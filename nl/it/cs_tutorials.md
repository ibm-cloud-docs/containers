---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-16"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Esercitazione: Creazione dei cluster
{: #cs_cluster_tutorial}

Distribuisci e gestisci il tuo proprio cluster Kubernetes nel cloud. Puoi automatizzare la distribuzione, l'operatività, il ridimensionamento e il monitoraggio
delle applicazioni inserite in un contenitore in un cluster di host di calcolo indipendenti
denominati nodi di lavoro.
{:shortdesc}

In questa serie di esercitazioni, puoi vedere come un'agenzia di PR immaginaria utilizza Kubernetes
per distribuire un'applicazione in un contenitore in {{site.data.keyword.Bluemix_short}}. Utilizzo di {{site.data.keyword.toneanalyzerfull}}, l'agenzia di PR analizza i propri comunicati stampa e riceve i feedback.


## Obiettivi

In questa prima esercitazione, agisci come l'amministratore di rete della società di PR. Configuri un cluster Kubernetes personalizzato utilizzato per distribuire un test a una versione Hello World dell'applicazione.

Per configurare l'infrastruttura:

-   Crea un cluster Kubernetes con un nodo di lavoro
-   Installa le CLI per utilizzare l'API Kubernetes e gestire le immagini Docker
-   Crea un repository delle immagini privato in {{site.data.keyword.registrylong_notm}} per archiviare le tue immagini
-   Aggiungi il servizio {{site.data.keyword.toneanalyzershort}} al cluster in modo che ogni applicazione nel cluster possa utilizzare il servizio


## Tempo richiesto

40 minuti


## Destinatari

Questa esercitazione è destinata agli sviluppatori software e agli amministratori di rete che
non hanno mai creato prima un cluster Kubernetes.


## Prerequisiti

-  Un [account {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/registration/)



## Lezione 1: creazione di un cluster e configurazione della CLI
{: #cs_cluster_tutorial_lesson1}

Crea il tuo cluster nella GUI e installa le CLI richieste. Per questa esercitazione, crea il tuo cluster nella regione Regno Unito Sud.


Per creare il tuo cluster:

1. Servono alcuni minuti per eseguire il provisioning del tuo cluster. Per non perdere tempo, [crea il tuo cluster ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/containers-kubernetes/launch?env_id=ibm:yp:united-kingdom) prima di installare le CLI. Un cluster lite viene fornito con un nodo di lavoro in cui distribuire i pod del contenitore. Un nodo di lavoro
è l'host di calcolo, normalmente una macchina virtuale, su cui vengono eseguite le tue applicazioni.


Le seguenti CLI e i rispettivi prerequisiti sono utilizzati per gestire i cluster tramite la CLI:
-   CLI {{site.data.keyword.Bluemix_notm}}
-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes
-   Plug-in {{site.data.keyword.registryshort_notm}}
-   CLI Docker

</br>
Per installare le CLI:

1.  Come prerequisito per il plugin {{site.data.keyword.containershort_notm}}, installa la CLI [{{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://clis.ng.bluemix.net/ui/home.html). Per eseguire i comandi della CLI {{site.data.keyword.Bluemix_notm}}, utilizza il prefisso `bx`.
2.  Segui le istruzioni per selezionare un account e un'organizzazione {{site.data.keyword.Bluemix_notm}}. I cluster sono specifici di un account, ma sono indipendenti da un'organizzazione o uno spazio {{site.data.keyword.Bluemix_notm}}. 

4.  Installa il plugin {{site.data.keyword.containershort_notm}} per creare i cluster Kubernetes e gestire i nodi di lavoro. Per eseguire i comandi del plugin {{site.data.keyword.containershort_notm}}, utilizza il prefisso `bx cs`.

    ```
    bx plugin install container-service -r Bluemix
    ```
    {: pre}

5.  Per visualizzare una versione locale del dashboard Kubernetes e per distribuire le applicazioni nei tuoi cluster,
[installa la CLI Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Per eseguire i comandi utilizzando la CLI Kubernetes, utilizza il prefisso `kubectl`.
    1.  Per una compatibilità funzionale completa, scarica la versione della CLI Kubernetes che corrisponde alla versione del cluster Kubernetes che vuoi utilizzare. La versione Kubernetes predefinita di {{site.data.keyword.containershort_notm}} corrente è 1.7.4.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

          **Suggerimento:** se stai utilizzando Windows, installa la CLI Kubernetes nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Se stai utilizzando OS X o Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Assicurati che /usr/local/bin sia elencato nella tua variabile di sistema `PATH`. La variabile `PATH` contiene tutte le directory in cui il tuo sistema operativo
può trovare i file eseguibili. Le directory elencate nella variabile `PATH`
servono a diversi scopi. `/usr/local/bin` viene utilizzata per memorizzare i file eseguibili
per il software che non fa parte del sistema operativo e che viene installato manualmente dall'amministratore
di sistema.

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

        3.  Rendi il file eseguibile.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6. Per configurare e gestire un repository delle immagini privato in {{site.data.keyword.registryshort_notm}}, installa il plugin
{{site.data.keyword.registryshort_notm}}. Per eseguire i comandi del registro, utilizza il prefisso `bx cr`.

    ```
    bx plugin install container-registry -r Bluemix
    ```
    {: pre}

    Per verificare che i plugin container-service e container-registry siano installati correttamente, esegui il seguente comando:

    ```
    bx plugin list
    ```
    {: pre}

7. Per creare le immagini localmente e per trasmetterle al tuo repository delle immagini privato,
[installa la CLI Docker CE ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/community-edition#/download). Se stai utilizzando Windows 8 o precedenti, puoi invece installare [Docker Toolbox ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/products/docker-toolbox).

Congratulazioni! Hai installato correttamente le CLI per le seguenti esercitazioni e lezioni. Successivamente, configura il tuo ambiente cluster e aggiungi il servizio {{site.data.keyword.toneanalyzershort}}.


## Lezione 2: Configurazione del tuo ambiente cluster
{: #cs_cluster_tutorial_lesson2}

Crea il tuo cluster Kubernetes, configura un repository delle immagini privato in {{site.data.keyword.registryshort_notm}} e aggiungi i segreti al tuo cluster
in modo che l'applicazione possa accedere al servizio {{site.data.keyword.toneanalyzershort}}.

1.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}} utilizzando le tue credenziali {{site.data.keyword.Bluemix_notm}}, quando richiesto.

    ```
    bx login [--sso] -a api.eu-gb.bluemix.net
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza l'indicatore `--sso` per accedere. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso.

2.  Configura il tuo proprio repository delle immagini privato in {{site.data.keyword.registryshort_notm}} per condividere ed archiviare in modo sicuro le immagini Docker
con tutti gli utenti del cluster. Un repository delle immagini privato in {{site.data.keyword.Bluemix_notm}} viene
identificato da uno spazio dei nomi. Lo spazio dei nomi viene utilizzato per creare un URL univoco per il tuo repository delle immagini
che gli sviluppatori possono utilizzare per accedere alle immagini Docker private.

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
    bx cs workers <cluster_name>
    ```
     {: pre}

    Quando il provisioning del tuo nodo di lavoro è completo,
lo stato viene modificato in **Pronto** e puoi iniziare il bind dei servizi {{site.data.keyword.Bluemix_notm}}
da utilizzare in una prossima esercitazione.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status
    kube-par02-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready
    ```
    {: screen}

4.  Configura il contesto per il tuo cluster nella tua CLI. Ogni volta che accedi alla tua CLI del contenitore per utilizzare i cluster, devi eseguire questi comandi
per configurare il percorso al file di configurazione del cluster come una variabile di sessione. La CLI Kubernetes
utilizza questa variabile per trovare i certificati e un file di configurazione locale necessari per il collegamento con il
cluster in {{site.data.keyword.Bluemix_notm}}.

    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
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
        Versione client: v1.7.4
      Versione server: v1.7.4
        ```
        {: screen}

5.  Aggiungi il servizio {{site.data.keyword.toneanalyzershort}} al cluster. Con i servizi {{site.data.keyword.Bluemix_notm}},
puoi approfittare della funzionalità già sviluppata nelle tue applicazioni. Ogni servizio {{site.data.keyword.Bluemix_notm}} associato al
cluster può essere utilizzato da qualsiasi applicazione distribuita in tale cluster. Ripeti i seguenti passi per ogni
servizio {{site.data.keyword.Bluemix_notm}} che desideri utilizzare con le tue applicazioni.
    1.  Aggiungi il servizio {{site.data.keyword.toneanalyzershort}} al tuo account {{site.data.keyword.Bluemix_notm}}.

        **Nota:** quando aggiungi il servizio {{site.data.keyword.toneanalyzershort}} al tuo account, viene visualizzato un messaggio che indica che il servizio non è gratuito. Se limiti la tua chiamata API, per questa esercitazione non sarà addebitato nulla dal tuo servizio {{site.data.keyword.watson}}. [Rivedi le informazioni sul prezzo per il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block).

        ```
        bx service create tone_analyzer standard <mytoneanalyzer>
        ```
        {: pre}

    2.  Esegui il bind dell'istanza {{site.data.keyword.toneanalyzershort}} allo spazio dei nomi Kubernetes `default` del cluster. Successivamente, puoi creare i tuoi propri spazi dei nomi per gestire l'accesso utente alle risorse Kubernetes, ma per ora, utilizza lo spazio dei nomi `default`. Gli spazi dei nomi Kubernetes
sono diversi dallo spazio dei nomi del registro che hai precedentemente creato

        ```
        bx cs cluster-service-bind <cluster_name> default <mytoneanalyzer>
        ```
        {: pre}

        Output:

        ```
        bx cs cluster-service-bind <cluster_name> default <mytoneanalyzer>
        Binding service instance to namespace...
        OK
        Namespace:	default
        Secret name:	binding-mytoneanalyzer
        ```
        {: screen}

6.  Verifica che il segreto Kubernetes sia stato creato nel tuo spazio dei nomi del cluster. Ogni servizio {{site.data.keyword.Bluemix_notm}} viene definito da un file
JSON che include informazioni confidenziali sul servizio, come il nome utente, la
password e l'URL che il contenitore utilizza per accedere al servizio. Per archiviare in modo sicuro queste informazioni, vengono utilizzati i segreti
Kubernetes. In questo esempio, il segreto include le credenziali per l'accesso all'istanza di
{{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} di cui è stato eseguito il provisioning nel tuo account.

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

</br>
Ottimo lavoro! Il cluster è stato configurato e il tuo ambiente locale è pronto per iniziare a distribuire le applicazioni nel cluster.

## Operazioni successive

* [Verifica la tua conoscenza e fai un quiz! ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)

* Prova [Esercitazione: distribuzione delle applicazioni nei cluster Kubernetes
in {{site.data.keyword.containershort_notm}}](cs_tutorials_apps.html#cs_apps_tutorial) per distribuire l'applicazione dell'agenzia di PR
nel cluster che hai creato.
