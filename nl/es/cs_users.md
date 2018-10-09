---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Asignación de acceso al clúster
{: #users}

Como administrador del clúster, puede definir políticas de acceso para el clúster de Kubernetes para crear distintos niveles de acceso para distintos usuarios. Por ejemplo, puede autorizar a determinados usuarios a trabajar con recursos del clúster mientras que a otros sólo desplegar contenedores.
{: shortdesc}


## Visión general de los permisos y las políticas de acceso
{: #access_policies}

<dl>
  <dt>¿Tengo que definir políticas de acceso?</dt>
    <dd>Debe definir políticas de acceso para cada usuario que trabaje con {{site.data.keyword.containerlong_notm}}. El ámbito de una política de acceso se basa en un rol o roles definidos para los usuarios que determinan las acciones que pueden realizar. Algunas políticas son predefinidas, otras se pueden personalizar. La misma política se aplica independientemente de si el usuario realiza una solicitud desde la GUI de {{site.data.keyword.containerlong_notm}} o mediante la CLI, incluso cuando las acciones se completan en la infraestructura de IBM Cloud (SoftLayer).</dd>

  <dt>¿Cuáles son los tipos de permisos?</dt>
    <dd><p><strong>Plataforma</strong>: {{site.data.keyword.containerlong_notm}} está configurado para utilizar los roles
de la plataforma {{site.data.keyword.Bluemix_notm}} para determinar las acciones que las personas pueden realizar en un clúster. Los permisos de los roles se agregan entre sí, lo que significa que el rol de `Editor` tiene los mismos permisos que el rol de `Visor`, y además se le otorgan permisos para editar. Puede establecer estas políticas por región. Estas políticas deben establecerse junto con las políticas de la infraestructura y deben tener los correspondientes roles de RBAC que se asignan automáticamente al espacio de nombres predeterminado. Ejemplos de acciones: crear o eliminar clústeres o añadir nodos trabajadores adicionales.</p> <p><strong>Infraestructura</strong>: Puede determinar los niveles de acceso para su infraestructura como, por ejemplo, máquinas de nodo, red o recursos de almacenamiento de clúster. Debe establecer este tipo de política junto con las políticas de acceso de la plataforma {{site.data.keyword.containerlong_notm}}. Para obtener más información sobre los roles disponibles, consulte [permisos de infraestructura](/docs/iam/infrastructureaccess.html#infrapermission). Además de otorgar los roles de infraestructura específicos, también debe otorgar acceso a los usuarios a los dispositivos que funcionan con la infraestructura. Para iniciar la asignación de roles, siga los pasos en [Personalización de permisos de infraestructura para un usuario](#infra_access). <strong>Nota:</strong> asegúrese de que su cuenta de {{site.data.keyword.Bluemix_notm}} está [configurada con un acceso al portafolio (SoftLayer) de la infraestructura de IBM Cloud](cs_troubleshoot_clusters.html#cs_credentials) de forma que los usuarios autorizados puedan realizar acciones en la cuenta (SoftLayer) de la infraestructura de IBM Cloud con base a los permisos asignados.</p> <p><strong>RBAC</strong>: el control de acceso basado en roles (RBAC) es una forma de proteger los recursos que están dentro del clúster y decidir qué usuarios realizan cada una de las acciones de Kubernetes. Cada usuario asignado a la política de acceso de la plataforma, se le asigna también de forma automática un rol de Kubernetes. En Kubernetes, el [Role Based Access Control (RBAC) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) determina las acciones que el usuario puede realizar en los recursos dentro de un clúster. <strong>Nota</strong>: los roles de RBAC se establecen automáticamente junto con el rol de plataforma para el espacio de nombres predeterminado. Como administrador del clúster, puede [actualizar o asignar roles](#rbac) para otros espacios de nombres.</p> <p><strong>Cloud Foundry</strong>: no es posible gestionar todos los servicios con Cloud IAM. Si está utilizando uno de estos servicios, puede continuar utilizando los [roles de usuario de Cloud Foundry](/docs/iam/cfaccess.html#cfaccess) para controlar el acceso a los servicios. Las acciones de ejemplo enlazan un servicio o crean una nueva instancia de servicio.</p></dd>

  <dt>¿Cómo puedo definir los permisos?</dt>
    <dd><p>Cuando establece permisos de plataforma, puede asignar acceso a un usuario específico, a un grupo de usuarios o al grupo de recursos predeterminado. Cuando define los permisos de la plataforma, los roles de RBAC se configuran automáticamente para el espacio de nombres predeterminado y se crea un RoleBinding.</p>
    <p><strong>Usuarios</strong>: es posible que un usuario específico necesite más o menos permisos que el resto de su equipo. Puede personalizar los permisos de forma individual de forma que cada persona tenga la cantidad de permisos adecuada que necesita para realizar sus tareas.</p>
    <p><strong>Grupos de acceso</strong>: puede crear grupos de usuarios y luego asignar permisos a un grupo específico. Por ejemplo, podría agrupar todos los jefes de equipo y asignar a dicho grupo acceso de administrador. Paralelamente, el grupo de desarrolladores podría tener solo permiso de escritura.</p>
    <p><strong>Grupos de recursos</strong>: con IAM, puede crear políticas de acceso para un grupo de recursos y otorgar a los usuarios acceso a este grupo. Estos recursos pueden formar parte de un servicio de un servicio de {{site.data.keyword.Bluemix_notm}} o también puede agrupar recursos entre instancias de servicio, como un clúster de {{site.data.keyword.containerlong_notm}} y una app CF.</p> <p>**Importante**: {{site.data.keyword.containerlong_notm}} solo da soporte al grupo de recursos <code>default</code>. Todos los recursos relacionados con el clúster están disponibles de forma automática en el grupo de recursos <code>default</code>. Si tiene otros servicios en la cuenta de {{site.data.keyword.Bluemix_notm}} que desea utilizar con el clúster, estos servicios también deben estar en el grupo de recursos <code>default</code>.</p></dd>
</dl>


Si desea más información o resolver dudas, consulte esta guía de aprendizaje sobre las [prácticas recomendadas para organizar usuarios, equipos y aplicaciones](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Acceso al portafolio de la infraestructura de IBM Cloud (SoftLayer)
{: #api_key}

<dl>
  <dt>¿Por qué necesito acceso al portafolio de la infraestructura de IBM Cloud (SoftLayer)?</dt>
    <dd>Para suministrar correctamente clústeres en la cuenta y trabajar con ellos, debe asegurarse de que la cuenta esté correctamente configurada para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer). En función de la configuración de la cuenta, puede utilizar la clave de API IAM o las credenciales de infraestructura que establece manualmente mediante el mandato `ibmcloud ks credentials-set`.</dd>

  <dt>¿Cómo funciona la clave de API de IAM con {{site.data.keyword.containerlong_notm}}?</dt>
    <dd><p>La clave de API de Identity and Access Management (IAM) se establece automáticamente para una región cuando se realiza la primera acción que requiere la política de acceso de administrador de {{site.data.keyword.containerlong_notm}}. Por ejemplo, uno de los usuarios administrativos crea el primer clúster en la región <code>us-south</code>. De ese modo, la clave de API IAM para este usuario se almacena en la cuenta para esta región. La clave de API se utiliza para pedir infraestructura de IBM Cloud (SoftLayer), como nodos trabajadores nuevos o VLAN.</p> <p>Cuando un usuario distinto realiza una acción en esta región que requiere interacción con el portafolio de infraestructura de IBM Cloud (SoftLayer), como crear un nuevo clúster o recargar un nodo trabajador, la clave de API almacenada se utiliza para determinar si existen suficientes permisos para realizar esa acción. Para asegurarse de que las acciones relacionadas con la infraestructura en el clúster se realicen correctamente, puede asignar a los usuarios administradores de {{site.data.keyword.containerlong_notm}} la política de acceso a infraestructura <strong>Superusuario</strong>.</p> <p>Puede encontrar el propietario de clave de API actual ejecutando [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Si necesita actualizar la clave de API que hay almacenada para una región, puede hacerlo mediante la ejecución del mandato [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Este mandato requiere la política de acceso de administrador de {{site.data.keyword.containerlong_notm}} y almacena la clave de API del usuario que ejecuta este mandato en la cuenta. La clave de API que se almacena para la región no puede utilizarse si las credenciales de infraestructura de IBM Cloud (SoftLayer) se han establecido manualmente mediante el mandato <code>ibmcloud ks credentials-set</code>.</p> <p><strong>Nota:</strong> asegúrese de que desea restablecer la clave y de que comprende el impacto en la app. La clave se utiliza en varios lugares y puede provocar cambios de última hora si se modifican innecesariamente.</p></dd>

  <dt>¿Qué hace el mandato <code>ibmcloud ks credentials-set</code>?</dt>
    <dd><p>Si tiene una cuenta de pago según uso de {{site.data.keyword.Bluemix_notm}}, tiene acceso al portafolio de infraestructura de IBM Cloud (de SoftLayer) de forma predeterminada. Sin embargo, es posible que desee utilizar otra cuenta de infraestructura de IBM Cloud (SoftLayer) que ya tenga para solicitar infraestructura para clústeres dentro de una región. Puede enlazar esta cuenta de infraestructura a la cuenta de {{site.data.keyword.Bluemix_notm}} mediante el mandato [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set).</p> <p>Para eliminar las credenciales de infraestructura de IBM Cloud (SoftLayer) establecidas manualmente, puede utilizar el mandato [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Una vez eliminadas las credenciales, la clave de API IAM se utiliza para pedir infraestructura.</p></dd>

  <dt>¿Hay una diferencia entre las credenciales de la infraestructura y la clave de API?</dt>
    <dd>Tanto la clave de API como el mandato <code>ibmcloud ks credentials-set</code> cumplen la misma tarea. Si establece manualmente las credenciales con el mandato <code>ibmcloud ks credentials-set</code>, las credenciales definidas prevalecen sobre cualquier acceso que haya otorgado la clave de API. Sin embargo, si el usuario cuyas credenciales se almacenan no tiene los permisos necesarios para solicitar la infraestructura, entonces las acciones relacionadas con la infraestructura, como por ejemplo la creación de un clúster o la recarga de un nodo trabajador, pueden fallar.</dd>
    
  <dt>¿Cómo puedo saber si las credenciales de mi cuenta de infraestructura están establecidas para utilizar una cuenta distinta?</dt>
    <dd>Abra la [GUI de {{site.data.keyword.containerlong_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/containers-kubernetes/clusters) y seleccione el clúster. En el separador **Visión general**, busque el campo **Usuario de infraestructura**. Si ve este campo, no utilizará las credenciales de infraestructura predeterminadas que vienen con su cuenta de Pago según uso en esta región. En su lugar, se establece que la región utilice otras credenciales de cuenta de infraestructura distintas.</dd>

  <dt>¿Hay alguna forma de facilitar la asignación de permisos de infraestructura de IBM Cloud (SoftLayer)?</dt>
    <dd><p>Los usuarios normalmente no necesitan permisos específicos de infraestructura de IBM Cloud (SoftLayer). En su lugar, configure la clave de API con los permisos de infraestructura correctos y utilice la clave de API en cada región en la que desee clústeres. La clave de API puede pertenecer al propietario de cuenta, a un ID funcional o a un usuario, en función de lo que sea más sencillo gestionar y auditar.</p> <p>Si desea crear un clúster en una nueva región, asegúrese de que el primer clúster lo crea el propietario de la clave de API que ha configurado con las credenciales de infraestructura adecuadas. Después, puede invitar a personas individuales, grupos de IAM o usuarios de cuenta de servicio a dicha región. Los usuarios de la cuenta comparten las credenciales de clave de API para realizar acciones de infraestructura como, por ejemplo, añadir nodos trabajadores. Para controlar las acciones de infraestructura que puede llevar a cabo un usuario, asigne el rol de {{site.data.keyword.containerlong_notm}} adecuado en IAM.</p><p>Por ejemplo, un usuario con un rol IAM `Visor` no tiene autorización para añadir un nodo trabajador. Por lo tanto, la acción `worker-add` falla, aunque la clave de API tenga los permisos de infraestructura correctos. Si cambia el rol de usuario a `Operador` en IAM, el usuario tiene autorización para añadir un nodo trabajador. La acción `worker-add` se ejecuta correctamente porque el rol de usuario está autorizado y la clave de API se ha establecido correctamente. No es necesario que edite los permisos de infraestructura de IBM Cloud (SoftLayer) del usuario.</p> <p>Para obtener más información sobre el establecimiento de permisos, consulte [Personalización de permisos de infraestructura para un usuario](#infra_access)</p></dd>
</dl>


<br />



## Visión general de las relaciones entre los roles
{: #user-roles}

Para poder entender qué rol puede realizar cada acción, es importante comprender cómo se relacionan los roles entre sí.
{: shortdesc}

En la imagen siguiente se muestran los roles que puede necesitar cada tipo de persona de la organización. Sin embargo, es diferente para cada organización. Es posible que observe que algunos usuarios requieren permisos personalizados para la infraestructura. Asegúrese de leer [Acceso a la cartera de infraestructura de IBM Cloud (SoftLayer)](#api_key) para obtener información sobre qué permisos de infraestructura de IBM Cloud (SoftLayer) son y quién necesita qué permisos. 

![{{site.data.keyword.containerlong_notm}} - Roles de acceso](/images/user-policies.png)

Figura. Permisos de acceso a {{site.data.keyword.containerlong_notm}} por tipo de rol

<br />



## Asignación de roles con la GUI
{: #add_users}

Puede añadir usuarios a una cuenta de {{site.data.keyword.Bluemix_notm}} para otorgarles acceso a sus clústeres con la GUI.
{: shortdesc}

**Antes de empezar**

- Verifique que el usuario se ha añadido a la cuenta. Si no es así, [añádalo](../iam/iamuserinv.html#iamuserinv).
- Verifique que tiene asignado el [rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf) de `Gestor` sobre la cuenta de {{site.data.keyword.Bluemix_notm}} en la que está trabajando.

**Para asignar acceso a un usuario**

1. Vaya a **Gestionar > Usuarios**. Se muestra una lista de los usuarios con acceso a la cuenta.

2. Pulse el nombre del usuario cuyos permisos desea establecer. Si el usuario no se muestra, pulse **Invitar a usuarios** para añadirlo a la cuenta.

3. Asigne una política.
  * Para un grupo de recursos:
    1. Seleccione el grupo de recursos **default**. Se puede configurar el acceso a {{site.data.keyword.containerlong_notm}} solo para el grupo de recursos predeterminado.
  * Para un recurso específico:
    1. En la lista **Servicios**, seleccione
**{{site.data.keyword.containerlong_notm}}**.
    2. En la lista **Región**, seleccione una región.
    3. En la lista **Instancia de servicio**, seleccione el clúster al que va a invitar al usuario. Para encontrar el ID de un clúster específico, ejecute `ibmcloud ks clusters`.

4. En la sección **Seleccionar roles**, seleccione un rol. 

5. Pulse **Asignar**.

6. Asigne un [rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf).

7. Opcional: asigne un [rol de infraestructura](/docs/iam/infrastructureaccess.html#infrapermission).

</br>

**Para asignar acceso a un grupo**

1. Vaya a **Gestionar > Grupos de acceso**.

2. Cree un grupo de acceso.
  1. Pulse **Crear** y asigne al grupo un **Nombre** y una **Descripción**. Pulse **Crear**.
  2. Pulse **Añadir usuarios** para añadir personas a su grupo de acceso. Se muestra una lista de los usuarios que tienen acceso a su cuenta.
  3. Seleccione el recuadro que hay junto a los usuarios que desea añadir al grupo. Aparece un recuadro de diálogo.
  4. Pulse **Añadir al grupo**.

3. Para asignar el acceso a un servicio específico, añada un ID de servicio.
  1. Pulse **Añadir ID de servicio**.
  2. Seleccione el recuadro que hay junto a los usuarios que desea añadir al grupo. Aparece una ventana emergente.
  3. Pulse **Añadir al grupo**.

4. Asigne políticas de acceso. No se olvide comprobar las personas que añade a su grupo. A todos los miembros del grupo se les proporciona el mismo nivel de acceso.
    * Para un grupo de recursos:
        1. Seleccione el grupo de recursos **default**. Se puede configurar el acceso a {{site.data.keyword.containerlong_notm}} solo para el grupo de recursos predeterminado.
    * Para un recurso específico:
        1. En la lista **Servicios**, seleccione
**{{site.data.keyword.containerlong_notm}}**.
        2. En la lista **Región**, seleccione una región.
        3. En la lista **Instancia de servicio**, seleccione el clúster al que va a invitar al usuario. Para encontrar el ID de un clúster específico, ejecute `ibmcloud ks clusters`.

5. En la sección **Seleccionar roles**, seleccione un rol. 

6. Pulse **Asignar**.

7. Asigne un [rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf).

8. Opcional: asigne un [rol de infraestructura](/docs/iam/infrastructureaccess.html#infrapermission).

<br />



## Asignación de roles con la CLI
{: #add_users_cli}

Puede añadir usuarios a una cuenta de {{site.data.keyword.Bluemix_notm}} para otorgarles acceso a sus clústeres con la CLI.
{: shortdesc}

**Antes de empezar**

Verifique que tiene asignado el [rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf) de `Gestor` sobre la cuenta de {{site.data.keyword.Bluemix_notm}} en la que está trabajando.

**Para asignar acceso a un usuario específico**

1. Invite al usuario a su cuenta.
  ```
  ibmcloud account user-invite <user@email.com>
  ```
  {: pre}
2. Cree una política de acceso de IAM para establecer permisos para {{site.data.keyword.containerlong_notm}}. Puede elegir entre Visor, Editor, Operador y Administrador para el rol.
  ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

**Para asignar acceso a un grupo**

1. Si el usuario todavía no forma parte de su cuenta, invítelo.
  ```
  ibmcloud account user-invite <user_email>
  ```
  {: pre}

2. Cree un grupo.
  ```
  ibmcloud iam access-group-create <team_name>
  ```
  {: pre}

3. Añada el usuario al grupo.
  ```
  ibmcloud iam access-group-user-add <team_name> <user_email>
  ```
  {: pre}

4. Añada el usuario al grupo. Puede elegir entre Visor, Editor, Operador y Administrador para el rol.
  ```
  ibmcloud iam access-group-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

5. Actualice la configuración del clúster para generar un RoleBinding.
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  RoleBinding:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <binding>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <role>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <group_name>
    namespace: default
  ```
  {: screen}

Las instrucciones anteriores muestran cómo dar acceso a un grupo de usuarios a todos los recursos de {{site.data.keyword.containerlong_notm}}. Como administrador, también puede limitar el acceso al servicio en la región o en el nivel de instancia de clúster.
{: tip}

<br />


## Autorización de usuarios con enlaces de rol de RBAC
{: #role-binding}

Cada clúster se configura con roles de RBAC predefinidos que se configuran para el espacio de nombres predeterminado del clúster. Puede copiar los roles de RBAC del espacio de nombres predeterminado a otros espacios de nombres del clúster para aplicar el mismo nivel de acceso de usuario.

**¿Qué es un RoleBinding de RBAC?**

Un enlace de rol es una política de acceso específica de recurso de Kubernetes. Puede utilizar los enlaces de rol para establecer políticas específicas de espacios de nombres, pods u otros recursos dentro del clúster. {{site.data.keyword.containerlong_notm}} proporciona roles de RBAC predefinidos que corresponden a los roles de la plataforma en IAM. Cuando se asigna un rol de plataforma de IAM a un usuario, se crea automáticamente un enlace de rol de RBAC para el usuario en el espacio de nombres predeterminado del clúster.

**¿Qué es un enlace de rol de clúster RBAC?**

Aunque un enlace de rol de RBAC es específico de un recurso, como por ejemplo un espacio de nombres o un pod, se puede utilizar un enlace de rol de clúster RBAC para establecer permisos a nivel de clúster, lo que incluye todos los espacios de nombres. Los enlaces de rol de clúster se crean automáticamente para el espacio de nombres predeterminado cuando se establecen los roles de la plataforma. Puede copiar el enlace de rol a otros espacios de nombres.


<table>
  <tr>
    <th>Rol de plataforma</th>
    <th>Rol de RBAC</th>
    <th>Enlace de rol</th>
  </tr>
  <tr>
    <td>Visor</td>
    <td>Ver</td>
    <td><code>ibm-view</code></td>
  </tr>
  <tr>
    <td>Editor</td>
    <td>Editar</td>
    <td><code>ibm-edit</code></td>
  </tr>
  <tr>
    <td>Operador</td>
    <td>Administrar</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrador</td>
    <td>Administrador de clúster</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

**¿Hay algún requisito específico al trabajar con RoleBindings?**

Para poder trabajar con diagramas de IBM Helm, debe instalar Tiller en el espacio de nombres `kube-system`. Para poder instalar Tiller, debe tener el [rol `administrador de clúster` ](cs_users.html#access_policies)
en el espacio de nombres `kube-system`. Para otros diagramas de Helm, puede elegir otro espacio de nombres. Sin embargo, cuando ejecuta un mandato `helm`, debe utilizar el distintivo `tiller-namespace <namespace>` para apuntar al espacio de nombres en el que Tiller está instalado.


### Copia de un RoleBinding de RBAC

Cuando configura las políticas de la plataforma, se genera un enlace de rol de clúster automáticamente para el espacio de nombres predeterminado. Puede copiar el enlace en otros espacios de nombres actualizando el enlace con el espacio de nombres para el que sedes definir la política. Por ejemplo, supongamos que tiene un grupo de desarrolladores denominado `team-a` y tienen acceso para `ver` en el servicio, pero necesitan acceso para `editar` en el espacio de nombres `teama`. Puede editar el RoleBinding generado automáticamente para proporcionarles el acceso que necesitan a nivel de recurso.

1. Cree un enlace de rol de RBAC para el espacio de nombres predeterminado [asignando acceso con un rol de plataforma](#add_users_cli).
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}
  Salida de ejemplo:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. Copie esa configuración en otro espacio de nombres.
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role> --namespace <namespace>
  ```
  {: pre}
  En el caso de ejemplo anterior, he realizado un cambio en la configuración de otro espacio de nombres. La configuración actualizada se parecería a la siguiente:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### Creación de roles de RBAC de Kubernetes personalizados
{: #rbac}

Para autorizar otros roles de Kubernetes que difieren de la política de acceso de plataforma correspondiente, puede personalizar los roles de RBAC y luego asignar los roles a usuarios individuales o grupos de usuarios.
{: shortdesc}

¿Necesita que las políticas de acceso de clúster sean más granulares de lo que permite una política de IAM? No hay problema. Puede asignar políticas de acceso para recursos específicos de Kubernetes a usuarios, grupos de usuarios (en clústeres que ejecutan Kubernetes v1.11 o posterior) o cuentas de servicio. Puede crear un rol y luego enlazar el rol a usuarios específicos o a un grupo. Para obtener información, consulte [Utilización de la autorización RBAC ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) en la documentación de Kubernetes.

Cuando se crea un enlace para un grupo, este afecta a cualquier usuario que se añada o se elimine de dicho grupo. Si añade un usuario al grupo, también recibe el acceso adicional. Si se elimina, su acceso se revoca.
{: tip}

Si desea asignar acceso a un servicio, como por ejemplo una cadena de herramientas de entrega continua, puede utilizar [cuentas del servicio Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

**Antes de empezar**

- Defina el clúster como destino de la [CLI de Kubernetes](cs_cli_install.html#cs_cli_configure).
- Asegúrese de que el usuario o el grupo tiene un acceso mínimo de `Visor` en el nivel de servicio.


**Para personalizar roles de RBAC**

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
        <caption>Visión general de los componentes de YAML</caption>
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
              <td><ul><li>Especifique los grupos de API de Kubernetes con los que desea que puedan interactuar los usuarios, como `"apps"`, `"batch"` o `"extensions"`. </li><li>Para acceder al grupo de API principal en la vía de acceso de REST `api/v1`, deje el grupo en blanco: `[""]`.</li><li>Para obtener más información, consulte [grupos de API ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) en la documentación de Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>Especifique los recursos de Kubernetes a los que desea otorgar acceso, como `"daemonsets"`, `"deployments"`, `"events"` o `"ingresses"`.</li><li>Si especifica `"nodes"`, entonces el tipo de rol debe ser `ClusterRole`.</li><li>Para obtener una lista de recursos, consulte la tabla de [tipos de recurso ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) en la hoja de apuntes de Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>Especifique los tipos de acciones que desea que los usuarios puedan hacer, como `"get"`, `"list"`, `"describe"`, `"create"` o `"delete"`. </li><li>Para ver una lista completa de verbos, consulte la [documentación de `kubectl`![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/kubectl/overview/).</li></ul></td>
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
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Visión general de los componentes de YAML</caption>
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
              <td>Especifique el tipo como una de las opciones siguientes:
              <ul><li>`User`: enlace el rol de RBAC a un usuario individual de la cuenta.</li>
              <li>`Group`: para clústeres que ejecutan Kubernetes 1.11 o posterior, enlace el rol de RBAC a un [grupo de IAM](/docs/iam/groups.html#groups) en la cuenta.</li>
              <li>`ServiceAccount`: enlace el rol de RBAC a una cuenta de servicio en un espacio de nombres en el clúster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**Para `User`**: añada la dirección de correo electrónico del usuario individual al URL siguiente: `https://iam.ng.bluemix.net/kubernetes#`. Por ejemplo, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Para `Group`**: para clústeres que ejecutan Kubernetes 1.11 o posterior, especifique el nombre del [grupo de IAM](/docs/iam/groups.html#groups) en la cuenta.</li>
              <li>**Para `ServiceAccount`**: especifique el nombre de la cuenta de servicio.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>**Para `User` o `Group`**: utilice `rbac.authorization.k8s.io`.</li>
              <li>**Para `ServiceAccount`**: no incluya este campo.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/namespace</code></td>
              <td>**Solo para `ServiceAccount`**: especifique el nombre del espacio de nombres de Kubernetes en el que se despliega la cuenta de servicio.</td>
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
        kubectl apply -f filepath/my_role_binding.yaml
        ```
        {: pre}

    3.  Verifique que se ha creado el enlace.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Ahora que ha creado y enlazado un rol de RBAC de Kubernetes personalizado, siga con los usuarios. Pídales que prueben una acción que tengan permiso para realizar debido al rol, como suprimir un pod.


<br />



## Personalización de permisos de infraestructura para un usuario
{: #infra_access}

Cuando se establecen las políticas de infraestructura en Identity and Access Management, se otorgan permisos a un usuario que están asociados con un rol. Algunas políticas son predefinidas, otras se pueden personalizar. Para personalizar esos permisos, debe iniciar sesión en la infraestructura de IBM Cloud (SoftLayer) y ajustar los permisos allí.
{: #view_access}

Por ejemplo, los **Usuarios básicos** pueden rearrancar un nodo trabajador, pero no pueden recargarlo. Sin dar a esa persona permisos de **Superusuario**, puede ajustar los permisos de la infraestructura de IBM Cloud (SoftLayer) y añadir el permiso para ejecutar un mandato de recarga.

Si tiene clústeres multizona, el propietario de la cuenta de la infraestructura de IBM Cloud (SoftLayer) debe activar la expansión de VLAN de modo que los nodos de distintas zonas se puedan comunicar dentro del clúster. El propietario de la cuenta también puede asignar a un usuario al permiso **Red > Gestionar expansión de VLAN de red** para que el usuario pueda habilitar la expansión de VLAN. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}


1.  Inicie la sesión en [cuenta de {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) y, a continuación, desde el menú, seleccione **Infraestructura**.

2.  Vaya a **Cuenta** > **Usuarios** > **Lista de usuarios**.

3.  Para modificar permisos, seleccione el nombre de un perfil de usuario o la columna **Acceso de dispositivos**.

4.  En el separador **Permisos de portal**, personalice el acceso de usuario. Los permisos que los usuarios necesitan dependen de los recursos de infraestructura que necesitan utilizar:

    * Utilice la lista desplegable **Permisos rápidos** para asignar el rol **Superusuario**, que da al usuario todos los permisos.
    * Utilice la lista desplegable **Permisos rápidos** para asignar el rol **Usuario básico**, que da al usuario algunos permisos necesarios, pero no todos.
    * Si no desea otorgar todos los permisos con el rol **Superusuario** o necesita añadir más permisos que los del rol **Usuario básico**, consulte la tabla siguiente, que describe los permisos necesarios para realizar tareas comunes en {{site.data.keyword.containerlong_notm}}.

    <table summary="Permisos de infraestructura para casos de ejemplo comunes de {{site.data.keyword.containerlong_notm}}.">
     <caption>Permisos de infraestructura necesarios habitualmente para {{site.data.keyword.containerlong_notm}}</caption>
     <thead>
      <th>Tareas comunes en {{site.data.keyword.containerlong_notm}}</th>
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
         <td><strong>Red</strong>:<ul><li>Gestionar rutas de subredes de la red</li><li>Gestionar túneles de red IPSEC</li><li>Gestionar pasarelas de red</li><li>Administración de VPN</li></ul></td>
       </tr>
       <tr>
         <td><strong>Gestión de redes públicas</strong>:<ul><li>Configurar las redes públicas de Ingress y del equilibrador de carga para exponer apps.</li></ul></td>
         <td><strong>Dispositivos</strong>:<ul><li>Gestionar equilibradores de carga</li><li>Editar nombre de host/dominio</li><li>Gestionar control de puertos</li></ul>
         <strong>Red</strong>:<ul><li>Añadir sistema con puerto de red pública</li><li>Gestionar rutas de subredes de la red</li><li>Añadir direcciones IP</li></ul>
         <strong>Servicios</strong>:<ul><li>Gestionar DNS, DNS inverso y WHOIS</li><li>Ver certificados (SSL)</li><li>Gestionar certificados (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  Para guardar los cambios, pulse **Editar permisos del portal**.

6.  En el separador **Acceso de dispositivos**, seleccione los dispositivos a los que desea otorgar acceso.

    * En el desplegable de **Tipo de dispositivo**, puede otorgar acceso a **Todos los servidores virtuales**.
    * Para permitir a los usuarios acceder a nuevos dispositivos que se crean, seleccione **Otorgar acceso automáticamente cuando se añadan nuevos dispositivos**.
    * Para guardar los cambios, pulse **Actualizar acceso de dispositivos**.

¿Degradación de permisos? Para completar la acción pueden ser necesarios unos minutos.
{: tip}

<br />

