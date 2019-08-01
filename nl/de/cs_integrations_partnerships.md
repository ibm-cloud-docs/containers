---

copyright:
  years: 2014, 2019
lastupdated: "2019-05-31"

keywords: kubernetes, iks, helm

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
{:preview: .preview}


# IBM Cloud Kubernetes Service-Partner
{: #service-partners}

IBM ist bestrebt, {{site.data.keyword.containerlong_notm}} zum besten Kubernetes Service für das Migrieren, Bearbeiten und Verwalten Ihrer Kubernetes-Workloads zu machen. Um Ihnen alle Funktionen zur Verfügung zu stellen, die Sie für die Ausführung von Produktionsworkloads in der Cloud benötigen, wird {{site.data.keyword.containerlong_notm}} über Partnerschaften zusammen mit Services anderer Provider verwendet und kann Ihren Cluster so um erstklassige Protokollierungs-, Überwachungs- und Speichertools erweitern.
{: shortdesc}

Prüfen Sie unsere Partner und die Vorteile der von ihnen bereitgestellten Lösungen. Informationen zu anderen proprietären Open-Source-Services von {{site.data.keyword.Bluemix_notm}} und anderen Anbietern, die Sie in Ihrem Cluster verwenden können, finden Sie unter [Integration von {{site.data.keyword.Bluemix_notm}} und Produkten anderer Anbieter](/docs/containers?topic=containers-ibm-3rd-party-integrations).

## LogDNA
{: #logdna-partner}

{{site.data.keyword.la_full_notm}} stellt [LogDNA ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://logdna.com/) als Service eines anderen Anbieters bereit, mit dem Sie Ihrem Cluster und Ihren Apps intelligente Protokollierungsfunktionen hinzufügen können. 

### Vorteile
{: #logdna-benefits}

In der folgenden Tabelle finden Sie eine Liste der Hauptvorteile, die sich für Sie aus der Verwendung von LogDNA ergeben.
{: shortdesc}

|Vorteil|Beschreibung|
|-------------|------------------------------|
|Zentralisierung von Protokollmanagement und Protokollanalyse|Wenn Sie Ihren Cluster als Protokollquelle konfigurieren, beginnt LogDNA automatisch mit der Erfassung von Protokollinformationen für Ihre Workerknoten, Pods und Apps sowie Ihr Netzwerk. Ihre Protokolle werden von LogDNA automatisch geparst, indexiert, mit Tags versehen und aggregiert sowie im LogDNA-Dashboard visualisiert, sodass Sie ohne großen Aufwand in Ihre Clusterressourcen eintauchen können. Sie können das integrierte Diagrammtool verwenden, um die gängigsten Fehlercodes oder Protokolleinträge zu visualisieren. |
|Leichte Auffindbarkeit mit einer Google vergleichbaren Suchsyntax|LogDNA verwendet eine mit Google vergleichbare Suchsyntax, die Standardbegriffe sowie `AND`- und `OR`-Operationen unterstützt und das Ausschließen und Kombinieren von Suchbegriffen ermöglicht, damit Sie Ihre Protokolle leichter finden können. Durch die intelligente Indexierung der Protokolle können Sie jederzeit zu einem bestimmten Protokolleintrag springen. |
|In-Transit- und At-Rest-Verschlüsselung|LogDNA verschlüsselt Ihre Protokolle automatisch, um sie während der Übertragung (In Transit) und im Ruhezustand (At Rest) zu schützen. |
|Angepasste Alerts und Protokollansichten|Sie können das Dashboard verwenden, um die Protokolle zu finden, die Ihren Suchkriterien entsprechen, diese Protokolle in einer Ansicht zu speichern und diese Ansicht mit anderen Benutzern gemeinsam zu nutzen, um das Debugging für alle Teammitglieder zu vereinfachen. Sie können diese Ansicht auch verwenden, um einen Alert zu erstellen, den Sie an nachgeordnete Systeme senden können, wie PagerDuty, Slack oder E-Mail.   |
|Standarddashboards oder angepasste Dashboards|Sie können zwischen einer Vielzahl vorhandener Dashboards wählen oder ein eigenes Dashboard erstellen, um Protokolle so zu visualisieren, wie Sie es benötigen. |

### Integration mit {{site.data.keyword.containerlong_notm}}
{: #logdna-integration}

LogDNA wird von {{site.data.keyword.la_full_notm}} bereitgestellt, einem {{site.data.keyword.Bluemix_notm}}-Plattformservice, den Sie mit Ihrem Cluster verwenden können. {{site.data.keyword.la_full_notm}} wird von LogDNA in Partnerschaft mit IBM betrieben.
{: shortdesc}

Um LogDNA in Ihrem Cluster verwenden zu können, müssen Sie eine Instanz von {{site.data.keyword.la_full_notm}} in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto bereitstellen und Ihre Kubernetes-Cluster als Protokollquelle konfigurieren. Nach der Konfiguration des Clusters werden Protokolle automatisch erfasst und an Ihre {{site.data.keyword.la_full_notm}}-Serviceinstanz weitergeleitet. Sie können das {{site.data.keyword.la_full_notm}}-Dashboard verwenden, um auf Ihre Protokolle zuzugreifen.   

Weitere Informationen finden Sie unter [Kubernetes-Cluster-Protokolle mit {{site.data.keyword.la_full_notm}} verwalten](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-kube).

### Abrechnung und Unterstützung
{: #logdna-billing-support}

{{site.data.keyword.la_full_notm}} ist vollständig in das {{site.data.keyword.Bluemix_notm}}-Unterstützungssystem integriert. Wenn ein Problem bei der Verwendung von {{site.data.keyword.la_full_notm}} auftritt, posten Sie eine Frage im Kanal `logdna-on-iks` in [{{site.data.keyword.containerlong_notm}} Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com/) oder öffnen Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support). Melden Sie bei Slack mit Ihrer IBMid an. Wenn Sie keine IBMid für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung in diesen Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://bxcs-slack-invite.mybluemix.net/) an.

## Sysdig
{: #sydig-partner}

{{site.data.keyword.mon_full_notm}} stellt [Sysdig Monitor ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://sysdig.com/products/monitor/) als cloudnatives Analysesystem eines anderen Anbieters bereit, mit dem Sie einen Einblick in die Leistung und den Status Ihrer Rechenhosts, Apps, Container und Netze erhalten können.
{: shortdesc}

### Vorteile
{: #sydig-benefits}

In der folgenden Tabelle finden Sie eine Liste der Hauptvorteile, die sich für Sie aus der Verwendung von Sysdig ergeben.
{: shortdesc}

|Vorteil|Beschreibung|
|-------------|------------------------------|
|Automatischer Zugriff auf cloudnative und angepasste Prometheus-Metriken|Wählen Sie aus einer Vielzahl von vordefinierten cloudnativen und angepassten Prometheus-Metriken aus, um einen Einblick in die Leistung und den Status Ihrer Rechenhosts, Apps, Container und Netze zu erhalten. |
|Fehlerbehebung mit erweiterten Filtern|Sysdig Monitor erstellt Netztopologien, die zeigen, wie Ihre Workerknoten verbunden sind und wie Ihre Kubernetes Services miteinander kommunizieren. Sie können von Ihren Workerknoten zu Containern und einzelnen Systemaufrufen navigieren und dabei wichtige Metriken für die einzelnen Ressourcen gruppieren und anzeigen. Verwenden Sie diese Metriken zum Beispiel, um Services, die die meisten Anforderungen empfangen, oder Services mit langsamen Abfragen und langen Antwortzeiten zu finden. Sie können diese Daten mit Kubernetes-Ereignissen, angepassten CI/CD-Ereignissen oder Code-Commits kombinieren.
|Automatische Anomalieerkennung und angepasste Alerts|Definieren Sie Regeln und Schwellenwerte für den Zeitpunkt, an dem Sie benachrichtigt werden möchten, um Anomalien in Ihren Cluster- oder Gruppenressourcen zu erkennen, und um sich von Sysdig benachrichtigen zu lassen, wenn eine Ressource anders agiert als die anderen. Sie können diese Alerts an nachgeordnete Tools senden, z. B. ServiceNow, PagerDuty, Slack, VictorOps oder E-Mail.|
|Standarddashboards oder angepasste Dashboards|Sie können zwischen einer Vielzahl vorhandener Dashboards wählen oder ein eigenes Dashboard erstellen, um Metriken Ihrer Microservices so zu visualisieren, wie Sie es benötigen. |
{: caption="Vorteile der Verwendung von Sysdig Monitor" caption-side="top"}

### Integration mit {{site.data.keyword.containerlong_notm}}
{: #sysdig-integration}

Sysdig Monitor wird von {{site.data.keyword.mon_full_notm}} bereitgestellt, einem {{site.data.keyword.Bluemix_notm}}-Plattformservice, den Sie mit Ihrem Cluster verwenden können. {{site.data.keyword.mon_full_notm}} wird von Sysdig in Partnerschaft mit IBM betrieben.
{: shortdesc}

Um Sysdig Monitor in Ihrem Cluster verwenden zu können, müssen Sie eine Instanz von {{site.data.keyword.mon_full_notm}} in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto bereitstellen und Ihre Kubernetes-Cluster als Metrikquelle konfigurieren. Nach der Konfiguration des Clusters werden Metriken automatisch erfasst und an Ihre {{site.data.keyword.mon_full_notm}}-Serviceinstanz weitergeleitet. Sie können das {{site.data.keyword.mon_full_notm}}-Dashboard verwenden, um auf Ihre Metriken zuzugreifen.   

Weitere Informationen finden Sie unter [Metriken für eine App analysieren, die in einem Kubernetes-Cluster bereitgestellt wurde](/docs/services/Monitoring-with-Sysdig?topic=Sysdig-kubernetes_cluster).

### Abrechnung und Unterstützung
{: #sysdig-billing-support}

Da Sysdig Monitor von {{site.data.keyword.mon_full_notm}} bereitgestellt wird, ist Ihre Nutzung in der {{site.data.keyword.Bluemix_notm}}-Rechnung für Plattformservices enthalten. Preisinformationen finden Sie in den verfügbaren Plänen im [{{site.data.keyword.Bluemix_notm}}-Katalog ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/observe/monitoring/create).

{{site.data.keyword.mon_full_notm}} ist voll in das {{site.data.keyword.Bluemix_notm}}-Unterstützungssystem integriert. Wenn ein Problem bei der Verwendung von {{site.data.keyword.mon_full_notm}} auftritt, posten Sie eine Frage im Kanal `sysdig-monitoring` in [{{site.data.keyword.containerlong_notm}} Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com/) oder öffnen Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support). Melden Sie bei Slack mit Ihrer IBMid an. Wenn Sie keine IBMid für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung in diesen Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://bxcs-slack-invite.mybluemix.net/) an.

## Portworx
{: #portworx-parter}

[Portworx ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://portworx.com/products/introduction/) ist eine Lösung für hoch verfügbaren, durch Software definierten Speicher, die Sie zur Verwaltung von lokalem persistenten Speicher für Ihre containerisierten Datenbanken und andere statusabhängigen Apps oder zur zonenübergreifenden gemeinsamen Nutzung von Daten zwischen Pods einsetzen können.
{: shortdesc}

**Was ist softwaredefinierter Speicher (SDS)?** </br>
Eine SDS-Lösung (SDS - Software-Defined Storage) fasst Speichereinheiten verschiedener Typen, Größen und Hersteller zusammen, die den Workerknoten in Ihrem Cluster zugeordnet sind. Workerknoten mit verfügbarem Speicher auf Festplatten werden einem Speichercluster als Knoten hinzugefügt. In diesem Cluster wird der physische Speicher virtualisiert und für den Benutzer als virtueller Speicherpool dargestellt. Der Speichercluster wird durch die SDS-Software verwaltet. Wenn Daten auf dem Speichercluster gespeichert werden müssen, entscheidet die SDS-Software, wo die Daten zwecks höchster Verfügbarkeit zu speichern sind. Ihr virtueller Speicher wird mit einer allgemeinen Gruppe von Funktionen und Services bereitgestellt, die Sie nutzen können, ohne sich um die eigentliche Speicherarchitektur, die ihnen zugrunde liegt, kümmern zu müssen.

### Vorteile
{: #portworx-benefits}

In der folgenden Tabelle finden Sie eine Liste der Hauptvorteile, die sich für Sie aus der Verwendung von Portworx ergeben.
{: shortdesc}

|Vorteil|Beschreibung|
|-------------|------------------------------|
|Cloudnatives Speicher- und Datenmanagement für statusabhängige Apps|Portworx fasst verfügbaren lokalen Speicher, der Ihren Workerknoten zugeordnet ist und bezüglich Größe oder Typ variieren kann, zusammen und schafft eine einheitliche persistente Speicherebene für containerisierte Datenbanken und andere statusabhängige Apps, die in dem Cluster ausgeführt werden sollen. Durch die Verwendung von Kubernetes-PVCs (Persistent Volume Claims) können Sie Ihren Apps lokalen persistenten Speicher zum Speichern von Daten hinzufügen. |
|Hoch verfügbare Daten mit Datenträgerreplikation|Portworx repliziert Daten in Ihren Datenträgern automatisch workerknoten- und zonenübergreifend in Ihrem Cluster, sodass Sie jederzeit auf Ihre Daten zugreifen können und Ihre statusabhängige App im Fall eines Workerknotenfehlers oder -warmstarts für die erneute Ausführung auf einem anderen Workerknoten geplant werden kann. |
|Unterstützung für die Ausführung von `hyper-converged`|Portworx kann für die Ausführung von [`hyper-converged` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.portworx.com/portworx-install-with-kubernetes/storage-operations/hyperconvergence/) konfiguriert werden, um sicherzustellen, dass Ihre Rechenressourcen und der Speicher immer auf demselben Workerknoten platziert werden. Wenn Ihre App zur erneuten Ausführung geplant werden muss, verlegt Portworx Ihre App auf einen Workerknoten, auf dem sich eines Ihrer Datenträgerreplikate befindet, um die Zugriffsgeschwindigkeit lokaler Festplattenzugriffe und hohe Leistung für Ihre statusabhängige App sicherzustellen. |
|Daten mit {{site.data.keyword.keymanagementservicelong_notm}} verschlüsseln|Sie können zum Schutz der Daten auf Ihren Datenträgern [{{site.data.keyword.keymanagementservicelong_notm}}-Verschlüsselungsschlüssel konfigurieren](/docs/containers?topic=containers-portworx#encrypt_volumes), die durch cloudbasierte, mit FIPS 140-2 Level 2 zertifizierte Hardwaresicherheitsmodule (HSMs) gesichert sind. Sie können zwischen nur einem Verschlüsselungsschlüssel zur Verschlüsselung aller Datenträger in einem Cluster oder je einem Verschlüsselungsschlüssel für jeden Datenträger wählen. Portworx verwendet diesen Schlüssel, um ruhende Daten und Daten bei der Übertragung zu verschlüsseln, wenn sie an einen anderen Workerknoten gesendet werden.|
|Integrierte Snapshots und Cloud-Backups|Sie können den aktuellen Stand eines Datenträgers und seiner Daten durch Erstellen eines [Portworx-Snapshots ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.portworx.com/portworx-install-with-kubernetes/storage-operations/create-snapshots/) speichern. Snapshots können in Ihrem lokalen Portworx-Cluster oder in der Cloud gespeichert werden.|
|Integrierte Überwachung mit Lighthouse|[Lighthouse ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.portworx.com/reference/lighthouse/) ist ein intuitives, grafisches Tool, das Ihnen hilft, Ihre Portworx-Cluster und Datenträgersnapshots zu verwalten und zu überwachen. Mit Lighthouse können Sie den Allgemeinzustand Ihres Portworx-Clusters anzeigen, einschließlich der Anzahl der verfügbaren Speicherknoten, der Datenträger und der verfügbaren Kapazität, sowie Ihre Daten in Prometheus, Grafana oder Kibana analysieren.|
{: caption="Vorteile der Verwendung von Portworx" caption-side="top"}

### Integration mit {{site.data.keyword.containerlong_notm}}
{: #portworx-integration}

{{site.data.keyword.containerlong_notm}} stellt Typen von Workerknoten bereit, die zur Verwendung für softwaredefinierten Speicher (SDS) optimiert sind und mit einem oder mehreren unaufbereiteten, unformatierten und nicht angehängten lokalen Platten zur Verfügung gestellt werden, die Sie zum Speichern Ihrer Daten verwenden können. Portworx bietet die beste Leistung, wenn Sie [SDS-Workerknotenmaschinen](/docs/containers?topic=containers-planning_worker_nodes#sds) mit einer Netzgeschwindigkeit von 10 Gb/s einsetzen. Sie können Portworx jedoch auf anderen Workerknotentypen als SDS-Typen installieren, allerdings werden möglicherweise nicht die Leistungsvorteile erzielt, die für Ihre App erforderlich sind.
{: shortdesc}

Portworx wird unter Verwendung eines [Helm-Diagramms](/docs/containers?topic=containers-portworx#install_portworx) installiert. Wenn Sie das Helm-Diagramm installieren, analysiert Portworx automatisch den lokalen persistenten Speicher, der in Ihrem Cluster verfügbar ist, und fügt den Speicher zur Portworx-Speicherebene hinzu. Um Ihren Apps Speicher aus Ihrer Portworx-Speicherebene hinzuzufügen, müssen Sie [Kubernetes-PVCs](/docs/containers?topic=containers-portworx#add_portworx_storage) verwenden.

Um Portworx in Ihrem Cluster zu installieren, müssen Sie über eine Portworx-Lizenz verfügen. Wenn Sie ein erstmaliger Benutzer sind, können Sie die `px-enterprise`-Edition als Testversion verwenden. Die Testversion bietet Ihnen die volle Portworx-Funktionalität, die Sie 30 Tage lang testen können. Nach Ablauf der Testversion müssen Sie [eine Portworx-Lizenz kaufen![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/containers?topic=containers-portworx#portworx_license), um Ihren Portworx-Cluster weiterhin verwenden zu können.

Weitere Informationen zum Installieren und Verwenden von Portworx mit {{site.data.keyword.containerlong_notm}} finden Sie unter [Daten in softwaredefiniertem Speicher (SDS) mit Portworx speichern](/docs/containers?topic=containers-portworx).

### Abrechnung und Unterstützung
{: #portworx-billing-support}

SDS-Workerknotenmaschinen, die mit lokalen Festplatten geliefert werden, und virtuelle Maschinen, die Sie für Portworx verwenden, sind in Ihrer monatlichen {{site.data.keyword.containerlong_notm}}-Rechnung enthalten. Preisinformationen finden Sie im [{{site.data.keyword.Bluemix_notm}}-Katalog ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/catalog/cluster). Die Kosten der Portworx-Lizenz fallen separat an und sind in Ihrer monatlichen Rechnung nicht enthalten.
{: shortdesc}

Wenn ein Problem bei der Verwendung von Portworx auftritt oder Sie zu Fragen der Portworx-Konfiguration für Ihren speziellen Anwendungsfall chatten möchten, posten Sie eine Frage über den Kanal `portworx-on-iks` in [{{site.data.keyword.containerlong_notm}} Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com/). Melden Sie bei Slack mit Ihrer IBMid an. Wenn Sie keine IBMid für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung in diesen Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://bxcs-slack-invite.mybluemix.net/) an.
