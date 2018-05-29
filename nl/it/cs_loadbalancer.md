---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Esposizione delle applicazioni con LoadBalancers
{: #loadbalancer}

Esponi una porta e utilizza un indirizzo IP portatile per il programma di bilanciamento del carico per accedere a un'applicazione inserita in un contenitore.
{:shortdesc}

## Gestione del traffico di rete utilizzando LoadBalancers
{: #planning}

Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} richiede automaticamente cinque indirizzi IP pubblici portatili e cinque privati portatili e li fornisce nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) durante la creazione del cluster. Due degli indirizzi IP portatili, uno pubblico e uno privato, vengono utilizzati per i [programmi di bilanciamento del carico dell'applicazione Ingress](cs_ingress.html). Possono essere utilizzati quattro indirizzi IP privati e pubblici portatili per esporre le applicazioni creando un servizio del programma di bilanciamento del carico.

Quando crei un servizio Kubernetes LoadBalancer in un cluster in una VLAN pubblica, viene creato
un programma di bilanciamento del carico esterno. Le opzioni di indirizzi IP quando crei un servizio LoadBalancer sono le seguenti:

- Se il tuo cluster è su una VLAN pubblica, viene utilizzato uno dei quattro indirizzi IP pubblici portatili disponibili.
- Se il tuo cluster è disponibile solo su una VLAN privata, viene utilizzato uno dei quattro indirizzi IP privati portatili disponibili.
- Puoi richiedere un indirizzo IP pubblico o privato portatile per un servizio LoadBalancer aggiungendo un'annotazione al file di configurazione: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.

L'indirizzo IP pubblico portatile assegnato al tuo servizio
LoadBalancer è permanente e non viene modificato quando un nodo di lavoro viene rimosso
o ricreato. Pertanto, il servizio LoadBalancer è più disponibile del servizio NodePort. A differenza dei servizi NodePort, puoi assegnare una qualsiasi porta al tuo programma di bilanciamento del carico
e non è associato a un dato intervallo di porte. Se utilizzi un servizio LoadBalancer, è disponibile anche una porta del nodo per ogni indirizzo IP di ogni nodo di lavoro. Per bloccare l'accesso alla porta del nodo mentre stai utilizzando un servizio LoadBalancer, consulta [Blocco del traffico in entrata](cs_network_policy.html#block_ingress).

Il servizio
LoadBalancer funge da punto di ingresso per le richieste in entrata per l'applicazione. Per accedere al servizio LoadBalancer da internet,
utilizza l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata nel formato `<IP_address>:<port>`. Il seguente diagramma mostra come un programma di bilanciamento del carico dirige la comunicazione da Internet a un'applicazione:

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Esponi un'applicazione in {{site.data.keyword.containershort_notm}} utilizzando un programma di bilanciamento del carico" style="width:550px; border-style: none"/>

1. Viene inviata una richiesta alla tua applicazione utilizzando l'indirizzo IP pubblico del tuo programma di bilanciamento del carico e la porta assegnata sul nodo di lavoro.

2. La richiesta viene inoltrata automaticamente alla porta e all'indirizzo IP del cluster interno del servizio di bilanciamento del carico. L'indirizzo IP del cluster interno è accessibile solo all'interno del cluster.

3. `kube-proxy` instrada la richiesta al servizio di bilanciamento del carico Kubernetes per l'applicazione.

4. La richiesta viene inoltrata all'indirizzo IP privato del pod in cui è distribuita l'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, il programma di bilanciamento del carico instrada le richieste tra i pod dell'applicazione.




<br />




## Abilitazione dell'accesso pubblico o privato a un'applicazione utilizzando un servizio LoadBalancer
{: #config}

Prima di iniziare:

-   Questa funzione è disponibile solo per i cluster standard.
-   Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio di bilanciamento del carico.
-   Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di una porta del nodo pubblica aperta per i nodi di lavoro. Per aggiungere una politica di rete per evitare il traffico pubblico, consulta [Blocco del traffico in entrata](cs_network_policy.html#block_ingress).

Per creare un servizio del programma di bilanciamento del carico:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico.
2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
    1.  Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.

    2.  Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre.
        - Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.
        - Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.
        - Puoi richiedere un indirizzo IP pubblico o privato portatile per un servizio LoadBalancer aggiungendo un'annotazione al file di configurazione.

        Servizio LoadBalancer che utilizza un indirizzo IP predefinito:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        Servizio LoadBalancer che utilizza un'annotazione per specificare un indirizzo IP pubblico o privato:

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
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, assicurati che i valori di <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em> siano gli stessi della coppia chiave/valore che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> del tuo yaml di distribuzione.</td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare il tipo di LoadBalancer. I valori accettati sono `private` e `public`. Se crei un LoadBalancer pubblico nei cluster che si trovano su VLAN pubbliche, questa annotazione non è richiesta.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Per creare un LoadBalancer privato o per utilizzare uno specifico indirizzo IP portatile per un LoadBalancer pubblico, sostituisci <em>&lt;IP_address&gt;</em> con l'indirizzo IP che desideri utilizzare. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

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

4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Se scegli di [conservare l'indirizzo IP di origine del pacchetto in entrata![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) e avere nodi edge, nodi di lavoro solamente privati o più VLAN, assicurati che i pod dell'applicazione vengano inclusi nel bilanciamento del carico [aggiungendo l'affinità e le tolleranze del nodo ai pod dell'applicazione](#node_affinity_tolerations).

<br />


## Aggiunta dell'affinità e delle tolleranze del nodo ai pod dell'applicazione per l'IP di origine
{: #node_affinity_tolerations}

Quando distribuisci i pod dell'applicazione, anche i pod del servizio di bilanciamento del carico vengono distribuiti ai nodi di lavoro in cui vengono distribuiti i pod dell'applicazione. Tuttavia, ci sono alcune situazioni in cui i pod del bilanciamento del carico e quelli dell'applicazione potrebbero non essere pianificati sullo stesso nodo di lavoro:
{: shortdesc}

* Hai nodi edge corrotti in cui puoi distribuire solo i pod del servizio di bilanciamento del carico. I pod dell'applicazione non possono essere distribuiti in questi nodi. 
* Il tuo cluster è connesso a più VLAN pubbliche o private e i tuoi pod dell'applicazione possono essere distribuiti ai nodi di lavoro che sono connessi solo ad una VLAN. I pod del servizio di bilanciamento del carico non possono essere distribuiti in tali nodi di lavoro in quanto l'indirizzo IP del programma di bilanciamento è connesso ad una VLAN diversa da quella dei nodi di lavoro.

Quando una richiesta client alla tua applicazione viene inviata al tuo cluster, viene instradata ad un pod per il servizio di bilanciamento del carico Kubernetes che espone l'applicazione. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, il programma di bilanciamento inoltra la richiesta ad un nodo di lavoro diverso in cui è distribuito il pod dell'applicazione. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. 

Se desideri conservare l'indirizzo IP di origine originale della richiesta client, puoi [abilitare l'IP di origine![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) per i servizi di bilanciamento del carico. La conservazione dell'IP del client è utile quando, ad esempio, i server delle applicazioni devono applicare le politiche di sicurezza e di controllo dell'accesso. Una volta abilitato l'IP di origine, i pod del servizio di bilanciamento del carico devono inoltrare le richieste solo ai pod dell'applicazione che sono distribuiti nello stesso nodo di lavoro Per forzare la tua applicazione alla distribuzione in specifici nodi di lavoro in cui possono essere distribuiti anche i pod del servizio di bilanciamento del carico, devi aggiungere le regole di affinità e le tolleranze alla tua distribuzione dell'applicazione. 

### Aggiunta delle regole di affinità e delle tolleranze del nodo edge
{: #edge_nodes}

Quando [etichetti i nodi di lavoro come nodi edge](cs_edge.html#edge_nodes), i pod del servizio del programma di bilanciamento del carico vengono distribuiti solo in tali nodi edge. Se inoltre [danneggi i nodi edge](cs_edge.html#edge_workloads), i pod dell'applicazione non possono essere distribuiti nei nodi edge.
{:shortdesc}

Quando abiliti l'IP di origine, le richieste in entrata non possono essere inoltrate dal programma di bilanciamento del carico al tuo pod dell'applicazione. Per forzare la distribuzione dei tuoi pod dell'applicazione nei nodi edge, aggiungi la [regola di affinità ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) e la [tolleranza ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) del nodo edge alla distribuzione dell'applicazione. 

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

Nota: entrambe le sezioni **affinity** e **tolerations** hanno `dedicated` come `key` e `edge` come `value`.

### Aggiunta di regole di affinità per più VLAN pubbliche o private
{: #edge_nodes}

Quando il tuo cluster è connesso a più VLAN pubbliche o private, i tuoi pod dell'applicazione possono essere distribuiti solo nei nodi di lavoro connessi ad una VLAN. Se l'indirizzo IP del programma di bilanciamento del carico è connesso ad una VLAN diversa da quella di questi nodi di lavoro, i pod del servizio di bilanciamento del carico non verranno distribuiti in questi nodi di lavoro.
{:shortdesc}

Quando l'IP di origine è abilitato, pianifica i pod dell'applicazione sui nodi di lavoro che si trovano nella stessa VLAN dell'indirizzo IP del programma di bilanciamento del carico aggiungendo una regola di affinità alla distribuzione dell'applicazione. 

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

1. Ottieni l'indirizzo IP del servizio del programma di bilanciamento del carico che desideri utilizzare. Ricerca l'indirizzo IP nel campo **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Richiama l'ID VLAN a cui è connesso il tuo servizio del programma di bilanciamento del carico. 

    1. Elenca le VLAN pubbliche portatili per il tuo cluster.
        ```
        bx cs cluster-get <cluster_name_or_ID> --showResources
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

        Ad esempio, se l'indirizzo IP del servizio del programma di bilanciamento del carico è `169.36.5.xxx`, la sottorete corrispondente nell'output di esempio sopra riportato è `169.36.5.xxx/29`. L'ID VLAN a cui è connessa la sottorete è `2234945`.

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

    Nel file yaml sopra riportato, la sezione **affinity** ha `publicVLAN` come `key` e `"2234945"` come `value`.

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

        Nell'output di esempio sopra riportato, il pod dell'applicazione `cf-py-d7b7d94db-vp8pq` si trova sul nodo di lavoro `10.176.48.78`.

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

