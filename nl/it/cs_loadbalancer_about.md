---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb

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
{:preview: .preview}



# Informazioni sugli NLB
{: #loadbalancer-about}

Quando crei un cluster standard, {{site.data.keyword.containerlong}} esegue automaticamente il provisioning di una sottorete pubblica portatile e di una sottorete privata portatile.
{: shortdesc}

* La sottorete pubblica portatile fornisce 5 indirizzi IP utilizzabili. 1 indirizzo IP pubblico portatile è utilizzato dall'[ALB Ingress pubblico](/docs/containers?topic=containers-ingress) predefinito. I restanti 4 indirizzi IP pubblici portatili possono essere usati per esporre singole applicazioni su Internet creando servizi NLB (network load balancer).
* La sottorete privata portatile fornisce 5 indirizzi IP utilizzabili. 1 indirizzo IP privato portatile è utilizzato dall'[ALB Ingress privato](/docs/containers?topic=containers-ingress#private_ingress). I restanti 4 indirizzi IP privati portatili possono essere usati per esporre le singole applicazioni su una rete privata creando servizi NLB (network load balancer) privati.

Gli indirizzi IP pubblici e privati portatili sono IP mobili statici e non cambiano quando viene rimosso un nodo di lavoro. Se il nodo di lavoro su cui si trova l'indirizzo IP NLB viene rimosso, un daemon Keepalive, che monitora costantemente l'IP, sposta automaticamente l'IP in un altro nodo di lavoro. Puoi assegnare qualsiasi porta al tuo NLB. Il servizio NLB funge da punto di ingresso esterno per le richieste in entrata per l'applicazione. Per accedere all'NLB da Internet, puoi utilizzare l'indirizzo IP pubblico del tuo NLB e la porta assegnata nel formato `<IP_address>:<port>`. È anche possibile creare delle voci DNS per gli NLB registrando gli indirizzi IP NLB con i nomi host.

Quando esponi un'applicazione con un servizio NLB, la tua applicazione viene automaticamente resa disponibile anche sulle NodePort del servizio. Le [NodePort](/docs/containers?topic=containers-nodeport) sono accessibili su ogni indirizzo IP pubblico e privato di ogni nodo di lavoro all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un NLB, vedi [Controllo del traffico in entrata nei servizi NLB (network load balancer) o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Confronto del bilanciamento del carico di base e DSR negli NLB versione 1.0 e 2.0
{: #comparison}

Quando crei un NLB, puoi scegliere un NLB versione 1.0, che esegue un bilanciamento del carico di base, oppure un NLB versione 2.0, che esegue un bilanciamento del carico DSR (direct server return). Nota che gli NLB versione 2.0 sono beta.
{: shortdesc}

**In cosa gli NLB versioni 1.0 e 2.0 sono simili?**

Gli NLB versione 1.0 e 2.0 sono entrambi programmi di bilanciamento del carico di livello 4 che esistono nello spazio del kernel Linux. Entrambe le versioni vengono eseguite all'interno del cluster e utilizzano le risorse del nodo di lavoro. Pertanto, la capacità disponibile degli NLB è sempre dedicata al tuo cluster. Inoltre, entrambe le versioni degli NLB non terminano la connessione. Al contrario, inoltrano le connessioni a un pod dell'applicazione.

**In cosa gli NLB versioni 1.0 e 2.0 sono diversi?**

Quando un client invia una richiesta alla tua applicazione, l'NLB instrada i pacchetti della richiesta all'indirizzo IP del nodo di lavoro in cui è presente un pod dell'applicazione. Gli NLB versione 1.0 utilizzano la NAT (Network Address Translation) per riscrivere l'indirizzo IP di origine del pacchetto della richiesta sull'IP del nodo di lavoro in cui è presente un pod del programma di bilanciamento del carico. Quando il nodo di lavoro restituisce il pacchetto di risposta dell'applicazione, utilizza l'IP del nodo di lavoro in cui è presente l'NLB. L'NLB deve quindi inviare il pacchetto di risposta al client. Per evitare che l'indirizzo IP venga riscritto, puoi [abilitare la conservazione dell'IP di origine](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations). Tuttavia, la conservazione dell'IP di origine richiede che i pod del programma di bilanciamento del carico e i pod dell'applicazione vengano eseguiti sullo stesso nodo di lavoro in modo che la richiesta non debba essere inoltrata a un altro nodo di lavoro. Devi aggiungere l'affinità e le tolleranze del nodo ai pod dell'applicazione. Per ulteriori informazioni sul bilanciamento del carico di base con gli NLB versione 1.0, vedi [v1.0: Componenti e architettura del bilanciamento del carico di base](#v1_planning).

A differenza degli NLB versione 1.0, gli NLB versione 2.0 non utilizzano NAT durante l'inoltro delle richieste ai pod dell'applicazione su altri nodi di lavoro. Quando un
NLB 2.0 instrada una richiesta del client, utilizza l'IPIP (IP over IP) per incapsulare il pacchetto della richiesta originale in un altro pacchetto. Questo pacchetto IPIP di incapsulamento ha un IP di origine del nodo di lavoro in cui si trova il pod del programma di bilanciamento del carico, che consente al pacchetto di richiesta originale di conservare l'IP del client come proprio indirizzo IP di origine. Il nodo di lavoro utilizza quindi il DSR (direct server return) per inviare il pacchetto di risposta dell'applicazione all'IP del client. Il pacchetto di risposta ignora l'NLB e viene inviato direttamente al client, riducendo la quantità di traffico che deve essere gestita dall'NLB. Per ulteriori informazioni sul bilanciamento del carico DSR con gli NLB versione 2.0, vedi [v2.0: Componenti e architettura del bilanciamento del carico DSR](#planning_ipvs).

<br />


## Componenti e architettura di un NLB 1.0
{: #v1_planning}

L'NLB (network load balancer) TCP/UDP 1.0 utilizza Iptables, una funzione del kernel Linux, per bilanciare il carico delle richieste tra i pod di un'applicazione.
{: shortdesc}

### Flusso del traffico in un cluster a zona singola
{: #v1_single}

Il seguente diagramma mostra in che modo un NLB 1.0 indirizza le comunicazioni da Internet a un'applicazione in un cluster a zona singola.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} attraverso un NLB 1.0" style="width:410px; border-style: none"/>

1. Una richiesta alla tua applicazione usa l'indirizzo IP pubblico del tuo NLB e la porta assegnata sul nodo di lavoro.

2. La richiesta viene inoltrata automaticamente alla porta e all'indirizzo IP del cluster interno del servizio NLB. L'indirizzo IP del cluster interno è accessibile solo all'interno del cluster.

3. `kube-proxy` instrada la richiesta al servizio NLB per l'applicazione.

4. La richiesta viene inoltrata all'indirizzo IP privato del pod dell'applicazione. L'indirizzo IP di origine del pacchetto di richieste viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, il servizio NLB instrada le richieste tra i pod dell'applicazione.

### Flusso del traffico in un cluster multizona
{: #v1_multi}

Il seguente diagramma mostra in che modo un NLB (Network load balancer) 1.0 indirizza le comunicazioni da Internet a un'applicazione in un cluster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Utilizza un NLB 1.0 per bilanciare il carico delle applicazioni neicluster multizona" style="width:500px; border-style: none"/>

Per impostazione predefinita, ogni NLB 1.0 è configurato in una sola zona. Per ottenere l'alta disponibilità, devi distribuire un NLB 1.0 in ciascuna zona in cui hai istanze dell'applicazione. Le richieste vengono gestite dagli NLB in varie zone in un ciclo round-robin. Inoltre, ciascun NLB instrada le richieste alle istanze dell'applicazione nella propria zona e quelle delle altre zone.

<br />


## Componenti e architettura di un NLB 2.0 (beta)
{: #planning_ipvs}

Le funzionalità NLB (network load balancer) 2.0 sono in versione beta. Per utilizzare un NLB versione 2.0, devi [aggiornare i nodi master e di lavoro del tuo cluster](/docs/containers?topic=containers-update) a Kubernetes versione 1.12 o successive.
{: note}

L'NLB 2.0 è un programma di bilanciamento del carico di livello 4 che utilizza l'IPVS (IP Virtual Server) del kernel Linux. L'NLB 2.0 supporta TCP e UDP, viene eseguito per più nodi di lavoro e utilizza il tunneling IPIP (IP over IP) per distribuire il traffico che arriva a un singolo indirizzo IP
dell'NLB tra quei nodi di lavoro.

Vuoi maggiori dettagli sui modelli di distribuzione del bilanciamento del carico disponibili in {{site.data.keyword.containerlong_notm}}? Consulta questo [post del blog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/).
{: tip}

### Flusso del traffico in un cluster a zona singola
{: #ipvs_single}

Il seguente diagramma mostra in che modo un NLB 2.0 indirizza le comunicazioni da Internet a un'applicazione in un cluster a zona singola.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un NLB versione 2.0" style="width:600px; border-style: none"/>

1. Una richiesta client alla tua applicazione usa l'indirizzo IP pubblico del tuo NLB e la porta assegnata sul nodo di lavoro. In questo esempio, l'NLB ha l'indirizzo IP virtuale 169.61.23.130, che attualmente si trova sul nodo di lavoro 10.73.14.25.

2. L'NLB incapsula il pacchetto della richiesta del client (etichettato come "CR" nell'immagine) all'interno di un pacchetto IPIP (etichettato come "IPIP"). Il pacchetto di richiesta del client mantiene l'IP del client come proprio indirizzo IP di origine. Il pacchetto di incapsulamento IPIP utilizza l'IP 10.73.14.25 del nodo di lavoro come proprio indirizzo IP di origine.

3. L'NLB instrada il pacchetto IPIP a un nodo di lavoro su cui si trova un pod dell'applicazione, 10.73.14.26. Se nel cluster vengono distribuite più istanze dell'applicazione, l'NLB instrada le richieste tra i nodi di lavoro in cui sono distribuiti i pod dell'applicazione.

4. Il nodo di lavoro 10.73.14.26 decomprime il pacchetto di incapsulamento IPIP e quindi decomprime il pacchetto di richiesta del client. Il pacchetto di richiesta del client viene inoltrato al pod dell'applicazione su quel nodo di lavoro.

5. Il nodo di lavoro 10.73.14.26 utilizza quindi l'indirizzo IP di origine dal pacchetto di richiesta originale, l'IP del client, per restituire il pacchetto di risposta del pod dell'applicazione direttamente al client.

### Flusso del traffico in un cluster multizona
{: #ipvs_multi}

Il flusso del traffico attraverso un cluster multizona segue lo stesso percorso del [traffico attraverso un cluster a zona singola](#ipvs_single). In un cluster multizona, l'NLB instrada le richieste alle istanze dell'applicazione nella propria zona e in altre zone. Il seguente diagramma mostra in che modo gli NLB versione 2.0 indirizzano in ciascuna zona il traffico da Internet a un'applicazione in un cluster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} attraverso un NLB 2.0" style="width:500px; border-style: none"/>

Per impostazione predefinita, ciascun NLB versione 2.0 viene configurato solo in una zona. Puoi ottenere una maggiore disponibilità distribuendo un NLB versione 2.0 in ciascuna zona in cui hai istanze dell'applicazione.
