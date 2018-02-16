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


# Compilación de contenedores a partir de imágenes
{: #images}

Una imagen de Docker es la base para cada contenedor que pueda crear. Se crea una imagen a partir de Dockerfile, que es un archivo que contiene instrucciones para crear la imagen. Un Dockerfile puede hacer referencia a artefactos de compilación en sus instrucciones que se almacenan por separado, como por ejemplo una app, la configuración de la app y sus dependencias.
{:shortdesc}


## Planificación de registros de imagen
{: #planning}

Las imágenes normalmente se almacenan en un registro que puede ser tanto de acceso público (registro público) como estar configurado con acceso limitado para un pequeño grupo de usuarios (registro privado). Los registros públicos, como por ejemplo Docker Hub, se pueden utilizar para empezar a trabajar con Docker y Kubernetes para crear la primera app contenerizada de un clúster. Pero, cuando se trate de aplicaciones de empresa, utilice un registro privado, como el que se suministra en {{site.data.keyword.registryshort_notm}}, para proteger sus imágenes frente a un posible uso y modificación por parte de usuarios no autorizados. El administrador del clúster debe configurar los registros privados para asegurarse de que las credenciales para acceder al registro privado están disponibles para los usuarios del clúster.
{:shortdesc}

Puede utilizar varios registros con {{site.data.keyword.containershort_notm}} para desplegar apps en el clúster.

|Registro|Descripción|Ventaja|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|Con esta opción, puede configurar su propio repositorio seguro de imágenes de Docker en {{site.data.keyword.registryshort_notm}} donde puede almacenar y compartir de forma segura imágenes entre los usuarios del clúster.|<ul><li>Gestione el acceso a las imágenes de la cuenta.</li><li>Utilice las apps de ejemplo y las imágenes proporcionadas por {{site.data.keyword.IBM_notm}}, como {{site.data.keyword.IBM_notm}} Liberty, como imagen padre y añádales su propio código de app.</li><li>Exploración automática de imágenes en busca de vulnerabilidades potenciales por parte de Vulnerability Advisor, que incluyen recomendaciones específicas del sistema operativo para solucionarlas.</li></ul>|
|Cualquier otro registro privado|Para conectar cualquier registro privado existente a su clúster, cree un [imagePullSecret ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/containers/images/). El secreto se utiliza para guardar el URL del registro y las credenciales de forma segura en un secreto de Kubernetes.|<ul><li>Utilice registros privados existentes independientemente de su origen (Docker Hub, registros propiedad de la organización u otros registros privados de Cloud).</li></ul>|
|Public Docker Hub|Utilice esta opción para utilizar directamente las imágenes públicas existentes de Docker Hub cuando no sea necesario realizar cambios en Dockerfile. <p>**Nota:** Tenga en cuenta que es posible que esta opción no se ajuste a los requisitos de seguridad de su organización, como la gestión de accesos, la exploración de vulnerabilidades o la privacidad de las apps.</p>|<ul><li>No se requiere configuración adicional para el clúster.</li><li>Incluye diversas aplicaciones de código abierto.</li></ul>|
{: caption="Tabla. Opciones de registro de imágenes público y privado" caption-side="top"}

Después de configurar el registro de imágenes, los usuarios del clúster pueden utilizar las imágenes de sus despliegues de apps en el clúster.


<br />



## Como acceder a un espacio de nombres en {{site.data.keyword.registryshort_notm}}
{: #namespace}

Puede desplegar contenedores en su clúster desde una imagen pública proporcionada por IBM o desde una imagen privada almacenada en el espacio de nombres de {{site.data.keyword.registryshort_notm}}.
{:shortdesc}

Antes de empezar:

1. [Configure un espacio de nombres en {{site.data.keyword.registryshort_notm}} en {{site.data.keyword.Bluemix_notm}} Público o {{site.data.keyword.Bluemix_dedicated_notm}} y envíe por push imágenes a este espacio de nombres](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Cree un clúster](cs_clusters.html#clusters_cli).
3. [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).

Cuando crea un clúster, se crean automáticamente señales y secretos tanto para [el registro regional más cercano y el registro internacional](/docs/services/Registry/registry_overview.html#registry_regions). El registro internacional almacena de forma segura imágenes públicas proporcionadas por IBM a las que puede hacer referencia en sus despliegues en lugar de tener referencias distintas para las imágenes que se almacenan en cada registro regional. El registro regional almacena de forma segura sus imágenes de Docker privadas así como las mismas imágenes públicas que se almacenan en el registro internacional. Las señales se utilizan para autorizar el acceso de solo lectura a cualquiera de los espacios de nombres que configure en {{site.data.keyword.registryshort_notm}} para que pueda trabajar con estas imágenes públicas (registro internacional) y privadas (registros regionales).

Cada señal se debe guardar en `imagePullSecret` de Kubernetes para que resulte accesible para un clúster de Kubernetes cuando se despliegue una app contenerizada. Cuando se crea el clúster, {{site.data.keyword.containershort_notm}} almacena automáticamente las señales para los registros internacional (imágenes públicas proporcionadas por IBM) y regionales en los secretos de extracción de imágenes de Kubernetes. Los secretos de extracción de imágenes se añaden al espacio de nombres `predeterminado` de Kubernetes, la lista predeterminada de secretos en la `ServiceAccount` de dicho espacio de nombres y el espacio de nombres `kube-system`.

**Nota:** Con esta configuración inicial, puede desplegar contenedores desde cualquier imagen disponible en un espacio de nombres de la cuenta de {{site.data.keyword.Bluemix_notm}} en el espacio de nombres **default** del clúster. Si desea desplegar un contenedor en otros espacios de nombres del clúster, o si desea utilizar una imagen almacenada en otra región de {{site.data.keyword.Bluemix_notm}} o en otra cuenta de {{site.data.keyword.Bluemix_notm}}, debe [crear su propio imagePullSecret para el clúster](#other).

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
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}


<br />



## Acceso a imágenes en otros espacios de nombres de Kubernetes, regiones de {{site.data.keyword.Bluemix_notm}} y cuentas
{: #other}

Puede desplegar contenedores en otros espacios de nombres de Kubernetes, utilizar imágenes almacenadas en otras regiones o cuentas de {{site.data.keyword.Bluemix_notm}} o utilizar imágenes almacenadas en {{site.data.keyword.Bluemix_dedicated_notm}} creando su propio imagePullSecret.
{:shortdesc}

Antes de empezar:

1.  [Configure un espacio de nombres en {{site.data.keyword.registryshort_notm}} en {{site.data.keyword.Bluemix_notm}} Público o {{site.data.keyword.Bluemix_dedicated_notm}} y envíe por push imágenes a este espacio de nombres](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Cree un clúster](cs_clusters.html#clusters_cli).
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
    <caption>Tabla. Descripción de los componentes de este mandato</caption>
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
        <caption>Tabla. Visión general de los componentes del archivo YAML</caption>
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


<br />



## Acceso a imágenes públicas desde Docker Hub
{: #dockerhub}

Puede utilizar cualquier imagen pública almacenada en Docker Hub para desplegar un contenedor en el clúster sin configuración adicional.
{:shortdesc}

Antes de empezar:

1.  [Cree un clúster](cs_clusters.html#clusters_cli).
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
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}

<br />



## Acceso a imágenes almacenadas en otros registros privados
{: #private_images}

Si ya tiene un registro privado que desea utilizar, debe almacenar las credenciales del registro en un imagePullSecret de Kubernetes y hacer referencia a dicho secreto en el archivo de configuración.
{:shortdesc}

Antes de empezar:

1.  [Cree un clúster](cs_clusters.html#clusters_cli).
2.  [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para crear un imagePullSecret:

**Nota:** Los ImagePullSecrets son válidos para los espacios de nombres de Kubernetes para los que se han creado. Repita estos pasos para cada espacio de nombres en el que desea desplegar contenedores desde una imagen de un registro privado de {{site.data.keyword.Bluemix_notm}}.

1.  Cree el secreto de Kubernetes para almacenar las credenciales del registro privado.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabla. Descripción de los componentes de este mandato</caption>
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
        <caption>Tabla. Visión general de los componentes del archivo YAML</caption>
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

