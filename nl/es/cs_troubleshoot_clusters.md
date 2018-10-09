---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
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

## No se puede conectar con la cuenta de infraestructura
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

{: tsCauses}
Las cuentas de Pago según uso de {{site.data.keyword.Bluemix_notm}} creadas después de haber enlazado una cuenta automática ya se han configurado con acceso a la infraestructura de IBM Cloud (SoftLayer). Es posible adquirir recursos de la infraestructura para el clúster sin configuración adicional. Si tiene una cuenta de Pago según uso válida y recibe este mensaje de error, es posible que no esté utilizando las credenciales de cuenta de la infraestructura de IBM Cloud (SoftLayer) correctas para acceder a los recursos de la infraestructura.

Los usuarios con otros tipos de cuenta de {{site.data.keyword.Bluemix_notm}} deben configurar sus cuentas para crear clústeres estándares. Los ejemplos de cuándo puede tener un tipo de cuenta diferente son los siguientes:
* Tiene una cuenta de infraestructura de IBM Cloud (SoftLayer) existente que es anterior a la cuenta de plataforma de {{site.data.keyword.Bluemix_notm}} y que desea continuar utilizando.
* Desea utilizar una cuenta de infraestructura de IBM Cloud distinta (SoftLayer) en la que suministrar recursos de infraestructura. Por ejemplo, puede configurar una cuenta de {{site.data.keyword.Bluemix_notm}} de equipo para que utilice una cuenta de infraestructura distinta con fines de facturación.

{: tsResolve}
El propietario de la cuenta debe configurar correctamente las credenciales de la cuenta de la infraestructura. Las credenciales dependen del tipo de cuenta de infraestructura que esté utilizando.

**Antes de empezar**:

