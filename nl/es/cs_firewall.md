---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

---

{:new_window: target="_blank"}
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




# Apertura de los puertos y direcciones IP necesarios en el cortafuegos
{: #firewall}

Revise estas situaciones en las que puede tener que abrir puertos específicos y direcciones IP en el cortafuegos para {{site.data.keyword.containerlong}}.
{:shortdesc}

* [Para ejecutar mandatos `ibmcloud` ](#firewall_bx)desde el sistema local cuando las políticas de red corporativas impiden el acceso a los puntos finales de internet pública mediante proxies o cortafuegos.
* [Para ejecutar mandatos `kubectl` ](#firewall_kubectl)desde el sistema local cuando las políticas de red corporativas impiden el acceso a los puntos finales de internet pública mediante proxies o cortafuegos.
* [Para ejecutar mandatos `calicoctl` ](#firewall_calicoctl)desde el sistema local cuando las políticas de red corporativas impiden el acceso a los puntos finales de internet pública mediante proxies o cortafuegos.
* [Para permitir la comunicación entre el maestro de Kubernetes y los nodos trabajadores](#firewall_outbound) cuando hay un cortafuegos configurado para los nodos trabajadores o los valores del cortafuegos están personalizados en su cuenta de infraestructura de IBM Cloud (SoftLayer).
* [Para permitir que el clúster acceda a los recursos a través de un cortafuegos en la red privada](#firewall_private).
* [Para acceder al servicio NodePort, equilibrador de carga o Ingress desde fuera del clúster](#firewall_inbound).

<br />


## Ejecución de mandatos `ibmcloud` desde detrás de un cortafuegos
{: #firewall_bx}

Si las políticas de red corporativas impiden el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos, para ejecutar mandatos `ibmcloud ks` debe permitir el acceso TCP para {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

1. Permita el acceso a `containers.bluemix.net` en el puerto 443.
2. Compruebe la conexión. Si el acceso está configurado correctamente, los envíos se visualizan en la salida.
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   Salida de ejemplo:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

<br />


## Ejecución de mandatos `kubectl` desde detrás de un cortafuegos
{: #firewall_kubectl}

Si las políticas de red corporativas impiden el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos, para ejecutar mandatos `kubectl` debe permitir el acceso TCP para el clúster.
{:shortdesc}

Cuando se crea un clúster, el puerto del URL maestro se asigna aleatoriamente entre 20000 y 32767. Puede elegir abrir el rango de puerto 20000-32767 para cualquier clúster que se pueda crear o permitir el acceso a un clúster existente específico.

Antes de empezar, permita el acceso para [ejecutar mandatos `ibmcloud ks`](#firewall_bx).

Para permitir el acceso a un clúster específico:

1. Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Escriba
sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite. Si tiene una cuenta federada, incluya la opción `--sso`.

   ```
   ibmcloud login [--sso]
   ```
   {: pre}

2. Si el clúster está en un grupo de recursos distinto de `default`, elija como destino dicho grupo de recursos. Para ver el grupo de recursos al que pertenece cada clúster, ejecute `ibmcloud ks clusters`. **Nota**: debe tener al menos el [rol de **Visor**](cs_users.html#platform) para el grupo de recursos.
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

2. Seleccione la región en la que está el clúster.

   ```
   ibmcloud ks region-set
   ```
   {: pre}

3. Obtenga el nombre del clúster.

   ```
   ibmcloud ks clusters
   ```
   {: pre}

4. Recupere el **URL maestro** del clúster.

   ```
   ibmcloud ks cluster-get <cluster_name_or_ID>
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ...
   Master URL:		https://c3.<region>.containers.cloud.ibm.com
   ...
   ```
   {: screen}

5. Permitir el acceso al **URL maestro** en el puerto, como en el puerto `31142` en el ejemplo anterior.

6. Compruebe la conexión.

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   Mandato de ejemplo:
   ```
   curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
   ```
   {: pre}

   Salida de ejemplo:
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. Opcional: repita estos pasos para cada clúster que necesite exponer.

<br />


## Ejecución de mandatos `calicoctl` desde detrás de un cortafuegos
{: #firewall_calicoctl}

Si las políticas de red corporativas impiden el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos, para ejecutar mandatos `calicoctl` debe permitir el acceso TCP para los mandatos Calico.
{:shortdesc}

Antes de empezar, permita el acceso para ejecutar mandatos [`ibmcloud`](#firewall_bx) y mandatos [`kubectl`](#firewall_kubectl).

1. Recupere la dirección IP del URL maestro que ha utilizado para permitir los mandatos [`kubectl`](#firewall_kubectl).

2. Obtenga el puerto para ETCD.

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. Permita el acceso para las políticas de Calico mediante la dirección IP del URL maestro y el puerto ETCD.

<br />


## Cómo permitir al clúster acceder a recursos de infraestructura y otros servicios
{: #firewall_outbound}

Permita que el clúster acceda a servicios y recursos de infraestructura desde detrás de un cortafuegos, como para las regiones de {{site.data.keyword.containerlong_notm}}, {{site.data.keyword.registrylong_notm}}, {{site.data.keyword.monitoringlong_notm}}, {{site.data.keyword.loganalysislong_notm}}, IP privadas de infraestructura de IBM Cloud (SoftLayer) y de salida para reclamaciones de volumen persistente.
{:shortdesc}

1.  Anote la dirección IP pública de todos sus nodos trabajadores del clúster.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2.  Permita el tráfico de red de salida del origen _<each_worker_node_publicIP>_ al rango de puertos TCP/UDP de destino 20000-32767 y al puerto 443, y a las siguientes direcciones IP y grupos de red. Si tiene un cortafuegos corporativo que impide a la máquina local acceder a puntos finales de Internet pública, realice este paso para los nodos trabajadores de origen y para la máquina local.

    También debe permitir el tráfico de salida al puerto 443 y a todas las zonas entre una región y otra para equilibrar la carga durante el proceso de arranque. Por ejemplo, si el clúster está en EE.UU. sur, debe permitir el tráfico procedente desde las IP públicas de cada uno de los nodos trabajadores al puerto 443 de la dirección IP para todas las zonas.
    {: important}

    <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas deben leerse de izquierda a derecha, con la zona de servidor en la columna una y las direcciones IP coincidentes en la columna dos.">
    <caption>Direcciones IP para abrir para el tráfico saliente</caption>
        <thead>
        <th>Región</th>
        <th>Zona</th>
        <th>Dirección IP</th>
        </thead>
      <tbody>
        <tr>
          <td>AP norte</td>
          <td>che01<br>hkg02<br>seo01<br>sng01<br>tok02, tok04, tok05</td>
          <td><code>169.38.70.10</code><br><code>169.56.132.234</code><br><code>169.56.69.242</code><br><code>161.202.186.226</code><br><code>161.202.126.210, 128.168.71.117, 165.192.69.69</code></td>
         </tr>
        <tr>
           <td>AP sur</td>
           <td>mel01<br>syd01, syd04</td>
           <td><code>168.1.97.67</code><br><code>168.1.8.195, 130.198.66.26, 168.1.12.98, 130.198.64.19</code></td>
        </tr>
        <tr>
           <td>UE central</td>
           <td>ams03<br>mil01<br>osl01<br>par01<br>fra02, fra04, fra05</td>
           <td><code>169.50.169.110, 169.50.154.194</code><br><code>159.122.190.98, 159.122.141.69</code><br><code>169.51.73.50</code><br><code>159.8.86.149, 159.8.98.170</code><br><code>169.50.56.174, 161.156.65.42, 149.81.78.114</code></td>
          </tr>
        <tr>
          <td>RU sur</td>
          <td>lon02, lon04, lon05, lon06</td>
          <td><code>159.122.242.78, 158.175.111.42, 158.176.94.26, 159.122.224.242, 158.175.65.170, 158.176.95.146</code></td>
        </tr>
        <tr>
          <td>EE.UU. este</td>
           <td>mon01<br>tor01<br>wdc04, wdc06, wdc07</td>
           <td><code>169.54.126.219</code><br><code>169.53.167.50</code><br><code>169.63.88.186, 169.60.73.142, 169.61.109.34, 169.63.88.178, 169.60.101.42, 169.61.83.62</code></td>
        </tr>
        <tr>
          <td>EE.UU. sur</td>
          <td>hou02<br>sao01<br>sjc03<br>sjc04<br>dal10,dal12,dal13</td>
          <td><code>184.173.44.62</code><br><code>169.57.151.10</code><br><code>169.45.67.210</code><br><code>169.62.82.197</code><br><code>169.46.7.238, 169.48.230.146, 169.61.29.194, 169.46.110.218, 169.47.70.10, 169.62.166.98, 169.48.143.218, 169.61.177.2, 169.60.128.2</code></td>
        </tr>
        </tbody>
      </table>

3.  Permita el tráfico de red de salida de los nodos trabajadores a regiones de [{{site.data.keyword.registrylong_notm}}](/docs/services/Registry/registry_overview.html#registry_regions):
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - Sustituya <em>&lt;registry_publicIP&gt;</em> por las direcciones IP de registro a las que desea permitir el tráfico. El registro global almacena imágenes públicas proporcionadas por IBM y los registros regionales almacenan sus propias imágenes privadas o públicas.
      <p>
<table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas deben leerse de izquierda a derecha, con la zona de servidor en la columna una y las direcciones IP coincidentes en la columna dos.">
  <caption>Direcciones IP para abrir para el tráfico de registro</caption>
      <thead>
        <th>Región de {{site.data.keyword.containerlong_notm}}</th>
        <th>Dirección de registro</th>
        <th>Dirección IP de registro</th>
      </thead>
      <tbody>
        <tr>
          <td>Registro global a través de regiones de {{site.data.keyword.containerlong_notm}}</td>
          <td>registry.bluemix.net</td>
          <td><code>169.60.72.144/28</code></br><code>169.61.76.176/28</code></br><code>169.62.37.240/29</code></br><code>169.60.98.80/29</code></br><code>169.63.104.232/29></code></td>
        </tr>
        <tr>
          <td>AP norte, AP sur</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></br><code>168.1.1.240/29</code></br><code>130.198.88.128/29</code></td>
        </tr>
        <tr>
          <td>UE central</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></br><code>169.50.58.104/29</code></br><code>161.156.93.16/29</code></br><code>149.81.79.152/29</code></td>
         </tr>
         <tr>
          <td>RU sur</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></br><code>158.175.97.184/29</code></br><code>158.176.105.64/29</code></br><code>141.125.71.136/29</code></td>
         </tr>
         <tr>
          <td>EE.UU. este, EE.UU. sur</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></br><code>169.61.234.224/29</code></br><code>169.61.135.160/29</code></br><code>169.61.46.80/29</code></td>
         </tr>
        </tbody>
      </table>
</p>

4.  Opcional: Permita el tráfico de red de salida de los nodos trabajadores a los servicios {{site.data.keyword.monitoringlong_notm}},
{{site.data.keyword.loganalysislong_notm}} y LogDNA:
    *   **{{site.data.keyword.monitoringlong_notm}}**:
        <pre class="screen">TCP port 443, port 9095 FROM &lt;each_worker_node_public_IP&gt; TO &lt;monitoring_public_IP&gt;</pre>
        Sustituya <em>&lt;monitoring_public_IP&gt;</em> por todas las direcciones de las regiones de supervisión a las que desea permitir el tráfico:
        <p><table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas deben leerse de izquierda a derecha, con la zona de servidor en la columna una y las direcciones IP coincidentes en la columna dos.">
  <caption>Direcciones IP para abrir para el tráfico de supervisión</caption>
        <thead>
        <th>Región de {{site.data.keyword.containerlong_notm}}</th>
        <th>Dirección de supervisión</th>
        <th>Direcciones IP de supervisión</th>
        </thead>
      <tbody>
        <tr>
         <td>UE central</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>RU sur</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>EE.UU. este, EE.UU. sur, AP norte, AP sur</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    *   **{{site.data.keyword.loganalysislong_notm}}**:
        <pre class="screen">TCP port 443, port 9091 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logging_public_IP&gt;</pre>
        Sustituya <em>&lt;logging_public_IP&gt;</em> por todas las direcciones de las regiones de registro a las que desea permitir el tráfico:
        <p><table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas deben leerse de izquierda a derecha, con la zona de servidor en la columna una y las direcciones IP coincidentes en la columna dos.">
<caption>Direcciones IP para abrir para el tráfico de creación de registros</caption>
        <thead>
        <th>Región de {{site.data.keyword.containerlong_notm}}</th>
        <th>Dirección de registro</th>
        <th>Direcciones IP de registro</th>
        </thead>
        <tbody>
          <tr>
            <td>EE.UU. este, EE.UU. sur</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
          </tr>
          <tr>
           <td>RU sur</td>
           <td>ingest.logging.eu-gb.bluemix.net</td>
           <td><code>169.50.115.113</code></td>
          </tr>
          <tr>
           <td>UE central</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>AP sur, AP norte</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>
    *   **{{site.data.keyword.la_full_notm}}**:
        <pre class="screen">TCP port 443, port 80 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logDNA_public_IP&gt;</pre>
        Sustituya `<logDNA_public_IP>` por las [direcciones IP de LogDNA](/docs/services/Log-Analysis-with-LogDNA/network.html#ips).

5. Si utiliza los servicios del equilibrador de carga, asegúrese de que todo el tráfico que utiliza el protocolo VRRP esté permitido entre los nodos trabajadores en las interfaces públicas y privadas. {{site.data.keyword.containerlong_notm}} utiliza el protocolo VRRP para gestionar direcciones IP para equilibradores de carga públicos y privados.

6. {: #pvc}Para crear reclamaciones de volúmenes persistentes para el almacenamiento de datos, permita el acceso de salida a través del cortafuegos a la infraestructura de IBM Cloud (SoftLayer):
    - Permita el acceso al punto final de API de la infraestructura de IBM Cloud (SoftLayer) para iniciar las solicitudes de suministro:
`TCP port 443 FROM <each_worker_node_public_IP> TO 66.228.119.120`.
    - Permita el acceso al rango de IP de la infraestructura de IBM Cloud (SoftLayer) para la zona en la que se encuentra el clúster para la
[**Red (pública) frontal**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#frontend-public-network) y la [**Red (privada) de fondo**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network). Para buscar la zona del clúster, ejecute `ibmcloud ks clusters`.

<br />


## Cómo permitir que el clúster acceda a recursos a través de un cortafuegos privado
{: #firewall_private}

Si tiene un cortafuegos en la red privada, permita la comunicación entre los nodos trabajadores y deje que el clúster acceda a los recursos de la infraestructura a través de la red privada.
{:shortdesc}

1. Permita todo el tráfico entre nodos trabajadores.
    1. Permita todo el tráfico TCP, UDP, VRRP e IPEncap entre los nodos trabajadores en las interfaces públicas y privadas. {{site.data.keyword.containerlong_notm}} utiliza el protocolo VRRP para gestionar direcciones IP para equilibradores de carga privados y el protocolo IPEncap para permitir el tráfico de pod a pod entre subredes.
    2. Si utiliza políticas de Calico, o si tiene cortafuegos en cada zona de un clúster multizona, un cortafuegos puede bloquear la comunicación entre nodos trabajadores. Debe abrir todos los nodos trabajadores del clúster entre sí utilizando los puertos de los trabajadores, las direcciones IP privadas de los trabajadores o la etiqueta de nodo trabajador de Calico.

2. Permita los rangos de IP privados de la infraestructura de IBM Cloud (SoftLayer) para poder crear nodos trabajadores en el clúster.
    1. Permita los rangos de IP privados adecuados de la infraestructura de IBM Cloud (SoftLayer). Consulte [Red (privada) de fondo](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network).
    2. Permita los rangos de IP privados de la infraestructura de IBM Cloud (SoftLayer) para todas las [zonas](cs_regions.html#zones) que está utilizando. Tenga en cuenta que debe añadir IP para las zonas `dal01` y `wdc04`. Consulte [Red de servicio (en red de fondo/privada)](/docs/infrastructure/hardware-firewall-dedicated/ips.html#service-network-on-backend-private-network-).

3. Abra los puertos siguientes:
    - Permita las conexiones TCP y UDP de salida de los nodos trabajadores a los puertos 80 y 443 para permitir actualizaciones y recargas de nodos trabajadores.
    - Permita TCP y UDP de salida al puerto 2049 para permitir el almacenamiento de archivos de montaje como volúmenes.
    - Permita TCP de salida y UDP al puerto 3260 para la comunicación con el almacenamiento en bloque.
    - Permita las conexiones TCP y UDP de entrada al puerto 10250 para el panel de control de Kubernetes y los mandatos como `kubectl logs` y `kubectl exec`.
    - Permita las conexiones de entrada y salida al puerto 53 TCP y UDP para el acceso de DNS.

4. Si también tiene un cortafuegos en la red pública, o si tiene un clúster sólo de VLAN privada y está utilizando un dispositivo de pasarela como cortafuegos, también debe permitir las IP y los puertos especificados en [Cómo permitir al clúster acceder a recursos de infraestructura y otros servicios](#firewall_outbound).

<br />


## Acceso a servicios NodePort, de equilibrador de carga e Ingress desde fuera del clúster
{: #firewall_inbound}

Puede permitir el acceso a servicios NodePort, de equilibrador de carga e Ingress.
{:shortdesc}

<dl>
  <dt>Servicio NodePort</dt>
  <dd>Abra el puerto que ha configurado cuando ha desplegado el servicio a las direcciones IP públicas para permitir el tráfico a todos los nodos trabajadores. Para encontrar el puerto, ejecute `kubectl get svc`. El puerto está en el rango 20000-32000.<dd>
  <dt>Servicio equilibrador de carga</dt>
  <dd>Abra el puerto que ha configurado cuando ha desplegado el servicio a la dirección IP pública del servicio de equilibrador de carga.</dd>
  <dt>Ingress</dt>
  <dd>Abra el puerto 80 para HTTP o el puerto 443 para HTTPS a la dirección IP del equilibrador de carga de aplicación de Ingress.</dd>
</dl>
