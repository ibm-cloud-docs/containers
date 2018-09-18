---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"


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
    <dd>Devi definire le politiche di accesso per ogni utente che lavora con {{site.data.keyword.containershort_notm}}. L'ambito di una politica di accesso si basa su un ruolo o sui ruoli definiti dagli utenti che determinano le azioni che essi possono eseguire. Alcune politiche sono predefinite, ma altre possono essere personalizzate. Si applica la stessa politica se l'utente esegue la richiesta dalla GUI {{site.data.keyword.containershort_notm}} oppure tramite la CLI, anche quando le azioni vengono completate nell'infrastruttura IBM Cloud (SoftLayer).</dd>

  <dt>Quali sono i tipi di autorizzazioni?</dt>
    <dd><p><strong>Piattaforma</strong>: {{site.data.keyword.containershort_notm}} è configurato per utilizzare i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} per determinare le azioni che i singoli utenti possono eseguire su un cluster. Le autorizzazioni ruolo si sviluppano l'una sull'altra, ciò significa che il ruolo `Editor` ha tutte le stesse autorizzazioni del ruolo `Visualizzatore`, più le autorizzazioni concesse ad un editor. Puoi impostare queste politiche in base alla regione. Queste politiche devono essere configurate insieme alle politiche dell'infrastruttura e avere dei ruoli RBAC corrispondenti che vengono assegnati automaticamente allo spazio dei nomi predefinito. Alcune azioni di esempio sono la creazione o la rimozione di cluster oppure l'aggiunta di nodi di lavoro extra.</p> <p><strong>Infrastruttura</strong>: puoi determinare i livelli di accesso per la tua infrastruttura come ad esempio le macchine del nodo cluster, la rete o le risorse di archiviazione. Devi impostare questo tipo di politica insieme alle politiche di accesso alla piattaforma {{site.data.keyword.containershort_notm}}. Per informazioni sui ruoli disponibili, controlla le [autorizzazioni dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission). In aggiunta alla concessione di ruoli dell'infrastruttura specifici, devi anche concedere l'accesso al dispositivo agli utenti che utilizzano l'infrastruttura. Per iniziare ad assegnare i ruoli, segui la procedura presente in [Personalizzazione delle autorizzazioni dell'infrastruttura per un utente](#infra_access). <strong>Nota</strong>: assicurati che il tuo account {{site.data.keyword.Bluemix_notm}} sia [configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials) in modo che gli utenti autorizzati possano eseguire azioni nell'account dell'infrastruttura IBM Cloud (SoftLayer) in base alle autorizzazioni assegnate. </p> <p><strong>RBAC</strong>: RBAC (resource-based access control) costituisce un modo per proteggere le tue risorse che si trovano all'interno del tuo cluster e per decidere quali utenti possono eseguire i diversi tipi di azioni Kubernetes.A ogni utente a cui è assegnata una politica di accesso alla piattaforma viene assegnato automaticamente un ruolo Kubernetes. In Kubernetes, [RBAC (Role Based Access Control) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) determina le azioni che un utente può eseguire sulle risorse all'interno di un cluster. <strong>Nota</strong>: i ruoli RBAC sono automaticamente configurati insieme al ruolo della piattaforma per lo spazio dei nomi predefinito. In qualità di amministratore del cluster, puoi [aggiornare o assegnare i ruoli](#rbac) per altri spazi dei nomi.</p> <p><strong> Cloud Foundry </strong>: non tutti i servizi possono essere gestiti con Cloud IAM. Se stai utilizzando uno di questi servizi, puoi continuare a utilizzare i [ruoli utente Cloud Foundry](/docs/iam/cfaccess.html#cfaccess) per controllare l'accesso ai tuoi servizi. Le azioni di esempio sono il bind di un servizio o la creazione di una nuova istanza del servizio.</p></dd>

  <dt>Come possono impostare le autorizzazioni?</dt>
    <dd><p>Quando imposti le autorizzazioni Piattaforma, puoi assegnare l'accesso a uno specifico utente, un gruppo di utenti o al gruppo di risorse default. Quando imposti le autorizzazioni Piattaforma, i ruoli RBAC vengono configurati automaticamente per lo spazio dei nomi predefinito e viene creato un RoleBinding. </p>
    <p><strong>Utenti</strong>: potresti avere un utente specifico che ha bisogno di più o meno autorizzazioni rispetto al resto del tuo team. Puoi personalizzare le autorizzazioni su base singola in modo che ogni persona abbia la giusta quantità di autorizzazioni di cui ha bisogno per completare la propria attività.</p>
    <p><strong>Gruppi di accesso</strong>: puoi creare gruppi di utenti e quindi assegnare le autorizzazioni a un gruppo specifico. Ad esempio, puoi raggruppare tutti i responsabili dei team e fornire a tale gruppo l'accesso di amministratore. Allo stesso tempo, invece, il tuo gruppo di sviluppatori ha solo l'accesso in scrittura.</p>
    <p><strong>Gruppi di risorse</strong>: con IAM, puoi creare delle politiche di accesso per un gruppo di risorse e concedere agli utenti l'accesso a questo gruppo. Queste risorse possono essere parte di un servizio {{site.data.keyword.Bluemix_notm}} o puoi anche raggruppare le risorse tra le istanze del servizio, come ad esempio un cluster {{site.data.keyword.containershort_notm}} e un'applicazione CF.</p> <p>**Importante**: {{site.data.keyword.containershort_notm}} supporta solo il gruppo di risorse <code>default</code> . Tutte le risorse correlate al cluster vengono rese automaticamente disponibili nel gruppo di risorse <code>default</code>. Se hai altri servizi nel tuo account {{site.data.keyword.Bluemix_notm}} che desideri utilizzare con il tuo cluster, i servizi devono essere anche nel gruppo di risorse <code>default</code>.</p></dd>
</dl>


Ti senti sopraffatto? Prova questa esercitazione sulle [procedure consigliate per organizzare utenti, team e applicazioni](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)
{: #api_key}

<dl>
  <dt>Perché ho bisogno dell'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer)?</dt>
    <dd>Per eseguire il provisioning e lavorare correttamente con i cluster nel tuo account, devi assicurarti che il tuo account sia configurato in modo appropriato per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer). A seconda della configurazione del tuo account, puoi utilizzare la chiave API IAM o le credenziali dell'infrastruttura che hai impostato manualmente usando il comando `ibmcloud ks credentials-set`.</dd>

  <dt>Come funziona la chiave API IAM con il servizio Container?</dt>
    <dd><p>La chiave API IAM (Identity and Access Management) viene impostata automaticamente per una regione quando viene eseguita la prima azione che richiede la politica di accesso come amministratore {{site.data.keyword.containershort_notm}}. Ad esempio, uno dei tuoi utenti amministratore crea il primo cluster nella regione <code>us-south</code>. In questo modo, la chiave API IAM di questo utente viene memorizzata nell'account per questa regione. La chiave API viene utilizzata per ordinare l'infrastruttura IBM Cloud (SoftLayer), come nuovi nodi di lavoro o VLAN.</p> <p>Quando un altro utente esegue un'azione in questa regione che richiede l'interazione con il portfolio dell'infrastruttura IBM Cloud (SoftLayer), come la creazione di un nuovo cluster o il ricaricamento di un nodo di lavoro, la chiave API memorizzata viene utilizzata per determinare se esistono autorizzazioni sufficienti per eseguire tale azione. Per garantire che le azioni correlate all'infrastruttura nel tuo cluster possano essere eseguite correttamente, assegna ai tuoi utenti amministratore {{site.data.keyword.containershort_notm}} la politica di accesso all'infrastruttura <strong>Super utente</strong>.</p> <p>Puoi trovare il proprietario della chiave API attuale eseguendo [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Se ritieni di dover aggiornare la chiave API memorizzata per una regione, puoi farlo eseguendo il comando [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Questo comando richiede la politica di accesso come amministratore {{site.data.keyword.containershort_notm}} e memorizza la chiave API dell'utente che esegue questo comando nell'account. La chiave API memorizzata per la regione potrebbe non essere utilizzata se le credenziali dell'infrastruttura IBM Cloud (SoftLayer) sono state impostate manualmente utilizzando il comando <code>ibmcloud ks credentials-set</code>.</p> <p><strong>Note:</strong> assicurati di reimpostare la chiave e di comprendere l'impatto sulla tua applicazione. La chiave viene utilizzata in diverse ubicazioni e può causare delle modifiche che provocano interruzioni, se viene modificata senza che sia necessario.</p></dd>

  <dt>Cosa fa il comando <code>ibmcloud ks credentials-set</code>?</dt>
    <dd><p>Se hai un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}, hai accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer) per impostazione predefinita. Tuttavia, potresti voler utilizzare un altro account dell'infrastruttura IBM Cloud (SoftLayer) di cui già disponi per ordinare l'infrastruttura. Puoi collegare questo account dell'infrastruttura al tuo account {{site.data.keyword.Bluemix_notm}} utilizzando il comando [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set).</p> <p>Per rimuovere le credenziali dell'infrastruttura IBM Cloud (SoftLayer) che erano state impostate manualmente, puoi utilizzare il comando [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Dopo aver rimosso le credenziali, viene utilizzata la chiave API IAM per ordinare l'infrastruttura.</p></dd>

  <dt>C'è una differenza tra i due?</dt>
    <dd>Sia la chiave API che il comando <code>ibmcloud ks credentials-set</code> realizzano la stessa attività. Se imposti manualmente le credenziali con il comando <code>ibmcloud ks credentials-set</code>, le credenziali impostate sovrascrivono qualsiasi accesso concesso dalla chiave API. Tuttavia, se l'utente di cui sono state memorizzate le credenziali non dispone delle autorizzazioni necessarie per ordinare l'infrastruttura, le azioni correlate all'infrastruttura, come la creazione di un cluster o il ricaricamento di un nodo di lavoro, possono avere esito negativo. </dd>
</dl>


Per rendere un po' più facile la gestione delle chiavi API, prova a creare un ID funzionale che puoi utilizzare per impostare le autorizzazioni.
{: tip}

<br />



## Descrizione delle relazioni di ruolo
{: #user-roles}

Prima di poter comprendere quale ruolo può eseguire ciascuna azione, è importante comprendere in che modo i ruoli si integrano tra loro.
{: shortdesc}

La seguente immagine mostra i ruoli di cui ogni tipo di persona nella tua organizzazione potrebbe aver bisogno. Tuttavia, la cosa è diversa per ogni organizzazione.

![{{site.data.keyword.containershort_notm}} - ruoli di accesso](/images/user-policies.png)

Figura. Autorizzazioni di accesso {{site.data.keyword.containershort_notm}} per tipo di ruolo

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
    1. Seleziona il gruppo di risorse **default**. L'accesso {{site.data.keyword.containershort_notm}} può essere configurato solo per il gruppo di risorse default.
  * Per una risorsa specifica:
    1. Dall'elenco **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
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
        1. Seleziona il gruppo di risorse **default**. L'accesso {{site.data.keyword.containershort_notm}} può essere configurato solo per il gruppo di risorse default.
    * Per una risorsa specifica:
        1. Dall'elenco **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
        2. Dall'elenco **Regione**, seleziona una regione.
        3. Dall'elenco **Istanza del servizio**, seleziona il cluster a cui invitare l'utente. Per trovare l'ID di un cluster specifico, esegui `ibmcloud ks clusters`.

5. Nella sezione **Seleziona ruoli**, scegli un ruolo. 

6. Fai clic su **Assegna**.

7. Assegna un [ruolo Cloud Foundry](/docs/iam/mngcf.html#mngcf).

8. Facoltativo: assegna un [ruolo dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission).

<br />






## Autorizzazione di utenti con ruoli personalizzati di RBAC Kubernetes
{: #rbac}

Le politiche di accesso {{site.data.keyword.containershort_notm}} corrispondono a specifici ruoli RBAC (role-based access control) di Kubernetes. Per autorizzare altri ruoli Kubernetes che differiscono dalla politica di accesso corrispondente, puoi personalizzare i ruoli RBAC e quindi assegnare i ruoli a singoli individui o gruppi di utenti.
{: shortdesc}

In alcuni casi potresti aver bisogno di politiche di accesso più dettagliate di quanto potrebbe consentire una politica IAM. Nessun problema! Puoi assegnare le politiche di accesso per specifiche risorse Kubernetes per gli utenti o per i gruppi. Puoi creare un ruolo e quindi eseguirne il bind a utenti specifici o a un gruppo. Per ulteriori informazioni, vedi [Using RBAC Authorization ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) nella documentazione di Kubernetes.

Quando viene creato, un bind per un gruppo influenza qualsiasi utente aggiunto a, o rimosso da, tale gruppo. Se aggiungi un utente al gruppo, anch'egli ha l'accesso aggiuntivo. Se viene rimosso, il suo accesso viene rimosso.
{: tip}

Se vuoi assegnare l'accesso a un servizio, quale ad esempio l'integrazione continua con la pipeline di fornitura, puoi utilizzare gli [account di servizio Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

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
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: system:serviceaccount:<namespace>:<service_account_name>
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
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
              <td><ul><li>**Per i singoli utenti**: accoda l'indirizzo email dell'utente al seguente URL: `https://iam.ng.bluemix.net/kubernetes#`. Ad esempio, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Per gli account del servizio**: specifica lo spazio dei nomi e il nome del servizio. Ad esempio: `system:serviceaccount:<namespace>:<service_account_name>`</li></ul></td>
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
        kubectl apply -f filepath/my_role_team1.yaml
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

Se hai dei cluster multizona, il tuo proprietario dell'account dell'infrastruttura IBM Cloud (SoftLayer) deve attivare lo spanning delle VLAN in modo che i nodi in zone differenti possano comunicare all'interno del cluster. Il proprietario dell'account può anche assegnare a un utente l'autorizzazione **Rete > Gestisci lo spanning delle VLAN di rete** in modo che l'utente possa abilitare lo spanning delle VLAN.
{: tip}


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
         <td><strong>Dispositivi</strong>:<ul><li>Gestisci programmi di bilanciamento del carico</li><li>Modifica nome host/dominio</li><li>Gestisci controllo porta</li></ul>
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

