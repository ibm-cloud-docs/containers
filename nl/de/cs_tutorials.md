---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-16"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Lernprogramm: Cluster erstellen
{: #cs_cluster_tutorial}

Stellen Sie einen eigenen Kubernetes-Cluster in der Cloud bereit und verwalten Sie diesen Cluster. Sie können die Bereitstellung, den Betrieb, die Skalierung und Überwachung containerisierter Apps in einem Cluster unabhängiger Rechenhosts (sog. Workerknoten) automatisieren.
{:shortdesc}

In der vorliegenden Reihe von Lernprogrammen werden Sie erfahren, wie eine fiktive Public-Relations-Firma Kubernetes verwendet, um eine containerisierte App in {{site.data.keyword.Bluemix_short}} bereitzustellen. Diese PR-Firma nutzt {{site.data.keyword.toneanalyzerfull}} zur Analyse ihrer Pressemitteilungen und zum Empfang von Feedback.


## Ziele

Im ersten Lernprogramm fungieren Sie als Netzadministrator der PR-Firma. Sie konfigurieren einen angepassten Kubernetes-Cluster, der zur Bereitstellung und zum Testen einer Hello World-Version der App verwendet wird.

Führen Sie die folgenden Schritte aus, um die Infrastruktur einzurichten:

-   Kubernetes-Cluster mit einem Workerknoten erstellen
-   CLIs zum Verwenden der Kubernetes-API und zum Verwalten von Docker-Images installieren
-   Privates Image-Repository in {{site.data.keyword.registrylong_notm}} zum Speichern von Images erstellen
-   {{site.data.keyword.toneanalyzershort}}-Service zu dem Cluster hinzufügen, sodass jede App im Cluster den Service verwenden kann


## Erforderlicher Zeitaufwand

40 Minuten


## Zielgruppe

Dieses Lernprogramm ist für Softwareentwickler und Netzadministratoren konzipiert, die noch nie zuvor einen Kubernetes-Cluster erstellt haben.


## Voraussetzungen

-  Ein [{{site.data.keyword.Bluemix_notm}}-Konto ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/registration/)



## Lerneinheit 1: Cluster erstellen und CLI einrichten
{: #cs_cluster_tutorial_lesson1}

Erstellen Sie Ihren Cluster in der GUI und installieren Sie die erforderlichen CLIs. Für das vorliegende Lernprogramm müssen Sie Ihren Cluster in der Region 'Großbritannien (Süden)' erstellen.


Gehen Sie wie folgt vor, um Ihren Cluster zu erstellen:

1. Die Bereitstellung Ihres Clusters kann einige Minuten dauern. Um diese Zeit optimal zu nutzen, sollten Sie [Ihren Cluster erstellen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/containers-kubernetes/launch?env_id=ibm:yp:united-kingdom), bevor Sie die CLIs installieren. Ein Lite-Cluster ist mit einem Workerknoten ausgestattet, in dem Container-Pods bereitgestellt werden können. Ein Workerknoten ist der Rechenhost (normalerweise eine virtuelle Maschine), auf dem Ihre Apps ausgeführt werden.


Die folgenden CLIs und die zugehörigen Voraussetzungen werden verwendet, um Cluster über die CLI zu verwalten:
-   {{site.data.keyword.Bluemix_notm}}-CLI
-   {{site.data.keyword.containershort_notm}}-Plug-in
-   Kubernetes-CLI
-   {{site.data.keyword.registryshort_notm}}-Plug-in
-   Docker-CLI

</br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu installieren:

1.  Als Voraussetzung für das {{site.data.keyword.containershort_notm}}-Plug-in müssen Sie die [{{site.data.keyword.Bluemix_notm}}-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://clis.ng.bluemix.net/ui/home.html) installieren. Verwenden Sie zur Ausführung von {{site.data.keyword.Bluemix_notm}}-CLI-Befehlen das Präfix `bx`.
2.  Folgen Sie den Eingabeaufforderungen, um ein Konto und eine {{site.data.keyword.Bluemix_notm}}-Organisation auszuwählen. Cluster sind zwar kontospezifisch, besitzen jedoch keine Abhängigkeit zu einer {{site.data.keyword.Bluemix_notm}}-Organisation oder einem Bluemix-Bereich.

4.  Installieren Sie das {{site.data.keyword.containershort_notm}}-Plug-in, um Kubernetes-Cluster zu erstellen und Workerknoten zu verwalten. Verwenden Sie zur Ausführung von {{site.data.keyword.containershort_notm}}-Plug-in-Befehlen das Präfix `bx cs`.

    ```
    bx plugin install container-service -r Bluemix
    ```
    {: pre}

5.  Um eine lokale Version des Kubernetes-Dashboards anzuzeigen und Apps in Ihren Clustern bereitzustellen, müssen Sie die [Kubernetes-CLI installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Um Befehle über die Kubernetes-CLI auszuführen, müssen Sie das Präfix `kubectl` verwenden.
    1.  Zur Erreichung der vollständigen funktionalen Kompatibilität müssen Sie die Kubernetes-CLI-Version herunterladen, die mit der Version des Kubernetes-Clusters übereinstimmt, die verwendet werden soll. Die aktuelle standardmäßige Kubernetes-Version für {{site.data.keyword.containershort_notm}} lautet 1.7.4.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

          **Tipp:** Wenn Sie Windows verwenden, installieren Sie die Kubernetes-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen einige Dateipfadänderungen, wenn Sie spätere Befehle ausführen.

    2.  Wenn Sie mit OS X oder Linux arbeiten, dann führen Sie die folgenden Schritte aus.
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis `/usr/local/bin`.

            ```
            mv /<dateipfad>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Vergewissern Sie sich, dass '/usr/local/bin' in der Systemvariablen `PATH` aufgeführt wird. Die Variable `PATH` enthält alle Verzeichnisse, in denen Ihr Betriebssystem ausführbare Dateien finden kann. Die Verzeichnisse, die in der Variablen `PATH` aufgelistet sind, erfüllen jedoch eine andere Funktion. Im Verzeichnis `/usr/local/bin` werden ausführbare Dateien für Software gespeichert, die nicht Bestandteil des Betriebssystem ist und vom Systemadministrator manuell installiert wurde.

            ```
            echo $PATH
            ```
            {: pre}

            Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Konvertieren Sie die Datei in eine ausführbare Datei.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6. Installieren Sie zum Einrichten und Verwalten eines privaten Image-Repositorys in {{site.data.keyword.registryshort_notm}} das {{site.data.keyword.registryshort_notm}}-Plug-in. Verwenden Sie zur Ausführung von Registry-Befehlen das Präfix `bx cr`.

    ```
    bx plugin install container-registry -r Bluemix
    ```
    {: pre}

    Überprüfen Sie durch Ausführen des folgenden Befehls, ob die Plug-ins 'container-service' und 'container-registry' ordnungsgemäß installiert wurden:

    ```
    bx plugin list
    ```
    {: pre}

7. Um Images lokal zu erstellen und per Push-Operation an das private Image-Repository zu übertragen, müssen Sie die [Docker CE-CLI installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/community-edition#/download). Wenn Sie Windows 8 oder älter verwenden, können Sie stattdessen [Docker Toolbox ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/products/docker-toolbox) installieren.

Glückwunsch! Sie haben die CLIs für die folgenden Lerneinheiten und Lernprogramme erfolgreich installiert. Als Nächstes werden Sie die Clusterumgebung einrichten und den {{site.data.keyword.toneanalyzershort}}-Service hinzufügen.


## Lerneinheit 2: Clusterumgebung einrichten
{: #cs_cluster_tutorial_lesson2}

Erstellen Sie Ihren Kubernetes-Cluster, richten Sie ein privates Image-Repository in {{site.data.keyword.registryshort_notm}} ein und fügen Sie geheime Schlüssel zu Ihrem Cluster hinzu, sodass die App auf den {{site.data.keyword.toneanalyzershort}}-Service zugreifen kann.

1.  Melden Sie sich bei der {{site.data.keyword.Bluemix_notm}}-CLI mithilfe Ihrer {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise an, wenn Sie dazu aufgefordert werden.

    ```
    bx login [--sso] -a api.eu-gb.bluemix.net
    ```
    {: pre}

    **Hinweis:** Wenn Sie über eine eingebundene ID verfügen, dann geben Sie das Flag `--sso` an, um sich anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen.

2.  Richten Sie Ihr eigenes privates Image-Repository in {{site.data.keyword.registryshort_notm}} ein, um Docker-Images sicher zu speichern und mit allen Benutzern des Clusters gemeinsam nutzen zu können. In {{site.data.keyword.Bluemix_notm}} ist ein privates Image-Repository durch einen Namensbereich gekennzeichnet. Der Namensbereich dient der Erstellung einer eindeutigen URL zu Ihrem Image-Repository, das Entwickler für den Zugriff auf private Docker-Images verwenden können.

    Im vorliegenden Beispiel will das PR-Unternehmen lediglich ein Image-Repository in {{site.data.keyword.registryshort_notm}} erstellen und wählt daher _pr-unternehmen_ als Namensbereich aus, um alle Images im Konto zu gruppieren. Ersetzen Sie den Platzhalter _&lt;ihr_namensbereich&gt;_ durch einen Namensbereich Ihrer Wahl
und nicht durch eine Angabe, die sich auf das Lernprogramm bezieht.

    ```
    bx cr namespace-add <ihr_namensbereich>
    ```
    {: pre}

3.  Vergewissern Sie sich zuerst, dass die Bereitstellung Ihres Workerknotens abgeschlossen ist, bevor Sie mit dem nächsten Schritt fortfahren.

    ```
    bx cs workers <clustername>
    ```
     {: pre}

    Wenn die Bereitstellung Ihres Workerknoten abgeschlossen ist, wechselt der Status zu **Bereit**. Sie können nun mit dem Binden von {{site.data.keyword.Bluemix_notm}}-Services zur Verwendung in einem späteren Lernprogramm beginnen.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status
    kube-par02-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready
    ```
    {: screen}

4.  Legen Sie in Ihrer CLI (Befehlszeilenschnittstelle) den Kontext für Ihren Cluster fest. Jedes Mal, wenn Sie sich an der Container-CLI anmelden, um mit Clustern zu arbeiten, müssen Sie diese Befehle ausführen, um den Pfad zu der Konfigurationsdatei des Clusters als Sitzungsvariable festzulegen. Anhand dieser Variablen sucht die Kubernetes-CLI eine lokale Konfigurationsdatei und Zertifikate, die zum Herstellen der Verbindung zum Cluster in {{site.data.keyword.Bluemix_notm}} erforderlich sind.

    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config <clustername>
        ```
        {: pre}

        Wenn
der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können,
um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
        ```
        {: screen}

    2.  Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.

    3.  Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.

        Beispiel für OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Ausgabe:

        ```
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.

        ```
        kubectl version  --short
        ```
        {: pre}

        Beispielausgabe:

        ```
        Client Version: v1.7.4
        Server Version: v1.7.4
        ```
        {: screen}

5.  Fügen Sie den {{site.data.keyword.toneanalyzershort}}-Service zum Cluster hinzu. Mit den {{site.data.keyword.Bluemix_notm}}-Services können Sie bereits entwickelte Funktionen in Ihren Apps nutzen. Jeder an den Cluster gebundene {{site.data.keyword.Bluemix_notm}}-Service kann von jeder App genutzt werden, die in diesem Cluster bereitgestellt ist. Wiederholen Sie die folgenden Schritte für jeden {{site.data.keyword.Bluemix_notm}}-Service, den Sie in Verbindung mit Ihren Apps verwenden wollen.
    1.  Fügen Sie den {{site.data.keyword.toneanalyzershort}}-Service zu Ihrem {{site.data.keyword.Bluemix_notm}}-Konto hinzu.

        **Hinweis:** Wenn Sie den {{site.data.keyword.toneanalyzershort}}-Service zu Ihrem Konto hinzufügen, wird eine Nachricht mit dem Inhalt angezeigt, dass der Service nicht kostenlos ist. Wenn Sie Ihren API-Aufruf einschränken, entstehen im Rahmen dieses Lernprogramms keine Kosten durch den {{site.data.keyword.watson}}-Service. [Informieren Sie sich über die Preisinformationen für den {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block).

        ```
        bx service create tone_analyzer standard <mein_tone_analyzer>
        ```
        {: pre}

    2.  Binden Sie die {{site.data.keyword.toneanalyzershort}}-Instanz an den Kubernetes-Standardnamensbereich (`default`) für den Cluster. Später können Sie Ihren eigenen Namensbereich erstellen, um Benutzerzugriff auf Kubernetes-Ressourcen zu verwalten. Aber für den Moment müssen Sie den Namensbereich `default` verwenden. Kubernetes-Namensbereiche unterscheiden sich von dem Registry-Namensbereich, den Sie davor erstellt haben.

        ```
        bx cs cluster-service-bind <clustername> default <mein_tone_analyzer>
        ```
        {: pre}

        Ausgabe:

        ```
        bx cs cluster-service-bind <clustername> default <mein_tone_analyzer>
        Binding service instance to namespace...
        OK
        Namespace:	default
        Secret name:	binding-mytoneanalyzer
        ```
        {: screen}

6.  Stellen Sie sicher, dass der geheime Kubernetes-Schlüssel im Namensbereich Ihres Clusters erstellt wurde. Jeder {{site.data.keyword.Bluemix_notm}}-Service ist durch eine JSON-Datei definiert, die vertrauliche Informationen zu diesem Service wie zum Beispiel den Benutzernamen, das Kennwort und die URL enthält, über die der Container auf den Service zugreift. Kubernetes verwendet geheime Schlüssel, um diese Informationen sicher zu speichern. Im vorliegenden Beispiel enthält der geheime Schlüssel die Berechtigungsnachweise für den Zugriff auf die {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Instanz, die in Ihrem Konto bereitgestellt wird.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Ausgabe:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
Ganz hervorragend! Sie haben den Cluster konfiguriert und Ihre lokale Umgebung ist jetzt so vorbereitet, dass Sie mit der Bereitstellung von Apps im Cluster beginnen können.

## Womit möchten Sie fortfahren?

* [Testen Sie Ihr Wissen in einem Quiz! ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)

* Machen Sie sich mit dem [Lernprogramm: Apps in Kubernetes-Clustern in {{site.data.keyword.containershort_notm}} bereitstellen](cs_tutorials_apps.html#cs_apps_tutorial) vertraut, um die App der PR-Firma in dem von Ihnen erstellten Cluster bereitzustellen.
