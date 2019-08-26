---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}



# Guía de aprendizaje: Creación de clústeres de Kubernetes
{: #cs_cluster_tutorial}

Con esta guía de aprendizaje podrá desplegar y gestionar un clúster de Kubernetes en {{site.data.keyword.containerlong}}. Haga el seguimiento de una empresa ficticia de relaciones públicas para aprender a automatizar el despliegue, la operación, el escalado y la supervisión de apps contenerizadas en un clúster que se integra con otros servicios de nube, como por ejemplo {{site.data.keyword.ibmwatson}}.
{:shortdesc}

## Objetivos
{: #tutorials_objectives}

En esta guía de aprendizaje, puede trabajar para una empresa de relaciones públicas (PR) y completar una serie de lecciones para establecer y configurar un entorno de clúster de Kubernetes personalizado. En primer lugar, configure la CLI de {{site.data.keyword.cloud_notm}}, cree un clúster de {{site.data.keyword.containershort_notm}} y almacene las imágenes de su empresa de relaciones públicas en un {{site.data.keyword.registrylong}} privado. A continuación, puede suministrar un servicio {{site.data.keyword.toneanalyzerfull}} y enlazarlo con el clúster. Después de desplegar y probar una app Hello World en el clúster, despliega progresivamente más versiones complejas y de alta disponibilidad de la app de {{site.data.keyword.watson}} para que la empresa de relaciones públicas pueda analizar los comunicados de prensa y recibir comentarios con la última tecnología de IA.
{:shortdesc}

El diagrama siguiente muestra una visión general de lo que se configura en esta guía de aprendizaje.

<img src="images/tutorial_ov.png" width="500" alt="diagrama de visión general para crear un clúster y desplegar una app Watson" style="width:500px; border-style: none"/>

## Tiempo necesario
{: #tutorials_time}

60 minutos


## Público
{: #tutorials_audience}

Esta guía de aprendizaje está destinada a los desarrolladores de software y administradores del sistema que crean un clúster de Kubernetes y despliegan una app por primera vez.
{: shortdesc}

## Requisitos previos
{: #tutorials_prereqs}

-  Consulte los pasos que debe llevar a cabo para [prepararse para crear un clúster](/docs/containers?topic=containers-clusters#cluster_prepare).
-  Asegúrese de tener las políticas de acceso siguientes:
    - El [rol de plataforma **Administrador** de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para {{site.data.keyword.containerlong_notm}}
    - El [rol de plataforma **Administrador** de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para {{site.data.keyword.registrylong_notm}}
    - El [rol de servicio **Escritor** o **Gestor** de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre {{site.data.keyword.containerlong_notm}}

## Lección 1: Configuración del entorno de clúster
{: #cs_cluster_tutorial_lesson1}

Cree el clúster de Kubernetes en la consola de {{site.data.keyword.Bluemix_notm}}, instale las CLI necesarias, configure el registro de contenedor y establezca el contexto para el clúster de Kubernetes en la CLI.
{: shortdesc}

Puesto que el suministro puede tardar unos minutos, cree el clúster antes de configurar el resto del entorno de clúster.

1.  [En la consola de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/kubernetes/catalog/cluster/create), cree un clúster gratuito o estándar con una agrupación de nodos trabajadores que contenga un nodo trabajador.

    También puede crear un [clúster en la CLI](/docs/containers?topic=containers-clusters#clusters_cli_steps).
    {: tip}
2.  Mientras se suministra su clúster, instale la [CLI de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](/docs/cli?topic=cloud-cli-getting-started). Esta instalación incluye:
    -   La CLI base de {{site.data.keyword.Bluemix_notm}} (`ibmcloud`).
    -   El plugin de {{site.data.keyword.containerlong_notm}} en (`ibmcloud ks`). Utilice este plug-in para gestionar los clústeres de Kubernetes, como por ejemplo, para cambiar el tamaño de las agrupaciones de nodos trabajadores para aumentar la capacidad de cálculo o para enlazar los servicios de {{site.data.keyword.Bluemix_notm}} con el clúster.
    -   El plugin {{site.data.keyword.registryshort_notm}} (`ibmcloud cr`). Utilice este plugin para configurar y gestionar un repositorio de imágenes privadas en {{site.data.keyword.registryshort_notm}}.
    -   La CLI de Kubernetes (`kubectl`). Utilice esta CLI para desplegar y gestionar recursos de Kubernetes, como por ejemplo pods y servicios de la app.

    Si en su lugar desea utilizar la consola de {{site.data.keyword.Bluemix_notm}} después de crear el clúster, puede ejecutar mandatos de CLI directamente desde el navegador web en [Kubernetes Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web).
    {: tip}
3.  En el terminal, inicie sesión en la cuenta de {{site.data.keyword.Bluemix_notm}}. Escriba
sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite. Si tiene un ID federado, utilice el distintivo `--sso` para iniciar la sesión. Seleccione la región y, si procede, seleccione como destino el grupo de recursos (`-g`) en el que ha creado el clúster.
    ```
    ibmcloud login [-g <resource_group>] [--sso]
    ```
    {: pre}
5.  Verifique que los plugins están instalados correctamente.
    ```
    ibmcloud plugin list
    ```
    {: pre}

    El plugin {{site.data.keyword.containerlong_notm}} se visualiza en los resultados como **kubernetes-service** y el plugin
{{site.data.keyword.registryshort_notm}} se visualiza en los resultados como **container-registry**.
6.  Configure su propio repositorio de imágenes privadas en {{site.data.keyword.registryshort_notm}} para almacenar y compartir de forma segura imágenes de Docker con todos los usuarios del clúster. Un repositorio privado en {{site.data.keyword.Bluemix_notm}} se identifica mediante un espacio de nombres. El espacio de nombres sirve para crear un URL exclusivo para el repositorio privado que los desarrolladores pueden utilizar para acceder a las imágenes de Docker.
    Obtenga más información sobre cómo [proteger su información personal](/docs/containers?topic=containers-security#pi) cuando se trabaja con imágenes de contenedor.

    En este ejemplo, la empresa PR desea crear un solo repositorio de imágenes en {{site.data.keyword.registryshort_notm}}, por lo que eligen `pr_firm` como el espacio de nombres para agrupar todas las imágenes de la cuenta. Sustituya `<namespace>` por un espacio de nombres de su elección que no esté relacionado con la guía de aprendizaje.

    ```
    ibmcloud cr namespace-add <namespace>
    ```
    {: pre}
7.  Antes de continuar con el paso siguiente, verifique que el despliegue del nodo trabajador se ha completado.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Cuando el suministro del nodo trabajador finaliza, el estado pasa a **Preparado** y puede empezar a enlazar servicios de {{site.data.keyword.Bluemix_notm}}.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.13.8
    ```
    {: screen}
8.  Establezca el contexto para el clúster de Kubernetes en la CLI.
    1.  Obtenga el mandato para establecer la variable de entorno y descargar los archivos de configuración de Kubernetes. Cada vez que inicie la sesión en la CLI de {{site.data.keyword.containerlong}} para trabajar con clústeres, deberá ejecutar estos mandatos para establecer el archivo de configuración del clúster como una variable de la sesión. La CLI de Kubernetes utiliza esta variable para buscar un archivo de configuración local y los certificados necesarios para conectar con el clúster en {{site.data.keyword.Bluemix_notm}}.<p class="tip">¿Utiliza PowerShell de Windows? Incluya el distintivo `--powershell` para obtener las variables de entorno en formato de PowerShell de Windows.</p>
        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Cuando termine la descarga de los archivos de configuración, se muestra un mandato que puede utilizar para establecer la vía de acceso al archivo de configuración de
Kubernetes como variable de entorno.

        Ejemplo para OS X:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/    pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}
    2.  Copie y pegue el mandato que se muestra en el terminal para definir la variable de entorno `KUBECONFIG`.
    3.  Compruebe que la variable de entorno `KUBECONFIG` se haya establecido correctamente.

        Ejemplo para OS X:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Salida de ejemplo:

        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Compruebe que los mandatos `kubectl` se ejecutan correctamente con el clúster comprobando la versión del cliente de la CLI de Kubernetes.
        ```
        kubectl version  --short
        ```
        {: pre}

        Salida de ejemplo:

        ```
        Cliente versión: v1.13.8
    Servidor Versión: v1.13.8
        ```
        {: screen}

¡Buen trabajo! Ha instalado correctamente las CLI y ha configurado el contexto de clúster para las lecciones siguientes. A continuación, configure el entorno de clúster y añada el servicio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.

<br />


## Lección 2: Adición de un servicio de IBM Cloud a su clúster
{: #cs_cluster_tutorial_lesson2}

Con los servicios de {{site.data.keyword.Bluemix_notm}}, puede aprovechar la funcionalidad ya desarrollada de sus apps. Cualquier servicio de {{site.data.keyword.Bluemix_notm}} que esté enlazado al clúster de Kubernetes puede ser utilizado por cualquier app desplegada en ese clúster. Repita los pasos siguientes para cada servicio de {{site.data.keyword.Bluemix_notm}} que desee utilizar con sus apps.
{: shortdesc}

1.  Añada el servicio {{site.data.keyword.toneanalyzershort}} a su cuenta de {{site.data.keyword.Bluemix_notm}} en la misma región que el clúster. Sustituya `<service_name>` por un nombre para la instancia de servicio y `<region>` por una región, como la que se encuentra en el clúster.

    Cuando añada el servicio {{site.data.keyword.toneanalyzershort}} a su cuenta, se visualizará un mensaje que indica que el servicio no es gratuito. Si limita la llamada a la API, en esta guía de aprendizaje no se incurre en ningún cargo por el servicio {{site.data.keyword.watson}}. [Revise la información sobre precios correspondientes al servicio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/catalog/services/tone-analyzer).
    {: note}

    ```
    ibmcloud resource service-instance-create <service_name> tone-analyzer standard <region>
    ```
    {: pre}
2.  Vincule la instancia de {{site.data.keyword.toneanalyzershort}} al espacio de nombres `default` de Kubernetes correspondiente al clúster. Luego podrá crear sus propios espacios de nombres para gestionar el acceso de los usuarios a los recursos de Kubernetes, pero por ahora utilice el espacio de nombres `default`. Los espacios de nombres de Kubernetes son diferentes del espacio de nombres del registro que ha creado anteriormente.
    ```
    ibmcloud ks cluster-service-bind --cluster <cluster_name> --namespace default --service <service_name>
    ```
    {: pre}

    Salida de ejemplo:
    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}
3.  Verifique que el secreto de Kubernetes se ha creado en el espacio de nombres del clúster. Cuando [enlaza un servicio {{site.data.keyword.Bluemix_notm}} con el clúster](/docs/containers?topic=containers-service-binding), se genera un archivo JSON que incluye información confidencial como la clave de API de {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) y el URL que utiliza el contenedor para acceder al servicio. Para almacenar esta información de forma segura, el archivo JSON se almacena en un secreto de Kubernetes.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Salida de ejemplo:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
¡Buen trabajo! El clúster está configurado y su entorno local está listo para que inicie el despliegue de apps en el clúster.

Antes de continuar con la lección siguiente, ¿por qué no probar sus conocimientos y [hacer un breve cuestionario ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)?
{: note}

<br />


## Lección 3: Despliegue de apps de una sola instancia en clústeres de Kubernetes
{: #cs_cluster_tutorial_lesson3}

En la lección anterior, ha configurado un clúster con un nodo trabajador. En esta lección, configurará un despliegue y desplegará una única instancia de la app en un pod de Kubernetes dentro del nodo trabajador.
{:shortdesc}

Los componentes que desplegará al completar esta lección se muestran en el siguiente diagrama.

![Configuración del despliegue](images/cs_app_tutorial_mz-components1.png)

Para desplegar la app:

1.  Clone el código fuente de la [app Hello world ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/IBM/container-service-getting-started-wt) en el directorio inicial de su usuario. El repositorio contiene distintas versiones de una app similar en carpetas que se que empiezan por `Lab`. Cada versión contiene los siguientes archivos:
    *   `Dockerfile`: las definiciones de compilación para la imagen.
    *   `app.js`: la app Hello world.
    *   `package.json`: metadatos sobre la app.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

2.  Vaya al directorio `Lab 1`.
    ```
    cd 'container-service-getting-started-wt/Lab 1'
    ```
    {: pre}
3.  Inicie la sesión en la CLI de {{site.data.keyword.registryshort_notm}}.
    ```
    ibmcloud cr login
    ```
    {: pre}

    Si ha olvidado el espacio de nombres de {{site.data.keyword.registryshort_notm}}, ejecute el mandato siguiente.
    ```
    ibmcloud cr namespace-list
    ```
    {: pre}
4.  Cree una imagen de Docker que incluya los archivos de app del directorio `Lab 1` y traslade la imagen al espacio de nombres {{site.data.keyword.registryshort_notm}} que ha creado en la lección anterior. Si tiene que realizar un cambio en la app en el futuro, repita estos pasos para crear otra versión de la imagen. **Nota**: Obtenga más información sobre cómo [proteger su información personal](/docs/containers?topic=containers-security#pi) cuando se trabaja con imágenes de contenedor.

    Utilice caracteres alfanuméricos en minúscula o guiones bajos (`_`) solo en el nombre de imagen. No olvide el punto (`.`) al final del mandato. El punto indica a Docker que debe buscar el Dockerfile y crear artefactos para crear la imagen dentro del directorio actual. **Nota**: Debe especificar una [región de registro](/docs/services/Registry?topic=registry-registry_overview#registry_regions), como por ejemplo `us`. Para obtener la región de registro en la que se encuentra actualmente, ejecute `ibmcloud cr region`.

    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:1 .
    ```
    {: pre}

    Cuando finalice la compilación, compruebe que aparece el siguiente mensaje de éxito:

    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
5.  Cree un despliegue. Los despliegues se utilizan para gestionar pods, lo que incluye instancias contenerizadas de una app. El mandato siguiente despliega la app en un solo pod haciendo referencia a la imagen que ha creado en su registro privado. Para los efectos de esta guía, el despliegue se denomina despliegue **hello-world-deployment**, pero puede darle al despliegue cualquier nombre que desee.
    ```
    kubectl create deployment hello-world-deployment --image=<region>.icr.io/<namespace>/hello-world:1
    ```
    {: pre}

    Salida de ejemplo:
    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Obtenga más información sobre cómo [proteger su información personal](/docs/containers?topic=containers-security#pi) cuando se trabaja recursos de Kubernetes.
6.  Facilite el acceso general a la app exponiendo el despliegue como un servicio NodePort. Al igual que expone un puerto para una app Cloud Foundry, el NodePort que expone es el puerto en el que el nodo trabajador escucha si hay tráfico.
    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Salida de ejemplo:
    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table summary="Información sobre la exposición de parámetros de mandato.">
    <caption>Más información acerca de los parámetros de exposición</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Más información acerca de los parámetros de exposición</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Exponer un recurso como un servicio Kubernetes y difundirlo públicamente a los usuarios.</td>
    </tr>
    <tr>
    <td><code>deployment/<em>&lt;hello-world-deployment&gt;</em></code></td>
    <td>El tipo de recurso y el nombre del recurso para exponer con este servicio.</td>
    </tr>
    <tr>
    <td><code>--name=<em>&lt;hello-world-service&gt;</em></code></td>
    <td>El nombre del servicio.</td>
    </tr>
    <tr>
    <td><code>--port=<em>&lt;8080&gt;</em></code></td>
    <td>El puerto en el que el servicio sirve.</td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>El tipo de servicio a crear.</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>El puerto al que el servicio dirige el tráfico. En esta instancia, el destino-puerto es el mismo que el puerto, pero otras apps que cree pueden ser distintas.</td>
    </tr>
    </tbody></table>
7. Ahora que ya se ha realizado todo el trabajo de despliegue, puede probar la app en un navegador. Obtenga los detalles para formar el URL.
    1.  Obtenga información acerca del servicio para ver qué NodePort se ha asignado.
        ```
        kubectl describe service hello-world-service
        ```
        {: pre}

        Salida de ejemplo:
        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.xxx.xx.xxx
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.xxx.xxx:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Los
NodePorts se asignan aleatoriamente cuando se generan con el mandato `expose`, pero
dentro del rango 30000-32767. En este ejemplo, el NodePort es 30872.
    2.  Obtenga la dirección IP pública del nodo trabajador en el clúster.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Salida de ejemplo:
        ```
        ibmcloud ks workers --cluster pr_firm_cluster
        Listing cluster workers...
        OK
        ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
        kube-mil01-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.13.8
        ```
        {: screen}
8. Abra un navegador y compruebe la app con el siguiente URL: `http://<IP_address>:<NodePort>`. Con los valores de ejemplo, el URL es `http://169.xx.xxx.xxx:30872`. Cuando escriba
dicho URL en un navegador, verá un mensaje parecido al siguiente.
    ```
    Hello world! Your app is up and running in a cluster!
    ```
    {: screen}

    Para ver que la app está disponible públicamente, intente entrar en ella con un navegador en su teléfono móvil.
    {: tip}
9. [Inicie el panel de control de Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).

    Si selecciona su clúster en la [consola de {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/), utilice el botón del **Panel de control de Kubernetes** para iniciar el panel de control con una pulsación.
    {: tip}
10. En el separador **Cargas de trabajo**, verá los recursos que ha creado.

¡Buen trabajo! Ha desplegado su primera versión de la app.

¿Ha utilizado demasiados mandatos en esta lección? Es cierto. ¿Qué le parece si ahora utilizamos un script de configuración para realizar automáticamente parte del trabajo? Para utilizar un script de configuración para la segunda versión de la app y para aumentar la disponibilidad desplegando varias instancias de dicha app, continúe en la lección siguiente.

**Limpieza**<br>
¿Desea suprimir los recursos que ha creado en esta lección antes de continuar? Cuando ha creado el despliegue, Kubernetes ha asignado el despliegue a una etiqueta, `app=hello-world-deployment` (o cualquier otro nombre que haya asignado al despliegue). A continuación, cuando expuso el despliegue, Kubernetes aplicó la misma etiqueta al servicio que se ha creado. Las etiquetas son herramientas útiles para organizar los recursos de Kubernetes para que pueda aplicar acciones a gran escala como `get` o `delete` para ellos.

  Puede comprobar todos los recursos que tienen la etiqueta `app=hello-world-deployment`.
  ```
  kubectl get all -l app=hello-world-deployment
  ```
  {: pre}

  A continuación, puede suprimir todos los recursos con la etiqueta.
  ```
  kubectl delete all -l app=hello-world-deployment
  ```
  {: pre}

  Salida de ejemplo:
  ```
  pod "hello-world-deployment-5c78f9b898-b9klb" deleted
  service "hello-world-service" deleted
  deployment.apps "hello-world-deployment" deleted
  ```
  {: screen}

<br />


## Lección 4: Despliegue y actualización de apps con mayor disponibilidad
{: #cs_cluster_tutorial_lesson4}

En esta lección, desplegará tres instancias de la app Hello World en un clúster para aumentar la disponibilidad con respecto a la primera versión de la app.
{:shortdesc}

Mayor disponibilidad significa que el acceso de usuario se divide entre las tres instancias. Cuando hay demasiados usuarios que intentan acceder a la misma instancia de la app, es posible que el tiempo de respuesta sea lento. Varias instancias puede significar mejores tiempos de respuesta para los usuarios. En esta lección, también aprenderá cómo funcionan las comprobaciones de estado y las actualizaciones de despliegue con Kubernetes. El siguiente diagrama incluye los componentes que desplegará al completar esta lección.

![Configuración del despliegue](images/cs_app_tutorial_mz-components2.png)

En las lecciones anteriores, ha creado el clúster con un nodo trabajador y ha desplegado una sola instancia de una app. En esta lección, debe configurar un despliegue y desplegar tres instancias de la app Hello World. Cada instancia se despliega en un pod de Kubernetes como parte de un conjunto de réplicas del nodo trabajador. Para hacerlo accesible a nivel público, puede crear un servicio Kubernetes.

Tal como se define en el script de configuración, Kubernetes puede utilizar una comprobación de disponibilidad para ver si un contenedor de un pod se está o no ejecutando. Por ejemplo, estas comprobaciones pueden detectar puntos muertos, en los que una app se está ejecutando pero no progresa. Reiniciar un contenedor que está en esta condición puede ayudar a mejorar la disponibilidad de la app a pesar de los errores. Luego Kubernetes utiliza una comprobación de preparación para ver si un contenedor está preparado para empezar de nuevo a aceptar tráfico. Se considera que un pod está preparado cuando su contenedor está preparado. Cuando el pod está preparado, se inicia de nuevo. En esta versión de la app, cada 15 segundos se agota el tiempo de espera de la app. Con una comprobación de estado configurada en el script de configuración, los contenedores se vuelven a crear si la comprobación de estado encuentra un problema con una app.

Si se ha tomado un descanso después de la última lección y ha iniciado un nuevo terminal, asegúrese de volver a iniciar la sesión en el clúster.

1.  En el terminal, acceda al directorio `Lab 2`.
    ```
    cd 'container-service-getting-started-wt/Lab 2'
    ```
    {: pre}
2.  Cree, etiquete y envíe por push la app como una imagen al espacio de nombres en {{site.data.keyword.registryshort_notm}}. No olvide el punto (`.`) al final del mandato.
    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:2 .
      ```
    {: pre}

    Verifique que aparece el mensaje de éxito.
    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
3.  En el directorio `Lab 2`, abra el archivo `healthcheck.yml` con un editor de texto. Este script de configuración combina unos pocos pasos de la lección anterior para crear un despliegue y un servicio al mismo tiempo. Los desarrolladores de apps de la empresa PR pueden utilizar estos scripts cuando se realizan actualizaciones o para solucionar problemas cuando se vuelven a crear los pods.
    1.  Actualice los detalles de la imagen en el espacio de nombres del registro privado.
        ```
        image: "<region>.icr.io/<namespace>/hello-world:2"
        ```
        {: codeblock}
    2.  En la sección **Despliegue**, anote el valor de `replicas`. El valor de réplicas indica el número de instancias de la app. Si se ejecutan tres instancias, la app tiene una mayor disponibilidad que si se utiliza una sola instancia.
        ```
        replicas: 3
        ```
        {: codeblock}
    3.  Observe que la prueba de actividad de HTTP comprueba el estado del contenedor cada 5 segundos.
        ```
        livenessProbe:
                    httpGet:
                      path: /healthz
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 5
        ```
        {: codeblock}
    4.  En la sección **Service**, anote el valor de `NodePort`. En lugar de generar un NodePort aleatorio como hizo en la lección anterior, puede especificar un puerto comprendido entre 30000 y 32767. En este ejemplo se utiliza el valor 30072.
4.  Vuelva a la CLI que ha utilizado para definir el contexto de clúster y ejecute el script de configuración. Cuando se hayan creado el despliegue y el servicio, la app estará disponible para que la vean los usuarios de la empresa PR.
    ```
    kubectl apply -f healthcheck.yml
    ```
    {: pre}

    Salida de ejemplo:
    ```
    deployment "hw-demo-deployment" created
  service "hw-demo-service" created
    ```
    {: screen}
5.  Una vez realizado todo el trabajo de despliegue, abra un navegador y compruebe la app. Para formar el URL, tome la misma dirección IP pública que ha utilizado en la lección anterior para el nodo trabajador y combínela con el NodePort especificado en el script de configuración. Para obtener la dirección IP pública para el nodo trabajador:
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Con los valores de ejemplo, el URL es `http://169.xx.xxx.xxx:30072`. En un navegador, es posible que vea el texto siguiente. Si no ve este texto, no se preocupe. Esta app está diseñado para ir hacia arriba y hacia abajo.
    ```
    Hello world! Great job getting the second stage up and running!
    ```
    {: screen}

    También puede consultar `http://169.xx.xxx.xxx:30072/healthz` para ver el estado.

    Durante los 10 - 15 primeros segundos, se devuelve un mensaje 200, que le indica que la app se está ejecutando correctamente. Transcurridos estos 15 segundos, aparece un mensaje de tiempo de espera excedido. Este es el comportamiento esperado.
    ```
    {
      "error": "Timeout, Health check error!"
  }
    ```
    {: screen}
6.  Compruebe el estado del pod para supervisar el estado de la app en Kubernetes. Puede comprobar el estado en la CLI o en el panel de control de Kubernetes.
    *   **Desde la CLI**: vea lo que sucede en los pods a medida que cambia su estado.
        ```
        kubectl get pods -o wide -w
        ```
        {: pre}
    *   **Desde el panel de control de Kubernetes**:
        1.  [Inicie el panel de control de Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).
        2.  En el separador **Cargas de trabajo**, verá los recursos que ha creado. Desde este separador, puede renovar continuamente y ver que la comprobación de estado funciona. En la sección **Pods**, puede ver el número de veces que se han reiniciado los pods cuando se vuelven a crear los contenedores que hay incluidos. Si recibe el siguiente error en el panel de control, este mensaje indica que la comprobación de estado ha detectado un problema. Espere unos minutos y vuelva a renovar. Verá el número de cambios de reinicio para cada pod.
        ```
        Liveness probe failed: HTTP probe failed with statuscode: 500
        Back-off restarting failed docker container
        Error syncing pod, skipping: failed to "StartContainer" for "hw-container" w      CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-d     deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
        ```
        {: screen}

Bien; ha desplegado la segunda versión de la app. Ha tenido que utilizar menos mandatos, ha visto cómo funcionan las comprobaciones de seguridad y ha editado un despliegue, lo cual no está nada mal. La app Hello world ha pasado la prueba para la empresa PR. Ahora puede desplegar una app más útil para que la empresa PR empiece a analizar notas de prensa.

**Limpieza**<br>
¿Está listo para suprimir lo que ha creado antes de continuar con la siguiente lección? Esta vez puede utilizar el mismo script de configuración para suprimir los recursos que ha creado.

  ```
  kubectl delete -f healthcheck.yml
  ```
  {: pre}

  Salida de ejemplo:

  ```
  deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
  ```
  {: screen}

<br />


## Lección 5: Despliegue y actualización de la app Watson Tone Analyzer
{: #cs_cluster_tutorial_lesson5}

En las lecciones anteriores, las apps se han desplegado como componentes únicos de un nodo trabajador. En esta lección, puede desplegar dos componentes de una app en un clúster que utiliza el servicio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.
{:shortdesc}

La separación de componentes en distintos contenedores garantiza que puede actualizar uno sin que afecte a los otros. A continuación, actualizará la app para ampliarla con más réplicas a fin de aumentar su disponibilidad. El siguiente diagrama incluye los componentes que desplegará al completar esta lección.

![Configuración del despliegue](images/cs_app_tutorial_mz-components3.png)

En la guía de aprendizaje anterior, ha creado una cuenta y un clúster con un nodo trabajador. En esta lección, creará una instancia del servicio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} en su cuenta de {{site.data.keyword.Bluemix_notm}} y configurará dos despliegues, uno para cada componente de la app. Cada componente se despliega en un pod de Kubernetes del nodo trabajador. Para hacerlos accesibles a nivel público, también puede crear un servicio Kubernetes para cada componente.


### Lección 5a: Despliegue de la app {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}
{: #lesson5a}

Despliegue las apps {{site.data.keyword.watson}}, acceda al servicio públicamente y analice parte del texto con la app.
{: shortdesc}

Si se ha tomado un descanso después de la última lección y ha iniciado un nuevo terminal, asegúrese de volver a iniciar la sesión en el clúster.

1.  En una CLI, vaya al directorio `Lab 3`.
    ```
    cd 'container-service-getting-started-wt/Lab 3'
    ```
    {: pre}

2.  Cree la primera imagen de {{site.data.keyword.watson}}.
    1.  Vaya al directorio `watson`.
        ```
        cd watson
        ```
        {: pre}
    2.  Cree, etiquete y envíe por push la app `watson` como una imagen al espacio de nombres en {{site.data.keyword.registryshort_notm}}. Como siempre, no olvide el punto (`.`) al final del mandato.
        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson .
        ```
        {: pre}

        Verifique que aparece el mensaje de éxito.
        ```
        Successfully built <image_id>
        ```
        {: screen}
    3.  Repita estos pasos para crear la segunda imagen de `watson-talk`.
        ```
        cd 'container-service-getting-started-wt/Lab 3/watson-talk'
        ```
        {: pre}

        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson-talk .
        ```
        {: pre}
3.  Compruebe que las imágenes se han añadido correctamente al espacio de nombres del registro.
    ```
    ibmcloud cr images
    ```
    {: pre}

    Salida de ejemplo:

    ```
    Listing images...

    REPOSITORY                        NAMESPACE  TAG      DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    us.icr.io/namespace/watson        namespace  latest   fedbe587e174   3 minutes ago   274 MB   OK
    us.icr.io/namespace/watson-talk   namespace  latest   fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}
4.  En el directorio `Lab 3`, abra el archivo `watson-deployment.yml` con un editor de texto. Este script de configuración incluye un despliegue y un servicio para los componentes `watson` y `watson-talk` de la app.
    1.  Actualice los detalles de la imagen en el espacio de nombres del registro para ambos despliegues.
        **watson**:
        ```
        image: "<region>.icr.io/<namespace>/watson"
        ```
        {: codeblock}

        **watson-talk**:
        ```
        image: "<region>.icr.io/<namespace>/watson-talk"
        ```
        {: codeblock}
    2.  En la sección de volúmenes del despliegue `watson-pod`, actualice el nombre del secreto {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} que ha creado en la [Lección 2](#cs_cluster_tutorial_lesson2). Al montar el secreto de Kubernetes como un volumen en el despliegue, establecerá la clave de API de
{{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) como disponible para el contenedor que se ejecuta en el pod. Los componentes
de la app {{site.data.keyword.watson}} de esta guía de aprendizaje están configurados para buscar la clave de API utilizando la vía de acceso de montaje del volumen.
        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-mytoneanalyzer
        ```
        {: codeblock}

        Si ha olvidado cómo llamó al secreto, ejecute el siguiente mandato:
        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}
    3.  En la sección del servicio watson-talk, anote el valor definido para el `NodePort`. En este ejemplo se utiliza 30080.
5.  Ejecute el script de configuración.
    ```
    kubectl apply -f watson-deployment.yml
    ```
    {: pre}
6.  Opcional: Compruebe que el secreto de {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} se haya montado como volumen en el pod.
    1.  Para obtener el nombre de un pod de watson, ejecute el siguiente mandato:
        ```
        kubectl get pods
        ```
        {: pre}

        Salida de ejemplo:
        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}
    2.  Obtenga los detalles del pod y busque el nombre del secreto.
        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

        Salida de ejemplo:
        ```
        Volumes:
          service-bind-volume:
            Type:       Secret (a volume populated by a Secret)
            SecretName: binding-mytoneanalyzer
          default-token-j9mgd:
            Type:       Secret (a volume populated by a Secret)
            SecretName: default-token-j9mgd
        ```
        {: codeblock}
7.  Abra un navegador y analice parte del texto. El formato del URL es `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"`.
    Ejemplo:
    ```
    http://169.xx.xxx.xxx:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    En un navegador, puede ver la respuesta JSON para el texto especificado.
    ```
    {
      "document_tone": {
        "tone_categories": [
          {
            "tones": [
              {
                "score": 0.011593,
                "tone_id": "anger",
                "tone_name": "Anger"
              },
              ...
            "category_id": "social_tone",
            "category_name": "Social Tone"
          }
        ]
      }
    }
    ```
    {: screen}
8. [Inicie el panel de control de Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).
9. En el separador **Cargas de trabajo**, verá los recursos que ha creado.

### Lección 5b: Actualización del despliegue de Watson Tone Analyzer en ejecución
{: #lesson5b}

Mientras un despliegue se está ejecutando, puede editar el despliegue para cambiar valores en la plantilla del pod. En esta lección, la empresa de relaciones públicas (PR) quiere cambiar la app en el despliegue actualizando la imagen que se utiliza.
{: shortdesc}

Cambie el nombre de la imagen:

1.  Abra los detalles de configuración del despliegue en ejecución.
    ```
    kubectl edit deployment/watson-talk-pod
    ```
    {: pre}

    En función del sistema operativo, lo abre un editor vi o un editor de texto.
2.  Cambie el nombre de la imagen por la imagen `ibmliberty`.
    ```
    spec:
          containers:
          - image: <region>.icr.io/ibmliberty:latest
    ```
    {: codeblock}
3.  Guarde los cambios y salga del editor.
4.  Aplique los cambios en el despliegue en ejecución.
    ```
    kubectl rollout status deployment/watson-talk-pod
    ```
    {: pre}

    Espere a que se confirme que la actualización ha finalizado.
    ```
    deployment "watson-talk-pod" successfully rolled out
    ```
    {: screen}
    Cuando se despliega un cambio, se crea otro pod y Kubernetes lo prueba. Cuando la prueba se ejecuta correctamente, el pod antiguo se elimina.

¡Buen trabajo! Ha desplegado la app {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} y ha aprendido a realizar una actualización sencilla de la misma. La empresa de relaciones públicas puede utilizar este despliegue para iniciar el análisis de sus comunicados de prensa con la última tecnología de IA.

**Limpieza**<br>
¿Está listo para suprimir la app {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} que ha creado en el clúster de {{site.data.keyword.containerlong_notm}}? Puede utilizar el script de configuración para suprimir los recursos que ha creado.

  ```
  kubectl delete -f watson-deployment.yml
  ```
  {: pre}

  Salida de ejemplo:

  ```
  deployment "watson-pod" deleted
deployment "watson-talk-pod" deleted
service "watson-service" deleted
service "watson-talk-service" deleted
  ```
  {: screen}

  Si no desea conservar el clúster, también puede suprimirlo.

  ```
  ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
  ```
  {: pre}

Vamos a jugar. Ha cubierto una gran cantidad de material, por lo que es bueno [asegurarse de que lo entiende todo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php). No se preocupe, el cuestionario no es acumulativo.
{: note}

<br />


## ¿Qué es lo siguiente?
{: #tutorials_next}

Ahora que ya domina los conceptos básicos, puede pasar a actividades más avanzadas. Plantéese probar uno de los recursos siguientes para hacer más cosas con {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

*   Completar un [laboratorio más complejo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/IBM/container-service-getting-started-wt#lab-overview) en el repositorio.
*   Aprender a crear [apps de alta disponibilidad](/docs/containers?topic=containers-ha) utilizando características como clústeres multizona, almacenamiento persistente, autoescalador de clústeres y autoescalado de pod horizontal para apps.
*   Explorar los patrones de código de orquestación de contenedores en [IBM Developer ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/technologies/containers/).
