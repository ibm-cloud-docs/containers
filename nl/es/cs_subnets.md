---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuración de subredes para clústeres
{: #subnets}

Cambie la agrupación de las direcciones IP públicas o privadas portátiles disponibles añadiendo subredes a su clúster.
{:shortdesc}

En {{site.data.keyword.containershort_notm}}, tiene la posibilidad de añadir direcciones IP portátiles y estables para los servicios de Kubernetes añadiendo subredes al clúster. En este caso, las subredes no se utilizan con máscara de red para crear conectividad entre uno o varios clústeres. En su lugar, las subredes se utilizan para proporcionar IP fijas permanentes para un servicio de un clúster que puede utilizarse para acceder a ese servicio.

Cuando se crea un clúster estándar, {{site.data.keyword.containershort_notm}} automáticamente suministra una subred pública portátil con 5 direcciones IP públicas portátiles y una subred privada portátil con 5 direcciones IP privadas. Las direcciones IP públicas y privadas portátiles son estáticas y no cambian cuando se elimina un nodo trabajador o incluso el clúster. Para cada subred, una de las direcciones públicas portátiles y una de las direcciones IP privadas portátiles se utilizan para los [equilibradores de carga de aplicación](cs_ingress.html), que puede utilizar para exponer varias apps en el clúster. Las 4 direcciones IP públicas portátiles y las 4 direcciones IP privadas portátiles restantes se pueden utilizar para exponer apps individuales al público mediante la [creación de un servicio equilibrador de carga](cs_loadbalancer.html).

**Nota:** Las direcciones IP públicas portátiles se facturan mensualmente. Si decide retirar las direcciones IP públicas portátiles una vez suministrado el clúster, tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.

## Solicitud de subredes adicionales para el clúster
{: #request}

Puede añadir direcciones IP públicas o privadas portátiles estables al clúster asignándole subredes.

**Nota:** Cuando se pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containershort_notm}} al mismo tiempo.

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para crear una subred en una cuenta de infraestructura de IBM Cloud (SoftLayer) y ponerla a disponibilidad de un determinado clúster:

1. Suministre una subred nueva.

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>El mandato para suministrar una subred para el clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>Sustituya <code>&lt;cluster_name_or_id&gt;</code> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Sustituya <code>&lt;subnet_size&gt;</code> por el número de direcciones IP que desea añadir desde la subred portátil. Los valores aceptados son 8, 16, 32 o 64. <p>**Nota:** Cuando añade direcciones IP portátiles para la subred, se utilizan tres direcciones IP para establecer conexión por red clúster-interna, de modo que no puede utilizarlas para el equilibrador de carga de aplicación o para crear un servicio equilibrador de carga. Por ejemplo, si solicita ocho direcciones IP públicas portátiles, puede utilizar cinco de ellas para exponer sus apps al público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Sustituya <code>&lt;VLAN_ID&gt;</code> con el ID de la VLAN pública o privada a la que desea asignar las direcciones IP públicas o privadas portátiles. Debe seleccionar la VLAN pública o privada a la que está conectado el nodo trabajador existente. Para revisar la VLAN pública o privada para los nodos trabajadores, ejecute el mandato <code>bx cs worker-get &lt;worker_id&gt;</code>. </td>
    </tr>
    </tbody></table>

2.  Compruebe que la subred se haya creado y añadido correctamente al clúster. El CIDR de subred se muestra en la sección **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

<br />


