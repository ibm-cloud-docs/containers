---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

Scopri la procedura generale per distribuire le applicazioni facendo clic su un'area della seguente immagine.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Installa le CLI." title="Installa le CLI." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Crea un file di configurazione per la tua applicazione. Consulta le procedure consigliate da Kubernetes." title="Crea un file di configurazione per la tua applicazione. Consulta le procedure consigliate da Kubernetes." shape="rect" coords="254, 64, 486, 231" />
<area href="#cs_apps_cli" target="_blank" alt="Opzione 1: esegui i file di configurazione della CLI Kubernetes." title="Opzione 1: esegui i file di configurazione della CLI Kubernetes." shape="rect" coords="544, 67, 730, 124" />
<area href="#cs_cli_dashboard" target="_blank" alt="Opzione 2: avvia il dashboard Kubernetes in locale ed esegui i file di configurazione." title="Opzione 2: avvia il dashboard Kubernetes in locale ed esegui i file di configurazione." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Avvio del dashboard Kubernetes
{: #cs_cli_dashboard}

Ari il dashboard Kubernetes nel tuo sistema locale per visualizzare le informazioni su un cluster e sui suoi nodi di lavoro.
{:shortdesc}

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster. Questa attività richiede la [politica di accesso Amministratore](cs_cluster.html#access_ov). Verifica la tua [politica
di accesso](cs_cluster.html#view_access) corrente.

Puoi utilizzare la porta predefinita o impostare una tua porta per avviare il dashboard Kubernetes per un cluster.

1.  Per i cluster con una versione del master Kubernetes di 1.7.4 o precedente:

    1.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        Output:

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    2.  Apri il dashboard Kubernetes in un browser Web.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  Per i cluster con una versione del master Kubernetes di 1.8.2 o successiva:

    1.  Scarica le tue credenziali.

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: codeblock}

    2.  Visualizza le credenziali del cluster che hai scaricato.  Utilizza il percorso file specificato nell'esportazione nel passo precedente.

        Per macOS o Linux:

        ```
        cat <filepath_to_cluster_credentials>
        ```
        {: codeblock}

        Per Windows:

        ```
        type <filepath_to_cluster_credentials>
        ```
        {: codeblock}

    3.  Copia il token nel campo **id-token**.

    4.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        Il tuo output CLI si presenta così:

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    6.  Accedi al dashboard.

        1.  Copia questo URL nel tuo browser.

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  Nella pagina di accesso, seleziona il metodo di autenticazione **Token**.

        3.  Quindi, incolla il valore **id-token** nel campo **Token** e fai clic su **ACCEDI**.

[Successivamente, puoi eseguire un file di configurazione dal dashboard.](#cs_apps_ui)

Quando hai finito con il dashboard Kubernetes, utilizza `CTRL+C` per uscire dal
comando `proxy`. Dopo essere uscito, il dashboard Kubernetes non è più disponibile. Esegui il comando `proxy` per riavviare il dashboard Kubernetes.



<br />


## Creazione dei segreti
{: #secrets}

I segreti Kubernetes rappresentano un modo sicuro per memorizzare informazioni riservate, quali nome utente, password o
chiavi.


<table>
<caption>Tabella. File necessari da memorizzare nei segreti in base all'attività</caption>
<thead>
<th>Attività</th>
<th>File richiesti da memorizzare nei segreti</th>
</thead>
<tbody>
<tr>
<td>Aggiungere un servizio a un cluster</td>
<td>Nessuno. Un segreto viene creato per te quando esegui il bind di un servizio a un cluster.</td>
</tr>
<tr>
<td>Facoltativo: se non utilizzi il segreto ingress, configura il servizio Ingress con TLS. <p><b>Nota</b>: TLS è già abilitato per impostazione predefinita e un segreto è già stato creato per la connessione TLS.

Per visualizzare il segreto TLS:
<pre>
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
Per creare il tuo proprio segreto, completa la procedura in questo argomento.</td>
<td>Certificato e chiave del server: <code>server.crt</code> e <code>server.key</code></td>
<tr>
<td>Crea l'annotazione di autenticazione reciproca.</td>
<td>Certificato CA: <code>ca.crt</code></td>
</tr>
</tbody>
</table>

Per ulteriori informazioni su cosa puoi memorizzare nei segreti, consulta la [documentazione Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/).



Per creare un segreto con un certificato:

1. Genera il certificato e la chiave di autorità di certificazione (CA, certificate authority) dal tuo provider di certificati. Se disponi del tuo proprio dominio, acquista un certificato TLS ufficiale per il dominio. A scopo di test, puoi generare un certificato autofirmato.

 Importante: assicurati che il [CN](https://support.dnsimple.com/articles/what-is-common-name/) sia diverso per ogni certificato.

 Il certificato client e la chiave client devono essere verificati utilizzando il certificato di fonte attendibile, che in questo caso è il certificato CA. Esempio:

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. Crea il certificato come segreto Kubernetes.

 ```
 kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
 ```
 {: pre}

 Esempi:
 - Connessione TLS:

 ```
 kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
 ```
 {: pre}

 - Annotazione di autenticazione reciproca:

 ```
 kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
 ```
 {: pre}

<br />



## Consentire l'accesso pubblico alle applicazioni
{: #cs_apps_public}

Per rendere pubblicamente disponibile un'applicazione su Internet, devi aggiornare il tuo file di configurazione prima di distribuire l'applicazione in un cluster.
{:shortdesc}

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

Rendi la tua applicazione disponibile per l'accesso Internet utilizzando l'indirizzo IP pubblico di un qualsiasi nodo di lavoro in un cluster ed esponendo una porta del nodo. Utilizza questa opzione per la verifica e per un accesso pubblico
a breve termine.

{:shortdesc}

Puoi esporre la tua applicazione come un servizio Kubernetes NodePort per i cluster lite o standard.

Per gli ambienti {{site.data.keyword.Bluemix_dedicated_notm}}, gli indirizzi IP pubblici sono bloccati da un firewall. Per rendere la tua applicazione disponibile pubblicamente, utilizza invece un [Servizio LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress).

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
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
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

Esponi una porta e utilizza un indirizzo IP portatile per il programma di bilanciamento del carico per accedere all'applicazione. Utilizza un indirizzo IP pubblico per rendere un'applicazione accessibile su Internet o un indirizzo IP privato per rendere un'applicazione accessibile sulla rete dell'infrastruttura privata.

A differenza di un servizio NodePort, l'indirizzo IP portatile del servizio di bilanciamento del carico non dipende
dal nodo di lavoro su cui viene distribuita l'applicazione. Tuttavia, un servizio Kubernetes LoadBalancer è anche un servizio NodePort. Un servizio LoadBalancer rende la tua applicazione disponibile per la porta e l'indirizzo IP del programma di bilanciamento del carico e per le porte del nodo del servizio.

L'indirizzo IP portatile del programma di bilanciamento del carico viene assegnato
automaticamente e non cambia quando aggiungi o rimuovi i nodi di lavoro Il che significa che i servizi del programma di bilanciamento del carico sono più disponibili dei servizi NodePort. Gli utenti possono selezionare qualsiasi porta per
il programma di bilanciamento del carico e non sono limitati all'intervallo di porte di NodePort. Puoi usare i servizi di bilanciamento del carico
per i protocolli TCP e UDP.

Quando un account {{site.data.keyword.Bluemix_dedicated_notm}} viene [abilitato per i cluster](cs_ov.html#setup_dedicated), puoi richiedere sottoreti pubbliche da utilizzare per gli indirizzi IP del programma di bilanciamento del carico.[Apri un ticket di supporto](/docs/support/index.html#contacting-support) per creare la sottorete e quindi utilizza il comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) per aggiungere la sottorete al cluster.

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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
          <td>Annotazione per specificare il tipo di LoadBalancer. I valori sono `private` e `public`. Quando crei un LoadBalancer pubblico nei cluster su VLAN pubbliche, questa annotazione non è necessaria.</td>
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
del carico.
3.  Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Sostituisci
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




### Configurazione dell'accesso a un'applicazione utilizzando il controller Ingress
{: #cs_apps_public_ingress}

Esponi più applicazioni nel tuo cluster creando risorse Ingress che vengono gestite dal
controller Ingress fornito da IBM. Il controller Ingress è un programma di bilanciamento del carico HTTP o HTTPS esterno che utilizza un punto di accesso pubblico o privato sicuro e univoco per instradare le richieste in entrata alle tue applicazioni all'interno o all'esterno del tuo cluster.

**Nota:** Ingress è disponibile solo per i cluster standard e richiede almeno due nodi di lavoro nel cluster per garantire l'alta disponibilità e l'applicazione di aggiornamenti periodici. La configurazione di Ingress richiede una [politica di accesso Amministratore](cs_cluster.html#access_ov). Verifica la tua [politica
di accesso](cs_cluster.html#view_access) corrente.

Quando crei un cluster standard, per te viene creato e abilitato automaticamente un controller Ingress a cui viene assegnato un indirizzo IP pubblico portatile e una rotta pubblica. Viene anche creato un controller Ingress a cui viene assegnato un indirizzo IP privato portatile e una rotta privata, ma non viene abilitato automaticamente. Puoi configurare questi controller Ingress e definire singole regole di instradamento per ogni applicazione che esponi alle reti pubbliche o private. Ad ogni applicazione esposta alla rete pubblica tramite Ingress viene assegnato un percorso univoco che viene aggiunto alla rotta pubblica, in modo che tu possa utilizzare un URL univoco per accedere pubblicamente a un'applicazione nel tuo cluster.

Quando un account {{site.data.keyword.Bluemix_dedicated_notm}} viene [abilitato per i cluster](cs_ov.html#setup_dedicated), puoi richiedere sottoreti pubbliche da utilizzare per gli indirizzi IP del controller Ingress. Successivamente,
viene creato il controller Ingress e viene assegnata una rotta pubblica. [Apri un ticket di supporto](/docs/support/index.html#contacting-support) per creare la sottorete e quindi utilizza il comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) per aggiungere la sottorete al cluster.

Per esporre la tua applicazione al pubblico, puoi configurare il controller Ingress pubblico per i seguenti scenari.

-   [Utilizzare il dominio fornito da IBM senza la terminazione TLS](#ibm_domain)
-   [Utilizzare il dominio fornito da IBM con la terminazione TLS](#ibm_domain_cert)
-   [Utilizzare un dominio personalizzato e un certificato TLS per fornire la terminazione
TLS](#custom_domain_cert)
-   [Utilizzare il dominio fornito da IBM o un dominio personalizzato con la terminazione TLS per
accedere alle applicazioni all'esterno del tuo cluster](#external_endpoint)
-   [Apertura di porte nel programma di bilanciamento del carico Ingress](#opening_ingress_ports)
-   [Configurazione di protocolli SSL e cifrature SSL a livello di HTTP](#ssl_protocols_ciphers)
-   [Personalizzare il tuo controller Ingress con le annotazioni](cs_annotations.html)
{: #ingress_annotation}

Per esporre la tua applicazione alle reti private, per prima cosa [abilita il controller Ingress privato](#private_ingress). Puoi quindi configurare il controller Ingress privato per i seguenti scenari.

-   [Utilizzare un dominio personalizzato senza la terminazione TLS](#private_ingress_no_tls)
-   [Utilizzare un dominio personalizzato e un certificato TLS per fornire la terminazione
TLS](#private_ingress_tls)

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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di
riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.</td>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di
riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.</td>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di
riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di
riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.</td>
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



#### Apertura di porte nel programma di bilanciamento del carico Ingress
{: #opening_ingress_ports}

Per impostazione predefinita, solo le porte 80 e 443 sono esposte nel programma di bilanciamento del carico Ingress. Per esporre altre porte, puoi modificare la risorsa della mappa di configurazione ibm-cloud-provider-ingress-cm.

1.  Crea una versione locale del file di configurazione per la risorsa della mappa di configurazione ibm-cloud-provider-ingress-cm. Aggiungi una sezione <code>data</code> e specifica le porte pubbliche 80, 443 e qualsiasi altra porta che vuoi aggiungere al file della mappa di configurazione separandole con un punto e virgola (;). 

 Nota: quando si specificano le porte, è necessario includere anche 80 e 443 per mantenere aperte queste porte. Qualsiasi porta non specificata viene chiusa.

 ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

 Esempio:
 ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```

2. Applica il file di configurazione.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Verifica che il file di configurazione sia stato applicato.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 Output:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

Per ulteriori informazioni sulle risorse della mappa di configurazione, consulta la [documentazione Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).



#### Configurazione di protocolli SSL e cifrature SSL a livello di HTTP
{: #ssl_protocols_ciphers}

Abilita i protocolli e le cifrature SSL a livello globale HTTP modificando la mappa di configurazione `ibm-cloud-provider-ingress-cm`.

Per impostazione predefinita, vengono utilizzati i seguenti valori per ssl-protocols e ssl-ciphers:

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

Per ulteriori informazioni su questi parametri, consulta la documentazione NGINX per [ssl-protocols ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols) e [ssl-ciphers ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers).

Per modificare i valori predefiniti:
1. Crea una versione locale del file di configurazione per la risorsa della mappa di configurazione ibm-cloud-provider-ingress-cm. 

 ```
 apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

2. Applica il file di configurazione.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Verifica che il file di configurazione sia stato applicato.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 Output:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
 ```
 {: screen}


#### Abilitazione del controller Ingress privato
{: #private_ingress}

Quando crei un cluster standard, viene creato automaticamente un controller Ingress privato, ma non viene automaticamente abilitato. Prima di poter utilizzare il controller Ingress privato, devi abilitarlo con l'indirizzo IP privato portatile pre-assegnato fornito da IBM o con il tuo proprio indirizzo IP privato portatile. **Nota**: se quando hai creato il cluster hai utilizzato l'indicatore `--no-subnet`, devi aggiungere una sottorete privata portatile o una sottorete gestita dall'utente prima di poter abilitare il controller Ingress privato. Per maggiori informazioni, vedi [Richiesta di ulteriori sottoreti per il tuo cluster](cs_cluster.html#add_subnet).

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per abilitare il controller Ingress privato utilizzando l'indirizzo IP privato portatile pre-assegnato fornito da IBM:

1. Elenca i controller Ingress disponibili nel tuo cluster per ottenere l'ID ALB del controller Ingress privato. Sostituisci <em>&lt;cluser_name&gt;</em> con il nome del cluster in cui è distribuita l'applicazione che vuoi esporre.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    Il campo **Status** per il controller Ingress privato è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. Abilita il controller Ingress privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID ALB del controller Ingress privato indicato nell'output nel passo precedente.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Per abilitare il controller Ingress privato utilizzando il tuo proprio indirizzo IP privato portatile:

1. Configura la sottorete gestita dall'utente dell'indirizzo IP che hai scelto per instradare il traffico sulla VLAN privata del tuo cluster. Sostituisci <em>&lt;cluser_name&gt;</em> con il nome o l'ID del cluster in cui è distribuita l'applicazione che vuoi esporre, <em>&lt;subnet_CIDR&gt;</em> con il CIDR della tua sottorete gestita dall'utente e <em>&lt;private_VLAN&gt;</em> con un ID VLAN privata disponibile. Puoi trovare l'ID di una VLAN privata disponibile eseguendo `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Elenca i controller Ingress disponibili nel tuo cluster per ottenere l'ID ALB del controller Ingress privato. 

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    Il campo **Status** per il controller Ingress privato è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. Abilita il controller Ingress privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID ALB del controller Ingress privato indicato nell'output nel passo precedente e <em>&lt;user_ip&gt;</em> con l'indirizzo IP dalla sottorete gestita dall'utente che vuoi utilizzare.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

#### Utilizzo del controller Ingress privato con un dominio personalizzato
{: #private_ingress_no_tls}

Puoi configurare il controller Ingress privato per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster utilizzando un dominio personalizzato.
{:shortdesc}

Prima di iniziare, [abilita il controller Ingress privato](#private_ingress).

Per configurare il controller Ingress privato:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) per registrare il tuo dominio personalizzato.

2.  Associa il tuo dominio personalizzato all'indirizzo IP privato portatile del controller Ingress privato fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP privato portatile del controller Ingress privato, esegui `bx cs albs --cluster <cluster_name>`.

3.  [Distribuisci la tua applicazione al cluster](#cs_apps_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.

4.  Crea un servizio Kubernetes per l'applicazione da esporre. Il controller Ingress privato può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster. 

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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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

    5.  Ripeti questi passi per ogni applicazione che vuoi esporre alla rete privata.
7.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal controller Ingress per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai tuoi servizi. Per ogni
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
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myingressname&gt;</em> con un nome per la tua risorsa Ingress.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID ALB del controller Ingress privato. Per trovare l'ID ALB, esegui <code>bx cs albs --cluster <my_cluster></code>.</td>
        </tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il tuo dominio personalizzato.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è
in ascolto la tua applicazione, in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio di Kubernetes, puoi definire un percorso individuale che viene aggiunto al dominio personalizzato per creare un percorso univoco alla tua applicazione, ad esempio <code>custom_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web,
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
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di
riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.
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

8.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci <em>&lt;myingressname&gt;</em> con il nome della risorsa Ingress che hai creato nel passo precedente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** potrebbero essere richiesti alcuni secondi prima che la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile.

9.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

#### Utilizzo del controller Ingress privato con un dominio personalizzato e un certificato TLS
{: #private_ingress_tls}

Puoi configurare il controller Ingress privato per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster e utilizzare il tuo proprio certificato TLS per gestire la terminazione TLS, mentre utilizzi il tuo dominio personalizzato.
{:shortdesc}

Prima di iniziare, [abilita il controller Ingress privato](#private_ingress).

Per configurare il controller Ingress:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) per registrare il tuo dominio personalizzato.

2.  Associa il tuo dominio personalizzato all'indirizzo IP privato portatile del controller Ingress privato fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP privato portatile del controller Ingress privato, esegui `bx cs albs --cluster <cluster_name>`.

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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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

6.  Crea un servizio Kubernetes per l'applicazione da esporre. Il controller Ingress privato può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster. 

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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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

    5.  Ripeti questi passi per ogni applicazione che vuoi esporre sulla rete privata.
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
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myingressname&gt;</em> con un nome per la tua risorsa Ingress.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID ALB del controller Ingress privato. Per trovare l'ID ALB, esegui <code>bx cs albs --cluster <my_cluster></code>.</td>
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
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il tuo dominio personalizzato che vuoi
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
diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di
riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.
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
<em>&lt;myingressname&gt;</em> con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** potrebbero essere richiesti alcuni secondi prima che la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile.

9.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

## Gestione di sottoreti e indirizzi IP
{: #cs_cluster_ip_subnet}

Puoi utilizzare le sottoreti private e pubbliche e gli indirizzi IP per esporre le applicazioni nel tuo cluster e renderle accessibili da internet o da una rete privata.
{:shortdesc}

In {{site.data.keyword.containershort_notm}}, puoi aggiungere IP portatili
stabili per i servizi Kubernetes aggiungendo delle sottoreti di rete al cluster. Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} fornisce automaticamente una sottorete pubblica portatile con 5 indirizzi IP pubblici portatili e una sottorete privata portatile con 5 indirizzi IP privati portatili. Gli indirizzi IP portatili sono
statici e non cambiano alla rimozione di un nodo di lavoro o di un cluster.

 Due degli indirizzi IP portatili, uno pubblico e uno privato, vengono utilizzati per i [controller Ingress](#cs_apps_public_ingress) che puoi usare per esporre più applicazioni nel tuo cluster. 4 indirizzi IP pubblici portatili e 4 indirizzi IP privati portatili possono essere utilizzati per esporre le applicazioni [creando un servizio di bilanciamento del carico](#cs_apps_public_load_balancer).

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
che crea, aggiorna e gestisce i pod nel tuo cluster.
{:shortdesc}

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
delle tue applicazione in base alla CPU.
{:shortdesc}

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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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


Quando un account {{site.data.keyword.Bluemix_dedicated_notm}} viene [abilitato per i cluster](cs_ov.html#setup_dedicated), invece di utilizzare questa attività, devi [aprire un ticket di supporto](/docs/support/index.html#contacting-support). Aprendo un ticket, puoi richiedere un backup per i volumi, un ripristino dai volumi e altre funzioni di archiviazione.


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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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

    </li> Se non specifichi alcuna classe di archiviazione, il volume persistente viene creato con la classe di archiviazione bronze.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Se scegli una dimensione diversa da quella elencata, la dimensione viene arrotondata per eccesso. Se selezioni una dimensione superiore a quella più grande, la dimensione viene arrotondata per difetto.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Questa opzione è solo per ibmc-file-custom / ibmc-file-retain-custom. Specifica il totale di IOPS per l'archiviazione. Esegui `kubectl describe storageclasses ibmc-file-custom` per visualizzare tutte le opzioni. Se scegli un IOPS diverso da quello elencato, viene arrotondato per eccesso.</td>
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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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
l'utente root nel contenitore, che per alcune applicazioni, è l'unico utente all'interno del contenitore. Tuttavia, molte applicazioni specificano un utente non root diverso da `nobody` che scrive nel percorso di montaggio del contenitore. Alcune applicazioni specificano che il volume deve essere di proprietà dell'utente root. In genere le applicazioni non utilizzano l'utente root a causa di problemi di sicurezza. Tuttavia, se la tua applicazione richiede un utente root, puoi contattare il [supporto {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support) per assistenza.


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
