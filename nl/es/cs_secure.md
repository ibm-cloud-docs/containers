---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

## Seguridad por componente de clúster
{: #cluster}

Cada clúster de {{site.data.keyword.containerlong_notm}} tiene características de seguridad que están incorporadas en sus nodos [maestro](#master) y de [trabajador](#worker).
{: shortdesc}

Si tiene un cortafuegos, si necesita acceder el equilibrio de carga desde fuera del clúster o si desea ejecutar mandatos `kubectl` desde el sistema local cuando las políticas de red corporativas impiden el acceso a los puntos finales de Internet pública, [abra los puertos en el cortafuegos](cs_firewall.html#firewall). Si desea conectar apps del clúster a una red local o a otras apps externas al clúster, [configure la conectividad de VPN](cs_vpn.html#vpn).

En el siguiente diagrama, puede ver características de seguridad agrupadas por maestro de Kubernetes, nodos trabajadores e imágenes de contenedor.

<img src="images/cs_security.png" width="400" alt="Seguridad de clústeres de {{site.data.keyword.containershort_notm}}" style="width:400px; border-style: none"/>


  <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos.">
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Valores integrados de seguridad de clústeres de {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Maestro de Kubernetes</td>
      <td>IBM gestiona el maestro de Kubernetes de cada clúster, que ofrece una alta disponibilidad. Incluye valores de seguridad de {{site.data.keyword.containershort_notm}} que garantizan la conformidad de seguridad y la comunicación segura entre los nodos trabajadores. IBM realiza las actualizaciones según sea necesario. El maestro de Kubernetes dedicado controla y supervisa de forma centralizada todos los recursos de Kubernetes del clúster. Basándose en los requisitos de despliegue y la capacidad del clúster, el maestro de Kubernetes planifica automáticamente las apps contenerizadas para desplegar en nodos trabajadores disponibles. Para obtener más información, consulte [Seguridad del maestro de Kubernetes](#master).</td>
    </tr>
    <tr>
      <td>Nodo trabajador</td>
      <td>Los contenedores se despliegan en nodos trabajadores que están dedicados a un clúster y que garantizan las funciones de cálculo, red y aislamiento del almacenamiento para los clientes de IBM. {{site.data.keyword.containershort_notm}} proporciona funciones integradas de seguridad para mantener la seguridad de los nodos trabajadores en la red privada y pública y garantizan la conformidad de seguridad de los nodos trabajadores. Para obtener más información, consulte [Seguridad de los nodos trabajadores](#worker). Además, puede añadir [políticas de red Calico](cs_network_policy.html#network_policies) para especificar el tráfico de red que desee permitir o bloquear de y desde un pod a un nodo trabajador.</td>
     </tr>
     <tr>
      <td>Imágenes</td>
      <td>Como administrador del clúster, puede configurar un repositorio seguro propio de imágenes de Docker en {{site.data.keyword.registryshort_notm}} donde puede almacenar y compartir imágenes de Docker entre los usuarios del clúster. Para garantizar despliegues de contenedor seguros, Vulnerability Advisor explora cada imagen del registro privado. Vulnerability Advisor es un componente de {{site.data.keyword.registryshort_notm}} que realiza exploraciones en busca de vulnerabilidades, realiza recomendaciones sobre seguridad y ofrece instrucciones para solucionar las vulnerabilidades. Para obtener más información, consulte [Seguridad de imágenes en {{site.data.keyword.containershort_notm}}](#images).</td>
    </tr>
  </tbody>
</table>

<br />


## Maestro de Kubernetes
{: #master}

Revise las funciones integradas de seguridad de maestro de Kubernetes para proteger el maestro de Kubernetes y para asegurar la comunicación de red del clúster.
{: shortdesc}

<dl>
  <dt>Maestro de Kubernetes totalmente gestionado y dedicado</dt>
    <dd>Cada clúster de Kubernetes de {{site.data.keyword.containershort_notm}} está controlado por un maestro de Kubernetes gestionado por IBM en una cuenta de infraestructura de IBM Cloud (SoftLayer) propiedad de IBM. El maestro de Kubernetes se configura con los siguientes componentes dedicados que no se comparten con otros clientes de IBM.
    <ul><li>Almacén de datos etcd: almacena todos los recursos de Kubernetes de un clúster, como por ejemplo servicios, despliegues y pods. ConfigMaps y secretos de Kubernetes son datos de app que se almacenan como pares de clave y valor para que los pueda utilizar una app que se ejecuta en un pod. Los datos de etcd, de los que se hace una copia de seguridad diaria, se almacenan en un disco cifrado gestionado por IBM. Cuando se envían a un pod, los datos se cifran mediante TLS para garantizar la protección y la integridad de los datos. </li>
    <li>kube-apiserver: sirve como punto de entrada principal para todas las solicitudes procedentes del nodo trabajador destinadas al maestro de Kubernetes. kube-apiserver valida y procesa las solicitudes y puede leer y escribir en el almacén de datos
etcd.</li>
    <li>kube-scheduler: decide dónde desplegar los pods, teniendo en cuenta los requisitos de capacidad y de rendimiento, las restricciones de política de hardware y de software, las especificaciones anti afinidad y los requisitos de carga de trabajo. Si no se encuentra ningún nodo trabajador que se ajuste a los requisitos, el pod no se despliega en el clúster.</li>
    <li>kube-controller-manager: responsable de supervisar los conjuntos de réplicas y de crear los pods correspondientes para alcanzar el estado deseado.</li>
    <li>OpenVPN: componente específico de {{site.data.keyword.containershort_notm}} que proporciona conectividad de red segura para la comunicación entre el maestro de Kubernetes y el nodo trabajador.</li></ul></dd>
  <dt>Conectividad de red protegida por TLS para toda la comunicación entre el nodo trabajador y maestro de Kubernetes</dt>
    <dd>Para proteger la comunicación de red con el maestro de Kubernetes, {{site.data.keyword.containershort_notm}} genera certificados TLS que cifran la comunicación entre los componentes kube-apiserver y el almacén de datos etcd para cada clúster. Estos certificados nunca se comparten entre clústeres ni entre componentes de maestro de Kubernetes.</dd>
  <dt>Conectividad de red protegida por OpenVPN para la comunicación entre el maestro de Kubernetes y el nodo trabajador</dt>
    <dd>Aunque Kubernetes protege la comunicación entre el maestro de Kubernetes y los nodos trabajadores mediante el protocolo `https`, no se proporciona autenticación en el nodo trabajador de forma predeterminada. Para proteger esta comunicación, {{site.data.keyword.containershort_notm}} configura automáticamente una conexión OpenVPN entre el maestro de Kubernetes y el nodo trabajador cuando se crea el clúster.</dd>
  <dt>Supervisión continua de la red del maestro de Kubernetes</dt>
    <dd>IBM supervisa continuamente cada maestro de Kubernetes para controlar y solucionar los ataques de tipo denegación de servicio (DOS) a nivel de proceso.</dd>
  <dt>Conformidad con la seguridad del nodo maestro de Kubernetes</dt>
    <dd>{{site.data.keyword.containershort_notm}} explora automáticamente cada nodo en el que se ha desplegado el nodo maestro de Kubernetes en busca de vulnerabilidades y arreglos de seguridad específicos de Kubernetes y del sistema operativo que se tengan que aplicar para garantizar la protección del nodo maestro. Si se encuentran vulnerabilidades, {{site.data.keyword.containershort_notm}} aplica automáticamente los arreglos y soluciona las vulnerabilidades en nombre del usuario.</dd>
</dl>

<br />


## Nodos trabajadores
{: #worker}

Revise las características de seguridad integradas del nodo trabajador para proteger el entorno de nodo trabajador y para garantizar el aislamiento de recursos, red y almacenamiento.
{: shortdesc}

<dl>
  <dt>Propiedad de los nodos trabajadores</dt>
    <dd>La propiedad de los nodos trabajadores depende del tipo de clúster que cree. <p> Los nodos trabajadores de los clústeres gratuitos se suministran a la cuenta de la infraestructura de IBM Cloud (SoftLayer) que es propiedad de IBM. Los usuarios pueden desplegar apps en los nodos trabajadores, pero no pueden cambiar los valores o instalar software adicional en el nodo trabajador.</p> <p>Los nodos trabajadores de los clústeres estándar se suministran a la cuenta de la infraestructura de IBM Cloud (SoftLayer) que está asociada a la cuenta de IBM Cloud pública o dedicada del cliente. Los nodos trabajadores son propiedad del cliente, pero IBM mantiene el acceso a los nodos trabajadores para desplegar actualizaciones y parches de seguridad en el sistema operativo. Los clientes pueden elegir cambiar los valores de seguridad o instalar software adicional en los nodos trabajadores, según lo estipulado por IBM Cloud Container Service.</p> </dd>
  <dt>Aislamiento de la infraestructura de cálculo, red y almacenamiento</dt>
    <dd>Cuando se crea un clúster, IBM suministra los nodos trabajadores como máquinas virtuales utilizando el portafolio de la infraestructura de IBM Cloud (SoftLayer). Los nodos trabajadores están dedicados a un clúster y no albergan cargas de trabajo de otros clústeres.<p> Cada cuenta de {{site.data.keyword.Bluemix_notm}} se configura con una VLAN de infraestructura de IBM Cloud (SoftLayer) para garantizar el rendimiento y el aislamiento de red de calidad en los nodos trabajadores. También puede designar nodos trabajadores como privados conectándolos solo a una VLAN privada.</p> <p>Para conservar los datos en el clúster, puede suministrar almacenamiento de archivos dedicado basado en NFS de infraestructura de IBM Cloud(SoftLayer) y aprovechar las características integradas de seguridad de datos de dicha plataforma. </p></dd>
  <dt>Configuración protegida de nodo trabajador</dt>
    <dd>Cada nodo trabajador se configura con un sistema operativo Ubuntu que el propietario del nodo trabajador no puede modificar. Dado que el sistema operativo del nodo trabajador es Ubuntu, todos los contenedores desplegados en el nodo trabajador deben utilizar una distribución de Linux que utilice el kernel de Ubuntu. Las distribuciones de Linux que se deben comunicar con el kernel de otra forma no se pueden utilizar. Para proteger el sistema operativo de los nodos trabajadores frente a ataques potenciales, cada noto trabajador se configura con valores avanzados de cortafuegos que imponen las reglas de iptable de Linux.<p> Todos los contenedores que se ejecutan en Kubernetes están protegidos por valores predefinidos de política de red de Calico configurados en cada nodo trabajador durante la creación del clúster. Esta configuración garantiza una comunicación de red segura entre nodos trabajadores y pods. Para restringir aún más las acciones que puede realizar un contenedor sobre el nodo trabajador en un clúster estándar, los usuarios pueden optar por configurar [políticas AppArmor ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) en los nodos trabajadores.</p><p> El acceso SSH está inhabilitado en el nodo trabajador. Si tiene un clúster estándar y desea instalar más características en el nodo trabajador, puede utilizar [conjuntos de daemons de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) para todo lo que desee ejecutar en cada nodo trabajador o [trabajos de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) para cualquier acción única que deba ejecutar.</p></dd>
  <dt>Conformidad de seguridad de nodos trabajadores de Kubernetes</dt>
    <dd>IBM trabaja con equipos de asesoramiento de seguridad interna y externa para abordar las vulnerabilidades potenciales de conformidad de seguridad. IBM mantiene acceso a los nodos trabajadores para desplegar actualizaciones y parches de seguridad en el sistema operativo.<p> <b>Importante</b>: Rearranque los nodos trabajadores de forma normal para garantizar la instalación de las actualizaciones y parches de seguridad que se despliegan automáticamente en el sistema operativo. IBM no rearranca los nodos trabajadores.</p></dd>
  <dt>Opción para desplegar nodos en servidores físicos (nativos)</dt>
  <dd>Si elige suministrar los nodos trabajadores en servidores físicos nativos (en lugar de instancias de servidor virtual), tiene más control sobre el host de cálculo, como por ejemplo la memoria o la CPU. Esta configuración elimina el hipervisor de máquina virtual que asigna recursos físicos a máquinas virtuales que se ejecutan en el host. En su lugar, todos los recursos de una máquina nativa están dedicados exclusivamente al trabajador, por lo que no es necesario preocuparse por "vecinos ruidosos" que compartan recursos o ralenticen el rendimiento. Los servidores nativos están dedicados a usted, con todos los recursos disponibles para que los utilice el clúster.</dd>
  <dt id="trusted_compute">{{site.data.keyword.containershort_notm}} con Trusted Compute</dt>
  <dd><p>Cuando [despliega el clúster en dispositivos nativos](cs_clusters.html#clusters_ui) compatibles con Trusted Compute, puede habilitar la confianza. El chip de TPM (módulo de plataforma de confianza) está habilitado en cada nodo trabajador nativo en el clúster compatible con Trusted Compute (incluidos los nodos futuros que añada al clúster). Por consiguiente, después de habilitar la confianza, no puede inhabilitarla posteriormente para el clúster. Se despliega un servidor de confianza en el nodo maestro, y se despliega un agente de confianza como un pod en el nodo trabajador. Cuando el nodo trabajador se inicia, el pod del agente de confianza supervisa cada etapa del proceso.</p>
  <p>El hardware está en la raíz de la confianza, que envía mediciones mediante el TPM. El TPM genera claves de cifrado que se utilizan para proteger la transmisión de los datos de medición en todo el proceso. El agente de confianza pasa al servidor de confianza la medición de cada componente en el proceso de inicio: desde el firmware del BIOS que interactúa con el hardware de TPM hasta el cargador de arranque y el kernel de SO. A continuación, el agente de confianza compara estas mediciones con los valores previstos en el servidor de confianza, para atestiguar si el inicio ha sido válido. El proceso de informática de confianza no supervisa otros pods en los nodos trabajadores, como aplicaciones.</p>
  <p>Por ejemplo, si un usuario no autorizado obtiene acceso al sistema y modifica el kernel de SO con lógica adicional para recopilar datos, el agente de confianza lo detecta y cambia el estado de confianza del nodo, de modo que sepa que el trabajador ya no es de confianza. Con la informática de confianza, puede verificar que los nodos trabajadores no se manipulan de forma indebida.</p>
  <p><img src="images/trusted_compute.png" alt="Trusted Compute para clústeres nativos" width="480" style="width:480px; border-style: none"/></p></dd>
  <dt id="encrypted_disks">Disco cifrado</dt>
  <dd>De forma predeterminada, {{site.data.keyword.containershort_notm}} proporciona dos particiones locales SSD de datos cifrados para todos los nodos trabajadores cuando se suministran los nodos trabajadores. La primera partición no está cifrada y la segunda partición, montada en _/var/lib/docker_, está desbloqueada mediante claves de cifrado LUKS. Cada trabajador de cada clúster de Kubernetes tiene su propia clave de cifrado LUKS, que gestiona {{site.data.keyword.containershort_notm}}. Cuando se crea un clúster o se añade un nodo trabajador a un clúster existente, las claves se extraen de forma segura y luego se descartan una vez desbloqueado el disco cifrado.
  <p><b>Nota</b>: el cifrado puede afectar al rendimiento de E/S del disco. Para las cargas de trabajo que requieren E/S de disco de alto rendimiento, pruebe un clúster con cifrado habilitado e inhabilitado para decidir mejor si desactiva el cifrado.</p>
  </dd>
  <dt>Soporte para cortafuegos de red de infraestructura de IBM Cloud (SoftLayer)</dt>
    <dd>{{site.data.keyword.containershort_notm}} es compatible con todas las [ofertas de cortafuegos de infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/network-security). En {{site.data.keyword.Bluemix_notm}} Público, puede configurar un cortafuegos con políticas de red personalizadas para proporcionar seguridad de red dedicada para el clúster estándar y para detectar y solucionar problemas de intrusión en la red. Por ejemplo, puede optar por configurar [Vyatta ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/vyatta-1) para que actúe como cortafuegos y bloquee el tráfico no deseado. Si configura un cortafuegos, [también debe abrir los puertos y direcciones IP necesarios](cs_firewall.html#firewall) para cada región para que los nodos maestro y trabajador se puedan comunicar.</dd>
  <dt>Conserve la privacidad de los servicios o exponga servicios y apps a Internet pública de forma selectiva</dt>
    <dd>Puede conservar la privacidad de sus servicios y apps y aprovechar las características seguridad integradas que se describen en este tema para garantizar una comunicación segura entre nodos trabajadores y pods. Para exponer servicios y apps a Internet pública, puede aprovechar el soporte de Ingress y del equilibrador de carga para poner los servicios a disponibilidad pública de forma segura.</dd>
  <dt>Conecte de forma segura sus nodos trabajadores y apps a un centro de datos local</dt>
  <dd>Para conectar los nodos trabajadores y las apps a un centro de datos local, puede configurar un punto final de VPN IPSec con un servicio strongSwan o con un dispositivo Vyatta Gateway o un dispositivo Fortigate.<br><ul><li><b>Servicio VPN IPSec de strongSwan</b>: puede configurar un [servicio VPN IPSec de strongSwan ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.strongswan.org/) que se conecte de forma segura al clúster de Kubernetes con una red local. El servicio VPN IPSec de strongSwan proporciona un canal de comunicaciones de extremo a extremo seguro sobre Internet que está basado en la suite de protocolos
Internet Protocol Security (IPsec) estándar del sector. Para configurar una conexión segura entre el clúster y una red local, debe tener instalada una pasarela VPN IPsec en el centro de datos local. A continuación, puede [configurar y desplegar el servicio VPN IPSec de strongSwan](cs_vpn.html#vpn-setup) en un pod de Kubernetes.</li><li><b>Dispositivo Vyatta Gateway o Fortigate</b>: si tiene un clúster grande, desea acceder a recursos no Kubernetes sobre la VPN o desea acceder a varios clústeres en una sola VPN, puede elegir configurar un dispositivo Vyatta Gateway o Fortigate o para configurar un punto final de VPN IPSec. Para obtener más información, consulte esta publicación de blog sobre [Conexión de un clúster con un centro de datos local ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</li></ul></dd>
  <dt>Supervisión y registro continuos de actividad de clúster</dt>
    <dd>Para los clústeres estándares, todos los sucesos relacionados con clústeres, como la adición de un nodo trabajador, el progreso de una actualización continuada o la información sobre uso de capacidad se pueden registrar y supervisar mediante {{site.data.keyword.containershort_notm}} y enviar a {{site.data.keyword.loganalysislong_notm}} y {{site.data.keyword.monitoringlong_notm}}. Para obtener información sobre cómo configurar el registro y la supervisión, consulte [Configuración del registro de clúster](/docs/containers/cs_health.html#logging) y [Configuración de la supervisión del clúster](/docs/containers/cs_health.html#monitoring).</dd>
</dl>

<br />


## Imágenes
{: #images}

Gestione la seguridad y la integridad de sus imágenes con características integradas de seguridad.
{: shortdesc}

<dl>
<dt>Repositorio de imágenes privadas seguras de Docker en {{site.data.keyword.registryshort_notm}}</dt>
<dd>Puede configurar su propio repositorio de imágenes de Docker en un registro privado de imágenes multiarrendatario, de alta disponibilidad y escalable alojado y gestionado por IBM para crear, almacenar de forma segura y compartir imágenes de Docker con todos los usuarios del clúster.</dd>

<dt>Conformidad con la seguridad de imágenes</dt>
<dd>Cuando se utiliza {{site.data.keyword.registryshort_notm}}, puede aprovechar la exploración de seguridad integrada que proporciona Vulnerability Advisor. Cada imagen que se publica en el espacio de nombres se explora automáticamente para detectar vulnerabilidades especificadas en una base de datos de problemas conocidos de CentOS, Debian, Red Hat y Ubuntu. Si se encuentran vulnerabilidades, Vulnerability Advisor proporciona instrucciones sobre cómo resolverlas para garantizar la integridad y la seguridad.</dd>
</dl>

Para ver la valoración de vulnerabilidades de las imágenes, [revise la documentación de Vulnerability Advisor](/docs/services/va/va_index.html#va_registry_cli).

<br />


## Redes en clúster
{: #in_cluster_network}

Una comunicación de red en clúster segura entre nodos trabajadores y pods se consigue con redes de área local virtuales privadas (VLAN). Una VLAN configura un grupo de nodos trabajadores y pods como si estuvieran conectadas a la misma conexión física.
{:shortdesc}

Cuando crea un clúster, cada clúster se conecta automáticamente a una VLAN privada. La VLAN privada determina la dirección IP privada que se asigna a un nodo trabajador durante la creación del clúster.

|Tipo de clúster|Gestor de la VLAN privada del clúster|
|------------|-------------------------------------------|
|Clústeres gratuitos en {{site.data.keyword.Bluemix_notm}}|{{site.data.keyword.IBM_notm}}|
|Clústeres estándares en {{site.data.keyword.Bluemix_notm}}|En la cuenta de infraestructura de IBM Cloud (SoftLayer) <p>**Sugerencia:** Para tener acceso a todas las VLAN de la cuenta, active [Expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).</p>|

También se asigna una dirección IP privada a todos los pods desplegados en un nodo trabajador. Se asigna a los pods
una IP del rango de direcciones privadas 172.30.0.0/16 y se direccionan solo entre nodos trabajadores. Para evitar conflictos, no utilice este rango de IP en ningún otro nodo que se vaya a comunicar con los nodos trabajadores. Los nodos trabajadores y los pods pueden comunicarse de forma segura a través de la red privada utilizando direcciones IP privadas. Sin embargo, cuando un pod se cuelga o cuando es necesario volver a crear un nodo trabajador, se signa una nueva dirección IP privada.

Puesto que resulta difícil realizar un seguimiento de direcciones IP privadas cambiantes para las apps que deben ofrecer una alta disponibilidad, puede utilizar las funciones integradas de descubrimiento de servicios de Kubernetes y exponer las apps como servicios de IP de clúster en la red privada del clúster. Un servicio de Kubernetes agrupa un conjunto de pods y proporciona una conexión de red a estos pods para otros servicios del clúster sin exponer la dirección IP privada real de cada pod. Cuando se crea un servicio de IP de clúster, se le asigna una dirección IP privada del rango de direcciones privadas 10.10.10.0/24. Al igual que sucede con el rango de direcciones privadas de pod, no utilice este rango de IP en ningún otro nodo que se vaya a comunicar con los nodos trabajadores. Solo se puede acceder a esta dirección IP dentro del clúster. No puede acceder a esta dirección IP desde Internet. Al mismo tiempo, se crea una entrada de búsqueda DNS para el servicio, que se guarda en el componente kube-dns del clúster. La entrada DNS contiene el nombre del servicio, el espacio de nombres en el que se ha creado el servicio y el enlace a la dirección IP privada asignada del clúster.

Si una app del clúster tiene que acceder a un pod situado tras un servicio de IP de clúster, puede utilizar la dirección IP privada del clúster asignada al servicio o puede enviar una solicitud utilizando el nombre del servicio. Si utiliza el nombre del servicio, se busca el nombre en el componente
kube-dns y se direcciona a la dirección IP privada del clúster del servicio. Cuando llega una solicitud al servicio, este asegura que todas las solicitudes se envían a los pods, independientemente de sus direcciones IP privadas y del nodo trabajador en el que estén desplegadas.

Para obtener más información sobre cómo crear un servicio de tipo IP de clúster, consulte [Servicios de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types).

Para obtener información sobre la conexión segura de apps en un clúster de Kubernetes a una red local, consulte [Configuración de la conectividad de VPN](cs_vpn.html#vpn). Para obtener información sobre cómo exponer sus apps para la comunicación de redes externas, consulte [Planificación de redes externas](cs_network_planning.html#planning).
