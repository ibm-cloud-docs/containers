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



# Resolución de problemas con clústeres y nodos trabajadores
{: #cs_troubleshoot_clusters}

Si utiliza {{site.data.keyword.containerlong}}, tenga en cuenta estas técnicas para resolver problemas relacionados con los clústeres y los nodos trabajadores.
{: shortdesc}

Si tiene un problema más general, pruebe la [depuración del clúster](cs_troubleshoot.html).
{: tip}

## No se ha podido crear un clúster debido a errores de permiso
{: #cs_credentials}

{: tsSymptoms}
Cuando crea un nuevo clúster de Kubernetes, recibe un mensaje de error parecido al siguiente.

```
No se ha podido conectar con la cuenta de IBM infraestructura de Cloud (SoftLayer).
Para crear un clúster estándar, debe tener una cuenta de Pago según uso enlazada a una cuenta de infraestructura de IBM Cloud (SoftLayer) o debe haber utilizado la CLI de {{site.data.keyword.containerlong_notm}} para configurar las claves de API de la infraestructura de {{site.data.keyword.Bluemix_notm}}.
```
{: screen}

```
Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El elemento 'Item' se debe solicitar con permiso.
```
{: screen}

```
Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El usuario no tiene los permisos necesarios de la infraestructura de {{site.data.keyword.Bluemix_notm}} para añadir servidores
```
{: screen}

```
La solicitud de intercambio de señales IAM ha fallado: no se puede crear la señal del portal de IMS, ya que no hay ninguna cuenta de IMS enlazada a la cuenta de BSS seleccionada
```
{: screen}

```
El clúster no se ha podido configurar con el registro. Asegúrese de que tiene el rol de administrador para {{site.data.keyword.registrylong_notm}}.
```
{: screen}

{: tsCauses}
No tiene los permisos correctos para crear un clúster. Necesita los permisos siguientes para crear un clúster:
*  Rol de **Superusuario** para la infraestructura de IBM Cloud (SoftLayer).
*  Rol de gestión de la plataforma de **Administrador** para {{site.data.keyword.containerlong_notm}} a nivel de cuenta.
*  Rol de gestión de la plataforma de **Administrador** para {{site.data.keyword.registrylong_notm}} a nivel de cuenta. No limite las políticas para {{site.data.keyword.registryshort_notm}} a nivel de grupo de recursos. Si ha empezado a utilizar {{site.data.keyword.registrylong_notm}} antes del 4 de octubre de 2018, asegúrese de [habilitar la imposición de políticas de {{site.data.keyword.Bluemix_notm}} IAM](/docs/services/Registry/registry_users.html#existing_users).

En el caso de errores relacionados con la infraestructura, las cuentas de Pago según uso de {{site.data.keyword.Bluemix_notm}} creadas después de haber enlazado una cuenta automática ya se han configurado con acceso a la infraestructura de IBM Cloud (SoftLayer). Es posible adquirir recursos de la infraestructura para el clúster sin configuración adicional. Si tiene una cuenta de Pago según uso válida y recibe este mensaje de error, es posible que no esté utilizando las credenciales de cuenta de infraestructura de IBM Cloud (SoftLayer) correctas para acceder a los recursos de la infraestructura.

Los usuarios con otros tipos de cuenta de {{site.data.keyword.Bluemix_notm}} deben configurar sus cuentas para crear clústeres estándares. Los ejemplos de cuándo puede tener un tipo de cuenta diferente son los siguientes:
* Tiene una cuenta de infraestructura de IBM Cloud (SoftLayer) existente que es anterior a la cuenta de plataforma de {{site.data.keyword.Bluemix_notm}} y que desea continuar utilizando.
* Desea utilizar una cuenta de infraestructura de IBM Cloud distinta (SoftLayer) en la que suministrar recursos de infraestructura. Por ejemplo, puede configurar una cuenta de {{site.data.keyword.Bluemix_notm}} de equipo para que utilice una cuenta de infraestructura distinta con fines de facturación.

Si utiliza una infraestructura de IBM Cloud (SoftLayer) distinta para suministrar recursos de infraestructura, es posible que tenga también [clústeres huérfanos](#orphaned) en la cuenta.

{: tsResolve}
El propietario de la cuenta debe configurar correctamente las credenciales de la cuenta de infraestructura. Las credenciales dependen del tipo de cuenta de infraestructura que esté utilizando.

1.  Verifique que tiene acceso a una cuenta de infraestructura. Inicie una sesión en la [consola de {{site.data.keyword.Bluemix_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/) y, desde el menú ![Icono de menú](../icons/icon_hamburger.svg "Icono de menú"), pulse **Infraestructura**. Si ve el panel de control de la infraestructura, significa que tiene acceso a una cuenta de infraestructura.
2.  Compruebe si el clúster utiliza una cuenta de infraestructura distinta de la que se suministra con la cuenta de Pago según uso.
    1.  En el menú ![Icono de menú](../icons/icon_hamburger.svg "Icono de menú"), pulse **Contenedores > Clústeres**.
    2.  En la tabla, seleccione el clúster.
    3.  En el separador **Visión general**, compruebe si hay un campo **Usuario de infraestructura**.
        * Si no ve el campo **Usuario de infraestructura**, tiene una cuenta de Pago según uso enlazada que utiliza las mismas credenciales para las cuentas de infraestructura y de plataforma.
        * Si ve un campo **Usuario de infraestructura**, significa que el clúster utiliza una cuenta de infraestructura distinta de la que se ha suministrado con la cuenta de Pago según uso. Estas credenciales distintas se aplican a todos los clústeres de la región.
3.  Decida el tipo de cuenta que desea tener para determinar cómo resolver el problema de permisos de infraestructura. Para la mayoría de los usuarios, la cuenta predeterminada enlazada de Pago según uso es suficiente.
    *  Cuenta de {{site.data.keyword.Bluemix_notm}} de Pago según uso enlazada: [Compruebe que la clave de API esté configurada con los permisos correctos](cs_users.html#default_account). Si el clúster utiliza una cuenta de infraestructura distinta, debe eliminar el establecimiento de dichas credenciales como parte del proceso.
    *  Cuentas diferentes de infraestructura y plataforma de {{site.data.keyword.Bluemix_notm}}: compruebe que puede acceder al portafolio de la infraestructura y que [las credenciales de la cuenta de infraestructura están correctamente configuradas con los permisos correctos](cs_users.html#credentials).
4.  Si no puede ver los nodos trabajadores del clúster en la cuenta de infraestructura, compruebe si [el clúster está huérfano](#orphaned).

<br />


## El cortafuegos impide ejecutar mandatos de CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Cuando ejecuta los mandatos `ibmcloud`, `kubectl` o `calicoctl` desde la CLI, fallan.

{: tsCauses}
Puede que tenga políticas de red corporativas que impidan el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos.

{: tsResolve}
[Permita el acceso TCP para que funciones los mandatos de CLI](cs_firewall.html#firewall_bx). Esta tarea requiere el rol de [**Administrador** de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform) para el clúster.


## El cortafuegos impide que el clúster se conecte a recursos
{: #cs_firewall}

{: tsSymptoms}
Cuando los nodos trabajadores no se pueden conectar, podría ver distintos síntomas. Puede ver uno de los siguientes mensajes cuando el proxy de kubectl falla o cuando intenta acceder a un servicio del clúster y la conexión falla.

  ```
  Conexión rechazada
  ```
  {: screen}

  ```
  La conexión ha excedido el tiempo de espera
  ```
  {: screen}

  ```
  No se puede conectar con el servidor: net/http: tiempo de espera excedido de reconocimiento de TLS
  ```
  {: screen}

Si ejecuta kubectl exec, attach o logs, puede ver el siguiente mensaje:

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Si el proxy kubectl se ejecuta correctamente pero el panel de control no está disponible, puede ver el siguiente mensaje.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Es posible que tenga otro cortafuegos configurado o que se hayan personalizado los valores existentes del cortafuegos en la cuenta de infraestructura de IBM Cloud (SoftLayer). {{site.data.keyword.containerlong_notm}} requiere que determinadas direcciones IP y puertos estén abiertos para permitir la comunicación entre el nodo trabajador y el maestro de Kubernetes y viceversa. Otro motivo puede ser que los nodos trabajadores están bloqueados en un bucle de recarga.

{: tsResolve}
[Permita que el clúster acceda a los recursos de infraestructura y a otros servicios](cs_firewall.html#firewall_outbound). Esta tarea requiere el rol de [**Administrador** de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform) para el clúster.

<br />



## No se puede ver o trabajar con un clúster
{: #cs_cluster_access}

{: tsSymptoms}
* No puede encontrar un clúster. Cuando ejecuta `ibmcloud ks clusters`, el clúster no aparece en la lista de salida.
* No puede trabajar con un clúster. Cuando ejecuta `ibmcloud ks cluster-config` u otros mandatos específicos de clúster, no se encuentra el clúster.


{: tsCauses}
En {{site.data.keyword.Bluemix_notm}}, cada recurso debe estar en un grupo de recursos. Por ejemplo, es posible que el clúster ` mycluster` exista en el grupo de recursos `default`. Cuando el propietario de la cuenta le da acceso a los recursos asignándole un rol en la plataforma {{site.data.keyword.Bluemix_notm}} IAM, el acceso puede ser para un recurso específico o para el grupo de recursos. Cuando se le da acceso a un recurso específico, no tiene acceso al grupo de recursos. En este caso, no es necesario que tenga como destino un grupo de recursos para trabajar con los clústeres a los que tiene acceso. Si tiene como destino un grupo de recursos distinto al del grupo en el que se encuentra el clúster, las acciones sobre dicho clúster pueden fallar. Por el contrario, si se le da acceso a un recurso como parte de su acceso a un grupo de recursos, debe elegir como destino un grupo de recursos para poder trabajar con un clúster de dicho grupo. Si no elige como destino de la sesión de CLI el grupo de recursos en el que se encuentra el clúster, las acciones sobre dicho clúster pueden fallar.

Si no encuentra o no puede trabajar con un clúster, es posible que esté experimentando uno de los problemas siguientes:
* Tiene acceso al clúster y al grupo de recursos en el que se encuentra el clúster, pero la sesión de CLI no tiene como destino el grupo de recursos en el que se encuentra el clúster.
* Tiene acceso al clúster, pero no como parte del grupo de recursos en el que se encuentra el clúster. La sesión de CLI tiene como destino este u otro grupo de recursos.
* No tiene acceso al clúster.

{: tsResolve}
Para comprobar sus permisos de acceso de usuario:

1. Obtenga una lista de todos sus permisos de usuario.
    ```
    ibmcloud iam user-policies <your_user_name>
    ```
    {: pre}

2. Compruebe si tiene acceso al clúster y al grupo de recursos en el que se encuentra el clúster.
    1. Busque una política que tenga el valor **Resource Group Name** del grupo de recursos del clúster y el valor **Memo** para `Policy applies to the resource group`. Si tiene esta política, tiene acceso al grupo de recursos. Por ejemplo, esta política indica que un usuario tiene acceso al grupo de recursos `test-rg`:
        ```
        Policy ID:   3ec2c069-fc64-4916-af9e-e6f318e2a16c
        Roles:       Viewer
        Resources:
                     Resource Group ID     50c9b81c983e438b8e42b2e8eca04065
                     Resource Group Name   test-rg
                     Memo                  Policy applies to the resource group
        ```
        {: screen}
    2. Busque una política que tenga el valor **Resource Group Name** del grupo de recursos del clúster, para **Service Name** tenga el valor `containers-kubernetes` o ningún valor y tenga el valor **Memo** para `Policy applies to the resource(s) within the resource group`. Si tiene esta política, tiene acceso a los clústeres o a todos los recursos dentro del grupo de recursos. Por ejemplo, esta política indica que un usuario tiene acceso a los clústeres del grupo de recursos `test-rg`:
        ```
        Policy ID:   e0ad889d-56ba-416c-89ae-a03f3cd8eeea
        Roles:       Administrator
        Resources:
                     Resource Group ID     a8a12accd63b437bbd6d58fb6a462ca7
                     Resource Group Name   test-rg
                     Service Name          containers-kubernetes
                     Service Instance
                     Region
                     Resource Type
                     Resource
                     Memo                  Policy applies to the resource(s) within the resource group
        ```
        {: screen}
    3. Si tiene estas dos políticas, salte al primer punto del paso 4. Si no tiene la política del paso 2a, pero sí tiene la política del paso 2b, salte al segundo punto del paso 4. Si no tiene ninguna de estas políticas, continúe en el paso 3.

3. Compruebe si tiene acceso al clúster, pero no como parte del acceso al grupo de recursos en el que se encuentra el clúster.
    1. Busque una política que no tenga ningún valor junto a los campos **Policy ID** y **Roles**. Si tiene esta política, tiene acceso al clúster como parte del acceso a toda la cuenta. Por ejemplo, esta política indica que un usuario tiene acceso a todos los recursos de la cuenta:
        ```
        Policy ID:   8898bdfd-d520-49a7-85f8-c0d382c4934e
        Roles:       Administrator, Manager
        Resources:
                     Service Name
                     Service Instance
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    2. Busque una política que tenga para **Service Name** el valor `containers-kubernetes` y para **Service Instance** el valor del ID del clúster. Para encontrar el ID de un clúster, ejecute `ibmcloud ks cluster-get <cluster_name>`. Por ejemplo, esta política indica que un usuario tiene acceso a un clúster específico:
        ```
        Policy ID:   140555ce-93ac-4fb2-b15d-6ad726795d90
        Roles:       Administrator
        Resources:
                     Service Name       containers-kubernetes
                     Service Instance   df253b6025d64944ab99ed63bb4567b6
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    3. Si tiene alguna de estas políticas, salte al segundo punto del paso 4. Si no tiene ninguna de estas políticas, salte al tercer punto del paso 4.

4. En función de las políticas de acceso, elija una de las opciones siguientes.
    * Si tiene acceso al clúster y al grupo de recursos en el que se encuentra el clúster:
      1. Elija como destino el grupo de recursos. **Nota**: no se puede trabajar con clústeres en otros grupos de recursos hasta que no se elimine como destino este grupo de recursos.
          ```
          ibmcloud target -g <resource_group>
          ```
          {: pre}

      2. Elija el clúster como destino.
          ```
          ibmcloud ks cluster-config <cluster_name_or_ID>
          ```
          {: pre}

    * Si tiene acceso al clúster pero no al grupo de recursos en el que se encuentra el clúster:
      1. No elija como destino un grupo de recursos. Si ya ha elegido como destino un grupo de recursos, elimínelo como destino:
        ```
        ibmcloud target -g none
        ```
        {: pre}
        Este mandato falla porque no existe ningún grupo de recursos llamado `none`. Sin embargo, el grupo de recursos actual automáticamente deja de ser destino cuando el mandato falla.

      2. Elija el clúster como destino.
        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

    * Si no tiene acceso al clúster:
        1. Solicite al propietario de la cuenta que le asigne un [rol de plataforma {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform) para dicho clúster.
        2. No elija como destino un grupo de recursos. Si ya ha elegido como destino un grupo de recursos, elimínelo como destino:
          ```
          ibmcloud target -g none
          ```
          {: pre}
          Este mandato falla porque no existe ningún grupo de recursos llamado `none`. Sin embargo, el grupo de recursos actual automáticamente deja de ser destino cuando el mandato falla.
        3. Elija el clúster como destino.
          ```
          ibmcloud ks cluster-config <cluster_name_or_ID>
          ```
          {: pre}

<br />


## El acceso al nodo trabajador con SSH falla
{: #cs_ssh_worker}

{: tsSymptoms}
No puede acceder a un nodo trabajador mediante una conexión SSH.

{: tsCauses}
SSH mediante contraseña no está disponible en los nodos trabajadores.

{: tsResolve}
Utilice un [`DaemonSet` de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para las acciones que tenga que ejecutar en cada nodo, o bien utilice trabajos para las acciones únicas que deba ejecutar.

<br />


## El ID de instancia nativa no es coherente con los registros del nodo trabajador
{: #bm_machine_id}

{: tsSymptoms}
Si utiliza mandatos `ibmcloud ks worker` con el nodo trabajador nativo, aparece un mensaje parecido al siguiente.

```
ID de instancia incoherente con los registros del nodo trabajador
```
{: screen}

{: tsCauses}
El ID de máquina puede ser incoherente con el registro del nodo trabajador de {{site.data.keyword.containerlong_notm}} si la máquina experimenta problemas de hardware. Cuando IBM Cloud infraestructura (SoftLayer) soluciona este problema, es posible que un componente cambie dentro del sistema que el servicio no identifica.

{: tsResolve}
Para que {{site.data.keyword.containerlong_notm}} pueda volver a identificar la máquina, [vuelva a cargar el nodo trabajador nativo](cs_cli_reference.html#cs_worker_reload). **Nota**: al volver a cargar, también se actualiza la [versión de parche](cs_versions_changelog.html) de la máquina.

También puede [suprimir el nodo trabajador nativo](cs_cli_reference.html#cs_cluster_rm). **Nota**: las instancias nativas se facturan mensualmente.

<br />


## No se ha podido modificar o suprimir la infraestructura en un clúster huérfano
{: #orphaned}

{: tsSymptoms}
No puede ejecutar mandatos relacionados con la infraestructura en el clúster, como por ejemplo:
* Adición o eliminación de nodos trabajadores
* Recarga o rearranque de nodos trabajadores
* Redimensionamiento de agrupaciones de nodos trabajadores
* Actualización del clúster

No puede ver los nodos trabajadores del clúster en la cuenta de infraestructura de IBM Cloud (SoftLayer). Sin embargo, puede actualizar y gestionar otros clústeres de la cuenta.

Además, ha verificado que tiene las [credenciales de infraestructura adecuadas](#cs_credentials).

{: tsCauses}
Es posible que el clúster se suministre en una cuenta de infraestructura de IBM Cloud (SoftLayer) que ya no esté enlazada a la cuenta {{site.data.keyword.containerlong_notm}}. El clúster está huérfano. Puesto que los recursos se encuentran en otra cuenta, no tiene las credenciales de la infraestructura para modificar los recursos.

Tenga en cuenta el caso de ejemplo siguiente para entender cómo se pueden quedar huérfanas los clústeres.
1.  Tiene una cuenta de pago según uso de {{site.data.keyword.Bluemix_notm}}.
2.  Crea un clúster llamado `Cluster1`. Los nodos trabajadores y otros recursos de la infraestructura se suministran en la cuenta de infraestructura que viene con su cuenta de pago según uso.
3.  Más adelante, averigua que su equipo utiliza una cuenta de infraestructura de IBM Cloud (SoftLayer) heredada o compartida. Utiliza el mandato `ibmcloud ks credential-set` para cambiar las credenciales de la infraestructura de IBM Cloud (SoftLayer) para utilizar la cuenta del equipo.
4.  Crea otro clúster llamado `Cluster2`. Los nodos trabajadores y otros recursos de la infraestructura se suministran en la cuenta de infraestructura del equipo.
5.  Observa que `Cluster1` necesita una actualización del nodo trabajador, o una recarga del nodo trabajador o simplemente desea limpiarlo antes de suprimirlo. Sin embargo, como `Cluster1` se ha suministrado en otra cuenta de infraestructura, no puede modificar sus recursos de la infraestructura. `Cluster1` es huérfano.
6.  Sigue los pasos de resolución de la sección siguiente, pero no restablece las credenciales de la infraestructura en la cuenta de equipo. Puede suprimir `Cluster1`, pero ahora `Cluster2` es huérfano.
7.  Vuelve a cambiar las credenciales de la infraestructura por la cuenta de equipo que creó `Cluster2`. Ahora, ya no tiene un clúster huérfano.

<br>

{: tsResolve}
1.  Compruebe qué cuenta de infraestructura utiliza la región en la que está actualmente el clúster para suministrar clústeres.
    1.  Inicie una sesión en la [consola de clústeres de {{site.data.keyword.containerlong_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/containers-kubernetes/clusters).
    2.  En la tabla, seleccione el clúster.
    3.  En el separador **Visión general**, compruebe si hay un campo **Usuario de infraestructura**. Este campo le ayuda a determinar si la cuenta de {{site.data.keyword.containerlong_notm}} utiliza una cuenta de infraestructura distinta de la predeterminada.
        * Si no ve el campo **Usuario de infraestructura**, tiene una cuenta de Pago según uso enlazada que utiliza las mismas credenciales para las cuentas de infraestructura y de plataforma. Es posible que el clúster que no se puede modificar se suministre en una cuenta de infraestructura distinta.
        * Si ve un campo **Usuario de infraestructura**, significa que utiliza una cuenta de infraestructura distinta de la que se ha suministrado con la cuenta de Pago según uso. Estas credenciales distintas se aplican a todos los clústeres de la región. Es posible que el clúster que no se puede modificar se suministre en su cuenta de pago según uso o en una cuenta de infraestructura distinta.
2.  Compruebe qué cuenta de infraestructura se ha utilizado para suministrar el clúster.
    1.  En el separador **Nodos trabajadores**, seleccione un nodo trabajador y anote su **ID**.
    2.  Abra el menú ![Icono de menú](../icons/icon_hamburger.svg "Icono de menú") y pulse **Infraestructura**.
    3.  En el panel de navegación de infraestructura, pulse **Dispositivos > Lista de dispositivos**.
    4.  Busque el ID de nodo trabajador que ha anotado anteriormente.
    5.  Si no encuentra el ID del nodo trabajador, significa que el nodo trabajador no se suministra en esta cuenta de infraestructura. Cambie a otra cuenta de infraestructura y vuélvalo a intentar.
3.  Utilice el [mandato](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set` para cambiar las credenciales de la infraestructura por la cuenta en la que se han suministrado los nodos trabajadores del clúster, que encontrará en el paso anterior.
    Si ya no tiene acceso y no puede obtener las credenciales de la infraestructura, debe abrir un caso de soporte de {{site.data.keyword.Bluemix_notm}} para eliminar el clúster huérfano.
    {: note}
4.  [Suprima el clúster](cs_clusters.html#remove).
5.  Si lo desea, restablezca las credenciales de la infraestructura de la cuenta anterior. Tenga en cuenta que si ha creado clústeres con una cuenta de infraestructura distinta de la cuenta a la que conmuta, es posible que deje huérfanos dichos clústeres.
    * Para establecer las credenciales en otra cuenta de infraestructura, utilice el [mandato](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set`.
    * Para utilizar las credenciales predeterminadas que se suministran con la cuenta de pago según uso de {{site.data.keyword.Bluemix_notm}}, utilice el [mandato](cs_cli_reference.html#cs_credentials_unset) `ibmcloud ks credential-unset`.

<br />


## Tiempo de espera de mandatos `kubectl`
{: #exec_logs_fail}

{: tsSymptoms}
Si ejecuta mandatos como `kubectl exec`, `kubectl attach`, `kubectl proxy`, `kubectl port-forward` o `kubectl logs`, ve el siguiente mensaje.

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
La conexión OpenVPN entre el nodo maestro y los nodos trabajadores no está funcionando correctamente.

{: tsResolve}
1. Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de infraestructura de IBM Cloud (SoftLayer).
2. Reinicie el pod de cliente de OpenVPN.
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. Si sigue viendo el mismo mensaje de error, entonces el nodo trabajador en el que está el pod de VPN podría estar en un estado no saludable. Para reiniciar el pod de VPN y volverlo a planificar en un nodo trabajador diferente, [acordone, drene y rearranque el nodo trabajador](cs_cli_reference.html#cs_worker_reboot) en el que está el pod de VPN.

<br />


## Al enlazar un servicio a un clúster se produce un error de nombre
{: #cs_duplicate_services}

{: tsSymptoms}
Cuando ejecuta `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, ve el siguiente mensaje.

```
Se han encontrado varios servicios con el mismo nombre.
Ejecute 'ibmcloud service list' para ver las instancias disponibles del servicio Bluemix...
```
{: screen}

{: tsCauses}
Varias instancias de servicio pueden tener el mismo nombre en distintas regiones.

{: tsResolve}
Utilice el GUID de servicio en lugar del nombre de instancia de servicio en el mandato `ibmcloud ks cluster-service-bind`.

1. [Inicie sesión en la región que incluye la instancia de servicio que se debe enlazar.](cs_regions.html#bluemix_regions)

2. Obtenga el GUID de la instancia de servicio.
  ```
  ibmcloud service show <service_instance_name> --guid
  ```
  {: pre}

  Salida:
  ```
  Invocando 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Vuelva a enlazar el servicio al clúster.
  ```
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## Al enlazar un servicio a un clúster se produce un error de no encontrado
{: #cs_not_found_services}

{: tsSymptoms}
Cuando ejecuta `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, ve el siguiente mensaje.

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
Para enlazar servicios a un clúster, debe tener el rol de usuario desarrollador de Cloud Foundry para el espacio de nombres donde se ha suministrado la instancia de servicio. Además, debe tener acceso de editor de {{site.data.keyword.Bluemix_notm}} IAM a {{site.data.keyword.containerlong}}. Para acceder a la instancia de servicio, debe haber iniciado una sesión en el espacio en el que se ha suministrado la instancia de servicio.

{: tsResolve}

**Como usuario: **

1. Inicie una sesión en {{site.data.keyword.Bluemix_notm}}.
   ```
   ibmcloud login
   ```
   {: pre}

2. Defina como destino la organización y el espacio donde se haya suministrado la instancia de servicio.
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. Liste las instancias de servicio para verificar que está en el espacio adecuado.
   ```
   ibmcloud service list
   ```
   {: pre}

4. Intente enlazar de nuevo el servicio. Si recibe el mismo error, póngase en contacto con el administrador de la cuenta y verifique que tiene los permisos suficientes para enlazar a los servicios (consulte los siguientes pasos de administración de la cuenta).

**Como administrador de la cuenta: **

1. Verifique que el usuario que experimenta este problema tiene [permisos de editor para {{site.data.keyword.containerlong}}](/docs/iam/mngiam.html#editing-existing-access).

2. Verifique que el usuario con este problema tiene el [rol de desarrollador de Cloud Foundry para el espacio](/docs/iam/mngcf.html#updating-cloud-foundry-access) en el que se ha suministrado el servicio.

3. Si los permisos son los correctos, intente asignar un permiso diferente y, a continuación, vuelva a asignar los permisos necesarios.

4. Espere unos minutos y, a continuación, deje que el usuario intente enlazar el servicio de nuevo.

5. Si esto no resuelve el problema, entonces los permisos de {{site.data.keyword.Bluemix_notm}} IAM no están sincronizados y no podrá resolver el problema usted mismo. [Póngase en contacto con el equipo de soporte de IBM](/docs/get-support/howtogetsupport.html#getting-customer-support) abriendo un caso de soporte. Asegúrese de proporcionar el ID de clúster, el ID de usuario y el ID de instancia de servicio.
   1. Recupere el ID de clúster.
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. Recupere el ID de la instancia de servicio.
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />


## Al enlazar un servicio a un clúster se produce el error de que el servicio no admite las claves de servicio
{: #cs_service_keys}

{: tsSymptoms}
Cuando ejecuta `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, ve el siguiente mensaje.

```
Este servicio no admite la creación de claves
```
{: screen}

{: tsCauses}
Algunos servicios de {{site.data.keyword.Bluemix_notm}}, como {{site.data.keyword.keymanagementservicelong}} no admiten la creación de credenciales de servicio, también conocidas como claves de servicio. Si no se admiten las claves de servicio, el servicio no se puede enlazar a un clúster. Para consultar una lista de servicios que admiten la creación de claves de servicio, consulte [Habilitación de apps externas para utilizar servicios de {{site.data.keyword.Bluemix_notm}}](/docs/resources/connect_external_app.html#externalapp).

{: tsResolve}
Para integrar servicios que no admiten claves de servicio, compruebe si el servicio proporciona una API que puede utilizar para acceder al servicio directamente desde la app. Por ejemplo, si desea utilizar {{site.data.keyword.keymanagementservicelong}}, consulte la [Referencia de API ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/apidocs/kms?language=curl).

<br />


## Después de que un nodo trabajador se actualice o recargue, aparecen pods y nodos duplicados
{: #cs_duplicate_nodes}

{: tsSymptoms}
Cuando ejecuta `kubectl get nodes`, ve nodos trabajadores duplicados con el estado **NotReady**. Los nodos trabajadores con **NotReady** tienen direcciones IP públicas, mientras que los nodos trabajadores con **Ready** tienen direcciones IP privadas.

{: tsCauses}
Clústeres antiguos listaban nodos trabajadores según la dirección IP pública del clúster. Ahora los nodos trabajadores aparecen listados por la dirección IP privada del clúster. Cuando se vuelve a cargar o se actualiza un nodo, la dirección IP se modifica, pero la referencia a la dirección IP pública permanece.

{: tsResolve}
El servicio no se interrumpe debido a estos duplicados, pero puede eliminar las referencias a los nodos trabajadores antiguos del servidor de API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />


## El acceso a un pod en un nodo trabajador nuevo falla con un tiempo de espera excedido
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Ha suprimido un nodo trabajador del clúster y luego ha añadido un nodo trabajador. Cuando se despliega un pod o un servicio de Kubernetes, el recurso no puede acceder al nodo trabajador recién creado y la conexión supera el tiempo de espera.

{: tsCauses}
Si suprime un nodo trabajador del clúster y luego añade un nodo trabajador, es posible que el nuevo nodo trabajador se asigne a la dirección IP privada del nodo trabajador suprimido. Calico utiliza esta dirección IP privada como código y sigue intentando acceder al nodo suprimido.

{: tsResolve}
Actualice manualmente la referencia a la dirección IP privada de modo que apunte al nodo correcto.

1.  Confirme que tiene dos nodos trabajadores con la misma dirección **IP privada**. Anote la **IP privada** y el **ID** del nodo trabajador suprimido.

  ```
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.11
  ```
  {: screen}

2.  Instale la [CLI de Calico](cs_network_policy.html#adding_network_policies).
3.  Obtenga una lista de los nodos trabajadores disponibles en Calico. Sustituya <path_to_file> por la vía de acceso local al archivo de configuración de Calico.

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Suprima el nodo trabajador duplicado en Calico. Sustituya NODE_ID por el ID del nodo trabajador.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Rearranque el nodo trabajador que no se ha suprimido.

  ```
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


El nodo suprimido ya no aparece en Calico.

<br />




## Las pods no se pueden desplegar debido a una política de seguridad de pod
{: #cs_psp}

{: tsSymptoms}
Después de crear un pod o de ejecutar `kubectl get events` para comprobar un despliegue de pod, ve un mensaje de error similar al siguiente.

```
no se puede validar con ninguna política de seguridad de pod
```
{: screen}

{: tsCauses}
[El controlador de admisiones `PodSecurityPolicy`](cs_psp.html) comprueba la autorización del usuario o de la cuenta de servicio, como un despliegue o tiller de Helm, que ha intentado crear el pod. Si no hay ninguna política de seguridad de pod que dé soporte a la cuenta de usuario o al servicio, el controlador de admisiones `PodSecurityPolicy` impide que se creen los pods.

Si ha suprimido uno de los recursos de la política de seguridad de pod para [la gestión de clústeres de {{site.data.keyword.IBM_notm}}](cs_psp.html#ibm_psp), es posible que experimente problemas similares.

{: tsResolve}
Asegúrese de que el usuario o la cuenta de servicio tenga autorización de la política de seguridad de pod. Es posible que tenga que [modificar una política existente](cs_psp.html#customize_psp).

Si ha suprimido un recurso de gestión de clústeres de {{site.data.keyword.IBM_notm}}, renueve el nodo maestro de Kubernetes para restaurarlo.

1.  [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).
2.  Renueve el nodo maestro de Kubernetes para restaurarlo.

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## El clúster permanece en un estado pendiente
{: #cs_cluster_pending}

{: tsSymptoms}
Al desplegar el clúster, se queda en estado pendiente y no se inicia.

{: tsCauses}
Si acaba de crear el clúster, es posible que los nodos trabajadores aún se estén configurando. Si ya esperado algo de tiempo, es posible que tenga una VLAN no válida.

{: tsResolve}

Puede probar una de las siguientes soluciones:
  - Compruebe el estado del clúster ejecutando `ibmcloud ks clusters`. Luego, compruebe que los nodos trabajadores están desplegados ejecutando `ibmcloud ks workers <cluster_name>`.
  - Compruebe si la VLAN es válida. Para ser válida, una VLAN debe estar asociada con infraestructura que pueda alojar un trabajador con almacenamiento en disco local. Puede [ver una lista de las VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) ejecutando `ibmcloud ks vlans <zone>`; si la VLAN no aparece en la lista, significa que no es válida. Elija una VLAN diferente.

<br />


## Los pods permanecen en estado pendiente
{: #cs_pods_pending}

{: tsSymptoms}
Cuando se ejecuta `kubectl get pods`, puede ver que los pods permanecen en el estado **Pendiente**.

{: tsCauses}
Si acaba de crear el clúster de Kubernetes, es posible que los nodos trabajadores aún se estén configurando.

Si este clúster ya existe:
*  Quizá no tiene suficiente capacidad en el clúster para desplegar el pod.
*  Es posible que el pod haya superado una solicitud o límite de recursos.

{: tsResolve}
Esta tarea requiere el [rol de **Administrador**](cs_users.html#platform) de la plataforma {{site.data.keyword.Bluemix_notm}} IAM para el clúster.

Si acaba de crear el clúster de Kubernetes, ejecute el siguiente mandato y espere que se hayan inicializado los nodos trabajadores.

```
kubectl get nodes
```
{: pre}

Si este clúster ya existe, compruebe la capacidad del clúster.

1.  Establezca el proxy con el número de puerto predeterminado.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Abra el panel de control de Kubernetes.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Compruebe si tiene suficiente capacidad en el clúster para desplegar el pod.

4.  Si no tiene suficiente capacidad en el clúster, cambie el tamaño de la agrupación de nodos trabajadores para añadir más nodos.

    1.  Revise los tamaños y los tipos de máquina actuales de las agrupaciones de nodos trabajadores para decidir cuál va a redimensionar.

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  Cambie el tamaño de las agrupaciones de nodos trabajadores para añadir más nodos a cada zona que abarque la agrupación.

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  Opcional: compruebe las solicitudes de recursos de pod.

    1.  Confirme que los valores de `resources.requests` no son mayores que la capacidad del nodo trabajador. Por ejemplo, si la solicitud de pod es `cpu: 4000m`, o 4 núcleos, pero el tamaño de nodo trabajador es de sólo 2 núcleos, el pod no se puede desplegar.

        ```
        kubectl get pod <pod_name> -o yaml
        ```
        {: pre}

    2.  Si la solicitud supera la capacidad disponible, [añada una nueva agrupación de trabajadores](cs_clusters.html#add_pool) con nodos trabajadores que puedan cumplir la solicitud.

6.  Si los pods continúan en estado **pending** después de que se despliegue por completo el nodo trabajador, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) para solucionar el estado pendiente del pod.

<br />


## Los contenedores no se inician
{: #containers_do_not_start}

{: tsSymptoms}
Los pods se despliegan correctamente en los clústeres, pero los contenedores no inician.

{: tsCauses}
Es posible que los contenedores no se inicien cuando se alcanza la cuota de registro.

{: tsResolve}
[Libere almacenamiento en {{site.data.keyword.registryshort_notm}}.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />


## Los pods no se pueden reiniciar repetidamente o se eliminan inesperadamente
{: #pods_fail}

{: tsSymptoms}
Su pod estaba en buen estado pero inesperadamente se ha eliminado o ha quedado atascado en un bucle de reinicio.

{: tsCauses}
Es posible que sus contenedores superen sus límites de recursos, o que sus pods hayan sido sustituidos por pods de prioridad más alta.

{: tsResolve}
Para ver si un contenedor se ha eliminado debido a un límite de recursos:
<ol><li>Obtenga el nombre del pod. Si ha utilizado una etiqueta, puede incluirla para filtrar los resultados.<pre class="pre"><code>kubectl get pods --selector='app=wasliberty'</code></pre></li>
<li>Describa el pod y busque el **Recuento de reinicios**.<pre class="pre"><code>kubectl describe pod</code></pre></li>
<li>Si el pod se ha reiniciado muchas veces durante un breve periodo de tiempo, capte su estado. <pre class="pre"><code>kubectl get pod -o go-template={{range.status.containerStatuses}}{{"Container Name: "}}{{.name}}{{"\r\nLastState: "}}{{.lastState}}{{end}}</code></pre></li>
<li>Revise el motivo. Por ejemplo, `OOM Killed` significa "sin memoria," lo que indica que el contenedor ha caído debido a un límite de recursos.</li>
<li>Añada capacidad al clúster para disponer de suficientes recursos.</li></ol>

<br>

Para ver si su pod ha sido sustituido por pods de prioridad más alta:
1.  Obtenga el nombre del pod.

    ```
    kubectl get pods
    ```
    {: pre}

2.  Describa el archivo YAML del pod.

    ```
    kubectl get pod <pod_name> -o yaml
    ```
    {: pre}

3.  Compruebe el campo `priorityClassName`.

    1.  Si no hay ningún valor del campo `priorityClassName`, significa que su pod tiene la clase de prioridad `globalDefault`. Si el administrador del clúster no ha establecido una clase de prioridad `globalDefault`, el valor predeterminado es cero (0) o la prioridad más baja. Cualquier pod con una clase de prioridad más alta tiene preferencia sobre su pod o puede eliminarlo.

    2.  Si hay un valor de campo `priorityClassName`, obtenga la clase de prioridad.

        ```
        kubectl get priorityclass <priority_class_name> -o yaml
        ```
        {: pre}

    3.  Observe el campo `value` para comprobar la prioridad del pod.

4.  Obtenga una lista de las clases de prioridad del clúster.

    ```
    kubectl get priorityclasses
    ```
    {: pre}

5.  Para cada clase de prioridad, obtenga el archivo YAML y observe el campo `value`.

    ```
    kubectl get priorityclass <priority_class_name> -o yaml
    ```
    {: pre}

6.  Compare el valor de la clase de prioridad de su pod con los otros valores de clase de prioridad para ver si la prioridad es más alta o más baja.

7.  Repita los pasos del 1 al 3 para los otros pods del clúster, para comprobar qué clase de prioridad están utilizando. Si la clase de prioridad de estos otros pods es más alta que la de su pod, su pod no se suministra a menos que haya recursos suficientes para su pod y para cada pod con prioridad más alta.

8.  Póngase en contacto con el administrador del clúster para añadir más capacidad al clúster y confirmar que se han asignado las clases de prioridad adecuadas.

<br />


## No se puede instalar un diagrama de Helm con valores de configuración actualizados
{: #cs_helm_install}

{: tsSymptoms}
Cuando intenta instalar un diagrama de Helm actualizado ejecutando `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>`, obtiene el mensaje de error `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
El URL del repositorio de {{site.data.keyword.Bluemix_notm}} en la instancia de Helm podría ser incorrecto.

{: tsResolve}
Para resolver el problema del diagrama de Helm:

1. Obtenga una lista de los repositorios disponibles actualmente en la instancia de Helm.

    ```
    helm repo list
    ```
    {: pre}

2. En la salida, verifique que el URL del repositorio de {{site.data.keyword.Bluemix_notm}}, `ibm`, es `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Si el URL es incorrecto:

        1. Elimine el repositorio de {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Añada el repositorio de {{site.data.keyword.Bluemix_notm}} de nuevo.

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Si el URL es correcto, obtenga las últimas actualizaciones del repositorio.

        ```
        helm repo update
        ```
        {: pre}

3. Instale el diagrama de Helm con las actualizaciones.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}

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

