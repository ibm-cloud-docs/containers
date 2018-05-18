---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Ingress-Services einrichten
{: #ingress}

Stellen Sie mehrere Apps in Ihrem Kubernetes-Cluster bereit, indem Sie Ingress-Ressourcen erstellen, die durch eine von IBM bereitgestellte Lastausgleichsfunktion für Anwendungen in {{site.data.keyword.containerlong}} verwaltet werden.
{:shortdesc}

## Netzbetrieb mit Ingress-Services planen
{: #planning}

Mit Ingress können Sie mehrere Services in Ihrem Cluster zugänglich zu machen und mithilfe eines einzigen öffentlichen Einstiegspunkts öffentlich verfügbar machen.
{:shortdesc}

Anstatt für jede App, die öffentlich zugänglich gemacht werden soll, einen Lastausgleichsservice zu erstellen,
bietet Ingress eine eindeutige öffentliche Route, mit der Sie öffentliche Anforderungen an Apps basierend auf ihren individuellen Pfaden innerhalb Ihres Clusters weiterleiten können. Ingress besteht aus zwei Hauptkomponenten: der Lastausgleichsfunktion für Anwendungen und der Ingress-Ressource.  

Die Lastausgleichsfunktion für Anwendungen (ALB) ist eine externe Lastausgleichsfunktionen, die für eingehende HTTP- oder HTTPS-, TCP- oder UDP-Serviceanforderungen empfangsbereit ist und Anforderungen an den entsprechenden App-Pod weiterleitet. Wenn Sie einen Standardcluster erstellen, erstellt {{site.data.keyword.containershort_notm}} automatisch eine hochverfügbare ALB für Ihre Cluster und ordnet ihnen eine eindeutige öffentliche Route zu. Die öffentliche Route ist mit einer portierbaren öffentlichen IP-Adresse verknüpft, die bei der Erstellung des Clusters in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) eingerichtet wird. Es wird zwar auch eine private Standard-ALB (Lastausgleichsfunktion für Anwendungen) erstellt, diese wird jedoch nicht automatisch aktiviert.

Um eine App über Ingress zugänglich zu machen, müssen Sie einen Kubernetes-Service für Ihre App erstellen und diesen Service bei der Lastausgleichsfunktion für Anwendungen (ALB) registrieren, indem Sie eine Ingress-Ressource definieren. Die Ingress-Ressource gibt den Pfad an, der an die öffentliche Route angefügt wurde, um eine eindeutige URL für Ihre zugänglich gemachte App zu bilden (z. B. `mycluster.us-south.containers.mybluemix.net/myapp`) und definiert die Regeln für die Weiterleitung eingehender Anforderungen für eine App. 

Das folgende Diagramm veranschaulicht, wie Ingress die Kommunikation vom Internet an eine App leitet:

<img src="images/cs_ingress_planning.png" width="550" alt="App {{site.data.keyword.containershort_notm}} mithilfe von Ingress zugänglich machen" style="width:550px; border-style: none"/>

1. Ein Benutzer sendet eine Anforderung an Ihre App, indem er auf die URL Ihrer App zugreift. Diese URL ist die öffentliche URL für Ihre zugänglich gemachte App, der der Pfad der Ingress-Ressource wie zum Beispiel `mycluster.us-south.containers.mybluemix.net/myapp` angehängt wird. 

2. Ein DNS-Systemservice, der als globale Lastausgleichsfunktion fungiert, löst die URL in die portierbare öffentliche IP-Adresse der öffentlichen Standard-ALB im Cluster auf. 

3. `kube-proxy` leitet die Anforderung an den Kubernetes-ALB-Service für die App weiter. 

4. Der Kubernetes-Service leitet die Anforderung an die ALB weiter.

5. Die ALB überprüft, ob eine Weiterleitungsregel für den Pfad `myapp` im Cluster vorhanden ist. Wird eine übereinstimmende Regel gefunden, wird die Anforderung entsprechend der Regeln, die Sie in der Ingress-Ressource definiert haben, an den Pod weitergeleitet, in dem die App bereitgestellt wurde. Wenn mehrere App-Instanzen im Cluster bereitgestellt werden, gleicht die ALB die Anforderungen zwischen den App-Pods aus. 



**Hinweis:** Ingress ist nur für Standardcluster verfügbar und erfordert mindestens zwei Workerknoten im Cluster, um eine hohe Verfügbarkeit und regelmäßige Aktualisierungen zu gewährleisten. Für die Einrichtung von Ingress ist eine [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).

Folgen Sie diesem Entscheidungsbaum, um die beste Konfiguration für Ingress auszuwählen:

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="Diese Abbildung zeigt eine Übersicht zum Auswählen der besten Konfiguration für Ihre Ingress-Lastausgleichsfunktion für Anwendungen. Falls diese Abbildung nicht angezeigt wird, finden Sie diese Informationen auch in der Dokumentation." style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="Apps mithilfe einer angepassten Domäne ohne TLS nicht öffentlich zugänglich machen" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="Apps mithilfe einer angepassten Domäne mit TLS nicht öffentlich zugänglich machen" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="Apps außerhalb des verwendeten Clusters mithilfe der von IBM bereitgestellten oder einer angepassten Domäne mit TLS öffentlich zugänglich machen" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="Apps mithilfe einer angepassten Domäne mit TLS öffentlich zugänglich machen" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="Apps mithilfe der von IBM bereitgestellten Domäne ohne TLS öffentlich zugänglich machen" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="Apps mithilfe der von IBM bereitgestellten Domäne mit TLS öffentlich zugänglich machen" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## Apps öffentlich zugänglich machen
{: #ingress_expose_public}

Wenn Sie einen Standardcluster erstellen, wird automatisch eine von IBM bereitgestellte Lastausgleichsfunktion für Anwendungen (ALB) aktiviert, der eine portierbare öffentliche IP-Adresse und eine öffentliche Route zugewiesen ist. {:shortdesc}

Jeder App, die öffentlich über Ingress zugänglich gemacht wird, ist ein eindeutiger Pfad zugewiesen, der an die öffentliche Route angehängt wird, sodass Sie eine eindeutige URL verwenden können, um öffentlich auf eine App in Ihrem Cluster zuzugreifen. Um Ihre App öffentlich zugänglich zu machen, können Sie Ingress für die folgenden Szenarios konfigurieren.

-   [Apps mithilfe der von IBM bereitgestellten Domäne ohne TLS öffentlich zugänglich machen](#ibm_domain)
-   [Apps mithilfe der von IBM bereitgestellten Domäne mit TLS öffentlich zugänglich machen](#ibm_domain_cert)
-   [Apps mithilfe einer angepassten Domäne mit TLS öffentlich zugänglich machen](#custom_domain_cert)
-   [Apps außerhalb des verwendeten Clusters mithilfe der von IBM bereitgestellten oder einer angepassten Domäne mit TLS öffentlich zugänglich machen](#external_endpoint)

### Apps mithilfe der von IBM bereitgestellten Domäne ohne TLS öffentlich zugänglich machen
{: #ibm_domain}

Sie können die Lastausgleichsfunktion für Anwendungen (ALB) als Lastausgleichsfunktion für eingehenden HTTP-Netzdatenverkehr für die Apps in Ihrem Cluster konfigurieren und die von IBM bereitgestellte Domäne für den Zugriff auf Ihre Apps über das Internet verwenden.{:shortdesc}

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.

Gehen Sie wie folgt vor, um eine App unter Verwendung der von IBM bereitgestellten Domäne zugänglich zu machen:

1.  [Stellen Sie die App für den Cluster bereit](cs_app.html#app_cli). Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Ingress-Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Von der ALB kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Servicekonfigurationsdatei namens `myservice.yaml` (Beispiel).
    2.  Definieren Sie einen Service für die App, die Sie öffentlich zugänglich machen möchten.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          selector:
            <selektorschlüssel>: <selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der ALB-Servicedateikomponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen für Ihren ALB-Service.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>Der Port, den der Service überwacht.</td>
         </tr>
         </tbody></table>
    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  Wiederholen Sie diese Schritte für jede App, die Sie öffentlich zugänglich machen wollen.
3.  Rufen Sie die Details für Ihren Cluster ab, um die von IBM bereitgestellte Domäne anzuzeigen. Ersetzen Sie _&lt;mein_cluster&gt;_ durch den Namen des Clusters, in dem die App bereitgestellt wird, die Sie öffentlich zugänglich machen möchten.

    ```
    bx cs cluster-get <mein_cluster>
    ```
    {: pre}

    Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:

    ```
    Retrieving cluster <mein_cluster>...
    OK
    Name:    <mein_cluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibm domäne>
    Ingress secret:  <geheimer_tls-schlüssel_von_ibm>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    Die von IBM bereitgestellte Domäne ist im Feld für die Ingress-Unterdomäne (**Ingress subdomain**) angegeben.
4.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden von der ALB verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie müssen eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, wenn jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Ingress-Konfigurationsdatei namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrer Konfigurationsdatei, die die von IBM bereitgestellte Domäne für das Weiterleiten von eingehendem Netzverkehr an den zuvor erstellten Service verwendet.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
        spec:
          rules:
          - host: <ibm_domäne>
            http:
              paths:
              - path: /<mein_servicepfad1>
                backend:
                  serviceName: <mein_service1>
                  servicePort: 80
              - path: /<mein_servicepfad2>
                backend:
                  serviceName: <mein_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der Ingress-Ressourcendatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;ibm domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (*) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
        Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br></br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.
        </br>
        Beispiel: <ul><li>Geben Sie für <code>http://ingress-hostname/</code> als Pfad <code>/</code> ein.</li><li>Geben Sie für <code>http://ingress-hostname/mein_servicepfad</code> als Pfad <code>/mein_servicepfad</code> ein.</li></ul>
        </br>
        <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit [Annotation neu schreiben](cs_annotations.html#rewrite-path) eine richtige Weiterleitung an Ihre App einrichten.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
        </tr>
        </tbody></table>

    3.  Erstellen Sie die Ingress-Ressource für Ihr Cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie
_&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    1. Wenn Nachrichten im Ereignis einen Fehler in Ihrer Ressourcenkonfiguration beschreiben, ändern Sie die Werte in Ihrer Ressourcendatei und wenden die Datei für die Ressource erneut an. 

6.  Geben Sie in einem Web-Browser die URL des App-Service an, auf den zugegriffen werden soll.

    ```
    http://<ibm domäne>/<mein_servicepfad1>
    ```
    {: codeblock}

<br />


### Apps mithilfe der von IBM bereitgestellten Domäne mit TLS öffentlich zugänglich machen
{: #ibm_domain_cert}

Sie können die Ingress-ALB (Lastausgleichsfunktion für Anwendungen) so konfigurieren, dass eingehende TLS-Verbindungen für Ihre Apps verwaltet, der Netzverkehr mithilfe des von IBM bereitgestellten TLS-Zertifikats entschlüsselt und die entschlüsselte Anforderung an die Apps weitergeleitet wird, die in Ihrem Cluster zugänglich sind.{:shortdesc}

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.

Gehen Sie wie folgt vor, um eine App unter Verwendung der von IBM bereitgestellten Domäne mit TLS zugänglich zu machen:

1.  [Stellen Sie die App für den Cluster bereit](cs_app.html#app_cli). Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung identifiziert alle Pods, in denen Ihre App ausgeführt wird, damit die Pods in den Ingress-Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Von der ALB kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Servicekonfigurationsdatei namens `myservice.yaml` (Beispiel).
    2.  Definieren Sie einen ALB-Service für die App, die Sie öffentlich zugänglich machen möchten.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          selector:
            <selektorschlüssel>: <selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der ALB-Servicedateikomponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen für Ihren ALB-Service.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>Der Port, den der Service überwacht.</td>
         </tr>
         </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Wiederholen Sie diese Schritte für jede App, die Sie öffentlich zugänglich machen wollen.

3.  Zeigen Sie die von IBM bereitgestellte Domäne und das TLS-Zertifikat an. Ersetzen Sie _&lt;mein_cluster&gt;_ durch den Namen des Clusters, in dem die App bereitgestellt wird.

    ```
    bx cs cluster-get <mein_cluster>
    ```
    {: pre}

    Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:

    ```
    bx cs cluster-get <mein_cluster>
    Retrieving cluster <mein_cluster>...
    OK
    Name:    <mein_cluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibm domäne>
    Ingress secret:  <geheimer_tls-schlüssel_von_ibm>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    Die von IBM bereitgestellte Domäne ist im Feld für die Unterdomäne (**Ingress-Unterdomäne**) und das von IBM bereitgestellte Zertifikat im Feld für den geheimen Ingress-Schlüssel (**Ingress secret**) angegeben.

4.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden von der ALB verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie müssen eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, wenn jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Ingress-Konfigurationsdatei namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrer Konfigurationsdatei, die die von IBM bereitgestellte Domäne für das Weiterleiten von eingehendem Netzverkehr an Ihre Services und das von IBM bereitgestellte Zertifikat für die Verwaltung der TLS-Terminierung verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://ingress-domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die ALB sucht den zugehörigen Service, sendet den Netzverkehr an diesen Service und weiter an die Pods, auf denen die App ausgeführt wird. 

        **Hinweis:** Die App muss den Pfad überwachen, den Sie in der Ingress-Ressource angegeben haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als
`/` und geben keinen individuellen Pfad für Ihre App an.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
        spec:
          tls:
          - hosts:
            - <ibm domäne>
            secretName: <geheimer_tls-schlüssel_von_ibm>
          rules:
          - host: <ibm domäne>
            http:
              paths:
              - path: /<mein_servicepfad1>
                backend:
                  serviceName: <mein_service1>
                  servicePort: 80
              - path: /<mein_servicepfad2>
                backend:
                  serviceName: <mein_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der Ingress-Ressourcendatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Ersetzen Sie <em>&lt;ibm domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;geheimer_tls-schlüssel_von_ibm&gt;</em> durch den von IBM bereitgestellten Namen des <strong>geheimen Ingress-Schlüssels</strong> aus dem vorherigen Schritt. Mithilfe dieses Zertifikats wird die TLS-Terminierung verwaltet.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;ibm domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
        Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br>
        Beispiel: <ul><li>Geben Sie für <code>http://ingress-hostname/</code> als Pfad <code>/</code> ein.</li><li>Geben Sie für <code>http://ingress-hostname/mein_servicepfad</code> als Pfad <code>/mein_servicepfad</code> ein.</li></ul>
        <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit [Annotation neu schreiben](cs_annotations.html#rewrite-path) eine richtige Weiterleitung an Ihre App einrichten.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
        </tr>
        </tbody></table>

    3.  Erstellen Sie die Ingress-Ressource für Ihr Cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie
_&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    1. Wenn Nachrichten im Ereignis einen Fehler in Ihrer Ressourcenkonfiguration beschreiben, ändern Sie die Werte in Ihrer Ressourcendatei und wenden Sie die Datei für die Ressource erneut an. 

6.  Geben Sie in einem Web-Browser die URL des App-Service an, auf den zugegriffen werden soll.

    ```
    https://<ibm domäne>/<mein_servicepfad1>
    ```
    {: codeblock}

<br />


### Apps mithilfe einer angepassten Domäne mit TLS öffentlich zugänglich machen
{: #custom_domain_cert}

Sie können die Lastausgleichsfunktion für Anwendungen (ALB) zum Weiterleiten von eingehendem Netzverkehr an die Apps in Ihrem Cluster verwenden und Ihr eigenes TLS-Zertifikat zum Verwalten der TLS-Terminierung nutzen, wobei Sie statt der von IBM bereitgestellten Domäne Ihre angepasste Domäne verwenden.
{:shortdesc}

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.

Gehen Sie wie folgt vor, um eine App unter Verwendung einer angepassten Domäne mit TLS zugänglich zu machen:

1.  Erstellen Sie eine angepasste Domäne. Zum Erstellen einer angepassten Domäne arbeiten Sie mit Ihrem DNS-Provider (Domain Name Service) oder [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns), um Ihre angepasste Domäne zu registrieren.
2.  Konfigurieren Sie Ihre Domäne, um eingehenden Netzverkehr an die von IBM bereitgestellte Lastausgleichsfunktion für Anwendungen (ALB) weiterzuleiten. Wählen Sie zwischen diesen Optionen:
    -   Definieren Sie einen Alias für Ihre angepasste Domäne, indem Sie die von IBM bereitgestellte Domäne als kanonischen Namensdatensatz (CNAME) angeben. Führen Sie `bx cs cluster-get <mycluster>` aus, um die von IBM bereitgestellte Ingress-Domäne zu suchen, und suchen Sie nach dem Feld für die Ingress-Unterdomäne (**Ingress subdomain**).
    -   Ordnen Sie Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse der von IBM bereitgestellten Lastausgleichsfunktion für Anwendungen (ALB) zu, indem Sie die IP-Adresse als Datensatz hinzufügen. Um die portierbare öffentliche IP-Adresse der ALB zu finden, führen Sie folgenden Befehl aus: `bx cs alb-get<public_alb_ID>`.
3.  Importieren oder erstellen Sie ein TLS-Zertifikat und einen geheimen Schlüssel:
    * Wenn in {{site.data.keyword.cloudcerts_long_notm}} bereits ein TLS-Zertifikat gespeichert ist, das Sie verwenden wollen, können Sie den zugehörigen geheimen Schlüssel in Ihren Cluster importieren, indem Sie den folgenden Befehl ausführen:

      ```
      bx cs alb-cert-deploy --secret-name <name_des_geheimen_schlüssels> --cluster <clustername_oder_-id> --cert-crn <crn_des_zertifikats>
      ```
      {: pre}

    * Wenn kein TLS-Zertifikat bereitsteht, führen Sie die folgenden Schritte aus:
        1. Erstellen Sie ein TLS-Zertifikat und einen Schlüssel für Ihre Domäne, der im PEM-Format codiert ist.
        2. Erstellen Sie einen geheimen Schlüssel, der Ihr TLS-Zertifikat und Ihren Schlüssel verwendet. Ersetzen Sie <em>&lt;mein_geheimer_tls-schlüssel&gt;</em> durch einen Namen für Ihren geheimen Kubernetes-Schlüssel, <em>&lt;dateipfad_des_tls-schlüssels&gt;</em> durch den Pfad Ihrer angepassten TLS-Schlüsseldatei und <em>&lt;dateipfad_des_tls-zertifikats&gt;</em> durch den Pfad Ihrer angepassten TLS-Zertifikatsdatei.

            ```
            kubectl create secret tls <mein_geheimer_tls-schlüssel> --key <dateipfad_des_tls-schlüssels> --cert <dateipfad_des_tls-zertifikats>
            ```
            {: pre}

4.  [Stellen Sie die App für den Cluster bereit](cs_app.html#app_cli). Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Ingress-Lastenausgleich aufgenommen werden können.

5.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Von der ALB kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.

    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Servicekonfigurationsdatei namens `myservice.yaml` (Beispiel).
    2.  Definieren Sie einen ALB-Service für die App, die Sie öffentlich zugänglich machen möchten.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          selector:
            <selektorschlüssel>: <selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <caption>Erklärung der ALB-Servicedateikomponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen Ihres ALB-Service. </td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
         </tr>
         <td><code>port</code></td>
         <td>Der Port, den der Service überwacht.</td>
         </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Wiederholen Sie diese Schritte für jede App, die Sie öffentlich zugänglich machen wollen.
6.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden von der ALB verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie müssen eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, wenn jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Ingress-Konfigurationsdatei namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrer Konfigurationsdatei, die Ihre angepasste Domäne für das Weiterleiten von eingehendem Netzverkehr an Ihre Services und Ihr angepasstes Zertifikat für die Verwaltung der TLS-Terminierung verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an Ihre angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen; z. B. `https://meine_domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die ALB sucht den zugehörigen Service, sendet den Netzverkehr an diesen Service und weiter an die Pods, auf denen die App ausgeführt wird. 

        Die App muss auf dem Pfad empfangsbereit sein, den Sie in der Ingress-Ressource definiert haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als
`/` und geben keinen individuellen Pfad für Ihre App an.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
        spec:
          tls:
          - hosts:
            - <meine_angepasste_domäne>
            secretName: <mein_geheimer_tls-schlüssel>
          rules:
          - host: <meine_angepasste_domäne>
            http:
              paths:
              - path: /<mein_servicepfad1>
                backend:
                  serviceName: <mein_service1>
                  servicePort: 80
              - path: /<mein_servicepfad2>
                backend:
                  serviceName: <mein_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der Ingress-Ressourcendatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Ersetzen Sie <em>&lt;meine_angepasste_domäne&gt;</em> durch die angepasste Domäne, die Sie für TLS-Terminierung konfigurieren möchten.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_geheimer_tls-schlüssel&gt;</em> durch den Namen des zuvor erstellten geheimen Schlüssels, der Ihr angepasstes TLS-Zertifikat sowie den Schlüssel enthält. Wenn Sie ein Zertifikat aus {{site.data.keyword.cloudcerts_short}} importiert haben, können Sie den Befehl <code>bx cs alb-cert-get --cluster <clustername_oder_-id> --cert-crn <crn_des_zertifikats></code> ausführen, um die geheimen Schlüssel anzuzeigen, die einem TLS-Zertifikat zugeordnet sind.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;meine_angepasste_domäne&gt;</em> durch die angepasste Domäne, die Sie für TLS-Terminierung konfigurieren möchten.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
        Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br></br>
        Beispiel: <ul><li>Geben Sie für <code>https://meine_angepasste_domäne/</code> <code>/</code> als Pfad an.</li><li>Geben Sie für <code>https://meine_angepasste_domäne/mein_servicepfad</code> <code>/mein_servicepfad</code> als Pfad ein.</li></ul>
        <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit [Annotation neu schreiben](cs_annotations.html#rewrite-path) eine richtige Weiterleitung an Ihre App einrichten.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
        </tr>
        </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie die Ingress-Ressource für Ihr Cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

7.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie
_&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    1. Wenn Nachrichten im Ereignis einen Fehler in Ihrer Ressourcenkonfiguration beschreiben, ändern Sie die Werte in Ihrer Ressourcendatei und wenden Sie die Datei für die Ressource erneut an. 

8.  Greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die URL des App-Service an, auf den zugegriffen werden soll.

        ```
        https://<meine_angepasste_domäne>/<mein_servicepfad1>
        ```
        {: codeblock}

<br />


### Apps außerhalb des verwendeten Clusters mithilfe der von IBM bereitgestellten oder einer angepassten Domäne mit TLS öffentlich zugänglich machen
{: #external_endpoint}

Sie können die Lastausgleichsfunktion für Anwendungen (ALB) so konfigurieren, dass Apps, die sich außerhalb des Clusters befinden, berücksichtigt werden. Eingehende Anforderungen an die von IBM bereitgestellte oder Ihre angepasste Domäne werden automatisch an die externe App weitergeleitet.
{:shortdesc}

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.
-   Stellen Sie sicher, dass auf die externe App, die Sie beim Lastausgleich des Clusters berücksichtigen möchten, über eine öffentliche IP-Adresse zugegriffen werden kann.

Sie können eingehenden Netzverkehr in der von IBM bereitgestellten Domäne an Apps weiterleiten, die sich außerhalb Ihres Clusters befinden. Wenn Sie stattdessen eine angepasste Domäne und ein TLS-Zertifikat verwenden möchten, ersetzen Sie die von IBM bereitgestellte Domäne und das TLS-Zertifikat durch Ihre [angepasste Domäne und das TLS-Zertifikat](#custom_domain_cert).

1.  Erstellen Sie einen Kubernetes-Service für Ihren Cluster, der eingehende Anforderungen an einen von Ihnen erstellten externen Endpunkt weiterleitet. 
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Servicekonfigurationsdatei namens `myexternalservice.yaml` (Beispiel).
    2.  Definieren Sie den ALB-Service.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_servicename>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der ALB-Servicedateikomponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicename&gt;</em> durch den Namen Ihres Service.</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>Der Port, den der Service überwacht.</td>
        </tr></tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Kubernetes-Service für Ihren Cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

2.  Konfigurieren Sie einen Kubernetes-Endpunkt, der den externen Standort der App definiert, die Sie beim Lastausgleich des Clusters berücksichtigen möchten.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Endpunktkonfigurationsdatei namens `myexternalendpoint.yaml` (Beispiel).
    2.  Definieren Sie Ihren externen Endpunkt. Schließen Sie alle öffentlichen IP-Adressen und Ports ein, über die Sie auf Ihre externen App zugreifen können.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <mein_servicename>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_endpunktname&gt;</em> durch den Namen des Kubernetes-Service, den Sie zuvor erstellt haben. </td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Ersetzen Sie <em>&lt;externe_IP&gt;</em> durch die öffentlichen IP-Adressen für die Verbindung mit Ihrer externen App.</td>
         </tr>
         <td><code>port</code></td>
         <td>Ersetzen Sie <em>&lt;externer_port&gt;</em> durch den Port, den Ihre externe App überwacht.</td>
         </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Kubernetes-Endpunkt für Ihren Cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

3.  Zeigen Sie die von IBM bereitgestellte Domäne und das TLS-Zertifikat an. Ersetzen Sie _&lt;mein_cluster&gt;_ durch den Namen des Clusters, in dem die App bereitgestellt wird.

    ```
    bx cs cluster-get <mein_cluster>
    ```
    {: pre}

    Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:

    ```
    Retrieving cluster <mein_cluster>...
    OK
    Name:    <mein_cluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibm_domäne>
    Ingress secret:  <geheimer_tls-schlüssel_von_ibm>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    Die von IBM bereitgestellte Domäne ist im Feld für die Unterdomäne (**Ingress-Unterdomäne**) und das von IBM bereitgestellte Zertifikat im Feld für den geheimen Ingress-Schlüssel (**Ingress secret**) angegeben.

4.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden von der ALB verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie können eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere externe Apps zu definieren, solange jede App mit ihrem externen Endpunkt über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Ingress-Konfigurationsdatei namens `myexternalingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrer Konfigurationsdatei, die die von IBM bereitgestellte Domäne und das TLS-Zertifikat für das Weiterleiten von eingehendem Netzverkehr an Ihre externe App mithilfe des zuvor definierten externen Endpunkts verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne oder die angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://ingress-domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service und sendet Netzverkehr an ihn und dann weiter an die externe App.

        Die App muss auf dem Pfad empfangsbereit sein, den Sie in der Ingress-Ressource definiert haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als / und geben keinen individuellen Pfad für Ihre App an.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
        spec:
          tls:
          - hosts:
            - <ibm domäne>
            secretName: <geheimer_tls-schlüssel_von_ibm>
          rules:
          - host: <ibm domäne>
            http:
              paths:
              - path: /<mein_externer_servicepfad1>
                backend:
                  serviceName: <mein_service1>
                  servicePort: 80
              - path: /<mein_externer_servicepfad2>
                backend:
                  serviceName: <mein_externer_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der Ingress-Ressourcendatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch den Namen für die Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Ersetzen Sie <em>&lt;ibm domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;geheimer_tls-schlüssel_von_ibm&gt;</em> durch den von IBM bereitgestellten <strong>geheimen Ingress-Schlüssel</strong> aus dem vorherigen Schritt. Mithilfe dieses Zertifikats wird die TLS-Terminierung verwaltet.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Ersetzen Sie <em>&lt;ibm domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_externer_servicepfad&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die externe App weitergeleitet werden kann.

        </br>
        Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an Ihre Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>https://ibm_domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service. Sie sendet Netzverkehr an die externe App, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br></br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br></br>
        <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit [Annotation neu schreiben](cs_annotations.html#rewrite-path) eine richtige Weiterleitung an Ihre App einrichten.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_externer_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre externe App verwendet haben.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Der Port, den Ihr Service überwacht.</td>
        </tr>
        </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie die Ingress-Ressource für Ihr Cluster.

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie
_&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    1. Wenn Nachrichten im Ereignis einen Fehler in Ihrer Ressourcenkonfiguration beschreiben, ändern Sie die Werte in Ihrer Ressourcendatei und wenden Sie die Datei für die Ressource erneut an. 

6.  Greifen Sie auf Ihre externe App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die URL für den Zugriff auf Ihre externe App ein.

        ```
        https://<ibm domäne>/<mein_externer_servicepfad>
        ```
        {: codeblock}

<br />


## Apps in einem privaten Netz zugänglich machen
{: #ingress_expose_private}

Wenn Sie einen Standardcluster erstellen, wird eine von IBM bereitgestellte Lastausgleichsfunktion für Anwendungen (ALB) erstellt, der eine portierbare öffentliche IP-Adresse und eine private Route zugewiesen ist. Die private Standard-ALB wird jedoch nicht automatisch aktiviert. Um Ihre App für private Netze zugänglich zu machen, [aktivieren Sie zunächst die private Lastausgleichsfunktion für Anwendungen](#private_ingress).
{:shortdesc}

Anschließend können Sie Ingress für die folgenden Szenarios konfigurieren.
-   [Apps mithilfe einer angepassten Domäne ohne TLS nicht öffentlich zugänglich machen](#private_ingress_no_tls)
-   [Apps mithilfe einer angepassten Domäne mit TLS nicht öffentlich zugänglich machen](#private_ingress_tls)

### Private Lastausgleichsfunktion für Anwendungen aktivieren
{: #private_ingress}

Bevor Sie die standardmäßige private Lastausgleichsfunktion für Anwendungen (ALB) verwenden können, müssen Sie sie entweder mit der von IBM bereitgestellten, portierbaren privaten IP-Adresse oder mit Ihrer eigenen portierbaren privaten IP-Adresse aktivieren.{:shortdesc}

**Hinweis**: Wenn Sie beim Erstellen des Clusters das Flag `--no-subnet` verwendet haben, müssen Sie ein portierbares privates Teilnetz oder ein durch einen Benutzer verwaltetes Teilnetz hinzufügen, bevor Sie die private Lastausgleichsfunktion für Anwendungen (ALB) aktivieren können. Weitere Informationen finden Sie im Abschnitt [Weitere Teilnetze für Ihren Cluster anfordern](cs_subnets.html#request).

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um die private Lastausgleichsfunktion für Anwendungen (ALB) mit der zuvor zugewiesenen, durch IBM bereitgestellten portierbaren privaten IP-Adresse zu aktivieren:

1. Listen Sie die verfügbaren ALBs in Ihrem Cluster auf, um die ID der privaten ALB abzurufen. Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen des Clusters, in dem die App, die Sie zugänglich machen möchten, bereitgestellt wird.

    ```
    bx cs albs --cluster <mein_cluster>
    ```
    {: pre}

    Das Feld **Status** für die private ALB ist _inaktiviert_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. Aktivieren Sie die private ALB. Ersetzen Sie <em>&lt;private_ALB-ID&gt;</em> durch die ID für die private ALB aus der Ausgabe im vorherigen Schritt. 

   ```
   bx cs alb-configure --albID <private_ALB-ID> --enable
   ```
   {: pre}


Gehen Sie wie folgt vor, um die private Lastausgleichsfunktion für Anwendungen (ALB) mit Ihrer eigenen portierbaren privaten IP-Adresse zu aktivieren:

1. Konfigurieren Sie das vom Benutzer verwaltete Teilnetz der gewünschten IP-Adresse so, dass Datenverkehr über das private VLAN Ihres Clusters geleitet wird. Ersetzen Sie <em>&lt;clustername&gt;</em> durch den Namen oder der ID des Clusters, in dem die App, die Sie zugänglich machen möchten, bereitgestellt wird, <em>&lt;teilnetz_CIDR&gt;</em> mit dem CIDR Ihres vom Benutzer verwalteten Teilnetzes und <em>&lt;privates_VLAN&gt;</em> mit einer verfügbaren privaten VLAN-ID. Sie können durch das Ausführen des Befehls `bx cs vlans` nach der ID eines verfügbaren privaten VLANs suchen.

   ```
   bx cs cluster-user-subnet-add <clustername> <teilnetz_CIDR> <privates_VLAN>
   ```
   {: pre}

2. Listen Sie die verfügbaren ALBs in Ihrem Cluster auf, um die ID der privaten ALB abzurufen. 

    ```
    bx cs albs --cluster <mein_cluster>
    ```
    {: pre}

    Das Feld **Status** für die private ALB ist _inaktiviert_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. Aktivieren Sie die private ALB. Ersetzen Sie <em>&lt;private_ALB-ID&gt;</em> durch die ID für die private Lastausgleichsfunktion für Anwendungen (ALB) aus der Ausgabe aus dem vorherigen Schritt und <em>&lt;benutzer-ip&gt;</em> durch die IP-Adresse des durch den Benutzer verwalteten Teilnetzes, das Sie verwenden möchten.

   ```
   bx cs alb-configure --albID <private_ALB-ID> --enable --user-ip <benutzer-ip>
   ```
   {: pre}

<br />


### Apps mithilfe einer angepassten Domäne ohne TLS nicht öffentlich zugänglich machen
{: #private_ingress_no_tls}

Sie können die private Lastausgleichsfunktion für Anwendungen (ALB) zum Weiterleiten von eingehendem Netzverkehr an die Apps in Ihrem Cluster verwenden, wobei Sie eine angepasste Domäne verwenden.
{:shortdesc}

[Aktivieren Sie zunächst die private Lastausgleichsfunktion für Anwendungen](#private_ingress).

Gehen Sie wie folgt vor, um eine App unter Verwendung einer angepassten Domäne ohne TLS nicht öffentlich zugänglich zu machen:

1.  Erstellen Sie eine angepasste Domäne. Zum Erstellen einer angepassten Domäne arbeiten Sie mit Ihrem DNS-Provider (Domain Name Service) oder [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns), um Ihre angepasste Domäne zu registrieren.

2.  Ordnen Sie Ihre angepasste Domäne der portierbaren privaten IP-Adresse der von IBM bereitgestellten privaten Lastausgleichsfunktion für Anwendungen (ALB) zu, indem Sie die IP-Adresse als Datensatz hinzufügen. Um die portierbare private IP-Adresse des privaten ALB zu finden, führen Sie den folgenden Befehl aus: `bx cs albs -- cluster<cluster_name>`.

3.  [Stellen Sie die App für den Cluster bereit](cs_app.html#app_cli). Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung identifiziert alle Pods, in denen Ihre App ausgeführt wird, damit sie in den Ingress-Lastenausgleich aufgenommen werden können.

4.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Von der privaten ALB kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.

    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Servicekonfigurationsdatei namens `myservice.yaml` (Beispiel).
    2.  Definieren Sie einen ALB-Service für die App, die Sie öffentlich zugänglich machen möchten.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          selector:
            <selektorschlüssel>: <selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <caption>Erklärung der ALB-Servicedateikomponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen Ihres ALB-Service. </td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
         </tr>
         <td><code>port</code></td>
         <td>Der Port, den der Service überwacht.</td>
         </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Kubernetes-Service in Ihrem Cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Wiederholen Sie diese Schritte für jede App, die Sie im privaten Netz zugänglich machen möchten.
7.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden von der ALB verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie müssen eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, wenn jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Ingress-Konfigurationsdatei namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrer Konfigurationsdatei, die Ihre angepasste Domäne für das Weiterleiten von eingehendem Netzverkehr an Ihre Services verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an Ihre angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://meine_domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die ALB sucht den zugehörigen Service, sendet den Netzverkehr an diesen Service und weiter an die Pods, auf denen die App ausgeführt wird. 

        Die App muss auf dem Pfad empfangsbereit sein, den Sie in der Ingress-Ressource definiert haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als
`/` und geben keinen individuellen Pfad für Ihre App an.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB-ID>"
        spec:
          rules:
          - host: <meine_angepasste_domäne>
            http:
              paths:
              - path: /<mein_servicepfad1>
                backend:
                  serviceName: <mein_service1>
                  servicePort: 80
              - path: /<mein_servicepfad2>
                backend:
                  serviceName: <mein_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der Ingress-Ressourcendatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Ersetzen Sie <em>&lt;private_ALB-ID&gt;</em> durch die ID für Ihre private Lastausgleichsfunktion für Anwendungen (ALB). Führen Sie den Befehl <code>bx cs albs --cluster <mein_cluster></code> aus, um nach der ALB-ID zu suchen. Weitere Informationen zu dieser Ingress-Annotation finden Sie unter [Weiterleitung mit einer privaten Lastausgleichsfunktion für Anwendungen](cs_annotations.html#alb-id).</td>
        </tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;meine_angepasste_domäne&gt;</em> durch Ihre angepasste Domäne.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
        Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>custom_domain/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br></br>
        Beispiel: <ul><li>Geben Sie für <code>https://meine_angepasste_domäne/</code> <code>/</code> als Pfad an.</li><li>Geben Sie für <code>https://meine_angepasste_domäne/mein_servicepfad</code> <code>/mein_servicepfad</code> als Pfad ein.</li></ul>
        <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit [Annotation neu schreiben](cs_annotations.html#rewrite-path) eine richtige Weiterleitung an Ihre App einrichten.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
        </tr>
        </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie die Ingress-Ressource für Ihr Cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie
_&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    1. Wenn Nachrichten im Ereignis einen Fehler in Ihrer Ressourcenkonfiguration beschreiben, ändern Sie die Werte in Ihrer Ressourcendatei und wenden Sie die Datei für die Ressource erneut an. 

9.  Greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die URL des App-Service an, auf den zugegriffen werden soll.

        ```
        http://<meine_angepasste_domäne>/<mein_servicepfad1>
        ```
        {: codeblock}

<br />


### Apps mithilfe einer angepassten Domäne mit TLS nicht öffentlich zugänglich machen
{: #private_ingress_tls}

Sie können private Lastausgleichsfunktionen für Anwendungen (ALBs) zum Weiterleiten von eingehendem Netzverkehr an die Apps in Ihrem Cluster verwenden. Verwenden Sie außerdem Ihr eigenes TLS-Zertifikat, um die TLS-Terminierung zu verwalten, während Sie Ihre angepasste Domäne verwenden.{:shortdesc}

Bevor Sie beginnen, [aktivieren Sie zunächst die standardmäßige private Lastausgleichsfunktion für Anwendungen](#private_ingress).

Gehen Sie wie folgt vor, um eine App unter Verwendung einer angepassten Domäne mit TLS privat zugänglich zu machen:

1.  Erstellen Sie eine angepasste Domäne. Zum Erstellen einer angepassten Domäne arbeiten Sie mit Ihrem DNS-Provider (Domain Name Service) oder [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns), um Ihre angepasste Domäne zu registrieren.

2.  Ordnen Sie Ihre angepasste Domäne der portierbaren privaten IP-Adresse der von IBM bereitgestellten privaten Lastausgleichsfunktion für Anwendungen (ALB) zu, indem Sie die IP-Adresse als Datensatz hinzufügen. Um die portierbare private IP-Adresse des privaten ALB zu finden, führen Sie den folgenden Befehl aus: `bx cs albs -- cluster<cluster_name>`.

3.  Importieren oder erstellen Sie ein TLS-Zertifikat und einen geheimen Schlüssel:
    * Wenn in {{site.data.keyword.cloudcerts_long_notm}} bereits ein TLS-Zertifikat gespeichert ist, das Sie verwenden wollen, können Sie den zugehörigen geheimen Schlüssel in Ihren Cluster importieren, indem Sie den folgenden Befehl ausführen: `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * Wenn kein TLS-Zertifikat bereitsteht, führen Sie die folgenden Schritte aus:
        1. Erstellen Sie ein TLS-Zertifikat und einen Schlüssel für Ihre Domäne, der im PEM-Format codiert ist.
        2. Erstellen Sie einen geheimen Schlüssel, der Ihr TLS-Zertifikat und Ihren Schlüssel verwendet. Ersetzen Sie <em>&lt;mein_geheimer_tls-schlüssel&gt;</em> durch einen Namen für Ihren geheimen Kubernetes-Schlüssel, <em>&lt;dateipfad_des_tls-schlüssels&gt;</em> durch den Pfad Ihrer angepassten TLS-Schlüsseldatei und <em>&lt;dateipfad_des_tls-zertifikats&gt;</em> durch den Pfad Ihrer angepassten TLS-Zertifikatsdatei.

            ```
            kubectl create secret tls <mein_geheimer_tls-schlüssel> --key <dateipfad_des_tls-schlüssels> --cert <dateipfad_des_tls-zertifikats>
            ```
            {: pre}

4.  [Stellen Sie die App für den Cluster bereit](cs_app.html#app_cli). Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Ingress-Lastenausgleich aufgenommen werden können.

5.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Von der privaten ALB kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.

    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Servicekonfigurationsdatei namens `myservice.yaml` (Beispiel).
    2.  Definieren Sie einen Lastausgleichsservice für Anwendungen für diejenige App, die Sie öffentlich zugänglich machen wollen.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          selector:
            <selektorschlüssel>: <selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <caption>Erklärung der ALB-Servicedateikomponenten</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen Ihres ALB-Service. </td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
         </tr>
         <td><code>port</code></td>
         <td>Der Port, den der Service überwacht.</td>
         </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Wiederholen Sie diese Schritte für jede App, die Sie im privaten Netz zugänglich machen möchten.
6.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden von der ALB verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie müssen eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, wenn jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie eine Ingress-Konfigurationsdatei namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrer Konfigurationsdatei, die Ihre angepasste Domäne für das Weiterleiten von eingehendem Netzverkehr an Ihre Services und Ihr angepasstes Zertifikat für die Verwaltung der TLS-Terminierung verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an Ihre angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://meine_domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die ALB sucht den zugehörigen Service, sendet den Netzverkehr an diesen Service und weiter an die Pods, auf denen die App ausgeführt wird. 

        **Hinweis:** Die App muss auf dem Pfad empfangsbereit sein, den Sie in der Ingress-Ressource definiert haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als
`/` und geben keinen individuellen Pfad für Ihre App an.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB-ID>"
        spec:
          tls:
          - hosts:
            - <meine_angepasste_domäne>
            secretName: <mein_geheimer_tls-schlüssel>
          rules:
          - host: <meine_angepasste_domäne>
            http:
              paths:
              - path: /<mein_servicepfad1>
                backend:
                  serviceName: <mein_service1>
                  servicePort: 80
              - path: /<mein_servicepfad2>
                backend:
                  serviceName: <mein_service2>
                  servicePort: 80
         ```
         {: codeblock}

         <table>
        <caption>Erklärung der Komponenten der Ingress-Ressourcendatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Ersetzen Sie <em>&lt;private_ALB-ID&gt;</em> durch die ID für Ihre private Lastausgleichsfunktion für Anwendungen (ALB). Führen Sie den Befehl <code>bx cs albs --cluster <mein_cluster></code> aus, um nach der ALB-ID zu suchen. Weitere Informationen zu dieser Ingress-Annotation finden Sie unter [Weiterleitung mit einer privaten Lastausgleichsfunktion für Anwendungen (ALB-ID)](cs_annotations.html#alb-id).</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Ersetzen Sie <em>&lt;meine_angepasste_domäne&gt;</em> durch die angepasste Domäne, die Sie für TLS-Terminierung konfigurieren möchten.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_geheimer_tls-schlüssel&gt;</em> durch den Namen des zuvor erstellten geheimen Schlüssels, der Ihr angepasstes TLS-Zertifikat sowie den Schlüssel enthält. Wenn Sie ein Zertifikat aus {{site.data.keyword.cloudcerts_short}} importiert haben, können Sie den Befehl <code>bx cs alb-cert-get --cluster <clustername_oder_-id> --cert-crn <crn_des_zertifikats></code> ausführen, um die geheimen Schlüssel anzuzeigen, die einem TLS-Zertifikat zugeordnet sind.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;meine_angepasste_domäne&gt;</em> durch Ihre angepasste Domäne, die Sie für TLS-Terminierung konfigurieren möchten.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
        Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an die Lastausgleichsfunktion für Anwendungen (ALB) weitergeleitet. Die Lastausgleichsfunktion für Anwendungen (ALB) sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br></br>
        Beispiel: <ul><li>Geben Sie für <code>https://meine_angepasste_domäne/</code> <code>/</code> als Pfad an.</li><li>Geben Sie für <code>https://meine_angepasste_domäne/mein_servicepfad</code> <code>/mein_servicepfad</code> als Pfad ein.</li></ul>
        <strong>Tipp:</strong> Um Ingress für die Überwachung eines Pfads zu konfigurieren, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit [Annotation neu schreiben](cs_annotations.html#rewrite-path) eine richtige Weiterleitung an Ihre App einrichten.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre App verwendet haben.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Der Port, den Ihr Service überwacht. Verwenden Sie denselben Port, die Sie beim Erstellen des Kubernetes-Service für Ihre App definiert haben.</td>
        </tr>
         </tbody></table>

    3.  Speichern Sie Ihre Änderungen.
    4.  Erstellen Sie die Ingress-Ressource für Ihr Cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

7.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie
_&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    1. Wenn Nachrichten im Ereignis einen Fehler in Ihrer Ressourcenkonfiguration beschreiben, ändern Sie die Werte in Ihrer Ressourcendatei und wenden Sie die Datei für die Ressource erneut an. 

8.  Greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die URL des App-Service an, auf den zugegriffen werden soll.

        ```
        https://<meine_angepasste_domäne>/<mein_servicepfad1>
        ```
        {: codeblock}

Lesen Sie [diesen Blogbeitrag ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")]](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2) mit einem umfassenden Lernprogramm zur Vorgehensweise für das Schützen von microservice-to-microservice-Kommunikation mithilfe der privaten ALB mit TLS über Ihre Cluster hinweg.

<br />




## Optional: Konfiguration der Lastausgleichsfunktion für Anwendungen
{: #configure_alb}

Mit den folgenden Optionen können Sie die Konfiguration einer Lastausgleichsfunktion für Anwendungen ergänzen.

-   [Ports für die Ingress-Lastausgleichsfunktion für Anwendungen öffnen](#opening_ingress_ports)
-   [SSL-Protokolle und SSL-Verschlüsselungen auf HTTP-Ebene konfigurieren](#ssl_protocols_ciphers)
-   [Lastausgleichsfunktion für Anwendungen mit Annotationen anpassen](cs_annotations.html)
{: #ingress_annotation}


### Ports für die Ingress-Lastausgleichsfunktion für Anwendungen öffnen
{: #opening_ingress_ports}

Standardmäßig sind nur die Ports 80 und 443 für die Ingress-ALB (Lastausgleichsfunktion für Anwendungen) zugänglich. Um weitere Ports zugänglich zu machen, können Sie die Konfigurationszuordnungsressource `ibm-cloud-provider-ingress-cm` bearbeiten.{:shortdesc}

1.  Erstellen Sie eine lokale Version der Konfigurationsdatei für die Konfigurationszuordnungsressource `ibm-cloud-provider-ingress-cm`. Fügen Sie den Abschnitt <code>data</code> hinzu und geben Sie die öffentlichen Ports 80, 443 und allen weiteren Ports an, die Sie zur Konfigurationszuordnungsdatei hinzufügen möchten. Trennen Sie dabei die Ports jeweils mit einem Semikolon (;) voneinander.

 Hinweis: Bei der Angabe der Ports müssen die Ports 80 und 443 eingeschlossen werden, um diese Ports offen zu halten. Ein Port, der nicht angegeben wird, wird geschlossen.

 ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

 Beispiel:
 ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```

2. Wenden Sie die Konfigurationsdatei an.

 ```
 kubectl apply -f <pfad_zu_configmap.yaml>
 ```
 {: pre}

3. Stellen Sie sicher, dass die Konfigurationsdatei angewendet wurde.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 Ausgabe:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <keine>
 Annotations:    <keine>

 Data
 ====

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

Weitere Informationen zu Konfigurationszuordnungsressourcen finden Sie in der [Kubernetes-Dokumentation](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).

### SSL-Protokolle und SSL-Verschlüsselungen auf HTTP-Ebene konfigurieren
{: #ssl_protocols_ciphers}

Aktivieren Sie SSL-Protokolle und -Verschlüsselungen auf der globalen HTTP-Ebene, indem Sie die Konfigurationszuordnung `ibm-cloud-provider-ingress-cm` bearbeiten.{:shortdesc}



**Hinweis**: Wenn Sie die aktivierten Protokolle für alle Hosts angeben, funktionieren die Parameter TLSv1.1 und TLSv1.2 (1.1.13, 1.0.12) nur wenn OpenSSL 1.0.1 oder eine höhere Version verwendet wird. Der Parameter TLSv1.3 (1.13.0) funktioniert nur, wenn OpenSSL 1.1.1 mit der Unterstützung von TLSv1.3 erstellt und dann verwendet wird. 

Gehen Sie wie folgt vor, um die Konfigurationsübersicht zu bearbeiten und SSL-Protokolle und Verschlüsselungen zu aktivieren.

1. Erstellen Sie eine lokale Version der Konfigurationsdatei für die Konfigurationszuordnungsressource 'ibm-cloud-provider-ingress-cm'. 

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Fügen Sie SSL-Protokolle und Verschlüsselungen hinzu. Formatieren Sie Verschlüsselungen entsprechend des [OpenSSL-Formats (OpenSSL library cipher list format) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

2. Wenden Sie die Konfigurationsdatei an.

   ```
   kubectl apply -f <pfad_zu_configmap.yaml>
   ```
   {: pre}

3. Stellen Sie sicher, dass die Konfigurationsdatei angewendet wurde.

   ```
   kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
   ```
   {: pre}

   Ausgabe:
   ```
   Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <keine>
 Annotations:    <keine>

   Data
 ====

    ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
   ```
   {: screen}
