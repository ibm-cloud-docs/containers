---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"


---

{:new_window: target="blank"}
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


# Assegnazione dell'accesso al cluster
{: #users}

Come amministratore del cluster, puoi definire le politiche di accesso per il tuo cluster {{site.data.keyword.containerlong}} per creare diversi livelli di accesso per i vari utenti. Ad esempio, puoi autorizzare determinati utenti a lavorare con le risorse dell'infrastruttura cluster e altri a distribuire solo i contenitori.
{: shortdesc}

## Descrizione delle politiche e dei ruoli di accesso
{: #access_policies}

Le politiche di accesso determinano il livello di accesso che gli utenti del tuo account {{site.data.keyword.Bluemix_notm}} devono avere alle risorse sulla piattaforma {{site.data.keyword.Bluemix_notm}}. Una politica assegna a un utente uno o più ruoli che definiscono l'ambito di accesso a un singolo servizio o a un insieme di servizi e risorse organizzati insieme in un gruppo di risorse. Ogni servizio in {{site.data.keyword.Bluemix_notm}} potrebbe richiedere la propria serie di politiche di accesso.
{: shortdesc}

Man mano che sviluppi il piano per gestire l'accesso degli utenti, considera i seguenti passi generali:
1.  [Scegli la politica e il ruolo di accesso appropriati per i tuoi utenti](#access_roles)
2.  [Assegna ruoli di accesso a singoli o gruppi di utenti in {{site.data.keyword.Bluemix_notm}} IAM](#iam_individuals_groups)
3.  [Estendi l'accesso utente alle istanze del cluster o ai gruppi di risorse](#resource_groups)

Dopo aver compreso come poter gestire ruoli, utenti e risorse nel tuo account, consulta [Configurazione dell'accesso al tuo cluster](#access-checklist) per un elenco di controllo su come configurare l'accesso.

### Scegli la politica e il ruolo di accesso appropriati per i tuoi utenti
{: #access_roles}

Devi definire le politiche di accesso per ogni utente che lavora con {{site.data.keyword.containerlong_notm}}. L'ambito di una politica di accesso si basa sul ruolo o sui ruoli definiti dell'utente, che determinano le azioni che l'utente può eseguire. Alcune politiche sono predefinite ma altre possono essere personalizzate. Si applica la stessa politica se l'utente esegue la richiesta dalla console {{site.data.keyword.containerlong_notm}} o tramite la CLI, anche quando le azioni vengono completate nell'infrastruttura IBM Cloud (SoftLayer).
{: shortdesc}

Ulteriori informazioni sui diversi tipi di autorizzazioni e ruoli, su quale ruolo può eseguire ogni azione e su come i ruoli si correlano tra loro

Per visualizzare le autorizzazioni {{site.data.keyword.containerlong_notm}} specifiche per ogni ruolo, controlla l'argomento di riferimento [Autorizzazioni di accesso utente](cs_access_reference.html).
{: tip}

<dl>

<dt><a href="#platform">Piattaforma IAM</a></dt>
<dd>{{site.data.keyword.containerlong_notm}} utilizza i ruoli di {{site.data.keyword.Bluemix_notm}} IAM (Identity and Access Management) per concedere agli utenti l'accesso al cluster. I ruoli della piattaforma IAM determinano le azioni che gli utenti possono eseguire su un cluster. Puoi impostare le politiche per questi ruoli in base alla regione. A ogni utente a cui viene assegnato un ruolo della piattaforma IAM viene assegnato automaticamente anche un ruolo RBAC corrispondente nello spazio dei nomi Kubernetes `predefinito`. Inoltre, i ruoli della piattaforma IAM ti autorizzano a eseguire azioni dell'infrastruttura sul cluster, ma non concedono l'accesso alle risorse dell'infrastruttura IBM Cloud (SoftLayer). L'accesso alle risorse dell'infrastruttura IBM Cloud (SoftLayer) è determinato dalla [chiave API impostata per la regione](#api_key).</br></br>
Le azioni di esempio consentite dai ruoli della piattaforma IAM sono la creazione o la rimozione di cluster, il bind di servizi a un cluster o l'aggiunta di nodi di lavoro supplementari.</dd>
<dt><a href="#role-binding">RBAC</a></dt>
<dd>In Kubernetes, l'RBAC (role-based access control) è un modo per proteggere le risorse all'interno del tuo cluster. I ruoli RBAC determinano le azioni Kubernetes che gli utenti possono eseguire su quelle risorse. A ogni utente a cui viene assegnato un ruolo della piattaforma IAM viene assegnato automaticamente un ruolo cluster RBAC corrispondente nello spazio dei nomi Kubernetes `predefinito`. Questo ruolo cluster RBAC viene applicato nello spazio dei nomi predefinito o in tutti gli spazi dei nomi, a seconda del ruolo della piattaforma IAM che scegli.</br></br>
Le azioni di esempio consentite dai ruoli RBAC sono la creazione di oggetti come i pod o la lettura dei log dei pod.</dd>
<dt><a href="#api_key">Infrastruttura</a></dt>
<dd>I ruoli dell'infrastruttura consentono l'accesso alle tue risorse dell'infrastruttura IBM Cloud (SoftLayer). Configura un utente con il ruolo dell'infrastruttura **Super utente** e memorizza le credenziali dell'infrastruttura di questo utente in una chiave API. Quindi, imposta la chiave API in ogni regione in cui vuoi creare i cluster. Dopo aver impostato la chiave API, gli altri utenti a cui concedi l'accesso a {{site.data.keyword.containerlong_notm}} non necessitano di ruoli dell'infrastruttura poiché la chiave API viene condivisa per tutti gli utenti all'interno della regione. Invece, i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM determinano le azioni dell'infrastruttura che gli utenti possono eseguire. Se non configuri la chiave API con il ruolo dell'infrastruttura completo <strong>Super utente</strong> o se devi concedere agli utenti l'accesso specifico al dispositivo, puoi [personalizzare le autorizzazioni di infrastruttura](#infra_access). </br></br>
Le azioni di esempio consentite dai ruoli dell'infrastruttura sono la visualizzazione dei dettagli delle macchine del nodo di lavoro del cluster o la modifica delle risorse di rete e archiviazione.</dd>
<dt>Cloud Foundry</dt>
<dd>Non tutti i servizi possono essere gestiti con {{site.data.keyword.Bluemix_notm}} IAM. Se utilizzi uno di questi servizi, puoi continuare a usare i ruoli utente Cloud Foundry per controllare l'accesso a tali servizi. I ruoli di Cloud Foundry concedono l'accesso a organizzazioni e spazi all'interno dell'account. Per visualizzare l'elenco dei servizi basati su Cloud Foundry in {{site.data.keyword.Bluemix_notm}}, esegui <code>ibmcloud service list</code>.</br></br>
Le azioni di esempio consentite dai ruoli Cloud Foundry sono la creazione di una nuova istanza del servizio Cloud Foundry o il bind di un'istanza del servizio Cloud Foundry a un cluster. Per ulteriori informazioni, vedi i [ruoli disponibili per l'organizzazione e lo spazio](/docs/iam/cfaccess.html) o la procedura per la [gestione dell'accesso a Cloud Foundry](/docs/iam/mngcf.html) nella documentazione di {{site.data.keyword.Bluemix_notm}} IAM.</dd>
</dl>

### Assegna ruoli di accesso a singoli o gruppi di utenti in {{site.data.keyword.Bluemix_notm}} IAM
{: #iam_individuals_groups}

Quando imposti le politiche {{site.data.keyword.Bluemix_notm}} IAM, puoi assegnare ruoli a un singolo utente o a un gruppo di utenti.
{: shortdesc}

<dl>
<dt>Singoli utenti</dt>
<dd>Potresti avere un utente specifico che ha bisogno di più o meno autorizzazioni rispetto al resto del tuo team. Puoi personalizzare le autorizzazioni su base individuale in modo che ogni persona disponga delle autorizzazioni necessarie per completare le proprie attività. Puoi assegnare più di un ruolo {{site.data.keyword.Bluemix_notm}} IAM a ogni utente.</dd>
<dt>Più utenti in un gruppo di accesso</dt>
<dd>Puoi creare un gruppo di utenti e quindi assegnare le autorizzazioni a tale gruppo. Ad esempio, puoi raggruppare tutti i team leader e assegnare al gruppo l'accesso come amministratore. Quindi, puoi raggruppare tutti gli sviluppatori e assegnare a quel gruppo solo l'accesso in scrittura. Puoi assegnare più di un ruolo {{site.data.keyword.Bluemix_notm}} IAM a ogni gruppo di accesso. Quando assegni le autorizzazioni a un gruppo, viene interessato qualsiasi utente aggiunto o rimosso da quel gruppo. Se aggiungi un utente al gruppo, anch'egli ha l'accesso aggiuntivo. Se viene rimosso, il suo accesso viene revocato.</dd>
</dl>

I ruoli {{site.data.keyword.Bluemix_notm}} IAM non possono essere assegnati a un account di servizio. Puoi invece [assegnare i ruoli RBAC agli account di servizio](#rbac).
{: tip}

Devi inoltre specificare se gli utenti hanno accesso a un cluster in un gruppo di risorse, a tutti i cluster in un gruppo di risorse o a tutti i cluster in tutti i gruppi di risorse nel tuo account.

### Applica l'accesso utente alle istanze del cluster o ai gruppi di risorse
{: #resource_groups}

In {{site.data.keyword.Bluemix_notm}} IAM, puoi assegnare ruoli di accesso utente alle istanze della risorsa o ai gruppi di risorse.
{: shortdesc}

Quando crei il tuo account {{site.data.keyword.Bluemix_notm}}, il gruppo di risorse predefinito viene creato automaticamente. Se non specifichi un gruppo di risorse quando crei la risorsa, le istanze della risorsa (i cluster) appartengono al gruppo di risorse predefinito. Se vuoi aggiungere un gruppo di risorse nel tuo account, vedi [Procedure consigliate per la configurazione del tuo account ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](/docs/tutorials/users-teams-applications.html) e [Configurazione dei tuoi gruppi di risorse](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups).

<dl>
<dt>Istanza della risorsa</dt>
  <dd><p>Ogni servizio {{site.data.keyword.Bluemix_notm}} nel tuo account è una risorsa che ha delle istanze. L'istanza differisce in base al servizio. Ad esempio, in {{site.data.keyword.containerlong_notm}}, l'istanza è un cluster, ma in {{site.data.keyword.cloudcerts_long_notm}}, l'istanza è un certificato. Per impostazione predefinita, le risorse appartengono anche al gruppo di risorse predefinito nel tuo account. Puoi assegnare agli utenti un ruolo di accesso a un'istanza della risorsa per i seguenti scenari.
  <ul><li>Tutti i servizi {{site.data.keyword.Bluemix_notm}} IAM nel tuo account, inclusi tutti i cluster in {{site.data.keyword.containerlong_notm}} e le immagini in {{site.data.keyword.registrylong_notm}}.</li>
  <li>Tutte le istanze all'interno di un servizio, ad esempio tutti i cluster in {{site.data.keyword.containerlong_notm}}.</li>
  <li>Tutte le istanze all'interno di una regione di un servizio, ad esempio tutti i cluster presenti nella regione **Stati Uniti Sud** di {{site.data.keyword.containerlong_notm}}.</li>
  <li>A una singola istanza, come ad esempio un cluster.</li></ul></dd>
<dt>Gruppo di risorse</dt>
  <dd><p>Puoi organizzare le risorse del tuo account in raggruppamenti personalizzabili in modo da poter assegnare rapidamente a singoli o a gruppi di utenti l'accesso a più di una risorsa alla volta. I gruppi di risorse possono aiutare gli operatori e gli amministratori a filtrare le risorse per visualizzarne l'utilizzo corrente, risolvere i problemi e gestire i team.</p>
  <p class="important">Un cluster può essere integrato solo con altri servizi {{site.data.keyword.Bluemix_notm}} che si trovano nello stesso gruppo di risorse o con i servizi che non supportano i gruppi di risorse, come {{site.data.keyword.registrylong_notm}}. Un cluster può essere creato in un solo gruppo di risorse che non puoi modificare in seguito. Se crei un cluster nel gruppo di risorse sbagliato, devi eliminare il cluster e ricrearlo nel gruppo di risorse corretto.</p>
  <p>Se intendi utilizzare [{{site.data.keyword.monitoringlong_notm}} per le metriche](cs_health.html#view_metrics), considera la possibilità di assegnare ai cluster nomi univoci tra i gruppi di risorse e le regioni nel tuo account per evitare conflitti di denominazione delle metriche. Non puoi ridenominare un cluster.</p>
  <p>Puoi assegnare agli utenti un ruolo di accesso a un gruppo di risorse per i seguenti scenari. Tieni presente che, a differenza delle istanze della risorsa, non puoi concedere l'accesso a una singola istanza all'interno di un gruppo di risorse.</p>
  <ul><li>Tutti i servizi {{site.data.keyword.Bluemix_notm}} IAM nel gruppo di risorse, inclusi tutti i cluster in {{site.data.keyword.containerlong_notm}} e le immagini in {{site.data.keyword.registrylong_notm}}.</li>
  <li>Tutte le istanze all'interno di un servizio nel gruppo di risorse, ad esempio tutti i cluster in {{site.data.keyword.containerlong_notm}}.</li>
  <li>Tutte le istanze all'interno di una regione di un servizio nel gruppo di risorse, ad esempio tutti i cluster presenti nella regione **Stati Uniti Sud** di {{site.data.keyword.containerlong_notm}}.</li></ul></dd>
</dl>

<br />


## Configurazione dell'accesso al tuo cluster
{: #access-checklist}

Dopo aver [compreso come poter gestire ruoli, utenti e risorse nel tuo account](#access_policies), utilizza il seguente elenco di controllo per configurare l'accesso utente nel tuo cluster.
{: shortdesc}

1. [Imposta la chiave API](#api_key) per tutte le regioni e tutti i gruppi di risorse in cui vuoi creare i cluster.
2. Invita gli utenti al tuo account e [assegna loro i ruoli {{site.data.keyword.Bluemix_notm}} IAM](#platform) per {{site.data.keyword.containerlong_notm}}. 
3. Per consentire agli utenti di eseguire il bind dei servizi al cluster o di visualizzare i log inoltrati dalle configurazioni di registrazione del cluster, [concedi agli utenti i ruoli Cloud Foundry](/docs/iam/mngcf.html) per l'organizzazione e lo spazio in cui vengono distribuiti i servizi o in cui vengono raccolti i log.
4. Se utilizzi gli spazi dei nomi Kubernetes per isolare le risorse all'interno del cluster, [copia i bind del ruolo RBAC Kubernetes per i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Visualizzatore** ed **Editor** in altri spazi dei nomi](#role-binding).
5. Per tutti gli strumenti di automazione, come quelli nella tua pipeline CI/CD, configura gli account di servizio e [assegna le autorizzazioni RBAC Kubernetes agli account di servizio](#rbac).
6. Per altre configurazioni avanzate per controllare l'accesso alle tue risorse del cluster a livello di pod, vedi [Configurazione della sicurezza del pod](/docs/containers/cs_psp.html).

</br>

Per ulteriori informazioni sulla configurazione del tuo account e delle risorse, prova questa esercitazione sulle [procedure consigliate per organizzare utenti, team e applicazioni](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Configurazione della chiave API per consentire l'accesso al portfolio dell'infrastruttura
{: #api_key}

Per eseguire il provisioning e lavorare correttamente con i cluster, devi assicurarti che il tuo account {{site.data.keyword.Bluemix_notm}} sia configurato in modo appropriato per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer).
{: shortdesc}

**Nella maggior parte dei casi**: il tuo account Pagamento a consumo {{site.data.keyword.Bluemix_notm}} ha già accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Per configurare {{site.data.keyword.containerlong_notm}} per l'accesso al portfolio, il **proprietario dell'account** deve impostare la chiave API per la regione e il gruppo di risorse.

1. Accedi al terminale come proprietario dell'account.
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. Specifica il gruppo di risorse in cui vuoi impostare la chiave API. Se non specifichi un gruppo di risorse, la chiave API viene impostata per il gruppo di risorse predefinito.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. Se ti trovi in una regione diversa, passa alla regione in cui vuoi impostare la chiave API.
    ```
    ibmcloud ks region-set
    ```
    {: pre}

4. Imposta la chiave API per la regione e il gruppo di risorse.
    ```
    ibmcloud ks api-key-reset
    ```
    {: pre}    

5. Verifica che la chiave API sia impostata.
    ```
    ibmcloud ks api-key-info <cluster_name_or_ID>
    ```
    {: pre}

6. Ripeti per ogni regione e gruppo di risorse in cui vuoi creare i cluster.

**Opzioni alternative e ulteriori informazioni**: per i diversi modi per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer), controlla le seguenti sezioni.
* Se non sei sicuro che il tuo account abbia già accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer), vedi [Informazioni sull'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](#understand_infra).
* Se il proprietario dell'account non imposta la chiave API, [assicurati che l'utente che imposta la chiave API disponga delle autorizzazioni corrette](#owner_permissions).
* Per ulteriori informazioni sull'utilizzo del tuo account predefinito per impostare la chiave API, vedi [Accesso al portfolio dell'infrastruttura con il tuo account Pagamento a consumo {{site.data.keyword.Bluemix_notm}} predefinito](#default_account).
* Se non hai un account Pagamento a consumo predefinito o devi utilizzare un diverso account dell'infrastruttura IBM Cloud (SoftLayer), vedi [Accesso a un diverso account dell'infrastruttura IBM Cloud (SoftLayer)](#credentials).

### Informazioni sull'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)
{: #understand_infra}

Determina se il tuo account ha accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer) e scopri come {{site.data.keyword.containerlong_notm}} utilizza la chiave API per accedere al portfolio.
{: shortdesc}

**Il mio account ha già accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)?**</br>

Per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer), utilizzi un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}. Se hai un diverso tipo di account, visualizza le opzioni nella seguente tabella.

<table summary="La tabella mostra le opzioni di creazione del cluster standard per tipo di account. Le righe devono essere lette da sinistra a destra, con la descrizione dell'account nella colonna uno e le opzioni per creare un cluster standard nella colonna due.">
<caption>Opzioni di creazione del cluster standard per tipo di account</caption>
  <thead>
  <th>Descrizione dell'account</th>
  <th>Opzioni per creare un cluster standard</th>
  </thead>
  <tbody>
    <tr>
      <td>Gli **account Lite** non possono eseguire il provisioning dei cluster.</td>
      <td>[Aggiorna il tuo account Lite a un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}](/docs/account/index.html#paygo).</td>
    </tr>
    <tr>
      <td>Gli account **Pagamento a consumo** vengono forniti con l'accesso al portfolio dell'infrastruttura.</td>
      <td>Puoi creare dei cluster standard. Utilizza una chiave API per configurare le autorizzazioni di infrastruttura per i tuoi cluster.</td>
    </tr>
    <tr>
      <td>**Gli account Sottoscrizione** non sono configurati con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer).</td>
      <td><p><strong>Opzione 1: </strong> [Crea un nuovo account Pagamento a consumo](/docs/account/index.html#paygo) che è configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Se scegli questa opzione, hai due account e fatture {{site.data.keyword.Bluemix_notm}} separati.</p><p>Se vuoi continuare a utilizzare il tuo account Sottoscrizione, puoi utilizzare il nuovo account Pagamento a consumo per generare una chiave API nell'infrastruttura IBM Cloud (SoftLayer). Devi quindi impostare manualmente la chiave API dell'infrastruttura IBM Cloud (SoftLayer) per il tuo account Sottoscrizione. Ricorda che le risorse dell'infrastruttura IBM Cloud (SoftLayer) vengono fatturate attraverso il tuo nuovo account Pagamento a consumo.</p><p><strong>Opzione 2:</strong> se hai già un account dell'infrastruttura IBM Cloud (SoftLayer) esistente che vuoi utilizzare, puoi impostare manualmente le credenziali dell'infrastruttura IBM Cloud (SoftLayer) per il tuo account {{site.data.keyword.Bluemix_notm}}.</p><p class="note">Quando colleghi manualmente un account dell'infrastruttura IBM Cloud (SoftLayer), le credenziali vengono utilizzate per ogni azione specifica dell'infrastruttura IBM Cloud (SoftLayer) nel tuo account {{site.data.keyword.Bluemix_notm}}. Devi assicurarti che la chiave API che hai inviato abbia [autorizzazioni dell'infrastruttura sufficienti](cs_users.html#infra_access) in modo che gli utenti possano creare e utilizzare i cluster.</p></td>
    </tr>
    <tr>
      <td>**Account dell'infrastruttura IBM Cloud (SoftLayer)**, nessun account {{site.data.keyword.Bluemix_notm}}</td>
      <td><p>[Crea un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}](/docs/account/index.html#paygo). Hai la fatturazione e due account dell'infrastruttura IBM Cloud (SoftLayer) separati.</p><p>Per impostazione predefinita, il tuo nuovo account {{site.data.keyword.Bluemix_notm}} utilizza il nuovo account dell'infrastruttura. Per continuare a utilizzare il vecchio account dell'infrastruttura, imposta manualmente le credenziali.</p></td>
    </tr>
  </tbody>
  </table>

**Ora che il mio portfolio dell'infrastrutture è configurato, in che modo {{site.data.keyword.containerlong_notm}} accede al portfolio?**</br>

{{site.data.keyword.containerlong_notm}} accede al portfolio dell'infrastruttura IBM Cloud (SoftLayer) utilizzando una chiave API. La chiave API memorizza le credenziali di un utente con accesso a un account dell'infrastruttura IBM Cloud (SoftLayer). Le chiavi API sono impostate per regione all'interno di un gruppo di risorse e sono condivise dagli utenti in quella regione.
 
Per consentire a tutti gli utenti di accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer), l'utente di cui sono state memorizzate le credenziali nella chiave API deve avere [il ruolo dell'infrastruttura **Super utente** e il ruolo della piattaforma **Amministratore** per {{site.data.keyword.containerlong_notm}} e per {{site.data.keyword.registryshort_notm}}](#owner_permissions) nel tuo account {{site.data.keyword.Bluemix_notm}}. Quindi, lascia che quell'utente esegua la prima azione di amministrazione in una regione e in un gruppo di risorse. Le credenziali dell'infrastruttura dell'utente vengono memorizzate in una chiave API per tale regione e gruppo di risorse.

Altri utenti all'interno dell'account condividono la chiave API per accedere all'infrastruttura. Quando gli utenti accedono all'account {{site.data.keyword.Bluemix_notm}}, un token {{site.data.keyword.Bluemix_notm}} IAM basato sulla chiave API viene generato per la sessione della CLI e consente di eseguire i comandi relativi all'infrastruttura in un cluster.

Per visualizzare il token {{site.data.keyword.Bluemix_notm}} IAM per una sessione della CLI, puoi eseguire `ibmcloud iam oauth-tokens`. I token {{site.data.keyword.Bluemix_notm}} IAM possono essere utilizzati anche per [effettuare chiamate direttamente all'API {{site.data.keyword.containerlong_notm}}](cs_cli_install.html#cs_api).
{: tip}

**Se gli utenti hanno accesso al portfolio tramite un token {{site.data.keyword.Bluemix_notm}} IAM, come limito i comandi che un utente può eseguire?**

Dopo aver configurato l'accesso al portfolio per gli utenti nel tuo account, puoi controllare quali azioni dell'infrastruttura possono essere eseguite dagli utenti assegnando il [ruolo della piattaforma](#platform) appropriato. Assegnando i ruoli {{site.data.keyword.Bluemix_notm}} IAM agli utenti, limiti i comandi che essi possono eseguire in un cluster. Ad esempio, poiché il proprietario della chiave API ha il ruolo dell'infrastruttura **Super utente**, tutti i comandi relativi all'infrastruttura possono essere eseguiti in un cluster. Tuttavia, a seconda del ruolo {{site.data.keyword.Bluemix_notm}} IAM assegnato a un utente, l'utente può eseguire solo alcuni di questi comandi relativi all'infrastruttura.

Ad esempio, se vuoi creare un cluster in una nuova regione, assicurati che il primo cluster sia stato creato da un utente con il ruolo dell'infrastruttura **Super utente**, ad esempio il proprietario dell'account. Successivamente, puoi invitare singoli utenti o utenti nei gruppi di accesso {{site.data.keyword.Bluemix_notm}} IAM a quella regione impostando per loro le politiche di gestione della piattaforma in tale regione. Un utente con il ruolo della piattaforma **Visualizzatore** non è autorizzato ad aggiungere un nodo di lavoro. Pertanto, l'azione `worker-add` non riesce, anche se la chiave API ha le autorizzazioni dell'infrastruttura corrette. Se modifichi il ruolo della piattaforma dell'utente in **Operatore**, l'utente sarà autorizzato ad aggiungere un nodo di lavoro. L'azione `worker-add` riesce perché l'utente è autorizzato e la chiave API è impostata correttamente. Non dovrai modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) dell'utente.

Per controllare le azioni eseguite dagli utenti nel tuo account, puoi utilizzare [{{site.data.keyword.cloudaccesstrailshort}}](cs_at_events.html) per visualizzare tutti gli eventi correlati al cluster.
{: tip}

**Cosa succede se non voglio assegnare al proprietario della chiave API o al proprietario delle credenziali il ruolo dell'infrastruttura Super utente?**</br>

Per motivi di conformità, sicurezza o fatturazione, potresti non voler assegnare il ruolo dell'infrastruttura **Super utente** all'utente che imposta la chiave API o di cui vengono impostate le credenziali con il comando `ibmcloud ks credential-set`. Tuttavia, se questo utente non ha il ruolo **Super utente**, le azioni correlate all'infrastruttura, come la creazione di un cluster o il ricaricamento di un nodo di lavoro, possono avere esito negativo. Invece di utilizzare i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM per controllare l'accesso all'infrastruttura degli utenti, devi [impostare specifiche autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer)](#infra_access) per gli utenti.

**Cosa succede se l'utente che imposta la chiave API per una regione e un gruppo di risorse lascia l'azienda?**

Se l'utente lascia la tua organizzazione, il proprietario dell'account {{site.data.keyword.Bluemix_notm}} può rimuovere le autorizzazioni di quell'utente. Tuttavia, prima di rimuovere le autorizzazioni di accesso specifiche di un utente o di rimuovere completamente un utente dal tuo account, devi reimpostare la chiave API con le credenziali di infrastruttura di un altro utente. In caso contrario, gli altri utenti nell'account potrebbero perdere l'accesso al portale dell'infrastruttura IBM Cloud (SoftLayer) e i comandi relativi all'infrastruttura potrebbero non riuscire. Per ulteriori informazioni, vedi [Rimozione delle autorizzazioni utente](#removing).

**Come posso bloccare il mio cluster se la mia chiave API viene compromessa?**

Se una chiave API impostata per una regione e per un gruppo di risorse nel tuo cluster viene compromessa, [eliminala](../iam/userid_keys.html#deleting-an-api-key) in modo che non possano essere effettuate ulteriori chiamate utilizzando la chiave API come autenticazione. Per ulteriori informazioni sulla protezione dell'accesso al server API Kubernetes, vedi l'argomento sulla sicurezza del [Server API Kubernetes ed etcd](cs_secure.html#apiserver).

**Come posso configurare la chiave API per il mio cluster?**</br>

Dipende dal tipo di account che stai utilizzando per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer):
* [Un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}} predefinito](#default_account)
* [Un altro account dell'infrastruttura IBM Cloud (SoftLayer) che non è collegato al tuo account Pagamento a consumo {{site.data.keyword.Bluemix_notm}} predefinito](#credentials)

### Garanzia che il proprietario della chiave API o delle credenziali dell'infrastruttura disponga delle autorizzazioni corrette
{: #owner_permissions}

Per garantire che tutte le azioni correlate all'infrastruttura possano essere completate correttamente nel cluster, l'utente di cui vuoi impostare le credenziali per la chiave API deve disporre delle autorizzazioni appropriate.
{: shortdesc}

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/).

2. Per garantire che tutte le azioni correlate all'account possano essere eseguite correttamente, verifica che l'utente disponga dei ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM corretti.
    1. Passa a **Gestisci > Account > Utenti**.
    2. Fai clic sul nome dell'utente che vuoi che imposti la chiave API o di cui vuoi impostare le credenziali per la chiave API.
    3. Se l'utente non ha il ruolo della piattaforma **Amministratore** per tutti i cluster {{site.data.keyword.containerlong_notm}} in tutte le regioni, [assegna all'utente questo ruolo della piattaforma](#platform).
    4. Se l'utente non ha almeno il ruolo della piattaforma **Visualizzatore** per il gruppo di risorse in cui vuoi impostare la chiave API, [assegna all'utente questo ruolo del gruppo di risorse](#platform).
    5. Per creare i cluster, l'utente ha anche bisogno del ruolo della piattaforma **Amministratore** per {{site.data.keyword.registrylong_notm}} a livello di account. Non limitare le politiche per {{site.data.keyword.registryshort_notm}} al livello del gruppo di risorse.

3. Per garantire che tutte le azioni correlate all'infrastruttura nel tuo cluster possano essere eseguite correttamente, verifica che l'utente disponga delle corrette politiche di accesso all'infrastruttura.
    1. Dal menu ![Icona Menu](../icons/icon_hamburger.svg "Icona Menu"), seleziona **Infrastruttura**.
    2. Dalla barra dei menu, seleziona **Account** > **Utenti** > **Elenco utenti**.
    3. Nella colonna **Chiave API**, verifica che l'utente abbia una chiave API oppure fai clic su **Genera**.
    4. Seleziona il nome del profilo utente e controlla le autorizzazioni dell'utente.
    5. Se l'utente non ha il ruolo **Super utente**, fai clic sulla scheda **Autorizzazioni portale**.
        1. Utilizza l'elenco a discesa **Autorizzazioni rapide** per assegnare il ruolo **Super utente**.
        2. Fai clic su **Imposta autorizzazioni**.

### Accesso al portfolio dell'infrastruttura con il tuo account Pagamento a consumo {{site.data.keyword.Bluemix_notm}} predefinito
{: #default_account}

Se hai un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}, per impostazione predefinita hai accesso a un portfolio dell'infrastruttura IBM Cloud (SoftLayer) collegato. La chiave API viene utilizzata per ordinare le risorse di infrastruttura da questo portfolio dell'infrastruttura IBM Cloud (SoftLayer), come nuovi nodi di lavoro o nuove VLAN.
{: shortdec}

Puoi trovare il proprietario della chiave API attuale eseguendo [`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info). Se ritieni di dover aggiornare la chiave API memorizzata per una regione, puoi farlo eseguendo il comando [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset). Questo comando richiede la politica di accesso come amministratore {{site.data.keyword.containerlong_notm}} e memorizza la chiave API dell'utente che esegue questo comando nell'account.

Assicurati di voler reimpostare la chiave e di comprenderne l'impatto sulla tua applicazione. La chiave viene utilizzata in diversi punti e può causare modifiche improvvise se viene modificata senza che sia necessario.
{: note}

**Prima di iniziare**:
- Se il proprietario dell'account non imposta la chiave API, [assicurati che l'utente che imposta la chiave API disponga delle autorizzazioni corrette](#owner_permissions).
- [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

Per impostare la chiave API per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer):

1.  Imposta la chiave API per la regione e il gruppo di risorse in cui si trova il cluster.
    1.  Accedi al terminale con l'utente di cui vuoi utilizzare le autorizzazioni di infrastruttura.
    2.  Specifica il gruppo di risorse in cui vuoi impostare la chiave API. Se non specifichi un gruppo di risorse, la chiave API viene impostata per il gruppo di risorse predefinito.
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  Se ti trovi in una regione diversa, passa alla regione in cui vuoi impostare la chiave API.
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  Imposta la chiave API dell'utente per la regione.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  Verifica che la chiave API sia impostata.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

2. [Crea un
cluster](cs_clusters.html). Per creare il cluster, vengono utilizzate le credenziali della chiave API impostate per la regione e il gruppo di risorse.

### Accesso a un diverso account dell'infrastruttura IBM Cloud (SoftLayer)
{: #credentials}

Invece di utilizzare l'account dell'infrastruttura IBM Cloud (SoftLayer) collegato predefinito per ordinare l'infrastruttura per i cluster all'interno di una regione, potresti voler utilizzare un altro account dell'infrastruttura IBM Cloud (SoftLayer) di cui già disponi. Puoi collegare questo account dell'infrastruttura al tuo account {{site.data.keyword.Bluemix_notm}} utilizzando il comando [`ibmcloud ks credential-set`](cs_cli_reference.html#cs_credentials_set). Vengono utilizzate le credenziali dell'infrastruttura IBM Cloud (SoftLayer) al posto delle credenziali dell'account Pagamento a consumo predefinito memorizzate per la regione.
{: shortdesc}

Le credenziali dell'infrastruttura IBM Cloud (SoftLayer) impostate dal comando `ibmcloud ks credential-set` vengono conservate al termine della sessione. Se rimuovi le credenziali dell'infrastruttura IBM Cloud (SoftLayer) che erano state impostate manualmente con il comando [`ibmcloud ks credential-unset`](cs_cli_reference.html#cs_credentials_unset), vengono utilizzate le credenziali dell'account Pagamento a consumo predefinite. Tuttavia, questa modifica delle credenziali dell'account dell'infrastruttura potrebbe causare [cluster orfani](cs_troubleshoot_clusters.html#orphaned).
{: important}

**Prima di iniziare**:
- Se non utilizzi le credenziali del proprietario dell'account, [assicurati che l'utente di cui vuoi impostare le credenziali per la chiave API disponga delle autorizzazioni corrette](#owner_permissions).
- [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

Per impostare le credenziali dell'account dell'infrastruttura per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer):

1. Ottieni l'account dell'infrastruttura che vuoi utilizzare per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Hai diverse opzioni che dipendono dal tuo [tipo di account corrente](#understand_infra).

2.  Imposta le credenziali dell'API dell'infrastruttura con l'utente per l'account corretto.

    1.  Ottieni le credenziali dell'API dell'infrastruttura dell'utente. Nota che le credenziali sono diverse dall'ID IBM.

        1.  Dalla tabella di [console {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/) **Infrastruttura** > **Account** > **Utenti** > **Elenco utenti**, fai clic su **ID IBM o Nome utente**.

        2.  Nella sezione **Informazioni di accesso API**, visualizza il **Nome utente API** e la **Chiave di autenticazione**.    

    2.  Imposta le credenziali API dell'infrastruttura da utilizzare.
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

    3. Verifica che siano impostate le credenziali corrette.
        ```
        ibmcloud ks credential-get
        ```
        Output di esempio:
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [Crea un
cluster](cs_clusters.html). Per creare il cluster, vengono utilizzate le credenziali dell'infrastruttura impostate per la regione e il gruppo di risorse.

4. Verifica che il tuo cluster utilizzi le credenziali dell'account dell'infrastruttura che hai impostato.
  1. Apri la [console {{site.data.keyword.containerlong_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/containers-kubernetes/clusters) e seleziona il tuo cluster. 
  2. Nella scheda Panoramica, cerca il campo **Utente infrastruttura**. 
  3. Se vedi tale campo, non utilizzare le credenziali dell'infrastruttura predefinite fornite con il tuo account Pagamento a consumo in questa regione. La regione è impostata invece per utilizzare le diverse credenziali dell'account dell'infrastruttura che hai impostato.

<br />


## Concessione dell'accesso utente al tuo cluster tramite {{site.data.keyword.Bluemix_notm}} IAM
{: #platform}

Imposta le politiche di gestione della piattaforma {{site.data.keyword.Bluemix_notm}} IAM nella [console {{site.data.keyword.Bluemix_notm}}](#add_users) o nella [CLI](#add_users_cli) in modo che gli utenti possano lavorare con i cluster in {{site.data.keyword.containerlong_notm}}. Prima di iniziare, consulta [Descrizione delle politiche e dei ruoli di accesso](#access_policies) per esaminare quali sono le politiche, a chi è possibile assegnarle e a quali risorse possono essere concesse.
{: shortdesc}

I ruoli {{site.data.keyword.Bluemix_notm}} IAM non possono essere assegnati a un account di servizio. Puoi invece [assegnare i ruoli RBAC agli account di servizio](#rbac).
{: tip}

### Assegnazione dei ruoli {{site.data.keyword.Bluemix_notm}} IAM con la console
{: #add_users}

Concedi agli utenti l'accesso ai tuoi cluster assegnando i ruoli di gestione della piattaforma {{site.data.keyword.Bluemix_notm}} IAM con la console {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

Prima di iniziare, verifica che ti sia stato assegnato il ruolo della piattaforma **Amministratore** per l'account {{site.data.keyword.Bluemix_notm}} in cui stai lavorando.

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e passa a **Gestisci > Account > Utenti**.

2. Seleziona gli utenti individualmente o crea un gruppo di accesso di utenti.
    * Per assegnare ruoli a un singolo utente:
      1. Fai clic sul nome dell'utente per cui vuoi impostare le autorizzazioni. Se l'utente non viene visualizzato, fai clic su **Invita utenti** per aggiungerlo all'account.
      2. Fai clic su **Assegna accesso**.
    * Per assegnare ruoli a più utenti in un gruppo di accesso:
      1. Nel menu di navigazione a sinistra, fai clic su **Gruppi di accesso**.
      2. Fai clic su **Crea** e dai al tuo gruppo un **Nome** e una **Descrizione**. Fai clic su **Crea**.
      3. Fai clic su **Aggiungi utenti** per aggiungere persone al tuo gruppo di accesso. Viene visualizzato un elenco degli utenti che hanno accesso al tuo account.
      4. Seleziona la casella accanto agli utenti che vuoi aggiungere al gruppo. Viene visualizzata una finestra di dialogo.
      5. Fai clic su **Aggiungi al gruppo**.
      6. Fai clic su **Politiche di accesso**.
      7. Fai clic su **Assegna accesso**.

3. Assegna una politica.
  * Per accedere a tutti i cluster in un gruppo di risorse:
    1. Fai clic su **Assegna l'accesso in un gruppo di risorse**.
    2. Seleziona il nome del gruppo di risorse.
    3. Dall'elenco **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
    4. Dall'elenco **Regione**, seleziona una o tutte le regioni.
    5. Seleziona un **Ruolo di accesso alla piattaforma**. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Autorizzazioni di accesso utente](/cs_access_reference.html#platform).
    6. Fai clic su **Assegna**.
  * Per l'accesso a un cluster in un gruppo di risorse o a tutti i cluster in tutti i gruppi di risorse:
    1. Fai clic su **Assegna l'accesso alle risorse**.
    2. Dall'elenco **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
    3. Dall'elenco **Regione**, seleziona una o tutte le regioni.
    4. Dall'elenco **Istanza del servizio**, seleziona un nome cluster o **Tutte le istanze del servizio**.
    5. Nella sezione **Seleziona i ruoli**, scegli un ruolo di accesso alla piattaforma {{site.data.keyword.Bluemix_notm}} IAM. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Autorizzazioni di accesso utente](/cs_access_reference.html#platform). Nota: se assegni a un utente il ruolo della piattaforma **Amministratore** solo per un cluster, devi assegnargli anche il ruolo della piattaforma **Visualizzatore** per tutti i cluster in quella regione all'interno del gruppo di risorse.
    6. Fai clic su **Assegna**.

4. Se vuoi che gli utenti siano in grado di lavorare con i cluster in un gruppo di risorse diverso da quello predefinito, questi utenti necessitano di un accesso aggiuntivo ai gruppi di risorse in cui si trovano i cluster. Puoi assegnare a questi utenti almeno il ruolo della piattaforma **Visualizzatore** per i gruppi di risorse.
  1. Fai clic su **Assegna l'accesso in un gruppo di risorse**.
  2. Seleziona il nome del gruppo di risorse.
  3. Dall'elenco **Assegna accesso a un gruppo di risorse**, seleziona il ruolo **Visualizzatore**. Questo ruolo consente agli utenti di accedere al gruppo di risorse stesso, ma non alle risorse all'interno del gruppo.
  4. Fai clic su **Assegna**.

### Assegnazione dei ruoli {{site.data.keyword.Bluemix_notm}} IAM con la CLI
{: #add_users_cli}

Concedi agli utenti l'accesso ai tuoi cluster assegnando i ruoli di gestione della piattaforma {{site.data.keyword.Bluemix_notm}} IAM con la CLI.
{: shortdesc}

**Prima di iniziare**:

- Verifica che ti sia stato assegnato il ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM `cluster-admin` per l'account {{site.data.keyword.Bluemix_notm}} in cui stai lavorando.
- Verifica che l'utente sia stato aggiunto all'account. Se non è stato aggiunto, invita l'utente al tuo account eseguendo `ibmcloud account user-invite <user@email.com>`.
- [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

**Per assegnare i ruoli {{site.data.keyword.Bluemix_notm}} IAM a un singolo utente con la CLI:**

1.  Crea una politica di accesso {{site.data.keyword.Bluemix_notm}} IAM per impostare le autorizzazioni per {{site.data.keyword.containerlong_notm}} (**`--service-name containers-kubernetes`**). Per il ruolo della piattaforma, puoi scegliere Visualizzatore, Editor, Operatore e Amministratore. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Autorizzazioni di accesso utente](cs_access_reference.html#platform).
    * Per assegnare l'accesso a un cluster in un gruppo di risorse:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Nota**: se assegni a un utente il ruolo della piattaforma **Amministratore** solo per un cluster, devi assegnargli anche il ruolo della piattaforma **Visualizzatore** per tutti i cluster nella regione all'interno del gruppo di risorse.

    * Per assegnare l'accesso a tutti i cluster in un gruppo di risorse:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * Per assegnare l'accesso a tutti i cluster in tutti i gruppi di risorse:
      ```
      ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

2. Se vuoi che gli utenti siano in grado di lavorare con i cluster in un gruppo di risorse diverso da quello predefinito, questi utenti necessitano di un accesso aggiuntivo ai gruppi di risorse in cui si trovano i cluster. Puoi assegnare a questi utenti almeno il ruolo **Visualizzatore** per i gruppi di risorse. Puoi trovare l'ID del gruppo di risorse eseguendo `ibmcloud resource group <resource_group_name> --id`.
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. Per rendere effettive le modifiche, aggiorna la configurazione del cluster.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. Il ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM viene applicato automaticamente come [bind del ruolo RBAC o bind del ruolo cluster](#role-binding) corrispondente. Verifica che l'utente sia stato aggiunto al ruolo RBAC immettendo uno dei seguenti comandi per il ruolo della piattaforma che hai assegnato:
    * Visualizzatore:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operatore:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Amministratore:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  Ad esempio, se all'utente `john@email.com` assegni il ruolo della piattaforma **Visualizzatore** ed esegui `kubectl get rolebinding ibm-view -o yaml -n default`, l'output sarà simile al seguente:

  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-view
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-view
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: view
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: IAM#user@email.com
  ```
  {: screen}


**Per assegnare ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM a più utenti in un gruppo di accesso con la CLI:**

1. Crea un gruppo di accesso.
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. Aggiungi utenti al gruppo di accesso.
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. Crea una politica di accesso {{site.data.keyword.Bluemix_notm}} IAM per impostare le autorizzazioni per {{site.data.keyword.containerlong_notm}}. Per il ruolo della piattaforma, puoi scegliere Visualizzatore, Editor, Operatore e Amministratore. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Autorizzazioni di accesso utente](/cs_access_reference.html#platform).
  * Per assegnare l'accesso a un cluster in un gruppo di risorse:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      Se assegni a un utente il ruolo della piattaforma **Amministratore** solo per un cluster, devi assegnargli anche il ruolo della piattaforma **Visualizzatore** per tutti i cluster nella regione all'interno del gruppo di risorse.
      {: note}

  * Per assegnare l'accesso a tutti i cluster in un gruppo di risorse:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * Per assegnare l'accesso a tutti i cluster in tutti i gruppi di risorse:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. Se vuoi che gli utenti siano in grado di lavorare con i cluster in un gruppo di risorse diverso da quello predefinito, questi utenti necessitano di un accesso aggiuntivo ai gruppi di risorse in cui si trovano i cluster. Puoi assegnare a questi utenti almeno il ruolo **Visualizzatore** per i gruppi di risorse. Puoi trovare l'ID del gruppo di risorse eseguendo `ibmcloud resource group <resource_group_name> --id`.
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. Se hai assegnato l'accesso a tutti i cluster in tutti i gruppi di risorse, ripeti questo comando per ogni gruppo di risorse nell'account.

5. Per rendere effettive le modifiche, aggiorna la configurazione del cluster.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. Il ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM viene applicato automaticamente come [bind del ruolo RBAC o bind del ruolo cluster](#role-binding) corrispondente. Verifica che l'utente sia stato aggiunto al ruolo RBAC immettendo uno dei seguenti comandi per il ruolo della piattaforma che hai assegnato:
    * Visualizzatore:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operatore:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Amministratore:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  Ad esempio, se al gruppo di accesso `team1` assegni il ruolo della piattaforma **Visualizzatore** ed esegui `kubectl get rolebinding ibm-view -o yaml -n default`, l'output sarà simile al seguente:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-edit
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-edit
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team1
  ```
  {: screen}

<br />



- Per assegnare l'accesso a singoli utenti o a utenti in un gruppo di accesso, assicurati che all'utente o al gruppo sia stato assegnato almeno un [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM](#platform) a livello di servizio {{site.data.keyword.containerlong_notm}}.

Per creare autorizzazioni RBAC personalizzate:

1. Crea il ruolo o il ruolo cluster con l'accesso che vuoi assegnare.

    1. Crea un file `.yaml` per definire il ruolo o il ruolo cluster.

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Utilizza `Role` per concedere l'accesso alle risorse all'interno di uno specifico spazio dei nomi. Utilizza `ClusterRole` per concedere l'accesso alle risorse a livello di cluster, come i nodi di lavoro, o alle risorse nell'ambito degli spazi dei nomi, come i pod, in tutti gli spazi dei nomi.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successive, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>Solo per il tipo `Role`: specifica lo spazio dei nomi Kubernetes a cui è concesso l'accesso.</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Fornisci un nome per il ruolo o il ruolo cluster.</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>Specifica i [gruppi di API ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) Kubernetes con i quali gli utenti potranno interagire, ad esempio `"apps"`, `"batch"` o `"extensions"`. Per l'accesso al gruppo API principale nel percorso REST `api/v1`, lascia il gruppo vuoto: `[""]`.</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>Specifica i [tipi di risorsa ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) Kubernetes a cui vuoi concedere l'accesso, ad esempio `"daemonsets"`, `"deployments"`, `"events"` o `"ingresses"`. Se specifichi `"nodes"`, il tipo deve essere `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>Specifica i tipi di [azioni ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/) che vuoi che gli utenti siano in grado di eseguire, ad esempio `"get"`, `"list"`, `"describe"`, `"create"` o `"delete"`.</td>
            </tr>
          </tbody>
        </table>

    2. Crea il ruolo o il ruolo cluster nel tuo cluster.

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. Verifica che il ruolo o il ruolo cluster sia stato creato.
      * Ruolo:
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * Ruolo cluster:
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. Esegui il bind degli utenti al ruolo o al ruolo cluster.

    1. Crea un file `.yaml` per eseguire il bind degli utenti al ruolo o al ruolo cluster. Nota l'URL univoco da utilizzare per il nome di ogni soggetto.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: IAM#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>Specifica `RoleBinding` per un `Role` o `ClusterRole` specifico dello spazio dei nomi.</li><li>Specifica `ClusterRoleBinding` per un `ClusterRole` a livello di cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successive, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>Per il tipo `RoleBinding`: specifica lo spazio dei nomi Kubernetes a cui è concesso l'accesso.</li><li>Per il tipo `ClusterRoleBinding`: non utilizzare il campo `namespace`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Fornisci un nome per il bind del ruolo o il bind del ruolo cluster.</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>Specifica il tipo come uno dei seguenti:
              <ul><li>`User`: esegui il bind del ruolo RBAC o del ruolo cluster a un singolo utente nel tuo account.</li>
              <li>`Group`: per i cluster che eseguono Kubernetes 1.11 o versioni successive, esegui il bind del ruolo RBAC o del ruolo cluster a un [gruppo di accesso {{site.data.keyword.Bluemix_notm}} IAM](/docs/iam/groups.html#groups) nel tuo account.</li>
              <li>`ServiceAccount`: esegui il bind del ruolo RBAC o del ruolo cluster a un account di servizio in uno spazio dei nomi nel tuo cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>Per `User`: aggiungi l'indirizzo e-mail del singolo utente a uno dei seguenti URL.<ul><li>Per i cluster che eseguono Kubernetes 1.11 o versioni successive: <code>IAM#user@email.com</code></li><li>Per i cluster che eseguono Kubernetes 1.10 o versioni precedenti: <code>https://iam.ng.bluemix.net/kubernetes#user@email.com</code></li></ul></li>
              <li>Per `Group`: per i cluster che eseguono Kubernetes 1.11 o versioni successive, specifica il nome del [gruppo di accesso {{site.data.keyword.Bluemix_notm}} IAM](/docs/iam/groups.html#groups) nel tuo account.</li>
              <li>Per `ServiceAccount`: specifica il nome dell'account di servizio.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>Per `User` o `Group`: utilizza `rbac.authorization.k8s.io`.</li>
              <li>Per `ServiceAccount`: non includere questo campo.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>Solo per `ServiceAccount`: specifica il nome dello spazio dei nomi Kubernetes in cui è distribuito l'account di servizio.</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>Immetti lo stesso valore del `kind` nel file `.yaml` del ruolo: `Role` o `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>Immetti il nome del file `.yaml` del ruolo.</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>Utilizza `rbac.authorization.k8s.io`.</td>
            </tr>
          </tbody>
        </table>

    2. Crea la risorsa di bind del ruolo o bind del ruolo cluster nel tuo cluster.

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  Verifica che il bind sia stata creato.

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

3. Facoltativo: per applicare lo stesso livello di accesso utente in altri spazi dei nomi, puoi copiare i bind del ruolo per quei ruoli o ruoli cluster negli altri spazi dei nomi.
    1. Copia il bind del ruolo da uno spazio dei nomi a un altro spazio dei nomi.
        ```
        kubectl get rolebinding <role_binding_name> -o yaml | sed 's/<namespace_1>/<namespace_2>/g' | kubectl -n <namespace_2> create -f -
        ```
        {: pre}

        Ad esempio, per copiare il bind del ruolo `custom-role` dallo spazio dei nomi `default` allo spazio dei nomi `testns`:
        ```
        kubectl get rolebinding custom-role -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
        ```
        {: pre}

    2. Verifica che il bind del ruolo sia stato copiato. Se hai aggiunto un gruppo di accesso {{site.data.keyword.Bluemix_notm}} IAM al bind del ruolo, ogni utente in quel gruppo viene aggiunto singolarmente, non come un ID di gruppo di accesso.
        ```
        kubectl get rolebinding -n <namespace_2>
        ```
        {: pre}

Ora che hai creato e associato un ruolo RBAC o un ruolo cluster Kubernetes personalizzato, occupati degli utenti. Chiedi loro di testare un'azione per la quale dispongono dell'autorizzazione grazie al ruolo, come l'eliminazione di un pod.

<br />


</staging>

## Assegnazione delle autorizzazioni RBAC
{: #role-binding}

Utilizza i ruoli RBAC per definire le azioni che un utente può eseguire per lavorare con le risorse Kubernetes nel tuo cluster. 
{: shortdesc}

**Cosa sono i ruoli RBAC e i ruoli cluster?**</br>

I ruoli RBAC e i ruoli cluster definiscono una serie di autorizzazioni per il modo in cui gli utenti possono interagire con le risorse Kubernetes nel tuo cluster. Un ruolo è esteso alle risorse all'interno di uno spazio dei nomi specifico, come una distribuzione. Un ruolo cluster è esteso alle risorse a livello di cluster, come i nodi di lavoro, o alle risorse nell'ambito degli spazi dei nomi che possono essere trovate in ognuno di questi spazi, come i pod.

**Cosa sono i bind del ruolo RBAC e i bind del ruolo cluster?**</br>

I bind del ruolo applicano i ruoli RBAC o i ruoli cluster a uno specifico spazio dei nomi. Quando utilizzi un bind del ruolo per applicare un ruolo, fornisci a un utente l'accesso a una risorsa specifica in uno specifico spazio dei nomi. Quando utilizzi un bind del ruolo per applicare un ruolo cluster, fornisci a un utente l'accesso alle risorse nell'ambito degli spazi dei nomi che possono essere trovate in ognuno di questi spazi, come i pod, ma solo all'interno di uno spazio dei nomi specifico.

I bind del ruolo cluster applicano i ruoli cluster RBAC a tutti gli spazi dei nomi nel cluster. Quando utilizzi un bind del ruolo cluster per applicare un ruolo cluster, fornisci a un utente l'accesso alle risorse a livello di cluster, come i nodi di lavoro, o alle risorse nell'ambito degli spazi dei nomi in ogni spazio dei nomi, come i pod.

**Che forma assumono questi ruoli nel mio cluster?**</br>

A ogni utente a cui viene assegnato un [ruolo di gestione della piattaforma {{site.data.keyword.Bluemix_notm}} IAM](#platform) viene assegnato automaticamente un ruolo cluster RBAC corrispondente. Questi ruoli cluster RBAC sono predefiniti e consentono agli utenti di interagire con le risorse Kubernetes nel tuo cluster. Inoltre, viene creato un bind del ruolo per applicare il ruolo cluster a uno specifico spazio dei nomi o un bind del ruolo cluster per applicare il ruolo cluster a tutti gli spazi dei nomi.

La seguente tabella descrive le relazioni tra i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} e i ruoli cluster corrispondenti e i bind del ruolo o i bind del ruolo cluster che vengono creati automaticamente per i ruoli della piattaforma.

<table>
  <tr>
    <th>Ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM</th>
    <th>Ruolo cluster RBAC</th>
    <th>Bind del ruolo RBAC</th>
    <th>Bind del ruolo cluster RBAC</th>
  </tr>
  <tr>
    <td>Visualizzatore</td>
    <td><code>view</code></td>
    <td><code>ibm-view</code> nello spazio dei nomi predefinito</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Editor</td>
    <td><code>edit</code></td>
    <td><code>ibm-edit</code> nello spazio dei nomi predefinito</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Operatore</td>
    <td><code>admin</code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Amministratore</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

Per ulteriori informazioni sulle azioni consentite da ogni ruolo RBAC, controlla l'argomento di riferimento [Autorizzazioni di accesso utente](cs_access_reference.html#platform).
{: tip}

**Come posso gestire le autorizzazioni RBAC per specifici spazi dei nomi nel mio cluster?**

Se utilizzi gli [spazi dei nomi Kubernetes per partizionare il tuo cluster e fornire isolamento per i carichi di lavoro](cs_secure.html#container), devi assegnare l'accesso utente a spazi dei nomi specifici. Quando assegni a un utente i ruoli della piattaforma **Operatore** o **Amministratore**, i corrispondenti ruoli cluster predefiniti `admin` e `cluster-admin` vengono applicati automaticamente all'intero cluster. Tuttavia, quando a un utente assegni i ruoli della piattaforma **Visualizzatore** o **Editor**, i corrispondenti ruoli cluster predefiniti `view` ed `edit` vengono applicati automaticamente solo nello spazio dei nomi predefinito. Per applicare lo stesso livello di accesso utente in altri spazi dei nomi, puoi [copiare i bind del ruolo](#rbac_copy) per quei ruoli cluster, `ibm-view` e `ibm-edit`, negli altri spazi dei nomi.

**Posso creare ruoli o ruoli cluster personalizzati?**

I ruoli cluster `view`, `edit`, `admin` e `cluster-admin` sono ruoli predefiniti che vengono creati automaticamente quando assegni a un utente il ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM corrispondente. Per concedere altre autorizzazioni Kubernetes, puoi [creare autorizzazioni RBAC personalizzate](#rbac).

**Quando devo utilizzare i bind del ruolo cluster e i bind del ruolo non legati alle autorizzazioni {{site.data.keyword.Bluemix_notm}} IAM che ho impostato?**

Potresti voler autorizzare chi può creare e aggiornare i pod nel tuo cluster. Con le [politiche di sicurezza pod](https://console.bluemix.net/docs/containers/cs_psp.html#psp), puoi utilizzare i bind del ruolo cluster esistenti forniti con il tuo cluster o crearne di tuoi.

Potresti anche voler integrare componenti aggiuntivi al tuo cluster. Ad esempio, quando [configuri Helm nel tuo cluster](cs_integrations.html#helm), devi creare un account di servizio per Tiller nello spazio dei nomi `kube-system` e un bind del ruolo cluster RBAC Kubernetes per il pod `tiller-deploy`.

### Copia di un bind del ruolo RBAC in un altro spazio dei nomi
{: #rbac_copy}

Alcuni ruoli e ruoli cluster vengono applicati solo a uno spazio dei nomi. Ad esempio, i ruoli cluster predefiniti `view` ed `edit` vengono applicati automaticamente solo nello spazio dei nomi `predefinito`. Per applicare lo stesso livello di accesso utente in altri spazi dei nomi, puoi copiare i bind del ruolo per quei ruoli o ruoli cluster negli altri spazi dei nomi.
{: shortdesc}

Ad esempio, supponiamo che tu assegni all'utente "john@email.com" il ruolo di gestione della piattaforma **Editor**. Il ruolo cluster RBAC predefinito `edit` viene creato automaticamente nel tuo cluster e il bind del ruolo `ibm-edit` applica le autorizzazioni nello spazio dei nomi di `default`. Vuoi che "john@email.com" abbia anche l'accesso come Editor nel tuo spazio dei nomi di sviluppo, quindi copi il bind del ruolo `ibm-edit` da `default` in `development`. **Nota**: devi copiare il bind del ruolo ogni volta un utente viene aggiunto ai ruoli `view` o `edit`.

1. Copia il bind del ruolo da `default` in un altro spazio dei nomi.
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    Ad esempio, per copiare il bind del ruolo `ibm-edit` nello spazio dei nomi `testns`:
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. Verifica che il bind del ruolo `ibm-edit` sia stato copiato.
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### Creazione di autorizzazioni RBAC personalizzate per utenti, gruppi o account di servizio
{: #rbac}

I ruoli cluster `view`, `edit`, `admin` e `cluster-admin` vengono creati automaticamente quando assegni il ruolo di gestione della piattaforma {{site.data.keyword.Bluemix_notm}} IAM corrispondente. Ha bisogno che le tue politiche di accesso al cluster siano più dettagliate di quelle permesse dalle autorizzazioni predefinite? Nessun problema! Puoi creare ruoli RBAC e ruoli cluster personalizzati.
{: shortdesc}

Puoi assegnare ruoli RBAC e ruoli cluster personalizzati a singoli utenti, gruppi di utenti (nei cluster che eseguono Kubernetes v1.11 o successiva) o account di servizio. Quando viene creato, un bind per un gruppo influenza qualsiasi utente aggiunto a, o rimosso da, tale gruppo. Quando aggiungi utenti a un gruppo, questi ottengono i diritti di accesso del gruppo oltre a eventuali singoli diritti di accesso che concedi loro. Se viene rimosso, il suo accesso viene revocato. **Nota**: non puoi aggiungere account di servizio ai gruppi di accesso.

Se vuoi assegnare l'accesso a un processo che viene eseguito nei pod, come una toolchain di fornitura continua, puoi utilizzare gli [account di servizio Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). Per seguire un'esercitazione che illustra come configurare gli account di servizio per Travis e Jenkins e per assegnare ruoli RBAC personalizzati agli account di servizio, vedi il post del blog [Kubernetes ServiceAccounts for use in automated systems ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982).

**Nota**: per evitare modifiche improvvise, non modificare i ruoli cluster predefiniti `view`, `edit`, `admin` e `cluster-admin`.

**Creo un ruolo o un ruolo cluster? Lo applico con un bind del ruolo o un bind del ruolo cluster?**

* Per consentire a un utente, gruppo di accesso o account di servizio di accedere a una risorsa all'interno di uno specifico spazio dei nomi, scegli una delle seguenti combinazioni:
  * Crea un ruolo e applicalo con un bind del ruolo. Questa opzione è utile per controllare l'accesso a un'unica risorsa presente solo in uno spazio dei nomi, come una distribuzione dell'applicazione.
  * Crea un ruolo cluster e applicalo con un bind del ruolo. Questa opzione è utile per controllare l'accesso a risorse generali in uno spazio dei nomi, come i pod.
* Per consentire a un utente o a un gruppo di accesso di accedere a risorse a livello di cluster o a risorse in tutti gli spazi dei nomi, crea un ruolo cluster e applicalo con un bind del ruolo cluster. Questa opzione è utile per controllare l'accesso alle risorse che non rientrano nell'ambito degli spazi dei nomi, come i nodi di lavoro, o alle risorse in tutti gli spazi dei nomi nel tuo cluster, come i pod in ogni spazio dei nomi.

Prima di iniziare:

- Indirizza la [CLI Kubernetes](cs_cli_install.html#cs_cli_configure) al tuo cluster.
- Per assegnare l'accesso a singoli utenti o a utenti in un gruppo di accesso, assicurati che all'utente o al gruppo sia stato assegnato almeno un [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM](#platform) a livello di servizio {{site.data.keyword.containerlong_notm}}.

Per creare autorizzazioni RBAC personalizzate:

1. Crea il ruolo o il ruolo cluster con l'accesso che vuoi assegnare.

    1. Crea un file `.yaml` per definire il ruolo o il ruolo cluster.

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Utilizza `Role` per concedere l'accesso alle risorse all'interno di uno specifico spazio dei nomi. Utilizza `ClusterRole` per concedere l'accesso alle risorse a livello di cluster, come i nodi di lavoro, o alle risorse nell'ambito degli spazi dei nomi, come i pod, in tutti gli spazi dei nomi.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successive, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>Solo per il tipo `Role`: specifica lo spazio dei nomi Kubernetes a cui è concesso l'accesso.</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Fornisci un nome per il ruolo o il ruolo cluster.</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>Specifica i [gruppi di API ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) Kubernetes con i quali gli utenti potranno interagire, ad esempio `"apps"`, `"batch"` o `"extensions"`. Per l'accesso al gruppo API principale nel percorso REST `api/v1`, lascia il gruppo vuoto: `[""]`.</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>Specifica i [tipi di risorsa ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) Kubernetes a cui vuoi concedere l'accesso, ad esempio `"daemonsets"`, `"deployments"`, `"events"` o `"ingresses"`. Se specifichi `"nodes"`, il tipo deve essere `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>Specifica i tipi di [azioni ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/) che vuoi che gli utenti siano in grado di eseguire, ad esempio `"get"`, `"list"`, `"describe"`, `"create"` o `"delete"`.</td>
            </tr>
          </tbody>
        </table>

    2. Crea il ruolo o il ruolo cluster nel tuo cluster.

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. Verifica che il ruolo o il ruolo cluster sia stato creato.
      * Ruolo:
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * Ruolo cluster:
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. Esegui il bind degli utenti al ruolo o al ruolo cluster.

    1. Crea un file `.yaml` per eseguire il bind degli utenti al ruolo o al ruolo cluster. Nota l'URL univoco da utilizzare per il nome di ogni soggetto.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: IAM#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>Specifica `RoleBinding` per un `Role` o `ClusterRole` specifico dello spazio dei nomi.</li><li>Specifica `ClusterRoleBinding` per un `ClusterRole` a livello di cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successive, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>Per il tipo `RoleBinding`: specifica lo spazio dei nomi Kubernetes a cui è concesso l'accesso.</li><li>Per il tipo `ClusterRoleBinding`: non utilizzare il campo `namespace`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Fornisci un nome per il bind del ruolo o il bind del ruolo cluster.</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>Specifica il tipo come uno dei seguenti:
              <ul><li>`User`: esegui il bind del ruolo RBAC o del ruolo cluster a un singolo utente nel tuo account.</li>
              <li>`Group`: per i cluster che eseguono Kubernetes 1.11 o versioni successive, esegui il bind del ruolo RBAC o del ruolo cluster a un [gruppo di accesso {{site.data.keyword.Bluemix_notm}} IAM](/docs/iam/groups.html#groups) nel tuo account.</li>
              <li>`ServiceAccount`: esegui il bind del ruolo RBAC o del ruolo cluster a un account di servizio in uno spazio dei nomi nel tuo cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>Per `User`: aggiungi l'indirizzo e-mail del singolo utente a uno dei seguenti URL.<ul><li>Per i cluster che eseguono Kubernetes 1.11 o versioni successive: <code>IAM#user@email.com</code></li><li>Per i cluster che eseguono Kubernetes 1.10 o versioni precedenti: <code>https://iam.ng.bluemix.net/kubernetes#user@email.com</code></li></ul></li>
              <li>Per `Group`: per i cluster che eseguono Kubernetes 1.11 o versioni successive, specifica il nome del [gruppo {{site.data.keyword.Bluemix_notm}} IAM](/docs/iam/groups.html#groups) nel tuo account.</li>
              <li>Per `ServiceAccount`: specifica il nome dell'account di servizio.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>Per `User` o `Group`: utilizza `rbac.authorization.k8s.io`.</li>
              <li>Per `ServiceAccount`: non includere questo campo.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>Solo per `ServiceAccount`: specifica il nome dello spazio dei nomi Kubernetes in cui è distribuito l'account di servizio.</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>Immetti lo stesso valore del `kind` nel file `.yaml` del ruolo: `Role` o `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>Immetti il nome del file `.yaml` del ruolo.</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>Utilizza `rbac.authorization.k8s.io`.</td>
            </tr>
          </tbody>
        </table>

    2. Crea la risorsa di bind del ruolo o bind del ruolo cluster nel tuo cluster.

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  Verifica che il bind sia stata creato.

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

Ora che hai creato e associato un ruolo RBAC o un ruolo cluster Kubernetes personalizzato, occupati degli utenti. Chiedi loro di testare un'azione per la quale dispongono dell'autorizzazione grazie al ruolo, come l'eliminazione di un pod.

<br />




## Personalizzazione delle autorizzazioni di infrastruttura
{: #infra_access}

Quando assegni il ruolo dell'infrastruttura **Super utente** all'amministratore che imposta la chiave API o di cui vengono impostate le credenziali di infrastruttura, gli altri utenti all'interno dell'account condividono la chiave API o le credenziali per eseguire azioni dell'infrastruttura. Puoi quindi controllare quali azioni dell'infrastruttura possono essere eseguite dagli utenti assegnando il [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM](#platform) appropriato. Non dovrai modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) dell'utente.
{: shortdesc}

Per motivi di conformità, sicurezza o fatturazione, potresti non voler assegnare il ruolo dell'infrastruttura **Super utente** all'utente che imposta la chiave API o di cui vengono impostate le credenziali con il comando `ibmcloud ks credential-set`. Tuttavia, se questo utente non ha il ruolo **Super utente**, le azioni correlate all'infrastruttura, come la creazione di un cluster o il ricaricamento di un nodo di lavoro, possono avere esito negativo. Invece di utilizzare i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM per controllare l'accesso all'infrastruttura degli utenti, devi impostare specifiche autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) per gli utenti.

Se hai dei cluster multizona, il tuo proprietario dell'account dell'infrastruttura IBM Cloud (SoftLayer) deve attivare lo spanning delle VLAN in modo che i nodi in zone differenti possano comunicare all'interno del cluster. Il proprietario dell'account può anche assegnare a un utente l'autorizzazione **Rete > Gestisci il VLAN Spanning di rete** in modo che l'utente possa abilitare lo spanning delle VLAN. Per controllare se lo spanning della VLAN è già abilitato, utilizza il [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

Prima di iniziare, assicurati di essere il proprietario dell'account o di avere il ruolo di **Super utente** e l'accesso a tutti i dispositivi. Non puoi concedere a un utente un accesso che non hai.

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e passa a **Gestisci > Account > Utenti**.

2. Fai clic sul nome dell'utente per cui vuoi impostare le autorizzazioni.

3. Fai clic su **Assegna accesso** e quindi su **Assegna l'accesso al tuo account SoftLayer**.

4. Fai clic sulla scheda **Autorizzazioni portale** per personalizzare l'accesso dell'utente. Le autorizzazioni necessarie agli utenti dipendono dalle risorse di infrastruttura che devono utilizzare. Hai due opzioni per assegnare l'accesso:
    * Utilizza l'elenco a discesa **Autorizzazioni rapide** per assegnare uno dei seguenti ruoli predefiniti. Dopo aver selezionato un ruolo, fai clic su **Imposta autorizzazioni**.
        * **Utente con solo visualizzazione** fornisce all'utente le autorizzazioni per visualizzare solo i dettagli dell'infrastruttura.
        * **Utente di base** fornisce all'utente alcune, ma non tutte le autorizzazioni di infrastruttura.
        * **Super utente** fornisce all'utente tutte le autorizzazioni di infrastruttura.
    * Seleziona le singole autorizzazioni in ogni scheda. Per riesaminare le autorizzazioni necessarie per eseguire attività comuni in {{site.data.keyword.containerlong_notm}}, vedi [Autorizzazioni di accesso utente](cs_access_reference.html#infra).

5.  Per salvare le modifiche, fai clic su **Modifica autorizzazioni del portale**.

6.  Nella scheda **Accesso al dispositivo**, seleziona i dispositivi a cui concedere l'accesso.

    * Nell'elenco a discesa **Tipo di dispositivo**, puoi concedere l'accesso a **Tutti i dispositivi** in modo che gli utenti possano lavorare con tipi di macchine sia virtuali che fisiche (hardware bare metal) per i nodi di lavoro.
    * Per consentire agli utenti di accedere ai nuovi dispositivi che vengono creati, seleziona **Accesso concesso automaticamente quando vengono aggiunti nuovi dispositivi**.
    * Nella tabella dei dispositivi, assicurati che siano selezionati i dispositivi appropriati.

7. Per salvare le modifiche, fai clic su **Aggiorna accesso dispositivo**.

Downgrade delle autorizzazioni? Per il completamento dell'azione, potrebbero essere necessari alcuni minuti.
{: tip}

<br />


## Rimozione delle autorizzazioni utente
{: #removing}

Se un utente non ha più bisogno di autorizzazioni di accesso specifiche, o se l'utente lascia la tua organizzazione, il proprietario dell'account {{site.data.keyword.Bluemix_notm}} può rimuovere le autorizzazioni di quell'utente.
{: shortdesc}

Prima di rimuovere le autorizzazioni di accesso specifiche di un utente o di rimuovere completamente un utente dal tuo account, assicurati che le credenziali di infrastruttura dell'utente non vengano utilizzate per impostare la chiave API o per il comando `ibmcloud ks credential-set`. In caso contrario, gli altri utenti nell'account potrebbero perdere l'accesso al portale dell'infrastruttura IBM Cloud (SoftLayer) e i comandi relativi all'infrastruttura potrebbero non riuscire.
{: important}

1. Indirizza il tuo contesto della CLI a una regione e a un gruppo di risorse in cui hai i cluster.
    ```
    ibmcloud target -g <resource_group_name> -r <region>
    ```
    {: pre}

2. Verifica il proprietario della chiave API o delle credenziali dell'infrastruttura impostate per tale regione e gruppo di risorse.
    * Se utilizzi la [chiave API per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](#default_account):
        ```
        ibmcloud ks api-key-info --cluster <cluster_name_or_id>
        ```
        {: pre}
    * Se imposti le [credenziali dell'infrastruttura per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](#credentials):
        ```
        ibmcloud ks credential-get
        ```
        {: pre}

3. Se viene restituito il nome utente dell'utente, utilizza le credenziali di un altro utente per impostare la chiave API o le credenziali dell'infrastruttura.

  Se il proprietario dell'account non imposta la chiave API o se tu non imposti le credenziali di infrastruttura del proprietario dell'account, [assicurati che l'utente che imposta la chiave API o di cui imposti le credenziali disponga delle autorizzazioni corrette](#owner_permissions).
  {: note}

    * Per reimpostare la chiave API:
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}
    * Per reimpostare le credenziali dell'infrastruttura:
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4. Ripeti questi passi per ogni combinazione di gruppi di risorse e regioni in cui hai i cluster.

### Rimozione di un utente da un account
{: #remove_user}

Se un utente nel tuo account lascia la tua organizzazione, devi rimuovere con attenzione le autorizzazioni per tale utente per assicurarti di non rendere orfani i cluster o le altre risorse. Successivamente, puoi rimuovere l'utente dal tuo account {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

Prima di iniziare:
- [Assicurati che le credenziali di infrastruttura dell'utente non siano utilizzate per impostare la chiave API o per il comando `ibmcloud ks credential-set`](#removing).
- Se nel tuo account {{site.data.keyword.Bluemix_notm}} hai altre istanze del servizio di cui l'utente potrebbe aver eseguito il provisioning, controlla la documentazione di tali servizi per verificare tutti i passi che devi completare prima di rimuovere l'utente dall'account.

Prima che l'utente se ne vada, il proprietario dell'account {{site.data.keyword.Bluemix_notm}} deve completare i seguenti passi per impedire modifiche improvvise in {{site.data.keyword.containerlong_notm}}.

1. Determina quali cluster sono stati creati dall'utente.
    1.  Accedi alla [console {{site.data.keyword.containerlong_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/containers-kubernetes/clusters).
    2.  Dalla tabella, seleziona il tuo cluster.
    3.  Nella scheda **Panoramica**, cerca il campo **Proprietario**.

2. Per ogni cluster creato dall'utente, segui questi passi:
    1. Verifica quale account dell'infrastruttura ha utilizzato l'utente per eseguire il provisioning del cluster.
        1.  Nella scheda **Nodi di lavoro**, seleziona un nodo di lavoro e prendi nota del suo **ID**.
        2.  Apri il menu ![Icona Menu](../icons/icon_hamburger.svg "Icona Menu") e fai clic su **Infrastruttura**.
        3.  Dal riquadro di navigazione dell'infrastruttura, fai clic su **Dispositivi > Elenco dispositivi**.
        4.  Cerca l'ID nodo di lavoro di cui hai precedentemente preso nota.
        5.  Se non trovi l'ID nodo di lavoro, il nodo di lavoro non è fornito in questo account dell'infrastruttura. Passa a un altro account dell'infrastruttura e riprova.
    2. Determina cosa succede all'account dell'infrastruttura utilizzato dall'utente per eseguire il provisioning dei cluster dopo che l'utente se ne va.
        * Se l'utente non possiede l'account dell'infrastruttura, gli altri utenti hanno accesso a questo account dell'infrastruttura che persiste dopo che l'utente se ne è andato. Puoi continuare a lavorare con questi cluster nel tuo account. Assicurati che almeno un altro utente abbia il [ruolo della piattaforma **Amministratore**](#platform) per i cluster.
        * Se l'utente possiede l'account dell'infrastruttura, l'account dell'infrastruttura viene eliminato una volta che l'utente se ne è andato. Non puoi continuare a lavorare con questi cluster. Per impedire che il cluster diventi orfano, l'utente deve eliminare i cluster prima di andarsene. Se l'utente se ne è andato ma i cluster non sono stati eliminati, devi utilizzare il comando `ibmcloud ks credential-set` per modificare le tue credenziali dell'infrastruttura sull'account in cui è stato eseguito il provisioning dei nodi di lavoro del cluster ed eliminare il cluster. Per ulteriori informazioni, vedi [Impossibile modificare o eliminare l'infrastruttura in un cluster orfano](cs_troubleshoot_clusters.html#orphaned).

3. Rimuovi l'utente dall'account {{site.data.keyword.Bluemix_notm}}.
    1. Passa a **Gestisci > Account > Utenti**.
    2. Fai clic sul nome utente dell'utente.
    3. Nella voce di tabella per l'utente, fai clic sul menu delle azioni e seleziona **Rimuovi utente**. Quando rimuovi un utente, i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM, i ruoli Cloud Foundry e i ruoli dell'infrastruttura IBM Cloud (SoftLayer) assegnati all'utente vengono rimossi automaticamente.

4. Quando vengono rimosse le autorizzazioni della piattaforma {{site.data.keyword.Bluemix_notm}} IAM, le autorizzazioni dell'utente vengono rimosse automaticamente anche dai ruoli RBAC predefiniti associati. Tuttavia, se hai creato ruoli RBAC o ruoli cluster personalizzati, [rimuovi l'utente da quei bind del ruolo RBAC o bind del ruolo cluster](#remove_custom_rbac).

5. Se hai un account Pagamento a consumo che viene automaticamente collegato al tuo account {{site.data.keyword.Bluemix_notm}}, i ruoli dell'infrastruttura IBM Cloud (SoftLayer) dell'utente vengono rimossi automaticamente. Tuttavia, se hai un [diverso tipo di account](#understand_infra), potresti dover rimuovere l'utente manualmente dall'infrastruttura IBM Cloud (SoftLayer).
    1. Nel menu ![Icona Menu](../icons/icon_hamburger.svg "Icona Menu") della [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), fai clic su **Infrastruttura**.
    2. Passa a **Account > Utenti > Elenco utenti**.
    2. Cerca una voce di tabella per l'utente.
        * Se non vedi una voce per l'utente, l'utente è già stato rimosso. Non sono richieste ulteriori azioni.
        * Se vedi una voce per l'utente, vai al passo successivo.
    3. Nella voce di tabella per l'utente, fai clic sul menu Azioni.
    4. Seleziona **Modifica stato utente**.
    5. Nell'elenco Stato, seleziona **Disabilitato**. Fai clic su **Salva**.


### Rimozione di autorizzazioni specifiche
{: #remove_permissions}

Se vuoi rimuovere autorizzazioni specifiche per un utente, puoi rimuovere le singole politiche di accesso che sono state assegnate all'utente.
{: shortdesc}

Prima di iniziare, [assicurati che le credenziali di infrastruttura dell'utente non siano utilizzate per impostare la chiave API o per il comando `ibmcloud ks credential-set`](#removing). Successivamente, puoi rimuovere:
* [un utente da un gruppo di accesso](#remove_access_group)
* [le autorizzazioni della piattaforma {{site.data.keyword.Bluemix_notm}} IAM e le autorizzazioni RBAC associate di un utente](#remove_iam_rbac)
* [le autorizzazioni RBAC personalizzate di un utente](#remove_custom_rbac)
* [le autorizzazioni Cloud Foundry di un utente](#remove_cloud_foundry)
* [le autorizzazioni dell'infrastruttura di un utente](#remove_infra)

#### Rimuovi un utente da un gruppo di accesso
{: #remove_access_group}

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e passa a **Gestisci > Account > Utenti**.
2. Fai clic sul nome dell'utente da cui vuoi rimuovere le autorizzazioni.
3. Fai clic sulla scheda **Gruppo di accesso**.
4. Nella voce di tabella per il gruppo di accesso, fai clic sul menu delle azioni e seleziona **Rimuovi utente**. Quando l'utente viene rimosso, tutti i ruoli che sono stati assegnati al gruppo di accesso vengono rimossi dall'utente.

#### Rimuovi le autorizzazioni della piattaforma {{site.data.keyword.Bluemix_notm}} IAM e le autorizzazioni RBAC predefinite associate
{: #remove_iam_rbac}

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e passa a **Gestisci > Account > Utenti**.
2. Fai clic sul nome dell'utente da cui vuoi rimuovere le autorizzazioni.
3. Nella voce di tabella per l'autorizzazione che vuoi rimuovere, fai clic sul menu delle azioni.
4. Seleziona **Rimuovi.**
5. Quando vengono rimosse le autorizzazioni della piattaforma {{site.data.keyword.Bluemix_notm}} IAM, le autorizzazioni dell'utente vengono rimosse automaticamente anche dai ruoli RBAC predefiniti associati. Per aggiornare i ruoli RBAC con le modifiche, esegui `ibmcloud ks cluster-config`. Tuttavia, se hai creato [ruoli RBAC o ruoli cluster personalizzati](#rbac), devi rimuovere l'utente dai file `.yaml` per quei bind del ruolo RBAC o bind del ruolo cluster. Vedi i passi per rimuovere le autorizzazioni RBAC personalizzate qui di seguito.

#### Rimuovi le autorizzazioni RBAC personalizzate
{: #remove_custom_rbac}

Se non hai più bisogno delle autorizzazioni RBAC personalizzate, puoi rimuoverle. 
{: shortdesc}

1. Apri il file `.yaml` per il bind del ruolo o il bind del ruolo cluster che hai creato.
2. Nella sezione `subjects`, rimuovi la sezione relativa all'utente.
3. Salva il file.
4. Applica le modifiche nella risorsa di bind del ruolo o di bind del ruolo cluster nel tuo cluster.
    ```
    kubectl apply -f my_role_binding.yaml
    ```
    {: pre}

#### Rimuovi le autorizzazioni Cloud Foundry
{: #remove_cloud_foundry}

Per rimuovere tutte le autorizzazioni Cloud Foundry di un utente, puoi rimuovere i ruoli dell'organizzazione dell'utente. Se vuoi rimuovere solo la capacità di un utente, ad esempio, di eseguire il bind dei servizi in un cluster, rimuovi solo i ruoli dello spazio dell'utente.
{: shortdesc}

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e passa a **Gestisci > Account > Utenti**.
2. Fai clic sul nome dell'utente da cui vuoi rimuovere le autorizzazioni.
3. Fai clic sulla scheda **Accesso Cloud Foundry**.
    * Per rimuovere il ruolo dello spazio dell'utente:
        1. Espandi la voce di tabella relativa all'organizzazione in cui si trova lo spazio.
        2. Nella voce di tabella per il ruolo dello spazio, fai clic sul menu delle azioni e seleziona **Modifica ruolo spazio**.
        3. Elimina un ruolo facendo clic sul pulsante di chiusura.
        4. Per rimuovere tutti i ruoli dello spazio, seleziona **Nessun ruolo spazio** nell'elenco a discesa.
        5. Fai clic su **Salva ruolo**.
    * Per rimuovere il ruolo dell'organizzazione dell'utente:
        1. Nella voce di tabella per il ruolo dell'organizzazione, fai clic sul menu delle azioni e seleziona **Modifica ruolo organizzazione**.
        3. Elimina un ruolo facendo clic sul pulsante di chiusura.
        4. Per rimuovere tutti i ruoli dell'organizzazione, seleziona **Nessun ruolo organizzazione** nell'elenco a discesa.
        5. Fai clic su **Salva ruolo**.

#### Rimuovi le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer)
{: #remove_infra}

Puoi rimuovere le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) per un utente utilizzando la console {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/).
2. Dal menu ![Icona Menu](../icons/icon_hamburger.svg "Icona Menu"), fai clic su **Infrastruttura**.
3. Fai clic sull'indirizzo email dell'utente.
4. Fai clic sulla scheda **Autorizzazioni portale**.
5. In ogni scheda, deseleziona le autorizzazioni specifiche.
6. Per salvare le modifiche, fai clic su **Modifica autorizzazioni del portale**.
7. Nella scheda **Accesso al dispositivo**, deseleziona i dispositivi specifici.
8. Per salvare le modifiche, fai clic su **Aggiorna accesso dispositivo**. Il downgrade delle autorizzazioni viene completato dopo pochi minuti.

<br />



