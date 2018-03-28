---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-01"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Introduzione ai cluster in {{site.data.keyword.Bluemix_dedicated_notm}}
{: #dedicated}

Se hai un account {{site.data.keyword.Bluemix_dedicated}}, puoi distribuire i cluster in un ambiente cloud dedicato (`https://<my-dedicated-cloud-instance>.bluemix.net`) e collegarti ai servizi {{site.data.keyword.Bluemix}} preselezionati che sono in esecuzione qui.
{:shortdesc}

Se non hai un account {{site.data.keyword.Bluemix_dedicated_notm}}, puoi [iniziare con {{site.data.keyword.containershort_notm}}](container_index.html#container_index) in un account {{site.data.keyword.Bluemix_notm}} pubblico.

## Informazioni sull'ambiente cloud dedicato
{: #dedicated_environment}

Con un account {{site.data.keyword.Bluemix_dedicated_notm}}, le risorse fisiche disponibili sono dedicate solo al tuo cluster e non vengono condivise con i cluster di altri clienti {{site.data.keyword.IBM_notm}}. Potresti scegliere di configurare un ambiente {{site.data.keyword.Bluemix_dedicated_notm}} se vuoi l'isolamento per il tuo cluster e richiedi tale isolamento anche per gli altri servizi {{site.data.keyword.Bluemix_notm}} che utilizzi. Se non hai un account dedicato, puoi creare i cluster con l'hardware dedicato in {{site.data.keyword.Bluemix_notm}} pubblico.

Con {{site.data.keyword.Bluemix_dedicated_notm}}, puoi creare i cluster dal catalogo nella console dedicata o utilizzando la CLI {{site.data.keyword.containershort_notm}}. Quando utilizzi la console dedicata, accedi ai tuoi account dedicato e pubblico contemporaneamente utilizzando il tuo ID IBM. Questo doppio login ti permette di accedere ai tuoi cluster pubblici utilizzando la console dedicata. Quando utilizzi la CLI, accedi utilizzando il tuo endpoint dedicato (`api.<my-dedicated-cloud-instance>.bluemix.net.`) e specifica l'endpoint API {{site.data.keyword.containershort_notm}} della regione pubblica associata all'ambiente dedicato.

Le maggiori differenze tra {{site.data.keyword.Bluemix_notm}} pubblico e dedicato sono le seguenti.

*   {{site.data.keyword.IBM_notm}} possiede e gestisce l'account dell'infrastruttura IBM Cloud (SoftLayer) in cui vengono distribuiti i nodi di lavoro, le VLAN e le sottoreti, anziché in un account di tua proprietà.
*   Le specifiche per tali VLAN e sottoreti vengono determinate quando viene abilitato l'ambiente dedicato e non quando viene creato il cluster. 

### Differenze nella gestione dei cluster tra gli ambienti cloud
{: #dedicated_env_differences}

|Area|{{site.data.keyword.Bluemix_notm}} pubblico|{{site.data.keyword.Bluemix_dedicated_notm}}|
|--|--------------|--------------------------------|
|Creazione cluster|Crea un cluster gratuito o specifica i seguenti dettagli per un cluster standard:<ul><li>Tipo di cluster</li><li>Nome</li><li>Ubicazione</li><li>Tipo di macchina</li><li>Numero di nodi di lavoro</li><li>VLAN pubblica</li><li>VLAN privata</li><li>Hardware</li></ul>|Specifica i seguenti dettagli per un cluster standard:<ul><li>Nome</li><li>Versione Kubernetes</li><li>Tipo di macchina</li><li>Numero di nodi di lavoro</li></ul><p>**Nota:** le impostazioni VLAN e Hardware vengono predefinite durante la creazione dell'ambiente {{site.data.keyword.Bluemix_notm}}.</p>|
|Hardware e proprietà del cluster|Nei cluster standard, l'hardware può essere condiviso da altri clienti {{site.data.keyword.IBM_notm}} o dedicato solo a te. Le VLAN pubbliche e private sono possedute e gestite da te nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).|Nei cluster su {{site.data.keyword.Bluemix_dedicated_notm}}, l'hardware è sempre dedicato. Le VLAN pubbliche e private appartengono e gestite da IBM per te. L'ubicazione è predefinita per l'ambiente {{site.data.keyword.Bluemix_notm}}.|
|Rete Programma di bilanciamento del carico e Ingress|Durante il provisioning dei cluster standard, si verificano automaticamente le seguenti azioni.<ul><li>Una sottorete pubblica portatile e una privata vengono associate al tuo cluster e assegnate al tuo account dell'infrastruttura IBM Cloud (SoftLayer). </li><li>Viene utilizzato un indirizzo IP pubblico portatile per un programma di bilanciamento del carico dell'applicazione altamente disponibile e viene assegnata una rotta pubblica univoca nel formato &lt;cluster_name&gt;.containers.mybluemix.net. Puoi utilizzare questa rotta per esporre più applicazioni pubblicamente. Viene utilizzato un indirizzo IP portatile per un programma di bilanciamento del carico dell'applicazione privato.</li><li>Vengono assegnati al cluster quattro indirizzi IP pubblici e quattro privati che possono venire utilizzati per esporre le applicazioni tramite i servizi del programma di bilanciamento del carico. È possibile richiedere ulteriori sottoreti attraverso il tuo account dell'infrastruttura IBM Cloud (SoftLayer).</li></ul>|Quando crei il tuo account dedicato, prendi una decisione di connettività su come vuoi esporre e accedere ai tuoi servizi del cluster. Se vuoi utilizzare i tuoi propri intervalli di IP aziendali (IP gestiti dall'utente), devi fornirli quando [configuri un ambiente {{site.data.keyword.Bluemix_dedicated_notm}}](/docs/dedicated/index.html#setupdedicated). <ul><li>Per impostazione predefinita, nessuna sottorete pubblica portatile viene associata ai cluster che crei nel tuo account dedicato. Invece, hai la flessibilità di scegliere il modello di connettività che si adatta meglio alla tua azienda.</li><li>Dopo che hai creato il cluster, scegli il tipo di sottoreti che vuoi associare e utilizzare con il tuo cluster per il programma di bilanciamento del carico o per la connettività Ingress.<ul><li>Per le sottoreti portatili pubblica e privata, puoi [aggiungere le sottoreti ai cluster](cs_subnets.html#subnets)</li><li>Per gli indirizzi IP gestiti dall'utente che hai fornito a IBM nell'onboarding dedicato,
puoi [aggiungere le sottoreti gestite dall'utente ai cluster](#dedicated_byoip_subnets).</li></ul></li><li>Dopo che hai associato una sottorete al tuo cluster, viene creato il controller Ingress. Una rotta Ingress pubblica viene creata solo se utilizzi una sottorete pubblica portatile.</li></ul>|
|Rete NodePort|Esponi una porta pubblica nel tuo nodo di lavoro e utilizza l'indirizzo IP pubblico del nodo di lavoro
per accedere pubblicamente al tuo servizio nel cluster.|Tutti gli indirizzi IP dei nodi di lavoro vengono bloccati da un firewall. Tuttavia per i servizi
{{site.data.keyword.Bluemix_notm}} aggiunti al cluster, è possibile accedere alla porta del nodo tramite un indirizzo IP pubblico o privato.|
|Memoria persistente|Utilizza il [provisioning
dinamico](cs_storage.html#create) o il [provisioning
statico](cs_storage.html#existing) dei volumi.|Utilizza il [provisioning
dinamico](cs_storage.html#create) dei volumi. [Apri un ticket di supporto](/docs/get-support/howtogetsupport.html#getting-customer-support) per richiedere un backup per i tuoi volumi, richiedere il ripristino dai tuoi volumi e per eseguire altre funzioni di archiviazione.</li></ul>|
|URL del registro di immagini in {{site.data.keyword.registryshort_notm}}|<ul><li>Stati Uniti Sud e Stati Uniti Est: <code>registry.ng bluemix.net</code></li><li>Regno Unito Sud: <code>registry.eu-gb.bluemix.net</code></li><li>Europa centrale (Francoforte): <code>registry.eu-de.bluemix.net</code></li><li>Australia (Sydney): <code>registry.au-syd.bluemix.net</code></li></ul>|<ul><li>Per i nuovi spazi dei nomi, utilizza gli stessi registri basati su regione definiti per {{site.data.keyword.Bluemix_notm}} pubblico. </li><li>Per gli spazi dei nomi configurati per i contenitori singoli e scalabili in {{site.data.keyword.Bluemix_dedicated_notm}}, utilizza <code>registry.&lt;dedicated_domain&gt;</code></li></ul>|
|Accesso al registro|Consulta le opzioni in [Utilizzo dei registri di immagini pubblici e privati con {{site.data.keyword.containershort_notm}}](cs_images.html).|<ul><li>Per i nuovi spazi dei nomi, vedi le opzioni in [Utilizzo dei registri di immagini pubblici e privati con {{site.data.keyword.containershort_notm}}](cs_images.html).</li><li>Per gli spazi dei nomi configurati per i gruppi di contenitori singoli e scalabili, [utilizza un token e crea un segreto
Kubernetes](cs_dedicated_tokens.html#cs_dedicated_tokens) per l'autenticazione.</li></ul>|
{: caption="Differenze delle funzioni tra {{site.data.keyword.Bluemix_notm}} pubblico e {{site.data.keyword.Bluemix_dedicated_notm}} " caption-side="top"}

<br />


### Architettura del servizio
{: #dedicated_ov_architecture}

Ogni nodo di lavoro è configurato con un Docker Engine gestito da {{site.data.keyword.IBM_notm}}, risorse di calcolo separate,
rete e servizio del volume. Le funzioni di sicurezza integrate forniscono l'isolamento, le funzionalità di gestione della risorsa e la conformità di sicurezza dei nodi di lavoro. Il nodo di lavoro comunica con il master
utilizzando i certificati di sicurezza TLS e la connessione openVPN.
{:shortdesc}

*La rete e l'architettura Kubernetes in {{site.data.keyword.Bluemix_dedicated_notm}}*

![{{site.data.keyword.containershort_notm}} Architettura Kubernetes in {{site.data.keyword.Bluemix_dedicated_notm}}](images/cs_dedicated_arch.png)

<br />


## Configurazione di {{site.data.keyword.containershort_notm}} in Dedicato
{: #dedicated_setup}

Ogni ambiente {{site.data.keyword.Bluemix_dedicated_notm}} ha un account aziendale, di proprietà del client, pubblico in {{site.data.keyword.Bluemix_notm}}. Per consentire agli utenti nell'ambiente dedicato di creare i cluster, l'amministratore deve aggiungere gli utenti a questo account aziendale pubblico per l'ambiente dedicato.

Prima di iniziare:
  * [Configura un ambiente {{site.data.keyword.Bluemix_dedicated_notm}}](/docs/dedicated/index.html#setupdedicated).
  * Se il tuo sistema locale o la tua rete aziendale controllano gli endpoint internet pubblici utilizzando i proxy o i firewall, devi [aprire le porte e gli indirizzi IP necessari nel tuo firewall](cs_firewall.html#firewall).
  * [Scarica la CLI Cloud Foundry ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/cloudfoundry/cli/releases) e [Aggiungi il plugin CLI di gestione di IBM Cloud](/docs/cli/plugins/bluemix_admin/index.html#adding-the-ibm-cloud-admin-cli-plug-in).

Per consentire agli utenti {{site.data.keyword.Bluemix_dedicated_notm}} di accedere ai cluster:

1.  Il proprietario del tuo account {{site.data.keyword.Bluemix_notm}} pubblico deve generare una chiave API.
    1.  Accedi all'endpoint per la tua istanza {{site.data.keyword.Bluemix_dedicated_notm}}. Immetti le credenziali {{site.data.keyword.Bluemix_notm}} per il proprietario dell'account pubblico e seleziona il tuo account quando richiesto.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza `--sso` e positivo con l'opzione `--sso`. 

    2.  Genera una chiave API per invitare gli utenti nell'account pubblico. Prendi nota del valore della chiave API, che l'amministratore dell'account dedicato utilizzerà nel prossimo passo.

        ```
        bx iam api-key-create <key_name> -d "Key to invite users to <dedicated_account_name>"
        ```
        {: pre}

    3.  Prendi nota del GUID dell'organizzazione dell'account pubblico in cui vuoi invitare gli utenti, che l'amministratore dell'account dedicato utilizzerà nel prossimo passo.

        ```
        bx account orgs
        ```
        {: pre}

2.  Il proprietario del tuo account {{site.data.keyword.Bluemix_dedicated_notm}} può invitare uno o più utenti nel tuo account pubblico.
    1.  Accedi all'endpoint per la tua istanza {{site.data.keyword.Bluemix_dedicated_notm}}. Immetti le credenziali {{site.data.keyword.Bluemix_notm}} per il proprietario dell'account dedicato e seleziona il tuo account quando richiesto. 

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza `--sso` e positivo con l'opzione `--sso`. 

    2.  Invita gli utenti nell'account pubblico.
        * Per invitare un solo utente:

            ```
            bx cf bluemix-admin invite-users-to-public -userid=<user_email> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```
            {: pre}

            Sostituisci <em>&lt;user_IBMid&gt;</em> con l'email dell'utente che vuoi invitare, <em>&lt;public_api_key&gt;</em> con la chiave API generata nel passo precedete e <em>&lt;public_org_id&gt;</em> con il GUID dell'organizzazione dell'account pubblico. Consulta [Invito di un utente da IBM Cloud Dedicated](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public) per ulteriori informazioni su questo comando.

        * Per invitare tutti gli utenti al momento in un'organizzazione dell'account dedicato:

            ```
            bx cf bluemix-admin invite-users-to-public -organization=<dedicated_org_id> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```

            Sostituisci <em>&lt;dedicated_org_id&gt;</em> con l'ID dell'organizzazione dell'account dedicato, <em>&lt;public_api_key&gt;</em> con la chiave API generata nel passo precedete e <em>&lt;public_org_id&gt;</em> con il GUID dell'organizzazione dell'account pubblico. Consulta [Invito di un utente da IBM Cloud Dedicated](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public) per ulteriori informazioni su questo comando.

    3.  Se esiste un ID IBM per un utente, l'utente viene automaticamente aggiunto all'organizzazione specificata nell'account pubblico. Se ancora non esiste un ID IBM per un utente, viene inviato un invito all'indirizzo email dell'utente. Dopo che l'utente ha accettato l'invito, viene creato un ID IBM per l'utente e viene aggiunto all'organizzazione specificata nell'account pubblico.

    4.  Verifica che gli utenti siano stati aggiunti all'account.

        ```
        bx cf bluemix-admin invite-users-status -apikey=<public_api_key>
        ```
        {: pre}

        Gli utenti invitati che hanno un ID IBM esistente avranno uno stato di `ATTIVO`. Gli utenti invitati che non hanno un ID IBM esistente avranno uno stato di `IN SOSPESO` o `ATTIVO` a seconda se hanno già accettato o meno l'invito all'account.

3.  Se un utente ha bisogno dei privilegi per creare un cluster, devi concedere il ruolo amministratore a tale utente.

    1.  Dalla barra dei menu nella console pubblica, fai clic su **Gestisci > Sicurezza > Identità e accesso** e fai clic su **Utenti**.

    2.  Dalla riga dell'utente a cui vuoi assegnare l'accesso, seleziona il menu **Azioni** e fai clic su **Assegna accesso**.

    3.  Seleziona **Assegna l'accesso alle risorse**.

    4.  Dall'elenco **Servizi**, seleziona **Servizio IBM Cloud Container**.

    5.  Dall'elenco **Regione**, seleziona **Tutte le regioni correnti** o una regione specifica, se ti viene richiesto.

    6. In **Seleziona i ruoli**, seleziona amministratore.

    7. Fai clic su **Assegna**.

4.  Gli utenti possono ora accedere all'endpoint dell'account dedicato per iniziare a creare i cluster.

    1.  Accedi all'endpoint per la tua istanza {{site.data.keyword.Bluemix_dedicated_notm}}. Immetti il tuo ID IBM quando richiesto.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `bx login -a api. <my-dedicated-cloud-instance>.<region>.bluemix.net --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza `--sso` e positivo con l'opzione `--sso`. 

    2.  Se stai accedendo per la prima volta, fornisci i tuoi ID utente e password dedicati quando richiesto. Questo autentica l'account dedicato e collega gli account pubblico e dedicato tra loro. Ogni volta che accedi dopo la prima volta, utilizza solo il tuo ID IBM per accedere. Per ulteriori informazioni, consulta [Connessione di un ID dedicato al tuo ID IBM pubblico](/docs/cli/connect_dedicated_id.html#connect_dedicated_id).

        **Nota**: devi accedere sia al tuo account dedicato che pubblico per creare i cluster. Se vuoi accedere solo al tuo account dedicato, utilizza l'indicatore `--no-iam` quando accedi all'endpoint dedicato.

    3.  Per creare o accedere ai cluster nell'ambiente dedicato, devi configurare la regione associata a tale ambiente.

        ```
        bx cs region-set
        ```
        {: pre}

5.  Se vuoi scollegare i tuoi account, puoi disconnettere il tuo ID IBM dal tuo ID utente dedicato. Per ulteriori informazioni, consulta [Disconnetti il tuo ID dedicato dall'ID IBM pubblico](/docs/cli/connect_dedicated_id.html#disconnect-your-dedicated-id-from-the-public-ibmid).

    ```
    bx iam dedicated-id-disconnect
    ```
    {: pre}

<br />


## Creazione dei cluster
{: #dedicated_administering}

Progetta la configurazione del tuo cluster {{site.data.keyword.Bluemix_dedicated_notm}} per la massima capacità e disponibilità.
{:shortdesc}

### Creazione dei cluster con la GUI
{: #dedicated_creating_ui}

1.  Apri la tua console dedicata: `https://<my-dedicated-cloud-instance>.bluemix.net`.
2. Seleziona la casella di spunta **Accedi anche a {{site.data.keyword.Bluemix_notm}} pubblico** e fai clic su **Accedi**.
3. Segui le istruzioni per accedere con il tuo ID IBM. Se questa è la prima volta che accedi al tuo account dedicato, segui le istruzioni per accedere a {{site.data.keyword.Bluemix_dedicated_notm}}.
4.  Dal catalogo, seleziona **Contenitori** e fai clic su **Cluster
Kubernetes**.
5.  Immetti un **Nome cluster**.
6.  Seleziona un **Tipo di macchina**. Il tipo di macchina definisce la quantità di memoria e di CPU virtuale configurate in ogni nodo di lavoro. Questa memoria e CPU virtuale è disponibile per tutti i contenitori che distribuisci nei tuoi nodi. 
    -   Il tipo di macchina micro indica l'opzione più piccola.
    -   Un tipo di macchina bilanciato ha una quantità uguale di memoria assegnata a ciascuna CPU, il che ottimizza le prestazioni.
7.  Scegli il **Numero di nodi di lavoro** di cui hai bisogno. Seleziona `3` per assicurare l'elevata disponibilità al tuo cluster.
8.  Fai clic su **Crea cluster**. Si aprono i dettagli del cluster, ma i nodi di lavoro nel cluster impiegano alcuni minuti per eseguire
il provisioning. Nella scheda **Nodi di lavoro**, puoi visualizzare l'andamento della distribuzione del nodo di lavoro. Quando i nodi di lavoro sono pronti, lo stato viene modificato in **Pronto**.

### Creazione dei cluster con la CLI
{: #dedicated_creating_cli}

1.  Installa la CLI {{site.data.keyword.Bluemix_notm}} e il plugin
[{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Accedi all'endpoint per la tua istanza {{site.data.keyword.Bluemix_dedicated_notm}}. Immetti le tue credenziali {{site.data.keyword.Bluemix_notm}} e seleziona il tuo account quando richiesto. 

    ```
    bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login -a api. <my-dedicated-cloud-instance>.<region>.bluemix.net --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza `--sso` e positivo con l'opzione `--sso`. 

3.  Per selezionare una regione, esegui `bx cs region-set`.

4.  Crea un cluster con il comando `cluster-create`. Quando crei un cluster standard, l'hardware del nodo di lavoro viene addebitato in base alle
ore di utilizzo.

    Esempio:

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>Il comando per creare un cluster nella tua organizzazione {{site.data.keyword.Bluemix_notm}}.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>Sostituisci &lt;location&gt; con l'ID ubicazione {{site.data.keyword.Bluemix_notm}} che il tuo ambiente dedicato è configurato a utilizzare.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Se stai creando un cluster standard, scegli un tipo di macchina. Il tipo di macchina specifica le risorse di calcolo virtuali che sono disponibili per ogni nodo
di lavoro. Controlla [Confronto tra i cluster standard e gratuito per {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) per ulteriori informazioni. Per i cluster gratuiti, non devi definire il tipo di macchina.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Sostituisci <em>&lt;name&gt;</em> con un nome per il tuo cluster.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>Il numero di nodi di lavoro da includere nel cluster. Se non viene specificata l'opzione <code>--workers</code>, viene creato un nodo di lavoro.</td>
    </tr>
    </tbody></table>

5.  Verifica che la creazione del cluster sia stata richiesta.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** servono fino a 15 minuti perché le macchine del nodo di lavoro siano ordinate e che il cluster
sia configurato e ne sia stato eseguito il provisioning al tuo account.

    Quando è stato terminato il provisioning del tuo cluster,
lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

6.  Controlla lo stato dei nodi di lavoro.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione
passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**,
puoi accedere al
cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

7.  Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.

    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
        ```
        {: screen}

    2.  Copia e incolla il comando visualizzato nel tuo terminale per impostare la variabile di ambiente `KUBECONFIG`.
    3.  Verifica che la variabile di ambiente `KUBECONFIG` sia impostata correttamente.

        Esempio per OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Output:

        ```
        /Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml

        ```
        {: screen}

8.  Accedi al dashboard Kubernetes con la porta predefinita 8001.
    1.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    2.  Apri il seguente URL in un browser web per visualizzare il dashboard Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

### Utilizzo dei registri di immagini pubblici e privati
{: #dedicated_images}

Per i nuovi spazi dei nomi, vedi le opzioni in [Utilizzo dei registri di immagini pubblici e privati con {{site.data.keyword.containershort_notm}}](cs_images.html). Per gli spazi dei nomi configurati per i gruppi di contenitori singoli e scalabili, [utilizza un token e crea un segreto
Kubernetes](cs_dedicated_tokens.html#cs_dedicated_tokens) per l'autenticazione.

### Aggiunta di sottoreti ai cluster
{: #dedicated_cluster_subnet}

Modifica il pool di indirizzi IP pubblici portatili disponibili aggiungendo le sottoreti al tuo cluster. Per ulteriori informazioni, consulta [Aggiunta di sottoreti ai cluster](cs_subnets.html#subnets). Controlla le seguenti differenze per aggiungere le sottoreti ai cluster dedicati.

#### Aggiunta di ulteriori sottoreti gestite dall'utente e degli indirizzi IP ai tuoi cluster Kubernetes 
{: #dedicated_byoip_subnets}

Fornisci un numero maggiore di tue sottoreti da una rete in loco che vuoi utilizzare per accedere a {{site.data.keyword.containershort_notm}}. Puoi aggiungere gli indirizzi IP privati da queste sottoreti ai servizi del programma di bilanciamento del carico e Ingress nel tuo cluster Kubernetes. Le sottoreti gestite dall'utente sono configurate in uno o due modi a seconda del formato della sottorete che vuoi utilizzare.

Requisiti:
- Le sottoreti gestite dall'utente possono essere aggiunte solo a VLAN private.
- Il limite di lunghezza del prefisso della sottorete è da /24 a /30. Ad esempio, `203.0.113.0/24` specifica 253 indirizzi IP privati utilizzabili, mentre `203.0.113.0/30` specifica 1 indirizzo IP privato utilizzabile.
- Il primo indirizzo IP nella sottorete deve essere utilizzato come gateway della sottorete.

Prima di iniziare: configura l'instradamento del traffico di rete in entrata e in uscita della tua rete aziendale alla rete {{site.data.keyword.Bluemix_dedicated_notm}} che utilizzerà la sottorete gestita dall'utente.

1. Per utilizzare la tua propria sottorete, [apri un ticket di supporto](/docs/get-support/howtogetsupport.html#getting-customer-support) e fornisci l'elenco dei CIDR della sottorete che vuoi utilizzare.
    **Nota**: il modo in cui ALB e i programmi di bilanciamento del carico vengono gestiti per un account interno e in loco si differenzia a seconda del formato del CIDR della sottorete. Consulta il passo finale per le differenze di configurazione.

2. Dopo che {{site.data.keyword.IBM_notm}} ha eseguito il provisioning delle sottoreti gestite dall'utente, rendi una sottorete disponibile al tuo cluster Kubernetes.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
    ```
    {: pre}
    Sostituisci <em>&lt;cluster_name&gt;</em> con il nome o l'ID del tuo cluster, <em>&lt;subnet_CIDR&gt;</em> con uno dei CIDR della sottorete che hai fornito nel ticket di supporto e <em>&lt;private_VLAN&gt;</em> con un ID della VLAN privata disponibile. Puoi trovare l'ID di una VLAN privata disponibile eseguendo `bx cs vlans`.

3. Verifica che le sottoreti siano state aggiunte al tuo cluster. Il campo **Gestito dall'utente** per le sottoreti fornite dall'utente è _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Per configurare la connettività dell'account interna e in loco, scegli tra queste opzioni:
  - Se hai utilizzato un intervallo di IP privato 10.x.x.x per la sottorete, utilizza gli IP validi da tale intervallo per configurare la connettività dell'account interna e in loco con Ingress e un programma di bilanciamento del carico. Per ulteriori informazioni, consulta [Configurazione dell'accesso a un'applicazione](cs_network_planning.html#planning).
  - Se non hai utilizzato un intervallo di IP privato 10.x.x.x per la sottorete, utilizza gli IP validi da tale intervallo per configurare la connettività in loco con Ingress e un programma di bilanciamento del carico. Per ulteriori informazioni, consulta [Configurazione dell'accesso a un'applicazione](cs_network_planning.html#planning). Tuttavia, devi utilizzare una sottorete privata portatile dell'infrastruttura IBM Cloud (SoftLayer) per configurare la connettività dell'account interna tra il tuo cluster e altri servizi basati su Cloud Foundry. Puoi creare una sottorete privata portatile con il comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add). Per questo scenario, il tuo cluster ha una sottorete gestita dall'utente per la connettività in loco e una sottorete privata portatile dell'infrastruttura IBM Cloud (SoftLayer) per la connettività dell'account interna.

### Configurazione degli altri cluster
{: #dedicated_other}

Rivedi le seguenti opzioni per le configurazioni degli altri cluster: 
  * [Gestione dell'accesso al cluster](cs_users.html#managing)
  * [Aggiornamento del master Kubernetes](cs_cluster_update.html#master)
  * [Aggiornamento dei nodi di lavoro](cs_cluster_update.html#worker_node)
  * [Configurazione della registrazione cluster](cs_health.html#logging)
  * [Configurazione del monitoraggio dei cluster](cs_health.html#monitoring)
      * **Nota**: esiste un cluster `ibm-monitoring` con ogni account {{site.data.keyword.Bluemix_dedicated_notm}}. Questo cluster monitora continuamente l'integrità di {{site.data.keyword.containerlong_notm}} nell'ambiente dedicato, verificando la stabilità e la connettività dell'ambiente. Non rimuovere questo cluster dall'ambiente.
  * [Visualizzazione delle risorse del cluster Kubernetes](cs_integrations.html#weavescope)
  * [Rimozione dei cluster](cs_clusters.html#remove)

<br />


## Distribuzione di applicazioni nei cluster
{: #dedicated_apps}

Puoi utilizzare le tecniche Kubernetes per distribuire le applicazioni nei cluster {{site.data.keyword.Bluemix_dedicated_notm}} e per assicurarti che siano sempre pronte e in esecuzione.
{:shortdesc}

Per distribuire le applicazioni nei cluster, puoi seguire le istruzioni per la [distribuzione delle applicazioni nei cluster {{site.data.keyword.Bluemix_notm}} pubblico](cs_app.html#app). Controlla le seguenti differenze per i cluster {{site.data.keyword.Bluemix_dedicated_notm}}.

### Consentire l'accesso pubblico alle applicazioni
{: #dedicated_apps_public}

Per gli ambienti {{site.data.keyword.Bluemix_dedicated_notm}}, gli indirizzi IP primari pubblici sono bloccati da un firewall. Per rendere la tua applicazione disponibile pubblicamente, utilizza un [Servizio LoadBalancer](#dedicated_apps_public_load_balancer) o [Ingress](#dedicated_apps_public_ingress) invece di un servizio NodePort. Se richiedi l'accesso a un servizio LoadBalancer o Ingress per tali indirizzi IP pubblici portatili, fornisci una whitelist di firewall aziendali a IBM al momento dell'onboarding del servizio.

#### Configurazione dell'accesso a un'applicazione utilizzando il tipo di servizio LoadBalancer
{: #dedicated_apps_public_load_balancer}

Se vuoi utilizzare gli indirizzi IP pubblici per il programma di bilanciamento del carico, assicurati che sia stata fornita una whitelist di firewall aziendali a IBM o [apri un ticket di supporto](/docs/get-support/howtogetsupport.html#getting-customer-support) per configurare la whitelist di firewall. Quindi segui la procedura in [Configurazione dell'accesso a un'applicazione utilizzando il tipo di servizio LoadBalancer](cs_loadbalancer.html#config).

#### Configurazione dell'accesso pubblico a un'applicazione utilizzando Ingress
{: #dedicated_apps_public_ingress}

Se vuoi utilizzare gli indirizzi IP pubblici per il programma di bilanciamento del carico dell'applicazione, assicurati che sia stata fornita una whitelist di firewall aziendali a IBM o [apri un ticket di supporto](/docs/get-support/howtogetsupport.html#getting-customer-support) per configurare la whitelist di firewall. Quindi segui la procedura in [Configurazione dell'accesso a un'applicazione utilizzando Ingress](cs_ingress.html#config).

### Creazione di archiviazione persistente
{: #dedicated_apps_volume_claim}

Per controllare le opzioni per la creazione dell'archiviazione persistente, consulta [Archivio di dati persistenti](cs_storage.html#planning). Per richiedere un backup per i volumi, un ripristino dai volumi e altre funzioni di archiviazione, devi [aprire un ticket di supporto](/docs/get-support/howtogetsupport.html#getting-customer-support).
