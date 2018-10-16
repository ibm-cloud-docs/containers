---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Daten in IBM File Storage für IBM Cloud speichern
{: #file_storage}


## File Storage-Konfiguration festlegen
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} stellt vordefinierte Speicherklassen für File Storage zur Verfügung, die Sie verwenden können, um Dateispeicher mit einer bestimmten Konfiguration bereitzustellen.
{: shortdesc}

Jede Speicherklasse gibt den Typ des Dateispeichers an, den Sie bereitstellen, einschließlich der verfügbaren Größe, der E/A-Operationen pro Sekunde, des Dateisystems und der Aufbewahrungsrichtlinie.  

**Wichtig:** Stellen Sie sicher, dass die Speicherkonfiguration sorgfältig ausgewählt ist, damit genügend Kapazität zum Speichern Ihrer Daten vorhanden ist. Nachdem Sie mithilfe einer Speicherklasse einen bestimmten Typ von Speicher bereitgestellt haben, können Sie die Größe, den Typ, die E/A-Operationen pro Sekunde oder die Aufbewahrungsrichtlinie für die Speichereinheit nicht mehr ändern. Wenn Sie mehr Speicher oder Speicher mit einer anderen Konfiguration benötigen, müssen Sie [eine neue Speicherinstanz erstellen und die Daten](cs_storage_basics.html#update_storageclass) aus der alten Speicherinstanz in die neue kopieren.

1. Listen Sie die in {{site.data.keyword.containerlong}} verfügbaren Speicherklassen auf.
    ```
    kubectl get storageclasses | grep file
    ```
    {: pre}

    Beispielausgabe:
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
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

2. Überprüfen Sie die Konfiguration einer Speicherklasse.
   ```
   kubectl describe storageclass <name_der_speicherklasse>
   ```
   {: pre}

   Weitere Informationen zu den einzelnen Speicherklassen finden Sie in der [Speicherklassenreferenz](#storageclass_reference). Wenn Sie nichts Entsprechendes finden, können Sie eine eigene angepasste Speicherklasse erstellen. Prüfen Sie zunächst die [Beispiele für angepasste Speicherklassen](#custom_storageclass).
   {: tip}

3. Wählen Sie den Typ des Dateispeichers aus, den Sie bereitstellen möchten.
   - **Speicherklassen 'bronze', 'silver' und 'gold':** Diese Speicherklassen stellen [Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage) bereit. Mit dem Endurance-Speicher können Sie in vordefinierten Tiers für E/A-Operationen pro Sekunde die Größe des Speichers in Gigabyte auswählen.
   - **Speicherklasse 'custom':** Diese Speicherklasse stellt [Leistungsspeicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage) bereit. Mit dem Leistungsspeicher können Sie die Größe des Speichers und der E/A-Operationen pro Sekunde besser steuern.

4. Wählen Sie für Ihren Dateispeicher die Größe und die Anzahl E/A-Operationen pro Sekunde aus. Die Größe und die Anzahl der E/A-Operationen pro Sekunde definieren die Gesamtzahl der E/A-Operationen pro Sekunde, die als Indikator für die Geschwindigkeit des Speichers dient. Je höher die Anzahl der E/A-Operationen pro Sekunde für Ihren Speicher ist, desto höher ist dessen Verarbeitungsgeschwindigkeit für Lese- und Schreiboperationen.
   - **Speicherklassen 'bronze', 'silver' und 'gold':** Diese Speicherklassen haben eine feste Anzahl von pro Gigabyte angegebenen E/A-Operationen pro Sekunde und werden auf SSD-Festplatten bereitgestellt. Die Gesamtzahl der E/A-Operationen pro Sekunde hängt von der Größe des von Ihnen ausgewählten Speichers ab. Sie können innerhalb des zulässigen Größenbereichs eine beliebige ganze Zahl von Gigabyte auswählen, z. B. 20, 256 oder 11854 Gigabyte. Um die Gesamtzahl der E/A-Operationen pro Sekunde zu ermitteln, müssen Sie die E/A-Operationen pro Sekunde mit der ausgewählten Größe multiplizieren. Wenn Sie beispielsweise in der Speicherklasse 'silver', die 4 E/A-Operationen pro Sekunde aufweist, als Größe des Dateispeichers 1000 Gigabyte (1000Gi) auswählen, hat Ihr Speicher eine Gesamtzahl von 4000 E/A-Operationen pro Sekunde.
     <table>
         <caption>Tabelle der Größenbereiche der Speicherklasse und der IOPS pro Gigabyte</caption>
         <thead>
         <th>Speicherklasse</th>
         <th>IOPS pro Gigabyte</th>
         <th>Größenbereich in Gigabyte</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze</td>
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
   - **Speicherklasse 'custom':** Wenn Sie diese Speicherklasse auswählen, können Sie die gewünschte Größe und Anzahl der E/A-Operationen pro Sekunde besser steuern. Als Größe können Sie innerhalb des zulässigen Größenbereichs eine beliebige ganze Zahl von Gigabyte auswählen. Die von Ihnen gewählte Größe legt den Bereich der für Sie verfügbaren E/A-Operationen pro Sekunde fest. Sie können eine Anzahl von E/A-Operationen pro Sekunde auswählen, bei der es sich um eine Vielzahl von 100 handelt und die sich im angegebenen Bereich befindet. Der von Ihnen ausgewählte Wert für E/A-Operationen pro Sekunde ist statisch und wird nicht mit der Größe des Speichers skaliert. Wenn Sie beispielsweise 40 Gigabyte (40Gi) mit 100 E/A-Operationen pro Sekunde auswählen, bleibt die Gesamtzahl der E/A-Operationen pro Sekunde bei 100. </br></br> Das Verhältnis zwischen der Anzahl E/A-Operationen pro Sekunde und Gigabyte bestimmt auch den Typ der Festplatte, die für Sie bereitgestellt wird. Beispiel: Wenn Sie beispielsweise 500 Gigabyte (500Gi) bei 100 E/A-Operationen pro Sekunde haben, ist das Verhältnis E/A-Operationen pro Sekunde zu Gigabyte 0,2. Speicher mit einem Verhältnis von kleiner-gleich 0,3 wird auf SATA-Festplatten bereitgestellt. Wenn das Verhältnis größer als 0,3 ist, wird Ihr Speicher auf SSD-Festplatten bereitgestellt.  
     <table>
         <caption>Tabelle mit Größenbereichen und der Anzahl E/A-Operationen pro Sekunde (IOPS) für Speicherklassen des Typs 'custom'</caption>
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

5. Wählen Sie diese Option aus, wenn die Daten nach dem Löschen des Clusters oder des Persistent Volume Claim (PVC) beibehalten werden sollen.
   - Wenn Sie die Daten aufbewahren möchten, dann wählen Sie eine Speicherklasse vom Typ `retain` aus. Beim Löschen des PVC wird nur der PVC gelöscht. Der persistente Datenträger, die physische Speichereinheit im Konto der IBM Cloud-Infrastruktur (SoftLayer) und Ihre Daten sind weiterhin vorhanden. Um den Speicher zurückzufordern und in Ihrem Cluster erneut zu verwenden, müssen Sie den persistenten Datenträger entfernen und die Schritte zum [Verwenden von vorhandenem Dateispeicher](#existing_file) ausführen.
   - Wenn Sie möchten, dass der persistente Datenträger, die Daten und Ihre physische Dateispeichereinheit beim Löschen des Persistent Volume Claim (PVC) gelöscht werden, müssen Sie eine Speicherklasse ohne `retain` auswählen. 
**Hinweis**: Wenn Sie über ein Dedicated-Konto verfügen, wählen Sie eine Speicherklasse ohne `retain` aus, um zu verhindern, dass es verwaiste Datenträger in der IBM Cloud-Infrastruktur (SoftLayer) gibt.

6. Wählen Sie aus, ob Sie die Abrechnung auf Stundenbasis oder monatlich erhalten möchten. Weitere Informationen finden Sie unter [Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing). Standardmäßig werden alle Dateispeichereinheiten mit dem Abrechnungstyp 'Stündlich' (hourly) bereitgestellt.
   **Anmerkung:** Wenn Sie als Abrechnungstyp 'Monatlich' wählen, zahlen Sie beim Entfernen des persistenten Speichers immer noch eine monatliche Gebühr für ihn, selbst dann, wenn Sie den Speicher nur für eine kurze Zeit genutzt haben.

<br />



## Dateispeicher zu Apps hinzufügen
{: #add_file}

Erstellen Sie einen Persistent Volume Claim (PVC), um Dateispeicher für Ihren Cluster [dynamisch bereitzustellen](cs_storage_basics.html#dynamic_provisioning). Mithilfe der dynamischen Bereitstellung wird der übereinstimmende persistente Datenträger (PV) automatisch erstellt und die physische Speichereinheit in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) bestellt.
{:shortdesc}

Vorbemerkungen:
- Wenn Sie über eine Firewall verfügen, [gewähren Sie Egress-Zugriff](cs_firewall.html#pvc) für die IBM Cloud-Infrastruktur-IP-Bereiche (SoftLayer) der Zonen, in denen sich Ihre Cluster befinden, damit Sie Persistent Volume Claims (PVCs) erstellen können.
- [Entscheiden Sie sich für eine vordefinierte Speicherklasse](#predefined_storageclass) oder erstellen Sie eine [angepasste Speicherklasse (custom)](#custom_storageclass).

  **Tipp:** Wenn Sie einen Mehrzonencluster haben, wird die Zone, in der Ihr Speicher bereitgestellt wird, im Umlaufverfahren ausgewählt, um die Datenträgeranforderungen gleichmäßig auf alle Zonen zu verteilen. Wenn Sie die Zone für Ihren Speicher angeben möchten, müssen Sie zuerst eine [angepasste Speicherklasse (custom)](#multizone_yaml) erstellen. Führen Sie anschließend die Schritte in diesem Thema aus, um unter Verwendung Ihrer angepassten Speicherklasse (custom) Speicher bereitzustellen.

Gehen Sie wie folgt vor, um Dateispeicher hinzuzufügen:

1.  Erstellen Sie eine Konfigurationsdatei, um Ihren Persistent Volume Claim zu definieren, und speichern Sie die Konfiguration als `.yaml`-Datei.

    -  **Beispiel für die Speicherklassen 'bronze', 'silver' und 'gold'**:
       Die folgende `.yaml`-Datei erstellt eine Anforderung mit dem Namen `mypvc` der Speicherklasse `"ibmc-file-silver"` und einer monatlichen Abrechnung (`"monthly"`) mit einer Größe von `24Gi`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Beispiel für die Verwendung der Speicherklasse 'custom'**:
       Die folgende `.yaml`-Datei erstellt eine Anforderung mit dem Namen `mypvc` der Speicherklasse `ibmc-file-retain-custom` und einer Abrechnung auf Stundenbasis (`"hourly"`) mit einer Größe von `45Gi` und einer Anzahl von `"300"` E/A-Operationen pro Sekunde.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "hourly"
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
        <caption>Erklärung der Komponenten der YAML-Datei</caption>
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
        <td>Der Name der Speicherklasse, die Sie für die Bereitstellung von Dateispeicher verwenden möchten. </br> Wenn Sie keine Speicherklasse angeben, wird der persistente Datenträger mit der Standardspeicherklasse <code>ibmc-file-bronze</code> erstellt.<p>**Tipp:** Wenn Sie die Standardspeicherklasse ändern möchten, führen Sie den Befehl <code>kubectl patch storageclass &lt;speicherklasse&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> aus und ersetzen Sie <code>&lt;speicherklasse&gt;</code> durch den Namen der Speicherklasse.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Geben Sie die Häufigkeit an, mit der Ihre Speicherrechnung berechnet wird, monatlich ("monthly") oder stündlich ("hourly"). Wenn Sie keinen Abrechnungstyp angeben, wird der Speicher mit dem Abrechnungstyp 'Stündlich' (Hourly) bereitgestellt. </td>
        </tr>
        <tr>
        <td><code>spec/accessMode</code></td>
        <td>Geben Sie eine der folgenden Optionen an: <ul><li><strong>ReadWriteMany:</strong> Der PVC kann von mehreren Pods angehängt werden. Alle Pods können von diesem Datenträger lesen und auf diesen Datenträger schreiben.</li><li><strong>ReadOnlyMany:</strong> Der PVC kann von mehreren Pods angehängt werden. Alle Pods verfügen über Lesezugriff.<li><strong>ReadWriteOnce:</strong> Der PVC kann nur von einem Pod angehängt werden. Dieser Pod kann von diesem Datenträger lesen und auf diesen Datenträger schreiben.</li></ul></td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Geben Sie die Größe des Dateispeichers in Gigabytes (Gi) an. </br></br><strong>Anmerkung:</strong> Nach dem Bereitstellen des Speichers können Sie die Größe Ihres Dateispeichers nicht mehr ändern. Stellen Sie sicher, dass Sie eine Größe angeben, die dem Umfang der Daten entspricht, die Sie speichern möchten. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Diese Option gilt nur für die angepassten Speicherklassen (`ibmc-file-custom / ibmc-file-retain-custom`). Geben Sie die Gesamtzahl der E/A-Operationen pro Sekunde für den Speicher an, indem Sie ein Vielfaches von 100 innerhalb des zulässigen Bereichs auswählen. Wenn Sie einen Wert für die E/A-Operationen pro Sekunde auswählen, der nicht aufgelistet ist, wird der Wert aufgerundet.</td>
        </tr>
        </tbody></table>

    Wenn Sie eine angepasste Speicherklasse verwenden möchten, erstellen Sie den PVC mit dem entsprechenden Speicherklassennamen, einem gültigen Wert für IOPS und einer Größe.   
    {: tip}

2.  Erstellen Sie den PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  Überprüfen Sie, ob Ihr PVC erstellt und an das PV gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Beispielausgabe:

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Erstellen Sie zum Anhängen des Speichers an Ihre Bereitstellung eine `.yaml`-Konfigurationsdatei und geben Sie den Persistent Volume Claim (PVC) an, der den persistenten Datenträger bindet.

    Wenn Sie über eine App verfügen, für die erforderlich ist, dass ein Benutzer ohne Rootberechtigung in den persistenten Speicher schreibt, oder eine App, für die erforderlich ist, dass der Rootbenutzer Eigner des Mountpfads ist, finden Sie weitere Informationen unter [Zugriff für Benutzer ohne Rootberechtigung auf NFS-Dateispeicher hinzufügen](cs_troubleshoot_storage.html#nonroot) oder [Rootberechtigung für NFS-Dateispeicher aktivieren](cs_troubleshoot_storage.html#nonroot).
    {: tip}

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <bereitstellungsname>
      labels:
        app: <bereitstellungsbezeichnung>
    spec:
      selector:
        matchLabels:
          app: <app-name>
      template:
        metadata:
          labels:
            app: <app-name>
        spec:
          containers:
          - image: <imagename>
            name: <containername>
            volumeMounts:
            - name: <datenträgername>
              mountPath: /<dateipfad>
          volumes:
          - name: <datenträgername>
            persistentVolumeClaim:
              claimName: <pvc-name>
    ```
    {: codeblock}

    <table>
    <caption>Erklärung der Komponenten der YAML-Datei</caption>
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
    <td>Der Name des Images, das Sie verwenden möchten. Um die in Ihrem {{site.data.keyword.registryshort_notm}}-Konto verfügbaren Images aufzulisten, führen Sie den Befehl `ibmcloud cr image-list` aus.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>Der Name des Containers, den Sie in Ihrem Cluster bereitstellen möchten.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>Der absolute Pfad des Verzeichnisses, in dem der Datenträger innerhalb des Containers angehängt wird. Daten, die in den Mountpfad geschrieben werden, werden unter dem Verzeichnis <code>root</code> in Ihrer physischen Dateispeicherinstanz gespeichert. Um Verzeichnisse in Ihrer physischen Dateispeicherinstanz zu erstellen, müssen Sie Unterverzeichnisse in Ihrem Mountpfad erstellen.</td>
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
    <td>Der Name des PVC, der den zu verwendenden persistenten Datenträger bindet. </td>
    </tr>
    </tbody></table>

5.  Erstellen Sie die Bereitstellung.
     ```
     kubectl apply -f <lokaler_yaml-pfad>
     ```
     {: pre}

6.  Überprüfen Sie, dass der persistente Datenträger erfolgreich angehängt wurde.

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




## Vorhandenen Dateispeicher in Ihrem Cluster verwenden
{: #existing_file}

Wenn Sie bereits über eine physische Speichereinheit verfügen, die Sie in Ihrem Cluster verwenden möchten, können Sie den persistenten Datenträger und den PVC manuell erstellen, um den Speicher [statisch bereitzustellen](cs_storage_basics.html#static_provisioning).

Stellen Sie zunächst sicher, dass Sie über mindestens einen Workerknoten verfügen, der sich in derselben Zone befindet wie Ihre vorhandene Dateispeicherinstanz.

### Schritt 1: Vorhandenen Speicher vorbereiten

Bevor Sie mit dem Anhängen Ihres vorhandenen Speichers an eine App beginnen können, müssen Sie alle erforderlichen Informationen für Ihren persistenten Datenträger abrufen und den Speicher vorbereiten, sodass in Ihrem Cluster auf den Speicher zugegriffen werden kann.  

**Für Speicher, der mit einer `retain`-Speicherklasse bereitgestellt wurde:** </br>
Wenn Sie Speicher mit einer `retain`-Speicherklasse bereitgestellt haben und Sie den Persistent Volume Claim entfernen, werden der persistente Datenträger und die physische Speichereinheit nicht automatisch entfernt. Zum Wiederverwenden des Speichers in Ihrem Cluster müssen Sie zuerst den beibehaltenen persistenten Datenträger entfernen.

Wenn Sie den in einem Cluster bereitgestellten Speicher auch in einem anderen Cluster verwenden möchten, führen Sie die Schritte für [außerhalb des Clusters erstellten Speicher](#external_storage) aus, um den Speicher dem Teilnetz Ihres Workerknotens hinzuzufügen.
{: tip}

1. Listen Sie vorhandene persistente Datenträger auf.
   ```
   kubectl get pv
   ```
   {: pre}

   Suchen Sie den persistenten Datenträger, der zu Ihrem persistenten Speicher gehört. Der persistente Datenträger hat den Status 'freigegeben' (`released`).

2. Rufen Sie die Details zum persistenten Datenträger ab.
   ```
   kubectl describe pv <pv-name>
   ```
   {: pre}

3. Notieren Sie sich die Werte für `CapacityGb`, `storageClass`, `failure-domain.beta.kubernetes.io/region`, `failure-domain.beta.kubernetes.io/zone`, `server` und `path`.

4. Entfernen Sie den persistenten Datenträger.
   ```
   kubectl delete pv <pv-name>
   ```
   {: pre}

5. Überprüfen Sie, dass der persistente Datenträger entfernt wurde.
   ```
   kubectl get pv
   ```
   {: pre}

</br>

**Für persistenten Speicher, der außerhalb des Clusters bereitgestellt wurde:** </br>
Wenn Sie bereits vorhandenen Speicher verwenden möchten, den Sie zuvor bereitgestellt, aber noch nie zuvor in Ihrem Cluster verwendet haben, müssen Sie den Speicher in demselben Teilnetz wie Ihre Workerknoten verfügbar machen.

**Hinweis**: Wenn Sie über ein Dedicated-Konto verfügen, müssen Sie [ein Support-Ticket öffnen](/docs/get-support/howtogetsupport.html#getting-customer-support).

1.  {: #external_storage}Klicken Sie im [Portal der IBM Cloud-Infrastruktur (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.bluemix.net/) auf **Speicher**.
2.  Klicken Sie auf **Dateispeicher** und wählen Sie im Menü **Aktionen** die Option zum Autorisieren des Hosts**** aus.
3.  Wählen Sie **Teilnetze** aus.
4.  Wählen Sie in der Dropdown-Liste das private VLAN-Teilnetz aus, mit dem der Workerknoten verbunden ist. Um das Teilnetz Ihres Workerknotens zu finden, führen Sie den Befehl `ibmcloud ks workers <cluster_name>` aus und vergleichen Sie die `Private IP` Ihres Workerknotens mit dem Teilnetz, das Sie in der Dropdown-Liste gefunden haben.
5.  Klicken Sie auf **Übergeben**.
6.  Klicken Sie auf den Namen des Dateispeichers.
7.  Notieren Sie die Werte in den Feldern `Mountpunkt`, `Größe` und `Standort`. Das Feld `Mountpunkt` wird als `<nfs_server>:<file_storage_path>` angezeigt.

### Schritt 2: Persistenten Datenträger (PV) und übereinstimmenden Persistent Volume Claim (PVC) erstellen

1.  Erstellen Sie eine Speicherkonfigurationsdatei für Ihr PV (Persistent Volume). Schließen Sie die Werte ein, die Sie zuvor abgerufen haben.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
     labels:
        failure-domain.beta.kubernetes.io/region: <region>
        failure-domain.beta.kubernetes.io/zone: <zone>
    spec:
     capacity:
       storage: "<größe>"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "<nfs-server>"
       path: "<file storage-pfad>"
    ```
    {: codeblock}

    <table>
    <caption>Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Geben Sie den Namen des PV-Objekts ein, das erstellt werden soll.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Geben Sie die Region und die Zone ein, die Sie zuvor abgerufen haben. Zum Anhängen des Speichers an Ihren Cluster müssen Sie mindestens einen Workerknoten in der Region und Zone haben, in der sich auch der persistente Speicher befindet. If a PV for your storage already exists, [add the zone and region label](cs_storage_basics.html#multizone) to your PV.
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Geben Sie die Speichergröße der vorhandenen NFS-Dateifreigabe ein, die Sie zuvor abgerufen haben. Die Größe des Speichers muss in Gigabyte angegeben werden, z. B. 20Gi (20 GB) oder 1000Gi (1 TB), und sie muss mit der Größe der vorhandenen Dateifreigabe übereinstimmen.</td>
    </tr>
    <tr>
    <td><code>spec/accessMode</code></td>
    <td>Geben Sie eine der folgenden Optionen an: <ul><li><strong>ReadWriteMany:</strong> Der PVC kann von mehreren Pods angehängt werden. Alle Pods können von diesem Datenträger lesen und auf diesen Datenträger schreiben.</li><li><strong>ReadOnlyMany:</strong> Der PVC kann von mehreren Pods angehängt werden. Alle Pods verfügen über Lesezugriff.<li><strong>ReadWriteOnce:</strong> Der PVC kann nur von einem Pod angehängt werden. Dieser Pod kann von diesem Datenträger lesen und auf diesen Datenträger schreiben.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Geben Sie die Server-ID der NFS-Dateifreigabe ein, die Sie zuvor abgerufen haben.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Geben Sie den Pfad zur NFS-Dateifreigabe ein, den Sie zuvor abgerufen haben.</td>
    </tr>
    </tbody></table>

3.  Erstellen Sie das PV in Ihrem Cluster.

    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4.  Überprüfen Sie, dass das PV erstellt wurde.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Erstellen Sie eine weitere Konfigurationsdatei, um Ihren Persistent Volume Claim (PVC) zu erstellen. Damit der Persistent Volume Claim (PVC) mit dem zuvor erstellten Persistent Volume übereinstimmt, müssen Sie denselben Wert für `storage` und `accessMode` auswählen. Das Feld `storage-class` muss leer sein. Wenn eines dieser Felder nicht mit dem persistenten Datenträger (PV – Persistent Volume) übereinstimmt, werden ein neuer persistenter Datenträger und eine neue physische Speicherinstanz [dynamisch bereitgestellt](cs_storage_basics.html#dynamic_provisioning).

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
         storage: "<größe>"
    ```
    {: codeblock}

6.  Erstellen Sie Ihren PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

7.  Überprüfen Sie, ob Ihr PVC erstellt und an das PV gebunden wurde. Dieser Prozess kann einige Minuten dauern.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Beispielausgabe:

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Sie haben erfolgreich ein PV (Persistent Volume) erstellt und an einen PVC (Persistent Volume Claim) gebunden. Clusterbenutzer können jetzt den [PVC (Persistent Volume Claim) an ihre Bereitstellungen anhängen](#app_volume_mount) und mit dem Lesen und Schreiben in dem PV-Objekt (Persistent Volume-Objekt) beginnen.

<br />



## NFS-Standardversion ändern
{: #nfs_version}

Die Version des Dateispeichers bestimmt das Protokoll, das für die Kommunikation mit dem {{site.data.keyword.Bluemix_notm}}-Dateispeicherserver verwendet wird. Standardmäßig sind alle Dateispeicherinstanzen mit NFS Version 4 eingerichtet. Sie können das vorhandenen PV in eine ältere NFS-Version ändern, wenn Ihre App für einen ordnungsgemäßen Betrieb eine bestimmte Version benötigt.
{: shortdesc}

Um die NFS-Standardversion zu ändern, können Sie entweder eine neue Speicherklasse erstellen, um den Dateispeicher dynamisch in Ihrem Cluster bereitzustellen, oder ändern Sie ein vorhandenes PV, der an den Pod angehängt ist.

**Wichtig:** Um die aktuellen Sicherheitsupdates anzuwenden und eine bessere Leistung zu erzielen, verwenden Sie die NFS-Standardversion und wechseln nicht zu einer älteren NFS-Version.

**Gehen Sie wie folgt vor, um eine angepasste Speicherklasse mit der gewünschten NFS-Version zu erstellen:**
1. Erstellen Sie eine [angepasste Speicherklasse (custom)](#nfs_version_class), die die NFS-Version aufweist, die Sie bereitstellen möchten.
2. Erstellen Sie die Speicherklasse in Ihrem Cluster.
   ```
   kubectl apply -f nfsversion_storageclass.yaml
   ```
   {: pre}

3. Überprüfen Sie, dass die angepasste Speicherklasse erstellt wurde.
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. Stellen Sie [Dateispeicher](#add_file) mit der angepassten Speicherklasse bereit.

**Gehen Sie wie folgt vor, um das vorhandene PV (Persistent Volume) so zu ändern, dass eine andere NFS-Version verwendet wird:**

1. Rufen Sie das PV des Dateispeichers ab, für das die NFS-Version geändert werden soll, und notieren Sie den Namen des PV.
   ```
   kubectl get pv
   ```
   {: pre}

2. Fügen Sie dem persistenten Datenträger eine Annotation hinzu. Ersetzen Sie `<version_number>` durch die zu verwendende NFS-Version. Um beispielsweise eine Änderung in NFS Version 3.0 vorzunehmen, geben Sie **3** ein.  
   ```
   kubectl patch pv <pv-name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<versionsnummer>"}}}'
   ```
   {: pre}

3. Löschen Sie den Pod, der den Dateispeicher verwendet, und erstellen Sie den Pod erneut.
   1. Speichern Sie die YALM-Datei für den Pod auf der lokalen Maschine.
      ```
      kubect get pod <podname> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. Löschen Sie den Pod.
      ```
      kubectl deleted pod <podname>
      ```
      {: pre}

   3. Erstellen Sie den Pod erneut.
      ```
      kubectl apply -f pod.yaml
      ```
      {: pre}

4. Warten Sie, bis der Pod bereitgestellt wurde.
   ```
   kubectl get pods
   ```
   {: pre}

   Der Pod wird vollständig bereitgestellt, wenn der Status in `Aktiv` geändert wird.

5. Melden Sie sich beim Pod an.
   ```
   kubectl exec -it <podname> sh
   ```
   {: pre}

6. Stellen Sie sicher, dass der Dateispeicher mit der von Ihnen zuvor angegebenen NFS-Version angehängt wurde.
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   Beispielausgabe:
   ```
   nfs vers=3.0
   ```
   {: screen}

<br />


## Daten sichern und wiederherstellen
{: #backup_restore}

Der Dateispeicher wird an derselben Position wie die Workerknoten in Ihrem Cluster bereitgestellt. Der Speicher wird auf in Gruppen zusammengefassten Servern von IBM gehostet, um Verfügbarkeit sicherzustellen, falls ein Server ausfallen sollte. Der Dateispeicher wird jedoch nicht automatisch gesichert und ist möglicherweise nicht zugänglich, wenn der gesamte Standort fehlschlägt. Um Ihre Daten vor Verlust oder Beschädigung zu schützen, können Sie regelmäßige Sicherungen konfigurieren, mit denen Sie bei Bedarf Daten wiederherstellen können.
{: shortdesc}

Überprüfen Sie die folgenden Optionen zum Sichern und Wiederherstellen Ihres Dateispeichers:

<dl>
  <dt>Regelmäßige Snapshots konfigurieren</dt>
  <dd><p>Sie können [für Ihren Dateispeicher das Erstellen regelmäßiger Snapshots](/docs/infrastructure/FileStorage/snapshots.html) konfigurieren. Dies ist ein schreibgeschütztes Image, das den Status der Instanz zu einem bestimmten Zeitpunkt erfasst. Um den Snapshot zu speichern, müssen Sie für den Snapshot Speicherplatz im Dateispeicher anfordern. Snapshots werden in der in derselben Zone vorhandenen Speicherinstanz gespeichert. Sie können Daten von einem Snapshot wiederherstellen, falls ein Benutzer versehentlich wichtige Daten von dem Datenträger entfernt. <strong>Hinweis</strong>: Wenn Sie über ein Dedicated-Konto verfügen, müssen Sie [ein Support-Ticket öffnen](/docs/get-support/howtogetsupport.html#getting-customer-support).</br></br> <strong>Gehen Sie wie folgt vor, um einen Snapshot für den Datenträger zu erstellen: </strong><ol><li>Listen Sie alle vorhandenen PVs in Ihrem Cluster auf. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>Rufen Sie die Details für das PV ab, für das Snapshotspeicherplatz angefordert werden soll, und notieren Sie sich die Datenträger-ID, die Größe und die E/A-Operationen pro Sekunde (IOPS). <pre class="pre"><code>kubectl describe pv &lt;pv-name&gt;</code></pre> Die Datenträger-ID, die Größe und den Wert für die Anzahl E/A-Operationen pro Sekunde finden Sie im Abschnitt <strong>Labels</strong> der CLI-Ausgabe. </li><li>Erstellen Sie die Snapshotgröße für den vorhandenen Datenträger mit den Parametern, die Sie im vorherigen Schritt abgerufen haben. <pre class="pre"><code>slcli file snapshot-order --capacity &lt;größe&gt; --tier &lt;iops&gt; &lt;datenträger-id&gt;</code></pre></li><li>Warten Sie, bis die Snapshotgröße erstellt wurde. <pre class="pre"><code>slcli file volume-detail &lt;datenträger-id&gt;</code></pre>Die Snapshotgröße wird erfolgreich bereitgestellt, wenn der Wert für <strong>Snapshot Capacity (GB)</strong> in der CLI-Ausgabe von '0' in die von Ihnen angeforderte Größe geändert wird. </li><li>Erstellen Sie einen Snapshot für den Datenträger und notieren Sie die ID des von Sie erstellten Snapshots. <pre class="pre"><code>slcli file snapshot-create &lt;datenträger-id&gt;</code></pre></li><li>Überprüfen Sie, dass der Snapshot erfolgreich erstellt wurde. <pre class="pre"><code>slcli file volume-detail &lt;snapshot-id&gt;</code></pre></li></ol></br><strong>Gehen Sie wie folgt vor, um Daten aus einem Snapshot auf einem vorhandenen Datenträger wiederherzustellen: </strong><pre class="pre"><code>slcli file snapshot-restore -s &lt;snapshot_id&gt; &lt;datenträger-id&gt;</code></pre></p></dd>
  <dt>Snapshots in eine andere Zone replizieren</dt>
 <dd><p>Um Daten vor einem Zonenausfall zu schützen, können Sie in einer Dateispeicherinstanz, die in einer anderen Zone konfiguriert ist, [Snapshots replizieren](/docs/infrastructure/FileStorage/replication.html#replicating-data). Daten können nur aus dem primären Speicher an den Sicherungsspeicher repliziert werden. Sie können eine replizierte Dateispeicherinstanz nicht an einen Cluster anhängen. Wenn Ihr primärer Speicher fehlschlägt, können Sie Ihren replizierten Sicherungsspeicher manuell als primären Speicher festlegen. Anschließend können Sie ihn an den Cluster anhängen. Nachdem Ihr primärer Speicher wiederhergestellt wurde, können Sie die Daten aus dem Sicherungsspeicher wiederherstellen. <strong>Hinweis</strong>: Wenn Sie über ein Dedicated-Konto verfügen, können Sie keine Snapshots in eine andere Zone replizieren.</p></dd>
 <dt>Speicher duplizieren</dt>
 <dd><p>Sie können Ihre [Dateispeicherinstanz in derselben Zone duplizieren](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage), in der sich auch die ursprüngliche Speicherinstanz befindet. Ein Duplikat hat dieselben Daten wie die Originalspeicherinstanz zu dem Zeitpunkt, an dem das Duplikat erstellt wurde. Verwenden Sie das Duplikat - im Gegensatz zu den Replikaten - als unabhängige Speicherinstanz. Zur Vorbereitung einer Duplizierung müssen Sie zunächst [Snapshots für den Datenträger erstellen](/docs/infrastructure/FileStorage/snapshots.html). <strong>Hinweis</strong>: Wenn Sie über ein Dedicated-Konto verfügen, müssen Sie <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">ein Support-Ticket öffnen</a>.</p></dd>
  <dt>Daten in {{site.data.keyword.cos_full}} sichern</dt>
  <dd><p>Sie können den Befehl [**ibm-backup-restore image**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) verwenden, damit ein Pod für Sicherung und Wiederherstellung in Ihrem Cluster den Betrieb aufnimmt. Dieser Pod enthält ein Script zur Ausführung einer einmaligen oder regelmäßigen Sicherung für alle PVCs (Persistent Volume Claims) in Ihrem Cluster. Die Daten werden in Ihrer {{site.data.keyword.cos_full}}-Instanz gespeichert, die Sie in einer Zone konfiguriert haben.</p>
  <p>Damit Ihre Daten noch besser hoch verfügbar sind und um Ihre App vor einem Zonenausfall zu schützen, konfigurieren Sie eine zweite {{site.data.keyword.cos_full}}-Instanz und replizieren Sie die Daten zonenübergreifend. Falls Sie Daten von Ihrer {{site.data.keyword.cos_full}}-Instanz wiederherstellen müssen, verwenden Sie das Wiederherstellungsscript, das mit dem Image bereitgestellt wird.</p></dd>
<dt>Daten in und aus Pods und Containern kopieren</dt>
<dd><p>Sie können den [Befehl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) `kubectl cp` verwenden, um Dateien und Verzeichnisse in und aus Pods oder spezifischen Containern in Ihrem Cluster zu kopieren.</p>
<p>Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel Ihrer Kubernetes-CLI](cs_cli_install.html#cs_cli_configure) den gewünschten Cluster an. Wenn Sie keinen Container mit <code>-c</code> angeben, verwendet der Befehl den ersten verfügbaren Container im Pod.</p>
<p>Sie können den Befehl auf verschiedene Weisen verwenden:</p>
<ul>
<li>Kopieren Sie Daten von Ihrer lokalen Maschine in einen Pod in Ihrem Cluster: <pre class="pre"><code>kubectl cp <var>&lt;lokaler_dateipfad&gt;/&lt;dateiname&gt;</var> <var>&lt;namensbereich&gt;/&lt;pod&gt;:&lt;dateipfad_des_pods&gt;</var></code></pre></li>
<li>Kopieren Sie Daten von einem Pod in Ihrem Cluster auf Ihre lokale Maschine: <pre class="pre"><code>kubectl cp <var>&lt;namensbereich&gt;/&lt;pod&gt;:&lt;dateipfad_des_pods&gt;/&lt;dateiname&gt;</var> <var>&lt;lokaler_dateipfad&gt;/&lt;dateiname&gt;</var></code></pre></li>
<li>Kopieren Sie Daten von Ihrer lokalen Maschine in einen bestimmten Container, der in einem Pod in Ihrem Cluster ausgeführt wird: <pre class="pre"><code>kubectl cp <var>&lt;lokaler_dateipfad&gt;/&lt;dateiname&gt;</var> <var>&lt;namensbereich&gt;/&lt;pod&gt;:&lt;pod-dateipfad&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Speicherklassenreferenz
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Dateispeicherklasse: bronze</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-file-bronze</code></br><code>ibmc-file-retain-bronze</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS pro Gigabyte</td>
<td>2</td>
</tr>
<tr>
<td>Größenbereich in Gigabyte</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Festplatte</td>
<td>SSD</td>
</tr>
<tr>
<td>Abrechnung</td>
<td>Stündlich</td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>


### Silver
{: #silver}

<table>
<caption>Dateispeicherklasse: silver</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-file-silver</code></br><code>ibmc-file-retain-silver</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS pro Gigabyte</td>
<td>4</td>
</tr>
<tr>
<td>Größenbereich in Gigabyte</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Festplatte</td>
<td>SSD</td>
</tr>
<tr>
<td>Abrechnung</td>
<td>Stündlich</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Dateispeicherklasse: gold</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-file-gold</code></br><code>ibmc-file-retain-gold</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS pro Gigabyte</td>
<td>10</td>
</tr>
<tr>
<td>Größenbereich in Gigabyte</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>Festplatte</td>
<td>SSD</td>
</tr>
<tr>
<td>Abrechnung</td>
<td>Stündlich</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Custom
{: #custom}

<table>
<caption>Dateispeicherklasse: custom</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-file-custom</code></br><code>ibmc-file-retain-custom</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Performance ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>NFS</td>
</tr>
<tr>
<td>E/A-Operationen pro Sekunde (IOPS) und Größe</td>
<td><p><strong>Größenbereich in Gigabyte / IOPS-Bereich in Vielfachen von 100</strong></p><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Festplatte</td>
<td>Das Verhältnis zwischen der Anzahl E/A-Operationen pro Sekunde und Gigabyte bestimmt den Typ der Festplatte, die bereitgestellt wird. Um das Verhältnis zwischen der Anzahl E/A-Operationen pro Sekunde zu Gigabyte zu bestimmen, teilen Sie die Anzahl E/A-Operationen pro Sekunde durch die Größe Ihres Speichers. </br></br>Beispiel: </br>Sie wählen 500 Gigabyte (500Gi) Speicher mit 100 E/A-Operationen pro Sekunde. Ihr Verhältnis ist 0,2 (100 E/A-Operationen pro Sekunde/500 Gigabyte). </br></br><strong>Zuordnung Festplattentypen/Verhältnis – Übersicht:</strong><ul><li>Kleiner-gleich 0,3: SATA</li><li>Größer als 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Abrechnung</td>
<td>Stündlich</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Beispiele für angepasste Speicherklassen (custom)
{: #custom_storageclass}

### Zone angeben (bei Mehrzonencluster)
{: #multizone_yaml}

Die folgende `.yaml`-Datei passt eine Speicherklasse an, die auf der Speicherklasse `ibm-file-silver` ohne 'retain' (Beibehaltung) basiert: Der Typ (`type`) ist `"Endurance"`, der Wert für `iopsPerGB` ist `4`, der Wert für `sizeRange` ist `"[20-12000]Gi"` und für `reclaimPolicy` wird die Einstellung `"Delete"` festgelegt. Die Zone wird als `dal12` angegeben. Als Unterstützung für die Festlegung von zulässigen Werten können Sie die oben stehenden Informationen zu `ibmc`-Speicherklassen erneut lesen. </br>

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-file-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-file
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### NFS-Standardversion ändern
{: #nfs_version_class}

Die folgende angepasste Speicherklasse hat als Basis die [Speicherklasse `ibmc-file-bronze`](#bronze) und gibt Ihnen die Möglichkeit, die bereitzustellende NFS-Version zu definieren. Um beispielsweise NFS Version 3.0 bereitzustellen, ersetzen Sie `<nfs_version>` durch **3.0**.
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-file-mount
  #annotations:
  #  storageclass.beta.kubernetes.io/is-default-class: "true"
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-file
parameters:
  type: "Endurance"
  iopsPerGB: "2"
  sizeRange: "[1-12000]Gi"
  reclaimPolicy: "Delete"
  classVersion: "2"
  mountOptions: nfsvers=<nfs-version>
```
{: codeblock}
