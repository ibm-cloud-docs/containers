---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-30"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Warum {{site.data.keyword.containerlong_notm}}?
{: #cs_ov}

{{site.data.keyword.containershort}} bietet durch die Kombination von Docker- und Kubernetes-Technologien leistungsstarke Tools, ein intuitives Benutzererlebnis sowie integrierte Sicherheit und Isolation, um die Bereitstellung, den Betrieb, die Skalierung und die Überwachung von containerisierten Apps über einen Cluster von Berechnungshosts zu automatisieren.
{:shortdesc}

## Vorteile durch die Verwendung des Service
{: #benefits}

Cluster werden auf Rechenhosts bereitgestellt, die native Kubernetes-Funktionalität und durch {{site.data.keyword.IBM_notm}} hinzugefügte Funktionen zur Verfügung stellen.
{:shortdesc}

|Vorteil|Beschreibung|
|-------|-----------|
|Single-Tenant-Kubernetes-Cluster mit Isolation der Berechnungs-, Netz- und Speicherinfrastruktur|<ul><li>Erstellen Sie Ihre eigene angepasste Infrastruktur, die den Anforderungen Ihrer Organisation entspricht.</li><li>Ermöglicht die Einrichtung eines dedizierten und geschützten Kubernetes-Masters sowie von Workerknoten, virtuellen Netzen und Speicher unter Nutzung der von IBM Cloud Infrastructure (SoftLayer) bereitgestellten Ressourcen.</li><li>Der komplett verwaltete Kubernetes-Master, der kontinuierlich von {{site.data.keyword.IBM_notm}} überwacht und aktualisiert wird, um Ihren Cluster verfügbar zu halten.</li><li>Ermöglicht das Speichern persistenter Daten, die gemeinsame Nutzung von Daten durch Kubernetes-Pods und bei Bedarf die Wiederherstellung von Daten mit dem integrierten und sicheren Datenträgerservice.</li><li>Bietet volle Unterstützung für alle nativen Kubernetes-APIs.</li></ul>|
|Einhaltung von Sicherheitsbestimmungen für Images mit Vulnerability Advisor|<ul><li>Ermöglicht die Einrichtung einer eigenen geschützten privaten Docker-Image-Registry, in der Images gespeichert und von allen Benutzern der Organisation gemeinsam genutzt werden können.</li><li>Bietet den Vorteil des automatischen Scannens von Images in Ihrer privaten {{site.data.keyword.Bluemix_notm}}-Registry.</li><li>Ermöglicht die Überprüfung von Empfehlungen für das im Image verwendete Betriebssystem, um potenzielle Schwachstellen zu beheben.</li></ul>|
|Kontinuierliche Überwachung des Clusterzustands|<ul><li>Über das Cluster-Dashboard können Sie den Zustand Ihrer Cluster, Workerknoten und Containerbereitstellungen rasch anzeigen und verwalten.</li><li>Ermöglicht die Feststellung detaillierter Metriken zur Auslastung mit {{site.data.keyword.monitoringlong}} und die rasche Erweiterung des Clusters als Reaktion auf die Arbeitslast.</li><li>Stellt detaillierte Protokollinformationen zu Clusteraktivitäten über den {{site.data.keyword.loganalysislong}} bereit.</li></ul>|
|Sichere Offenlegung von Apps gegenüber der Allgemeinheit|<ul><li>Sie haben die Auswahl zwischen einer öffentlichen IP-Adresse, einer von {{site.data.keyword.IBM_notm}} bereitgestellten Route oder Ihrer eigenen angepassten Domäne, um aus dem Internet auf Services in Ihrem Cluster zuzugreifen.</li></ul>|
|Integration des {{site.data.keyword.Bluemix_notm}}-Service|<ul><li>Ermöglicht das Hinzufügen zusätzlicher Funktionalität zu Ihrer App durch die Integration von {{site.data.keyword.Bluemix_notm}}-Services wie zum Beispiel Watson-APIs, Blockchain, Datenservices oder Internet of Things.</li></ul>|



<br />


## Vergleich von kostenlosen Clustern und Standardclustern
{: #cluster_types}

Sie können einen kostenlosen Cluster oder beliebig viele Standardcluster erstellen. Testen Sie kostenlose Cluster, um sich mit einigen Kubernetes-Leistungsmerkmalen vertraut zu machen. Oder erstellen Sie Standardcluster, um das vollständige Leistungsspektrum von Kubernetes zum Bereitstellen von Apps zu nutzen.
{:shortdesc}

|Merkmale|Kostenlose Cluster|Standardcluster|
|---------------|-------------|-----------------|
|[Netzbetrieb in Clustern](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Öffentlicher App-Zugriff durch einen NodePort-Service](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Benutzerzugriffsverwaltung](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Zugriff auf den {{site.data.keyword.Bluemix_notm}}-Service über den Cluster und die Apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Plattenspeicher auf Workerknoten für Speicher](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Persistenter NFS-dateibasierter Speicher mit Datenträgern](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Öffentlicher oder privater App-Zugriff durch einen Lastausgleichsservice](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Öffentlicher App-Zugriff durch einen Ingress-Service](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Portierbare öffentliche IP-Adressen](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Protokollierung und Überwachung](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|
|[Verfügbar in {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Funktion verfügbar" style="width:32px;" />|

<br />



## Zuständigkeiten beim Cluster-Management
{: #responsibilities}

Informieren Sie sich über die Zuständigkeiten, die Sie gemeinsam mit IBM bei der Verwaltung von Clustern haben.
{:shortdesc}

**IBM ist für Folgendes verantwortlich:**

- Bereitstellen des Masters, der Workerknoten und Managementkomponenten im Cluster (z. B. Ingress-Controller) bei der Clustererstellung
- Verwalten der Aktualisierungen, Überwachen und Wiederherstellen des Kubernetes-Masters für den Cluster
- Überwachen des Zustands der Workerknoten und Bereitstellen der Automatisierung für Aktualisierung und Wiederherstellung dieser Workerknoten
- Ausführen von Automatisierungstasks für das Infrastrukturkonto einschließlich Hinzufügen von Workerknoten, Entfernen von Workerknoten und Erstellen eines Standardteilnetzes
- Verwalten, Aktualisieren und Wiederherstellen der aktiven Komponenten im Cluster (z. B. Ingress-Controller und Speicher-Plug-in)
- Bereitstellen der Speicherdatenträger auf Anforderung von PVCs (Persistant Volume Claims)
- Bereitstellen der Sicherheitseinstellungen auf allen Workerknoten

</br>
**Sie sind für Folgendes verantwortlich:**

- [Bereitstellen und Verwalten der Kubernetes-Ressourcen (z. B. Pods, Services und Bereitstellungen) im Cluster](cs_app.html#app_cli)
- [Nutzen der Funktionalität des Service und von Kubernetes zur Sicherstellung einer hohen Verfügbarkeit der Apps](cs_app.html#highly_available_apps)
- [Hinzufügen oder Entfernen von Kapazitäten über die CLI durch Hinzufügen und Entfernen von Workerknoten](cs_cli_reference.html#cs_worker_add)
- [Erstellen öffentlicher und privater VLANs in IBM Cloud Infrastructure (SoftLayer) zur Netzisolation Ihres Clusters](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [Sicherstellen der Netzkonnektivität zur Kubernetes-Master-URL für alle Workerknoten](cs_firewall.html#firewall) <p>**Hinweis**: Wenn ein Workerknoten sowohl über öffentliche als auch private VLANs verfügt, dann ist die Netzkonnektivität konfiguriert. Wenn für den Workerknoten ausschließlich ein privates VLAN konfiguriert wurde, dann ist eine Vyatta-Einheit erforderlich, um die Netzkonnektivität bereitzustellen.</p>
- [Aktualisieren der Master-Komponente 'kube-apiserver' und der Workerknoten, wenn Aktualisierungen für Haupt- und Nebenversionen von Kubernetes verfügbar sind](cs_cluster_update.html#master)
- [Wiederherstellen von fehlerhaften Workerknoten durch Ausführen der geeigneten `kubectl`-Befehle (z. B. `cordon` oder `drain`) und durch Ausführen der geeigneten `bx cs`-Befehle (z. B. `reboot`, `reload` oder `delete`](cs_cli_reference.html#cs_worker_reboot))
- [Hinzufügen oder Entfernen von Teilnetzen in der IBM Cloud-Infrastruktur (SoftLayer) nach Bedarf](cs_subnets.html#subnets)
- [Sichern und Wiederherstellen von Daten im persistenten Speicher in IBM Cloud Infrastructure (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## Missbrauch von Containern
{: #terms}

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
