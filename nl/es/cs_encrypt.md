---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Protección de la información confidencial del clúster
{: #encryption}

De forma predeterminada, el clúster de {{site.data.keyword.containerlong}} utiliza discos cifrados para almacenar información, como configuraciones, en `etcd` o en el sistema de archivos de contenedor que se ejecuta en los discos secundarios del nodo trabajador. Cuando despliegue la app, no almacene información confidencial, como credenciales o claves, en el archivo de configuración de YAML, mapas de configuración o scripts. Utilice en su lugar [secretos de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/secret/). También puede cifrar datos en secretos de Kubernetes para evitar que usuarios no autorizados accedan a la información confidencial del clúster.
{: shortdesc}

Para obtener más información sobre cómo proteger el clúster, consulte [Seguridad para {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).



## Cuándo utilizar secretos
{: #secrets}

Los secretos de Kubernetes constituyen una forma segura de almacenar información confidencial, como nombres de usuario, contraseñas o claves. Si necesita que la información confidencial se cifre, [habilite {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) para cifrar los secretos. Para obtener más información sobre lo que puede almacenar en secretos, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Revise las siguientes tareas que requieren secretos.

### Adición de un servicio a un clúster
{: #secrets_service}

Cuando enlaza un servicio a un clúster, no tiene que crear un secreto para almacenar las credenciales de servicio. El secreto se crea automáticamente. Para obtener más información, consulte [Adición de servicios de Cloud Foundry a clústeres](cs_integrations.html#adding_cluster).

### Cifrado del tráfico destinado a sus apps con secretos de TLS
{: #secrets_tls}

El ALB equilibra carga de tráfico de red HTTP para las apps en su clúster. Para equilibrar también la carga de conexiones HTTPS entrantes, puede configurar el ALB para descifrar el tráfico de red y reenviar las solicitudes descifradas a las apps expuestas en su clúster. Para obtener más información, consulte la [documentación sobre la configuración de Ingress](cs_ingress.html#public_inside_3).

Además, si tiene apps que requieren el protocolo HTTPS y necesitan que el tráfico permanezca cifrado, puede utilizar secretos de autenticación mutua o unidireccional con la anotación `ssl-services`. Para obtener más información, consulte la [documentación sobre anotaciones de Ingress](cs_annotations.html#ssl-services).

### Acceso a su registro con las credenciales almacenadas en un `imagePullSecret` de Kubernetes
{: #imagepullsecret}

Cuando crea un clúster, los secretos correspondientes a sus credenciales de {{site.data.keyword.registrylong}} se crean automáticamente en el espacio de nombres `default` de Kubernetes. Sin embargo, debe [crear su propio imagePullSecret para el clúster](cs_images.html#other) si
desea desplegar un contenedor en las situaciones siguientes.
* Desde una imagen del registro de {{site.data.keyword.registryshort_notm}} en un espacio de nombres de Kubernetes que no sea `default`.
* Desde una imagen del registro de {{site.data.keyword.registryshort_notm}} almacenado en otra región de {{site.data.keyword.Bluemix_notm}} o cuenta de {{site.data.keyword.Bluemix_notm}}.
* Desde una imagen almacenada en una cuenta dedicada de {{site.data.keyword.Bluemix_notm}}.
* Desde una imagen almacenada en un registro privado externo.

<br />


## Cifrado de secretos de Kubernetes mediante {{site.data.keyword.keymanagementserviceshort}}
{: #keyprotect}

Puede cifrar sus secretos de Kubernetes mediante [{{site.data.keyword.keymanagementservicefull}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](/docs/services/key-protect/index.html#getting-started-with-key-protect) como [proveedor de servicios de gestión de claves (KMS) de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) en su clúster. El proveedor de KMS es una característica alfa en Kubernetes para las versiones 1.10 y 1.11.
{: shortdesc}

De forma predeterminada, los secretos de Kubernetes se almacenan en un disco cifrado en el componente `etcd` del nodo maestro de Kubernetes gestionado por IBM. Los nodos trabajadores también tienen discos secundarios cifrados mediante claves LUKS gestionadas por IBM que se almacenan como secretos en el clúster. Cuando habilita {{site.data.keyword.keymanagementserviceshort}} en el clúster, se utiliza su propia clave raíz para cifrar los secretos de Kubernetes, incluidos los secretos de LUKS. Puede obtener más control sobre los datos confidenciales mediante el cifrado de secretos con la clave raíz. El uso de su propio cifrado añade una capa de seguridad a los secretos de Kubernetes y le proporciona un mayor control sobre quién puede acceder a la información confidencial del clúster. Si alguna vez necesita eliminar de forma irreversible el acceso a sus secretos, puede eliminar la clave raíz.

**Importante**: si suprime la clave raíz en la instancia de {{site.data.keyword.keymanagementserviceshort}}, no puede acceder ni eliminar los datos de los secretos del clúster posteriormente.

Antes de empezar:
* [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).
* Compruebe que el clúster ejecuta Kubernetes versión 1.10.8_1524, 1.11.3_1521 o posterior ejecutando `ibmcloud ks clúster-get --cluster <cluster_name_or_ID>` y comprobando el campo **Version**.
* Compruebe que dispone de [permisos de **administrador**](cs_users.html#access_policies) para llevar a cabo estos pasos.
* Asegúrese de que la clave de API establecida para la región en la que está el clúster está autorizada para utilizar la protección por clave. Para comprobar el propietario de la clave de API cuyas credenciales están almacenadas para la región, ejecute `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`.

Para habilitar {{site.data.keyword.keymanagementserviceshort}} o para actualizar la instancia o clave raíz que cifra los secretos del clúster:

1.  [Cree una instancia de {{site.data.keyword.keymanagementserviceshort}}](/docs/services/key-protect/provision.html#provision).

2.  Obtenga el ID de la instancia de servicio.

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [Cree una clave raíz](/docs/services/key-protect/create-root-keys.html#create-root-keys). De forma predeterminada, la clave raíz se crea sin fecha de caducidad.

    ¿Necesita establecer una fecha de caducidad para cumplir con las políticas de seguridad internas? [Cree la clave raíz mediante la API](/docs/services/key-protect/create-root-keys.html#api) e incluya el parámetro `expirationDate`. **Importante**: antes de que caduque la clave raíz, debe repetir estos pasos para actualizar el clúster de modo que utilice la nueva clave raíz. De lo contrario, no podrá descifrar sus secretos.
    {: tip}

4.  Anote el [**ID** de la clave raíz](/docs/services/key-protect/view-keys.html#gui).

5.  Obtenga el [punto final de {{site.data.keyword.keymanagementserviceshort}}](/docs/services/key-protect/regions.html#endpoints) de la instancia.

6.  Obtenga el nombre del clúster para el que desea habilitar {{site.data.keyword.keymanagementserviceshort}}.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  Habilite {{site.data.keyword.keymanagementserviceshort}} en el clúster. Especifique los distintivos con la información que ha recuperado anteriormente.

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

Después de habilitar {{site.data.keyword.keymanagementserviceshort}} en el clúster, los secretos existentes y los nuevos que se creen en el clúster se cifran automáticamente mediante la clave raíz de {{site.data.keyword.keymanagementserviceshort}}. Puede rotar la clave en cualquier momento repitiendo estos pasos con un ID de clave raíz nuevo.
