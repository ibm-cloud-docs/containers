---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-15"

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
Sie können Daten in {{site.data.keyword.containerlong}} persistent speichern, um Daten zwischen App-Instanzen gemeinsam zu nutzen und um Ihre Daten vor Verlust zu schützen, wenn eine Komponente in Ihrem Kubernetes-Cluster ausfällt.

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
<caption>Tabelle. Nicht persistente Speicheroptionen</caption>
  <thead>
  <th>Option</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
    <tr>
      <td>1. Innerhalb des Containers oder Pods</td>
      <td>Container und Pods sind per Definition Komponenten mit kurzer Lebensdauer, die kurzfristig und unerwartet ausfallen können. Sie können jedoch Daten in das lokale Dateisystem eines Containers schreiben, um diese Daten für die Lebensdauer des Containers zu speichern. Daten in einem Container können nicht mit anderen Containern oder Pods gemeinsam genutzt werden und gehen verloren, wenn der Container ausfällt oder entfernt wird. Weitere Informationen finden Sie unter [Storing data in a container](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2. Auf dem Workerknoten</td>
    <td>Für jeden Workerknoten wird primärer und sekundärer Speicher entsprechend dem Maschinentyp eingerichtet, den Sie für Ihren Workerknoten auswählen. Der primäre Speicher dient zum Speichern von Betriebssystemdaten und auf ihn kann mithilfe eines [Kubernetes-<code>HostPath</code>-Datenträgers![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) zugegriffen werden. Der sekundäre Speicher dient zum Speichern von Daten in dem Verzeichnis <code>/var/lib/docker</code>, in das alle Containerdaten geschrieben werden. Sie können auf den zweiten Speicher zugreifen, indem Sie einen [Kubernetes-<code>emptyDir</code>-Datenträger verwenden![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)<br/><br/>Während <code>HostPath</code>-Datenträger verwendet werden, um Dateien vom Dateisystem des Workerknotens auf Ihrem Pod anzuhängen (mount), erstellt <code>emptyDir</code> ein leeres Verzeichnis, das einem Pod in Ihrem Cluster zugewiesen ist. Alle Container in diesem Pod können von diesem Datenträger lesen und auf diesen Datenträger schreiben. Da der Datenträger einem ganz bestimmten Pod zugewiesen ist, können Daten nicht mit anderen Pods in einer Replikatgruppe gemeinsam genutzt werden. <br/><br/><p>Ein <code>HostPath</code>- oder <code>emptyDir</code>-Datenträger und die zugehörigen Daten werden in folgenden Situationen entfernt: <ul><li>Der Workerknoten wird gelöscht.</li><li>Der Workerknoten wird neu geladen oder aktualisiert.</li><li>Der Cluster wird gelöscht.</li><li>Das {{site.data.keyword.Bluemix_notm}}-Konto wird ausgesetzt. </li></ul></p><p>Zusätzlich werden Daten auf einem <code>emptyDir</code>-Datenträger in folgenden Situationen entfernt: <ul><li>Der zugeordnete Pod auf dem Workerknoten wird permanent gelöscht.</li><li>Der zugeordnete Pod wird auf einem anderen Workerknoten terminiert.</li></ul></p><p><strong>Hinweis:</strong> Wenn der Container im Pod ausfällt, sind die im Datenträger enthaltenen Daten trotzdem noch auf dem Workerknoten verfügbar.</p></td>
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
<caption>Tabelle. Persistente Speicheroptionen</caption>
  <thead>
  <th>Option</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
  <tr>
  <td>1. NFS-Dateispeicher</td>
  <td>Diese Option stellt persistente App- und Containerdaten mithilfe von persistenten Kubernetes-Datenträgern bereit. Die Datenträger werden in [NFS-basiertem Endurance- und Performance-Dateispeicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/details) gehostet, der für Apps verwendet werden kann, die Daten in Dateiform speichern und nicht in einer Datenbank. Dateispeicher werden bei REST verschlüsselt. <p>{{site.data.keyword.containershort_notm}} stellt vordefinierte Speicherklassen bereit, die den Größenbereich des Speichers, die E/A-Operationen pro Sekunde, die Löschrichtlinie sowie die Lese- und Schreibberechtigungen für den Datenträger definieren. Um eine Anforderung für NFS-basierten Dateispeicher zu stellen, müssen Sie einen [PVC (Persistent Volume Claim](cs_storage.html#create)) erstellen. Nachdem Sie einen PVC übergeben haben, stellt {{site.data.keyword.containershort_notm}} dynamisch einen persistenten Datenträger dar, der in einem NFS-basierten Dateispeicher gehostet wird. [Sie hängen den PVC (Persistent Volume Claim)](cs_storage.html#app_volume_mount) als Datenträger an Ihre Bereitstellung an, damit die Container den Datenträger lesen und beschreiben können. </p><p>Persistent Volumes (persistente Datenträger) werden in dem Rechenzentrum bereitgestellt, in dem sich der Workerknoten befindet. Daten können von derselben Replikatgruppe oder von verschiedenen Implementierungen im selben Cluster gemeinsam genutzt werden. Daten können nicht von Clustern gemeinsam genutzt werden, die sich in verschiedenen Rechenzentren oder Regionen befinden. </p><p>Standardmäßig wird keine automatische Sicherung des NFS-Speichers erstellt. Mit den verfügbaren [Sicherungs- und Wiederherstellungsverfahren](cs_storage.html#backup_restore) können Sie regelmäßige Sicherungen für Ihren Cluster konfigurieren. Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Bereitstellungen zugegriffen werden, an die der Datenträger angehängt ist. </p><p><strong>Hinweis:</strong> Die Speicherung in persistenten NFS-Dateifreigaben wird monatlich berechnet. Wenn Sie persistenten Speicher für Ihren Cluster einrichten und diesen unverzüglich nach der Einrichtung entfernen, bezahlen Sie trotzdem die monatliche Gebühr für den persistenten Speicher, auch wenn Sie ihn nur über einen kurzen Zeitraum genutzt haben.</p></td>
  </tr>
  <tr>
    <td>2. Cloud-Datenbankservice</td>
    <td>Mit dieser Option können Sie über einen {{site.data.keyword.Bluemix_notm}}-Cloud-Service für Datenbanken (z. B. [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant)) Daten persistent speichern und auf sie zugreifen. Auf Daten, die mit dieser Option gespeichert wurden, kann in mehreren Clustern sowie an mehreren Standorten und Regionen zugegriffen werden. <p> Sie können entweder eine einzelne Datenbankinstanz konfigurieren, auf die alle Ihre Apps zugreifen, oder [mehrere Instanzen mit übergreifender Replikation in Rechenzentren einrichten](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery), um hohe Verfügbarkeit für die Daten bereitzustellen. In der IBM Cloudant NoSQL-Datenbank werden Daten nicht automatisch gesichert. Sie können die bereitgestellten [Sicherungs- und Wiederherstellungsverfahren](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) verwenden, um Ihre Daten vor Siteausfällen zu schützen.</p> <p> Um einen Service in Ihrem Cluster zu verwenden, [binden Sie den {{site.data.keyword.Bluemix_notm}}-Service](cs_integrations.html#adding_app) an einen Namensbereich in Ihrem Cluster. Bei diesem Vorgang wird ein geheimer Kubernetes-Schlüssel erstellt. Der geheime Kubernetes-Schlüssel enthält vertrauliche Informationen zu dem Service (z. B. die URL für den Service, Ihren Benutzernamen und das Kennwort). Sie können den geheimen Schlüssel als Datenträger für geheime Schlüssel an Ihren Pod anhängen und unter Verwendung der im geheimen Schlüssel gespeicherten Berechtigungsnachweise auf den Service zugreifen. Durch Anhängen des Datenträgers für geheime Schlüssel an andere Pods können Sie Daten podübergreifend gemeinsam nutzen. Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Pods zugegriffen werden, an die der Datenträger für geheime Schlüssel angehängt ist. <p>Die meisten {{site.data.keyword.Bluemix_notm}}-Datenbankservices stellen Plattenspeicher für ein geringes Datenvolumen gebührenfrei zur Verfügung, damit Sie dessen Funktionen testen können.</p></td>
  </tr>
  <tr>
    <td>3. Lokale Datenbank</td>
    <td>Wenn Ihre Daten aus rechtlichen Gründen lokal gespeichert werden müssen, können Sie eine [VPN-Verbindung zur lokalen Datenbank einrichten](cs_vpn.html#vpn) und die in Ihrem Rechenzentrum vorhandenen Sicherungs- und Wiederherstellungsverfahren verwenden.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tabelle. Optionen für persistentes Speichern von Daten bei Bereitstellungen in Kubernetes-Clustern" caption-side="top"}

<br />



## Vorhandene NFS-Dateifreigaben in Clustern verwenden
{: #existing}

Wenn bereits NFS-Dateifreigaben in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) vorhanden sind, die Sie mit Kubernetes verwenden möchten, können Sie dies tun, indem Sie einen persistenten Datenträger (PV) für Ihren vorhandenen Speicher erstellen.{:shortdesc}

Ein persistenter Datenträger (PV) ist eine Kubernetes-Ressource, die eine tatsächliche Speichereinheit darstellt, die in einem Rechenzentrum bereitgestellt wird. Persistente Datenträger abstrahieren die Details dazu, wie ein bestimmter Speichertyp von IBM Cloud Storage bereitgestellt wird. Um einen persistenten Datenträger (PV) an Ihren Cluster anzuhängen (mount), müssen Sie persistenten Speicher für Ihren Pod anfordern, indem Sie einen PVC (Persistent Volume Claim) erstellen. Das folgende Diagramm zeigt die Beziehung zwischen PVs und PVCs. 

![Erstellen von Persistent Volumes und Persistent Volume Claims](images/cs_cluster_pv_pvc.png)

 Wenn Sie, wie im Diagramm dargestellt, die Verwendung vorhandener NFS-Dateifreigaben mit Kubernetes ermöglichen möchten, müssen Sie PVs (Persistent Volumes) mit einer bestimmten Größe und einem bestimmten Zugriffsmodus erstellen und dann einen PVC (Persistent Volume Claim) erstellen, der mit der Angabe des PV (Persistent Volume) übereinstimmt. Wenn PV (Persistent Volume) und PVC (Persistent Volume Claim) übereinstimmen, werden sie aneinander gebunden. Vom Clusterbenutzer können nur gebundene PVCs (Persistent Volume Claims) verwendet werden, um den Datenträger an eine Bereitstellung anzuhängen. Dieser Prozess wird als statische Bereitstellung von persistentem Speicher bezeichnet.

Stellen Sie zunächst sicher, dass Sie über eine NFS-Dateifreigabe verfügen, die Sie zum Erstellen Ihres PV (Persistent Volume) verwenden können. Wenn Sie beispielsweise zuvor [einen PVC mit der Speicherklassenrichtlinie `retain` erstellt haben](#create), können Sie die beibehaltenen Daten in der vorhandenen NFS-Datei für diesen neuen PVC zur gemeinsamen Nutzung verwenden. 

**Hinweis:** Eine statische Bereitstellung von persistentem Speicher gilt nur für vorhandene NFS-Dateifreigaben. Wenn keine NFS-Dateifreigaben vorhanden sind, können Clusterbenutzer den Prozess der [dynamischen Bereitstellung](cs_storage.html#create) nutzen, um Persistent Volumes (PVs) hinzuzufügen.

Führen Sie die folgenden Schritte aus, um ein PV und einen übereinstimmenden PVC zu erstellen. 

1.  Suchen Sie in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) nach der ID und dem Pfad der NFS-Dateifreigabe, in der Sie Ihr PV-Objekt erstellen möchten. Autorisieren Sie darüber hinaus den Dateispeicher für die Teilnetze im Cluster. Diese Autorisierung erteilt Ihrem Cluster Zugriff auf den Speicher.
    1.  Melden Sie sich bei Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) an.
    2.  Klicken Sie auf **Speicher**.
    3.  Klicken Sie auf **Dateispeicher** und wählen Sie im Menü **Aktionen** die Option zum Autorisieren des Hosts**** aus.
    4.  Wählen Sie **Teilnetze** aus.
    5.  Wählen Sie in der Dropdown-Liste das private VLAN-Teilnetz aus, mit dem der Workerknoten verbunden ist. Um das Teilnetz Ihres Workerknotens zu finden, führen Sie den Befehl `bx cs workers <cluster_name>` aus und vergleichen die `Private IP` Ihres Workerknotens mit dem Teilnetz, das Sie in der Dropdown-Liste gefunden haben. 
    6.  Klicken Sie auf **Übergeben**.
    6.  Klicken Sie auf den Namen des Dateispeichers.
    7.  Notieren Sie sich den Inhalt des Felds **Mountpunkt**. Das Feld hat dieses Format: `<server>:/<path>`.
2.  Erstellen Sie eine Speicherkonfigurationsdatei für Ihr PV (Persistent Volume). Schließen Sie die im Feld **Mountpunkt** des Dateispeichers angegebenen Server und Pfad ein.

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
       path: "/IBM01SEV8491247_0908/data01"
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
    <td>Geben Sie den Namen des PV-Objekts ein, das Sie erstellen wollen.</td>
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Geben Sie die Speichergröße der vorhandenen NFS Dateifreigabe ein. Die Größe des Speichers muss in Gigabyte angegeben werden, z. B. 20Gi (20 GB) oder 1000Gi (1 TB), und sie muss mit der Größe der vorhandenen Dateifreigabe übereinstimmen.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Der Zugriffsmodus definiert, auf welche Art ein Persistent Volume Claim (PVC) an einen Workerknoten angehängt werden kann. <ul><li>ReadWriteOnce (RWO): Das Persistent Volume kann nur an die Bereitstellungen in einem einzigen Workerknoten angehängt werden. Die an dieses Persistent Volume angehängten Container können auf diesen Datenträger schreiben und ihn lesen. </li><li>ReadOnlyMany (ROX): Das PV (Persistent Volume) kann an Bereitstellungen angehängt werden, die auf verschiedenen Workerknoten gehostet sind. Die an dieses PV (Persistent Volume) angehängten Bereitstellungen können den Datenträger nur lesen. </li><li>ReadWriteMany (RWX): Dieses PV (Persistent Volume) kann an Bereitstellungen angehängt werden, die auf verschiedenen Workerknoten gehostet sind. Bereitstellungen, die an dieses PV (Persistent Volume) angehängt werden, können den Datenträger lesen und ihn beschreiben.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Geben Sie die Server-ID der NFS-Dateifreigabe ein.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Geben Sie den Pfad zur NFS-Dateifreigabe ein, in der Sie das PV-Objekt erstellen möchten. </td>
    </tr>
    </tbody></table>

3.  Erstellen Sie das PV-Objekt in Ihrem Cluster.

    ```
    kubectl apply -f <yaml-pfad>
    ```
    {: pre}

    Beispiel

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Überprüfen Sie, dass das PV erstellt wurde. 

    ```
    kubectl get pv
    ```
    {: pre}

5.  Erstellen Sie eine weitere Konfigurationsdatei, um Ihren Persistent Volume Claim (PVC) zu erstellen. Damit der Persistent Volume Claim (PVC) mit dem zuvor erstellten Persistent Volume-Objekt übereinstimmt, müssen Sie denselben Wert für `storage` und `accessMode` auswählen. Das Feld `storage-class` muss leer sein. Wenn eines dieser Felder nicht mit dem PV (Persistent Volume) übereinstimmt, wird stattdessen automatisch ein neues PV erstellt.

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

6.  Erstellen Sie Ihren PVC.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Überprüfen Sie, ob Ihr PVC erstellt und an das PV-Objekt gebunden wurde. Dieser Prozess kann einige Minuten dauern.

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


Sie haben erfolgreich ein PV-Objekt (Persistent Volume-Objekt) erstellt und an einen PVC (Persistent Volume Claim) gebunden. Clusterbenutzer können jetzt den [PVC (Persistent Volume Claim) an ihre Bereitstellungen anhängen](#app_volume_mount) und mit dem Lesen und Schreiben in dem PV-Objekt (Persistent Volume-Objekt) beginnen.

<br />




## NFS-Dateispeicher zu Apps hinzufügen
{: #create}

Um NFS-Dateispeicher für Ihren Cluster bereitzustellen, erstellen Sie einen PVC (Persistent Volume Claim). Anschließend hängen Sie diese Anforderung (PVC) an ein PV (Persistent Volume) an, um sicherzustellen, dass Daten auch dann verfügbar sind, wenn die Pods ausfallen oder abgeschaltet werden.
{:shortdesc}

Der NFS-Dateispeicher, auf den sich das PV (Persistent Volume) stützt, wird von IBM in Gruppen zusammengefasst, um hohe Verfügbarkeit für Ihre Daten bereitzustellen. Die Speicherklassen beschreiben die Typen der verfügbaren Speicherangebote und definieren Aspekte wie die Datenaufbewahrungsrichtlinie, die Größe in Gigabyte und die E/A-Operationen pro Sekunde (IOPS), wenn Sie Ihren persistenten Datenträger (PV) erstellen.



**Hinweis vor der Ausführung**: Wenn Sie über eine Firewall verfügen, [gewähren Sie Egress-Zugriff](cs_firewall.html#pvc) für die IBM Cloud Infrastructure (SoftLayer)-IP-Bereiche der Standorte (Rechenzentren), in denen sich Ihre Cluster befinden, damit Sie Persistent Volume Claims (PVCs) erstellen können.

Gehen Sie wie folgt vor, um einen persistenter Speicher hinzuzufügen: 

1.  Überprüfen Sie die verfügbaren Speicherklassen. {{site.data.keyword.containerlong}} stellt vordefinierte Speicherklassen für NFS-Dateispeicher zur Verfügung, sodass der Clusteradministrator keine Speicherklassen erstellen muss.
Die Speicherklasse `ibmc-file-bronze` ist identisch mit der Speicherklasse `default`.

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

    **Tipp:** Wenn Sie die Standardspeicherklasse ändern möchten, führen Sie den Befehl `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` aus und ersetzen Sie `<storageclass>` durch den Namen der Speicherklasse. 

2.  Legen Sie fest, ob Sie Ihre Daten und die NFS-Dateifreigabe nach dem Löschen des PVC speichern möchten.
    - Wenn Sie die Daten aufbewahren möchten, dann wählen Sie eine Speicherklasse vom Typ `retain` aus. Wenn Sie den PVC löschen, wird das PV entfernt. Die NFS-Datei  und Ihre Daten sind jedoch noch immer im Konto von IBM Cloud Infrastructure (SoftLayer) vorhanden. Um später auf diese Daten in Ihrem Cluster zugreifen zu können, erstellen Sie einen PVC und ein übereinstimmendes PV, das auf Ihre vorhandene [NFS-Datei](#existing) verweist.
    - Wenn die Daten und die NFS-Dateifreigabe bei der Löschung des PVC ebenfalls gelöscht werden sollen, dann wählen Sie eine Speicherklasse ohne `retain` aus.

3.  **Wenn Sie eine Speicherklasse wie 'bronze', 'silver' oder 'gold' ausgewählt haben**: Erhalten Sie einen [Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage) mit einem definierten Wert für die E/A-Operationen pro Sekunde (IOPS) pro GB für jede Klasse. Sie können den Gesamtwert für IOPS festlegen, indem Sie eine Größe innerhalb des verfügbaren Bereichs auswählen. Sie können innerhalb des zulässigen Größenbereichs (z. B. 20 Gi, 256 Gi, 11854 Gi) eine beliebige ganze Zahl von Gigabyte-Größen auswählen. Wenn Sie beispielsweise eine Größe von 1000Gi für die Dateifreigabe in der Speicherklasse 'silver' mit 4 IOPS pro GB auswählen, verfügt Ihr Datenträger insgesamt über 4000 IOPS. Je höher der IOPS-Wert Ihres persistenten Datenträgers (PV), umso höher die Verarbeitungsgeschwindigkeit für Ein- und Ausgabeoperationen. In der folgenden Tabelle werden die IOPS pro Gigabyte und der Größenbereich für jede Speicherklasse beschrieben.

    <table>
         <caption>Tabelle der Größenbereiche der Speicherklasse und der IOPS pro Gigabyte</caption>
         <thead>
         <th>Speicherklasse</th>
         <th>IOPS pro Gigabyte</th>
         <th>Größenbereich in Gigabyte</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze (Standardwert)</td>
         <td>2 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Silver</td>
         <td>4 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Gold</td>
         <td>10 IOPS/GB</td>
         <td>20-4000 Gi</td>
         </tr>
         </tbody></table>

    <p>**Beispielbefehl zum Anzeigen der Details der Speicherklasse**:</p>

    <pre class="pre">kubectl describe storageclasses ibmc-file-silver</pre>

4.  **Wenn Sie die angepasste Speicherklasse auswählen**: Sie erhalten einen [Leistungsspeicher![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage) und haben mehr Kontrolle über die Auswahl der Kombination von IOPS und Größe. Wenn Sie zum Beispiel eine Größe von 40Gi für Ihren PVC auswählen, können Sie IOPS auswählen, die ein Vielfaches von 100 sind und im Bereich von 100 - 2000 IOPS liegen. Die folgende Tabelle zeigt Ihnen, aus welchem IOPS-Bereich Sie abhängig von der ausgewählten Größe auswählen können. 

    <table>
         <caption>Tabelle mit Größenbereichen und IOPS für angepasste Speicherklassen</caption>
         <thead>
         <th>Größenbereich in Gigabyte</th>
         <th>IOPS-Bereich in Vielfachen von 100</th>
         </thead>
         <tbody>
         <tr>
         <td>20-39 Gi</td>
         <td>100-1000 IOPS</td>
         </tr>
         <tr>
         <td>40-79 Gi</td>
         <td>100-2000 IOPS</td>
         </tr>
         <tr>
         <td>80-99 Gi</td>
         <td>100-4000 IOPS</td>
         </tr>
         <tr>
         <td>100-499 Gi</td>
         <td>100-6000 IOPS</td>
         </tr>
         <tr>
         <td>500-999 Gi</td>
         <td>100-10000 IOPS</td>
         </tr>
         <tr>
         <td>1000-1999 Gi</td>
         <td>100-20000 IOPS</td>
         </tr>
         <tr>
         <td>2000-2999 Gi</td>
         <td>200-40000 IOPS</td>
         </tr>
         <tr>
         <td>3000-3999 Gi</td>
         <td>200-48000 IOPS</td>
         </tr>
         <tr>
         <td>4000-7999 Gi</td>
         <td>300-48000 IOPS</td>
         </tr>
         <tr>
         <td>8000-9999 Gi</td>
         <td>500-48000 IOPS</td>
         </tr>
         <tr>
         <td>10000-12000 Gi</td>
         <td>1000-48000 IOPS</td>
         </tr>
         </tbody></table>

    <p>**Beispielbefehl zum Anzeigen der Details für angepasste Speicherklassen**:</p>

    <pre class="pre">kubectl describe storageclasses ibmc-file-retain-custom</pre>

5.  Entscheiden Sie, ob Sie die Abrechnung auf Stundenbasis oder monatlich erhalten möchten. Die Rechnung erfolgt standardmäßig pro Monat. 

6.  Erstellen Sie eine Konfigurationsdatei, um Ihren PVC zu definieren und speichern Sie die Konfiguration als `.yaml`-Datei. 

    -  **Beispiel für die Speicherlassen 'bronze', 'silver' und 'gold'**:
       Die folgende `.yaml`-Datei erstellt eine Anforderung mit dem Namen `mypvc` der Speicherklasse `"ibmc-file-silver"` und einer Abrechnung auf Stundenbasis (`"hourly"`) mit einer Größe von `24Gi`. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Beispiel für angepasste Speicherklassen**:
       Die folgende `.yaml`-Datei erstellt eine Anforderung mit dem Namen `mypvc` der Speicherklasse `ibmc-file-retain-custom` und einer monatlichen Abrechnung (`"monthly"`) mit einer Größe von `45Gi` und `"300"` IOPS.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 45Gi
             iops: "300"
        ```
        {: codeblock}

        <table>
	      <caption>Tabelle. Erklärung der Komponenten der YAML-Datei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Geben Sie den Namen des PVC ein.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>Geben Sie eine Speicherklasse für das PV an:
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 E/A-Operationen pro Sekunde pro GB.</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver: 4 E/A-Operationen pro Sekunde pro GB.</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold: 10 E/A-Operationen pro Sekunde pro GB.</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom: Mehrere Werte für E/A-Operationen pro Sekunde verfügbar.</li></ul>
          <p>Wenn keine Speicherklasse angegeben ist, wird das PV (Persistent Volume) mit der Standardspeicherklasse erstellt. </p><p>**Tipp:** Wenn Sie die Standardspeicherklasse ändern möchten, führen Sie den Befehl <code>kubectl patch storageclass &lt;speicherklasse&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> aus und ersetzen Sie <code>&lt;speicherklasse&gt;</code> durch den Namen der Speicherklasse. </p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Geben Sie die Häufigkeit an, mit der Ihre Speicherrechnung berechnet wird, monatlich ("monthly") oder stündlich ("hourly"). Der Standardwert ist "monthly".</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Geben Sie die Größe des Dateispeichers in Gigabytes (Gi) an. Wählen Sie eine ganze Zahl innerhalb des zulässigen Größenbereichs. </br></br><strong>Anmerkung:</strong> Nachdem Ihr Speicher bereitgestellt wurde, können Sie die Größe Ihrer NFS-Dateifreigabe nicht mehr ändern. Stellen Sie sicher, dass Sie eine Größe angeben, die dem Umfang der Daten entspricht, die Sie speichern möchten. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Diese Option gilt nur für angepasste Speicherklassen (`ibmc-file-custom / ibmc-file-retain-custom`). Geben Sie die Gesamtzahl der E/A-Operationen pro Sekunde für den Speicher an, indem Sie ein Vielfaches von 100 innerhalb des zulässigen Bereichs auswählen. Führen Sie den folgenden Befehl aus, um alle Speicherklassen anzuzeigen: `kubectl describe storageclasses <storageclass>`. Wenn Sie einen Wert für die E/A-Operationen pro Sekunde auswählen, der nicht aufgelistet ist, wird der Wert aufgerundet.</td>
        </tr>
        </tbody></table>

7.  Erstellen Sie den PVC.

    ```
    kubectl apply -f <lokaler_dateipfad>
    ```
    {: pre}

8.  Überprüfen Sie, ob Ihr PVC erstellt und an das PV gebunden wurde. Dieser Prozess kann einige Minuten dauern.

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

9.  {: #app_volume_mount}Erstellen Sie eine `.yaml`-Konfigurationsdatei, um den PVC an Ihre Bereitstellung anzuhängen. 

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>Tabelle. Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>Eine Bezeichnung für die Bereitstellung.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>Eine Bezeichnung für Ihre App.</td>
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
    <td>Der Name des PVCs, die Sie als Ihren Datenträger verwenden wollen. Wenn Sie den Datenträger an den Pod anhängen (mount), erkennt Kubernetes das PV, das an den PVC gebunden ist, und  ermöglicht dem Benutzer das Lesen von und Schreiben auf das PV. </td>
    </tr>
    </tbody></table>

10.  Bereitstellung erstellen und PVC anhängen (mount) 
     ```
     kubectl apply -f <lokaler_yaml-pfad>
     ```
     {: pre}

11.  Überprüfen Sie, dass der Datenträger erfolgreich angehängt wurde.

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




## Lösungen zum Sichern und Wiederherstellen für NFS-Dateifreigaben konfigurieren
{: #backup_restore}

Dateifreigaben werden an denselben Standort (Rechenzentrum) bereitgestellt wie Ihr Cluster und von {{site.data.keyword.IBM_notm}} in Clustern zusammengefasst, um eine hohe Verfügbarkeit zu gewährleisten. Dateifreigaben werden jedoch nicht automatisch gesichert und sind möglicherweise nicht zugänglich, wenn der gesamte Standort fehlschlägt. Um Ihre Daten vor Verlust oder Beschädigung zu schützen, können Sie regelmäßige Sicherungen in Ihren NFS-Dateifreigaben konfigurieren, mit denen Sie bei Bedarf Daten wiederherstellen können.
{: shortdesc}

Überprüfen Sie die folgenden Optionen zum Sichern und Wiederherstellen Ihrer NFS-Dateifreigaben: 

<dl>
  <dt>Regelmäßige Snapshots Ihrer NFS-Dateifreigabe konfigurieren</dt>
  <dd>Sie können [regelmäßige Snapshots](/docs/infrastructure/FileStorage/snapshots.html#working-with-snapshots) für Ihre NFS-Dateifreigabe konfigurieren. Dies ist ein schreibgeschütztes Image einer NFS-Dateifreigabe, die den Status des Datenträgers zu einem bestimmten Zeitpunkt erfasst. Snapshots werden in derselben Dateifreigabe innerhalb desselben Standorts gespeichert. Sie können Daten von einem Snapshot wiederherstellen, falls ein Benutzer versehentlich wichtige Daten von dem Datenträger entfernt. </dd>
  <dt>Snapshots in einer NFS-Dateifreigabe an einem anderen Standort (Rechenzentrum) replizieren</dt>
 <dd>Um Daten vor einem Standortausfall zu schützen, können Sie in einer NFS-Dateifreigabe, die an einem anderen Standort konfiguriert ist, [Snapshots replizieren](/docs/infrastructure/FileStorage/replication.html#working-with-replication). Daten können von einer primären NFS-Dateifreigabe nur auf die Sicherung der NFS-Dateifreigabe repliziert werden. Sie können eine replizierte NFS-Dateifreigabe nicht an einen Cluster anhängen (mount). Wenn Ihre primäre NFS-Dateifreigabe fehlschlägt, können Sie Ihre Sicherung der NFS-Dateifreigabe manuell als primäre NFS-Dateifreigabe festlegen. Anschließend können Sie sie an den Cluster anhängen (mount). Nachdem Ihre primäre NFS-Dateifreigabe wiederhergestellt wurde, können Sie die Daten aus der Sicherung der NFS-Dateifreigabe wiederherstellen. </dd>
  <dt>Daten in Object Storage sichern</dt>
  <dd>Sie können den Befehl [**ibm-backup-restore image**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) verwenden, damit ein Pod für Sicherung und Wiederherstellung in Ihrem Cluster den Betrieb aufnimmt. Dieser Pod enthält ein Script zur Ausführung einer einmaligen oder regelmäßigen Sicherung für alle PVCs (Persistent Volume Claims) in Ihrem Cluster. Die Daten werden in Ihrer {{site.data.keyword.objectstoragefull}}-Instanz gespeichert, die Sie an einem Standort konfiguriert haben. Damit Ihre Daten besser verfügbar sind und um Ihre App vor einem Standortausfall zu schützen, konfigurieren Sie eine zweite {{site.data.keyword.objectstoragefull}}-Instanz und replizieren die Daten über die Standorte hinweg. Falls Sie Daten von Ihrer {{site.data.keyword.objectstoragefull}}-Instanz wiederherstellen müssen, verwenden Sie das Wiederherstellungsscript, das mit dem Image bereitgestellt wird. </dd>
  </dl>

## Zugriff für Benutzer ohne Rootberechtigung auf NFS-Dateispeicher hinzufügen
{: #nonroot}

Standardmäßig haben Benutzer ohne Rootberechtigung keinen Schreibzugriff auf den Datenträgermountpfad für NFS-gesicherte Speicher. Einige allgemeine Images, wie z. B. Jenkins und Nexus3, geben einen Benutzer ohne Rootberechtigung an, der Eigner des Mountpfads in der Dockerfile ist. Wenn Sie einen Container aus dieser Dockerfileerstellen, schlägt die Erstellung des Containers aufgrund unzureichender Berechtigungen für den Benutzer ohne Rootberechtigung auf dem Mountpfad fehl. Um Schreibberechtigung zu erteilen, können Sie die Dockerfile so ändern, dass der Benutzer ohne Rootberechtigung temporär zur Stammbenutzergruppe hinzugefügt wird, bevor die Mountpfadberechtigungen geändert werden, oder Sie verwenden einen Init-Container.{:shortdesc}

Wenn Sie ein Helm-Diagramm verwenden, um ein Image für einen Benutzer ohne Rootberechtigung bereitzustellen, der Schreibberechtigungen auf die NFS-Dateifreigabe erhalten soll, bearbeiten Sie zuerst die Helm-Bereitstellung, um einen Init-Container zu verwenden.
{:tip}



Wenn Sie einen [Init-Container![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externenLink")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) in Ihre Bereitstellung einschließen, können Sie einem Benutzer ohne Rootberechtigung, der in Ihrer Dockerfile angegeben ist, Schreibberechtigungen für den Datenträgermountpfad innerhalb des Containers erteilen, der auf Ihre NFS-Dateifreigabe verweist. Der Init-Container startet, bevor Ihr App-Container startet. Der Init-Container erstellt den Datenträgermountpfad innerhalb des Containers, ändert den Mountpfad, sodass der richtige Benutzer (ohne Rootberechtigung) Eigner ist, und schließt den Pfad wieder. Anschließend startet Ihr App-Container, der den Benutzer ohne Rootberechtigung enthält, der in den Mountpfad schreiben muss. Da der Benutzer ohne Rootberechtigung bereits Eigner des Pfads ist, ist das Schreiben in den Mountpfad erfolgreich. Wenn Sie keinen Init-Container verwenden möchten, können Sie die Dockerfile ändern, um Benutzern ohne Rootberechtigung Zugriff auf den NFS-Dateispeicher hinzuzufügen. 

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

1.  Öffnen Sie die Dockerfile für Ihre App und rufen Sie die Benutzer-ID (UID) und die Benutzer-ID (GID) von dem Benutzer ab, dem Sie Schreibzugriff auf den Datenträgermountpfad erteilen möchten. Im Beispiel einer Jenkins-Dockerfile lautet die Information:
    - UID: `1000`
    - GID: `1000`

    **Beispiel**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  Fügen Sie persistenten Speicher zu Ihrer App hinzu, indem Sie einen PVC (Persistent Volume Claim) erstellen. Dieses Beispiel verwendet die Speicherklasse `ibmc-file-bronze`. Um verfügbare Speicherklassen zu überprüfen, führen Sie den folgenden Befehl aus: `kubectl get storageclasses`.

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

3.  Erstellen Sie den PVC.

    ```
    kubectl apply -f <lokaler_dateipfad>
    ```
    {: pre}

4.  Fügen Sie in Ihrer `.yaml`-Bereitstellungsdatei den Init-Container hinzu. Beziehen Sie die UID und GID ein, die Sie zuvor abgerufen haben. 

    ```
    initContainers:
    - name: initContainer # Kann durch einen beliebigen Namen ersetzt werden
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Ersetzen Sie UID und GID durch Werte aus der Dockerfile
      volumeMounts:
      - name: volume #  Kann durch einen beliebigen Namen ersetzt werden
        mountPath: /mount # Muss mit dem Moountpfad in der args-Zeile übereinstimmen
    ```
    {: codeblock}

    **Beispiel** für eine Jenkins-Bereitstellung

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  Erstellen Sie den Pod und hängen Sie den PVC an Ihren Pod an. 

    ```
    kubectl apply -f <lokaler_yaml-pfad>
    ```
    {: pre}

6. Überprüfen Sie, ob der Datenträger erfolgreich an Ihren Pod angehängt wurde. Notieren Sie den Namen des Pod und den **Containers/Mounts**-Pfad. 

    ```
    kubectl describe pod <mein_pod>
    ```
    {: pre}

    **Beispielausgabe**:

    ```
    Name:		    mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (Referenz auf einen PersistentVolumeClaim im gleichen Namensbereich)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

7.  Melden Sie sich beim Pod an, indem Sie den Podnamen verwenden, den Sie zuvor notiert haben. 

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. Überprüfen Sie die Berechtigungen des Mountpfads Ihres Containers. In dem Beispiel ist der Mountpfad `/var/jenkins_home`.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **Beispielausgabe**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    Diese Ausgabe zeigt, dass die GID und UID von Ihrer Dockerfile (in diesem Beispiel `1000` und `1000`) Eigner des Mountpfads innerhalb des Containers sind. 


