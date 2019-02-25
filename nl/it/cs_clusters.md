---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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
{:gif: data-image-type='gif'}


# Configurazione di cluster e nodi di lavoro
{: #clusters}
Crea i cluster e aggiungi i nodi di lavoro per aumentare la capacità del cluster in {{site.data.keyword.containerlong}}. Sei ancora nella fase iniziale? Prova l'[esercitazione relativa alla creazione di un cluster Kubernetes](cs_tutorials.html#cs_cluster_tutorial).
{: shortdesc}

## Preparazione alla creazione dei cluster
{: #cluster_prepare}

Con {{site.data.keyword.containerlong_notm}}, puoi creare un ambiente altamente disponibile e sicuro per le tue applicazioni, con molte funzionalità aggiuntive integrate o configurabili. Le molte possibilità che hai con i cluster significano anche che hai molte decisioni da prendere quando crei un cluster. I seguenti passi delineano ciò che devi considerare per l'impostazione del tuo account, delle autorizzazioni, dei gruppi di risorse, dello spanning della VLAN, della configurazione del cluster per zona e hardware e delle informazioni di fatturazione.
{: shortdesc}

L'elenco è diviso in due parti:
*  **Livello di account**: si tratta di preparazioni che, una volta eseguite dall'amministratore dell'account, potresti non dover modificare ogni volta che crei un cluster. Tuttavia, ogni volta che crei un cluster, puoi comunque verificare che lo stato corrente a livello di account sia quello che desideri.
*  **Livello di cluster**: si tratta di preparazioni che hanno un impatto sul tuo cluster ogni volta che ne crei uno.

### Livello di account
{: #prepare_account_level}

1.  [Crea o aggiorna il tuo account a un account fatturabile (Pagamento a consumo o Sottoscrizione {{site.data.keyword.Bluemix_notm}})](https://console.bluemix.net/registration/).
2.  [Configura una chiave API di {{site.data.keyword.containerlong_notm}}](cs_users.html#api_key) nelle regioni in cui vuoi creare i cluster. Assegna la chiave API con le autorizzazioni appropriate per creare i cluster:
    *  Ruolo **Super utente** per l'infrastruttura IBM Cloud (SoftLayer).
    *  Ruolo di gestione della piattaforma **Amministratore** per {{site.data.keyword.containerlong_notm}} a livello di account.
    *  Ruolo di gestione della piattaforma **Amministratore** per {{site.data.keyword.registrylong_notm}} a livello di account.

    Sei il proprietario dell'account? Hai già le autorizzazioni necessarie! Quando crei un cluster, la chiave API per tale regione e gruppo di risorse viene impostata con le tue credenziali.
    {: tip}

3.  Se il tuo account utilizza più gruppi di risorse, scopri la strategia del tuo account per la [gestione dei gruppi di risorse](cs_users.html#resource_groups). 
    *  Il cluster viene creato nel gruppo di risorse che specifichi quando accedi a {{site.data.keyword.Bluemix_notm}}. Se non specifichi un gruppo di risorse, viene utilizzato automaticamente il gruppo di risorse predefinito.
    *  Se vuoi creare un cluster in un gruppo di risorse diverso da quello predefinito, devi disporre almeno del ruolo **Visualizzatore** per il gruppo di risorse. Se non disponi di alcun ruolo per il gruppo di risorse ma sei comunque un **Amministratore** per il servizio all'interno del gruppo di risorse, il tuo cluster viene creato nel gruppo di risorse predefinito.
    *  Non puoi modificare il gruppo di risorse di un cluster. Il cluster può essere integrato solo con altri servizi {{site.data.keyword.Bluemix_notm}} che si trovano nello stesso gruppo di risorse o con i servizi che non supportano i gruppi di risorse, come {{site.data.keyword.registrylong_notm}}.
    *  Se intendi utilizzare [{{site.data.keyword.monitoringlong_notm}} per le metriche](cs_health.html#view_metrics), assegna al cluster un nome univoco tra tutti i gruppi di risorse e tutte le regioni nel tuo account per evitare conflitti di denominazione delle metriche.
    * Se hai un account {{site.data.keyword.Bluemix_dedicated}}, devi creare i cluster solo nel gruppo di risorse predefinito.
4.  Abilita lo spanning della VLAN. Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).

### Livello di cluster
{: #prepare_cluster_level}

1.  Assicurati di avere il ruolo della piattaforma **Amministratore** per {{site.data.keyword.containerlong_notm}}.
    1.  Dalla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), fai clic su **Gestisci > Account > Utenti**.
    2.  Dalla tabella, seleziona te stesso.
    3.  Dalla scheda **Politiche di accesso**, conferma che il tuo **Ruolo** sia **Amministratore**. Puoi essere l'**Amministratore** per tutte le risorse nell'account o almeno per {{site.data.keyword.containershort_notm}}. **Nota**: se disponi del ruolo **Amministratore** per {{site.data.keyword.containershort_notm}} in un solo gruppo di risorse o una sola regione anziché nell'intero account, devi avere almeno il ruolo di **Visualizzatore** a livello di account per visualizzare le VLAN dell'account.
2.  Decidi tra un [cluster gratuito o standard](cs_why.html#cluster_types). Puoi creare 1 cluster gratuito per provare alcune delle funzionalità per 30 giorni oppure puoi creare cluster standard completamente personalizzabili con le tue scelte di isolamento hardware. Crea un cluster standard per ottenere maggiori vantaggi e maggior controllo sulle prestazioni del tuo cluster.
3.  [Pianifica la configurazione del tuo cluster](cs_clusters_planning.html#plan_clusters).
    *  Decidi se creare un cluster a [zona singola](cs_clusters_planning.html#single_zone) o [multizona](cs_clusters_planning.html#multizone). Nota che i cluster multizona sono disponibili solo in determinate ubicazioni.
    *  Se vuoi creare un cluster non accessibile pubblicamente, esamina la [procedura aggiuntiva per il cluster privato](cs_clusters_planning.html#private_clusters).
    *  Scegli il tipo di [hardware e isolamento](cs_clusters_planning.html#shared_dedicated_node) che vuoi per i nodi di lavoro del tuo cluster, compresa la decisione tra macchine virtuali o bare metal.
4.  Per i cluster standard, puoi [stimare i costi con lo stimatore del costo ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes). Per ulteriori informazioni sugli addebiti che potrebbero non essere inclusi nello stimatore, vedi [Prezzi e fatturazione](cs_why.html#pricing).
<br>
<br>

**Operazioni successive**
* [Creazione dei cluster con la console {{site.data.keyword.Bluemix_notm}}](#clusters_ui)
* [Creazione dei cluster con la CLI {{site.data.keyword.Bluemix_notm}}](#clusters_cli)

## Creazione dei cluster con la console {{site.data.keyword.Bluemix_notm}}
{: #clusters_ui}

Lo scopo del cluster Kubernetes è quello di definire un insieme di risorse, nodi, reti e dispositivi di archiviazione che mantengano le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

### Creazione di un cluster gratuito
{: #clusters_ui_free}

Puoi utilizzare il tuo cluster gratuito per acquisire familiarità con il funzionamento di {{site.data.keyword.containerlong_notm}}. Con i cluster gratuiti, puoi comprendere la terminologia, completare un'esercitazione e ottenere le indicazioni necessarie prima di passare ai cluster standard a livello di produzione. Non preoccuparti, ottieni comunque un cluster gratuito anche se disponi di un account fatturabile.

I cluster gratuiti hanno una durata di 30 giorni. Trascorso tale periodo di tempo, il cluster scade e verrà eliminato insieme ai suoi dati. {{site.data.keyword.Bluemix_notm}} non esegue il backup dei dati eliminati e non possono essere ripristinati. Assicurati di eseguire il backup dei dati importanti.
{: note}

1. [Preparati a creare un cluster](#cluster_prepare) per assicurarti di disporre della configurazione account e delle autorizzazioni utente {{site.data.keyword.Bluemix_notm}} corrette e per stabilire la configurazione del cluster e il gruppo di risorse che vuoi utilizzare.

2. Nel [catalogo ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/catalog/?category=containers), seleziona **{{site.data.keyword.containershort_notm}}** per creare un cluster.

3. Seleziona un'ubicazione in cui distribuire il tuo cluster. **Nota**: non puoi creare dei cluster gratuiti nelle ubicazioni di Washington DC (Stati Uniti Est) o Tokyo (Asia Pacifico Nord).

4. Seleziona il piano del cluster **gratuito**.

5. Assegna un nome al tuo cluster. Il nome deve iniziare con una lettera, può contenere lettere, numeri e un trattino (-) e non può contenere più di 35 caratteri. Il nome cluster e la regione in cui viene distribuito il cluster formano il nome dominio completo per il dominio secondario Ingress. Per garantire che il dominio secondario Ingress sia univoco all'interno di una regione, è possibile che il nome cluster venga troncato e vi venga aggiunto un valore casuale all'interno del nome dominio Ingress.


6. Fai clic su **Crea cluster**. Per impostazione predefinita, viene creato un pool di nodi di lavoro con un nodo di lavoro. Puoi vedere lo stato di avanzamento della distribuzione del nodo di lavoro nella scheda **Nodi di lavoro**. Quando la distribuzione è terminata, puoi vedere se il tuo cluster è pronto nella scheda **Panoramica**.

    La modifica dell'ID univoco o del nome dominio assegnato durante la creazione non consente al master di gestire il tuo cluster.
    {: tip}

</br>

### Creazione di un cluster standard
{: #clusters_ui_standard}

1. [Preparati a creare un cluster](#cluster_prepare) per assicurarti di disporre della configurazione account e delle autorizzazioni utente {{site.data.keyword.Bluemix_notm}} corrette e per stabilire la configurazione del cluster e il gruppo di risorse che vuoi utilizzare.

2. Nel [catalogo ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/catalog/?category=containers), seleziona **{{site.data.keyword.containershort_notm}}** per creare un cluster.

3. Seleziona un gruppo di risorse in cui creare il tuo cluster.
  **Nota**:
    * Un cluster può essere creato in un solo gruppo di risorse e, una volta che è stato creato, non puoi modificare il suo gruppo di risorse.
    * I cluster gratuiti vengono creati automaticamente nel gruppo di risorse predefinito.
    * Per creare i cluster in un gruppo di risorse diverso da quello predefinito, devi disporre almeno del [ruolo **Visualizzatore**](cs_users.html#platform) per il gruppo di risorse.

4. Seleziona un'[ubicazione {{site.data.keyword.Bluemix_notm}}](cs_regions.html#regions-and-zones) in cui distribuire il tuo cluster. Per prestazioni ottimali, seleziona l'ubicazione fisicamente più vicina a te. Tieni presente che se selezioni una zona che si trova al di fuori del tuo paese, potresti aver bisogno di un'autorizzazione legale prima di poter archiviare i dati.

5. Seleziona il piano del cluster **standard**. Con un cluster standard hai accesso a funzioni come più nodi di lavoro per un ambiente altamente disponibile.

6. Immetti i dettagli della tua zona.

    1. Seleziona la disponibilità a **Zona singola** o **Multizona**. In un cluster multizona, il nodo master viene distribuito in una zona in grado di supportare il multizona e le risorse del tuo cluster vengono estese tra più zone. Le tue scelte potrebbero essere limitare dalla regione.

    2. Seleziona le zone specifiche in cui desideri ospitare il tuo cluster. Devi selezionare almeno una zona ma puoi selezionarne quante ne desideri. Se selezioni più di una zona, i nodi di lavoro vengono estesi tra le zone che hai scelto e ciò ti fornisce una disponibilità più elevata. Se selezioni solo una zona, puoi [aggiungere le zone al tuo cluster](#add_zone) una volta creato.

    3. Seleziona una VLAN pubblica (facoltativo) e una VLAN privata (obbligatorio) dal tuo account dell'infrastruttura IBM Cloud (SoftLayer). I nodi di lavoro comunicano tra loro utilizzando la VLAN privata. Per comunicare con il master Kubernetes, devi configurare una connettività pubblica per il tuo nodo di lavoro.  Se non hai una VLAN pubblica o privata in questa zona, lascia vuota questa opzione. Verranno create automaticamente per te una VLAN pubblica e una privata. Se hai VLAN esistenti e non specifichi una VLAN pubblica, prendi in considerazione di configurare un firewall, ad esempio una [VRA (Virtual Router Appliance)](/docs/infrastructure/virtual-router-appliance/about.html#about-the-vra). Puoi utilizzare la stessa VLAN per più cluster.
        Se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete. Per ulteriori informazioni, vedi [Pianificazione della rete cluster solo privata](cs_network_cluster.html#private_vlan).
        {: note}

7. Configura il tuo pool di nodi di lavoro predefinito. I pool di nodi di lavoro sono gruppi di nodi di lavoro che condividono la stessa configurazione. Puoi sempre aggiungere altri pool di nodi di lavoro al tuo cluster in un secondo momento.

    1. Seleziona un tipo di isolamento hardware. Il tipo virtuale ha una fatturazione oraria e il tipo bare metal ha una fatturazione mensile.

        - **Virtuale - Dedicato**: i tuoi nodi di lavoro sono ospitati sull'infrastruttura dedicata al tuo account. Le tue risorse fisiche sono completamente isolate.

        - **Virtuale - Condiviso**: le risorse dell'infrastruttura, come l'hypervisor e l'hardware fisico, sono condivise tra te e altri clienti IBM, ma ciascun nodo di lavoro è accessibile solo a te. Sebbene questa opzione sia meno costosa e sufficiente nella maggior parte dei casi, potresti voler verificare i requisiti di prestazioni e infrastruttura con le politiche aziendali.

        - **Bare Metal**: il provisioning dei server bare metal, con fatturazione mensile, viene eseguito tramite l'interazione manuale con l'infrastruttura Cloud IBM (SoftLayer) e il completamento di questo processo può richiedere più di un giorno lavorativo. Bare metal è più adatto per le applicazioni ad alte prestazioni che richiedono più risorse e controllo host. Puoi anche scegliere di abilitare [Trusted Compute](cs_secure.html#trusted_compute) per verificare possibili tentativi di manomissione dei tuoi nodi di lavoro. Trusted Compute è disponibile per alcuni tipi di macchina bare metal selezionati. Ad esempio, le varietà GPU `mgXc` non supportano Trusted Compute. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.

        Assicurati di voler eseguire il provisioning di una macchina bare metal. Poiché viene fatturata mensilmente, se la annulli immediatamente dopo un ordine effettuato per errore, ti viene comunque addebitato l'intero mese.
        {:tip}

    2. Seleziona un tipo di macchina. Il tipo di macchina definisce la quantità di CPU virtuale, di memoria e di spazio disco configurata in ogni nodo di lavoro e resa disponibile ai contenitori. I tipi di macchine bare metal e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Una volta creato il tuo cluster, puoi aggiungere tipi di macchina diversi aggiungendo un nodo di lavoro o un pool al cluster.

    3. Specifica il numero di nodi di lavoro di cui hai bisogno nel cluster. Il numero di nodi di lavoro che hai immesso viene replicato tra il numero di zone che hai selezionato. Ciò significa che se hai 2 zone e selezioni 3 nodi di lavoro, viene eseguito il provisioning di 6 nodi e 3 nodi sono attivi in ciascuna zona.

8. Fornisci al tuo cluster un nome univoco. **Nota**: la modifica dell'ID univoco o del nome dominio assegnato durante la creazione non consente al master di gestire il tuo cluster.

9. Scegli la versione del server API Kubernetes per il nodo master del cluster.

10. Fai clic su **Crea cluster**. Un pool di nodi di lavoro viene creato con il numero di nodi di lavoro che hai specificato. Puoi vedere lo stato di avanzamento della distribuzione del nodo di lavoro nella scheda **Nodi di lavoro**. Quando la distribuzione è terminata, puoi vedere se il tuo cluster è pronto nella scheda **Panoramica**.

**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività:

-   Se hai creato il cluster in una zona con supporto multizona, estendi i nodi di lavoro [aggiungendo una zona al tuo cluster](#add_zone).
-   [Installa le CLI per iniziare ad utilizzare
il tuo cluster.](cs_cli_install.html#cs_cli_install)
-   [Distribuisci un'applicazione nel tuo cluster.](cs_app.html#app_cli)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)
-   Se hai un firewall, potresti dover [aprire le porte richieste](cs_firewall.html#firewall) per utilizzare i comandi `ibmcloud`, `kubectl` o `calicotl`, per consentire il traffico in uscita dal tuo cluster o per consentire il traffico in entrata per i servizi di rete.
-   I cluster con Kubernetes versione 1.10 o successive: controlla chi può creare i pod nel tuo cluster con le [politiche di sicurezza del pod](cs_psp.html).

<br />


## Creazione dei cluster con la CLI {{site.data.keyword.Bluemix_notm}}
{: #clusters_cli}

Lo scopo del cluster Kubernetes è quello di definire un insieme di risorse, nodi, reti e dispositivi di archiviazione che mantengano le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

Prima di iniziare, installa la CLI {{site.data.keyword.Bluemix_notm}} e il [plug-in {{site.data.keyword.containerlong_notm}}](cs_cli_install.html#cs_cli_install).

Per creare un cluster:

1. [Preparati a creare un cluster](#cluster_prepare) per assicurarti di disporre della configurazione account e delle autorizzazioni utente {{site.data.keyword.Bluemix_notm}} corrette e per stabilire la configurazione del cluster e il gruppo di risorse che vuoi utilizzare.

2.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}.

    1.  Esegui l'accesso e immetti le tue credenziali {{site.data.keyword.Bluemix_notm}} quando richiesto.

        ```
        ibmcloud login
        ```
        {: pre}

        Se disponi di un ID federato, utilizza `ibmcloud login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.
        {: tip}

    2. Se disponi di più account {{site.data.keyword.Bluemix_notm}}, seleziona l'account in cui vuoi creare il tuo cluster Kubernetes.

    3.  Per creare i cluster in un gruppo di risorse diverso da quello predefinito, specifica tale gruppo di risorse.
      **Nota**:
        * Un cluster può essere creato in un solo gruppo di risorse e, una volta che è stato creato, non puoi modificare il suo gruppo di risorse.
        * Devi disporre almeno del [ruolo **Visualizzatore**](cs_users.html#platform) per il gruppo di risorse.
        * I cluster gratuiti vengono creati automaticamente nel gruppo di risorse predefinito.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4.  Se vuoi creare o accedere ai cluster Kubernetes in una regione diversa dalla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, esegui `ibmcloud ks region-set`.


4.  Crea un cluster. I cluster standard possono essere creati in qualsiasi regione e zona disponibile. I cluster gratuiti non possono essere creati nelle regioni Stati Uniti Est o Asia Pacifico Nord e zone corrispondenti e non puoi selezionare la zona.

    1.  **Cluster standard**: esamina le zone disponibili. Le zone che vengono mostrate dipendono dalla regione {{site.data.keyword.containerlong_notm}} a cui hai eseguito l'accesso. Per estendere il tuo cluster tra le zone, devi crearlo in una [una zona che supporta il multizona](cs_regions.html#zones).

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **Cluster standard**: scegli una zona ed esamina i tipi di macchina disponibili in tale zona. Il tipo di macchina specifica gli host di calcolo virtuali o fisici disponibili per ciascun nodo di lavoro.

        -  Visualizza il campo **Tipo di server** per scegliere macchine virtuali o fisiche (bare metal).
        -  **Virtuale**: il provisioning delle macchine virtuali, con fatturazione oraria, viene eseguito su hardware condiviso o dedicato.
        -  **Fisico**: il provisioning dei server bare metal, con fatturazione mensile, viene eseguito tramite l'interazione manuale con l'infrastruttura Cloud IBM (SoftLayer) e il completamento di questo processo può richiedere più di un giorno lavorativo. Bare metal è più adatto per le applicazioni ad alte prestazioni che richiedono più risorse e controllo host.
        - **Macchine fisiche con Trusted Compute**: puoi anche scegliere di abilitare [Trusted Compute](cs_secure.html#trusted_compute) per verificare possibili tentativi di manomissione dei tuoi nodi di lavoro. Trusted Compute è disponibile per alcuni tipi di macchina bare metal selezionati. Ad esempio, le varietà GPU `mgXc` non supportano Trusted Compute. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.
        -  **Tipi di macchina**: per stabilire quale tipo di macchina distribuire, esamina le combinazioni di core, memoria e archiviazione dell'[hardware del nodo di lavoro disponibile](cs_clusters_planning.html#shared_dedicated_node). Una volta creato il tuo cluster, puoi aggiungere diversi tipi di macchina fisica o virtuale [aggiungendo un pool di nodi di lavoro](#add_pool).

           Assicurati di voler eseguire il provisioning di una macchina bare metal. Poiché viene fatturata mensilmente, se la annulli immediatamente dopo un ordine effettuato per errore, ti viene comunque addebitato l'intero mese.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **Cluster standard**: controlla se esiste già una VLAN pubblica e privata nell'infrastruttura IBM Cloud (SoftLayer) per questo account.

        ```
        ibmcloud ks vlans <zone>
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

        Se esiste già una VLAN pubblica e privata, annota i router corrispondenti. I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere. Nell'output di esempio, le VLAN private
possono essere utilizzate con una qualsiasi VLAN pubblica perché i router includono tutti
`02a.dal10`.

        Devi collegare i tuoi nodi di lavoro a una VLAN privata e puoi, facoltativamente, collegarli a una VLAN pubblica **Nota**: se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete. Per ulteriori informazioni, vedi [Pianificazione della rete cluster solo privata](cs_network_cluster.html#private_vlan).

    4.  **Cluster gratuiti e standard**: esegui il comando `cluster-create`. Puoi scegliere tra un cluster gratuito, che include un nodo di lavoro configurato con 2vCPU e 4 GB di memoria e che viene eliminato automaticamente dopo 30 giorni. Quando crei un cluster standard, per impostazione predefinita, i dischi del nodo di lavoro vengono codificati, il relativo hardware condiviso tra più clienti IBM e viene effettuato un addebito per ora di utilizzo. </br>Esempio per un cluster standard. Specifica le opzioni del cluster:

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        Esempio per un cluster gratuito. Specifica il nome del cluster:

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Componenti di cluster-create</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Il comando per creare un cluster nella tua organizzazione {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**Cluster standard**: sostituisci <em>&lt;zone&gt;</em> con l'ID zona {{site.data.keyword.Bluemix_notm}} in cui vuoi creare il tuo cluster. Le zone disponibili dipendono alla regione {{site.data.keyword.containerlong_notm}} a cui hai eseguito l'accesso.<p class="note">I nodi di lavoro del cluster vengono distribuiti in questa zona. Per estendere il tuo cluster tra le zone, devi crearlo in una [una zona che supporta il multizona](cs_regions.html#zones). Una volta creato il cluster, puoi [aggiungere una zona al cluster](#add_zone).</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Cluster standard**: scegli un tipo di macchina. Puoi distribuire i tuoi nodi di lavoro come macchine virtuali su hardware condiviso o dedicato o come macchine fisiche su bare metal. I tipi di macchine fisiche e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Per ulteriori informazioni, consulta la documentazione per il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-type`. Per i cluster gratuiti, non devi definire il tipo di macchina.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Cluster standard, solo virtuali**: il livello di isolamento hardware per il tuo nodo di lavoro. Utilizza dedicato per avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso. Questo valore è facoltativo per i cluster standard e non è disponibile per i cluster gratuiti.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Cluster gratuiti**: non è necessario definire una VLAN pubblica. Il tuo cluster gratuito viene automaticamente collegato alla VLAN pubblica di proprietà di IBM.</li>
          <li>**Cluster standard**: se hai già una VLAN pubblica configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella zona, immetti l'ID della VLAN pubblica. Se vuoi collegare i tuoi nodi di lavoro solo a una VLAN privata, non specificare questa opzione.
          <p>I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</p>
          <p class="note">Se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete. Per ulteriori informazioni, vedi [Pianificazione della rete cluster solo privata](cs_network_cluster.html#private_vlan).</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Cluster gratuiti**: non è necessario definire una VLAN privata. Il tuo cluster gratuito viene automaticamente collegato alla VLAN privata di proprietà di IBM.</li><li>**Cluster standard**: se hai già una VLAN privata configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella zona, immetti l'ID della VLAN privata. Se non hai una VLAN privata nel tuo account, non specificare questa opzione. {{site.data.keyword.containerlong_notm}} crea automaticamente una VLAN privata per te.<p>I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</p></li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Cluster gratuiti e standard**: sostituisci <em>&lt;name&gt;</em> con un nome per il tuo cluster. Il nome deve iniziare con una lettera, può contenere lettere, numeri e un trattino (-) e non può contenere più di 35 caratteri. Il nome cluster e la regione in cui viene distribuito il cluster formano il nome dominio completo per il dominio secondario Ingress. Per garantire che il dominio secondario Ingress sia univoco all'interno di una regione, è possibile che il nome cluster venga troncato e vi venga aggiunto un valore casuale all'interno del nome dominio Ingress.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Cluster standard**: il numero di nodi di lavoro da includere nel cluster. Se non viene specificata l'opzione <code>--workers</code>, viene creato 1 nodo di lavoro.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Cluster standard**: la versione di Kubernetes per il nodo master del cluster. Questo valore è facoltativo. Quando la versione non viene specificata, il cluster viene creato con l'impostazione predefinita delle versioni di Kubernetes supportate. Per visualizzare le versioni disponibili, esegui <code>ibmcloud ks kube-versions</code>.
</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Cluster gratuiti e standard**: i nodi di lavoro dispongono della codifica del disco per impostazione predefinita; [ulteriori informazioni](cs_secure.html#encrypted_disk). Se vuoi disabilitare la codifica, includi questa opzione.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Cluster bare metal standard**: abilita [Trusted Compute](cs_secure.html#trusted_compute) per verificare i tentativi di intrusione nei tuoi nodi di lavoro bare metal. Trusted Compute è disponibile per alcuni tipi di macchina bare metal selezionati. Ad esempio, le varietà GPU `mgXc` non supportano Trusted Compute. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.</td>
        </tr>
        </tbody></table>

5.  Verifica che la creazione del cluster sia stata richiesta. Per le macchine virtuali, possono essere necessari alcuni minuti per l'ordine delle macchine del nodo di lavoro e per la configurazione e il provisioning del cluster nel tuo account. Il provisioning delle macchine fisiche bare metal viene eseguito tramite l'interazione manuale con l'infrastruttura Cloud IBM (SoftLayer) e il completamento di questo processo può richiedere più di un giorno lavorativo.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Quando è stato terminato il provisioning del tuo cluster, lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.10.11      Default
    ```
    {: screen}

6.  Controlla lo stato dei nodi di lavoro.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**, puoi accedere al cluster.

    A ogni nodo di lavoro viene assegnato un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo cluster.
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.10.11      Default
    ```
    {: screen}

7.  Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.
    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  Avvia il tuo dashboard Kubernetes con la porta predefinita `8001`.
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

-   Se hai creato il cluster in una zona con supporto multizona, estendi i nodi di lavoro [aggiungendo una zona al tuo cluster](#add_zone).
-   [Distribuisci un'applicazione nel tuo cluster.](cs_app.html#app_cli)
-   [Gestisci il tuo cluster con la riga di comando `kubectl`. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)
- Se hai un firewall, potresti dover [aprire le porte richieste](cs_firewall.html#firewall) per utilizzare i comandi `ibmcloud`, `kubectl` o `calicotl`, per consentire il traffico in uscita dal tuo cluster o per consentire il traffico in entrata per i servizi di rete.
-  I cluster con Kubernetes versione 1.10 o successive: controlla chi può creare i pod nel tuo cluster con le [politiche di sicurezza del pod](cs_psp.html).

<br />



## Aggiunta di nodi di lavoro e di zone ai cluster
{: #add_workers}

Per incrementare la disponibilità delle tue applicazioni, puoi aggiungere i nodi di lavoro a una zona esistente o a più zone esistenti nel tuo cluster. Per un supporto nella protezione delle tue applicazioni dai malfunzionamenti della zona, puoi aggiungere le zone al tuo cluster.
{:shortdesc}

Quando crei un cluster, viene eseguito il provisioning dei nodi di lavoro in un pool di nodi di lavoro. Dopo aver creato il cluster, puoi aggiungere altri nodi di lavoro a un pool ridimensionandolo o aggiungendo altro pool di nodi di lavoro. Per impostazione predefinita, il pool di nodi di lavoro esiste in un'unica zona. I cluster che hanno un pool di nodi di lavoro in un'unica zona sono denominati cluster a zona singola. Quando aggiungi altre zone al cluster, il pool di nodi di lavoro esiste tra le zone. I cluster che hanno un pool di nodi di lavoro esteso tra più di una zona sono denominati cluster multizona.

Se hai un cluster multizona, mantieni bilanciate le sue risorse del nodo di lavoro. Assicurati che tutti i pool di nodi di lavoro vengano estesi tra le stesse zone e aggiungi o rimuovi i nodi di lavoro ridimensionando i pool invece di aggiungere singoli nodi.
{: tip}

Prima di iniziare, assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Operatore** o **Amministratore**](cs_users.html#platform). Quindi, scegli una delle seguenti sezioni:
  * [Aggiungere nodi di lavoro ridimensionando un pool di nodi di lavoro esistente nel tuo cluster](#resize_pool)
  * [Aggiungere nodi di lavoro aggiungendo un pool di nodi di lavoro al tuo cluster](#add_pool)
  * [Aggiungere una zona al tuo cluster e replicare i nodi di lavoro nei tuoi pool di nodi di lavoro tra più zone](#add_zone)
  * [Obsoleto: Aggiungere un nodo di lavoro autonomo a un cluster](#standalone)


### Aggiunta di nodi di lavoro ridimensionando un pool di nodi di lavoro esistente
{: #resize_pool}

Puoi aggiungere o ridurre il numero di nodi di lavoro nel tuo cluster ridimensionando un pool di nodi di lavoro esistente, indipendentemente dal fatto che il pool di nodi di lavoro si trovi in un'unica zona o sia esteso tra più zone.
{: shortdesc}

Ad esempio, prendi in considerazione un cluster con un pool di nodi di lavoro che ha tre nodi di lavoro per zona.
* Se il cluster è a zona singola ed esiste in `dal10`, il pool di nodi di lavoro ha tre nodi di lavoro in `dal10`. Il cluster ha un totale di tre nodi di lavoro.
* Se il cluster è multizona ed esiste in `dal10` e `dal12`, il pool di nodi di lavoro ha tre nodi di lavoro in `dal10` e tre nodo di lavoro in `dal12`. Il cluster ha un totale di sei nodi di lavoro.

Per i pool di nodi di lavoro bare metal, ricordati che la fatturazione è mensile. Il ridimensionamento aggiungendo o rimuovendo elementi influirà sui costi mensili.
{: tip}

Per ridimensionare il pool di nodi di lavoro, modifica il numero di nodi di lavoro che il pool di nodi di lavoro distribuisce in ciascuna zona:

1. Ottieni il nome del pool di nodi di lavoro che vuoi ridimensionare.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Ridimensiona il pool di nodi di lavoro indicando il numero di nodi di lavoro che vuoi distribuire in ciascuna zona. Il valore minimo è 1.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Verifica che il pool di nodi di lavoro sia stato ridimensionato.
    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Esempio di output per un pool di nodi di lavoro che si trova in due zone, `dal10` e `dal12`, e che è stato ridimensionato a due nodi di lavoro per zona:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Aggiunta di nodi di lavoro creando un nuovo pool di nodi di lavoro
{: #add_pool}

Puoi aggiungere nodi di lavoro al tuo cluster creando un nuovo pool di nodi di lavoro.
{:shortdesc}

1. Richiama le **Worker Zones** del tuo cluster e scegli la zona in cui vuoi distribuire i nodi di lavoro nel tuo pool di nodi di lavoro. Se hai un cluster a zona singola, devi utilizzare la zona visualizzata nel campo **Worker Zones**. Per i cluster multizona, puoi scegliere una qualsiasi delle **Worker Zones** esistenti del tuo cluster o aggiungere una delle [città metropolitane multizona](cs_regions.html#zones) per la regione in cui si trova il tuo cluster. Puoi elencare le zone disponibili eseguendo `ibmcloud ks zones`.
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Output di esempio:
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. Per ciascuna zona elenca le VLAN pubbliche e private disponibili. Prendi nota della VLAN privata e di quella pubblica che vuoi utilizzare. Se non hai una VLAN privata o una pubblica, la VLAN viene creata automaticamente per te quando aggiungi una zona al tuo pool di nodi di lavoro.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3.  Per ogni zona, esamina i [tipi di macchina disponibili per i nodi di lavoro](cs_clusters_planning.html#shared_dedicated_node).

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. Crea un pool di nodi di lavoro. Se esegui il provisioning di un pool di nodi di lavoro bare metal, specifica `--hardware dedicated`.
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. Verifica che il pool di nodi di lavoro sia stato creato.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. Per impostazione predefinita, l'aggiunta di un pool di nodi di lavoro crea un pool senza zone. Per distribuire i nodi di lavoro in una zona, devi aggiungere le zone precedentemente richiamate al pool di nodi di lavoro. Se vuoi estendere i tuoi nodi di lavoro su più zone, ripeti questo comando per ogni zona.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. Verifica che sia stato eseguito il provisioning dei nodi di lavoro nella zona che hai aggiunto. I tuoi nodi di lavoro sono pronti quando lo stato cambia da **provision_pending** a **normal**.
   ```
   ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Output di esempio:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Aggiunta di nodi di lavoro aggiungendo una zona a un pool di nodi di lavoro
{: #add_zone}

Puoi estendere il tuo cluster tra più zone all'interno di una regione aggiungendo una zona al tuo pool di nodi di lavoro esistente.
{:shortdesc}

Quando aggiungi una zona a un pool di nodi di lavoro, viene eseguito il provisioning dei nodi di lavoro definiti nel tuo pool di nodi di lavoro nella nuova zona e vengono considerati per una pianificazione futura del carico di lavoro. {{site.data.keyword.containerlong_notm}} aggiunge automaticamente l'etichetta `failure-domain.beta.kubernetes.io/region` per la regione e l'etichetta `failure-domain.beta.kubernetes.io/zone` per la zona a ciascun nodo di lavoro. Il programma di pianificazione (scheduler) Kubernetes usa queste tabelle per estendere i pod tra le zone all'interno della stessa regione.

Se hai più pool di nodi di lavoro nel tuo cluster, aggiungi la zona a tutti i pool in modo che i nodi di lavoro vengano estesi in modo uniforme nel tuo cluster.

Prima di iniziare:
*  Per aggiungere una zona al tuo pool di nodi di lavoro, il tuo pool di nodi di lavoro deve trovarsi in una [zona che supporta il multizona](cs_regions.html#zones). Se il tuo pool di nodi di lavoro non si trova in una zona che supporta il multizona, prendi in considerazione di [creare un nuovo pool di nodi di lavoro](#add_pool).
*  Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).

Per aggiungere una zona con nodi di lavoro al tuo pool di nodi di lavoro:

1. Elenca le zone disponibili e seleziona quella che vuoi aggiungere al tuo pool di nodi di lavoro. La zona che hai scelto deve essere una zona che supporta il multizona.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Elenca le VLAN disponibili in tale zona. Se non hai una VLAN privata o una pubblica, la VLAN viene creata automaticamente per te quando aggiungi una zona al tuo pool di nodi di lavoro.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Elenca i pool di nodi di lavoro nel tuo cluster e prendi nota dei loro nomi.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Aggiungi la zona al tuo pool di nodi di lavoro. Se hai più pool di nodi di lavoro, aggiungi la zona a tutti i tuoi pool di nodi di lavoro in modo che il tuo cluster sia bilanciato in tutte le zone. Sostituisci `<pool1_id_or_name,pool2_id_or_name,...>` con i nomi di tutti i tuoi pool di nodi di lavoro in un elenco separato da virgole.

    È necessario che esistano una VLAN pubblica e una privata prima che tu possa aggiungere una zona a più pool di nodi di lavoro. Se non hai una VLAN privata e una pubblica in tale zona, aggiungi innanzitutto la zona a un pool di nodi di lavoro in modo che la VLAN privata e quella pubblica vengano create per te. Quindi, puoi aggiungere la zona agli altri pool di nodi di lavoro specificando la VLAN privata e quella pubblica create per te.
    {: note}

   Se vuoi utilizzare VLAN diverse per pool di nodi di lavoro differenti, ripeti questo comando per ciascuna VLAN e i suoi pool di nodi di lavoro corrispondenti. I nuovi nodi di lavoro vengono aggiunti alle VLAN che hai specificato, ma le VLAN per i nodi di lavoro esistenti non vengono modificate.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. Verifica che la zona sia stata aggiunta al tuo cluster. Ricerca la zona aggiunta nel campo **Worker zones** dell'output. Tieni presente che il numero totale di nodi di lavoro nel campo **Workers** è aumentato in quanto è stato eseguito il provisioning dei nuovi nodi di lavoro nella zona aggiunta.
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Output di esempio:
    ```
    Name:                   mycluster
    ID:                     df253b6025d64944ab99ed63bb4567b6
    State:                  normal
    Created:                2018-09-28T15:43:15+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:30426
    Master Location:        Dallas
    Master Status:          Ready (21 hours ago)
    Ingress Subdomain:      ...
    Ingress Secret:         mycluster
    Workers:                6
    Worker Zones:           dal10, dal12
    Version:                1.11.3_1524
    Owner:                  owner@email.com
    Monitoring Dashboard:   ...
    Resource Group ID:      a8a12accd63b437bbd6d58fb6a462ca7
    Resource Group Name:    Default
    ```
    {: screen}  

### Obsoleto: Aggiunta di nodi di lavoro autonomi
{: #standalone}

Se hai un cluster che è stato creato prima dell'introduzione dei pool di nodi di lavoro, puoi usare i comandi obsoleti per aggiungere nodi di lavoro autonomi.
{: deprecated}

Se hai un cluster che è stato creato dopo l'introduzione dei pool di nodi di lavoro, non puoi aggiungere nodi di lavoro autonomi. Puoi invece [creare un pool di nodi di lavoro](#add_pool), [ridimensionare un pool di nodi di lavoro esistente](#resize_pool) o [aggiungere una zona a un pool di nodi di lavoro](#add_zone) per aggiungere i nodi di lavoro al tuo cluster.
{: note}

1. Elenca le zone disponibili e seleziona la zona a cui vuoi aggiungere i nodi di lavoro.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Elenca le VLAN disponibili in tale zona e prendi nota del loro ID.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Elenca i tipi di macchina disponibili in tale zona.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

4. Aggiungi i nodi di lavoro autonomi al cluster.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. Verifica che i nodi di lavoro siano stati creati.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}



## Visualizzazione degli stati del cluster
{: #states}

Esamina lo stato di un cluster Kubernetes per ottenere informazioni sulla disponibilità e capacità del cluster e sui potenziali problemi che potrebbero essersi verificati.
{:shortdesc}

Per visualizzare le informazioni su un cluster specifico, come zone, URL master, dominio secondario Ingress, versione, proprietario e dashboard di monitoraggio, usa il [comando](cs_cli_reference.html#cs_cluster_get) `ibmcloud ks cluster-get <cluster_name_or_ID>`. Includi l'indicatore `--showResources` per visualizzare più risorse del cluster come i componenti aggiuntivi per i pod di archiviazione o le VLAN di sottorete per IP pubblici e privati.

Puoi visualizzare lo stato del cluster corrente eseguendo il comando `ibmcloud ks clusters` e individuando il campo **Stato**. Per risolvere i problemi relativi al cluster e ai nodi di lavoro, vedi [Risoluzione dei problemi dei cluster](cs_troubleshoot.html#debug_clusters).

<table summary="Ogni riga della tabella deve essere letta da sinistra verso destra, con lo stato del cluster nella prima colonna e un descrizione nella seconda colonna.">
<caption>Stati cluster</caption>
   <thead>
   <th>Stato cluster</th>
   <th>Descrizione</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>L'eliminazione del cluster viene richiesta dall'utente prima che il master Kubernetes venga distribuito. Al termine dell'eliminazione del cluster, questo viene rimosso dal tuo dashboard. Se il tuo cluster rimane bloccato in questo stato per molto tempo, apri un [caso di supporto {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>Il master Kubernetes non può essere raggiunto o tutti i nodi di lavoro nel cluster sono inattivi. </td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>Non è possibile eliminare il master Kubernetes o almeno uno dei nodi di lavoro.  </td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>Il cluster viene eliminato ma non ancora rimosso dal tuo dashboard. Se il tuo cluster rimane bloccato in questo stato per molto tempo, apri un [caso di supporto {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>Il cluster viene eliminato e la relativa infrastruttura viene smantellata. Non puoi accedere al cluster.  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>Non è stato possibile completare la distribuzione del master Kubernetes. Non puoi risolvere questo stato. Contatta il supporto IBM Cloud aprendo un [caso di supporto {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Il master Kubernetes non è ancora stato completamente distribuito. Non puoi accedere al tuo cluster. Attendi fino alla completa distribuzione del cluster per verificarne l'integrità.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Tutti i nodi di lavoro in un cluster sono attivi e in esecuzione. Puoi accedere al cluster e distribuire le applicazioni al cluster. Questo stato è considerato come integro e non richiede un'azione da parte tua.<p class="note">Anche se i nodi di lavoro possono essere normali, le altre risorse dell'infrastruttura, come [rete](cs_troubleshoot_network.html) e [archiviazione](cs_troubleshoot_storage.html), potrebbero necessitare ancora di attenzione.</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Il master Kubernetes è stato distribuito. Sta venendo eseguito il provisioning dei nodi di lavoro e non sono ancora disponibili nel cluster. Puoi accedere al cluster, ma non puoi distribuire le applicazioni al cluster.  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>Viene inviata una richiesta per creare il cluster e ordinare l'infrastruttura per il master Kubernetes e i nodi di lavoro. Quando viene avviata la distribuzione del cluster, lo stato del cluster cambia in <code>Deploying</code>. Se il tuo cluster rimane bloccato nello stato <code>Requested</code> per molto tempo, apri un [caso di supporto {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>Il server API Kubernetes eseguito nel master Kubernetes viene aggiornato a una nuova versione dell'API Kubernetes. Durante l'aggiornamento, non è possibile accedere o modificare il cluster. I nodi di lavoro, le applicazioni e le risorse che sono state distribuite dall'utente non vengono modificate e continuano a essere eseguite. Attendi il completamento dell'aggiornamento per verificare l'integrità del tuo cluster. </td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>Almeno un nodo di lavoro nel cluster non è disponibile, ma altri lo sono e possono subentrare nel carico di lavoro. </td>
    </tr>
   </tbody>
 </table>


<br />


## Rimozione dei cluster
{: #remove}

I cluster gratuiti e standard creati con un account fatturabile devono essere rimossi manualmente quando non sono più necessari in modo che non consumino più le risorse.
{:shortdesc}

<p class="important">
Non viene creato alcun backup del tuo cluster o dei tuoi dati nella tua archiviazione persistente. L'eliminazione di un cluster o dell'archiviazione persistente è permanente e non può essere annullata.</br>
</br>Quando decidi di rimuovere un cluster, rimuovi anche le sottoreti di cui è stato eseguito automaticamente il provisioning quando hai creato il cluster e che hai creato utilizzando il comando `ibmcloud ks cluster-subnet-create`. Tuttavia, se hai aggiunto manualmente sottoreti esistenti al tuo cluster utilizzando il `comando ibmcloud ks cluster-subnet-add`, tali sottoreti non verranno rimosse dal tuo account dell'infrastruttura IBM Cloud (SoftLayer) e potrai riutilizzarle in altri cluster.</p>

Prima di iniziare:
* Prendi nota del tuo ID cluster. Potresti aver bisogno dell'ID cluster per analizzare e rimuovere le risorse correlate all'infrastruttura IBM Cloud (SoftLayer) che non vengono automaticamente eliminate con il tuo cluster.
* Se vuoi eliminare i dati nella tua archiviazione persistente, [comprendi le opzioni di eliminazione](cs_storage_remove.html#cleanup).
* Assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Amministratore**](cs_users.html#platform).

Per rimuovere un cluster:

-   Dalla console {{site.data.keyword.Bluemix_notm}}
    1.  Seleziona il tuo cluster e fai clic su **Elimina** dal menu **Ulteriori azioni...**.

-   Dalla CLI {{site.data.keyword.Bluemix_notm}}
    1.  Elenca i cluster disponibili.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Elimina il cluster.

        ```
        ibmcloud ks cluster-rm <cluster_name_or_ID>
        ```
        {: pre}

    3.  Segui le richieste e scegli se eliminare le risorse del cluster che includono contenitori, pod, servizi associati, archiviazione persistente e segreti.
      - **Archiviazione persistente**: l'archiviazione persistente fornisce l'alta disponibilità per i tuoi dati. Se hai creato un'attestazione del volume persistente utilizzando una [condivisione file esistente](cs_storage_file.html#existing_file), non potrai eliminare la condivisione file quando elimini il cluster. Devi eliminare manualmente in seguito la condivisione file dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).

          A causa del ciclo di fatturazione mensile, non è possibile eliminare un'attestazione del volume persistente durante l'ultimo giorno del mese. Se elimini l'attestazione del volume persistente l'ultimo giorno del mese, l'eliminazione rimane in sospeso fino all'inizio del mese successivo.
          {: note}

Passi successivi:
- Puoi riutilizzare il nome di un cluster rimosso una volta che non è più presente nell'elenco dei cluster disponibili quando viene eseguito il comando `ibmcloud ks clusters`.
- Se mantieni le sottoreti, puoi [riutilizzarle in un nuovo cluster](cs_subnets.html#custom) o eliminarle manualmente in un secondo momento dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).
- Se mantieni l'archiviazione persistente, puoi [eliminare la tua archiviazione](cs_storage_remove.html#cleanup) in un secondo momento attraverso il dashboard dell'infrastruttura IBM Cloud (SoftLayer) nella console {{site.data.keyword.Bluemix_notm}}.
