---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Esercitazioni per i cluster
{: #cs_tutorials}

Prova queste esercitazioni e altre risorse per un'introduzione al servizio.
{:shortdesc}

## Esercitazione: Creazione dei cluster
{: #cs_cluster_tutorial}

Distribuisci e gestisci i tuoi cluster Kubernetes nel cloud in modo da automatizzare la distribuzione, l'operatività, il ridimensionamento e il monitoraggio
delle applicazioni inserite in un contenitore in un cluster di host di calcolo indipendenti
denominati nodi di lavoro.
{:shortdesc}

Queste serie di esercitazioni illustra come una società di relazioni pubbliche immaginaria può utilizzare
Kubernetes per distribuire un'applicazione in un contenitore in {{site.data.keyword.Bluemix_short}}
che si avvale di Watson Tone Analyzer. La società di RP utilizza Watson Tone Analyzer per analizzare
i propri comunicati stampa e riceve feedback sul tono dei propri messaggi. In questa esercitazione della società,
l'amministratore della rete della società di RP configura un cluster Kubernetes personalizzato che è l'infrastruttura di calcolo
per l'applicazione Watson Tone Analyzer della società. Questo cluster viene utilizzato per distribuire e testare una versione di
Hello World dell'applicazione della società di RP.

### Obiettivi

-   Crea un cluster Kubernetes con un nodo di lavoro
-   Installa le CLI per utilizzare l'API Kubernetes e gestire le immagini Docker
-   Crea un repository delle immagini privato in IBM {{site.data.keyword.Bluemix_notm}} Container Registry per archiviare le tue immagini
-   Aggiungi il servizio di {{site.data.keyword.Bluemix_notm}} Watson Tone Analyzer al cluster in modo che ogni applicazione nel cluster possa utilizzare il servizio

### Tempo richiesto

25 minuti

### Destinatari

Questa esercitazione è destinata agli sviluppatori software e agli amministratori di rete che
non hanno mai creato prima un cluster Kubernetes.

### Lezione 1: configurazione della CLI
{: #cs_cluster_tutorial_lesson1}

Installa la CLI {{site.data.keyword.containershort_notm}}, la CLI
{{site.data.keyword.registryshort_notm}} e i rispettivi requisiti. Queste CLI vengono utilizzate nelle prossime lezioni e sono necessarie
per gestire il tuo cluster Kubernetes dalla tua macchina locale, creare immagini da distribuire come i contenitori e in una esercitazione successiva,
per distribuire le applicazioni nel cluster.

Questa esercitazione include
le informazioni per l'installazione delle seguenti CLI.

-   CLI {{site.data.keyword.Bluemix_notm}}
-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes
-   Plug-in {{site.data.keyword.registryshort_notm}}
-   CLI Docker


Per installare le CLI:
1.  Se ancora non disponi di una di esse, crea un account [{{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/registration/). Annota i tuoi nome utente e password poiché queste informazioni saranno necessarie in seguito.
2.  Come prerequisito per il plugin {{site.data.keyword.containershort_notm}}, installa la CLI [{{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://clis.ng.bluemix.net/ui/home.html). Il prefisso per eseguire i comandi utilizzando la CLI {{site.data.keyword.Bluemix_notm}} è `bx`.
3.  Segui le istruzioni per selezionare un account e un'organizzazione {{site.data.keyword.Bluemix_notm}}. I cluster sono specifici di un
ma sono indipendenti da uno spazio o un'organizzazione {{site.data.keyword.Bluemix_notm}}.

5.  Per creare i cluster Kubernetes e gestire i nodi di lavoro, installa il plugin {{site.data.keyword.containershort_notm}}. Il prefisso per eseguire i comandi utilizzando il plugin {{site.data.keyword.containershort_notm}} è `bx cs`.

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}
6.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto.

    ```
    bx login
    ```
    {: pre}

    Per specificare una regione
{{site.data.keyword.Bluemix_notm}} specifica, includi l'endpoint
dell'API. Se disponi di immagini Docker private archiviate nel registro del contenitore di una regione
{{site.data.keyword.Bluemix_notm}} specifica o delle istanze del servizio
{{site.data.keyword.Bluemix_notm}} che hai già creato,
accedi in tale regione per accedere alle tue immagini e servizi {{site.data.keyword.Bluemix_notm}}.

    La regione {{site.data.keyword.Bluemix_notm}} a cui hai eseguito l'accesso determina inoltre la regione in cui puoi creare i tuoi cluster Kubernetes, inclusi i data center disponibili. Se non specifici una regione, viene automaticamente fatto accesso alla regione a te più vicina.

       -  Stati Uniti Sud

           ```
           bx login -a api.ng.bluemix.net
           ```
           {: pre}
     
       -  Sydney

           ```
           bx login -a api.au-syd.bluemix.net
           ```
           {: pre}

       -  Germania

           ```
           bx login -a api.eu-de.bluemix.net
           ```
           {: pre}

       -  Regno Unito

           ```
           bx login -a api.eu-gb.bluemix.net
           ```
           {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

7.  Se vuoi creare un cluster Kubernetes in una regione diversa dalla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, specifica tale regione. Ad esempio, hai creato i servizi {{site.data.keyword.Bluemix_notm}} o le immagini Docker private in una regione e desideri utilizzarle con {{site.data.keyword.containershort_notm}} in un'altra regione.

    Scegli tra i seguenti endpoint API:

    * Stati Uniti Sud:

        ```
        bx cs init --host https://us-south.containers.bluemix.net
        ```
        {: pre}

    * Regno Unito-Sud:

        ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
        {: pre}

    * Europa centrale:

        ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
        {: pre}

    * Asia Pacifico Sud:

        ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
        {: pre}

8.  Per visualizzare una versione locale del dashboard Kubernetes e per distribuire le applicazioni nei tuoi cluster,
[installa la CLI Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Il prefisso per eseguire i comandi utilizzando la CLI Kubernetes è
`kubectl`.
    1.  Scarica la CLI Kubernetes.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

          **Suggerimento:** se stai utilizzando Windows, installa la CLI Kubernetes nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Per gli utenti OSX e Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Assicurati che /usr/local/bin sia elencato nella tua variabile di sistema `PATH`. La variabile `PATH` contiene tutte le directory in cui il tuo sistema operativo
può trovare i file eseguibili. Le directory elencate nella variabile `PATH`
servono a diversi scopi. /usr/local/bin viene utilizzata per memorizzare i file eseguibili
per il software che non fa parte del sistema operativo e che viene installato manualmente dall'amministratore di sistema.

            ```
            echo $PATH
            ```
            {: pre}

            L'output della CLI
sarà simile al seguente.

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Converti il file binario in un file eseguibile. 

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

9. Per configurare e gestire un repository delle immagini privato in {{site.data.keyword.registryshort_notm}}, installa il plugin
{{site.data.keyword.registryshort_notm}}. Il prefisso per l'esecuzione dei comandi di registro è `bx cr`.

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Per verificare che i plugin container-service e container-registry siano installati correttamente, esegui il seguente comando:

    ```
    bx plugin list
    ```
    {: pre}

10. Per creare le immagini localmente e per trasmetterle al tuo repository delle immagini privato,
[installa la CLI Docker CE ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/community-edition#/download). Se stai utilizzando Windows 8 o precedenti, puoi invece installare [Docker Toolbox ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/products/docker-toolbox).

Congratulazioni! Hai creato correttamente il tuo account {{site.data.keyword.Bluemix_notm}} e installato le CLI
per le seguenti esercitazioni e lezioni. Successivamente, accedi al tuo cluster utilizzando la CLI e inizia ad aggiungere i servizi
{{site.data.keyword.Bluemix_notm}}.

### Lezione 2: Configurazione del tuo ambiente cluster
{: #cs_cluster_tutorial_lesson2}

Crea il tuo cluster Kubernetes, configura un repository delle immagini privato in {{site.data.keyword.registryshort_notm}} e aggiungi i segreti al tuo cluster
in modo che l'applicazione possa accedere al servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzerfull}}.

1.  Crea il tuo cluster Kubernetes lite. 

    ```
    bx cs cluster-create --name <pr_firm_cluster>
    ```
    {: pre}

    Un cluster lite viene fornito con un nodo di lavoro su cui distribuire i pod del contenitore. Un nodo di lavoro
è l'host di calcolo, normalmente una macchina virtuale, su cui vengono eseguite le tue applicazioni. Un'applicazione in produzione esegue le repliche dell'applicazione
tra più nodi di lavoro per fornire elevata disponibilità per la tua applicazione.

    **Nota:** servono fino a 15 minuti perché la macchina del nodo di lavoro sia ordinata e che il cluster
sia configurato e ne sia stato eseguito il provisioning.

2.  Configura il tuo proprio repository delle immagini privato in {{site.data.keyword.registryshort_notm}} per condividere ed archiviare in modo sicuro le immagini Docker
con tutti gli utenti del cluster. Un repository delle immagini privato in {{site.data.keyword.Bluemix_notm}} viene
identificato da uno spazio dei nomi che imposti in questo passo. Lo spazio dei nomi viene utilizzato per creare un URL univoco per il tuo repository delle immagini
che gli sviluppatori possono utilizzare per accedere alle immagini Docker private. Puoi creare
più spazi dei nomi nel tuo account per raggruppare e organizzare le tue immagini. Ad esempio, puoi creare
uno spazio dei nomi per ogni dipartimento, ambiente o applicazione.

    In questo esempio, l'agenzia di PR vuole creare solo
un repository delle immagini in {{site.data.keyword.registryshort_notm}}, per cui sceglie
_agenzia_PR_ come proprio spazio dei nomi per raggruppare tutte le immagini nel suo account. Sostituisci
_&lt;tuo_spazionomi&gt;_ con uno spazio di nomi a tua scelta e non qualcosa che sia correlato all'esercitazione.

    ```
    bx cr namespace-add <your_namespace>
    ```
    {: pre}

3.  Prima di continuare con il prossimo passo, verifica che la distribuzione del tuo nodo di lavoro sia completa.

    ```
    bx cs workers <pr_firm_cluster>
    ```
     {: pre}

    Quando il provisioning del tuo nodo di lavoro è completo,
lo stato viene modificato in **Pronto** e puoi iniziare il bind dei servizi {{site.data.keyword.Bluemix_notm}}
da utilizzare in una prossima esercitazione.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   
    kube-dal10-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready   
    ```
    {: screen}

4.  Configura il contesto per il tuo cluster nella tua CLI. Ogni volta che accedi alla tua CLI del contenitore per utilizzare i cluster, devi eseguire questi comandi
per configurare il percorso al file di configurazione del cluster come una variabile di sessione. La CLI Kubernetes
utilizza questa variabile per trovare i certificati e un file di configurazione locale necessari per il collegamento con il
cluster in {{site.data.keyword.Bluemix_notm}}.

    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config pr_firm_cluster
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-dal10-pr_firm_cluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Verifica che i comandi `kubectl` siano eseguiti correttamente con il tuo cluster controllando la versione server della CLI
Kubernetes.

        ```
        kubectl version --short
        ```
        {: pre}

        Output di esempio:

        ```
        Versione client: v1.5.6
    Versione server: v1.5.6
        ```
        {: screen}

5.  Aggiungi il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} {{site.data.keyword.Bluemix_notm}} al cluster. Con
i servizi {{site.data.keyword.Bluemix_notm}}, come {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}},
puoi approfittare della funzionalità già sviluppata nelle tue applicazioni. Ogni servizio {{site.data.keyword.Bluemix_notm}} associato al
cluster può essere utilizzato da qualsiasi applicazione distribuita in tale cluster. Ripeti i seguenti passi per ogni
servizio {{site.data.keyword.Bluemix_notm}} che desideri utilizzare con le tue applicazioni.
    1.  Aggiungi il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} al tuo account {{site.data.keyword.Bluemix_notm}}.

        **Nota:** quando aggiungi il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} al tuo account, viene visualizzato un messaggio che indica che il servizio non è gratuito. Se limiti la tua chiamata API, per questa esercitazione non sarà addebitato nulla dal tuo servizio {{site.data.keyword.watson}}. Puoi [rivedere le informazioni di prezzo per {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block).

        ```
        bx service create tone_analyzer standard <mytoneanalyzer>
        ```
        {: pre}

    2.  Esegui il bind dell'istanza {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} allo spazio dei nomi Kubernetes `default` del cluster. Successivamente, puoi creare i tuoi propri spazi dei nomi per gestire l'accesso utente alle risorse Kubernetes, ma per ora, utilizza lo spazio dei nomi `default`. Gli spazi dei nomi Kubernetes
sono diversi dallo spazio dei nomi del registro che hai precedentemente creato

        ```
        bx cs cluster-service-bind <pr_firm_cluster> default <mytoneanalyzer>
        ```
        {: pre}

        Output:

        ```
        bx cs cluster-service-bind <pr_firm_cluster> default <mytoneanalyzer>
        Binding service instance to namespace...
        OK
        Namespace: default
        Secret name: binding-mytoneanalyzer
        ```
        {: screen}

6.  Verifica che il segreto Kubernetes sia stato creato nel tuo spazio dei nomi del cluster. Ogni servizio {{site.data.keyword.Bluemix_notm}} viene definito da un file
JSON che include informazioni confidenziali sul servizio, come il nome utente, la
password e l'URL che il contenitore utilizza per accedere al servizio. Per archiviare in modo sicuro queste informazioni, vengono utilizzati i segreti
Kubernetes. In questo esempio, il segreto include le credenziali per l'accesso all'istanza {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} di cui è stato eseguito il provisioning nel tuo account {{site.data.keyword.Bluemix_notm}}.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Output:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}


Ottimo lavoro! Il cluster è stato creato, configurato e il tuo ambiente locale è pronto per iniziare a distribuire le applicazioni
nel cluster.

**Operazioni successive**

* [Verifica la tua conoscenza e fai un quiz! ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://bluemix-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)
* Prova [Esercitazione: distribuzione delle applicazioni nei cluster Kubernetes
in {{site.data.keyword.containershort_notm}}](#cs_apps_tutorial) per distribuire l'applicazione dell'agenzia di PR
nel cluster che hai creato.

## Esercitazione: distribuzione delle applicazioni nei cluster
{: #cs_apps_tutorial}

Questa seconda esercitazione ti spiega come utilizzare Kubernetes per distribuire un'applicazione
inserita nel contenitore che si avvale del servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} {{site.data.keyword.Bluemix_notm}}. Una fittizia agenzia di PR
utilizza {{site.data.keyword.watson}} per analizzare i propri comunicati stampa e ricevere feedback sul tono dei propri messaggi.
{:shortdesc}

In questo scenario, lo sviluppatore dell'applicazione dell'agenzia di PR distribuisce una versione Hello World dell'applicazione nel
cluster Kubernetes che l'amministratore di rete ha creato nella [prima esercitazione](#cs_cluster_tutorial).

In ogni lezione ti verrà spiegato come distribuire versioni progressivamente più complicate della stessa applicazione.
Il diagramma mostra i componenti dell'esercitazione relativi alle distribuzioni dell'applicazione, fatta eccezione per la quarta parte.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_roadmap.png">![Componenti della lezione](images/cs_app_tutorial_roadmap.png)</a>

Kubernetes utilizza diversi tipi di risorse per rendere operative le tue applicazioni nei cluster. In Kubernetes, le distribuzioni e i servizi lavorano insieme. Le distribuzioni includono le definizioni per
l'applicazione, come ad esempio l'immagine da utilizzare per il contenitore e quale porta esporre per l'applicazione.
Quando crei una distribuzione, viene creato un pod Kubernetes per ogni contenitore che definisci nella
distribuzione. Per una maggiore resilienza della tua applicazione, puoi definire più istanze della stessa applicazione
nella distribuzione e consentire a Kubernetes di creare automaticamente una serie di repliche. La serie di repliche
monitora i pod e assicura che il numero di pod desiderato sia sempre in esecuzione. Se uno dei
pod smette di rispondere, il pod viene ricreato automaticamente.

I servizi raggruppano una serie di pod e forniscono la connessione di rete a tali pod per gli altri servizi nel
cluster senza esporre il reale indirizzo IP privato di ogni pod. Puoi utilizzare i servizi Kubernetes
per rendere disponibile un'applicazione agli altri pod all'interno del cluster o per esporre un'applicazione
a Internet. In questa esercitazione, utilizzerai un servizio Kubernetes per accedere alla tua applicazione in esecuzione
da Internet utilizzando un indirizzo IP pubblico, che viene assegnato automaticamente a un nodo di lavoro, e una porta
pubblica.

Per rendere la tua applicazione ancora più disponibile, nei cluster standard, puoi creare più nodi di lavoro
per eseguire ancora più repliche della tua applicazione. Questa attività non è trattata in questa esercitazione, ma tieni
a mente questo concetto per futuri miglioramenti alla disponibilità di un'applicazione.

Solo una delle lezioni include l'integrazione di un servizio {{site.data.keyword.Bluemix_notm}} in un'applicazione, ma puoi servirtene con un'applicazione tanto semplice o complessa quanto tu possa immaginare.

### Obiettivi

* Comprendere la terminologia Kubernetes di base
* Eseguire il push di un'immagine al tuo spazio dei nomi del registro in {{site.data.keyword.registryshort_notm}}
* Rendere pubblicamente accessibile un'applicazione
* Distribuire una singola istanza di un'applicazione in un cluster utilizzando un comando Kubernetes e uno script
* Distribuire più istanze di un'applicazione in contenitori che vengono ricreati durante i controlli di integrità
* Distribuire un'applicazione che utilizza la funzionalità da un servizio {{site.data.keyword.Bluemix_notm}}

### Tempo richiesto

40 minuti

### Destinatari

Sviluppatori software e amministratori di rete che non hanno mai distribuito un'applicazione in un cluster
Kubernetes.

### Prerequisiti

[Esercitazione: Creazione dei cluster Kubernetes in {{site.data.keyword.containershort_notm}}](#cs_cluster_tutorial).

### Lezione 1: distribuzione di singole applicazioni dell'istanza ai cluster Kubernetes
{: #cs_apps_tutorial_lesson1}

In questa lezione, distribuisci una singola istanza dell'applicazione Hello World in un
cluster.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components1.png">![Impostazioni di distribuzione](images/cs_app_tutorial_components1.png)</a>


1.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto.

    ```
    bx login
    ```
    {: pre}

    Per specificare una regione
{{site.data.keyword.Bluemix_notm}} specifica, includi l'endpoint
dell'API. Se disponi di immagini Docker private archiviate nel registro del contenitore di una regione
{{site.data.keyword.Bluemix_notm}} specifica o delle istanze del servizio
{{site.data.keyword.Bluemix_notm}} che hai già creato,
accedi in tale regione per accedere alle tue immagini e servizi {{site.data.keyword.Bluemix_notm}}.

    La regione {{site.data.keyword.Bluemix_notm}} a cui hai eseguito l'accesso determina inoltre la regione in cui puoi creare i tuoi cluster Kubernetes, inclusi i datacenter disponibili. Se non specifici una regione, viene automaticamente fatto accesso alla regione a te più vicina.

    -  Stati Uniti Sud

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}
  
    -  Sydney

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -  Germania

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -  Regno Unito

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

2.  Configura il contesto del cluster nella tua CLI.
    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <pr_firm_cluster>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<pr_firm_cluster>/kube-config-prod-dal10-pr_firm_cluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<pr_firm_cluster>/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Verifica che i comandi `kubectl` siano eseguiti correttamente con il tuo cluster controllando la versione server della CLI
Kubernetes.

        ```
        kubectl version --short
        ```
        {: pre}

        Output di esempio:

        ```
        Versione client: v1.5.6
    Versione server: v1.5.6
        ```
        {: screen}

3.  Avvia Docker.
    * Se stai utilizzando Docker CE, non è necessaria alcuna azione.
    * Se stai utilizzando Linux, segui la [Documentazione Docker ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/engine/admin/) per trovare le istruzioni su come avviare Docker in base alla distribuzione Linux che utilizzi.
    * Se stai utilizzando Docker Toolbox su Windows o OSX, puoi utilizzare il Docker Quickstart Terminal,
che avvia Docker per te. Utilizza il Docker Quickstart Terminal per i prossimi pochi passi per eseguire i comandi
Docker e quindi ritorna alla CLI in cui hai configurato la variabile della sessione `KUBECONFIG`.
        * Se stai utilizzando il Docker QuickStart Terminal, esegui il comando di accesso della CLI {{site.data.keyword.Bluemix_notm}}
nuovamente.

          ```
          bx login
          ```
          {: pre}

4.  Accedi alla CLI {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

    -   Se hai dimenticato il tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}},
esegui il seguente comando.

        ```
        bx cr namespace-list
        ```
        {: pre}

5.  Clona o scarica il codice di origine per l'[applicazione Hello world ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM/container-service-getting-started-wt) nella tua directory home utente.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

    Se hai scaricato il repository, estrai il file compresso.

    Esempi:

    * Windows: `C:Users\<my_username>\container-service-getting-started-wt`
    * OS X: `/Users/<my_username>/container-service-getting-started-wt`

    Il repository contiene tre versioni di un'applicazione simile
nelle cartelle denominate `Stage1`, `Stage2` e `Stage3`. Ogni versione contiene i seguenti file:
    * `Dockerfile`: le definizioni di build dell'immagine
    * `app.js`: l'applicazione Hello world
    * `package.json`: i metadati dell'applicazione

6.  Passa alla prima directory dell'applicazione, `Stage1`.

    ```
    cd <username_home_directory>/container-service-getting-started-wt/Stage1
    ```
    {: pre}

7.  Crea un'immagine Docker che include i file dell'applicazione della directory `Stage1`. Se hai bisogno di effettuare una modifica all'applicazione in futuro, ripeti questi passi per creare un'altra versione
dell'immagine.

    1.  Crea l'immagine localmente e contrassegnala con il nome e la tag che desideri utilizzare e
lo spazio dei nomi che hai creato in {{site.data.keyword.registryshort_notm}} nella precedente esercitazione. L'inserimento di tag nell'immagine con le informazioni dello spazio dei nomi indica a Docker dove eseguire il push
dell'immagine in una fase successiva. Utilizza caratteri alfanumerici minuscoli o di sottolineatura (`_`) solo nei nomi di immagine. Non dimenticare il punto (`.`) alla fine del comando. Il punto indica a Docker di cercare all'interno della
directory corrente per il Dockerfile e delle risorse di build da creare nell'immagine.

        ```
        docker build -t registry.<region>.bluemix.net/<namespace>/hello-world:1 .
        ```
        {: pre}

        Quando
la creazione è completa, verifica di ricevere il messaggio
di esito positivo.

        ```
        Successfully built <image_id>
        ```
        {: screen}

    2.  Invia l'immagine al tuo spazio dei nomi del registro.

        ```
        docker push registry.<region>.bluemix.net/<namespace>/hello-world:1
        ```
        {: pre}

        Output:

        ```
        The push refers to a repository [registry.<region>.bluemix.net/<namespace>/hello-world]
        ea2ded433ac8: Pushed
        894eb973f4d3: Pushed
        788906ca2c7e: Pushed
        381c97ba7dc3: Pushed
        604c78617f34: Pushed
        fa18e5ffd316: Pushed
        0a5e2b2ddeaa: Pushed
        53c779688d06: Pushed
        60a0858edcd5: Pushed
        b6ca02dfe5e6: Pushed
        1: digest: sha256:0d90cb73288113bde441ae9b8901204c212c8980d6283fbc2ae5d7cf652405
        43 size: 2398
        ```
        {: screen}

        Attendi che l'immagine sia stata trasmessa prima di continuare con il passo successivo.

    3.  Se stai utilizzando il Docker Quickstart Terminal, ritorna alla CLI
utilizzata per configurare la variabile della sessione `KUBECONFIG`.

    4.  Verifica che l'immagine sia stata correttamente aggiunta al tuo spazio dei nomi.

        ```
        bx cr images
        ```
        {: pre}

        Output:

        ```
        Listing images...

        REPOSITORY                                  NAMESPACE   TAG       DIGEST         CREATED        SIZE     VULNERABILITY STATUS
        registry.<region>.bluemix.net/<namespace>/hello-world   <namespace>   1   0d90cb732881   1 minute ago   264 MB   OK
        ```
        {: screen}

8.  Crea una distribuzione Kubernetes denominata _hello-world-deployment_
per distribuire l'applicazione a un pod nel tuo cluster. Le distribuzioni sono utilizzate per gestire i pod, che includono le istanze inserite nel contenitore di un'applicazione.
La seguente distribuzione distribuisce l'applicazione in un solo pod.

    ```
    kubectl run hello-world-deployment --image=registry.<region>.bluemix.net/<namespace>/hello-world:1
    ```
    {: pre}

    Output:

    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Poiché questa distribuzione
crea solo un'istanza dell'applicazione, la creazione è più veloce che
nelle lezioni successive in cui vengono create più di un'istanza dell'applicazione.

9.  Rendi la tua applicazione accessibile al mondo esponendo la distribuzione come un servizio NodePort. I servizi applicano la funzionalità di rete per l'applicazione. Poiché il cluster ha un nodo di lavoro
piuttosto che molti, il programma di bilanciamento del carico tra i nodi di lavoro non è necessario. Pertanto, può essere utilizzata una NodePort
per fornire agli utenti l'accesso esterno all'applicazione. Così come puoi esporre una porta per un'applicazione Cloud Foundry,
la NodePort esposta è la porta su cui il nodo di lavoro è in ascolto per il traffico. In un passo successivo,
controlla quale NodePort è stata assegnata casualmente al servizio.

    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Output:

    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table>
    <table summary=\xe2\x80\x9cInformation about the expose command parameters.\xe2\x80\x9d>
    <caption>Tabella 1. Parametri del comando </caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Ulteriori informazioni sui parametri di esposizione</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Esponi una risorsa come un servizio Kubernetes e rendila disponibile pubblicamente agli utenti.</td>
    </tr>
    <tr>
    <td><code>deployment/<em>&lt;hello-world-deployment&gt;</em></code></td>
    <td>Il nome e il tipo della risorsa da esporre con questo servizio.</td>
    </tr>
    <tr>
    <td><code>--name=<em>&lt;hello-world-service&gt;</em></code></td>
    <td>Il nome del servizio.</td>
    </tr>
    <tr>
    <td><code>--port=<em>&lt;8080&gt;</em></code></td>
    <td>La porta che il servizio utilizza. </td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>Il tipo di servizio da creare.</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>La porta su cui il servizio gestisce il traffico. In questa istanza, la porta di destinazione è la stessa porta,
ma per altre applicazioni che hai creato potrebbe essere diverso.</td>
    </tr>
    </tbody></table>

    Ora che tutto il lavoro di distribuzione è stato effettuato,
puoi controllare come tutto è stato attivato.

10. Per verificare la tua applicazione in un browser, ottieni i dettagli per creare l'URL.
    1.  Ottieni le informazioni sul servizio per visualizzare quale NodePort è stata assegnata.

        ```
        kubectl describe service <hello-world-service>
        ```
        {: pre}

        Output:

        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.10.10.8
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.171.87:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Le
NodePort sono assegnate casualmente quando vengono generate con il comando `expose`,
ma comprese nell'intervallo 30000-32767. In questo esempio, la NodePort è 30872. 

    2.  Ottieni l'indirizzo IP pubblico per il nodo di lavoro nel cluster.

        ```
        bx cs workers <pr_firm_cluster>
        ```
        {: pre}

        Output:

        ```
        Listing cluster workers...
        OK
        ID                                            Public IP        Private IP      Machine Type   State      Status
        dal10-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.47.227.138   10.171.53.188   free           normal    Ready
        ```
        {: screen}

11. Apri un browser e controlla l'applicazione con il seguente URL: `http://<IP_address>:<NodePort>`. Con i valori di esempio, l'URL è `http://169.47.227.138:30872`. Quando immetti tale URL
in un browser, puoi visualizzare il seguente
testo.

    ```
    Hello world! La tua applicazione è attiva e in esecuzione in un cluster!
    ```
    {: screen}

    Puoi dare questo URL
a un collaboratore come prova o immetterlo nel browser del cellulare, in modo da poter controllare che l'applicazione Hello
World sia realmente disponibile pubblicamente.

12. Avvia il tuo dashboard Kubernetes con la porta predefinita 8001.
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
         {: pre}

13. Nella scheda **Carichi di lavoro**, puoi visualizzare le risorse che hai creato. Quando hai terminato di controllare il dashboard Kubernetes, utilizza CTRL+C
per uscire dal comando `proxy`.

Congratulazioni! Hai distribuito la tua prima versione dell'applicazione.

Troppi comandi in questa lezione? D'accordo. Come l'utilizzo di uno script di configurazione
può fare del lavoro al tuo posto? Per utilizzare uno script di configurazione per la seconda versione dell'applicazione e per creare
elevata disponibilità distribuendo più istanze di tale applicazione, continua con la prossima lezione.

### Lezione 2: distribuzione e aggiornamento delle applicazioni con elevata disponibilità
{: #cs_apps_tutorial_lesson2}

In questa lezione, distribuisci tre istanze dell'applicazione Hello World in un
cluster per una maggiore disponibilità della prima versione dell'applicazione. La maggiore disponibilità significa che l'accesso utente
è diviso tra le tre istanze. Quando troppi utenti stanno tentando di accedere alla stessa istanza dell'applicazione,
potrebbero ravvisare tempi di risposta lenti. Più istanze possono voler dire tempi di risposta più veloci per i tuoi
utenti. In questa lezione, imparerai anche come i controlli di integrità e gli aggiornamenti della distribuzione possono funzionare con
Kubernetes.


<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components2.png">![Impostazioni di distribuzione](images/cs_app_tutorial_components2.png)</a>


Come definito nello script di configurazione, Kubernetes può utilizzare un controllo di disponibilità per visualizzare se
un contenitore in un pod è in esecuzione o meno. Ad esempio, questi controlli potrebbero individuare dei deadlock,
dove un'applicazione è in esecuzione, ma non possono fare progressi. Riavviare un contenitore in questa condizione può aiutare
a rendere l'applicazione più disponibile nonostante i bug. Quindi, Kubernetes utilizza il controllo di disponibilità per conoscere
quando un contenitore è pronto per iniziare ad accettare nuovamente il traffico. Un pod è considerato pronto quanto il suo contenitore
è pronto. Quando il pod è pronto, viene riavviato. Nell'applicazione Stage2, ogni 15 secondi,
l'applicazione va in timeout. Con un controllo di integrità configurato nello script di configurazione, i contenitori vengono ricreati se
il controllo di integrità trova un problema con l'applicazione.

1.  In una CLI, passa alla directory della seconda applicazione, `Stage2`. Se stai utilizzando Docker Toolbox per Windows o OS X, utilizza Docker Quickstart
Terminal.

  ```
  cd <username_home_directory>/container-service-getting-started-wt/Stage2
  ```
  {: pre}

2.  Crea e contrassegna con tag la seconda versione dell'applicazione localmente come un'immagine. Nuovamente, non dimenticare il punto (`.`) alla fine del comando.

  ```
  docker build -t registry.<region>.bluemix.net/<namespace>/hello-world:2 .
  ```
  {: pre}

  Verifica di poter visualizzare il messaggio di esito positivo.

  ```
  Successfully built <image_id>
  ```
  {: screen}

3.  Trasmetti la seconda versione dell'immagine al tuo spazio dei nomi del registro. Attendi che l'immagine sia stata trasmessa prima di continuare con il passo successivo.

  ```
  docker push registry.<region>.bluemix.net/<namespace>/hello-world:2
  ```
  {: pre}

  Output:

  ```
  The push refers to a repository [registry.<region>.bluemix.net/<namespace>/hello-world]
  ea2ded433ac8: Pushed
  894eb973f4d3: Pushed
  788906ca2c7e: Pushed
  381c97ba7dc3: Pushed
  604c78617f34: Pushed
  fa18e5ffd316: Pushed
  0a5e2b2ddeaa: Pushed
  53c779688d06: Pushed
  60a0858edcd5: Pushed
  b6ca02dfe5e6: Pushed
  1: digest: sha256:0d90cb73288113bde441ae9b8901204c212c8980d6283fbc2ae5d7cf652405
  43 size: 2398
  ```
  {: screen}

4.  Se stai utilizzando il Docker Quickstart Terminal, ritorna alla CLI
utilizzata per configurare la variabile della sessione `KUBECONFIG`.
5.  Verifica che l'immagine sia stata correttamente aggiunta al tuo spazio dei nomi del registro.

    ```
    bx cr images
    ```
     {: pre}

    Output:

    ```
    Listing images...

    REPOSITORY                                 NAMESPACE  TAG  DIGEST        CREATED        SIZE     VULNERABILITY STATUS
    registry.<region>.bluemix.net/<namespace>/hello-world  <namespace>  1    0d90cb732881  30 minutes ago 264 MB   OK
    registry.<region>.bluemix.net/<namespace>/hello-world  <namespace>  2    c3b506bdf33e  1 minute ago   264 MB   OK
    ```
    {: screen}

6.  Apri il file `<username_home_directory>/container-service-getting-started-wt/Stage2/healthcheck.yml` con un editor di testo. Questo script di configurazione combina alcuni passi dalla lezione precedente per creare una distribuzione
e un servizio contemporaneamente. Gli sviluppatori dell'applicazione dell'agenzia di PR possono utilizzare questi script quando effettuano degli aggiornamenti
o per risolvere i problemi ricreando i pod.

    1.  Nella sezione **Distribuzione**, prendi nota di `replicas`. Le repliche
sono il numero di istanze della tua applicazione. Eseguire tre istanze rende l'applicazione più disponibile
rispetto a una sola istanza.

        ```
        replicas: 3
        ```
        {: pre}

    2.  Aggiorna i dettagli dell'immagine nel tuo spazio dei nomi del registro privato.

        ```
        image: "registry.<region>.bluemix.net/<namespace>/hello-world:2"
        ```
        {: pre}

    3.  Nota che l'analisi di attività HTTP controlla l'integrità del contenitore ogni 5 secondi.

        ```
        livenessProbe:
                    httpGet:
                      path: /healthz
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 5
        ```
        {: codeblock}

    4.  Nella sezione **Servizio**, prendi nota di `NodePort`. Invece di generare una NodePort casuale come hai fatto nella precedente lezione, puoi specificare
una porta nell'intervallo 30000 - 32767. Questo esempio utilizza 30072.

7.  Esegui lo script di configurazione nel cluster. Una volta creati la distribuzione e il servizio, l'applicazione è disponibile per la visualizzazione da parte degli utenti
dell'agenzia di PR.

  ```
  kubectl apply -f <username_home_directory>/container-service-getting-started-wt/Stage2/healthcheck.yml
  ```
  {: pre}

  Output:

  ```
  deployment "hw-demo-deployment" created
  service "hw-demo-service" created
  ```
  {: screen}

  Ora che tutto il lavoro di distribuzione è stato effettuato,
controlla come tutto è stato attivato. Potresti riscontrare che poiché alcune istanze sono in esecuzione,
tutto può essere un po' più lento.

8.  Apri un browser e controlla l'applicazione. Per creare l'URL, prendi lo stesso indirizzo IP pubblico che
hai utilizzato nella lezione precedente per il tuo nodo di lavoro e combinalo con la NodePort specificata
nello script di configurazione. Per ottenere l'indirizzo IP pubblico per il nodo di lavoro:

  ```
  bx cs workers <pr_firm_cluster>
  ```
  {: pre}

  Con i valori di esempio, l'URL è `http://169.47.227.138:30072`. In un
browser, potresti visualizzare il seguente testo. Se non visualizzi questo testo, non ti preoccupare. Questa applicazione è progettata
per essere attiva e disattiva.

  ```
  Hello world! Ottimo lavoro per aver reso la seconda fase attiva e in esecuzione!
  ```
  {: screen}

  Puoi anche controllare `http://169.47.227.138:30072/healthz` per lo stato.

  Per i primi 10 - 15 secondi, viene restituito un messaggio 200, in modo che puoi sapere se l'applicazione
è in esecuzione correttamente. Dopo questi 15 secondi, viene visualizzato un messaggio di timeout, come progettato nell'applicazione.

  ```
  {
    "error": "Timeout, Health check error!"
  }
  ```
  {: screen}

9.  Avvia il tuo dashboard Kubernetes con la porta predefinita 8001.
    1.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        Output:

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    2.  Apri il seguente URL in un browser web per visualizzare il dashboard Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

10. Nella scheda **Carichi di lavoro**, puoi visualizzare le risorse che hai creato. Da questa scheda, puoi continuamente aggiornare e visualizzare che il controllo di integrità stia funzionando. Nella sezione
**Pod**, puoi visualizzare quante volte i pod sono riavviati quando
i contenitori in essi vengono ricreati. Se ti capita di ricevere il seguente errore nel dashboard,
questo messaggio indica che il controllo di integrità ha rilevato un problema. Attendi alcuni minuti e aggiorna di nuovo. Vedrai il numero di riavvio delle modifiche per ogni
pod.

    ```
    Liveness probe failed: HTTP probe failed with statuscode: 500
    Back-off restarting failed docker container
    Error syncing pod, skipping: failed to "StartContainer" for "hw-container" with CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-demo-deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
    ```
    {: screen}

    Quando hai terminato di controllare il dashboard Kubernetes, nella tua CLI, immetti CTRL+C per uscire dal comando `proxy`.


Congratulazioni! Hai distribuito la seconda versione dell'applicazione. Hai dovuto utilizzare pochi comandi,
hai imparato come funzionano i controlli di integrità e modificato una distribuzione, il che è fantastico! L'applicazione Hello world
ha superato il test per l'agenzia di PR. Ora, puoi distribuire un'applicazione più utile per l'agenzia di PR per iniziare l'analisi
dei comunicati stampa.

Pronto a eliminare quello che hai precedentemente creato prima di continuare? Questa volta, puoi utilizzare lo stesso
script di configurazione per eliminare le risorse che hai
creato.

```
kubectl delete -f <username_home_directory>/container-service-getting-started-wt/Stage2/healthcheck.yml
```
{: pre}

Output:

```
deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
```
{: screen}

### Lezione 3: distribuzione e aggiornamento dell'applicazione Watson Tone Analyzer
{: #cs_apps_tutorial_lesson3}

Nelle precedenti lezioni, le applicazioni sono state distribuite come singoli componenti in un nodo di lavoro. In questa lezione, distribuisci due componenti di un'applicazione in un cluster che utilizzano il servizio Watson Tone Analyzer che hai aggiunto al tuo cluster nell'esercitazione precedente. Separare i componenti in contenitori differenti ti assicura di poterne aggiornare uno
senza influenzare gli altri. Quindi, aggiornerai l'applicazione per scalarla con più repliche per renderla
altamente disponibile.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components3.png">[![Configurazione della distribuzione](images/cs_app_tutorial_components3.png)</a>


#### **Lezione 3a: distribuzione dell'applicazione Watson Tone Analyzer**
{: #lesson3a}

1.  In una CLI, passa alla directory della terza applicazione, `Stage3`. Se stai utilizzando Docker Toolbox per Windows o OS X, utilizza Docker Quickstart
Terminal.

  ```
  cd <username_home_directory>/container-service-getting-started-wt/Stage3
  ```
  {: pre}

2.  Crea la prima immagine {{site.data.keyword.watson}}.

    1.  Passa alla directory `watson`.

        ```
        cd watson
        ```
        {: pre}

    2.  Crea e contrassegna con tag la prima parte dell'applicazione localmente come un'immagine. Nuovamente, non dimenticare il punto (`.`) alla fine del comando.

        ```
        docker build -t registry.<region>.bluemix.net/<namespace>/watson .
        ```
        {: pre}

        Verifica di poter visualizzare il messaggio di esito positivo.

        ```
        Successfully built <image_id>
        ```
        {: screen}

    3.  Trasmetti la prima parte dell'applicazione con un'immagine al tuo spazio dei nomi del registro privato. Attendi che l'immagine sia stata trasmessa prima di continuare con il passo successivo.

        ```
        docker push registry.<region>.bluemix.net/<namespace>/watson
        ```
        {: pre}

3.  Crea la seconda immagine {{site.data.keyword.watson}}-talk.

    1.  Passa alla directory `watson-talk`.

        ```
        cd <username_home_directory>/container-service-getting-started-wt/Stage3/watson-talk
        ```
        {: pre}

    2.  Crea e contrassegna con tag la seconda parte dell'applicazione localmente come un'immagine. Nuovamente, non dimenticare il punto (`.`) alla fine del comando.

        ```
        docker build -t registry.<region>.bluemix.net/<namespace>/watson-talk .
        ```
        {: pre}

        Verifica di poter visualizzare il messaggio di esito positivo.

        ```
        Successfully built <image_id>
        ```
        {: screen}

    3.  Trasmetti la seconda parte dell'applicazione al tuo spazio dei nomi del registro privato. Attendi che l'immagine sia stata trasmessa prima di continuare con il passo successivo.

        ```
        docker push registry.<region>.bluemix.net/<namespace>/watson-talk
        ```
        {: pre}

4.  Se stai utilizzando il Docker Quickstart Terminal, ritorna alla CLI
utilizzata per configurare la variabile della sessione `KUBECONFIG`.

5.  Verifica che le immagini siano state correttamente aggiunte al tuo spazio dei nomi del registro.

    ```
    bx cr images
    ```
    {: pre}

    Output:

    ```
    Listing images...

    REPOSITORY                                  NAMESPACE  TAG            DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    registry.<region>.bluemix.net/namespace/hello-world   namespace  1              0d90cb732881   40 minutes ago  264 MB   OK
    registry.<region>.bluemix.net/namespace/hello-world   namespace  2              c3b506bdf33e   20 minutes ago  264 MB   OK
    registry.<region>.bluemix.net/namespace/watson        namespace  latest         fedbe587e174   3 minutes ago   274 MB   OK
    registry.<region>.bluemix.net/namespace/watson-talk   namespace  latest         fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}

6.  Apri il file `<username_home_directory>/container-service-getting-started-wt/Stage3/watson-deployment.yml` con un editor di testo. Questo script di configurazione include una distribuzione e un servizio per entrambi i componenti
watson e watson-talk dell'applicazione.

    1.  Aggiorna i dettagli dell'immagine nel tuo spazio dei nomi del registro per entrambe le distribuzioni.

        watson:

        ```
        image: "registry.<region>.bluemix.net/namespace/watson"
        ```
        {: codeblock}

        watson-talk:

        ```
        image: "registry.<region>.bluemix.net/namespace/watson-talk"
        ```
        {: codeblock}

    2.  Nella sezione volumes della distribuzione watson, aggiorna il nome del segreto {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} creato nell'esercitazione precedente. Montando il segreto Kubernetes come un volume alla tua distribuzione, rendi le credenziali del servizio {{site.data.keyword.Bluemix_notm}} disponibili al contenitore che è in esecuzione nel tuo pod. I componenti dell'applicazione {{site.data.keyword.watson}} in questa esercitazione sono configurati per cercare le credenziali del servizio utilizzando il percorso di montaggio del volume.

        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-<mytoneanalyzer>
        ```
        {: codeblock}

        Se hai dimenticato come hai denominato il segreto, esegui il seguente
comando.

        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}

    3.  Nella sezione del servizio watson-talk, prendi nota del valore impostato per la
`NodePort`. Questo esempio utilizza 30080. 

7.  Esegui lo script di configurazione.

  ```
  kubectl apply -f <username_home_directory>/container-service-getting-started-wt/Stage3/watson-deployment.yml
  ```
  {: pre}

8.  Facoltativo: verifica che il segreto {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} sia montato come un volume al pod.

    1.  Per ottenere il nome di un pod watson, esegui il seguente comando.

        ```
        kubectl get pods
        ```
        {: pre}

        Output:

        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}

    2.  Ottieni i dettagli relativi al pod e cerca il nome del segreto.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

        Output:

        ```
        Volumes:
          service-bind-volume:
            Type:       Secret (a volume populated by a Secret)
            SecretName: binding-mytoneanalyzer
          default-token-j9mgd:
            Type:       Secret (a volume populated by a Secret)
            SecretName: default-token-j9mgd
        ```
        {: codeblock}

9.  Apri un browser e analizza del testo. Con l'indirizzo IP di esempio, il formato dell'URL è `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"`. Esempio:

    ```
    http://169.47.227.138:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    In
un browser, puoi visualizzare la risposta JSON per il testo che hai immesso.

10. Avvia il tuo dashboard Kubernetes con la porta predefinita 8001.

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

11. Nella scheda **Carichi di lavoro**, puoi visualizzare le risorse che hai creato. Quando hai terminato di controllare il dashboard Kubernetes, utilizza CTRL+C
per uscire dal comando `proxy`.

#### Lezione 3b. Aggiornamento ed esecuzione della distribuzione Watson Tone Analyzer
{: #lesson3b}

Mentre una distribuzione è in esecuzione, puoi modificare la distribuzione per modificare i valori nel template di pod. Questa lezione include l'aggiornamento dell'immagine utilizzata.

1.  Cambia il nome dell'immagine. L'agenzia di PR vuole provare un'applicazione differente nella stessa distribuzione eseguendo però il rollback se viene rilevato un problema con la nuova applicazione.

    1.  Apri lo script di configurazione per la distribuzione in esecuzione.

        ```
        kubectl edit deployment/watson-talk-pod
        ```
        {: pre}

        A seconda del tuo sistema operativo,
si apre un editor vi o un editor di testo.

    2.  Cambia il nome dell'immagine all'immagine ibmliberty.

        ```
        spec:
              containers:
              - image: registry.<region>.bluemix.net/ibmliberty:latest
        ```
        {: codeblock}

    3.  Salva le modifiche e esci dall'editor.

    4.  Applica le modifiche nello script di configurazione per la distribuzione in esecuzione.

        ```
        kubectl rollout status deployment/watson-talk-pod
        ```
        {: pre}

        Attendi la conferma che la
distribuzione iniziale sia completa.

        ```
        deployment "watson-talk-pod" successfully rolled out
        ```
        {: screen}

        Quando distribuisci una modifica, un altro pod viene
creato e testato da Kubernetes. Quando il test ha esito positivo, il vecchio pod viene rimosso.

    5.  Se le modifiche non sono come previsto, è possibile eseguire il rollback delle modifiche. Forse qualcuno nell'agenzia di PR ha commesso un errore con le modifiche dell'applicazione ed è necessario riportarle
alla distribuzione precedente.

        1.  Visualizza i numeri versione di revisione per identificare il numero della distribuzione precedente. La revisione più recente è il numero versione più elevato. In questo esempio, la revisione 1 era la distribuzione originale e la revisione 2 è la modifica dell'immagine da te eseguita nel passo precedente.

            ```
            kubectl rollout history deployment/watson-talk-pod
            ```
            {: pre}

            Output:

            ```
            deployments "watson-talk-pod"
            REVISION CHANGE-CAUSE
            1          <none>
            2          <none>

            ```
            {: screen}

        2.  Esegui il seguente comando per ripristinare la distribuzione alla revisione precedente. Ancora una volta, un altro pod viene creato e testato da Kubernetes. Quando il test ha esito positivo, il vecchio pod viene rimosso.

            ```
            kubectl rollout undo deployment/watson-talk-pod --to-revision=1
            ```
            {: pre}

            Output:

            ```
            deployment "watson-talk-pod" rolled back
            ```
            {: screen}

        3.  Ottieni il nome del pod da utilizzare nel prossimo passo.

            ```
            kubectl get pods
            ```
            {: pre}

            Output:

            ```
            NAME                              READY     STATUS    RESTARTS   AGE
            watson-talk-pod-2511517105-6tckg  1/1       Running   0          2m
            ```
            {: screen}

        4.  Visualizza i dettagli del pod e verifica che sia stato eseguito il rollback dell'immagine.

            ```
            kubectl describe pod <pod_name>
            ```
            {: pre}

            Output:

            ```
            Image: registry.<region>.bluemix.net/namespace/watson-talk
            ```
            {: screen}

2.  Facoltativo: ripeti le modifiche per la distribuzione watson-pod.

[Verifica la tua conoscenza e fai un quiz! ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://bluemix-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php)

Congratulazioni! Hai distribuito l'applicazione Watson Tone Analyzer. L'agenzia di PR può definitamente iniziare ad utilizzare
questa distribuzione dell'applicazione per iniziare l'analisi dei loro comunicati stampa.

Pronto a eliminare quello che hai precedentemente creato? Puoi utilizzare lo script di configurazione per eliminare le risorse che hai
creato.

```
kubectl delete -f <directory_home_nome_utente>/container-service-getting-started-wt/Stage3/watson-deployment.yml
```
{: pre}

Output:

```
deployment "watson-pod" deleted
deployment "watson-talk-pod" deleted
service "watson-service" deleted
service "watson-talk-service" deleted
```
{: screen}

Se non lo vuoi conservare, puoi eliminare anche il cluster.

```
bx cs cluster-rm <pr_firm_cluster>
```
{: pre}

**Operazioni successive**

Prova ad esplorare i percorsi di orchestrazione del contenitore in [developerWorks ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/code/journey/category/container-orchestration/).
