---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="_blank"}
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
{:preview: .preview}



# Esercitazione: Creazione dei cluster Kubernetes
{: #cs_cluster_tutorial}

Con questa esercitazione, puoi distribuire e gestire un cluster Kubernetes in {{site.data.keyword.containerlong}}. Segui le procedure pensate per un'agenzia di pubbliche relazioni fittizia per imparare come automatizzare la distribuzione, l'operatività, il ridimensionamento e il monitoraggio di applicazioni inserite nel contenitore in un cluster che si integrano con altri servizi cloud come ad esempio {{site.data.keyword.ibmwatson}}.
{:shortdesc}

## Obiettivi
{: #tutorials_objectives}

In questa esercitazione, lavori per una società di pubbliche relazioni (PR) e completi una serie di lezioni per impostare e configurare un ambiente cluster Kubernetes personalizzato. Innanzitutto, imposti la tua CLI {{site.data.keyword.cloud_notm}}, crei un cluster {{site.data.keyword.containershort_notm}} e archivi le immagini della tua società di PR in un {{site.data.keyword.registrylong}}privato. Esegui quindi il provisioning di un servizio {{site.data.keyword.toneanalyzerfull}} e lo associ mediante bind al tuo cluster. Dopo che hai distribuito e testato un'applicazione Hello Workd nel tuo cluster, distribuisci delle versioni progressivamente più complesse e altamente disponibili della tua applicazione {{site.data.keyword.watson}} in modo che la tua società di PR possa analizzare i comunicati stampa e ricevere un feedback con la più recente tecnologia di intelligenza artificiale.
{:shortdesc}

Il seguente diagramma fornisce una panoramica di quello che hai configurato in questa esercitazione.

<img src="images/tutorial_ov.png" width="500" alt="Diagramma di panoramica della creazione di un cluster e di distribuzione di un'applicazione Watson" style="width:500px; border-style: none"/>

## Tempo richiesto
{: #tutorials_time}

60 minuti


## Destinatari
{: #tutorials_audience}

Questa esercitazione è destinata agli sviluppatori software e agli amministratori di sistema che stanno creando un cluster Kubernetes e distribuendo un'applicazione per la prima volta.
{: shortdesc}

## Prerequisiti
{: #tutorials_prereqs}

-  Controlla i passi che devi seguire per [prepararti a creare un cluster](/docs/containers?topic=containers-clusters#cluster_prepare).
-  Assicurati di disporre delle seguenti politiche di accesso:
    - [**Amministratore** come ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) per {{site.data.keyword.containerlong_notm}}
    - Il [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Amministratore**](/docs/containers?topic=containers-users#platform) per {{site.data.keyword.registrylong_notm}}
    - [**Scrittore** o **Gestore** come ruolo del servizio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) per {{site.data.keyword.containerlong_notm}}

## Lezione 1: Configurazione del tuo ambiente cluster
{: #cs_cluster_tutorial_lesson1}

Crea il tuo cluster Kubernetes nella console {{site.data.keyword.Bluemix_notm}}, installa le CLI richieste, configura il tuo registro contenitori e imposta il contesto per il tuo cluster Kubernetes nella CLI.
{: shortdesc}

Poiché servono alcuni minuti per eseguire il provisioning, crea il tuo cluster prima di configurare il resto del tuo ambiente cluster.

1.  [Nella console {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/kubernetes/catalog/cluster/create), crea un cluster gratuito o standard con un pool di nodi di lavoro che abbia un nodo di lavoro in esso.

    Puoi anche creare un [cluster nella CLI](/docs/containers?topic=containers-clusters#clusters_cli_steps).
    {: tip}
2.  Mentre viene eseguito il provisioning del tuo cluster, installa la CLI [{{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](/docs/cli?topic=cloud-cli-getting-started). L'installazione include:
    -   La CLI {{site.data.keyword.Bluemix_notm}} di base (`ibmcloud`).
    -   Il plugin {{site.data.keyword.containerlong_notm}} (`ibmcloud ks`). Utilizza questo plugin per gestire i cluster Kubernetes, ad esempio per ridimensionare i pool di nodi di lavoro per una capacità di calcolo aggiunta o per associare mediante bind i servizi {{site.data.keyword.Bluemix_notm}} al cluster.
    -   Il plug-in {{site.data.keyword.registryshort_notm}} (`ibmcloud cr`). Utilizza questo plugin per configurare e gestire un repository delle immagini privato in {{site.data.keyword.registryshort_notm}}.
    -   La CLI Kubernetes (`kubectl`). Utilizza questa CLI per distribuire e gestire risorse Kubernetes quali i servizi e i pod della tua applicazione.

    Se desideri utilizzare invece la console {{site.data.keyword.Bluemix_notm}}, dopo che il tuo cluster è stato creato, puoi eseguire i comandi della CLI direttamente dal tuo browser web nel [terminale Kubernetes](/docs/containers?topic=containers-cs_cli_install#cli_web).
    {: tip}
3.  Nel tuo terminale, accedi al tuo account {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali {{site.data.keyword.Bluemix_notm}} quando richiesto. Se disponi di un ID federato, utilizza l'indicatore `--sso` per accedere. Seleziona la regione e, se applicabile, indica come destinazione il gruppo di risorse (`-g`) in cui hai creato il cluster.
    ```
    ibmcloud login [-g <resource_group>] [--sso]
    ```
    {: pre}
5.  Verifica che i plugin siano installati correttamente.
    ```
    ibmcloud plugin list
    ```
    {: pre}

    Il plugin {{site.data.keyword.containerlong_notm}} viene visualizzato nei risultati come **kubernetes-service** e il plugin {{site.data.keyword.registryshort_notm}} viene visualizzato nei risultati come **container-registry**.
6.  Configura il tuo proprio repository delle immagini privato in {{site.data.keyword.registryshort_notm}} per condividere ed archiviare in modo sicuro le immagini Docker
con tutti gli utenti del cluster. Un repository delle immagini privato in {{site.data.keyword.Bluemix_notm}} viene
identificato da uno spazio dei nomi. Lo spazio dei nomi viene utilizzato per creare un URL univoco per il tuo repository delle immagini
che gli sviluppatori possono utilizzare per accedere alle immagini Docker private.
    Ulteriori informazioni sulla [protezione delle tue informazioni personali](/docs/containers?topic=containers-security#pi) quando utilizzi le immagini del contenitore.

    In questo esempio, l'agenzia di PR vuole creare solo
un repository delle immagini in {{site.data.keyword.registryshort_notm}}, per cui sceglie
`agenzia_PR` come proprio spazio dei nomi per raggruppare tutte le immagini nel suo account. Sostituisci `<namespace>` con uno spazio dei nomi di tua scelta che non sia correlato all'esercitazione.

    ```
    ibmcloud cr namespace-add <namespace>
    ```
    {: pre}
7.  Prima di continuare con il prossimo passo, verifica che la distribuzione del tuo nodo di lavoro sia completa.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Quando è finito il provisioning del tuo nodo di lavoro, lo stato viene modificato in **Pronto** e puoi iniziare il bind dei servizi {{site.data.keyword.Bluemix_notm}}.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.13.8
    ```
    {: screen}
8.  Imposta il contesto per il tuo cluster Kubernetes nella tua CLI.
    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes. Ogni volta che accedi alla tua CLI {{site.data.keyword.containerlong}} per utilizzare i cluster, devi eseguire questi comandi per configurare il percorso al file di configurazione del cluster come una variabile di sessione. La CLI Kubernetes
utilizza questa variabile per trovare i certificati e un file di configurazione locale necessari per il collegamento con il
cluster in {{site.data.keyword.Bluemix_notm}}.<p class="tip">Stai utilizzando Windows PowerShell? Includi l'indicatore `--powershell` per ottenere le variabili di ambiente in formato Windows PowerShell.</p>
        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/    pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}
    2.  Copia e incolla il comando visualizzato nel tuo terminale per impostare la variabile di ambiente `KUBECONFIG`.
    3.  Verifica che la variabile di ambiente `KUBECONFIG` sia impostata correttamente.

        Esempio per OS X:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Output di esempio:

        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
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
        Client Version: v1.13.8
        Server Version: v1.13.8
        ```
        {: screen}

Ottimo lavoro! Hai correttamente installato le CLI e configurato il tuo contesto del cluster per le seguenti lezioni. Successivamente, configura il tuo ambiente cluster e aggiungi il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.

<br />


## Lezione 2: Aggiunta di un servizio IBM Cloud al tuo cluster
{: #cs_cluster_tutorial_lesson2}

Con i servizi {{site.data.keyword.Bluemix_notm}},
puoi approfittare della funzionalità già sviluppata nelle tue applicazioni. Qualsiasi servizio {{site.data.keyword.Bluemix_notm}} associato al
cluster Kubernetes può essere utilizzato da qualsiasi applicazione distribuita in tale cluster. Ripeti i seguenti passi per ogni
servizio {{site.data.keyword.Bluemix_notm}} che desideri utilizzare con le tue applicazioni.
{: shortdesc}

1.  Aggiungi il servizio {{site.data.keyword.toneanalyzershort}} al tuo account {{site.data.keyword.Bluemix_notm}} nella stessa regione del tuo cluster. Sostituisci `<service_name>` con un nome per la tua istanza del servizio e `<region>` con una regione, come quella in cui si trova il tuo cluster.

    Quando aggiungi il servizio {{site.data.keyword.toneanalyzershort}} al tuo account, viene visualizzato un messaggio che indica che il servizio non è gratuito. Se limiti la tua chiamata API, per questa esercitazione non sarà addebitato nulla dal tuo servizio {{site.data.keyword.watson}}. [Rivedi le informazioni sul prezzo per il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/catalog/services/tone-analyzer).
    {: note}

    ```
    ibmcloud resource service-instance-create <service_name> tone-analyzer standard <region>
    ```
    {: pre}
2.  Esegui il bind dell'istanza {{site.data.keyword.toneanalyzershort}} allo spazio dei nomi Kubernetes `default` del cluster. Successivamente, puoi creare i tuoi propri spazi dei nomi per gestire l'accesso utente alle risorse Kubernetes, ma per ora, utilizza lo spazio dei nomi `default`. Gli spazi dei nomi Kubernetes
sono diversi dallo spazio dei nomi del registro che hai precedentemente creato
    ```
    ibmcloud ks cluster-service-bind --cluster <cluster_name> --namespace default --service <service_name>
    ```
    {: pre}

    Output di esempio:
    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}
3.  Verifica che il segreto Kubernetes sia stato creato nel tuo spazio dei nomi del cluster. Quando [associ mediante bind un servizio {{site.data.keyword.Bluemix_notm}} al tuo cluster](/docs/containers?topic=containers-service-binding), viene generato un file JSON che include informazioni riservate quali la chiave API {{site.data.keyword.Bluemix_notm}} IAM (Identity and Access Management) e l'URL utilizzato dal contenitore per ottenere l'accesso al servizio. Per archiviare in modo protetto queste informazioni, il file JSON viene memorizzato in un segreto Kubernetes.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Output di esempio:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
Ottimo lavoro! Il tuo cluster è configurato e il tuo ambiente locale è pronto per iniziare a distribuire le applicazioni nel cluster.

Prima di continuare con la prossima lezione, perché non testare le tue conoscenze e [fare un breve quiz![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)?
{: note}

<br />


## Lezione 3: Distribuzione di singole applicazioni dell'istanza ai cluster Kubernetes
{: #cs_cluster_tutorial_lesson3}

Nella precedente lezione, hai configurato un cluster con un singolo nodo di lavoro. In questa lezione, configura una distribuzione e distribuisci una sola istanza dell'applicazione in un pod Kubernetes nel nodo di lavoro.
{:shortdesc}

Il seguente diagramma mostra i componenti che distribuisci completando questa lezione.

![Impostazioni di distribuzione](images/cs_app_tutorial_mz-components1.png)

Per distribuire l'applicazione:

1.  Clona il codice di origine per l'[applicazione Hello world ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM/container-service-getting-started-wt) nella tua directory home utente. Il repository contiene diverse versioni di un'applicazione simile nelle cartelle, ognuna delle quali inizia con `Lab`. Ogni versione contiene i seguenti file:
    *   `Dockerfile`: le definizioni di build dell'immagine.
    *   `app.js`: l'applicazione Hello world.
    *   `package.json`: i metadati dell'applicazione.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

2.  Passa alla directory `Lab 1`.
    ```
    cd 'container-service-getting-started-wt/Lab 1'
    ```
    {: pre}
3.  Accedi alla CLI {{site.data.keyword.registryshort_notm}}.
    ```
    ibmcloud cr login
    ```
    {: pre}

    Se hai dimenticato il tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}},
esegui il seguente comando.
    ```
    ibmcloud cr namespace-list
    ```
    {: pre}
4.  Crea un'immagine Docker che include i file dell'applicazione della directory `Lab 1` ed esegui il push dell'immagine allo spazio dei nomi {{site.data.keyword.registryshort_notm}} che hai creato nella lezione precedente. Se hai bisogno di effettuare una modifica all'applicazione in futuro, ripeti questi passi per creare un'altra versione
dell'immagine. **Nota**: acquisisci ulteriori informazioni sulla [protezione delle tue informazioni personali](/docs/containers?topic=containers-security#pi) quando utilizzi le immagini del contenitore.

    Utilizza caratteri alfanumerici minuscoli o di sottolineatura (`_`) solo nei nomi di immagine. Non dimenticare il punto (`.`) alla fine del comando. Il punto indica a Docker di guardare all'interno della directory corrente per trovare il Dockerfile e le risorse di build per creare l'immagine. **Nota**: devi specificare una [regione del registro](/docs/services/Registry?topic=registry-registry_overview#registry_regions), come ad esempio `us`. Per ottenere la regione del registro in cui ti trovi attualmente, esegui `ibmcloud cr region`.

    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:1 .
    ```
    {: pre}

    Quando la creazione è completa, verifica di ricevere il seguente messaggio di esito positivo:

    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
5.  Crea una distribuzione. Le distribuzioni sono utilizzate per gestire i pod, che includono le istanze inserite nel contenitore di un'applicazione. Il seguente comando distribuisce l'applicazione in un singolo pod facendo riferimento all'immagine che hai creato nel tuo registro privato. Per gli scopi di questa esercitazione, la distribuzione viene denominata **hello-world-deployment** ma puoi fornirle qualsiasi nome tu voglia.
    ```
    kubectl create deployment hello-world-deployment --image=<region>.icr.io/<namespace>/hello-world:1
    ```
    {: pre}

    Output di esempio:
    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Ulteriori informazioni sulla [protezione delle tue informazioni personali](/docs/containers?topic=containers-security#pi) quando utilizzi le risorse Kubernetes.
6.  Rendi la tua applicazione accessibile al mondo esponendo la distribuzione come un servizio NodePort. Così come puoi esporre una porta per un'applicazione Cloud Foundry, la NodePort esposta è la porta su cui il nodo di lavoro è in ascolto per il traffico.
    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Output di esempio:
    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table summary="Informazioni sui parametri del comandi expose.">
    <caption>Ulteriori informazioni sui parametri di esposizione</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Ulteriori informazioni sui parametri di esposizione</th>
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
    <td>La porta che il servizio utilizza.</td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>Il tipo di servizio da creare.</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>La porta su cui il servizio gestisce il traffico. In questa istanza, la porta di destinazione è la stessa porta, ma per altre applicazioni che hai creato potrebbe essere diversa.</td>
    </tr>
    </tbody></table>
7. Ora che tutto il lavoro di distribuzione è stato effettuato, puoi verificare la tua applicazione in un browser. Ottieni i dettagli dal formato dell'URL.
    1.  Ottieni le informazioni sul servizio per visualizzare quale NodePort è stata assegnata.
        ```
        kubectl describe service hello-world-service
        ```
        {: pre}

        Output di esempio:
        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.xxx.xx.xxx
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.xxx.xxx:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Le NodePort sono assegnate casualmente quando vengono generate con il comando `expose`, ma comprese nell'intervallo 30000-32767. In questo esempio, la NodePort è 30872.
    2.  Ottieni l'indirizzo IP pubblico per il nodo di lavoro nel cluster.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Output di esempio:
        ```
        ibmcloud ks workers --cluster pr_firm_cluster
        Listing cluster workers...
        OK
        ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
        kube-mil01-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.13.8
        ```
        {: screen}
8. Apri un browser e controlla l'applicazione con il seguente URL: `http://<IP_address>:<NodePort>`. Con i valori di esempio, l'URL è `http://169.xx.xxx.xxx:30872`. Quando immetti tale URL in un browser, puoi visualizzare il seguente testo.
    ```
    Hello world! La tua applicazione è attiva e in esecuzione in un cluster!
    ```
    {: screen}

    Per vedere se l'applicazione è disponibile pubblicamente, tenta di immetterla in un browser nel tuo cellulare.
    {: tip}
9. [Avvia il dashboard Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).

    Se selezioni il tuo cluster nella [console {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/), puoi utilizzare il pulsante **Dashboard Kubernetes** per avviare il tuo dashboard con un clic.
    {: tip}
10. Nella scheda **Carichi di lavoro**, puoi visualizzare le risorse che hai creato.

Ottimo lavoro! Hai distribuito la tua prima versione dell'applicazione.

Troppi comandi in questa lezione? D'accordo. Come l'utilizzo di uno script di configurazione può fare del lavoro al tuo posto? Per utilizzare uno script di configurazione per la seconda versione dell'applicazione e per creare una maggiore disponibilità distribuendo più istanze di tale applicazione, continua con la prossima lezione.

**Ripulitura**<br>
Vuoi eliminare le risorse che hai creato in questa lezione prima di andare avanti? Quando hai creato la distribuzione, Kubernetes ha assegnato un'etichetta alla distribuzione, `app=hello-world-deployment` (o qualsiasi nome tu abbia dato alla distribuzione). Quindi, quando hai esposto la distribuzione, Kubernetes ha applicato la stessa etichetta al servizio che è stato creato. Le etichette sono strumenti utili per consentirti di organizzare le tue risorse Kubernetes in modo da poter applicare ad esse operazioni globali quali `get` o `delete`.

  Puoi controllare tutte le tue risorse che hanno l'etichetta `app=hello-world-deployment`.
  ```
  kubectl get all -l app=hello-world-deployment
  ```
  {: pre}

  Puoi quindi eliminare tutte le risorse con l'etichetta.
  ```
  kubectl delete all -l app=hello-world-deployment
  ```
  {: pre}

  Output di esempio:
  ```
  pod "hello-world-deployment-5c78f9b898-b9klb" deleted
  service "hello-world-service" deleted
  deployment.apps "hello-world-deployment" deleted
  ```
  {: screen}

<br />


## Lezione 4: Distribuzione e aggiornamento delle applicazioni con una maggiore disponibilità
{: #cs_cluster_tutorial_lesson4}

In questa lezione, distribuisci tre istanze dell'applicazione Hello World in un cluster per una maggiore disponibilità rispetto alla prima versione dell'applicazione.
{:shortdesc}

Maggiore disponibilità significa che l'accesso dell'utente è diviso tra le tre istanze. Quando troppi utenti stanno tentando di accedere alla stessa istanza dell'applicazione, potrebbero ravvisare tempi di risposta lenti. Più istanze possono voler dire tempi di risposta più veloci per i tuoi utenti. In questa lezione, impari anche come i controlli dell'integrità e gli aggiornamenti della distribuzione possono funzionare con Kubernetes. Il seguente diagramma include i componenti che distribuisci completando questa lezione.

![Impostazioni di distribuzione](images/cs_app_tutorial_mz-components2.png)

Nelle lezioni precedenti, hai creato il tuo cluster con un singolo nodo di lavoro e hai distribuito una singola istanza di un'applicazione. In questa lezione, configura una distribuzione e distribuisci tre istanze dell'applicazione Hello World. Ogni istanza viene distribuita in un pod Kubernetes come parte di una serie di repliche nel nodo di lavoro. Per renderla pubblicamente disponibile, crea anche un servizio Kubernetes.

Come definito nello script di configurazione, Kubernetes può utilizzare un controllo di disponibilità per visualizzare se un contenitore in un pod è in esecuzione o meno. Ad esempio, questi controlli potrebbero individuare dei deadlock, dove un'applicazione è in esecuzione, ma non è in grado di fare progressi. Riavviare un contenitore in questa condizione può aiutare a rendere l'applicazione più disponibile nonostante i bug. Quindi, Kubernetes utilizza un controllo di disponibilità per conoscere quando un contenitore è pronto per iniziare ad accettare nuovamente il traffico. Un pod è considerato pronto quanto il suo contenitore è pronto. Quando il pod è pronto, viene riavviato. In questa versione dell'applicazione, ogni 15 secondi va in timeout. Con un controllo dell'integrità configurato nello script di configurazione, i contenitori vengono ricreati se il controllo dell'integrità trova un problema con l'applicazione.

Se hai fatto una pausa dall'ultima lezione e hai avviato un nuovo terminale, assicurati di accedere di nuovo al tuo cluster.

1.  Nel tuo terminale, vai alla directory `Lab 2`.
    ```
    cd 'container-service-getting-started-wt/Lab 2'
    ```
    {: pre}
2.  Crea, apponi tag ed esegui il push dell'applicazione come un'immagine nel tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}. Non dimenticare il punto (`.`) alla fine del comando.
    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:2 .
      ```
    {: pre}

    Verifica di poter visualizzare il messaggio di esito positivo.
    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
3.  Nella directory `Lab 2`, apri il file `healthcheck.yml` con un editor di testo. Questo script di configurazione combina alcuni passi dalla lezione precedente per creare una distribuzione e un servizio contemporaneamente. Gli sviluppatori dell'applicazione dell'agenzia di PR possono utilizzare questi script quando effettuano degli aggiornamenti o per risolvere i problemi ricreando i pod.
    1.  Aggiorna i dettagli dell'immagine nel tuo spazio dei nomi del registro privato.
        ```
        image: "<region>.icr.io/<namespace>/hello-world:2"
        ```
        {: codeblock}
    2.  Nella sezione **Distribuzione**, prendi nota di `replicas`. Le repliche sono il numero di istanze della tua applicazione. Eseguire tre istanze rende l'applicazione più disponibile rispetto a una sola istanza.
        ```
        replicas: 3
        ```
        {: codeblock}
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
    4.  Nella sezione **Servizio**, prendi nota di `NodePort`. Invece di generare una NodePort casuale come hai fatto nella precedente lezione, puoi specificare una porta nell'intervallo 30000 - 32767. Questo esempio utilizza 30072.
4.  Ritorna alla CLI che hai utilizzato per configurare il tuo contesto del cluster ed esegui lo script di configurazione. Una volta creati la distribuzione e il servizio, l'applicazione è disponibile per la visualizzazione da parte degli utenti dell'agenzia di PR.
    ```
    kubectl apply -f healthcheck.yml
    ```
    {: pre}

    Output di esempio:
    ```
    deployment "hw-demo-deployment" created
  service "hw-demo-service" created
    ```
    {: screen}
5.  Ora che il lavoro di distribuzione è stato effettuato, apri un browser e controlla l'applicazione. Per creare l'URL, prendi lo stesso indirizzo IP pubblico che hai utilizzato nella lezione precedente per il tuo nodo di lavoro e combinalo con la NodePort specificata nello script di configurazione. Per ottenere l'indirizzo IP pubblico per il nodo di lavoro:
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Con i valori di esempio, l'URL è `http://169.xx.xxx.xxx:30072`. In un browser, potresti visualizzare il seguente testo. Se non visualizzi questo testo, non ti preoccupare. Questa applicazione è progettata per essere attiva e disattiva.
    ```
    Hello world! Ottimo lavoro per aver reso la seconda fase attiva e in esecuzione!
    ```
    {: screen}

    Puoi anche controllare `http://169.xx.xxx.xxx:30072/healthz` per lo stato.

    Per i primi 10 - 15 secondi, viene restituito un messaggio 200, in modo che puoi sapere se l'applicazione è in esecuzione correttamente. Dopo questi 15 secondi, viene visualizzato un messaggio di timeout. Questo è un comportamento previsto.
    ```
    {
      "error": "Timeout, Health check error!"
  }
    ```
    {: screen}
6.  Controlla lo stato del tuo pod per monitorare l'integrità della tua applicazione in Kubernetes. Puoi controllare lo stato dalla CLI o nel dashboard Kubernetes.
    *   **Dalla CLI**: guarda cosa sta accadendo ai tuoi pod mentre cambiano stato.
        ```
        kubectl get pods -o wide -w
        ```
        {: pre}
    *   **Dal dashboard Kubernetes**:
        1.  [Avvia il dashboard Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).
        2.  Nella scheda **Carichi di lavoro**, puoi visualizzare le risorse che hai creato. Da questa scheda, puoi continuamente aggiornare e visualizzare che il controllo di integrità stia funzionando. Nella sezione **Pod**, puoi visualizzare quante volte i pod vengono riavviati quando i contenitori in essi vengono ricreati. Se ti capita di ricevere il seguente errore nel dashboard,
questo messaggio indica che il controllo di integrità ha rilevato un problema. Attendi alcuni minuti e aggiorna di nuovo. Vedrai il numero di riavvio delle modifiche per ogni
pod.
        ```
        Liveness probe failed: HTTP probe failed with statuscode: 500
        Back-off restarting failed docker container
        Error syncing pod, skipping: failed to "StartContainer" for "hw-container" w      CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-d     deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
        ```
        {: screen}

Bene, hai distribuito la seconda versione dell'applicazione. Hai dovuto utilizzare meno comandi, hai imparato come funzionano i controlli di integrità e modificato una distribuzione, il che è fantastico! L'applicazione Hello world ha superato il test per l'agenzia di PR. Ora, puoi distribuire un'applicazione più utile per l'agenzia di PR per iniziare l'analisi dei comunicati stampa.

**Ripulitura**<br>
Pronto a eliminare quello che hai creato prima di continuare con la prossima lezione? Questa volta, puoi utilizzare lo stesso script di configurazione per eliminare le risorse che hai creato.

  ```
  kubectl delete -f healthcheck.yml
  ```
  {: pre}

  Output di esempio:

  ```
  deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
  ```
  {: screen}

<br />


## Lezione 5: Distribuzione e aggiornamento dell'applicazione Watson Tone Analyzer
{: #cs_cluster_tutorial_lesson5}

Nelle precedenti lezioni, le applicazioni sono state distribuite come singoli componenti in un nodo di lavoro. In questa lezione, puoi distribuire due componenti di un'applicazione in un cluster che utilizza il servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.
{:shortdesc}

Separare i componenti in contenitori differenti ti assicura di poterne aggiornare uno
senza influenzare gli altri. Quindi, aggiorni l'applicazione per scalarla con più repliche per renderla altamente disponibile. Il seguente diagramma include i componenti che distribuisci completando questa lezione.

![Impostazioni di distribuzione](images/cs_app_tutorial_mz-components3.png)

Dall'esercitazione precedente, hai il tuo account e un cluster con un nodo di lavoro. In questa lezione, crea un'istanza del servizio {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} nel tuo account {{site.data.keyword.Bluemix_notm}} e configura due distribuzioni, una per ogni componente dell'applicazione. Ogni componente viene distribuito in un pod Kubernetes nel nodo di lavoro. Per rendere entrambi questi componenti pubblicamente disponibili, crea anche un servizio Kubernetes per ogni componente.


### Lezione 5a: Distribuzione dell'applicazione {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}
{: #lesson5a}

Distribuisci le applicazioni {{site.data.keyword.watson}}, accedi al servizio pubblicamente e analizza del testo con l'applicazione.
{: shortdesc}

Se hai fatto una pausa dall'ultima lezione e hai avviato un nuovo terminale, assicurati di accedere di nuovo al tuo cluster.

1.  In una CLI, passa alla directory `Lab 3`.
    ```
    cd 'container-service-getting-started-wt/Lab 3'
    ```
    {: pre}

2.  Crea la prima immagine {{site.data.keyword.watson}}.
    1.  Passa alla directory `watson`.
        ```
        cd watson
        ```
        {: pre}
    2.  Crea, apponi tag ed esegui il push dell'applicazione `watson` come un'immagine al tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}. Nuovamente, non dimenticare il punto (`.`) alla fine del comando.
        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson .
        ```
        {: pre}

        Verifica di poter visualizzare il messaggio di esito positivo.
        ```
        Successfully built <image_id>
        ```
        {: screen}
    3.  Ripeti questa procedura per creare la seconda immagine `watson-talk`.
        ```
        cd 'container-service-getting-started-wt/Lab 3/watson-talk'
        ```
        {: pre}

        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson-talk .
        ```
        {: pre}
3.  Verifica che le immagini siano state correttamente aggiunte al tuo spazio dei nomi del registro.
    ```
    ibmcloud cr images
    ```
    {: pre}

    Output di esempio:

    ```
    Listing images...

    REPOSITORY                        NAMESPACE  TAG      DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    us.icr.io/namespace/watson        namespace  latest   fedbe587e174   3 minutes ago   274 MB   OK
    us.icr.io/namespace/watson-talk   namespace  latest   fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}
4.  Nella directory `Lab 3`, apri il file `watson-deployment.yml` con un editor di testo. Questo script di configurazione include una distribuzione e un servizio per entrambi i componenti `watson` e `watson-talk` dell'applicazione.
    1.  Aggiorna i dettagli dell'immagine nel tuo spazio dei nomi del registro per entrambe le distribuzioni.
        **watson**:
        ```
        image: "<region>.icr.io/<namespace>/watson"
        ```
        {: codeblock}

        **watson-talk**:
        ```
        image: "<region>.icr.io/<namespace>/watson-talk"
        ```
        {: codeblock}
    2.  Nella sezione volumes della distribuzione `watson-pod`, aggiorna il nome del segreto {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} che hai creato nella [Lezione 2](#cs_cluster_tutorial_lesson2). Montando il segreto Kubernetes come un volume alla tua distribuzione, rendi la chiave API {{site.data.keyword.Bluemix_notm}} IAM (Identity and Access Management) disponibile al contenitore che è in esecuzione nel tuo pod. I componenti dell'applicazione {{site.data.keyword.watson}} in questa esercitazione sono configurati per cercare la chiave API utilizzando il percorso di montaggio del volume.
        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-mytoneanalyzer
        ```
        {: codeblock}

        Se hai dimenticato come hai denominato il segreto, immetti il seguente comando.
        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}
    3.  Nella sezione del servizio watson-talk, prendi nota del valore impostato per la
`NodePort`. Questo esempio utilizza 30080.
5.  Esegui lo script di configurazione.
    ```
    kubectl apply -f watson-deployment.yml
    ```
    {: pre}
6.  Facoltativo: verifica che il segreto {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} sia montato come un volume al pod.
    1.  Per ottenere il nome di un pod watson, esegui il seguente comando.
        ```
        kubectl get pods
        ```
        {: pre}

        Output di esempio:
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

        Output di esempio:
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
7.  Apri un browser e analizza del testo. Il formato dell'URL è `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/ "<text_to_analyze>"`.
    Esempio:
    ```
    http://169.xx.xxx.xxx:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    In
un browser, puoi visualizzare la risposta JSON per il testo che hai immesso.
    ```
    {
      "document_tone": {
        "tone_categories": [
          {
            "tones": [
              {
                "score": 0.011593,
                "tone_id": "anger",
                "tone_name": "Anger"
              },
              ...
            "category_id": "social_tone",
            "category_name": "Social Tone"
          }
        ]
      }
    }
    ```
    {: screen}
8. [Avvia il dashboard Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).
9. Nella scheda **Carichi di lavoro**, puoi visualizzare le risorse che hai creato.

### Lezione 5b: Aggiornamento della distribuzione Watson Tone Analyzer in esecuzione
{: #lesson5b}

Mentre una distribuzione è in esecuzione, puoi modificare la distribuzione per modificare i valori nel template di pod. In questa lezione, l'agenzia di PR vuole modificare l'applicazione nella distribuzione aggiornando l'immagine che viene utilizzata.
{: shortdesc}

Cambia il nome dell'immagine:

1.  Apri i dettagli della configurazione per la distribuzione in esecuzione.
    ```
    kubectl edit deployment/watson-talk-pod
    ```
    {: pre}

    A seconda del tuo sistema operativo,
si apre un editor vi o un editor di testo.
2.  Cambia il nome dell'immagine in `ibmliberty`.
    ```
    spec:
          containers:
          - image: <region>.icr.io/ibmliberty:latest
    ```
    {: codeblock}
3.  Salva le modifiche e esci dall'editor.
4.  Applica le modifiche alla distribuzione in esecuzione.
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
    Quando distribuisci una modifica, un altro pod viene creato e testato da Kubernetes. Quando il test ha esito positivo, il vecchio pod viene rimosso.

Ottimo lavoro! Hai distribuito l'applicazione {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} e imparato come eseguire un semplice aggiornamento dell'applicazione. L'agenzia di PR può utilizzare questa distribuzione per iniziare ad analizzare i propri comunicati stampa con la più recente tecnologia di intelligenza artificiale.

**Ripulitura**<br>
Pronto a eliminare l'applicazione {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} che hai creato nel tuo cluster {{site.data.keyword.containerlong_notm}}? Puoi utilizzare lo script di configurazione per eliminare le risorse che hai creato.

  ```
  kubectl delete -f watson-deployment.yml
  ```
  {: pre}

  Output di esempio:

  ```
  deployment "watson-pod" deleted
deployment "watson-talk-pod" deleted
service "watson-service" deleted
service "watson-talk-service" deleted
  ```
  {: screen}

  Se non lo vuoi conservare, puoi eliminare anche il cluster.

  ```
  ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
  ```
  {: pre}

È il momento di un quiz. Hai affrontato molti argomenti; ti invitiamo pertanto ad [assicurarti di averli compresi tutti ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php). Non ti preoccupare, il quiz non è cumulativo!
{: note}

<br />


## Operazioni successive
{: #tutorials_next}

Ora che hai acquisito le basi, puoi passare ad attività più avanzate. Prendi in considerazione di provare una delle seguenti risorse per fare di più con {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

*   Completa un [lab più complicato ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM/container-service-getting-started-wt#lab-overview) nel repository.
*   Impara come creare [applicazioni altamente disponibili](/docs/containers?topic=containers-ha) utilizzando funzioni quali i cluster multizona, l'archiviazione persistente, il cluster autoscaler e il ridimensionamento pod orizzontale per le applicazioni.
*   Esplora i modelli di codice di orchestrazione del contenitore in [IBM Developer ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/technologies/containers/).
