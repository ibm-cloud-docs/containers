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



# Modifica della modalità di funzionamento Ingress predefinita
{: #ingress-settings}

Dopo che hai esposto le tue applicazioni creando una risorsa Ingress, puoi configurare ulteriormente gli ALB Ingress nel tuo cluster impostando le seguenti opzioni.
{: shortdesc}

## Apertura delle porte nell'ALB Ingress
{: #opening_ingress_ports}

Per impostazione predefinita, solo le porte 80 e 443 sono esposte nell'ALB Ingress. Per esporre altre porte, puoi modificare la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.
{: shortdesc}

1. Modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Aggiungi una sezione <code>data</code> e specifica le porte pubbliche `80`, `443` e le altre porte che vuoi esporre separate da un punto e virgola (;).

    Per impostazione predefinita, sono aperte le porte 80 e 443. Se vuoi mantenere le porte 80 e 443 aperte, devi includerle in aggiunta a tutte le altre porte che specifichi nel campo `public-ports`. Qualsiasi porta che non sia specificata viene chiusa. Se hai abilitato un ALB privato, devi inoltre specificare tutte le porte che vuoi mantenere aperte nel campo `private-ports`.
    {: important}

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Esempio che mantiene le porte `80`, `443` e `9443` aperte:
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.
  ```
  kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
  ```
  {: pre}

5. Facoltativo:
  * Accedi a un'applicazione tramite una porta TCP non standard che hai aperto utilizzando l'annotazione [`tcp-ports`](/docs/containers?topic=containers-ingress_annotation#tcp-ports).
  * Modifica le porte predefinite per il traffico di rete HTTP (porta 80) e HTTPS (porta 443) con una porta che hai aperto utilizzando l'annotazione [`custom-port`](/docs/containers?topic=containers-ingress_annotation#custom-port).

Per ulteriori informazioni sulle risorse della mappa di configurazione, vedi la [documentazione di Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

<br />


## Conservazione dell'indirizzo IP di origine
{: #preserve_source_ip}

Per impostazione predefinita, l'indirizzo IP di origine della richiesta client non viene conservato. Quando una richiesta client alla tua applicazione viene inviata al tuo cluster, la richiesta viene instradata a un pod per il servizio di programma di bilanciamento del carico che espone l'ALB. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, il programma di bilanciamento inoltra la richiesta a un pod dell'applicazione su un nodo di lavoro diverso. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione.
{: shortdesc}

Per preservare l'indirizzo IP di origine originale della richiesta client, puoi abilitare la [conservazione dell'IP di origine ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). La conservazione dell'IP del client è utile quando, ad esempio, i server delle applicazioni devono applicare le politiche di sicurezza e di controllo dell'accesso.

Se [disabiliti un ALB](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure), eventuali modifiche all'IP di origine che apporti al servizio di bilanciamento del carico che espone l'ALB andranno perse. Quando riabiliti l'ALB, devi abilitare di nuovo l'IP di origine.
{: note}

Per abilitare la conservazione dell'IP di origine, modifica il servizio del programma di bilanciamento del carico che espone un ALB Ingress:

1. Abilita la conservazione dell'IP di origine per un singolo ALB o per tutti gli ALB nel tuo cluster.
    * Per impostare la conservazione dell'IP di origine per un singolo ALB:
        1. Ottieni l'ID dell'ALB per il quale vuoi abilitare l'IP di origine. I servizi ALB hanno un formato simile a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` per un ALB pubblico o `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` per un ALB privato.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Apri il file YAML per il servizio del programma di bilanciamento del carico che espone l'ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. In **`spec`**, modifica il valore di **`externalTrafficPolicy`** da `Cluster` a `Local`.

        4. Salva e chiudi il file di configurazione. L'output è simile al seguente:

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Per impostare la conservazione dell'IP di origine per tutti gli ALB pubblici nel tuo cluster, esegui questo comando:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Output di esempio:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Per impostare la conservazione dell'IP di origine per tutti gli ALB privati nel tuo cluster, esegui questo comando:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Output di esempio:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verifica che l'IP di origine venga conservato nei log dei tuoi pod ALB.
    1. Ottieni l'ID di un pod per l'ALB che hai modificato.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Apri i log relativi a tale pod ALB. Verifica che l'indirizzo IP per il campo `client` sia l'indirizzo IP della richiesta client invece dell'indirizzo IP del servizio del programma di bilanciamento del carico.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Ora, quando nelle intestazioni ricerchi le richieste inviate alla tua applicazione di back-end, puoi vedere l'indirizzo IP del client nell'intestazione `x-forwarded-for`.

4. Se non vuoi più conservare l'IP di origine, puoi ripristinare le modifiche apportate al servizio.
    * Per ripristinare la conservazione dell'IP di origine per i tuoi ALB pubblici:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Per ripristinare la conservazione dell'IP di origine per i tuoi ALB privati:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## Configurazione di protocolli SSL e cifrature SSL a livello di HTTP
{: #ssl_protocols_ciphers}

Abilita i protocolli e le cifrature SSL a livello globale HTTP modificando la mappa di configurazione `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

Per rispettare il mandato del Consiglio per gli standard di sicurezza PCI, il servizio Ingress disabilita TLS 1.0 e 1.1 per impostazione predefinita con l'imminente aggiornamento della versione dei pod ALB Ingress in data 23 gennaio 2019. L'aggiornamento viene distribuito automaticamente a tutti i cluster {{site.data.keyword.containerlong_notm}} che non hanno disattivato gli aggiornamenti automatici ALB. Se i client che si connettono alle tue applicazioni supportano TLS 1.2, non è richiesta alcuna azione. Se hai ancora dei client legacy che richiedono il supporto TLS 1.0 o 1.1, devi abilitare manualmente le versioni TLS richieste. Puoi sovrascrivere l'impostazione predefinita per utilizzare i protocolli TLS 1.1 o 1.0 seguendo le procedure in questa sezione. Per ulteriori informazioni su come visualizzare le versioni TLS utilizzate dai tuoi client per accedere alle applicazioni, vedi questo [post del blog {{site.data.keyword.cloud_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).
{: important}

Quando specifichi i protocolli abilitati per tutti gli host, i parametri TLSv1.1 e TLSv1.2 (1.1.13, 1.0.12) funzionano solo se viene utilizzato OpenSSL 1.0.1 o superiore. Il parametro TLSv1.3 (1.13.0) funziona solo quando viene utilizzato OpenSSL 1.1.1 sviluppato con il supporto TLSv1.3.
{: note}

Per modificare la mappa di configurazione per l'abilitazione di protocolli e cifrature SSL:

1. Modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Aggiungi i protocolli e le cifrature SSL. Formatta le cifrature in base al [formato dell'elenco di cifrature della libreria OpenSSL ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

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

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Aumento del tempo di controllo della disponibilità dei riavvii per i pod ALB
{: #readiness-check}

Aumenta la quantità di tempo che i pod ALB hanno per analizzare file di risorse Ingress di grandi dimensioni quando vengono riavviati i pod ALB.
{: shortdesc}

Quando un pod ALB viene riavviato, come ad esempio dopo l'applicazione di un aggiornamento, un controllo della disponibilità impedisce che il pod ALB provi a instradare le richieste di traffico fino a quando non vengono analizzati tutti i file di risorse Ingress. Questo controllo della disponibilità impedisce la perdita di richieste quando vengono riavviati i pod ALB. Per impostazione predefinita, il controllo della disponibilità attende 15 secondi dopo il riavvio del pod per iniziare a controllare se sono stati analizzati tutti i file Ingress. Se tutti i file sono stati analizzati 15 secondi dopo il riavvio del pod, il pod ALB inizia nuovamente a instradare le richieste di traffico. Se non tutti i file sono stati analizzati 15 secondi dopo il riavvio del pod, il pod non instrada il traffico e il controllo della disponibilità continua ad eseguire la verifica ogni 15 secondi per un timeout massimo di 5 minuti. Dopo 5 minuti, il pod ALB inizia a instradare il traffico.

Se hai dei file di risorse Ingress molto grandi, l'analisi di tutti i file potrebbe richiedere più di 5 minuti. Puoi modificare i valori predefiniti per la frequenza di intervallo del controllo di disponibilità e per il timeout massimo totale del controllo di disponibilità aggiungendo le impostazioni `ingress-resource-creation-rate` e `ingress-resource-timeout` alla mappa di configurazione `ibm-cloud-provider-ingress-cm`-

1. Modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Nella sezione **data**, aggiungi le impostazioni `ingress-resource-creation-rate` e `ingress-resource-timeout`. I valori possono essere formattati come secondi (`s`) e i minuti (`m`). Esempio:
   ```
   apiVersion: v1
   data:
     ingress-resource-creation-rate: 1m
     ingress-resource-timeout: 6m
     keep-alive: 8s
     private-ports: 80;443
     public-ports: 80;443
   ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.
   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Ottimizzazione delle prestazioni ALB
{: #perf_tuning}

Per ottimizzare le prestazioni dei tuoi ALB Ingress, puoi modificare le impostazioni predefinite in base alle tue necessità.
{: shortdesc}

### Aggiunta di listener socket ALB a ogni nodo di lavoro
{: #reuse-port}

Aumenta il numero di listener socket ALB da uno per ogni cluster a uno per ogni nodo di lavoro utilizzando la direttiva Ingress `reuse-port`.
{: shortdesc}

Quando l'opzione `reuse-port` è disabilitata, un singolo socket in ascolto informa i nodi di lavoro delle connessioni in arrivo e tutti i nodi di lavoro provano a prendere la connessione. Quando però è abilitata `reuse-port`, esiste un singolo listener socket per ogni nodo di lavoro per ogni combinazione di indirizzo IP e porta di ALB. Non è più ciascun nodo di lavoro a provare a prendere la connessione ma è il kernel Linux che determina quale listener socket disponibile ottiene la connessione. Il conflitto di blocco tra i nodi di lavoro è ridotto, con un conseguente miglioramento delle prestazioni. Per ulteriori informazioni sui vantaggi e sugli svantaggi della direttiva `reuse-port`, vedi [questo post del blog NGINX![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/).

Puoi ridimensionare i listener modificando la mappa di configurazione Ingress `ibm-cloud-provider-ingress-cm`.

1. Modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Nella sezione `metadata`, aggiungi `reuse-port: "true"`. Esempio:
   ```
   apiVersion: v1
   data:
     private-ports: 80;443;9443
     public-ports: 80;443
   kind: ConfigMap
   metadata:
     creationTimestamp: "2018-09-28T15:53:59Z"
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
     resourceVersion: "24648820"
     selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
     uid: b6ca0c36-c336-11e8-bf8c-bee252897df5
     reuse-port: "true"
   ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Abilitazione del buffering di log e del timeout di scarico
{: #access-log}

Per impostazione predefinita, l'ALB Ingress registra ogni richiesta appena arriva. Se hai un ambiente utilizzato in modo intensivo, la registrazione di ciascuna richiesta appena arriva può aumentare notevolmente l'utilizzo di I/O del disco. Per evitare un continuo I/O del disco, puoi abilitare il buffering di log e il timeout di scarico per l'ALB modificando la mappa di configurazione di Ingress `ibm-cloud-provider-ingress-cm`. Quando il buffering è abilitato, invece di eseguire un'operazione di scrittura separata per ciascuna voce di log, l'ALB memorizza in buffer una serie di voci e le scrive insieme nel file in una singola operazione.
{: shortdesc}

1. Crea e modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifica la mappa di configurazione.
    1. Abilita il buffering di log aggiungendo il campo `access-log-buffering` e impostandolo su `"true"`.

    2. Imposta la soglia per quando l'ALB deve scrivere il contenuto del buffer nel log.
        * Intervallo di tempo: aggiungi il campo `flush-interval` e impostalo su quanto spesso l'ALB deve scrivere nel log. Ad esempio, se viene utilizzato il valore predefinito di `5m`, l' ALB scrive il contenuto del buffer nel log una volta ogni 5 minuti.
        * Dimensione del buffer: aggiungi il campo `buffer-size` e impostalo su quanta memoria di log può essere contenuta nel buffer prima che l'ALB scriva il contenuto del buffer nel log. Ad esempio, se viene utilizzato il valore predefinito `100KB`, l'ALB scrive il contenuto del buffer nel log ogni volta che il buffer raggiunge i 100kb di contenuto di log.
        * Intervallo di tempo o dimensione del buffer: quando vengono impostati sia `flush-interval` che `buffer-size`, l'ALB scrive il contenuto del buffer nel log in base al parametro di soglia che viene soddisfatto per primo.

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che il tuo ALB sia configurato con le modifiche del log di accesso.

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### Modifica del numero o della durata delle connessioni keepalive
{: #keepalive_time}

Le connessioni keepalive possono avere un impatto significativo sulle prestazioni riducendo l'utilizzo di CPU e rete necessario per aprire e chiudere le connessioni. Per ottimizzare le prestazioni dei tuoi ALB, puoi modificare il numero massimo di connessioni keepalive tra l'ALB e il client e la durata possibile delle connessioni keepalive.
{: shortdesc}

1. Modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifica i valori di `keep-alive-requests` e `keep-alive`.
    * `keep-alive-requests`: il numero di connessioni client keepalive che possono rimanere aperte all'ALB Ingress. Il valore predefinito è `4096`.
    * `keep-alive`: il timeout, in secondi, durante il quale la connessione client keepalive rimane aperta all'ALB Ingress. Il valore predefinito è `8s`.
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Modifica del backlog di connessioni in sospeso
{: #backlog}

Puoi ridurre l'impostazione di backlog predefinita relativa al numero di connessioni in sospeso che può attendere nella coda del server.
{: shortdesc}

Nella mappa di configurazione Ingress `ibm-cloud-provider-ingress-cm`, il campo `backlog` imposta il numero massimo di connessioni in sospeso che può attendere nella coda del server. Per impostazione predefinita, `backlog` è impostato su `32768`. Puoi sovrascrivere il valore predefinito modificando la mappa di configurazione Ingress.

1. Modifica il file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifica il valore di `backlog` da `32768` a un valore più basso. Il valore deve essere uguale o inferiore a 32768.

   ```
   apiVersion: v1
   data:
     backlog: "32768"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Ottimizzazione delle prestazioni del kernel
{: #ingress_kernel}

Per ottimizzare le prestazioni dei tuoi ALB Ingress, puoi anche [modificare i parametri `sysctl` del kernel Linux sui nodi di lavoro](/docs/containers?topic=containers-kernel). Dei nodi di lavoro viene eseguito automaticamente il provisioning con la regolazione del kernel ottimizzata; ti invitiamo pertanto a modificare queste impostazioni sono se hai degli specifici requisiti di ottimizzazione delle prestazioni.
{: shortdesc}

<br />

