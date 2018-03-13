---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Daten in Ihrem Cluster speichern
{: #storage}
Sie können Daten dauerhaft speichern, damit sie bei Störungen Ihres Clusters oder für die gemeinsame Nutzung durch App-Instanzen zur Verfügung stehen.

## Hochverfügbarkeitsspeicher planen
{: #planning}

In {{site.data.keyword.containerlong_notm}} stehen verschiedene Optionen zum Speichern Ihrer App-Daten und für die gemeinsame Datennutzung zwischen Pods in Ihrem Cluster zur Auswahl. Nicht alle Speicheroptionen bieten denselben Grad an Permanenz und Verfügbarkeit, falls eine Komponente in Ihrem Cluster oder ein ganzer Standort ausfällt.
{: shortdesc}

### Optionen für nicht persistente Datenspeicherung
{: #non_persistent}

Optionen für nicht persistente Speicherung können verwendet werden, wenn die zu speichernden Daten nicht permanent verfügbar sein müssen (z. B. zum Wiederherstellen nach Clusterfehlern) oder nicht von App-Instanzen gemeinsam genutzt werden. Außerdem können diese Speicheroptionen zum Testen von App-Komponenten oder neuen Funktionen verwendet werden.
{: shortdesc}

Die folgende Abbildung zeigt die verfügbaren Optionen für nicht persistente Datenspeicherung in {{site.data.keyword.containerlong_notm}}. Diese Optionen stehen für kostenlose Cluster und für Standardcluster zur Verfügung.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Optionen für nicht persistente Datenspeicherung" width="450" style="width: 450px; border-style: none"/></p>

<table summary="In der Tabelle sind die Optionen für nicht persistente Datenspeicherung aufgeführt. Die Tabellenzeilen enthalten von links nach rechts die Nummer der Option in der ersten Spalte, den Titel der Option in der zweiten Spalte und die Beschreibung in der dritten Spalte." style="width: 100%">
<colgroup>
       <col span="1" style="width: 5%;"/>
       <col span="1" style="width: 20%;"/>
       <col span="1" style="width: 75%;"/>
    </colgroup>
  <thead>
  <th>#</th>
  <th>Option</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Im Container oder Pod</td>
      <td>Container und Pods sind per Definition Komponenten mit kurzer Lebensdauer, die kurzfristig und unerwartet ausfallen können. Sie können jedoch Daten in das lokale Dateisystem eines Containers schreiben, um diese Daten für die Lebensdauer des Containers zu speichern. Daten in einem Container können nicht mit anderen Containern oder Pods gemeinsam genutzt werden und gehen verloren, wenn der Container ausfällt oder entfernt wird. Weitere Informationen finden Sie unter [Storing data in a container](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2</td>
    <td>Auf dem Workerknoten</td>
    <td>Für jeden Workerknoten wird primärer und sekundärer Speicher entsprechend dem Maschinentyp eingerichtet, den Sie für Ihren Workerknoten auswählen. Der primäre Speicher dient zum Speichern von Betriebssystemdaten und ist für den Benutzer nicht zugänglich. Der sekundäre Speicher dient zum Speichern von Daten in dem Verzeichnis <code>/var/lib/docker</code>, in das alle Containerdaten geschrieben werden. <br/><br/>Um auf den sekundären Speicher Ihres Workerknotens zuzugreifen, können Sie einen Datenträger <code>/emptyDir</code> erstellen. Dieser leere Datenträger wird einem Pod in Ihrem Cluster zugeordnet, damit Container in diesem Pod Daten in dem Datenträger lesen und schreiben können. Da der Datenträger einem ganz bestimmten Pod zugewiesen ist, können Daten nicht mit anderen Pods in einer Replikatgruppe gemeinsam genutzt werden.<br/><p>Ein Datenträger <code>/emptyDir</code> und die zugehörigen Daten werden entfernt, wenn die folgenden Situationen eintreten: <ul><li>Der zugeordnete Pod auf dem Workerknoten wird permanent gelöscht.</li><li>Der zugeordnete Pod wird auf einem anderen Workerknoten terminiert.</li><li>Der Workerknoten wird neu geladen oder aktualisiert.</li><li>Der Workerknoten wird gelöscht.</li><li>Der Cluster wird gelöscht.</li><li>Das {{site.data.keyword.Bluemix_notm}}-Konto wird ausgesetzt.</li></ul></p><p><strong>Hinweis:</strong> Wenn der Container im Pod ausfällt, sind die im Datenträger enthaltenen Daten trotzdem noch auf dem Workerknoten verfügbar.</p><p>Weitere Informationen finden Sie unter [Kubernetes-Datenträger ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/).</p></td>
    </tr>
    </tbody>
    </table>

### Optionen für persistenten Datenspeicher mit hoher Verfügbarkeit
{: persistent}

Die größte Herausforderung bei der Erstellung von hoch verfügbaren, statusabhängigen Apps besteht in der Persistenz von Daten zwischen mehreren App-Instanzen an mehreren Standorten und darin, die Daten ständig synchron zu halten. Bei hoch verfügbaren Daten sollten Sie sicheerstellen, dass eine Masterdatenbank mit mehreren Instanzen vorhanden ist, die auf mehrere Rechenzentren oder Regionen verteilt ist, und dass die Daten in dieser Masterdatenbank fortlaufend repliziert werden. Alle Instanzen in Ihrem Cluster müssen aus dieser Masterdatenbank lesen und in sie schreiben. Wenn eine Instanz der Masterdatenbank nicht betriebsbereit ist, können anderen Instanzen die Arbeitslast übernehmen, damit keine Ausfallzeiten für Ihre Apps entstehen.
{: shortdesc}

Die folgende Abbildung zeigt, mit welchen Optionen Sie Ihre Daten in {{site.data.keyword.containerlong_notm}} in einem Standardcluster hoch verfügbar machen können. Welche Option für Ihr Szenario am besten geeignet ist, hängt von den folgenden Faktoren ab:
  * **Typ der verwendeten App:** Möglicherweise muss Ihre App Daten in Dateien speichern und nicht in einer Datenbank.
  * **Gesetzliche Anforderungen für das Speichern und Weiterleiten der Daten:** Möglicherweise sind Sie dazu verpflichtet, Daten ausschließlich in den USA zu speichern und weiterzuleiten, d. h. Sie dürfen keinen Service mit Standort in Europa verwenden.
  * **Optionen für Sicherung und Wiederherstellung:** Jede Speicheroption bietet Funktionen zum Sichern und Wiederherstellen von Daten. Überprüfen Sie, dass die verfügbaren Optionen für Sicherung und Wiederherstellung den Anforderungen (z. B. Häufigkeit der Sicherungen oder Möglichkeiten zur Datenspeicherung außerhalb Ihres primären Rechenzentrums) Ihres Disaster-Recovery-Plans entsprechen.
  * **Globale Replikation:** Für die Hochverfügbarkeit kann es sinnvoll sein, mehrere Speicherinstanzen einzurichten, die auf Rechenzentren in der ganzen Welt verteilt und repliziert werden.

<br/>
<img src="images/cs_storage_ha.png" alt="Hochverfügbarkeitsoptionen für persistenten Speicher"/>

<table summary="In der Tabelle sind Optionen für persistenten Speicher aufgeführt. Die einzelnen Tabellenzeilen enthalten von links nach rechts die Nummer der Option in der ersten Spalte, den Titel der Option in der zweiten Spalte und die Beschreibung in der dritten Spalte.">
  <thead>
  <th>#</th>
  <th>Option</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
  <tr>
  <td width="5%">1</td>
  <td width="20%">NFS-Dateispeicher</td>
  <td width="75%">Diese Option stellt persistente App- und Containerdaten mithilfe von persistenten Kubernetes-Datenträgern bereit. Die Datenträger werden in [NFS-basiertem Endurance- und Performance-Dateispeicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/details) gehostet, der für Apps verwendet werden kann, die Daten in Dateiform speichern und nicht in einer Datenbank. Der Dateispeicher wird auf REST-Ebene verschlüsselt und von IBM in Gruppen zusammengefasst, um hohe Verfügbarkeit bereitzustellen.<p>{{site.data.keyword.containershort_notm}} stellt vordefinierte Speicherklassen bereit, die den Größenbereich des Speichers, die E/A-Operationen pro Sekunde, die Löschrichtlinie sowie die Lese- und Schreibberechtigungen für den Datenträger definieren. Um eine Anforderung für NFS-basierten Dateispeicher zu stellen, müssen Sie einen [Persistent Volume Claim](cs_storage.html#create) (PVC) erstellen. Nachdem Sie einen Persistent Volume Claim (PVC) übergeben haben, stellt {{site.data.keyword.containershort_notm}} dynamisch ein Persistent Volume (PV) bereit, das in NFS-basiertem Dateispeicher gehostet wird. [Sie hängen den Persistent Volume Claim (PVC)](cs_storage.html#app_volume_mount) als Datenträger an Ihre Bereitstellung an, damit die Container den Datenträger lesen und beschreiben können. </p><p>Persistent Volumes (persistente Datenträger) werden in dem Rechenzentrum bereitgestellt, in dem sich der Workerknoten befindet. Daten können von derselben Replikatgruppe oder von verschiedenen Implementierungen im selben Cluster gemeinsam genutzt werden. Daten können nicht von Clustern gemeinsam genutzt werden, die sich in verschiedenen Rechenzentren oder Regionen befinden.</p><p>Standardmäßig wird keine automatische Sicherung des NFS-Speichers erstellt. Mit den verfügbaren Sicherungs- und Wiederherstellungsverfahren können Sie regelmäßige Sicherungen für Ihren Cluster einrichten. Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Bereitstellungen zugegriffen werden, an die der Datenträger angehängt ist. </p><p><strong>Hinweis:</strong> Die Speicherung in persistenten NFS-Dateifreigaben wird monatlich berechnet. Wenn Sie persistenten Speicher für Ihren Cluster einrichten und diesen unverzüglich nach der Einrichtung entfernen, bezahlen Sie trotzdem die monatliche Gebühr für den persistenten Speicher, auch wenn Sie ihn nur über einen kurzen Zeitraum genutzt haben.</p></td>
  </tr>
  <tr>
    <td>2</td>
    <td>Cloud-Datenbankservice</td>
    <td>Mit dieser Option können Sie über einen {{site.data.keyword.Bluemix_notm}}-Cloud-Service für Datenbanken (z. B. [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant)) Daten persistent speichern und auf sie zugreifen. Auf Daten, die mit dieser Option gespeichert wurden, kann in mehreren Clustern sowie an mehreren Standorten und Regionen zugegriffen werden.<p> Sie können entweder eine einzelne Datenbankinstanz konfigurieren, auf die alle Ihre Apps zugreifen, oder [mehrere Instanzen mit übergreifender Replikation in Rechenzentren einrichten](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery), um hohe Verfügbarkeit für die Daten bereitzustellen. In der IBM Cloudant NoSQL-Datenbank werden Daten nicht automatisch gesichert. Sie können die bereitgestellten [Sicherungs- und Wiederherstellungsverfahren](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) verwenden, um Ihre Daten vor Siteausfällen zu schützen.</p> <p> Um einen Service in Ihrem Cluster zu verwenden, [binden Sie den {{site.data.keyword.Bluemix_notm}}-Service](cs_integrations.html#adding_app) an einen Namensbereich in Ihrem Cluster. Bei diesem Vorgang wird ein geheimer Kubernetes-Schlüssel erstellt. Der geheime Kubernetes-Schlüssel enthält vertrauliche Informationen zu dem Service (z. B. die URL für den Service, Ihren Benutzernamen und das Kennwort). Sie können den geheimen Schlüssel als Datenträger für geheime Schlüssel an Ihren Pod anhängen und unter Verwendung der im geheimen Schlüssel gespeicherten Berechtigungsnachweise auf den Service zugreifen. Durch Anhängen des Datenträgers für geheime Schlüssel an andere Pods können Sie Daten podübergreifend gemeinsam nutzen. Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Pods zugegriffen werden, an die der Datenträger für geheime Schlüssel angehängt ist. <p>Die meisten {{site.data.keyword.Bluemix_notm}}-Datenbankservices stellen Plattenspeicher für ein geringes Datenvolumen gebührenfrei zur Verfügung, damit Sie dessen Funktionen testen können.</p></td>
  </tr>
  <tr>
    <td>3</td>
    <td>Lokale Datenbank</td>
    <td>Wenn Ihre Daten aus rechtlichen Gründen lokal gespeichert werden müssen, können Sie eine [VPN-Verbindung zur lokalen Datenbank einrichten](cs_vpn.html#vpn) und die in Ihrem Rechenzentrum vorhandenen Sicherungs- und Wiederherstellungsverfahren verwenden.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tabelle. Optionen für persistentes Speichern von Daten bei Bereitstellungen in Kubernetes-Clustern" caption-side="top"}

<br />



## Vorhandene NFS-Dateifreigaben in Clustern verwenden
{: #existing}

Wenn bereits NFS-Dateifreigaben in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) vorhanden sind, die Sie mit Kubernetes verwenden möchten, können Sie das tun, indem Sie Persistent Volumes in Ihrer vorhandenen NFS-Dateifreigabe erstellen. Ein Persistent Volume ist eine Hardwarekomponente, die als Kubernetes-Clusterressource dient und von dem Clusterbenutzer verarbeitet werden kann.
{:shortdesc}

Kubernetes unterscheidet zwischen Persistent Volumes, die tatsächliche Hardware darstellen, und Persistent Volume Claims, bei denen es sich um Speicheranforderungen handelt, die üblicherweise vom Clusterbenutzer initiiert werden. Das folgende Diagramm veranschaulicht die Beziehung zwischen Persistent Volumes und Persistent Volume Claims (PVCs).

![Erstellen von Persistent Volumes und Persistent Volume Claims](images/cs_cluster_pv_pvc.png)

 Wenn Sie, wie im Diagramm dargestellt, die Verwendung vorhandener NFS-Dateifreigaben mit Kubernetes ermöglichen möchten, müssen Sie Persistent Volumes mit einer bestimmten Größe und einem bestimmten Zugriffsmodus erstellen und dann einen Persistent Volume Claim erstellen, der mit der Angabe des Persistent Volume übereinstimmt. Wenn Persistent Volume und Persistent Volume Claim übereinstimmen, werden sie aneinander gebunden. Vom Clusterbenutzer können nur gebundene Persistent Volume Claims verwendet werden, um den Datenträger an eine Bereitstellung anzuhängen. Dieser Prozess wird als statische Bereitstellung von persistentem Speicher bezeichnet.

Stellen Sie zunächst sicher, dass Sie über eine NFS-Dateifreigabe verfügen, die Sie zum Erstellen Ihres Persistent Volume verwenden können.

**Hinweis:** Eine statische Bereitstellung von persistentem Speicher gilt nur für vorhandene NFS-Dateifreigaben. Wenn keine NFS-Dateifreigaben vorhanden sind, können Clusterbenutzer den Prozess der [dynamischen Bereitstellung](cs_storage.html#create) nutzen, um Persistent Volumes hinzuzufügen.

Führen Sie die folgenden Schritte aus, um ein Persistent Volume und einen passenden Persistent Volume Claim zu erstellen:

1.  Suchen Sie in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) die ID und den Pfad der NFS-Dateifreigabe, in der Sie Ihr Persistent Volume-Objekt erstellen möchten. Autorisieren Sie darüber hinaus den Dateispeicher für die Teilnetze im Cluster. Diese Autorisierung erteilt Ihrem Cluster Zugriff auf den Speicher.
    1.  Melden Sie sich bei Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) an.
    2.  Klicken Sie auf **Speicher**.
    3.  Klicken Sie auf **Dateispeicher** und wählen Sie im Menü **Aktionen** die Option zum Autorisieren des Hosts**** aus.
    4.  Klicken Sie auf **Teilnetze**. Nach der Autorisierung hat jeder Workerknoten im Teilnetz Zugriff auf den Dateispeicher.
    5.  Wählen Sie das Teilnetz des öffentlichen VLANs Ihres Clusters im Menü aus und klicken Sie auf **Abschicken**. Wenn Sie das Teilnetz suchen müssen, führen Sie `bx cs cluster-get <cluster_name> --showResources` aus.
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
    <caption>Tabelle. Erklärung der Komponenten der YAML-Datei</caption>
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
    <td>Der Zugriffsmodus definiert, auf welche Art ein Persistent Volume Claim (PVC) an einen Workerknoten angehängt werden kann.<ul><li>ReadWriteOnce (RWO): Das Persistent Volume kann nur an die Bereitstellungen in einem einzigen Workerknoten angehängt werden. Die an dieses Persistent Volume angehängten Container können auf diesen Datenträger schreiben und ihn lesen.</li><li>ReadOnlyMany (ROX): Das Persistent Volume kann an Bereitstellungen angehängt werden, die auf verschiedenen Workerknoten gehostet sind. Die an dieses Persistent Volume angehängten Bereitstellungen können den Datenträger nur lesen.</li><li>ReadWriteMany (RWX): Dieses Persistent Volume kann an Bereitstellungen angehängt werden, die auf verschiedenen Workerknoten gehostet sind. Bereitstellungen, die an dieses Persistent Volume angehängt werden, können den Datenträger lesen und ihn beschreiben.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Geben Sie die Server-ID der NFS-Dateifreigabe ein.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Geben Sie den Pfad der NFS-Dateifreigabe ein, in dem Sie das Persistent Volume-Objekt erstellen wollen.</td>
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

4.  Vergewissern Sie sich, dass das Persistent Volume erstellt wurde.

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

7.  Vergewissern Sie sich, dass Ihr Persistent Volume Claim erstellt und an das Persistent Volume-Objekt gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Die Ausgabe ähnelt der folgenden:

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


Sie haben erfolgreich ein Persistent Volume-Objekt erstellt und an einen Persistent Volume Claim gebunden. Clusterbenutzer können jetzt den [Persistent Volume Claim an ihre Bereitstellungen anhängen](#app_volume_mount) und mit dem Lesen und Schreiben in dem Persistent Volume-Objekt beginnen.

<br />


## Persistenten Speicher für Apps erstellen
{: #create}

Zum Einrichten von NFS-Dateispeicher für Ihren Cluster erstellen Sie einen Persistent Volume Claim (PVC). Anschließend hängen Sie diesen Claim an eine Bereitstellung an, um sicherzustellen, dass Daten auch dann verfügbar sind, wenn die Pods ausfallen oder abschalten.
{:shortdesc}

Der NFS-Dateispeicher, auf den sich das Persistent Volume stützt, wird von IBM in Gruppen zusammengefasst, um hohe Verfügbarkeit für Ihre Daten bereitzustellen. Die Speicherklassen beschreiben die Typen der verfügbaren Speicherangebote und definieren Aspekte wie die Datenaufbewahrungsrichtlinie, die Größe in Gigabyte und die E/A-Operationen pro Sekunde (IOPS), wenn Sie Ihren persistenten Datenträger erstellen.

**Hinweis**: Wenn Sie über eine Firewall verfügen, [gewähren Sie Egress-Zugriff](cs_firewall.html#pvc) für die IBM Cloud Infrastructure (SoftLayer)-IP-Bereiche der Standorte (Rechenzentren), in denen sich Ihre Cluster befinden, damit Sie Persistent Volume Claims erstellen können.

1.  Überprüfen Sie die verfügbaren Speicherklassen. {{site.data.keyword.containerlong}} stellt acht vordefinierte Speicherklassen zur Verfügung, sodass der Clusteradministrator keine Speicherklassen erstellen muss. Die Speicherklasse `ibmc-file-bronze` ist identisch mit der Speicherklasse `default`.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-retain-bronze      ibm.io/ibmc-file
    ibmc-file-retain-custom      ibm.io/ibmc-file
    ibmc-file-retain-gold        ibm.io/ibmc-file
    ibmc-file-retain-silver      ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Legen Sie fest, ob Ihre Daten und die NFS-Dateifreigabe nach dem Löschen der PVC gespeichert werden sollen (dies wird auch als Freigaberichtlinie bezeichnet). Wenn Sie die Daten aufbewahren möchten, dann wählen Sie eine Speicherklasse vom Typ `retain` aus. Wenn die Daten und die Dateifreigabe bei der Löschung des PVC ebenfalls gelöscht werden sollen, dann wählen Sie eine Speicherklasse ohne `retain` aus.

3.  Rufen Sie die Details für eine Speicherklasse ab. Prüfen Sie die IOPS pro Gigabyte und den Größenbereich im Feld **Parameter** Ihrer CLI-Ausgabe. 

    <ul>
      <li>Die Speicherklassen 'bronze', 'silver' oder 'gold' verwenden [Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage) mit einem definierten Wert für die E/A-Operationen pro Sekunde (IOPS) pro GB für jede Klasse. Sie können den Gesamtwert für IOPS festlegen, indem Sie eine Größe innerhalb des verfügbaren Bereichs auswählen. Wenn Sie beispielsweise eine Größe von 1000Gi für die Dateifreigabe in der Speicherklasse 'silver' mit 4 IOPS pro GB auswählen, verfügt Ihr Datenträger insgesamt über 4000 IOPS. Je höher der IOPS-Wert Ihres persistenten Datenträgers, umso höher die Verarbeitungsgeschwindigkeit für Ein- und Ausgabeoperationen. <p>**Beispielbefehl zum Beschreiben der Speicherklasse**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-silver</pre>

       Das Feld **Parameters** gibt die E/A-Operationen pro Sekunde pro GB für die Speicherklasse und die verfügbaren Größen in Gigabyte an.
       <pre class="pre">Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi</pre>
       
       </li>
      <li>Die angepassten Speicherklassen verwenden [Leistungsspeicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage) und bieten mehr Kontrolle beim Auswählen der Kombination aus IOPS und Größe. <p>**Beispielbefehl zum Beschreiben der angepassten Speicherklasse**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-retain-custom</pre>

       Das Feld **Parameters** gibt die E/A-Operationen pro Sekunde für die Speicherklasse und die verfügbaren Größen in Gigabyte an. Beispiel: Mit 40Gi pvc können E/A-Operationen pro Sekunde ausgewählt werden, die ein Vielfaches von 100 sind und im Bereich zwischen 100 - 2000 E/A-Operationen pro Sekunde liegen.

       ```
       Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
       ```
       {: screen}
       </li></ul>
4. Erstellen Sie eine Konfigurationsdatei, um Ihren Persistent Volume Claim (PVC) zu definieren, und speichern Sie die Konfiguration als Datei mit der Erweiterung `.yaml`.

    -  **Beispiel für die Speicherklassen 'bronze', 'silver' und 'gold'**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
        name: mypvc
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

    -  **Beispiel für angepasste Speicherklassen**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"

       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 40Gi
             iops: "500"
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Geben Sie den Namen des PVCs ein.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>Geben Sie die Speicherklasse für den persistenten Datenträger (Persistent Volume) an:
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 E/A-Operationen pro Sekunde pro GB.</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver: 4 E/A-Operationen pro Sekunde pro GB.</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold: 10 E/A-Operationen pro Sekunde pro GB.</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom: Mehrere Werte für E/A-Operationen pro Sekunde verfügbar.</li>
          <p>Wenn keine Speicherklasse angegeben ist, wird das Persistent Volume mit der Speicherklasse 'bronze' erstellt.</p></td>
        </tr>
        
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
        <td>Wenn Sie eine Größe angeben, die nicht aufgelistet ist, wird automatisch aufgerundet. Wenn Sie eine Größe angeben, die die maximale angegebene Größe überschreitet, wird automatisch auf die nächstkleinere Größe abgerundet.</td>
        </tr>
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
        <td>Diese Option gilt nur für angepasste Speicherklassen (`ibmc-file-custom / ibmc-file-retain-custom`). Geben Sie die Gesamtzahl der E/A-Operationen pro Sekunde für den Speicher an. Führen Sie `kubectl describe storageclasses ibmc-file-custom` aus, um alle Optionen anzuzeigen. Wenn Sie einen Wert für die E/A-Operationen pro Sekunde auswählen, der nicht aufgelistet ist, wird der Wert aufgerundet.</td>
        </tr>
        </tbody></table>

5.  Erstellen Sie den Persistent Volume Claim.

    ```
    kubectl apply -f <lokaler_dateipfad>
    ```
    {: pre}

6.  Überprüfen Sie, dass Ihr Persistent Volume Claim erstellt und an das Persistent Volume gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Beispielausgabe:

    ```
    Name: mypvc
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

6.  {: #app_volume_mount}Erstellen Sie eine Konfigurationsdatei, um den Persistent Volume Claim an Ihre Bereitstellung anzuhängen. Speichern Sie diese Konfiguration als Datei mit der Erweiterung `.yaml`.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <bereitstellungsname>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app-name>
    spec:
     containers:
     - image: <imagename>
       name: <containername>
       volumeMounts:
       - mountPath: /<dateipfad>
         name: <datenträgername>
     volumes:
     - name: <datenträgername>
       persistentVolumeClaim:
         claimName: <pvc-name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Der Name der Bereitstellung.</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Eine Bezeichnung für die Bereitstellung.</td>
    </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>Der Name des Images, das Sie verwenden möchten. Um die verfügbaren Images in Ihrem {{site.data.keyword.registryshort_notm}}-Konto aufzulisten, führen Sie den Befehl `bx cr image-list` aus.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>Der Name des Containers, den Sie in Ihrem Cluster bereitstellen möchten.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>Der absolute Pfad des Verzeichnisses, in dem der Datenträger innerhalb des Containers angehängt wird.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>Der Name des Datenträgers, der an Ihren Pod angehängt werden soll.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Der Name des Datenträgers, der an Ihren Pod angehängt werden soll. Normalerweise ist dieser Name deckungsgleich mit <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>Der Name des PVCs, den Sie als Ihren Datenträger verwenden wollen. Wenn Sie den Datenträger an den Pod anhängen, erkennt Kubernetes den persistenten Datenträger, der an den Persistent Volume Claim (PVC) gebunden ist, und ermöglicht dem Benutzer das Lesen bzw. Schreiben in dem persistenten Datenträger.</td>
    </tr>
    </tbody></table>

8.  Erstellen Sie die Bereitstellung und hängen Sie den Persistent Volume Claim an.

    ```
    kubectl apply -f <lokaler_yaml-pfad>
    ```
    {: pre}

9.  Überprüfen Sie, dass der Datenträger erfolgreich angehängt wurde.

    ```
    kubectl describe deployment <bereitstellungsname>
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

<br />



## Datenträgerzugriff für Benutzer ohne Rootberechtigung zu persistentem Speicher hinzufügen
{: #nonroot}

Benutzer ohne Rootberechtigung verfügen nicht über die Schreibberechtigung für den Mountpfad für NFS-gesicherten Speicher. Um die Schreibberechtigung zu erteilen, müssen Sie die Dockerfile des Image bearbeiten und im Mountpfad ein Verzeichnis mit der entsprechenden Berechtigung zu erstellen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

Wenn Sie eine App erstellen, in der ein Benutzer ohne Rootberechtigung die Schreibberechtigung für den Datenträger benötigt, müssen Sie die folgenden Prozesse in Ihrer Dockerfile und in Ihrem Script für den Einstiegspunkt hinzufügen:

-   Einen Benutzer ohne Rootberechtigung erstellen
-   Den Benutzer temporär zu Rootgruppe hinzufügen
-   Ein Verzeichnis mit den entsprechenden Benutzerberechtigungen im Datenträger-Mountpfad erstellen

Für {{site.data.keyword.containershort_notm}} ist der Standardeigner des Datenträgermountpfads der Eigner `nobody`. Falls bei NFS-Speicher der Eigner nicht lokal im Pod vorhanden ist, wird der Benutzer `nobody` erstellt. Die Datenträger sind so konfiguriert, dass der Rootbenutzer im Container erkannt wird. Bei manchen Apps ist dies der einzige Benutzer in einem Container. In vielen Apps wird jedoch ein anderer Benutzer ohne Rootberechtigung als `nobody` angegeben, der in den Container-Mountpfad schreibt. Für einige Apps ist es erforderlich, dass der Datenträger dem Rootbenutzer gehören muss. Normalerweise werden Apps den Rootbenutzer aus Sicherheitsgründen nicht. Wenn für Ihre App jedoch ein Rootbenutzer erforderlich ist, können Sie sich für entsprechende Unterstützung an den [{{site.data.keyword.Bluemix_notm}}-Support](/docs/get-support/howtogetsupport.html#getting-customer-support) wenden.


1.  Erstellen Sie eine Dockerfile in einem lokalen Verzeichnis. Die nachfolgende Beispiel-Dockerfile erstellt einen Benutzer ohne Rootberechtigung mit dem Namen `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmliberty:latest

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

8.  Erstellen Sie eine Konfigurationsdatei, um den Datenträger anzuhängen und den Pod über das Image 'nonroot' auszuführen. Der Datenträger-Mountpfad `/mnt/myvol` stimmt mit dem in der Dockerfile angegebenen Mountpfad überein. Speichern Sie diese Konfiguration als Datei mit der Erweiterung `.yaml`.

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


