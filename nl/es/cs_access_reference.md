---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"


---

{:new_window: target="blank"}
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

# Permisos de acceso de usuario
{: #understanding}



Cuando [asigna permisos de clúster](cs_users.html), puede resultar difícil saber qué rol tiene que asignar a un usuario. Utilice las tablas de las secciones siguientes para determinar el nivel mínimo de permisos necesarios para realizar tareas comunes en {{site.data.keyword.containerlong}}.
{: shortdesc}

## {{site.data.keyword.Bluemix_notm}} Plataforma IAM y RBAC de Kubernetes
{: #platform}

{{site.data.keyword.containerlong_notm}} está configurado para que utilice roles de Identity and Access Management (IAM) de {{site.data.keyword.Bluemix_notm}}. Los roles de la plataforma {{site.data.keyword.Bluemix_notm}} IAM determinan las acciones que pueden realizar los usuarios sobre un clúster. A cada usuario que tiene asignado un rol de plataforma también se le asigna automáticamente un rol de control de acceso basado en rol (RBAC) de Kubernetes correspondiente en el espacio de nombres predeterminado. Además, los roles de plataforma establecen automáticamente los permisos básicos de la infraestructura para los usuarios. Para definir políticas, consulte [Asignación de permisos de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform). Para obtener más información sobre los roles RBAC, consulte [Asignación de permisos RBAC](cs_users.html#role-binding).
{: shortdesc}

En la tabla siguiente se muestran los permisos de gestión de clúster otorgados por cada rol de la plataforma y los permisos de recursos de Kubernetes para los roles RBAC correspondientes.

<table summary="En la tabla se muestran los permisos de usuario para los roles de plataforma IAM y las políticas de RBAC correspondientes. Las filas se leen de izquierda a derecha, con el rol de plataforma IAM en la columna uno, el permiso de clúster en la columna dos y el rol RBAC correspondiente en la columna tres.">
<caption>Permisos de gestión de clúster por plataforma y rol RBAC</caption>
<thead>
    <th>Rol de plataforma</th>
    <th>Permisos de gestión de clústeres</th>
    <th>Rol de RBAC correspondiente y permisos de recursos</th>
</thead>
<tbody>
  <tr>
    <td>**Visor**</td>
    <td>
      Clúster:<ul>
        <li>Ver el nombre y la dirección de correo electrónico del propietario de la clave de API de {{site.data.keyword.Bluemix_notm}} IAM para un grupo de recursos y una región</li>
        <li>Si la cuenta de {{site.data.keyword.Bluemix_notm}} utiliza diferentes credenciales para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer), ver el nombre de usuario de infraestructura.</li>
        <li>Obtener una lista o ver detalles de clústeres, nodos trabajadores, agrupaciones de nodos trabajadores, servicios de un clúster y webhooks</li>
        <li>Ver el estado de expansión de VLAN para la cuenta de infraestructura</li>
        <li>Obtener una lista de las subredes de la cuenta de infraestructura</li>
        <li>Cuando se establece para un clúster: obtener una lista de las VLAN a las que está conectado el clúster en una zona</li>
        <li>Cuando se establece para todos los clústeres de la cuenta: obtener una lista de todas las VLAN disponibles en una zona</li></ul>
      Registro:<ul>
        <li>Ver el punto final de registro predeterminado para la región de destino</li>
        <li>Obtener una lista o ver detalles de las configuraciones de reenvío de registro y de filtrado</li>
        <li>Ver el estado de las actualizaciones automáticas del complemento Fluentd</li></ul>
      Ingress:<ul>
        <li>Obtener una lista o ver detalles de los ALB de un clúster</li>
        <li>Ver los tipos de ALB que reciben soporte en la región.</li></ul>
    </td>
    <td>El rol de clúster <code>view (ver)</code> se aplica mediante el enlace de rol <code>ibm-view</code> y proporciona los permisos siguientes en el espacio de nombres <code>default</code>:<ul>
      <li>Acceso de lectura a los recursos internos del espacio de nombres predeterminado</li>
      <li>Sin acceso de lectura a secretos de Kubernetes</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Editor** <br/><br/><strong>Sugerencia</strong>: utilice este rol para desarrolladores de apps y asigne el rol de **Desarrollador** de <a href="#cloud-foundry">Cloud Foundry</a>.</td>
    <td>Este rol tiene todos los permisos del rol de visor, más los siguientes:</br></br>
      Clúster:<ul>
        <li>Enlazar servicios de {{site.data.keyword.Bluemix_notm}} a un clúster y desenlazarlos del mismo</li></ul>
      Registro:<ul>
        <li>Crear, actualizar y suprimir weebhooks de auditoría del servidor de API</li>
        <li>Crear webhooks de clúster</li>
        <li>Crear y suprimir configuraciones de reenvío de registros para todos los tipos excepto `kube-audit`</li>
        <li>Actualizar y renovar configuraciones de reenvío de registros</li>
        <li>Crear, actualizar y suprimir configuraciones de filtrado de registros</li></ul>
      Ingress:<ul>
        <li>Habilitar o inhabilitar ALB</li></ul>
    </td>
    <td>El rol de clúster <code>edit (editar)</code> se aplica mediante el enlace de rol <code>ibm-edit</code> y proporciona los permisos siguientes en el espacio de nombres <code>default</code>:
      <ul><li>Acceso de lectura/escritura a los recursos internos del espacio de nombres predeterminado</li></ul></td>
  </tr>
  <tr>
    <td>**Operador**</td>
    <td>Este rol tiene todos los permisos del rol de visor, más los siguientes:</br></br>
      Clúster:<ul>
        <li>Actualizar un clúster</li>
        <li>Renovar el nodo maestro de Kubernetes</li>
        <li>Añadir y eliminar nodos trabajadores</li>
        <li>Reiniciar, volver a cargar y actualizar nodos trabajadores</li>
        <li>Crear y suprimir agrupaciones de nodos trabajadores</li>
        <li>Añadir y eliminar zonas de agrupaciones de nodos trabajadores</li>
        <li>Actualizar la configuración de red para una zona determinada en agrupaciones de nodos trabajadores</li>
        <li>Cambiar el tamaño y volver a equilibrar agrupaciones de nodos trabajadores</li>
        <li>Crear y añadir subredes a un clúster</li>
        <li>Añadir y eliminar subredes gestionadas por el usuario a y desde un clúster</li></ul>
    </td>
    <td>El rol de clúster <code>admin</code> se aplica mediante el enlace de rol de clúster <code>ibm-operate</code> y proporciona los permisos siguientes:<ul>
      <li>Acceso de lectura/escritura a los recursos de un espacio de nombres, pero no al propio espacio de nombres</li>
      <li>Crear roles RBAC dentro de un espacio de nombres</li></ul></td>
  </tr>
  <tr>
    <td>**Administrador**</td>
    <td>Este rol tiene todos los permisos de los roles Editor, Operador y Visor para todos los clústeres de esta cuenta, más los siguientes:</br></br>
      Clúster:<ul>
        <li>Crear clústeres gratuitos o estándares</li>
        <li>Suprimir clústeres</li>
        <li>Cifrar secretos de Kubernetes mediante {{site.data.keyword.keymanagementservicefull}}</li>
        <li>Definir la clave de API para la cuenta de {{site.data.keyword.Bluemix_notm}} para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer) enlazada</li>
        <li>Establecer, ver y eliminar credenciales de la infraestructura para la cuenta de {{site.data.keyword.Bluemix_notm}} para acceder a otro portafolio de infraestructura de IBM Cloud (SoftLayer)</li>
        <li>Asignar y cambiar roles de la plataforma {{site.data.keyword.Bluemix_notm}} IAM para otros usuarios existentes en la cuenta</li>
        <li>Cuando se establece para todas las instancias (clústeres) de {{site.data.keyword.containerlong_notm}} en todas las regiones: obtener una lista de todas las VLAN disponibles en la cuenta</ul>
      Registro:<ul>
        <li>Crear y actualizar configuraciones de reenvío de registros para el tipo `kube-audit`</li>
        <li>Recopilar una instantánea de registros del servidor de API en un grupo de {{site.data.keyword.cos_full_notm}}</li>
        <li>Habilitar e inhabilitar actualizaciones automáticas para el complemento de clúster Fluentd</li></ul>
      Ingress:<ul>
        <li>Obtener una lista o ver detalles de los ALB de un clúster</li>
        <li>Desplegar un certificado desde la instancia de {{site.data.keyword.cloudcerts_long_notm}} en un ALB</li>
        <li>Actualizar o eliminar secretos de ALB de un clúster</li></ul>
      <p class="note">Para crear recursos como máquinas, VLAN y subredes, los usuarios administradores necesitan el rol de la infraestructura **Superusuario**.</p>
    </td>
    <td>El rol de clúster <code>cluster-admin</code> se aplica mediante el enlace de rol de clúster <code>ibm-admin</code> y proporciona los permisos siguientes:
      <ul><li>Acceso de lectura/escritura a los recursos de cada espacio de nombres</li>
      <li>Crear roles RBAC dentro de un espacio de nombres</li>
      <li>Acceder al panel de control de Kubernetes</li>
      <li>Crear un recurso Ingress que ponga las apps a disponibilidad pública</li></ul>
    </td>
  </tr>
  </tbody>
</table>



## Roles de Cloud Foundry
{: #cloud-foundry}

Los roles de Cloud Foundry otorgan acceso a las organizaciones y espacios dentro de la cuenta. Para ver la lista de servicios basados en Cloud Foundry de {{site.data.keyword.Bluemix_notm}}, ejecute `ibmcloud service list`. Para obtener más información, consulte todos los [roles de espacio y organización](/docs/iam/cfaccess.html) disponibles o los pasos para [gestionar el acceso a Cloud Foundry](/docs/iam/mngcf.html) en la documentación de {{site.data.keyword.Bluemix_notm}} IAM.
{: shortdesc}

En la tabla siguiente se muestran los roles de Cloud Foundry necesarios para los permisos de acción de clúster.

<table summary="En la tabla se muestran los permisos de usuario para Cloud Foundry. Las filas se leen de izquierda a derecha, con el rol de Cloud Foundry en la columna uno y el permiso de clúster en la columna dos.">
  <caption>Permisos de gestión de clúster por rol de Cloud Foundry</caption>
  <thead>
    <th>Rol de Cloud Foundry</th>
    <th>Permisos de gestión de clústeres</th>
  </thead>
  <tbody>
  <tr>
    <td>Rol de espacio: Gestor</td>
    <td>Gestionar el acceso de los usuarios a un espacio de {{site.data.keyword.Bluemix_notm}}</td>
  </tr>
  <tr>
    <td>Rol del espacio: Desarrollador</td>
    <td>
      <ul><li>Crear instancias de servicio de {{site.data.keyword.Bluemix_notm}}</li>
      <li>Enlazar instancias de servicio de {{site.data.keyword.Bluemix_notm}} a clústeres</li>
      <li>Ver registros de la configuración de reenvío de registros de un clúster a nivel de espacio</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## Roles de la infraestructura
{: #infra}

Cuando un usuario con el rol de acceso de la infraestructura de **Superusuario** [establece la clave de API para una región y un grupo de recursos](cs_users.html#api_key), los permisos de la infraestructura para otros usuarios de la cuenta se establecen mediante roles de la plataforma {{site.data.keyword.Bluemix_notm}} IAM. No es necesario que edite los permisos de la infraestructura de IBM Cloud (SoftLayer) de otros usuarios. Utilice la tabla siguiente únicamente para personalizar los permisos de la infraestructura de IBM Cloud (SoftLayer) de los usuarios cuando no pueda asignar el rol de **Superusuario** al usuario que establece la clave de API. Para obtener más información, consulte [Personalización de permisos de la infraestructura](cs_users.html#infra_access).
{: shortdesc}

En la tabla siguiente se muestran los permisos de la infraestructura necesarios para completar grupos de tareas comunes.

<table summary="Permisos de infraestructura para casos de ejemplo comunes de {{site.data.keyword.containerlong_notm}}.">
 <caption>Permisos de infraestructura necesarios habitualmente para {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Tareas comunes en {{site.data.keyword.containerlong_notm}}</th>
  <th>Permisos de infraestructura necesarios por separador</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Permisos mínimos</strong>: <ul><li>Cree un clúster.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Ver detalles de servidores virtuales</li><li>Rearrancar servidor y ver información del sistema IPMI</li><li>Emitir recargas de SO e iniciar el kernel de rescate</li></ul><strong>Cuenta</strong>: <ul><li>Añadir servidor</li></ul></td>
   </tr>
   <tr>
     <td><strong>Administración de clúster</strong>: <ul><li>Crear, actualizar y suprimir clústeres.</li><li>Añadir, cargar y rearrancar nodos trabajadores.</li><li>Ver VLAN.</li><li>Crear subredes.</li><li>Desplegar pods y servicios del equilibrador de carga.</li></ul></td>
     <td><strong>Soporte</strong>:<ul><li>Ver tíquets</li><li>Añadir tíquets</li><li>Editar tíquets</li></ul>
     <strong>Dispositivos</strong>:<ul><li>Ver detalles de hardware</li><li>Ver detalles de servidores virtuales</li><li>Rearrancar servidor y ver información del sistema IPMI</li><li>Emitir recargas de SO e iniciar el kernel de rescate</li></ul>
     <strong>Red</strong>:<ul><li>Añadir sistema con puerto de red pública</li></ul>
     <strong>Cuenta</strong>:<ul><li>Cancelar servidor</li><li>Añadir servidor</li></ul></td>
   </tr>
   <tr>
     <td><strong>Almacenamiento</strong>: <ul><li>Crear reclamaciones de volumen persistente para suministrar volúmenes persistentes.</li><li>Crear y gestionar recursos de infraestructura de almacenamiento.</li></ul></td>
     <td><strong>Servicios</strong>:<ul><li>Gestionar almacenamiento</li></ul><strong>Cuenta</strong>:<ul><li>Añadir almacenamiento</li></ul></td>
   </tr>
   <tr>
     <td><strong>Gestión de redes privadas</strong>: <ul><li>Gestionar VLAN privadas para redes en clúster.</li><li>Configurar conectividad de VPN en redes privadas.</li></ul></td>
     <td><strong>Red</strong>:<ul><li>Gestionar rutas de subredes de la red</li></ul></td>
   </tr>
   <tr>
     <td><strong>Gestión de redes públicas</strong>:<ul><li>Configurar las redes públicas de Ingress y del equilibrador de carga para exponer apps.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Editar nombre de host/dominio</li><li>Gestionar control de puertos</li></ul>
     <strong>Red</strong>:<ul><li>Añadir sistema con puerto de red pública</li><li>Gestionar rutas de subredes de la red</li><li>Añadir direcciones IP</li></ul>
     <strong>Servicios</strong>:<ul><li>Gestionar DNS, DNS inverso y WHOIS</li><li>Ver certificados (SSL)</li><li>Gestionar certificados (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
