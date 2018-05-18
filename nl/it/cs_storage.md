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


# Salvataggio dei dati nel tuo cluster
{: #storage}
Puoi conservare i dati in {{site.data.keyword.containerlong}} per condividerli tra le istanze dell'applicazioni e per impedirne la perdita nel caso in cui un componente nel tuo cluster Kubernetes abbia un malfunzionamento.

## Pianificazione della memorizzazione altamente disponibile
{: #planning}

In {{site.data.keyword.containerlong_notm}} puoi scegliere tra varie opzioni per memorizzare i tuoi dati dell'applicazione e condividerli tra i pod nel tuo cluster. Tuttavia, non tutte le opzioni di archiviazione offrono lo stesso livello di persistenza e disponibilità in situazioni in cui un componente nel cluster o un intero sito abbia un malfunzionamento.
{: shortdesc}

### Opzioni di archiviazione dati non persistente
{: #non_persistent}

Puoi utilizzare le opzioni di archiviazione non persistente se i dati non devono essere memorizza in modo persistente, in modo che tu possa ripristinarli dopo un errore di un componente nel tuo cluster o se i dati non devono essere condivisi tra le istanze dell'applicazione. Le opzioni di archiviazione
non persistente possono essere utilizzate anche per la verifica dell'unità dei tuoi componenti dell'applicazione o per provare nuove funzioni.
{: shortdesc}

La seguente immagine mostra le opzioni di archiviazione dati non persistente disponibili in {{site.data.keyword.containerlong_notm}}. Queste opzioni sono disponibili per i cluster gratuito e standard.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Opzioni di archiviazione dati non persistente" width="450" style="width: 450px; border-style: none"/></p>

<table summary="La tabella mostra le opzioni di archiviazione non persistente. Le righe devono essere lette da sinistra a destra, con il numero dell'opzione nella colonna uno, il titolo nella colonna due e una descrizione nella colonna tre." style="width: 100%">
<caption>Tabella. Opzioni di archiviazione non persistente</caption>
  <thead>
  <th>Opzione</th>
  <th>Descrizione</th>
  </thead>
  <tbody>
    <tr>
      <td>1. All'interno del contenitore o del pod</td>
      <td>I contenitori e i pod sono, come progettati, di breve durata e possono avere un malfunzionamento imprevisto. Tuttavia, puoi scrivere i dati nel file system locale del contenitore per memorizzare i dati tramite il ciclo di vita di un contenitore. I dati all'interno di un contenitore non possono essere condivisi con altri contenitori o pod e vengono persi quando il contenitore ha un arresto anomalo o viene rimosso. Per ulteriori informazioni, consulta [Memorizzazione dei dati in un contenitore](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2. Nel nodo di lavoro</td>
    <td>Ogni nodo di lavoro è configurato con un'archiviazione primaria e secondaria determinata dal tipo di macchina che selezioni per il tuo nodo di lavoro. L'archiviazione primaria viene utilizzata per memorizzare i dati dal sistema operativo e vi si può accedere utilizzando un [volume Kubernetes <code>hostPath</code> ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath). L'archiviazione secondaria viene utilizzata per memorizzare i dati in <code>/var/lib/docker</code>, la directory in cui vengono scritti tutti i dati del contenitore. Puoi accedere all'archiviazione secondaria utilizzando un [volume Kubernetes <code>emptyDir</code> ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)<br/><br/>Mentre i volumi <code>hostPath</code> vengono utilizzati per montare i file dal file system del nodo di lavoro sul tuo pod, <code>emptyDir</code> crea una directory vuota che viene assegnata a un pod nel tuo cluster. Tutti i contenitori in questo pod possono leggere e scrivere su quel volume. Poiché il volume è assegnato
a un pod specifico, i dati non possono essere condivisi con altri pod in una serie di repliche.<br/><br/><p>Un volume <code>hostPath</code> o <code>emptyDir</code> e i relativi dati vengono rimossi quando: <ul><li>Il nodo di lavoro viene eliminato.</li><li>Il nodo di lavoro viene ricaricato o aggiornato.</li><li>Il cluster viene eliminato.</li><li>L'account {{site.data.keyword.Bluemix_notm}} raggiunge uno stato sospeso. </li></ul></p><p>Inoltre, i dati in un volume <code>emptyDir</code> vengono rimossi quando: <ul><li>Il pod assegnato
viene eliminato definitivamente dal nodo di lavoro.</li><li>Il pod assegnato viene pianificato su un altro nodo di lavoro.</li></ul></p><p><strong>Nota:</strong> se il contenitore nel pod ha un arresto anomalo, i dati
nel volume sono ancora disponibili nel nodo di lavoro.</p></td>
    </tr>
    </tbody>
    </table>

### Opzioni di archiviazione dati persistente per l'elevata disponibilità
{: persistent}

La sfida principale quando crei le applicazioni con stato altamente disponibili è di conservare i dati tra più istanze dell'applicazione in più ubicazioni e mantenere i dati sempre sincronizzati. Per i dati altamente disponibili, vuoi assicurarti di avere un database master con più istanze che vengono suddivise tra più data center
o anche tra più regioni e che i dati in questo master vengano continuamente replicati. Tutte le istanze nel tuo cluster devono leggere e scrivere in questo database master. Nel caso un'istanza del master sia inattiva, le altre istanze possono sostenere il carico di lavoro, per cui non riscontri del tempo di inattività per le tue applicazioni.
{: shortdesc}

La seguente immagine mostra le opzioni che hai a disposizione in {{site.data.keyword.containerlong_notm}} per rendere i tuoi dati altamente disponibili in un cluster standard. L'opzione giusta per te dipende dai seguenti fattori:
  * **Il tuo tipo di applicazione:** ad esempio, potresti avere un'applicazione che deve memorizzare i dati su una base file rispetto che all'interno di un database.
  * **I requisiti legali su dove memorizzare e instradare i dati:** ad esempio, potresti essere obbligato a memorizzare e instradare i dati solo negli Stati Uniti e non poter utilizzare un servizio ubicato in Europa.
  * **Le opzioni di backup e ripristino:** ogni opzione di memorizzazione viene fornita con le funzionalità di backup e ripristino dei dati. Controlla che le opzioni di backup e ripristino disponibili soddisfano i tuoi requisiti del piano di ripristino di emergenza, come la frequenza dei backup o le funzionalità di archiviazione dei dati all'esterno del tuo data center primario.
  * **La replica globale:** per l'elevata disponibilità, potresti voler configurare più istanze di memorizzazione distribuite e replicate tra i data center globalmente.

<br/>
<img src="images/cs_storage_ha.png" alt="Opzioni di elevata disponibilità per l'archiviazione persistente"/>

<table summary="La tabella mostra le opzioni di archiviazione persistente. Le righe devono essere lette da sinistra a destra, con il numero dell'opzione nella colonna uno, il titolo nella colonna due e una descrizione nella colonna tre.">
<caption>Tabella. Opzioni di archiviazione persistente</caption>
  <thead>
  <th>Opzione</th>
  <th>Descrizione</th>
  </thead>
  <tbody>
  <tr>
  <td>1. Archiviazione file NFS</td>
  <td>Con questa opzione, puoi conservare i dati del contenitore e dell'applicazione utilizzando i volumi persistenti Kubernetes. I volumi sono ospitati in [Endurance and Performance NFS-based file storage ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/file-storage/details) che può essere utilizzato per le applicazioni che archiviano i dati su una base file rispetto che all'interno di un database. L'archiviazione file viene codificata quando INATTIVA. <p>{{site.data.keyword.containershort_notm}} fornisce classi di archiviazione predefinite che
definiscono l'intervallo di dimensioni dell'archivio, gli IOPS, la politica di eliminazione e le autorizzazioni di scrittura e lettura per il volume. Per avviare una richiesta per l'archiviazione file basata su NFS, devi creare un'[attestazione del volume persistente (o PVC, persistent volume claim)](cs_storage.html#create). Dopo aver inviato una PVC, {{site.data.keyword.containershort_notm}} esegue dinamicamente il provisioning di un volume persistente ospitato in un'archiviazione file basata su NFS. [Puoi montare la PVC](cs_storage.html#app_volume_mount) come volume nella tua distribuzione per consentire ai contenitori di leggere e scrivere nel volume. </p><p>I volumi persistenti vengono forniti nel data center in cui è ubicato il nodo di lavoro. Puoi condividere i dati tra la stessa serie di repliche o con altre distribuzioni nello stesso cluster. Non puoi condividere i dati tra i cluster quando sono ubicati in differenti data center o regioni. </p><p>Per impostazione predefinita, non viene eseguito automaticamente il backup dell'archivio NFS. Puoi configurare un backup periodico per il tuo cluster utilizzando i [meccanismi di backup e ripristino](cs_storage.html#backup_restore) forniti. Quando un
contenitore ha un arresto anomalo o viene rimosso un pod da un nodo di lavoro, i dati non vengono rimossi ed è ancora possibile accedervi da altre distribuzioni che montano il volume. </p><p><strong>Nota:</strong> l'archivio di condivisione file NFS
viene addebitato su base mensile. Se esegui il provisioning dell'archivio persistente del tuo cluster e lo rimuovi immediatamente,
paghi comunque l'addebito mensile per l'archiviazione persistente, anche se lo hai utilizzato solo per un breve periodo di tempo.</p></td>
  </tr>
  <tr>
    <td>2. Servizio database cloud</td>
    <td>Con questa opzione, puoi conservare i dati utilizzando un servizio cloud database {{site.data.keyword.Bluemix_notm}},
come [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant). I dati che vengono archiviati con questa opzione sono accessibili nei cluster, nelle ubicazioni e nelle regioni. <p> Puoi scegliere di configurare una sola istanza database a cui possono accedere tutte le tue applicazioni o [configurare più istanze attraverso i data center e la replica](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery) tra le istanze per l'elevata disponibilità. Nel database IBM Cloudant NoSQL, non viene eseguito automaticamente il backup dei dati. Puoi utilizzare i [meccanismi di backup e ripristino](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) forniti per proteggere i tuoi dati da un malfunzionamento del sito.</p> <p> Per utilizzare un servizio nel tuo cluster, devi [associare il servizio {{site.data.keyword.Bluemix_notm}}](cs_integrations.html#adding_app) a uno spazio dei nomi nel tuo cluster. Quando associ il servizio al cluster, viene creato un segreto Kubernetes. Il segreto Kubernetes ospita informazioni confidenziali sul servizio,
come ad esempio l'URL del servizio, i tuoi nome utente e password. Puoi montare il segreto
come un volume segreto nel tuo pod e accedere al servizio utilizzando le credenziali nel segreto. Montando il volume segreto in altri pod, puoi inoltre condividere i dati tra i pod. Quando un
contenitore ha un arresto anomalo o viene rimosso un pod da un nodo di lavoro, i dati non vengono rimossi ed è ancora possibile accedervi
da altri pod che montano il volume segreto. <p>Alcuni servizi database {{site.data.keyword.Bluemix_notm}} forniscono spazio su disco
per una piccola quantità di dati gratuitamente, in questo modo puoi verificarne le funzioni.</p></td>
  </tr>
  <tr>
    <td>3. Database in loco</td>
    <td>Se i tuoi dati devono essere archiviati in loco per motivi legali, puoi [configurare una connessione VPN](cs_vpn.html#vpn) nel tuo database in loco e utilizzare l'archiviazione esistente, i meccanismi di backup e ripristino nel tuo data center.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tabella. Opzioni di archiviazione dati persistente per le distribuzioni nei cluster Kubernetes" caption-side="top"}

<br />



## Utilizzo di condivisioni file NFS esistenti nei cluster
{: #existing}

Se hai già delle condivisioni file NFS esistenti nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) che vuoi utilizzare con Kubernetes, puoi farlo creando un volume persistente (o PV, persistent volume) per il tuo spazio di archiviazione esistente.
{:shortdesc}

Un volume persistente (PV) è una risorsa Kubernetes che rappresenta un dispositivo di archiviazione effettivo che viene fornito in un data center. I volumi persistenti astraggono i dettagli di come viene fornito uno specifico tipo di archiviazione da IBM Cloud Storage. Per montare un PV nel tuo cluster, devi richiedere l'archiviazione persistente per il tuo pod creando un'attestazione del volume persistente (o PVC, persistent volume claim). Il seguente diagramma illustra la relazione tra i PV e le PVC.

![Crea i volumi persistenti e le attestazioni del volume persistente](images/cs_cluster_pv_pvc.png)

 Come illustrato nel diagramma, per abilitare l'utilizzo delle condivisioni file NFS esistenti con Kubernetes, devi creare PV con determinate dimensioni e modalità di accesso e creare una PVC che corrisponda alla specifica del PV. Se il PV e la PVC corrispondono, vengono associati tra loro. Solo le PVC associate possono essere utilizzate dall'utente del cluster per montare il volume in una distribuzione. Questo processo viene indicato come provisioning statico di archiviazione persistente.

Prima di iniziare, assicurati di avere una condivisione file NFS esistente da utilizzare per creare il tuo PV. Ad esempio, se in precedenza [hai creato una PVC con una politica della classe di archiviazione `retain`](#create), puoi utilizzare quei messaggi conservati nella condivisione file NFS esistente per questa nuova PVC.

**Nota:** il provisioning statico di archiviazione persistente viene applicato solo alle condivisioni file NFS esistenti. Se non disponi di condivisioni file NFS esistenti, gli utenti del cluster possono utilizzare il processo di [provisioning dinamico](cs_storage.html#create) per aggiungere i PV.

Per creare un PV e una PVC corrispondente, completa la seguente procedura.

1.  Nel tuo account dell'infrastruttura IBM Cloud (SoftLayer), cerca l'ID e il percorso della condivisione file NFS in cui vuoi creare l'oggetto del PV. In aggiunta, autorizza l'archiviazione file per le sottoreti nel cluster. Questa autorizzazione fornisce al tuo cluster l'accesso all'archivio.
    1.  Accedi al tuo account dell'infrastruttura IBM Cloud (SoftLayer).
    2.  Fai clic su **Archiviazione**.
    3.  Fai clic su **Archiviazione file** e dal menu **Azioni**, seleziona **Autorizza host**.
    4.  Seleziona **Sottoreti**.
    5.  Dall'elenco a discesa, seleziona la sottorete VLAN privata a cui è connesso il nodo di lavoro. Per trovare la sottorete del tuo nodo di lavoro, esegui `bx cs workers <cluster_name>` e confronta l'`IP privato` del tuo nodo di lavoro con la sottorete che hai trovato nell'elenco a discesa.
    6.  Fai clic su **Invia**.
    6.  Fai clic sul nome dell'archiviazione file.
    7.  Prendi nota del campo **Punto di montaggio**. Il campo viene visualizzato come `<server>:/<path>`.
2.  Crea un file di configurazione dell'archiviazione per il tuo PV. Includi il server e il percorso dal campo **punto di montaggio** dell'archiviazione file.

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
    <caption>Tabella. Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Immetti il nome dell'oggetto del PV che vuoi creare.</td>
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Immetti la dimensione di archiviazione della condivisione file NFS esistente. La dimensione di archiviazione deve essere scritta in gigabyte, ad esempio, 20Gi (20 GB) o 1000Gi (1 TB) e deve corrispondere alla dimensione della condivisione file esistente.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Le modalità di accesso definiscono il modo in cui la PVC può essere montata in un nodo di lavoro.<ul><li>ReadWriteOnce (RWO): il PV può essere montato nelle distribuzioni in un solo nodo di lavoro. I contenitori nelle distribuzioni montate su questo PV possono leggere e scrivere nel volume.</li><li>ReadOnlyMany (ROX): il PV può essere montato nelle distribuzioni ospitate su più nodi di lavoro. Le distribuzioni montate in questo PV possono solo leggere dal volume.</li><li>ReadWriteMany (RWX): questo PV può essere montato nelle distribuzioni ospitate su più nodi di lavoro. Le distribuzioni montate in questo PV possono leggere e scrivere nel volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Immetti l'ID server della condivisione file NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Immetti il percorso della condivisione file NFS in cui vuoi creare l'oggetto del PV.</td>
    </tr>
    </tbody></table>

3.  Crea l'oggetto del PV nel tuo cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Esempio

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Verifica che il PV sia stato creato.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Crea un altro file di configurazione per creare la tua PVC. Affinché la PVC corrisponda all'oggetto del PV creato in precedenza, devi scegliere lo stesso valore per `storage` e `accessMode`. Il campo `storage-class` deve essere vuoto. Se uno di questi campi non corrisponde al PV, verrà creato automaticamente un nuovo PV.

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

6.  Crea la tua PVC.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Verifica che la tua PVC sia stata creata e associata all'oggetto del PV. Questo processo può richiedere qualche minuto.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Il tuo output sarà simile al seguente.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
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


Hai creato correttamente un oggetto del PV e lo hai associato a una PVC. Gli utenti del cluster possono ora [montare la PVC](#app_volume_mount) nelle proprie distribuzioni e iniziare a leggere e a scrivere sull'oggetto del PV.

<br />




## Aggiunta dell'archiviazione file NFS alle applicazioni
{: #create}

Crea un'attestazione del volume persistente (o PVC, persistent volume claim) per eseguire il provisioning dell'archiviazione file NFS per il tuo cluster. Quindi, monta questa attestazione in un volume persistente (o PV, persistent volume) per garantire che i dati siano disponibili anche se i pod si bloccano o si arrestano.
{:shortdesc}

L'archiviazione file NFS che supporta il PV viene organizzata in cluster da IBM per fornire l'alta disponibilità per i tuoi dati. Le classi di archiviazione descrivono i tipi di offerte di archiviazione disponibili e definiscono aspetti come la politica di conservazione dei dati, le dimensioni in gigabyte e IOPS quando crei il tuo PV.



**Prima di iniziare**: se hai un firewall, [consenti l'accesso in uscita](cs_firewall.html#pvc) per gli intervalli IP dell'infrastruttura IBM Cloud (SoftLayer) delle ubicazioni (data center) in cui si trovano i tuoi cluster, in modo da poter creare le PVC.

Per aggiungere l'archiviazione persistente:

1.  Rivedi le classi di archiviazione disponibili. {{site.data.keyword.containerlong}} fornisce classi di archiviazione predefinite per l'archiviazione file NFS in modo che l'amministratore del cluster non debba creare alcuna classe di archiviazione. La classe di archiviazione `ibmc-file-bronze` è uguale a `default`.

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

    **Suggerimento:** se vuoi modificare la classe di archiviazione predefinita, esegui `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e sostituisci `<storageclass>` con il nome della classe di archiviazione.

2.  Decidi se vuoi conservare i tuoi dati e la condivisione file NFS dopo aver eliminato la PVC.
    - Se vuoi conservare i tuoi dati, scegli una classe di archiviazione `retain`. Quando elimini la PVC, il PV viene rimosso, ma il file NFS e i tuoi dati sono ancora presenti nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). Successivamente, per accedere a questi dati nel tuo cluster, crea una PVC e un PV corrispondente che faccia riferimento al tuo [file NFS](#existing) esistente.
    - Se vuoi che i dati e la condivisione file NFS vengano eliminati quando elimini la PVC, scegli una classe di archiviazione senza `retain`.

3.  **Se scegli una classe di archiviazione bronze, silver o gold**: ottieni l'[archiviazione Endurance ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/endurance-storage) che definisce gli IOPS per GB per ogni classe. Tuttavia, puoi determinare il totale di IOPS scegliendo la dimensione nell'intervallo disponibile. Puoi selezionare qualsiasi numero intero di dimensioni di gigabyte entro l'intervallo di dimensioni consentito (come 20 Gi, 256 Gi, 11854 Gi). Ad esempio, se selezioni una dimensione di condivisione file di 1000Gi nella classe di archiviazione silver di 4 IOPS per GB, il tuo volume ha un totale di 4000 IOPS. Più IOPS ha il tuo PV, più velocemente elabora le operazioni di input e output. La seguente tabella descrive gli IOPS per gigabyte e l'intervallo di dimensioni per ogni classe di archiviazione.

    <table>
         <caption>Tabella di intervalli di dimensioni della classe di archiviazione e IOPS per gigabyte</caption>
         <thead>
         <th>Classe di archiviazione</th>
         <th>IOPS per gigabyte</th>
         <th>Intervallo di dimensioni in gigabyte</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze (predefinito)</td>
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

    <p>**Comando di esempio per mostrare i dettagli di una classe di archiviazione**:</p>

    <pre class="pre">kubectl describe storageclasses ibmc-file-silver</pre>

4.  **Se scegli la classe di archiviazione personalizzata**: ottieni l'[archiviazione Performance ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/performance-storage) e hai maggiore controllo sulla scelta della combinazione di IOPS e dimensioni. Ad esempio, se selezioni una dimensione di 40Gi per la PVC, puoi scegliere un IOPS multiplo di 100 compreso nell'intervallo 100-2000 IOPS. La seguente tabella mostra quale intervallo di IOPS puoi scegliere in base alla dimensione selezionata.

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

    <p>**Comando di esempio per mostrare i dettagli di una classe di archiviazione personalizzata**:</p>

    <pre class="pre">kubectl describe storageclasses ibmc-file-retain-custom</pre>

5.  Decidi se ricevere una fattura su base oraria o mensile. Per impostazione predefinita, la fatturazione è mensile.

6.  Crea un file di configurazione per definire la tua PVC e salva la configurazione come file `.yaml`.

    -  **Esempio per le classi di archiviazione bronze, silver, gold**:
       Il seguente file `.yaml` crea un'attestazione denominata `mypvc` della classe di archiviazione `"ibmc-file-silver"`, con fatturazione oraria (`"hourly"`) e una dimensione in gigabyte di `24Gi`. 

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

    -  **Esempio per le classi di archiviazione personalizzate**:
       Il seguente file `.yaml` crea un'attestazione denominata `mypvc` della classe di archiviazione `ibmc-file-retain-custom`, con fatturazione mensile (`"monthly"`) per impostazione predefinita, una dimensione in gigabyte di `45Gi` e IOPS di `"300"`.

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
	      <caption>Tabella. Descrizione dei componenti del file YAML</caption>
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
        <td>Specifica la classe di archiviazione per il PV:
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS per GB.</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS per GB.</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS per GB.</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom: più valori di IOPS disponibili.</li></ul>
          <p>Se non specifichi alcuna classe di archiviazione, il PV viene creato con la classe di archiviazione predefinita.</p><p>**Suggerimento:** se vuoi modificare la classe di archiviazione predefinita, esegui <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> e sostituisci <code>&lt;storageclass&gt;</code> con il nome della classe di archiviazione.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Specifica la frequenza per la quale viene calcolata la fattura di archiviazione, "mensile" o "oraria". Il valore predefinito è "mensile".</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Immetti la dimensione dell'archiviazione file, in gigabyte (Gi). Scegli un numero intero entro l'intervallo di dimensioni consentite. </br></br><strong>Nota: </strong> una volta completato il provisioning della tua archiviazione, non puoi modificare la dimensione della condivisione file NFS. Assicurati di specificare una dimensione che corrisponda alla quantità di dati che desideri memorizzare. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Questa opzione è valida solo per le classi di archiviazione personalizzate (`ibmc-file-custom / ibmc-file-retain-custom`). Specifica l'IOPS totale per l'archiviazione, selezionando un multiplo di 100 nell'intervallo consentito. Per visualizzare tutte le opzioni, esegui `kubectl describe storageclasses <storageclass>`. Se scegli un IOPS diverso da quello elencato, viene arrotondato per eccesso.</td>
        </tr>
        </tbody></table>

7.  Crea la PVC.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Verifica che la tua PVC sia stata creata e associata al PV. Questo processo può richiedere qualche minuto.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Output di esempio:

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
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

9.  {: #app_volume_mount}Per montare la PVC nella tua distribuzione, crea un file di configurazione `.yaml`.

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
    <caption>Tabella. Descrizione dei componenti del file YAML</caption>
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
    <td>Il nome dell'immagine che vuoi utilizzare. Per elencare le immagini disponibili nel tuo account {{site.data.keyword.registryshort_notm}}, esegui `bx cr image-list`.</td>
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
    <td>Il nome della PVC che vuoi utilizzare come volume. Quando monti il volume nel pod, Kubernetes identifica il PV associato alla PVC e consente all'utente di leggere e scrivere nel PV.</td>
    </tr>
    </tbody></table>

10.  Crea la distribuzione e monta la PVC.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

11.  Verifica che il volume sia stato correttamente montato.

     ```
     kubectl describe deployment <deployment_name>
     ```
     {: pre}

     Il punto di montaggio è nel campo **Volume Mounts** e il volume nel campo **Volumes**.

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




## Configurazione delle soluzioni di backup e ripristino per le condivisioni file NFS
{: #backup_restore}

Le condivisioni file sono fornite nella stessa ubicazione (data center) del tuo cluster e vengono organizzate in cluster da {{site.data.keyword.IBM_notm}} per fornire l'alta disponibilità. Tuttavia, non viene eseguito il backup automatico delle condivisioni file e queste potrebbero essere inaccessibili se si verifica un errore nell'intera ubicazione. Per evitare che i tuoi dati vengano persi o danneggiati, puoi configurare dei backup periodici delle condivisioni file NFS che puoi utilizzare per ripristinare i dati quando necessario.
{: shortdesc}

Esamina le seguenti opzioni di backup e ripristino per le tue condivisioni file NFS:

<dl>
  <dt>Configura istantanee periodiche delle tue condivisioni file NFS</dt>
  <dd>Puoi configurare [istantanee periodiche](/docs/infrastructure/FileStorage/snapshots.html#working-with-snapshots) per la tua condivisione file NFS, ossia un'immagine di sola lettura di una condivisione file NFS che acquisisce lo stato del volume in un punto nel tempo. Le istantanee vengono memorizzate sulla stessa condivisione file all'interno della stessa ubicazione. Puoi ripristinare i dati da un'istantanea se un utente rimuove accidentalmente dati importanti dal volume.</dd>
  <dt>Replica le istantanee in una condivisione file NFS in un'altra ubicazione (data center)</dt>
 <dd>Per proteggere i tuoi dati da un errore di ubicazione, puoi [replicare le istantanee](/docs/infrastructure/FileStorage/replication.html#working-with-replication) in una condivisione file NFS configurata in un'altra ubicazione. I dati possono essere replicati solo dalla condivisione file NFS principale alla condivisione file NFS di backup. Non puoi montare una condivisione file NFS replicata in un cluster. Quando la tua condivisione file NFS principale non funziona più, puoi impostare manualmente la condivisione file NFS di backup come principale. Quindi, puoi montarla nel tuo cluster. Dopo aver ripristinato la condivisione file NFS principale, puoi ripristinare i dati dalla condivisione file NFS di backup.</dd>
  <dt>Esegui il backup dei dati in Object Storage</dt>
  <dd>Puoi utilizzare l'[**immagine ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) per avviare un pod di backup e ripristino nel tuo cluster. Questo pod contiene uno script per eseguire un backup una tantum o periodico per qualsiasi attestazione del volume persistente (PVC) nel tuo cluster. I dati vengono memorizzati nella tua istanza {{site.data.keyword.objectstoragefull}} che hai configurato in un'ubicazione. Per rendere i tuoi dati ancora più disponibili e proteggere la tua applicazione da un errore di ubicazione, configura una seconda istanza {{site.data.keyword.objectstoragefull}} e replica i dati tra le varie ubicazioni. Se devi ripristinare i dati dalla tua istanza {{site.data.keyword.objectstoragefull}}, utilizza lo script di ripristino fornito con l'immagine.</dd>
  </dl>

## Aggiunta di accesso utente non root all'archiviazione file NFS
{: #nonroot}

Per impostazione predefinita, gli utenti non root non dispongono dell'autorizzazione di scrittura sul percorso di montaggio del volume per l'archiviazione con supporto NFS. Alcune immagini comuni, come Jenkins e Nexus3, specificano un utente non root che possiede il percorso di montaggio nel Dockerfile. Quando crei un contenitore da questo Dockerfile, la creazione del contenitore non riesce a causa di autorizzazioni insufficienti dell'utente non root sul percorso di montaggio. Per concedere l'autorizzazione di scrittura, puoi modificare il Dockerfile per aggiungere temporaneamente l'utente non root al gruppo di utenti root prima di modificare le autorizzazioni del percorso di montaggio o utilizzare un contenitore init.
{:shortdesc}

Se utilizzi un grafico Helm per distribuire un'immagine con un utente non root a cui concedere l'autorizzazione di scrittura sulla condivisione file NFS, modifica prima la distribuzione Helm per utilizzare un contenitore init.
{:tip}



Quando includi un [contenitore init ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) nella tua distribuzione, a un utente non root specificato nel Dockerfile puoi fornire le autorizzazioni di scrittura sul percorso di montaggio del volume all'interno del contenitore che punta alla tua condivisione file NFS. Il contenitore init viene avviato prima del contenitore dell'applicazione. Il contenitore init crea il percorso di montaggio del volume all'interno del contenitore, modifica il percorso di montaggio in modo che sia di proprietà dell'utente corretto (non root) e si chiude. Quindi, viene avviato il contenitore dell'applicazione, che include l'utente non root che deve scrivere sul percorso di montaggio. Poiché il percorso è già di proprietà dell'utente non root, la scrittura sul percorso di montaggio ha esito positivo. Se non vuoi utilizzare un contenitore init, puoi modificare il Dockerfile per aggiungere l'accesso utente non root all'archiviazione file NFS.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

1.  Apri il Dockerfile per la tua applicazione e ottieni l'ID utente (UID) e l'ID di gruppo (GID) dell'utente a cui desideri concedere l'autorizzazione di scrittore sul percorso di montaggio del volume. Nell'esempio di un Dockerfile Jenkins, le informazioni sono:
    - UID: `1000`
    - GID: `1000`

    **Esempio**:

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

2.  Aggiungi l'archiviazione persistente alla tua applicazione creando un'attestazione del volume persistente (o PVC, persistent volume claim). Questo esempio utilizza la classe di archiviazione `ibmc-file-bronze`. Per esaminare le classi di archiviazione disponibili, esegui `kubectl get storageclasses`.

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

3.  Crea la PVC.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

4.  Nel tuo file di distribuzione `.yaml`, aggiungi il contenitore init. Includi l'UID e il GID che hai richiamato in precedenza.

    ```
    initContainers:
    - name: initContainer # Or you can replace with any name
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Replace UID and GID with values from the Dockerfile
      volumeMounts:
      - name: volume # Or you can replace with any name
        mountPath: /mount # Must match the mount path in the args line
    ```
    {: codeblock}

    **Esempio** per una distribuzione Jenkins:

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

5.  Crea il pod e monta la PVC nel tuo pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

6. Verifica che il volume sia stato correttamente montato nel tuo pod. Prendi nota del nome del pod e del percorso **Containers/Mounts**.

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **Output di esempio**:

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
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

7.  Accedi al pod utilizzando il nome pod che hai annotato precedentemente.

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. Verifica le autorizzazioni del percorso di montaggio del tuo contenitore. Nell'esempio, il percorso di montaggio è `/var/jenkins_home`.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **Output di esempio**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    Questo output mostra che il GID e l'UID dal tuo Dockerfile (in questo esempio, `1000` e `1000`) possiedono il percorso di montaggio all'interno del contenitore.


