---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Lernprogramme für Cluster
{: #cs_tutorials}

Probieren Sie diese Lernprogramme und andere Ressourcen aus, um sich mit dem Service vertraut zu machen.
{:shortdesc}

## Lernprogramm: Cluster erstellen
{: #cs_cluster_tutorial}

Sie können einen eigenen Kubernetes-Cluster in der Cloud bereitstellen und verwalten,
mit dem Sie die Bereitstellung, den Betrieb, die Skalierung und die Überwachung von containerisierten Apps
über einen Cluster unabhängiger Berechnungshosts hinweg (so genannter Workerknoten) automatisieren können.
{:shortdesc}

Dies Reihe von Lernprogrammen veranschaulicht, wie ein fiktives PR-Unternehmen Kubernetes einsetzen kann, um eine containerisierte App in {{site.data.keyword.Bluemix_short}} bereitzustellen, die Watson Tone Analyzer nutzt. Das PR-Unternehmen setzt Watson Tone Analyzer ein, um Pressemitteilungen zu analysieren und Feedback zum Tenor in ihren Nachrichten zu erhalten. In diesem ersten Lernprogramm richtet der Netzadministrator des PR-Unternehmens einen angepassten Kubernetes-Cluster ein, der die Berechnungsinfrastruktur für die 'Watson Tone Analyzer'-App des Unternehmens darstellt. Dieser Cluster wird verwendet, um eine 'Hello World'-Version der App des PR-Unternehmens bereitzustellen und zu testen.

### Ziele

-   Kubernetes-Cluster mit einem Workerknoten erstellen
-   CLIs zum Verwenden der Kubernetes-API und Verwalten von Docker-Images installieren
-   Privates Image-Repository in der IBM {{site.data.keyword.Bluemix_notm}}-Container-Registry zum Speichern von Images erstellen
-   {{site.data.keyword.Bluemix_notm}}-Service 'Watson Tone Analyzer'
zu dem Cluster hinzufügen, sodass jede App im Cluster den Service verwenden kann

### Erforderlicher Zeitaufwand

25 Minuten

### Zielgruppe

Dieses Lernprogramm ist für Softwareentwickler und Netzadministratoren konzipiert, die noch nie zuvor einen Kubernetes-Cluster erstellt haben.

### Lerneinheit 1: CLI einrichten
{: #cs_cluster_tutorial_lesson1}

Installieren Sie die {{site.data.keyword.containershort_notm}}-Befehlszeilenschnittstelle, die {{site.data.keyword.registryshort_notm}}-Befehlszeilenschnittstelle und die jeweiligen Voraussetzungen. Diese CLIs werden in späteren Lerneinheiten verwendet und sind erforderlich, um Ihren Kubernetes-Cluster von Ihrer lokalen Maschine aus zu verwalten, Images für die Bereitstellung als Container zu erstellen und (in einem späteren Lernprogramm) Apps im Cluster bereitzustellen.

Diese Lerneinheit enthält die Informationen zum Installieren der folgenden CLIs (Befehlszeilenschnittstellen).

-   {{site.data.keyword.Bluemix_notm}}-CLI
-   {{site.data.keyword.containershort_notm}}-Plug-in
-   Kubernetes-CLI
-   {{site.data.keyword.registryshort_notm}}-Plug-in
-   Docker-CLI


Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu installieren:
1.  Wenn Sie noch nicht über ein Konto verfügen, sollten Sie jetzt ein [{{site.data.keyword.Bluemix_notm}}-Konto ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.ng.bluemix.net/registration/) erstellen. Notieren Sie Ihren Benutzernamen und das zugehörige Kennwort, da Sie diese Informationen zu einem späteren Zeitpunkt wieder benötigen.
2.  Als Voraussetzung für das {{site.data.keyword.containershort_notm}}-Plug-in müssen Sie die [{{site.data.keyword.Bluemix_notm}}-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://clis.ng.bluemix.net/ui/home.html) installieren. Das Präfix zum Ausführen von Befehlen über die {{site.data.keyword.Bluemix_notm}}-CLI lautet `bx`. 
3.  Folgen Sie den Eingabeaufforderungen, um ein Konto und eine {{site.data.keyword.Bluemix_notm}}-Organisation auszuwählen. Cluster sind zwar kontospezifisch, besitzen jedoch keine Abhängigkeit zu einer {{site.data.keyword.Bluemix_notm}}-Organisation oder einem Bluemix-Bereich.

5.  Installieren Sie das {{site.data.keyword.containershort_notm}}-Plug-in, um Kubernetes-Cluster zu erstellen und Workerknoten zu verwalten. Das Präfix zum Ausführen von Befehlen mithilfe des {{site.data.keyword.containershort_notm}}-Plug-ins lautet `bx cs`. 

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}
6.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
    {: pre}

    Schließen Sie den API-Endpunkt ein, um eine bestimmte {{site.data.keyword.Bluemix_notm}}-Region anzugeben. Falls Sie über private Docker-Images verfügen, die in der Container-Registry einer bestimmten {{site.data.keyword.Bluemix_notm}}-Region gespeichert sind, oder über {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen, die Sie bereits erstellt haben, melden Sie sich an dieser Region an, um auf Ihre Images und {{site.data.keyword.Bluemix_notm}}-Services zuzugreifen.

    Die {{site.data.keyword.Bluemix_notm}}-Region, bei der Sie sich anmelden, bestimmt auch die Region, in der Sie Ihre Kubernetes-Cluster, einschließlich der verfügbaren Rechenzentren, erstellen können. Wenn Sie keine Region angeben, werden Sie automatisch bei der nächstgelegenen Region angemeldet. 

       -  Vereinigte Staaten (Süden)

           ```
           bx login -a api.ng.bluemix.net
           ```
           {: pre}
     
       -  Sydney

           ```
           bx login -a api.au-syd.bluemix.net
           ```
           {: pre}

       -  Deutschland

           ```
           bx login -a api.eu-de.bluemix.net
           ```
           {: pre}

       -  Großbritannien

           ```
           bx login -a api.eu-gb.bluemix.net
           ```
           {: pre}

    **Hinweis:** Falls Sie über eine föderierte ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

7.  Wenn Sie ein Kubernetes-Cluster in einer anderen Region als der zuvor ausgewählten {{site.data.keyword.Bluemix_notm}}-Region erstellen möchten, geben Sie die gewünschte Region an. Sie haben beispielsweise {{site.data.keyword.Bluemix_notm}}-Services oder private Docker-Images in einer Region erstellt und wollen sie mit {{site.data.keyword.containershort_notm}} in einer anderen Region verwenden. 

    Wählen Sie zwischen den folgenden API-Endpunkten aus: 

    * Vereinigte Staaten (Süden):

        ```
        bx cs init --host https://us-south.containers.bluemix.net
        ```
        {: pre}

    * Großbritannien (Süden):

        ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
        {: pre}

    * Zentraleuropa:

        ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
        {: pre}

    * Asiatisch-pazifischer Raum (Süden):

        ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
        {: pre}

8.  Um eine lokale Version des Kubernetes-Dashboards anzuzeigen und Apps in Ihren Clustern bereitzustellen, müssen Sie die [Kubernetes-CLI installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Das Präfix zum Ausführen von Befehlen über die Kubernetes-CLI lautet `kubectl`.
    1.  Laden Sie die Kubernetes-CLI herunter.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

          **Tipp:** Wenn Sie Windows verwenden, installieren Sie die Kubernetes-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen einige Dateipfadänderungen, wenn Sie spätere Befehle ausführen.

    2.  OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen.
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis `/usr/local/bin`.

            ```
            mv /<dateipfad>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Stellen Sie sicher, dass '/usr/local/bin' in der Variablen `PATH` Ihres Systems aufgelistet wird. Die Variable `PATH` enthält alle Verzeichnisse, in denen Ihr Betriebssystem ausführbare Dateien finden kann. Die Verzeichnisse, die in der Variablen `PATH` aufgelistet sind, erfüllen jedoch eine andere Funktion. Im Verzeichnis '/usr/local/bin' werden ausführbare Dateien für Software gespeichert, die nicht Bestandteil des Betriebssystem ist und vom Systemadministrator manuell installiert wurde. 

            ```
            echo $PATH
            ```
            {: pre}

            Die Ausgabe in der Befehlszeilenschnittstelle (CLI) ähnelt der folgenden:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Konvertieren Sie die Binärdatei in eine ausführbare Datei. 

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

9. Installieren Sie zum Einrichten und Verwalten eines privaten Image-Repositorys in {{site.data.keyword.registryshort_notm}} das {{site.data.keyword.registryshort_notm}}-Plug-in. Das Präfix zum Ausführen von Registry-Befehlen lautet `bx cr`. 

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Überprüfen Sie durch Ausführen des folgenden Befehls, ob die Plug-ins 'container-service' und 'container-registry' ordnungsgemäß installiert wurden:


    ```
    bx plugin list
    ```
    {: pre}

10. Um Images lokal zu erstellen und per Push-Operation an das private Image-Repository zu übertragen, müssen Sie die [Docker CE-CLI installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/community-edition#/download). Wenn Sie Windows 8 oder älter verwenden, können Sie stattdessen [Docker Toolbox ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/products/docker-toolbox) installieren. 

Glückwunsch! Sie haben erfolgreich ein {{site.data.keyword.Bluemix_notm}}-Konto erstellt und die Befehlszeilenschnittstellen (CLIs) für die nachfolgenden Lektionen und Lernprogramme installiert. Greifen Sie als Nächstes über die CLI auf Ihren Cluster zu und beginnen Sie, {{site.data.keyword.Bluemix_notm}}-Services hinzuzufügen.

### Lerneinheit 2: Clusterumgebung einrichten
{: #cs_cluster_tutorial_lesson2}

Erstellen Sie Ihren Kubernetes-Cluster, richten Sie ein privates Image-Repository in {{site.data.keyword.registryshort_notm}} ein und fügen Sie geheime Schlüssel zu Ihrem Cluster hinzu, sodass die App auf den Service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzerfull}} zugreifen kann. 

1.  Erstellen Sie Ihren Kubernetes-Lite-Cluster.

    ```
    bx cs cluster-create --name <pr-unternehmenscluster>
    ```
    {: pre}

    Ein Lite-Cluster ist mit einem Workerknoten ausgestattet, über den die Bereitstellung von Pods möglich ist. Ein Workerknoten ist der Rechenhost (normalerweise eine virtuelle Maschine), auf dem Ihre Apps ausgeführt werden. Eine App im Produktionsbetrieb führt Replikate der App auf mehreren Workerknoten aus, um eine höhere Verfügbarkeit der App zu bieten.

    **Hinweis:** Es kann bis zu 15 Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster entsprechend eingerichtet und bereitgestellt wird. 

2.  Richten Sie Ihr eigenes privates Image-Repository in {{site.data.keyword.registryshort_notm}} ein, um Docker-Images sicher zu speichern und mit allen Benutzern des Clusters gemeinsam nutzen zu können. In {{site.data.keyword.Bluemix_notm}} ist ein privates Image-Repository durch einen Namensbereich gekennzeichnet; einen solchen Namensbereich legen Sie in diesem Schritt fest. Der Namensbereich dient der Erstellung einer eindeutigen URL zu Ihrem Image-Repository, das Entwickler für den Zugriff auf private Docker-Images verwenden können. Sie können in Ihrem Konto mehrere Namensbereiche erstellen und so die Images gruppieren und organisieren. Sie könnten zum Beispiel für jede Abteilung, jede Umgebung oder jede App einen eigenen Namensbereich erstellen.

    Im vorliegenden Beispiel will das PR-Unternehmen lediglich ein Image-Repository in {{site.data.keyword.registryshort_notm}} erstellen und wählt daher _pr-unternehmen_ als Namensbereich aus, um alle Images im Konto zu gruppieren. Ersetzen Sie den Platzhalter _&lt;ihr_namensbereich&gt;_ durch einen Namensbereich Ihrer Wahl
und nicht durch eine Angabe, die sich auf das Lernprogramm bezieht.

    ```
    bx cr namespace-add <ihr_namensbereich>
    ```
    {: pre}

3.  Vergewissern Sie sich zuerst, dass die Bereitstellung Ihres Workerknotens abgeschlossen ist, bevor Sie mit dem nächsten Schritt fortfahren.

    ```
    bx cs workers <pr-unternehmenscluster>
    ```
     {: pre}

    Wenn die Bereitstellung Ihres Workerknoten abgeschlossen ist, wechselt der Status zu **Bereit**. Sie können nun mit dem Binden von {{site.data.keyword.Bluemix_notm}}-Services zur Verwendung in einem späteren Lernprogramm beginnen.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   
    kube-dal10-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready   
    ```
    {: screen}

4.  Legen Sie in Ihrer CLI (Befehlszeilenschnittstelle) den Kontext für Ihren Cluster fest. Jedes Mal, wenn Sie sich an der Container-CLI anmelden, um mit Clustern zu arbeiten, müssen Sie diese Befehle ausführen, um den Pfad zu der Konfigurationsdatei des Clusters als Sitzungsvariable festzulegen. Anhand dieser Variablen sucht die Kubernetes-CLI eine lokale Konfigurationsdatei und Zertifikate, die zum Herstellen der Verbindung zum Cluster in {{site.data.keyword.Bluemix_notm}} erforderlich sind.

    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config pr-unternehmenscluster
        ```
        {: pre}

        Wenn
der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können,
um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-dal10-pr_firm_cluster.yml
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
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.

        ```
        kubectl version  --short
        ```
        {: pre}

        Beispielausgabe:

        ```
        Client Version: v1.5.6
        Server Version: v1.5.6
        ```
        {: screen}

5.  Fügen Sie den {{site.data.keyword.Bluemix_notm}}-Service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} zum Cluster hinzu. Bei {{site.data.keyword.Bluemix_notm}}-Services wie {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} können Sie sich bereits entwickelte Funktionen in Ihren Apps zunutze machen. Jeder an den Cluster gebundene {{site.data.keyword.Bluemix_notm}}-Service kann von jeder App genutzt werden, die in diesem Cluster bereitgestellt ist. Wiederholen Sie die folgenden Schritte für jeden {{site.data.keyword.Bluemix_notm}}-Service, den Sie in Verbindung mit Ihren Apps verwenden wollen.
    1.  Fügen Sie den Service '{{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}' zu Ihrem {{site.data.keyword.Bluemix_notm}}-Konto hinzu. 

        **Hinweis:** Wenn Sie den Service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} zu Ihrem Konto hinzufügen, wird eine Nachricht mit dem Inhalt angezeigt,
dass der Service nicht kostenlos ist.
Wenn Sie Ihren API-Aufruf einschränken, entstehen im Rahmen dieses Lernprogramms keine Kosten durch den {{site.data.keyword.watson}}-Service.
Sie können die [Preisinformationen für {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block) prüfen. 

        ```
        bx service create tone_analyzer standard <mein_tone_analyzer>
        ```
        {: pre}

    2.  Binden Sie die {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Instanz an den Kubernetes-Standardnamensbereich (`default`) für den Cluster. Später können Sie Ihren eigenen Namensbereich erstellen, um Benutzerzugriff auf Kubernetes-Ressourcen zu verwalten. Aber für den Moment müssen Sie den Namensbereich `default` verwenden. Kubernetes-Namensbereiche unterscheiden sich von dem Registry-Namensbereich, den Sie davor erstellt haben.

        ```
        bx cs cluster-service-bind <pr-unternehmenscluster> default <mein_tone_analyzer>
        ```
        {: pre}

        Ausgabe:

        ```
        bx cs cluster-service-bind <pr-unternehmenscluster> default <mein_tone_analyzer>
        Binding service instance to namespace...
        OK
        Namespace: default
        Secret name: binding-mytoneanalyzer
        ```
        {: screen}

6.  Stellen Sie sicher, dass der geheime Kubernetes-Schlüssel im Namensbereich Ihres Clusters erstellt wurde. Jeder {{site.data.keyword.Bluemix_notm}}-Service ist durch eine JSON-Datei definiert, die vertrauliche Informationen zu diesem Service wie zum Beispiel den Benutzernamen, das Kennwort und die URL enthält, über die der Container auf den Service zugreift. Kubernetes verwendet geheime Schlüssel, um diese Informationen sicher zu speichern. Im vorliegenden Beispiel enthält der geheime Schlüssel die Berechtigungsnachweise für den Zugriff auf die {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}-Instanz, die in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto bereitgestellt ist. 

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


Ganz hervorragend! Der Cluster wurde erstellt und konfiguriert und Ihre lokale Umgebung ist jetzt so vorbereitet, dass Sie mit der Bereitstellung von Apps auf dem Cluster beginnen können.

**Womit möchten Sie fortfahren? **

* [Testen Sie Ihr Wissen in einem Quiz! ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://bluemix-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)
* Machen Sie sich mit dem [Lernprogramm: Apps in Kubernetes-Clustern in {{site.data.keyword.containershort_notm}} bereitstellen](#cs_apps_tutorial) vertraut, um die App des PR-Unternehmens in dem von Ihnen erstellten Cluster bereitzustellen. 

## Lernprogramm: Apps in Clustern bereitstellen
{: #cs_apps_tutorial}

In diesem zweiten Lernprogramm erfahren Sie, wie Sie mit Kubernetes eine containerisierte App bereitstellen, die den {{site.data.keyword.Bluemix_notm}}-Service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} nutzt. Hier setzt ein fiktives PR-Unternehmen {{site.data.keyword.watson}} ein, um Pressemitteilungen zu analysieren und Feedback zum Tenor in ihren Nachrichten zu erhalten. {:shortdesc}

In diesem Szenario stellt der App-Entwickler des PR-Unternehmens eine 'Hello World'-Version der App in einem Kubernetes-Cluster bereit, der vom Netzadministrator im [ersten Lernprogramm](#cs_cluster_tutorial) erstellt wurde.

In jeder Lerneinheit erfahren Sie, wie Sie zunehmend komplexere Versionen ein und derselben App implementieren. Im Diagramm sind (mit Ausnahme von Teil 4) die Komponenten der App-Bereitstellungen des Lernprogramms sichtbar.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_roadmap.png">![Komponenten der Lerneinheit](images/cs_app_tutorial_roadmap.png)</a>

Kubernetes verwendet diverse Typen von Ressourcen, um Ihre Apps betriebsbereit für die Ausführung in Clustern zu gestalten. In Kubernetes arbeiten Bereitstellungen und Services zusammen. Bereitstellungen enthalten die Definitionen für die App, wie z. B. das Image, das für den Container verwendet werden soll oder die Angabe, welcher Port für die App offengelegt werden soll. Beim Erstellen einer Bereitstellung wird für jeden Container, den Sie in der Bereitstellung definiert haben, jeweils ein Kubernetes-Pod erstellt. Um Ihre App widerstandsfähiger zu machen, können Sie in Ihrer Bereitstellung mehrere Instanzen derselben App definieren und von Kubernetes automatisch eine Replikatgruppe erstellen lassen. Die Replikatgruppe überwacht die Pods und stellt sicher, dass zu jedem beliebigen Zeitpunkt die gewünschte Anzahl von Pods betriebsbereit ist. Reagiert einer der Pods nicht mehr, so wird dieser automatisch neu erstellt.

Services fassen eine Gruppe von Pods zusammen und stellen diesen Pods eine Netzverbindung für andere Services im Cluster bereit, ohne hierbei die tatsächlichen privaten IP-Adressen der einzelnen Pods preiszugeben. Mit Kubernetes-Services können Sie eine App anderen Pods im Cluster zur Verfügung stellen oder über das Internet verfügbar machen. Im vorliegenden Lernprogramm verwenden Sie einen Kubernetes-Service, um über eine öffentliche IP-Adresse, die automatisch einem Workerknoten zugewiesen wird, und einen öffentlichen Port vom Internet aus auf Ihre aktive App zuzugreifen.

Um die Verfügbarkeit Ihrer App noch weiter zu steigern, können sie bei Standardclustern mehrere Workerknoten erstellen, die eine noch größere Anzahl an Replikaten der App ausführen. Obwohl diese Task im vorliegenden Lernprogramm nicht behandelt wird, sollten Sie dieses Konzept im Hinterkopf behalten, wenn Sie zu einem späteren Zeitpunkt die Verfügbarkeit einer App weiter verbessern möchten.

Die Integration eines {{site.data.keyword.Bluemix_notm}}-Service
in eine App wird nur in einer Lerneinheit behandelt. Sie können Services jedoch mit so einfach oder so komplex
konzipierten Apps verwenden, wie überhaupt vorstellbar.

### Ziele

* Grundlegende Kubernetes-Terminologie verstehen
* Image mit Push-Operation in Registry-Namensbereich in {{site.data.keyword.registryshort_notm}} übertragen
* App öffentlich zugänglich machen
* Einzelne Instanz einer App mit einem Kubernetes-Befehl und eine Script in einem Cluster bereitstellen
* Mehrere Instanzen einer App in Containern bereitstellen, die bei Statusprüfungen neu erstellt werden
* Eine App implementieren, die Funktionalität eines {{site.data.keyword.Bluemix_notm}}-Service verwendet

### Erforderlicher Zeitaufwand

40 Minuten

### Zielgruppen

Softwareentwickler und Netzadministratoren, die noch nie zuvor eine App in einem Kubernetes-Cluster bereitgestellt haben.

### Voraussetzungen

[Lernprogramm: Kubernetes-Cluster in {{site.data.keyword.containershort_notm}}](#cs_cluster_tutorial) erstellen. 

### Lerneinheit 1: Einzelinstanz-Apps auf Kubernetes-Clustern bereitstellen
{: #cs_apps_tutorial_lesson1}

In dieser Lerneinheit stellen Sie eine einzelne Instanz der App 'Hello World' in einem Cluster bereit.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components1.png">![Konfiguration für die Bereitstellung](images/cs_app_tutorial_components1.png)</a>


1.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
    {: pre}

    Schließen Sie den API-Endpunkt ein, um eine bestimmte {{site.data.keyword.Bluemix_notm}}-Region anzugeben. Falls Sie über private Docker-Images verfügen, die in der Container-Registry einer bestimmten {{site.data.keyword.Bluemix_notm}}-Region gespeichert sind, oder über {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen, die Sie bereits erstellt haben, melden Sie sich an dieser Region an, um auf Ihre Images und {{site.data.keyword.Bluemix_notm}}-Services zuzugreifen.

    Die {{site.data.keyword.Bluemix_notm}}-Region, bei der Sie sich anmelden, bestimmt auch die Region, in der Sie Ihre Kubernetes-Cluster, einschließlich der verfügbaren Rechenzentren, erstellen können. Wenn Sie keine Region angeben, werden Sie automatisch bei der nächstgelegenen Region angemeldet. 

    -  Vereinigte Staaten (Süden)

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}
  
    -  Sydney

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -  Deutschland

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -  Großbritannien

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

    **Hinweis:** Falls Sie über eine föderierte ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

2.  Legen Sie in Ihrer CLI (Befehlszeilenschnittstelle) den Kontext für den Cluster fest.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config <pr-unternehmenscluster>
        ```
        {: pre}

        Wenn
der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können,
um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<pr-unternehmenscluster>/kube-config-prod-dal10-pr_firm_cluster.yml
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
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/<pr-unternehmenscluster>/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.

        ```
        kubectl version  --short
        ```
        {: pre}

        Beispielausgabe:

        ```
        Client Version: v1.5.6
        Server Version: v1.5.6
        ```
        {: screen}

3.  Starten Sie Docker.
    * Wenn Sie Docker CE verwenden, sind keine weiteren Maßnahmen erforderlich.
    * Wenn Sie Linux verwenden, durchsuchen Sie die [Docker-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.docker.com/engine/admin/) nach Anweisungen dazu, wie Docker abhängig von der verwendeten Linux-Distribution gestartet wird. 
    * Wenn Sie Docker Toolbox unter Windows oder OSX verwenden, können Sie das Programm 'Docker Quickstart Terminal' verwenden, das Docker für Sie startet. Verwenden Sie 'Docker Quickstart Terminal' für die nächsten Schritte, um die Docker-Befehle auszuführen. Wechseln Sie anschließend zurück zur CLI (Befehlszeilenschnittstelle) und legen Sie dort die Sitzungsvariable `KUBECONFIG` fest. 
        * Führen Sie bei Verwendung des Programms 'Docker QuickStart Terminal' erneut den Anmeldebefehl für die {{site.data.keyword.Bluemix_notm}}-CLI aus.

          ```
          bx login
          ```
          {: pre}

4.  Melden Sie sich an der {{site.data.keyword.registryshort_notm}}-CLI an.

    ```
    bx cr login
    ```
    {: pre}

    -   Wenn Sie Ihren Namensbereich in {{site.data.keyword.registryshort_notm}} vergessen haben, führen Sie den folgenden Befehl aus.

        ```
        bx cr namespace-list
        ```
        {: pre}

5.  Klonen Sie den Quellcode für die [App 'Hello World' ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM/container-service-getting-started-wt) oder laden Sie ihn in das Benutzerausgangsverzeichnis herunter. 

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

    Wenn Sie das Repository heruntergeladen haben, extrahieren Sie die komprimierte Datei.

    Beispiel:

    * Windows: `C:\Benutzer\<mein_benutzername>\container-service-getting-started-wt`
    * OS X: `/Users/<mein_benutzername>/container-service-getting-started-wt`

    Das Repository enthält drei Versionen einer ähnlichen App in drei Ordnern namens `Stage1`, `Stage2` und `Stage3`. Jede Version enthält die folgenden Dateien:
    * `Dockerfile`: Builddefinitionen für das Image
    * `app.js`: App 'Hello World'
    * `package.json`: Metadaten zur App

6.  Navigieren Sie zum ersten App-Verzeichnis namens `Stage1`.

    ```
    cd <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage1
    ```
    {: pre}

7.  Erstellen Sie ein Docker-Image, das die App-Dateien aus dem Verzeichnis `Stage1` enthält. Falls zu einem späteren Zeitpunkt Änderungen an der App vorgenommen werden sollen, wiederholen Sie diese Schritte, um eine weitere Version des Image zu erstellen.

    1.  Erstellen Sie das Image lokal und kennzeichnen Sie es mit dem Namen und Tag, den Sie verwenden möchten, und dem Namensbereich, den Sie in {{site.data.keyword.registryshort_notm}} im vorherigen Lernprogramm erstellt haben. Durch die Kennzeichnung (das Tagging) des Image mit den Namensbereichsinformationen weiß Docker, wohin das Image in einem späteren Schritt per Push-Operation übertragen werden soll. Verwenden Sie im Imagenamen nur alphanumerische Zeichen in Kleinschreibung oder Unterstreichungszeichen (`_`). Vergessen Sie nicht den Punkt (`.`) am Ende des Befehls. Der Punkt signalisiert Docker, im aktuellen Verzeichnis nach der Dockerfile zu suchen und Artefakte zum Erstellen des Image zu erstellen.

        ```
        docker build -t registry.<region>.bluemix.net/<namensbereich>/hello-world:1 .
        ```
        {: pre}

        Stellen Sie nach der Beendigung des Buildprozesses sicher, dass die Nachricht über die erfolgreiche Ausführung angezeigt wird.

        ```
        Successfully built <image-id>
        ```
        {: screen}

    2.  Übertragen Sie das Image mit einer Push-Operation in den Registry-Namensbereich.

        ```
        docker push registry.<region>.bluemix.net/<namensbereich>/hello-world:1
        ```
        {: pre}

        Ausgabe:

        ```
        The push refers to a repository [registry.<region>.bluemix.net/<namensbereich>/hello-world]
        ea2ded433ac8: Pushed
        894eb973f4d3: Pushed
        788906ca2c7e: Pushed
        381c97ba7dc3: Pushed
        604c78617f34: Pushed
        fa18e5ffd316: Pushed
        0a5e2b2ddeaa: Pushed
        53c779688d06: Pushed
        60a0858edcd5: Pushed
        b6ca02dfe5e6: Pushed
        1: digest: sha256:0d90cb73288113bde441ae9b8901204c212c8980d6283fbc2ae5d7cf652405
        43 size: 2398
        ```
        {: screen}

        Fahren Sie erst dann mit dem nächsten Schritt fort, wenn das Image per Push-Operation übertragen worden ist.

    3.  Wenn Sie das Programm 'Docker Quickstart Terminal' verwenden, wechseln Sie zurück zu der CLI (Befehlszeilenschnittstelle), über die Sie die Sitzungsvariable `KUBECONFIG` festgelegt haben.

    4.  Überprüfen Sie, ob das Image erfolgreich zum Namensbereich hinzugefügt wurde.

        ```
        bx cr images
        ```
        {: pre}

        Ausgabe:

        ```
        Listing images...

        REPOSITORY                                  NAMESPACE   TAG       DIGEST         CREATED        SIZE     VULNERABILITY STATUS
        registry.<region>.bluemix.net/<namensbereiche>/hello-world   <namensbereich>   1   0d90cb732881   1 minute ago   264 MB   OK
        ```
        {: screen}

8.  Erstellen Sie eine Kubernetes-Bereitstellung namens _hello-world-deployment_, um die App in einem Pod in Ihrem Cluster bereitzustellen. Bereitstellungen werden zum Verwalten von Pods verwendet, die containerisierte Instanzen einer App enthalten. Die folgende Bereitstellung stellt die App in einem einzelnen Pod bereit.

    ```
    kubectl run hello-world-deployment --image=registry.<region>.bluemix.net/<namensbereich>/hello-world:1
    ```
    {: pre}

    Ausgabe:

    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Da bei dieser Bereitstellung nur eine Instanz der App erstellt wird, kann die Bereitstellung schneller als in späteren Lerneinheiten erstellt werden, in denen mehrere Instanzen der App erstellt werden.

9.  Machen Sie die App zugänglich, indem Sie die Bereitstellung als Service vom Typ 'NodePort' zur Verfügung stellen. Services wenden Vernetzung für die App an. Da der Cluster nur über einen Workerknoten und nicht über mehrere verfügt, ist kein workerknotenübergreifender Lastausgleich erforderlich. Daher kann ein Knotenport (NodePort) verwendet werden, um Benutzern den externen Zugriff auf die App zu ermöglichen. Genau so, wie Sie einen Port für eine Cloud Foundry-App zugänglich machen würden, ist der Knotenport, den Sie offenlegen, der Port, an dem der Arbeiterknoten für Datenverkehr empfangsbereit ist. In einem späteren Schritt erfahren Sie, welche Knotenportnummer dem Service nach dem Zufallsprinzip zugewiesen wurde.

    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Ausgabe:

    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table>
    <table summary=\xe2\x80\x9cInformation about the expose command parameters.\xe2\x80\x9d>
    <caption>Tabelle 1. Befehlsparameter</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Weitere Informationen zu den expose-Parametern</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Macht eine Ressource als Kubernetes-Service verfügbar und macht sie den Benutzern öffentlich zugänglich.</td>
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
    <td>Der Port, an dem der Service bereitgestellt werden soll. </td>
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

    Nachdem alle Schritte für die Bereitstellung ausgeführt worden sind, können Sie das Ergebnis überprüfen.

10. Testen Sie Ihre App in einem Browser. Rufen Sie dazu die Details ab, um die zugehörige URL zu bilden.
    1.  Rufen Sie Informationen zum Service ab, um zu erfahren, welche Knotenportnummer (NodePort) zugewiesen wurde.

        ```
        kubectl describe service <hello-world-service>
        ```
        {: pre}

        Ausgabe:

        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.10.10.8
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.171.87:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Knotenportnummern (NodePort) werden nach dem Zufallsprinzip zugewiesen, wenn sie mit dem Befehl `expose` generiert werden, bewegen sich aber im Bereich 30000-32767. Im vorliegenden Beispiel lautet die Portnummer für den Service vom Typ 'NodePort' 30872. 

    2.  Rufen Sie die öffentliche IP-Adresse für den Workerknoten im Cluster ab.

        ```
    bx cs workers <pr-unternehmenscluster>
    ```
        {: pre}

        Ausgabe:

        ```
        Listing cluster workers...
        OK
        ID                                            Public IP        Private IP      Machine Type   State      Status
        dal10-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.47.227.138   10.171.53.188   free           normal    Ready
        ```
        {: screen}

11. Öffnen Sie einen Browser und überprüfen Sie die App mit der folgenden URL: `http://<ip-adresse>:<knotenport>`. Anhand der Werte für das Beispiel lautet die URL wie folgt: `http://169.47.227.138:30872`. Bei Eingabe dieser URL in einen Browser wird folgender Text angezeigt.

    ```
    Hello world! Your app is up and running in a cluster!
(Hallo Welt! Ihre App steht jetzt in einem Cluster für den Betrieb bereit!)
    ```
    {: screen}

    Geben Sie diese URL an eine Kollegin oder einen Kollegen weiter und fordern Sie diese bzw. diesen auf, die URL selbst auszuprobieren, oder geben Sie auf Ihrem Mobiltelefon in den Browser ein, um sich davon zu überzeugen, dass die App 'Hello
World' auch tatsächlich zugänglich verfügbar ist.

12. Starten Sie Ihr Kubernetes-Dashboard über den Standardport 8001.
    1.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
         {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Öffnen Sie die folgende URL in einem Web-Browser, damit das Kubernetes-Dashboard angezeigt wird.

        ```
        http://localhost:8001/ui
        ```
         {: pre}

13. Auf der Registerkarte **Workloads** werden die von Ihnen erstellten Ressourcen angezeigt. Wenn Sie das Kubernetes-Dashboard fertig untersucht haben, beenden Sie den Befehl `proxy` mit der Tastenkombination STRG + C. 

Glückwunsch! Sie haben die erste Version der App bereitgestellt.

Sie sind der Ansicht, dass diese Lerneinheit zu viele Befehle enthält? Ganz Ihrer Meinung. Warum also verwenden Sie nicht ein Konfigurationsscript, das Ihnen einen Teil der Arbeit abnimmt? Um für die zweite Version der App ein Konfigurationsscript zu verwenden und durch die Bereitstellung mehrerer Instanzen dieser App ein höheres Maß an Verfügbarkeit erreichen, fahren Sie mit der nächsten Lerneinheit fort.

### Lerneinheit 2: Apps mit höherer Verfügbarkeit bereitstellen und aktualisieren
{: #cs_apps_tutorial_lesson2}

In dieser Lerneinheit stellen Sie drei Instanzen der App 'Hello World' in einem Cluster für höhere Verfügbarkeit als in der ersten Version der App bereit. Höhere Verfügbarkeit bedeutet, dass der Benutzerzugriff auf drei Instanzen aufgeteilt ist. Versuchen zu viele Benutzer, auf dieselbe Instanz der App zuzugreifen, so können schleppende Reaktionszeiten auftreten. Eine höhere Anzahl von Instanzen kann für Ihre Benutzer gleichbedeutend mit geringeren Reaktionszeiten sein. In der vorliegenden Lerneinheit erfahren Sie außerdem, wie Statusprüfungen und Bereitstellungsaktualisierungen mit Kubernetes funktionieren können.


<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components2.png">![Konfiguration für die Bereitstellung](images/cs_app_tutorial_components2.png)</a>


Wie im Konfigurationsscript definiert kann Kubernetes anhand einer Verfügbarkeitsprüfung feststellen, ob ein Container in einem Pod aktiv oder inaktiv ist. Mit diesen Prüfungen können gegebenenfalls Deadlocks abgefangen werden, bei denen eine App zwar aktiv, nicht aber in der Lage ist, Verarbeitungsfortschritt zu machen. Durch den Neustart eines Containers, der sich in einem solchen Zustand befindet, ist es möglich, die Verfügbarkeit der App trotz Fehlern zu erhöhen. Anhand einer Bereitschaftsprüfung ermittelt Kubernetes dann, wann ein Container wieder für die Entgegennahme von Datenverkehr ist. Ein Pod gilt als bereit, wenn sein Container bereit ist. Wenn der Pod bereit ist, wird er wieder gestartet. In der App 'Stage2' überschreitet die App alle 15 Sekunden das Zeitlimit. Da im Konfigurationsscript eine Statusprüfung konfiguriert ist, werden Container erneut  erstellt, falls bei der Statusprüfung ein Problem im Zusammenhang mit der App festgestellt wird.

1.  Navigieren Sie in einer CLI (Befehlszeilenschnittstelle) zum Verzeichnis für die zweite App namens `Stage2`. Wenn Sie mit Docker Toolbox für Windows oder OS X arbeiten, verwenden Sie 'Docker Quickstart Terminal'.

  ```
  cd <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage2
  ```
  {: pre}

2.  Erstellen und kennzeichnen (taggen) Sie die zweite Version der App lokal als Image. Vergessen Sie auch hier nicht den Punkt (`.`) am Ende des Befehls. 

  ```
  docker build -t registry.<region>.bluemix.net/<namensbereich>/hello-world:2 .
  ```
  {: pre}

  Stellen Sie sicher, dass die Nachricht über die erfolgreiche Ausführung angezeigt wird.

  ```
  Successfully built <image-id>
        ```
  {: screen}

3.  Übertragen Sie die zweite Version des Image mit einer Push-Operation an Ihren Registry-Namensbereich. Fahren Sie erst dann mit dem nächsten Schritt fort, wenn das Image per Push-Operation übertragen worden ist.

  ```
  docker push registry.<region>.bluemix.net/<namensbereich>/hello-world:2
  ```
  {: pre}

  Ausgabe:

  ```
  The push refers to a repository [registry.<region>.bluemix.net/<namensbereich>/hello-world]
  ea2ded433ac8: Pushed
  894eb973f4d3: Pushed
  788906ca2c7e: Pushed
  381c97ba7dc3: Pushed
  604c78617f34: Pushed
  fa18e5ffd316: Pushed
  0a5e2b2ddeaa: Pushed
  53c779688d06: Pushed
  60a0858edcd5: Pushed
  b6ca02dfe5e6: Pushed
  1: digest: sha256:0d90cb73288113bde441ae9b8901204c212c8980d6283fbc2ae5d7cf652405
  43 size: 2398
  ```
  {: screen}

4.  Wenn Sie das Programm 'Docker Quickstart Terminal' verwenden, wechseln Sie zurück zu der CLI (Befehlszeilenschnittstelle), über die Sie die Sitzungsvariable `KUBECONFIG` festgelegt haben.
5.  Überprüfen Sie, ob das Image erfolgreich zum Registry-Namensbereich hinzugefügt wurde.

    ```
    bx cr images
    ```
     {: pre}

    Ausgabe:

    ```
    Listing images...

    REPOSITORY                                 NAMESPACE  TAG  DIGEST        CREATED        SIZE     VULNERABILITY STATUS
    registry.<region>.bluemix.net/<namensbereich>/hello-world  <namensbereich>  1    0d90cb732881  30 minutes ago 264 MB   OK
    registry.<region>.bluemix.net/<namensbereich>/hello-world  <namensbereich>  2    c3b506bdf33e  1 minute ago   264 MB   OK
    ```
    {: screen}

6.  Öffnen Sie die Datei `<benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage2/healthcheck.yml` in einem Texteditor. Dieses Konfigurationsscript verbindet einige Schritte aus der vorherigen Lerneinheit, um zur gleichen Zeit eine Bereitstellung sowie einen Service zu erstellen. Die App-Entwickler des PR-Unternehmens können diese Scripts verwenden, wenn Aktualisierungen durchgeführt werden. Sie können sie auch im Rahmen der Fehlerbehebung einsetzen, indem Sie die Pods neu erstellen.

    1.  Beachten Sie im Abschnitt **Deployment** für die Bereitstellung die Angabe für die Anzahl der Replikate (`replicas`). Replikate sind gleichbedeutend mit der Anzahl von Instanzen Ihrer App. Durch Ausführen von drei Instanzen ist die Verfügbarkeit der App sehr viel höher als dies bei Ausführung von nur einer Instanz der Fall wäre.

        ```
        replicas: 3
        ```
        {: pre}

    2.  Aktualisieren Sie die Details für das Image in Ihrem privaten Registry-Namensbereich.

        ```
        image: "registry.<region>.bluemix.net/<namensbereich>/hello-world:2"
        ```
        {: pre}

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

7.  Führen Sie das Konfigurationsscript im Cluster aus. Wenn die Bereitstellung und der Service erstellt worden sind, kann die App gegenüber den Benutzern des PR-Unternehmens verfügbar gemacht werden.

  ```
  kubectl apply -f <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage2/healthcheck.yml
  ```
  {: pre}

  Ausgabe:

  ```
  deployment "hw-demo-deployment" created
  service "hw-demo-service" created
  ```
  {: screen}

  Nachdem alle Schritte für die Bereitstellung ausgeführt worden sind, sollten Sie das Ergebnis überprüfen. Gegebenenfalls stellen Sie fest, dass alles etwas langsamer ist, da mehr Instanzen aktiv sind.

8.  Öffnen Sie einen Browser und überprüfen Sie die App. Sie bilden die URL, indem Sie dieselbe öffentliche IP-Adresse, die Sie in der vorherigen Lerneinheit für Ihren Workerknoten verwendet haben, mit der Knotenportnummer (NodePort) kombinieren, die im Konfigurationsscript angegeben war. So rufen Sie die öffentliche IP-Adresse für den Workerknoten ab:

  ```
    bx cs workers <pr-unternehmenscluster>
    ```
  {: pre}

  Anhand der Werte für das Beispiel lautet die URL wie folgt: `http://169.47.227.138:30072`. Bei Eingabe dieser URL in einen Browser wird gegebenenfalls der folgende Text angezeigt. Falls dieser Text nicht angezeigt wird, machen Sie sich keine Gedanken. Diese App wurde für alternierende Intervalle von Aktivität und Inaktivität konzipiert.

  ```
  Hello world! Great job getting the second stage up and running! (Hallo Welt! Sie haben Stage2 hervorragend umgesetzt.)
  ```
  {: screen}

  Sie können den Status auch unter `http://169.47.227.138:30072/healthz` überprüfen. 

  Während der ersten 10-15 Sekunden wird eine Nachricht vom Typ 200 zurückgegeben. Dadurch wissen Sie, dass die App erfolgreich ausgeführt wird. Nach Verstreichen dieser 15 Sekunden wird wie in der App vorgesehen eine Zeitlimitnachricht angezeigt.

  ```
  {
    "error": "Timeout, Health check error!" ("Fehler": "Zeitlimitüberschreitung, Fehler bei Statusprüfung!")
  }
  ```
  {: screen}

9.  Starten Sie Ihr Kubernetes-Dashboard über den Standardport 8001.
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

    2.  Öffnen Sie die folgende URL in einem Web-Browser, damit das Kubernetes-Dashboard angezeigt wird.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

10. Auf der Registerkarte **Workloads** werden die von Ihnen erstellten Ressourcen angezeigt. Von dieser Registerkarte aus können Sie die Anzeige fortlaufend aktualisieren lassen und sicherstellen, dass die Statusprüfung ordnungsgemäß funktioniert. Im Abschnitt **Pods** wird angegeben, wie häufig die Pods erneut gestartet werden, wenn die in ihnen enthaltenen Container erneut erstellt werden. Falls Sie per Zufall den folgenden Fehler im Dashboard abfangen, so beachten Sie, das diese Nachricht darauf hinweist, dass bei der Statusprüfung ein Problem festgestellt wurde. Warten Sie einige Minuten ab und aktualisieren Sie dann die Anzeige erneut. Sie können erkennen, dass die Anzahl von Neustarts für jeden Pod variiert.

    ```
    Liveness probe failed: HTTP probe failed with statuscode: 500
Back-off restarting failed docker container
Error syncing pod, skipping: failed to "StartContainer" for "hw-container" with CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-demo-deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
(Aktivitätsprüfung fehlgeschlagen: HTTP-Prüfung fehlgeschlagen mit Statuscode: 500
Fehlgeschlagener Container wird mit 'Back-off' neu gestartet
Fehler bei Synchronisierung von Pod, wird übersprungen: "StartContainer" für "hw-container" mit CrashLoopBackOff fehlgeschlagen: "Back-off 1m20s restarting failed container=hw-container pod=hw-demo-deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
    ```
    {: screen}

    Wenn Sie das Kubernetes-Dashboard fertig untersucht haben, beenden Sie in Ihrer CLI (Befehlszeilenschnittstelle) den Befehl `proxy` mit der Tastenkombination STRG + C. 


Glückwunsch! Sie haben die zweite Version der App bereitgestellt. Hierzu haben Sie eine geringere Anzahl von Befehlen verwenden müssen, konnten erfahren, wie Statusprüfungen funktionieren, und haben eine Bereitstellung bearbeitet, was hervorragend ist. Die App 'Hello World' hat den Test für das PR-Unternehmen bestanden. Nun können Sie eine App mit höherem Nutzwert für das PR-Unternehmen bereitstellen, um mit der Analyse von Pressemitteilungen zu beginnen.

Sind Sie bereit, die von Ihnen erstellten Elemente zu löschen, bevor Sie fortfahren? Dieses Mal können Sie dasselbe Konfigurationsscript verwenden, um die beiden von Ihnen erstellten Ressourcen zu löschen.

```
kubectl delete -f <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage2/healthcheck.yml
```
{: pre}

Ausgabe:

```
deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
```
{: screen}

### Lerneinheit 3: App 'Watson Tone Analyzer' bereitstellen und aktualisieren
{: #cs_apps_tutorial_lesson3}

In den vorherigen Lerneinheiten wurden die Apps als einzelne Komponenten in einem Workerknoten bereitgestellt. In dieser Lerneinheit stellen Sie zwei Komponenten einer App in einem Cluster bereit, die den Service 'Watson Tone Analyzer' verwenden,
den Sie im vorherigen Lernprogramm zu Ihrem Cluster hinzugefügt haben. Durch das Aufteilen der Komponenten auf verschiedene Container stellen Sie sicher, dass Sie ein Element aktualisieren können, ohne dass sich dies nachteilig auf die übrigen auswirkt. Dann aktualisieren Sie die App, um sie mit einer größeren Anzahl von Replikaten vertikal zu skalieren und so ihre Verfügbarkeit weiter zu steigern.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components3.png">[![Konfiguration für die Bereitstellung](images/cs_app_tutorial_components3.png)</a>


#### **Lerneinheit 3a: App 'Watson Tone Analyzer' bereitstellen**
{: #lesson3a}

1.  Navigieren Sie in einer CLI (Befehlszeilenschnittstelle) zum Verzeichnis für die dritte App namens `Stage3`. Wenn Sie mit Docker Toolbox für Windows oder OS X arbeiten, verwenden Sie 'Docker Quickstart Terminal'.

  ```
  cd <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage3
  ```
  {: pre}

2.  Erstellen Sie das erste {{site.data.keyword.watson}}-Image. 

    1.  Navigieren Sie zum Verzeichnis `watson`.

        ```
        cd watson
        ```
        {: pre}

    2.  Erstellen und kennzeichnen (taggen) Sie den ersten Teil der App lokal als Image. Vergessen Sie auch hier nicht den Punkt (`.`) am Ende des Befehls. 

        ```
        docker build -t registry.<region>.bluemix.net/<namensbereich>/watson .
        ```
        {: pre}

        Stellen Sie sicher, dass die Nachricht über die erfolgreiche Ausführung angezeigt wird.

        ```
        Successfully built <image-id>
        ```
        {: screen}

    3.  Übertragen Sie den ersten Teil der App mit einer Push-Operation als Image an Ihren private Registry-Namensbereich. Fahren Sie erst dann mit dem nächsten Schritt fort, wenn das Image per Push-Operation übertragen worden ist.

        ```
        docker push registry.<region>.bluemix.net/<namensbereich>/watson
        ```
        {: pre}

3.  Erstellen Sie das zweite '{{site.data.keyword.watson}}-talk'-Image. 

    1.  Navigieren Sie zum Verzeichnis `watson-talk`.

        ```
        cd <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage3/watson-talk
        ```
        {: pre}

    2.  Erstellen und kennzeichnen (taggen) Sie den zweiten Teil der App lokal als Image. Vergessen Sie auch hier nicht den Punkt (`.`) am Ende des Befehls. 

        ```
        docker build -t registry.<region>.bluemix.net/<namensbereich>/watson-talk .
        ```
        {: pre}

        Stellen Sie sicher, dass die Nachricht über die erfolgreiche Ausführung angezeigt wird.

        ```
        Successfully built <image-id>
        ```
        {: screen}

    3.  Übertragen Sie den zweiten Teil der App mit einer Push-Operation an Ihren privaten Registry-Namensbereich. Fahren Sie erst dann mit dem nächsten Schritt fort, wenn das Image per Push-Operation übertragen worden ist.

        ```
        docker push registry.<region>.bluemix.net/<namensbereich>/watson-talk
        ```
        {: pre}

4.  Wenn Sie das Programm 'Docker Quickstart Terminal' verwenden, wechseln Sie zurück zu der CLI (Befehlszeilenschnittstelle), über die Sie die Sitzungsvariable `KUBECONFIG` festgelegt haben.

5.  Überprüfen Sie, ob die Images erfolgreich zu Ihrem Registry-Namensbereich hinzugefügt wurden.

    ```
    bx cr images
    ```
    {: pre}

    Ausgabe:

    ```
    Listing images...

    REPOSITORY                                  NAMESPACE  TAG            DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    registry.<region>.bluemix.net/namespace/hello-world   namespace  1              0d90cb732881   40 minutes ago  264 MB   OK
    registry.<region>.bluemix.net/namespace/hello-world   namespace  2              c3b506bdf33e   20 minutes ago  264 MB   OK
    registry.<region>.bluemix.net/namespace/watson        namespace  latest         fedbe587e174   3 minutes ago   274 MB   OK
    registry.<region>.bluemix.net/namespace/watson-talk   namespace  latest         fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}

6.  Öffnen Sie die Datei `<benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage3/watson-deployment.yml` in einem Texteditor. Dieses Konfigurationsscript enthält sowohl für die 'watson'- als auch die 'watson-talk'-Komponente der
App eine Bereitstellung und einen Service.

    1.  Aktualisieren Sie für beide Bereitstellungen die Details für das Image in Ihrem Registry-Namensbereich.

        watson:

        ```
        image: "registry.<region>.bluemix.net/namespace/watson"
        ```
        {: codeblock}

        watson-talk:

        ```
        image: "registry.<region>.bluemix.net/namespace/watson-talk"
        ```
        {: codeblock}

    2.  Aktualisieren Sie im Datenträgerabschnitt der Watson-Bereitstellung den Namen des geheimen Schlüssels
für {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}, den Sie im vorherigen Lernprogramm erstellt haben. Wenn Sie den geheimen Kubernetes-Schlüssel als Datenträger an Ihre Bereitstellung anhängen, stellen Sie die
{{site.data.keyword.Bluemix_notm}}-Serviceberechtigungsnachweise
dem Container zur Verfügung, der in Ihrem Pod ausgeführt wird. Die {{site.data.keyword.watson}}-App-Komponenten in diesem Lernprogramm sind so konfiguriert, dass sie die
Serviceberechtigungsnachweise unter Verwendung des Datenträgermountpfads suchen. 

        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-<mein_tone_analyzer>
        ```
        {: codeblock}

        Sollten Sie vergessen haben, welchen Namen Sie dem geheimen Schlüssel gegeben haben, führen Sie den folgenden Befehl aus.

        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}

    3.  Beachten Sie im Abschnitt für den Service 'watson-talk' die Knotenportnummer, die für `NodePort` festgelegt ist. Das vorliegende Beispiel verwendet die Nummer 30080. 

7.  Führen Sie das Konfigurationsscript aus.

  ```
  kubectl apply -f <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage3/watson-deployment.yml
  ```
  {: pre}

8.  Optional: Überprüfen Sie, ob der geheime Schlüssel für {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} als Datenträger an den Pod angehängt wurde. 

    1.  Wenn Sie den Namen eines Watson-Pods abrufen wollen, führen Sie den folgenden Befehl aus:

        ```
        kubectl get pods
        ```
        {: pre}

        Ausgabe:

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

        Ausgabe:

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

9.  Öffnen Sie einen Browser und analysieren Sie Text. Mit der IP-Adresse des Beispiels weist die URL das folgende Format auf `http://<IP-adresse_des_workerknotens>:<knotenportnummer_für_watson-talk>/analyze/"<zu_analysierender_text>"`. Beispiel:

    ```
    http://169.47.227.138:30080/analyze/"Heute ist ein herrlicher Tag"
    ```
    {: codeblock}

    In einem Browser wird die JSON-Antwort auf den von Ihnen eingegebenen Text angezeigt.

10. Starten Sie Ihr Kubernetes-Dashboard über den Standardport 8001.

    1.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Öffnen Sie die folgende URL in einem Web-Browser, damit das Kubernetes-Dashboard angezeigt wird.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

11. Auf der Registerkarte **Workloads** werden die von Ihnen erstellten Ressourcen angezeigt. Wenn Sie das Kubernetes-Dashboard fertig untersucht haben, beenden Sie den Befehl `proxy` mit der Tastenkombination STRG + C. 

#### Lerneinheit 3b. Aktive Bereitstellung von 'Watson Tone Analyzer' aktualisieren
{: #lesson3b}

Während der Ausführung einer Bereitstellung können Sie die Bereitstellung durch Änderung von Werten in der Pod-Vorlage bearbeiten. In dieser Lerneinheit aktualisieren Sie das verwendete Image.

1.  Ändern Sie den Namen des Image. Das PR-Unternehmen möchte eine andere App in derselben Bereitstellung ausprobieren, aber die Änderungen rückgängig machen können, falls ein Problem mit der neuen App auftritt.

    1.  Öffnen Sie das Konfigurationsscript für die aktive Bereitstellung.

        ```
        kubectl edit deployment/watson-talk-pod
        ```
        {: pre}

        Abhängig vom verwendeten Betriebssystem wird ein Editor vom Typ 'vi' oder ein Texteditor geöffnet.

    2.  Ändern Sie den Namen des Image in das 'ibmliberty'-Image.

        ```
        spec:
              containers:
              - image: registry.<region>.bluemix.net/ibmliberty:latest
        ```
        {: codeblock}

    3.  Speichern Sie die Änderungen und beenden Sie den Editor.

    4.  Wenden Sie die Änderungen im Konfigurationsscript auf die aktive Bereitstellung an.

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

    5.  Wenn die Änderungen die Erwartungen nicht erfüllen, können sie rückgängig gemacht werden. Stellen Sie sich vor, dass jemand im PR-Unternehmen bei den App-Änderungen ein Fehler unterlaufen ist
und es daher erforderlich ist, zur vorherigen Bereitstellung zurückzukehren.

        1.  Zeigen Sie die Revisionsnummern an, um die Anzahl der vorherigen Bereitstellungen herauszufinden. Die aktuelle Revision hat die höchste Versionsnummer. In diesem Beispiel war Revision 1 die ursprüngliche Bereitstellung und
Revision 2 ist die Imageänderung, die Sie im vorherigen Schritt vorgenommen haben.

            ```
            kubectl rollout history deployment/watson-talk-pod
            ```
            {: pre}

            Ausgabe:

            ```
            deployments "watson-talk-pod"
            REVISION CHANGE-CAUSE
            1          <keine>
            2          <keine>

            ```
            {: screen}

        2.  Führen Sie den folgenden Befehl aus, um die Bereitstellung auf die vorherige Revision zurückzusetzen. Es wird wieder ein weiterer Pod von Kubernetes erstellt und getestet. Wenn der Test erfolgreich ist, wird der alte Pod entfernt.

            ```
            kubectl rollout undo deployment/watson-talk-pod --to-revision=1
            ```
            {: pre}

            Ausgabe:

            ```
            deployment "watson-talk-pod" rolled back
            ```
            {: screen}

        3.  Notieren Sie sich den Namen des Pods für den nächsten Schritt.

            ```
            kubectl get pods
            ```
            {: pre}

            Ausgabe:

            ```
            NAME                              READY     STATUS    RESTARTS   AGE
            watson-talk-pod-2511517105-6tckg  1/1       Running   0          2m
            ```
            {: screen}

        4.  Zeigen Sie die Details des Pod an und überprüfen Sie, dass die Änderungen am Image rückgängig gemacht wurden.

            ```
            kubectl describe pod <podname>
            ```
            {: pre}

            Ausgabe:

            ```
            Image: registry.<region>.bluemix.net/namespace/watson-talk
            ```
            {: screen}

2.  Optional: Wiederholen Sie die Änderungen für die Bereitstellung 'watson-pod'. 

[Testen Sie Ihr Wissen in einem Quiz! ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://bluemix-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php)

Glückwunsch! Sie haben die App 'Watson Tone Analyzer' bereitgestellt. Das PR-Unternehmen kann diese Bereitstellung der App künftig definitiv einsetzen, um mit der Analyse seiner Pressemitteilungen zu beginnen.

Sind Sie bereit, die von Ihnen erstellten Elemente zu löschen? Zum Löschen der von Ihnen erstellten Ressourcen können Sie das Konfigurationsscript verwenden.

```
kubectl delete -f <benutzername_ausgangsverzeichnis>/container-service-getting-started-wt/Stage3/watson-deployment.yml
```
{: pre}

Ausgabe:

```
deployment "watson-pod" deleted
deployment "watson-talk-pod" deleted
service "watson-service" deleted
service "watson-talk-service" deleted
```
{: screen}

Falls Sie den Cluster nicht beibehalten wollen, können Sie diesen ebenfalls löschen.

```
bx cs cluster-rm <pr-unternehmenscluster>
```
{: pre}

**Womit möchten Sie fortfahren? **

Versuchen Sie die Lernprogramme für die Containerkoordination unter [developerWorks ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/code/journey/category/container-orchestration/). 
