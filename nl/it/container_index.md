---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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

Parti in quarta con {{site.data.keyword.containerlong}} distribuendo applicazioni ad alta disponibilità nei contenitori Docker eseguiti nei cluster Kubernetes.
{:shortdesc}

I contenitori sono un modo standard per assemblare applicazioni e tutte le sue dipendenze in modo da poter spostare facilmente le applicazioni tra gli ambienti. A differenza delle macchine virtuali, i contenitori non includono il sistema operativo. I contenitori includono solo il codice dell'applicazione, il runtime, gli strumenti di sistema, le librerie e le impostazioni. I contenitori sono più leggeri, portatili ed efficienti rispetto alle macchine virtuali.


Fai clic su una opzione per iniziare:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Fai clic su un'icona per iniziare ad utilizzare velocemente \{{site.data.keyword.containershort_notm}}. Con {{site.data.keyword.Bluemix_dedicated_notm}}, fai clic su questa icona per visualizzare le tue opzioni." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Introduzione ai cluster Kubernetes in {{site.data.keyword.Bluemix_notm}}" title="Introduzione ai cluster Kubernetes in {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Installa le CLI." title="Installa le CLI." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} - ambiente cloud " title="{{site.data.keyword.Bluemix_notm}} - ambiente cloud" shape="rect" coords="326, -10, 448, 218" />
</map>


## Introduzione ai cluster
{: #clusters}

Vuoi distribuire un'applicazione in un contenitore? Aspetta! Crea prima un cluster Kubernetes. Kubernetes è uno strumento di orchestrazione per i contenitori. Con Kubernetes, gli sviluppatori possono distribuire in un attimo le applicazioni ad alta disponibilità sfruttando la potenza e la flessibilità dei cluster.
{:shortdesc}

E cos'è un cluster? Un cluster è un insieme di risorse, nodi di lavoro, reti e dispositivi di archiviazione che mantengono le applicazioni altamente disponibili. Dopo aver ottenuto il tuo cluster, puoi distribuire le tue applicazioni nei contenitori.

**Prima di iniziare**

Ottieni il tipo di [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) giusto per te:
* **Pagamento a consumo o Sottoscrizione**: puoi creare un cluster di prova gratuito. Puoi anche eseguire il provisioning delle risorse dell'infrastruttura IBM Cloud (SoftLayer) da creare e utilizzare nei cluster standard. 
* **Lite**: puoi creare un cluster gratuito o standard. [Aggiorna il tuo account](/docs/account/account_faq.html#changeacct) a Pagamento a consumo o Sottoscrizione. 
* **Prova (per scopi educativi)**: puoi creare un cluster gratuito che puoi utilizzare per 30 giorni per acquisire familiarità con il servizio. 

Per creare un cluster gratuito:

1.  Nel [{{site.data.keyword.Bluemix_notm}} **Catalogo** ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/catalog/?category=containers), seleziona **{{site.data.keyword.containershort_notm}}** e fai clic su **Crea**. Viene visualizzata una pagina di configurazione cluster. Per impostazione predefinita, è selezionato **Cluster gratuito**.

2. Fornisci al tuo cluster un nome univoco.

3.  Fai clic su **Crea cluster**. Viene creato un pool di lavoro che contiene un nodo di lavoro. Il provisioning del nodo di lavoro può richiedere alcuni minuti, ma puoi vedere l'avanzamento nella scheda **Nodi di lavoro**. Quando lo stato diventa `Pronto` puoi iniziare ad utilizzare il tuo cluster!

Ottimo lavoro! Hai creato il tuo primo cluster Kubernetes. Di seguito sono riportati alcuni dettagli sul tuo cluster gratuito:

*   **Tipo di macchina**: il cluster gratuito ha un nodo di lavoro virtuale raggruppato in un pool di lavoro, con 2 CPU, 4 GB di memoria e un singolo disco SAN da 100 GB disponibili per le tue applicazioni. Quando crei un cluster standard, puoi scegliere tra macchine fisiche (bare metal) o virtuali, oltre a varie dimensioni della macchina.
*   **Master gestito**: il nodo di lavoro è monitorato e gestito centralmente da un master Kubernetes dedicato e altamente disponibile di proprietà di {{site.data.keyword.IBM_notm}} che controlla e monitora tutte le risorse Kubernetes presenti nel cluster. Puoi concentrarti sul tuo nodo di lavoro e sulle applicazioni distribuite nel nodo di lavoro senza preoccuparti di gestire anche questo master.
*   **Risorse dell'infrastruttura**: le risorse necessarie per eseguire il cluster, come VLAN e indirizzi IP, sono gestite in un account dell'infrastruttura IBM Cloud (SoftLayer) di proprietà di {{site.data.keyword.IBM_notm}}. Quando crei un cluster standard, gestisci queste risorse nel tuo proprio account dell'infrastruttura IBM Cloud (SoftLayer). Puoi scoprire di più su queste risorse e sulle [autorizzazioni necessarie](cs_users.html#infra_access) quando crei un cluster standard.
*   **Altre opzioni**: i cluster gratuiti vengono distribuiti nella regione da te selezionata, ma non puoi scegliere la zona. Per avere il controllo sulla zona, sulla rete e sull'archiviazione persistente, crea un cluster standard. [Scopri di più sui vantaggi dei cluster gratuiti e standard](cs_why.html#cluster_types).


**Operazioni successive**</br>
Prova ad eseguire alcune operazioni con il tuo cluster gratuito prima che scada. 

* Esegui la [prima esercitazione di {{site.data.keyword.containershort_notm}}](cs_tutorials.html#cs_cluster_tutorial) per creare un cluster Kubernetes, installare la CLI, creare un registro privato, impostare il tuo ambiente cluster e aggiungere un servizio al tuo cluster.
* Prosegui poi con la [seconda esercitazione di {{site.data.keyword.containershort_notm}}](cs_tutorials_apps.html#cs_apps_tutorial) relativa alla distribuzione delle applicazioni nel cluster.
* [Crea un cluster standard](cs_clusters.html#clusters_ui) con più nodi per una maggiore disponibilità.


