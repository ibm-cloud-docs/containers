---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Informationen zu {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containershort}} bietet durch die Kombination von Docker- und Kubernetes-Technologien leistungsstarke Tools, ein intuitives Benutzererlebnis sowie integrierte Sicherheit und Isolation, um die Bereitstellung, den Betrieb, die Skalierung und die Überwachung von containerisierten Apps über einen Cluster von Berechnungshosts zu automatisieren.
{:shortdesc}


<br />


## Docker-Container
{: #cs_ov_docker}

Docker ist ein Open-Source-Projekt, das von dotCloud 2013 veröffentlicht wurde. Aufbauend auf Features der vorhandenen LXC (Linux Containers)-Technologie hat sich Docker zu einer Softwareplattform entwickelt, die Sie zum schnellen Testen, Bereitstellen und Skalieren von Apps einsetzen können. Docker packt Software in standardisierten Einheiten, die als Container bezeichnet werden und alle Elemente enthalten, die eine App für die Ausführung benötigt.
{:shortdesc}

Erfahren Sie mehr über einige grundlegende Docker-Konzepte: 

<dl>
<dt>Image</dt>
<dd>Ein Docker-Image wird auf der Grundlage einer Dockerfile erstellt. Hierbei handelt es sich  um eine Textdatei, die definiert, wie das Image erstellt wird und welche Buildartefakte darin enthalten sein sollen, z. B. die App, die Konfiguration der App und ihre Abhängigkeiten. Images werden immer auf der Grundlage anderer Images erstellt, wodurch sie schneller konfiguriert werden können. So wird die Hauptarbeit für ein Image von jemand anderem ausgeführt und Sie müssen das Image nur noch für Ihre Nutzung optimieren. </dd>
<dt>Registry</dt>
<dd>Eine Image-Registry ist ein Ort, an dem Docker-Images gespeichert, abgerufen und von gemeinsam genutzt werden können. Die in einer Registry gespeicherten Images können öffentlich verfügbar sein (öffentliche Registry) oder aber für eine kleine Gruppe von Benutzern zugänglich sein (private Registry). {{site.data.keyword.containershort_notm}} bietet öffentliches Images, z. B. 'ibmliberty', mit denen Sie Ihre erste containerisierte App erstellen können. Was Unternehmensanwendungen betrifft, so sollten Sie jedoch eine private Registry (wie z. B. die von {{site.data.keyword.Bluemix_notm}} bereitgestellte Registry) verwenden, um zu verhindern, dass Ihre Images durch nicht berechtigte Benutzer verwendet werden.

</dd>
<dt>Container</dt>
<dd>Jeder Container wird auf der Grundlage eines Images erstellt. Ein Container ist eine gepackte App mit den zugehörigen Abhängigkeiten, sodass die App in eine andere Umgebungen verlagert und dort ohne Änderungen ausgeführt werden kann. Im Unterschied zu virtuellen Maschinen virtualisieren Container keine Einheiten, die zugehörigen Betriebssysteme und die zugrunde liegende Hardware. Nur App-Code, Laufzeit, Systemtools, Bibliotheken und Einstellungen werden in dem Container gepackt. Container werden als isolierte Prozesse auf Rechenhosts ausgeführt und nutzen dasselbe Hostbetriebssystem und dieselben Hardwareressourcen. Dadurch ist ein Container schlanker, leichter portierbar und effizienter als eine virtuelle Maschine.</dd>
</dl>

### Die wichtigsten Vorteile der Verwendung von Containern
{: #container_benefits}

<dl>
<dt>Container sind agil</dt>
<dd>Container vereinfachen die Systemverwaltung durch die Bereitstellung standardisierter Umgebungen für Entwicklungs- und Produktionsbereitstellungen. Die schlanke Laufzeitumgebung ermöglicht schnelle Scale-up- und Scale-down-Operationen von Bereitstellungen. Reduzieren Sie die Komplexität bei der Verwaltung verschiedener Betriebssystemplattformen und ihrer zugrunde liegenden Infrastrukturen, indem Sie Container verwenden, um alle Apps in allen Infrastrukturen schnell und zuverlässig bereitstellen und ausführen zu können. </dd>
<dt>Container sind klein</dt>
<dd>Sie können in dem Speicherbereich, den eine einzelne virtuelle Maschine benötigt, viele Container unterbringen.
</dd>
<dt>Container sind portierbar</dt>
<dd><ul>
  <li>Verwenden Sie Teile von Images wieder, um Container zu erstellen. </li>
  <li>Verschieben Sie App-Code schnell von Staging- in Produktionsumgebungen. </li>
  <li>Automatisieren Sie Ihre Prozesse mit Continuous Delivery-Tools. </li> </ul></dd>
</dl>


<br />


## Grundlegende Informationen zu Kubernetes
{: #kubernetes_basics}

Kubernetes wurde von Google als Teil des Borg-Projekts entwickelt und im Jahr 2014 an die Open-Source-Community übergeben. Kubernetes vereint über 15 Jahre Google-Forschung in der Ausführung einer containerisierten Infrastruktur mit Produktionsarbeitslasten, Open-Source-Beiträgen und Managementtools für Docker-Container und stellt nun eine isolierte und sichere App-Plattform für die Verwaltung von Containern zur Verfügung, die portierbar, erweiterbar und bei Auftreten von Failover-Situationen selbstheilend ist.
{:shortdesc}

Im folgenden Diagramm sind einige grundlegende Kubernetes-Konzepte veranschaulicht. 

![Konfiguration für die Bereitstellung](images/cs_app_tutorial_components1.png)

<dl>
<dt>Konto</dt>
<dd>Das Konto bezieht sich auf Ihr {{site.data.keyword.Bluemix_notm}}-Konto.</dd>

<dt>Cluster</dt>
<dd>Ein Kubernetes-Cluster besteht aus einem oder mehreren Rechenhosts, die als Workerknoten bezeichnet werden. Workerknoten werden von einem Kubernetes-Master verwaltet, der alle Kubernetes-Ressourcen im Cluster zentral steuert und überwacht. Wenn Sie also die Ressourcen für eine containerisierte App bereitstellen, entscheidet der Kubernetes-Master, auf welchen Workerknoten diese Ressourcen bereitgestellt werden sollen, und zwar unter Berücksichtigung der Bereitstellungsanforderungen und der im Cluster verfügbaren Kapazität. Kubernetes-Ressourcen sind Services, Bereitstellungen und Pods. </dd>

<dt>Service</dt>
<dd>Ein Service ist eine Kubernetes-Ressource, die eine Gruppe von Pods zusammenfasst und diesen Pods eine Netzverbindung bereitstellt, ohne hierbei die tatsächlichen IP-Adressen der einzelnen Pods preiszugeben. Mithilfe von Services können Sie Ihre App innerhalb Ihres Clusters oder im öffentlichen Internet zugänglich machen.
</dd>

<dt>Bereitstellung</dt>
<dd>Eine Bereitstellung ist eine Kubernetes-Ressource, in der Sie Informationen zu anderen Ressourcen oder Funktionalitäten angeben, die für die Ausführung Ihrer App erforderlich sind, z. B. Services, persistenter Speicher oder Annotationen. Sie dokumentieren eine Bereitstellung in einer YAML-Konfigurationsdatei und wenden diese dann auf den Cluster an. Der Kubernetes-Master konfiguriert die Ressourcen und stellt Container in Pods auf den Workerknoten mit verfügbarer Kapazität bereit.
</br></br>
Definieren Sie Aktualisierungsstrategien für Ihre App. Dabei können Sie unter anderem die Anzahl von Pods angeben, die Sie bei einer rollierenden Aktualisierung hinzufügen wollen, und festlegen, wie viele Pods zur gleichen Zeit nicht verfügbar sein dürfen. Wenn Sie eine rollierende Aktualisierung durchführen, prüft die Bereitstellung, ob die Aktualisierung funktioniert, und stoppt den Rollout, wenn Fehler erkannt werden.</dd>

<dt>Pod</dt>
<dd>Jede containerisierte App, die in einem Cluster bereitgestellt wird, wird von einer Kubernetes-Ressource namens Pod bereitgestellt, ausgeführt und verwaltet. Pods stellen kleine bereitstellbare Einheiten in einem Kubernetes-Cluster dar und werden verwendet, um Container zu gruppieren, die als einzelne Einheit verarbeitet werden müssen. In den meisten Fällen wird ein Container in einem eigenen Pod bereitgestellt. Es kann jedoch erforderlich sein, dass für eine App ein Container und weitere Hilfscontainer in einem Pod bereitgestellt werden, damit diese Container mit derselben privaten IP-Adresse referenziert werden können.</dd>

<dt>App</dt>
<dd>Eine App kann sich auf eine gesamte App oder eine Komponente einer App beziehen. Sie können Komponenten einer App in verschiedenen Pods oder Workerknoten bereitstellen. </br></br>
Weitere Informationen zur Kubernetes-Terminologie finden Sie im <a href="cs_tutorials.html#cs_cluster_tutorial" target="_blank">Lernprogramm</a>. </dd>

</dl>

<br />


## Vorteile durch die Verwendung von Clustern
{: #cs_ov_benefits}

Cluster werden auf Rechenhosts bereitgestellt, die native Kubernetes-Funktionalität und durch {{site.data.keyword.IBM_notm}} hinzugefügte Funktionen zur Verfügung stellen.
{:shortdesc}

|Vorteil|Beschreibung|
|-------|-----------|
|Single-Tenant-Kubernetes-Cluster mit Isolation der Berechnungs-, Netz- und Speicherinfrastruktur|<ul><li>Erstellen Sie Ihre eigene angepasste Infrastruktur, die den Anforderungen Ihrer Organisation entspricht. </li><li>Ermöglicht die Einrichtung eines dedizierten und geschützten Kubernetes-Masters sowie von Workerknoten, virtuellen Netzen und Speicher unter Nutzung der von IBM Cloud Infrastructure (SoftLayer) bereitgestellten Ressourcen.</li><li>Ermöglicht das Speichern persistenter Daten, die gemeinsame Nutzung von Daten durch Kubernetes-Pods und bei Bedarf die Wiederherstellung von Daten mit dem integrierten und sicheren Datenträgerservice.</li><li>Der komplett verwaltete Kubernetes-Master, der kontinuierlich von {{site.data.keyword.IBM_notm}} überwacht und aktualisiert wird, um Ihren Cluster verfügbar zu halten.</li><li>Bietet volle Unterstützung für alle nativen Kubernetes-APIs.</li></ul>|
|Einhaltung von Sicherheitsbestimmungen für Images mit Vulnerability Advisor|<ul><li>Ermöglicht die Einrichtung einer eigenen geschützten privaten Docker-Image-Registry, in der Images gespeichert und von allen Benutzern der Organisation gemeinsam genutzt werden können.</li><li>Bietet den Vorteil des automatischen Scannens von Images in Ihrer privaten {{site.data.keyword.Bluemix_notm}}-Registry.</li><li>Ermöglicht die Überprüfung von Empfehlungen für das im Image verwendete Betriebssystem, um potenzielle Schwachstellen zu beheben.</li></ul>|
|Automatische Skalierung von Apps|<ul><li>Ermöglicht das Definieren angepasster Richtlinien, um Apps auf der Grundlage der CPU-Auslastung und des Speicherbedarfs vertikal nach oben oder nach unten zu skalieren.</li></ul>|
|Kontinuierliche Überwachung des Clusterzustands|<ul><li>Über das Cluster-Dashboard können Sie den Zustand Ihrer Cluster, Workerknoten und Containerbereitstellungen rasch anzeigen und verwalten.</li><li>Ermöglicht die Feststellung detaillierter Metriken zur Auslastung mit {{site.data.keyword.monitoringlong}} und die rasche Erweiterung des Clusters als Reaktion auf die Arbeitslast.</li><li>Stellt detaillierte Protokollinformationen zu Clusteraktivitäten über den {{site.data.keyword.loganalysislong}} bereit.</li></ul>|
|Automatische Wiederherstellung von nicht ordnungsgemäß funktionierenden Containern|<ul><li>Führt kontinuierlich Statusprüfungen für Container aus, die auf einem Workerknoten bereitgestellt sind.</li><li>Bewirkt bei Ausfällen die automatische Neuerstellung von Containern.</li></ul>|
|Serviceerkennung und Service-Management|<ul><li>Ermöglicht das zentrale Registrieren von App-Services, um diese für andere Apps in Ihrem Cluster verfügbar zu machen, jedoch ohne sie öffentlich zugänglich zu machen.</li><li>Ermöglicht das Erkennen registrierter Services, ohne dass Sie den Überblick über wechselnde IP-Adressen oder Container-IDs behalten müssen, und versetzt Sie in die Lage, die Vorteile des automatischen Routing zu verfügbaren Instanzen auszuschöpfen.</li></ul>|
|Sichere Offenlegung von Services gegenüber der Allgemeinheit|<ul><li>Ermöglicht das Einrichten privater Overlay-Netze mit voller Unterstützung der Lastausgleichsfunktion (Load Balancer) und voller Ingress-Unterstützung, um Ihre Apps öffentlich zugänglich zu machen und Arbeitslasten über mehrere Workerknoten gleichmäßig zu verteilen, ohne den Überblick über die wechselnden IP-Adressen in Ihrem Cluster behalten zu müssen.</li><li>Sie haben die Auswahl zwischen einer öffentlichen IP-Adresse, einer von {{site.data.keyword.IBM_notm}} bereitgestellten Route oder Ihrer eigenen angepassten Domäne, um aus dem Internet auf Services in Ihrem Cluster zuzugreifen.</li></ul>|
|Integration des {{site.data.keyword.Bluemix_notm}}-Service|<ul><li>Ermöglicht das Hinzufügen zusätzlicher Funktionalität zu Ihrer App durch die Integration von {{site.data.keyword.Bluemix_notm}}-Services wie zum Beispiel Watson-APIs, Blockchain, Datenservices oder Internet of Things und hilft den Benutzern des Clusters, den Prozess der Entwicklung von Apps und Verwaltung von Containern zu vereinfachen.</li></ul>|
{: caption="Tabelle 1. Vorteile durch die Verwendung von Clustern mit {{site.data.keyword.containerlong_notm}}" caption-side="top"}

<br />


## Servicearchitektur
{: #cs_ov_architecture}

Jeder Workerknoten ist mit einer von {{site.data.keyword.IBM_notm}} verwalteten Docker Engine, getrennten Berechnungsressourcen, Netzbetrieb und Datenträgerservice eingerichtet und verfügt ferner über integrierte Sicherheitsfeatures, die die Isolation, die Funktionalität für die Verwaltung von Ressourcen und die Einhaltung der Sicherheitsbestimmungen für die Workerknoten sicherstellen. Der Workerknoten kommuniziert über sichere TLS-Zertifikate und eine openVPN-Verbindung mit dem Master.
{:shortdesc}

*Abbildung 1. Kubernetes-Architektur und Netzbetrieb in {{site.data.keyword.containershort_notm}}*

![{{site.data.keyword.containerlong_notm}} Kubernetes-Architektur](images/cs_org_ov.png)

Das Diagramm veranschaulicht, was von Ihnen in einem Cluster und was von IBM verwaltet wird. Weitere Informationen zu diesen Verwaltungstasks finden Sie in [Zuständigkeiten beim Cluster-Management](cs_planning.html#responsibilities).

<br />


## Missbrauch von Containern
{: #cs_terms}

Der unsachgemäße Gebrauch von {{site.data.keyword.containershort_notm}} ist untersagt.
{:shortdesc}

Ein unsachgemäßer Gebrauch umfasst:

*   Illegale Aktivitäten
*   Verteilung und Ausführung von Malware
*   {{site.data.keyword.containershort_notm}} beschädigen oder Verwendung von {{site.data.keyword.containershort_notm}} durch einen anderen Benutzer stören
*   Schäden verursachen oder Verwendung durch einen anderen Benutzer stören
*   Unbefugter Zugriff auf Services oder Systeme
*   Unberechtigte Änderung von Services oder Systemen
*   Verletzung von Rechten anderer Benutzer

Alle Nutzungsbedingungen finden Sie unter [Bedingungen für Cloud-Services](/docs/navigation/notices.html#terms).
