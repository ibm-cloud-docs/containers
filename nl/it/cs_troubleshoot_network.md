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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Risoluzione dei problemi di rete del cluster
{: #cs_troubleshoot_network}

Mentre utilizzi {{site.data.keyword.containerlong}}, tieni presente queste tecniche per la risoluzione dei problemi di rete del cluster.
{: shortdesc}

Hai problemi a connetterti alla tua applicazione tramite Ingress? Prova ad eseguire il [debug di Ingress](cs_troubleshoot_debug_ingress.html).
{: tip}

## Impossibile collegarsi a un'applicazione tramite un servizio di programma di bilanciamento del carico
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Hai esposto pubblicamente la tua applicazione creando un servizio di programma di bilanciamento del carico nel tuo cluster. Quando tenti di collegarti alla tua applicazione utilizzando l'indirizzo IP pubblico del programma di bilanciamento del carico, la connessione non riesce o va in timeout.

{: tsCauses}
Il tuo servizio di programma di bilanciamento del carico potrebbe non funzionare correttamente per uno dei seguenti motivi:

-   Il cluster è un cluster gratuito o standard con solo un nodo di lavoro.
-   Il cluster non è ancora stato completamente distribuito.
-   Lo script di configurazione per il tuo servizio di programma di bilanciamento del carico include degli errori.

{: tsResolve}
Per risolvere i problemi del tuo servizio di programma di bilanciamento del carico:

1.  Verifica di aver configurato un cluster standard che è stato completamente distribuito e che abbia almeno due nodi di lavoro per garantire l'elevata disponibilità per il tuo servizio di programma di bilanciamento del carico.

  ```
  ibmcloud ks workers <cluster_name_or_ID>
  ```
  {: pre}

    Nel tuo output della CLI, assicurati che lo **Stato** del tuo nodo di lavoro visualizzi **Pronto** e che il **Tipo di macchina** sia diverso da **gratuito**.

2. Per i programmi di bilanciamento del carico versione 2.0: assicurati di completare i [prerequisiti del programma di bilanciamento del carico 2.0](cs_loadbalancer.html#ipvs_provision).

3. Verifica l'accuratezza del file di configurazione del tuo servizio di programma di bilanciamento del carico.
    * Programmi di bilanciamento del carico versione 2.0:
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myservice
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
          ports:
           - protocol: TCP
             port: 8080
          externalTrafficPolicy: Local
        ```
        {: screen}

        1. Verifica di aver definito **LoadBalancer** come il tipo del tuo servizio.
        2. Verifica di aver incluso l'annotazione `service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"`.
        3. Nella sezione `spec.selector` del servizio LoadBalancer, assicurati che `<selector_key>` e `<selector_value>` siano gli stessi della coppia chiave/valore che hai utilizzato nella sezione `spec.template.metadata.labels` del tuo file yaml di distribuzione. Se le etichette non corrispondono, la sezione **Endpoints** nel tuo servizio LoadBalancer mostra **<none>** e la tua applicazione non sarà accessibile da Internet.
        4. Verifica di aver utilizzato la **porta** su cui è in ascolto la tua applicazione.
        5. Verifica di aver impostato `externalTrafficPolicy` su `Local`.

    * Programmi di bilanciamento del carico versione 1.0:
        ```
        apiVersion: v1
    kind: Service
    metadata:
      name: myservice
    spec:
      type: LoadBalancer
      selector:
        <selector_key>:<selector_value>
      ports:
           - protocol: TCP
               port: 8080
        ```
        {: screen}

        1. Verifica di aver definito **LoadBalancer** come il tipo del tuo servizio.
        2. Nella sezione `spec.selector` del servizio LoadBalancer, assicurati che `<selector_key>` e `<selector_value>` siano gli stessi della coppia chiave/valore che hai utilizzato nella sezione `spec.template.metadata.labels` del tuo file yaml di distribuzione. Se le etichette non corrispondono, la sezione **Endpoints** nel tuo servizio LoadBalancer mostra **<none>** e la tua applicazione non sarà accessibile da Internet.
        3. Verifica di aver utilizzato la **porta** su cui è in ascolto la tua applicazione.

3.  Verifica il tuo servizio di programma di bilanciamento del carico e controlla la sezione **Eventi** per trovare errori potenziali.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    Ricerca i seguenti messaggi di errore:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Per utilizzare il servizio di programma di bilanciamento del carico, devi disporre di un cluster standard con almeno due nodi di lavoro.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Questo messaggio di errore indica che non è stato lasciato alcun indirizzo IP pubblico portatile che può essere assegnato al tuo servizio di programma di bilanciamento del carico. Fai riferimento a <a href="cs_subnets.html#subnets">Aggiunta di sottoreti ai cluster</a> per trovare informazioni su come richiedere gli indirizzi IP pubblici portatili per il tuo cluster. Dopo che gli indirizzi IP pubblici portatili sono disponibili per il cluster, il servizio di programma di bilanciamento del carico viene creato automaticamente.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Hai definito un indirizzo IP pubblico portatile per il tuo servizio di programma di bilanciamento del carico utilizzando la sezione **loadBalancerIP**, ma questo indirizzo IP pubblico portatile non è disponibile nella tua sottorete pubblica portatile. Nella sezione **loadBalancerIP** il tuo script di configurazione rimuove l'indirizzo IP esistente e aggiunge uno degli indirizzi IP pubblici portatili. Puoi anche rimuovere la sezione **loadBalancerIP** dal tuo script in modo che possa venirne assegnato uno automaticamente.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Non disponi di abbastanza nodi di lavoro da distribuire a un servizio di programma di bilanciamento del carico. Un motivo potrebbe essere che hai distribuito un cluster standard con più di un nodo di lavoro ma il provisioning ha avuto esito negativo.</li>
    <ol><li>Elenca i nodi di lavoro disponibili.</br><pre class="pre"><code>kubectl get nodes</code></pre></li>
    <li>Se vengono trovati almeno due nodi di lavoro, elenca i dettagli del nodo di lavoro.</br><pre class="pre"><code>ibmcloud ks worker-get &lt;cluster_name_or_ID&gt; &lt;worker_ID&gt;</code></pre></li>
    <li>Assicurati che gli ID di VLAN pubblica e privata dei nodi di lavoro restituiti dai comandi <code>kubectl get nodes</code> e <code>ibmcloud ks &lt;cluster_name_or_ID&gt; worker-get</code> corrispondano.</li></ol></li></ul>

4.  Se stai utilizzando un dominio personalizzato per collegarti al tuo servizio di programma di bilanciamento del carico, assicurati che sia associato all'indirizzo IP pubblico del tuo servizio di programma di bilanciamento del carico.
    1.  Trova l'indirizzo IP pubblico del servizio di bilanciamento del carico.
        ```
        kubectl describe service <service_name> | grep "LoadBalancer Ingress"
        ```
        {: pre}

    2.  Verifica che il tuo dominio personalizzato sia associato all'indirizzo IP pubblico portatile del tuo servizio di bilanciamento del carico nel record di puntatore (PTR).

<br />


## Impossibile collegarsi a un'applicazione tramite Ingress
{: #cs_ingress_fails}

{: tsSymptoms}
Hai esposto pubblicamente la tua applicazione creando una risorsa Ingress per la tua applicazione nel tuo cluster. Quando tenti di collegarti alla tua applicazione tramite il dominio secondario o l'indirizzo IP pubblico del programma di bilanciamento del carico (ALB) dell'applicazione Ingress, la connessione non riesce o va in timeout.

{: tsResolve}
Controlla innanzitutto che il tuo cluster sia completamente distribuito e che abbia almeno 2 nodi di lavoro disponibili per zona per garantire l'elevata disponibilità per il tuo ALB.
```
ibmcloud ks workers <cluster_name_or_ID>
```
{: pre}

Nel tuo output della CLI, assicurati che lo **Stato** del tuo nodo di lavoro visualizzi **Pronto** e che il **Tipo di macchina** sia diverso da **gratuito**.

* Se il tuo cluster standard è completamente distribuito e ha almeno 2 nodi di lavoro per zona, ma non è disponibile alcun **Dominio secondario Ingress**, vedi [Impossibile ottenere un dominio secondario per l'ALB Ingress](cs_troubleshoot_network.html#cs_subnet_limit).
* Per altre situazioni di cui occuparsi, risolvi i problemi della tua impostazione Ingress attenendoti alla procedura in [Debug di Ingress](cs_troubleshoot_debug_ingress.html).

<br />


## Problemi con il segreto del programma di bilanciamento del carico dell'applicazione Ingress
{: #cs_albsecret_fails}

{: tsSymptoms}
Dopo aver distribuito un segreto del programma di bilanciamento del carico (ALB) dell'applicazione Ingress al tuo cluster, il campo `Descrizione` non viene aggiornato con il nome del segreto quando visualizzi il tuo certificato in {{site.data.keyword.cloudcerts_full_notm}}.

Quando elenchi le informazioni sul segreto dell'ALB, lo stato è `*_failed`. Ad esempio, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Controlla i seguenti motivi sul perché il segreto dell'ALB può avere un malfunzionamento e i passi di risoluzione del problema corrispondenti:

<table>
<caption>Risoluzione dei problemi con i segreti del programma di bilanciamento del carico dell'applicazione Ingress</caption>
 <thead>
 <th>Perché sta succedendo</th>
 <th>Come porvi rimedio</th>
 </thead>
 <tbody>
 <tr>
 <td>Non disponi dei ruoli di accesso necessari per scaricare e aggiornare i dati del certificato.</td>
 <td>Rivolgiti all'amministratore del tuo account per farti assegnare i seguenti ruoli {{site.data.keyword.Bluemix_notm}} IAM:<ul><li>I ruoli del servizio **Gestore** e **Scrittore** per la tua istanza {{site.data.keyword.cloudcerts_full_notm}}. Per ulteriori informazioni, vedi <a href="/docs/services/certificate-manager/access-management.html#managing-service-access-roles">Gestione dell'accesso al servizio</a> per {{site.data.keyword.cloudcerts_short}}.</li><li>Il <a href="cs_users.html#platform">ruolo della piattaforma **Amministratore**</a> per il cluster.</li></ul></td>
 </tr>
 <tr>
 <td>Il CRN del certificato fornito al momento della creazione, dell'aggiornamento o della rimozione non appartiene allo stesso account del cluster.</td>
 <td>Controlla che il CRN del certificato che hai fornito sia importato in un'istanza del servizio {{site.data.keyword.cloudcerts_short}} che viene distribuita nello stesso account del tuo cluster.</td>
 </tr>
 <tr>
 <td>Il CRN del certificato fornito al momento della creazione non è corretto.</td>
 <td><ol><li>Controlla l'accuratezza della stringa CRN del certificato che fornisci.</li><li>Se il certificato CRN risulta essere accurato, prova ad aggiornare il segreto: <code>ibmcloud ks alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Se questo comando produce lo stato <code>update_failed</code>, rimuovi il segreto: <code>ibmcloud ks alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code></li><li>Distribuisci di nuovo il segreto: <code>ibmcloud ks alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Il CRN del certificato fornito al momento dell'aggiornamento non è corretto.</td>
 <td><ol><li>Controlla l'accuratezza della stringa CRN del certificato che fornisci.</li><li>Se il certificato CRN risulta essere accurato, rimuovi il segreto: <code>ibmcloud ks alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code></li><li>Distribuisci di nuovo il segreto: <code>ibmcloud ks alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Prova ad aggiornare il segreto: <code>ibmcloud ks alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Il servizio {{site.data.keyword.cloudcerts_long_notm}} sta riscontrando un tempo di inattività.</td>
 <td>Controlla che il tuo servizio {{site.data.keyword.cloudcerts_short}} sia attivo e in esecuzione.</td>
 </tr>
 </tbody></table>

<br />


## Impossibile ottenere un dominio secondario per l'ALB Ingress
{: #cs_subnet_limit}

{: tsSymptoms}
Quando esegui `ibmcloud ks cluster-get <cluster>`, il tuo cluster si trova in uno stato `normal` ma non ci sono **domini secondari Ingress** disponibili.

Potresti ricevere un messaggio di errore simile al seguente.

```
There are already the maximum number of subnets permitted in this VLAN.
```
{: screen}

{: tsCauses}
Nei cluster standard, la prima volta che crei un cluster in una zona, viene automaticamente eseguito il provisioning di una VLAN pubblica e di una VLAN privata in tale zona per tuo conto nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). In tale zona, 1 sottorete pubblica portatile è richiesta sulla VLAN pubblica da te specificata e 1 sottorete privata portatile è richiesta sulla VLAN privata da te specificata. Per {{site.data.keyword.containerlong_notm}}, le VLAN hanno un limite di 40 sottoreti. Se la VLAN del cluster in una zona ha già raggiunto tale limite, il provisioning del **dominio secondario Ingress** non riesce.

Per visualizzare quante sottoreti sono presenti in una VLAN:
1.  Dalla [console dell'infrastruttura IBM Cloud (SoftLayer)](https://control.bluemix.net/), seleziona **Rete** > **Gestione IP** > **VLAN**.
2.  Fai clic sul **Numero VLAN** della VLAN che hai usato per creare il tuo cluster. Esamina la sezione **Sottoreti** per vedere se ci sono 40 o più sottoreti.

{: tsResolve}
Se hai bisogno di una nuova VLAN, ordinane una [contattando il supporto {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#ordering-premium-vlans). Quindi [crea un cluster](cs_cli_reference.html#cs_cluster_create) che utilizzi questa nuova VLAN.

Se hai un'altra VLAN disponibile, puoi [configurare lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) nel tuo cluster esistente. Dopo, puoi aggiungere nuovi nodi di lavoro al cluster che utilizza l'altra VLAN con sottoreti disponibili. Per controllare se lo spanning della VLAN è già abilitato, utilizza il [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

Se non stai utilizzando tutte le sottoreti nella VLAN, puoi riutilizzare le sottoreti nel cluster.
1.  Controlla che le sottoreti che desideri utilizzare siano disponibili.

    L'account dell'infrastruttura che stai utilizzando potrebbe essere condiviso tra più account {{site.data.keyword.Bluemix_notm}}. Se è questo il caso, anche se esegui il comando `ibmcloud ks subnets` per vedere le sottoreti con **Bound Clusters**, potrai vedere le informazioni solo per i tuoi cluster. Controlla con il proprietario dell'account dell'infrastruttura per assicurarti che le sottoreti siano disponibili e non in uso da parte di un altro account o team.
    {: note}

2.  [Crea un cluster](cs_cli_reference.html#cs_cluster_create) con l'opzione `--no-subnet` in modo tale che il servizio non tenti di creare nuove sottoreti. Specifica la zona e la VLAN in cui le sottoreti sono disponibili per essere utilizzate.

3.  Usa il [comando](cs_cli_reference.html#cs_cluster_subnet_add) `ibmcloud ks cluster-subnet-add` per aggiungere sottoreti esistenti al tuo cluster. Per ulteriori informazioni, consulta [Aggiunta o riutilizzo di sottoreti personalizzate ed esistenti nei cluster Kubernetes](cs_subnets.html#custom).

<br />


## L'ALB Ingress non viene distribuito in una zona
{: #cs_multizone_subnet_limit}

{: tsSymptoms}
Quando hai un cluster multizona ed esegui `ibmcloud ks albs <cluster>`, in una zona non viene distribuito alcun ALB. Ad esempio, se hai dei nodi di lavoro in 3 zone, potresti vedere un output simile al seguente in cui un ALB pubblico non è stato distribuito nella terza zona.
```
ALB ID                                            Status     Type      ALB IP           Zone    Build
private-cr96039a75fddb4ad1a09ced6699c88888-alb1   disabled   private   -                dal10   ingress:350/ingress-auth:192
private-cr96039a75fddb4ad1a09ced6699c88888-alb2   disabled   private   -                dal12   ingress:350/ingress-auth:192
private-cr96039a75fddb4ad1a09ced6699c88888-alb3   disabled   private   -                dal13   ingress:350/ingress-auth:192
public-cr96039a75fddb4ad1a09ced6699c88888-alb1    enabled    public    169.xx.xxx.xxx  dal10   ingress:350/ingress-auth:192
public-cr96039a75fddb4ad1a09ced6699c88888-alb2    enabled    public    169.xx.xxx.xxx  dal12   ingress:350/ingress-auth:192
```
{: screen}

{: tsCauses}
In ciascuna zona, 1 sottorete pubblica portatile è richiesta sulla VLAN pubblica da te specificata e 1 sottorete privata portatile è richiesta sulla VLAN privata da te specificata. Per {{site.data.keyword.containerlong_notm}}, le VLAN hanno un limite di 40 sottoreti. Se la VLAN pubblica del cluster in una zona ha già raggiunto tale limite, il provisioning dell'ALB Ingress pubblico per tale zona non riesce.

{: tsResolve}
Per controllare il numero di sottoreti in una VLAN e per la procedura su come ottenere un'altra VLAN, vedi [Impossibile ottenere un dominio secondario per l'ALB Ingress](#cs_subnet_limit).

<br />


## La connessione tramite WebSocket si chiude dopo 60 secondi
{: #cs_ingress_websocket}

{: tsSymptoms}
Il tuo servizio Ingress espone un'applicazione che utilizza un WebSocket. Tuttavia, la connessione tra un client e la tua applicazione WebSocket viene chiusa quando non viene inviato traffico tra di essi per 60 secondi.

{: tsCauses}
La connessione alla tua applicazione WebSocket potrebbe essere interrotta dopo 60 secondi di inattività per uno dei seguenti motivi:

* La tua connessione Internet ha un proxy o un firewall che non tollerano lunghe connessioni.
* Un timeout nell'ALB all'applicazione WebSocket termina la connessione.

{: tsResolve}
Per evitare che la connessione venga chiusa dopo 60 secondi di inattività:

1. Se stabilisci una connessione alla tua applicazione WebSocket tramite un proxy o un firewall, assicurati che il proxy o il firewall non siano configurati per terminare automaticamente le connessioni lunghe.

2. Per mantenere attiva la connessione, puoi aumentare il valore del timeout oppure configurare un heartbeat nella tua applicazione.
<dl><dt>Modifica il timeout</dt>
<dd>Aumenta il valore del `proxy-read-timeout` nella tua configurazione dell'ALB. Ad esempio, per modificare il timeout da `60s` a un valore più grande come `300s`, aggiungi questa [annotazione](cs_annotations.html#connection) al tuo file di risorse Ingress `ingress.bluemix.net/proxy-read-timeout: "serviceName=<service_name> timeout=300s"`. Il timeout viene modificato per tutti gli ALB pubblici nel tuo cluster.</dd>
<dt>Configura un heartbeat</dt>
<dd>Se non vuoi modificare il valore di timeout della lettura predefinito di ALB, configura un heartbeat nella tua applicazione WebSocket. Quando configuri un protocollo heartbeat utilizzando un framework come [WAMP ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://wamp-proto.org/), il server di upstream dell'applicazione invia periodicamente un messaggio "ping" a un intervallo prestabilito e il client risponde con un messaggio "pong". Configura l'intervallo di heartbeat su 58 secondi o meno in modo che il traffico "ping/pong" mantenga la connessione aperta prima che venga implementato il timeout di 60 secondi.</dd></dl>

<br />


## La conservazione dell'IP di origine non riesce quando si utilizzano nodi corrotti
{: #cs_source_ip_fails}

{: tsSymptoms}
Hai abilitato la conservazione dell'IP di origine per un servizio del [programma di bilanciamento del carico versione 1.0](cs_loadbalancer.html#node_affinity_tolerations) o dell'[ALB Ingress](cs_ingress.html#preserve_source_ip) modificando `externalTrafficPolicy` in `Local` nel file di configurazione del servizio. Tuttavia, nessun traffico raggiunge il servizio di backend per la tua applicazione.

{: tsCauses}
Quando abiliti la conservazione dell'IP di origine per i servizi del programma di bilanciamento del carico o dell'ALB Ingress, l'indirizzo IP di origine della richiesta del client viene conservato. Il servizio inoltra il traffico ai pod dell'applicazione solo sullo stesso nodo di lavoro per garantire che l'indirizzo IP del pacchetto di richiesta non venga modificato. In genere, i pod dei servizi del programma di bilanciamento del carico o dell'ALB Ingress vengono distribuiti negli stessi nodi di lavoro su cui vengono distribuiti i pod dell'applicazione. Tuttavia, ci sono alcune situazioni in cui i pod del servizio e i pod dell'applicazione potrebbero non essere pianificati sullo stesso nodo di lavoro. Se utilizzi le [corruzioni Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) sui nodi di lavoro, a tutti i pod che non hanno una tolleranza alle corruzioni viene impedita l'esecuzione sui nodi di lavoro corrotti. La conservazione dell'IP di origine potrebbe non funzionare in base al tipo di corruzione che hai utilizzato:

* **Corruzioni del nodo edge**: hai [aggiunto l'etichetta `dedicated=edge`](cs_edge.html#edge_nodes) a due o più nodi di lavoro su ogni VLAN pubblica nel tuo cluster per garantire che i pod Ingress e del programma di bilanciamento del carico vengano distribuiti solo a quei nodi di lavoro. Quindi, hai anche [corrotto quei nodi edge](cs_edge.html#edge_workloads) per impedire che altri carichi di lavoro vengano eseguiti su nodi edge. Tuttavia, non hai aggiunto una regola di affinità del nodo edge e una tolleranza alla tua distribuzione dell'applicazione. I tuoi pod dell'applicazione non possono essere pianificati sugli stessi nodi corrotti dei pod del servizio e nessun traffico raggiunge il servizio di backend per la tua applicazione.

* **Corruzioni personalizzate**: hai utilizzato corruzioni personalizzate su diversi nodi in modo che solo i pod dell'applicazione con tolleranza a queste corruzioni possano essere distribuiti su tali nodi. Hai aggiunto regole di affinità e tolleranze alle distribuzioni dell'applicazione e del servizio del programma di bilanciamento del carico o Ingress in modo che i loro pod vengano distribuiti solo su tali nodi. Tuttavia, i pod `keepalived` `ibm-cloud-provider-ip` che vengono creati automaticamente nello spazio dei nomi `ibm-system` garantiscono che i pod del programma di bilanciamento del carico e i pod dell'applicazione siano sempre pianificati sullo stesso nodo di lavoro. Questi pod `keepalived` non hanno le tolleranze per le corruzioni personalizzate che hai utilizzato. Non possono essere pianificati sugli stessi nodi corrotti su cui sono in esecuzione i tuoi pod dell'applicazione e nessun traffico raggiunge il servizio di backend per la tua applicazione.

{: tsResolve}
Risolvi il problema scegliendo una delle seguenti opzioni:

* **Corruzioni del nodo edge**: per garantire che i tuoi pod del programma di bilanciamento del carico e dell'applicazione vengano distribuiti sui nodi edge corrotti, [aggiungi regole di affinità e tolleranze del nodo edge alla tua distribuzione dell'applicazione](cs_loadbalancer.html#edge_nodes). I pod del programma di bilanciamento del carico e dell'ALB Ingress hanno queste regole di affinità e tolleranze per impostazione predefinita.

* **Corruzioni personalizzate**: rimuovi le corruzioni personalizzate per le quali i pod `keepalived` non hanno tolleranze. Puoi invece [etichettare i nodi di lavoro come edge e quindi danneggiare quei nodi edge](cs_edge.html).

Se completi una delle opzioni precedenti ma i pod `keepalived` non vengono ancora pianificati, puoi ottenere ulteriori informazioni sui pod `keepalived`:

1. Ottieni i pod `keepalived`.
    ```
    kubectl get pods -n ibm-system
    ```
    {: pre}

2. Nell'output, cerca i pod `ibm-cloud-provider-ip` che hanno lo **Status** uguale a `Pending`. Esempio:
    ```
    ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-7zv9t     0/1       Pending   0          2m        <none>          <none>
    ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-8ptvg     0/1       Pending   0          2m        <none>          <none>
    ```
    {:screen}

3. Descrivi ogni pod `keepalived` e cerca la sezione **Events**. Risolvi eventuali messaggi di errore o di avvertenza elencati.
    ```
    kubectl describe pod ibm-cloud-provider-ip-169-61-XX-XX-55967b5b8c-7zv9t -n ibm-system
    ```
    {: pre}

<br />


## Impossibile stabilire la connettività VPN con il grafico Helm strongSwan
{: #cs_vpn_fails}

{: tsSymptoms}
Quando controlli la connettività VPN eseguendo `kubectl exec  $STRONGSWAN_POD -- ipsec status`, non vedi lo stato `ESTABLISHED` oppure il pod VPN è in uno stato `ERROR` o continua ad arrestarsi e a riavviarsi.

{: tsCauses}
Il tuo file di configurazione del grafico Helm ha valori errati, valori mancanti o errori di sintassi.

{: tsResolve}
Quando tenti di stabilire la connettività VPN con il grafico Helm strongSwan per la prima volta, è probabile che lo stato della VPN non sia `ESTABLISHED`. Potresti dover verificare diversi tipi di problemi e modificare di conseguenza il tuo file di configurazione. Per risolvere i problemi relativi alla connettività VPN strongSwan:

1. [Testa e verifica la connettività VPN strongSwan](cs_vpn.html#vpn_test) eseguendo i cinque test Helm inclusi nella definizione del grafico strongSwan.

2. Se non sei in grado di stabilire la connettività VPN dopo aver eseguito i test Helm, puoi eseguire lo strumento di debug VPN fornito all'interno dell'immagine del pod VPN.

    1. Imposta la variabile di ambiente `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Esegui lo strumento di debug.

        ```
        kubectl exec  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        Lo strumento emette diverse pagine di informazioni mentre esegue vari test per i comuni problemi di rete. Le righe di output che iniziano con `ERROR`, `WARNING`, `VERIFY` o `CHECK` indicano possibili errori con la connettività VPN.

    <br />


## Impossibile installare una nuova release del grafico Helm strongSwan
{: #cs_strongswan_release}

{: tsSymptoms}
Modifichi il tuo grafico Helm strongSwan e provi a installare la tua nuova release eseguendo `helm install -f config.yaml --name=vpn ibm/strongswan`. Tuttavia, visualizzi il seguente errore:
```
Error: release vpn failed: deployments.extensions "vpn-strongswan" already exists
```
{: screen}

{: tsCauses}
Questo errore indica che la release precedente del grafico strongSwan non era stata disinstallata completamente.

{: tsResolve}

1. Elimina la release del grafico precedente.
    ```
    helm delete --purge vpn
    ```
    {: pre}

2. Elimina la distribuzione per la release precedente. L'eliminazione della distribuzione e del pod associato impiega fino a 1 minuto
    ```
    kubectl delete deploy vpn-strongswan
    ```
    {: pre}

3. Verifica che la distribuzione sia stata eliminata. La distribuzione `vpn-strongswan` non viene visualizzata nell'elenco.
    ```
    kubectl get deployments
    ```
    {: pre}

4. Reinstalla il grafico Helm strongSwan aggiornato con un nuovo nome di release.
    ```
    helm install -f config.yaml --name=vpn ibm/strongswan
    ```
    {: pre}

<br />


## La connettività VPN strongSwan si interrompe dopo che aggiungi o elimini nodi di lavoro
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
In precedenza hai stabilito una connessione VPN funzionante utilizzando il servizio VPN IPsec strongSwan. Tuttavia, dopo aver aggiunto o eliminato un nodo di lavoro nel cluster, si verificano uno o più dei seguenti sintomi:

* Non hai uno stato `ESTABLISHED` per la VPN
* Non puoi accedere ai nuovi nodi di lavoro dalla tua rete in loco
* Non puoi accedere alla rete remota dai pod in esecuzione nei nuovi nodi di lavoro

{: tsCauses}
Se hai aggiunto un nodo di lavoro a un pool di nodi di lavoro:

* È stato eseguito il provisioning del nodo di lavoro su una nuova sottorete privata che non è esposta tramite la connessione VPN dalle tue impostazioni `localSubnetNAT` o `local.subnet` esistenti
* Le rotte VPN non possono essere aggiunte al nodo di lavoro perché il nodo di lavoro ha delle corruzioni o etichette che non sono incluse nelle tue impostazioni `tolerations` o `nodeSelector` esistenti
* Il pod VPN è in esecuzione sul nuovo nodo di lavoro, ma l'indirizzo IP pubblico di tale nodo di lavoro non è consentito attraverso il firewall in loco

Se hai eliminato il nodo di lavoro:

* Quel nodo di lavoro era l'unico nodo su cui era in esecuzione un pod VPN, a causa delle restrizioni su determinate corruzioni o etichette nelle tue impostazioni `tolerations` o `nodeSelector` esistenti

{: tsResolve}
Aggiorna i valori del grafico Helm per riflettere le modifiche del nodo di lavoro:

1. Elimina il grafico Helm esistente.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Apri il file di configurazione per il tuo servizio VPN strongSwan.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Controlla le seguenti impostazioni e apporta modifiche per riflettere i nodi di lavoro eliminati o aggiunti secondo necessità.

    Se hai aggiunto un nodo di lavoro:

    <table>
    <caption>Impostazioni</didascalia del nodo di lavoro?
     <thead>
     <th>Impostazione</th>
     <th>Descrizione</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Il nodo di lavoro aggiunto potrebbe essere distribuito su una nuova sottorete privata diversa rispetto alle altre sottoreti esistenti su cui sono attivi altri nodi di lavoro. Se utilizzi il NAT della sottorete per riassociare gli indirizzi IP locali privati del tuo cluster e il nodo di lavoro è stato aggiunto in una nuova sottorete, aggiungi il CIDR della nuova sottorete a questa impostazione.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se in precedenza hai limitato la distribuzione del pod VPN ai nodi di lavoro con un'etichetta specifica, assicurati che anche il nodo di lavoro aggiunto abbia tale etichetta.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se il nodo di lavoro aggiunto è corrotto, modifica questa impostazione per consentire l'esecuzione del pod VPN su tutti i nodi di lavoro corrotti con qualsiasi corruzione o con delle corruzioni specifiche.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>Il nodo di lavoro aggiunto potrebbe essere distribuito su una nuova sottorete privata diversa rispetto alle sottoreti esistenti su cui sono attivi altri nodi di lavoro. Se le tue applicazioni sono esposte dai servizi NodePort o LoadBalancer sulla rete privata e si trovano sul nodo di lavoro aggiunto, aggiungi il nuovo CIDR della sottorete a questa impostazione. **Nota**: se aggiungi valori a `local.subnet`, controlla le impostazioni VPN per la sottorete locale per vedere se devono essere aggiornate.</td>
     </tr>
     </tbody></table>

    Se hai eliminato il nodo di lavoro:

    <table>
    <caption>Impostazioni del nodo di lavoro</caption>
     <thead>
     <th>Impostazione</th>
     <th>Descrizione</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Se stai utilizzando il NAT di sottorete per riassociare specifici indirizzi IP locali privati, rimuovi, da questa impostazione, gli indirizzi IP che provengono dal vecchio nodo di lavoro. Se utilizzi il NAT della sottorete per riassociare intere sottoreti e non ci sono nodi di lavoro rimanenti in una sottorete, rimuovi il CIDR di tale sottorete da questa impostazione.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Se hai limitato la distribuzione del pod VPN a un solo nodo di lavoro ed è stato eliminato, modifica questa impostazione per consentire l'esecuzione del pod VPN su altri nodi di lavoro.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Se il nodo di lavoro che hai eliminato non era corrotto, ma lo sono gli unici nodi di lavoro rimasti, modifica questa impostazione per consentire l'esecuzione del pod VPN sui nodi di lavoro con qualsiasi corruzione o con delle corruzioni specifiche.
     </td>
     </tr>
     </tbody></table>

4. Installa il nuovo grafico Helm con i tuoi valori aggiornati.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Controlla lo stato di distribuzione del grafico. Quando il grafico è pronto, il campo **STATO** vicino alla parte superiore dell'output ha un valore di `DEPLOYED`.

    ```
    helm status <release_name>
    ```
    {: pre}

6. In alcuni casi, potresti dover modificare le impostazioni in loco e le impostazioni del tuo firewall in modo che corrispondano alle modifiche che hai apportato al file di configurazione VPN.

7. Avvia la VPN.
    * Se la connessione VPN viene avviata dal cluster (`ipsec.auto` è impostata su `start`), avvia la VPN sul gateway in loco e quindi avviala sul cluster.
    * Se la connessione VPN viene avviata dal gateway in loco (`ipsec.auto` è impostata su `auto`), avvia la VPN sul cluster e quindi avviala sul gateway in loco.

8. Imposta la variabile di ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Controlla lo stato della VPN.

    ```
    kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Se la connessione VPN ha lo stato `ESTABLISHED`, la connessione VPN ha avuto esito positivo. Non sono necessarie ulteriori azioni.

    * Se hai ancora problemi di connessione, vedi [Impossibile stabilire la connettività VPN con il grafico Helm strongSwan](#cs_vpn_fails) per ulteriori informazioni su come risolvere i problemi con la connessione VPN.

<br />



## Impossibile richiamare le politiche di rete Calico
{: #cs_calico_fails}

{: tsSymptoms}
Quando tenti di visualizzare le politiche di rete Calico nel tuo cluster eseguendo `calicoctl get policy`, riscontri uno dei seguenti risultati non previsti o messaggi di errore:
- Un elenco vuoto
- Un elenco delle precedenti politiche Calico v2 invece delle v3
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'projectcalico.org/v3'`

Quando tenti di visualizzare le politiche di rete Calico nel tuo cluster eseguendo `calicoctl get GlobalNetworkPolicy`, riscontri uno dei seguenti risultati non previsti o messaggi di errore:
- Un elenco vuoto
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'v1'`
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'projectcalico.org/v3'`
- `Failed to get resources: Resource type 'GlobalNetworkPolicy' is not supported`

{: tsCauses}
Per utilizzare le politiche Calico, quattro fattori devono essere allineati: la tua versione del cluster Kubernetes, la versione della CLI Calico, la sintassi del file di configurazione Calico e i comandi di visualizzazione della politica. Uno o più di questi fattori non è alla versione corretta.

{: tsResolve}
Quando il tuo cluster è alla [versione Kubernetes 1.10 o successive](cs_versions.html), devi utilizzare la CLI Calico v3.1, la sintassi del file di configurazione `calicoctl.cfg` v3 e i comandi `calicoctl get GlobalNetworkPolicy` e `calicoctl get NetworkPolicy`.

Quando il tuo cluster è alla [versione Kubernetes 1.9 o precedenti](cs_versions.html), devi utilizzare la CLI Calico v1.6.3, la sintassi del file di configurazione `calicoctl.cfg` v2 e il comando `calicoctl get policy`.

Per assicurarti che tutti i fattori Calico siano allineati:

1. Visualizza la tua versione del cluster Kubernetes.
    ```
    ibmcloud ks cluster-get <cluster_name>
    ```
    {: pre}

    * Se il tuo cluster è alla versione Kubernetes 1.10 o successive:
        1. [Installa e configura la CLI Calico versione 3.3.1](cs_network_policy.html#1.10_install). La configurazione include l'aggiornamento manuale del file `calicoctl.cfg` per utilizzare la sintassi Calico v3.
        2. Assicurati che tutte le politiche che crei e vuoi applicare al tuo cluster utilizzino la [sintassi Calico v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). Se hai un file `.yaml` o `.json` della politica esistente alla sintassi Calico v2, puoi convertirlo a Calico v3 utilizzando il comando [`calicoctl convert` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/commands/convert).
        3. Per [visualizzare le politiche](cs_network_policy.html#1.10_examine_policies), assicurati di stare utilizzando `calicoctl get GlobalNetworkPolicy` per le politiche globali e `calicoctl get NetworkPolicy --namespace <policy_namespace>` per le politiche dedicate a spazi dei nomi specifici.

    * Se il tuo cluster è alla versione Kubernetes 1.9 o precedenti:
        1. [Installa e configura la CLI Calico versione 1.6.3](cs_network_policy.html#1.9_install). Assicurati che il file `calicoctl.cfg` utilizzi la sintassi Calico v2.
        2. Assicurati che tutte le politiche che crei e vuoi applicare al tuo cluster utilizzino la [sintassi Calico v2 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).
        3. Per [visualizzare le politiche](cs_network_policy.html#1.9_examine_policies), assicurati di stare utilizzando `calicoctl get policy`.

Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedenti alla versione 1.10 o successive, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: tip}

<br />


## Impossibile aggiungere i nodi di lavoro a causa di un ID VLAN non valido
{: #suspended}

{: tsSymptoms}
Il tuo account {{site.data.keyword.Bluemix_notm}} è stato sospeso o tutti i nodi di lavoro nel tuo cluster sono stati eliminati. Dopo che l'account viene riattivato, non puoi aggiungere nodi di lavoro quando provi a ridimensionare o ribilanciare il tuo pool di nodi di lavoro. Vedi un messaggio di errore simile al seguente:

```
SoftLayerAPIError(SoftLayer_Exception_Public): Could not obtain network VLAN with id #123456.
```
{: screen}

{: tsCauses}
Quando un account viene sospeso, i nodi di lavoro all'interno dell'account vengono eliminati. Se un cluster non ha alcun nodo di lavoro, l'infrastruttura IBM Cloud (SoftLayer) recupera le VLAN pubbliche e private associate. Tuttavia, il pool di nodi di lavoro del cluster ha ancora i precedenti ID VLAN nei suoi metadati e utilizza questi ID non disponibili quando ribilanci o ridimensioni il pool. La creazione dei nodi non riesce perché le VLAN non sono più associate al cluster.

{: tsResolve}

Puoi [eliminare il tuo pool di nodi di lavoro esistente](cs_cli_reference.html#cs_worker_pool_rm) e quindi [creare un nuovo pool di nodi di lavoro](cs_cli_reference.html#cs_worker_pool_create).

In alternativa, puoi conservare il tuo pool di nodi di lavoro esistente ordinando delle nuove VLAN e utilizzandole per creare dei nuovi nodi di lavoro nel pool.

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1.  Per ottenere le zone per cui hai bisogno di nuovi ID VLAN, prendi nota dell'**Ubicazione** nel seguente output di comando. **Nota**: se il tuo cluster è un multizona, ti servono degli ID VLAN per ciascuna zona.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

2.  Ottieni una nuova VLAN privata e pubblica per ogni zona in cui si trova il tuo cluster [contattando il supporto {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#ordering-premium-vlans).

3.  Prendi nota dei nuovi ID VLAN pubblica e privata per ciascuna zona.

4.  Prendi nota del nome dei tuoi pool di nodi di lavoro.

    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

5.  Utilizza il [comando](cs_cli_reference.html#cs_zone_network_set) `zone-network-set` per modificare i metadati della rete del pool di nodi di lavoro.

    ```
    ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> -- worker-pools <worker-pool> --private-vlan <private_vlan_ID> --public-vlan <public_vlan_ID>
    ```
    {: pre}

6.  **Solo cluster multizona**: ripeti il **Passo 5** per ciascuna zona nel tuo cluster.

7.  Ribilancia o ridimensiona il tuo pool di nodi di lavoro per aggiungere i nodi di lavoro che utilizzano i nuovi ID VLAN. Ad esempio:

    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <worker_pool> --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

8.  Verifica che i tuoi nodi di lavoro vengano creati.

    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool>
    ```
    {: pre}

<br />



## Come ottenere aiuto e supporto
{: #ts_getting_help}

Stai ancora avendo problemi con il tuo cluster?
{: shortdesc}

-  Nel terminale, ricevi una notifica quando sono disponibili degli aggiornamenti ai plug-in e alla CLI `ibmcloud`. Assicurati di mantenere la tua CLI aggiornata in modo che tu possa utilizzare tutti i comandi e gli indicatori disponibili.
-   Per vedere se {{site.data.keyword.Bluemix_notm}} è disponibile, [controlla la pagina sugli stati {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/bluemix/support/#status).
-   Pubblica una domanda in [{{site.data.keyword.containerlong_notm}} Slack ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibm-container-service.slack.com).
    Se non stai utilizzando un ID IBM per il tuo account {{site.data.keyword.Bluemix_notm}}, [richiedi un invito](https://bxcs-slack-invite.mybluemix.net/) a questo Slack.
    {: tip}
-   Rivedi i forum per controllare se altri utenti hanno riscontrato gli stessi problemi. Quando utilizzi i forum per fare una domanda, contrassegna con una tag la tua domanda in modo che sia visualizzabile dai team di sviluppo {{site.data.keyword.Bluemix_notm}}.
    -   Se hai domande tecniche sullo sviluppo o la distribuzione di cluster o applicazioni con
{{site.data.keyword.containerlong_notm}}, inserisci la tua domanda in
[Stack Overflow ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e contrassegnala con le tag `ibm-cloud`, `kubernetes` e `containers`.
    -   Per domande sul servizio e istruzioni introduttive, utilizza il forum
[IBM Developer Answers ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Includi le tag `ibm-cloud`
e `containers`.
    Consulta [Come ottenere supporto](/docs/get-support/howtogetsupport.html#using-avatar) per ulteriori dettagli sull'utilizzo dei forum.
-   Contatta il supporto IBM aprendo un caso. Per informazioni su come aprire un caso di supporto IBM o sui livelli di supporto e sulla gravità dei casi, consulta [Come contattare il supporto](/docs/get-support/howtogetsupport.html#getting-customer-support).
Quando riporti un problema, includi il tuo ID del cluster. Per ottenere il tuo ID del cluster, esegui `ibmcloud ks clusters`.
{: tip}

