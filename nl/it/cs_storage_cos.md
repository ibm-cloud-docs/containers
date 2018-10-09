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


# Archiviazione dei dati su IBM Cloud Object Storage
{: #object_storage}

## Creazione della tua istanza del servizio di archiviazione oggetti
{: #create_cos_service}

Prima di poter iniziare a utilizzare {{site.data.keyword.cos_full_notm}} nel tuo cluster, devi eseguire il provisioning di un'istanza del
servizio {{site.data.keyword.cos_full_notm}} nel tuo account.
{: shortdesc}

1. Esegui una distribuzione dell'istanza del servizio {{site.data.keyword.cos_full_notm}}.
   1.  Apri la [pagina del catalogo {{site.data.keyword.cos_full_notm}}](https://console.bluemix.net/catalog/services/cloud-object-storage).
   2.  Immetti un nome per la tua istanza del servizio, quale `cos-backup`, e seleziona **default** come tuo gruppo di risorse.
   3.  Esamina le [opzioni di piano ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) per le informazioni sui prezzi e seleziona un piano.
   4.  Fai clic su **Crea**.Viene visualizzata la pagina dei dettagli del servizio.
2. {: #service_credentials}Richiama le credenziali del servizio {{site.data.keyword.cos_full_notm}}.
   1.  Nella navigazione nella pagina dei dettagli del servizio, fai clic su **Credenziali del servizio**.
   2.  Fai clic su **Nuova credenziale**. Viene visualizzata una finestra di dialogo.
   3.  Immetti un nome per le tue credenziali.
   4.  Dall'elenco a discesa **Ruolo**, seleziona `Writer` o `Manager`. Quando selezioni `Reader`, non puoi utilizzare le credenziali per creare i bucket in {{site.data.keyword.cos_full_notm}} e scrivervi dei dati.
   5.  Facoltativo: in **Aggiungi parametri di configurazione inline (facoltativo)**, immetti `{"HMAC":true}` per creare delle credenziali HMAC aggiuntive per il servizio {{site.data.keyword.cos_full_notm}}. L'autenticazione HMAC aggiunge uno livello supplementare di sicurezza all'autenticazione OAuth2 predefinita impedendo l'utilizzo improprio di token OAuth2 scaduti o creati casualmente.
   6.  Fai clic su **Aggiungi**.Le tue nuove credenziali sono elencate nella tabella **Credenziali del servizio**.
   7.  Fai clic su **Visualizza credenziali**.
   8.  Prendi nota dell'**apikey** per utilizzare i token OAuth2 per eseguire l'autenticazione presso il servizio {{site.data.keyword.cos_full_notm}}. Per l'autenticazione HMAC, nella sezione **cos_hmac_keys**, prendi nota di **access_key_id** e **secret_access_key**.
3. [Archivia le tue credenziali del servizio in un segreto Kubernetes all'interno del cluster](#create_cos_secret) per abilitare l'accesso alla tua istanza del servizio {{site.data.keyword.cos_full_notm}}.

## Creazione di un segreto per le credenziali del servizio di archiviazione oggetti
{: #create_cos_secret}

Per accedere alla tua istanza del servizio {{site.data.keyword.cos_full_notm}} per leggere e scrivere dati, devi archiviare in modo protetto le credenziali del servizio in un segreto Kubernetes. Il plug-in {{site.data.keyword.cos_full_notm}} utilizza queste credenziali per ogni operazione di lettura o scrittura nel tuo bucket.
{: shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster.

1. Richiama la **apikey**, oppure l'**access_key_id** e la **secret_access_key**, delle tue [credenziali del servizio {{site.data.keyword.cos_full_notm}}](#service_credentials).

2. Ottieni il **GUID** della tua istanza del servizio {{site.data.keyword.cos_full_notm}}.
   ```
   ibmcloud resource service-instance <service_name>
   ```
   {: pre}

3. Codifica il {{site.data.keyword.cos_full_notm}} **GUID** e la **apikey**, oppure l'**access_key_id** e la **secret_access_key** che hai richiamato in precedenza, in base64 e prendi nota di tutti i valori con codifica base64. Ripeti questo comando per ciascun parametro per richiamare il valore con codifica base64.
   ```
   echo -n "<key_value>" | base64
   ```
   {: pre}

4. Crea un file di configurazione per definire il tuo segreto Kubernetes.

   **Esempio per l'utilizzo della chiave API:**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     api-key: <base64_apikey>
     service-instance-id: <base64_guid>
   ```
   {: codeblock}

   **Esempio per l'utilizzo dell'autenticazione HMAC:**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     access-key: <base64_access_key_id>
     secret-key: <base64_secret_access_key>
     service-instance-id: <base64_guid>
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
   <td>Immetti un nome per il tuo segreto {{site.data.keyword.cos_full_notm}}.</td>
   </tr>
   <tr>
   <td><code>metadata/namespace</code></td>
   <td>Specifica lo spazio dei nomi in cui vuoi creare il segreto. Il segreto deve essere creato nello stesso spazio dei nomi in cui vuoi creare la tua PVC e il pod che accede alla tua istanza del servizio {{site.data.keyword.cos_full_notm}}.  </td>
   </tr>
   <tr>
   <td><code>data/api-key</code></td>
   <td>Immetti la chiave API che hai richiamato dalle tue credenziali del servizio {{site.data.keyword.cos_full_notm}} precedentemente. La chiave API deve avere una codifica base64. Se vuoi utilizzare l'autenticazione HMAC, specifica invece <code>data/access-key</code> e <code>data/secret-key</code>.  </td>
   </tr>
   <tr>
   <td><code>data/access-key</code></td>
   <td>Immetti l'ID chiave di accesso che hai richiamato dalle tue credenziali del servizio {{site.data.keyword.cos_full_notm}} precedentemente. L'ID chiave di accesso deve avere una codifica base64. Se vuoi utilizzare l'autenticazione OAuth2, specifica invece <code>data/api-key</code>.  </td>
   </tr>
   <tr>
   <td><code>data/secret-key</code></td>
   <td>Immetti la chiave di accesso segreta che hai richiamato dalle tue credenziali del servizio {{site.data.keyword.cos_full_notm}} precedentemente. La chiave di accesso segreta deve avere una codifica base64. Se vuoi utilizzare l'autenticazione OAuth2, specifica invece <code>data/api-key</code>.  </td>
   </tr>
   <tr>
   <td><code>data/service-instance-id</code></td>
   <td>Immetti il GUID della tua istanza del servizio {{site.data.keyword.cos_full_notm}} che hai richiamato precedentemente. Il GUID deve avere una codifica base64. </td>
   </tr>
   </tbody>
   </table>

5. Crea il segreto nel tuo cluster.
   ```
   kubectl apply -f filepath/secret.yaml
   ```
   {: pre}

6. Verifica che il segreto venga creato nel tuo spazio dei nomi.
   ```
   kubectl get secret
   ```
   {: pre}

7. [Installa il plug-in {{site.data.keyword.cos_full_notm}}](#install_cos) o, se lo hai già installato, [decidi in merito alla configurazione ]( #configure_cos) per il tuo bucket {{site.data.keyword.cos_full_notm}}.

## Installazione del plug-in IBM Cloud Object Storage
{: #install_cos}

Installa il plug-in {{site.data.keyword.cos_full_notm}} con un grafico Helm per configurare le classi di archiviazione predefinite per {{site.data.keyword.cos_full_notm}}. Puoi utilizzare queste classi di archiviazione per creare una PVC per eseguire il provisioning di {{site.data.keyword.cos_full_notm}} per le tue applicazioni.
{: shortdesc}

Cerchi le istruzioni su come aggiornare o rimuovere il plug-in {{site.data.keyword.cos_full_notm}}? Vedi [Aggiornamento del plug-in](#update_cos_plugin) e [Rimozione del plug-in](#remove_cos_plugin).
{: tip}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui desideri installare il plug-in {{site.data.keyword.cos_full_notm}}.

1. Attieniti alle [istruzioni](cs_integrations.html#helm) per installare il client Helm sulla tua macchina locale, installare il server Helm (tiller) nel tuo cluster e aggiungere il repository di grafici {{site.data.keyword.Bluemix_notm}} Helm al cluster dove vuoi utilizzare il plug-in {{site.data.keyword.cos_full_notm}}.

    **Importante:** se utilizzi Helm versione 2.9 o successive, assicurati di avere installato tiller con un [account di servizio](cs_integrations.html#helm).
2. Aggiungi il repository {{site.data.keyword.Bluemix_notm}} Helm al tuo cluster.
   ```
   helm repo add ibm https://registry.bluemix.net/helm/ibm
   ```
   {: pre}

3. Aggiorna il repository Helm per richiamare la versione più recente di tutti i grafici Helm in questo repository.
   ```
   helm repo update
   ```
   {: pre}

4. Installa il plug-in {{site.data.keyword.cos_full_notm}}Helm `ibmc`. Il plug-in viene utilizzato per richiamare automaticamente l'ubicazione del tuo cluster e per impostare l'endpoint API per i tuoi bucket {{site.data.keyword.cos_full_notm}} nelle tue classi di archiviazione.
   1. Scarica il grafico Helm e decomprimi il grafico nella tua directory corrente.    
      ```
      helm fetch --untar ibm/ibmcloud-object-storage-plugin
      ```
      {: pre}
   2. Installa il plug-in Helm.
      ```
      helm plugin install ibmcloud-object-storage-plugin/helm-ibmc
      ```
      {: pre}

      Output di esempio:
        ```
      Installed plugin: ibmc
      ```
      {: screen}

5. Verifica che il plug-in `ibmc` sia installato correttamente.
   ```
   helm ibmc --help
   ```
   {: pre}

   Output di esempio:
   ```
   Install or upgrade Helm charts in IBM K8S Service

   Available Commands:
    helm ibmc install [CHART] [flags]              Install a Helm chart
    helm ibmc upgrade [RELEASE] [CHART] [flags]    Upgrades the release to a new version of the Helm chart

   Available Flags:
    --verbos                      (Optional) Verbosity intensifies... ...
    -f, --values valueFiles       (Optional) specify values in a YAML file (can specify multiple) (default [])
    -h, --help                    (Optional) This text.
    -u, --update                  (Optional) Update this plugin to the latest version

   Example Usage:
    helm ibmc install ibm/ibmcloud-object-storage-plugin -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: screen}

6. Facoltativo: limita il plug-in {{site.data.keyword.cos_full_notm}} per accedere solo ai segreti Kubernetes che detengono le tue credenziali del servizio {{site.data.keyword.cos_full_notm}}. Per impostazione predefinita, il plug-in è autorizzato ad accedere a tutti i segreti Kubernetes nel tuo cluster.
   1. [Crea la tua istanza del servizio {{site.data.keyword.cos_full_notm}}](#create_cos_service).
   2. [Archivia le tue credenziali del servizio {{site.data.keyword.cos_full_notm}} service in un segreto Kubernetes](#create_cos_secret).
   3. Passa alla directory `templates` ed elenca i file disponibili.  
      ```
      cd ibmcloud-object-storage-plugin/templates && ls
      ```
      {: pre}

   4. Apri il file `provisioner-sa.yaml` e cerca la definizione di ClusterRole `ibmcloud-object-storage-secret-reader`.
   6. Aggiungi il nome del segreto che hai creato in precedenza all'elenco di segreti a cui il plug-in è autorizzato ad accedere nella sezione `resourceNames`.
      ```
      kind: ClusterRole
      apiVersion: rbac.authorization.k8s.io/v1beta1
      metadata:
        name: ibmcloud-object-storage-secret-reader
      rules:
      - apiGroups: [""]
        resources: ["secrets"]
        resourceNames: ["<secret_name1>","<secret_name2>"]
        verbs: ["get"]
      ```
      {: codeblock}
   7. Salva le modifiche.

8. Installa il plug-in {{site.data.keyword.cos_full_notm}}.Quando installi il plug-in, al tuo cluster vengono aggiunte le classi di archiviazione predefinite.

   **Installa senza una limitazione a specifici segreti Kubernetes:**
   ```
   helm ibmc install ibm/ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

   **Installa con una limitazione a specifici segreti Kubernetes come descritto nel passo precedente:**
   ```
   helm ibmc install ./ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

   Output di esempio:
   ```
   Installing the Helm chart
   DC: dal10  Chart: ibm/ibmcloud-object-storage-plugin
   NAME:   mewing-duck
   LAST DEPLOYED: Mon Jul 30 13:12:59 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1/Pod(related)
   NAME                                             READY  STATUS             RESTARTS  AGE
   ibmcloud-object-storage-driver-hzqp9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-jtdb9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-tl42l             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-plugin-7d87fbcbcc-wgsn8  0/1    ContainerCreating  0         1s

   ==> v1beta1/StorageClass
   NAME                                  PROVISIONER       AGE
   ibmc-s3fs-cold-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-cold-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-cross-region      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-regional          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-cross-region       ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-cross-region  ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-regional      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-regional           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-cross-region          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-regional              ibm.io/ibmc-s3fs  1s

   ==> v1/ServiceAccount
   NAME                            SECRETS  AGE
   ibmcloud-object-storage-driver  1        1s
   ibmcloud-object-storage-plugin  1        1s

   ==> v1beta1/ClusterRole
   NAME                                   AGE
   ibmcloud-object-storage-secret-reader  1s
   ibmcloud-object-storage-plugin         1s

   ==> v1beta1/ClusterRoleBinding
   NAME                                   AGE
   ibmcloud-object-storage-plugin         1s
   ibmcloud-object-storage-secret-reader  1s

   ==> v1beta1/DaemonSet
   NAME                            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-object-storage-driver  3        3        0      3           0          <none>         1s

   ==> v1beta1/Deployment
   NAME                            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-object-storage-plugin  1        1        1           0          1s

   NOTES:
   Thank you for installing: ibmcloud-object-storage-plugin.   Your release is named: mewing-duck

   Please refer Chart README.md file for creating a sample PVC.
   Please refer Chart RELEASE.md to see the release details/fixes.
   ```
   {: screen}

9. Verifica che il plug-in sia installato correttamente.
   ```
   kubectl get pod -n kube-system -o wide | grep object
   ```
   {: pre}

   Output di esempio:
   ```
   ibmcloud-object-storage-driver-9n8g8                              1/1       Running   0          2m
   ibmcloud-object-storage-plugin-7c774d484b-pcnnx                   1/1       Running   0          2m
   ```
   {: screen}

   L'installazione ha avuto esito positivo quando visualizzi un pod `ibmcloud-object-storage-plugin` e uno o più pod `ibmcloud-object-storage-driver`. Il numero di pod `ibmcloud-object-storage-driver` è uguale al numero di nodi di lavoro nel tuo cluster. Tutti i pod devono essere in uno stato `Running` perché il plug-in funzioni correttamente. Se si verifica un malfunzionamento dei pod, esegui `kubectl describe pod -n kube-system <pod_name>` per trovare la causa radice per il malfunzionamento.

10. Verifica che le classi di archiviazione vengano create correttamente.
   ```
   kubectl get storageclass | grep s3
   ```
   {: pre}

   Output di esempio:
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

11. Ripeti i passi per tutti i cluster dove vuoi accedere ai bucket {{site.data.keyword.cos_full_notm}}.

### Aggiornamento del plug-in IBM Cloud Object Storage
{: #update_cos_plugin}

Puoi eseguire un upgrade del plug-in {{site.data.keyword.cos_full_notm}} esistente alla versione più recente.
{: shortdesc}

1. Aggiorna il repository Helm per richiamare la versione più recente di tutti i grafici Helm in questo repository.
   ```
   helm repo update
   ```
   {: pre}

2. Scarica il grafico Helm più recente sulla tua macchina locale e decomprimi il pacchetto per esaminare il file `release.md` per trovare le informazioni sulla release più aggiornate.
   ```
   helm fetch --untar ibm/ibmcloud-object-storage-plugin
   ```

3. Trova il nome di installazione del tuo grafico helm.
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}

   Output di esempio:
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}

4. Esegui l'upgrade del plug-in {{site.data.keyword.cos_full_notm}} alla versione più recente.
   ```   
   helm ibmc upgrade <helm_chart_name> ibm/ibmcloud-object-storage-plugin --force --recreate-pods -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

5. Verifica che l'upgrade di `ibmcloud-object-storage-plugin` venga eseguito correttamente.  
   ```
   kubectl rollout status deployment/ibmcloud-object-storage-plugin -n kube-system
   ```
   {: pre}

   L'upgrade del plug-in è riuscito quando vedi `deployment "ibmcloud-object-storage-plugin" successfully rolled out` nel tuo output della CLI.

6. Verifica che l'upgrade di `ibmcloud-object-storage-driver` venga eseguito correttamente.
   ```
   kubectl rollout status ds/ibmcloud-object-storage-driver -n kube-system
   ```
   {: pre}

   L'upgrade è riuscito quando vedi `daemon set "ibmcloud-object-storage-driver" successfully rolled out` nel tuo output della CLI.

7. Verifica che i pod {{site.data.keyword.cos_full_notm}} siano in uno stato `Running`.
   ```
   kubectl get pods -n kube-system -o wide | grep object-storage
   ```
   {: pre}


### Rimozione del plug-in IBM Cloud Object Storage
{: #remove_cos_plugin}

Se non vuoi eseguire il provisioning di {{site.data.keyword.cos_full_notm}} e farne uso nel tuo cluster, puoi disinstallare i grafici helm.

**Nota:** la rimozione del plug-in non rimuove PVC, PV o dati esistenti. Quando rimuovi il plug-in, tutti i pod e le serie di daemon correlati vengono rimossi dal tuo cluster. Non puoi eseguire il provisioning di un nuovo {{site.data.keyword.cos_full_notm}} per il tuo cluster o utilizzare i PVC e i PV esistenti dopo che hai rimosso il plug-in, a meno che tu non configuri l'applicazione per utilizzare l'API {{site.data.keyword.cos_full_notm}} direttamente.

Prima di iniziare:

- [Indirizza la tua CLI al cluster](cs_cli_install.html#cs_cli_configure).
- Assicurati di non avere PVC o PV nel tuo cluster che utilizzano {{site.data.keyword.cos_full_notm}}. Per elencare tutti i pod che montano uno specifico PVC, esegui `kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"`.

Per rimuovere il plug-in:

1. Trova il nome di installazione del tuo grafico helm.
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}

   Output di esempio:
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}

2. Elimina il plug-in {{site.data.keyword.cos_full_notm}} rimuovendo il grafico Helm.
   ```
   helm delete --purge <helm_chart_name>
   ```
   {: pre}

3. Verifica che i pod {{site.data.keyword.cos_full_notm}} vengano rimossi.
   ```
   kubectl get pod -n kube-system | grep object-storage
   ```
   {: pre}

   La rimozione dei pod è riuscita se nel tuo output CLI non vengono visualizzati pod.

4. Verifica che le classi di archiviazione vengano rimosse.
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}

   La rimozione delle classi di archiviazione è riuscita se nel tuo output CLI non vengono visualizzate classi di archiviazione.

5. Rimuovi il plug-in Helm `ibmc`.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

6. Verifica che il plug-in `ibmc` venga rimosso.
   ```
   helm plugin list
   ```
   {: pre}

   Output di esempio:
   ```
   NAME	VERSION	DESCRIPTION
   ```
   {: screen}

   Il plug-in `ibmc` viene rimosso correttamente se il plug-in `ibmc` non è elencato nel tuo output della CLI.


## Decisioni relative alla configurazione dell'archiviazione oggetti
{: #configure_cos}

{{site.data.keyword.containerlong_notm}} fornisce delle classi di archiviazione predefinite che puoi utilizzare per creare i bucket con una specifica configurazione.

1. Elenca le classi di archiviazione disponibili in {{site.data.keyword.containerlong_notm}}.
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}

   Output di esempio:
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

2. Scegli una classe di archiviazione adatta ai tuoi requisiti di accesso ai dati. La classe di archiviazione determina i [prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) per la capacità di archiviazione, le operazioni di lettura e scrittura e la larghezza di banda in uscita per un bucket. L'opzione corretta per te è basata sulla frequenza con cui i dati vengono letti e scritti nella tua istanza del servizio.
   - **Standard**: questa opzione è usata per i dati hot a cui si accede frequentemente. I casi d'uso comuni sono le applicazioni web o mobili.
   - **Vault**: questa opzione viene utilizzata per i carichi di lavoro o i dati cool a cui si accede poco di frequente, ad esempio una volta al mese o meno. I casi d'uso comuni sono gli archivi, la conservazione dei dati a breve termine, la conservazione di asset digitali, la sostituzione dei nastri e il ripristino d'emergenza.
   - **Cold**: questa opzione viene utilizzata per i dati cold a cui si accede raramente (ogni 90 giorni o meno) o i dati inattivi. I casi d'uso comuni sono gli archivi, i backup a lungo termine, i dati cronologici che conservi per la conformità oppure i carichi di lavoro e le applicazioni a cui si accede raramente.
   - **Flex**: questa opzione viene utilizzata per i carichi di lavoro e i dati che non seguono uno specifico modello di utilizzo o che sono troppo grandi per determinare o prevedere un modello di utilizzo. **Suggerimento:** controlla questo [blog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/03/interconnect-2017-changing-rules-storage/) per capire come funziona la classe di archiviazione Flex rispetto ai livelli di archiviazione tradizionali.   

3. Decidi il livello di resilienza per i dati archiviati nel tuo bucket.
   - **Interregionale**: con questa opzione, i tuoi dati vengono archiviati tra tre regioni all'interno di una geolocalizzazione per la massima disponibilità. Se hai dei carichi di lavoro distribuiti tra le regioni, le richieste vengono instradate all'endpoint regionale più vicino. L'endpoint API per la geolocalizzazione viene impostato automaticamente dal plug-in Helm `ibmc` che hai installato in precedenza in base all'ubicazione in cui si trova il tuo cluster. Ad esempio, se il tuo cluster si trova negli `Stati Uniti Sud`, le tue classi di archiviazione sono configurate per utilizzare l'endpoint API `US GEO` per i tuoi bucket. Per ulteriori informazioni, vedi [Regioni ed endpoint](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints).  
   - **Regionale**: con questa opzione, i tuoi dati vengono replicati in più zone all'interno di una singola regione. Se hai dei carichi di lavoro che si trovano nella stessa regione, vedi una latenza più bassa e delle prestazioni migliori rispetto a una configurazione interregionale. L'endpoint regionale viene impostato automaticamente dal plug-in Helm `ibm` che hai installato in precedenza in base all'ubicazione in cui si trova il tuo cluster. Ad esempio, se il tuo cluster si trova negli `Stati Uniti Sud`, le tue classi di archiviazione erano configurate per utilizzare `US South` come endpoint regionale per i tuoi bucket. Per ulteriori informazioni, vedi [Regioni ed endpoint](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints).

4. Riesamina la configurazione del bucket {{site.data.keyword.cos_full_notm}} dettagliata per una classe di archiviazione.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Output di esempio:
   ```
   Name:                  ibmc-s3fs-standard-cross-region
   IsDefaultClass:        No
   Annotations:           <none>
   Provisioner:           ibm.io/ibmc-s3fs
   Parameters:            ibm.io/chunk-size-mb=16,ibm.io/curl-debug=false,ibm.io/debug-level=warn,ibm.io/iam-endpoint=https://iam.bluemix.net,ibm.io/kernel-cache=true,ibm.io/multireq-max=20,ibm.io/object-store-endpoint=https://s3-api.dal-us-geo.objectstorage.service.networklayer.com,ibm.io/object-store-storage-class=us-standard,ibm.io/parallel-count=2,ibm.io/s3fs-fuse-retry-count=5,ibm.io/stat-cache-size=100000,ibm.io/tls-cipher-suite=AESGCM
   AllowVolumeExpansion:  <unset>
   MountOptions:          <none>
   ReclaimPolicy:         Delete
   VolumeBindingMode:     Immediate
   Events:                <none>
   ```
   {: screen}

   <table>
   <caption>Descrizione dei dettagli delle classi di archiviazione</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>ibm.io/chunk-size-mb</code></td>
   <td>La dimensione del blocco di dati letta da o scritta in {{site.data.keyword.cos_full_notm}}, espressa in megabyte. Le classi di archiviazione con <code>perf</code> nel loro nome sono configurate con 52 megabyte. Le classi di archiviazione senza <code>perf</code> nel loro nome utilizzano blocchi di 16 megabyte. Ad esempio, se vuoi leggere un file di 1GB, il plug-in legge questo file in più blocchi di 16 o 52 megabyte. </td>
   </tr>
   <tr>
   <td><code>ibm.io/curl-debug</code></td>
   <td>Abilita la registrazione delle richieste inviate all'istanza del servizio {{site.data.keyword.cos_full_notm}}. Se abilitata, i log vengono inviati a `syslog` e puoi [inoltrare i log a un server di registrazione esterno](cs_health.html#logging). Per impostazione predefinita, tutte le classi di archiviazione sono impostate su <strong>false</strong> per disabilitare questa funzione di registrazione.</td>
   </tr>
   <tr>
   <td><code>ibm.io/debug-level</code></td>
   <td>Il livello di registrazione impostato dal plug-in {{site.data.keyword.cos_full_notm}}. Tutte le classi di archiviazione sono configurate con il livello di registrazione <strong>WARN</strong>. </td>
   </tr>
   <tr>
   <td><code>ibm.io/iam-endpoint</code></td>
   <td>L'endpoint API per IAM (Identity and Access Management). </td>
   </tr>
   <tr>
   <td><code>ibm.io/kernel-cache</code></td>
   <td>Abilita o disabilita la cache del buffer del kernel per il punto di montaggio del volume. Se abilitata, i dati letti da {{site.data.keyword.cos_full_notm}} sono archiviati nella cache del kernel per garantire un accesso in lettura rapido ai tuoi dati. Se disabilitata, i dati non vengono memorizzati nella cache e sono sempre letti da {{site.data.keyword.cos_full_notm}}. La cache del kernel è abilitata per le classi di archiviazione <code>standard</code> e <code>flex</code> e disabilitata per le classi di archiviazione <code>cold</code> e <code>vault</code>. </td>
   </tr>
   <tr>
   <td><code>ibm.io/multireq-max</code></td>
   <td>Il numero massimo di richieste parallele che può essere inviato all'istanza del servizio {{site.data.keyword.cos_full_notm}} per elencare i file in una singola directory. Tutte le classi di archiviazione sono configurate con un massimo di 20 richieste parallele. </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-endpoint</code></td>
   <td>L'endpoint API da utilizzare per accedere al bucket nella tua istanza del servizio {{site.data.keyword.cos_full_notm}}. L'endpoint viene impostato automaticamente in base alla regione del tuo cluster. </br></br><strong>Nota: </strong> se vuoi accedere a un bucket esistente che si trova in una regione diversa rispetto a quella in cui si trova il tuo cluster, devi creare una [classe di archiviazione personalizzata](cs_storage_basics.html#customized_storageclass) e utilizzare l'endpoint API per il tuo bucket. </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-storage-class</code></td>
   <td>Il nome della classe di archiviazione. </td>
   </tr>
   <tr>
   <td><code>ibm.io/parallel-count</code></td>
   <td>Il numero massimo di richieste parallele che può essere inviato all'istanza del servizio {{site.data.keyword.cos_full_notm}} per una singola operazione di lettura o scrittura. Le classi di archiviazione con <code>perf</code> nel loro nome sono configurate con un massimo di 20 richieste parallele. Le classi di archiviazione senza <code>perf</code> sono configurate con 2 richieste parallele per impostazione predefinita. </td>
   </tr>
   <tr>
   <td><code>ibm.io/s3fs-fuse-retry-count</code></td>
   <td>Il numero massimo di nuovi tentativi per un'operazione di lettura o scrittura prima che l'operazione venga considerata non riuscita. Tutte le classi di archiviazione sono configurate con un massimo di 5 nuovi tentativi. </td>
   </tr>
   <tr>
   <td><code>ibm.io/stat-cache-size</code></td>
   <td>Il numero massimo di record conservato nella cache dei metadati {{site.data.keyword.cos_full_notm}}. Ogni record può richiedere fino a 0,5 kilobyte. Tutte le classi di archiviazione impostano il numero massimo di record a 100000 per impostazione predefinita. </td>
   </tr>
   <tr>
   <td><code>ibm.io/tls-cipher-suite</code></td>
   <td>La suite di cifratura TLS che deve essere utilizzata quando viene stabilita una connessione a {{site.data.keyword.cos_full_notm}} tramite l'endpoint HTTPS. Il valore per la suite di cifratura deve rispettare il [formato OpenSSL ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html). Tutte le classi di archiviazione utilizzano la suite di cifratura <strong>AESGCM</strong> per impostazione predefinita. </td>
   </tr>
   </tbody>
   </table>

   Per ulteriori informazioni su ciascuna classe di archiviazione, vedi la sezione di [riferimento delle classi di archiviazione](#storageclass_reference). Se vuoi modificare qualche valore preimpostato, crea una tua [classe di archiviazione personalizzata](cs_storage_basics.html#customized_storageclass).
   {: tip}

5. Decidei un nome per il tuo bucket. Il nome di un bucket deve essere univoco in {{site.data.keyword.cos_full_notm}}. Puoi anche scegliere di creare automaticamente un nome per il tuo bucket dal plug-in {{site.data.keyword.cos_full_notm}}. Per organizzare i dati in un bucket, puoi creare delle sottodirectory.

   ** Nota:** la classe di archiviazione che hai scelto in precedenza determina il prezzo per l'intero bucket. Non puoi definire delle classi di archiviazione differenti per le sottodirectory. Se vuoi archiviare i dati con requisiti di accesso differenti, considera la creazione di più bucket utilizzando più PVC.

6. Scegli se vuoi mantenere i tuoi dati e il bucket dopo l'eliminazione del cluster o dell'attestazione del volume persistente (o PVC, persistent volume claim).Quando elimini la PVC, il PV viene sempre eliminato. Puoi scegliere se vuoi anche eliminare automaticamente i dati e il bucket quando elimini la PVC. La tua istanza del servizio {{site.data.keyword.cos_full_notm}} è indipendente dalla politica di conservazione che selezioni per i tuoi dati e non viene mai rimossa quando elimini una PVC.

Ora che hai deciso in merito alla configurazione che desideri, sei pronto a [creare una PVC](#add_cos) per eseguire il provisioning di {{site.data.keyword.cos_full_notm}}.

## Aggiunta dell'archiviazione oggetti alle applicazioni
{: #add_cos}

Crea un'attestazione del volume persistente (o PVC, persistent volume claim) per eseguire il provisioning di {{site.data.keyword.cos_full_notm}} per il tuo cluster.
{: shortdesc}

A seconda delle impostazioni che scegli nella tua PVC, puoi eseguire il provisioning di {{site.data.keyword.cos_full_notm}} nei seguenti modi:
- [Provisioning dinamico](cs_storage_basics.html#dynamic_provisioning): quando crei una PVC, il volume persistente (o PV, persistent volume) e il bucket nella tua istanza del servizio {{site.data.keyword.cos_full_notm}} vengono creati automaticamente.
- [Provisioning statico](cs_storage_basics.html#static_provisioning): puoi fare riferimento a un bucket esistente nella tua istanza del servizio {{site.data.keyword.cos_full_notm}} nella tua PVC. Quando crei la PVC, il PV corrispondente viene automaticamente creato e collegato al tuo bucket esistente in {{site.data.keyword.cos_full_notm}}.

Prima di iniziare:
- [Crea e prepara la tua istanza del servizio {{site.data.keyword.cos_full_notm}}](#create_cos_service).
- [Crea un segreto per archiviare le tue credenziali del servizio {{site.data.keyword.cos_full_notm}}](#create_cos_secret).
- [Decidi in merito alla configurazione per il tuo {{site.data.keyword.cos_full_notm}}](#configure_cos).

Per aggiungere {{site.data.keyword.cos_full_notm}} al tuo cluster:

1. Crea un file di configurazione per definire la tua attestazione del volume persistente (o PVC, persistent volume claim).
   ```
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: <pvc_name>
     namespace: <namespace>
     annotations:
       volume.beta.kubernetes.io/storage-class: "<storage_class>"
       ibm.io/auto-create-bucket: "<true_or_false>"
       ibm.io/auto-delete-bucket: "<true_or_false>"
       ibm.io/bucket: "<bucket_name>"
       ibm.io/object-path: "<bucket_subdirectory>"
       ibm.io/secret-name: "<secret_name>"
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 8Gi # Enter a fictitious value
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
   <td><code>metadata/namespace</code></td>
   <td>Immetti lo spazio dei nomi in cui vuoi creare la PVC. La PVC deve essere creata nello stesso spazio dei nomi in cui hai creato il segreto Kubernetes per le tue credenziali del servizio {{site.data.keyword.cos_full_notm}} e dove vuoi eseguire il tuo pod. </td>
   </tr>
   <tr>
   <td><code>volume.beta.kubernetes.io/storage-class</code></td>
   <td>Scegli tra le seguenti opzioni: <ul><li>Se <code>ibm.io/auto-create-bucket</code> è impostata su <strong>true</strong>: immetti la classe di archiviazione che vuoi utilizzare per il tuo nuovo bucket.</li><li>Se <code>ibm.io/auto-create-bucket</code> è impostato su <strong>false</strong>: immetti la classe di archiviazione che hai utilizzato per creare il tuo bucket esistente. </br></br>Se hai creato manualmente il bucket nella tua istanza del servizio {{site.data.keyword.cos_full_notm}} oppure non riesci a ricordare la classe di archiviazione che hai utilizzato, trova la tua istanza del servizio nel dashboard {{site.data.keyword.Bluemix}} e controlla <strong>Classe</strong> e <strong>Ubicazione</strong> del tuo bucket esistente. Usa quindi una [classe di archiviazione](#storageclass_reference) appropriata. </br></br><strong>Nota: </strong> l'endpoint API {{site.data.keyword.cos_full_notm}} impostato nella tua classe di archiviazione è basato sulla regione in cui si trova il tuo cluster. Se vuoi accedere a un bucket che si trova in una regione diversa da quella in cui si trova il tuo cluster, devi creare una [classe di archiviazione personalizzata](cs_storage_basics.html#customized_storageclass) e utilizzare l'endpoint API appropriato per il tuo bucket. </li></ul>  </td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-create-bucket</code></td>
   <td>Scegli tra le seguenti opzioni: <ul><li><strong>true</strong>: quando crei la PVC, il PV e il bucket nella tua istanza del servizio {{site.data.keyword.cos_full_notm}} vengono creati automaticamente. Scegli questa opzione per creare un nuovo bucket nella tua istanza del servizio {{site.data.keyword.cos_full_notm}}. </li><li><strong>false</strong>: scegli questa opzione se vuoi accedere ai dati in un bucket esistente. Quando crei la PVC, il PV viene automaticamente creato e collegato al bucket che hai specificato in <code>ibm.io/bucket</code>.</td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-delete-bucket</code></td>
   <td>Scegli tra le seguenti opzioni: <ul><li><strong>true</strong>: i tuoi dati, il bucket e il PV vengono automaticamente rimossi quando elimini la PVC. La tua istanza del servizio {{site.data.keyword.cos_full_notm}} rimane e non viene eliminata. Se scegli di impostare questa opzione su <strong>true</strong>, devi impostare <code>ibm.io/auto-create-bucket: true</code> e <code>ibm.io/bucket: ""</code> in modo che il tuo bucket venga creato automaticamente con un nome con il formato <code>tmp-s3fs-xxxx</code>. </li><li><strong>false</strong>: quando elimini la PVC, il PV viene eliminato automaticamente ma i tuoi dati e il bucket nella tua istanza del servizio {{site.data.keyword.cos_full_notm}} rimangono. Per accedere ai tuoi dati, devi creare un nuovo PVC con il nome del tuo bucket esistente. </li></ul>
   <tr>
   <td><code>ibm.io/bucket</code></td>
   <td>Scegli tra le seguenti opzioni: <ul><li>Se <code>ibm.io/auto-create-bucket</code> è impostata su <strong>true</strong>: immetti il nome del bucket che vuoi creare in {{site.data.keyword.cos_full_notm}}. Se, inoltre, <code>ibm.io/auto-delete-bucket</code> è impostata su <strong>true</strong>, devi lasciare questo campo vuoto per assegnare automaticamente un nome al tuo bucket con il formato <code>tmp-s3fs-xxxx</code>. Il nome deve essere univoco in {{site.data.keyword.cos_full_notm}}. </li><li>Se <code>ibm.io/auto-create-bucket</code> è impostata su <strong>false</strong>: immetti il nome del bucket esistente a cui vuoi accedere nel cluster. </li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-path</code></td>
   <td>Facoltativo; immetti il nome della sottodirectory esistente nel tuo bucket che vuoi montare. Utilizza questa opzione se vuoi montare solo una sottodirectory e non l'intero bucket. Per montare una sottodirectory, devi impostare <code>ibm.io/auto-create-bucket: "false"</code> e fornire il nome del bucket in <code>ibm.io/bucket</code>. </li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/secret-name</code></td>
   <td>Immetti il nome del segreto che contiene le credenziali {{site.data.keyword.cos_full_notm}} che hai creato in precedenza. </td>
   </tr>
   <tr>
   <td><code>resources/requests/storage</code></td>
   <td>Una dimensione fittizia per il tuo bucket {{site.data.keyword.cos_full_notm}} in gigabyte. La dimensione è richiesta da Kubernetes, ma non è rispettata in {{site.data.keyword.cos_full_notm}}. Puoi immettere qualsiasi dimensione vuoi. Lo spazio effettivo che usi in {{site.data.keyword.cos_full_notm}} potrebbe essere diverso ed è fatturato in base alla [tabella dei prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api). </td>
   </tr>
   </tbody>
   </table>

2. Crea la PVC.
   ```
   kubectl apply -f filepath/pvc.yaml
   ```
   {: pre}

3. Verifica che la tua PVC sia stata creata e associata al PV.
   ```
   kubectl get pvc
   ```
   {: pre}

   Output di esempio:
   ```
   NAME                  STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                     AGE
   s3fs-test-pvc         Bound     pvc-b38b30f9-1234-11e8-ad2b-t910456jbe12   8Gi        RWO            ibmc-s3fs-standard-cross-region  1h
   ```
   {: screen}

4. Facoltativo: se intendi accedere ai tuoi dati con un utente non root, oppure hai aggiunto dei file a un bucket {{site.data.keyword.cos_full_notm}} esistente utilizzando la GUI o l'API direttamente, assicurati che ai [file sia assegnata l'autorizzazione corretta](cs_troubleshoot_storage.html#cos_nonroot_access) per consentire alla tua applicazione di leggerli e aggiornarli correttamente come necessario.

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
            securityContext:
              runAsUser: <non_root_user>
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
    <td><code>spec/containers/securityContext/runAsUser</code></td>
    <td>Facoltativo: per eseguire l'applicazione con un utente non root, specifica il [contesto di sicurezza ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) per il tuo pod definendo l'utente non root senza impostare al tempo stesso `fsGroup` nel tuo YAML di distribuzione. L'impostazione di `fsGroup` attiva il plug-in {{site.data.keyword.cos_full_notm}} per aggiornare le autorizzazioni del gruppo per tutti i file in un bucket quando viene distribuito il pod. L'aggiornamento delle autorizzazioni è un'operazione di scrittura e influisce sulle prestazioni. A seconda del numero di file che hai, l'aggiornamento delle autorizzazioni potrebbe impedire al tuo pod di avviarsi e di passare a uno stato di <code>Running</code>. </td>
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

7. Verifica che puoi scrivere dati nella tua istanza del servizio {{site.data.keyword.cos_full_notm}}.
   1. Accedi al pod che monta il tuo PV.
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. Vai al tuo percorso di montaggio del volume che hai definito nella distribuzione della tua applicazione.
   3. Crea un file di testo.
      ```
      echo "This is a test" > test.txt
      ```
      {: pre}

   4. Dal dashboard {{site.data.keyword.Bluemix}}, vai alla tua istanza del servizio {{site.data.keyword.cos_full_notm}}.
   5. Dal menu, seleziona **Bucket**.
   6. Apri il tuo bucket e verifica che puoi vedere il `test.txt` che hai creato.


## Backup e ripristino di dati
{: #backup_restore}

{{site.data.keyword.cos_full_notm}} è configurato per fornire un'elevata durabilità per i tuoi dati per offrire loro una protezione da eventuali perdite. Puoi trovare la SLA nei [termini del servizio {{site.data.keyword.cos_full_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-7857-03).
{: shortdesc}

**Importante:** {{site.data.keyword.cos_full_notm}} non fornisce una cronologia delle versioni per i tuoi dati. Se devi mantenere e accedere a versioni meno recenti dei tuoi dati, devi configurare l'applicazione per gestire la cronologia dei dati o implementare delle soluzioni di backup alternative. Ad esempio, potresti voler archiviare i tuoi dati {{site.data.keyword.cos_full_notm}} nel tuo database in locale oppure utilizzare i nastri per archiviare i tuoi dati.

## Riferimento delle classi di archiviazione
{: #storageclass_reference}

### Standard
{: #standard}

<table>
<caption>Classe di archiviazione oggetti: standard</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-s3fs-standard-cross-region</code></br><code>ibmc-s3fs-standard-perf-cross-region</code></br><code>ibmc-s3fs-standard-regional</code></br><code>ibmc-s3fs-standard-perf-regional</code></td>
</tr>
<tr>
<td>Endpoint di resilienza predefinito</td>
<td>L'endpoint di resilienza viene impostato automaticamente in base all'ubicazione in cui si trova il cluster. Per ulteriori informazioni, vedi [Regioni ed endpoint](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints).</td>
</tr>
<tr>
<td>Dimensione blocco</td>
<td>Classi di archiviazione senza `perf`: 16 MB</br>Classi di archiviazione con `perf`: 52 MB</td>
</tr>
<tr>
<td>Cache kernel</td>
<td>Abilitata</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Mensile</td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Vault
{: #Vault}

<table>
<caption>Classe di archiviazione oggetti: vault</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-s3fs-vault-cross-region</code></br><code>ibmc-s3fs-vault-regional</code></td>
</tr>
<tr>
<td>Endpoint di resilienza predefinito</td>
<td>L'endpoint di resilienza viene impostato automaticamente in base all'ubicazione in cui si trova il cluster. Per ulteriori informazioni, vedi [Regioni ed endpoint](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints).</td>
</tr>
<tr>
<td>Dimensione blocco</td>
<td>16 MB</td>
</tr>
<tr>
<td>Cache kernel</td>
<td>Disabilitata</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Mensile</td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Cold
{: #cold}

<table>
<caption>Classe di archiviazione oggetti: cold</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-s3fs-flex-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-flex-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>Endpoint di resilienza predefinito</td>
<td>L'endpoint di resilienza viene impostato automaticamente in base all'ubicazione in cui si trova il cluster. Per ulteriori informazioni, vedi [Regioni ed endpoint](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints).</td>
</tr>
<tr>
<td>Dimensione blocco</td>
<td>16 MB</td>
</tr>
<tr>
<td>Cache kernel</td>
<td>Disabilitata</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Mensile</td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Flex
{: #flex}

<table>
<caption>Classe di archiviazione oggetti: flex</caption>
<thead>
<th>Caratteristiche</th>
<th>Impostazione</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-s3fs-cold-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-cold-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>Endpoint di resilienza predefinito</td>
<td>L'endpoint di resilienza viene impostato automaticamente in base all'ubicazione in cui si trova il cluster. Per ulteriori informazioni, vedi [Regioni ed endpoint](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints).</td>
</tr>
<tr>
<td>Dimensione blocco</td>
<td>Classi di archiviazione senza `perf`: 16 MB</br>Classi di archiviazione con `perf`: 52 MB</td>
</tr>
<tr>
<td>Cache kernel</td>
<td>Abilitata</td>
</tr>
<tr>
<td>Fatturazione</td>
<td>Mensile</td>
</tr>
<tr>
<td>Prezzi</td>
<td>[Prezzi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>
