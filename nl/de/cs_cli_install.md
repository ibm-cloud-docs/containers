---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# CLI und API einrichten
{: #cs_cli_install}

Sie können die {{site.data.keyword.containershort_notm}}-CLI
oder -API zu Erstellen und Verwalten Ihrer Kubernetes-Cluster verwenden.
{:shortdesc}

## CLI installieren
{: #cs_cli_install_steps}

Installieren Sie die erforderlichen CLIs, um Ihre Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} zu erstellen und zu verwalten und um containerisierte Apps in Ihrem Cluster bereitzustellen.
{:shortdesc}

Diese Task enthält Informationen zur Installation dieser CLIs (Befehlszeilenschnittstellen) und Plug-ins: 

-   {{site.data.keyword.Bluemix_notm}}-CLI Version 0.5.0 oder höher
-   {{site.data.keyword.containershort_notm}}-Plug-in
-   Kubernetes-CLI-Version 1.5.6 oder höher
-   Optional: {{site.data.keyword.registryshort_notm}}-Plug-in
-   Optional: Docker Version 1.9. oder höher

<br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu installieren:

1.  Als Voraussetzung für das {{site.data.keyword.containershort_notm}}-Plug-in müssen Sie die [{{site.data.keyword.Bluemix_notm}}-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://clis.ng.bluemix.net/ui/home.html) installieren. Das Präfix zum Ausführen von Befehlen über die {{site.data.keyword.Bluemix_notm}}-CLI lautet `bx`. 

2.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
    {: pre}

    **Hinweis:** Falls Sie über eine föderierte ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.



4.  Installieren Sie das {{site.data.keyword.containershort_notm}}-Plug-in, um Kubernetes-Cluster zu erstellen und Workerknoten zu verwalten. Das Präfix zum Ausführen von Befehlen mithilfe des {{site.data.keyword.containershort_notm}}-Plug-ins lautet `bx cs`. 

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Überprüfen Sie durch Ausführen des folgenden Befehls, ob das Plug-in ordnungsgemäß installiert wurde:

    ```
    bx plugin list
    ```
    {: pre}

    Das
{{site.data.keyword.containershort_notm}}-Plug-in wird in den Ergebnissen als 'container-service' angezeigt. 

5.  Um eine lokale Version des Kubernetes-Dashboards anzuzeigen und Apps in Ihren Clustern bereitzustellen, müssen Sie die [Kubernetes-CLI installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Das Präfix zum Ausführen von Befehlen über die Kubernetes-CLI lautet `kubectl`.

    1.  Laden Sie die Kubernetes-CLI herunter.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Tipp:** Wenn Sie Windows verwenden, installieren Sie die Kubernetes-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen einige Dateipfadänderungen, wenn Sie spätere Befehle ausführen.

    2.  OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen.
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis `/usr/local/bin`.

            ```
            mv /<dateipfad>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Stellen Sie sicher, dass `/usr/local/bin` in der Variablen `PATH` Ihres Systems aufgelistet wird. Die Variable `PATH` enthält alle Verzeichnisse, in denen Ihr Betriebssystem ausführbare Dateien finden kann. Die Verzeichnisse, die in der Variablen `PATH` aufgelistet sind, erfüllen jedoch eine andere Funktion. Im Verzeichnis `/usr/local/bin` werden ausführbare Dateien für Software gespeichert, die nicht Bestandteil des Betriebssystem ist und vom Systemadministrator manuell installiert wurde.

            ```
            echo $PATH
            ```
            {: pre}

            CLI-Beispielausgabe: 

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Konvertieren Sie die Binärdatei in eine ausführbare Datei.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6.  Installieren Sie zum Verwalten eines privaten Image-Repositorys das {{site.data.keyword.registryshort_notm}}-Plug-in. Verwenden Sie dieses Plug-in zum Festlegen Ihres eigenen Namensbereichs in einer hoch verfügbaren, skalierbaren, privaten Multi-Tenant-Image-Registry, die von IBM gehostet wird, und zum Speichern und gemeinsamen Nutzen von Docker-Images mit anderen Benutzern. Docker-Images sind erforderlich, um Container in einem Cluster bereitzustellen. Das Präfix zum Ausführen von Registry-Befehlen lautet `bx cr`. 

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Überprüfen Sie durch Ausführen des folgenden Befehls, ob das Plug-in ordnungsgemäß installiert wurde:

    ```
    bx plugin list
    ```
    {: pre}

    Das Plug-in wird in den Ergebnissen unter dem Namen 'container-registry' angezeigt.

7.  Um Images lokal zu erstellen und per Push-Operation an Ihren Registry-Namensbereich übertragen zu können, müssen Sie [Docker installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/community-edition#/download). Wenn Sie Windows 8 oder älter verwenden, können Sie stattdessen [Docker Toolbox ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/products/docker-toolbox) installieren. Die Befehlszeilenschnittstelle von Docker wird verwendet, um Apps zu Images zu kompilieren. Das Präfix zum Ausführen von Befehlen über die Docker-CLI lautet `docker`.

Beginnen Sie anschließend damit, [Kubernetes-Cluster über die CLI mit {{site.data.keyword.containershort_notm}} zu erstellen](cs_cluster.html#cs_cluster_cli).

Referenzinformationen zu diesen CLIs finden Sie in der Dokumentation zu diesen Tools.

-   [`bx`-Befehle](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [`bx cs`-Befehle](cs_cli_reference.html#cs_cli_reference)
-   [`kubectl`-Befehle ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [`bx cr`-Befehle](/docs/cli/plugins/registry/index.html#containerregcli)

## CLI zur Ausführung von `kubectl` konfigurieren
{: #cs_cli_configure}

Sie können die Befehle, die mit der Kubernetes-Befehlszeilenschnittstelle zur Verfügung gestellt werden,
zum Verwalten von Clustern in {{site.data.keyword.Bluemix_notm}} verwenden. Alle in Kubernetes 1.5.6 verfügbaren `kubectl`-Befehle werden für die Verwendung mit Clustern in {{site.data.keyword.Bluemix_notm}} unterstützt. Wenn Sie einen Cluster erstellt haben, müssen Sie den Kontext für Ihre lokale Befehlszeilenschnittstelle (CLI)
mit einer Umgebungsvariablen auf diesen Cluster festlegen. Anschließend können Sie die Kubernetes-`kubectl`-Befehle verwenden,
um in {{site.data.keyword.Bluemix_notm}} mit Ihrem Cluster zu arbeiten.
{:shortdesc}

Damit Sie `kubectl`-Befehle ausführen können, [müssen Sie die erforderlichen Befehlszeilenschnittstellen installieren](#cs_cli_install) und [einen Cluster erstellen](cs_cluster.html#cs_cluster_cli).

1.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
    {: pre}

    Schließen Sie den API-Endpunkt ein, um eine bestimmte {{site.data.keyword.Bluemix_notm}}-Region anzugeben. Falls Sie über private Docker-Images verfügen, die in der Container-Registry einer bestimmten {{site.data.keyword.Bluemix_notm}}-Region gespeichert sind, oder über {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen, die Sie bereits erstellt haben, melden Sie sich an dieser Region an, um auf Ihre Images und {{site.data.keyword.Bluemix_notm}}-Services zuzugreifen.

    Die {{site.data.keyword.Bluemix_notm}}-Region, bei der Sie sich anmelden, bestimmt auch die Region, in der Sie Ihre Kubernetes-Cluster, einschließlich der verfügbaren Rechenzentren, erstellen können. Wenn Sie keine Region angeben, werden Sie automatisch bei der nächstgelegenen Region angemeldet. 
      -   Vereinigte Staaten (Süden)

          ```
          bx login -a api.ng.bluemix.net
          ```
          {: pre}

      -   Sydney

          ```
          bx login -a api.au-syd.bluemix.net
          ```
          {: pre}

      -   Deutschland

          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   Großbritannien

          ```
          bx login -a api.eu-gb.bluemix.net
          ```
          {: pre}

    **Hinweis:** Falls Sie über eine föderierte ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

2.  Wählen Sie ein {{site.data.keyword.Bluemix_notm}}-Konto aus. Wenn Sie mehreren {{site.data.keyword.Bluemix_notm}}-Organisationen zugeordnet sind,
wählen Sie die Organisation aus, in der der Cluster erstellt wurde. Cluster sind für eine Organisation spezifisch, jedoch von einem
{{site.data.keyword.Bluemix_notm}}-Bereich unabhängig. Daher ist es nicht erforderlich, einen Bereich auszuwählen.

3.  Wenn Sie Kubernetes-Cluster in einer anderen Region als der zuvor ausgewählten {{site.data.keyword.Bluemix_notm}}-Region erstellen oder darauf zugreifen möchten, geben Sie die gewünschte Region an. Beispielsweise könnten Sie sich aus den folgenden Gründen bei einer anderen Region als der {{site.data.keyword.containershort_notm}}-Region anmelden: 
   -   Sie haben {{site.data.keyword.Bluemix_notm}}-Services oder private Docker-Images in einer Region erstellt und wollen sie mit {{site.data.keyword.containershort_notm}} in einer anderen Region verwenden. 
   -   Sie möchten auf einen Cluster in einer Region zugreifen, die sich von der {{site.data.keyword.Bluemix_notm}}-Standardregion unterscheidet, bei der Sie angemeldet sind. <br>
   Wählen Sie zwischen den folgenden API-Endpunkten aus: 
        - Vereinigte Staaten (Süden):
          ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
          {: pre}

        - Großbritannien (Süden):
          ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
          {: pre}

        - Zentraleuropa:
          ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
          {: pre}

        - Asiatisch-pazifischer Raum (Süden):
          ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
          {: pre}

4.  Listen Sie alle Cluster im Konto auf, um den Namen des Clusters zu ermitteln.

    ```
    bx cs clusters
    ```
    {: pre}

5.  Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config <clustername_oder_-id>
        ```
        {: pre}

        Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml
        ```
        {: screen}

    2.  Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.
    3.  Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.

        Beispiel:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Ausgabe:
        ```
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml
        ```
        {: screen}

6.  Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.

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


Nun können Sie `kubectl`-Befehle zum Verwalten Ihrer Cluster
in {{site.data.keyword.Bluemix_notm}} ausführen. Eine vollständige Liste von Befehlen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/). 

**Tipp:** Wenn Sie Windows verwenden und die Kubernetes-CLI nicht in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI installiert ist, müssen Sie die Verzeichnisse zu dem Pfad wechseln, in dem die Kubernetes-CLI installiert ist, um `kubectl`-Befehle erfolgreich ausführen zu können..

## CLI aktualisieren
{: #cs_cli_upgrade}

Es kann sinnvoll sein, die CLIs regelmäßig zu aktualisieren, um neue Funktionen verwenden zu können.
{:shortdesc}

Diese Task enthält Informationen zur Aktualisierung dieser CLIs (Befehlszeilenschnittstellen).

-   {{site.data.keyword.Bluemix_notm}}-CLI Version 0.5.0 oder höher
-   {{site.data.keyword.containershort_notm}}-Plug-in
-   Kubernetes-CLI-Version 1.5.6 oder höher
-   {{site.data.keyword.registryshort_notm}}-Plug-in
-   Docker-Version 1.9. oder höher

<br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu aktualisieren:
1.  Aktualisieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI. Laden Sie die [neueste Version ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://clis.ng.bluemix.net/ui/home.html) herunter und führen Sie das Installationsprogramm aus.

2.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
     {: pre}

    Schließen Sie den API-Endpunkt ein, um eine bestimmte {{site.data.keyword.Bluemix_notm}}-Region anzugeben. Falls Sie über private Docker-Images verfügen, die in der Container-Registry einer bestimmten {{site.data.keyword.Bluemix_notm}}-Region gespeichert sind, oder über {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen, die Sie bereits erstellt haben, melden Sie sich an dieser Region an, um auf Ihre Images und {{site.data.keyword.Bluemix_notm}}-Services zuzugreifen.

    Die {{site.data.keyword.Bluemix_notm}}-Region, bei der Sie sich anmelden, bestimmt auch die Region, in der Sie Ihre Kubernetes-Cluster, einschließlich der verfügbaren Rechenzentren, erstellen können. Wenn Sie keine Region angeben, werden Sie automatisch bei der nächstgelegenen Region angemeldet. 

    -   Vereinigte Staaten (Süden)

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

    -   Sydney

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -   Deutschland

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -   Großbritannien

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

        **Hinweis:** Falls Sie über eine föderierte ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

3.  Aktualisieren Sie das {{site.data.keyword.containershort_notm}}-Plug-in.
    1.  Installieren Sie das Update aus dem {{site.data.keyword.Bluemix_notm}}-Plug-in-Repository.

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Überprüfen Sie die Plug-in-Installation, indem Sie den folgenden Befehl ausführen und die Liste der installierten Plug-ins überprüfen.

        ```
        bx plugin list
        ```
        {: pre}

        Das
{{site.data.keyword.containershort_notm}}-Plug-in wird in den Ergebnissen als 'container-service' angezeigt. 

    3.  Initialisieren Sie die CLI.

        ```
        bx cs init
        ```
        {: pre}

4.  Aktualisieren Sie die Kubernetes-CLI.
    1.  Laden Sie die Kubernetes-CLI herunter.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Tipp:** Wenn Sie Windows verwenden, installieren Sie die Kubernetes-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen einige Dateipfadänderungen, wenn Sie spätere Befehle ausführen.

    2.  OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen.
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis '/usr/local/bin'. 

            ```
            mv /<dateipfad>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Stellen Sie sicher, dass `/usr/local/bin` in der Variablen `PATH` Ihres Systems aufgelistet wird. Die Variable `PATH` enthält alle Verzeichnisse, in denen Ihr Betriebssystem ausführbare Dateien finden kann. Die Verzeichnisse, die in der Variablen `PATH` aufgelistet sind, erfüllen jedoch eine andere Funktion. Im Verzeichnis `/usr/local/bin` werden ausführbare Dateien für Software gespeichert, die nicht Bestandteil des Betriebssystem ist und vom Systemadministrator manuell installiert wurde.

            ```
            echo $PATH
            ```
            {: pre}

            CLI-Beispielausgabe: 

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Konvertieren Sie die Binärdatei in eine ausführbare Datei.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Aktualisieren Sie das {{site.data.keyword.registryshort_notm}}-Plug-in.
    1.  Installieren Sie das Update aus dem {{site.data.keyword.Bluemix_notm}}-Plug-in-Repository.

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Überprüfen Sie die Plug-in-Installation, indem Sie den folgenden Befehl ausführen und die Liste der installierten Plug-ins überprüfen.

        ```
        bx plugin list
        ```
        {: pre}

        Das Registry-Plug-in wird in den Ergebnissen unter dem Namen 'container-registry' angezeigt.

6.  Aktualisieren Sie Docker.
    -   Wenn Sie Docker Community Edition verwenden, starten Sie Docker, klicken Sie auf das **Docker**-Symbol und klicken Sie auf **Auf Updates überprüfen**.
    -   Wenn Sie Docker Toolbox verwenden, laden Sie die [neueste Version ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/products/docker-toolbox) herunter und führen Sie das Installationsprogramm aus. 

## CLI deinstallieren
{: #cs_cli_uninstall}

Wenn Sie die Befehlszeilenschnittstelle (CLI) nicht mehr benötigen, können Sie sie deinstallieren.
{:shortdesc}

Diese Task enthält die Informationen zum Entfernen dieser CLIs (Befehlszeilenschnittstellen): 


-   {{site.data.keyword.containershort_notm}}-Plug-in
-   Kubernetes-CLI-Version 1.5.6 oder höher
-   {{site.data.keyword.registryshort_notm}}-Plug-in
-   Docker-Version 1.9. oder höher

<br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu deinstallieren:

1.  Deinstallieren Sie das {{site.data.keyword.containershort_notm}}-Plug-in.

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  Deinstallieren Sie das {{site.data.keyword.registryshort_notm}}-Plug-in.

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  Stellen Sie sicher, dass die Plug-ins auch tatsächlich deinstalliert wurden, indem Sie den folgenden Befehl ausführen und die Liste der installierten Plug-ins überprüfen.

    ```
    bx plugin list
    ```
    {: pre}

    Die Plug-ins 'container-service' und 'container-registry' werden in den Ergebnissen nicht angezeigt. 





6.  Deinstallieren Sie Docker. Die Anweisungen für die Deinstallation von Docker richten sich nach dem Betriebssystem, das Sie verwenden.

    <table summary="Betriebssystemspezifische Anweisungen zur Deinstallation von Docker">
     <tr>
      <th>Betriebssystem</th>
      <th>Link</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>Wählen Sie aus, ob Sie Docker über die [grafische Benutzerschnittstelle oder Befehlszeilenschnittstelle ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset) deinstallieren möchten. </td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>Die Anweisungen für die Deinstallation von Docker richten sich nach der Linux-Distribution, die Sie verwenden. Informationen zum Deinstallieren von Docker für Ubuntu finden Sie unter [Docker deinstallieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce). Verwenden Sie diesen Link, um Anweisungen zu erhalten, wie Sie Docker für andere Linux-Distributionen deinstallieren können, indem Sie Ihre Distribution aus der Navigation auswählen.</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>Deinstallieren Sie die [Docker-Toolbox ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox). </td>
      </tr>
    </table>

## Clusterbereitstellungen mit der API automatisieren
{: #cs_api}

Mithilfe der {{site.data.keyword.containershort_notm}}-API können Sie die Erstellung, Bereitstellung und Verwaltung Ihrer Kubernetes-Cluster automatisieren.
{:shortdesc}

Die {{site.data.keyword.containershort_notm}}-API benötigt Headerinformationen, die Sie in Ihrer API-Anforderung bereitstellen müssen. Diese können je nach verwendeter API variieren. Um zu bestimmen, welche Headerinformationen für Ihre API benötigt werden, finden Sie weitere Informationen in der [{{site.data.keyword.containershort_notm}}-API-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://us-south.containers.bluemix.net/swagger-api).

Die folgenden Schritte enthalten Anweisungen, wie diese Headerinformationen abgerufen werden, so dass Sie sie in Ihre API-Anforderung einschließen können.

1.  Rufen Sie Ihre IAM-Zugriffstoken (Identity and Access Management) ab. Das IAM-Zugriffstoken ist erforderlich, um sich bei {{site.data.keyword.containershort_notm}} anzumelden. Ersetzen Sie _&lt;mein_bluemix-benutzername&gt;_ und _&lt;mein_bluemix-kennwort&gt;_ durch Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Input parameters to get tokens">
      <tr>
        <th>Eingabeparameter</th>
        <th>Werte</th>
      </tr>
      <tr>
        <td>Header</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>Hauptteil</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;mein_bluemix-benutzername&gt;</em></li>
        <li>password: <em>&lt;mein_bluemix-kennwort&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:</li></ul>
        <p>**Hinweis:** Fügen Sie den Schlüssel 'uaa_client_secret' ohne angegebenen Wert hinzu.</p></td>
      </tr>
    </table>

    API-Beispielausgabe:

    ```
    {
    "access_token": "<iam-token>",
    "refresh_token": "<iam-aktualisierungstoken>",
    "uaa_token": "<uaa-token>",
    "uaa_refresh_token": "<uaa-aktualisierungstoken>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    Sie finden das IAM-Token im Feld **access_token** und das UAA-Token im Feld **uaa_token** Ihrer API-Ausgabe. Notieren Sie sich diese IAM- und UAA-Token, um in den nächsten Schritten zusätzliche Headerinformationen abzurufen.

2.  Rufen Sie die ID Ihres {{site.data.keyword.Bluemix_notm}}-Kontos ab, in dem Sie Ihre Cluster erstellen und verwalten möchten. Ersetzen Sie _&lt;iam-token&gt;_ durch das IAM-Token, das Sie im vorherigen Schritt abgerufen haben.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="Eingabeparameter zum Abrufen der Bluemix-Konto-ID">
   <tr>
    <th>Eingabeparameter</th>
    <th>Werte</th>
   </tr>
   <tr>
    <td>Header</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam-token&gt;</li>
      <li>Accept: application/json</li></ul></td>
   </tr>
    </table>

    API-Beispielausgabe:

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<meine_bluemix-konto-id>",
            "url": "/v1/accounts/<meine_bluemix-konto-id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    Sie finden die ID Ihres {{site.data.keyword.Bluemix_notm}}-Kontos im Feld **resources/metadata/guid** Ihrer API-Ausgabe.

3.  Rufen Sie ein neues IAM-Zugriffstoken ab, das Ihre {{site.data.keyword.Bluemix_notm}}-Kontoinformationen
enthält. Ersetzen Sie
_&lt;meine_bluemix-konto-id&gt;_ durch die ID Ihres {{site.data.keyword.Bluemix_notm}}-Kontos, die Sie im vorherigen Schritt abgerufen haben.

    **Hinweis:** IAM-Zugriffstoken laufen nach 1 Stunde ab. Anweisungen zum Aktualisieren Ihres Zugriffstokens finden Sie unter [IAM-Zugriffstoken mit der API aktualisieren](#cs_api_refresh). 

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Eingabeparameter zum Abrufen von Zugriffstoken">
     <tr>
      <th>Eingabeparameter</th>
      <th>Werte</th>
     </tr>
     <tr>
      <td>Header</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>Hauptteil</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;mein_bluemix-benutzername&gt;</em></li>
        <li>password: <em>&lt;mein_bluemix-kennwort&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Hinweis:** Fügen Sie den Schlüssel 'uaa_client_secret' ohne angegebenen Wert hinzu.</p>
        <li>bss_account: <em>&lt;meine_bluemix-konto-id&gt;</em></li></ul></td>
     </tr>
    </table>

    API-Beispielausgabe:

    ```
    {
      "access_token": "<iam-token>",
    "refresh_token": "<iam-aktualisierungstoken>",
    "uaa_token": "<uaa-token>",
    "uaa_refresh_token": "<uaa-aktualisierungstoken>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    Sie finden Ihr IAM-Token im Feld **access_token** und das IAM-Aktualisierungstoken im Feld **refresh_token** Ihrer CLI-Ausgabe.

4.  Rufen Sie die ID Ihres {{site.data.keyword.Bluemix_notm}}-Bereichs ab, in dem Sie Ihren Cluster erstellen oder verwalten möchten.
    1.  Rufen Sie den API-Endpunkt ab, um auf Ihre Bereichs-ID zuzugreifen. Ersetzen Sie _&lt;uaa-token&gt;_ durch das UAA-Token, das Sie im ersten Schritt abgerufen haben.

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="Eingabeparameter zum Abrufen einer Bereichs-ID">
         <tr>
          <th>Eingabeparameter</th>
          <th>Werte</th>
         </tr>
         <tr>
          <td>Header</td>
          <td><ul><li>Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa-token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      API-Beispielausgabe:

      ```
      {
            "metadata": {
              "guid": "<meine_bluemix-organisations-id>",
              "url": "/v2/organizations/<meine_bluemix-organisations-id>",
              "created_at": "2016-01-07T18:55:19Z",
              "updated_at": "2016-02-09T15:56:22Z"
            },
            "entity": {
              "name": "<mein_bluemix-organisationsname>",
              "billing_enabled": false,
              "quota_definition_guid": "<meine_bluemix-organisations-id>",
              "status": "active",
              "quota_definition_url": "/v2/quota_definitions/<meine_bluemix-organisations-id>",
              "spaces_url": "/v2/organizations/<meine_bluemix-organisations-id>/spaces",
      ...

      ```
      {: screen}

5.  Notieren Sie die Ausgabe des Felds **spaces_url**.
6.  Rufen Sie die ID Ihres {{site.data.keyword.Bluemix_notm}}-Bereichs ab, indem Sie den Endpunkt **spaces_url** verwenden.

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<meine_bluemix-organisations-id>/spaces
      ```
      {: pre}

      API-Beispielausgabe:

      ```
      {
            "metadata": {
              "guid": "<meine_bluemix-bereichs-id>",
              "url": "/v2/spaces/<meine_bluemix-bereichs-id>",
              "created_at": "2016-01-07T18:55:22Z",
              "updated_at": null
            },
            "entity": {
              "name": "<mein_bluemix-bereichsname>",
              "organization_guid": "<meine_bluemix-organisations-id>",
              "space_quota_definition_guid": null,
              "allow_ssh": true,
      ...
      ```
      {: screen}

      Sie finden die ID Ihres {{site.data.keyword.Bluemix_notm}}-Bereichs im Feld **metadata/guid** Ihrer API-Ausgabe.

7.  Listen Sie alle Kubernetes-Cluster in Ihrem Konto auf. Verwenden Sie die in früheren Schritten abgerufenen Informationen, um Ihre Headerinformationen zu erstellen.

    -   Vereinigte Staaten (Süden)

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Großbritannien (Süden)

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Zentraleuropa

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Asiatisch-pazifischer Raum (Süden)

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

        <table summary="Eingabeparameter zum Arbeiten mit der API">
         <thead>
          <th>Eingabeparameter</th>
          <th>Werte</th>
         </thead>
          <tbody>
         <tr>
          <td>Header</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam-token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  Eine Liste von unterstützten APIs finden Sie in der [{{site.data.keyword.containershort_notm}}-API-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://us-south.containers.bluemix.net/swagger-api). 

## IAM-Zugriffstoken aktualisieren
{: #cs_api_refresh}

Alle IAM-Zugriffstoken (Identity and Access Management), die über die API ausgegeben werden, laufen nach einer Stunde ab. Sie müssen Ihr Zugriffstoken regelmäßig aktualisieren, um den Zugriff auf die {{site.data.keyword.containershort_notm}}-API zu sichern.
{:shortdesc}

Stellen Sie zunächst sicher, dass Sie über ein IAM-Aktualisierungstoken verfügen, mit dem Sie ein neues Zugriffstoken anfordern können. Wenn Sie kein solches Aktualisierungstoken haben, finden Sie unter [Clustererstellungs- und -verwaltungsprozess mit der {{site.data.keyword.containershort_notm}}-API automatisieren](#cs_api) weitere Informationen darüber, wie Sie Ihr Zugriffstoken abrufen können. 

Führen Sie die folgenden Schritte aus, wenn Sie Ihre IAM-Tokens aktualisieren möchten.

1.  Rufen Sie ein neues IAM-Zugriffstoken ab. Ersetzen Sie _&lt;iam-aktualisierungstoken&gt;_ durch das IAM-Aktualisierungstoken, das Sie bei der erstmaligen Authentifizierung bei {{site.data.keyword.Bluemix_notm}} erhalten haben.

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Eingabeparameter für neue IAM-Token">
     <tr>
      <th>Eingabeparameter</th>
      <th>Werte</th>
     </tr>
     <tr>
      <td>Header</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>Hauptteil</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>refresh_token: <em>&lt;iam-aktualisierungstoken&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Hinweis:** Fügen Sie den Schlüssel 'uaa_client_secret' ohne angegebenen Wert hinzu.</p></li><ul></td>
     </tr>
    </table>

    API-Beispielausgabe:

    ```
    {
      "access_token": "<iam-token>",
    "refresh_token": "<iam-aktualisierungstoken>",
    "uaa_token": "<uaa-token>",
    "uaa_refresh_token": "<uaa-aktualisierungstoken>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    Sie finden Ihr neues IAM-Token im Feld **access_token** und das IAM-Aktualisierungstoken im Feld
**refresh_token** Ihrer
API-Ausgabe.

2.  Arbeiten Sie weiter mit der [{{site.data.keyword.containershort_notm}}-API-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://us-south.containers.bluemix.net/swagger-api), indem Sie das Token aus dem vorherigen Schritt verwenden. 
