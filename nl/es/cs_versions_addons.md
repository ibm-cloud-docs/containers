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


# Registro de cambios de complementos del clúster

El clúster de {{site.data.keyword.containerlong}} se proporciona con complementos que IBM actualiza automáticamente. También puede inhabilitar las actualizaciones automáticas de algunos complementos y actualizarlos manualmente de forma independiente de los nodos maestro y trabajador. Consulte las tablas de las secciones siguientes para ver un resumen de los cambios de cada versión.
{: shortdesc}

## Registro de cambios del complemento de ALB de Ingress
{: #alb_changelog}

Puede ver los cambios de la versión de compilación del complemento de ALB (equilibrador de carga de aplicación) de Ingress en los clústeres de
{{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Cuando se actualiza el complemento de ALB de Ingress, se actualizan los contenedores
`nginx-ingress` e `ingress-auth` en todos los pods de ALB a la versión de compilación más reciente. De forma predeterminada, las actualizaciones automáticas del complemento están habilitadas, pero puede inhabilitar las actualizaciones automáticas y actualizar manualmente el complemento. Para obtener más información, consulte [Actualización del equilibrador de carga de aplicación de Ingress](cs_cluster_update.html#alb).

Consulte la tabla siguiente para ver un resumen de los cambios de cada compilación del complemento de ALB de Ingress.

<table summary="Visión general de los cambios de compilación del complemento del equilibrador de carga de aplicación de Ingress">
<caption>Registro de cambios del complemento del equilibrador de carga de aplicación de Ingress</caption>
<thead>
<tr>
<th>Compilación de `nginx-ingress` / `ingress-auth`</th>
<th>Fecha de lanzamiento</th>
<th>Cambios no disruptivos</th>
<th>Cambios disruptivos</th>
</tr>
</thead>
<tbody>
<tr>
<td>393 / 282</td>
<td>29 de noviembre de 2018</td>
<td>Mejora el rendimiento de {{site.data.keyword.appid_full}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 de noviembre de 2018</td>
<td>Mejora las características de registro y cierre de sesión de {{site.data.keyword.appid_full}}.</td>
<td>Sustituye el certificado autofirmado para `*.containers.mybluemix.net` por el certificado firmado por LetsEncrypt que se genera automáticamente y que utiliza el clúster. Se ha eliminado el certificado autofirmado de `*.containers.mybluemix.net`.</td>
</tr>
<tr>
<td>350 / 192</td>
<td>05 de noviembre de 2018</td>
<td>Añade soporte para habilitar e inhabilitar las actualizaciones automáticas del complemento del ALB de Ingress.</td>
<td>-</td>
</tr>
</tbody>
</table>
