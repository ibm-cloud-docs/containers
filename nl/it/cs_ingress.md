---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

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

## Configurazione dell'accesso a un'applicazione utilizzando Ingress
{: #config}

Esponi più applicazioni nel tuo cluster creando risorse Ingress che vengono gestite dal programma di bilanciamento del carico dell'applicazione fornito da IBM. Un programma di bilanciamento del carico dell'applicazione è un programma di bilanciamento del carico HTTP o HTTPS esterno che utilizza un punto di accesso pubblico o privato sicuro e univoco per instradare le richieste in entrata alle tue applicazioni all'interno o all'esterno del tuo cluster. Con Ingress, puoi definire singole regole di instradamento per ogni applicazione che esponi alle reti pubbliche o private. Per informazioni generali sui servizi Ingress, consulta [Pianificazione della rete esterna con Ingress](cs_network_planning.html#ingress).

**Nota:** Ingress è disponibile solo per i cluster standard e richiede almeno due nodi di lavoro nel cluster per garantire l'alta disponibilità e l'applicazione di aggiornamenti periodici. La configurazione di Ingress richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica
di accesso](cs_users.html#infra_access) corrente.

Per scegliere la migliore configurazione per Ingress, segui questo albero delle decisioni:

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="Questa immagine ti guida nella scelta della configurazione migliore per il programma di bilanciamento del carico dell'applicazione Ingress. Se questa immagine non viene visualizzata, le informazioni possono ancora essere trovate nella documentazione." style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="Esposizione in privato delle applicazioni utilizzando un dominio personalizzato senza TLS" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="Esposizione in privato delle applicazioni utilizzando un dominio personalizzato con TLS" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="Esposizione in privato delle applicazioni che si trovano all'esterno del tuo cluster utilizzando un dominio fornito da IBM o personalizzato con TLS" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="Esposizione in pubblico delle applicazioni utilizzando un dominio personalizzato con TLS" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="Esposizione in pubblico delle applicazioni utilizzando il dominio fornito da IBM senza TLS" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="Esposizione in pubblico delle applicazioni utilizzando il dominio fornito da IBM con TLS" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## Esposizione delle applicazioni in pubblico
{: #ingress_expose_public}

Quando crei un cluster standard, viene automaticamente abilitato un programma di bilanciamento del carico dell'applicazione fornito da IBM e viene assegnato un indirizzo IP pubblico portatile e una rotta pubblica. Ad ogni applicazione esposta alla rete pubblica tramite Ingress viene assegnato un percorso univoco che viene aggiunto alla rotta pubblica, in modo che tu possa utilizzare un URL univoco per accedere pubblicamente a un'applicazione nel tuo cluster. Per esporre la tua applicazione al pubblico, puoi configurare Ingress per i seguenti scenari.

-   [Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM senza TLS](#ibm_domain)
-   [Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM con TLS](#ibm_domain_cert)
-   [Esponi in pubblico le applicazioni utilizzando un dominio personalizzato con TLS](#custom_domain_cert)
-   [Esponi in pubblico le applicazioni che si trovano all'esterno del tuo cluster utilizzando il dominio fornito da IBM o un dominio personalizzato con TLS](#external_endpoint)

### Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM senza TLS
{: #ibm_domain}

Puoi configurare il programma di bilanciamento del carico dell'applicazione per bilanciare il carico del traffico di rete HTTP in entrata per le applicazioni nel tuo cluster e utilizzare il dominio fornito da IBM per accedere alle tue applicazioni da internet.

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
2.  Crea un servizio Kubernetes per l'applicazione da esporre. Il programma di bilanciamento del carico dell'applicazione può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
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
        <caption>Descrizione dei componenti del file del servizio del programma di bilanciamento del carico dell'applicazione</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico dell'applicazione.</td>
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
instradamento per la tua applicazione e sono utilizzate dal programma di bilanciamento del carico dell'applicazione per
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete al servizio e ai
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

<br />


### Esponi in pubblico le applicazioni utilizzando il dominio fornito da IBM con TLS
{: #ibm_domain_cert}

Puoi configurare il controller Ingress per gestire le connessioni TLS in entrata per le tue
applicazioni, decrittografare il traffico di rete utilizzando il certificato TLS fornito da IBM e inoltrare
le risorse non crittografate alle applicazioni esposte nel tuo cluster.

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.

Per esporre un'applicazione utilizzando il dominio fornito da IBM con TLS:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta identifica tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.
2.  Crea un servizio Kubernetes per l'applicazione da esporre. Il programma di bilanciamento del carico dell'applicazione può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
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
        <caption>Descrizione dei componenti del file del servizio del programma di bilanciamento del carico dell'applicazione</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico dell'applicazione.</td>
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
instradamento per la tua applicazione e sono utilizzate dal programma di bilanciamento del carico dell'applicazione per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM
per instradare il traffico di rete in entrata ai tuoi servizi e il certificato fornito da IBM per
gestire per te la terminazione TLS. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per
creare un percorso univoco alla tua applicazione, ad esempio `https://ingress_domain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete al servizio e ai
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

<br />


### Esponi in pubblico le applicazioni utilizzando un dominio personalizzato con TLS
{: #custom_domain_cert}

Puoi configurare il programma di bilanciamento del carico dell'applicazione per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster e utilizzare il tuo proprio certificato TLS per gestire la terminazione TLS,
mentre utilizzi il tuo dominio personalizzato invece del dominio fornito da IBM.
{:shortdesc}

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.

Per esporre un'applicazione utilizzando un dominio personalizzato con TLS:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) per registrare il tuo dominio personalizzato.
2.  Configura il tuo dominio per instradare il traffico di rete in entrata al programma di bilanciamento del carico dell'applicazione fornito da IBM. Scegli tra queste opzioni:
    -   Definisci un alias per il tuo dominio personalizzato specificando il dominio fornito da IBM come un record di nome canonico
(CNAME). Per trovare il dominio Ingress fornito da IBM, esegui `bx cs cluster-get <mycluster>` e cerca il campo **Dominio secondario Ingress**.
    -   Associa il tuo dominio personalizzato all'indirizzo IP pubblico portatile del programma di bilanciamento del carico dell'applicazione fornito da IBM aggiungendo l'indirizzo IP come un record. Per trovare l'indirizzo IP pubblico portatile del programma di bilanciamento del carico dell'applicazione, esegui `bx cs alb-get <public_alb_ID>`.
3.  Importa o crea un certificato TLS e il segreto della chiave:
    * Se già disponi di un certificato TLS archiviato in {{site.data.keyword.cloudcerts_long_notm}} che desideri utilizzare, puoi importare il relativo segreto associato nel tuo cluster immettendo il seguente comando:

      ```
      bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
      ```
      {: pre}

    * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in
formato PEM.
        2.  Apri il tuo editor preferito e crea un file di configurazione del segreto Kubernetes denominato,
ad esempio, `mysecret.yaml`.
        3.  Definisci un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;mytlssecret&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

        4.  Salva il tuo file di configurazione.
        5.  Crea il segreto TLS per il tuo cluster.

            ```
            kubectl apply -f mysecret.yaml
            ```
            {: pre}

4.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.

5.  Crea un servizio Kubernetes per l'applicazione da esporre. Il programma di bilanciamento del carico dell'applicazione può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster.

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
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
        <caption>Descrizione dei componenti del file del servizio del programma di bilanciamento del carico dell'applicazione</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico dell'applicazione.</td>
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
6.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal programma di bilanciamento del carico dell'applicazione per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato
per instradare il traffico di rete in entrata ai tuoi servizi e il tuo certificato personalizzato per gestire la terminazione
TLS. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al tuo dominio personalizzato per
creare un percorso univoco alla tua applicazione, ad esempio `https://mydomain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio
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
        <td>Sostituisci <em>&lt;mycustomdomain&gt;</em> con il nostro dominio personalizzato che vuoi
configurare per la terminazione TLS.

        </br></br>
        <strong>Nota:</strong> non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sostituisci <em>&lt;mytlssecret&gt;</em> con il nome del segreto che hai creato
in precedenza che contiene il tuo certificato e la tua chiave TLS personalizzati. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per visualizzare i segreti associati a un certificato TLS.
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete al servizio e ai
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

7.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci
_&lt;myingressname&gt;_ con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** perché la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile sull'Internet pubblico potrebbero essere richiesti alcuni minuti.

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

Puoi configurare il programma di bilanciamento del carico dell'applicazione per includere le applicazioni nel bilanciamento del carico del cluster che si trovano all'esterno del tuo cluster. Le richieste in entrata sul dominio fornito da IBM o sul tuo dominio
personalizzato vengono inoltrate automaticamente all'applicazione esterna.

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.
-   Assicurati che l'applicazione esterna che desideri includere nel bilanciamento del carico del cluster sia
accessibile mediante un indirizzo IP pubblico.

Puoi instradare il traffico di rete in entrata sul dominio fornito da IBM alle applicazioni che si trovano all'esterno
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
    2.  Definisci il servizio del programma di bilanciamento del carico dell'applicazione.

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
        <caption>Descrizione dei componenti del file del servizio del programma di bilanciamento del carico dell'applicazione</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Sostituisci <em>&lt;myexternalservice&gt;</em> con il nome per il tuo servizio del programma di bilanciamento del carico dell'applicazione.</td>
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
instradamento per la tua applicazione e sono utilizzate dal programma di bilanciamento del carico dell'applicazione per
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete al servizio e successivamente
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete all'applicazione esterna
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

<br />


## Esposizione delle applicazioni su una rete privata
{: #ingress_expose_private}

Quando crei un cluster standard, vengono automaticamente creati e assegnati a un programma di bilanciamento del carico dell'applicazione fornito da IBM un indirizzo IP privato portatile e una rotta privata. Tuttavia, il programma di bilanciamento del carico dell'applicazione privato predefinito non viene automaticamente abilitato. Per esporre la tua applicazione alle reti private, per prima cosa [abilita il programma di bilanciamento del carico dell'applicazione privato predefinito](#private_ingress). Puoi quindi configurare Ingress per i seguenti scenari.

-   [Esponi in privato le applicazioni utilizzando un dominio personalizzato senza TLS](#private_ingress_no_tls)
-   [Esponi in privato le applicazioni utilizzando un dominio personalizzato con TLS](#private_ingress_tls)

### Abilitazione del programma di bilanciamento del carico dell'applicazione privato predefinito
{: #private_ingress}

Prima di poter utilizzare il programma di bilanciamento del carico dell'applicazione privato predefinito, devi abilitarlo con l'indirizzo IP privato portatile fornito da IBM o con il tuo proprio indirizzo IP privato portatile. **Nota**: se quando hai creato il cluster hai utilizzato l'indicatore `--no-subnet`, devi aggiungere una sottorete privata portatile o una sottorete gestita dall'utente prima di poter abilitare il programma di bilanciamento del carico dell'applicazione privato. Per maggiori informazioni, vedi [Richiesta di ulteriori sottoreti per il tuo cluster](cs_subnets.html#request).

Prima di iniziare:

-   Se non ne hai già uno, [crea un
cluster standard](cs_clusters.html#clusters_ui).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per abilitare il programma di bilanciamento del carico dell'applicazione privato utilizzando l'indirizzo IP privato portatile pre-assegnato fornito da IBM:

1. Elenca i programmi di bilanciamento del carico dell'applicazione disponibili nel tuo cluster per ottenere l'ID del programma di bilanciamento del carico dell'applicazione privato. Sostituisci <em>&lt;cluser_name&gt;</em> con il nome del cluster in cui è distribuita l'applicazione che vuoi esporre.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    Il campo **Status** per il programma di bilanciamento del carico dell'applicazione è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. Abilita il programma di bilanciamento del carico dell'applicazione privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del programma di bilanciamento del carico dell'applicazione privato indicato nell'output nel passo precedente.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Per abilitare il programma di bilanciamento del carico dell'applicazione privato utilizzando il tuo proprio indirizzo IP privato portatile:

1. Configura la sottorete gestita dall'utente dell'indirizzo IP che hai scelto per instradare il traffico sulla VLAN privata del tuo cluster. Sostituisci <em>&lt;cluser_name&gt;</em> con il nome o l'ID del cluster in cui è distribuita l'applicazione che vuoi esporre, <em>&lt;subnet_CIDR&gt;</em> con il CIDR della tua sottorete gestita dall'utente e <em>&lt;private_VLAN&gt;</em> con un ID VLAN privata disponibile. Puoi trovare l'ID di una VLAN privata disponibile eseguendo `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Elenca i programmi di bilanciamento del carico dell'applicazione disponibili nel tuo cluster per ottenere l'ID del programma di bilanciamento del carico dell'applicazione privato.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    Il campo **Status** per il programma di bilanciamento del carico dell'applicazione è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. Abilita il programma di bilanciamento del carico dell'applicazione privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del programma di bilanciamento del carico dell'applicazione privato indicato nell'output nel passo precedente e <em>&lt;user_ip&gt;</em> con l'indirizzo IP dalla sottorete gestita dall'utente che vuoi utilizzare. 

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

<br />


### Esponi in privato le applicazioni utilizzando un dominio personalizzato senza TLS 
{: #private_ingress_no_tls}

Puoi configurare il programma di bilanciamento del carico dell'applicazione privato per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster utilizzando un dominio personalizzato. {:shortdesc}

Prima di iniziare, [abilita il programma di bilanciamento del carico dell'applicazione privato](#private_ingress).

Per esporre in privato un'applicazione utilizzando un dominio personalizzato senza TLS: 

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) per registrare il tuo dominio personalizzato.

2.  Associa il tuo dominio personalizzato all'indirizzo IP privato portatile del programma di bilanciamento del carico dell'applicazione privato fornito da IBM aggiungendo l'indirizzo IP come un record. Per trovare l'indirizzo IP privato portatile del programma di bilanciamento del carico dell'applicazione privato, esegui `bx cs albs --cluster <cluster_name>`.

3.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.

4.  Crea un servizio Kubernetes per l'applicazione da esporre. Il programma di bilanciamento del carico dell'applicazione privato può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster. 

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
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
        <caption>Descrizione dei componenti del file del servizio del programma di bilanciamento del carico dell'applicazione</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico dell'applicazione.</td>
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
    4.  Crea il servizio Kubernetes nel tuo cluster. 

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Ripeti questi passi per ogni applicazione che vuoi esporre alla rete privata.
7.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal programma di bilanciamento del carico dell'applicazione per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai tuoi servizi. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al tuo dominio personalizzato per
creare un percorso univoco alla tua applicazione, ad esempio `https://mydomain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio
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
        <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del tuo programma di bilanciamento del carico dell'applicazione privato. Esegui <code>bx cs albs --cluster <my_cluster></code> per trovare l'ID del programma di bilanciamento del carico dell'applicazione. Per ulteriori informazioni su questa annotazione Ingress, consulta [Instradamento del programma di bilanciamento del carico dell'applicazione privato](cs_annotations.html#alb-id).</td>
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete al servizio e ai
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

<br />


### Esponi in privato le applicazioni utilizzando un dominio personalizzato con TLS 
{: #private_ingress_tls}

Puoi utilizzare i programmi di bilanciamento del carico dell'applicazione privati per instradare il traffico di rete in entrata alle applicazioni nel tuo cluster e utilizzare il tuo proprio certificato TLS per gestire la terminazione TLS, mentre utilizzi il tuo dominio personalizzato. {:shortdesc}

Prima di iniziare, [abilita il programma di bilanciamento del carico dell'applicazione privato predefinito](#private_ingress). 

Per esporre in privato un'applicazione utilizzando un dominio personalizzato con TLS:

1.  Crea un dominio personalizzato. Per creare un dominio personalizzato, utilizza il provider DNS (Domain Name Service) per registrare il tuo dominio personalizzato.

2.  Associa il tuo dominio personalizzato all'indirizzo IP privato portatile del programma di bilanciamento del carico dell'applicazione privato fornito da IBM aggiungendo l'indirizzo IP come un record. Per trovare l'indirizzo IP privato portatile del programma di bilanciamento del carico dell'applicazione privato, esegui `bx cs albs --cluster <cluster_name>`.

3.  Importa o crea un certificato TLS e il segreto della chiave:
    * Se già disponi di un certificato TLS archiviato in {{site.data.keyword.cloudcerts_long_notm}} che desideri utilizzare, puoi importare il relativo segreto associato nel tuo cluster immettendo `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in
formato PEM.
        2.  Apri il tuo editor preferito e crea un file di configurazione del segreto Kubernetes denominato,
ad esempio, `mysecret.yaml`.
        3.  Definisci un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;mytlssecret&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

        4.  Salva il tuo file di configurazione.
        5.  Crea il segreto TLS per il tuo cluster.

            ```
            kubectl apply -f mysecret.yaml
            ```
            {: pre}

4.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico Ingress.

5.  Crea un servizio Kubernetes per l'applicazione da esporre. Il programma di bilanciamento del carico dell'applicazione privato può includere la tua applicazione nel bilanciamento del carico Ingress solo se l'applicazione viene esposta attraverso un servizio Kubernetes all'interno del cluster. 

    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato,
ad esempio, `myservice.yaml`.
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
        <caption>Descrizione dei componenti del file del servizio del programma di bilanciamento del carico dell'applicazione</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myservice1&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico dell'applicazione.</td>
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
6.  Crea una risorsa Ingress. Le risorse Ingress definiscono le regole di
instradamento per la tua applicazione e sono utilizzate dal programma di bilanciamento del carico dell'applicazione per
instradare il traffico di rete in entrata al servizio. Puoi utilizzare una risorsa Ingress per definire le regole di instradamento
per più applicazioni finché ogni applicazione è esposta tramite un servizio Kubernetes nel cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione Ingress denominato,
ad esempio, `myingress.yaml`.
    2.  Definisci una risorsa Ingress nel file di configurazione che utilizza il tuo dominio personalizzato
per instradare il traffico di rete in entrata ai tuoi servizi e il tuo certificato personalizzato per gestire la terminazione
TLS. Per ogni
servizio puoi definire un percorso individuale che viene aggiunto al tuo dominio personalizzato per
creare un percorso univoco alla tua applicazione, ad esempio `https://mydomain/myapp`. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio
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
        <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del tuo programma di bilanciamento del carico dell'applicazione privato. Esegui <code>bx cs albs --cluster <my_cluster></code> per trovare l'ID del programma di bilanciamento del carico dell'applicazione. Per ulteriori informazioni su questa annotazione Ingress, consulta [Instradamento del programma di bilanciamento del carico dell'applicazione privato (ALB-ID)](cs_annotations.html#alb-id).</td>
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
in precedenza e che contiene la tua chiave e il tuo certificato TLS personalizzati. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per visualizzare i segreti associati a un certificato TLS.
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
il traffico di rete viene instradato al programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione cerca il servizio associato e invia il traffico di rete al servizio e ai
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

7.  Verifica che la risorsa Ingress sia stata creata correttamente. Sostituisci
<em>&lt;myingressname&gt;</em> con il nome della risorsa Ingress che hai creato in
precedenza.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** potrebbero essere richiesti alcuni secondi prima che la risorsa Ingress venga creata correttamente e l'applicazione sia disponibile.

8.  Accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'URL del servizio dell'applicazione a cui vuoi accedere.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />




## Facoltativo: configurazione di un programma di bilanciamento del carico dell'applicazione
{: #configure_alb}

Puoi ulteriormente configurare un programma di bilanciamento del carico dell'applicazione con le seguenti opzioni.

-   [Apertura di porte nel programma di bilanciamento del carico dell'applicazione Ingress](#opening_ingress_ports)
-   [Configurazione di protocolli SSL e cifrature SSL a livello di HTTP](#ssl_protocols_ciphers)
-   [Personalizzazione del tuo programma di bilanciamento del carico dell'applicazione con le annotazioni](cs_annotations.html)
{: #ingress_annotation}


### Apertura di porte nel programma di bilanciamento del carico dell'applicazione Ingress 
{: #opening_ingress_ports}

Per impostazione predefinita, solo le porte 80 e 443 sono esposte nel programma di bilanciamento del carico dell'applicazione Ingress. Per esporre altre porte, puoi modificare la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

1.  Crea una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`. Aggiungi una sezione <code>data</code> e specifica le porte pubbliche 80, 443 e qualsiasi altra porta che vuoi aggiungere al file della mappa di configurazione separandole con un punto e virgola (;).

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

### Configurazione di protocolli SSL e cifrature SSL a livello di HTTP
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
