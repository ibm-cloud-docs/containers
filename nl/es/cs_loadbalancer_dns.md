---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb, health check, dns, host name

subcollection: containers

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
{:preview: .preview}


# Registro de un nombre de host de NLB
{: #loadbalancer_hostname}

Una vez haya configurado los equilibradores de carga de red (NLB), puede crear entradas de DNS para las IP de NLB creando nombres de host. También puede configurar los supervisores de TCP/HTTP (S) para comprobar el estado de las direcciones IP de NLB detrás de cada nombre de host.
{: shortdesc}

<dl>
<dt>Nombre de host</dt>
<dd>Cuando se crea un NLB público en un clúster de una sola zona o multizona, se puede exponer la app a Internet creando un nombre de host para la dirección IP del NLB. Además, {{site.data.keyword.cloud_notm}} se ocupa de la generación y mantenimiento del certificado SSL de comodín para el nombre de host.
<p>En clústeres multizona, se puede crear un nombre de host y, en cada zona, añadir la dirección IP de NLB a esa entrada de DNS de nombre de host. Por ejemplo, si ha desplegado varios NLB para su app en tres zonas en el EE.UU. sur, puede crear el nombre de host `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` para las tres direcciones IP de NLB. Cuando un usuario accede al nombre de host de su app, el cliente accede a una de estas direcciones IP al azar y la solicitud se envía a ese NLB.</p>
Tenga en cuenta que actualmente no puede crear nombres de host para NLB privados.</dd>
<dt>Supervisor de comprobación de estado</dt>
<dd>Habilite las comprobaciones de estado en las direcciones IP de NLB detrás de un nombre de host para determinar si están disponibles o no. Cuando se habilita un supervisor para el nombre de host, el supervisor de estado comprueba cada IP de NLB y mantiene actualizados los resultados de búsqueda de DNS en base a estas comprobaciones de estado. Por ejemplo, si los NLB tienen las direcciones IP `1.1.1.1`, `2.2.2.2` y `3.3.3.3`, una operación normal de búsqueda de DNS devuelve las 3 IP y el cliente accede a 1 de ellas de forma aleatoria. Si el NLB con la dirección IP `3.3.3.3` deja de estar disponible por cualquier motivo, por ejemplo debido a una anomalía de zona, la comprobación de estado de esa IP falla, el supervisor elimina la IP fallida del nombre de host y la búsqueda de DNS devuelve sólo las IP en buen estado, `1.1.1.1` y `2.2.2.2`.</dd>
</dl>

Puede ver todos los nombres de host que están registrados para las IP de NLB en el clúster, ejecutando el mandato siguiente.
```
ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
```
{: pre}

</br>

## Registro de las IP de NLB en un nombre de host DNS
{: #loadbalancer_hostname_dns}

Exponga la app a la Internet pública creando un nombre de host para la dirección IP del equilibrador de carga de red (NLB).
{: shortdesc}

Antes de empezar:
* Revise las consideraciones y limitaciones siguientes.
  * Puede crear nombres de host para NLB públicos versión 1.0 y 2.0.
  * Actualmente no puede crear nombres de host para NLB privados.
  * Puede registrar hasta 128 nombres de host. Este límite se puede aumentar a petición abriendo un [caso de soporte](/docs/get-support?topic=get-support-getting-customer-support).
* [Cree un NLB para la app en un clúster de una sola zona](/docs/containers?topic=containers-loadbalancer#lb_config) o [cree NLB en cada zona de un clúster multizona](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

Para crear un nombre de host para una o varias direcciones IP de NLB:

1. Obtenga la dirección **EXTERNAL-IP** para su NLB. Si tiene NLB en cada zona de un clúster multizona que expone una app, obtenga los IP para cada NLB.
  ```
  kubectl get svc
  ```
  {: pre}

  En la siguiente salida de ejemplo, las **EXTERNAL-IP** de NLB son `168.2.4.5` y `88.2.4.5`.
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. Registre la IP creando un nombre de host DNS. Recuerde que inicialmente puede crear el nombre de host con una sola dirección IP.
  ```
  ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <NLB_IP>
  ```
  {: pre}

3. Verifique que se ha creado el nombre de host.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Salida de ejemplo:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. Si tiene NLB en cada zona de un clúster multizona que expone una app, añada las IP de los otros NLB al nombre de host. Tenga en cuenta que debe ejecutar el siguiente mandato para cada dirección IP que desee añadir.
  ```
  ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
  ```
  {: pre}

5. Opcional: verifique que las IP están registradas con el nombre de host ejecutando `host` o `ns lookup`.
  Mandato de ejemplo:
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  Salida de ejemplo:
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. En un navegador web, escriba el URL para acceder a la app a través del nombre de host que ha creado.

A continuación, puede [habilitar comprobaciones de estado en el nombre de host mediante la creación de un supervisor de estado](#loadbalancer_hostname_monitor).

</br>

## Formato del nombre de host
{: #loadbalancer_hostname_format}

Los nombres de host para los NLB siguen el formato `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

Por ejemplo un nombre de host que haya creado para un NLB podría ser así: `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. En la tabla siguiente se describe cada componente del nombre de host.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Formato del nombre de host de LB</th>
</thead>
<tbody>
<tr>
<td><code>&lt;cluster_name&gt;</code></td>
<td>El nombre del clúster.
<ul><li>Si el nombre del clúster tiene 26 caracteres o menos, se incluye todo el nombre de clúster y no se modifica: <code>myclustername</code>.</li>
<li>Si el nombre del clúster tiene 26 caracteres o más y es exclusivo en esta región, sólo se utilizan los primeros 24 caracteres del nombre de clúster: <code>myveryverylongclusternam</code>.</li>
<li>Si el nombre del clúster tiene 26 caracteres o más y existe otro clúster con el mismo nombre en esta región, sólo se utilizan los primeros 17 caracteres del nombre de clúster y se añade un guión con seis caracteres aleatorios: <code>myveryverylongclu-ABC123</code>.</li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>Se crea un HASH globalmente exclusivo para su cuenta de {{site.data.keyword.cloud_notm}}. Todos los nombres de host que cree para NLB en clústeres de su cuenta utilizan este HASH globalmente exclusivo.</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
El primer y segundo caracteres, <code>00</code>, indican un nombre de host público. Los caracteres tercero y cuarto, como por ejemplo <code>01</code> u otro número, actúan de contador para cada nombre de host que cree.</td>
</tr>
<tr>
<td><code>&lt;region&gt;</code></td>
<td>La región donde se ha creado el clúster.</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>El subdominio de los nombres de host de {{site.data.keyword.containerlong_notm}}.</td>
</tr>
</tbody>
</table>

</br>

## Habilitar comprobaciones de estado en un nombre de host creando un supervisor de estado.
{: #loadbalancer_hostname_monitor}

Habilite las comprobaciones de estado en las direcciones IP de NLB detrás de un nombre de host para determinar si están disponibles o no.
{: shortdesc}

Antes de empezar, [registre las IP de NLB en un nombre de host de DNS](#loadbalancer_hostname_dns).

1. Obtenga el nombre del nombre de host. En la salida, observe que el host tiene el **Estado** de supervisor `Unconfigured`.
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Salida de ejemplo:
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. Cree un supervisor de comprobación de estado para el nombre de host. Si no incluye un parámetro de configuración, se utiliza el valor predeterminado.
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>Descripción de los componentes de este mandato</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;cluster_name_or_ID&gt;</code></td>
  <td>Obligatorio: El nombre o el ID del clúster en el que está registrado el nombre de host.</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;host_name&gt;</code></td>
  <td>Obligatorio: El nombre de host para el que desea habilitar un supervisor de comprobación de estado.</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>Obligatorio: Habilitar el supervisor de comprobación de estado para el nombre de host.</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>Una descripción del monitor de estado.</td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>El protocolo a utilizar para la comprobación de estado: <code>HTTP</code>, <code>HTTPS</code> o <code>TCP</code>. Valor predeterminado: <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>El método a utilizar para la comprobación de estado. Valor predeterminado para <code>type</code> <code>HTTP</code> y <code>HTTPS</code>: <code>GET</code>. Valor predeterminado para <code>type</code> <code>TCP</code>: <code>connection_established</code></td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td>Cuando <code>type</code> es <code>HTTPS</code>: La vía de acceso del punto final contra el que se realizará la comprobación de estado. Valor predeterminado: <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>El tiempo de espera, en segundos, antes de considerar la IP en mal estado. Valor predeterminado: <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>Cuando se excede el tiempo de espera, el número de reintentos llevarán a cabo antes de considerar la IP en mal estado. Los reintentos se realizan inmediatamente. Valor predeterminado: <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>El intervalo, en segundos, entre cada comprobación de estado. Los intervalos cortos pueden mejorar el tiempo de migración tras error, pero aumentar la carga en los IP. Valor predeterminado: <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>El número de puerto al que conectar para la comprobación de estado. Cuando <code>type</code> es <code>TCP</code>, este parámetro es obligatorio. Cuando <code>type</code> es <code>HTTP</code> o <code>HTTPS</code>, sólo es necesario definir el puerto si se utiliza un puerto distinto de 80 para HTTP o de 443 para HTTPS. Valor predeterminado para TCP: <code>0</code>. Valor predeterminado para HTTP: <code>80</code>. Valor predeterminado para HTTPS: <code>443</code>.</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td>Cuando <code>type</code> es <code>HTTP</code> o <code>HTTPS</code>: una subserie no sensible a las mayúsculas y minúsculas que la comprobación de estado busca en el cuerpo de la respuesta. Si no se encuentra esta serie, se considera que la IP está en mal estado.</td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td>Cuando <code>type</code> es <code>HTTP</code> o <code>HTTPS</code>: códigos HTTP que la comprobación de estado busca en la respuesta. Si no se encuentra el código HTTP, se considera que la IP está en mal estado. Valor predeterminado: <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td>Cuando <code>type</code> es <code>HTTP</code> o <code>HTTPS</code>: se establece en <code>true</code> para no validar el certificado.</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td>Cuando <code>type</code> es <code>HTTP</code> o <code>HTTPS</code>: se establece en <code>true</code> para seguir cualquier redirección que devuelva la IP.</td>
  </tr>
  </tbody>
  </table>

  Mandato de ejemplo:
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60 --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. Verifique que el monitor de comprobación de estado esté configurado con los valores correctos.
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Salida de ejemplo:
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. Visualice el estado de comprobación de estado de las IP de NLB que están detrás del nombre de host.
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Salida de ejemplo:
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### Actualización y eliminación de IP y supervisores de los nombres de host
{: #loadbalancer_hostname_delete}

Puede añadir y eliminar direcciones IP de NLB de los nombres de host que ha generado. También puede inhabilitar y habilitar supervisores de comprobación de estado para los nombres de host según sea necesario.
{: shortdesc}

**IP de NLB**

Si posteriormente añade más NLB en otras zonas del clúster para exponer la misma app, puede añadir las IP de NLB al nombre de host existente. Tenga en cuenta que debe ejecutar el siguiente mandato para cada dirección IP que desee añadir.
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

También puede eliminar las direcciones IP de los NLB que ya no desee que estén registradas en un nombre de host. Tenga en cuenta que debe ejecutar el siguiente mandato para cada dirección IP que desee eliminar. Si elimina todas las IP de un nombre de host, el nombre de host sigue existiendo, pero no hay ninguna IP asociada al mismo.
```
ibmcloud ks nlb-dns-rm --cluster <cluster_name_or_id> --ip <ip1,ip2> --nlb-host <host_name>
```
{: pre}

</br>

**Supervisores de comprobación de estado**

Si tiene que cambiar la configuración del supervisor de estado, puede cambiar los valores específicos. Incluya sólo los distintivos para los valores que desee cambiar.
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

Puede inhabilitar el supervisor de comprobación de estado para un nombre de host en cualquier momento ejecutando el mandato siguiente:
```
ibmcloud ks nlb-dns-monitor-disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

Para volver a habilitar un supervisor para un nombre de host, ejecute el mandato siguiente:
```
ibmcloud ks nlb-dns-monitor-enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}
