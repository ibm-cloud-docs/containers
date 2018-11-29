---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Registro de cambios de CLI
{: #cs_cli_changelog}

En el terminal, se le notifica cuando están disponibles las actualizaciones de la CLI y los plug-ins de `ibmcloud`. Asegúrese de mantener actualizada la CLI para poder utilizar todos los mandatos y distintivos disponibles.
{:shortdesc}

Para instalar el plugin de CLI, consulte [Instalación de la CLI](cs_cli_install.html#cs_cli_install_steps).

Consulte la tabla siguiente para ver un resumen de cambios para cada versión del plugin de CLI.

<table summary="Registro de cambios para el plugin de CLI de {{site.data.keyword.containerlong_notm}}">
<caption>Registro de cambios para el plugin de CLI de {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<tr>
<th>Versión</th>
<th>Fecha de lanzamiento</th>
<th>Cambios</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.593</td>
<td>10 de octubre de 2018</td>
<td><ul><li>Añade el ID de grupo de recursos a la salida de <code>ibmcloud ks cluster-get</code>.</li>
<li>Cuando [{{site.data.keyword.keymanagementserviceshort}} está habilitado](cs_encrypt.html#keyprotect) como proveedor de servicios de gestión de claves (KMS), añade el campo habilitado para KMS en la salida de <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2 de octubre de 2018</td>
<td>Incorpora soporte para [grupos de recursos](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>1 de octubre de 2018</td>
<td><ul>
<li>Incorpora los mandatos [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) e [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) para recopilar registros del servidor de API en el clúster.</li>
<li>Incorpora el [mandato <code>ibmcloud ks key-protect-enable</code>](cs_cli_reference.html#cs_key_protect) para habilitar {{site.data.keyword.keymanagementserviceshort}} como proveedor de servicios de gestión de claves (KMS) en el clúster.</li>
<li>Incorpora el distintivo <code>--skip-master-health</code> a los mandatos [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) e [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) para omitir la comprobación de estado del nodo maestro antes de realizar un reinicio o una recarga.</li>
<li>Cambia el nombre de <code>Owner Email</code> por <code>Owner</code> en la salida de <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
