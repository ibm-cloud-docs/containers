---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Annotazioni di Ingress
{: #ingress_annotation}

Per aggiungere funzionalità al tuo programma di bilanciamento del carico dell'applicazione, puoi specificare delle annotazioni sotto forma di metadati in una risorsa Ingress.
{: shortdesc}

Per informazioni generali sui servizi Ingress e su come iniziare ad usarli, vedi [Configurazione dell'accesso pubblico a un'applicazione utilizzando Ingress](cs_ingress.html#config).

<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Annotazioni generali</th>
 <th>Nome</th>
 <th>Descrizione</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">Servizi esterni</a></td>
 <td><code>proxy-external-service</code></td>
 <td>Aggiungi definizioni di percorso a servizi esterni, ad esempio il servizio ospitato in {{site.data.keyword.Bluemix_notm}}.</td>
 </tr>
 <tr>
 <td><a href="#alb-id">Instradamento del programma di bilanciamento del carico dell'applicazione privato</a></td>
 <td><code>ALB-ID</code></td>
 <td>Instrada le richieste in entrata alle tue applicazioni con un programma di bilanciamento del carico dell'applicazione privato.</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">Percorsi di riscrittura</a></td>
 <td><code>rewrite-path</code></td>
 <td>Instrada il traffico di rete in entrata a un percorso diverso su cui è in ascolto la tua applicazione di back-end.</td>
 </tr>
 <tr>
 <td><a href="#sticky-cookie-services">Affinità di sessione con i cookie</a></td>
 <td><code>sticky-cookie-services</code></td>
 <td>Instrada sempre il tuo traffico di rete in entrata allo stesso server upstream utilizzando un cookie permanente.</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">Porte TCP</a></td>
 <td><code>tcp-ports</code></td>
 <td>Accedi a un'applicazione tramite una porta TCP non standard.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Annotazioni di connessione</th>
 <th>Nome</th>
 <th>Descrizione</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">Timeout di lettura e connessione personalizzati</a></td>
  <td><code>proxy-connect-timeout</code></td>
  <td>Modifica il tempo in cui il programma di bilanciamento del carico dell'applicazione attende il collegamento e la lettura da un'applicazione di back-end prima che venga considerata non disponibile.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">Richieste di keepalive</a></td>
  <td><code>keepalive-requests</code></td>
  <td>Configura il numero massimo di richieste che possono essere offerte attraverso una connessione keepalive.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">Timeout di keepalive</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>Configura la durata in cui una connessione keepalive rimane aperta sul server.</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">Keepalive upstream</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>Configura il numero massimo di connessioni keepalive inattive per un server upstream.</td>
  </tr>
  </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Annotazioni buffer proxy</th>
 <th>Nome</th>
 <th>Descrizione</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">Buffer dei dati della risposta client</a></td>
 <td><code>proxy-buffering</code></td>
 <td>Disabilita il buffer di una risposta client al programma di bilanciamento del carico dell'applicazione mentre la invii al client.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffers">Buffer proxy</a></td>
 <td><code>proxy-buffers</code></td>
 <td>Imposta il numero e la dimensione dei buffer che legge una risposta per una singola connessione dal server proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffer-size">Dimensione buffer proxy</a></td>
 <td><code>proxy-buffer-size</code></td>
 <td>Imposta la dimensione del buffer che legge la prima parte della risposta ricevuta dal server proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-busy-buffers-size">Dimensione buffer occupati del proxy</a></td>
 <td><code>proxy-busy-buffers-size</code></td>
 <td>Imposta la dimensione dei buffer del proxy che può essere occupata.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>Annotazioni richiesta e risposta</th>
<th>Nome</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td><a href="#proxy-add-headers">Intestazione della risposta o della richiesta del client aggiuntivo</a></td>
<td><code>proxy-add-headers</code></td>
<td>Aggiungi le informazioni di intestazione a una richiesta client prima di inoltrare la richiesta alla tua applicazione di back-end o a una risposta client prima di inviare la risposta al client.</td>
</tr>
<tr>
<td><a href="#response-remove-headers">Rimozione intestazione risposta client</a></td>
<td><code>response-remove-headers</code></td>
<td>Rimuovi le informazioni sull'intestazione da una risposta client prima di inoltrarla al client.</td>
</tr>
<tr>
<td><a href="#client-max-body-size">Dimensione corpo richiesta client massima personalizzata</a></td>
<td><code>client-max-body-size</code></td>
<td>Modifica la dimensione del corpo della richiesta client che è consentito inviare al programma di bilanciamento del carico dell'applicazione.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>Annotazioni limite del servizio</th>
<th>Nome</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td><a href="#global-rate-limit">Limiti di velocità globali</a></td>
<td><code>global-rate-limit</code></td>
<td>Limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita per tutti i servizi.</td>
</tr>
<tr>
<td><a href="#service-rate-limit">Limiti di velocità del servizio</a></td>
<td><code>service-rate-limit</code></td>
<td>Limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita per servizi specifici.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>Annotazioni autenticazione HTTPS e TLS/SSL</th>
<th>Nome</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td><a href="#custom-port">Porte HTTP e HTTPS personalizzate</a></td>
<td><code>custom-port</code></td>
<td>Modifica le porte predefinite per il traffico di rete HTTP (porta 80) e HTTPS (porta 443).</td>
</tr>
<tr>
<td><a href="#redirect-to-https">Reindirizzamenti HTTP a HTTPS</a></td>
<td><code>redirect-to-https</code></td>
<td>Reindirizza le richieste HTTP nel tuo dominio a HTTPS.</td>
</tr>
<tr>
<td><a href="#mutual-auth">Autenticazione reciproca</a></td>
<td><code>mutual-auth</code></td>
<td>Configura l'autenticazione reciproca per il programma di bilanciamento del carico dell'applicazione.</td>
</tr>
<tr>
<td><a href="#ssl-services">Supporto dei servizi SSL</a></td>
<td><code>ssl-services</code></td>
<td>Consente il supporto dei servizi SSL per il bilanciamento del carico.</td>
</tr>
</tbody></table>



## Annotazioni generali
{: #general}

### Servizi esterni (proxy-external-service)
{: #proxy-external-service}

Aggiungi definizioni di percorso a servizi esterni, ad esempio i servizi ospitati in {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Aggiungi le definizioni di percorso ai servizi esterni. Utilizza questa annotazione solo quando la tua applicazione opera su un servizio esterno invece che su un servizio di backend. Quando utilizzi questa annotazione per creare una rotta al servizio esterno, sono supportate insieme solo le annotazioni `client-max-body-size`, `proxy-read-timeout`, `proxy-connect-timeout` e `proxy-buffering`. Tutte le altre annotazioni non sono supportate insieme a `proxy-external-service`.
</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: cafe-ingress
  annotations:
    ingress.bluemix.net/proxy-external-service: "path=&lt;mypath&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 80
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>path</code></td>
 <td>Sostituisci <code>&lt;<em>mypath</em>&gt;</code> con il percorso su cui è in ascolto il servizio esterno.</td>
 </tr>
 <tr>
 <td><code>external-svc</code></td>
 <td>Sostituisci <code>&lt;<em>external_service</em>&gt;</code> con il servizio esterno da richiamare. Ad esempio, <code>https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net</code>.</td>
 </tr>
 <tr>
 <td><code>host</code></td>
 <td>Sostituisci <code>&lt;<em>mydomain</em>&gt;</code> con il dominio host del servizio esterno.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Instradamento del programma di bilanciamento del carico dell'applicazione privato (ALB-ID)
{: #alb-id}

Instrada le richieste in entrata alle tue applicazioni con un programma di bilanciamento del carico dell'applicazione privato.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Scegli un programma di bilanciamento del carico dell'applicazione privato per instradare le richieste in entrata invece del pubblico.</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/ALB-ID: "&lt;private_ALB_ID&gt;"
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
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>L'ID del tuo programma di bilanciamento del carico dell'applicazione privato. Esegui <code>bx cs albs --cluster <my_cluster></code> per trovare l'ID del programma di bilanciamento del carico dell'applicazione privato.
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />



### Percorsi di riscrittura (rewrite-path)
{: #rewrite-path}

Instrada il traffico di rete in entrata su un percorso del dominio del programma di bilanciamento del carico dell'applicazione a un percorso diverso su cui è in ascolto la tua applicazione di back-end.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il tuo dominio del programma di bilanciamento del carico dell'applicazione Ingress instrada il traffico di rete in entrata su <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> alla tua applicazione. La tua applicazione è in ascolto su <code>/coffee</code>, invece di <code>/beans</code>. Per inoltrare il traffico di rete in entrata alla tua applicazione, aggiungi l'annotazione di riscrittura al file di configurazione della tua risorsa Ingress. L'annotazione di riscrittura garantisce che il traffico di rete in entrata su <code>/beans</code> venga inoltrato alla tua applicazione utilizzando il percorso <code>/coffee</code>. Quando includi più servizi, utilizza solo un punto e virgola (;) per
separarli.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;myservice1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;myservice2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /beans
        backend:
          serviceName: myservice1
          servicePort: 80
</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione.</td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>Sostituisci <code>&lt;<em>target_path</em>&gt;</code> con il percorso su cui è in ascolto la tua applicazione. Il traffico di rete in entrata nel dominio del programma di bilanciamento del carico dell'applicazione viene inoltrato al servizio Kubernetes utilizzando tale percorso. La maggior parte delle applicazioni non è
in ascolto su uno specifico percorso, ma utilizza il percorso root e una porta specifica. Nell'esempio precedente, il percorso di riscrittura è stato definito come <code>/coffee</code>.</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### Affinità di sessione con i cookie (sticky-cookie-services)
{: #sticky-cookie-services}

Utilizza l'annotazione cookie permanente per aggiungere l'affinità di sessione al tuo programma di bilanciamento del carico dell'applicazione e instradare sempre il traffico di rete in entrata allo stesso server upstream.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per l'alta disponibilità, alcune configurazioni di applicazione richiedono di distribuire più server upstream che gestiscono le richieste client in entrata. Quando un client si collega alla tua applicazione di back-end, puoi utilizzare l'affinità di sessione in modo che un client sia servito dallo stesso server upstream per la durata di una sessione o per il tempo necessario per completare un'attività. Puoi configurare il tuo programma di bilanciamento del carico dell'applicazione per garantire che l'affinità di sessione instradi sempre il traffico di rete in entrata allo stesso server upstream.

</br></br>
Ad ogni client che si collega alla tua applicazione di back-end viene assegnato uno dei server upstream disponibili dal programma di bilanciamento del carico dell'applicazione. Il programma di bilanciamento del carico dell'applicazione crea un cookie di sessione che viene memorizzato nell'applicazione del client e che viene incluso nelle informazioni di intestazione di ogni richiesta tra il programma di bilanciamento del carico dell'applicazione e il client. Le informazioni nel cookie garantiscono che tutte le richieste vengano gestite dallo stesso server upstream nella sessione.

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
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;myservice1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;myservice2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
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
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Descrizione dei componenti del file YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione.</td>
  </tr>
  <tr>
  <td><code>name</code></td>
  <td>Sostituisci <code>&lt;<em>cookie_name</em>&gt;</code> con il nome di un cookie permanente creato durante una sessione.</td>
  </tr>
  <tr>
  <td><code>expires</code></td>
  <td>Sostituisci <code>&lt;<em>expiration_time</em>&gt;</code> con il tempo in secondi (s), minuti (m) o ore (h) prima che scada il cookie permanente. Il tempo non è dipendente dall'attività utente. Dopo che il cookie è scaduto, viene eliminato dal browser web del client e non viene più inviato al programma di bilanciamento del carico dell'applicazione. Ad esempio, per impostare un orario di scadenza di 1 secondo, 1 minuto o 1 ora, immetti <code>1s</code>, <code>1m</code> o <code>1h</code>.</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>Sostituisci <code>&lt;<em>cookie_path</em>&gt;</code> con il percorso accodato al dominio secondario Ingress e che indica per quali domini e domini secondari il cookie viene inviato al programma di bilanciamento del carico dell'applicazione. Ad esempio, se il tuo dominio Ingress è <code>www.myingress.com</code> e desideri inviare il cookie in ogni richiesta client, devi impostare <code>path=/</code>. Se desideri inviare il cookie solo per <code>www.myingress.com/myapp</code> e a tutti i relativi domini secondari, devi impostare <code>path=/myapp</code>.</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>Sostituisci <code>&lt;<em>hash_algorithm</em>&gt;</code> con l'algoritmo hash che protegge le informazioni nel cookie. È
supportato solo <code>sha1</code>. SHA1 crea un riepilogo hash in base alle informazioni nel cookie e lo accoda ad esso. Il server può decrittografare le informazioni nel cookie e verificare l'integrità dei dati.</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />



### Porte TCP per i programmi di bilanciamento del carico dell'applicazione (tcp-ports)
{: #tcp-ports}

Accedi a un'applicazione tramite una porta TCP non standard.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Utilizza questa annotazione per un'applicazione che esegue un carico di lavoro di flussi TCP.

<p>**Nota**: il programma di bilanciamento del carico dell'applicazione funziona in modalità pass-through e inoltra il traffico alle applicazioni di back-end. In questo caso, la terminazione SSL non è supportata.</p>
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/tcp-ports: "serviceName=&lt;myservice&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes a cui accedere tramite una porta TCP non standard.</td>
  </tr>
  <tr>
  <td><code>ingressPort</code></td>
  <td>Sostituisci <code>&lt;<em>ingress_port</em>&gt;</code> con la porta TCP con cui vuoi accedere alla tua applicazione.</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Questo parametro è facoltativo. Se fornito, la porta viene sostituita con questo valore prima che il traffico venga inviato all'applicazione di back-end. Altrimenti, la porta rimane uguale alla porta Ingress.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Annotazioni di connessione
{: #connection}

### Timeout di lettura e connessione personalizzati (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Imposta timeout di lettura e connessione personalizzati per il programma di bilanciamento del carico dell'applicazione. Modifica il tempo in cui il programma di bilanciamento del carico dell'applicazione attende il collegamento e la lettura da un'applicazione di back-end prima che venga considerata non disponibile.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Quando una richiesta client viene inviata al programma di bilanciamento del carico dell'applicazione Ingress, viene aperto un collegamento all'applicazione di back-end dal programma di bilanciamento del carico dell'applicazione. Per impostazione predefinita, il programma di bilanciamento del carico dell'applicazione attende per 60 secondi di ricevere una risposta dall'applicazione di back-end. Se l'applicazione di back-end non risponde entro 60 secondi, la richiesta di connessione viene annullata e l'applicazione di back-end viene considerata non disponibile.

</br></br>
Una volta collegato all'applicazione di back-end, il programma di bilanciamento del carico dell'applicazione legge i dati di risposta dall'applicazione di back-end. Durante questa operazione di lettura, il programma di bilanciamento del carico dell'applicazione attende un massimo di 60 secondi tra due operazioni di lettura per ricevere i dati dall'applicazione di back-end. Se l'applicazione di back-end non invia i dati entro 60 secondi, il collegamento all'applicazione di back-end viene chiuso e l'applicazione non viene considerata disponibile.
</br></br>
Un timeout di connessione e timeout di lettura di 60 secondi è il timeout predefinito su un proxy e, in genere, non deve essere modificato.
</br></br>
Se la disponibilità della tua applicazione non è stazionaria o la tua applicazione è lenta a rispondere a causa di elevati carichi di lavoro, potresti voler aumentare i timeout di collegamento o di lettura. Tieni presente che aumentando il timeout si influenzano le prestazioni del programma di bilanciamento del carico dell'applicazione poiché il collegamento all'applicazione di back-end deve rimanere aperto finché non viene raggiunto il timeout.
</br></br>
D'altra parte, puoi ridurre il timeout per migliorare le prestazioni del programma di bilanciamento del carico dell'applicazione. Assicurati che la tua applicazione di back-end possa gestire le richieste nel timeout specificato, anche durante elevati carichi di lavoro.</dd>
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
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>Il numero di secondi da attendere per il collegamento all'applicazione di back-end, ad esempio <code>65s</code>. <strong>Nota:</strong> un timeout di collegamento non può superare 75 secondi.</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>Il numero di secondi da attendere prima che venga letta l'applicazione di back-end, ad esempio <code>65s</code>. <strong>Nota:</strong> un timeout di lettura non può superare 120 secondi.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Richieste di keepalive (keepalive-requests)
{: #keepalive-requests}

Configura il numero massimo di richieste che possono essere offerte attraverso una connessione keepalive.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Imposta il numero massimo di richieste che possono essere offerte attraverso una connessione keepalive.
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/keepalive-requests: "serviceName=&lt;myservice&gt; requests=&lt;max_requests&gt;"
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
        serviceName: &lt;myservice&gt;
        servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione. Questo parametro è facoltativo. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Se il parametro viene fornito, le richieste di keepalive vengono impostate per il servizio specificato. Se il parametro non viene fornito, le richieste di keepalive vengono impostate al livello server del <code>nginx.conf</code> per tutti i servizi per i quali non sono configurate le richieste di keepalive.</td>
</tr>
<tr>
<td><code>requests</code></td>
<td>Sostituisci <code>&lt;<em>max_requests</em>&gt;</code> con il numero massimo di richieste che possono essere offerte attraverso una connessione keepalive.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Timeout di keepalive (keepalive-timeout)
{: #keepalive-timeout}

Configura la durata in cui una connessione keepalive rimane aperta sul lato server.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Imposta la durata in cui una connessione keepalive rimane aperta sul server.
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;myservice&gt; timeout=&lt;time&gt;s"
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
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione. Questo parametro è facoltativo. Se il parametro viene fornito, il timeout di keepalive viene impostato per il servizio specificato. Se il parametro non viene fornito, il timeout di keepalive viene impostato al livello server del <code>nginx.conf</code> per tutti i servizi per i quali non è configurato il timeout di keepalive.</td>
 </tr>
 <tr>
 <td><code>timeout</code></td>
 <td>Sostituisci <code>&lt;<em>time</em>&gt;</code> con una quantità di tempo in secondi. Esempio: <code>timeout=20s</code>. Un valore zero disabilita le connessioni client keepalive.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Keepalive upstream (upstream-keepalive)
{: #upstream-keepalive}

Configura il numero massimo di connessioni keepalive inattive per un server upstream.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Modifica il numero massimo di connessioni keepalive inattive al server upstream di un determinato servizio. Il server upstream ha 64 connessioni keepalive inattive per impostazione predefinita.
</dd>


 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;myservice&gt; keepalive=&lt;max_connections&gt;"
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
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione.</td>
  </tr>
  <tr>
  <td><code>keepalive</code></td>
  <td>Sostituisci <code>&lt;<em>max_connections</em>&gt;</code> con il numero massimo di connessioni keepalive inattive a un server upstream. Il valore predefinito è <code>64</code>. Un valore <code>0</code> disabilita le connessioni keepalive upstream per il servizio specificato.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Annotazioni buffer proxy
{: #proxy-buffer}


### Buffer dei dati della risposta client (proxy-buffering)
{: #proxy-buffering}

Utilizza l'annotazione del buffer per disabilitare l'archiviazione dei dati della risposta nel programma di bilanciamento del carico dell'applicazione mentre i dati vengono inviati al client.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il programma di bilanciamento del carico dell'applicazione Ingress agisce come un proxy tra la tua applicazione di back-end e il browser web del client. Quando una risposta viene inviata dall'applicazione di back-end al client, i dati della risposta vengono memorizzati nel buffer nel programma di bilanciamento del carico dell'applicazione per impostazione predefinita. Il programma di bilanciamento del carico dell'applicazione trasmette tramite proxy la risposta client e avvia l'invio della risposta al client al ritmo del client. Dopo che sono stati ricevuti tutti i dati dalla risposta di back-end dal programma di bilanciamento del carico dell'applicazione, il collegamento all'applicazione di back-end viene chiuso. Il collegamento dal programma di bilanciamento del carico dell'applicazione al client rimane aperto finché il client non riceve tutti i dati. 

</br></br>
Se il buffer dei dati della risposta nel programma di bilanciamento del carico dell'applicazione è disabilitato, i dati vengono immediatamente inviati dal programma di bilanciamento del carico dell'applicazione al client. Il client deve poter gestire i dati in entrata al ritmo del programma di bilanciamento del carico dell'applicazione. Se il client è troppo lento, i dati potrebbero andare persi.
</br></br>
Il buffer dei dati della risposta nel programma di bilanciamento del carico dell'applicazione è abilitato per impostazione predefinita. </dd>
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

<br />



### Buffer proxy (proxy-buffers)
{: #proxy-buffers}

Configura il numero e la dimensione dei buffer del proxy per il programma di bilanciamento del carico dell'applicazione.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Imposta il numero e la dimensione dei buffer che legge una risposta per una singola connessione dal server proxy. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Ad esempio, se si specifica una configurazione come <code>serviceName=SERVICE number=2 size=1k</code>, al servizio viene applicato 1k. Se si specifica una configurazione come <code>number=2 size=1k</code>, 1k viene applicato a tutti i servizi nell'host Ingress.
</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-buffers: "serviceName=&lt;myservice&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
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
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome di un servizio a cui applicare proxy-buffers.</td>
 </tr>
 <tr>
 <td><code>number_of_buffers</code></td>
 <td>Sostituisci <code>&lt;<em>number_of_buffers</em>&gt;</code> con un numero, ad esempio <em>2</em>.</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>Sostituisci <code>&lt;<em>size</em>&gt;</code> con la dimensione di ciascun buffer in kilobyte (k o K), ad esempio <em>1K</em>.</td>
 </tr>
 </tbody>
 </table>
 </dd></dl>

<br />


### Dimensione buffer proxy (proxy-buffer-size)
{: #proxy-buffer-size}

Configura la dimensione del buffer del proxy che legge la prima parte della risposta.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Imposta la dimensione del buffer che legge la prima parte della risposta ricevuta dal server proxy. Questa parte della risposta di solito contiene una piccola intestazione di risposta. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Ad esempio, se si specifica una configurazione come <code>serviceName=SERVICE size=1k</code>, al servizio viene applicato 1k. Se si specifica una configurazione come <code>size=1k</code>, 1k viene applicato a tutti i servizi nell'host Ingress.
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;myservice&gt; size=&lt;size&gt;"
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
          servicePort: 8080
 </code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome di un servizio a cui applicare proxy-buffers-size.</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>Sostituisci <code>&lt;<em>size</em>&gt;</code> con la dimensione di ciascun buffer in kilobyte (k o K), ad esempio <em>1K</em>.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Dimensione buffer occupati del proxy (proxy-busy-buffers-size)
{: #proxy-busy-buffers-size}

Configura la dimensione dei buffer del proxy che può essere occupata.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Limita la dimensione di tutti i buffer che stanno inviando una risposta al client mentre la risposta non è stata ancora completamente letta. Nel frattempo, il resto dei buffer può leggere la risposta e, se necessario, eseguire il buffer di una parte della risposta in un file temporaneo. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Ad esempio, se si specifica una configurazione come <code>serviceName=SERVICE size=1k</code>, al servizio viene applicato 1k. Se si specifica una configurazione come <code>size=1k</code>, 1k viene applicato a tutti i servizi nell'host Ingress.
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: proxy-ingress
 annotations:
   ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
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
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome di un servizio a cui applicare proxy-busy-buffers-size.</td>
</tr>
<tr>
<td><code>size</code></td>
<td>Sostituisci <code>&lt;<em>size</em>&gt;</code> con la dimensione di ciascun buffer in kilobyte (k o K), ad esempio <em>1K</em>.</td>
</tr>
</tbody></table>

 </dd>
 </dl>

<br />



## Annotazioni richiesta e risposta
{: #request-response}


### Intestazione della risposta o della richiesta del client aggiuntivo (proxy-add-headers)
{: #proxy-add-headers}

Aggiungi ulteriori informazioni di intestazione a una richiesta client prima che venga inviata all'applicazione di back-end o a una risposta client prima che venga inviata al client.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il programma di bilanciamento del carico dell'applicazione Ingress agisce come un proxy tra l'applicazione client e la tua applicazione di back-end. Le richieste client inviate al programma di bilanciamento del carico dell'applicazione vengono elaborate (tramite proxy) e inserite in una nuova richiesta che viene quindi inviata dal programma di bilanciamento del carico dell'applicazione alla tua applicazione di back-end. Il passaggio tramite proxy di una richiesta rimuove le informazioni dell'intestazione http, come il nome utente, che era stato inizialmente inviato dal client. Se la tua applicazione di back-end richiede queste informazioni, puoi utilizzare l'annotazione <strong>ingress.bluemix.net/proxy-add-headers</strong> per aggiungere le informazioni sull'intestazione alla richiesta client prima che venga inoltrata dal programma di bilanciamento del carico dell'applicazione all'applicazione di back-end. 

</br></br>
Quando un'applicazione di back-end invia una risposta al client, viene trasmessa tramite proxy dal programma di bilanciamento del carico dell'applicazione e le intestazioni http vengono rimosse dalla risposta. L'applicazione web client potrebbe richiedere queste informazioni sull'intestazione per elaborare correttamente la risposta. Puoi utilizzare l'annotazione <strong>ingress.bluemix.net/response-add-headers</strong> per aggiungere le informazioni sull'intestazione alla risposta client prima che venga inoltrata dal programma di bilanciamento del carico dell'applicazione alla tua applicazione web client. </dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;myservice1&gt; {
      &lt;header1&gt; &lt;value1&gt;;
      &lt;header2&gt; &lt;value2&gt;;
      }
      serviceName=&lt;myservice2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;myservice1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;myservice2&gt; {
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
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>service_name</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione.</td>
  </tr>
  <tr>
  <td><code>&lt;header&gt;</code></td>
  <td>La chiave delle informazioni sull'intestazione da aggiungere alla richiesta o alla risposta client. </td>
  </tr>
  <tr>
  <td><code>&lt;value&gt;</code></td>
  <td>Il valore delle informazioni sull'intestazione da aggiungere alla richiesta o alla risposta client. </td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />



### Rimozione intestazione risposta client (response-remove-headers)
{: #response-remove-headers}

Rimuovi le informazioni di intestazione incluse nella risposta client dall'applicazione di back-end prima che la risposta venga inviata al client.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>Il programma di bilanciamento del carico dell'applicazione Ingress agisce come un proxy tra la tua applicazione di back-end e il browser web del client. Le risposte client che vengono inviate al programma di bilanciamento del carico dell'applicazione vengono elaborate (tramite proxy) e immesse in una nuova risposta che viene inviata dal programma di bilanciamento del carico dell'applicazione al browser web del client. Sebbene la trasmissione tramite proxy di una risposta rimuova le informazioni sull'intestazione http che erano state inizialmente inviate dall'applicazione di back-end, questo processo potrebbe non rimuovere tutte le intestazione specifiche dell'applicazione di back-end. Rimuovi le informazioni di intestazione da una risposta client prima che la risposta venga inoltrata dal programma di bilanciamento del carico dell'applicazione al browser web del client. </dd>
 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;myservice1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;myservice2&gt; {
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
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
       - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>service_name</code></td>
   <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio Kubernetes che hai creato per la tua applicazione.</td>
   </tr>
   <tr>
   <td><code>&lt;header&gt;</code></td>
   <td>La chiave dell'intestazione da rimuovere dalla risposta client. </td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


### Dimensione corpo richiesta client massima personalizzata (client-max-body-size)
{: #client-max-body-size}

Regola la dimensione massima del corpo che il client può inviare come parte di una richiesta.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per mantenere le prestazioni previste, la dimensione del corpo della richiesta client massima è impostata su 1 megabyte. Quando al programma di bilanciamento del carico dell'applicazione Ingress viene inviata una richiesta client con una dimensione del corpo superiore al limite e il client non consente la divisione dei dati, il programma di bilanciamento del carico dell'applicazione restituisce una risposta http 413 (Entità richiesta troppo grande) al client. Un collegamento tra il client e il programma di bilanciamento del carico dell'applicazione non è possibile finché la dimensione del corpo della richiesta non viene ridotta. Quando il client consente che i dati vengano suddivisi in parti più piccole, vengono divisi in pacchetti di 1 megabyte e inviati al programma di bilanciamento del carico dell'applicazione. 

</br></br>
Potresti voler ridurre la dimensione del corpo massima perché ti attendi richieste client con una dimensione del corpo maggiore di 1 megabyte. Ad esempio, vuoi che il tuo client sia in grado di caricare file di grandi dimensioni. Aumentando la dimensione del corpo della richiesta massima potresti influenzare le prestazioni del tuo programma di bilanciamento del carico dell'applicazione perché il collegamento al client deve rimanere aperto finché non viene ricevuta la richiesta.
</br></br>
<strong>Nota:</strong> alcuni browser web del client non possono visualizzare il messaggio di risposta HTTP 413 correttamente.</dd>
<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/client-max-body-size: "size=&lt;size&gt;"
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
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>La dimensione massima del corpo della risposta client. Ad esempio, per impostarla su 200 megabyte, definisci <code>200m</code>.  <strong>Nota:</strong> puoi impostare la dimensione su 0 per disabilitare il controllo della dimensione del corpo della richiesta client.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



## Annotazioni limite del servizio
{: #service-limit}


### Limiti di velocità globali
{: #global-rate-limit}

Limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita per tutti i servizi.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Per tutti i servizi, limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita provenienti da un singolo indirizzo IP per tutti i percorsi dei back-end selezionati.
</dd>


 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/global-rate-limit: "key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
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
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>key</code></td>
  <td>Per impostare un limite globale per le richieste in entrata in base alla posizione o al servizio, utilizza `key=location`. Per impostare un limite globale per le richieste in entrata in base all'intestazione, utilizza `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Sostituisci <code>&lt;<em>rate</em>&gt;</code> con la velocità di elaborazione. Immetti un valore come una velocità al secondo (r/s) o al minuto (r/m). Esempio: <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Sostituisci <code>&lt;<em>conn</em>&gt;</code> con il numero di connessioni.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

<br />



### Limiti di velocità del servizio (service-rate-limit)
{: #service-rate-limit}

Limita la velocità di elaborazione delle richieste e il numero di connessioni per i servizi specifici.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per servizi specifici, limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita provenienti da un singolo indirizzo IP per tutti i percorsi dei back-end selezionati.
</dd>


 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;myservice&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
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
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio per cui vuoi limitare la velocità di elaborazione.</li>
  </tr>
  <tr>
  <td><code>key</code></td>
  <td>Per impostare un limite globale per le richieste in entrata in base alla posizione o al servizio, utilizza `key=location`. Per impostare un limite globale per le richieste in entrata in base all'intestazione, utilizza `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Sostituisci <code>&lt;<em>rate</em>&gt;</code> con la velocità di elaborazione. Per definire una velocità al secondo, utilizza r/s: <code>10r/s</code>. Per definire una velocità al minuto, utilizza r/m: <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Sostituisci <code>&lt;<em>conn</em>&gt;</code> con il numero di connessioni.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />



## Annotazioni autenticazione HTTPS e TLS/SSL
{: #https-auth}


### Porte HTTP e HTTPS personalizzate (custom-port)
{: #custom-port}

Modifica le porte predefinite per il traffico di rete HTTP (porta 80) e HTTPS (porta 443).
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per impostazione predefinita, il programma di bilanciamento del carico dell'applicazione Ingress è configurato per essere in ascolto sul traffico di rete HTTP in entrata sulla porta 80 e per HTTPS sulla porta 443. Puoi modificare le porte predefinite per aggiungere sicurezza al tuo dominio del programma di bilanciamento del carico dell'applicazione o per abilitare solo una porta HTTPS.
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
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>Immetti <strong>http</strong> o <strong>https</strong> per modificare la porta predefinita per il traffico di rete HTTP o HTTPS in entrata. </td>
 </tr>
 <tr>
 <td><code>&lt; port&gt;</code></td>
 <td>Immetti il numero di porta che desideri utilizzare per il traffico di rete HTTP o HTTPS in entrata. <p><strong>Nota:</strong> quando viene specificata una porta personalizzata per HTTP o HTTPS, le porte predefinite non sono più valide. Ad esempio, per modificare la porta predefinita per HTTPS in 8443, ma utilizzare la porta predefinita per HTTP, devi impostare le porte personalizzate per entrambe: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Utilizzo</dt>
 <dd><ol><li>Controlla le porte aperte del tuo programma di bilanciamento del carico dell'applicazione.
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



### Reindirizzamenti HTTP a HTTPS (redirect-to-https)
{: #redirect-to-https}

Converti le richieste client http non sicure in https.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Configura il tuo programma di bilanciamento del carico dell'applicazione Ingress per proteggere il tuo dominio con il certificato TLS fornito da IBM o con il tuo certificato TLS personalizzato. Alcuni utenti potrebbero tentare di accedere alle tue applicazioni utilizzando una richiesta http non sicura al tuo dominio del programma di bilanciamento del carico dell'applicazione, ad esempio <code>http://www.myingress.com</code>, invece di utilizzare <code>https</code>. Puoi utilizzare l'annotazione di reindirizzamento per convertire sempre le richieste HTTP non sicure in HTTPS. Se non utilizzi questa annotazione, le richieste HTTP non sicure non vengono convertite in richieste HTTPS per impostazione predefinita e potrebbero esporre al pubblico informazioni riservate non crittografate. 

</br></br>
Il reindirizzamento delle richieste HTTP in HTTPS è disabilitato per impostazione predefinita.</dd>

<dt>YAML risorsa Ingress di esempio</dt>
<dd>
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

<br />



### Autenticazione reciproca (mutual-auth)
{: #mutual-auth}

Configura l'autenticazione reciproca per il programma di bilanciamento del carico dell'applicazione.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Configura l'autenticazione reciproca per il programma di bilanciamento del carico dell'applicazione Ingress. Il client autentica il server e anche il server autentica il client utilizzando i certificati. L'autenticazione reciproca è nota anche come autenticazione basata su certificato o autenticazione bidirezionale.
</dd>

<dt>Prerequisiti</dt>
<dd>
<ul>
<li>[Devi disporre di un segreto valido che contenga l'autorità di certificazione (CA) richiesta](cs_app.html#secrets). Per l'autenticazione reciproca sono necessari anche <code>client.key</code> e <code>client.crt</code>.</li>
<li>Per abilitare l'autenticazione reciproca su una porta diversa da 443, [configura il programma di bilanciamento del carico per aprire la porta valida](cs_ingress.html#opening_ingress_ports).</li>
</ul>
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: myingress
annotations:
  ingress.bluemix.net/mutual-auth: "secretName=&lt;mysecret&gt; port=&lt;port&gt; serviceName=&lt;servicename1&gt;,&lt;servicename2&gt;"
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
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>Sostituisci <code>&lt;<em>mysecret</em>&gt;</code> con un nome per la risorsa del segreto.</td>
</tr>
<tr>
<td><code>&lt; port&gt;</code></td>
<td>Il numero di porta del programma di bilanciamento del carico dell'applicazione.</td>
</tr>
<tr>
<td><code>&lt;serviceName&gt;</code></td>
<td>Il nome di una o più risorse Ingress. Questo parametro è facoltativo.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Supporto dei servizi SSL (ssl-services)
{: #ssl-services}

Consenti le richieste HTTPS e crittografa il traffico alle tue applicazioni upstream.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Codifica il traffico verso le tue applicazioni upstream che richiedono HTTPS con i programmi di bilanciamento del carico dell'applicazione. 

**Facoltativo**: a questa annotazione, puoi aggiungere [l'autenticazione unidirezionale o l'autenticazione reciproca](#ssl-services-auth).
</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: "ssl-service=&lt;myservice1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;myservice2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio che rappresenta la tua applicazione. Per questa applicazione, il traffico viene crittografato dal programma di bilanciamento del carico dell'applicazione. </td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Sostituisci <code>&lt;<em>service-ssl-secret</em>&gt;</code> con il segreto per il servizio. Questo parametro è facoltativo. Se il parametro viene fornito, il valore deve contenere la chiave e il certificato che la tua applicazione si aspetta dal client.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


#### Supporto dei servizi SSL con l'autenticazione
{: #ssl-services-auth}

Consenti le richieste HTTPS e crittografa il traffico alle tue applicazioni upstream con l'autorizzazione unidirezionale o reciproca per garantire ulteriore sicurezza.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Configura l'autenticazione reciproca per le applicazioni di bilanciamento del carico che richiedono HTTPS con i controller Ingress.

**Nota**: prima di iniziare, [converti il certificato e la chiave in base-64 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.base64encode.org/).

</dd>


<dt>YAML risorsa Ingress di esempio</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: |
      ssl-service=&lt;myservice1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;myservice2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444
          </code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Sostituisci <code>&lt;<em>myservice</em>&gt;</code> con il nome del servizio che rappresenta la tua applicazione. Per questa applicazione, il traffico viene crittografato dal programma di bilanciamento del carico dell'applicazione. </td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Sostituisci <code>&lt;<em>service-ssl-secret</em>&gt;</code> con il segreto per il servizio. Questo parametro è facoltativo. Se il parametro viene fornito, il valore deve contenere la chiave e il certificato che la tua applicazione si aspetta dal client.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />



