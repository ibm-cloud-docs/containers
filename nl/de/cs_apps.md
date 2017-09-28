---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-13"

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
{: #cs_apps}

Sie können Kubernetes-Verfahren verwenden, um Apps bereitzustellen und sicherzustellen, dass Ihre Apps ununterbrochen betriebsbereit sind. Sie können beispielsweise rollierende Aktualisierungen und Rollbacks ausführen, ohne dass Ihren Benutzern hierdurch Ausfallzeiten entstehen. {:shortdesc}

Das Bereitstellen einer App umfasst üblicherweise die folgenden Schritte.

1.  [Installieren Sie die CLIs](cs_cli_install.html#cs_cli_install).

2.  Erstellen Sie ein Konfigurationsscript für Ihre App. [Verschaffen Sie sich einen Überblick über die Best Practices von Kubernetes. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  Verwenden Sie eine der folgenden Methoden, um das Konfigurationsscript auszuführen.
    -   [Kubernetes-CLI](#cs_apps_cli)
    -   Kubernetes-Dashboard
        1.  [Starten Sie das Kubernetes-Dashboard.](#cs_cli_dashboard)
        2.  [Führen Sie das Konfigurationsscript aus. ](#cs_apps_ui)


## Kubernetes-Dashboard starten
{: #cs_cli_dashboard}

Öffnen Sie auf Ihrem lokalen System ein Kubernetes-Dashboard, um Informationen zu einem Cluster und seinen Workerknoten anzuzeigen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.
Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_cluster.html#access_ov) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_cluster.html#view_access).

Sie können den Standardport verwenden oder einen eigenen Port festlegen, um das Kubernetes-Dashboard für einen Cluster zu starten.
-   Starten Sie Ihr Kubernetes-Dashboard über den Standardport 8001.
    1.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
        {: pre}

        Die Ausgabe in der Befehlszeilenschnittstelle sieht wie folgt aus: 

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Öffnen Sie die folgende URL in einem Web-Browser, damit das Kubernetes-Dashboard angezeigt wird.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   Starten Sie Ihr Kubernetes-Dashboard über Ihren eigenen Port.
    1.  Legen Sie eine eigene Portnummer für den Proxy fest.

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  Öffnen Sie die folgende URL in einem Browser.

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


Wenn Sie die Arbeit im Kubernetes-Dashboard beendet haben, beenden Sie den Befehl `proxy` mit der Tastenkombination `STRG + C`.

## Öffentlichen Zugriff auf Apps zulassen
{: #cs_apps_public}

Um eine App öffentlich zugänglich zu machen, müssen Sie vor der Bereitstellung der App in einem Cluster Ihr Konfigurationsskript aktualisieren. {:shortdesc}

Je nachdem, ob Sie einen Lite-Cluster oder einen Standardcluster erstellt haben, gibt es verschiedene Möglichkeiten, den Zugriff auf Ihre App vom Internet aus zu ermöglichen. 

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">Service vom Typ 'NodePort'</a> (Lite- und Standardcluster)</dt>
<dd>Machen Sie auf jedem Workerknoten einen öffentlichen Port zugänglich und verwenden Sie die öffentliche IP-Adresse der einzelnen Workerknoten, um öffentlich auf Ihren Service im Cluster zuzugreifen. Die öffentliche IP-Adresse des Workerknotens ist nicht permanent. Wird ein Workerknoten entfernt oder neu erstellt, so wird ihm eine neue öffentliche IP-Adresse zugewiesen. Sie können den Service vom Typ 'NodePort' verwenden, wenn Sie den öffentlichen Zugriff auf Ihre App testen möchten oder der öffentliche Zugriff nur über einen beschränkten Zeitraum erforderlich ist. Wenn Sie eine gleich bleibende öffentliche IP-Adresse und ein höheres Maß an Verfügbarkeit für Ihren Serviceendpunkt benötigen, sollten Sie Ihre App über einen Service vom Typ 'LoadBalancer' oder über Ingress verfügbar machen.</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">Service vom Typ 'LoadBalancer'</a> (nur Standardcluster)</dt>
<dd>Jeder Standardcluster wird mit 4 portierbaren öffentlichen IP-Adressen bereitgestellt, mit denen Sie eine externe TCP-/UDP-Lastausgleichsfunktion (Load Balancer) für Ihre App erstellen können. Diese Lastausgleichsfunktion kann durch Offenlegung jedes beliebigen Ports, den Ihre App benötigt, entsprechend angepasst werden. Die der Lastausgleichsfunktion zugewiesene portierbare öffentliche IP-Adresse ist dauerhaft und ändert sich nicht, wenn im Cluster ein Workerknoten neu erstellt wird.

</br>
Falls Sie HTTP- oder HTTPS-Lastausgleich für Ihre App benötigen und eine einzige öffentliche Route verwenden wollen, um mehrere Apps in Ihrem Cluster als Services zugänglich zu machen, sollten Sie die in {{site.data.keyword.containershort_notm}} integrierte Ingress-Unterstützung nutzen.</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (nur Standardcluster)</dt>
<dd>Sie können mehrere Apps in ihrem Cluster öffentlich zugänglich machen, indem Sie eine einzelne externe HTTP- oder HTTPS-Lastausgleichsfunktion (Load Balancer) erstellen, die einen geschützten und eindeutigen Einstiegspunkt für die Weiterleitung eingehender Anforderungen an Ihre Apps verwendet. Ingress besteht aus zwei Hauptkomponenten, der Ingress-Ressource und dem Ingress-Controller. Die Ingress-Ressource definiert die Regeln,
die festlegen, wie die Weiterleitung der eingehenden Anforderungen für eine App und deren Lastausgleich erfolgen soll. Alle Ingress-Ressourcen müssen bei dem Ingress-Controller registriert sein, der für eingehende HTTP- oder HTTPS-Serviceanforderungen empfangsbereit ist und die Weiterleitung auf der Grundlage der für jede Ingress-Ressource definierten Regeln durchführt.
Verwenden Sie Ingress, wenn Sie ihre eigene Lastausgleichsfunktion mit angepassten Regeln für die Weiterleitung implementieren möchten und wenn Sie SSL-Terminierung für Ihre Apps benötigen.

</dd></dl>

### Öffentlichen Zugriff auf eine App durch Verwenden des Servicetyps 'NodePort' konfigurieren
{: #cs_apps_public_nodeport}

Sie können Ihre App öffentlich zugänglich machen, indem Sie die öffentliche IP-Adresse eines beliebigen Workerknotens in einem Cluster verwenden und einen Knotenport zugänglich machen. Verwenden Sie diese Option zum Testen und zur Bereitstellung von öffentlichem Zugriff über einen kurzen Zeitraum.
{:shortdesc}

Sie können Ihre App für Lite-Cluster oder Standardcluster als Kubernetes-Service vom Typ 'NodePort' verfügbar machen. 

Für {{site.data.keyword.Bluemix_notm}} Dedicated-Umgebungen sind öffentliche IP-Adressen durch eine Firewall blockiert. Machen Sie eine App stattdessen mithilfe eines [Service vom Typ 'LoadBalancer'](#cs_apps_public_load_balancer) oder über [Ingress](#cs_apps_public_ingress) öffentlich verfügbar. 

**Hinweis:** Die öffentliche IP-Adresse eines Workerknotens ist nicht permanent. Muss ein Workerknoten neu erstellt werden, so wird ihm eine neue öffentliche IP-Adresse zugewiesen. Wenn Sie eine gleich bleibende öffentliche IP-Adresse und ein höheres Maß an Verfügbarkeit für Ihren Service benötigen, sollten Sie Ihre App über einen [Service vom Typ 'LoadBalancer'](#cs_apps_public_load_balancer)
oder über [Ingress](#cs_apps_public_ingress) verfügbar machen.




1.  Definieren Sie einen [Service![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/service/)abschnitt im Konfigurationsscript. 
2.  Fügen Sie im Abschnitt `spec` für den Service den Typ 'NodePort' hinzu. 

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  Optional: Fügen Sie im Abschnitt `ports` einen Eintrag 'NodePort' hinzu und legen Sie für diesen eine Portnummer aus dem Bereich 30000-32767 fest. Geben Sie für 'NodePort' keine Portnummer an, die bereits von einem anderen Service verwendet wird. Falls Sie nicht sicher sind, welche Knotenportnummern bereits belegt sind, verzichten Sie auf die Zuweisung einer Portnummer, denn diese Angabe ist nicht obligatorisch. Wenn manuell keine Knotenportnummer festgelegt wird, so erfolgt die Zuweisung automatisch nach dem Zufallsprinzip.

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    Wenn Sie für 'NodePort' eine Portnummer festlegen möchten und ermitteln wollen, welche Knotenportnummern bereits belegt sind, führen Sie den folgenden Befehl aus.

    ```
    kubectl get svc
    ```
    {: pre}

    Ausgabe:

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    meine_app          10.10.10.83    <knoten>       80:31513/TCP   28s
    redis-master   10.10.10.160   <keine>        6379/TCP       28s
    redis-slave    10.10.10.194   <keine>        6379/TCP       28s
    ```
    {: screen}

4.  Speichern Sie die Änderungen.
5.  Wiederholen Sie diesen Vorgang, um für jede App einen Service zu erstellen.

    Beispiel:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: mein_knotenport-service
      labels:
        run: meine_demo
    spec:
      selector:
        run: meine_demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**Womit möchten Sie fortfahren?**

Bei Bereitstellung der App können Sie mithilfe der öffentlichen IP-Adresse jedes beliebigen Workerknotens und der für 'NodePort' festgelegten Portnummer die öffentliche URL erzeugen, mit der in einem Browser auf die App zugegriffen werden kann.

1.  Rufen Sie die öffentliche IP-Adresse für einen Workerknoten im Cluster ab.

    ```
    bx cs workers <clustername>
    ```
    {: pre}

    Ausgabe:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
    ```
    {: screen}

2.  Falls für 'NodePort' nach dem Zufallsprinzip Portnummern zugewiesen wurden, ermitteln Sie eine Portnummer, die auf diese Art festgelegt wurde.

    ```
    kubectl describe service <servicename>
    ```
    {: pre}

    Ausgabe:

    ```
    Name:                   <servicename>
    Namespace:              default
    Labels:                 run=<bereitstellungsname>
    Selector:               run=<bereitstellungsname>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    In diesem Beispiel lautet die Portnummer für 'NodePort' `30872`. 

3.  Bilden Sie die URL mit einer der öffentlichen IP-Adressen des Workerknotens und der Portnummer für 'NodePort'. Beispiel: `http://192.0.2.23:30872`

### Öffentlichen Zugriff auf eine App durch Verwenden des Servicetyps 'LoadBalancer' konfigurieren
{: #cs_apps_public_load_balancer}

Machen Sie einen Port zugänglich und verwenden Sie eine portierbare öffentliche IP-Adresse für die Lastausgleichsfunktion (Load Balancer),
um auf die App zuzugreifen. Anders als beim Service 'NodePort' hängt die portierbare öffentliche IP-Adresse des Service für den Lastausgleich nicht von dem Workerknoten ab, auf dem die App bereitgestellt wird. Die portierbare öffentliche IP-Adresse der Lastausgleichsfunktion (Load Balancer) wird Ihnen zugewiesen und bleibt unverändert erhalten, wenn Sie Workerknoten hinzufügen oder entfernen. Das bedeutet, dass Services für die Lastausgleichsfunktion eine höhere Verfügbarkeit aufweisen als Services vom Typ 'NodePort'. Benutzer können für die Lastausgleichsfunktion jeden beliebigen Port auswählen und sind nicht auf den Portbereich für 'NodePort' beschränkt. Services vom Typ 'LoadBalancer' können für TCP- und UDP-Protokolle verwendet werden.

Wenn ein {{site.data.keyword.Bluemix_notm}} Dedicated-Konto [für Cluster aktiviert](cs_ov.html#setup_dedicated) ist, können Sie anfordern, dass öffentliche Teilnetze für Lastausgleichs-IP-Adressen verwendet werden. [Öffnen Sie ein Support-Ticket](/docs/support/index.html#contacting-support), um das Teilnetz zu erstellen, und verwenden Sie dann den Befehl [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add), um dem Cluster das Teilnetz hinzuzufügen. 

**Hinweis:** Von den Services für die Lastausgleichsfunktion wird die TLS-Terminierung nicht unterstützt. Falls für Ihre App die TLS-Terminierung erforderlich ist, können Sie Ihre App über [Ingress](#cs_apps_public_ingress) verfügbar machen oder die TLS-Terminierung für die App konfigurieren.

Vorbemerkungen:

-   Dieses Feature ist nur für Standardcluster verfügbar.
-   Es muss eine portierbare öffentliche IP-Adresse verfügbar sein, die Sie dem Service für Lastausgleich (Load Balancer) zuweisen können.

Gehen Sie wie folgt vor, um einen Service für die Lastausgleichsfunktion zu erstellen:

1.  [Stellen Sie dem Cluster die App bereit. ](#cs_apps_cli) Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt des Konfigurationsscripts eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Service für die App, den Sie öffentlich zugänglich machen möchten. Damit Ihre App im öffentlichen Internet verfügbar wird, müssen Sie einen Kubernetes-Service für die App erstellen und den Service so konfigurieren, dass alle Pods, aus denen die App besteht, in den Lastenausgleich eingeschlossen sind.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Servicekonfigurationsscript namens `myloadbalancer.yaml` (Beispiel).
    2.  Definieren Sie einen Lastenausgleichsservice für die App, die Sie öffentlich zugänglich machen möchten.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          type: LoadBalancer
          selector:
            <selektorschlüssel>:<selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen für Ihren Lastenausgleichsservice.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
         </tr>
         <td><code>port</code></td>
         <td>Der Port, den der Service überwacht.</td>
         </tbody></table>
    3.  Optional: Wenn Sie eine bestimmte portierbare öffentliche IP-Adresse für die Lastausgleichsfunktion verwenden möchten, die für Ihren Cluster zur Verfügung steht, können Sie diese IP-Adresse angeben, indem Sie `loadBalancerIP` im Spezifikationsabschnitt einfügen. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/service/).

    4.  Optional: Durch Angabe von `loadBalancerSourceRanges` im Spezifikationsabschnitt können Sie eine Firewall konfigurieren. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    5.  Speichern Sie Ihre Änderungen.
    6.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Wenn der Lastenausgleichsservice erstellt wird, wird der Lastenausgleichsfunktion automatisch eine portierbare öffentliche IP-Adresse zugeordnet. Ist keine portierbare öffentliche IP-Adresse verfügbar, schlägt die Erstellung Ihres Lastenausgleichsservice fehl.
3.  Stellen Sie sicher, dass der Lastenausgleichsservice erstellt wurde. Ersetzen Sie _&lt;mein_service&gt;_ durch den Namen des Lastenausgleichsservice, den Sie im vorherigen Schritt erstellt haben.

    ```
    kubectl describe service <mein_service>
    ```
    {: pre}

    **Hinweis:** Es kann ein paar Minuten dauern, bis der Lastenausgleichsservice ordnungsgemäß erstellt und die App im öffentlichen Internet verfügbar ist. 

    Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:

    ```
    Name:                   <mein_service>
    Namespace:              default
    Labels:                 <keine>
    Selector:               <selektorschlüssel>=<selektorwert>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    Die IP-Adresse für **LoadBalancer Ingress** ist die portierbare öffentliche IP-Adresse, die dem Lastenausgleichsservice zugeordnet wurde.
4.  Greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die portierbare öffentliche IP-Adresse der Lastausgleichsfunktion und des Ports ein. Im obigen Beispiel wurde dem Service für die Lastausgleichsfunktion die portierbare öffentliche IP-Adresse `192.168.10.38` zugeordnet.


        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### Öffentlichen Zugriff auf eine App durch Verwenden des Ingress-Controllers konfigurieren
{: #cs_apps_public_ingress}

Sie können mehrere Apps öffentlich zugänglich machen, indem Sie Ingress-Ressourcen erstellen, die vom durch IBM bereitgestellten Ingress-Controller verwaltet werden. Der Ingress-Controller ist eine externe HTTP- oder HTTPS-Lastausgleichsfunktion, die einen geschützten und eindeutigen öffentlichen Einstiegspunkt für die Weiterleitung
eingehender Anforderungen an Ihre Apps innerhalb und außerhalb Ihres Clusters verwendet. 

**Hinweis:** Ingress ist nur für Standardcluster verfügbar und erfordert mindestens zwei Workerknoten im Cluster, um eine hohe Verfügbarkeit zu
gewährleisten. 

Wenn Sie einen Standardcluster erstellen, wird automatisch ein Ingress-Controller für Sie erstellt und diesem eine portierbare öffentliche IP-Adresse und eine öffentliche Route zugewiesen. Sie können den Ingress-Controller konfigurieren und individuelle Weiterleitungsregeln für jede App definieren, die Sie öffentlich zugänglich machen. Jeder App, die über Ingress zugänglich gemacht wird, ist ein eindeutiger Pfad zugewiesen, der an die öffentliche Route angehängt wird, sodass Sie eine eindeutige URL verwenden können, um öffentlich auf eine App in Ihrem Cluster zuzugreifen.

Wenn ein {{site.data.keyword.Bluemix_notm}} Dedicated-Konto [für Cluster aktiviert](cs_ov.html#setup_dedicated) ist, können Sie anfordern, dass öffentliche Teilnetze für Ingress-Controller-IP-Adressen verwendet werden. Anschließend werden der Ingress-Controller erstellt und eine öffentliche Route zugeordnet. [Öffnen Sie ein Support-Ticket](/docs/support/index.html#contacting-support), um das Teilnetz zu erstellen, und verwenden Sie dann den Befehl [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add), um dem Cluster das Teilnetz hinzuzufügen. 

Sie können den Ingress-Controller für die folgenden Szenarios konfigurieren.

-   [Von IBM bereitgestellte Domäne ohne TLS-Terminierung verwenden](#ibm_domain)
-   [Von IBM bereitgestellte Domäne mit TLS-Terminierung verwenden](#ibm_domain_cert)
-   [Angepasste Domäne und TLS-Zertifikat für TLS-Terminierung verwenden](#custom_domain_cert)
-   [Von IBM bereitgestellte oder angepasste Domäne mit TLS-Terminierung für den Zugriff auf Apps außerhalb Ihres Clusters verwenden](#external_endpoint)
-   [Ingress-Controller mit Annotationen anpassen](#ingress_annotation)

#### Von IBM bereitgestellte Domäne ohne TLS-Terminierung verwenden
{: #ibm_domain}

Sie können den Ingress-Controller als HTTP-Lastausgleichsfunktion für die Apps in Ihrem Cluster konfigurieren und die von IBM bereitgestellte Domäne für den Zugriff auf Ihre Apps über das Internet verwenden.

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie
einen Standardcluster](cs_cluster.html#cs_cluster_ui).
-   [Richten Sie Ihre
CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, kubectl-Befehle auszuführen.

Gehen Sie wie folgt vor, um den Ingress-Controller zu konfigurieren:

1.  [Stellen Sie dem Cluster die App bereit. ](#cs_apps_cli) Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt des Konfigurationsscripts eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Ingress-Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Vom Ingress-Controller kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Servicekonfigurationsscript namens `myservice.yaml` (Beispiel).
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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen für Ihren Lastenausgleichsservice.</td>
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
    5.  Wiederholen Sie diese Schritte für jede App, die Sie öffentlich zugänglich machen möchten.
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
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibm-domäne>
    Ingress secret:  <geheimer_tls-schlüssel_von_ibm>
    Workers:  3
    ```
    {: screen}

    Die von IBM bereitgestellte Domäne ist im Feld für die Ingress-Unterdomäne (**Ingress subdomain**) angegeben.
4.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden vom Ingress-Controller verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie können eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, solange jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Ingress-Konfigurationsscript namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrem Konfigurationsscript, die die von IBM bereitgestellte Domäne für das Weiterleiten von eingehendem Netzverkehr an den zuvor erstellten Service verwendet.

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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;ibm-domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. 

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (*) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br></br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.
        </br>
        Beispiel: <ul><li>Geben Sie für <code>http://ingress-hostname/</code> <code>/</code> als Pfad ein. </li><li>Geben Sie für <code>http://ingress-hostname/mein_servicepfad</code> <code>/mein_servicepfad</code> als Pfad ein. </li></ul>
        </br>
        <strong>Tipp:</strong> Wenn Sie Ingress für die Überwachung eines Pfads konfigurieren möchten, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit <a href="#rewrite" target="_blank">Annotation neu schreiben</a> eine richtige Weiterleitung an Ihre App einrichten. </td>
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

5.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie _&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

  **Hinweis:** Es kann ein paar Minuten dauern, bis die Ingress-Ressource erstellt und die App im öffentlichen Internet verfügbar ist. 
6.  Geben Sie in einem Web-Browser die URL des App-Service an, auf den zugegriffen werden soll.

    ```
    http://<ibm-domäne>/<mein_servicepfad1>
    ```
    {: codeblock}


#### Von IBM bereitgestellte Domäne mit TLS-Terminierung verwenden
{: #ibm_domain_cert}

Sie können den Ingress-Controller so konfigurieren, dass eingehende TLS-Verbindungen für Ihre Apps verwaltet, der Netzverkehr mithilfe des von IBM bereitgestellten TLS-Zertifikats entschlüsselt und die nicht verschlüsselte Anforderung an die Apps weitergeleitet wird, die in Ihrem Cluster zugänglich sind.

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_cluster.html#cs_cluster_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.

Gehen Sie wie folgt vor, um den Ingress-Controller zu konfigurieren:

1.  [Stellen Sie dem Cluster die App bereit. ](#cs_apps_cli) Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt des Konfigurationsscripts eine Bezeichnung hinzufügen. Diese Bezeichnung identifiziert alle Pods, in denen Ihre App ausgeführt wird, damit die Pods in den Ingress-Lastenausgleich aufgenommen werden können. 
2.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Vom Ingress-Controller kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Servicekonfigurationsscript namens `myservice.yaml` (Beispiel).
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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch einen Namen für Ihren Kubernetes-Service. </td>
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

    5.  Wiederholen Sie diese Schritte für jede App, die Sie öffentlich zugänglich machen möchten.

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
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibm-domäne>
    Ingress secret:  <geheimer_tls-schlüssel_von_ibm>
    Workers:  3
    ```
    {: screen}

    Die von IBM bereitgestellte Domäne ist im Feld für die Unterdomäne (**Ingress-Unterdomäne**) und das von IBM bereitgestellte Zertifikat im Feld für den geheimen Ingress-Schlüssel (**Ingress secret**) angegeben.

4.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden vom Ingress-Controller verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie können eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, solange jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Ingress-Konfigurationsscript namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrem Konfigurationsscript, die die von IBM bereitgestellte Domäne für das Weiterleiten von eingehendem Netzverkehr an Ihre Services und das von IBM bereitgestellte Zertifikat für die Verwaltung der TLS-Terminierung verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://ingress-domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service und sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird.

        **Hinweis:** Die App muss den Pfad überwachen, den Sie in der Ingress-Ressource angegeben haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als `/` und geben keinen individuellen Pfad für Ihre App an.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
        spec:
          tls:
          - hosts:
            - <ibm-domäne>
            secretName: <geheimer_tls-schlüssel_von_ibm>
          rules:
          - host: <ibm-domäne>
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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch einen Namen für Ihre Ingress-Ressource.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Ersetzen Sie <em>&lt;ibm-domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;geheimer_tls-schlüssel_von_ibm&gt;</em> durch den von IBM bereitgestellten Namen des <strong>geheimen Ingress-Schlüssels</strong> aus dem vorherigen Schritt. Mithilfe dieses Zertifikats wird die TLS-Terminierung verwaltet. </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;ibm-domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br>
        Beispiel: <ul><li>Geben Sie für <code>http://ingress-hostname/</code> <code>/</code> als Pfad ein. </li><li>Geben Sie für <code>http://ingress_hostname/mein_servicepfad</code> <code>/mein_servicepfad</code> als Pfad ein. </li></ul>
        <strong>Tipp:</strong> Wenn Sie Ingress für die Überwachung eines Pfads konfigurieren möchten, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit <a href="#rewrite" target="_blank">Annotation neu schreiben</a> eine richtige Weiterleitung an Ihre App einrichten. </td>
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

    **Hinweis:** Es kann ein paar Minuten dauern, bis die Ingress-Ressource ordnungsgemäß erstellt und die App im öffentlichen Internet verfügbar ist.
6.  Geben Sie in einem Web-Browser die URL des App-Service an, auf den zugegriffen werden soll.

    ```
    https://<ibm-domäne>/<mein_servicepfad1>
    ```
    {: codeblock}

#### Ingress-Controller mit einer angepassten Domäne und einem TLS-Zertifikat verwenden
{: #custom_domain_cert}

Sie können den Ingress-Controller zum Weiterleiten von eingehendem Netzverkehr an die Apps in Ihrem Cluster verwenden und Ihr eigenes TLS-Zertifikat zum Verwalten der TLS-Terminierung nutzen, wobei Sie statt der von IBM bereitgestellten Domäne Ihre angepasste Domäne verwenden.
{:shortdesc}

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie
einen Standardcluster](cs_cluster.html#cs_cluster_ui).
-   [Richten Sie Ihre
CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, kubectl-Befehle auszuführen.

Gehen Sie wie folgt vor, um den Ingress-Controller zu konfigurieren:

1.  Erstellen Sie eine angepasste Domäne. Zum Erstellen einer angepassten Domäne arbeiten Sie mit Ihrem DNS-Provider (Domain Name Service), um Ihre angepasste Domäne zu registrieren. 
2.  Konfigurieren Sie Ihre Domäne, um eingehenden Netzverkehr an den IBM Ingress-Controller weiterzuleiten. Wählen Sie zwischen diesen Optionen: 
    -   Definieren Sie einen Alias für Ihre angepasste Domäne, indem Sie die von IBM bereitgestellte Domäne als kanonischen Namensdatensatz (CNAME) angeben. Sie finden die von IBM bereitgestellte Ingress-Domäne, indem Sie `bx cs cluster-get <mein_cluster>` ausführen und nach dem Feld für die Ingress-Unterdomäne (**Ingress subdomain**) suchen. 
    -   Ordnen Sie Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse des von IBM bereitgestellten Ingress-Controllers zu, indem Sie die IP-Adresse als Zeigerdatensatz (PTR) hinzufügen. Gehen Sie wie folgt vor, um die portierbare öffentliche IP-Adresse des Ingress-Controllers zu suchen:
        1.  Führen Sie `bx cs cluster-get <mein_cluster>` aus und suchen Sie nach dem Feld für die Ingress-Unterdomäne (**Ingress subdomain**). 
        2.  Führen Sie `nslookup <Ingress subdomain>` aus.
3.  Erstellen Sie ein TLS-Zertifikat und einen Schlüssel für Ihre Domäne, der im base64-Format codiert ist.
4.  Speichern Sie Ihr TLS-Zertifikat und den Schlüssel in einem geheimen Kubernetes-Schlüssel.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Konfigurationsscript für den geheimen Kubernetes-Schlüssel namens `mysecret.yaml` (Beispiel).
    2.  Definieren Sie einen geheimen Schlüssel, der Ihr TLS-Zertifikat und Ihren Schlüssel verwendet. 

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mein_geheimer_tls-schlüssel>
        type: Opaque
        data:
          tls.crt: <tls-zertifikat>
          tls.key: <tls-schlüssel>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_geheimer_tls-schlüssel&gt;</em> durch den Namen für Ihren geheimen Kubernetes-Schlüssel.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Ersetzen Sie <em>&lt;tls-zertifikat&gt;</em> durch Ihr angepasstes TLS-Zertifikat, das im base64-Format codiert ist.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Ersetzen Sie <em>&lt;tls-schlüssel&gt;</em> durch Ihren angepassten TLS-Schlüssel, der im base64-Format codiert ist.</td>
         </tbody></table>

    3.  Speichern Sie Ihr Konfigurationsscript.
    4.  Erstellen Sie den geheimen TLS-Schlüssel für Ihren Cluster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Stellen Sie dem Cluster die App bereit. ](#cs_apps_cli) Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt des Konfigurationsscripts eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Ingress-Lastenausgleich aufgenommen werden können.

6.  Erstellen Sie einen Kubernetes-Service für die App, die öffentlich zugänglich gemacht werden soll. Vom Ingress-Controller kann Ihre App nur in den Ingress-Lastenausgleich eingeschlossen werden, wenn die App über einen Kubernetes-Service im Cluster öffentlich zugänglich gemacht wurde.

    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Servicekonfigurationsscript namens `myservice.yaml` (Beispiel).
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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_service1&gt;</em> durch einen Namen für Ihren Kubernetes-Service.</td>
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

    5.  Wiederholen Sie diese Schritte für jede App, die Sie öffentlich zugänglich machen möchten.
7.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden vom Ingress-Controller verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie können eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere Apps zu definieren, solange jede App über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Ingress-Konfigurationsscript namens `myingress.yaml` (Beispiel).
    2.  Definieren Sie eine Ingress-Ressource in Ihrem Konfigurationsscript, die Ihre angepasste Domäne für das Weiterleiten von eingehendem Netzverkehr an Ihre Services und Ihr angepasstes Zertifikat für die Verwaltung der TLS-Terminierung verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an Ihre angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://meine_domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service und sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird.

        **Hinweis:** Es ist wichtig, dass die App den Pfad überwacht, den Sie in der Ingress-Ressource angegeben haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als
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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
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
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_geheimer_tls-schlüssel&gt;</em> durch den Namen des geheimen Schlüssels, den Sie zuvor erstellt haben und der Ihr angepasstes TLS-Zertifikat sowie den Schlüssel für die Verwaltung der TLS-Terminierung für Ihre angepasste Domäne enthält.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Ersetzen Sie <em>&lt;meine_angepasste_domäne&gt;</em> durch die angepasste Domäne, die Sie für TLS-Terminierung konfigurieren möchten. 

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_servicepfad1&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die App weitergeleitet werden kann.

        </br>
Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>ingress-domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service. Er sendet Netzverkehr an ihn und dann weiter an die Pods, in denen die App ausgeführt wird, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz zu erhalten.

        </br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br></br>
        Beispiel: <ul><li>Geben Sie für <code>https://meine_angepasste_domäne/</code> <code>/</code> als Pfad an. </li><li>Geben Sie für <code>https://meine_angepasste_domäne/mein_servicepfad</code> <code>/mein_servicepfad</code> als Pfad ein. </li></ul>
        <strong>Tipp:</strong> Wenn Sie Ingress für die Überwachung eines Pfads konfigurieren möchten, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit <a href="#rewrite" target="_blank">Annotation neu schreiben</a> eine richtige Weiterleitung an Ihre App einrichten. </td>
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

8.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie _&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    **Hinweis:** Es kann ein paar Minuten dauern, bis die Ingress-Ressource ordnungsgemäß erstellt und die App im öffentlichen Internet verfügbar ist.


9.  Greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die URL des App-Service an, auf den zugegriffen werden soll.

        ```
        https://<meine_angepasste_domäne>/<mein_servicepfad1>
        ```
        {: codeblock}


#### Ingress-Controller zum Weiterleiten von Netzverkehr an Apps außerhalb des Clusters konfigurieren
{: #external_endpoint}

Sie können den Ingress-Controller so konfigurieren, dass Apps, die sich außerhalb des Clusters befinden, beim Lastausgleich des Clusters berücksichtigt werden. Eingehende Anforderungen an die von IBM bereitgestellte oder Ihre angepasste Domäne werden automatisch an die externe App weitergeleitet.

Vorbemerkungen:

-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_cluster.html#cs_cluster_ui).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.
-   Stellen Sie sicher, dass auf die externe App, die Sie beim Lastausgleich des Clusters berücksichtigen möchten, über eine öffentliche IP-Adresse zugegriffen werden kann. 

Sie können den Ingress-Controller für das Weiterleiten von eingehendem Netzverkehr in der von IBM bereitgestellten Domäne an Apps konfigurieren, die sich außerhalb Ihres Clusters befinden. Wenn Sie stattdessen eine angepasste Domäne und ein TLS-Zertifikat verwenden möchten, ersetzen Sie die von IBM bereitgestellte Domäne und das TLS-Zertifikat durch Ihre [angepasste Domäne und das TLS-Zertifikat](#custom_domain_cert). 

1.  Konfigurieren Sie einen Kubernetes-Endpunkt, der den externen Standort der App definiert, die Sie beim Lastausgleich des Clusters berücksichtigen möchten.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Endpunktkonfigurationsscript namens `myexternalendpoint.yaml` (Beispiel). 
    2.  Definieren Sie Ihren externen Endpunkt. Schließen Sie alle öffentlichen IP-Adressen und Ports ein, über die Sie auf Ihre externen App zugreifen können.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <mein_endpunktname>
        subsets:
          - addresses:
              - ip: <externe_IP1>
              - ip: <externe_IP2>
            ports:
              - port: <externer_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_endpunktname&gt;</em> durch den Namen Ihres Kubernetes-Endpunkt.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Ersetzen Sie <em>&lt;externe_IP&gt;</em> durch die öffentlichen IP-Adressen für die Verbindung mit Ihrer externen App. </td>
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

2.  Erstellen Sie einen Kubernetes-Service für Ihren Cluster und konfigurieren Sie ihn so, dass er eingehende Anforderungen an den externen Endpunkt weiterleitet, den Sie zuvor erstellt haben.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Servicekonfigurationsscript namens `myexternalservice.yaml` (Beispiel). 
    2.  Definieren Sie den Service.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_externer_service>
          labels:
              name: <mein_endpunktname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_externer_service&gt;</em> durch den Namen für Ihren Kubernetes-Service. </td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_endpunktname&gt;</em> durch den Namen des Kubernetes-Endpunkt, den Sie zuvor erstellt haben.</td>
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
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibm-domäne>
    Ingress secret:  <geheimer_tls-schlüssel_von_ibm>
    Workers:  3
    ```
    {: screen}

    Die von IBM bereitgestellte Domäne ist im Feld für die Unterdomäne (**Ingress-Unterdomäne**) und das von IBM bereitgestellte Zertifikat im Feld für den geheimen Ingress-Schlüssel (**Ingress secret**) angegeben.

4.  Erstellen Sie eine Ingress-Ressource. Ingress-Ressourcen definieren die Routing-Regeln für den Kubernetes-Service, den Sie für Ihre App erstellt haben; sie werden vom Ingress-Controller verwendet, um eingehenden Netzverkehr zum Cluster weiterzuleiten. Sie können eine Ingress-Ressource verwenden, um Routing-Regeln für mehrere externe Apps zu definieren, solange jede App mit ihrem externen Endpunkt über einen Kubernetes-Service im Cluster zugänglich gemacht wird.
    1.  Öffnen Sie Ihren bevorzugten Editor und erstellen Sie ein Ingress-Konfigurationsscript namens `myexternalingress.yaml` (Beispiel). 
    2.  Definieren Sie eine Ingress-Ressource in Ihrem Konfigurationsscript, die die von IBM bereitgestellte Domäne und das TLS-Zertifikat für das Weiterleiten von eingehendem Netzverkehr an Ihre externe App mithilfe des zuvor definierten externen Endpunkts verwendet. Für jeden Service können Sie einen individuellen Pfad definieren, der an die von IBM bereitgestellte Domäne oder die angepasste Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. `https://ingress-domäne/meine_app`. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service und sendet Netzverkehr an ihn und dann weiter an die externe App.

        **Hinweis:** Es ist wichtig, dass die App den Pfad überwacht, den Sie in der Ingress-Ressource angegeben haben. Andernfalls kann der Netzverkehr nicht an die App weitergeleitet werden. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als / und geben keinen individuellen Pfad für Ihre App an. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <mein_ingress-name>
        spec:
          tls:
          - hosts:
            - <ibm-domäne>
            secretName: <geheimer_tls-schlüssel_von_ibm>
          rules:
          - host: <ibm-domäne>
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
        <thead>
        <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Ersetzen Sie <em>&lt;mein_ingress-name&gt;</em> durch den Namen für die Ingress-Ressource. </td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Ersetzen Sie <em>&lt;ibm-domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Ersetzen Sie <em>&lt;geheimer_tls-schlüssel_von_ibm&gt;</em> durch den von IBM bereitgestellten <strong>geheimen Ingress-Schlüssel</strong> aus dem vorherigen Schritt. Mithilfe dieses Zertifikats wird die TLS-Terminierung verwaltet. </td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Ersetzen Sie <em>&lt;ibm-domäne&gt;</em> durch den von IBM im Feld für die Ingress-Unterdomäne (<strong>Ingress subdomain</strong>) bereitgestellten Namen aus dem vorherigen Schritt. Diese Domäne ist für TLS-Terminierung konfiguriert.

        </br></br>
        <strong>Hinweis:</strong> Verwenden Sie keine Sternchen (&ast;) für Ihren Host oder lassen Sie die Hosteigenschaft leer, um Fehler während der Ingress-Erstellung zu vermeiden. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Ersetzen Sie <em>&lt;mein_externer_servicepfad&gt;</em> durch einen Schrägstrich oder den eindeutigen Pfad, den Ihre Anwendung überwacht, sodass Netzverkehr an die externe App weitergeleitet werden kann. 

        </br>
Für jeden Kubernetes-Service können Sie einen individuellen Pfad definieren, der an Ihre Domäne angehängt wird, um einen eindeutigen Pfad zu Ihrer App zu erstellen, z. B. <code>https://ibm_domäne/mein_servicepfad1</code>. Wenn Sie diese Route in einen Web-Browser eingeben, wird der Netzverkehr an den Ingress-Controller weitergeleitet. Der Ingress-Controller sucht nach dem zugehörigen Service. Er sendet Netzverkehr an die externe App, indem derselbe Pfad verwendet wird. Die App muss so konfiguriert werden, dass dieser Pfad überwacht wird, um eingehenden Datenverkehr im Netz
zu erhalten.

        </br></br>
        Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. In diesem Fall definieren Sie den Rootpfad als <code>/</code> und geben keinen individuellen Pfad für Ihre App an.

        </br></br>
        <strong>Tipp:</strong> Wenn Sie Ingress für die Überwachung eines Pfads konfigurieren möchten, der von dem Pfad abweicht, den Ihre App überwacht, können Sie mit <a href="#rewrite" target="_blank">Annotation neu schreiben</a> eine richtige Weiterleitung an Ihre App einrichten. </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Ersetzen Sie <em>&lt;mein_externer_service1&gt;</em> durch den Namen des Service, den Sie beim Erstellen des Kubernetes-Service für Ihre externe App verwendet haben. </td>
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

5.  Überprüfen Sie, dass die Ingress-Ressource erfolgreich erstellt wurde. Ersetzen Sie _&lt;mein_ingress-name&gt;_ durch den Namen der Ingress-Ressource, die Sie zuvor erstellt haben.

    ```
    kubectl describe ingress <mein_ingress-name>
    ```
    {: pre}

    **Hinweis:** Es kann ein paar Minuten dauern, bis die Ingress-Ressource ordnungsgemäß erstellt und die App im öffentlichen Internet verfügbar ist.


6.  Greifen Sie auf Ihre externe App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die URL für den Zugriff auf Ihre externe App ein.

        ```
        https://<ibm-domäne>/<mein_externer_servicepfad>
        ```
        {: codeblock}


#### Unterstützte Ingress-Annotationen
{: #ingress_annotation}

Sie können Metadaten für Ihre Ingress-Ressource angeben, um Funktionen zu Ihrem Ingress-Controller hinzuzufügen.
{: shortdesc}

|Unterstützte Annotation|Beschreibung|
|--------------------|-----------|
|[Neu geschriebene Annotationen](#rewrite)|Eingehenden Netzverkehr an einen anderen Pfad weiterleiten, den Ihre Back-End-App überwacht. |
|[Sitzungsaffinität mit Cookies](#sticky_cookie)|Eingehenden Netzverkehr mithilfe eines permanenten Cookies immer an denselben Upstream-Server weiterleiten. |
|[Zusätzlicher Clientanforderungs- oder -antwortheader](#add_header)|Einer Clientanforderung zusätzliche Headerinformationen hinzufügen, bevor Sie die Anforderung an Ihre Back-End-App weiterleiten, bzw. einer Clientantwort, bevor Sie die Antwort an den Client senden.|
|[Entfernen des Clientantwortheaders](#remove_response_headers)|Headerinformationen aus einer Clientantwort entfernen, bevor die Antwort an den Client weitergeleitet wird.|
|[HTTP-Weiterleitungen an HTTPs](#redirect_http_to_https)|Unsichere HTTP-Anforderungen an Ihre Domäne an HTTPs weiterleiten.|
|[Pufferung von Clientantwortdaten](#response_buffer)|Pufferung einer Clientantwort auf dem Ingress-Controller inaktivieren. während die Antwort an den Client gesendet wird.|
|[Angepasste Verbindungs- und Lesezeitlimits](#timeout)|Wartezeit des Ingress-Controllers für das Verbinden mit und Lesen aus der Back-End-App, bis die Back-End-App als nicht verfügbar betrachtet wird, anpassen. |
|[Angepasste maximale Länge des Clientanforderungshauptteils](#client_max_body_size)|Länge des Clientanforderungshauptteils anpassen, die an den Ingress-Controller gesendet werden darf.|

##### **Eingehenden Netzverkehr an einen anderen Pfad durch eine neu geschriebene Annotation weiterleiten**
{: #rewrite}

Verwenden Sie die Annotation 'rewrite' zum erneuten Schreiben eines Pfads, um den eingehenden Netzverkehr für den Pfad in der Domäne eines Ingress-Controllers an einen anderen Pfad weiterzuleiten, an dem die Back-End-Anwendung empfangsbereit ist. {:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Die Domäne des Ingress-Controllers leitet eingehenden Netzverkehr für <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> an Ihre App weiter. Ihre App überwacht <code>/coffee</code> statt <code>/beans</code>. Zum Weiterleiten des eingehenden Netzverkehrs an Ihre App fügen Sie eine Annotation zum erneuten Schreiben (rewrite) zur Konfigurationsdatei der Ingress-Ressource hinzu, sodass der an <code>/beans</code> eingehende Netzverkehr mithilfe des Pfads <code>/coffee</code> an Ihre App weitergeleitet wird. Wenn Sie mehrere Services einschließen, verwenden Sie nur ein Semikolon (;) zum Trennen der Services. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;servicename1&gt; rewrite=&lt;neu_geschriebener_pfad1&gt;;serviceName=&lt;servicename2&gt; rewrite=&lt;neu_geschriebener_pfad2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domänenpfad1&gt;
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: &lt;serviceport1&gt;
      - path: /&lt;domänenpfad2&gt;
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: &lt;serviceport2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für Ihre App erstellt haben, und <em>&lt;neu_geschriebener_pfad&gt;</em> durch den Pfad, an dem Ihre App empfangsbereit ist. Der eingehende Netzverkehr in der Domäne des Ingress-Controllers wird mithilfe dieses Pfads an den Kubernetes-Service weitergeleitet. Die meisten Apps überwachen keinen bestimmten Pfad, sondern verwenden den Rootpfad und einen bestimmten Port. Definieren Sie in diesem Fall <code>/</code> als <em>&lt;neu_geschriebener_pfad&gt;</em> für Ihre App.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Ersetzen Sie <em>&lt;domänenpfad&gt;</em> durch den Pfad, den Sie zur Domäne des Ingress-Controllers hinzufügen möchten. Der für diesen Pfad eingehende Netzverkehr wird an den neu geschriebenen Pfad weitergeleitet, den Sie in der Annotation definiert haben. Im obigen Beispiel muss als Pfad der Domäne <code>/beans</code> festgelegt sein, damit dieser Pfad in den Lastenausgleich des Ingress-Controllers aufgenommen wird. </td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen des Kubernetes-Service, den Sie für die App erstellt haben. Der hier verwendete Servicename muss mit dem Namen identisch sein, den Sie in der Annotation definiert haben.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Ersetzen Sie <em>&lt;serviceport&gt;</em> durch den Port, an dem der Service empfangsbereit ist.</td>
</tr></tbody></table>

</dd></dl>


##### **Eingehenden Netzverkehr mithilfe eines permanenten Cookies immer an denselben Upstream-Server weiterleiten.**
{: #sticky_cookie}

Verwenden Sie die permanente Cookie-Annotation, um Ihrem Ingress-Controller Sitzungsaffinität hinzuzufügen.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Bei Ihrer Appkonfiguration müssen Sie unter Umständen mehrere Upstream-Server bereitstellen, die eingehende Clientanforderungen verarbeiten, die für eine höhere Sicherheit sorgen. Wenn ein Client eine Verbindung mit Ihrer Back-End-App herstellt, kann es nützlich sein, dass ein Client für die Dauer einer Sitzung bzw. für die Zeit, die für den Abschluss einer Task erforderlich ist, von demselben Upstream-Server bedient wird. Sie können Ihren Ingress-Controller so konfigurieren, dass Sitzungsaffinität sichergestellt ist, indem Sie eingehenden Netzverkehr immer an denselben Upstream-Server weiterleiten.

</br>
Jeder Client, der eine Verbindung mit Ihrer Back-End-App herstellt, wird durch den Ingress-Controller einem der verfügbaren Upstream-Server zugeordnet. Der Ingress-Controller erstellt ein Sitzungscookie, das in der App des Clients gespeichert wird und das in die Headerinformationen jeder Anforderung zwischen dem Ingress-Controller und dem Client eingeschlossen wird. Die Information im Cookie stellen sicher, dass alle Anforderungen während der gesamten Sitzung von demselben Upstream-Server verarbeitet werden.

</br></br>
Wenn Sie mehrere Services einschließen, verwenden Sie ein Semikolon (;) zum Trennen der Services. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;servicename1&gt; name=&lt;cookiename1&gt; expires=&lt;ablaufzeit1&gt; path=&lt;cookiepfad1&gt; hash=&lt;hash-algorithmus1&gt;;serviceName=&lt;servicename2&gt; name=&lt;cookiename2&gt; expires=&lt;ablaufzeit2&gt; path=&lt;cookiepfad2&gt; hash=&lt;hash-algorithmus2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: 8080
      - path: /meine_app
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Tabelle 12. Erklärung der Komponenten der YAML-Datei</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte: <ul><li><code><em>&lt;servicename&gt;</em></code>: Der Name des Kubernetes-Service, den Sie für Ihre App erstellt haben. </li><li><code><em>&lt;cookiename&gt;</em></code>: Wählen Sie einen Namen für das permanente Cookie aus, das während einer Sitzung erstellt wird. </li><li><code><em>&lt;ablaufzeit&gt;</em></code>: Die Zeit in Sekunden, Minuten oder Stunden, bevor das permanente Cookie abläuft. Diese Zeit ist unabhängig von der Benutzeraktivität. Nachdem das Cookie abgelaufen ist, wird es durch den Web-Browser des Clients gelöscht und nicht mehr an den Ingress-Controller gesendet. Um beispielsweise eine Ablaufzeit von einer Sekunde, einer Minute oder einer Stunde festzulegen, geben Sie <strong>1s</strong>, <strong>1m</strong> oder <strong>1h</strong> ein. </li><li><code><em>&lt;cookiepfad&gt;</em></code>: Der Pfad, der an die Ingress-Unterdomäne angehängt ist, und der angibt, für welche Domänen und Unterdomänen das Cookie an den Ingress-Controller gesendet wird. Wenn Ihre Ingress-Domäne beispielsweise <code>www.myingress.com</code> ist und Sie das Cookie in jeder Clientanforderung senden möchten, müssen Sie <code>path=/</code> festlegen. Wenn Sie das Cookie nur für <code>www.myingress.com/meine_app</code> und alle zugehörigen Unterdomänen senden möchten, müssen Sie <code>path=/meine_app</code> festlegen. </li><li><code><em>&lt;hash-algorithmus&gt;</em></code>: Der Hashalgorithmus, der die Informationen im Cookie schützt. Nur <code>sha1</code> wird unterstützt. SHA1 erstellt eine Hashsumme auf der Grundlage der Informationen im Cookie und hängt die Hashsumme an das Cookie an. Der Server kann die Informationen im Cookie entschlüsseln und die Datenintegrität bestätigen. </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **Einer Clientanforderung oder Clientantwort angepasste HTTP-Header hinzufügen**
{: #add_header}

Verwenden Sie diese Informationen, um einer Clientanforderung zusätzliche Headerinformationen hinzuzufügen, bevor Sie die Anforderung an die Back-End-App senden, bzw. einer Clientantwort, bevor Sie die Antwort an den Client senden. {:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Der Ingress-Controller fungiert als Proxy zwischen der Client-App und Ihrer Back-End-App. Clientanforderungen, die an den Ingress-Controller gesendet werden, werden (als Proxy) verarbeitet und in eine neue Anforderung umgesetzt, die anschließend vom Ingress-Controller an Ihre Back-End-App gesendet wird. Beim Senden einer Anforderung als Proxy werden Headerinformationen entfernt, z. B. der Benutzername, der ursprünglich vom Client gesendet wurde. Falls Ihre Back-End-App diese Informationen erfordert, können Sie die Annotation <strong>ingress.bluemix.net/proxy-add-headers</strong> verwenden, um der Clientanforderung Headerinformationen hinzuzufügen, bevor die Anforderung vom Ingress-Controller an Ihre Back-End-App weitergeleitet wird.

</br></br>
Wenn eine Back-End-App eine Antwort an den Client sendet, wird die Antwort vom Ingress-Controller als Proxy gesendet, und die HTTP-Header werden aus der Antwort entfernt. Die Client-Web-App benötigt diese Headerinformationen, um die Antwort erfolgreich verarbeiten zu können. Sie können die Annotation <strong>ingress.bluemix.net/response-add-headers</strong> verwenden, um der Clientanforderung Headerinformationen hinzuzufügen, bevor die Anforderung vom Ingress-Controller an Ihre Back-End-App weitergeleitet wird.

</dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;servicename1&gt; {
      &lt;header1> &lt;wert1&gt;;
      &lt;header2> &lt;wert2&gt;;
      }
      serviceName=&lt;servicename2&gt; {
      &lt;header3&gt; &lt;wert3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;servicename1&gt; {
      "&lt;header1&gt;: &lt;wert1&gt;";
      "&lt;header2&gt;: &lt;wert2&gt;";
      }
      serviceName=&lt;servicename1&gt; {
      "&lt;header3&gt;: &lt;wert3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: 8080
      - path: /meine_app
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte: <ul><li><code><em>&lt;servicename&gt;</em></code>: Der Name des Kubernetes-Service, den Sie für Ihre App erstellt haben. </li><li><code><em>&lt;header&gt;</em></code>: Der Schlüssel der Headerinformationen, die der Clientanforderung oder der Clientantwort hinzugefügt werden sollen. </li><li><code><em>&lt;wert&gt;</em></code>: Der Wert der Headerinformationen, die der Clientanforderung oder der Clientantwort hinzugefügt werden sollen. </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **HTTP-Headerinformationen aus einer Clientantwort entfernen**
{: #remove_response_headers}

Verwenden Sie diese Annotation, um Headerinformationen zu entfernen, die aus der Back-End-App in die Clientantwort eingeschlossen werden sollen, bevor die Antwort an den Client gesendet wird.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Der Ingress-Controller fungiert als Proxy zwischen Ihrer Back-End-App und dem Client-Web-Browser. Clientantworten von der Back-End-App, die an den Ingress-Controller gesendet werden, werden (als Proxy) verarbeitet und in eine neue Antwort umgesetzt, die anschließend vom Ingress-Controller an Ihren Client-Web-Browser gesendet wird. Auch wenn beim Senden einer Antwort als Proxy die HTTP-Headerinformationen entfernt werden, die ursprünglich von der Back-End-App gesendet wurden, entfernt dieser Prozess möglicherweise nicht alle Back-End-App-spezifischen Header. Verwenden Sie diese Annotation, um Headerinformationen aus einer Clientantwort zu entfernen, bevor die Antwort vom Ingress-Controller an den Client-Web-Browser weitergeleitet wird. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;servicename1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;servicename2&gt; {
      "&lt;header3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;servicename1&gt;
          servicePort: 8080
      - path: /meine_app
        backend:
          serviceName: &lt;servicename2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte: <ul><li><code><em>&lt;servicename&gt;</em></code>: Der Name des Kubernetes-Service, den Sie für Ihre App erstellt haben. </li><li><code><em>&lt;header&gt;</em></code>: Der Schlüssel des Headers, der aus der Clientantwort gesendet werden soll. </li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **Unsichere HTTP-Clientanforderungen an HTTPS weiterleiten**
{: #redirect_http_to_https}

Verwenden Sie die 'redirect'-Annotation, um unsichere HTTP-Clientanforderungen in HTTPS zu konvertieren.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Sie konfigurieren Ihren Ingress-Controller für die Sicherung Ihrer Domäne mit dem von IBM bereitgestellten TLS-Zertifikat oder Ihrem angepassten TLS-Zertifikat. Manche Benutzer versuchen unter Umständen, auf Ihre Apps zuzugreifen, indem Sie eine unsichere HTTP-Anforderung an die Domäne Ihres Ingress-Controllers senden, z. B. <code>http://www.myingress.com</code>, anstatt <code>https</code> zu verwenden. Sie können die 'redirect'-Annotation verwenden, um unsichere HTTP-Anforderungen immer in HTTPS zu konvertieren. Wenn Sie diese Annotation nicht verwenden, werden unsichere HTTP-Anforderungen nicht standardmäßig in HTTPS-Anforderungen konvertiert und machen unter Umständen vertrauliche Daten ohne Verschlüsselung öffentlich zugänglich.

</br></br>
Das Umadressieren von HTTP-Anforderungen in HTTPS ist standardmäßig inaktiviert. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **Pufferung von Back-End-Antworten auf Ihrem Ingress-Controller inaktivieren**
{: #response_buffer}

Verwenden Sie die 'buffer'-Annotation, um das Speichern von Antwortdaten auf dem Ingress-Controller während des Sendens von Daten an den Client zu inaktivieren.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Der Ingress-Controller fungiert als Proxy zwischen Ihrer Back-End-App und dem Client-Web-Browser. Wenn eine Antwort von der Back-End-App an den Client gesendet wird, werden die Antwortdaten standardmäßig auf dem Ingress-Controller gepuffert. Der Ingress-Controller verarbeitet die Clientantwort als Proxy und beginnt mit dem Senden der Antwort an den Client (in der Geschwindigkeit des Clients). Nachdem alle Daten aus der Back-End-App vom Ingress-Controller empfangen wurden, wird die Verbindung zur Back-End-App gekappt. Die Verbindung vom Ingress-Controller zum Client bleibt geöffnet, bis der Client alle Daten empfangen hat.

</br></br>
Falls die Pufferung von Antwortdaten auf dem Ingress-Controller inaktiviert ist, werden Daten sofort vom Ingress-Controller an den Client gesendet. Der Client muss eingehende Daten in der Geschwindigkeit des Ingress-Controllers verarbeiten können. Falls der Client zu langsam ist, gehen unter Umständen Daten verloren.
</br></br>
Die Pufferung von Antwortdaten auf dem Ingress-Controller ist standardmäßig aktiviert. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **Angepasste Verbindungs- und Lesezeitlimits für den Ingress-Controller festlegen**
{: #timeout}

Passen Sie die Wartezeit des Ingress-Controllers für das Verbinden mit und Lesen aus der Back-End-App, bis die Back-End-App als nicht verfügbar betrachtet wird, an. {:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Wenn eine Clientanforderung an den Ingress-Controller gesendet wird, wird vom Ingress-Controller eine Verbindung mit der Back-End-App geöffnet. Standardmäßig wartet der Ingress-Controller 60 Sekunden auf eine Antwort von einer Back-End-App. Falls die Back-End-App nicht innerhalb von 60 Sekunden antwortet, wird die Verbindungsanforderung abgebrochen und die Back-End-App als nicht verfügbar angenommen.

</br></br>
Nachdem der Ingress-Controller mit der Back-End-App verbunden wurde, werden Antwortdaten von der Back-End-App vom Ingress-Controller gelesen. Zwischen zwei Leseoperationen wartet der Ingress-Controller maximal 60 Sekunden auf Daten aus der Back-End-App. Falls die Back-End-App innerhalb von 60 Sekunden keine Daten sendet, wird die Verbindung zur Back-End-App gekappt und die App wird als nicht verfügbar angenommen.
</br></br>
Ein Verbindungszeitlimit und Lesezeitlimit von 60 Sekunden ist die Standardeinstellung auf einem Proxy und sollte idealerweise nicht geändert werden.
</br></br>
Falls die Verfügbarkeit Ihrer App nicht durchgehend gewährleistet ist oder Ihre App aufgrund hoher Workloads langsam antwortet, können Sie die Vebindungs- und Lesezeitlimits nach oben korrigieren. Denken Sie daran, dass sich das Erhöhen des Zeitlimits negativ auf die Leistung des Ingress-Controllers auswirken kann, da die Verbindung mit der Back-End-App geöffnet bleiben muss, bis das Zeitlimit erreicht wurde.
</br></br>
Sie können andererseits das Zeitlimit nach unten korrigieren, um die Leistung des Ingress-Controllers zu verbessern. Stellen Sie sicher, dass Ihre Back-End-App Anforderungen auch bei höheren Workloads innerhalb des angegebenen Zeitlimits verarbeiten kann. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;verbindungszeitlimit&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;lesezeitlimit&gt;s"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie die folgenden Werte: <ul><li><code><em>&lt;verbindungszeitlimit&gt;</em></code>: Geben Sie die Anzahl von Sekunden ein, die auf eine Verbindung mit der Back-End-App gewartet werden soll, z. B. <strong>65s</strong>.

  </br></br>
  <strong>Hinweis:</strong> Ein Verbindungszeitlimit kann nicht größer als 75 Sekunden sein. </li><li><code><em>&lt;lesezeitlimit&gt;</em></code>: Geben Sie die Anzahl von Sekunden ein, die auf das Lesen aus der Back-End-App gewartet werden soll, z. B. <strong>65s</strong>. </li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **Maximal zulässige Länge des Clientanforderungshauptteils festlegen**
{: #client_max_body_size}

Verwenden Sie diese Annotation, um die Länge des Texts anzupassen, den der Client als Teil einer Anforderung senden kann.
{:shortdesc}

<dl>
<dt>Beschreibung</dt>
<dd>Um die erwartete Leistung beizubehalten, ist die maximale Größe des Clientanforderungshauptteils auf 1 Megabyte festgelegt. Wenn eine Clientanforderung mit einer das Limit überschreitenden Größe des Hauptteils an den Ingress-Controller gesendet wird und der Client das Unterteilen in mehrere Blöcke nicht zulässt, gibt der Ingress-Controller die HTTP-Antwort 413 (Anforderungsentität zu groß) an den Client zurück. Eine Verbindung zwischen dem Client und dem Ingress-Controller ist erst möglich, wenn die der Anforderungshauptteil verkleinert wird. Wenn der Client das Unterteilen in mehrere Blöcke zulässt, werden die Daten in Pakete von 1 Megabyte aufgeteilt und an den Ingress-Controller gesendet.

</br></br>
Wenn Sie Clientanforderungen mit einer Hauptteilgröße über 1 Megabyte erwarten, können Sie die maximale Größe des Hauptteils erhöhen. Beispiel: Sie möchten, dass Ihr Client große Dateien hochladen kann. Das Erhöhen der maximalen Größe des Anforderungshauptteils kann sich negativ auf die Leistung Ihres Ingress-Controllers auswirken, weil die Verbindung mit dem Client geöffnet bleiben muss, bis die Anforderung empfangen wird.
</br></br>
<strong>Hinweis:</strong> Manche Client-Web-Browser können die HTTP-Antwortnachricht 413 nicht ordnungsgemäß anzeigen. </dd>
<dt>YAML-Beispiel einer Ingress-Ressource</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;größe&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Ersetzen Sie den folgenden Wert: <ul><li><code><em>&lt;größe&gt;</em></code>: Geben Sie die maximale Größe des Clientantworthauptteils ein. Um sie beispielsweise auf 200 Megabyte festzulegen, definieren Sie <strong>200m</strong>.

  </br></br>
  <strong>Hinweis:</strong> Sie können die Größe auf '0' festlegen, um die Prüfung der Größe des Clientanforderungshauptteils zu inaktivieren.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


## IP-Adressen und Teilnetze verwalten
{: #cs_cluster_ip_subnet}

Sie können portierbare öffentliche Teilnetze und IP-Adressen verwenden, um Apps in Ihrem Cluster und über das Internet zugänglich zu machen.
{:shortdesc}

Sie können in {{site.data.keyword.containershort_notm}} stabile, portierbare IPs für Kubernetes-Services hinzufügen, indem Sie dem Cluster Teilnetze hinzufügen. Wenn Sie einen Standardcluster erstellen, stellt {{site.data.keyword.containershort_notm}} automatisch ein portierbares Teilnetz und 5 IP-Adressen bereit. Portierbare öffentliche IP-Adressen sind statisch und ändern sich nicht, wenn ein Workerknoten oder sogar der Cluster entfernt wird.

Eine der portierbaren öffentlichen IP-Adressen wird für den [Ingress-Controller](#cs_apps_public_ingress) verwendet, mit dem Sie mehrere Apps in Ihrem Cluster über eine öffentliche Route zugänglich machen können. Die vier verbleibenden portierbaren öffentlichen IP-Adressen können verwendet werden, um einzelne Apps für die Öffentlichkeit verfügbar zu machen, indem Sie einen [Lastausgleichsservice erstellen](#cs_apps_public_load_balancer).

**Hinweis:** Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Clusters beschließen, portierbare öffentliche IP-Adressen zu entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur über einen kurzen Zeitraum genutzt haben.



1.  Erstellen Sie ein Kubernetes-Servicekonfigurationsscript namens `myservice.yaml` und definieren Sie einen Service vom Typ `LoadBalancer` mit einer Dummy-IP-Adresse für die Lastausgleichsfunktion. Im folgenden Beispiel wird die IP-Adresse '1.1.1.1' als IP-Adresse der Lastausgleichsfunktion verwendet.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Erstellen Sie den Service in Ihrem Cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Überprüfen Sie den Service.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Hinweis:** Die Erstellung dieses Service schlägt fehl, weil der Kubernetes-Master die angegebene IP-Adresse der Lastausgleichsfunktion in der Kubernetes-Konfigurationsübersicht nicht finden kann. Wenn Sie diesen Befehl ausführen, können Sie die Fehlernachricht und die Liste von verfügbaren öffentlichen IP-Adressen für den Cluster anzeigen.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. Die folgenden Cloud-Provider-IPs sind verfügbar: <liste_von_IP-adressen>
    ```
    {: screen}

</staging>

### Verwendete öffentliche IP-Adressen freigeben
{: #freeup_ip}

Sie können eine verwendete öffentliche IP-Adresse freigeben, indem Sie den Lastausgleichsservice löschen, der die öffentliche IP-Adresse belegt.

Bevor Sie beginnen, müssen Sie den [Kontext für den Cluster festlegen, der verwendet werden soll](cs_cli_install.html#cs_cli_configure).

1.  Listen Sie verfügbare Services in Ihrem Cluster auf.

    ```
    kubectl get services
    ```
    {: pre}

2.  Entfernen Sie den Lastausgleichsservice, der eine öffentliche IP-Adresse belegt.

    ```
    kubectl delete service <mein_service>
    ```
    {: pre}


## Apps über die GUI bereitstellen
{: #cs_apps_ui}

Wenn Sie eine App über das Kubernetes-Dashboard in Ihrem Cluster bereitstellen, wird für Sie automatisch eine Bereitstellung erstellt, die die Pods in Ihrem Cluster erstellt, aktualisiert und verwaltet.
{:shortdesc}

Vorbemerkungen:

-   Installieren Sie die erforderlichen [CLIs](cs_cli_install.html#cs_cli_install).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um Ihre App bereitzustellen: 

1.  [Öffnen Sie das Kubernetes-Dashboard](#cs_cli_dashboard).
2.  Klicken Sie im Kubernetes-Dashboard auf **+ Create**.
3.  Wählen Sie **Specify app details below** (App-Details unten angeben) aus, um die App-Details über die GUI einzugeben, oder wählen Sie die Option **Upload a YAML or JSON file** (YAML- oder JSON-Datei hochladen) aus, um die [Konfigurationsdatei ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) für Ihre App hochzuladen. Verwenden Sie [diese YAML-Beispieldatei ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml), um einen Container aus dem Image **ibmliberty** in der Region 'Vereinigte Staaten (Süden)' bereitzustellen. 
4.  Klicken Sie im Kubernetes-Dashboard auf **Deployments**, um zu überprüfen, ob die Bereitstellung auch tatsächlich erstellt wurde.
5.  Wenn Sie Ihre App mithilfe eines Knotenportservice, eines Lastenausgleichsservice oder Ingress öffentlich zugänglich gemacht haben, [überprüfen Sie, dass Sie auf die App zugreifen können](#cs_apps_public). 

## Apps über die CLI (Befehlszeilenschnittstelle) bereitstellen
{: #cs_apps_cli}

Nachdem ein Cluster erstellt worden ist, können Sie in diesem Cluster über die Kubernetes-CLI eine App bereitstellen.
{:shortdesc}

Vorbemerkungen:

-   Installieren Sie die erforderlichen [Befehlszeilenschnittstellen](cs_cli_install.html#cs_cli_install).
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um Ihre App bereitzustellen: 

1.  Erstellen Sie ein Konfigurationsscript auf der Grundlage der [Best Practices von Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/overview/). Im Allgemeinen enthält ein Konfigurationsscript die Konfigurationsdetails für jede Ressource, die Sie in Kubernetes erstellen. Ihr Script könnte dabei einen oder mehrere der folgenden Abschnitte enthalten:


    -   [Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Definiert die Erstellung von Pods und Replikatgruppen. Ein Pod enthält eine einzelne containerisierte App. Mehrere Instanzen von Pods werden durch Replikatgruppen gesteuert.

    -   [Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/service/): Stellt Front-End-Zugriff auf Pods über eine öffentliche IP-Adresse eines Workerknotens oder einer Lastausgleichsfunktion bzw. über eine öffentliche Ingress-Route bereit. 

    -   [Ingress ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Gibt einen Typ von Lastausgleichsfunktion an, die Routen für den öffentlichen Zugriff auf Ihre App bereitstellt. 

2.  Führen Sie das Konfigurationsscript in dem Kontext eines Clusters aus.

    ```
    kubectl apply -f position_des_bereitstellungscripts
    ```
    {: pre}

3.  Wenn Sie Ihre App mithilfe eines Knotenportservice, eines Lastenausgleichsservice oder Ingress öffentlich zugänglich gemacht haben, [überprüfen Sie, dass Sie auf die App zugreifen können](#cs_apps_public). 



## Laufende Bereitstellungen verwalten
{: #cs_apps_rolling}

Sie können den Rollout Ihrer Änderungen auf eine automatisierte und gesteuerte Art verwalten. Wenn der Rollout nicht nach Plan verläuft, können Sie die Bereitstellung auf die vorherige Revision rückgängig machen.
{:shortdesc}

Erstellen Sie zunächst eine [Bereitstellung](#cs_apps_cli). 

1.  [Implementieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) Sie eine Änderung. Beispiel: Sie möchten das Image ändern, das Sie in Ihrer ursprünglichen Bereitstellung verwendet haben. 

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
        kubectl rollout history deployment/<bereitstellungsname> --revision=<anzahl>
        ```
        {: pre}

    2.  Führen Sie ein Rollback auf die frühere Version durch oder geben Sie eine Revision an. Verwenden Sie für das Rollback auf die frühere Version den folgenden Befehl.

        ```
        kubectl rollout undo deployment/<bereitstellungsname> --to-revision=<anzahl>
        ```
        {: pre}

## {{site.data.keyword.Bluemix_notm}}-Services hinzufügen
{: #cs_apps_service}

Zum Speichern der Detailinformationen und Berechtigungsnachweise für {{site.data.keyword.Bluemix_notm}}-Services und zur Sicherstellung der sicheren Kommunikation zwischen dem Service und dem Cluster werden verschlüsselte Kubernetes-Schlüssel verwendet. Als Clusterbenutzer können Sie auf diesen geheimen Schlüssel zugreifen, indem Sie ihn als Datenträger an einen Pod anhängen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.
 Stellen Sie sicher, dass der {{site.data.keyword.Bluemix_notm}}-Service, den Sie in Ihrer App verwenden wollen, vom Clusteradministrator [zu dem Cluster hinzugefügt](cs_cluster.html#cs_cluster_service) wurde. 

Geheime Kubernetes-Schlüssel stellen eine sichere Methode zum Speichern vertraulicher Informationen wie Benutzernamen, Kennwörter oder Schlüssel dar. Statt vertrauliche Informationen über Umgebungsvariablen oder direkt in der Dockerfile selbst offenzulegen, müssen geheime Schlüssel als Datenträger für geheime Schlüssel an einen Pod angehängt werden, damit sie von einem aktiven Container in einem Pod zugänglich sind.

Wenn Sie einen Datenträger für geheime Schlüssel an Ihren Pod anhängen, wird im Mountverzeichnis des Datenträgers eine Datei namens 'binding' gespeichert. Diese Datei enthält sämtliche Informationen und Berechtigungsnachweise, die Sie benötigen, um auf den {{site.data.keyword.Bluemix_notm}}-Service zuzugreifen. 

1.  Listen Sie die verfügbaren geheimen Schlüssel im Namensbereich Ihres Clusters auf.

    ```
    kubectl get secrets --namespace=<mein_namensbereich>
    ```
    {: pre}

    Beispielausgabe:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<serviceinstanzname>         Opaque                                1         3m

    ```
    {: screen}

2.  Suchen Sie nach einem Schlüssel des Typs **Opaque** und notieren Sie den **Namen** des geheimen Schlüssels. Sollten mehrere geheime Schlüssel vorhanden sein, wenden Sie sich an Ihren Clusteradministrator, damit dieser den geheimen Schlüssel für den gewünschten Service ermittelt.

3.  Öffnen Sie Ihren bevorzugten Editor.

4.  Erstellen Sie eine YAML-Datei, um einen Pod zu konfigurieren, der in der Lage ist, über einen Datenträger für geheime Schlüssel auf die Servicedetails zuzugreifen.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <mein_namensbereich>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<serviceinstanzname>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Der Name des Datenträgers für geheime Schlüssel, der an den Container angehängt werden soll.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Geben Sie einen Namen für den Datenträger für geheime Schlüssel ein, der an den Container angehängt werden soll.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Legen Sie Schreibschutz für den geheimen Schlüssel für den Service fest.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Geben Sie den Namen des geheimer Schlüssels ein, den Sie zu einem früheren Zeitpunkt notiert haben.</td>
    </tr></tbody></table>

5.  Erstellen Sie den Pod und hängen Sie den Datenträger für geheime Schlüssel an.

    ```
    kubectl apply -f <yaml-pfad>
    ```
    {: pre}

6.  Stellen Sie sicher, dass der Pod erstellt wurde.

    ```
    kubectl get pods --namespace=<mein_namensbereich>
    ```
    {: pre}

    CLI-Beispielausgabe: 

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  Notieren Sie die Namensangabe für Ihren Pod unter **NAME**.
8.  Rufen Sie die Details zum Pod ab und suchen Sie den Namen des geheimen Schlüssels.

    ```
        kubectl describe pod <podname>
        ```
    {: pre}

    Ausgabe:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (Datenträger, der mit einem geheimen Schlüssel belegt ist)
        SecretName: binding-<serviceinstanzname>
    ...
    ```
    {: screen}

    

9.  Konfigurieren Sie Ihre App beim Implementieren so, dass sie die Datei **binding** mit dem geheimen Schlüssel im Mountverzeichnis finden, den JSON-Inhalt parsen und die URL sowie die Berechtigungsnachweise für den Service ermitteln kann, um auf den {{site.data.keyword.Bluemix_notm}}-Service zuzugreifen. 

Sie können nun auf die Details für den {{site.data.keyword.Bluemix_notm}}-Service und die zugehörigen Berechtigungsnachweise zugreifen. Um mit Ihrem {{site.data.keyword.Bluemix_notm}}-Service arbeiten zu können, stellen Sie sicher, dass Ihre App so konfiguriert ist, dass sie die Datei mit dem geheimen Schlüssel für den Service im Mountverzeichnis finden, den JSON-Inhalt parsen und die Servicedetails ermitteln kann.

## Persistenten Speicher erstellen
{: #cs_apps_volume_claim}

Zum Einrichten von NFS-Dateispeicher erstellen Sie einen Persistent Volume Claim (PVC) für Ihren Cluster. Sie hängen diesen Claim an einen Pod an, um sicherzustellen, dass Daten auch dann verfügbar sind, wenn der Pod ausfällt oder abschaltet. {:shortdesc}

Der NFS-Dateispeicher, auf den sich das Persistent Volume stützt, wird von IBM in Gruppen zusammengefasst, um hohe Verfügbarkeit für Ihre Daten bereitzustellen. 

1.  Überprüfen Sie die verfügbaren Speicherklassen. {{site.data.keyword.containerlong}} stellt drei vordefinierte Speicherklassen zur Verfügung, sodass der Clusteradministrator keine Speicherklassen erstellen muss.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Überprüfen Sie die E/A-Operationen pro Sekunde (IOPS) für eine Speicherklasse oder prüfen Sie die verfügbaren Größen.

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    Das Feld **Parameters** gibt die E/A-Operationen pro Sekunde pro GB für die Speicherklasse und die verfügbaren Größen in Gigabyte an.

    ```
    Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

3.  Erstellen Sie in Ihrem bevorzugten Texteditor ein Konfigurationsscript, in dem Sie Ihren Persistent Volume Claim (PVC) definieren. Speichern Sie diese Konfiguration als Datei mit der Erweiterung `.yaml`. 

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc-name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Geben Sie den Namen des PVCs ein.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Geben Sie die Speicherklasse an, die die Anzahl von E/A-Operationen pro Sekunde pro GB der Hostdateifreigabe für das Persistent Volume bestimmt: <ul><li>ibmc-file-bronze: 2 E/A-Operationen pro Sekunde pro GB.</li><li>ibmc-file-silver: 4 E/A-Operationen pro Sekunde pro GB.</li><li>ibmc-file-gold:  10 E/A-Operationen pro Sekunde pro GB.</li>

    </li> Wenn keine Speicherklasse angegeben ist, wird das Persistent Volume mit der bronzenen Speicherklasse erstellt. </td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Wenn Sie eine Größe angeben, die nicht aufgelistet ist, wird automatisch aufgerundet. Wenn Sie eine Größe angeben, die die maximale angegebene Größe überschreitet, wird automatisch auf die nächstkleinere Größe abgerundet.</td>
    </tr>
    </tbody></table>

4.  Erstellen Sie den Persistent Volume Claim.

    ```
    kubectl apply -f <lokaler_dateipfad>
    ```
    {: pre}

5.  Überprüfen Sie, dass Ihr Persistent Volume Claim erstellt und an das Persistent Volume gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc <pvc-name>
    ```
    {: pre}

    Die Ausgabe ähnelt der folgenden.

    ```
    Name:  <pvc-name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <keine>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}Erstellen Sie ein Konfigurationsscript, um den Persistent Volume Claim an Ihren Pod anzuhängen. Speichern Sie diese Konfiguration als Datei mit der Erweiterung `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <podname>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Der Name des Pods.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Der absolute Pfad des Verzeichnisses, wo der Datenträger im Container angehängt wird.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>Der Name des Datenträgers, den Sie an Ihren Container anhängen.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Der Name des Datenträgers, den Sie an Ihren Container anhängen. Normalerweise ist dieser Name deckungsgleich mit <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>Der Name des PVCs, den Sie als Ihren Datenträger verwenden wollen. Wenn Sie den Datenträger an den Pod anhängen, erkennt Kubernetes das Persistent Volume, das an den Persistent Volume Claim gebunden ist, und ermöglicht dem Benutzer das Lesen von und Schreiben auf das Persistent Volume.</td>
    </tr>
    </tbody></table>

7.  Erstellen Sie den Pod und hängen Sie den Persistent Volume Claim an Ihren Pod an.

    ```
    kubectl apply -f <lokaler_yaml-pfad>
    ```
    {: pre}

8.  Überprüfen Sie, ob der Datenträger erfolgreich an Ihren Pod angehängt wurde.

    ```
    kubectl describe pod <podname>
    ```
    {: pre}

    Der Mountpunkt wird im Feld **Volume Mounts** und der Datenträger wird im Feld **Volumes** angegeben. 

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (Referenz auf einen PersistentVolumeClaim im gleichen Namensbereich)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

## Datenträgerzugriff für Benutzer ohne Rootberechtigung zu persistentem Speicher hinzufügen 
{: #cs_apps_volumes_nonroot}

Benutzer ohne Rootberechtigung verfügen nicht über die Schreibberechtigung für den Mountpfad für NFS-gesicherten Speicher. Um die Schreibberechtigung zu erteilen, müssen Sie die Dockerfile des Image bearbeiten und im Mountpfad ein Verzeichnis mit der entsprechenden Berechtigung zu erstellen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus. 

Wenn Sie eine App erstellen, in der ein Benutzer ohne Rootberechtigung die Schreibberechtigung für den Datenträger benötigt, müssen Sie die folgenden Prozesse in Ihrer Dockerfile und in Ihrem Script für den Einstiegspunkt hinzufügen: 

-   Einen Benutzer ohne Rootberechtigung erstellen
-   Den Benutzer temporär zu Rootgruppe hinzufügen
-   Ein Verzeichnis mit den entsprechenden Benutzerberechtigungen im Datenträger-Mountpfad erstellen

Für {{site.data.keyword.containershort_notm}} ist der Standardeigner des Datenträgermountpfads der Eigner `nobody`. Falls bei NFS-Speicher der Eigner nicht lokal im Pod vorhanden ist, wird der Benutzer `nobody` erstellt. Die Datenträger sind so konfiguriert, dass der Rootbenutzer im Container erkannt wird. Bei manchen Apps ist dies der einzige Benutzer in einem Container. In vielen Apps wird jedoch ein anderer Benutzer ohne Rootberechtigung als `nobody` angegeben, der in den Container-Mountpfad schreibt. 

1.  Erstellen Sie eine Dockerfile in einem lokalen Verzeichnis. Die nachfolgende Beispiel-Dockerfile erstellt einen Benutzer ohne Rootberechtigung mit dem Namen `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    #Gruppe und Benutzer mit Gruppen-ID & Benutzer-ID 1010 erstellen.
    #In diesem Fall wird eine Gruppe und ein Benutzer mit dem Namen myguest erstellt.
    #Die Gruppen-ID und die Benutzer-ID 1010 verursachen wahrscheinlich keinen Konflikt mit bestehenden GUIDs oder UIDs in dem Image.
    #Die Gruppen-ID und Benutzer-ID müssen im Bereich von 0 bis 65536 liegen. Andernfalls schlägt die Containererstellung fehl.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Erstellen Sie das Einstiegspunktscript im selben lokalen Ordner wie die Dockerfile. In diesem Beispiel wird im Einstiegspunktscript der Datenträger-Mountpfad `/mnt/myvol` angegeben.

    ```
    #!/bin/bash
    set -e

    #Dies ist der Mountpunkt für den gemeinsam genutzten Datenträger.
    #Standardmäßig ist der Rootbenutzer Eigner des Mountpunkts.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # Diese Funktion erstellt ein Unterverzeichnis, dessen Eigner
    # der Benutzer ohne Rootberechtigung im Mountpfad des gemeinsamen Datenträgers ist.
    create_data_dir() {
      #Den Benutzer ohne Rootberechtigung zur Primärgruppe für Rootbenutzer hinzufügen.
      usermod -aG root $MY_USER

      #Der Gruppe Lese-, Schreib- und Ausführungsberechtigung für den Mountpfad des gemeinsamen Datenträgers erteilen.
      chmod 775 $MOUNTPATH

      # Im gemeinsamen Pfad des Eigners myguest ohne Rootberechtigung ein Verzeichnis erstellen.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #Den Benutzer ohne Rootberechtigung aus Sicherheitsgründen aus der Rootbenutzergruppe entfernen.
      deluser $MY_USER root

      #Die ursprünglichen Lese-, Schreib- und Ausführungsberechtigungen für den Mountpfad des Datenträgers wiederherstellen.
      chmod 755 $MOUNTPATH
      echo "Datenverzeichnis wurde erstellt..."
    }

    create_data_dir

    #Dieser Befehl erstellt einen Prozess mit langer Laufzeit für dieses Beispiel.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Melden Sie sich bei {{site.data.keyword.registryshort_notm}} an. 

    ```
    bx cr login
    ```
    {: pre}

4.  Erstellen Sie das Image lokal. Ersetzen Sie _&lt;mein_namensbereich&gt;_ durch den Namensbereich für Ihre private Image-Registry. Führen Sie `bx cr namespace-get` aus, wenn Sie Ihren Namensbereich finden müssen. 

    ```
    docker build -t registry.<region>.bluemix.net/<mein_namensbereich>/nonroot .
    ```
    {: pre}

5.  Übertragen Sie das Image mit einer Push-Operation in {{site.data.keyword.registryshort_notm}}. 

    ```
    docker push registry.<region>.bluemix.net/<mein_namensbereich>/nonroot
    ```
    {: pre}

6.  Erstellen Sie einen Persistent Volume Claim, indem Sie eine `.yaml`-Konfigurationsdatei erstellen. In diesem Beispiel wird eine niedrigere Speicherklasse verwendet. Führen Sie `kubectl get storageclasses` aus, um verfügbare Speicherklassen anzuzeigen. 

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Erstellen Sie den Persistent Volume Claim.

    ```
    kubectl apply -f <lokaler_dateipfad>
    ```
    {: pre}

8.  Erstellen Sie ein Konfigurationsscript, um den Datenträger anzuhängen und den Pod über das Image 'nonroot' auszuführen. Der Datenträger-Mountpfad `/mnt/myvol` stimmt mit dem in der Dockerfile angegebenen Mountpfad überein.
Speichern Sie diese Konfiguration als Datei mit der Erweiterung `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<mein_namensbereich>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Erstellen Sie den Pod und hängen Sie den Persistent Volume Claim an Ihren Pod an.

    ```
    kubectl apply -f <lokaler_yaml-pfad>
    ```
    {: pre}

10. Überprüfen Sie, ob der Datenträger erfolgreich an Ihren Pod angehängt wurde.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    Der Mountpunkt wird im Feld **Volume Mounts** aufgelistet und der Datenträger wird im Feld **Volumes** angegeben.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (Referenz auf einen PersistentVolumeClaim im gleichen Namensbereich)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Melden Sie sich bei dem Pod an, sobald er aktiv ist. 

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Zeigen Sie die Berechtigungen für Ihren Datenträger-Mountpfad an.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Diese Ausgabe zeigt, dass der Rootbenutzer über Lese-, Schreib- und Ausführungsberechtigungen für den Datenträger-Mountpfad `mnt/myvol/` verfügt, und der Benutzer myguest ohne Rootberechtigung über die Lese- und Schreibberechtigung für den Ordner `mnt/myvol/mydata`. Diese aktualisierten Berechtigungen ermöglichen dem Benutzer ohne Rootberechtigung das Schreiben von Daten auf das Persistent Volume.


