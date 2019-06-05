---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-05"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Risoluzione dei problemi dell'archiviazione cluster
{: #cs_troubleshoot_storage}

Mentre utilizzi {{site.data.keyword.containerlong}}, tieni presente queste tecniche per la risoluzione dei problemi dell'archiviazione del cluster.
{: shortdesc}

Se hai un problema più generale, prova a [eseguire il debug del cluster](/docs/containers?topic=containers-cs_troubleshoot).
{: tip}

## In un cluster multizona, il montaggio di un volume persistente in un pod non riesce
{: #mz_pv_mount}

{: tsSymptoms}
Il tuo cluster era, in precedenza, un cluster a zona singola con dei nodi di lavoro autonomi che non si trovavano in pool di nodi di lavoro. Hai montato correttamente un'attestazione del volume persistente (o PVC, persistent volume claim) che descriveva il volume persistente (o PV, persistent volume) da utilizzare per la distribuzione del pod della tua applicazione. Tuttavia, ora che hai dei pool di nodi di lavoro e delle zone aggiunte al tuo cluster, il montaggio del PV al pod non riesce.

{: tsCauses}
Per i cluster multizona, i PV devono avere le seguenti etichette in modo che i pod non provino a montare i volumi in una zona differente.
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

I nuovi cluster con dei pool di nodi di lavoro che possono estendersi a più zone etichettano i PV per impostazione predefinita. Se hai creato i tuoi cluster prima che fossero introdotti i pool di nodi di lavoro, devi aggiungere le etichette manualmente.

{: tsResolve}
[Aggiorna i PV nel tuo cluster con le etichette di regione e zona](/docs/containers?topic=containers-kube_concepts#storage_multizone).

<br />


## Archiviazione file: i file system per i nodi di lavoro diventano di sola lettura
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Potresti vedere uno dei seguenti sintomi:
- Quando esegui `kubectl get pods -o wide`, visualizzi che molti pod in esecuzione nello stesso nodo di lavoro sono bloccati nello stato `ContainerCreating`.
- Quando esegui un comando `kubectl describe`, vedi il seguente errore nella sezione **Eventi**: `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
Il file system nel nodo di lavoro è in sola lettura.

{: tsResolve}
1.  Esegui il backup di tutti i dati che possono venire archiviati nel nodo di lavoro o nei tuoi contenitori.
2.  Per una correzione a breve termine per il nodo di lavoro esistente, ricarica il nodo di lavoro.
    <pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;cluster_name&gt; --worker &lt;worker_ID&gt;</code></pre>

Per una correzione a lungo termine, [aggiorna il tipo di macchina del tuo pool di nodi di lavoro](/docs/containers?topic=containers-update#machine_type).

<br />



## Archiviazione file: l'applicazione genera un errore quando un utente non root possiede il percorso di montaggio dell'archiviazione file NFS
{: #nonroot}

{: tsSymptoms}
Dopo aver [aggiunto l'archiviazione NFS](/docs/containers?topic=containers-file_storage#file_app_volume_mount) alla tua distribuzione, la distribuzione del tuo contenitore ha esito negativo. Quando richiami i log per il tuo contenitore, potresti vedere degli errori simili ai seguenti: Il pod genera un errore e si blocca in un ciclo di ricaricamento.

```
write-permission
```
{: screen}

```
do not have required permission
```
{: screen}

```
cannot create directory '/bitnami/mariadb/data': Permission denied
```
{: screen}

{: tsCauses}
Per impostazione predefinita, gli utenti non root non dispongono dell'autorizzazione di scrittura sul percorso di montaggio del volume per l'archiviazione con supporto NFS. Alcune immagini comuni dell'applicazione, come Jenkins e Nexus3, specificano un utente non root che possiede il percorso di montaggio nel Dockerfile. Quando crei un contenitore da questo Dockerfile, la creazione del contenitore non riesce a causa di autorizzazioni insufficienti dell'utente non root sul percorso di montaggio. Per concedere l'autorizzazione di scrittura, puoi modificare il Dockerfile per aggiungere temporaneamente l'utente non root al gruppo di utenti root prima di modificare le autorizzazioni del percorso di montaggio o utilizzare un contenitore init.

Se utilizzi un grafico Helm per distribuire l'immagine, modifica la distribuzione Helm in modo che utilizzi un contenitore init.
{:tip}



{: tsResolve}
Quando includi un [contenitore init![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) nella tua distribuzione, puoi fornire a un utente non root specificato nel Dockerfile le autorizzazioni di scrittura sul percorso di montaggio del volume all'interno del contenitore. Il contenitore init viene avviato prima del contenitore dell'applicazione. Il contenitore init crea il percorso di montaggio del volume all'interno del contenitore, modifica il percorso di montaggio in modo che sia di proprietà dell'utente corretto (non root) e si chiude. Quindi, viene avviato il contenitore dell'applicazione con l'utente non root che deve scrivere sul percorso di montaggio. Poiché il percorso è già di proprietà dell'utente non root, la scrittura sul percorso di montaggio ha esito positivo. Se non vuoi utilizzare un contenitore init, puoi modificare il Dockerfile per aggiungere l'accesso utente non root all'archiviazione file NFS.


Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Apri il Dockerfile per la tua applicazione e ottieni l'ID utente (UID) e l'ID di gruppo (GID) dell'utente a cui desideri concedere l'autorizzazione di scrittore sul percorso di montaggio del volume. Nell'esempio di un Dockerfile Jenkins, le informazioni sono:
    - UID: `1000`
    - GID: `1000`

    **Esempio**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update &&apt-get install -y git curl &&rm -rf /var/lib/apt/lists/*

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
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  Nel tuo file di distribuzione `.yaml`, aggiungi il contenitore init. Includi l'UID e il GID che hai richiamato in precedenza.

    ```
    initContainers:
    - name: initcontainer # Or replace the name
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
      selector:
        matchLabels:
          app: jenkins      
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
    kubectl apply -f my_pod.yaml
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

7.  Accedi al pod utilizzando il nome pod di cui hai preso nota precedentemente.

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

<br />


## Archiviazione file: l'aggiunta di accesso utente non root all'archiviazione persistente non riesce
{: #cs_storage_nonroot}

{: tsSymptoms}
Dopo aver [aggiunto l'accesso utente non root all'archiviazione persistente](#nonroot) o aver distribuito un grafico Helm con un ID utente non root specificato, l'utente non può scrivere nell'archiviazione montata.

{: tsCauses}
La distribuzione o la configurazione del grafico Helm specifica il [contesto di sicurezza](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) per `fsGroup` (ID gruppo) e `runAsUser` (ID utente) del pod. Attualmente, {{site.data.keyword.containerlong_notm}} non supporta la specifica `fsGroup` e supporta solo `runAsUser` impostato come `0` (autorizzazioni root).

{: tsResolve}
Rimuovi i campi `securityContext` della configurazione per `fsGroup` e `runAsUser` dal file di configurazione dell'immagine, della distribuzione o del grafico Helm e riesegui la distribuzione. Se devi modificare la proprietà del percorso di montaggio da `nobody`, [aggiungi l'accesso utente non root](#nonroot). Dopo che hai aggiunto l'[non-root `initContainer`](#nonroot), imposta `runAsUser` a livello di contenitore, non a livello di pod.

<br />




## Archiviazione blocchi: l'archiviazione blocchi è modificata a sola lettura
{: #readonly_block}

{: tsSymptoms}
Potresti vedere i seguenti sintomi:
- Quando esegui `kubectl get pods -o wide`, vedi che più pod sullo stesso nodo di lavoro sono bloccati nello stato `ContainerCreating` o `CrashLoopBackOff`. Tutti questi pod utilizzano la stessa istanza di archiviazione blocchi.
- Quando esegui un comando `kubectl describe pod`, vedi il seguente errore nella sezione **Eventi**: `MountVolume.SetUp failed for volume ...
read-only`.

{: tsCauses}
Se si verifica un errore di rete mentre un pod scrive su un volume, l'infrastruttura IBM Cloud (SoftLayer) protegge i dati sul volume per evitarne il danneggiamento modificando il volume a una modalità di sola lettura. I pod che utilizzano questo volume non possono continuare a scrivere sul volume e riscontrano una condizione di errore.

{: tsResolve}
1. Controlla la versione del plugin {{site.data.keyword.Bluemix_notm}} Block Storage installato nel tuo cluster.
   ```
   helm ls
   ```
   {: pre}

2. Verifica che quella che utilizzi è la [versione più recente del plugin {{site.data.keyword.Bluemix_notm}} Block Storage](https://cloud.ibm.com/kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin). In caso contrario, [aggiorna il tuo plugin](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in).
3. Se hai utilizzato una distribuzione Kubernetes per il tuo pod, riavvia il pod che sta riscontrando la condizione di errore rimuovendolo e lasciando che Kubernetes lo crei nuovamente. Se non hai utilizzato una distribuzione, richiama il file YAML che era stato utilizzato per creare il tuo pod eseguendo `kubectl get pod <pod_name> -o yaml >pod.yaml`. Quindi elimina e crea di nuovo manualmente il pod.
    ```
    kubectl delete pod <pod_name>
    ```
    {: pre}

4. Controlla se creare nuovamente il tuo pod ha risolto il problema. Se non lo ha fatto, ricarica il nodo di lavoro.
   1. Trova il nodo di lavoro dove viene eseguito il tuo pod e annota l'indirizzo IP privato assegnato al tuo nodo di lavoro.
      ```
      kubectl describe pod <pod_name> | grep Node
      ```
      {: pre}

      Output di esempio:
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. Richiama l'**ID** del tuo nodo di lavoro utilizzando l'indirizzo IP privato dal passo precedente.
      ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}

   3. Senza forzare l'operazione, [ricarica il nodo di lavoro](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload).


<br />


## Archiviazione blocchi: impossibile montare l'archiviazione blocchi esistente in un pod a causa del file system errato
{: #block_filesystem}

{: tsSymptoms}
Quando esegui `kubectl describe pod <pod_name>`, vedi il seguente errore:
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
Hai un dispositivo di archiviazione blocchi esistente configurato con un file system `XFS`. Per montare questo dispositivo nel tuo pod, [hai creato un PV](/docs/containers?topic=containers-block_storage#existing_block) che ha specificato `ext4` come tuo file system o nessun file system nella sezione `spec/flexVolume/fsType`. Se non viene definito un file system, viene utilizzato il valore predefinito del PV `ext4`.
Il PV era stato creato correttamente e collegato alla tua istanza dell'archiviazione blocchi esistente. Tuttavia, quando tenti di montare il PV nel tuo cluster utilizzando una PVC corrispondente, il montaggio del volume non riesce. Non puoi montare la tua istanza dell'archiviazione blocchi `XFS` con un file system `ext4` nel pod.

{: tsResolve}
Aggiorna il file system nel PV esistente da `ext4` a `XFS`.

1. Elenca i PV esistenti nel tuo cluster e prendi nota del nome del PV che hai utilizzato per la tua istanza dell'archiviazione blocchi esistente.
   ```
   kubectl get pv
   ```
   {: pre}

2. Salva lo YAML del PV sulla tua macchina locale.
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. Apri il file YAML e modifica l'`fsType` da `ext4` a `xfs`.
4. Sostituisci il PV nel tuo cluster.
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. Accedi al pod in cui hai montato il PV.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. Verifica che il file system sia stato modificato con `XFS`.
   ```
   df -Th
   ```
   {: pre}

   Output di esempio:
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## Archiviazione oggetti: l'installazione del plugin Helm {{site.data.keyword.cos_full_notm}} `ibmc` non riesce
{: #cos_helm_fails}

{: tsSymptoms}
Quando installi il plugin Helm {{site.data.keyword.cos_full_notm}} `ibmc`, l'installazione non riesce con il seguente errore:
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
Quando il plugin Helm `ibmc` è installato, viene creato un collegamento simbolico dalla directory `./helm/plugins/helm-ibmc` alla directory dove si trova il plugin Helm `ibmc` sul tuo sistema locale, che è di norma in `./ibmcloud-object-storage-plugin/helm-ibmc`. Quando rimuovi il plugin Helm `ibmc` dal tuo sistema locale, o sposti la directory del plugin Helm `ibmc` in un'altra ubicazione, il collegamento simbolico non viene rimosso.

{: tsResolve}
1. Rimuovi il plugin Helm {{site.data.keyword.cos_full_notm}}.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. [Installa {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-object_storage#install_cos).

<br />


## Archiviazione oggetti: la creazione del pod o della PVC non riesce perché non è possibile trovare il segreto Kubernetes
{: #cos_secret_access_fails}

{: tsSymptoms}
Quando crei la tua PVC o distribuisci un pod che monta la PVC, la creazione o la distribuzione non riescono.

- Messaggio di errore di esempio per un errore di creazione di PVC:
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- Messaggio di errore di esempio per un errore di creazione di pod:
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}

{: tsCauses}
Il segreto Kubernetes dove archivi le tue credenziali del servizio {{site.data.keyword.cos_full_notm}}, la PVC e il pod non si trovano tutti nello stesso spazio dei nomi Kubernetes, Quando il segreto viene distribuito a uno spazio dei nomi differente rispetto alla tua PVC o al tuo pod, non è possibile accedere al segreto.

{: tsResolve}
Questa attività richiede [**Scrittore** o **Gestore** come ruolo del servizio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) per tutti gli spazi dei nomi.

1. Elenca tutti i segreti nel tuo cluster e riesamina lo spazio dei nomi Kubernetes dove viene creato il segreto Kubernetes per la tua istanza del servizio {{site.data.keyword.cos_full_notm}}. Il segreto deve mostrare `ibm/ibmc-s3fs` come tipo (**Type**).
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. Controlla il tuo file di configurazione YAML per la tua PVC o il tuo pod per verificare che hai utilizzato lo stesso spazio dei nomi. Se vuoi distribuire un pod in uno spazio dei nomi diverso da quello in cui si trova il tuo segreto, [crea un altro segreto](/docs/containers?topic=containers-object_storage#create_cos_secret) in tale spazio dei nomi.

3. Crea la PVC o distribuisci il pod nello spazio dei nomi appropriato.

<br />


## Archiviazione oggetti: la creazione della PVC non riesce a causa di credenziali errate o di accesso rifiutato
{: #cred_failure}

{: tsSymptoms}
Quando crei la PVC, vedi un messaggio di errore simile al seguente:

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403
```
{: screen}

```
CredentialsEndpointError: failed to load credentials
```
{: screen}

{: tsCauses}
Le credenziali del servizio {{site.data.keyword.cos_full_notm}} che utilizzi per accedere all'istanza del servizio potrebbero essere errate oppure consentire solo l'accesso in lettura al tuo bucket.

{: tsResolve}
1. Nella navigazione nella pagina dei dettagli del servizio, fai clic su **Credenziali del servizio**.
2. Trova le tue credenziali, quindi fai clic su **Visualizza credenziali**.
3. Verifica di utilizzare **access_key_id** e **secret_access_key** corretti nel tuo segreto Kubernetes. In caso contrario, aggiorna il tuo segreto Kubernetes.
   1. Ottieni lo YAML che hai utilizzato per creare il segreto.
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}

   2. Aggiorna **access_key_id** e **secret_access_key**.
   3. Aggiorna il segreto.
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

4. Nella sezione **iam_role_crn**, verifica di avere il ruolo di scrittore (`Writer`) o di gestore (`Manager`). Se non hai il ruolo corretto, devi [creare delle nuove credenziali del servizio {{site.data.keyword.cos_full_notm}} con l'autorizzazione corretta](/docs/containers?topic=containers-object_storage#create_cos_service). Aggiorna quindi il tuo segreto esistente oppure [crea un nuovo segreto](/docs/containers?topic=containers-object_storage#create_cos_secret) con le tue nuove credenziali del servizio.

<br />


## Archiviazione oggetti: impossibile accedere a un bucket esistente

{: tsSymptoms}
Quando crei la PVC, non è possibile accedere al bucket in {{site.data.keyword.cos_full_notm}}. Vedi un messaggio di errore simile al seguente:

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
Potresti aver utilizzato la classe di archiviazione errata per accedere al tuo bucket esistente oppure hai tentato di accedere a un bucket che non hai creato.

{: tsResolve}
1. Dal [dashboard {{site.data.keyword.Bluemix_notm}}![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/), seleziona la tua istanza del servizio {{site.data.keyword.cos_full_notm}}.
2. Seleziona **Bucket**.
3. Riesamina le informazioni su **Classe** e **Ubicazione** per il tuo bucket esistente.
4. Scegli la [classe di archiviazione](/docs/containers?topic=containers-object_storage#cos_storageclass_reference) appropriata.

<br />


## Archiviazione oggetti: l'accesso ai file con un utente non root non riesce
{: #cos_nonroot_access}

{: tsSymptoms}
Hai caricato dei file nella tua istanza del servizio {{site.data.keyword.cos_full_notm}} utilizzando la console o l'API REST. Quando provi ad accedere a questi file con un utente non root che hai definito con `runAsUser` nella tua distribuzione dell'applicazione, l'accesso ai file viene rifiutato.

{: tsCauses}
In Linux, un file o una directory hanno 3 gruppi di accesso: `Owner`, `Group` e `Other`. Quando carichi un file in {{site.data.keyword.cos_full_notm}} utilizzando la console o l'API REST, le autorizzazioni per `Owner`, `Group` e `Other` vengono rimosse. L'autorizzazione di ciascun file si presenta così:

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

Quando carichi un file utilizzando il plugin {{site.data.keyword.cos_full_notm}}, le autorizzazioni per il file vengono conservate e non modificate.

{: tsResolve}
Per accedere al file con un utente non root, quest'ultimo deve disporre delle autorizzazioni in lettura e scrittura per il file. La modifica dell'autorizzazione di un file come parte della tua distribuzione del pod richiede un'operazione di scrittura. {{site.data.keyword.cos_full_notm}} non è progettato per i carichi di lavoro di scrittura. L'aggiornamento delle autorizzazioni durante la distribuzione del pod potrebbe impedire al tuo pod di passare a uno stato di `Running`.

Per risolvere questo problema, prima di montare la PVC nel tuo pod dell'applicazione, crea un altro pod per impostare l'autorizzazione corretta per l'utente non root.

1. Controlla le autorizzazioni dei tuoi file nel tuo bucket.
   1. Crea un file di configurazione per il tuo pod `test-permission` e denomina il file `test-permission.yaml`.
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc_name>
      ```
      {: codeblock}

   2. Crea il pod `test-permission`.
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}

   3. Accedi al tuo pod.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. Passa al percorso di montaggio ed elenca le autorizzazioni per i tuoi file.
      ```
      cd test && ls -al
      ```
      {: pre}

      Output di esempio:
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}

2. Elimina il pod.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. Crea un file di configurazione per il pod che utilizzi per correggere le autorizzazioni dei tuoi file e denominalo `fix-permission.yaml`.
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission
     namespace: <namespace>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nonroot_userID> <mount_path>/*; find <mount_path>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mount_path>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

3. Crea il pod `fix-permission`.
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. Attendi che il pod passi a uno stato di `Completed`.  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. Elimina il pod `fix-permission`.
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. Ricrea il pod `test-permission` che hai utilizzato in precedenza per controllare le autorizzazioni.
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. Verifica che le autorizzazioni per i tuoi file siano aggiornate.
   1. Accedi al tuo pod.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. Passa al percorso di montaggio ed elenca le autorizzazioni per i tuoi file.
      ```
      cd test && ls -al
      ```
      {: pre}

      Output di esempio:
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}

6. Elimina il pod `test-permission`.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. Monta la PVC nell'applicazione con l'utente non root.

   Definisci l'utente non root come `runAsUser` senza impostare al tempo stesso `fsGroup` nel tuo YAML di distribuzione. L'impostazione di `fsGroup` attiva il plugin {{site.data.keyword.cos_full_notm}} per aggiornare le autorizzazioni del gruppo per tutti i file in un bucket quando viene distribuito il pod. L'aggiornamento delle autorizzazioni è un'operazione di scrittura e potrebbe impedire al tuo pod di passare a uno stato di `Running`.
   {: important}

Dopo aver impostato le autorizzazioni file corrette nella tua istanza del servizio {{site.data.keyword.cos_full_notm}}, non caricare i file utilizzando la console o l'API REST. Utilizza il plugin {{site.data.keyword.cos_full_notm}} per aggiungere file alla tua istanza del servizio.
{: tip}

<br />




## Come ottenere aiuto e supporto
{: #storage_getting_help}

Stai ancora avendo problemi con il tuo cluster?
{: shortdesc}

-  Nel terminale, ricevi una notifica quando sono disponibili degli aggiornamenti ai plugin e alla CLI `ibmcloud`. Assicurati di mantenere la tua CLI aggiornata in modo che tu possa utilizzare tutti i comandi e gli indicatori disponibili.
-   Per vedere se {{site.data.keyword.Bluemix_notm}} è disponibile, [controlla la pagina sugli stati {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/status?selected=status).
-   Pubblica una domanda in [{{site.data.keyword.containerlong_notm}} Slack ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibm-container-service.slack.com).
    Se non stai utilizzando un ID IBM per il tuo account {{site.data.keyword.Bluemix_notm}}, [richiedi un invito](https://bxcs-slack-invite.mybluemix.net/) a questo Slack.
    {: tip}
-   Rivedi i forum per controllare se altri utenti hanno riscontrato gli stessi problemi. Quando utilizzi i forum per fare una domanda, contrassegna con una tag la tua domanda in modo che sia visualizzabile dai team di sviluppo {{site.data.keyword.Bluemix_notm}}.
    -   Se hai domande tecniche sullo sviluppo o la distribuzione di cluster o applicazioni con
{{site.data.keyword.containerlong_notm}}, inserisci la tua domanda in
[Stack Overflow ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e contrassegnala con le tag `ibm-cloud`, `kubernetes` e `containers`.
    -   Per domande sul servizio e istruzioni introduttive, utilizza il forum
[IBM Developer Answers ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Includi le tag `ibm-cloud`
e `containers`.
    Consulta [Come ottenere supporto](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) per ulteriori dettagli sull'utilizzo dei forum.
-   Contatta il supporto IBM aprendo un caso. Per informazioni su come aprire un caso di supporto IBM o sui livelli di supporto e sulla gravità dei casi, consulta [Come contattare il supporto](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support).
Quando riporti un problema, includi il tuo ID del cluster. Per ottenere il tuo ID del cluster, esegui `ibmcloud ks clusters`. Puoi anche utilizzare il [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) per raccogliere ed esportare informazioni pertinenti dal tuo cluster da condividere con il supporto IBM.
{: tip}

