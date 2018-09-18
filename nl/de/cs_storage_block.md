---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# Daten in IBM Block Storage für IBM Cloud speichern
{: #block_storage}


## Plug-in für {{site.data.keyword.Bluemix_notm}}-Block Storage in Ihrem Cluster installieren 
{: #install_block}

Installieren Sie das {{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-in mit einem Helm-Diagramm, um vordefinierte Speicherklassen für den Blockspeicher einzurichten. Mit diesen Speicherklassen können Sie einen PVC zum Bereitstellen von Blockspeicher für Ihre Apps erstellen.
{: shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) den Cluster an, auf dem Sie das {{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-in installieren möchten.


1. Führen Sie die [Anweisungen](cs_integrations.html#helm) aus, um den Helm-Client auf Ihrer lokalen Maschine zu installieren, installieren Sie den Helm-Server (tiller) in Ihrem Cluster und fügen Sie das {{site.data.keyword.Bluemix_notm}}-Repository für das Helm-Diagramm dem Cluster hinzu, in dem Sie das Plug-in für {{site.data.keyword.Bluemix_notm}}-Block Storage verwenden wollen.
2. Aktualisieren Sie das Helm-Repository, um die aktuelle Version aller Helm-Diagramme in diesem Repository abzurufen.
   ```
   helm repo update
   ```
   {: pre}

3. Installieren Sie das {{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-in. Wenn Sie das Plug-in installieren, werden vordefinierte Blockspeicherklassen zu Ihrem Cluster hinzugefügt.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Beispielausgabe:
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. Überprüfen Sie, dass die Installation erfolgreich war.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Beispielausgabe:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   Die Installation ist erfolgreich, wenn ein Pod des Typs `ibmcloud-block-storage-plugin` und ein oder mehrere Pods des Typs `ibmcloud-block-storage-driver` angezeigt werden. Die Anzahl der Pods des Typs `ibmcloud-block-storage-driver` entspricht der Anzahl der Workerknoten in Ihrem Cluster. Alle Pods müssen den Status **Aktiv** aufweisen.

5. Überprüfen Sie, dass die Speicherklassen für Blockspeicher zu Ihrem Cluster hinzugefügt wurden.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Beispielausgabe:
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. Wiederholen Sie diese Schritte für jeden Cluster, in dem Sie Blockspeicher bereitstellen möchten.

Sie können jetzt mit dem [Erstellen eines PVC](#add_block) zum Bereitstellen von Blockspeicher für Ihre App fortfahren.


### {{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-in aktualisieren
Sie können ein Upgrade des vorhandenen {{site.data.keyword.Bluemix_notm}}Blockspeicher-Plug-ins auf die aktuelle Version durchführen.
{: shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf den Cluster aus.

1. Aktualisieren Sie das Helm-Repository, um die aktuelle Version aller Helm-Diagramme in diesem Repository abzurufen.
   ```
   helm repo update
   ```
   {: pre}
   
2. Optional: Laden Sie das aktuellste Helm-Diagramm auf Ihre lokale Maschine herunter. Dekomprimieren Sie anschließend das Paket und überprüfen Sie die Datei `release.md`, um die neuesten Releaseinformationen anzuzeigen. 
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. Suchen Sie den Namen des Block Storage-Helm-Diagramms, das Sie in Ihrem Cluster installiert haben.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Beispielausgabe:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. Führen Sie ein Upgrade des {{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-ins auf die aktuelle Version durch.
   ```
   helm upgrade --force --recreate-pods <name_des_helm-diagramms>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. Optional: Wenn Sie das Plug-in aktualisieren, wird die Festlegung auf die Speicherklasse `standard` aufgehoben. Wenn Sie statt der Speicherklasse 'standard' eine Speicherklasse Ihrer Wahl festlegen möchten, führen Sie den folgenden Befehl aus.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### Plug-in für {{site.data.keyword.Bluemix_notm}}-Block Storage entfernen
Wenn Sie in Ihrem Cluster {{site.data.keyword.Bluemix_notm}}-Block Storage nicht bereitstellen und verwenden möchten, können Sie das Helm-Diagramm deinstallieren.
{: shortdesc}

**Hinweis:** Durch das Entfernen des Plug-ins werden keine vorhandenen PVCs, PVs oder Daten entfernt. Wenn Sie das Plug-in entfernen, werden alle zugehörigen Pods und Dämongruppen aus Ihrem Cluster entfernt. Nachdem Sie das Plug-in entfernt haben, können Sie keinen neuen Blockspeicher für Ihren Cluster bereitstellen oder vorhandene Blockspeicher-PVCs und -PVs verwenden.

Vorbemerkungen:
- [Geben Sie als Ziel Ihrer Befehlszeilenschnittstelle](cs_cli_install.html#cs_cli_configure) den Cluster an. 
- Stellen Sie sicher, dass in Ihrem Cluster keine PVCs oder persistenten Datenträger vorhanden sind, die Block Storage verwenden.

Gehen Sie wie folgt vor, um das Plug-in zu entfernen: 

1. Suchen Sie den Namen des Block Storage-Helm-Diagramms, das Sie in Ihrem Cluster installiert haben.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Beispielausgabe:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Löschen Sie das {{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-in.
   ```
   helm delete <name_des_helm-diagramms>
   ```
   {: pre}

3. Überprüfen Sie, dass die Blockspeicher-Pods entfernt wurden.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   Das Entfernen der Pods war erfolgreich, wenn in Ihrer CLI-Ausgabe keine Pods angezeigt werden.

4. Überprüfen Sie, dass die Blockspeicherklassen entfernt wurden.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   Das Entfernen der Speicherklassen war erfolgreich, wenn in Ihrer CLI-Ausgabe keine Speicherklassen angezeigt werden.

<br />



## Block Storage-Konfiguration festlegen
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} stellt vordefinierte Speicherklassen für Block Storage zur Verfügung, die Sie verwenden können, um Blockspeicher mit einer bestimmten Konfiguration bereitzustellen.
{: shortdesc}

Jede Speicherklasse gibt den Typ des Blockspeichers an, den Sie bereitstellen, einschließlich der verfügbaren Größe, der E/A-Operationen pro Sekunde, des Dateisystems und der Aufbewahrungsrichtlinie.  

**Wichtig:** Stellen Sie sicher, dass die Speicherkonfiguration sorgfältig ausgewählt ist, damit genügend Kapazität zum Speichern Ihrer Daten vorhanden ist. Nachdem Sie mithilfe einer Speicherklasse einen bestimmten Typ von Speicher bereitgestellt haben, können Sie die Größe, den Typ, die E/A-Operationen pro Sekunde oder die Aufbewahrungsrichtlinie für die Speichereinheit nicht mehr ändern. Wenn Sie mehr Speicher oder Speicher mit einer anderen Konfiguration benötigen, müssen Sie [eine neue Speicherinstanz erstellen und die Daten](cs_storage_basics.html#update_storageclass) aus der alten Speicherinstanz in die neue kopieren. 

1. Listen Sie die in {{site.data.keyword.containerlong}} verfügbaren Speicherklassen auf.
```
    kubectl get storageclasses | grep block
    ```
    {: pre}

    Beispielausgabe: 
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

2. Überprüfen Sie die Konfiguration einer Speicherklasse. 
   ```
   kubectl describe storageclass <name_der_speicherklasse>
   ```
   {: pre}
   
   Weitere Informationen zu den einzelnen Speicherklassen finden Sie in der [Speicherklassenreferenz](#storageclass_reference). Wenn Sie nichts Entsprechendes finden, können Sie eine eigene angepasste Speicherklasse erstellen. Prüfen Sie zunächst die [Beispiele für angepasste Speicherklassen](#custom_storageclass).{: tip}
   
3. Wählen Sie den Typ des Blockspeichers aus, den Sie bereitstellen möchten. 
   - **Speicherklassen 'bronze', 'silver' und 'gold':** Diese Speicherklassen stellen [Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage) bereit. Mit dem Endurance-Speicher können Sie in vordefinierten Tiers für E/A-Operationen pro Sekunde die Größe des Speichers in Gigabyte auswählen.
   - **Speicherklasse 'custom':** Diese Speicherklasse stellt [Leistungsspeicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage) bereit. Mit dem Leistungsspeicher können Sie die Größe des Speichers und der E/A-Operationen pro Sekunde besser steuern. 
     
4. Wählen Sie für Ihren Blockspeicher die Größe und die Anzahl E/A-Operationen pro Sekunde aus. Die Größe und die Anzahl der E/A-Operationen pro Sekunde definieren die Gesamtzahl der E/A-Operationen pro Sekunde, die als Indikator für die Geschwindigkeit des Speichers dient. Je höher die Anzahl der E/A-Operationen pro Sekunde für Ihren Speicher ist, desto höher ist dessen Verarbeitungsgeschwindigkeit für Lese- und Schreiboperationen. 
   - **Speicherklassen 'bronze', 'silver' und 'gold':** Diese Speicherklassen haben eine feste Anzahl von pro Gigabyte angegebenen E/A-Operationen pro Sekunde und werden auf SSD-Festplatten bereitgestellt. Die Gesamtzahl der E/A-Operationen pro Sekunde hängt von der Größe des von Ihnen ausgewählten Speichers ab. Sie können innerhalb des zulässigen Größenbereichs eine beliebige ganze Zahl von Gigabyte auswählen, z. B. 20, 256 oder 11854 Gigabyte. Um die Gesamtzahl der E/A-Operationen pro Sekunde zu ermitteln, müssen Sie die E/A-Operationen pro Sekunde mit der ausgewählten Größe multiplizieren. Wenn Sie beispielsweise in der Speicherklasse 'silver', die 4 E/A-Operationen pro Sekunde aufweist, als Größe des Blockspeichers 1000 Gigabyte (1000Gi) auswählen, hat Ihr Speicher eine Gesamtzahl von 4000 E/A-Operationen pro Sekunde.  
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
   - **Speicherklasse 'custom':** Wenn Sie diese Speicherklasse auswählen, können Sie die gewünschte Größe und Anzahl der E/A-Operationen pro Sekunde besser steuern. Als Größe können Sie innerhalb des zulässigen Größenbereichs eine beliebige ganze Zahl von Gigabyte auswählen. Die von Ihnen gewählte Größe legt den Bereich der für Sie verfügbaren E/A-Operationen pro Sekunde fest. Sie können eine Anzahl von E/A-Operationen pro Sekunde auswählen, bei der es sich um eine Vielzahl von 100 handelt und die sich im angegebenen Bereich befindet. Der von Ihnen ausgewählte Wert für E/A-Operationen pro Sekunde ist statisch und wird nicht mit der Größe des Speichers skaliert. Wenn Sie beispielsweise 40 Gigabyte (40Gi) mit 100 E/A-Operationen pro Sekunde auswählen, bleibt die Gesamtzahl der E/A-Operationen pro Sekunde bei 100.</br></br>Das Verhältnis zwischen der Anzahl E/A-Operationen pro Sekunde und Gigabyte bestimmt auch den Typ der Festplatte, die für Sie bereitgestellt wird. Beispiel: Wenn Sie beispielsweise 500 Gigabyte (500Gi) bei 100 E/A-Operationen pro Sekunde haben, ist das Verhältnis E/A-Operationen pro Sekunde zu Gigabyte 0,2. Speicher mit einem Verhältnis von kleiner-gleich 0,3 wird auf SATA-Festplatten bereitgestellt. Wenn das Verhältnis größer als 0,3 ist, wird Ihr Speicher auf SSD-Festplatten bereitgestellt.<table>
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
   - Wenn Sie die Daten beibehalten möchten, wählen Sie eine Speicherklasse vom Typ `retain` aus. Beim Löschen des PVC wird nur der PVC gelöscht. Der persistente Datenträger, die physische Speichereinheit im Konto der IBM Cloud-Infrastruktur (SoftLayer) und Ihre Daten sind weiterhin vorhanden. Um den Speicher zurückzufordern und in Ihrem Cluster erneut zu verwenden, müssen Sie den persistenten Datenträger entfernen und die Schritte zum [Verwenden von vorhandenem Blockspeicher](#existing_block) ausführen. 
   - Wenn Sie möchten, dass der persistente Datenträger, die Daten und Ihre physische Blockspeichereinheit beim Löschen des Persistent Volume Claim (PVC) gelöscht werden, müssen Sie eine Speicherklasse ohne `retain` auswählen.
   
6. Wählen Sie aus, ob Sie die Abrechnung auf Stundenbasis oder monatlich erhalten möchten. Weitere Informationen finden Sie unter [Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing). Standardmäßig werden alle Blockspeichereinheiten mit dem Abrechnungstyp 'Stündlich' (hourly) bereitgestellt. 

<br />



## Blockspeicher zu Apps hinzufügen
{: #add_block}

Erstellen Sie einen Persistent Volume Claim (PVC), um Blockspeicher für Ihren Cluster [dynamisch bereitzustellen](cs_storage_basics.html#dynamic_provisioning). Mithilfe der dynamischen Bereitstellung wird der übereinstimmende persistente Datenträger (PV) automatisch erstellt und die tatsächliche Speichereinheit in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) bestellt.{:shortdesc}

**Wichtig**: Blockspeicher wird mit dem Zugriffsmodus `ReadWriteOnce` geliefert. Sie können ihn jeweils immer nur an einen Pod auf einem Workerknoten im Cluster anhängen.

Vorbemerkungen:
- Wenn Sie über eine Firewall verfügen, [gewähren Sie Egress-Zugriff](cs_firewall.html#pvc) für die IBM Cloud-Infrastruktur-IP-Bereiche (SoftLayer) der Zonen, in denen sich Ihre Cluster befinden, damit Sie Persistent Volume Claims (PVCs) erstellen können.
- Installieren Sie das [{{site.data.keyword.Bluemix_notm}}-Blockspeicher-Plug-in](#install_block).
- [Entscheiden Sie sich für eine vordefinierte Speicherklasse](#predefined_storageclass) oder erstellen Sie eine [angepasste Speicherklasse](#custom_storageclass). 

Gegen Sie wie folgt vor, um Blockspeicher hinzuzufügen:

1.  Erstellen Sie eine Konfigurationsdatei, um Ihren PVC zu definieren, und speichern Sie die Konfiguration als `.yaml`-Datei.

    -  **Beispiel für die Speicherklassen 'bronze', 'silver' und 'gold'**:
       Die folgende `.yaml`-Datei erstellt eine Anforderung mit dem Namen `mypvc` der Speicherklasse `"ibmc-block-silver"` und einer Abrechnung auf Stundenbasis (`"hourly"`) mit einer Größe von `24Gi`.  

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Beispiel für die Verwendung der Speicherklasse 'custom'**:
       Die folgende `.yaml`-Datei erstellt eine Anforderung mit dem Namen `mypvc` der Speicherklasse `ibmc-block-retain-custom` und einer Abrechnung auf Stundenbasis (`"hourly"`) mit einer Größe von `45Gi` und einer Anzahl von `"300"` E/A-Operationen pro Sekunde. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
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
        <td>Der Name der Speicherklasse, die Sie für die Bereitstellung von Blockspeicher verwenden möchten. </br> Wenn Sie keine Speicherklasse angeben, wird der persistente Datenträger mit der Standardspeicherklasse <code>ibmc-file-bronze</code> erstellt.<p>**Tipp:** Wenn Sie die Standardspeicherklasse ändern möchten, führen Sie den Befehl <code>kubectl patch storageclass &lt;speicherklasse&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> aus und ersetzen Sie <code>&lt;speicherklasse&gt;</code> durch den Namen der Speicherklasse.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Geben Sie die Häufigkeit an, mit der Ihre Speicherrechnung berechnet wird, monatlich ('monthly') oder stündlich ('hourly'). Der Standardwert ist 'hourly'.</td>
        </tr>
	<tr>
	<td><code>metadata/region</code></td>
        <td>Geben Sie die Region an, in der der Blockspeicher bereitgestellt werden soll. Bei Angabe der Region müssen Sie auch eine Zone angeben. Wenn Sie keine Region angeben oder die angegebene Region nicht gefunden wird, wird der Speicher in derselben Region wie Ihr Cluster erstellt.</br><strong>Anmerkung:</strong> Diese Option wird nur mit dem Block Storage-Plug-in Version 1.0.1 oder höher von IBM Cloud unterstützt. Wenn Sie einen Mehrzonencluster haben, wird bei älteren Plug-in-Versionen die Zone, in der Ihr Speicher bereitgestellt wird, im Umlaufverfahren ausgewählt, um die Datenträgeranforderungen gleichmäßig auf alle Zonen zu verteilen. Wenn Sie die Zone für Ihren Speicher angeben möchten, müssen Sie zuerst eine [angepasste Speicherklasse](#multizone_yaml) erstellen. Erstellen Sie anschließend einen PVC mit der angepassten Speicherklasse.</td>
	</tr>
	<tr>
	<td><code>metadata/zone</code></td>
	<td>Geben Sie die Zone an, in der der Blockspeicher bereitgestellt werden soll. Bei Angabe der Zone müssen Sie auch eine Region angeben. Wenn Sie keine Zone angeben oder die angegebene Zone in einem Mehrzonencluster nicht gefunden wird, wird die Zone im Umlaufverfahren ausgewählt.</br><strong>Anmerkung:</strong> Diese Option wird nur mit dem Block Storage-Plug-in Version 1.0.1 oder höher von IBM Cloud unterstützt. Wenn Sie einen Mehrzonencluster haben, wird bei älteren Plug-in-Versionen die Zone, in der Ihr Speicher bereitgestellt wird, im Umlaufverfahren ausgewählt, um die Datenträgeranforderungen gleichmäßig auf alle Zonen zu verteilen. Wenn Sie die Zone für Ihren Speicher angeben möchten, müssen Sie zuerst eine [angepasste Speicherklasse](#multizone_yaml) erstellen. Erstellen Sie anschließend einen PVC mit der angepassten Speicherklasse.</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Geben Sie die Größe des Blockspeichers in Gigabyte (Gi) an. </br></br><strong>Anmerkung:</strong> Nach dem Bereitstellen des Speichers können Sie die Größe Ihres Blockspeichers nicht mehr ändern. Stellen Sie sicher, dass Sie eine Größe angeben, die dem Umfang der Daten entspricht, die Sie speichern möchten. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Diese Option gilt nur für die angepassten Speicherklassen (`ibmc-block-custom / ibmc-block-retain-custom`). Geben Sie die Gesamtzahl der E/A-Operationen pro Sekunde für den Speicher an, indem Sie ein Vielfaches von 100 innerhalb des zulässigen Bereichs auswählen. Wenn Sie einen Wert für die E/A-Operationen pro Sekunde auswählen, der nicht aufgelistet ist, wird der Wert aufgerundet.</td>
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
      3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Erstellen Sie zum Anhängen des persistenten Datenträgers an Ihre Bereitstellung eine `.yaml`-Konfigurationsdatei und geben Sie den Persistent Volume Claim (PVC) an, der den persistenten Datenträger bindet.

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
    <td>Der Name des PVC, der den zu verwendenden persistenten Datenträger bindet.</td>
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




## Vorhandenen Blockspeicher in Ihrem Cluster verwenden
{: #existing_block}

Wenn Sie bereits über eine physische Speichereinheit verfügen, die Sie in Ihrem Cluster verwenden möchten, können Sie den persistenten Datenträger und den PVC manuell erstellen, um den Speicher [statisch bereitzustellen](cs_storage_basics.html#static_provisioning).

Bevor Sie mit dem Anhängen Ihres vorhandenen Speichers an eine App beginnen können, müssen Sie alle erforderlichen Informationen für Ihren persistenten Datenträger abrufen.  
{: shortdesc}

### Schritt 1: Informationen zu Ihrem vorhandenen Blockspeicher abrufen

1.  Rufen Sie einen API-Schlüssel für Ihr Konto der IBM Cloud-Infrastruktur (SoftLayer) ab oder generieren Sie einen API-Schlüssel.
    1. Melden Sie sich beim [Portal der IBM Cloud-Infrastruktur (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.bluemix.net/) an.
    2. Wählen Sie **Konto**, dann **Benutzer** und dann **Benutzerliste** aus.
    3. Suchen Sie nach Ihrer Benutzer-ID.
    4. Klicken Sie in der Spalte **API-SCHLÜSSEL** auf **Generieren**, um einen API-Schlüssel zu generieren, oder auf **Anzeigen**, um Ihren vorhandenen API-Schlüssel anzuzeigen.
2.  Rufen Sie den API-Benutzernamen für Ihr Konto der IBM Cloud-Infrastruktur (SoftLayer) ab.
    1. Wählen Sie im Menü **Benutzerliste** Ihre Benutzer-ID aus.
    2. Suchen Sie im Abschnitt **API-Zugriffsinformationen** nach Ihrem **API-Benutzernamen**.
3.  Melden Sie sich beim Befehlszeilen-Plug-in der IBM Cloud-Infrastruktur an.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  Wählen Sie die Authentifizierung anhand des Benutzernamens und API-Schlüssels für Ihr Konto der IBM Cloud-Infrastruktur (SoftLayer) aus.
5.  Geben Sie den Benutzernamen und den API-Schlüssel ein, die Sie in den vorherigen Schritten abgerufen haben.
6.  Listen Sie verfügbare Blockspeichereinheiten auf.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    Beispielausgabe:
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Notieren Sie sich die Angaben `id`, `ip_addr`, `capacity_gb`, das Rechenzentrum (`datacenter`) und `lunId` der Blockspeichereinheit, die Sie an Ihren Cluster anhängen möchten. **Anmerkung:** Wenn Sie einen vorhandenen Speicher an einen Cluster anhängen möchten, müssen Sie in derselben Zone, in der sich auch der Speicher befindet, einen Workerknoten haben. Um die Zone des Workerknotens zu überprüfen, führen Sie `ibmcloud ks workers <cluster_name_or_ID>` aus. 

### Schritt 2: Persistenten Datenträger (PV) und übereinstimmenden Persistent Volume Claim (PVC) erstellen

1.  Optional: Wenn Sie über Speicher verfügen, den Sie mit einer Speicherklasse des Typs `retain` bereitgestellt haben, werden der persistente Datenträger und die physische Speichereinheit beim Entfernen des Persistent Volume Claim (PVC) nicht entfernt. Zum Wiederverwenden des Speichers in Ihrem Cluster müssen Sie zuerst den persistenten Datenträger entfernen. 
    1. Listen Sie vorhandene persistente Datenträger auf.
```
       kubectl get pv
       ```
       {: pre}
     
       Suchen Sie den persistenten Datenträger, der zu Ihrem persistenten Speicher gehört. Der persistente Datenträger hat den Status 'freigegeben' (`released`). 
     
    2. Entfernen Sie den persistenten Datenträger.
```
       kubectl delete pv <pv-name>
       ```
       {: pre}
   
    3. Überprüfen Sie, dass der persistente Datenträger entfernt wurde.
```
       kubectl get pv
       ```
       {: pre}

2.  Erstellen Sie eine Konfigurationsdatei für Ihren persistenten Datenträger (PV). Geben Sie zum Blockspeicher die Angaben für `id`, `ip_addr`, `capacity_gb`, das Rechenzentrum (`datacenter`) und die `lunIdID` an, die Sie zuvor abgerufen haben.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region=<region>
         failure-domain.beta.kubernetes.io/zone=<zone>
    spec:
      capacity:
        storage: "<speichergröße>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs-typ>"
        options:
          "Lun": "<lun-id>"
          "TargetPortal": "<ip-adresse>"
          "VolumeID": "<datenträger-id>"
          "volumeName": "<datenträgername>"
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
    <td>Geben Sie den Namen des PV ein, das Sie erstellen möchten.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Geben Sie die Region und die Zone ein, die Sie zuvor abgerufen haben. Zum Anhängen des Speichers an Ihren Cluster müssen Sie mindestens einen Workerknoten in der Region und Zone haben, in der sich auch der persistente Speicher befindet. Wenn bereits ein persistenter Datenträger für Ihren Speicher vorhanden ist, [fügen Sie die Zonen- und Regionsbezeichnung](cs_storage_basics.html#multizone) zu Ihrem persistenten Datenträger hinzu.</tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>Geben Sie den Dateisystemtyp ein, der für den vorhandenen Blockspeicher konfiguriert ist. Wählen Sie zwischen <code>ext4</code> oder <code>xfs</code>. Wenn Sie diese Option nicht angeben, nimmt das PV standardmäßig den Wert <code>ext4</code> ein. Wenn der falsche Wert für 'fsType' definiert ist, ist zwar die PV-Erstellung erfolgreich, das Anhängen des PVs an einen Pod schlägt jedoch fehl. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Geben Sie die Speichergröße des vorhandenen Blockspeichers ein, den Sie im vorherigen Schritt als <code>capacity-gb</code> abgerufen haben. Die Größe des Speichers muss in Gigabyte angegeben werden, z. B. 20Gi (20 GB) oder 1000Gi (1 TB).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Geben Sie die LUN-ID für Ihren Blockspeicher ein, die Sie zuvor als <code>lunId</code> abgerufen haben.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Geben Sie die IP-Adresse Ihres Blockspeichers ein, die Sie zuvor als <code>ip_addr</code> abgerufen haben.</td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Geben Sie die ID Ihres Blockspeichers ein, die Sie zuvor als <code>id</code> abgerufen haben.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Geben Sie einen Namen für Ihren Datenträger ein.</td>
	    </tr>
    </tbody></table>

3.  Erstellen Sie das PV in Ihrem Cluster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. Überprüfen Sie, dass das PV erstellt wurde.
    ```
    kubectl get pv
    ```
    {: pre}

5. Erstellen Sie eine weitere Konfigurationsdatei, um Ihren Persistent Volume Claim (PVC) zu erstellen. Damit der Persistent Volume Claim (PVC) mit dem zuvor erstellten Persistent Volume übereinstimmt, müssen Sie denselben Wert für `storage` und `accessMode` auswählen. Das Feld `storage-class` muss leer sein. Wenn eines dieser Felder nicht mit dem PV (Persistent Volume) übereinstimmt, wird stattdessen automatisch ein neues PV erstellt.

     ```
     kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
     spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "<speichergröße>"
     ```
     {: codeblock}

6.  Erstellen Sie Ihren PVC.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  Überprüfen Sie, ob Ihr PVC erstellt und an das zuvor erstellte PV gebunden wurde. Dieser Prozess kann einige Minuten dauern.
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
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

Sie haben erfolgreich ein PV (Persistent Volume) erstellt und an einen PVC (Persistent Volume Claim) gebunden. Clusterbenutzer können jetzt den [PVC (Persistent Volume Claim) an ihre Bereitstellungen anhängen](#app_volume_mount) und mit dem Lesen und Schreiben in dem PV (Persistent Volume) beginnen.

<br />



## Daten sichern und wiederherstellen 
{: #backup_restore}

Der Blockspeicher wird an derselben Position wie die Workerknoten in Ihrem Cluster bereitgestellt. Der Speicher wird auf in Gruppen zusammengefassten Servern von IBM gehostet, um Verfügbarkeit sicherzustellen, falls ein Server ausfallen sollte. Der Blockspeicher wird jedoch nicht automatisch gesichert und ist möglicherweise nicht zugänglich, wenn der gesamte Standort fehlschlägt. Um Ihre Daten vor Verlust oder Beschädigung zu schützen, können Sie regelmäßige Sicherungen konfigurieren, mit denen Sie bei Bedarf Daten wiederherstellen können.

Überprüfen Sie die folgenden Optionen zum Sichern und Wiederherstellen Ihres Blockspeichers:

<dl>
  <dt>Regelmäßige Snapshots konfigurieren</dt>
  <dd><p>Sie können [für Ihren Blockspeicher das Erstellen regelmäßiger Snapshots](/docs/infrastructure/BlockStorage/snapshots.html#snapshots) konfigurieren. Dies ist ein schreibgeschütztes Image, das den Status der Instanz zu einem bestimmten Zeitpunkt erfasst. Um den Snapshot zu speichern, müssen Sie für den Snapshot Speicherplatz im Blockspeicher anfordern. Snapshots werden in der in derselben Zone vorhandenen Speicherinstanz gespeichert. Sie können Daten von einem Snapshot wiederherstellen, falls ein Benutzer versehentlich wichtige Daten von dem Datenträger entfernt. </br></br> <strong>Gehen Sie wie folgt vor, um einen Snapshot für den Datenträger zu erstellen: </strong><ol><li>Listen Sie alle vorhandenen PVs in Ihrem Cluster auf. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>Rufen Sie die Details für das PV ab, für das Snapshotspeicherplatz angefordert werden soll, und notieren Sie sich die Datenträger-ID, die Größe und die E/A-Operationen pro Sekunde (IOPS). <pre class="pre"><code>kubectl describe pv &lt;pv-name&gt;</code></pre> Die Größe und die Anzahl der E/A-Operationen pro Sekunde werden im Abschnitt <strong>Labels</strong> der CLI-Ausgabe angezeigt. Um die Datenträger-ID zu finden, überprüfen Sie die Annotation <code>ibm.io/network-storage-id</code> der CLI-Ausgabe. </li><li>Erstellen Sie die Snapshotgröße für den vorhandenen Datenträger mit den Parametern, die Sie im vorherigen Schritt abgerufen haben. <pre class="pre"><code>slcli block snapshot-order --capacity &lt;größe&gt; --tier &lt;iops&gt; &lt;datenträger-id&gt;</code></pre></li><li>Warten Sie, bis die Snapshotgröße erstellt wurde. <pre class="pre"><code>slcli block volume-detail &lt;datenträger-id&gt;</code></pre>Die Snapshotgröße wird erfolgreich bereitgestellt, wenn der Wert für <strong>Snapshot Capacity (GB)</strong> in der CLI-Ausgabe von '0' in die von Ihnen angeforderte Größe geändert wird. </li><li>Erstellen Sie einen Snapshot für den Datenträger und notieren Sie die ID des von Sie erstellten Snapshots. <pre class="pre"><code>slcli block snapshot-create &lt;datenträger-id&gt;</code></pre></li><li>Überprüfen Sie, dass der Snapshot erfolgreich erstellt wurde. <pre class="pre"><code>slcli block volume-detail &lt;snapshot-id&gt;</code></pre></li></ol></br><strong>Gehen Sie wie folgt vor, um Daten aus einem Snapshot auf einem vorhandenen Datenträger wiederherzustellen: </strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot-id&gt; &lt;datenträger-id&gt;</code></pre></p></dd>
  <dt>Snapshots in eine andere Zone replizieren</dt>
 <dd><p>Um Daten vor einem Zonenausfall zu schützen, können Sie in einer Blockspeicherinstanz, die in einer anderen Zone konfiguriert ist, [Snapshots replizieren](/docs/infrastructure/BlockStorage/replication.html#replicating-data). Daten können nur aus dem primären Speicher an den Sicherungsspeicher repliziert werden. Sie können eine replizierte Blockspeicherinstanz nicht an einen Cluster anhängen. Wenn Ihr primärer Speicher fehlschlägt, können Sie Ihren replizierten Sicherungsspeicher manuell als primären Speicher festlegen. Anschließend können Sie ihn an den Cluster anhängen. Nachdem Ihr primärer Speicher wiederhergestellt wurde, können Sie die Daten aus dem Sicherungsspeicher wiederherstellen.</p></dd>
 <dt>Speicher duplizieren</dt>
 <dd><p>Sie können Ihre [Blockspeicherinstanz in derselben Zone duplizieren](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume), in der sich auch die ursprüngliche Speicherinstanz befindet. Ein Duplikat hat dieselben Daten wie die Originalspeicherinstanz zu dem Zeitpunkt, an dem das Duplikat erstellt wurde. Verwenden Sie das Duplikat - im Gegensatz zu den Replikaten - als unabhängige Speicherinstanz. Erstellen Sie zur Vorbereitung einer Duplizierung zunächst Snapshots für den Datenträger.</p></dd>
  <dt>Daten in {{site.data.keyword.cos_full}} sichern</dt>
  <dd><p>Sie können den Befehl [**ibm-backup-restore image**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) verwenden, damit ein Pod für Sicherung und Wiederherstellung in Ihrem Cluster den Betrieb aufnimmt. Dieser Pod enthält ein Script zur Ausführung einer einmaligen oder regelmäßigen Sicherung für alle PVCs (Persistent Volume Claims) in Ihrem Cluster. Die Daten werden in Ihrer {{site.data.keyword.cos_full}}-Instanz gespeichert, die Sie in einer Zone konfiguriert haben.</p><strong>Anmerkung:</strong> Blockspeicher wird mit dem RWO-Zugriffsmodus (ReadWriteOnce) angehängt. Dieser Zugriff ermöglicht, dass gleichzeitig nur ein einziger Pod an den Blockspeicher angehängt werden kann. Zum Sichern Ihrer Daten müssen Sie den Speicher von Ihrem App-Pod abhängen, ihn an Ihren Sicherungspod anhängen, die Daten sichern und den Speicher wieder an Ihren App-Pod anhängen.</br></br>
Damit Ihre Daten noch besser hoch verfügbar sind und um Ihre App vor einem Zonenausfall zu schützen, konfigurieren Sie eine zweite {{site.data.keyword.cos_full}}-Instanz und replizieren Sie die Daten zonenübergreifend. Falls Sie Daten von Ihrer {{site.data.keyword.cos_full}}-Instanz wiederherstellen müssen, verwenden Sie das Wiederherstellungsscript, das mit dem Image bereitgestellt wird.</dd>
<dt>Daten in und aus Pods und Containern kopieren</dt>
<dd><p>Sie können den [Befehl ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) `kubectl cp` verwenden, um Dateien und Verzeichnisse in und aus Pods oder spezifischen Containern in Ihrem Cluster zu kopieren.</p>
<p>Führen Sie zunächst den folgenden Schritt aus: [Geben Sie als Ziel Ihrer Kubernetes-CLI](cs_cli_install.html#cs_cli_configure) den gewünschten Cluster an. Wenn Sie keinen Container mit <code>-c</code> angeben, verwendet der Befehl den ersten verfügbaren Container im Pod.</p>
<p>Sie können den Befehl auf verschiedene Weisen verwenden:</p>
<ul>
<li>Kopieren Sie Daten von Ihrer lokalen Maschine in einen Pod in Ihrem Cluster: <pre class="pre"><code>kubectl cp <var>&lt;lokaler_dateipfad&gt;/&lt;dateiname&gt;</var> <var>&lt;namensbereich&gt;/&lt;pod&gt;:&lt;dateipfad_des_pods&gt;</var></code></pre></li>
<li>Kopieren Sie Daten von einem Pod in Ihrem Cluster auf Ihre lokale Maschine: <pre class="pre"><code>kubectl cp <var>&lt;namensbereich&gt;/&lt;pod&gt;:&lt;dateipfad_des_pods&gt;/&lt;dateiname&gt;</var> <var>&lt;lokaler_dateipfad&gt;/&lt;dateiname&gt;</var></code></pre></li>
<li>Kopieren Sie Daten von einem Pod in Ihrem Cluster in einen spezifischen Container in einem anderen Pod: <pre class="pre"><code>kubectl cp <var>&lt;namensbereich&gt;/&lt;pod&gt;:&lt;dateipfad_des_pods&gt;</var> <var>&lt;namensbereich&gt;/&lt;anderer_pod&gt;:&lt;dateipfad_des_pods&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Speicherklassenreferenz
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Blockspeicherklasse: bronze</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>ext4</td>
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
<td>Der Standardabrechnungstyp hängt von der Version Ihres Block Storage-Plug-ins von {{site.data.keyword.Bluemix_notm}} ab: <ul><li> Ab Version 1.0.1: Auf Stundenbasis (Hourly)</li><li>Bis Version 1.0.0: Monatlich (Monthly)</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### Silver
{: #silver}

<table>
<caption>Blockspeicherklasse: silver</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>ext4</td>
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
<td>Der Standardabrechnungstyp hängt von der Version Ihres Block Storage-Plug-ins von {{site.data.keyword.Bluemix_notm}} ab: <ul><li> Ab Version 1.0.1: Auf Stundenbasis (Hourly)</li><li>Bis Version 1.0.0: Monatlich (Monthly)</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Blockspeicherklasse: gold</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Endurance-Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>ext4</td>
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
<td>Der Standardabrechnungstyp hängt von der Version Ihres Block Storage-Plug-ins von {{site.data.keyword.Bluemix_notm}} ab: <ul><li> Ab Version 1.0.1: Auf Stundenbasis (Hourly)</li><li>Bis Version 1.0.0: Monatlich (Monthly)</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Custom
{: #custom}

<table>
<caption>Blockspeicherklasse: custom</caption>
<thead>
<th>Merkmale</th>
<th>Einstellung</th>
</thead>
<tbody>
<tr>
<td>Name</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>Typ</td>
<td>[Performance ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Dateisystem</td>
<td>ext4</td>
</tr>
<tr>
<td>E/A-Operationen pro Sekunde (IOPS) und Größe</td>
<td><strong>Größenbereich in Gigabyte / IOPS-Bereich in Vielfachen von 100</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Festplatte</td>
<td>Das Verhältnis zwischen der Anzahl E/A-Operationen pro Sekunde und Gigabyte bestimmt den Typ der Festplatte, die bereitgestellt wird. Um das Verhältnis zwischen der Anzahl E/A-Operationen pro Sekunde zu Gigabyte zu bestimmen, teilen Sie die Anzahl E/A-Operationen pro Sekunde durch die Größe Ihres Speichers.</br></br>Beispiel: </br>Sie wählen 500 Gigabyte (500Gi) Speicher mit 100 E/A-Operationen pro Sekunde. Ihr Verhältnis ist 0,2 (100 E/A-Operationen pro Sekunde/500 Gigabyte). </br></br><strong>Zuordnung Festplattentypen/Verhältnis – Übersicht:</strong><ul><li>Kleiner-gleich 0,3: SATA</li><li>Größer als 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Abrechnung</td>
<td>Der Standardabrechnungstyp hängt von der Version Ihres Block Storage-Plug-ins von {{site.data.keyword.Bluemix_notm}} ab: <ul><li> Ab Version 1.0.1: Auf Stundenbasis (Hourly)</li><li>Bis Version 1.0.0: Monatlich (Monthly)</li></ul></td>
</tr>
<tr>
<td>Preisstruktur</td>
<td>[Informationen zur Preisstruktur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Beispiele für angepasste Speicherklassen (custom)
{: #custom_storageclass}

### Zone angeben (bei Mehrzonencluster)
{: #multizone_yaml}

Die folgende `.yaml`-Datei passt eine Speicherklasse an, die auf der Speicherklasse `ibm-block-silver` ohne 'retain' (Beibehaltung) basiert: Der Typ (`type`) ist `"Endurance"`, der Wert für `iopsPerGB` ist `4`, der Wert für `sizeRange` ist `"[20-12000]Gi"` und für `reclaimPolicy` wird die Einstellung `"Delete"` festgelegt. Die Zone wird als `dal12` angegeben. Als Unterstützung für die Festlegung von zulässigen Werten können Sie die oben stehenden Informationen zu `ibmc`-Speicherklassen erneut lesen.</br>

Lesen Sie in der [Speicherklassenreferenz](#storageclass_reference) nach, wenn Sie eine andere Speicherklasse als Basis verwenden möchten. 

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Blockspeicher mit einem `XFS`-Dateisystem anhängen
{: #xfs}

Im folgenden Beispiel wird eine Speicherklasse mit dem Namen `ibmc-block-custom-xfs` erstellt, die Performance-Blockspeicher mit dem Dateisystem `XFS` bereitstellt. 

```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-block-custom-xfs
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
   provisioner: ibm.io/ibmc-block
   parameters:
     type: "Performance"
     sizeIOPSRange: |-
       [20-39]Gi:[100-1000]
       [40-79]Gi:[100-2000]
       [80-99]Gi:[100-4000]
       [100-499]Gi:[100-6000]
       [500-999]Gi:[100-10000]
       [1000-1999]Gi:[100-20000]
       [2000-2999]Gi:[200-40000]
       [3000-3999]Gi:[200-48000]
       [4000-7999]Gi:[300-48000]
       [8000-9999]Gi:[500-48000]
       [10000-12000]Gi:[1000-48000]
  fsType: "xfs"
     reclaimPolicy: "Delete"
     classVersion: "2"
```
{: codeblock}

<br />

