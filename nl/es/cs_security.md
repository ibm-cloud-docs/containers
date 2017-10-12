---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

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
{: #cs_security}

Puede utilizar características integradas de seguridad para análisis de riesgos y protección de la seguridad. Estas características le ayudan a proteger la infraestructura del clúster y las comunicaciones en la red, a aislar sus recursos de cálculo y a garantizar la conformidad de la seguridad de los componentes de la infraestructura y de los despliegues de contenedores.
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png"><img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} seguridad del clúster" style="width:400px;" /></a>

<table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
  <thead>
  <th colspan=2><img src="images/idea.png"/> Valores integrados de seguridad de clústeres de {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes maestro</td>
      <td>IBM gestiona el nodo Kubernetes maestro de cada clúster, que ofrece una alta disponibilidad. Incluye valores de seguridad de {{site.data.keyword.containershort_notm}} que garantizan la conformidad de seguridad y la comunicación segura entre los nodos trabajadores. IBM realiza las actualizaciones según sea necesario. El Kubernetes maestro dedicado controla y supervisa de forma centralizada todos los recursos de Kubernetes del clúster. Basándose en los requisitos de despliegue y la capacidad del clúster, el Kubernetes maestro planifica automáticamente las apps contenerizadas para desplegar en nodos trabajadores disponibles. Para obtener más información, consulte [Seguridad del nodo Kubernetes maestro](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Nodo trabajador</td>
      <td>Los contenedores se despliegan en nodos trabajadores que están dedicados a un clúster y que garantizan las funciones de cálculo, red y aislamiento del almacenamiento para los clientes de IBM. {{site.data.keyword.containershort_notm}} proporciona funciones integradas de seguridad para mantener la seguridad de los nodos trabajadores en la red privada y pública y garantizan la conformidad de seguridad de los nodos trabajadores. Para obtener más información, consulte [Seguridad de los nodos trabajadores](#cs_security_worker).</td>
     </tr>
     <tr>
      <td>Imágenes</td>
      <td>Como administrador del clúster, puede configurar un repositorio seguro propio de imágenes de Docker en {{site.data.keyword.registryshort_notm}} donde puede almacenar y compartir imágenes de Docker entre los usuarios del clúster. Para garantizar despliegues de contenedor seguros, Vulnerability Advisor explora cada imagen del registro privado. Vulnerability Advisor es un componente de {{site.data.keyword.registryshort_notm}} que realiza exploraciones en busca de vulnerabilidades, realiza recomendaciones sobre seguridad y ofrece instrucciones para solucionar las vulnerabilidades. Para obtener más información, consulte [Seguridad de imágenes en {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

## Kubernetes maestro
{: #cs_security_master}

Revise las funciones integradas de seguridad de Kubernetes maestro para proteger el nodo Kubernetes maestro y para asegurar la comunicación de red del clúster.
{: shortdesc}

<dl>
  <dt>Kubernetes maestro totalmente gestionado y dedicado</dt>
    <dd>Cada clúster de Kubernetes de {{site.data.keyword.containershort_notm}} está controlado por un Kubernetes maestro gestionado por IBM en una cuenta de {{site.data.keyword.BluSoftlayer_full}} propiedad de IBM. El nodo Kubernetes maestro se configura con los siguientes componentes dedicados que no se comparten con otros clientes de IBM.
    <ul><ul><li>Almacén de datos etcd: almacena todos los recursos de Kubernetes de un clúster, como por ejemplo servicios, despliegues y pods. ConfigMaps y secretos de Kubernetes son datos de app que se almacenan como pares de clave y valor para que los pueda utilizar una app que se ejecuta en un pod. Los datos de etcd se almacenan en un disco cifrado gestionado por IBM y se cifra mediante TLS cuando se envían a un pod para garantizar la protección y la integridad de los datos.
    <li>kube-apiserver: sirve como punto de entrada principal para todas las solicitudes procedentes del nodo trabajador destinadas al nodo Kubernetes maestro. kube-apiserver valida y procesa las solicitudes y puede leer y escribir en el almacén de datos
etcd.
    <li><kube-scheduler: decide dónde desplegar los pods, teniendo en cuenta los requisitos de capacidad y de rendimiento, las restricciones de política de hardware y de software, las especificaciones anti afinidad y los requisitos de carga de trabajo. Si no se encuentra ningún nodo trabajador que se ajuste a los requisitos, el pod no se despliega en el clúster.
    <li>kube-controller-manager: responsable de supervisar los conjuntos de réplicas y de crear los pods correspondientes para alcanzar el estado deseado.
    <li>OpenVPN: componente específico de {{site.data.keyword.containershort_notm}} que proporciona conectividad de red segura para
la comunicación entre el nodo Kubernetes maestro y el nodo trabajador.</ul></ul></dd>
  <dt>Conectividad de red protegida por TLS para toda la comunicación entre el nodo trabajador y Kubernetes maestro</dt>
    <dd>Para proteger la comunicación de red con el nodo Kubernetes maestro, {{site.data.keyword.containershort_notm}} genera certificados TLS que cifran la comunicación entre los componentes
kube-apiserver y almacén de datos etcd para cada clúster. Estos certificados nunca se comparten entre clústeres ni entre componentes de Kubernetes maestro.</dd>
  <dt>Conectividad de red protegida por OpenVPN para la comunicación entre el nodo Kubernetes maestro y el nodo trabajador</dt>
    <dd>Aunque Kubernetes protege la comunicación entre el nodo Kubernetes maestro y los nodos trabajadores mediante el protocolo `https`, no se proporciona autenticación en el nodo trabajador de forma predeterminada. Para proteger esta comunicación, {{site.data.keyword.containershort_notm}} configura automáticamente una conexión OpenVPN entre el nodo Kubernetes maestro y el nodo trabajador cuando se crea el clúster.</dd>
  <dt>Supervisión continua de red de Kubernetes maestro</dt>
    <dd>IBM supervisa continuamente cada nodo Kubernetes maestro para controlar y solucionar los ataques de tipo denegación de servicio (DOS) a nivel de proceso.</dd>
  <dt>Conformidad con la seguridad del nodo Kubernetes maestro</dt>
    <dd>{{site.data.keyword.containershort_notm}} explora automáticamente cada nodo en el que se ha desplegado el nodo Kubernetes maestro en busca de vulnerabilidades y arreglos de seguridad específicos de Kubernetes y del sistema operativo que se tengan que aplicar para garantizar la protección del nodo maestro. Si se encuentran vulnerabilidades, {{site.data.keyword.containershort_notm}} aplica automáticamente los arreglos y soluciona las vulnerabilidades en nombre del usuario.</dd>
</dl>  

## Nodos trabajadores
{: #cs_security_worker}

Revise las características de seguridad integradas del nodo trabajador para proteger el entorno de nodo trabajador y para garantizar el aislamiento de recursos, red y almacenamiento.
{: shortdesc}

<dl>
  <dt>Aislamiento de la infraestructura de cálculo, red y almacenamiento</dt>
    <dd>Cuando crea un clúster, se suministran máquinas virtuales como nodos trabajadores en la cuenta de {{site.data.keyword.BluSoftlayer_notm}} del cliente o en la cuenta de {{site.data.keyword.BluSoftlayer_notm}} dedicada por IBM. Los nodos trabajadores están dedicados a un clúster y no albergan cargas de trabajo de otros clústeres.</br> Cada cuenta de {{site.data.keyword.Bluemix_notm}} se configura con una VLAN de {{site.data.keyword.BluSoftlayer_notm}} para garantizar el rendimiento y el aislamiento de red de calidad en los nodos trabajadores. </br>Para conservar los datos en el clúster, puede suministrar almacenamiento de archivos dedicado basado en NFS de {{site.data.keyword.BluSoftlayer_notm}} y aprovechar las características integradas de seguridad de datos de dicha plataforma.</dd>
  <dt>Configuración protegida de nodo trabajador</dt>
    <dd>Cada nodo trabajador se configura con un sistema operativo Ubuntu que el usuario no puede modificar. Para proteger el sistema operativo de los nodos trabajadores frente a ataques potenciales, cada noto trabajador se configura con valores avanzados de cortafuegos que imponen las reglas de iptable de Linux.</br> Todos los contenedores que se ejecutan en Kubernetes están protegidos por valores predefinidos de política de red de Calico configurados en cada nodo trabajador durante la creación del clúster. Esta configuración garantiza una comunicación de red segura entre nodos trabajadores y pods. Para restringir aún más las acciones que puede realizar un contenedor sobre el nodo trabajador, los usuarios pueden optar por configurar [políticas AppArmor![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) en los nodos trabajadores.</br> De forma predeterminada, el acceso SSH para el usuario root está inhabilitado en el nodo trabajador. Si desea instalar más características en el nodo trabajador, puede utilizar [conjuntos de daemons de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) para todo lo que desee ejecutar en cada nodo trabajador o [trabajos de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) para cualquier acción única que deba ejecutar. </dd>
  <dt>Conformidad de seguridad de nodos trabajadores de Kubernetes</dt>
    <dd>IBM trabaja con equipos de asesoramiento en cuanto a seguridad internos y externos para identificar problemas potenciales de conformidad de seguridad para nodos trabajadores y publica periódicamente actualizaciones de conformidad y parches de seguridad para solucionar las vulnerabilidades detectadas. IBM despliega las actualizaciones y los parches de seguridad de forma automática en el sistema operativo del nodo trabajador. Para ello, IBM mantiene acceso SSH a los nodos trabajadores.</br> <b>Nota</b>: Algunas actualizaciones pueden precisar rearrancar los nodos trabajadores.
Sin embargo, IBM no rearranca los nodos trabajadores durante la instalación de actualizaciones o parches de seguridad. Se advierte a los usuarios la necesidad de rearrancar los nodos trabajadores de forma periódica para asegurarse de que la instalación de las actualizaciones y de los parches de seguridad finalizan correctamente.</dd>
  <dt>Soporte para cortafuegos de red de SoftLayer</dt>
    <dd>{{site.data.keyword.containershort_notm}} es compatible con todas las ofertas de cortafuegos de [{{site.data.keyword.BluSoftlayer_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/network-security). En {{site.data.keyword.Bluemix_notm}} público, puede configurar un cortafuegos con políticas de red personalizadas para proporcionar seguridad de red dedicada para el clúster y para detectar y solucionar problemas de intrusión en la red.
Por ejemplo, puede optar por configurar [Vyatta ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/vyatta-1) para que actúe como cortafuegos y bloquee el tráfico no deseado. Si configura un cortafuegos, [también debe abrir los puertos y direcciones IP necesarios](#opening_ports) para cada región para que los nodos maestro y trabajador se puedan comunicar. En {{site.data.keyword.Bluemix_notm}} dedicado, los cortafuegos, DataPower, Fortigate y DNS se configuran como parte del despliegue del entorno dedicado estándar. </dd>
  <dt>Conserve la privacidad de los servicios o exponga servicios y apps a Internet pública de forma selectiva</dt>
    <dd>Puede conservar la privacidad de sus servicios y apps y aprovechar las características seguridad integradas que se describen en este tema para garantizar una comunicación segura entre nodos trabajadores y pods. Para exponer servicios y apps a Internet pública, puede aprovechar el soporte de Ingress y del equilibrador de carga para poner los servicios a disponibilidad pública de forma segura.</dd>
  <dt>Conecte de forma segura sus nodos trabajadores y apps a un centro de datos local</dt>
    <dd>Puede configurar Vyatta Gateway Appliance o Fortigate Appliance para configurar un punto final IPSec VPN que conecte el clúster de Kubernetes con un centro de datos local. Sobre un túnel cifrado, todos los servicios que se ejecutan en el clúster de Kubernetes se pueden comunicar de forma segura con apps locales, como directorios de usuario, bases de datos o sistemas principales. Para obtener más información, consulte [Conexión de un clúster con un centro de datos local ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</dd>
  <dt>Supervisión y registro continuos de actividad de clúster</dt>
    <dd>Para los clústeres estándares, todos los sucesos relacionados con clústeres, como la adición de un nodo trabajador, el progreso de una actualización continuada o la información sobre uso de capacidad, se registran y supervisar mediante {{site.data.keyword.containershort_notm}} y se envían al servicio de registro y supervisión de IBM.</dd>
</dl>

### Apertura de los puertos y direcciones IP necesarios en el cortafuegos
{: #opening_ports}

Si configura un cortafuegos para los nodos trabajadores o personaliza los valores de cortafuegos en la cuenta de {{site.data.keyword.BluSoftlayer_notm}}, debe abrir ciertos puertos y direcciones IP para que el nodo trabajador y el nodo maestro de Kubernetes se puedan comunicar. 

1.  Anote la dirección IP pública de todos los nodos trabajadores del clúster.

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  En el cortafuegos, permita las siguientes conexiones entre los nodos trabajadores.

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>Para conectividad de SALIDA de los nodos trabajadores, permita el tráfico de red de salida desde el nodo trabajador de origen al rango de puertos TCP/UDP de destino 20000-32767 para `
<each_worker_node_publicIP>` y las siguientes direcciones IP y grupos de red: </br>
    

    <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
  <thead>
      <th colspan=2><img src="images/idea.png"/> Direcciones IP de salida</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## Políticas de red
{: #cs_security_network_policies}

Cada clúster de Kubernetes está configurado con un plugin de red que se denomina Calico. Las políticas de red predeterminadas se configuran para proteger la interfaz de red pública de cada nodo trabajador. Puede utilizar Calico y las funciones nativas de Kubernetes para configurar más políticas de red para un clúster cuando tenga requisitos de seguridad exclusivos. Estas políticas de red especifican el tráfico de red que desea permitir o bloquear de entrada y de salida de un pod de un clúster.
{: shortdesc}

Puede elegir entre Calico y las funciones nativas de Kubernetes para crear políticas de red para el clúster. Puede utilizar las políticas de red de Kubernetes para empezar, pero utilice las políticas de red de Calico para obtener funciones más potentes.

<ul><li>[Políticas de red de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): se ofrecen algunas opciones básicas, como por ejemplo la especificación de los pods que se pueden comunicar entre sí. El tráfico de red de entrada para los pods se puede permitir o bloquear para un protocolo y un puerto en función de las etiquetas y de los espacios de nombres de Kubernetes del pod que intenta establecer la conexión.</br>Estas políticas se pueden aplicar utilizando mandatos `kubectl` o la API de Kubernetes. Cuando se aplican estas políticas, se convierten en políticas de red de Calico y Calico impone estas políticas.
<li>[Políticas de red de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy): estas políticas constituyen un superconjunto de las políticas de red de
Kubernetes y mejoran las funciones nativas de Kubernetes con las siguientes características.
<ul><ul><li>Permitir o bloquear el tráfico de red en las interfaces de red especificadas, no sólo el tráfico de pod de Kubernetes.<li>Permitir o bloquear el tráfico de red de entrada (ingress) y de salida (egress).<li>Permitir o bloquear el tráfico que se basa en una dirección IP de origen o de destino o en CIDR.</ul></ul></br>
Estas políticas se aplican mediante mandatos `calicoctl`. Calico impone estas políticas, incluidas las políticas de Kubernetes que se convierten en políticas de Calico, configurando reglas iptables de Linux en los nodos trabajadores de Kubernetes. Las reglas iptables sirven como cortafuegos para el nodo trabajador para definir las características que debe cumplir el tráfico de red para que se reenvíe al recurso de destino.</ul>


### Configuración de la política predeterminada
{: #concept_nq1_2rn_4z}

Cuando se crea un clúster, se configuran automáticamente políticas de red predeterminadas para la interfaz de red pública de cada nodo trabajador a fin de limitar el tráfico entrante de Internet público para un nodo trabajador. Estas políticas no afectan al tráfico entre pods y se configuran para permitir el acceso a nodeport de Kubernetes, al equilibrador de carga y a los servicios de Ingress.

Las políticas predeterminadas no se aplican directamente a los pods; se aplican a la interfaz de red pública de un nodo trabajador utilizando un [punto final de host![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal) de Calico. Cuando se crea un punto final de host en Calico, todo el tráfico de entrada y de salida de la interfaz de red del nodo trabajador se bloquea, a no ser que una política permita dicho tráfico.

Tenga en cuenta que no existe una política que permita SSH, de modo que el acceso SSH a través de la interfaz de red pública se bloquea, así como todos los demás puertos que no tienen una política para abrirlos. El acceso SSH, otros accesos, está disponible en la interfaz de red privada de cada nodo trabajador.

**Importante:** No elimine las políticas que se aplican a un punto final de host a menos que conozca en profundidad la política y sepa con seguridad que no necesita el tráfico que permite dicha política.



  <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
  <thead>
  <th colspan=2><img src="images/idea.png"/> Políticas predeterminadas para cada clúster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Permite todo el tráfico de salida.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Permite paquetes icmp de entrada (pings).</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>Permite todo el tráfico de entrada en el puerto 10250, que es el puerto que utiliza kubelet. La política permite que `kubectl logs` y `kubectl exec` funcionen correctamente en el clúster
de Kubernetes.</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Permite el tráfico de entrada de nodeport, equilibrador de carga y servicio ingress en los pods que exponen dichos servicios. Tenga en cuenta que el puerto en el que exponen estos servicios en la interfaz pública no se tiene que especificar, ya que Kubernetes utiliza la conversión de direcciones de red de destino (DNAT) para reenviar estas solicitudes de servicio a los pods adecuados. El reenvío se realiza antes de que se apliquen las políticas de punto final de host en iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Permite conexiones entrantes para sistemas {{site.data.keyword.BluSoftlayer_notm}} específicos que se utilizan para gestionar los nodos trabajadores.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Permite paquetes vrrp, que se utilizan para supervisar y mover direcciones IP virtuales entre los nodos trabajadores.</td>
   </tr>
  </tbody>
</table>


### Adición de políticas de red
{: #adding_network_policies}

En la mayoría de los casos, no es necesario modificar las políticas predeterminadas. Sólo en escenarios avanzados se pueden requerir cambios. Si debe realizar cambios, instale la CLI de Calico y cree sus propias políticas de red

Antes de empezar, siga los siguientes pasos.

1.  [Instale las CLI de {{site.data.keyword.containershort_notm}} y de Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Cree un clúster lite o estándar.](cs_cluster.html#cs_cluster_ui)
3.  [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `bx cs cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para el rol de administrador rbac, que tiene que ejecutar con mandatos Calico.

  ```
  bx cs cluster-config <cluster_name>
  ```
  {: pre}


Para añadir políticas de red:
1.  Instale la CLI de Calico.
    1.  [Descargue la CLI de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/projectcalico/calicoctl/releases/).

        **Sugerencia:** Si utiliza Windows, instale la CLI de Calico en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}.
Esta configuración le ahorra algunos cambios en filepath cuando ejecute mandatos posteriormente.

    2.  Para usuarios de OSX y Linux, siga los pasos siguientes:
        1.  Mueva el archivo ejecutable al directorio /usr/local/bin. 
            -   Linux:

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS
X:

              ```
              mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Convierta el archivo binario en un ejecutable.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Compruebe que los mandatos `calico` se han ejecutado correctamente comprobando la versión del cliente de la CLI de Calico.

        ```
        calicoctl version
        ```
        {: pre}

2.  Configure la CLI de Calico.

    1.  Para Linux y OS X, cree el directorio '/etc/calico'. Para Windows, se puede utilizar cualquier directorio.

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Cree un archivo 'calicoctl.cfg'. 
        -   Linux y OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: Cree el archivo con un editor de texto.

    3.  Escriba la siguiente información en el archivo <code>calicoctl.cfg</code>.

      ```
      apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
      ```
      {: pre}

        1.  Recupere `<ETCD_URL>`.

          -   Linux y OS X:

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   Ejemplo de salida:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Obtenga una lista de los pods del espacio de nombres kube-system y localice el pod del controlador Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Ejemplo:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>Consulte los detalles del pod del controlador Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>Localice el valor de los puntos finales de ETCD. Ejemplo: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Recupere `<CERTS_DIR>`, el directorio en el que se han descargado los certificados de Kubernetes. 

            -   Linux y OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Ejemplo de salida:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Ejemplo de salida:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **Nota**: Para obtener la vía de acceso del directorio, elimine el nombre de archivo `kube-config-prod-<location>-<cluster_name>.yml` del final de la salida. 

        3.  Recupere el valor <code>ca-*pem_file<code>.

            -   Linux y OS X:

              ```
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows:
              <ol><li>Abra el directorio que ha recuperado en el último paso.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
              <li> Localice el archivo <code>ca-*pem_file</code>.</ol>

        4.  Compruebe que la configuración de Calico funciona correctamente.

            -   Linux y OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              Salida:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  Examine las políticas de red existentes.

    -   Consultar el punto final del host de Calico.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Consultar todas las políticas de red de Calico y de Kubernetes que se han creado para el clúster. Esta lista incluye políticas que quizás no se apliquen todavía a ningún pod o host. Para que una política de red se pueda imponer, debe encontrar un recurso de Kubernetes que coincida con el selector que se ha definido en la política de red de Calico.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Consultar los detalles correspondientes a una política de red.

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   Consultar los detalles de todas las políticas de red para el clúster.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Cree las políticas de red de Calico de modo que permitan o bloqueen el tráfico.

    1.  Para definir su [política de red de Calico![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy), cree un script de configuración(.yaml). Estos archivos de configuración incluyen los selectores que describen los pods, espacios de nombres o hosts a los que se aplican estas políticas. Consulte estas [políticas de Calico de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) como ayuda para crear la suya propia. 

    2.  Aplique las políticas al clúster.
        -   Linux y OS X:

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}


## Imágenes
{: #cs_security_deployment}

Gestione la seguridad y la integridad de sus imágenes con características integradas de seguridad.
{: shortdesc}

### Repositorio de imágenes privadas seguras de Docker en {{site.data.keyword.registryshort_notm}}:

 Puede configurar su propio repositorio de imágenes de Docker en un registro privado de imágenes multiarrendatario, de alta disponibilidad y escalable alojado y gestionado por IBM para crear, almacenar de forma segura y compartir imágenes de Docker con todos los usuarios del clúster.

### Conformidad con la seguridad de imágenes: 

Cuando se utiliza {{site.data.keyword.registryshort_notm}}, puede aprovechar la exploración de seguridad integrada que proporciona Vulnerability Advisor. Cada imagen que se publica en el espacio de nombres se explora automáticamente para detectar vulnerabilidades especificadas en una base de datos de problemas conocidos de CentOS, Debian, Red Hat y Ubuntu. Si se encuentran vulnerabilidades, Vulnerability Advisor proporciona instrucciones sobre cómo resolverlas para garantizar la integridad y la seguridad.

Para ver la valoración de vulnerabilidades de una imagen:

1.  En el **catálogo**, seleccione **Contenedores**.
2.  Seleccione la imagen en la que desea ver la valoración de vulnerabilidad.
3.  En la sección **Valoración de vulnerabilidad**, pulse **Ver informe**.
