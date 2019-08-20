---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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


# Serverunabhängige Apps mit Knative bereitstellen
{: #serverless-apps-knative}

Machen Sie sich mit der Installation und Verwendung von Knative in einem Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}} vertraut.
{: shortdesc}

**Was ist Knative und wozu wird es verwendet?**</br>
[Knative](https://github.com/knative/docs) ist eine Open-Source-Plattform, die von IBM, Google, Pivotal, Red Hat, Cisco und anderen entwickelt wurde. Das Ziel besteht darin, die Funktionalität von Kubernetes zu erweitern, um Sie bei der Erstellung moderner, quellenzentrierter, containerisierter und serverunabhängiger Apps auf der Basis eines Kubernetes-Clusters zu unterstützen. Die Plattform ist auf die Anforderungen von Entwicklern ausgerichtet, die heute entscheiden müssen, welchen Typ von App sie in der Cloud ausführen wollen: 12-Faktoren-Apps, Container oder Funktionen. Jeder Typ von App erfordert eine Open-Source-Lösung oder eine proprietäre Lösung, die auf diese Apps zugeschnitten ist: Cloud Foundry für 12-Faktoren-Apps, Kubernetes für Container sowie OpenWhisk und andere für Funktionen. In der Vergangenheit mussten Entwickler entscheiden, welchem Ansatz sie folgen wollten, was sich als unflexibel und komplex erwies, wenn unterschiedliche Typen von Apps kombiniert werden mussten.  

Knative nutzt ein konsistentes, programmiersprachen- und frameworkübergreifendes Konzept, um den Betriebsaufwand für die Builderstellung, Bereitstellung und Verwaltung von Workloads in Kubernetes zusammenzufassen, sodass Entwickler sich auf das Wichtigste konzentrieren können: den Quellcode. Sie können bewährte Build-Packs verwenden, mit denen Sie bereits vertraut sind, wie zum Beispiel Cloud Foundry, Kaniko, Dockerfile, Bazel und andere. Durch die Integration in Istio stellt Knative sicher, dass sich Ihre serverunabhängigen und containerisierten Workloads problemlos über das Internet zugänglich machen, überwachen und steuern lassen und dass Ihre Daten bei der Übertragung verschlüsselt werden.

**Wie funktioniert Knative?**</br>
Knative wird mit drei Hauptkomponenten oder _Basiskomponenten_ ('Primitives') bereitgestellt, die Sie beim Erstellen (Build), Bereitstellen (Deploy) und Verwalten Ihrer serverunabhängigen Apps in Ihrem Kubernetes-Cluster unterstützen.

- **Build:** Die Basiskomponente `Build` unterstützt das Erstellen einer Reihe von Schritten, um Ihre App aus Quellcode als Container-Image zu erstellen. Stellen Sie sich vor, Sie verwenden eine einfache Buildvorlage, in der Sie das Quellenrepository zum Auffinden Ihres App-Codes und die gewünschte Container-Registry für das Hosting des Images angeben. Durch einen einzigen Befehl können Sie Knative anweisen, diese Buildvorlage zu verwenden, den Quellcode zu extrahieren, das Image zu erstellen und das Image durch eine Push-Operation in Ihre Container-Registry einzufügen, sodass Sie das Image in Ihrem Container verwenden können.
- **Serving:** Die Basiskomponente `Serving` unterstützt Sie bei der Bereitstellung serverunabhängiger Apps als Knative-Services sowie bei der automatischen Skalierung dieser Services, sogar bis auf null Instanzen herab. Knative verwendet Istio zum Bereitstellen Ihrer serverunabhängigen und containerisierten Workloads. Wenn Sie das verwaltete Knative-Add-on installieren, wird das verwaltete Istio-Add-on automatisch mitinstalliert. Durch die Nutzung der Istio-Funktionalität für Datenverkehrsmanagement und intelligentes Routing können Sie steuern, welcher Datenverkehr an eine bestimmte Version Ihres Service geleitet wird, sodass ein Entwickler eine neue App-Version ohne großen Aufwand testen und implementieren kann oder A-B-Tests durchführen kann.
- **Eventing:** Mit der Basiskomponente `Eventing` können Sie Auslöser (Trigger) oder Ereignisströme erstellen, die andere Services abonnieren können. Sie wollen zum Beispiel immer dann einen neuen Build Ihrer App starten, wenn Code durch eine Push-Operation in Ihr GitHub-Master-Repository übertragen wird. Oder Sie möchten eine serverunabhängige App nur ausführen, wenn die Temperatur unter den Gefrierpunkt fällt. Zum Beispiel kann die Basiskomponente `Eventing` in Ihre CI/CD-Pipeline integriert werden, um den Build und die Bereitstellung von Apps zu automatisieren, wenn ein bestimmtes Ereignis auftritt.

**Was ist das (experimentelle) Managed Knative on {{site.data.keyword.containerlong_notm}}-Add-on?** </br>
Managed Knative on {{site.data.keyword.containerlong_notm}} ist ein [verwaltetes Add-on](/docs/containers?topic=containers-managed-addons#managed-addons), das Knative und Istio direkt in Ihren Kubernetes-Cluster integriert. Die Knative- und die Istio-Version in dem Add-on werden von IBM getestet und für die Verwendung in {{site.data.keyword.containerlong_notm}} unterstützt. Weitere Informationen zu verwalteten Add-ons finden Sie unter [Services unter Verwendung verwalteter Add-ons hinzufügen](/docs/containers?topic=containers-managed-addons#managed-addons).

**Gibt es Einschränkungen?** </br>
Wenn Sie den [Zugangscontroller zur Durchsetzung der Sicherheit von Container-Images](/docs/services/Registry?topic=registry-security_enforce#security_enforce) in Ihrem Cluster installiert haben, können Sie das verwaltete Knative-Add-on in Ihrem Cluster nicht aktivieren.

## Knative im Cluster einrichten
{: #knative-setup}

Knative baut auf Istio auf, um sicherzustellen, dass Ihre serverunabhängigen und containerisierten Workloads im Cluster und über das Internet zugänglich gemacht werden können. Mit Istio können Sie den Netzverkehr zwischen Ihren Services auch überwachen und steuern sowie sicherstellen, dass Ihre Daten während der Übertragung verschlüsselt sind. Wenn Sie das verwaltete Knative-Add-on installieren, wird das verwaltete Istio-Add-on automatisch mitinstalliert.
{: shortdesc}

Vorbereitende Schritte:
-  [Installieren Sie die IBM Cloud-CLI, das {{site.data.keyword.containerlong_notm}}-Plug-in und die Kubernetes-CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps). Stellen Sie sicher, dass Sie die CLI-Version von `kubectl` installieren, die der Kubernetes-Version Ihres Clusters entspricht.
-  [Erstellen Sie einen Standardcluster mit mindestens drei Workerknoten, die jeweils vier Cores und 16 GB Hauptspeicher (`b3c.4x16`) oder mehr haben](/docs/containers?topic=containers-clusters#clusters_ui). Darüber hinaus müssen der Cluster und die Workerknoten mindestens die unterstützte, mindestens erforderliche Version von Kubernetes ausführen. Dies können Sie durch Ausführen von `ibmcloud ks addon-versions -- addon knative` überprüfen.
-  Stellen Sie sicher, dass Sie über die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.containerlong_notm}} verfügen.
-  [Definieren Sie Ihren Cluster als Ziel der CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
</br>

Gehen Sie wie folgt vor, um Knative in Ihrem Cluster zu installieren:

1. Aktivieren Sie das verwaltete Knative-Add-on in Ihrem Cluster. Wenn Sie Knative in Ihrem Cluster aktivieren, werden Istio und alle Knative-Komponenten in Ihrem Cluster installiert.
   ```
   ibmcloud ks cluster-addon-enable knative --cluster <clustername_oder_-id> -y
   ```
   {: pre}

   Beispielausgabe:
   ```
   Enabling add-on knative for cluster knative...
   OK
   ```
   {: screen}

   Die Installation aller Knative-Komponenten kann einige Minuten dauern.

2. Überprüfen Sie, ob Istio erfolgreich installiert wurde. Alle Pods für die neun Istio-Services und der Pod für Prometheus müssen den Status `Running` (Aktiv) haben.
   ```
   kubectl get pods --namespace istio-system
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
   ```
   {: screen}

3. Optional: Wenn Sie Istio für alle Apps im Standardnamensbereich (`default`) verwenden möchten, fügen Sie dem Namensbereich die Bezeichnung `istio-injection=enabled` hinzu. Jeder serverunabhängige App-Pod muss einen Envoy-Prox-Sidecar ausführen, sodass die App in das Istio-Servicenetz eingeschlossen werden kann. Diese Bezeichnung ermöglicht Istio das automatische Ändern der Pod-Vorlagenspezifikation bei neuen App-Bereitstellungen, sodass Pods mit Envoy-Proxy-Sidecar-Containern erstellt werden.
   ```
   kubectl label namespace default istio-injection=enabled
   ```
   {: pre}

4. Überprüfen Sie, ob alle Pods der Knative-Komponente `Serving` den Status `Running` (Aktiv) haben.
   ```
   kubectl get pods --namespace knative-serving
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME                          READY     STATUS    RESTARTS   AGE
      activator-598b4b7787-ps7mj    2/2       Running   0          21m
      autoscaler-5cf5cfb4dc-mcc2l   2/2       Running   0          21m
      controller-7fc84c6584-qlzk2   1/1       Running   0          21m
      webhook-7797ffb6bf-wg46v      1/1       Running   0          21m
   ```
   {: screen}

## Serverunabhängige App mithilfe von Knative-Services bereitstellen
{: #knative-deploy-app}

Nachdem Sie Knative in Ihrem Cluster eingerichtet haben, können Sie Ihre serverunabhängige App als Knative-Service bereitstellen.
{: shortdesc}

**Was ist ein Knative-Service?** </br>
Zum Bereitstellen einer App mit Knative müssen Sie eine Knative-`Serviceressource` angeben. Ein Knative-Service wird von der Knative-Basiskomponente `Serving` verwaltet und ist für die Verwaltung des gesamten Lebenszyklus der Workload verantwortlich. Wenn Sie den Service erstellen, erstellt die Knative-Basiskomponente `Serving` automatisch eine Version für Ihre serverunabhängige App und fügt diese Version dem Revisionsprotokoll des Service hinzu. Ihrer serverunabhängigen App wird eine öffentliche URL aus Ihrer Ingress-Unterdomäne im Format `<knative-servicename>.<namensbereich>.<ingress-unterdomäne>` zugeordnet, durch die Sie über das Internet auf die App zugreifen können. Außerdem wird Ihrer App ein privater Hostname im Format `<knative-servicename>.<namensbereich>.cluster.local` zugeordnet, durch den Sie über den Cluster auf Ihre App zugreifen können.

**Was passiert im Hintergrund, wenn ich den Knative-Service erstelle?**</br>
Wenn Sie einen Knative-Service erstellen, wird Ihre App automatisch als Kubernetes-Pod in Ihrem Cluster bereitgestellt und über einen Kubernetes Service zugänglich gemacht. Knative verwendet die von IBM bereitgestellte Ingress-Unterdomäne und das zugehörige TLS-Zertifikat zum Zuordnen des öffentlichen Hostnamens. Eingehender Netzverkehr wird auf der Basis der von IBM bereitgestellten Ingress-Standard-Routing-Regeln weitergeleitet.

**Wie kann ich eine neue Version meiner App implementieren?**</br>
Wenn Sie Ihren Knative-Service aktualisieren, wird eine neue Version Ihrer serverunabhängigen App erstellt. Dieser Version werden dieselben öffentlichen und privaten Hostnamen wie der vorherigen Version zugeordnet. Standardmäßig wird der gesamte eingehende Netzverkehr an die neueste Version Ihrer App weitergeleitet. Sie können jedoch angeben, welcher Prozentsatz des eingehenden Netzverkehrs an eine bestimmte App-Version weitergeleitet werden soll, damit Sie A-B-Tests durchführen können. Sie können den eingehenden Netzverkehr gleichzeitig zwischen zwei App-Versionen aufteilen: die aktuelle Version Ihrer Version und die neue Version, die Sie implementieren wollen.  

**Kann ich eine eigene angepasste Domäne und das entsprechende TLS-Zertifikat verwenden?** </br>
Sie können die Konfigurationszuordnung Ihres Istio-Ingress-Gateways und die Ingress-Routing-Regel so ändern, dass sie Ihren angepassten Domänennamen und das TLS-Zertifikat verwenden, wenn Sie Ihrer serverunabhängigen App einen Hostnamen zuordnen. Weitere Informationen finden Sie unter [Angepasste Domänennamen und Zertifikate einrichten](#knative-custom-domain-tls).

Gehen Sie wie folgt vor, um Ihre serverunabhängige App als Knative-Service bereitzustellen:

1. Erstellen Sie eine YAML-Datei für Ihre erste serverunabhängige App [`Hello World`](https://hub.docker.com/r/ibmcom/kn-helloworld) in Go mit Knative. Wenn Sie eine Anforderung an Ihre Beispielapp senden, liest die App die Umgebungsvariable `TARGET` und gibt `"Hello ${TARGET}!"` aus. Ist diese Umgebungsvariable leer, wird `"Hello World!"` zurückgegeben.
   ```
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     runLatest:
       configuration:
         revisionTemplate:
           spec:
             container:
               image: docker.io/ibmcom/kn-helloworld
               env:
               - name: TARGET
                 value: "Go Sample v1"
    ```
    {: codeblock}

    <table>
    <caption>Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>Der Name Ihres Knative-Service.</td>
    </tr>
    <tr>
    <td><code>metadata.namespace</td>
    <td>Optional: Der Kubernetes-Namensbereich, in dem Sie Ihre App als Knative-Service bereitstellen wollen. Standardmäßig werden alle Services im Kubernetes-Standardnamensbereich (<code>default</code>) bereitgestellt. </td>
    </tr>
    <tr>
    <td><code>spec.container.image</code></td>
    <td>Die URL zu der Container-Registry, in der Ihr Image gespeichert ist. In diesem Beispiel stellen Sie eine Knative-App 'Hello World' bereit, die im Namensbereich <code>ibmcom</code> in Docker Hub gespeichert ist. </td>
    </tr>
    <tr>
    <td><code>spec.container.env</code></td>
    <td>Optional: Eine Liste der Umgebungsvariablen, die Ihr Knative-Service haben soll. In diesem Beispiel wird der Wert der Umgebungsvariablen <code>TARGET</code> von der Beispielapp gelesen und zurückgegeben, wenn Sie eine Anforderung an Ihre App im Format <code>"Hello ${TARGET}!"</code> senden. Wenn kein Wert angegeben ist, gibt die Beispielapp den Wert <code>"Hello World!"</code> zurück.  </td>
    </tr>
    </tbody>
    </table>

2. Erstellen Sie den Knative-Service in Ihrem Cluster.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

   Beispielausgabe:
   ```
   service.serving.knative.dev "kn-helloworld" created
   ```
   {: screen}

3. Überprüfen Sie, ob Ihr Knative-Service erstellt wurde. In Ihrer CLI-Ausgabe können Sie die öffentliche Domäne (**DOMAIN**) sehen, die Ihrer serverunabhängigen App zugeordnet ist. Die Spalten **LATESTCREATED** und **LATESTREADY** zeigen die Version Ihrer zuletzt erstellten und zurzeit bereitgestellten App im Format `<knative-servicename>-<version>` an. Die Ihrer App zugeordnete Version ist ein zufälliger Zeichenfolgewert. In diesem Beispiel lautet die Version Ihrer serverunabhängigen App `rjmwt`. Wenn Sie den Service aktualisieren, wird eine neue Version der App erstellt und ihr wird eine neue zufällige Zeichenfolge für die Version zugeordnet.  
   ```
   kubectl get ksvc/kn-helloworld
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME            DOMAIN                                                                LATESTCREATED         LATESTREADY           READY   REASON
      kn-helloworld   kn-helloworld.default.mycluster.us-south.containers.appdomain.cloud   kn-helloworld-rjmwt   kn-helloworld-rjmwt   True
   ```
   {: screen}

4. Testen Sie Ihre App `Hello World`, indem Sie eine Anforderung an die öffentliche URL senden, die Ihrer App zugeordnet ist.
   ```
   curl -v <öffentliche_app-url>
   ```
   {: pre}

   Beispielausgabe:
   ```
   * Rebuilt URL to: kn-helloworld.default.mycluster.us-south.containers.appdomain.cloud/
   *   Trying 169.46.XX.XX...
   * TCP_NODELAY set
   * Connected to kn-helloworld.default.mycluster.us-south.containers.appdomain.cloud (169.46.XX.XX) port 80 (#0)
   > GET / HTTP/1.1
   > Host: kn-helloworld.default.mycluster.us-south.containers.appdomain.cloud
   > User-Agent: curl/7.54.0
   > Accept: */*
   >
   < HTTP/1.1 200 OK
      < Date: Thu, 21 Mar 2019 01:12:48 GMT
      < Content-Type: text/plain; charset=utf-8
      < Content-Length: 20
      < Connection: keep-alive
      < x-envoy-upstream-service-time: 17
      <
      Hello Go Sample v1!
   * Connection #0 to host kn-helloworld.default.mycluster.us-south.containers.appdomain.cloud left intact
   ```
   {: screen}

5. Listen Sie die Anzahl der Pods auf, die für Ihren Knative-Service erstellt wurden. Im Beispiel in diesem Abschnitt wird ein Pod bereitgestellt, der aus zwei Behältern besteht. Der eine Container führt Ihre App `Hello World` aus und der andere Container ist ein Sidecar, der Istio- und Knative-Tools zur Überwachung und Protokollierung ausführt.
   ```
   kubectl get pods
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME                                             READY     STATUS    RESTARTS   AGE
   kn-helloworld-rjmwt-deployment-55db6bf4c5-2vftm  2/2      Running   0          16s
   ```
   {: screen}

6. Warten Sie einige Minuten, um Knative ein Scale-down Ihrer Pods durchführen zu lassen. Knative berechnet die Anzahl der Pods, die gleichzeitig betriebsbereit sein müssen, um eingehende Workloads verarbeiten zu können. Wenn kein Netzverkehr empfangen wird, verringert Knative die Anzahl Ihrer Pods durch automatische Scale-downs sogar bis auf null Pods, wie in diesem Beispiel gezeigt.

   Möchten Sie sehen, wie Knative ein Scale-up Ihrer Pods durchführt? Versuchen Sie, die Workload für Ihre App zu erhöhen, indem Sie zum Beispiel Tools wie das [einfache Testprogramm für cloudbasierte Auslastungen](https://loader.io/) verwenden.
   {: tip}
   ```
   kubectl get pods
   ```
   {: pre}

   Wenn keine Pods `kn-helloworld` angezeigt werden, hat Knative die Anzahl der Pods Ihrer App durch Scale-down auf null reduziert.

7. Aktualisieren Sie Ihr Knative-Servicebeispiel und geben Sie einen anderen Wert für die Umgebungsvariable `TARGET` an.

   YAML-Beispiel für den Service:
   ```
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: kn-helloworld
     namespace: default
   spec:
     runLatest:
       configuration:
         revisionTemplate:
           spec:
             container:
               image: docker.io/ibmcom/kn-helloworld
               env:
               - name: TARGET
                 value: "Mr. Smith"
   ```
   {: codeblock}

8. Wenden Sie die Änderung auf Ihren Service an. Wenn Sie die Konfiguration ändern, erstellt Knative automatisch eine neue Version für Ihre App.
   ```
   kubectl apply -f service.yaml
   ```
   {: pre}

9. Überprüfen Sie, ob eine neue Version Ihrer App bereitgestellt wurde. In Ihrer CLI-Ausgabe können Sie die neue Version Ihrer App in der Spalte **LATESTCREATED** sehen. Wenn die Spalte **LATESTREADY** dieselbe App-Version enthält, ist Ihre App vollständig eingerichtet und empfangsbereit für den eingehenden Netzverkehr an der zugeordneten öffentlichen URL.
   ```
   kubectl get ksvc/kn-helloworld
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME            DOMAIN                                                                LATESTCREATED         LATESTREADY           READY   REASON
   kn-helloworld   kn-helloworld.default.mycluster.us-south.containers.appdomain.cloud   kn-helloworld-ghyei   kn-helloworld-ghyei   True
   ```
   {: screen}

9. Senden Sie eine neue Anforderung an Ihr App, um zu prüfen, ob Ihre Änderung angewendet wurde.
   ```
   curl -v <servicedomäne>
   ```

   Beispielausgabe:
   ```
   ...
   Hello Mr. Smith!
   ```
   {: screen}

10. Überprüfen Sie, ob Knative die Anzahl Ihrer Pods durch Scale-up wieder erhöht hat, um dem erhöhten Netzverkehr Rechnung zu tragen.
    ```
    kubectl get pods
    ```

    Beispielausgabe:
    ```
    NAME                                              READY     STATUS    RESTARTS   AGE
    kn-helloworld-ghyei-deployment-55db6bf4c5-2vftm   2/2       Running   0          16s
    ```
    {: screen}

11. Optional: Bereinigen Sie Ihren Knative-Service.
    ```
    kubectl delete -f service.yaml
    ```
    {: pre}


## Angepasste Domänennamen und Zertifikate einrichten
{: #knative-custom-domain-tls}

Sie können Knative so konfigurieren, dass Hostnamen Ihrer angepassten Domäne, die Sie mit TLS konfiguriert haben, zugeordnet werden.
{: shortdesc}

Standardmäßig wird jeder App eine öffentliche Unterdomäne aus Ihrer Ingress-Unterdomäne im Format `<knative-servicename>.<namensbereich>.<ingress-unterdomäne>` zugeordnet, durch die Sie über das Internet auf die App zugreifen können. Außerdem wird Ihrer App ein privater Hostname im Format `<knative-servicename>.<namensbereich>.cluster.local` zugeordnet, durch den Sie über den Cluster auf Ihre App zugreifen können. Wenn Sie Hostnamen aus einer angepassten Domäne zuordnen wollen, deren Eigner Sie sind, können Sie die Knative-Konfigurationszuordnung ändern, damit stattdessen die angepasste Domäne verwendet wird.

1. Erstellen Sie eine angepasste Domäne. Arbeiten Sie mit Ihrem DNS-Provider (Domain Name Service) oder [IBM Cloud DNS](/docs/infrastructure/dns?topic=dns-getting-started), um Ihre angepasste Domäne zu registrieren.
2. Konfigurieren Sie Ihre Domäne, um eingehenden Netzverkehr an das von IBM bereitgestellte Ingress-Gateway weiterzuleiten. Wählen Sie zwischen diesen Optionen:
   - Definieren Sie einen Alias für Ihre angepasste Domäne, indem Sie die von IBM bereitgestellte Domäne als kanonischen Namensdatensatz (CNAME) angeben. Zum Ermitteln der von IBM bereitgestellten Ingress-Domäne führen Sie den Befehl `ibmcloud ks cluster-get --cluster <clustername>` aus. Suchen Sie nach dem Feld für die Ingress-Unterdomäne (**Ingress subdomain**). Die Verwendung eines CNAME wird bevorzugt, weil IBM automatische Zustandsprüfungen für die IBM Unterdomäne ermöglicht und alle fehlgeschlagenen IPs aus der DNS-Antwort entfernt.
   - Ordnen Sie Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse des Ingress-Gateways zu, indem Sie die IP-Adresse als A-Datensatz hinzufügen. Führen Sie `nslookup <ingress-unterdomäne>` aus, um die öffentliche IP-Adresse des Ingress-Gateways zu suchen.
3. Kaufen Sie ein offizielles TLS-Platzhalterzertifikat für Ihre angepasste Domäne. Wenn Sie mehrere TLS-Zertifikate kaufen wollen, stellen Sie sicher, dass der [allgemeine Name (CN, Common Name) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://support.dnsimple.com/articles/what-is-common-name/) für jedes Zertifikat anders ist.
4. Erstellen Sie einen geheimen Kubernetes-Schlüssel (Secret) für Ihr Zertifikat und den Schlüssel.
   1. Verschlüsseln Sie das Zertifikat und den Schlüssel in Base-64 und speichern Sie den mit Base-64 verschlüsselten Wert in einer neuen Datei.
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. Zeigen Sie den mit Base-64 verschlüsselten Wert für das Zertifikat und den Schlüssel an.
      ```
      cat tls.key.base64
      ```
      {: pre}

   3. Erstellen Sie anhand des Zertifikats und des Schlüssels eine YAML-Datei für geheime Schlüssel.
      ```
      apiVersion: v1
      kind: Secret
      metadata:
        name: mydomain-ssl
      type: Opaque
      data:
        tls.crt: <clientzertifikat>
        tls.key: <clientschlüssel>
      ```
      {: codeblock}

   4. Erstellen Sie das Zertifikat in Ihrem Cluster.
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

5. Öffnen Sie die Ingress-Ressource `iks-knative-ingress` im Namensbereich `istio-system` Ihres Clusters, um Sie zu bearbeiten.
   ```
   kubectl edit ingress iks-knative-ingress -n istio-system
   ```
   {: pre}

6. Ändern Sie die Standard-Routing-Regeln für Ihre Ingress-Instanz.
   - Fügen Sie Ihre angepasste Platzhalterdomäne dem Abschnitt `spec.rules.host` hinzu, sodass der gesamte eingehende Netzverkehr von Ihrer angepassten Domäne und allen Unterdomänen an `istio-ingressgateway` weitergeleitet wird.
   - Konfigurieren Sie alle Hosts Ihrer angepassten Platzhalterdomäne für die Verwendung des geheimen TLS-Schlüssels, den Sie zuvor im Abschnitt `spec.tls.hosts` erstellt haben.

   Ingress-Beispiel:
   ```
   apiVersion: extensions/v1beta1
   kind: Ingress
   metadata:
     name: iks-knative-ingress
     namespace: istio-system
   spec:
     rules:
     - host: '*.mydomain'
       http:
         paths:
         - backend:
             serviceName: istio-ingressgateway
             servicePort: 80
           path: /
     tls:
     - hosts:
       - '*.mydomain'
       secretName: mydomain-ssl
   ```
   {: codeblock}

   Die Abschnitte `spec.rules.host` und `spec.tls.hosts` sind Listen, die mehrere angepasste Domänen und TLS-Zertifikat enthalten können.
   {: tip}

7. Ändern Sie die Knative-Konfigurationszuordnung `config-domain` so, dass Ihre angepasste Domäne verwendet wird, um neuen Knative-Services Hostnamen zuzuordnen.
   1. Öffnen Sie die Konfigurationszuordnung `config-domain`, um sie zu bearbeiten.
      ```
      kubectl edit configmap config-domain -n knative-serving
      ```
      {: pre}

   2. Geben Sie Ihre angepasste Domäne im Abschnitt `data` Ihrer Konfigurationszuordnung an und entfernen Sie die Standarddomäne, die für Ihren Cluster festgelegt ist.
      - **Beispiel für das Zuordnen eines Hostnamens aus Ihrer angepassten Domäne für alle Knative-Services**:
        ```
        apiVersion: v1
        kind: ConfigMap
        data:
          <angepasste_domäne>: ""
        metadata:
          name: config-domain
          namespace: knative-serving
        ```
        {: codeblock}

        Durch Hinzufügen von `""` zu Ihrer angepassten Domäne wird allen Knative-Services, die Sie erstellen, ein Hostname aus Ihrer angepassten Domäne zugeordnet.  

      - **Beispiel für das Zuordnen eines Hostnamens aus Ihrer angepassten Domäne für ausgewählte Knative-Services**:
        ```
        apiVersion: v1
        kind: ConfigMap
        data:
          <angepasste_domäne>: |
            selector:
              app: sample
          mycluster.us-south.containers.appdomain.cloud: ""
        metadata:
          name: config-domain
          namespace: knative-serving
        ```
        {: codeblock}

        Fügen Sie Ihrer Konfigurationszuordnung einen `data.selector`-Bezeichnungsschlüssel und -wert hinzu, damit nur ausgewählten Knative-Services ein Hostname aus Ihrer angepassten Domäne zugeordnet wird. In diesem Beispiel wird allen Services mit der Bezeichnung `app: sample` ein Hostname aus Ihrer angepassten Domäne zugeordnet. Stellen Sie sicher, dass Sie auch einen Domänennamen haben, den Sie allen anderen Apps zuordnen wollen, die nicht die Bezeichnung `app: sample` haben. In diesem Beispiel wird die von IBM bereitgestellte Domäne `mycluster.us-south.containers.appdomain.cloud` verwendet.
    3. Speichern Sie Ihre Änderungen.

Nach dem Einrichten Ihrer Ingress-Routing-Regeln und Knative-Konfigurationszuordnungen können Sie Knative-Services mit Ihrer angepassten Domäne und dem zugehörigen TLS-Zertifikat erstellen.

## Über anderen Knative-Service auf einen Knative-Service zugreifen
{: #knative-access-service}

Sie über einen anderen Knative-Service auf Ihren Knative-Service zugreifen, indem Sie einen API-Aufruf an die URL verwenden, die Ihrem Knative-Service zugeordnet ist.
{: shortdesc}

1. Listen Sie alle Knative-Services in Ihrem Cluster auf.
   ```
   kubectl get ksvc --all-namespaces
   ```
   {: pre}

2. Rufen Sie die Domäne (**DOMAIN**) ab, die Ihrem Knative-Service zugeordnet ist.
   ```
   kubect get ksvc/<knative-servicename>
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME        DOMAIN                                                            LATESTCREATED     LATESTREADY       READY   REASON
   myservice   myservice.default.mycluster.us-south.containers.appdomain.cloud   myservice-rjmwt   myservice-rjmwt   True
   ```
   {: screen}

3. Verwenden Sie den Domänennamen zum Implementieren eines REST-API-Aufrufs, um auf Ihren Knative-Service zuzugreifen. Dieser REST-API-Aufruf muss Teil der App sein, die die Sie einen Knative-Service erstellen. Wenn der Knative-Service, auf den Sie zuzugreifen versuchen, einer lokalen URL im Format `<service_name>.<namespace>.svc.cluster.local` zugeordnet ist, hält Knative die REST-API-Anforderung innerhalb des clusterinternen Netzes.

   Beispiel-Code-Snippet in Go:
   ```go
   resp, err := http.Get("<knative-service-domänenname>")
   if err != nil {
       fmt.Fprintf(os.Stderr, "Error: %s\n", err)
   } else if resp.Body != nil {
       body, _ := ioutil.ReadAll(resp.Body)
       fmt.Printf("Response: %s\n", string(body))
   }
   ```
   {: codeblock}

## Gängige Einstellungen für Knative-Services
{: #knative-service-settings}

Überprüfen Sie gängige Einstellungen für Knative-Services, die beim Entwickeln Ihrer serverunabhängigen App nützlich für Sie sein können.
{: shortdesc}

- [Mindestanzahl und maximale Anzahl Pods festlegen](#knative-min-max-pods)
- [Maximale Anzahl Anforderungen pro Pod angeben](#max-request-per-pod)
- [Nur private serverunabhängige Apps erstellen](#knative-private-only)
- [Knative-Service zum erneuten Extrahieren eines Container-Images zwingen](#knative-repull-image)

### Mindestanzahl und maximale Anzahl Pods festlegen
{: #knative-min-max-pods}

Mithilfe einer Annotation können Sie die Mindestanzahl und die maximale Anzahl von Pods angeben, die Sie für Ihre Apps ausführen wollen. Wenn Sie beispielsweise nicht wollen, dass Knative für Ihre App ein Scale-down auf null Instanzen durchführt, setzen Sie die Mindestanzahl der Pods auf 1.
{: shortdesc}

```
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: ...
spec:
  runLatest:
    configuration:
      revisionTemplate:
        metadata:
          annotations:
            autoscaling.knative.dev/minScale: "1"
            autoscaling.knative.dev/maxScale: "100"
        spec:
          container:
            image:
...
```
{: codeblock}

<table>
<caption>Erklärung der Komponenten der YAML-Datei</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
</thead>
<tbody>
<tr>
<td><code>autoscaling.knative.dev/minScale</code></td>
<td>Geben Sie die Mindestanzahl von Pods ein, die in Ihrem Cluster ausgeführt werden sollen. Knative kann für Ihre App kein Scale-down auf eine Anzahl durchführen, die kleiner als die von Ihnen festgelegte Anzahl ist, auch wenn von Ihrer App kein Netzverkehr empfangen wird. Die Standardanzahl Pods ist Null.  </td>
</tr>
<tr>
<td><code>autoscaling.knative.dev/maxScale</code></td>
<td>Geben Sie die maximale Anzahl von Pods ein, die in Ihrem Cluster ausgeführt werden sollen. Knative kann für Ihre App kein Scale-up auf eine Anzahl durchführen, die größer als die von Ihnen festgelegte Anzahl ist, auch wenn mehr Anforderungen auftreten, als Ihre aktuellen APP-Instanzen verarbeiten können.</td>
</tr>
</tbody>
</table>

### Maximale Anzahl Anforderungen pro Pod angeben
{: #max-request-per-pod}

Sie können die maximale Anzahl Anforderungen angeben, die eine App-Instanz empfangen und verarbeiten kann, bevor Knative ein Scale-up für Ihre App-Instanzen durchführt. Wenn Sie beispielsweise die maximale Anzahl Anforderungen auf 1 setzen, kann Ihre App-Instanz jeweils nur eine Anforderung empfangen. Wenn eine zweite Anforderung eingeht, bevor die erste vollständig verarbeitet wurde, führt Knative eine Scale-up um eine weitere Instanz durch.

```
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: myservice
spec:
  runLatest:
    configuration:
      revisionTemplate:
        spec:
          container:
            image: myimage
          containerConcurrency: 1
....
```
{: codeblock}

<table>
<caption>Erklärung der Komponenten der YAML-Datei</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
</thead>
<tbody>
<tr>
<td><code>containerConcurrency</code></td>
<td>Geben Sie die maximale Anzahl Anforderungen ein, die eine App-Instanz gleichzeitig empfangen kann, bevor Knative ein Scale-up für Ihre App-Instanzen durchführt.  </td>
</tr>
</tbody>
</table>

### Nur private serverunabhängige Apps erstellen
{: #knative-private-only}

Standardmäßig wird jedem Knative-Service eine öffentliche Route von Ihrer Istio-Ingress-Unterdomäne und eine private Route im Format `<servicename>.<namensbereich>.cluster.local` zugeordnet. Sie können die öffentliche Route für den Zugriff auf die App über das öffentliche Netz verwenden. Wenn Ihr Service privat bleiben soll, können Sie Ihrem Knative-Service die Bezeichnung `serving.knative.dev/visibility` hinzufügen. Diese Bezeichnung weist Knative an, Ihrem Service nur einen privaten Hostnamen zuzuordnen.
{: shortdesc}

```
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: myservice
  labels:
    serving.knative.dev/visibility: cluster-local
spec:
  runLatest:
    configuration:
      revisionTemplate:
        spec:
          container:
            image:
...
```
{: codeblock}

<table>
<caption>Erklärung der Komponenten der YAML-Datei</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
</thead>
<tbody>
<tr>
<td><code>serving.knative.dev/visibility</code></td>
  <td>Wenn Sie die Bezeichnung <code>serving.knative.dev/visibility: cluster-local</code> hinzufügen, wird Ihrem Service nur eine private Route im Format <code>&lt;servicename&gt;.&lt;namensbereich&gt;.cluster.local</code> zugeordnet. Sie können den privaten Hostnamen für den Zugriff auf Ihren Service von innerhalb des Clusters aus verwenden, Sie können aber nicht über das öffentliche Netz auf Ihren Service zugreifen.  </td>
</tr>
</tbody>
</table>

### Knative-Service zum erneuten Extrahieren eines Container-Images zwingen
{: #knative-repull-image}

Die aktuelle Implementierung von Knative bietet kein Standardverfahren, mit dem Ihre Knative-Komponente `Serving` zum erneuten Extrahieren eines Container-Images gezwungen werden kann. Wenn Sie ein Image erneut aus Ihrer Registry extrahieren möchten, wählen Sie zwischen den folgenden Optionen:

- **Ändern Sie die `revisionTemplate`**-Instanz des Knative-Service: Die `revisionTemplate`-Instanz eines Knative-Service wird zum Erstellen einer Revision Ihres Knative-Service verwendet. Wenn Sie diese Revisionsvorlage ändern und z. B. die Anmerkung `repullFlag` hinzufügen, muss Knative eine neue Revision für Ihre App erstellen. Im Rahmen der Erstellung der Revision muss Knative prüfen, ob Container-Images aktualisiert wurden. Wenn Sie `imagePullPolicy: Always` festlegen, kann Knative nicht den Image-Cache im Cluster verwenden, sondern muss stattdessen das Image aus Ihrer Container-Registry extrahieren.
   ```
   apiVersion: serving.knative.dev/v1alpha1
   kind: Service
   metadata:
     name: <servicename>
   spec:
     runLatest:
       configuration:
         revisionTemplate:
           metadata:
             annotations:
               repullFlag: 123
           spec:
             container:
               image: <imagename>
               imagePullPolicy: Always
    ```
    {: codeblock}

    Sie müssen den Wert von `repullFlag` jedes Mal ändern, wenn Sie eine neue Revision Ihres Service erstellen wollen, die die neueste Imageversion aus Ihrer Container-Registry extrahiert. Stellen Sie sicher, dass Sie für jede Revision einen eindeutigen Wert verwenden, um zu vermeiden, dass Knative aufgrund von zwei identischen Knative-Service-Konfigurationen eine alte Imageversion verwendet.  
    {: note}

- **Tags zum Erstellen eindeutiger Container-Images verwenden**: Sie können für jedes Container-Image, das Sie erstellen, eindeutige Tags verwenden und auf dieses Image in der Knative-Service-Konfiguration `container.image` verweisen. Im folgenden Beispiel wird `v1` als Image-Tag verwendet. Sie müssen den Image-Tag ändern, um Knative zu zwingen, ein neues Image aus Ihrer Container-Registry zu extrahieren. Verwenden Sie beispielweise `v2` als neuen Image-Tag.
  ```
  apiVersion: serving.knative.dev/v1alpha1
  kind: Service
  metadata:
    name: <servicename>
  spec:
    runLatest:
      configuration:
          spec:
            container:
              image: myapp:v1
              imagePullPolicy: Always
    ```
    {: codeblock}


## Zugehörige Links  
{: #knative-related-links}

- Probieren Sie diesen [Knative-Workshop ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM/knative101/tree/master/workshop) aus, um Ihre erste `Node.js`-Fibonacci-App in Ihrem Cluster bereitzustellen.
  - Erkunden Sie, wie Sie mit der Knative-Basiskomponente `Build` ein Image aus einer Dockerfile in GitHub erstellen und das Image automatisch durch eine Push-Operation in Ihren Namensbereich in {{site.data.keyword.registrylong_notm}} übertragen.  
  - Erfahren Sie, wie Sie das Routing für Netzverkehr aus der von IBM zur Verfügung gestellten Ingress-Domäne zu dem von Knative bereitgestellten Istio-Ingress-Gateway einrichten können.
  - Implementieren Sie eine neue Version Ihrer App und steuern Sie mithilfe von Istio die Menge an Datenverkehr, die an jede App-Version geleitet wird.
- Untersuchen Sie Beispiele für die [Knative-Basiskomponente `Eventing` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/knative/docs/tree/master/eventing/samples).
- Lesen Sie weitere Informationen zu Knative in der [Knative-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/knative/docs).