## Adición de subredes existentes y personalizadas a clústeres de Kubernetes
{: #custom}

Existe la posibilidad de añadir subredes públicas o privadas portátiles existentes a su clúster de Kubernetes.

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Si tiene una subred existente en su portafolio de infraestructura de IBM Cloud (SoftLayer) con reglas de cortafuegos personalizadas o con direcciones IP disponibles que desea utilizar, cree un clúster sin subredes y haga que su subred existente esté disponible para el clúster al suministrar dicho clúster.

1.  Identifique la subred que desea utilizar. Anote el ID de la subred y el ID de la VLAN. En este ejemplo, el ID de subred es 807861 y el ID de la VLAN es 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Confirme la ubicación en la que se encuentra la VLAN. En este ejemplo, la ubicación es dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router
    1900403   vlan                    1391     private   bcr01a.dal10
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Cree un clúster utilizando el ID de VLAN y la ubicación que ha identificado. Incluya el distintivo `--no-subnet` para evitar que de forma automática se creen una nueva subred IP pública y privada portátiles.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Verifique que ha solicitado la creación del clúster.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** Puede llevar hasta 15 minutos la ordenación de las máquinas del nodo trabajador y la configuración y suministro del clúster
en su cuenta.

    Una vez completado el suministro del clúster, el estado del clúster pasa a ser **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Compruebe el estado de los nodos trabajadores.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Cuando los nodos trabajadores están listos, el estado pasa a **normal** y el estado es **Ready**. Cuando el estado del nodo sea **Preparado**, podrá acceder al clúster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Añada la subred al clúster especificando el ID de subred. Cuando pone una subred a disponibilidad de un clúster, se crea automáticamente una correlación de configuración de Kubernetes que incluye todas las direcciones IP públicas portátiles disponibles que puede utilizar. Si no existen equilibradores de carga de aplicación para el clúster, se utilizan automáticamente una dirección IP pública portátil y una dirección IP privada portátil para crear los equilibradores de carga de aplicación público y privado. El resto de las direcciones IP públicas y privadas portátiles se pueden utilizar para crear servicios equilibradores de carga para las apps.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## Adición de subredes y direcciones IP gestionadas por el usuario a clústeres de Kubernetes
{: #user_managed}

Especifique su propia subred desde una red local a la que desea que acceda {{site.data.keyword.containershort_notm}}. A continuación, puede añadir direcciones IP privadas desde dicha subred a los servicios del equilibrador de carga del clúster de Kubernetes.

Requisitos:
- Las subredes gestionadas por el usuario solo se pueden añadir a VLAN privadas.
- El límite de longitud del prefijo de subred es de /24 a /30. Por ejemplo, `203.0.113.0/24` especifica 253 direcciones IP privadas que se pueden utilizar, mientras que `203.0.113.0/30` especifica 1 dirección IP privada que se puede utilizar.
- La primera dirección IP de la subred se debe utilizar como pasarela para la subred.

Antes de empezar:
- Configure el direccionamiento del tráfico de red de entrada y de salida de la subred externa.
- Confirme que tiene conectividad VPN entre el dispositivo de pasarela del centro de datos local y Vyatta de la red privada en el portafolio de la infraestructura de IBM Cloud (SoftLayer) o bien el servicio VPN de Strongswan que se ejecuta en el clúster. Para utilizar un Vyatta, consulte esta [publicación de blog ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)]. Para utilizar Strongswan, consulte [Configuración de la conectividad de VPN con el servicio VPN IPSec de Strongswan](cs_vpn.html).

1. Consulte el ID de la VLAN privada del clúster. Localice la sección **VLAN**. En el campo **User-managed**, identifique el ID de VLAN con _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Añada la subred externa a la VLAN privada. Las direcciones IP privadas portátiles se añaden al mapa de configuración del clúster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Ejemplo:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Verifique que se ha añadido la subred proporcionada por el usuario. El campo **User-managed** es _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Añada un servicio de equilibrador de carga privado o un equilibrador de carga de aplicación de Ingress privado para acceder a la app sobre la red privada. Si desea utilizar una dirección IP privada de la subred que ha añadido al crear un equilibrador de carga privado o un equilibrador de carga de aplicación de Ingress privado, debe especificar una dirección IP. De lo contrario, se elige una dirección IP aleatoria de las subredes de infraestructura de IBM Cloud (SoftLayer) o las subredes proporcionadas por el usuario en la VLAN privada. Para obtener más información, consulte [Configuración del acceso a una app utilizando el tipo de servicio LoadBalancer](cs_loadbalancer.html#config) o [Habilitación del equilibrador de carga de aplicación privado](cs_ingress.html#private_ingress).

<br />


## Gestión de direcciones IP y subredes
{: #manage}

Puede utilizar subredes públicas y privadas portátiles y direcciones IP para exponer apps en el clúster y hacer que se pueda acceder a las mismas desde Internet o desde una red privada.
{:shortdesc}

En {{site.data.keyword.containershort_notm}}, tiene la posibilidad de añadir direcciones IP portátiles y estables para los servicios de Kubernetes añadiendo subredes al clúster. Cuando se crea un clúster estándar, {{site.data.keyword.containershort_notm}} automáticamente suministra una subred pública portátil con 5 direcciones IP públicas portátiles y una subred privada portátil con 5 direcciones IP privadas. Las direcciones IP portátiles son estáticas y no cambian cuando se elimina un nodo trabajador o incluso el clúster.

Dos de las direcciones IP portátiles, una pública y una privada, se utilizan para los [equilibradores de carga de aplicación de Ingress](cs_ingress.html), que puede utilizar para exponer varias apps en el clúster. Se pueden utilizar 4 direcciones IP públicas portátiles y 4 direcciones IP privadas para exponer apps mediante la [creación de un servicio equilibrador de carga](cs_loadbalancer.html).

**Nota:** Las direcciones IP públicas portátiles se facturan mensualmente. Si decide retirar las direcciones IP públicas portátiles una vez suministrado el clúster, tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.



1.  Cree un archivo de configuración de servicio Kubernetes denominado `myservice.yaml` y defina un servicio de tipo `LoadBalancer` con una dirección IP de equilibrador de carga ficticia. En el ejemplo siguiente se utiliza la dirección IP 1.1.1.1 como dirección IP del equilibrador de carga.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Cree el servicio en el clúster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspeccione el servicio.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** La creación de este servicio falla porque el maestro de Kubernetes no encuentra la dirección IP del equilibrador de carga especificada en la correlación de configuración de Kubernetes. Cuando se ejecuta este mandato, puede ver el mensaje de error y la lista de direcciones IP públicas disponibles para el clúster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />




## Liberación de direcciones IP utilizadas
{: #free}

Puede liberar una dirección IP portátil utilizada suprimiendo el servicio equilibrador de carga que está utilizando la dirección IP pública portátil.

Antes de empezar, [establezca el contexto para el clúster que desea utilizar.](cs_cli_install.html#cs_cli_configure)

1.  Obtenga una lista de los servicios disponibles en el clúster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Elimine el servicio equilibrador de carga que utiliza una dirección IP pública o privada.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}
