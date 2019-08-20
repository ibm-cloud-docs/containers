---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

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



# Lernprogramm: Kubernetes-Cluster erstellen
{: #cs_cluster_tutorial}

Mit diesem Lernprogramm können Sie einen Kubernetes-Cluster in {{site.data.keyword.containerlong}} bereitstellen und verwalten. Machen Sie sich mit der fiktiven Firma für Öffentlichkeitsarbeit (PR-Firma) vertraut, um zu erfahren, wie die Bereitstellung, der Betrieb, die Skalierung und die Überwachung containerisierter Apps in einem Cluster automatisiert werden können, die mit anderen Cloud-Services wie beispielsweise {{site.data.keyword.ibmwatson}} integriert werden.
{:shortdesc}

## Ziele
{: #tutorials_objectives}

In diesem Lernprogramm arbeiten Sie für eine Firma für Öffentlichkeitsarbeit (PR = Public Relations) und führen eine Reihe von Lerneinheiten aus, um eine angepasste Kubernetes-Cluster-Umgebung zu installieren und zu konfigurieren. Zunächst müssen Sie die {{site.data.keyword.cloud_notm}}-CLI einrichten, einen {{site.data.keyword.containershort_notm}}-Cluster erstellen und die Images Ihrer PR-Firma in einer privaten Instanz von {{site.data.keyword.registrylong}} speichern. Anschließend werden Sie einen {{site.data.keyword.toneanalyzerfull}}-Service bereitstellen und ihn an Ihren Cluster binden. Nachdem Sie die Anwendung 'Hello World' in Ihrem Cluster bereitgestellt und getestet haben, werden Sie nach und nach komplexere und hoch verfügbare Versionen Ihrer {{site.data.keyword.watson}}-App bereitstellen, damit Ihre PR-Firma Pressemitteilungen analysieren und Feedback mit der neuesten KI-Technologie empfangen kann.
{:shortdesc}

Im folgenden Diagramm erhalten Sie einen Überblick zu den in diesem Lernprogramm zu installierenden Komponenten.

<img src="images/tutorial_ov.png" width="500" alt="Erstellung eines Clusters und Bereitstellung einer Watson-App - Übersichtsdiagramm" style="width:500px; border-style: none"/>

## Erforderlicher Zeitaufwand
{: #tutorials_time}

60 Minuten


## Zielgruppe
{: #tutorials_audience}

Dieses Lernprogramm ist für Softwareentwickler und Systemadministratoren konzipiert, die zum ersten Mal einen Kubernetes-Cluster erstellen und eine App bereitstellen.
{: shortdesc}

## Voraussetzungen
{: #tutorials_prereqs}

-  Überprüfen Sie die Schritte, die Sie zur [Vorbereitung der Erstellung eines Clusters](/docs/containers?topic=containers-clusters#cluster_prepare) ausführen müssen.
-  Stellen Sie sicher, dass Sie über die folgenden Zugriffsrichtlinien verfügen:
    - Die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.containerlong_notm}}
    - Die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Administrator**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.registrylong_notm}}
    - Die [{{site.data.keyword.Bluemix_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.containerlong_notm}}

## Lerneinheit 1: Clusterumgebung einrichten
{: #cs_cluster_tutorial_lesson1}

Erstellen Sie Ihren Kubernetes-Cluster in der {{site.data.keyword.Bluemix_notm}}-Konsole, installieren Sie die erforderlichen CLIs, richten Sie die Container-Registry ein und definieren Sie den Kontext für Ihren Kubernetes-Cluster in der CLI.
{: shortdesc}

Da die Bereitstellung einige Minuten dauern kann, sollten Sie den Cluster erstellen, bevor Sie die restlichen Komponenten Ihrer Clusterumgebung installieren.

1.  [Erstellen Sie in der {{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/catalog/cluster/create) einen kostenlosen Cluster oder einen Standardcluster mit einem (1) Worker-Pool, in dem sich ein (1) Workerknoten befindet.

    Sie können auch einen [Cluster in der CLI](/docs/containers?topic=containers-clusters#clusters_cli_steps) erstellen.
    {: tip}
2.  Während die Clusterbereitstellung durchgeführt wird, können Sie die [{{site.data.keyword.Bluemix_notm}}-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/cli?topic=cloud-cli-getting-started) installieren. Zu dieser Installation gehören:
    -   {{site.data.keyword.Bluemix_notm}}-Basis-CLI (`ibmcloud`).
    -   {{site.data.keyword.containerlong_notm}}-Plug-in (`ibmcloud ks`). Verwenden Sie dieses Plug-in zur Verwaltung Ihrer Kubernetes-Cluster, z. B. zur Änderung der Größe von Worker-Pools, um die Rechenleistung zu erhöhen, oder zum Binden von {{site.data.keyword.Bluemix_notm}}-Services an den Cluster.
    -   {{site.data.keyword.registryshort_notm}}-Plug-in (`ibmcloud cr`). Mit diesem Plug-in können Sie ein privates Image-Repository in {{site.data.keyword.registryshort_notm}} einrichten und verwalten.
    -   Kubernetes-CLI (`kubectl`). Verwenden Sie diese Befehlszeilenschnittstelle (CLI), um Kubernetes-Ressourcen wie z. B. die Pods und Services Ihrer App bereitzustellen und zu verwalten.

    Wenn Sie stattdessen nach der Erstellung des Clusters die {{site.data.keyword.Bluemix_notm}}-Konsole verwenden möchten, können Sie CLI-Befehle direkt über Ihren Web-Browser im [Kubernetes-Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web) ausführen.
    {: tip}
3.  Melden Sie sich über das Terminal bei Ihrem {{site.data.keyword.Bluemix_notm}}-Konto an. Geben Sie Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden. Wenn Sie über eine eingebundene ID verfügen, dann geben Sie das Flag `--sso` an, um sich anzumelden. Wählen Sie die Region und ggf. als Ziel die Ressourcengruppe (`-g`) aus, in der Sie Ihren Cluster erstellt haben.
    ```
    ibmcloud login [-g <ressourcengruppe>] [--sso]
    ```
    {: pre}
5.  Stellen Sie sicher, dass die Plug-ins ordnungsgemäß installiert wurden.
    ```
    ibmcloud plugin list
    ```
    {: pre}

    Das {{site.data.keyword.containerlong_notm}}-Plug-in wird in den Ergebnissen mit **kubernetes-service**, das {{site.data.keyword.registryshort_notm}}-Plug-in mit **container-registry** angezeigt.
6.  Richten Sie Ihr eigenes privates Image-Repository in {{site.data.keyword.registryshort_notm}} ein, um Docker-Images sicher zu speichern und mit allen Benutzern des Clusters gemeinsam nutzen zu können. In {{site.data.keyword.Bluemix_notm}} ist ein privates Image-Repository durch einen Namensbereich gekennzeichnet. Der Namensbereich dient der Erstellung einer eindeutigen URL zu Ihrem Image-Repository, das Entwickler für den Zugriff auf private Docker-Images verwenden können.
    Erfahren Sie mehr über das [Sichern der persönlichen Daten](/docs/containers?topic=containers-security#pi) bei der Arbeit mit Container-Images.

    Im vorliegenden Beispiel will das PR-Unternehmen lediglich ein Image-Repository in {{site.data.keyword.registryshort_notm}} erstellen und wählt daher `pr-unternehmen` als Namensbereich aus, um alle Images im Konto zu gruppieren. Ersetzen Sie `<namespace>` durch einen Namensbereich Ihrer Wahl, der sich nicht auf das Lernprogramm bezieht.

    ```
    ibmcloud cr namespace-add <namensbereich>
    ```
    {: pre}
7.  Vergewissern Sie sich zuerst, dass die Bereitstellung Ihres Workerknotens abgeschlossen ist, bevor Sie mit dem nächsten Schritt fortfahren.
    ```
    ibmcloud ks workers --cluster <clustername_oder_-id>
    ```
    {: pre}

    Wenn die Bereitstellung Ihres Workerknotens abgeschlossen ist, wechselt der Status zu **Bereit**. Sie können nun mit dem Binden von {{site.data.keyword.Bluemix_notm}}-Services beginnen.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.13.8
    ```
    {: screen}
8.  Legen Sie in Ihrer CLI (Befehlszeilenschnittstelle) den Kontext für Ihren Kubernetes-Cluster fest.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter. Jedes Mal, wenn Sie sich an der {{site.data.keyword.containerlong}}-CLI anmelden, um mit Clustern zu arbeiten, müssen Sie diese Befehle ausführen, um den Pfad zur Konfigurationsdatei des Clusters als Sitzungsvariable festzulegen. Anhand dieser Variablen sucht die Kubernetes-CLI eine lokale Konfigurationsdatei und Zertifikate, die zum Herstellen der Verbindung zum Cluster in {{site.data.keyword.Bluemix_notm}} erforderlich sind.<p class="tip">Sie verwenden Windows PowerShell? Schließen Sie das Flag `--powershell` ein, um Umgebungsvariablen im Windows PowerShell-Format abzurufen.</p>
        ```
        ibmcloud ks cluster-config --cluster <clustername_oder_-id>
        ```
        {: pre}

        Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/    pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}
    2.  Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.
    3.  Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.

        Beispiel für OS X:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Beispielausgabe:

        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.
        ```
        kubectl version  --short
        ```
        {: pre}

        Beispielausgabe:

        ```
        Client Version: v1.13.8
        Server Version: v1.13.8
        ```
        {: screen}

Gute Arbeit! Sie haben die CLIs für die folgenden Lerneinheiten erfolgreich installiert und den Clusterkontext erfolgreich eingerichtet. Als Nächstes werden Sie die Clusterumgebung einrichten und den {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Service hinzufügen.

<br />


## Lerneinheit 2: IBM Cloud-Service zum Cluster hinzufügen
{: #cs_cluster_tutorial_lesson2}

Mit den {{site.data.keyword.Bluemix_notm}}-Services können Sie bereits entwickelte Funktionen in Ihren Apps nutzen. Alle an den Cluster gebundenen {{site.data.keyword.Bluemix_notm}}-Services können von allen Apps genutzt werden, die in diesem Cluster bereitgestellt sind. Wiederholen Sie die folgenden Schritte für jeden {{site.data.keyword.Bluemix_notm}}-Service, den Sie in Verbindung mit Ihren Apps verwenden wollen.
{: shortdesc}

1.  Fügen Sie den {{site.data.keyword.toneanalyzershort}}-Service in derselben Region wie Ihren Cluster zu Ihrem {{site.data.keyword.Bluemix_notm}}-Konto hinzu. Ersetzen Sie `<service_name>` durch einen Namen für Ihre Serviceinstanz und `<region>` durch eine Region, z. B. durch die Region, in der sich Ihr Cluster befindet.

    Wenn Sie den {{site.data.keyword.toneanalyzershort}}-Service zu Ihrem Konto hinzufügen, wird eine Nachricht angezeigt, dass der Service nicht kostenlos ist. Wenn Sie Ihren API-Aufruf einschränken, entstehen im Rahmen dieses Lernprogramms keine Kosten durch den {{site.data.keyword.watson}}-Service. [Informieren Sie sich über die Preisinformationen für den {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/catalog/services/tone-analyzer).
    {: note}

    ```
    ibmcloud resource service-instance-create <service_name> tone-analyzer standard <region>
    ```
    {: pre}
2.  Binden Sie die {{site.data.keyword.toneanalyzershort}}-Instanz an den Kubernetes-Standardnamensbereich (`default`) für den Cluster. Später können Sie Ihren eigenen Namensbereich erstellen, um Benutzerzugriff auf Kubernetes-Ressourcen zu verwalten. Aber für den Moment müssen Sie den Namensbereich `default` verwenden. Kubernetes-Namensbereiche unterscheiden sich von dem Registry-Namensbereich, den Sie davor erstellt haben.
    ```
    ibmcloud ks cluster-service-bind --cluster <clustername> --namespace default --service <servicename>
    ```
    {: pre}

    Beispielausgabe:
    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}
3.  Stellen Sie sicher, dass der geheime Kubernetes-Schlüssel im Namensbereich Ihres Clusters erstellt wurde. Wenn Sie einen [{{site.data.keyword.Bluemix_notm}}-Service an Ihren Cluster binden](/docs/containers?topic=containers-service-binding), wird eine JSON-Datei generiert, die vertrauliche Informationen wie beispielsweise den API-Schlüssel für {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) und die URL enthält, die vom Container für den Zugriff auf den Server benutzt werden. Um diese Informationen sicher zu speichern, wird die JSON-Datei in einem geheimen Kubernetes-Schlüssel gespeichert.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Beispielausgabe:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
Ganz hervorragend! Der Cluster ist konfiguriert und Ihre lokale Umgebung ist jetzt so vorbereitet, dass Sie mit der Bereitstellung von Apps im Cluster beginnen können.

Bevor Sie mit der nächsten Lerneinheit fortfahren, sollten Sie Ihr Wissen prüfen und an einem [kurzen Quiz teilnehmen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php).
{: note}

<br />


## Lerneinheit 3: Einzelinstanz-Apps auf Kubernetes-Clustern bereitstellen
{: #cs_cluster_tutorial_lesson3}

In der vorherigen Lerneinheit haben Sie einen Cluster mit einem Workerknoten eingerichtet. In dieser Lerneinheit konfigurieren Sie eine Bereitstellung und stellen eine einzelne Instanz der App in einem Kubernetes-Pod im Workerknoten bereit.
{:shortdesc}

Das folgende Diagramm zeigt die Komponenten, die Sie im Rahmen dieser Lerneinheit bereitstellen.

![Konfiguration für die Bereitstellung](images/cs_app_tutorial_mz-components1.png)

Gehen Sie wie folgt vor, um die App bereitzustellen:

1.  Klonen Sie den Quellcode für die [App 'Hello World' ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM/container-service-getting-started-wt) in Ihr Benutzerausgangsverzeichnis. Das Repository enthält verschiedene Versionen einer ähnlichen App in Ordnern, deren Namen jeweils mit `Lab` beginnen. Jede Version enthält die folgenden Dateien:
    *   `Dockerfile`: Die Builddefinitionen für das Image.
    *   `app.js`: Die App 'Hello World'.
    *   `package.json`: Metadaten zur App.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

2.  Navigieren Sie zum Verzeichnis `Lab 1`.
    ```
    cd 'container-service-getting-started-wt/Lab 1'
    ```
    {: pre}
3.  Melden Sie sich an der {{site.data.keyword.registryshort_notm}}-CLI an.
    ```
    ibmcloud cr login
    ```
    {: pre}

    Wenn Sie Ihren Namensbereich in {{site.data.keyword.registryshort_notm}} vergessen haben, führen Sie den folgenden Befehl aus.
    ```
    ibmcloud cr namespace-list
    ```
    {: pre}
4.  Erstellen Sie ein Docker-Image, das die App-Dateien aus dem Verzeichnis `Lab 1` enthält, und übertragen Sie das Image mit einer Push-Operation an den {{site.data.keyword.registryshort_notm}}-Namensbereich, den Sie in der vorherigen Lerneinheit erstellt haben. Falls zu einem späteren Zeitpunkt Änderungen an der App vorgenommen werden sollen, wiederholen Sie diese Schritte, um eine weitere Version des Image zu erstellen. **Hinweis**: Erfahren Sie mehr über das [Sichern der persönlichen Daten](/docs/containers?topic=containers-security#pi) bei der Arbeit mit Container-Images.

    Verwenden Sie im Imagenamen nur alphanumerische Zeichen in Kleinschreibung oder Unterstreichungszeichen (`_`). Vergessen Sie nicht den Punkt (`.`) am Ende des Befehls. Der Punkt signalisiert Docker, im aktuellen Verzeichnis nach der Dockerfile zu suchen und Artefakte zum Erstellen des Image zu erstellen. **Hinweis**: Sie müssen eine [Registry-Region](/docs/services/Registry?topic=registry-registry_overview#registry_regions) (z. B. `us`) angeben. Zum Abrufen der Registry-Region, in der Sie sich zurzeit befinden, führen Sie `ibmcloud cr region` aus.

    ```
    ibmcloud cr build -t <region>.icr.io/<namensbereich>/hello-world:1 .
    ```
    {: pre}

    Überprüfen Sie nach der Beendigung des Buildprozesses, dass die folgende Nachricht über die erfolgreiche Ausführung angezeigt wird:

    ```
    Successfully built <image-id>
    Successfully tagged <region>.icr.io/<namensbereich>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namensbereich>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
5.  Erstellen Sie eine Bereitstellung. Bereitstellungen werden zum Verwalten von Pods verwendet, die containerisierte Instanzen einer App enthalten. Der folgende Befehl dient zur Bereitstellung der App in einem einzelnen Pod. Dabei wird auf das Image verwiesen, das Sie in Ihrer privaten Registry erstellt haben. Im vorliegenden Lernprogramm wird der Bereitstellung der Name **hello-world-deployment** zugeordnet. Sie können jedoch einen eigenen Namen verwenden.```
    kubectl create deployment hello-world-deployment --image=<region>.icr.io/<namensbereich>/hello-world:1
    ```
    {: pre}

    Beispielausgabe:
    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Erfahren Sie mehr über das [Sichern der persönlichen Daten](/docs/containers?topic=containers-security#pi) bei der Arbeit mit Kubernetes-Ressourcen.
6.  Machen Sie die App zugänglich, indem Sie die Bereitstellung als Service vom Typ 'NodePort' zur Verfügung stellen. Genau wie beim Zugänglichmachen eines Ports für eine Cloud Foundry-App machen Sie als Knotenport (NodePort) den Port zugänglich, an dem der Workerknoten für Datenverkehr empfangsbereit ist.
    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Beispielausgabe:
    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table summary="Informationen zu den Parametern des Befehls 'expose'.">
    <caption>Weitere Informationen zu den Parametern von 'expose'</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Weitere Informationen zu den Parametern von 'expose'</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Macht eine Ressource als Kubernetes Service verfügbar und macht sie den Benutzern öffentlich zugänglich.</td>
    </tr>
    <tr>
    <td><code>deployment/<em>&lt;hello-world-deployment&gt;</em></code></td>
    <td>Der Ressourcentyp und der Name der Ressource, die mit diesem Service verfügbar gemacht werden soll.</td>
    </tr>
    <tr>
    <td><code>--name=<em>&lt;hello-world-service&gt;</em></code></td>
    <td>Der Name des Service.</td>
    </tr>
    <tr>
    <td><code>--port=<em>&lt;8080&gt;</em></code></td>
    <td>Der Port, an dem der Service bereitgestellt wird.</td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>Der Typ des Service, der erstellt werden soll.</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>Der Port, an den der Service den Datenverkehr leitet. In dieser Instanz ist der Zielport mit dem Port identisch, andere von Ihnen erstellte Apps können hiervon jedoch abweichen.</td>
    </tr>
    </tbody></table>
7. Nachdem alle Schritte für die Bereitstellung ausgeführt worden sind, können Sie Ihre App in einem Browser testen. Rufen Sie die Details ab, um die zugehörige URL zu bilden.
    1.  Rufen Sie Informationen zum Service ab, um zu erfahren, welcher Knotenport (NodePort) zugewiesen wurde.
        ```
        kubectl describe service hello-world-service
        ```
        {: pre}

        Beispielausgabe:
        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.xxx.xx.xxx
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.xxx.xxx:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Knotenportnummern (NodePort) werden nach dem Zufallsprinzip zugewiesen, wenn sie mit dem Befehl `expose` generiert werden, bewegen sich aber im Bereich 30000-32767. Im vorliegenden Beispiel lautet die Portnummer für den Service vom Typ 'NodePort' 30872.
    2.  Rufen Sie die öffentliche IP-Adresse für den Workerknoten im Cluster ab.
        ```
        ibmcloud ks workers --cluster <clustername_oder_-id>
        ```
        {: pre}

        Beispielausgabe:
        ```
        ibmcloud ks workers --cluster pr_firm_cluster
        Listing cluster workers...
        OK
        ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
        kube-mil01-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.13.8
        ```
        {: screen}
8. Öffnen Sie einen Browser und überprüfen Sie die App mit der folgenden URL: `http://<IP_address>:<NodePort>`. Anhand der Werte im Beispiel lautet die URL wie folgt: `http://169.xx.xxx.xxx:30872`. Bei Eingabe dieser URL in einen Browser wird folgender Text angezeigt.
    ```
    Hello world! Your app is up and running in a cluster!
    ```
    {: screen}

    Um zu überprüfen, ob die App öffentlich verfügbar ist, versuchen Sie, sie im Browser Ihres Mobiltelefons einzugeben.
    {: tip}
9. [Starten Sie das Kubernetes-Dashboard](/docs/containers?topic=containers-app#cli_dashboard).

    Wenn Sie den Cluster in der [{{site.data.keyword.Bluemix_notm}}-Konsole](https://cloud.ibm.com/) auswählen, können Sie über die Schaltfläche **Kubernetes-Dashboard** das Dashboard mit einem einzigen Klick starten.
    {: tip}
10. Auf der Registerkarte **Workloads** werden die von Ihnen erstellten Ressourcen angezeigt.

Gute Arbeit! Sie haben die erste Version der App bereitgestellt.

Sie sind der Ansicht, dass diese Lerneinheit zu viele Befehle enthält? Ganz Ihrer Meinung. Warum also verwenden Sie nicht ein Konfigurationsscript, das Ihnen einen Teil der Arbeit abnimmt? Um für die zweite Version der App ein Konfigurationsscript zu verwenden und durch die Bereitstellung mehrerer Instanzen dieser App ein höheres Maß an Verfügbarkeit erreichen, fahren Sie mit der nächsten Lerneinheit fort.

**Bereinigung**<br>
Möchten Sie die Ressourcen löschen, die Sie in dieser Lerneinheit erstellt haben, bevor Sie fortfahren? Als Sie die Bereitstellung erstellt haben, hat Kubernetes der Bereitstellung eine Bezeichnung (z. B. `app=hello-world-deployment` oder eine andere, von Ihnen für die Bereitstellung gewählte Bezeichnung) zugeordnet. Als Sie die Bereitstellung zugänglich gemacht haben, hat Kubernetes die gleiche Bezeichnung für den von Ihnen erstellten Service angewendet. Bezeichnungen stellen nützliche Tools zum Organisieren Ihrer Kubernetes-Ressourcen dar, die Ihnen die Anwendung von Massenaktionen wie beispielsweise `get` oder `delete` auf diese Ressourcen ermöglichen.

  Sie können Ihre sämtlichen Ressourcen überprüfen, die über die Bezeichnung `app=hello-world-deployment` verfügen.
  ```
  kubectl get all -l app=hello-world-deployment
  ```
  {: pre}

  Anschließend können Sie alle Ressourcen mit dieser Bezeichnung löschen.
  ```
  kubectl delete all -l app=hello-world-deployment
  ```
  {: pre}

  Beispielausgabe:
  ```
  pod "hello-world-deployment-5c78f9b898-b9klb" deleted
  service "hello-world-service" deleted
  deployment.apps "hello-world-deployment" deleted
  ```
  {: screen}

<br />


## Lerneinheit 4: Apps mit höherer Verfügbarkeit bereitstellen und aktualisieren
{: #cs_cluster_tutorial_lesson4}

In dieser Lerneinheit stellen Sie drei Instanzen der App 'Hello World' in einem Cluster mit höherer Verfügbarkeit als in der ersten Version der App bereit.
{:shortdesc}

Höhere Verfügbarkeit bedeutet, dass der Benutzerzugriff auf drei Instanzen aufgeteilt ist. Versuchen zu viele Benutzer, auf dieselbe Instanz der App zuzugreifen, so können schleppende Reaktionszeiten auftreten. Eine höhere Anzahl von Instanzen kann für Ihre Benutzer gleichbedeutend mit geringeren Reaktionszeiten sein. In der vorliegenden Lerneinheit erfahren Sie außerdem, wie Statusprüfungen und Bereitstellungsaktualisierungen mit Kubernetes funktionieren können. Das folgende Diagramm enthält die von Ihnen im Rahmen der Lerneinheit bereitgestellten Komponenten.

![Konfiguration für die Bereitstellung](images/cs_app_tutorial_mz-components2.png)

In den vorherigen Lerneinheiten haben Sie Ihren Cluster mit einem (1) Workerknoten erstellt und eine einzelne Instanz einer App bereitgestellt. In dieser Lerneinheit konfigurieren Sie eine Bereitstellung und stellen drei Instanzen der App 'Hello World' bereit. Jede dieser Instanzen wird in einem Kubernetes-Pod als Teil einer Replikatgruppe im Workerknoten implementiert. Um die App öffentlich zu machen, erstellen Sie zudem einen Kubernetes Service.

Wie im Konfigurationsscript definiert kann Kubernetes anhand einer Verfügbarkeitsprüfung feststellen, ob ein Container in einem Pod aktiv oder inaktiv ist. Mit diesen Prüfungen können gegebenenfalls Deadlocks abgefangen werden, bei denen eine App zwar aktiv, nicht aber in der Lage ist, Verarbeitungsfortschritt zu machen. Durch den Neustart eines Containers, der sich in einem solchen Zustand befindet, ist es möglich, die Verfügbarkeit der App trotz Fehlern zu erhöhen. Anhand einer Bereitschaftsprüfung ermittelt Kubernetes dann, wann ein Container wieder für die Entgegennahme von Datenverkehr ist. Ein Pod gilt als bereit, wenn sein Container bereit ist. Wenn der Pod bereit ist, wird er wieder gestartet. In dieser Version der App wird das Zeitlimit alle 15 Sekunden überschritten. Da im Konfigurationsscript eine Statusprüfung konfiguriert ist, werden Container erneut  erstellt, falls bei der Statusprüfung ein Problem im Zusammenhang mit der App festgestellt wird.

Wenn Sie nach der letzten Lerneinheit eine Pause gemacht und ein neues Terminal gestartet haben, stellen Sie sicher, dass Sie sich erneut bei Ihrem Cluster anmelden.

1.  Navigieren Sie in Ihrem Terminal zum Verzeichnis `Lab 2`.
    ```
    cd 'container-service-getting-started-wt/Lab 2'
    ```
    {: pre}
2.  Erstellen und kennzeichnen (taggen) Sie die App und übertragen Sie sie per Push als Image an Ihren Namensbereich in {{site.data.keyword.registryshort_notm}}. Vergessen Sie nicht den Punkt (`.`) am Ende des Befehls.
    ```
    ibmcloud cr build -t <region>.icr.io/<namensbereich>/hello-world:2 .
      ```
    {: pre}

    Stellen Sie sicher, dass die Nachricht über die erfolgreiche Ausführung angezeigt wird.
    ```
    Successfully built <image-id>
    Successfully tagged <region>.icr.io/<namensbereich>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namensbereich>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
3.  Öffnen Sie im Verzeichnis `Lab 2` die Datei `healthcheck.yml` mit einem Texteditor. Dieses Konfigurationsscript verbindet einige Schritte aus der vorherigen Lerneinheit, um zur gleichen Zeit eine Bereitstellung sowie einen Service zu erstellen. Die App-Entwickler des PR-Unternehmens können diese Scripts verwenden, wenn Aktualisierungen durchgeführt werden. Sie können sie auch im Rahmen der Fehlerbehebung einsetzen, indem Sie die Pods neu erstellen.
    1.  Aktualisieren Sie die Details für das Image in Ihrem privaten Registry-Namensbereich.
        ```
        image: "<region>.icr.io/<namensbereich>/hello-world:2"
        ```
        {: codeblock}
    2.  Beachten Sie im Abschnitt **Deployment** für die Bereitstellung die Angabe für die Anzahl der Replikate (`replicas`). Replikate sind gleichbedeutend mit der Anzahl von Instanzen Ihrer App. Durch Ausführen von drei Instanzen ist die Verfügbarkeit der App sehr viel höher als dies bei Ausführung von nur einer Instanz der Fall wäre.
        ```
        replicas: 3
        ```
        {: codeblock}
    3.  Beachten Sie die HTTP-Aktivitätsprüfung (livenessProbe), die den Zustand des Containers alle 5 Sekunden überprüft.
        ```
        livenessProbe:
                    httpGet:
                      path: /healthz
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 5
        ```
        {: codeblock}
    4.  Beachten Sie im Abschnitt **Service** die Angabe für die Knotenportnummern (`NodePort`). Anstatt einen Knotenport nach dem Zufallsprinzip generieren zu lassen, wie das der Fall in der vorherigen Lerneinheit war, können Sie eine Portnummer im Bereich 30000-32767 angeben. Das vorliegende Beispiel verwendet die Nummer 30072.
4.  Wechseln Sie zurück zu der CLI, die Sie zum Definieren des Clusterkontexts verwendet haben, und führen Sie das Konfigurationsscript aus. Wenn die Bereitstellung und der Service erstellt worden sind, kann die App gegenüber den Benutzern des PR-Unternehmens verfügbar gemacht werden.```
    kubectl apply -f healthcheck.yml
    ```
    {: pre}

    Beispielausgabe:
    ```
    deployment "hw-demo-deployment" created
  service "hw-demo-service" created
    ```
    {: screen}
5.  Nachdem die Bereitstellung nun abgeschlossen ist, können Sie einen Browser öffnen und die App überprüfen. Um die URL zu bilden, kombinieren Sie die öffentliche IP-Adresse, die Sie in der vorherigen Lerneinheit für Ihren Workerknoten verwendet haben, mit der Knotenportnummer (NodePort), die im Konfigurationsscript angegeben war. So rufen Sie die öffentliche IP-Adresse für den Workerknoten ab:
    ```
    ibmcloud ks workers --cluster <clustername_oder_-id>
    ```
    {: pre}

    Anhand der Werte im Beispiel lautet die URL wie folgt: `http://169.xx.xxx.xxx:30072`. Bei Eingabe dieser URL in einen Browser wird gegebenenfalls der folgende Text angezeigt. Falls dieser Text nicht angezeigt wird, machen Sie sich keine Gedanken. Diese App wurde für alternierende Intervalle von Aktivität und Inaktivität konzipiert.
    ```
    Hello world! Great job getting the second stage up and running! (Hallo Welt! Sie haben Stage2 hervorragend umgesetzt.)
    ```
    {: screen}

    Sie können den Status auch unter `http://169.xx.xxx.xxx:30072/healthz` überprüfen.

    Während der ersten 10-15 Sekunden wird eine Nachricht vom Typ 200 zurückgegeben. Dadurch wissen Sie, dass die App erfolgreich ausgeführt wird. Nach Verstreichen dieser 15 Sekunden wird eine Zeitlimitnachricht angezeigt. Dies entspricht dem erwarteten Verhalten.
    ```
    {
      "error": "Timeout, Health check error!" ("Fehler": "Zeitlimitüberschreitung, Fehler bei Statusprüfung!")
    }
    ```
    {: screen}
6.  Überprüfen Sie Ihren Podstatus, um den Zustand Ihrer App in Kubernetes zu überwachen. Sie können den Status über die CLI oder im Kubernetes-Dashboard überprüfen.
    *   **Über die CLI**: Beobachten Sie, was mit Ihren Pods geschieht, während sich ihr Status ändert.
        ```
        kubectl get pods -o wide -w
        ```
        {: pre}
    *   **Im Kubernetes-Dashboard**:
        1.  [Starten Sie das Kubernetes-Dashboard](/docs/containers?topic=containers-app#cli_dashboard).
        2.  Auf der Registerkarte **Workloads** werden die von Ihnen erstellten Ressourcen angezeigt. Von dieser Registerkarte aus können Sie die Anzeige fortlaufend aktualisieren lassen und sicherstellen, dass die Statusprüfung ordnungsgemäß funktioniert. Im Abschnitt **Pods** wird angegeben, wie häufig die Pods erneut gestartet werden, wenn die in ihnen enthaltenen Container erneut erstellt werden. Falls Sie per Zufall den folgenden Fehler im Dashboard abfangen, so beachten Sie, das diese Nachricht darauf hinweist, dass bei der Statusprüfung ein Problem festgestellt wurde. Warten Sie einige Minuten ab und aktualisieren Sie dann die Anzeige erneut. Sie können erkennen, dass die Anzahl von Neustarts für jeden Pod variiert.
        ```
        Liveness probe failed: HTTP probe failed with statuscode: 500
        Back-off restarting failed docker container
        Error syncing pod, skipping: failed to "StartContainer" for "hw-container" w      CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-d     deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
        ```
        {: screen}

Sie haben nun die zweite Version der App bereitgestellt. Hierzu haben Sie eine geringere Anzahl von Befehlen verwenden müssen, konnten erfahren, wie Statusprüfungen funktionieren, und haben eine Bereitstellung bearbeitet, was hervorragend ist. Die App 'Hello World' hat den Test für das PR-Unternehmen bestanden. Nun können Sie eine App mit höherem Nutzwert für das PR-Unternehmen bereitstellen, um mit der Analyse von Pressemitteilungen zu beginnen.

**Bereinigung**<br>
Sind Sie bereit, die von Ihnen erstellten Elemente zu löschen, bevor Sie mit der nächsten Lerneinheit fortfahren? Dieses Mal können Sie dasselbe Konfigurationsscript verwenden, um die beiden von Ihnen erstellten Ressourcen zu löschen.

  ```
  kubectl delete -f healthcheck.yml
  ```
  {: pre}

  Beispielausgabe:

  ```
  deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
  ```
  {: screen}

<br />


## Lerneinheit 5: App 'Watson Tone Analyzer' bereitstellen und aktualisieren
{: #cs_cluster_tutorial_lesson5}

In den vorherigen Lerneinheiten wurden die Apps als einzelne Komponenten in einem Workerknoten bereitgestellt. In dieser Lerneinheit stellen Sie zwei Komponenten einer App in einem Cluster bereit, die den Service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} verwenden.
{:shortdesc}

Durch das Aufteilen der Komponenten auf verschiedene Container stellen Sie sicher, dass Sie ein Element aktualisieren können, ohne dass sich dies nachteilig auf die übrigen auswirkt. Dann aktualisieren Sie die App, um sie mit einer größeren Anzahl von Replikaten vertikal zu skalieren und so ihre Verfügbarkeit weiter zu steigern. Das folgende Diagramm enthält die von Ihnen im Rahmen der Lerneinheit bereitgestellten Komponenten.

![Konfiguration für die Bereitstellung](images/cs_app_tutorial_mz-components3.png)

Aus dem vorherigen Lernprogramm verfügen Sie bereits über ein Konto und einen Cluster mit einem Workerknoten. In dieser Lerneinheit erstellen Sie eine Instanz des {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Service in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto und konfigurieren zwei Bereitstellungen (eine Bereitstellung für jede Komponente der App). Jede Komponente wird in einem Kubernetes-Pod im Workerknoten implementiert. Um beide Komponenten öffentlich zu machen, erstellen Sie zudem für jede Komponente einen Kubernetes Service.


### Lerneinheit 5a: App '{{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}' bereitstellen
{: #lesson5a}

Stellen Sie die {{site.data.keyword.watson}}-Apps bereit, greifen Sie öffentlich auf den Service zu und analysieren Sie ein Textelement mit der App.
{: shortdesc}

Wenn Sie nach der letzten Lerneinheit eine Pause gemacht und ein neues Terminal gestartet haben, stellen Sie sicher, dass Sie sich erneut bei Ihrem Cluster anmelden.

1.  Navigieren Sie in einer CLI (Befehlszeilenschnittstelle) zum Verzeichnis `Lab 3`.
    ```
    cd 'container-service-getting-started-wt/Lab 3'
    ```
    {: pre}

2.  Erstellen Sie das erste {{site.data.keyword.watson}}-Image.
    1.  Navigieren Sie zum Verzeichnis `watson`.
        ```
        cd watson
        ```
        {: pre}
    2.  Erstellen und kennzeichnen (taggen) Sie die `watson`-App und übertragen Sie sie per Push als Image an Ihren Namensbereich in {{site.data.keyword.registryshort_notm}}. Vergessen Sie auch hier nicht den Punkt (`.`) am Ende des Befehls.
        ```
        ibmcloud cr build -t <region>.icr.io/<namensbereich>/watson .
        ```
        {: pre}

        Stellen Sie sicher, dass die Nachricht über die erfolgreiche Ausführung angezeigt wird.
        ```
        Successfully built <image-id>
        ```
        {: screen}
    3.  Wiederholen Sie diese Schritte, um das zweite Image für `watson-talk` zu erstellen.
        ```
        cd 'container-service-getting-started-wt/Lab 3/watson-talk'
        ```
        {: pre}

        ```
        ibmcloud cr build -t <region>.icr.io/<namensbereich>/watson-talk .
        ```
        {: pre}
3.  Überprüfen Sie, ob die Images erfolgreich zu Ihrem Registry-Namensbereich hinzugefügt wurden.
    ```
    ibmcloud cr images
    ```
    {: pre}

    Beispielausgabe:

    ```
    Listing images...

    REPOSITORY                        NAMESPACE  TAG      DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    us.icr.io/namespace/watson        namespace  latest   fedbe587e174   3 minutes ago   274 MB   OK
    us.icr.io/namespace/watson-talk   namespace  latest   fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}
4.  Öffnen Sie im Verzeichnis `Lab 3` die Datei `watson-deployment.yml` mit einem Texteditor. Dieses Konfigurationsscript enthält sowohl für die `watson`- als auch die `watson-talk`-Komponente der App eine Bereitstellung und einen Service.
    1.  Aktualisieren Sie für beide Bereitstellungen die Details für das Image in Ihrem Registry-Namensbereich.
        **watson**:
        ```
        image: "<region>.icr.io/<namensbereich>/watson"
        ```
        {: codeblock}

        **watson-talk**:
        ```
        image: "<region>.icr.io/<namensbereich>/watson-talk"
        ```
        {: codeblock}
    2.  Aktualisieren Sie im Datenträgerabschnitt ('volumes') der `watson-pod`-Bereitstellung den Namen des geheimen Schlüssels für {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}, den Sie in [Lerneinheit 2](#cs_cluster_tutorial_lesson2) erstellt haben. Wenn Sie den geheimen Kubernetes-Schlüssel als Datenträger an Ihre Bereitstellung anhängen, stellen Sie den API-Schlüssel von {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) für den Container zur Verfügung, der in Ihrem Pod ausgeführt wird. Die {{site.data.keyword.watson}}-App-Komponenten in diesem Lernprogramm sind so konfiguriert, dass sie den API-Schlüssel unter Verwendung des Datenträgermountpfads suchen.
        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-mytoneanalyzer
        ```
        {: codeblock}

        Falls Sie vergessen haben, welchen Namen Sie dem geheimen Schlüssel zugeordnet haben, führen Sie den folgenden Befehl aus.
        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}
    3.  Beachten Sie im Abschnitt für den Service 'watson-talk' die Knotenportnummer, die für `NodePort` festgelegt ist. Das vorliegende Beispiel verwendet die Nummer 30080.
5.  Führen Sie das Konfigurationsscript aus.
    ```
    kubectl apply -f watson-deployment.yml
    ```
    {: pre}
6.  Optional: Überprüfen Sie, ob der geheime Schlüssel für {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} als Datenträger an den Pod angehängt wurde.
    1.  Wenn Sie den Namen eines Watson-Pods abrufen wollen, führen Sie den folgenden Befehl aus:
        ```
        kubectl get pods
        ```
        {: pre}

        Beispielausgabe:
        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}
    2.  Rufen Sie die Details zum Pod ab und suchen Sie den Namen des geheimen Schlüssels.
        ```
        kubectl describe pod <podname>
        ```
        {: pre}

        Beispielausgabe:
        ```
        Volumes:
          service-bind-volume:
            Type:       Secret (Datenträger, der mit einem geheimen Schlüssel belegt ist)
            SecretName: binding-mytoneanalyzer
          default-token-j9mgd:
            Type:       Secret (Datenträger, der mit einem geheimen Schlüssel belegt ist)
            SecretName: default-token-j9mgd
        ```
        {: codeblock}
7.  Öffnen Sie einen Browser und analysieren Sie Text. Die URL weist das folgende Format auf: `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"`.
    Beispiel:
    ```
    http://169.xx.xxx.xxx:30080/analyze/"Heute ist ein herrlicher Tag"
    ```
    {: codeblock}

    In einem Browser wird die JSON-Antwort auf den von Ihnen eingegebenen Text angezeigt.
    ```
    {
      "document_tone": {
        "tone_categories": [
          {
            "tones": [
              {
                "score": 0.011593,
                "tone_id": "anger",
                "tone_name": "Anger"
              },
              ...
            "category_id": "social_tone",
            "category_name": "Social Tone"
          }
        ]
      }
    }
    ```
    {: screen}
8. [Starten Sie das Kubernetes-Dashboard](/docs/containers?topic=containers-app#cli_dashboard).
9. Auf der Registerkarte **Workloads** werden die von Ihnen erstellten Ressourcen angezeigt.

### Lerneinheit 5b: Aktive Bereitstellung von 'Watson Tone Analyzer' aktualisieren
{: #lesson5b}

Während der Ausführung einer Bereitstellung können Sie die Bereitstellung durch Änderung von Werten in der Pod-Vorlage bearbeiten. In dieser Lerneinheit möchte die PR-Firma die App in der Bereitstellung ändern, indem sie das verwendete Image aktualisiert.
{: shortdesc}

Ändern Sie den Namen des Image:

1.  Öffnen Sie die Konfigurationsdetails für die aktive Bereitstellung.
    ```
    kubectl edit deployment/watson-talk-pod
    ```
    {: pre}

    Abhängig vom verwendeten Betriebssystem wird ein Editor vom Typ 'vi' oder ein Texteditor geöffnet.
2.  Ändern Sie den Namen des Image und geben Sie das Image `ibmliberty` an.
    ```
    spec:
          containers:
          - image: <region>.icr.io/ibmliberty:latest
    ```
    {: codeblock}
3.  Speichern Sie die Änderungen und beenden Sie den Editor.
4.  Wenden Sie die Änderungen auf die aktive Bereitstellung an.
    ```
    kubectl rollout status deployment/watson-talk-pod
    ```
    {: pre}

    Warten Sie die Bestätigung ab, dass der Rollout vollständig abgeschlossen wurde.
    ```
    deployment "watson-talk-pod" successfully rolled out
    ```
    {: screen}
    Wenn Sie eine Änderung implementieren, wird ein weiterer Pod von Kubernetes erstellt getestet. Wenn der Test erfolgreich ist, wird der alte Pod entfernt.

Gute Arbeit! Sie haben die App {{site.data.keyword.watson}}{{site.data.keyword.toneanalyzershort}} bereitgestellt und gelernt, wie eine einfache App-Aktualisierung ausgeführt werden kann. Die PR-Firma kann diese Bereitstellung benutzen, um mit der Analyse ihrer Pressemitteilungen mit der neuesten KI-Technologie zu beginnen.

**Bereinigung**<br>
Sind Sie bereit zum Löschen der {{site.data.keyword.watson}}-App für {{site.data.keyword.toneanalyzershort}}, die Sie in Ihrem {{site.data.keyword.containerlong_notm}}-Cluster erstellt haben? Zum Löschen der von Ihnen erstellten Ressourcen können Sie das Konfigurationsscript verwenden.

  ```
  kubectl delete -f watson-deployment.yml
  ```
  {: pre}

  Beispielausgabe:

  ```
  deployment "watson-pod" deleted
  deployment "watson-talk-pod" deleted
  service "watson-service" deleted
  service "watson-talk-service" deleted
  ```
  {: screen}

  Falls Sie den Cluster nicht beibehalten wollen, können Sie diesen ebenfalls löschen.

  ```
  ibmcloud ks cluster-rm --cluster <clustername_oder_-id>
  ```
  {: pre}

Zeit für eine Lernzielkontrolle! Sie haben nun zahlreiche Informationen erhalten und sollten sich deswegen [vergewissern, dass Sie alles verstanden haben ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php). Keine Sorge - Diese Lernzielkontrolle ist nicht kumulativ aufgebaut!
{: note}

<br />


## Womit möchten Sie fortfahren?
{: #tutorials_next}

Nachdem Sie sich mit den grundlegenden Informationen vertraut gemacht haben, können Sie nun komplexere Aufgaben in Angriff nehmen. Machen Sie sich mit einer der folgenden Ressourcen vertraut, um weitere Arbeitsschritte mit {{site.data.keyword.containerlong_notm}} auszuführen.
{: shortdesc}

*   Führen Sie ein [komplexeres Lab ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM/container-service-getting-started-wt#lab-overview) im Repository aus.
*   Erfahren Sie mehr über die Erstellung von [hoch verfügbaren Apps](/docs/containers?topic=containers-ha), indem Sie Funktionen wie beispielsweise Cluster mit mehreren Zonen, persistenten Speicher, die Funktion zur automatischen Skalierung von Clustern und die Funktion für die automatische horizontale Skalierung von Pods für Apps verwenden.
*   Machen Sie sich mit den Codemustern der Containerorchestrierung in [IBM Developer ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/technologies/containers/) vertraut.
