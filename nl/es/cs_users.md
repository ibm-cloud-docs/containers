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


# Asignación de acceso de usuario a clústeres
{: #users}

Puede otorgar acceso a un clúster para a otros usuarios de la organización para garantizar que solo los usuarios autorizados puedan trabajar con el clúster y desplegar apps en el mismo.
{:shortdesc}




## Gestión de acceso a clústeres
{: #managing}

Cada usuario que trabaje con {{site.data.keyword.containershort_notm}} debe tener asignada una combinación de roles de usuario específicos del servicio que determinan las acciones que el usuario puede realizar.
{:shortdesc}

<dl>
<dt>Políticas de acceso de {{site.data.keyword.containershort_notm}}</dt>
<dd>En Identity and Access Management, las políticas de acceso a {{site.data.keyword.containershort_notm}} determinan las acciones de gestión de clúster que puede llevar a cabo en un clúster, como por ejemplo crear o eliminar clústeres y añadir o eliminar nodos trabajadores adicionales. Estas políticas deben establecerse en conjunto con las políticas de infraestructura.</dd>
<dt>Políticas de acceso a infraestructura</dt>
<dd>En Identity and Access Management, las políticas de acceso a infraestructura permiten realizar las acciones solicitadas desde la CLI o la interfaz de usuario de {{site.data.keyword.containershort_notm}} en la infraestructura de IBM Cloud (SoftLayer). Estas políticas deben establecerse en conjunto con las políticas de acceso a {{site.data.keyword.containershort_notm}}. [Más información sobre los roles de infraestructura disponibles](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Grupos de recursos</dt>
<dd>Un grupo de recursos es una forma de organizar servicios de {{site.data.keyword.Bluemix_notm}} en agrupaciones de modo que se pueda asignar rápidamente el acceso a más de un recurso a usuarios a la vez. [Aprenda cómo gestionar usuarios utilizando grupos de recursos](/docs/admin/resourcegroups.html#rgs).</dd>
<dt>Roles de Cloud Foundry</dt>
<dd>En Identity and Access Management, cada usuario debe tener asignado un rol de usuario de Cloud Foundry. Este rol determina las acciones que el usuario puede llevar a cabo en la cuenta de {{site.data.keyword.Bluemix_notm}}, como por ejemplo invitar a otros usuarios o ver el uso de la cuota. [Más información sobre los roles de Cloud Foundry disponibles](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Roles de RBAC de Kubernetes</dt>
<dd>A cada usuario al que se asigne una política de acceso de {{site.data.keyword.containershort_notm}} se le asigna automáticamente un rol de RBAC de Kubernetes. En Kubernetes, los roles de RBAC determinan las acciones que puede realizar sobre los recursos de Kubernetes dentro del clúster. Los roles de RBAC se configuran solo para el espacio de nombres predeterminado. El administrador del clúster puede añadir roles de RBAC para otros espacios de nombres del clúster. Consulte [Utilización de la autorización RBAC ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) en la documentación de Kubernetes para obtener más información.</dd>
</dl>

<br />


## Permisos y políticas de acceso
{: #access_policies}

Revise las políticas de acceso y los permisos que puede otorgar a los usuarios de la cuenta de {{site.data.keyword.Bluemix_notm}}. El rol de operador y el de editor tienen permisos separados. Si desea que un usuario, por ejemplo, añada nodos de trabajador y servicios de enlace, debe asignar al usuario tanto el rol de operador como el de editor.

|Política de acceso de {{site.data.keyword.containershort_notm}}|Permisos de gestión de clústeres|Permisos de recursos de Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrador|Este rol hereda los permisos de los roles Editor, Operador y Visor para todos los clústeres de esta cuenta. <br/><br/>Cuando se establece para todas las instancias de servicio actuales:<ul><li>Crear un clúster lite o estándar</li><li>Establezca las credenciales para una cuenta de {{site.data.keyword.Bluemix_notm}} para acceder al portafolio de la infraestructura de IBM Cloud (SoftLayer)</li><li>Eliminar un clúster</li><li>Asignar y cambiar políticas de acceso de {{site.data.keyword.containershort_notm}} para otros usuarios existentes en esta cuenta.</li></ul><p>Cuando se establece para un ID de clúster específico:<ul><li>Eliminar un clúster específico</li></ul></p>Política de acceso a infraestructura correspondiente: Superusuario<br/><br/><b>Nota</b>: para crear recursos como máquinas, VLAN y subredes, los usuarios necesitan el rol de infraestructura **Superusuario**.|<ul><li>Rol de RBAC: cluster-admin</li><li>Acceso de lectura/escritura a los recursos en cada espacio de nombres</li><li>Crear roles dentro de un espacio de nombres</li><li>Acceso al panel de control de Kubernetes</li><li>Crear un recurso Ingress que ponga las apps a disponibilidad pública</li></ul>|
|Operador|<ul><li>Añadir nodos trabajadores adicionales a un clúster</li><li>Eliminar nodos trabajadores de un clúster</li><li>Rearrancar un nodo trabajador</li><li>Volver a cargar un nodo trabajador</li><li>Añadir una subred a un clúster</li></ul><p>Política de acceso a infraestructura correspondiente: Usuario básico</p>|<ul><li>Rol de RBAC: administrador</li><li>Acceso de lectura/escritura a recursos dentro del espacio de nombres predeterminado pero no para el espacio de nombres en sí</li><li>Crear roles dentro de un espacio de nombres</li></ul>|
|Editor <br/><br/><b>Consejo</b>: utilice este rol para los desarrolladores de apps.|<ul><li>Enlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.</li><li>Desenlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.</li><li>Crear un webhook.</li></ul><p>Política de acceso a infraestructura correspondiente: Usuario básico|<ul><li>Rol de RBAC: editar</li><li>Acceso de lectura/escritura a los recursos internos del espacio de nombres predeterminado</li></ul></p>|
|Visor|<ul><li>Listar un clúster</li><li>Ver los detalles de un clúster</li></ul><p>Política de acceso a infraestructura correspondiente: Solo visualización</p>|<ul><li>Rol de RBAC: ver</li><li>Acceso de lectura a los recursos internos del espacio de nombres predeterminado</li><li>Sin acceso de lectura a los secretos de Kubernetes</li></ul>|

|Política de acceso de Cloud Foundry|Permisos de gestión de cuentas|
|-------------|------------------------------|
|Rol de la organización: Gestor|<ul><li>Añadir usuarios adicionales a una cuenta de {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Rol del espacio: Desarrollador|<ul><li>Crear instancias de servicio de {{site.data.keyword.Bluemix_notm}}</li><li>Vincular instancias de servicio de {{site.data.keyword.Bluemix_notm}} a clústeres</li></ul>| 

<br />


## Adición de usuarios a una cuenta de {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Puede añadir usuarios adicionales a una cuenta de {{site.data.keyword.Bluemix_notm}} para otorgarles acceso a sus clústeres.

Antes de empezar, verifique que se le haya asignado el rol de Gestor de Cloud Foundry para una cuenta de {{site.data.keyword.Bluemix_notm}}.

1.  [Añada el usuario a la cuenta](../iam/iamuserinv.html#iamuserinv).
2.  En la sección **Acceso**, expanda **Servicios**.
3.  Asigne un rol de acceso de {{site.data.keyword.containershort_notm}}. Desde la lista desplegable **Asignar acceso a**, decida si desea conceder acceso solo a su cuenta de {{site.data.keyword.containershort_notm}} (**Recurso**) o a una colección de varios recursos dentro de la cuenta (**Grupo de recursos**).
  -  Para **Recurso**:
      1. En la lista desplegable **Servicios**, seleccione **{{site.data.keyword.containershort_notm}}**.
      2. En la lista desplegable **Región**, seleccione la zona a la que va a invitar al usuario.
      3. En la lista desplegable **Instancia de servicio**, seleccione el clúster al que va a invitar al usuario. Para encontrar el ID de un clúster específico, ejecute ` bx cs clusters`.
      4. En la sección **Seleccionar roles**, seleccione un rol. Para ver una lista de las acciones admitidas por rol, consulte [Permisos y políticas de acceso](#access_policies).
  - Para **Grupo de recursos**:
      1. Desde la lista desplegable **Grupo de recursos**, seleccione el grupo de recursos, seleccione el grupo de recursos que incluya permisos para el recurso {{site.data.keyword.containershort_notm}} de la cuenta.
      2. Desde la lista desplegable **Asignar acceso a un grupo de recursos**, seleccione un rol. Para ver una lista de las acciones admitidas por rol, consulte [Permisos y políticas de acceso](#access_policies).
4. [Opcional: asigne un rol de infraestructura](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Opcional: asigne un rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. Pulse **Invitar a usuarios**.

<br />


## Personalización de permisos de infraestructura para un usuario
{: #infra_access}

Cuando se establecen las políticas de infraestructura en Identity and Access Management, se otorgan permisos a un usuario asociados con un rol. Para personalizar esos permisos, debe iniciar sesión en la infraestructura de IBM Cloud (SoftLayer) y ajustar los permisos allí.
{: #view_access}

Por ejemplo, los usuarios básicos pueden reiniciar un nodo de trabajador, pero no pueden recargarlo. Sin dar a esa persona permisos de superusuario, puede ajustar los permisos de la infraestructura de IBM Cloud (SoftLayer) y añadir el permiso para ejecutar un mandato de recarga.

1.  Inicie sesión en la cuenta de infraestructura de IBM Cloud (SoftLayer).
2.  Seleccione un perfil de usuario que desee actualizar.
3.  En **Permisos de portal**, personalice el acceso del usuario. Por ejemplo, para añadir un permiso de recarga, en el separador **Dispositivos**, seleccione **Emitir recargas de SO e iniciar el kernel de rescate**.
9.  Guarde los cambios.
