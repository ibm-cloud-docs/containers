---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Creazione dei contenitori dalle immagini
{: #images}

Un'immagine Docker è la base per ogni contenitore che crei con {{site.data.keyword.containerlong}}.
{:shortdesc}

Un'immagine viene creata da un
Dockerfile, che è un file che contiene le istruzioni per creare l'immagine. Nelle sue istruzioni, un Dockerfile potrebbe
fare riferimento alle risorse di build che vengono memorizzate separatamente, quali ad esempio un'applicazione, la configurazione
dell'applicazione e le relative dipendenze.



## Pianificazione dei registri di immagini
{: #planning}

Le immagini normalmente vengono archiviate in un registro ed è possibile accedervi pubblicamente (registro pubblico)
o configurarle con un accesso limitato a un piccolo gruppo di utenti (registro privato). 
{:shortdesc}

I registri pubblici,
come Docker Hub possono essere utilizzati come un'introduzione di Docker e Kubernetes per creare la tua prima
applicazione inserita in un contenitore in un cluster. Nel caso però di applicazioni aziendali, utilizza un registro privato,
come quello fornito in {{site.data.keyword.registryshort_notm}}, per proteggere le tue immagini dall'essere utilizzate e modificate da utenti non autorizzati. I registri privati
devono essere configurati dall'amministratore del cluster per assicurare che le credenziali di accesso al registro privato
siano disponibili agli utenti del cluster.


Puoi utilizzare più registri con {{site.data.keyword.containershort_notm}} per distribuire le applicazioni al tuo cluster.

|Registro|Descrizione|Vantaggi|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|Con questa opzione, puoi configurare il tuo proprio repository delle immagini Docker protetto in {{site.data.keyword.registryshort_notm}}
dove puoi archiviare e condividere le immagini in sicurezza tra gli utenti del cluster.|<ul><li>Gestisci l'accesso alle immagini nel tuo account.</li><li>Utilizza le applicazioni di esempio e le immagini fornite da
{{site.data.keyword.IBM_notm}}, come {{site.data.keyword.IBM_notm}} Liberty, come immagine principale e aggiungi il tuo proprio codice
ad esse.</li><li>Scansione automatica delle immagini per vulnerabilità potenziali dal Controllo vulnerabilità, incluse
le raccomandazioni di correzione specifiche del sistema operativo.</li></ul>|
|Ogni altro registro privato|Collega qualsiasi registro privato esistente al tuo cluster creando un [imagePullSecret ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/containers/images/). Il segreto viene utilizzato
per salvare in modo sicuro le tue credenziali e il tuo URL del registro in un segreto Kubernetes.|<ul><li>Utilizza i registri privati esistenti indipendentemente dalle loro origini (Docker Hub, registri di proprietà dell'organizzazione
o altri registri cloud privati).</li></ul>|
|Docker Hub pubblico|Utilizza questa opzione per utilizzare direttamente le immagini pubbliche esistenti da Docker Hub quando non è necessaria alcuna
modifica al Dockerfile. <p>**Nota:** tieni presente che questa opzione non rispetta i requisiti di sicurezza della tua organizzazione,
come la gestione dell'accesso, la scansione di vulnerabilità o la privacy dell'applicazione.</p>|<ul><li>Non è necessaria alcuna ulteriore configurazione per il tuo cluster.</li><li>Include varie applicazioni open source.</li></ul>|
{: caption="Tabella. Opzioni del registro delle immagini privato e pubblico" caption-side="top"}

Dopo che hai configurato un registro immagini, gli utenti del cluster possono utilizzare le immagini per le loro distribuzioni dell'applicazione al cluster.


<br />



## Accesso a uno spazio dei nomi in {{site.data.keyword.registryshort_notm}}
{: #namespace}

Puoi distribuire i contenitori al tuo cluster da un'immagine pubblica fornita da IBM o da un'immagine privata
memorizzata nel tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}.
{:shortdesc}

Prima di iniziare:

1. [Configura uno spazio dei nomi in {{site.data.keyword.registryshort_notm}} su {{site.data.keyword.Bluemix_notm}} pubblico o {{site.data.keyword.Bluemix_dedicated_notm}} e distribuisci le immagini in questo spazio dei nomi](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Crea un
cluster](cs_clusters.html#clusters_cli).
3. [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Quando crei un cluster, i segreti e i token del registro senza scadenza vengono creati automaticamente per [il registro regionale più vicino e il registro globale](/docs/services/Registry/registry_overview.html#registry_regions). Il registro globale archivia in modo sicuro le immagini fornite da IBM pubbliche a cui puoi fare riferimento nelle tue distribuzioni invece di avere riferimenti differenti per le immagini archiviate in ogni registro regionale. Il registro regionale archivia in modo sicuro le tue proprie immagini Docker, così come le stesse immagini pubbliche che vengono archiviate nel registro globale. I token sono utilizzati per autorizzare l'accesso in sola lettura a tutti i tuoi spazi dei nomi che hai configurato in {{site.data.keyword.registryshort_notm}} in modo che puoi utilizzare queste immagini pubbliche (registro globale) e private (registri regionali).

Ogni token deve essere memorizzato in un `imagePullSecret` Kubernetes per poter essere accessibile da un cluster Kubernetes
quando distribuisci un'applicazione inserita in un contenitore. Quando il tuo cluster viene creato, {{site.data.keyword.containershort_notm}} memorizza automaticamente i token per il registro globale (immagini pubbliche fornite da IBM) e il regionale nei segreti di pull dell'immagine Kubernetes. I segreti di pull dell'immagine sono aggiunti allo spazio dei nomi Kubernetes `default`, all'elenco predefinito dei segreti in `ServiceAccount` per tale spazio dei nomi e allo spazio dei nomi `kube-system`.

**Nota:** utilizzando questa configurazione iniziale, puoi distribuire i contenitori da qualsiasi immagine disponibile in
uno spazio dei nomi del tuo account {{site.data.keyword.Bluemix_notm}} allo
spazio dei nomi **predefinito** del tuo cluster. Se vuoi distribuire un contenitore in altri
spazi dei nomi del tuo cluster, o se vuoi utilizzare un'immagine memorizzata in un'altra regione {{site.data.keyword.Bluemix_notm}} o in un altro account {{site.data.keyword.Bluemix_notm}}, devi [creare il tuo proprio imagePullSecret per il cluster](#other).

Per distribuire un contenitore nello spazio dei nomi **predefinito** del tuo
cluster, crea un file di configurazione.

1.  Crea un file di configurazione di distribuzione denominato `mydeployment.yaml`.
2.  Definisci la distribuzione e l'immagine che vuoi utilizzare dal tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}.

    Per
utilizzare un'immagine privata da uno spazio dei nomi in {{site.data.keyword.registryshort_notm}}:

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **Suggerimento:** per richiamare le informazioni sul tuo spazio dei nomi, esegui `bx cr namespace-list`.

3.  Crea la distribuzione nel tuo cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Suggerimento:** puoi anche distribuire un file di configurazione esistente, come una delle immagini pubbliche fornite da IBM. Questo esempio utilizza l'immagine **ibmliberty** nella regione stati uniti sud.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}


<br />



## Accesso alle immagini in altri spazi dei nomi Kubernetes, regioni {{site.data.keyword.Bluemix_notm}} e account
{: #other}

Puoi distribuire i contenitori ad altri spazi dei nomi Kubernetes, utilizzare le immagini memorizzate in altre regioni o account {{site.data.keyword.Bluemix_notm}} o utilizzare le immagini memorizzate in {{site.data.keyword.Bluemix_dedicated_notm}} creando il tuo proprio imagePullSecret.
{:shortdesc}

Prima di iniziare:

1.  [Configura uno spazio dei nomi in {{site.data.keyword.registryshort_notm}} su {{site.data.keyword.Bluemix_notm}} pubblico o {{site.data.keyword.Bluemix_dedicated_notm}} e distribuisci le immagini in questo spazio dei nomi](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Crea un
cluster](cs_clusters.html#clusters_cli).
3.  [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Per creare il tuo proprio imagePullSecret:

**Nota:** segreti imagePullSecret sono validi solo per gli spazi dei nomi per i quali sono stati creati. Ripeti questa procedura
per ogni spazio dei nomi in cui vuoi distribuire i contenitori. Le immagini da [DockerHub](#dockerhub) non richiedono ImagePullSecrets.

1.  Se non hai un token, [crea un token per il registro a cui vuoi accedere.](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Elenca i token nel tuo account {{site.data.keyword.Bluemix_notm}}.

    ```
    bx cr token-list
    ```
    {: pre}

3.  Prendi nota dell'ID token che vuoi utilizzare.
4.  Richiama il valore per il tuo token. Sostituisci <em>&lt;token_id&gt;</em>
con l'ID del token che hai richiamato nel passo precedente.

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    Il valore del tuo token viene visualizzato
nel campo **Token** dell'output della tua CLI.

5.  Crea il segreto Kubernetes per memorizzare le informazioni sul token.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabella. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obbligatoria. Lo spazio dei nomi Kubernetes del cluster in cui vuoi utilizzare il segreto e a cui distribuire i contenitori. Esegui <code>kubectl get namespaces</code> per elencare tutti gli spazi dei nomi nel tuo cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Obbligatoria. Il nome che vuoi utilizzare per imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Obbligatoria. L'URL del registro delle immagini in cui è configurato il tuo spazio dei nomi.<ul><li>Per gli spazi dei nomi configurati in Stati Uniti Sud e Stati Uniti Est registry.ng.bluemix.net</li><li>Per gli spazi dei nomi configurati in Regno Unito Sud registry.eu-gb.bluemix.net</li><li>Per gli spazi dei nomi configurati in Europa centrale (Francoforte) registry.eu-de.bluemix.net</li><li>Per gli spazi dei nomi configurati in Australia (Sydney) registry.au-syd.bluemix.net</li><li>Per gli spazi dei nomi configurati nel registro {{site.data.keyword.Bluemix_dedicated_notm}}.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Obbligatoria. Il nome utente per accedere al tuo registro privato. Per {{site.data.keyword.registryshort_notm}}, il nome utente è impostato su <code>token</code>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Obbligatoria. Il valore del tuo token di registro che hai richiamato in precedenza.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Obbligatoria. Se ne hai uno, immetti il tuo indirizzo e-mail Docker. Se non hai uno, immetti un indirizzo e-mail fittizio, come ad esempio a@b.c. Questa e-mail è obbligatoria per creare un segreto Kubernetes, ma non viene utilizzata dopo la creazione.</td>
    </tr>
    </tbody></table>

6.  Verifica che il segreto sia stato creato correttamente. Sostituisci <em>&lt;kubernetes_namespace&gt;</em> con il nome dello spazio in cui hai creato imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  Crea un a pod che fa riferimento all'imagePullSecret.
    1.  Crea un file di configurazione del pod denominato `mypod.yaml`.
    2.  Definisci il pod e l'imagePullSecret che vuoi utilizzare per accedere al tuo registro
{{site.data.keyword.Bluemix_notm}} privato.

        Un'immagine privata da uno spazio dei nomi:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        Un'immagine pubblica {{site.data.keyword.Bluemix_notm}}:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tabella. Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>Il nome del contenitore che vuoi distribuire al tuo cluster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>Lo spazio dei nomi in cui è memorizzata la tua immagine. Per elencare gli spazi dei nomi disponibili, esegui `bx cr namespace-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>Il nome dell'immagine che vuoi utilizzare. Per elencare le immagini disponibili in un account {{site.data.keyword.Bluemix_notm}}, esegui `bx cr image-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>La versione dell'immagine che vuoi utilizzare. Se non si specifica una tag, viene utilizzata l'immagine contrassegnata con <strong>latest</strong> per impostazione predefinita.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>Il nome dell'imagePullSecret che hai creato in precedenza.</td>
        </tr>
        </tbody></table>

   3.  Salva le modifiche.
   4.  Crea la distribuzione nel tuo cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


<br />



## Accesso alle immagini pubbliche da Docker Hub
{: #dockerhub}

Puoi utilizzare qualsiasi immagine pubblica memorizzata in Docker Hub per distribuire un contenitore al tuo cluster senza alcuna configurazione aggiuntiva.
{:shortdesc}

Prima di iniziare:

1.  [Crea un
cluster](cs_clusters.html#clusters_cli).
2.  [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Crea un file di configurazione di distribuzione.

1.  Crea un file di configurazione denominato `mydeployment.yaml`.
2.  Definisci la distribuzione e l'immagine pubblica dal Docker Hub che vuoi utilizzare. Il seguente file di configurazione utilizza l'immagine pubblica NGINX disponibile su Docker Hub.

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  Crea la distribuzione nel tuo cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Suggerimento:** in alternativa, distribuisci un file di configurazione esistente. Il seguente esempio utilizza la stessa immagine NGINX pubblica ma la applica direttamente al tuo cluster.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}

<br />



## Accesso alle immagini memorizzate in altri registri privati
{: #private_images}

Se hai già un registro privato da utilizzare, devi memorizzare le credenziali del registro in un imagePullSecret Kubernetes e fare riferimento a questo segreto nel tuo file di configurazione.
{:shortdesc}

Prima di iniziare:

1.  [Crea un cluster](cs_clusters.html#clusters_cli).
2.  [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Per creare un imagePullSecret:

**Nota:** i segreti imagePullSecret sono validi per gli spazi dei nomi per i quali sono stati creati. Ripeti questa procedura per ogni spazio dei nomi in cui vuoi distribuire i contenitori da un'immagine memorizzata in un registro {{site.data.keyword.Bluemix_notm}} privato.

1.  Crea il segreto Kubernetes per memorizzare le credenziali del tuo registro privato.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabella. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obbligatoria. Lo spazio dei nomi Kubernetes del cluster in cui vuoi utilizzare il segreto e a cui distribuire i contenitori. Esegui <code>kubectl get namespaces</code> per elencare tutti gli spazi dei nomi nel tuo cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Obbligatoria. Il nome che vuoi utilizzare per imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Obbligatoria. L'URL del registro in cui sono memorizzate le tue immagini private.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Obbligatoria. Il nome utente per accedere al tuo registro privato.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Obbligatoria. Il valore del tuo token di registro che hai richiamato in precedenza.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Obbligatoria. Se ne hai uno, immetti il tuo indirizzo e-mail Docker. Se non hai uno, immetti un indirizzo e-mail fittizio, come ad esempio a@b.c. Questa e-mail è obbligatoria per creare un segreto Kubernetes, ma non viene utilizzata dopo la creazione.</td>
    </tr>
    </tbody></table>

2.  Verifica che il segreto sia stato creato correttamente. Sostituisci <em>&lt;kubernetes_namespace&gt;</em> con il nome dello spazio in cui hai creato imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  Crea un a pod che fa riferimento all'imagePullSecret.
    1.  Crea un file di configurazione del pod denominato `mypod.yaml`.
    2.  Definisci il pod e l'imagePullSecret che vuoi utilizzare per accedere al tuo registro {{site.data.keyword.Bluemix_notm}} privato. Per utilizzare un'immagine privata dal tuo registro privato:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tabella. Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>Il nome del pod che vuoi creare.</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>Il nome del contenitore che vuoi distribuire al tuo cluster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>Il percorso completo dell'immagine nel tuo registro privato che vuoi utilizzare.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>La versione dell'immagine che vuoi utilizzare. Se non si specifica una tag, viene utilizzata l'immagine contrassegnata con <strong>latest</strong> per impostazione predefinita.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>Il nome dell'imagePullSecret che hai creato in precedenza.</td>
        </tr>
        </tbody></table>

  3.  Salva le modifiche.
  4.  Crea la distribuzione nel tuo cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}
