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


# NodePort-Services einrichten
{: #nodeport}

Sie können Ihre App für den Internetzugriff verfügbar machen, indem Sie die öffentliche IP-Adresse eines beliebigen Workerknotens in einem Cluster verwenden und einen Knotenport zugänglich machen. Verwenden Sie diese Option zum Testen und zur Bereitstellung von öffentlichem Zugriff über einen kurzen Zeitraum.
{:shortdesc}

## Öffentlichen Zugriff auf eine App durch Verwenden des Servicetyps 'NodePort' konfigurieren
{: #config}

Sie können Ihre App für Lite-Cluster oder Standardcluster als Kubernetes-NodePort-Service verfügbar machen.
{:shortdesc}

**Hinweis:** Die öffentliche IP-Adresse eines Workerknotens ist nicht permanent. Muss ein Workerknoten neu erstellt werden, so wird ihm eine neue öffentliche IP-Adresse zugewiesen. Wenn Sie eine stabile öffentliche IP-Adresse und ein höheres Maß an Verfügbarkeit für Ihren Service benötigen, sollten Sie Ihre App über einen [LoadBalancer-Service](cs_loadbalancer.html) oder über [Ingress](cs_ingress.html) verfügbar machen.

Wenn bisher keine App bereitsteht, können Sie eine Kubernetes-Beispielapp namens [Guestbook ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml) verwenden.

1.  Definieren Sie in der Konfigurationsdatei für Ihre App einen Abschnitt vom Typ [Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/service/).

    Beispiel:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <mein_nodeport-service>
      labels:
        run: <meine_demo>
    spec:
      selector:
        run: <meine_demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>Erklärung der Komponenten dieser YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Komponenten des NodePort-Serviceabschnitts</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Ersetzen Sie <code><em>&lt;mein_nodeport-service&gt;</em></code> durch einen Namen für Ihren NodePort-Service.</td>
    </tr>
    <tr>
    <td><code>run</code></td>
    <td>Ersetzen Sie <code><em>&lt;meine_demo&gt;</em></code> durch den Namen Ihrer Bereitstellung.</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td>Ersetzen Sie <code><em>&lt;8081&gt;</em></code> durch den Port, an dem Ihr Service empfangsbereit ist. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>Optional: Ersetzen Sie <code><em>&lt;31514&gt;</em></code> durch eine Knotenportnummer aus dem Bereich 30000 bis 32767. Geben Sie für 'NodePort' keine Portnummer an, die bereits von einem anderen Service verwendet wird. Wenn manuell keine Knotenportnummer festgelegt wird, so erfolgt die Zuweisung automatisch nach dem Zufallsprinzip.<br><br>Wenn Sie für 'NodePort' eine Portnummer festlegen wollen und ermitteln wollen, welche Knotenportnummern bereits belegt sind, führen Sie den folgenden Befehl aus: <pre class="pre"><code>   kubectl get svc
   </code></pre>Alle bereits belegten Knotenportnummern werden unter dem Feld **Ports** angezeigt.</td>
     </tr>
     </tbody></table>


    Für das Beispiel 'Guestbook' ist in der Konfigurationsdatei bereits ein Front-End-Serviceabschnitt vorhanden. Um die App 'Guestbook' extern verfügbar zu machen, müssen Sie dem Front-End-Serviceabschnitt den Typ 'NodePort' und für 'nodePort' eine Portnummer aus dem Bereich 30000 bis 32767 hinzufügen.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  Speichern Sie die aktualisierte Konfigurationsdatei.

3.  Wiederholen Sie diese Schritte, um einen NodePort-Service für jede App zu erstellen, die Sie im Internet zugänglich machen wollen.

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
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
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
