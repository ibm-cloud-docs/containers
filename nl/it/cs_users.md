---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Assegnazione dell'accesso al cluster
{: #users}

Come amministratore del cluster, puoi definire le politiche di accesso per il tuo cluster Kubernetes per creare livelli diversi di accesso per utenti differenti. Ad esempio, puoi autorizzare determinati utenti a lavorare con le risorse cluster mentre altri possono solo distribuire i contenitori.
{: shortdesc}


## Descrizione delle autorizzazioni e delle politiche di accesso
{: #access_policies}

<dl>
  <dt>Devo impostare le politiche di accesso?</dt>
    <dd>Devi definire le politiche di accesso per ogni utente che lavora con {{site.data.keyword.containerlong_notm}}. L'ambito di una politica di accesso si basa su un ruolo o sui ruoli definiti dagli utenti che determinano le azioni che essi possono eseguire. Alcune politiche sono predefinite, ma altre possono essere personalizzate. Si applica la stessa politica se l'utente esegue la richiesta dalla GUI {{site.data.keyword.containerlong_notm}} oppure tramite la CLI, anche quando le azioni vengono completate nell'infrastruttura IBM Cloud (SoftLayer).</dd>

  <dt>Quali sono i tipi di autorizzazioni?</dt>
    <dd><p><strong>Piattaforma</strong>: {{site.data.keyword.containerlong_notm}} è configurato per utilizzare i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} per determinare le azioni che i singoli utenti possono eseguire su un cluster. Le autorizzazioni ruolo si sviluppano l'una sull'altra, ciò significa che il ruolo `Editor` ha tutte le stesse autorizzazioni del ruolo `Visualizzatore`, più le autorizzazioni concesse ad un editor. Puoi impostare queste politiche in base alla regione. Queste politiche devono essere configurate insieme alle politiche dell'infrastruttura e avere dei ruoli RBAC corrispondenti che vengono assegnati automaticamente allo spazio dei nomi predefinito. Alcune azioni di esempio sono la creazione o la rimozione di cluster oppure l'aggiunta di nodi di lavoro extra.</p> <p><strong>Infrastruttura</strong>: puoi determinare i livelli di accesso per la tua infrastruttura come ad esempio le macchine del nodo cluster, la rete o le risorse di archiviazione. Devi impostare questo tipo di politica insieme alle politiche di accesso alla piattaforma {{site.data.keyword.containerlong_notm}}. Per informazioni sui ruoli disponibili, controlla le [autorizzazioni dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission). In aggiunta alla concessione di ruoli dell'infrastruttura specifici, devi anche concedere l'accesso al dispositivo agli utenti che utilizzano l'infrastruttura. Per iniziare ad assegnare i ruoli, segui la procedura presente in [Personalizzazione delle autorizzazioni dell'infrastruttura per un utente](#infra_access). <strong>Nota</strong>: assicurati che il tuo account {{site.data.keyword.Bluemix_notm}} sia [configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials) in modo che gli utenti autorizzati possano eseguire azioni nell'account dell'infrastruttura IBM Cloud (SoftLayer) in base alle autorizzazioni assegnate.</p> <p><strong>RBAC</strong>: RBAC (role-based access control) è un modo per proteggere le tue risorse che si trovano all'interno del tuo cluster e per decidere quali utenti possono eseguire i diversi tipi di azioni Kubernetes.A ogni utente a cui è assegnata una politica di accesso alla piattaforma viene assegnato automaticamente un ruolo Kubernetes. In Kubernetes, [RBAC (Role Based Access Control) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) determina le azioni che un utente può eseguire sulle risorse all'interno di un cluster. <strong>Nota</strong>: i ruoli RBAC sono automaticamente configurati insieme al ruolo della piattaforma per lo spazio dei nomi predefinito. In qualità di amministratore del cluster, puoi [aggiornare o assegnare i ruoli](#rbac) per altri spazi dei nomi.</p> <p><strong> Cloud Foundry </strong>: non tutti i servizi possono essere gestiti con Cloud IAM. Se stai utilizzando uno di questi servizi, puoi continuare a utilizzare i [ruoli utente Cloud Foundry](/docs/iam/cfaccess.html#cfaccess) per controllare l'accesso ai tuoi servizi. Le azioni di esempio sono il bind di un servizio o la creazione di una nuova istanza del servizio.</p></dd>

  <dt>Come possono impostare le autorizzazioni?</dt>
    <dd><p>Quando imposti le autorizzazioni Piattaforma, puoi assegnare l'accesso a uno specifico utente, un gruppo di utenti o al gruppo di risorse default. Quando imposti le autorizzazioni Piattaforma, i ruoli RBAC vengono configurati automaticamente per lo spazio dei nomi predefinito e viene creato un RoleBinding.</p>
    <p><strong>Utenti</strong>: potresti avere un utente specifico che ha bisogno di più o meno autorizzazioni rispetto al resto del tuo team. Puoi personalizzare le autorizzazioni su base singola in modo che ogni persona abbia la giusta quantità di autorizzazioni di cui ha bisogno per completare la propria attività.</p>
    <p><strong>Gruppi di accesso</strong>: puoi creare gruppi di utenti e quindi assegnare le autorizzazioni a un gruppo specifico. Ad esempio, puoi raggruppare tutti i responsabili dei team e fornire a tale gruppo l'accesso di amministratore. Allo stesso tempo, invece, il tuo gruppo di sviluppatori ha solo l'accesso in scrittura.</p>
    <p><strong>Gruppi di risorse</strong>: con IAM, puoi creare delle politiche di accesso per un gruppo di risorse e concedere agli utenti l'accesso a questo gruppo. Queste risorse possono essere parte di un servizio {{site.data.keyword.Bluemix_notm}} o puoi anche raggruppare le risorse tra le istanze del servizio, come ad esempio un cluster {{site.data.keyword.containerlong_notm}} e un'applicazione CF.</p> <p>**Importante**: {{site.data.keyword.containerlong_notm}} supporta solo il gruppo di risorse <code>default</code> . Tutte le risorse correlate al cluster vengono rese automaticamente disponibili nel gruppo di risorse <code>default</code>. Se hai altri servizi nel tuo account {{site.data.keyword.Bluemix_notm}} che desideri utilizzare con il tuo cluster, i servizi devono essere anche nel gruppo di risorse <code>default</code>.</p></dd>
</dl>


Ti senti sopraffatto? Prova questa esercitazione sulle [procedure consigliate per organizzare utenti, team e applicazioni](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)
{: #api_key}

<dl>
  <dt>Perché ho bisogno dell'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)?</dt>
    <dd>Per eseguire il provisioning e lavorare correttamente con i cluster nel tuo account, devi assicurarti che il tuo account sia configurato in modo appropriato per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer). A seconda della configurazione del tuo account, puoi utilizzare la chiave API IAM o le credenziali dell'infrastruttura che hai impostato manualmente usando il comando `ibmcloud ks credentials-set`.</dd>

  <dt>Come funziona la chiave API IAM con {{site.data.keyword.containerlong_notm}}?</dt>
    <dd><p>La chiave API IAM (Identity and Access Management) viene impostata automaticamente per una regione quando viene eseguita la prima azione che richiede la politica di accesso come amministratore {{site.data.keyword.containerlong_notm}}. Ad esempio, uno dei tuoi utenti amministratore crea il primo cluster nella regione <code>us-south</code>. In questo modo, la chiave API IAM di questo utente viene memorizzata nell'account per questa regione. La chiave API viene utilizzata per ordinare l'infrastruttura IBM Cloud (SoftLayer), come nuovi nodi di lavoro o VLAN.</p> <p>Quando un altro utente esegue un'azione in questa regione che richiede l'interazione con il portfolio dell'infrastruttura IBM Cloud (SoftLayer), come la creazione di un nuovo cluster o il ricaricamento di un nodo di lavoro, la chiave API memorizzata viene utilizzata per determinare se esistono autorizzazioni sufficienti per eseguire tale azione. Per garantire che le azioni correlate all'infrastruttura nel tuo cluster possano essere eseguite correttamente, assegna ai tuoi utenti amministratore {{site.data.keyword.containerlong_notm}} la politica di accesso all'infrastruttura <strong>Super utente</strong>.</p> <p>Puoi trovare il proprietario della chiave API attuale eseguendo [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Se ritieni di dover aggiornare la chiave API memorizzata per una regione, puoi farlo eseguendo il comando [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Questo comando richiede la politica di accesso come amministratore {{site.data.keyword.containerlong_notm}} e memorizza la chiave API dell'utente che esegue questo comando nell'account. La chiave API memorizzata per la regione potrebbe non essere utilizzata se le credenziali dell'infrastruttura IBM Cloud (SoftLayer) sono state impostate manualmente utilizzando il comando <code>ibmcloud ks credentials-set</code>.</p> <p><strong>Note:</strong> assicurati di reimpostare la chiave e di comprendere l'impatto sulla tua applicazione. La chiave viene utilizzata in diverse ubicazioni e può causare delle modifiche che provocano interruzioni, se viene modificata senza che sia necessario.</p></dd>

  <dt>Cosa fa il comando <code>ibmcloud ks credentials-set</code>?</dt>
    <dd><p>Se hai un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}, hai accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer) per impostazione predefinita. Tuttavia, potresti voler utilizzare un altro account dell'infrastruttura IBM Cloud (SoftLayer) di cui già disponi per ordinare l'infrastruttura per i cluster in una regione. Puoi collegare questo account dell'infrastruttura al tuo account {{site.data.keyword.Bluemix_notm}} utilizzando il comando [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set).</p> <p>Per rimuovere le credenziali dell'infrastruttura IBM Cloud (SoftLayer) che erano state impostate manualmente, puoi utilizzare il comando [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Dopo aver rimosso le credenziali, viene utilizzata la chiave API IAM per ordinare l'infrastruttura.</p></dd>

  <dt>C'è una differenza tra le credenziali dell'infrastruttura e la chiave API?</dt>
    <dd>Sia la chiave API che il comando <code>ibmcloud ks credentials-set</code> realizzano la stessa attività. Se imposti manualmente le credenziali con il comando <code>ibmcloud ks credentials-set</code>, le credenziali impostate sovrascrivono qualsiasi accesso concesso dalla chiave API. Tuttavia, se l'utente di cui sono state memorizzate le credenziali non dispone delle autorizzazioni necessarie per ordinare l'infrastruttura, le azioni correlate all'infrastruttura, come la creazione di un cluster o il ricaricamento di un nodo di lavoro, possono avere esito negativo.</dd>
    
  <dt>Come faccio a sapere se le mie credenziali di account dell'infrastruttura sono impostate per utilizzare un account diverso?</dt>
    <dd>Apri la [GUI {{site.data.keyword.containerlong_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/containers-kubernetes/clusters) e seleziona il tuo cluster. Nella scheda **Panoramica**, cerca un campo **Utente infrastruttura**. Se vedi tale campo, non utilizzare le credenziali dell'infrastruttura predefinite fornite con il tuo account Pagamento a consumo in questa regione. La regione è invece impostata per utilizzare delle credenziali dell'account dell'infrastruttura differenti.</dd>

  <dt>C'è un modo per rendere più facile l'assegnazione delle autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer)?</dt>
    <dd><p>Gli utenti di norma non hanno bisogno di specifiche autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer). Configura invece la chiave API con le autorizzazioni dell'infrastruttura corrette e utilizza tale chiave API in ciascuna regione in cui desideri creare e utilizzare i cluster. La chiave API può appartenere al proprietario dell'account, a un ID funzionale oppure a un utente, a seconda di cosa sia più facile per te da gestire e controllare. </p> <p>Se vuoi creare un cluster in una nuova regione, assicurati che il primo cluster venga creato dal proprietario della chiave API che tu hai configurato con le corrette credenziali dell'infrastruttura. Successivamente, puoi invitare singoli utenti, gruppi IAM o utenti dell'account di servizio a tale regione. Gli utenti nell'account condividono le credenziali della chiave API per eseguire azioni dell'infrastruttura, come ad esempio l'aggiunta di nodi di lavoro. Per controllare quali sono le azioni dell'infrastruttura che un utente può eseguire, assegna il ruolo {{site.data.keyword.containerlong_notm}} appropriato in IAM.</p><p>Ad esempio, un utente con un ruolo IAM `Viewer` non è autorizzato ad aggiungere un nodo di lavoro. Pertanto, l'azione `worker-add` non riesce, anche se la chiave API ha le autorizzazioni dell'infrastruttura corrette. Se modifichi il ruolo utente in `Operator` in IAM, l'utente è autorizzato ad aggiungere un nodo di lavoro. L'azione `worker-add` riesce perché il ruolo utente è autorizzato e la chiave API è impostata correttamente. Non hai bisogno di modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer).</p> <p>Per ulteriori informazioni sull'impostazione delle autorizzazioni, controlla [Personalizzazione delle autorizzazioni dell'infrastruttura per un utente](#infra_access)</p></dd>
</dl>


<br />



## Descrizione delle relazioni di ruolo
{: #user-roles}

Prima di poter comprendere quale ruolo può eseguire ciascuna azione, è importante comprendere in che modo i ruoli si integrano tra loro.
{: shortdesc}

La seguente immagine mostra i ruoli di cui ogni tipo di persona nella tua organizzazione potrebbe aver bisogno. Tuttavia, la cosa è diversa per ogni organizzazione. Potresti notare che alcuni utenti richiedono delle autorizzazioni personalizzate per l'infrastruttura. Assicurati di leggere attentamente [Accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](#api_key) per informazioni su quali sono le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) e su quali sono le autorizzazioni di cui hanno bisogno gli specifici utenti. 

![{{site.data.keyword.containerlong_notm}} - ruoli di accesso](/images/user-policies.png)

Figura. Autorizzazioni di accesso {{site.data.keyword.containerlong_notm}} per tipo di ruolo

<br />



## Assegnazione dei ruoli con la GUI
{: #add_users}

Puoi aggiungere utenti a un account {{site.data.keyword.Bluemix_notm}} per concedere l'accesso ai tuoi cluster con la GUI.
{: shortdesc}

**Prima di iniziare**

- Verifica che il tuo utente venga aggiunto all'account. In caso negativo, [aggiungilo](../iam/iamuserinv.html#iamuserinv).
- Verifica che ti sia stato assegnato il ruolo di `Gestore` di [Cloud Foundry](/docs/iam/mngcf.html#mngcf) per l'account {{site.data.keyword.Bluemix_notm}} in cui stai lavorando.

**Per assegnare l'accesso a un utente**

1. Passa a **Gestisci > Utenti**. Viene visualizzato un elenco degli utenti con accesso all'account.

2. Fare clic sul nome dell'utente per cui vuoi impostare le autorizzazioni. Se l'utente non viene visualizzato, fai clic su **Invita utenti** per eseguirne l'aggiunta all'account.

3. Assegna una politica.
  * Per un gruppo di risorse:
    1. Seleziona il gruppo di risorse **default**. L'accesso {{site.data.keyword.containerlong_notm}} può essere configurato solo per il gruppo di risorse default.
  * Per una risorsa specifica:
    1. Dall'elenco **Servizi**, seleziona **{{site.data.keyword.containerlong_notm}}**.
    2. Dall'elenco **Regione**, seleziona una regione.
    3. Dall'elenco **Istanza del servizio**, seleziona il cluster a cui invitare l'utente. Per trovare l'ID di un cluster specifico, esegui `ibmcloud ks clusters`.

4. Nella sezione **Seleziona ruoli**, scegli un ruolo. 

5. Fai clic su **Assegna**.

6. Assegna un [ruolo Cloud Foundry](/docs/iam/mngcf.html#mngcf).

7. Facoltativo: assegna un [ruolo dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission).

</br>

**Per assegnare l'accesso a un gruppo**

1. Passa a **Gestisci > Gruppi di accesso**.

2. Crea un gruppo di accesso.
  1. Fai clic su **Crea** e dai al tuo gruppo un **Nome** e una **Descrizione**. Fai clic su **Crea**.
  2. Fai clic su **Aggiungi utenti** per aggiungere persone al tuo gruppo di accesso. Viene visualizzato un elenco degli utenti che hanno accesso al tuo account.
  3. Seleziona la casella accanto agli utenti che vuoi aggiungere al gruppo. Viene visualizzata una finestra di dialogo.
  4. Fai clic su **Aggiungi al gruppo**.

3. Per assegnare l'accesso a un servizio specifico, aggiungi un ID servizio.
  1. Fai clic su **Aggiungi ID servizio**.
  2. Seleziona la casella accanto agli utenti che vuoi aggiungere al gruppo. Viene visualizzata una finestra a comparsa.
  3. Fai clic su **Aggiungi al gruppo**.

4. Assegna le politiche di accesso. Non dimenticarti di ricontrollare le persone che aggiungi al tuo gruppo. A tutti nel gruppo viene fornito lo stesso livello di accesso.
    * Per un gruppo di risorse:
        1. Seleziona il gruppo di risorse **default**. L'accesso {{site.data.keyword.containerlong_notm}} può essere configurato solo per il gruppo di risorse default.
    * Per una risorsa specifica:
        1. Dall'elenco **Servizi**, seleziona **{{site.data.keyword.containerlong_notm}}**.
        2. Dall'elenco **Regione**, seleziona una regione.
        3. Dall'elenco **Istanza del servizio**, seleziona il cluster a cui invitare l'utente. Per trovare l'ID di un cluster specifico, esegui `ibmcloud ks clusters`.

5. Nella sezione **Seleziona ruoli**, scegli un ruolo. 

6. Fai clic su **Assegna**.

7. Assegna un [ruolo Cloud Foundry](/docs/iam/mngcf.html#mngcf).

8. Facoltativo: assegna un [ruolo dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission).

<br />



## Assegnazione di ruoli con la CLI
{: #add_users_cli}

Puoi aggiungere utenti a un account {{site.data.keyword.Bluemix_notm}} per concedere l'accesso ai tuoi cluster con la CLI.
{: shortdesc}

**Prima di iniziare**

Verifica che ti sia stato assegnato il ruolo di `Gestore` di [Cloud Foundry](/docs/iam/mngcf.html#mngcf) per l'account {{site.data.keyword.Bluemix_notm}} in cui stai lavorando.

**Per assegnare l'accesso a uno specifico utente**

1. Invita l'utente al tuo account.
  ```
  ibmcloud account user-invite <user@email.com>
  ```
  {: pre}
2. Crea una politica di accesso IAM per impostare le autorizzazioni per {{site.data.keyword.containerlong_notm}}. Puoi scegliere tra Visualizzatore, Editor, Operatore e Amministratore per il ruolo.
  ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

**Per assegnare l'accesso a un gruppo**

1. Se l'utente non fa già parte del tuo account, invitalo.
  ```
  ibmcloud account user-invite <user_email>
  ```
  {: pre}

2. Crea un gruppo.
  ```
  ibmcloud iam access-group-create <team_name>
  ```
  {: pre}

3. Aggiungi l'utente al gruppo.
  ```
  ibmcloud iam access-group-user-add <team_name> <user_email>
  ```
  {: pre}

4. Aggiungi l'utente al gruppo.Puoi scegliere tra Visualizzatore, Editor, Operatore e Amministratore per il ruolo.
  ```
  ibmcloud iam access-group-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

5. Aggiorna la tua configurazione del cluster per generare un RoleBinding.
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  RoleBinding:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <binding>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <role>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <group_name>
    namespace: default
  ```
  {: screen}

Le istruzioni precedenti mostrano come dare a un gruppo di utenti l'accesso a tutte le risorse {{site.data.keyword.containerlong_notm}}. In quanto amministratore, puoi anche limitare l'accesso al servizio a livello di istanza cluster o regione.
{: tip}

<br />


## Autorizzazione di utenti con i bind del ruolo RBAC
{: #role-binding}

Ogni cluster è configurato con ruoli RBAC predefiniti che sono configurati per lo spazio dei nomi predefinito del tuo cluster. Puoi copiare i ruoli RBAC dallo spazio dei nomi predefinito ad altri spazi dei nomi nel tuo cluster per implementare lo stesso livello di accesso utente.

**Cos'è un RoleBinding (bind del ruolo) RBAC?**

Un bind del ruolo è una politica di accesso specifica per le risorse Kubernetes. Puoi utilizzare i bind del ruolo per impostare le politiche specifiche per spazi dei nomi, pod o altre risorse all'interno del tuo cluster. {{site.data.keyword.containerlong_notm}} fornisce dei ruoli RBAC predefiniti che corrispondono ai ruoli della piattaforma in IAM. Quando assegni un ruolo della piattaforma IAM a un utente, per l'utente viene automaticamente creato un bind del ruolo RBAC nello spazio dei nomi predefinito del cluster.

**Cos'è un bind del ruolo del cluster RBAC?**

Mentre un bind del ruolo RBAC è specifico per una singola risorsa, come uno spazio dei nomi o un pod, un bind del ruolo del cluster RBAC può essere utilizzato per impostare le autorizzazioni a un livello di cluster che include tutti gli spazi dei nomi.I bind del ruolo del cluster vengono creati automaticamente per lo spazio dei nomi predefinito quando vengono impostati i ruoli della piattaforma. Puoi copiare tale bind del ruolo in altri spazi dei nomi.


<table>
  <tr>
    <th>Ruolo piattaforma</th>
    <th>Ruolo RBAC</th>
    <th>Bind del ruolo</th>
  </tr>
  <tr>
    <td>Visualizzatore</td>
    <td>Visualizzatore</td>
    <td><code>ibm-view</code></td>
  </tr>
  <tr>
    <td>Editor</td>
    <td>Editor</td>
    <td><code>ibm-edit</code></td>
  </tr>
  <tr>
    <td>Operatore</td>
    <td>Amministratore</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Amministratore</td>
    <td>Amministratore cluster</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

**Ci sono dei requisiti specifici quando si lavora con i RoleBinding (bind del ruolo)?**

Per lavorare con i grafici IBM Helm, devi installare Tiller nello spazio dei nomi `kube-system`. Per installare Tiller, devi disporre del [ruolo `cluster-admin`](cs_users.html#access_policies)
nello spazio dei nomi `kube-system`. Per altri grafici Helm, puoi scegliere un altro spazio dei nomi. Tuttavia, quando esegui un comando `helm`, devi utilizzare l'indicatore `tiller-namespace <namespace>` per puntare allo spazio dei nomi in cui è installato Tiller.


### Copia di un RoleBinding (bind del ruolo) RBAC

Quando configuri le tue politiche della piattaforma, viene automaticamente generato un bind del ruolo del cluster per lo spazio dei nomi predefinito. Puoi copiare il bind in altri spazi dei nomi aggiornando il bind con lo spazio dei nomi per cui vuoi impostare la politica. Supponiamo, ad esempio, che hai un gruppo di sviluppatori denominato `team-a` e che essi abbiano l'accesso in visualizzazione (`view`) nell'ambito del servizio ma che abbiano bisogno dell'accesso in modifica (`edit`) allo spazio dei nomi `teama`. Puoi modificare il RoleBinding (bind del ruolo) generato automaticamente per dare loro quello di cui hanno bisogno a livello di risorsa.

1. Crea un bind del ruolo RBAC per lo spazio dei nomi predefinito [assegnando l'accesso con un ruolo della piattaforma](#add_users_cli).
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}
  Output di esempio:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. Copia tale configurazione in un altro spazio dei nomi.
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role> --namespace <namespace>
  ```
  {: pre}
  Nello scenario precedente, ho apportato una modifica alla configurazione per un altro spazio dei nomi. La configurazione sarà simile alla seguente:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### Creazione di ruoli RBAC Kubernetes personalizzati
{: #rbac}

Per autorizzare altri ruoli Kubernetes che differiscono dalla politica di accesso alla piattaforma corrispondente, puoi personalizzare i ruoli RBAC e quindi assegnare i ruoli a singoli individui o gruppi di utenti.
{: shortdesc}

Hai bisogno che le tue politiche di accesso al cluster siano più dettagliate di quanto consentito da una politica IAM? Nessun problema! Puoi assegnare delle politiche di accesso per specifiche risorse Kubernetes a utenti, gruppi o utenti (in cluster che eseguono Kubernetes v1.11 o successive) o account di servizio. Puoi creare un ruolo e quindi eseguirne il bind a utenti specifici o a un gruppo. Per ulteriori informazioni, vedi [Using RBAC Authorization ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) nella documentazione di Kubernetes.

Quando viene creato, un bind per un gruppo influenza qualsiasi utente aggiunto a, o rimosso da, tale gruppo. Se aggiungi un utente al gruppo, anch'egli ha l'accesso aggiuntivo. Se viene rimosso, il suo accesso viene rimosso.
{: tip}

Se vuoi assegnare l'accesso a un servizio, come una toolchain di fornitura continua, puoi utilizzare gli [account di servizio Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

**Prima di iniziare**

- Indirizza la [CLI Kubernetes](cs_cli_install.html#cs_cli_configure) al tuo cluster.
- Assicurati che l'utente o il gruppo abbia come minimo l'accesso `Visualizzatore` a livello del servizio.


**Per personalizzare i ruoli RBAC**

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
        <caption>Descrizione dei componenti di questo YAML</caption>
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
              <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successive, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
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
              <td><ul><li>Specifica i gruppi di API Kubernetes con i quali vuoi che gli utenti possano interagire, ad esempio `"apps"`, `"batch"` o `"extensions"`. </li><li>Per l'accesso al gruppo API principale nel percorso REST `api/v1`, lascia il gruppo vuoto: `[""]`.</li><li>Per ulteriori informazioni, vedi [API groups![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) nella documentazione di Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>Specifica le risorse Kubernetes a cui vuoi concedere l'accesso, ad esempio `"daemonsets"`, `"deployments"`, `"events"` o `"ingresses"`.</li><li>Se specifichi `"nodes"`, il tipo di ruolo deve essere `ClusterRole`.</li><li>Per un elenco di risorse, vedi la tabella di [Tipi di risorse ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) nella pagina di aiuto di Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>Specifica i tipi di azioni che vuoi che gli utenti siano in grado di eseguire, ad esempio `"get"`, `"list"`, `"describe"`, `"create"` o `"delete"`. </li><li>Per un elenco completo di verbi, vedi la [documentazione `kubectl`![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/).</li></ul></td>
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
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
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
        <caption>Descrizione dei componenti di questo YAML</caption>
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
              <td><ul><li>Per i cluster che eseguono Kubernetes 1.8 o successive, utilizza `rbac.authorization.k8s.io/v1`. </li><li>Per le versioni precedenti, utilizza `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
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
              <td>Specifica il tipo come uno dei seguenti:
              <ul><li>`User`: esegui il bind del ruolo RBAC a un singolo utente nel tuo account.</li>
              <li>`Group`: per i cluster che eseguono Kubernetes 1.11 o successive, esegui il bind del ruolo RBAC a un [gruppo IAM](/docs/iam/groups.html#groups) nel tuo account.</li>
              <li>`ServiceAccount`: esegui il bind del ruolo RBAC a un account di servizio in uno spazio dei nomi nel tuo cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**Per `User`**: accoda l'indirizzo email del singolo utente al seguente URL: `https://iam.ng.bluemix.net/kubernetes#`. Ad esempio, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Per `Group`**: per i cluster che eseguono Kubernetes 1.11 o successive, specifica il nome del [gruppo IAM](/docs/iam/groups.html#groups) nel tuo account.</li>
              <li>**Per `ServiceAccount`**: specifica il nome dell'account di servizio.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>**Per `User` o `Group`**: utilizza `rbac.authorization.k8s.io`.</li>
              <li>**Per `ServiceAccount`**: non includere questo campo.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/namespace</code></td>
              <td>**Solo per `ServiceAccount`**: specifica il nome dello spazio dei nomi Kubernetes in cui viene distribuito l'account di servizio.</td>
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
        kubectl apply -f filepath/my_role_binding.yaml
        ```
        {: pre}

    3.  Verifica che l'associazione sia stata creata.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Ora che hai creato e associato un ruolo RBAC Kubernetes personalizzato, occupati degli utenti. Chiedi loro di testare un'azione per la quale dispongono dell'autorizzazione grazie al ruolo, come l'eliminazione di un pod.


<br />



## Personalizzazione delle autorizzazioni dell'infrastruttura per un utente
{: #infra_access}

Quando imposti le politiche dell'infrastruttura in IAM (Identity and Access Management), a un utente vengono assegnate le autorizzazioni associate a un ruolo. Alcune politiche sono predefinite, ma altre possono essere personalizzate. Per personalizzare tali autorizzazioni, devi accedere all'infrastruttura IBM Cloud (SoftLayer) e modificare lì le autorizzazioni.
{: #view_access}

Ad esempio, gli **Utenti di base** possono riavviare un nodo di lavoro ma non possono ricaricarlo. Senza concedere le autorizzazioni di **Super utente** a tale persona, puoi modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) e aggiungere l'autorizzazione per eseguire un comando di ricaricamento.

Se hai dei cluster multizona, il tuo proprietario dell'account dell'infrastruttura IBM Cloud (SoftLayer) deve attivare lo spanning delle VLAN in modo che i nodi in zone differenti possano comunicare all'interno del cluster. Il proprietario dell'account può anche assegnare a un utente l'autorizzazione **Rete > Gestisci il VLAN Spanning di rete** in modo che l'utente possa abilitare lo spanning delle VLAN. Per controllare se lo spanning della VLAN è già abilitato, utilizza il [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}


1.  Accedi al tuo [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/) e seleziona **Infrastruttura** dal menu.

2.  Vai a **Account** > **Utenti** > **Elenco utenti**.

3.  Per modificare le autorizzazioni, seleziona il nome di un profilo utente o la colonna **Accesso al dispositivo**.

4.  Nella scheda **Autorizzazioni portale**, personalizza l'accesso dell'utente. Le autorizzazioni necessarie agli utenti dipendono dalle risorse di infrastruttura di cui hanno bisogno:

    * Utilizza l'elenco a discesa **Autorizzazioni rapide** per assegnare il ruolo di **Super utente**, che concede all'utente tutte le autorizzazioni.
    * Utilizza l'elenco a discesa **Autorizzazioni rapide** per assegnare il ruolo di **Utente di base**, che concede all'utente solo alcune autorizzazioni necessarie.
    * Se non vuoi concedere tutte le autorizzazioni con il ruolo di **Super utente** o devi aggiungere autorizzazioni al di sopra del ruolo di **Utente di base**, esamina la seguente tabella che descrive le autorizzazioni necessarie per eseguire attività comuni in {{site.data.keyword.containerlong_notm}}.

    <table summary="Autorizzazioni dell'infrastruttura per scenari comuni di {{site.data.keyword.containerlong_notm}}.">
     <caption>Autorizzazioni dell'infrastruttura comunemente richieste per {{site.data.keyword.containerlong_notm}}</caption>
     <thead>
      <th>Attività comuni in {{site.data.keyword.containerlong_notm}}</th>
      <th>Autorizzazioni dell'infrastruttura richieste per scheda</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>Autorizzazioni minime</strong>: <ul><li>Crea un cluster.</li></ul></td>
         <td><strong>Dispositivi</strong>:<ul><li>Visualizza i dettagli di Virtual Server</li><li>Riavvia il server e visualizza le informazioni di sistema IPMI</li><li>Emetti i ricaricamenti SO e avvia il kernel di salvataggio</li></ul><strong>Account</strong>: <ul><li>Aggiungi/Aggiorna istanze cloud</li><li>Aggiungi server</li></ul></td>
       </tr>
       <tr>
         <td><strong>Amministrazione cluster</strong>: <ul><li>Crea, aggiorna ed elimina i cluster.</li><li>Aggiungi, ricarica e riavvia i nodi di lavoro.</li><li>Visualizza le VLAN.</li><li>Crea sottoreti.</li><li>Distribuisci i pod e i servizi di bilanciamento del carico.</li></ul></td>
         <td><strong>Supporto</strong>:<ul><li>Visualizza ticket</li><li>Aggiungi ticket</li><li>Modifica ticket</li></ul>
         <strong>Dispositivi</strong>:<ul><li>Visualizza i dettagli di Virtual Server</li><li>Riavvia il server e visualizza le informazioni di sistema IPMI</li><li>Aggiorna server</li><li>Emetti i ricaricamenti SO e avvia il kernel di salvataggio</li></ul>
         <strong>Servizi</strong>:<ul><li>Gestisci chiavi SSH</li></ul>
         <strong>Account</strong>:<ul><li>Visualizza riepilogo account</li><li>Aggiungi/Aggiorna istanze cloud</li><li>Annulla server</li><li>Aggiungi server</li></ul></td>
       </tr>
       <tr>
         <td><strong>Archiviazione</strong>: <ul><li>Crea attestazioni del volume persistente per il provisioning di volumi persistenti.</li><li>Crea e gestisci risorse dell'infrastruttura di archiviazione.</li></ul></td>
         <td><strong>Servizi</strong>:<ul><li>Gestisci archiviazione</li></ul><strong>Account</strong>:<ul><li>Aggiungi archiviazione</li></ul></td>
       </tr>
       <tr>
         <td><strong>Rete privata</strong>: <ul><li>Gestisci le VLAN private per la rete in cluster</li><li>Configura la connettività VPN per le reti private.</li></ul></td>
         <td><strong>Rete</strong>:<ul><li>Gestisci le rotte di sottorete della rete</li><li>Gestisci i tunnel di rete IPSEC</li><li>Gestisci gateway di rete</li><li>Amministrazione VPN</li></ul></td>
       </tr>
       <tr>
         <td><strong>Rete pubblica</strong>:<ul><li>Configura la rete Ingress o programma di bilanciamento del carico pubblica per esporre le applicazioni.</li></ul></td>
         <td><strong>Dispositivi</strong>:<ul><li>Gestisci Load Balancers</li><li>Modifica nome host/dominio</li><li>Gestisci controllo porta</li></ul>
         <strong>Rete</strong>:<ul><li>Aggiungi calcoli con la porta di rete pubblica</li><li>Gestisci le rotte di sottorete della rete</li><li>Aggiungi indirizzi IP</li></ul>
         <strong>Servizi</strong>:<ul><li>Gestisci DNS, DNS inverso e WHOIS</li><li>Visualizza certificati (SSL)</li><li>Gestisci certificati (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  Per salvare le modifiche, fai clic su **Modifica autorizzazioni del portale**.

6.  Nella scheda **Accesso al dispositivo**, seleziona i dispositivi a cui concedere l'accesso.

    * Nel menu a discesa **Tipo di dispositivo**, puoi concedere l'accesso a **Tutti i server virtuali**.
    * Per consentire agli utenti di accedere ai nuovi dispositivi che vengono creati, seleziona **Accesso concesso automaticamente quando vengono aggiunti nuovi dispositivi**.
    * Per salvare le modifiche, fai clic su **Aggiorna accesso dispositivo**.

Downgrade delle autorizzazioni? Il completamento di questa operazione può richiedere alcuni minuti.
{: tip}

<br />

