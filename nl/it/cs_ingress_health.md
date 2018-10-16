---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Registrazione e monitoraggio di Ingress
{: #ingress_health}

Personalizza la registrazione e configura il monitoraggio per un supporto nella risoluzione dei problemi e per migliorare le prestazioni della tua configurazione Ingress.
{: shortdesc}

## Visualizzazione dei log Ingress
{: #ingress_logs}

I log vengono raccolti automaticamente per i tuoi ALB Ingress  Per visualizzare i log ALB, scegli tra due opzioni.
* [Crea una configurazione di registrazione per il servizio Ingress](cs_health.html#configuring) nel tuo cluster.
* Controlla i log dalla CLI.
    1. Ottieni l'ID di un pod per un ALB.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Apri i log relativi a tale pod ALB. Verifica che tutti i log seguano il formato aggiornato.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>Il contenuto del log Ingress predefinito è formattato in JSON e visualizza i campi comuni che descrivono la sessione di connessione tra un client e la tua applicazione. Un log di esempio con i campi predefiniti è simile al seguente:

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>Descrizione dei campi nel formato di log Ingress predefinito</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei campi nel formato di log Ingress predefinito</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>L'ora locale nel formato standard ISO 8601 quando viene scritto il log.</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>L'indirizzo IP del pacchetto di richieste che il client ha inviato alla tua applicazione. Questo IP può cambiare in base alle seguenti situazioni:<ul><li>Quando una richiesta client alla tua applicazione viene inviata al tuo cluster, la richiesta viene instradata a un pod per il servizio di programma di bilanciamento del carico che espone l'ALB. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, il programma di bilanciamento inoltra la richiesta a un pod dell'applicazione su un nodo di lavoro diverso. L'indirizzo IP di origine del pacchetto di richieste viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione.</li><li>Se la [conservazione dell'IP di origine è abilitata](cs_ingress.html#preserve_source_ip), viene invece registrato l'indirizzo IP originale della richiesta client alla tua applicazione.</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>L'host, o il dominio secondario, tramite cui sono accessibili le tue applicazioni. Questo host è configurato nei file di risorse Ingress per i tuoi ALB.</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>Il tipo di richiesta: <code>HTTP</code> o <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>Il metodo della chiamata di richiesta all'applicazione di backend, come ad esempio <code>GET</code> o <code>POST</code>.</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>L'URI della richiesta originale al tuo percorso dell'applicazione. Gli ALB elaborano i percorsi su cui le applicazioni sono in ascolto sotto forma di prefissi. Alla ricezione di una richiesta da un client a un'applicazione, l'ALB controlla la risorsa Ingress per rilevare un percorso (come prefisso) che corrisponda al percorso nell'URI della richiesta. </td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>Un identificativo richiesta univoco generato da 16 byte casuali.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>Il codice di stato per la sessione di connessione.<ul>
<li><code>200</code>: la sessione è stata completata correttamente</li>
<li><code>400</code>: impossibile analizzare i dati del client</li>
<li><code>403</code>: accesso non consentito, ad esempio quando l'accesso è limitato per specifici indirizzi IP client</li>
<li><code>500</code>: errore server interno</li>
<li><code>502</code>: gateway non valido; ad esempio, se non è possibile selezionare o raggiungere un server upstream</li>
<li><code>503</code>: servizio non disponibile; ad esempio quando l'accesso è limitato dal numero di connessioni</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>L'indirizzo IP e la porta o il percorso al socket del dominio UNIX del server di upstream. Se vengono contattati diversi server durante l'elaborazione della richiesta, i loro indirizzi sono separati da virgole: <code>"192.168.1.1:1:80, 192.168.1.2:80, unix:/tmp/sock"</code>. Se la richiesta viene reindirizzata internamente da un gruppo di server a un altro, gli indirizzi server da gruppi differenti sono separati da due punti: <code>"192.168.1.1:1:80, 192.168.1.2:80, unix:/tmp/sock: 192.168.10.1:80, 192.168.10.2:80"</code>. Se l'ALB non riesce a selezionare un server, viene invece registrato il nome del gruppo di server.</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>Il codice di stato della risposta ottenuta dal server di upstream per l'applicazione di backend, come i codici di risposta HTTP standard. I codici di stato di diverse risposte sono separati da virgole e da due punti come indirizzi nella variabile <code>$upstream_addr</code>. Se l'ALB non riesce a selezionare un server, viene registrato il codice di stato 502 (Bad Gateway).</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>Il tempo di elaborazione della richiesta, misurato in secondi con una risoluzione di millisecondi. Questo tempo inizia quando l'ALB legge i primi byte della richiesta del client e si arresta quando l'ALB invia gli ultimi byte della risposta al client. Il log viene scritto subito dopo che il tempo di elaborazione della richiesta si arresta.</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>Il tempo che impiega l'ALB per ricevere la risposta dal server di upstream per l'applicazione di backend, misurata in secondi con una risoluzione di millisecondi. I tempi di diverse risposte sono separati da virgole e da due punti come indirizzi nella variabile <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>Il tempo che impiega l'ALB per stabilire una connessione con il server di upstream per l'applicazione di backend, misurata in secondi con una risoluzione di millisecondi. Se TLS/SSL è abilitato nella tua configurazione della risorsa Ingress, questo tempo include il tempo impiegato per l'handshake. I tempi di diverse connessioni sono separati da virgole e da due punti come indirizzi nella variabile <code>$upstream_addr</code> .</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>Il tempo che impiega l'ALB per ricevere l'intestazione della risposta dal server di upstream per l'applicazione di backend, misurata in secondi con una risoluzione di millisecondi. I tempi di diverse connessioni sono separati da virgole e da due punti come indirizzi nella variabile <code>$upstream_addr</code> .</td>
</tr>
</tbody></table>

## Personalizzazione del formato e del contenuto del log Ingress
{: #ingress_log_format}

Puoi personalizzare il contenuto e il formato dei log raccolti per l'ALB Ingress.
{:shortdesc}

Per impostazione predefinita, il formato dei log Ingress è JSON e mostrano i campi log comuni. Tuttavia, puoi anche creare un formato di log personalizzato. Per scegliere quali componenti di log verranno inoltrati e come verranno organizzati nell'output del log:

1. Crea e apri una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Aggiungi una sezione <code>data</code>. Aggiungi il campo `log-format` e, facoltativamente, il campo `log-format-escape-json`.

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>Componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione della configurazione del formato di log</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Sostituisci <code>&lt;key&gt;</code> con il nome del componente di log e <code>&lt;log_variable&gt;</code> con una variabile per il componente di cui desideri raccogliere le voci di log. Puoi includere il testo e la punteggiatura che desideri nella voce di log, ad esempio le virgolette nei valori stringa e le virgole per separare i componenti di log. Ad esempio, se formatti il componente utilizzando <code>request: "$request"</code>, generi quanto segue in una voce del log: <code>request: "GET / HTTP/1.1"</code> . Per un elenco di tutte le variabili che puoi utilizzare, vedi l'<a href="http://nginx.org/en/docs/varindex.html">elenco di variabili Nginx</a>.<br><br>Per registrare un'intestazione aggiuntiva come ad esempio <em>x-custom-ID</em>, aggiungi la seguente coppia chiave-valore al contenuto del log personalizzato: <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>I trattini (<code>-</code>) vengono convertiti in caratteri di sottolineatura (<code>_</code>) e <code>$http_</code> deve essere aggiunto come prefisso al nome intestazione personalizzato.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Facoltativo: per impostazione predefinita, i log vengono generati in formato testo. Per generare i log in formato JSON, aggiungi il campo <code>log-format-escape-json</code> e utilizza il valore <code>true</code>.</td>
    </tr>
    </tbody></table>

    Ad esempio, il tuo formato di log potrebbe contenere le seguenti variabili:
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    Una voce di log basata su questo formato sarà simile al seguente esempio:
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    Per creare un formato di log personalizzato basato sul formato predefinito per i log ALB, modifica la seguente sezione come necessario e aggiungila alla tua mappa di configurazione:
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. Salva il file di configurazione.

5. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Per visualizzare i log ALB di Ingress, scegli tra due opzioni.
    * [Crea una configurazione di registrazione per il servizio Ingress](cs_health.html#logging) nel tuo cluster.
    * Controlla i log dalla CLI.
        1. Ottieni l'ID di un pod per un ALB.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. Apri i log relativi a tale pod ALB. Verifica che tutti i log seguano il formato aggiornato.
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Aumento della dimensione della zona di memoria condivisa per la raccolta di metriche Ingress
{: #vts_zone_size}

Le zone di memoria condivise sono definite in modo che i processi del nodo di lavoro possano condividere informazioni come cache, persistenza della sessione e limiti di velocità. Una zona di memoria condivisa, detta zona di stato del traffico host virtuale, viene impostata per raccogliere i dati delle metriche per un ALB.
{:shortdesc}

Nella mappa di configurazione Ingress `ibm-cloud-provider-ingress-cm`, il campo `vts-status-zone-size` imposta la dimensione della zona di memoria condivisa per la raccolta dei dati delle metriche. Per impostazione predefinita, `vts-status-zone-size` è impostato su `10m`. Se hai un ambiente di grandi dimensioni che richiede più memoria per la raccolta delle metriche, puoi sovrascrivere il valore predefinito invece di usare un valore più grande seguendo questa procedura.

1. Crea e apri una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifica il valore di `vts-status-zone-size` da `10m` a un valore più grande.

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
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
