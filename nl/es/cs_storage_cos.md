---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Almacenamiento de datos en IBM Cloud Object Storage
{: #object_storage}

## Creación de la instancia de servicio de almacenamiento de objetos
{: #create_cos_service}

Antes de poder empezar a utilizar {{site.data.keyword.cos_full_notm}} en el clúster, debe suministrar una instancia de servicio de {{site.data.keyword.cos_full_notm}} en la cuenta.
{: shortdesc}

1. Despliegue una instancia de servicio de {{site.data.keyword.cos_full_notm}}.
   1.  Abra la [página del catálogo de {{site.data.keyword.cos_full_notm}}](https://console.bluemix.net/catalog/services/cloud-object-storage).
   2.  Indique un nombre para la instancia de servicio, como por ejemplo `cos-backup`, y seleccione **predeterminado** como grupo de recursos.
   3.  Consulte las [opciones de plan ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) para conocer la información de tarifas y seleccione un plan.
   4.  Pulse **Crear**. Se abre la página de detalles de servicio.
2. {: #service_credentials}Recupere las credenciales de servicio de {{site.data.keyword.cos_full_notm}}.
   1.  En la navegación de la página de detalles de servicio, pulse **Credenciales de servicio**.
   2.  Pulse **Nueva credencial**. Aparece un recuadro de diálogo.
   3.  Especifique un nombre para las credenciales.
   4.  En el menú desplegable **Rol**, seleccione `Escritor` o `Gestor`. Si selecciona `Lector`, no puede utilizar las credenciales para crear grupos en {{site.data.keyword.cos_full_notm}} y escribir datos en ellos.
   5.  Opcional: en **Añadir parámetros de configuración en línea (opcional)**, especifique `{"HMAC":true}` para crear credenciales de HMAC adicionales para el servicio de {{site.data.keyword.cos_full_notm}}. La autenticación HMAC añade un nivel adicional de seguridad a la autenticación OAuth2 predeterminada, ya que evita el mal uso de las señales OAuth2 caducadas o creadas de forma aleatoria.
   6.  Pulse **Añadir**. Sus nuevas credenciales aparecerán en la tabla **Credenciales de servicio**.
   7.  Pulse **Ver credenciales**.
   8.  Tome nota del valor de **apikey** para utilizar las señales OAuth2 para autenticarse con el servicio de {{site.data.keyword.cos_full_notm}}. Para la autenticación HMAC, en la sección **cos_hmac_keys**, tenga en cuenta el valor de **access_key_id** y de **secret_access_key**.
3. [Almacene las credenciales de servicio en un secreto de Kubernetes dentro del clúster](#create_cos_secret) para habilitar el acceso a la instancia de servicio de {{site.data.keyword.cos_full_notm}}.

## Creación de un secreto para las credenciales de servicio de almacenamiento de objetos
{: #create_cos_secret}

Para acceder a la instancia de servicio de {{site.data.keyword.cos_full_notm}} para leer y escribir datos, debe almacenar de forma segura las credenciales de servicio en un secreto de Kubernetes. El plugin de {{site.data.keyword.cos_full_notm}} utiliza estas credenciales para cada operación de lectura o escritura en el grupo.
{: shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

1. Recupere los valores de **apikey** o de **access_key_id** y **secret_access_key** de las [credenciales de servicio de {{site.data.keyword.cos_full_notm}}](#service_credentials).

2. Obtenga el **GUID** de la instancia de servicio de {{site.data.keyword.cos_full_notm}}.
   ```
   ibmcloud resource service-instance <service_name>
   ```
   {: pre}

3. Codifique en base64 el **GUID** de {{site.data.keyword.cos_full_notm}} y los valores de **apikey** o de **access_key_id** y **secret_access_key** que ha recuperado anteriormente y anote todos los valores codificados en base64. Repita este mandato para todos los parámetros para recuperar el valor codificado en base 64.
   ```
   echo -n "<key_value>" | base64
   ```
   {: pre}

4. Cree un archivo de configuración para definir el secreto de Kubernetes.

   **Ejemplo de uso de la clave de API:**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     api-key: <base64_apikey>
     service-instance-id: <base64_guid>
   ```
   {: codeblock}

   **Ejemplo de uso de la autenticación HMAC:**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     access-key: <base64_access_key_id>
     secret-key: <base64_secret_access_key>
     service-instance-id: <base64_guid>
   ```
   {: codeblock}

   <table>
   <caption>Visión general de los componentes del archivo YAML</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>metadata/name</code></td>
   <td>Especifique un nombre para el secreto de {{site.data.keyword.cos_full_notm}}. </td>
   </tr>
   <tr>
   <td><code>metadata/namespace</code></td>
   <td>Especifique el espacio de nombres en el que desea crear el secreto. El secreto se debe crear en el mismo espacio de nombres en el que desea crear la PVC y el pod que accede a la instancia de servicio de {{site.data.keyword.cos_full_notm}}. </td>
   </tr>
   <tr>
   <td><code>data/api-key</code></td>
   <td>Especifique la clave de API que ha recuperado de las credenciales de servicio de {{site.data.keyword.cos_full_notm}} anteriormente. La clave de API debe estar codificada en base64. Si desea utilizar la autenticación HMAC, especifique en su lugar <code>data/access-key</code> y <code>data/secret-key</code>.  </td>
   </tr>
   <tr>
   <td><code>data/access-key</code></td>
   <td>Especifique el ID de clave de acceso que ha recuperado de las credenciales de servicio de {{site.data.keyword.cos_full_notm}} anteriormente. El ID de clave de acceso debe estar codificado en base64. Si desea utilizar la autenticación OAuth2, especifique <code>data/api-key</code> en su lugar.  </td>
   </tr>
   <tr>
   <td><code>data/secret-key</code></td>
   <td>Especifique la clave de acceso secreta que ha recuperado de las credenciales de servicio de {{site.data.keyword.cos_full_notm}} anteriormente. La clave de acceso secreta debe estar codificada en base64. Si desea utilizar la autenticación OAuth2, especifique <code>data/api-key</code> en su lugar.</td>
   </tr>
   <tr>
   <td><code>data/service-instance-id</code></td>
   <td>Especifique el GUID de la instancia de servicio de {{site.data.keyword.cos_full_notm}} que ha recuperado anteriormente. El GUID debe estar codificado en base64. </td>
   </tr>
   </tbody>
   </table>

5. Cree el secreto en el clúster.
   ```
   kubectl apply -f filepath/secret.yaml
   ```
   {: pre}

6. Verifique que el secreto se haya creado en el espacio de nombres.
   ```
   kubectl get secret
   ```
   {: pre}

7. [Instale el plugin de {{site.data.keyword.cos_full_notm}}](#install_cos) o, si ya ha instalado el plugin, [decida la configuración]( #configure_cos) del grupo de {{site.data.keyword.cos_full_notm}}.

## Instalación del plugin de IBM Cloud Object Storage
{: #install_cos}

Instale el plugin de {{site.data.keyword.cos_full_notm}} con un diagrama de Helm para configurar las clases de almacenamiento predefinidas para {{site.data.keyword.cos_full_notm}}. Utilice estas clases de almacenamiento para crear una PVC para suministrar {{site.data.keyword.cos_full_notm}} para sus apps.
{: shortdesc}

¿Está buscando instrucciones sobre cómo actualizar o eliminar el plugin de {{site.data.keyword.cos_full_notm}}? Consulte [Actualización del plugin](#update_cos_plugin) y [Eliminación del plugin](#remove_cos_plugin).
{: tip}

Antes de empezar, seleccione [como destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster en el que desea instalar el plugin de {{site.data.keyword.cos_full_notm}}.

1. Siga las [instrucciones](cs_integrations.html#helm) para instalar el cliente Helm en la máquina local, instale el servidor Helm (tiller) en el clúster y añada el repositorio de diagramas Helm de {{site.data.keyword.Bluemix_notm}} al clúster en el que desea utilizar el plugin de {{site.data.keyword.cos_full_notm}}.

    **Importante:** Si utiliza Helm versión 2.9 o superior, asegúrese de que ha instalado tiller con una [cuenta de servicio](cs_integrations.html#helm).
2. Añada el repositorio de {{site.data.keyword.Bluemix_notm}} Helm al clúster.
   ```
   helm repo add ibm https://registry.bluemix.net/helm/ibm
   ```
   {: pre}

3. Actualice el repositorio de Helm para recuperar la última versión de todos los diagramas de Helm de este repositorio.
   ```
   helm repo update
   ```
   {: pre}

4. Instale el plugin de {{site.data.keyword.cos_full_notm}} Helm `ibmc`. El plugin se utiliza para recuperar automáticamente la ubicación del cluster y definir el punto final de API para los grupos de {{site.data.keyword.cos_full_notm}} de las clases de almacenamiento.
   1. Descargue el diagrama de Helm y desempaquete el diagrama en el directorio actual.    
      ```
      helm fetch --untar ibm/ibmcloud-object-storage-plugin
      ```
      {: pre}
   2. Instale el plugin de Helm.
      ```
      helm plugin install ibmcloud-object-storage-plugin/helm-ibmc
      ```
      {: pre}

      Salida de ejemplo:
      ```
      Installed plugin: ibmc
      ```
      {: screen}

5. Verifique que el plugin `ibmc` esté instalado correctamente.
   ```
   helm ibmc --help
   ```
   {: pre}

   Salida de ejemplo:
   ```
   Install or upgrade Helm charts in IBM K8S Service

   Available Commands:
    helm ibmc install [CHART] [flags]              Install a Helm chart
    helm ibmc upgrade [RELEASE] [CHART] [flags]    Upgrades the release to a new version of the Helm chart

   Available Flags:
    --verbos                      (Optional) Verbosity intensifies... ...
    -f, --values valueFiles       (Optional) specify values in a YAML file (can specify multiple) (default [])
    -h, --help                    (Optional) This text.
    -u, --update                  (Optional) Update this plugin to the latest version

   Example Usage:
    helm ibmc install ibm/ibmcloud-object-storage-plugin -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: screen}

6. Opcional: limite el plugin de {{site.data.keyword.cos_full_notm}} para acceder únicamente a los secretos de Kubernetes que contienen las credenciales de servicio de {{site.data.keyword.cos_full_notm}}. De forma predeterminada, el plugin está autorizado para acceder a todos los secretos de Kubernetes del clúster.
   1. [Cree la instancia de servicio de {{site.data.keyword.cos_full_notm}}](#create_cos_service).
   2. [Almacene las credenciales de servicio de {{site.data.keyword.cos_full_notm}} en un secreto de Kubernetes](#create_cos_secret).
   3. Vaya al directorio `templates` y obtenga una lista de los archivos disponibles.  
      ```
      cd ibmcloud-object-storage-plugin/templates && ls
      ```
      {: pre}

   4. Abra el archivo `provisioner-sa.yaml` y busque la definición de ClusterRole de `ibmcloud-object-storage-secret-reader`.
   6. Añada el nombre del secreto que ha creado anteriormente a la lista de secretos a los que el plugin está autorizado para acceder en la sección `resourceNames`.
      ```
      kind: ClusterRole
      apiVersion: rbac.authorization.k8s.io/v1beta1
      metadata:
        name: ibmcloud-object-storage-secret-reader
      rules:
      - apiGroups: [""]
        resources: ["secrets"]
        resourceNames: ["<secret_name1>","<secret_name2>"]
        verbs: ["get"]
      ```
      {: codeblock}
   7. Guarde los cambios.

8. Instale el plug-in de {{site.data.keyword.cos_full_notm}}. Cuando instala el plugin, se añaden a su clúster las clases de almacenamiento de almacenamiento predefinidas.

   **Instalar sin limitación a secretos de Kubernetes específicos:**
   ```
   helm ibmc install ibm/ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

   **Instalar con una limitación a secretos de Kubernetes específicos, tal como se describe en el paso anterior:**
   ```
   helm ibmc install ./ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

   Salida de ejemplo:
   ```
   Installing the Helm chart
   DC: dal10  Chart: ibm/ibmcloud-object-storage-plugin
   NAME:   mewing-duck
   LAST DEPLOYED: Mon Jul 30 13:12:59 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1/Pod(related)
   NAME                                             READY  STATUS             RESTARTS  AGE
   ibmcloud-object-storage-driver-hzqp9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-jtdb9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-tl42l             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-plugin-7d87fbcbcc-wgsn8  0/1    ContainerCreating  0         1s

   ==> v1beta1/StorageClass
   NAME                                  PROVISIONER       AGE
   ibmc-s3fs-cold-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-cold-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-cross-region      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-regional          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-cross-region       ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-cross-region  ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-regional      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-regional           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-cross-region          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-regional              ibm.io/ibmc-s3fs  1s

   ==> v1/ServiceAccount
   NAME                            SECRETS  AGE
   ibmcloud-object-storage-driver  1        1s
   ibmcloud-object-storage-plugin  1        1s

   ==> v1beta1/ClusterRole
   NAME                                   AGE
   ibmcloud-object-storage-secret-reader  1s
   ibmcloud-object-storage-plugin         1s

   ==> v1beta1/ClusterRoleBinding
   NAME                                   AGE
   ibmcloud-object-storage-plugin         1s
   ibmcloud-object-storage-secret-reader  1s

   ==> v1beta1/DaemonSet
   NAME                            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-object-storage-driver  3        3        0      3           0          <none>         1s

   ==> v1beta1/Deployment
   NAME                            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-object-storage-plugin  1        1        1           0          1s

   NOTES:
   Thank you for installing: ibmcloud-object-storage-plugin.   Your release is named: mewing-duck

   Please refer Chart README.md file for creating a sample PVC.
   Please refer Chart RELEASE.md to see the release details/fixes.
   ```
   {: screen}

9. Verifique que el plugin está instalado correctamente.
   ```
   kubectl get pod -n kube-system -o wide | grep object
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ibmcloud-object-storage-driver-9n8g8                              1/1       Running   0          2m
   ibmcloud-object-storage-plugin-7c774d484b-pcnnx                   1/1       Running   0          2m
   ```
   {: screen}

   La instalación es satisfactoria si ve un pod `ibmcloud-object-storage-plugin` y uno o varios pods `ibmcloud-object-storage-driver`. El número de pods `ibmcloud-object-storage-driver` corresponde al número de nodos trabajadores de su clúster. Todos los pods deben estar en un estado `En ejecución` para que el plugin funcione correctamente. Si fallan los pods, ejecute `kubectl describe pod -n kube-system <pod_name>` para encontrar la causa raíz de la anomalía.

10. Verifique que las clases de almacenamiento se han creado correctamente.
   ```
   kubectl get storageclass | grep s3
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

11. Repita los pasos para todos los clústeres en los que desea acceder a los grupos de {{site.data.keyword.cos_full_notm}}.

### Actualización del plugin de IBM Cloud Object Storage
{: #update_cos_plugin}

Puede actualizar el plugin de {{site.data.keyword.cos_full_notm}} existente a la última versión.
{: shortdesc}

1. Actualice el repositorio de Helm para recuperar la última versión de todos los diagramas de Helm de este repositorio.
   ```
   helm repo update
   ```
   {: pre}

2. Descargue el diagrama de Helm más reciente a la máquina local y, a continuación, descomprima el paquete para revisar el archivo `release.md` para ver la información de release más reciente.
   ```
   helm fetch --untar ibm/ibmcloud-object-storage-plugin
   ```

3. Busque el nombre de la instalación de su diagrama de helm.
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}

   Salida de ejemplo:
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}

4. Actualice el plugin de {{site.data.keyword.cos_full_notm}} a la última versión.
   ```   
   helm ibmc upgrade <helm_chart_name> ibm/ibmcloud-object-storage-plugin --force --recreate-pods -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

5. Verifique que `ibmcloud-object-storage-plugin` se haya actualizado correctamente.  
   ```
   kubectl rollout status deployment/ibmcloud-object-storage-plugin -n kube-system
   ```
   {: pre}

   La actualización del plugin se realiza correctamente cuando se ve `deployment "ibmcloud-object-storage-plugin" successfully rolled out` en la salida de la CLI.

6. Verifique que `ibmcloud-object-storage-driver` se haya actualizado correctamente.
   ```
   kubectl rollout status ds/ibmcloud-object-storage-driver -n kube-system
   ```
   {: pre}

   La actualización se realiza correctamente cuando se ve `daemon set "ibmcloud-object-storage-driver" successfully rolled out` en la salida de la CLI.

7. Verifique que los pods de {{site.data.keyword.cos_full_notm}} se encuentran en un estado `En ejecución`.
   ```
   kubectl get pods -n kube-system -o wide | grep object-storage
   ```
   {: pre}


### Eliminación del plugin de IBM Cloud Object Storage
{: #remove_cos_plugin}

Si no desea suministrar y utilizar {{site.data.keyword.cos_full_notm}} en el clúster, puede desinstalar los diagramas de helm.

**Nota:** Al eliminar el plugin no elimina los datos, las PVC o los PV. Cuando se elimina el plugin, se eliminan del clúster todos los conjuntos de daemons y pods relacionados. No puede suministrar un nuevo {{site.data.keyword.cos_full_notm}} para el clúster ni utilizar las PVC y los PV existentes después de eliminar el plugin, a menos que configure la app para que utilice la API de {{site.data.keyword.cos_full_notm}} directamente.

Antes de empezar:

- [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).
- Asegúrese de que no haya PVC ni PV en el clúster que utiliza {{site.data.keyword.cos_full_notm}}. Para obtener una lista de todos los pods que montan una PVC específica, ejecute `kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"`.

Para eliminar el plugin:

1. Busque el nombre de la instalación de su diagrama de helm.
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}

   Salida de ejemplo:
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}

2. Suprima el plugin de {{site.data.keyword.cos_full_notm}} eliminando el diagrama de Helm.
   ```
   helm delete --purge <helm_chart_name>
   ```
   {: pre}

3. Verifique que los pods de {{site.data.keyword.cos_full_notm}} se han eliminado.
   ```
   kubectl get pod -n kube-system | grep object-storage
   ```
   {: pre}

   La eliminación de los pods es satisfactoria si dejan de aparecer en la salida de la CLI.

4. Verifique que las clases de almacenamiento se han eliminado.
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}

   La eliminación de las clases de almacenamiento es satisfactoria si dejan de aparecer en la salida de la CLI.

5. Elimine el plugin `ibmc` de Helm.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

6. Verifique que se ha eliminado el plugin `ibmc`.
   ```
   helm plugin list
   ```
   {: pre}

   Salida de ejemplo:
   ```
   NAME	VERSION	DESCRIPTION
   ```
   {: screen}

   El plugin `ibmc` se elimina correctamente si el plugin `ibmc` no aparece en la lista de la salida de la CLI.


## Cómo decidir la configuración del almacenamiento de objetos
{: #configure_cos}

{{site.data.keyword.containerlong_notm}} proporciona clases de almacenamiento predefinidas que puede utilizar para crear grupos con una configuración específica.

1. Obtenga una lista de las clases de almacenamiento disponibles en {{site.data.keyword.containerlong_notm}}.
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

2. Elija una clase de almacenamiento que se ajuste a sus requisitos de acceso a datos. La clase de almacenamiento determina las [tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) de la capacidad de almacenamiento, las operaciones de lectura y escritura y el ancho de banda de un grupo. La opción adecuada para usted depende de la frecuencia con la que se lean y se graben datos en la instancia de servicio.
   - **Estándar**: esta opción se utiliza para datos calientes a los que se accede con frecuencia. Las apps web o móviles son ejemplos habituales de este caso.
   - **Caja fuerte**: esta opción se utiliza para cargas de trabajo o datos fríos a los que se accede con poca frecuencia, como una vez al mes o menos. El archivado, la retención de datos a corto plazo, la conservación de activos digitales, la sustitución de cinta y la recuperación tras desastre son ejemplos habituales de este caso.
   - **Frío**: esta opción se utiliza para datos fríos a los que se accede con muy poca frecuencia (cada 90 días o menos), o datos inactivos. Los archivados, las copias de seguridad a largo plazo, los datos históricos que se conservan por motivos de conformidad o las cargas de trabajo y apps a las que se accede con muy poca frecuencia son ejemplos habituales de este caso.
   - **Flexible**: esta opción se utiliza para las cargas de trabajo y los datos que no siguen un patrón de uso específico o que son demasiado grandes para determinar o prever un patrón de uso. **Sugerencia:** consulte este [blog ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/03/interconnect-2017-changing-rules-storage/) para saber cómo funciona la clase de almacenamiento flexible en comparación con los niveles de almacenamiento tradicionales.   

3. Decida el nivel de resiliencia de los datos que se almacenan en el grupo.
   - **Entre regiones**: con esta opción, los datos se almacenan en tres regiones dentro de una geolocalización para obtener la mayor disponibilidad. Si tiene cargas de trabajo que se distribuyen entre regiones, las solicitudes se direccionan al punto final regional más próximo. El punto final de API de la geolocalización lo establece automáticamente el plugin de Helm `ibmc` que ha instalado anteriormente en función de la ubicación en la que se encuentra el clúster. Por ejemplo, si el clúster está en `EE.UU. sur`, las clases de almacenamiento se configuran para utilizar el punto final de API `GEO EE.UU.` para los grupos. Consulte [Regiones y puntos finales](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) para obtener más información.  
   - **Regional**: con esta opción, los datos se replican en varias zonas dentro de una región. Si tiene cargas de trabajo que se encuentran en la misma región, observará una menor latencia y un mejor rendimiento que en una configuración entre regiones. El punto final regional lo establece automáticamente el plugin de Helm `ibm` que ha instalado anteriormente en función de la ubicación en la que se encuentra el clúster. Por ejemplo, si el clúster está en `EE.UU. sur`, las clases de almacenamiento se configuran para utilizar `EE.UU. sur` como punto final regional para los grupos. Consulte [Regiones y puntos finales](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) para obtener más información.

4. Revise la configuración de grupo de {{site.data.keyword.cos_full_notm}} detallada de una clase de almacenamiento.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Salida de ejemplo:
   ```
   Name:                  ibmc-s3fs-standard-cross-region
   IsDefaultClass:        No
   Annotations:           <none>
   Provisioner:           ibm.io/ibmc-s3fs
   Parameters:            ibm.io/chunk-size-mb=16,ibm.io/curl-debug=false,ibm.io/debug-level=warn,ibm.io/iam-endpoint=https://iam.bluemix.net,ibm.io/kernel-cache=true,ibm.io/multireq-max=20,ibm.io/object-store-endpoint=https://s3-api.dal-us-geo.objectstorage.service.networklayer.com,ibm.io/object-store-storage-class=us-standard,ibm.io/parallel-count=2,ibm.io/s3fs-fuse-retry-count=5,ibm.io/stat-cache-size=100000,ibm.io/tls-cipher-suite=AESGCM
   AllowVolumeExpansion:  <unset>
   MountOptions:          <none>
   ReclaimPolicy:         Delete
   VolumeBindingMode:     Immediate
   Events:                <none>
   ```
   {: screen}

   <table>
   <caption>Detalles de la clase de almacenamiento</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>ibm.io/chunk-size-mb</code></td>
   <td>El tamaño de un fragmento de datos que se lee o en el que se graba en {{site.data.keyword.cos_full_notm}} en megabytes. Las clases de almacenamiento con <code>perf</code> en el nombre se configuran con 52 megabytes. Las clases de almacenamiento sin <code>perf</code> en el nombre utilizan fragmentos de 16 megabytes. Por ejemplo, si desea leer un archivo que es de 1 GB, el plugin lee este archivo en varios fragmentos de 16 o 52 megabytes. </td>
   </tr>
   <tr>
   <td><code>ibm.io/curl-debug</code></td>
   <td>Habilita el registro de solicitudes que se envían a la instancia de servicio de {{site.data.keyword.cos_full_notm}}. Si está habilitado, los registros se envían a `syslog` y puede [reenviar los registros a un servidor de registro externo](cs_health.html#logging). De forma predeterminada, todas las clases de almacenamiento se establecen en <strong>false</strong> para inhabilitar esta característica de registro. </td>
   </tr>
   <tr>
   <td><code>ibm.io/debug-level</code></td>
   <td>El nivel de registro establecido por el plugin de {{site.data.keyword.cos_full_notm}}. Todas las clases de almacenamiento se configuran con el nivel de registro <strong>WARN</strong>. </td>
   </tr>
   <tr>
   <td><code>ibm.io/iam-endpoint</code></td>
   <td>Punto final de API para Identity and Access Management (IAM). </td>
   </tr>
   <tr>
   <td><code>ibm.io/kernel-cache</code></td>
   <td>Habilita o inhabilita la memoria caché del almacenamiento intermedio del kernel para el punto de montaje del volumen. Si está habilitado, los datos que se leen de {{site.data.keyword.cos_full_notm}} se almacenan en la memoria caché del kernel para garantizar el acceso de lectura rápido a los datos. Si está inhabilitado, los datos no se almacenan en la memoria caché y siempre se leen desde {{site.data.keyword.cos_full_notm}}. La memoria caché de kernel está habilitada para las clases de almacenamiento <code>estándar</code> y <code>flexible</code>, e inhabilitada para las clases de almacenamiento <code>frío</code> y <code>caja fuerte</code>. </td>
   </tr>
   <tr>
   <td><code>ibm.io/multireq-max</code></td>
   <td>El número máximo de solicitudes paralelas que se pueden enviar a la instancia de servicio de {{site.data.keyword.cos_full_notm}} para obtener una lista de los archivos en un único directorio. Todas las clases de almacenamiento se configuran con un máximo de 20 solicitudes paralelas. </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-endpoint</code></td>
   <td>El punto final de la API que se debe utilizar para acceder al grupo en la instancia de servicio de {{site.data.keyword.cos_full_notm}}. El punto final se establece automáticamente en función de la región del clúster. </br></br><strong>Nota: </strong> si desea acceder a un grupo existente que se encuentra en una región distinta a la del clúster, debe crear una [clase de almacenamiento personalizada](cs_storage_basics.html#customized_storageclass) y utilizar el punto final de la API para el grupo. </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-storage-class</code></td>
   <td>El nombre de la clase de almacenamiento. </td>
   </tr>
   <tr>
   <td><code>ibm.io/parallel-count</code></td>
   <td>El número máximo de solicitudes paralelas que se pueden enviar a la instancia de servicio de {{site.data.keyword.cos_full_notm}} para una sola operación de lectura o escritura. Las clases de almacenamiento con <code>perf</code> en el nombre se configuran con un máximo de 20 solicitudes paralelas. Las clases de almacenamiento sin <code>perf</code> se configuran con 2 solicitudes paralelas de forma predeterminada. </td>
   </tr>
   <tr>
   <td><code>ibm.io/s3fs-fuse-retry-count</code></td>
   <td>El número máximo de reintentos para una operación de lectura o escritura antes de que se considere que la operación no es satisfactoria. Todas las clases de almacenamiento se configuran con un máximo de 5 reintentos.  </td>
   </tr>
   <tr>
   <td><code>ibm.io/stat-cache-size</code></td>
   <td>El número máximo de registros que se conservan en la memoria caché de metadatos de {{site.data.keyword.cos_full_notm}}. Cada registro puede ocupar un máximo de 0,5 kilobytes. Todas las clases de almacenamiento establecen el número máximo de registros en 100000 de forma predeterminada. </td>
   </tr>
   <tr>
   <td><code>ibm.io/tls-cipher-suite</code></td>
   <td>La suite de cifrado TLS que se debe utilizar cuando se establece una conexión a {{site.data.keyword.cos_full_notm}} mediante el punto final de HTTPS. El valor de la suite de cifrado debe seguir el [formato OpenSSL ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html). Todas las clases de almacenamiento utilizan la suite de cifrado <strong>AESGCM</strong> de forma predeterminada. </td>
   </tr>
   </tbody>
   </table>

   Para obtener más información sobre cada clase de almacenamiento, consulte la [referencia de clases de almacenamiento](#storageclass_reference). Si desea cambiar alguno de los valores preestablecidos, cree su propia [clase de almacenamiento personalizada](cs_storage_basics.html#customized_storageclass).
   {: tip}

5. Decida un nombre para el grupo. El nombre del grupo debe ser exclusivo en {{site.data.keyword.cos_full_notm}}. También puede optar por crear automáticamente un nombre para el grupo mediante el plugin de {{site.data.keyword.cos_full_notm}}. Para organizar los datos en un grupo, puede crear subdirectorios.

   **Nota:** la clase de almacenamiento que ha seleccionado anteriormente determina las tarifas de todo el grupo. No se pueden definir distintas clases de almacenamiento para los subdirectorios. Si desea almacenar datos con diferentes requisitos de acceso, considere la posibilidad de crear varios grupos mediante varias PVC.

6. Decida si desea conservar los datos y el grupo después de que se suprima el clúster o la reclamación de volumen persistente (PVC). Cuando se suprime la PVC, siempre se suprime el PV. Puede elegir si desea también suprimir automáticamente los datos y el grupo cuando suprime la PVC. La instancia de servicio de {{site.data.keyword.cos_full_notm}} es independiente de la política de retención que selecciona para los datos y nunca se elimina cuando suprime una PVC.

Ahora que ha decidido la configuración que desea, está preparado para [crear una PVC](#add_cos) para suministrar {{site.data.keyword.cos_full_notm}}.

## Adición de almacenamiento de objetos a apps
{: #add_cos}

Cree una reclamación de volumen persistente (PVC) para suministrar {{site.data.keyword.cos_full_notm}} al clúster.
{: shortdesc}

En función de los valores que elija en la PVC, puede suministrar {{site.data.keyword.cos_full_notm}} de las formas siguientes:
- [Suministro dinámico](cs_storage_basics.html#dynamic_provisioning): al crear la PVC, se crean automáticamente el grupo y el volumen persistente (PV) correspondiente en la instancia de servicio de {{site.data.keyword.cos_full_notm}}.
- [Suministro estático](cs_storage_basics.html#static_provisioning): puede hacer referencia a un grupo existente en la instancia de servicio de {{site.data.keyword.cos_full_notm}} en la PVC. Cuando se crea la PVC, sólo se crea automáticamente el PV correspondiente y se vincula con el grupo existente en {{site.data.keyword.cos_full_notm}}.

Antes de empezar:
- [Cree y prepare la instancia de servicio de {{site.data.keyword.cos_full_notm}}](#create_cos_service).
- [Cree un secreto para almacenar las credenciales de servicio de {{site.data.keyword.cos_full_notm}}](#create_cos_secret).
- [Decida la configuración de {{site.data.keyword.cos_full_notm}}](#configure_cos).

Para añadir {{site.data.keyword.cos_full_notm}} al clúster:

1. Cree un archivo de configuración para definir la reclamación de volumen persistente (PVC).
   ```
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: <pvc_name>
     namespace: <namespace>
     annotations:
       volume.beta.kubernetes.io/storage-class: "<storage_class>"
       ibm.io/auto-create-bucket: "<true_or_false>"
       ibm.io/auto-delete-bucket: "<true_or_false>"
       ibm.io/bucket: "<bucket_name>"
       ibm.io/object-path: "<bucket_subdirectory>"
       ibm.io/secret-name: "<secret_name>"
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 8Gi # Enter a fictitious value
   ```
   {: codeblock}

   <table>
   <caption>Visión general de los componentes del archivo YAML</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>metadata/name</code></td>
   <td>Escriba el nombre de la PVC.</td>
   </tr>
   <tr>
   <td><code>metadata/namespace</code></td>
   <td>Especifique el espacio de nombres en el que desea crear la PVC. La PVC se debe crear en el mismo espacio de nombres en el que ha creado el secreto de Kubernetes para las credenciales de servicio de {{site.data.keyword.cos_full_notm}} y en el que desea ejecutar el pod. </td>
   </tr>
   <tr>
   <td><code>volume.beta.kubernetes.io/storage-class</code></td>
   <td>Seleccione una de las opciones siguientes: <ul><li>Si <code>ibm.io/auto-create-bucket</code> se establece en <strong>true</strong>: especifique la clase de almacenamiento que desea utilizar para el nuevo grupo. </li><li>Si <code>ibm.io/auto-create-bucket</code> se establece en <strong>false</strong>: especifique la clase de almacenamiento que ha utilizado para crear el grupo existente. </br></br>Si ha creado manualmente el grupo en la instancia de servicio de {{site.data.keyword.cos_full_notm}} o no recuerda la clase de almacenamiento que ha utilizado, busque la instancia de servicio en el panel de control de {{site.data.keyword.Bluemix}} y compruebe la <strong>Clase</strong> y la <strong>Ubicación</strong> del grupo existente. A continuación, utilice la [clase de almacenamiento](#storageclass_reference) adecuada. </br></br><strong>Nota:</strong> el punto final de la API de {{site.data.keyword.cos_full_notm}} que se establece en la clase de almacenamiento se basa en la región en la que se encuentra el clúster. Si desea acceder a un grupo que se encuentra en una región distinta a la del clúster, debe crear una [clase de almacenamiento personalizada](cs_storage_basics.html#customized_storageclass) y utilizar el punto final apropiado de la API para el grupo. </li></ul>  </td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-create-bucket</code></td>
   <td>Seleccione una de las opciones siguientes: <ul><li><strong>true</strong>: al crear la PVC, se crean automáticamente el grupo y el PV en la instancia de servicio de {{site.data.keyword.cos_full_notm}}. Elija esta opción para crear un nuevo grupo en la instancia de servicio de {{site.data.keyword.cos_full_notm}}. </li><li><strong>false</strong>: elija esta opción si desea acceder a los datos de un grupo existente. Cuando se crea la PVC, el PV se crea automáticamente y se enlaza con el grupo que haya especificado en <code>ibm.io/bucket</code>.</td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-delete-bucket</code></td>
   <td>Seleccione una de las opciones siguientes: <ul><li><strong>true</strong>: los datos, el grupo y el PV se eliminan automáticamente cuando se suprime la PVC. La instancia de servicio de {{site.data.keyword.cos_full_notm}} se conserva y no se suprime. Si elige establecer esta opción en <strong>true</strong>, debe establecer <code>ibm.io/auto-create-bucket: true</code> e <code>ibm.io/bucket: ""</code> para que el grupo se cree automáticamente con un nombre con el formato <code>tmp-s3fs-xxxx</code>. </li><li><strong>false</strong>: al suprimir la PVC, el PV se suprime automáticamente, pero se conservan los datos del grupo de la instancia de servicio de {{site.data.keyword.cos_full_notm}}. Para acceder a los datos, debe crear una nueva PVC con el nombre del grupo existente. </li></ul>
   <tr>
   <td><code>ibm.io/bucket</code></td>
   <td>Seleccione una de las opciones siguientes: <ul><li>Si se establece <code>ibm.io/auto-create-bucket</code> en <strong>true</strong>: escriba el nombre del grupo que desea crear en {{site.data.keyword.cos_full_notm}}. Si, además, <code>ibm.io/auto-delete-bucket</code> se establece en <strong>true</strong>, debe dejar este campo en blanco para asignar automáticamente al grupo un nombre con el formato <code>tmp-s3fs-xxxx</code>. El nombre debe ser exclusivo en {{site.data.keyword.cos_full_notm}}. </li><li>Si <code>ibm.io/auto-create-bucket</code> se establece en <strong> false </strong>: especifique el nombre del grupo existente al que desea acceder en el clúster. </li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-path</code></td>
   <td>Opcional: especifique el nombre del subdirectorio existente del grupo que desea montar. Utilice esta opción si desea montar únicamente un subdirectorio y no todo el grupo. Para montar un subdirectorio, debe establecer <code>ibm.io/auto-create-bucket: "false"</code> e indicar el nombre del grupo en <code>ibm.io/bucket</code>. </li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/secret-name</code></td>
   <td>Especifique el nombre del secreto que contiene las credenciales de {{site.data.keyword.cos_full_notm}} que ha creado anteriormente. </td>
   </tr>
   <tr>
   <td><code>resources/requests/storage</code></td>
   <td>Un tamaño ficticio para el grupo de {{site.data.keyword.cos_full_notm}} en gigabytes. El tamaño es necesario para Kubernetes, pero no se respeta en {{site.data.keyword.cos_full_notm}}. Puede especificar cualquier tamaño que desee. El espacio real que utilice en {{site.data.keyword.cos_full_notm}} puede ser diferente y se factura en función de la [tabla de tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api). </td>
   </tr>
   </tbody>
   </table>

2. Cree la PVC.
   ```
   kubectl apply -f filepath/pvc.yaml
   ```
   {: pre}

3. Verifique que la PVC se ha creado y se ha vinculado al PV.
   ```
   kubectl get pvc
   ```
   {: pre}

   Salida de ejemplo:
   ```
   NAME                  STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                     AGE
   s3fs-test-pvc         Bound     pvc-b38b30f9-1234-11e8-ad2b-t910456jbe12   8Gi        RWO            ibmc-s3fs-standard-cross-region  1h
   ```
   {: screen}

4. Opcional: si tiene previsto acceder a los datos con un usuario no root, o añadir archivos a un grupo de {{site.data.keyword.cos_full_notm}} existente mediante la interfaz gráfica de usuario o la API directamente, asegúrese de que los [archivos tengan el permiso correcto](cs_troubleshoot_storage.html#cos_nonroot_access) asignado para que la app pueda leer y actualizar correctamente los archivos según sea necesario.

4.  {: #app_volume_mount}Para montar el PV en el despliegue, cree un archivo `.yaml` de configuración y especifique la PVC que enlaza el PV.

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            securityContext:
              runAsUser: <non_root_user>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>Una etiqueta para el despliegue.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>Una etiqueta para la app.</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Una etiqueta para el despliegue.</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>El nombre del imagen que desea utilizar. Para ver una lista de todas las imágenes disponibles en su cuenta de {{site.data.keyword.registryshort_notm}}, ejecute `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>El nombre del contenedor que desea desplegar en el clúster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/securityContext/runAsUser</code></td>
    <td>Opcional: para ejecutar la app con un usuario no root, especifique el [contexto de seguridad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) del pod definiendo el usuario no root sin establecer `fsGroup` en el YAML de despliegue al mismo tiempo. Al establecer `fsGroup`, se provoca que el plugin de {{site.data.keyword.cos_full_notm}} actualice los permisos de grupo para todos los archivos de un grupo cuando se despliega el pod. La actualización de los permisos es una operación de escritura y afecta al rendimiento. En función de la cantidad de archivos que tenga, la actualización de los permisos puede impedir que el pod se proporcione y pase al estado <code>En ejecución</code>. </td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>La vía de acceso absoluta del directorio en el que el que está montado el volumen dentro del contenedor.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>El nombre del volumen que va a montar en el pod.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>El nombre del volumen que va a montar en el pod. Normalmente, este nombre es el mismo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>El nombre de la PVC que enlaza el PV que desea utilizar. </td>
    </tr>
    </tbody></table>

5.  Cree el despliegue.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  Verifique que el PV se ha montado correctamente.

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

7. Verifique que puede grabar datos en la instancia de servicio de {{site.data.keyword.cos_full_notm}}.
   1. Inicie la sesión en el pod que monta el PV.
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. Vaya a la vía de acceso de montaje de volumen que ha definido en el despliegue de la app.
   3. Cree un archivo de texto.
      ```
      echo "This is a test" > test.txt
      ```
      {: pre}

   4. En el panel de control de {{site.data.keyword.Bluemix}}, vaya a la instancia de servicio de {{site.data.keyword.cos_full_notm}}.
   5. En el menú, seleccione **Grupos**.
   6. Abra el grupo y verifique que puede ver el archivo `test.txt` que ha creado.


## Copia de seguridad y restauración de datos
{: #backup_restore}

{{site.data.keyword.cos_full_notm}} se configura para proporcionar una alta durabilidad para los datos y evitar que se pierdan. El SLA está disponible en los [términos de servicio de {{site.data.keyword.cos_full_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-7857-03).
{: shortdesc}

**Importante:** {{site.data.keyword.cos_full_notm}} no proporciona un historial de versiones para los datos. Si necesita conservar y acceder a las versiones anteriores de los datos, debe configurar la app para gestionar el historial de los datos o implementar soluciones alternativas de copia de seguridad. Por ejemplo, puede que desee almacenar los datos de {{site.data.keyword.cos_full_notm}} en la base de datos local o utilizar cintas para archivar los datos.

## Referencia de clases de almacenamiento
{: #storageclass_reference}

### Estándar
{: #standard}

<table>
<caption>Clase de almacenamiento de objetos: estándar</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-s3fs-standard-cross-region</code></br><code>ibmc-s3fs-standard-perf-cross-region</code></br><code>ibmc-s3fs-standard-regional</code></br><code>ibmc-s3fs-standard-perf-regional</code></td>
</tr>
<tr>
<td>Punto final de resiliencia predeterminado</td>
<td>El punto final de resiliencia se establece automáticamente en función de la ubicación en la que se encuentra el clúster. Consulte [Regiones y puntos finales](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) para obtener más información. </td>
</tr>
<tr>
<td>Tamaño de fragmento</td>
<td>Clases de almacenamiento sin `perf`: 16 MB</br>Clases de almacenamiento con `perf`: 52 MB</td>
</tr>
<tr>
<td>Caché de Kernel</td>
<td>Habilitada</td>
</tr>
<tr>
<td>Facturación</td>
<td>Mensual</td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Caja fuerte
{: #Vault}

<table>
<caption>Clase de almacenamiento de objetos: caja fuerte</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-s3fs-vault-cross-region</code></br><code>ibmc-s3fs-vault-regional</code></td>
</tr>
<tr>
<td>Punto final de resiliencia predeterminado</td>
<td>El punto final de resiliencia se establece automáticamente en función de la ubicación en la que se encuentra el clúster. Consulte [Regiones y puntos finales](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) para obtener más información. </td>
</tr>
<tr>
<td>Tamaño de fragmento</td>
<td>16 MB</td>
</tr>
<tr>
<td>Caché de Kernel</td>
<td>Inhabilitada</td>
</tr>
<tr>
<td>Facturación</td>
<td>Mensual</td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Frío
{: #cold}

<table>
<caption>Clase de almacenamiento de objetos: frío</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-s3fs-flex-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-flex-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>Punto final de resiliencia predeterminado</td>
<td>El punto final de resiliencia se establece automáticamente en función de la ubicación en la que se encuentra el clúster. Consulte [Regiones y puntos finales](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) para obtener más información. </td>
</tr>
<tr>
<td>Tamaño de fragmento</td>
<td>16 MB</td>
</tr>
<tr>
<td>Caché de Kernel</td>
<td>Inhabilitada</td>
</tr>
<tr>
<td>Facturación</td>
<td>Mensual</td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Flexible
{: #flex}

<table>
<caption>Clase de almacenamiento de objetos: flexible</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-s3fs-cold-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-cold-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>Punto final de resiliencia predeterminado</td>
<td>El punto final de resiliencia se establece automáticamente en función de la ubicación en la que se encuentra el clúster. Consulte [Regiones y puntos finales](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints) para obtener más información. </td>
</tr>
<tr>
<td>Tamaño de fragmento</td>
<td>Clases de almacenamiento sin `perf`: 16 MB</br>Clases de almacenamiento con `perf`: 52 MB</td>
</tr>
<tr>
<td>Caché de Kernel</td>
<td>Habilitada</td>
</tr>
<tr>
<td>Facturación</td>
<td>Mensual</td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>
