---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks

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



# Configuración de subredes para clústeres
{: #subnets}

Cambie la agrupación de las direcciones IP públicas o privadas portátiles disponibles para los servicios del equilibrador de carga de red (NLB) añadiendo subredes a su clúster de Kubernetes.
{:shortdesc}

## Utilización de subredes de la infraestructura de IBM Cloud (SoftLayer) personalizadas o existentes para crear un clúster
{: #subnets_custom}

Cuando se crea un clúster estándar, se crean subredes automáticamente. Sin embargo, en lugar de utilizar las subredes suministradas automáticamente, puede utilizar subredes portátiles existentes de la cuenta de infraestructura de IBM Cloud (SoftLayer) o reutilizar las subredes de un clúster suprimido.
{:shortdesc}

Esta opción permite retener las direcciones IP estáticas estables al crear, eliminar o solicitar bloques grandes de direcciones de IP. Si, en su lugar, desea obtener más direcciones IP privadas portátiles para los servicios de equilibrador de carga de red (NLB) del clúster utilizando su propia subred local, consulte [Adición de IP privadas portátiles mediante la adición de subredes gestionadas por el usuario a VLAN privadas](#subnet_user_managed).

Las direcciones IP públicas portátiles se facturan mensualmente. Si elimina direcciones IP públicas portátiles una vez suministrado el clúster, todavía tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.
{: note}

Antes de empezar:
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
- Para reutilizar las subredes de un clúster que ya no necesita, suprima el clúster innecesario. Cree el nuevo clúster inmediatamente porque las subredes se suprimen en un plazo de 24 horas si no se reutilizan.

   ```
   ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
   ```
   {: pre}

Para utilizar una subred existente en su portafolio de infraestructura de IBM Cloud (SoftLayer) con reglas de cortafuegos personalizadas o con direcciones IP disponibles:

1. Obtenga el ID de la subred a utilizar y el ID de la VLAN en la que se encuentra la subred.

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

2. [Cree un clúster](/docs/containers?topic=containers-clusters#clusters_cli) utilizando el ID de VLAN que ha identificado. Incluya el distintivo `--no-subnet` para evitar que se creen de forma automática una nueva subred IP pública portátil y una nueva subred IP privada portátil.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b3c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Si no recuerda la zona en la que está la VLAN para el distintivo `--zone`, puede comprobar si la VLAN está en una zona determinada ejecutando `ibmcloud ks vlans --zone <zone>`.
    {: tip}

3.  Verifique que el clúster se ha creado. Se puede tardar hasta 15 minutos en solicitar las máquinas de nodo trabajador y en configurar y suministrar el clúster en la cuenta.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Cuando el clúster se haya suministrado por completo, el **Estado (State)** cambia a `deployed`.

    ```
    Name         ID                                   State      Created          Workers    Zone      Version     Resource Group Name
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3          dal10     1.12.7      Default
    ```
    {: screen}

4.  Compruebe el estado de los nodos trabajadores.

    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Antes de continuar con el paso siguiente, los nodos trabajadores deben estar preparados. El **Estado (State)** cambia a `normal` y el **Estatus (Status)** es `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone     Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.12.7
    ```
    {: screen}

5.  Añada la subred al clúster especificando el ID de subred. Cuando pone una subred a disponibilidad de un clúster, se crea automáticamente una correlación de configuración de Kubernetes que incluye todas las direcciones IP públicas portátiles disponibles que puede utilizar. Si no existe ningún ALB de Ingress en la zona en la que se encuentra la VLAN de la subred, se utiliza automáticamente una dirección IP pública portátil y una dirección IP privada portátil para crear los ALB públicos y privados para dicha zona. Puede utilizar el resto de las direcciones IP públicas y privadas portátiles para crear servicios de NLB para las apps.

  ```
  ibmcloud ks cluster-subnet-add --cluster <cluster_name_or_id> --subnet-id <subnet_ID>
  ```
  {: pre}

  Mandato de ejemplo:
  ```
  ibmcloud ks cluster-subnet-add --cluster mycluster --subnet-id 807861
  ```
  {: screen}

6. **Importante**: para habilitar la comunicación entre nodos trabajadores que están en distintas subredes en la misma VLAN, debe [habilitar el direccionamiento entre subredes en la misma VLAN](#subnet-routing).

<br />


## Gestión de las direcciones IP portátiles existentes
{: #managing_ips}

De forma predeterminada, se pueden utilizar 4 direcciones IP públicas portátiles y 4 direcciones IP privadas portátiles para exponer apps individuales a la red privada o pública mediante la [creación de un servicio de equilibrador de carga de red (NLB)](/docs/containers?topic=containers-loadbalancer). Para crear un servicio de NLB, debe tener disponible al menos una dirección IP portátil del tipo correcto. Puede ver las direcciones IP portátiles disponibles o puede liberar una dirección IP portátil utilizada.
{: shortdesc}

### Visualización de direcciones IP públicas portátiles disponibles
{: #review_ip}

Para obtener una lista de todas las direcciones IP portátiles del clúster, tanto utilizadas como disponibles, puede ejecutar el siguiente mandato.
{: shortdesc}

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Para obtener una lista solo de las direcciones IP públicas portátiles disponibles para crear NLBs, puede seguir los pasos siguientes:

Antes de empezar:
-  Asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Para ver una lista de las direcciones IP públicas portátiles disponibles:

1.  Cree un archivo de configuración de servicio Kubernetes denominado `myservice.yaml` y defina un servicio de tipo `LoadBalancer` con una dirección IP de NLB ficticia. En el ejemplo siguiente se utiliza la dirección IP 1.1.1.1 como dirección IP de NLB. Sustituya `<zone>` por la zona en la que desea comprobar las IP disponibles.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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

    La creación de este servicio falla porque el maestro de Kubernetes no encuentra la dirección IP de NLB especificada en la correlación de configuración de Kubernetes. Cuando se ejecuta este mandato, puede ver el mensaje de error y la lista de direcciones IP públicas disponibles para el clúster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IP addresses are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Liberación de direcciones IP utilizadas
{: #free}

Puede liberar una dirección IP portátil utilizada suprimiendo el servicio de equilibrador de carga de red (NLB) que está utilizando la dirección IP pública portátil.
{:shortdesc}

Antes de empezar:
-  Asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Para suprimir un NLB:

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

De forma predeterminada, se pueden utilizar 4 direcciones IP públicas portátiles y 4 direcciones IP privadas portátiles para exponer apps individuales a la red privada o pública mediante la [creación de un servicio de equilibrador de carga de red (NLB)](/docs/containers?topic=containers-loadbalancer). Para crear más de 4 NLBs públicos o 4 privados, puede obtener más direcciones IP portátiles añadiendo subredes de red al clúster.
{: shortdesc}

Cuando pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containerlong_notm}} al mismo tiempo.
{: important}

Las direcciones IP públicas portátiles se facturan mensualmente. Si elimina direcciones IP públicas portátiles una vez suministrada la subred, todavía tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.
{: note}

### Adición de direcciones IP portátiles mediante la solicitud de más subredes
{: #request}

Puede obtener más IP portátiles para los servicios de NLB creando una nueva subred en una cuenta de infraestructura de IBM Cloud (SoftLayer) y poniéndola a disposición del clúster especificado.
{:shortdesc}

Antes de empezar:
-  Asegúrese de tener el rol de [**Operador** o de
Administrador de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para el clúster.
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Para solicitar una subred:

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
    <td>Sustituya <code>&lt;subnet_size&gt;</code> por el número de direcciones IP que desea añadir desde la subred portátil. Los valores aceptados son 8, 16, 32 o 64. <p class="note"> Cuando añade direcciones IP portátiles para la subred, se utilizan tres direcciones IP para establecer conexión por red clúster-interna. No puede utilizar estas tres direcciones IP para los equilibradores de carga de aplicación (ALB) de Ingress ni para crear servicios de equilibrador de carga de red (NLB). Por ejemplo, si solicita ocho direcciones IP públicas portátiles, puede utilizar cinco de ellas para exponer sus apps al público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Sustituya <code>&lt;VLAN_ID&gt;</code> con el ID de la VLAN pública o privada a la que desea asignar las direcciones IP públicas o privadas portátiles. Debe seleccionar la VLAN pública o privada a la que está conectado el nodo trabajador existente. Para revisar la VLAN pública o privada para los nodos trabajadores, ejecute el mandato <code>ibmcloud ks worker-get --worker &lt;worker_id&gt;</code>. <La subred se suministra en la misma zona en la que se encuentra la VLAN.</td>
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

3. **Importante**: para habilitar la comunicación entre nodos trabajadores que están en distintas subredes en la misma VLAN, debe [habilitar el direccionamiento entre subredes en la misma VLAN](#subnet-routing).

<br />


### Adición de IP privadas portátiles mediante la adición de subredes gestionadas por el usuario a VLAN privadas
{: #subnet_user_managed}

Puede obtener más IP privadas portátiles para los servicios de equilibrador de carga de red (NLB) creando una subred desde una red local disponible para el clúster.
{:shortdesc}

¿Desea reutilizar las subredes portátiles existentes en la cuenta de infraestructura de IBM Cloud (SoftLayer) en su lugar? Consulte [Utilización de subredes de la infraestructura de IBM Cloud (SoftLayer) personalizadas o existentes para crear un clúster](#subnets_custom).
{: tip}

Requisitos:
- Las subredes gestionadas por el usuario solo se pueden añadir a VLAN privadas.
- El límite de longitud del prefijo de subred es de /24 a /30. Por ejemplo, `169.xx.xxx.xxx/24` especifica 253 direcciones IP privadas que se pueden utilizar, mientras que `169.xx.xxx.xxx/30` especifica 1 dirección IP privada que se puede utilizar.
- La primera dirección IP de la subred se debe utilizar como pasarela para la subred.

Antes de empezar:
- Configure el direccionamiento del tráfico de red de entrada y de salida de la subred externa.
- Confirme que tiene conectividad de VPN entre la pasarela de red del centro de datos local y el Virtual Router Appliance de red privada o el servicio de VPN strongSwan que se ejecuta en el clúster. Para obtener más información, consulte [Configuración de la conectividad de VPN](/docs/containers?topic=containers-vpn).
-  Asegúrese de tener el rol de [**Operador** o de
Administrador de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para el clúster.
- [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)


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

5. Añada un [servicio de equilibrador de carga de red (NLB) privado](/docs/containers?topic=containers-loadbalancer) o habilite un [ALB de Ingress privado](/docs/containers?topic=containers-ingress#private_ingress) para acceder a la app a través de la red privada. Para utilizar una dirección IP privada de la subred que ha añadido, debe especificar una dirección IP del CIDR de la subred. De lo contrario, se elige una dirección IP aleatoria de las subredes de infraestructura de IBM Cloud (SoftLayer) o las subredes proporcionadas por el usuario en la VLAN privada.

<br />


## Gestión del direccionamiento de subred
{: #subnet-routing}

Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para habilitar VRF, [póngase en contacto con el representante de su cuenta de la infraestructura de IBM Cloud (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Si no puede o no desea habilitar VRF, habilite la [expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](/docs/containers?topic=containers-users#infra_access) **Red > Gestionar expansión de VLAN de red** o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

Revise los siguientes casos de ejemplo en los que también es necesaria la expansión de VLAN.

### Habilitación del direccionamiento entre subredes primarias en la misma VLAN
{: #vlan-spanning}

Cuando se crea un clúster, las subredes públicas y privadas primarias se suministran en las VLAN públicas y privadas. La subred pública primaria termina en `/28` y proporciona 14 IP públicas para los nodos trabajadores. La subred privada primaria termina en `/26` y proporciona IP privadas para un máximo de 62 nodos trabajadores.
{:shortdesc}

Puede superar las 14 IP iniciales públicas y 62 IP privadas iniciales para los nodos trabajadores si tiene un clúster grande o varios clústeres pequeños en la misma ubicación en la misma VLAN. Cuando una subred pública o privada alcanza el límite de nodos trabajadores, se solicita otra subred primaria en la misma VLAN.

Para asegurarse de que los nodos trabajadores de estas subredes primarias de la misma VLAN pueden comunicarse, debe activar la expansión de VLAN. Para obtener instrucciones, consulte [Habilitar o inhabilitar la expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gestión del direccionamiento de subred para dispositivos de pasarela
{: #vra-routing}

Cuando se crea un clúster, se solicita una subred pública portátil y una subred privada portátil en las VLAN a las que está conectado el clúster. Estas subredes proporcionan direcciones IP para los servicios de equilibrador de carga de aplicaciones (ALB) de Ingress y de equilibrador de carga de red (NLB).
{: shortdesc}

Sin embargo, si tiene un dispositivo direccionador existente, como por ejemplo un [dispositivo direccionador virtual (VRA)](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra), las subredes portátiles recién añadidas de las VLAN a las que está conectado el clúster no están configuradas en el direccionador. Para utilizar NLBs o ALBs de Ingress, debe asegurarse de que los dispositivos de red pueden direccionar entre distintas subredes de la misma VLAN [habilitando la expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
