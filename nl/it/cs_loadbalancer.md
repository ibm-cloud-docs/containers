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



# Esposizione di applicazioni con i programmi di bilanciamento del carico
{: #loadbalancer}

Esponi una porta e usa un indirizzo IP portatile per un programma di bilanciamento del carico di livello 4 per accedere a un'applicazione inserita in un contenitore.
{:shortdesc}



## Componenti del programma di bilanciamento del carico e architettura
{: #planning}

Quando crei un cluster standard, {{site.data.keyword.containerlong_notm}} esegue automaticamente il provisioning di una sottorete pubblica portatile e di una sottorete privata portatile.

* La sottorete pubblica portatile fornisce un indirizzo IP pubblico portatile che viene usato dall'[ALB Ingress pubblico](cs_ingress.html) predefinito. I restanti 4 indirizzi IP pubblici portatili possono essere usati per esporre le singole applicazioni su Internet creando un servizio del programma di bilanciamento del carico pubblico.
* La sottorete privata portatile fornisce un indirizzo IP privato portatile che viene usato dall'[ALB Ingress privato](cs_ingress.html#private_ingress) predefinito. I restanti 4 indirizzi IP privati portatili possono essere usati per esporre le singole applicazioni su una rete privata creando un servizio del programma di bilanciamento del carico privato.

Gli indirizzi IP pubblici e privati portatili sono statici e non cambiano quando viene rimosso un nodo di lavoro. Se il nodo di lavoro su cui si trova l'indirizzo IP del programma di bilanciamento del carico viene rimosso, un daemon Keepalive, che monitora costantemente l'IP, sposta automaticamente l'IP in un altro nodo di lavoro. Puoi assegnare una qualsiasi porta al tuo programma di bilanciamento del carico e non è associata a un dato intervallo di porte.

Un servizio del programma di bilanciamento del carico rende anche disponibili le applicazioni sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

Il servizio del programma di bilanciamento del carico funge da punto di ingresso per le richieste in entrata per l'applicazione. Per accedere al servizio del programma di bilanciamento del carico da Internet, utilizza l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata nel formato `<IP_address>:<port>`. Il seguente diagramma mostra come un programma di bilanciamento del carico dirige la comunicazione da Internet a un'applicazione.

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un programma di bilanciamento del carico" style="width:550px; border-style: none"/>

1. Una richiesta alla tua applicazione usa l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata sul nodo di lavoro.

2. La richiesta viene inoltrata automaticamente alla porta e all'indirizzo IP del cluster interno del servizio di bilanciamento del carico. L'indirizzo IP del cluster interno è accessibile solo all'interno del cluster.

3. `kube-proxy` instrada la richiesta al servizio di bilanciamento del carico Kubernetes per l'applicazione.

4. La richiesta viene inoltrata all'indirizzo IP privato del pod dell'applicazione. L'indirizzo IP di origine del pacchetto di richieste viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, il programma di bilanciamento del carico instrada le richieste tra i pod dell'applicazione.

**Cluster multizona**:

Se hai un cluster multizona, le istanze dell'applicazione vengono distribuite nei pod sui nodi di lavoro tra le diverse zone. Il seguente diagramma mostra come un classico programma di bilanciamento del carico dirige la comunicazione da Internet a un'applicazione in un cluster multizona.

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Usa un servizio del programma di bilanciamento del carico per bilanciare il carico delle applicazioni in cluster multizona" style="width:500px; border-style: none"/>

Per impostazione predefinita, ogni programma di bilanciamento del carico viene configurato solo in una zona. Per ottenere l'alta disponibilità, devi distribuire un programma di bilanciamento del carico in ogni zona in cui hai istanze dell'applicazione. Le richieste vengono gestite dai programmi di bilanciamento del carico in diverse zone in un ciclo round-robin. Inoltre, ciascun programma di bilanciamento del carico instrada le richieste alle istanze dell'applicazione nella sua zona e alle istanze dell'applicazione nelle altre zone.

<br />


## Abilitazione dell'accesso pubblico o privato a un'applicazione in un cluster multizona
{: #multi_zone_config}

Nota:
  * Questa funzione è disponibile solo per i cluster standard.
  * I servizi del programma di bilanciamento del carico non supportano la terminazione TLS. Se la tua applicazione richiede la terminazione TLS,
la puoi esporre utilizzando [Ingress](cs_ingress.html) o configurare la tua applicazione per gestire la terminazione TLS.

Prima di iniziare:
  * Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di un NodePort pubblico aperto per i nodi di lavoro. Per aggiungere una politica di rete per evitare il traffico pubblico, consulta [Blocco del traffico in entrata](cs_network_policy.html#block_ingress).
  * Devi distribuire un programma di bilanciamento del carico in ciascuna zona e a ciascun programma di bilanciamento del carico viene assegnato un proprio indirizzo IP in tale zona. Per creare dei programmi di bilanciamento del carico pubblici, almeno una VLAN pubblica deve avere delle sottoreti portatili disponibili in ciascuna zona. Per aggiungere dei servizi di programma di bilanciamento del carico privati, almeno una VLAN privata deve avere delle sottoreti portatili disponibili in ciascuna zona. Per aggiungere sottoreti, vedi [Configurazione delle sottoreti per i cluster](cs_subnets.html).
  * Se limiti il traffico di rete ai nodi di lavoro edge, assicurati che siano abilitati almeno 2 [nodi di lavoro edge](cs_edge.html#edge) in ciascuna zona. Se i nodi di lavoro edge sono abilitati in alcune zone ma non in altre, i programmi di bilanciamento del carico non verranno distribuiti uniformemente. I programmi di bilanciamento del carico verranno distribuiti sui nodi edge in alcune zone ma non sui nodi di lavoro regolari in altre zone.
  * Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).


Per configurare un servizio del programma di bilanciamento del carico in un cluster multizona:
1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico.

2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su Internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
  1. Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.
  2. Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre. Puoi specificare una zona e un indirizzo IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta da utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, controlla i valori <em>&lt;selectorkey&gt;</em> e <em>&lt;selectorvalue&gt;</em>. Assicurati che siano gli stessi della coppia <em>chiave/valore</em> che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> del tuo file yaml di distribuzione.</td>
      </tr>
      <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che vuoi utilizzare. Se specifichi una zona, l'indirizzo IP deve essere in quella VLAN o zona. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.</li></td>
      </tr>
      </tbody></table>

      File di configurazione di esempio per creare un classico servizio del programma di bilanciamento del carico privato che utilizza un indirizzo IP specificato nel campo `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
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

3. Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Sostituisci _&lt;myservice&gt;_ con il nome del servizio del programma di bilanciamento del carico che hai creato nel passo precedente.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **Nota:** perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

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

5. Se scegli di [abilitare la conservazione dell'IP di origine per un servizio del programma di bilanciamento del carico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assicurati che i pod dell'applicazione siano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](cs_loadbalancer.html#edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.

6. Per gestire le richieste in entrata alla tua applicazione dalle altre zone, ripeti i passi sopra riportati per aggiungere un programma di bilanciamento del carico in ciascuna zona.

7. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

## Abilitazione dell'accesso pubblico o privato a un'applicazione in un cluster a zona singola
{: #config}

Prima di iniziare:

-   Questa funzione è disponibile solo per i cluster standard.
-   Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio di bilanciamento del carico.
-   Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di un NodePort pubblico aperto per i nodi di lavoro. Per aggiungere una politica di rete per evitare il traffico pubblico, consulta [Blocco del traffico in entrata](cs_network_policy.html#block_ingress).

Per creare un servizio del programma di bilanciamento del carico:

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
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare il tipo di programma di bilanciamento del carico. I valori accettati sono `private` e `public`. Se crei un programma di bilanciamento del carico pubblico nei cluster che si trovano su VLAN pubbliche, questa annotazione non è richiesta.</td>
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
          <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che vuoi utilizzare. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.</li></td>
        </tr>
        </tbody></table>

        File di configurazione di esempio per creare un classico servizio del programma di bilanciamento del carico privato che utilizza un indirizzo IP specificato:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
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

3.  Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **Nota:** perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

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

5. Se scegli di [abilitare la conservazione dell'IP di origine per un servizio del programma di bilanciamento del carico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assicurati che i pod dell'applicazione siano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](cs_loadbalancer.html#edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.

6. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePorts del servizio. Puoi accedere alle [NodePorts](cs_nodeport.html) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio del programma di bilanciamento del carico, vedi [Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort](cs_network_policy.html#block_ingress).

<br />


## Aggiunta dell'affinità e delle tolleranze del nodo ai pod dell'applicazione per l'IP di origine
{: #node_affinity_tolerations}

Quando una richiesta client alla tua applicazione viene inviata al tuo cluster, la richiesta viene instradata al pod del servizio del programma di bilanciamento del carico che espone la tua applicazione. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, il programma di bilanciamento inoltra la richiesta a un pod dell'applicazione su un nodo di lavoro diverso. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione.

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

Esempio di yaml di distribuzione con affinità e tolleranza del nodo edge:

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

