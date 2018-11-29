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





# Archiviazione di dati in IBM Block Storage per IBM Cloud
{: #block_storage}


## Installazione del plug-in {{site.data.keyword.Bluemix_notm}} Block Storage nel tuo cluster
{: #install_block}

Installa il plug-in {{site.data.keyword.Bluemix_notm}} Block Storage con un grafico Helm per impostare le classi di archiviazione predefinite per l'archiviazione blocchi. Puoi utilizzare queste classi di archiviazione per creare una PVC per eseguire il provisioning dell'archiviazione blocchi per le tue applicazioni.
{: shortdesc}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Assicurati che il tuo nodo di lavoro applichi la patch più recente per la tua versione secondaria. 
   1. Elenca la versione patch corrente dei tuoi nodi di lavoro.
      ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}
      
      Output di esempio: 
      ```
      OK
      ID                                                  Public IP        Private IP     Machine Type           State    Status   Zone    Version   
      kube-dal10-crb1a23b456789ac1b20b2nc1e12b345ab-w26   169.xx.xxx.xxx    10.xxx.xx.xxx   b2c.4x16.encrypted     normal   Ready    dal10   1.9.10_1523* 
      ```
      {: screen}
      
      Se il tuo nodo di lavoro non applica la versione patch più recente, viene visualizzato un asterisco (`*`) nella colonna **Versione** del tuo output della CLI. 
      
   2. Esamina il [changelog di versione](cs_versions_changelog.html#changelog) per trovare le modifiche incluse nella versione patch più recente. 
   
   3. Applica la versione patch più recente ricaricando il tuo nodo di lavoro. Segui le istruzioni nel [comando ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reload) per ripianificare correttamente qualsiasi pod in esecuzione sul tuo nodo di lavoro prima di ricaricare il nodo.

2. Attieniti alle [istruzioni](cs_integrations.html#helm) per installare il client Helm sulla tua macchina locale, installare il server Helm (tiller) nel tuo cluster e aggiungere il repository di grafici {{site.data.keyword.Bluemix_notm}} Helm al cluster dove vuoi utilizzare il plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.

   **Importante:** se utilizzi Helm versione 2.9 o successive, assicurati di avere installato tiller con un [account di servizio](cs_integrations.html#helm).

3. Aggiorna il repository Helm per richiamare la versione più recente di tutti i grafici Helm in questo repository.
   ```
   helm repo update
   ```
   {: pre}

4. Installa il plug-in {{site.data.keyword.Bluemix_notm}} Block Storage. Quando installi il plug-in, al tuo cluster vengono aggiunte le classi di archiviazione blocchi predefinite.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Output di esempio:
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

5. Verifica che l'installazione sia stata eseguita correttamente.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Output di esempio:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   L'installazione ha avuto esito positivo quando visualizzi un pod `ibmcloud-block-storage-plugin` e uno o più pod `ibmcloud-block-storage-driver`. Il numero di pod `ibmcloud-block-storage-driver` è uguale al numero di nodi di lavoro nel tuo cluster. Tutti i pod devono essere in uno stato **In esecuzione**.

6. Verifica che le classi di archiviazione per l'archiviazione blocchi siano state aggiunte al tuo cluster.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Output di esempio:
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

7. Ripeti questa procedura per ogni cluster in cui desideri eseguire il provisioning dell'archiviazione blocchi.

Ora puoi continuare a [creare una PVC](#add_block) per eseguire il provisioning dell'archiviazione blocchi per la tua applicazione.


### Aggiornamento del plug-in {{site.data.keyword.Bluemix_notm}} Block Storage
Puoi eseguire l'upgrade del plug-in {{site.data.keyword.Bluemix_notm}} Block Storage esistente alla versione più recente.
{: shortdesc}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Aggiorna il repository Helm per richiamare la versione più recente di tutti i grafici helm in questo repository.
   ```
   helm repo update
   ```
   {: pre}

2. Facoltativo: scarica il grafico helm più recente sulla tua macchina locale. Decomprimi quindi il pacchetto ed esamina il file `release.md` per trovare le informazioni sulla release più recenti.
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. Trova il nome del grafico Helm dell'archiviazione blocchi che hai installato nel tuo cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Output di esempio:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. Aggiorna il plug-in {{site.data.keyword.Bluemix_notm}} Block Storage alla versione più recente.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. Facoltativo; quando aggiorni il plug-in, la classe di archiviazione `default` non è impostata. Se vuoi impostare la classe di archiviazione predefinita su una classe di archiviazione di tua scelta, esegui questo comando.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### Rimozione del plug-in {{site.data.keyword.Bluemix_notm}} Block Storage
Se non vuoi eseguire il provisioning di {{site.data.keyword.Bluemix_notm}} Block Storage e farne uso nel tuo cluster, puoi disinstallare il grafico Helm.
{: shortdesc}

**Nota:** la rimozione del plug-in non rimuove PVC, PV o dati esistenti. Quando rimuovi il plug-in, tutti i pod e le serie di daemon correlati vengono rimossi dal tuo cluster. Non puoi eseguire il provisioning di una nuova archiviazione blocchi per il tuo cluster o utilizzare i PV e le PVC dell'archiviazione blocchi esistente una volta rimosso il plug-in.

Prima di iniziare:
- [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
- Assicurati di non avere PVC o PV nel tuo cluster che utilizzano l'archiviazione blocchi.

Per rimuovere il plug-in:

1. Trova il nome del grafico Helm dell'archiviazione blocchi che hai installato nel tuo cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Output di esempio:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Elimina il plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. Verifica che i pod dell'archiviazione blocchi siano stati rimossi.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   La rimozione dei pod è riuscita se nel tuo output CLI non vengono visualizzati pod.

4. Verifica che le classi di archiviazione dell'archiviazione blocchi siano state rimosse.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   La rimozione delle classi di archiviazione è riuscita se nel tuo output CLI non vengono visualizzate classi di archiviazione.

<br />



## Decisioni relative alla configurazione dell'archiviazione blocchi
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} fornisce delle classi di archiviazione predefinite per l'archiviazione blocchi che puoi utilizzare per eseguire il provisioning di archiviazione blocchi con una specifica configurazione.
{: shortdesc}

Ogni classe di archiviazione specifica il tipo di archiviazione blocchi di cui esegui il provisioning, compresi la dimensione disponibile, il file system IOPS e la politica di conservazione.  

**Importante:** assicurati di scegliere la tua configurazione di archiviazione attentamente per disporre di sufficiente capacità per archiviare i tuoi dati. Dopo che hai eseguito il provisioning di uno specifico tipo di archiviazione utilizzando una classe di archiviazione, non puoi modificare la dimensione, il tipo, l'IOPS e la politica di conservazione per il dispositivo di archiviazione. Se hai bisogno di più archiviazione oppure di un'archiviazione con una configurazione differente, devi [creare una nuova istanza di archiviazione e copiare i dati](cs_storage_basics.html#update_storageclass) dalla vecchia istanza di archiviazione a quella nuova.

1. Elenca le classi di archiviazione disponibili in {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep block
    ```
    {: pre}

    Output di esempio:
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

2. Esamina la configurazione di una classe di archiviazione.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Per ulteriori informazioni su ciascuna classe di archiviazione, vedi la sezione di [riferimento delle classi di archiviazione](#storageclass_reference). Se non trovi quello che stai cercando, considera la possibilità di creare una tua classe di archiviazione personalizzata. Per iniziare, controlla gli [esempi di classe di archiviazione personalizzata](#custom_storageclass).
   {: tip}

3. Scegli il tipo di archiviazione blocchi di cui desideri eseguire il provisioning.
   - **Classi di archiviazione bronze, silver e gold:** queste classi di archiviazione eseguono il provisioning di [archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage). L'archiviazione Endurance ti consente di scegliere la dimensione dell'archiviazione in gigabyte in livelli IOPS predefiniti.
   - **Classe di archiviazione personalizzata:** questa classe di archiviazione esegue il provisioning di [archiviazione Performance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/performance-storage). Con l'archiviazione Performance, hai più controllo sulla dimensione dell'archiviazione e sull'IOPS.

4. Scegli la dimensione e l'IOPS per la tua archiviazione blocchi. La dimensione e il numero di IOPS definiscono il numero totale di IOPS (operazioni di input/ output al secondo) che funge da indicatore della rapidità della tua archiviazione. Più IOPS totale ha la tua archiviazione e più rapidamente elabora le operazioni di lettura e scrittura.
   - **Classi di archiviazione bronze, silver e gold:** queste classi di archiviazione vengono fornite con un numero fisso di IOPS per gigabyte e ne viene eseguito il provisioning su dischi rigidi SSD. Il numero totale di IOPS dipende dalla dimensione dell'archiviazione che scegli. Puoi selezionare qualsiasi numero intero di gigabyte all'interno dell'intervallo di dimensioni consentite, come ad esempio 20 Gi, 256 Gi o 11854 Gi. Per determinare il numero totale di IOPS, devi moltiplicare l'IOPS con la dimensione selezionata. Ad esempio, se selezioni una dimensione di archiviazione blocchi di 1000Gi nella classe di archiviazione silver che viene fornita con 4 IOPS per GB, la tua archiviazione ha un totale di 4000 IOPS  
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
   - **Classe di archiviazione personalizzata:** quando scegli questa classe di archiviazione, hai più controllo sulla dimensione e sull'IOPS che desideri. Per la dimensione, puoi selezionare qualsiasi numero intero di gigabyte all'interno dell'intervallo di dimensioni consentito. La dimensione da te scelta determina l'intervallo IOPS a tua disposizione. Puoi scegliere un IOPS che è un multiplo di 100 che è compreso nell'intervallo specificato. L'IOPS che scegli è statico e non ridimensiona l'archiviazione. Ad esempio, se scegli 40Gi con 100 IOPS, l'IOPS totale rimane 100. </br></br>Anche il rapporto IOPS-gigabyte determina il tipo di disco rigido di cui viene eseguito il provisioning per tuo conto. Ad esempio, se hai 500Gi a 100 IOPS, il tuo rapporto IOPS-gigabyte è 0,2. Il provisioning dell'archiviazione con un rapporto inferiore o uguale a 0,3 viene eseguito sui dischi rigidi SATA. Se il tuo rapporto è superiore a 0,3, il provisioning della tua archiviazione viene eseguito su dischi rigidi SSD.
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
   - Se vuoi conservare i tuoi dati, scegli una classe di archiviazione `retain`. Quando elimini la PVC, viene eliminata solo la PVC. Il PV, il dispositivo di archiviazione fisico nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) e i tuoi dati permangono. Per reclamare l'archiviazione e utilizzarla nuovamente nel tuo cluster, devi rimuovere il PV e attenerti alla procedura per l'[utilizzo dell'archiviazione blocchi esistente](#existing_block).
   - Se vuoi che il PV, i dati e il tuo dispositivo di archiviazione blocchi fisico vengano eliminati quando elimini la PVC, scegli una classe di archiviazione senza `retain`.

6. Scegli se preferisci una fatturazione oraria o mensile. Per ulteriori informazioni, controlla la sezione relativa ai [prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/block-storage/pricing). Per impostazione predefinita, il provisioning di tutti i dispositivi di archiviazione blocchi viene eseguito con un tipo di fatturazione oraria.

<br />



## Aggiunta di archiviazione blocchi alle applicazioni
{: #add_block}

Crea un'attestazione del volume persistente (o PVC, persistent volume claim) per [eseguire dinamicamente il provisioning](cs_storage_basics.html#dynamic_provisioning) di archiviazione blocchi per il tuo cluster. Il provisioning dinamico crea automaticamente il volume persistente (o PV, persistent volume) corrispondente e ordina il dispositivo di archiviazione effettivo nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).
{:shortdesc}

**Importante**: l'archiviazione blocchi viene fornita con una modalità di accesso `ReadWriteOnce`. Puoi montarla su un solo pod in un nodo di lavoro nel cluster alla volta.

Prima di iniziare:
- Se hai un firewall, [consenti l'accesso in uscita](cs_firewall.html#pvc) per gli intervalli IP dell'infrastruttura IBM Cloud (SoftLayer) delle zone in cui si trovano i tuoi cluster, in modo da poter creare le PVC.
- Installa il [plugin {{site.data.keyword.Bluemix_notm}}](#install_block) Block Storage.
- [Decidi in merito alla classe di archiviazione predefinita](#predefined_storageclass) oppure crea una [classe di archiviazione personalizzata](#custom_storageclass).

Intendi esporre l'archiviazione blocchi in una serie con stato? Vedi [Utilizzo dell'archiviazione blocchi in una serie con stato](#block_statefulset) per ulteriori informazioni.
{: tip}

Per aggiungere l'archiviazione blocchi:

1.  Crea un file di configurazione per definire la tua attestazione del volume persistente (o PVC, persistent volume claim) e salva la configurazione come un file `.yaml`.

    -  **Esempio per le classi di archiviazione bronze, silver, gold**:
       Il seguente file `.yaml` crea un'attestazione denominata `mypvc` della classe di archiviazione `"ibmc-block-silver"`, con fatturazione oraria (`"hourly"`) e una dimensione in gigabyte di `24Gi`.

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

    -  **Esempio per l'utilizzo della classe di archiviazione personalizzata**:
       il seguente file `.yaml` crea un'attestazione denominata `mypvc` della classe di archiviazione `ibmc-block-retain-custom`, fatturata su base oraria (`"hourly"`), con una dimensione in gigabyte di `45Gi` e un IOPS di `"300"`.

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
       <caption>Descrizione dei componenti del file YAML</caption>
       <thead>
       <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
       </thead>
       <tbody>
       <tr>
       <td><code>metadata.name</code></td>
       <td>Immetti il nome della PVC.</td>
       </tr>
       <tr>
       <td><code>metadata.annotations</code></td>
       <td>Il nome della classe di archiviazione che vuoi utilizzare per eseguire il provisioning dell'archiviazione blocchi. </br> Se non specifichi una classe di archiviazione, il PV viene creato con la classe di archiviazione predefinita <code>ibmc-file-bronze</code><p>**Suggerimento:** se vuoi modificare la classe di archiviazione predefinita, esegui <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> e sostituisci <code>&lt;storageclass&gt;</code> con il nome della classe di archiviazione.</p></td>
       </tr>
       <tr>
         <td><code>metadata.labels.billingType</code></td>
         <td>Specifica la frequenza per la quale viene calcolata la fattura di archiviazione, "mensile" o "oraria". Il valore predefinito è "hourly".</td>
       </tr>
       <tr>
       <td><code>metadata.labels.region</code></td>
       <td>Specifica la regione in cui desideri eseguire il provisioning dell'archiviazione blocchi. Se specifichi la regione, devi specificare anche una zona. Se non specifichi una regione, o se la regione specificata non viene trovata, l'archiviazione viene creata nella stessa regione del tuo cluster. </br><strong>Nota:</strong> questa opzione è supportata solo con il plug-in IBM Cloud Block Storage versione 1.0.1 o successive. Per le versioni del plug-in meno recenti, se hai un cluster multizona, la zona in cui viene eseguito il provisioning della tua archiviazione è selezionata su una base round-robin per bilanciare equamente le richieste di volume tra tutte le zone. Se vuoi specificare la zona per la tua archiviazione, crea prima una [classe di archiviazione personalizzata](#multizone_yaml). Crea quindi una PVC on la tua classe di archiviazione personalizzata.</td>
       </tr>
       <tr>
       <td><code>metadata.labels.zone</code></td>
	<td>Specifica la zona in cui desideri eseguire il provisioning dell'archiviazione blocchi. Se specifichi la zona, devi specificare anche una regione. Se non specifichi una zona o se la zona specificata non viene trovata in un cluster multizona, la zona viene selezionata su una base round-robin. </br><strong>Nota:</strong> questa opzione è supportata solo con il plug-in IBM Cloud Block Storage versione 1.0.1 o successive. Per le versioni del plug-in meno recenti, se hai un cluster multizona, la zona in cui viene eseguito il provisioning della tua archiviazione è selezionata su una base round-robin per bilanciare equamente le richieste di volume tra tutte le zone. Se vuoi specificare la zona per la tua archiviazione, crea prima una [classe di archiviazione personalizzata](#multizone_yaml). Crea quindi una PVC on la tua classe di archiviazione personalizzata.</td>
	</tr>
        <tr>
        <td><code>spec.resources.requests.storage</code></td>
        <td>Immetti la dimensione dell'archiviazione blocchi, in gigabyte (Gi). </br></br><strong>Nota: </strong> dopo che è stato eseguito il provisioning della tua archiviazione, non puoi modificare la dimensione della tua archiviazione blocchi. Assicurati di specificare una dimensione che corrisponda alla quantità di dati che desideri memorizzare. </td>
        </tr>
        <tr>
        <td><code>spec.resources.requests.iops</code></td>
        <td>Questa opzione è disponibile solo per le classi di archiviazione personalizzate (`ibmc-block-custom / ibmc-block-retain-custom`). Specifica l'IOPS totale per l'archiviazione, selezionando un multiplo di 100 nell'intervallo consentito. Se scegli un IOPS diverso da quello elencato, viene arrotondato per eccesso.</td>
        </tr>
        </tbody></table>

    Se vuoi utilizzare una classe di archiviazione personalizzata, crea la tua PVC con il nome della classe di archiviazione corrispondente, una dimensione e un IOPS validi.   
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
      3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Per montare il PV nella tua distribuzione, crea un file `.yaml` di configurazione e specifica la PVC che esegue il bind del PV.

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
    <td><code>metadata.labels.app</code></td>
    <td>Un'etichetta per la distribuzione.</td>
      </tr>
      <tr>
        <td><code>spec.selector.matchLabels.app</code> <br/> <code>spec.template.metadata.labels.app</code></td>
        <td>Un'etichetta per la tua applicazione.</td>
      </tr>
    <tr>
    <td><code>template.metadata.labels.app</code></td>
    <td>Un'etichetta per la distribuzione.</td>
      </tr>
    <tr>
    <td><code>spec.containers.image</code></td>
    <td>Il nome dell'immagine che vuoi utilizzare. Per elencare le immagini disponibili nel tuo account {{site.data.keyword.registryshort_notm}}, esegui `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec.containers.name</code></td>
    <td>Il nome del contenitore che vuoi distribuire al tuo cluster.</td>
    </tr>
    <tr>
    <td><code>spec.containers.volumeMounts.mountPath</code></td>
    <td>Il percorso assoluto della directory in cui viene montato il volume nel contenitore. I dati scritti nel percorso di montaggio vengono memorizzati nella directory root nella tua istanza di archiviazione blocchi fisica. Per creare delle directory nella tua istanza di archiviazione blocchi fisica, devi creare delle sottodirectory nel tuo percorso di montaggio.</td>
    </tr>
    <tr>
    <td><code>spec.containers.volumeMounts.name</code></td>
    <td>Il nome del volume per montare il tuo pod.</td>
    </tr>
    <tr>
    <td><code>volumes.name</code></td>
    <td>Il nome del volume per montare il tuo pod. Normalmente questo nome è lo stesso di <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes.persistentVolumeClaim.claimName</code></td>
    <td>Il nome della PVC che esegue il bind del PV che vuoi utilizzare. </td>
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




## Utilizzo dell'archiviazione blocchi esistente nel tuo cluster
{: #existing_block}

Se hai un dispositivo di archiviazione fisico esistente che vuoi usare nel tuo cluster, puoi creare manualmente il PV e la PVC per [eseguire in modo statico il provisioning](cs_storage_basics.html#static_provisioning) dell'archiviazione.

Prima di iniziare a montare la tua archiviazione esistente in un'applicazione, devi richiamare tutte le informazioni necessarie per il tuo PV.  
{: shortdesc}

### Passo 1: Richiamo delle informazioni della tua archiviazione blocchi esistente

1.  Recupera o genera una chiave API per il tuo account dell'infrastruttura IBM Cloud (SoftLayer).
    1. Accedi al [portale dell'infrastruttura IBM Cloud (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://control.bluemix.net/).
    2. Seleziona **Account**, quindi **Utenti** e quindi **Elenco utenti**.
    3. Trova il tuo ID utente.
    4. Nella colonna **Chiave API**, fai clic su **Genera** per generare una chiave API oppure su **Visualizza** per visualizzare la tua chiave API esistente.
2.  Recupera il nome utente API per il tuo account dell'infrastruttura IBM Cloud (SoftLayer).
    1. Dal menu **Elenco utenti**, seleziona il tuo ID utente.
    2. Nella sezione **Informazioni di accesso API**, trova il tuo **Nome utente API**.
3.  Accedi al plugin della CLI dell'infrastruttura IBM Cloud.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  Scegli di eseguire l'autenticazione utilizzando il nome utente e la chiave API per il tuo account dell'infrastruttura IBM Cloud (SoftLayer).
5.  Immetti il nome utente e la chiave API che hai recuperato nei passi precedenti.
6.  Elenca i dispositivi di archiviazione blocchi disponibili.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    Output di esempio:
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Prendi nota di `id`, `ip_addr`, `capacity_gb`, `datacenter` e `lunId` del dispositivo di archiviazione blocchi che vuoi montare nel tuo cluster. **Nota:** per montare l'archiviazione esistente in un cluster, devi disporre di un nodo di lavoro nella stessa zona della tua archiviazione. Per verificare la zona del tuo nodo di lavoro, esegui `ibmcloud ks workers <cluster_name_or_ID>`.

### Passo 2: Creazione di un volume persistente (o PV, persistent volume) e di un'attestazione del volume persistente (o PVC, persistent volume claim) corrispondente

1.  Facoltativo: se hai dell'archiviazione di cui hai eseguito il provisioning con una classe di archiviazione `retain`, quando rimuovi la PVC, il PV e il dispositivo di archiviazione fisico non vengono rimossi. Per riutilizzare l'archiviazione nel tuo cluster, devi prima rimuovere il PV.
    1. Elenca i PV esistenti.
       ```
       kubectl get pv
       ```
       {: pre}

       Cerca il PV che appartiene alla tua archiviazione persistente. Il PV è in uno stato `released`.

    2. Rimuovi il PV.
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}

    3. Verifica che il PV venga rimosso.
       ```
       kubectl get pv
       ```
       {: pre}

2.  Crea un file di configurazione per il tuo PV. Includi `id`, `ip_addr`, `capacity_gb`, `datacenter` e `lunIdID` dell'archiviazione blocchi che hai richiamato in precedenza.

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
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
      ```
      {: codeblock}

    <table>
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata.name</code></td>
    <td>Immetti il nome del PV che desideri creare.</td>
    </tr>
    <tr>
    <td><code>metadata.labels</code></td>
    <td>Immetti la regione e la zona che hai richiamato in precedenza. Devi disporre di almeno un nodo di lavoro nella stessa regione e nella stessa zona della tua archiviazione persistente per montare l'archiviazione nel tuo cluster. Se un PV per la tua archiviazione già esiste, [aggiungi l'etichetta di zona e regione](cs_storage_basics.html#multizone) al tuo PV.
    </tr>
    <tr>
    <td><code>spec.flexVolume.fsType</code></td>
    <td>Immetti il tipo di file system configurato per la tua archiviazione blocchi esistente. Scegli tra <code>ext4</code> o <code>xfs</code>. Se non specifichi questa opzione, viene utilizzato il valore predefinito del PV <code>ext4</code>. Quando viene definito il fsType sbagliato, la creazione del PV ha esito positivo ma il montaggio del PV in un pod ha esito negativo. </td></tr>	    
    <tr>
    <td><code>spec.capacity.storage</code></td>
    <td>Immetti la dimensione di archiviazione dell'archiviazione blocchi esistente che hai recuperato nel passo precedente come <code>capacity-gb</code>. La dimensione di archiviazione deve essere scritta in gigabyte, ad esempio, 20Gi (20 GB) o 1000Gi (1 TB).</td>
    </tr>
    <tr>
    <td><code>flexVolume.options.Lun</code></td>
    <td>Immetti l'ID lun per la tua archiviazione blocchi che hai richiamato precedentemente come <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume.options.TargetPortal</code></td>
    <td>Immetti l'indirizzo IP dell'archiviazione blocchi che hai richiamato in precedenza come <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume.options.VolumeId</code></td>
	    <td>Immetti l'ID della tua archiviazione blocchi che hai richiamato in precedenza come <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume.options.volumeName</code></td>
		    <td>Immetti un nome per il tuo volume.</td>
	    </tr>
    </tbody></table>

3.  Crea il PV nel tuo cluster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. Verifica che il PV sia stato creato.
    ```
    kubectl get pv
    ```
    {: pre}

5. Crea un altro file di configurazione per creare la tua PVC. Affinché la PVC corrisponda al PV che hai creato in precedenza, devi scegliere lo stesso valore per `storage` e `accessMode`. Il campo `storage-class` deve essere vuoto. Se uno di questi campi non corrisponde al PV, verrà creato automaticamente un nuovo PV.

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
          storage: "<storage_size>"
     ```
     {: codeblock}

6.  Crea la tua PVC.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  Verifica che la tua PVC sia stata creata e collegata al PV che hai creato in precedenza. Questo processo può richiedere qualche minuto.
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
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

Hai creato correttamente un PV e lo hai collegato ad una PVC. Gli utenti del cluster ora possono [montare la PVC](#app_volume_mount) nelle loro distribuzioni e iniziare a leggere e a scrivere nel PV.

<br />



## Utilizzo dell'archiviazione blocchi in una serie con stato
{: #block_statefulset}

Se hai un'applicazione con stato, come ad esempio un database, puoi creare delle serie con stato che utilizzano l'archiviazione blocchi per memorizzare i dati della tua applicazione. In alternativa, puoi utilizzare un DBaaS (database-as-a-service) {{site.data.keyword.Bluemix_notm}} e memorizzare i tuoi dati sul cloud.
{: shortdesc}

**Cosa devo sapere quando aggiungo l'archiviazione blocchi a una serie con stato?** </br>
Per aggiungere l'archiviazione a una serie con stato, devi specificare la tua configurazione di archiviazione nella sezione `volumeClaimTemplates` del file YAML della serie con stato. La sezione `volumeClaimTemplates` è la base per la tua PVC e può includere la classe di archiviazione e la dimensione o l'IOPS della tua archiviazione blocchi di cui desideri eseguire il provisioning. Tuttavia, se vuoi includere etichette in `volumeClaimTemplates`, Kubernetes non le include durante la creazione della PVC. Devi invece aggiungere le etichette direttamente alla tua serie con stato.

**Importante:** non puoi distribuire due serie con stato contemporaneamente. Se tenti di creare una serie con stato prima ne venga completamente distribuita un'altra, la distribuzione della tua serie con stato potrebbe portare a risultati imprevisti.

**Come posso creare la mia serie con stato in una zona specifica?** </br>
In un cluster multizona, puoi specificare la zona e la regione in cui vuoi creare la serie con stato nella sezione `spec.selector.matchLabels` e `spec.template.metadata.labels` del file YAML della serie con stato. In alternativa, puoi aggiungere queste etichette a una [classe di archiviazione personalizzata](cs_storage_basics.html#customized_storageclass) e utilizzare questa classe di archiviazione nella sezione `volumeClaimTemplates` della tua serie con stato. 

**Quali opzioni ho per aggiungere l'archiviazione blocchi a una serie con stato?** </br>
Se vuoi creare automaticamente la tua PVC quando crei la serie con stato, utilizza il [provisioning dinamico](#dynamic_statefulset). Puoi anche scegliere di eseguire il [pre-provisioning delle PVC o utilizzare PVC esistenti](#static_statefulset) con la tua serie con stato.  

### Provisioning dinamico della PVC quando crei una serie con stato
{: #dynamic_statefulset}

Utilizza questa opzione se vuoi creare automaticamente la PVC quando crei la serie con stato.
{: shortdesc}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Verifica che tutte le serie con stato esistenti nel tuo cluster siano state completamente distribuite. Se una serie con stato è ancora in fase di distribuzione, non puoi iniziare a creare la tua serie con stato. Devi attendere che tutte le serie con stato nel tuo cluster vengano distribuite completamente per evitare risultati imprevisti.
   1. Elenca le serie con stato esistenti nel tuo cluster.
      ```
      kubectl get statefulset --all-namespaces
      ```
      {: pre}

      Output di esempio:
      ```
      NAME              DESIRED   CURRENT   AGE
      mystatefulset     3         3         6s
      ```
      {: screen}

   2. Visualizza la sezione **Pods Status** di ogni serie con stato per assicurarti che la distribuzione della serie con stato sia terminata.  
      ```
      kubectl describe statefulset <statefulset_name>
      ```
      {: pre}

      Output di esempio:
      ```
      Name:               nginx
      Namespace:          default
      CreationTimestamp:  Fri, 05 Oct 2018 13:22:41 -0400
      Selector:           app=nginx,billingType=hourly,region=us-south,zone=dal10
      Labels:             app=nginx
                          billingType=hourly
                          region=us-south
                          zone=dal10
      Annotations:        kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"apps/v1beta1","kind":"StatefulSet","metadata":{"annotations":{},"name":"nginx","namespace":"default"},"spec":{"podManagementPolicy":"Par...
      Replicas:           3 desired | 3 total
      Pods Status:        0 Running / 3 Waiting / 0 Succeeded / 0 Failed
      Pod Template:
        Labels:  app=nginx
                 billingType=hourly
                 region=us-south
                 zone=dal10
      ...
      ```
      {: screen}

      Una serie con stato è completamente distribuita quando il numero di repliche che trovi nella sezione **Replicas** dell'output della CLI è uguale al numero di pod in stato **Running** nella sezione **Pods Status**. Se una serie con stato non è ancora completamente distribuita, attendi fino al termine della distribuzione prima di procedere.

3. Crea un file di configurazione per la tua serie con stato e il servizio che utilizzi per esporre la serie con stato. Il seguente esempio mostra come distribuire nginx come serie con stato con 3 repliche. Per ogni replica, viene eseguito il provisioning di un dispositivo di archiviazione blocchi da 20 gigabyte in base alle specifiche definite nella classe di archiviazione `ibmc-block-retain-bronze`. Il provisioning di tutti i dispositivi di archiviazione viene eseguito nella zona `dal10`. Poiché non è possibile accedere all'archiviazione blocchi da altre zone, anche tutte le repliche della serie con stato vengono distribuite su un nodo di lavoro che si trova in `dal10`.

   ```
   apiVersion: v1
   kind: Service
   metadata:
    name: nginx
    labels:
      app: nginx
   spec:
    ports:
    - port: 80
      name: web
    clusterIP: None
    selector:
      app: nginx
   ---
   apiVersion: apps/v1beta1
   kind: StatefulSet
   metadata:
    name: nginx
   spec:
    serviceName: "nginx"
    replicas: 3
    podManagementPolicy: Parallel
    selector:
      matchLabels:
        app: nginx
        billingType: "hourly"
        region: "us-south"
        zone: "dal10"
    template:
      metadata:
        labels:
          app: nginx
          billingType: "hourly"
          region: "us-south"
          zone: "dal10"
      spec:
        containers:
        - name: nginx
          image: k8s.gcr.io/nginx-slim:0.8
          ports:
          - containerPort: 80
            name: web
          volumeMounts:
          - name: myvol
            mountPath: /usr/share/nginx/html
    volumeClaimTemplates:
    - metadata:
        annotations:
          volume.beta.kubernetes.io/storage-class: ibmc-block-retain-bronze
        name: myvol
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 20Gi
            iops: "300" #required only for performance storage
   ```
   {: codeblock}

   <table>
    <caption>Descrizione dei componenti del file YAML della serie con stato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML della serie con stato</th>
    </thead>
    <tbody>
    <tr>
    <td style="text-align:left"><code>metadata.name</code></td>
    <td style="text-align:left">Immetti un nome per la tua serie con stato. Il nome che immetti viene utilizzato per creare il nome della tua PVC nel formato: <code>&lt;volume_name&gt;-&lt;statefulset_name&gt;-&lt;replica_number&gt;</code>. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.serviceName</code></td>
    <td style="text-align:left">Immetti il nome del servizio che vuoi utilizzare per esporre la tua serie con stato. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.replicas</code></td>
    <td style="text-align:left">Immetti il numero di repliche per la tua serie con stato. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.podManagementPolicy</code></td>
    <td style="text-align:left">Immetti la politica di gestione pod che vuoi utilizzare per la tua serie con stato. Scegli tra le seguenti opzioni: <ul><li><strong>OrderedReady: </strong>con questa opzione, le repliche della serie con stato vengono distribuite una dopo l'altra. Ad esempio, se hai distribuito 3 repliche, Kubernetes crea la PVC per la prima replica, attende che la PVC venga collegata, distribuisce la replica della serie con stato e monta la PVC sulla replica. Al termine della distribuzione, viene distribuita la seconda replica. Per ulteriori informazioni su questa opzione, vedi [Gestione pod OrderedReady ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#orderedready-pod-management). </li><li><strong>Parallel: </strong>con questa opzione, la distribuzione di tutte le repliche della serie con stato viene avviata contemporaneamente. Se la tua applicazione supporta la distribuzione parallela di repliche, utilizza questa opzione per risparmiare tempo di distribuzione per le tue PVC e repliche della serie con stato.</li></ul></td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.selector.matchLabels</code></td>
    <td style="text-align:left">Immetti tutte le etichette che vuoi includere nella serie con stato e nella PVC. Le etichette che includi nella sezione <code>volumeClaimTemplates</code> della tua serie con stato non vengono riconosciute da Kubernetes. Le etichette di esempio che potresti voler includere sono: <ul><li><code><strong>region</strong></code> e <code><strong>zone</strong></code>: se vuoi che tutte le tue repliche della serie con stato e PVC vengano create in una specifica zona, aggiungi entrambe le etichette. Puoi anche specificare la zona e la regione nella classe di archiviazione che utilizzi. Se non specifichi una zona e una regione e hai un cluster multizona, la zona in cui viene eseguito il provisioning della tua archiviazione è selezionata su una base round-robin per bilanciare equamente le richieste di volume tra tutte le zone.</li><li><code><strong>billingType</strong></code>: immetti il tipo di fatturazione che vuoi utilizzare per le tue PVC. Scegli tra <code>hourly</code> o <code>monthly</code>. Se non specifichi questa etichetta, tutte le PVC vengono create con un tipo di fatturazione oraria. </li></ul></td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.template.metadata.labels</code></td>
    <td style="text-align:left">Immetti le stesse etichette che hai aggiunto alla sezione <code>spec.selector.matchLabels</code>. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.metadata.</code></br><code>annotations.volume.beta.</code></br><code>kubernetes.io/storage-class</code></td>
    <td style="text-align:left">Immetti la classe di archiviazione che vuoi utilizzare. Per elencare le classi di archiviazione esistenti, esegui <code>kubectl get storageclasses | grep block</code>. Se non specifichi alcuna classe di archiviazione, la PVC viene creata con la classe di archiviazione predefinita impostata nel tuo cluster. Assicurati che la classe di archiviazione predefinita utilizzi il provisioner <code>ibm.io/ibmc-block</code> in modo che la tua serie con stato venga fornita con l'archiviazione blocchi.</td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.metadata.name</code></td>
    <td style="text-align:left">Immetti un nome per il tuo volume. Utilizza lo stesso nome che hai definito nella sezione <code>spec.containers.volumeMount.name</code>. Il nome che immetti qui viene utilizzato per creare il nome della tua PVC nel formato: <code>&lt;volume_name&gt;-&lt;statefulset_name&gt;-&lt;replica_number&gt;</code>. </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.spec.resources.</code></br><code>requests.storage</code></td>
    <td style="text-align:left">Immetti la dimensione dell'archiviazione blocchi in gigabyte (Gi).</td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.spec.resources.</code></br><code>requests.iops</code></td>
    <td style="text-align:left">Se vuoi eseguire il provisioning dell'[archiviazione Performance](#predefined_storageclass), immetti il numero di IOPS. Se utilizzi una classe di archiviazione Endurance e specifichi un numero di IOPS, il numero di IOPS viene ignorato. Invece, viene utilizzato l'IOPS specificato nella tua classe di archiviazione.  </td>
    </tr>
    </tbody></table>

4. Crea la tua serie con stato.
   ```
   kubectl apply -f statefulset.yaml
   ```
   {: pre}

5. Attendi che la serie con stato venga distribuita.
   ```
   kubectl describe statefulset <statefulset_name>
   ```
   {: pre}

   Per visualizzare lo stato corrente delle tue PVC, esegui `kubectl get pvc`. Il nome della PVC ha il formato `<volume_name>-<statefulset_name>-<replica_number>`.
   {: tip}

### Pre-provisioning della PVC prima di creare la serie con stato
{: #static_statefulset}

Puoi eseguire il pre-provisioning delle tue PVC prima di creare la serie con stato oppure utilizzare PVC esistenti con la tua serie con stato.
{: shortdesc}

Quando [esegui dinamicamente il provisioning delle tue PVC quando crei la serie con stato](#dynamic_statefulset), il nome della PVC viene assegnato in base ai valori che hai usato nel file YAML della serie con stato. Affinché la serie con stato utilizzi le PVC esistenti, il nome delle tue PVC deve corrispondere al nome che viene automaticamente creato quando si utilizza il provisioning dinamico.

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Segui i passi da 1 a 3 in [Aggiunta di archiviazione blocchi alle applicazioni](#add_block) per creare una PVC per ogni replica della serie con stato. Assicurati di creare la PVC con un nome che segue il seguente formato: `<volume_name>-<statefulset_name>-<replica_number>`.
   - **`<volume_name>`**: utilizza il nome che vuoi specificare nella sezione `spec.volumeClaimTemplates.metadata.name` della tua serie con stato, ad esempio `nginxvol`.
   - **`<statefulset_name>`**: utilizza il nome che vuoi specificare nella sezione `metadata.name` della tua serie con stato, ad esempio `nginx_statefulset`.
   - **`<replica_number>`**: immetti il numero delle tue repliche a partire da 0.

   Ad esempio, se devi creare 3 repliche della serie con stato, crea 3 PVC con i seguenti nomi: `nginxvol-nginx_statefulset-0`, `nginxvol-nginx_statefulset-1` e `nginxvol-nginx_statefulset-2`.  

2. Segui i passi indicati in [Provisioning dinamico della PVC quando crei una serie con stato](#dynamic_statefulset) per creare la tua serie con stato. Assicurati di utilizzare i valori dei tuoi nomi PVC nella specifica della serie con stato:
   - **`spec.volumeClaimTemplates.metadata.name`**: immetti il `<volume_name>` che hai usato nel passo precedente.
   - **`metadata.name`**: immetti il `<statefulset_name>` che hai usato nel passo precedente.
   - **`spec.replicas`**: immetti il numero di repliche che vuoi creare per la tua serie con stato. Il numero di repliche deve essere uguale al numero di PVC create in precedenza.

   **Nota:** se hai creato le tue PVC in zone diverse, non includere un'etichetta di regione o zona nella serie con stato.

3. Verifica che le PVC siano utilizzate nei pod di replica della serie con stato.
   1. Elenca i pod nel tuo cluster. Identifica i pod che appartengono alla tua serie con stato.
      ```
      kubectl get pods
      ```
      {: pre}

   2. Verifica che la PVC esistente sia montata nella replica della serie con stato. Esamina il **ClaimName** nella sezione **Volumes** del tuo output della CLI.
      ```
      kubectl describe pod <pod_name>
      ```
      {: pre}

      Output di esempio:
      ```
      Name:           nginx-0
      Namespace:      default
      Node:           10.xxx.xx.xxx/10.xxx.xx.xxx
      Start Time:     Fri, 05 Oct 2018 13:24:59 -0400
      ...
      Volumes:
        myvol:
          Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
          ClaimName:  myvol-nginx-0
     ...
      ```
      {: screen}

<br />



## Backup e ripristino di dati
{: #backup_restore}

Il provisioning dell'archiviazione blocchi viene eseguito nella stessa ubicazione dei nodi di lavoro nel tuo cluster. L'archiviazione viene ospitata sui server in cluster da IBM per offrire la disponibilità in caso di arresto di un server. Tuttavia, non viene eseguito il backup automatico dell'archiviazione blocchi e potrebbe essere inaccessibile se si verifica un malfunzionamento dell'intera ubicazione. Per evitare che i tuoi dati vengano persi o danneggiati, puoi configurare dei backup periodici che puoi utilizzare per ripristinare i dati quando necessario.

Esamina le seguenti opzioni di backup e ripristino per la tua archiviazione blocchi:

<dl>
  <dt>Configura istantanee periodiche</dt>
  <dd><p>Puoi [configurare delle istantanee periodiche per la tua archiviazione blocchi](/docs/infrastructure/BlockStorage/snapshots.html#snapshots), che è un'immagine di sola lettura che acquisisce lo stato dell'istanza in un punto nel tempo. Per archiviare l'istantanea, devi richiedere lo spazio per l'istantanea nella tua archiviazione blocchi. Le istantanee vengono archiviate nell'istanza di archiviazione esistente all'interno della stessa zona. Puoi ripristinare i dati da un'istantanea se un utente rimuove accidentalmente dati importanti dal volume. <strong>Nota</strong>: se hai un account dedicato, devi <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">aprire un ticket di supporto</a>.</br></br> <strong>Per creare un'istantanea per il tuo volume:</strong><ol><li>[Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).</li><li>Accedi alla CLI `ibmcloud sl`. <pre class="pre"><code>    ibmcloud sl init
    </code></pre></li><li>Elenca i PV esistenti nel tuo cluster. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>Ottieni i dettagli del PV per cui vuoi creare uno spazio per l'istantanea e prendi nota dell'ID volume, della dimensione e dell'IOPS. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> La dimensione e l'IOPS vengono visualizzati nella sezione <strong>Etichette</strong> del tuo output della CLI. Per trovare l'ID volume, controlla l'annotazione <code>ibm.io/network-storage-id</code> del tuo output della CLI. </li><li>Crea la dimensione dell'istantanea per il tuo volume esistente con i parametri che hai richiamato nel passo precedente. <pre class="pre"><code>ibmcloud sl block snapshot-order &lt;volume_ID&gt; --size &lt;size&gt; --tier &lt;iops&gt;</code></pre></li><li>Attendi che la dimensione dell'istantanea venga creata. <pre class="pre"><code>ibmcloud sl block volume-detail &lt;volume_ID&gt;</code></pre>La dimensione dell'istantanea viene fornita correttamente quando la <strong>Dimensione istantanea (GB)</strong> nel tuo output della CLI viene modificata da 0 con la dimensione che hai ordinato. </li><li>Crea l'istantanea per il tuo volume e prendi nota dell'ID dell'istantanea che ti viene creata. <pre class="pre"><code>ibmcloud sl block snapshot-create &lt;volume_ID&gt;</code></pre></li><li>Verifica che l'istantanea sia stata creata correttamente. <pre class="pre"><code>ibmcloud sl block snapshot-list &lt;volume_ID&gt;</code></pre></li></ol></br><strong>Per ripristinare i dati da un'istantanea in un volume esistente: </strong><pre class="pre"><code>ibmcloud sl block snapshot-restore &lt;volume_ID&gt; &lt;snapshot_ID&gt;</code></pre></p></dd>
  <dt>Replica le istantanee in un'altra zona</dt>
 <dd><p>Per proteggere i tuoi dati da un malfunzionamento dell'ubicazione, puoi [replicare le istantanee](/docs/infrastructure/BlockStorage/replication.html#replicating-data) in un'istanza di archiviazione blocchi configurata in un'altra zona. I dati possono essere replicati solo dall'archiviazione primaria a quella di backup. Non puoi montare un'istanza di archiviazione blocchi replicata in un cluster. Quando la tua archiviazione primaria non funziona più, puoi impostare manualmente la tua archiviazione di backup replicata in modo che sia quella primaria. Quindi, puoi montarla nel tuo cluster. Una volta ripristinata la tua archiviazione primaria, puoi ripristinare i dati dall'archiviazione di backup. <strong>Nota</strong>: se hai un account dedicato, non puoi replicare le istantanee in un'altra zona.</p></dd>
 <dt>Duplica l'archiviazione</dt>
 <dd><p>Puoi [duplicare la tua istanza di archiviazione blocchi](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume) nella stessa zona dell'istanza di archiviazione originale. Un duplicato contiene gli stessi dati dell'istanza di archiviazione originale nel momento in cui è stato creato il duplicato. A differenza delle repliche, puoi utilizzare il duplicato come un'istanza di archiviazione indipendente dall'originale. Per eseguire la duplicazione, configura innanzitutto le istantanee per il volume. <strong>Nota</strong>: se hai un account dedicato, devi <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">aprire un ticket di supporto</a>.</p></dd>
  <dt>Esegui il backup dei dati in {{site.data.keyword.cos_full}}</dt>
  <dd><p>Puoi utilizzare l'[**immagine ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) per avviare un pod di backup e ripristino nel tuo cluster. Questo pod contiene uno script per eseguire un backup una tantum o periodico per qualsiasi attestazione del volume persistente (PVC) nel tuo cluster. I dati vengono archiviati nella tua istanza {{site.data.keyword.cos_full}} che hai configurato in una zona.</p><strong>Nota:</strong> l'archiviazione blocchi viene montata con una modalità di accesso RWO. Questo accesso consente di montare un solo pod nell'archiviazione blocchi alla volta. Per eseguire il backup dei tuoi dati, devi smontare il pod dell'applicazione dall'archiviazione, montarlo nel tuo pod di backup, eseguire il backup dei dati e rimontare l'archiviazione nel tuo pod dell'applicazione. </br></br>
Per rendere i tuoi dati ancora più disponibili e proteggere la tua applicazione da un errore di zona, configura una seconda istanza {{site.data.keyword.cos_short}} e replica i dati tra le varie zone. Se devi ripristinare i dati dalla tua istanza {{site.data.keyword.cos_short}}, utilizza lo script di ripristino fornito con l'immagine.</dd>
<dt>Copia i dati nei/dai pod e contenitori</dt>
<dd><p>Puoi utilizzare il comando `kubectl cp` [![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) per copiare i file e le directory in/da pod o specifici contenitori nel tuo cluster.</p>
<p>Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). Se non specifichi un contenitore con <code>-c</code>, il comando utilizza il primo contenitore disponibile nel pod.</p>
<p>Puoi utilizzare il comando in diversi modi:</p>
<ul>
<li>Copiare i dati dalla tua macchina locale in un pod nel tuo cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copiare i dati da un pod nel tuo cluster nella tua macchina locale: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copia i dati dalla tua macchina locale a un contenitore specifico che viene eseguito in un pod nel tuo cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container&gt;</var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Riferimento delle classi di archiviazione
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Classe di archiviazione blocchi: bronze</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
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
<td>Il tipo di fatturazione predefinito dipende dalla versione del tuo plug-in {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versione 1.0.1 e successive: Ogni ora</li><li>Versione 1.0.0 e precedente: Mensile</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### Silver
{: #silver}

<table>
<caption>Classe di archiviazione blocchi: silver</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
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
<td>Il tipo di fatturazione predefinito dipende dalla versione del tuo plug-in {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versione 1.0.1 e successive: Ogni ora</li><li>Versione 1.0.0 e precedente: Mensile</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Classe di archiviazione blocchi: gold</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Archiviazione Endurance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
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
<td>Il tipo di fatturazione predefinito dipende dalla versione del tuo plug-in {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versione 1.0.1 e successive: Ogni ora</li><li>Versione 1.0.0 e precedente: Mensile</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Personalizzata
{: #custom}

<table>
<caption>Classe di archiviazione blocchi: custom</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Performance ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>File system</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS e dimensione</td>
<td><strong>Intervallo di dimensioni in gigabyte / intervallo di IOPS in multipli di 100</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disco rigido</td>
<td>Il rapporto IOPS-gigabyte determina il tipo di disco rigido di cui viene eseguito il provisioning. Per determinare il tuo rapporto IOPS/gigabyte, dividi l'IOPS per la dimensione della tua archiviazione. </br></br>Esempio: </br>Hai scelto 500Gi di archiviazione con 100 IOPS. Il tuo rapporto è 0,2 (100 IOPS/500Gi). </br></br><strong>Panoramica dei tipi di disco rigido per rapporto:</strong><ul><li>Inferiore o uguale a 0,3: SATA</li><li>Maggiore di 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Il tipo di fatturazione predefinito dipende dalla versione del tuo plug-in {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versione 1.0.1 e successive: Ogni ora</li><li>Versione 1.0.0 e precedente: Mensile</li></ul></td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Informazioni sui prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Classi di archiviazione personalizzate di esempio
{: #custom_storageclass}

Puoi creare una classe di archiviazione personalizzata e utilizzare la classe di archiviazione nella tua PVC.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} fornisce [classi di archiviazione predefinite](#storageclass_reference) per eseguire il provisioning dell'archiviazione blocchi con un livello e una configurazione specifici. In alcuni casi, potresti voler eseguire il provisioning dell'archiviazione con una configurazione diversa che non è inclusa nelle classi di archiviazione predefinite. Puoi utilizzare gli esempi in questo argomento per trovare classi di archiviazione personalizzate di esempio.

Per creare la tua classe di archiviazione personalizzata, vedi [Personalizzazione di una classe di archiviazione](cs_storage_basics.html#customized_storageclass). Quindi, [utilizza la classe di archiviazione personalizzata nella tua PVC](#add_block).

### Specifica della zona per i cluster a multizona
{: #multizone_yaml}

**Nota:** utilizza la classe di archiviazione personalizzata se usi il plug-in {{site.data.keyword.Bluemix_notm}} Block Storage versione 1.0.0 o se vuoi eseguire [in modo statico il provisioning dell'archiviazione blocchi](#existing_block) in una zona specifica. In tutti gli altri casi, [specifica la zona direttamente nella tua PVC](#add_block).  

Il seguente file `.yaml` personalizza una classe di archiviazione basata sulla classe di archiviazione di non conservazione `ibm-block-silver`: il `type` è `"Endurance"`, l'`iopsPerGB` è `4`, il `sizeRange` è `"[20-12000]Gi"` e la `reclaimPolicy` è impostata su `"Delete"`. La zona viene specificata come `dal12`. Puoi esaminare le informazioni precedenti nelle classi di archiviazione `ibmc` per un ausilio nella scelta di valori accettabili per esse, </br>

Per utilizzare una classe di archiviazione differente come tua base, vedi il [riferimento delle classi di archiviazione](#storageclass_reference).

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
  region: "us-south"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Montaggio dell'archiviazione blocchi con un file system `XFS`
{: #xfs}

Il seguente esempio crea una classe di archiviazione denominata `ibmc-block-custom-xfs` e che esegue il provisioning di archiviazione blocchi Performance con un file system `XFS`.

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

