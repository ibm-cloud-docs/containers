---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Perché {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containerlong}} offre potenti strumenti combinando i contenitori Docker e la tecnologia Kubernetes, un'esperienza utente intuitiva e la sicurezza e l'isolamento integrati per automatizzare la distribuzione, il funzionamento, il ridimensionamento e il monitoraggio di applicazioni caricate nei contenitori in un cluster di host di calcolo.
{:shortdesc}


## Vantaggi dell'utilizzo del servizio
{: #benefits}

I cluster vengono distribuiti su host di calcolo che forniscono funzionalità Kubernetes native e funzionalità specifiche di {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Vantaggi|Descrizione|
|-------|-----------|
|Cluster Kubernetes a singolo tenant con calcolo, rete e isolamento dell'infrastruttura di archiviazione|<ul><li>Crea la tua propria infrastruttura personalizzata che soddisfi i requisiti della tua organizzazione.</li><li>Esegui il provisioning di un master Kubernetes sicuro e dedicato, dei nodi di lavoro, delle reti virtuali e dell'archiviazione utilizzando le risorse fornite dall'infrastruttura IBM Cloud (SoftLayer).</li><li>Master Kubernetes completamente gestito e continuamente monitorato da {{site.data.keyword.IBM_notm}} per mantenere il tuo cluster disponibile.</li><li>Opzione per il provisioning dei nodi di lavoro come server bare metal con Trusted Compute.</li><li>Archivia i dati persistenti, i dati condivisi tra i pod Kubernetes e ripristinali quando necessario
con il servizio del volume protetto e integrato.</li><li>Vantaggi del supporto completo per le API Kubernetes native.</li></ul>|
| Cluster multizona per aumentare l'alta disponibilità | <ul><li>Gestisci facilmente i nodi di lavoro dello stesso tipo di macchina (CPU, memoria, virtuale o fisica) con i pool di nodi di lavoro.</li><li>Proteggiti dai malfunzionamenti di zona distribuendo equamente i nodi tra le multizona selezionate e utilizzando le distribuzioni pod anti-affinità per le tue applicazioni.</li><li>Riduci i costi utilizzando i cluster multizona invece di duplicare le risorse in un cluster separato.</li><li>Avvaliti del bilanciamento del carico automatico tra le applicazioni con il programma di bilanciamento del carico multizona (o MZLB, multizone load balancer) che viene configurato automaticamente per tuo conto in ciascuna zona del cluster.</li></ul>|
|Conformità della sicurezza dell'immagine con il Controllo vulnerabilità|<ul><li>Configura il tuo repository nel nostro registro delle immagini privato Docker protetto in cui le immagini vengono archiviate e condivise da tutti gli utenti nell'organizzazione.</li><li>Vantaggi dalla scansione automatica delle immagini nel tuo registro {{site.data.keyword.Bluemix_notm}} privato.</li><li>Rivedi la raccomandazioni specifiche del sistema operativo utilizzato nell'immagine per risolvere le vulnerabilità potenziali.</li></ul>|
|Monitoraggio continuo dell'integrità del cluster|<ul><li>Utilizza il dashboard del cluster per visualizzare e gestire rapidamente l'integrità del tuo cluster, dei nodi di lavoro e delle distribuzioni del contenitore.</li><li>Trova le metriche di consumo dettagliate utilizzando {{site.data.keyword.monitoringlong}} ed
espandi velocemente il tuo cluster per soddisfare i carichi di lavoro.</li><li>Esamina le informazioni di registrazione utilizzando {{site.data.keyword.loganalysislong}} per visualizzare le attività del cluster dettagliate.</li></ul>|
|Esposizione protetta delle applicazioni al pubblico|<ul><li>Scegli tra un indirizzo IP pubblico, una rotta fornita da {{site.data.keyword.IBM_notm}} o il tuo proprio dominio personale per accedere
ai servizi nel tuo cluster da internet.</li></ul>|
|Integrazione servizio {{site.data.keyword.Bluemix_notm}}|<ul><li>Aggiungi ulteriori funzionalità alla tua applicazione tramite l'integrazione dei servizi {{site.data.keyword.Bluemix_notm}}, come le API Watson, Blockchain, i servizi dati o Internet of Things.</li></ul>|
{: caption="Vantaggi di {{site.data.keyword.containerlong_notm}}" caption-side="top"}

Sei pronto a iniziare? Prova l'[esercitazione relativa alla creazione di un cluster Kubernetes](cs_tutorials.html#cs_cluster_tutorial).

<br />


## Confronto delle offerte e le loro combinazioni
{: #differentiation}

Puoi eseguire {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} pubblico o dedicato, in {{site.data.keyword.Bluemix_notm}} privato o in una configurazione ibrida.
{:shortdesc}


<table>
<caption>Differenze tra le configurazioni {{site.data.keyword.containerlong_notm}}</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>Configurazione di {{site.data.keyword.containerlong_notm}}</th>
 <th>Descrizione</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} pubblico
 </td>
 <td>Con {{site.data.keyword.Bluemix_notm}} pubblico sull'[hardware condiviso o dedicato o sulle macchine bare metal](cs_clusters_planning.html#shared_dedicated_node), puoi ospitare le tue applicazioni nei cluster sul cloud utilizzando {{site.data.keyword.containerlong_notm}}. Puoi anche creare un cluster con dei pool di nodi di lavoro in più zone per aumentare l'elevata disponibilità per le tue applicazioni. {{site.data.keyword.containerlong_notm}} su {{site.data.keyword.Bluemix_notm}} pubblico offre potenti strumenti combinando i contenitori Docker e la tecnologia Kubernetes, un'esperienza utente intuitiva e la sicurezza e l'isolamento integrati per automatizzare la distribuzione, il funzionamento, il ridimensionamento e il monitoraggio di applicazioni caricate nei contenitori in un cluster di host di calcolo.<br><br>Per ulteriori informazioni, vedi [Tecnologia {{site.data.keyword.containerlong_notm}}](cs_tech.html).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} dedicato
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} dedicato offre le stesse capacità {{site.data.keyword.containerlong_notm}} sul cloud di {{site.data.keyword.Bluemix_notm}} pubblico. Tuttavia, con un account {{site.data.keyword.Bluemix_notm}} dedicato, le [risorse fisiche disponibili sono dedicate solo al tuo cluster](cs_clusters_planning.html#shared_dedicated_node) e non vengono condivise con i cluster provenienti dagli altri clienti {{site.data.keyword.IBM_notm}}. Potresti scegliere di impostare un ambiente {{site.data.keyword.Bluemix_notm}} dedicato quando richiedi l'isolamento per il tuo cluster e gli altri servizi {{site.data.keyword.Bluemix_notm}} che utilizzi.<br><br>Per ulteriori informazioni, vedi [Introduzione ai cluster in {{site.data.keyword.Bluemix_notm}} dedicato](cs_dedicated.html#dedicated).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} privato
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} privato è una piattaforma applicativa che può essere installata localmente sulle tue macchine. Puoi scegliere di utilizzare {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} privato quando hai bisogno di sviluppare applicazioni inserite nel contenitore in loco nel tuo ambiente controllato dietro un firewall. <br><br>Per ulteriori informazioni, consulta la [documentazione del prodotto {{site.data.keyword.Bluemix_notm}} privato ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
 </td>
 </tr>
 <tr>
 <td>Configurazione ibrida
 </td>
 <td>La configurazione ibrida consiste nell'uso combinato dei servizi che vengono eseguiti in {{site.data.keyword.Bluemix_notm}} pubblico o dedicato e altri servizi che vengono eseguiti in loco, come ad esempio un'applicazione in {{site.data.keyword.Bluemix_notm}} privato. Esempi per una configurazione ibrida: <ul><li>Eseguire il provisioning di un cluster con {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} pubblico ma connettendo tale cluster a un database in loco.</li><li>Esecuzione del provisioning di un cluster con {{site.data.keyword.containerlong_notm}} in {{site.data.keyword.Bluemix_notm}} privato e distribuzione di un'applicazione in tale cluster. Tuttavia, questa applicazione potrebbe utilizzare un servizio {{site.data.keyword.ibmwatson}}, ad esempio {{site.data.keyword.toneanalyzershort}}, in {{site.data.keyword.Bluemix_notm}} pubblico.</li></ul><br>Per abilitare le comunicazioni tra i servizi che sono in esecuzione in {{site.data.keyword.Bluemix_notm}} pubblico o dedicato e i servizi che sono in esecuzione in loco, devi [configurare una connessione VPN](cs_vpn.html). Per ulteriori informazioni, vedi [Utilizzo di {{site.data.keyword.containerlong_notm}} con {{site.data.keyword.Bluemix_notm}} privato](cs_hybrid.html).
 </td>
 </tr>
 </tbody>
</table>

<br />


## Confronto tra i cluster standard e gratuito
{: #cluster_types}

Puoi creare un cluster gratuito o un qualsiasi numero di cluster standard. Prova i cluster gratuiti per acquisire familiarità con alcune funzionalità di Kubernetes oppure crea i cluster standard per utilizzare le funzionalità complete di Kubernetes per distribuire le applicazioni. I cluster gratuiti vengono eliminati automaticamente dopo 30 giorni.
{:shortdesc}

Se hai un cluster gratuito e vuoi eseguire l'upgrade a un cluster standard, puoi [creare un cluster standard](cs_clusters.html#clusters_ui). Distribuisci quindi gli YAML per le risorse Kubernetes di cui hai eseguito la creazione con il tuo cluster gratuito nel cluster standard.

|Caratteristiche|Cluster gratuiti|Cluster standard|
|---------------|-------------|-----------------|
|[Rete in cluster](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso dell'applicazione della rete pubblica da un servizio NodePort a un indirizzo IP non stabile](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Gestione degli accessi utente](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso al servizio {{site.data.keyword.Bluemix_notm}} dal cluster e dalle applicazioni](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Spazio su disco sul nodo di lavoro per l'archiviazione non persistente](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
| [Capacità di creare il cluster in ogni regione {{site.data.keyword.containerlong_notm}}](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" /> |
|[Cluster multizona per aumentare l'alta disponibilità delle applicazioni](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Archiviazione basata sul file NFS persistente con i volumi](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso dell'applicazione della rete pubblica o privata da un servizio di bilanciamento del carico a un indirizzo IP stabile](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso dell'applicazione della rete pubblica da un servizio Ingress a un indirizzo IP stabile e URL personalizzabile](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Indirizzi IP pubblici portatili](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Registrazione e monitoraggio](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Opzione per il provisioning dei nodi di lavoro su server fisici (bare metal)](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Opzione per il provisioning dei nodi di lavoro bare metal con Trusted Compute](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Disponibile in {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
{: caption="Caratteristiche dei cluster standard e gratuito" caption-side="top"}

<br />




{: #responsibilities}
**Nota**: cerchi le tue responsabilità e i termini {{site.data.keyword.containerlong}} quando utilizzi il servizio?

{: #terms}
Vedi [Responsabilità di {{site.data.keyword.containerlong_notm}}](cs_responsibilities.html).
