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




# Archiviazione di dati in IBM File Storage per IBM Cloud
{: #file_storage}


## Decisioni relative alla configurazione dell'archiviazione file
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} fornisce delle classi di archiviazione predefinite per l'archiviazione file che puoi utilizzare per eseguire il provisioning di archiviazione file con una specifica configurazione.
{: shortdesc}

Ogni classe di archiviazione specifica il tipo di archiviazione file di cui esegui il provisioning, compresi la dimensione disponibile, il file system IOPS e la politica di conservazione.  

**Importante:** assicurati di scegliere la tua configurazione di archiviazione attentamente per disporre di sufficiente capacità per archiviare i tuoi dati. Dopo che hai eseguito il provisioning di uno specifico tipo di archiviazione utilizzando una classe di archiviazione, non puoi modificare la dimensione, il tipo, l'IOPS e la politica di conservazione per il dispositivo di archiviazione. Se hai bisogno di più archiviazione oppure di un'archiviazione con una configurazione differente, devi [creare una nuova istanza di archiviazione e copiare i dati](cs_storage_basics.html#update_storageclass) dalla vecchia istanza di archiviazione a quella nuova.

1. Elenca le classi di archiviazione disponibili in {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep file
    ```
    {: pre}

    Output di esempio:
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

2. Esamina la configurazione di una classe di archiviazione.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Per ulteriori informazioni su ciascuna classe di archiviazione, vedi la sezione di [riferimento delle classi di archiviazione](#storageclass_reference). Se non trovi quello che stai cercando, considera la possibilità di creare una tua classe di archiviazione personalizzata. Per iniziare, controlla gli [esempi di classe di archiviazione personalizzata](#custom_storageclass).
   {: tip}

3. Scegli il tipo di archiviazione file di cui desideri eseguire il provisioning.
   - **Classi di archiviazione bronze, silver e gold:** queste classi di archiviazione eseguono il provisioning di [archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage). L'archiviazione Endurance ti consente di scegliere la dimensione dell'archiviazione in gigabyte in livelli IOPS predefiniti.
   - **Classe di archiviazione personalizzata:** questa classe di archiviazione esegue il provisioning di [archiviazione Performance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/performance-storage). Con l'archiviazione Performance, hai più controllo sulla dimensione dell'archiviazione e sull'IOPS.

4. Scegli la dimensione e l'IOPS per la tua archiviazione file. La dimensione e il numero di IOPS definiscono il numero totale di IOPS (operazioni di input/ output al secondo) che funge da indicatore della rapidità della tua archiviazione. Più IOPS totale ha la tua archiviazione e più rapidamente elabora le operazioni di lettura e scrittura.
   - **Classi di archiviazione bronze, silver e gold:** queste classi di archiviazione vengono fornite con un numero fisso di IOPS per gigabyte e ne viene eseguito il provisioning su dischi rigidi SSD. Il numero totale di IOPS dipende dalla dimensione dell'archiviazione che scegli. Puoi selezionare qualsiasi numero intero di gigabyte all'interno dell'intervallo di dimensioni consentite, come ad esempio 20 Gi, 256 Gi o 11854 Gi. Per determinare il numero totale di IOPS, devi moltiplicare l'IOPS con la dimensione selezionata. Ad esempio, se selezioni una dimensione di archiviazione file di 1000Gi nella classe di archiviazione silver che viene fornita con 4 IOPS per GB, la tua archiviazione ha un totale di 4000 IOPS.
     <table>
         <caption>Tabella di intervalli di dimensioni della classe di archiviazione e IOPS per gigabyte</caption>
         <thead>
         <th>Classe di archiviazione</th>
         <th>IOPS per gigabyte</th>
         <th>Intervallo di dimensioni in gigabyte</th>
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
   - **Classe di archiviazione personalizzata:** quando scegli questa classe di archiviazione, hai più controllo sulla dimensione e sull'IOPS che desideri. Per la dimensione, puoi selezionare qualsiasi numero intero di gigabyte all'interno dell'intervallo di dimensioni consentito. La dimensione da te scelta determina l'intervallo IOPS a tua disposizione. Puoi scegliere un IOPS che è un multiplo di 100 che è compreso nell'intervallo specificato. L'IOPS che scegli è statico e non ridimensiona l'archiviazione. Ad esempio, se scegli 40Gi con 100 IOPS, l'IOPS totale rimane 100. </br></br> Anche il rapporto IOPS-gigabyte determina il tipo di disco rigido di cui viene eseguito il provisioning per tuo conto. Ad esempio, se hai 500Gi a 100 IOPS, il tuo rapporto IOPS-gigabyte è 0,2. Il provisioning dell'archiviazione con un rapporto inferiore o uguale a 0,3 viene eseguito sui dischi rigidi SATA. Se il tuo rapporto è superiore a 0,3, il provisioning della tua archiviazione viene eseguito su dischi rigidi SSD.  
     <table>
         <caption>Tabella di intervalli di dimensioni della classe di archiviazione personalizzata e IOPS</caption>
         <thead>
         <th>Intervallo di dimensioni in gigabyte</th>
         <th>Intervallo di IOPS in multipli di 100</th>
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

5. Scegli se vuoi mantenere i tuoi dati dopo l'eliminazione del cluster o dell'attestazione del volume persistente (o PVC, persistent volume claim).
   - Se vuoi conservare i tuoi dati, scegli una classe di archiviazione `retain`. Quando elimini il PVC, viene eliminato solo il PVC. Il PV, il dispositivo di archiviazione fisico nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) e i tuoi dati permangono. Per reclamare l'archiviazione e utilizzarla nuovamente nel tuo cluster, devi rimuovere il PV e attenerti alla procedura per l'[utilizzo dell'archiviazione file esistente](#existing_file).
   - Se vuoi che il PV, i dati e il tuo dispositivo di archiviazione file fisico vengano eliminati quando elimini la PVC, scegli una classe di archiviazione senza `retain`.

6. Scegli se preferisci una fatturazione oraria o mensile. Per ulteriori informazioni, controlla la sezione relativa ai [prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/file-storage/pricing). Per impostazione predefinita, il provisioning di tutti i dispositivi di archiviazione file viene eseguito con un tipo di fatturazione oraria.
   **Nota:** se scegli un tipo di fatturazione mensile, quando rimuovi l'archiviazione persistente pagherai comunque l'addebito mensile per essa, anche se l'hai usata solo per un breve periodo di tempo.

<br />



## Aggiunta di archiviazione file alle applicazioni
{: #add_file}

Crea un'attestazione del volume persistente (o PVC, persistent volume claim) per [eseguire dinamicamente il provisioning](cs_storage_basics.html#dynamic_provisioning) di archiviazione file per il tuo cluster. Il provisioning dinamico crea automaticamente il volume persistente (o PV, persistent volume) corrispondente e ordina il dispositivo di archiviazione fisico nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).
{:shortdesc}

Prima di iniziare:
- Se hai un firewall, [consenti l'accesso in uscita](cs_firewall.html#pvc) per gli intervalli IP dell'infrastruttura IBM Cloud (SoftLayer) delle zone in cui si trovano i tuoi cluster, in modo da poter creare le PVC. 
- [Decidi in merito alla classe di archiviazione predefinita](#predefined_storageclass) oppure crea una [classe di archiviazione personalizzata](#custom_storageclass).

  **Suggerimento:** se hai un cluster multizona, la zona in cui viene eseguito il provisioning della tua archiviazione è selezionata su una base round-robin per bilanciare equamente le richieste volume tra tutte le zone. Se vuoi specificare la zona per la tua archiviazione, crea prima una [classe di archiviazione personalizzata](#multizone_yaml). Attieniti quindi alla procedura in questo argomento per eseguire l provisioning di archiviazione utilizzando la tua classe di archiviazione personalizzata.

Per aggiungere l'archiviazione file:

1.  Crea un file di configurazione per definire la tua attestazione del volume persistente (o PVC, persistent volume claim) e salva la configurazione come un file `.yaml`.

    -  **Esempio per le classi di archiviazione bronze, silver e gold**:
       il seguente file `.yaml` crea un'attestazione denominata `mypvc` della classe di archiviazione`"ibmc-file-silver"`, fatturata mensilmente (`"monthly"`), con una dimensione in gigabyte di `24Gi`.

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

    -  **Esempio per l'utilizzo della classe di archiviazione personalizzata**:
       il seguente file `.yaml` crea un'attestazione denominata `mypvc` della classe di archiviazione `ibmc-file-retain-custom`, fatturata su base oraria (`"hourly"`), con una dimensione in gigabyte di `45Gi` e un IOPS di `"300"`.

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
        <caption>Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Immetti il nome della PVC.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>Il nome della classe di archiviazione che vuoi utilizzare per eseguire il provisioning dell'archiviazione file. </br> Se non specifichi una classe di archiviazione, il PV viene creato con la classe di archiviazione predefinita <code>ibmc-file-bronze</code><p>**Suggerimento:** se vuoi modificare la classe di archiviazione predefinita, esegui <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> e sostituisci <code>&lt;storageclass&gt;</code> con il nome della classe di archiviazione.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Specifica la frequenza per la quale viene calcolata la fattura di archiviazione, "mensile" o "oraria". Se non specifichi un tipo di fatturazione, viene eseguito il provisioning dell'archiviazione con un tipo di fatturazione oraria. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Immetti la dimensione dell'archiviazione file, in gigabyte (Gi). </br></br><strong>Nota: </strong> dopo che è stato eseguito il provisioning della tua archiviazione, non puoi modificare la dimensione della tua archiviazione file. Assicurati di specificare una dimensione che corrisponda alla quantità di dati che desideri memorizzare. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Questa opzione è disponibile solo per le classi di archiviazione personalizzate (`ibmc-file-custom / ibmc-file-retain-custom`). Specifica l'IOPS totale per l'archiviazione, selezionando un multiplo di 100 nell'intervallo consentito. Se scegli un IOPS diverso da quello elencato, viene arrotondato per eccesso.</td>
        </tr>
        </tbody></table>

    Se vuoi utilizzare una classe di archiviazione personalizzata, crea il tuo PVC con il nome della classe di archiviazione corrispondente, una dimensione e un IOPS validi.   
    {: tip}

2.  Crea la PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  Verifica che la tua PVC sia stata creata e associata al PV. Questo processo può richiedere qualche minuto.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Output di esempio:

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

4.  {: #app_volume_mount}Per montare l'archiviazione nella tua distribuzione, crea un file `.yaml` di configurazione e specifica la PVC che esegue il bind del PV.

    Se hai un'applicazione che richiede che un utente non root scriva nell'archiviazione persistente oppure un'applicazione che richiede che il percorso di montaggio appartenga all'utente root, vedi [Aggiunta di accesso utente non root all'archiviazione file NFS](cs_troubleshoot_storage.html#nonroot) o [Abilitazione dell'autorizzazione root per l'archiviazione file NFS](cs_troubleshoot_storage.html#nonroot).
    {: tip}

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
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>Un'etichetta per la distribuzione.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>Un'etichetta per la tua applicazione.</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Un'etichetta per la distribuzione.</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>Il nome dell'immagine che vuoi utilizzare. Per elencare le immagini disponibili nel tuo account {{site.data.keyword.registryshort_notm}}, esegui `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>Il nome del contenitore che vuoi distribuire al tuo cluster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>Il percorso assoluto della directory in cui viene montato il volume nel contenitore.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>Il nome del volume per montare il tuo pod.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Il nome del volume per montare il tuo pod. Normalmente questo nome è lo stesso di <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>Il nome della PVC che esegue il bind del PV che vuoi utilizzare.</td>
    </tr>
    </tbody></table>

5.  Crea la distribuzione.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  Verifica che il PV venga montato correttamente.

     ```
     kubectl describe deployment <deployment_name>
     ```
     {: pre}

     Il punto di montaggio è nel campo **Montaggi volume** e il volume nel campo **Volumi**.

     ```
      Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
     ...
     Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false
     ```
     {: screen}

<br />




## Utilizzo dell'archiviazione file esistente nel tuo cluster
{: #existing_file}

Se hai un dispositivo di archiviazione fisico esistente che vuoi usare nel tuo cluster, puoi creare manualmente il PV e la PVC per [eseguire in modo statico il provisioning](cs_storage_basics.html#static_provisioning) dell'archiviazione.

Prima di iniziare, devi assicurarti di avere almeno un nodo di lavoro che esiste nella stessa zona della tua istanza di archiviazione file esistente.

### Passo 1: Preparazione della tua archiviazione esistente.

Prima di poter iniziare a montare la tua archiviazione esistente in un'applicazione, devi richiamare tutte le informazioni necessarie per il tuo PV e preparare l'archiviazione in modo che sia accessibile nel tuo cluster.  

**Per l'archiviazione di cui è stato eseguito il provisioning con una classe di archiviazione `retain`:** </br>
Se hai eseguito il provisioning con una classe di archiviazione `retain` e rimuovi la PVC, il PV e il dispositivo di archiviazione fisico non vengono rimossi automaticamente. Per riutilizzare l'archiviazione nel tuo cluster, devi rimuovere prima il PV rimanente.

Per utilizzare l'archiviazione esistente in un cluster diverso da quello dove ne hai eseguito il provisioning, attieniti alla procedura per l'[archiviazione che era stata creata esternamente al cluster](#external_storage) per aggiungere l'archiviazione alla sottorete del tuo nodo di lavoro.
{: tip}

1. Elenca i PV esistenti.
   ```
   kubectl get pv
   ```
   {: pre}

   Cerca il PV che appartiene alla tua archiviazione persistente. Il PV è in uno stato `released`.

2. Ottieni i dettagli del PV.
   ```
   kubectl describe pv <pv_name>
   ```
   {: pre}

3. Prendi nota di `CapacityGb`, `storageClass`, `failure-domain.beta.kubernetes.io/region`, `failure-domain.beta.kubernetes.io/zone`, `server` e `path`.

4. Rimuovi il PV.
   ```
   kubectl delete pv <pv_name>
   ```
   {: pre}

5. Verifica che il PV venga rimosso.
   ```
   kubectl get pv
   ```
   {: pre}

</br>

**Per l'archiviazione persistente di cui era stato eseguito il provisioning esternamente al cluster:** </br>
Se vuoi utilizzare l'archiviazione esistente di cui avevi eseguito il provisioning in precedenza ma che non hai mai usato nel tuo cluster in precedenza, devi renderla disponibile nella stessa sottorete dei tuoi nodi di lavoro.

1.  {: #external_storage}Dal [portale dell'infrastruttura IBM Cloud (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://control.bluemix.net/), fai clic su **Archiviazione**.
2.  Fai clic su **Archiviazione file** e dal menu **Azioni**, seleziona **Autorizza host**.
3.  Seleziona **Sottoreti**.
4.  Dall'elenco a discesa, seleziona la sottorete VLAN privata a cui è connesso il nodo di lavoro. Per trovare la sottorete del tuo nodo di lavoro, esegui `ibmcloud ks workers <cluster_name>` e confronta l'`IP privato` del tuo nodo di lavoro con la sottorete che hai trovato nell'elenco a discesa.
5.  Fai clic su **Invia**.
6.  Fai clic sul nome dell'archiviazione file.
7.  Prendi nota dei campi `Mount Point`, `size` e `Location`. Il campo `Mount Point` viene visualizzato come `<server>:/<path>`.

### Passo 2: Creazione di un volume persistente (o PV, persistent volume) e di un'attestazione del volume persistente (o PVC, persistent volume claim) corrispondente

1.  Crea un file di configurazione dell'archiviazione per il tuo PV. Includi i valori che hai richiamato in precedenza.

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
       storage: "<size>"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "<nfs_server>"
       path: "<file_storage_path>"
    ```
    {: codeblock}

    <table>
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Immetti il nome dell'oggetto del PV da creare.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Immetti la regione e la zona che hai richiamato in precedenza. Devi disporre di almeno un nodo di lavoro nella stessa regione e nella stessa zona della tua archiviazione persistente per montare l'archiviazione nel tuo cluster. Se un PV per la tua archiviazione già esiste, [aggiungi l'etichetta di zona e regione](cs_storage_basics.html#multizone) al tuo PV.
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Immetti la dimensione di archiviazione della condivisione file NFS esistente che hai richiamato in precedenza. La dimensione di archiviazione deve essere scritta in gigabyte, ad esempio, 20Gi (20 GB) o 1000Gi (1 TB) e deve corrispondere alla dimensione della condivisione file esistente.</td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Immetti l'ID server della condivisione file NFS che hai richiamato in precedenza.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Immetti il percorso alla condivisione file NFS che hai richiamato in precedenza.</td>
    </tr>
    </tbody></table>

3.  Crea il PV nel tuo cluster.

    ```
    kubectl apply -f deploy/kube-config/mypv.yaml
    ```
    {: pre}

4.  Verifica che il PV sia stato creato.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Crea un altro file di configurazione per creare la tua PVC. Affinché la PVC corrisponda al PV che hai creato in precedenza, devi scegliere lo stesso valore per `storage` e `accessMode`. Il campo `storage-class` deve essere vuoto. Se qualcuno di questi campi non corrisponde al PV, viene [dinamicamente eseguito il provisioning](cs_storage_basics.html#dynamic_provisioning) di un nuovo PV e di una nuova istanza di archiviazione fisica.

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
         storage: "<size>"
    ```
    {: codeblock}

6.  Crea la tua PVC.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Verifica che la tua PVC sia stata creata e associata al PV. Questo processo può richiedere qualche minuto.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Output di esempio:

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


Hai creato correttamente un PV e lo hai collegato ad una PVC. Gli utenti del cluster possono ora [montare la PVC](#app_volume_mount) nelle proprie distribuzioni e iniziare a leggere e a scrivere sull'oggetto del PV.

<br />



## Modifica della versione NFS predefinita
{: #nfs_version}

La versione dell'archiviazione file determina il protocollo che viene utilizzato per comunicare con il server dell'archiviazione file {{site.data.keyword.Bluemix_notm}}. Per impostazione predefinita, le istanze dell'archiviazione file sono configurate con NFS versione 4. Puoi modificare il PV esistente con una versione precedente di NFS se la tua applicazione richiede una versione specifica per funzionare correttamente.
{: shortdesc}

Per modificare la versione NFS predefinita, puoi creare una nuova classe di archiviazione per fornire l'archiviazione file in modo dinamico al tuo cluster oppure scegliere un PV esistente montato nel tuo pod.

**Importante:** per applicare gli ultimi aggiornamenti di sicurezza e per prestazioni migliori, utilizza la versione NFS predefinita e non modificare NFS ad una versione precedente.

**Per creare una classe di archiviazione personalizzata con la versione NFS desiderata:**
1. Crea una [classe di archiviazione personalizzata](#nfs_version_class) con la versione NFS di cui desideri eseguire il provisioning.
2. Crea la classe di archiviazione nel tuo cluster.
   ```
   kubectl apply -f <filepath/nfsversion_storageclass.yaml>
   ```
   {: pre}

3. Verifica che la classe di archiviazione personalizzata sia stata creata.
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. Esegui il provisioning dell'[archiviazione file](#add_file) con la tua classe di archiviazione personalizzata.

**Per modificare il tuo PV esistente in modo che utilizzi una versione NFS differente:**

1. Ottieni il PV dell'archiviazione file di cui vuoi modificare la versione NFS e prendi nota del nome del PV.
   ```
   kubectl get pv
   ```
   {: pre}

2. Aggiungi un'annotazione al tuo PV. Sostituisci `<version_number>` con la versione NFS che vuoi utilizzare. Ad esempio per modificare la versione NFS con la 3.0, immetti **3**.  
   ```
   kubectl patch pv <pv_name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<version_number>"}}}'
   ```
   {: pre}

3. Elimina il pod che utilizza l'archiviazione file e ricrealo.
   1. Salva il file yaml del pod nella tua macchina locale.
      ```
      kubect get pod <pod_name> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. Elimina il pod.
      ```
      kubectl deleted pod <pod_name>
      ```
      {: pre}

   3. Ricrea il pod.
      ```
      kubectl apply -f <filepath/pod.yaml>
      ```
      {: pre}

4. Attendi che il pod venga distribuito.
   ```
   kubectl get pods
   ```
   {: pre}

   Il pod è completamente distribuito quando lo stato viene modificato con `In esecuzione`.

5. Accedi al tuo pod.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. Verifica che l'archiviazione file sia stata montata con la versione NFS da te specificata precedentemente.
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   Output di esempio:
   ```
   nfs vers=3.0
   ```
   {: screen}

<br />


## Backup e ripristino di dati
{: #backup_restore}

Il provisioning dell'archiviazione file viene eseguito nella stessa ubicazione dei nodi di lavoro nel tuo cluster. L'archiviazione viene ospitata sui server in cluster da IBM per offrire la disponibilità in caso di arresto di un server. Tuttavia, non viene eseguito il backup automatico dell'archiviazione file e potrebbe essere inaccessibile se si verifica un malfunzionamento dell'intera ubicazione. Per evitare che i tuoi dati vengano persi o danneggiati, puoi configurare dei backup periodici che puoi utilizzare per ripristinare i dati quando necessario.
{: shortdesc}

Esamina le seguenti opzioni di backup e ripristino per la tua archiviazione file:

<dl>
  <dt>Configura istantanee periodiche</dt>
  <dd><p>Puoi [configurare delle istantanee periodiche per la tua archiviazione file](/docs/infrastructure/FileStorage/snapshots.html), che è un'immagine di sola lettura che acquisisce lo stato dell'istanza in un punto nel tempo. Per archiviare l'istantanea, devi richiedere lo spazio per l'istantanea nella tua archiviazione file. Le istantanee vengono archiviate nell'istanza di archiviazione esistente all'interno della stessa zona. Puoi ripristinare i dati da un'istantanea se un utente rimuove accidentalmente dati importanti dal volume. </br></br> <strong>Per creare un'istantanea per il tuo volume:</strong><ol><li>Elenca i PV esistenti nel tuo cluster. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>Ottieni i dettagli del PV per cui vuoi creare uno spazio per l'istantanea e prendi nota dell'ID volume, della dimensione e dell'IOPS. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> L'ID volume, la dimensione e l'IOPS possono essere trovati nella sezione <strong>Etichette</strong> del tuo output della CLI. </li><li>Crea la dimensione dell'istantanea per il tuo volume esistente con i parametri che hai richiamato nel passo precedente. <pre class="pre"><code>slcli file snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Attendi che la dimensione dell'istantanea venga creata. <pre class="pre"><code>slcli file volume-detail &lt;volume_id&gt;</code></pre>La dimensione dell'istantanea viene fornita correttamente quando la <strong>Capacità dell'istantanea (GB)</strong> nel tuo output della CLI viene modificata da 0 con la dimensione che hai ordinato. </li><li>Crea l'istantanea per il tuo volume e prendi nota dell'ID dell'istantanea che ti viene creata. <pre class="pre"><code>slcli file snapshot-create &lt;volume_id&gt;</code></pre></li><li>Verifica che l'istantanea sia stata creata correttamente. <pre class="pre"><code>slcli file volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>Per ripristinare i dati da un'istantanea in un volume esistente: </strong><pre class="pre"><code>slcli file snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>Replica le istantanee in un'altra zona</dt>
 <dd><p>Per proteggere i tuoi dati da un malfunzionamento dell'ubicazione, puoi [replicare le istantanee](/docs/infrastructure/FileStorage/replication.html#replicating-data) in un'istanza di archiviazione file configurata in un'altra zona. I dati possono essere replicati solo dall'archiviazione primaria a quella di backup. Non puoi montare un'istanza di archiviazione file replicata in un cluster. Quando la tua archiviazione primaria non funziona più, puoi impostare manualmente la tua archiviazione di backup replicata in modo che sia quella primaria. Quindi, puoi montarla nel tuo cluster. Una volta ripristinata la tua archiviazione primaria, puoi ripristinare i dati dall'archiviazione di backup. </p></dd>
 <dt>Duplica l'archiviazione</dt>
 <dd><p>Puoi [duplicare la tua istanza di archiviazione file](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage) nella stessa zona dell'istanza di archiviazione originale. Un duplicato contiene gli stessi dati dell'istanza di archiviazione originale nel momento in cui è stato creato il duplicato. A differenza delle repliche, puoi utilizzare il duplicato come un'istanza di archiviazione indipendente dall'originale. Per eseguire la duplicazione, per prima cosa [configura le istantanee per il volume](/docs/infrastructure/FileStorage/snapshots.html).</p></dd>
  <dt>Esegui il backup dei dati in {{site.data.keyword.cos_full}}</dt>
  <dd><p>Puoi utilizzare l'[**immagine ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) per avviare un pod di backup e ripristino nel tuo cluster. Questo pod contiene uno script per eseguire un backup una tantum o periodico per qualsiasi attestazione del volume persistente (PVC) nel tuo cluster. I dati vengono archiviati nella tua istanza {{site.data.keyword.cos_full}} che hai configurato in una zona.</p>
  <p>Per rendere i tuoi dati ancora più disponibili e proteggere la tua applicazione da un errore di zona, configura una seconda istanza {{site.data.keyword.cos_full}} e replica i dati tra le varie zone. Se devi ripristinare i dati dalla tua istanza {{site.data.keyword.cos_full}}, utilizza lo script di ripristino fornito con l'immagine.</p></dd>
<dt>Copia i dati nei/dai pod e contenitori</dt>
<dd><p>Puoi utilizzare il comando `kubectl cp` [![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) per copiare i file e le directory in/da pod o specifici contenitori nel tuo cluster.</p>
<p>Prima di iniziare, [indirizza la tua CLI Kubernetes](cs_cli_install.html#cs_cli_configure) al cluster che desideri utilizzare. Se non specifichi un contenitore con <code>-c</code>, il comando utilizza il primo contenitore disponibile nel pod.</p>
<p>Puoi utilizzare il comando in diversi modi:</p>
<ul>
<li>Copiare i dati dalla tua macchina locale in un pod nel tuo cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copiare i dati da un pod nel tuo cluster nella tua macchina locale: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copiare i dati da un pod nel tuo cluster in uno specifico contenitore in un altro pod: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Riferimento delle classi di archiviazione
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Classe di archiviazione file: bronze</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-file-bronze</code></br><code>ibmc-file-retain-bronze</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS per gigabyte</td>
<td>2</td>
</tr>
<tr>
<td>Intervallo di dimensioni in gigabyte</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Disco rigido</td>
<td>SSD</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Oraria</td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>


### Silver
{: #silver}

<table>
<caption>Classe di archiviazione file: silver</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-file-silver</code></br><code>ibmc-file-retain-silver</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS per gigabyte</td>
<td>4</td>
</tr>
<tr>
<td>Intervallo di dimensioni in gigabyte</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Disco rigido</td>
<td>SSD</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Oraria</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Classe di archiviazione file: gold</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-file-gold</code></br><code>ibmc-file-retain-gold</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS per gigabyte</td>
<td>10</td>
</tr>
<tr>
<td>Intervallo di dimensioni in gigabyte</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>Disco rigido</td>
<td>SSD</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Oraria</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Personalizzata
{: #custom}

<table>
<caption>Classe di archiviazione file: custom</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-file-custom</code></br><code>ibmc-file-retain-custom</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Performance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS e dimensione</td>
<td><p><strong>Intervallo di dimensioni in gigabyte / intervallo di IOPS in multipli di 100</strong></p><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disco rigido</td>
<td>Il rapporto IOPS-gigabyte determina il tipo di disco rigido di cui viene eseguito il provisioning. Per determinare il tuo rapporto IOPS/gigabyte, dividi l'IOPS per la dimensione della tua archiviazione. </br></br>Esempio: </br>Hai scelto 500Gi di archiviazione con 100 IOPS. Il tuo rapporto è 0,2 (100 IOPS/500Gi). </br></br><strong>Panoramica dei tipi di disco rigido per rapporto:</strong><ul><li>Inferiore o uguale a 0,3: SATA</li><li>Maggiore di 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Oraria</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Classi di archiviazione personalizzate di esempio
{: #custom_storageclass}

### Specifica della zona per i cluster a multizona
{: #multizone_yaml}

Il seguente file `.yaml` personalizza una classe di archiviazione basata sulla classe di archiviazione di non conservazione `ibm-file-silver`: il `type` è `"Endurance"`, l'`iopsPerGB` è `4`, il `sizeRange` è `"[20-12000]Gi"` e la `reclaimPolicy` è impostata su `"Delete"`. La zona viene specificata come `dal12`. Puoi esaminare le informazioni precedenti nelle classi di archiviazione `ibmc` per un ausilio nella scelta di valori accettabili per esse,</br>

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

+### Modifica della versione NFS predefinita
{: #nfs_version_class}

La seguente classe di archiviazione personalizzata è basata sulla [classe di archiviazione `ibmc-file-bronze`](#bronze) e ti consente di definire la versione NFS di cui desideri eseguire il provisioning. Ad esempio, per eseguire il provisioning di NFS versione 3.0, sostituisci `<nfs_version>` con **3.0**.
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
     mountOptions: nfsvers=<nfs_version>
```
{: codeblock}
