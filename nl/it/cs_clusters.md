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


# Configurazione dei cluster
{: #clusters}

Progetta la configurazione del tuo cluster Kubernetes per la massima capacità cluster e disponibilità dei contenitori con {{site.data.keyword.containerlong}}. Sei ancora nella fase iniziale? Prova l'[esercitazione relativa alla creazione di un cluster Kubernetes](cs_tutorials.html#cs_cluster_tutorial).
{:shortdesc}

## Creazione di cluster multizona in {{site.data.keyword.containershort_notm}}
{: #multizone}

Con {{site.data.keyword.containerlong}}, puoi creare cluster multizona. I tuoi utenti hanno meno probabilità di riscontrare tempi di inattività quando distribuisci le tue applicazioni tra più nodi di lavoro e zone utilizzando un pool di lavoro. Le funzionalità integrate, come il bilanciamento del carico e l'isolamento, aumentano la resilienza nei confronti di potenziali malfunzionamenti di zona con host, reti o applicazioni. Se le risorse in una zona si disabilitano, i tuoi carichi di lavoro del cluster saranno ancora operativi nelle altre zone.
{: shortdesc}

### Perché si parla tanto di zone e pool? Cosa è cambiato?
{: #mz_changed}

Le **zone**, precedentemente denominate ubicazioni, sono data center in cui puoi creare le risorse IBM Cloud.

Ora nei cluster è presente una funzione denominata **pool di lavoro**, ossia una raccolta di nodi di lavoro con la stessa caratteristica, ad esempio tipo di macchina, CPU e memoria. Usa i nuovi comandi `ibmcloud ks worker-pool` per apportare modifiche al tuo cluster, ad esempio aggiungendo zone, nodi di lavoro oppure aggiornando questi ultimi.

La configurazione cluster precedente dei nodi di lavoro autonomi è supportata ma obsoleta. Assicurati di [aggiungere un pool di lavoro al tuo cluster](cs_clusters.html#add_pool) e quindi di [eseguire la migrazione per utilizzare i pool di lavoro](cs_cluster_update.html#standalone_to_workerpool) per organizzare i tuoi nodi di lavoro invece di nodi di lavoro autonomi.

### Cosa devo sapere prima di iniziare?
{: #general_reqs}

Prima di procedere troppo, deve occuparti di alcuni elementi di gestione per assicurarti che i tuoi cluster multizona siano pronti per i carichi di lavoro.

<dl>
<dt>VLAN richieste</dt>
  <dd><p>Quando aggiungi una zona a un pool di lavoro, devi definire una VLAN privata e una pubblica a cui si connetteranno i tuoi nodi di lavoro.</p><ul><li>Per controllare se hai VLAN esistenti utilizzabili in tale zona, esegui `ibmcloud ks vlans <zone>`. Prendi nota degli ID VLAN e usali quando aggiungi una zona a un pool di lavoro. </li>
  <li>Se non hai VLAN in tale zona, verranno create automaticamente per te una VLAN privata e una pubblica. Non devi specificare una VLAN privata e una pubblica. </li></ul>
  </dd>
<dt>Abilita lo spanning delle VLAN o VRF</dt>
  <dd><p>I tuoi nodi di lavoro devono comunicare tra loro sulla rete privata tra le zone. Hai due opzioni:</p>
  <ol><li>[Abilita lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). Per abilitare lo spanning delle VLAN, ti serve l'[autorizzazione dell'infrastruttura](/docs/iam/infrastructureaccess.html#infrapermission) <strong>Rete > Gestisci lo spanning delle VLAN di rete</strong> oppure puoi richiedere al proprietario dell'account di abilitarlo.</li>
  <li>Oppure, usa un account dell'infrastruttura IBM Cloud (SoftLayer) abilitato per VRF (Virtual Router Function). Per ottenere un account VRF, contatta il supporto dell'infrastruttura IBM Cloud (SoftLayer).</li></ol></dd>
<dt>Prepara volumi persistenti esistenti</dt>
  <dd><p>I volumi persistenti possono essere utilizzati solo nella zona in cui si trova il dispositivo di archiviazione effettivo. Per impedire errori imprevisti dell'applicazione in un cluster multizona, devi applicare le etichette di regione e zona ai volumi persistenti esistenti. Queste etichette consentono al programma di pianificazione (scheduler) kube di determinare dove pianificare un'applicazione che utilizza il volume persistente. Esegui il comando riportato di seguito e sostituisci <code>&lt;mycluster&gt;</code> con il nome del tuo cluster:</p>
  <pre class="pre"><code>bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster></code></pre></dd>
<dt>Per le istanze {{site.data.keyword.Bluemix_dedicated_notm}} sono disponibili solo cluster a zona singola.</dt>
    <dd>Con un {{site.data.keyword.Bluemix_dedicated_notm}}, puoi creare solo [cluster a zona singola](cs_clusters.html#single_zone). La zona disponibile è stata predefinita al momento della configurazione dell'ambiente {{site.data.keyword.Bluemix_dedicated_notm}}. Per impostazione predefinita, un cluster a zona singola è impostato con un pool di lavoro denominato `default`. Il pool di lavoro raggruppa i nodi di lavoro con la stessa configurazione, ad esempio il tipo di macchina, che hai definito durante la creazione del cluster. Puoi aggiungere altri nodi di lavoro al tuo cluster [ridimensionando un pool di lavoro esistente](cs_clusters.html#resize_pool) o [aggiungendo un nuovo pool di lavoro](cs_clusters.html#add_pool). Quando aggiungi un pool di lavoro, devi aggiungere la zona disponibile al pool di lavoro in modo tale che i nodi di lavoro possano essere distribuiti nella stessa zona. Tuttavia, non puoi aggiungere altre zone ai tuoi pool di lavoro.</dd>
</dl>

### Sono pronto per creare un cluster multizona. Come posso iniziare?
{: #mz_gs}

Inizia oggi nella [console {{site.data.keyword.containershort_notm}}](https://console.bluemix.net/containers-kubernetes/clusters) facendo clic su **Crea cluster**.

Puoi creare un cluster in una delle [città multizona](cs_regions.html#zones):
* Dallas nella regione Stati Uniti Sud: dal10, dal12, dal13
* Washington DC nella regione Stati Uniti Est: wdc04, wdc06, wdc07
* Francoforte nella regione Europa Centrale: fra02, fra04, fra05
* Londra nella regione Regno Unito Sud: lon02, lon04, lon06

**Aggiungi le zone a un cluster esistente**:

Se hai un cluster in una città multizona, puoi aggiungere un pool di lavoro al cluster e poi aggiungere una zona a tale pool utilizzando la GUI o la CLI. Per un elenco completo dei passi, vedi [Aggiornamento dai nodi di lavoro autonomi ai pool di lavoro](cs_cluster_update.html#standalone_to_workerpool).

### Andando avanti, quali sono le differenze rispetto alla mia attuale gestione dei cluster?
{: #mz_new_ways}

Con l'introduzione dei pool di lavoro, puoi utilizzare una nuova serie di API e di comandi per gestire il tuo cluster. Puoi vedere questi nuovi comandi nella [pagina della documentazione della CLI](cs_cli_reference.html#cs_cli_reference) oppure sul tuo terminale eseguendo `ibmcloud ks help`.

La tabella riportata di seguito confronta i vecchi metodi con i nuovi per alcune azioni di gestione cluster comuni.
<table summary="La tabella mostra la descrizione del nuovo modo per eseguire i comandi multizona. Le righe devono essere lette da sinistra a destra, con la descrizione nella colonna uno, il vecchio modo nella colonna due e il nuovo modo multizona nella colonna tre.">
<caption>Nuovi metodi per i comando del pool di lavoro multizona.</caption>
  <thead>
  <th>Descrizione</th>
  <th>Vecchi nodi di lavoro autonomi</th>
  <th>Nuovi pool di lavoro multizona</th>
  </thead>
  <tbody>
    <tr>
    <td>Aggiungi i nodi di lavoro al cluster.</td>
    <td><strong>Obsoleto</strong>: <code>ibmcloud ks worker-add</code> per aggiungere i nodi di lavoro autonomi.</td>
    <td><ul><li>Per aggiungere tipi di macchina diversi rispetto al tuo pool esistente, crea un nuovo pool di lavoro: [comando](cs_cli_reference.html#cs_worker_pool_create) <code>ibmcloud ks worker-pool-create</code>.</li>
    <li>Per aggiungere nodi di lavoro ad un pool esistente, ridimensiona il numero di nodi per zona nel pool: [comando](cs_cli_reference.html#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Rimuovi i nodi di lavoro dal cluster.</td>
    <td><code>ibmcloud ks worker-rm</code>, che puoi ancora utilizzare per eliminare un nodo di lavoro problematico dal tuo cluster.</td>
    <td><ul><li>Se il tuo pool di lavoro non è bilanciato, ad esempio dopo la rimozione di un nodo di lavoro, ribilancialo: [comando](cs_cli_reference.html#cs_rebalance) <code>ibmcloud ks worker-pool-rebalance</code> .</li>
    <li>Per ridurre il numero di nodi di lavoro in un pool, ridimensiona il numero per zona (valore minimo pari a 1): [comando](cs_cli_reference.html#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Usa una nuova VLAN per i nodi di lavoro.</td>
    <td><strong>Obsoleto</strong>: aggiungi un nuovo nodo di lavoro che utilizza la nuova VLAN privata o pubblica: <code>ibmcloud ks worker-add</code>.</td>
    <td>Imposta il pool di lavoro per utilizzare una VLAN pubblica o privata diversa rispetto a quella utilizzata in precedenza: [comando](cs_cli_reference.html#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code>.</td>
    </tr>
  </tbody>
  </table>

### Come posso ottenere ulteriori informazioni sui cluster multizona?
{: #learn_more}

L'intera documentazione è stata aggiornata per il multizona. In particolare, potresti essere interessato ai seguenti argomenti che sono stati notevolmente modificati con l'introduzione dei cluster multizona:
* [Configurazione di cluster altamente disponibili](#ha_clusters)
* [Pianificazione delle distribuzioni applicazione altamente disponibili](cs_app.html#highly_available_apps)
* [Esposizione delle applicazioni con LoadBalancers per i cluster multizona](cs_loadbalancer.html#multi_zone_config)
* [Esposizione delle applicazioni con Ingress](cs_ingress.html#ingress)
* Per l'archiviazione persistente altamente disponibile, usa un servizio cloud come [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) o [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).

## Configurazione di cluster altamente disponibili
{: #ha_clusters}
Progetta il tuo cluster standard per la massima capacità e disponibilità per la tua applicazione con {{site.data.keyword.containerlong}}.

I tuoi utenti hanno meno probabilità di riscontrare tempi di inattività quando distribuisci le tue applicazioni tra più nodi di lavoro, zone e cluster. Le funzionalità integrate, come il bilanciamento del carico e l'isolamento, aumentano la resilienza nei confronti di
potenziali errori con host, reti o applicazioni.

Rivedi la configurazione di questi cluster potenziali ordinati per gradi di disponibilità.

![Alta disponibilità per i cluster](images/cs_cluster_ha_roadmap_multizone.png)

1. Un [cluster a zona singola](#single_zone) con più nodi di lavoro in un pool di lavoro.
2. Un [cluster multizona](#multi_zone) che estende i nodi di lavoro tra le zone all'interno di una regione.
3. [Più cluster](#multiple_clusters) impostati tra le zone o le regioni e che sono connessi tramite un programma di bilanciamento del carico globale.

### Cluster a zona singola
{: #single_zone}

Per migliorare la disponibilità per la tua applicazione e per consentire il failover nel caso in cui un nodo di lavoro non sia disponibile nel tuo cluster, aggiungi altri nodi di lavoro al tuo cluster a zona singola.
{: shortdesc}

<img src="images/cs_cluster_singlezone.png" alt="Alta disponibilità per i cluster in una zona singola" width="230" style="width:230px; border-style: none"/>

Per impostazione predefinita, il tuo cluster a zona singola è impostato con un pool di lavoro denominato `default`. Il pool di lavoro raggruppa i nodi di lavoro con la stessa configurazione, ad esempio il tipo di macchina, che hai definito durante la creazione del cluster. Puoi aggiungere altri nodi di lavoro al tuo cluster [ridimensionando un pool di lavoro esistente](#resize_pool) o [aggiungendo un nuovo pool di lavoro](#add_pool).

Quando aggiungi più nodi di lavoro, le istanze dell'applicazione possono essere distribuite tra più nodi di lavoro. Se un nodo di lavoro si disattiva, le istanze dell'applicazione sui nodi di lavoro disponibili continueranno a funzionare. Kubernetes ripianifica automaticamente i pod dai nodi di lavoro non disponibili per garantire le prestazioni e la capacità della tua applicazione. Per assicurarti che i tuoi pod vengano distribuiti uniformemente tra i nodi di lavoro, implementa l'[affinità pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature).

**Posso convertire il mio cluster a zona singola in un cluster multizona?**
In alcuni casi. Se il tuo cluster a zona singola si trova in una [città metropolitana multizona](cs_regions.html#zones), puoi convertire il cluster a zona singola in uno multizona. Per convertire un cluster multizona, [aggiungi una zona](#add_zone) al pool di lavoro del tuo cluster. Se hai più pool di lavoro, aggiungi la zona a tutti i pool in modo che i nodi di lavoro rimangano bilanciati nel cluster.

**Devo utilizzare i cluster multizona?**
No. Puoi creare tutti i cluster a zona singola che desideri. In effetti, potresti preferire i cluster a zona singola per la gestione semplificata oppure se il tuo cluster deve risiedere in una specifica [città a zona singola](cs_regions.html#zones).

### Cluster multizona
{: #multi_zone}

Per proteggere il tuo cluster da un malfunzionamento della zona singola, puoi estenderlo tra le zone all'interno di una regione.
{: shortdesc}

<img src="images/cs_cluster_multizone.png" alt="Alta disponibilità per i cluster multizona" width="500" style="width:500px; border-style: none"/>

Puoi aggiungere ulteriori zone al tuo cluster per replicare i nodi di lavoro nei tuoi pool di lavoro tra più zone all'interno di una regione. I cluster multizona sono progettati per pianificare uniformemente i pod tra i nodi di lavoro e le zone per garantire la disponibilità e il ripristino in caso di malfunzionamento. Se i nodi di lavoro non vengono estesi uniformemente tra le zone o se la capacità di una delle zone non è sufficiente, il programma di pianificazione (scheduler) Kubernetes potrebbe non riuscire a pianificare tutti i pod richiesti. Di conseguenza, lo stato dei pod potrebbe essere **In sospeso** fino a quando non sarà disponibile capacità sufficiente. Se vuoi modificare il comportamento predefinito in modo che il programma di pianificazione (scheduler) Kubernetes distribuisca i pod tra le zone con una distribuzione migliore, usa la [politica di affinità pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature) `preferredDuringSchedulingIgnoredDuringExecution`.

**Perché ho bisogno dei nodi di lavoro in 3 zone?** </br>
La distribuzione del tuo carico di lavoro tra 3 zone garantisce l'alta disponibilità per la tua applicazione nel caso in cui una o due zone non siano disponibili, ma rende anche la configurazione del tuo cluster più efficiente. Ti chiedi per quale motivo? Di seguito troverai un esempio.

Supponiamo che hai bisogno di un nodo di lavoro con 6 core per gestire il carico di lavoro per la tua applicazione. Per rendere il tuo cluster ancora più disponibile, hai le seguenti opzioni:

- **Duplica le tue risorse in un'altra zona:** questa opzione ti lascia con 2 nodi di lavoro, ciascuno con 6 core in ogni zona per un totale di 12 core. </br>
- **Distribuisci le risorse tra 3 zone:** con questa opzione, distribuisci 3 core per zona, lasciandoti con una capacità totale di 9 core. Per gestire il tuo carico di lavoro, è necessario che siano attive due zone alla volta. Se una zona non è disponibile, le altre due zone possono gestire il tuo carico di lavoro. Se due zone non sono disponibili, i 3 core rimanenti sono attivi per gestire il tuo carico di lavoro. La distribuzione di 3 core per zona significa macchine più piccole e quindi una riduzione dei costi per te.</br>

**Come posso aumentare la disponibilità per il mio master Kubernetes?** </br>
Un cluster multizona è impostato con un singolo master Kubernetes di cui viene eseguito il provisioning nella stessa area metropolitana dei nodi di lavoro. Ad esempio, se i nodi di lavoro si trovano in una o più delle zone `dal10`, `dal12` o `dal13`, il master si trova nella città metropolitana multizona di Dallas.

**Cosa accade se il master Kubernetes diventa non disponibile?** </br>
Non puoi accedere o modificare il tuo cluster mentre il master Kubernetes non è disponibile. Tuttavia, i nodi di lavoro, le applicazioni e le risorse che hai distribuito non vengono modificate e continuano a essere eseguite. Per proteggere il tuo cluster da un malfunzionamento del master Kubernetes o quando si trova in regioni in cui non sono disponibili cluster multizona, puoi [impostare più cluster e collegarli ad un programma di bilanciamento del carico globale](#multiple_clusters).

**Come posso consentire ai miei utenti l'accesso alla mia applicazione da un Internet pubblico?**</br>
Puoi esporre le tue applicazioni utilizzando un ALB Ingress o il servizio del programma di bilanciamento del carico. Per impostazione predefinita, gli ALB pubblici vengono creati e abilitati automaticamente in ciascuna zona nel tuo cluster. Viene creato e abilitato automaticamente anche un programma di bilanciamento del carico multizona (MZLB) per il tuo cluster. L'integrità di MZLB controlla gli ALB in ciascuna zona del tuo cluster e tiene aggiornati i risultati della ricerca DNS in base a questi controlli di integrità. Per ulteriori informazioni, vedi i [servizi Ingress](cs_ingress.html#planning) ad alta disponibilità.

I servizi del programma di bilanciamento dei carico vengono impostati solo in una zona. Le richieste in entrata alla tua applicazione vengono instradate da tale zona a tutte le istanze dell'applicazione in altre zone. Se questa zona diventa non disponibile, la tua applicazione potrebbe non essere raggiungibile da internet. Puoi impostare ulteriori servizi del programma di bilanciamento del carico nelle altre zone per tenere conto del malfunzionamento di una singola zona. Per ulteriori informazioni, vedi i [servizi del programma di bilanciamento del carico](cs_loadbalancer.html#multi_zone_config) ad alta disponibilità.

**Ho creato il mio cluster multizona. Perché è presente ancora una sola zona? Come posso aggiungere zone al mio cluster?**</br>
Se [crei il tuo cluster multizona con la CLI](#clusters_cli), il cluster viene creato, ma devi aggiungere le zone al pool di lavoro per completare il processo. Per estendersi su più zone, il tuo cluster deve trovarsi in una [città metropolitana multizona](cs_regions.html#zones). Per aggiungere una zona al tuo cluster ed estendere i nodi di lavoro tra le zone, vedi [Aggiunta di una zona al tuo cluster](#add_zone).

### Più cluster connessi a un programma di bilanciamento del carico globale
{: #multiple_clusters}

Per proteggere la tua applicazione da un malfunzionamento del master Kubernetes e per le regioni in cui non sono disponibili cluster multizona, puoi creare più cluster in zone diverse all'interno di una regione e collegarli con un programma di bilanciamento del carico globale.
{: shortdesc}

<img src="images/cs_multiple_cluster_zones.png" alt="Alta disponibilità per più cluster" width="700" style="width:700px; border-style: none"/>

Per bilanciare il carico di lavoro tra più cluster, devi impostare un programma di bilanciamento del carico globale e aggiungere gli indirizzi IP dei tuoi ALB o dei tuoi servizi di bilanciamento del carico al tuo dominio. Aggiungendo questi indirizzi IP, puoi instradare il traffico in entrata tra i tuoi cluster. Affinché il programma di bilanciamento del carico globale rilevi se uno dei tuoi cluster non è disponibile, prendi in considerazione di aggiungere il controllo di integrità basato su ping ad ogni indirizzo IP. Quando imposti questo controllo, il tuo provider DNS esegue regolarmente il ping degli indirizzi IP che hai aggiunto al tuo domino. Se uno degli indirizzi IP diventa non disponibile, il traffico non verrà più inviato a questo indirizzo IP. Tuttavia, Kubernetes non riavvia automaticamente i pod dal cluster non disponibile sui nodi di lavoro nei cluster disponibili. Se vuoi che Kubernetes riavvii automaticamente i pod nei cluster disponibili, prendi in considerazione di impostare un [cluster multizona](#multi_zone).

**Perché ho bisogno di 3 cluster in 3 zone?** </br>
In modo analogo all'utilizzo di [3 zone in un cluster multizona](#multi_zone), puoi fornire una maggiore disponibilità alla tua applicazione impostando fino a 3 cluster tra le zone. Puoi anche ridurre i costi acquistando macchine più piccole per gestire il tuo carico di lavoro.

**Se voglio impostare più cluster tra le regioni?** </br>
Puoi impostare più cluster in regioni diverse di una georilevazione (ad esempio, Stati Uniti Sud e Stati Uniti Est) o tra georilevazioni (ad esempio, Stati Uniti Sud ed Europa Centrale). Entrambe le configurazioni offrono lo stesso livello di disponibilità per la tua applicazione, ma aggiungono anche complessità quando si tratta di condivisione e di replica dei dati. Per la maggior parte dei casi, trovarsi all'interno della stessa georilevazione si rivela sufficiente. Ma se hai utenti in tutto il mondo, sarebbe meglio impostare un cluster dove si trovano gli utenti, in questo modo questi ultimi non riscontreranno lunghi tempi di attesa quando invieranno una richiesta alla tua applicazione.

**Per impostare un programma di bilanciamento del carico globale per più cluster:**

1. [Crea i cluster](cs_clusters.html#clusters) in più zone o regioni.
2. Abilita lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci lo spanning delle VLAN di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Come alternativa allo spanning delle VLAN, puoi utilizzare una VRF (Virtual Router Function) se è abilitata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).
3. In ciascun cluster, esponi la tua applicazione utilizzando un [ALB](cs_ingress.html#ingress_expose_public) o un [servizio del programma di bilanciamento del carico](cs_loadbalancer.html#config).
4. Per ciascun cluster, elenca gli indirizzi IP pubblici dei tuoi ALB o dei tuoi servizi del programma di bilanciamento del carico.
   - Per elencare l'indirizzo IP di tutti gli AL pubblici abilitati nel tuo cluster:
     ```
     ibmcloud ks albs --cluster <cluster_name_or_id>
     ```
     {: pre}

   - Per elencare l'indirizzo IP per il tuo servizio del programma di bilanciamento del carico:
     ```
     kubectl describe service <myservice>
     ```
     {: pre}

     L'indirizzo IP **Ingress programma di bilanciamento del carico** è l'indirizzo IP portatile che è stato assegnato al tuo servizio del programma di bilanciamento del carico.
4. Imposta un programma di bilanciamento del carico globale utilizzando {{site.data.keyword.Bluemix_notm}} Internet Services (CIS) oppure imposta il tuo programma di bilanciamento del carico globale.
    * Per utilizzare un programma di bilanciamento del carico globale CIS:
        1. Imposta il servizio seguendo i passi da 1 a 4 presenti in [Introduzione a {{site.data.keyword.Bluemix_notm}} Internet Services (CIS)](/docs/infrastructure/cis/getting-started.html#getting-started-with-ibm-cloud-internet-services-cis-).
            * I passi da 1 a 3 ti guidano attraverso il provisioning dell'istanza di servizio, l'aggiunta del tuo dominio dell'applicazione e la configurazione dei tuoi server dei nomi.
            * Il passo 4 ti guida attraverso la creazione dei record DNS. Crea un record DNS per ciascun indirizzo IP ALB o del programma di bilanciamento del carico che hai raccolto. Questi record DNS associano il tuo dominio dell'applicazione a tutti i tuoi programmi di bilanciamento del carico o agli ALB del cluster e garantiscono che le richieste al tuo dominio dell'applicazione vengono inoltrate ai tuoi cluster in un ciclo round-robin.
        2. [Aggiungi i controlli di integrità](/docs/infrastructure/cis/glb-setup.html#add-a-health-check) per gli ALB o i programmi di bilanciamento del carico. Puoi utilizzare lo stesso controllo di integrità per gli ALB o i programmi di bilanciamento del carico in tutti i tuoi cluster oppure creare controlli di integrità specifici da utilizzare per cluster specifici.
        3. [Aggiungi un pool di origine](/docs/infrastructure/cis/glb-setup.html#add-a-pool) per ciascun cluster aggiungendo gli IP dell'ALB o del programma di bilanciamento del carico del cluster. Ad esempio, se hai 3 cluster che hanno 2 ALB, crea 3 pool di origine che hanno 2 indirizzi IP ALB ciascuno. Aggiungi un controllo di integrità a ciascun pool di origine che hai creato.
        4. [Aggiungi un programma di bilanciamento del carico globale](/docs/infrastructure/cis/glb-setup.html#set-up-and-configure-your-load-balancers).
    * Per utilizzare il tuo programma di bilanciamento del carico globale:
        1. Configura il tuo dominio per instradare il traffico in entrata al tuo ALB o ai servizi di bilanciamento del carico aggiungendo gli indirizzi IP di tutti gli ALB e di tutti i servizi del programma di bilanciamento del carico abilitati pubblici al tuo dominio.
        2. Per ciascun indirizzo IP, abilita il controllo di integrità basato su ping in modo che il tuo provider DNS possa rilevare gli indirizzi IP non integri. Se viene rilevato un indirizzo IP non integro, il traffico non verrà più instradato a questo indirizzo IP.

## Pianificazione configurazione del nodo di lavoro
{: #planning_worker_nodes}

Un cluster Kubernetes è costituito da nodi di lavoro raggruppati in pool di nodi di lavoro ed è monitorato e gestito centralmente dal master Kubernetes. Gli amministratori del cluster decidono come configurare il cluster dei nodi di lavoro per garantire che gli utenti del cluster abbiano tutte le risorse per distribuire ed eseguire le applicazioni nel cluster.
{:shortdesc}

Quando crei un cluster standard, i nodi di lavoro della stessa configurazione vengono ordinati nell'infrastruttura IBM Cloud (SoftLayer) e aggiunti al pool di nodi di lavoro predefinito nel tuo cluster. A ogni nodo di lavoro viene
assegnato un ID e nome dominio univoco che non deve essere modificato dopo la creazione del cluster.

Puoi scegliere tra server virtuali o fisici (bare metal). A seconda del livello di isolamento hardware che scegli, i nodi di lavoro virtuali possono essere configurati come nodi condivisi o dedicati. Puoi anche scegliere se vuoi che i nodi di lavoro si colleghino a una VLAN pubblica e privata o solo a una VLAN privata. Viene eseguito il provisioning di ogni nodo di lavoro
con un tipo di macchina specifico che determina il numero di vCPU, memoria
e spazio su disco disponibili per i contenitori distribuiti al nodo di lavoro. Kubernetes limita il numero massimo di nodi di lavoro che puoi avere in un cluster. Controlla [nodo di lavoro e quote pod ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/setup/cluster-large/) per ulteriori informazioni.

### Pool di lavoro
{: #worker_pools}

Ogni cluster viene configurato con un pool di lavoro predefinito che raggruppa i nodi di lavoro con la stessa configurazione che hai definito durante la creazione del cluster, ad esempio il tipo di macchina. Se esegui il provisioning di un cluster dalla IU, puoi selezionare più zone contemporaneamente. Per i cluster creati dalla CLI viene inizialmente eseguito il provisioning con un pool di lavoro solo in una zona. Puoi aggiungere più zone al tuo pool di lavoro una volta eseguito il provisioning del cluster per replicare i nodi di lavoro uniformemente tra le zone. Ad esempio, se aggiungi una seconda zona ad un pool di lavoro formato da 3 nodo di lavoro, viene eseguito il provisioning di questi 3 nodo di lavoro nella seconda zona, ciò ti lascia con un cluster con un totale di 6 nodo di lavoro.

Per abilitare la comunicazione sulla rete privata tra i nodi di lavoro che si trovano in zone diverse, devi abilitare lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning). Per aggiungere caratteristiche del tipo di macchina diverse al tuo cluster, [crea un altro pool di lavoro](cs_cli_reference.html#cs_worker_pool_create).

### Hardware per i nodi di lavoro
{: #shared_dedicated_node}

Quando crei un cluster standard in {{site.data.keyword.Bluemix_notm}}, puoi scegliere di eseguire il provisioning dei tuoi nodi di lavoro come macchine fisiche (bare metal) o come macchine virtuali eseguite su hardware fisico. Quando crei un cluster gratuito, viene eseguito automaticamente il provisioning del tuo nodo di lavoro come nodo virtuale condiviso nell'account dell'infrastruttura IBM Cloud (SoftLayer).
{:shortdesc}

![Opzioni hardware per i nodi di lavoro in un cluster standard](images/cs_clusters_hardware.png)

Controlla le seguenti informazioni per decidere quale tipo di pool di lavoro vuoi. Come ben sai, tieni presente la [soglia minima del limite del nodo di lavoro](#resource_limit_node) del 10% di capacità di memoria totale.

<dl>
<dt>Perché dovrei utilizzare le macchine fisiche (bare metal)?</dt>
<dd><p><strong>Più risorse di calcolo</strong>: puoi eseguire il provisioning del tuo nodo di lavoro come server fisico a singolo tenant, indicato anche come bare metal. Bare metal ti dà accesso diretto alle risorse fisiche sulla macchina, come la memoria o la CPU. Questa configurazione elimina l'hypervisor della macchina virtuale che assegna risorse fisiche alle macchine virtuali eseguite sull'host. Invece, tutte le risorse di una macchina bare metal sono dedicate esclusivamente al nodo di lavoro, quindi non devi preoccuparti dei "vicini rumorosi" che condividono risorse o rallentano le prestazioni. I tipi di macchine fisiche hanno un'archiviazione locale maggiore rispetto a quelle virtuali e alcune dispongono di RAID per il backup dei dati locali.</p>
<p><strong>Fatturazione mensile</strong>: i server bare metal sono più costosi di quelli virtuali e sono più adatti per le applicazioni ad alte prestazioni che richiedono più risorse e controllo host. I server bare metal vengono fatturati mensilmente. Se annulli un server bare metal prima della fine del mese, ti viene addebitato il costo fino alla fine di quel mese. L'ordinazione e l'annullamento dei server bare metal è un processo manuale che viene eseguito tramite il tuo account dell'infrastruttura IBM Cloud (SoftLayer). Il suo completamento può richiedere più di un giorno lavorativo.</p>
<p><strong>Opzione per abilitare Trusted Compute</strong>: abilita Trusted Compute per verificare i tentativi di intrusione nei tuoi nodi di lavoro. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente. Puoi creare un nuovo cluster senza attendibilità. Per ulteriori informazioni su come funziona l'attendibilità durante il processo di avvio del nodo, vedi [{{site.data.keyword.containershort_notm}} con Trusted Compute](cs_secure.html#trusted_compute). Trusted Compute è disponibile sui cluster su cui è in esecuzione Kubernetes versione 1.9 o successive e che hanno alcuni tipi di macchine bare metal. Quando esegui il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types<zone>`, puoi vedere quali macchine supportano l'attendibilità controllando il campo **Trustable**. Ad esempio, le caratteristiche GPU `mgXc` non supportano Trusted Compute.</p></dd>
<dt>Perché dovrei utilizzare le macchine virtuali?</dt>
<dd><p>Con le VM, ottieni maggiore flessibilità, tempi di provisioning più veloci e ulteriori funzioni di scalabilità automatica rispetto ai bare metal, ad un prezzo più conveniente. Puoi utilizzare le VM per casi di utilizzo più generali come gli ambienti di sviluppo e test, di preparazione e di produzione, i microservizi e le applicazioni di business. Tuttavia, è un compromesso nelle prestazioni. Se hai bisogno di calcolo di prestazioni elevate per la RAM-, i dati-, o i carichi di lavoro intensivi di GPU-, utilizza i bare metal.</p>
<p><strong>Decidi tra la tenancy singola o multipla</strong>: quando crei un cluster virtuale standard, devi scegliere se desideri che l'hardware sottostante sia condiviso tra più clienti {{site.data.keyword.IBM_notm}} (più tenant) o che sia dedicato solo a te (tenant singolo).</p>
<p>In una configurazione a più tenant, le risorse fisiche, come ad esempio la CPU e la memoria, vengono condivise tra tutte le
macchine virtuali distribuite allo stesso hardware fisico. Per assicurare che ogni macchina virtuale
possa essere eseguita indipendentemente, un monitoraggio della macchina virtuale, conosciuto anche come hypervisor,
divide le risorse fisiche in entità isolate e le alloca come risorse dedicate
a una macchina virtuale (isolamento hypervisor).</p>
<p>In una configurazione a tenant singolo, tutte le risorse fisiche sono dedicate soltanto a te. Puoi distribuire
più nodi di lavoro come macchine virtuali allo stesso host fisico. In modo simile alla configurazione a più tenant,
l'hypervisor assicura che ogni nodo ottenga la propria condivisione di risorse
fisiche disponibili.</p>
<p>I nodi condivisi sono generalmente più economici dei nodi dedicati perché i costi dell'hardware sottostante
sono condivisi tra più clienti. Tuttavia, quando decidi tra nodi condivisi e dedicati,
potresti voler verificare con il tuo dipartimento legale e discutere sul livello di conformità e isolamento dell'infrastruttura
che il tuo ambiente dell'applicazione necessita.</p>
<p><strong>Caratteristiche delle macchine virtuali `u2c` o `b2c`</strong>: queste macchine utilizzano il disco locale anziché SAN (Storage Area Networking) per garantire l'affidabilità. I vantaggi dell'affidabilità includono una velocità di elaborazione più elevata durante la serializzazione dei byte sul disco locale e una riduzione del danneggiamento del file system dovuto a errori di rete. Questi tipi di macchina contengono 25 GB di archiviazione su disco locale primario per il file system del sistema operativo e 100 GB di archiviazione su disco locale secondario per per i dai come il runtime del contenitore e il kubelet.</p>
<p><strong>Cosa succede se ho tipi di macchine `u1c` o `b1c` obsoleti?</strong> Per iniziare a utilizzare i tipi di macchina `u2c` e `b2c`, [aggiorna i tipi di macchina aggiungendo i nodi di lavoro](cs_cluster_update.html#machine_type).</p></dd>
<dt>Tra quali caratteristiche della macchina fisica e virtuali posso scegliere?</dt>
<dd><p>Molte! Seleziona il tipo di macchina che è migliore per il tuo caso di utilizzo. Ricorda che un pool di lavoro è composto da macchine che sono della stessa caratteristica. Se vuoi una combinazione di tipi di macchina nel tuo cluster, crea pool di lavoro separati per ogni caratteristica.</p>
<p>I tipi di macchina variano per zona. Per vedere i tipi di macchina disponibili nella tua zona, esegui `ibmcloud ks machine-types <zone_name>`.</p>
<p><table>
<caption>Tipi di macchina virtuale e fisica (bare metal) disponibili in {{site.data.keyword.containershort_notm}}.</caption>
<thead>
<th>Nome e caso di utilizzo</th>
<th>Core / Memoria</th>
<th>Disco primario / secondario</th>
<th>Velocità di rete</th>
</thead>
<tbody>
<tr>
<td><strong>Virtuale, u2c.2x4</strong>: utilizza questa VM di dimensione minima per il test rapido, le prove di concetto e altri carichi di lavoro leggeri.</td>
<td>2 / 4GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtuale, b2c.4x16</strong>: seleziona questa VM bilanciata per il test e lo sviluppo e altri carichi di lavoro leggeri.</td>
<td>4 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtuale, b2c.16x64</strong>: seleziona questa VM bilanciata per carichi di lavoro di dimensione media.</td></td>
<td>16 / 64GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtuale, b2c.32x128</strong>: seleziona questa VM bilanciata per carichi di lavoro medi o grandi, come un database e un sito web dinamico con molti utenti simultanei.</td></td>
<td>32 / 128GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Virtuale, b2c.56x242</strong>: seleziona questa VM bilanciata per carichi di lavoro grandi, come un database e più applicazioni con molti utenti simultanei.</td></td>
<td>56 / 242GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal con RAM intensiva, mr1c.28x512</strong>: massimizza la disponibilità della RAM dei tuoi nodi di lavoro.</td>
<td>28 / 512GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal GPU, mg1c.16x128</strong>: scegli questo tipo per i carichi di lavoro intensivi matematicamente come il calcolo di elevate prestazioni, il machine learning o le applicazioni 3D. Questa caratteristica ha 1 scheda fisica Tesla K80 con 2 GPU (graphics processing unit) per scheda per un totale di 2 GPU.</td>
<td>16 / 128GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal GPU, mg1c.28x256</strong>: scegli questo tipo per i carichi di lavoro intensivi matematicamente come il calcolo di elevate prestazioni, il machine learning o le applicazioni 3D. Questa caratteristica ha 2 schede fisiche Tesla K80 con 2 GPU per scheda per un totale di 4 GPU.</td>
<td>28 / 256GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal con dai intensivi, md1c.16x64.4x4tb</strong>: per una quantità significativa di archiviazione su disco locale, incluso RAID per eseguire il backup dei dati memorizzati localmente sulla macchina. Utilizza per casi come i file system distribuiti, i database molto grandi e i carichi di lavoro di analisi Big Data.</td>
<td>16 / 64GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal con dai intensivi, md1c.28x512.4x4tb</strong>: per una quantità significativa di archiviazione su disco locale, incluso RAID per eseguire il backup dei dati memorizzati localmente sulla macchina. Utilizza per casi come i file system distribuiti, i database molto grandi e i carichi di lavoro di analisi Big Data.</td>
<td>28 / 512 GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal bilanciato, mb1c.4x32</strong>: utilizza per i carichi di lavoro bilanciati che richiedono ulteriori risorse di calcolo rispetto all'offerta delle macchine virtuali.</td>
<td>4 / 32GB</td>
<td>2TB SATA / 2TB SATA</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>Bare metal bilanciato, mb1c.16x64</strong>: utilizza per i carichi di lavoro bilanciati che richiedono ulteriori risorse di calcolo rispetto all'offerta delle macchine virtuali.</td>
<td>16 / 64GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
</tbody>
</table>
</p>
</dd>
</dl>


Puoi distribuire i cluster utilizzando l'[IU della console](#clusters_ui) o la [CLI](#clusters_cli).

### Connessione VLAN per i nodi di lavoro
{: #worker_vlan_connection}

Quando crei un cluster, ogni cluster viene automaticamente collegato a una VLAN dal tuo account dell'infrastruttura IBM Cloud (SoftLayer).
{:shortdesc}

Una VLAN configura un gruppo di
nodi di lavoro come se fossero collegati con lo stesso cavo fisico.
* La VLAN pubblica dispone di due sottoreti fornite automaticamente. La sottorete pubblica primaria determina l'indirizzo IP pubblico assegnato a un nodo di lavoro durante la creazione del cluster e la sottorete pubblica portatile fornisce gli indirizzi IP pubblici per i servizi di rete del programma di bilanciamento del carico e Ingress.
* Anche la VLAN privata dispone di due sottoreti fornite automaticamente. La sottorete privata primaria determina l'indirizzo IP privato assegnato a un nodo di lavoro durante la creazione del cluster e la sottorete privata portatile fornisce gli indirizzi IP privati per i servizi di rete del programma di bilanciamento del carico e Ingress.

Per i cluster gratuiti, i nodi di lavoro del cluster vengono collegati a una VLAN privata e a una VLAN pubblica di proprietà di IBM per impostazione predefinita durante la creazione del cluster.

Per i cluster standard, la prima volta che crei un cluster in una zona, ti vengono automaticamente fornite una VLAN privata e una pubblica. Per ogni cluster successivo che crei in tale zona, scegli le VLAN che desideri utilizzare. Puoi collegare i tuoi nodi di lavoro a una VLAN pubblica e alla VLAN privata o solo alla VLAN privata. Se vuoi collegare i tuoi nodi di lavoro solo a una VLAN privata, puoi utilizzare l'ID di una VLAN privata esistente o [creare una VLAN privata](/docs/cli/reference/softlayer/index.html#sl_vlan_create) e utilizzare l'ID durante la creazione del cluster. Se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete, come un [VRA (Virtual Router Appliance)](cs_vpn.html#vyatta), in modo che i nodi possano comunicare con il master.

**Nota**: se hai più VLAN per un cluster o più sottoreti sulla stessa VLAN, devi attivare lo spanning delle VLAN in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per istruzioni, vedi [Abilita o disabilita lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

### Limiti di memoria dei nodi di lavoro
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} imposta un limite di memoria su ogni nodo di lavoro. Quando i pod in esecuzione sul nodo di lavoro superano questo limite di memoria, i pod vengono rimossi. In Kubernetes, questo limite è chiamato [soglia di rimozione rigida![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Se i tuoi pod vengono rimossi frequentemente, aggiungi più nodi di lavoro al tuo cluster o imposta i [limiti di risorsa ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) sui pod.

**Ogni macchina ha una soglia minima uguale al 10% della sua capacità di memoria totale**. Quando sul nodo di lavoro è disponibile meno memoria rispetto alla soglia minima consentita, Kubernetes rimuove immediatamente il pod. Il pod viene ripianificato su un altro nodo di lavoro, laddove disponibile. Ad esempio, se hai una macchina virtuale `b2c.4x16`, la sua capacità di memoria totale è 16GB. Se è disponibile meno di 1600MB (10%) di memoria, i nuovi pod non possono essere pianificati in questo nodo di lavoro ma lo sono invece in un altro. Se non è disponibile alcun nodo di lavoro, i nuovi pod rimangono senza pianificazione.

Per verificare la quantità di memoria utilizzata sul tuo nodo di lavoro, esegui [kubectl top node ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/#top).

### Autorecovery per i tuoi nodi di lavoro
`Docker`, `kubelet`, `kube-proxy` e `calico` sono componenti critici che devono essere funzionali per avere un nodo di lavoro Kubernetes integro. Con il passare del tempo questi componenti possono rompersi e lasciare il tuo nodo di lavoro in uno stato non funzionale. I nodi di lavoro non funzionali riducono la capacità totale del cluster e possono causare tempi di inattività per la tua applicazione.

Puoi [configurare i controlli di integrità per il nodo di lavoro e abilitare l'Autorecovery](cs_health.html#autorecovery). Se Autorecovery rileva un nodo di lavoro non integro in base ai controlli configurati, attiva un'azione correttiva come un ricaricamento del sistema operativo sul nodo di lavoro. Per ulteriori informazioni su come funziona Autorecovery, vedi il [blog Autorecovery ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />




## Creazione dei cluster con la GUI
{: #clusters_ui}

Lo scopo del cluster Kubernetes è quello di definire un insieme di risorse, nodi, reti e dispositivi di archiviazione che mantengano le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

**Prima di iniziare**

Devi disporre di un [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) Di prova, Pagamento a consumo o Sottoscrizione.

Per personalizzare completamente i tuoi cluster con le tue scelte per l'isolamento hardware, la zona, la versione API e altro, crea un cluster standard.
{: tip}

**Per creare un cluster gratuito**

Puoi utilizzare il tuo cluster gratuito per acquisire familiarità con il funzionamento di {{site.data.keyword.containershort_notm}}. Con i cluster gratuiti, puoi comprendere la terminologia, completare un'esercitazione e ottenere le indicazioni necessarie prima di passare ai cluster standard a livello di produzione. Non preoccuparti, hai ancora un cluster gratuito anche se hai un account Pagamento a consumo o Sottoscrizione. **Nota**: i cluster gratuiti hanno una durata di 21 giorni. Trascorso tale periodo di tempo, il cluster scade e verrà eliminato insieme ai suoi dati. {{site.data.keyword.Bluemix_notm}} non esegue il backup dei dati eliminati e non possono essere ripristinati. Assicurati di eseguire il backup dei dati importanti.

1. Nel catalogo, seleziona **{{site.data.keyword.containershort_notm}}**.

2. Seleziona una regione in cui distribuire il tuo cluster.

3. Seleziona il piano del cluster **gratuito**.

4. Assegna un nome al tuo cluster. Il nome deve iniziare con una lettera, può contenere lettere, numeri e un trattino (-) e non può contenere più di 35 caratteri. Il nome cluster e la regione in cui viene distribuito il cluster formano il nome dominio completo per il dominio secondario Ingress. Per garantire che il dominio secondario Ingress sia univoco all'interno di una regione, è possibile che il nome cluster venga troncato e vi venga aggiunto un valore casuale all'interno del nome dominio Ingress.


5. Fai clic su **Crea cluster**. Per impostazione predefinita, viene creato un pool di lavoro con un nodo di lavoro. Puoi vedere lo stato di avanzamento della distribuzione del nodo di lavoro nella scheda **Nodi di lavoro**. Quando la distribuzione è terminata, puoi vedere se il tuo cluster è pronto nella scheda **Panoramica**.

    La modifica dell'ID univoco o del nome dominio assegnato durante la creazione non consente al master di gestire il tuo cluster.
    {: tip}

</br>

**Per creare un cluster standard**

1. Nel catalogo, seleziona **{{site.data.keyword.containershort_notm}}**.

2. Seleziona una regione in cui distribuire il tuo cluster. Per prestazioni ottimali, seleziona la regione fisicamente più vicina a te. Tieni presente che se selezioni una zona che si trova al di fuori del tuo paese, potresti aver bisogno di un'autorizzazione legale prima di poter archiviare i dati.

3. Seleziona il piano del cluster **standard**. Con un cluster standard hai accesso a funzioni come più nodi di lavoro per un ambiente altamente disponibile.

4. Immetti i dettagli della tua zona.

    1. Seleziona la disponibilità a **Zona singola** o **Multizona**. In un cluster multizona, il nodo master viene distribuito in una zona in grado di supportare il multizona e le risorse del tuo cluster vengono estese tra più zone. Le tue scelte potrebbero essere limitare dalla regione.

    2. Seleziona le zone specifiche in cui desideri ospitare il tuo cluster. Devi selezionare almeno una zona ma puoi selezionarne quante ne desideri. Se selezioni più di una zona, i nodi di lavoro vengono estesi tra le zone che hai scelto e ciò ti fornisce una disponibilità più elevata. Se selezioni solo una zona, puoi [aggiungere le zone al tuo cluster](#add_zone) una volta creato.

    3. Seleziona una VLAN pubblica (facoltativo) e una VLAN privata (obbligatorio) dal tuo account dell'infrastruttura IBM Cloud (SoftLayer). I nodi di lavoro comunicano tra loro utilizzando la VLAN privata. Per comunicare con il master Kubernetes, devi configurare una connettività pubblica per il tuo nodo di lavoro.  Se non hai una VLAN pubblica o privata in questa zona, lascia vuota questa opzione. Verranno create automaticamente per te una VLAN pubblica e una privata. Se hai VLAN esistenti e non specifichi una VLAN pubblica, prendi in considerazione di configurare un firewall, ad esempio un [VRA (Virtual Router Appliance)](/docs/infrastructure/virtual-router-appliance/about.html#about). Puoi utilizzare la stessa VLAN per più cluster. Per abilitare la comunicazione sulla rete privata tra i nodi di lavoro che si trovano in zone diverse, devi abilitare lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning). **Nota**: se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete.

5. Configura il tuo pool di lavoro predefinito. I pool di lavoro sono gruppi di nodi di lavoro che condividono la stessa configurazione. Puoi sempre aggiungere altri pool di lavoro al tuo cluster in un secondo momento.

    1. Seleziona un tipo di isolamento hardware. Il tipo virtuale ha una fatturazione oraria e il tipo bare metal ha una fatturazione mensile.

        - **Virtuale - Dedicato**: i tuoi nodi di lavoro sono ospitati sull'infrastruttura dedicata al tuo account. Le tue risorse fisiche sono completamente isolate.

        - **Virtuale - Condiviso**: le risorse dell'infrastruttura, come l'hypervisor e l'hardware fisico, sono condivise tra te e altri clienti IBM, ma ciascun nodo di lavoro è accessibile solo a te. Sebbene questa opzione sia meno costosa e sufficiente nella maggior parte dei casi, potresti voler verificare i requisiti di prestazioni e infrastruttura con le politiche aziendali.

        - **Bare Metal**: il provisioning dei server bare metal, con fatturazione mensile, viene eseguito tramite l'interazione manuale con l'infrastruttura Cloud IBM (SoftLayer) e il completamento di questo processo può richiedere più di un giorno lavorativo. Bare metal è più adatto per le applicazioni ad alte prestazioni che richiedono più risorse e controllo host. Per i cluster che eseguono Kubernetes versione 1.9 o successiva, puoi anche scegliere di abilitare [Trusted Compute](cs_secure.html#trusted_compute) per verificare possibili tentativi di intrusione nei tuoi nodi di lavoro. Trusted Compute è disponibile per alcuni tipi di macchina bare metal selezionati. Ad esempio, le caratteristiche GPU `mgXc` non supportano Trusted Compute. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.

        Assicurati di voler eseguire il provisioning di una macchina bare metal. Poiché viene fatturata mensilmente, se la annulli immediatamente dopo un ordine effettuato per errore, ti viene comunque addebitato l'intero mese.
        {:tip}

    2. Seleziona un tipo di macchina. Il tipo di macchina definisce la quantità di CPU virtuale, di memoria e di spazio disco configurata in ogni nodo di lavoro e resa disponibile ai contenitori. I tipi di macchine bare metal e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Una volta creato il tuo cluster, puoi aggiungere tipi di macchina diversi aggiungendo un nodo di lavoro o un pool al cluster.

    3. Specifica il numero di nodi di lavoro di cui hai bisogno nel cluster. Il numero di nodi di lavoro che hai immesso viene replicato tra il numero di zone che hai selezionato. Ciò significa che se hai 2 zone e selezioni 3 nodi di lavoro, viene eseguito il provisioning di 6 nodi e 3 nodi sono attivi in ciascuna zona.

6. Fornisci al tuo cluster un nome univoco. **Nota**: la modifica dell'ID univoco o del nome dominio assegnato durante la creazione non consente al master di gestire il tuo cluster.

7. Scegli la versione del server API Kubernetes per il nodo master del cluster.

8. Fai clic su **Crea cluster**. Un pool di lavoro viene creato con il numero di nodi di lavoro che hai specificato. Puoi vedere lo stato di avanzamento della distribuzione del nodo di lavoro nella scheda **Nodi di lavoro**. Quando la distribuzione è terminata, puoi vedere se il tuo cluster è pronto nella scheda **Panoramica**.

**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività:

-   Estendi i nodi di lavoro tra più zone [aggiungendo una zona al tuo cluster](#add_zone).
-   [Installa le CLI per iniziare ad utilizzare
il tuo cluster.](cs_cli_install.html#cs_cli_install)
-   [Distribuisci un'applicazione nel tuo cluster.](cs_app.html#app_cli)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)
- Se hai più VLAN per un cluster o più sottoreti sulla stessa VLAN, devi [attivare lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata.
- Se hai un firewall, potresti dover [aprire le porte richieste](cs_firewall.html#firewall) per utilizzare i comandi `ibmcloud`, `kubectl` o `calicotl`, per consentire il traffico in uscita dal tuo cluster o per consentire il traffico in entrata per i servizi di rete.
-  I cluster con Kubernetes versione 1.10 o successive: controlla chi può creare i pod nel tuo cluster con le [politiche di sicurezza del pod](cs_psp.html).

<br />


## Creazione dei cluster con la CLI
{: #clusters_cli}

Lo scopo del cluster Kubernetes è quello di definire un insieme di risorse, nodi, reti e dispositivi di archiviazione che mantengano le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

Prima di iniziare:
- Devi disporre di un [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) Pagamento a consumo o Sottoscrizione configurato per [accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials). Puoi creare 1 cluster gratuito per provare alcune delle funzionalità per 30 giorni oppure puoi creare cluster standard completamente personalizzabili con le tue scelte di isolamento hardware.
- [Assicurati di disporre delle autorizzazioni minime richieste nell'infrastruttura IBM Cloud (SoftLayer) per eseguire il provisioning di un cluster standard](cs_users.html#infra_access).
- Installa la CLI {{site.data.keyword.Bluemix_notm}} e il plugin
[{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
- Se hai più VLAN per un cluster o più sottoreti sulla stessa VLAN, devi [attivare lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata.

Per creare un cluster:

1.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}.

    1.  Esegui l'accesso e immetti le tue credenziali {{site.data.keyword.Bluemix_notm}} quando richiesto.

        ```
        ibmcloud login
        ```
        {: pre}

        **Nota:** se disponi di un ID federato, utilizza `ibmcloud login --sso` per accedere alla CLI di {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

    2. Se disponi di più account {{site.data.keyword.Bluemix_notm}}, seleziona l'account in cui vuoi creare il tuo cluster Kubernetes.

    3.  Se vuoi creare o accedere ai cluster Kubernetes in una regione diversa dalla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, esegui `ibmcloud ks region-set`.

3.  Crea un cluster.

    1.  **Cluster standard**: esamina le zone disponibili. Le zone che vengono mostrate dipendono dalla regione {{site.data.keyword.containershort_notm}} a cui hai eseguito l'accesso.

        **Nota**: per estendere il tuo cluster tra le zone, devi crearlo in una [una zona che supporta il multizona](cs_regions.html#zones).

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **Cluster standard**: scegli una zona ed esamina i tipi di macchina disponibili in tale zona. Il tipo di macchina specifica gli host di calcolo virtuali o fisici disponibili per ciascun nodo di lavoro.

        -  Visualizza il campo **Tipo di server** per scegliere macchine virtuali o fisiche (bare metal).
        -  **Virtuale**: il provisioning delle macchine virtuali, con fatturazione oraria, viene eseguito su hardware condiviso o dedicato.
        -  **Fisico**: il provisioning dei server bare metal, con fatturazione mensile, viene eseguito tramite l'interazione manuale con l'infrastruttura Cloud IBM (SoftLayer) e il completamento di questo processo può richiedere più di un giorno lavorativo. Bare metal è più adatto per le applicazioni ad alte prestazioni che richiedono più risorse e controllo host.
        - **Macchine fisiche con Trusted Compute**: per i cluster bare metal che eseguono Kubernetes versione 1.9 o successiva, puoi anche scegliere di abilitare [Trusted Compute](cs_secure.html#trusted_compute) per verificare possibili tentativi di intrusione nei tuoi nodi di lavoro bare metal. Trusted Compute è disponibile per alcuni tipi di macchina bare metal selezionati. Ad esempio, le caratteristiche GPU `mgXc` non supportano Trusted Compute. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.
        -  **Tipi di macchina**: per stabilire quale tipo di macchina distribuire, esamina le combinazioni di core, memoria e archiviazione dell'[hardware del nodo di lavoro disponibile](#shared_dedicated_node). Una volta creato il tuo cluster, puoi aggiungere diversi tipi di macchina fisica o virtuale [aggiungendo un pool di lavoro](#add_pool).

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

        Devi collegare i tuoi nodi di lavoro a una VLAN privata e puoi, facoltativamente, collegarli a una VLAN pubblica **Nota**: se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete.

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
        <td>**Cluster standard**: sostituisci <em>&lt;zone&gt;</em> con l'ID zona {{site.data.keyword.Bluemix_notm}} in cui vuoi creare il tuo cluster. Le zone disponibili dipendono alla regione {{site.data.keyword.containershort_notm}} a cui hai eseguito l'accesso.<br></br>**Nota**: i nodi di lavoro del cluster vengono distribuiti in questa zona. Per estendere il tuo cluster tra le zone, devi crearlo in una [una zona che supporta il multizona](cs_regions.html#zones). Una volta creato il cluster, puoi [aggiungere una zona al cluster](#add_zone).</td>
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
          <li>**Cluster standard**: se hai già una VLAN pubblica configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella zona, immetti l'ID della VLAN pubblica. Se vuoi collegare i tuoi nodi di lavoro solo a una VLAN privata, non specificare questa opzione. **Nota**: se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete.<br/><br/>
          <strong>Nota</strong>: i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Cluster gratuiti**: non è necessario definire una VLAN privata. Il tuo cluster gratuito viene automaticamente collegato alla VLAN privata di proprietà di IBM.</li><li>**Cluster standard**: se hai già una VLAN privata configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella zona, immetti l'ID della VLAN privata. Se non hai una VLAN privata nel tuo account, non specificare questa opzione. {{site.data.keyword.containershort_notm}} crea automaticamente una VLAN privata per te.<br/><br/><strong>Nota</strong>: i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</li></ul></td>
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
        <td>**Cluster bare metal standard**: abilita [Trusted Compute](cs_secure.html#trusted_compute) per verificare i tentativi di intrusione nei tuoi nodi di lavoro bare metal. Trusted Compute è disponibile per alcuni tipi di macchina bare metal selezionati. Ad esempio, le caratteristiche GPU `mgXc` non supportano Trusted Compute. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.</td>
        </tr>
        </tbody></table>

4.  Verifica che la creazione del cluster sia stata richiesta.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    **Nota:** per le macchine virtuali, possono essere necessari alcuni minuti per l'ordine delle macchine del nodo di lavoro e per la configurazione e il provisioning del cluster nel tuo account. Il provisioning delle macchine fisiche bare metal viene eseguito tramite l'interazione manuale con l'infrastruttura Cloud IBM (SoftLayer) e il completamento di questo processo può richiedere più di un giorno lavorativo.

    Quando è stato terminato il provisioning del tuo cluster, lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.10.5
    ```
    {: screen}

5.  Controlla lo stato dei nodi di lavoro.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**, puoi accedere al cluster.

    **Nota:** a ogni nodo di lavoro viene assegnato un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo cluster.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.10.5
    ```
    {: screen}

6.  Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.
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

7.  Avvia il tuo dashboard Kubernetes con la porta predefinita `8001`.
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

-   Estendi i nodi di lavoro tra più zone [aggiungendo una zona al tuo cluster](#add_zone).
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

Quando crei un cluster, viene eseguito il provisioning dei nodi di lavoro in un pool di lavoro. Dopo aver creato il cluster, puoi aggiungere altri nodi di lavoro a un pool ridimensionandolo o aggiungendo altro pool di lavoro. Per impostazione predefinita, il pool di lavoro esiste in un'unica zona. I cluster che hanno un pool di lavoro in un'unica zona sono denominati cluster a zona singola. Quando aggiungi altre zone al cluster, il pool di lavoro esiste tra le zone. I cluster che hanno un pool di lavoro esteso tra più di una zona sono denominati cluster multizona.

Se hai un cluster multizona, mantieni bilanciate le sue risorse del nodo di lavoro. Assicurati che tutti i pool di lavoro vengano estesi tra le stesse zone e aggiungi o rimuovi i nodi di lavoro ridimensionando i pool invece di aggiungere singoli nodi.
{: tip}

Le seguenti sezioni ti mostrano come:
  * [Aggiungere nodi di lavoro ridimensionando un pool di lavoro esistente nel tuo cluster](#resize_pool)
  * [Aggiungere nodi di lavoro aggiungendo un pool di lavoro al tuo cluster](#add_pool)
  * [Aggiungere una zona al tuo cluster e replicare i nodi di lavoro nei tuoi pool di lavoro tra più zone](#add_zone)
  * [Obsoleto: Aggiungere un nodo di lavoro autonomo a un cluster](#standalone)


### Aggiunta di nodi di lavoro ridimensionando un pool di lavoro esistente
{: #resize_pool}

Puoi aggiungere o ridurre il numero di nodi di lavoro nel tuo cluster ridimensionando un pool di lavoro esistente, indipendentemente dal fatto che il pool di lavoro si trovi in un'unica zona o sia esteso tra più zone.
{: shortdesc}

Ad esempio, prendi in considerazione un cluster con un pool di lavoro che ha tre nodi di lavoro per zona. 
* Se il cluster è a zona singola ed esiste in `dal10`, il pool di lavoro ha tre nodi di lavoro in `dal10`. Il cluster ha un totale di tre nodi di lavoro. 
* Se il cluster è multizona ed esiste in `dal10` e `dal12`, il pool di lavoro ha tre nodi di lavoro in `dal10` e tre nodo di lavoro in `dal12`. Il cluster ha un totale di sei nodi di lavoro. 

Per i pool di lavoro bare metal, ricordati che la fatturazione è mensile. Il ridimensionamento aggiungendo o rimuovendo elementi influirà sui costi mensili.
{: tip}

Per ridimensionare il pool di lavoro, modifica il numero di nodi di lavoro che il pool di lavoro distribuisce in ciascuna zona: 

1. Ottieni il nome del pool di lavoro che vuoi ridimensionare.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Ridimensiona il pool di lavoro indicando il numero di nodi di lavoro che vuoi distribuire in ciascuna zona. Il valore minimo è 1.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Verifica che il pool di lavoro sia stato ridimensionato.
    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Esempio di output per un pool di lavoro che si trova in due zone, `dal10` e `dal12`, e che è stato ridimensionato a due nodi di lavoro per zona:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Aggiunta di nodi di lavoro creando un nuovo pool di lavoro
{: #add_pool}

Puoi aggiungere nodi di lavoro al tuo cluster creando un nuovo pool di lavoro.
{:shortdesc}

1. Elenca le zone disponibili e scegli la zona in cui vuoi distribuire i nodi di lavoro nel tuo pool di lavoro. Se pianifichi di estendere i nodi di lavoro tra più zone, scegli una [zona che supporta il multizona](cs_regions.html#zones).
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Per ciascuna zona elenca le VLAN pubbliche e private disponibili. Prendi nota della VLAN privata e di quella pubblica che vuoi utilizzare. Se non hai una VLAN privata o una pubblica, la VLAN viene creata automaticamente per te quando aggiungi una zona al tuo pool di lavoro. 
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Crea un pool di lavoro. Per le opzioni del tipo di macchina, esamina la documentazione del [comando `machine-types`](cs_cli_reference.html#cs_machine_types).
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

4. Verifica che il pool di lavoro sia stato creato.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

5. Per impostazione predefinita, l'aggiunta di un pool di lavoro crea un pool senza zone. Per distribuire i nodi di lavoro in una zona, devi aggiungere le zone al pool di lavoro. Se desideri estendere i tuoi nodi di lavoro tra più zone, ripeti questo comando con una zona diversa che supporta il multizona.   
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

6. Verifica che sia stato eseguito il provisioning dei nodi di lavoro nella zona che hai aggiunto. 
   ```
   ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Output di esempio:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Aggiunta di nodi di lavoro aggiungendo una zona a un pool di lavoro
{: #add_zone}

Puoi estendere il tuo cluster tra più zone all'interno di una regione aggiungendo una zona al tuo pool di lavoro esistente.
{:shortdesc}

Quando aggiungi una zona a un pool di lavoro, viene eseguito il provisioning dei nodi di lavoro definiti nel tuo pool di lavoro nella nuova zona e vengono considerati per una pianificazione futura del carico di lavoro. {{site.data.keyword.containerlong_notm}} aggiunge automaticamente l'etichetta `failure-domain.beta.kubernetes.io/region` per la regione e l'etichetta `failure-domain.beta.kubernetes.io/zone` per la zona a ciascun nodo di lavoro. Il programma di pianificazione (scheduler) Kubernetes usa queste tabelle per estendere i pod tra le zone all'interno della stessa regione. 

**Nota**: se hai più nodi di lavoro nel tuo cluster, aggiungi la zona a tutti loro in modo che i nodi di lavoro vengano estesi uniformemente nel tuo cluster.

Prima di iniziare:
*  Per aggiungere una zona al tuo pool di lavoro, il tuo pool di lavoro deve trovarsi in una [zona che supporta il multizona](cs_regions.html#zones). Se il tuo pool di lavoro non si trova in una zona che supporta il multizona, prendi in considerazione di [creare un nuovo pool di lavoro](#add_pool).
*  Abilita lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci lo spanning delle VLAN di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Come alternativa allo spanning delle VLAN, puoi utilizzare una VRF (Virtual Router Function) se è abilitata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).

Per aggiungere una zona con nodi di lavoro al tuo pool di lavoro: 

1. Elenca le zone disponibili e seleziona quella che vuoi aggiungere al tuo pool di lavoro. La zona che hai scelto deve essere una zona che supporta il multizona. 
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Elenca le VLAN disponibili in tale zona. Se non hai una VLAN privata o una pubblica, la VLAN viene creata automaticamente per te quando aggiungi una zona al tuo pool di lavoro. 
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Elenca i pool di lavoro nel tuo cluster e prendi nota dei loro nomi. 
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Aggiungi la zona al tuo pool di lavoro. Se hai più pool di lavoro, aggiungi la zona a tutti i tuoi pool di lavoro in modo che il tuo cluster sia bilanciato in tutte le zone. Sostituisci `<pool1_id_or_name,pool2_id_or_name,...>` con i nomi di tutti i tuoi pool di lavoro in un elenco separato da virgole. </br>**Nota:** è necessario che esistano una VLAN pubblica e una privata prima che tu possa aggiungere una zona a più pool di lavoro. Se non hai una VLAN privata e una pubblica in tale zona, aggiungi innanzitutto la zona a un pool di lavoro in modo che la VLAN privata e quella pubblica vengano create per te. Quindi, puoi aggiungere la zona agli altri pool di lavoro specificando la VLAN privata e quella pubblica create per te. 

   Se vuoi utilizzare VLAN diverse per pool di lavoro differenti, ripeti questo comando per ciascuna VLAN e i suoi pool di lavoro corrispondenti. I nuovi nodi di lavoro vengono aggiunti alle VLAN che hai specificato, ma le VLAN per i nodi di lavoro esistenti non vengono modificate.
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
    Name:               mycluster
    ID:                 a20a637238aa471f8d4a8b881aaa4988
    State:              normal
    Created:            2018-04-19T01:49:22+0000
    Master zone:    us-south
    Worker zones:       dal10,dal12
    Master URL:         https://169.xx.xxx.xxx:21111
    Ingress subdomain:  ...
    Ingress secret:     ...
    Workers:            6
    Version:            1.8.6_1504
    ```
    {: screen}  

### Obsoleto: Aggiunta di nodi di lavoro autonomi
{: #standalone}

Se hai un cluster che è stato creato prima dell'introduzione dei pool di lavoro, puoi usare i comandi obsoleti per aggiungere nodi di lavoro autonomi.
{: shortdesc}

**Nota:** se hai un cluster che è stato creato dopo l'introduzione dei pool di lavoro, non puoi aggiungere nodi di lavoro autonomi. Puoi invece [creare un pool di lavoro](#add_pool), [ridimensionare un pool di lavoro esistente](#resize_pool) o [aggiungere una zona a un pool di lavoro](#add_zone) per aggiungere i nodi di lavoro al tuo cluster.

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
   <td>Interrotto</td>
   <td>L'eliminazione del cluster viene richiesta dall'utente prima che il master Kubernetes venga distribuito. Al termine dell'eliminazione del cluster, questo viene rimosso dal tuo dashboard. Se il tuo cluster rimane bloccato in questo stato per un lungo periodo, apri un [{{site.data.keyword.Bluemix_notm}} ticket di supporto](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
 <tr>
     <td>Critico</td>
     <td>Il master Kubernetes non può essere raggiunto o tutti i nodi di lavoro nel cluster sono inattivi. </td>
    </tr>
   <tr>
     <td>Eliminazione non riuscita</td>
     <td>Non è possibile eliminare il master Kubernetes o almeno uno dei nodi di lavoro.  </td>
   </tr>
   <tr>
     <td>Eliminato</td>
     <td>Il cluster viene eliminato ma non ancora rimosso dal tuo dashboard. Se il tuo cluster rimane bloccato in questo stato per un lungo periodo, apri un [{{site.data.keyword.Bluemix_notm}} ticket di supporto](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Eliminazione</td>
   <td>Il cluster viene eliminato e la relativa infrastruttura viene smantellata. Non puoi accedere al cluster.  </td>
   </tr>
   <tr>
     <td>Distribuzione non riuscita</td>
     <td>Non è stato possibile completare la distribuzione del master Kubernetes. Non puoi risolvere questo stato. Contatta il supporto IBM Cloud aprendo un [{{site.data.keyword.Bluemix_notm}} ticket di supporto](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Distribuzione</td>
       <td>Il master Kubernetes non è ancora stato completamente distribuito. Non puoi accedere al tuo cluster. Attendi fino alla completa distribuzione del cluster per verificarne l'integrità.</td>
      </tr>
      <tr>
       <td>Normale</td>
       <td>Tutti i nodi di lavoro in un cluster sono attivi e in esecuzione. Puoi accedere al cluster e distribuire le applicazioni al cluster. Questo stato è considerato come integro e non richiede un'azione da parte tua. **Nota**: anche se i nodi di lavoro possono essere normali, le altre risorse dell'infrastruttura, come [rete](cs_troubleshoot_network.html) e [archiviazione](cs_troubleshoot_storage.html), potrebbero necessitare ancora di attenzione.</td>
    </tr>
      <tr>
       <td>In sospeso</td>
       <td>Il master Kubernetes è stato distribuito. Sta venendo eseguito il provisioning dei nodi di lavoro e non sono ancora disponibili nel cluster. Puoi accedere al cluster, ma non puoi distribuire le applicazioni al cluster.  </td>
     </tr>
   <tr>
     <td>Richiesto</td>
     <td>Viene inviata una richiesta per creare il cluster e ordinare l'infrastruttura per il master Kubernetes e i nodi di lavoro. Quando viene avviata la distribuzione del cluster, lo stato del cluster cambia in <code>Distribuzione</code>. Se il tuo cluster rimane bloccato nello stato <code>Richiesto</code> per molto tempo, apri un [{{site.data.keyword.Bluemix_notm}}ticket di supporto](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Aggiornamento in corso</td>
     <td>Il server API Kubernetes eseguito nel master Kubernetes viene aggiornato a una nuova versione dell'API Kubernetes. Durante l'aggiornamento, non è possibile accedere o modificare il cluster. I nodi di lavoro, le applicazioni e le risorse che sono state distribuite dall'utente non vengono modificate e continuano a essere eseguite. Attendi il completamento dell'aggiornamento per verificare l'integrità del tuo cluster. </td>
   </tr>
    <tr>
       <td>Avvertenza</td>
       <td>Almeno un nodo di lavoro nel cluster non è disponibile, ma altri lo sono e possono subentrare nel carico di lavoro. </td>
    </tr>
   </tbody>
 </table>


<br />


## Rimozione dei cluster
{: #remove}

I cluster gratuiti e standard creati con un account a Pagamento a consumo devono essere rimossi manualmente quando non sono più necessari in modo che non utilizzino più le risorse.
{:shortdesc}

**Avvertenza:**
  - Non viene creato alcun backup del tuo cluster o dei tuoi dati nella tua archiviazione persistente. L'eliminazione di un cluster o dell'archiviazione persistente è permanente e non può essere annullata.
  - Quando decidi di rimuovere un cluster, rimuovi anche le sottoreti di cui è stato eseguito automaticamente il provisioning quando hai creato il cluster e che hai creato utilizzando il comando `ibmcloud ks cluster-subnet-create`. Tuttavia, se hai aggiunto manualmente sottoreti esistenti al tuo cluster utilizzando il `comando ibmcloud ks cluster-subnet-add`, tali sottoreti non verranno rimosse dal tuo account dell'infrastruttura IBM Cloud (SoftLayer) e potrai riutilizzarle in altri cluster. 

Prima di iniziare:
* Prendi nota del tuo ID cluster. Potresti aver bisogno dell'ID cluster per analizzare e rimuovere le risorse correlate all'infrastruttura IBM Cloud (SoftLayer) che non vengono automaticamente eliminate con il tuo cluster.
* Se vuoi eliminare i dati nella tua archiviazione persistente, [comprendi le opzioni di eliminazione](cs_storage_remove.html#cleanup).

Per rimuovere un cluster:

-   Dalla GUI {{site.data.keyword.Bluemix_notm}}
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

          **Nota**: a causa del ciclo di fatturazione mensile, non è possibile eliminare un'attestazione del volume persistente durante l'ultimo giorno del mese. Se elimini l'attestazione del volume persistente l'ultimo giorno del mese, l'eliminazione rimane in sospeso fino all'inizio del mese successivo.

Passi successivi:
- Puoi riutilizzare il nome di un cluster rimosso una volta che non è più presente nell'elenco dei cluster disponibili quando viene eseguito il comando `ibmcloud ks clusters`. 
- Se mantieni le sottoreti, puoi [riutilizzarle in un nuovo cluster](cs_subnets.html#custom) o eliminarle manualmente in un secondo momento dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).
- Se mantieni l'archiviazione persistente, puoi [eliminare la tua archiviazione](cs_storage_remove.html#cleanup) in un secondo momento attraverso il dashboard dell'infrastruttura IBM Cloud (SoftLayer) nella GUI {{site.data.keyword.Bluemix_notm}}.
