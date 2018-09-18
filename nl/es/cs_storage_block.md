---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# Almacenamiento de datos en IBM Block Storage for IBM Cloud
{: #block_storage}


## Instalación del plugin {{site.data.keyword.Bluemix_notm}} Block Storage en el clúster
{: #install_block}

Instale el plugin {{site.data.keyword.Bluemix_notm}} Block Storage con un diagrama de Helm para configurar las clases de almacenamiento predefinidas para el almacenamiento en bloque. Utilice estas clases de almacenamiento para crear una PVC para suministrar almacenamiento en bloque para sus apps.
{: shortdesc}

Antes de empezar, seleccione [como destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster en el que desea instalar el plugin {{site.data.keyword.Bluemix_notm}} Block Storage.


1. Siga las [instrucciones](cs_integrations.html#helm) para instalar el cliente Helm en la máquina local, instale el servidor Helm (tiller) en el clúster y añada el repositorio de diagramas Helm de {{site.data.keyword.Bluemix_notm}} al clúster en el que desea utilizar el plugin {{site.data.keyword.Bluemix_notm}} Block Storage.
2. Actualice el repositorio de Helm para recuperar la última versión de todos los diagramas de Helm de este repositorio.
   ```
   helm repo update
   ```
   {: pre}

3. Instale el plugin {{site.data.keyword.Bluemix_notm}} Block Storage. Cuando instala el plugin, se añaden a su clúster las clases de almacenamiento de almacenamiento en bloque predefinidas.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Salida de ejemplo:
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. Verifique que la instalación ha sido satisfactoria.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   La instalación es satisfactoria si ve un pod `ibmcloud-block-storage-plugin` y uno o varios pods `ibmcloud-block-storage-driver`. El número de pods `ibmcloud-block-storage-driver` corresponde al número de nodos trabajadores de su clúster. Todos los pods deben estar en un estado **Running**.

5. Verifique que las clases de almacenamiento para el almacenamiento en bloque se añaden a su clúster.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. Repita estos pasos para cada clúster donde desea suministrar almacenamiento en bloques.

Ahora puede seguir para [crear una PVC](#add_block) para suministrar almacenamiento en bloque a la app.


### Actualización del plugin {{site.data.keyword.Bluemix_notm}} Block Storage
Actualice el plugin {{site.data.keyword.Bluemix_notm}} Block Storage existente a la última versión.
{: shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

1. Actualice el repositorio de Helm para recuperar la última versión de todos los diagramas de Helm de este repositorio.
   ```
   helm repo update
   ```
   {: pre}
   
2. Opcional: descargue el último diagrama de Helm en la máquina local. A continuación, descomprima el paquete y revise el archivo `release.md`
para ver la información de release más reciente. 
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. Busque el nombre del diagrama de Helm de almacenamiento en bloque que ha instalado en el clúster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Salida de ejemplo:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. Actualice el plugin {{site.data.keyword.Bluemix_notm}} Block Storage a la última versión.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. Opcional: cuando actualice el plugin, la clase de almacenamiento `default` deja de estar establecida. Si desea establecer como clase de almacenamiento predeterminada la clase de almacenamiento de su elección, ejecute el mandato siguiente.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### Eliminación del plugin {{site.data.keyword.Bluemix_notm}} Block Storage
Si no desea suministrar y utilizar {{site.data.keyword.Bluemix_notm}} Block Storage en el clúster, puede desinstalar el diagrama de Helm.
{: shortdesc}

**Nota:** Al eliminar el plugin no elimina los datos, las PVC o los PV. Cuando se elimina el plugin, se eliminan del clúster todos los conjuntos de daemons y pods relacionados. No puede suministrar nuevo almacenamiento en bloque para el clúster o utilizar PV o PVC de almacenamiento en bloque existente después de eliminar el plugin.

Antes de empezar:
- [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure). 
- Asegúrese de que no haya PVC ni PV en el clúster que utilice almacenamiento en bloque.

Para eliminar el plugin: 

1. Busque el nombre del diagrama de Helm de almacenamiento en bloque que ha instalado en el clúster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Salida de ejemplo:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Suprima el plugin {{site.data.keyword.Bluemix_notm}} Block Storage.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. Verifique que se hayan eliminado los pods de almacenamiento en bloque.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   La eliminación de los pods es satisfactoria si dejan de aparecer en la salida de la CLI.

4. Verifique que se hayan eliminado las clases de almacenamiento en bloque.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   La eliminación de las clases de almacenamiento es satisfactoria si dejan de aparecer en la salida de la CLI.

<br />



## Cómo decidir la configuración del almacenamiento en bloque
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} proporciona clases de almacenamiento predefinidas para el almacenamiento en bloque que puede utilizar para suministrar almacenamiento en bloque con una configuración específica.
{: shortdesc}

Cada clase de almacenamiento especifica el tipo de almacenamiento en bloque que suministra, incluidos tamaño disponible, IOPS, sistema de archivos y política de retención.  

**Importante:** asegúrese de elegir la configuración de almacenamiento cuidadosamente para tener suficiente capacidad para almacenar los datos. Después de suministrar un tipo específico de almacenamiento utilizando una clase de almacenamiento, no puede cambiar tamaño, tipo, IOPS ni política de retención del dispositivo de almacenamiento. Si necesita más almacenamiento o almacenamiento con otra configuración, debe [crear una nueva instancia de almacenamiento y copiar los datos](cs_storage_basics.html#update_storageclass) de la instancia de almacenamiento antigua en la nueva. 

1. Obtenga una lista de las clases de almacenamiento disponibles en {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep block
    ```
    {: pre}

    Salida de ejemplo: 
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

2. Revise la configuración de una clase de almacenamiento. 
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}
   
   Para obtener más información sobre cada clase de almacenamiento, consulte la [referencia de clases de almacenamiento](#storageclass_reference). Si no encuentra lo que está buscando, considere la posibilidad de crear su propia clase de almacenamiento personalizada. Para empezar, compruebe los [ejemplos de clase de almacenamiento personalizada](#custom_storageclass).
   {: tip}
   
3. Elija el tipo de almacenamiento en bloque que desea suministrar. 
   - **Clases de almacenamiento de bronce, plata y oro:** estas clases de almacenamiento suministran [almacenamiento resistente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo") ](https://knowledgelayer.softlayer.com/topic/endurance-storage). El almacenamiento resistente le permite elegir el tamaño del almacenamiento en gigabytes en los niveles de IOPS predefinidos.
   - **Clase de almacenamiento personalizada:** esta clase de almacenamiento contiene [almacenamiento de rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo") ](https://knowledgelayer.softlayer.com/topic/performance-storage). Con el almacenamiento de rendimiento, tiene más control sobre el tamaño del almacenamiento y de IOPS. 
     
4. Elija el tamaño e IOPS para el almacenamiento en bloque. El tamaño y el número de IOPS definen el número total de IOPS (operaciones de entrada/salida por segundo), lo que sirve como indicador de la rapidez del almacenamiento. Cuantas más IOPS tenga el almacenamiento, más rápido se procesarán las operaciones de entrada y salida. 
   - **Clases de almacenamiento de bronce, plata y oro:** estas clases de almacenamiento se suministran con un número fijo de IOPS por gigabytes y se suministran en discos duros SSD. El número total de IOPS depende del tamaño del almacenamiento que elija. Puede seleccionar cualquier número entero de gigabytes comprendido dentro del rango de tamaño permitido, como por ejemplo 20 Gi, 256 Gi o 11854 Gi. Para determinar el número total de IOPS, debe multiplicar IOPS por el tamaño seleccionado. Por ejemplo, si selecciona un tamaño de almacenamiento en bloque de 1000 Gi en la clase de almacenamiento de plata que se suministra con 4 IOPS por GB, el almacenamiento tendrá un total de 4000 IOPS.  
     <table>
         <caption>Tabla de IOPS y rangos de tamaño de clase de almacenamiento por gigabyte</caption>
         <thead>
         <th>Clase de almacenamiento</th>
         <th>IOPS por gigabyte</th>
         <th>Rango de tamaño en gigabytes</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronce</td>
         <td>2 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Plata</td>
         <td>4 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Oro</td>
         <td>10 IOPS/GB</td>
         <td>20-4000 Gi</td>
         </tr>
         </tbody></table>
   - **Clase de almacenamiento personalizada:** cuando elige esta clase de almacenamiento, tiene más control sobre el tamaño y el número de IOPS que desea. Para el tamaño, puede seleccionar cualquier número entero de gigabytes comprendido dentro del rango de tamaño permitido. El tamaño que elija determina el rango de IOPS que tendrá a su disponibilidad. Puede elegir un tamaño de IOPS que sea un múltiplo de 100 y que esté en el rango especificado. Las IOPS que elige son estáticas y no se escalan con el tamaño del almacenamiento. Por ejemplo, si elige 40 Gi con 100 IOPS, el número total de IOPS seguirá siendo 100. </br></br>La proporción entre IOPS y gigabytes también determina el tipo de disco duro que se suministra. Por ejemplo, si tiene 500 Gi a 100 IOPS, la proporción entre IOPS y gigabyte será de 0,2. Si la proporción es menor o igual a 0,3, el almacenamiento se suministra en discos duros SATA. Si la proporción es mayor que 0,3, el almacenamiento se suministran en los discos duros SSD. 
     <table>
         <caption>Tabla de IOPS y rangos de tamaño de clase de almacenamiento personalizadas</caption>
         <thead>
         <th>Rango de tamaño en gigabytes</th>
         <th>Rango de IOPS en múltiplos de 100</th>
         </thead>
         <tbody>
         <tr>
         <td>20-39 Gi</td>
         <td>100-1000 IOPS</td>
         </tr>
         <tr>
         <td>40-79 Gi</td>
         <td>100-2000 IOPS</td>
         </tr>
         <tr>
         <td>80-99 Gi</td>
         <td>100-4000 IOPS</td>
         </tr>
         <tr>
         <td>100-499 Gi</td>
         <td>100-6000 IOPS</td>
         </tr>
         <tr>
         <td>500-999 Gi</td>
         <td>100-10000 IOPS</td>
         </tr>
         <tr>
         <td>1000-1999 Gi</td>
         <td>100-20000 IOPS</td>
         </tr>
         <tr>
         <td>2000-2999 Gi</td>
         <td>200-40000 IOPS</td>
         </tr>
         <tr>
         <td>3000-3999 Gi</td>
         <td>200-48000 IOPS</td>
         </tr>
         <tr>
         <td>4000-7999 Gi</td>
         <td>300-48000 IOPS</td>
         </tr>
         <tr>
         <td>8000-9999 Gi</td>
         <td>500-48000 IOPS</td>
         </tr>
         <tr>
         <td>10000-12000 Gi</td>
         <td>1000-48000 IOPS</td>
         </tr>
         </tbody></table>

5. Decida si desea conservar los datos después de que se suprima el clúster o la reclamación de volumen persistente (PVC). 
   - Si desea conservar los datos, seleccione la clase de almacenamiento `retain`. Cuando se suprime la PVC, únicamente ésta se suprime. El PV, el dispositivo de almacenamiento físico de la cuenta de la infraestructura de IBM Cloud (SoftLayer) y los datos seguirán existiendo. Para reclamar el almacenamiento y volverlo a utilizar en el clúster, debe eliminar el PV y seguir los pasos de [utilización de almacenamiento en bloque existente](#existing_block). 
   - Si desea que el PV, los datos y el dispositivo físico de almacenamiento en bloques se supriman cuando suprima la PVC, elija una clase de almacenamiento sin la opción `retain`.
   
6. Decida si desea que se le facture por horas o por meses. Consulte las [tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/block-storage/pricing) para obtener más información. De forma predeterminada, todos los dispositivos de almacenamiento en bloque se suministran con un tipo de facturación por hora. 

<br />



## Adición de almacenamiento en bloques a apps
{: #add_block}

Cree una reclamación de volumen persistente (PVC) para [suministrar de forma dinámica](cs_storage_basics.html#dynamic_provisioning) almacenamiento en bloque para el clúster. El suministro dinámico crea automáticamente el volumen persistente (PV) adecuado y solicita el dispositivo de almacenamiento real en la cuenta de la infraestructura de IBM Cloud (SoftLayer). 
{:shortdesc}

**Importante**: el almacenamiento en bloque se suministra con la modalidad de acceso `ReadWriteOnce`. Solo puede montarlo en un pod en un nodo trabajador en el clúster al mismo tiempo.

Antes de empezar:
- Si tiene un cortafuegos, [permita el acceso de salida](cs_firewall.html#pvc) para los rangos de IP de la infraestructura de IBM Cloud (SoftLayer) de las zonas en las que están en los clústeres, de modo que pueda crear las PVC.
- Instale el [plugin de almacenamiento en bloque de {{site.data.keyword.Bluemix_notm}}](#install_block).
- [Decida si desea utilizar una clase de almacenamiento predefinida](#predefined_storageclass) o crear una [clase de almacenamiento personalizada](#custom_storageclass). 

Para añadir almacenamiento en bloque:

1.  Cree un archivo de configuración para definir su reclamación de volumen permanente (PVC) y guarde la configuración como archivo `.yaml`.

    -  **Ejemplo de clases de almacenamiento bronce, plata y oro**:
       El siguiente archivo `.yaml` crea una reclamación que se denomina `mypvc` de la clase de almacenamiento `"ibmc-block-silver"`, que se factura con el valor `"hourly"`, con un tamaño de gigabyte de `24Gi`. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Ejemplo de utilización de una clase de almacenamiento personalizada**:
       El siguiente archivo `.yaml` crea una reclamación denominada `mypvc` de la clase de almacenamiento `ibmc-block-retain-custom`, con una facturación de tipo `"hourly"` y un tamaño en gigabytes de `45Gi` y de IOPS de `"300"`. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 45Gi
             iops: "300"
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
        <td><code>metadata/annotations</code></td>
        <td>El nombre de la clase de almacenamiento que desea utilizar para suministrar almacenamiento en bloque. </br> Si no especifica ninguna clase de almacenamiento, el PV se crea con la clase de almacenamiento predeterminada <code>ibmc-file-bronze</code><p>**Sugerencia:** Si desea cambiar la clase de almacenamiento predeterminada, ejecute <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> y sustituya <code>&lt;storageclass&gt;</code> con el nombre de la clase de almacenamiento.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Especifique la frecuencia con la que desea que se calcule la factura de almacenamiento, los valores son "monthly" o "hourly". El valor predeterminado es "hourly".</td>
        </tr>
	<tr>
	<td><code>metadatos/región</code></td>
        <td>Especifique la región en la que desea suministrar el almacenamiento en bloque. Si especifica la región, también debe especificar una zona. Si no especifica una región, o si la región especificada no se encuentra, el almacenamiento se crea en la misma región que el clúster. </br><strong>Nota:</strong> esta opción solo recibe soporte con el plugin IBM Cloud Block Storage versión 1.0.1 o superior. Para las versiones anteriores del plugin, si tiene un clúster multizona, la zona en la que se suministra el almacenamiento se selecciona en una iteración cíclica para equilibrar las solicitudes de volumen de forma uniforme entre todas las zonas. Si desea especificar la zona para el almacenamiento, cree en primer lugar una [clase de almacenamiento personalizada](#multizone_yaml). A continuación, cree una PVC con la clase de almacenamiento personalizada.</td>
	</tr>
	<tr>
	<td><code>metadatos/zona</code></td>
	<td>Especifique la zona en la que desea suministrar el almacenamiento en bloque. Si especifica la zona, también debe especificar una región. Si no especifica una zona o si la zona especificada no se encuentra en un clúster multizona, la zona se selecciona en una iteración cíclica. </br><strong>Nota:</strong> esta opción solo recibe soporte con el plugin IBM Cloud Block Storage versión 1.0.1 o superior. Para las versiones anteriores del plugin, si tiene un clúster multizona, la zona en la que se suministra el almacenamiento se selecciona en una iteración cíclica para equilibrar las solicitudes de volumen de forma uniforme entre todas las zonas. Si desea especificar la zona para el almacenamiento, cree en primer lugar una [clase de almacenamiento personalizada](#multizone_yaml). A continuación, cree una PVC con la clase de almacenamiento personalizada.</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Indique el tamaño del almacenamiento en bloque, en gigabytes (Gi). </br></br><strong>Nota:</strong> una vez suministrado el almacenamiento, no puede cambiar el tamaño del almacenamiento en bloque. Asegúrese de especificar un tamaño que coincida con la cantidad de datos que desea almacenar. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Esta opción solo está disponible para las clases de almacenamiento personalizadas (`ibmc-block-custom/ibmc-block-retain-custom`). Especifique el IOPS total para el almacenamiento seleccionando un múltiplo de 100 dentro del rango permitido. Si elige un IOPS distinto del que aparece en la lista, el IOPS se redondea.</td>
        </tr>
        </tbody></table>

    Si desea utilizar una clase de almacenamiento personalizada, cree su PVC con el nombre de clase de almacenamiento correspondiente, unas IOPS válidas y un tamaño.   
    {: tip}

2.  Cree la PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  Verifique que la PVC se ha creado y se ha vinculado al PV. Este proceso puede tardar unos minutos.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Salida de ejemplo:

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

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
     
<br />




## Utilización de almacenamiento en bloque existente en el clúster
{: #existing_block}

Si dispone de un dispositivo de almacenamiento físico existente que desea utilizar en el clúster, puede crear manualmente el PV y la PVC para [suministrar de forma estática](cs_storage_basics.html#static_provisioning) el almacenamiento.

Antes de empezar a montar el almacenamiento existente en una app, debe recuperar toda la información necesaria para su PV.  
{: shortdesc}

### Paso 1: Recuperación de la información del almacenamiento en bloque existente

1.  Recupere o genere una clave de API para su cuenta (SoftLayer) de infraestructura de IBM Cloud.
    1. Inicie sesión en el [portal de la infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://control.bluemix.net/).
    2. Seleccione **Cuenta**, **Usuarios** y, a continuación, **Lista de usuarios**.
    3. Encuentre su ID de usuario.
    4. En la columna de **Clave de API**, pulse **Generar** para generar una clave de API o **Ver** para ver su clave de API existente.
2.  Recupere el nombre de usuario de API de su cuenta (SoftLayer) de infraestructura de IBM Cloud.
    1. Desde el menú **Lista de usuarios**, seleccione su ID de usuario.
    2. En la sección **Información de acceso de API**, busque su **Nombre de usuario de API**.
3.  Inicie una sesión en el plugin de CLI de la infraestructura de IBM Cloud.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  Elija autenticarse utilizando el nombre de usuario y la clave de API de su cuenta (SoftLayer) de infraestructura de IBM Cloud.
5.  Especifique el nombre de usuario y la clave de API que recuperó en los pasos anteriores.
6.  Obtenga una lista de los dispositivos de almacenamiento en bloque disponibles.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    Salida de ejemplo:
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Anote los valores de `id`, `ip_addr`, `capacity_gb`, `datacenter` y `lunId` del dispositivo de almacenamiento en bloque que desea montar para el clúster. **Nota:** para montar el almacenamiento existente en un clúster, debe tener un nodo trabajador en la misma zona que el almacenamiento. Para verificar la zona del nodo trabajador, ejecute `ibmcloud ks workers <cluster_name_or_ID>`. 

### Paso 2: Creación de un volumen permanente (PV) y de una reclamación de volumen permanente (PVC) coincidente

1.  Opcional: si tiene almacenamiento que ha suministrado con una clase de almacenamiento de tipo `retain`, cuando elimine la PVC, el PV y el dispositivo de almacenamiento físico no se eliminarán. Para volver a utilizar el almacenamiento en el clúster, primero debe eliminar el PV. 
    1. Obtenga una lista de los PV existentes. 
       ```
       kubectl get pv
       ```
       {: pre}
     
       Busque el PV perteneciente a su almacenamiento persistente. El PV está en el estado `released`. 
     
    2. Elimine el PV. 
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}
   
    3. Verifique que el PV se ha eliminado. 
       ```
       kubectl get pv
       ```
       {: pre}

2.  Cree un archivo de configuración para el PV. Incluya los valores de `id`, `ip_addr`, `capacity_gb`, `datacenter` y `lunIdID` del almacenamiento en bloque que ha recuperado anteriormente.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region=<region>
         failure-domain.beta.kubernetes.io/zone=<zone>
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
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
    <td>Especifique el nombre del PV que crear.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Especifique la región y la zona que ha recuperado anteriormente. Debe tener al menos un nodo trabajador en la misma región y zona que el almacenamiento persistente para montar el almacenamiento en el clúster. Si ya existe un PV para el almacenamiento, [añada la etiqueta de zona y región](cs_storage_basics.html#multizone) a su PV.
    </tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>Especifique el tipo de sistema de archivos que está configurado para el almacenamiento en bloques existente. Elija entre <code>ext4</code> o <code>xfs</code>. Si no especifica esta opción, de forma predeterminada será <code>ext4</code> para el PV. Cuando se define el fsType erróneo, se sigue creando el PV, sin embargo, el montaje del PV para el pod fallará. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Especifique el tamaño del almacenamiento en bloque existente que ha recuperado en el paso anterior como <code>capacity-gb</code>. El tamaño de almacenamiento se debe especificar en gigabytes, por ejemplo, 20Gi (20 GB) o 1000Gi (1 TB).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Especifique el ID de la unidad lógica de su almacenamiento en bloque que ha recuperado anteriormente como <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Especifique la dirección IP del almacenamiento en bloque que ha recuperado anteriormente como <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Especifique el ID del almacenamiento en bloque que ha recuperado anteriormente como <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Especifique un nombre para el volumen.</td>
	    </tr>
    </tbody></table>

3.  Cree el PV en el clúster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. Verifique que se ha creado el PV.
    ```
    kubectl get pv
    ```
    {: pre}

5. Cree otro archivo de configuración para crear la PVC. Para que la PVC coincida con el PV que ha creado anteriormente, debe elegir el mismo valor para `storage` y `accessMode`. El campo `storage-class` debe estar vacío. Si alguno de estos campos no coincide con el PV, se crea automáticamente un nuevo PV.

     ```
     kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
     spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "<storage_size>"
     ```
     {: codeblock}

6.  Cree la PVC.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  Verifique que la PVC se ha creado y se ha enlazado al PV que ha creado con anterioridad. Este proceso puede tardar unos minutos.
     ```
     kubectl describe pvc mypvc
     ```
     {: pre}

     Salida de ejemplo:

     ```
     Name: mypvc
    Namespace: default
    StorageClass: ""
     Status: Bound
     Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     Labels: <none>
     Capacity: 20Gi
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

Ha creado correctamente un PV y lo ha enlazado a una PVC. Ahora los usuarios del clúster pueden [montar la PVC](#app_volume_mount) en sus despliegues y empezar a leer el PV y a grabar en el mismo.

<br />



## Copia de seguridad y restauración de datos 
{: #backup_restore}

El almacenamiento en bloque se suministra en la misma ubicación que los nodos trabajadores del clúster. IBM aloja el almacenamiento en servidores en clúster para proporcionar disponibilidad en el caso de que un servidor deje de funcionar. Sin embargo, no se realizan automáticamente copias de seguridad del almacenamiento en bloque, y puede dejar de ser accesible si falla toda la ubicación. Para evitar que los datos que se pierdan o se dañen, puede configurar copias de seguridad periódicas que puede utilizar para restaurar los datos cuando sea necesario.

Consulte las opciones siguientes de copia de seguridad y restauración para el almacenamiento en bloque:

<dl>
  <dt>Configurar instantáneas periódicas</dt>
  <dd><p>Puede [configurar instantáneas periódicas para el almacenamiento en bloque](/docs/infrastructure/BlockStorage/snapshots.html#snapshots), que son imágenes de solo lectura que capturan el estado de la instancia en un punto en el tiempo. Para almacenar la instantánea, debe solicitar espacio de instantáneas en el almacenamiento en bloque. Las instantáneas se almacenan en la instancia de almacenamiento existente dentro de la misma zona. Puede restaurar datos desde una instantánea si un usuario elimina accidentalmente datos importantes del volumen. </br></br> <strong>Para crear una instantánea para su volumen: </strong><ol><li>Liste los PV en su clúster. <pre class="pre"><code>kubectl get pv</code></pre></li><li>Obtenga los detalles de los PV para los que desea crear espacio de instantáneas y anote el ID de volumen, el tamaño y las IOPS. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> El tamaño y el número de IOPS se muestran en la sección <strong>Labels</strong> de la salida de la CLI. Para encontrar el ID de volumen, revise la anotación <code>ibm.io/network-storage-id</code> de la salida de la CLI. </li><li>Cree el tamaño de instantánea para el volumen existente con los parámetros que ha recuperado en el paso anterior. <pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Espere a que se haya creado el tamaño de la instantánea. <pre class="pre"><code>slcli block volume-detail &lt;volume_id&gt;</code></pre>El tamaño de la instantánea se suministra de forma correcta cuando la <strong>Snapshot Capacity (GB)</strong> en la salida de la CLI cambia de 0 al tamaño solicitado. </li><li>Cree la instantánea para el volumen y anote el ID de la instantánea que se crea para usted. <pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>Verifique que la instantánea se haya creado correctamente. <pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>Para restaurar los datos desde una instantánea en un volumen existente: </strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>Realice una réplica de las instantáneas en otra zona</dt>
 <dd><p>Para proteger los datos ante un error de la zona, puede [replicar instantáneas](/docs/infrastructure/BlockStorage/replication.html#replicating-data) en una instancia de almacenamiento en bloque configurada en otra zona. Los datos únicamente se pueden replicar desde el almacenamiento primario al almacenamiento de copia de seguridad. No puede montar una instancia replicada de almacenamiento en bloque en un clúster. Cuando el almacenamiento primario falla, puede establecer de forma manual el almacenamiento de copia de seguridad replicado para que sea el primario. A continuación, puede montarla en el clúster. Una vez restaurado el almacenamiento primario, puede restaurar los datos del almacenamiento de copia de seguridad.</p></dd>
 <dt>Duplicar almacenamiento</dt>
 <dd><p>Puede [duplicar la instancia de almacenamiento en bloque](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume) en la misma zona que la instancia de almacenamiento original. La instancia duplicada tiene los mismos datos que la instancia de almacenamiento original en el momento de duplicarla. A diferencia de las réplicas, utilice los duplicados como una instancia de almacenamiento independiente de la original. Para duplicar, primero configure instantáneas para el volumen.</p></dd>
  <dt>Haga copia de seguridad de los datos en {{site.data.keyword.cos_full}}</dt>
  <dd><p>Puede utilizar la [**imagen ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) para utilizar un pod de copia de seguridad y restauración en el clúster. Este pod contiene un script para ejecutar una copia de seguridad puntual o periódico para cualquier reclamación de volumen permanente (PVC) en el clúster. Los datos se almacenan en la instancia de {{site.data.keyword.cos_full} que ha configurado en una zona.</p><strong>Nota:</strong> el almacenamiento en bloque se monta con la modalidad de acceso RWO. Este acceso solo permite los pods en el almacenamiento en bloque de uno en uno. Para hacer una copia de seguridad de los datos, debe desmontar el pod de la app desde el almacenamiento, montarlo en el pod de copia de seguridad, realizar una copia de seguridad de los datos y volver a montar el almacenamiento en el pod de la app. </br></br>
Para aumentar la alta disponibilidad de los datos y proteger la app ante un error de la zona, configure una segunda instancia de {{site.data.keyword.cos_full}} y replique los datos entre las zonas. Si necesita restaurar datos desde la instancia de {{site.data.keyword.cos_full}}, utilice el script de restauración que se proporciona con la imagen.</dd>
<dt>Copiar datos a y desde pods y contenedores</dt>
<dd><p>Utilice el [mandato ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) `kubectl cp` para copiar archivos y directorios a y desde pods o contenedores específicos en el clúster.</p>
<p>Antes de empezar, establezca como [destino de su CLI de Kubernetes](cs_cli_install.html#cs_cli_configure) el clúster que desea utilizar. Si no especifica un contenedor con <code>-c</code>, el mandato utiliza el primer contenedor disponible en el pod.</p>
<p>El mandato se puede utilizar de varias maneras:</p>
<ul>
<li>Copiar datos desde su máquina local a un pod en su clúster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copiar datos desde un pod en su clúster a su máquina local: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copiar datos desde un pod en su clúster a un contenedor específico en otro pod: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Referencia de clases de almacenamiento
{: #storageclass_reference}

### Bronce
{: #bronze}

<table>
<caption>Clase de almacenamiento en bloque: bronce</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Almacenamiento resistente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de archivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS por gigabyte</td>
<td>2</td>
</tr>
<tr>
<td>Rango de tamaño en gigabytes</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Disco duro</td>
<td>SSD</td>
</tr>
<tr>
<td>Facturación</td>
<td>El tipo de facturación predeterminado depende de la versión del plugin {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versión 1.0.1 y superiores: por hora</li><li>Versión 1.0.0 e inferiores: mensualmente</li></ul></td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Información sobre tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### Plata
{: #silver}

<table>
<caption>Clase de almacenamiento en bloque: plata</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Almacenamiento resistente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de archivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS por gigabyte</td>
<td>4</td>
</tr>
<tr>
<td>Rango de tamaño en gigabytes</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Disco duro</td>
<td>SSD</td>
</tr>
<tr>
<td>Facturación</td>
<td>El tipo de facturación predeterminado depende de la versión del plugin {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versión 1.0.1 y superiores: por hora</li><li>Versión 1.0.0 e inferiores: mensualmente</li></ul></td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Información sobre tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Oro
{: #gold}

<table>
<caption>Clase de almacenamiento en bloque: oro</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Almacenamiento resistente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de archivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS por gigabyte</td>
<td>10</td>
</tr>
<tr>
<td>Rango de tamaño en gigabytes</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>Disco duro</td>
<td>SSD</td>
</tr>
<tr>
<td>Facturación</td>
<td>El tipo de facturación predeterminado depende de la versión del plugin {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versión 1.0.1 y superiores: por hora</li><li>Versión 1.0.0 e inferiores: mensualmente</li></ul></td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Información sobre tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Personalizada
{: #custom}

<table>
<caption>Clase de almacenamiento en bloque: personalizada</caption>
<thead>
<th>Características</th>
<th>Valor</th>
</thead>
<tbody>
<tr>
<td>Nombre</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Sistema de archivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS y tamaño</td>
<td><strong>Rango de tamaños en gigabytes / Rango de IOPS en múltiplos de 100</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disco duro</td>
<td>La proporción entre IOPS y gigabytes determina el tipo de disco duro que se suministra. Para determinar la proporción entre IOPS y gigabytes, divida el número de IOPS por el tamaño de su almacenamiento. </br></br>Ejemplo: </br>Supongamos que elige 500 Gi de almacenamiento con 100 IOPS. La proporción es de 0,2 (100 IOPS/500 Gi). </br></br><strong>Visión general de los tipos de disco duro por proporción:</strong><ul><li>Menor o igual que 0,3: SATA</li><li>Mayor que 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Facturación</td>
<td>El tipo de facturación predeterminado depende de la versión del plugin {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versión 1.0.1 y superiores: por hora</li><li>Versión 1.0.0 e inferiores: mensualmente</li></ul></td>
</tr>
<tr>
<td>Tarifas</td>
<td>[Información sobre tarifas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Clases de almacenamiento personalizadas de ejemplo
{: #custom_storageclass}

### Especificación de la zona para clústeres multizona
{: #multizone_yaml}

El siguiente archivo `.yaml` personaliza una clase de almacenamiento que se basa en la clase de almacenamiento sin retención `ibm-block-silver`: el valor de `type` es `"Endurance"`, el valor de `iopsPerGB` es `4`, el valor de `sizeRange` es `"[20-12000]Gi"` y el valor de `reclaimPolicy` está establecido en `"Delete"`. La zona especificada es `dal12`. Puede revisar la información anterior en las clases de almacenamiento `ibmc` como ayuda para elegir valores aceptables para estos </br>

Para utilizar otra clase de almacenamiento como base, consulte la [Referencia de clases de almacenamiento](#storageclass_reference). 

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Montaje de almacenamiento en bloque con un sistema de archivos `XFS`
{: #xfs}

El ejemplo siguiente crea una clase de almacenamiento que se denomina `ibmc-block-custom-xfs` y que proporciona almacenamiento en bloque de rendimiento con un sistema de archivos `XFS`. 

```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-block-custom-xfs
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
   provisioner: ibm.io/ibmc-block
   parameters:
     type: "Performance"
     sizeIOPSRange: |-
       [20-39]Gi:[100-1000]
       [40-79]Gi:[100-2000]
       [80-99]Gi:[100-4000]
       [100-499]Gi:[100-6000]
       [500-999]Gi:[100-10000]
       [1000-1999]Gi:[100-20000]
       [2000-2999]Gi:[200-40000]
       [3000-3999]Gi:[200-48000]
       [4000-7999]Gi:[300-48000]
       [8000-9999]Gi:[500-48000]
       [10000-12000]Gi:[1000-48000]
  fsType: "xfs"
     reclaimPolicy: "Delete"
     classVersion: "2"
```
{: codeblock}

<br />

