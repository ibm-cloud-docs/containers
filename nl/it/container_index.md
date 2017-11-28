---

copyright:
  years: 2014, 2017
lastupdated: "2017-09-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Introduzione a {{site.data.keyword.containerlong_notm}}
{: #container_index}

Gestisci le applicazioni ad elevata disponibilità all'interno dei contenitori Docker e dei cluster Kubernetes sul cloud {{site.data.keyword.IBM}}. Un contenitore è un modo standard per impacchettare un'applicazione e tutte le sue dipendenze in modo che l'applicazione possa essere spostata tra gli ambienti ed eseguita senza modifiche. A differenza delle macchine virtuali, i contenitori non includono il sistema operativo. Solo il codice dell'applicazione, il runtime, gli strumenti di sistema, le librerie e le impostazioni sono inclusi nel contenitore, il che rende un contenitore più leggero, portatile ed efficiente di una macchina virtuale.
{:shortdesc}

Fai clic su una opzione per iniziare:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Con {{site.data.keyword.Bluemix_notm}} pubblico, puoi creare cluster Kubernetes o migrare gruppi di contenitori singoli e scalabili ai cluster. Con {{site.data.keyword.Bluemix_notm}} dedicato, fai clic su questa icona per vedere le tue opzioni." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Introduzione ai cluster Kubernetes in {{site.data.keyword.Bluemix_notm}}" title="Introduzione ai cluster Kubernetes in {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="Esecuzione di contenitori singoli e scalabili in {{site.data.keyword.containershort_notm}}" title="Esecuzione di contenitori singoli e scalabili in {{site.data.keyword.containershort_notm}}" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_notm}} dedicato ambiente cloud" title="{{site.data.keyword.Bluemix_notm}} ambiente cloud" shape="rect" coords="326, -10, 448, 218" />
</map>


## Introduzione ai cluster
{: #clusters}

Kubernetes è uno strumento di orchestrazione per la pianificazione dei contenitori dell'applicazione su un cluster
di macchine di calcolo. Con Kubernetes, gli sviluppatori possono sviluppare rapidamente le applicazioni ad
elevata disponibilità utilizzando la potenza e la flessibilità dei contenitori.
{:shortdesc}

Prima di poter distribuire un'applicazione con Kubernetes, inizia a creare un cluster. Un cluster è una serie di nodi di lavoro organizzati in una
rete. Lo scopo del cluster è di definire una serie di risorse, nodi, reti e dispositivi di archiviazione
che mantengono le applicazioni altamente disponibili.

Per creare un cluster lite:

1.  Dal [**catalogo** ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/catalog/?category=containers), nella categoria **Contenitori**, fai clic su **Cluster Kubernetes**.

2.  Immetti un **Nome cluster**. Il tipo di cluster predefinito è lite. La prossima volta, puoi creare un cluster standard e definire ulteriori personalizzazioni, come il numero di
nodi di lavoro all'interno del cluster.

3.  Fai clic su **Crea cluster**. Si aprono i dettagli del cluster, ma il nodo di lavoro nel cluster impiega alcuni minuti per eseguire
il provisioning. Puoi vedere lo stato del nodo di lavoro nella scheda **Nodi di lavoro**. Quando lo stato diventa `Pronto`, il nodo di lavoro è pronto per essere utilizzato.

Ottimo lavoro! Hai creato il tuo primo cluster!

*   Il cluster lite ha un nodo di lavoro con 2 CPU e 4 GB di memoria disponibile per le tue applicazioni.
*   Il nodo di lavoro è monitorato e gestito centralmente da un master Kubernetes dedicato e altamente disponibile di proprietà di {{site.data.keyword.IBM_notm}} che controlla e monitora tutte le risorse Kubernetes presenti nel cluster. Puoi concentrarti sul tuo nodo di lavoro e sulle applicazioni distribuite nel nodo di lavoro senza preoccuparti di gestire anche questo master.
*   Le risorse richieste per eseguire il cluster, come le VLAN e gli indirizzi IP, sono gestite in un account dell'infrastruttura IBM Bluemix (SoftLayer) di proprietà di {{site.data.keyword.IBM_notm}}. Quando
crei un cluster standard, gestisci queste risorse nel tuo proprio account dell'infrastruttura IBM Bluemix (SoftLayer). Puoi scoprire di più su queste risorse
quando crei un cluster standard.
*   **Suggerimento: i cluster lite ** creati con un account di prova gratuita {{site.data.keyword.Bluemix_notm}} vengono rimossi automaticamente al termine del periodo di prova, a meno che non [esegui l'aggiornamento a un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}](/docs/pricing/billable.html#upgradetopayg).


**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività.

* [Installa le CLI per iniziare ad utilizzare il tuo cluster.](cs_cli_install.html#cs_cli_install)
* [Distribuisci un'applicazione nel tuo cluster.](cs_apps.html#cs_apps_cli)
* [Crea un cluster standard con più nodi per una maggiore disponibilità.](cs_cluster.html#cs_cluster_ui)
* [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)


## Introduzione ai cluster in {{site.data.keyword.Bluemix_notm}} dedicato (Chiuso beta)
{: #dedicated}

Kubernetes è uno strumento di orchestrazione per la pianificazione dei contenitori dell'applicazione su un cluster
di macchine di calcolo. Con Kubernetes, gli sviluppatori possono sviluppare rapidamente le applicazioni ad
elevata disponibilità utilizzando la potenza e la flessibilità dei contenitori nella propria istanza di {{site.data.keyword.Bluemix_notm}} dedicato.
{:shortdesc}

Prima di iniziare, [configura il tuo ambiente {{site.data.keyword.Bluemix_notm}} dedicato per utilizzare i cluster](cs_ov.html#setup_dedicated). Puoi quindi
creare un cluster. Un cluster è una serie di nodi di lavoro organizzati in una
rete. Lo scopo del cluster è di definire una serie di risorse, nodi, reti e dispositivi di archiviazione
che mantengono le applicazioni altamente disponibili. Dopo aver creato un
cluster, puoi distribuire la tua applicazione nel cluster.

**Suggerimento:** se la tua organizzazione non ha ancora un ambiente {{site.data.keyword.Bluemix_notm}} dedicato, potresti
non averne bisogno. [Prova prima un cluster dedicato standard
nell'ambiente {{site.data.keyword.Bluemix_notm}}
pubblico.](cs_cluster.html#cs_cluster_ui)

Per distribuire un cluster in {{site.data.keyword.Bluemix_notm}} dedicato:

1.  Accedi alla console {{site.data.keyword.Bluemix_notm}} pubblico ([https://console.bluemix.net ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/catalog/?category=containers)) con il tuo ID IBM. Sebbene sia necessario richiedere un cluster da {{site.data.keyword.Bluemix_notm}} pubblico, lo stai distribuendo nel tuo account {{site.data.keyword.Bluemix_notm}} dedicato.
2.  Se disponi di più account, dal menu dell'account, seleziona un account {{site.data.keyword.Bluemix_notm}}.
3.  Dal catalogo, nella categoria **Contenitori**, fai clic **Cluster Kubernetes**.
4.  Immetti i dettagli del cluster.
    1.  Immetti un **Nome cluster**.
    2.  Seleziona una **Versione Kubernetes** da utilizzare nei nodi di lavoro. 
    3.  Seleziona un **Tipo di macchina**. Il tipo di macchina definisce la quantità di CPU virtuale e di memoria configurate in ogni nodo di lavoro
disponibile per tutti i contenitori che distribuisci nei tuoi nodi.
    4.  Scegli il **Numero di nodi di lavoro** di cui hai bisogno. Seleziona 3 per l'elevata di disponibilità del tuo cluster.

    I campi relativi a tipo di cluster, ubicazione, VLAN pubblica, VLAN privata e hardware vengono definiti
durante il processo di creazione dell'account di {{site.data.keyword.Bluemix_notm}} dedicato, pertanto non puoi modificare
questi valori.
5.  Fai clic su **Crea cluster**. Si aprono i dettagli del cluster, ma i nodi di lavoro nel cluster impiegano alcuni minuti per eseguire
il provisioning. Puoi vedere lo stato dei nodi di lavoro nella scheda **Nodi di
lavoro**. Quando lo stato diventa `Pronto`, i nodi di lavoro sono pronti per essere utilizzati.

    I nodi di lavoro sono monitorati e gestiti centralmente da un master Kubernetes dedicato e altamente disponibile di proprietà di {{site.data.keyword.IBM_notm}} che controlla e monitora tutte le risorse Kubernetes presenti nel cluster. Puoi concentrarti sui nodi di lavoro e sulle
applicazioni distribuite nei nodi di lavoro senza preoccuparti di gestire anche questo
master.

Ottimo lavoro! Hai creato il tuo primo cluster!


**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività.

* [Installa le CLI per iniziare ad utilizzare il tuo cluster.](cs_cli_install.html#cs_cli_install)
* [Distribuisci un'applicazione al tuo cluster.](cs_apps.html#cs_apps_cli)
* [Aggiungi i servizi {{site.data.keyword.Bluemix_notm}} al tuo cluster.](cs_cluster.html#binding_dedicated)
* [Trova le informazioni sulle differenze tra i cluster in {{site.data.keyword.Bluemix_notm}} dedicato e pubblico.](cs_ov.html#env_differences)
