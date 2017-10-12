---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurazione della CLI e della API
{: #cs_cli_install}

Puoi usare la API o la CLI {{site.data.keyword.containershort_notm}} per creare e gestire i tuoi cluster Kubernetes.
{:shortdesc}

## Installazione della CLI
{: #cs_cli_install_steps}

Installa le CLI richieste per creare e gestire i tuoi cluster Kubernetes in {{site.data.keyword.containershort_notm}} e per distribuire le applicazioni inserite nel contenitore al tuo cluster.
{:shortdesc}

Questa attività include le informazioni per l'installazione di queste CLI e questi plug-in:

-   Versione CLI {{site.data.keyword.Bluemix_notm}} 0.5.0 o successiva
-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes versione 1.5.6 o successiva
-   Facoltativo: plug-in {{site.data.keyword.registryshort_notm}}
-   Facoltativo: Docker versione 1.9. o successiva

<br>
Per installare le CLI:

1.  Come prerequisito per il plugin {{site.data.keyword.containershort_notm}}, installa la CLI [{{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://clis.ng.bluemix.net/ui/home.html). Il prefisso per eseguire i comandi utilizzando la CLI {{site.data.keyword.Bluemix_notm}} è `bx`.

2.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto.

    ```
    bx login
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.



4.  Per creare i cluster Kubernetes e gestire i nodi di lavoro, installa il plugin {{site.data.keyword.containershort_notm}}. Il prefisso per eseguire i comandi utilizzando il plugin {{site.data.keyword.containershort_notm}} è `bx cs`.

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Per verificare che il plugin è installato correttamente, esegui il seguente comando:

    ```
    bx plugin list
    ```
    {: pre}

    Il plugin {{site.data.keyword.containershort_notm}} viene visualizzato nei risultati come container-service.

5.  Per visualizzare una versione locale del dashboard Kubernetes e per distribuire le applicazioni nei tuoi cluster,
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
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Assicurati che `/usr/local/bin` sia elencato nella tua variabile di sistema
`PATH`. La variabile `PATH` contiene tutte le directory in cui il tuo sistema operativo
può trovare i file eseguibili. Le directory elencate nella variabile `PATH`
servono a diversi scopi. `/usr/local/bin` viene utilizzata per memorizzare i file eseguibili
per il software che non fa parte del sistema operativo e che viene installato manualmente dall'amministratore
di sistema.

            ```
            echo $PATH
            ```
            {: pre}

            Output CLI di esempio:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Converti il file binario in
un eseguibile.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6.  Per gestire un repository delle immagini privato, installa il plug-in {{site.data.keyword.registryshort_notm}}. Utilizza questo plug-in per configurare il tuo proprio spazio dei nomi in un multi-tenant, altamente disponibile e il registro delle immagini privato scalabile
ospitato da IBM e per archiviare e condividere le immagini Docker
con altri utenti. Le immagini Docker sono richieste per distribuire i contenitori in un cluster. Il prefisso per l'esecuzione dei comandi di registro è `bx cr`.

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Per verificare che il plugin è installato correttamente, esegui il seguente comando:

    ```
    bx plugin list
    ```
    {: pre}

    Il plugin viene visualizzato nei risultati come container-registry.

7.  Per creare le immagini localmente e per trasmetterle al tuo spazio dei nomi del registro,
[installa Docker ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/community-edition#/download). Se stai utilizzando Windows 8 o precedenti, puoi invece installare [Docker Toolbox ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/products/docker-toolbox). La CLI Docker viene utilizzata per creare le applicazioni nelle immagini. Il prefisso per eseguire i comandi utilizzando la CLI Docker è
`docker`.

Successivamente, avvia la [Creazione dei cluster Kubernetes dalla CLI con {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_cluster_cli).

Per informazioni di riferimento su queste CLI, consulta la documentazione per questi strumenti.

-   [Comandi `bx`](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [Comandi `bx cs`](cs_cli_reference.html#cs_cli_reference)
-   [Comandi `kubectl` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [Comandi `bx cr`](/docs/cli/plugins/registry/index.html#containerregcli)

## Configurazione della CLI per eseguire `kubectl`
{: #cs_cli_configure}

Puoi utilizzare i comandi forniti con la CLI Kubernetes per gestire i cluster in
{{site.data.keyword.Bluemix_notm}}. Tutti i comandi `kubectl` disponibili in Kubernetes 1.5.6 sono supportati per l'utilizzo con i cluster in {{site.data.keyword.Bluemix_notm}}. Dopo che hai creato un cluster, imposta il
contesto per la tua CLI locale su tale cluster con una variabile di ambiente. Puoi quindi eseguire i comandi
`kubectl` Kubernetes per lavorare con il tuo cluster in {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Prima di poter eseguire i comandi `kubectl`, [installa le CLI richieste](#cs_cli_install) e
[crea un cluster](cs_cluster.html#cs_cluster_cli).

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
      -   Stati Uniti Sud

          ```
          bx login -a api.ng.bluemix.net
          ```
          {: pre}

      -   Sydney

          ```
          bx login -a api.au-syd.bluemix.net
          ```
          {: pre}

      -   Germania

          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   Regno Unito

          ```
          bx login -a api.eu-gb.bluemix.net
          ```
          {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

2.  Seleziona un account {{site.data.keyword.Bluemix_notm}}. Se sei assegnato a più organizzazioni {{site.data.keyword.Bluemix_notm}}, seleziona l'organizzazione
dove è stato creato il cluster. I cluster sono specifici di un'organizzazione,
ma sono indipendenti da uno spazio {{site.data.keyword.Bluemix_notm}}. Pertanto, non devi selezionare uno spazio.

3.  Se vuoi creare o accedere ai cluster Kubernetes in un'altra regione rispetto alla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, specifica tale regione. Ad esempio, potresti voler accedere a un'altra regione {{site.data.keyword.containershort_notm}} per i seguenti motivi:
   -   Hai creato i servizi {{site.data.keyword.Bluemix_notm}} o le immagini Docker private in una regione e desideri utilizzarle con {{site.data.keyword.containershort_notm}} in un'altra regione.
   -   Vuoi accedere a un cluster in una regione diversa dalla regione {{site.data.keyword.Bluemix_notm}} predefinita a cui hai eseguito l'accesso.<br>
   Scegli tra i seguenti endpoint API:
        - Stati Uniti Sud:
          ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
          {: pre}

        - Regno Unito-Sud:
          ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
          {: pre}

        - Europa centrale:
          ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
          {: pre}

        - Asia Pacifico Sud:
          ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
          {: pre}

4.  Elenca tutti i cluster nell'account per ottenere il nome del cluster.

    ```
    bx cs clusters
    ```
    {: pre}

5.  Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.
    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Dopo aver scaricato i file di configurazione, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio:

        ```
        export KUBECONFIG=/Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
        ```
        {: screen}

    2.  Copia e incolla il comando visualizzato nel tuo terminale per impostare la variabile di ambiente `KUBECONFIG`.
    3.  Verifica che la variabile di ambiente `KUBECONFIG` sia impostata correttamente.

        Esempio:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Output:
        ```
        /Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
        ```
        {: screen}

6.  Verifica che i comandi `kubectl` siano eseguiti correttamente con il tuo cluster controllando la versione server della CLI
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


Ora puoi eseguire i comandi `kubectl` per gestire i tuoi cluster in {{site.data.keyword.Bluemix_notm}}. Per un elenco completo dei comandi, consulta la [Documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).

**Suggerimento:** se stai utilizzando Windows e la CLI Kubernetes non è installata nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}, devi modificare le directory al percorso in cui è installata la CLI Kubernetes per eseguire correttamente i comandi `kubectl`.

## Aggiornamento della CLI
{: #cs_cli_upgrade}

Per utilizzare le nuove funzioni, ti consigliamo di aggiornare periodicamente le CLI.
{:shortdesc}

Questa attività include le informazioni per aggiornare queste CLI.

-   Versione CLI {{site.data.keyword.Bluemix_notm}} 0.5.0 o successiva
-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes versione 1.5.6 o successiva
-   Plug-in {{site.data.keyword.registryshort_notm}}
-   Docker versione 1.9. o successiva

<br>
Per aggiornare le CLI:
1.  Aggiorna la CLI {{site.data.keyword.Bluemix_notm}}. Scarica la [versione più recente ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://clis.ng.bluemix.net/ui/home.html) ed esegui il programma di installazione.

2.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
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

    -   Stati Uniti Sud

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

    -   Sydney

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -   Germania

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -   Regno Unito

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

3.  Aggiorna il plug-in {{site.data.keyword.containershort_notm}}.
    1.  Installa l'aggiornamento dal repository di plugin {{site.data.keyword.Bluemix_notm}}.

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Verifica l'installazione del plug-in immettendo il seguente comando e controllando l'elenco dei plug-in
installati.

        ```
        bx plugin list
        ```
        {: pre}

        Il plugin {{site.data.keyword.containershort_notm}} viene visualizzato nei risultati come container-service.

    3.  Inizializza la CLI.

        ```
        bx cs init
        ```
        {: pre}

4.  Aggiorna la CLI Kubernetes.
    1.  Scarica la CLI Kubernetes.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Suggerimento:** se stai utilizzando Windows, installa la CLI Kubernetes nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Per gli utenti OSX e Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory /usr/local/bin.

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Assicurati che `/usr/local/bin` sia elencato nella tua variabile di sistema
`PATH`. La variabile `PATH` contiene tutte le directory in cui il tuo sistema operativo
può trovare i file eseguibili. Le directory elencate nella variabile `PATH`
servono a diversi scopi. `/usr/local/bin` viene utilizzata per memorizzare i file eseguibili
per il software che non fa parte del sistema operativo e che viene installato manualmente dall'amministratore
di sistema.

            ```
            echo $PATH
            ```
            {: pre}

            Output CLI di esempio:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Converti il file binario in
un eseguibile.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Aggiorna il plug-in {{site.data.keyword.registryshort_notm}}.
    1.  Installa l'aggiornamento dal repository di plugin {{site.data.keyword.Bluemix_notm}}.

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Verifica l'installazione del plug-in immettendo il seguente comando e controllando l'elenco dei plug-in
installati.

        ```
        bx plugin list
        ```
        {: pre}

        Il plug-in registro viene visualizzato nei risultati come container-registry.

6.  Aggiorna Docker.
    -   Se stai utilizzando Docker Community Edition, avvia Docker, fai clic sull'icona **Docker** e fai clic su **Verifica disponibilità aggiornamenti**.
    -   Se stai utilizzando Docker Toolbox, scarica la [versione più recente ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/products/docker-toolbox) ed esegui il programma di installazione.

## Disinstallazione della CLI
{: #cs_cli_uninstall}

Se non hai più bisogno della CLI, puoi disinstallarla.
{:shortdesc}

Questa attività include le informazioni per rimuovere queste CLI:


-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes versione 1.5.6 o successiva
-   Plug-in {{site.data.keyword.registryshort_notm}}
-   Docker versione 1.9. o successiva

<br>
Per disinstallare le CLI:

1.  Disinstalla il plug-in {{site.data.keyword.containershort_notm}}.

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  Disinstalla il plug-in {{site.data.keyword.registryshort_notm}}.

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  Verifica che i plug-in siano stati disinstallati eseguendo questo comando e controllando l'elenco dei
plug-in installati.

    ```
    bx plugin list
    ```
    {: pre}

    I plugin container-service e container-registry non sono visualizzati nei risultati.





6.  Disinstalla Docker. Le istruzioni per la disinstallazione di Docker variano a seconda del
sistema operativo utilizzato.

    <table summary="Istruzioni specifiche SO per disinstallare Docker">
     <tr>
      <th>Sistema operativo</th>
      <th>Link</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>Scegli di disinstallare Docker dalla [GUI o dalla riga di comando ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset)</td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>Le istruzioni per la disinstallazione di Docker variano a seconda della distribuzione Linux utilizzata. Per
disinstallare Docker per Ubuntu, vedi [Disinstalla Docker ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce). Utilizza questo link per trovare le istruzioni su come
disinstallare Docker per altre distribuzioni Linux selezionando la distribuzione dalla
navigazione.</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>Disinstalla il [Docker toolbox ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox).</td>
      </tr>
    </table>

## Automazione delle distribuzioni dei cluster con l'API
{: #cs_api}

Puoi utilizzare l'API {{site.data.keyword.containershort_notm}}
per automatizzare la creazione, la distribuzione e la gestione dei tuoi cluster Kubernetes.
{:shortdesc}

L'API {{site.data.keyword.containershort_notm}} richiede informazioni
di intestazione che devi fornire nella tua richiesta API e che possono variare in base all'API che vuoi
utilizzare. Per determinare quali informazioni di intestazione sono necessarie per la tua API, vedi la [Documentazione API {{site.data.keyword.containershort_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://us-south.containers.bluemix.net/swagger-api).

La seguente procedura fornisce istruzioni su come recuperare queste informazioni di intestazione, in modo da poterle
includere nella tua richiesta API.

1.  Recupera il tuo token di accesso IAM (Identity and Access Management). Il token di accesso IAM
è richiesto per accedere a {{site.data.keyword.containershort_notm}}. Sostituisci
_&lt;my_bluemix_username&gt;_ e _&lt;my_bluemix_password&gt;_ con
le tue credenziali di
{{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Input parameters to get tokens">
      <tr>
        <th>Parametri di input </th>
        <th>Valori</th>
      </tr>
      <tr>
        <td>Intestazione</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>Corpo</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:</li></ul>
        <p>**Nota:** aggiungi la chiave uaa_client_secret senza alcun valore specificato.</p></td>
      </tr>
    </table>

    Output API di esempio:

    ```
    {
    "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    Puoi
trovare il token IAM nel campo **access_token**e un token UAA nel campo
**uaa_token** del tuo output dell'API. Prendi nota dei token IAM e UAA per recuperare
ulteriori informazioni di intestazione nei prossimi passi.

2.  Recupera l'ID del tuo account {{site.data.keyword.Bluemix_notm}} in cui vuoi creare e
gestire i tuoi cluster. Sostituisci _&lt;iam_token&gt;_ con il token IAM recuperato nel
passo precedente.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="Parametri di input per ottenere l'ID account Bluemix">
   <tr>
    <th>Parametri di input</th>
    <th>Valori</th>
   </tr>
   <tr>
    <td>Intestazioni</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
   </tr>
    </table>

    Output API di esempio:

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<my_bluemix_account_id>",
            "url": "/v1/accounts/<my_bluemix_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    Puoi
trovare l'ID del tuo account {{site.data.keyword.Bluemix_notm}}
nel campo **resources/metadata/guid** dell'output dell'API.

3.  Recupera un nuovo token IAM che include le informazioni sul tuo account {{site.data.keyword.Bluemix_notm}}. Sostituisci
_&lt;my_bluemix_account_id&gt;_ con l'ID del tuo account {{site.data.keyword.Bluemix_notm}} richiamato nel passo
precedente.

    **Nota:** i token di accesso IAM scadono dopo 1 ora. Consulta [Aggiornamento del token di accesso IAM con l'API](#cs_api_refresh) per istruzioni su come aggiornare il tuo token di accesso.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Parametri di input per ottenere i token di accesso">
     <tr>
      <th>Parametri di input</th>
      <th>Valori</th>
     </tr>
     <tr>
      <td>Intestazioni</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>Corpo</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Nota:** aggiungi la chiave uaa_client_secret senza alcun valore specificato.</p>
        <li>bss_account: <em>&lt;my_bluemix_account_id&gt;</em></li></ul></td>
     </tr>
    </table>

    Output API di esempio:

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    ```
    {: screen}

    Puoi
trovare il token IAM nel campo **access_token** e il tuo token di aggiornamento IAM
nel campo **refresh_token** nell'output della CLI.

4.  Recupera l'ID del tuo spazio {{site.data.keyword.Bluemix_notm}} in cui vuoi creare o gestire
il tuo cluster.
    1.  Recupera l'endpoint API per accedere al tuo ID spazio. Sostituisci
_&lt;uaa_token&gt;_ con il token UAA recuperato nel primo
passo.

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="Parametri di input per richiamare l'ID spazio">
         <tr>
          <th>Parametri di input</th>
          <th>Valori</th>
         </tr>
         <tr>
          <td>Intestazione</td>
          <td><ul><li>Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa_token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      Output API di esempio:

      ```
      {
            "metadata": {
              "guid": "<my_bluemix_org_id>",
              "url": "/v2/organizations/<my_bluemix_org_id>",
              "created_at": "2016-01-07T18:55:19Z",
              "updated_at": "2016-02-09T15:56:22Z"
            },
            "entity": {
              "name": "<my_bluemix_org_name>",
              "billing_enabled": false,
              "quota_definition_guid": "<my_bluemix_org_id>",
              "status": "active",
              "quota_definition_url": "/v2/quota_definitions/<my_bluemix_org_id>",
              "spaces_url": "/v2/organizations/<my_bluemix_org_id>/spaces",
      ...

      ```
      {: screen}

5.  Prendi nota dell'output del campo **spaces_url**.
6.  Recupera l'ID del tuo spazio {{site.data.keyword.Bluemix_notm}} utilizzando
l'endpoint
**spaces_url**.

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<my_bluemix_org_id>/spaces
      ```
      {: pre}

      Output API di esempio:

      ```
      {
            "metadata": {
              "guid": "<my_bluemix_space_id>",
              "url": "/v2/spaces/<my_bluemix_space_id>",
              "created_at": "2016-01-07T18:55:22Z",
              "updated_at": null
            },
            "entity": {
              "name": "<my_bluemix_space_name>",
              "organization_guid": "<my_bluemix_org_id>",
              "space_quota_definition_guid": null,
              "allow_ssh": true,
      ...
      ```
      {: screen}

      Puoi
trovare l'ID del tuo spazio {{site.data.keyword.Bluemix_notm}}
nel campo **metadata/guid** dell'output dell'API.

7.  Elenca tutti i cluster Kubernetes nel tuo account. Utilizza le informazioni che hai richiamato nei
passi precedenti per creare le informazioni della tua intestazione.

    -   Stati Uniti Sud

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Regno Unito-Sud

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Europa centrale

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Asia Pacifico Sud

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

        <table summary="Parametri di input per utilizzare l'API">
         <thead>
          <th>Parametri di input</th>
          <th>Valori</th>
         </thead>
          <tbody>
         <tr>
          <td>Intestazione</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  Consulta la [Documentazione API {{site.data.keyword.containershort_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://us-south.containers.bluemix.net/swagger-api) per trovare un elenco di API supportate.

## Aggiornamento dei token di accesso IAM
{: #cs_api_refresh}

Ogni token di accesso IAM (Identity and Access Management) che viene emesso tramite API
scade dopo un'ora. Devi aggiornare regolarmente il tuo token di accesso per garantire l'accesso
all'API {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Prima di iniziare, assicurati di disporre di un token di aggiornamento IAM che
puoi utilizzare per richiedere un nuovo token di accesso. Se non ha un token di aggiornamento, consulta [Automazione del processo di creazione e gestione dei cluster con l'API {{site.data.keyword.containershort_notm}}](#cs_api) per recuperare i tuoi token di accesso.

Attieniti alla seguente procedura se vuoi aggiornare il tuo token IAM.

1.  Recupera un nuovo token di accesso IAM. Sostituisci _&lt;token_aggiornamento_iam&gt;_ con
il token di aggiornamento IAM che hai ricevuto quando hai eseguito l'autenticazione iniziale presso {{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Parametri di input per il novo token IAM">
     <tr>
      <th>Parametri di input</th>
      <th>Valori</th>
     </tr>
     <tr>
      <td>Intestazione</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>Corpo</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>refresh_token: <em>&lt;token_aggiornamento_iam&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Nota:** aggiungi la chiave uaa_client_secret senza alcun valore specificato.</p></li><ul></td>
     </tr>
    </table>

    Output API di esempio:

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    ```
    {: screen}

    Puoi
trovare il tuo nuovo token IAM nel campo **access_token** e il token di aggiornamento IAM
nel campo **refresh_token** del tuo output dell'API.

2.  Continua a lavorare con la [Documentazione API{{site.data.keyword.containershort_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://us-south.containers.bluemix.net/swagger-api) utilizzando il token dal passo precedente.
