---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

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

Parti in quarta con {{site.data.keyword.Bluemix_notm}} distribuendo applicazioni ad alta disponibilità nei contenitori Docker eseguiti nei cluster Kubernetes. I contenitori sono un modo standard per assemblare applicazioni e tutte le sue dipendenze in modo da poter spostare facilmente le applicazioni tra gli ambienti. A differenza delle macchine virtuali, i contenitori non includono il sistema operativo. I contenitori includono solo il codice dell'applicazione, il runtime, gli strumenti di sistema, le librerie e le impostazioni. I contenitori sono più leggeri, portatili ed efficienti rispetto alle macchine virtuali.
{:shortdesc}


Fai clic su una opzione per iniziare:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Fai clic su un'icona per iniziare ad utilizzare velocemente \{{site.data.keyword.containershort_notm}}. Con {{site.data.keyword.Bluemix_dedicated_notm}}, fai clic su questa icona per visualizzare le tue opzioni." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Introduzione ai cluster Kubernetes in {{site.data.keyword.Bluemix_notm}}" title="Introduzione ai cluster Kubernetes in {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Installa le CLI." title="Installa le CLI." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} - ambiente cloud " title="{{site.data.keyword.Bluemix_notm}} - ambiente cloud" shape="rect" coords="326, -10, 448, 218" />
</map>


## Introduzione ai cluster
{: #clusters}

Vuoi distribuire un'applicazione nel contenitore? Aspetta! Crea prima un cluster Kubernetes. Kubernetes è uno strumento di orchestrazione per i contenitori. Con Kubernetes, gli sviluppatori possono distribuire in un attimo le applicazioni ad alta disponibilità sfruttando la potenza e la flessibilità dei cluster.
{:shortdesc}

E cos'è un cluster? Un cluster è un insieme di risorse, nodi di lavoro, reti e dispositivi di archiviazione che mantengono le applicazioni altamente disponibili. Dopo aver ottenuto il tuo cluster, puoi distribuire le tue applicazioni nei contenitori.

[Prima di cominciare, devi avere un account {{site.data.keyword.Bluemix_notm}} Pagamento a consumo o Sottoscrizione per creare un cluster gratuito.](https://console.bluemix.net/registration/)


Per creare un cluster gratuito:

1.  Dal [**catalogo** ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/catalog/?category=containers), nella categoria **Contenitori**, fai clic su **Cluster Kubernetes**.

2.  Immetti un **Nome cluster**. Il tipo di cluster predefinito è gratuito. La prossima volta, puoi creare un cluster standard e definire ulteriori personalizzazioni, come il numero di
nodi di lavoro all'interno del cluster.

3.  Fai clic su **Crea cluster**. Si aprono i dettagli del cluster, ma il nodo di lavoro nel cluster impiega alcuni minuti per eseguire
il provisioning. Puoi vedere lo stato del nodo di lavoro nella scheda **Nodi di lavoro**. Quando lo stato diventa `Pronto`, il nodo di lavoro è pronto per essere utilizzato.

Ottimo lavoro! Hai creato il tuo primo cluster!

*   Il cluster gratuito ha un nodo di lavoro con 2 CPU e 4 GB di memoria disponibile per le tue applicazioni. 
*   Il nodo di lavoro è monitorato e gestito centralmente da un master Kubernetes dedicato e altamente disponibile di proprietà di {{site.data.keyword.IBM_notm}} che controlla e monitora tutte le risorse Kubernetes presenti nel cluster. Puoi concentrarti sul tuo nodo di lavoro e sulle applicazioni distribuite nel nodo di lavoro senza preoccuparti di gestire anche questo master.
*   Le risorse richieste per eseguire il cluster, come le VLAN e gli indirizzi IP, sono gestite in un account dell'infrastruttura IBM Cloud (SoftLayer) di proprietà di {{site.data.keyword.IBM_notm}}. Quando crei un cluster standard, gestisci queste risorse nel tuo proprio account dell'infrastruttura IBM Cloud (SoftLayer). Puoi scoprire di più su queste risorse
quando crei un cluster standard.


**Operazioni successive**

Una volta che il cluster è operativo, puoi iniziare a eseguire alcune attività.

* [Installa le CLI per iniziare ad utilizzare il tuo cluster.](cs_cli_install.html#cs_cli_install)
* [Distribuisci un'applicazione nel tuo cluster.](cs_app.html#app_cli)
* [Crea un cluster standard con più nodi per una maggiore disponibilità.](cs_clusters.html#clusters_ui)
* [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)
