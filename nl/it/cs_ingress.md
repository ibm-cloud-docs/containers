---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurazione dei servizi Ingress
{: #ingress}

Esponi più applicazioni nel tuo cluster Kubernetes creando risorse Ingress che vengono gestite dal programma di bilanciamento del carico dell'applicazione fornito da IBM in {{site.data.keyword.containerlong}}.
{:shortdesc}

## Pianificazione della rete con i servizi Ingress
{: #planning}

Con Ingress, puoi esporre più servizi nel tuo cluster e renderli pubblicamente disponibili utilizzando un unico punto di ingresso pubblico.
{:shortdesc}

Anziché creare un servizio di bilanciamento del carico per ogni applicazione che vuoi esporre al pubblico, Ingress fornisce una rotta pubblica univoca per inoltrare richieste pubbliche alle applicazioni all'interno e all'esterno del cluster in base ai singoli percorsi. Ingress è costituito da due componenti principali: il programma di bilanciamento del carico dell'applicazione e la risorsa Ingress.

Il programma di bilanciamento del carico dell'applicazione (o ALB, application load balancer) è un programma di bilanciamento del carico esterno che rimane in ascolto delle richieste di servizio HTTP o HTTPS, TCP o UDP in entrata e inoltra le richieste al pod dell'applicazione appropriato. Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} crea automaticamente un ALB altamente disponibile per il tuo cluster e gli assegna una rotta pubblica univoca. La rotta pubblica è collegata a un indirizzo IP pubblico portatile che viene fornito nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) durante la creazione del cluster. Viene inoltre creato automaticamente un ALB privato predefinito, ma non viene automaticamente abilitato.

Per esporre un'applicazione tramite Ingress, devi creare un servizio Kubernetes per la tua applicazione e registrare questo servizio con l'ALB definendo una risorsa Ingress. La risorsa Ingress specifica il percorso che viene aggiunto alla rotta pubblica per formare un URL univoco per la tua applicazione esposta, come ad esempio `mycluster.us-south.containers.mybluemix.net/myapp`, e definisce le regole su come instradare le richieste in entrata per un'applicazione.

Il seguente diagramma mostra come Ingress dirige la comunicazione da Internet a un'applicazione:

<img src="images/cs_ingress_planning.png" width="550" alt="Esponi un'applicazione in {{site.data.keyword.containershort_notm}} utilizzando Ingress" style="width:550px; border-style: none"/>

1. Un utente invia una richiesta alla tua applicazione accedendo all'URL dell'applicazione. Questo URL è l'URL pubblico per la tua applicazione esposta a cui è aggiunto il percorso della risorsa Ingress, ad esempio `mycluster.us-south.containers.mybluemix.net/myapp`.

2. Un servizio di sistema DNS che funge da programma di bilanciamento del carico globale risolve l'URL nell'indirizzo IP pubblico portatile dell'ALB pubblico predefinito nel cluster.

3. `kube-proxy` instrada la richiesta al servizio ALB Kubernetes per l'applicazione.

4. Il servizio Kubernetes instrada la richiesta all'ALB.

5. L'ALB verifica se esiste una regola di instradamento per il percorso `myapp` nel cluster. Se viene trovata una regola corrispondente, la richiesta viene inoltrata in base alle regole definite nella risorsa Ingress al pod in cui è distribuita l'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, l'ALB bilancia il carico delle richieste tra i pod dell'applicazione.



**Nota:** Ingress è disponibile solo per i cluster standard e richiede almeno due nodi di lavoro nel cluster per garantire l'alta disponibilità e l'applicazione di aggiornamenti periodici. La configurazione di Ingress richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.

