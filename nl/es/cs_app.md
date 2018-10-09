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




# Despliegue de apps en clústeres
{: #app}

Puede utilizar las técnicas de Kubernetes en {{site.data.keyword.containerlong}} para desplegar apps en contenedores y asegurarse de que las estén siempre activas y en funcionamiento. Por ejemplo, puede realizar actualizaciones continuas y retrotracciones sin causar a los usuarios tiempos de inactividad.
{: shortdesc}

Conozca los pasos generales para desplegar apps pulsando en un área de la imagen siguiente. ¿Desea aprender primero los conceptos básicos? Consulte la [guía de aprendizaje para desplegar apps](cs_tutorials_apps.html#cs_apps_tutorial).

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="Proceso de despliegue básico"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Instale las CLI." title="Instale las CLI." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Cree un archivo de configuración para la app. Revise las mejores prácticas desde Kubernetes." title="Cree un archivo de configuración para la app. Revise las mejores prácticas desde Kubernetes." shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="Opción 1: Ejecute los archivos de configuración desde la CLI de Kubernetes." title="Opción 1: Ejecute los archivos de configuración desde la CLI de Kubernetes." shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="Opción 2: Inicie el panel de control de Kubernetes localmente y ejecute los archivos de configuración." title="Opción 2: Inicie el panel de control de Kubernetes localmente y ejecute los archivos de configuración." shape="rect" coords="544, 141, 728, 204" />
</map>

<br />




## Planificación de despliegues de alta disponibilidad
{: #highly_available_apps}

Cuanto más ampliamente distribuya la configuración entre varios nodos trabajadores y clústeres, menor será la probabilidad de que los usuarios experimenten tiempo de inactividad con la app.
{: shortdesc}

Revise las siguientes configuraciones potenciales de apps que están ordenadas por grados de disponibilidad en orden ascendente.

![Etapas de alta disponibilidad de una app](images/cs_app_ha_roadmap-mz.png)

1.  Un despliegue con n+2 pods gestionados por un conjunto de réplicas en un solo nodo de un clúster de una sola zona.
2.  Un despliegue con n+2 pods gestionados por un conjunto de réplicas y distribuidos en varios nodos (antiafinidad) en un clúster de una sola zona.
3.  Un despliegue con n+2 pods gestionados por un conjunto de réplicas y distribuidos en varios nodos (antiafinidad) en varias zonas de un clúster multizona.

También puede [conectar varios clústeres en distintas regiones con un equilibrador de carga global](cs_clusters_planning.html#multiple_clusters) para aumentar la alta disponibilidad.

### Cómo aumentar la disponibilidad de la app
{: #increase_availability}

<dl>
  <dt>Utilice despliegues y conjuntos de réplicas para desplegar la app y sus dependencias</dt>
    <dd><p>Un despliegue es un recurso de Kubernetes que puede utilizar para declarar todos los componentes de su app y sus dependencias. Con los despliegues, no tiene que encargarse de todos los pasos y en su lugar puede centrarse en la app.</p>
    <p>Si despliega más de un pod, se crea automáticamente un conjunto de réplicas que supervisa los pods y garantiza que el número deseado de pods están activos y en ejecución en todo momento. Cuando un pod pasa a estar inactivo, el conjunto de réplicas sustituye el pod que no responde por uno nuevo.</p>
    <p>Puede utilizar un despliegue para definir estrategias para la app que incluyan el número de pods que desea añadir durante una actualización continuada y el número de pods que pueden no estar disponibles al mismo tiempo. Cuando lleva a cabo una actualización continuada, el despliegue comprueba si la revisión funciona o no y detiene la implantación cuando se detectan anomalías.</p>
    <p>Los despliegues permiten desplegar simultáneamente varias revisiones con diferentes distintivos. Por ejemplo, puede probar un primer despliegue antes de decidir si se debe utilizar para producción.</p>
    <p>Los despliegues permiten realizar un seguimiento de las revisiones desplegadas. Puede utilizar este historial para retrotraer a una versión anterior si detecta que las actualizaciones no funcionan como esperaba.</p></dd>
  <dt>Incluya suficientes réplicas para la carga de trabajo de la app, más dos</dt>
    <dd>Para que la app esté aún más disponible y resulte más resistente frente a errores, considere la posibilidad de incluir más réplicas que el mínimo para gestionar la carga de trabajo prevista. Las réplicas adicionales pueden gestionar la carga de trabajo en el caso de que un pod se cuelgue y el conjunto de réplicas aún no haya recuperado el pod inactivo. Para la protección frente a dos anomalías simultáneas, incluya dos réplicas adicionales. Esta configuración es un patrón de tipo N+2, donde N es el número de réplicas necesario para gestionar la carga de trabajo entrante y +2 significa dos réplicas adicionales. Mientras el clúster tenga suficiente espacio, puede tener tantos pods como desee.</dd>
  <dt>Distribuya los pods entre varios nodos (antiafinidad)</dt>
    <dd><p>Cuando se crea un despliegue, cada pod se puede desplegar en el mismo nodo trabajador. Esto se conoce como afinidad o coubicación. Para proteger la app con relación a una anomalía del nodo trabajador, es posible configurar el despliegue para repartir los pods a través de varios nodos de trabajo utilizando la opción <em>podAntiAffinity</em> con los clústeres estándar. Puede definir dos tipos de antiafinidad de pod: preferida o necesaria. Para obtener más información, consulte la documentación de Kubernetes en <a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(Se abre en un nuevo separador o ventana)">Asignación de pods a nodos</a>.</p>
    <p><strong>Nota</strong>: Con la antiafinidad necesaria, únicamente puede desplegar un número de réplicas para las que tenga nodos de trabajador. Por ejemplo, si tiene 3 nodos de trabajador en su clúster y define 5 réplicas en su archivo YAML, únicamente se desplegarán 3 réplicas. Cada réplica se basa en un nodo trabajador diferente. Las 2 réplicas sobrantes quedarán pendientes. Si añade otro nodo trabajador al clúster, una de las réplicas sobrantes se desplegará de forma automática en el nuevo nodo trabajador.<p>
    <p><strong>Ejemplo de archivos YAML de despliegue</strong>:<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="(Se abre en un nuevo separador o ventana)">App de Nginx con antiafinidad de pod preferida. </a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="(Se abre en un nuevo separador o ventana)">App de IBM® WebSphere® Application Server Liberty con antiafinidad de pod requerida. </a></li></ul></p>
    
    </dd>
<dt>Distribución de pods entre varias zonas o regiones</dt>
  <dd><p>Para proteger la app frente a un error de zona, puede crear varios clústeres en distintas zonas o puede añadir zonas a una agrupación de nodos trabajadores en un clúster multizona. Los clústeres multizona solo están disponibles en [determinadas áreas metropolitanas](cs_regions.html#zones), como Dallas. Si crea varios clústeres en distintas zonas, debe [configurar un equilibrador de carga global](cs_clusters_planning.html#multiple_clusters).</p>
  <p>Cuando se utiliza un conjunto de réplicas y se especifica la antiafinidad de pod, Kubernetes distribuye los pods de la app entre los nodos. Si los nodos están en varias zonas, los pods se distribuyen entre las zonas, lo que aumenta la disponibilidad de la app. Si desea limitar las apps de modo que solo se ejecuten en una zona, puede configurar la afinidad de pod, o puede crear y etiquetar una agrupación de nodos trabajadores en una zona. Para obtener más información, consulte [Alta disponibilidad de clústeres multizona](cs_clusters_planning.html#ha_clusters).</p>
  <p><strong>En un despliegue de clúster multizona, ¿se distribuyen mis pods de app de forma uniforme entre los nodos? </strong></p>
  <p>Los pods se distribuyen uniformemente entre las zonas, pero no siempre entre los nodos. Por ejemplo, si tiene un clúster con 1 nodo en cada una de las 3 zonas y despliega un conjunto de réplicas de 6 pods, cada nodo obtiene 2 pods. Sin embargo, si tiene un clúster con 2 nodos en cada una de las 3 zonas y despliega un conjunto de réplicas de 6 pods, cada zona tiene 2 pods planificados, y puede que planifique 1 pod por nodo o puede que no. Para obtener más control sobre la planificación, puede [establecer la afinidad de pod ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo") ](https://kubernetes.io/docs/concepts/configuration/assign-pod-node).</p>
  <p><strong>Si cae una zona, ¿cómo se replanifican los pods en los nodos restantes de las otras zonas?</strong></br>Depende de la política de planificación que haya utilizado en el despliegue. Si ha incluido la [afinidad de pod específica del nodo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature), los pods no se vuelven a planificar. Si no lo ha hecho, los pods se crean en los nodos trabajadores disponibles en otras zonas, pero es posible que no estén equilibrados. Por ejemplo, es posible que los 2 pods se distribuyan entre los 2 nodos disponibles, o puede que ambos se planifiquen en 1 nodo con capacidad disponible. De forma similar, cuando la zona no disponible vuelve a estar activa, los pods no se suprimen y se reequilibran automáticamente entre los nodos. Si desea que los pods se reequilibren entre las zonas cuando la zona vuelve a estar activa, tenga en cuenta la posibilidad de utilizar el [deplanificador de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes-incubator/descheduler).</p>
  <p><strong>Consejo</strong>: en clústeres multizona, intente mantener una capacidad de nodo trabajador del 50 % por zona para disponer de suficiente capacidad para proteger el clúster frente un error de la zona.</p>
  <p><strong>¿Qué ocurre si quiero distribuir mi app entre regiones?</strong></br>Para proteger la app frente a un error de región, cree un segundo clúster en otra región, [configure un equilibrador de carga global](cs_clusters_planning.html#multiple_clusters) para conectar los clústeres y utilice un YAML de despliegue para desplegar un conjunto de réplicas duplicado con [antiafinidad de pod ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo") ](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) para la app.</p>
  <p><strong>¿Qué pasa si mis apps necesitan almacenamiento persistente?</strong></p>
  <p>Utilice un servicio de nube, como por ejemplo [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) o [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).</p></dd>
</dl>



### Despliegue de una app mínima
{: #minimal_app_deployment}

Un despliegue básico de app en un clúster gratuito o estándar puede incluir los siguientes componentes.
{: shortdesc}

![Configuración del despliegue](images/cs_app_tutorial_components1.png)

Para desplegar los componentes de una app mínima tal como se muestra en el diagrama, utilice un archivo de configuración parecido al del siguiente ejemplo:
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.bluemix.net/ibmliberty:latest
        ports:
        - containerPort: 9080        
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    app: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

**Nota:** Para exponer el servicio, asegúrese de que el par clave/valor que utiliza en la sección `spec.selector` del servicio es el mismo que el par de clave/valor utilizado en la sección `spec.template.metadata.labels` de su yaml de despliegue.
Para obtener más información sobre cada componente, revise [Aspectos básicos de Kubernetes](cs_tech.html#kubernetes_basics).

<br />






## Inicio del panel de control de Kubernetes
{: #cli_dashboard}

Abra un panel de control de Kubernetes en el sistema local para ver información sobre un clúster y sus nodos trabajadores. [En la GUI](#db_gui), puede acceder al panel de control mediante una simple pulsación desde un botón. [Con la CLI](#db_cli), puede acceder al panel de control o utilizar los pasos en un proceso de automatización como, por ejemplo, para un conducto CI/CD.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Puede utilizar el puerto predeterminado o definir su propio puerto para iniciar el panel de control de Kubernetes para un clúster.

**Inicio del panel de control de Kubernetes desde la GUI**
{: #db_gui}

1.  Inicie una sesión en la [GUI de {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/).
2.  Desde su perfil en la barra de menús, seleccione la cuenta que desea utilizar.
3.  En el menú, pulse **Contenedores**.
4.  En la página **Clústeres**, pulse el clúster al que desea acceder.
5.  En la página de detalles del clúster, pulse el botón **Panel de control de Kubernetes**.

</br>
</br>

**Inicio del panel de control de Kubernetes desde la CLI**
{: #db_cli}

1.  Obtenga las credenciales para Kubernetes.

    ```
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2.  Copie el valor **id-token** que se muestra en la salida.

3.  Establezca el proxy con el número de puerto predeterminado.

    ```
    kubectl proxy
    ```
    {: pre}

    Salida de ejemplo:

    ```
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4.  Inicie sesión en el panel de control.

  1.  En el navegador, vaya al siguiente URL:

      ```
      http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
      ```
      {: codeblock}

  2.  En la página de inicio de sesión, seleccione el método de autenticación **Señal**.

  3.  A continuación, pegue el valor **id-token** que ha copiado anteriormente en el campo **Señal** y pulse **INICIAR SESIÓN**.

Cuando termine de utilizar el panel de control de Kubernetes, utilice `CONTROL+C` para salir del mandato `proxy`. Después de salir, el panel de control Kubernetes deja de estar disponible. Ejecute el mandato `proxy` para reiniciar el panel de control de Kubernetes.

[A continuación, puede ejecutar un archivo de configuración desde el panel de control.](#app_ui)

<br />


## Creación de secretos
{: #secrets}

Los secretos de Kubernetes constituyen una forma segura de almacenar información confidencial, como nombres de usuario, contraseñas o claves.
{:shortdesc}

Revise las siguientes tareas que requieren secretos. Para obtener más información sobre lo que puede almacenar en secretos, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/secret/).

### Adición de un servicio a un clúster
{: #secrets_service}

Cuando enlaza un servicio a un clúster, no tiene que crear un secreto. El secreto se crea automáticamente. Para obtener más información, consulte [Adición de servicios de Cloud Foundry a clústeres](cs_integrations.html#adding_cluster).

### Configuración de Ingress ALB para que utilice TLS
{: #secrets_tls}

El ALB equilibra carga de tráfico de red HTTP para las apps en su clúster. Para equilibrar también la carga de conexiones HTTPS entrantes, puede configurar el ALB para descifrar el tráfico de red y reenviar las solicitudes descifradas a las apps expuestas en su clúster.

Si está utilizando el subdominio de Ingress proporcionado por IBM, puede [utilizar el certificado TLS proporcionado por IBM](cs_ingress.html#public_inside_2). Para ver el secreto de TLS proporcionado por IBM, ejecute el mandato siguiente:
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep "Ingress secret"
```
{: pre}

Si utiliza un dominio personalizado, puede utilizar su propio certificado para gestionar la terminación TLS. Para crear su propio secreto de TLS:
1. Genere una clave y un certificado de una de estas formas:
    * Genere un certificado de la autoridad de certificados (CA) y una clave de su proveedor de certificados. Si tiene su propio dominio, compre un certificado TLS oficial para el mismo.
      **Importante**: asegúrese de que el [CN ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://support.dnsimple.com/articles/what-is-common-name/) sea distinto para cada certificado.
    * A efectos de prueba, puede crear un certificado autofirmado mediante OpenSSL. Para obtener más información, consulte esta [guía de aprendizaje sobre los certificados SSL autofirmados ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Cree un `tls.key`.
            ```
            openssl genrsa -out tls.key 2048
            ```
            {: pre}
        2. Utilice la clave para crear un `tls.crt`.
            ```
            openssl req -new -x509 -key tls.key -out tls.crt
            ```
            {: pre}
2. [Convierta el certificado y la clave a base-64 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.base64encode.org/).
3. Cree un archivo YAML secreto utilizando el certificado y la clave.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. Cree el certificado como un secreto de Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### Personalización de Ingress ALB con la anotación de los servicios SSL
{: #secrets_ssl_services}

Puede utilizar el tráfico cifrado con la [anotación `ingress.bluemix.net/ssl-services`](cs_annotations.html#ssl-services) para cargar sus apps desde Ingress ALB. Para crear el secreto:

1. Obtenga la clave y el certificado de la entidad emisora de certificados (CA) desde el servidor de carga.
2. [Convierta el certificado a base-64 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.base64encode.org/).
3. Cree un archivo YAML secreto utilizando el certificado.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **Nota**: si también desea imponer la autenticación mutua para el tráfico en sentido ascendente, puede suministrar un archivo `client.crt` y un archivo `client.key` además de `trusted.crt` en la sección de datos.
4. Cree el certificado como un secreto de Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### Personalización de Ingress ALB con la anotación de autenticación mutua
{: #secrets_mutual_auth}

Puede utilizar la [anotación `ingress.bluemix.net/mutual-auth`](cs_annotations.html#mutual-auth) para configurar la autenticación mutua del tráfico en sentido descendente para Ingress ALB. Para crear un secreto de autenticación mutua:

1. Genere una clave y un certificado de una de estas formas:
    * Genere un certificado de la autoridad de certificados (CA) y una clave de su proveedor de certificados. Si tiene su propio dominio, compre un certificado TLS oficial para el mismo.
      **Importante**: asegúrese de que el [CN ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://support.dnsimple.com/articles/what-is-common-name/) sea distinto para cada certificado.
    * A efectos de prueba, puede crear un certificado autofirmado mediante OpenSSL. Para obtener más información, consulte esta [guía de aprendizaje sobre los certificados SSL autofirmados ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Cree un archivo `ca.key`.
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. Utilice la clave para crear un archivo `ca.crt`.
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. Utilice el archivo `ca.crt` para crear un certificado autofirmado.
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [Convierta el certificado a base-64 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.base64encode.org/).
3. Cree un archivo YAML secreto utilizando el certificado.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. Cree el certificado como un secreto de Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## Despliegue de apps con la GUI
{: #app_ui}

Cuando despliega una app a un clúster utilizando el panel de control de Kubernetes, un recurso de despliegue crea, actualiza y gestiona automáticamente los pods del clúster.
{:shortdesc}

Antes de empezar:

-   Instale las [CLI](cs_cli_install.html#cs_cli_install) necesarias.
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para desplegar la app:

1.  Abra el [panel de control](#cli_dashboard) de Kubernetes y pulse **+ Crear**.
2.  Especifique los detalles de la app de una de las dos siguientes maneras.
  * Seleccione **Especificar detalles de app a continuación** y especifique los detalles.
  * Seleccione **Cargar un archivo YAML o JSON** para cargar su [archivo de configuración ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

  ¿Necesita ayuda con su archivo de configuración? Consulte este [archivo YAML de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml). En este ejemplo, se despliega un contenedor desde la imagen **ibmliberty** en la región EE.UU. sur. Obtenga más información sobre cómo [proteger su información personal](cs_secure.html#pi) cuando se trabaja recursos de Kubernetes.
  {: tip}

3.  Verifique que ha desplegado satisfactoriamente la app de una de las siguientes formas.
  * En el panel de control de Kubernetes, pulse **Despliegues**. Se visualiza una lista de despliegues satisfactorios.
  * Si la app está [disponible públicamente](cs_network_planning.html#public_access), vaya a la página de visión general del clúster en el panel de control de {{site.data.keyword.containerlong}}. Copie el subdominio, que se encuentra en la sección de resumen del clúster y péguelo en un navegador para ver la app.

<br />


## Despliegue de apps con la CLI
{: #app_cli}

Después de crear un clúster, puede desplegar una app en dicho clúster mediante la CLI de Kubernetes.
{:shortdesc}

Antes de empezar:

-   Instale las [CLI](cs_cli_install.html#cs_cli_install) necesarias.
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para desplegar la app:

1.  Cree un archivo de configuración basado en la [prácticas recomendadas de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/overview/). Generalmente, un archivo de configuración contiene detalles de configuración de cada uno de los recursos que está creando en Kubernetes. El script puede incluir una o varias de las siguientes secciones:

    -   [Despliegue ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Define la creación de pods y conjuntos de réplicas. Un pod incluye una app contenerizada individual y conjuntos de réplicas que controlan varias instancias de pods.

    -   [Servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/): Ofrece un acceso frontal a los pods mediante un nodo trabajador o una dirección IP pública de equilibrador de carga, o bien una ruta pública de Ingress.

    -   [Ingress ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Especifica un tipo de equilibrador de carga que ofrece rutas para acceder a la app a nivel público.

    Obtenga más información sobre cómo [proteger su información personal](cs_secure.html#pi) cuando se trabaja recursos de Kubernetes.

2.  Ejecute el archivo de configuración en el contexto de un clúster.

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  Si ha puesto la app a disponibilidad pública mediante un servicio de nodeport, un servicio de equilibrador de carga o Ingress, compruebe que puede acceder a la app.

<br />


## Despliegue de apps en nodos trabajadores específicos mediante la utilización de etiquetas
{: #node_affinity}

Cuando despliega una app, los pods de la app se despliegan de forma indiscriminada en varios nodos trabajadores del clúster. En algunos casos, es posible que desee restringir los nodos trabajadores en los que se despliegan los pods de la app. Por ejemplo, es posible que desee que los pods de la app solo se desplieguen en nodos trabajadores de una determinada agrupación de nodos trabajadores porque dichos nodos trabajadores están en máquinas vacías. Para designar los nodos trabajadores en los que deben desplegarse los pods de la app, añada una regla de afinidad al despliegue de la app.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

1. Obtenga el nombre de la agrupación de nodos trabajadores en la que desea desplegar los pods de la app.
    ```
    ibmcloud ks worker-pools <cluster_name_or_ID>
    ```
    {:pre}

    En estos pasos se utiliza un nombre de agrupación de nodos trabajadores como ejemplo. Para desplegar pods de la app en determinados nodos trabajadores en función en otro factor, obtenga ese valor en su lugar. Por ejemplo, para desplegar los pods de la app solo en nodos trabajadores de una VLAN específica, obtenga el ID de VLAN con el mandato ` ibmcloud ks vlans <zone>`.
    {: tip}

2. [Añada una regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) correspondiente al nombre de la agrupación de nodos trabajadores al despliegue de la app.

    Archivo yaml de ejemplo:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - <worker_pool_name>
    ...
    ```
    {: codeblock}

    En la sección **affinity** del archivo yaml de ejemplo, `workerPool` es la `clave (key)` y `<worker_pool_name>` es el `valor (value)`.

3. Aplique el archivo de configuración de despliegue actualizado.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

4. Verifique que los pods de la app se han desplegado en los nodos trabajadores correctos.

    1. Obtenga una lista de pods en el clúster.
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        Salida de ejemplo:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. En la salida, identifique un pod para su app. Anote la dirección IP privada de **NODE** del nodo trabajador en el que está el pod.

        En la salida de ejemplo anterior, el pod de la app `cf-py-d7b7d94db-vp8pq` está en un nodo trabajador con la dirección IP `10.176.48.78`.

    3. Obtenga una lista de los nodos trabajadores de la agrupación de nodos trabajadores que ha designado en el despliegue de la app.

        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        Salida de ejemplo:

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        Si ha creado una regla de afinidad de app basada en otro factor, obtenga ese valor en su lugar. Por ejemplo, para verificar que el pod de la app se ha desplegado en un nodo trabajador de una VLAN específica, visualice la VLAN en la que se encuentra el nodo trabajador con el mandato ` ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>`.
        {: tip}

    4. En la salida, verifique que el nodo trabajadores con la dirección IP privada que ha identificado en el paso anterior se ha desplegado en esta agrupación de nodos trabajadores.

<br />


## Despliegue de una app en una máquina con GPU
{: #gpu_app}

Si tiene un [tipo de máquina con GPU (Graphics Processing Unit) nativa](cs_clusters_planning.html#shared_dedicated_node), puede planificar cargas de trabajo matemáticas intensivas en el nodo trabajador. Por ejemplo, podría querer ejecutar una app 3D que utilizase la plataforma CUDA (Compute Unified Device Architecture) para compartir la carga de trabajo entre la GPU y la CPU para un mayor rendimiento.
{:shortdesc}

En los pasos siguientes, aprenderá a desplegar cargas de trabajo que requieren la GPU. También puede [desplegar apps](#app_ui) que no tienen la necesidad de procesar sus cargas de trabajo entre la GPU y la CPU. Después, podría encontrar útil probar con cargas de trabajo matemáticas intensivas como por ejemplo las de la infraestructura de aprendizaje máquina de [TensorFlow ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.tensorflow.org/) con [esta demo de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/pachyderm/pachyderm/tree/master/doc/examples/ml/tensorflow).

Antes de empezar:
* [Cree un tipo de máquina nativa con GPU](cs_clusters.html#clusters_cli). Tenga en cuenta que puede llevar más de 1 día laboral el lograrlo.
* El nodo maestro y el nodo trabajador con GPU del clúster deben ejecutar Kubernetes versión 1.10 o posterior.

Para ejecutar una carga de trabajo en una máquina con GPU:
1.  Cree un archivo YAML. En este ejemplo, un `trabajo` YAML gestiona cargas de trabajo como lotes creando un pod de corta vida que está en ejecución hasta que el mandato que se planifica finaliza de forma satisfactoria.

    **Importante**: Para cargas de trabajo de GPU, siempre debe proporcionar el campo `resources: limits: nvidia.com/gpu` en la especificación YAML.

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>Componentes de YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td>Metadatos y nombres de etiqueta</td>
    <td>Proporcione un nombre y una etiqueta para el trabajo, y utilice el mismo nombre tanto en los metadatos del archivo como en los metadatos de la `plantilla de especificación`. Por ejemplo, `nvidia-smi`.</td>
    </tr>
    <tr>
    <td><code>containers/image</code></td>
    <td>Proporcione la imagen de la que el contenedor es su instancia en ejecución. En este ejemplo, el valor se establece para utilizar la imagen CUDA DockerHub CUDA: <code>nvidia/cuda:9.1-base-ubuntu16.04</code>.</td>
    </tr>
    <tr>
    <td><code>containers/command</code></td>
    <td>Especifique un mandato a ejecutar en el contenedor. En este ejemplo, el mandato <code>[ "/usr/test/nvidia-smi" ]</code> hace referencia a un binario que está en la máquina con GPU, por lo que también debe configurar un montaje de volumen.</td>
    </tr>
    <tr>
    <td><code>containers/imagePullPolicy</code></td>
    <td>Para obtener mediante pull una nueva imagen solo si actualmente dicha imagen no está en el nodo trabajador, especifique <code>IfNotPresent</code>.</td>
    </tr>
    <tr>
    <td><code>resources/limits</code></td>
    <td>Para máquinas con GPU, debe especificar el límite del recurso. El [Device Plug-in![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) de Kubernetes establece la solicitud de recurso predeterminado para que coincida con el límite.
    <ul><li>Debe especificar la clave como <code>nvidia.com/gpu</code>.</li>
    <li>Especifique el número entero de GPU que solicita, por ejemplo, <code>2</code>. <strong>Nota</strong>: Los pods de contenedor no comparten GPU. Tampoco es posible sobrecargar GPU. Por ejemplo, si solo tiene una máquina `mg1c.16x128`, solo tiene 2 GPU en dicha máquina y puede especificar un máximo de `2`.</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>Nombre del volumen que está montado en el contenedor, como por ejemplo <code>nvidia0</code>. Especifique el <code>mountPath</code> en el contenedor para el volumen. En este ejemplo, la vía de acceso <code>/usr/test</code> coincide con la vía de acceso utilizada en el mandato de contenedor del trabajo.</td>
    </tr>
    <tr>
    <td><code> volumes</code></td>
    <td>Nombre del volumen de trabajo, como por ejemplo <code>nvidia0</code>. En el <code>hostPath</code> del nodo trabajador con GPU, especifique el valor del <code>path</code> del volumen en el host, en este ejemplo, <code>/usr/bin</code>. El contenedor <code>mountPath</code> se correlaciona con el volumen de host <code>path</code>, que proporciona a este trabajo acceso a los binarios NVIDIA en el nodo trabajador con GPU para la ejecución del mandato de contenedor.</td>
    </tr>
    </tbody></table>

2.  Aplique el archivo YAML. Por ejemplo:

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  Compruebe el pod de trabajo filtrando los pods con la etiqueta `nvidia-sim`. Verifique que **STATUS** es **Completed**.

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    Salida de ejemplo:
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  Describa el pod para ver cómo el plugin de dispositivo de GPU planificó el pod.
    * En los campos `Limits` y `Requests` podrá ver el límite de recurso que especificó coincide con la solicitud que el plugin de dispositivo estableció de forma automática.
    * En los sucesos, verifique que el pod está asignado a su nodo trabajador con GPU.

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    Salida de ejemplo:
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  Para verificar que el trabajo utilizó la GPU para los cálculos de su carga de trabajo, compruebe los registros. El mandato `[ "/usr/test/nvidia-smi" ]` del trabajo consultó el estado del dispositivo GPU en el nodo trabajador con GPU.

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    Salida de ejemplo:
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    En este ejemplo, verá que ambas GPU se utilizaron para ejecutar el trabajo porque ambas GPU fueron planificadas en el nodo trabajador. Si el límite se establece en 1, solo se mostrará una GPU.

## Escalado de apps
{: #app_scaling}

Con Kubernetes, puede habilitar el [escalado automático de pod horizontal ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) para aumentar o disminuir automáticamente el número de instancias de las apps en función de la CPU.
{:shortdesc}

¿Está buscando información sobre las aplicaciones de escalado de Cloud Foundry? Consulte [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html). 
{: tip}

Antes de empezar:
- Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).
- La supervisión de Heapster debe desplegarse en el clúster que desea escalar automáticamente.

Pasos:

1.  Despliegue su app en un clúster desde la CLI. Cuando despliegue la app, debe solicitar CPU.

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>Componentes de mandato para kubectl run</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>La aplicación que desea desplegar.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>La CPU necesaria para el contenedor, que se especifica en milinúcleos. Por ejemplo, <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>Si tiene el valor true, crea un servicio externo.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>El puerto en el que la app está disponible externamente.</td>
    </tr></tbody></table>

    Para despliegues más complejos, es posible que tenga que crear un [archivo de configuración](#app_cli).
    {: tip}

2.  Cree un autoscaler y defina la política. Para obtener más información sobre cómo trabajar con el mandato `kubectl autoscale`, consulte [la documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <caption>Componentes de mandato para kubectl autoscale</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Utilización media de CPU que mantiene el componente Horizontal Pod Autoscaler, que se especifica como un porcentaje.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>El número mínimo de pods desplegados que se utilizan para mantener el porcentaje especificado de utilización de CPU.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>El número máximo de pods desplegados que se utilizan para mantener el porcentaje especificado de utilización de CPU.</td>
    </tr>
    </tbody></table>


<br />


## Gestión de despliegues continuos
{: #app_rolling}

Puede gestionar la implantación de los cambios de una forma automatizada y controlada. Si el despliegue no va según lo planificado, puede retrotraerlo a la revisión anterior.
{:shortdesc}

Antes de empezar, cree un [despliegue](#app_cli).

1.  [Implante ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) un cambio. Por ejemplo, supongamos que desea cambiar la imagen que ha utilizado en el despliegue inicial.

    1.  Obtener el nombre del despliegue.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Obtener el nombre del pod.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Obtener el nombre del contenedor que se está ejecutando en el pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Definir la imagen que utilizará el despliegue.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    Al ejecutar estos mandatos, el cambio se aplica de inmediato y se registra en el historial de implantaciones.

2.  Comprobar el estado del despliegue.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Retrotraer un cambio.
    1.  Ver el historial de implantaciones del despliegue e identificar el número de revisión del último despliegue.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Sugerencia:** Para ver los detalles de una revisión concreta, incluya el número de revisión.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Retrotraer a la versión anterior o especificar una revisión. Para retrotraer a la versión anterior, utilice el mandato siguiente.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />

