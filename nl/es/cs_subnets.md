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


# Configuración de subredes para clústeres
{: #subnets}

Cambie la agrupación de las direcciones IP públicas o privadas portátiles disponibles para los servicios del equilibrador de carga añadiendo subredes a su clúster de Kubernetes.
{:shortdesc}

## VLAN, subredes y direcciones IP predeterminadas para clústeres
{: #default_vlans_subnets}

Durante la creación del clúster, los nodos trabajadores del clúster y las subredes predeterminadas se conectan automáticamente a una VLAN.

### VLAN
{: #vlans}

Cuando se crea un clúster, los nodos trabajadores del clúster se conectan automáticamente a una VLAN. Una VLAN configura un grupo de nodos trabajadores y pods como si estuvieran conectadas a la misma conexión física y ofrece un canal para la conectividad entre los nodos trabajadores y los pods.

<dl>
<dt>VLAN para clústeres gratuitos</dt>
<dd>En los clústeres gratuitos, los nodos trabajadores del clúster se conectan de forma predeterminada a una VLAN pública y VLAN privada propiedad de IBM. Puesto que IBM controla las VLAN, las subredes y las direcciones IP, no puede crear clústeres multizona ni añadir subredes a un clúster, y solo puede utilizar servicios NodePort para exponer la app.</dd>
<dt>VLAN para clústeres estándares</dt>
<dd>En los clústeres estándares, la primera vez que crea un clúster en una zona, se suministra automáticamente una VLAN pública y una VLAN privada en dicha zona en su cuenta de infraestructura de IBM Cloud (SoftLayer). Para los demás clústeres que cree en la zona, puede reutilizar la misma VLAN pública y privada porque varios clústeres pueden compartir las VLAN.</br></br>Puede conectar los nodos trabajadores tanto a una VLAN pública y a la VLAN privada, o solo a la VLAN privada. Si desea conectar sus nodos trabajadores únicamente a una VLAN privada, utilice el ID de una VLAN privada existente o [cree una VLAN privada](/docs/cli/reference/ibmcloud/cli_vlan.html#ibmcloud-sl-vlan-create) y utilice el ID durante la creación del clúster.</dd></dl>

Para ver las VLAN que se suministran en cada zona para su cuenta, ejecute `ibmcloud ks vlans <zone>.` Para ver las VLAN en las que se ha suministrado un clúster, ejecute `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` y busque la sección **Subnet VLANs**.

**Nota**:
* Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de infraestructura de IBM Cloud (SoftLayer).
* La infraestructura de IBM Cloud (SoftLayer) gestiona las VLAN que se suministran automáticamente cuando crea el primer clúster en una zona. Si deja que una VLAN quede sin utilizar, por ejemplo eliminando todos los nodos trabajadores de una VLAN, la infraestructura de IBM Cloud (SoftLayer) reclama la VLAN. Después, si necesita una nueva VLAN, [póngase en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans).

### Subredes y direcciones IP
{: #subnets_ips}

Además de los nodos trabajadores y los pods, las subredes también se suministran automáticamente en las VLAN. Las subredes proporcionan conectividad de red a los componentes del clúster mediante la asignación de direcciones IP a los mismos.

Las subredes siguientes se suministran automáticamente en las VLAN públicas y privadas predeterminadas:

**Subredes VLAN públicas**
* La subred pública primaria determina las direcciones IP públicas que se asignan a los nodos trabajadores durante la creación del clúster. Varios clústeres en la misma VLAN pueden compartir una subred pública primaria.
* La subred pública portátil está enlazada a un solo clúster y proporciona al clúster 8 direcciones IP públicas. 3 IP están reservadas para las funciones de la infraestructura IBM Cloud (SoftLayer). 1 IP la utiliza el ALB de Ingress público predeterminado y 4 IP se pueden utilizar para crear servicios públicos de red de equilibrio de carga. Las IP públicas portátiles son permanentes, direcciones IP fijas que se pueden utilizar para acceder a los servicios de equilibrador de carga a través de Internet. Si necesita más de 4 IP para los equilibradores de carga públicos, consulte [Adición de direcciones IP portátiles](#adding_ips).

**Subredes VLAN privadas**
* La subred privada primaria determina las direcciones IP privadas que se asignan a los nodos trabajadores durante la creación del clúster. Varios clústeres en la misma VLAN pueden compartir una subred privada primaria.
* La subred privada portátil está enlazada a un solo clúster y proporciona al clúster 8 direcciones IP privadas. 3 IP están reservadas para las funciones de la infraestructura IBM Cloud (SoftLayer). 1 IP la utiliza el ALB de Ingress privado predeterminado y 4 IP se pueden utilizar para crear servicios privados de red de equilibrio de carga. Las IP privadas portátiles son permanentes, direcciones IP fijas que se pueden utilizar para acceder a los servicios de equilibrador de carga a través de Internet. Si necesita más de 4 IP para los equilibradores de carga privados, consulte [Adición de direcciones IP portátiles](#adding_ips).

Para ver todas las subredes que se suministran en su cuenta, ejecute `ibmcloud ks subnets`. Para ver las subredes privadas portátiles y públicas portátiles que están enlazadas a un clúster, ejecute `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` y busque la sección **Subnet VLANs**.

**Nota**: en {{site.data.keyword.containerlong_notm}}, las VLAN tienen un límite de 40 subredes. Si alcanza este límite, compruebe en primer lugar si puede [reutilizar subredes en la VLAN para crear nuevos clústeres](#custom). Si necesita una nueva VLAN, [póngase en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans) para solicitar una. A continuación, [cree un clúster](cs_cli_reference.html#cs_cluster_create) que utilice esta nueva VLAN.

<br />


## Utilización de subredes personalizadas o existentes para crear un clúster
{: #custom}

Cuando se crea un clúster estándar, se crean subredes automáticamente. Sin embargo, en lugar de utilizar las subredes suministradas automáticamente, puede utilizar subredes portátiles existentes de la cuenta de infraestructura de IBM Cloud (SoftLayer) o reutilizar las subredes de un clúster suprimido.
{:shortdesc}

Esta opción permite retener las direcciones IP estáticas estables al crear, eliminar o solicitar bloques grandes de direcciones de IP.

**Nota:** Las direcciones IP públicas portátiles se facturan mensualmente. Si elimina direcciones IP públicas portátiles una vez suministrado el clúster, todavía tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.

Antes de empezar:
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).
- Para reutilizar las subredes de un clúster que ya no necesita, suprima el clúster innecesario. Cree el nuevo clúster inmediatamente porque las subredes se suprimen en un plazo de 24 horas si no se reutilizan.

   ```
   ibmcloud ks cluster-rm <cluster_name_or_ID>
   ```
   {: pre}

Para utilizar una subred existente en su portafolio de infraestructura de IBM Cloud (SoftLayer) con reglas de cortafuegos personalizadas o con direcciones IP disponibles:

1. Obtenga el ID de la subred que desea utilizar y el ID de la VLAN en la que se encuentra la subred.

    ```
    ibmcloud ks subnets
    ```
    {: pre}

    En este ejemplo, el ID de subred es `1602829` y el ID de la VLAN es `2234945`:
    ```
    Getting subnet list...
    OK
    ID        Network             Gateway          VLAN ID   Type      Bound Cluster
    1550165   10.xxx.xx.xxx/26    10.xxx.xx.xxx    2234947   private
    1602829   169.xx.xxx.xxx/28   169.xx.xxx.xxx   2234945   public
    ```
    {: screen}

2. [Cree un clúster](cs_clusters.html#clusters_cli) utilizando el ID de VLAN que ha identificado. Incluya el distintivo `--no-subnet` para evitar que se creen de forma automática una nueva subred IP pública portátil y una nueva subred IP privada portátil.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Si no recuerda la zona en la que está la VLAN para el distintivo `--zone`, puede comprobar si la VLAN está en una zona determinada ejecutando `ibmcloud ks vlans <zone>`.
    {: tip}

3.  Verifique que el clúster se ha creado. **Nota:** se puede tardar hasta 15 minutos en solicitar las máquinas de nodo trabajador y en configurar y suministrar el clúster en la cuenta.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Cuando el clúster se haya suministrado por completo, el **Estado (State)** cambia a `deployed`.

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3         dal10      1.10.8
    ```
    {: screen}

4.  Compruebe el estado de los nodos trabajadores.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Antes de continuar con el paso siguiente, los nodos trabajadores deben estar preparados. El **Estado (State)** cambia a `normal` y el **Estatus (Status)** es `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.10.8
    ```
    {: screen}

5.  Añada la subred al clúster especificando el ID de subred. Cuando pone una subred a disponibilidad de un clúster, se crea automáticamente una correlación de configuración de Kubernetes que incluye todas las direcciones IP públicas portátiles disponibles que puede utilizar. Si no existe ningún ALB de Ingress en la zona en la que se encuentra la VLAN de la subred, se utiliza automáticamente una dirección IP pública portátil y una dirección IP privada portátil para crear los ALB públicos y privados para dicha zona. Puede utilizar el resto de las direcciones IP públicas y privadas portátiles para crear servicios equilibradores de carga para las apps.

    ```
    ibmcloud ks cluster-subnet-add mycluster 807861
    ```
    {: pre}

6. **Importante**: para habilitar la comunicación entre nodos trabajadores que están en distintas subredes en la misma VLAN, debe [habilitar el direccionamiento entre subredes en la misma VLAN ](#subnet-routing).

<br />


## Gestión de las direcciones IP portátiles existentes
{: #managing_ips}

De forma predeterminada, se pueden utilizar 4 direcciones IP públicas portátiles y 4 direcciones IP privadas portátiles para exponer apps individuales a la red privada o pública mediante la [creación de un servicio equilibrador de carga](cs_loadbalancer.html). Para crear un servicio equilibrador de carga, debe tener disponible al menos una dirección IP portátil del tipo correcto. Puede ver las direcciones IP portátiles disponibles o puede liberar una dirección IP portátil utilizada.

### Visualización de direcciones IP públicas portátiles disponibles
{: #review_ip}

Para obtener una lista de todas las direcciones IP portátiles del clúster, tanto utilizadas como disponibles, puede ejecutar:

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Para obtener una lista solo de las direcciones IP públicas portátiles disponibles para crear equilibradores de carga, puede seguir los pasos siguientes:

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).

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
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IP addresses are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Liberación de direcciones IP utilizadas
{: #free}

Puede liberar una dirección IP portátil utilizada suprimiendo el servicio equilibrador de carga que está utilizando la dirección IP pública portátil.
{:shortdesc}

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).

1.  Obtenga una lista de los servicios disponibles en el clúster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Elimine el servicio equilibrador de carga que utiliza una dirección IP pública o privada.

    ```
    kubectl delete service <service_name>
    ```
    {: pre}

<br />


## Adición de direcciones IP portátiles
{: #adding_ips}

De forma predeterminada, se pueden utilizar 4 direcciones IP públicas portátiles y 4 direcciones IP privadas portátiles para exponer apps individuales a la red privada o pública mediante la [creación de un servicio equilibrador de carga](cs_loadbalancer.html). Para crear más de 4 equilibradores de carga públicos o 4 privados, puede obtener más direcciones IP portátiles añadiendo subredes de red al clúster.

**Nota:**
* Cuando pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containerlong_notm}} al mismo tiempo.
* Las direcciones IP públicas portátiles se facturan mensualmente. Si elimina direcciones IP públicas portátiles una vez suministrada la subred, todavía tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.

### Adición de direcciones IP portátiles mediante la solicitud de más subredes
{: #request}

Puede obtener más IP portátiles para los servicios de equilibrador de carga creando una nueva subred en una cuenta de infraestructura de IBM Cloud (SoftLayer) y poniéndola a disposición del clúster especificado.
{:shortdesc}

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).

1. Suministre una subred nueva.

    ```
    ibmcloud ks cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
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
    <td>Sustituya <code>&lt;subnet_size&gt;</code> por el número de direcciones IP que desea añadir desde la subred portátil. Los valores aceptados son 8, 16, 32 o 64. <p>**Nota:** Cuando añade direcciones IP portátiles para la subred, se utilizan tres direcciones IP para establecer conexión por red clúster-interna. No puede utilizar estas tres IP para el equilibrador de carga de aplicación o para crear un servicio equilibrador de carga. Por ejemplo, si solicita ocho direcciones IP públicas portátiles, puede utilizar cinco de ellas para exponer sus apps al público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Sustituya <code>&lt;VLAN_ID&gt;</code> con el ID de la VLAN pública o privada a la que desea asignar las direcciones IP públicas o privadas portátiles. Debe seleccionar la VLAN pública o privada a la que está conectado el nodo trabajador existente. Para revisar la VLAN pública o privada para los nodos trabajadores, ejecute el mandato <code>ibmcloud ks worker-get &lt;worker_id&gt;</code>. <La subred se suministra en la misma zona en la que se encuentra la VLAN.</td>
    </tr>
    </tbody></table>

2. Compruebe que la subred se haya creado y añadido correctamente al clúster. El CIDR de subred se muestra en la sección **Subnet VLANs**.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name_or_ID>
    ```
    {: pre}

    En esta salida de ejemplo, se ha añadido una segunda subred a la VLAN pública `2234945`:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

3. **Importante**: para habilitar la comunicación entre nodos trabajadores que están en distintas subredes en la misma VLAN, debe [habilitar el direccionamiento entre subredes en la misma VLAN ](#subnet-routing).

<br />


### Adición de IP privadas portátiles mediante subredes gestionadas por el usuario
{: #user_managed}

Puede obtener más IP privadas portátiles para los servicios de equilibrador de carga creando una subred desde una red local disponible para el clúster especificado.
{:shortdesc}

Requisitos:
- Las subredes gestionadas por el usuario solo se pueden añadir a VLAN privadas.
- El límite de longitud del prefijo de subred es de /24 a /30. Por ejemplo, `169.xx.xxx.xxx/24` especifica 253 direcciones IP privadas que se pueden utilizar, mientras que `169.xx.xxx.xxx/30` especifica 1 dirección IP privada que se puede utilizar.
- La primera dirección IP de la subred se debe utilizar como pasarela para la subred.

Antes de empezar:
- Configure el direccionamiento del tráfico de red de entrada y de salida de la subred externa.
- Confirme que tiene conectividad de VPN entre la pasarela de red del centro de datos local y el Virtual Router Appliance de red privada o el servicio de VPN strongSwan que se ejecuta en el clúster. Para obtener más información, consulte [Configuración de la conectividad de VPN](cs_vpn.html).

Para añadir una subred desde una red local:

1. Vea el ID de la VLAN privada del clúster. Localice la sección **Subnet VLANs**. En el campo **User-managed**, identifique el ID de VLAN con _false_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false
    ```
    {: screen}

2. Añada la subred externa a la VLAN privada. Las direcciones IP privadas portátiles se añaden al mapa de configuración del clúster.

    ```
    ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Ejemplo:

    ```
    ibmcloud ks cluster-user-subnet-add mycluster 10.xxx.xx.xxx/24 2234947
    ```
    {: pre}

3. Verifique que se ha añadido la subred proporcionada por el usuario. El campo **User-managed** es _true_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    En esta salida de ejemplo, se ha añadido una segunda subred a la VLAN privada `2234947`:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR       Public   User-managed
    2234947   10.xxx.xx.xxx/29  false    false
    2234945   169.xx.xxx.xxx/29 true     false
    2234947   10.xxx.xx.xxx/24  false    true
    ```
    {: screen}

4. [Habilite el direccionamiento entre subredes en la misma VLAN](#subnet-routing).

5. Añada un [servicio equilibrador de carga privado](cs_loadbalancer.html) o habilite un [ALB Ingress privado](cs_ingress.html#private_ingress) para acceder a la app a través de la red privada. Para utilizar una dirección IP privada de la subred que ha añadido, debe especificar una dirección IP del CIDR de la subred. De lo contrario, se elige una dirección IP aleatoria de las subredes de infraestructura de IBM Cloud (SoftLayer) o las subredes proporcionadas por el usuario en la VLAN privada.

<br />


## Gestión del direccionamiento de subred
{: #subnet-routing}

Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de infraestructura de IBM Cloud (SoftLayer).

Revise los siguientes casos de ejemplo en los que también es necesaria la expansión de VLAN.

### Habilitación del direccionamiento entre subredes primarias en la misma VLAN
{: #vlan-spanning}

Cuando crea un clúster, se suministra una subred que acaba en `/26` en la VLAN primaria privada predeterminada. Una subred primaria privada puede proporcionar IP para un máximo de 62 nodos trabajadores.
{:shortdesc}

Este límite de 62 nodos trabajadores se puede superar en un clúster grande o en varios clústeres más pequeños en una sola región que estén en la misma VLAN. Cuando se alcanza el límite de 62 nodos trabajadores, se solicita una segunda subred primaria privada en la misma VLAN.

Para asegurarse de que los nodos trabajadores de estas subredes primarias de la misma VLAN pueden comunicarse, debe activar la expansión de VLAN. Para obtener instrucciones, consulte [Habilitar o inhabilitar la expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gestión del direccionamiento de subred para dispositivos de pasarela
{: #vra-routing}

Cuando se crea un clúster, se solicita una subred pública portátil y una subred privada portátil en las VLAN a las que está conectado el clúster. Estas subredes proporcionan las direcciones IP para los servicios de red del equilibrador de carga e Ingress.

Sin embargo, si tiene un dispositivo direccionador existente, como por ejemplo un [dispositivo direccionador virtual (VRA)](/docs/infrastructure/virtual-router-appliance/about.html#about), las subredes portátiles recién añadidas de las VLAN a las que está conectado el clúster no están configuradas en el direccionador. Para utilizar los servicios de red de Ingress o de equilibrador de carga, debe asegurarse de que los dispositivos de red pueden direccionar entre distintas subredes de la misma VLAN mediante la [habilitación de la expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
