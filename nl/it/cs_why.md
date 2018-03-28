---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-30"

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

{{site.data.keyword.containershort}} offre potenti strumenti combinando le tecnologie Docker e Kubernetes, un'esperienza utente intuitiva e la sicurezza e l'isolamento integrati per automatizzare la distribuzione, il funzionamento, il ridimensionamento e il monitoraggio di applicazioni caricate nei contenitori in un cluster di host di calcolo.
{:shortdesc}

## Vantaggi dell'utilizzo del servizio 
{: #benefits}

I cluster vengono distribuiti su host di calcolo che forniscono funzionalità Kubernetes native e funzionalità specifiche di {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Vantaggi|Descrizione|
|-------|-----------|
|Cluster Kubernetes a singolo tenant con calcolo, rete e isolamento dell'infrastruttura di archiviazione|<ul><li>Crea la tua propria infrastruttura personalizzata che soddisfi i requisiti della tua organizzazione. </li><li>Esegui il provisioning di un master Kubernetes sicuro e dedicato, dei nodi di lavoro, delle reti virtuali e dell'archiviazione utilizzando le risorse fornite dall'infrastruttura IBM Cloud (SoftLayer).</li><li>Master Kubernetes completamente gestito e continuamente monitorato da {{site.data.keyword.IBM_notm}} per mantenere il tuo cluster disponibile.</li><li>Archivia i dati persistenti, i dati condivisi tra i pod Kubernetes e ripristinali quando necessario
con il servizio del volume protetto e integrato.</li><li>Vantaggi del supporto completo per le API Kubernetes native.</li></ul>|
|Conformità della sicurezza dell'immagine con il Controllo vulnerabilità|<ul><li>Configura il tuo registro delle immagini privato Docker in cui le immagini vengono archiviate e condivise da tutti gli utenti
nell'organizzazione.</li><li>Vantaggi dalla scansione automatica delle immagini nel tuo registro {{site.data.keyword.Bluemix_notm}} privato.</li><li>Rivedi la raccomandazioni specifiche del sistema operativo utilizzato nell'immagine per risolvere le vulnerabilità potenziali.</li></ul>|
|Monitoraggio continuo dell'integrità del cluster|<ul><li>Utilizza il dashboard del cluster per visualizzare e gestire rapidamente l'integrità del tuo cluster, dei nodi di lavoro e delle distribuzioni del contenitore.</li><li>Trova le metriche di consumo dettagliate utilizzando {{site.data.keyword.monitoringlong}} ed
espandi velocemente il tuo cluster per soddisfare i carichi di lavoro.</li><li>Esamina le informazioni di registrazione utilizzando {{site.data.keyword.loganalysislong}} per visualizzare le attività del cluster dettagliate.</li></ul>|
|Esposizione protetta delle applicazioni al pubblico |<ul><li>Scegli tra un indirizzo IP pubblico, una rotta fornita da {{site.data.keyword.IBM_notm}} o il tuo proprio dominio personale per accedere
ai servizi nel tuo cluster da internet.</li></ul>|
|Integrazione servizio {{site.data.keyword.Bluemix_notm}}|<ul><li>Aggiungi ulteriori funzionalità alla tua applicazione tramite l'integrazione dei servizi {{site.data.keyword.Bluemix_notm}}, come le API Watson, Blockchain, i servizi dati o Internet of Things. </li></ul>|



<br />


## Confronto tra i cluster standard e gratuito 
{: #cluster_types}

Puoi creare un cluster gratuito o un qualsiasi numero di cluster standard. Prova i cluster gratuiti per acquisire familiarità e testare alcune funzionalità di Kubernetes o crea i cluster standard per utilizzare le funzionalità complete di Kubernetes per distribuire le applicazioni.
{:shortdesc}

|Caratteristiche|Cluster gratuiti|Cluster standard|
|---------------|-------------|-----------------|
|[Rete in cluster](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso all'applicazione della rete pubblica tramite un servizio NodePort](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Gestione degli accessi utente](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso al servizio {{site.data.keyword.Bluemix_notm}} dal cluster e dalle applicazioni](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Spazio disco sul nodo di lavoro per l'archiviazione](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Archiviazione basata sul file NFS persistente con i volumi](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso all'applicazione della rete pubblica o privata tramite un servizio di bilanciamento del carico](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Accesso all'applicazione della rete pubblica tramite un servizio Ingress](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Indirizzi IP pubblici portatili](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Registrazione e monitoraggio](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|
|[Disponibile in {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Funzione disponibile" style="width:32px;" />|

<br />



## Responsabilità di gestione del cluster
{: #responsibilities}

Controlla le responsabilità che condividi con IBM per gestire i tuoi cluster.
{:shortdesc}

**IBM è responsabile per:**

- Distribuzione del master, dei nodi di lavoro e della gestione dei componenti nel cluster, come il controller Ingress, al momento della creazione del cluster
- Gestione degli aggiornamenti, dei monitoraggi e del ripristino del master Kubernetes del cluster
- Monitoraggio dell'integrità dei nodi di lavoro e la fornitura dell'automazione dell'aggiornamento e del ripristino di tali nodi di lavoro
- Esecuzione delle attività di automazione nel tuo account dell'infrastruttura, inclusi l'aggiunta e la rimozione dei nodi di lavoro e la creazione di una sottorete predefinita
- Gestione, aggiornamento e ripristino dei componenti operativi nel cluster, come il controller Ingress e il plugin di archiviazione
- Provisioning di volumi di archiviazione quando richiesto dalle attestazioni del volume persistente
- Fornitura delle impostazioni di sicurezza per tutti i nodi di lavoro

</br>
**Tu sei responsabile per:**

- [Distribuzione e gestione delle risorse Kubernetes, come i pod, i servizi e le distribuzioni, all'interno del cluster](cs_app.html#app_cli)
- [Utilizzo delle funzionalità del servizio e di Kubernetes per garantire l'elevata disponibilità alle applicazioni](cs_app.html#highly_available_apps)
- [Aggiunta o rimozione della capacità di utilizzare la CLI per aggiungere o rimuovere i nodi di lavoro](cs_cli_reference.html#cs_worker_add)
- [Creazione delle VLAN pubblica e privata nell'infrastruttura IBM Cloud (SoftLayer) per l'isolamento di rete del tuo cluster](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [Verifica che tutti i nodi di lavoro dispongano di connettività di rete all'URL del master Kubernetes](cs_firewall.html#firewall) <p>**Nota**: se un nodo di lavoro ha sia una VLAN pubblica che privata, viene configurata la connettività di rete. Se il nodo di lavoro ha soltanto una rete privata configurata, è necessario un Vyatta per fornire la connettività di rete.</p>
- [Aggiornamento di kube-apiserver master e dei nodi di lavoro quando sono disponibili gli aggiornamenti delle versioni principali o secondarie di Kubernetes](cs_cluster_update.html#master)
- [Ripristino dei nodi di lavoro con problemi eseguendo i comandi `kubectl`, come `cordon` o `drain` ed eseguendo i comandi `bx cs`, come `reboot`, `reload` o `delete`](cs_cli_reference.html#cs_worker_reboot)
- [Aggiunta o rimozione delle sottoreti nell'infrastruttura IBM Cloud (SoftLayer) secondo necessità](cs_subnets.html#subnets)
- [Backup e ripristino dei dati nell'archiviazione persistente nell'infrastruttura IBM Cloud (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## Abuso dei contenitori
{: #terms}

I clienti non possono usare impropriamente il {{site.data.keyword.containershort_notm}}.
{:shortdesc}

L'utilizzo improprio include:

*   Qualsiasi attività illegale
*   La distribuzione o l'esecuzione di malware
*   Il danneggiamento di {{site.data.keyword.containershort_notm}} o l'interferenza
con l'utilizzo di {{site.data.keyword.containershort_notm}}
*   Il danneggiamento o l'interferenza con l'utilizzo di qualsiasi altro servizio o sistema
*   L'accesso non autorizzato a qualsiasi servizio o sistema
*   La modifica non autorizzata a qualsiasi servizio o sistema
*   La violazione dei diritti altrui

Per i termini generali di utilizzo, consulta [Termini dei
servizi cloud](/docs/navigation/notices.html#terms).
