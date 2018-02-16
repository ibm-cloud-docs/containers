---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

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

Das Konfigurieren der Clusterprotokollierung und -überwachung dient zur Unterstützung bei der Behebung von Problemen mit Clustern und Apps sowie bei der Überwachung des Status und der Leistung von Clustern.
{:shortdesc}

## Clusterprotokollierung konfigurieren
{: #logging}

Sie können Protokolle zwecks Verarbeitung oder Langzeitspeicherung an eine bestimmte Position senden. In einem Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} können Sie die Protokollweiterleitung für Ihren Cluster aktivieren und auswählen, wohin die Protokolle weitergeleitet werden sollen. **Hinweis**: Die Protokollweiterleitung wird nur für Standardcluster unterstützt.
{:shortdesc}

Sie können Protokolle für andere Protokollquellen, wie Container, Anwendungen, Workerknoten, Kubernetes-Cluster und Ingress-Controller, weiterleiten. Nachfolgend finden Sie eine Tabelle mit den entsprechenden Informationen zu jeder Protokollquelle.

|Protokollquelle|Merkmale|Protokollpfade|
|----------|---------------|-----|
|`container`|Protokolle für Ihren Container, der in einem Kubernetes-Cluster ausgeführt wird.|-|
|`application`|Protokolle für Ihre eigene Anwendung, die in einem Kubernetes-Cluster ausgeführt wird.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Protokolle für Workerknoten für virtuelle Maschinen in einem Kubernetes-Cluster.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Protokolle für die Kubernetes-Systemkomponente.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Protokolle für eine Lastausgleichsfunktion für Anwendungen, die vom Ingress-Controller verwaltet wird, der den aus einem Kubernetes-Cluster kommenden Datenverkehr verwaltet.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Merkmale von Protokollquellen" caption-side="top"}

