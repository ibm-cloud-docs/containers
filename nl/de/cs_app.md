---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Apps in Clustern bereitstellen
{: #app}

Sie können Kubernetes-Verfahren in {{site.data.keyword.containerlong}} verwenden, um Apps in Containern bereitzustellen und um sicherzustellen, dass Ihre Apps ununterbrochen betriebsbereit sind. Sie können beispielsweise rollierende Aktualisierungen und Rollbacks ausführen, ohne dass Ihren Benutzern hierdurch Ausfallzeiten entstehen.
{:shortdesc}

Erfahren Sie mehr zu den allgemeinen Schritten zur Bereitstellung von Apps, indem Sie auf einen Bereich der folgenden Abbildung klicken.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="Basisbereitstellungsprozess"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Installieren Sie die CLIs." title="Installieren Sie die CLIs." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Erstellen Sie eine Konfigurationsdatei für Ihre App. Verschaffen Sie sich einen Überblick über die Best Practices von Kubernetes." title="Erstellen Sie eine Konfigurationsdatei für Ihre App. Verschaffen Sie sich einen Überblick über die Best Practices von Kubernetes." shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="Option 1: Führen Sie Konfigurationsdateien über die Kubernetes-CLI aus." title="Option 1: Führen Sie Konfigurationsdateien über die Kubernetes-CLI aus." shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="Option 2: Starten Sie das Kubernetes-Dashboard lokal und führen Sie Konfigurationsdateien aus." title="Option 2: Starten Sie das Kubernetes-Dashboard lokal und führen Sie Konfigurationsdateien aus." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Bereitstellungen mit Hochverfügbarkeit planen
{: #highly_available_apps}

Je breiter gefächert Sie Ihre Containerkonfiguration auf mehrere Workerknoten und Cluster verteilen, umso geringer ist die Wahrscheinlichkeit, dass Ihre Benutzer Ausfallzeiten mit Ihrer App verzeichnen.
{:shortdesc}

Betrachten Sie die folgenden potenziellen Appkonfigurationen, die nach zunehmendem Grad der Verfügbarkeit angeordnet sind.

![Stufen der Hochverfügbarkeit für eine App](images/cs_app_ha_roadmap.png)

1.  Bereitstellung mit n+2 Pods, deren Verwaltung durch eine Replikatgruppe erfolgt.
2.  Bereitstellung mit n+2 Pods, deren Verwaltung durch eine Replikatgruppe erfolgt und die auf mehrere Knoten
(Anti-Affinität) an demselben Standort verteilt sind.
3.  Bereitstellung mit n+2 Pods, deren Verwaltung durch eine Replikatgruppe erfolgt und die auf mehrere Knoten
(Anti-Affinität) an unterschiedlichen Standorten verteilt sind.
4.  Bereitstellung mit n+2 Pods, deren Verwaltung durch eine Replikatgruppe erfolgt und die auf mehrere Knoten (Anti-Affinität) in unterschiedlichen Regionen verteilt sind.

### Verfügbarkeit Ihrer App erhöhen

<dl>
<dt>Bereitstellungen und Replikatgruppen zum Bereitstellen Ihrer App und deren Abhängigkeiten verwenden</dt>
<dd>Eine Bereitstellung ist eine Kubernetes-Ressource, mit der Sie alle Komponenten Ihrer App und deren Abhängigkeiten deklarieren können. Dadurch, dass Sie die einzelnen Komponenten beschreiben und nicht etwa notieren, welche Schritte notwendig sind und in welcher Reihenfolge ausgeführt müssen, um sie zu erstellen, können Sie sich voll darauf konzentrieren, wie Ihre App zur Ausführungszeit aussehen soll.
</br></br>
Wenn Sie mehrere Pods bereitstellen, wird für Ihre Bereitstellungen automatisch eine Replikatgruppe erstellt, anhand der die Pods überwacht werden und sichergestellt wird, dass die gewünschte Anzahl von Pods jederzeit betriebsbereit ist. Wird ein Pod inaktiv, so ersetzt die Replikatgruppe den inaktiven Pod durch einen neuen Pod.
</br></br>
Mit einer Bereitstellung können Sie Aktualisierungsstrategien für Ihre App definieren. Dabei können Sie unter Anderem die Anzahl von Pods angeben, die Sie bei einer rollierenden Aktualisierung hinzufügen wollen, und festlegen, wie viele Pods zur gleichen Zeit nicht verfügbar sein dürfen. Wenn Sie eine rollierende Aktualisierung durchführen, prüft die Bereitstellung, ob die Überarbeitung funktioniert, und stoppt den Rollout, wenn Fehler erkannt werden.
</br></br>
Bereitstellungen bieten ferner die Möglichkeit der gleichzeitigen (simultanen) Bereitstellung mehrerer Revisionen (Überarbeitungen) mit verschiedenen Flags. Dadurch können Sie beispielsweise eine Bereitstellung testen, bevor Sie sich entschließen, sie mit einer Push-Operation an die Produktion zu übertragen.
</br></br>
Jede Bereitstellung verfolgt die Revisionen, die bereitgestellt wurden. Dieses Verlaufsprotokoll von Revisionen können Sie verwenden, um ein Rollback auf eine vorherige Version durchzuführen, falls Sie feststellen, dass Ihre Aktualisierungen nicht wie erwartet funktionieren.</dd>
<dt>Ausreichende Anzahl von Replikaten für die Arbeitslast Ihrer App plus 2 einbeziehen</dt>
<dd>Um Ihre App noch verfügbarer zu machen und ihre Ausfallsicherheit zu steigern, sollten Sie erwägen, über die Mindestzahl hinaus zusätzliche Replikate einzubinden, damit die erwartete Arbeitslast verarbeitet werden kann. Zusätzliche Replikate sind in der Lage, die Arbeitslast abzufangen, wenn ein Pod ausfällt und der ausgefallene Pod noch nicht durch die Replikatgruppe ersetzt wurde. Zum Schutz vor zwei gleichzeitigen Ausfällen sollten Sie zwei zusätzliche Replikate einbinden. Diese Konfiguration folgt dem Muster 'N+2'. Hierbei steht 'N' für die Anzahl der Replikate, die für die Verarbeitung der eingehenden Arbeitslast zur Verfügung steht, während der Wert '+2' die beiden zusätzlich eingebundenen Replikate angibt. Sie können in einem Cluster mit beliebig vielen Pods arbeiten, solange im Cluster ein genügend großer Bereich dafür zur Verfügung steht.</dd>
<dt>Pods auf mehrere Knoten (Anti-Affinität) verteilen</dt>
<dd>Wenn Sie Ihre Bereitstellung erstellen, ist es möglich, dass jeder Pod auf demselben Workerknoten bereitgestellt wird. Diese Konfiguration, bei der sich die Pods auf demselben Workerknoten befinden, wird als Affinität oder Kollokation (Zusammenstellung) bezeichnet. Zum Schutz Ihrer App vor dem Ausfall eines Workerknotens können Sie von Ihrer Bereitstellung durch Verwenden der Option <strong>podAntiAffinity</strong> die Verteilung der Pods auf mehrere Workerknoten erzwingen. Diese Option steht nur für Standardcluster zur Verfügung.

</br></br>
<strong>Hinweis:</strong> Die folgende YAML-Datei setzt durch, dass jeder Pod auf einem anderen Workerknoten bereitgestellt wird. Sind mehr Replikate definiert als Workerknoten in Ihrem Cluster verfügbar sind, so wird nur die Anzahl an Replikaten bereitgestellt, die die Anti-Affinitätsanforderung erfüllen kann. Alle zusätzlichen Replikate verweilen so lange in einem Wartestatus, bis weitere Workerknoten zum Cluster hinzugefügt werden.

<pre class="codeblock">
<code>apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: wasliberty
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - wasliberty
              topologyKey: kubernetes.io/hostname
      containers:
      - name: wasliberty
        image: registry.&lt;region&gt;.bluemix.net/ibmliberty
        ports:
        - containerPort: 9080
---
apiVersion: v1
kind: Service
metadata:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
    # Port, den dieser Service bedienen soll
  - port: 9080
  selector:
    app: wasliberty
  type: NodePort</code></pre>

</dd>
<dt>Pods auf mehrere Standorte oder Regionen verteilen</dt>
<dd>Als Schutz Ihrer App vor einem Ausfall des Standorts oder der Region können Sie an einem anderen Standort oder in einer anderen Region
einen zweiten Cluster erstellen und mit der YAML-Datei für die Bereitstellung ein Duplikat der Replikatgruppe bereitstellen. Durch Einfügen einer gemeinsam genutzten Route und einer Lastausgleichsfunktion (Load Balancer)
vor Ihren Clustern können Sie eine Verteilung der Arbeitslast auf mehrere Standorte oder Regionen bewirken. Weitere Informationen zur gemeinsamen Nutzung einer Route durch mehrere Cluster enthält <a href="cs_clusters.html#clusters" target="_blank">Hochverfügbarkeit von Clustern</a>.

Weitere Details finden Sie unter den Optionen für <a href="cs_clusters.html#planning_clusters" target="_blank">hoch verfügbare Bereitstellungen</a>.</dd>
</dl>


### Minimale App-Bereitstellung
{: #minimal_app_deployment}

Eine grundlegende App-Bereitstellung in einem kostenlosen Cluster oder Standardcluster kann die folgenden Komponenten enthalten.
{:shortdesc}

![Konfiguration für die Bereitstellung](images/cs_app_tutorial_components1.png)

Um die Komponenten für eine minimale App wie im Diagramm dargestellt bereitzustellen, verwenden Sie eine Konfigurationsdatei wie im folgenden Beispiel:
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.<region>.bluemix.net/ibmliberty:latest
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    run: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

Um mehr über die einzelnen Komponenten zu erfahren, lesen Sie sich den Abschnitt [Grundlegende Informationen zu Kubernetes](cs_tech.html#kubernetes_basics) durch.

<br />




## Kubernetes-Dashboard starten
{: #cli_dashboard}

Öffnen Sie auf Ihrem lokalen System ein Kubernetes-Dashboard, um Informationen zu einem Cluster und seinen Workerknoten anzuzeigen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus. Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).

Sie können den Standardport verwenden oder einen eigenen Port festlegen, um das Kubernetes-Dashboard für einen Cluster zu starten.

1.  Für Cluster mit der Kubernetes-Masterversion 1.7.4 oder einer früheren Version:

    1.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
        {: pre}

        Ausgabe:

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Öffnen Sie das Kubernetes-Dashboard in einem Web-Browser.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  Für Cluster mit einer Kubernetes-Masterversion ab Version 1.8.2:

    1.  Rufen Sie Ihre Berechtigungsnachweise für Kubernetes ab.

        ```
        kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
        ```
        {: pre}

    2.  Kopieren Sie den Wert für **id-token**, der in der Ausgabe angezeigt wird.

    3.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
        {: pre}

        Beispielausgabe:

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    4.  Melden Sie sich beim Dashboard an.

        1.  Navigieren Sie in Ihrem Browser zur folgenden URL:

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  Wählen Sie auf der Anmeldeseite die Authentifizierungsmethode **Token** aus.

        3.  Fügen Sie dann den zuvor kopierten Wert für **id-token** in das Feld **Token** ein und klicken Sie auf **ANMELDEN**.

[Als Nächstes können Sie eine Konfigurationsdatei über das Dashboard ausführen.](#app_ui)

Wenn Sie die Arbeit im Kubernetes-Dashboard beendet haben, beenden Sie den Befehl `proxy` mit der Tastenkombination `STRG + C`. Anschließend ist das Kubernetes-Dashboard nicht mehr verfügbar. Führen Sie den Befehl `proxy` aus, um das Kubernetes-Dashboard erneut zu starten.



<br />




## Geheime Schlüssel erstellen
{: #secrets}

Geheime Kubernetes-Schlüssel stellen eine sichere Methode zum Speichern vertraulicher Informationen wie Benutzernamen, Kennwörter oder Schlüssel dar.
{:shortdesc}

<table>
<caption>Tabelle. Dateien müssen in geheimen Schlüsseln nach Task gespeichert werden</caption>
<thead>
<th>Task</th>
<th>Erforderliche Dateien, die in geheimen Schlüssel gespeichert werden müssen</th>
</thead>
<tbody>
<tr>
<td>Hinzufügen eines Service zu einem Cluster</td>
<td>Keine. Es wird ein geheimer Schlüssel für Sie erstellt, wenn Sie einen Service an einen Cluster binden.</td>
</tr>
<tr>
<td>Optional: Konfigurieren Sie den Ingress-Service mit TLS, wenn 'ingress-secret' nicht verwendet wird. <p><b>Hinweis</b>: TLS ist bereits standardmäßig aktiviert und ein geheimer Schlüssel wurde bereits für die TLS-Verbindung erstellt.

Gehen Sie wie folgt vor, um den geheimen TLS-Standardschlüssel anzuzeigen:
<pre>
bx cs cluster-get &gt;CLUSTERNAME&lt; | grep "Ingress secret"
</pre>
</p>
Um stattdessen Ihren eigenen geheimen Schlüssel zu erstellen, führen Sie die Schritte im nachfolgenden Abschnitt durch.</td>
<td>Serverzertifikat und -schlüssel: <code>server.crt</code> und <code>server.key</code></td>
<tr>
<td>Erstellen Sie die Annotation 'mutual-authentication'.</td>
<td>Zertifikat der Zertifizierungsstelle: <code>ca.crt</code></td>
</tr>
</tbody>
</table>

Weitere Informationen darüber, was Sie in geheimen Schlüssel speichern können, finden Sie in der [Kubernetes-Dokumentation](https://kubernetes.io/docs/concepts/configuration/secret/).



Gehen Sie wie folgt vor, um einen geheimen Schlüssel mit einem Zertifikat zu erstellen:

1. Generieren Sie das Zertifikat und den Schlüssel der Zertifizierungsstelle über Ihren Zertifikatsanbieter. Wenn Sie über eine eigene Domäne verfügen, kaufen Sie ein offizielles TLS-Zertifikat für Ihre Domäne. Zu Testzwecken können Sie ein selbst signiertes Zertifikat generieren.

 Wichtig: Stellen Sie sicher, dass der [allgemeine Name](https://support.dnsimple.com/articles/what-is-common-name/) für jedes Zertifikat anders ist.

 Das Clientzertifikat und der Clientschlüssel müssen anhand des Trusted-Root-Zertifikats verifiziert werden, welches in diesem Fall das Zertifikat der Zertifizierungsstelle ist. Beispiel:

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. Erstellen Sie das Zertifikat als einen geheimen Kubernetes-Schlüssel.

   ```
   kubectl create secret generic <name_des_geheimen_schlüssels> --from-file=<zertifikatsdatei>=<zertifikatsdatei>
   ```
   {: pre}

   Beispiel:
   - TLS-Verbindung:

     ```
     kubectl create secret tls <name_des_geheimen_schlüssels> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
     ```
     {: pre}

   - Annotation für die gegenseitige Authentifizierung:

     ```
     kubectl create secret generic <name_des_geheimen_schlüssels> --from-file=ca.crt=ca.crt
     ```
     {: pre}

<br />





## Apps über die GUI bereitstellen
{: #app_ui}

Wenn Sie eine App über das Kubernetes-Dashboard in Ihrem Cluster bereitstellen, wird eine Bereitstellungsressource automatisch die Pods in Ihrem Cluster erstellen, aktualisieren und verwalten.
{:shortdesc}

Vorbemerkungen:

-   Installieren Sie die erforderlichen [CLIs](cs_cli_install.html#cs_cli_install).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um Ihre App bereitzustellen:

1.  [Öffnen Sie das Kubernetes-Dashboard](#cli_dashboard).
2.  Klicken Sie im Kubernetes-Dashboard auf **+ Create**.
3.  Wählen Sie **Specify app details below** (App-Details unten angeben) aus, um die App-Details über die GUI einzugeben, oder wählen Sie die Option **Upload a YAML or JSON file** (YAML- oder JSON-Datei hochladen) aus, um die [Konfigurationsdatei ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) für Ihre App hochzuladen. Verwenden Sie [diese YAML-Beispieldatei ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml), um einen Container aus dem Image **ibmliberty** in der Region 'Vereinigte Staaten (Süden)' bereitzustellen.
4.  Klicken Sie im Kubernetes-Dashboard auf **Deployments**, um zu überprüfen, ob die Bereitstellung auch tatsächlich erstellt wurde.
5.  Wenn Sie Ihre App mithilfe eines Knotenportservice, eines Lastenausgleichsservice oder Ingress öffentlich zugänglich gemacht haben, überprüfen Sie, dass Sie auf die App zugreifen können.

<br />


## Apps über die CLI (Befehlszeilenschnittstelle) bereitstellen
{: #app_cli}

Nachdem ein Cluster erstellt worden ist, können Sie in diesem Cluster über die Kubernetes-CLI eine App bereitstellen.
{:shortdesc}

Vorbemerkungen:

-   Installieren Sie die erforderlichen [CLIs](cs_cli_install.html#cs_cli_install).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um Ihre App bereitzustellen:

1.  Erstellen Sie eine Konfigurationsdatei auf der Grundlage der [Best Practices von Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/overview/). Im Allgemeinen enthält eine Konfigurationsdatei die Konfigurationsdetails für jede Ressource, die Sie in Kubernetes erstellen. Ihr Script könnte dabei einen oder mehrere der folgenden Abschnitte enthalten:

    -   [Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Definiert die Erstellung von Pods und Replikatgruppen. Ein Pod enthält eine einzelne containerisierte App. Mehrere Instanzen von Pods werden durch Replikatgruppen gesteuert.

    -   [Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/service/): Stellt Front-End-Zugriff auf Pods über eine öffentliche IP-Adresse eines Workerknotens oder einer Lastausgleichsfunktion bzw. über eine öffentliche Ingress-Route bereit.

    -   [Ingress ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Gibt einen Typ von Lastausgleichsfunktion an, die Routen für den öffentlichen Zugriff auf Ihre App bereitstellt.

2.  Führen Sie die Konfigurationsdatei in dem Kontext eines Clusters aus.

    ```
    kubectl apply -f position_des_bereitstellungscripts
    ```
    {: pre}

3.  Wenn Sie Ihre App mithilfe eines Knotenportservice, eines Lastenausgleichsservice oder Ingress öffentlich zugänglich gemacht haben, überprüfen Sie, dass Sie auf die App zugreifen können.

<br />





## Apps skalieren
{: #app_scaling}

Mit Kubernetes können Sie die [horizontale Autoskalierung von Pods ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) aktivieren, um die Anzahl der Instanzen Ihrer Apps CPU-basiert automatisch zu erhöhen oder zu verringern.
{:shortdesc}

Suchen Sie Informationen zum Skalieren von Cloud Foundry-Anwendungen? Lesen Sie den Abschnitt zur [IBM Autoskalierung für {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html). 
{: tip}

Vorbemerkungen:
- [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.
- Die Heapsterüberwachung muss in dem Cluster bereitgestellt werden, den Sie automatisch skalieren möchten.

1.  Stellen Sie Ihre App über die Befehlszeilenschnittstelle (CLI) bereit. Bei der Bereitstellung Ihrer App müssen Sie CPU anfordern.

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<portnummer>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>Die Anwendung, die bereitgestellt werden soll.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>Die erforderliche CPU für den Container. Die Angabe erfolgt in Millicore. Beispiel: <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>Bei Angabe von 'true' wird ein externer Service erstellt.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>Der Port, an dem Ihre App extern verfügbar ist.</td>
    </tr></tbody></table>

    Für Bereitstellungen mit einem höheren Grad an Komplexität ist gegebenenfalls die Erstellung einer [Konfigurationsdatei](#app_cli) erforderlich. {: tip}

2.  Erstellen Sie einen automatischen Scaler und definieren Sie Ihre Richtlinie. Weitere Informationen zur Arbeit mit dem Befehl `kubetcl autoscale` finden Sie in der [Dokumentation zu Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <bereitstellungsname> --cpu-percent=<prozentsatz> --min=<mindestwert> --max=<höchstwert>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Die durchschnittliche CPU-Auslastung, die durch die Funktion zur automatischen horizontalen Skalierung von Pods (Horizontal Pod Autoscaler) aufrechterhalten wird. Die Angabe erfolgt als Prozentsatz.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>Die Mindestanzahl von bereitgestellten Pods, die zur Aufrechterhaltung der angegebenen CPU-Auslastung verwendet werden.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>Die maximale Anzahl von bereitgestellten Pods, die zur Aufrechterhaltung der angegebenen CPU-Auslastung verwendet werden.</td>
    </tr>
    </tbody></table>


<br />


## Laufende Bereitstellungen verwalten
{: #app_rolling}

Sie können den Rollout Ihrer Änderungen auf eine automatisierte und gesteuerte Art verwalten. Wenn der Rollout nicht nach Plan verläuft, können Sie die Bereitstellung auf die vorherige Revision rückgängig machen.
{:shortdesc}

Erstellen Sie zunächst eine [Bereitstellung](#app_cli).

1.  [Implementieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout) Sie eine Änderung. Beispiel: Sie möchten das Image ändern, das Sie in Ihrer ursprünglichen Bereitstellung verwendet haben.

    1.  Rufen Sie den Namen der Bereitstellung ab.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Rufen Sie den Namen des Pods ab.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Rufen Sie den Namen des Containers ab, der im Pod ausgeführt wird.

        ```
        kubectl describe pod <podname>
        ```
        {: pre}

    4.  Legen Sie das neue Image fest, das für die Bereitstellung verwendet werden soll.

        ```
        kubectl set image deployment/<bereitstellungsname><containername>=<imagename>
        ```
        {: pre}

    Wenn Sie die Befehle ausführen, wird die Änderung unverzüglich angewendet und im Rolloutprotokoll protokolliert.

2.  Überprüfen Sie den Status der Bereitstellung.

    ```
    kubectl rollout status deployments/<bereitstellungsname>
    ```
    {: pre}

3.  Machen Sie die Änderung rückgängig.
    1.  Zeigen Sie das Rolloutprotokoll für die Bereitstellung an und ermitteln Sie die Revisionsnummer Ihrer letzten Bereitstellung.

        ```
        kubectl rollout history deployment/<bereitstellungsname>
        ```
        {: pre}

        **Tipp:** Schließen Sie zum Anzeigen der Details für eine bestimmte Revision die Revisionsnummer ein.

        ```
        kubectl rollout history deployment/<bereitstellungsname> --revision=<nummer>
        ```
        {: pre}

    2.  Führen Sie ein Rollback auf die frühere Version durch oder geben Sie eine Revision an. Verwenden Sie für das Rollback auf die frühere Version den folgenden Befehl.

        ```
        kubectl rollout undo deployment/<bereitstellungsname> --to-revision=<nummer>
        ```
        {: pre}

<br />

