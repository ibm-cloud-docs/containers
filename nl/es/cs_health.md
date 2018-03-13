---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Registro y supervisión de clústeres
{: #health}

Configure el registro y la supervisión de clústeres para que le ayude a resolver problemas con los clústeres y apps y supervisar el estado y el rendimiento de los clústeres.
{:shortdesc}

## Configuración del registro de clúster
{: #logging}

Puede enviar registros a una ubicación específica para su procesamiento o almacenamiento a largo plazo. En un clúster de Kubernetes en {{site.data.keyword.containershort_notm}}, puede habilitar el reenvío de registros a varios orígenes de registro de clúster y elegir dónde se reenvían los registros. **Nota**: el reenvío de registros solo se soporta para los clústeres estándares.
{:shortdesc}

Puede reenviar registros para orígenes de registro, como aplicaciones, nodos trabajadores, clústeres de Kubernetes y controladores de Ingress. Revise la tabla siguiente para obtener información sobre cada origen de registro.

|Origen de registro|Características|Vías de acceso de registro|
|----------|---------------|-----|
|`contenedor`|Registra el contenedor que se ejecuta en un clúster de Kubernetes.|-|
|`aplicación`|Registra la aplicación que se ejecuta en un clúster de Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Registra nodos trabajadores de máquinas virtuales dentro de un clúster de Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Registra el componente del sistema de Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Registra un equilibrador de carga de aplicación de Ingress que gestiona el tráfico de red entrante en un clúster de Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Características del origen de registro" caption-side="top"}

## Habilitación del reenvío de registros
{: #log_sources_enable}

Puede reenviar registros a {{site.data.keyword.loganalysislong_notm}} o a un servidor syslog externo. Si desea reenviar los registros de un origen de registro a ambos servidores del recopilador de registro, debe crear dos configuraciones de registro. **Nota**: Para reenviar registros para aplicaciones, consulte [Habilitación del reenvío de registros para aplicaciones](#apps_enable).
{:shortdesc}

Antes de empezar:

1. Si desea reenviar los registros a un servidor syslog externo, puede configurar un servidor que acepte un protocolo syslog de dos maneras:
  * Puede configurar y gestionar su propio servidor o dejar que lo gestione un proveedor. Si un proveedor gestiona el servidor, obtenga el punto final de registro del proveedor de registro.
  * Puede ejecutar syslog desde un contenedor. Por ejemplo, puede utilizar este archivo [deployment .yaml ![Icono de archivo externo](../icons/launch-glyph.svg "Icono de archivo externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para obtener una imagen pública de Docker que ejecute un contenedor en un clúster de Kubernetes. La imagen publica el puerto `514` en la dirección IP del clúster público y utiliza esta dirección IP del clúster público para configurar el host de syslog.

2. Elija como [destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster en el que se encuentra el origen de registro.

Para habilitar el reenvío de registros para un contenedor, nodo trabajador, componente del sistema Kubernetes, aplicación o equilibrador de carga de aplicación de Ingress:

1. Cree una configuración de reenvío de registro.

  * Para reenviar registros a {{site.data.keyword.loganalysislong_notm}}:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>El mandato para crear una configuración de reenvío de registro de {{site.data.keyword.loganalysislong_notm}}.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_log_source&gt;</em> por el origen de registro. Los valores aceptados son <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Sustituya <em>&lt;kubernetes_namespace&gt;</em> por el espacio de nombres de Kubernetes desde el que desea reenviar los registros. El reenvío de registros no recibe soporte para los espacios de nombres de Kubernetes <code>ibm-system</code> y <code>kube-system</code>. Este valor sólo es válido para el origen de registro de contenedor y es opcional. Si no especifica un espacio de nombres, todos los espacios de nombres del clúster utilizarán esta configuración.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>Sustituya <em>&lt;ingestion_URL&gt;</em> con el URL de ingestión de {{site.data.keyword.loganalysisshort_notm}}. Puede encontrar la lista de URL de ingestión disponible [aquí](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Si no especifica un URL de ingestión, se utiliza el punto final de la región en la que se ha creado el clúster.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>Sustituya <em>&lt;ingestion_port&gt;</em> con el puerto ingestión. Si no especifica un puerto, se utiliza el puerto estándar, <code>9091</code>.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_space&gt;</em> con el nombre del espacio de Cloud Foundry al que desea enviar registros. Si no especifica un espacio, los registros se envían al nivel de cuenta.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_org&gt;</em> con el nombre de la organización de Cloud Foundry en la que está el espacio. Este valor es necesario si ha especificado un espacio.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>El tipo de registro para enviar registros a {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Para reenviar registros a un servidor syslog externo:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>El mandato para crear una configuración de reenvío de registro de syslog.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_log_source&gt;</em> por el origen de registro. Los valores aceptados son <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Sustituya <em>&lt;kubernetes_namespace&gt;</em> por el espacio de nombres de Kubernetes desde el que desea reenviar los registros. El reenvío de registros no recibe soporte para los espacios de nombres de Kubernetes <code>ibm-system</code> y <code>kube-system</code>. Este valor sólo es válido para el origen de registro de contenedor y es opcional. Si no especifica un espacio de nombres, todos los espacios de nombres del clúster utilizarán esta configuración.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_server_hostname&gt;</em> por el nombre de host o dirección IP del servicio del recopilador de registro.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_server_port&gt;</em> por el puerto del servidor del recopilador de registro. Si no especifica un puerto, se utiliza el puerto estándar, <code>514</code>.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>El tipo de registro para enviar registros a un servidor syslog externo.</td>
    </tr>
    </tbody></table>

2. Verifique que la configuración de reenvío de registros se ha creado.

    * Para obtener una lista de todas las configuraciones de registro del clúster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Para obtener una lista de las configuraciones de registro para un tipo de origen de registro:
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}


### Habilitación del reenvío de registros para aplicaciones
{: #apps_enable}

Los registros desde aplicaciones se deben limitar a un directorio específico del nodo principal. Para hacerlo, monte un volumen de vía de acceso de host a los contenedores con una vía de acceso de montaje. Esta vía de acceso de montaje sirve de directorio en los contenedores donde se envían los registros de aplicación. El directorio de la vía de acceso del host predefinido, `/var/log/apps`, se crea automáticamente al crear el montaje de volumen.

Revise los siguientes aspectos del reenvío de registro de aplicación:
* Los registros se leen recursivamente desde la vía de acceso /var/log/apps. Esto significa que puede colocar registros de aplicación en subdirectorios de la vía de acceso /var/log/apps.
* Solo se reenvía los archivos de registro de aplicación con las extensiones de archivo `.log` o `.err`.
* Cuando se habilita el reenvío de registro por primera vez, los registros de aplicación no se leen desde el principio. Es decir, el contenido de los registros que ya existían antes de la habilitación del registro de aplicación no se leen. Los registros se leen a partir del momento en que se habilita el registro. Sin embargo, a partir de la primera vez en que se habilita el reenvío de registro, los registros se recogen desde donde se dejaron.
* Cuando monte el volumen de la vía de acceso de host `/var/log/apps` en los contenedores, grabe todos los contenedores en este directorio. Esto significa que si los contenedores están grabando en el mismo nombre de archivo, los contenedores grabarán exactamente en el mismo archivo del host. Si esta no es su intención, puede evitar que los contenedores sobrescriban los mismos archivos de registro asignando otro nombre a los archivos de registro de cada contenedor.
* Puesto que todos los contenedores graban en el mismo nombre de archivo, no se debe utilizar este método para reenviar registros de aplicaciones de ReplicaSets. En su lugar, puede escribir los registros desde la aplicación a STDOUT y STDERR, que se seleccionan como registros de contenedor. Para reenviar registros de aplicaciones grabadas en STDOUT y STDERR, siga los pasos de [Habilitación del reenvío de registro](cs_health.html#log_sources_enable).

Antes de empezar, [destino su CLI](cs_cli_install.html#cs_cli_configure) para el clúster donde se encuentra el origen de registro.

1. Abra el archivo de configuración `.yaml` del pod de la aplicación.

2. Añada `volumeMounts` y `volúmenes` al archivo de configuración:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Monte el volumen en el pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Para crear una configuración de reenvío de registros, siga los pasos de [Habilitación del reenvío de registro](cs_health.html#log_sources_enable).

<br />


## Actualización de la configuración de reenvío de registros
{: #log_sources_update}

Puede actualizar una configuración de registro para un contenedor, aplicación, nodo trabajador, componente del sistema Kubernetes o equilibrador de carga de aplicación de Ingress.
{: shortdesc}

Antes de empezar:

1. Si está cambiando el servidor del recopilador de registros a syslog, puede configurar un servidor que acepte un protocolo syslog de dos maneras:
  * Puede configurar y gestionar su propio servidor o dejar que lo gestione un proveedor. Si un proveedor gestiona el servidor, obtenga el punto final de registro del proveedor de registro.
  * Puede ejecutar syslog desde un contenedor. Por ejemplo, puede utilizar este archivo [deployment .yaml ![Icono de archivo externo](../icons/launch-glyph.svg "Icono de archivo externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para obtener una imagen pública de Docker que ejecute un contenedor en un clúster de Kubernetes. La imagen publica el puerto `514` en la dirección IP del clúster público y utiliza esta dirección IP del clúster público para configurar el host de syslog.

2. Elija como [destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster en el que se encuentra el origen de registro.

Para cambiar los detalles de una configuración de registro:

1. Actualice la configuración de registro.

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>El mandato para actualizar la configuración del reenvío de registros para el origen de registro.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_config_id&gt;</em> por el ID de la configuración del origen de registro.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_log_source&gt;</em> por el origen de registro. Los valores aceptados son <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Cuando el tipo de registro es <code>syslog</code>, sustituya <em>&lt;log_server_hostname_or_IP&gt;</em> con el nombre de host o dirección IP del servicio del recopilador de registro. Cuando el tipo de registro es <code>ibm</code>, sustituya <em>&lt;log_server_hostname&gt;</em> con el URL de ingestión de {{site.data.keyword.loganalysislong_notm}}. Puede encontrar la lista de URL de ingestión disponible [aquí](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Si no especifica un URL de ingestión, se utiliza el punto final de la región en la que se ha creado el clúster.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_server_port&gt;</em> por el puerto del servidor del recopilador de registro. Si no especifica un puerto, se utiliza el puerto estándar <code>514</code> para <code>syslog</code> y el <code>9091</code> para <code>ibm</code>.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_space&gt;</em> con el nombre del espacio de Cloud Foundry al que desea enviar registros. Este valor sólo es válido para el registro de tipo <code>ibm</code> y es opcional. Si no especifica un espacio, los registros se envían al nivel de cuenta.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_org&gt;</em> con el nombre de la organización de Cloud Foundry en la que está el espacio. Este valor sólo es válido para el registro de tipo <code>ibm</code> y es necesario si ha especificado un espacio.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Sustituya <em>&lt;logging_type&gt;</em> por protocolo de reenvío de registros que desea utilizar. Actualmente se da soporte a <code>syslog</code> e <code>ibm</code>.</td>
    </tr>
    </tbody></table>

2. Verifique que la configuración de reenvío de registros se ha actualizado.

    * Para obtener una lista de todas las configuraciones de registro del clúster:

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Para obtener una lista de las configuraciones de registro para un tipo de origen de registro:

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

<br />


## Detención del reenvío de registros
{: #log_sources_delete}

Puede detener el reenvío de registros mediante la supresión de la configuración de registro.

Antes de empezar, [destino su CLI](cs_cli_install.html#cs_cli_configure) para el clúster donde se encuentra el origen de registro.

1. Suprima la configuración de registro.

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
    Sustituya <em>&lt;my_cluster&gt;</em> por el nombre del clúster en el que está la configuración de registro y <em>&lt;log_config_id&gt;</em> por el ID de la configuración del origen de registro.

<br />


## Configuración de reenvío de registros para registros de auditoría de API de Kubernetes
{: #app_forward}

Los registros de auditoría de API de Kubernetes capturan las llamadas al servidor de API de Kubernetes desde el clúster. Para empezar a recopilar registros de auditoría de API de Kubernetes, puede configurar el servidor de API de Kubernetes para establecer un programa de fondo de webhook para el clúster. Este programa de fondo de webhook permite enviar registros a un servidor remoto. Para obtener más información sobre los registros de auditoría de Kubernetes, consulte el <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">tema sobre auditoría <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> en la documentación de Kubernetes.

**Nota**:
* El reenvío de registros de auditoría de API de Kubernetes sólo está admitido en la versión 1.7 de Kubernetes y posterior.
* Actualmente, se utiliza una política de auditoría predeterminada para todos los clústeres con esta configuración de registro.

### Habilitación del reenvío de registros de auditoría de API de Kubernetes
{: #audit_enable}

Antes de empezar:

1. Configure un servidor de registro remoto donde puede reenviar los registros. Por ejemplo, puede [utilizar Logstash con Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) para recopilar sucesos de auditoría.

2. [Dirija su CLI](cs_cli_install.html#cs_cli_configure) al clúster del que desea recopilar registros de auditoría de servidor de API.

Para reenviar registros de auditoría de API de Kubernetes:

1. Establecer el programa de fondo del webhook para la configuración del servidor de API. Se crea una configuración de webhook basándose en la información que proporciona en los distintivos de este mandato. Si no proporciona ninguna información en los distintivos, se utiliza una configuración de webhook predeterminada.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>El mandato para establecer una opción para la configuración de servidor de API de Kubernetes del clúster.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>El submandato para establecer la configuración del webhook de auditoría del servidor de API de Kubernetes del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>Sustituya <em>&lt;server_URL&gt;</em> con la dirección IP o el URL del servicio de registro remoto al que desea enviar registros. Si proporciona un URL de servidor no seguro, se ignoran los certificados.</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Sustituya <em>&lt;CA_cert_path&gt;</em> con la vía de acceso de archivo del certificado de CA que se utiliza para verificar el servicio de registro remoto.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>Sustituya <em>&lt;client_cert_path&gt;</em> con la vía de acceso de archivo del certificado de cliente que se utiliza para autenticarse en el servicio de registro remoto.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>Sustituya <em>&lt;client_key_path&gt;</em> con la vía de acceso de archivo de la clave de cliente correspondiente que se utiliza para conectarse al servicio de registro remoto.</td>
    </tr>
    </tbody></table>

2. Verifique que el reenvío de registros se ha habilitado consultando el URL del servicio de registro remoto.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    Salida de ejemplo:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Aplique la actualización de configuración reiniciando el maestro de Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Detención del reenvío de registros de auditoría de API de Kubernetes
{: #audit_delete}

Puede detener el reenvío de registros de auditoría inhabilitando la configuración del programa de fondo del webhook para el servidor de API del clúster.

Antes de empezar, seleccione [como destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster del que desea dejar de recopilar los registros de auditoría del servidor de API.

1. Inhabilitar la configuración del programa de fondo del webhook para el servidor de API del clúster.

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Aplique la actualización de configuración reiniciando el maestro de Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## Visualización de registros
{: #view_logs}

Para ver los registros de clústeres y contenedores, puede utilizar las características estándares de registro de Kubernetes y Docker.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Para clústeres estándares, los registros se encuentran en la cuenta de {{site.data.keyword.Bluemix_notm}} en el que ha iniciado la sesión al crear el clúster de Kubernetes. Si ha especificado un espacio de {{site.data.keyword.Bluemix_notm}} al crear el clúster o al crear la configuración de registro, entonces los registros están ubicados en el espacio en cuestión. Los registros se supervisan y se reenvían fuera del contenedor. Puede acceder a los registros de un contenedor mediante el panel de control de Kibana. Para obtener más información sobre el registro, consulte [Registro para el {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Nota**: si ha especificado un espacio al crear el clúster o la configuración de registro, el propietario de la cuenta necesita permisos de gestor, desarrollador o auditor para dicho espacio para ver registros. Para obtener más información sobre cómo cambiar políticas de acceso y permisos de {{site.data.keyword.containershort_notm}}, consulte [Gestión de acceso a clústeres](cs_users.html#managing). Cuando se cambian los permisos, los registros pueden tardar hasta 24 horas en aparecer.

Para acceder al panel de control de Kibana, vaya a uno de los siguientes URL y seleccione la cuenta o espacio de {{site.data.keyword.Bluemix_notm}} en la que ha creado el clúster.
- EE.UU. sur y EE.UU. este: https://logging.ng.bluemix.net
- UK sur: https://logging.eu-gb.bluemix.net
- UE central: https://logging.eu-fra.bluemix.net
- AP sur: https://logging.au-syd.bluemix.net

Para obtener más información sobre la visualización de registros, consulte [Navegación a Kibana desde un navegador web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Registros de Docker
{: #view_logs_docker}

Puede aprovechar las funciones incorporadas de registro de Docker para revisar las actividades de las secuencias de salida estándar STDOUT y STDERR. Para obtener más información, consulte [Visualización de registros de contenedor para un contenedor que se ejecute en un clúster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Configuración de la supervisión del clúster
{: #monitoring}

Las métricas le ayudan a supervisar el estado y el rendimiento de sus clústeres. Puede configurar la supervisión del estado de los nodos trabajadores para detectar de forma automática los trabajadores que pasen a un estado degradado o no operativo. **Nota**: La supervisión se soporta solo para los clústeres estándares.
{:shortdesc}

## Visualización de métricas
{: #view_metrics}

Puede utilizar las funciones estándares de Kubernetes y Docker para supervisar el estado de sus clústeres y apps.
{:shortdesc}

<dl>
<dt>Página de detalles del clúster en {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} proporciona información sobre el estado y la capacidad del clúster y sobre el uso de los recursos del clúster. Puede utilizar esta
GUI para escalar los clústeres, trabajar con el almacenamiento permanente y añadir funciones adicionales al clúster mediante la vinculación de servicios de {{site.data.keyword.Bluemix_notm}}. Para ver la página de detalles de un clúster, vaya al **Panel de control de {{site.data.keyword.Bluemix_notm}}** y seleccione un clúster.</dd>
<dt>Panel de control de Kubernetes</dt>
<dd>El panel de control de Kubernetes es una interfaz web administrativa que puede utilizar para revisar el estado de los nodos trabajadores, buscar recursos de Kubernetes, desplegar apps contenerizadas y resolver problemas de apps en función de la información de registro y supervisión. Para obtener más información sobre cómo acceder al panel de control de Kubernetes, consulte [Inicio del panel de control de Kubernetes para {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>En el caso de los clústeres estándares, las métricas se encuentran en el espacio de {{site.data.keyword.Bluemix_notm}} al que se inició sesión cuando se creó el clúster de Kubernetes. Si ha especificado un espacio de {{site.data.keyword.Bluemix_notm}} al crear el clúster, entonces las métricas están ubicados en el espacio en cuestión. Las métricas de contenedor se recopilan automáticamente para todos los contenedores desplegados en un clúster. Estas métricas se envían y se ponen a disponibilidad mediante Grafana. Para obtener más información sobre las métricas, consulte el tema sobre [Supervisión de {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Para acceder al panel de control de Grafana, vaya a uno de los siguientes URL y seleccione la cuenta o espacio de {{site.data.keyword.Bluemix_notm}} en la que ha creado el clúster.<ul><li>EE.UU. Sur y EE.UU. este: https://metrics.ng.bluemix.net</li><li>UK-Sur: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

### Otras herramientas de supervisión de estado
{: #health_tools}

Puede configurar otras herramientas para disponer de funciones adicionales.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus es una herramienta de supervisión, registro y generación de alertas diseñada para Kubernetes. La herramienta recupera información detallada acerca del clúster, los nodos trabajadores y el estado de despliegue basado en la información de registro de Kubernetes. Para obtener información sobre la configuración, consulte [Integración de servicios con {{site.data.keyword.containershort_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configuración de la supervisión de estado de los nodos trabajadores con recuperación automática
{: #autorecovery}

El sistema de recuperación automática de {{site.data.keyword.containerlong_notm}} se puede desplegar en clústeres existentes de Kubernetes versión 1.7 o posterior. El sistema de recuperación automática utiliza varias comprobaciones para consultar el estado de salud del nodo trabajador de la consulta. Si la recuperación automática detecta un nodo trabajador erróneo basado en las comprobaciones configuradas, desencadena una acción correctiva, como una recarga del sistema operativo, en el nodo trabajador. Solo se aplica una acción correctiva por nodo trabajador cada vez. El nodo trabajador debe completar correctamente la acción correctiva antes de otro nodo trabajador empiece otra acción correctiva. Para obtener más información, consulte esta [publicación del blog sobre recuperación automática ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**NOTA**: La recuperación automática requiere que al menos haya un nodo en buen estado que funcione correctamente. Configure la recuperación automática solo con las comprobaciones activas en los clústeres con dos o varios nodos trabajadores.

Antes de empezar, seleccione el clúster cuyos estados de nodos trabajadores desea comprobar como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

1. Cree un archivo de mapa de configuración que defina las comprobaciones en formato JSON. Por ejemplo, el siguiente archivo YAML define tres comprobaciones: una comprobación HTTP y dos comprobaciones de servidor API de Kubernetes. **Nota**: Cada comprobación debe definirse como una clave exclusiva en la sección de datos del mapa de configuración.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
      }
    ```
    {:codeblock}


<table summary="Visión general de los componentes del mapa de configuración">
<caption>Visión general de los componentes del mapa de configuración</caption>
<thead>
<th colspan=2><img src="images/idea.png"/>Visión general de los componentes del mapa de configuración</th>
</thead>
<tbody>
<tr>
<td><code>name</code></td>
<td>El nombre de configuración <code>ibm-worker-recovery-checks</code> es una constante y no se puede cambiar.</td>
</tr>
<tr>
<td><code>namespace</code></td>
<td>El espacio de nombre <code>kube-system</code> es una constante y no se puede cambiar.</td>
</tr>
<tr>
<td><code>checkhttp.json</code></td>
<td>Define una comprobación HTTP que comprueba si un servidor HTTP se está ejecutando en la dirección IP de cada nodo en el puerto 80 y devuelve una respuesta 200 en la vía de acceso <code>/myhealth</code>. Para encontrar la dirección IP de un nodo, ejecute <code>kubectl get nodes</code>.
Por ejemplo, considere dos nodos en un clúster que tienen las direcciones IP 10.10.10.1 y 10.10.10.2. En este ejemplo, se comprueban dos rutas para obtener respuestas 200 OK: <code>http://10.10.10.1:80/myhealth</code> y <code>http://10.10.10.2:80/myhealth</code>.
La comprobación del YAML de ejemplo anterior se ejecuta cada 3 minutos. Si falla 3 veces consecutivas, se rearrancará el nodo. Esta acción equivale a ejecutar <code>bx cs worker-reboot</code>. La comprobación HTTP está inhabilitada hasta que se establece el campo <b>Habilitado</b> en <code>true</code>.</td>
</tr>
<tr>
<td><code>checknode.json</code></td>
<td>Define una comprobación de nodo de API de Kubernetes que comprueba si cada nodo está en estado <code>Listo</code>. La comprobación de un nodo específico cuenta como fallo si el nodo no está en estado <code>Listo</code>.
La comprobación del YAML de ejemplo anterior se ejecuta cada 3 minutos. Si falla 3 veces consecutivas, se recarga el nodo. Esta acción equivale a ejecutar <code>bx cs worker-reload</code>. La comprobación de nodo está habilitada hasta que se establezca el campo <b>Habilitado</b> en <code>false</code> o se elimine la comprobación.</td>
</tr>
<tr>
<td><code>checkpod.json</code></td>
<td>Define una comprobación de pod de API que comprueba el porcentaje total de pods <code>NotReady</code> en un nodo en relación con el número total de pods asignados a dicho nodo. La comprobación de un nodo específico cuenta como fallo si el porcentaje total de pods <code>NotReady</code> es superior al definido en <code>PodFailureThresholdPercent</code>.
La comprobación del YAML de ejemplo anterior se ejecuta cada 3 minutos. Si falla 3 veces consecutivas, se recarga el nodo. Esta acción equivale a ejecutar <code>bx cs worker-reload</code>. La comprobación de pod está habilitada hasta que se establezca el campo <b>Habilitado</b> en <code>false</code> o se elimine la comprobación.</td>
</tr>
</tbody>
</table>


<table summary="Visión general de los componentes de reglas individuales">
<caption>Visión general de los componentes de reglas individuales</caption>
<thead>
<th colspan=2><img src="images/idea.png"/>Visión general de los componentes de reglas individuales </th>
</thead>
<tbody>
<tr>
<td><code>Check</code></td>
<td>Introduzca el tipo de comprobación que desee que utilice la recuperación automática. <ul><li><code>HTTP</code>: La recuperación automática llama a los servidores HTTP que se ejecutan en cada nodo para determinar si los nodos se están ejecutando correctamente.</li><li><code>KUBEAPI</code>: La recuperación automática llama al servidor de API de Kubernetes y lee los datos del estado de salud notificado por los nodos trabajadores.</li></ul></td>
</tr>
<tr>
<td><code>Resource</code></td>
<td>Cuando el tipo de comprobación es <code>KUBEAPI</code>, especifique el tipo de recurso que desee que compruebe la recuperación automática. Los valores aceptados son <code>NODE</code> o <code>PODS</code>.</td>
</tr>
<tr>
<td><code>FailureThreshold</code></td>
<td>Especifique el umbral para el número de comprobaciones consecutivas fallidas. Cuando se alcance el umbral, la recuperación automática desencadenará la acción correctiva especificada. Por ejemplo, si el valor es 3 y la recuperación automática falla una comprobación configurada tres veces consecutivas, la recuperación automática desencadena la acción correctiva asociada con la comprobación.</td>
</tr>
<tr>
<td><code>PodFailureThresholdPercent</code></td>
<td>Cuando el tipo de recurso sea <code>PODS</code>, especifique el umbral del porcentaje de pods en un nodo trabajador que puede encontrarse en estado [NotReady ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Este porcentaje se basa en el número total de pods que están programados para un nodo trabajador. Cuando una comprobación determina que el porcentaje de pods erróneos es superior al umbral, cuenta un error.</td>
</tr>
<tr>
<td><code>CorrectiveAction</code></td>
<td>Especifique que se ejecute la acción cuando se alcance el umbral de errores. Una acción correctiva solo se ejecuta cuando no se repara ningún otro trabajador y cuando el nodo trabajador no está en un período de calma tras una acción anterior. <ul><li><code>REBOOT</code>: Reinicia el nodo trabajador.</li><li><code>RELOAD</code>: Vuelve a cargar las configuraciones necesarias del nodo trabajador desde un SO limpio.</li></ul></td>
</tr>
<tr>
<td><code>CooloffSeconds</code></td>
<td>Especifique el número de segundos que debe esperar la recuperación automática para un nodo que ya ha emitido una acción correctiva. El período de calma empieza a la hora en que se emite la acción correctiva.</td>
</tr>
<tr>
<td><code>IntervalSeconds</code></td>
<td>Especifique el número de segundos entre comprobaciones consecutivas. Por ejemplo, si el valor es 180, la recuperación automática ejecuta la comprobación en cada nodo cada 3 minutos.</td>
</tr>
<tr>
<td><code>TimeoutSeconds</code></td>
<td>Especifique el número máximo de segundos que tarda una llamada de comprobación a la base de datos antes de que la recuperación automática finalice la operación de llamada. El valor <code>TimeoutSeconds</code> debe ser inferior al valor de <code>IntervalSeconds</code>.</td>
</tr>
<tr>
<td><code>Port</code></td>
<td>Cuando el tipo de comprobación sea <code>HTTP</code>, especifique el puerto con el que se debe vincular el servidor HTTP en los nodos trabajadores. Este puerto debe estar expuesto a la IP de cada nodo trabajador en el clúster. La recuperación automática requiere un número de puerto en todos los nodos para la comprobación de servidores. Utilice [DaemonSets ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)cuando despliegue un servidor personalizado en un clúster.</td>
</tr>
<tr>
<td><code>ExpectedStatus</code></td>
<td>Cuando el tipo de comprobación sea <code>HTTP</code>, especifique el estado del servidor HTTP que espera que se devuelva desde la comprobación. Por ejemplo, un valor de 200 indica que espera una respuesta <code>OK</code> del servidor.</td>
</tr>
<tr>
<td><code>Route</code></td>
<td>Cuando el tipo de comprobación es <code>HTTP</code>, especifique la vía de acceso solicitada desde el servidor HTTP. Este valor suele ser la vía de acceso de las métricas del servidor que se ejecuta en todos los nodos trabajadores.</td>
</tr>
<tr>
<td><code>Enabled</code></td>
<td>Especifique <code>true</code> para habilitar la comprobación o <code>false</code> para inhabilitar la comprobación.</td>
</tr>
</tbody>
</table>

2. Cree el mapa de configuración en el clúster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Verifique haber creado el mapa de configuración con el nombre `ibm-worker-recovery-checks` en el espacio de nombre `kube-system` con las comprobaciones adecuadas.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}


4. Despliegue la recuperación automática en el clúster aplicando este archivo YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. Pasados unos minutos, podrá comprobar la sección `Sucesos` en la salida del siguiente mandato para ver la actividad en el despliegue de la recuperación automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
