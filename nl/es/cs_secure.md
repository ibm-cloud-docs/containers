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




# Seguridad para {{site.data.keyword.containerlong_notm}}
{: #security}

Puede utilizar características integradas de seguridad en {{site.data.keyword.containerlong}} para análisis de riesgos y protección de la seguridad. Estas características le ayudan a proteger la infraestructura del clúster de Kubernetes y las comunicaciones en la red, a aislar sus recursos de cálculo y a garantizar la conformidad de la seguridad de los componentes de la infraestructura y de los despliegues de contenedores.
{: shortdesc}

## Visión general de las amenazas de seguridad para el clúster
{: #threats}

Para evitar que el clúster se vea comprometido, debe comprender las amenazas de seguridad potenciales para el clúster y lo que puede hacer para reducir la exposición a vulnerabilidades.
{: shortdesc}

<img src="images/cs_security_threats.png" width="400" alt="Amenazas de seguridad para el clúster" style="width:400px; border-style: none"/>

La seguridad en la nube y la protección de sus sistemas, infraestructura y datos frente a ataques se han convertido en asuntos de gran importantes en los últimos dos años, a medida que las empresas siguen trasladando sus cargas de trabajo a la nube pública. Un clúster consta de varios componentes, y cada uno puede poner en riesgo su entorno ante ataques maliciosos. Para proteger el clúster frente a estas amenazas de seguridad, debe asegurarse de que aplica las últimas características y actualizaciones de seguridad de {{site.data.keyword.containerlong_notm}} y Kubernetes en todos los componentes del clúster.

Estos componentes incluyen:
- [Servidor de API Kubernetes y almacén de datos etcd](#apiserver)
- [Nodos trabajadores](#workernodes)
- [Red](#network)
- [Almacén persistente](#storage)
- [Supervisión y registro](#monitoring_logging)
- [Registro e imágenes de contenedor](#images_registry)
- [Seguridad y aislamiento de contenedores](#container)
- [Información personal](#pi)

## Servidor de API Kubernetes y etcd
{: #apiserver}

El servidor de API Kubernetes y etcd son los componentes más vulnerables que se ejecutan en el nodo maestro de Kubernetes. Si un usuario o sistema no autorizado consigue acceder al servidor de API de Kubernetes, el usuario o sistema puede cambiar los valores, manipular o tomar el control del clúster, lo que pone el clúster en riesgo de sufrir ataques maliciosos.
{: shortdesc}

Para proteger el servidor de API Kubernetes y el almacén de datos etcd, debe proteger y limitar el acceso al servidor de API Kubernetes tanto a usuarios humanos como a cuentas del servicio Kubernetes.

**¿Cómo se otorga acceso a mi servidor de API Kubernetes?** </br>
De forma predeterminada, Kubernetes requiere que cada solicitud pase por varias etapas antes de que se conceda el acceso al servidor de API:

<ol><li><strong>Autenticación: </strong>valida la identidad de un usuario registrado o una cuenta de servicio.</li><li><strong>Autorización: </strong>limita los permisos de los usuarios autenticados y las cuentas de servicio para asegurarse de que pueden acceder y operar solo con los componentes de clúster que desee.</li><li><strong>Control de admisiones: </strong>valida o muta solicitudes antes de que las procese el servidor de API de Kubernetes. Muchas características de Kubernetes requieren controladores de admisiones para funcionar correctamente.</li></ol>

**¿Qué hace {{site.data.keyword.containerlong_notm}} para proteger mi servidor de API Kubernetes y el almacén de datos etcd?** </br>
En la imagen siguiente se muestran los valores de seguridad de clúster predeterminados que abordan la autenticación, la autorización, el control de admisiones y la conectividad segura entre el nodo maestro Kubernetes y los nodos trabajadores.

<img src="images/cs_security_apiserver_access.png" width="600" alt="Fases de seguridad cuando se accede al servidor de API de Kubernetes" style="width:600px; border-style: none"/>

<table>
<caption>Seguridad del servidor de API Kubernetes y de etcd</caption>
  <thead>
  <th>Característica de seguridad</th>
  <th>Descripción</th>
  </thead>
  <tbody>
    <tr>
      <td>Maestro de Kubernetes totalmente gestionado y dedicado</td>
      <td><p>Cada clúster de Kubernetes de {{site.data.keyword.containerlong_notm}} está controlado por un maestro de Kubernetes gestionado por IBM en una cuenta de infraestructura de IBM Cloud (SoftLayer) propiedad de IBM. El nodo maestro de Kubernetes se configura con los siguientes componentes dedicados que no se comparten con otros clientes de IBM.</p>
        <ul><li><strong>Almacén de datos etcd:</strong> almacena todos los recursos de Kubernetes de un clúster, como por ejemplo servicios, despliegues y pods. ConfigMaps y secretos de Kubernetes son datos de app que se almacenan como pares de clave y valor para que los pueda utilizar una app que se ejecuta en un pod. Los datos de etcd, de los que se hace una copia de seguridad diaria, se almacenan en un disco cifrado gestionado por IBM. Cuando se envían a un pod, los datos se cifran mediante TLS para garantizar la protección y la integridad de los datos.</li>
          <li><strong>kube-apiserver:</strong> sirve como punto de entrada principal para todas las solicitudes de gestión del clúster procedentes del nodo trabajador destinadas al maestro de Kubernetes. kube-apiserver valida y procesa las solicitudes y puede leer y escribir en el almacén de datos etcd.</li>
          <li><strong>kube-scheduler:</strong> decide dónde desplegar los pods, considerando los requisitos de capacidad y de rendimiento, las restricciones de política de hardware y de software, las especificaciones anti afinidad y los requisitos de carga de trabajo. Si no se encuentra ningún nodo trabajador que se ajuste a los requisitos, el pod no se despliega en el clúster.</li>
          <li><strong>kube-controller-manager:</strong> responsable de supervisar los conjuntos de réplicas y de crear los pods correspondientes para alcanzar el estado deseado.</li>
          <li><strong>OpenVPN:</strong> componente específico de {{site.data.keyword.containerlong_notm}} que proporciona conectividad de red segura para la comunicación entre el maestro de Kubernetes y el nodo trabajador. La comunicación entre el nodo maestro de Kubernetes y el nodo trabajador la inicia el usuario e incluye mandatos <code>kubectl</code>, como <code>logs</code>, <code>attach</code>, <code>exec</code> y <code>top</code>.</li></ul></td>
    </tr>
    <tr>
      <td>Comunicación segura a través de TLS</td>
      <td>Para utilizar {{site.data.keyword.containerlong_notm}}, debe autenticarse con el servicio utilizando sus credenciales. Cuando se ha autenticado, {{site.data.keyword.containerlong_notm}} genera certificados TLS que cifran la comunicación a y desde el servidor de API de Kubernetes y el almacén de datos etcd para garantizar una comunicación segura de extremo a extremo entre los nodos trabajadores y el nodo maestro de Kubernetes. Estos certificados nunca se comparten entre clústeres ni entre componentes de maestro de Kubernetes. </td>
    </tr>
    <tr>
      <td>Conectividad OpenVPN con nodos trabajadores</td>
      <td>Aunque Kubernetes protege la comunicación entre el maestro de Kubernetes y los nodos trabajadores mediante el protocolo <code>https</code>, no se proporciona autenticación en el nodo trabajador de forma predeterminada. Para proteger esta comunicación, {{site.data.keyword.containerlong_notm}} configura automáticamente una conexión OpenVPN entre el maestro de Kubernetes y el nodo trabajador cuando se crea el clúster.</td>
    </tr>
    <tr>
      <td>Control de acceso preciso</td>
      <td>Como administrador de la cuenta, puede [otorgar acceso a otros usuarios para {{site.data.keyword.containerlong_notm}}](cs_users.html#users) utilizando {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM). IAM proporciona autenticación segura con la plataforma {{site.data.keyword.Bluemix_notm}}, {{site.data.keyword.containerlong_notm}} y todos los recursos de la cuenta. La configuración de los roles y permisos de usuario adecuados resulta clave para limitar quién puede acceder a sus recursos y limitar el daño que puede hacer un usuario cuando se utilizan mal los permisos legítimos. </br></br>Puede seleccionar entre los siguientes roles de usuario predefinidos que determinan el conjunto de acciones que el usuario puede realizar: <ul><li><strong>Roles de plataforma:</strong> determinan las acciones relacionadas con el clúster y el nodo trabajador que un usuario puede realizar en {{site.data.keyword.containerlong_notm}}.</li><li><strong>Roles de infraestructura:</strong> determinan los permisos para solicitar, actualizar o eliminar recursos de infraestructura como, por ejemplo, nodos trabajadores, VLAN o subredes.</li><li><strong>Roles de RBAC de Kubernetes:</strong> determinan los mandatos `kubectl` que un usuario puede ejecutar cuando está autorizado a acceder a un clúster. Los roles de RBAC se configuran automáticamente para el espacio de nombres predeterminado de un clúster. Para utilizar los mismos roles de RBAC en otros espacios de nombres, puede copiar los roles de RBAC del espacio de nombres predeterminado.  </li></ul> </br> En lugar de utilizar roles de usuario predefinidos, puede optar por [personalizar los permisos de infraestructura](cs_users.html#infra_access) o [configurar sus propios roles de RBAC](cs_users.html#rbac) para añadir un control de acceso más preciso. </td>
    </tr>
    <tr>
      <td>Controladores de admisiones</td>
      <td>Los controladores de admisiones se implementan para características específicas en Kubernetes y {{site.data.keyword.containerlong_notm}}. Con los controladores de admisiones puede configurar políticas en el clúster que determinen si se permite o no una acción concreta en el clúster. En la política, puede especificar condiciones bajo las que un usuario no puede realizar una acción, incluso si esta acción forma parte de los permisos generales que ha asignado al usuario utilizando RBAC. Por lo tanto, los controladores de admisiones pueden proporcionar una capa adicional de seguridad para el clúster antes de que el servidor de API Kubernetes procese una solicitud de API. </br></br> Cuando crea un clúster, {{site.data.keyword.containerlong_notm}} instala automáticamente los siguientes [controladores de admisiones de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/admission-controllers/) en el nodo maestro de Kubernetes, que el usuario no puede cambiar: <ul>
      <li>DefaultTolerationSeconds</li>
      <li>DefaultStorageClass</li>
      <li>GenericAdmissionWebhook (Kubernetes 1.8)</li>
      <li>Initializers</li>
      <li>LimitRanger</li>
      <li>MutatingAdmissionWebhook (Kubernetes 1.9 y posteriores)</li>
      <li>NamespaceLifecycle</li>
      <li>PersistentVolumeLabel</li>
      <li>[PodSecurityPolicy](cs_psp.html#ibm_psp) (Kubernetes 1.8.13, 1.9.8 o 1.10.3 y posteriores)</li>
      <li>[Priority](cs_pod_priority.html#pod_priority) (Kubernetes 1.11.2 o posterior</li>
      <li>ResourceQuota</li>
      <li>ServiceAccount</li>
      <li>StorageObjectInUseProtection (Kubernetes 1.10 y posteriores)</li>
      <li>ValidatingAdmissionWebhook (Kubernetes 1.9 y posteriores)</li></ul></br>
      Puede [instalar sus propios controladores de admisiones en el clúster ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#admission-webhooks) o puede elegir entre los controladores de admisiones opcionales que proporciona {{site.data.keyword.containerlong_notm}}: <ul><li><strong>[Container Image Security Enforcer](/docs/services/Registry/registry_security_enforce.html#security_enforce):</strong> utilice este controlador de admisiones para imponer políticas de Vulnerability Advisor en el clúster para bloquear despliegues procedentes de imágenes vulnerables.</li></ul></br><strong>Nota: </strong> si ha instalado manualmente controladores de admisiones y ya no desea utilizarlos, asegúrese de eliminarlos por completo. Si los controladores de admisiones no se eliminan por completo, es posible que bloqueen todas las acciones que desee realizar en el clúster. </td>
    </tr>
  </tbody>
</table>

## Nodo trabajador
{: #workernodes}

Los nodos trabajadores se ocupan de los despliegues y los servicios que forman la app. Si aloja las cargas de trabajo en la nube pública, desea asegurarse de que la app está protegido frente al acceso, modificación y supervisión por parte de un usuario o software no autorizado.
{: shortdesc}

**¿Quién es el propietario del nodo trabajador y soy yo el responsable de protegerlo?** </br>
La propiedad de un nodo trabajador depende del tipo de clúster que haya creado. Los nodos trabajadores de los clústeres gratuitos se suministran a la cuenta de la infraestructura de IBM Cloud (SoftLayer) que es propiedad de IBM. Puede desplegar apps en nodos trabajadores, pero no pueden cambiar los valores ni instalar software adicional en el nodo trabajador. Debido a la capacidad limitada y a las características limitadas de {{site.data.keyword.containerlong_notm}}, no ejecute cargas de trabajo de producción en clústeres gratuitos. Considere la posibilidad de utilizar clústeres estándares para las cargas de producción. </br> </br>
Los nodos trabajadores de los clústeres estándares se suministran en la cuenta de infraestructura de IBM Cloud (SoftLayer) asociada con su cuenta de {{site.data.keyword.Bluemix_notm}} pública o dedicada. Los nodos trabajadores están dedicados a su cuenta y usted es el responsable de solicitar actualizaciones puntuales para los nodos trabajadores para asegurarse de que el sistema operativo y los componentes de {{site.data.keyword.containerlong_notm}} aplican las últimas actualizaciones de seguridad y parches. </br></br><strong>Importante: </strong>Utilice el [mandato](cs_cli_reference.html#cs_worker_update) <code>ibmcloud ks worker-update</code> de forma regular (por ejemplo, una vez al mes) para desplegar actualizaciones y parches de seguridad en el sistema operativo y para actualizar la versión de Kubernetes. Cuando hay actualizaciones disponibles, se le notifica cuando visualiza información sobre los nodos maestro y trabajador en la GUI o CLI, por ejemplo con los mandatos <code>ibmcloud ks clusters</code> o <code>ibmcloud ks workers <cluster_name></code>.

**¿Qué aspecto tiene la configuración de mi nodo trabajador?**</br>
En la imagen siguiente se muestran los componentes que se configuran para cada nodo trabajador para proteger el nodo trabajador frente a ataques maliciosos. </br></br>
**Nota:** la imagen no incluye componentes que garanticen la comunicación segura de extremo a extremo a y desde el nodo trabajador. Consulte [seguridad de red](#network) para obtener más información.

<img src="images/cs_worker_setup.png" width="600" alt="Configuración de nodo trabajador (sin incluir seguridad de red)" style="width:600px; border-style: none"/>

<table>
<caption>Configuración de la seguridad del nodo trabajador</caption>
  <thead>
  <th>Característica de seguridad</th>
  <th>Descripción</th>
  </thead>
  <tbody>
    <tr><td>Imagen de Linux conforme con CIS</td><td>Cada nodo trabajador se configura con un sistema operativo Ubuntu que implementa los puntos de referencia publicados por el Centro de seguridad de Internet (CIS). Ni el usuario ni el propietario de la máquina pueden modificar el sistema operativo Ubuntu. Para comprobar la versión de Ubuntu actual, ejecute <code>kubectl get nodes -o wide</code>. IBM trabaja con equipos de asesoramiento de seguridad interna y externa para abordar las vulnerabilidades potenciales de conformidad de seguridad. Las actualizaciones de seguridad y los parches para el sistema operativo están disponibles a través de {{site.data.keyword.containerlong_notm}} y los debe instalar el usuario para mantener seguro el nodo de trabajo. </br></br><strong>Importante: </strong>{{site.data.keyword.containerlong_notm}} utiliza un kernel de Ubuntu Linux para nodos trabajadores. Puede ejecutar contenedores basados en cualquier distribución de Linux en {{site.data.keyword.containerlong_notm}}. Verifique con el proveedor de la imagen de contenedor si da soporte a la ejecución de la imagen de contenedor en los kernels de Ubuntu Linux.</td></tr>
    <tr>
  <td>Aislamiento de cálculo</td>
  <td>Los nodos trabajadores están dedicados a un clúster y no albergan cargas de trabajo de otros clústeres. Cuando crea un clúster estándar, puede optar por suministrar a los nodos trabajadores como [máquinas físicas (nativas) o máquinas virtuales](cs_clusters_planning.html#planning_worker_nodes) que se ejecutan en hardware físico compartido o dedicado. El nodo trabajador de un clúster gratuito se suministra automáticamente como nodo compartido virtual en la cuenta de infraestructura de IBM Cloud (SoftLayer).</td>
</tr>
<tr>
<td>Opción para despliegue nativo</td>
<td>Si elige suministrar los nodos trabajadores en servidores físicos nativos (en lugar de instancias de servidor virtual), tiene más control sobre el host de cálculo, como por ejemplo la memoria o la CPU. Esta configuración elimina el hipervisor de máquina virtual que asigna recursos físicos a máquinas virtuales que se ejecutan en el host. En su lugar, todos los recursos de una máquina nativa están dedicados exclusivamente al trabajador, por lo que no es necesario preocuparse por "vecinos ruidosos" que compartan recursos o ralenticen el rendimiento. Los servidores nativos están dedicados a usted, con todos los recursos disponibles para que los utilice el clúster.</td>
</tr>
<tr>
  <td id="trusted_compute">Opción para cálculo de confianza</td>
    <td>Si despliega el clúster en un sistema nativo que da soporte a Trusted Compute (cálculo de confianza), puede [habilitar la confianza](cs_cli_reference.html#cs_cluster_feature_enable). El chip de TPM (módulo de plataforma de confianza) está habilitado en cada nodo trabajador nativo en el clúster compatible con Trusted Compute (incluidos los nodos futuros que añada al clúster). Por consiguiente, después de habilitar la confianza, no puede inhabilitarla posteriormente para el clúster. Se despliega un servidor de confianza en el nodo maestro, y se despliega un agente de confianza como un pod en el nodo trabajador. Cuando el nodo trabajador se inicia, el pod del agente de confianza supervisa cada etapa del proceso.<p>El hardware es la base de un sistema fiable, que envía medidas mediante TPM. TPM genera las claves de cifrado que se utilizan para proteger la transmisión de datos sobre medidas durante el proceso. El agente de confianza transmite al servidor de confianza la medida de cada componente en el proceso de arranque: desde el firmware de BIOS que interactúa con el hardware TPM hasta el cargador de arranque y el kernel del sistema operativo. Luego, el agente de confianza compara estas medidas con los valores esperados en el servidor de confianza para evaluar si el arranque ha sido válido. El proceso de cálculo de confianza no supervisa otros pods de los nodos trabajadores, como pueden ser aplicaciones.</p><p>Por ejemplo, si un usuario no autorizado accede a su sistema y modifica el kernel del sistema operativo con lógica adicional para recopilar datos, el agente de confianza detecta este cambio y marca el nodo como de no confianza. Con el cálculo de confianza, puede proteger los nodos trabajadores frente a una manipulación indebida.</p>
    <p><strong>Nota</strong>: Trusted Compute está disponible para determinados tipos de máquinas nativas. Por ejemplo, los distintos tipos de GPU `mgXc` no dan soporte a Trusted Compute.</p>
    <p><img src="images/trusted_compute.png" alt="Cálculo de confianza para clústeres nativos" width="480" style="width:480px; border-style: none"/></p></td>
  </tr>
    <tr>
  <td id="encrypted_disk">Discos cifrados</td>
    <td>De forma predeterminada, cada nodo trabajador se suministra con dos particiones de datos cifrados SSD locales. La primera partición contiene la imagen de kernel que se utiliza para arrancar el nodo trabajador y que no está cifrada. La segunda partición contiene el sistema de archivos de contenedor y se desbloquea mediante las claves de cifrado LUKS. Cada nodo trabajador de cada clúster de Kubernetes tiene su propia clave de cifrado LUKS, que gestiona {{site.data.keyword.containerlong_notm}}. Cuando se crea un clúster o se añade un nodo trabajador a un clúster existente, las claves se extraen de forma segura y luego se descartan una vez desbloqueado el disco cifrado.</br></br><strong>Nota: </strong> el cifrado puede afectar al rendimiento de E/S de disco. Para las cargas de trabajo que requieren E/S de disco de alto rendimiento, pruebe un clúster con cifrado habilitado e inhabilitado para decidir mejor si desactiva el cifrado.</td>
      </tr>
    <tr>
      <td>Políticas AppArmor de experto</td>
      <td>Cada nodo trabajador se configura con políticas de seguridad y de acceso que se imponen mediante perfiles de [AppArmor ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo") ](https://wiki.ubuntu.com/AppArmor), que se cargan en el nodo trabajador durante el programa de carga. Ni el usuario ni el propietario de la máquina pueden modificar los perfiles de AppArmor. </td>
    </tr>
    <tr>
      <td>SSH inhabilitado</td>
      <td>De forma predeterminada, el acceso SSH está inhabilitado en el nodo trabajador para proteger el clúster frente a ataques maliciosos. Cuando el acceso SSH está inhabilitado, el acceso al clúster se impone mediante el servidor de API de Kubernetes. El servidor de API de Kubernetes requiere que cada solicitud se compruebe con las políticas establecidas en la autenticación, autorización y módulo de control de admisiones antes de que la solicitud se ejecute en el clúster. </br></br>  Si tiene un clúster estándar y desea instalar más características en el nodo trabajador, puede elegir entre los complementos proporcionados por {{site.data.keyword.containerlong_notm}} o utilizar [conjuntos de daemons de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para cualquier cosa que desee ejecutar en cada nodo trabajador. Para cualquier acción individual que deba ejecutar, utilice los [Trabajos de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/).</td>
    </tr>
  </tbody>
  </table>

## Red
{: #network}
El enfoque clásico para proteger la red de una empresa consiste en configurar un cortafuegos y bloquear todo el tráfico de red no deseado dirigido a sus apps. Aunque esto sigue vigente, recientes investigaciones muestran que muchos ataques malintencionados provienen de personal interno o de usuarios autorizados que hacer un mal uso de sus permisos asignados.
{: shortdesc}

Para proteger la red y limitar el rango de daños que puede infligir un usuario cuando se otorga el acceso a una red, debe asegurarse de que las cargas de trabajo estén tan aisladas en la medida de lo posible y de que limite el número de apps y nodos trabajadores que están expuestos públicamente.

**¿Qué tráfico de red está permitido para mi clúster de forma predeterminada?**</br>
Todos los contenedores están protegidos por [valores predefinidos de política de red de Calico](cs_network_policy.html#default_policy)
que se configuran en cada nodo trabajador durante la creación del clúster. De forma predeterminada, todo el tráfico de red de salida está permitido para todos los nodos trabajadores. El tráfico de red de entrada se bloquea excepto en algunos puertos abiertos para que IBM pueda supervisar el tráfico de la red y pueda instalar automáticamente las actualizaciones de seguridad en el nodo maestro de Kubernetes. El acceso desde el nodo maestro de Kubernetes al kubelet del nodo trabajador está protegido por un túnel OpenVPN. Para obtener más información, consulte la [arquitectura de {{site.data.keyword.containerlong_notm}}](cs_tech.html).

Si desea permitir el tráfico de red entrante desde Internet, debe exponer sus apps con un [servicio NodePort, un servicio LoadBalancer o un equilibrador de carga de aplicaciones de Ingress](cs_network_planning.html#planning).  

**¿Qué es la segmentación de red y cómo puedo configurarla para un clúster?** </br>
La segmentación de red describe el enfoque para dividir una red en varias subredes. Puede agrupar apps y datos relacionados a los que vaya a acceder un determinado grupo de la organización. Las apps que se ejecutan en una subred no pueden ver ni acceder a las apps de otra subred. La segmentación de red también limita el acceso que se proporciona a un software interno o de terceros y puede limitar el rango de actividades maliciosas.   

{{site.data.keyword.containerlong_notm}} proporciona VLAN de infraestructura de IBM Cloud (SoftLayer) que garantizan un rendimiento de red de calidad y el aislamiento de red de los nodos trabajadores. Una VLAN configura un grupo de nodos trabajadores y pods como si estuvieran conectadas a la misma conexión física. Las VLAN están dedicadas a su
cuenta de {{site.data.keyword.Bluemix_notm}} y no se comparten entre los clientes de IBM. Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de la infraestructura de IBM Cloud (SoftLayer).

La expansión de VLAN es un valor de la cuenta de {{site.data.keyword.Bluemix_notm}} y puede activarse o desactivarse. Cuando está activada, todos los clústeres de su cuenta pueden ver y hablar entre sí. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Aunque esto puede resultar útil en algunos casos, la expansión de VLAN elimina la segmentación de red para los clústeres.

Revise la siguiente tabla para ver las opciones sobre cómo conseguir la segmentación de red cuando se activa la expansión de VLAN.

|Característica de seguridad|Descripción|
|-------|----------------------------------|
|Configuración de políticas de red personalizadas con Calico|Puede utilizar la interfaz integrada de Calico para [configurar políticas de red de Calico personalizadas](cs_network_policy.html#network_policies) para los nodos trabajadores. Por ejemplo, puede permitir o bloquear el tráfico de red en interfaces de red específicas, para pods específicos o servicios. Para configurar políticas de red personalizadas, debe [instalar la CLI <code>calicoctl</code>](cs_network_policy.html#cli_install).|
|Soporte para cortafuegos de red de infraestructura de IBM Cloud (SoftLayer)|{{site.data.keyword.containerlong_notm}} es compatible con todas las [ofertas de cortafuegos de infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/network-security). En {{site.data.keyword.Bluemix_notm}} Público, puede configurar un cortafuegos con políticas de red personalizadas para proporcionar seguridad de red dedicada para el clúster estándar y para detectar y solucionar problemas de intrusión en la red. Por ejemplo, podría elegir configurar un [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) para que actuase como cortafuegos para bloquear el tráfico no deseado. Si configura un cortafuegos, [también debe abrir los puertos y direcciones IP necesarios](cs_firewall.html#firewall) para cada región para que los nodos maestro y trabajador se puedan comunicar.|
{: caption="Opciones de segmentación de red" caption-side="top"}

**¿Qué otra cosa puedo hacer para reducir la superficie de ataques externos?**</br>
Cuantas más apps o nodos trabajadores exponga públicamente, más pasos debe llevar a cabo para evitar ataques maliciosos externos. Revise la siguiente tabla para ver las opciones disponibles para mantener la privacidad de sus apps y nodos trabajadores.

|Característica de seguridad|Descripción|
|-------|----------------------------------|
|Limitación del número de apps expuestas|De forma predeterminada, no se puede acceder sobre internet público a las apps y servicios que se ejecutan en el clúster. Puede elegir si desea exponer sus apps al público, o si desea que solo se pueda acceder a sus apps y servicios en la red privada. Si mantiene la privacidad de las apps y los servicios, puede aprovechar las características de seguridad integradas para garantizar una comunicación segura entre nodos trabajadores y pods. Para exponer servicios y apps a Internet pública, puede aprovechar el [soporte de Ingress y del equilibrador de carga](cs_network_planning.html#planning) para poner los servicios a disponibilidad pública de forma segura. Asegúrese de que solo se expongan los servicios necesarios y vuelva a visitar la lista de apps expuesta de forma regular para asegurarse de que siguen siendo válidas. |
|Mantenimiento de la privacidad de los nodos trabajadores|Cuando crea un clúster, cada clúster se conecta automáticamente a una VLAN privada. La VLAN privada determina la dirección IP privada que se asigna a un nodo trabajador. Puede optar por mantener la privacidad de los nodos trabajadores conectándolos solo a una VLAN privada. Las VLAN privadas en clústeres gratuitos están gestionadas por IBM, y las VLAN privadas de los clústeres estándares se gestionan mediante la cuenta de infraestructura de IBM Cloud (SoftLayer). </br></br><strong>Atención:</strong> tenga en cuenta que, para comunicarse con el nodo maestro de Kubernetes y para que {{site.data.keyword.containerlong_notm}} funcione correctamente, debe configurar la conectividad pública con [URL y direcciones IP específicos](cs_firewall.html#firewall_outbound). Para configurar esta conectividad pública, puede configurar un cortafuegos, como un [dispositivo direccionador virtual](/docs/infrastructure/virtual-router-appliance/about.html), frente a los nodos trabajadores y habilitar el tráfico de red a estos URL y direcciones IP.|
|Limitación de la conectividad de Internet pública con los nodos de extremo|De forma predeterminada, cada nodo trabajador se configura de modo que acepte pods de app y pods de ingress o de equilibrador de carga asociados. Puede etiquetar los nodos trabajadores como [nodos de extremo](cs_edge.html#edge) para forzar el despliegue del equilibrador de carga y de los pods ingress solo en estos nodos trabajadores. Además, puede [marcar los nodos trabajadores](cs_edge.html#edge_workloads) de modo que los pods de app no se puedan planificar en los nodos de extremo. Con nodos de extremo puede aislar la carga de trabajo de red en menos nodos trabajadores en el clúster y mantener la privacidad de los otros nodos trabajadores del clúster.|
{: caption="Opciones de servicios privados y de nodos trabajadores" caption-side="top"}

**¿Qué ocurre si deseo conectar mi clúster a un centro de datos local?**</br>
Para conectar los nodos trabajadores y las apps a un centro de datos local, puede configurar un [punto final VPN IPSec con un servicio strongSwan, un dispositivo direccionador virtual o un dispositivo de seguridad Fortigate](cs_vpn.html#vpn).

### Servicios LoadBalancer e Ingress
{: #network_lb_ingress}

Puede utilizar los servicios de red LoadBalancer e Ingress para conectar sus apps a internet público o a redes privadas externas. Revise los siguientes valores opcionales para los equilibradores de carga y los ALB de Ingress que puede utilizar para satisfacer los requisitos de seguridad de las apps de fondo o para cifrar el tráfico a medida que se mueve a través del clúster.

**¿Puedo utilizar grupos de seguridad para gestionar el tráfico de red de mi clúster?** </br>
Para utilizar los servicios de Ingress y LoadBalancer, utilice [políticas de Calico y Kubernetes](cs_network_policy.html) para gestionar el tráfico de red de entrada y salida del clúster. No utilice [grupos de seguridad](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups) de la infraestructura de IBM Cloud (SoftLayer). Los grupos de seguridad de la infraestructura de IBM Cloud (SoftLayer) se aplican a la interfaz de red de un solo servidor virtual para filtrar el tráfico en el nivel de hipervisor. Sin embargo, los grupos de seguridad no dan soporte al protocolo VRRP, que {{site.data.keyword.containerlong_notm}} utiliza para gestionar la dirección IP de LoadBalancer. Si no dispone del protocolo VRRP para gestionar la IP de LoadBalancer, los servicios Ingress y LoadBalancer no funcionan correctamente. Si no utiliza los servicios Ingress o LoadBalancer y desea aislar completamente el nodo trabajador del público, puede utilizar grupos de seguridad.

**¿Cómo puedo proteger la IP de origen dentro del clúster?** </br>
De forma predeterminada, la dirección IP de origen de la solicitud de cliente no se conserva. Cuando una solicitud de cliente para su app se envía a su clúster, la solicitud se direcciona a un pod para el servicio de equilibrador de carga que expone el ALB. Si no existen pods de app en el mismo nodo trabajador que el pod del servicio equilibrador de carga, el equilibrador de carga reenvía las solicitudes a un pod de app en un nodo trabajador diferente. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el pod de app está en ejecución.

Conservar la dirección IP del cliente es útil, por ejemplo, cuando los servidores de apps tienen que aplicar políticas de control de acceso y seguridad. Para conservar la dirección IP de origen original de la solicitud de cliente, puede habilitar la conservación de IP de origen para [loadbalancers](cs_loadbalancer.html#node_affinity_tolerations) o [ALB Ingress](cs_ingress.html#preserve_source_ip).

**¿Cómo puedo cifrar el tráfico con TLS?** </br>
El servicio Ingress ofrece terminación de TLS en dos puntos en el flujo del tráfico:
* [Descifrado de paquete al llegar](cs_ingress.html#public_inside_2): de forma predeterminada, el ALB Ingress equilibra la carga del tráfico de red HTTP con las apps del clúster. Para equilibrar también la carga de conexiones HTTPS entrantes, puede configurar el ALB para descifrar el tráfico de red y reenviar las solicitudes descifradas a las apps expuestas en su clúster. Si está utilizando el subdominio de Ingress proporcionado por IBM, puede utilizar el certificado TLS proporcionado por IBM. Si utiliza un dominio personalizado, puede utilizar su propio certificado TLS para gestionar la terminación TLS.
* [Recifrado de paquete antes de que se reenvíe
a las apps en sentido ascendente](cs_annotations.html#ssl-services): el ALB descifra las solicitudes HTTPS antes de reenviar el tráfico a las apps. Si tiene apps que requieren HTTPS y necesita que el tráfico se cifre antes de que se reenvíen a dichas apps en sentido ascendente, puede utilizar la anotación ssl-services. Si sus apps en sentido ascendente pueden manejar TLS, puede proporcionar de forma opcional un certificado contenido en un secreto TLS de autenticación mutua o de un solo sentido.

Para proteger la comunicación de servicio a servicio, puede utilizar la [autenticación TLS mutua de Istio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://istio.io/docs/concepts/security/mutual-tls/). Istio es un servicio de código fuente abierto que ofrece a los desarrolladores una forma de conectarse, proteger, gestionar y supervisar una red de microservicios, también conocida como malla de servicios, en plataformas de orquestación de nube como Kubernetes.

## Almacén persistente
{: #storage}

Cuando se suministra almacenamiento persistente para almacenar datos en el clúster, los datos se cifran automáticamente sin coste adicional cuando se almacenan en la compartición de archivos o en el almacenamiento en bloque. El cifrado incluye instantáneas y almacenamiento replicado.
{: shortdesc}

Para obtener más información sobre cómo se cifran los datos para el tipo de almacenamiento específico, consulte los siguientes enlaces.
- [Almacenamiento de archivos NFS](/docs/infrastructure/FileStorage/block-file-storage-encryption-rest.html#securing-your-data-provider-managed-encryption-at-rest)
- [Almacenamiento en bloque](/docs/infrastructure/BlockStorage/block-file-storage-encryption-rest.html#securing-your-data-provider-managed-encryption-at-rest) </br>

También puede utilizar un servicio de base de datos de {{site.data.keyword.Bluemix_notm}}, como por ejemplo [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant), para persistir datos en una base de datos gestionada fuera del clúster. Se puede acceder a los datos que se almacenan con un servicio de base de datos de nube a través de clústeres, zonas y regiones. Para obtener información relacionada con la seguridad acerca de IBM Cloudant NoSQL DB, consulte la [documentación del servicio](/docs/services/Cloudant/offerings/security.html#security).

## Supervisión y registro
{: #monitoring_logging}

La clave para detectar ataques maliciosos en el clúster es la supervisión y el registro adecuados de todos los sucesos que se producen en el clúster. La supervisión y el registro también pueden ayudarle a comprender la capacidad de clúster y la disponibilidad de los recursos para su app, lo que le ayudará a realizar una planificación consecuente para proteger sus apps frente a un tiempo de inactividad.
{: shortdesc}

**¿Supervisa IBM mi clúster?**</br>
IBM supervisa continuamente cada nodo Kubernetes maestro para controlar y solucionar los ataques de tipo denegación de servicio (DOS) a nivel de proceso. {{site.data.keyword.containerlong_notm}} explora automáticamente cada nodo en el que se ha desplegado el nodo maestro de Kubernetes en busca de vulnerabilidades y arreglos de seguridad específicos de Kubernetes y del sistema operativo. Si se encuentran vulnerabilidades, {{site.data.keyword.containerlong_notm}} aplica automáticamente los arreglos y soluciona las vulnerabilidades en nombre del usuario para asegurarse de la protección del nodo maestro.  

**¿Qué información se registra?**</br>
Para los clústeres estándares, puede [configurar el reenvío de registros](/docs/containers/cs_health.html#logging) para todos los sucesos relacionados con el clúster de distintos orígenes a {{site.data.keyword.loganalysislong_notm}} o a otro servidor externo para que pueda filtrar y analizar los registros. Estos orígenes incluyen registros procedentes de:

- **Contenedores**: los registros que se escriben en STDOUT o STDERR.
- **Apps**: los registros que se escriben en una vía de acceso específica dentro de la app.
- **Nodos trabajadores**: los registros del sistema operativo Ubuntu que se envían a /var/log/syslog y /var/log/auth.log.
- **Servidor de API de Kubernetes**: cada acción relacionada con el clúster que se envía al servidor de API de Kubernetes se registra por motivos de auditoría, e incluyen hora, usuario y recurso afectado. Para obtener más información, consulte [Registros de auditoría de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/)
- **Componentes del sistema Kubernetes**: los registros procedentes de `kubelet`, `kube-proxy` y otros componentes que se ejecutan en el espacio de nombres `kube-system`.
- **Ingress**: los registros de un equilibrador de carga de aplicación de Ingress que gestiona el tráfico de red que entra en un clúster.

Puede elegir los sucesos que desea registrar para el clúster y dónde desea reenviar los registros. Para detectar actividades maliciosas y para verificar el estado del clúster, debe analizar los registros de forma continua.

**¿Cómo puedo supervisar el estado y el rendimiento de mi clúster?**</br>
Puede verificar la capacidad y el rendimiento del clúster supervisando los componentes del clúster y los recursos de cálculo, como por ejemplo el uso de CPU y de memoria. {{site.data.keyword.containerlong_notm}} envía automáticamente métricas para los clústeres estándares a {{site.data.keyword.monitoringlong}} para que pueda [verlos y analizarlos en Grafana](cs_health.html#view_metrics).

También puede utilizar herramientas incorporadas, como la página de detalles de {{site.data.keyword.containerlong_notm}} o el panel de control de Kubernetes, o puede [configurar integraciones de terceros](cs_integrations.html#health_services), como Prometheus, Weave Scope y otros.

**¿Cómo puedo auditar los sucesos que se producen en mi clúster?**</br>
Puede [configurar {{site.data.keyword.cloudaccesstraillong}} en el {{site.data.keyword.containerlong_notm}}clúster](cs_at_events.html#at_events). Para obtener más información, consulte la [documentación de {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/activity_tracker_ov.html#activity_tracker_ov).

**¿Cuáles son mis opciones para habilitar la confianza en mi clúster?** </br>
De forma predeterminada, {{site.data.keyword.containerlong_notm}} proporciona muchas características para los componentes del clúster de modo que pueda desplegar las apps contenerizadas en un entorno de seguridad. Amplíe su nivel de confianza en su clúster para asegurarse de que lo que sucede en su clúster es lo que tiene previsto. La confianza en el clúster se puede implementar de varias maneras, tal como se muestra en el siguiente diagrama.

![Despliegue de contenedores con contenido de confianza](images/trusted_story.png)

1.  **{{site.data.keyword.containerlong_notm}} con Trusted Compute**: la confianza se puede habilitar en los nodos trabajadores nativos. El agente de confianza supervisa el proceso de inicio de hardware e informa de cualquier cambio para que pueda verificar si sus nodos trabajadores nativos han sido manipulados. Con Trusted Compute, puede desplegar contenedores en hosts nativos verificados de forma que sus cargas de trabajo se ejecuten en un hardware de confianza. Tenga en cuenta que algunas máquinas nativas, por ejemplo que utilizan GPU, no dan soporte a Trusted Compute. [Más información sobre cómo Trusted Compute funciona](#trusted_compute).

2.  **Confianza de contenido en sus imágenes**: Asegúrese de la integridad de sus imágenes habilitando la confianza de contenido en {{site.data.keyword.registryshort_notm}}. Con el contenido de confianza podrá controlar los usuarios que pueden firmar imágenes como imágenes de confianza. Después los firmantes de confianza transferirán una imagen a su registro y los usuarios podrán extraer el contenido firmado de forma que podrán verificar el origen de la misma. Para obtener más información, consulte [Firma de imágenes para contenido de confianza](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent).

3.  **Container Image Security Enforcement (beta)**: Crea un controlador de admisión con políticas personalizadas de forma que es posible verificar las imágenes del contenedor antes de desplegarlas. Con Container Image Security Enforcement, podrá controlar dónde se despliegan las imágenes y asegurarse de que se satisfacen las políticas de [Vulnerability Advisor](/docs/services/va/va_index.html) o los requisitos del [contenido de confianza](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent). Si un despliegue no cumple las políticas que ha establecido, la aplicación de la seguridad impide modificaciones en el clúster. Para obtener más información, consulte [Imposición de seguridad de imagen de contenedor (Beta)](/docs/services/Registry/registry_security_enforce.html#security_enforce).

4.  **Container Vulnerability Scanner**: De forma predeterminada, Vulnerability Advisor explora imágenes almacenadas en {{site.data.keyword.registryshort_notm}}. Para comprobar el estado de los contenedores activos que están en ejecución en el clúster, puede instalar el explorador de contenedores. Para obtener más información, consulte [Instalación del explorador de contenedores](/docs/services/va/va_index.html#va_install_container_scanner).

5.  **Análisis de red con Security Advisor (vista previa)**: Con {{site.data.keyword.Bluemix_notm}} Security Advisor podrá centralizar el conocimiento de seguridad de los servicios de {{site.data.keyword.Bluemix_notm}} como, por ejemplo, de Vulnerability Advisor y {{site.data.keyword.cloudcerts_short}}. Cuando se habilita Security Advisor en el clúster, puede ver informes sobre el tráfico de red entrante y saliente sospechoso. Para obtener más información, consulte [Analíticas de red](/docs/services/security-advisor/network-analytics.html#network-analytics). Para instalar, consulte [Configuración de supervisión de direcciones de IP y clientes sospechosos para un clúster de Kubernetes](/docs/services/security-advisor/setup_cluster.html).

6.  **{{site.data.keyword.cloudcerts_long_notm}} (beta)**: Si posee un clúster en EE.UU. sur y desea [exponer su app utilizando un dominio personalizado con TLS](cs_ingress.html#ingress_expose_public), puede almacenar su certificado TLS en {{site.data.keyword.cloudcerts_short}}. El panel de control de Security Advisor también puede informar de certificados caducados o a punto de caducar. Para obtener más información, consulte [Iniciación a {{site.data.keyword.cloudcerts_short}}](/docs/services/certificate-manager/index.html#gettingstarted).


## Imagen y registro
{: #images_registry}

Cada despliegue se basa en una imagen que contiene las instrucciones sobre cómo utilizar el contenedor que ejecuta la app. Estas instrucciones incluyen el sistema operativo dentro del contenedor y el software adicional que desea instalar. Para proteger la app, debe proteger la imagen y establecer comprobaciones para garantizar la integridad de la imagen.
{: shortdesc}

**¿Debo utilizar un registro público o privado para almacenar mis imágenes?** </br>
Los registros públicos, como por ejemplo Docker Hub, se pueden utilizar para empezar a trabajar con imágenes de Docker y Kubernetes para crear la primera app contenerizada de un clúster. Pero, cuando se trata de aplicaciones de empresa, evite los registros que no conozca o en los que no confía para proteger el clúster de imágenes maliciosas. Mantenga las imágenes en un registro privado, como el que se proporciona en {{site.data.keyword.registryshort_notm}}, y asegúrese de controlar el acceso al registro y el contenido de la imagen que se puede enviar por push.

**¿Por qué es importante comprobar las imágenes frente a vulnerabilidades?** </br>
Las investigaciones muestran que la mayoría de los ataques maliciosos aprovechan las vulnerabilidades conocidas de software y las configuraciones débiles del sistema. Cuando despliega un contenedor a partir de una imagen, el contenedor se utiliza con el sistema operativo y con los binarios adicionales que ha descrito en la imagen. Al igual que protege su máquina virtual o física, debe eliminar las vulnerabilidades conocidas en el sistema operativo y los binarios que utiliza dentro del contenedor para evitar que usuarios no autorizados accedan a la app. </br>

Para proteger sus apps, tenga en cuenta la posibilidad de establecer un proceso dentro de su equipo para abordar las siguientes áreas:

1. **Explorar las imágenes antes de desplegarlas en producción:** </br>
Asegúrese de explorar cada imagen antes de desplegar un contenedor a partir de la misma. Si se encuentran vulnerabilidades, considere la posibilidad de eliminar las vulnerabilidades o de bloquear el despliegue para dichas imágenes. Establezca un proceso en el que se deba aprobar el contenido de la imagen y en el que solo se puedan desplegar las imágenes que pasen las comprobaciones de vulnerabilidad.

2. **Explorar de forma regular los contenedores en ejecución:** </br>
Aunque haya desplegado un contenedor a partir de una imagen que haya pasado la comprobación de vulnerabilidad, el sistema operativo o los binarios que se ejecutan en el contenedor pueden volverse vulnerables con el tiempo. Para proteger la app, debe asegurarse de que los contenedores en ejecución se exploran de forma regular para que pueda detectar y solucionar las vulnerabilidades. Dependiendo de la app, para añadir seguridad adicional puede establecer un proceso que desactive los contenedores vulnerables después de que se detecten.

**¿Cómo puede {{site.data.keyword.registryshort_notm}} ayudarme a proteger mis imágenes y proceso de despliegue?**  

![Despliegue de contenedores con contenido de confianza](images/cs_image_security.png)

<table>
<caption>Seguridad para imágenes y despliegues</caption>
  <thead>
    <th>Característica de seguridad</th>
    <th>Descripción</th>
  </thead>
  <tbody>
    <tr>
      <td>Repositorio de imágenes privadas seguras de Docker en {{site.data.keyword.registryshort_notm}}</td>
      <td>Configure su propio [repositorio de imágenes](/docs/services/Registry/index.html#index) de Docker en un registro privado de imágenes multiarrendatario, de alta disponibilidad y escalable alojado y gestionado por IBM. Con este registro, podrá crear, almacenar de forma segura y compartir imágenes de Docker con todos los usuarios del clúster. </br></br>Obtenga más información sobre cómo [proteger su información personal](cs_secure.html#pi) cuando se trabaja con imágenes de contenedor.</td>
    </tr>
    <tr>
      <td>Solo envíe por push imágenes con contenido fiable</td>
      <td>Asegure la integridad de las imágenes habilitando la [confianza de contenido](/docs/services/Registry/registry_trusted_content.html#registry_trustedcontent) en el repositorio de imágenes. Con el contenido de confianza, puede controlar quién puede firmar imágenes como fiables y enviar por push imágenes a un espacio de nombres de registro específico. Después los firmantes de confianza envíen por push una imagen a un espacio de nombres de registro, los usuarios podrán extraer el contenido firmado y podrán verificar el origen de la imagen.</td>
    </tr>
    <tr>
      <td>Exploraciones automáticas de vulnerabilidades</td>
      <td>Si utiliza {{site.data.keyword.registryshort_notm}}, puede aprovechar la exploración de seguridad integrada que proporciona [Vulnerability Advisor](/docs/services/va/va_index.html#va_registry_cli). Cada imagen que se publica en el espacio de nombres del registro se explora automáticamente para detectar vulnerabilidades especificadas en una base de datos de problemas conocidos de CentOS, Debian, Red Hat y Ubuntu. Si se encuentran vulnerabilidades, Vulnerability Advisor proporciona instrucciones sobre cómo resolverlas para garantizar la integridad y la seguridad.</td>
    </tr>
    <tr>
      <td>Despliegues en bloque desde imágenes vulnerables o usuarios no fiables</td>
      <td>Crea un controlador de admisiones con políticas personalizadas de forma que se puedan verificar las imágenes del contenedor antes de desplegarlas. Con [Container Image Security Enforcement](/docs/services/Registry/registry_security_enforce.html#security_enforce), podrá controlar dónde se despliegan las imágenes y asegurarse de que se satisfacen las políticas de Vulnerability Advisor o los requisitos del contenido de confianza. Si un despliegue no cumple las políticas que ha establecido, el controlador de admisiones impide el despliegue en su clúster.</td>
    </tr>
    <tr>
      <td>Exploración directa de contenedores</td>
      <td>Para detectar vulnerabilidades en contenedores en ejecución, puede instalar [ibmcloud-container-scanner](/docs/services/va/va_index.html#va_install_container_scanner). De forma similar a lo que sucede con las imágenes, puede configurar el explorador de contenedores para que supervise los contenedores en busca de vulnerabilidades en todos los espacios de nombres de clúster. Cuando se encuentren vulnerabilidades, actualice la imagen de origen y vuelva a desplegar el contenedor.</td>
    </tr>
  </tbody>
  </table>


## Seguridad y aislamiento de contenedores
{: #container}

**¿Qué es un espacio de nombres de Kubernetes y por qué debo utilizarlo?** </br>
Los espacios de nombres de Kubernetes constituyen una forma de dividir virtualmente un clúster y de proporcionar aislamiento para los despliegues y los grupos de usuarios que deseen mover su carga de trabajo al clúster. Con los espacios de nombres, puede organizar los recursos entre los nodos trabajadores y entre las zonas de los clústeres multizona.  

Cada clúster se configura con los siguientes espacios de nombres:
- **default:** el espacio de nombres en el que se despliega todo lo que no define un espacio de nombres específico. Si asigna a un usuario el rol de visor, editor y operador de la plataforma, el usuario puede acceder al espacio de nombres predeterminado, pero no a los espacios de nombres `kube-system`, `ibm-system` ni `ibm-cloud-cert`.
- **kube-system e ibm-system:** este espacio de nombres contiene los despliegues y servicios necesarios para que Kubernetes y {{site.data.keyword.containerlong_notm}} gestionen el clúster. Los administradores del clúster pueden utilizar este espacio de nombres para poner un recurso de Kubernetes a disponibilidad de los espacios de nombres.
- **ibm-cloud-cert:** este espacio de nombres se utiliza para los recursos que están relacionados con {{site.data.keyword.cloudcerts_long_notm}}.
- **kube-public:** todos los usuarios pueden acceder a este espacio de nombres, aunque no estén autenticados con el clúster. Tenga cuidado al desplegar recursos en este espacio de nombres, ya que puede poner su clúster en peligro.

Los administradores de clúster pueden configurar espacios de nombres adicionales en el clúster y personalizarlos en función de sus necesidades. </br></br>
**Importante:** para cada espacio de nombres que tenga en el clúster, asegúrese de configurar las [políticas de RBAC](cs_users.html#rbac) adecuadas para limitar el acceso a este espacio de nombres, de controlar lo que se despliega y de establecer las [cuotas de recursos ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/policy/resource-quotas/) y los [rangos de límites ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/memory-default-namespace/) adecuados.  

**¿Debería configurar un clúster de un solo arrendatario o un clúster multiarrendatario?** </br>
En un clúster de un solo arrendatario, puede crear un clúster para cada grupo de personas que deben ejecutar cargas de trabajo en un clúster. Normalmente, este equipo es el responsable de gestionar el clúster y de configurarlo y protegerlo correctamente. Los clústeres multiarrendatario utilizan varios espacios de nombres para aislar los arrendatarios y sus cargas de trabajo.

<img src="images/cs_single_multitenant.png" width="600" alt="Clúster de un solo arrendatario frente a clúster multiarrendatario" style="width:600px; border-style: none"/>

Los clústeres de un solo arrendatario y multiarrendatario proporcionan el mismo nivel de aislamiento para las cargas de trabajo y tienen el mismo coste aproximadamente. La opción adecuada para cada usuario depende del número de equipos que deben ejecutar cargas de trabajo en un clúster, de sus requisitos de servicio y del tamaño del servicio.

Un clúster de un solo arrendatario puede resultar su opción adecuada si tiene un montón de equipos con servicios complejos, y cada uno de ellos debe controlar el ciclo de vida del clúster. Esto incluye la libertad de decidir cuándo se actualiza un clúster o qué recursos se pueden desplegar en el clúster. Tenga en cuenta que para gestionar un clúster se necesitan conocimientos profundos de Kubernetes y de la infraestructura para garantizar la capacidad y la seguridad de los despliegues.  

Los clústeres multiarrendatario ofrecen la ventaja de que puede utilizar el mismo nombre de servicio en distintos espacios de nombres, lo que puede resultar útil si tiene previsto utilizar espacios de nombres para separar el entorno de producción, de transferencia y de desarrollo. Aunque los clústeres multiarrendatario suelen requerir menos personas para gestionar y administrar el clúster, a menudo resultan más complejos en las áreas siguientes:

- **Acceso:** cuando configure varios espacios de nombres, debe configurar las políticas de RBAC adecuadas para cada espacio de nombres para garantizar el aislamiento de recursos. Las políticas de RBAC son complejas y requieren conocimientos profundos de Kubernetes.
- **Limitación de recursos de cálculo:** para asegurarse de que cada equipo tiene los recursos necesarios para desplegar servicios y ejecutar apps en el clúster, debe configurar [cuotas de recursos](https://kubernetes.io/docs/concepts/policy/resource-quotas/) para cada espacio de nombres. Las cuotas de recursos determinan las restricciones de despliegue para un espacio de nombres, como el número de recursos de Kubernetes que se pueden desplegar y la cantidad de CPU y de memoria que pueden consumir estos recursos. Después de establecer una cuota, los usuarios deben incluir los límites y las solicitudes de recursos en sus despliegues.
- **Recursos de clúster compartidos:** si ejecuta varios arrendatarios en un clúster, algunos recursos de clúster, como por ejemplo el equilibrador de carga de aplicación de Ingress o las direcciones IP portátiles disponibles, se comparten entre los arrendatarios. Es posible que a los servicios pequeños les cueste utilizar recursos compartidos si deben competir con servicios del clúster de gran tamaño.
- **Actualizaciones:** solo puede ejecutar una versión de API de Kubernetes en un momento determinado. Todas las apps que se ejecutan en un clúster deben cumplir con la versión de la API Kubernetes actual, independientemente del equipo que posea la app. Cuando desee actualizar un clúster, debe asegurarse de que todos los equipos estén listos para cambiar a una nueva versión de API de Kubernetes y que las apps se hayan actualizado para que funcionen con la nueva versión de la API de Kubernetes. Esto también significa que los equipos individuales tienen menos control sobre la versión de la API de Kubernetes que desean ejecutar.
- **Cambios en la configuración del clúster:** si desea cambiar la configuración del clúster o migrar a nuevos nodos trabajadores, debe desplegar este cambio entre los arrendatarios. Este despliegue requiere más conciliación y pruebas que en un clúster de un solo arrendatario.
- **Proceso de comunicación:** cuando gestione varios arrendatarios, considere la posibilidad de configurar un proceso de comunicación para que los arrendatarios sepan a dónde ir cuando exista un problema con el clúster o cuando necesiten más recursos para sus servicios. Este proceso de comunicación también incluye informar a los arrendatarios acerca de todos los cambios en la configuración del clúster o de las actualizaciones planificadas.

**¿Qué más puedo hacer para proteger mi contenedor?**

|Característica de seguridad|Descripción|
|-------|----------------------------------|
|Limitar el número de contenedores privilegiados|Los contenedores se ejecutan como un proceso Linux independiente en el host de cálculo que está aislado de otros procesos. Aunque los usuarios tienen acceso de usuario root dentro del contenedor, los permisos de este usuario están limitados fuera del contenedor para proteger otros procesos de Linux, el sistema de archivos de host y los dispositivos de host. Algunas apps requieren acceso al sistema de archivos de host o permisos avanzados para que se ejecuten correctamente. Puede ejecutar contenedores en modalidad privilegiada para permitir que el contenedor tenga el mismo acceso que los procesos que se ejecutan en el host de cálculo. </br></br> <strong>Importante: </strong>tenga en cuenta que los contenedores privilegiados causan grandes daños en el clúster y en el host de cálculo subyacente cuando se ven comprometidos. Intente limitar el número de contenedores que se ejecutan en modalidad privilegiada y considere la posibilidad de cambiar la configuración de la app de modo que la app se pueda ejecutar sin permisos avanzados. Si desea evitar que los contenedores privilegiados se ejecuten en el clúster, considere la posibilidad de configurar [políticas de seguridad de pod](cs_psp.html#customize_psp) personalizadas. |
|Establecer límites de CPU y de memoria para contenedores|Cada contenedor necesita una cantidad específica de CPU y de memoria para iniciarse correctamente y para continuar ejecutándose. Puede definir [límites de recursos y de solicitudes de recursos de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) para sus contenedores a fin de limitar la cantidad de CPU y de memoria que puede consumir el contenedor. Si no hay límites para la CPU y la memoria establecidos y el contenedor está ocupado, el contenedor utiliza todos los recursos disponibles. Este alto consumo de recursos puede afectar a otros contenedores del nodo trabajador que no tienen recursos suficientes para iniciarse o para ejecutarse correctamente, y pone en riesgo el nodo trabajador ante ataques de tipo denegación de servicio.|
|Aplicar valores de seguridad del sistema operativo a los pods|Puede añadir la sección [<code>securityContext</code> ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) al despliegue del pod para aplicar valores de seguridad específicos de Linux al pod o a un contenedor específico del pod. Los valores de seguridad incluyen el control sobre el ID de usuario y el ID de grupo que ejecuta scripts dentro del contenedor, como por ejemplo el script de punto de entrada, o el ID de usuario y la IP de grupo propietarios de la vía de acceso de montaje del volumen. </br></br><strong>Consejo</strong> si desea utilizar <code>securityContext</code> para establecer el ID de usuario <code>runAsUser</code> o el ID de grupo <code>fsGroup</code>, considere la posibilidad de bloquear el almacenamiento cuando [cree almacenamiento persistentes](cs_storage_block.html#add_block). El almacenamiento NFS no da soporte a <code>fsGroup</code> y <code>runAsUser</code> se debe establecer a nivel de contenedor, no a nivel de pod. |
{: caption="Otras protecciones de seguridad" caption-side="top"}

## Almacenamiento de información personal
{: #pi}

El usuario es responsable de garantizar la seguridad de la información personal en las imágenes de contenedor y en los recursos de Kubernetes. La información personal incluye nombre, dirección, número de teléfono, dirección de correo electrónico u otra información que permita identificar, ponerse en contacto o ubicar a los clientes, o a cualquier otro individuo.
{: shortdesc}

<dl>
  <dt>Utilización de un secreto de Kubernetes para almacenar información personal</dt>
  <dd>Únicamente almacene información personal en recursos Kubernetes que estén diseñados para alojar información personal. Por ejemplo, no utilice su nombre en el nombre de una correlación de configuración, servicio, despliegue o espacio de nombres de Kubernetes. En lugar de ello, para un cifrado y protección adecuados, almacene la información personal en los <a href="cs_app.html#secrets">secretos de Kubernetes</a>.</dd>

  <dt>Utilización de `imagePullSecret` de Kubernetes para almacenar credenciales de registros de imagen</dt>
  <dd>No almacene información personal en espacios de nombres de registro ni imágenes de contenedor. En lugar de ello, para un cifrado y protección adecuados, almacene las credenciales de registro en <a href="cs_images.html#other">Kubernetes imagePullSecrets</a> y otra información personal en los <a href="cs_app.html#secrets">secretos de Kubernetes</a>. Recuerde que si la información personal se almacena en una capa previa de una imagen, la supresión de la imagen no será suficiente para suprimir esta información personal.</dd>
  </dl>
