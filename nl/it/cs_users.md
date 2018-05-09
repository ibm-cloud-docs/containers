---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Assegnazione dell'accesso utente ai cluster
{: #users}

Puoi concedere l'accesso a un cluster Kubernetes per garantire che solo gli utenti autorizzati possano lavorare con il cluster e distribuire i contenitori al cluster in {{site.data.keyword.containerlong}}.
{:shortdesc}


## Pianificazione dei processi di comunicazione
Come amministratore di un cluster, considera come potresti stabilire un processo di comunicazione con cui i membri della tua organizzazione ti comunichino le richieste di accesso in modo da poter essere organizzato.
{:shortdesc}

Fornisci istruzioni agli utenti del tuo cluster su come richiedere l'accesso a un cluster o su come ottenere assistenza con qualsiasi tipo di attività comuni da un amministratore del cluster. Poiché Kubernetes non facilita questo tipo di comunicazione, ogni team può avere variazioni sul proprio processo preferito.

Puoi scegliere uno dei seguenti metodi o stabilire il tuo proprio metodo.
- Crea un sistema di ticket
- Crea un template di modulo
- Crea una pagina wiki
- Richiedi una richiesta tramite e-mail
- Utilizza il metodo di tracciamento dei problemi che già usi per tracciare il lavoro quotidiano del tuo team


## Gestione dell'accesso al cluster
{: #managing}

A ogni utente che lavora con {{site.data.keyword.containershort_notm}} deve essere assegnata una combinazione di ruoli utente specifici per il sevizio
che determina quali azioni può eseguire un utente.
{:shortdesc}

<dl>
<dt>politiche di accesso
{{site.data.keyword.containershort_notm}}</dt>
<dd>In IAM (Identity and Access Management), le politiche di accesso {{site.data.keyword.containershort_notm}} determinano le azioni di gestione cluster che puoi eseguire su un
cluster, come la creazione o rimozione dei cluster e l'aggiunta o la rimozione di nodi di lavoro supplementari. Queste politiche devono essere configurate insieme alle politiche dell'infrastruttura. Puoi concedere l'accesso ai cluster su base regionale.</dd>
<dt>Politiche di accesso all'infrastruttura</dt>
<dd>In IAM (Identity and Access Management), le politiche di accesso all'infrastruttura consentono il completamento delle azioni richieste dall'interfaccia utente
{{site.data.keyword.containershort_notm}} dalla CLI nell'infrastruttura IBM Cloud (SoftLayer). Queste politiche devono essere configurate insieme alle politiche di accesso {{site.data.keyword.containershort_notm}}. [Ulteriori informazioni sui ruoli](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Gruppi di risorse</dt>
<dd>Un gruppo di risorse è un modo per organizzare i servizi {{site.data.keyword.Bluemix_notm}} in raggruppamenti in modo da poter assegnare rapidamente agli utenti l'accesso a più di una risorsa alla volta. [Scopri come gestire gli utenti utilizzando i gruppi di risorse](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Ruoli Cloud Foundry</dt>
<dd>In IAM (Identity and Access Management), a ogni utente deve essere assegnato un ruolo Cloud Foundry. Questo ruolo
determina le azioni che l'utente può eseguire sull'account {{site.data.keyword.Bluemix_notm}}, come l'invito di altri utenti
o la visualizzazione dell'utilizzo della quota. [Ulteriori informazioni sui ruoli Cloud Foundry disponibili](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Ruoli RBAC Kubernetes</dt>
<dd>Ad ogni utente a cui è assegnata una politica di accesso {{site.data.keyword.containershort_notm}} viene assegnato automaticamente un
ruolo RBAC.  In Kubernetes, i ruoli RBAC determinano le azioni che puoi eseguire sulle risorse Kubernetes
all'interno del cluster. I ruoli RBAC vengono configurati solo per lo spazio dei nomi predefinito. L'amministratore del cluster
può aggiungere i ruoli RBAC per gli altri spazi dei nomi nel cluster. Consulta la seguente tabella nella sezione [Autorizzazioni e politiche di accesso](#access_policies) per vedere a quale ruolo RBAC corrisponde una determinata politica di accesso {{site.data.keyword.containershort_notm}}. Per ulteriori informazioni sui ruoli RBAC in generale, vedi [Using RBAC Authorization ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) nella documentazione di Kubernetes.</dd>
</dl>

<br />


## Autorizzazioni e politiche di accesso
{: #access_policies}

Esamina le politiche di accesso e le autorizzazioni che puoi concedere agli utenti nel tuo account {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

I ruoli operatore ed editor di {{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM) hanno autorizzazioni separate. Se vuoi, ad esempio, che un utente aggiunga nodi di lavoro ed esegua il bind dei servizi, devi assegnare all'utente sia il ruolo di operatore che di editor. Per maggiori dettagli sulle politiche di accesso all'infrastruttura corrispondenti, vedi [Personalizzazione delle autorizzazioni dell'infrastruttura per un utente](#infra_access).<br/><br/>Se modifichi la politica di accesso di un utente, le politiche RBAC associate alla modifica nel tuo cluster vengono eliminate automaticamente. </br></br>**Nota:** quando esegui il downgrade delle autorizzazioni, ad esempio se vuoi assegnare l'accesso di visualizzatore a un amministratore cluster precedente, devi attendere alcuni minuti per il completamento del downgrade.

|Politica di accesso {{site.data.keyword.containershort_notm}}|Autorizzazioni di gestione del cluster|Autorizzazioni delle risorse Kubernetes|
|-------------|------------------------------|-------------------------------|
|Amministratore|Questo ruolo eredita le autorizzazioni dai ruoli editor, operatore e visualizzatore
per tutti i cluster in questo account. <br/><br/>Quando impostato per tutte le istanze del servizio:<ul><li>Creare un cluster gratuito o standard</li><li>Impostare le credenziali per un account {{site.data.keyword.Bluemix_notm}} per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer)</li><li>Rimuovere un cluster</li><li>Assegnare e modificare le politiche di accesso {{site.data.keyword.containershort_notm}}
per altri utenti esistenti in questo account.</li></ul><p>Quando impostato per un ID client specifico:<ul><li>Rimuovere un cluster specifico</li></ul></p>Politica di accesso all'infrastruttura corrispondente: super utente<br/><br/><strong>Nota</strong>: per creare le risorse come le macchine, le VLAN e le sottoreti, gli utenti hanno bisogno del ruolo **Super utente**.|<ul><li>Ruolo RBAC: amministratore del cluster</li><li>Accesso in lettura/scrittura alle risorse in ogni spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li><li>Accesso al dashboard Kubernetes</li><li>Creare una risorsa Ingress che renda le applicazioni disponibili pubblicamente.</li></ul>|
|Operatore|<ul><li>Aggiungere ulteriori nodi di lavoro a un cluster</li><li>Rimuovere nodi di lavoro da un cluster</li><li>Riavviare un nodo di lavoro</li><li>Ricaricare un nodo di lavoro</li><li>Aggiungere una sottorete a un cluster</li></ul><p>Politica di accesso all'infrastruttura corrispondente: [Personalizzato](#infra_access)</p>|<ul><li>Ruolo RBAC: amministratore</li><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito ma non allo spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li></ul>|
|Editor <br/><br/><strong>Suggerimento</strong>: utilizza questo ruolo per gli sviluppatori dell'applicazione.|<ul><li>Eseguire il bind di un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.</li><li>Annullare il bind di un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.</li><li>Creare un webhook.</li></ul><p>Politica di accesso all'infrastruttura corrispondente: [Personalizzato](#infra_access)|<ul><li>Ruolo RBAC: modifica</li><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito</li></ul></p>|
|Visualizzatore|<ul><li>Elencare un cluster</li><li>Visualizzare i dettagli per un cluster</li></ul><p>Politica di accesso all'infrastruttura corrispondente: solo visualizzazione</p>|<ul><li>Ruolo RBAC: visualizza</li><li>Accesso in lettura alle risorse nello spazio dei nomi predefinito</li><li>Nessun accesso in lettura ai segreti Kubernetes</li></ul>|

|Politica di accesso Cloud Foundry|Autorizzazioni di gestione dell'account|
|-------------|------------------------------|
|Ruolo organizzazione: gestore|<ul><li>Aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Ruolo spazio: sviluppatore|<ul><li>Creare le istanze del servizio {{site.data.keyword.Bluemix_notm}}</li><li>Eseguire il bind delle istanze del servizio {{site.data.keyword.Bluemix_notm}}
ai cluster</li></ul>| 

<br />



## Descrizione della chiave API IAM e del comando `bx cs credentials-set`
{: #api_key}

Per eseguire il provisioning e lavorare correttamente con i cluster nel tuo account, devi assicurarti che il tuo account sia configurato in modo appropriato per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer). A seconda della configurazione del tuo account, puoi utilizzare la chiave API IAM o le credenziali dell'infrastruttura che hai impostato manualmente usando il comando `bx cs credentials-set`.

<dl>
  <dt>Chiave API IAM</dt>
  <dd>La chiave API IAM (Identity and Access Management) viene impostata automaticamente per una regione quando viene eseguita la prima azione che richiede la politica di accesso come amministratore {{site.data.keyword.containershort_notm}}. Ad esempio, uno dei tuoi utenti amministratore crea il primo cluster nella regione <code>us-south</code>. In questo modo, la chiave API IAM di questo utente viene memorizzata nell'account per questa regione. La chiave API viene utilizzata per ordinare l'infrastruttura IBM Cloud (SoftLayer), come nuovi nodi di lavoro o VLAN. </br></br>
Quando un altro utente esegue un'azione in questa regione che richiede l'interazione con il portfolio dell'infrastruttura IBM Cloud (SoftLayer), come la creazione di un nuovo cluster o il ricaricamento di un nodo di lavoro, la chiave API memorizzata viene utilizzata per determinare se esistono autorizzazioni sufficienti per eseguire tale azione. Per garantire che le azioni relative all'infrastruttura nel tuo cluster possano essere eseguite correttamente, assegna ai tuoi utenti amministratore {{site.data.keyword.containershort_notm}} la politica di accesso all'infrastruttura <strong>Super utente</strong>. </br></br>Puoi trovare il proprietario della chiave API corrente eseguendo [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Se ritieni di dover aggiornare la chiave API memorizzata per una regione, puoi farlo eseguendo il comando [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Questo comando richiede la politica di accesso come amministratore {{site.data.keyword.containershort_notm}} e memorizza la chiave API dell'utente che esegue questo comando nell'account. </br></br> <strong>Nota:</strong> la chiave API memorizzata per la regione potrebbe non essere utilizzata se le credenziali dell'infrastruttura IBM Cloud (SoftLayer) sono state impostate manualmente utilizzando il comando <code>bx cs credentials-set</code>. </dd>
<dt>Credenziali dell'infrastruttura IBM Cloud (SoftLayer) tramite <code>bx cs credentials-set</code></dt>
<dd>Se hai un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}, hai accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer) per impostazione predefinita. Tuttavia, potresti voler utilizzare un altro account dell'infrastruttura IBM Cloud (SoftLayer) di cui già disponi per ordinare l'infrastruttura. Puoi collegare questo account dell'infrastruttura al tuo account {{site.data.keyword.Bluemix_notm}} utilizzando il comando [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set). </br></br>Se le credenziali dell'infrastruttura IBM Cloud (SoftLayer) vengono impostate manualmente, queste credenziali sono utilizzate per ordinare l'infrastruttura, anche se esiste già una chiave API IAM per l'account. Se l'utente di cui sono state memorizzate le credenziali non dispone delle autorizzazioni necessarie per ordinare l'infrastruttura, le azioni relative all'infrastruttura, come la creazione di un cluster o il ricaricamento di un nodo di lavoro, possono avere esito negativo. </br></br> Per rimuovere le credenziali dell'infrastruttura IBM Cloud (SoftLayer) che erano state impostate manualmente, puoi utilizzare il comando [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Dopo aver rimosso le credenziali, viene utilizzata la chiave API IAM per ordinare l'infrastruttura. </dd>
</dl>

## Aggiunta di utenti a un account {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Puoi aggiungere utenti a un account {{site.data.keyword.Bluemix_notm}} per concedere l'accesso ai tuoi cluster.
{:shortdesc}

Prima di iniziare, verifica che ti sia stato assegnato il ruolo Gestore di Cloud Foundry per un account {{site.data.keyword.Bluemix_notm}}.

1.  [Aggiungi l'utente all'account](../iam/iamuserinv.html#iamuserinv).
2.  Nella sezione **Accesso**, espandi **Servizi**.
3.  Assegna un ruolo di accesso {{site.data.keyword.containershort_notm}}. Dall'elenco a discesa **Assegna accesso a**, decidi se vuoi concedere l'accesso solo al tuo account {{site.data.keyword.containershort_notm}} (**Risorse**) o a una raccolta di varie risorse nel tuo account (**Gruppo di risorse**).
  -  Per **Risorsa**:
      1. Dall'elenco a discesa **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
      2. Dall'elenco a discesa **Regione**, seleziona la regione in cui invitare l'utente. **Nota**: per l'accesso ai cluster nella [regione Asia Pacifico Nord](cs_regions.html#locations), vedi [Concessione dell'accesso IAM agli utenti per i cluster all'interno della regione Asia Pacifico Nord](#iam_cluster_region).
      3. Dall'elenco a discesa **Istanza del servizio**, seleziona il cluster da cui invitare l'utente. Per trovare l'ID di uno specifico cluster, esegui `bx cs clusters`.
      4. Nella sezione **Seleziona ruoli**, scegli un ruolo. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Autorizzazioni e politiche di accesso](#access_policies).
  - Per **Gruppo di risorse**:
      1. Dall'elenco a discesa **Gruppo di risorse**, seleziona il gruppo di risorse che include le autorizzazioni per la risorsa {{site.data.keyword.containershort_notm}} del tuo account.
      2. Dall'elenco a discesa **Assegna accesso a un gruppo di risorse**, seleziona un ruolo. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Autorizzazioni e politiche di accesso](#access_policies).
4. [Facoltativo: assegna un ruolo Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. [Facoltativo: assegna un ruolo dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission).
6. Fai clic su **Invita utenti**.

<br />


### Concessione dell'accesso IAM agli utenti per i cluster all'interno della regione Asia Pacifico Nord
{: #iam_cluster_region}

Quando [aggiungi utenti al tuo account {{site.data.keyword.Bluemix_notm}}](#add_users), selezioni le regioni alle quali concedere loro l'accesso. Tuttavia, alcune regioni, come Asia Pacifico Nord, potrebbero non essere disponibili nella console e devono essere aggiunte utilizzando la CLI.
{:shortdesc}

Prima di iniziare, verifica di essere un amministratore per l'account {{site.data.keyword.Bluemix_notm}}.

1.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Seleziona l'account che vuoi utilizzare.

    ```
    bx login [--sso]
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

2.  Scegli l'ambiente a cui desideri concedere le autorizzazioni, ad esempio la regione Asia Pacifico Nord (`jp-tok`). Per ulteriori dettagli sulle opzioni di comando come organizzazione e spazio, vedi il [comando `bluemix target`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target).

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  Ottieni il nome o gli ID dei cluster della regione a cui vuoi concedere l'accesso.

    ```
    bx cs clusters
    ```
    {: pre}

4.  Ottieni gli ID utente a cui vuoi concedere l'accesso.

    ```
    bx account users
    ```
    {: pre}

5.  Seleziona i ruoli per la politica di accesso.

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  Concedi all'utente l'accesso al cluster con il ruolo appropriato. Questo esempio assegna a `user@example.com` i ruoli `Operator` ed `Editor` per tre cluster.

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    Per concedere l'accesso ai cluster esistenti e futuri nella regione, non specificare l'indicatore `--service-instance`. Per ulteriori informazioni, vedi il [comando `bluemix iam user-policy-create`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create).
    {:tip}

## Personalizzazione delle autorizzazioni dell'infrastruttura per un utente
{: #infra_access}

Quando imposti le politiche dell'infrastruttura in IAM (Identity and Access Management), a un utente vengono assegnate le autorizzazioni associate a un ruolo. Per personalizzare tali autorizzazioni, devi accedere all'infrastruttura IBM Cloud (SoftLayer) e modificare lì le autorizzazioni.
{: #view_access}

Ad esempio, gli **Utenti di base** possono riavviare un nodo di lavoro ma non possono ricaricarlo. Senza concedere le autorizzazioni di **Super utente** a tale persona, puoi modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) e aggiungere l'autorizzazione per eseguire un comando di ricaricamento.

1.  Accedi al tuo [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e seleziona **Infrastruttura** dal menu.

2.  Vai a **Account** > **Utenti** > **Elenco utenti**.

3.  Per modificare le autorizzazioni, seleziona il nome di un profilo utente o la colonna **Accesso al dispositivo**.

4.  Nella scheda **Autorizzazioni portale**, personalizza l'accesso dell'utente. Le autorizzazioni necessarie agli utenti dipendono dalle risorse di infrastruttura di cui hanno bisogno:

    * Utilizza l'elenco a discesa **Autorizzazioni rapide** per assegnare il ruolo di **Super utente**, che concede all'utente tutte le autorizzazioni.
    * Utilizza l'elenco a discesa **Autorizzazioni rapide** per assegnare il ruolo di **Utente di base**, che concede all'utente solo alcune autorizzazioni necessarie.
    * Se non vuoi concedere tutte le autorizzazioni con il ruolo di **Super utente** o devi aggiungere autorizzazioni al di sopra del ruolo di **Utente di base**, esamina la seguente tabella che descrive le autorizzazioni necessarie per eseguire attività comuni in {{site.data.keyword.containershort_notm}}.

    <table summary="Autorizzazioni dell'infrastruttura per scenari comuni di {{site.data.keyword.containershort_notm}}.">
     <caption>Autorizzazioni dell'infrastruttura comunemente richieste per {{site.data.keyword.containershort_notm}}</caption>
     <thead>
     <th>Attività comuni in {{site.data.keyword.containershort_notm}}</th>
     <th>Autorizzazioni dell'infrastruttura richieste per scheda</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>Autorizzazioni minime</strong>: <ul><li>Crea un cluster.</li></ul></td>
     <td><strong>Dispositivi</strong>:<ul><li>Visualizza i dettagli del server virtuale</li><li>Riavvia il server e visualizza le informazioni di sistema IPMI</li><li>Emetti i ricaricamenti SO e avvia il kernel di salvataggio</li></ul><strong>Account</strong>: <ul><li>Aggiungi/Aggiorna istanze cloud</li><li>Aggiungi server</li></ul></td>
     </tr>
     <tr>
     <td><strong>Amministrazione cluster</strong>: <ul><li>Crea, aggiorna ed elimina i cluster.</li><li>Aggiungi, ricarica e riavvia i nodi di lavoro.</li><li>Visualizza le VLAN.</li><li>Crea sottoreti.</li><li>Distribuisci i pod e i servizi di bilanciamento del carico.</li></ul></td>
     <td><strong>Supporto</strong>:<ul><li>Visualizza ticket</li><li>Aggiungi ticket</li><li>Modifica ticket</li></ul>
     <strong>Dispositivi</strong>:<ul><li>Visualizza i dettagli del server virtuale</li><li>Riavvia il server e visualizza le informazioni di sistema IPMI</li><li>Aggiorna server</li><li>Emetti i ricaricamenti SO e avvia il kernel di salvataggio</li></ul>
     <strong>Servizi</strong>:<ul><li>Gestisci chiavi SSH</li></ul>
     <strong>Account</strong>:<ul><li>Visualizza riepilogo account</li><li>Aggiungi/Aggiorna istanze cloud</li><li>Annulla server</li><li>Aggiungi server</li></ul></td>
     </tr>
     <tr>
     <td><strong>Archiviazione</strong>: <ul><li>Crea attestazioni del volume persistente per il provisioning di volumi persistenti.</li><li>Crea e gestisci risorse dell'infrastruttura di archiviazione.</li></ul></td>
     <td><strong>Servizi</strong>:<ul><li>Gestisci archiviazione</li></ul><strong>Account</strong>:<ul><li>Aggiungi archiviazione</li></ul></td>
     </tr>
     <tr>
     <td><strong>Rete privata</strong>: <ul><li>Gestisci le VLAN private per la rete in cluster</li><li>Configura la connettività VPN per le reti private.</li></ul></td>
     <td><strong>Rete</strong>:<ul><li>Gestisci le rotte di sottorete della rete</li><li>Gestisci lo spanning della VLAN di rete</li><li>Gestisci i tunnel di rete IPSEC</li><li>Gestisci gateway di rete</li><li>Amministrazione VPN</li></ul></td>
     </tr>
     <tr>
     <td><strong>Rete pubblica</strong>:<ul><li>Configura la rete Ingress o programma di bilanciamento del carico pubblica per esporre le applicazioni.</li></ul></td>
     <td><strong>Dispositivi</strong>:<ul><li>Gestisci programmi di bilanciamento del carico</li><li>Modifica nome host/dominio</li><li>Gestisci controllo porta</li></ul>
     <strong>Rete</strong>:<ul><li>Aggiungi calcoli con la porta di rete pubblica</li><li>Gestisci le rotte di sottorete della rete</li><li>Gestisci lo spanning della VLAN di rete</li><li>Aggiungi indirizzi IP</li></ul>
     <strong>Servizi</strong>:<ul><li>Gestisci DNS, DNS inverso e WHOIS</li><li>Visualizza certificati (SSL)</li><li>Gestisci certificati (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  Per salvare le modifiche, fai clic su **Modifica autorizzazioni del portale**.

6.  Nella scheda **Accesso al dispositivo**, seleziona i dispositivi a cui concedere l'accesso.

    * Nel menu a discesa **Tipo di dispositivo**, puoi concedere l'accesso a **Tutti i server virtuali**.
    * Per consentire agli utenti di accedere ai nuovi dispositivi che vengono creati, seleziona **Accesso concesso automaticamente quando vengono aggiunti nuovi dispositivi**.
    * Per salvare le modifiche, fai clic su **Aggiorna accesso dispositivo**.

7.  Ritorna all'elenco dei profili utente e verifica che sia stato concesso l'**Accesso al dispositivo**.

## Autorizzazione di utenti con ruoli personalizzati di RBAC Kubernetes 
{: #rbac}

Le politiche di accesso di {{site.data.keyword.containershort_notm}} corrispondono ad alcuni ruoli RBAC (role-based access control) di Kubernetes, come descritto in [Autorizzazioni e politiche di accesso](#access_policies). Per autorizzare altri ruoli Kubernetes che differiscono dalla politica di accesso corrispondente, puoi personalizzare i ruoli RBAC e quindi assegnare i ruoli a singoli individui o gruppi di utenti.
{: shortdesc}

Ad esempio, potresti voler concedere le autorizzazioni a un gruppo di sviluppatori affinché possano lavorare su un determinato gruppo API o con risorse all'interno di uno spazio dei nomi Kubernetes nel cluster, ma non nell'intero cluster. Dovrai creare un ruolo e quindi associare il ruolo agli utenti, utilizzando un nome utente che sia univoco per {{site.data.keyword.containershort_notm}}. Per informazioni più dettagliate, vedi [Using RBAC Authorization ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) nella documentazione di Kubernetes.

Prima di iniziare, [indirizza la CLI Kubernetes al cluster](cs_cli_install.html#cs_cli_configure).

1.  Crea un ruolo con l'accesso che vuoi assegnare.

    1. Crea un file `.yaml` per definire un ruolo con l'accesso che vuoi assegnare.

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
        <caption>Tabella. Descrizione dei componenti di questo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Utilizza `Role` per concedere l'accesso alle risorse all'interno di un singolo spazio dei nomi o `ClusterRole` per le risorse a livello di cluster.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successiva, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Per il tipo `Role`: specifica lo spazio dei nomi Kubernetes a cui è concesso l'accesso.</li><li>Non utilizzare il campo `namespace` se stai creando un `ClusterRole` che si applica a livello di cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Assegna un nome al ruolo e utilizza il nome in seguito quando associ il ruolo.</td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>Specifica i gruppi di API Kubernetes con i quali vuoi che gli utenti possano interagire, ad esempio `"apps"`, `"batch"` o `"extensions"`. </li><li>Per l'accesso al gruppo API principale nel percorso REST `api/v1`, lascia il gruppo vuoto: `[""]`.</li><li>Per ulteriori informazioni, vedi [API groups![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/api-overview/#api-groups) nella documentazione di Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>Specifica le risorse Kubernetes a cui vuoi concedere l'accesso, ad esempio `"daemonsets"`, `"deployments"`, `"events"` o `"ingresses"`.</li><li>Se specifichi `"nodes"`, il tipo di ruolo deve essere `ClusterRole`.</li><li>Per un elenco di risorse, vedi la tabella di [Tipi di risorse ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) nella pagina di aiuto di Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>Specifica i tipi di azioni che vuoi che gli utenti siano in grado di eseguire, ad esempio `"get"`, `"list"`, `"describe"`, `"create"` o `"delete"`. </li><li>Per un elenco completo di verbi, vedi la [documentazione `kubectl` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  Crea il ruolo nel tuo cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Verifica che il ruolo sia stato creato.

        ```
        kubectl get roles
        ```
        {: pre}

2.  Associa gli utenti al ruolo.

    1. Crea un file `.yaml` per associare gli utenti al ruolo. Nota l'URL univoco da utilizzare per il nome di ogni soggetto.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Tabella. Descrizione dei componenti di questo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Specifica il `kind` come `RoleBinding` per entrambi i tipi di file `.yaml` dei ruoli: `Role` per lo spazio dei nomi e `ClusterRole` a livello di cluster.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successiva, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Per il tipo `Role`: specifica lo spazio dei nomi Kubernetes a cui è concesso l'accesso.</li><li>Non utilizzare il campo `namespace` se stai creando un `ClusterRole` che si applica a livello di cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Fornisci un nome per l'associazione del ruolo.</td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>Specifica il tipo come `User`.</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>Aggiungi l'indirizzo e-mail dell'utente al seguente URL: `https://iam.ng.bluemix.net/kubernetes#`.</li><li>Ad esempio, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>Utilizza `rbac.authorization.k8s.io`.</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>Immetti lo stesso valore del `kind` nel file `.yaml` del ruolo: `Role` o `ClusterRole`.</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>Immetti il nome del file `.yaml` del ruolo.</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>Utilizza `rbac.authorization.k8s.io`.</td>
        </tr>
        </tbody>
        </table>

    2. Crea la risorsa di associazione del ruolo nel tuo cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Verifica che l'associazione sia stata creata.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Ora che hai creato e associato un ruolo RBAC Kubernetes personalizzato, occupati degli utenti. Chiedi loro di testare un'azione per la quale dispongono dell'autorizzazione grazie al ruolo, come l'eliminazione di un pod.