## Protokollweiterleitung aktivieren
{: #log_sources_enable}

Sie können Protokolle an {{site.data.keyword.loganalysislong_notm}} oder einen externen Systemprotokollserver weiterleiten. Wenn Sie Protokolle aus einer Protokollquelle an beide Protokollcollector-Server weiterleiten möchten, müssen Sie zwei Protokollierungskonfigurationen erstellen. **Hinweis**: Weitere Informationen zum Weiterleiten von Protokollen für Anwendungen finden Sie unter [Protokollweiterleitung für Anwendungen aktivieren](#apps_enable).
{:shortdesc}

Vorbemerkungen:

1. Wenn Sie Protokolle an einen externen Systemprotokollserver weiterleiten möchten, haben Sie zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.
  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in einem Kubernetes-Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts.

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

Gehen Sie wie folgt vor, um Protokollweiterleitung für einen Container, einen Workerknoten, eine Kubernetes-Systemkomponente, eine Anwendung oder eine Ingress-Lastausgleichsfunktion für Anwendungen zu aktivieren:

1. Erstellen Sie eine Konfiguration für die Protokollweiterleitung.

  * Für die Protokollweiterleitung an {{site.data.keyword.loganalysislong_notm}}:

    ```
    bx cs logging-config-create <mein_cluster> --logsource <meine_protokollquelle> --namespace <kubernetes-namensbereich> --hostname <einpflege-url> --port <einpflegeport> --space <clusterbereich> --org <clusterorganisation> --type ibm
    ```
    {: pre}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Der Befehl zum Erstellen einer {{site.data.keyword.loganalysislong_notm}}-Protokollweiterleitungskonfiguration.</td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;meine_protokollquelle&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;meine_protokollquelle&gt;</em> durch die Protokollquelle. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;kubernetes-namensbereich&gt;</em> durch den Kubernetes-Namensbereich, von dem aus Sie Protokolle weiterleiten wollen. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Containerprotokollquelle gültig und optional. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Cluster diese Konfiguration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;einpflege-URL&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;einpflege-URL&gt;</em> durch die {{site.data.keyword.loganalysisshort_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;einpflegeport&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;einpflegeport&gt;</em> durch den Einpflegeport. Wenn Sie keinen Port angeben, wird der Standardport <code>9091</code> verwendet.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;clusterbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterbereich&gt;</em> durch den Namen des Cloud Foundry-Bereichs, an den Sie Protokolle senden möchten. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;clusterorganisation&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterorganisation&gt;</em> durch den Namen der Cloud Foundry-Organisation, in der sich der Bereich befindet. Dieser Wert ist erforderlich, wenn Sie einen Bereich angegeben haben.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>Der Protokolltyp für das Senden von Protokollen an {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Für die Protokollweiterleitung an einen externen Systemprotokollserver:

    ```
    bx cs logging-config-create <mein_cluster> --logsource <meine_protokollquelle> --namespace <kubernetes-namensbereich> --hostname <hostname_oder_ip_des_protokollservers> --port <protokollserver-port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Der Befehl zum Erstellen einer syslog-Protokollweiterleitungskonfiguration.</td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;meine_protokollquelle&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;meine_protokollquelle&gt;</em> durch die Protokollquelle. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;kubernetes-namensbereich&gt;</em> durch den Kubernetes-Namensbereich, von dem aus Sie Protokolle weiterleiten wollen. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Containerprotokollquelle gültig und optional. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Cluster diese Konfiguration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;hostname_oder_ip_des_protokollservers&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollserver-hostname&gt;</em> durch den Hostnamen oder die IP-Adresse des Protokollcollector-Service.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;protokollserver-port&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollserver-port&gt;</em> durch den Port des Protokollcollector-Servers. Wenn Sie keinen Port angeben, dann wird der Standardport <code>514</code> verwendet.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Der Protokolltyp zum Senden von Protokollen an einen externen Systemprotokollserver.</td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, ob die Protokollweiterleitungskonfiguration erstellt wurde.

    * Gehen Sie wie folgt vor, um alle Protokollierungskonfigurationen im Cluster aufzulisten:
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

    * Gehen Sie wie folgt vor, um Protokollierungskonfigurationen für einen Protokollquellentyp aufzulisten:
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


### Protokollweiterleitung für Anwendungen aktivieren
{: #apps_enable}

Protokolle von Anwendungen müssen auf ein bestimmtes Verzeichnis auf dem Hostknoten beschränkt sein. Dazu hängen Sie einen Datenträger mit Hostpfaden mithilfe eines Mountpfads per Mountoperation an Ihre Container an. Dieser Mountpfad dient als Verzeichnis in Ihren Containern, an das die Anwendungsprotokolle gesendet werden. Das vordefinierte Hostpfadverzeichnis `/var/log/apps` wird automatisch beim Generieren des Datenträgermounts erstellt.

Nachfolgend finden Sie noch einmal die wichtigsten Aspekte der Protokollweiterleitung für Anwendungen:
* Protokolle werden rekursiv aus dem Pfad '/var/log/apps' gelesen. Dies bedeutet, dass Sie Anwendungsprotokolle in Unterverzeichnissen des Pfads '/var/log/apps' ablegen können.
* Nur Anwendungsprotokolldateien mit der Erweiterung `.log` oder `.err` werden weitergeleitet.
* Wenn Sie die Protokollweiterleitung zum ersten Mal aktivieren, werden für Anwendungsprotokolle 'tail'-Aufrufe durchgeführt, anstatt dass sie aus dem Kopfsatz ausgelesen werden. Dies bedeutet, dass die Inhalte von Protokollen, die bereits vor der Aktivierung der Anwendungsprotokolle vorhanden sind, nicht gelesen werden. Die Protokolle werden ab dem Zeitpunkt der Aktivierung der Protokollierung gelesen. Nach der erstmaligen Aktivierung der Protokollweiterleitung werden Protokolle jedoch immer von der Stelle ab weiterverarbeitet, an der sie zuletzt verarbeitet wurden.
* Wenn Sie den Datenträger für den Hostpfad `/var/log/apps` per Mountoperation an Container anhängen, schreiben die Container alle in dasselbe Verzeichnis. Dies bedeutet, dass, wenn die Container ihre Schreiboperationen alle an denselben Dateinamen richten, die Container in exakt dieselbe Datei auf dem Host schreiben. Wenn Sie dies nicht möchten, können Sie verhindern, dass die Container dieselbe Protokolldatei überschreiben, indem Sie den Protokolldateien von den einzelnen Containern unterschiedliche Namen geben.
* Da alle Container an denselben Dateinamen schreiben, verwenden Sie diese Methode nicht zum Weiterleiten von Anwendungsprotokollen für Replikatgruppen. Stattdessen können Sie Protokolle von der Anwendung in STDOUT und STDERR schreiben, die als Containerprotokolle erfasst werden. Um Anwendungsprotokolle, die in STDOUT und STDERR geschrieben wurden, weiterzuleiten, führen Sie die Schritte im Abschnitt [Protokollweiterleitung ans Systemprotokoll aktivieren](cs_health.html#log_sources_enable) aus.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

1. Öffnen Sie die Konfigurationsdatei mit der Erweiterung `.yaml` für den Pod der Anwendung.

2. Fügen Sie der Konfigurationsdatei die folgenden Angaben für `volumeMounts` und `volumes` hinzu:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <podname>
    containers:
    - name: fluentd
      image: "<ihr_registry-image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Hängen Sie den Datenträger über eine Mountoperation an den Pod an.

    ```
    kubectl apply -f <lokaler_yaml-pfad>
    ```
    {:pre}

3. Zum Erstellen einer Protokollweiterleitungskonfiguration führen Sie die Schritte im Abschnitt [Protokollweiterleitung aktivieren](cs_health.html#log_sources_enable) aus.

<br />


## Protokollweiterleitungskonfiguration aktualisieren
{: #log_sources_update}

Sie können Protokollweiterleitung für einen Container, eine Anwendung, einen Workerknoten, eine Kubernetes-Systemkomponente oder eine Ingress-Lastausgleichsfunktion für Anwendungen aktualisieren.
{: shortdesc}

Vorbemerkungen:

1. Wenn Sie den Protokollcollector-Server in einen Systemprotokollserver (syslog) ändern, haben Sie zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.
  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in einem Kubernetes-Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts.

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

Gehen Sie wie folgt vor, um die Details der Protokollierungskonfiguration zu ändern:

1. Aktualisieren Sie die Protokollierungskonfiguration.

    ```
    bx cs logging-config-update <mein_cluster> --id <protokollkonfigurations-id> --logsource <meine_protokollquelle> --hostname <protokollserver-hostname_oder_-ip> --port <protokollserver-port> --space <clusterbereich> --org <clusterorganisation> --type <protokollierungstyp>
    ```
    {: pre}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Der Befehl zum Aktualisieren der Protokollweiterleitungskonfiguration für Ihre Protokollquelle.</td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;protokollkonfigurations-id&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollkonfigurations-id&gt;</em> durch die ID der Protokollquellenkonfiguration.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;meine_protokollquelle&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;meine_protokollquelle&gt;</em> durch die Protokollquelle. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;protokollserver-hostname_oder_-ip&gt;</em></code></td>
    <td>Wenn der Protokollierungstyp <code>syslog</code> lautet, ersetzen Sie <em>&lt;protokollserver-hostname_oder_-ip&gt;</em> durch den Hostnamen oder die IP-Adresse des Protokollcollector-Service. Wenn der Protokollierungstyp <code>ibm</code> lautet, ersetzen Sie <em>&lt;protokollserver-hostname&gt;</em> durch die {{site.data.keyword.loganalysislong_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;protokollserver-port&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollserver-port&gt;</em> durch den Port des Protokollcollector-Servers. Wenn Sie keinen Port angeben, wird der Standardport <code>514</code> für <code>syslog</code> und <code>9091</code> für <code>ibm</code> verwendet.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;clusterbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterbereich&gt;</em> durch den Namen des Cloud Foundry-Bereichs, an den Sie Protokolle senden möchten. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und optional. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;clusterorganisation&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterorganisation&gt;</em> durch den Namen der Cloud Foundry-Organisation, in der sich der Bereich befindet. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und erforderlich, wenn Sie einen Bereich angegeben haben.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;protokollierungstyp&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollierungstyp&gt;</em> durch das neue Protokollweiterleitungsprotokoll, das Sie verwenden möchten. Momentan werden <code>syslog</code> und <code>ibm</code> unterstützt.</td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, ob die Protokollweiterleitungskonfiguration aktualisiert wurde.

    * Gehen Sie wie folgt vor, um alle Protokollierungskonfigurationen im Cluster aufzulisten:

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

    * Gehen Sie wie folgt vor, um Protokollierungskonfigurationen für einen Protokollquellentyp aufzulisten:

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

<br />


## Protokollweiterleitung stoppen
{: #log_sources_delete}

Sie können die Weiterleitung von Protokollen stoppen, indem Sie die Protokollierungskonfiguration löschen.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

1. Löschen Sie die Protokollierungskonfiguration.

    ```
    bx cs logging-config-rm <mein_cluster> --id <protokollkonfigurations-id>
    ```
    {: pre}
    Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen des Clusters, in dem sich die Protokollierungskonfiguration befindet, und <em>&lt;protokollkonfigurations-id&gt;</em> durch die ID der Protokollquellenkonfiguration.

<br />


## Protokollweiterleitung für Kubernetes-API-Auditprotokolle konfigurieren
{: #app_forward}

Kubernetes-API-Auditprotokolle erfassen alle Aufrufe an den Kubernetes-API-Server von Ihrem Cluster. Starten Sie das Erfassen von Kubernetes-API-Auditprotokollen, indem Sie den Kubernetes-API-Server für die Einrichtung eines Webhook-Back-Ends für Ihren Cluster konfigurieren. Dieses Webhook-Back-End ermöglicht, dass Protokolle an einen fernen Server gesendet werden. Weitere Informationen zu Kubernetes-Auditprotokollen finden Sie im Thema zu <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">Audits <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> in der Kubernetes-Dokumentation.

**Hinweis**:
* Die Weiterleitung für Kubernetes-API-Auditprotokolle wird nur in Kubernetes Version 1.7 und höher unterstützt.
* Aktuell wird eine Standardauditrichtlinie für alle Cluster mit dieser Protokollierungskonfiguration verwendet.

### Kubernetes-API-Auditprotokollweiterleitung aktivieren
{: #audit_enable}

Vorbemerkungen:

1. Richten Sie einen fernen Protokollierungsserver ein, an den Sie die Protokolle weiterleiten können. Beispiel: Sie können [Logstash mit Kubernetes verwenden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend), um Auditereignisse zu erfassen.

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem Sie API-Serverauditprotokolle erfassen möchten.

Um Kubernetes-API-Auditprotokolle weiterzuleiten, gehen Sie wie folgt vor:

1. Legen Sie das Webhook-Back-End für die API-Serverkonfiguration fest. Eine Webhook-Konfiguration wird auf der Grundlage der Informationen erstellt, die Sie in den Flags dieses Befehls bereitstellen. Wenn Sie keine Informationen in den Flags bereitstellen, wird eine Standard-Webhook-Konfiguration verwendet.

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
    <td><code>apiserver-config-set</code></td>
    <td>Der Befehl zum Festlegen einer Option für die Kubernetes-API-Serverkonfiguration des Clusters.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>Der Unterbefehl zum Festlegen der Webhook-Auditkonfiguration für den Kubernetes-API-Server des Clusters.</td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server-URL_oder_IP&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;server-URL_oder_IP&gt;</em> durch die URL oder IP-Adresse für den fernen Protokollierungsservice, an den Sie Protokolle senden möchten. Wenn Sie eine unsichere Server-URL eingeben, werden alle Zertifikate ignoriert.</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;pfad_des_zertifizierungsstellenzertifikats&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;pfad_des_zertifizierungsstellenzertifikats&gt;</em> durch den Pfadnamen für das Zertifizierungsstellenzertifikat, das zum Überprüfen des fernen Protokollierungsservice verwendet wird.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;pfad_des_clientzertifikats&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;pfad_des_clientzertifikats&gt;</em> durch den Dateipfad für das Clientzertifikat, das zur Authentifizierung beim fernen Protokollierungsservice verwendet wird.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;pfad_des_clientschlüssels&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;pfad_des_clientschlüssels&gt;</em> durch den Dateipfad für den entsprechenden Clientschlüssel, der zum Verbinden mit dem fernen Protokollierungsservice verwendet wird.</td>
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


## Protokolle anzeigen
{: #view_logs}

Zum Anzeigen von Protokollen für Cluster und Container können Sie die Standardprotokollierungsfunktionen von Kubernetes und Docker verwenden.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Für Standardcluster befinden sich die Protokolle in dem {{site.data.keyword.Bluemix_notm}}-Konto, bei dem Sie angemeldet waren, als der Kubernetes-Cluster erstellt wurde. Wenn Sie beim Erstellen des Clusters oder der Protokollierungskonfiguration einen {{site.data.keyword.Bluemix_notm}}-Bereich angegeben haben, befinden sich die Protokolle in diesem Bereich. Protokolle werden außerhalb des Containers überwacht und weitergeleitet. Sie können über das Kibana-Dashboard auf Protokolle für einen Container zugreifen. Weitere Informationen zur Protokollierung finden Sie unter [Protokollierung für {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Hinweis**: Wenn Sie beim Erstellen des Clusters oder der Protokollierungskonfiguration einen Bereich angegeben haben, muss der Kontobesitzer für diesen Bereich über die Berechtigungen eines Managers, Entwicklers oder Prüfers verfügen, um Protokolle anzuzeigen. Informationen zum Ändern der Zugriffsrichtlinien und Berechtigungen für {{site.data.keyword.containershort_notm}} finden Sie in [Clusterzugriff verwalten](cs_users.html#managing). Sobald Berechtigungen geändert wurden, kann es bis zu 24 Stunden dauern, bis die entsprechenden Protokolle angezeigt werden.

Zum Zugriff auf das Kibana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.
- Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://logging.ng.bluemix.net
- Großbritannien (Süden) und Zentraleuropa: https://logging.eu-fra.bluemix.net
- Asiatisch-pazifischer Raum (Süden): https://logging.au-syd.bluemix.net

Weitere Informationen zum Anzeigen von Protokollen finden Sie im Abschnitt zum [Navigieren zu Kibana über einen Web-Browser](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Docker-Protokolle
{: #view_logs_docker}

Sie können die in Docker integrierten Protokollierungsfunktion nutzen, um Aktivitäten in den Standardausgabedatenströmen STDOUT und STDERR zu prüfen. Weitere Informationen finden Sie unter [Container-Protokolle für einen Container anzeigen, der in einem Kubernetes-Cluster ausgeführt wird](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

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
<dd>Das Kubernetes-Dashboard ist eine Webschnittstelle für die Verwaltung, über die Sie den Zustand Ihrer Workerknoten überprüfen, Kubernetes-Ressourcen suchen, containerisierte Apps bereitstellen und Fehler bei Apps auf der Grundlage von Protokollierungs- und Überwachungsdaten suchen und beheben können. Weitere Informationen dazu, wie Sie auf das Kubernetes-Dashboard zugreifen, finden Sie unter [Kubernetes-Dashboard für {{site.data.keyword.containershort_notm}} starten](cs_app.html#cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>Metriken für Standardcluster befinden sich in dem {{site.data.keyword.Bluemix_notm}}-Konto, das angemeldet war, als der Kubernetes-Cluster erstellt wurde. Wenn Sie beim Erstellen des Clusters einen {{site.data.keyword.Bluemix_notm}}-Bereich angegeben haben, befinden sich die Metriken in diesem Bereich. Containermetriken werden automatisch für alle Container erfasst, die in einem Cluster bereitgestellt werden. Diese Metriken werden durch Grafana gesendet und verfügbar gemacht. Weitere Informationen zu Metriken finden Sie unter [Überwachung für {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Zum Zugriff auf das Grafana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.<ul><li>Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://metrics.ng.bluemix.net</li><li>Großbritannien (Süden): https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

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

Das System für die automatische Wiederherstellung von {{site.data.keyword.containerlong_notm}} kann in vorhandenen Clustern ab Kubernetes Version 1.7 bereitgestellt werden. Das System verwendet verschiedene Prüfungen zum Abfragen des allgemeinen Zustands von Workerknoten. Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Diese Korrekturmaßnahme wird immer nur für einen Workerknoten ausgeführt. Die Korrekturmaßnahme muss für diesen Workerknoten erfolgreich abgeschlossen werden, bevor für einen weiteren Workerknoten eine Korrekturmaßnahme durchgeführt werden kann. Weitere Informationen finden Sie in diesem [Blogbeitrag zur automatischen Wiederherstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**HINWEIS**: Für die automatische Wiederherstellung ist es erforderlich, dass mindestens ein ordnungsgemäß funktionierender Workerknoten vorhanden ist. Konfigurieren Sie die automatische Wiederherstellung mit aktiven Prüfungen nur in Clustern mit mindestens zwei Workerknoten.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem die Zustandsprüfung für die Workerknoten durchgeführt werden soll.

1. Erstellen Sie eine Konfigurationszuordnungsdatei, mit der die Prüfungen im JSON-Format definiert werden. In der folgenden YAML-Datei sind beispielsweise drei Prüfungen angegeben: eine HTTP-Prüfung und zwei Kubernetes-API-Serverprüfungen. **Hinweis**: Jede Prüfung muss als eindeutiger Schlüssel im Datenabschnitt der Konfigurationszuordnung (ConfigMap) definiert werden.

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


    <table summary="Erklärung der Komponenten der Konfigurationszuordnung">
    <caption>Erklärung der Komponenten der Konfigurationszuordnung</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>Erklärung der Komponenten der Konfigurationszuordnung</th>
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
               Die Prüfung in der vorstehenden YAML-Beispieldatei wird alle Minuten durchgeführt. Schlägt die Prüfung 3 Mal hintereinander fehl, wird der Knoten neu gestartet. Diese Aktion ist äquivalent zur Ausführung des Befehls <code>bx cs worker-reboot</code>. Die HTTP-Prüfung wird erst dann aktiviert, wenn Sie das Feld <b>Enabled</b> auf den Wert <code>true</code> setzen.</td>
        </tr>
        <tr>
          <td><code>checknode.json</code></td>
          <td>Definiert eine Kubernetes-API-Knotenprüfung, mit der ermittelt wird, ob sich jeder Knoten im Bereitstatus (<code>Ready</code>) befindet. Die Prüfung eines bestimmten Knotens wird als Fehler gezählt, wenn sich der betreffende Knoten nicht im Status <code>Ready</code> befindet.
               Die Prüfung in der vorstehenden YAML-Beispieldatei wird alle Minuten durchgeführt. Schlägt die Prüfung 3 Mal hintereinander fehl, wird der Knoten neu geladen. Diese Aktion ist äquivalent zur Ausführung des Befehls <code>bx cs worker-reload</code>. Die Knotenprüfung bleibt so lange aktiviert, bis Sie das Feld <b>Enabled</b> auf den Wert <code>false</code> setzen oder die Prüfung entfernen.</td>
        </tr>
        <tr>
          <td><code>checkpod.json</code></td>
          <td>Definiert eine Kubernetes-API-Podprüfung, mit der auf Basis der Gesamtzahl der einem Knoten zugeordneten Pods ermittelt wird, welcher prozentuale Anteil der Pods in dem betreffenden Knoten insgesamt den Status <code>NotReady</code> (nicht bereit) aufweist. Die Prüfung eines bestimmten Knotens wird als Fehler gezählt, wenn der Gesamtprozentsatz der Pods im Status <code>NotReady</code> größer ist als der für <code>PodFailureThresholdPercent</code> festgelegte Wert.
               Die Prüfung in der vorstehenden YAML-Beispieldatei wird alle Minuten durchgeführt. Schlägt die Prüfung 3 Mal hintereinander fehl, wird der Knoten neu geladen. Diese Aktion ist äquivalent zur Ausführung des Befehls <code>bx cs worker-reload</code>. Die Podprüfung bleibt so lange aktiviert, bis Sie das Feld <b>Enabled</b> auf den Wert <code>false</code> setzen oder die Prüfung entfernen.</td>
        </tr>
      </tbody>
    </table>


    <table summary="Erklärung der Komponenten einzelner Regeln">
    <caption>Erklärung der Komponenten einzelner Regeln</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>Erklärung der Komponenten einzelner Regeln </th>
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
            <td>Geben Sie die Anzahl der Sekunden an, die die automatische Wiederherstellung warten muss, bis eine weitere Korrekturmaßnahme für einen Knoten abgesetzt werden kann, für den bereits eine Korrekturmaßnahme ausgelöst wurde. Die 'Erholungsphase' startet zu dem Zeitpunkt, zu dem eine Korrekturmaßnahme ausgegeben wird.</td>
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

4. Stellen Sie sicher, dass Sie einen geheimen Schlüssel für Docker-Pulloperationen namens `international-registry-docker-secret` im Namensbereich `kube-system` erstellt haben. Die automatische Wiederherstellung ist in der internationalen Docker-Registry von {{site.data.keyword.registryshort_notm}} gehostet. Wenn Sie keinen geheimen Schlüssel für die Docker-Registry erstellt haben, der gültige Berechtigungsnachweise für die internationale Registry aufweist, erstellen Sie einen solchen Schlüssel zum Ausführen des System für die automatische Wiederherstellung.

    1. Installieren Sie das {{site.data.keyword.registryshort_notm}}-Plug-in.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Wechseln Sie zur internationalen Registry.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Erstellen Sie ein Token für die internationale Registry.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Setzen Sie die Umgebungsvariable `INTERNATIONAL_REGISTRY_TOKEN` auf das von Ihnen erstellte Token.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Setzen Sie die Umgebungsvariable `DOCKER_EMAIL` auf den aktuellen Benutzer. Ihre E-Mail-Adresse wird nur zum Ausführen des Befehls `kubectl` im nächsten Schritt benötigt.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Erstellen Sie einen geheimen Schlüssel für die Docker-Pulloperation.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Stellen Sie die automatische Wiederherstellung in Ihrem Cluster durch das Anwenden der folgenden YAML-Datei bereit.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. Nach einigen Minuten können Sie den Abschnitt `Events` in der Ausgabe des folgenden Befehls auf mögliche Aktivitäten bei der Bereitstellung der automatischen Wiederherstellung überprüfen.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
