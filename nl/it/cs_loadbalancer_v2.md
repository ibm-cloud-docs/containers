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



# Configurazione di un NLB 2.0 (beta)
{: #loadbalancer-v2}

Esponi una porta e utilizza un indirizzo IP portatile per un NLB (network load balancer) di livello 4 per esporre un'applicazione inserita in un contenitore. Per ulteriori informazioni sugli NLB versione 2.0, vedi [Componenti e architettura di un NLB 2.0](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs).
{:shortdesc}

## Prerequisiti
{: #ipvs_provision}

Non puoi aggiornare un NLB versione 1.0 esistente alla versione 2.0. Devi creare un nuovo NLB 2.0. Nota che in un cluster puoi eseguire contemporaneamente NLB versione 1.0 e 2.0.
{: shortdesc}

Prima di creare un NLB 2.0, devi completare la seguente procedura prerequisita.

1. [Aggiorna i nodi master e di lavoro del tuo cluster](/docs/containers?topic=containers-update) a Kubernetes versione 1.12 o successive.

2. Per consentire al tuo NLB 2.0 di inoltrare le richieste ai pod dell'applicazione in più zone, apri un caso di supporto per richiedere l'aggregazione di capacità per le tue VLAN. Questa impostazione di configurazione non causa interferenze o interruzioni di rete.
    1. Accedi alla [console {{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/).
    2. Dalla barra dei menu, fai clic su **Supporto**, fai clic sulla scheda **Gestisci casi** e quindi su **Crea nuovo caso**.
    3. Nei campi del caso, immetti quanto segue:
       * Per il tipo di supporto, seleziona **Supporto tecnico**.
       * Per la categoria, seleziona **VLAN Spanning**.
       * Per l'oggetto, immetti **Public and private VLAN network question**
    4. Aggiungi le seguenti informazioni alla descrizione: "Please set up the network to allow capacity aggregation on the public and private VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145". Nota: se vuoi consentire l'aggregazione di capacità su VLAN specifiche, come ad esempio le VLAN pubbliche solo per un singolo cluster, puoi specificare questi ID VLAN nella descrizione.
    5. Fai clic su **Invia**.

3. Abilita una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) per il tuo account dell'infrastruttura IBM Cloud. Per abilitare VRF, [contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Per controllare se una VRF è già abilitata, utilizza il comando `ibmcloud account show`. Se non puoi o non vuoi abilitare VRF, abilita lo [spanning della VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Quando lo spanning della VRF o della VLAN viene abilitato, l'NLB 2.0 può instradare i pacchetti alle varie sottoreti dell'account.

4. Se utilizzi le [politiche di rete pre-DNAT di Calico](/docs/containers?topic=containers-network_policies#block_ingress) per gestire il traffico verso l'indirizzo IP di un NLB 2.0, devi aggiungere i campi `applyOnForward: true` e `doNotTrack: true` e rimuovere il campo `preDNAT: true` dalla sezione `spec` delle politiche. `applyOnForward: true` assicura che la politica Calico venga applicata al traffico quando viene incapsulato e inoltrato. `doNotTrack: true` garantisce che i nodi di lavoro possano utilizzare DSR per restituire un pacchetto di risposta direttamente al client senza che sia necessario tenere traccia della connessione. Ad esempio, se utilizzi una politica Calico per inserire in whitelist il traffico solo da specifici indirizzi IP all'indirizzo IP del tuo NLB, la politica è simile alla seguente:
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
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

Successivamente, puoi seguire la procedura indicata in [Configurazione di un NLB 2.0 in un cluster multizona](#ipvs_multi_zone_config) o [in un cluster a zona singola](#ipvs_single_zone_config).

<br />


## Configurazione di un NLB 2.0 in un cluster multizona
{: #ipvs_multi_zone_config}

**Prima di iniziare**:

* **Importante**: completa i [prerequisiti di NLB 2.0](#ipvs_provision).
* Per creare NLB pubblici in più zone, almeno una VLAN pubblica deve avere delle sottoreti portatili disponibili in ciascuna zona. Per creare NLB privati in più zone, almeno una VLAN privata deve avere delle sottoreti portatili disponibili in ciascuna zona. Puoi aggiungere sottoreti seguendo la procedura in [Configurazione delle sottoreti per i cluster](/docs/containers?topic=containers-subnets).
* Se limiti il traffico di rete ai nodi di lavoro edge, assicurati che almeno due [nodi di lavoro edge](/docs/containers?topic=containers-edge#edge) siano abilitati in ogni zona in modo che gli NLB vengano distribuiti in modo uniforme.
* Assicurati di disporre del [ruolo del servizio {{site.data.keyword.cloud_notm}} IAM **Scrittore** o **Gestore**](/docs/containers?topic=containers-users#platform) per lo spazio dei nomi `default`.


Per configurare un NLB 2.0 in un cluster multizona:
1.  [Distribuisci la tua applicazione al cluster](/docs/containers?topic=containers-app#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico.

2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre all'Internet pubblico o a una rete privata.
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
        <td>Annotazione per specificare un programma di bilanciamento del carico <code>private</code> o <code>public</code>.</td>
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
        <td>Facoltativo: annotazione per specificare l'algoritmo di pianificazione. I valori accettati sono <code>"rr"</code> per Round Robin (predefinito) o <code>"sh"</code> per Source Hashing. Per ulteriori informazioni, vedi [2.0: Algoritmi di pianificazione](#scheduling).</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>La chiave (<em>&lt;selector_key&gt;</em>) e il valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> dello YAML di distribuzione della tua applicazione.</td>
      </tr>
      <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facoltativo: per creare un NLB privato o utilizzare un indirizzo IP portatile specifico per un NLB pubblico, specifica l'indirizzo IP che vuoi utilizzare. L'indirizzo IP deve essere nella zona e nella VLAN che specifichi nelle annotazioni. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è solo su una VLAN privata, viene utilizzato un indirizzo IP privato portatile.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Imposta su <code>Local</code>.</td>
      </tr>
      </tbody></table>

      File di configurazione di esempio per creare un servizio NLB 2.0 in `dal12` che utilizza l'algoritmo di pianificazione Round Robin:

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

  3. Facoltativo: rendi disponibile il tuo servizio NLB solo per un intervallo limitato di indirizzi IP, specificando gli IP nel campo `spec.loadBalancerSourceRanges`.  `loadBalancerSourceRanges` è implementato da `kube-proxy` nel tuo cluster tramite regole Iptables sui nodi di lavoro. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Crea il servizio nel tuo cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifica che il servizio NLB sia stato creato correttamente. Affinché il servizio NLB venga creato correttamente e l'applicazione sia disponibile potrebbero essere necessari alcuni minuti.

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

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile assegnato al tuo servizio NLB.

4.  Se hai creato un NLB pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile dell'NLB e la porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Per ottenere l'alta disponibilità, ripeti i passi da 2 a 4 per aggiungere un NLB 2.0 in ciascuna zona in cui hai istanze dell'applicazione.

6. Facoltativo: un servizio NLB rende anche disponibile la tua applicazione anche sulle NodePort del servizio. Puoi accedere alle [NodePort](/docs/containers?topic=containers-nodeport) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio NLB, vedi [Controllo del traffico in entrata nei servizi NLB (network load balancer) o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Successivamente, puoi [registrare un nome host NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Configurazione di un NLB 2.0 in un cluster a zona singola
{: #ipvs_single_zone_config}

**Prima di iniziare**:

* **Importante**: completa i [prerequisiti di NLB 2.0](#ipvs_provision).
* Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio NLB. Per ulteriori informazioni, vedi [Configurazione delle sottoreti per i cluster](/docs/containers?topic=containers-subnets).
* Assicurati di disporre del [ruolo del servizio {{site.data.keyword.cloud_notm}} IAM **Scrittore** o **Gestore**](/docs/containers?topic=containers-users#platform) per lo spazio dei nomi `default`.

Per creare un servizio NLB 2.0 in un cluster a zona singola:

1.  [Distribuisci la tua applicazione al cluster](/docs/containers?topic=containers-app#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico.
2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre all'Internet pubblico o a una rete privata.
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
          <td>Annotazione per specificare un programma di bilanciamento del carico <code>private</code> o <code>public</code>.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Facoltativo: annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Annotazione per specificare un programma di bilanciamento del carico 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Facoltativo: annotazione per specificare un algoritmo di pianificazione. I valori accettati sono <code>"rr"</code> per Round Robin (predefinito) o <code>"sh"</code> per Source Hashing. Per ulteriori informazioni, vedi [2.0: Algoritmi di pianificazione](#scheduling).</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>La chiave (<em>&lt;selector_key&gt;</em>) e il valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> dello YAML di distribuzione della tua applicazione.</td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Facoltativo: per creare un NLB privato o utilizzare un indirizzo IP portatile specifico per un NLB pubblico, specifica l'indirizzo IP che vuoi utilizzare. L'indirizzo IP deve essere sulla VLAN che specifichi nelle annotazioni. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è solo su una VLAN privata, viene utilizzato un indirizzo IP privato portatile.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Imposta su <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Facoltativo: rendi disponibile il tuo servizio NLB solo per un intervallo limitato di indirizzi IP, specificando gli IP nel campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` è implementato da `kube-proxy` nel tuo cluster tramite regole Iptables sui nodi di lavoro. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verifica che il servizio NLB sia stato creato correttamente. Perché il servizio venga creato e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

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

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile assegnato al tuo servizio NLB.

4.  Se hai creato un NLB pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile dell'NLB e la porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Facoltativo: un servizio NLB rende anche disponibile la tua applicazione anche sulle NodePort del servizio. Puoi accedere alle [NodePort](/docs/containers?topic=containers-nodeport) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio NLB, vedi [Controllo del traffico in entrata nei servizi NLB (network load balancer) o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Successivamente, puoi [registrare un nome host NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Algoritmi di pianificazione
{: #scheduling}

Gli algoritmi di pianificazione determinano il modo in cui NLB 2.0 assegna le connessioni di rete ai pod della tua applicazione. Quando le richieste del client arrivano al tuo cluster, il servizio NLB instrada i pacchetti di richiesta ai nodi di lavoro in base all'algoritmo di pianificazione. Per utilizzare un algoritmo di pianificazione, specifica il suo nome breve Keepalived nell'annotazione del programma di pianificazione (scheduler) del tuo file di configurazione del servizio NLB: `service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Controlla i seguenti elenchi per vedere quali algoritmi di pianificazione sono supportati in {{site.data.keyword.containerlong_notm}}. Se non specifichi un algoritmo di pianificazione, viene utilizzato l'algoritmo Round Robin per impostazione predefinita. Per ulteriori informazioni, vedi la [documentazione Keepalived ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://www.Keepalived.org/doc/scheduling_algorithms.html).
{: shortdesc}

### Algoritmi di pianificazione supportati
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>L'NLB scorre l'elenco dei pod dell'applicazione durante l'instradamento delle connessioni ai nodi di lavoro, trattando allo stesso modo ciascun pod dell'applicazione. Round Robin è l'algoritmo di pianificazione predefinito per gli NLB versione 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>L'NLB genera una chiave di hash in base all'indirizzo IP di origine del pacchetto di richieste del client. Quindi, l'NLB cerca la chiave di hash in una tabella hash assegnata staticamente e inoltra la richiesta al pod dell'applicazione che gestisce gli hash di tale intervallo. Questo algoritmo garantisce che le richieste provenienti da un determinato client siano sempre indirizzate allo stesso pod dell'applicazione.</br>**Nota**: Kubernetes utilizza le regole Iptables, che comportano l'invio di richieste a un pod casuale sul nodo di lavoro. Per utilizzare questo algoritmo di pianificazione, devi assicurarti che non venga distribuito più di un pod della tua applicazione per ciascun nodo di lavoro. Ad esempio, se ogni pod ha l'etichetta <code>run=&lt;app_name&gt;</code>, aggiungi la seguente regola di anti-affinità alla sezione <code>spec</code> della tua distribuzione dell'applicazione:</br>
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
<dd>La destinazione del pacchetto, che è composta dall'indirizzo IP dell'NLB e dalla porta, viene utilizzata per determinare quale nodo di lavoro gestisce la richiesta in entrata. Tuttavia, l'indirizzo IP e la porta degli NLB in {{site.data.keyword.containerlong_notm}} non cambiano. All'NLB viene imposto di mantenere la richiesta nello stesso nodo di lavoro in cui si trova, quindi i pod dell'applicazione di un unico nodo di lavoro gestiscono tutte le richieste in entrata.</dd>
<dt>Algoritmi di conteggio dinamico delle connessioni</dt>
<dd>I seguenti algoritmi dipendono dal conteggio dinamico delle connessioni tra client e NLB. Tuttavia, poiché il DSR (direct service return) impedisce ai pod NLB 2.0 di trovarsi nel percorso del pacchetto restituito, gli NLB non tracciano le connessioni stabilite.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Algoritmi di pod ponderati</dt>
<dd>I seguenti algoritmi dipendono dai pod dell'applicazione ponderati. Tuttavia, in {{site.data.keyword.containerlong_notm}}, a tutti i pod dell'applicazione viene assegnato lo stesso peso per il bilanciamento del carico.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>
