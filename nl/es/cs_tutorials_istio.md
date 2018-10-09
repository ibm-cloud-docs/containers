---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Guía de aprendizaje: Instalación de Istio en {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/info/istio) es una plataforma abierta para conectar, proteger, controlar y observar servicios de plataformas en la nube, como Kubernetes en {{site.data.keyword.containerlong}}. Istio permite gestionar el tráfico de red, proporciona equilibrio de carga entre microservicios, aplica políticas de acceso, verifica identidades de servicio, etc.
{:shortdesc}

En esta guía de aprendizaje, puede aprender cómo instalar Istio junto a cuatro microservicios para una sencilla app ficticia sobre libros denominada BookInfo. Los microservicios incluyen una página web de productos, detalles de libros, revisiones y evaluaciones. Cuando se despliegan los microservicios de BookInfo en un clúster de {{site.data.keyword.containerlong}} en el que está instalado Istio, se inyectan los proxies sidecar Envoy de Istio en los pods de cada microservicio.

## Objetivos

-   Desplegar el diagrama de Helm de Istio en el clúster
-   Desplegar la app de muestra BookInfo
-   Verificar el despliegue de la app BookInfo y utilizar round robin en las tres versiones del servicio de evaluaciones

## Tiempo necesario

30
minutos

## Público

Esta guía de aprendizaje está destinada a los desarrolladores de software y administradores de la red que están utilizando Istio por primera vez.

## Requisitos previos

-  [Instale la CLI de IBM Cloud, el plugin de {{site.data.keyword.containerlong_notm}} y la CLI de Kubernetes](cs_cli_install.html#cs_cli_install_steps). Istio precisa de Kubernetes versión 1.9 o superior. Asegúrese de instalar una versión de la CLI de `kubectl` que coincida con la versión de Kubernetes de su clúster.
-  [Cree un clúster que ejecute Kubernetes versión 1.9 o posterior](cs_clusters.html#clusters_cli), o bien [ actualice un clúster existente a la versión 1.9](cs_versions.html#cs_v19).
-  [Definir como destino de la CLI su clúster](cs_cli_install.html#cs_cli_configure).

## Lección 1: Descargar e instalar Istio
{: #istio_tutorial1}

Descargar e instalar Istio en el clúster.
{:shortdesc}

1. Instale Istio utilizando el [diagrama de Helm de Istio de IBM ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm/ibm-istio).
    1. [Configure Helm en el clúster y añada el repositorio de IBM a la instancia de Helm](cs_integrations.html#helm).
    2.  **Solo para versiones de Helm 2.9 o anteriores**: instale las definiciones de recursos personalizadas de Istio.
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. Instale el diagrama de Helm en el clúster.
        ```
        helm install ibm/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. Asegúrese de que los pods correspondientes a los 9 servicios de Istio y el pod de Prometheus estén totalmente desplegados antes de continuar.
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

Enhorabuena. Ha instalado correctamente Istio en el clúster. A continuación, despliegue la app de muestra BookInfo en el clúster.


## Lección 2: Desplegar la app BookInfo
{: #istio_tutorial2}

Despliegue los microservicios de la app de muestra BookInfo en el clúster de Kubernetes.
{:shortdesc}

Los microservicios incluyen una página web de productos, detalles de libros, revisiones (con varias versiones del microservicio de revisión) y evaluaciones. Cuando despliega BookInfo, los proxies sidecar Envoy se inyectan como contenedores en los pods de los microservicios de la app antes de que se desplieguen los pods de microservicio. Istio utiliza una versión ampliada del proxy Envoy para conciliar todo el tráfico de entrada y salida de todos los microservicios de la malla de servicios. Para obtener más información sobre Envoy, consulte la [documentación de Istio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy).

1. Descargue el paquete de Istio que contiene los archivos de BookInfo necesarios.
    1. Descargue Istio directamente desde [https://github.com/istio/istio/releases ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/istio/istio/releases) y extraiga los archivos de instalación, u obtenga la última versión mediante cURL:
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. Cambie el directorio a la ubicación de archivo de Istio.
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. Añada el cliente `istioctl` a la variable PATH. Por ejemplo, ejecute el mandato siguiente en un sistema Linux o MacOS:
        ```
        export PATH=$PWD/istio-1.0/bin:$PATH
        ```
        {: pre}

2. Etiquete el espacio de nombres `default` con `istio-injection=enabled`.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. Despliegue la app BookInfo. Cuando se despliegan los microservicios de la app, el sidecar Envoy también se despliega en cada pod de microservicio.

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. Asegúrese de que los microservicios y sus pods correspondientes están desplegados:
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
    kubectl get pods
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

5. Para verificar el despliegue de app, obtenga la dirección pública del clúster.
    * Clústeres estándares:
        1. Para exponer la app en una IP pública de Ingress, despliegue la pasarela BookInfo.
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. Defina el host de Ingress.
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. Defina el puerto de Ingress.
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. Cree una variable de entorno `GATEWAY_URL` que utilice el host y el puerto de Ingress.

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * Clústeres gratuitos:
        1. Obtenga la dirección IP pública de cualquier nodo trabajador del clúster.
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. Cree una variable de entorno GATEWAY_URL que utilice la dirección IP pública del nodo trabajador.
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. Ejecute curl sobre la variable `GATEWAY_URL` para comprobar que la app BookInfo se está ejecutando. Una respuesta `200` significa que la app BookInfo se está ejecutando correctamente con Istio.
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  Consulte la página web de BookInfo en un navegador.

    Para Mac OS o Linux:
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Para Windows:
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. Intente renovar la página varias veces. Las diferentes versiones de la sección de revisiones se muestran por round robin con estrellas rojas, estrellas negras y sin estrellas.

Enhorabuena. Ha desplegado correctamente la app de muestra BookInfo con sidecars Envoy de Istio. A continuación, puede limpiar los recursos o continuar con más guías de aprendizaje para seguir explorando Istio.

## Limpieza
{: #istio_tutorial_cleanup}

Si ha finalizado de trabajar con Istio y no desea [continuar explorando](#istio_tutorial_whatsnext), puede eliminar los recursos de Istio en su clúster.
{:shortdesc}

1. Suprima todos los servicios, pods y despliegues de BookInfo del clúster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Desinstale el despliegue de Helm de Istio.
    ```
    helm del istio --purge
    ```
    {: pre}

3. **Opcional**: si utiliza Helm 2.9 o anterior y ha aplicado las definiciones de recursos personalizados de Istio, suprímalas.
    ```
    kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
    ```
    {: pre}

## ¿Qué es lo siguiente?
{: #istio_tutorial_whatsnext}

* Para explorar más Istio, puede encontrar más guías en la [documentación de Istio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/).
    * [Direccionamiento inteligente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/guides/intelligent-routing.html): este ejemplo muestra cómo direccionar el tráfico a una versión específica de los microservicios de revisiones y evaluaciones de BookInfo utilizando las funcionalidades de gestión de tráfico de Istio.
    * [Telemetría detallada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/guides/telemetry.html): este ejemplo explica cómo obtener métricas uniformes, registros y rastreos en los microservicios de BookInfo mediante Istio Mixer y el proxy Envoy.
* Siga la clase sobre [Iniciación a los microservicios con Istio y el servicio IBM Cloud Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Nota**: puede saltarse la sección sobre instalación de este curso.
* Consulte esta publicación del blog sobre cómo utilizar [Vistio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) para visualizar la malla de servicios de Istio.
