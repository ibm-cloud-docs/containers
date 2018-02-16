---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-18"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Guía de aprendizaje: Instalación de Istio en {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio](https://www.ibm.com/cloud/info/istio) es una plataforma de código abierto que ofrece a los desarrolladores una forma uniforme de conectarse, proteger y gestionar una red de microservicios, también conocida como malla de servicios, en plataformas de nube, como Kubernetes. Istio proporciona la posibilidad de gestionar el tráfico de la red, equilibrar la carga entre los microservicios, aplicar políticas de acceso y verificar la identidad en la malla de servicios, entre otras muchas funciones.

{:shortdesc}

En esta guía de aprendizaje, puede aprender cómo instalar Istio junto a cuatro microservicios para una sencilla app ficticia sobre libros denominada BookInfo. Los microservicios incluyen una página web de productos, detalles de libros, revisiones y evaluaciones. Cuando se despliegan los microservicios de BookInfo rn un clúster de {{site.data.keyword.containershort}} en el que está instalado Istio, se inyectan los proxies sidecar Envoy de Istio en los pods de cada microservicio.

**Nota**: algunas configuraciones y características de la plataforma Istio todavía están en desarrollo y están sujetas a cambios en función de los comentarios de los usuarios. Deje pasar unos meses, como estabilización, antes de utilizar Istio en producción. 

## Objetivos

-   Descargar e instalar Istio en el clúster
-   Desplegar la app de muestra BookInfo
-   Inyectar los proxies sidecar Envoy en los pods de los cuatro microservicios de la app para conectar los microservicios en la malla de servicios
-   Verificar el despliegue de la app BookInfo y utilizar round robin en las tres versiones del servicio de evaluaciones

## Tiempo necesario

30
minutos

## Público

Esta guía de aprendizaje está destinada a los desarrolladores de software y administradores de la red que nunca antes han utilizado Istio.

## Requisitos previos

