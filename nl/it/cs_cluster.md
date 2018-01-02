---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurazione dei cluster
{: #cs_cluster}

Progetta la configurazione del tuo cluster per la massima capacità e disponibilità.
{:shortdesc}

Il seguente diagramma include configurazioni di cluster comuni con disponibilità crescente.

![Fasi di elevata disponibilità per un cluster](images/cs_cluster_ha_roadmap.png)

Come mostrato nel diagramma, la distribuzione di applicazioni su più nodi di lavoro le rende più altamente disponibili. La distribuzione delle applicazioni tra più cluster le rende ancora più disponibili. Per la massima disponibilità, distribuisci le tue applicazioni tra i cluster in regioni diverse. [Per ulteriori dettagli, riesamina le opzioni per le configurazioni di cluster ad alta disponibilità.](cs_planning.html#cs_planning_cluster_config)

<br />


## Creazione dei cluster con la GUI
{: #cs_cluster_ui}

Un cluster Kubernetes  è una serie di nodi di lavoro organizzati in una
rete. Lo scopo del cluster è di definire una serie di risorse, nodi, reti e dispositivi di archiviazione
che mantengono le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}
Per gli utenti di {{site.data.keyword.Bluemix_dedicated_notm}}, consulta invece [Creazione di cluster Kubernetes dalla GUI in {{site.data.keyword.Bluemix_dedicated_notm}} (Beta chiusa)](#creating_ui_dedicated).

Per creare un cluster:
1. Nel catalogo, seleziona **Cluster Kubernetes**.
2. Seleziona un tipo di piano del cluster. Puoi scegliere tra **Lite** o **Pagamento a consumo**. Con il piano Pagamento a consumo, puoi eseguire il provisioning di un cluster standard con le funzioni come più nodi di lavoro per un ambiente ad elevata disponibilità.
3. Configura i tuoi dettagli del cluster.
    1. Fornisci al tuo cluster un nome, scegli una versione di Kubernetes e seleziona un'ubicazione in cui eseguire la distribuzione. Per prestazioni ottimali, seleziona l'ubicazione fisicamente più vicina a te. Tieni presente che potresti aver bisogno
di un'autorizzazione legale prima di poter fisicamente archiviare i dati in un paese straniero.
    2. Seleziona un tipo di macchina e specifica il numero di nodi di lavoro di cui hai bisogno. Il tipo di macchina definisce la quantità di CPU virtuale e di memoria configurate in ogni nodo di lavoro e resa disponibile ai contenitori.
        - Il tipo di macchina micro indica l'opzione più piccola.
        - Una macchina bilanciata ha una quantità uguale di memoria assegnata a ciascuna CPU, il che ottimizza le prestazioni.
    3. Seleziona una VLAN pubblica e privata dal tuo account dell'infrastruttura IBM Cloud (SoftLayer). Entrambe le VLAN comunicano con i nodi di lavoro ma la VLAN pubblica anche con il master Kubernetes gestito da IBM. Puoi utilizzare la stessa VLAN per più cluster.
        **Nota**: se scegli di non selezionare una VLAN pubblica, devi configurare una soluzione alternativa.
    4. Seleziona un tipo di hardware. Condiviso è un'opzione sufficiente per la maggior parte delle situazioni.
        - **Dedicato**: assicurati di completare l'isolamento delle tue risorse fisiche.
        - **Condiviso**: consente di archiviare le tue risorse fisiche nello stesso hardware di altri clienti IBM.
4. Fai clic su **Crea cluster**. Puoi vedere lo stato di avanzamento della distribuzione del nodo di lavoro nella scheda **Nodi di lavoro**. Quando la distribuzione è terminata, puoi vedere se il tuo cluster è pronto nella scheda **Panoramica**.
    **Nota:** a ogni nodo di lavoro viene assegnato
un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del
cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo
cluster.


**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività:

-   [Installa le CLI per iniziare ad utilizzare
il tuo cluster.](cs_cli_install.html#cs_cli_install)
-   [Distribuisci un'applicazione nel tuo cluster.](cs_apps.html#cs_apps_cli)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)


### Creazione di cluster con la GUI in {{site.data.keyword.Bluemix_dedicated_notm}} (Beta chiusa)
{: #creating_ui_dedicated}

1.  Accedi alla console {{site.data.keyword.Bluemix_notm}} pubblico ([https://console.bluemix.net ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net)) con il tuo ID IBM.
2.  Dal menu Account, seleziona il tuo account {{site.data.keyword.Bluemix_dedicated_notm}}. La console viene aggiornata con i servizi e le informazioni per la tua istanza di {{site.data.keyword.Bluemix_dedicated_notm}}.
3.  Dal catalogo, seleziona **Contenitori** e fai clic su **Cluster
Kubernetes**.
4.  Immetti un **Nome cluster**.
5.  Seleziona un **Tipo di macchina**. Il tipo di macchina definisce la quantità di CPU virtuale e di memoria configurate in ogni nodo di lavoro
disponibile per tutti i contenitori che distribuisci nei tuoi nodi.
    -   Il tipo di macchina micro indica l'opzione più piccola.
    -   Un tipo di macchina bilanciato ha una quantità uguale di memoria assegnata a ciascuna CPU, il che ottimizza
le prestazioni.
6.  Scegli il **Numero di nodi di lavoro** di cui hai bisogno. Seleziona `3` per assicurare l'elevata disponibilità al tuo cluster.
7.  Fai clic su **Crea cluster**. Si aprono i dettagli del cluster, ma i nodi di lavoro nel cluster impiegano alcuni minuti per eseguire
il provisioning. Nella scheda **Nodi di lavoro**, puoi visualizzare l'andamento della distribuzione del nodo di lavoro. Quando i nodi di lavoro sono pronti, lo stato viene modificato in **Pronto**.

**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività:

-   [Installa le CLI per iniziare ad utilizzare
il tuo cluster.](cs_cli_install.html#cs_cli_install)
-   [Distribuisci un'applicazione nel tuo cluster.](cs_apps.html#cs_apps_cli)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)

<br />


## Creazione dei cluster con la CLI
{: #cs_cluster_cli}

Un cluster è una serie di nodi di lavoro organizzati in una
rete. Lo scopo del cluster è di definire una serie di risorse, nodi, reti e dispositivi di archiviazione
che mantengono le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

Per gli utenti di {{site.data.keyword.Bluemix_dedicated_notm}}, consulta invece [Creazione di cluster Kubernetes dalla CLI in {{site.data.keyword.Bluemix_dedicated_notm}} (Beta chiusa)](#creating_cli_dedicated).

Per creare un cluster:
1.  Installa la CLI {{site.data.keyword.Bluemix_notm}} e il plugin
[{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto. Per specificare una regione {{site.data.keyword.Bluemix_notm}}, [includi l'endpoint API](cs_regions.html#bluemix_regions).

    ```
    bx login
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

3. Se disponi di più account {{site.data.keyword.Bluemix_notm}}, seleziona l'account in cui vuoi creare il tuo cluster Kubernetes.

4.  Se vuoi creare o accedere ai cluster Kubernetes in un'altra regione rispetto alla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, [specifica l'endpoint dell'API della regione {{site.data.keyword.containershort_notm}} ](cs_regions.html#container_login_endpoints).

    **Nota**: se desideri creare un cluster negli Stati Uniti Est, devi specificare l'endpoint dell'API della regione del contenitore Stati Uniti Est utilizzando il comando `bx cs init --host https://us-east.containers.bluemix.net`.

6.  Crea un cluster.
    1.  Esamina le ubicazioni disponibili. Le ubicazioni che vengono mostrate dipendono dalla regione {{site.data.keyword.containershort_notm}} a cui hai eseguito l'accesso.

        ```
        bx cs locations
        ```
        {: pre}

        Il tuo output della CLI corrisponde alle [ubicazioni di alcune regioni del contenitore](cs_regions.html#locations).

    2.  Scegli un'ubicazione ed esamina i tipi di macchina disponibili in tale ubicazione. Il tipo di macchina specifica le risorse di calcolo virtuali che sono disponibili per ogni nodo
di lavoro.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Controlla se esiste già una VLAN pubblica e privata nell'infrastruttura IBM Cloud (SoftLayer) per questo account.

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Se esiste già una VLAN pubblica e privata, nota i router corrispondenti. I router della VLAN privata iniziano sempre con `bcr` (router back-end) e i router
della VLAN pubblica iniziano sempre con `fcr` (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster. Nell'output di esempio, le VLAN private
possono essere utilizzate con una qualsiasi VLAN pubblica perché i router includono tutti
`02a.dal10`.

    4.  Esegui il comando `cluster-create`. Puoi scegliere tra un cluster lite, che include un nodo di lavoro configurato con 2vCPU e 4 GB di memoria, o un cluster standard, che può includere quanti nodi di lavoro desideri nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). Quando crei un cluster standard,
per impostazione predefinita, l'hardware del nodo di lavoro viene condiviso da più clienti IBM e addebitato
in base alle ore di utilizzo. </br>Esempio per un cluster standard:

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch>
        ```
        {: pre}

        Esempio per un cluster lite:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tabella 1. Descrizione dei componenti del comando <code>bx cs cluster-create</code></caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Il comando per creare un cluster nella tua organizzazione {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>Sostituisci <em>&lt;location&gt;</em> con l'ID ubicazione {{site.data.keyword.Bluemix_notm}} in cui vuoi creare
il tuo cluster. [Le ubicazioni disponibili](cs_regions.html#locations) dipendono dalla regione {{site.data.keyword.containershort_notm}} in cui hai
eseguito l'accesso.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Se stai creando un cluster standard, scegli un tipo di macchina. Il tipo di macchina specifica le risorse di calcolo virtuali che sono disponibili per ogni nodo
di lavoro. Controlla [Confronto tra i cluster standard e lite per
{{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type) per ulteriori informazioni. Per i cluster lite, non devi definire il tipo di macchina.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Per i cluster lite, non devi definire una VLAN pubblica. Il tuo cluster lite viene automaticamente collegato alla
VLAN pubblica di proprietà di IBM.</li>
          <li>Per un cluster standard, se hai già una VLAN pubblica configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella ubicazione, immetti l'ID della VLAN pubblica. Se non hai ancora una VLAN privata e pubblica nel tuo account, non
specificare questa opzione. {{site.data.keyword.containershort_notm}} crea automaticamente una VLAN pubblica per tuo conto.<br/><br/>
          <strong>Nota</strong>: i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Per i cluster lita, non devi definire una
VLAN privata. Il tuo cluster lite viene automaticamente collegato alla
VLAN privata di proprietà di IBM.</li><li>Per un cluster standard, se hai già una VLAN privata configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella ubicazione, immetti l'ID della VLAN privata. Se non hai ancora una VLAN privata e pubblica nel tuo account, non
specificare questa opzione. {{site.data.keyword.containershort_notm}} crea automaticamente una VLAN pubblica per tuo conto.<br/><br/><strong>Nota</strong>: i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Sostituisci <em>&lt;name&gt;</em> con un nome per il tuo cluster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>Il numero di nodi di lavoro da includere nel cluster. Se non viene specificata l'opzione <code>--workers</code>,
viene creato 1 nodo di lavoro.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>La versione di Kubernetes per il nodo master del cluster. Questo valore è facoltativo. Se non specificato, il cluster viene creato con l'impostazione predefinita delle versioni di Kubernetes supportate. Per visualizzare le versioni disponibili. esegui <code>bx cs kube-versions</code>.</td>
        </tr>
        </tbody></table>

7.  Verifica che la creazione del cluster sia stata richiesta.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** servono fino a 15 minuti perché le macchine del nodo di lavoro siano ordinate e che il cluster
sia configurato e ne sia stato eseguito il provisioning al tuo account.

    Quando è stato terminato il provisioning del tuo cluster,
lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  Controlla lo stato dei nodi di lavoro.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione
passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**,
puoi accedere al
cluster.

    **Nota:** a ogni nodo di lavoro viene assegnato
un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del
cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo
cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.
    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
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
        /Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml

        ```
        {: screen}

10. Avvia il tuo dashboard Kubernetes con la porta predefinita `8001`.
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


**Operazioni successive**

-   [Distribuisci un'applicazione nel tuo cluster.](cs_apps.html#cs_apps_cli)
-   [Gestisci il tuo cluster con la riga di comando `kubectl`. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)

### Creazione di cluster con la CLI in {{site.data.keyword.Bluemix_dedicated_notm}} (Beta chiusa)
{: #creating_cli_dedicated}

1.  Installa la CLI {{site.data.keyword.Bluemix_notm}} e il plugin
[{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Accedi all'endpoint pubblico per {{site.data.keyword.containershort_notm}}. Immetti le tue credenziali {{site.data.keyword.Bluemix_notm}} e seleziona l'account {{site.data.keyword.Bluemix_dedicated_notm}} quando richiesto.

    ```
    bx login -a api.<region>.bluemix.net
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

3.  Crea un cluster con il comando `cluster-create`. Quando crei un cluster standard, l'hardware del nodo di lavoro viene addebitato in base alle
ore di utilizzo.

    Esempio:

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>Tabella 2. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>Il comando per creare un cluster nella tua organizzazione {{site.data.keyword.Bluemix_notm}}.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>Sostituisci &lt;location&gt; con l'ID ubicazione {{site.data.keyword.Bluemix_notm}} in cui vuoi creare
il tuo cluster. [Le ubicazioni disponibili](cs_regions.html#locations) dipendono dalla regione {{site.data.keyword.containershort_notm}} in cui hai
eseguito l'accesso.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Se stai creando un cluster standard, scegli un tipo di macchina. Il tipo di macchina specifica le risorse di calcolo virtuali che sono disponibili per ogni nodo
di lavoro. Controlla [Confronto tra i cluster standard e lite per
{{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type) per ulteriori informazioni. Per i cluster lite, non devi definire il tipo di macchina.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Sostituisci <em>&lt;name&gt;</em> con un nome per il tuo cluster.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>Il numero di nodi di lavoro da includere nel cluster. Se non viene specificata l'opzione <code>--workers</code>,
viene creato 1 nodo di lavoro.</td>
    </tr>
    </tbody></table>

4.  Verifica che la creazione del cluster sia stata richiesta.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** servono fino a 15 minuti perché le macchine del nodo di lavoro siano ordinate e che il cluster
sia configurato e ne sia stato eseguito il provisioning al tuo account.

    Quando è stato terminato il provisioning del tuo cluster,
lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

5.  Controlla lo stato dei nodi di lavoro.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione
passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**,
puoi accedere al
cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.

    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
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
        /Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml

        ```
        {: screen}

7.  Accedi al dashboard Kubernetes con la porta predefinita 8001.
    1.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    2.  Apri il seguente URL in un browser web per poter visualizzare il dashboard Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**Operazioni successive**

-   [Distribuisci un'applicazione nel tuo cluster.](cs_apps.html#cs_apps_cli)
-   [Gestisci il tuo cluster con la riga di comando `kubectl`. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)

<br />


## Utilizzo dei registri di immagini pubblici e privati
{: #cs_apps_images}

Un'immagine Docker è la base per ogni contenitore che crei. Un'immagine viene creata da un
Dockerfile, che è un file che contiene le istruzioni per creare l'immagine. Nelle sue istruzioni, un Dockerfile potrebbe
fare riferimento alle risorse di build che vengono memorizzate separatamente, quali ad esempio un'applicazione, la configurazione
dell'applicazione e le relative dipendenze. Le immagini normalmente vengono archiviate in un registro ed è possibile accedervi pubblicamente (registro pubblico)
o configurarle con un accesso limitato a un piccolo gruppo di utenti (registro privato).
{:shortdesc}

Esamina le seguenti opzioni per trovare informazioni su come configurare un registro delle immagini e su come
utilizzare un'immagine dal registro.

-   [Accesso a uno spazio dei nomi in {{site.data.keyword.registryshort_notm}} per lavorare con le immagini fornite da IBM e con le tue proprie immagini Docker private](#bx_registry_default).
-   [Accesso alle immagini pubbliche da Docker Hub](#dockerhub).
-   [Accesso alle immagini private memorizzate in altri registri
privati](#private_registry).

### Accedere a uno spazio dei nomi in {{site.data.keyword.registryshort_notm}}
per lavorare con le immagini fornite da IBM e con le tue proprie immagini Docker private
{: #bx_registry_default}

Puoi distribuire i contenitori al tuo cluster da un'immagine pubblica fornita da IBM o da un'immagine privata
memorizzata nel tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}.

Prima di iniziare:

1. [Configura uno spazio dei nomi in {{site.data.keyword.registryshort_notm}} su {{site.data.keyword.Bluemix_notm}} pubblico o {{site.data.keyword.Bluemix_dedicated_notm}} e distribuisci le immagini in questo spazio dei nomi](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Crea un
cluster](#cs_cluster_cli).
3. [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Quando crei un cluster, per esso viene creato automaticamente un token di registro senza
scadenza. Questo token viene utilizzato per autorizzare l'accesso in sola lettura a tutti i tuoi spazi dei nomi che hai configurato
in {{site.data.keyword.registryshort_notm}} in modo che tu possa
lavorare con le immagini pubbliche fornite da IBM e le tue immagini Docker private. I token devono essere memorizzati
in un `imagePullSecret` Kubernetes per poter essere accessibili da un cluster Kubernetes
quando distribuisci un'applicazione inserita in un contenitore. Quando il tuo cluster viene creato, {{site.data.keyword.containershort_notm}} memorizza automaticamente questo token in un
`imagePullSecret` Kubernetes. `imagePullSecret` viene aggiunto allo spazio dei nomi
Kubernetes predefinito, all'elenco di segreti predefinito nel ServiceAccount per tale spazio dei nomi
e allo spazio dei nomi kube-system.

**Nota:** utilizzando questa configurazione iniziale, puoi distribuire i contenitori da qualsiasi immagine disponibile in
uno spazio dei nomi del tuo account {{site.data.keyword.Bluemix_notm}} allo
spazio dei nomi **predefinito** del tuo cluster. Se vuoi distribuire un contenitore in altri
spazi dei nomi del tuo cluster, o se vuoi utilizzare un'immagine memorizzata in un'altra regione {{site.data.keyword.Bluemix_notm}} o in un altro account {{site.data.keyword.Bluemix_notm}}, devi [creare il tuo proprio imagePullSecret per il cluster](#bx_registry_other).

Per distribuire un contenitore nello spazio dei nomi **predefinito** del tuo
cluster, crea un file di configurazione.

1.  Crea un file di configurazione di distribuzione denominato `mydeployment.yaml`.
2.  Definisci la distribuzione e l'immagine che vuoi utilizzare dal tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}.

    Per
utilizzare un'immagine privata da uno spazio dei nomi in {{site.data.keyword.registryshort_notm}}:

    ```
    apiVersion: extensions/v1beta1
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
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Distribuzione di immagini ad altri spazi dei nomi Kubernetes o accesso alle immagini in altre regioni o account {{site.data.keyword.Bluemix_notm}}
{: #bx_registry_other}

Puoi distribuire i contenitori ad altri spazi dei nomi Kubernetes, utilizzare le immagini memorizzate in altre regioni o account {{site.data.keyword.Bluemix_notm}} o utilizzare le immagini memorizzate in {{site.data.keyword.Bluemix_dedicated_notm}} creando il tuo proprio imagePullSecret.

Prima di iniziare:

1.  [Configura uno spazio dei nomi in {{site.data.keyword.registryshort_notm}} su {{site.data.keyword.Bluemix_notm}} pubblico o {{site.data.keyword.Bluemix_dedicated_notm}} e distribuisci le immagini in questo spazio dei nomi](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Crea un
cluster](#cs_cluster_cli).
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
    <caption>Tabella 3. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obbligatoria. Lo spazio dei nomi Kubernetes del cluster in cui vuoi utilizzare il segreto e a cui
distribuire i contenitori. Esegui <code>kubectl get namespaces</code> per elencare tutti gli spazi dei nomi nel tuo
cluster.</td>
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
    <td>Obbligatoria. Se ne hai uno, immetti il tuo indirizzo e-mail Docker. Se non hai uno, immetti
un indirizzo e-mail fittizio, come ad esempio a@b.c. Questa e-mail è obbligatoria per creare un segreto Kubernetes,
ma non viene utilizzata dopo la creazione.</td>
    </tr>
    </tbody></table>

6.  Verifica che il segreto sia stato creato correttamente. Sostituisci
<em>&lt;kubernetes_namespace&gt;</em> con il nome dello spazio in cui hai creato
imagePullSecret.

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
        <caption>Tabella 4.Descrizione dei componenti del file YAML</caption>
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
        <td>Lo spazio dei nomi in cui è memorizzata la tua immagine. Per elencare gli spazi dei nomi disponibili, esegui `bx cr
namespace-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>Il nome dell'immagine che vuoi utilizzare. Per elencare le immagini disponibili in un account {{site.data.keyword.Bluemix_notm}}, esegui `bx cr image-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>La versione dell'immagine che vuoi utilizzare. Se non si specifica una tag, viene utilizzata l'immagine contrassegnata con
<strong>latest</strong> per impostazione predefinita.</td>
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


### Accesso alle immagini pubbliche da Docker Hub
{: #dockerhub}

Puoi utilizzare qualsiasi immagine pubblica memorizzata in Docker Hub per distribuire un contenitore al tuo
cluster senza alcuna configurazione aggiuntiva.

Prima di iniziare:

1.  [Crea un
cluster](#cs_cluster_cli).
2.  [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Crea un file di configurazione di distribuzione.

1.  Crea un file di configurazione denominato `mydeployment.yaml`.
2.  Definisci la distribuzione e l'immagine pubblica dal Docker Hub che vuoi utilizzare. Il seguente file di configurazione utilizza l'immagine pubblica NGINX disponibile su Docker Hub.

    ```
    apiVersion: extensions/v1beta1
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
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### Accesso alle immagini private memorizzate in altri registri privati
{: #private_registry}

Se hai già un registro privato che vuoi utilizzare, devi memorizzare le credenziali del
registro in un imagePullSecret Kubernetes e fare riferimento a questo segreto nel tuo file di configurazione.

Prima di iniziare:

1.  [Crea un
cluster](#cs_cluster_cli).
2.  [Indirizza la tua CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

Per creare un imagePullSecret:

**Nota:** i segreti imagePullSecret sono validi per gli spazi dei nomi per i quali sono stati creati. Ripeti questa procedura
per ogni spazio dei nomi in cui vuoi distribuire i contenitori da un'immagine memorizzata in un registro {{site.data.keyword.Bluemix_notm}} privato.

1.  Crea il segreto Kubernetes per memorizzare le credenziali del tuo registro privato.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabella 5. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obbligatoria. Lo spazio dei nomi Kubernetes del cluster in cui vuoi utilizzare il segreto e a cui
distribuire i contenitori. Esegui <code>kubectl get namespaces</code> per elencare tutti gli spazi dei nomi nel tuo
cluster.</td>
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
    <td>Obbligatoria. Se ne hai uno, immetti il tuo indirizzo e-mail Docker. Se non hai uno, immetti
un indirizzo e-mail fittizio, come ad esempio a@b.c. Questa e-mail è obbligatoria per creare un segreto Kubernetes,
ma non viene utilizzata dopo la creazione.</td>
    </tr>
    </tbody></table>

2.  Verifica che il segreto sia stato creato correttamente. Sostituisci
<em>&lt;kubernetes_namespace&gt;</em> con il nome dello spazio in cui hai creato
imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  Crea un a pod che fa riferimento all'imagePullSecret.
    1.  Crea un file di configurazione del pod denominato `mypod.yaml`.
    2.  Definisci il pod e l'imagePullSecret che vuoi utilizzare per accedere al tuo registro
{{site.data.keyword.Bluemix_notm}} privato. Per utilizzare un'immagine
privata dal tuo registro privato:

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
        <caption>Tabella 6.Descrizione dei componenti del file YAML</caption>
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
        <td>La versione dell'immagine che vuoi utilizzare. Se non si specifica una tag, viene utilizzata l'immagine contrassegnata con
<strong>latest</strong> per impostazione predefinita.</td>
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


## Aggiunta dei servizi {{site.data.keyword.Bluemix_notm}}
ai cluster
{: #cs_cluster_service}

Aggiungi un'istanza del servizio {{site.data.keyword.Bluemix_notm}} esistente al tuo cluster
per abilitare gli utenti del cluster ad accedere e utilizzare il servizio
{{site.data.keyword.Bluemix_notm}} quando distribuiscono un'applicazione al cluster.
{:shortdesc}

Prima di iniziare:

1. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.
2. [Richiedi un'istanza del servizio {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).
   **Nota:** per creare un'istanza di un servizio nell'ubicazione Washington, devi utilizzare la CLI.
3. Per gli utenti di {{site.data.keyword.Bluemix_dedicated_notm}}, consulta invece [Aggiunta dei servizi {{site.data.keyword.Bluemix_notm}} ai cluster in {{site.data.keyword.Bluemix_dedicated_notm}} (Beta chiusa)](#binding_dedicated).

**Nota:**
<ul><ul>
<li>Puoi aggiungere solo servizi {{site.data.keyword.Bluemix_notm}} che supportano le chiavi del servizio. Se il servizio non supporta le chiavi del servizio, consulta [Abilitazione di applicazioni esterne all'utilizzo dei servizi {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).</li>
<li>Il cluster e i nodi di lavoro devono essere distribuiti completamente prima di poter aggiungere un servizio.</li>
</ul></ul>


Per aggiungere un servizio:
2.  Elenca i servizi {{site.data.keyword.Bluemix_notm}} disponibili.

    ```
    bx service list
    ```
    {: pre}

    Output CLI di esempio:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  Prendi nota del **nome** dell'istanza del servizio che vuoi aggiungere al tuo cluster.
4.  Identifica lo spazio dei nomi del cluster che desideri utilizzare per l'aggiunta del tuo servizio. Scegli tra le seguenti opzioni:
    -   Elenca gli spazi dei nomi esistenti e scegline uno che desideri utilizzare.

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   Crea un nuovo spazio dei nomi nel tuo cluster.

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  Aggiungi il servizio al tuo cluster.

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    Dopo che
il servizio è stato correttamente associato al tuo cluster, viene creato un segreto cluster che contiene le credenziali
della tua istanza del servizio. Output CLI di esempio:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Verifica che il segreto sia stato creato nel tuo spazio dei nomi del cluster.

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


Per utilizzare il
servizio in un pod distribuito nel cluster, gli utenti del cluster possono accedere alle credenziali del servizio {{site.data.keyword.Bluemix_notm}} da
[montaggio del segreto Kubernetes come un volume secreto in un pod](cs_apps.html#cs_apps_service).

### Aggiunta dei servizi {{site.data.keyword.Bluemix_notm}} ai cluster in {{site.data.keyword.Bluemix_dedicated_notm}} (Beta chiusa)
{: #binding_dedicated}

**Nota**: il cluster e i nodi di lavoro devono essere distribuiti completamente prima di poter aggiungere un servizio.

1.  Imposta il percorso del tuo file di configurazione {{site.data.keyword.Bluemix_dedicated_notm}} locale come variabile di ambiente `DEDICATED_BLUEMIX_CONFIG`.

    ```
    export DEDICATED_BLUEMIX_CONFIG=<path_to_config_directory>
    ```
    {: pre}

2.  Imposta lo stesso percorso precedentemente definito come la variabile di ambiente `BLUEMIX_HOME`.

    ```
    export BLUEMIX_HOME=$DEDICATED_BLUEMIX_CONFIG
    ```
    {: pre}

3.  Accedi all'ambiente {{site.data.keyword.Bluemix_dedicated_notm}} in cui vuoi creare l'istanza del servizio.

    ```
    bx login -a api.<dedicated_domain> -u <user> -p <password> -o <org> -s <space>
    ```
    {: pre}

4.  Elenca i servizi disponibili nel catalogo {{site.data.keyword.Bluemix_notm}}.

    ```
    bx service offerings
    ```
    {: pre}

5.  Crea un'istanza del servizio che desideri associare al cluster.

    ```
    bx service create <service_name> <service_plan> <service_instance_name>
    ```
    {: pre}

6.  Verifica di aver creato la tua istanza del servizio elencando i servizi {{site.data.keyword.Bluemix_notm}} disponibili.

    ```
    bx service list
    ```
    {: pre}

    Output CLI di esempio:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

7.  Annulla la configurazione della variabile di ambiente `BLUEMIX_HOME` per tornare ad utilizzare {{site.data.keyword.Bluemix_notm}} Pubblico.

    ```
    unset $BLUEMIX_HOME
    ```
    {: pre}

8.  Accedi all'endpoint pubblico per {{site.data.keyword.containershort_notm}} e indirizza la CLI al cluster nel tuo ambiente {{site.data.keyword.Bluemix_dedicated_notm}}.
    1.  Accedi all'account utilizzando l'endpoint pubblico per {{site.data.keyword.containershort_notm}}. Immetti le tue credenziali {{site.data.keyword.Bluemix_notm}} e seleziona l'account {{site.data.keyword.Bluemix_dedicated_notm}} quando richiesto.

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

    2.  Ottieni un elenco di cluster disponibili e identifica il nome del cluster da indirizzare alla
CLI.

        ```
        bx cs clusters
        ```
        {: pre}

    3.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
        ```
        {: screen}

    4.  Copia e incolla il comando visualizzato nel tuo terminale per impostare la variabile di ambiente `KUBECONFIG`.

9.  Identifica lo spazio dei nomi del cluster che desideri utilizzare per l'aggiunta del tuo servizio. Scegli tra le seguenti opzioni:
    * Elenca gli spazi dei nomi esistenti e scegline uno che desideri utilizzare.
        ```
        kubectl get namespaces
        ```
        {: pre}

    * Crea un nuovo spazio dei nomi nel tuo cluster.
        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

10.  Esegui il bind dell'istanza del servizio al tuo cluster.

      ```
      bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
      ```
      {: pre}

<br />


## Gestione dell'accesso al cluster
{: #cs_cluster_user}

Puoi concedere ad altri utenti l'accesso al tuo cluster in modo che essi possano accedervi,
gestirlo e distribuirvi applicazioni.
{:shortdesc}

A ogni utente che lavora con {{site.data.keyword.containershort_notm}} deve essere assegnato
un ruolo utente specifico del servizio in Identity and Access Management che determini il tipo di azioni che tale utente
può eseguire. Identity and Access Management differenzia le seguenti autorizzazioni di accesso.

<dl>
<dt>politiche di accesso
{{site.data.keyword.containershort_notm}}</dt>
<dd>Le politiche di accesso determinano le azioni di gestione cluster che puoi eseguire su un
cluster, come la creazione o rimozione dei cluster e l'aggiunta o la rimozione di nodi di lavoro supplementari.</dd>
<dt>Gruppi di risorse</dt>
<dd>Un gruppo di risorse è un modo per organizzare i servizi {{site.data.keyword.Bluemix_notm}} in raggruppamenti in modo da poter assegnare rapidamente agli utenti l'accesso a più di una risorsa alla volta. Scopri come [gestire gli utenti utilizzando i gruppi di risorse](/docs/admin/resourcegroups.html#rgs).</dd>
<dt>Ruoli RBAC</dt>
<dd>Ad ogni utente a cui è assegnata una politica di accesso {{site.data.keyword.containershort_notm}} viene assegnato automaticamente un
ruolo RBAC. I ruoli RBAC determinano le azioni che puoi eseguire sulle risorse Kubernetes
all'interno del cluster. I ruoli RBAC vengono configurati solo per lo spazio dei nomi predefinito. L'amministratore del cluster
può aggiungere i ruoli RBAC per gli altri spazi dei nomi nel cluster. Consulta  [Using RBAC Authorization ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) nella documentazione Kubernetes per ulteriori informazioni.</dd>
<dt>Ruoli Cloud Foundry</dt>
<dd>A ogni utente deve essere assegnato un ruolo Cloud Foundry. Questo ruolo
determina le azioni che l'utente può eseguire sull'account {{site.data.keyword.Bluemix_notm}}, come l'invito di altri utenti
o la visualizzazione dell'utilizzo della quota. Per esaminare le autorizzazioni di ciascun ruolo, vedi [Ruoli Cloud
Foundry](/docs/iam/cfaccess.html#cfaccess).</dd>
</dl>

Scegli tra le seguenti azioni per procedere:

-   [Visualizza le politiche di accesso e le autorizzazioni richieste per lavorare con i
cluster](#access_ov).
-   [Visualizza la tua politica di accesso corrente](#view_access).
-   [Modifica la politica di accesso di un utente esistente](#change_access).
-   [Aggiungi ulteriori utenti all'account {{site.data.keyword.Bluemix_notm}}](#add_users).

### Panoramica delle politiche di accesso e delle autorizzazioni richieste di {{site.data.keyword.containershort_notm}}
{: #access_ov}

Esamina le politiche di accesso e le autorizzazioni che puoi concedere agli utenti nel tuo account {{site.data.keyword.Bluemix_notm}}. I ruoli operatore e editor hanno autorizzazioni separate. Se vuoi, ad esempio, che un utente aggiunga nodi di lavoro ed esegua il bind dei servizi, devi assegnare all'utente sia il ruolo di operatore che di editor.

|Politica di accesso|Autorizzazioni di gestione cluster|Autorizzazioni delle risorse Kubernetes|
|-------------|------------------------------|-------------------------------|
|<ul><li>Ruolo: Amministratore</li><li>Istanze del servizio: tutte le istanze del servizio corrente</li></ul>|<ul><li>Creare un cluster lite o standard</li><li>Impostare le credenziali per un account {{site.data.keyword.Bluemix_notm}} per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer)</li><li>Rimuovere un cluster</li><li>Assegnare e modificare le politiche di accesso {{site.data.keyword.containershort_notm}}
per altri utenti esistenti in questo account.</li></ul><br/>Questo ruolo eredita le autorizzazioni dai ruoli editor, operatore e visualizzatore
per tutti i cluster in questo account.|<ul><li>Ruolo RBAC: amministratore del cluster</li><li>Accesso in lettura/scrittura alle risorse in ogni spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li><li>Accesso al dashboard Kubernetes</li><li>Creare una risorsa Ingress che renda le applicazioni disponibili pubblicamente.</li></ul>|
|<ul><li>Ruolo: Amministratore</li><li>Istanze del servizio: uno specifico ID cluster</li></ul>|<ul><li>Rimuovere un cluster specifico.</li></ul><br/>Questo ruolo eredita le autorizzazioni dai ruoli editor, operatore e visualizzatore
per il cluster selezionato.|<ul><li>Ruolo RBAC: amministratore del cluster</li><li>Accesso in lettura/scrittura alle risorse in ogni spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li><li>Accesso al dashboard Kubernetes</li><li>Creare una risorsa Ingress che renda le applicazioni disponibili pubblicamente.</li></ul>|
|<ul><li>Ruolo: Operatore</li><li>Istanze del servizio: tutte le istanze del servizio corrente/uno specifico ID cluster</li></ul>|<ul><li>Aggiungere ulteriori nodi di lavoro a un cluster</li><li>Rimuovere nodi di lavoro da un cluster</li><li>Riavviare un nodo di lavoro</li><li>Ricaricare un nodo di lavoro</li><li>Aggiungere una sottorete a un cluster</li></ul>|<ul><li>Ruolo RBAC: amministratore</li><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito ma non allo spazio dei nomi</li><li>Creare ruoli all'interno di uno spazio dei nomi</li></ul>|
|<ul><li>Ruolo: Editor</li><li>Istanze del servizio: tutte le istanze del servizio corrente, uno specifico ID cluster</li></ul>|<ul><li>Eseguire il bind di un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.</li><li>Annullare il bind di un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.</li><li>Creare un webhook.</li></ul><br/>Utilizza questo ruolo per gli sviluppatori della tua applicazione.|<ul><li>Ruolo RBAC: modifica</li><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito</li></ul>|
|<ul><li>Ruolo: Visualizzatore</li><li>Istanze del servizio: tutte le istanze del servizio corrente/uno specifico ID cluster</li></ul>|<ul><li>Elencare un cluster</li><li>Visualizzare i dettagli per un cluster</li></ul>|<ul><li>Ruolo RBAC: visualizza</li><li>Accesso in lettura alle risorse nello spazio dei nomi predefinito</li><li>Nessun accesso in lettura ai segreti Kubernetes</li></ul>|
|<ul><li>Ruolo organizzazione Cloud Foundry: Gestore</li></ul>|<ul><li>Aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|<ul><li>Ruolo spazio Cloud Foundry: Sviluppatore</li></ul>|<ul><li>Creare istanze del servizio {{site.data.keyword.Bluemix_notm}}/li><li>Eseguire il bind delle istanze del servizio {{site.data.keyword.Bluemix_notm}}
ai cluster</li></ul>| |
{: caption="Tabella 7. Panoramica delle autorizzazioni e delle politiche di accesso a {{site.data.keyword.containershort_notm}} obbligatorie" caption-side="top"}

### Verifica della tua politica di accesso
{{site.data.keyword.containershort_notm}}
{: #view_access}

Puoi riesaminare e verificare la tua politica di accesso assegnata per {{site.data.keyword.containershort_notm}}. La politica di accesso determina
le azioni di gestione del cluster che puoi eseguire.

1.  Seleziona l'account {{site.data.keyword.Bluemix_notm}}
in cui vuoi verificare la tua politica di accesso {{site.data.keyword.containershort_notm}}.
2.  Dalla barra dei menu, fai clic su **Gestisci** > **Sicurezza** > **Identità e accesso**. La finestra **Utenti** visualizza un elenco
di utenti con i relativi indirizzi e-mail e lo stato corrente per l'account selezionato.
3.  Seleziona l'utente per il quale vuoi controllare la politica di accesso.
4.  Nella sezione **Politiche di accesso**, esamina la politica di accesso per l'utente. Per trovare informazioni dettagliate sulle azioni che puoi eseguire con questo ruolo, consulta
[Panoramica delle autorizzazioni e delle politiche di accesso {{site.data.keyword.containershort_notm}} obbligatorie](#access_ov).
5.  Facoltativo: [Modifica la tua politica di accesso corrente](#change_access).

    **Nota:** solo gli utenti che hanno una politica di accesso Amministratore assegnata per tutte le risorse in {{site.data.keyword.containershort_notm}} possono modificare la politica di accesso
per un utente esistente. Per aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}}, devi avere il ruolo Gestore di Cloud Foundry per l'account. Per trovare l'ID del proprietario dell'account {{site.data.keyword.Bluemix_notm}}, esegui `bx iam
accounts` e cerca l'**ID utente proprietario**.


### Modifica della politica di accesso {{site.data.keyword.containershort_notm}}
per un utente esistente
{: #change_access}

Puoi modificare la politica di accesso per un utente esistente per concedere le autorizzazioni di gestione
cluster per un cluster nel tuo account {{site.data.keyword.Bluemix_notm}}.

Prima di iniziare, [verifica che ti sia stata assegnata
la politica di accesso Amministratore](#view_access) per tutte le risorse in {{site.data.keyword.containershort_notm}}.

1.  Seleziona l'account {{site.data.keyword.Bluemix_notm}}
in cui vuoi modificare la politica di accesso {{site.data.keyword.containershort_notm}} per un utente esistente.
2.  Dalla barra dei menu, fai clic su **Gestisci** > **Sicurezza** > **Identità e accesso**. La finestra **Utenti** visualizza un elenco
di utenti con i relativi indirizzi e-mail e lo stato corrente per l'account selezionato.
3.  Trova l'utente per il quale vuoi modificare la politica di accesso. Se non trovi l'utente che
stai cercando, [invita questo utente all'account {{site.data.keyword.Bluemix_notm}}](#add_users).
4.  Da **Politiche di accesso**, nella riga **Ruolo** e sotto la colonna **Azioni**, espandi e fai clic su **Modifica politica**.
5.  Dall'elenco a discesa **Servizio**, seleziona **{{site.data.keyword.containershort_notm}}**.
6.  Dall'elenco a discesa **Regioni**, seleziona la regione per cui vuoi modificare la politica. 
7.  Dall'elenco a discesa **Istanza del servizio**, seleziona il cluster per cui vuoi modificare la politica. Per trovare l'ID di uno specifico cluster, esegui `bx cs clusters`.
8.  Nella sezione **Seleziona i ruoli**, fai clic sul ruolo a cui desideri modificare l'accesso dell'utente. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Panoramica delle politiche di accesso e delle autorizzazioni richieste di {{site.data.keyword.containershort_notm}}](#access_ov).
9.  Fai clic su **Salva** per salvare le modifiche.

### Aggiunta di utenti a un account {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Puoi aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}} per concedere loro l'accesso ai tuoi cluster.

Prima di iniziare, verifica che ti sia stato assegnato il ruolo Gestore di Cloud Foundry per un account {{site.data.keyword.Bluemix_notm}}.

1.  Seleziona l'account {{site.data.keyword.Bluemix_notm}}
in cui vuoi aggiungere gli utenti.
2.  Dalla barra dei menu, fai clic su **Gestisci** > **Sicurezza** > **Identità e accesso**. La finestra Utenti visualizza un elenco
di utenti con i relativi indirizzi e-mail e lo stato corrente per l'account selezionato.
3.  Fai clic su **Invita utenti**.
4.  In **Indirizzo e-mail**, immetti l'indirizzo e-mail dell'utente che vuoi aggiungere all'account {{site.data.keyword.Bluemix_notm}}.
5.  Nella sezione **Accesso**, espandi **Servizi**.
6.  Dall'elenco a discesa **Assegna accesso a**, decidi se vuoi concedere l'accesso solo al tuo account {{site.data.keyword.containershort_notm}} (**Risorse**) o a una raccolta di varie risorse nel tuo account (**Gruppo di risorse**).
7.  Se **Risorse**:
    1. Dall'elenco a discesa **Servizi**, seleziona **{{site.data.keyword.containershort_notm}}**.
    2. Dall'elenco a discesa **Regione**, seleziona la regione a cui vuoi invitare l'utente.
    3. Dall'elenco a discesa **Istanza del servizio**, seleziona il cluster a cui vuoi invitare l'utente. Per trovare l'ID di uno specifico cluster, esegui `bx cs clusters`.
    4. Nella sezione **Seleziona i ruoli**, fai clic sul ruolo a cui desideri modificare l'accesso dell'utente. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Panoramica delle politiche di accesso e delle autorizzazioni richieste di {{site.data.keyword.containershort_notm}}](#access_ov).
8. Se **Gruppo di risorse**:
    1. Dall'elenco a discesa **Gruppo di risorse**, seleziona il gruppo di risorse che include le autorizzazioni per la risorsa {{site.data.keyword.containershort_notm}} del tuo account.
    2. Dall'elenco a discesa **Assegna accesso a un gruppo di risorse**, seleziona il ruolo che vuoi assegnare all'utente invitato. Per trovare un elenco di azioni supportate per ciascun ruolo, vedi [Panoramica delle politiche di accesso e delle autorizzazioni richieste di {{site.data.keyword.containershort_notm}}](#access_ov).
9. Facoltativo: per consentire a questi utente di aggiungere ulteriori utenti a un account {{site.data.keyword.Bluemix_notm}}, assegna all'utente un ruolo dell'organizzazione Cloud Foundry.
    1. Nella sezione **Ruoli Cloud Foundry**, dall'elenco a discesa **Organizzazione**, seleziona l'organizzazione a cui vuoi concedere le autorizzazioni dell'utente.
    2. Dall'elenco a discesa **Ruoli organizzazione**, seleziona
**Gestore**.
    3. Dall'elenco a discesa **Regione**, seleziona la regione a cui vuoi concedere le autorizzazioni dell'utente.
    4. Dall'elenco a discesa **Spazio**, seleziona lo spazio a cui vuoi concedere le autorizzazioni dell'utente.
    5. Dall'elenco a discesa **Ruoli spazio**, seleziona **Gestore**.
10. Fai clic su **Invita utenti**.

<br />


## Aggiornamento del master Kubernetes
{: #cs_cluster_update}

Kubernetes aggiorna periodicamente le [versioni principali, secondarie e patch](cs_versions.html#version_types), il che incide sui tuoi cluster. L'aggiornamento di un cluster è un processo in due fasi. Per prima cosa devi aggiornare il master Kubernetes e poi ognuno dei nodi di lavoro.

Per impostazione predefinita, non puoi aggiornare un master Kubernetes più di due versioni secondarie in avanti. Ad esempio, se il master corrente è la versione 1.5 e vuoi aggiornare a 1.8, devi prima aggiornare a 1.7. Puoi forzare l'aggiornamento per continuare, ma l'aggiornamento di più di due versioni secondarie potrebbe causare risultati imprevisti.

**Attenzione**: segui le istruzioni di aggiornamento e utilizza un cluster di test per risolvere potenziali interruzioni delle applicazioni durante l'aggiornamento. Non puoi eseguire il rollback di un cluster a una versione precedente.

Quando esegui un aggiornamento _maggiore_ o _minore_, completa la seguente procedura.

1. Controlla le [modifiche Kubernetes](cs_versions.html) ed effettua tutti gli aggiornamenti contrassegnati come _Aggiorna prima master_.
2. Aggiorna il tuo master Kubernetes utilizzando la GUI o eseguendo il comando della CLI [](cs_cli_reference.html#cs_cluster_update). Quando aggiorni il master Kubernetes, il master non è attivo per circa 5 - 10 minuti. Durante l'aggiornamento, non è possibile accedere o modificare il cluster. Tuttavia, i nodi di lavoro, le applicazioni e le risorse che gli utenti del cluster hanno distribuito non vengono modificate e continuano ad essere eseguite.
3. Conferma che l'aggiornamento è stato completato. Controlla la versione di Kubernetes nel dashboard {{site.data.keyword.Bluemix_notm}} o esegui `bx cs clusters`.

Una volta completato l'aggiornamento del master Kubernetes, puoi aggiornare i tuoi nodi di lavoro.

<br />


## Aggiornamento dei nodi di lavoro
{: #cs_cluster_worker_update}

Mentre IBM applica automaticamente le patch al master Kubernetes, devi aggiornare in modo esplicito i nodi di lavoro per gli aggiornamenti principali e secondari. La versione del nodo di lavoro non può essere superiore al master Kubernetes.

**Attenzione**: gli aggiornamenti ai nodi di lavoro possono causare tempi di inattività per applicazioni e servizi:
- I dati vengono eliminati se non archiviati al di fuori del pod.
- Utilizza le [repliche ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) nelle tue distribuzioni per ripianificare i pod sui nodi disponibili.

Aggiornamento dei cluster al livello di produzione:
- Per evitare tempi di inattività per le tue applicazioni, il processo di aggiornamento impedisce la pianificazione dei pod sul nodo di lavoro durante l'aggiornamento. Per ulteriori informazioni, vedi [`kubectl drain` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#drain).
- Utilizza un cluster di test per controllare che i tuoi carichi di lavoro e il processo di distribuzione non vengano influenzati dall'aggiornamento. Non puoi eseguire il rollback dei nodi di lavoro a una versione precedente.
- I cluster al livello di produzione dovrebbero poter superare un errore del nodo di lavoro. Se il tuo cluster non supera l'errore, aggiungi un nodo di lavoro prima di aggiornare il cluster.
- Viene eseguito un aggiornamento continuo quando è richiesto l'aggiornamento di più nodi di lavoro. È possibile aggiornare contemporaneamente fino al 20 percento della quantità totale di nodi di lavoro in un cluster. Il processo di aggiornamento attende che un nodo di lavoro completi l'aggiornamento prima di avviare quello di un altro nodo.


1. Installa la versione della [`cli kubectl` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) che corrisponde alla versione di Kubernetes del master Kubernetes.

2. Apporta tutte le modifiche contrassegnate come _Aggiorna dopo il master_ in [Modifiche Kubernetes](cs_versions.html).

3. Aggiorna i tuoi nodi di lavoro:
  * Per aggiornare dal dashboard {{site.data.keyword.Bluemix_notm}}, passa alla sezione `Nodi di lavoro` del tuo cluster e fai clic su `Aggiorna nodo di lavoro`.
  * Per ottenere gli ID del nodo di lavoro, esegui `bx cs workers <cluster_name_or_id>`. Se selezioni più nodi di lavoro, vengono aggiornati uno alla volta.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Conferma che l'aggiornamento sia stato completato:
  * Controlla la versione di Kubernetes nel dashboard {{site.data.keyword.Bluemix_notm}} o esegui `bx cs workers <cluster_name_or_id>`.
  * Controlla la versione di Kubernetes dei nodi di lavoro eseguendo `kubectl get nodes`.
  * In alcuni casi, i cluster meno recenti possono elencare nodi di lavoro duplicati con uno stato di **Non pronto** dopo un aggiornamento. Per rimuovere i duplicati, consulta [risoluzione dei problemi](cs_troubleshoot.html#cs_duplicate_nodes).

Dopo aver completato l'aggiornamento:
  - Ripeti il processo di aggiornamento con gli altri cluster.
  - Avvisa gli sviluppatori che lavorano nel cluster di aggiornare la loro CLI `kubectl` alla versione del master Kubernetes.
  - Se il dashboard Kubernetes non visualizza i grafici di utilizzo, [elimina il pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).

<br />


## Aggiunta di sottoreti ai cluster
{: #cs_cluster_subnet}

Modifica il pool di indirizzi IP pubblici o privati portatili disponibili aggiungendo sottoreti al tuo cluster.
{:shortdesc}

In {{site.data.keyword.containershort_notm}}, puoi aggiungere IP portatili
stabili per i servizi Kubernetes aggiungendo delle sottoreti di rete al cluster. Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} fornisce automaticamente una sottorete pubblica portatile con 5 indirizzi IP pubblici e una sottorete privata portatile con 5 indirizzi IP privati. Gli indirizzi IP pubblici e privati portatili sono statici e non cambiano quando viene rimosso un nodo di lavoro o il cluster.

Uno degli indirizzi IP pubblici portatili e uno di quelli privati portatili vengono utilizzati per i [controller Ingress](cs_apps.html#cs_apps_public_ingress) che puoi usare per esporre più applicazioni nel tuo cluster. I restanti 4 indirizzi IP pubblici portatili e 4 privati portatili possono essere utilizzati per esporre al pubblico singole applicazioni [creando un servizio di bilanciamento del carico](cs_apps.html#cs_apps_public_load_balancer).

**Nota:** gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se scegli di rimuovere gli indirizzi IP pubblici portatili
dopo il provisioning del tuo cluster, devi comunque pagare l'addebito mensile, anche se li hai utilizzati
solo per un breve periodo di tempo.

### Richiesta di ulteriori sottoreti per il tuo cluster
{: #add_subnet}

Puoi aggiungere stabili IP pubblici o privati portatili al cluster assegnando ad esso delle sottoreti.

Per gli utenti di {{site.data.keyword.Bluemix_dedicated_notm}}, invece di utilizzare questa attività, devi [aprire un ticket di supporto](/docs/support/index.html#contacting-support) per creare la sottorete e quindi utilizzare il comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) per aggiungere la sottorete al cluster.

Prima di iniziare, assicurati di poter accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer) attraverso la GUI di {{site.data.keyword.Bluemix_notm}}. Per accedere al portfolio, devi configurare
o utilizzare un account Pagamento a consumo di {{site.data.keyword.Bluemix_notm}}
esistente.

1.  Dal catalogo, nella sezione **Infrastruttura**, seleziona
**Rete**.
2.  Seleziona **Sottorete/IP** e fai clic su
**Crea**.
3.  Dall'elenco a discesa **Seleziona il tipo di sottorete da aggiungere a questo account**, seleziona **Pubblico portatile** o **Privato portatile**.
4.  Seleziona il numero di indirizzi IP che vuoi aggiungere dalla tua sottorete portatile.

    **Nota:** quando aggiungi gli indirizzi IP portatili per la tua sottorete, tre indirizzi IP vengono utilizzati per stabilire un collegamento di rete interno al cluster, pertanto non puoi utilizzarli per il tuo controller Ingress o per creare un servizio di bilanciamento del carico. Ad esempio, se richiedi otto indirizzi IP pubblici portatili, puoi utilizzarne cinque per
esporre le tue applicazioni pubblicamente.

5.  Seleziona la VLAN pubblica o privata a cui vuoi instradare gli indirizzi IP pubblici o privati portatili. Devi selezionare la VLAN pubblica o privata a cui è connesso un nodo di lavoro esistente. Esamina la VLAN pubblica o privata per un nodo di lavoro.

    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  Completa il questionario e fai clic su **Effettua ordine**.

    **Nota:** gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se scegli di rimuovere gli indirizzi
IP pubblici portatili dopo averli creati, dovrai ancora pagare l'addebito mensile anche se li hai utilizzati
solo una parte del mese.

7.  Una volta fornita la sottorete, rendila disponibile al tuo cluster Kubernetes.
    1.  Dal dashboard Infrastruttura, seleziona la sottorete che hai creato e prendi nota dell'ID
della sottorete.
    2.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Per specificare una regione {{site.data.keyword.Bluemix_notm}}, [includi l'endpoint API](cs_regions.html#bluemix_regions).

        ```
        bx login
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai di disporre di un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

    3.  Elenca tutti i cluster nel tuo account e prendi nota dell'ID del cluster in cui vuoi rendere disponibile
la sottorete.

        ```
        bx cs clusters
        ```
        {: pre}

    4.  Aggiungi la sottorete al tuo cluster. Quando rendi disponibile una sottorete a un cluster, per te viene creata una mappa di configurazione Kubernetes che include tutti gli indirizzi IP pubblici o privati portatili disponibili che puoi utilizzare. Se non esiste alcun controller Ingress per il tuo cluster, viene utilizzato automaticamente un indirizzo IP pubblico portatile per creare il controller Ingress pubblico e un indirizzo IP privato portatile per creare il controller Ingress privato. Tutti gli altri indirizzi IP pubblici e privati portatili possono essere utilizzati per creare i servizi del programma di bilanciamento del carico per le tue applicazioni.

        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  Verifica che la sottorete sia stata aggiunta correttamente al tuo cluster. Il CIDR della sottorete viene elencato nella sezione **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Aggiunta di sottoreti personalizzate ed esistenti ai cluster Kubernetes
{: #custom_subnet}

Puoi aggiungere sottoreti pubbliche o private portatili esistenti al tuo cluster Kubernetes. 

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Se hai una sottorete esistente nel tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer) con regole firewall personalizzate o indirizzi IP disponibili che vuoi utilizzare, crea un cluster senza sottoreti e rendi disponibile la tua sottorete esistente al cluster durante il provisioning. 

1.  Identifica la sottorete da utilizzare. Nota l'ID della sottorete e l'ID della VLAN. In questo esempio, l'ID sottorete è 807861 e
l'ID VLAN è 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Conferma l'ubicazione della VLAN. In questo esempio, l'ubicazione è dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Crea un cluster utilizzando l'ubicazione e l'ID VLAN che hai identificato. Includi l'indicatore `--no-subnet` per impedire la creazione automatica di una nuova sottorete IP pubblica portatile e di una nuova sottorete IP privata portatile.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Verifica che la creazione del cluster sia stata richiesta.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** servono fino a 15 minuti perché le macchine del nodo di lavoro siano ordinate e che il cluster
sia configurato e ne sia stato eseguito il provisioning al tuo account.

    Quando è stato terminato il provisioning del tuo cluster,
lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Controlla lo stato dei nodi di lavoro.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione
passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**,
puoi accedere al
cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Aggiungi la sottorete al tuo cluster specificando l'ID sottorete. Quando rendi disponibile una sottorete a un
cluster, per te viene creata una mappa di configurazione Kubernetes che include tutti gli indirizzi IP pubblici
portatili che puoi utilizzare. Se ancora non esiste alcun controller Ingress
per il tuo cluster, viene automaticamente utilizzato un indirizzo IP pubblico portatile per creare il controller
Ingress. Tutti gli altri indirizzi IP pubblici portatili possono essere utilizzati per creare i servizi del programma di bilanciamento del carico
per le tue applicazioni.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Aggiunta delle sottoreti gestite dall'utente e degli indirizzi IP ai cluster Kubernetes
{: #user_subnet}

Fornisci la tua propria sottorete da una rete in loco a cui desideri che {{site.data.keyword.containershort_notm}} acceda. Dopodiché, puoi aggiungere indirizzi IP privati da tale sottorete ai servizi del programma di bilanciamento del carico nel tuo cluster Kubernetes.

Requisiti:
- Le sottoreti gestite dall'utente possono essere aggiunte solo a VLAN private.
- Il limite di lunghezza del prefisso della sottorete è da /24 a /30. Ad esempio, `203.0.113.0/24` specifica 253 indirizzi IP privati utilizzabili, mentre `203.0.113.0/30` specifica 1 indirizzo IP privato utilizzabile.
- Il primo indirizzo IP nella sottorete deve essere utilizzato come gateway della sottorete.

Prima di iniziare: configura l'instradamento del traffico di rete in entrata e in uscita della sottorete esterna. Inoltre, conferma di disporre di una connettività VPN tra il dispositivo gateway del data center in loco e il Vyatta della rete privata nel tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer). Per ulteriori informazioni consulta questo post del blog [ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

1. Visualizza l'ID della VLAN privata del tuo cluster. Individua la sezione **VLAN**. Nel campo **User-managed**, identifica l'ID della VLAN con _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Aggiungi la sottorete esterna alla tua VLAN privata. Gli indirizzi IP privati portatili vengono aggiunti alla mappa di configurazione del cluster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Esempio:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Verifica che la sottorete fornita dall'utente sia stata aggiunta. Il campo **User-managed** è _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Aggiungi un programma di bilanciamento del carico per accedere alla tua applicazione da una rete privata. Se desideri utilizzare un indirizzo IP privato dalla sottorete che hai aggiunto, devi specificare un indirizzo IP quando crei un programma di bilanciamento del carico privato. Diversamente, viene scelto a caso un indirizzo IP dalle sottoreti dell'infrastruttura IBM Cloud (SoftLayer) o dalle sottoreti fornite dall'utente sulla VLAN privata. Per ulteriori informazioni, consulta [Configurazione dell'accesso a un'applicazione](cs_apps.html#cs_apps_public_load_balancer).

    File di configurazione di esempio per un servizio del programma di bilanciamento del carico privato con un indirizzo IP specificato:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <myservice>
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    spec:
      type: LoadBalancer
      selector:
        <selectorkey>:<selectorvalue>
      ports:
       - protocol: TCP
         port: 8080
      loadBalancerIP: <private_ip_address>
    ```
    {: codeblock}

<br />


## Utilizzo di condivisioni file NFS esistenti nei cluster
{: #cs_cluster_volume_create}

Se hai già delle condivisioni file NFS esistenti nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) che vuoi utilizzare con Kubernetes, puoi farlo creando dei volumi persistenti sulla tua condivisione file NFS esistente. Un
volume persistente è un pezzo di hardware effettivo che funge da risorsa cluster Kubernetes e può
essere utilizzato dall'utente del cluster.
{:shortdesc}

Kubernetes differenzia i volumi persistenti che rappresentano l'hardware effettivo e
le attestazioni del volume persistente che sono delle richieste di archiviazione normalmente avviate dall'utente del cluster. Il seguente diagramma illustra la relazione tra i volumi persistenti e le attestazioni del volume persistente.

![Crea i volumi persistenti e le attestazioni del volume persistente](images/cs_cluster_pv_pvc.png)

 Come illustrato nel diagramma, per abilitare l'utilizzo delle condivisioni file NFS esistenti con Kubernetes, devi creare volumi persistenti con una determinata dimensione e modalità di accesso e creare un'attestazione del volume persistente che corrisponda alla specifica del volume persistente. Se il volume persistente e l'attestazione del volume persistente corrispondono, vengono
collegati tra loro. Solo le attestazioni del volume persistente collegate possono essere utilizzate dall'utente del cluster per montare
il volume in un pod. Questo processo viene indicato come provisioning statico di archiviazione persistente.

Prima di iniziare, assicurati di avere una condivisione file NFS esistente da utilizzare per creare
il tuo volume persistente.

**Nota:** il provisioning statico di archiviazione persistente viene applicato solo alle condivisioni file NFS esistenti. Se non
disponi di condivisioni file NFS esistenti, gli utenti del cluster possono utilizzare il processo di [provisioning
dinamico](cs_apps.html#cs_apps_volume_claim) per aggiungere i volumi persistenti.

Per creare un volume persistente e un'attestazione del volume persistente corrispondente, segui la seguente procedura.

1.  Nel tuo account dell'infrastruttura IBM Cloud (SoftLayer), cerca l'ID e il percorso della condivisione file NFS in cui vuoi creare l'oggetto del volume persistente.
    1.  Accedi al tuo account dell'infrastruttura IBM Cloud (SoftLayer).
    2.  Fai clic su **Archiviazione**.
    3.  Fai clic su **Archiviazione file** e prendi nota dell'ID e del percorso della condivisione file NFS
che vuoi utilizzare.
2.  Apri il tuo editor preferito.
3.  Crea un file di configurazione dell'archiviazione per il tuo volume persistente.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.softlayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Tabella 8.Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Immetti il nome dell'oggetto del volume persistente che vuoi creare.</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>Immetti la dimensione di archiviazione della condivisione file NFS esistente. La dimensione di archiviazione deve essere scritta
in gigabyte, ad esempio, 20Gi (20 GB) o 1000Gi (1 TB) e deve corrispondere alla dimensione
della condivisione file esistente.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Le modalità di accesso definiscono il modo in cui l'attestazione del volume persistente può essere montata in un
nodo di lavoro.<ul><li>ReadWriteOnce (RWO): Il volume persistente può essere montato nei pod solo in un nodo di lavoro. I pod montati in questo volume persistente possono leggere e scrivere nel volume.</li><li>ReadOnlyMany (ROX): Il volume persistente può essere montato nei pod
ospitati in più nodi di lavoro. I pod montati in questo volume persistente possono solo leggere dal volume.</li><li>ReadWriteMany (RWX): Questo volume persistente può essere montato nei pod
ospitati in più nodi di lavoro. I pod montati in questo volume persistente possono leggere e scrivere nel volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Immetti l'ID server della condivisione file NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Immetti il percorso della condivisione file NFS in cui vuoi creare l'oggetto del volume persistente.</td>
    </tr>
    </tbody></table>

4.  Crea l'oggetto del volume persistente nel tuo cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Esempio

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

5.  Verifica che il volume persistente sia stato creato.

    ```
    kubectl get pv
    ```
    {: pre}

6.  Crea un altro file di configurazione per creare la tua attestazione del volume persistente. Affinché l'attestazione del volume persistente corrisponda all'oggetto del volume persistente creato
in precedenza, devi scegliere lo stesso valore per `storage` e
`accessMode`. Il campo `storage-class` deve essere vuoto. Se uno di questi
campi non corrisponde al volume persistente, verrà creato automaticamente un nuovo volume
persistente.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

7.  Crea la tua attestazione del volume persistente.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

8.  Verifica che la tua attestazione del volume persistente sia stata creata e collegata all'oggetto del volume persistente. Questo processo può richiedere qualche minuto.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Il tuo output sarà simile al seguente.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Hai creato correttamente un oggetto del volume persistente e lo hai collegato a un'attestazione del
volume persistente. Gli utenti del cluster possono ora [montare l'attestazione del volume persistente](cs_apps.html#cs_apps_volume_mount) nel proprio pod e iniziare a leggere
e a scrivere sull'oggetto del volume persistente.

<br />


## Configurazione della registrazione cluster
{: #cs_logging}

I log ti aiutano a risolvere i problemi con i tuoi cluster e applicazioni. A volte, potresti voler inviare i log in una posizione specifica per l'elaborazione o l'archiviazione di lungo termine. Su un cluster Kubernetes in {{site.data.keyword.containershort_notm}}, puoi abilitare l'inoltro dei log per il tuo cluster e scegliere la posizione in cui i log verranno inoltrati. **Nota**: l'inoltro dei log è supportato solo per i cluster standard.
{:shortdesc}

### Visualizzazione dei log
{: #cs_view_logs}

Per visualizzare i log dei cluster e dei contenitori, puoi utilizzare le funzioni di registrazione Docker e Kubernetes standard.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

Per i cluster standard, i log si trovano nell'account {{site.data.keyword.Bluemix_notm}} al quale hai effettuato l'accesso quando hai creato il cluster Kubernetes. Se quando hai creato il cluster hai specificato uno spazio {{site.data.keyword.Bluemix_notm}}, i log si trovano in quello spazio. I log del contenitore vengono monitorati e inoltrati dall'esterno del contenitore. Puoi accedere ai log per un contenitore utilizzando il dashboard Kibana. Per ulteriori informazioni sulla registrazione, consulta [Registrazione di {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Nota**: se i log si trovano nello spazio che hai specificato durante la creazione del cluster, il proprietario dell'account deve disporre delle autorizzazioni di Gestore, Sviluppatore o Revisore in quello spazio per visualizzare i log. Per ulteriori informazioni sulla modifica delle politiche di accesso e delle autorizzazioni {{site.data.keyword.containershort_notm}}, vedi [Gestione dell'accesso al cluster](cs_cluster.html#cs_cluster_user). Una volta modificate le autorizzazioni, potrebbero essere necessarie fino a 24 ore prima di poter visualizzare i log.

Per accedere al dashboard Kibana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai creato il cluster.
- Stati Uniti Sud e Stati Uniti Est: https://logging.ng.bluemix.net
- Regno Unito Sud e Europa centrale: https://logging.eu-fra.bluemix.net

Per ulteriori informazioni sulla visualizzazione dei log, vedi [Passaggio a Kibana da un browser web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

#### Log Docker
{: #cs_view_logs_docker}

Puoi sfruttare le funzionalità di registrazione Docker integrate per controllare le attività per i flussi di output
STDOUT e STDERR standard. Per ulteriori informazioni, vedi [Visualizzazione dei log di un contenitore in esecuzione in un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

### Configurazione dell'inoltro del log per uno spazio dei nomi del contenitore Docker
{: #cs_configure_namespace_logs}

Per impostazione predefinita, {{site.data.keyword.containershort_notm}} inoltra i log dello spazio dei nomi del contenitore Docker a {{site.data.keyword.loganalysislong_notm}}. Puoi anche inoltrare i log dello spazio dei nomi del contenitore a un server syslog esterno creando una nuova configurazione di inoltro del log.
{:shortdesc}

**Nota**: per visualizzare i log nell'ubicazione Sydney, devi inoltrare i log a un server syslog esterno.

#### Abilitazione dell'inoltro dei log a syslog
{: #cs_namespace_enable}

Prima di iniziare:

1. Configura un server in grado di accettare un protocollo syslog in due modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.
  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore in un cluster Kubernetes. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui è ubicato lo spazio dei nomi.

Per inoltrare i log del tuo spazio dei nomi a un server syslog:

1. Crea la configurazione di registrazione.

    ```
    bx cs logging-config-create <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabella 9. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Il comando per creare la configurazione di inoltro del log per il tuo spazio dei nomi.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--namespace <em>&lt;my_namespace&gt;</em></code></td>
    <td>Sostituisci <em>&lt;mio_spazionomi&gt;</em> con il nome dello spazio dei nomi. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel contenitore utilizzeranno questa configurazione.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_hostname&gt;</em> con il nome host o l'indirizzo IP del server di raccolta del log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_port&gt;</em> con la porta del server di raccolta del log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code> per syslog.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Il tipo di logo per syslog.</td>
    </tr>
    </tbody></table>

2. Verifica che la configurazione di inoltro del log sia stata creata.

    * Per elencare tutte le configurazioni di inoltro del log nel cluster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Output di esempio:

      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

    * Per elencare solo le configurazioni di registrazione dello spazio dei nomi:
      ```
      bx cs logging-config-get <my_cluster> --logsource namespaces
      ```
      {: pre}

      Output di esempio:

      ```
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

#### Aggiornamento della configurazione del server syslog
{: #cs_namespace_update}

Se desideri aggiornare i dettagli della configurazione del server syslog corrente o passare a un server syslog diverso, puoi aggiornare la configurazione di inoltro di registrazione.
{:shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova lo spazio dei nomi.

1. Aggiorna la configurazione di inoltro del log.

    ```
    bx cs logging-config-update <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabella 10. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Il comando per aggiornare la configurazione di inoltro del log per il tuo spazio dei nomi.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--namepsace <em>&lt;my_namespace&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_namespace&gt;</em> con il nome dello spazio dei nomi con la configurazione di registrazione.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_hostname&gt;</em> con il nome host o l'indirizzo IP del server di raccolta del log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_port&gt;</em> con la porta del server di raccolta del log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code>.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Il tipo di registrazione per <code>syslog</code>.</td>
    </tr>
    </tbody></table>

2. Verifica che la configurazione di inoltro del log sia stata aggiornata.
    ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
    {: pre}

    Output di esempio:

    ```
    Namespace         Host             Port    Protocol
    default           myhostname.com   5514    syslog
    my-namespace      localhost        5514    syslog
    ```
    {: screen}

#### Arresto dell'inoltro del log a syslog
{: #cs_namespace_delete}

Puoi arrestare l'inoltro dei log da uno spazio dei nomi eliminando la configurazione di registrazione.

**Nota**: questa azione elimina solo la configurazione per l'inoltro dei log a un server syslog. I log dello spazio dei nomi continuano ad essere inoltrati a {{site.data.keyword.loganalysislong_notm}}.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster in cui si trova lo spazio dei nomi.

1. Elimina la configurazione di registrazione.

    ```
    bx cs logging-config-rm <my_cluster> --namespace <my_namespace>
    ```
    {: pre}
    Sostituisci <em>&lt;my_cluster&gt;</em> con il nome del cluster in cui si trova la configurazione di registrazione e <em>&lt;my_namespace&gt;</em> con il nome dello spazio dei nomi.

### Configurazione dell'inoltro dei log per applicazioni, nodi di lavoro, il componente di sistema Kubernetes e il controller Ingress
{: #cs_configure_log_source_logs}

Per impostazione predefinita, {{site.data.keyword.containershort_notm}} inoltra i log dello spazio dei nomi del contenitore Docker a {{site.data.keyword.loganalysislong_notm}}. Puoi anche configurare l'inoltro dei log per altre origini log, quali applicazioni, nodi di lavoro, cluster Kubernetes e controller Ingress.
{:shortdesc}

Rivedi le seguenti opzioni per informazioni su ciascuna origine log.

|Origine log|Caratteristiche|Percorsi log|
|----------|---------------|-----|
|`application`|Log per la tua applicazione eseguita in un cluster Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`
|`worker`|Log per i nodi di lavoro della macchina virtuale in un cluster Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`
|`kubernetes`|Log per il componente di sistema Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`
|`ingress`|Log per un controller Ingress che gestisce il traffico di rete in arrivo in un cluster Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`
{: caption="Tabella 11. Caratteristiche delle origini log." caption-side="top"}

#### Abilitazione dell'inoltro dei log per le applicazioni
{: #cs_apps_enable}

I log delle applicazioni devono essere vincolati a una directory specifica sul nodo host. Puoi farlo montando un volume del percorso host nei contenitori con un percorso di montaggio. Questo percorso di montaggio funge da directory sui tuoi contenitori in cui vengono inviati i log delle applicazioni. La directory del percorso host predefinita, `/var/log/apps`, viene creata automaticamente quando crei il montaggio del volume.

Rivedi i seguenti aspetti dell'inoltro dei log dell'applicazione:
* I log vengono letti in modo ricorsivo dal percorso /var/log/apps. Ciò significa che puoi inserire i log dell'applicazione nelle sottodirectory del percorso /var/log/apps.
* Vengono inoltrati solo i file di log dell'applicazione con le estensioni `.log` o `.err`.
* Quando abiliti l'inoltro dei log per la prima volta, i log dell'applicazione vengono messi in coda invece di essere letti dall'inizio. Ciò significa che il contenuto di eventuali log già presenti prima che la registrazione dell'applicazione venisse abilitata non viene letto. I log vengono letti dal punto in cui la registrazione è stata abilitata. Tuttavia, una volta che l'inoltro dei log è stato abilitato, i log vengono sempre prelevati dal punto in cui erano stati interrotti.
* Quando monti il volume del percorso host `/var/log/apps` nei contenitori, tutti i contenitori scrivono in questa stessa directory. Ciò significa che se i tuoi contenitori scrivono nello stesso nome file, i contenitori scriveranno nello stesso identico file sull'host. Se questa non è la tua intenzione, puoi impedire ai tuoi contenitori di sovrascrivere gli stessi file di log nominando i file di log da ciascun contenitore in modo diverso.
* Poiché tutti i contenitori scrivono nello stesso nome file, non utilizzare questo metodo per inoltrare i log dell'applicazione per le serie di repliche. Puoi invece scrivere i log dell'applicazione in STDOUT e STDERR. Questi log vengono prelevati come log del contenitore e i log del contenitore vengono automaticamente inoltrati a {{site.data.keyword.loganalysisshort_notm}}. Per inoltrare i log dell'applicazione scritti in STDOUT e STDERR a un server syslog esterno, segui la procedura in [Abilitazione dell'inoltro dei log a syslog](cs_cluster.html#cs_namespace_enable).

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

1. Apri il file di configurazione `.yaml` per il pod dell'applicazione.

2. Aggiungi i seguenti `volumeMounts` e `volumes` al file di configurazione:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Monta il volume nel pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Per creare una configurazione di inoltro dei log, segui la procedura indicata in [Abilitazione dell'inoltro dei log per i nodi di lavoro, il componente di sistema Kubernetes e il controller Ingress](cs_cluster.html#cs_log_sources_enable).

#### Abilitazione dell'inoltro dei log per i nodi di lavoro, il componente di sistema Kubernetes e il controller Ingress
{: #cs_log_sources_enable}

Puoi inoltrare i log a {{site.data.keyword.loganalysislong_notm}} o a un server syslog esterno. Se inoltri i log a {{site.data.keyword.loganalysisshort_notm}}, questi vengono inoltrati nello stesso spazio in cui hai creato il cluster. Se vuoi inoltrare i log da un'origine log a entrambi i server di raccolta log, devi creare due configurazioni di registrazione.
{:shortdesc}

Prima di iniziare:

1. Se vuoi inoltrare i log a un server syslog esterno, puoi configurare un server che accetti un protocollo syslog in due modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.
  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore in un cluster Kubernetes. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.**Nota**: per visualizzare i log nell'ubicazione Sydney, devi inoltrare i log a un server syslog esterno.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

Per abilitare l'inoltro dei log per i nodi di lavoro, il componente di sistema Kubernetes o un controller Ingress:

1. Crea una configurazione di inoltro dei log.

  * Per inoltrare i log a {{site.data.keyword.loganalysisshort_notm}}:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --type ibm
    ```
    {: pre}
    Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster. Sostituisci <em>&lt;my_log_source&gt;</em> con l'origine log. I valori accettati sono `application`, `worker`, `kubernetes` e `ingress`.

  * Per inoltrare i log a un server syslog esterno:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabella 12. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Il comando per creare la configurazione di inoltro dei log syslog per la tua origine log.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_log_source&gt;</em> con l'origine log. I valori accettati sono <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_hostname&gt;</em> con il nome host o l'indirizzo IP del server di raccolta del log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_port&gt;</em> con la porta del server di raccolta del log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code> per syslog.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Il tipo di log per un server syslog esterno.</td>
    </tr>
    </tbody></table>

2. Verifica che la configurazione di inoltro del log sia stata creata.

    * Per elencare tutte le configurazioni di registrazione nel cluster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Output di esempio:

      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

    * Per elencare le configurazioni di registrazione per un tipo di origine log:
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Output di esempio:

      ```
      Id                                    Source      Host        Port   Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker      localhost   5514   syslog     /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker      -           -      ibm        /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### Aggiornamento del server di raccolta log
{: #cs_log_sources_update}

Puoi aggiornare una configurazione di registrazione per un'applicazione, i nodi di lavoro, il componente di sistema Kubernetes e il controller Ingress modificando il server di raccolta log o il tipo di log.
{: shortdesc}

**Nota**: per visualizzare i log nell'ubicazione Sydney, devi inoltrare i log a un server syslog esterno.

Prima di iniziare:

1. Se modifichi il server di raccolta log in un server syslog, puoi configurare un server che accetti un protocollo syslog in due modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.
  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore in un cluster Kubernetes. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

Per modificare il server di raccolta log per la tua origine log:

1. Aggiorna la configurazione di registrazione.

    ```
    bx cs logging-config-update <my_cluster> --id <log_source_id> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Tabella 13. Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Il comando per aggiornare la configurazione di inoltro dei log per la tua origine log.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_source_id&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_source_id&gt;</em> con l'ID della configurazione dell'origine log.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_log_source&gt;</em> con l'origine log. I valori accettati sono <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_hostname&gt;</em> con il nome host o l'indirizzo IP del server di raccolta del log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_port&gt;</em> con la porta del server di raccolta del log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code> per syslog.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Sostituisci <em>&lt;logging_type&gt;</em> con il nuovo protocollo di inoltro dei log che vuoi utilizzare. Al momento, sono supportati <code>syslog</code> e <code>ibm</code>.</td>
    </tr>
    </tbody></table>

2. Verifica che la configurazione di inoltro del log sia stata aggiornata.

  * Per elencare tutte le configurazioni di registrazione nel cluster:
    ```
    bx cs logging-config-get <my_cluster>
    ```
    {: pre}

    Output di esempio:

    ```
    Logging Configurations
    ---------------------------------------------
    Id                                    Source        Host             Port    Protocol   Paths
    f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
    5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

    Container Log Namespace configurations
    ---------------------------------------------
    Namespace         Host             Port    Protocol
    default           myhostname.com   5514    syslog
    my-namespace      localhost        5514    syslog
    ```
    {: screen}

  * Per elencare le configurazioni di registrazione per un tipo di origine log:
    ```
    bx cs logging-config-get <my_cluster> --logsource worker
    ```
    {: pre}

    Output di esempio:

    ```
    Id                                    Source      Host        Port   Protocol   Paths
    f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker      localhost   5514   syslog     /var/log/syslog,/var/log/auth.log
    5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker      -           -      ibm        /var/log/syslog,/var/log/auth.log
    ```
    {: screen}

#### Arresto dell'inoltro dei log
{: #cs_log_sources_delete}

Puoi arrestare l'inoltro dei log eliminando la configurazione di registrazione.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster in cui si trova l'origine log.

1. Elimina la configurazione di registrazione.

    ```
    bx cs logging-config-rm <my_cluster> --id <log_source_id>
    ```
    {: pre}
    Sostituisci <em>&lt;my_cluster&gt;</em> con il nome del cluster in cui si trova la configurazione di registrazione e <em>&lt;log_source_id&gt;</em> con l'ID della configurazione dell'origine log.


## Configurazione del monitoraggio dei cluster
{: #cs_monitoring}

Le metriche ti aiutano a monitorare l'integrità e le prestazioni dei tuoi cluster. Puoi configurare il monitoraggio dell'integrità per i nodi di lavoro per rilevare e correggere automaticamente tutti i nodi di lavoro che entrano in uno stato di danneggiamento o non operativo. **Nota**: il monitoraggio è supportato solo per i cluster standard.
{:shortdesc}

### Visualizzazione delle metriche
{: #cs_view_metrics}

Puoi utilizzare le funzioni Kubernetes e Docker standard per monitorare l'integrità del tuo cluster e delle applicazioni.
{:shortdesc}

<dl>
<dt>Pagina dei dettagli del cluster in {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} fornisce informazioni sull'integrità
e capacità del tuo cluster e sull'utilizzo delle tue risorse del cluster. Puoi utilizzare questa GUI per ridimensionare il tuo cluster, utilizzare la tua archiviazione persistente e aggiungere ulteriori funzionalità al cluster attraverso il bind del servizio {{site.data.keyword.Bluemix_notm}}. Per visualizzare la pagina dei dettagli del cluster,
vai al tuo **Dashboard {{site.data.keyword.Bluemix_notm}}** e seleziona un cluster.</dd>
<dt>Dashboard Kubernetes</dt>
<dd>Il dashboard Kubernetes è un'interfaccia web di amministrazione in cui puoi esaminare l'integrità dei tuoi nodi di lavoro, trovare le risorse Kubernetes, distribuire le applicazioni inserite in un contenitore e per risolvere i problemi delle applicazioni utilizzando le informazioni di monitoraggio e registrazione. Per ulteriori informazioni su come
accedere al tuo dashboard Kubernetes, consulta [Avvio del dashboard Kubernetes per  {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>Le metriche per i cluster standard si trovano nell'account {{site.data.keyword.Bluemix_notm}} a cui è stato effettuato l'accesso quando è stato creato il cluster Kubernetes. Se quando hai creato il cluster hai specificato uno spazio {{site.data.keyword.Bluemix_notm}}, le metriche si trovano in quello spazio. Le metriche di contenitore sono raccolte automaticamente per tutti i contenitori distribuiti in un cluster. Queste metriche vengono inviate e rese disponibili tramite Grafana. Per ulteriori informazioni sulle metriche, vedi [Monitoraggio per il {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Per accedere al dashboard Grafana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai creato il cluster.<ul><li>Stati Uniti Sud e Stati Uniti Est: https://metrics.ng.bluemix.net</li><li>Regno Unito-Sud: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### Altri strumenti di monitoraggio dell'integrità
{: #cs_health_tools}

Puoi configurare altri strumenti per ulteriori funzionalità di monitoraggio.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus è uno strumento di monitoraggio, registrazione e avviso open source progettato per Kubernetes. Lo strumento recupera informazioni dettagliate sul cluster, sui nodi di lavoro e sull'integrità della distribuzione in base alle informazioni di registrazione di Kubernetes. Per le informazioni di configurazione, consulta [Integrazione dei servizi con {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_integrations).</dd>
</dl>

### Configurazione del monitoraggio dell'integrità per i nodi di lavoro con Autorecovery
{: #cs_configure_worker_monitoring}

Il sistema Autorecovery di {{site.data.keyword.containerlong_notm}} può essere distribuito nei cluster esistenti di Kubernetes versione 1.7 o successive. Il sistema Autorecovery utilizza vari controlli per interrogare lo stato di integrità dei nodi di lavoro. Se Autorecovery rileva un nodo di lavoro non integro in base ai controlli configurati, attiva un'azione correttiva come un ricaricamento del sistema operativo sul nodo di lavoro. Viene eseguita un'azione correttiva su un solo nodo di lavoro alla volta. Il nodo di lavoro deve completare correttamente l'azione correttiva prima che qualsiasi altro nodo di lavoro sia sottoposto a un'azione correttiva.
**NOTA**: Autorecovery richiede che almeno un nodo sia integro per funzionare correttamente. Configura Autorecovery con controlli attivi solo nei cluster con due o più nodi di lavoro. 

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui vuoi controllare lo stato dei nodi di lavoro.

1. Crea un file di mappa di configurazione che definisca i tuoi controlli in formato JSON. Ad esempio, il seguente file YAML definisce tre controlli: un controllo HTTP e due controlli del server API Kubernetes.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>Tabella 15. Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Il nome della configurazione <code>ibm-worker-recovery-checks</code> è una costante e non può essere modificato.</td>
    </tr>
    <tr>
    <td><code>spazio dei nomi</code></td>
    <td>Lo spazio dei nomi <code>kube-system</code> è una costante e non può essere modificato.</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>Immetti il tipo di controllo che vuoi venga utilizzato da Autorecovery. <ul><li><code>HTTP</code>: Autorecovery richiama i server HTTP in esecuzione su ciascun nodo per determinare se i nodi vengono eseguiti correttamente.</li><li><code>KUBEAPI</code>: Autorecovery richiama il server API Kubernetes e legge i dati sullo stato di integrità riportati dai nodi di lavoro.</li></ul></td>
    </tr>
    <tr>
    <td><code>Resource</code></td>
    <td>Quando il tipo di controllo è <code>KUBEAPI</code>, immetti il tipo di risorsa che vuoi venga controllata da Autorecovery. I valori accettati sono <code>NODE</code> o <code>PODS</code>.</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>Immetti la soglia per il numero di controlli non riusciti consecutivi. Quando viene raggiunta questa soglia, Autorecovery attiva l'azione correttiva specificata. Ad esempio, se il valore è 3 e Autorecovery non riesce ad eseguire un controllo configurato tre volte consecutive, Autorecovery attiva l'azione correttiva associata al controllo.</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>Quando il tipo di risorsa è <code>PODS</code>, immetti la soglia per la percentuale di pod su un nodo di lavoro che può trovarsi in uno stato [NotReady ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Questa percentuale si basa sul numero totale di pod pianificati su un nodo di lavoro. Quando un controllo determina che la percentuale di pod non integri è maggiore della soglia, il controllo conta come un errore.</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>Immetti l'azione da eseguire quando viene raggiunta la soglia di errore. Un'azione correttiva viene eseguita solo mentre nessun altro nodo di lavoro viene riparato e quando questo nodo di lavoro non si trova in un periodo di raffreddamento da un'azione precedente. <ul><li><code>REBOOT</code>: riavvia il nodo di lavoro.</li><li><code>RELOAD</code>: ricarica tutte le configurazioni necessarie per il nodo di lavoro da un sistema operativo pulito.</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>Immetti il numero di secondi in cui Autorecovery deve attendere di immettere un'altra azione correttiva per un nodo per il quale è già stata emessa un'azione correttiva. Il periodo di raffreddamento inizia nel momento in cui viene emessa un'azione correttiva.</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>Immetti il numero di secondi tra i controlli consecutivi. Ad esempio, se il valore è 180, Autorecovery esegue il controllo su ciascun nodo ogni 3 minuti. </td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>Immetti il numero massimo di secondi impiegati da una chiamata di controllo al database prima che Autorecovery termini l'operazione di chiamata. Il valore per <code>TimeoutSeconds</code> deve essere inferiore al valore per <code>IntervalSeconds</code>.</td>
    </tr>
    <tr>
    <td><code>Porta</code></td>
    <td>Quando il tipo di controllo è <code>HTTP</code>, immetti la porta a cui deve essere associato il server HTTP sui nodi di lavoro. Questa porta deve essere esposta sull'IP di ogni nodo di lavoro nel cluster. Autorecovery richiede un numero di porta costante tra tutti i nodi per il controllo dei server. Utilizza [DaemonSets ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) quando distribuisci un server personalizzato in un cluster.</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>Quando il tipo di controllo è <code>HTTP</code>, immetti lo stato del server HTTP che prevedi venga restituito dal controllo. Ad esempio, un valore di 200 indica che prevedi una risposta <code>OK</code> dal server.</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>Quando il tipo di controllo è <code>HTTP</code>, immetti il percorso che viene richiesto dal server HTTP. Questo valore è in genere il percorso delle metriche per il server in esecuzione su tutti i nodi di lavoro.</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>Immetti <code>true</code> per abilitare il controllo o <code>false</code> per disabilitarlo.</td>
    </tr>
    </tbody></table>

2. Crea la mappa di configurazione nel tuo cluster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Verifica di aver creato la mappa di configurazione con il nome `ibm-worker-recovery-checks` nello spazio dei nomi `kube-system` con i controlli appropriati.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Assicurati di aver creato un segreto Docker pull con il nome `international-registry-docker-secret` nello spazio dei nomi `kube-system`. Autorecovery è ospitato nel registro Docker internazionale di {{site.data.keyword.registryshort_notm}}. Se non hai creato un segreto del registro Docker che contiene credenziali valide per il registro internazionale, creane uno per eseguire il sistema Autorecovery.

    1. Installa il plug-in {{site.data.keyword.registryshort_notm}}.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Specifica il registro internazionale.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Crea un token del registro internazionale.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Imposta la variabile di ambiente `INTERNATIONAL_REGISTRY_TOKEN` sul token che hai creato.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Imposta la variabile di ambiente `DOCKER_EMAIL` sull'utente corrente. Il tuo indirizzo e-mail è necessario solo per eseguire il comando `kubectl` nel passo successivo.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Crea il segreto Docker pull.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Distribuisci Autorecovery nel tuo cluster applicando questo file YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. Dopo alcuni minuti, puoi controllare la sezione `Events` nell'output del seguente comando per visualizzare l'attività sulla distribuzione di Autorecovery.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## Visualizzazione delle risorse del cluster Kubernetes
{: #cs_weavescope}

Weave Scope fornisce un diagramma visivo delle risorse in un cluster Kubernetes,
inclusi i servizi, i pod, i contenitori, i processi, i nodi e altro. Scope fornisce metriche interattive
per la CPU e la memoria e inoltre fornisce strumenti per inserire ed eseguire in un contenitore.
{:shortdesc}

Prima di iniziare:

-   Ricorda di non esporre le informazioni del tuo cluster pubblicamente su internet. Completa questa procedura per distribuire in sicurezza Weave Scope e accedervi da un browser web
localmente.
-   Se non ne hai già uno, [crea un
cluster standard](#cs_cluster_ui). Weave Scope può essere intensivo per la CPU, specialmente l'applicazione. Esegui Weave Scope con grandi cluster a pagamento, non con cluster lite.
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.


Per utilizzare Weave Scope con un cluster:
2.  Distribuisci uno dei file di configurazione delle autorizzazioni RBAC fornite nel
cluster.

    Per abilitare le autorizzazioni di lettura/scrittura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Per abilitare le autorizzazioni di
sola
lettura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Output:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Distribuisci il servizio Weave Scope, che è accessibile privatamente dall'indirizzo IP del cluster.

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Output:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Esegui una comando di inoltro della porta per visualizzare il servizio nel tuo computer. Ora che Weave Scope è stato configurato con il cluster, per accedere a Weave Scope successivamente, puoi
eseguire questo comando di inoltro della porta senza dover completare nuovamente i precedenti passi di configurazione.

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Output:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Apri il tuo browser web in `http://localhost:4040`. Senza i componenti predefiniti distribuiti, viene visualizzato il seguente diagramma. Puoi scegliere di visualizzare i diagrammi della topologia o le tabelle delle risorse Kubernetes nel cluster.

     <img src="images/weave_scope.png" alt="Topologia di esempio da Weave Scope" style="width:357px;" />


[Ulteriori informazioni sulle funzioni Weave Scope ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.weave.works/docs/scope/latest/features/).

<br />


## Rimozione dei cluster
{: #cs_cluster_remove}

Quando non hai più bisogno di un cluster, puoi rimuoverlo in modo che non utilizzi
più risorse.
{:shortdesc}

I cluster lite e standard creati con un account lite o Pagamento a consumo di {{site.data.keyword.Bluemix_notm}} devono essere rimossi manualmente dall'utente quando non sono più necessari. 

Quando elimini un cluster, stai anche eliminando le risorse nel cluster,
inclusi i contenitori, i pod, i servizi associati e i segreti. Se quando elimini il tuo cluster non elimini l'archiviazione, puoi eliminarla attraverso il dashboard dell'infrastruttura IBM Cloud (SoftLayer) nella GUI {{site.data.keyword.Bluemix_notm}}. A causa del ciclo di fatturazione mensile, non è possibile eliminare un'attestazione del volume persistente durante l'ultimo
giorno del mese. Se elimini l'attestazione del volume persistente l'ultimo giorno del mese, l'eliminazione rimane in sospeso fino all'inizio del mese successivo.

**Avvertenza:** non è stato creato alcun backup del tuo cluster o dei tuoi dati nella tua memoria persistente. L'eliminazione di un cluster è permanente e non può essere annullata.

-   Dalla GUI {{site.data.keyword.Bluemix_notm}}
    1.  Seleziona il tuo cluster
e fai clic su **Elimina** dal gruppo **Ulteriori azioni...**.
-   Dalla CLI {{site.data.keyword.Bluemix_notm}}
    1.  Elenca i cluster disponibili.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Elimina il cluster.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  Segui le richieste e scegli se eliminare le risorse del cluster.

Quando rimuovi un cluster, puoi scegliere di rimuovere le sottoreti portatili e l'archiviazione persistente ad esso associato:
- Le sottoreti sono utilizzate per assegnare indirizzi IP pubblici portatili ai servizi di bilanciamento del carico o al tuo controller Ingress. Se le mantieni, puoi riutilizzarle in un nuovo cluster o eliminarle manualmente in un secondo momento dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).
- Se hai creato un'attestazione del volume persistente utilizzando una condivisione file esistente [#cs_cluster_volume_create], non potrai eliminare la condivisione file quando elimini il cluster. Devi eliminare manualmente in seguito la condivisione file dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).
- L'archiviazione persistente fornisce l'alta disponibilità per i tuoi dati. Se la elimini, non puoi recuperare i tuoi dati.
