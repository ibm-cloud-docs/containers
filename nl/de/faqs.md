---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, compliance, security standards

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
{:download: .download}
{:preview: .preview}
{:faq: data-hd-content-type='faq'}



# Häufig gestellte Fragen
{: #faqs}

## Was ist Kubernetes?
{: #kubernetes}
{: faq}

Kubernetes ist eine Open-Source-Plattform für die Verwaltung containerisierter Workloads und Services über mehrere Hosts hinweg und bietet Verwaltungstools für die Bereitstellung, Automatisierung, Überwachung und Skalierung containerisierter Apps mit geringer bis gar keiner manuellen Intervention. Alle Container, aus denen sich Ihr Microservice zusammensetzt, werden in Pods gruppiert, einer logischen Einheit zur Sicherstellung einer einfachen Verwaltung und Erkennung. Diese Pods werden auf Rechenhosts ausgeführt, die in einem portierbaren, erweiterbaren und im Störfall selbst-heilenden Kubernetes-Cluster verwaltet werden.
{: shortdesc}

Weitere Informationen zu Kubernetes finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational).

## Wie funktioniert IBM Cloud Kubernetes Service?
{: #kubernetes_service}
{: faq}

Mit {{site.data.keyword.containerlong_notm}} können Sie Ihren eigenen Kubernetes-Cluster zum Bereitstellen und Verwalten von containerisierten Apps in {{site.data.keyword.cloud_notm}} erstellen. Ihre containerisierten Apps werden auf Rechenhosts der IBM Cloud-Infrastruktur gehostet, die als Workerknoten bezeichnet werden. Sie können Ihre Rechenhosts als [virtuelle Maschinen](/docs/containers?topic=containers-planning_worker_nodes#vm) mit gemeinsam genutzten oder dedizierten Ressourcen oder als [Bare-Metal-Maschinen](/docs/containers?topic=containers-planning_worker_nodes#bm) bereitstellen, die für die GPU- (Graphics Processing Unit) und SDS-Verwendung (Software-defined Storage) optimiert werden können. Ihre Workerknoten werden von einem hoch verfügbaren Kubernetes-Master gesteuert, der von IBM konfiguriert, überwacht und verwaltet wird. Sie können die {{site.data.keyword.containerlong_notm}}-API oder -CLI verwenden, um mit Ihren Clusterinfrastrukturressourcen zu arbeiten, und die Kubernetes-API oder -CLI, um Ihre Bereitstellungen und Services zu verwalten.

Weitere Informationen zur Konfiguration Ihrer Clusterressourcen finden Sie unter [Servicearchitektur](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture). Eine Liste von Funktionen und Vorteilen finden Sie unter [Warum {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-cs_ov#cs_ov).

## Warum sollte ich IBM Cloud Kubernetes Service verwenden?
{: #faq_benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} ist ein verwaltetes Kubernetes-Angebot, das leistungsfähige Tools, eine intuitive Benutzererfahrung und integrierte Sicherheit für die schnelle Bereitstellung von Apps zur Verfügung stellt, die Sie an Cloud-Services für {{site.data.keyword.ibmwatson}}, KI, Internet der Dinge, DevOps, Sicherheit und Datenanalyse binden können. Als zertifizierter Kubernetes-Provider stellt {{site.data.keyword.containerlong_notm}} intelligente Planung, automatische Fehlerbehebung, horizontale Skalierung, Serviceerkennung und Lastausgleich, automatisierte Rollouts und Rollbacks sowie Verwaltung von geheimen Schlüsseln und Konfigurationsverwaltung bereit. Der Service bietet außerdem erweiterte Funktionen für vereinfachtes Cluster-Management, Containersicherheit und Isolationsrichtlinien, die Möglichkeit, einen eigenen Cluster zu entwerfen, und integrierte operationale Tools für Konsistenz in der Bereitstellung.

Eine detaillierte Übersicht über die Funktionen und Vorteile finden Sie unter [Warum {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-cs_ov#cs_ov).

## Welche Containerplattformen stehen für meinen Cluster zur Verfügung?
{: #container_platforms}
{: faq}

Bei {{site.data.keyword.containerlong_notm}} können Sie eine der beiden folgenden Container-Management-Plattformen auswählen: IBM Version von Community-Kubernetes und Red Hat OpenShift on IBM Cloud. Die von Ihnen ausgewählte Containerplattform wird auf Ihrem Cluster-Master und den Workerknoten installiert. Später können Sie die [Version aktualisieren](/docs/containers?topic=containers-update#update). Ein Rollback zu einer Vorgängerversion oder der Wechsel zu einer anderen Containerplattform ist jedoch nicht möglich. Wenn Sie mehrere Containerplattformen verwenden möchten, erstellen Sie für jede der Plattformen einen separaten Cluster.

Weitere Informationen hierzu finden Sie unter [Vergleich zwischen OpenShift- und Community-Kubernetes-Clustern](/docs/openshift?topic=openshift-why_openshift#openshift_kubernetes).

<dl>
  <dt>Kubernetes</dt>
    <dd>[Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/) ist eine Open-Source-Containerorchestrierungsplattform für den Produktionsbereich, die Sie zum Automatisieren, Skalieren und Verwalten Ihrer containerisierten Apps verwenden können, die unter einem Ubuntu-Betriebssystem arbeiten. Mit der [{{site.data.keyword.containerlong_notm}}-Version](/docs/containers?topic=containers-cs_versions#cs_versions) erhalten Sie Zugriff auf die Funktionen der Community-Kubernetes-API, die in der Community als **Betaversion** oder höher eingestuft werden. Kubernetes-**Alpha**-Funktionen, für die Änderungen vorbehalten sind, werden im Allgemeinen nicht standardmäßig aktiviert. Mit Kubernetes können Sie verschiedene Ressourcen (z. B. geheime Schlüssel, Bereitstellungen und Services) kombinieren, um hochverfügbare, containerisierte Apps sicher zu erstellen und zu verwalten.<br><br>
    Als ersten Schritt müssen Sie einen [Kubernetes-Cluster erstellen](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial).</dd>
  <dt>OpenShift</dt>
    <dd>Red Hat OpenShift on IBM Cloud ist eine auf Kubernetes basierende Plattform, die speziell zur Beschleunigung der Bereitstellungsprozesse für Ihre containerisierten Apps konzipiert wurde, die unter einem Red Hat Enterprise Linux 7-Betriebssystem ausgeführt werden. Sie können vorhandene OpenShift-Workloads über lokale und ferne Clouds hinweg orchestrieren und skalieren, um eine portierbare Hybridlösung bereitzustellen, die auch in Multi-Cloud-Szenarios auf dieselbe Weise eingesetzt werden kann. <br><br>
    Um sich mit dem Produkt vertraut zu machen, können Sie das [Lernprogramm für Red Hat OpenShift on IBM Cloud](/docs/openshift?topic=openshift-openshift_tutorial) durcharbeiten.</dd>
</dl>

## Beinhaltet der Service einen verwalteten Kubernetes-Masterknoten sowie Workerknoten?
{: #managed_master_worker}
{: faq}

Jeder Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}} wird von einem dedizierten Kubernetes-Master gesteuert, der von IBM in einem IBM eigenen Konto der {{site.data.keyword.cloud_notm}}-Infrastruktur verwaltet wird. Der Kubernetes-Master, einschließlich aller Masterkomponenten, Rechen-, Netzbetriebs- und Speicherressourcen, wird fortlaufend von IBM Site Reliability Engineers (SREs) überwacht. Von SREs werden die neuesten Sicherheitsstandards angewendet, böswillige Aktivitäten ermittelt und korrigiert und somit die Zuverlässigkeit und Verfügbarkeit von {{site.data.keyword.containerlong_notm}} sichergestellt. Add-ons wie Fluentd für die Protokollierung, die automatisch installiert werden, wenn Sie den Cluster bereitstellen, werden automatisch von IBM aktualisiert. Sie können jedoch automatische Aktualisierungen für manche Add-ons inaktivieren und sie separat über die Master- und Workerknoten aktualisieren. Weitere Informationen finden Sie unter [Cluster-Add-ons aktualisieren](/docs/containers?topic=containers-update#addons).

Kubernetes gibt regelmäßig [Hauptversionen, Nebenversionen oder Patches als Aktualisierungen heraus.](/docs/containers?topic=containers-cs_versions#version_types). Diese Aktualisierungen können die API-Serverversion von Kubernetes oder andere Komponenten in Ihrem Kubernetes-Master betreffen. IBM aktualisiert die Patchversionen automatisch, aber Sie müssen die Haupt- und Nebenversionen des Masters aktualisieren. Weitere Informationen finden Sie unter [Kubernetes-Master aktualisieren](/docs/containers?topic=containers-update#master).

Workerknoten in Standardclustern werden in Ihrem Konto der {{site.data.keyword.cloud_notm}}-Infrastruktur bereitgestellt. Die Workerknoten sind Ihrem Konto zugeordnet und es liegt in Ihrer Verantwortung, zeitnahe Aktualisierungen für die Workerknoten anzufordern, um sicherzustellen, dass das Betriebssystem der Workerknoten und die {{site.data.keyword.containerlong_notm}}-Komponenten die neuesten Sicherheitsupdates und Patches anwenden. Sicherheitspatches und -aktualisierungen von Sicherheitsinformationen werden von IBM Site Reliability Engineers (SREs) zur Verfügung gestellt, die das Linux-Image kontinuierlich überwachen, das auf Ihren Workerknoten installiert ist, um Sicherheitslücken und Probleme bei der Einhaltung von Sicherheitsbestimmungen zu ermitteln. Weitere Informationen finden Sie unter [Workerknoten aktualisieren](/docs/containers?topic=containers-update#worker_node).

## Sind die Kubernetes-Masterknoten und -Workerknoten hoch verfügbar?
{: #faq_ha}
{: faq}

Die {{site.data.keyword.containerlong_notm}}-Architektur und -Infrastruktur wurde konzipiert, um eine hohe Zuverlässigkeit, eine geringe Latenzzeit bei der Verarbeitung und eine maximale Betriebszeit des Service zu gewährleisten. Standardmäßig wird jeder Cluster in {{site.data.keyword.containerlong_notm}} mit mehreren Kubernetes-Masterinstanzen konfiguriert, um die Verfügbarkeit und den Zugriff auf die Clusterressourcen zu gewährleisten, selbst wenn eine oder mehrere Instanzen Ihres Kubernetes-Masters nicht verfügbar sind.

Sie können die Hochverfügbarkeit Ihres Clusters weiter steigern und Ihre App vor Ausfallzeiten schützen, indem Sie Ihre Workloads über mehrere Workerknoten in mehreren Zonen einer Region verteilen. Diese Konfiguration wird als [Mehrzonencluster](/docs/containers?topic=containers-ha_clusters#multizone) bezeichnet und stellt sicher, dass auf Ihre App zugegriffen werden kann, selbst wenn ein Workerknoten oder eine gesamte Zone nicht verfügbar ist.

Erstellen Sie zum Schutz vor dem Ausfall einer ganzen Region [mehrere Cluster und verteilen Sie diese über {{site.data.keyword.containerlong_notm}}-Regionen](/docs/containers?topic=containers-ha_clusters#multiple_clusters). Indem Sie eine Netzlastausgleichsfunktion (NLB) für Ihre Cluster konfigurieren, können Sie einen regionsübergreifenden Lastausgleich und Netzbetrieb für Ihre Cluster erzielen.

Wenn Sie Daten haben, die auch bei einem Ausfall verfügbar sein müssen, müssen Sie sicherstellen, dass Ihre Daten in einem [persistenten Speicher](/docs/containers?topic=containers-storage_planning#storage_planning) gesichert sind.

Weitere Informationen dazu, wie Sie Hochverfügbarkeit für Ihren Cluster erzielen, finden Sie unter [Hochverfügbarkeit für {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-ha#ha).

## Welche Möglichkeiten habe ich, meinen Cluster zu sichern?
{: #secure_cluster}
{: faq}

Sie können integrierte Sicherheitsfeatures in {{site.data.keyword.containerlong_notm}} verwenden, um die Komponenten in Ihrem Cluster, Ihre Daten und App-Bereitstellungen zu schützen und so die Einhaltung von Sicherheitsbestimmungen und die Datenintegrität zu gewährleisten. Verwenden Sie diese Features, um Ihren Kubernetes-API-Server, den etcd-Datenspeicher, Workerknoten, das Netz, den Speicher, die Images und die Bereitstellungen vor böswilligen Angriffen zu schützen. Sie können auch integrierte Protokollierungs- und Überwachungstools nutzen, um böswillige Angriffe und verdächtige Verwendungsmuster zu erkennen.

Weitere Informationen zu den Komponenten Ihres Clusters und dazu, wie Sie die einzelnen Komponenten schützen können, finden Sie unter [Sicherheit für {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-security#security).

## Welche Zugriffsrichtlinien erteile ich meinen Clusterbenutzern?
{: #faq_access}
{: faq}

{{site.data.keyword.containerlong_notm}} verwendet {{site.data.keyword.iamshort}} (IAM), um Zugriff auf Clusterressourcen über IAM-Plattformrollen und auf Kubernetes-RBAC-Richtlinien (RBAC - Role-Based Access Control) über IAM-Servicerollen zu erteilen. Weitere Informationen zu Zugriffsrichtlinientypen finden Sie unter [Richtige Zugriffsrichtlinie und Rolle für Benutzer auswählen](/docs/containers?topic=containers-users#access_roles).
{: shortdesc}

Die Zugriffsrichtlinien, die Sie Benutzern zuweisen, variieren je nachdem, was Ihre Benutzer tun können sollen. Weitere Informationen dazu, welche Rollen welche Aktionstypen autorisieren, finden Sie auf der [Referenzseite für den Benutzerzugriff](/docs/containers?topic=containers-access_reference) oder über die Links in der folgenden Tabelle. Informationen zu den Schritten zum Zuordnen von Richtlinien finden Sie unter [Benutzern Zugriff auf Cluster über {{site.data.keyword.cloud_notm}} IAM erteilen](/docs/containers?topic=containers-users#platform).

| Anwendungsfall | Beispielrollen und -bereich |
| --- | --- |
| App-Auditor | [Plattformrolle 'Anzeigeberechtigter' für einen Cluster, eine Region oder eine Ressourcengruppe](/docs/containers?topic=containers-access_reference#view-actions), [Servicerolle 'Leseberechtigter' für einen Cluster, eine Region oder eine Ressourcengruppe](/docs/containers?topic=containers-access_reference#service). |
| App-Entwickler | [Plattformrolle 'Editor' für einen Cluster](/docs/containers?topic=containers-access_reference#editor-actions), [an einem Namensbereich orientierte Servicerolle 'Schreibberechtigter'](/docs/containers?topic=containers-access_reference#service), [Bereichsrolle 'Cloud Foundry-Entwickler'](/docs/containers?topic=containers-access_reference#cloud-foundry). |
| Abrechnung | [Plattformrolle 'Anzeigeberechtigter' für einen Cluster, eine Region oder eine Ressourcengruppe](/docs/containers?topic=containers-access_reference#view-actions). |
| Cluster erstellen | Berechtigungen auf Kontoebene, die mit dem API-Schlüssel und den Superuser-Berechtigungsnachweisen für die Infrastruktur festgelegt werden. Individuelle Benutzerberechtigungen für die Plattformrolle 'Administrator' für {{site.data.keyword.containerlong_notm}} und die Plattformrolle 'Administrator' für {{site.data.keyword.registrylong_notm}}. Weitere Informationen finden Sie unter [Clustererstellung vorbereiten](/docs/containers?topic=containers-clusters#cluster_prepare).|
| Clusteradministrator | [Plattformrolle 'Administrator' für einen Cluster](/docs/containers?topic=containers-access_reference#admin-actions), [nicht an einem Namensbereich orientierte Servicerolle 'Manager' (für den gesamten Cluster)](/docs/containers?topic=containers-access_reference#service).|
| DevOps-Operator | [Plattformrolle 'Operator' für einen Cluster](/docs/containers?topic=containers-access_reference#operator-actions), [nicht an einem Namensbereich orientierte Servicerolle 'Schreibberechtigter' (für den gesamten Cluster)](/docs/containers?topic=containers-access_reference#service), [Bereichsrolle 'Cloud Foundry-Entwickler'](/docs/containers?topic=containers-access_reference#cloud-foundry).  |
| Operator oder Site Reliability Engineer | [Plattformrolle 'Administrator' für einen Cluster, eine Region oder eine Ressourcengruppe](/docs/containers?topic=containers-access_reference#admin-actions), [Servicerolle 'Leseberechtigter' für einen Cluster oder eine Region](/docs/containers?topic=containers-access_reference#service) oder [Servicerolle 'Manager' für alle Clusternamensbereiche](/docs/containers?topic=containers-access_reference#service), um `kubectl top nodes/pods`-Befehle verwenden zu können. |
{: caption="Typen von Rollen, die Sie zuordnen können, um unterschiedlichen Anwendungsfällen zu entsprechen." caption-side="top"}

## Wo finde ich eine Liste der Sicherheitsbulletins, die meinen Cluster betreffen?
{: #faq_security_bulletins}
{: faq}

Wenn Sicherheitslücken in Kubernetes gefunden werden, veröffentlicht Kubernetes CVEs in Sicherheitsbulletins, um Benutzer zu informieren und die Aktionen zu beschreiben, die Benutzer zur Korrektur der Sicherheitslücke ausführen müssen. Kubernetes-Sicherheitsbulletins, die {{site.data.keyword.containerlong_notm}}-Benutzer oder die {{site.data.keyword.cloud_notm}}-Plattform betreffen, werden im [{{site.data.keyword.cloud_notm}}-Sicherheitsbulletin](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) veröffentlicht.

Einige CVEs erfordern die neueste Patchaktualisierung für eine Kubernetes-Version, die Sie als Teil des regulären [Clusteraktualisierungsprozesses](/docs/containers?topic=containers-update#update) in {{site.data.keyword.containerlong_notm}} installieren können. Stellen Sie sicher, dass Sie Sicherheitspatches zeitgerecht anwenden, um Ihren Cluster gegen böswillige Angriffe zu schützen. Weitere Informationen zum Inhalt eines Sicherheitspatchs finden Sie im [Versionsänderungsprotokoll](/docs/containers?topic=containers-changelog#changelog).

## Bietet der Service Unterstützung für Bare-Metal und GPU?
{: #bare_metal_gpu}
{: faq}

Ja, Sie können Ihre Workerknoten als physischen Single-Tenant-Server bereitstellen, der auch als Bare-Metal-Server bezeichnet wird. Bare-Metal-Server bieten den Vorteil hoher Leistung für Workloads wie Daten, KI (künstliche Intelligenz) und GPU (Graphics Processing Unit; Grafikprozessor). Außerdem sind alle Hardwareressourcen für Ihre Workloads dediziert, sodass Sie sich keine Sorgen um Leistungsbeeinträchtigungen machen brauchen, weil Sie Ressourcen mit anderen teilen.

Weitere Informationen zu verfügbaren Bare-Metal-Optionen und zu den Unterschieden zwischen Bare-Metal- und virtuellen Maschinen finden Sie unter [Physische Maschinen (Bare-Metal)](/docs/containers?topic=containers-planning_worker_nodes#bm).

## Welche Kubernetes-Versionen unterstützt der Service?
{: #supported_kube_versions}
{: faq}

{{site.data.keyword.containerlong_notm}} unterstützt momentan mehrere Versionen von Kubernetes. Wenn die aktuellste Version (n) freigegeben wird, werden bis zu 2 Versionen davor (n-2) unterstützt. Versionen, die mehr als zwei Versionen älter sind, als die aktuellsten Version (n-3) werden zuerst nicht mehr verwendet und dann nicht weiter unterstützt. Die folgenden Versionen werden derzeit unterstützt:


**Unterstützte Kubernetes-Versionen**:
*   Aktuelle: 1.14.4 
*   Standard: 1.13.8
*   Sonstige: 1.12.10

Weitere Informationen zu unterstützten Versionen und Aktualisierungsaktionen, die Sie ausführen müssen, um von einer Version zu einer anderen zu wechseln, finden Sie unter [Versionsinformationen und Aktualisierungsaktionen](/docs/containers?topic=containers-cs_versions#cs_versions).

Verfügen Sie über einen [OpenShift-Cluster](/docs/openshift?topic=openshift-openshift_tutorial)? Die unterstützte OpenShift-Version ist 3.11, die auch Kubernetes 1.11 umfasst.
{: note}

## Wo ist der Service verfügbar?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} ist weltweit verfügbar. Sie können Standardcluster in jeder unterstützten {{site.data.keyword.containerlong_notm}}-Region erstellen. Kostenlose Cluster sind nur in ausgewählten Regionen verfügbar.

Weitere Informationen zu unterstützten Regionen finden Sie unter [Standorte](/docs/containers?topic=containers-regions-and-zones#regions-and-zones).

## Welche Standards hält der Service ein?
{: #standards}
{: faq}

{{site.data.keyword.containerlong_notm}} implementiert Kontrollmechanismen, die den folgenden Standards entsprechen:
- EU-US-Datenschutzschild und Swiss-US Privacy Shield
- Health Insurance Portability and Accountability Act (HIPAA)
- Service Organization Control Standards (SOC 1, SOC 2 Typ 1)
- International Standard on Assurance Engagements 3402 (ISAE 3402), Assurance Reports on Controls at a Service Organization
- International Organization for Standardization (ISO 27001, ISO 27017, ISO 27018)
- Payment Card Industry Data Security Standard (PCI DSS)

## Kann ich IBM Cloud und andere Services mit meinem Cluster verwenden?
{: #faq_integrations}
{: faq}

Sie können {{site.data.keyword.cloud_notm}}-Plattform- und Infrastrukturservices sowie Services von Drittanbietern zu Ihrem {{site.data.keyword.containerlong_notm}}-Cluster hinzufügen, um die Automatisierung zu aktivieren, die Sicherheit zu verbessern oder Ihre Überwachungs- und Protokollierungsfunktionen im Cluster zu erweitern.

Eine Liste der unterstützten Services finden Sie unter [Services integrieren](/docs/containers?topic=containers-supported_integrations#supported_integrations).

## Kann ich meinen Cluster in IBM Cloud Public mit Apps verbinden, die in meinem lokalen Rechenzentrum ausgeführt werden?
{: #hybrid}
{: faq}

Sie können Services in {{site.data.keyword.cloud_notm}} Public mit Ihrem lokalen Rechenzentrum verbinden, um Ihre eigene Hybrid-Cloud-Konfiguration zu erstellen. Beispiele für die Verwendung von {{site.data.keyword.cloud_notm}} Public und Private mit Apps, die in Ihrem lokalen Rechenzentrum ausgeführt werden:
- Sie erstellen einen Cluster mit {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.cloud_notm}} Public, möchten Ihren Cluster aber mit einer lokalen Datenbank verbinden.
- Sie erstellen einen Kubernetes-Cluster in {{site.data.keyword.cloud_notm}} Private in Ihrem eigenen Rechenzentrum und stellen Apps in Ihrem Cluster bereit. Ihre App verwendet jedoch unter Umständen einen {{site.data.keyword.ibmwatson_notm}}-Service wie Tone Analyzer in {{site.data.keyword.cloud_notm}} Public.

Um die Kommunikation zwischen Services zu aktivieren, die in {{site.data.keyword.cloud_notm}} Public ausgeführt werden, und Services, die lokal ausgeführt werden, müssen Sie eine [VPN-Verbindung einrichten](/docs/containers?topic=containers-vpn#vpn). Informationen zum Verbinden Ihrer {{site.data.keyword.cloud_notm}} Public- oder Dedicated-Umgebung mit einer {{site.data.keyword.cloud_notm}} Private-Umgebung finden Sie unter [{{site.data.keyword.containerlong_notm}} mit {{site.data.keyword.cloud_notm}} Private verwenden](/docs/containers?topic=containers-hybrid_iks_icp#hybrid_iks_icp).

Einen Überblick über die unterstützen {{site.data.keyword.containerlong_notm}}-Angebote finden Sie unter [Vergleich von Angeboten und ihren Kombinationen](/docs/containers?topic=containers-cs_ov#differentiation).

## Kann ich IBM Cloud Kubernetes Service in meinem eigenen Rechenzentrum bereitstellen?
{: #private}
{: faq}

Wenn Sie Ihre Apps nicht in {{site.data.keyword.cloud_notm}} Public verschieben möchten, aber trotzdem die Features von {{site.data.keyword.containerlong_notm}} nutzen möchten, können Sie {{site.data.keyword.cloud_notm}} Private installieren. {{site.data.keyword.cloud_notm}} Private ist eine Anwendungsplattform, die lokal auf Ihren Maschinen installiert werden kann und mit der Sie lokale containerisierte Apps in Ihrer eigenen kontrollierten Umgebung hinter einer Firewall entwickeln und verwalten können.

Weitere Informationen finden Sie unter [{{site.data.keyword.cloud_notm}} Private – Produktdokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).

## Welche Gebühren werden bei der Nutzung von IBM Cloud Kubernetes Service berechnet?
{: #charges}
{: faq}

Mit {{site.data.keyword.containerlong_notm}}-Clustern können Sie die Rechen-, Netzbetriebs- und Speicherressourcen der IBM Cloud-Infrastruktur mit Plattformservices (Watson AI oder Database as a Service 'Compose') verwenden. Mit jeder Ressource sind eigene Gebühren verbunden, die [fest, gemessen, gestaffelt oder reserviert](/docs/billing-usage?topic=billing-usage-charges#charges) sein können.
* [Workerknoten](#nodes)
* [Abgehender Netzbetrieb](#bandwidth)
* [IP-Teilnetzadressen](#subnet_ips)
* [Speicher](#persistent_storage)
* [{{site.data.keyword.cloud_notm}} Services](#services)
* [Red Hat OpenShift on IBM Cloud](#rhos_charges)

<dl>
  <dt id="nodes">Workerknoten</dt>
    <dd><p>Cluster können über zwei Haupttypen an Workerknoten verfügen: virtuelle Maschinen (VMs) oder physische Maschinen (Bare-Metal-Maschinen). Die Verfügbarkeit und Preisstruktur der Typen (Maschinentyp) sind von der Zone abhängig, in der Sie Ihren Cluster bereitstellen.</p>
    <p><strong>Virtuelle Maschinen</strong> bieten eine größere Flexibilität, schnellere Bereitstellungszeiten und mehr automatische Skalierbarkeitsfunktionen als Bare-Metal-Maschinen und sind zudem kostengünstiger als Bare-Metal-Maschinen. Im Vergleich zu Bare-Metal-Maschinen müssen bei virtuellen Maschinen jedoch Leistungskompromisse in Kauf genommen werden, zum Beispiel in Bezug auf die Gb/s-Werte im Netzbetrieb, die Schwellenwerte für RAM und Speicher sowie die Speicheroptionen. Beachten Sie, dass sich die folgenden Faktoren auf die Kosten für virtuelle Maschinen auswirken:</p>
    <ul><li><strong>Gemeinsam genutzt im Gegensatz zu dediziert</strong>: Wenn Sie die zugrunde liegende Hardware der virtuellen Maschine gemeinsam nutzen, sind die Kosten niedriger als bei dedizierter Hardware, die physischen Ressourcen sind jedoch nicht dediziert für Ihre virtuelle Maschine.</li>
    <li><strong>Nur stündliche Abrechnung</strong>: Die stündliche Abrechnung bietet mehr Flexibilität beim schnellen Bestellen und Stornieren virtueller Maschinen.
    <li><strong>Nach Stunden pro Monat gestaffelt</strong>: Die stündliche Abrechnung erfolgt gestaffelt. Da die Bestellung einer virtuellen Maschine für die Preisstufe für die Stunden in einem Abrechnungsmonat fortbesteht, sinkt die stündliche Rate, die berechnet wird. Die Preisstufen für die Stunden sind 0 - 150 Stunden, 151 - 290 Stunden, 291 - 540 Stunden und über 541 Stunden.</li></ul>
    <p><strong>Physische Maschinen oder Bare-Metal-Systeme</strong> bieten den Vorteil hoher Leistung für Workloads wie Daten, KI (künstliche Intelligenz) und GPU (Graphics Processing Unit; Grafikprozessoren). Außerdem sind alle Hardwareressourcen für Ihre Workloads dediziert, sodass Sie sich keine Sorgen um Leistungsbeeinträchtigungen machen brauchen, weil sie Ressourcen mit anderen teilen. Beachten Sie, dass sich die folgenden Faktoren auf die Kosten für Bare-Metal-Maschinen auswirken:</p>
    <ul><li><strong>Nur monatliche Abrechnung</strong>: Alle Bare-Metal-Maschinen werden monatlich abgerechnet.</li>
    <li><strong>Längerer Bestellprozess</strong>: Nachdem Sie einen Bare-Metal-Server bestellt oder storniert haben, wird der Prozess manuell in Ihrem Konto für die IBM Cloud-Infrastruktur ausgeführt. Die Ausführung kann daher länger als einen Geschäftstag dauern.</li></ul>
    <p>Weitere Informationen zu den Maschinenspezifikationen finden Sie unter [Verfügbare Hardware für Workerknoten](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes).</p></dd>
  <dt id="bandwidth">Öffentliche Bandbreite</dt>
    <dd><p>Die Bandbreite bezieht sich auf die öffentliche Datenübertragung des eingehenden und abgehenden Netzverkehrs, sowohl zu als auch von den {{site.data.keyword.cloud_notm}}-Ressourcen in den Rechenzentren auf der ganzen Welt.</p>
    <p>Die öffentliche Bandbreite wird nach Gb berechnet. Wenn Sie Ihre aktuelle Zusammenfassung der Bandbreite überprüfen möchten, melden Sie sich an der [{{site.data.keyword.cloud_notm}}-Konsole](https://cloud.ibm.com/) an, wählen Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") die Option **Klassische Infrastruktur** aus und wählen Sie anschließend die Seite **Netz > Bandbreite > Zusammenfassung** aus.</p>
    <p>Überprüfen Sie die folgenden Faktoren, die sich auf die Gebühren für die öffentliche Bandbreite auswirken:</p>
    <ul><li><strong>Standort</strong>: Wie bei den Workerknoten variieren die Gebühren in Abhängigkeit von der Zone, in der die Ressourcen bereitgestellt werden.</li>
    <li><strong>Inklusive Bandbreite oder nutzungsabhängig</strong>: Die Workerknotenmaschinen können mit einer bestimmten Zuordnung für abgehenden Netzdatenverkehr pro Monat bereitgestellt werden, zum Beispiel 250 GB für virtuelle Maschinen (VMs) oder 500 GB für Bare-Metal-Maschinen. Alternativ wird auch eine nutzungsabhängig Zuordnung auf der Basis der Gb-Nutzung bereitgestellt.</li>
    <li><strong>Gestaffelte Pakete</strong>: Sobald eine inklusive Bandbreite überschritten wird, wird die Abrechnung nach einem gestaffelten Nutzungsschema ausgeführt, das abhängig vom Standort variiert. Wenn Sie die Quote für die Staffelung überschreiten, wird möglicherweise auch eine Standarddatenübertragungsgebühr abgerechnet.</li></ul>
    <p>Weitere Informationen finden Sie in [Bandbreitenpakete ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/bandwidth).</p></dd>
  <dt id="subnet_ips">IP-Teilnetzadressen</dt>
    <dd><p>Wenn Sie einen Standardcluster erstellen, wird ein portierbares öffentliches Teilnetz mit 8 öffentlichen IP-Adressen bestellt und dem Konto monatlich in Rechnung gestellt.</p><p>Wenn Sie im Infrastrukturkonto bereits über Teilnetze verfügen, können Sie stattdessen diese Teilnetze verwenden. Erstellen Sie den Cluster mit dem [Flag](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_create) `--no-subnets` und [verwenden Sie die Teilnetze erneut](/docs/containers?topic=containers-subnets#subnets_custom).
    </dd>
  <dt id="persistent_storage">Speicher</dt>
    <dd>Wenn Sie Speicher bereitstellen, können Sie den Speichertyp und die Speicherklasse auswählen, die für Ihren Anwendungsfall geeignet sind. Die Gebühren hängen vom Typ des Speichers, dem Standort und den Spezifikationen der Speicherinstanz ab. Bestimmte Speicherlösungen - z. B. Datei- und Blockspeicher - bieten stündliche und monatliche Pläne zur Auswahl an. Informationen zum Auswählen der richtigen Speicherlösung finden Sie unter [Persistenten Hochverfügbarkeitsspeicher planen](/docs/containers?topic=containers-storage_planning#storage_planning). Weitere Informationen finden Sie unter:
    <ul><li>[Preisstruktur für NFS-Dateispeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</li>
    <li>[Preisstruktur für Blockspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</li>
    <li>[Pläne für Objektspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>
  <dt id="services">{{site.data.keyword.cloud_notm}}-Services</dt>
    <dd>Jeder Service, den Sie in den Cluster integrieren, weist ein eigenes Preismodell auf. Lesen Sie die jeweilige Produktdokumentation und verwenden Sie die {{site.data.keyword.cloud_notm}}-Konsole, um die [Kosten zu schätzen](/docs/billing-usage?topic=billing-usage-cost#cost).</dd>
  <dt id="rhos_charges">Red Hat OpenShift on IBM Cloud</dt>
    <dd>Wenn Sie einen [Red Hat OpenShift on IBM Cloud-Cluster](/docs/openshift?topic=openshift-openshift_tutorial) erstellen, werden Ihre Workerknoten mit dem Red Hat Enterprise Linux-Betriebssystem installiert, wodurch sich der Preis für die [Workerknotenmaschinen](#nodes) erhöht. Sie müssen außerdem über eine OpenShift-Lizenz verfügen, durch die monatlich zusätzlich zu den stündlichen VM-Kosten oder den monatlichen Bare-Metal-Kosten weitere Kosten anfallen. Die OpenShift-Lizenz gilt für jeweils zwei Cores (Kerne) des Workerknotentyps. Wenn Sie Ihre Workerknoten vor Ende des Monats löschen, kann Ihre monatliche Lizenz für andere Workerknoten im Worker-Pool verwendet werden. Weitere Informationen zu OpenShift-Clustern finden Sie unter [Red Hat OpenShift on IBM Cloud-Cluster erstellen](/docs/openshift?topic=openshift-openshift_tutorial).</dd>
</dl>
<br><br>

Bei Ressourcen mit monatlicher Abrechnung wird die Nutzung am ersten des Monats für den vorherigen Monat berechnet. Wenn Sie eine Monatsressource in der Mitte eines Monats bestellen, wird Ihnen für diesen Monat der anteilige Betrag in Rechnung gestellt. Wenn Sie eine Ressource jedoch in der Mitte des Monats kündigen, wird Ihnen trotzdem der volle Betrag für die monatliche Ressource in Rechnung gestellt.
{: note}

## Werden meine Plattform- und Infrastrukturressourcen in einer Rechnung konsolidiert?
{: #bill}
{: faq}

Wenn Sie ein belastbares {{site.data.keyword.cloud_notm}}-Konto verwenden, werden Plattform- und Infrastrukturressourcen in einer Rechnung zusammengefasst.
Wenn Sie Ihr {{site.data.keyword.cloud_notm}}-Konto und das Konto der IBM Cloud-Infrastruktur miteinander verknüpft haben, erhalten Sie eine [konsolidierte Rechnung](/docs/customer-portal?topic=customer-portal-unifybillaccounts#unifybillaccounts) für Ihre {{site.data.keyword.cloud_notm}}-Plattformressourcen und -Infrastrukturressourcen.

## Kann ich meine Kosten schätzen?
{: #cost_estimate}
{: faq}

Ja, siehe [Kostenschätzung](/docs/billing-usage?topic=billing-usage-cost#cost). Beachten Sie, dass einige Kosten in der Schätzung nicht berücksichtigt werden, wie zum Beispiel die gestaffelte Preisgestaltung bei erhöhter Nutzung pro Stunde. Weitere Informationen finden Sie unter [Welche Gebühren werden bei der Nutzung von {{site.data.keyword.containerlong_notm}} berechnet?](#charges).

## Kann ich meine aktuelle Nutzung anzeigen?
{: #usage}
{: faq}

Sie können Ihre aktuelle Nutzung und die monatliche Schätzung der Gesamtkosten für Ihre {{site.data.keyword.cloud_notm}}-Plattformressourcen und -Infrastrukturressourcen prüfen. Weitere Informationen finden Sie unter [Nutzung anzeigen](/docs/billing-usage?topic=billing-usage-viewingusage#viewingusage). Organisieren Sie Ihre Abrechnung, indem Sie Ihre Ressourcen in [Ressourcengruppen](/docs/resources?topic=resources-bp_resourcegroups#bp_resourcegroups) gruppieren.
