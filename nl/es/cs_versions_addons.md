---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, nginx, ingress controller

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



# Registro de cambios de complementos del clúster

El clúster de {{site.data.keyword.containerlong}} se proporciona con complementos que IBM actualiza automáticamente. También puede inhabilitar las actualizaciones automáticas de algunos complementos y actualizarlos manualmente de forma independiente de los nodos maestro y trabajador. Consulte las tablas de las secciones siguientes para ver un resumen de los cambios de cada versión.
{: shortdesc}

## Registro de cambios del complemento de ALB de Ingress
{: #alb_changelog}

Puede ver los cambios de la versión de compilación del complemento de ALB (equilibrador de carga de aplicación) de Ingress en los clústeres de
{{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Cuando se actualiza el complemento de ALB de Ingress, se actualizan los contenedores
`nginx-ingress` e `ingress-auth` en todos los pods de ALB a la versión de compilación más reciente. De forma predeterminada, las actualizaciones automáticas del complemento están habilitadas, pero puede inhabilitar las actualizaciones automáticas y actualizar manualmente el complemento. Para obtener más información, consulte [Actualización del equilibrador de carga de aplicación de Ingress](/docs/containers?topic=containers-update#alb).

Consulte la tabla siguiente para ver un resumen de los cambios de cada compilación del complemento de ALB de Ingress.

<table summary="Visión general de los cambios de compilación del complemento del equilibrador de carga de aplicación de Ingress">
<caption>Registro de cambios del complemento del equilibrador de carga de aplicación de Ingress</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
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
<td>411 / 306</td>
<td>21 de marzo de 2019</td>
<td>Actualiza la versión de Go a 1.12.1.</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>18 de marzo de 2019</td>
<td><ul>
<li>Corrige las vulnerabilidades de las exploraciones de imágenes.</li>
<li>Mejora el registro de {{site.data.keyword.appid_full}}.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>5 de marzo de 2019</td>
<td>-</td>
<td>Corrige errores en la integración de autorización relacionados con la funcionalidad de cierre de sesión, caducidad de la señal y devolución de llamada de autorización de `OAuth`. Estos arreglos solo se implementan si ha habilitado la autorización de {{site.data.keyword.appid_full_notm}} mediante la anotación [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth). Para implementar estos arreglos, se añaden cabeceras adicionales, lo que aumenta el tamaño total de la cabecera. En función del tamaño de sus propias cabeceras y del tamaño total de las respuestas, es posible que tenga que ajustar las [anotaciones de almacenamiento intermedio de proxy](/docs/containers?topic=containers-ingress_annotation#proxy-buffer) que utilice.</td>
</tr>
<tr>
<td>406 / 301</td>
<td>19 de febrero de 2019</td>
<td><ul>
<li>Actualiza la versión de Go a 1.11.5.</li>
<li>Corrige las vulnerabilidades de las exploraciones de imágenes.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>31 de enero de 2019</td>
<td>Actualiza la versión de Go a 1.11.4.</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>23 de enero de 2019</td>
<td><ul>
<li>Actualiza la versión de NGINX de ALB a 1.15.2.</li>
<li>Ahora los certificados TLS proporcionados por IBM se renuevan automáticamente 37 días antes de que caduquen, en lugar de 7 días antes.</li>
<li>Añade la funcionalidad de cierre de sesión de {{site.data.keyword.appid_full_notm}}: Si el prefijo `/logout` existe en una vía de acceso de {{site.data.keyword.appid_full_notm}}, se eliminan cookies y se devuelve al usuario a la página de inicio de sesión.</li>
<li>Añade una cabecera a las solicitudes de {{site.data.keyword.appid_full_notm}} para fines de seguimiento internos.</li>
<li>Actualiza la directriz de ubicación de {{site.data.keyword.appid_short_notm}} de modo que se puede utilizar la anotación `app-id` junto con las anotaciones `proxy-buffers`, `proxy-buffer-size` y `proxy-busy-buffer-size`.</li>
<li>Corrige un error para que los registros de información no se etiqueten como errores.</li>
</ul></td>
<td>Inhabilita TLS 1.0 y 1.1 de forma predeterminada. Si los clientes que se conectan a las apps dan soporte a TLS 1.2, no se requiere ninguna acción. Si aún tiene clientes anteriores que necesitan soporte de TLS 1.0 o 1.1, habilite manualmente las versiones de TLS necesarias siguiendo [estos pasos](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers). Para obtener más información sobre cómo ver las versiones de TLS que utilizan los clientes para acceder a las apps, consulte esta [publicación del blog de {{site.data.keyword.Bluemix_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).</td>
</tr>
<tr>
<td>393 / 291</td>
<td>9 de enero de 2019</td>
<td>Incorpora soporte para varias instancias de {{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>29 de noviembre de 2018</td>
<td>Mejora el rendimiento de {{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 de noviembre de 2018</td>
<td>Mejora las características de registro y cierre de sesión de {{site.data.keyword.appid_full_notm}}.</td>
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
