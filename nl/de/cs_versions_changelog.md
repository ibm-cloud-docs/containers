---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Änderungsprotokoll der Version
{: #changelog}

Zeigen Sie Informationen zu Versionsänderungen für Hauptversions-, Nebenversions- und Patchaktualisierungen an, die für Ihre {{site.data.keyword.containerlong}}-Kubernetes-Cluster verfügbar sind. Diese Änderungen umfassen Updates für Kubernetes und {{site.data.keyword.Bluemix_notm}} Provider-Komponenten.
{:shortdesc}

IBM wendet Updates auf Patch-Level automatisch auf Ihren Master an, aber Sie müssen [Ihre Workerknoten aktualisieren](cs_cluster_update.html#worker_node). Prüfen Sie einmal im Monat auf verfügbare Updates. Sobald Updates verfügbar sind, werden Sie benachrichtigt, wenn Sie Informationen zu den Workerknoten anzeigen, z. B. mit den Befehlen `bx cs workers <cluster>` oder `bx cs worker-get <cluster> <worker>`. 

Eine Zusammenfassung der Migrationsaktionen finden Sie unter [Kubernetes-Versionen](cs_versions.html).
{: tip}

Weitere Informationen zu Änderungen seit der vorherigen Version finden Sie in den Änderungsprotokollen. 
-  Version 1.8, [Änderungsprotokoll](#18_changelog).
-  Version 1.7, [Änderungsprotokoll](#17_changelog).


## Version 1.8, Änderungsprotokoll
{: #18_changelog}

Überprüfen Sie die folgenden Änderungen. 

### Änderungsprotokoll für 1.8.11_1509
{: #1811_1509}

<table summary="Änderungen seit Version 1.8.8_1507">
<caption>Änderungen seit Version 1.8.8_1507</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). </td>
</tr>
<tr>
<td>Containerimage anhalten</td>
<td>3.0</td>
<td>3.1</td>
<td>Entfernt geerbte verwaiste Zombie-Prozesse.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>`NodePort`- und `LoadBalancer`-Services unterstützen jetzt [das Beibehalten der Client-Quellen-IP](cs_loadbalancer.html#node_affinity_tolerations) durch Festlegen von `service.spec.externalTrafficPolicy` auf `Local`. </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Korrigiert die [Edge-Knoten](cs_edge.html#edge)-Tolerierungskonfiguration für ältere Cluster. </td>
</tr>
</tbody>
</table>

## Version 1.7, Änderungsprotokoll
{: #17_changelog}

Überprüfen Sie die folgenden Änderungen. 

### Änderungsprotokoll für 1.7.16_1511
{: #1716_1511}

<table summary="Änderungen seit Version 1.7.4_1509">
<caption>Änderungen seit Version 1.7.4_1509</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). </td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort`- und `LoadBalancer`-Services unterstützen jetzt [das Beibehalten der Client-Quellen-IP](cs_loadbalancer.html#node_affinity_tolerations) durch Festlegen von `service.spec.externalTrafficPolicy` auf `Local`. </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Korrigiert die [Edge-Knoten](cs_edge.html#edge)-Tolerierungskonfiguration für ältere Cluster. </td>
</tr>
</tbody>
</table>

