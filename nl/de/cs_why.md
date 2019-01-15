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



# Warum {{site.data.keyword.containerlong_notm}}?
{: #cs_ov}

{{site.data.keyword.containerlong}} bietet durch die Kombination von Docker-Containern, der Kubernetes-Technologie, einer intuitiven Benutzererfahrung und integrierter Sicherheit und Isolation leistungsfähige Tools, um die Bereitstellung, den Betrieb, das Skalieren und die Überwachung von containerisierten Apps in einem Cluster aus Rechenhosts zu automatisieren. Zertifizierungsinformationen finden Sie unter [Compliance in {{site.data.keyword.Bluemix_notm}} ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/compliance).
{:shortdesc}


## Vorteile durch die Verwendung des Service
{: #benefits}

Cluster werden auf Rechenhosts bereitgestellt, die native Kubernetes-Funktionalität und durch {{site.data.keyword.IBM_notm}} hinzugefügte Funktionen zur Verfügung stellen.
{:shortdesc}

|Vorteil|Beschreibung|
|-------|-----------|
|Single-Tenant-Kubernetes-Cluster mit Isolation der Rechen-, Netz- und Speicherinfrastruktur|<ul><li>Erstellen Sie Ihre eigene angepasste Infrastruktur, die den Anforderungen Ihrer Organisation entspricht.</li><li>Ermöglicht die Einrichtung eines dedizierten und geschützten Kubernetes-Masters sowie von Workerknoten, virtuellen Netzen und Speicher unter Nutzung der von IBM Cloud Infrastructure (SoftLayer) bereitgestellten Ressourcen.</li><li>Der komplett verwaltete Kubernetes-Master, der kontinuierlich von {{site.data.keyword.IBM_notm}} überwacht und aktualisiert wird, um Ihren Cluster verfügbar zu halten.</li><li>Option zum Bereitstellen von Workerknoten als Bare-Metal-Server mit Trusted Compute.</li><li>Ermöglicht das Speichern persistenter Daten, die gemeinsame Nutzung von Daten durch Kubernetes-Pods und bei Bedarf die Wiederherstellung von Daten mit dem integrierten und sicheren Datenträgerservice.</li><li>Bietet volle Unterstützung für alle nativen Kubernetes-APIs.</li></ul>|
| Mehrzonencluster zur Verstärkung der Hochverfügbarkeit | <ul><li>Workerknoten desselben Maschinentyps (CPU, Speicher, virtuell oder physisch) können einfach mit Worker-Pools verwaltet werden.</li><li>Schutz gegen Zonenausfälle, indem Knoten gleichmäßig über ausgewählte Zonen verteilt werden und indem für Ihre Apps Podbereitstellungen mit Anti-Affinität verwendet werden.</li><li>Verringern Sie Ihre Kosten, indem Sie Mehrzonencluster verwenden, anstatt die Ressourcen in einem separaten Cluster zu duplizieren.</li><li>Profitieren Sie von dem App-übergreifenden automatischen Lastausgleich durch die 'Lastausgleichsfunktion für mehrere Zonen', die für Sie in jeder Zone des Clusters automatisch eingerichtet wird.</li></ul>|
| Hoch verfügbare Master | <ul>Verfügbar in Clustern, auf denen Kubernetes Version 1.10 oder höher ausgeführt wird. <li>Reduzieren Sie Clusterausfallzeiten, beispielsweise während Aktualisierungen des Masters, mithilfe von hoch verfügbaren Mastern, die beim Erstellen eines Clusters automatisch bereitgestellt werden. </li><li>Verteilen Sie Ihre Master über mehrere Zonen in einem [Mehrzonencluster](cs_clusters_planning.html#multizone), um Ihren Cluster vor Zonenausfällen zu schützen.</li></ul> |
|Einhaltung von Sicherheitsbestimmungen für Images mit Vulnerability Advisor|<ul><li>Richten Sie Ihr eigenes Repository in unserer geschützten privaten Docker-Image-Registry ein, in der Images gespeichert und von allen Benutzern der Organisation gemeinsam genutzt werden.</li><li>Profitieren Sie durch das automatische Scannen von Images in Ihrer privaten {{site.data.keyword.Bluemix_notm}}-Registry.</li><li>Ermöglicht die Überprüfung von Empfehlungen für das im Image verwendete Betriebssystem, um potenzielle Schwachstellen zu beheben.</li></ul>|
|Kontinuierliche Überwachung des Clusterzustands|<ul><li>Über das Cluster-Dashboard können Sie den Zustand Ihrer Cluster, Workerknoten und Containerbereitstellungen rasch anzeigen und verwalten.</li><li>Ermöglicht die Feststellung detaillierter Metriken zur Auslastung mit {{site.data.keyword.monitoringlong}} und die rasche Erweiterung des Clusters als Reaktion auf die Arbeitslast.</li><li>Stellt detaillierte Protokollinformationen zu Clusteraktivitäten über den {{site.data.keyword.loganalysislong}} bereit.</li></ul>|
|Sichere Offenlegung von Apps gegenüber der Allgemeinheit|<ul><li>Sie haben die Auswahl zwischen einer öffentlichen IP-Adresse, einer von {{site.data.keyword.IBM_notm}} bereitgestellten Route oder Ihrer eigenen angepassten Domäne, um aus dem Internet auf Services in Ihrem Cluster zuzugreifen.</li></ul>|
|Integration des {{site.data.keyword.Bluemix_notm}}-Service|<ul><li>Ermöglicht das Hinzufügen zusätzlicher Funktionalität zu Ihrer App durch die Integration von {{site.data.keyword.Bluemix_notm}}-Services wie zum Beispiel Watson-APIs, Blockchain, Datenservices oder Internet of Things.</li></ul>|
{: caption="Vorteile von {{site.data.keyword.containerlong_notm}}" caption-side="top"}

Bereit loszulegen? Erkunden Sie das [Lernprogramm zum Erstellen eines Kubernetes-Clusters](cs_tutorials.html#cs_cluster_tutorial).

<br />


## Vergleich von Angeboten und ihren Kombinationen
{: #differentiation}

Sie können {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Public oder Dedicated, in {{site.data.keyword.Bluemix_notm}} Private oder in einem Hybridsetup ausführen.
{:shortdesc}


<table>
<caption>Unterschiede zwischen den {{site.data.keyword.containerlong_notm}}-Konfigurationen</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>{{site.data.keyword.containerlong_notm}}-Setup</th>
 <th>Beschreibung</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>Mit {{site.data.keyword.Bluemix_notm}} Public auf [gemeinsam genutzter oder dedizierter Hardware oder auf Bare-Metal-Maschinen](cs_clusters_planning.html#shared_dedicated_node) können Sie Ihre Apps mithilfe von {{site.data.keyword.containerlong_notm}} in Clustern in der Cloud hosten. Sie können auch einen Cluster mit Worker-Pools in mehreren Zonen erstellen, um die Hochverfügbarkeit für Ihre Apps zu verstärken. {{site.data.keyword.containerlong_notm}} unter {{site.data.keyword.Bluemix_notm}} Public bietet durch die Kombination von Docker-Containern, der Kubernetes-Technologie, einer intuitiven Benutzererfahrung und integrierter Sicherheit und Isolation leistungsfähige Tools, um die Bereitstellung, den Betrieb, das Skalieren und die Überwachung von containerisierten Apps in einem Cluster aus Rechenhosts zu automatisieren.<br><br>Weitere Informationen finden Sie unter [{{site.data.keyword.containerlong_notm}}-Technologie](cs_tech.html).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated bietet dieselben {{site.data.keyword.containerlong_notm}}-Funktionalitäten in der Cloud wie {{site.data.keyword.Bluemix_notm}} Public. Bei einem {{site.data.keyword.Bluemix_notm}} Dedicated-Konto sind die verfügbaren [physischen Ressourcen jedoch nur Ihrem Cluster zugeordnet](cs_clusters_planning.html#shared_dedicated_node) und werden nicht mit Clustern von anderen {{site.data.keyword.IBM_notm}} Kunden geteilt. Sie können eine {{site.data.keyword.Bluemix_notm}} Dedicated-Umgebung einrichten, wenn Sie eine Isolation für Ihren Cluster und die anderen, von Ihnen genutzten {{site.data.keyword.Bluemix_notm}}-Services benötigen.<br><br>Weitere Informationen finden Sie unter [Einführung in Cluster in {{site.data.keyword.Bluemix_notm}} Dedicated](cs_dedicated.html#dedicated).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private ist eine Anwendungsplattform, die lokal auf Ihren Maschinen installiert werden kann. Sie können Kubernetes in {{site.data.keyword.Bluemix_notm}} Private verwenden, wenn Sie lokale, containerisierte Apps in Ihrer eigenen kontrollierten Umgebung hinter einer Firewall entwickeln und verwalten müssen. <br><br>Weitere Informationen finden Sie unter [{{site.data.keyword.Bluemix_notm}} Private – Produktdokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
 </td>
 </tr>
 <tr>
 <td>Hybridsetup
 </td>
 <td>Hybrid ist die kombinierte Nutzung von Services, die in {{site.data.keyword.Bluemix_notm}} Public oder Dedicated ausgeführt werden, sowie anderen Services, die lokal ausgeführt werden, z. B. als App in {{site.data.keyword.Bluemix_notm}} Private. Beispiele für ein Hybridsetup: <ul><li>Bereitstellung eines Clusters mit {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Public, aber Verbindung dieses Clusters mit einer lokalen Datenbank.</li><li>Bereitstellung eines Clusters mit {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Private und Implementierung einer App in diesem Cluster. Diese App kann jedoch einen {{site.data.keyword.ibmwatson}}-Service wie {{site.data.keyword.toneanalyzershort}} in {{site.data.keyword.Bluemix_notm}} Public nutzen.</li></ul><br>Um die Kommunikation zwischen Services zu aktivieren, die in {{site.data.keyword.Bluemix_notm}} Public oder Dedicated ausgeführt werden, und Services, die lokal ausgeführt werden, müssen Sie eine [VPN-Verbindung einrichten](cs_vpn.html). Weitere Informationen finden Sie unter [{{site.data.keyword.containerlong_notm}} mit {{site.data.keyword.Bluemix_notm}} Private verwenden](cs_hybrid.html).
 </td>
 </tr>
 </tbody>
</table>

<br />


## Vergleich von kostenlosen Clustern und Standardclustern
{: #cluster_types}

Sie können einen kostenlosen Cluster oder beliebig viele Standardcluster erstellen. Testen Sie kostenlose Cluster, um sich mit einigen Kubernetes-Leistungsmerkmalen vertraut zu machen. Oder erstellen Sie Standardcluster, um das vollständige Leistungsspektrum von Kubernetes zum Bereitstellen von Apps zu nutzen. Freie Cluster werden nach 30 Tagen automatisch gelöscht.
{:shortdesc}

Wenn Sie einen kostenlosen Cluster haben und ein Upgrade auf einen Standardcluster durchführen wollen, können Sie [einen Standardcluster erstellen](cs_clusters.html#clusters_ui). Stellen Sie anschließend alle YAML-Dateien für die Kubernetes-Ressourcen, die Sie mit Ihrem kostenlosen Cluster erstellt haben, im Standardcluster bereit.

|Merkmale|Kostenlose Cluster|Standardcluster|
|---------------|-------------|-----------------|
|[Netzbetrieb in Clustern](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Zugriff auf Apps über ein öffentliches Netz mithilfe eines NodePort-Service auf eine nicht stabile IP-Adresse](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Benutzerzugriffsverwaltung](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Zugriff auf den {{site.data.keyword.Bluemix_notm}}-Service von Cluster und Apps aus](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Plattenspeicher auf Workerknoten für nicht persistenten Speicher](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
| [Möglichkeit zum Erstellen eines Clusters in jeder {{site.data.keyword.containerlong_notm}}-Region](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" /> |
|[Mehrzonencluster zur Verstärkung der Hochverfügbarkeit](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
| Replizierte Master für höhere Verfügbarkeit (Kubernetes 1.10 oder höher) | | <img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" /> |
|[Skalierbare Anzahl von Workerknoten zur Steigerung der Kapazität](cs_app.html#app_scaling)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Persistenter NFS-dateibasierter Speicher mit Datenträgern](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Öffentlicher oder privater App-Zugriff auf eine stabile IP-Adresse durch einen Lastausgleichsservice](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Öffentlicher App-Zugriff auf eine stabile IP-Adresse und eine anpassbare URL durch einen Ingress-Service](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Portierbare öffentliche IP-Adressen](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Protokollierung und Überwachung](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Option zum Bereitstellen der Workerknoten auf physischen Servern (Bare-Metal-Servern)](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Option zum Bereitstellen von Bare-Metal-Workern mit Trusted Compute](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Verfügbar in {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
{: caption="Merkmale von kostenlosen Clustern und Standardclustern" caption-side="top"}

<br />




## Preisstruktur und Abrechnung
{: #pricing}

Überprüfen Sie die häufig gestellten Fragen zur Preisstruktur und Abrechnung von {{site.data.keyword.containerlong_notm}}. Antworten auf Fragen zur Kontoebene finden Sie unter [Abrechnungs- und Nutzungsdokumente verwalten](/docs/billing-usage/how_charged.html#charges). Details zu Kontovereinbarungen finden Sie in den entsprechenden [{{site.data.keyword.Bluemix_notm}}-Nutzungsbedingungen und Bemerkungen](/docs/overview/terms-of-use/notices.html#terms).
{: shortdesc}

### Wie kann ich meine Nutzung anzeigen und organisieren?
{: #usage}

**Wie kann ich meine Abrechnung und Nutzung überprüfen?**<br>
Informationen zur Nutzung und den geschätzten Gesamtbeträgen finden Sie unter [Nutzung anzeigen](/docs/billing-usage/viewing_usage.html#viewingusage).

Wenn Sie das {{site.data.keyword.Bluemix_notm}}-Konto und das IBM Cloud-Infrastrukturkonto (SoftLayer) miteinander verknüpfen, erhalten Sie eine konsolidierte Abrechnung; weitere Informationen finden Sie unter [Konsolidierte Rechnungsstellung für verknüpfte Konten](/docs/customer-portal/linking_accounts.html#unifybillaccounts).

**Kann ich meine Cloudressourcen zu Abrechnungszwecken nach Teams oder Abteilungen zusammenfassen?**<br>
Sie können [Ressourcengruppen verwenden](/docs/resources/bestpractice_rgs.html#bp_resourcegroups), um {{site.data.keyword.Bluemix_notm}}-Ressourcen, einschließlich Cluster, zur Verwaltung der Abrechnung in Gruppen zusammenzufassen.

### Wie wird abgerechnet? Werden die Gebühren stündlich oder Monatlich abgerechnet?
{: #monthly-charges}

Ihre Gebühren hängen vom Typ der jeweils verwendeten Ressource ab und können fest, gemessen, gestaffelt oder reserviert sein. Weitere Informationen hierzu finden Sie unter [Berechnung der Gebühren](/docs/billing-usage/how_charged.html#charges).

Die Ressourcen der IBM Cloud-Infrastruktur (SoftLayer) können in {{site.data.keyword.containerlong_notm}} stündlich oder monatlich abgerechnet werden.
* Die Workerknoten von virtuellen Maschinen werden stündlich abgerechnet.
* Physische Knoten (Bare-Metal-Knoten) sind in {{site.data.keyword.containerlong_notm}} monatlich abgerechnete Ressourcen.
* Bei anderen Infrastrukturressourcen, wie zum Beispiel Datei- oder Blockspeicher, können Sie bei der Erstellung der Ressource möglicherweise zwischen stündlicher und monatlicher Abrechnung wählen.

Bei monatlichen Ressourcen wird die Nutzung des aktuellen Monats im Folgemonat auf der Basis des Monatsersten abgerechnet. Wenn Sie eine Monatsressource in der Mitte eines Monats bestellen, wird Ihnen für diesen Monat der anteilige Betrag in Rechnung gestellt. Wenn Sie eine Ressource jedoch in der Mitte des Monats kündigen, wird Ihnen trotzdem der volle Betrag für die monatliche Ressource in Rechnung gestellt.

### Kann ich meine Kosten schätzen?
{: #estimate}

Ja, Informationen hierzu finden Sie unter [Kosten schätzen](/docs/billing-usage/estimating_costs.html#cost) und im [Kostenschätzungstool ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/pricing/). Lesen Sie auch die Informationen zu den Kosten, die nicht vom Kostenschätzungstool berücksichtigt werden, zum Beispiel für den abgehenden Netzbetrieb.

### Welche Gebühren werden bei der Nutzung von {{site.data.keyword.containerlong_notm}} berechnet?
{: #cluster-charges}

Mit {{site.data.keyword.containerlong_notm}}-Clustern können Sie die Rechen-, Netzbetriebs- und Speicherressourcen der IBM Cloud-Infrastruktur (SoftLayer) mit Plattformservices (Watson AI oder Database as a Service 'Compose') verwenden. Mit jeder Ressource sind eigene Gebühren verbunden.
* [Workerknoten](#nodes)
* [Abgehender Netzbetrieb](#bandwidth)
* [IP-Teilnetzadressen](#subnets)
* [Speicher](#storage)
* [{{site.data.keyword.Bluemix_notm}} Services](#services)

<dl>
<dt id="nodes">Workerknoten</dt>
  <dd><p>Cluster können über zwei Haupttypen an Workerknoten verfügen: virtuelle Maschinen (VMs) oder physische Maschinen (Bare-Metal-Maschinen). Die Verfügbarkeit und Preisstruktur für jeden Maschinentyp hängt von der Zone ab, in der Sie Ihren Cluster bereitstellen.</p>
  <p><strong>Virtuelle Maschinen</strong> bieten eine größere Flexibilität, schnellere Bereitstellungszeiten und mehr automatische Skalierbarkeitsfunktionen als Bare-Metal-Maschinen und sind zudem kostengünstiger als Bare-Metal-Maschinen. Im Vergleich zu Bare-Metal-Maschinen müssen bei virtuellen Maschinen jedoch Leistungskompromisse in Kauf genommen werden, zum Beispiel in Bezug auf die Gb/s-Werte im Netzbetrieb, die Schwellenwerte für RAM und Speicher sowie die Speicheroptionen. Beachten Sie, dass sich die folgenden Faktoren auf die Kosten für virtuelle Maschinen auswirken:</p>
  <ul><li><strong>Gemeinsam genutzt im Gegensatz zu dediziert</strong>: Wenn Sie die zugrunde liegende Hardware der virtuellen Maschine gemeinsam nutzen, sind die Kosten niedriger als bei dedizierter Hardware, die physischen Ressourcen sind jedoch nicht dediziert für Ihre virtuelle Maschine.</li>
  <li><strong>Nur stündliche Abrechnung</strong>: Die stündliche Abrechnung bietet mehr Flexibilität beim schnellen Bestellen und Stornieren virtueller Maschinen.
  <li><strong>Nach Stunden pro Monat gestaffelt</strong>: Die stündliche Abrechnung erfolgt gestaffelt. Da die Bestellung einer virtuellen Maschine für die Preisstufe für die Stunden in einem Abrechnungsmonat fortbesteht, sinkt die stündliche Rate, die berechnet wird. Die Preisstufen für die Stunden sind 0 - 150 Stunden, 151 - 290 Stunden, 291 - 540 Stunden und über 541 Stunden.</li></ul>
  <p><strong>Physische Maschinen (Bare-Metal)</strong> bieten den Vorteil hoher Leistung für Workloads wie Daten, künstliche Intelligenz und Grafik-Verarbeitungseinheiten. Außerdem sind alle Hardwareressourcen für Ihre Workloads dediziert, sodass Sie sich keine Sorgen um Leistungsbeeinträchtigungen machen brauchen, weil sie Ressourcen mit anderen teilen. Beachten Sie, dass sich die folgenden Faktoren auf die Kosten für Bare-Metal-Maschinen auswirken:</p>
  <ul><li><strong>Nur monatliche Abrechnung</strong>: Alle Bare-Metal-Maschinen werden monatlich abgerechnet.</li>
  <li><strong>Längerer Bestellprozess</strong>: Da es sich bei der Bestellung und Stornierung von Bare-Metal-Servern um einen manuellen Prozess über das IBM Cloud-Infrastrukturkonto (SoftLayer) handelt, kann die Ausführung über einen Geschäftstag dauern.</li></ul>
  <p>Details zu den Maschinenspezifikationen finden Sie unter [Verfügbare Hardware für Workerknoten](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Öffentliche Bandbreite</dt>
  <dd><p>Die Bandbreite bezieht sich auf die öffentliche Datenübertragung des eingehenden und abgehenden Netzverkehrs, sowohl zu als auch von den {{site.data.keyword.Bluemix_notm}}-Ressourcen in den Rechenzentren auf der ganzen Welt. Die öffentliche Bandbreite wird nach Gb berechnet. Wenn Sie Ihre aktuelle Zusammenfassung der Bandbreite überprüfen möchten, melden Sie sich an der [{{site.data.keyword.Bluemix_notm}}-Konsole](https://console.bluemix.net/) an, wählen Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") **Infrastruktur** aus und wählen Sie anschließend die Seite **Netz > Bandbreite > Zusammenfassung** aus.
  <p>Überprüfen Sie die folgenden Faktoren, die sich auf die Gebühren für die öffentliche Bandbreite auswirken:</p>
  <ul><li><strong>Standort</strong>: Wie bei den Workerknoten variieren die Gebühren in Abhängigkeit von der Zone, in der die Ressourcen bereitgestellt werden.</li>
  <li><strong>Inklusive Bandbreite oder nutzungsabhängig</strong>: Die Workerknotenmaschinen können mit einer bestimmten Zuordnung für abgehende Netze pro Monat bereitgestellt werden, zum Beispiel 250 Gb für virtuelle Maschinen oder 500 Gb für Bare-Metal-Maschinen. Alternativ wird auch eine nutzungsabhängig Zuordnung auf der Basis der Gb-Nutzung bereitgestellt.</li>
  <li><strong>Gestaffelte Pakete</strong>: Sobald eine inklusive Bandbreite überschritten wird, wird die Abrechnung nach einem gestaffelten Nutzungsschema ausgeführt, das abhängig vom Standort variiert. Wenn Sie die Quote für die Staffelung überschreiten, wird möglicherweise auch eine Standarddatenübertragungsgebühr abgerechnet. </li></ul>
  <p>Weitere Informationen finden Sie in [Bandbreitenpakete ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">IP-Teilnetzadressen</dt>
  <dd><p>Wenn Sie einen Standardcluster erstellen, wird ein portierbares öffentliches Teilnetz mit 8 öffentlichen IP-Adressen bestellt und dem Konto monatlich in Rechnung gestellt.</p><p>Wenn Sie im Infrastrukturkonto bereits über Teilnetze verfügen, können Sie stattdessen diese Teilnetze verwenden. Erstellen Sie den Cluster mit dem [Flag](cs_cli_reference.html#cs_cluster_create) `-- no-subnets` und [verwenden Sie die Teilnetze erneut](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Speicher</dt>
  <dd>Wenn Sie Speicher bereitstellen, können Sie den Speichertyp und die Speicherklasse auswählen, die für Ihren Anwendungsfall geeignet sind. Die Gebühren hängen vom Typ des Speichers, dem Standort und den Spezifikationen der Speicherinstanz ab. Informationen zum Auswählen der richtigen Speicherlösung finden Sie unter [Persistenten Hochverfügbarkeitsspeicher planen](cs_storage_planning.html#storage_planning). Weitere Informationen finden Sie unter:
  <ul><li>[Preisstruktur für NFS-Dateispeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Preisstruktur für Blockspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Pläne für Objektspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}}-Services</dt>
  <dd>Jeder Service, den Sie in den Cluster integrieren, weist ein eigenes Preismodell auf. Weitere Informationen finden Sie in jeder Produktdokumentation und im [Kostenschätzungstool ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/pricing/).</dd>

</dl>
