---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-29"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Configuración de la conectividad de VPN
{: #vpn}

La conectividad VPN le permite conectar de forma segura apps de un clúster de Kubernetes a una red local. También puede conectar apps que son externas al clúster a una app que se ejecuta dentro del clúster.
{:shortdesc}

## Configuración de la conectividad de VPN con el diagrama de Helm del servicio VPN IPSec de Strongswan
{: #vpn-setup}

Para configurar la conectividad de VPN, puede utilizar un diagrama de Helm para configurar y desplegar el [servicio VPN IPSec de Strongswan ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.strongswan.org/) dentro de un pod de Kubernetes. Todo el tráfico de VPN se direcciona a través de este pod. Para obtener más información sobre los mandatos Helm que se utilizan para configurar el diagrama de Strongswan, consulte la <a href="https://docs.helm.sh/helm/" target="_blank">documentación de Helm <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.
{:shortdesc}

Antes de empezar:

- [Cree un clúster estándar.](cs_clusters.html#clusters_cli)
- [Si utiliza un clúster existente, actualícelo a la versión 1.7.4 o posterior.](cs_cluster_update.html#master)
- El clúster debe tener disponible al menos una dirección IP del equilibrador de carga público.
- [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure).

Para configurar la conectividad de VPN con Strongswan:

1. Si todavía no está habilitado, instale e inicialice Helm para el clúster.

    1. Instale la <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">CLI de Helm <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a>.

    2. Inicialice Helm e instale `tiller`.

        ```
        helm init
        ```
        {: pre}

    3. Verifique que el pod `tiller-deploy` tiene el estado `Running` en el clúster.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Salida de ejemplo:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Añada el repositorio de Helm de {{site.data.keyword.containershort_notm}} a la instancia de Helm.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Verifique que el diagrama de Strongswan aparece en el repositorio de Helm.

        ```
        helm search bluemix
        ```
        {: pre}

2. Guarde los valores de configuración predeterminados para el diagrama de Helm de Strongswan en un archivo YAML local.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Abra el archivo `config.yaml` y realice los cambios siguientes a los valores predeterminados según la configuración de VPN que desee. Si una propiedad tiene valores específicos que puede elegir, dichos valores se listan en los comentarios encima de cada propiedad del archivo. **Importante**: si no necesita cambiar una propiedad, coméntela colocando un signo `#` delante de ella.

    <table>
    <caption>Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Si ya tiene un archivo <code>ipsec.conf</code> que desea utilizar, elimine las llaves (<code>{}</code>) y añada el contenido del archivo después de esta propiedad. El contenido del archivo debe especificarse con un sangrado. **Nota:** si utiliza su propio archivo, los valores de las secciones <code>segip</code>, <code>local</code> y <code>remote</code> no se utilizan.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Si ya tiene un archivo <code>ipsec.secrets</code> que desea utilizar, elimine las llaves (<code>{}</code>) y añada el contenido del archivo después de esta propiedad. El contenido del archivo debe especificarse con un sangrado. **Nota:** si utiliza su propio archivo, los valores de la sección <code>preshared</code> no se utilizan.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Si el punto final de túnel VPN local no admite <code>ikev2</code> como protocolo para inicializar la conexión, cambie este valor a <code>ikev1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Cambie este valor a la lista de algoritmos de autenticación/cifrado de ESP que el punto final de túnel VPN local utiliza para la conexión.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Cambie este valor a la lista de algoritmos de autenticación/cifrado de IKE/ISAKMP SA que el punto final de túnel VPN local utiliza para la conexión.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Si desea que el clúster inicie la conexión VPN, cambie este valor a <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Cambie este valor a la lista de CIDR de subred del clúster que se va a exponer a través de la conexión VPN a la red local. Esta lista puede incluir las subredes siguientes: <ul><li>El CIDR de subred del pod de Kubernetes: <code>172.30.0.0/16</code></li><li>El CIDR de subred del servicio de Kubernetes: <code>172.21.0.0/16</code></li><li>Si sus aplicaciones están expuestas por un servicio NodePort en una red privada, el CIDR de subred privada del nodo trabajador. Para encontrar este valor, ejecute <code>bx cs subnets | grep <xxx.yyy.zzz></code>, donde <code>&lt;xxx.yyy.zzz&gt;</code> son los tres primeros octetos de la dirección IP privada del nodo trabajador.</li><li>Si tiene aplicaciones expuestas por los servicios de LoadBalancer en la red privada, el CIDR de subred privada o gestionada por el usuario del clúster. Para encontrar estos valores, ejecute <code>bx cs cluster-get <cluster name> --showResources</code>. En la sección <b>VLANS</b>, busque CIDR que tengan los valores <b>Public</b> o <code>false</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Cambie este valor al identificador de serie para el lado del clúster de Kubernetes local que el punto final de túnel VPN utiliza para la conexión.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Cambie este valor a la dirección IP pública de la pasarela VPN local.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Cambie este valor a la lista de CIDR de subred privada local a la que pueden acceder los clústeres de Kubernetes.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Cambie este valor al identificador de serie para el lado local remoto que el punto final de túnel VPN utiliza para la conexión.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Cambie este valor a la clave secreta compartida previamente que la pasarela de punto final de túnel VPN local utiliza para la conexión.</td>
    </tr>
    </tbody></table>

4. Guarde el archivo `config.yaml` actualizado.

5. Instale el diagrama de Helm en el clúster con el archivo `config.yaml` actualizado. Las propiedades actualizadas se almacenan en una correlación de configuración para el diagrama.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Compruebe el estado de despliegue del diagrama. Cuando el diagrama está listo, el campo **STATUS**, situado cerca de la parte superior de la salida, tiene el valor `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

7. Una vez desplegado el diagrama, verifique que se han utilizado los valores actualizados del archivo `config.yaml`.

    ```
    helm get values vpn
    ```
    {: pre}

8. Pruebe la conectividad VPN nueva.
    1. Si la VPN de la pasarela local no está activa, inicie la VPN.

    2. Establezca la variable de entorno `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. Compruebe el estado de la VPN. Un estado `ESTABLISHED` significa que la conexión VPN se ha realizado correctamente.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        Salida de ejemplo:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

      **Nota**:
          - Es probable que el estado de la VPN no sea `ESTABLISHED` la primera vez que utilice este diagrama de Helm. Puede que necesite comprobar los valores de punto final de VPN local y volver al paso 3 para cambiar el archivo `config.yaml` varias veces antes de que la conexión sea correcta.
          - Si el pod de VPN está en estado `ERROR` o sigue bloqueándose y reiniciándose, puede que se deba a la validación de parámetro de los valores de `ipsec.conf` en la correlación de configuración del diagrama. Compruebe los errores de validación en los registros del pod de Strongswan ejecutando `kubectl logs -n kube-system $STRONGSWAN_POD`. Si hay errores de validación, ejecute `helm delete --purge vpn`, vuelva al paso 3 para arreglar los valores incorrectos en el archivo `config.yaml` y repita los pasos 4 - 8. Si el clúster tiene un número elevado de nodos trabajadores, también puede utilizar `helm upgrade` para aplicar los cambios más rápidamente en lugar de ejecutar `helm delete` y `helm install`.

    4. Una vez que la VPN tenga el estado `ESTABLISHED`, pruebe la conexión con `ping`. El ejemplo siguiente envía un ping desde el pod de VPN en el clúster de Kubernetes a la dirección IP privada de la pasarela VPN local. Asegúrese de estén especificados los valores de `remote.subnet` y `local.subnet` correctos en el archivo de configuración y de que la lista de subredes local incluya la dirección IP de origen desde la que envía el ping.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### Inhabilitación del servicio VPN IPSec de Strongswan
{: vpn_disable}

1. Suprima el diagrama de Helm.

    ```
    helm delete --purge vpn
    ```
    {: pre}
