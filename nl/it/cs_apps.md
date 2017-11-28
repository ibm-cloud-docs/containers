---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Distribuzione di applicazioni nei cluster
{: #cs_apps}

Puoi utilizzare le tecniche Kubernetes per distribuire le applicazioni e per assicurarti che siano sempre in esecuzione. Ad esempio, puoi eseguire aggiornamenti continui e rollback senza tempi di inattività per i tuoi utenti.
{:shortdesc}

La distribuzione di un'applicazione in genere include i seguenti passi.

1.  [Installa le CLI](cs_cli_install.html#cs_cli_install).

2.  Crea un file di configurazione per la tua applicazione. [Consulta le procedure consigliate da Kubernetes. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  Esegui il file di configurazione utilizzando uno dei seguenti metodi. 
    -   [La CLI Kubernetes](#cs_apps_cli)
    -   Il dashboard Kubernetes
        1.  [Avvia il dashboard Kubernetes.](#cs_cli_dashboard)
        2.  [Esegui il file di configurazione.](#cs_apps_ui)

<br />


## Avvio del dashboard Kubernetes
{: #cs_cli_dashboard}

Ari il dashboard Kubernetes nel tuo sistema locale per visualizzare le informazioni su un cluster e sui suoi nodi di lavoro.
{:shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster. Questa attività richiede la [politica di accesso Amministratore](cs_cluster.html#access_ov). Verifica la tua [politica
di accesso](cs_cluster.html#view_access) corrente.

Puoi utilizzare la porta predefinita o impostare una tua porta per avviare il dashboard Kubernetes per un cluster.
-   Avvia il tuo dashboard Kubernetes con la porta predefinita 8001.
    1.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        Il tuo output CLI si presenta così:

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    2.  Apri il seguente URL in un browser web per visualizzare il dashboard Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   Avvia il tuo dashboard Kubernetes con la tua porta.
    1.  Imposta il proxy con il tuo proprio numero di porta.

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  Apri il seguente URL in un browser.

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


Quando hai finito con il dashboard Kubernetes, utilizza `CTRL+C` per uscire dal
comando `proxy`. Dopo essere uscito, il dashboard Kubernetes non è più disponibile. Esegui nuovamente il comando `proxy` per riavviare il dashboard Kubernetes.

<br />


## Consentire l'accesso pubblico alle applicazioni
{: #cs_apps_public}

Per rendere un'applicazione pubblicamente disponibile, devi aggiornare il tuo file di configurazione
prima di distribuire l'applicazione in un cluster. {:shortdesc}

A seconda che il cluster da te creato sia lite o standard, esistono diversi modi per rendere la tua applicazione accessibile da Internet.

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">Servizio NodePort</a> (cluster lite e standard)</dt>
<dd>Esponi una porta pubblica su ogni nodo di lavoro e utilizza l'indirizzo IP pubblico di ognuno di questi nodi
per accedere pubblicamente al tuo servizio nel cluster. L'indirizzo IP pubblico del nodo di lavoro non è
permanente. Quando un nodo di lavoro viene rimosso
o ricreato, a tale nodo viene assegnato un nuovo indirizzo IP pubblico. Puoi utilizzare NodePort per verificare l'accesso pubblico per la tua applicazione
o se l'accesso pubblico è richiesto solo per un breve periodo. Se hai bisogno di un indirizzo IP pubblico stabile
e di una maggiore disponibilità per il tuo endpoint del servizio, esponi la tua applicazione utilizzando un servizio LoadBalancer o Ingress.</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">Servizio LoadBalancer</a> (solo cluster standard)</dt>
<dd>Ogni cluster standard viene fornito con 4 indirizzi IP pubblici e privati portatili che puoi utilizzare per
creare un programma di bilanciamento del carico TCP/ UDP esterno per la tua applicazione. Puoi personalizzare il tuo programma di bilanciamento del carico
esponendo una qualsiasi porta richiesta dalla tua applicazione. L'indirizzo IP pubblico portatile che viene assegnato al programma di bilanciamento del carico è permanente
e non cambia quando un nodo di lavoro viene ricreato nel cluster.

</br>
Se hai bisogno del bilanciamento del carico HTTP o HTTPS
per la tua applicazione e vuoi utilizzare una rotta pubblica per esporre più applicazioni nel tuo cluster
come servizi, utilizza il supporto integrato Ingress con {{site.data.keyword.containershort_notm}}.</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (solo cluster
standard)</dt>
<dd>Esponi più applicazioni nel tuo cluster creando un programma di bilanciamento del carico HTTP o HTTPS
esterno che utilizza un punto di ingresso pubblico protetto e univoco per instradare le richieste
in entrata alle tue applicazioni. Ingress è costituito da due componenti principali, la risorsa Ingress e il controller
Ingress. La risorsa Ingress definisce
le regole su come instradare e bilanciare il carico delle richieste in entrata per un'applicazione. Tutte le risorse Ingress
devono essere registrate con il controller Ingress che è in ascolto delle richieste del servizio HTTP o HTTPS e inoltra le richieste in base alle regole definite per
ogni risorsa Ingress. Utilizza Ingress se vuoi
implementare il tuo proprio programma di bilanciamento del carico con regole di instradamento personalizzate e
se hai bisogno della terminazione SSL per le tue applicazioni.

</dd></dl>

### Configurazione dell'accesso pubblico a un'applicazione utilizzando il tipo di servizio NodePort
{: #cs_apps_public_nodeport}

Rendi pubblicamente disponibile la tua applicazione utilizzando l'indirizzo IP pubblico di un qualsiasi nodo di lavoro in
un cluster ed esponendo una porta del nodo. Utilizza questa opzione per la verifica e per un accesso pubblico
a breve termine.
{:shortdesc}

Puoi esporre la tua applicazione come un servizio Kubernetes NodePort per i cluster lite o standard.

Per gli ambienti {{site.data.keyword.Bluemix_notm}} dedicato, l'indirizzo IP pubblico viene bloccato da un firewall. Per rendere la tua applicazione disponibile pubblicamente, utilizza invece un [Servizio LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress).

**Nota:** l'indirizzo IP pubblico di un nodo di lavoro non è permanente. Se è necessario ricreare un nodo di lavoro,
 a tale nodo viene assegnato un nuovo indirizzo IP pubblico. Se hai bisogno di un indirizzo IP pubblico stabile
e di una maggiore disponibilità per il tuo servizio, esponi la tua applicazione utilizzando un [Servizio LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress).




1.  Definisci un servizio [ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/service/) nel file di configurazione.
2.  Nella sezione `spec` per il servizio, aggiungi il tipo NodePort.

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  Facoltativo: nella sezione `ports`, aggiungi un valore NodePort compreso tra 30000 e 32767. Non specificare un NodePort già utilizzato da un altro servizio. Se non sai quale
NodePort sia già in uso, non assegnarne uno. Se non assegni un NodePort, ne
verrà assegnato uno casuale automaticamente.

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    Se vuoi specificare un
NodePort e vedere quali NodePort sono già in uso, puoi immettere il seguente
comando.

    ```
    kubectl get svc
    ```
    {: pre}

    Output:

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  Salva la modifiche.
5.  Ripeti i passi per creare un servizio per ogni applicazione.

    Esempio:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**Operazioni successive:**

Quando l'applicazione viene distribuita, puoi utilizzare l'indirizzo IP pubblico di qualsiasi nodo di lavoro e il NodePort
per formare l'URL pubblico per accedere all'applicazione da un browser.

1.  Ottieni l'indirizzo IP pubblico per un nodo di lavoro
nel cluster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Output:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
    ```
    {: screen}

2.  Se è stato assegnato un NodePort casuale, scopri quale è stato
assegnato.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Output:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    In questo esempio, la NodePort è `30872`.

3.  Forma l'URL con uno degli indirizzi IP pubblici del nodo di lavoro e la NodePort. Esempio: `http://192.0.2.23:30872`

### Configurazione dell'accesso a un'applicazione utilizzando il tipo di servizio LoadBalancer 
{: #cs_apps_public_load_balancer}

Esponi una porta e utilizza un indirizzo IP pubblico o privato portatile per il programma di bilanciamento del carico per accedere
all'applicazione. A differenza di un servizio NodePort, l'indirizzo IP portatile del servizio di bilanciamento del carico non dipende
dal nodo di lavoro su cui viene distribuita l'applicazione. Tuttavia, un servizio Kubernetes LoadBalancer è anche un servizio NodePort. Un servizio LoadBalancer rende la tua applicazione disponibile per la porta e l'indirizzo IP del programma di bilanciamento del carico e per le porte del nodo del servizio. 

 L'indirizzo IP portatile del programma di bilanciamento del carico viene assegnato
automaticamente e non cambia quando aggiungi o rimuovi i nodi di lavoro Il che significa che i servizi del programma di bilanciamento del carico sono più disponibili dei servizi NodePort. Gli utenti possono selezionare qualsiasi porta per
il programma di bilanciamento del carico e non sono limitati all'intervallo di porte di NodePort. Puoi usare i servizi di bilanciamento del carico
per i protocolli TCP e UDP.

Quando un account {{site.data.keyword.Bluemix_notm}} dedicato viene [abilitato per i cluster](cs_ov.html#setup_dedicated), puoi richiedere sottoreti remote da utilizzare per gli indirizzi IP del programma di bilanciamento del carico. [Apri un ticket di supporto](/docs/support/index.html#contacting-support) per creare la sottorete e quindi utilizza il comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) per aggiungere la sottorete al cluster.

**Nota:** i servizi del programma di bilanciamento del carico non supportano la chiusura TLS. Se la tua applicazione richiede la terminazione TLS,
la puoi esporre utilizzando [Ingress](#cs_apps_public_ingress) o configurare la tua applicazione per gestire la terminazione TLS. 

Prima di iniziare:

-   Questa funzione è disponibile solo per i cluster standard.
-   Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio di bilanciamento del carico. 
-   Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di una porta del nodo pubblica aperta per i nodi di lavoro. Per aggiungere una politica di rete per evitare il traffico pubblico, consulta [Blocco del traffico in entrata](cs_security.html#cs_block_ingress).

Per creare un servizio del programma di bilanciamento del carico:

1.  [Distribuisci la tua applicazione al cluster](#cs_apps_cli). Quando distribuisci la tua applicazione al cluster,
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
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
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
          name: <myservice>
          annotations: 
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private> 
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore
(<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua
applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno
questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato
quando hai distribuito la tua applicazione al cluster. </td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare il tipo di LoadBalancer. I valori sono `private` e `public`. Quando crei un LoadBalancer pubblico nei cluster su VLAN pubbliche, questa annotazione non è necessaria.
        </tbody></table>
    3.  Facoltativo: per utilizzare uno specifico indirizzo IP portatile per il tuo programma di bilanciamento del carico
disponibile per il tuo cluster, puoi specificare tale indirizzo IP includendo `loadBalancerIP` nella sezione spec. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/service/).
    4.  Facoltativo: configura un firewall specificando `loadBalancerSourceRanges` nella sezione spec. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).
    5.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando viene creato il tuo servizio del programma di bilanciamento del carico, viene automaticamente assegnato un
indirizzo IP portatile ad esso. Se non è disponibile alcun indirizzo IP portatile, è impossibile creare il servizio del programma di bilanciamento
del carico. 3.  Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Sostituisci
_&lt;myservice&gt;_ con il nome del servizio del programma di bilanciamento del carico che hai creato
nel passo precedente.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Nota:** perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    Output CLI di esempio:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile che è stato assegnato
al tuo servizio del programma di bilanciamento del carico.
4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta. Nell'esempio precedente, l'indirizzo IP pubblico portatile `192.168.10.38` è stato assegnato al servizio del programma di bilanciamento del carico.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### Configurazione dell'accesso pubblico a un'applicazione utilizzando il controller Ingress
{: #cs_apps_public_ingress}

Esponi più applicazioni nel tuo cluster creando risorse Ingress che vengono gestite dal
controller Ingress fornito da IBM. Il controller Ingress è un programma di bilanciamento del carico HTTP o HTTPS esterno che utilizza un punto di ingresso pubblico protetto e univoco
per instradare le richieste in entrata alle tue applicazioni all'interno o all'esterno del tuo cluster.

**Nota:** Ingress è disponibile solo per i cluster standard e richiede almeno due nodi di lavoro nel
cluster per garantire l'elevata disponibilità. La configurazione di Ingress richiede una [politica di accesso Amministratore](cs_cluster.html#access_ov). Verifica la tua [politica
di accesso](cs_cluster.html#view_access) corrente.

Quando crei un cluster standard, ti viene creato automaticamente un controller Ingress
al quale viene assegnato un indirizzo IP pubblico portatile e una rotta pubblica. Puoi configurare il
controller Ingress e definire singole regole di instradamento per ogni applicazione che esponi al
pubblico. Ad ogni applicazione esposta tramite Ingress viene assegnato un percorso univoco che viene aggiunto alla
rotta pubblica, in modo che tu possa utilizzare un URL univoco per accedere pubblicamente a un'applicazione nel tuo cluster.

Quando un account {{site.data.keyword.Bluemix_notm}} dedicato viene [abilitato per i cluster](cs_ov.html#setup_dedicated), puoi richiedere sottoreti remote da utilizzare per gli indirizzi IP del controller Ingress. Successivamente,
viene creato il controller Ingress e viene assegnata una rotta pubblica. [Apri un ticket di supporto](/docs/support/index.html#contacting-support) per creare la sottorete e quindi utilizza il comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) per aggiungere la sottorete al cluster.

Puoi
configurare il controller Ingress per i seguenti scenari.

-   [Utilizzare il dominio fornito da IBM senza la terminazione TLS](#ibm_domain)
-   [Utilizzare il dominio fornito da IBM con la terminazione TLS](#ibm_domain_cert)
-   [Utilizzare un dominio personalizzato e un certificato TLS per fornire la terminazione
TLS](#custom_domain_cert)
-   [Utilizzare il dominio fornito da IBM o un dominio personalizzato con la terminazione TLS per
accedere alle applicazioni all'esterno del tuo cluster](#external_endpoint)
-   [Personalizza il tuo controller Ingress con le annotazioni](#ingress_annotation)

#### Utilizzo del dominio fornito da IBM senza la terminazione TLS
{: #ibm_domain}

Puoi configurare il controller Ingress come un programma di bilanciamento del carico HTTP per le applicazioni nel tuo
cluster e utilizzare il dominio fornito da IBM per accedere alle tue applicazioni da Internet.

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.

Per configurare il controller Ingress:

1.  [Distribuisci la tua applicazione al cluster](#cs_apps_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.
2.  Crea un servizio Kubernetes per l'applicazione da esporre. Il controller
Ingress può includere la tua applicazione nel bilanciamento del carico Ingress solo se la tua applicazione viene esposta
tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
    2.  Definisci un servizio per l'applicazione che vuoi esporre al pubblico.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore
(<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua
applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno
questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato
quando hai distribuito la tua applicazione al cluster. </td>
         </tr>
         <tr>
         <td><code> port</code></td>
         <td>La porta su cui è in ascolto il servizio.</td>
         </tr>
         </tbody></table>
    3.  Salva le modifiche.
    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  Ripeti questi passi per ogni applicazione che vuoi esporre al pubblico.
3.  Richiama i dettagli del tuo cluster per visualizzare il dominio fornito da IBM. Sostituisci _&lt;mycluster&gt;_ con il nome del cluster in cui viene distribuita l'applicazione che vuoi
esporre al pubblico.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    L'output della CLI
sarà simile al seguente.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Puoi
visualizzare il dominio fornito da IBM nel campo **Dominio secondario Ingress**.
4.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal controller Ingress per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`. 
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM
per instradare il traffico di rete in entrata al servizio che hai creato in precedenza. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myingressname&gt;</em> con un nome per la tua risorsa Ingress.</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal
passo precedente.

        </br></br>
        <strong>Nota:</strong> non utilizzare * per il tuo host o lascia vuota
la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è
in ascolto la tua applicazione, in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes,
puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un
percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio associato e invia il traffico di rete al servizio e ai
pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere
configurata per l'ascolto su questo percorso.

        </br></br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root
e una porta specificata. In questo caso, definisci il percorso root come
<code>/</code> e non specificare un percorso individuale per la tua applicazione.
        </br>
        Esempi: <ul><li>Per <code>http://ingress_host_name/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://ingress_host_name/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        </br>
        <strong>Suggerimento:</strong> se vuoi configurare Ingress per l'ascolto su un percorso
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'<a href="#rewrite" target="_blank">annotazione di
riscrittura</a> per stabilire l'instradamento appropriato alla tua applicazione.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato
alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato
il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci
_&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **Nota:** perché la risorsa Ingress venga creata e l'applicazione sia disponibile
sull'Internet pubblico potrebbero essere richiesti alcuni minuti.
6.  In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### Utilizzo del dominio fornito da IBM con la terminazione TLS
{: #ibm_domain_cert}

Puoi configurare il controller Ingress per gestire le connessioni TLS in entrata per le tue
applicazioni, decrittografare il traffico di rete utilizzando il certificato TLS fornito da IBM e inoltrare
le risorse non crittografate alle applicazioni esposte nel tuo cluster.

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.

Per configurare il controller Ingress:

1.  [Distribuisci la tua applicazione al cluster](#cs_apps_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta identifica tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.
2.  Crea un servizio Kubernetes per l'applicazione da esporre. Il controller
Ingress può includere la tua applicazione nel bilanciamento del carico Ingress solo se la tua applicazione viene esposta
tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
    2.  Definisci un servizio per l'applicazione che vuoi esporre al pubblico.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore
(<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua
applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno
questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato
quando hai distribuito la tua applicazione al cluster. </td>
         </tr>
         <tr>
         <td><code> port</code></td>
         <td>La porta su cui è in ascolto il servizio.</td>
         </tr>
         </tbody></table>

    3.  Salva le modifiche.
    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Ripeti questi passi per ogni applicazione che vuoi esporre al pubblico.

3.  Visualizza il dominio fornito da IBM e il certificato TLS con la terminazione TLS. Sostituisci _&lt;mycluster&gt;_ con il nome del cluster in cui viene distribuita l'applicazione.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    L'output della CLI
sarà simile al seguente.

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Puoi
visualizzare il dominio fornito da IBM nel campo **Dominio secondario Ingress**  e il certificato fornito da
IBM nel campo **Segreto Ingress**.

4.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal controller Ingress per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`. 
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM
per instradare il traffico di rete in entrata ai tuoi servizi e il certificato fornito da IBM per
gestire per te la terminazione TLS. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per
creare un percorso univoco alla tua applicazione, ad esempio `https://ingress_domain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio
associato e invia il traffico di rete al servizio e successivamente ai pod in cui è in esecuzione l'applicazione.

        **Nota:** la tua applicazione deve essere in ascolto sul percorso che hai definito nella risorsa
Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è
in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come
`/` e non specificare un percorso individuale per la tua applicazione.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myingressname&gt;</em> con un nome per la tua risorsa Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal
passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;ibmtlssecret&gt;</em> con il nome dell'<strong>Host
Ingress</strong> fornito da IBM dal passo precedente. Questo certificato gestisce la terminazione TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal
passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è
in ascolto la tua applicazione, in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes,
puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un
percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio associato e invia il traffico di rete al servizio e ai
pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere
configurata per l'ascolto su questo percorso.

        </br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root
e una porta specificata. In questo caso, definisci il percorso root come
<code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br>
        Esempi: <ul><li>Per <code>http://ingress_host_name/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://ingress_host_name/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        <strong>Suggerimento:</strong> se vuoi configurare Ingress per l'ascolto su un percorso
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'<a href="#rewrite" target="_blank">annotazione di
riscrittura</a> per stabilire l'instradamento appropriato alla tua applicazione.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato
alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato
il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci
_&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** perché la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile sull'Internet pubblico potrebbero essere richiesti alcuni minuti.
6.  In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### Utilizzo del controller Ingress con un dominio personalizzato e un certificato TLS
{: #custom_domain_cert}

Puoi configurare il controller Ingress per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster e utilizzare il tuo proprio certificato TLS per gestire la terminazione TLS,
mentre utilizzi il tuo dominio personalizzato invece del dominio fornito da IBM.
{:shortdesc}

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.

Per configurare il controller Ingress:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) per registrare il tuo dominio personalizzato.
2.  Configura il tuo dominio per instradare il traffico di rete in entrata al controller
Ingress IBM. Scegli tra queste opzioni:
    -   Definisci un alias per il tuo dominio personalizzato specificando il dominio fornito da IBM come un record di nome canonico
(CNAME). Per trovare il dominio Ingress fornito da IBM, esegui `bx cs cluster-get <mycluster>` e cerca il campo **Dominio secondario Ingress**.
    -   Associa il tuo dominio personalizzato all'indirizzo IP pubblico portatile del controller Ingress fornito da IBM aggiungendo l'indirizzo IP come un record. Per trovare l'indirizzo IP pubblico portatile del controller Ingress:
        1.  Esegui `bx cs cluster-get <mycluster>` e cerca il campo **Dominio secondario Ingress**.
        2.  Esegui `nslookup <Ingress subdomain>`.
3.  Crea un certificato e una chiave TLS per il tuo dominio codificati in
formato PEM.
4.  Memorizza il certificato e la chiave TLS in un segreto
Kubernetes.
    1.  Apri il tuo editor preferito e crea un file di configurazione del segreto Kubernetes denominato,
ad esempio, `mysecret.yaml`.
    2.  Definisci un segreto che utilizza il certificato e la chiave TLS.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;mytlssecret&gt;</em> con un nome per il tuo segreto Kubernetes.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Sostituisci <em>&lt;tlscert&gt;</em> con il tuo certificato TLS personalizzato codificato in formato
base64.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Sostituisci <em>&lt;tlskey&gt;</em> con la tua chiave TLS personalizzata codificata in formato
base64.</td>
         </tbody></table>

    3.  Salva il tuo file di configurazione.
    4.  Crea il segreto TLS per il tuo cluster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Distribuisci la tua applicazione al cluster](#cs_apps_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.

6.  Crea un servizio Kubernetes per l'applicazione da esporre. Il controller
Ingress può includere la tua applicazione nel bilanciamento del carico Ingress solo se la tua applicazione viene esposta
tramite un servizio Kubernetes nel cluster.

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
    2.  Definisci un servizio per l'applicazione che vuoi esporre al pubblico.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore
(<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua
applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno
questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato
quando hai distribuito la tua applicazione al cluster. </td>
         </tr>
         <td><code> port</code></td>
         <td>La porta su cui è in ascolto il servizio.</td>
         </tbody></table>

    3.  Salva le modifiche.
    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Ripeti questi passi per ogni applicazione che vuoi esporre al pubblico.
7.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal controller Ingress per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`. 
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato
per instradare il traffico di rete in entrata ai tuoi servizi e il tuo certificato personalizzato per gestire la terminazione
TLS. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al tuo dominio personalizzato per
creare un percorso univoco alla tua applicazione, ad esempio `https://mydomain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio
associato e invia il traffico di rete al servizio e successivamente ai pod in cui è in esecuzione l'applicazione.

        **Nota:** è importante che l'applicazione sia in ascolto sul percorso che hai definito nella risorsa
Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è
in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come
`/` e non specificare un percorso individuale per la tua applicazione.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myingressname&gt;</em> con un nome per la tua risorsa Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il nostro dominio personalizzato che vuoi
configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;mytlssecret&gt;</em> con il nome del segreto che hai creato
in precedenza e che contiene il tuo certificato e la tua chiave TLS personalizzati per gestire la terminazione TLS per
il tuo dominio personalizzato.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il nostro dominio personalizzato che vuoi
configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è
in ascolto la tua applicazione, in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes,
puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un
percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio associato e invia il traffico di rete al servizio e ai
pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere
configurata per l'ascolto su questo percorso.

        </br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root
e una porta specificata. In questo caso, definisci il percorso root come
<code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br></br>
        Esempi: <ul><li>Per <code>https://mycustomdomain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>https://mycustomdomain/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        <strong>Suggerimento:</strong> se vuoi configurare Ingress per l'ascolto su un percorso
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'<a href="#rewrite" target="_blank">annotazione di
riscrittura</a> per stabilire l'instradamento appropriato alla tua applicazione.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato
alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato
il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Salva le modifiche.
    4.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci
_&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** perché la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile sull'Internet pubblico potrebbero essere richiesti alcuni minuti.

9.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### Configurazione del controller Ingress per instradare il traffico di rete alle applicazioni all'esterno
del cluster
{: #external_endpoint}

Puoi configurare il controller Ingress per le applicazioni che si trovano al di fuori del cluster
da includere nel bilanciamento del carico del cluster. Le richieste in entrata sul dominio fornito da IBM o sul tuo dominio
personalizzato vengono inoltrate automaticamente all'applicazione esterna.

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.
-   Assicurati che l'applicazione esterna che desideri includere nel bilanciamento del carico del cluster sia
accessibile mediante un indirizzo IP pubblico.

Puoi configurare il controller Ingress
per instradare il traffico di rete in entrata sul dominio fornito da IBM alle applicazioni che si trovano all'esterno
del cluster. Se invece vuoi utilizzare un dominio e un certificato TLS personalizzati, sostituisci
il dominio fornito da IBM e il certificato TLS con [il tuo dominio e il tuo certificato TLS personalizzati](#custom_domain_cert).

1.  Configura un endpoint Kubernetes che definisce la posizione esterna
dell'applicazione che desideri includere nel bilanciamento del carico del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione endpoint denominato,
ad esempio, `myexternalendpoint.yaml`. 
    2.  Definisci il tuo endpoint esterno. Includi tutti gli indirizzi IP pubblici e le porte
che puoi utilizzare per accedere alla tua applicazione esterna.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myendpointname&gt;</em> con il nome del tuo endpoint
Kubernetes.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Sostituisci <em>&lt;externalIP&gt;</em> con gli indirizzi IP pubblici per la connessione alla tua applicazione esterna.</td>
         </tr>
         <td><code> port</code></td>
         <td>Sostituisci <em>&lt;externalport&gt;</em> con la porta su cui è in ascolto la tua applicazione esterna.</td>
         </tbody></table>

    3.  Salva le modifiche.
    4.  Crea l'endpoint Kubernetes per il tuo cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  Crea un servizio Kubernetes per il tuo cluster e configuralo per
inoltrare le richieste in entrata all'endpoint esterno che hai creato in precedenza.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myexternalservice.yaml`.
    2.  Definisci il servizio.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Sostituisci <em>&lt;myexternalservice&gt;</em> con il nome del tuo servizio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>Sostituisci <em>&lt;myendpointname&gt;</em> con il nome dell'endpoint Kubernetes che hai
creato in precedenza.</td>
        </tr>
        <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
        </tr></tbody></table>

    3.  Salva le modifiche.
    4.  Crea il servizio Kubernetes per il tuo cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

3.  Visualizza il dominio fornito da IBM e il certificato TLS con la terminazione TLS. Sostituisci _&lt;mycluster&gt;_ con il nome del cluster in cui viene distribuita l'applicazione.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    L'output della CLI
sarà simile al seguente.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Puoi
visualizzare il dominio fornito da IBM nel campo **Dominio secondario Ingress**  e il certificato fornito da
IBM nel campo **Segreto Ingress**.

4.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal controller Ingress per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni esterne finché ogni applicazione è esposta con il proprio endpoint esterno
tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myexternalingress.yaml`. 
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM
e il certificato TLS per instradare il traffico di rete in entrata alla tua applicazione esterna utilizzando
l'endpoint esterno che hai creato in precedenza. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM o personalizzato per
creare un percorso univoco alla tua applicazione, ad esempio `https://ingress_domain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress
cerca il servizio associato e invia il traffico di rete al servizio e successivamente
all'applicazione esterna.

        **Nota:** è importante che l'applicazione sia in ascolto sul percorso che hai definito nella risorsa
Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è
in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come
/ e non specificare un percorso individuale per la tua applicazione.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myingressname&gt;</em> con il nome della risorsa Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal
passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;ibmtlssecret&gt;</em> con l'<strong>Host Ingress</strong> fornito da IBM dal passo precedente. Questo certificato gestisce la terminazione TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal
passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myexternalservicepath&gt;</em> con una barra o il percorso univoco su cui è
in ascolto la tua applicazione esterna, in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni
servizio Kubernetes puoi definire un percorso individuale che viene aggiunto al tuo dominio personalizzato per
creare un percorso univoco alla tua applicazione, ad esempio <code>https://ibmdomain/myservicepath1</code>. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio associato e invia il traffico di rete all'applicazione esterna
utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere
configurata per l'ascolto su questo percorso.

        </br></br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root
e una porta specificata. In questo caso, definisci il percorso root come
<code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br></br>
        <strong>Suggerimento:</strong> se vuoi configurare Ingress per l'ascolto su un percorso
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'<a href="#rewrite" target="_blank">annotazione di
riscrittura</a> per stabilire l'instradamento appropriato alla tua applicazione.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myexternalservice&gt;</em> con il nome del servizio che hai utilizzato
alla creazione del servizio Kubernetes per la tua applicazione esterna.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio.</td>
        </tr>
        </tbody></table>

    3.  Salva le modifiche.
    4.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci
_&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** perché la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile sull'Internet pubblico potrebbero essere richiesti alcuni minuti.

6.  Accedi alla tua applicazione esterna.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL per accedere alla tua applicazione esterna.

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}


#### Annotazioni Ingress supportate
{: #ingress_annotation}

Puoi specificare i metadati per la tua risorsa Ingress per aggiungere funzionalità al tuo controller
Ingress.
{: shortdesc}

|Annotazione supportata|Descrizione|
|--------------------|-----------|
|[Riscritture](#rewrite)|Instradare il traffico di rete in entrata a un percorso diverso su cui è in ascolto la tua applicazione di backend.|
|[Affinità della sessione con i cookie](#sticky_cookie)|Instrada sempre il tuo traffico di rete in entrata allo stesso server upstream utilizzando un cookie permanente.|
|[Intestazione della risposta o della richiesta del client aggiuntivo](#add_header)|Aggiungi ulteriori informazioni sull'intestazione a una richiesta client prima di inoltrarla alla tua applicazione di backend o a una risposta client prima di inviarla al client.|
|[Rimozione intestazione risposta client](#remove_response_headers)|Rimuovi le informazioni sull'intestazione da una risposta client prima di inoltrarla al client.|
|[Reindirizzamenti HTTP a HTTPS](#redirect_http_to_https)|Reindirizza le richieste HTTP nel tuo dominio a HTTPS.|
|[Buffer dei dati della risposta client](#response_buffer)|Disabilita il buffer di una risposta client al controller Ingress mentre la invii al client.|
|[Timeout di lettura e connessione personalizzati](#timeout)|Modifica il tempo in cui il controller Ingress attende il collegamento e la lettura da un'applicazione di backend prima che venga considerata non disponibile.|
|[Dimensione corpo richiesta client massima personalizzata](#client_max_body_size)|Modifica la dimensione del corpo della richiesta client che è consentito inviare al controller Ingress.|
|[Porte HTTP e HTTPS personalizzate](#custom_http_https_ports)|Modifica le porte predefinite per il traffico di rete HTTP e HTTPS.|


##### **Instradare il traffico di rete in entrata a un percorso diverso utilizzando le riscritture**
{: #rewrite}

Utilizza l'annotazione di riscrittura per instradare il traffico di rete in entrata su un percorso del dominio del controller Ingress
a un percorso diverso su cui è in ascolto la tua applicazione di back-end.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il tuo dominio del controller Ingress instrada il traffico di rete in entrata su <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> alla tua applicazione. La tua applicazione è in ascolto su <code>/coffee</code>, invece di <code>/beans</code>. Per inoltrare
il traffico di rete in entrata alla tua applicazione, aggiungi l'annotazione di riscrittura al tuo file di configurazione Ingress,
in modo che il traffico di rete in entrata su <code>/beans</code> venga inoltrato alla tua applicazione
utilizzando il percorso <code>/coffee</code>. Quando includi più servizi, utilizza solo un punto e virgola (;) per
separarli.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Sostituisci <em>&lt;service_name&gt;</em> con il nome del servizio Kubernetes che hai creato per la tua applicazione
e <em>&lt;target-path&gt;</em> con il percorso su cui è in ascolto la tua
applicazione. Il traffico di rete in entrata nel dominio del controller Ingress viene inoltrato al servizio Kubernetes
utilizzando tale percorso. La maggior parte delle applicazioni non è
in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci <code>/</code> come il
<em>rewrite-path</em> per la tua applicazione.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Sostituisci <em>&lt;domain_path&gt;</em> con il percorso che desideri aggiungere al tuo dominio del controller
Ingress. Il traffico di rete in entrata su questo percorso viene inoltrato al percorso di riscrittura
definito nella tua annotazione. Nel precedente esempio, imposta il percorso del dominio su <code>/beans</code> per includere
tale percorso nel bilanciamento del carico del tuo controller Ingress.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Sostituisci <em>&lt;service_name&gt;</em> con il nome del servizio Kubernetes che hai creato
per la tua applicazione. Il nome del servizio che qui utilizzi deve essere lo stesso nome che hai definito nella tua annotazione.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Sostituisci <em>&lt;service_port&gt;</em> con la porta su cui è in ascolto il tuo servizio.</td>
</tr></tbody></table>

</dd></dl>


##### **Instrada sempre il tuo traffico di rete in entrata allo stesso server upstream utilizzando un cookie permanente**
{: #sticky_cookie}

Utilizza l'annotazione cookie permanente per aggiungere l'affinità della sessione al tuo controller Ingress.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Le tue impostazioni dell'applicazione potrebbero aver bisogno di distribuire più server upstream che gestiscono le richieste client in entrata e che assicurano l'elevata disponibilità. Quando un client si collega alla tua applicazione di backend, potrebbe essere utile che un client utilizzi lo stesso server upstream per la durata di una sessione o per il tempo necessario al completamento di un'attività. Puoi configurare il tuo controller Ingress per garantire che l'affinità della sessione instradi sempre il traffico di rete in entrata allo stesso server upstream.

</br>
Ad ogni client che si collega alla tua applicazione di backend viene assegnato uno dei server upstream disponibili dal controller Ingress. Il controller Ingress crea un cookie di sessione che viene archiviato nell'applicazione del client e che viene incluso nelle informazioni dell'intestazione di ogni richiesta tra il controller Ingress e il client. Le informazioni nel cookie garantiscono che tutte le richieste vengano gestite dallo stesso server upstream nella sessione.

</br></br>
Quando includi più servizi, utilizza un un punto e virgola (;) per separarli.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Tabella 12. Descrizione dei componenti del file YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul><li><code><em>&lt;service_name&gt;</em></code>: il nome del servizio Kubernetes che hai creato
per la tua applicazione.</li><li><code><em>&lt;cookie_name&gt;</em></code>: scegli un nome del cookie permanente creato durante una sessione.</li><li><code><em>&lt;expiration_time&gt;</em></code>: il tempo in secondi, minuti o ore prima che il cookie permanente scada. Il tempo non è dipendente dall'attività utente. Dopo che il cookie è scaduto, viene eliminato dal browser web del client e non viene più inviato al controller Ingress. Ad esempio, per impostare un orario di scadenza di 1 secondo, 1 minuto o 1 ora, immetti <strong>1s</strong>, <strong>1m</strong> o <strong>1h</strong>.</li><li><code><em>&lt;cookie_path&gt;</em></code>: il percorso accodato al dominio secondario Ingress e che indica per quali domini e domini secondari il cookie viene inviato al controller Ingress. Ad esempio, se il tuo dominio Ingress è <code>www.myingress.com</code> e desideri inviare il cookie in ogni richiesta client, devi impostare <code>path=/</code>. Se desideri inviare il cookie solo per <code>www.myingress.com/myapp</code> e a tutti i relativi domini secondari, devi impostare <code>path=/myapp</code>.</li><li><code><em>&lt;hash_algorithm&gt;</em></code>: l'algoritmo hash che protegge le informazioni nel cookie. È
supportato solo <code>sha1</code>. SHA1 crea un riepilogo hash in base alle informazioni nel cookie e lo accoda ad esso. Il server può decrittografare le informazioni nel cookie e verificare l'integrità dei dati.</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **Aggiunta delle intestazioni HTTP personalizzate a una richiesta o risposta client**
{: #add_header}

Utilizza questa annotazione per aggiungere ulteriori informazioni sull'intestazione a una richiesta client prima di inviarla all'applicazione di backend o a una risposta client prima di inviarla al client.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il controller Ingress agisce come un proxy tra l'applicazione client e l'applicazione di backend. Le richieste client che vengono inviate al controller Ingress vengono elaborate (tramite proxy) e immesse in una nuova richiesta che viene inviata dal controller Ingress alla tua applicazione di backend. Il passaggio tramite proxy di una richiesta rimuove le informazioni dell'intestazione http, come il nome utente, che era stato inizialmente inviato dal client. Se l'applicazione di backend richiede queste informazioni, puoi utilizzare l'annotazione <strong>ingress.bluemix.net/proxy-add-headers</strong> per aggiungere le informazioni sull'intestazione alla richiesta client prima che venga inoltrata dal controller Ingress alla tua applicazione di backend.

</br></br>
Quando un'applicazione di backend invia una risposta al client, viene trasmessa tramite proxy e il controller Ingress e le intestazioni http vengono rimossi dalla risposta. L'applicazione web client potrebbe richiedere queste informazioni sull'intestazione per elaborare correttamente la risposta. Puoi utilizzare l'annotazione <strong>ingress.bluemix.net/response-add-headers</strong> per aggiungere le informazioni sull'intestazione alla risposta client prima che venga inoltrata dal controller Ingress alla tua applicazione web client.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul><li><code><em>&lt;service_name&gt;</em></code>: il nome del servizio Kubernetes che hai creato
per la tua applicazione.</li><li><code><em>&lt;header&gt;</em></code>: la chiave delle informazioni sull'intestazione da aggiungere alla richiesta o alla risposta client.</li><li><code><em>&lt;value&gt;</em></code>: il valore delle informazioni sull'intestazione da aggiungere alla richiesta o alla risposta client.</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **Rimozione delle informazioni sull'intestazione http da una risposta del client**
{: #remove_response_headers}

Utilizza questa annotazione per rimuovere le informazioni sull'intestazione incluse nella risposta client dall'applicazione di backend prima che venga inviata al client.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il controller Ingress agisce come un proxy tra la tua applicazione di backend e il browser web del client. Le risposte client che vengono inviate al controller Ingress vengono elaborate (tramite proxy) e immesse in una nuova risposta che viene inviata dal controller Ingress al browser web del client. Sebbene la trasmissione tramite proxy di una risposta rimuova le informazioni sull'intestazione http che erano state inizialmente inviate dall'applicazione di backend, questo processo potrebbe non rimuovere tutte le intestazione specifiche dell'applicazione di backend. Utilizza questa annotazione per rimuovere le informazioni sull'intestazione da una risposta client prima che venga inoltrata dal controller Ingress al browser web del client.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;service_name2&gt; {
      "&lt;header3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul><li><code><em>&lt;service_name&gt;</em></code>: il nome del servizio Kubernetes che hai creato
per la tua applicazione.</li><li><code><em>&lt;header&gt;</em></code>: la chiave dell'intestazione da rimuovere dalla risposta client.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **Reindirizzamento delle richieste http non sicure in https**
{: #redirect_http_to_https}

Utilizza l'annotazione di reindirizzamento per convertire le richieste http non sicure in https.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Configura il tuo controller Ingress per proteggere il tuo dominio sicuro con il certificato TLS fornito da IBM o con il certificato TLS personalizzato. Alcuni utenti potrebbero tentare di accedere alle tue applicazioni utilizzando una richiesta http non sicura al tuo dominio del controller Ingress, ad esempio <code>http://www.myingress.com</code>, invece di utilizzare <code>https</code>. Puoi utilizzare l'annotazione di reindirizzamento per convertire sempre le richieste http non sicure in https Se non utilizzi questa annotazione, le richieste http non sicure non vengono convertite in richieste https per impostazione predefinita e potrebbero esporre informazioni confidenziali pubblicamente senza crittografia.

</br></br>
Il reindirizzamento delle richieste http in https è disabilitato per impostazione predefinita.</dd>
<dt>YAML risorsa Ingress di esempio</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **Disabilitare il buffer delle risposte di backend nel tuo controller Ingress**
{: #response_buffer}

Utilizza l'annotazione del buffer per disabilitare l'archiviazione dei dati della risposta nel controller Ingress mentre i dati vengono inviati al client.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il controller Ingress agisce come un proxy tra la tua applicazione di backend e il browser web del client. Quando una risposta viene inviata dall'applicazione di backend al client, i dati della risposta vengono memorizzati nel buffer nel controller Ingress per impostazione predefinita. Il controller Ingress trasmette tramite proxy la risposta client e avvia l'invio della risposta al client al ritmo del client. Dopo che sono stati ricevuti tutti i dati dalla risposta di backend dal controller Ingress, il collegamento all'applicazione di backend viene chiuso. Il collegamento dal controller Ingress al client rimane aperto finché il client non ha ricevuto tutti i i dati.

</br></br>
Se il buffer dei dati della risposta nel controller Ingress è disabilitato, i dati vengono immediatamente inviati dal controller Ingress al client. Il client deve poter gestire i dati in entrata al ritmo del controller Ingress. Se il client è troppo lento, i dati potrebbero andare persi.
</br></br>
Il buffer dei dati della risposta nel controller Ingress è abilitato per impostazione predefinita.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **Configurazione di timeout di lettura e connessione personalizzati per il controller Ingress**
{: #timeout}

Modifica il tempo in cui il controller Ingress attende durante il collegamento e la lettura da un'applicazione di backend prima che venga considerata non disponibile.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Quando una richiesta client viene inviata al controller Ingress, viene aperto un collegamento all'applicazione di backend dal controller Ingress. Per impostazione predefinita, il controller Ingress attende per 60 secondi di ricevere una risposta dall'applicazione di backend. Se l'applicazione di backend non risponde entro 60 secondi, la richiesta di collegamento viene interrotta e l'applicazione di backend non viene considerata disponibile.

</br></br>
Dopo il collegamento del controller Ingress all'applicazione di backend, i dati della risposta dall'applicazione di backend vengono letti dal controller Ingress. Durante questa operazione di lettura, il controller Ingress attende un massimo di 60 secondi tra due operazioni di lettura per ricevere i dati dall'applicazione di backend. Se l'applicazione di backend non invia i dati entro 60 secondi, il collegamento all'applicazione di backend viene chiuso e l'applicazione non viene considerata disponibile.
</br></br>
Un timeout di collegamento e di lettura di 60 secondi è il timeout predefinito su un proxy e idealmente non dovrebbe essere modificato.
</br></br>
Se la disponibilità della tua applicazione non è stazionaria o la tua applicazione è lenta a rispondere a causa di elevati carichi di lavoro, potresti voler aumentare i timeout di collegamento o di lettura. Tieni presente che aumentando il timeout si influenzano le prestazioni del controller Ingress poiché il collegamento all'applicazione di backend deve rimanere aperto finché non viene raggiunto il timeout.
</br></br>
D'altra parte, puoi ridurre il timeout per migliorare le prestazioni del controller Ingress. Assicurati che la tua applicazione di backend possa gestire le richieste nel timeout specificato, anche durante elevati carichi di lavoro.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: immetti il numero di secondi da attendere per il collegamento all'applicazione di backend, ad esempio <strong>65s</strong>.

  </br></br>
  <strong>Nota:</strong> un timeout di collegamento non può superare 75 secondi.</li><li><code><em>&lt;read_timeout&gt;</em></code>: immetti il numero di secondi da attendere prima che venga letta l'applicazione di backend, ad esempio <strong>65s</strong>.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **Configurazione della dimensione consentita massima del corpo della richiesta client**
{: #client_max_body_size}

Modifica la dimensione del corpo che il client può inviare come parte di una richiesta.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per mantenere le prestazioni previste, la dimensione del corpo della richiesta client massima è impostata su 1 megabyte. Quando viene inviata una richiesta client con una dimensione oltre il limite al controller Ingress e il client non consente di suddividere i dati in parti più piccole, il controller Ingress restituisce al client una risposta http 413 (Entità richiesta troppo grande). Un collegamento tra il client e il controller Ingress non è possibile finché la dimensione del corpo della richiesta non viene ridotta. Quando il client consente che i dati vengano suddivisi in parti più piccole, vengono divisi in pacchetti di 1 megabyte e inviati al controller Ingress.

</br></br>
Potresti voler ridurre la dimensione del corpo massima perché ti attendi richieste client con una dimensione del corpo maggiore di 1 megabyte. Ad esempio, vuoi che il tuo client possa caricare file grandi. Aumentando la dimensione del corpo della richiesta massima potresti influenzare le prestazioni del tuo controller Ingress perché il collegamento al client deve rimanere aperto finché Non viene ricevuta la richiesta.
</br></br>
<strong>Nota:</strong> alcuni browser web del client non possono visualizzare il messaggio di risposta http 413 correttamente.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci il seguente valore:<ul><li><code><em>&lt;size&gt;</em></code>: immetti la dimensione massima del corpo della risposta client. Ad esempio, per impostarla su 200 megabyte, definisci <strong>200m</strong>.

  </br></br>
  <strong>Nota:</strong> puoi impostare la dimensione su 0 per disabilitare il controllo della dimensione del corpo della richiesta client.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>
  

##### **Modifica delle porte predefinite per il traffico di rete HTTP e HTTPS**
{: #custom_http_https_ports}

Utilizza questa annotazione per modificare le porte predefinite per il traffico di rete HTTP (porta 80) e HTTPS (porta 443).
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per impostazione predefinita, il controller Ingress è configurato per essere in ascolto sul traffico di rete HTTP in entrata sulla porta 80 e per HTTPS sulla porta 443. Puoi modificare le porte predefinite per aggiungere sicurezza al tuo dominio del controller Ingress o per abilitare solo una porta HTTPS.
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/custom-port: "protocol=&lt;protocol1&gt; port=&lt;port1&gt;;protocol=&lt;protocol2&gt;port=&lt;port2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul><li><code><em>&lt;protocol&gt;</em></code>: immetti <strong>http</strong> o <strong>https</strong> per modificare la porta predefinita per il traffico di rete HTTP o HTTPS in entrata.</li>
  <li><code><em>&lt;port&gt;</em></code>: immetti il numero di porta che desideri utilizzare per il traffico di rete HTTP o HTTPS in entrata.</li></ul>
  <p><strong>Nota:</strong> quando viene specificata una porta personalizzata per HTTP o HTTPS, le porte predefinite non sono più valide. Ad esempio, per modificare la porta predefinita per HTTPS in 8443, ma utilizzare la porta predefinita per HTTP, devi impostare le porte personalizzate per entrambe: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p>
  </td>
  </tr>
  </tbody></table>

  </dd>
  <dt>Utilizzo</dt>
  <dd><ol><li>Controlla le porte aperte del tuo controller Ingress.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
L'output della CLI sarà simile al seguente: 
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>Apri la mappa di configurazione del controller Ingress.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Aggiungi le porte HTTP e HTTPS non predefinite alla mappa di configurazione. Sostituisci &lt;port&gt; con la porta HTTP o HTTPS che desideri aprire.
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
data:
  public-ports: &lt;port1&gt;;&lt;port2&gt;
metadata:
  creationTimestamp: 2017-08-22T19:06:51Z
  name: ibm-cloud-provider-ingress-cm
  namespace: kube-system
  resourceVersion: "1320"
  selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
  uid: &lt;uid&gt;</code></pre></li>
  <li>Verifica che il tuo controller Ingress sia stato riconfigurato con le porte non predefinite.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
L'output della CLI sarà simile al seguente: 
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>Configura il tuo Ingress in modo che utilizzi le porte non predefinite quando instrada il traffico di rete ai tuoi servizi. Utilizza il file YAML di esempio in questo riferimento. </li>
<li>Aggiorna la configurazione del tuo controller Ingress.
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>Apri il tuo browser web preferito per accedere alla tua applicazione. Esempio: <code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>








<br />


## Gestione di sottoreti e indirizzi IP
{: #cs_cluster_ip_subnet}

Puoi utilizzare le sottoreti private e pubbliche e gli indirizzi IP per esporre le applicazioni nel tuo cluster e renderle accessibili da internet o da una rete privata.
{:shortdesc}

In {{site.data.keyword.containershort_notm}}, puoi aggiungere IP portatili
stabili per i servizi Kubernetes aggiungendo delle sottoreti di rete al cluster. Quando crei un
cluster standard, {{site.data.keyword.containershort_notm}} fornisce automaticamente
una sottorete pubblica portatile e 5 indirizzi IP privati e pubblici portatili. Gli indirizzi IP portatili sono
statici e non cambiano alla rimozione di un nodo di lavoro o di un cluster. 

 Due degli indirizzi IP portatili, uno pubblico e uno privato, vengono utilizzati per il [controller Ingress](#cs_apps_public_ingress) che puoi
utilizzare per esporre più applicazioni nel tuo cluster utilizzando una rotta pubblica. Possono essere utilizzati 4 indirizzi IP privati e 4 pubblici portatili per esporre le applicazioni
[creando un servizio del programma di bilanciamento del carico](#cs_apps_public_load_balancer). 

**Nota:** gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se scegli di rimuovere gli indirizzi IP pubblici portatili
dopo il provisioning del tuo cluster, devi comunque pagare l'addebito mensile, anche se li hai utilizzati
solo per un breve periodo di tempo.



1.  Crea un file di configurazione del servizio Kubernetes denominato
`myservice.yaml` e definisci un servizio di tipo `LoadBalancer` con
un indirizzo IP del programma di bilanciamento del carico fittizio. Il seguente esempio utilizza l'indirizzo IP 1.1.1.1 come
indirizzo IP del programma di bilanciamento del carico.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Crea il servizio nel tuo cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Controlla il servizio.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** la creazione di questo servizio non riesce perché il master Kubernetes non può trovare l'indirizzo
IP del programma di bilanciamento del carico specificato nella mappa di configurazione Kubernetes. Quando esegui questo comando, puoi visualizzare il
messaggio di errore e l'elenco di indirizzi IP pubblici disponibili per il cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### Liberazione degli indirizzi IP utilizzati 
{: #freeup_ip}

Puoi liberare un indirizzo IP portatile utilizzato eliminando il servizio di bilanciamento del carico
che utilizza tale indirizzo IP. 

[Prima di iniziare, imposta il contesto
per il cluster che desideri utilizzare.](cs_cli_install.html#cs_cli_configure)

1.  Elenca i servizi disponibili nel tuo cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Rimuovi il servizio di bilanciamento del carico che utilizza un indirizzo IP pubblico o privato. 

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## Distribuzione di applicazioni con la GUI
{: #cs_apps_ui}

Quando distribuisci un'applicazione al tuo cluster utilizzando il dashboard Kubernetes, viene automaticamente creata una risorsa di distribuzione
che crea, aggiorna e gestisce i pod nel tuo cluster. {:shortdesc}

Prima di iniziare:

-   Installa le [CLI](cs_cli_install.html#cs_cli_install) richieste.
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per distribuire la tua applicazione:

1.  [Apri il dashboard Kubernetes](#cs_cli_dashboard).
2.  Dal dashboard Kubernetes, fai clic su **+ Create**.
3.  Seleziona **Specify app details below** per immettere i dettagli dell'applicazione nella GUI o **Upload a YAML or JSON file** per caricare il tuo [file di configurazione dell'applicazione ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). Utilizza [questo file YAML di esempio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) per distribuire un contenitore dall'immagine **ibmliberty** nella regione Stati Uniti Sud.
4.  Nel dashboard Kubernetes, fai clic su **Deployments** per verificare che la distribuzione sia stata creata.
5.  Se rendi la tua applicazione disponibile pubblicamente utilizzando un servizio della porta del nodo, un servizio del programma di bilanciamento del carico o Ingress, verifica di poter accedere all'applicazione.

<br />


## Distribuzione di applicazioni con la CLI
{: #cs_apps_cli}

Dopo aver creato un cluster, puoi distribuire un'applicazione in tale cluster utilizzando la CLI Kubernetes.
{:shortdesc}

Prima di iniziare:

-   Installa le [CLI](cs_cli_install.html#cs_cli_install) richieste.
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per distribuire la tua applicazione:

1.  Crea un file di configurazione basato sulle [Procedure consigliate Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/overview/). Generalmente, un file di configurazione contiene i dettagli di configurazione per ognuna delle risorse
che crei in Kubernetes. Il tuo script potrebbe includere una o più delle seguenti sezioni:

    -   [Distribuire ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): definisce la creazione di pod e serie di repliche. Un pod include una singola
applicazione inserita nel contenitore e le serie di repliche controllano più istanze dei pod.

    -   [Servizio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/service/): fornisce accesso di front-end ai pod utilizzando un nodo di lavoro o un indirizzo IP pubblico del programma di bilanciamento del carico o una rotta Ingress pubblica.

    -   [Ingress ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/ingress/): specifica un tipo di programma di bilanciamento del carico che fornisce le rotte per accedere alla tua applicazione pubblicamente.

2.  Esegui il file di configurazione nel contesto di un cluster.

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  Se rendi la tua applicazione disponibile pubblicamente utilizzando un servizio della porta del nodo, un servizio del programma di bilanciamento del carico o Ingress, verifica di poter accedere all'applicazione.

<br />


## Ridimensionamento delle applicazioni 
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

Distribuisci le applicazioni cloud che rispondono alle variazioni della domanda per le tue applicazioni e
che utilizzano risorse solo quando necessario. Il ridimensionamento automatico aumenta o riduce il numero di istanze
delle tue applicazione in base alla CPU. {:shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

**Nota:** cerchi informazioni sul ridimensionamento delle applicazioni Cloud Foundry? Controlla [IBM Auto-Scaling per {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html).

Con Kubernetes, puoi abilitare [Horizontal Pod Autoscaling ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) per ridimensionare le tue applicazioni in base alla CPU.

1.  Distribuisci la tua applicazione al cluster dalla CLI. Quando distribuisci la tua applicazione, devi richiedere la CPU.

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>L'applicazione che desideri distribuire.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>La CPU richiesta per il contenitore, specificata in milli-core. Ad esempio,
<code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>Se true, crea un servizio esterno.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>La porta dove la tua applicazione è disponibile esternamente.</td>
    </tr></tbody></table>

    **Nota:** per distribuzioni più complesse, potresti dover creare uno [file di configurazione](#cs_apps_cli).
2.  Crea un Horizontal Pod Autoscaler e definisci la tua politica. Per ulteriori informazioni sull'utilizzo del comando `kubetcl autoscale`, consulta la
[documentazione Kubernetes
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Understanding this command&apos;s components</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>L'utilizzo medio della CPU mantenuto da Horizontal Pod Autoscaler, che viene specificato
come percentuale.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>Il numero minimo di pod distribuiti utilizzati per mantenere la percentuale di utilizzo della CPU
specificata.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>Il numero massimo di pod distribuiti utilizzati per mantenere la percentuale di utilizzo della CPU
specificata.</td>
    </tr>
    </tbody></table>

<br />


## Gestione delle distribuzioni graduali
{: #cs_apps_rolling}

Puoi gestire la distribuzione delle modifiche in modo automatizzato e controllato. Se la distribuzione
non avviene secondo i tuoi piani, puoi riportarla alla revisione
precedente.
{:shortdesc}

Prima di iniziare, crea una [distribuzione](#cs_apps_cli).

1.  [Distribuisci ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) una modifica. Ad esempio, potresti voler modificare l'immagine che hai utilizzato nella tua distribuzione iniziale.

    1.  Ottieni il nome della distribuzione.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Ottieni il nome del pod.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Ottieni il nome del contenitore in esecuzione nel pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Configura la nuova immagine per la distribuzione da utilizzare.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    Quando esegui i comandi, la modifica viene immediatamente applicata e registrata nella cronologia di distribuzione.

2.  Controlla lo stato della tua distribuzione.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Annulla una modifica.
    1.  Visualizza la cronologia di distribuzione e identifica il numero di revisione della tua ultima distribuzione.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Suggerimento:** per visualizzare i dettagli di una revisione specifica, includi il numero di revisione.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Riporta la distribuzione alla versione precedente o specifica una revisione. Per tornare alla versione precedente, utilizza il seguente comando.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />


## Aggiunta di servizi {{site.data.keyword.Bluemix_notm}}
{: #cs_apps_service}

I segreti Kubernetes crittografati sono utilizzati per memorizzare i dettagli e le credenziali del servizio {{site.data.keyword.Bluemix_notm}}
e consentono una comunicazione sicura tra il servizio e il cluster. In qualità di utente del cluster,
puoi accedere a questo segreto montandolo come volume in un pod.
{:shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster. Accertati che il servizio {{site.data.keyword.Bluemix_notm}} che vuoi usare nella tua applicazione sia stato [aggiunto al cluster](cs_cluster.html#cs_cluster_service) dall'amministratore del cluster.

I segreti Kubernetes rappresentano un modo sicuro per memorizzare informazioni riservate, quali nome utente, password o
chiavi. Anziché esporre informazioni riservate attraverso le variabili di ambiente o direttamente nel
Dockerfile, i segreti devono essere montati come volume segreto in un pod per renderli accessibili a un
contenitore in esecuzione in un pod.

Quando monti un volume segreto nel tuo pod, un file denominato binding viene memorizzato nella directory di montaggio del volume che include tutte le informazioni e credenziali di cui hai bisogno per accedere al servizio {{site.data.keyword.Bluemix_notm}}.

1.  Elenca i segreti disponibili nello spazio dei nomi del cluster.

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    Output di esempio:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Cerca un segreto di tipo **Opaco** e prendi nota del
**nome** del segreto. Se sono presenti più segreti, contatta il tuo amministratore cluster per identificare il segreto del servizio
corretto.

3.  Apri il tuo editor preferito.

4.  Crea un file YAML per configurare un pod che possa accedere ai dettagli del servizio tramite un volume
segreto.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Il nome del volume segreto che vuoi montare nel tuo contenitore.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Immetti un nome per il volume segreto che vuoi montare nel tuo contenitore.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Imposta le autorizzazioni di sola lettura per il segreto del servizio.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Immetti il nome del segreto di cui hai preso nota in precedenza.</td>
    </tr></tbody></table>

5.  Crea il pod e monta il volume segreto.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  Verifica che il pod sia stato creato.

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    Output CLI di esempio:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  Prendi nota del **NOME** del tuo pod.
8.  Ottieni i dettagli relativi al pod e cerca il nome del segreto.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Output:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  Quando implementi la tua applicazione, configurala per trovare il file del segreto denominato **binding** nella
directory di montaggio, analizza il contenuto JSON e determina l'URL e le credenziali del servizio per accedere al tuo servizio
{{site.data.keyword.Bluemix_notm}}.

Puoi ora accedere ai dettagli e alle credenziali del servizio {{site.data.keyword.Bluemix_notm}}. Per lavorare con il servizio {{site.data.keyword.Bluemix_notm}}, assicurati che la tua applicazione sia
configurata per trovare il file del segreto del servizio nella directory di montaggio, analizzare il contenuto JSON e
determinare i dettagli del servizio.

<br />


## Creazione di archiviazione persistente
{: #cs_apps_volume_claim}

Crea un'attestazione di un volume persistente (pvc) per eseguire il provisioning dell'archivio file NFS per il tuo cluster. Poi, monta questa attestazione in un pod per assicurarti che i dati siano disponibili anche se il pod ha un arresto anomalo o viene spento.
{:shortdesc}

L'archivio file NFS che ospita il volume persistente
viene inserito in cluster da IBM per fornire elevata disponibilità per i tuoi dati.

1.  Rivedi le classi di archiviazione disponibili. {{site.data.keyword.containerlong}} fornisce otto
classi di archiviazione predefinite in modo che l'amministratore del cluster non debba creare tutte le classi
archiviazione. La classe di archiviazione `ibmc-file-bronze` è uguale a `default`.

    ```
    kubectl get storageclasses
    ```
    {: pre}
    
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file 
    ```
    {: screen}

2.  Decidi se vuoi salvare i tuoi dati e la condivisione del file NFS dopo che hai eliminato il pvc. Se vuoi conservare i tuoi dati, scegli una classe di archiviazione `retain`. Se vuoi che i tuoi dati e la tua condivisione file vengano eliminati insieme al pvc, scegli una classe di archiviazione senza `retain`.

3.  Rivedi gli IOPS di una classe di archiviazione e le dimensioni di archiviazione disponibili. 
    - Le classi di archiviazione bronze, silver e gold utilizzano l'archiviazione di durata e dispongo di un solo IOPS definito per GB per ogni classe. Il totale di IOPS dipende dalla dimensione dell'archiviazione. Ad esempio, 1000Gi pvc a 4 IOPS per GB ha un totale di 4000 IOPS.
 
    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    Il campo **parametri** fornisce gli IOPS per GB associati alla classe di archiviazione
e le dimensioni disponibili in gigabyte.

    ```
    Parametri:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}
    
    - Le classi di archiviazione personalizzate utilizzano
[Performance storage ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/performance-storage) e hanno diverse opzioni per dimensione e IOPS totali.

    ```
    kubectl describe storageclasses ibmc-file-retain-custom 
    ```
    {: pre}

    Il campo **parametri** fornisce gli IOPS associati alla classe di archiviazione
e le dimensioni disponibili in gigabyte. Ad esempio, un pvc 40Gi può selezionare IOPS che è un multiplo di 100 nell'intervallo 100 - 2000 IOPS.

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  Crea un file di configurazione per definire la tua attestazione del volume persistente
e salva la configurazione come un file `.yaml`. 
    
    Esempio di classi bronze, silver, gold:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}
    
    Esempio di classi personalizzate:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Immetti il nome dell'attestazione del volume persistente.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Specifica la classe di archiviazione del volume persistente:
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS per GB.</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS per GB.</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS per GB.</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom: più valori di IOPS disponibili.

    </li> Se non specifichi alcuna classe di archiviazione, il volume persistente viene creato con la classe di archiviazione bronze. </td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Se scegli una dimensione diversa da quella elencata, la dimensione viene arrotondata per eccesso. Se selezioni una dimensione superiore a quella più grande, la dimensione viene arrotondata per difetto.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Questa opzione è solo per ibmc-file-custom / ibmc-file-retain-custom. Specifica il totale di IOPS per l'archiviazione. Esegui `kubectl describe storageclasses ibmc-file-custom` per visualizzare tutte le opzioni. Se scegli un IOPS diverso da quello elencato, viene arrotondato per eccesso. </td>
    </tr>
    </tbody></table>

5.  Crea l'attestazione del volume persistente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Verifica che la tua attestazione del volume persistente sia stata creata e collegata al volume persistente. Questo processo può richiedere qualche minuto.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    Il tuo output sarà simile al seguente.

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}Per montare l'attestazione del volume persistente al tuo pod, crea un file di configurazione. Salva la configurazione come un file `.yaml` file.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Il nome del pod.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Il percorso assoluto della directory in cui viene montato il volume nel contenitore.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>Il nome del volume che monti nel tuo contenitore.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Il nome del volume che monti nel tuo contenitore. Normalmente questo nome è lo stesso di
<code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>Il nome dell'attestazione del volume persistente che desideri utilizzare per il tuo volume. Quando monti
il volume nel pod, Kubernetes identifica il volume persistente associato all'attestazione del volume persistente
e abilita l'utente a leggere e scrivere nel volume persistente.</td>
    </tr>
    </tbody></table>

8.  Crea il pod e monta l'attestazione del volume persistente nel tuo pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  Verifica che il volume sia stato correttamente montato nel tuo pod.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Il punto di montaggio è nel campo **Volume Mounts** e il volume nel campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />


## Aggiunta di accesso utente non root alla archiviazione persistente
{: #cs_apps_volumes_nonroot}

Gli utenti non root non dispongono dell'autorizzazione di scrittura nel percorso di montaggio del volume per l'archiviazione di backend NFS. Per concedere l'autorizzazione di scrittura,
devi modificare il Dockerfile dell'immagine per creare una directory nel percorso di montaggio con
l'autorizzazione corretta.
{:shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Se stai progettando un'applicazione con un utente non root che richiede l'autorizzazione di scrittura nel volume,
devi aggiungere i seguenti processi al tuo Dockerfile e al tuo script di punto di ingresso:

-   Creare un utente non root.
-   Aggiungere temporaneamente l'utente al gruppo root.
-   Creare una directory nel percorso di montaggio volume con le autorizzazioni utente corrette.

Per {{site.data.keyword.containershort_notm}}, il proprietario predefinito del percorso di montaggio del volume è `nobody`. Con l'archiviazione NFS, se il proprietario non esiste localmente nel pod, viene creato l'utente `nobody`. I volumi sono configurati per riconoscere
l'utente root nel contenitore, che per alcune applicazioni, è l'unico utente all'interno del contenitore. Tuttavia, molte applicazioni specificano un utente non root diverso da `nobody` che scrive nel percorso di montaggio del contenitore.

1.  Creare un Dockerfile in una directory locale. Questo Dockerfile di esempio crea un utente non root denominato `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Crea un gruppo e un utente con GID e UID 1010.
    # In questo caso stai creando un gruppo e un utente denominati myguest.
    # Il GUID e l'UID 1010 è improbabile che creino un conflitto con un GUID o un UID utente esistenti nell'immagine.
    # Il GUID e l'UID devono essere compresi tra 0 e 65536. Altrimenti, la creazione del contenitore ha esito negativo.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Crea lo script di punto di ingresso nella stessa cartella locale del Dockerfile. Questo script di punto di ingresso di esempio specifica
`/mnt/myvol` come percorso di montaggio del volume.

    ```
    #!/bin/bash
    set -e

    #Questo è il punto di montaggio per il volume condiviso.
    #Per impostazione predefinita il punto di montaggio è gestito dall'utente root.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # Questa funzione crea una directory secondaria gestita
    # dall'utente non root nel percorso di montaggio del volume condiviso.
    create_data_dir() {
      #Aggiungi l'utente non root al gruppo primario dell'utente root.
      usermod -aG root $MY_USER

      #Fornisci l'autorizzazione di lettura-scrittura-esecuzione al gruppo per il percorso di montaggio del volume condiviso.
      chmod 775 $MOUNTPATH

      # Crea una directory nel percorso condiviso gestito dall'utente non root myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #Per sicurezza, rimuovi l'utente non root dal gruppo di utenti root.
      deluser $MY_USER root

      #Modifica il percorso di montaggio del volume condiviso con l'autorizzazione di lettura-scrittura-esecuzione originale.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    #Questo comando crea un processo a esecuzione prolungata per lo scopo di questo esempio.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Accedi a {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

4.  Crea l'immagine in locale. Ricorda di sostituire _&lt;mio_spazionomi&gt;_ con lo spazio dei nomi del tuo registro delle immagini
privato. Esegui `bx cr namespace-get` se devi trovare il tuo spazio dei nomi.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  Invia l'immagine al tuo spazio dei nomi in {{site.data.keyword.registryshort_notm}}.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  Crea un'attestazione del volume persistente creando un file `.yaml` di configurazione. Questo esempio utilizza una classe di archiviazione delle prestazioni inferiore. Esegui `kubectl get storageclasses` per visualizzare le classi di archiviazione disponibili.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Crea l'attestazione del volume persistente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Crea un file di configurazione per montare il volume ed esegui il pod dall'immagine nonroot. Il percorso di montaggio del volume `/mnt/myvol` corrisponde al percorso di montaggio specificato nel
Dockerfile. Salva la configurazione come un file `.yaml` file.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Crea il pod e monta l'attestazione del volume persistente nel tuo pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. Verifica che il volume sia stato correttamente montato nel tuo pod.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    Il punto di montaggio viene elencato nel campo
**Volume Mounts** e il volume nel campo
**Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Accedi al pod dopo che è in esecuzione.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Visualizza le autorizzazioni del tuo percorso di montaggio del volume.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Questo output mostra che root dispone delle autorizzazioni di lettura, scrittura e esecuzione nel percorso di montaggio del volume
`mnt/myvol/`, ma che l'utente myguest non root dispone della autorizzazioni di
lettura e scrittura per la cartella `mnt/myvol/mydata`. Poiché queste autorizzazioni sono state aggiornate,
l'utente non root può ora scrivere dati nel volume persistente.


