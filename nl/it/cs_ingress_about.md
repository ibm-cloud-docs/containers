---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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



# Informazioni sugli ALB Ingress
{: #ingress-about}

Ingress è un servizio Kubernetes che bilancia i carichi di lavoro del traffico di rete nel tuo cluster inoltrando le richieste pubbliche o private alle tue applicazioni. Puoi utilizzare Ingress per esporre più servizi dell'applicazione ad una rete pubblica o privata utilizzando una rotta pubblica o privata univoca.
{: shortdesc}

## Cosa viene fornito con Ingress?
{: #ingress_components}

Ingress consiste in tre componenti: risorse Ingress, ALB (application load balancer) e MZLB (multizone load balancer).
{: shortdesc}

### Risorsa Ingress
{: #ingress-resource}

Per esporre un'applicazione utilizzando Ingress, devi creare un servizio Kubernetes per la tua applicazione e registrare questo servizio con Ingress definendo una risorsa Ingress. La risorsa Ingress è una risorsa Kubernetes che definisce le regole su come instradare le richieste in entrata per le applicazioni. La risorsa Ingress specifica anche il percorso ai tuoi servizi dell'applicazione che vengono accodati all'instradamento pubblico per formare un URL applicazione univoco come ad esempio `mycluster.us-south.containers.appdomain.cloud/myapp1`.
{: shortdesc}

È richiesta una risorsa Ingress per ogni spazio dei nomi in cui hai le applicazioni che vuoi esporre.
* Se le applicazioni nel tuo cluster si trovano tutte nello stesso spazio dei nomi, è richiesta una risorsa Ingress per definire le regole di instradamento per le applicazioni che sono esposte lì. Nota: se vuoi utilizzare domini differenti per le applicazioni all'interno dello stesso spazio dei nomi, puoi utilizzare un carattere jolly per specificare più host di dominio secondario all'interno di una singola risorsa.
* Se le applicazioni nel tuo cluster si trovano in spazi dei nomi differenti, devi creare una risorsa per ogni spazio dei nomi per definire le regole per le applicazioni che sono esposte lì. Devi utilizzare un dominio jolly e specificare un dominio secondario differente in ogni risorsa Ingress.

Per ulteriori informazioni, vedi [Pianificazione della rete per spazi dei nomi singoli o multipli](/docs/containers?topic=containers-ingress#multiple_namespaces).

A partire dal 24 maggio 2018, il formato del dominio secondario Ingress è cambiato per i nuovi cluster. Il nome della regione o della zona incluso nel nuovo formato del dominio secondario viene generato in base alla zona in cui è stato creato il cluster. Se hai dipendenze pipeline sui nomi dominio dell'applicazione coerenti, puoi usare il tuo dominio personalizzato invece del dominio secondario Ingress fornito da IBM.
{: note}

* A tutti i cluster creati dopo il 24 maggio 2018 viene assegnato un dominio secondario nel nuovo formato, `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`.
* I cluster a zona singola creati dopo il 24 maggio 2018 continuano a usare il dominio secondario assegnato nel vecchio formato, `<cluster_name>.<region>.containers.mybluemix.net`.
* Se modifichi un cluster a zona singola creato prima del 24 maggio 2018 in uno multizona [aggiungendo una zona al cluster](/docs/containers?topic=containers-add_workers#add_zone) per la prima volta, il cluster continua a utilizzare il dominio secondario assegnato nel vecchio formato, `<cluster_name>.<region>.containers.mybluemix.net`, e gli viene anche assegnato un dominio secondario nel nuovo formato, `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. Possono essere utilizzati entrambi i domini secondari.

### ALB (application load balancer)
{: #alb-about}

L'ALB (application load balancer) è un programma di bilanciamento del carico esterno che ascolta le richieste di servizio HTTP, HTTPS o TCP in entrata. L'ALB inoltra quindi le richieste al pod dell'applicazione appropriato in base alle regole definire nella risorsa Ingress.
{: shortdesc}

Quando crei un cluster standard, {{site.data.keyword.containerlong_notm}} crea automaticamente un ALB altamente disponibile per il tuo cluster e gli assegna una rotta pubblica univoca. La rotta pubblica è collegata a un indirizzo IP pubblico portatile che viene fornito nel tuo account dell'infrastruttura IBM Cloud durante la creazione del cluster. Viene inoltre creato automaticamente un ALB privato predefinito, ma non viene automaticamente abilitato.

**Cluster multizona**: quando aggiungi una zona al tuo cluster, viene aggiunta una sottorete pubblica portatile e viene creato e abilitato automaticamente un nuovo ALB pubblico sulla sottorete in tale zona. Tutti gli ALB pubblici predefiniti nel tuo cluster condividono una rotta pubblica ma hanno indirizzi IP diversi. In ciascuna zona viene creato automaticamente anche un ALB privato predefinito, ma non viene abilitato automaticamente.

### Programma di bilanciamento del carico multizona (o MZLB, multizone load balancer)
{: #mzlb}

**Cluster multizona**: ogni volta che crei un cluster multizona o [aggiungi una zona a un cluster a zona singola,](/docs/containers?topic=containers-add_workers#add_zone), viene automaticamente creato e distribuito un programma di bilanciamento del carico di lavoro (o MZLB, multizone load balancer) Cloudflare in modo che esista 1 MZLB per ciascuna regione. L'MZLB mette gli indirizzi IP dei tuoi ALB dietro lo stesso dominio secondario e abilita i controlli dell'integrità su tali indirizzi IP per determinare se sono disponibili o meno.

Ad esempio, se hai dei nodi di lavoro in 3 zone nella regione Stati Uniti Est, il dominio secondario `yourcluster.us-east.containers.appdomain.cloud` ha 3 indirizzi IP ALB. L'MZLB controlla l'integrità dell'IP ALB pubblico in ciascuna zona di una regione e tiene i risultati della ricerca DNS aggiornati in base a tali controlli dell'integrità. Ad esempio, se i tuoi ALB hanno gli indirizzi IP `1.1.1.1`, `2.2.2.2` e `3.3.3.3`, una normale operazione di ricerca DNS del tuo dominio secondario Ingress restituisce tutti e 3 gli IP; il client accede a uno di essi in modo casuale. Se l'ALB con indirizzo IP `3.3.3.3` diventa per un qualsiasi motivo non disponibile, ad esempio a causa di un malfunzionamento di zona, il controllo dell'integrità per tale zona non riesce, l'MZLB rimuove l'IP non riuscito dal dominio secondario e la ricerca DNS restituisce solo gli IP ALB `1.1.1.1` e `2.2.2.2` integri. Il dominio secondario ha un TTL (time to live) di 30 secondi; pertanto, dopo 30 secondi, le nuove applicazioni client possono accedere solo a uno degli IP ALB integri disponibili.

In rari casi, alcune applicazioni client o alcuni resolver DNS potrebbero continuare a utilizzare l'IP ALB non integro dopo il TTL di 30 secondi. Tali applicazioni client potrebbero riscontrare un tempo di carico più lungo finché non abbandonano l'IP `3.3.3.3` e provano a connettersi a `1.1.1.1` o `2.2.2.2`. A seconda delle impostazioni del browser client o dell'applicazione client, il ritardo può andare dai pochi secondi a un timeout TCP completo.

I programmi di bilanciamento del carico MZLB per gli ALB pubblici usano solo il dominio secondario Ingress fornito da IBM. Se usi solo ALB privati, devi controllare manualmente l'integrità degli ALB e aggiornare i risultati di ricerca DNS. Se usi ALB pubblici che usano un dominio personalizzato, puoi includere gli ALB nel bilanciamento del carico di MZLB creando un CNAME nella tua voce DNS per inoltrare le richieste dal tuo dominio personalizzato al dominio secondario Ingress fornito da IBM per il tuo cluster.

Se usi politiche di rete pre-DNAT di Calico per bloccare tutto il traffico in entrata ai servizi Ingress, devi anche inserire in whitelist gli [IP IPv4 di Cloudflare![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.cloudflare.com/ips/) per controllare l'integrità dei tuoi ALB. Per la procedura su come creare una politica Calico pre-DNAT per inserire in whitelist questi IP, vedi la [lezione 3 dell'esercitazione della politica di rete Calico](/docs/containers?topic=containers-policy_tutorial#lesson3).
{: note}

<br />


## Come vengono assegnati gli IP agli ALB Ingress?
{: #ips}

Quando crei un cluster standard, {{site.data.keyword.containerlong_notm}} esegue automaticamente il provisioning di una sottorete pubblica portatile e di una sottorete privata portatile. Per impostazione predefinita, il cluster utilizza automaticamente:
* 1 indirizzo IP pubblico portatile dalla sottorete pubblica portatile per l'ALB Ingress pubblico predefinito.
* 1 indirizzo IP privato portatile dalla sottorete privata portatile per l'ALB Ingress privato predefinito.
{: shortdesc}

Se hai un cluster multizona, un ALB pubblico predefinito e un ALB privato predefinito vengono creati automaticamente in ogni zona. Gli indirizzi IP dei tuoi ALB pubblici predefiniti sono tutti dietro lo stesso dominio secondario fornito da IBM per il tuo cluster.

Gli indirizzi IP pubblici e privati portatili sono IP mobili statici e non cambiano quando viene rimosso un nodo di lavoro. Se il nodo di lavoro viene rimosso, un daemon `Keepalived`, che monitora costantemente l'IP, ripianifica automaticamente i pod ALB che si trovavano in quel nodo di lavoro su un altro nodo di lavoro in tale zona. I pod ALB ripianificati conservano lo stesso indirizzo IP statico. Per tutta la durata del cluster, l'indirizzo IP ALB in ciascuna zona non cambia. Se rimuovi una zona da un cluster, viene rimosso l'indirizzo IP ALB per quella zona.

Per vedere gli IP assegnati ai tuoi ALB, puoi eseguire il seguente comando.
```
ibmcloud ks albs --cluster <cluster_name_or_id>
```
{: pre}

Per ulteriori informazioni su cosa succede agli IP ALB in caso di malfunzionamento della zona, vedi la definizione per il [componente Programma di bilanciamento del carico multizona (o MZLB, multizone load balancer)](#ingress_components).



<br />


## In che modo viene effettuata una richiesta alla mia applicazione con Ingress in un cluster a zona singola?
{: #architecture-single}



Il seguente diagramma mostra in che modo Ingress indirizza le comunicazioni da Internet a un'applicazione in un cluster a zona singola:

<img src="images/cs_ingress_singlezone.png" width="800" alt="Esponi un'applicazione in un cluster a zona singola utilizzando Ingress" style="width:800px; border-style: none"/>

1. Un utente invia una richiesta alla tua applicazione accedendo all'URL dell'applicazione. Questo URL è l'URL pubblico per la tua applicazione esposta a cui è aggiunto il percorso della risorsa Ingress, ad esempio `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un servizio di sistema DNS risolve il dominio secondario nell'URL sull'indirizzo IP pubblico portatile del programma di bilanciamento del carico che espone l'ALB nel tuo cluster.

3. In base all'indirizzo IP risolto, il client invia la richiesta al servizio del programma di bilanciamento del carico che espone l'ALB.

4. Il servizio del programma di bilanciamento del carico instrada la richiesta all'ALB.

5. L'ALB verifica se esiste una regola di instradamento per il percorso `myapp` nel cluster. Se viene trovata una regola corrispondente, la richiesta viene inoltrata in base alle regole definite nella risorsa Ingress al pod in cui è distribuita l'applicazione. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP dell'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, l'ALB bilancia il carico delle richieste tra i pod dell'applicazione.

<br />


## In che modo viene effettuata una richiesta alla mia applicazione con Ingress in un cluster multizona?
{: #architecture-multi}

Il seguente diagramma mostra in che modo Ingress indirizza le comunicazioni da Internet a un'applicazione in un cluster multizona:

<img src="images/cs_ingress_multizone.png" width="800" alt="Esponi un'applicazione in un cluster multizona utilizzando Ingress" style="width:800px; border-style: none"/>

1. Un utente invia una richiesta alla tua applicazione accedendo all'URL dell'applicazione. Questo URL è l'URL pubblico per la tua applicazione esposta a cui è aggiunto il percorso della risorsa Ingress, ad esempio `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un servizio di sistema DNS, che funge da programma di bilanciamento del carico globale, risolve il dominio secondario nell'URL in un indirizzo IP disponibile che è stato segnalato come integro da MZLB. L'MZLB controlla continuamente gli indirizzi IP pubblici portatili dei servizi di bilanciamento del carico che espongono gli ALB pubblici in ciascuna zona nel tuo cluster. Gli indirizzi IP vengono risolti in un ciclo round-robin, ciò garantisce che le richieste vengono bilanciate equamente tra gli ALB integri nelle varie zone.

3. Il client invia la richiesta all'indirizzo IP del servizio del programma di bilanciamento del carico che espone un ALB.

4. Il servizio del programma di bilanciamento del carico instrada la richiesta all'ALB.

5. L'ALB verifica se esiste una regola di instradamento per il percorso `myapp` nel cluster. Se viene trovata una regola corrispondente, la richiesta viene inoltrata in base alle regole definite nella risorsa Ingress al pod in cui è distribuita l'applicazione. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, l'ALB bilancia il carico delle richieste tra i pod dell'applicazione tra tutte le zone.