-  [Instalar la CLI](cs_cli_install.html#cs_cli_install_steps)
-  [Crear un clúster](cs_clusters.html#clusters_cli)
-  [Definir el clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure)

## Lección 1: Descargar e instalar Istio
{: #istio_tutorial1}

Descargar e instalar Istio en el clúster.

1. Descargue Istio directamente desde [https://github.com/istio/istio/releases ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/istio/istio/releases) u obtenga la última versión mediante curl:

   ```
   curl -L https://git.io/getLatestIstio | sh -
   ```
   {: pre}

2. Extraiga los archivos de instalación.

3. Añada el cliente `istioctl` a la variable PATH. Por ejemplo, ejecute el mandato siguiente en un sistema Linux o MacOS:

   ```
   export PATH=$PWD/istio-0.4.0/bin:$PATH
   ```
   {: pre}

4. Cambie el directorio a la ubicación de archivo de Istio.

   ```
   cd <path_to_istio-0.4.0>
   ```
   {: pre}

5. Instale Istio en el clúster de Kubernetes. Istio se despliega en el espacio de nombres de Kubernetes `istio-system`.

   ```
   kubectl apply -f install/kubernetes/istio.yaml
   ```
   {: pre}

   **Nota**: si necesita habilitar la autenticación TLS mutua entre sidecars, puede instalar el archivo `istio-auth` en su lugar: `kubectl apply -f install/kubernetes/istio-auth.yaml`

6. Asegúrese de que los servicios de Kubernetes `istio-pilot`, `istio-mixer` e `istio-ingress` estén totalmente desplegados antes de continuar.

   ```
   kubectl get svc -n istio-system
   ```
   {: pre}

   ```
   NAME            TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                                                            AGE
   istio-ingress   LoadBalancer   172.21.121.139   169.48.221.218   80:31176/TCP,443:30288/TCP                                         2m
   istio-mixer     ClusterIP      172.21.31.30     <none>           9091/TCP,15004/TCP,9093/TCP,9094/TCP,9102/TCP,9125/UDP,42422/TCP   2m
   istio-pilot     ClusterIP      172.21.97.191    <none>           15003/TCP,443/TCP                                                  2m
   ```
   {: screen}

7. Asegúrese de que los pods correspondientes `istio-pilot-*`, `istio-mixer-*`, `istio-ingress-*` e `istio-ca-*` también estén totalmente desplegados antes de continuar.

   ```
   kubectl get pods -n istio-system
   ```
   {: pre}

   ```
   istio-ca-3657790228-j21b9           1/1       Running   0          5m
   istio-ingress-1842462111-j3vcs      1/1       Running   0          5m
   istio-pilot-2275554717-93c43        1/1       Running   0          5m
   istio-mixer-2104784889-20rm8        2/2       Running   0          5m
   ```
   {: screen}


¡Enhorabuena! Ha instalado correctamente Istio en el clúster. A continuación, despliegue la app de muestra BookInfo en el clúster.


## Lección 2: Desplegar la app BookInfo
{: #istio_tutorial2}

Despliegue los microservicios de la app de muestra BookInfo en el clúster de Kubernetes. Los microservicios incluyen una página web de productos, detalles de libros, revisiones (con varias versiones del microservicio de revisión) y evaluaciones. Puede encontrar todos los archivos utilizados en este ejemplo en el directorio de instalación de Istio `samples/bookinfo`.

Cuando despliega BookInfo, los proxies sidecar Envoy se inyectan como contenedores en los pods de los microservicios de la app antes de que se desplieguen los pods de microservicio. Istio utiliza una versión ampliada del proxy Envoy para conciliar todo el tráfico de entrada y salida de todos los microservicios de la malla de servicios. Para obtener más información sobre Envoy, consulte la [documentación de Istio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/concepts/what-is-istio/overview.html#envoy).

1. Despliegue la app BookInfo. El mandato `kube-inject` añade a Envoy al archivo `bookinfo.yaml` y utiliza este archivo actualizado para desplegar la app. Cuando se despliegan los microservicios de la app, el sidecar Envoy también se despliega en cada pod de microservicio.

   ```
   kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/kube/bookinfo.yaml)
   ```
   {: pre}

2. Asegúrese de que los microservicios y sus pods correspondientes están desplegados:

   ```
   kubectl get svc
   ```
   {: pre}

   ```
   NAME                       CLUSTER-IP   EXTERNAL-IP   PORT(S)              AGE
   details                    10.0.0.31    <none>        9080/TCP             6m
   kubernetes                 10.0.0.1     <none>        443/TCP              30m
   productpage                10.0.0.120   <none>        9080/TCP             6m
   ratings                    10.0.0.15    <none>        9080/TCP             6m
   reviews                    10.0.0.170   <none>        9080/TCP             6m
   ```
   {: screen}

   ```
   kubectl get pods
   ```
   {: pre}

   ```
   NAME                                        READY     STATUS    RESTARTS   AGE
   details-v1-1520924117-48z17                 2/2       Running   0          6m
   productpage-v1-560495357-jk1lz              2/2       Running   0          6m
   ratings-v1-734492171-rnr5l                  2/2       Running   0          6m
   reviews-v1-874083890-f0qf0                  2/2       Running   0          6m
   reviews-v2-1343845940-b34q5                 2/2       Running   0          6m
   reviews-v3-1813607990-8ch52                 2/2       Running   0          6m
   ```
   {: screen}

3. Para verificar el despliegue de aplicación, obtenga la dirección pública del clúster.

    * Si está trabajando con un clúster estándar, ejecute el siguiente mandato para obtener la IP de Ingress y el puerto del clúster:

       ```
       kubectl get ingress
       ```
       {: pre}

       La salida tiene el aspecto siguiente:

       ```
       NAME      HOSTS     ADDRESS          PORTS     AGE
       gateway   *         169.48.221.218   80        3m
       ```
       {: screen}

       La entrada resultante de Ingress para este ejemplo es `169.48.221.218:80`. Exporte la dirección como el URL de pasarela con el mandato siguiente. Utilizará el URL de pasarela en el paso siguiente para acceder a la página de producto de BookInfo.

       ```
       export GATEWAY_URL=169.48.221.218:80
       ```
       {: pre}

    * Si está trabajando con un clúster lite, debe utilizar la IP pública del nodo de trabajador y NodePort. Ejecute el siguiente mandato para obtener la IP pública del nodo trabajador:

       ```
       bx cs workers <cluster_name_or_ID>
       ```
       {: pre}

       Exporte la IP pública del nodo trabajador como el URL de pasarela con el mandato siguiente. Utilizará el URL de pasarela en el paso siguiente para acceder a la página de producto de BookInfo.

       ```
       export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingress -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
       ```
       {: pre}

4. Ejecute curl en la variable `GATEWAY_URL` para comprobar que BookInfo se esté ejecutando. La respuesta `200` significa que BookInfo se está ejecutando correctamente con Istio.

   ```
   curl -I http://$GATEWAY_URL/productpage
   ```
   {: pre}

5. En un navegador, vaya a `http://$GATEWAY_URL/productpage` para ver la página web de BookInfo.

6. Intente renovar la página varias veces. Las diferentes versiones de la sección de revisiones se muestran por round robin con estrellas rojas, estrellas negras y sin estrellas.

¡Enhorabuena! Ha desplegado correctamente la app de muestra BookInfo con sidecars Envoy de Istio. A continuación, puede limpiar los recursos o continuar con más guías de aprendizaje para explorar la funcionalidad de Istio todavía más.

## Limpieza
{: #istio_tutorial_cleanup}

Si no desea explorar más funciones de Istio indicadas en [¿Qué es lo siguiente?](#istio_tutorial_whatsnext), puede limpiar los recursos de Istio en el clúster.

1. Suprima todos los servicios, pods y despliegues de BookInfo del clúster.

   ```
   samples/bookinfo/kube/cleanup.sh
   ```
   {: pre}

2. Desinstale Istio.

   ```
   kubectl delete -f install/kubernetes/istio.yaml
   ```
   {: pre}

## ¿Qué es lo siguiente?
{: #istio_tutorial_whatsnext}

Para explorar más la funcionalidad de Istio, puede encontrar más guías en la [documentación de Istio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/).

* [Direccionamiento inteligente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/guides/intelligent-routing.html): este ejemplo muestra cómo utilizar las diferentes funciones de gestión de tráfico de Istio con BookInfo para direccionar el tráfico a la versión específica de los microservicios de revisiones y evaluaciones.

* [Telemetría detallada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/guides/telemetry.html): este ejemplo muestra cómo obtener métricas uniformes, registros y rastreos en los microservicios de BookInfo mediante Istio Mixer y el proxy Envoy.
