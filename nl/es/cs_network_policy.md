---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Control del tráfico con políticas de red
{: #network_policies}

Cada clúster de Kubernetes está configurado con un plugin de red que se denomina Calico. Las políticas de red predeterminadas se configuran para proteger la interfaz de red pública de cada nodo trabajador en {{site.data.keyword.containerlong}}.
{: shortdesc}

Puede utilizar Calico y las funciones nativas de Kubernetes para configurar más políticas de red para un clúster cuando tenga requisitos de seguridad exclusivos. Estas políticas de red especifican el tráfico de red que desea permitir o bloquear de entrada y de salida de un pod de un clúster. Puede utilizar las políticas de red de Kubernetes para empezar, pero utilice las políticas de red de Calico para obtener funciones más potentes.

<ul>
  <li>[Políticas de red de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): se ofrecen algunas opciones básicas, como por ejemplo la especificación de los pods que se pueden comunicar entre sí. El tráfico de red de entrada se puede permitir o bloquear para un protocolo y un puerto. El tráfico se puede filtrar en función de las etiquetas y de los espacios de nombres de Kubernetes del pod que intenta establecer la conexión con otros pods.</br>Estas políticas se pueden aplicar utilizando mandatos `kubectl` o la API de Kubernetes. Cuando se aplican estas políticas, se convierten en políticas de red de Calico y Calico impone estas políticas.</li>
  <li>[Políticas de red de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): estas políticas constituyen un superconjunto de las políticas de red de
Kubernetes y mejoran las funciones nativas de Kubernetes con las siguientes características.</li>
    <ul><ul><li>Permitir o bloquear el tráfico de red en las interfaces de red especificadas, no sólo el tráfico de pod de Kubernetes.</li>
    <li>Permitir o bloquear el tráfico de red de entrada (ingress) y de salida (egress).</li>
    <li>[Bloquear el tráfico de entrada (ingress) a los servicios LoadBalancer o NodePort Kubernetes](#block_ingress).</li>
    <li>Permitir o bloquear el tráfico que se basa en una dirección IP de origen o de destino o en CIDR.</li></ul></ul></br>

Estas políticas se aplican mediante mandatos `calicoctl`. Calico impone estas políticas, incluidas las políticas de Kubernetes que se convierten en políticas de Calico, configurando reglas iptables de Linux en los nodos trabajadores de Kubernetes. Las reglas iptables sirven como cortafuegos para el nodo trabajador para definir las características que debe cumplir el tráfico de red para que se reenvíe al recurso de destino.</ul>

<br />


## Configuración de la política predeterminada
{: #default_policy}

Cuando se crea un clúster, se definen políticas de red predeterminadas para la interfaz de red pública de cada nodo trabajador a fin de limitar el tráfico entrante de Internet público. Estas políticas no afectan al tráfico entre pods y permiten el acceso a nodeport de Kubernetes, al equilibrador de carga y a los servicios de Ingress.
{:shortdesc}

Las políticas predeterminadas no se aplican directamente a los pods; se aplican a la interfaz de red pública de un nodo trabajador utilizando un punto final de host de Calico. Cuando se crea un punto final de host en Calico, todo el tráfico de entrada y de salida de la interfaz de red del nodo trabajador se bloquea, a no ser que una política permita dicho tráfico.

**Importante:** No elimine las políticas que se aplican a un punto final de host a menos que conozca en profundidad la política y sepa con seguridad que no necesita el tráfico que permite dicha política.


 <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
 <caption>Políticas predeterminadas para cada clúster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Políticas predeterminadas para cada clúster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Permite todo el tráfico de salida.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Permite el tráfico entrante en el puerto 52311 a la app bigfix para permitir las actualizaciones necesarias del nodo trabajador.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Permite paquetes icmp de entrada (pings).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Permite el tráfico de entrada de nodeport, equilibrador de carga y servicio ingress en los pods que exponen dichos servicios. Tenga en cuenta que el puerto en el que exponen estos servicios en la interfaz pública no se tiene que especificar, ya que Kubernetes utiliza la conversión de direcciones de red de destino (DNAT) para reenviar estas solicitudes de servicio a los pods adecuados. El reenvío se realiza antes de que se apliquen las políticas de punto final de host en iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Permite conexiones entrantes para sistemas de infraestructura de IBM Cloud (SoftLayer) específicos que se utilizan para gestionar los nodos trabajadores.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Permite paquetes vrrp, que se utilizan para supervisar y mover direcciones IP virtuales entre los nodos trabajadores.</td>
   </tr>
  </tbody>
</table>

<br />


## Adición de políticas de red
{: #adding_network_policies}

En la mayoría de los casos, no es necesario modificar las políticas predeterminadas. Sólo en escenarios avanzados se pueden requerir cambios. Si debe realizar cambios, instale la CLI de Calico y cree sus propias políticas de red.
{:shortdesc}

Antes de empezar:

1.  [Instale las CLI de {{site.data.keyword.containershort_notm}} y de Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Cree un clúster gratuito o estándar.](cs_clusters.html#clusters_ui)
3.  [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `bx cs cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para el rol de superusuario, que necesita para ejecutar mandatos Calico.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **Nota**: CLI Calico versión 1.6.1 recibe soporte.

Para añadir políticas de red:
1.  Instale la CLI de Calico.
    1.  [Descargue la CLI de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1).

        **Sugerencia:** Si utiliza Windows, instale la CLI de Calico en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}. Esta configuración le ahorra algunos cambios en filepath cuando ejecute mandatos posteriormente.

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
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Convierta el archivo en ejecutable.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Compruebe que los mandatos `calico` se han ejecutado correctamente comprobando la versión del cliente de la CLI de Calico.

        ```
        calicoctl version
        ```
        {: pre}

    4.  Si las políticas de red corporativas impiden el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos, consulte [Ejecución de mandatos `calicoctl` desde detrás de un cortafuegos](cs_firewall.html#firewall) para obtener instrucciones sobre cómo permitir el acceso TCP para los mandatos Calico.

2.  Configure la CLI de Calico.

    1.  Para Linux y OS X, cree el directorio `/etc/calico`. Para Windows, se puede utilizar cualquier directorio.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Cree un archivo `calicoctl.cfg`.
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
        {: codeblock}

        1.  Recupere `<ETCD_URL>`. Si este mandato falla con un error `calico-config not found`, consulte este [tema de resolución de problemas](cs_troubleshoot.html#cs_calico_fails).

          -   Linux y OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Ejemplo de salida:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Obtener los valores de configuración de calico del mapa de configuración. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>En la sección `data`, localice el valor etcd_endpoints. Ejemplo: <code>https://169.1.1.1:30001</code>
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
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>Abra el directorio que ha recuperado en el último paso.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
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

    1.  Para definir su [política de red de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy), cree un script de configuración(.yaml). Estos archivos de configuración incluyen los selectores que describen los pods, espacios de nombres o hosts a los que se aplican estas políticas. Consulte estas [políticas de Calico de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) como ayuda para crear la suya propia.

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

<br />


## Bloquear el tráfico de entrada a los servicios LoadBalancer o NodePort.
{: #block_ingress}

De forma predeterminada, los servicios `NodePort` y `LoadBalancer` de Kubernetes están diseñados para hacer que su app esté disponible en todas las interfaces del clúster públicas y privadas. Sin embargo, puede bloquear el tráfico de entrada a los servicios en función del origen o el destino del tráfico.
{:shortdesc}

Un servicio LoadBalancer de Kubernetes es también un servicio NodePort. Un servicio LoadBalancer hace que la app está disponible en la dirección IP y puerto del equilibrador de carga y hace que la app está disponible en los puertos del nodo del servicio. Se puede acceder a los puertos del nodo en cada dirección IP (pública y privada) para cada nodo del clúster.

El administrador del clúster puede utilizar el bloque de políticas de red `preDNAT` de Calico:

  - Tráfico destinado a servicios NodePort. Se permite el tráfico destinado a los servicios LoadBalancer.
  - Tráfico que se basa en una dirección de origen o CIDR.

Algunos usos comunes de las políticas de red `preDNAT` de Calico:

  - Bloquear el tráfico a puertos de nodos públicos de un servicio LoadBalancer privado.
  - Bloquear el tráfico a puertos de nodos públicos en clústeres que ejecuten [nodos trabajadores de extremo](cs_edge.html#edge). El bloqueo de puertos de nodos garantiza que los nodos trabajadores de extremo sean los únicos nodos trabajadores que manejen el tráfico entrante.

Las políticas de red `preDNAT` resultan útiles porque las políticas predeterminadas de Kubernetes y Calico son difíciles de aplicar para proteger los servicios NodePort y LoadBalancer de Kubernetes debido a las reglas iptables de DNAT que se generan para estos servicios.

Las políticas de red `preDNAT` de Calico generan reglas iptables basadas en un [recurso de política de red de Calico
![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Defina una política de red `preDNAT` de Calico para el acceso de ingress a los servicios de Kubernetes.

  Ejemplo que bloquea todos los puertos de nodo:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Aplique la política de red preDNAT de Calico. La aplicación de los cambios en la política al clúster tarda alrededor de 1 minuto.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}
