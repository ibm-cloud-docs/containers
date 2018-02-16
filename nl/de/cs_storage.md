---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Daten durch Speicherung auf persistenten Datenträgern (Persistent Volumes, PV) sichern
{: #planning}

Ein Container ist designbedingt kurzlebig. Sie haben jedoch, wie im Diagramm dargestellt, die Wahl zwischen mehreren Optionen, um Daten für den Fall eines Container-Failovers persistent zu speichern und Daten zwischen mehreren Containern gemeinsam zu nutzen.
{:shortdesc}

**Hinweis**: Wenn Sie über eine Firewall verfügen, [gewähren Sie Egress-Zugriff](cs_firewall.html#pvc) für die IBM Cloud Infrastructure (SoftLayer)-IP-Bereiche der Standorte (Rechenzentren), in denen sich Ihre Cluster befinden, damit Sie Persistent Volume Claims erstellen können.

![Optionen für persistentes Speichern bei Bereitstellungen in Kubernetes-Clustern](images/cs_planning_apps_storage.png)

|Option|Beschreibung|
|------|-----------|
|Option 1: Verwenden von `/emptyDir`, um Daten unter Verwendung des verfügbaren Plattenspeichers auf dem Workerknoten zu speichern<p>Dieses Feature ist nur für Lite-Cluster und Standardcluster verfügbar.</p>|Bei dieser Option können Sie auf dem Plattenspeicher Ihres Workerknotens einen leeren Datenträger erstellen, der einem Pod zugewiesen ist. Der Container in diesem Pod kann auf diesen Datenträger schreiben und von ihm lesen. Da der Datenträger einem ganz bestimmten Pod zugewiesen ist, können Daten nicht mit anderen Pods in einer Replikatgruppe gemeinsam genutzt werden.<p>Ein `/emptyDir`-Datenträger und die in ihm enthaltenen Daten werden entfernt, sobald der zugewiesene Pod endgültig vom Workerknoten gelöscht wird.</p><p>**Hinweis:** Wenn der Container im Pod ausfällt, sind die im Datenträger enthaltenen Daten trotzdem noch auf dem Workerknoten verfügbar.</p><p>Weitere Informationen finden Sie unter [Kubernetes-Datenträger ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/).</p>|
|Option 2: Erstellen eines Persistent Volume Claims (PVCs), um NFS-basierten persistenten Speicher für die Bereitstellung einzurichten<p>Dieses Feature ist nur für Standardcluster verfügbar.</p>|<p>Diese Option bietet persistente Speicherung von App- und Containerdaten durch Persistent Volumes (PVs). Die Volumes sind in einem [NFS-basierten Endurance- und Performance-Dateispeicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/details) gehostet. Der Dateispeicher ist im Ruhezustand verschlüsselt und Sie können Replikate der gespeicherten Daten erstellen.</p> <p>Sie erstellen einen [Persistent Volume Claim](cs_storage.html) (PVC), um eine Anforderung für NFS-basierten Dateispeicher zu stellen. {{site.data.keyword.containershort_notm}} stellt vordefinierte Speicherklassen bereit, die den Größenbereich des Speichers, die E/A-Operationen pro Sekunde, die Löschrichtlinie sowie die Lese- und Schreibberechtigungen für den Datenträger definieren. Beim Erstellen Ihres Persistent Volume Claims können Sie zwischen diesen Speicherklassen wählen. Nachdem Sie einen Persistent Volume Claim (PVC) übergeben haben, stellt {{site.data.keyword.containershort_notm}} dynamisch ein Persistent Volume (PV) bereit, das in NFS-basiertem Dateispeicher gehostet wird. [Sie hängen den Persistent Volume Claim (PVC)](cs_storage.html#create) als Datenträger an Ihre Bereitstellung an, damit die Container den Datenträger lesen und beschreiben können. Persistent Volumes (PV) können in derselben Replikatgruppe oder von mehreren Bereitstellungen in demselben Cluster gemeinsam genutzt werden.</p><p>Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Bereitstellungen zugegriffen werden, an die der Datenträger angehängt ist. Persistent Volume Claims (PVCs) werden im persistenten Speicher gehostet, Sicherungen sind jedoch keine verfügbar. Falls Sie eine Sicherung Ihrer Daten benötigen, können Sie eine manuelle Sicherung erstellen.</p><p>**Hinweis:** Die Speicherung in persistenten NFS-Dateifreigaben wird monatlich berechnet. Wenn Sie persistenten Speicher für Ihren Cluster einrichten und diesen unverzüglich nach der Einrichtung entfernen, bezahlen Sie trotzdem die monatliche Gebühr für den persistenten Speicher, auch wenn sie ihn nur über einen kurzen Zeitraum genutzt haben.</p>|
|Option 3: Binden eines {{site.data.keyword.Bluemix_notm}}-Datenbankservice an Ihren Pod<p>Dieses Feature ist nur für Lite-Cluster und Standardcluster verfügbar.</p>|Bei dieser Option können Sie unter Verwendung eines {{site.data.keyword.Bluemix_notm}}-Cloud-Service für Datenbanken Daten persistent speichern und auf diese zugreifen. Wenn Sie den {{site.data.keyword.Bluemix_notm}}-Service an einen Namensbereich in Ihrem Cluster anhängen, wird ein geheimer Kubernetes-Schlüssel erstellt. Der geheime Kubernetes-Schlüssel beherbergt vertrauliche Informationen zum Service wie zum Beispiel die URL zum Service, Ihren Benutzernamen und das zugehörige Kennwort. Sie können den geheimen Schlüssel als Datenträger für geheime Schlüssel an Ihren Pod anhängen und unter Verwendung der im geheimen Schlüssel gespeicherten Berechtigungsnachweise auf den Service zugreifen. Durch Anhängen des Datenträgers für geheime Schlüssel an andere Pods können Sie Daten podübergreifend gemeinsam nutzen.<p>Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Pods zugegriffen werden, an die der Datenträger für geheime Schlüssel angehängt ist.</p><p>Die meisten {{site.data.keyword.Bluemix_notm}}-Datenbankservices stellen Plattenspeicher für ein geringes Datenvolumen gebührenfrei zur Verfügung, damit Sie dessen Funktionen testen können.</p><p>Weitere Informationen zum Binden eines {{site.data.keyword.Bluemix_notm}}-Service an einen Pod finden Sie unter [{{site.data.keyword.Bluemix_notm}}-Services für Apps in {{site.data.keyword.containershort_notm}} hinzufügen](cs_integrations.html#adding_app).</p>|
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

Der NFS-Dateispeicher, auf den sich das Persistent Volume stützt, wird von IBM in Gruppen zusammengefasst, um hohe Verfügbarkeit für Ihre Daten bereitzustellen.

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

2.  Entscheiden Sie, ob die Daten und die NFS-Dateifreigabe nach der Löschung des PVC gespeichert werden sollen. Wenn Sie die Daten aufbewahren möchten, dann wählen Sie eine Speicherklasse vom Typ `retain` aus. Wenn die Daten und die Dateifreigabe bei der Löschung des PVC ebenfalls gelöscht werden sollen, dann wählen Sie eine Speicherklasse ohne `retain` aus.

3.  Überprüfen Sie die E/A-Operationen pro Sekunde (IOPS) für eine Speicherklasse und die verfügbaren Speichergrößen.

    - Die Speicherklassen 'bronze', 'silver' und 'gold' verwenden [Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage) und verfügen für jede Klasse über einen einzigen definierten Wert für die E/A-Operationen pro Sekunde pro GB. Der Gesamtwert der E/A-Operationen pro Sekunde hängt von der Größe des Speichers ab. Beispiel: 1000Gi pvc at 4 IOPS per GB ergibt insgesamt 4000 E/A-Operationen pro Sekunde (IOPS).

      ```
      kubectl describe storageclasses ibmc-file-silver
      ```
      {: pre}

      Das Feld **Parameters** gibt die E/A-Operationen pro Sekunde pro GB für die Speicherklasse und die verfügbaren Größen in Gigabyte an.

      ```
      Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
      ```
      {: screen}

    - Die angepassten Speicherklassen verwenden [Leistungsspeicher  ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage) und verfügen über diskrete Optionen für die Gesamtzahl der E/A-Operationen pro Sekunde und die Größe.

      ```
      kubectl describe storageclasses ibmc-file-retain-custom
      ```
      {: pre}

      Das Feld **Parameters** gibt die E/A-Operationen pro Sekunde für die Speicherklasse und die verfügbaren Größen in Gigabyte an. Beispiel: Mit 40Gi pvc können E/A-Operationen pro Sekunde ausgewählt werden, die ein Vielfaches von 100 sind und im Bereich zwischen 100 - 2000 E/A-Operationen pro Sekunde liegen.

      ```
      Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
      ```
      {: screen}

4.  Erstellen Sie eine Konfigurationsdatei, um Ihren Persistent Volume Claim (PVC) zu definieren, und speichern Sie die Konfiguration als Datei mit der Erweiterung `.yaml`.

    Beispiel für die Klassen 'bronze', 'silver' und 'gold':

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc-name>
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

    Beispiel für angepasste Klassen:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc-name>
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
      <li>ibmc-file-custom / ibmc-file-retain-custom: Mehrere Werte für E/A-Operationen pro Sekunde verfügbar.

    </li> Wenn keine Speicherklasse angegeben ist, wird das Persistent Volume mit der Speicherklasse 'bronze' erstellt.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Wenn Sie eine Größe angeben, die nicht aufgelistet ist, wird automatisch aufgerundet. Wenn Sie eine Größe angeben, die die maximale angegebene Größe überschreitet, wird automatisch auf die nächstkleinere Größe abgerundet.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Diese Option gilt nur für ibmc-file-custom / ibmc-file-retain-custom. Geben Sie die Gesamtzahl der E/A-Operationen pro Sekunde für den Speicher an. Führen Sie `kubectl describe storageclasses ibmc-file-custom` aus, um alle Optionen anzuzeigen. Wenn Sie einen Wert für die E/A-Operationen pro Sekunde auswählen, der nicht aufgelistet ist, wird der Wert aufgerundet.</td>
    </tr>
    </tbody></table>

5.  Erstellen Sie den Persistent Volume Claim.

    ```
    kubectl apply -f <lokaler_dateipfad>
    ```
    {: pre}

6.  Überprüfen Sie, dass Ihr Persistent Volume Claim erstellt und an das Persistent Volume gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc <pvc-name>
    ```
    {: pre}

    Die Ausgabe ähnelt der folgenden:

    ```
    Name:  <pvc-name>
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
    <td><code>volumeMounts/mountPath</code></td>
    <td>Der absolute Pfad des Verzeichnisses, wo der Datenträger in der Bereitstellung angehängt wird.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>Der Name des Datenträgers, den Sie an Ihre Bereitstellung anhängen.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Der Name des Datenträgers, den Sie an Ihre Bereitstellung anhängen. Normalerweise ist dieser Name deckungsgleich mit <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>Der Name des PVCs, den Sie als Ihren Datenträger verwenden wollen. Wenn Sie den Datenträger an die Bereitstellung anhängen, erkennt Kubernetes das Persistent Volume, das an den Persistent Volume Claim gebunden ist, und ermöglicht dem Benutzer das Lesen von und Schreiben auf das Persistent Volume.</td>
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

Für {{site.data.keyword.containershort_notm}} ist der Standardeigner des Datenträgermountpfads der Eigner `nobody`. Falls bei NFS-Speicher der Eigner nicht lokal im Pod vorhanden ist, wird der Benutzer `nobody` erstellt. Die Datenträger sind so konfiguriert, dass der Rootbenutzer im Container erkannt wird. Bei manchen Apps ist dies der einzige Benutzer in einem Container. In vielen Apps wird jedoch ein anderer Benutzer ohne Rootberechtigung als `nobody` angegeben, der in den Container-Mountpfad schreibt. Für einige Apps ist es erforderlich, dass der Datenträger dem Rootbenutzer gehören muss. Normalerweise werden Apps den Rootbenutzer aus Sicherheitsgründen nicht. Wenn für Ihre App jedoch ein Rootbenutzer erforderlich ist, können Sie sich für entsprechende Unterstützung an den [{{site.data.keyword.Bluemix_notm}}-Support](/docs/support/index.html#contacting-support) wenden.


1.  Erstellen Sie eine Dockerfile in einem lokalen Verzeichnis. Die nachfolgende Beispiel-Dockerfile erstellt einen Benutzer ohne Rootberechtigung mit dem Namen `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

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