1.  Verifique que tiene acceso a una cuenta de infraestructura. Inicie una sesión en la [consola de {{site.data.keyword.Bluemix_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/) y, desde el menú emergente, pulse **Infraestructura**. Si ve el panel de control de la infraestructura, significa que tiene acceso a una cuenta de infraestructura.
2.  Compruebe si el clúster utiliza una cuenta de infraestructura distinta de la que se suministra con la cuenta de Pago según uso.
    1.  En el menú emergente, pulse **Contenedores > Clústeres**.
    2.  En la tabla, seleccione el clúster.
    3.  En el separador **Visión general**, compruebe si hay un campo **Usuario de infraestructura**.
        * Si no ve el campo **Usuario de infraestructura**, tiene una cuenta de Pago según uso enlazada que utiliza las mismas credenciales para las cuentas de infraestructura y de plataforma.
        * Si ve un campo **Usuario de infraestructura**, significa que el clúster utiliza una cuenta de infraestructura distinta de la que se ha suministrado con la cuenta de Pago según uso. Estas credenciales distintas se aplican a todos los clústeres de la región. 
3.  Decida el tipo de cuenta que desea tener para determinar cómo resolver el problema de permisos de infraestructura. Para la mayoría de los usuarios, la cuenta predeterminada enlazada de Pago según uso es suficiente.
    *  Cuenta de {{site.data.keyword.Bluemix_notm}} de Pago según uso enlazada: [Compruebe que la clave de API de la infraestructura esté configurada con los permisos correctos](#apikey). Si el clúster utiliza una cuenta de infraestructura distinta, debe desestablecer dichas credenciales como parte del proceso.
    *  Cuentas diferentes de infraestructura y plataforma de {{site.data.keyword.Bluemix_notm}}: compruebe que puede acceder al portafolio de la infraestructura y que [las credenciales de la cuenta de la infraestructura están correctamente configuradas con los permisos correctos](#credentials).

### Utilización de las credenciales de infraestructura predeterminadas para cuentas de Pago según uso con la clave de API
{: #apikey}

1.  Verifique que el usuario cuyas credenciales desea utilizar para acciones de la infraestructura tenga los permisos correctos.

    1.  Inicie una sesión en [{{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/).

    2.  En el menú que aparece, seleccione **Infraestructura**.

    3.  En la barra de menús, seleccione **Cuenta** > **Usuarios** > **Lista de usuarios**.

    4.  En la columna **Clave de API**, verifique que el usuario tiene una clave de API o pulse **Generar**.

    5.  Verifique o asigne al usuario los [permisos de infraestructura correctos](cs_users.html#infra_access).

2.  Establezca la clave de API para la región en la que se encuentra el clúster.

    1.  Inicie sesión en el terminal con el usuario cuyos permisos de infraestructura desea utilizar.
    
    2.  Si se encuentra en una región distinta, cambie a la región en la que desea establecer la clave de API.
    
        ```
        ibmcloud ks region-set
        ```
        {: pre}

    3.  Establezca la clave de API del usuario para la región.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    

    4.  Compruebe que la clave de API está establecida.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

3.  **Opcional**: si la cuenta de Pago según uso utiliza una cuenta de infraestructura distinta para suministrar clústeres (por ejemplo, ha utilizado el mandato `ibmcloud ks credentials-set`), la cuenta sigue utilizando dichas credenciales de infraestructura en lugar de la clave de API. Debe eliminar la cuenta de infraestructura asociada para que se utilice la clave de API que ha establecido en el paso anterior.
    ```
    ibmcloud ks credentials-unset
    ```
    {: pre}
        
4.  **Opcional**: si conecta el clúster público a recursos locales, compruebe la conectividad de red.

    1.  Compruebe la conectividad de VLAN del nodo trabajador.
    2.  Si es necesario, [configure la conectividad VPN](cs_vpn.html#vpn).
    3.  [Abra los puertos necesarios en el cortafuegos](cs_firewall.html#firewall).

### Configuración de las credenciales de infraestructura para distintas cuentas de plataforma e infraestructura
{: #credentials}

1.  Obtenga la cuenta de la infraestructura que desea utilizar para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer). Dispone de distintas opciones que dependen del tipo de cuenta actual.

    <table summary="En la tabla se muestran las opciones de creación de clúster estándar por tipo de cuenta. Las filas se leen de izquierda a derecha; la descripción de la cuenta está en la columna uno y las opciones para crear un clúster estándar en la columna dos.">
    <caption>Opciones de creación de clúster estándar por tipo de cuenta</caption>
      <thead>
      <th>Descripción de la cuenta</th>
      <th>Opciones para crear un clúster estándar</th>
      </thead>
      <tbody>
        <tr>
          <td>Las **cuentas Lite** no pueden suministrar clústeres.</td>
          <td>[Actualice su cuenta Lite a una cuenta de {{site.data.keyword.Bluemix_notm}} de Pago según uso](/docs/account/index.html#paygo) que está configurada para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer).</td>
        </tr>
        <tr>
          <td>Las cuentas de **Pago según uso reciente** se suministran con acceso al portafolio de la infraestructura.</td>
          <td>Puede crear clústeres estándares. Para resolver los problemas de permisos de la infraestructura, consulte [Configuración de las credenciales de API de infraestructura para cuentas enlazadas](#apikey).</td>
        </tr>
        <tr>
          <td>Las cuentas de **Pago según uso antiguas** que se crearon antes de que estuviese disponible el enlace de cuentas automático, no tenían acceso al portafolio de la infraestructura de IBM Cloud (SoftLayer).<p>Si tiene una cuenta existente de infraestructura de IBM Cloud (SoftLayer), no puede enlazarla a una cuenta antigua de Pago según uso.</p></td>
          <td><p><strong>Opción 1: </strong> [Crear una nueva cuenta de Pago según uso](/docs/account/index.html#paygo) que esté configurada para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer). Cuando elige esta opción, tendrá dos cuentas y dos facturaciones distintas para {{site.data.keyword.Bluemix_notm}}.</p><p>Para continuar utilizando su cuenta antigua de Pago según uso, debe utilizar su nueva cuenta de Pago según uso para generar una clave de API para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer).</p><p><strong>Opción 2:</strong> si ya tiene una cuenta de la infraestructura de IBM Cloud (SoftLayer) existente que desea utilizar, puede configurar sus credenciales en su cuenta de {{site.data.keyword.Bluemix_notm}}.</p><p>**Nota:** Cuando enlaza de forma manual a una cuenta de infraestructura de IBM Cloud (SoftLayer), las credenciales se utilizan para cada acción específica de la infraestructura de IBM Cloud (SoftLayer) en su cuenta de {{site.data.keyword.Bluemix_notm}}. Debe asegurarse de que la clave de API que ha establecido tiene [suficientes permisos de infraestructura](cs_users.html#infra_access) para que los usuarios pueden crear y trabajar con clústeres.</p><p>**Para ambas opciones, continúe en el paso siguiente**.</p></td>
        </tr>
        <tr>
          <td>Las **cuentas de Suscripción** no se configuran con acceso al portafolio de infraestructura de IBM Cloud (SoftLayer).</td>
          <td><p><strong>Opción 1: </strong> [Crear una nueva cuenta de Pago según uso](/docs/account/index.html#paygo) que esté configurada para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer). Cuando elige esta opción, tendrá dos cuentas y dos facturaciones distintas para {{site.data.keyword.Bluemix_notm}}.</p><p>Si desea continuar utilizando su cuenta de Suscripción, debe utilizar su nueva cuenta de Pago según uso para generar una clave de API en la infraestructura de IBM Cloud (SoftLayer). Debe configurar la clave de la API de la infraestructura de IBM Cloud (SoftLayer) de forma manual para su cuenta de Suscripción. Tenga en cuenta que los recursos de infraestructura de IBM Cloud (SoftLayer) se facturarán a través de su nueva cuenta de Pago según uso.</p><p><strong>Opción 2:</strong> si ya tiene una cuenta de la infraestructura de IBM Cloud (SoftLayer) existente que desea utilizar, puede configurar sus credenciales de forma manual para su cuenta de {{site.data.keyword.Bluemix_notm}}.</p><p>**Nota:** Cuando enlaza de forma manual a una cuenta de infraestructura de IBM Cloud (SoftLayer), las credenciales se utilizan para cada acción específica de la infraestructura de IBM Cloud (SoftLayer) en su cuenta de {{site.data.keyword.Bluemix_notm}}. Debe asegurarse de que la clave de API que ha establecido tiene [suficientes permisos de infraestructura](cs_users.html#infra_access) para que los usuarios pueden crear y trabajar con clústeres.</p><p>**Para ambas opciones, continúe en el paso siguiente**.</p></td>
        </tr>
        <tr>
          <td>**Cuentas de infraestructura de IBM Cloud (SoftLayer)**, no cuenta de {{site.data.keyword.Bluemix_notm}}</td>
          <td><p>[Crear una nueva cuenta de Pago según uso de {{site.data.keyword.Bluemix_notm}}](/docs/account/index.html#paygo) que esté configurada para acceder al portafolio de la infraestructura de IBM Cloud (SoftLayer). Cuando elige esta opción, se le crea en su nombre una cuenta de infraestructura de IBM Cloud (SoftLayer). Tiene dos cuentas y facturaciones separadas de infraestructura de IBM Cloud (SoftLayer).</p><p>De forma predeterminada, la nueva cuenta de {{site.keyword.data.Bluemix_notm}} utiliza la nueva cuenta de infraestructura. Para seguir utilizando la cuenta de infraestructura antigua, continúe en el paso siguiente.</p></td>
        </tr>
      </tbody>
      </table>

2.  Verifique que el usuario cuyas credenciales desea utilizar para acciones de la infraestructura tenga los permisos correctos.

    1.  Inicie una sesión en [{{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/).

    2.  En el menú que aparece, seleccione **Infraestructura**.

    3.  En la barra de menús, seleccione **Cuenta** > **Usuarios** > **Lista de usuarios**.

    4.  En la columna **Clave de API**, verifique que el usuario tiene una clave de API o pulse **Generar**.

    5.  Verifique o asigne al usuario los [permisos de infraestructura correctos](cs_users.html#infra_access).

3.  Establezca las credenciales de API de la infraestructura con el usuario correspondiente a la cuenta correcta.

    1.  Obtenga las credenciales de API de la infraestructura del usuario. **Nota**: las credenciales difieren del IBMid.

        1.  En la tabla de la consola [{{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/) **Infraestructura** > **Cuenta** > **Usuarios** > **Lista de usuarios**, pulse **IBMid o nombre de usuario**.

        2.  En la sección **Información de acceso de API**, visualice el **Nombre de usuario de API** y la **Clave de autenticación**.    

    2.  Defina las credenciales de API de la infraestructura que desea utilizar.
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4.  **Opcional**: si conecta el clúster público a recursos locales, compruebe la conectividad de red.

    1.  Compruebe la conectividad de VLAN del nodo trabajador.
    2.  Si es necesario, [configure la conectividad VPN](cs_vpn.html#vpn).
    3.  [Abra los puertos necesarios en el cortafuegos](cs_firewall.html#firewall).

<br />


## El cortafuegos impide ejecutar mandatos de CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Cuando ejecuta los mandatos `ibmcloud`, `kubectl` o `calicoctl` desde la CLI, fallan.

{: tsCauses}
Puede que tenga políticas de red corporativas que impidan el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos.

{: tsResolve}
[Permita el acceso TCP para que funciones los mandatos de CLI](cs_firewall.html#firewall). Esta tarea precisa de la [política de acceso de administrador](cs_users.html#access_policies). Verifique su [política de acceso](cs_users.html#infra_access) actual.


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
[Permita que el clúster acceda a los recursos de infraestructura y a otros servicios](cs_firewall.html#firewall_outbound). Esta tarea precisa de la [política de acceso de administrador](cs_users.html#access_policies). Verifique su [política de acceso](cs_users.html#infra_access) actual.

<br />



## El acceso al nodo trabajador con SSH falla
{: #cs_ssh_worker}

{: tsSymptoms}
No puede acceder an un nodo trabajador mediante una conexión SSH.

{: tsCauses}
SSH mediante contraseña no está disponible en los nodos trabajadores.

{: tsResolve}
Utilice [DaemonSets ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para las acciones que debe ejecutar en cada nodo o bien utilice trabajos para acciones puntuales que deba ejecutar.

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
1. Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de la infraestructura de IBM Cloud (SoftLayer).
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
Para enlazar servicios a un clúster, debe tener el rol de usuario desarrollador de Cloud Foundry para el espacio de nombres donde se ha suministrado la instancia de servicio. Además, debe tener acceso de editor de IAM a {{site.data.keyword.containerlong}}. Para acceder a la instancia de servicio, debe haber iniciado una sesión en el espacio en el que se ha suministrado la instancia de servicio.

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

5. Si esto no resuelve el problema, entonces los permisos de IAM no están sincronizados y no podrá resolver el problema usted mismo. [Póngase en contacto con el equipo de soporte de IBM](/docs/get-support/howtogetsupport.html#getting-customer-support) abriendo una incidencia de soporte. Asegúrese de proporcionar el ID de clúster, el ID de usuario y el ID de instancia de servicio.
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
Algunos servicios de {{site.data.keyword.Bluemix_notm}}, como {{site.data.keyword.keymanagementservicelong}} no admiten la creación de credenciales de servicio, también conocidas como claves de servicio. Si no se admiten las claves de servicio, el servicio no se puede enlazar a un clúster. Para consultar una lista de servicios que admiten la creación de claves de servicio, consulte [Habilitación de apps externas para utilizar servicios de {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#accser_external).

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.7
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.7
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

1.  Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).
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
Esta tarea precisa de la [política de acceso de administrador](cs_users.html#access_policies). Verifique su [política de acceso](cs_users.html#infra_access) actual.

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
-   Publique una pregunta en [{{site.data.keyword.containerlong_notm}}Slack ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibm-container-service.slack.com).

    Si no utiliza un ID de IBM para la cuenta de {{site.data.keyword.Bluemix_notm}}, [solicite una invitación](https://bxcs-slack-invite.mybluemix.net/) a este Slack.
    {: tip}
-   Revise los foros para ver si otros usuarios se han encontrado con el mismo problema. Cuando utiliza los foros para formular una pregunta, etiquete la pregunta para que la puedan ver los equipos de desarrollo de {{site.data.keyword.Bluemix_notm}}.

    -   Si tiene preguntas técnicas sobre el desarrollo o despliegue de clústeres o apps con {{site.data.keyword.containerlong_notm}}, publique su pregunta en [Stack Overflow ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) y etiquete su pregunta con `ibm-cloud`, `kubernetes` y `containers`.
    -   Para las preguntas relativas a las instrucciones de inicio y el servicio, utilice el foro [IBM Developer Answers ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluya las etiquetas `ibm-cloud` y `containers`.
    Consulte [Obtención de ayuda](/docs/get-support/howtogetsupport.html#using-avatar) para obtener más detalles sobre cómo utilizar los foros.

-   Póngase en contacto con el soporte de IBM abriendo una incidencia. Para obtener información sobre cómo abrir una incidencia de soporte de IBM, o sobre los niveles de soporte y las gravedades de las incidencias, consulte [Cómo contactar con el servicio de soporte](/docs/get-support/howtogetsupport.html#getting-customer-support).

{: tip}
Al informar de un problema, incluya el ID de clúster. Para obtener el ID de clúster, ejecute `ibmcloud ks clusters`.

