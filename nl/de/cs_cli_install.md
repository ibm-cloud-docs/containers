---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

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

Sie können die {{site.data.keyword.containerlong}}-CLI
oder -API zu Erstellen und Verwalten Ihrer Kubernetes-Cluster verwenden.
{:shortdesc}

<br />


## CLI installieren
{: #cs_cli_install_steps}

Installieren Sie die erforderlichen CLIs, um Ihre Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}} zu erstellen und zu verwalten und um containerisierte Apps in Ihrem Cluster bereitzustellen.
{:shortdesc}

Diese Task enthält Informationen zur Installation dieser CLIs (Befehlszeilenschnittstellen) und Plug-ins:

-   {{site.data.keyword.Bluemix_notm}}-CLI Version 0.8.0 oder höher
-   {{site.data.keyword.containerlong_notm}}-Plug-in
-   Kubernetes CLI-Version, die mit der Version `major.minor` Ihres Clusters übereinstimmt
-   Optional: {{site.data.keyword.registryshort_notm}}-Plug-in

<br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu installieren:

1.  Als Voraussetzung für das {{site.data.keyword.containerlong_notm}}-Plug-in müssen Sie die [{{site.data.keyword.Bluemix_notm}}-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](../cli/index.html#overview) installieren. Das Präfix zum Ausführen von Befehlen über die {{site.data.keyword.Bluemix_notm}}-CLI lautet `ibmcloud`.

    Beabsichtigen Sie, die CLI häufig einzusetzen? Dann probieren Sie aus, was im Abschnitt [Automatische Vervollständigung für die Shell für die {{site.data.keyword.Bluemix_notm}}-CLI aktivieren (nur Linux/MacOS)](/docs/cli/reference/ibmcloud/enable_cli_autocompletion.html#enabling-shell-autocompletion-for-ibm-cloud-cli-linux-macos-only-) beschrieben ist.
    {: tip}

2.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    ibmcloud login
    ```
    {: pre}

    **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `ibmcloud login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

3.  Installieren Sie das {{site.data.keyword.containerlong_notm}}-Plug-in, um Kubernetes-Cluster zu erstellen und Workerknoten zu verwalten. Das Präfix zum Ausführen von Befehlen mithilfe des {{site.data.keyword.containerlong_notm}}-Plug-ins lautet `ibmcloud ks`.

    ```
    ibmcloud plugin install container-service 
    ```
    {: pre}

    Überprüfen Sie durch Ausführen des folgenden Befehls, ob das Plug-in ordnungsgemäß installiert wurde:

    ```
    ibmcloud plugin list
    ```
    {: pre}

    Das
{{site.data.keyword.containerlong_notm}}-Plug-in wird in den Ergebnissen als 'container-service' angezeigt.

4.  {: #kubectl}Um eine lokale Version des Kubernetes-Dashboards anzuzeigen und Apps in Ihren Clustern bereitzustellen, müssen Sie die [Kubernetes-CLI installieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Das Präfix zum Ausführen von Befehlen über die Kubernetes-CLI lautet `kubectl`.

    1.  Laden Sie die Kubernetes-CLI-Version `major.minor` herunter, die mit der Version des Kubernetes-Clusters `major.minor` übereinstimmt, die Sie verwenden möchten. Die aktuelle Kubernetes-Standardversion für {{site.data.keyword.containerlong_notm}} ist die Version 1.10.8.**Hinweis**: Wenn Sie eine `kubectl`-CLI-Version verwenden, die nicht wenigstens mit der Version `major.minor` Ihrer Cluster übereinstimmt, kann dies zu unerwarteten Ergebnissen führen. Stellen Sie sicher, dass Ihr Kubernetes-Cluster und die CLI-Versionen immer auf dem neuesten Stand sind.

        - **OS X**:   [https://storage.googleapis.com/kubernetes-release/release/v1.10.8/bin/darwin/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.10.8/bin/darwin/amd64/kubectl)
        - **Linux**:   [https://storage.googleapis.com/kubernetes-release/release/v1.10.8/bin/linux/amd64/kubectl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.10.8/bin/linux/amd64/kubectl)
        - **Windows**:    [https://storage.googleapis.com/kubernetes-release/release/v1.10.8/bin/windows/amd64/kubectl.exe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://storage.googleapis.com/kubernetes-release/release/v1.10.8/bin/windows/amd64/kubectl.exe)

    2.  **Für OSX und Linux**: Führen Sie die folgenden Schritte aus:
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis `/usr/local/bin`.

            ```
            mv /filepath/kubectl /usr/local/bin/kubectl
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

        3.  Konvertieren Sie die Datei in eine ausführbare Datei.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

    3.  **Für Windows**: Installieren Sie die Kubernetes-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen einige Dateipfadänderungen, wenn Sie spätere Befehle ausführen.

5.  Installieren Sie zum Verwalten eines privaten Image-Repositorys das {{site.data.keyword.registryshort_notm}}-Plug-in. Verwenden Sie dieses Plug-in zum Festlegen Ihres eigenen Namensbereichs in einer hoch verfügbaren, skalierbaren, privaten Multi-Tenant-Image-Registry, die von IBM gehostet wird, und zum Speichern und gemeinsamen Nutzen von Docker-Images mit anderen Benutzern. Docker-Images sind erforderlich, um Container in einem Cluster bereitzustellen. Das Präfix für die Ausführung von Registry-Befehlen ist `ibmcloud cr`.

    ```
    ibmcloud plugin install container-registry 
    ```
    {: pre}

    Überprüfen Sie durch Ausführen des folgenden Befehls, ob das Plug-in ordnungsgemäß installiert wurde:

    ```
    ibmcloud plugin list
    ```
    {: pre}

    Das Plug-in wird in den Ergebnissen unter dem Namen 'container-registry' angezeigt.

Beginnen Sie anschließend damit, [Kubernetes-Cluster über die CLI mit {{site.data.keyword.containerlong_notm}} zu erstellen](cs_clusters.html#clusters_cli).

Referenzinformationen zu diesen CLIs finden Sie in der Dokumentation zu diesen Tools.

-   [`ibmcloud`-Befehle](../cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli)
-   [`ibmcloud ks`-Befehle](cs_cli_reference.html#cs_cli_reference)
-   [`kubectl`-Befehle ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [`ibmcloud cr`-Befehle](/docs/cli/plugins/registry/index.html)

<br />




## CLI in einem Container auf Ihrem Computer ausführen
{: #cs_cli_container}

Anstatt jede der CLIs einzeln auf Ihrem Computer zu installieren, können Sie die CLIs in einem Container installieren, der auf dem Computer ausgeführt wird.
{:shortdesc}

[Installieren Sie zunächst Docker ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.docker.com/community-edition#/download), um Images lokal zu erstellen und auszuführen. Wenn Sie Windows 8 oder älter verwenden, können Sie stattdessen [Docker Toolbox ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.docker.com/toolbox/toolbox_install_windows/) installieren.

1. Erstellen Sie ein Image von der bereitgestellten Dockerfile.

    ```
    docker build -t <imagename> https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/install-clis-container/Dockerfile
    ```
    {: pre}

2. Stellen Sie das Image lokal als Container bereit und hängen Sie ein Datenträger für den Zugriff auf lokale Dateien an.

    ```
    docker run -it -v /local/path:/container/volume <imagename>
    ```
    {: pre}

3. Beginnen Sie damit, die Befehle `ibmcloud ks` und `kubectl` über die interaktive Shell auszuführen. Wenn Sie Daten erstellen, die gespeichert werden sollen, speichern Sie diese auf dem angehängten Datenträger. Wenn Sie die Shell beenden, wird der Container gestoppt.

<br />



## CLI zur Ausführung von `kubectl` konfigurieren
{: #cs_cli_configure}

Sie können die Befehle, die mit der Kubernetes-Befehlszeilenschnittstelle zur Verfügung gestellt werden,
zum Verwalten von Clustern in {{site.data.keyword.Bluemix_notm}} verwenden.
{:shortdesc}

Alle in Kubernetes 1.10.8 verfügbaren `kubectl`-Befehle werden für die Verwendung mit Clustern in {{site.data.keyword.Bluemix_notm}} unterstützt. Wenn Sie einen Cluster erstellt haben, müssen Sie den Kontext für Ihre lokale Befehlszeilenschnittstelle (CLI)
mit einer Umgebungsvariablen auf diesen Cluster festlegen. Anschließend können Sie die Kubernetes-`kubectl`-Befehle verwenden,
um in {{site.data.keyword.Bluemix_notm}} mit Ihrem Cluster zu arbeiten.

Damit Sie `kubectl`-Befehle ausführen können, [müssen Sie die erforderlichen Befehlszeilenschnittstellen (CLIs) installieren](#cs_cli_install) und [einen Cluster erstellen](cs_clusters.html#clusters_cli).

1.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden. Zur Angabe einer {{site.data.keyword.Bluemix_notm}}-Region müssen Sie den [API-Endpunkt einschließen](cs_regions.html#bluemix_regions).

    ```
    ibmcloud login
    ```
    {: pre}

    **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `ibmcloud login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

2.  Wählen Sie ein {{site.data.keyword.Bluemix_notm}}-Konto aus. Wenn Sie mehreren {{site.data.keyword.Bluemix_notm}}-Organisationen zugeordnet sind,
wählen Sie die Organisation aus, in der der Cluster erstellt wurde. Cluster sind für eine Organisation spezifisch, jedoch von einem {{site.data.keyword.Bluemix_notm}}-Bereich unabhängig. Daher ist es nicht erforderlich, einen Bereich auszuwählen.

3. Wenn Sie Cluster erstellen und mit ihnen in einer Ressourcengruppe arbeiten möchten, die nicht mit der Standardressourcengruppe identisch ist, geben Sie die entsprechende Ressourcengruppe als Ziel an. **Anmerkung:** Sie müssen über die [Zugriffsrechte eines **Anzeigeberechtigten**](cs_users.html#platform) für die Ressourcengruppe verfügen.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

3.  Um Kubernetes-Cluster in einer anderen als der zuvor ausgewählten {{site.data.keyword.Bluemix_notm}}-Region zu erstellen, führen Sie `ibmcloud ks region-set` aus.

4.  Listen Sie alle Cluster im Konto auf, um den Namen des Clusters zu ermitteln.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

5.  Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        ibmcloud ks cluster-config <clustername_oder_-id>
        ```
        {: pre}

        Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.

        **Mac- oder Linux-Benutzer**: Anstatt den Befehl `ibmcloud ks cluster-config` auszuführen und die Umgebungsvariable `KUBECONFIG` zu kopieren, können Sie `(ibmcloud ks cluster-config "<cluster-name>" | grep export)` ausführen.
        {:tip}

    3.  Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.

        Beispiel:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Ausgabe:
        ```
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

6.  Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.

    ```
    kubectl version  --short
    ```
    {: pre}

    Beispielausgabe:

    ```
    Client Version: v1.10.8
    Server Version: v1.10.8
    ```
    {: screen}

Nun können Sie `kubectl`-Befehle zum Verwalten Ihrer Cluster
in {{site.data.keyword.Bluemix_notm}} ausführen. Eine vollständige Liste von Befehlen finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/).

**Tipp:** Wenn Sie Windows verwenden und die Kubernetes-CLI nicht in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI installiert ist, müssen Sie die Verzeichnisse zu dem Pfad wechseln, in dem die Kubernetes-CLI installiert ist, um `kubectl`-Befehle erfolgreich ausführen zu können..


<br />


## CLI aktualisieren
{: #cs_cli_upgrade}

Es kann sinnvoll sein, die CLIs regelmäßig zu aktualisieren, um neue Funktionen verwenden zu können.
{:shortdesc}

Diese Task enthält Informationen zur Aktualisierung dieser CLIs (Befehlszeilenschnittstellen).

-   {{site.data.keyword.Bluemix_notm}}-CLI Version 0.8.0 oder höher
-   {{site.data.keyword.containerlong_notm}}-Plug-in
-   Kubernetes-CLI Version 1.10.8 oder höher
-   {{site.data.keyword.registryshort_notm}}-Plug-in

<br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu aktualisieren:

1.  Aktualisieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI. Laden Sie die [neueste Version ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](../cli/index.html#overview) herunter und führen Sie das Installationsprogramm aus.

2. Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden. Zur Angabe einer {{site.data.keyword.Bluemix_notm}}-Region müssen Sie den [API-Endpunkt einschließen](cs_regions.html#bluemix_regions).

    ```
    ibmcloud login
    ```
    {: pre}

     **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `ibmcloud login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und
verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

3.  Aktualisieren Sie das {{site.data.keyword.containerlong_notm}}-Plug-in.
    1.  Installieren Sie das Update aus dem {{site.data.keyword.Bluemix_notm}}-Plug-in-Repository.

        ```
        ibmcloud plugin update container-service 
        ```
        {: pre}

    2.  Überprüfen Sie die Plug-in-Installation, indem Sie den folgenden Befehl ausführen und die Liste der installierten Plug-ins überprüfen.

        ```
        ibmcloud plugin list
        ```
        {: pre}

        Das
{{site.data.keyword.containerlong_notm}}-Plug-in wird in den Ergebnissen als 'container-service' angezeigt.

    3.  Initialisieren Sie die CLI.

        ```
        ibmcloud ks init
        ```
        {: pre}

4.  [Aktualisieren Sie die Kubernetes-CLI](#kubectl).

5.  Aktualisieren Sie das {{site.data.keyword.registryshort_notm}}-Plug-in.
    1.  Installieren Sie das Update aus dem {{site.data.keyword.Bluemix_notm}}-Plug-in-Repository.

        ```
        ibmcloud plugin update container-registry 
        ```
        {: pre}

    2.  Überprüfen Sie die Plug-in-Installation, indem Sie den folgenden Befehl ausführen und die Liste der installierten Plug-ins überprüfen.

        ```
        ibmcloud plugin list
        ```
        {: pre}

        Das Registry-Plug-in wird in den Ergebnissen unter dem Namen 'container-registry' angezeigt.

<br />


## CLI deinstallieren
{: #cs_cli_uninstall}

Wenn Sie die Befehlszeilenschnittstelle (CLI) nicht mehr benötigen, können Sie sie deinstallieren.
{:shortdesc}

Diese Task enthält die Informationen zum Entfernen dieser CLIs (Befehlszeilenschnittstellen):


-   {{site.data.keyword.containerlong_notm}}-Plug-in
-   Kubernetes-CLI
-   {{site.data.keyword.registryshort_notm}}-Plug-in
<br>
Gehen Sie wie folgt vor, um die Befehlszeilenschnittstellen (CLIs) zu deinstallieren:

1.  Deinstallieren Sie das {{site.data.keyword.containerlong_notm}}-Plug-in.

    ```
    ibmcloud plugin uninstall container-service
    ```
    {: pre}

2.  Deinstallieren Sie das {{site.data.keyword.registryshort_notm}}-Plug-in.

    ```
    ibmcloud plugin uninstall container-registry
    ```
    {: pre}

3.  Stellen Sie sicher, dass die Plug-ins auch tatsächlich deinstalliert wurden, indem Sie den folgenden Befehl ausführen und die Liste der installierten Plug-ins überprüfen.

    ```
    ibmcloud plugin list
    ```
    {: pre}

    Die Plug-ins 'container-service' und 'container-registry' werden in den Ergebnissen nicht angezeigt.

<br />


## Clusterbereitstellungen mit der API automatisieren
{: #cs_api}

Mithilfe der {{site.data.keyword.containerlong_notm}}-API können Sie die Erstellung, Bereitstellung und Verwaltung Ihrer Kubernetes-Cluster automatisieren.
{:shortdesc}

Die {{site.data.keyword.containerlong_notm}}-API benötigt Headerinformationen, die Sie in Ihrer API-Anforderung bereitstellen müssen. Diese können je nach verwendeter API variieren. Um zu bestimmen, welche Headerinformationen für Ihre API benötigt werden, finden Sie weitere Informationen in der [{{site.data.keyword.containerlong_notm}}-API-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://us-south.containers.bluemix.net/swagger-api).

Sie können auch die [swagger.json-Datei für APIs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://containers.bluemix.net/swagger-api-json) verwenden, um einen Client zu generieren, der mit der API als Teil Ihrer Automatisierungsarbeit interagieren kann.
{: tip}

**Hinweis:** Zur Authentifizierung bei {{site.data.keyword.containerlong_notm}} müssen Sie ein IAM-Token (IAM = Identity and Access Management) angeben, das mit Ihren {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweisen generiert wurde und das die {{site.data.keyword.Bluemix_notm}}-Konto-ID umfasst, unter der der Cluster erstellt wurde. Abhängig von der Art und Weise, in der Sie die Authentifizierung bei {{site.data.keyword.Bluemix_notm}} durchführen, können Sie zwischen den folgenden Optionen zur Automatisierung der Erstellung Ihres IAM-Tokens wählen.

<table>
<caption>ID-Typen und Optionen</caption>
<thead>
<th>{{site.data.keyword.Bluemix_notm}}-ID</th>
<th>Meine Optionen</th>
</thead>
<tbody>
<tr>
<td>Nicht eingebundene ID</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}}-Benutzername und -Kennwort:</strong> Sie können die Schritte im vorliegenden Abschnitt ausführen, um die Erstellung des IAM-Zugriffstokens vollständig zu automatisieren.</li>
<li><strong>{{site.data.keyword.Bluemix_notm}}-API-Schlüssel generieren:</strong> Alternativ zur Verwendung des {{site.data.keyword.Bluemix_notm}}-Benutzernamens und des zugehörigen Kennworts können Sie <a href="../iam/apikeys.html#manapikey" target="_blank">auch {{site.data.keyword.Bluemix_notm}}-API-Schlüssel verwenden.</a> {{site.data.keyword.Bluemix_notm}}-API-Schlüssel sind von dem {{site.data.keyword.Bluemix_notm}}-Konto abhängig, für das sie generiert wurden. Sie können Ihren {{site.data.keyword.Bluemix_notm}}-API-Schlüssel nicht mit einer anderen Konto-ID in demselben IAM-Token kombinieren. Um auf Cluster zugreifen zu können, die mit einem anderen Konto als dem Konto erstellt wurden, auf dem der {{site.data.keyword.Bluemix_notm}}-API-Schlüssel basiert, müssen Sie sich bei dem Konto anmelden, um einen neuen API-Schlüssel zu generieren. </li></ul></tr>
<tr>
<td>Eingebundene ID</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}}-API-Schlüssel generieren:</strong> <a href="../iam/apikeys.html#manapikey" target="_blank">{{site.data.keyword.Bluemix_notm}}-API-Schlüssel</a> sind von dem {{site.data.keyword.Bluemix_notm}}-Konto abhängig, für das sie generiert wurden. Sie können Ihren {{site.data.keyword.Bluemix_notm}}-API-Schlüssel nicht mit einer anderen Konto-ID in demselben IAM-Token kombinieren. Um auf Cluster zugreifen zu können, die mit einem anderen Konto als dem Konto erstellt wurden, auf dem der {{site.data.keyword.Bluemix_notm}}-API-Schlüssel basiert, müssen Sie sich bei dem Konto anmelden, um einen neuen API-Schlüssel zu generieren. </li><li><strong>Einmaligen Kenncode verwenden:</strong> Wenn Sie sich bei {{site.data.keyword.Bluemix_notm}} authentifizieren, indem Sie einen einmaligen Kenncode verwenden, dann können Sie die Erstellung Ihres IAM-Tokens nicht vollständig automatisieren, weil das Abrufen des einmaligen Kenncodes einen manuellen Eingriff beim Web-Browser erfordert. Um die Erstellung Ihres IAM-Tokens vollständig zu automatisieren, müssen Sie stattdessen einen {{site.data.keyword.Bluemix_notm}}-API-Schlüssel erstellen. </ul></td>
</tr>
</tbody>
</table>

1.  Erstellen Sie Ihr IAM-Zugriffstoken (IAM = Identity and Access Management). Die Informationen des Hauptteils, der Bestandteil Ihrer Anforderung ist, kann abhängig von der {{site.data.keyword.Bluemix_notm}}-Authentifizierungsmethode, die verwendet wird, variieren. Ersetzen Sie die folgenden Werte:
  - _&lt;benutzername&gt;_: Ihr {{site.data.keyword.Bluemix_notm}}-Benutzername
  - _&lt;kennwort&gt;_: Ihr {{site.data.keyword.Bluemix_notm}}-Kennwort
  - _&lt;api-schlüssel&gt;_: Ihr {{site.data.keyword.Bluemix_notm}}-API-Schlüssel
  - _&lt;kenncode&gt;_: Ihr einmaliger {{site.data.keyword.Bluemix_notm}}-Kenncode. Führen Sie den Befehl `ibmcloud login --sso` aus und befolgen Sie die Anweisungen in der CLI-Ausgabe, um den einmaligen Kenncode über Ihren Web-Browser abzurufen.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    Beispiel:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    Um eine {{site.data.keyword.Bluemix_notm}}-Region anzugeben, [sehen Sie nach, welche Regionsabkürzungen in den API-Endpunkten verwendet werden](cs_regions.html#bluemix_regions).

    <table summary-"Input parameters to retrieve tokens">
    <caption>Eingabeparameter zum Abrufen von Tokens</caption>
    <thead>
        <th>Eingabeparameter</th>
        <th>Werte</th>
    </thead>
    <tbody>
    <tr>
    <td>Header</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><strong>Hinweis</strong>: <code>Yng6Yng=</code> entspricht der URL-codierten Autorisierung für den Benutzernamen <strong>bx</strong> und das Kennwort <strong>bx</strong>.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Hauptteil für {{site.data.keyword.Bluemix_notm}}-Benutzername und -Kennwort</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam uaa</li>
    <li>username: <em>&lt;benutzername&gt;</em></li>
    <li>password: <em>&lt;kennwort&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li></ul>
    <strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    <tr>
    <td>Hauptteil für {{site.data.keyword.Bluemix_notm}}-API-Schlüssel</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam uaa</li>
    <li>apikey: <em>&lt;api-schlüssel&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li></ul>
    <strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    <tr>
    <td>Hauptteil für einmaligen {{site.data.keyword.Bluemix_notm}}-Kenncode</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam uaa</li>
    <li>passcode: <em>&lt;kenncode&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li></ul>
    <strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    </tbody>
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

    Sie finden das IAM-Token im Feld **access_token** Ihrer API-Ausgabe. Notieren Sie das IAM-Token, um in den nächsten Schritten zusätzliche Headerinformationen abzurufen.

2.  Rufen Sie die ID des {{site.data.keyword.Bluemix_notm}}-Kontos ab, unter dem der Cluster erstellt wurde. Ersetzen Sie _&lt;iam-token&gt;_ durch das IAM-Token, das Sie im vorherigen Schritt abgerufen haben.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="Eingabeparameter zum Abrufen der {{site.data.keyword.Bluemix_notm}}-Konto-ID">
    <caption>Eingabeparameter zum Abrufen einer {{site.data.keyword.Bluemix_notm}}-Konto-ID</caption>
    <thead>
  	<th>Eingabeparameter</th>
  	<th>Werte</th>
    </thead>
    <tbody>
  	<tr>
  		<td>Header</td>
  		<td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam-token&gt;</li>
      <li>Accept: application/json</li></ul></td>
  	</tr>
    </tbody>
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
            "guid": "<konto-id>",
            "url": "/v1/accounts/<konto-id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    Sie finden die ID Ihres {{site.data.keyword.Bluemix_notm}}-Kontos im Feld **resources/metadata/guid** Ihrer API-Ausgabe.

3.  Generieren Sie ein neues IAM-Token, das Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise und die Konto-ID enthält, unter der der Cluster erstellt wurde. Ersetzen Sie _&lt;konto-id&gt;_ durch die ID des {{site.data.keyword.Bluemix_notm}}-Kontos, die Sie im vorherigen Schritt abgerufen haben.

    **Hinweis:** Wenn Sie einen {{site.data.keyword.Bluemix_notm}}-API-Schlüssel verwenden, dann müssen Sie die {{site.data.keyword.Bluemix_notm}}-Konto-ID verwenden, für die der API-Schlüssel erstellt wurde. Um auf Cluster in anderen Konten zugreifen zu können, müssen Sie sich bei dem betreffenden Konto anmelden und einen {{site.data.keyword.Bluemix_notm}}-API-Schlüssel erstellen, der auf diesem Konto basiert.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    Beispiel:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    Um eine {{site.data.keyword.Bluemix_notm}}-Region anzugeben, [sehen Sie nach, welche Regionsabkürzungen in den API-Endpunkten verwendet werden](cs_regions.html#bluemix_regions).

    <table summary-"Input parameters to retrieve tokens">
    <caption>Eingabeparameter zum Abrufen von Tokens</caption>
    <thead>
        <th>Eingabeparameter</th>
        <th>Werte</th>
    </thead>
    <tbody>
    <tr>
    <td>Header</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><strong>Hinweis</strong>: <code>Yng6Yng=</code> entspricht der URL-codierten Autorisierung für den Benutzernamen <strong>bx</strong> und das Kennwort <strong>bx</strong>.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Hauptteil für {{site.data.keyword.Bluemix_notm}}-Benutzername und -Kennwort</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam uaa</li>
    <li>username: <em>&lt;benutzername&gt;</em></li>
    <li>password: <em>&lt;kennwort&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;konto-id&gt;</em></li></ul>
    <strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    <tr>
    <td>Hauptteil für {{site.data.keyword.Bluemix_notm}}-API-Schlüssel</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam uaa</li>
    <li>apikey: <em>&lt;api-schlüssel&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;konto-id&gt;</em></li></ul>
      <strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    <tr>
    <td>Hauptteil für einmaligen {{site.data.keyword.Bluemix_notm}}-Kenncode</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam uaa</li>
    <li>passcode: <em>&lt;kenncode&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;konto-id&gt;</em></li></ul><strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    </tbody>
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

    Sie finden das IAM-Token im Feld **access_token** und das IAM-Aktualisierungstoken im Feld **refresh_token**.

4.  Listen Sie alle Kubernetes-Cluster in Ihrem Konto auf. Verwenden Sie die in früheren Schritten abgerufenen Informationen, um Ihre Headerinformationen zu erstellen.

     ```
     GET https://containers.bluemix.net/v1/clusters
     ```
     {: codeblock}

     <table summary="Eingabeparameter zum Arbeiten mit der API">
     <caption>Eingabeparameter zum Arbeiten mit der API</caption>
     <thead>
     <th>Eingabeparameter</th>
     <th>Werte</th>
     </thead>
     <tbody>
     <tr>
     <td>Header</td>
     <td><ul><li>Authorization: bearer <em>&lt;iam-token&gt;</em></li>
     <li>X-Auth-Refresh-Token: <em>&lt;aktualisierungstoken&gt;</em></li></ul></td>
     </tr>
     </tbody>
     </table>

5.  Eine Liste von unterstützten APIs finden Sie in der [{{site.data.keyword.containerlong_notm}}-API-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://containers.bluemix.net/swagger-api).

<br />


## IAM-Zugriffstoken aktualisieren und neue Aktualisierungstoken abrufen
{: #cs_api_refresh}

Alle IAM-Zugriffstoken (Identity and Access Management), die über die API ausgegeben werden, laufen nach einer Stunde ab. Sie müssen Ihr Zugriffstoken regelmäßig aktualisieren, um den Zugriff auf die {{site.data.keyword.Bluemix_notm}}-API zu sichern. Sie können dieselben Schritte ausführen, um ein neues Aktualisierungstoken abzurufen.
{:shortdesc}

Stellen Sie zunächst sicher, dass Sie über ein IAM-Aktualisierungstoken oder einen {{site.data.keyword.Bluemix_notm}}-API-Schlüssel verfügen, mit dem Sie ein neues Zugriffstoken anfordern können.
- **Aktualisierungstoken:** Führen Sie die Anweisungen unter [Clustererstellungs- und -verwaltungsprozess mit der {{site.data.keyword.Bluemix_notm}}-API automatisieren](#cs_api) aus.
- **API-Schlüssel:** Rufen Sie Ihren [{{site.data.keyword.Bluemix_notm}}-API-Schlüssel ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) wie folgt ab.
   1. Klicken Sie in der Menüleiste auf **Verwalten** > **Sicherheit** > **Plattform-API-Schlüssel**.
   2. Klicken Sie auf **Erstellen**.
   3. Geben Sie einen **Namen** und eine **Beschreibung** für Ihren API-Schlüssel ein und klicken Sie auf **Erstellen**.
   4. Klicken Sie auf **Anzeigen**, um den API-Schlüssel anzuzeigen, der für Sie generiert wurde.
   5. Kopieren Sie den API-Schlüssel, um mit ihm Ihr neues IAM-Zugriffstoken abzurufen.

Führen Sie die folgenden Schritte aus, wenn Sie ein IAM-Token erstellen oder ein neues Aktualisierungstoken abrufen möchten.

1.  Generieren Sie ein neues IAM-Zugriffstoken, indem Sie das Aktualisierungstoken oder den {{site.data.keyword.Bluemix_notm}}-API-Schlüssel verwenden.
    ```
    POST https://iam.bluemix.net/identity/token
    ```
    {: codeblock}

    <table summary="Eingabeparameter für neue IAM-Token">
    <caption>Eingabeparameter für neue IAM-Token</caption>
    <thead>
    <th>Eingabeparameter</th>
    <th>Werte</th>
    </thead>
    <tbody>
    <tr>
    <td>Header</td>
    <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
      <li>Authorization: Basic Yng6Yng=</br></br><strong>Note:</strong> <code>Yng6Yng=</code> entspricht der URL-codierten Autorisierung für den Benutzernamen <strong>bx</strong> und das Kennwort <strong>bx</strong>.</li></ul></td>
    </tr>
    <tr>
    <td>Hauptteil bei Verwendung des Aktualisierungstoken</td>
    <td><ul><li>grant_type: refresh_token</li>
    <li>response_type: cloud_iam uaa</li>
    <li>refresh_token: <em>&lt;iam-aktualisierungstoken&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;konto-id&gt;</em></li></ul><strong>Hinweis</strong>: Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    <tr>
      <td>Hauptteil bei Verwendung des {{site.data.keyword.Bluemix_notm}}-API-Schlüssels</td>
      <td><ul><li>grant_type: <code>urn:ibm:params:oauth:grant-type:apikey</code></li>
    <li>response_type: cloud_iam uaa</li>
    <li>apikey: <em>&lt;api-schlüssel&gt;</em></li>
    <li>uaa_client_ID: cf</li>
        <li>uaa_client_secret:</li></ul><strong>Hinweis:</strong> Fügen Sie den Schlüssel <code>uaa_client_secret</code> ohne angegebenen Wert hinzu.</td>
    </tr>
    </tbody>
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

2.  Arbeiten Sie weiter mit der [{{site.data.keyword.containerlong_notm}}-API-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://us-south.containers.bluemix.net/swagger-api), indem Sie das Token aus dem vorherigen Schritt verwenden.
