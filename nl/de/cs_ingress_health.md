---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Protokollierung und Überwachung von Ingress
{: #ingress_health}

Passen Sie die Protokollierung an und richten Sie die Überwachung ein, um Unterstützung bei der Fehlerbehebung zu erhalten und um die Leistung Ihrer Ingress-Konfiguration zu verbessern.
{: shortdesc}

## Ingress-Protokolle anzeigen
{: #ingress_logs}

Für Ihre Ingress-ALBs werden automatisch Protokolle erfasst. Um die ALB-Protokolle anzuzeigen, können Sie zwischen zwei Optionen wählen.
* [Erstellen Sie eine Protokollierungskonfiguration für den Ingress-Service](cs_health.html#configuring) in Ihrem Cluster.
* Überprüfen Sie die Protokolle von der CLI.
    1. Rufen Sie die ID eines Pods für eine ALB ab.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Öffnen Sie die Protokolle für diesen ALB-Pod. Stellen Sie sicher, dass die Protokolle dem aktualisierten Format entsprechen.
        ```
        kubectl logs <id_des_alb-pods> nginx-ingress -n kube-system
        ```
        {: pre}

</br>Der Ingress-Standardprotokollinhalt wird in JSON formatiert und zeigt allgemeine Felder an, in denen die Verbindungssitzung zwischen einem Client und Ihrer App beschrieben wird. Ein Beispielprotokoll mit den Standardfeldern sieht wie folgt aus:

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>Erklärung der Felder im Ingress-Standardprotokollformat</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Felder im Ingress-Standardprotokollformat</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>Die Ortszeit im ISO-8601-Standardformat, wenn das Protokoll geschrieben wird.</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>Die IP-Adresse des Anforderungspakets, das der Client an Ihre App gesendet hat. Diese IP kann sich in folgenden Situationen ändern:<ul><li>Wenn an Ihren Cluster eine Clientanforderung für Ihre App gesendet wird, wird die Anforderung an einen Pod für den Lastausgleichsservice weitergeleitet, der die Lastausgleichsfunktion zugänglich macht. Wenn ein App-Pod nicht auf demselben Workerknoten vorhanden ist wie der Lastausgleichsservice-Pod, leitet die Lastausgleichsfunktion die Anforderung an einen App-Pod auf einem anderen Workerknoten weiter. Die Quellen-IP-Adresse des Anforderungspakets wird in die öffentliche IP-Adresse des Workerknotens geändert, auf dem der App-Pod ausgeführt wird.</li><li>Wenn die [Beibehaltung der Quellen-IP aktiviert ist](cs_ingress.html#preserve_source_ip), wird stattdessen die ursprüngliche IP-Adresse der Clientanforderung an Ihre App aufgezeichnet.</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>Der Host oder die Unterdomäne, über den/die Ihre Apps zugänglich sind. Dieser Host wird in den Ingress-Ressourcendateien für Ihre ALBs konfiguriert.</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>Die Art der Anforderung: <code>HTTP</code> oder <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>Die Methode des Anforderungsaufrufs an die Back-End-App, z. B. <code>GET</code> oder <code>POST</code>.</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>Der ursprüngliche Anforderungs-URI zu Ihrem App-Pfad. ALBs verarbeiten die Pfade, auf denen Apps als Präfixe empfangsbereit sind. Wenn eine ALB eine Anforderung von einem Client an eine App empfängt, überprüft der ALB die Ingress-Ressource auf einen Pfad (als Präfix), der mit dem Pfad im Anforderungs-URI übereinstimmt.</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>Eine eindeutige Anforderungs-ID, die aus 10 beliebigen Bytes generiert wird.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>Der Statuscode für die Verbindungssitzung.<ul>
<li><code>200</code>: Die Sitzung wurde erfolgreich abgeschlossen.</li>
<li><code>400</code>: Clientdaten können nicht geparst werden.</li>
<li><code>403</code>: Zugriff verboten; z. B. wenn der Zugriff auf bestimmte Client-IP-Adressen beschränkt ist.</li>
<li><code>500</code>: Interner Serverfehler.</li>
<li><code>502</code>: Fehlerhaftes Gateway; z. B. wenn ein Upstream-Server nicht ausgewählt oder erreicht werden kann.</li>
<li><code>503</code>: Service nicht verfügbar; z. B. wenn der Zugriff durch die Anzahl der Verbindungen begrenzt ist.</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>Die IP-Adresse und der Port oder der Pfad zu dem UNIX-Domänen-Socket des Upstream-Servers. Wenn mehrere Server während der Anforderungsverarbeitung kontaktiert werden, werden ihre Adressen durch Kommas getrennt: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>. Wenn die Anforderung intern von einer Servergruppe zu einer anderen umgeleitet wird, werden die Serveradressen aus verschiedenen Gruppen durch Doppelpunkte voneinander getrennt: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>. Wenn die ALB keinen Server auswählen kann, wird stattdessen der Name der Servergruppe protokolliert.</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>Der Statuscode der Antwort, die vom Upstream-Server für die Back-End-App abgerufen wurde (z. B. HTTP-Standardantwortcodes). Statuscodes mehrerer Antworten werden durch Kommas und Doppelpunkte wie Adressen in der Variablen <code>$upstream_addr</code> voneinander getrennt. Wenn die ALB keinen Server auswählen kann, wird der Statuscode 502 (Fehlerhaftes Gateway) protokolliert.</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>Die Anforderungsverarbeitungszeit, gemessen in Sekunden mit einer Millisekundenauflösung. Diese Zeit beginnt, wenn die ALB die ersten Bytes der Clientanforderung liest, und sie endet, wenn die ALB die letzten Bytes der Antwort an den Client sendet. Das Protokoll wird unmittelbar nach dem Ende der Anforderungsverarbeitungszeit geschrieben.</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>Die Zeit, die die ALB benötigt, um die Antwort vom Upstream-Server für die Back-End-App zu empfangen (gemessen in Sekunden mit Millisekundenauflösung). Zeitangaben mehrerer Antworten werden durch Kommas und Doppelpunkte wie Adressen in der Variablen <code>$upstream_addr</code> voneinander getrennt.</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>Die Zeit, die die ALB benötigt, um eine Verbindung mit dem Upstream-Server für die Back-End-App herzustellen (gemessen in Sekunden mit Millisekundenauflösung). Wenn TLS/SSL in Ihrer Ingress-Ressourcenkonfiguration aktiviert ist, beinhaltet diese Zeit auch die Zeit, die für den Handshake benötigt wird. Zeitangaben mehrerer Verbindungen werden durch Kommas und Doppelpunkte wie Adressen in der Variablen <code>$upstream_addr</code> voneinander getrennt.</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>Die Zeit, die die ALB benötigt, um den Antwortheader vom Upstream-Server für die Back-End-App zu empfangen (gemessen in Sekunden mit Millisekundenauflösung). Zeitangaben mehrerer Verbindungen werden durch Kommas und Doppelpunkte wie Adressen in der Variablen <code>$upstream_addr</code> voneinander getrennt.</td>
</tr>
</tbody></table>

## Ingress-Protokollinhalt und -format anpassen
{: #ingress_log_format}

Sie können den Inhalt und das Format von Protokollen anpassen, die für die Ingress-ALB gesammelt werden.
{:shortdesc}

Standardmäßig sind Ingress-Protokolle in JSON formatiert und zeigen allgemeine Protokollfelder an. Sie können jedoch auch ein angepasstes Protokollformat erstellen. Gehen Sie wie folgt vor, um auszuwählen, welche Protokollkomponenten weitergeleitet werden und wie diese in der Protokollausgabe angeordnet sind:

1. Erstellen Sie eine lokale Version der Konfigurationsdatei für die Konfigurationszuordnungsressource `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Fügen Sie einen Abschnitt <code>data</code> hinzu. Fügen Sie das Feld `log-format` und optional das Feld `log-format-escape-json` hinzu.

    ```
    apiVersion: v1
    data:
      log-format: '{<schlüssel1>: <protokollvariable1>, <schlüssel2>: <protokollvariable2>, <schlüssel3>: <protokollvariable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>YAML-Dateikomponenten</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Konfiguration von 'log-format'</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Ersetzen Sie <code>&lt;schlüssel&gt;</code> durch den Namen für die Protokollkomponente und <code>&lt;protokollvariable&gt;</code> durch eine Variable für die Protokollkomponente, die Sie in Protokolleinträgen erfassen möchten. Sie können Text und Interpunktion einschließen, die der Protokolleintrag enthalten soll, z. B. Anführungszeichen um Zeichenfolgewerte und Kommas zum Trennen der einzelnen Protokollkomponenten. Wenn Sie beispielsweise eine Komponente wie <code>request: "$request"</code> formatieren, wird Folgendes in einem Protokolleintrag generiert: <code>request: "GET / HTTP/1.1"</code>. Eine Liste aller Variablen, die Sie verwenden können, finden Sie im <a href="http://nginx.org/en/docs/varindex.html">Nginx-Variablenindex</a>.<br><br>Um einen zusätzlichen Header wie <em>x-custom-ID</em> zu protokollieren, fügen Sie das folgende Schlüssel/Wert-Paar zum angepassten Protokollinhalt hinzu: <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>Bindestriche (<code>-</code>) werden in Unterstriche (<code>_</code>) konvertiert und <code>$http_</code> muss dem angepassten Headernamen vorangestellt werden.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Optional: Standardmäßig werden Protokolle im Textformat generiert. Um Protokolle im JSON-Format zu generieren, fügen Sie das Feld <code>log-format-escape-json</code> hinzu und verwenden Sie den Wert <code>true</code>.</td>
    </tr>
    </tbody></table>

    Ihr Protokollformat kann beispielsweise die folgenden Variablen enthalten:
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    Ein Protokolleintrag mit diesem Format sieht in etwa wie folgt aus:
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    Wenn Sie ein angepasstes Protokollformat erstellen möchten, das auf dem Standardformat für ALB-Protokolle basiert, ändern Sie den folgenden Abschnitt nach Bedarf und fügen Sie ihn zu Ihrer Konfigurationszuordnung hinzu:
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. Speichern Sie die Konfigurationsdatei.

5. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Wählen Sie zwischen zwei Optionen aus, um die Ingress-ALB-Protokolle anzuzeigen.
    * [Erstellen Sie eine Protokollierungskonfiguration für den Ingress-Service](cs_health.html#logging) in Ihrem Cluster.
    * Überprüfen Sie die Protokolle von der CLI.
        1. Rufen Sie die ID eines Pods für eine ALB ab.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. Öffnen Sie die Protokolle für diesen ALB-Pod. Stellen Sie sicher, dass die Protokolle dem aktualisierten Format entsprechen.
            ```
            kubectl logs <alb-pod-id> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Größe der gemeinsam genutzten Speicherzone für die Erfassung von Ingress-Metriken erhöhen
{: #vts_zone_size}

Gemeinsam genutzte Speicherzonen sind so definiert, dass Workerprozesse Informationen wie Cache, Sitzungspersistenz und Ratenlimit gemeinsam nutzen können. Eine gemeinsam genutzte Speicherzone, die als virtuelle Host-Verkehrsstatuszone bezeichnet wird, wird für Ingress eingerichtet, um Messdaten für eine ALB zu erfassen.
{:shortdesc}

In der Ingress-Konfigurationszuordnung `ibm-cloud-provider-ingress-cm` legt das Feld `vts-status-zone-size` die Größe der gemeinsam genutzten Speicherzone für die Messdatenerfassung fest. Standardmäßig ist der Wert für `vts-status-zone-size` auf `10m` gesetzt. Wenn Sie über eine große Umgebung verfügen, die mehr Speicher für die Erfassung von Messwerten benötigt, können Sie den Standardwert überschreiben, um stattdessen einen größeren Wert zu verwenden, indem Sie die folgenden Schritte ausführen.

1. Erstellen Sie eine lokale Version der Konfigurationsdatei für die Konfigurationszuordnungsressource `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ändern Sie den Wert für `vts-status-zone-size` von `10m` in einen größeren Wert.

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
