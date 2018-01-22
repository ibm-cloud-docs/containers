---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Cluster einrichten
{: #cs_cluster}

Konzipieren Sie die Konfiguration Ihres Clusters, um das größtmögliche Maß an Verfügbarkeit und Kapazität zu erzielen.
{:shortdesc}

Das folgende Diagramm zeigt allgemeine Clusterkonfigurationen mit steigender Verfügbarkeit.

![Stufen der Hochverfügbarkeit für einen Cluster](images/cs_cluster_ha_roadmap.png)

Wie im Diagramm dargestellt, führt eine Bereitstellung Ihrer Apps über mehrere Workerknoten hinweg zu einer höheren Verfügbarkeit der Apps. Bei einer Bereitstellung über mehrere Cluster hinweg erhöht sich die Verfügbarkeit der Apps noch mehr. Eine besonders hohe Verfügbarkeit erreichen Sie, wenn Sie Ihre Apps über Cluster in verschiedenen Regionen bereitstellen. [Weitere Details liefern Ihnen die Optionen für hoch verfügbare Clusterkonfigurationen.](cs_planning.html#cs_planning_cluster_config)

<br />


## Cluster über die GUI erstellen
{: #cs_cluster_ui}

Ein Kubernetes-Cluster ist eine Gruppe von Workerknoten, die zu einem Netz zusammengefasst sind. Der Zweck des Clusters besteht darin, eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten zu definieren, die die Hochverfügbarkeit von Anwendungen sicherstellen. Bevor Sie eine App bereitstellen können, müssen Sie zunächst einen Cluster erstellen und die Definitionen für die Workerknoten in diesem Cluster festlegen.
{:shortdesc}

Gehen Sie wie folgt vor, um einen Cluster zu erstellen:
1. Wählen Sie im Katalog die Option **Kubernetes-Cluster** aus.
2. Wählen Sie einen Clusterplantyp aus. Sie können entweder **Lite** oder **Nutzungsabhängig** auswählen. Beim Plan 'Nutzungsabhängig' können Sie einen Standardcluster mit Features wie beispielsweise mehreren Workerknoten für eine hoch verfügbare Umgebung bereitstellen.
3. Konfigurieren Sie die Clusterdetails.
    1. Ordnen Sie dem Cluster einen Namen zu, wählen Sie eine Kubernetes-Version aus und anschließend eine Position für die Bereitstellung aus. Wählen Sie die Position aus, die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Wenn Sie einen Standort außerhalb Ihres Landes auswählen, dann sollten Sie beachten, dass Sie möglicherweise eine gesetzliche Genehmigung benötigen, bevor Daten physisch in einem anderen Land gespeichert werden können.
    2. Wählen Sie einen Maschinentyp aus und geben Sie die Anzahl der Workerknoten an, die Sie benötigen. Der Maschinentyp definiert die Menge an virtueller CPU und Hauptspeicher, die in jedem Workerknoten eingerichtet wird und allen Containern zur Verfügung steht.
        - Der Maschinentyp 'Micro' gibt die kleinste Option an.
        - In einer ausgeglichenen Maschine ist jeder CPU dieselbe Speichermenge zugeordnet. Dadurch wird die Leistung optimiert.
        - Maschinentypen mit `encrypted` im Namen verschlüsseln die Dockerdaten des Hosts. Das Verzeichnis `/var/lib/docker`, in dem alle Containerdaten gespeichert sind, ist mit der LUKS-Verschlüsselung verschlüsselt.
    3. Wählen Sie ein öffentliches und ein privates VLAN über Ihr Konto für IBM Cloud Infrastructure (SoftLayer) aus. Beide VLANs kommunizieren zwischen Workerknoten, das öffentliche VLAN kommuniziert jedoch auch mit dem von IBM verwalteten Kubernetes-Master. Sie können dasselbe VLAN für mehrere Cluster verwenden.
        **Hinweis:** Falls Sie sich gegen die Verwendung eines öffentlichen VLAN entscheiden, müssen Sie eine alternative Lösung konfigurieren.
    4. Wählen Sie einen Hardwaretyp aus. In den meisten Situationen stellt gemeinsam genutzte Hardware eine ausreichende Option dar.
        - **Dediziert**: Vergewissern Sie sich, dass Ihre physischen Ressourcen vollständig isoliert sind.
        - **Gemeinsam genutzt**: Erlaubt die Speicherung Ihrer physische Ressourcen auf derselben Hardware wie für andere IBM Kunden.
        - Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_security.html#cs_security_worker). Wenn Sie die Verschlüsselung inaktivieren möchten, wählen Sie das Kontrollkästchen für die Verschlüsselung der lokalen Platte**** ab. 
4. Klicken Sie auf **Cluster einrichten**. Auf der Registerkarte **Workerknoten** können Sie den Fortschritt der Bereitstellung des Workerknotens überprüfen. Nach Abschluss der Bereitstellung können Sie auf der Registerkarte **Übersicht** sehen, dass Ihr Cluster bereit ist.
    **Hinweis:** Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.


**Womit möchten Sie fortfahren? **

Wenn der Cluster betriebsbereit ist, können Sie sich mit den folgenden Tasks vertraut machen:

-   [Installieren Sie die CLIs und nehmen Sie die Arbeit mit dem Cluster auf. ](cs_cli_install.html#cs_cli_install)
-   [Stellen Sie eine App in Ihrem Cluster bereit. ](cs_apps.html#cs_apps_cli)
-   [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit
anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)
- Wenn Sie eine Firewall haben, müssen Sie unter Umständen [die erforderlichen Ports öffnen](cs_security.html#opening_ports), um die Befehle `bx`, `kubectl` oder `calicotl` zu verwenden, um von Ihrem Cluster ausgehenden Datenverkehr bzw. eingehenden Datenverkehr für Netzservices zuzulassen. 

<br />


## Cluster über die CLI erstellen
{: #cs_cluster_cli}

Ein Cluster ist eine Gruppe von Workerknoten, die zu einem Netz zusammengefasst sind. Der Zweck des Clusters besteht darin, eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten zu definieren, die die Hochverfügbarkeit von Anwendungen sicherstellen. Bevor Sie eine App bereitstellen können, müssen Sie zunächst einen Cluster erstellen und die Definitionen für die Workerknoten in diesem Cluster festlegen.
{:shortdesc}

Gehen Sie wie folgt vor, um einen Cluster zu erstellen:
1.  Installieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI sowie das [{{site.data.keyword.containershort_notm}}-Plug-in](cs_cli_install.html#cs_cli_install).
2.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
    {: pre}

    **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

3. Wenn Sie über mehrere {{site.data.keyword.Bluemix_notm}}-Konten verfügen, dann wählen Sie das Konto aus, unter dem Sie Ihren Kubernetes-Cluster erstellen wollen.

4.  Wenn Sie Kubernetes-Cluster in einer anderen als der zuvor ausgewählten {{site.data.keyword.Bluemix_notm}}-Region erstellen wollen, führen Sie `bx cs region-set` aus. 

6.  Erstellen Sie einen Cluster. 
    1.  Überprüfen Sie, welche Standorte verfügbar sind. Welche Standorte angezeigt werden, hängt von der {{site.data.keyword.containershort_notm}}-Region ab, bei der Sie angemeldet sind.

        ```
        bx cs locations
        ```
        {: pre}

        Ihre CLI-Ausgabe stimmt mit den [Standorten für die Containerregion überein](cs_regions.html#locations).

    2.  Wählen Sie einen Standort aus und prüfen Sie, welche Maschinentypen an diesem Standort verfügbar sind. Der Maschinentyp gibt an, welche virtuellen Rechenressourcen jedem Workerknoten zur Verfügung stehen.

        ```
        bx cs machine-types <standort>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Prüfen Sie, ob in IBM Cloud Infrastructure (SoftLayer) bereits ein öffentliches und ein privates VLAN für dieses Konto vorhanden ist.

        ```
        bx cs vlans <standort>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Falls bereits ein öffentliches oder privates VLAN vorhanden ist, notieren Sie sich die passenden Router. Private VLAN-Router beginnen immer mit `bcr` (Back-End-Router) und öffentliche VLAN-Router immer mit `fcr` (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. In der Beispielausgabe können alle privaten VLANs mit allen öffentlichen VLANs verwendet werden, weil alle Router `02a.dal10` enthalten.

    4.  Führen Sie den Befehl `cluster-create` aus. Sie können zwischen einem Lite-Cluster, der einen Workerknoten mit 2 vCPU und 4 GB Hauptspeicher umfasst, und einem Standardcluster wählen, der so viele Workerknoten enthalten kann, wie Sie in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) auswählen. Wenn Sie einen Standardcluster erstellen, werden die Platten der Workerknoten standardmäßig verschlüsselt, die zugehörige Hardware wird von mehreren IBM Kunden gemeinsam genutzt und es wird nach Nutzungsstunden abgerechnet. </br>Beispiel eines Standardclusters:

        ```
        bx cs cluster-create --location dal10 --public-vlan <id_des_öffentlichen_vlan> --private-vlan <id_des_privaten_vlan> --machine-type u2c.2x4 --workers 3 --name <clustername> --kube-version <major.minor.patch>
        ```
        {: pre}

        Beispiel eines Lite-Clusters:

        ```
        bx cs cluster-create --name mein_cluster
        ```
        {: pre}

        <table>
        <caption>Tabelle 1. Erklärung der Bestandteile des Befehls <code>bx cs cluster-create</code></caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Der Befehl zum Erstellen eines Clusters in Ihrer {{site.data.keyword.Bluemix_notm}}-Organisation.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;standort&gt;</em></code></td>
        <td>Ersetzen Sie <em>&lt;standort&gt;</em> durch die ID des {{site.data.keyword.Bluemix_notm}}-Standorts, an dem Sie Ihren Cluster erstellen möchten. [Verfügbare Standorte](cs_regions.html#locations) sind von der {{site.data.keyword.containershort_notm}}-Region abhängig, bei der Sie angemeldet sind.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;maschinentyp&gt;</em></code></td>
        <td>Wählen Sie bei Erstellung eines Standardclusters den Maschinentyp aus. Der Maschinentyp gibt an, welche virtuellen Rechenressourcen jedem Workerknoten zur Verfügung stehen. Weitere Informationen finden Sie unter [Vergleich von Lite-Clustern und Standardclustern für {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type). Bei Lite-Clustern muss kein Maschinentyp definiert werden.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;id_des_öffentlichen_vlan&gt;</em></code></td>
        <td><ul>
          <li>Bei Lite-Clustern muss kein öffentliches VLAN definiert werden. Ihr Lite-Cluster wird automatisch mit einem öffentlichen VLAN von IBM verbunden.</li>
          <li>Wenn für diesen Standort bereits ein öffentliches VLAN in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) eingerichtet ist, geben Sie bei einem Standardcluster die ID des öffentlichen VLAN ein. Wenn Sie noch nicht über ein öffentliches und ein privates VLAN für Ihr Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containershort_notm}} erstellt automatisch ein öffentliches VLAN für Sie.<br/><br/>
          <strong>Hinweis</strong>: Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;id_des_privaten_vlan&gt;</em></code></td>
        <td><ul><li>Bei Lite-Clustern muss kein privates VLAN definiert werden. Ihr Lite-Cluster wird automatisch mit einem privaten VLAN von IBM verbunden.</li><li>Wenn für diesen Standort bereits ein privates VLAN in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) eingerichtet ist, geben Sie bei einem Standardcluster die ID des privaten VLAN ein. Wenn Sie noch nicht über ein öffentliches und ein privates VLAN für Ihr Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containershort_notm}} erstellt automatisch ein öffentliches VLAN für Sie.<br/><br/><strong>Hinweis</strong>: Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Ersetzen Sie <em>&lt;name&gt;</em> durch den Namen Ihres Clusters.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;anzahl&gt;</em></code></td>
        <td>Die Anzahl der Workerknoten, die im Cluster eingebunden werden sollen. Wird die Option <code>--workers</code> nicht angegeben, wird 1 Workerknoten erstellt.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn nicht anders angegeben, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>bx cs kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_security.html#cs_security_worker). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein. </td>
        </tr>
        </tbody></table>

7.  Prüfen Sie, ob die Erstellung des Clusters angefordert wurde.

    ```
    bx cs clusters
    ```
    {: pre}

    **Hinweis:** Es kann bis zu 15 Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem
Konto eingerichtet und bereitgestellt wird.

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des
Clusters in **deployed** (Bereitgestellt) geändert.

    ```
    Name         ID                                   State      Created          Workers
    mein_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  Überprüfen Sie den Status der Workerknoten.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Bereit** lautet, können Sie auf den Cluster zugreifen.

    **Hinweis:** Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach der Erstellung des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config <clustername_oder_id>
        ```
        {: pre}

        Wenn
der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können,
um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml
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
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml

        ```
        {: screen}

10. Starten Sie Ihr Kubernetes-Dashboard über den Standardport `8001`.
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


**Womit möchten Sie fortfahren? **

-   [Stellen Sie eine App in Ihrem Cluster bereit. ](cs_apps.html#cs_apps_cli)
-   [Verwalten Sie Ihren Cluster über die Befehlszeile `kubectl`. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit
anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)
- Wenn Sie eine Firewall haben, müssen Sie unter Umständen [die erforderlichen Ports öffnen](cs_security.html#opening_ports), um die Befehle `bx`, `kubectl` oder `calicotl` zu verwenden, um von Ihrem Cluster ausgehenden Datenverkehr bzw. eingehenden Datenverkehr für Netzservices zuzulassen. 

<br />


## Private und öffentliche Image-Registrys verwenden
{: #cs_apps_images}

Ein Docker-Image bildet die Grundlage für die Erstellung eines jeden Containers. Ein Image wird auf der Grundlage einer Dockerfile erstellt. Hierbei handelt es sich um eine Datei, die Anweisungen zum Erstellen des Image enthält. Eine Dockerfile referenziert möglicherweise in ihren Anweisungen Buildartefakte, die separat gespeichert sind, z. B. eine App, die Konfiguration der App und ihre Abhängigkeiten. Images werden in der Regel in einer Registry gespeichert, auf die der Zugriff entweder öffentlich (extern) möglich ist (öffentliche Registry) oder aber so eingerichtet ist, dass der Zugriff auf eine kleine Gruppe von Benutzern beschränkt ist (private Registry).
{:shortdesc}

Überprüfen Sie die nachfolgend aufgeführten Optionen, um zu erfahren, wie Sie eine Image-Registry einrichten und wie Sie ein Image aus der Registry verwenden.

-   [Zugriff auf einen Namensbereich in {{site.data.keyword.registryshort_notm}} für die Arbeit mit von IBM bereitgestellten Images und Ihren eigenen privaten Docker-Images](#bx_registry_default).
-   [Zugriff auf öffentliche Images in Docker Hub](#dockerhub).
-   [Zugriff auf private Images, die in anderen privaten Registrys gespeichert sind](#private_registry).

### Zugriff auf einen Namensbereich in {{site.data.keyword.registryshort_notm}} für die Arbeit mit von IBM bereitgestellten Images und Ihren eigenen privaten Docker-Images
{: #bx_registry_default}

Sie können Container aus einem von IBM bereitgestellten öffentlichen Image oder einem privaten Image, das in Ihrem Namensbereich in {{site.data.keyword.registryshort_notm}} gespeichert ist, in Ihrem Cluster bereitstellen.

Vorbemerkungen:

1. [Richten Sie einen Namensbereich in {{site.data.keyword.registryshort_notm}} unter {{site.data.keyword.Bluemix_notm}} Public oder {{site.data.keyword.Bluemix_dedicated_notm}} ein und übertragen Sie Images per Push-Operation an diesen Namensbereich](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Erstellen Sie einen Cluster](#cs_cluster_cli).
3. [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Wenn Sie einen Cluster erstellen, wird automatisch ein nicht ablaufendes Registry-Token für den Cluster erstellt. Mit diesem Token wird Lesezugriff auf alle Namensbereiche autorisiert, die Sie in {{site.data.keyword.registryshort_notm}} einrichten, damit Sie mit von IBM bereitgestellten öffentlichen und Ihren eigenen privaten Docker-Images arbeiten können. Token müssen in einem `imagePullSecret` von Kubernetes gespeichert sein, damit ein Kubernetes-Cluster darauf zugreifen kann, wenn Sie eine containerisierte App bereitstellen. Wenn Ihr Cluster erstellt wird, speichert {{site.data.keyword.containershort_notm}} dieses Token automatisch in einem `imagePullSecret` in Kubernetes. Das `imagePullSecret` wird zum Kubernetes-Standardnamensbereich, der Standardliste von geheimen Schlüsseln im Servicekonto für diesen Namensbereich und dem Namensbereich 'kube-system' hinzugefügt.

**Hinweis:** Bei dieser anfänglichen Konfiguration können Sie Container aus allen Images, die in einem Namensbereich in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verfügbar sind, im **Standardnamensbereich** Ihres Clusters bereitstellen. Wenn Sie einen Container in anderen Namespaces Ihres Clusters bereitstellen möchten oder wenn Sie ein Image verwenden möchten, das in einer {{site.data.keyword.Bluemix_notm}}-Region oder in einem anderen {{site.data.keyword.Bluemix_notm}}-Konto gespeichert ist, müssen Sie [Ihr eigenes 'imagePullSecret' für Ihren Cluster erstellen](#bx_registry_other).

Um einen Container im Standardnamensbereich (**default**) Ihres Clusters bereitzustellen, müssen Sie eine Konfigurationsdatei erstellen.

1.  Erstellen Sie eine Bereitstellungskonfigurationsdatei mit dem Namen `mydeployment.yaml`.
2.  Definieren Sie die Bereitstellung und das Image aus Ihrem Namensbereich, das Sie verwenden möchten, in {{site.data.keyword.registryshort_notm}}.

    Gehen Sie wie folgt vor,
um ein privates Image aus einem Namensbereich in {{site.data.keyword.registryshort_notm}} zu verwenden:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namensbereich>/<mein_image>:<tag>
    ```
    {: codeblock}

    **Tipp:** Führen Sie `bx cr namespace-list` aus, um Ihre Namensbereichsinformationen abzurufen.

3.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Tipp:** Sie können auch eine vorhandene Konfigurationsdatei bereitstellen, z. B. eines der von IBM bereitgestellten öffentlichen Images. In diesem Beispiel wird das Image **ibmliberty** in der Region 'Vereinigte Staaten (Süden)' verwendet.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Images in anderen Kubernetes-Namensbereichen bereitstellen oder auf Images in anderen {{site.data.keyword.Bluemix_notm}}-Regionen und -Kontos zugreifen
{: #bx_registry_other}

Sie können Container in anderen Kubernetes-Namensbereichen bereitstellen oder Images verwenden, die in anderen {{site.data.keyword.Bluemix_notm}}-Regionen oder -Konten gespeichert sind, oder Images, die in {{site.data.keyword.Bluemix_dedicated_notm}} gespeichert sind, indem Sie Ihr eigenes 'imagePullSecret' erstellen.

Vorbemerkungen:

1.  [Richten Sie einen Namensbereich in {{site.data.keyword.registryshort_notm}} unter {{site.data.keyword.Bluemix_notm}} Public oder {{site.data.keyword.Bluemix_dedicated_notm}} ein und übertragen Sie Images per Push-Operation an diesen Namensbereich](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Erstellen Sie einen Cluster](#cs_cluster_cli).
3.  [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Gehen Sie wie folgt vor, um Ihr eigenes 'imagePullSecret' zu erstellen.

**Hinweis:** 'ImagePullSecrets' sind nur für die Namensbereiche gültig, für die sie erstellt wurden. Wiederholen Sie diese Schritte für jeden Namensbereich, in dem Sie Container bereitstellen möchten. Für Images aus [DockerHub](#dockerhub) ist 'ImagePullSecrets' nicht erforderlich.

1.  Falls Sie kein Token haben, [erstellen Sie ein Token für die Registry, auf die Sie zugreifen möchten.](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Listen Sie die Tokens in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto auf.

    ```
    bx cr token-list
    ```
    {: pre}

3.  Notieren Sie sich die Token-ID, die Sie verwenden möchten.
4.  Rufen Sie den Wert für Ihr Token ab. Ersetzen Sie <em>&lt;token-id&gt;</em>
durch die ID des Tokens, das Sie im vorherigen Schritt abgerufen haben.

    ```
    bx cr token-get <token-id>
    ```
    {: pre}

    Ihr Tokenwert wird im Feld **Token** Ihrer CLI-Ausgabe angezeigt.

5.  Erstellen Sie den geheimen Kubernetes-Schlüssel, um Ihre Tokeninformationen zu speichern.

    ```
    kubectl --namespace <kubernetes-namensbereich> create secret docker-registry <name_des_geheimen_schlüssels>  --docker-server=<registry-url> --docker-username=token --docker-password=<tokenwert> --docker-email=<docker-e-mail>
    ```
    {: pre}

    <table>
    <caption>Tabelle 3. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Erforderlich. Der Kubernetes-Namensbereich Ihres Clusters, in dem Sie den geheimen Schlüssel verwenden und Container bereitstellen möchten. Führen Sie <code>kubectl get namespaces</code>, um alle Namensbereiche in Ihrem Cluster aufzulisten.</td>
    </tr>
    <tr>
    <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
    <td>Erforderlich. Der Name, den Sie für Ihr 'imagePullSecret' verwenden möchten.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry-url&gt;</em></code></td>
    <td>Erforderlich. Die URL der Image-Registry, in der Ihr Namensbereich eingerichtet ist.<ul><li>Für Namensbereiche, die in den Regionen 'Vereinigte Staaten (Süden)' und 'Vereinigte Staaten (Osten)' eingerichtet sind: registry.ng.bluemix.net</li><li>Für Namensbereiche, die in der Region 'Großbritannien (Süden)' eingerichtet sind: registry.eu-gb.bluemix.net</li><li>Für Namensbereiche, die in der Region 'Zentraleuropa (Frankfurt)' eingerichtet sind: registry.eu-de.bluemix.net</li><li>Für Namensbereiche, die in der Region 'Australien (Sydney)' eingerichtet sind: registry.au-syd.bluemix.net</li><li>Für Namensbereiche, die in {{site.data.keyword.Bluemix_dedicated_notm}} eingerichtet sind: registry.<em>&lt;dedizierte_domäne&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker-benutzername&gt;</em></code></td>
    <td>Erforderlich. Der Benutzername für die Anmeldung bei Ihrer privaten Registry. Für {{site.data.keyword.registryshort_notm}} wurde als Benutzername <code>token</code> festgelegt.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;tokenwert&gt;</em></code></td>
    <td>Erforderlich. Der Wert des zuvor abgerufenen Registry-Tokens.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-e-mail&gt;</em></code></td>
    <td>Erforderlich. Falls Sie über eine Docker-E-Mail-Adresse verfügen, geben Sie diese ein. Ist dies nicht der Fall, geben Sie eine fiktive E-Mail-Adresse ein, z. B. a@b.c. Die Angabe der E-Mail-Adresse ist obligatorisch, um einen geheimen Kubernetes-Schlüssel zu erstellen, wird aber nach der Erstellung nicht weiter genutzt.</td>
    </tr>
    </tbody></table>

6.  Überprüfen Sie, dass der geheime Schlüssel erfolgreich erstellt wurde. Ersetzen Sie
<em>&lt;kubernetes-namensbereich&gt;</em> durch den Namen des Namensbereichs, in dem Sie das
'imagePullSecret' erstellt haben.

    ```
    kubectl get secrets --namespace <kubernetes-namensbereich>
    ```
    {: pre}

7.  Erstellen Sie einen Pod, der das 'imagePullSecret' referenziert.
    1.  Erstellen Sie eine Podkonfigurationsdatei mit dem Namen `mypod.yaml`.
    2.  Definieren Sie den Pod und das 'imagePullSecret', das Sie für den Zugriff auf die private
{{site.data.keyword.Bluemix_notm}}-Registry verwenden möchten.

        Ein privates Image aus einem Namensbereich:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <podname>
        spec:
          containers:
            - name: <containername>
              image: registry.<region>.bluemix.net/<mein_namensbereich>/<mein_image>:<tag>
          imagePullSecrets:
            - name: <name_des_geheimen_schlüssels>
        ```
        {: codeblock}

        Ein öffentliches {{site.data.keyword.Bluemix_notm}}-Image:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <podname>
        spec:
          containers:
            - name: <containername>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <name_des_geheimen_schlüssels>
        ```
        {: codeblock}

        <table>
        <caption>Tabelle 4. Erklärung der Komponenten der YAML-Datei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;containername&gt;</em></code></td>
        <td>Der Name des Containers, den Sie in Ihrem Cluster bereitstellen möchten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;mein_namensbereich&gt;</em></code></td>
        <td>Der Namensbereich, in dem das Image gespeichert ist. Führen Sie den Befehl `bx cr namespace-list` aus, um die verfügbaren Namensbereiche aufzulisten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;mein_image&gt;</em></code></td>
        <td>Der Name des Images, das Sie verwenden möchten. Führen Sie den Befehl `bx cr image-list` aus, um die verfügbaren Images in einem {{site.data.keyword.Bluemix_notm}} aufzulisten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>Die Version des Images, das Sie verwenden möchten. Ist kein Tag angegeben, wird standardmäßig das Image mit dem Tag <strong>latest</strong> verwendet.</td>
        </tr>
        <tr>
        <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
        <td>Der Name des 'imagePullSecret', das Sie zuvor erstellt haben.</td>
        </tr>
        </tbody></table>

   3.  Speichern Sie Ihre Änderungen.
   4.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


### Zugriff auf öffentliche Images in Docker Hub
{: #dockerhub}

Sie können jedes beliebige öffentliche Image verwenden, das in Docker Hub gespeichert ist, um ohne zusätzliche Konfigurationsschritte einen Container in Ihrem Cluster bereitzustellen.

Vorbemerkungen:

1.  [Erstellen Sie einen Cluster](#cs_cluster_cli).
2.  [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Erstellen Sie eine Bereitstellungskonfigurationsdatei.

1.  Erstellen Sie eine Konfigurationsdatei mit dem Namen `mydeployment.yaml`.
2.  Definieren Sie die Bereitstellung und das gewünschte öffentliche Image aus Docker Hub. Die folgende Konfigurationsdatei verwendet das öffentliche NGINX-Image, das in Docker Hub verfügbar ist.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Tipp:** Stellen Sie alternativ eine vorhandene Konfigurationsdatei bereit. Im folgenden Beispiel wird dasselbe öffentliche NGINX-Image verwendet, aber direkt auf Ihren Cluster angewendet.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### Zugriff auf private Images, die in anderen privaten Registrys gespeichert sind
{: #private_registry}

Wenn bereits eine private Registry vorhanden ist und Sie diese verwenden wollen, müssen Sie die Berechtigungsnachweise für die Registry in einem 'imagePullSecret' von Kubernetes
speichern und diesen geheimen Schlüssel in Ihrer Konfigurationsdatei referenzieren.

Vorbemerkungen:

1.  [Erstellen Sie einen Cluster](#cs_cluster_cli).
2.  [Richten Sie Ihre CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

Gehen Sie wie folgt vor, um ein 'imagePullSecret' zu erstellen:

**Hinweis:** 'ImagePullSecrets' sind für die Namensbereiche gültig, für die sie erstellt wurden. Wiederholen Sie diese Schritte für jeden Namensbereich, in dem Sie Container aus einem Image in einer privaten {{site.data.keyword.Bluemix_notm}}-Registry bereitstellen möchten.

1.  Erstellen Sie den geheimen Kubernetes-Schlüssel, um Ihre Berechtigungsnachweise für die private Registry zu speichern.

    ```
    kubectl --namespace <kubernetes-namensbereich> create secret docker-registry <name_des_geheimen_schlüssels>  --docker-server=<registry-url> --docker-username=<docker-benutzername> --docker-password=<docker-kennwort> --docker-email=<docker-e-mail>
    ```
    {: pre}

    <table>
    <caption>Tabelle 5. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Erforderlich. Der Kubernetes-Namensbereich Ihres Clusters, in dem Sie den geheimen Schlüssel verwenden und Container bereitstellen möchten. Führen Sie <code>kubectl get namespaces</code>, um alle Namensbereiche in Ihrem Cluster aufzulisten.</td>
    </tr>
    <tr>
    <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
    <td>Erforderlich. Der Name, den Sie für Ihr 'imagePullSecret' verwenden möchten.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry-url&gt;</em></code></td>
    <td>Erforderlich. Die URL der Registry, in der Ihre privaten Images gespeichert sind.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker-benutzername&gt;</em></code></td>
    <td>Erforderlich. Der Benutzername für die Anmeldung bei Ihrer privaten Registry.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;tokenwert&gt;</em></code></td>
    <td>Erforderlich. Der Wert des zuvor abgerufenen Registry-Tokens.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-e-mail&gt;</em></code></td>
    <td>Erforderlich. Falls Sie über eine Docker-E-Mail-Adresse verfügen, geben Sie diese ein. Ist dies nicht der Fall, geben Sie eine fiktive E-Mail-Adresse ein, z. B. a@b.c. Die Angabe der E-Mail-Adresse ist obligatorisch, um einen geheimen Kubernetes-Schlüssel zu erstellen, wird aber nach der Erstellung nicht weiter genutzt.</td>
    </tr>
    </tbody></table>

2.  Überprüfen Sie, dass der geheime Schlüssel erfolgreich erstellt wurde. Ersetzen Sie
<em>&lt;kubernetes-namensbereich&gt;</em> durch den Namen des Namensbereichs, in dem Sie das
'imagePullSecret' erstellt haben.

    ```
    kubectl get secrets --namespace <kubernetes-namensbereich>
    ```
    {: pre}

3.  Erstellen Sie einen Pod, der das 'imagePullSecret' referenziert.
    1.  Erstellen Sie eine Podkonfigurationsdatei mit dem Namen `mypod.yaml`.
    2.  Definieren Sie den Pod und das 'imagePullSecret', das Sie für den Zugriff auf die private
{{site.data.keyword.Bluemix_notm}}-Registry verwenden möchten. Gehen Sie wie folgt vor, um ein privates Image aus Ihrer privaten Registry zu verwenden:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <podname>
        spec:
          containers:
            - name: <containername>
              image: <mein_image>:<tag>
          imagePullSecrets:
            - name: <name_des_geheimen_schlüssels>
        ```
        {: codeblock}

        <table>
        <caption>Tabelle 6. Erklärung der Komponenten der YAML-Datei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;podname&gt;</em></code></td>
        <td>Der Name des Pod, den Sie erstellen möchten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;containername&gt;</em></code></td>
        <td>Der Name des Containers, den Sie in Ihrem Cluster bereitstellen möchten.</td>
        </tr>
        <tr>
        <td><code><em>&lt;mein_image&gt;</em></code></td>
        <td>Der vollständige Pfad des gewünschten Images in Ihrer privaten Registry.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>Die Version des Images, das Sie verwenden möchten. Ist kein Tag angegeben, wird standardmäßig das Image mit dem Tag <strong>latest</strong> verwendet.</td>
        </tr>
        <tr>
        <td><code><em>&lt;name_des_geheimen_schlüssels&gt;</em></code></td>
        <td>Der Name des 'imagePullSecret', das Sie zuvor erstellt haben.</td>
        </tr>
        </tbody></table>

  3.  Speichern Sie Ihre Änderungen.
  4.  Erstellen Sie die Bereitstellung in Ihrem Cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## {{site.data.keyword.Bluemix_notm}}-Services
zu Clustern hinzufügen
{: #cs_cluster_service}

Sie können eine vorhandene {{site.data.keyword.Bluemix_notm}}-Serviceinstanz
zu Ihrem Cluster hinzufügen, um den Benutzern Ihres Clusters den Zugriff auf den
{{site.data.keyword.Bluemix_notm}}-Service
sowie seine Verwendung zu ermöglichen, wenn sie eine App auf dem Cluster bereitstellen.
{:shortdesc}

Vorbemerkungen:

1. [Richten Sie Ihre CLI
](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.
2. [Fordern Sie eine Instanz des {{site.data.keyword.Bluemix_notm}}-Service](/docs/manageapps/reqnsi.html#req_instance) an.
   **Hinweis:** Zur Erstellung einer Instanz eines Service am Standort 'Washington DC' müssen Sie die CLI verwenden.

**Hinweis:**
<ul><ul>
<li>Es können nur {{site.data.keyword.Bluemix_notm}}-Services
hinzugefügt werden, die Serviceschlüssel unterstützen. Wenn der Service keine Serviceschlüssel unterstützt, dann sollten Sie die Informationen zum Thema [Externen Apps die Verwendung von {{site.data.keyword.Bluemix_notm}}-Services ermöglichen](/docs/manageapps/reqnsi.html#req_instance) lesen.</li>
<li>Der Cluster und die Workerknoten müssen vollständig bereitgestellt werden, bevor Sie einen Service hinzufügen können.</li>
</ul></ul>


Gehen Sie wie folgt vor, um einen Service hinzuzufügen:
2.  Listen Sie verfügbare {{site.data.keyword.Bluemix_notm}}-Services auf.

    ```
    bx service list
    ```
    {: pre}

    CLI-Beispielausgabe:

    ```
    name                      service           plan    bound apps   last operation
    <serviceinstanzname>   <servicename>    spark                create succeeded
    ```
    {: screen}

3.  Notieren Sie unter **name** den Namen der Serviceinstanz, die Sie zu Ihrem Cluster hinzufügen wollen.
4.  Geben Sie den Clusternamensbereich an, den Sie verwenden wollen, um Ihren Service hinzuzufügen. Wählen Sie eine der folgenden Optionen aus.
    -   Lassen Sie eine Liste der vorhandenen Namensbereiche anzeigen und wählen Sie einen Namensbereich aus, den Sie verwenden wollen.

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   Erstellen Sie einen neuen Namensbereich in Ihrem Cluster.

        ```
        kubectl create namespace <name_des_namensbereichs>
        ```
        {: pre}

5.  Fügen Sie den Service zu Ihrem Cluster hinzu.

    ```
    bx cs cluster-service-bind <clustername_oder_id> <namensbereich> <serviceinstanzname>
    ```
    {: pre}

    Wenn der Service erfolgreich zu Ihrem Cluster hinzugefügt worden ist, wird ein geheimer Schlüssel für den Cluster erstellt, der die Berechtigungsnachweise Ihrer Serviceinstanz enthält. CLI-Beispielausgabe:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<serviceinstanzname>
    ```
    {: screen}

6.  Stellen Sie sicher, dass der geheime Schlüssel im Namensbereich Ihres Clusters erstellt wurde.

    ```
    kubectl get secrets --namespace=<namensbereich>
    ```
    {: pre}


Um den Service in einem Pod zu verwenden, der im Cluster bereitgestellt ist, können Clusterbenutzer auf die Serviceberechtigungsnachweise des {{site.data.keyword.Bluemix_notm}}-Service zugreifen, indem sie [den geheimen Kubernetes-Schlüssel als Datenträger für geheime Schlüssel an einen Pod anhängen](cs_apps.html#cs_apps_service).

<br />



## Clusterzugriff verwalten
{: #cs_cluster_user}

Jedem Benutzer, der mit {{site.data.keyword.containershort_notm}} arbeitet, muss eine Kombination von servicespezifischen Benutzerrollen zugewiesen sein, deren Aktionen der Benutzer ausführen kann.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien</dt>
<dd>In IAM (Identity and Access Management) bestimmen {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien die Cluster-Management-Aktionen, die Sie in einem Cluster ausführen können, z. B. das Erstellen oder Entfernen von Clustern und das Hinzufügen oder Entfernen von zusätzlichen Workerknoten. Diese Richtlinien müssen in Verbindung mit Infrastrukturrichtlinien gesetzt werden. </dd>
<dt>Infrastrukturzugriffsrichtlinien</dt>
<dd>In IAM (Identity and Access Management) ermöglichen Infrastrukturzugriffsrichtlinien, dass die Aktionen, die von der {{site.data.keyword.containershort_notm}}-Benutzerschnittstelle oder -Befehlszeilenschnittstelle angefordert werden, in IBM Cloud Infrastructure (SoftLayer) abgeschlossen werden. Diese Richtlinien müssen in Verbindung mit {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien gesetzt werden. [Weitere Informationen zu den verfügbaren Infrastrukturrollen](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Ressourcengruppen</dt>
<dd>Mit einer Ressourcengruppe können {{site.data.keyword.Bluemix_notm}}-Services in Gruppierungen organisiert werden, sodass Benutzern schnell Zugriff auf mehr als eine Ressource gleichzeitig zugewiesen werden kann. [Erfahren Sie, wie Sie Benutzer anhand von Ressourcengruppen verwalten können](/docs/admin/resourcegroups.html#rgs). </dd>
<dt>Cloud Foundry-Rollen</dt>
<dd>In IAM (Identity and Access Management) muss jedem Benutzer eine Cloud Foundry-Benutzerrolle zugewiesen sein. Diese Rolle bestimmt, welche Aktionen der Benutzer für das {{site.data.keyword.Bluemix_notm}}-Konto ausführen kann, z. B. andere Benutzer einladen oder die Kontingentnutzung anzeigen. [Weitere Informationen zu den verfügbaren Cloud Foundry-Rollen](/docs/iam/cfaccess.html#cfaccess). </dd>
<dt>Kubernetes-RBAC-Rollen</dt>
<dd>Jedem Benutzer, dem eine {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinie zugeordnet ist, ist automatisch auch eine Kubernetes-RBAC-Rolle zugeordnet. In Kubernetes bestimmen RBAC-Rollen, welche Aktionen Sie für Kubernetes-Ressourcen innerhalb eines Clusters ausführen können. RBAC-Rollen werden nur für die Standardnamensbereiche eingerichtet. Der Clusteradministrator kann RBAC-Rollen für andere Namensbereiche im Cluster hinzufügen. Weitere Informationen finden Sie im Kapitel zur [Verwendung von RBAC-Autorisierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) in der Kubernetes-Dokumentation. </dd>
</dl>

In diesem Abschnitt finden Sie folgende Informationen: 

-   [Zugriffsrichtlinien und -berechtigungen](#access_ov)
-   [Benutzer zum {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen](#add_users)
-   [Infrastrukturberechtigungen für einen Benutzer anpassen](#infrastructure_permissions)

### Zugriffsrichtlinien und -berechtigungen
{: #access_ov}

Überprüfen Sie die Zugriffsrichtlinien und die Berechtigungen, die Sie Benutzern in Ihrem {{site.data.keyword.Bluemix_notm}}-Konto erteilen können. Der Rolle des Operators und des Bearbeiters sind unterschiedliche Berechtigungen zugewiesen. Wenn ein Benutzer Workerknoten hinzufügen und Services binden soll, müssen Sie ihm sowohl die Operator- als auch die Bearbeiterrolle zuordnen.

|{{site.data.keyword.containershort_notm}}-Zugriffsrichtlinie|Cluster-Management-Berechtigungen|Kubernetes-Ressourcenberechtigungen|
|-------------|------------------------------|-------------------------------|
|Administrator|Diese Rolle erbt die Berechtigungen von den Rollen 'Editor (Bearbeiter)', 'Bediener (Operator)' und 'Viewer (Anzeigeberechtigter)' für alle Cluster in diesem Konto. <br/><br/>Bei Festlegung für alle aktuellen Serviceinstanzen:<ul><li>Erstellen eines Lite-Clusters oder Standardclusters</li><li>Festlegen von Berechtigungsnachweisen für ein {{site.data.keyword.Bluemix_notm}}-Konto, um auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) zuzugreifen</li><li>Entfernen eines Clusters</li><li>Zuordnen und Ändern von {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien für andere vorhandene Benutzer in diesem Konto</li></ul><p>Bei Festlegung für eine bestimmte Cluster-ID: <ul><li>Entfernen eines bestimmten Clusters</li></ul></p>Entsprechende Infrastrukturzugriffsrichtlinie: Superuser<br/><br/><b>Hinweis</b>: Zum Erstellen von Ressourcen wie Maschinen, VLANs und Teilnetze benötigen Benutzer die Infrastrukturrolle **Superuser**. |<ul><li>RBAC-Rolle: cluster-admin</li><li>Schreib-/Lesezugriff auf Ressourcen in allen Namensbereichen</li><li>Erstellen von Rollen innerhalb eines Namensbereichs</li><li>Zugriff auf das Kubernetes-Dashboard</li><li>Erstellen einer Ingress-Ressource zur öffentlichen Bereitstellung von Apps</li></ul>|
|Operator|<ul><li>Hinzufügen zusätzlicher Workerknoten zu einem Cluster</li><li>Entfernen von Workerknoten aus einem Cluster</li><li>Neustarten eines Workerknotens</li><li>Neuladen eines Workerknotens</li><li>Hinzufügen eines Teilnetzes zu einem Cluster</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Basisbenutzer</p>|<ul><li>RBAC-Rolle: admin</li><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen, aber nicht auf den Namensbereich selbst</li><li>Erstellen von Rollen innerhalb eines Namensbereichs</li></ul>|
|Editor <br/><br/><b>Tipp</b>: Verwenden Sie diese Rolle für App-Entwickler. |<ul><li>Binden eines {{site.data.keyword.Bluemix_notm}}-Service an einen Cluster</li><li>Auflösen einer Bindung eines {{site.data.keyword.Bluemix_notm}}-Service an einen Cluster</li><li>Erstellen eines Web-Hook</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Basisbenutzer|<ul><li>RBAC-Rolle: edit</li><li>Schreib-/Lesezugriff auf Ressourcen innerhalb von Standardnamensbereichen</li></ul></p>|
|Viewer |<ul><li>Auflisten eines Clusters</li><li>Anzeigen von Details für einen Cluster</li></ul><p>Entsprechende Infrastrukturzugriffsrichtlinie: Nur anzeigen</p>|<ul><li>RBAC-Rolle: view</li><li>Lesezugriff auf Ressourcen innerhalb des Standardnamensbereichs</li><li>Kein Lesezugriff auf geheime Kubernetes-Schlüssel</li></ul>|
{: caption="Tabelle 7. {{site.data.keyword.containershort_notm}}-Zugriffsrichtlinien und -berechtigungen" caption-side="top"}

|Cloud Foundry-Zugriffsrichtlinie|Kontoverwaltungsberechtigungen|
|-------------|------------------------------|
|Organisationsrolle: Manager|<ul><li>Hinzufügen zusätzlicher Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto</li></ul>| |
|Bereichsrolle: Entwickler|<ul><li>Erstellen von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen</li><li>Binden von {{site.data.keyword.Bluemix_notm}}-Serviceinstanzen an Cluster</li></ul>| 
{: caption="Tabelle 8. Cloud Foundry-Zugriffsrichtlinien und -berechtigungen" caption-side="top"}


### Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen
{: #add_users}

Sie können zusätzliche Benutzer zu einem {{site.data.keyword.Bluemix_notm}}-Konto hinzufügen, um ihnen Zugriff auf Ihren Cluster zu gewähren.

Zunächst müssen Sie sicherstellen, dass Ihnen die Cloud Foundry-Rolle 'Manager' für ein {{site.data.keyword.Bluemix_notm}}-Konto zugeordnet wurde.

1.  [Fügen Sie den Benutzer zum Konto hinzu](../iam/iamuserinv.html#iamuserinv).
2.  Erweitern Sie im Abschnitt **Zugriff** den Eintrag **Services**.
3.  Weisen Sie eine {{site.data.keyword.containershort_notm}}-Zugriffsrolle zu. Wählen Sie in der Dropdown-Liste **Zugriff zuweisen zu** aus, ob Sie Zugriff nur Ihrem {{site.data.keyword.containershort_notm}}-Konto (**Ressource**) oder einer Reihe verschiedener Ressourcen in Ihrem Konto (**Ressourcengruppe**) gewähren möchten.
  -  Für **Ressource**:
      1. Wählen Sie in der Dropdown-Liste **Services** den Eintrag **{{site.data.keyword.containershort_notm}}** aus.
      2. Wählen Sie aus der Dropdown-Liste **Region** die Region aus, der der Benutzer angehören soll.
      3. Wählen Sie aus der Dropdown-Liste **Serviceinstanz** den Cluster aus, dem der Benutzer angehören soll. Führen Sie `bx cs clusters` aus, um die ID eines bestimmten Clusters zu finden.
      4. Wählen Sie im Abschnitt **Rollen auswählen** eine Rolle aus. Eine Liste von unterstützten Aktionen pro Rolle finden Sie unter [Zugriffsrichtlinien und -berechtigungen](#access_ov). 
  - Für **Ressourcengruppe**:
      1. Wählen Sie aus der Dropdown-Liste **Ressourcengruppe** die Ressourcengruppe aus, die Berechtigungen für die {{site.data.keyword.containershort_notm}}-Ressource Ihres Kontos enthält.
      2. Wählen Sie aus der Dropdown-Liste **Zugriff für eine Ressourcengruppe zuweisen** zu einer Ressourcengruppe eine Rolle aus. Eine Liste von unterstützten Aktionen pro Rolle finden Sie unter [Zugriffsrichtlinien und -berechtigungen](#access_ov). 
4. [Optional: Weisen Sie eine Infrastrukturrolle zu](/docs/iam/mnginfra.html#managing-infrastructure-access). 
5. [Optional: Weisen Sie eine Cloud Foundry-Rolle zu](/docs/iam/mngcf.html#mngcf).
5. Klicken Sie auf **Benutzer einladen**.



### Infrastrukturberechtigungen für einen Benutzer anpassen
{: #infrastructure_permissions}

Wenn Sie Infrastrukturrichtlinien in IAM (Identity and Access Management) konfigurieren, werden einem Benutzer mit einer Rolle verknüpfte Berechtigungen zugewiesen. Um diese Berechtigungen anzupassen, müssen Sie sich bei IBM Cloud Infrastructure (SoftLayer) anmelden und die Berechtigungen dort anpassen.
{: #view_access}

Basisbenutzer können beispielsweise einen Workerknoten neu starten, ihn aber nicht neu laden. Ohne diesen Benutzern Superuser-Berechtigungen zuzuweisen, können Sie die IBM Cloud Infrastructure (SoftLayer)-Berechtigungen anpassen und die Berechtigung zum Ausführen eines Neuladen-Befehls hinzufügen. 

1.  Melden Sie sich bei Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) an.
2.  Wählen Sie ein Benutzerprofil aus, das aktualisiert werden soll. 
3.  Passen Sie unter **Portalberechtigungen** den Zugriff des Benutzers an. Um beispielsweise eine Neuladen-Berechtigung hinzuzufügen, wählen Sie auf der Registerkarte **Devices** die Option **Issue OS Reloads and Initiate Rescue Kernel** aus. 
9.  Speichern Sie Ihre Änderungen.

<br />



## Kubernetes-Master aktualisieren
{: #cs_cluster_update}

Kubernetes aktualisiert in regelmäßigen Abständen [Haupt-, Neben und Patchversionen](cs_versions.html#version_types), was Auswirkungen auf die Cluster hat. Die Aktualisierung eines Clusters ist ein aus zwei Schritten bestehender Prozess. Im ersten Schritt müssen Sie den Kubernetes-Master aktualisieren und dann können Sie die verschiedenen Workerknoten aktualisieren.

Standardmäßig ist für einen Kubernetes-Master eine Aktualisierung über mehr als zwei Nebenversionen hinweg nicht möglich. Wenn die aktuelle Masterversion beispielsweise 1.5 ist und Sie eine Aktualisierung auf 1.8 durchführen möchten, müssen Sie zunächst auf Version 1.7 aktualisieren. Sie können die gewünschte Aktualisierung zwar erzwingen, jedoch kann eine Aktualisierung über mehr als zwei Nebenversionen hinweg zu nicht erwarteten Ergebnissen führen.

**Achtung**: Befolgen Sie die Aktualisierungsanweisungen und verwenden Sie einen Testcluster, um potenziellen App-Ausfällen oder Unterbrechungen während der Aktualisierung entgegenzuwirken. Für einen Cluster kann kein Rollback auf eine Vorgängerversion durchgeführt werden.

Bei der Durchführung einer Aktualisierung für eine _Hauptversion_ oder _Nebenversion_ müssen Sie die folgenden Schritte ausführen.

1. Überprüfen Sie die [Kubernetes-Änderungen](cs_versions.html) und führen Sie alle Aktualisierungen durch, die mit der Markierung _Vor Master aktualisieren_ gekennzeichnet sind.
2. Aktualisieren Sie den Kubernetes-Master über die GUI oder durch Ausführung des [CLI-Befehls](cs_cli_reference.html#cs_cluster_update). Wenn Sie den Kubernetes-Master aktualisieren, dann wird der Master für ca. 5 - 10 Minuten inaktiviert. Während der Aktualisierung kann weder auf den Cluster zugegriffen noch können Änderungen am Cluster vorgenommen werden. Allerdings werden Workerknoten, Apps und Ressourcen, die von Clusterbenutzern bereitgestellt wurden, nicht geändert und weiterhin ausgeführt.
3. Vergewissern Sie sich, dass die Aktualisierung abgeschlossen wurde. Überprüfen Sie die Kubernetes-Version im {{site.data.keyword.Bluemix_notm}}-Dashboard oder führen Sie den Befehl `bx cs clusters` aus.

Wenn die Aktualisierung des Kubernetes-Masters abgeschlossen ist, können Sie Ihre Workerknoten aktualisieren.

<br />


## Workerknoten aktualisieren
{: #cs_cluster_worker_update}

Während IBM Patches für den Kubernetes-Master automatisch anwendet, müssen Sie Workerknoten explizit für Haupt- und Nebenversionen aktualisieren. Die Workerknotenversion darf nicht höher sein als die des Kubernetes-Masters.

**Achtung**: Die Aktualisierung von Workerknoten kann zu Ausfallzeiten bei Ihren Apps und Services führen.
- Die Daten werden gelöscht, wenn sie nicht außerhalb des Pods gespeichert werden.
- Verwenden Sie [Replikate ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) in Ihren Bereitstellungen, um die erneute Zeitplanung für Pods auf den verfügbaren Knoten zu ermöglichen.

Cluster im Produktionsbetrieb aktualisieren:
- Um Ausfallzeiten für Ihre Apps zu vermeiden, wird beim Aktualisierungsprozess verhindert, dass Pods auf dem Workerknoten geplant werden. Weitere Informationen finden Sie im Abschnitt zu [`kubectl drain` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain).
- Verwenden Sie einen Testcluster, um zu überprüfen, ob Ihre Arbeitslast und der Bereitstellungsprozess von der Aktualisierung beeinflusst werden. Für Workerknoten kann kein Rollback auf eine Vorgängerversion durchgeführt werden.
- Cluster im Produktionsbetrieb müssen über die erforderlichen Kapazitäten verfügen, um bei Ausfall eines Workerknotens weiterhin funktionsfähig zu bleiben. Wenn dies für Ihren Cluster nicht möglich ist, dann fügen Sie einen Workerknoten hinzu, bevor Sie den Cluster aktualisieren.
- Wenn für mehrere Workerknoten eine Aktualisierung erforderlich ist, wird eine rollierende Aktualisierung durchgeführt. Von der Gesamtanzahl von Workerknoten in einem Cluster können maximal 20 Prozent gleichzeitig aktualisiert werden. Dabei wird immer gewartet, dass der Aktualisierungsvorgang für einen Workerknoten abgeschlossen wurde, bevor der nächste Workerknoten aktualisiert wird.


1. Installieren Sie die Version der [`CLI für kubectl` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/tools/install-kubectl/), die der Kubernetes-Version des Kubernetes-Masters entspricht.

2. Führen Sie alle Änderungen durch, die mit der Markierung _Nach Master aktualisieren_ in [Kubernetes-Änderungen](cs_versions.html) versehen sind.

3. Aktualisieren Sie Ihre Workerknoten:
  * Zur Aktualisierung über das {{site.data.keyword.Bluemix_notm}}-Dashboard navigieren Sie zum Abschnitt für die `Workerknoten` Ihres Clusters und klicken dann auf `Worker aktualisieren`.
  * Zum Abrufen von Workerknoten-IDs müssen Sie den Befehl `bx cs workers <cluster_name_or_id>` ausführen. Wenn Sie mehrere Workerknoten auswählen, werden die Workerknoten nacheinander aktualisiert.

    ```
    bx cs worker-update <clustername_oder_id> <workerknoten_id1> <workerknoten_id2>
    ```
    {: pre}

4. Vergewissern Sie sich, dass die Aktualisierung abgeschlossen wurde:
  * Überprüfen Sie die Kubernetes-Version im {{site.data.keyword.Bluemix_notm}}-Dashboard oder führen Sie den Befehl `bx cs workers <cluster_name_or_id>` aus.
  * Überprüfen Sie die Kubernetes-Version der Workerknoten, indem Sie den Befehl `kubectl get nodes` ausführen.
  * In bestimmten Fällen werden in älteren Clustern nach einer Aktualisierung doppelte Workerknoten mit dem Status **NotReady** (Nicht bereit) aufgelistet. Informationen zum Entfernen doppelter Workerknoten finden Sie im Abschnitt zur [Fehlerbehebung](cs_troubleshoot.html#cs_duplicate_nodes).

Führen Sie nach dem Abschluss der Aktualisierung die folgenden Aktionen durch:
  - Wiederholen Sie den Aktualisierungsprozess für andere Cluster.
  - Informieren Sie die Entwickler, die im Cluster arbeiten, damit diese ihre `kubectl`-CLI auf die Version des Kubernetes-Masters aktualisieren können.
  - Wenn im Kubernetes-Dashboard keine Nutzungsdiagramme angezeigt werden, [löschen Sie den Pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).

<br />


## Clustern Teilnetze hinzufügen
{: #cs_cluster_subnet}

Ändern Sie den Pool der verfügbaren portierbaren öffentlichen oder privaten IP-Adressen, indem Sie Ihrem Cluster Teilnetze hinzufügen.
{:shortdesc}

Sie können in {{site.data.keyword.containershort_notm}} stabile, portierbare IPs für Kubernetes-Services hinzufügen, indem Sie dem Cluster Teilnetze hinzufügen. In diesem Fall werden Teilnetze nicht mit Netzmasken verwendet, um Konnektivität zwischen mehreren Clustern zu erstellen. Stattdessen werden Teilnetze eingesetzt, um unveränderliche IPs für einen Service aus einem Cluster bereitzustellen, über die auf den Service zugegriffen werden kann. 

Wenn Sie einen Standardcluster erstellen, stellt {{site.data.keyword.containershort_notm}} automatisch ein portierbares öffentliches Teilnetz mit 5 öffentlichen IP-Adressen und ein portierbares privates Teilnetz mit 5 privaten IP-Adressen bereit. Portierbare öffentliche und private IP-Adressen sind statisch und ändern sich nicht, wenn ein Workerknoten oder sogar der Cluster entfernt wird. Pro Teilnetz wird eine der portierbaren öffentlichen und eine der portierbaren privaten IP-Adressen für [Lastausgleichsfunktionen für Anwendungen](cs_apps.html#cs_apps_public_ingress) verwendet, mit denen Sie mehrere Apps in Ihrem Cluster zugänglich machen können. Die vier verbleibenden portierbaren öffentlichen und vier portierbaren privaten IP-Adressen können verwendet werden, um einzelne Apps für die Öffentlichkeit verfügbar zu machen, indem Sie einen [Lastausgleichsservice erstellen](cs_apps.html#cs_apps_public_load_balancer). 

**Hinweis:** Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Clusters beschließen, portierbare öffentliche IP-Adressen zu entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur über einen kurzen Zeitraum genutzt haben.

### Zusätzliche Teilnetze für Ihren Cluster anfordern
{: #add_subnet}

Sie können stabile portierbare öffentliche oder private IP-Adressen zum Cluster hinzufügen, wenn Sie dem Cluster Teilnetze zuordnen.

**Hinweis:** Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um ein Teilnetz in einem IBM Cloud Infrastructure (SoftLayer)-Konto zu erstellen und in einem bestimmten Cluster verfügbar zu machen: 

1. Stellen Sie ein neues Teilnetz bereit. 

    ```
    bx cs cluster-subnet-create <clustername_oder_id> <teilnetzgröße> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>Tabelle 8. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>Der Befehl zum Bereitstellen eines Teilnetzes für Ihren Cluster. </td>
    </tr>
    <tr>
    <td><code><em>&lt;clustername_oder_id&gt;</em></code></td>
    <td>Ersetzen Sie <code>&gt;clustername_oder_id&lt;</code> durch den Namen oder die ID des Clusters. </td>
    </tr>
    <tr>
    <td><code><em>&lt;teilnetzgröße&gt;</em></code></td>
    <td>Ersetzen Sie <code>&gt;teilnetzgröße&lt;</code> durch die Anzahl von IP-Adressen, die Sie aus Ihrem portierbaren Teilnetz hinzufügen möchten. Gültige Werte sind 8, 16, 32 oder 64. <p>**Hinweis:** Wenn Sie portierbare IP-Adressen für Ihr Teilnetz hinzufügen, werden drei IP-Adressen verwendet, um clusterinterne Netze einzurichten, und stehen folglich nicht für Ihre Lastausgleichsfunktionen für Anwendungen oder für das Erstellen eines Lastausgleichsservice bereit. Wenn Sie beispielsweise acht portierbare öffentliche IP-Adressen anfordern, können Sie fünf verwenden, um die Apps öffentlich verfügbar zu machen.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Ersetzen Sie <code>&gt;VLAN_ID&lt;</code> durch die ID des öffentlichen oder privaten VLANs, in dem Sie die portierbaren öffentlichen oder privaten IP-Adressen zuweisen möchten. Sie müssen das öffentliche oder private VLAN auswählen, mit dem ein vorhandener Workerknoten verbunden ist. Führen Sie den Befehl <code>bx cs worker-get &gt;worker-id&lt;</code> aus, um das öffentliche oder private VLAN für einen Workerknoten zu überprüfen.</td>
    </tr>
    </tbody></table>

2.  Überprüfen Sie, ob das Teilnetz erfolgreich erstellt und zu Ihrem Cluster hinzugefügt wurde. Das Teilnetz-CIDR wird im Abschnitt **VLANs** aufgelistet.

    ```
    bx cs cluster-get --showResources <clustername_oder_id>
    ```
    {: pre}

### Kubernetes-Clustern angepasste und bestehende Teilnetze hinzufügen
{: #custom_subnet}

Sie können Ihren Kubernetes-Clustern vorhandene portierbare öffentliche oder private Teilnetze hinzufügen.

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

Wenn Sie ein Teilnetz in Ihrem Portfolio von IBM Cloud Infrastructure (SoftLayer) mit angepassten Firewallregeln oder verfügbaren IP-Adressen haben, das Sie verwenden möchten, erstellen Sie einen Cluster ohne Teilnetz. Stellen Sie dann das vorhandene Teilnetz dem Cluster zur Verfügung, wenn der Cluster bereitgestellt wird.

1.  Geben Sie das Teilnetz an, das Sie verwenden möchten. Beachten Sie die ID des Teilnetzes und die VLAN-ID. In diesem Beispiel lautet die Teilnetz-ID '807861' und die VLAN-ID '1901230'.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Bestätigen Sie die Position, an der sich das VLAN befindet. In diesem Beispiel lautet die Position 'dal10'.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Erstellen Sie einen Cluster mithilfe der Position und der VLAN-ID, die Sie angegeben haben. Schließen Sie das Flag `--no-subnet` ein, um zu vermeiden, dass ein neues portierbares öffentliches und ein neues portierbares privates IP-Teilnetz automatisch erstellt wird.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name mein_cluster
    ```
    {: pre}

4.  Prüfen Sie, ob die Erstellung des Clusters angefordert wurde.

    ```
    bx cs clusters
    ```
    {: pre}

    **Hinweis:** Es kann bis zu 15 Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem
Konto eingerichtet und bereitgestellt wird.

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des
Clusters in **deployed** (Bereitgestellt) geändert.

    ```
    Name         ID                                   State      Created          Workers
    mein_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Überprüfen Sie den Status der Workerknoten.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Bereit** lautet, können Sie auf den Cluster zugreifen.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Fügen Sie Ihrem Cluster das Teilnetz hinzu, indem Sie die Teilnetz-ID angeben. Wenn Sie ein Teilnetz für einen Cluster verfügbar machen, wird eine Kubernetes-Konfigurationsübersicht für Sie erstellt, die alle verfügbaren portierbaren öffentlichen IP-Adressen enthält, die Sie verwenden können. Wenn für Ihr Cluster noch keine Lastausgleichsfunktionen für Anwendungen vorhanden sind, werden eine portierbare öffentliche und eine portierbare private IP-Adresse automatisch verwendet, um die öffentlichen und privaten Lastausgleichsfunktionen für Anwendungen zu erstellen. Alle anderen portierbaren öffentlichen und privaten IP-Adressen können zum Erstellen von Lastenausgleichsservices für die Apps verwendet werden.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Vom Benutzer verwaltete Teilnetze und IP-Adressen zu Kubernetes-Clustern hinzufügen
{: #user_subnet}

Stellen Sie ein eigenes Teilnetz aus einem lokalen Netz zur Verfügung, auf das über {{site.data.keyword.containershort_notm}} zugegriffen werden soll. Anschließend können Sie private IP-Adressen aus diesem Teilnetz zu den Lastenausgleichsservices im Kubernetes-Cluster hinzufügen.

Voraussetzungen:
- Vom Benutzer verwaltete Teilnetze können nur zu privaten VLANs hinzugefügt werden.
- Die Begrenzung für die Länge des Teilnetzpräfix beträgt /24 bis /30. Beispiel: `203.0.113.0/24` gibt 253 verwendbare private IP-Adressen an, während `203.0.113.0/30` 1 verwendbare private IP-Adresse angibt.
- Die erste IP-Adresse im Teilnetz muss als Gateway für das Teilnetz verwendet werden.

Vorab müssen Sie das Routing des Netzverkehrs in das externe bzw. aus dem externen Teilnetz konfigurieren. Darüber hinaus müssen Sie sicherstellen, dass Sie über VPN-Konnektivität zwischen der Gateway-Einheit des lokalen Rechenzentrums und der Vyatta-Einheit des privaten Netzes im Portfolio von IBM Cloud Infrastructure (SoftLayer) verfügen. Weitere Informationen hierzu finden Sie in diesem [Blogbeitrag ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

1. Zeigen Sie die ID des privaten VLAN Ihres Clusters an. Suchen Sie den Abschnitt **VLANs**. Geben Sie im Feld für die Verwaltung durch den Benutzer die VLAN-ID mit _false_ an.

    ```
    bx cs cluster-get --showResources <clustername>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Fügen Sie das externe Teilnetz zu Ihrem privaten VLAN hinzu. Die portierbaren privaten IP-Adressen werden zur Konfigurationsübersicht des Clusters hinzugefügt.

    ```
    bx cs cluster-user-subnet-add <clustername> <teilnetz_CIDR> <VLAN-ID>
    ```
    {: pre}

    Beispiel:

    ```
    bx cs cluster-user-subnet-add mein_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Überprüfen Sie, ob das vom Benutzer bereitgestellte Teilnetz hinzugefügt wurde. Das Feld für die Verwaltung durch den Benutzer ist auf _true_ gesetzt.

    ```
    bx cs cluster-get --showResources <clustername>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Fügen Sie einen privaten Lastausgleichsservice oder eine private Ingress-Lastausgleichsfunktion für Anwendungen hinzu, um über das private Netz auf Ihre App zuzugreifen. Wenn Sie eine private IP-Adresse aus dem Teilnetz verwenden möchten, die Sie hinzugefügt haben, als Sie eine private Lastausgleichsfunktion bzw. eine private Ingress-Lastausgleichsfunktion für Anwendungen erstellt haben, müssen Sie eine IP-Adresse angeben. Andernfalls wird eine IP-Adresse nach dem Zufallsprinzip aus den Teilnetzen von IBM Cloud Infrastructure (SoftLayer) oder aus den vom Benutzer bereitgestellten Teilnetzen im privaten VLAN ausgewählt. Weitere Informationen finden Sie unter [Zugriff auf eine App durch Verwenden des Servicetyps 'LoadBalancer' konfigurieren](cs_apps.html#cs_apps_public_load_balancer) oder unter [Private Lastausgleichsfunktion für Anwendungen aktivieren](cs_apps.html#private_ingress). 

<br />


## Vorhandene NFS-Dateifreigaben in Clustern verwenden
{: #cs_cluster_volume_create}

Wenn bereits NFS-Dateifreigaben in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) vorhanden sind, die Sie mit Kubernetes verwenden möchten, können Sie das tun, indem Sie Persistent Volumes in Ihrer vorhandenen NFS-Dateifreigabe erstellen. Ein Persistent Volume ist eine Hardwarekomponente, die als Kubernetes-Clusterressource dient und von dem Clusterbenutzer verarbeitet werden kann.
{:shortdesc}

Kubernetes unterscheidet zwischen Persistent Volumes, die tatsächliche Hardware darstellen, und Persistent Volume Claims, bei denen es sich um Speicheranforderungen handelt, die üblicherweise vom Clusterbenutzer initiiert werden. Das folgende Diagramm veranschaulicht die Beziehung zwischen Persistent Volumes und Persistent Volume Claims (PVCs).

![Erstellen von Persistent Volumes und Persistent Volume Claims](images/cs_cluster_pv_pvc.png)

 Wenn Sie, wie im Diagramm dargestellt, die Verwendung vorhandener NFS-Dateifreigaben mit Kubernetes ermöglichen möchten, müssen Sie Persistent Volumes mit einer bestimmten Größe und einem bestimmten Zugriffsmodus erstellen und dann einen Persistent Volume Claim erstellen, der mit der Angabe des Persistent Volume übereinstimmt. Wenn Persistent Volume und Persistent Volume Claim übereinstimmen, werden sie aneinander gebunden. Vom Clusterbenutzer können nur gebundene Persistent Volume Claims verwendet werden, um den Datenträger an eine Bereitstellung anzuhängen. Dieser Prozess wird als statische Bereitstellung von persistentem Speicher bezeichnet.

Stellen Sie zunächst sicher, dass Sie über eine NFS-Dateifreigabe verfügen, die Sie zum Erstellen Ihres Persistent Volume verwenden können.

**Hinweis:** Eine statische Bereitstellung von persistentem Speicher gilt nur für vorhandene NFS-Dateifreigaben. Wenn keine NFS-Dateifreigaben vorhanden sind, können Clusterbenutzer den Prozess der [dynamischen Bereitstellung](cs_apps.html#cs_apps_volume_claim) nutzen, um Persistent Volumes hinzuzufügen.

Führen Sie die folgenden Schritte aus, um ein Persistent Volume und einen passenden Persistent Volume Claim zu erstellen.

1.  Suchen Sie in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) die ID und den Pfad der NFS-Dateifreigabe, in der Sie Ihr Persistent Volume-Objekt erstellen möchten. Autorisieren Sie darüber hinaus den Dateispeicher für die Teilnetze im Cluster. Diese Autorisierung erteilt Ihrem Cluster Zugriff auf den Speicher. 
    1.  Melden Sie sich bei Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) an.
    2.  Klicken Sie auf **Speicher**.
    3.  Klicken Sie auf **Dateispeicher** und wählen Sie im Menü **Aktionen** die Option zum Autorisieren des Hosts**** aus. 
    4.  Klicken Sie auf **Teilnetze**. Nach der Autorisierung hat jeder Workerknoten im Teilnetz Zugriff auf den Dateispeicher. 
    5.  Wählen Sie das Teilnetz des öffentlichen VLANs Ihres Clusters im Menü aus und klicken Sie auf **Abschicken**. Wenn Sie das Teilnetz suchen müssen, führen Sie `bx cs cluster-get <clustername> --showResources` aus. 
    6.  Klicken Sie auf den Namen des Dateispeichers. 
    7.  Notieren Sie sich den Inhalt des Felds **Mountpunkt**. Das Feld hat dieses Format: `<server>:/<path>`.
2.  Erstellen Sie eine Speicherkonfigurationsdatei für Ihr Persistent Volume. Schließen Sie die im Feld **Mountpunkt** des Dateispeichers angegebenen Server und Pfad ein. 

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Tabelle 9. Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Geben Sie den Namen des Persistent Volume-Objekts ein, das Sie erstellen möchten.</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>Geben Sie die Speichergröße der vorhandenen NFS Dateifreigabe ein. Die Größe des Speichers muss in Gigabyte angegeben werden, z. B. 20Gi (20 GB) oder 1000Gi (1 TB), und sie muss mit der Größe der vorhandenen Dateifreigabe übereinstimmen.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Der Zugriffsmodus definiert, auf welche Art ein Persistent Volume Claim (PVC) an einen Workerknoten angehängt werden kann.<ul><li>ReadWriteOnce (RWO): Das Persistent Volume kann nur an die Bereitstellungen in einem einzigen Workerknoten angehängt werden. Die an dieses Persistent Volume angehängten Container können auf diesen Datenträger schreiben und ihn lesen. </li><li>ReadOnlyMany (ROX): Das Persistent Volume kann an Bereitstellungen angehängt werden, die auf verschiedenen Workerknoten gehostet sind. Die an dieses Persistent Volume angehängten Bereitstellungen können den Datenträger nur lesen. </li><li>ReadWriteMany (RWX): Dieses Persistent Volume kann an Bereitstellungen angehängt werden, die auf verschiedenen Workerknoten gehostet sind. Bereitstellungen, die an dieses Persistent Volume angehängt werden, können den Datenträger lesen und ihn beschreiben. </li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Geben Sie die Server-ID der NFS-Dateifreigabe ein.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Geben Sie den Pfad der NFS-Dateifreigabe ein, in dem Sie das Persistent Volume-Objekt erstellen möchten.</td>
    </tr>
    </tbody></table>

3.  Erstellen Sie das Persistent Volume-Objekt in Ihrem Cluster.

    ```
    kubectl apply -f <yaml-pfad>
    ```
    {: pre}

    Beispiel

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Überprüfen Sie, dass das Persistent Volume erstellt wurde.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Erstellen Sie eine weitere Konfigurationsdatei, um Ihren Persistent Volume Claim zu erstellen. Damit der Persistent Volume Claim mit dem zuvor erstellten Persistent Volume-Objekt übereinstimmt, müssen Sie denselben Wert für `storage` und `accessMode` auswählen. Das Feld `storage-class` muss leer sein. Wenn eines dieser Felder nicht mit dem Persistent Volume übereinstimmt, wird stattdessen automatisch ein neues Persistent Volume erstellt.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  Erstellen Sie Ihren Persistent Volume Claim.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Überprüfen Sie, dass Ihr Persistent Volume Claim erstellt und an das Persistent Volume-Objekt gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Die Ausgabe ähnelt der folgenden.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <keine>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Sie haben erfolgreich ein Persistent Volume-Objekt erstellt und an einen Persistent Volume Claim gebunden. Clusterbenutzer können jetzt den [Persistent Volume Claim an ihre Bereitstellungen anhängen](cs_apps.html#cs_apps_volume_mount) und mit dem Lesen und Schreiben in dem Persistent Volume-Objekt beginnen. 

<br />


## Clusterprotokollierung konfigurieren
{: #cs_logging}

Protokolle dienen zur Fehlerbehebung von Problemen mit Ihren Clustern und Apps. In einigen Situationen möchten Sie möglicherweise Protokolle für die Verarbeitung oder Langzeitspeicherung an eine bestimmte Position senden. In einem Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} können Sie die Protokollweiterleitung für Ihren Cluster aktivieren und auswählen, wohin die Protokolle weitergeleitet werden sollen. **Hinweis**: Die Protokollweiterleitung wird nur für Standardcluster unterstützt.
{:shortdesc}

Sie können Protokolle für andere Protokollquellen, wie Container, Anwendungen, Workerknoten, Kubernetes-Cluster und Ingress-Controller, weiterleiten.
Nachfolgend finden Sie eine Tabelle mit den entsprechenden Informationen zu jeder Protokollquelle. 

|Protokollquelle|Merkmale|Protokollpfade|
|----------|---------------|-----|
|`Container`|Protokolle für Ihren Container, der in einem Kubernetes-Cluster ausgeführt wird.|-|
|`application`|Protokolle für Ihre eigene Anwendung, die in einem Kubernetes-Cluster ausgeführt wird.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Protokolle für Workerknoten für virtuelle Maschinen in einem Kubernetes-Cluster.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Protokolle für die Kubernetes-Systemkomponente.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Protokolle für eine Lastausgleichsfunktion für Anwendungen, die vom Ingress-Controller verwaltet wird, der den aus einem Kubernetes-Cluster kommenden Datenverkehr verwaltet.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Tabelle 9. Merkmale von Protokollquellen" caption-side="top"}

### Protokollweiterleitung aktivieren
{: #cs_log_sources_enable}

Sie können Protokolle an {{site.data.keyword.loganalysislong_notm}} oder einen externen Systemprotokollserver weiterleiten. Wenn Sie Protokolle aus einer Protokollquelle an beide Protokollcollector-Server weiterleiten möchten, müssen Sie zwei Protokollierungskonfigurationen erstellen.
**Hinweis**: Weitere Informationen zum Weiterleiten von Protokollen für Anwendungen finden Sie unter [Protokollweiterleitung für Anwendungen aktivieren](#cs_apps_enable).
{:shortdesc}

Vorbemerkungen:

1. Wenn Sie Protokolle an einen externen Systemprotokollserver weiterleiten möchten, haben Sie zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.
  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in einem Kubernetes-Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts.

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

Gehen Sie wie folgt vor, um Protokollweiterleitung für einen Container, einen Workerknoten, eine Kubernetes-Systemkomponente, eine Anwendung oder eine Ingress-Lastausgleichsfunktion für Anwendungen zu aktivieren: 

1. Erstellen Sie eine Konfiguration für die Protokollweiterleitung.

  * Für die Protokollweiterleitung an {{site.data.keyword.loganalysislong_notm}}:

    ```
    bx cs logging-config-create <mein_cluster> --logsource <meine_protokollquelle> --namespace <kubernetes-namensbereich> --hostname <einpflege-URL> --port <einpflegeport> --spaceName <clusterbereich> --orgName <clusterorganisation> --type ibm
    ```
    {: pre}

    <table>
    <caption>Tabelle 10. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Der Befehl zum Erstellen einer {{site.data.keyword.loganalysislong_notm}}-Protokollweiterleitungskonfiguration. </td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;meine_protokollquelle&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;meine_protokollquelle&gt;</em> durch die Protokollquelle. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>. </td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;kubernetes-namensbereich&gt;</em> durch den Namensbereich des Docker-Containers, von dem Sie Protokolle weiterleiten möchten. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Containerprotokollquelle gültig und optional. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Container diese Konfiguration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;einpflege-URL&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;einpflege-URL&gt;</em> durch die {{site.data.keyword.loganalysisshort_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;einpflegeport&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;einpflegeport&gt;</em> durch den Einpflegeport. Wenn Sie keinen Port angeben, wird der Standardport <code>9091</code> verwendet. </td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;clusterbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterbereich&gt;</em> durch den Namen des Bereichs, an den Sie Protokolle senden möchten. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet. </td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;clusterorganisation&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterorganisation&gt;</em> durch den Namen der Organisation, in der sich der Bereich befindet. Dieser Wert ist erforderlich, wenn Sie einen Bereich angegeben haben. </td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>Der Protokolltyp für das Senden von Protokollen an {{site.data.keyword.loganalysisshort_notm}}. </td>
    </tr>
    </tbody></table>

  * Für die Protokollweiterleitung an einen externen Systemprotokollserver:

    ```
    bx cs logging-config-create <mein_cluster> --logsource <meine_protokollquelle> --namespace <kubernetes-namensbereich> --hostname <hostname_oder_ip_des_protokollservers> --port <protokollserver-port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabelle 11. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Der Befehl zum Erstellen einer syslog-Protokollweiterleitungskonfiguration. </td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;meine_protokollquelle&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;meine_protokollquelle&gt;</em> durch die Protokollquelle. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>. </td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes-namensbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;kubernetes-namensbereich&gt;</em> durch den Namensbereich des Docker-Containers, von dem Sie Protokolle weiterleiten möchten. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Containerprotokollquelle gültig und optional. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Container diese Konfiguration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;hostname_oder_ip_des_protokollservers&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollserver-hostname&gt;</em> durch den Hostnamen oder die IP-Adresse des Protokollcollector-Service. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;protokollserver-port&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollserver-port&gt;</em> durch den Port des Protokollcollector-Servers. Wenn Sie keinen Port angeben, dann wird der Standardport <code>514</code> verwendet.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Der Protokolltyp zum Senden von Protokollen an einen externen Systemprotokollserver. </td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, ob die Protokollweiterleitungskonfiguration erstellt wurde.

    * Gehen Sie wie folgt vor, um alle Protokollierungskonfigurationen im Cluster aufzulisten:
      ```
      bx cs logging-config-get <mein_cluster>
      ```
      {: pre}

      Beispielausgabe:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   meine_org   mein_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   mein_namensbereich  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Gehen Sie wie folgt vor, um Protokollierungskonfigurationen für einen Protokollquellentyp aufzulisten:
      ```
      bx cs logging-config-get <mein_cluster> --logsource worker
      ```
      {: pre}

      Beispielausgabe:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### Protokollweiterleitung für Anwendungen aktivieren
{: #cs_apps_enable}

Protokolle von Anwendungen müssen auf ein bestimmtes Verzeichnis auf dem Hostknoten beschränkt sein. Dazu hängen Sie einen Datenträger mit Hostpfaden mithilfe eines Mountpfads per Mountoperation an Ihre Container an. Dieser Mountpfad dient als Verzeichnis in Ihren Containern, an das die Anwendungsprotokolle gesendet werden. Das vordefinierte Hostpfadverzeichnis `/var/log/apps` wird automatisch beim Generieren des Datenträgermounts erstellt.

Nachfolgend finden Sie noch einmal die wichtigsten Aspekte der Protokollweiterleitung für Anwendungen:
* Protokolle werden rekursiv aus dem Pfad '/var/log/apps' gelesen. Dies bedeutet, dass Sie Anwendungsprotokolle in Unterverzeichnissen des Pfads '/var/log/apps' ablegen können.
* Nur Anwendungsprotokolldateien mit der Erweiterung `.log` oder `.err` werden weitergeleitet.
* Wenn Sie die Protokollweiterleitung zum ersten Mal aktivieren, werden für Anwendungsprotokolle 'tail'-Aufrufe durchgeführt, anstatt dass sie aus dem Kopfsatz ausgelesen werden. Dies bedeutet, dass die Inhalte von Protokollen, die bereits vor der Aktivierung der Anwendungsprotokolle vorhanden sind, nicht gelesen werden. Die Protokolle werden ab dem Zeitpunkt der Aktivierung der Protokollierung gelesen. Nach der erstmaligen Aktivierung der Protokollweiterleitung werden Protokolle jedoch immer von der Stelle ab weiterverarbeitet, an der sie zuletzt verarbeitet wurden.
* Wenn Sie den Datenträger für den Hostpfad `/var/log/apps` per Mountoperation an Container anhängen, schreiben die Container alle in dasselbe Verzeichnis. Dies bedeutet, dass, wenn die Container ihre Schreiboperationen alle an denselben Dateinamen richten, die Container in exakt dieselbe Datei auf dem Host schreiben. Wenn Sie dies nicht möchten, können Sie verhindern, dass die Container dieselbe Protokolldatei überschreiben, indem Sie den Protokolldateien von den einzelnen Containern unterschiedliche Namen geben.
* Da alle Container an denselben Dateinamen schreiben, verwenden Sie diese Methode nicht zum Weiterleiten von Anwendungsprotokollen für Replikatgruppen. Stattdessen können Sie Protokolle von der Anwendung in STDOUT und STDERR schreiben, die als Containerprotokolle erfasst werden. Um Anwendungsprotokolle, die in STDOUT und STDERR geschrieben wurden, weiterzuleiten, führen Sie die Schritte im Abschnitt [Protokollweiterleitung ans Systemprotokoll aktivieren](cs_cluster.html#cs_log_sources_enable) aus. 

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

1. Öffnen Sie die Konfigurationsdatei mit der Erweiterung `.yaml` für den Pod der Anwendung.

2. Fügen Sie der Konfigurationsdatei die folgenden Angaben für `volumeMounts` und `volumes` hinzu:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod-name>
    containers:
    - name: fluentd
      image: "<ihr_registry-image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Hängen Sie den Datenträger über eine Mountoperation an den Pod an.

    ```
    kubectl apply -f <lokaler_yaml-pfad>
    ```
    {:pre}

3. Zum Erstellen einer Protokollweiterleitungskonfiguration führen Sie die Schritte im Abschnitt [Protokollweiterleitung aktivieren](cs_cluster.html#cs_log_sources_enable) aus. 

### Protokollweiterleitungskonfiguration aktualisieren
{: #cs_log_sources_update}

Sie können Protokollweiterleitung für einen Container, eine Anwendung, einen Workerknoten, eine Kubernetes-Systemkomponente oder eine Ingress-Lastausgleichsfunktion für Anwendungen aktualisieren.
{: shortdesc}

Vorbemerkungen:

1. Wenn Sie den Protokollcollector-Server in einen Systemprotokollserver (syslog) ändern, haben Sie zwei Möglichkeiten, einen Server einzurichten, der ein Systemprotokoll empfangen kann:
  * Richten Sie einen eigenen Server ein und verwalten Sie diesen oder lassen Sie diese Aufgaben von einem Provider durchführen. Wenn ein Provider den Server für Sie verwaltet, dann rufen Sie den Protokollierungsendpunkt vom Protokollierungsprovider ab.
  * Führen Sie das Systemprotokoll über einen Container aus. Sie können beispielsweise diese [YAML-Datei für die Bereitstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) verwenden, um ein öffentliches Docker-Image abzurufen, das zur Ausführung eines Containers in einem Kubernetes-Cluster dient. Das Image veröffentlicht den Port `514` auf der öffentlichen Cluster-IP-Adresse und verwendet diese öffentliche Cluster-IP-Adresse zum Konfigurieren des Systemprotokollhosts.

2. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

Gehen Sie wie folgt vor, um die Details der Protokollierungskonfiguration zu ändern: 

1. Aktualisieren Sie die Protokollierungskonfiguration.

    ```
    bx cs logging-config-update <mein_cluster> <protokollkonfiguration-id> --logsource <meine_protokollquelle> --hostname <hostname_oder_IP_des_protokollservers> --port <protokollserver-port> --spaceName <clusterbereich> --orgName <clusterorganisation> --type <protokollierungstyp>
    ```
    {: pre}

    <table>
    <caption>Tabelle 12. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Der Befehl zum Aktualisieren der Protokollweiterleitungskonfiguration für Ihre Protokollquelle.</td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code><em>&lt;protokollkonfiguration-id&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollkonfiguration-id&gt;</em> durch die ID der Protokollquellenkonfiguration. </td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;meine_protokollquelle&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;meine_protokollquelle&gt;</em> durch die Protokollquelle. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>. </td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;hostname_oder_ip_des_protokollservers&gt;</em></code></td>
    <td>Wenn der Protokollierungstyp <code>syslog</code> lautet, ersetzen Sie <em>&lt;hostname_oder_IP des protokollservers&gt;</em> durch den Hostnamen oder die IP-Adresse des Protokollcollector-Service. Wenn der Protokollierungstyp <code>ibm</code> lautet, ersetzen Sie <em>&lt;protokollserver-hostname&gt;</em> durch die {{site.data.keyword.loganalysislong_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;protokollserver-port&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;protokollserver-port&gt;</em> durch den Port des Protokollcollector-Servers. Wenn Sie keinen Port angeben, wird der Standardport <code>514</code> für <code>syslog</code> und <code>9091</code> für <code>ibm</code> verwendet. </td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;clusterbereich&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterbereich&gt;</em> durch den Namen des Bereichs, an den Sie Protokolle senden möchten. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und optional. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet. </td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;clusterorganisation&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;clusterorganisation&gt;</em> durch den Namen der Organisation, in der sich der Bereich befindet. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und erforderlich, wenn Sie einen Bereich angegeben haben. </td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;protokollierungstyp&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;rotokollierungstyp&gt;</em> durch das neue Protokollweiterleitungsprotokoll, das Sie verwenden möchten. Momentan werden <code>syslog</code> und <code>ibm</code> unterstützt.</td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, ob die Protokollweiterleitungskonfiguration aktualisiert wurde.

    * Gehen Sie wie folgt vor, um alle Protokollierungskonfigurationen im Cluster aufzulisten:

      ```
      bx cs logging-config-get <mein_cluster>
      ```
      {: pre}

      Beispielausgabe:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   meine_org   mein_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   mein_namensbereich  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Gehen Sie wie folgt vor, um Protokollierungskonfigurationen für einen Protokollquellentyp aufzulisten:

      ```
      bx cs logging-config-get <mein_cluster> --logsource worker
      ```
      {: pre}

      Beispielausgabe:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

### Protokollweiterleitung stoppen
{: #cs_log_sources_delete}

Sie können die Weiterleitung von Protokollen stoppen, indem Sie die Protokollierungskonfiguration löschen.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem sich die Protokollquelle befindet.

1. Löschen Sie die Protokollierungskonfiguration.

    ```
    bx cs logging-config-rm <mein_cluster> <protokollkonfiguration-id>
    ```
    {: pre}
    Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen des Clusters, in dem sich die Protokollierungskonfiguration befindet, und <em>&lt;protokollkonfiguration-id&gt;</em> durch die ID der Protokollquellenkonfiguration.

### Protokollweiterleitung für Kubernetes-API-Auditprotokolle konfigurieren
{: #cs_configure_api_audit_logs}

Kubernetes-API-Auditprotokolle erfassen alle Aufrufe an den Kubernetes-API-Server von Ihrem Cluster. Starten Sie das Erfassen von Kubernetes-API-Auditprotokollen, indem Sie den Kubernetes-API-Server für die Einrichtung eines Webhook-Back-Ends für Ihren Cluster konfigurieren. Dieses Webhook-Back-End ermöglicht, dass Protokolle an einen fernen Server gesendet werden. Weitere Informationen zu Kubernetes-Auditprotokollen finden Sie im Thema zu <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">Audits <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> in der Kubernetes-Dokumentation. 

**Hinweis**:
* Die Weiterleitung für Kubernetes-API-Auditprotokolle wird nur in Kubernetes Version 1.7 und höher unterstützt. 
* Aktuell wird eine Standardauditrichtlinie für alle Cluster mit dieser Protokollierungskonfiguration verwendet. 

#### Kubernetes-API-Auditprotokollweiterleitung aktivieren
{: #cs_audit_enable}

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem Sie API-Serverauditprotokolle erfassen möchten. 

1. Legen Sie das Webhook-Back-End für die API-Serverkonfiguration fest. Eine Webhook-Konfiguration wird auf der Grundlage der Informationen erstellt, die Sie in den Flags dieses Befehls bereitstellen. Wenn Sie keine Informationen in den Flags bereitstellen, wird eine Standard-Webhook-Konfiguration verwendet. 

    ```
    bx cs apiserver-config-set audit-webhook <mein_cluster> --remoteServer <server-URL_oder_IP> --caCert <pfad_des_zertifizierungsstellenzertifikats> --clientCert <pfad_des_clientzertifikats> --clientKey <pfad_des_clientschlüssels>
    ```
    {: pre}

    <table>
    <caption>Tabelle 13. Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>Der Befehl zum Festlegen einer Option für die Kubernetes-API-Serverkonfiguration des Clusters. </td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>Der Unterbefehl zum Festlegen der Webhook-Auditkonfiguration für den Kubernetes-API-Server des Clusters. </td>
    </tr>
    <tr>
    <td><code><em>&lt;mein_cluster&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;mein_cluster&gt;</em> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server-URL_oder_IP&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;server-URL_oder_IP&gt;</em> durch die URL oder IP-Adresse für den fernen Protokollierungsservice, an den Sie Protokolle senden möchten. Wenn Sie eine unsichere Server-URL eingeben, werden alle Zertifikate ignoriert. Wenn Sie keine ferne Server-URL oder -IP-Adresse angeben, wird eine QRadar-Standardkonfiguration verwendet und die Protokolle werden an die QRadar-Instanz für die Region gesendet, in der sich der Cluster befindet. </td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;pfad_des_zertifizierungsstellenzertifikats&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;pfad_des_zertifizierungsstellenzertifikats&gt;</em> durch den Pfadnamen für das Zertifizierungsstellenzertifikat, das zum Überprüfen des fernen Protokollierungsservice verwendet wird. </td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;pfad_des_clientzertifikats&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;pfad_des_clientzertifikats&gt;</em> durch den Dateipfad für das Clientzertifikat, das zur Authentifizierung beim fernen Protokollierungsservice verwendet wird. </td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;pfad_des_clientschlüssels&gt;</em></code></td>
    <td>Ersetzen Sie <em>&lt;pfad_des_clientschlüssels&gt;</em> durch den Dateipfad für den entsprechenden Clientschlüssel, der zum Verbinden mit dem fernen Protokollierungsservice verwendet wird. </td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, dass die Protokollweiterleitung aktiviert war, indem Sie die URL für den fernen Protokollierungsservice anzeigen. 

    ```
    bx cs apiserver-config-get audit-webhook <mein_cluster>
    ```
    {: pre}

    Beispielausgabe:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Wenden Sie die Konfigurationsaktualisierung an, indem Sie den Kubernetes-Master erneut starten. 

    ```
    bx cs apiserver-refresh <mein_cluster>
    ```
    {: pre}

#### Kubernetes-API-Auditprotokollweiterleitung stoppen
{: #cs_audit_delete}

Sie können das Weiterleiten von Auditprotokollen stoppen, indem Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters inaktivieren. 

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem Sie die Erfassung von API-Serverauditprotokollen stoppen möchten. 

1. Inaktivieren Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters. 

    ```
    bx cs apiserver-config-unset audit-webhook <mein_cluster>
    ```
    {: pre}

2. Wenden Sie die Konfigurationsaktualisierung an, indem Sie den Kubernetes-Master erneut starten. 

    ```
    bx cs apiserver-refresh <mein_cluster>
    ```
    {: pre}

### Protokolle anzeigen
{: #cs_view_logs}

Zum Anzeigen von Protokollen für Cluster und Container können Sie die Standardprotokollierungsfunktionen von Kubernetes und Docker verwenden.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

Für Standardcluster befinden sich die Protokolle in dem {{site.data.keyword.Bluemix_notm}}-Konto, bei dem Sie angemeldet waren, als der Kubernetes-Cluster erstellt wurde. Wenn Sie beim Erstellen des Clusters oder der Protokollierungskonfiguration einen {{site.data.keyword.Bluemix_notm}}-Bereich angegeben haben, befinden sich die Protokolle in diesem Bereich. Protokolle werden außerhalb des Containers überwacht und weitergeleitet. Sie können über das Kibana-Dashboard auf Protokolle für einen Container zugreifen. Weitere Informationen zur Protokollierung finden Sie unter [Protokollierung für {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes). 

**Hinweis**: Wenn Sie beim Erstellen des Clusters oder der Protokollierungskonfiguration einen Bereich angegeben haben, muss der Kontobesitzer für diesen Bereich über die Berechtigungen eines Managers, Entwicklers oder Prüfers verfügen, um Protokolle anzuzeigen. Informationen zum Ändern der Zugriffsrichtlinien und Berechtigungen für {{site.data.keyword.containershort_notm}} finden Sie in [Clusterzugriff verwalten](cs_cluster.html#cs_cluster_user). Sobald Berechtigungen geändert wurden, kann es bis zu 24 Stunden dauern, bis die entsprechenden Protokolle angezeigt werden.

Zum Zugriff auf das Kibana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.
- Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://logging.ng.bluemix.net
- Großbritannien (Süden) und Zentraleuropa: https://logging.eu-fra.bluemix.net
- Asiatisch-pazifischer Raum (Süden): https://logging.au-syd.bluemix.net

Weitere Informationen zum Anzeigen von Protokollen finden Sie im Abschnitt zum [Navigieren zu Kibana über einen Web-Browser](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

#### Docker-Protokolle
{: #cs_view_logs_docker}

Sie können die in Docker integrierten Protokollierungsfunktion nutzen, um Aktivitäten in den Standardausgabedatenströmen STDOUT und STDERR zu prüfen. Weitere Informationen finden Sie unter [Container-Protokolle für einen Container anzeigen, der in einem Kubernetes-Cluster ausgeführt wird](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Clusterüberwachung konfigurieren
{: #cs_monitoring}

Mit Metriken können Sie den Zustand und die Leistung Ihrer Cluster überwachen. Sie können die Zustandsüberwachung für Workerknoten so konfigurieren, dass Worker automatisch erkannt und korrigiert werden, die einen verminderten oder nicht betriebsbereiten Status aufweisen. **Hinweis**: Die Überwachung wird nur für Standardcluster unterstützt.
{:shortdesc}

### Metriken anzeigen
{: #cs_view_metrics}

Sie können die Standardfeatures von Kubernetes und Docker verwenden, um den Zustand Ihrer Cluster und Apps zu überwachen.
{:shortdesc}

<dl>
<dt>Seite mit Clusterdetails in {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} stellt Information zum Zustand und zur Kapazität Ihres Clusters sowie zur Nutzung Ihrer Clusterressourcen bereit. Über diese grafische Benutzerschnittstelle (GUI) können Sie Ihren Cluster horizontal skalieren, mit dem persistenten Speicher arbeiten und weitere Funktionalität durch Binden von {{site.data.keyword.Bluemix_notm}}-Services zu Ihrem Cluster hinzufügen. Um die Seite mit Clusterdetails anzuzeigen, wählen Sie im **{{site.data.keyword.Bluemix_notm}}-Dashboard** einen Cluster aus.</dd>
<dt>Kubernetes-Dashboard</dt>
<dd>Das Kubernetes-Dashboard ist eine Webschnittstelle für die Verwaltung, über die Sie den Zustand Ihrer Workerknoten überprüfen, Kubernetes-Ressourcen suchen, containerisierte Apps bereitstellen und Fehler bei Apps auf der Grundlage von Protokollierungs- und Überwachungsdaten suchen und beheben können. Weitere Informationen dazu, wie Sie auf das Kubernetes-Dashboard zugreifen, finden Sie unter [Kubernetes-Dashboard für {{site.data.keyword.containershort_notm}} starten](cs_apps.html#cs_cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>Metriken für Standardcluster befinden sich in dem {{site.data.keyword.Bluemix_notm}}-Konto, das angemeldet war, als der Kubernetes-Cluster erstellt wurde. Wenn Sie beim Erstellen des Clusters einen {{site.data.keyword.Bluemix_notm}}-Bereich angegeben haben, befinden sich die Metriken in diesem Bereich. Containermetriken werden automatisch für alle Container erfasst, die in einem Cluster bereitgestellt werden. Diese Metriken werden durch Grafana gesendet und verfügbar gemacht. Weitere Informationen zu Metriken finden Sie unter [Überwachung für {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Zum Zugriff auf das Grafana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto oder den entsprechenden Bereich auswählen, in dem Sie den Cluster erstellt haben.<ul><li>Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://metrics.ng.bluemix.net</li><li>Großbritannien (Süden): https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### Weitere Zustandsüberwachungstools
{: #cs_health_tools}

Sie können weitere Tools für zusätzliche Überwachungsfunktionen konfigurieren.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus ist ein Open-Source-Tool für die Überwachung, Protokollierung und Benachrichtigung bei Alerts, das für Kubernetes entwickelt wurde. Das Tool ruft auf Grundlage der Kubernetes-Protokollierungsinformationen detaillierte Informationen zu Cluster, Workerknoten und Bereitstellungszustand ab. Weitere Informationen zur Einrichtung finden Sie unter [Services mit {{site.data.keyword.containershort_notm}} integrieren](cs_planning.html#cs_planning_integrations).</dd>
</dl>

### Zustandsüberwachung für Workerknoten mit automatischer Wiederherstellung konfigurieren
{: #cs_configure_worker_monitoring}

Das System für die automatische Wiederherstellung von {{site.data.keyword.containerlong_notm}} kann in vorhandenen Clustern ab Kubernetes Version 1.7 bereitgestellt werden. Das System verwendet verschiedene Prüfungen zum Abfragen des allgemeinen Zustands von Workerknoten. Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Diese Korrekturmaßnahme wird immer nur für einen Workerknoten ausgeführt. Die Korrekturmaßnahme muss für diesen Workerknoten erfolgreich abgeschlossen werden, bevor für einen weiteren Workerknoten eine Korrekturmaßnahme durchgeführt werden kann.
Weitere Informationen finden Sie in diesem [Blogbeitrag zur automatischen Wiederherstellung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**HINWEIS**: Für die automatische Wiederherstellung ist es erforderlich, dass mindestens ein ordnungsgemäß funktionierender Workerknoten vorhanden ist. Konfigurieren Sie die automatische Wiederherstellung mit aktiven Prüfungen nur in Clustern mit mindestens zwei Workerknoten.

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem die Zustandsprüfung für die Workerknoten durchgeführt werden soll.

1. Erstellen Sie eine Konfigurationszuordnungsdatei, mit der die Prüfungen im JSON-Format definiert werden. In der folgenden YAML-Datei sind beispielsweise drei Prüfungen angegeben: eine HTTP-Prüfung und zwei Kubernetes-API-Serverprüfungen.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>Tabelle 14. Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Der Konfigurationsname <code>ibm-worker-recovery-checks</code> ist eine Konstante und kann nicht geändert werden.</td>
    </tr>
    <tr>
    <td><code>namespace</code></td>
    <td>Der Namensbereich <code>kube-system</code> ist eine Konstante und kann nicht geändert werden.</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>Geben Sie die Art der Prüfung an, die im Rahmen der automatischen Wiederherstellung verwendet werden soll. <ul><li><code>HTTP</code>: Bei der automatischen Wiederherstellung werden HTTP-Server aufgerufen, die auf den einzelnen Knoten aktiv sind, um zu ermitteln, ob die Knoten ordnungsgemäß ausgeführt werden.</li><li><code>KUBEAPI</code>: Bei der automatischen Wiederherstellung wird der Kubernetes-API-Server aufgerufen und die Daten zum Allgemeinzustand gelesen, die von den Workerknoten gemeldet werden.</li></ul></td>
    </tr>
    <tr>
    <td><code>Ressource</code></td>
    <td>Wenn der Prüfungstyp <code>KUBEAPI</code> lautet, geben Sie den Ressourcentyp an, der im Rahmen der automatischen Wiederherstellung geprüft werden soll. Gültige Werte sind <code>NODE</code> oder <code>PODS</code>.</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>Geben Sie den Schwellenwert für die Anzahl der Prüfungen ein, die nacheinander fehlgeschlagen sind. Wenn dieser Schwellenwert erreicht wird, löst die automatische Wiederherstellung die angegebene Korrekturmaßnahme aus. Wenn beispielsweise der Schwellenwert '3' lautet und im Rahmen der automatischen Wiederherstellung dreimal in Folge eine konfigurierte Prüfung fehlschlägt, wird die der Prüfung zugeordnete Korrekturmaßnahme ausgelöst.</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>Wenn der Ressourcentyp <code>PODS</code> lautet, geben Sie den Schwellenwert für den Prozentsatz der Pods auf einem Workerknoten an, die den Zustand ['NotReady' ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) aufweisen können. Dieser Prozentsatz basiert auf der Gesamtanzahl an Pods, die auf einem Workerknoten geplant sind. Wenn durch eine Prüfung festgestellt wird, dass der Prozentsatz nicht ordnungsgemäß funktionierender Pods größer ist als der Schwellenwert, zählt die Prüfung als ein Fehler.</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>Geben Sie die Aktion ein, die ausgeführt werden soll, wenn der Fehlerschwellenwert erreicht wird. Eine Korrekturmaßnahme wird nur ausgeführt, während keine weiteren Worker repariert werden und wenn dieser Workerknoten sich nicht in einer 'Erholungsphase' von einer vorherigen Aktion befindet. <ul><li><code>REBOOT</code>: Startet den Workerknoten neu.</li><li><code>RELOAD</code>: Lädt alle erforderlichen Konfigurationen für den Workerknoten erneut von einem bereinigten Betriebssystem.</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>Geben Sie die Anzahl der Sekunden an, die die automatische Wiederherstellung warten muss, bis eine weitere Korrekturmaßnahme für einen Knoten abgesetzt werden kann, für den bereits eine Korrekturmaßnahme ausgelöst wurde. Die 'Erholungsphase' startet zu dem Zeitpunkt, zu dem eine Korrekturmaßnahme ausgegeben wird.</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>Geben Sie die Anzahl der Sekunden für den Zeitraum zwischen zwei aufeinanderfolgenden Prüfungen ein. Wenn der Wert beispielsweise '180' lautet, führt die automatische Wiederherstellung die Prüfung alle drei Minuten für einen Knoten aus.</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>Geben Sie die maximale Anzahl der Sekunden ein, die ein Prüfungsaufruf an die Datenbank dauern darf, bevor die automatische Wiederherstellung die Aufrufoperation beendet. Der Wert für <code>TimeoutSeconds</code> muss kleiner sein als der Wert für <code>IntervalSeconds</code>.</td>
    </tr>
    <tr>
    <td><code>Port</code></td>
    <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben Sie den Port ein, an den der HTTP-Server auf dem Workerknoten gebunden werden muss. Dieser Port muss an der IP jedes Workerknotens im Cluster zugänglich sein. Bei der automatischen Wiederherstellung ist für die Prüfung von Servern eine konstante Portnummer auf allen Knoten erforderlich. Verwenden Sie [DaemonSets ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) bei der Bereitstellung eines angepassten Servers in einem Cluster.</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben sie den HTTP-Serverstatus ein, der als Rückgabewert der Prüfung erwartet wird. Beispielsweise gibt der Wert '200' an, dass Sie als Antwort <code>OK</code> vom Server erwarten.</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>Wenn der Prüfungstyp <code>HTTP</code> lautet, geben Sie den Pfad an, der vom HTTP-Server angefordert wird. Der Wert ist in der Regel der Metrikenpfad für den Server, der auf allen Workerknoten ausgeführt wird.</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>Geben Sie <code>true</code> ein, um die Prüfung zu aktivieren, oder <code>false</code>, um die Prüfung zu inaktivieren.</td>
    </tr>
    </tbody></table>

2. Erstellen Sie die Konfigurationszuordnung in Ihrem Cluster.

    ```
    kubectl apply -f <meine_datei.yaml>
    ```
    {: pre}

3. Stellen Sie sicher, dass Sie die Konfigurationszuordnung mit dem Namen `ibm-worker-recovery-checks` im Namensbereich `kube-system` mit den richtigen Prüfungen erstellt haben.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Stellen Sie sicher, dass Sie einen geheimen Schlüssel für Docker-Pulloperationen namens `international-registry-docker-secret` im Namensbereich `kube-system` erstellt haben. Die automatische Wiederherstellung ist in der internationalen Docker-Registry von {{site.data.keyword.registryshort_notm}} gehostet. Wenn Sie keinen geheimen Schlüssel für die Docker-Registry erstellt haben, der gültige Berechtigungsnachweise für die internationale Registry aufweist, erstellen Sie einen solchen Schlüssel zum Ausführen des System für die automatische Wiederherstellung.

    1. Installieren Sie das {{site.data.keyword.registryshort_notm}}-Plug-in.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Wechseln Sie zur internationalen Registry.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Erstellen Sie ein Token für die internationale Registry.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Setzen Sie die Umgebungsvariable `INTERNATIONAL_REGISTRY_TOKEN` auf das von Ihnen erstellte Token.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Setzen Sie die Umgebungsvariable `DOCKER_EMAIL` auf den aktuellen Benutzer. Ihre E-Mail-Adresse wird nur zum Ausführen des Befehls `kubectl` im nächsten Schritt benötigt.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Erstellen Sie einen geheimen Schlüssel für die Docker-Pulloperation.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Stellen Sie die automatische Wiederherstellung in Ihrem Cluster durch das Anwenden der folgenden YAML-Datei bereit.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. Nach einigen Minuten können Sie den Abschnitt `Events` in der Ausgabe des folgenden Befehls auf mögliche Aktivitäten bei der Bereitstellung der automatischen Wiederherstellung überprüfen.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## Kubernetes-Clusterressourcen grafisch darstellen
{: #cs_weavescope}

Weave Scope liefert eine grafisch orientierte Diagrammdarstellung Ihrer Ressourcen in einem Kubernetes-Cluster unter Einbeziehung von Services, Pods, Containern, Prozessen, Knoten und vielem mehr. Weave Scope stellt interaktive Metriken für CPU und Speicher bereit und bietet Tools, um 'tail'- und 'exec'-Aufrufe in einem Container durchzuführen.
{:shortdesc}

Vorbemerkungen:

-   Denken Sie daran, dass Sie keine Clusterinformationen im öffentlichen Internet offenlegen dürfen. Führen Sie diese Schritte aus, um Weave Scope sicher bereitzustellen und dann lokal über einen Web-Browser auf den Service zuzugreifen.
-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](#cs_cluster_ui). Weave Scope kann die CPU stark belasten, insbesondere die App. Führen Sie Weave Scope daher mit größeren Standardclustern aus, nicht mit Lite-Clustern.
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.


Gehen Sie wie folgt vor, um Weave Scope mit einem Cluster zu verwenden:
2.  Stellen Sie eine der zur Verfügung gestellten Konfigurationsdatei für die RBAC-Berechtigungen im Cluster bereit.

    Gehen Sie wie folgt vor, um die Schreib-/Leseberechtigung zu aktivieren:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Gehen Sie wie folgt vor, um die Schreibberechtigung zu aktivieren:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Ausgabe:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Stellen Sie den Weave Scope-Service bereit, auf den über die IP-Adresse des Clusters privat zugegriffen werden kann.

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Ausgabe:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Führen Sie einen Befehl zur Portweiterleitung aus, um den Service auf dem Computer zu starten. Da Weave Scope jetzt für den Cluster konfiguriert ist, können Sie diesen Befehl zur Portweiterleitung beim nächsten Zugriff auf Weave Scope ausführen, ohne wieder die vorherigen Konfigurationsschritte ausführen zu müssen.

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Ausgabe:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Öffnen Sie Ihren Web-Browser mit der Adresse `http://localhost:4040`. Ohne die Bereitstellung der Standardkomponenten wird das folgende Diagramm angezeigt. Sie können entweder Topologiediagramme oder Tabellen in den Kubernetes-Ressourcen im Cluster anzeigen.

     <img src="images/weave_scope.png" alt="Beispieltopologie von Weave Scope" style="width:357px;" />


[Weitere Informationen zu den Weave Scope-Funktionen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.weave.works/docs/scope/latest/features/).

<br />


## Cluster entfernen
{: #cs_cluster_remove}

Wenn Sie den Vorgang für einen Cluster beendet haben, können Sie den Cluster entfernen, sodass dieser keine Ressourcen mehr verbraucht.
{:shortdesc}

Lite-Cluster und Standardcluster, die mit einem nutzungsabhängigen Konto erstellt wurden, müssen vom Benutzer manuell entfernt werden, wenn sie nicht mehr benötigt werden. 

Wenn Sie einen Cluster löschen, so löschen Sie zugleich auch Ressourcen, die sich diesem Cluster befinden, wie unter anderem Container, Pods, gebundene Services und geheime Schlüssel. Wenn Sie Ihren Speicher beim Löschen Ihres Clusters nicht löschen, können Sie Ihren Speicher über das Dashboard von IBM Cloud Infrastructure (SoftLayer) in der {{site.data.keyword.Bluemix_notm}}-GUI löschen. Bedingt durch den monatlichen Abrechnungszyklus kann ein Persistent Volume Claim (PVC) nicht am letzten Tag des Monats gelöscht werden. Wenn Sie den Persistent Volume Claim am letzten Tag des Monats entfernen, verbleibt die Löschung bis zum Beginn des nächsten Monats in einem anstehenden Zustand.

**Warnung:** In Ihrem persistenten Speicher werden keine Sicherungen Ihres Clusters oder Ihrer Daten erstellt. Das Löschen des Clusters kann nicht rückgängig gemacht werden.

-   Vorgehensweise bei Verwendung der {{site.data.keyword.Bluemix_notm}}-GUI:
    1.  Wählen Sie Ihren Cluster aus und klicken Sie im Menü **Weitere Aktionen...** auf **Löschen**.
-   Vorgehensweise bei Verwendung der {{site.data.keyword.Bluemix_notm}}-CLI:
    1.  Listen Sie die verfügbaren Cluster auf.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Löschen Sie den Cluster.

        ```
        bx cs cluster-rm mein_cluster
        ```
        {: pre}

    3.  Befolgen Sie die Eingabeaufforderungen und wählen Sie aus, ob Clusterressourcen gelöscht werden sollen.

Wenn Sie einen Cluster entfernen, können Sie auch die portierbaren Teilnetze und den zugehörigen persistenten Speicher entfernen:
- Teilnetze dienen zum Zuweisen von portierbaren öffentlichen IP-Adressen, um Lastausgleichsservices oder Ihre Ingress-Controller zu laden. Wenn Sie sie behalten, können Sie sie in einem neuen Cluster wiederverwenden oder manuell zu einem späteren Zeitpunkt aus Ihrem IBM Cloud Infrastructure (SoftLayer)-Portfolio löschen.
- Wenn Sie mithilfe eines vorhandenen Dateisystems (siehe [#cs_cluster_volume_create]) einen Persistent Volume Claim (PVC) erstellt haben, können Sie beim Entfernen des Clusters die Dateifreigabe nicht löschen. Sie müssen die Dateifreigabe zu einem späteren Zeitpunkt manuell aus Ihrem IBM Cloud Infrastructure (SoftLayer)-Portfolio löschen.
- Persistenter Speicher bietet eine hohe Verfügbarkeit für Ihre Daten. Wenn Sie ihn löschen, können Sie Ihre Daten nicht wiederherstellen.
