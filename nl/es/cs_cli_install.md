---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuración de la CLI y la API
{: #cs_cli_install}

Puede utilizar la CLI o la API de {{site.data.keyword.containershort_notm}} para crear y gestionar sus clústeres de Kubernetes.
{:shortdesc}

## Instalación de la CLI
{: #cs_cli_install_steps}

Instale las CLI necesarias para crear y gestionar sus clústeres de Kubernetes en {{site.data.keyword.containershort_notm}} y para desplegar apps contenerizadas en el clúster.
{:shortdesc}

Esta tarea incluye la información para instalar estas CLI y plug-ins:

-   {{site.data.keyword.Bluemix_notm}} CLI versión 0.5.0 o posterior
-   Plug-in de {{site.data.keyword.containershort_notm}} 
-   CLI de Kubernetes versión 1.5.6 o posterior
-   Opcional: plug-in {{site.data.keyword.registryshort_notm}}
-   Opcional: Docker versión 1.9. o posterior

<br>
Para instalar las CLI:

1.  Un requisito previo del plug-in de {{site.data.keyword.containershort_notm}} es que instale la CLI de [{{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://clis.ng.bluemix.net/ui/home.html). El prefijo para ejecutar mandatos mediante la CLI de {{site.data.keyword.Bluemix_notm}} es `bx`.

2.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Escriba
sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite.

    ```
    bx login
    ```
    {: pre}

    **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar
la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.



4.  Para crear clústeres de Kubernetes y gestionar nodos trabajadores, instale el plug-in {{site.data.keyword.containershort_notm}}. El prefijo para ejecutar mandatos mediante el plug-in {{site.data.keyword.containershort_notm}} es `bx cs`.

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Para comprobar que el plug-in se ha instalado correctamente, ejecute el siguiente mandato:

    ```
    bx plugin list
    ```
    {: pre}

    El plug-in {{site.data.keyword.containershort_notm}} se visualiza en los resultados como servicio de contenedor. 

5.  Para ver una versión local del panel de control Kubernetes y desplegar apps en los clústeres, [instale la CLI de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). El prefijo para ejecutar mandatos utilizando la CLI de Kubernetes es `kubectl`.

    1.  Descargue la CLI de Kubernetes.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Sugerencia:** Si utiliza Windows, instale la CLI de Kubernetes en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}. Esta configuración le ahorra algunos cambios en filepath cuando ejecute mandatos posteriormente.

    2.  Para usuarios de OSX y Linux, siga los pasos siguientes:
        1.  Mueva el archivo ejecutable al directorio `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Asegúrese de que `/usr/local/bin` aparezca en la variable del sistema `PATH`. La variable `PATH` contiene todos los directorios en los que el sistema operativo puede encontrar archivos ejecutables. Los directorios que se muestran en la variable `PATH` sirven para distintos propósitos. `/usr/local/bin` se utiliza para guardar archivos ejecutables correspondientes a software que no forma parte del sistema operativo y que ha instalado manualmente el administrador del sistema.

            ```
            echo $PATH
            ```
            {: pre}

            Ejemplo de salida de CLI:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Convierta el archivo binario en un ejecutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6.  Para gestionar un repositorio de imágenes privadas, instale el plug-in {{site.data.keyword.registryshort_notm}}. Utilice este plug-in para configurar su propio espacio de nombres en un registro privado de imágenes multiarrendatario, de alta disponibilidad y escalable alojado por IBM, y para almacenar y compartir imágenes de Docker con otros usuarios. Las imágenes de Docker son necesarias para desplegar contenedores en un clúster. El prefijo para ejecutar mandatos de registro es `bx cr`.

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Para comprobar que el plug-in se ha instalado correctamente, ejecute el siguiente mandato:

    ```
    bx plugin list
    ```
    {: pre}

    El plug-in se muestra en los resultados como registro de contenedor.

7.  Para crear imágenes localmente y enviarlas por push al espacio de nombres del registro, [instale Docker CE![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.docker.com/community-edition#/download). Si está utilizando Windows 8 o anterior, puede instalar [Docker Toolbox ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.docker.com/products/docker-toolbox) en su lugar.La CLI de Docker se utiliza para crear apps en imágenes. El prefijo para ejecutar mandatos utilizando la CLI de Docker es `docker`.

A continuación, empiece a [crear clústeres de Kubernetes desde la CLI con {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_cluster_cli).

Para obtener información acerca de estas CLI, consulte la documentación de dichas herramientas.

-   [Mandatos `bx`](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [Mandatos `bx cs`](cs_cli_reference.html#cs_cli_reference)
-   [Mandatos `kubectl` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [Mandatos `bx cr`](/docs/cli/plugins/registry/index.html#containerregcli)

## Configuración de la CLI para que ejecute mandatos `kubectl`
{: #cs_cli_configure}

Puede utilizar los mandatos que se proporcionan con la CLI de Kubernetes para gestionar clústeres en {{site.data.keyword.Bluemix_notm}}. Todos los mandatos `kubectl` que están disponibles en Kubernetes 1.5.6 se pueden utilizar con clústeres en {{site.data.keyword.Bluemix_notm}}. Después de crear un clúster, establezca el contexto de la CLI local para dicho clúster con una variable de entorno. A continuación, puede ejecutar el mandato de Kubernetes `kubectl` para trabajar con el clúster en {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Para poder ejecutar mandatos `kubectl`, [instale las CLI necesarias](#cs_cli_install) y [cree un clúster](cs_cluster.html#cs_cluster_cli).

1.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Escriba
sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite.

    ```
    bx login
    ```
    {: pre}

    Para especificar una región de {{site.data.keyword.Bluemix_notm}} concreta, incluya el punto final de la API. Si tiene imágenes de Docker privadas almacenadas en el registro de contenedor de una región {{site.data.keyword.Bluemix_notm}} concreta o instancias de servicio {{site.data.keyword.Bluemix_notm}} que ya ha creado, inicie la sesión en esta región para acceder a las imágenes y servicios de {{site.data.keyword.Bluemix_notm}}.

    La región de {{site.data.keyword.Bluemix_notm}} en la que inicie la sesión también determina la región donde puede crear los clústeres de Kubernetes, incluidos los centros de datos disponibles. Si no especifica ninguna región, la sesión se iniciará automáticamente en la región más cercana. 
      -   EE.UU. Sur

          ```
          bx login -a api.ng.bluemix.net
          ```
          {: pre}

      -   Sídney

          ```
          bx login -a api.au-syd.bluemix.net
          ```
          {: pre}

      -   Alemania

          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   Reino Unido

          ```
          bx login -a api.eu-gb.bluemix.net
          ```
          {: pre}

    **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar
la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.

2.  Seleccione una cuenta de {{site.data.keyword.Bluemix_notm}}. Si se le ha asignado a varias organizaciones de {{site.data.keyword.Bluemix_notm}}, seleccione la
organización en la que se ha creado el clúster. Los clústeres son específicos de una
organización, pero son independientes de un espacio de {{site.data.keyword.Bluemix_notm}}. Por lo tanto, no es necesario que seleccione un espacio.

3.  Si desea crear o acceder a clústeres de Kubernetes en una región distinta de la región de {{site.data.keyword.Bluemix_notm}} seleccionada anteriormente, especifique esta región. Por ejemplo, supongamos que desea iniciar una sesión en otra región de {{site.data.keyword.containershort_notm}} por las siguientes razones:
   -   Ha creado servicios de {{site.data.keyword.Bluemix_notm}} o imágenes de Docker privadas en una región y desea utilizarlos con {{site.data.keyword.containershort_notm}} en otra región.
   -   Desea acceder a un clúster de una región distinta de la región de {{site.data.keyword.Bluemix_notm}} predeterminada en la que ha iniciado la sesión. <br>
Elija entre los siguientes puntos finales de API:
        - EE.UU. Sur:
          ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
          {: pre}

        - UK-Sur: 
          ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
          {: pre}

        - UE-Central:
          ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
          {: pre}

        - AP Sur:
          ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
          {: pre}

4.  Obtenga una lista de todos los clústeres de la cuenta para obtener el nombre del clúster.

    ```
    bx cs clusters
    ```
    {: pre}

5.  Defina el clúster que ha creado como contexto para esta sesión. Siga estos pasos de configuración cada vez que de trabaje con el clúster.
    1.  Obtenga el mandato para establecer la variable de entorno y descargar los archivos de configuración de Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Después de descargar los archivos de configuración, se muestra un mandato que puede utilizar para establecer la vía de acceso al archivo de configuración de
Kubernetes local como variable de entorno. 

        Ejemplo:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  Copie y pegue el mandato que se muestra en el terminal para definir la variable de entorno `KUBECONFIG`.
    3.  Compruebe que la variable de entorno `KUBECONFIG` se haya establecido correctamente.

        Ejemplo:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Salida:
        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

6.  Compruebe que los mandatos `kubectl` se ejecutan correctamente con el clúster comprobando la versión del cliente de la CLI de Kubernetes.

    ```
    kubectl version  --short
    ```
    {: pre}

    Salida de ejemplo:

    ```
    Client Version: v1.5.6
    Server Version: v1.5.6
    ```
    {: screen}


Ahora puede ejecutar mandatos `kubectl` para gestionar sus clústeres en {{site.data.keyword.Bluemix_notm}}. Para ver una lista completa de mandatos, consulte la [documentación de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).

**Sugerencia:** Si utiliza Windows y la CLI de Kubernetes no está instalada en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}, debe cambiar los directorios por la vía de acceso donde está instalada la CLI de Kubernetes para poder ejecutar correctamente los mandatos `kubectl`.

## Actualización de la CLI
{: #cs_cli_upgrade}

Quizás desee actualizar las CLI periódicamente para usar nuevas funciones.
{:shortdesc}

Esta tarea incluye la información para actualizar estas CLI.

-   {{site.data.keyword.Bluemix_notm}} CLI versión 0.5.0 o posterior
-   Plug-in de {{site.data.keyword.containershort_notm}} 
-   CLI de Kubernetes versión 1.5.6 o posterior
-   Plug-in de {{site.data.keyword.registryshort_notm}} 
-   Docker versión 1.9. o posterior

<br>
Para actualizar las CLI:
1.  Actualice la CLI de {{site.data.keyword.Bluemix_notm}}. Descargue la [versión más reciente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://clis.ng.bluemix.net/ui/home.html) y ejecute el instalador.

2.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Escriba
sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite.

    ```
    bx login
    ```
     {: pre}

    Para especificar una región de {{site.data.keyword.Bluemix_notm}} concreta, incluya el punto final de la API. Si tiene imágenes de Docker privadas almacenadas en el registro de contenedor de una región {{site.data.keyword.Bluemix_notm}} concreta o instancias de servicio {{site.data.keyword.Bluemix_notm}} que ya ha creado, inicie la sesión en esta región para acceder a las imágenes y servicios de {{site.data.keyword.Bluemix_notm}}.

    La región de {{site.data.keyword.Bluemix_notm}} en la que inicie la sesión también determina la región donde puede crear los clústeres de Kubernetes, incluidos los centros de datos disponibles. Si no especifica ninguna región, la sesión se iniciará automáticamente en la región más cercana. 

    -   EE.UU. Sur

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

    -   Sídney

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -   Alemania

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -   Reino Unido

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

        **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar
la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.

3.  Actualice el plug-in de {{site.data.keyword.containershort_notm}}.
    1.  Instale la actualización desde el repositorio del plug-in de {{site.data.keyword.Bluemix_notm}}. 

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Para verificar la instalación del plug-in, ejecute el mandato siguiente
y compruebe la lista de plug-ins instalados.

        ```
        bx plugin list
        ```
        {: pre}

        El plug-in {{site.data.keyword.containershort_notm}} se visualiza en los resultados como servicio de contenedor. 

    3.  Inicialice la CLI.

        ```
        bx cs init
        ```
        {: pre}

4.  Actualice la CLI de Kubernetes.
    1.  Descargue la CLI de Kubernetes.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Sugerencia:** Si utiliza Windows, instale la CLI de Kubernetes en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}. Esta configuración le ahorra algunos cambios en filepath cuando ejecute mandatos posteriormente.

    2.  Para usuarios de OSX y Linux, siga los pasos siguientes:
        1.  Mueva el archivo ejecutable al directorio /usr/local/bin. 

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Asegúrese de que `/usr/local/bin` aparezca en la variable del sistema `PATH`. La variable `PATH` contiene todos los directorios en los que el sistema operativo puede encontrar archivos ejecutables. Los directorios que se muestran en la variable `PATH` sirven para distintos propósitos. `/usr/local/bin` se utiliza para guardar archivos ejecutables correspondientes a software que no forma parte del sistema operativo y que ha instalado manualmente el administrador del sistema.

            ```
            echo $PATH
            ```
            {: pre}

            Ejemplo de salida de CLI:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Convierta el archivo binario en un ejecutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Actualice el plug-in de {{site.data.keyword.registryshort_notm}}.
    1.  Instale la actualización desde el repositorio del plug-in de {{site.data.keyword.Bluemix_notm}}. 

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Para verificar la instalación del plug-in, ejecute el mandato siguiente
y compruebe la lista de plug-ins instalados.

        ```
        bx plugin list
        ```
        {: pre}

        El plug-in de registro se muestra en los resultados como container-registry.

6.  Actualice Docker.
    -   Si utiliza Docker Community Edition, inicie Docker, pulse el icono **Docker** y pulse **Comprobar si hay actualizaciones**.
    -   Si está utilizando Docker Toolbox, descargue la [versión más reciente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.docker.com/products/docker-toolbox) y ejecute el instalador.

## Desinstalación de la CLI
{: #cs_cli_uninstall}

Si ya no necesita una CLI, puede desinstalarla.
{:shortdesc}

Esta tarea incluye la información para eliminar estas CLI:


-   Plug-in de {{site.data.keyword.containershort_notm}} 
-   CLI de Kubernetes versión 1.5.6 o posterior
-   Plug-in de {{site.data.keyword.registryshort_notm}} 
-   Docker versión 1.9. o posterior

<br>
Para desinstalar las CLI:

1.  Desinstalar el plug-in de {{site.data.keyword.containershort_notm}}.

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  Desinstalar el plug-in de {{site.data.keyword.registryshort_notm}}.

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  Para verificar la desinstalación de los plug-ins, ejecute el mandato siguiente y compruebe la lista de plug-ins de instalados.

    ```
    bx plugin list
    ```
    {: pre}

    El servicio de contenedor y el plug-in de servicio de contenedor no se muestran en los resultados.






6.  Desinstalar Docker. Las instrucciones para desinstalar Docker varían en función del sistema operativo utilizado.

    <table summary="Instrucciones específicas del SO para desinstalar Docker">
     <tr>
      <th>Sistema operativo</th>
      <th>Enlace</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>Elija si desea desinstalar Docker desde la [GUI o la línea de mandatos ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset)</td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>Las instrucciones para desinstalar Docker varían en función de la distribución Linux utilizada. Para desinstalar Docker para Ubuntu, consulte [Desinstalar Docker ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce). Utilice este enlace para encontrar las instrucciones para desinstalar Docker para otras distribuciones Linux seleccionando la correspondiente distribución en la navegación.</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>Desinstale [Docker Toolbox ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox).</td>
      </tr>
    </table>

## Automatización de despliegues de clústeres con la API
{: #cs_api}

Puede utilizar la API de {{site.data.keyword.containershort_notm}} para automatizar la creación, el despliegue y la gestión de clústeres de Kubernetes.
{:shortdesc}

La API de {{site.data.keyword.containershort_notm}} precisa de información de cabecera que debe proporcionar en su solicitud de la API y que depende del tipo de API utilizado. Para determinar la información de cabecera que se necesita para la API, consulte la [{{site.data.keyword.containershort_notm}} documentación de la API ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://us-south.containers.bluemix.net/swagger-api).

En los siguientes pasos se proporcionan las instrucciones para recuperar esta información de cabecera, de forma que la pueda incluir en su solicitud de API.

1.  Recupere su señal de acceso de IAM (Identity and Access Management). La señal de acceso de IAM se necesita para iniciar una sesión en {{site.data.keyword.containershort_notm}}. Sustituya
_&lt;my_bluemix_username&gt;_ y _&lt;my_bluemix_password&gt;_ por las credenciales de {{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Input parameters to get tokens">
      <tr>
        <th>Parámetros de entrada</th>
        <th>Valores</th>
      </tr>
      <tr>
        <td>Cabecera</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>Cuerpo</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:</li></ul>
        <p>**Nota:** Añada la clave uaa_client_secret sin especificar ningún valor. </p></td>
      </tr>
    </table>

    Ejemplo de salida de API:

    ```
    {
    "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    Encontrará la señal de IAM en el campo **access_token**, y una señal UAA en el campo **uaa_token** de la salida de la API. Anote la señal IAM y la señal UAA para recuperar información de cabecera adicional en los pasos siguientes.

2.  Recupere el ID de la cuenta de {{site.data.keyword.Bluemix_notm}} en la que desea crear y gestionar los clústeres. Sustituya _&lt;iam_token&gt;_ por la señal de IAM que ha recuperado en el paso anterior.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="Parámetros de entrada para obtener el ID de cuenta de Bluemix">
   <tr>
    <th>Parámetros de entrada</th>
    <th>Valores</th>
   </tr>
   <tr>
    <td>Cabeceras</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
   </tr>
    </table>

    Ejemplo de salida de API:

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<my_bluemix_account_id>",
            "url": "/v1/accounts/<my_bluemix_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    Encontrará el ID de la cuenta de {{site.data.keyword.Bluemix_notm}} en el campo **metadatos/guid** de la salida de la API.

3.  Recupere una nueva señal de IAM que incluye su información de cuenta de {{site.data.keyword.Bluemix_notm}}. Sustituya
_&lt;my_bluemix_account_id&gt;_ por el ID de la cuenta de {{site.data.keyword.Bluemix_notm}} que ha recuperado en el paso anterior.

    **Nota:** Las señales de acceso a IAM caducan transcurrida 1 hora. Consulte el apartado sobre [Renovación de la señal de acceso a IAM con la API](#cs_api_refresh) para ver instrucciones sobre cómo renovar la señal de acceso. 

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Parámetros de entrada para obtener señales de acceso">
     <tr>
      <th>Parámetros de entrada</th>
      <th>Valores</th>
     </tr>
     <tr>
      <td>Cabeceras</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>Cuerpo</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Nota:** Añada la clave uaa_client_secret sin especificar ningún valor. </p>
        <li>bss_account: <em>&lt;my_bluemix_account_id&gt;</em></li></ul></td>
     </tr>
    </table>

    Ejemplo de salida de API:

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    ```
    {: screen}

    Encontrará la señal de IAM en el campo **access_token**, y la señal de renovación de IAM en el campo **refresh_token** de la salida de la CLI.

4.  Recupere el ID del espacio de {{site.data.keyword.Bluemix_notm}} en el que desea crear o gestionar el clúster.
    1.  Recupere el punto final de la API para acceder a su ID de espacio. Sustituya _&lt;uaa_token&gt;_ con la señal de UAA que recuperó en el primer paso.

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="Parámetros de entrada para recuperar el ID de espacio">
         <tr>
          <th>Parámetros de entrada</th>
          <th>Valores</th>
         </tr>
         <tr>
          <td>Cabecera</td>
          <td><ul><li>Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa_token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      Ejemplo de salida de API:

      ```
      {
            "metadata": {
              "guid": "<my_bluemix_org_id>",
              "url": "/v2/organizations/<my_bluemix_org_id>",
              "created_at": "2016-01-07T18:55:19Z",
              "updated_at": "2016-02-09T15:56:22Z"
            },
            "entity": {
              "name": "<my_bluemix_org_name>",
              "billing_enabled": false,
              "quota_definition_guid": "<my_bluemix_org_id>",
              "status": "active",
              "quota_definition_url": "/v2/quota_definitions/<my_bluemix_org_id>",
              "spaces_url": "/v2/organizations/<my_bluemix_org_id>/spaces",
      ...

      ```
      {: screen}

5.  Anote la salida del campo **spaces_url**.
6.  Recupere el ID del espacio de {{site.data.keyword.Bluemix_notm}} utilizando el punto final **spaces_url**.

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<my_bluemix_org_id>/spaces
      ```
      {: pre}

      Ejemplo de salida de API:

      ```
      {
            "metadata": {
              "guid": "<my_bluemix_space_id>",
              "url": "/v2/spaces/<my_bluemix_space_id>",
              "created_at": "2016-01-07T18:55:22Z",
              "updated_at": null
            },
            "entity": {
              "name": "<my_bluemix_space_name>",
              "organization_guid": "<my_bluemix_org_id>",
              "space_quota_definition_guid": null,
              "allow_ssh": true,
      ...
      ```
      {: screen}

      Encontrará el ID del espacio de {{site.data.keyword.Bluemix_notm}} en el campo **metadatos/guid** de la salida de la API.

7.  Obtenga una lista de todos los clústeres de Kubernetes de la cuenta. Utilice la información que ha recuperado en pasos anteriores para crear la información de cabecera.

    -   EE.UU. Sur

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   UK-Sur

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   UE-Central

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   AP Sur

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

        <table summary="Parámetros de entrada para trabajar con la API">
         <thead>
          <th>Parámetros de entrada</th>
          <th>Valores</th>
         </thead>
          <tbody>
         <tr>
          <td>Cabecera</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  Consulte la [{{site.data.keyword.containershort_notm}} documentación de la API ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://us-south.containers.bluemix.net/swagger-api) para ver una lista de las API admitidas. 

## Renovación de señales de acceso de IAM
{: #cs_api_refresh}

Cada señal de acceso de IAM (Identity and Access Management) que se emite mediante la API caduca transcurrida una hora. Debe renovar la señal de acceso de forma periódica para garantizar el acceso a la API de {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Antes de empezar, asegúrese de que tiene una señal de renovación de IAM que puede utilizar para solicitar una nueva señal de acceso. Si no tiene una señal de renovación, consulte [Automatización del proceso de creación y gestión de clústeres con la API de {{site.data.keyword.containershort_notm}}](#cs_api) para recuperar la señal de acceso.

Siga los pasos siguientes si desea renovar sus señales de acceso de IAM.

1.  Recupere una nueva señal de acceso de IAM. Sustituya _&lt;iam_refresh_token&gt;_ por la señal de renovación de IAM que recibió la primera vez que se autenticó en {{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Parámetros de entrada para una nueva señal de IAM">
     <tr>
      <th>Parámetros de entrada</th>
      <th>Valores</th>
     </tr>
     <tr>
      <td>Cabecera</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>Cuerpo</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Nota:** Añada la clave uaa_client_secret sin especificar ningún valor. </p></li><ul></td>
     </tr>
    </table>

    Ejemplo de salida de API:

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    ```
    {: screen}

    Encontrará la nueva señal de IAM en el campo **access_token**, y la señal de renovación de IAM en el campo **refresh_token** de la salida de la API.

2.  Siga trabajando con la [{{site.data.keyword.containershort_notm}} documentación de la API ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://us-south.containers.bluemix.net/swagger-api) utilizando la señal del paso anterior.

