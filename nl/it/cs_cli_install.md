---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-15"

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

<br />


## Installazione della CLI
{: #cs_cli_install_steps}

Installa le CLI richieste per creare e gestire i tuoi cluster Kubernetes in {{site.data.keyword.containershort_notm}} e per distribuire le applicazioni inserite nel contenitore al tuo cluster.
{:shortdesc}

Questa attività include le informazioni per l'installazione di queste CLI e questi plug-in:

-   Versione CLI {{site.data.keyword.Bluemix_notm}} 0.5.0 o successiva
-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes versione 1.7.4 o successiva
-   Facoltativo: plug-in {{site.data.keyword.registryshort_notm}}
-   Facoltativo: Docker versione 1.9 o successive

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

3.  Per creare i cluster Kubernetes e gestire i nodi di lavoro, installa il plugin {{site.data.keyword.containershort_notm}}. Il prefisso per eseguire i comandi utilizzando il plugin {{site.data.keyword.containershort_notm}} è `bx cs`.

    ```
    bx plugin install container-service -r Bluemix
    ```
    {: pre}

    Per verificare che il plugin è installato correttamente, esegui il seguente comando:

    ```
    bx plugin list
    ```
    {: pre}

    Il plugin {{site.data.keyword.containershort_notm}} viene visualizzato nei risultati come container-service.

4.  Per visualizzare una versione locale del dashboard Kubernetes e per distribuire le applicazioni nei tuoi cluster,
[installa la CLI Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Il prefisso per eseguire i comandi utilizzando la CLI Kubernetes è
`kubectl`.

    1.  Per una compatibilità funzionale completa, scarica la versione della CLI Kubernetes che corrisponde alla versione del cluster Kubernetes che vuoi utilizzare. La versione Kubernetes predefinita di {{site.data.keyword.containershort_notm}} corrente è 1.7.4.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

        **Suggerimento:** se stai utilizzando Windows, installa la CLI Kubernetes nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Per gli utenti OSX e Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
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

        3.  Rendi il file eseguibile.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Per gestire un repository delle immagini privato, installa il plug-in {{site.data.keyword.registryshort_notm}}. Utilizza questo plug-in per configurare il tuo proprio spazio dei nomi in un multi-tenant, altamente disponibile e il registro delle immagini privato scalabile
ospitato da IBM e per archiviare e condividere le immagini Docker
con altri utenti. Le immagini Docker sono richieste per distribuire i contenitori in un cluster. Il prefisso per l'esecuzione dei comandi di registro è `bx cr`.

    ```
    bx plugin install container-registry -r Bluemix
    ```
    {: pre}

    Per verificare che il plugin è installato correttamente, esegui il seguente comando:

    ```
    bx plugin list
    ```
    {: pre}

    Il plugin viene visualizzato nei risultati come container-registry.

6.  Per creare le immagini localmente e per trasmetterle al tuo spazio dei nomi del registro,
[installa Docker ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/community-edition#/download). Se stai utilizzando Windows 8 o precedenti, puoi invece installare [Docker Toolbox ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.docker.com/products/docker-toolbox). La CLI Docker viene utilizzata per creare le applicazioni nelle immagini. Il prefisso per eseguire i comandi utilizzando la CLI Docker è
`docker`.

Successivamente, avvia la [Creazione dei cluster Kubernetes dalla CLI con {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_cluster_cli).

Per informazioni di riferimento su queste CLI, consulta la documentazione per questi strumenti.

-   [Comandi `bx`](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [Comandi `bx cs`](cs_cli_reference.html#cs_cli_reference)
-   [Comandi `kubectl` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.7/)
-   [Comandi `bx cr`](/docs/cli/plugins/registry/index.html)

<br />


## Configurazione della CLI per eseguire `kubectl`
{: #cs_cli_configure}

Puoi utilizzare i comandi forniti con la CLI Kubernetes per gestire i cluster in
{{site.data.keyword.Bluemix_notm}}. Tutti i comandi `kubectl` disponibili in Kubernetes 1.7.4 sono supportati per l'utilizzo con i cluster in {{site.data.keyword.Bluemix_notm}}. Dopo che hai creato un cluster, imposta il
contesto per la tua CLI locale su tale cluster con una variabile di ambiente. Puoi quindi eseguire i comandi
`kubectl` Kubernetes per lavorare con il tuo cluster in {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Prima di poter eseguire i comandi `kubectl`, [installa le CLI richieste](#cs_cli_install) e
[crea un cluster](cs_cluster.html#cs_cluster_cli).

1.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto. Per specificare una regione {{site.data.keyword.Bluemix_notm}}, [includi l'endpoint API](cs_regions.html#bluemix_regions).

      ```
      bx login
      ```
      {: pre}

      **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

  2.  Seleziona un account {{site.data.keyword.Bluemix_notm}}. Se sei assegnato a più organizzazioni {{site.data.keyword.Bluemix_notm}}, seleziona l'organizzazione
dove è stato creato il cluster. I cluster sono specifici di un'organizzazione, ma sono indipendenti da uno spazio {{site.data.keyword.Bluemix_notm}}. Pertanto, non devi selezionare uno spazio.

  3.  Se vuoi creare o accedere ai cluster Kubernetes in un'altra regione rispetto alla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, [specifica l'endpoint dell'API della regione {{site.data.keyword.containershort_notm}} ](cs_regions.html#container_login_endpoints).

      **Nota**: se desideri creare un cluster negli Stati Uniti Est, devi specificare l'endpoint dell'API della regione del contenitore Stati Uniti Est utilizzando il comando `bx cs init --host https://us-east.containers.bluemix.net`.

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
      Versione client: v1.7.4
      Versione server: v1.7.4
      ```
      {: screen}

Ora puoi eseguire i comandi `kubectl` per gestire i tuoi cluster in {{site.data.keyword.Bluemix_notm}}. Per un elenco completo dei comandi, consulta la [Documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.7/).

**Suggerimento:** se stai utilizzando Windows e la CLI Kubernetes non è installata nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}, devi modificare le directory al percorso in cui è installata la CLI Kubernetes per eseguire correttamente i comandi `kubectl`.


<br />


## Aggiornamento della CLI
{: #cs_cli_upgrade}

Per utilizzare le nuove funzioni, ti consigliamo di aggiornare periodicamente le CLI.
{:shortdesc}

Questa attività include le informazioni per aggiornare queste CLI.

-   Versione CLI {{site.data.keyword.Bluemix_notm}} 0.5.0 o successiva
-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes versione 1.7.4 o successiva
-   Plug-in {{site.data.keyword.registryshort_notm}}
-   Docker versione 1.9. o successiva

<br>
Per aggiornare le CLI:

1.  Aggiorna la CLI {{site.data.keyword.Bluemix_notm}}. Scarica la [versione più recente ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://clis.ng.bluemix.net/ui/home.html) ed esegui il programma di installazione.

2. Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto. Per specificare una regione {{site.data.keyword.Bluemix_notm}}, [includi l'endpoint API](cs_regions.html#bluemix_regions).

    ```
    bx login
    ```
    {: pre}

     **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

3.  Aggiorna il plug-in {{site.data.keyword.containershort_notm}}.
    1.  Installa l'aggiornamento dal repository di plugin {{site.data.keyword.Bluemix_notm}}.

        ```
        bx plugin update container-service -r Bluemix
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
    1.  Aggiorna la versione della CLI Kubernetes che corrisponde alla versione del cluster Kubernetes che vuoi utilizzare. La versione Kubernetes predefinita di {{site.data.keyword.containershort_notm}} corrente è 1.7.4.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

        **Suggerimento:** se stai utilizzando Windows, installa la CLI Kubernetes nella stessa directory della CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Per gli utenti OSX e Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
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

        3.  Rendi il file eseguibile.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Aggiorna il plug-in {{site.data.keyword.registryshort_notm}}.
    1.  Installa l'aggiornamento dal repository di plugin {{site.data.keyword.Bluemix_notm}}.

        ```
        bx plugin update container-registry -r Bluemix
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

<br />


## Disinstallazione della CLI
{: #cs_cli_uninstall}

Se non hai più bisogno della CLI, puoi disinstallarla.
{:shortdesc}

Questa attività include le informazioni per rimuovere queste CLI:


-   Plug-in {{site.data.keyword.containershort_notm}}
-   CLI Kubernetes versione 1.7.4 o successiva
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

    - [OSX ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset)
    - [Linux ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce)
    - [Windows ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox)

<br />


## Automazione delle distribuzioni dei cluster con l'API
{: #cs_api}

Puoi utilizzare l'API {{site.data.keyword.containershort_notm}}
per automatizzare la creazione, la distribuzione e la gestione dei tuoi cluster Kubernetes.
{:shortdesc}

L'API {{site.data.keyword.containershort_notm}} richiede informazioni
di intestazione che devi fornire nella tua richiesta API e che possono variare in base all'API che vuoi
utilizzare. Per determinare quali informazioni di intestazione sono necessarie per la tua API, vedi la [Documentazione API {{site.data.keyword.containershort_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://us-south.containers.bluemix.net/swagger-api).

**Nota:** per l'autenticazione con {{site.data.keyword.containershort_notm}}, devi fornire un token IAM (Identity and Access Management) generato con le tue credenziali {{site.data.keyword.Bluemix_notm}} e che include l'ID dell'account {{site.data.keyword.Bluemix_notm}} in cui è stato creato il cluster. A seconda del modo con cui ti autentichi con {{site.data.keyword.Bluemix_notm}}, puoi scegliere tra le seguenti opzioni di automazione della creazione del tuo token IAM.

<table>
<thead>
<th>ID {{site.data.keyword.Bluemix_notm}}</th>
<th>Opzioni personali</th>
</thead>
<tbody>
<tr>
<td>ID non federato</td>
<td><ul><li>Nome utente e password <strong>{{site.data.keyword.Bluemix_notm}}:</strong> puoi seguire le istruzioni in questo argomento per automatizzare completamente la creazione del tuo token di accesso IAM.</li>
<li><strong>Genera una chiave API {{site.data.keyword.Bluemix_notm}}:</strong> come alternativa all'utilizzo di nome utente e password {{site.data.keyword.Bluemix_notm}}, puoi <a href="../iam/apikeys.html#manapikey" target="_blank">utilizzare le chiavi API {{site.data.keyword.Bluemix_notm}}</a> Le chiavi API {{site.data.keyword.Bluemix_notm}} sono dipendenti dall'account {{site.data.keyword.Bluemix_notm}} per il quale sono state generate. Non puoi combinare la tua chiave API {{site.data.keyword.Bluemix_notm}} con un ID dell'account differente nello stesso token IAM. Per accedere ai cluster che sono stati creati con un account diverso da quello su cui si basa la tua chiave API {{site.data.keyword.Bluemix_notm}}, devi accedere all'account per generare una nuova chiave API. </li></ul></tr>
<tr>
<td>ID federato</td>
<td><ul><li><strong>Genera una chiave API {{site.data.keyword.Bluemix_notm}}:</strong> <a href="../iam/apikeys.html#manapikey" target="_blank">le chiavi API {{site.data.keyword.Bluemix_notm}}</a> sono dipendenti dall'account {{site.data.keyword.Bluemix_notm}} per il quale sono state generate. Non puoi combinare la tua chiave API {{site.data.keyword.Bluemix_notm}} con un ID dell'account differente nello stesso token IAM. Per accedere ai cluster che sono stati creati con un account diverso da quello su cui si basa la tua chiave API {{site.data.keyword.Bluemix_notm}}, devi accedere all'account per generare una nuova chiave API. </li><li><strong>Utilizza un passcode monouso: </strong> se ti autentichi a {{site.data.keyword.Bluemix_notm}} utilizzando un passcode monouso, non puoi automatizzare completamente la creazione del tuo token IAM perché il richiamo del tuo passcode monouso richiede un'interazione manuale con il tuo browser web. Per automatizzare completamente la creazione del tuo token IAM, devi creare invece una chiave API {{site.data.keyword.Bluemix_notm}}. </ul></td>
</tr>
</tbody>
</table>

1.  Crea il tuo token di accesso IAM (Identity and Access Management). Le informazioni sul corpo incluse nella tue richiesta variano in base al metodo di autenticazione {{site.data.keyword.Bluemix_notm}} che utilizzi. Sostituisci i seguenti valori:
  - _&lt;my_username&gt;_: il tuo nome utente {{site.data.keyword.Bluemix_notm}}.
  - _&lt;my_password&gt;_: la tua password {{site.data.keyword.Bluemix_notm}}.
  - _&lt;my_api_key&gt;_: la tua chiave API {{site.data.keyword.Bluemix_notm}}.
  - _&lt;my_passcode&gt;_: il tuo passcode monouso {{site.data.keyword.Bluemix_notm}}. Esegui `bx login --sso` e segui le istruzioni nel tuo output della CLI per richiamare il tuo passcode monouso utilizzando il tuo browser web.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    <table summary-"Input parameters to get tokens">
    <thead>
        <th>Parametri di input</th>
        <th>Valori</th>
    </thead>
    <tbody>
    <tr>
    <td>Intestazione</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><b>Nota</b>: per te viene fornito Yng6Yng=, l'autorizzazione codificata URL per il nome utente **bx** e la password **bx**.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Corpo per il nome utente e la password {{site.data.keyword.Bluemix_notm}}.</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>username: <em>&lt;my_username&gt;</em></li>
    <li>password: <em>&lt;my_password&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>Nota</b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    <tr>
    <td>Corpo per le chiavi API {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>apikey: <em>&lt;my_api_key&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>Nota</b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    <tr>
    <td>Corpo per il passcode monouso {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>passcode: <em>&lt;my_passcode&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>Nota</b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    </tbody>
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

    Puoi trovare il token IAM nel campo **access_token** del tuo output dell'API. Prendi nota del token IAM per recuperare
ulteriori informazioni di intestazione nei prossimi passi.

2.  Richiama l'ID dell'account {{site.data.keyword.Bluemix_notm}} in cui è stato creato il cluster. Sostituisci _&lt;iam_token&gt;_ con il token IAM recuperato nel
passo precedente.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="Parametri di input per richiamare l'ID dell'account {{site.data.keyword.Bluemix_notm}} ">
    <thead>
  	<th>Parametri di input</th>
  	<th>Valori</th>
    </thead>
    <tbody>
  	<tr>
  		<td>Intestazioni</td>
  		<td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
  	</tr>
    </tbody>
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
            "guid": "<my_account_id>",
            "url": "/v1/accounts/<my_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    Puoi
trovare l'ID del tuo account {{site.data.keyword.Bluemix_notm}}
nel campo **resources/metadata/guid** dell'output dell'API.

3.  Genera un nuovo token IAM che include le tue credenziali e il tuo ID account {{site.data.keyword.Bluemix_notm}} in cui è stato creato il cluster. Sostituisci _&lt;my_account_id&gt;_ con l'ID dell'account {{site.data.keyword.Bluemix_notm}} richiamato nel passo precedente.

    **Nota:** se utilizzi una chiave API {{site.data.keyword.Bluemix_notm}}, devi usare l'ID dell'account {{site.data.keyword.Bluemix_notm}} per il quale è stata creata la chiave API. Per accedere ai cluster in altri account, collegati a questo account e crea una chiave API {{site.data.keyword.Bluemix_notm}} basata su questo account.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    <table summary-"Input parameters to get tokens">
    <thead>
        <th>Parametri di input</th>
        <th>Valori</th>
    </thead>
    <tbody>
    <tr>
    <td>Intestazione</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><b>Nota</b>: per te viene fornito Yng6Yng=, l'autorizzazione codificata URL per il nome utente **bx** e la password **bx**.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Corpo per il nome utente e la password {{site.data.keyword.Bluemix_notm}}.</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>username: <em>&lt;my_username&gt;</em></li>
    <li>password: <em>&lt;my_password&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>Nota</b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    <tr>
    <td>Corpo per le chiavi API {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>apikey: <em>&lt;my_api_key&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>Nota</b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    <tr>
    <td>Corpo per il passcode monouso {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>passcode: <em>&lt;my_passcode&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>Nota<b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    </tbody>
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

    Puoi trovare il token IAM nel campo **access_token** e il token di aggiornamento IAM nel campo **refresh_token**.

4.  Elenca tutti i cluster Kubernetes nel tuo account. Utilizza le informazioni che hai richiamato nei
passi precedenti per creare le informazioni della tua intestazione.

    -   Stati Uniti Sud

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

    -   Stati Uniti Est

        ```
        GET https://us-east.containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

    -   Regno Unito-Sud

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

    -   Europa centrale

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

    -   Asia Pacifico Sud

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

        <table summary="Parametri di input per utilizzare l'API">
        <thead>
        <th>Parametri di input</th>
        <th>Valori</th>
        </thead>
        <tbody>
        <tr>
        <td>Intestazione</td>
        <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li>
        <li>X-Auth-Refresh-Token: <em>&lt;refresh_token&gt;</em></li></ul></td>
        </tr>
        </tbody>
        </table>

5.  Consulta la [Documentazione API {{site.data.keyword.containershort_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://us-south.containers.bluemix.net/swagger-api) per trovare un elenco di API supportate.

<br />


## Aggiornamento dei token di accesso IAM
{: #cs_api_refresh}

Ogni token di accesso IAM (Identity and Access Management) che viene emesso tramite API
scade dopo un'ora. Devi aggiornare regolarmente il tuo token di accesso per garantire l'accesso
all'API {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Prima di iniziare, assicurati di disporre di un token di aggiornamento IAM che
puoi utilizzare per richiedere un nuovo token di accesso. Se non ha un token di aggiornamento, consulta [Automazione del processo di creazione e gestione dei cluster con l'API {{site.data.keyword.containershort_notm}}](#cs_api) per recuperare i tuoi token di accesso.

Attieniti alla seguente procedura se vuoi aggiornare il tuo token IAM.

1.  Genera un nuovo token di accesso IAM. Sostituisci _&lt;iam_refresh_token&gt;_ con il token di aggiornamento IAM che hai ricevuto quando hai eseguito l'autenticazione con {{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    <table summary="Parametri di input per il novo token IAM">
    <thead>
    <th>Parametri di input</th>
    <th>Valori</th>
    </thead>
    <tbody>
    <tr>
    <td>Intestazione</td>
    <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
    <li>Authorization: Basic Yng6Yng=<p><b>Nota</b>: per te viene fornito Yng6Yng=, l'autorizzazione codificata URL per il nome utente **bx** e la password **bx**.</p></li></ul></td>
    </tr>
    <tr>
    <td>Corpo</td>
    <td><ul><li>grant_type: refresh_token</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>refresh_token: <em>&lt;token_aggiornamento_iam&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_id&gt;</em></li></ul><p><b>Nota</b>: aggiungi la chiave uaa_client_secret senza alcun valore specificato. </p></td>
    </tr>
    </tbody>
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
