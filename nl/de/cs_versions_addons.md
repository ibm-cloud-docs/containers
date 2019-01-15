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


# Änderungsprotokoll für Cluster-Add-ons

Ihr {{site.data.keyword.containerlong}}-Cluster wird mit Add-ons ausgeliefert, die automatisch von IBM aktualisiert werden. Sie können automatische Aktualisierungen für manche Add-ons auch inaktivieren und sie separat über die Master- und Worker-Knoten aktualisieren. In den Tabellen in den folgenden Abschnitten finden Sie eine Zusammenfassung der Änderungen für jede Version.
{: shortdesc}

## Änderungsprotokoll für Ingress-ALB-Add-on
{: #alb_changelog}

Zeigen Sie Änderungen der Buildversion für das Add-on der Ingress-Lastausgleichsfunktion für Anwendungen (ALB) in Ihren {{site.data.keyword.containerlong_notm}}-Clustern an.
{:shortdesc}

Wenn das Ingress-ALB-Add-on aktualisiert wird, werden die Container `nginx-ingress` und `ingress-auth` in allen ALB-Pods auf die aktuelle Buildversion aktualisiert. Standardmäßig sind automatische Aktualisierungen für das Add-on aktiviert, aber Sie können die automatischen Aktualisierungen inaktivieren und das Add-on manuell aktualisieren. Weitere Informationen finden Sie unter [Ingress-Lastausgleichsfunktion für Anwendungen aktualisieren](cs_cluster_update.html#alb). 

In der folgenden Tabelle finden Sie eine Zusammenfassung der Änderungen für jeden Build des Ingress-ALB-Add-ons. 

<table summary="Übersicht über Buildänderungen für das Add-on der Ingress-Lastausgleichsfunktion für Anwendungen">
<caption>Änderungsprotokoll für das Add-on der Ingress-Lastausgleichsfunktion für Anwendungen</caption>
<thead>
<tr>
<th>Build `nginx-ingress`/`ingress-auth`</th>
<th>Freigabedatum</th>
<th>Unterbrechungsfreie Änderungen</th>
<th>Änderungen mit Unterbrechung</th>
</tr>
</thead>
<tbody>
<tr>
<td>393/282</td>
<td>29. November 2018</td>
<td>Verbessert die Leistung für {{site.data.keyword.appid_full}}. </td>
<td>-</td>
</tr>
<tr>
<td>384/246</td>
<td>14. November 2018</td>
<td>Verbessert die Protokollierungs- und Abmeldefeatures für {{site.data.keyword.appid_full}}. </td>
<td>Ersetzt das selbst signierte Zertifikat für `*.containers.mybluemix.net` durch das signierte Zertifikat von LetsEncrypt, das automatisch für den Cluster generiert und von diesem verwendet wird. Das selbst signierte Zertifikat `*.containers.mybluemix.net` wird entfernt. </td>
</tr>
<tr>
<td>350/192</td>
<td>5. November 2018</td>
<td>Fügt Unterstützung für die Aktivierung und Inaktivierung der automatischen Aktualisierungen des Ingress-ALB-Add-ons hinzu. </td>
<td>-</td>
</tr>
</tbody>
</table>
