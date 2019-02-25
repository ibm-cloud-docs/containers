---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# Depuración de Ingress
{: #cs_troubleshoot_debug_ingress}

Si utiliza {{site.data.keyword.containerlong}}, tenga en cuenta estas técnicas para depurar Ingress y solucionar problemas de forma general.
{: shortdesc}

Ha expuesto a nivel público la app creando un recurso de Ingress para la app en el clúster. Sin embargo, cuando intenta conectar con la app a través de la dirección IP pública o subdominio del ALB, la conexión falla o se supera el tiempo de espera. Los pasos de las secciones siguientes pueden ayudarle a depurar la configuración de Ingress.

Asegúrese de definir un host solo en un recurso de Ingress. Si se define un host en varios recursos de Ingress, el ALB no puede reenviar el tráfico correctamente y puede que se produzcan errores.
{: tip}

Antes de empezar, asegúrese de tener las [políticas de acceso de {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform) siguientes:
  - Rol de plataforma **Editor** o **Administrador** para el clúster

## Paso 1: Compruebe si hay mensajes de error en los registros de despliegue de Ingress y de pod de ALB
{: #errors}

En primer lugar, compruebe si hay mensajes de error en los registros de pod de ALB y los sucesos de despliegue de recursos de Ingress. Estos mensajes de error pueden ayudarle a encontrar las causas raíz de las anomalías y a depurar aún más la configuración de Ingress en las secciones siguientes.
{: shortdesc}

1. Compruebe el despliegue de recursos de Ingress y busque mensajes de aviso o de error.
    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    En la sección de **sucesos** de la salida, es posible que vea mensajes de aviso sobre valores no válidos en el recurso de Ingress o en determinadas anotaciones que haya utilizado. Consulte la [documentación de configuración de recursos de Ingress](cs_ingress.html#public_inside_4) o la [documentación de anotaciones](cs_annotations.html).

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xxx,169.xx.xxx.xxx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.appdomain.cloud
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}
{: #check_pods}
2. Compruebe el estado de los pods de ALB.
    1. Obtenga los pods de ALB que se ejecutan en el clúster.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Asegúrese de que todos los pods están en ejecución seleccionando la columna **ESTADO**.

    3. Si un pod no está `En ejecución`, puede inhabilitar y volver a habilitar el ALB. En los mandatos siguientes, sustituya `<ALB_ID>` con el ID del ALB del pod. Por ejemplo, si el pod que no se está ejecutando tiene el nombre `public-crb2f60e9735254ac8b20b9c1e38b649a5-alb1-5d6d86fbbc-kxj6z`, el ID de ALB es `public-crb2f60e9735254ac8b20b9c1e38b649a5-alb1`.
        ```
        ibmcloud ks alb-configure --albID <ALB_ID> --disable
        ```
        {: pre}

        ```
        ibmcloud ks alb-configure --albID <ALB_ID> --enable
        ```
        {: pre}

3. Compruebe los registros para su ALB.
    1.  Obtenga los ID de los pods de ALB que se ejecutan en el clúster.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    3. Obtenga los registros para el contenedor `nginx-ingress` en cada pod de ALB.
        ```
        kubectl logs <ingress_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

    4. Mire si hay mensajes de error en los registros del ALB.

## Paso 2: Ejecute ping al subdominio del ALB y las direcciones IP públicas
{: #ping}

Compruebe la disponibilidad del subdominio de Ingress y las direcciones IP públicas de los ALB.
{: shortdesc}

1. Obtenga las direcciones IP en las que están a la escucha los ALB públicos.
    ```
    ibmcloud ks albs --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Salida de ejemplo para un clúster multizona con nodos trabajadores en `dal10` y `dal13`:

    ```
    ALB ID                                            Status     Type      ALB IP           Zone    Build
    private-cr24a9f2caf6554648836337d240064935-alb1   disabled   private   -                dal13   ingress:350/ingress-auth:192   
    private-cr24a9f2caf6554648836337d240064935-alb2   disabled   private   -                dal10   ingress:350/ingress-auth:192   
    public-cr24a9f2caf6554648836337d240064935-alb1    enabled    public    169.62.196.238   dal13   ingress:350/ingress-auth:192   
    public-cr24a9f2caf6554648836337d240064935-alb2    enabled    public    169.46.52.222    dal10   ingress:350/ingress-auth:192  
    ```
    {: screen}

    * Si un ALB público no tiene ninguna dirección IP, consulte [Ingress ALB no se despliega en una zona](cs_troubleshoot_network.html#cs_multizone_subnet_limit).

2. Compruebe el estado de las IP de ALB.

    * Para clústeres de una sola zona y clústeres multizona: haga ping a la dirección IP de cada ALB público para asegurarse de que los ALB son capaces de recibir paquetes correctamente. Si está utilizando ALB privados, puede hacer ping a sus direcciones IP sólo desde la red privada.
        ```
        ping <ALB_IP>
        ```
        {: pre}

        * Si la CLI devuelve un tiempo de espera y tiene un cortafuegos personalizado que protege los nodos trabajadores, asegúrese de permitir ICMP en el [cortafuegos](cs_troubleshoot_clusters.html#cs_firewall).
        * Si no hay ningún cortafuegos que esté bloqueando los pings y los pings siguen ejecutándose con el tiempo de espera, [compruebe el estado de los pods de ALB](#check_pods).

    * Solo clústeres multizona: puede utilizar la comprobación de estado de MZLB para determinar el estado de las IP de ALB. Para obtener más información sobre el MZLB, consulte [Equilibrador de carga multizona (MZLB)](cs_ingress.html#planning). La comprobación de estado de MZLB solo está disponible para los clústeres que tienen el nuevo subdominio de Ingress en el formato `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. Si el clúster sigue utilizando el formato antiguo de `<cluster_name>.<region>.containers.mybluemix.net`, [convierta el clúster de una sola zona en multizona](cs_clusters.html#add_zone). Se asigna al clúster un subdominio con el nuevo formato, pero también puede continuar utilizando el formato del subdominio antiguo. Como alternativa, puede solicitar un nuevo clúster al que se asigne automáticamente el nuevo formato de subdominio.

    El siguiente mandato cURL de HTTP utiliza el host `albhealth`, que está configurado por {{site.data.keyword.containerlong_notm}} para devolver los valores de estado `healthy` o `unhealthy` para una IP de ALB.
        ```
        curl -X GET http://169.62.196.238/ -H "Host: albhealth.mycluster-12345.us-south.containers.appdomain.cloud"
        ```
        {: pre}

        Salida de ejemplo:
        ```
        healthy
        ```
        {: screen}
        Si una o varias de las IP devuelven el valor `unhealthy`, [compruebe el estado de los pods de ALB](#check_pods).

3. Obtenga el subdominio de Ingress proporcionado por IBM.
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID> | grep Ingress
    ```
    {: pre}

    Salida de ejemplo:
    ```
    Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
    ```
    {: screen}

4. Asegúrese de que las IP de cada ALB público que ha obtenido en el paso 2 de esta sección se registran con el subdominio de Ingress proporcionado por IBM del clúster. Por ejemplo, en un clúster multizona, la IP de ALB pública de cada zona en la que tenga nodos trabajadores se debe registrar bajo el mismo nombre de host.

    ```
    kubectl get ingress -o wide
    ```
    {: pre}

    Salida de ejemplo:
    ```
    NAME                HOSTS                                                    ADDRESS                        PORTS     AGE
    myingressresource   mycluster-12345.us-south.containers.appdomain.cloud      169.46.52.222,169.62.196.238   80        1h
    ```
    {: screen}

## Paso 3: Compruebe las correlaciones de dominio y la configuración de recursos de Ingress
{: #config}

1. Si utiliza un dominio personalizado, verifique que ha utilizado el proveedor de DNS para correlacionar el dominio personalizado con el subdominio proporcionado por IBM o con la dirección IP pública de ALB. Tenga en cuenta que se prefiere el uso de un CNAME porque IBM proporciona comprobaciones de estado automáticas en el subdominio de IBM y elimina cualquier IP anómala de la respuesta de DNS.
    * Subdominio proporcionado por IBM: compruebe que el dominio personalizado esté correlacionado con el subdominio proporcionado por IBM del clúster en el registro de nombre canónico (CNAME).
        ```
        host www.my-domain.com
        ```
        {: pre}

        Salida de ejemplo:
        ```
        www.my-domain.com is an alias for mycluster-12345.us-south.containers.appdomain.cloud
        mycluster-12345.us-south.containers.appdomain.cloud has address 169.46.52.222
        mycluster-12345.us-south.containers.appdomain.cloud has address 169.62.196.238
        ```
        {: screen}

    * Dirección IP pública: compruebe que el dominio personalizado esté correlacionado con la dirección IP pública portátil de ALB en el registro A. Las IP deben coincidir con las IP de ALB públicas que ha obtenido en el paso 1 de la [sección anterior](#ping).
        ```
        host www.my-domain.com
        ```
        {: pre}

        Salida de ejemplo:
        ```
        www.my-domain.com has address 169.46.52.222
        www.my-domain.com has address 169.62.196.238
        ```
        {: screen}

2. Compruebe los archivos de configuración de recursos de Ingress para el clúster.
    ```
    kubectl get ingress -o yaml
    ```
    {: pre}

    1. Asegúrese de definir un host solo en un recurso de Ingress. Si se define un host en varios recursos de Ingress, el ALB no puede reenviar el tráfico correctamente y puede que se produzcan errores.

    2. Compruebe que el subdominio y el certificado TLS sean correctos. Para encontrar el subdominio de Ingress proporcionado por IBM y el certificado TLS, ejecute `ibmcloud ks cluster-get <cluster_name_or_ID>`.

    3.  Asegúrese de que su app está a la escucha en la misma vía de acceso que está configurada en la sección **path** de Ingress. Si la app se ha configurado para que escuche en la vía de acceso raíz, utilice `/` como vía de acceso. Si el tráfico de entrada a esta vía de acceso se debe direccionar a una vía de acceso distinta en la que la app está a la escucha, utilice la anotación de [vías de acceso de reescritura](cs_annotations.html#rewrite-path).

    4. Edite el YAML de configuración de recursos según sea necesario. Cuando se cierra el editor, los cambios se guardan y se aplican automáticamente.
        ```
        kubectl edit ingress <myingressresource>
        ```
        {: pre}

## Eliminación de un ALB del DNS para la depuración
{: #one_alb}

Si no puede acceder a la app a través de una IP de ALB específica, puede eliminar temporalmente el ALB de la producción inhabilitando su registro de DNS. A continuación, puede utilizar la dirección IP de ALB para ejecutar pruebas de depuración en ese ALB.

Por ejemplo, supongamos que tiene un clúster multizona en 2 zonas y los 2 ALB públicos tienen las direcciones IP `169.46.52.222` y `169.62.196.238`. A pesar de que la comprobación de estado devuelve el valor healthy para el ALB de la segunda zona, no se puede acceder directamente a la app a través de él. Decide eliminar esa dirección IP de ALB, `169.62.196.238`, de la producción para depurarla. La IP de ALB de la primera zona, `169.46.52.222`, se registra con el dominio y sigue direccionando tráfico mientras se depura el ALB de la segunda zona.

1. Obtenga el nombre del ALB con la dirección IP que no se puede alcanzar.
    ```
    ibmcloud ks albs --cluster <cluster_name> | grep <ALB_IP>
    ```
    {: pre}

    Por ejemplo, la IP `169.62.196.238` que no se puede alcanzar pertenece al ALB `public-cr24a9f2caf6554648836337d240064935-alb1`:
    ```
    ALB ID                                            Status     Type      ALB IP           Zone   Build
    public-cr24a9f2caf6554648836337d240064935-alb1    enabled    public    169.62.196.238   dal13   ingress:350/ingress-auth:192
    ```
    {: screen}

2. Utilizando el nombre de ALB del paso anterior, obtenga los nombres de los pods de ALB. El mandato utiliza el nombre de ALB de ejemplo del paso anterior:
    ```
    kubectl get pods -n kube-system | grep public-cr24a9f2caf6554648836337d240064935-alb1
    ```
    {: pre}

    Salida de ejemplo:
    ```
    public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-8rvtq   2/2       Running   0          24m
    public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-trqxc   2/2       Running   0          24m
    ```
    {: screen}

3. Inhabilite la comprobación de estado que se ejecuta para todos los pods de ALB. Repita estos pasos para cada pod de ALB que haya obtenido en el paso anterior. La salida y los mandatos de ejemplo de estos pasos utilizan el primer pod, `public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-8rvtq`.
    1. Inicie la sesión en el pod de ALB y compruebe la línea `server_name` en el archivo de configuración de NGINX.
        ```
        kubectl exec -ti public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-8rvtq -n kube-system -c nginx-ingress -- grep server_name /etc/nginx/conf.d/kube-system-alb-health.conf
        ```
        {: pre}

        Salida de ejemplo que confirma que el pod de ALB está configurado con el nombre de host de comprobación de estado correcto, `albhealth.<domain>`:
        ```
        server_name albhealth.mycluster-12345.us-south.containers.appdomain.cloud;
        ```
        {: screen}

    2. Para eliminar la IP inhabilitando la comprobación de estado, inserte `#` delante de `server_name`. Cuando se inhabilita el host virtual `albhealth.mycluster-12345.us-south.containers.appdomain.cloud` para el ALB, la comprobación de estado automatizada elimina automáticamente la IP de la respuesta de DNS.
        ```
        kubectl exec -ti public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-8rvtq -n kube-system -c nginx-ingress -- sed -i -e 's*server_name*#server_name*g' /etc/nginx/conf.d/kube-system-alb-health.conf
        ```
        {: pre}

    3. Verifique que se ha aplicado el cambio.
        ```
        kubectl exec -ti public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-8rvtq -n kube-system -c nginx-ingress -- grep server_name /etc/nginx/conf.d/kube-system-alb-health.conf
        ```
        {: pre}

        Salida de ejemplo:
        ```
        #server_name albhealth.mycluster-12345.us-south.containers.appdomain.cloud
        ```
        {: screen}

    4. Para eliminar la dirección IP del registro de DNS, vuelva a cargar la configuración de NGINX.
        ```
        kubectl exec -ti public-cr24a9f2caf6554648836337d240064935-alb1-7f78686c9d-8rvtq -n kube-system -c nginx-ingress -- nginx -s reload
        ```
        {: pre}

    5. Repita estos pasos para cada pod de ALB.

4. Ahora, cuando intenta cURL en el host `albhealth` para comprobar el estado de la IP de ALB, la comprobación falla.
    ```
    curl -X GET http://169.62.196.238/ -H "Host: albhealth.mycluster-12345.us-south.containers.appdomain.cloud"
    ```
    {: pre}

    Salida:
    ```
    <html>
        <head>
            <title>404 Not Found</title>
        </head>
        <body bgcolor="white"><center>
            <h1>404 Not Found</h1>
        </body>
    </html>
    ```
    {: screen}

5. Verifique que la dirección IP de ALB se ha eliminado del registro de DNS para el dominio comprobando el servidor de Cloudflare. Tenga en cuenta que el registro de DNS puede tardar unos minutos en actualizarse.
    ```
    host mycluster-12345.us-south.containers.appdomain.cloud ada.ns.cloudflare.com
    ```
    {: pre}

    Salida de ejemplo que confirma que solo la IP de ALB en buen estado, `169.46.52.222`, permanece en el registro de DNS y que la IP de ALB en mal estado, `169.62.196.238`, se ha eliminado:
    ```
    mycluster-12345.us-south.containers.appdomain.cloud has address 169.46.52.222
    ```
    {: screen}

6. Ahora que la dirección IP de ALB se ha eliminado de la producción, puede ejecutar pruebas de depuración en la app a través de ella. Para probar la comunicación a la app a través de esta IP, puede ejecutar el siguiente mandato cURL sustituyendo los valores de ejemplo por sus propios valores:
    ```
    curl -X GET --resolve mycluster-12345.us-south.containers.appdomain.cloud:443:169.62.196.238 https://mycluster-12345.us-south.containers.appdomain.cloud/
    ```
    {: pre}

    * Si todo está configurado correctamente, obtendrá la respuesta esperada de la app.
    * Si obtiene un error en la respuesta, puede que haya un error en la app o en una configuración que se aplique únicamente a este ALB específico. Compruebe el código de la app, los [archivos de configuración de recursos de Ingress](cs_ingress.html#public_inside_4) o cualquier otra configuración que haya aplicado sólo a este ALB.

7. Después de finalizar la depuración, restaure la comprobación de estado en los pods de ALB. Repita estos pasos para cada pod de ALB.
  1. Inicie la sesión en el pod de ALB y elimine el carácter `#` de `server_name`.
    ```
    kubectl exec -ti <pod_name> -n kube-system -c nginx-ingress -- sed -i -e 's*#server_name*server_name*g' /etc/nginx/conf.d/kube-system-alb-health.conf
    ```
    {: pre}

  2. Vuelva a cargar la configuración de NGINX para que se aplique la restauración de comprobación de estado.
    ```
    kubectl exec -ti <pod_name> -n kube-system -c nginx-ingress -- nginx -s reload
    ```
    {: pre}

9. Ahora, cuando hace cURL en el host `albhealth` para comprobar el estado de la IP de ALB, la comprobación devuelve el valor `healthy`.
    ```
    curl -X GET http://169.62.196.238/ -H "Host: albhealth.mycluster-12345.us-south.containers.appdomain.cloud"
    ```
    {: pre}

10. Verifique que la dirección IP de ALB se ha restaurado en registro de DNS para el dominio comprobando el servidor de Cloudflare. Tenga en cuenta que el registro de DNS puede tardar unos minutos en actualizarse.
    ```
    host mycluster-12345.us-south.containers.appdomain.cloud ada.ns.cloudflare.com
    ```
    {: pre}

    Salida de ejemplo:
    ```
    mycluster-12345.us-south.containers.appdomain.cloud has address 169.46.52.222
    mycluster-12345.us-south.containers.appdomain.cloud has address 169.62.196.238
    ```
    {: screen}

<br />


## Obtención de ayuda y soporte
{: #ts_getting_help}

¿Sigue teniendo problemas con su clúster?
{: shortdesc}

-  En el terminal, se le notifica cuando están disponibles las actualizaciones de la CLI y los plug-ins de `ibmcloud`. Asegúrese de mantener actualizada la CLI para poder utilizar todos los mandatos y distintivos disponibles.
-   Para ver si {{site.data.keyword.Bluemix_notm}} está disponible, [consulte la página de estado de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/support/#status).
-   Publique una pregunta en [Slack de {{site.data.keyword.containerlong_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibm-container-service.slack.com).
    Si no utiliza un ID de IBM para la cuenta de {{site.data.keyword.Bluemix_notm}}, [solicite una invitación](https://bxcs-slack-invite.mybluemix.net/) a este Slack.
    {: tip}
-   Revise los foros para ver si otros usuarios se han encontrado con el mismo problema. Cuando utiliza los foros para formular una pregunta, etiquete la pregunta para que la puedan ver los equipos de desarrollo de {{site.data.keyword.Bluemix_notm}}.
    -   Si tiene preguntas técnicas sobre el desarrollo o despliegue de clústeres o apps con {{site.data.keyword.containerlong_notm}}, publique su pregunta en [Stack Overflow ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) y etiquete su pregunta con `ibm-cloud`, `kubernetes` y `containers`.
    -   Para las preguntas relativas a las instrucciones de inicio y el servicio, utilice el foro [IBM Developer Answers ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluya las etiquetas `ibm-cloud` y `containers`.
    Consulte [Obtención de ayuda](/docs/get-support/howtogetsupport.html#using-avatar) para obtener más detalles sobre cómo utilizar los foros.
-   Póngase en contacto con el soporte de IBM abriendo un caso. Para obtener información sobre cómo abrir un caso de soporte de IBM, o sobre los niveles de soporte y las gravedades de los casos, consulte [Cómo contactar con el servicio de soporte](/docs/get-support/howtogetsupport.html#getting-customer-support).
Al informar de un problema, incluya el ID de clúster. Para obtener el ID de clúster, ejecute `ibmcloud ks clusters`.
{: tip}

