---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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

Puoi concedere l'accesso a un cluster per altri utenti nella tua organizzazione per assicurarti che
solo gli utenti autorizzati possano utilizzare il cluster e distribuire le applicazioni al cluster.
{:shortdesc}


## Gestione dell'accesso al cluster
{: #managing}

A ogni utente che lavora con {{site.data.keyword.containershort_notm}} deve essere assegnata una combinazione di ruoli utente specifici per il sevizio
che determina quali azioni può eseguire un utente.
{:shortdesc}

<dl>
<dt>politiche di accesso
{{site.data.keyword.containershort_notm}}</dt>
<dd>In IAM (Identity and Access Management), le politiche di accesso {{site.data.keyword.containershort_notm}} determinano le azioni di gestione cluster che puoi eseguire su un
cluster, come la creazione o rimozione dei cluster e l'aggiunta o la rimozione di nodi di lavoro supplementari. Queste politiche devono essere configurate insieme alle politiche dell'infrastruttura.</dd>
<dt>Politiche di accesso all'infrastruttura</dt>
<dd>In IAM (Identity and Access Management), le politiche di accesso all'infrastruttura consentono il completamento delle azioni richieste dall'interfaccia utente
{{site.data.keyword.containershort_notm}} dalla CLI nell'infrastruttura IBM Cloud (SoftLayer). Queste politiche devono essere configurate insieme alle politiche di accesso {{site.data.keyword.containershort_notm}}. [Ulteriori informazioni sui ruoli](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Gruppi di risorse </dt>
<dd>Un gruppo di risorse è un modo per organizzare i servizi {{site.data.keyword.Bluemix_notm}} in raggruppamenti in modo da poter assegnare rapidamente agli utenti l'accesso a più di una risorsa alla volta. [Scopri come gestire gli utenti utilizzando i gruppi di risorse](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Ruoli Cloud Foundry</dt>
<dd>In IAM (Identity and Access Management), a ogni utente deve essere assegnato un ruolo Cloud Foundry. Questo ruolo
determina le azioni che l'utente può eseguire sull'account {{site.data.keyword.Bluemix_notm}}, come l'invito di altri utenti
o la visualizzazione dell'utilizzo della quota. [Ulteriori informazioni sui ruoli Cloud Foundry disponibili](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Ruoli RBAC Kubernetes</dt>
<dd>Ad ogni utente a cui è assegnata una politica di accesso {{site.data.keyword.containershort_notm}} viene assegnato automaticamente un
ruolo RBAC. In Kubernetes, i ruoli RBAC determinano le azioni che puoi eseguire sulle risorse Kubernetes
all'interno del cluster. I ruoli RBAC vengono configurati solo per lo spazio dei nomi predefinito. L'amministratore del cluster
può aggiungere i ruoli RBAC per gli altri spazi dei nomi nel cluster. Consulta  [Using RBAC Authorization ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) nella documentazione Kubernetes per ulteriori informazioni.</dd>
</dl>

<br />


## Autorizzazioni e politiche di accesso 
{: #access_policies}

Esamina le politiche di accesso e le autorizzazioni che puoi concedere agli utenti nel tuo account {{site.data.keyword.Bluemix_notm}}. I ruoli operatore e editor hanno autorizzazioni separate. Se vuoi, ad esempio, che un utente aggiunga nodi di lavoro ed esegua il bind dei servizi, devi assegnare all'utente sia il ruolo di operatore che di editor. Se scegli una politica di accesso dell'utente, {{site.data.keyword.containershort_notm}} elimina le politiche RBAC associate alla modifica nel tuo cluster per tuo conto.

|Politica di accesso {{site.data.keyword.containershort_notm}} |Autorizzazioni di gestione del cluster |Autorizzazioni delle risorse Kubernetes |
|-------------|------------------------------|-------------------------------|
|Amministratore|Questo ruolo eredita le autorizzazioni dai ruoli editor, operatore e visualizzatore
per tutti i cluster in questo account. <br/><br/>Quando impostato per tutte le istanze del servizio:<ul><li>Creare un cluster gratuito o standard </li><li>Impostare le credenziali per un account {{site.data.keyword.Bluemix_notm}} per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer)</li><li>Rimuovere un cluster</li><li>Assegnare e modificare le politiche di accesso {{site.data.keyword.containershort_notm}}
per altri utenti esistenti in questo account.</li></ul><p>Quando impostato per un ID client specifico:<ul><li>Rimuovere un cluster specifico </li></ul></p>Politica di accesso all'infrastruttura corrispondente: super utente<br/><br/><b>Nota</b>: per creare le risorse come le macchine, le VLAN e le sottoreti, gli utenti hanno bisogno del ruolo **Super utente**.|<ul><li>Ruolo RBAC: amministratore del cluster</li><li>Accesso in lettura/scrittura alle risorse in ogni spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li><li>Accesso al dashboard Kubernetes</li><li>Creare una risorsa Ingress che renda le applicazioni disponibili pubblicamente.</li></ul>|
|Operatore|<ul><li>Aggiungere ulteriori nodi di lavoro a un cluster</li><li>Rimuovere nodi di lavoro da un cluster</li><li>Riavviare un nodo di lavoro</li><li>Ricaricare un nodo di lavoro</li><li>Aggiungere una sottorete a un cluster</li></ul><p>Politica di accesso all'infrastruttura corrispondente: utente di base </p>|<ul><li>Ruolo RBAC: amministratore</li><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito ma non allo spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li></ul>|
|Editor <br/><br/><b>Suggerimento</b>: utilizza questo ruolo per gli sviluppatori dell'applicazione.|<ul><li>Eseguire il bind di un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.</li><li>Annullare il bind di un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.</li><li>Creare un webhook.</li></ul><p>Politica di accesso all'infrastruttura corrispondente: utente di base |<ul><li>Ruolo RBAC: modifica</li><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito</li></ul></p>|
|Visualizzatore|<ul><li>Elencare un cluster</li><li>Visualizzare i dettagli per un cluster</li></ul><p>Politica di accesso all'infrastruttura corrispondente: solo visualizzazione</p>|<ul><li>Ruolo RBAC: visualizza</li><li>Accesso in lettura alle risorse nello spazio dei nomi predefinito</li><li>Nessun accesso in lettura ai segreti Kubernetes</li></ul>|

|Politica di accesso Cloud Foundry|Autorizzazioni di gestione dell'account |
|-------------|------------------------------|
|Ruolo organizzazione: gestore|<ul><li>Aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Ruolo spazio: sviluppatore|<ul><li>Creare le istanze del servizio {{site.data.keyword.Bluemix_notm}} </li><li>Eseguire il bind delle istanze del servizio {{site.data.keyword.Bluemix_notm}}
ai cluster</li></ul>| 

<br />


## Aggiunta di utenti a un account {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Puoi aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}} per concedere loro l'accesso ai tuoi cluster.

Prima di iniziare, verifica che ti sia stato assegnato il ruolo Gestore di Cloud Foundry per un account {{site.data.keyword.Bluemix_notm}}.

1.  [Aggiungi l'utente all'account](../iam/iamuserinv.html#iamuserinv).
2.  Nella sezione **Accesso**, espandi **Servizi**.
3.  Assegna un ruolo di accesso {{site.data.keyword.containershort_notm}}. Dall'elenco a discesa **Assegna accesso a**, decidi se vuoi concedere l'accesso solo al tuo account {{site.data.keyword.containershort_notm}} (**Risorse**) o a una raccolta di varie risorse nel tuo account (**Gruppo di risorse**).
  -  Per **Risorsa**:
      1. Dall'elenco a discesa **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
      2. Dall'elenco a discesa **Regione**, seleziona la regione in cui invitare l'utente. 
      3. Dall'elenco a discesa **Istanza del servizio**, seleziona il cluster da cui invitare l'utente. Per trovare l'ID di uno specifico cluster, esegui `bx cs clusters`.
      4. Nella sezione **Seleziona ruoli**, scegli un ruolo. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Accesso alle politiche e alle autorizzazioni](#access_policies).
  - Per **Gruppo di risorse**:
      1. Dall'elenco a discesa **Gruppo di risorse**, seleziona il gruppo di risorse che include le autorizzazioni per la risorsa {{site.data.keyword.containershort_notm}} del tuo account.
      2. Dall'elenco a discesa **Assegna accesso a un gruppo di risorse**, seleziona un ruolo. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Accesso alle politiche e alle autorizzazioni](#access_policies).
4. [Facoltativo: assegna un ruolo dell'infrastruttura](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Facoltativo: assegna un ruolo Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. Fai clic su **Invita utenti**.

<br />


## Personalizzazione delle autorizzazioni dell'infrastruttura per un utente 
{: #infra_access}

Quando configuri le politiche dell'infrastruttura in IAM (Identity and Access Management), a un utente vengono fornite le autorizzazioni associate a un ruolo. Per personalizzare queste autorizzazioni, devi accedere all'infrastruttura IBM Cloud (SoftLayer) e modificare lì le autorizzazioni.
{: #view_access}

Ad esempio, gli utenti di base possono riavviare un nodo di lavoro ma non possono ricaricarlo. Senza fornire a questa persona le autorizzazioni da super utente, puoi modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) e aggiungere l'autorizzazione ad eseguire il comando di ricaricamento.

1.  Accedi al tuo account dell'infrastruttura IBM Cloud (SoftLayer).
2.  Seleziona un profilo utente da aggiornare.
3.  In **Autorizzazioni portale**, personalizza l'accesso dell'utente. Ad esempio, per aggiungere l'autorizzazione di ricaricamento, nella scheda **Dispositivi**, seleziona **Emetti i ricaricamenti SO e avvia il kernel di salvataggio**.
9.  Salva le modifiche.
