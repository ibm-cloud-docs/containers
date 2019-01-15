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



# Esposizione di applicazioni con i programmi di bilanciamento del carico
{: #loadbalancer}

Esponi una porta e usa un indirizzo IP portatile per un programma di bilanciamento del carico di livello 4 per accedere a un'applicazione inserita in un contenitore.
{:shortdesc}

Quando crei un cluster standard, {{site.data.keyword.containerlong}} esegue automaticamente il provisioning di una sottorete pubblica portatile e di una sottorete privata portatile.

* La sottorete pubblica portatile fornisce 5 indirizzi IP utilizzabili. 1 indirizzo IP pubblico portatile è utilizzato dall'[ALB Ingress pubblico](cs_ingress.html) predefinito. I restanti 4 indirizzi IP pubblici portatili possono essere usati per esporre le singole applicazioni su Internet creando servizi del programma di bilanciamento del carico pubblici.
* La sottorete privata portatile fornisce 5 indirizzi IP utilizzabili. 1 indirizzo IP privato portatile è utilizzato dall'[ALB Ingress privato](cs_ingress.html#private_ingress). I restanti 4 indirizzi IP privati portatili possono essere usati per esporre le singole applicazioni su una rete privata creando servizi del programma di bilanciamento del carico privati.

Gli indirizzi IP pubblici e privati portatili sono IP mobili statici e non cambiano quando viene rimosso un nodo di lavoro. Se il nodo di lavoro su cui si trova l'indirizzo IP del programma di bilanciamento del carico viene rimosso, un daemon Keepalive, che monitora costantemente l'IP, sposta automaticamente l'IP in un altro nodo di lavoro. Puoi assegnare una qualsiasi porta al tuo programma di bilanciamento del carico e non è associata a un dato intervallo di porte. Il servizio del programma di bilanciamento del carico funge da punto di ingresso per le richieste in entrata per l'applicazione. Per accedere al servizio del programma di bilanciamento del carico da Internet, utilizza l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata nel formato `<IP_address>:<port>`.

Quando esponi un'applicazione con un servizio del programma di bilanciamento del carico, la tua applicazione viene automaticamente resa disponibile anche sulle NodePort del servizio. Le [NodePort](cs_nodeport.html) sono accessibili su ogni indirizzo IP pubblico e privato di ogni nodo di lavoro all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

## Componenti e architettura del programma di bilanciamento del carico 2.0 (Beta)
{: #planning_ipvs}

Le funzionalità del programma di bilanciamento del carico 2.0 sono in versione beta. Per utilizzare un programma di bilanciamento del carico versione 2.0, devi [aggiornare i nodi master e di lavoro del tuo cluster](cs_cluster_update.html) a Kubernetes versione 1.12 o successive.
{: note}

Il programma di bilanciamento del carico 2.0 è un programma di bilanciamento del carico di livello 4 che viene implementato utilizzando IPVS (IP Virtual Server) del kernel Linux. Il programma di bilanciamento del carico 2.0 supporta TCP e UDP, viene eseguito di fronte a più nodi di lavoro e utilizza il tunneling IPIP (IP over IP) per distribuire il traffico che arriva a un singolo indirizzo IP del programma di bilanciamento del carico tra quei nodi di lavoro.

Per ulteriori dettagli, puoi consultare anche questo [post del blog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/) sul programma di bilanciamento del carico 2.0.

### In cosa sono simili i programmi di bilanciamento del carico versione 1.0 e 2.0?
{: #similarities}

I programmi di bilanciamento del carico versione 1.0 e 2.0 sono entrambi programmi di bilanciamento del carico di livello 4 che vivono solo nello spazio del kernel Linux. Entrambe le versioni vengono eseguite all'interno del cluster e utilizzano le risorse del nodo di lavoro. Pertanto, la capacità disponibile dei programmi di bilanciamento del carico è sempre dedicata al tuo proprio cluster. Inoltre, entrambe le versioni del programma di bilanciamento del carico non terminano la connessione. Al contrario, inoltrano le connessioni a un pod dell'applicazione.

### In cosa sono diversi i programmi di bilanciamento del carico versione 1.0 e 2.0?
{: #differences}

Quando un client invia una richiesta alla tua applicazione, il programma di bilanciamento del carico instrada i pacchetti di richiesta all'indirizzo IP del nodo di lavoro in cui è presente un pod dell'applicazione. I programmi di bilanciamento del carico versione 1.0 utilizzano la NAT (Network Address Translation) per riscrivere l'indirizzo IP di origine del pacchetto di richiesta sull'IP del nodo di lavoro in cui è presente un pod del programma di bilanciamento del carico. Quando il nodo di lavoro restituisce il pacchetto di risposta dell'applicazione, utilizza quell'IP del nodo di lavoro in cui è presente il programma di bilanciamento del carico. Il programma di bilanciamento del carico deve quindi inviare il pacchetto di risposta al client. Per evitare che l'indirizzo IP venga riscritto, puoi [abilitare la conservazione dell'IP di origine](#node_affinity_tolerations). Tuttavia, la conservazione dell'IP di origine richiede che i pod del programma di bilanciamento del carico e i pod dell'applicazione vengano eseguiti sullo stesso nodo di lavoro in modo che la richiesta non debba essere inoltrata a un altro nodo di lavoro. Devi aggiungere l'affinità e le tolleranze del nodo ai pod dell'applicazione.

A differenza dei programmi di bilanciamento del carico versione 1.0, quelli della versione 2.0 non utilizzano NAT durante l'inoltro delle richieste ai pod dell'applicazione su altri nodi di lavoro. Quando un programma di bilanciamento del carico 2.0 instrada una richiesta del client, utilizza IPIP (IP over IP) per incapsulare il pacchetto di richiesta originale in un altro nuovo pacchetto. Questo pacchetto IPIP di incapsulamento ha un IP di origine del nodo di lavoro in cui si trova il pod del programma di bilanciamento del carico, che consente al pacchetto di richiesta originale di conservare l'IP del client come proprio indirizzo IP di origine. Il nodo di lavoro utilizza quindi il DSR (direct server return) per inviare il pacchetto di risposta dell'applicazione all'IP del client. Il pacchetto di risposta ignora il programma di bilanciamento del carico e viene inviato direttamente al client, riducendo la quantità di traffico che deve essere gestita dal programma di bilanciamento del carico.

### In che modo viene effettuata una richiesta alla mia applicazione con un programma di bilanciamento del carico versione 2.0 in un cluster a zona singola?
{: #ipvs_single}

Il seguente diagramma mostra come un programma di bilanciamento del carico 2.0 indirizza la comunicazione da Internet a un'applicazione in un cluster a zona singola.

<img src="images/cs_loadbalancer_ipvs_planning.png" width="550" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un programma di bilanciamento del carico versione 2.0" style="width:550px; border-style: none"/>

1. Una richiesta del client alla tua applicazione usa l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata sul nodo di lavoro. In questo esempio, il programma di bilanciamento del carico ha l'indirizzo IP virtuale 169.61.23.130, che attualmente si trova sul nodo di lavoro 10.73.14.25.

2. Il programma di bilanciamento del carico incapsula il pacchetto di richiesta del client (etichettato come "CR" nell'immagine) all'interno di un pacchetto IPIP (etichettato come "IPIP"). Il pacchetto di richiesta del client mantiene l'IP del client come proprio indirizzo IP di origine. Il pacchetto di incapsulamento IPIP utilizza l'IP 10.73.14.25 del nodo di lavoro come proprio indirizzo IP di origine.

3. Il programma di bilanciamento del carico instrada il pacchetto IPIP a un nodo di lavoro su cui si trova un pod dell'applicazione, 10.73.14.26. Se nel cluster vengono distribuite più istanze dell'applicazione, il programma di bilanciamento del carico instrada le richieste tra i nodi di lavoro in cui sono distribuiti i pod dell'applicazione.

4. Il nodo di lavoro 10.73.14.26 decomprime il pacchetto di incapsulamento IPIP e quindi decomprime il pacchetto di richiesta del client. Il pacchetto di richiesta del client viene inoltrato al pod dell'applicazione su quel nodo di lavoro.

5. Il nodo di lavoro 10.73.14.26 utilizza quindi l'indirizzo IP di origine dal pacchetto di richiesta originale, l'IP del client, per restituire il pacchetto di risposta del pod dell'applicazione direttamente al client.

### In che modo viene effettuata una richiesta alla mia applicazione con un programma di bilanciamento del carico versione 2.0 in un cluster multizona?
{: #ipvs_multi}

Il flusso del traffico attraverso un cluster multizona segue lo stesso percorso del [traffico attraverso un cluster a zona singola](#ipvs_single). In un cluster multizona, il programma di bilanciamento del carico instrada le richieste alle istanze dell'applicazione nella sua zona e alle istanze dell'applicazione in altre zone. Il seguente diagramma mostra come i programmi di bilanciamento del carico di versione 2.0 indirizzano la comunicazione da Internet a un'applicazione in un cluster multizona.

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un programma di bilanciamento del carico 2.0" style="width:500px; border-style: none"/>

Per impostazione predefinita, ogni programma di bilanciamento del carico versione 2.0 viene configurato solo in una zona. Puoi ottenere una maggiore disponibilità distribuendo un programma di bilanciamento del carico versione 2.0 in ogni zona in cui hai istanze dell'applicazione.

<br />


## Algoritmi di pianificazione del programma di bilanciamento del carico 2.0
{: #scheduling}

Gli algoritmi di pianificazione determinano in che modo un programma di bilanciamento del carico versione 2.0 assegna le connessioni di rete ai tuoi pod dell'applicazione. Quando le richieste del client arrivano al tuo cluster, il programma di bilanciamento del carico instrada i pacchetti di richiesta ai nodi di lavoro in base all'algoritmo di pianificazione. Per utilizzare un algoritmo di pianificazione, specifica il suo nome breve Keepalived nell'annotazione del programma di pianificazione (scheduler) del tuo file di configurazione del servizio del programma di bilanciamento del carico: `service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Controlla i seguenti elenchi per vedere quali algoritmi di pianificazione sono supportati in {{site.data.keyword.containerlong_notm}}. Se non specifichi un algoritmo di pianificazione, viene utilizzato l'algoritmo Round Robin per impostazione predefinita. Per ulteriori informazioni, vedi la [documentazione Keepalived ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://www.Keepalived.org/doc/scheduling_algorithms.html).

### Algoritmi di pianificazione supportati
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>Il programma di bilanciamento del carico scorre l'elenco dei pod dell'applicazione durante l'instradamento delle connessioni ai nodi di lavoro, trattando allo stesso modo ciascun pod dell'applicazione. Round Robin è l'algoritmo di pianificazione predefinito per i programmi di bilanciamento del carico versione 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>Il programma di bilanciamento del carico genera una chiave di hash in base all'indirizzo IP di origine del pacchetto di richiesta del client. Quindi, il programma di bilanciamento del carico cerca la chiave di hash in una tabella hash assegnata staticamente e inoltra la richiesta al pod dell'applicazione che gestisce gli hash di tale intervallo. Questo algoritmo garantisce che le richieste provenienti da un determinato client siano sempre indirizzate allo stesso pod dell'applicazione.</br>**Nota**: Kubernetes utilizza le regole Iptables, che comportano l'invio di richieste a un pod casuale sul nodo di lavoro. Per utilizzare questo algoritmo di pianificazione, devi assicurarti che non venga distribuito più di un pod della tua applicazione per ciascun nodo di lavoro. Ad esempio, se ogni pod ha l'etichetta <code>run=&lt;app_name&gt;</code>, aggiungi la seguente regola di anti-affinità alla sezione <code>spec</code> della tua distribuzione dell'applicazione:</br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

Puoi trovare l'esempio completo in [questo blog sui modelli di distribuzione IBM Cloud ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/).</dd>
</dl>

### Algoritmi di pianificazione non supportati
{: #scheduling_unsupported}

<dl>
<dt>Destination Hashing (<code>dh</code>)</dt>
<dd>La destinazione del pacchetto, che è l'indirizzo IP e la porta del programma di bilanciamento del carico, viene utilizzata per determinare quale nodo di lavoro gestisce la richiesta in entrata. Tuttavia, l'indirizzo IP e la porta per i programmi di bilanciamento del carico in {{site.data.keyword.containerlong_notm}} non cambiano. Il programma di bilanciamento del carico viene forzato a mantenere la richiesta all'interno dello stesso nodo di lavoro su cui si trova, quindi solo i pod dell'applicazione in un unico nodo di lavoro gestiscono tutte le richieste in entrata.</dd>
<dt>Algoritmi di conteggio dinamico delle connessioni</dt>
<dd>I seguenti algoritmi dipendono dal conteggio dinamico delle connessioni tra client e programmi di bilanciamento del carico. Tuttavia, poiché il DSR (direct service return) impedisce ai pod del programma di bilanciamento del carico 2.0 di essere nel percorso del pacchetto restituito, i programmi di bilanciamento del carico non tengono traccia delle connessioni stabilite.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Algoritmi di pod ponderati</dt>
<dd>I seguenti algoritmi dipendono dai pod dell'applicazione ponderati. Tuttavia, in {{site.data.keyword.containerlong_notm}}, a tutti i pod dell'applicazione viene assegnato lo stesso peso per il bilanciamento del carico.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>

<br />


## Prerequisiti del programma di bilanciamento del carico 2.0
{: #ipvs_provision}

Non puoi aggiornare un programma di bilanciamento del carico versione 1.0 esistente alla versione 2.0. Devi creare un nuovo programma di bilanciamento del carico versione 2.0. Nota che puoi eseguire contemporaneamente i programmi di bilanciamento del carico versione 1.0 e 2.0 in un cluster.

Prima di creare un programma di bilanciamento del carico versione 2.0, devi completare i seguenti passi prerequisiti.

1. [Aggiorna i nodi master e di lavoro del tuo cluster](cs_cluster_update.html) a Kubernetes versione 1.12 o successive.

2. Per consentire al tuo programma di bilanciamento del carico 2.0 di inoltrare le richieste ai pod dell'applicazione in più zone, apri un caso di supporto per richiedere un'impostazione di configurazione per le tue VLAN. **Importante**: devi richiedere questa configurazione per tutte le VLAN pubbliche. Se richiedi una nuova VLAN associata, devi aprire un altro ticket per tale VLAN.
    1. Accedi alla [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/).
    2. Nel menu, passa a **Infrastructure** e quindi a **Support > Add Ticket**.
    3. Nei campi del caso, seleziona **Technical**, **Infrastructure** e **Public Network Question.**
    4. Aggiungi le seguenti informazioni alla descrizione: "Please set up the network to allow capacity aggregation on the public VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145".
    5. Fai clic su **Submit Ticket**.

3. Una volta che le tue VLAN sono state configurate con aggregazione di capacità, abilita lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer). Quando lo spanning della VLAN viene abilitato, il programma di bilanciamento del carico versione 2.0 può instradare i pacchetti alle varie sottoreti nell'account.

4. Se usi le [politiche di rete pre-DNAT di Calico](cs_network_policy.html#block_ingress) per gestire il traffico all'indirizzo IP di un programma di bilanciamento del carico versione 2.0, devi aggiungere i campi `applyOnForward: true` e `doNotTrack: true` alla sezione `spec` delle politiche. `applyOnForward: true` assicura che la politica Calico venga applicata al traffico quando viene incapsulato e inoltrato. `doNotTrack: true` garantisce che i nodi di lavoro possano utilizzare DSR per restituire un pacchetto di risposta direttamente al client senza che sia necessario tenere traccia della connessione. Ad esempio, se utilizzi una politica Calico per inserire in whitelist il traffico solo da specifici indirizzi IP all'indirizzo IP del tuo programma di bilanciamento del carico, la politica è simile alla seguente:
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

Successivamente, puoi seguire i passi in [Configurazione di un programma di bilanciamento del carico 2.0 in un cluster multizona](#ipvs_multi_zone_config) o [in un cluster a zona singola](#ipvs_single_zone_config).

<br />


## Configurazione di un programma di bilanciamento del carico 2.0 in un cluster multizona
{: #ipvs_multi_zone_config}

I servizi del programma di bilanciamento del carico sono disponibili solo per i cluster standard e non supportano la terminazione TLS. Se la tua applicazione richiede la terminazione TLS,
la puoi esporre utilizzando [Ingress](cs_ingress.html) o configurare la tua applicazione per gestire la terminazione TLS.
{: note}

**Prima di iniziare**:

  * **Importante**: completa i [prerequisiti del programma di bilanciamento del carico 2.0](#ipvs_provision).
  * Per creare programmi di bilanciamento del carico pubblici in più zone, almeno una VLAN pubblica deve avere delle sottoreti portatili disponibili in ciascuna zona. Per creare programmi di bilanciamento del carico privati in più zone, almeno una VLAN privata deve avere delle sottoreti portatili disponibili in ciascuna zona. Per aggiungere sottoreti, vedi [Configurazione delle sottoreti per i cluster](cs_subnets.html).
  * Se limiti il traffico di rete ai nodi di lavoro edge, assicurati che siano abilitati almeno 2 [nodi di lavoro edge](cs_edge.html#edge) in ciascuna zona. Se i nodi di lavoro edge sono abilitati in alcune zone ma non in altre, i programmi di bilanciamento del carico non verranno distribuiti uniformemente. I programmi di bilanciamento del carico verranno distribuiti sui nodi edge in alcune zone ma non sui nodi di lavoro regolari in altre zone.


Per configurare un programma di bilanciamento del carico 2.0 in un cluster multizona:
1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico.

2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su Internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
  1. Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.
  2. Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre. Puoi specificare una zona, una VLAN e un indirizzo IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
      ```
      {: codeblock}

      <table>
      <caption>Descrizione dei componenti del file YAML</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotazione per specificare il tipo di programma di bilanciamento del carico. I valori accettati sono <code>private</code> e <code>public</code>. Se crei un programma di bilanciamento del carico pubblico nei cluster che si trovano su VLAN pubbliche, questa annotazione non è richiesta.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotazione per specificare la zona in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le zone, esegui <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>Annotazione per specificare un programma di bilanciamento del carico versione 2.0.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>Facoltativo: annotazione per specificare un algoritmo di pianificazione. I valori accettati sono <code>"rr"</code> per Round Robin (predefinito) o <code>"sh"</code> per Source Hashing.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta da utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, controlla i valori <em>&lt;selectorkey&gt;</em> e <em>&lt;selectorvalue&gt;</em>. Assicurati che siano gli stessi della coppia <em>chiave/valore</em> che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> del tuo file yaml di distribuzione.</td>
      </tr>
      <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che vuoi utilizzare. Se specifichi una VLAN o una zona, l'indirizzo IP deve essere in quella VLAN o zona. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Imposta su <code>Local</code>.</td>
      </tr>
      </tbody></table>

      File di configurazione di esempio per creare un servizio del programma di bilanciamento del carico 2.0 in `dal12` che utilizza l'algoritmo di pianificazione Round Robin:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. Facoltativo: configura un firewall specificando `loadBalancerSourceRanges` nella sezione **spec**. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Crea il servizio nel tuo cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Sostituisci _&lt;myservice&gt;_ con il nome del servizio del programma di bilanciamento del carico che hai creato nel passo precedente. Perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Output CLI di esempio:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile che è stato assegnato al tuo servizio del programma di bilanciamento del carico.

4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Per ottenere l'alta disponibilità, ripeti i passi precedenti per aggiungere un programma di bilanciamento del carico 2.0 in ogni zona in cui hai istanze dell'applicazione.

6. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

## Configurazione di un programma di bilanciamento del carico 2.0 in un cluster a zona singola
{: #ipvs_single_zone_config}

Prima di iniziare:

* Questa funzione è disponibile solo per i cluster standard.
* Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio di bilanciamento del carico.
* **Importante**: completa i [prerequisiti del programma di bilanciamento del carico 2.0](#ipvs_provision).

Per creare un servizio del programma di bilanciamento del carico 2.0 in un cluster a zona singola:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico.
2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su Internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
    1.  Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.

    2.  Definisci un servizio del programma di bilanciamento del carico 2.0 per l'applicazione che vuoi esporre.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare il tipo di programma di bilanciamento del carico. I valori accettati sono `private` e `public`. Se crei un programma di bilanciamento del carico pubblico nei cluster che si trovano su VLAN pubbliche, questa annotazione non è richiesta.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Annotazione per specificare un programma di bilanciamento del carico 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Annotazione per specificare un algoritmo di pianificazione. I valori accettati sono <code>"rr"</code> per Round Robin (predefinito) o <code>"sh"</code> per Source Hashing.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta da utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, controlla i valori <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em>. Assicurati che siano gli stessi della coppia <em>chiave/valore</em> che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> del tuo file yaml di distribuzione.</td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che vuoi utilizzare. Se specifichi una VLAN, l'indirizzo IP deve essere su quella VLAN. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Imposta su <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Facoltativo: configura un firewall specificando `loadBalancerSourceRanges` nella sezione **spec**. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando viene creato il tuo servizio del programma di bilanciamento del carico, viene automaticamente assegnato un IP indirizzo IP portatile ad esso. Se non è disponibile alcun indirizzo IP portatile, è impossibile creare il servizio del programma di bilanciamento del carico.

3.  Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Output CLI di esempio:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile che è stato assegnato al tuo servizio del programma di bilanciamento del carico.

4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

<br />


## Componenti e architettura del programma di bilanciamento del carico 1.0
{: #planning}

Il programma di bilanciamento del carico TCP/UDP 1.0 utilizza Iptables, una funzione del kernel Linux, per bilanciare il carico delle richieste tra i pod di un'applicazione.

**In che modo viene effettuata una richiesta alla mia applicazione con un programma di bilanciamento del carico versione 1.0 in un cluster a zona singola?**

Il seguente diagramma mostra come un programma di bilanciamento del carico 1.0 indirizza la comunicazione da Internet a un'applicazione.

<img src="images/cs_loadbalancer_planning.png" width="450" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un programma di bilanciamento del carico 1.0" style="width:450px; border-style: none"/>

1. Una richiesta alla tua applicazione usa l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata sul nodo di lavoro.

2. La richiesta viene inoltrata automaticamente alla porta e all'indirizzo IP del cluster interno del servizio di bilanciamento del carico. L'indirizzo IP del cluster interno è accessibile solo all'interno del cluster.

3. `kube-proxy` instrada la richiesta al servizio di bilanciamento del carico Kubernetes per l'applicazione.

4. La richiesta viene inoltrata all'indirizzo IP privato del pod dell'applicazione. L'indirizzo IP di origine del pacchetto di richieste viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, il programma di bilanciamento del carico instrada le richieste tra i pod dell'applicazione.

**In che modo viene effettuata una richiesta alla mia applicazione con un programma di bilanciamento del carico versione 1.0 in un cluster multizona?**

Se hai un cluster multizona, le istanze dell'applicazione vengono distribuite nei pod sui nodi di lavoro tra le diverse zone. Il seguente diagramma mostra come un programma di bilanciamento del carico 1.0 indirizza la comunicazione da Internet a un'applicazione in un cluster multizona.

<img src="images/cs_loadbalancer_planning_multizone.png" width="475" alt="Utilizza un programma di bilanciamento del carico 1.0 per bilanciare il carico delle applicazioni nei cluster multizona" style="width:475px; border-style: none"/>

Per impostazione predefinita, ogni programma di bilanciamento del carico 1.0 viene configurato solo in una zona. Per ottenere l'alta disponibilità, devi distribuire un programma di bilanciamento del carico 1.0 in ogni zona in cui hai istanze dell'applicazione. Le richieste vengono gestite dai programmi di bilanciamento del carico in diverse zone in un ciclo round-robin. Inoltre, ciascun programma di bilanciamento del carico instrada le richieste alle istanze dell'applicazione nella sua zona e alle istanze dell'applicazione nelle altre zone.

<br />


## Configurazione di un programma di bilanciamento del carico 1.0 in un cluster multizona
{: #multi_zone_config}

I servizi del programma di bilanciamento del carico sono disponibili solo per i cluster standard e non supportano la terminazione TLS. Se la tua applicazione richiede la terminazione TLS,
la puoi esporre utilizzando [Ingress](cs_ingress.html) o configurare la tua applicazione per gestire la terminazione TLS.
{: note}

**Prima di iniziare**:
  * Devi distribuire un programma di bilanciamento del carico in ciascuna zona e a ciascun programma di bilanciamento del carico viene assegnato un proprio indirizzo IP in tale zona. Per creare dei programmi di bilanciamento del carico pubblici, almeno una VLAN pubblica deve avere delle sottoreti portatili disponibili in ciascuna zona. Per aggiungere dei servizi di programma di bilanciamento del carico privati, almeno una VLAN privata deve avere delle sottoreti portatili disponibili in ciascuna zona. Per aggiungere sottoreti, vedi [Configurazione delle sottoreti per i cluster](cs_subnets.html).
  * Se limiti il traffico di rete ai nodi di lavoro edge, assicurati che siano abilitati almeno 2 [nodi di lavoro edge](cs_edge.html#edge) in ciascuna zona. Se i nodi di lavoro edge sono abilitati in alcune zone ma non in altre, i programmi di bilanciamento del carico non verranno distribuiti uniformemente. I programmi di bilanciamento del carico verranno distribuiti sui nodi edge in alcune zone ma non sui nodi di lavoro regolari in altre zone.
  * Abilita lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.


Per configurare un servizio del programma di bilanciamento del carico 1.0 in un cluster multizona:
1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico.

2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su Internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
  1. Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.
  2. Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre. Puoi specificare una zona, una VLAN e un indirizzo IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
      ```
      {: codeblock}

      <table>
      <caption>Descrizione dei componenti del file YAML</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotazione per specificare il tipo di programma di bilanciamento del carico. I valori accettati sono <code>private</code> e <code>public</code>. Se crei un programma di bilanciamento del carico pubblico nei cluster che si trovano su VLAN pubbliche, questa annotazione non è richiesta.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotazione per specificare la zona in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le zone, esegui <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta da utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, controlla i valori <em>&lt;selectorkey&gt;</em> e <em>&lt;selectorvalue&gt;</em>. Assicurati che siano gli stessi della coppia <em>chiave/valore</em> che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> del tuo file yaml di distribuzione.</td>
      </tr>
      <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che vuoi utilizzare. Se specifichi una VLAN o una zona, l'indirizzo IP deve essere in quella VLAN o zona. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.</li></ul></td>
      </tr>
      </tbody></table>

      File di configurazione di esempio per creare un servizio del programma di bilanciamento del carico privato 1.0 che utilizza un indirizzo IP specificato sulla VLAN privata `2234945` in `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. Facoltativo: configura un firewall specificando `loadBalancerSourceRanges` nella sezione **spec**. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Crea il servizio nel tuo cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Sostituisci _&lt;myservice&gt;_ con il nome del servizio del programma di bilanciamento del carico che hai creato nel passo precedente. Perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Output CLI di esempio:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile che è stato assegnato al tuo servizio del programma di bilanciamento del carico.

4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. Se scegli di [abilitare la conservazione dell'IP di origine per un servizio del programma di bilanciamento del carico versione 1.0 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assicurati che i pod dell'applicazione siano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](cs_loadbalancer.html#edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.

6. Ripeti i passi precedenti per aggiungere un programma di bilanciamento del carico versione 1.0 in ogni zona.

7. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

## Configurazione di un programma di bilanciamento del carico 1.0 in un cluster a zona singola
{: #config}

Prima di iniziare:

* Questa funzione è disponibile solo per i cluster standard.
* Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio di bilanciamento del carico.

Per creare un servizio del programma di bilanciamento del carico 1.0 in un cluster a zona singola:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico.
2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su Internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
    1.  Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.

    2.  Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare il tipo di programma di bilanciamento del carico. I valori accettati sono `private` e `public`. Se crei un programma di bilanciamento del carico pubblico nei cluster che si trovano su VLAN pubbliche, questa annotazione non è richiesta.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta da utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, controlla i valori <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em>. Assicurati che siano gli stessi della coppia <em>chiave/valore</em> che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> del tuo file yaml di distribuzione.</td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che vuoi utilizzare. Se specifichi una VLAN, l'indirizzo IP deve essere su quella VLAN. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.</li></ul></td>
        </tr>
        </tbody></table>

        File di configurazione di esempio per creare un servizio del programma di bilanciamento del carico privato 1.0 che utilizza un indirizzo IP specificato sulla VLAN privata `2234945`:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3.  Facoltativo: configura un firewall specificando `loadBalancerSourceRanges` nella sezione **spec**. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando viene creato il tuo servizio del programma di bilanciamento del carico, viene automaticamente assegnato un IP indirizzo IP portatile ad esso. Se non è disponibile alcun indirizzo IP portatile, è impossibile creare il servizio del programma di bilanciamento del carico.

3.  Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Output CLI di esempio:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile che è stato assegnato al tuo servizio del programma di bilanciamento del carico.

4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Se scegli di [abilitare la conservazione dell'IP di origine per un servizio del programma di bilanciamento del carico 1.0 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assicurati che i pod dell'applicazione siano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](cs_loadbalancer.html#edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.

6. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

<br />


## Abilitazione della conservazione dell'IP di origine per i programmi di bilanciamento del carico versione 1.0
{: #node_affinity_tolerations}

Questa funzione è disponibile solo per i programmi di bilanciamento del carico versione 1.0. L'indirizzo IP di origine delle richieste del client viene conservato per impostazione predefinita nei programmi di bilanciamento del carico versione 2.0.
{: note}

Quando una richiesta del client alla tua applicazione viene inviata al tuo cluster, un pod del servizio del programma di bilanciamento del carico riceve la richiesta. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, il programma di bilanciamento inoltra la richiesta a un pod dell'applicazione su un nodo di lavoro diverso. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod del servizio del programma di bilanciamento del carico.

Per conservare l'indirizzo IP di origine originale della richiesta client, puoi [abilitare l'IP di origine ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) per i servizi del programma di bilanciamento del carico. La connessione TCP continua fino ai pod dell'applicazione in modo che l'applicazione possa vedere l'indirizzo IP di origine effettivo dell'initiator. La conservazione dell'IP del client è utile quando, ad esempio, i server delle applicazioni devono applicare le politiche di sicurezza e di controllo dell'accesso.

Una volta abilitato l'IP di origine, i pod del servizio di bilanciamento del carico devono inoltrare le richieste solo ai pod dell'applicazione che sono distribuiti nello stesso nodo di lavoro Di norma, i pod del servizio del programma di bilanciamento del carico vengono distribuiti anche ai nodi di lavoro a cui vengono distribuiti i pod dell'applicazione. Tuttavia, ci sono alcune situazioni in cui i pod del bilanciamento del carico e quelli dell'applicazione potrebbero non essere pianificati sullo stesso nodo di lavoro:

* Hai nodi edge corrotti in cui puoi distribuire solo i pod del servizio di bilanciamento del carico. I pod dell'applicazione non possono essere distribuiti in questi nodi.
* Il tuo cluster è connesso a più VLAN pubbliche o private e i tuoi pod dell'applicazione possono essere distribuiti ai nodi di lavoro che sono connessi solo ad una VLAN. I pod del servizio di bilanciamento del carico non possono essere distribuiti in tali nodi di lavoro in quanto l'indirizzo IP del programma di bilanciamento è connesso ad una VLAN diversa da quella dei nodi di lavoro.

Per forzare la tua applicazione alla distribuzione in specifici nodi di lavoro in cui possono essere distribuiti anche i pod del servizio di bilanciamento del carico, devi aggiungere le regole di affinità e le tolleranze alla tua distribuzione dell'applicazione.

### Aggiunta delle regole di affinità e delle tolleranze del nodo edge
{: #edge_nodes}

Quando [etichetti i nodi di lavoro come nodi edge](cs_edge.html#edge_nodes) e inoltre [danneggi i nodi edge](cs_edge.html#edge_workloads), i pod del servizio del programma di bilanciamento del carico vengono distribuiti solo in tali nodi edge e i pod dell'applicazione non possono essere distribuiti nei nodi edge. Quando l'IP di origine viene abilitato per il servizio del programma di bilanciamento del carico, i pod del programma di bilanciamento del carico nei nodi edge non possono inoltrare le richieste in entrata ai tuoi pod dell'applicazione su altri nodi di lavoro.
{:shortdesc}

Per forzare la distribuzione dei tuoi pod dell'applicazione nei nodi edge, aggiungi la [regola di affinità ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) e la [tolleranza ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) del nodo edge alla distribuzione dell'applicazione.

Esempio di file YAML di distribuzione con affinità e tolleranza del nodo edge:

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

Entrambe le sezioni **affinity** e **tolerations** hanno `dedicated` come `key` e `edge` come `value`.

### Aggiunta di regole di affinità per più VLAN pubbliche o private
{: #edge_nodes_multiple_vlans}

Quando il tuo cluster è connesso a più VLAN pubbliche o private, i tuoi pod dell'applicazione possono essere distribuiti solo nei nodi di lavoro connessi ad una VLAN. Se l'indirizzo IP del programma di bilanciamento del carico è connesso ad una VLAN diversa da quella di questi nodi di lavoro, i pod del servizio di bilanciamento del carico non verranno distribuiti in questi nodi di lavoro.
{:shortdesc}

Quando l'IP di origine è abilitato, pianifica i pod dell'applicazione sui nodi di lavoro che si trovano nella stessa VLAN dell'indirizzo IP del programma di bilanciamento del carico aggiungendo una regola di affinità alla distribuzione dell'applicazione.

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Ottieni l'indirizzo IP del servizio del programma di bilanciamento del carico. Ricerca l'indirizzo IP nel campo **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Richiama l'ID VLAN a cui è connesso il tuo servizio del programma di bilanciamento del carico.

    1. Elenca le VLAN pubbliche portatili per il tuo cluster.
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
        ```
        {: pre}

        Output di esempio:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. Nell'output, sotto **Subnet VLANs**, ricerca il CIDR di sottorete che corrisponde all'indirizzo IP del programma di bilanciamento del carico che hai recuperato in precedenza e prendi nota dell'ID VLAN.

        Ad esempio, se l'indirizzo IP del servizio del programma di bilanciamento del carico è `169.36.5.xxx`, la sottorete corrispondente nell'output di esempio del precedente passo è `169.36.5.xxx/29`. L'ID VLAN a cui è connessa la sottorete è `2234945`.

3. [Aggiungi una regola di affinità ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) alla distribuzione dell'applicazione per l'ID VLAN di cui hai preso nota nel passo precedente.

    Ad esempio, se hai più VLAN ma desideri che i tuoi pod dell'applicazione vengano distribuiti solo nei nodi di lavoro presenti sulla VLAN pubblica `2234945`:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    Nel file YAML di esempio, la sezione **affinity** ha `publicVLAN` come `key` e `"2234945"` come `value`.

4. Applica il file di configurazione della distribuzione aggiornato.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. Verifica che i pod dell'applicazione vengano distribuiti nei nodi di lavoro connessi alla VLAN designata.

    1. Elenca i pod nel tuo cluster. Sostituisci `<selector>` con l'etichetta che hai utilizzato per l'applicazione.
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        Output di esempio:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Nell'output, identifica un pod per la tua applicazione. Prendi nota dell'ID **NODE** del nodo di lavoro in cui il pod è attivo.

        Nell'output di esempio del passo precedente, il pod dell'applicazione `cf-py-d7b7d94db-vp8pq` si trova sul nodo di lavoro `10.176.48.78`.

    3. Elenca i dettagli del nodo di lavoro.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        Output di esempio:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. Nella sezione **Labels** dell'output, verifica che la VLAN pubblica o privata sia la VLAN che hai designato nei passi precedenti.
