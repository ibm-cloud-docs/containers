---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Gängige Themen für {{site.data.keyword.containershort_notm}}
{: #cs_popular_topics}

Schauen Sie sich an, was Container-Anwendungsentwickler in Bezug auf {{site.data.keyword.containerlong}} wissen wollen.
{:shortdesc}

## Beliebte Themen im März 2018
{: #mar18}

<table summary="Die Tabelle zeigt beliebte Themen. Die Zeilen sind von links nach rechts zu lesen. In Spalte 1 finden Sie das Datum, den Titel der Funktion in Zeile 2 und eine Beschreibung in Zeile 3.">
<caption>Beliebte Themen im Bereich Container und Kubernetes-Cluster im Februar 2018</caption>
<thead>
<th>Datum</th>
<th>Titel</th>
<th>Beschreibung</th>
</thead>
<tbody>
<tr>
<td> 16. März</td>
<td>[Bereitstellung eines Bare-Metal-Clusters mit Trusted Compute](cs_clusters.html#shared_dedicated_node)</td>
<td>Erstellen Sie ein Bare-Metal-Cluster, das [Kubernetes Version 1.9](cs_versions.html#cs_v19) oder eine höhere Version ausführt und aktivieren Sie Trusted Compute, um Ihre Workerknoten auf Manipulation zu überprüfen. </td>
</tr>
<tr>
<td>14. März</td>
<td>[Sichere Anmeldung bei {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Verbessern Sie Ihre Apps, die in {{site.data.keyword.containershort_notm}} ausgeführt werden, in dem Sie verlangen, dass Benutzer sich anmelden.</td>
</tr>
<tr>
<td>13. März</td>
<td>[Standort in São Paulo verfügbar](cs_regions.html)</td>
<td>Willkommen in São Paulo, Brasilien, dem neuen Standort in der Regtion 'Vereinigte Staaten (Süden)'. Wenn Sie eine Firewall haben, stellen Sie sicher, dass Sie [die erforderlichen Firewall-Ports](cs_firewall.html#firewall) für diesen Standort und die anderen Standorte in der Region Ihres Clusters öffnen. </td>
</tr>
<tr>
<td>12. März</td>
<td>[Haben Sie nur ein Testkonto für {{site.data.keyword.Bluemix_notm}}? Probieren Sie die kostenlosen Kubernetes-Cluster aus!](container_index.html#clusters)</td>
<td>Mit dem [{{site.data.keyword.Bluemix_notm}}-Testkonto](https://console.bluemix.net/registration/) können Sie 1 kostenlosen Cluster für 21 Tage testen und das Leistungsspektrum von Kubernetes ausprobieren. </td>
</tr>
</tbody></table>

## Beliebte Themen im Februar 2018
{: #feb18}

<table summary="Die Tabelle zeigt beliebte Themen. Die Zeilen sind von links nach rechts zu lesen. In Spalte 1 finden Sie das Datum, den Titel der Funktion in Zeile 2 und eine Beschreibung in Zeile 3.">
<caption>Beliebte Themen im Bereich Container und Kubernetes-Cluster im Februar 2018</caption>
<thead>
<th>Datum</th>
<th>Titel</th>
<th>Beschreibung</th>
</thead>
<tbody>
<tr>
<td>27. Februar</td>
<td>HVM-Images (HVM, Hardware Virtual Machine) für Workerknoten</td>
<td>Erhöhen Sie die E/A-Leistung für Ihre Arbeitslast mit HVM-Images. Aktivieren Sie sie auf jedem vorhandenen Workerknoten mit dem [Befehl](cs_cli_reference.html#cs_worker_reload) `bx cs worker-reload` oder mit dem [Befehl](cs_cli_reference.html#cs_worker_update) `bx cs worker-update`.</td>
</tr>
<tr>
<td>26. Februar</td>
<td>[Automatische KubeDNS-Skalierung](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS führt nun eine Skalierung mit Ihrem Cluster aus, wenn dieser größer wird. Sie können die Skalierungsfaktoren anpassen, indem Sie den folgenden Befehl verwenden: `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23. Februar</td>
<td>Suchen Sie in der Webbenutzerschnittstelle nach [Protokollierung](cs_health.html#view_logs) und [Messwerten](cs_health.html#view_metrics)</td>
<td>Sie können Protokolle und Messwerte mit einer verbesserten Webbenutzerschnittstelle bequem in Ihrem Cluster und seinen Komponenten anzeigen. Auf der Detailseite des Clusters finden Sie Informationen zum Zugriff. </td>
</tr>
<tr>
<td>20. Februar</td>
<td>Verschlüsselte Images und [-signierter, vertrauenswürdiger Inhalt](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>In {{site.data.keyword.registryshort_notm}} können Sie Images signieren und verschlüsseln, um deren Integrität zu gewährleisten, wenn sie in Ihrem Registry-Namensbereich gespeichert werden. Erstellen Sie Container, die nur vertrauenswürdigen Inhalt aufweisen.</td>
</tr>
<tr>
<td>19. Februar</td>
<td>[StrongSwan IPSec-VPN konfigurieren](cs_vpn.html#vpn-setup)</td>
<td>Stellen Sie schnell das StrongSwan IPSec-VPN-Helm-Diagramm bereit, um eine sichere Verbindung ohne Vyatta zu Ihrem {{site.data.keyword.containershort_notm}}-Cluster in Ihrem Rechenzentrum vor Ort herzustellen. </td>
</tr>
<tr>
<td>14. Februar</td>
<td>[Standort in Seoul verfügbar](cs_regions.html)</td>
<td>Gerade rechtzeitig für Olympia wird ein Kubernetes-Cluster in Seoul in der Region 'Asien-Pazifik (Norden)' bereitgestellt. Wenn Sie eine Firewall haben, stellen Sie sicher, dass Sie [die erforderlichen Firewall-Ports](cs_firewall.html#firewall) für diesen Standort und die anderen Standorte in der Region Ihres Clusters öffnen. </td>
</tr>
<tr>
<td>8. Februar</td>
<td>[Kubernetes 1.9 aktualisieren](cs_versions.html#cs_v19)</td>
<td>Überprüfen Sie die Änderungen, die an Ihren Clustern vorgenommen werden müssen, bevor Sie Kubernetes 1.9 aktualisieren.</td>
</tr>
</tbody></table>

## Beliebte Themen im Januar 2018
{: #jan18}

<table summary="Die Tabelle zeigt beliebte Themen. Die Zeilen sind von links nach rechts zu lesen. In Spalte 1 finden Sie das Datum, den Titel der Funktion in Zeile 2 und eine Beschreibung in Zeile 3.">
<caption>Beliebte Themen im Bereich Container und Kubernetes-Cluster im Januar 2018</caption>
<thead>
<th>Datum</th>
<th>Titel</th>
<th>Beschreibung</th>
</thead>
<tbody>
<td>25. Januar</td>
<td>[Global Registry verfügbar](../services/Registry/registry_overview.html#registry_regions)</td>
<td>Mit {{site.data.keyword.registryshort_notm}} können Sie die globale Registry `registry.bluemix.net` verwenden, um von IBM bereitgestellte öffentliche Images zu extrahieren. </td>
</tr>
<tr>
<td>23. Januar</td>
<td>[Standort in Singapore und Montreal verfügbar](cs_regions.html)</td>
<td>Singapore und Montreal sind Standorte, die in den {{site.data.keyword.containershort_notm}}-Regionen 'Asien-Pazifik (Norden)' und 'Vereinigte Staaten (Osten)' verfügbar sind. Wenn Sie eine Firewall haben, stellen Sie sicher, dass Sie [die erforderlichen Firewall-Ports](cs_firewall.html#firewall) für diese Standorte und die anderen Standorte in der betreffenden Region Ihres Clusters öffnen. </td>
</tr>
<tr>
<td>8. Januar</td>
<td>[Erweiterte Maschinentypen sind verfügbar](cs_cli_reference.html#cs_machine_types)</td>
<td>Die Maschinentypen der Serie 2 umfassen lokalen SSD-Speicher und Plattenverschlüsselung. [Migrieren Sie Ihre Arbeitslast](cs_cluster_update.html#machine_type) auf diese Maschinentypen, um die Leistung und Stabilität zu verbessern.</td>
</tr>
</tbody></table>

## Tauschen Sie sich mit Entwicklern mit ähnlichen Zuständigkeitsbereichen in Slack aus
{: #slack}

Sie können die Diskussionen anderer verfolgen und Ihre Fragen im [{{site.data.keyword.containershort_notm}}-Slack stellen. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com)
{:shortdesc}

Tipp: Wenn Sie keine IBM ID für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung](https://bxcs-slack-invite.mybluemix.net/) zu diesem Slack an.
