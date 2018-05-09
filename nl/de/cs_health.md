---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Cluster protokollieren und überwachen
{: #health}

Legen Sie die Protokollierung und Überwachung in {{site.data.keyword.containerlong}} fest, um Unterstützung bei der Fehlerbehebung zu erhalten und um die Leistung Ihrer Kubernetes-Cluster und Apps zu verbessern.
{: shortdesc}


## Protokollweiterleitung konfigurieren
{: #logging}

Mit einem Kubernetes-Standardcluster in {{site.data.keyword.containershort_notm}} können Sie Protokolle von unterschiedlichen Quellen an {{site.data.keyword.loganalysislong_notm}}, an einen externen Systemprotokollserver oder an beide weiterleiten.
{: shortdesc}

Wenn Sie Protokolle von einer Quelle an beide Kollektorserver weiterleiten möchten, müssen Sie zwei Protokollierungskonfigurationen erstellen.
{: tip}

Überprüfen Sie die folgende Tabelle auf Informationen zu unterschiedlichen Protokollquellen.

<table><caption>Merkmale von Protokollquellen</caption>
  <thead>
    <tr>
      <th>Protokollquelle</th>
      <th>Merkmale</th>
      <th>Protokollpfade</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>container</code></td>
      <td>Protokolle für Ihren Container, der in einem Kubernetes-Cluster ausgeführt wird.</td>
      <td>Alles, was in STDOUT oder STDERR in Ihren Containern protokolliert wurde.</td>
    </tr>
    <tr>
      <td><code>application</code></td>
      <td>Protokolle für Ihre eigene Anwendung, die in einem Kubernetes-Cluster ausgeführt wird.</td>
      <td>Sie können die Pfade definieren.</td>
    </tr>
    <tr>
      <td><code>worker</code></td>
      <td>Protokolle für Workerknoten für virtuelle Maschinen in einem Kubernetes-Cluster.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>kubernetes</code></td>
      <td>Protokolle für die Kubernetes-Systemkomponente.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>ingress</code></td>
      <td>Protokolle für eine Ingress-Lastausgleichsfunktion für Anwendungen, die den eingehenden Netzverkehr für einen Cluster verwaltet.</td>
      <td><code>/var/log/alb/ids/&ast;.log</code>, <code>/var/log/alb/ids/&ast;.err</code>, <code>/var/log/alb/customerlogs/&ast;.log</code>, <code>/var/log/alb/customerlogs/&ast;.err</code></td>
    </tr>
  </tbody>
</table>

Wenn Sie die Protokollierung über die Benutzerschnittstelle konfigurieren, müssen Sie eine Organisation und einen Bereich angeben. Wenn Sie die Protokollierung auf Kontoebene aktivieren möchten, können Sie dies über die CLI tun.
{: tip}


### Vorbereitende Schritte

1. Überprüfen Sie die Berechtigungen. Wenn Sie beim Erstellen der Cluster oder der Protokollierungskonfiguration einen Bereich angegeben haben, dann benötigen sowohl der Kontoeigner als auch der {{site.data.keyword.containershort_notm}}-Schlüsseleigner Manager-, Entwickler- oder Auditor-Berechtigungen in diesem Bereich.
  * Wenn Sie wissen, wer {{site.data.keyword.containershort_notm}}-Schlüsseleigner ist, führen Sie den folgenden Befehl aus: 
      ```
      bx cs api-key-info <clustername>
      ```
      {: pre}
  * Um sofort alle Änderungen anzuwenden, die Sie an Ihren Berechtigungen vorgenommen haben, führen Sie den folgenden Befehl aus. 
      ```
      bx cs logging-config-refresh <clustername>
      ```
      {: pre}

  Informationen zum Ändern der Zugriffsrichtlinien und Berechtigungen für {{site.data.keyword.containershort_notm}} finden Sie in [Clusterzugriff verwalten](cs_users.html#managing).
  {: tip}

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

  Wenn Sie ein dediziertes Konto verwenden, müssen Sie sich beim öffentlichen {{site.data.keyword.cloud_notm}}-Endpunkt anmelden und als Ziel Ihre öffentliche Organisation und den Bereich angeben, um die Protokollweiterleitung zu ermöglichen. {: tip}

3. Sie haben zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann, um somit Protokolle an den Systemprotokollserver weiterzuleiten:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.
  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in einem Kubernetes-Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts.

### Protokollweiterleitung aktivieren

1. Erstellen Sie eine Konfiguration für die Protokollweiterleitung.
    * Für die Protokollweiterleitung an {{site.data.keyword.loganalysisshort_notm}}:
      ```
      bx cs logging-config-create <mein_cluster> --logsource <meine_protokollquelle> --namespace <kubernetes_namensbereich> --hostname <einpflege_URL> --port <einpflegeport> --space <clusterbereich> --org <clusterorganisation> --type ibm --app-containers <container> --app-paths <pfade_zu_protokollen>
      ```
      {: pre}

      ```
      $ cs logging-config-create zac2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'zac1,zac2,zac3'
      Creating logging configuration for application logs in cluster zac2...
      OK
      Id                                     Source        Namespace   Host                                    Port    Org   Space   Protocol   Application Containers   Paths
      aa2b415e-3158-48c9-94cf-f8b298a5ae39   application   -           ingest.logging.stage1.ng.bluemix.net✣   9091✣   -     -       ibm        zac1,zac2,zac3           /var/log/apps.log
      ```
      {: screen}

    * Gehen Sie wie folgt vor, um Protokolle an den Systemprotokollserver weiterzuleiten:
      ```
      bx cs logging-config-create <mein_cluster> --logsource <meine_protokollquelle> --namespace <kubernetes_namensbereich> --hostname <hostname_oder_ip_des_protokollservers> --port <protokollserver-port> --type syslog --app-containers <container> --app-paths <pfade_zu_protokollen>
      ```
      {: pre}

  <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;mein_cluster&gt;</em></code></td>
      <td>Der Name oder die ID des Clusters.</td>
    </tr>
    <tr>
      <td><code><em>&lt;meine_protokollquelle&gt;</em></code></td>
      <td>Die Quelle, von der die Protokolle weitergeleitet werden sollen. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>.</td>
    </tr>
    <tr>
      <td><code><em>&lt;kubernetes-namensbereich&gt;</em></code></td>
      <td>Optional: Der Kubernetes-Namensbereich, von dem aus Sie Protokolle weiterleiten möchten. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Protokollquelle <code>container</code> gültig. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Cluster diese Konfiguration.</td>
    </tr>
    <tr>
      <td><code><em>&lt;einpflege_URL&gt;</em></code></td>
      <td><p>Verwenden Sie für {{site.data.keyword.loganalysisshort_notm}} die [einpflege_URL](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</p>
      <p>Geben Sie für das Systemprotokoll den Hostnamen oder die IP-Adresse des Protokollcollector-Service an. </p></td>
    </tr>
    <tr>
      <td><code><em>&lt;port&gt;</em></code></td>
      <td>Der Einpflegeport. Wenn Sie keinen Port angeben, wird der Standardport <code>9091</code> verwendet.
      <p>Geben Sie für das Systemprotokoll den Port des Protokollcollector-Servers an. Wenn Sie keinen Port angeben, dann wird der Standardport <code>514</code> verwendet.</td>
    </tr>
    <tr>
      <td><code><em>&lt;clusterbereich&gt;</em></code></td>
      <td>Optional: Der Name des Cloud Foundry-Bereichs, an den Sie die Protokolle senden möchten. Wenn Sie Protokolle an {{site.data.keyword.loganalysisshort_notm}} senden, werden Bereich und Organisation im Einpflegepunkt angegeben. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet.</td>
    </tr>
    <tr>
      <td><code><em>&lt;clusterorganisation&gt;</em></code></td>
      <td>Der Name der Cloud Foundry-Organisation, in der sich der Bereich befindet. Dieser Wert ist erforderlich, wenn Sie einen Bereich angegeben haben.</td>
    </tr>
    <tr>
      <td><code><em>&lt;typ&gt;</em></code></td>
      <td>Gibt an, wohin Sie Ihre Protokolle weiterleiten möchten. Optionen sind <code>ibm</code>, wodurch Ihre Protokolle an {{site.data.keyword.loganalysisshort_notm}} weitergeleitet werden, und <code>syslog</code>, wodurch Ihre Protokolle an externe Server weitergeleitet werden. </td>
    </tr>
    <tr>
      <td><code><em>&lt;pfade_zu_protokollen&gt;</em></code></td>
      <td>Der Pfad zu den Containern, an die die Apps Protokolle senden. Wenn Sie Protokolle mit dem Quellentyp <code>application</code> weiterleiten möchten, müssen Sie einen Pfad angeben. Wenn Sie mehr als einen Pfad angeben, verwenden Sie eine durch Kommas getrennte Liste. Beispiel: <code>/var/log/myApp1/*/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>&lt;container&gt;</em></code></td>
      <td>Optional: Wenn Sie Protokolle von Apps weiterleiten, können Sie den Namen des Containers angeben, der Ihre App enthält. Sie können mehr als einen Container angeben, indem Sie eine durch Kommas getrennte Liste verwenden. Falls keine Container angegeben sind, werden Protokolle von allen Containern weitergeleitet, die die von Ihnen bereitgestellten Pfade enthalten. </td>
    </tr>
  </tbody>
  </table>

2. Überprüfen Sie, dass Ihre Konfiguration korrekt ist. Dazu haben Sie zwei Möglichkeiten:

    * Gehen Sie wie folgt vor, um eine Liste aller Protokollierungskonfigurationen im Cluster anzuzeigen: 
      ```
      bx cs logging-config-get <mein_cluster>
      ```
      {: pre}

      Beispielausgabe:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   meine_org   mein_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   mein_namensbereich  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Gehen Sie wie folgt vor, um die Protokollierungskonfiguration für einen Protokollquellentyp aufzulisten: 
      ```
      bx cs logging-config-get <mein_cluster> --logsource worker
      ```
      {: pre}

      Beispielausgabe:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

Befolgen Sie dieselben Schritte, um Ihre Konfiguration zu aktualisieren. Ersetzen Sie jedoch `bx cs logging-config-create` durch `bx cs logging-config-update`. Stellen Sie sicher, dass Sie Ihre Aktualisierung überprüfen.
{: tip}

<br />


## Protokolle anzeigen
{: #view_logs}

Zum Anzeigen von Protokollen für Cluster und Container können Sie die Standardprotokollierungsfunktionen von Kubernetes und Docker verwenden.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Sie können die Protokolle anzeigen, die Sie über das Kibana-Dashboard an {{site.data.keyword.loganalysislong_notm}} weitergeleitet haben.
{: shortdesc}

Wenn Sie die Standardwerte zum Erstellen Ihrer Konfigurationsdatei verwenden, können Ihre Protokolle im Konto oder in der Organisation und im Bereich gefunden werden, in dem der Cluster erstellt wurde. Wenn Sie eine Organisation und einen Bereich in Ihrer Konfigurationsdatei angegeben haben, können Sie Ihre Protokolle in diesem Bereich finden. Weitere Informationen zur Protokollierung finden Sie unter [Protokollierung für {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

Zum Zugriff auf das Kibana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.
- Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://logging.ng.bluemix.net
- Großbritannien (Süden): https://logging.eu-gb.bluemix.net
- Zentraleuropa: https://logging.eu-fra.bluemix.net
- Asiatisch-pazifischer Raum (Süden): https://logging.au-syd.bluemix.net

Weitere Informationen zum Anzeigen von Protokollen finden Sie im Abschnitt zum [Navigieren zu Kibana über einen Web-Browser](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Docker-Protokolle
{: #view_logs_docker}

Sie können die in Docker integrierten Protokollierungsfunktion nutzen, um Aktivitäten in den Standardausgabedatenströmen STDOUT und STDERR zu prüfen. Weitere Informationen finden Sie unter [Container-Protokolle für einen Container anzeigen, der in einem Kubernetes-Cluster ausgeführt wird](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Protokollweiterleitung stoppen
{: #log_sources_delete}

Sie können die Weiterleitung von einem oder allen Protokollen der Protokollierungskonfiguration eines Clusters stoppen.
{: shortdesc}

1. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

2. Löschen Sie die Protokollierungskonfiguration.
<ul>
<li>Gehen Sie wie folgt vor, um eine Protokollierungskonfiguration zu löschen: </br>
  <pre><code>bx cs logging-config-rm &lt;mein_cluster&gt; --id &lt;log_config_id&gt;</pre></code>
  <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
      </thead>
        <tbody>
        <tr>
          <td><code><em>&lt;mein_cluster&gt;</em></code></td>
          <td>Der Name des Clusters, in dem sich die Protokollierungskonfiguration befindet.</td>
        </tr>
        <tr>
          <td><code><em>&lt;protokollkonfiguration-id&gt;</em></code></td>
          <td>Die ID der Protokollquellenkonfiguration.</td>
        </tr>
        </tbody>
  </table></li>
<li>Gehen Sie wie folgt vor, um alle Protokollierungskonfigurationen zu löschen. </br>
  <pre><code>bx cs logging-config-rm <mein_cluster> --all</pre></code></li>
</ul>

<br />


## Protokollweiterleitung für Kubernetes-API-Auditprotokolle konfigurieren
{: #app_forward}

Sie können einen Webhook über den API-Server von Kubernetes API konfigurieren, um alle Aufrufe von Ihrem Cluster zu erfassen. Mit einem aktivierten Webhook können Protokolle an einen fernen Server gesendet werden.
{: shortdesc}

Weitere Informationen zu Kubernetes-Auditprotokollen finden Sie im Thema zu <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">Audits <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> in der Kubernetes-Dokumentation.

* Die Weiterleitung für Kubernetes-API-Auditprotokolle wird nur in Kubernetes Version 1.7 und höher unterstützt.
* Aktuell wird eine Standardauditrichtlinie für alle Cluster mit dieser Protokollierungskonfiguration verwendet.
* Auditprotokolle können nur an einen externen Server weitergeleitet werden.
{: tip}

### Kubernetes-API-Auditprotokollweiterleitung aktivieren
{: #audit_enable}

Vorbemerkungen:

1. Richten Sie einen fernen Protokollierungsserver ein, an den Sie die Protokolle weiterleiten können. Beispiel: Sie können [Logstash mit Kubernetes verwenden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend), um Auditereignisse zu erfassen.

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem Sie API-Serverauditprotokolle erfassen möchten. **Hinweis**: Wenn Sie ein dediziertes Konto verwenden, müssen Sie sich beim öffentlichen {{site.data.keyword.cloud_notm}}-Endpunkt anmelden und als Ziel Ihre öffentliche Organisation und den Bereich angeben, um die Protokollweiterleitung zu ermöglichen. 

Um Kubernetes-API-Auditprotokolle weiterzuleiten, gehen Sie wie folgt vor:

1. Webhook konfigurieren. Wenn Sie keine Informationen in den Flags bereitstellen, wird eine Standardkonfiguration verwendet. 

    ```
    bx cs apiserver-config-set audit-webhook <mein_cluster> --remoteServer <server-URL_oder_IP> --caCert <pfad_des_zertifizierungsstellenzertifikats> --clientCert <pfad_des_clientzertifikats> --clientKey <pfad_des_clientschlüssels>
    ```
    {: pre}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Der Name oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code><em>&lt;server-URL&gt;</em></code></td>
    <td>Die URL oder IP-Adresse für den fernen Protokollierungsservice, an den Sie die Protokolle senden möchten. Zertifikate werden ignoriert, wenn Sie eine nicht sichere Server-URL angeben.</td>
    </tr>
    <tr>
    <td><code><em>&lt;pfad_des_zertifizierungsstellenzertifikats&gt;</em></code></td>
    <td>Der Dateipfad für das CA-Zertifikat, das zum Überprüfen des fernen Protokollierungsservice verwendet wird. </td>
    </tr>
    <tr>
    <td><code><em>&lt;pfad_des_clientzertifikats&gt;</em></code></td>
    <td>Der Dateipfad des Clientzertifikats, das zum Authentifizieren beim fernen Protokollierungsservice verwendet wird. </td>
    </tr>
    <tr>
    <td><code><em>&lt;pfad_des_clientschlüssels&gt;</em></code></td>
    <td>Der Dateipfad für den entsprechenden Clientschlüssel, der zum Verbinden mit dem fernen Protokollierungsservice verwendet wird. </td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, dass die Protokollweiterleitung aktiviert war, indem Sie die URL für den fernen Protokollierungsservice anzeigen.

    ```
    bx cs apiserver-config-get audit-webhook <mein_cluster>
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
    bx cs apiserver-refresh <mein_cluster>
    ```
    {: pre}

### Kubernetes-API-Auditprotokollweiterleitung stoppen
{: #audit_delete}

Sie können das Weiterleiten von Auditprotokollen stoppen, indem Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters inaktivieren.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem Sie die Erfassung von API-Serverauditprotokollen stoppen möchten.

1. Inaktivieren Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters.

    ```
    bx cs apiserver-config-unset audit-webhook <mein_cluster>
    ```
    {: pre}

2. Wenden Sie die Konfigurationsaktualisierung an, indem Sie den Kubernetes-Master erneut starten.

    ```
    bx cs apiserver-refresh <mein_cluster>
    ```
    {: pre}

<br />


## Clusterüberwachung konfigurieren
{: #monitoring}

Mit Metriken können Sie den Zustand und die Leistung Ihrer Cluster überwachen. Sie können die Zustandsüberwachung für Workerknoten so konfigurieren, dass Worker automatisch erkannt und korrigiert werden, die einen verminderten oder nicht betriebsbereiten Status aufweisen. **Hinweis**: Die Überwachung wird nur für Standardcluster unterstützt.
{:shortdesc}

## Metriken anzeigen
{: #view_metrics}

Sie können die Standardfeatures von Kubernetes und Docker verwenden, um den Zustand Ihrer Cluster und Apps zu überwachen.
{:shortdesc}

<dl>
  <dt>Seite mit Clusterdetails in {{site.data.keyword.Bluemix_notm}}</dt>
    <dd>{{site.data.keyword.containershort_notm}} stellt Information zum Zustand und zur Kapazität Ihres Clusters sowie zur Nutzung Ihrer Clusterressourcen bereit. Über diese grafische Benutzerschnittstelle (GUI) können Sie Ihren Cluster horizontal skalieren, mit dem persistenten Speicher arbeiten und weitere Funktionalität durch Binden von {{site.data.keyword.Bluemix_notm}}-Services zu Ihrem Cluster hinzufügen. Um die Seite mit Clusterdetails anzuzeigen, wählen Sie im **{{site.data.keyword.Bluemix_notm}}-Dashboard** einen Cluster aus.</dd>
  <dt>Kubernetes-Dashboard</dt>
    <dd>Das Kubernetes-Dashboard ist eine Webschnittstelle für die Verwaltung, über die Sie den Zustand Ihrer Workerknoten überprüfen, Kubernetes-Ressourcen suchen, containerisierte Apps bereitstellen und Fehler bei Apps mithilfe von Protokollierungs- und Überwachungsdaten suchen und beheben können. Weitere Informationen dazu, wie Sie auf das Kubernetes-Dashboard zugreifen, finden Sie unter [Kubernetes-Dashboard für {{site.data.keyword.containershort_notm}} starten](cs_app.html#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd>Metriken für Standardcluster befinden sich in dem {{site.data.keyword.Bluemix_notm}}-Konto, das angemeldet war, als der Kubernetes-Cluster erstellt wurde. Wenn Sie beim Erstellen des Clusters einen {{site.data.keyword.Bluemix_notm}}-Bereich angegeben haben, befinden sich die Metriken in diesem Bereich. Containermetriken werden automatisch für alle Container erfasst, die in einem Cluster bereitgestellt werden. Diese Metriken werden durch Grafana gesendet und verfügbar gemacht. Weitere Informationen zu Metriken finden Sie unter [Überwachung für {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Zum Zugriff auf das Grafana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.<ul><li>Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://metrics.ng.bluemix.net</li><li>Großbritannien (Süden): https://metrics.eu-gb.bluemix.net</li><li>Zentraleuropa: https://metrics.eu-de.bluemix.net</li></ul></p></dd>
</dl>

### Weitere Zustandsüberwachungstools
{: #health_tools}

Sie können weitere Tools für zusätzliche Überwachungsfunktionen konfigurieren.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus ist ein Open-Source-Tool für die Überwachung, Protokollierung und Benachrichtigung bei Alerts, das für Kubernetes entwickelt wurde. Das Tool ruft auf Grundlage der Kubernetes-Protokollierungsinformationen detaillierte Informationen zu Cluster, Workerknoten und Bereitstellungszustand ab. Weitere Informationen zur Einrichtung finden Sie unter [Services mit {{site.data.keyword.containershort_notm}} integrieren](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Zustandsüberwachung für Workerknoten mit automatischer Wiederherstellung konfigurieren
{: #autorecovery}

Das System für die automatische Wiederherstellung von {{site.data.keyword.containerlong_notm}} kann in vorhandenen Clustern ab Kubernetes Version 1.7 bereitgestellt werden.
{: shortdesc}

Das System verwendet verschiedene Prüfungen zum Abfragen des allgemeinen Zustands von Workerknoten. Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Diese Korrekturmaßnahme wird immer nur für einen Workerknoten ausgeführt. Die Korrekturmaßnahme muss für diesen Workerknoten erfolgreich abgeschlossen werden, bevor für einen weiteren Workerknoten eine Korrekturmaßnahme durchgeführt werden kann. Weitere Informationen finden Sie in diesem [Blogbeitrag zur automatischen Wiederherstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**HINWEIS**: Für die automatische Wiederherstellung ist es erforderlich, dass mindestens ein ordnungsgemäß funktionierender Workerknoten vorhanden ist. Konfigurieren Sie die automatische Wiederherstellung mit aktiven Prüfungen nur in Clustern mit mindestens zwei Workerknoten.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem die Zustandsprüfung für die Workerknoten durchgeführt werden soll.

1. Erstellen Sie eine Konfigurationszuordnungsdatei, mit der die Prüfungen im JSON-Format definiert werden. In der folgenden YAML-Datei sind beispielsweise drei Prüfungen angegeben: eine HTTP-Prüfung und zwei Kubernetes-API-Serverprüfungen.</br>
   **Tipp:** Definieren Sie jede Prüfung als eindeutigen Schlüssel im Datenabschnitt der Konfigurationszuordnung (ConfigMap). 

   ```
   kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
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
   <td><code>checkhttp.json</code></td>
   <td>Definiert eine HTTP-Prüfung, die von einem HTTP-Server für die IP-Adresse jedes Knotens an Port 80 durchgeführt wird, und gibt die Antwort 200 im Pfad <code>/myhealth</code> zurück. Die IP-Adresse eines Knotens kann durch Ausführen des Befehls <code>kubectl get nodes</code> ermittelt werden.
Beispiel: Angenommen, ein Cluster enthält zwei Knoten mit den IP-Adressen 10.10.10.1 und 10.10.10.2. In diesem Beispiel werden zwei Routen hinsichtlich einer Antwort 200 für OK geprüft: <code>http://10.10.10.1:80/myhealth</code> und <code>http://10.10.10.2:80/myhealth</code>.
Die Prüfung in der YAML-Beispieldatei wird alle 3 Minuten durchgeführt. Schlägt die Prüfung drei Mal hintereinander fehl, wird der Knoten neu gestartet. Diese Aktion ist äquivalent zur Ausführung des Befehls <code>bx cs worker-reboot</code>. Die HTTP-Prüfung wird erst dann aktiviert, wenn Sie das Feld <b>Enabled</b> auf den Wert <code>true</code> setzen.      </td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Definiert eine Kubernetes-API-Knotenprüfung, mit der ermittelt wird, ob sich jeder Knoten im Bereitstatus (<code>Ready</code>) befindet. Die Prüfung eines bestimmten Knotens wird als Fehler gezählt, wenn sich der betreffende Knoten nicht im Status <code>Ready</code> befindet.
Die Prüfung in der YAML-Beispieldatei wird alle 3 Minuten durchgeführt. Schlägt die Prüfung drei Mal hintereinander fehl, wird der Knoten neu geladen. Diese Aktion ist äquivalent zur Ausführung des Befehls <code>bx cs worker-reload</code>. Die Knotenprüfung bleibt so lange aktiviert, bis Sie das Feld <b>Enabled</b> auf den Wert <code>false</code> setzen oder die Prüfung entfernen.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>Definiert eine Kubernetes-API-Podprüfung, mit der auf Basis der Gesamtzahl der einem Knoten zugeordneten Pods ermittelt wird, welcher prozentuale Anteil der Pods in dem betreffenden Knoten insgesamt den Status <code>NotReady</code> (nicht bereit) aufweist. Die Prüfung eines bestimmten Knotens wird als Fehler gezählt, wenn der Gesamtprozentsatz der Pods im Status <code>NotReady</code> größer ist als der für <code>PodFailureThresholdPercent</code> festgelegte Wert.
Die Prüfung in der YAML-Beispieldatei wird alle 3 Minuten durchgeführt. Schlägt die Prüfung drei Mal hintereinander fehl, wird der Knoten neu geladen. Diese Aktion ist äquivalent zur Ausführung des Befehls <code>bx cs worker-reload</code>. Die Podprüfung bleibt so lange aktiviert, bis Sie das Feld <b>Enabled</b> auf den Wert <code>false</code> setzen oder die Prüfung entfernen.</td>
   </tr>
   </tbody>
   </table>


   <table summary="Erklärung der einzelnen Regelkomponenten">
   <caption>Erklärung der Komponenten einzelner Regeln</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/>Erklärung der einzelnen Regelkomponenten</th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Geben Sie die Art der Prüfung an, die im Rahmen der automatischen Wiederherstellung verwendet werden soll. <ul><li><code>HTTP</code>: Bei der automatischen Wiederherstellung werden HTTP-Server aufgerufen, die auf den einzelnen Knoten aktiv sind, um zu ermitteln, ob die Knoten ordnungsgemäß ausgeführt werden.</li><li><code>KUBEAPI</code>: Bei der automatischen Wiederherstellung wird der Kubernetes-API-Server aufgerufen und die Daten zum Allgemeinzustand gelesen, die von den Workerknoten gemeldet werden.</li></ul></td>
   </tr>
   <tr>
   <td><code>Ressource</code></td>
   <td>Wenn der Prüfungstyp <code>KUBEAPI</code> lautet, geben Sie den Ressourcentyp an, der im Rahmen der automatischen Wiederherstellung geprüft werden soll. Gültige Werte sind <code>NODE</code> oder <code>PODS</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Geben Sie den Schwellenwert für die Anzahl der Prüfungen ein, die nacheinander fehlgeschlagen sind. Wenn dieser Schwellenwert erreicht wird, löst die automatische Wiederherstellung die angegebene Korrekturmaßnahme aus. Wenn beispielsweise der Schwellenwert '3' lautet und im Rahmen der automatischen Wiederherstellung dreimal in Folge eine konfigurierte Prüfung fehlschlägt, wird die der Prüfung zugeordnete Korrekturmaßnahme ausgelöst.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>Wenn der Ressourcentyp <code>PODS</code> lautet, geben Sie den Schwellenwert für den Prozentsatz der Pods auf einem Workerknoten an, die den Zustand ['NotReady' ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) aufweisen können. Dieser Prozentsatz basiert auf der Gesamtanzahl an Pods, die auf einem Workerknoten geplant sind. Wenn durch eine Prüfung festgestellt wird, dass der Prozentsatz nicht ordnungsgemäß funktionierender Pods größer ist als der Schwellenwert, zählt die Prüfung als ein Fehler.</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>Geben Sie die Aktion ein, die ausgeführt werden soll, wenn der Fehlerschwellenwert erreicht wird. Eine Korrekturmaßnahme wird nur ausgeführt, während keine weiteren Worker repariert werden und wenn dieser Workerknoten sich nicht in einer 'Erholungsphase' von einer vorherigen Aktion befindet. <ul><li><code>REBOOT</code>: Startet den Workerknoten neu.</li><li><code>RELOAD</code>: Lädt alle erforderlichen Konfigurationen für den Workerknoten erneut von einem bereinigten Betriebssystem.</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>Geben Sie die Anzahl der Sekunden an, die die automatische Wiederherstellung warten muss, bis eine weitere Korrekturmaßnahme für einen Knoten abgesetzt werden kann, für den bereits eine Korrekturmaßnahme ausgelöst wurde. Dieser Zeitraum (Cooloff) beginnt zu dem Zeitpunkt, an dem die Korrekturmaßnahme eingeleitet wird. </td>
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
   <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben Sie den Port ein, an den der HTTP-Server auf dem Workerknoten gebunden werden muss. Dieser Port muss an der IP jedes Workerknotens im Cluster zugänglich sein. Bei der automatischen Wiederherstellung ist für die Prüfung von Servern eine konstante Portnummer auf allen Knoten erforderlich. Verwenden Sie [DaemonSets ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) bei der Bereitstellung eines angepassten Servers in einem Cluster.</td>
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
   </tbody>
   </table>

2. Erstellen Sie die Konfigurationszuordnung in Ihrem Cluster.

    ```
    kubectl apply -f <meine_datei.yaml>
    ```
    {: pre}

3. Stellen Sie sicher, dass Sie die Konfigurationszuordnung mit dem Namen `ibm-worker-recovery-checks` im Namensbereich `kube-system` mit den richtigen Prüfungen erstellt haben.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Stellen Sie die automatische Wiederherstellung in Ihrem Cluster durch das Anwenden der folgenden YAML-Datei bereit.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. Nach einigen Minuten können Sie den Abschnitt `Events` in der Ausgabe des folgenden Befehls auf mögliche Aktivitäten bei der Bereitstellung der automatischen Wiederherstellung überprüfen.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
