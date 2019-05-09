---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# Zuständigkeiten bei der Verwendung von {{site.data.keyword.containerlong_notm}}
Erfahren Sie mehr über die Zuständigkeiten und Nutzungsbedingungen bei der Clusterverwaltung, wenn Sie {{site.data.keyword.containerlong}} verwenden.
{:shortdesc}

## Zuständigkeiten bei der Clusterverwaltung
{: #responsibilities}

Informieren Sie sich über die Zuständigkeiten, die Sie gemeinsam mit IBM bei der Verwaltung von Clustern haben.
{:shortdesc}

**IBM ist für Folgendes verantwortlich:**

- Bereitstellen des Masters, der Workerknoten und Managementkomponenten im Cluster (z. B. Ingress-Lastausgleichsfunktion für Anwendungen) bei der Clustererstellung
- Bereitstellen der Sicherheitsupdates, Überwachen, Isolieren und Wiederherstellen des Kubernetes-Masters für den Cluster
- Durchführen von Versionsaktualisierungen und Sicherheitspatches für Sie zur Anwendung auf Ihre Cluster-Workerknoten
- Überwachen des Zustands der Workerknoten und Bereitstellen der Automatisierung für Aktualisierung und Wiederherstellung dieser Workerknoten
- Ausführen von Automatisierungstasks für das Infrastrukturkonto einschließlich Hinzufügen von Workerknoten, Entfernen von Workerknoten und Erstellen eines Standardteilnetzes
- Verwalten, Aktualisieren und Wiederherstellen der aktiven Komponenten im Cluster (z. B. Ingress-Lastausgleichsfunktion für Anwendungen und Speicher-Plug-in)
- Bereitstellen der Speicherdatenträger auf Anforderung von PVCs (Persistant Volume Claims)
- Bereitstellen der Sicherheitseinstellungen auf allen Workerknoten

</br>

**Sie sind für Folgendes verantwortlich:**

- [Konfigurieren des {{site.data.keyword.containerlong_notm}}-API-Schlüssels mit den geeigneten Berechtigungen für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer) und anderer {{site.data.keyword.Bluemix_notm}}-Services](/docs/containers?topic=containers-users#api_key)
- [Bereitstellen und Verwalten der Kubernetes-Ressourcen (z. B. Pods, Services und Bereitstellungen) im Cluster](/docs/containers?topic=containers-app#app_cli)
- [Nutzen der Funktionalität des Service und von Kubernetes zur Sicherstellung einer hohen Verfügbarkeit der Apps](/docs/containers?topic=containers-app#highly_available_apps)
- [Hinzufügen oder Entfernen von Clusterkapazitäten durch Ändern der Größe von Worker-Pools](/docs/containers?topic=containers-clusters#add_workers)
- [Aktivieren des VLAN-Spannings und Beibehalten des zonenübergreifenden Ausgleichs bei Mehrzonen-Worker-Pools](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [Erstellen öffentlicher und privater VLANs in der IBM Cloud-Infrastruktur (SoftLayer) zur Netzisolation Ihres Clusters](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [Sicherstellen der Netzkonnektivität zu den Kubernetes-Serviceendpunkt-URLs für alle Workerknoten](/docs/containers?topic=containers-firewall#firewall) <p class="note">Wenn ein Workerknoten sowohl über öffentliche als auch private VLANs verfügt, dann ist die Netzkonnektivität konfiguriert. Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie die Kommunikation zwischen Workerknoten und Cluster-Master zulassen, indem Sie den [privaten Serviceendpunkt aktivieren](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) oder eine [Gateway-Einheit konfigurieren](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway). Wenn Sie eine Firewall einrichten, müssen Sie die Einstellungen der Firewall so verwalten und konfigurieren, dass der Zugriff auf {{site.data.keyword.containerlong_notm}}- und andere {{site.data.keyword.Bluemix_notm}}-Services zugelassen wird, die Sie mit dem Cluster verwenden.</p>
- [Aktualisieren des Master-'kube-apiserver', wenn Kubernetes-Versionsaktualisierungen verfügbar sind](/docs/containers?topic=containers-update#master)
- [Aktualisieren der Workerknoten auf Haupt-, Neben- und Patchversionen](/docs/containers?topic=containers-update#worker_node) <p class="note">Sie können das Betriebssystem Ihres Workerknotens nicht ändern oder sich bei dem Workerknoten anmelden. Die Workerknotenaktualisierungen werden von IBM als vollständiges Workerknoten-Image bereitgestellt, das die neuesten Sicherheitspatches enthält. Zum Anwenden der Aktualisierungen muss das Image des Workerknotens erneut erstellt und der Workerknoten mit dem neuen Image erneut geladen werden. Schlüssel für den Rootbenutzer werden automatisch gewechselt, wenn der Workerknoten erneut geladen wird. </p>
- [Überwachen des Zustands Ihres Clusters durch Einrichten der Protokollweiterleitung für Ihre Clusterkomponenten](/docs/containers?topic=containers-health#health).   
- [Wiederherstellen von fehlerhaften Workerknoten durch Ausführen der geeigneten `kubectl`-Befehle (z. B. `cordon` oder `drain`) und durch Ausführen der geeigneten `ibmcloud ks`-Befehle (z. B. `reboot`, `reload` oder `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot))
- [Hinzufügen oder Entfernen von Teilnetzen in der IBM Cloud-Infrastruktur (SoftLayer) nach Bedarf](/docs/containers?topic=containers-subnets#subnets)
- [Sichern und Wiederherstellen von Daten im persistenten Speicher in der IBM Cloud-Infrastruktur (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- Einrichten der [Protokollierungs-](/docs/containers?topic=containers-health#logging) und [Überwachungsservices](/docs/containers?topic=containers-health#view_metrics) zum Unterstützen des Zustands und der Leistung Ihres Clusters
- [Zustandsüberwachung für Workerknoten mit automatischer Wiederherstellung konfigurieren](/docs/containers?topic=containers-health#autorecovery)
- Audit für Ereignisse durchführen, die Ressourcen in Ihrem Cluster ändern, wie beispielsweise durch Verwenden von [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) zum Anzeigen von benutzerinitiierten Aktivitäten, die den Status Ihrer {{site.data.keyword.containerlong_notm}}-Instanz ändern

<br />


## Unsachgemäßer Gebrauch von {{site.data.keyword.containerlong_notm}}
{: #terms}

Der unsachgemäße Gebrauch von {{site.data.keyword.containerlong_notm}} ist untersagt.
{:shortdesc}

Ein unsachgemäßer Gebrauch umfasst:

*   Illegale Aktivitäten
*   Verteilung und Ausführung von Malware
*   {{site.data.keyword.containerlong_notm}} beschädigen oder Verwendung von {{site.data.keyword.containerlong_notm}} durch einen anderen Benutzer stören
*   Schäden verursachen oder Verwendung durch einen anderen Benutzer stören
*   Unbefugter Zugriff auf Services oder Systeme
*   Unberechtigte Änderung von Services oder Systemen
*   Verletzung von Rechten anderer Benutzer

Alle Nutzungsbedingungen finden Sie unter [Bedingungen für Cloud-Services](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms).
