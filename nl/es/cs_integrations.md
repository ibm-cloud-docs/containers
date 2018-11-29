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




# Integración de servicios
{: #integrations}

Puede utilizar diversos servicios externos y servicios del catálogo con un clúster de Kubernetes estándar en {{site.data.keyword.containerlong}}.
{:shortdesc}


## DevOps services
{: #devops_services}
<table summary="Resumen de las características de accesibilidad">
<caption>DevOps services</caption>
<thead>
<tr>
<th>Servicio</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>Puede utilizar <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para la integración y entrega continua de contenedores. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Utilización de Codeship Pro para desplegar cargas de trabajo en {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> es un gestor de paquetes de Kubernetes. Puede crear nuevos diagramas de Helm o utilizar diagramas de Helm preexistentes para definir, instalar y actualizar utilizar aplicaciones de Kubernetes complejas que se ejecutan en clústeres de {{site.data.keyword.containerlong_notm}}. <p>Para obtener más información, consulte [Configuración de Helm en {{site.data.keyword.containerlong_notm}}](cs_integrations.html#helm).</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>Automatice las compilaciones de las apps y los despliegues de los contenedores en clústeres de Kubernetes
utilizando a cadena de herramientas. Para obtener información sobre la configuración, consulte el blog sobre <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Despliegue de pods de Kubernetes en {{site.data.keyword.containerlong_notm}} mediante conductos DevOps <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> es un servicio de código fuente abierto que ofrece a los desarrolladores una forma de conectarse, proteger, gestionar y supervisar una red de microservicios, también conocida como malla de servicios, en plataformas de orquestación de nube como Kubernetes. Consulte la publicación sobre <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">cómo IBM cofundó y lanzó Istio<img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para obtener más información sobre el proyecto de código abierto. Para instalar Istio en el clúster de Kubernetes en {{site.data.keyword.containerlong_notm}} y empezar con una app de muestra, consulte la [Guía de aprendizaje: Gestión de microservicios con Istio](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
</tbody>
</table>

<br />



## Servicios de registro y supervisión
{: #health_services}
<table summary="Resumen de las características de accesibilidad">
<caption>Servicios de registro y supervisión</caption>
<thead>
<tr>
<th>Servicio</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td>Supervise los nodos trabajadores, contenedores, conjuntos de réplicas, controladores de réplicas y servicios con <a href="https://www.coscale.com/" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Supervisión de {{site.data.keyword.containerlong_notm}} con CoScale <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Datadog</td>
<td>Supervise el clúster y visualice las métricas de rendimiento de las aplicaciones y la infraestructura con <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Supervisión de {{site.data.keyword.containerlong_notm}} con Datadog <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td> {{site.data.keyword.cloudaccesstrailfull}}</td>
<td>Supervise la actividad administrativa realizada en el clúster mediante el análisis de registros a través de Grafana. Para obtener más información sobre el servicio, consulte la documentación de [Activity Tracker](/docs/services/cloud-activity-tracker/index.html). Para obtener más información sobre los tipos de sucesos de los que puede realizar un seguimiento, consulte [sucesos de Activity Tracker](cs_at_events.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>Amplíe las funciones de recopilación de registros, retención y búsqueda con {{site.data.keyword.loganalysisfull_notm}}. Para obtener más información, consulte <a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">Habilitación de la recopilación automática de registros de clúster <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>Amplíe las funciones de retención y recopilación de métricas definiendo reglas y alertas con {{site.data.keyword.monitoringlong_notm}}. Para obtener más información, consulte <a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">Analizar métricas en Grafana para una app desplegada en un clúster de Kubernetes <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> proporciona la infraestructura y la supervisión de rendimiento de app con una GUI que detecta y correlaciona automáticamente las apps. Instana captura las solicitudes de las apps, que puede utilizar para resolver problemas y realizar el análisis de la causa raíz para evitar que se repitan los problemas. Consulte la publicación sobre <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">despliegue de Instana en {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para obtener más información.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus es una herramienta de supervisión, registro y generación de alertas diseñada específicamente para Kubernetes. Prometheus recupera información detallada acerca del clúster, los nodos trabajadores y el estado de despliegue basado en la información de registro de Kubernetes. Para cada contenedor en ejecución en el clúster se recopila actividad de CPU, memoria, E/S y red. Los datos recopilados se pueden utilizar en consultas personalizadas o en alertas para supervisar el rendimiento y las cargas de trabajo del clúster.

<p>Para utilizar Prometheus, siga las <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">instrucciones de CoreOS <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td>Visualice métricas y registros para sus aplicaciones contenerizadas utilizando <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Supervisión y registro de contenedores con Sematext <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Sysdig</td>
<td>Capture métricas de host, statsd, contenedor y app con un único punto de instrumentación utilizando <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Supervisión de {{site.data.keyword.containerlong_notm}} con Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope proporciona un diagrama visual de los recursos de un clúster de Kubernetes, incluidos servicios, pods, contenedores, procesos, nodos, etc. Weave Scope ofrece métricas interactivas correspondientes a CPU y memoria y también herramientas para realizar seguimientos y ejecuciones en un contenedor.<p>Para obtener más información, consulte [Visualización de recursos de clúster de Kubernetes con Weave Scope y {{site.data.keyword.containerlong_notm}}](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Servicios de seguridad
{: #security_services}

¿Desea obtener una visión completa de cómo integrar los servicios de seguridad de {{site.data.keyword.Bluemix_notm}} en su clúster? Consulte la [guía de aprendizaje sobre cómo aplicar seguridad de extremo a extremo a una aplicación de nube](/docs/tutorials/cloud-e2e-security.html#apply-end-to-end-security-to-a-cloud-application).
{: shortdesc}

<table summary="Resumen de las características de accesibilidad">
<caption>Servicios de seguridad</caption>
<thead>
<tr>
<th>Servicio</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>Añada un nivel de seguridad a sus apps con [{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted) requiriendo a los usuarios que inicien sesión. Para autenticar solicitudes HTTP/HTTPS de API o web para la app, puede integrar {{site.data.keyword.appid_short_notm}} con el servicio Ingress mediante la [{{site.data.keyword.appid_short_notm}} anotación de Ingress de autenticación](cs_annotations.html#appid-auth).</td>
  </tr>
<tr>
<td>Aqua Security</td>
  <td>Como suplemento a <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a>, puede utilizar <a href="https://www.aquasec.com/" target="_blank">Aqua Security <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para mejorar la seguridad de los despliegues de contenedores reduciendo las acciones que su app puede realizar. Para obtener más información, consulte <a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Protección de despliegues de contenedores en {{site.data.keyword.Bluemix_notm}} con Aqua Security <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td>Puede utilizar <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para almacenar y gestionar certificados SSL para sus apps. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Uso de {{site.data.keyword.cloudcerts_long_notm}} con {{site.data.keyword.containerlong_notm}} para desplegar certificados TLS de dominio personalizados <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>Configure su propio repositorio de imágenes de Docker protegidas para almacenar y compartir de forma segura las imágenes entre los usuarios del clúster. Para obtener más información, consulte la <a href="/docs/services/Registry/index.html" target="_blank">documentación de {{site.data.keyword.registrylong}} <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.</td>
</tr>
<tr>
  <td>{{site.data.keyword.keymanagementservicefull}}</td>
  <td>Cifre los secretos de Kubernetes que se encuentran en el clúster habilitando {{site.data.keyword.keymanagementserviceshort}}. El cifrado de los secretos de Kubernetes evita que los usuarios no autorizados accedan a la información confidencial del clúster.<br>Para configurarlo, consulte <a href="cs_encrypt.html#keyprotect">Cifrado de secretos de Kubernetes mediante {{site.data.keyword.keymanagementserviceshort}}</a>.<br>Para obtener más información, consulte la <a href="/docs/services/key-protect/index.html#getting-started-with-key-protect" target="_blank">documentación de {{site.data.keyword.keymanagementserviceshort}}<img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.</td>
</tr>
<tr>
<td>NeuVector</td>
<td>Proteja los contenedores con un cortafuegos nativo en la nube utilizando <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. Para obtener más información, consulte <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
<tr>
<td>Twistlock</td>
<td>Como suplemento a <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a>, puede utilizar <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para gestionar cortafuegos, la protección ante amenazas y la respuesta a incidentes. Para obtener más información, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock en {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Servicios de almacenamiento
{: #storage_services}
<table summary="Resumen de las características de accesibilidad">
<caption>Servicios de almacenamiento</caption>
<thead>
<tr>
<th>Servicio</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio Ark</td>
  <td>Utilice <a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> para hacer copias de seguridad y restauración de volúmenes persistentes y recursos de clúster. Para obtener más información, consulte <a href="https://github.com/heptio/ark/blob/master/docs/use-cases.md#use-cases" target="_blank">Casos de uso para migración de clústeres y recuperación ante desastres <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> de Heptio Ark.</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>Los datos que se almacenan con {{site.data.keyword.cos_short}} están cifrados y se dispersan entre varias ubicaciones geográficas. Se accede a estos datos sobre HTTP utilizando una API REST. Utilice [ibm-backup-restore image](/docs/services/RegistryImages/ibm-backup-restore/index.html) para configurar el servicio y hacer copias de seguridad puntuales o planificadas de los datos en los clústeres. Para obtener información general sobre el servicio, consulte la <a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">documentación de {{site.data.keyword.cos_short}} <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>{{site.data.keyword.cloudant_short_notm}} es una DBaaS (DataBase as a Service) orientada a documentos donde los datos se almacenan como documentos en formato JSON. El servicio se crea ofreciendo escalabilidad, alta disponibilidad y durabilidad. Para obtener más información, consulte la <a href="/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant" target="_blank">documentación de {{site.data.keyword.cloudant_short_notm}}<img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>{{site.data.keyword.composeForMongoDB}} ofrece alta disponibilidad y redundancia, copias de seguridad automatizadas y bajo demanda sin interrupciones, herramientas de supervisión, integración en sistemas de alertas, vistas de análisis de rendimiento y mucho más. Para obtener más información, consulte la <a href="/docs/services/ComposeForMongoDB/index.html#about-compose-for-mongodb" target="_blank">documentación de {{site.data.keyword.composeForMongoDB}}<img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.</td>
  </tr>
</tbody>
</table>


<br />



## Adición de servicios de {{site.data.keyword.Bluemix_notm}} a clústeres
{: #adding_cluster}

Añada servicios de {{site.data.keyword.Bluemix_notm}} para mejorar el clúster de Kubernetes con prestaciones adicionales en áreas como, por ejemplo, Watson AI, datos, seguridad e Internet de las cosas (IoT).
{:shortdesc}

**Importante:** sólo puede enlazar servicios que admitan claves de servicio. Para consultar una lista de servicios que admiten claves de servicio, consulte [Habilitación de apps externas para utilizar servicios de {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#accser_external).

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).

Para añadir un servicio {{site.data.keyword.Bluemix_notm}} al clúster:
1. [Cree una instancia del servicio {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#req_instance). </br></br>**Nota:**<ul><li>Algunos servicios de {{site.data.keyword.Bluemix_notm}} solo están disponibles en determinadas regiones. Puede enlazar un servicio con el clúster sólo si el servicio está disponible en la misma región que el clúster. Además, si desea crear una instancia de servicio en la zona de Washington DC, debe utilizar la CLI.</li><li>Debe crear la instancia de servicio en el mismo grupo de recursos que el clúster. Un recurso solo se puede crear en un grupo de recursos que no se puede cambiar después.</li></ul>

2. Compruebe el tipo de servicio que ha creado y tome nota del **Nombre** de la instancia de servicio.
   - **Servicios de Cloud Foundry:**
     ```
     ibmcloud service list
     ```
     {: pre}

     Salida de ejemplo:
     ```
     name                         service           plan    bound apps   last operation
     <cf_service_instance_name>   <service_name>    spark                create succeeded
     ```
     {: screen}

  - **Servicios habilitados para IAM:**
     ```
     ibmcloud resource service-instances
     ```
     {: pre}

     Salida de ejemplo:
     ```
     Name                          Location   State    Type               Tags   
     <iam_service_instance_name>   <region>   active   service_instance      
     ```
     {: screen}

   También puede ver los distintos tipos de servicio en el panel de control como **Servicios de Cloud Foundry** y **Servicios**.

3. Para los servicios habilitados para IAM, cree un alias de Cloud Foundry, de modo que pueda enlazar este servicio con el clúster. Si el servicio ya es un servicio de Cloud Foundry, este paso no es necesario y puede continuar con el paso siguiente.
   1. Defina una organización y un espacio de Cloud Foundry como objetivo.
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. Cree un alias de Cloud Foundry para la instancia de servicio.
      ```
      ibmcloud resource service-alias-create <service_alias_name> --instance-name <iam_service_instance_name>
      ```
      {: pre}

   3. Verifique que el alias de servicio se ha creado.
      ```
      ibmcloud service list
      ```
      {: pre}

4. Identifique el espacio de nombres del clúster que desea utilizar para añadir el servicio. Puede elegir entre las siguientes opciones.
   - Obtenga una lista de los espacios de nombres existentes y elija el espacio de nombres que desea utilizar.
     ```
     kubectl get namespaces
     ```
     {: pre}

   - Cree un espacio de nombres en el clúster.
     ```
     kubectl create namespace <namespace_name>
     ```
     {: pre}

5.  Añada el servicio al clúster. Para los servicios habilitados para IAM, asegúrese de utilizar el alias de Cloud Foundry que ha creado anteriormente.
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}

    Cuando el servicio se haya añadido correctamente al clúster, se crea un secreto de clúster que contiene las credenciales de la instancia de servicio. Los secretos se cifran automáticamente en etcd para proteger los datos.

    Salida de ejemplo:
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Verifique las credenciales de servicio en el secreto de Kubernetes.
    1. Obtenga los detalles del secreto y anote el valor de **binding**. El valor de **binding** está codificado en base64 y contiene las credenciales para la instancia de servicio en formato JSON.
       ```
       kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
       ```
       {: pre}

       Salida de ejemplo:
       ```
       apiVersion: v1
       data:
         binding: <binding>
       kind: Secret
       metadata:
         annotations:
           service-instance-id: 1111aaaa-a1aa-1aa1-1a11-111aa111aa11
           service-key-id: 2b22bb2b-222b-2bb2-2b22-b22222bb2222
         creationTimestamp: 2018-08-07T20:47:14Z
         name: binding-<service_instance_name>
         namespace: <namespace>
         resourceVersion: "6145900"
         selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
         uid: 33333c33-3c33-33c3-cc33-cc33333333c
       type: Opaque
       ```
       {: screen}

    2. Descodifique el valor de binding.
       ```
       echo "<binding>" | base64 -D
       ```
       {: pre}

       Salida de ejemplo:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. Opcional: compare las credenciales de servicio que ha descodificado en el paso anterior con las credenciales de servicio que encuentre para la instancia de servicio en el panel de control de {{site.data.keyword.Bluemix_notm}}.

7. Ahora que el servicio está enlazado con el clúster, debe configurar la app para que [acceda a las credenciales de servicio en el secreto de Kubernetes](#adding_app).


## Acceso a las credenciales de servicio desde las apps
{: #adding_app}

Para acceder a una instancia de servicio de {{site.data.keyword.Bluemix_notm}} desde la app, debe permitir que la app acceda a las credenciales de servicio almacenadas en el secreto de Kubernetes.
{: shortdesc}

Las credenciales de una instancia de servicio están codificadas como base64 y se almacenan en el secreto en formato JSON. Para acceder a los datos del secreto, elija una de las opciones siguientes:
- [Monte el secreto como un volumen en el pod](#mount_secret)
- [Haga referencia al secreto en las variables de entorno](#reference_secret)
<br>
¿Desea proteger aún más sus secretos? Solicite al administrador del clúster que [habilite {{site.data.keyword.keymanagementservicefull}}](cs_encrypt.html#keyprotect) en el clúster para cifrar los secretos nuevos y existentes, como el secreto que almacena las credenciales de las instancias de servicio de {{site.data.keyword.Bluemix_notm}}.
{: tip}

Antes de empezar:
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).
- [Añada un servicio de {{site.data.keyword.Bluemix_notm}} a su clúster](#adding_cluster).

### Montaje del secreto como un volumen en el pod
{: #mount_secret}

Cuando monta el secreto como volumen en el pod, un archivo denominado `binding` se almacena en el directorio de montaje del volumen. El archivo `binding` en formato JSON incluye toda la información y las credenciales que necesita para acceder al servicio de {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

1.  Liste los secretos disponibles en el clúster y anote el **nombre** del secreto. Busque un secreto de tipo **opaco**. Si existen varios secretos, póngase en contacto con el administrador del clúster para identificar el secreto correcto del servicio.

    ```
    kubectl get secrets
    ```
    {: pre}

    Salida de ejemplo:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Cree un archivo YAML para el despliegue de Kubernetes y monte el secreto como un volumen en el pod.
    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: registry.bluemix.net/ibmliberty:latest
            name: secret-test
            volumeMounts:
            - mountPath: <mount_path>
              name: <volume_name>
          volumes:
          - name: <volume_name>
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <caption>Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts.mountPath</code></td>
    <td>La vía de acceso absoluta del directorio en el que el que está montado el volumen dentro del contenedor.</td>
    </tr>
    <tr>
    <td><code>volumeMounts.name</code></br><code>volumes.name</code></td>
    <td>El nombre del volumen que va a montar en el pod.</td>
    </tr>
    <tr>
    <td><code>secret.defaultMode</code></td>
    <td>Los permisos de lectura y escritura en el secreto. Utilice `420` para establecer permisos de solo lectura. </td>
    </tr>
    <tr>
    <td><code>secret.secretName</code></td>
    <td>El nombre del secreto que ha anotado en el paso anterior.</td>
    </tr></tbody></table>

3.  Cree el pod y monte el secreto como un volumen.
    ```
    kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  Verifique que se ha creado el pod.
    ```
    kubectl get pods
    ```
    {: pre}

    Ejemplo de salida de CLI:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  Acceda a las credenciales de servicio.
    1. Inicie una sesión en el pod.
       ```
       kubectl exec <pod_name> -it bash
       ```
       {: pre}

    2. Vaya a la vía de acceso de montaje de volumen que ha definido anteriormente y liste los archivos en la vía de acceso de montaje del volumen.
       ```
       cd <volume_mountpath> && ls
       ```
       {: pre}

       Salida de ejemplo:
       ```
       enlace
       ```
       {: screen}

       El archivo `binding` incluye las credenciales de servicio que ha almacenado en el secreto de Kubernetes.

    4. Consulte las credenciales de servicio. Las credenciales se almacenan como pares de valor de clave en formato JSON.
       ```
       cat binding
       ```
       {: pre}

       Salida de ejemplo:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. Configure la app para analizar el contenido JSON y recuperar la información que necesita para acceder al servicio.


### Cómo hacer referencia al secreto en las variables de entorno
{: #reference_secret}

Puede añadir las credenciales de servicio y otros pares de valores de clave del secreto de Kubernetes como variables de entorno en el despliegue.   
{: shortdesc}

1. Liste los secretos disponibles en el clúster y anote el **nombre** del secreto. Busque un secreto de tipo **opaco**. Si existen varios secretos, póngase en contacto con el administrador del clúster para identificar el secreto correcto del servicio.

    ```
    kubectl get secrets
    ```
    {: pre}

    Salida de ejemplo:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m
    ```
    {: screen}

2. Obtenga los detalles del secreto para encontrar pares potenciales de valores de clave a los que pueda hacer referencia como variables de entorno en el pod. Las credenciales de servicio se almacenan en la clave `binding` del secreto.
   ```
   kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
   ```
   {: pre}

   Salida de ejemplo:
   ```
   apiVersion: v1
   data:
     binding: <binding>
   kind: Secret
   metadata:
     annotations:
       service-instance-id: 7123acde-c3ef-4ba2-8c52-439ac007fa70
       service-key-id: 9h30dh8a-023f-4cf4-9d96-d12345ec7890
     creationTimestamp: 2018-08-07T20:47:14Z
     name: binding-<service_instance_name>
     namespace: <namespace>
     resourceVersion: "6145900"
     selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
     uid: 12345a31-9a83-11e8-ba83-cd49014748f
   type: Opaque
   ```
   {: screen}

3. Cree un archivo YAML para el despliegue de Kubernetes y especifique una variable de entorno que haga referencia a la clave `binding`.
   ```
   apiVersion: apps/v1beta1
   kind: Deployment
   metadata:
     labels:
       app: secret-test
     name: secret-test
     namespace: <my_namespace>
   spec:
     selector:
       matchLabels:
         app: secret-test
     template:
       metadata:
         labels:
           app: secret-test
       spec:
         containers:
         - image: registry.bluemix.net/ibmliberty:latest
           name: secret-test
           env:
           - name: BINDING
             valueFrom:
               secretKeyRef:
                 name: binding-<service_instance_name>
                 key: binding
     ```
     {: codeblock}

     <table>
     <caption>Visión general de los componentes del archivo YAML</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
     </thead>
     <tbody>
     <tr>
     <td><code>containers.env.name</code></td>
     <td>El nombre de la variable de entorno.</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.name</code></td>
     <td>El nombre del secreto que ha anotado en el paso anterior.</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.key</code></td>
     <td>La clave que forma parte de su secreto y a la que desea hacer referencia en la variable de entorno. Para hacer referencia a las credenciales de servicio, debe utilizar la clave <strong>binding</strong>.  </td>
     </tr>
     </tbody></table>

4. Cree el pod que hace referencia a la clave `binding` del secreto como variable de entorno.
   ```
   kubectl apply -f secret-test.yaml
   ```
   {: pre}

5. Verifique que se ha creado el pod.
   ```
   kubectl get pods
   ```
   {: pre}

   Ejemplo de salida de CLI:
   ```
   NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
   ```
   {: screen}

6. Compruebe que la variable de entorno se haya establecido correctamente.
   1. Inicie una sesión en el pod.
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. Enumere todas las variables de entorno en el pod.
      ```
      env
      ```
      {: pre}

      Salida de ejemplo:
      ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. Configure la app para leer la variable de entorno y analizar el contenido JSON para recuperar la información que necesita para acceder al servicio.

   Código de ejemplo en Python:
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## Configuración de Helm en {{site.data.keyword.containerlong_notm}}
{: #helm}

[Helm ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://helm.sh) es un gestor de paquetes de Kubernetes. Puede crear diagramas de Helm o utilizar diagramas de Helm preexistentes para definir, instalar y actualizar utilizar aplicaciones de Kubernetes complejas que se ejecuten en clústeres de {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Antes de utilizar diagramas de Helm con {{site.data.keyword.containerlong_notm}}, debe instalar e inicializar una instancia de Helm en el clúster. A continuación, puede añadir el repositorio de Helm de {{site.data.keyword.Bluemix_notm}} a la instancia de Helm.

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).

1. Instale la <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">CLI de Helm <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.

2. **Importante**: para mantener la seguridad del clúster, cree una cuenta de servicio para Tiller en el espacio de nombres `kube-system` y un enlace de rol de clúster RBAC de Kubernetes para el pod `tiller-deploy` mediante la aplicación del siguiente archivo `.yaml` desde el repositorio de [{{site.data.keyword.Bluemix_notm}} `kube-samples`](https://github.com/IBM-Cloud/kube-samples/blob/master/rbac/serviceaccount-tiller.yaml). **Nota**: Para instalar Tiller con la cuenta de servicio y el enlace de rol de clúster en el espacio de nombres `kube-system`, debe tener el [rol `cluster-admin`](cs_users.html#access_policies).
    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/rbac/serviceaccount-tiller.yaml
    ```
    {: pre}

3. Inicialice Helm e instale `tiller` con la cuenta de servicio que acaba de crear.

    ```
    helm init --service-account tiller
    ```
    {: pre}

4. Verifique que el pod `tiller-deploy` tiene el **Estado** `En ejecución` en el clúster.

    ```
    kubectl get pods -n kube-system -l app=helm
    ```
    {: pre}

    Salida de ejemplo:

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. Añada los repositorios de Helm de {{site.data.keyword.Bluemix_notm}} a la instancia de Helm.

    ```
    helm repo add ibm https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

    ```
    helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
    ```
    {: pre}

6. Obtenga una lista de los diagramas de Helm disponibles actualmente en los repositorios de {{site.data.keyword.Bluemix_notm}}.

    ```
    helm search ibm
    ```
    {: pre}

    ```
    helm search ibm-charts
    ```
    {: pre}

7. Para obtener más información sobre un gráfico, obtenga una lista de sus valores y los valores predeterminados.

    Por ejemplo, para visualizar los valores, la documentación y los valores predeterminados para el gráfico Helm del servicio strongSwan IPSec VPN:

    ```
    helm inspect ibm/strongswan
    ```
    {: pre}


### Enlaces de Helm relacionados
{: #helm_links}

* Para utilizar el diagrama de Helm de strongSwan, consulte [Configuración de la conectividad de VPN con el diagrama de Helm del servicio VPN IPSec de strongSwan](cs_vpn.html#vpn-setup).
* Consulte los diagramas de Helm disponibles que puede utilizar con {{site.data.keyword.Bluemix_notm}} en la GUI del [catálogo de diagramas de Helm ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts) GUI.
* Obtenga más información sobre los mandatos Helm que se utilizan para configurar y gestionar diagramas de Helm en la <a href="https://docs.helm.sh/helm/" target="_blank">documentación de Helm <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.
* Obtenga más información sobre cómo [aumentar la velocidad del despliegue con diagramas de Helm de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/).

## Visualización de recursos de un clúster de Kubernetes
{: #weavescope}

Weave Scope proporciona un diagrama visual de los recursos de un clúster de Kubernetes, incluidos servicios, pods, contenedores, etc. Weave Scope ofrece métricas interactivas correspondientes a CPU y memoria y herramientas para realizar seguimientos y ejecuciones en un contenedor.
{:shortdesc}

Antes de empezar:

-   Recuerde no exponer la información del clúster en Internet público. Siga estos pasos para desplegar de forma segura Weave Scope y para acceder al mismo localmente desde un navegador web.
-   Si aún no tiene uno, [cree un clúster estándar](cs_clusters.html#clusters_ui). Weave Scope puede consumir mucha CPU, especialmente la app. Ejecute Weave Scope con clústeres de pago grandes, no con clústeres gratuitos.
-   [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).


Para utilizar Weave Scope con una clúster:
2.  Despliegue una de los archivos de configuración de permisos RBAC del clúster.

    Para habilitar los permisos de lectura/escritura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Para habilitar los permisos de solo lectura:

    ```
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Salida:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Despliegue el servicio Weave Acope, al que puede acceder de forma privada con la dirección IP del clúster.

    <pre class="pre">
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Salida:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Ejecute un mandato de reenvío de puerto para que abrir el servicio en el sistema. La próxima vez que acceda a Weave Scope, podrá ejecutar este mandato sin realizar de nuevo los pasos de configuración anteriores.

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Salida:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Abra el navegador web en `http://localhost:4040`. Sin los componentes predeterminados desplegados, verá el siguiente diagrama. Seleccione la vista de diagramas o tablas de topología de los recursos de Kubernetes en el clúster.

     <img src="images/weave_scope.png" alt="Ejemplo de topología de Weave Scope" style="width:357px;" />


[Más información sobre las características de Weave Scope ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.weave.works/docs/scope/latest/features/).

<br />

