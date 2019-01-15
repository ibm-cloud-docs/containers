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
{:download: .download}
{:faq: data-hd-content-type='faq'}

# Häufig gestellte Fragen
{: #faqs}

## Was ist Kubernetes?
{: #kubernetes}
{: faq}

Kubernetes ist eine Open-Source-Plattform für die Verwaltung containerisierter Workloads und Services über mehrere Hosts hinweg und bietet Verwaltungstools für die Bereitstellung, Automatisierung, Überwachung und Skalierung containerisierter Apps mit geringer bis gar keiner manuellen Intervention. Alle Container, aus denen sich Ihr Mikroservice zusammensetzt, werden in Pods gruppiert, einer logischen Einheit zur Sicherstellung einer einfachen Verwaltung und Erkennung. Diese Pods werden auf Rechenhosts ausgeführt, die in einem portierbaren, erweiterbaren und im Störfall selbst-heilenden Kubernetes-Cluster verwaltet werden.
{: shortdesc}

Weitere Informationen zu Kubernetes finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational).  

## Wie funktioniert IBM Cloud Kubernetes Service? 
{: #kubernetes_service}
{: faq}

Mit {{site.data.keyword.containerlong_notm}} können Sie Ihren eigenen Kubernetes-Cluster zum Bereitstellen und Verwalten von containerisierten Apps in {{site.data.keyword.Bluemix_notm}} erstellen. Ihre containerisierten Apps werden auf Rechenhosts der IBM Cloud-Infrastruktur (SoftLayer) namens Workerknoten gehostet. Sie können Ihre Rechenhosts als [virtuelle Maschinen](cs_clusters_planning.html#vm) mit gemeinsam genutzten oder dedizierten Ressourcen oder als [Bare-Metal-Maschinen](cs_clusters_planning.html#bm) bereitstellen, die für die GPU- (Graphics Processing Unit) und SDS-Verwendung (Software-defined Storage) optimiert werden können. Ihre Workerknoten werden von einem hoch verfügbaren Kubernetes-Master gesteuert, der von IBM konfiguriert, überwacht und verwaltet wird. Sie können die {{site.data.keyword.containerlong_notm}}-API oder -CLI verwenden, um mit Ihren Clusterinfrastrukturressourcen zu arbeiten, und die Kubernetes-API oder -CLI, um Ihre Bereitstellungen und Services zu verwalten.  

Weitere Informationen zur Konfiguration Ihrer Clusterressourcen finden Sie unter [Servicearchitektur](cs_tech.html#architecture). Informationen zum Auflisten von Funktionen und Vorteilen finden Sie unter [Warum {{site.data.keyword.containerlong_notm}}?](cs_why.html#cs_ov). 

## Warum sollte ich IBM Cloud Kubernetes Service verwenden? 
{: #benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} ist ein verwaltetes Kubernetes-Angebot, das leistungsfähige Tools, eine intuitive Benutzererfahrung und integrierte Sicherheit für schnelle Bereitstellung von Apps bereitstellt, die Sie an Cloud-Services für IBM Watson®, KI, Internet der Dinge, DevOps, Sicherheit und Datenanalyse binden können. Als zertifizierter Kubernetes-Provider stellt {{site.data.keyword.containerlong_notm}} intelligente Planung, automatische Fehlerbehebung, horizontale Skalierung, Serviceerkennung und Lastausgleich, automatisierte Rollouts und Rollbacks sowie Verwaltung von geheimen Schlüsseln und Konfigurationsverwaltung bereit. Der Service bietet außerdem erweiterte Funktionen für vereinfachtes Cluster-Management, Containersicherheit und Isolationsrichtlinien, die Möglichkeit, einen eigenen Cluster zu entwerfen, und integrierte operationale Tools für Konsistenz in der Bereitstellung. 

Einen detaillierten Überblick über die Funktionen und Vorteile finden Sie unter [Warum {{site.data.keyword.containerlong_notm}}?](cs_why.html#cs_ov).  

## Beinhaltet der Service einen verwalteten Kubernetes-Masterknoten sowie Workerknoten? 
{: #managed_master_worker}
{: faq}

Jeder Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}} wird von einem dedizierten Kubernetes-Master gesteuert, der von IBM in einem IBM eigenen {{site.data.keyword.Bluemix_notm}}-Infrastrukturkonto verwaltet wird. Der Kubernetes-Master, einschließlich aller Masterkomponenten, Rechen-, Netzbetriebs- und Speicherressourcen, wird fortlaufend von IBM Site Reliability Engineers (SREs) überwacht. Von SREs werden die neuesten Sicherheitsstandards angewendet, böswillige Aktivitäten ermittelt und korrigiert und somit die Zuverlässigkeit und Verfügbarkeit von {{site.data.keyword.containerlong_notm}} sichergestellt. Add-ons wie Fluentd für die Protokollierung, die automatisch installiert werden, wenn Sie den Cluster bereitstellen, werden automatisch von IBM aktualisiert. Sie können jedoch automatische Aktualisierungen für manche Add-ons inaktivieren und sie separat über die Master- und Workerknoten aktualisieren. Weitere Informationen finden Sie unter [Cluster-Add-ons aktualisieren](cs_cluster_update.html#addons).  

Kubernetes gibt regelmäßig [Hauptversionen, Nebenversionen oder Patches als Aktualisierungen heraus.](cs_versions.html#version_types). Diese Aktualisierungen können die API-Serverversion von Kubernetes oder andere Komponenten in Ihrem Kubernetes-Master betreffen. IBM aktualisiert die Patchversionen automatisch, aber Sie müssen die Haupt- und Nebenversionen des Masters aktualisieren.
Weitere Informationen finden Sie unter [Kubernetes-Master aktualisieren](cs_cluster_update.html#master).  

Workerknoten in Standardclustern werden in Ihrem {{site.data.keyword.Bluemix_notm}}-Infrastrukturkonto bereitgestellt. Die Workerknoten sind Ihrem Konto zugeordnet und es liegt in Ihrer Verantwortung, zeitnahe Aktualisierungen für die Workerknoten anzufordern, um sicherzustellen, dass das Betriebssystem der Workerknoten und die {{site.data.keyword.containerlong_notm}}-Komponenten die neuesten Sicherheitsupdates und Patches anwenden. Sicherheitspatches und -aktualisierungen von Sicherheitsinformationen werden von IBM Site Reliability Engineers (SREs) zur Verfügung gestellt, die das Linux-Image kontinuierlich überwachen, das auf Ihren Workerknoten installiert ist, um Sicherheitslücken und Probleme bei der Einhaltung von Sicherheitsbestimmungen zu ermitteln. Weitere Informationen finden Sie unter [Workerknoten aktualisieren](cs_cluster_update.html#worker_node).  

## Sind die Kubernetes-Masterknoten und -Workerknoten hoch verfügbar?
{: #ha}
{: faq}

Die {{site.data.keyword.containerlong_notm}}-Architektur und -Infrastruktur wurde konzipiert, um eine hohe Zuverlässigkeit, eine geringe Latenzzeit bei der Verarbeitung und eine maximale Betriebszeit des Service zu gewährleisten. Standardmäßig wird jeder Cluster in {{site.data.keyword.containerlong_notm}}, der Kubernetes Version 1.10 oder höher ausführt, mit mehreren Kubernetes-Masterinstanzen konfiguriert, um die Verfügbarkeit und den Zugriff auf die Clusterressourcen zu gewährleisten, selbst wenn eine oder mehrere Instanzen Ihres Kubernetes-Masters nicht verfügbar sind.  

Sie können die Hochverfügbarkeit Ihres Clusters weiter steigern und Ihre App vor Ausfallzeiten schützen, indem Sie Ihre Workloads über mehrere Workerknoten in mehreren Zonen einer Region verteilen. Diese Konfiguration wird als [Mehrzonencluster](cs_clusters_planning.html#multizone) bezeichnet und stellt sicher, dass auf Ihre App zugegriffen werden kann, selbst wenn ein Workerknoten oder eine gesamte Zone nicht verfügbar ist.  

Erstellen Sie zum Schutz vor dem Ausfall einer ganzen Region [mehrere Cluster und verteilen Sie diese über {{site.data.keyword.containerlong_notm}}-Regionen](cs_clusters_planning.html#multiple_clusters). Indem Sie eine Lastausgleichsfunktion für Ihre Cluster konfigurieren, können Sie einen regionsübergreifenden Lastausgleich und Netzbetrieb für Ihre Cluster erzielen.  

Wenn Sie Daten haben, die auch bei einem Ausfall verfügbar sein müssen, müssen Sie sicherstellen, dass Ihre Daten in einem [persistenten Speicher](cs_storage_planning.html#storage_planning) gesichert sind.  

Weitere Informationen dazu, wie Sie Hochverfügbarkeit für Ihren Cluster erzielen, finden Sie unter [Hochverfügbarkeit für {{site.data.keyword.containerlong_notm}}](cs_ha.html#ha).  

## Welche Möglichkeiten habe ich, meinen Cluster zu sichern? 
{: #secure_cluster}
{: faq}

Sie können integrierte Sicherheitsfeatures in {{site.data.keyword.containerlong_notm}} verwenden, um die Komponenten in Ihrem Cluster, Ihre Daten und App-Bereitstellungen zu schützen und so die Einhaltung von Sicherheitsbestimmungen und die Datenintegrität zu gewährleisten. Verwenden Sie diese Features, um Ihren Kubernetes-API-Server, den etcd-Datenspeicher, Workerknoten, das Netz, den Speicher, die Images und die Bereitstellungen vor böswilligen Angriffen zu schützen. Sie können auch integrierte Protokollierungs- und Überwachungstools nutzen, um böswillige Angriffe und verdächtige Verwendungsmuster zu erkennen.  

Weitere Informationen zu den Komponenten Ihres Clusters und dazu, wie Sie die einzelnen Komponenten schützen können, finden Sie unter [Sicherheit für {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).  

## Bietet der Service Unterstützung für Bare-Metal und GPU? 
{: #bare_metal_gpu}
{: faq}

Ja, Sie können Ihre Workerknoten als physischen Single-Tenant-Server bereitstellen, der auch als Bare-Metal-Server bezeichnet wird. Bare-Metal-Server bieten den Vorteil hoher Leistung für Workloads wie Daten, KI (künstliche Intelligenz) und GPU (Graphics Processing Unit). Außerdem sind alle Hardwareressourcen für Ihre Workloads dediziert, sodass Sie sich keine Sorgen um Leistungsbeeinträchtigungen machen brauchen, weil Sie Ressourcen mit anderen teilen. 

Weitere Informationen zu verfügbaren Bare-Metal-Optionen und zu den Unterschieden zwischen Bare-Metal- und virtuellen Maschinen finden Sie unter [Physische Maschinen (Bare-Metal)](cs_clusters_planning.html#bm). 

## Welche Kubernetes-Versionen unterstützt der Service? 
{: #supported_kube_versions}
{: faq}

{{site.data.keyword.containerlong_notm}} unterstützt momentan mehrere Versionen von Kubernetes. Wenn die aktuellste Version (n) freigegeben wird, werden bis zu 2 Versionen davor (n-2) unterstützt. Versionen, die mehr als zwei Versionen älter sind, als die aktuellsten Version (n-3) werden zuerst nicht mehr verwendet und dann nicht weiter unterstützt. Die folgenden Versionen werden derzeit unterstützt:  

- Aktuelle: 1.12.3
- Standard: 1.10.11
- Sonstige: 1.11.5

Weitere Informationen zu unterstützten Versionen und Aktualisierungsaktionen, die Sie ausführen müssen, um von einer Version zu einer anderen zu wechseln, finden Sie unter [Versionsinformationen und Aktualisierungsaktionen](cs_versions.html#cs_versions). 

## Wo ist der Service verfügbar?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} ist weltweit verfügbar. Sie können Standardcluster in jeder unterstützten {{site.data.keyword.containerlong_notm}}-Region erstellen. Freie Cluster sind nur in ausgewählten Regionen verfügbar.

Weitere Informationen zu unterstützten Regionen finden Sie unter [Regionen und Zonen](cs_regions.html#regions-and-zones). 

## Welche Standards hält der Service ein? 
{: #standards}
{: faq}

{{site.data.keyword.containerlong_notm}} implementiert Kontrollmechanismen, die den folgenden Standards entsprechen:  
- HIPAA
- SOC1
- SOC2 Type 1
- ISAE 3402
- ISO 27001
- ISO 27017
- ISO 27018

## Kann ich IBM Cloud und andere Services mit meinem Cluster verwenden?
{: #integrations}
{: faq}

Sie können {{site.data.keyword.Bluemix_notm}}-Plattform- und Infrastrukturservices sowie Services von Drittanbietern zu Ihrem {{site.data.keyword.containerlong_notm}}-Cluster hinzufügen, um die Automatisierung zu aktivieren, die Sicherheit zu verbessern oder Ihre Überwachungs- und Protokollierungsfunktionen im Cluster zu erweitern. 

Eine Liste der unterstützten Services finden Sie unter [Services integrieren](cs_integrations.html#integrations). 

## Kann ich meinen Cluster in IBM Cloud Public mit Apps verbinden, die in meinem lokalen Rechenzentrum ausgeführt werden?
{: #hybrid}
{: faq}

Sie können Services in {{site.data.keyword.Bluemix_notm}} Public mit Ihrem lokalen Rechenzentrum verbinden, um Ihre eigene Hybrid-Cloud-Konfiguration zu erstellen. Beispiele für die Verwendung von {{site.data.keyword.Bluemix_notm}} Public und Private mit Apps, die in Ihrem lokalen Rechenzentrum ausgeführt werden:  
- Sie erstellen einen Cluster mit {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} Public oder Dedicated, möchten Ihren Cluster aber mit einer lokalen Datenbank verbinden. 
- Sie erstellen einen Kubernetes-Cluster in {{site.data.keyword.Bluemix_notm}} Private in Ihrem eigenen Rechenzentrum und stellen Apps in Ihrem Cluster bereit. Ihre App verwendet jedoch unter Umständen einen {{site.data.keyword.ibmwatson_notm}}-Service wie Tone Analyzer in {{site.data.keyword.Bluemix_notm}} Public. 

Um die Kommunikation zwischen Services zu aktivieren, die in {{site.data.keyword.Bluemix_notm}} Public oder Dedicated ausgeführt werden, und Services, die lokal ausgeführt werden, müssen Sie eine [VPN-Verbindung einrichten](cs_vpn.html#vpn). Informationen zum Verbinden Ihrer {{site.data.keyword.Bluemix_notm}} Public- oder Dedicated-Umgebung mit einer {{site.data.keyword.Bluemix_notm}} Private-Umgebung finden Sie unter [{{site.data.keyword.containerlong_notm}} mit {{site.data.keyword.Bluemix_notm}} Private verwenden](cs_hybrid.html#hybrid_iks_icp). 

Einen Überblick über die unterstützen {{site.data.keyword.containerlong_notm}}-Angebote finden Sie unter [Vergleich von Angeboten und ihren Kombinationen](cs_why.html#differentiation). 

## Kann ich einen IBM Cloud Kubernetes-Service in meinem eigenen Rechenzentrum bereitstellen?
{: #private}
{: faq}

Wenn Sie Ihre Apps nicht in {{site.data.keyword.Bluemix_notm}} Public oder Dedicated verschieben möchten, aber trotzdem die Features von {{site.data.keyword.containerlong_notm}} nutzen möchten, können Sie {{site.data.keyword.Bluemix_notm}} Private installieren. {{site.data.keyword.Bluemix_notm}} Private ist eine Anwendungsplattform, die lokal auf Ihren Maschinen installiert werden kann und mit der Sie lokale containerisierte Apps in Ihrer eigenen kontrollierten Umgebung hinter einer Firewall entwickeln und verwalten können.  

Weitere Informationen finden Sie unter [{{site.data.keyword.Bluemix_notm}} Private – Produktdokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html). 

## Welche Gebühren werden bei der Nutzung des IBM Cloud Kubernetes-Service berechnet?
{: #charges}
{: faq}

Mit {{site.data.keyword.containerlong_notm}}-Clustern können Sie die Rechen-, Netzbetriebs- und Speicherressourcen der IBM Cloud-Infrastruktur (SoftLayer) mit Plattformservices (Watson AI oder Database as a Service 'Compose') verwenden. Mit jeder Ressource sind eigene Gebühren verbunden, die [fest, gemessen, gestaffelt oder reserviert](/docs/billing-usage/how_charged.html#charges) sein können.  
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
  <li><strong>Gestaffelte Pakete</strong>: Sobald eine inklusive Bandbreite überschritten wird, wird die Abrechnung nach einem gestaffelten Nutzungsschema ausgeführt, das abhängig vom Standort variiert. Wenn Sie die Quote für die Staffelung überschreiten, wird möglicherweise auch eine Standarddatenübertragungsgebühr abgerechnet.</li></ul>
  <p>Weitere Informationen finden Sie in [Bandbreitenpakete ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">IP-Teilnetzadressen</dt>
  <dd><p>Wenn Sie einen Standardcluster erstellen, wird ein portierbares öffentliches Teilnetz mit 8 öffentlichen IP-Adressen bestellt und dem Konto monatlich in Rechnung gestellt.</p><p>Wenn Sie im Infrastrukturkonto bereits über Teilnetze verfügen, können Sie stattdessen diese Teilnetze verwenden. Erstellen Sie den Cluster mit dem [Flag](cs_cli_reference.html#cs_cluster_create) `-- no-subnets` und [verwenden Sie die Teilnetze erneut](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Speicher</dt>
  <dd>Wenn Sie Speicher bereitstellen, können Sie den Speichertyp und die Speicherklasse auswählen, die für Ihren Anwendungsfall geeignet sind. Die Gebühren hängen vom Typ des Speichers, dem Standort und den Spezifikationen der Speicherinstanz ab. Bestimmte Speicherlösungen - z. B. Datei- und Blockspeicher - bieten stündliche und monatliche Pläne zur Auswahl an. Informationen zum Auswählen der richtigen Speicherlösung finden Sie unter [Persistenten Hochverfügbarkeitsspeicher planen](cs_storage_planning.html#storage_planning). Weitere Informationen finden Sie unter:
  <ul><li>[Preisstruktur für NFS-Dateispeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Preisstruktur für Blockspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Pläne für Objektspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}}-Services</dt>
  <dd>Jeder Service, den Sie in den Cluster integrieren, weist ein eigenes Preismodell auf. Weitere Informationen finden Sie in jeder Produktdokumentation und im [Kostenschätzungstool ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/pricing/).</dd>

</dl>

Bei monatlichen Ressourcen wird die Nutzung des aktuellen Monats im Folgemonat auf der Basis des Monatsersten abgerechnet. Wenn Sie eine Monatsressource in der Mitte eines Monats bestellen, wird Ihnen für diesen Monat der anteilige Betrag in Rechnung gestellt. Wenn Sie eine Ressource jedoch in der Mitte des Monats kündigen, wird Ihnen trotzdem der volle Betrag für die monatliche Ressource in Rechnung gestellt.
{: note}

## Werden meine Plattform- und Infrastrukturressourcen in einer Rechnung konsolidiert?
{: #bill}
{: faq}

Wenn Sie ein belastbares {{site.data.keyword.Bluemix_notm}}-Konto verwenden, werden Plattform- und Infrastrukturressourcen in einer Rechnung zusammengefasst.
Wenn Sie Ihre {{site.data.keyword.Bluemix_notm}}- und IBM Cloud-Infrastrukturkonten (SoftLayer) miteinander verknüpft haben, erhalten Sie eine [konsolidierte Rechnung](/docs/customer-portal/linking_accounts.html#unifybillaccounts) für Ihre {{site.data.keyword.Bluemix_notm}}-Plattform- und Infrastrukturressourcen.  

## Kann ich meine Kosten schätzen?
{: #cost_estimate}
{: faq}

Ja, Informationen hierzu finden Sie unter [Kosten schätzen](/docs/billing-usage/estimating_costs.html#cost) und [Kostenschätzungstool ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/pricing/).  

## Kann ich meine aktuelle Nutzung anzeigen? 
{: #usage}
{: faq}

Sie können Ihre aktuelle Nutzung und die monatliche Schätzung der Gesamtkosten für Ihre {{site.data.keyword.Bluemix_notm}}-Plattform- und Infrastrukturressourcen prüfen. Weitere Informationen finden Sie unter [Nutzung anzeigen](/docs/billing-usage/viewing_usage.html#viewingusage). Organisieren Sie Ihre Abrechnung, indem Sie Ihre Ressourcen in [Ressourcengruppen](/docs/resources/bestpractice_rgs.html#bp_resourcegroups) gruppieren.  

