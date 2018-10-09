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


# Control del tráfico con políticas de red
{: #network_policies}

Cada clúster de Kubernetes está configurado con un plugin de red que se denomina Calico. Las políticas de red predeterminadas se configuran para proteger la interfaz de red pública de cada nodo trabajador en {{site.data.keyword.containerlong}}.
{: shortdesc}

Si tiene requisitos de seguridad exclusivos o si tiene un clúster multizona con expansión de VLAN habilitada, puede utilizar Calico y Kubernetes para crear políticas de red para un clúster. Con las políticas de red de Kubernetes, puede especificar el tráfico de red que desea permitir o bloquear de y desde un pod en un clúster. Para establecer políticas de red más avanzadas como, por ejemplo, para el bloqueo de tráfico entrante (ingress) para los servicios de LoadBalancer, utilice políticas de red de Calico.

<ul>
  <li>
  [Políticas de red de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): Estas políticas especifican la forma en la que los pods se pueden comunicar con otros pods y con los puntos finales externos. A partir de Kubernetes versión 1.8, se puede permitir tanto el tráfico de red entrante como saliente con base al protocolo, el puerto y las direcciones IP de origen y destino. El tráfico también se puede filtrar basándose en las etiquetas de espacio de nombres y pod. Las políticas de red de Kubernetes se aplican mediante mandatos `kubectl` o con API de Kubernetes. Cuando se aplican estas políticas, se convierten de forma automática en políticas de red de Calico. Calico impone estas políticas.
  </li>
  <li>
  Políticas de red Calico para clústeres de Kubernetes versión [1.10 y posterior ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) o clústeres [1.9 y anterior ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): Estas políticas son un superconjunto de las políticas de red de Kubernetes y se aplican con mandatos `calicoctl`. Las políticas de Calico añaden las características siguientes.
    <ul>
    <li>Permitir o bloquear el tráfico de red en las interfaces de red especificadas, independientemente del CIDR o dirección IP de origen o destino del pod Kubernetes.</li>
    <li>Permitir o bloquear el tráfico de red para pods entre espacios de nombres.</li>
    <li>[Bloquear el tráfico de entrada (ingress) a los servicios LoadBalancer o NodePort Kubernetes](#block_ingress).</li>
    </ul>
  </li>
  </ul>

Calico impone estas políticas, incluidas las políticas de Kubernetes que se convierten automáticamente en políticas de Calico, configurando reglas iptables de Linux en los nodos trabajadores de Kubernetes. Las reglas iptables sirven como cortafuegos para el nodo trabajador para definir las características que debe cumplir el tráfico de red para que se reenvíe al recurso de destino.

Para utilizar los servicios de Ingress y LoadBalancer, utilice políticas de Calico y Kubernetes para gestionar el tráfico de red de entrada y salida del clúster. No utilice [grupos de seguridad](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups) de la infraestructura de IBM Cloud (SoftLayer). Los grupos de seguridad de la infraestructura de IBM Cloud (SoftLayer) se aplican a la interfaz de red de un solo servidor virtual para filtrar el tráfico en el nivel de hipervisor. Sin embargo, los grupos de seguridad no dan soporte al protocolo VRRP, que {{site.data.keyword.containerlong_notm}} utiliza para gestionar la dirección IP de LoadBalancer. Si no dispone del protocolo VRRP para gestionar la IP de LoadBalancer, los servicios Ingress y LoadBalancer no funcionan correctamente.
{: tip}

<br />


## Políticas de red de Kubernetes y Calico predeterminadas
{: #default_policy}

Cuando se crea un clúster con una VLAN pública, se crea de forma automática un recurso HostEndpont con la etiqueta `ibm.role: worker_public` para cada nodo trabajador y su interfaz de red pública. Para proteger la interfaz de red pública de un nodo trabajador, las políticas predeterminadas de Calico se aplican a todos los puntos finales de host con la etiqueta `ibm.role: worker_public`.
{:shortdesc}

Las políticas predeterminadas de Calico permiten todo el tráfico de red saliente y permiten el tráfico entrante a componentes específicos del clúster como, por ejemplo, servicios Ingress, LoadBalancer y NodePort de Kubernetes. Se bloquea el resto del tráfico de red entrante desde internet a los nodos trabajadores que no se especifica en las políticas predeterminadas. Las políticas predeterminadas no afectan al trafico entre pods.

Revise las políticas de red predeterminadas siguientes de Calico que se aplican automáticamente a su clúster.

**Importante:** No elimine las políticas que se aplican a un punto final de host a menos que conozca en profundidad la política. Asegúrese de que no necesita tráfico que la política está permitiendo.

 <table summary="La primera fila de la tabla abarca ambas columnas. Lea el resto de las filas de izquierda a derecha, con la zona de servidor en la columna uno y direcciones IP para que coincidan en la columna dos.">
 <caption>Políticas predeterminadas de Calico para cada clúster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Políticas predeterminadas de Calico para cada clúster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Permite todo el tráfico de salida.</td>
    </tr>
    <tr>
      <td><code>allow-bigfix-port</code></td>
      <td>Permite el tráfico entrante en el puerto 52311 a la app BigFix para permitir las actualizaciones necesarias del nodo trabajador.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Permite paquetes ICMP de entrada (pings).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Permite el tráfico de entrada de los servicios Ingress, LoadBalancer y NodePort en los pods que exponen dichos servicios. <strong>Nota</strong>: No necesita especificar los puertos expuestos porque Kubernetes utiliza DNAT (Destination Network Address Translation) para reenviar las solicitudes de servicio a los pods correctos. El reenvío se realiza antes de que se apliquen las políticas de punto final de host en iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Permite conexiones entrantes para sistemas de infraestructura de IBM Cloud (SoftLayer) específicos que se utilizan para gestionar los nodos trabajadores.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Permite paquetes VRRP, que se utilizan para supervisar y mover direcciones IP virtuales entre los nodos trabajadores.</td>
   </tr>
  </tbody>
</table>

En clústeres de Kubernetes versión 1.10 y posterior, también se crea una política predeterminada de Kubernetes que limita el acceso al Panel de control de Kubernetes. Las políticas de Kubernetes no se aplican al punto final de host sino que, por el contrario, al pod `kube-dashboard`. Esta política se aplica a clústeres conectados únicamente a VLAN privadas y a clústeres conectados a una VLAN privada y pública.

<table>
<caption>Políticas predeterminadas de Kubernetes para cada clúster</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Políticas predeterminadas de Kubernetes para cada clúster</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>Solo en Kubernetes v1.10</b>, proporcionado en el espacio de nombres <code>kube-system</code>: Bloquea el acceso de todos los pods al Panel de control de Kubernetes. Esta política no afecta el acceso al panel de control desde la interfaz de usuario de {{site.data.keyword.Bluemix_notm}} o utilizando <code>kubectl proxy</code>. Si un pod necesita acceder al panel de control, despliegue el pod en un espacio de nombres que tenga la etiqueta <code>kubernetes-dashboard-policy: allow</code>.</td>
 </tr>
</tbody>
</table>

<br />


## Instalación y configuración de la CLI de Calico
{: #cli_install}

Instale y configure la CLI de Calico para ver, gestionar y añadir políticas de Calico.
{:shortdesc}

La compatibilidad de las versiones de Calico para políticas y la configuración de CLI varía en función de la versión de Kubernetes del clúster. Para instalar y configurar la CLI de Calico, pulse uno de los enlaces siguientes basándose en la versión del clúster:

* [Clústeres Kubernetes versión 1.10 o posterior](#1.10_install)
* [Clústeres Kubernetes versión 1.9 o anterior](#1.9_install)

Antes de actualizar su clúster desde Kubernetes versión 1.9 o anterior a la versión 1.10 o posterior, consulte [Preparación para actualizar a Calico V3](cs_versions.html#110_calicov3).
{: tip}

### Instalación y configuración de la versión 3.1.1 de la CLI de Calico para clústeres que ejecutan Kubernetes versión 1.10 o posterior
{: #1.10_install}

Antes de empezar, [defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `ibmcloud ks cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para acceder a su portafolio de infraestructura y ejecutar mandatos de Calico en los nodos trabajadores.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

Para instalar y configurar la CLI de Calico 3.1.1:

1. [Descargue la CLI de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1).

    Si está utilizando OSX, descargue la versión `-darwin-amd64`. Si utiliza Windows, instale la CLI de Calico en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}. Esta configuración le ahorra algunos cambios en filepath cuando ejecute mandatos posteriormente. Asegúrese de guardar el archivo como `calicoctl.exe`.
    {: tip}

2. Para usuarios de OSX y Linux, siga los pasos siguientes:
    1. Mueva el archivo ejecutable al directorio _/usr/local/bin_.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS
X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Convierta en ejecutable el archivo.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Compruebe que los mandatos `calico` se han ejecutado correctamente comprobando la versión del cliente de la CLI de Calico.

    ```
    calicoctl version
    ```
    {: pre}

4. Si las políticas de red corporativas utilizan cortafuegos o proxies para impedir el acceso desde su sistema local a puntos finales públicos, [permita el acceso TCP a mandatos de Calico](cs_firewall.html#firewall).

5. Para Linux y OS X, cree el directorio `/etc/calico`. Para Windows, se puede utilizar cualquier directorio.

  ```
  sudo mkdir -p /etc/calico/
  ```
  {: pre}

6. Cree un archivo `calicoctl.cfg`.
    - Linux y OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: Cree el archivo con un editor de texto.

7. Escriba la siguiente información en el archivo <code>calicoctl.cfg</code>.

    ```
    apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Recupere `<ETCD_URL>`.

      - Linux y OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

          Salida de ejemplo:

          ```
          https://169.xx.xxx.xxx:30000
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Obtenga los valores de configuración de la correlación de configuración. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>En la sección `data`, localice el valor etcd_endpoints. Ejemplo: <code>https://169.xx.xxx.xxx:30000</code>
        </ol>

    2. Recupere `<CERTS_DIR>`, el directorio en el que se han descargado los certificados de Kubernetes.

        - Linux y OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Salida de ejemplo:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

            Ejemplo de salida:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Nota**: Para obtener la vía de acceso del directorio, elimine el nombre de archivo `kube-config-prod-<zone>-<cluster_name>.yml` del final de la salida.

    3. Recupere el valor `ca-*pem_file`.

        - Linux y OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Abra el directorio que ha recuperado en el último paso.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> Localice el archivo <code>ca-*pem_file</code>.</ol>

8. Guarde el archivo y asegúrese de que está en el directorio en el que se encuentra el archivo.

9. Compruebe que la configuración de Calico funciona correctamente.

    - Linux y OS X:

      ```
      calicoctl get nodes
      ```
      {: pre}

    - Windows:

      ```
      calicoctl get nodes --config=filepath/calicoctl.cfg
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


### Instalación y configuración de la versión 1.6.3 de la CLI de Calico para clústeres ejecutando Kubernetes versión 1.9 o anterior
{: #1.9_install}

Antes de empezar, [defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `ibmcloud ks cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para acceder a su portafolio de infraestructura y ejecutar mandatos de Calico en los nodos trabajadores.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

Para instalar y configurar la CLI de Calico 1.6.3:

1. [Descargue la CLI de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3).

    Si está utilizando OSX, descargue la versión `-darwin-amd64`. Si utiliza Windows, instale la CLI de Calico en el mismo directorio que la CLI de {{site.data.keyword.Bluemix_notm}}. Esta configuración le ahorra algunos cambios en filepath cuando ejecute mandatos posteriormente.
    {: tip}

2. Para usuarios de OSX y Linux, siga los pasos siguientes:
    1. Mueva el archivo ejecutable al directorio _/usr/local/bin_.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS
X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Convierta en ejecutable el archivo.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Compruebe que los mandatos `calico` se han ejecutado correctamente comprobando la versión del cliente de la CLI de Calico.

    ```
    calicoctl version
    ```
    {: pre}

4. Si las políticas de red corporativas utilizan cortafuegos o proxies para impedir el acceso desde su sistema local a puntos finales públicos: Consulte [Ejecución de mandatos `calicoctl` desde detrás de un cortafuegos](cs_firewall.html#firewall) para obtener instrucciones sobre cómo permitir el acceso TCP a los mandatos de Calico.

5. Para Linux y OS X, cree el directorio `/etc/calico`. Para Windows, se puede utilizar cualquier directorio.
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

6. Cree un archivo `calicoctl.cfg`.
    - Linux y OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: Cree el archivo con un editor de texto.

7. Escriba la siguiente información en el archivo <code>calicoctl.cfg</code>.

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

    1. Recupere `<ETCD_URL>`.

      - Linux y OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

      - Ejemplo de salida:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Obtenga los valores de configuración de la correlación de configuración. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>En la sección `data`, localice el valor etcd_endpoints. Ejemplo: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

    2. Recupere `<CERTS_DIR>`, el directorio en el que se han descargado los certificados de Kubernetes.

        - Linux y OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Salida de ejemplo:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

          Salida de ejemplo:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Nota**: Para obtener la vía de acceso del directorio, elimine el nombre de archivo `kube-config-prod-<zone>-<cluster_name>.yml` del final de la salida.

    3. Recupere el valor `ca-*pem_file`.

        - Linux y OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Abra el directorio que ha recuperado en el último paso.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> Localice el archivo <code>ca-*pem_file</code>.</ol>

    4. Compruebe que la configuración de Calico funciona correctamente.

        - Linux y OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

          ```
          calicoctl get nodes --config=filepath/calicoctl.cfg
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

          **Importante**: los usuarios de Windows y OS X deben incluir el
distintivo `--config=filepath/calicoctl.cfg` cada vez que ejecuten un mandato `calicoctl`.

<br />


## Visualización de políticas de red
{: #view_policies}

Consulte los detalles de políticas de red añadidas y predeterminadas que se aplican a su clúster.
{:shortdesc}

Antes de empezar:
1. [Instale y configure la CLI de Calico. ](#cli_install)
2. [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `ibmcloud ks cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para acceder a su portafolio de infraestructura y ejecutar mandatos de Calico en los nodos trabajadores.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

La compatibilidad de las versiones de Calico para políticas y la configuración de CLI varía en función de la versión de Kubernetes del clúster. Para instalar y configurar la CLI de Calico, pulse uno de los enlaces siguientes basándose en la versión del clúster:

* [Clústeres Kubernetes versión 1.10 o posterior](#1.10_examine_policies)
* [Clústeres Kubernetes versión 1.9 o anterior](#1.9_examine_policies)

Antes de actualizar su clúster desde Kubernetes versión 1.9 o anterior a la versión 1.10 o posterior, consulte [Preparación para actualizar a Calico V3](cs_versions.html#110_calicov3).
{: tip}

### Visualice las políticas de red que se ejecutan en Kubernetes versión 1.10 o posterior
{: #1.10_examine_policies}

Los usuarios de Linux y Mac no tienen que incluir el distintivo `--config=filepath/calicoctl.cfg` en los mandatos `calicoctl`.
{: tip}

1. Consultar el punto final del host de Calico.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. Consultar todas las políticas de red de Calico y de Kubernetes que se han creado para el clúster. Esta lista incluye políticas que quizás no se apliquen todavía a ningún pod o host. Para que una política de red se pueda imponer, se debe encontrar un recurso de Kubernetes que coincida con el selector definido en la política de red de Calico.

    El objeto del ámbito de las [Políticas de red ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) son espacios de nombres específicos:
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide --config=filepath/calicoctl.cfg
    ```
    {:pre}

    El objeto del ámbito de las [Políticas de red globales ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) no son espacios de nombres específicos:
    ```
    calicoctl get GlobalNetworkPolicy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Consultar los detalles correspondientes a una política de red.

    ```
    calicoctl get NetworkPolicy -o yaml <policy_name> --namespace <policy_namespace> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. Visualizar los detalles de todas las políticas de red globales del clúster.

    ```
    calicoctl get GlobalNetworkPolicy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

### Visualización de políticas de red en clústeres que ejecutan Kubernetes versión 1.9 o anterior
{: #1.9_examine_policies}

Los usuarios de Linux no tienen que incluir el distintivo `--config=filepath/calicoctl.cfg` en los mandatos `calicoctl`.
{: tip}

1. Consultar el punto final del host de Calico.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. Consultar todas las políticas de red de Calico y de Kubernetes que se han creado para el clúster. Esta lista incluye políticas que quizás no se apliquen todavía a ningún pod o host. Para que una política de red se pueda imponer, se debe encontrar un recurso de Kubernetes que coincida con el selector definido en la política de red de Calico.

    ```
    calicoctl get policy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Consultar los detalles correspondientes a una política de red.

    ```
    calicoctl get policy -o yaml <policy_name> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. Consultar los detalles de todas las políticas de red para el clúster.

    ```
    calicoctl get policy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

<br />


## Adición de políticas de red
{: #adding_network_policies}

En la mayoría de los casos, no es necesario modificar las políticas predeterminadas. Sólo en escenarios avanzados se pueden requerir cambios. Si debe realizar cambios, cree sus propias políticas de red.
{:shortdesc}

Para crear políticas de red de Kubernetes, consulte la [Documentación de políticas de red de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Siga estos pasos para crear políticas de Calico.

Antes de empezar:
1. [Instale y configure la CLI de Calico. ](#cli_install)
2. [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `ibmcloud ks cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para acceder a su portafolio de infraestructura y ejecutar mandatos de Calico en los nodos trabajadores.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

La compatibilidad de las versiones de Calico para políticas y la configuración de CLI varía en función de la versión de Kubernetes del clúster. Pulse uno de los enlaces siguientes basándose en la versión del clúster:

* [Clústeres Kubernetes versión 1.10 o posterior](#1.10_create_new)
* [Clústeres Kubernetes versión 1.9 o anterior](#1.9_create_new)

Antes de actualizar su clúster desde Kubernetes versión 1.9 o anterior a la versión 1.10 o posterior, consulte [Preparación para actualizar a Calico V3](cs_versions.html#110_calicov3).
{: tip}

### Adición de políticas de Calico en clústeres que ejecutan Kubernetes versión 1.10 o posterior
{: #1.10_create_new}

1. Defina su [política de red ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) o [política de red global ![Icono de enlace externo ](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) de Calico creando un script de configuración (`.yaml`). Estos archivos de configuración incluyen los selectores que describen los pods, espacios de nombres o hosts a los que se aplican estas políticas. Consulte estas [políticas de Calico de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) como ayuda para crear la suya propia.
    **Nota**: Los clústeres de Kubernetes versión 1.10 o posterior deben utilizar una sintaxis de política Calico v3.

2. Aplique las políticas al clúster.
    - Linux y OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

### Adición de políticas de Calico en clústeres que ejecutan Kubernetes versión 1.9 o anterior
{: #1.9_create_new}

1. Defina su [política de red de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) creando un script de configuración (`.yaml`). Estos archivos de configuración incluyen los selectores que describen los pods, espacios de nombres o hosts a los que se aplican estas políticas. Consulte estas [políticas de Calico de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) como ayuda para crear la suya propia.
    **Nota**: Los clústeres de Kubernetes versión 1.9 o anterior deben utilizar una sintaxis de política Calico v2.


2. Aplique las políticas al clúster.
    - Linux y OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

<br />


## Control del tráfico entrante a los servicios LoadBalancer o NodePort
{: #block_ingress}

[De forma predeterminada](#default_policy), los servicios NodePort y LoadBalancer de Kubernetes están diseñados para hacer que las apps estén disponibles en las interfaces de clúster privadas y pública. Sin embargo, puede utilizar políticas de Calico para bloquear el tráfico de entrada a los servicios en función del origen o el destino del tráfico.
{:shortdesc}

Un servicio LoadBalancer de Kubernetes es también un servicio NodePort. Un servicio LoadBalancer hace que la app está disponible en la dirección IP y puerto del equilibrador de carga y hace que la app está disponible en los NodePorts del servicio. Se puede acceder a los NodePorts en cada dirección IP (pública y privada) para cada nodo del clúster.

El administrador del clúster puede utilizar el bloque de políticas de red `preDNAT` de Calico:

  - Tráfico destinado a servicios NodePort. Se permite el tráfico destinado a los servicios LoadBalancer.
  - Tráfico que se basa en una dirección de origen o CIDR.

Algunos usos comunes de las políticas de red `preDNAT` de Calico:

  - Bloquear el tráfico a NodePorts públicos de un servicio LoadBalancer privado.
  - Bloquear el tráfico a NodePorts públicos en clústeres que ejecuten [nodos trabajadores de extremo](cs_edge.html#edge). El bloqueo de NodePorts garantiza que los nodos trabajadores de extremo sean los únicos nodos trabajadores que manejen el tráfico entrante.

Las políticas predeterminadas de Kubernetes y Calico son difíciles de aplicar para proteger los servicios NodePort y LoadBalancer de Kubernetes debido a las reglas iptables de DNAT que se generan para estos servicios.

Las políticas de red `preDNAT` de Calico pueden ayudar porque generan reglas de iptables con base a un recurso de política de red de Calico. Los clústeres de Kubernetes versión 1.10 o posterior utilizan [políticas de red con sintaxis `calicoctl.cfg` v3 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). Los clústeres de Kubernetes versión 1.9 o anterior utilizan [políticas con sintaxis `calicoctl.cfg` v2 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Defina una política de red `preDNAT` de Calico para el acceso de ingress (tráfico entrante) a los servicios de Kubernetes.

    * Los clústeres de Kubernetes versión 1.10 o posterior deben utilizar una sintaxis de política Calico v3.

        Ejemplo de recurso que bloquea todos los NodePorts:

        ```
        apiVersion: projectcalico.org/v3
        kind: GlobalNetworkPolicy
        metadata:
          name: deny-nodeports
        spec:
          applyOnForward: true
          ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: UDP
            source: {}
          preDNAT: true
          selector: ibm.role=='worker_public'
          order: 1100
          types:
          - Ingress
        ```
        {: codeblock}

    * Los clústeres de Kubernetes versión 1.9 o anterior deben utilizar una sintaxis de política Calico v2.

        Ejemplo de recurso que bloquea todos los NodePorts:

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-nodeports
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

  - Linux y OS X:

    ```
    calicoctl apply -f deny-nodeports.yaml
    ```
    {: pre}

  - Windows:

    ```
    calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Opcional: en los clústeres multizona, el comprobador de estado de MZLB comprueba los ALB de cada zona del clúster y mantiene actualizados los resultados de la búsqueda DNS en función de estas comprobaciones de estado. Si utiliza políticas pre-DNAT para bloquear todo el tráfico de entrada a los servicios Ingress, también debe colocar en la lista blanca las [IP IPv4 de Cloudflare ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.cloudflare.com/ips/) que se utilizan para comprobar el estado de los ALB. Para ver los pasos a seguir para crear una política pre-DNAT de Calico para colocar estas IP en la lista blanca, consulte la Lección 3 de la [guía de aprendizaje de la política de red de Calico](cs_tutorials_policies.html#lesson3).

Para ver cómo colocar direcciones IP en una lista blanca o en una lista negra, consulte la [guía de aprendizaje sobre cómo utilizar políticas de red de Calico para bloquear el tráfico](cs_tutorials_policies.html#policy_tutorial). Para ver más ejemplos de políticas de red de Calico que controlan el tráfico procedente y destinado a su clúster, puede consultar la [demostración de política inicial ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) y la [política de red avanzada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy).
{: tip}

## Aislamiento del clúster en la red privada
{: #isolate_workers}

Si tiene un clúster multizona, varias VLAN para un clúster de una sola zona o varias subredes en la misma VLAN, debe [habilitar la expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Sin embargo, cuando la expansión de VLAN está habilitada, cualquier sistema que esté conectado a cualquiera de las VLAN privadas en la misma cuenta de IBM Cloud se puede comunicar con los trabajadores.

Puede aislar el clúster de otros sistemas de la red privada aplicando [políticas de red privada de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation). Este conjunto de políticas de Calico y puntos finales de host aísla el tráfico de red privada de un clúster de otros recursos de la red privada de la cuenta.

Las políticas se dirigen a la interfaz privada de nodo trabajador (eth0) y a la red de pod de un clúster.

**Nodos trabajadores**

* La salida de interfaz privada solo se permite para las IP de pod, los trabajadores de este clúster y el puerto de UPD/TCP 53 para el acceso DNS.
* La entrada de interfaz privada solo se permite desde los trabajadores del clúster y solo a DNS, kubelet, ICMP y VRRP.

**Pods**

* Toda la entrada a los pods se permite desde los trabajadores del clúster.
* La salida de los pods está restringida solo a IP públicas, DNS, kubelet y otros pods del clúster.

Antes de empezar:
1. [Instale y configure la CLI de Calico. ](#cli_install)
2. [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `ibmcloud ks cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para acceder a su portafolio de infraestructura y ejecutar mandatos de Calico en los nodos trabajadores.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

Para aislar el clúster en la red privada mediante políticas de Calico:

1. Clone el repositorio `IBM-Cloud/kube-samples`.
    ```
    git clone https://github.com/IBM-Cloud/kube-samples.git
    ```
    {: pre}

2. Vaya al directorio de política privada para la versión de Calico con la que es compatible la versión del clúster.
    * Clústeres Kubernetes versión 1.10 o posterior:
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v3
      ```
      {: pre}

    * Clústeres Kubernetes versión 1.9 o anterior:
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v2
      ```
      {: pre}

3. Configure la política de punto final de host privado.
    1. Abra la política `generic-privatehostendpoint.yaml`.
    2. Sustituya `<worker_name>` con el nombre de un nodo trabajador y `<worker-node-private-ip>` con la dirección IP privada para el nodo trabajador. Para ver las IP privadas de los nodos trabajadores, ejecute `ibmcloud ks workers --cluster <my_cluster>`.
    3. Repita este paso en una sección nueva para cada nodo trabajador del clúster.
    **Nota**: cada vez que añade un nodo trabajador a un clúster, debe actualizar el archivo de puntos finales de host con las nuevas entradas.

4. Aplique todas las políticas al clúster.
    - Linux y OS X:

      ```
      calicoctl apply -f allow-all-workers-private.yaml
      calicoctl apply -f allow-dns-10250.yaml
      calicoctl apply -f allow-egress-pods.yaml
      calicoctl apply -f allow-icmp-private.yaml
      calicoctl apply -f allow-vrrp-private.yaml
      calicoctl apply -f generic-privatehostendpoint.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f allow-all-workers-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-dns-10250.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-egress-pods.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-icmp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-vrrp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f generic-privatehostendpoint.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

## Control del tráfico entre pods
{: #isolate_services}

Las políticas de Kubernetes protegen los pods frente al tráfico de red interno. Puede crear políticas de red de Kubernetes sencillas para aislar los microservicios de la app entre sí dentro de un espacio de nombres o entre espacios de nombres.
{: shortdesc}

Para obtener información sobre el modo en que las políticas de red de Kubernetes controlan el tráfico entre pods y para ver más políticas de ejemplo, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
{: tip}

### Aislamiento de los servicios de app dentro de un espacio de nombres
{: #services_one_ns}

En el caso de ejemplo siguiente se muestra cómo gestionar el tráfico entre los microservicios de una app dentro de un espacio de nombres.

Un equipo del departamento de cuentas despliega varios servicios de app en un espacio de nombres, pero necesitan aislamiento para permitir únicamente la comunicación necesaria entre los microservicios a través de la red pública. Para la app Srv1, el equipo tiene servicios frontales, de fondo y de base de datos. Etiquetan cada servicio con una etiqueta `app: Srv1` y con la etiqueta `tier: frontend`, `tier: backend` o `tier: db`.

<img src="images/cs_network_policy_single_ns.png" width="200" alt="Utilice una política de red paga gestionar el tráfico entre espacios de nombres." style="width:200px; border-style: none"/>

El equipo del departamento de cuentas desea permitir el tráfico procedente de un programa frontal y destinado al programa de fondo, y desde el programa de fondo a la base de datos. Utilizan etiquetas en sus políticas de red para designar los flujos de tráfico que se permiten entre los microservicios.

En primer lugar, crean una política de red de Kubernetes que permite el tráfico entre el programa frontal y el de fondo:

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

En la sección `spec.podSelector.matchLabels` se muestran las etiquetas correspondientes al servicio de fondo de Srv1 de modo que la política solo se aplique _a_ dichos pods. En la sección `spec.ingress.from.podSelector.matchLabels` se muestran las etiquetas correspondientes al servicio frontal Srv1 para que solo se permita el servicio ingress _desde_ dichos pods.

A continuación, crean una política de red de Kubernetes similar que permite el tráfico entre el programa de fondo y la base de datos:

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

En la sección `spec.podSelector.matchLabels` se muestran las etiquetas correspondientes al servicio de base de datos Srv1 de modo que la política solo se aplique _a_ dichos pods. En la sección `spec.ingress.from.podSelector.matchLabels` se muestran las etiquetas correspondientes al servicio de fondo Srv1 para que solo se permita el servicio ingress _desde_ dichos pods.

Ahora el tráfico puede fluir desea el programa frontal y destinado al programa de fondo, y desde el programa de fondo a la base de datos. La base de datos puede responder al programa de fondo y el programa de fondo puede responder al programa frontal, pero no se pueden establecer conexiones de tráfico inversas.

### Aislamiento de servicios de app entre espacios de nombres
{: #services_across_ns}

En el caso de ejemplo siguiente se muestra cómo gestionar el tráfico entre los microservicios de una app entre varios espacios de nombres.

Los servicios que son propiedad de distintos subequipos tienen que comunicarse, pero los servicios están desplegados en distintos espacios de nombres dentro del mismo clúster. El equipo de cuentas despliega servicios frontales, de fondo y de base de datos para la app Srv1 en el espacio de nombres de cuentas. El equipo de finanzas despliega servicios frontales, de fondo y de base de datos para la app Srv2 en el espacio de nombres de finanzas. Ambos equipos etiquetan cada servicio con una etiqueta `app: Srv1` o `app: Srv2` y con la etiqueta `tier: frontend`, `tier: backend` o `tier: db`. También etiquetan los espacios de nombres con la etiqueta `usage: accounts` o `usage: finance`.

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="Utilice una política de red para gestionar el tráfico entre espacios de nombres" style="width:475px; border-style: none"/>

El equipo de finanzas Srv2 necesita realizar una llamada a la información procedente del programa de fondo Srv1 del equipo de cuentas. Por lo tanto, el equipo de cuentas crea una política de red de Kubernetes que utiliza etiquetas para permitir todo el tráfico procedente del espacio de nombres de finanzas en el programa de fondo Srv1 en el espacio de nombres de cuentas. El equipo también especifica el puerto 3111 para aislar el acceso solo a través de dicho puerto.

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

En la sección `spec.podSelector.matchLabels` se muestran las etiquetas correspondientes al servicio de fondo de Srv1 de modo que la política solo se aplique _a_ dichos pods. La sección `spec.ingress.from.NamespaceSelector.matchLabels` muestra la etiqueta correspondiente al espacio de nombres de financias para que solo se permita ingress _desde_ los servicios de dicho espacio de nombres.

Ahora el tráfico puede fluir entre los microservicios financieros y el programa de fondo de cuentas Srv1. El programa de fondo Srv1 de cuentas puede responder a los microservicios de finanzas, pero no puede establecer una conexión de tráfico inversa.

**Nota**: no puede permitir el tráfico procedente de pods específicos de una app a otro espacio de nombres porque `podSelector` y `namespaceSelector` no se pueden combinar. En este ejemplo, se permite todo el tráfico procedente de todos los microservicios del espacio de nombres de finanzas.

## Registro de tráfico denegado
{: #log_denied}

Para registrar las solicitudes de tráfico denegadas a determinados pods del clúster, puede crear una política de red de registro de Calico.
{: shortdesc}

Cuando se configuran políticas de red para limitar el tráfico a los pods de app, las solicitudes de tráfico que no están permitidas por estas políticas se deniegan y se descartan. En algunos casos, quizá desee más información sobre las solicitudes de tráfico denegadas. Por ejemplo, es posible que observe algún tráfico poco habitual que una de las políticas de red deniega continuamente. Para supervisar la amenaza de seguridad potencial, puede configurar el registro para que registre todas las veces que la política deniega un intento de acción en pods de app determinados.

Antes de empezar:
1. [Instale y configure la CLI de Calico.](#cli_install) **Nota**: las políticas de estos pasos utilizan la sintaxis de Calico v3, que es compatible con los clústeres que ejecutan Kubernetes versión 1.10 o posterior. Para los clústeres que ejecutan Kubernetes versión 1.9 o anterior, debe utilizar una [sintaxis de política de Calico v2 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).
2. [Defina el clúster como destino de la CLI de Kubernetes](cs_cli_install.html#cs_cli_configure). Incluya la opción `--admin` con el mandato `ibmcloud ks cluster-config`, que se utiliza para descargar los certificados y los archivos de permiso. Esta descarga también incluye las claves para acceder a su portafolio de infraestructura y ejecutar mandatos de Calico en los nodos trabajadores.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

Para crear una política de Calico para registrar el tráfico denegado:

1. Cree o utilice una política de red de Kubernetes o Calico existente que bloquee o limite el tráfico entrante. Por ejemplo, para controlar el tráfico entre pods, puede utilizar la siguiente política de Kubernetes de ejemplo denominada `access-nginx`, que limita el acceso a una app NGINX. El tráfico de entrada a pods etiquetados como "run=nginx" solo se permite desde pods con la etiqueta "run=access". El resto del tráfico entrante a los pods de app "run = nginx" está bloqueado.
    ```
    kind: NetworkPolicy
    apiVersion: extensions/v1beta1
    metadata:
      name: access-nginx
    spec:
      podSelector:
        matchLabels:
          run: nginx
      ingress:
        - from:
          - podSelector:
              matchLabels:
                run: access
    ```
    {: codeblock}

2. Aplique la política.
    * Para aplicar una política de Kubernetes:
        ```
        kubectl apply -f <policy_name>.yaml
        ```
        {: pre}
        La política de Kubernetes se convierte automáticamente en una NetworkPolicy de Calico para que Calico pueda aplicarla como reglas de iptables.

    * Para aplicar una política de Calico:
        ```
        calicoctl apply -f <policy_name>.yaml --config=<filepath>/calicoctl.cfg
        ```
        {: pre}

3. Si ha aplicado una política de Kubernetes, revise la sintaxis de la política de Calico creada automáticamente y copie el valor del campo `spec.selector`.
    ```
    calicoctl get policy -o yaml <policy_name> --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

    Por ejemplo, una vez aplicada y convertida, la política `access-nginx` tiene la siguiente sintaxis de Calico v3. El campo `spec.selector` tiene el valor `projectcalico.org/orchestrator == 'k8s' && run == 'nginx'`.
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: access-nginx
    spec:
      ingress:
      - action: Allow
        destination: {}
        source:
          selector: projectcalico.org/orchestrator == 'k8s' && run == 'access'
      order: 1000
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      types:
      - Ingress
    ```
    {: screen}

4. Para registrar todo el tráfico que ha denegado la política de Calico que ha creado anteriormente, cree una NetworkPolicy de Calico denominada `log-denied-packets`. Por ejemplo, utilice la política siguiente para registrar todos los paquetes que ha denegado la política de red que ha definido en el paso 1. La política de registro utiliza el mismo selector de pod que la política `access-nginx` de ejemplo, que añade esta política a la cadena de reglas de iptables de Calico. Al utilizar un número de orden superior, por ejemplo `3000`, puede asegurarse de que esta regla se añada al final de la cadena de reglas de iptables. Cualquier paquete de solicitud del pod "run=access" que coincida con la regla de política `access-nginx` será aceptado por los pods "run=nginx". Sin embargo, cuando los paquetes de cualquier otro origen intentan coincidir con la regla de política `access-nginx` de orden inferior, son denegados. Estos paquetes intentan entonces coincidir con la regla de política `log-denied-packets`. `log-denied-packets` registra todos los paquetes que le llegan, de modo que solo se registran los paquetes que han denegado los pods "run=nginx". Una vez registrados los intentos de los paquetes, se descartan los paquetes.
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: log-denied-packets
    spec:
      types:
      - Ingress
      ingress:
      - action: Log
        destination: {}
        source: {}
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      order: 3000
    ```
    {: codeblock}

    <table>
    <caption>Descripción de los componentes de YAML de política de registro</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Descripción de los componentes de YAML de política de registro</th>
    </thead>
    <tbody>
    <tr>
     <td><code>types</code></td>
     <td>Esta política de <code>Ingress</code> aplica las solicitudes de tráfico entrantes. <strong>Nota:</strong> el valor <code>Ingress</code> es un término general para todo el tráfico de entrada, y no hace referencia solo al tráfico procedente del ALB de IBM Ingress.</td>
    </tr>
     <tr>
      <td><code>ingress</code></td>
      <td><ul><li><code>action</code>: la acción <code>Log</code> graba una entrada de registro para cualquier solicitud que coincida con esta política en la vía de acceso `/var/log/syslog` en el nodo trabajador.</li><li><code>destination</code>: no se ha especificado ningún destino porque el <code>selector</code> aplica esta política a todos los pods con una etiqueta determinada.</li><li><code>source</code>: esta política se aplica a las solicitudes procedentes de cualquier origen.</td>
     </tr>
     <tr>
      <td><code>selector</code></td>
      <td>Sustituya &lt;selector&gt; con el mismo selector en el campo `spec.selector` que ha utilizado en la política de Calico en el paso 1 o que ha encontrado en la sintaxis de Calico para la política de Kubernetes en el paso 3. Por ejemplo, mediante el selector <code>selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'</code>, la regla de esta política se añade a la misma cadena de iptables que la regla de política de red de ejemplo <code>access-nginx</code> del paso 1. Esta política se aplica únicamente al tráfico de red entrante a pods que utilizan la misma etiqueta de selector de pod.</td>
     </tr>
     <tr>
      <td><code>order</code></td>
      <td>Las políticas de Calico tienen un orden que determina cuándo se aplican a los paquetes de solicitud entrantes. Las políticas con un orden más bajo, como por ejemplo <code>1000</code>, se aplican primero. Las políticas con un orden más alto se aplican después de las políticas de orden más bajo. Por ejemplo, una política con un orden muy alto, como <code>3000</code>, se aplica de forma efectiva después de aplicar todas las políticas de orden inferior.</br></br>Los paquetes de solicitud entrantes pasan por la cadena de reglas de iptables e intentan coincidir con las reglas de las políticas de orden inferior en primer lugar. Si un paquete coincide con alguna regla, se acepta. Sin embargo, si un paquete no coincide con ninguna regla, llega a la última regla de la cadena de reglas de iptables con el orden más alto. Para asegurarse de que se trata de la última política de la cadena, utilice un orden mucho más alto, como <code>3000</code>, que la política que ha creado en el paso 1.</td>
     </tr>
    </tbody>
    </table>

5. Aplique la política.
    ```
    calicoctl apply -f log-denied-packets.yaml --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

6. [Reenvíe los registros](cs_health.html#configuring) de `/var/log/syslog` a {{site.data.keyword.loganalysislong}} o a un servidor syslog externo.
