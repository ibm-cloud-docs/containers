---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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



# Le tue responsabilità nell'utilizzo di {{site.data.keyword.containerlong_notm}}
Ulteriori informazioni sulle responsabilità di gestione del cluster e sui termini e le condizioni derivanti dall'utilizzo di {{site.data.keyword.containerlong}}.
{:shortdesc}

## Responsabilità di gestione del cluster
{: #responsibilities}

Controlla le responsabilità che condividi con IBM per gestire i tuoi cluster.
{:shortdesc}

**IBM è responsabile di quanto segue:**

- Distribuzione del master, dei nodi di lavoro e dei componenti di gestione all'interno del cluster, come il programma di bilanciamento del carico dell'applicazione Ingress, al momento della creazione del cluster
- Fornitura di aggiornamenti della sicurezza, monitoraggio, isolamento e ripristino del master Kubernetes per il cluster
- Messa a disposizione degli aggiornamenti di versione e delle patch di sicurezza per consentirti di applicarli ai nodi di lavoro del tuo cluster
- Monitoraggio dell'integrità dei nodi di lavoro e la fornitura dell'automazione dell'aggiornamento e del ripristino di tali nodi di lavoro
- Esecuzione delle attività di automazione nel tuo account dell'infrastruttura, inclusi l'aggiunta e la rimozione dei nodi di lavoro e la creazione di una sottorete predefinita
- Gestione, aggiornamento e ripristino dei componenti operativi all'interno del cluster, come il programma di bilanciamento del carico dell'applicazione Ingress e il plug-in di archiviazione
- Provisioning di volumi di archiviazione quando richiesto dalle attestazioni del volume persistente
- Fornitura delle impostazioni di sicurezza per tutti i nodi di lavoro

</br>

**Tu sei responsabile per:**

- [Configurazione della chiave API {{site.data.keyword.containerlong_notm}} con le autorizzazioni appropriate per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer) e ad altri servizi {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-users#api_key)
- [Distribuzione e gestione delle risorse Kubernetes, come i pod, i servizi e le distribuzioni, all'interno del cluster](/docs/containers?topic=containers-app#app_cli)
- [Utilizzo delle funzionalità del servizio e di Kubernetes per garantire l'elevata disponibilità alle applicazioni](/docs/containers?topic=containers-app#highly_available_apps)
- [Aggiunta o rimozione della capacità del cluster ridimensionando i tuoi pool di nodi di lavoro](/docs/containers?topic=containers-clusters#add_workers)
- [Abilitazione dello spanning delle VLAN e mantenimento del bilanciamento dei pool di nodi di lavoro multizona tra le zone](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [Creazione delle VLAN pubblica e privata nell'infrastruttura IBM Cloud (SoftLayer) per l'isolamento di rete del tuo cluster](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [Verifica che tutti i nodi di lavoro dispongano di connettività di rete agli URL di endpoint del servizio Kubernetes](/docs/containers?topic=containers-firewall#firewall) <p class="note">Se un nodo di lavoro ha sia una VLAN pubblica che privata, viene configurata la connettività di rete. Se i nodi di lavoro sono configurati solo con una VLAN privata, devi consentire le comunicazioni tra i nodi di lavoro e il master cluster [abilitando l'endpoint del servizio privato](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) o [configurando un dispositivo gateway](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway). Se imposti un firewall, devi gestirne e configurarne le impostazioni per consentire l'accesso per {{site.data.keyword.containerlong_notm}} e altri servizi {{site.data.keyword.Bluemix_notm}} che utilizzi con il cluster.</p>
- [Aggiornamento del kube-apiserver master quando sono disponibili aggiornamenti alla versione di Kubernetes](/docs/containers?topic=containers-update#master)
- [Mantenere i nodi di lavoro aggiornati alle versioni patch, principale e secondaria](/docs/containers?topic=containers-update#worker_node) <p class="note">Non puoi modificare il sistema operativo del tuo nodo di lavoro o eseguire l'accesso al nodo di lavoro. Gli aggiornamenti dei nodi di lavoro sono forniti da IBM come un'immagine del nodo di lavoro completa che include le patch di sicurezza più recenti. Per applicare gli aggiornamenti, è necessario ricercare l'immagine e ricaricare il nodo di lavoro con la nuova immagine. Le chiavi per l'utente root vengono ruotate automaticamente quando il nodo di lavoro viene ricaricato. </p>
- [Monitoraggio dell'integrità del tuo cluster configurando l'inoltro dei log per i componenti del tuo cluster](/docs/containers?topic=containers-health#health).   
- [Ripristino dei nodi di lavoro con problemi eseguendo i comandi `kubectl`, come `cordon` o `drain`, ed eseguendo i comandi `ibmcloud ks`, come `reboot`, `reload` o `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [Aggiunta o rimozione delle sottoreti nell'infrastruttura IBM Cloud (SoftLayer) secondo necessità](/docs/containers?topic=containers-subnets#subnets)
- [Backup e ripristino dei dati nell'archiviazione persistente nell'infrastruttura IBM Cloud (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- Configurazione dei servizi [logging](/docs/containers?topic=containers-health#logging) e [monitoring](/docs/containers?topic=containers-health#view_metrics) per supportare l'integrità e le prestazioni del tuo cluster
- [Configurazione del monitoraggio dell'integrità per i nodi di lavoro con Autorecovery](/docs/containers?topic=containers-health#autorecovery)
- Controllo degli eventi che modificano le risorse nel tuo cluster, come ad esempio utilizzando [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) per visualizzare le attività avviate dall'utente che modificano lo stato della tua istanza {{site.data.keyword.containerlong_notm}}

<br />


## Abuso di {{site.data.keyword.containerlong_notm}}
{: #terms}

I clienti non possono usare impropriamente il {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

L'utilizzo improprio include:

*   Qualsiasi attività illegale
*   La distribuzione o l'esecuzione di malware
*   Il danneggiamento di {{site.data.keyword.containerlong_notm}} o l'interferenza
con l'utilizzo di {{site.data.keyword.containerlong_notm}}
*   Il danneggiamento o l'interferenza con l'utilizzo di qualsiasi altro servizio o sistema
*   L'accesso non autorizzato a qualsiasi servizio o sistema
*   La modifica non autorizzata a qualsiasi servizio o sistema
*   La violazione dei diritti altrui

Per i termini generali di utilizzo, consulta [Termini dei
servizi cloud](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms).