Per scegliere la migliore configurazione per Ingress, segui questo albero delle decisioni:

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="Questa immagine ti guida nella scelta della configurazione migliore per il programma di bilanciamento del carico dell'applicazione Ingress. Se questa immagine non viene visualizzata, le informazioni possono ancora essere trovate nella documentazione." style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="Esponi in privato le applicazioni utilizzando un dominio personalizzato senza TLS" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="Esponi in privato le applicazioni utilizzando un dominio personalizzato con TLS" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="Esposizione in privato delle applicazioni che si trovano all'esterno del tuo cluster utilizzando un dominio fornito da IBM o personalizzato con TLS" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="Esposizione in pubblico delle applicazioni utilizzando un dominio personalizzato con TLS" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="Esposizione in pubblico delle applicazioni utilizzando il dominio fornito da IBM senza TLS" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="Esposizione in pubblico delle applicazioni utilizzando il dominio fornito da IBM con TLS" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## Esposizione delle applicazioni in pubblico
{: #ingress_expose_public}

Quando crei un cluster standard, viene abilitato automaticamente un ALB (programma di bilanciamento del carico dell'applicazione) fornito da IBM a cui vengono assegnati un indirizzo IP pubblico portatile e una rotta pubblica.
{:shortdesc}

Ad ogni applicazione esposta alla rete pubblica tramite Ingress viene assegnato un percorso univoco che viene aggiunto alla rotta pubblica, in modo che tu possa utilizzare un URL univoco per accedere pubblicamente a un'applicazione nel tuo cluster. Per esporre la tua applicazione al pubblico, puoi configurare Ingress per i seguenti scenari.

-   [Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM senza TLS](#ibm_domain)
-   [Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM con TLS](#ibm_domain_cert)
-   [Esponi in pubblico le applicazioni utilizzando un dominio personalizzato con TLS](#custom_domain_cert)
-   [Esponi in pubblico le applicazioni che si trovano all'esterno del tuo cluster utilizzando il dominio fornito da IBM o un dominio personalizzato con TLS](#external_endpoint)

### Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM senza TLS
{: #ibm_domain}

Puoi configurare l'ALB per bilanciare il carico del traffico di rete HTTP in entrata per le applicazioni nel tuo cluster e utilizzare il dominio fornito da IBM per accedere alle tue applicazioni da Internet.
{:shortdesc}

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.

Per esporre un'applicazione utilizzando il dominio fornito da IBM:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.
2.  Crea un servizio Kubernetes per l'applicazione da esporre. L'ALB può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione è esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myservice.yaml`.
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
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio ALB.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore (<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato quando hai distribuito la tua applicazione al cluster. </td>
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
3.  Richiama i dettagli del tuo cluster per visualizzare il dominio fornito da IBM. Sostituisci _&lt;mycluster&gt;_ con il nome del cluster in cui viene distribuita l'applicazione che vuoi esporre al pubblico.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    L'output della CLI sarà simile al seguente.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    Puoi visualizzare il dominio fornito da IBM nel campo **Ingress subdomain**.
4.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di instradamento per il servizio Kubernetes che hai creato per la tua applicazione e sono utilizzate dall'ALB per instradare il traffico di rete in entrata al servizio. Devi utilizzare una risorsa Ingress per definire le regole di instradamento per più applicazioni se ogni applicazione viene esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM per instradare il traffico di rete in entrata al servizio che hai creato in precedenza.

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
        <caption>Descrizione dei componenti del file della risorsa Ingress</caption>
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
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal passo precedente.

        </br></br>
        <strong>Nota:</strong> non utilizzare * per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes, puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e ai pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.

        </br></br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione.
        </br>
        Esempi: <ul><li>Per <code>http://ingress_host_name/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://ingress_host_name/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        </br>
        <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci _&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.

6.  In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

<br />


### Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM con TLS
{: #ibm_domain_cert}

Puoi configurare l'ALB Ingress per gestire le connessioni TLS in entrata per le tue applicazioni, decrittografare il traffico di rete utilizzando il certificato TLS fornito da IBM e inoltrare la richiesta decrittografata alle applicazioni esposte nel tue cluster.
{:shortdesc}

Prima di iniziare:

-   Se non ne hai già uno, [crea un cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi `kubectl`.

Per esporre un'applicazione utilizzando il dominio fornito da IBM con TLS:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione. Questa etichetta identifica tutti i pod in cui è in esecuzione la tua applicazione, in modo che possano essere inclusi nel bilanciamento del carico Ingress.
2.  Crea un servizio Kubernetes per l'applicazione da esporre. L'ALB può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione è esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myservice.yaml`.
    2.  Definisci un servizio ALB per l'applicazione che vuoi esporre al pubblico.

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
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio ALB.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore (<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato quando hai distribuito la tua applicazione al cluster. </td>
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

3.  Visualizza il dominio e il certificato TLS forniti da IBM. Sostituisci _&lt;mycluster&gt;_ con il nome del cluster in cui viene distribuita l'applicazione.

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
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    Puoi visualizzare il dominio fornito da IBM nel campo **Dominio secondario Ingress** e il certificato fornito da IBM nel campo **Segreto Ingress**.

4.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di instradamento per il servizio Kubernetes che hai creato per la tua applicazione e sono utilizzate dall'ALB per instradare il traffico di rete in entrata al servizio. Devi utilizzare una risorsa Ingress per definire le regole di instradamento per più applicazioni se ogni applicazione viene esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM per instradare il traffico di rete in entrata ai tuoi servizi e il certificato fornito da IBM per gestire per te la terminazione TLS. Per ogni servizio, puoi definire un singolo percorso che viene aggiunto al dominio fornito da IBM per creare un percorso univoco per la tua applicazione, ad esempio `https://ingress_domain/myapp`. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e quindi ai pod in cui è in esecuzione l'applicazione.

        **Nota:** la tua applicazione deve essere in ascolto sul percorso che hai definito nella risorsa Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come `/` e non specificare un percorso individuale per la tua applicazione.

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
        <caption>Descrizione dei componenti del file della risorsa Ingress</caption>
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
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;ibmtlssecret&gt;</em> con il nome del <strong>Segreto Ingress</strong> fornito da IBM dal passo precedente. Questo certificato gestisce la terminazione TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes, puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e ai pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.

        </br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br>
        Esempi: <ul><li>Per <code>http://ingress_host_name/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://ingress_host_name/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci _&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.

6.  In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

<br />


### Esponi in pubblico le applicazioni utilizzando un dominio personalizzato con TLS
{: #custom_domain_cert}

Puoi configurare l'ALB per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster e utilizzare il tuo proprio certificato TLS per gestire la terminazione TLS, mentre utilizzi il tuo dominio personalizzato anziché il dominio fornito da IBM.
{:shortdesc}

Prima di iniziare:

-   Se non ne hai già uno, [crea un cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi `kubectl`.

Per esporre un'applicazione utilizzando un dominio personalizzato con TLS:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) o [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) per registrare il tuo dominio.
2.  Configura il tuo dominio per instradare il traffico di rete in entrata all'ALB fornito da IBM. Scegli tra queste opzioni:
    -   Definisci un alias per il tuo dominio personalizzato specificando il dominio fornito da IBM come un record di nome canonico (CNAME). Per trovare il dominio Ingress fornito da IBM, esegui `bx cs cluster-get <mycluster>` e cerca il campo **Dominio secondario Ingress**.
    -   Associa il tuo dominio personalizzato all'indirizzo IP pubblico portatile dell'ALB fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP pubblico portatile dell'ALB, esegui `bx cs alb-get <public_alb_ID>`.
3.  Importa o crea un certificato TLS e il segreto della chiave:
    * Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster immettendo il seguente comando:

      ```
      bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
      ```
      {: pre}

    * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in formato PEM.
        2. Crea un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;mytlssecret&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

4.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster, vengono creati uno o più pod che eseguono la tua applicazione in un contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che possano essere inclusi nel bilanciamento del carico Ingress.

5.  Crea un servizio Kubernetes per l'applicazione da esporre. L'ALB può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione è esposta tramite un servizio Kubernetes all'interno del cluster.

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myservice.yaml`.
    2.  Definisci un servizio ALB per l'applicazione che vuoi esporre al pubblico.

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
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio ALB.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore (<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato quando hai distribuito la tua applicazione al cluster. </td>
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
6.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di instradamento per il servizio Kubernetes che hai creato per la tua applicazione e sono utilizzate dall'ALB per instradare il traffico di rete in entrata al servizio. Devi utilizzare una risorsa Ingress per definire le regole di instradamento per più applicazioni se ogni applicazione viene esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai tuoi servizi e il tuo certificato personalizzato per gestire la terminazione TLS. Per ogni servizio, puoi definire un singolo percorso che viene aggiunto al tuo dominio personalizzato per creare un percorso univoco per la tua applicazione; ad esempio, `https://mydomain/myapp`. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e quindi ai pod in cui è in esecuzione l'applicazione.

        L'applicazione deve essere in ascolto sul percorso che hai definito nella risorsa Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come `/` e non specificare un percorso individuale per la tua applicazione.

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
        <caption>Descrizione dei componenti del file della risorsa Ingress</caption>
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
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il nostro dominio personalizzato che vuoi configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;mytlssecret&gt;</em> con il nome del segreto che hai creato in precedenza che contiene il tuo certificato e la tua chiave TLS personalizzati. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per visualizzare i segreti associati a un certificato TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il nostro dominio personalizzato che vuoi configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes, puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e ai pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.

        </br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br></br>
        Esempi: <ul><li>Per <code>https://mycustomdomain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>https://mycustomdomain/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Salva le modifiche.
    4.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

7.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci _&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.

8.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


### Esponi in pubblico le applicazioni che si trovano all'esterno del tuo cluster utilizzando il dominio fornito da IBM o un dominio personalizzato con TLS
{: #external_endpoint}

Puoi configurare l'ALB per includere le applicazioni che si trovano all'esterno del cluster. Le richieste in entrata sul dominio fornito da IBM o sul tuo dominio personalizzato vengono inoltrate automaticamente all'applicazione esterna.
{:shortdesc}

Prima di iniziare:

-   Se non ne hai già uno, [crea un cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi `kubectl`.
-   Assicurati che l'applicazione esterna che desideri includere nel bilanciamento del carico del cluster sia accessibile mediante un indirizzo IP pubblico.

Puoi instradare il traffico di rete in entrata sul dominio fornito da IBM alle applicazioni che si trovano all'esterno del cluster. Se invece vuoi utilizzare un dominio e un certificato TLS personalizzati, sostituisci il dominio fornito da IBM e il certificato TLS con [il tuo dominio e il tuo certificato TLS personalizzati](#custom_domain_cert).

1.  Crea un servizio Kubernetes per il tuo cluster che inoltrerà le richieste in entrata a un endpoint esterno che avrai già creato.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myexternalservice.yaml`.
    2.  Definisci il servizio ALB.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservicename>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Sostituisci <em>&lt;myservicename&gt;</em> con un nome per il tuo servizio.</td>
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

2.  Configura un endpoint Kubernetes che definisce la posizione esterna dell'applicazione che desideri includere nel bilanciamento del carico del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione endpoint denominato, ad esempio, `myexternalendpoint.yaml`.
    2.  Definisci il tuo endpoint esterno. Includi tutti gli indirizzi IP pubblici e le porte che puoi utilizzare per accedere alla tua applicazione esterna.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myservicename>
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
        <td>Sostituisci <em>&lt;myendpointname&gt;</em> con il nome del servizio Kubernetes che hai creato in precedenza.</td>
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

3.  Visualizza il dominio e il certificato TLS forniti da IBM. Sostituisci _&lt;mycluster&gt;_ con il nome del cluster in cui viene distribuita l'applicazione.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    L'output della CLI sarà simile al seguente.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    Puoi visualizzare il dominio fornito da IBM nel campo **Dominio secondario Ingress** e il certificato fornito da IBM nel campo **Segreto Ingress**.

4.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di instradamento per il servizio Kubernetes che hai creato per la tua applicazione e sono utilizzate dall'ALB per instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento per più applicazioni esterne finché ogni applicazione è esposta con il proprio endpoint esterno tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myexternalingress.yaml`.
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM e il certificato TLS per instradare il traffico di rete in entrata alla tua applicazione esterna utilizzando l'endpoint esterno che hai creato in precedenza. Per ogni servizio, puoi definire un singolo percorso che viene aggiunto al dominio fornito da IBM o personalizzato per creare un percorso univoco per la tua applicazione, ad esempio `https://ingress_domain/myapp`. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e quindi all'applicazione esterna.

        L'applicazione deve essere in ascolto sul percorso che hai definito nella risorsa Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come / e non specificare un percorso individuale per la tua applicazione.

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
        <caption>Descrizione dei componenti del file della risorsa Ingress</caption>
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
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;ibmtlssecret&gt;</em> con l'<strong>Host Ingress</strong> fornito da IBM dal passo precedente. Questo certificato gestisce la terminazione TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM dal passo precedente. Questo dominio è configurato per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myexternalservicepath&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione esterna, in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes puoi definire un percorso individuale che viene aggiunto al tuo dominio personalizzato per creare un percorso univoco alla tua applicazione, ad esempio <code>https://ibmdomain/myservicepath1</code>. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete all'applicazione esterna utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.

        </br></br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br></br>
        <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myexternalservice&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione esterna.</td>
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

5.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci _&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.

6.  Accedi alla tua applicazione esterna.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL per accedere alla tua applicazione esterna.

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}

<br />


## Esposizione delle applicazioni su una rete privata
{: #ingress_expose_private}

Quando crei un cluster standard, viene creato un ALB (programma di bilanciamento del carico dell'applicazione) fornito da IBM a cui vengono assegnati un indirizzo IP privato portatile e una rotta privata. Tuttavia, l'ALB privato predefinito non viene abilitato automaticamente. Per esporre la tua applicazione alle reti private, per prima cosa [abilita il programma di bilanciamento del carico dell'applicazione privato predefinito](#private_ingress).
{:shortdesc}

Puoi quindi configurare Ingress per i seguenti scenari.
-   [Esponi in privato le applicazioni utilizzando un dominio personalizzato senza TLS](#private_ingress_no_tls)
-   [Esponi in privato le applicazioni utilizzando un dominio personalizzato con TLS](#private_ingress_tls)

### Abilitazione del programma di bilanciamento del carico dell'applicazione privato predefinito
{: #private_ingress}

Prima di poter utilizzare l'ALB privato predefinito, devi abilitarlo con l'indirizzo IP privato portatile fornito da IBM o con il tuo proprio indirizzo IP privato portatile.
{:shortdesc}

**Nota**: se quando hai creato il cluster hai utilizzato l'indicatore `--no-subnet`, devi aggiungere una sottorete privata portatile o una sottorete gestita dall'utente prima di poter abilitare l'ALB privato. Per ulteriori informazioni, vedi [Richiesta di più sottoreti per il tuo cluster](cs_subnets.html#request).

Prima di iniziare:

-   Se non ne hai già uno, [crea un cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per abilitare l'ALB privato utilizzando l'indirizzo IP privato portatile pre-assegnato fornito da IBM:

1. Elenca gli ALB disponibili nel tuo cluster per ottenere l'ID dell'ALB privato. Sostituisci <em>&lt;cluser_name&gt;</em> con il nome del cluster in cui è distribuita l'applicazione che vuoi esporre.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    Il campo **Status** per l'ALB privato è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. Abilita l'ALB privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID dell'ALB privato indicato nell'output nel passo precedente.

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Per abilitare l'ALB privato utilizzando il tuo proprio indirizzo IP privato portatile:

1. Configura la sottorete gestita dall'utente dell'indirizzo IP che hai scelto per instradare il traffico sulla VLAN privata del tuo cluster. Sostituisci <em>&lt;cluser_name&gt;</em> con il nome o l'ID del cluster in cui è distribuita l'applicazione che vuoi esporre, <em>&lt;subnet_CIDR&gt;</em> con il CIDR della tua sottorete gestita dall'utente e <em>&lt;private_VLAN&gt;</em> con un ID VLAN privata disponibile. Puoi trovare l'ID di una VLAN privata disponibile eseguendo `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Elenca gli ALB disponibili nel tuo cluster per ottenere l'ID dell'ALB privato.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    Il campo **Status** per l'ALB privato è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. Abilita l'ALB privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID dell'ALB privato indicato nell'output nel passo precedente e <em>&lt;user_ip&gt;</em> con l'indirizzo IP dalla sottorete gestita dall'utente che vuoi utilizzare.

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

<br />


### Esponi in privato le applicazioni utilizzando un dominio personalizzato senza TLS
{: #private_ingress_no_tls}

Puoi configurare l'ALB privato per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster utilizzando un dominio personalizzato.
{:shortdesc}

Prima di iniziare, [abilita il programma di bilanciamento del carico dell'applicazione privato](#private_ingress).

Per esporre privatamente un'applicazione utilizzando un dominio personalizzato senza TLS:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) o [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) per registrare il tuo dominio.

2.  Associa il tuo dominio personalizzato all'indirizzo IP privato portatile dell'ALB privato fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP privato portatile dell'ALB privato, esegui `bx cs albs --cluster <cluster_name>`.

3.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster, vengono creati uno o più pod che eseguono la tua applicazione in un contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione. Questa etichetta identifica tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico Ingress.

4.  Crea un servizio Kubernetes per l'applicazione da esporre. L'ALB privato può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione è esposta tramite un servizio Kubernetes all'interno del cluster.

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myservice.yaml`.
    2.  Definisci un servizio ALB per l'applicazione che vuoi esporre al pubblico.

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
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio ALB.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore (<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato quando hai distribuito la tua applicazione al cluster. </td>
         </tr>
         <td><code> port</code></td>
         <td>La porta su cui è in ascolto il servizio.</td>
         </tbody></table>

    3.  Salva le modifiche.
    4.  Crea il servizio Kubernetes nel tuo cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Ripeti questi passi per ogni applicazione che vuoi esporre alla rete privata.
7.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di instradamento per il servizio Kubernetes che hai creato per la tua applicazione e sono utilizzate dall'ALB per instradare il traffico di rete in entrata al servizio. Devi utilizzare una risorsa Ingress per definire le regole di instradamento per più applicazioni se ogni applicazione viene esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai tuoi servizi. Per ogni servizio, puoi definire un singolo percorso che viene aggiunto al tuo dominio personalizzato per creare un percorso univoco per la tua applicazione, ad esempio `https://mydomain/myapp`. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e quindi ai pod in cui è in esecuzione l'applicazione.

        L'applicazione deve essere in ascolto sul percorso che hai definito nella risorsa Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come `/` e non specificare un percorso individuale per la tua applicazione.

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
        <caption>Descrizione dei componenti del file della risorsa Ingress</caption>
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
        <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del tuo ALB privato. Per trovare l'ID ALB, esegui <code>bx cs albs --cluster <my_cluster></code>. Per ulteriori informazioni su questa annotazione Ingress, consulta [Instradamento del programma di bilanciamento del carico dell'applicazione privato](cs_annotations.html#alb-id).</td>
        </tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il tuo dominio personalizzato.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio di Kubernetes, puoi definire un percorso individuale che viene aggiunto al dominio personalizzato per creare un percorso univoco alla tua applicazione, ad esempio <code>custom_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e ai pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.

        </br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br></br>
        Esempi: <ul><li>Per <code>https://mycustomdomain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>https://mycustomdomain/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
        </tr>
        </tbody></table>

    3.  Salva le modifiche.
    4.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci _&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.

9.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


### Esponi in privato le applicazioni utilizzando un dominio personalizzato con TLS
{: #private_ingress_tls}

Puoi utilizzare gli ALB privati per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster. Inoltre, utilizza il tuo certificato TLS per gestire la terminazione TLS mentre usi il tuo dominio personalizzato.
{:shortdesc}

Prima di iniziare, [abilita il programma di bilanciamento del carico dell'applicazione privato predefinito](#private_ingress).

Per esporre privatamente un'applicazione utilizzando un dominio personalizzato con TLS:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) o [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) per registrare il tuo dominio.

2.  Associa il tuo dominio personalizzato all'indirizzo IP privato portatile dell'ALB privato fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP privato portatile dell'ALB privato, esegui `bx cs albs --cluster <cluster_name>`.

3.  Importa o crea un certificato TLS e il segreto della chiave:
    * Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster eseguendo `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in formato PEM.
        2. Crea un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;mytlssecret&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

4.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster, vengono creati uno o più pod che eseguono la tua applicazione in un contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che possano essere inclusi nel bilanciamento del carico Ingress.

5.  Crea un servizio Kubernetes per l'applicazione da esporre. L'ALB privato può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione è esposta tramite un servizio Kubernetes all'interno del cluster.

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myservice.yaml`.
    2.  Definisci un servizio del programma di bilanciamento del carico dell'applicazione che vuoi esporre al pubblico.

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
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio ALB.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore (<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato quando hai distribuito la tua applicazione al cluster. </td>
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
6.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di instradamento per il servizio Kubernetes che hai creato per la tua applicazione e sono utilizzate dall'ALB per instradare il traffico di rete in entrata al servizio. Devi utilizzare una risorsa Ingress per definire le regole di instradamento per più applicazioni se ogni applicazione viene esposta tramite un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai tuoi servizi e il tuo certificato personalizzato per gestire la terminazione TLS. Per ogni servizio, puoi definire un singolo percorso che viene aggiunto al tuo dominio personalizzato per creare un percorso univoco per la tua applicazione, ad esempio `https://mydomain/myapp`. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e quindi ai pod in cui è in esecuzione l'applicazione.

        **Nota:** l'applicazione deve essere in ascolto sul percorso che hai definito nella risorsa Ingress. Altrimenti, il traffico di rete non può essere inoltrato all'applicazione. La maggior parte delle applicazioni non è in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. In questo caso, definisci il percorso root come `/` e non specificare un percorso individuale per la tua applicazione.

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
        <caption>Descrizione dei componenti del file della risorsa Ingress</caption>
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
        <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del tuo ALB privato. Per trovare l'ID ALB, esegui <code>bx cs albs --cluster <my_cluster></code>. Per ulteriori informazioni su questa annotazione Ingress, consulta [Instradamento del programma di bilanciamento del carico dell'applicazione privato (ALB-ID)](cs_annotations.html#alb-id).</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il nostro dominio personalizzato che vuoi configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;mytlssecret&gt;</em> con il nome del segreto che hai creato in precedenza e che contiene la tua chiave e il tuo certificato TLS personalizzati. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per visualizzare i segreti associati a un certificato TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il tuo dominio personalizzato che vuoi configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sostituisci <em>&lt;myservicepath1&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione in modo che il traffico di rete possa essere inoltrato all'applicazione.

        </br>
        Per ogni servizio Kubernetes, puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio e ai pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.

        </br>
        Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione.

        </br></br>
        Esempi: <ul><li>Per <code>https://mycustomdomain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>https://mycustomdomain/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
        <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path) per stabilire l'instradamento appropriato alla tua applicazione.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
        </tr>
         </tbody></table>

    3.  Salva le modifiche.
    4.  Crea la risorsa Ingress per il tuo cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

7.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci _&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.

8.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

Per un'esercitazione completa su come proteggere le comunicazioni tra i microservizi nei tuoi cluster utilizzando l'ALB privato con TLS, consulta [questo post del blog ![External link icon](../icons/launch-glyph.svg "External link icon")]](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).

<br />




## Configurazioni facoltative per i programmi di bilanciamento del carico dell'applicazione
{: #configure_alb}

Puoi ulteriormente configurare un programma di bilanciamento del carico dell'applicazione con le seguenti opzioni.

-   [Apertura di porte nel programma di bilanciamento del carico dell'applicazione Ingress](#opening_ingress_ports)
-   [Configurazione di protocolli SSL e cifrature SSL a livello di HTTP](#ssl_protocols_ciphers)
-   [Personalizzazione del tuo programma di bilanciamento del carico dell'applicazione con le annotazioni](cs_annotations.html)
{: #ingress_annotation}


### Apertura di porte nel programma di bilanciamento del carico dell'applicazione Ingress
{: #opening_ingress_ports}

Per impostazione predefinita, solo le porte 80 e 443 sono esposte nell'ALB Ingress. Per esporre altre porte, puoi modificare la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

1.  Crea una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`. Aggiungi una sezione <code>data</code> e specifica le porte pubbliche 80, 443 e qualsiasi altra porta che vuoi aggiungere al file della mappa di configurazione separandole con un punto e virgola (;).

 Nota: quando si specificano le porte, è necessario includere anche 80 e 443 per mantenere aperte queste porte. Qualsiasi porta che non sia specificata viene chiusa.

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

Per ulteriori informazioni sulle risorse della mappa di configurazione, consulta la [documentazione di Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).

### Configurazione di protocolli SSL e cifrature SSL a livello di HTTP
{: #ssl_protocols_ciphers}

Abilita i protocolli e le cifrature SSL a livello globale HTTP modificando la mappa di configurazione `ibm-cloud-provider-ingress-cm`.
{:shortdesc}



**Nota**: quando specifichi i protocolli abilitati per tutti gli host, i parametri TLSv1.1 e TLSv1.2 (1.1.13, 1.0.12) funzionano solo quando viene utilizzato OpenSSL 1.0.1 o superiore. Il parametro TLSv1.3 (1.13.0) funziona solo quando viene utilizzato OpenSSL 1.1.1 sviluppato con il supporto TLSv1.3.

Per modificare la mappa di configurazione per l'abilitazione di protocolli e cifrature SSL:

1. Crea e apri una versione locale del file di configurazione per la risorsa della mappa di configurazione ibm-cloud-provider-ingress-cm.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Aggiungi i protocolli e le cifrature SSL. Formatta le cifrature in base al [formato dell'elenco di cifrature della libreria OpenSSL ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

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
