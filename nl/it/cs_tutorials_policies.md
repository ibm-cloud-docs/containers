---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Esercitazione: Utilizzo delle politiche di rete Calico per bloccare il traffico
{: #policy_tutorial}

Per impostazione predefinita, i servizi Ingress, LoadBalancer e NodePort Kubernetes rendono la tua applicazione disponibile su tutte le interfacce di rete cluster private e pubbliche. La politica Calico predefinita `allow-node-port-dnat` consente il traffico in entrata dai servizi Ingress, LoadBalancer e NodePort ai pod dell'applicazione esposti da tali servizi. Kubernetes utilizza la conversione degli indirizzi di rete di destinazione (o DNAT, destination network address translation) per inoltrare le richieste di servizio ai pod corretti.

Tuttavia, per motivi di sicurezza, potresti dover consentire il traffico ai servizi di rete solo da specifici indirizzi IP di origine. Puoi utilizzare le [politiche pre-DNAT Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/bare-metal/policy/pre-dnat) per inserire in whitelist o in blacklist il traffico da o verso specifici indirizzi IP. Le politiche pre-DNAT impediscono al traffico specificato di raggiungere le tue applicazioni perché vengono applicate prima che Kubernetes utilizzi la DNAT regolare per inoltrare il traffico ai pod. Quando crei delle politiche pre-DNAT Calico, scegli se inserire in whitelist o in blacklist gli indirizzi IP di origine. Per la maggior parte degli scenari, l'inserimento in whitelist fornisce la configurazione più sicura perché viene bloccato tutto il traffico tranne quello da indirizzi IP di origine noti e consentiti. L'inserimento in blacklist è di norma utile solo negli scenari in cui, ad esempio, si intende evitare un attacco da un piccolo insieme di indirizzi IP.

In questo scenario, hai il ruolo di amministratore di rete per una società di PR e noti del traffico insolito verso le tue applicazioni. Le lezioni in questa esercitazione ti guidano nella creazione di un'applicazione server web di esempio, nell'esposizione dell'applicazione utilizzando un servizio LoadBalancer e nella protezione dell'applicazione d traffico insolito e indesiderato con entrambe le politiche Calico di whitelist e blacklist.

## Obiettivi

- Impara a bloccare tutto il traffico in entrata per tutte le NodePort creando una politica pre-DNAT di ordine superiore.
- Impara a consentire agli indirizzi IP di origine inseriti nella whitelist l'accesso all'IP e alla porta pubblici del LoadBalancer creando una politica pre-DNAT di ordine inferiore. Le politiche di ordine inferiore sovrascrivono le politiche di ordine superiore.
- Impara a bloccare per gli indirizzi IP di origine inseriti nella blacklist l'accesso all'IP e alla porta pubblici del LoadBalancer creando una politica pre-DNAT di ordine inferiore.

## Tempo richiesto
1 ora

## Destinatari
Questa esercitazione è destinata agli sviluppatori di software e agli amministratori di rete che vogliono gestire il traffico di rete a un'applicazione.

## Prerequisiti

- [Crea un cluster versione 1.10](cs_clusters.html#clusters_ui) oppure [aggiorna un cluster esistente alla versione 1.10](cs_versions.html#cs_v110). È richiesto un cluster Kubernetes versione 1.10 o successive per utilizzare la CLI Calico 3.1.1 e la sintassi della politica di Calico v3 in questa esercitazione.
- [Indirizza la tua CLI al cluster](cs_cli_install.html#cs_cli_configure).
- [Installa e configura la CLI Calico](cs_network_policy.html#1.10_install).
- [Assicurati di disporre del ruolo della piattaforma **Editor**, **Operatore** o **Amministratore**](cs_users.html#add_users_cli).

<br />


## Lezione 1: Distribuisci un'applicazione ed esponila utilizzando un LoadBalancer
{: #lesson1}

La prima lezione ti mostra in che modo la tua applicazione viene esposta da molteplici indirizzi IP e porte e da dove proviene il traffico pubblico nel tuo cluster.
{: shortdesc}

Inizia distribuendo un'applicazione webserver di esempio da utilizzare in tutta l'esercitazione. Il webserver (server web) `echoserver` mostra i dati sulla connessione che si sta stabilendo al cluster dal client e ti consente di testare l'accesso al cluster della società di PR. Esponi quindi l'applicazione creando un servizio LoadBalancer. Un servizio LoadBalancer rende la tua applicazione disponibile sia sull'indirizzo IP del servizio LoadBalancer che sulle NodePort dei nodi di lavoro.

La seguente immagine mostra in che modo l'applicazione webserver sarà esposta a internet dalla NodePort pubblica e dal LoadBalancer pubblico alla fine della Lezione 1:

<img src="images/cs_tutorial_policies_Lesson1.png" width="450" alt="Alla fine della Lezione 1, l'applicazione webserver è esposta a internet dalla NodePort pubblica e dal LoadBalancer pubblico." style="width:450px; border-style: none"/>

1. Distribuisci l'applicazione webserver di esempio. Quando viene stabilita una connessione all'applicazione webserver, essa risponde con le intestazioni HTTP che aveva ricevuto nella connessione.
    ```
    kubectl run webserver --image=k8s.gcr.io/echoserver:1.10 --replicas=3
    ```
    {: pre}

2. Verifica che i pod dell'applicazione webserver abbiano una condizione (**STATUS**) di `Running`.
    ```
    kubectl get pods -o wide
    ```
    {: pre}

    Output di esempio:
    ```
    NAME                         READY     STATUS    RESTARTS   AGE       IP               NODE
    webserver-855556f688-6dbsn   1/1       Running   0          1m        172.30.xxx.xxx   10.176.48.78
    webserver-855556f688-76rkp   1/1       Running   0          1m        172.30.xxx.xxx   10.176.48.78
    webserver-855556f688-xd849   1/1       Running   0          1m        172.30.xxx.xxx   10.176.48.78
    ```
    {: screen}

3. Per esporre l'applicazione a internet pubblico, crea un file di configurazione del servizio LoadBalancer denominato `webserver.yaml` in un editor di testo.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: webserver
      name: webserver-lb
      namespace: pr-firm
    spec:
      externalTrafficPolicy: Cluster
      ports:
      - name: webserver-port
        port: 80
        protocol: TCP
        targetPort: 8080
      selector:
        run: webserver
      type: LoadBalancer
    ```
    {: codeblock}

4. Distribuisci il LoadBalancer.
    ```
    kubectl apply -f filepath/webserver-lb.yaml
    ```
    {: pre}

5. Verifica che puoi accedere pubblicamente all'applicazione esposta dal LoadBalancer dal tuo computer.

    1. Ottieni l'indirizzo **EXTERNAL-IP** pubblico del LoadBalancer.
        ```
        kubectl get svc -o wide
        ```
        {: pre}

        Output di esempio:
        ```
        NAME           CLUSTER-IP       EXTERNAL-IP        PORT(S)        AGE       SELECTOR
        webserver-lb   172.21.xxx.xxx   169.xx.xxx.xxx     80:31024/TCP   2m        run=webserver
        ```
        {: screen}

    2. Crea un file di testo di scheda di riferimento e copia in esso l'IP del LoadBalancer. La scheda di riferimento ti aiuterà a usare più rapidamente i valori nelle lezioni successive.

    3. Verifica che puoi accedere pubblicamente all'IP esterno per il LoadBalancer.
        ```
        curl --connect-timeout 10 <loadbalancer_IP>:80
        ```
        {: pre}

        Il seguente output di esempio conferma che il LoadBalancer espone la tua applicazione sull'indirizzo IP del LoadBalancer pubblico `169.1.1.1`. Il pod dell'applicazione `webserver-855556f688-76rkp` ha ricevuto la richiesta curl:
        ```
        Hostname: webserver-855556f688-76rkp
        Pod Information:
            -no pod information available-
        Server values:
            server_version=nginx: 1.13.3 - lua: 10008
        Request Information:
            client_address=1.1.1.1
            method=GET
            real path=/
            query=
            request_version=1.1
            request_scheme=http
            request_uri=http://169.1.1.1:8080/
        Request Headers:
            accept=*/*
            host=169.1.1.1
            user-agent=curl/7.54.0
        Request Body:
            -no body in request-
        ```
        {: screen}

6. Verifica che puoi accedere pubblicamente all'applicazione esposta dalla NodePort dal tuo computer. Un servizio LoadBalancer rende la tua applicazione disponibile sia sull'indirizzo IP del servizio LoadBalancer che sulle NodePort dei nodi di lavoro.

    1. Ottieni la NodePort che il LoadBalancer ha assegnato ai nodi di lavoro. La NodePort è compresa nell'intervallo 30000 - 32767.
        ```
        kubectl get svc -o wide
        ```
        {: pre}

        Nel seguente output di esempio, la NodePort è `31024`:
        ```
        NAME           CLUSTER-IP       EXTERNAL-IP        PORT(S)        AGE       SELECTOR
        webserver-lb   172.21.xxx.xxx   169.xx.xxx.xxx     80:31024/TCP   2m        run=webserver
        ```
        {: screen}  

    2. Ottieni l'indirizzo **Public IP** di un nodo di lavoro.
        ```
        ibmcloud ks workers <cluster_name>
        ```
        {: pre}

        Output di esempio:
        ```
        ID                                                 Public IP        Private IP     Machine Type        State    Status   Zone    Version   
        kube-dal10-cr18e61e63c6e94b658596ca93d087eed9-w1   169.xx.xxx.xxx   10.176.48.67   u2c.2x4.encrypted   normal   Ready    dal10   1.10.7_1513*   
        kube-dal10-cr18e61e63c6e94b658596ca93d087eed9-w2   169.xx.xxx.xxx   10.176.48.79   u2c.2x4.encrypted   normal   Ready    dal10   1.10.7_1513*   
        kube-dal10-cr18e61e63c6e94b658596ca93d087eed9-w3   169.xx.xxx.xxx   10.176.48.78   u2c.2x4.encrypted   normal   Ready    dal10   1.10.7_1513*   
        ```
        {: screen}

    3. Copia l'IP pubblico del nodo di lavoro e la NodePort nella tua scheda di riferimento testuale per un utilizzo nelle lezioni successive.

    4. Verifica che puoi accedere all'indirizzo IP pubblico del nodo di lavoro tramite la NodePort.
        ```
        curl  --connect-timeout 10 <worker_IP>:<NodePort>
        ```
        {: pre}

        Il seguente output di esempio conferma che la richiesta alla tua applicazione è arrivata tramite l'indirizzo IP privato `10.1.1.1` per il nodo di lavoro e la NodePort `31024`. Il pod dell'applicazione `webserver-855556f688-xd849` ha ricevuto la richiesta curl:
        ```
        Hostname: webserver-855556f688-xd849
        Pod Information:
            -no pod information available-
        Server values:
            server_version=nginx: 1.13.3 - lua: 10008
        Request Information:
            client_address=1.1.1.1
            method=GET
            real path=/
            query=
            request_version=1.1
            request_scheme=http
            request_uri=http://10.1.1.1:8080/
        Request Headers:
            accept=*/*
            host=10.1.1.1:31024
            user-agent=curl/7.60.0
        Request Body:
            -no body in request-
        ```
        {: screen}

A questo punto, la tua applicazione è esposta a molteplici indirizzi IP e porte. La maggior parte di questi IP è interna al cluster ed è possibile accedervi solo sulla rete privata. Solo la NodePort pubblica e la porta del LoadBalancer pubblica sono esposte a internet pubblico.

Puoi quindi iniziare a creare ed applicare politiche Calico per bloccare il traffico pubblico.

## Lezione 2: Blocco di tutto il traffico in arrivo verso tutte le NodePort
{: #lesson2}

Per proteggere il cluster dell'agenzia di PR, devi bloccare l'accesso pubblico sia al servizio LoadBalancer che alle NodePort che stanno esponendo la tua applicazione. Inizia bloccando l'accesso alle NodePort. La seguente immagine mostra come verrà consentito il traffico al LoadBalancer ma non alle NodePort alla fine della Lezione 2:

<img src="images/cs_tutorial_policies_Lesson2.png" width="450" alt="Alla fine della Lezione 2, l'applicazione webserver è esposta a Internet solo dal LoadBalancer pubblico." style="width:450px; border-style: none"/>

1. In un editor di testo, crea una politica pre-DNAT di ordine superiore denominata `deny-nodeports.yaml` per negare il traffico TCP e UDP in entrata d qualsiasi IP di origine a tutte le NodePort.
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: deny-nodeports
    spec:
      applyOnForward: true
      ingress:
      - action: Deny
            destination:
              ports:
          - 30000:32767
            protocol: TCP
            source: {}
      - action: Deny
            destination:
              ports:
          - 30000:32767
        protocol: UDP
        source: {}
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 1100
      types:
      - Ingress
    ```
    {: codeblock}

2. Applica la politica.
    - Linux:

      ```
      calicoctl apply -f filepath/deny-nodeports.yaml
      ```
      {: pre}

    - Windows e OS X:

      ```
      calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}
  Output di esempio:
  ```
  Successfully applied 1 'GlobalNetworkPolicy' resource(s)
  ```
  {: screen}

3. Utilizzando il valori dalla tua scheda di riferimento, verifica che non puoi accedere pubblicamente alla NodePort e all'indirizzo IP pubblico del nodo di lavoro.
    ```
    curl  --connect-timeout 10 <worker_IP>:<NodePort>
    ```
    {: pre}

    La connessione va in timeout perché la politica Calico da te creata sta bloccando il traffico alle NodePort.
    ```
    curl: (28) Connection timed out after 10016 milliseconds
    ```
    {: screen}

4. Modifica la externalTrafficPolicy del LoadBalancer che hai creato nella lezione precedente da `Cluster` a `Local`. `Local` garantisce che l'IP di origine del tuo sistema venga preservato quando esegui il curl dell'IP esterno del LoadBalancer nel passo successivo.
    ```
    kubectl patch svc webserver-lb -p '{"spec":{"externalTrafficPolicy":"Local"}}'
    ```
    {: pre}

5. Utilizzando il valore dalla tua scheda di riferimento, verifica che puoi ancora accedere pubblicamente all'indirizzo IP esterno del LoadBalancer.
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}

    Output di esempio:
    ```
    Hostname: webserver-855556f688-76rkp
    Pod Information:
        -no pod information available-
    Server values:
        server_version=nginx: 1.13.3 - lua: 10008
    Request Information:
        client_address=1.1.1.1
        method=GET
        real path=/
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://<loadbalancer_IP>:8080/
    Request Headers:
        accept=*/*
        host=<loadbalancer_IP>
        user-agent=curl/7.54.0
    Request Body:
        -no body in request-
    ```
    {: screen}
    Nella sezione `Request Information` dell'output, nota che l'indirizzo IP di origine è, ad esempio, `client_address=1.1.1.1`. L'indirizzo IP di origine è l'IP pubblico del sistema che stai utilizzando per eseguire curl. Altrimenti, se ti stai collegando a internet tramite un proxy o una VPN, è possibile che questi ultimi stiano oscurando l'indirizzo IP effettivo del tuo sistema. In entrambi i casi, il LoadBalancer vede l'indirizzo IP di origine del tuo sistema come l'indirizzo IP del client.

6. Copia l'indirizzo IP di origine del sistema (`client_address=1.1.1.1` nell'output del passo precedente) nella tua scheda di riferimento per utilizzarlo nelle lezioni successive.

Ottimo! A questo punto la tua applicazione è esposta a internet pubblico solo dalla porta del LoadBalancer pubblica. Il traffico alle NodePort pubbliche è bloccato. Hai parzialmente bloccato il tuo cluster al traffico indesiderato.

Ora puoi creare e applicare le politiche Calico per inserire in whitelist il traffico da specifici IP di origine.

## Lezione 3: Consenti il traffico in entrata da un IP inserito in whitelist al LoadBalancer
{: #lesson3}

Ora decidi di bloccare completamente il traffico al cluster dell'agenzia di PR e di testare l'accesso inserendo in whitelist solo l'indirizzo IP del tuo computer.
{: shortdesc}

Per prima cosa, oltre alle NodePort, devi bloccare tutto il traffico in entrata al LoadBalancer che espone l'applicazione. Puoi quindi creare una politica che inserisce in whitelist l'indirizzo IP del tuo sistema. Alla fine della Lezione 3, tutto il traffico alle NodePort pubbliche e al LoadBalancer sarà bloccato e sarà consentito solo il traffico dal tuo IP di sistema inserito in whitelist.
<img src="images/cs_tutorial_policies_L3.png" width="600" alt="L'applicazione webserver è esposta dal LoadBalancer pubblico solo all'IP del tuo sistema" style="width:600px; border-style: none"/>

1. In un editor di testo, crea una politica pre-DNAT di ordine superiore denominata `deny-lb-port-80.yaml` per negare tutto il traffico TCP e UDP da qualsiasi IP di origine all'indirizzo IP e alla porta del LoadBalancer. Sostituisci `<loadbalancer_IP>` con l'indirizzo IP pubblico del LoadBalancer dalla tua scheda di riferimento.
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: deny-lb-port-80
    spec:
      applyOnForward: true
      ingress:
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source: {}
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: UDP
        source: {}
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 1100
      types:
      - Ingress
    ```
    {: codeblock}

2. Applica la politica.
    - Linux:

      ```
      calicoctl apply -f filepath/deny-lb-port-80.yaml
      ```
      {: pre}

    - Windows e OS X:

      ```
      calicoctl apply -f filepath/deny-lb-port-80.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

3. Utilizzando il valore dalla tua scheda di riferimento, verifica che ora non puoi accedere all'indirizzo IP del LoadBalancer pubblico. La connessione va in timeout perché la politica Calico da te creata sta bloccando il traffico al LoadBalancer.
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}

4. In un editor di testo, crea una politica pre-DNAT di ordine inferiore denominata `whitelist.yaml` per consentire il traffico dall'IP del tuo sistema all'indirizzo IP e alla porta del LoadBalancer. Utilizzando i valori dalla tua scheda di riferimento, sostituisci `<loadbalancer_IP>` con l'indirizzo IP pubblico del LoadBalancer e `<client_address>` con l'indirizzo IP pubblico dell'IP di origine del tuo sistema.
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
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
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: codeblock}

5. Applica la politica.
    - Linux:

      ```
      calicoctl apply -f filepath/whitelist.yaml
      ```
      {: pre}

    - Windows e OS X:

      ```
      calicoctl apply -f filepath/whitelist.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}
  L'indirizzo IP del tuo sistema è ora inserito nella whitelist.

6. Utilizzando il valore dalla tua scheda di riferimento, verifica che ora puoi accedere all'indirizzo IP del LoadBalancer pubblico.
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}

7. Se hai accesso a un altro sistema che ha un indirizzo IP differente, prova ad accedere al LoadBalancer da tale sistema.
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}
    La connessione va in timeout perché l'indirizzo IP del sistema non è inserita nella whitelist.

A questo punto, tutto il traffico alle NodePort pubbliche e al LoadBalancer è bloccato. È consentito solo il traffico dal tuo IP di sistema inserito nella whitelist.

## Lezione 4: Negare il traffico in entrata da IP inseriti nella blacklist al LoadBalancer
{: #lesson4}

Nella lezione precedente, hai bloccato tutto il traffico e inserito nella whitelist solo alcuni IP. Tale scenario funziona bene per scopi di test quando vuoi limitare l'accesso solo a pochi indirizzi IP di origine controllati. Tuttavia, l'agenzia di PR ha delle applicazioni che devono essere ampiamente disponibili per il pubblico. Devi assicurarti che sia consentito tutto il traffico, fatta eccezione per il traffico insolito che vedi da qualche indirizzo IP. L'inserimento in blacklist è utile in uno scenario come questo perché può aiutare ad evitare un attacco da un piccolo insieme di indirizzi IP,

In questa lezione, farai un test dell'inserimento in blacklist bloccando il traffico dall'indirizzo IP di origine del tuo sistema. Alla fine della Lezione 4, tutto il traffico alle NodePort pubbliche sarà bloccato e tutto il traffico al LoadBalancer pubblico sarà consentito. Sarà bloccato solo il traffico dal tuo IP di sistema inserito nella blacklist al LoadBalancer.
<img src="images/cs_tutorial_policies_L4.png" width="600" alt="L'applicazione webserver è esposta dal LoadBalancer pubblico a internet. Solo il traffico dal tuo IP di sistema è bloccato." style="width:600px; border-style: none"/>

1. Elimina le politiche di whitelist che hai creato nella lezione precedente.
    - Linux:
      ```
      calicoctl delete GlobalNetworkPolicy deny-lb-port-80
      ```
      {: pre}
      ```
      calicoctl delete GlobalNetworkPolicy whitelist
      ```
      {: pre}

    - Windows e OS X:
      ```
      calicoctl delete GlobalNetworkPolicy deny-lb-port-80 --config=filepath/calicoctl.cfg
      ```
      {: pre}
      ```
      calicoctl delete GlobalNetworkPolicy whitelist --config=filepath/calicoctl.cfg
      ```
      {: pre}

    Ora tutto il traffico TCP e UDP in entrata da qualsiasi IP di origine all'indirizzo IP e alla porta del LoadBalancer è nuovamente consentito.

2. Per negare tutto il traffico TCP e UDP in entrata dall'indirizzo IP di origine del tuo sistema all'indirizzo IP e alla porta del LoadBalancer, crea una politica pre-DNAT di ordine inferiore denominata `deny-lb-port-80.yaml` in un editor di testo. Utilizzando i valori dalla tua scheda di riferimento, sostituisci `<loadbalancer_IP>` con l'indirizzo IP pubblico del LoadBalancer e `<client_address>` con l'indirizzo IP pubblico dell'IP di origine del tuo sistema.
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: blacklist
    spec:
      applyOnForward: true
      ingress:
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      - action: Deny
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: UDP
        source:
          nets:
          - <client_address>/32
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: codeblock}

3. Applica la politica.
    - Linux:

      ```
      calicoctl apply -f filepath/blacklist.yaml
      ```
      {: pre}

    - Windows e OS X:

      ```
      calicoctl apply -f filepath/blacklist.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}
  L'indirizzo IP del tuo sistema è ora inserito nella blacklist.

4. Utilizzando il valore dalla tua scheda di riferimento, verifica dal tuo sistema che non puoi accedere all'IP LoadBalancer perché l'IP del tuo sistema è stato inserito nella blacklist.
    ```
    curl --connect-timeout 10 <loadbalancer_IP>:80
    ```
    {: pre}
    A questo punto, tutto il traffico alle NodePort pubbliche è bloccato e tutto il traffico al LoadBalancer pubblico è consentito. Solo il traffico dall'IP di sistema inserito nella blacklist al LoadBalancer è bloccato.

5. Per ripulire questa politica di blacklist:

    - Linux:
      ```
      calicoctl delete GlobalNetworkPolicy blacklist
      ```
      {: pre}

    - Windows e OS X:
      ```
      calicoctl delete GlobalNetworkPolicy blacklist --config=filepath/calicoctl.cfg
      ```
      {: pre}

Ottimo lavoro! Hai controllato con successo il traffico nella tua applicazione utilizzando le politiche pre-DNAT Calico per inserire in whitelist e blacklist gli IP origine.

## Operazioni successive
{: #whats_next}

* Leggi ulteriori informazioni sul [controllo del traffico con le politiche di rete](cs_network_policy.html).
* Per ulteriori politiche di rete Calico di esempio che controllano il traffico verso o dal tuo cluster, puoi controllare la [demo della politica stars ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) e la [politica di rete avanzata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy).
