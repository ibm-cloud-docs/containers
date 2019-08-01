---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-11"

keywords: kubernetes, iks, logmet, logs, metrics

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


# Protokollierung und Überwachung
{: #health}

Richten Sie die Protokollierung und Überwachung in {{site.data.keyword.containerlong}} ein, um Unterstützung bei der Fehlerbehebung zu erhalten und um die Leistung Ihrer Kubernetes-Cluster und Apps zu verbessern.
{: shortdesc}

Die kontinuierliche Überwachung und Protokollierung ist der Schlüssel, um Angriffe auf Ihren Cluster zu erkennen und Probleme zu lösen, sobald diese auftreten. Wenn Sie Ihren Cluster kontinuierlich überwachen, können Sie die Clusterkapazität und Verfügbarkeit von Ressourcen für Ihre App besser verstehen. Mit diesen Erkenntnissen können Sie sich darauf vorbereiten, Ihre Apps gegen Ausfallzeiten zu schützen. **Hinweis:** Zur Konfiguration der Protokollierung und Überwachung müssen Sie einen Standardcluster in {{site.data.keyword.containerlong_notm}} verwenden.

## Protokollierungslösung auswählen
{: #logging_overview}

Protokolle werden standardmäßig für alle der folgenden {{site.data.keyword.containerlong_notm}}-Clusterkomponenten generiert und lokal aufgezeichnet: Workerknoten, Container, Anwendungen, persistenter Speicher, Ingress-Lastausgleichsfunktion für Anwendungen (ALB), Kubernetes-API und Namensbereich `kube-system`. Zum Erfassen, Weiterleiten und Anzeigen dieser Protokolle sind verschiedene Protokollierungslösungen verfügbar.
{: shortdesc}

Sie können Ihre Protokollierungslösung nach den Clusterkomponenten auswählen, für die Sie Protokolle erfassen müssen. Eine häufige Implementierung besteht darin, einen bevorzugten Protokollierungsservice auf der Basis seiner Analyse- und Schnittstellenfunktionen auszuwählen, wie zum Beispiel die folgenden: {{site.data.keyword.loganalysisfull}}, {{site.data.keyword.la_full}} oder einen Service eines anderen Anbieters. Sie können dann {{site.data.keyword.cloudaccesstrailfull}} verwenden, um die Benutzeraktivität im Cluster zu verfolgen und Cluster-Master-Protokolle in {{site.data.keyword.cos_full}} zu sichern. **Hinweis:** Um die Protokollierung konfigurieren zu können, müssen Sie einen Kubernetes-Standardcluster haben.

<dl>

<dt>{{site.data.keyword.la_full_notm}}</dt>
<dd>Verwalten Sie Protokolle für Pod-Container, indem Sie LogDNA als Service eines anderen Anbieters in Ihrem Cluster bereitstellen. Zur Verwendung von {{site.data.keyword.la_full_notm}} müssen Sie einen Protokollierungsagenten auf jedem Workerknoten in Ihrem Cluster bereitstellen. Dieser Agent erfasst Protokolle Ihrer Pods aus allen Namensbereichen, einschließlich `kube-system`, mit der Erweiterung `*.log` und in erweiterungslosen Dateien, die im Verzeichnis `/var/log` gespeichert werden. Anschließend leitet der Agent die Protokolle an den {{site.data.keyword.la_full_notm}}-Service weiter. Weitere Informationen zu dem Service finden Sie in der Dokumentation zu [{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about). Lesen Sie für den Einstieg die Informationen im Abschnitt [Kubernetes-Clusterprotokolle mit {{site.data.keyword.loganalysisfull_notm}} with LogDNA verwalten](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).
</dd>

<dt>Fluentd mit {{site.data.keyword.loganalysisfull_notm}}</dt>
<dd><p class="deprecated">Bisher konnten Sie eine Protokollierungskonfiguration für die Weiterleitung der von der Fluentd-Clusterkomponente erfassten Protokolle an {{site.data.keyword.loganalysisfull_notm}} erstellen. Ab dem 30. April 2019 können Sie keine neuen {{site.data.keyword.loganalysisshort_notm}}-Instanzen bereitstellen und alle Instanzen des Lite-Plans werden gelöscht. Bestehende Instanzen des Premium-Plans werden bis zum 30. September 2019 unterstützt. Wenn Sie weiterhin Protokolle für Ihren Cluster erfassen möchten, müssen Sie {{site.data.keyword.la_full_notm}} so konfigurieren, dass Protokolle an einen externen Server weitergeleitet werden, oder Ihre Konfiguration entsprechend ändern.</p>
</dd>

<dt>Fluentd mit einem externen Server</dt>
<dd>Zum Erfassen, Weiterleiten und Anzeigen von Protokollen für eine Clusterkomponente können Sie eine Protokollierungskonfiguration unter Verwendung von Fluentd erstellen. Wenn Sie eine Protokollierungskonfiguration erstellen, erfasst die Cluster-Komponente von [Fluentd ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.fluentd.org/) Protokolle aus den Pfaden für eine angegebene Quelle. Fluentd kann diese Protokolle dann an einen externen Server weiterleiten, der ein Syslog-Protokoll akzeptiert. Lesen Sie für den Einstieg die [Informationen zur Weiterleitung von Protokollen für Cluster und Apps an Syslog](#logging).
</dd>

<dt>{{site.data.keyword.cloudaccesstrailfull_notm}}</dt>
<dd>Zur Überwachung von durch Benutzer eingeleiteten Verwaltungsaktivitäten in Ihrem Cluster können Sie Auditprotokolle erfassen und an {{site.data.keyword.cloudaccesstrailfull_notm}} weiterleiten. Cluster generieren zwei Typen von {{site.data.keyword.cloudaccesstrailshort}}-Ereignissen.
<ul><li>Ereignisse der Clusterverwaltung werden automatisch generiert und an {{site.data.keyword.cloudaccesstrailshort}} weitergeleitet.</li>
<li>Ereignisse des Kubernetes-API-Serveraudits werden automatisch generiert, jedoch müssen Sie eine [Protokollierungskonfiguration erstellen](#api_forward), damit Fluentd diese Protokolle an {{site.data.keyword.cloudaccesstrailshort}} weiterleiten kann.</li></ul>
Weitere Informationen zu den Typen von {{site.data.keyword.containerlong_notm}}-Ereignissen, die Sie überwachen können, finden Sie unter [Activity Tracker-Ereignisse](/docs/containers?topic=containers-at_events). Weitere Informationen zum Service finden Sie in der Dokumentation zu [Activity Tracker](/docs/services/cloud-activity-tracker?topic=cloud-activity-tracker-getting-started).
<p class="note">{{site.data.keyword.containerlong_notm}} ist zurzeit nicht für die Verwendung von {{site.data.keyword.at_full}} konfiguriert. Zur Verwaltung von Ereignissen der Clusterverwaltung und Kubernetes-API-Auditprotokollen verwenden Sie weiterhin {{site.data.keyword.cloudaccesstrailfull_notm}} mit LogAnalysis.</p>
</dd>

<dt>{{site.data.keyword.cos_full_notm}}</dt>
<dd>Zum Erfassen, Weiterleiten und Anzeigen von Protokollen für den Kubernetes-Master Ihres Clusters können Sie zu einem beliebigen Zeitpunkt einen Snapshot Ihrer Master-Protokolle erstellen, die in einem {{site.data.keyword.cos_full_notm}}-Bucket erfasst werden sollen. Der Snapshot enthält alle Daten, die über den API-Server gesendet werden, zum Beispiel Pod-Planungen, Bereitstellungen oder RBAC-Richtlinien. Lesen Sie für den Einstieg die Informationen unter [Masterprotokolle erfassen](#collect_master).</dd>

<dt>Services anderer Anbieter</dt>
<dd>Wenn Sie besondere Anforderungen haben, können Sie eine eigene Protokollierungslösung einrichten. Lesen Sie die Informationen zu den Protokollierungsservices anderer Anbieter, die Sie Ihrem Cluster hinzufügen können, unter [Protokollierungs- und Überwachungsintegrationen](/docs/containers?topic=containers-supported_integrations#health_services). Sie können Containerprotokolle aus dem Pfad `/var/log/pods/` erfassen. </dd>

</dl>

<br />


## Cluster- und App-Protokolle an {{site.data.keyword.la_full_notm}} weiterleiten
{: #logdna}

Verwalten Sie Protokolle für Pod-Container, indem Sie LogDNA als Service eines anderen Anbieters in Ihrem Cluster bereitstellen.
{: shortdesc}

Zur Verwendung von {{site.data.keyword.la_full_notm}} müssen Sie einen Protokollierungsagenten auf jedem Workerknoten in Ihrem Cluster bereitstellen. Dieser Agent erfasst Protokolle Ihrer Pods aus allen Namensbereichen, einschließlich `kube-system`, mit der Erweiterung `*.log` und in erweiterungslosen Dateien, die im Verzeichnis `/var/log` gespeichert werden. Anschließend leitet der Agent die Protokolle an den {{site.data.keyword.la_full_notm}}-Service weiter. Weitere Informationen zu dem Service finden Sie in der Dokumentation zu [{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about). Lesen Sie für den Einstieg die Informationen im Abschnitt [Kubernetes-Clusterprotokolle mit {{site.data.keyword.loganalysisfull_notm}} with LogDNA verwalten](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).

<br />


## Veraltet: Cluster-, App- und Kubernetes-API-Auditprotokolle an {{site.data.keyword.loganalysisfull_notm}} weiterleiten
{: #loga}

Bisher konnten Sie eine Protokollierungskonfiguration für die Weiterleitung der von der Fluentd-Clusterkomponente erfassten Protokolle an {{site.data.keyword.loganalysisfull_notm}} erstellen. Seit dem 30. April 2019 ist {{site.data.keyword.loganalysisfull_notm}} veraltet. Sie können keine neuen {{site.data.keyword.loganalysisshort_notm}}-Instanzen bereitstellen und alle Lite-Planinstanzen werden gelöscht. Bestehende Instanzen des Premium-Plans werden bis zum 30. September 2019 unterstützt.
{: deprecated}

Für die weitere Erfassung von Protokollen für Ihren Cluster stehen Ihnen die folgenden Optionen zur Verfügung: 
* Richten Sie {{site.data.keyword.la_full_notm}} ein. Weitere Informationen finden Sie unter [Zu {{site.data.keyword.la_full_notm}} wechseln](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-transition).
* [Ändern Sie Ihre Konfiguration so, dass Protokolle an einen externen Server weitergeleitet werden](#configuring).

Weitere Informationen zu vorhandenen {{site.data.keyword.loganalysisshort_notm}}-Instanzen finden Sie in der [Dokumentation zu {{site.data.keyword.loganalysisshort_notm}}](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-containers_kube_other_logs).

<br />


## Cluster-, App- und Kubernetes-API-Auditprotokolle an einen externen Server weiterleiten
{: #configuring}

Konfigurieren Sie für {{site.data.keyword.containerlong_notm}}-Standardcluster die Protokollweiterleitung an einen externen Server.
{: shortdesc}

### Erklärung der Protokollweiterleitung an einen externen Server
{: #logging}

Protokolle werden standardmäßig durch das [Fluentd-Add-on ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.fluentd.org/) in Ihrem Cluster erfasst. Wenn Sie eine Protokollierungskonfiguration für eine Quelle in Ihrem Cluster, wie zum Beispiel für einen Container, erstellen, werden die Protokolle, die Fluentd aus den Pfaden dieser Quelle erfasst, an einen externen Server weitergeleitet. Der Datenverkehr von der Quelle an den Protokollierungsservice am Einpflegeportt wird verschlüsselt.
{: shortdesc}

**Für welche Quellen kann ich die Protokollweiterleitung konfigurieren?**

In der folgenden Abbildung sehen Sie die Position der Quellen, für die Sie die Protokollierung konfigurieren können.

<img src="images/log_sources.png" width="600" alt="Protokollquellen im Cluster" style="width:600px; border-style: none"/>

1. `Workerknoten`: Informationen, die für die Infrastrukturkonfiguration spezifisch sind, die Sie für Ihren Workerknoten konfiguriert haben. Workerprotokolle werden in Syslog erfasst und enthalten Betriebssystemereignisse. In `auth.log` finden Sie Informationen zu den Authentifizierungsanforderungen, die an das Betriebssystem gestellt werden.</br>**Pfade**:
    * `/var/log/syslog`
    * `/var/log/auth.log`

2. `Container:` Informationen, die von einem aktiven Container protokolliert werden.</br>**Pfade:** Informationen, die in `STDOUT` oder `STDERR` geschrieben werden.

3. `Anwendung`: Informationen zu Ereignissen, die auf Anwendungsebene auftreten. Dabei kann es sich um eine Benachrichtigung handeln, dass ein Ereignis stattgefunden hat, beispielsweise eine erfolgreiche Anmeldung, eine Warnung zum Speicher oder andere Operationen, die auf App-Ebene durchgeführt werden können.</br>**Pfade:** Sie können festlegen, an welche Pfade Ihre Protokolle gesendet werden. Damit Protokolle jedoch gesendet werden, müssen Sie einen absoluten Pfad in Ihrer Protokollierungskonfiguration verwenden. Andernfalls können die Protokolle nicht gelesen werden. Falls Ihr Pfad an Ihren Workerknoten angehängt ist, wurde dadurch möglicherweise die symbolische Verbindung erstellt. Beispiel: Wenn der angegebene Pfad `/usr/local/spark/work/app-0546/0/stderr` lautet, die Protokolle jedoch tatsächlich in `/usr/local/spark-1.0-hadoop-1.2/work/app-0546/0/stderr` gespeichert werden, können die Protokolle nicht gelesen werden.

4. `Speicher`: Informationen zum persistenten Speicher, der in Ihrem Cluster konfiguriert ist. Mit Hilfe von Speicherprotokollen können Sie Problembestimmungsdashboards und Alerts als Teil Ihrer DevOps-Pipeline und der Produktionsreleases konfigurieren. **Hinweis:** Die Pfade `/var/log/kubelet.log` und `/var/log/syslog` enthalten auch Speicherprotokolle; die Protokolle aus diesen Pfaden werden jedoch von den Protokollquellen `kubernetes` und `worker` erfasst.</br>**Pfade:**
    * `/var/log/ibmc-s3fs.log`
    * `/var/log/ibmc-block.log`

  **Pods**:
    * `portworx-***`
    * `ibmcloud-block-storage-attacher-***`
    * `ibmcloud-block-storage-driver-***`
    * `ibmcloud-block-storage-plugin-***`
    * `ibmcloud-object-storage-plugin-***`

5. `Kubernetes`: von 'kubelet', 'kube-proxy' und anderen Kubernetes-Ereignissen, die im Namensbereich 'kube-system' des Workerknotens auftreten können.</br>**Pfade:**
    * `/var/log/kubelet.log`
    * `/var/log/kube-proxy.log`
    * `/var/log/event-exporter/1..log`

6. `Kube-audit`: Informationen zu clusterbezogenen Aktionen, die an den Kubernetes-API-Server gesendet werden, einschließlich der Zeit, des Benutzers und der betroffenen Ressource.

7. `Ingress`: Informationen zum Netzverkehr, der über die Ingress-ALB in einen Cluster gelangt.</br>**Pfade:**
    * `/var/log/alb/ids/*.log`
    * `/var/log/alb/ids/*.err`
    * `/var/log/alb/customerlogs/*.log`
    * `/var/log/alb/customerlogs/*.err`

</br>

**Welche Konfigurationsoptionen stehen mir zur Verfügung?**

In der folgenden Tabelle sind die verschiedenen Optionen aufgeführt, die Ihnen bei der Konfiguration der Protokollierung und ihrer Beschreibungen zur Verfügung stehen.

<table>
<caption> Informationen zu den Konfigurationsoptionen für die Protokollierung</caption>
  <thead>
    <th>Option</th>
    <th>Beschreibung</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;clustername_oder_-id&gt;</em></code></td>
      <td>Der Name oder die ID des Clusters.</td>
    </tr>
    <tr>
      <td><code><em>--log_source</em></code></td>
      <td>Die Quelle, von der die Protokolle weitergeleitet werden sollen. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code>, <code>storage</code> und <code>kube-audit</code>. Dieses Argument unterstützt eine durch Kommas getrennte Liste mit Protokollquellen, die auf die Konfiguration angewendet werden sollen. Wenn Sie keine Protokollquelle bereitstellen, werden Protokollierungskonfigurationen für die Protokollquellen <code>container</code> und <code>ingress</code> erstellt.</td>
    </tr>
    <tr>
      <td><code><em>--type syslog</em></code></td>
      <td>Bei Angabe des Werts <code>syslog</code> werden Ihre Protokolle an einen externen Server weitergeleitet. </p>
      </dd></td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>Optional: Der Kubernetes-Namensbereich, von dem aus Sie Protokolle weiterleiten möchten. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Protokollquelle <code>container</code> gültig. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Cluster diese Konfiguration.</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>Verwenden Sie für {{site.data.keyword.loganalysisshort_notm}} die [Einpflege-URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</p>
      <p>Geben Sie für das Systemprotokoll (Syslog) den Hostnamen oder die IP-Adresse des Protokollcollector-Service an.</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>Der Einpflegeport. Wenn Sie keinen Port angeben, wird der Standardport <code>9091</code> verwendet.
      <p>Geben Sie für das Systemprotokoll den Port des Protokollcollector-Servers an. Wenn Sie keinen Port angeben, dann wird der Standardport <code>514</code> verwendet.</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>Optional: Zum Weiterleiten von Protokollen von Apps können Sie den Namen des Containers angeben, der Ihre App enthält. Sie können mehr als einen Container angeben, indem Sie eine durch Kommas getrennte Liste verwenden. Falls keine Container angegeben sind, werden Protokolle von allen Containern weitergeleitet, die die von Ihnen bereitgestellten Pfade enthalten.</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>Der Pfad zu einem Container, an den die Anwendungen Protokolle senden. Wenn Sie Protokolle mit dem Quellentyp <code>application</code> weiterleiten möchten, müssen Sie einen Pfad angeben. Wenn Sie mehr als einen Pfad angeben, verwenden Sie eine durch Kommas getrennte Liste. Beispiel: <code>/var/log/myApp1/*,/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>--syslog-protocol</em></code></td>
      <td>Wenn der Protokollierungstyp <code>syslog</code> lautet, das Transport Layer Protocol. Sie können die folgenden Protokolle verwenden: `udp`, `tls` oder `tcp`. Bei einer Weiterleitung an einen rsyslog-Server mit dem <code>udp</code>-Protokoll werden Protokolle, die größer sind als 1 KB, abgeschnitten.</td>
    </tr>
    <tr>
      <td><code><em>--ca-cert</em></code></td>
      <td>Erforderlich: Wenn der Protokollierungstyp <code>syslog</code> und das Protokoll <code>tls</code> ist, ist dies der Name des geheimen Kubernetes-Schlüssels, der das Zertifikat einer Zertifizierungsstelle enthält.</td>
    </tr>
    <tr>
      <td><code><em>--verify-mode</em></code></td>
      <td>Wenn der Protokollierungstyp <code>syslog</code> und das Protokoll <code>tls</code> ist, ist dies der Prüfmodus. Unterstützte Werte sind <code>verify-peer</code> und der Standardwert <code>verify-none</code>.</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>Optional: Überspringen Sie die Validierung der Organisations- und Bereichsnamen, wenn sie angegeben sind. Das Überspringen der Validierung verringert die Bearbeitungszeit. Eine ungültige Protokollierungskonfiguration aber führt dazu, dass Protokolle nicht ordnungsgemäß weitergeleitet werden.</td>
    </tr>
  </tbody>
</table>

**Bin ich dafür verantwortlich, dass Fluentd aktualisiert wird?**

Damit Sie Ihre Protokollierungs- oder Filterkonfigurationen ändern können, muss das Fluentd-Protokollierungs-Add-on die aktuelle Version aufweisen. Standardmäßig sind automatische Aktualisierungen für das Add-on aktiviert. Informationen zum Inaktivieren automatischer Aktualisierungen finden Sie im Abschnitt [Cluster-Add-ons aktualisieren: Fluentd für die Protokollierung](/docs/containers?topic=containers-update#logging-up).

**Kann ich einige Protokolle aus einer Quelle in meinem Cluster weiterleiten und andere nicht?**

Ja. Wenn Sie zum Beispiel einen besonders datenintensiven Pod haben, kann es wünschenswert sein, zu verhindern, dass Protokolle aus diesem Pod Protokollspeicherplatz belegen, und gleichzeitig die Weiterleitung von Protokollen anderer Pods weiterhin zuzulassen. Informationen dazu, wie die Weiterleitung eines bestimmten Pods verhindert wird, finden Sie unter [Protokolle filtern](#filter-logs).

<br />


### Weiterleitung von Cluster- und App-Protokollen
{: #enable-forwarding}

Erstellen Sie eine Konfiguration für die Cluster- und App-Protokollierung. Sie können zwischen den verschiedenen Protokollierungsoptionen unterscheiden, indem Sie Flags setzen.
{: shortdesc}

**Protokolle an Ihren eigenen Server über die Protokolle `udp` oder `tcp` weiterleiten**

1. Stellen Sie sicher, dass Sie die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Editor** oder **Administrator**](/docs/containers?topic=containers-users#platform) innehaben.

2. Für den Cluster, in dem sich die Protokollquelle befindet: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. Sie haben zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.

  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in Ihrem Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts.

  Sie können Ihre Protokolle als gültige JSON-Datei anzeigen, indem Sie syslog-Präfixe entfernen. Fügen Sie zu diesem Zweck den folgenden Code am Anfang der Datei <code>etc/rsyslog.conf</code> hinzu, in der Ihr rsyslog-Server ausgeführt wird: <code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

4. Erstellen Sie eine Konfiguration für die Protokollweiterleitung.
    ```
    ibmcloud ks logging-config-create --cluster <clustername_oder_-id> --logsource <protokollquelle> --namespace <kubernetes-namensbereich> --hostname <hostname_oder_ip_des_protokollservers> --port <protokollserver-port> --type syslog --app-containers <container> --app-paths <pfade_zu_protokollen> --syslog-protocol <protokoll> --skip-validation
    ```
    {: pre}

</br></br>

**Protokolle auf Ihrem eigenen Server über das Protokoll `tls` weiterleiten**

Die folgenden Schritte sind allgemeine Anweisungen. Stellen Sie vor der Verwendung des Containers in einer Produktionsumgebung sicher, dass alle von Ihnen benötigten Sicherheitsanforderungen erfüllt sind.
{: tip}

1. Stellen Sie sicher, dass Sie die folgenden [{{site.data.keyword.Bluemix_notm}}-IAM-Rollen](/docs/containers?topic=containers-users#platform) innehaben:
    * Plattformrolle **Editor** oder **Administrator** für den Cluster
    * Servicerolle **Schreibberechtigter** oder **Manager** für den Namensbereich `kube-system`

2. Für den Cluster, in dem sich die Protokollquelle befindet: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. Sie haben zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.

  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in Ihrem Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts. Sie müssen die entsprechenden Zertifikate einer Zertifizierungsstelle und serverseitigen Zertifikate einfügen und die Datei `syslog.conf` aktualisieren, damit `tls` auf Ihrem Server aktiviert werden kann.

4. Speichern Sie das Zertifikat der Zertifizierungsstelle in einer Datei namens `ca-cert`. Es muss genau dieser Name sein.

5. Erstellen Sie im Namensbereich `kube-system` einen geheimen Schlüssel für die Datei `ca-cert`. Wenn Sie Ihre Protokollierungskonfiguration erstellen, verwenden Sie den Namen des geheimen Schlüssels für das Flag `--ca-cert`.
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

6. Erstellen Sie eine Konfiguration für die Protokollweiterleitung.
    ```
    ibmcloud ks logging-config-create --cluster <clustername_oder_id> --logsource <protokollquelle> --type syslog --syslog-protocol tls --hostname <ip-adresse_des_syslog-servers> --port <port_für_syslog-server, 514 ist Standard> --ca-cert <name_des_geheimen_schlüssels> --verify-mode <standardmäßig verify-none>
    ```
    {: pre}

### Auditprotokolle der Kubernetes-API weiterleiten
{: #audit_enable}

Um Ereignisse zu prüfen, die über Ihren Kubernetes-API-Server übergeben werden, können Sie eine Konfiguration für die Weiterleitung von Ereignissen an Ihren externen Server erstellen.
{: shortdesc}

Weitere Informationen zu Kubernetes-Auditprotokollen finden Sie im Thema zu <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">Audits <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> in der Kubernetes-Dokumentation.

* Aktuell wird eine Standardauditrichtlinie für alle Cluster mit dieser Protokollierungskonfiguration verwendet.
* Momentan werden Filter nicht unterstützt.
* Es kann nur eine Konfiguration des Typs `kube-audit` pro Cluster vorhanden sein; Sie können jedoch Protokolle an {{site.data.keyword.cloudaccesstrailshort}} und an einen externen Server weiterleiten, indem Sie eine Protokollierungskonfiguration und einen Webhook erstellen.
* Sie müssen die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für den Cluster innehaben.

**Vorbereitende Schritte**

1. Richten Sie einen fernen Protokollierungsserver ein, an den Sie die Protokolle weiterleiten können. Beispiel: Sie können [Logstash mit Kubernetes verwenden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend), um Auditereignisse zu erfassen.

2. Für den Cluster, in dem Sie Protokolle der API-Serveraudits erfassen möchten: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Um Kubernetes-API-Auditprotokolle weiterzuleiten, gehen Sie wie folgt vor:

1. Richten Sie den Webhook ein. Wenn Sie keine Informationen in den Flags bereitstellen, wird eine Standardkonfiguration verwendet.

    ```
    ibmcloud ks apiserver-config-set audit-webhook <clustername_oder_-id> --remoteServer <server-URL_oder_IP> --caCert <pfad_des_zertifizierungsstellenzertifikats> --clientCert <pfad_des_clientzertifikats> --clientKey <pfad_des_clientschlüssels>
    ```
    {: pre}

  <table>
  <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;clustername_oder_-id&gt;</em></code></td>
        <td>Der Name oder die ID des Clusters.</td>
      </tr>
      <tr>
        <td><code><em>&lt;server-URL&gt;</em></code></td>
        <td>Die URL oder IP-Adresse für den fernen Protokollierungsservice, an den Sie die Protokolle senden möchten. Zertifikate werden ignoriert, wenn Sie eine nicht sichere Server-URL angeben.</td>
      </tr>
      <tr>
        <td><code><em>&lt;pfad_des_zertifizierungsstellenzertifikats&gt;</em></code></td>
        <td>Der Dateipfad für das CA-Zertifikat, das zum Überprüfen des fernen Protokollierungsservice verwendet wird.</td>
      </tr>
      <tr>
        <td><code><em>&lt;pfad_des_clientzertifikats&gt;</em></code></td>
        <td>Der Dateipfad des Clientzertifikats, das zum Authentifizieren beim fernen Protokollierungsservice verwendet wird.</td>
      </tr>
      <tr>
        <td><code><em>&lt;pfad_des_clientschlüssels&gt;</em></code></td>
        <td>Der Dateipfad für den entsprechenden Clientschlüssel, der zum Verbinden mit dem fernen Protokollierungsservice verwendet wird.</td>
      </tr>
    </tbody>
  </table>

2. Überprüfen Sie, dass die Protokollweiterleitung aktiviert war, indem Sie die URL für den fernen Protokollierungsservice anzeigen.

    ```
    ibmcloud ks apiserver-config-get audit-webhook <clustername_oder_-id>
    ```
    {: pre}

    Beispielausgabe:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Wenden Sie die Konfigurationsaktualisierung an, indem Sie den Kubernetes-Master erneut starten.

    ```
    ibmcloud ks apiserver-refresh --cluster <clustername_oder_-id>
    ```
    {: pre}

4. Wenn Sie Auditprotokolle nicht mehr weiterleiten möchten, können Sie die Konfiguration inaktivieren.
    1. Für den Cluster, in dem Sie die Erfassung der Protokolle der API-Serveraudits stoppen möchten: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2. Inaktivieren Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters.

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <clustername_oder_-id>
        ```
        {: pre}

    3. Wenden Sie die Konfigurationsaktualisierung an, indem Sie den Kubernetes-Master erneut starten.

        ```
        ibmcloud ks apiserver-refresh --cluster <clustername_oder_-id>
        ```
        {: pre}

### Weitergeleitete Protokolle filtern
{: #filter-logs}

Sie können auswählen, welche Protokolle an den externen Server weitergeleitet werden, indem Sie bestimmte Protokolle für einen bestimmten Zeitraum herausfiltern. Sie können zwischen den verschiedenen Filteroptionen unterscheiden, indem Sie Flags setzen.
{: shortdesc}

<table>
<caption>Informationen zu den Optionen für die Protokollfilterung</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Optionen für die Protokollfilterung</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;clustername_oder_-id&gt;</td>
      <td>Erforderlich: Der Name oder die ID des Clusters, für den die Protokolle gefiltert werden sollen.</td>
    </tr>
    <tr>
      <td><code>&lt;protokolltyp&gt;</code></td>
      <td>Der Typ von Protokollen, auf die Sie den Filter anwenden möchten. Momentan werden <code>all</code>, <code>container</code> und <code>host</code> unterstützt.</td>
    </tr>
    <tr>
      <td><code>&lt;konfigurationen&gt;</code></td>
      <td>Optional: Eine durch Kommas getrennte Liste Ihrer Protokollierungskonfigurations-IDs. Wird sie nicht bereitgestellt, wird der Filter auf alle Clusterprotokollierungskonfigurationen angewendet, die an den Filter übergeben werden. Sie können die Protokollkonfigurationen anzeigen, die mit dem Filter übereinstimmen, indem Sie die Option <code>--show-matching-configs</code> verwenden.</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes-namensbereich&gt;</code></td>
      <td>Optional: Der Kubernetes-Namensbereich, von dem aus Sie Protokolle weiterleiten möchten. Dieses Flag ist nur mit dem Protokolltyp <code>container</code> anwendbar.</td>
    </tr>
    <tr>
      <td><code>&lt;containername&gt;</code></td>
      <td>Optional: Der Name des Containers, in dem Sie Protokolle filtern möchten.</td>
    </tr>
    <tr>
      <td><code>&lt;protokollierungsstufe&gt;</code></td>
      <td>Optional: Filtert Protokolle auf einer angegebenen Stufe oder den darunterliegenden Stufen heraus. Zulässige Werte in ihrer kanonischen Reihenfolge sind <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> und <code>trace</code>. Beispiel: Wenn Sie Protokolle auf der Stufe <code>info</code> filtern, wird auch auf den Stufen <code>debug</code> und <code>trace</code> gefiltert. **Hinweis**: Sie können dieses Flag nur dann verwenden, wenn Protokollnachrichten das JSON-Format aufweisen und ein Feld für die Stufe enthalten. Wenn Sie Ihre Nachrichten in JSON anzeigen möchten, hängen Sie das Flag <code>--json</code> an den Befehl an.</td>
    </tr>
    <tr>
      <td><code>&lt;nachricht&gt;</code></td>
      <td>Optional: Filtert Protokolle heraus, die eine angegebene Nachricht enthalten, die als regulärer Ausdruck geschrieben wird.</td>
    </tr>
    <tr>
      <td><code>&lt;filter-id&gt;</code></td>
      <td>Optional: Die ID des Protokollfilters.</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>Optional: Zeigen Sie die Protokollierungskonfigurationen an, für die die einzelnen Filter gelten.</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>Optional: Löschen Sie alle Protokollweiterleitungsfilter.</td>
    </tr>
  </tbody>
</table>

1. Erstellen Sie einen Protokollierungsfilter.
  ```
  ibmcloud ks logging-filter-create --cluster <clustername_oder_-id> --type <protokolltyp> --logging-configs <konfigurationen> --namespace <kubernetes-namensbereich> --container <containername> --level <protokollierungsstufe> --regex-message <nachricht>
  ```
  {: pre}

2. Zeigen Sie die erstellten Protokollfilter an.

  ```
  ibmcloud ks logging-filter-get --cluster <clustername_oder_-id> --id <filter-id> --show-matching-configs
  ```
  {: pre}

3. Aktualisieren Sie den erstellten Protokollfilter.
  ```
  ibmcloud ks logging-filter-update --cluster <clustername_oder_-id> --id <filter-id> --type <servertyp> --logging-configs <konfigurationen> --namespace <kubernetes-namensbereich --container <containername> --level <protokollierungsstufe> --regex-message <nachricht>
  ```
  {: pre}

4. Löschen Sie einen erstellten Protokollfilter.

  ```
  ibmcloud ks logging-filter-rm --cluster <clustername_oder_-id> --id <filter-id> [--all]
  ```
  {: pre}

### Protokollweiterleitung überprüfen, aktualisieren und löschen
{: #verifying-log-forwarding}

**ÜberprüfenVerifying**</br>
Sie können überprüfen, ob Ihre Konfiguration ordnungsgemäß eingerichtet ist. Dazu haben Sie zwei Möglichkeiten:

* Gehen Sie wie folgt vor, um eine Liste aller Protokollierungskonfigurationen in einem Cluster anzuzeigen:
  ```
  ibmcloud ks logging-config-get --cluster <clustername_oder_-id>
  ```
  {: pre}

* Gehen Sie wie folgt vor, um die Protokollierungskonfiguration für einen Protokollquellentyp aufzulisten:
  ```
  ibmcloud ks logging-config-get --cluster <clustername_oder_-id> --logsource <quelle>
  ```
  {: pre}

**Aktualisieren**</br>
Sie können eine Protokollierungskonfiguration aktualisieren, die Sie bereits erstellt haben:
```
ibmcloud ks logging-config-update --cluster <clustername_oder_-id> --id <protokollkonfigurations-id> --namespace <namensbereich> --type <servertyp> --syslog-protocol <protokoll> --logsource <quelle> --hostname <hostname_oder_einpflege-url> --port <port> --space <clusterbereiche> --org <clusterorg> --app-containers <container> --app-paths <pfade_zu_protokollen>
```
{: pre}

**Löschen**</br>
Sie können die Weiterleitung von einem oder allen Protokollen der Protokollierungskonfiguration eines Clusters stoppen:

* Gehen Sie wie folgt vor, um eine Protokollierungskonfiguration zu löschen:
  ```
  ibmcloud ks logging-config-rm --cluster <clustername_oder_-id> --id <protokollkonfigurations-id>
  ```
  {: pre}

* Gehen Sie wie folgt vor, um alle Protokollierungskonfigurationen zu löschen:
  ```
  ibmcloud ks logging-config-rm --cluster <mein_cluster> --all
  ```
  {: pre}

<br />


## Auditprotokolle der Kubernetes API an {{site.data.keyword.cloudaccesstrailfull_notm}} weiterleiten
{: #api_forward}

Kubernetes führt automatisch einen Audit für alle Ereignisse durch, die über Ihren API-Server übergeben werden. Sie können die Ereignisse an {{site.data.keyword.cloudaccesstrailfull_notm}} weiterleiten.
{: shortdesc}

Weitere Informationen zu Kubernetes-Auditprotokollen finden Sie im Thema zu <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">Audits <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> in der Kubernetes-Dokumentation.

* Aktuell wird eine Standardauditrichtlinie für alle Cluster mit dieser Protokollierungskonfiguration verwendet.
* Momentan werden Filter nicht unterstützt.
* Es kann nur eine Konfiguration des Typs `kube-audit` pro Cluster vorhanden sein; Sie können jedoch Protokolle an {{site.data.keyword.cloudaccesstrailshort}} und an einen externen Server weiterleiten, indem Sie eine Protokollierungskonfiguration und einen Webhook erstellen.
* Sie müssen die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für den Cluster innehaben.

{{site.data.keyword.containerlong_notm}} ist zurzeit nicht für die Verwendung von {{site.data.keyword.at_full}} konfiguriert. Zur Verwaltung von Kubernetes-API-Auditprotokollen verwenden Sie weiterhin {{site.data.keyword.cloudaccesstrailfull_notm}} mit LogAnalysis.
{: note}

**Vorbereitende Schritte**

1. Überprüfen Sie die Berechtigungen. Wenn Sie beim Erstellen des Clusters einen Bereich angegeben haben, benötigen sowohl der Kontoeigner als auch der {{site.data.keyword.containerlong_notm}}-Schlüsseleigner Manager-, Entwickler- oder Auditor-Berechtigungen in diesem Bereich.

2. Für den Cluster, in dem Sie Protokolle der API-Serveraudits erfassen möchten: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

**Protokolle weiterleiten**

1. Erstellen Sie eine Protokollierungskonfiguration.

    ```
    ibmcloud ks logging-config-create --cluster <clustername_oder_.id> --logsource kube-audit --space <clusterbereich> --org <clusterorganisation> --hostname <einpflege-url> --type ibm
    ```
    {: pre}

    Beispielbefehl und -ausgabe:

    ```
    ibmcloud ks logging-config-create --cluster myCluster --logsource kube-audit
    Creating logging configuration for kube-audit logs in cluster myCluster...
    OK
    Id                                     Source      Namespace   Host                                   Port     Org    Space   Server Type   Protocol  Application Containers   Paths
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -         ingest-au-syd.logging.bluemix.net✣    9091✣     -       -         ibm          -              -                  -

    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

    ```
    {: screen}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;clustername_oder_-id&gt;</em></code></td>
          <td>Der Name oder die ID des Clusters.</td>
        </tr>
        <tr>
          <td><code><em>&lt;einpflege-url&gt;</em></code></td>
          <td>Der Endpunkt, von dem aus Protokolle weitergeleitet werden sollen. Wenn Sie keine [Einpflege-URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls) angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</td>
        </tr>
        <tr>
          <td><code><em>&lt;clusterbereich&gt;</em></code></td>
          <td>Optional: Der Name des Cloud Foundry-Bereichs, an den Sie die Protokolle senden möchten. Wenn Sie Protokolle an {{site.data.keyword.loganalysisshort_notm}} senden, werden Bereich und Organisation im Einpflegepunkt angegeben. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet.</td>
        </tr>
        <tr>
          <td><code><em>&lt;clusterorganisation&gt;</em></code></td>
          <td>Der Name der Cloud Foundry-Organisation, in der sich der Bereich befindet. Dieser Wert ist erforderlich, wenn Sie einen Bereich angegeben haben.</td>
        </tr>
      </tbody>
    </table>

2. Überprüfen Sie die Protokollierungskonfiguration für Ihren Cluster, um sicherzustellen, dass diese nach Ihren Vorgaben implementiert wurde.

    ```
    ibmcloud ks logging-config-get --cluster <clustername_oder_-id>
    ```
    {: pre}

    Beispielbefehl und -ausgabe:
    ```
    ibmcloud ks logging-config-get --cluster myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. Gehen Sie wie folgt vor, um die Kubernetes-API-Auditereignisse anzuzeigen, die Sie weiterleiten:
  1. Melden Sie sich bei Ihrem {{site.data.keyword.Bluemix_notm}}-Konto an.
  2. Stellen Sie über den Katalog eine Instanz des {{site.data.keyword.cloudaccesstrailshort}}-Service im selben Konto wie Ihre Instanz von {{site.data.keyword.containerlong_notm}} bereit.
  3. Wählen Sie in der Registerkarte **Verwalten** des {{site.data.keyword.cloudaccesstrailshort}}-Dashboards die Konto- oder Bereichsdomäne aus.
    * **Kontoprotokolle:** Ereignisse der Clusterverwaltung und Ereignisse von Kubernetes-API-Serveraudits sind in der **Kontodomäne** für die {{site.data.keyword.Bluemix_notm}}-Region verfügbar, in der die Ereignisse generiert werden.
    * **Bereichsprotokolle:** Falls Sie einen Bereich angegeben haben, als Sie in Schritt 2 die Protokollierungskonfiguration angegeben haben, sind diese Ereignisse in der **Bereichsdomäne** verfügbar, die dem Cloud Foundry-Bereich zugeordnet ist, in dem der {{site.data.keyword.cloudaccesstrailshort}}-Service bereitgestellt wird.
  4. Klicken Sie auf **In Kibana anzeigen**.
  5. Legen Sie den Zeitrahmen fest, für den Sie Protokolle anzeigen möchten. Der Standardwert ist 24 Stunden.
  6. Zum Eingrenzen der Suche können Sie auf das Bearbeitungssymbol für `ActivityTracker_Account_Search_in_24h` klicken und Felder in der Spalte **Verfügbare Felder** hinzufügen.

  Die Informationen im Abschnitt [Berechtigungen zur Anzeige von Kontoereignissen erteilen](/docs/services/cloud-activity-tracker/how-to?topic=cloud-activity-tracker-grant_permissions#grant_permissions) helfen Ihnen dabei, wenn Sie andere Benutzer berechtigen wollen, Konto- und Bereichsereignisse anzuzeigen.
  {: tip}

<br />


## Erfassung von Masterprotokollen in einem {{site.data.keyword.cos_full_notm}}-Bucket
{: #collect_master}

Mit {{site.data.keyword.containerlong_notm}} können Sie zu einem beliebigen Zeitpunkt einen Snapshot der Masterprotokolle erstellen, um sie in einem {{site.data.keyword.cos_full_notm}}-Bucket zu erfassen. Der Snapshot enthält alle Daten, die über den API-Server gesendet werden, zum Beispiel Pod-Planungen, Bereitstellungen oder RBAC-Richtlinien.
{: shortdesc}

Da die Kubernetes-API-Serverprotokolle automatisch gestreamt werden, werden sie auch automatisch gelöscht, um Platz für neue Protokolle zu schaffen. Wenn Sie einen Snapshot der Protokolle von einem bestimmten Zeitpunkt aufbewahren, können Sie besser Probleme beheben, Verwendungsunterschiede prüfen und Muster zur leichteren Verwaltung noch sichererer Anwendungen suchen.

**Vorbereitende Schritte**

* [Stellen Sie eine Instanz](/docs/services/cloud-object-storage/basics?topic=cloud-object-storage-gs-dev) von {{site.data.keyword.cos_short}} im {{site.data.keyword.Bluemix_notm}}-Katalog bereit.
* Stellen Sie sicher, dass Sie die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für den Cluster innehaben.

**Snapshot erstellen**

1. Erstellen Sie über die {{site.data.keyword.Bluemix_notm}}-Konsole gemäß [diesem Lernprogramm zur Einführung](/docs/services/cloud-object-storage?topic=cloud-object-storage-getting-started#gs-create-buckets) einen Object Storage-Bucket.

2. Generieren Sie im soeben erstellten Bucket [HMAC-Serviceberechtigungsnachweise](/docs/services/cloud-object-storage/iam?topic=cloud-object-storage-service-credentials).
  1. Klicken Sie in der Registerkarte **Serviceberechtigungsnachweise** des {{site.data.keyword.cos_short}}-Dashboards auf **Neuer Berechtigungsnachweis**.
  2. Ordnen Sie den HMAC-Berechtigungsnachweisen die Servicerolle `Schreibberechtigter` zu.
  3. Geben Sie im Feld **Inline-Konfigurationsparameter hinzufügen** die Zeichenfolge `{"HMAC":true}` an.

3. Erstellen Sie in der Befehlszeilenschnittstelle eine Anforderung für einen Snapshot der Masterprotokolle.

  ```
  ibmcloud ks logging-collect --cluster <clustername_oder_id> --cos-bucket <cos-bucketname> --cos-endpoint <position_des_cos-buckets> --hmac-key-id <id_des_hmac-zugriffsschlüssels> --hmac-key <hmac-zugriffsschlüssel>
  ```
  {: pre}

  <table>
  <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
      <tr>
        <td><code>--cluster <em>&lt;clustername_oder_-id&gt;</em></code></td>
        <td>Der Name oder die ID des Clusters.</td>
      </tr>
      <tr>
        <td><code>--cos-bucket <em>&lt;cos-bucketname&gt;</em></code></td>
        <td>Der Name des {{site.data.keyword.cos_short}}-Buckets, in dem die Protokolle gespeichert werden sollen.</td>
      </tr>
      <tr>
        <td><code>--cos-endpoint <em>&lt;position_des_cos-buckets&gt;</em></code></td>
        <td>Der regionale, regionsübergreifende oder sich in einem einzelnen Rechenzentrum befindliche {{site.data.keyword.cos_short}}-Endpunkt für das Bucket, in dem die Protokolle gespeichert werden. Informationen zu verfügbaren Endpunkten finden Sie unter [Endpunkte und Speicherpositionen](/docs/services/cloud-object-storage/basics?topic=cloud-object-storage-endpoints) in der {{site.data.keyword.cos_short}}-Dokumentation.</td>
      </tr>
      <tr>
        <td><code>--hmac-key-id <em>&lt;id_des_hmac-zugriffsschlüssels&gt;</em></code></td>
        <td>Die eindeutige ID für die HMAC-Berechtigungsnachweise für die {{site.data.keyword.cos_short}}-Instanz.</td>
      </tr>
      <tr>
        <td><code>--hmac-key <em>&lt;hmac-zugriffsschlüssel&gt;</em></code></td>
        <td>Der HMAC-Schlüssel für die {{site.data.keyword.cos_short}}-Instanz.</td>
      </tr>
    </tbody>
  </table>

  Beispiel für Befehl und Antwort:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

4. Überprüfen Sie den Status der Anforderung. Die Ausführung des Snapshots kann einige Zeit dauern, Sie können jedoch überprüfen, ob die Anforderung erfolgreich ausgeführt wird. Sie können nach dem Namen der Datei suchen, in der die Masterprotokolle in der Antwort enthalten sind, und die Datei mithilfe der {{site.data.keyword.Bluemix_notm}}-Konsole herunterladen.

  ```
  ibmcloud ks logging-collect-status --cluster <clustername_oder_-id>
  ```
  {: pre}

  Beispielausgabe:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## Überwachungslösung auswählen
{: #view_metrics}

Mit Metriken können Sie den Zustand und die Leistung Ihrer Cluster überwachen. Sie können die Standardfeatures von Kubernetes und der Containerlaufzeit verwenden, um den Zustand Ihrer Cluster und Apps zu überwachen. **Hinweis**: Die Überwachung wird nur für Standardcluster unterstützt.
{:shortdesc}

**Wird mein Cluster von IBM überwacht?**

Jeder Kubernetes-Master wird kontinuierlich von IBM überwacht. {{site.data.keyword.containerlong_notm}} überprüft automatisch jeden Knoten, auf dem der Kubernetes-Master bereitgestellt ist, auf Schwachstellen bzw. Sicherheitslücken, die in Kubernetes festgestellt wurden, und auf betriebssystemspezifische Korrekturen (Fixes) für die Sicherheit. Werden Schwachstellen bzw. Sicherheitslücken festgestellt, wendet {{site.data.keyword.containerlong_notm}} automatisch entsprechende Korrekturen (Fixes) an und beseitigt Schwachstellen bzw. Sicherheitslücken für den Benutzer, um den Schutz des Masterknotens sicherzustellen. Sie sind für die Überwachung und Analyse der Protokolle für die übrigen Clusterkomponenten verantwortlich.

Stellen Sie sicher, dass die Cluster in den Ressourcengruppen und Regionen eindeutige Namen haben, um Konflikte bei der Verwendung von Metrikservices zu vermeiden.
{: tip}

<dl>
  <dt>{{site.data.keyword.mon_full_notm}}</dt>
    <dd>Gewinnen Sie betriebliche Einblicke in die Leistung und den Allgemeinzustand Ihrer Apps, indem Sie Sysdig als Drittanbieterservice auf Ihren Workerknoten bereitstellen, um Metriken an {{site.data.keyword.monitoringlong}} weiterzuleiten. Weitere Informationen finden Sie unter [Metriken für eine App analysieren, die in einem Kubernetes-Cluster bereitgestellt wurde](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster).</dd>

  <dt>Kubernetes-Dashboard</dt>
    <dd>Das Kubernetes-Dashboard ist eine Webschnittstelle für die Verwaltung, über die Sie den Zustand Ihrer Workerknoten überprüfen, Kubernetes-Ressourcen suchen, containerisierte Apps bereitstellen und Fehler bei Apps mithilfe von Protokollierungs- und Überwachungsdaten suchen und beheben können. Weitere Informationen dazu, wie Sie auf das Kubernetes-Dashboard zugreifen, finden Sie unter [Kubernetes-Dashboard für {{site.data.keyword.containerlong_notm}} starten](/docs/containers?topic=containers-app#cli_dashboard).</dd>

  <dt>Veraltet: Dashboard 'Metriken' in Clusterübersichtsseite der {{site.data.keyword.Bluemix_notm}}-Konsole und der Ausgabe von <code>ibmcloud ks cluster-get</code></dt>
    <dd>{{site.data.keyword.containerlong_notm}} stellt Information zum Zustand und zur Kapazität Ihres Clusters sowie zur Nutzung Ihrer Clusterressourcen bereit. Über diese Konsole können Sie Ihren Cluster horizontal skalieren, mit dem persistenten Speicher arbeiten und weitere Funktionalität durch Binden von {{site.data.keyword.Bluemix_notm}}-Services zu Ihrem Cluster hinzufügen. Zum Anzeigen der Metriken rufen Sie **Kubernetes** und anschließend das Dashboard **Cluster** auf, wählen einen Cluster aus und klicken auf den Link **Metriken**.
<p class="deprecated">Der Link zum Dashboard 'Metriken' in Clusterübersichtsseite der {{site.data.keyword.Bluemix_notm}}-Konsole und in der Ausgabe von `ibmcloud ks cluster-get` ist veraltet. Cluster, die nach dem 3. Mai 2019 erstellt werden, werden ohne den Link zum Dashboard 'Metriken' erstellt. Cluster, die am oder vor dem 3. Mai 2019 erstellt werden, verfügen weiterhin über den Link zum Dashboard 'Metriken'.</p></dd>

  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>Metriken für Standardcluster befinden sich in dem {{site.data.keyword.Bluemix_notm}}-Konto, das angemeldet war, als der Kubernetes-Cluster erstellt wurde. Wenn Sie beim Erstellen des Clusters einen {{site.data.keyword.Bluemix_notm}}-Bereich angegeben haben, befinden sich die Metriken in diesem Bereich. Containermetriken werden automatisch für alle Container erfasst, die in einem Cluster bereitgestellt werden. Diese Metriken werden durch Grafana gesendet und verfügbar gemacht. Weitere Informationen zu Metriken finden Sie unter [Überwachung für {{site.data.keyword.containerlong_notm}}](/docs/services/cloud-monitoring/containers?topic=cloud-monitoring-monitoring_bmx_containers_ov#monitoring_bmx_containers_ov).</p>
    <p>Zum Zugriff auf das Grafana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.</p>
    <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die verbleibenden Zeilen enthalten von links nach rechts die jeweilige Serverzone in der ersten Spalte und die entsprechenden IP-Adressen in der zweiten Spalte.">
      <caption>Zu öffnende IP-Adressen für die Überwachung von Datenverkehr</caption>
            <thead>
            <th>{{site.data.keyword.containerlong_notm}}-Region</th>
            <th>Überwachungsadresse</th>
            <th>Überwachungsteilnetze</th>
            </thead>
          <tbody>
            <tr>
             <td>Mitteleuropa</td>
             <td><code>metrics.eu-de.bluemix.net</code></td>
             <td><code>158.177.65.80/30</code></td>
            </tr>
            <tr>
             <td>Vereinigtes Königreich (Süden)</td>
             <td><code>metrics.eu-gb.bluemix.net</code></td>
             <td><code>169.50.196.136/29</code></td>
            </tr>
            <tr>
              <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden), Asien-Pazifik (Norden), Asien-Pazifik (Süden)</td>
              <td><code>metrics.ng.bluemix.net</code></td>
              <td><code>169.47.204.128/29</code></td>
             </tr>
            </tbody>
          </table> </dd>
</dl>

### Weitere Tools des Statusmonitors
{: #health_tools}

Sie können weitere Tools für zusätzliche Überwachungsfunktionen konfigurieren.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus ist ein Open-Source-Tool für die Überwachung, Protokollierung und Benachrichtigung bei Alerts, das für Kubernetes entwickelt wurde. Das Tool ruft auf Grundlage der Kubernetes-Protokollierungsinformationen detaillierte Informationen zu Cluster, Workerknoten und Bereitstellungszustand ab. Weitere Informationen zur Konfiguration finden Sie in den [CoreOS-Anweisungen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus).</dd>
</dl>

<br />




## Clusterstatus anzeigen
{: #states}

Überprüfen Sie den Status eines Kubernetes-Clusters, um Informationen zur Verfügbarkeit und Kapazität des Clusters sowie zu möglichen Problemen, die auftreten können, zu erhalten.
{:shortdesc}

Wenn Sie Informationen zu einem bestimmten Cluster anzeigen möchten, zum Beispiel Zonen, Serviceendpunkt-URLs, Ingress-Unterdomäne, Version und Eigner, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get --cluster <clustername_oder_-id>`. Schließen Sie das Flag `--showResources` ein, um weitere Clusterressourcen, wie zum Beispiel Add-ons für Speicherpods oder Teilnetz-VLANs für öffentliche und private IPs anzuzeigen.

Sie können Informationen zum Gesamtcluster, zum IBM verwalteten Master und zu Ihren Workerknoten überprüfen. Informationen zum Beheben von Fehlern bei Clustern und Workerknoten finden Sie im Abschnitt [Fehlerbehebung bei Clustern](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters).

### Clusterstatus
{: #states_cluster}

Sie können den aktuellen Clusterstatus anzeigen, indem Sie den Befehl `ibmcloud ks clusters` ausführen. Der Status wird im entsprechenden **Statusfeld** angezeigt. 
{: shortdesc}

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Clusterstatus</caption>
   <thead>
   <th>Clusterstatus</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>`Aborted (Abgebrochen)`</td>
   <td>Das Löschen des Clusters wird vom Benutzer angefordert, bevor der Kubernetes Master bereitgestellt ist. Nachdem das Löschen des Clusters abgeschlossen ist, wird der Cluster aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
 <tr>
     <td>`Critical (Kritisch)`</td>
     <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. </td>
    </tr>
   <tr>
     <td>`Delete failed (Löschen fehlgeschlagen)`</td>
     <td>Der Kubernetes Masterknoten oder mindestens ein Workerknoten kann nicht gelöscht werden.  </td>
   </tr>
   <tr>
     <td>`Deleted (Gelöscht)`</td>
     <td>Der Cluster wird gelöscht, aber noch nicht aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
   <td>`Deleting (Löschen)`</td>
   <td>Der Cluster wird gelöscht, und die Clusterinfrastruktur wird abgebaut. Der Zugriff auf den Cluster ist nicht möglich.  </td>
   </tr>
   <tr>
     <td>`Deploy failed (Bereitstellung fehlgeschlagen)`</td>
     <td>Die Bereitstellung des Kubernetes-Masters konnte nicht abgeschlossen werden. Sie können diesen Status nicht auflösen. Wenden Sie sich an den Support für IBM Cloud, indem Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help) öffnen.</td>
   </tr>
     <tr>
       <td>`Deploying (Wird bereitgestellt)`</td>
       <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen. Warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters.</td>
      </tr>
      <tr>
       <td>`Normal`</td>
       <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion von Ihnen.<p class="note">Auch wenn die Workerknoten ordnungsgemäß funktionieren, bedürfen andere Infrastrukturressourcen wie [Netz](/docs/containers?topic=containers-cs_troubleshoot_network) und [Speicher](/docs/containers?topic=containers-cs_troubleshoot_storage) möglicherweise Ihrer Aufmerksamkeit. Wenn Sie den Cluster gerade erstellt haben, befinden sich einige Teile des Clusters, die von anderen Services wie z. B. geheimen Ingress-Schlüsseln oder geheimen Schlüsseln für Registry-Image-Pull-Operationen verwendet werden, möglicherweise noch in Bearbeitung.</p></td>
    </tr>
      <tr>
       <td>`Pending (Anstehend)`</td>
       <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.  </td>
     </tr>
   <tr>
     <td>`Requested (Angefordert)`</td>
     <td>Eine Anforderung zum Erstellen des Clusters und zum Bestellen der Infrastruktur für die Kubernetes Master- und Workerknoten wird gesendet. Wenn die Bereitstellung des Clusters gestartet wird, ändert sich der Clusterstatus in <code>Deploying</code> (Wird bereitgestellt). Wenn Ihr Cluster lange Zeit im Status <code>Requested</code> (Angefordert) blockiert ist, öffnen Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
     <td>`Updating (Aktualisierung)`</td>
     <td>Der Kubernetes API-Server, der in Ihrem Kubernetes-Master ausgeführt wird, wird auf eine neue Version der Kubernetes-API aktualisiert. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch Änderungen am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt. Warten Sie, bis die Aktualisierung abgeschlossen ist, und überprüfen Sie dann den Status Ihres Clusters. </td>
   </tr>
   <tr>
    <td>`Nicht unterstützt`</td>
    <td>Die [Kubernetes-Version](/docs/containers?topic=containers-cs_versions#cs_versions), die der Cluster ausführt, wird nicht mehr unterstützt. Der Zustand des Clusters wird nicht mehr aktiv überwacht oder gemeldet. Darüber hinaus können Sie keine Workerknoten hinzufügen oder erneut laden. Um weiterhin wichtige Sicherheitsupdates und Unterstützung erhalten zu können, müssen Sie Ihren Cluster aktualisieren. Prüfen Sie die [Aktionen zum Vorbereiten der Versionsaktualisierung](/docs/containers?topic=containers-cs_versions#prep-up) und [aktualisieren Sie Ihren Cluster](/docs/containers?topic=containers-update#update) auf eine unterstützte Kubernetes-Version.<br><br><p class="note">Cluster mit einer Version, die drei oder mehr Versionen älter als die älteste unterstützte Version ist, können nicht aktualisiert werden. Zur Vermeidung dieser Situation können Sie den Cluster auf eine Kubernetes-Version aktualisieren, die der aktuellen Version weniger als drei Versionen voraus ist, wie zum Beipiel die Versionen 1.12 bis 1.14. Wenn Ihre Cluster Version 1.5, 1.7 oder 1.8 ausführt, ist die Version zu alt für eine Aktualisierung. Stattdessen müssen Sie [einen Cluster erstellen](/docs/containers?topic=containers-clusters#clusters) und [Ihre Apps für den Cluster bereitstellen](/docs/containers?topic=containers-app#app).</p></td>
   </tr>
    <tr>
       <td>`Warning (Warnung)`</td>
       <td>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen. </td>
    </tr>
   </tbody>
 </table>




### Masterstatus
{: #states_master}

Ihre {{site.data.keyword.containerlong_notm}}-Instanz schließt einen IBM verwalteten Master mit Hochverfügbarkeitsreplikaten, für Sie angewendete automatische Sicherheitspatchaktualisierungen sowie Automatisierung zur Wiederherstellung nach einer Störung ein. Sie können den Zustand und den Status des Cluster-Masters überprüfen, indem Sie `ibmcloud ks cluster-get --cluster <clustername_oder_-id>` ausführen.
{: shortdesc} 

**Masterstatus**<br>
Der **Masterstatus** (Master Health) spiegelt den Status der Masterkomponenten wider und benachrichtigt Sie, wenn Ihre Aufmerksamkeit erforderlich ist. Der Status kann einen der folgenden Werte aufweisen:
*   `error (Fehler)`: Der Master ist nicht betriebsbereit. IBM wird automatisch benachrichtigt und ergreift Maßnahmen zur Behebung dieses Problems. Sie können den Status weiter überwachen, bis der Master den Status `normal` aufweist.
*   `normal`: Der Master ist betriebsbereit und in einwandfreiem Zustand. Es ist keine Aktion erforderlich.
*   `unavailable (nicht verfügbar)`: Der Master ist möglicherweise nicht zugänglich. Dies bedeutet, dass einige Aktionen, wie z. B. die Änderung der Größe eines Worker-Pools, vorübergehend nicht verfügbar sind. IBM wird automatisch benachrichtigt und ergreift Maßnahmen zur Behebung dieses Problems. Sie können den Status weiter überwachen, bis der Master den Status `normal` aufweist. 
*   `unsupported (nicht unterstützt)`: Der Master führt eine nicht unterstützte Version von Kubernetes aus. Sie müssen [Ihren Cluster aktualisieren](/docs/containers?topic=containers-update), um den Master wieder in einen normalen Status (`normal`) zu versetzen.

**Masterstatus und -zustand**<br>
Der **Masterstatus** (Master Status) stellt Details zu den Operationen bereit, die über den Masterzustand in Bearbeitung sind. Der Status umfasst eine Zeitmarke dazu, wie lange der Master sich in demselben Zustand befand, z. B. `Ready (1 month ago)` (Bereit (vor 1 Monat). Der **Masterzustand** (Master State) spiegelt den Lebenszyklus möglicher Operationen wider, die auf dem Master ausgeführt werden können, z. B. Bereitstellen, Aktualisieren oder Löschen. Die einzelnen Zustände werden in der folgenden Tabelle beschrieben.

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Masterzustand in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Masterzustände</caption>
   <thead>
   <th>Masterzustand</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>`deployed (bereitgestellt)`</td>
   <td>Der Master wurde erfolgreich bereitgestellt. Überprüfen Sie den Zustand, um zu verifizieren, dass der Master betriebsbereit (`Ready`) ist, oder um festzustellen, ob eine Aktualisierung verfügbar ist.</td>
   </tr>
 <tr>
     <td>`deploying (wird bereitgestellt)`</td>
     <td>Der Master wird zurzeit bereitgestellt. Warten Sie, bis der Zustand in `deployed` (bereitgestellt) geändert wird, bevor Sie mit Ihrem Cluster arbeiten, z. B. um Workerknoten hinzuzufügen.</td>
    </tr>
   <tr>
     <td>`deploy_failed (Bereitstellung fehlgeschlagen)`</td>
     <td>Die Bereitstellung des Masters ist fehlgeschlagen. Der IBM Support wird benachrichtigt und arbeitet an einer Lösung des Problems. Überprüfen Sie das ****Masterstatusfeld auf weitere Informationen oder warten Sie, bis der Zustand in `deployed` (bereitgestellt) geändert wird.</td>
   </tr>
   <tr>
   <td>`deleting (wird gelöscht)`</td>
   <td>Der Master wird zurzeit gelöscht, weil Sie den Cluster gelöscht haben. Ein Löschvorgang kann nicht rückgängig gemacht werden. Nach dem Löschen des Clusters können Sie den Masterzustand nicht mehr überprüfen, da der Cluster vollständig entfernt wird.</td>
   </tr>
     <tr>
       <td>`delete_failed (Löschen fehlgeschlagen)`</td>
       <td>Das Löschen des Masters ist fehlgeschlagen. Der IBM Support wird benachrichtigt und arbeitet an einer Lösung des Problems. Sie können das Problem nicht lösen, indem Sie versuchen, den Cluster erneut zu löschen. Überprüfen Sie stattdessen das ****Masterstatusfeld auf weitere Informationen oder warten Sie, bis der Cluster gelöscht wurde.</td>
      </tr>
      <tr>
       <td>`updating (wird aktualisiert)`</td>
       <td>Der Master aktualisiert seine Kubernetes-Version. Bei der Aktualisierung kann es sich um eine Patchaktualisierung handeln, die automatisch angewendet wird, oder um eine über- oder untergeordnete Version, die Sie durch Aktualisieren des Clusters angewendet haben. Während der Aktualisierung kann Ihr hoch verfügbarer Master die Verarbeitung von Anforderungen fortsetzen und Ihre App-Workloads und Workerknoten werden weiterhin ausgeführt. Wenn die Aktualisierung abgeschlossen ist, können Sie [Ihre Workerknoten aktualisieren](/docs/containers?topic=containers-update#worker_node).<br><br>
       Ist die Aktualisierung nicht erfolgreich, wird der Master wieder in den Zustand `deployed` (bereitgestellt) versetzt und führt die Vorgängerversion weiter aus. Der IBM Support wird benachrichtigt und arbeitet an einer Lösung des Problems. Sie können im ****Masterstatusfeld überprüfen, ob die Aktualisierung fehlgeschlagen ist.</td>
    </tr>
   </tbody>
 </table>




### Status des Workerknotens
{: #states_workers}

Sie können den aktuellen Workerknotenzustand anzeigen, indem Sie den Befehl `ibmcloud ks workers --cluster <clustername_oder_ID` ausführen. Der Status und der Zustand werden in den entsprechenden Feldern ******** angezeigt.
{: shortdesc}

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Status des Workerknotens</caption>
  <thead>
  <th>Status des Workerknotens</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
<tr>
    <td>`Critical (Kritisch)`</td>
    <td>Ein Workerknoten kann aus vielen Gründen in einen kritischen Status wechseln: <ul><li>Sie haben einen Warmstart für Ihren Workerknoten eingeleitet, ohne den Workerknoten zu abzuriegeln und zu entleeren. Der Warmstart eines Workerknotens kann zu Datenverlust in <code>containerd</code>, <code>kubelet</code>, <code>kube-proxy</code> und <code>calico</code> führen. </li>
    <li>Die Pods, die auf Ihrem Workerknoten bereitgestellt wurden, verwenden keine Ressourcengrenzen für [Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) und [CPU ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Ohne Ressourcengrenzen können die Pods alle verfügbaren Ressourcen in Anspruch nehmen und keine Ressourcen mehr für andere Pods übrig lassen, die auch auf diesem Workerknoten ausgeführt werden. Diese Überbelegung durch Workload führt dazu, dass der Workerknoten fehlschlägt. </li>
    <li><code>containerd</code>, <code>kubelet</code> oder <code>calico</code> geraten in einen nicht behebbaren kritischen Zustand, nachdem Hunderte oder Tausende von Containern ausgeführt wurden. </li>
    <li>Sie haben eine Virtual Router Appliance für Ihren Workerknoten eingerichtet, die fehlschlug und die Kommunikation zwischen Ihrem Workerknoten und dem Kubernetes-Master unterbrochen hat. </li><li> Aktuelle Netzprobleme in {{site.data.keyword.containerlong_notm}} oder IBM Cloud Infrastructure (SoftLayer), die ein Fehlschlagen der Kommunikation zwischen Ihrem Workerknoten und dem Kubernetes-Master verursachen.</li>
    <li>Ihr Workerknoten hat keine Kapazität mehr. Überprüfen Sie den <strong>Status</strong> des Workerknotens, um zu sehen, ob <strong>Out of disk</strong> (zu wenig Plattenspeicher) oder <strong>Out of memory</strong> (zu wenig Hauptspeicher) angezeigt wird. Wenn Ihr Workerknoten die Kapazitätsgrenze erreicht hat, können Sie entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern.</li>
    <li>Die Einheit wurde über die [Ressourcenliste der {{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/resources) ausgeschaltet. Öffnen Sie die Ressourcenliste und suchen Sie Ihre Workerknoten-ID in der Liste **Geräte**. Klicken Sie im Aktionsmenü auf die Option **Einschalten**.</li></ul>
    In vielen Fällen kann ein [Neuladen](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) Ihres Workerknotens das Problem lösen. Wenn Sie Ihren Workerknoten neu laden, wird die aktuellste [Patchversion](/docs/containers?topic=containers-cs_versions#version_types) auf Ihren Workerknoten angewendet. Die Haupt- und Nebenversion werden nicht geändert. Bevor Sie Ihren Workerknoten erneut laden, stellen Sie sicher, dass Ihr Workerknoten abgeriegelt und entleert wurde, damit die vorhandenen Pods ordnungsgemäß beendet und auf den verbleibenden Workerknoten neu geplant werden können. </br></br> Wenn das Neuladen des Workerknotens das Problem nicht löst, wechseln Sie zum nächsten Schritt, um mit der Fehlerbehebung Ihrer Workerknoten fortzufahren. </br></br><strong>Tipp:</strong> Sie können [Statusprüfungen für Ihre Workerknoten konfigurieren und die automatische Wiederherstellung aktiveren](/docs/containers?topic=containers-health#autorecovery). Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Weitere Informationen zur Funktionsweise der automatischen Wiederherstellung finden Sie im [Blogbeitrag zur automatischen Wiederherstellung![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
    </td>
   </tr>
   <tr>
   <td>`Deployed (Bereitgestellt)`</td>
   <td>Aktualisierungen wurden erfolgreich auf Ihrem Workerknoten bereitgestellt. Nach der Bereitstellung von Aktualisierungen startet {{site.data.keyword.containerlong_notm}} eine Zustandsprüfung auf dem Workerknoten. Wenn die Zustandsprüfung erfolgreich war, wechselt der Workerknoten in den Status <code>Normal</code>. Workerknoten im Status <code>Deployed</code> (Bereitgestellt) sind normalerweise dafür bereit, Workloads zu empfangen. Sie können dies überprüfen, indem Sie <code>kubectl get nodes</code> ausführen und bestätigen, dass der Zustand <code>Normal</code> angezeigt wird. </td>
   </tr>
    <tr>
      <td>`Deploying (Wird bereitgestellt)`</td>
      <td>Wenn Sie die Kubernetes-Version Ihres Workerknotens aktualisieren, wird der Workerknoten erneut bereitgestellt, um die Aktualisierungen zu installieren. Wenn Sie Ihren Workerknoten neu starten, wird der Workerknoten erneut bereitgestellt, um die neueste Patchversion automatisch zu installieren. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist. </td>
   </tr>
      <tr>
      <td>`Normal`</td>
      <td>Ihr Workerknoten wurde vollständig bereitgestellt und kann im Cluster verwendet werden. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion vom Benutzer. **Hinweis**: Auch wenn die Workerknoten ordnungsgemäß funktionieren, bedürfen andere Infrastrukturressourcen wie [Netz](/docs/containers?topic=containers-cs_troubleshoot_network) und [Speicher](/docs/containers?topic=containers-cs_troubleshoot_storage) möglicherweise Ihrer Aufmerksamkeit.</td>
   </tr>
 <tr>
      <td>`Provisioning (Wird bereitgestellt)`</td>
      <td>Ihr Workerknoten wird gerade eingerichtet und ist noch nicht im Cluster verfügbar. Sie können den Bereitstellungsprozess in der Spalte <strong>Status</strong> Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist.</td>
    </tr>
    <tr>
      <td>`Provision_failed (Bereitstellung fehlgeschlagen)`</td>
      <td>Ihr Workerknoten konnte nicht bereitgestellt werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
    </tr>
 <tr>
      <td>`Reloading (Wird neu geladen)`</td>
      <td>Ihr Workerknoten wird neu geladen und ist nicht im Cluster verfügbar. Sie können den Neuladeprozess in der Spalte <strong>Status</strong> Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während des Neuladens ein Problem aufgetreten ist.</td>
     </tr>
     <tr>
      <td>`Reloading_failed (Neuladen fehlgeschlagen) `</td>
      <td>Ihr Workerknoten konnte nicht neu geladen werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
    </tr>
    <tr>
      <td>`Reload_pending (Neuladen anstehend) `</td>
      <td>Eine Anforderung zum Neuladen oder Aktualisieren der Kubernetes-Version Ihrer Workerknoten wurde gesendet. Wenn der Workerknoten erneut geladen wird, ändert sich der Status in <code>Reloading</code>. </td>
    </tr>
    <tr>
     <td>`Unknown (Unbekannt)`</td>
     <td>Der Kubernetes-Master ist aus einem der folgenden Gründe nicht erreichbar:<ul><li>Sie haben ein Update Ihres Kubernetes-Masters angefordert. Der Status des Workerknotens kann während des Updates nicht abgerufen werden. Wenn der Workerknoten auch nach einer erfolgreichen Aktualisierung des Kubernetes-Masters für längere Zeit in diesem Status verbleibt, versuchen Sie, den Workerknoten [erneut zu laden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload).</li><li>Sie haben möglicherweise eine weitere Firewall, die Ihre Workerknoten schützt, oder Sie haben die Firewalleinstellungen kürzlich geändert. {{site.data.keyword.containerlong_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Weitere Informationen finden Sie in [Firewall verhindert Verbindung für Workerknoten](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_firewall).</li><li>Der Kubernetes-Master ist inaktiv. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie einen [{{site.data.keyword.Bluemix_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help) öffnen.</li></ul></td>
</tr>
   <tr>
      <td>`Warning (Warnung)`</td>
      <td>Ihr Workerknoten nähert sich dem Grenzwert für die Speicher- oder Plattenkapazität. Sie können entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern.</td>
</tr>
  </tbody>
</table>




## Statusprüfmonitor für Workerknoten mit automatischer Wiederherstellung konfigurieren
{: #autorecovery}

Das System verwendet verschiedene Prüfungen zum Abfragen des allgemeinen Zustands von Workerknoten. Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Diese Korrekturmaßnahme wird immer nur für einen Workerknoten ausgeführt. Die Korrekturmaßnahme muss für diesen Workerknoten erfolgreich abgeschlossen werden, bevor für einen weiteren Workerknoten eine Korrekturmaßnahme durchgeführt werden kann. Weitere Informationen finden Sie in diesem [Blogbeitrag zur automatischen Wiederherstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
{: shortdesc}

Für die automatische Wiederherstellung ist es erforderlich, dass mindestens ein ordnungsgemäß funktionierender Workerknoten vorhanden ist. Konfigurieren Sie die automatische Wiederherstellung mit aktiven Prüfungen nur in Clustern mit mindestens zwei Workerknoten.
{: note}

Vorbereitende Schritte:
- Stellen Sie sicher, dass Sie die folgenden [{{site.data.keyword.Bluemix_notm}}-IAM-Rollen](/docs/containers?topic=containers-users#platform) innehaben:
    - Plattformrolle **Administrator** für den Cluster
    - Servicerolle **Schreibberechtigter** oder **Manager** für den Namensbereich `kube-system`
- [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Gehen Sie wie folgt vor, um die automatische Wiederherstellung zu konfigurieren:

1.  [Befolgen Sie die Anweisungen](/docs/containers?topic=containers-helm#public_helm_install) zum Installieren des Helm-Clients auf Ihrer lokalen Maschine, Installieren des Helm-Servers (Tiller) mit einem Servicekonto und Hinzufügen des {{site.data.keyword.Bluemix_notm}}-Helm-Repositorys.

2.  Überprüfen Sie, ob 'tiller' mit einem Servicekonto installiert ist.
    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    Beispielausgabe:
    ```
    NAME                                 SECRETS   AGE
    tiller                               1         2m
    ```
    {: screen}

3. Erstellen Sie eine Konfigurationszuordnungsdatei, mit der die Prüfungen im JSON-Format definiert werden. In der folgenden YAML-Datei sind beispielsweise drei Prüfungen angegeben: eine HTTP-Prüfung und zwei Kubernetes-API-Serverprüfungen. In den Tabellen nach der YAML-Beispieldatei finden Sie Informationen zu den drei Arten von Überprüfungen und zu den einzelnen Komponenten dieser Überprüfungen.
</br>
   **Tipp:** Definieren Sie jede Prüfung als eindeutigen Schlüssel im Abschnitt `data` der Konfigurationszuordnung (ConfigMap).

   ```
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ibm-worker-recovery-checks
     namespace: kube-system
   data:
     checknode.json: |
       {
         "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
        }
      checkpod.json: |
        {
         "Check":"KUBEAPI",
         "Resource":"POD",
         "PodFailureThresholdPercent":50,
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
     checkhttp.json: |
       {
         "Check":"HTTP",
         "FailureThreshold":3,
         "CorrectiveAction":"REBOOT",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Port":80,
         "ExpectedStatus":200,
         "Route":"/myhealth",
         "Enabled":false
       }
   ```
   {:codeblock}

   <table summary="Erklärung der Komponenten der Konfigurationszuordnung (configmap)">
   <caption>Erklärung der Komponenten der Konfigurationszuordnung</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/>Erklärung der Komponenten der Konfigurationszuordnung</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>Der Konfigurationsname <code>ibm-worker-recovery-checks</code> ist eine Konstante und kann nicht geändert werden.</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td>Der Namensbereich <code>kube-system</code> ist eine Konstante und kann nicht geändert werden.</td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Definiert eine Kubernetes-API-Knotenprüfung, mit der ermittelt wird, ob sich jeder Workerknoten im Bereitstatus (<code>Ready</code>) befindet. Die Prüfung eines bestimmten Workerknotens wird als Fehler gezählt, wenn sich der betreffende Workerknoten nicht im Status <code>Ready</code> befindet. Die Prüfung in der YAML-Beispieldatei wird alle 3 Minuten durchgeführt. Schlägt die Prüfung drei Mal hintereinander fehl, wird der Workerknoten neu geladen. Diese Aktion ist äquivalent zur Ausführung von <code>ibmcloud ks worker-reload</code>.<br></br>Die Knotenprüfung bleibt so lange aktiviert, bis Sie das Feld <b>Enabled</b> auf den Wert <code>false</code> setzen oder die Prüfung entfernen.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
   Definiert eine Kubernetes-API-Podprüfung, mit der auf Basis der Gesamtzahl der einem Workerknoten zugewiesenen Pods ermittelt wird, welcher prozentuale Anteil der Pods in dem betreffenden Workerknoten insgesamt den Status <code>NotReady</code> (nicht bereit) aufweist. Die Prüfung eines bestimmten Workerknotens wird als Fehler gezählt, wenn der Gesamtprozentsatz der Pods im Status <code>NotReady</code> größer ist als der für <code>PodFailureThresholdPercent</code> festgelegte Wert. Die Prüfung in der YAML-Beispieldatei wird alle 3 Minuten durchgeführt. Schlägt die Prüfung drei Mal hintereinander fehl, wird der Workerknoten neu geladen. Diese Aktion ist äquivalent zur Ausführung von <code>ibmcloud ks worker-reload</code>. Der Standardwert für <code>PodFailureThresholdPercent</code> ist beispielsweise 50 %. Wenn der Prozentsatz der Pods mit dem Status <code>NotReady</code> dreimal hintereinander höher als 50 % ist, wird der Workerknoten neu geladen. <br></br>Standardmäßig werden Pods in allen Namensbereichen geprüft. Um nur Pods in einem angegebenen Namensbereich zu prüfen, fügen Sie das Feld <code>Namespace</code> zur Prüfung hinzu. Die Podprüfung bleibt so lange aktiviert, bis Sie das Feld <b>Enabled</b> auf den Wert <code>false</code> setzen oder die Prüfung entfernen.
   </td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>Definiert eine HTTP-Prüfung, die feststellt, ob ein auf einem Workerknoten ausgeführter HTTP-Server sich in einwandfreiem Zustand befindet. Damit Sie diese Prüfung verwenden können, müssen Sie einen HTTP-Server auf jedem Workerknoten mit einer [Dämongruppe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) im Cluster bereitstellen. Sie müssen eine Statusprüfung implementieren, die im Pfad <code>/myhealth</code> verfügbar ist und überprüfen kann, ob sich Ihr HTTP-Server in einwandfreiem Zustand befindet. Sie können andere Pfade definieren, indem Sie den Parameter <code>Route</code> ändern. Falls sich der HTTP-Server in einwandfreiem Zustand befindet, müssen Sie den HTTP-Antwortcode zurückgeben, der in <code>ExpectedStatus</code> definiert ist. Der HTTP-Server muss so konfiguriert sein, dass er die private IP-Adresse des Workerknotens überwacht. Die private IP-Adresse kann durch Ausführen des Befehls <code>kubectl get nodes</code> ermittelt werden.<br></br>
   Beispiel: Angenommen, ein Cluster enthält zwei Knoten mit den privaten IP-Adressen 10.10.10.1 und 10.10.10.2. In diesem Beispiel werden zwei Routen hinsichtlich einer 200 HTTP-Antwort geprüft: <code>http://10.10.10.1:80/myhealth</code> und <code>http://10.10.10.2:80/myhealth</code>.
   Die Prüfung in der YAML-Beispieldatei wird alle 3 Minuten durchgeführt. Schlägt die Prüfung drei Mal hintereinander fehl, wird der Workerknoten neu gestartet. Diese Aktion ist äquivalent zur Ausführung von <code>ibmcloud ks worker-reboot</code>.<br></br>Die HTTP-Prüfung wird erst dann aktiviert, wenn Sie das Feld <b>Enabled</b> auf den Wert <code>true</code> setzen.</td>
   </tr>
   </tbody>
   </table>

   <table summary="Erklärung der einzelnen Prüfungskomponenten">
   <caption>Erklärung der einzelnen Prüfungskomponenten</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/>Erklärung der einzelnen Prüfungskomponenten </th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Geben Sie die Art der Prüfung an, die im Rahmen der automatischen Wiederherstellung verwendet werden soll. <ul><li><code>HTTP</code>: Bei der automatischen Wiederherstellung werden HTTP-Server aufgerufen, die auf den einzelnen Knoten aktiv sind, um zu ermitteln, ob die Knoten ordnungsgemäß ausgeführt werden.</li><li><code>KUBEAPI</code>: Bei der automatischen Wiederherstellung wird der Kubernetes-API-Server aufgerufen und die Daten zum Allgemeinzustand gelesen, die von den Workerknoten gemeldet werden.</li></ul></td>
   </tr>
   <tr>
   <td><code>Resource</code></td>
   <td>Wenn der Prüfungstyp <code>KUBEAPI</code> lautet, geben Sie den Ressourcentyp an, der im Rahmen der automatischen Wiederherstellung geprüft werden soll. Gültige Werte sind <code>NODE</code> oder <code>POD</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Geben Sie den Schwellenwert für die Anzahl der Prüfungen ein, die nacheinander fehlgeschlagen sind. Wenn dieser Schwellenwert erreicht wird, löst die automatische Wiederherstellung die angegebene Korrekturmaßnahme aus. Wenn beispielsweise der Schwellenwert '3' lautet und im Rahmen der automatischen Wiederherstellung dreimal in Folge eine konfigurierte Prüfung fehlschlägt, wird die der Prüfung zugeordnete Korrekturmaßnahme ausgelöst.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>Wenn der Ressourcentyp <code>POD</code> lautet, geben Sie den Schwellenwert für den Prozentsatz der Pods auf einem Workerknoten an, die den Zustand [<strong><code>'NotReady' </code></strong> ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) aufweisen können. Dieser Prozentsatz basiert auf der Gesamtanzahl an Pods, die auf einem Workerknoten geplant sind. Wenn durch eine Prüfung festgestellt wird, dass der Prozentsatz nicht ordnungsgemäß funktionierender Pods größer ist als der Schwellenwert, zählt die Prüfung als ein Fehler.</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>Geben Sie die Aktion ein, die ausgeführt werden soll, wenn der Fehlerschwellenwert erreicht wird. Eine Korrekturmaßnahme wird nur ausgeführt, während keine weiteren Worker repariert werden und wenn dieser Workerknoten sich nicht in einer 'Erholungsphase' von einer vorherigen Aktion befindet. <ul><li><code>REBOOT</code>: Startet den Workerknoten neu.</li><li><code>RELOAD</code>: Lädt alle erforderlichen Konfigurationen für den Workerknoten erneut von einem bereinigten Betriebssystem.</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>Geben Sie die Anzahl der Sekunden an, die die automatische Wiederherstellung warten muss, bis eine weitere Korrekturmaßnahme für einen Knoten abgesetzt werden kann, für den bereits eine Korrekturmaßnahme ausgelöst wurde. Dieser Zeitraum (Cooloff) beginnt zu dem Zeitpunkt, an dem die Korrekturmaßnahme eingeleitet wird.</td>
   </tr>
   <tr>
   <td><code>IntervalSeconds</code></td>
   <td>Geben Sie die Anzahl der Sekunden für den Zeitraum zwischen zwei aufeinanderfolgenden Prüfungen ein. Wenn der Wert beispielsweise '180' lautet, führt die automatische Wiederherstellung die Prüfung alle drei Minuten für einen Knoten aus.</td>
   </tr>
   <tr>
   <td><code>TimeoutSeconds</code></td>
   <td>Geben Sie die maximale Anzahl der Sekunden ein, die ein Prüfungsaufruf an die Datenbank dauern darf, bevor die automatische Wiederherstellung die Aufrufoperation beendet. Der Wert für <code>TimeoutSeconds</code> muss kleiner sein als der Wert für <code>IntervalSeconds</code>.</td>
   </tr>
   <tr>
   <td><code>Port</code></td>
   <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben Sie den Port ein, an den der HTTP-Server auf dem Workerknoten gebunden werden muss. Dieser Port muss an der IP jedes Workerknotens im Cluster zugänglich sein. Bei der automatischen Wiederherstellung ist für die Prüfung von Servern eine konstante Portnummer auf allen Knoten erforderlich. Verwenden Sie [Dämongruppen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) bei der Bereitstellung eines angepassten Servers in einem Cluster.</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben sie den HTTP-Serverstatus ein, der als Rückgabewert der Prüfung erwartet wird. Beispielsweise gibt der Wert '200' an, dass Sie als Antwort <code>OK</code> vom Server erwarten.</td>
   </tr>
   <tr>
   <td><code>Route</code></td>
   <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben Sie den Pfad an, der vom HTTP-Server angefordert wird. Der Wert ist in der Regel der Metrikenpfad für den Server, der auf allen Workerknoten ausgeführt wird.</td>
   </tr>
   <tr>
   <td><code>Enabled</code></td>
   <td>Geben Sie <code>true</code> ein, um die Prüfung zu aktivieren, oder <code>false</code>, um die Prüfung zu inaktivieren.</td>
   </tr>
   <tr>
   <td><code>Namespace</code></td>
   <td> Optional: Damit <code>checkpod.json</code> nur Pods in einem Namensbereich prüft, fügen Sie das Feld <code>Namespace</code> hinzu und geben Sie den Namensbereich ein.</td>
   </tr>
   </tbody>
   </table>

4. Erstellen Sie die Konfigurationszuordnung in Ihrem Cluster.
    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

5. Stellen Sie sicher, dass Sie die Konfigurationszuordnung mit dem Namen `ibm-worker-recovery-checks` im Namensbereich `kube-system` mit den richtigen Prüfungen erstellt haben.
    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

6. Stellen Sie die automatische Wiederherstellung in Ihrem Cluster durch die Installation des `ibm-worker-recovery`-Helm-Diagramm bereit.
    ```
    helm install --name ibm-worker-recovery iks-charts/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

7. Nach einigen Minuten können Sie den Abschnitt `Events` in der Ausgabe des folgenden Befehls auf mögliche Aktivitäten bei der Bereitstellung der automatischen Wiederherstellung überprüfen.
    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

8. Wenn Sie keine Aktivitäten bei der Bereitstellung der automatischen Wiederherstellung erkennen, können Sie die Helm-Bereitstellung überprüfen, indem Sie die Tests ausführen, die in der Diagrammdefinition für die automatische Wiederherstellung enthalten sind.
    ```
    helm test ibm-worker-recovery
    ```
    {: pre}
