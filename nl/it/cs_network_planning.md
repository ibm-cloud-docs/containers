---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Pianificazione per esporre le tue applicazioni con la rete esterna
{: #planning}

Con {{site.data.keyword.containerlong}}, puoi gestire la rete esterna rendendo le applicazioni accessibili in modo pubblico o privato.
{: shortdesc}

## Scelta di un servizio NodePort, LoadBalancer o Ingress
{: #external}

Per rendere accessibili esternamente le tue applicazioni da Internet pubblico o da una rete privata, {{site.data.keyword.containerlong_notm}} supporta tre servizi di rete.
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

Quando crei un cluster Kubernetes in {{site.data.keyword.containerlong_notm}}, puoi connettere il cluster a una VLAN pubblica. La VLAN pubblica determina l'indirizzo IP pubblico che viene assegnato a ciascun nodo di lavoro, che fornisce a ciascun nodo di lavoro un'interfaccia di rete pubblica.
{:shortdesc}

Per rendere pubblicamente disponibile un'applicazione su Internet, puoi creare un servizio NodePort, LoadBalancer o Ingress. Per confrontare ciascun servizio, vedi [Scelta di un servizio NodePort, LoadBalancer o Ingress](#external).

Il seguente diagramma mostra in che modo Kubernetes inoltra il traffico di rete pubblico in {{site.data.keyword.containerlong_notm}}.

![{{site.data.keyword.containerlong_notm}} architettura Kubernetes](images/networking.png)

*Piano di dati Kubernetes in {{site.data.keyword.containerlong_notm}}*

L'interfaccia di rete pubblica dei nodi di lavoro nei cluster gratuito e standard è protetta dalle politiche di rete Calico. Queste politiche bloccano la maggior parte del traffico in entrata per impostazione predefinita. Tuttavia, è consentito il traffico in entrata necessario al funzionamento di Kubernetes, così come le connessioni ai servizi NodePort, LoadBalancer e Ingress. Per ulteriori informazioni su queste politiche, incluso su come modificarle, vedi [Politiche di rete](cs_network_policy.html#network_policies).

Per ulteriori informazioni sulla configurazione del tuo cluster per la rete, incluse le informazioni sulle sottoreti, sui firewall e sulle VPN, vedi [Pianificazione della rete cluster predefinita](cs_network_cluster.html#both_vlans).

<br />


## Pianificazione di una rete esterna privata per la configurazione di una VLAN pubblica e privata
{: #private_both_vlans}

Quando i tuoi nodi di lavoro sono connessi sia a una VLAN pubblica che a una VLAN privata, puoi rendere la tua applicazione accessibile da una rete privata solo creando dei servizi NodePort, LoadBalancer o Ingress privati. Puoi quindi creare delle politiche Calico per bloccare il traffico pubblico ai servizi.

**NodePort**
* [Crea un servizio NodePort](cs_nodeport.html). In aggiunta all'indirizzo IP pubblico, è disponibile un servizio NodePort nell'indirizzo IP privato di un nodo di lavoro.
* Un servizio NodePort apre una porta su un nodo di lavoro sia sull'indirizzo IP pubblico che in quello privato del nodo di lavoro. Devi usare una [politica di rete preDNAT Calico](cs_network_policy.html#block_ingress) per bloccare le NodePorts pubbliche.

**LoadBalancer**
* [Crea un servizio LoadBalancer privato](cs_loadbalancer.html).
* Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di una porta del nodo pubblica aperta per i nodi di lavoro. Devi usare una [politica di rete preDNAT Calico](cs_network_policy.html#block_ingress) per bloccare le porte del nodo pubblico presenti su esso.

**Ingress**
* Quando crei un cluster, vengono creati automaticamente un ALB Ingress privato e uno pubblico. Poiché l'ALB pubblico viene abilitato e quello privato viene disabilitato per impostazione predefinita, devi [disabilitare l'ALB pubblico](cs_cli_reference.html#cs_alb_configure) e [abilitare l'ALB privato](cs_ingress.html#private_ingress).
* Quindi, [crea un servizio Ingress privato](cs_ingress.html#ingress_expose_private).

Per fare un esempio, supponiamo che hai creato un servizio di programma di bilanciamento del carico privato. Hai anche creato una politica preDNAT Calico per impedire al traffico pubblico di raggiungere le NodePort pubbliche aperte dal programma di bilanciamento del carico. A questo programma di bilanciamento del carico privato possono accedere:
* Qualsiasi pod in quello stesso cluster
* Qualsiasi pod in qualsiasi cluster nello stesso account IBM Cloud
* Se hai lo [spanning VLAN abilitato](cs_subnets.html#subnet-routing), qualsiasi sistema connesso a una qualsiasi delle VLAN private nello stesso account IBM Cloud
* Se non sei nell'account IBM Cloud ma ancora dietro il firewall aziendale, qualsiasi sistema tramite una connessione VPN alla sottorete su cui si trova l'IP del programma di bilanciamento del carico
* Se sei in un account IBM Cloud differente, qualsiasi sistema tramite una connessione VPN alla sottorete su cui si trova l'IP del programma di bilanciamento del carico

Per ulteriori informazioni sulla configurazione del tuo cluster per la rete, incluse le informazioni sulle sottoreti, sui firewall e sulle VPN, vedi [Pianificazione della rete cluster predefinita](cs_network_cluster.html#both_vlans).

<br />


## Pianificazione di una rete esterna privata per la configurazione di solo una VLAN privata
{: #private_vlan}

Quando i tuoi nodi di lavoro sono connessi solo a una VLAN privata, puoi rendere la tua applicazione accessibile da una rete privata solo creando dei servizi NodePort, LoadBalancer o Ingress privati. Poiché i tuoi nodi di lavoro non sono connessi a una VLAN pubblica, a questi servizi non viene instradato alcun traffico pubblico.

**NodePort**:
* [Crea un servizio NodePort privato](cs_nodeport.html). Il servizio è disponibile su un indirizzo IP privato di un nodo di lavoro.
* Nel tuo firewall privato, apri la porta che hai configurato quando hai distribuito il servizio agli indirizzi IP privati per tutti i nodi di lavoro verso cui consentire il traffico. Per trovare la porta, esegui `kubectl get svc`. La porta è compresa nell'intervallo 20000-32000.

**LoadBalancer**
* [Crea un servizio LoadBalancer privato](cs_loadbalancer.html). Se il tuo cluster è disponibile solo su una VLAN privata, viene utilizzato uno dei quattro indirizzi IP privati portatili disponibili.
* Nel tuo firewall privato, apri la porta che hai configurato quando hai distribuito il servizio all'indirizzo IP privato del servizio del programma di bilanciamento del carico.

**Ingress**:
* Devi configurare un [servizio DNS che sia disponibile sulla rete privata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
* Quando crei un cluster, viene creato automaticamente un ALB Ingress privato ma non viene abilitato per impostazione predefinita. Devi [abilitare l'ALB privato](cs_ingress.html#private_ingress).
* Quindi, [crea un servizio Ingress privato](cs_ingress.html#ingress_expose_private).
* Nel tuo firewall privato, apri la porta 80 per HTTP o la porta 443 per HTTPS per l'indirizzo IP relativo all'ALB privato.

Per ulteriori informazioni sulla configurazione del tuo cluster per la rete, comprese le informazioni su sottoreti e applicazioni gateway, vedi [Pianificazione di una rete per la configurazione di solo una VLAN privata](cs_network_cluster.html#private_vlan).
