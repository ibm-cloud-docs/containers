---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Asignación de acceso de usuario a clústeres
{: #users}

Puede otorgar acceso a un clúster de Kubernetes para garantizar que solo los usuarios autorizados puedan trabajar con el clúster y desplegar contenedores en el clúster en {{site.data.keyword.containerlong}}.
{:shortdesc}


## Planificación de procesos de comunicación
Como administrador del clúster, considere cómo puede establecer un proceso de comunicación para que los miembros de la organización le comuniquen las solicitudes de acceso, de forma que pueda permanecer organizado.
{:shortdesc}

Proporcione instrucciones a los usuarios del clúster sobre cómo solicitar acceso a un clúster o cómo obtener ayuda con cualquier tipo de tareas comunes de un administrador del clúster. Dado que Kubernetes no facilita este tipo de comunicación, cada equipo puede tener variaciones en su proceso preferido.

Puede elegir cualquiera de los siguientes métodos o establecer su propio método.
- Crear un sistema de incidencias
- Crear una plantilla de formulario
- Crear una página de wiki
- Requerir una solicitud de correo electrónico
- Utilizar el método de seguimiento de problemas que ya utilice para realizar el seguimiento del trabajo diario del equipo


## Gestión de acceso a clústeres
{: #managing}

Cada usuario que trabaje con {{site.data.keyword.containershort_notm}} debe tener asignada una combinación de roles de usuario específicos del servicio que determinan las acciones que el usuario puede realizar.
{:shortdesc}

<dl>
<dt>Políticas de acceso de {{site.data.keyword.containershort_notm}}</dt>
<dd>En Identity and Access Management, las políticas de acceso a {{site.data.keyword.containershort_notm}} determinan las acciones de gestión de clúster que puede llevar a cabo en un clúster, como por ejemplo crear o eliminar clústeres y añadir o eliminar nodos trabajadores adicionales. Estas políticas deben establecerse en conjunto con las políticas de infraestructura. Puede otorgar acceso a clústeres a nivel regional.</dd>
<dt>Políticas de acceso a infraestructura</dt>
<dd>En Identity and Access Management, las políticas de acceso a infraestructura permiten realizar las acciones solicitadas desde la CLI o la interfaz de usuario de {{site.data.keyword.containershort_notm}} en la infraestructura de IBM Cloud (SoftLayer). Estas políticas deben establecerse en conjunto con las políticas de acceso a {{site.data.keyword.containershort_notm}}. [Más información sobre los roles de infraestructura disponibles](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Grupos de recursos</dt>
<dd>Un grupo de recursos es una forma de organizar servicios de {{site.data.keyword.Bluemix_notm}} en agrupaciones de modo que se pueda asignar rápidamente el acceso a más de un recurso a usuarios a la vez. [Aprenda cómo gestionar usuarios utilizando grupos de recursos](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Roles de Cloud Foundry</dt>
<dd>En Identity and Access Management, cada usuario debe tener asignado un rol de usuario de Cloud Foundry. Este rol determina las acciones que el usuario puede llevar a cabo en la cuenta de {{site.data.keyword.Bluemix_notm}}, como por ejemplo invitar a otros usuarios o ver el uso de la cuota. [Más información sobre los roles de Cloud Foundry disponibles](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Roles de RBAC de Kubernetes</dt>
<dd>A cada usuario al que se asigne una política de acceso de {{site.data.keyword.containershort_notm}} se le asigna automáticamente un rol de RBAC de Kubernetes.  En Kubernetes, los roles de RBAC determinan las acciones que puede realizar sobre los recursos de Kubernetes dentro del clúster. Los roles de RBAC se configuran solo para el espacio de nombres predeterminado. El administrador del clúster puede añadir roles de RBAC para otros espacios de nombres del clúster. Consulte la tabla siguiente en la sección [Permisos y políticas de acceso](#access_policies) sección para ver qué rol de RBAC corresponde con qué política de acceso de {{site.data.keyword.containershort_notm}}. Para obtener más información sobre los roles de RBAC en general, consulte [Utilización de la autorización RBAC ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) en la documentación de Kubernetes.</dd>
</dl>

<br />


## Permisos y políticas de acceso
{: #access_policies}

Revise las políticas de acceso y los permisos que puede otorgar a los usuarios de la cuenta de {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

El rol de operador y el de editor de {{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM) tienen permisos separados. Si desea que un usuario, por ejemplo, añada nodos trabajadores y enlace servicios, debe asignar al usuario tanto el rol de operador como el de editor. Para obtener más detalles sobre las políticas de acceso a infraestructura correspondientes, consulte [Personalización de permisos de infraestructura para un usuario](#infra_access).<br/><br/>Si cambia la política de acceso de un usuario, se limpian las políticas RBAC asociadas con el cambio en el clúster. </br></br>**Nota:** Cuando rebaja los permisos, por ejemplo si desea asignar acceso de visor a un usuario que era administrador del clúster, debe esperar unos minutos para que se complete la acción.

|Política de acceso de {{site.data.keyword.containershort_notm}}|Permisos de gestión de clústeres|Permisos de recursos de Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrador|Este rol hereda los permisos de los roles Editor, Operador y Visor para todos los clústeres de esta cuenta. <br/><br/>Cuando se establece para todas las instancias de servicio actuales:<ul><li>Crear un clúster estándar o gratuito</li><li>Establecer las credenciales para una cuenta de {{site.data.keyword.Bluemix_notm}} para acceder al portafolio de la infraestructura de IBM Cloud (SoftLayer)</li><li>Eliminar un clúster</li><li>Asignar y cambiar políticas de acceso de {{site.data.keyword.containershort_notm}} para otros usuarios existentes en esta cuenta.</li></ul><p>Cuando se establece para un ID de clúster específico:<ul><li>Eliminar un clúster específico</li></ul></p>Política de acceso a infraestructura correspondiente: Superusuario<br/><br/><strong>Nota</strong>: para crear recursos como máquinas, VLAN y subredes, los usuarios necesitan el rol de infraestructura **Superusuario**.|<ul><li>Rol de RBAC: cluster-admin</li><li>Acceso de lectura/escritura a los recursos en cada espacio de nombres</li><li>Crear roles dentro de un espacio de nombres</li><li>Acceso al panel de control de Kubernetes</li><li>Crear un recurso Ingress que ponga las apps a disponibilidad pública</li></ul>|
|Operador|<ul><li>Añadir nodos trabajadores adicionales a un clúster</li><li>Eliminar nodos trabajadores de un clúster</li><li>Rearrancar un nodo trabajador</li><li>Volver a cargar un nodo trabajador</li><li>Añadir una subred a un clúster</li></ul><p>Política de acceso a infraestructura correspondiente: [Personalizada](#infra_access)</p>|<ul><li>Rol de RBAC: administrador</li><li>Acceso de lectura/escritura a recursos dentro del espacio de nombres predeterminado pero no para el espacio de nombres en sí</li><li>Crear roles dentro de un espacio de nombres</li></ul>|
|Editor <br/><br/><strong>Consejo</strong>: utilice este rol para los desarrolladores de apps.|<ul><li>Enlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.</li><li>Desenlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.</li><li>Crear un webhook.</li></ul><p>Política de acceso a infraestructura correspondiente: [Personalizada](#infra_access)|<ul><li>Rol de RBAC: editar</li><li>Acceso de lectura/escritura a los recursos internos del espacio de nombres predeterminado</li></ul></p>|
|Visor|<ul><li>Listar un clúster</li><li>Ver los detalles de un clúster</li></ul><p>Política de acceso a infraestructura correspondiente: Solo visualización</p>|<ul><li>Rol de RBAC: ver</li><li>Acceso de lectura a los recursos internos del espacio de nombres predeterminado</li><li>Sin acceso de lectura a los secretos de Kubernetes</li></ul>|

|Política de acceso de Cloud Foundry|Permisos de gestión de cuentas|
|-------------|------------------------------|
|Rol de la organización: Gestor|<ul><li>Añadir usuarios adicionales a una cuenta de {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Rol del espacio: Desarrollador|<ul><li>Crear instancias de servicio de {{site.data.keyword.Bluemix_notm}}</li><li>Vincular instancias de servicio de {{site.data.keyword.Bluemix_notm}} a clústeres</li></ul>| 

<br />



## Descripción de la clave de API IAM y del mandato `bx cs credentials-set`
{: #api_key}

Para suministrar correctamente clústeres en la cuenta y trabajar con ellos, debe asegurarse de que la cuenta esté correctamente configurada para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer). En función de la configuración de la cuenta, puede utilizar la clave de API IAM o las credenciales de infraestructura que establece manualmente mediante el mandato `bx cs credentials-set`.

<dl>
  <dt>Clave de API IAM</dt>
  <dd>La clave de API de Identity and Access Management (IAM) se establece automáticamente para una región cuando se realiza la primera acción que requiere la política de acceso de administrador de {{site.data.keyword.containershort_notm}}. Por ejemplo, uno de los usuarios administrativos crea el primer clúster en la región <code>us-south</code>. De ese modo, la clave de API IAM para este usuario se almacena en la cuenta para esta región. La clave de API se utiliza para pedir infraestructura de IBM Cloud (SoftLayer), como nodos trabajadores nuevos o VLAN. </br></br>
Cuando un usuario distinto realiza una acción en esta región que requiere interacción con el portafolio de infraestructura de IBM Cloud (SoftLayer), como crear un nuevo clúster o recargar un nodo trabajador, la clave de API almacenada se utiliza para determinar si existen suficientes permisos para realizar esa acción. Para asegurarse de que las acciones relacionadas con la infraestructura en el clúster se realicen correctamente, puede asignar a los usuarios administradores de {{site.data.keyword.containershort_notm}} la política de acceso a infraestructura <strong>Superusuario</strong>. </br></br>Puede encontrar el propietario de clave de API actual ejecutando [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Si necesita actualizar la clave de API que hay almacenada para una región, puede hacerlo mediante la ejecución del mandato [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Este mandato requiere la política de acceso de administrador de {{site.data.keyword.containershort_notm}} y almacena la clave de API del usuario que ejecuta este mandato en la cuenta. </br></br> <strong>Nota:</strong> La clave de API que se almacena para la región no puede utilizarse si las credenciales de infraestructura de IBM Cloud (SoftLayer) se han establecido manualmente mediante el mandato <code>bx cs credentials-set</code>. </dd>
<dt>Credenciales de infraestructura de IBM Cloud (SoftLayer) mediante <code>bx cs credentials-set</code></dt>
<dd>Si tiene una cuenta de pago según uso de {{site.data.keyword.Bluemix_notm}}, tiene acceso al portafolio de infraestructura de IBM Cloud (de SoftLayer) de forma predeterminada. Sin embargo, es posible que desee utilizar otra cuenta de infraestructura de IBM Cloud (SoftLayer) que ya tenga para solicitar infraestructura. Puede enlazar esta cuenta de infraestructura a la cuenta de {{site.data.keyword.Bluemix_notm}} mediante el mandato [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set). </br></br>Si las credenciales de infraestructura de IBM Cloud (SoftLayer) se establecen manualmente, estas credenciales se utilizan para pedir infraestructura, aunque ya exista una clave de API IAM para la cuenta. Si el usuario cuyas credenciales se almacenan no tiene los permisos necesarios para pedir infraestructura, entonces las acciones relacionadas con la infraestructura, como crear un clúster o recargar un nodo trabajador, pueden fallar. </br></br> Para eliminar las credenciales de infraestructura de IBM Cloud (SoftLayer) establecidas manualmente, puede utilizar el mandato [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Una vez eliminadas las credenciales, la clave de API IAM se utiliza para pedir infraestructura. </dd>
</dl>

## Adición de usuarios a una cuenta de {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Puede añadir usuarios a una cuenta de {{site.data.keyword.Bluemix_notm}} para otorgarles acceso a sus clústeres.
{:shortdesc}

Antes de empezar, verifique que se le haya asignado el rol de Gestor de Cloud Foundry para una cuenta de {{site.data.keyword.Bluemix_notm}}.

1.  [Añada el usuario a la cuenta](../iam/iamuserinv.html#iamuserinv).
2.  En la sección **Acceso**, expanda **Servicios**.
3.  Asigne un rol de acceso de {{site.data.keyword.containershort_notm}}. Desde la lista desplegable **Asignar acceso a**, decida si desea conceder acceso solo a su cuenta de {{site.data.keyword.containershort_notm}} (**Recurso**) o a una recopilación de varios recursos dentro de la cuenta (**Grupo de recursos**).
  -  Para **Recurso**:
      1. En la lista desplegable **Servicios**, seleccione **{{site.data.keyword.containershort_notm}}**.
      2. En la lista desplegable **Región**, seleccione la zona a la que va a invitar al usuario. **Nota**: Para acceder a los clústeres en la [región AP Norte](cs_regions.html#locations), consulte [Cómo otorgar acceso de IAM a los usuarios para los clústeres en la región AP Norte](#iam_cluster_region).
      3. En la lista desplegable **Instancia de servicio**, seleccione el clúster al que va a invitar al usuario. Para encontrar el ID de un clúster específico, ejecute ` bx cs clusters`.
      4. En la sección **Seleccionar roles**, seleccione un rol. Para ver una lista de las acciones admitidas por rol, consulte [Permisos y políticas de acceso](#access_policies).
  - Para **Grupo de recursos**:
      1. Desde la lista desplegable **Grupo de recursos**, seleccione el grupo de recursos, seleccione el grupo de recursos que incluya permisos para el recurso {{site.data.keyword.containershort_notm}} de la cuenta.
      2. Desde la lista desplegable **Asignar acceso a un grupo de recursos**, seleccione un rol. Para ver una lista de las acciones admitidas por rol, consulte [Permisos y políticas de acceso](#access_policies).
4. [Opcional: asigne un rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. [Opcional: asigne un rol de infraestructura](/docs/iam/infrastructureaccess.html#infrapermission).
6. Pulse **Invitar a usuarios**.

<br />


### Cómo otorgar acceso de IAM a los usuarios para los clústeres en la región AP Norte
{: #iam_cluster_region}

Cuando [añada usuarios a la cuenta de {{site.data.keyword.Bluemix_notm}} ](#add_users), seleccione las regiones a la que les otorga acceso. Sin embargo, algunas regiones, como AP Norte, podrían no estar disponibles en la consola, y se deben añadir mediante la CLI.
{:shortdesc}

Antes de empezar, verifique que es un administrador de la cuenta de {{site.data.keyword.Bluemix_notm}}.

1.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Seleccione la cuenta que quiera utilizar.

    ```
    bx login [--sso]
    ```
    {: pre}

    **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar
la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.

2.  Defina como destino el entorno al que desea otorgar permisos, como la región AP Norte (`jp-tok`). Para obtener más detalles sobre las opciones de mandato, como la organización y el espacio, consulte el [mandato `bluemix target`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target).

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  Obtenga el nombre o los ID de los clústeres de la región a la que desea otorgar acceso.

    ```
    bx cs clusters
    ```
    {: pre}

4.  Obtenga los ID de usuario a los que desea otorgar acceso.

    ```
    bx account users
    ```
    {: pre}

5.  Seleccione los roles para la política de acceso.

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  Otorgue al usuario acceso al clúster con el rol adecuado. Este ejemplo asigna a `user@example.com` los roles de `Operador` y `Editor` para tres clústeres.

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    Para otorgar acceso a clústeres existentes y futuros en la región, no especifique el distintivo `--service-instance`. Para obtener más información, consulte el mandato [`bluemix iam user-policy-create`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create).
    {:tip}

## Personalización de permisos de infraestructura para un usuario
{: #infra_access}

Cuando se establecen las políticas de infraestructura en Identity and Access Management, se otorgan permisos a un usuario que están asociados con un rol. Para personalizar esos permisos, debe iniciar sesión en la infraestructura de IBM Cloud (SoftLayer) y ajustar los permisos allí.
{: #view_access}

Por ejemplo, los **Usuarios básicos** pueden rearrancar un nodo trabajador, pero no pueden recargarlo. Sin dar a esa persona permisos de **Superusuario**, puede ajustar los permisos de la infraestructura de IBM Cloud (SoftLayer) y añadir el permiso para ejecutar un mandato de recarga.

1.  Inicie la sesión en [cuenta de {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) y, a continuación, desde el menú, seleccione **Infraestructura**.

2.  Vaya a **Cuenta** > **Usuarios** > **Lista de usuarios**.

3.  Para modificar permisos, seleccione el nombre de un perfil de usuario o la columna **Acceso de dispositivos**.

4.  En el separador **Permisos de portal**, personalice el acceso de usuario. Los permisos que los usuarios necesitan dependen de los recursos de infraestructura que necesitan utilizar:

    * Utilice la lista desplegable **Permisos rápidos** para asignar el rol **Superusuario**, que da al usuario todos los permisos.
    * Utilice la lista desplegable **Permisos rápidos** para asignar el rol **Usuario básico**, que da al usuario algunos permisos necesarios, pero no todos.
    * Si no desea otorgar todos los permisos con el rol **Superusuario** o necesita añadir más permisos que los del rol **Usuario básico**, consulte la tabla siguiente, que describe los permisos necesarios para realizar tareas comunes en {{site.data.keyword.containershort_notm}}.

    <table summary="Permisos de infraestructura para casos de ejemplo comunes de {{site.data.keyword.containershort_notm}}.">
     <caption>Permisos de infraestructura necesarios habitualmente para {{site.data.keyword.containershort_notm}}</caption>
     <thead>
     <th>Tareas comunes en {{site.data.keyword.containershort_notm}}</th>
     <th>Permisos de infraestructura necesarios por separador</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>Permisos mínimos</strong>: <ul><li>Cree un clúster.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Ver detalles de servidores virtuales</li><li>Rearrancar servidor y ver información del sistema IPMI</li><li>Emitir recargas de SO e iniciar el kernel de rescate</li></ul><strong>Cuenta</strong>: <ul><li>Añadir/actualizar instancias de nube</li><li>Añadir servidor</li></ul></td>
     </tr>
     <tr>
     <td><strong>Administración de clúster</strong>: <ul><li>Crear, actualizar y suprimir clústeres.</li><li>Añadir, cargar y rearrancar nodos trabajadores.</li><li>Ver VLAN.</li><li>Crear subredes.</li><li>Desplegar pods y servicios del equilibrador de carga.</li></ul></td>
     <td><strong>Soporte</strong>:<ul><li>Ver tíquets</li><li>Añadir tíquets</li><li>Editar tíquets</li></ul>
     <strong>Dispositivos</strong>:<ul><li>Ver detalles de servidores virtuales</li><li>Rearrancar servidor y ver información del sistema IPMI</li><li>Actualizar servidor</li><li>Emitir recargas de SO e iniciar el kernel de rescate</li></ul>
     <strong>Servicios</strong>:<ul><li>Gestionar claves SSH</li></ul>
     <strong>Cuenta</strong>:<ul><li>Ver información de cuenta</li><li>Añadir/actualizar instancias de nube</li><li>Cancelar servidor</li><li>Añadir servidor</li></ul></td>
     </tr>
     <tr>
     <td><strong>Almacenamiento</strong>: <ul><li>Crear reclamaciones de volumen persistente para suministrar volúmenes persistentes.</li><li>Crear y gestionar recursos de infraestructura de almacenamiento.</li></ul></td>
     <td><strong>Servicios</strong>:<ul><li>Gestionar almacenamiento</li></ul><strong>Cuenta</strong>:<ul><li>Añadir almacenamiento</li></ul></td>
     </tr>
     <tr>
     <td><strong>Gestión de redes privadas</strong>: <ul><li>Gestionar VLAN privadas para redes en clúster.</li><li>Configurar conectividad de VPN en redes privadas.</li></ul></td>
     <td><strong>Red</strong>:<ul><li>Gestionar rutas de subredes de la red</li><li>Gestionar expansión de VLAN de la red</li><li>Gestionar túneles de red IPSEC</li><li>Gestionar pasarelas de red</li><li>Administración de VPN</li></ul></td>
     </tr>
     <tr>
     <td><strong>Gestión de redes públicas</strong>:<ul><li>Configurar las redes públicas de Ingress y del equilibrador de carga para exponer apps.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Gestionar equilibradores de carga</li><li>Editar nombre de host/dominio</li><li>Gestionar control de puertos</li></ul>
     <strong>Red</strong>:<ul><li>Añadir sistema con puerto de red pública</li><li>Gestionar rutas de subredes de la red</li><li>Gestionar expansión de VLAN de la red</li><li>Añadir direcciones IP</li></ul>
     <strong>Servicios</strong>:<ul><li>Gestionar DNS, DNS inverso y WHOIS</li><li>Ver certificados (SSL)</li><li>Gestionar certificados (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  Para guardar los cambios, pulse **Editar permisos del portal**.

6.  En el separador **Acceso de dispositivos**, seleccione los dispositivos a los que desea otorgar acceso.

    * En el desplegable de **Tipo de dispositivo**, puede otorgar acceso a **Todos los servidores virtuales**.
    * Para permitir a los usuarios acceder a nuevos dispositivos que se crean, seleccione **Otorgar acceso automáticamente cuando se añadan nuevos dispositivos**.
    * Para guardar los cambios, pulse **Actualizar acceso de dispositivos**.

7.  Vuelva a la lista de perfiles de usuario y verifique que se ha otorgado el **Acceso de dispositivos**.

## Autorización de usuarios con roles de RBAC de Kubernetes personalizados
{: #rbac}

Las políticas de acceso de {{site.data.keyword.containershort_notm}} corresponden a determinados roles de control de acceso basado en roles (RBAC) de Kubernetes, tal como se describe en [Permisos y políticas de acceso](#access_policies). Para autorizar otros roles de Kubernetes que difieren de la política de acceso correspondiente, puede personalizar los roles de RBAC y luego asignar los roles a usuarios individuales o grupos de usuarios.
{: shortdesc}

Por ejemplo, es posible que desee otorgar permisos a un equipo de desarrolladores para trabajar en un determinado grupo de API o con recursos dentro de un espacio de nombres de Kubernetes en el clúster, pero no en todo el clúster. Puede crear un rol y luego enlazar el rol a los usuarios, utilizando un nombre de usuario que sea exclusivo para {{site.data.keyword.containershort_notm}}. Para obtener información más detallada, consulte [Utilización de la autorización RBAC ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) en la documentación de Kubernetes.

Antes de empezar, [defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure).

1.  Cree el rol con el acceso que desea asignar.

    1. Cree un archivo `.yaml` para definir el rol con el acceso que desea asignar.

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Tabla. Visión general de los componentes de YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes de YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Utilice `Role` para otorgar acceso a los recursos dentro de un espacio de nombres único o `ClusterRole` para los recursos de todo el clúster.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Para clústeres que ejecutan Kubernetes 1.8 o posterior, utilice `rbac.authorization.k8s.io/v1`. </li><li>Para versiones anteriores, utilice `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Para el tipo `Role`: Especifique el espacio de nombres de Kubernetes al que se otorga acceso.</li><li>No utilice el campo `namespace` si está creando un `ClusterRole` que se aplica a nivel de clúster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Asigne un nombre al rol y utilice el nombre más adelante cuando enlace el rol.</td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>Especifique los grupos de API de Kubernetes con los que desea que puedan interactuar los usuarios, como `"apps"`, `"batch"` o `"extensions"`. </li><li>Para acceder al grupo de API principal en la vía de acceso de REST `api/v1`, deje el grupo en blanco: `[""]`.</li><li>Para obtener más información, consulte [grupos de API ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/api-overview/#api-groups) en la documentación de Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>Especifique los recursos de Kubernetes a los que desea otorgar acceso, como `"daemonsets"`, `"deployments"`, `"events"` o `"ingresses"`.</li><li>Si especifica `"nodes"`, entonces el tipo de rol debe ser `ClusterRole`.</li><li>Para obtener una lista de recursos, consulte la tabla de [tipos de recurso ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) en la hoja de apuntes de Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>Especifique los tipos de acciones que desea que los usuarios puedan hacer, como `"get"`, `"list"`, `"describe"`, `"create"` o `"delete"`. </li><li>Para ver una lista completa de verbos, consulte la [documentación de `kubectl`![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  Cree el rol en el clúster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Verifique que se ha creado el rol.

        ```
        kubectl get roles
        ```
        {: pre}

2.  Enlace usuarios al rol.

    1. Cree un archivo `.yaml` para enlazar usuarios al rol. Anote el URL exclusivo que se debe utilizar para el nombre de cada sujeto.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Tabla. Visión general de los componentes de YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes de YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>En `kind`, especifique `RoleBinding` para los dos tipos de archivos `.yaml` de roles: `Role` en espacio de nombres `ClusterRole` en todo el clúster.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Para clústeres que ejecutan Kubernetes 1.8 o posterior, utilice `rbac.authorization.k8s.io/v1`. </li><li>Para versiones anteriores, utilice `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Para el tipo `Role`: Especifique el espacio de nombres de Kubernetes al que se otorga acceso.</li><li>No utilice el campo `namespace` si está creando un `ClusterRole` que se aplica a nivel de clúster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Asigne un nombre al enlace de rol.</td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>Especifique el tipo como `User`.</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>Añada la dirección de correo electrónico del usuario al URL siguiente: `https://iam.ng.bluemix.net/kubernetes#`.</li><li>Por ejemplo, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>Utilice `rbac.authorization.k8s.io`.</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>Especifique el mismo valor que el de `kind` en el archivo `.yaml` de roles: `Role` o `ClusterRole`.</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>Especifique el nombre del archivo `.yaml` de roles.</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>Utilice `rbac.authorization.k8s.io`.</td>
        </tr>
        </tbody>
        </table>

    2. Cree el recurso de enlace de rol en el clúster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Verifique que se ha creado el enlace.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Ahora que ha creado y enlazado un rol de RBAC de Kubernetes personalizado, siga con los usuarios. Pídales que prueben una acción que tengan permiso para realizar debido al rol, como suprimir un pod.
