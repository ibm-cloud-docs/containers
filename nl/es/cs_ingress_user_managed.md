---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, nginx, iks multiple ingress controllers

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


# Cómo traer su propio controlador Ingress
{: #ingress-user_managed}

Traiga su propio controlador Ingress para que se ejecute en {{site.data.keyword.cloud_notm}} y aproveche un nombre de host y un certificado TLS proporcionados por IBM.
{: shortdesc}

Los equilibradores de carga de aplicación (ALB) proporcionados por IBM se basan en controladores NGINX que puede configurar utilizando [anotaciones de {{site.data.keyword.cloud_notm}} personalizadas](/docs/containers?topic=containers-ingress_annotation). En función de lo que necesite la app, es posible que desee configurar su propio controlador de Ingress personalizado. Cuando trae su propio controlador de Ingress en lugar de utilizar el ALB de Ingress proporcionado por IBM, es responsable de suministrar la imagen del controlador, de mantener el controlador, de actualizar el controlador y de aplicar las actualizaciones relacionadas con la seguridad para mantener el controlador de Ingress protegido frente a posibles vulnerabilidades. **Nota**: Solo se admite traer su propio controlador Ingress para proporcionar acceso externo público a sus apps y no se admite para proporcionar acceso externo privado.

Tiene 2 opciones para traer su propio controlador de Ingress:
* [Cree un equilibrador de carga de red (NLB) para exponer el despliegue del controlador de Ingress personalizado y, a continuación, cree un nombre de host para la dirección IP del NLB](#user_managed_nlb). {{site.data.keyword.cloud_notm}} proporciona el nombre de host y se ocupa de la generación y mantenimiento del certificado SSL de comodín para el nombre de host. Para obtener más información sobre los nombres de host de DNS de NLB proporcionados por IBM, consulte [Registro de un nombre de host NLB](/docs/containers?topic=containers-loadbalancer_hostname).
* [Inhabilite el despliegue de ALB proporcionado por IBM y utilice el servicio equilibrador de carga que ha expuesto el ALB y el registro de DNS para el subdominio de Ingress proporcionado por IBM](#user_managed_alb). Esta opción le permite aprovechar el subdominio de Ingress y el certificado TLS que ya están asignados a su clúster.

## Exposición del controlador de Ingress mediante la creación de un NLB y un nombre de host
{: #user_managed_nlb}

Cree un equilibrador de carga de red (NLB) para exponer el despliegue del controlador de Ingress personalizado y, a continuación, cree un nombre de host para la dirección IP del NLB.
{: shortdesc}

1. Prepare el archivo de configuración para el controlador de Ingress. Por ejemplo, puede utilizar el [controlador de Ingress de la comunidad NGINX genérico de la nube ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Si utiliza el controlador de la comunidad, edite el archivo `kustomization.yaml` siguiendo estos pasos.
  1. Sustituya `namespace: ingress-nginx` por `namespace: kube-system`.
  2. En la sección `commonLabels`, sustituya las etiquetas `app.kubernetes.io/name: ingress-nginx` y `app.kubernetes.io/part-of: ingress-nginx` por una etiqueta `app: ingress-nginx`.

2. Despliegue su propio controlador de Ingress. Por ejemplo, para utilizar el controlador de Ingress de la comunidad NGINX genérica de la nube, ejecute el mandato siguiente.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

3. Defina un equilibrador de carga para exponer el despliegue de Ingress personalizado.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-lb-svc
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
    ```
    {: codeblock}

4. Cree el servicio en el clúster.
    ```
    kubectl apply -f my-lb-svc.yaml
    ```
    {: pre}

5. Obtenga la dirección **EXTERNAL-IP** del equilibrador de carga.
    ```
    kubectl get svc my-lb-svc -n kube-system
    ```
    {: pre}

    En la siguiente información de salida de ejemplo, la **EXTERNAL-IP** es `168.1.1.1`.
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. Registre la dirección IP del equilibrador de carga mediante la creación de un nombre de host DNS.
    ```
    ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <LB_IP>
    ```
    {: pre}

7. Verifique que se ha creado el nombre de host.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Salida de ejemplo:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

8. Opcional: [habilite comprobaciones de estado en un nombre de host mediante la creación de un supervisor de estado](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor).

9. Despliegue cualquier otro recurso que necesite el controlador de Ingress personalizado, como por ejemplo el mapa de configuración.

10. Cree recursos de Ingress para sus apps. Puede utilizar la documentación de Kubernetes para crear [un archivo de recursos de Ingress ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/) y para utilizar [anotaciones ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/).
  <p class="tip">Si continúa utilizando los ALB proporcionados por IBM de forma simultánea con el controlador de Ingress personalizado en un clúster, puede crear recursos de Ingress independientes para los ALB y para el controlador personalizado. En el [recurso de Ingress que cree para aplicarlo solo a los ALB de IBM](/docs/containers?topic=containers-ingress#ingress_expose_public), añada la anotación <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

11. Acceda a la app utilizando el nombre de host del equilibrador de carga que ha encontrado en el paso 7 y la vía de acceso en la que escucha la app que ha especificado en el archivo de recursos de Ingress.
  ```
  https://<load_blanacer_host_name>/<app_path>
  ```
  {: codeblock}

## Exposición del controlador de Ingress mediante el equilibrador de carga existente y el subdominio Ingress
{: #user_managed_alb}

Inhabilite el despliegue de ALB proporcionado por IBM y utilice el servicio equilibrador de carga que ha expuesto el ALB y el registro de DNS para el subdominio de Ingress proporcionado por IBM.
{: shortdesc}

1. Obtenga el ID del ALB público predeterminado. El ALB público tiene un formato similar a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Inhabilite el ALB público predeterminado. El distintivo `--disable-deployment` inhabilita el despliegue del ALB proporcionado por IBM, pero no elimina el registro de DNS para el subdominio de Ingress proporcionado por IBM ni el servicio del equilibrador de carga que se utiliza para exponer el controlador de Ingress.
    ```
    ibmcloud ks alb-configure --albID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. Prepare el archivo de configuración para el controlador de Ingress. Por ejemplo, puede utilizar el [controlador de Ingress de la comunidad NGINX genérico de la nube ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Si utiliza el controlador de la comunidad, edite el archivo `kustomization.yaml` siguiendo estos pasos.
  1. Sustituya `namespace: ingress-nginx` por `namespace: kube-system`.
  2. En la sección `commonLabels`, sustituya las etiquetas `app.kubernetes.io/name: ingress-nginx` y `app.kubernetes.io/part-of: ingress-nginx` por una etiqueta `app: ingress-nginx`.
  3. En la variable `SERVICE_NAME`, sustituya `name: ingress-nginx` por `name: <ALB_ID>`. Por ejemplo, el ID de ALB del paso 1 podría parecerse al siguiente: `name: public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.

4. Despliegue su propio controlador de Ingress. Por ejemplo, para utilizar el controlador de Ingress de la comunidad NGINX genérica de la nube, ejecute el mandato siguiente. **Importante**: para seguir utilizando el servicio del equilibrador de carga exponiendo el controlador y el subdominio de Ingress proporcionado por IBM, el controlador debe estar desplegado en el espacio de nombres `kube-system`.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

5. Obtenga la etiqueta del despliegue personalizado de Ingress.
    ```
    kubectl get deploy <ingress-controller-name> -n kube-system --show-labels
    ```
    {: pre}

    En la siguiente salida de ejemplo, el valor de la etiqueta es `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

6. Utilizando el ID de ALB que ha obtenido en el paso 1, abra el servicio del equilibrador de carga que expone el ALB de IBM.
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

7. Actualice el servicio del equilibrador de carga de modo que apunte al despliegue de Ingress personalizado. En `spec/selector`, elimine el ID de ALB de la etiqueta `app` y añada la etiqueta correspondiente a su propio controlador de Ingress que ha obtenido en el paso 5.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. Opcional: de forma predeterminada, el servicio del equilibrador de carga permite el tráfico en los puertos 80 y 443. Si el controlador de Ingress personalizado necesita otro conjunto de puertos, añada dichos puertos a la sección `ports`.

8. Guarde y cierre el archivo de configuración. La salida se parece a la siguiente:
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

9. Verifique que ahora el campo `Selector` del ALB apunta a su controlador.
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    Salida de ejemplo:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

10. Despliegue cualquier otro recurso que necesite el controlador de Ingress personalizado, como por ejemplo el mapa de configuración.

11. Si tiene un clúster multizona, repita estos pasos para cada ALB.

12. Si tiene un clúster multizona, debe configurar una comprobación de estado. El punto final de comprobación de estado de DNS de Cloudflare, `albhealth.<clustername>.<region>.containers.appdomain.com`, espera una respuesta `200` con un cuerpo `healthy` en la respuesta. Si no hay ninguna comprobación de estado configurada de modo que devuelva `200` y `healthy`, la comprobación de estado elimina las direcciones IP de ALB de la agrupación de DNS. Puede editar el recurso de comprobación de estado existente o puede crear uno propio.
  * Para editar el recurso de comprobación de estado existente:
      1. Abra el recurso `alb-health`.
        ```
        kubectl edit ingress alb-health --namespace kube-system
        ```
        {: pre}
      2. En la sección `metadata.annotations`, cambie el nombre de la anotación `ingress.bluemix.net/server-snippets` por la anotación a la que da soporte el controlador. Por ejemplo, podría utilizar la anotación `nginx.ingress.kubernetes.io/server-snippet`. No cambie el contenido del fragmento de código del servidor.
      3. Guarde y cierre el archivo. Los cambios se aplican automáticamente.
  * Para crear su propio recurso de comprobación de estado, asegúrese de que se devuelve el siguiente fragmento de código a Cloudflare:
    ```
    { return 200 'healthy'; add_header Content-Type text/plain; }
    ```
    {: codeblock}

13. Cree recursos de Ingress para sus apps siguiendo los pasos del apartado [Exposición de apps que están dentro de su clúster al público](/docs/containers?topic=containers-ingress#ingress_expose_public).

Ahora el controlador de Ingress personalizado expone sus apps. Para restaurar el despliegue de ALB proporcionado por IBM, vuelva a habilitar el ALB. El ALB se vuelve a desplegar y el servicio del equilibrador de carga se vuelve a configurar automáticamente para que apunte al ALB.

```
ibmcloud ks alb-configure --albID <alb ID> --enable
```
{: pre}
