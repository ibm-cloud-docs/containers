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


# Pianificazione della rete del cluster
{: #planning}

Con {{site.data.keyword.containerlong}}, puoi gestire sia la rete esterna, rendendo le applicazioni accessibili pubblicamente o privatamente, che la rete interna all'interno del tuo cluster.
{: shortdesc}

## Scelta di un servizio NodePort, LoadBalancer o Ingress
{: #external}

Per rendere accessibili esternamente le tue applicazioni da [internet pubblico](#public_access) o da una [rete privata](#private_both_vlans), {{site.data.keyword.containershort_notm}} supporta tre servizi di rete.
{:shortdesc}

**[Servizio NodePort](cs_nodeport.html)** (cluster gratuito e standard)
* Esponi una porta su ogni nodo di lavoro e usa l'indirizzo IP pubblico o privato di qualsiasi nodo di lavoro per accedere al tuo servizio nel cluster. 
* Iptables è una funzione del kernel Linux che bilancia il carico delle richieste tra i pod dell'applicazione, offre un instradamento di rete ad alte prestazioni e fornisce il controllo dell'accesso alla rete.
* Gli indirizzi IP pubblici e privati del nodo di rete non sono permanenti. Quando un nodo di lavoro viene rimosso o ricreato, vengono assegnati al nodo di lavoro un nuovo indirizzo IP pubblico e uno nuovo privato. 
* Il servizio NodePort si rivela migliore per la verifica dell'accesso pubblico o privato. Può anche essere utilizzato se hai bisogno dell'accesso pubblico o privato solo per un breve periodo di tempo. 

**[Servizio LoadBalancer](cs_loadbalancer.html)** (solo cluster standard)
* Ogni cluster standard viene fornito con quattro indirizzi IP pubblici portatili e quattro indirizzi IP privati portatili che puoi utilizzare per creare un programma di bilanciamento del carico TCP/UDP esterno per la tua applicazione.
* Iptables è una funzione del kernel Linux che bilancia il carico delle richieste tra i pod dell'applicazione, offre un instradamento di rete ad alte prestazioni e fornisce il controllo dell'accesso alla rete.
* Gli indirizzi IP pubblici e privati portatili assegnati al programma di bilanciamento del carico sono permanenti e non cambiano quando un nodo di lavoro viene ricreato nel cluster.
* Puoi personalizzare il tuo programma di bilanciamento del carico
esponendo una qualsiasi porta richiesta dalla tua applicazione.

**[Ingress](cs_ingress.html)** (solo cluster
standard)
* Esponi più applicazioni in un cluster creando un ALB HTTP o HTTPS, TCP o UDP esterno. L'ALB usa un punto di ingresso pubblico o privato protetto e univoco per instradare le richieste in entrata alle tue applicazioni. 
* Puoi usare una rotta per esporre più applicazioni nel tuo cluster come servizi. 
* Ingress è composto da tre componenti:
  * La risorsa Ingress definisce
le regole su come instradare e bilanciare il carico delle richieste in entrata per un'applicazione.
  * L'ALB ascolta le richieste di servizio HTTP o HTTPS, TCP o UDP in entrata. Inoltra le richieste tra i pod delle applicazioni in base alle regole che hai definito nella risorsa Ingress.
  * MZLB gestisce tutte le richieste in entrata nelle tue applicazioni e bilancia il carico delle richieste tra gli ALB nelle varie zone. 
* Utilizza Ingress per implementare il tuo ALB con regole di instradamento personalizzate e hai bisogno della terminazione SSL per le tue applicazioni.

Per scegliere il servizio di rete migliore per la tua applicazione, puoi seguire questa struttura ad albero delle decisioni e fare clic su una delle opzioni per iniziare. 

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="Questa immagine ti guida nella scelta della migliore opzione di rete per la tua applicazione. Se questa immagine non viene visualizzata, le informazioni possono ancora essere trovate nella documentazione." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Servizio Nodeport" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="Servizio LoadBalancer" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Servizio Ingress" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## Pianificazione della rete esterna pubblica
{: #public_access}

Quando crei un cluster Kubernetes in {{site.data.keyword.containershort_notm}}, puoi connettere il cluster a una VLAN pubblica. La VLAN pubblica determina l'indirizzo IP pubblico che viene assegnato a ciascun nodo di lavoro, che fornisce a ciascun nodo di lavoro un'interfaccia di rete pubblica.
{:shortdesc}

Per rendere pubblicamente disponibile un'applicazione su internet, puoi creare un servizio NodePort, LoadBalancer o Ingress. Per confrontare ciascun servizio, vedi [Scelta di un servizio NodePort, LoadBalancer o Ingress](#external).

Il seguente diagramma mostra in che modo Kubernetes inoltra il traffico di rete pubblico in {{site.data.keyword.containershort_notm}}.

![{{site.data.keyword.containershort_notm}} architettura Kubernetes](images/networking.png)

*Piano di dati Kubernetes in {{site.data.keyword.containershort_notm}}*

L'interfaccia di rete pubblica dei nodi di lavoro nei cluster gratuito e standard è protetta dalle politiche di rete Calico. Queste politiche bloccano la maggior parte del traffico in entrata per impostazione predefinita. Tuttavia, è consentito il traffico in entrata necessario al funzionamento di Kubernetes, così come le connessioni ai servizi NodePort, LoadBalancer e Ingress. Per ulteriori informazioni su queste politiche, incluso su come modificarle, vedi [Politiche di rete](cs_network_policy.html#network_policies).

<br />


## Pianificazione di una rete esterna privata per la configurazione di una VLAN pubblica e privata
{: #private_both_vlans}

Quando crei un cluster Kubernetes in {{site.data.keyword.containershort_notm}}, devi connettere il tuo cluster a una VLAN privata. La VLAN privata determina l'indirizzo IP privato che viene assegnato a ciascun nodo di lavoro, che fornisce a ciascun nodo di lavoro un'interfaccia di rete privata.
{:shortdesc}

Quando vuoi che le tue applicazioni si connettano solo a una rete privata, puoi usare l'interfaccia di rete privata per i nodi di lavoro nei cluster standard. Tuttavia, quando i tuoi nodi di lavoro sono connessi sia a una VLAN pubblica che a una privata, devi usare anche le politiche di sicurezza Calico per proteggere il tuo cluster da accesso pubblico non desiderato. 

Le seguenti sezioni descrivono le funzionalità tra {{site.data.keyword.containershort_notm}} che puoi usare per esporre le tue applicazioni in una rete privata e proteggere il tuo cluster da accesso pubblico non desiderato. Facoltativamente, puoi anche isolare i carichi di lavoro di rete e connettere il tuo cluster alle risorse in una rete in loco. 

### Esposizione delle tue applicazioni con i servizi di rete privati e protezione del tuo cluster con le politiche di rete Calico
{: #private_both_vlans_calico}

L'interfaccia di rete pubblica per i nodi di rete è protetta dalle [impostazioni della politica di rete Calico predefinite](cs_network_policy.html#default_policy) configurate su ogni nodo di lavoro durante la creazione del cluster. Per impostazione predefinita, tutto il traffico di rete in uscita è consentito per tutti i nodi di lavoro. Il traffico di rete in entrata è bloccato ad eccezione di alcune porte che sono aperte in modo che il traffico di rete possa essere monitorato da IBM e affinché IBM possa installare automaticamente gli aggiornamenti di sicurezza per il master Kubernetes. L'accesso al kubelet del nodo di lavoro è protetto da un tunnel OpenVPN. Per ulteriori informazioni, vedi l'[architettura di {{site.data.keyword.containershort_notm}}](cs_tech.html).

Se esponi le tue applicazioni con un servizio NodePort, un servizio LoadBalancer o un ALB Ingress, le politiche Calico predefinite consentono anche il traffico di rete in entrata da internet a questi servizi. Per rendere accessibile la tua applicazione solo da una rete privata, puoi scegliere di usare solo servizi NodePort, LoadBalancer o Ingress privati e bloccare tutto il traffico pubblico ai servizi.

**NodePort**
* [Crea un servizio NodePort](cs_nodeport.html). In aggiunta all'indirizzo IP pubblico, è disponibile un servizio NodePort nell'indirizzo IP privato di un nodo di lavoro.
* Un servizio NodePort apre una porta su un nodo di lavoro sia sull'indirizzo IP pubblico che in quello privato del nodo di lavoro. Devi usare una [politica di rete ante-DNAT Calico](cs_network_policy.html#block_ingress) per bloccare le NodePorts pubbliche.

**LoadBalancer**
* [Crea un servizio LoadBalancer privato](cs_loadbalancer.html). 
* Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di una porta del nodo pubblica aperta per i nodi di lavoro. Devi usare una [politica di rete ante-DNAT Calico](cs_network_policy.html#block_ingress) per bloccare le porte del nodo pubblico presenti su esso. 

**Ingress**
* Quando crei un cluster, vengono creati automaticamente un ALB Ingress privato e uno pubblico. Poiché l'ALB pubblico viene abilitato e quello privato viene disabilitato per impostazione predefinita, devi [disabilitare l'ALB pubblico](cs_cli_reference.html#cs_alb_configure) e [abilitare l'ALB privato](cs_ingress.html#private_ingress).
* Quindi, [crea un servizio Ingress privato](cs_ingress.html#ingress_expose_private).

Per ulteriori informazioni su ciascun servizio, vedi [Scelta di un servizio NodePort, LoadBalancer o Ingress](#external).

### Facoltativo: isolamento dei carichi di lavoro di rete nei nodi di lavoro edge
{: #private_both_vlans_edge}

I nodi di lavoro edge possono migliorare la sicurezza del tuo cluster consentendo a un minor numero di nodi di lavoro di essere accessibili esternamente e isolando il carico di lavoro della rete. Per assicurarti che i pod Ingress e del programma di bilanciamento del carico vengano distribuiti solo ai nodi di lavoro specificati, [etichetta i nodi di lavoro come nodi edge](cs_edge.html#edge_nodes). Per impedire anche l'esecuzione di altri carichi di lavoro sui nodi edge, [danneggia i nodi edge](cs_edge.html#edge_workloads).

Quindi, usa una [politica di rete ante-DNAT Calico](cs_network_policy.html#block_ingress) per bloccare il traffico verso le porte del nodo pubblico sui cluster che stanno eseguendo i nodi di lavoro edge. Il blocco delle porte del nodo assicura che i nodi di lavoro edge siano gli unici nodi di lavoro a gestire il traffico in entrata.

### Facoltativo: connessione a un database in loco utilizzando la VPN strongSwan
{: #private_both_vlans_vpn}

Per connettere in modo sicuro i tuoi nodi di lavoro e le applicazioni a una rete in loco, puoi impostare un [servizio VPN IPSec strongSwan ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.strongswan.org/about.html). Il servizio VPN IPSec strongSwan fornisce un canale di comunicazione end-to-end protetto su Internet basato sulla suite di protocolli IPSec (Internet Protocol Security) standard del settore. Per configurare una connessione sicura tra il tuo cluster e una rete in loco, [configura e distribuisci il servizio VPN IPSec strongSwan](cs_vpn.html#vpn-setup) direttamente in un pod nel tuo cluster.

<br />


## Pianificazione di una rete esterna privata per la configurazione di una VLAN solamente privata
{: #private_vlan}

Quando crei un cluster Kubernetes in {{site.data.keyword.containershort_notm}}, devi connettere il tuo cluster a una VLAN privata. La VLAN privata determina l'indirizzo IP privato che viene assegnato a ciascun nodo di lavoro, che fornisce a ciascun nodo di lavoro un'interfaccia di rete privata.
{:shortdesc}

Quando i tuoi nodi di lavoro sono connessi solo a una VLAN privata, puoi usare l'interfaccia di rete privata affinché i nodi di lavoro mantengano connesse le applicazioni solo alla rete privata. Puoi quindi usare un'applicazione gateway per proteggere il tuo cluster da accesso pubblico non desiderato. 

Le seguenti sezioni descrivono le funzionalità tra {{site.data.keyword.containershort_notm}} che puoi usare per proteggere il tuo cluster da accesso pubblico non desiderato, esporre le tue applicazioni in una rete privata e connetterti alle risorse in una rete in loco. 

### Configurazione di un'applicazione gateway
{: #private_vlan_gateway}

Se i nodi di lavoro sono impostati solo con una VLAN privata, devi configurare una soluzione alternativa per la connettività di rete. Puoi configurare un firewall con politiche di rete personalizzate per fornire una sicurezza di rete dedicata per il tuo cluster standard e per rilevare e risolvere intrusioni di rete. Ad esempio, puoi scegliere di configurare un [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) o un [Fortigate Security Appliance](/docs/infrastructure/fortigate-10g/about.html) in modo che funga da firewall e blocchi il traffico non desiderato. Quando configuri un firewall, [devi anche aprire le porte e gli indirizzi IP necessari](cs_firewall.html#firewall_outbound) per ogni regione in modo che il master e i nodi di lavoro possano comunicare. 

**Nota**: se hai un'applicazione router esistente e aggiungi quindi un cluster, le nuove sottoreti portatili ordinate per il cluster non sono configurate sull'applicazione router. Per poter usare i servizi di rete, devi abilitare l'instradamento tra le sottoreti sulla stessa VLAN [abilitando lo spanning delle VLAN](cs_subnets.html#vra-routing).

### Esposizione delle tue applicazioni con i servizi di rete privati
{: #private_vlan_services}

Per rendere accessibile la tua applicazione solo da una rete privata, puoi usare i servizi NodePort, LoadBalancer o Ingress privati. Poiché i tuoi nodi di lavoro non sono connessi a una VLAN pubblica, a questi servizi non viene instradato alcun traffico pubblico. 

**NodePort**:
* [Crea un servizio NodePort privato](cs_nodeport.html). Il servizio è disponibile su un indirizzo IP privato di un nodo di lavoro. 
* Nel tuo firewall privato, apri la porta che hai configurato quando hai distribuito il servizio agli indirizzi IP privati per tutti i nodi di lavoro verso cui consentire il traffico. Per trovare la porta, esegui `kubectl get svc`. La porta è compresa nell'intervallo 20000-32000.

**LoadBalancer**
* [Crea un servizio LoadBalancer privato](cs_loadbalancer.html). Se il tuo cluster è disponibile solo su una VLAN privata, viene utilizzato uno dei quattro indirizzi IP privati portatili disponibili.
* Nel tuo firewall privato, apri la porta che hai configurato quando hai distribuito il servizio all'indirizzo IP privato del servizio del programma di bilanciamento del carico. 

**Ingress**:
* Quando crei un cluster, viene creato automaticamente un ALB Ingress privato ma non viene abilitato per impostazione predefinita. Devi [abilitare l'ALB privato](cs_ingress.html#private_ingress).
* Quindi, [crea un servizio Ingress privato](cs_ingress.html#ingress_expose_private).
* Nel tuo firewall privato, apri la porta 80 per HTTP o la porta 443 per HTTPS per l'indirizzo IP relativo all'ALB privato.


Per ulteriori informazioni su ciascun servizio, vedi [Scelta di un servizio NodePort, LoadBalancer o Ingress](#external).

### Facoltativo: connessione a un database in loco utilizzando l'applicazione gateway
{: #private_vlan_vpn}

Per connettere in modo sicuro i tuoi nodi di lavoro e le applicazioni a una rete in loco, devi configurare un gateway VPN. Puoi usare il [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) o il [Fortigate Security Appliance (FSA)](/docs/infrastructure/fortigate-10g/about.html) che hai configurato come firewall per configurare anche un endpoint VPN IPSec. Per configurare un VRA, vedi [Configurazione della connettività VPN con VRA](cs_vpn.html#vyatta).

<br />


## Pianificazione della rete in cluster
{: #in-cluster}

A tutti i pod che vengono distribuiti in un nodo di lavoro viene assegnato un indirizzo IP privato nell'intervallo 172.30.0.0/16 e vengono instradati solo tra i nodi di lavoro. Per evitare conflitti, non utilizzare questo intervallo di IP sui nodi che comunicano con i tuoi nodi di lavoro. I nodi di lavoro e i pod possono comunicare in modo sicuro sulla rete privata utilizzando indirizzi IP privati. Tuttavia, quando un pod ha un arresto anomalo o un nodo di lavoro deve essere ricreato, viene assegnato un nuovo
indirizzo IP.

Per impostazione predefinita, è difficile tenere traccia degli indirizzi IP privati mutevoli per le applicazioni che devono essere ad alta disponibilità. Puoi invece utilizzare le funzioni di rilevamento integrate del servizio Kubernetes per esporre le applicazioni come servizi IP cluster sulla rete privata. Un servizio Kubernetes raggruppa un insieme di pod e fornisce una connessione di rete a questi pod per altri servizi nel cluster senza esporre l'effettivo indirizzo IP privato di ciascun pod. Ai servizi viene assegnato un indirizzo IP in cluster accessibile solo all'interno del cluster. 
* **Cluster più vecchi**: nei cluster creati prima del febbraio 2018 nella zona dal13 o prima dell'ottobre 2017 in qualsiasi altra zona, ai servizi viene assegnato un IP tra i 254 IP dell'intervallo 10.10.10.0/24. Se hai raggiunto il limite di 254 e hai bisogno di altri servizi, devi creare un nuovo cluster.
* **Cluster più recenti**: nei cluster creati dopo il febbraio 2018 nella zona dal13 o dopo l'ottobre 2017 in qualsiasi altra zona, ai servizi viene assegnato un IP tra i 65.000 IP dell'intervallo 172.21.0.0/16. 

Per evitare conflitti, non utilizzare questo intervallo di IP sui nodi che comunicano con i tuoi nodi di lavoro. Viene creata anche una voce di ricerca DNS per il servizio e viene memorizzata nel componente `kube-dns` del cluster. La voce DNS contiene il nome del servizio,
lo spazio dei nomi in cui è stato creato il servizio e il link all'indirizzo IP in cluster assegnato.

Per accedere a un pod che si trova dietro un servizio IP cluster, le applicazioni possono usare l'indirizzo IP in cluster del servizio o inviare una richiesta utilizzando il nome del servizio. Quando usi il nome del servizio, il nome viene ricercato nel componente `kube-dns` e instradato all'indirizzo IP in cluster del servizio. Quando una richiesta raggiunge il servizio,
questo si assicura che tutte le richieste siano ugualmente inoltrate ai pod, indipendentemente dai loro indirizzi in cluster e dal nodo di lavoro in cui sono distribuiti.
