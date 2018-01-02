---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-14"

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

Per aggiungere funzionalità al tuo controller Ingress, puoi specificare delle annotazioni sotto forma di metadati in una risorsa Ingress.
{: shortdesc}

Per informazioni generali sui servizi Ingress e su come iniziare ad usarli, vedi [Configurazione dell'accesso pubblico a un'applicazione utilizzando il controller Ingress](cs_apps.html#cs_apps_public_ingress).


|Annotazione supportata|Descrizione|
|--------------------|-----------|
|[Intestazione della risposta o della richiesta del client aggiuntivo](#proxy-add-headers)|Aggiungi le informazioni di intestazione a una richiesta client prima di inoltrare la richiesta alla tua applicazione di back-end o a una risposta client prima di inviare la risposta al client.|
|[Buffer dei dati della risposta client](#proxy-buffering)|Disabilita il buffer di una risposta client al controller Ingress mentre la invii al client.|
|[Rimozione intestazione risposta client](#response-remove-headers)|Rimuovi le informazioni sull'intestazione da una risposta client prima di inoltrarla al client.|
|[Timeout di lettura e connessione personalizzati](#proxy-connect-timeout)|Modifica il tempo in cui il controller Ingress attende il collegamento e la lettura da un'applicazione di back-end prima che venga considerata non disponibile.|
|[Porte HTTP e HTTPS personalizzate](#custom-port)|Modifica le porte predefinite per il traffico di rete HTTP e HTTPS.|
|[Dimensione corpo richiesta client massima personalizzata](#client-max-body-size)|Modifica la dimensione del corpo della richiesta client che è consentito inviare al controller Ingress.|
|[Servizi esterni](#proxy-external-service)|Aggiunge la definizione di percorsi a servizi esterni, ad esempio un servizio ospitato in {{site.data.keyword.Bluemix_notm}}.|
|[Limiti di velocità globali](#global-rate-limit)|Per tutti i servizi, limita la velocità di elaborazione delle richieste e le connessioni per una chiave definita.|
|[Reindirizzamenti HTTP a HTTPS](#redirect-to-https)|Reindirizza le richieste HTTP nel tuo dominio a HTTPS.|
|[Richieste di keepalive](#keepalive-requests)|Configura il numero massimo di richieste che possono essere offerte attraverso una connessione keepalive.|
|[Timeout di keepalive](#keepalive-timeout)|Configura la durata in cui una connessione keepalive rimane aperta sul server.|
|[Autenticazione reciproca](#mutual-auth)|Configura l'autenticazione reciproca per il controller Ingress.|
|[Buffer proxy](#proxy-buffers)|Imposta il numero e la dimensione dei buffer utilizzati per leggere una risposta per una singola connessione dal server proxy.|
|[Dimensione buffer occupati del proxy](#proxy-busy-buffers-size)|Limita la dimensione totale dei buffer che possono essere occupati a inviare una risposta al client mentre la risposta non è stata ancora completamente letta.|
|[Dimensione buffer proxy](#proxy-buffer-size)|Imposta la dimensione del buffer utilizzato per leggere la prima parte della risposta ricevuta dal server proxy.|
|[Percorsi di riscrittura](#rewrite-path)|Instradare il traffico di rete in entrata a un percorso diverso su cui è in ascolto la tua applicazione di back-end.|
|[Affinità di sessione con i cookie](#sticky-cookie-services)|Instrada sempre il tuo traffico di rete in entrata allo stesso server upstream utilizzando un cookie permanente.|
|[Limiti di velocità del servizio](#service-rate-limit)|Per servizi specifici, limita la velocità di elaborazione delle richieste e le connessioni per una chiave definita.|
|[Supporto dei servizi SSL](#ssl-services)|Consente il supporto dei servizi SSL per il bilanciamento del carico.|
|[Porte TCP](#tcp-ports)|Accedi a un'applicazione tramite una porta TCP non standard.|
|[Keepalive upstream](#upstream-keepalive)|Configura il numero massimo di connessioni keepalive inattive per un server upstream.|






## Intestazione della risposta o della richiesta del client aggiuntivo (proxy-add-headers)
{: #proxy-add-headers}

Aggiungi ulteriori informazioni di intestazione a una richiesta client prima che venga inviata all'applicazione di back-end o a una risposta client prima che venga inviata al client.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il controller Ingress agisce come un proxy tra l'applicazione client e l'applicazione di back-end. Le richieste client inviate al controller Ingress vengono elaborate (tramite proxy) e inserite in una nuova richiesta che viene quindi inviata dal controller Ingress all'applicazione di back-end. Il passaggio tramite proxy di una richiesta rimuove le informazioni dell'intestazione http, come il nome utente, che era stato inizialmente inviato dal client. Se l'applicazione di back-end richiede queste informazioni, puoi utilizzare l'annotazione <strong>ingress.bluemix.net/proxy-add-headers</strong> per aggiungere le informazioni sull'intestazione alla richiesta client prima che venga inoltrata dal controller Ingress alla tua applicazione di back-end.

</br></br>
Quando un'applicazione di back-end invia una risposta al client, viene trasmessa tramite proxy e il controller Ingress e le intestazioni http vengono rimossi dalla risposta. L'applicazione web client potrebbe richiedere queste informazioni sull'intestazione per elaborare correttamente la risposta. Puoi utilizzare l'annotazione <strong>ingress.bluemix.net/response-add-headers</strong> per aggiungere le informazioni sull'intestazione alla risposta client prima che venga inoltrata dal controller Ingress alla tua applicazione web client.</dd>
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
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: il nome del servizio Kubernetes che hai creato
per la tua applicazione.</li>
  <li><code><em>&lt;header&gt;</em></code>: la chiave delle informazioni sull'intestazione da aggiungere alla richiesta o alla risposta client.</li>
  <li><code><em>&lt;value&gt;</em></code>: il valore delle informazioni sull'intestazione da aggiungere alla richiesta o alla risposta client.</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## Buffer dei dati della risposta client (proxy-buffering)
 {: #proxy-buffering}

 Utilizza l'annotazione del buffer per disabilitare l'archiviazione dei dati della risposta nel controller Ingress mentre i dati vengono inviati al client.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>Il controller Ingress agisce come un proxy tra la tua applicazione di back-end e il browser web del client. Quando una risposta viene inviata dall'applicazione di back-end al client, i dati della risposta vengono memorizzati nel buffer nel controller Ingress per impostazione predefinita. Il controller Ingress trasmette tramite proxy la risposta client e avvia l'invio della risposta al client al ritmo del client. Dopo che sono stati ricevuti tutti i dati dalla risposta di backend dal controller Ingress, il collegamento all'applicazione di back-end viene chiuso. Il collegamento dal controller Ingress al client rimane aperto finché il client non ha ricevuto tutti i dati.

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

<br />


 ## Rimozione intestazione risposta client (response-remove-headers)
 {: #response-remove-headers}

Rimuovi le informazioni di intestazione incluse nella risposta client dall'applicazione di back-end prima che la risposta venga inviata al client.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>Il controller Ingress agisce come un proxy tra la tua applicazione di back-end e il browser web del client. Le risposte client che vengono inviate al controller Ingress vengono elaborate (tramite proxy) e immesse in una nuova risposta che viene inviata dal controller Ingress al browser web del client. Sebbene la trasmissione tramite proxy di una risposta rimuova le informazioni sull'intestazione http che erano state inizialmente inviate dall'applicazione di back-end, questo processo potrebbe non rimuovere tutte le intestazione specifiche dell'applicazione di back-end. Rimuovi le informazioni di intestazione da una risposta client prima che la risposta venga inoltrata dal controller Ingress al browser web del client.</dd>
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
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Sostituisci i seguenti valori:<ul>
   <li><code><em>&lt;service_name&gt;</em></code>: il nome del servizio Kubernetes che hai creato
per la tua applicazione.</li>
   <li><code><em>&lt;header&gt;</em></code>: la chiave dell'intestazione da rimuovere dalla risposta client.</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## Timeout di lettura e connessione personalizzati (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Imposta timeout di lettura e connessione personalizzati per il controller Ingress. Regola il tempo di attesa del controller Ingress durante la connessione e la lettura dall'applicazione di back-end prima che questa venga considerata non disponibile.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Quando una richiesta client viene inviata al controller Ingress, viene aperto un collegamento all'applicazione di back-end dal controller Ingress. Per impostazione predefinita, il controller Ingress attende per 60 secondi di ricevere una risposta dall'applicazione di back-end. Se l'applicazione di back-end non risponde entro 60 secondi, la richiesta di connessione viene annullata e l'applicazione di back-end viene considerata non disponibile.

</br></br>
Una volta collegato all'applicazione di back-end, il controller Ingress legge i dati di risposta dall'applicazione di back-end. Durante questa operazione di lettura, il controller Ingress attende un massimo di 60 secondi tra due operazioni di lettura per ricevere i dati dall'applicazione di back-end. Se l'applicazione di back-end non invia i dati entro 60 secondi, il collegamento all'applicazione di back-end viene chiuso e l'applicazione non viene considerata disponibile.
</br></br>
Un timeout di connessione e timeout di lettura di 60 secondi è il timeout predefinito su un proxy e, in genere, non deve essere modificato.
</br></br>
Se la disponibilità della tua applicazione non è stazionaria o la tua applicazione è lenta a rispondere a causa di elevati carichi di lavoro, potresti voler aumentare i timeout di collegamento o di lettura. Tieni presente che aumentando il timeout si influenzano le prestazioni del controller Ingress poiché il collegamento all'applicazione di back-end deve rimanere aperto finché non viene raggiunto il timeout.
</br></br>
D'altra parte, puoi ridurre il timeout per migliorare le prestazioni del controller Ingress. Assicurati che la tua applicazione di back-end possa gestire le richieste nel timeout specificato, anche durante elevati carichi di lavoro.</dd>
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
 <td><code>annotations</code></td>
 <td>Sostituisci i seguenti valori:<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: immetti il numero di secondi da attendere per il collegamento all'applicazione di back-end, ad esempio <strong>65s</strong>.

 </br></br>
 <strong>Nota:</strong> un timeout di collegamento non può superare 75 secondi.</li><li><code><em>&lt;read_timeout&gt;</em></code>: immetti il numero di secondi da attendere prima che venga letta l'applicazione di back-end, ad esempio <strong>65s</strong>.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## Porte HTTP e HTTPS personalizzate (custom-port)
{: #custom-port}

Modifica le porte predefinite per il traffico di rete HTTP (porta 80) e HTTPS (porta 443).
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per impostazione predefinita, il controller Ingress è configurato per essere in ascolto sul traffico di rete HTTP in entrata sulla porta 80 e per HTTPS sulla porta 443. Puoi modificare le porte predefinite per aggiungere sicurezza al dominio del tuo controller Ingress o per abilitare solo una porta HTTPS.
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
 <td><code>annotations</code></td>
 <td>Sostituisci i seguenti valori:<ul>
 <li><code><em>&lt;protocol&gt;</em></code>: immetti <strong>http</strong> o <strong>https</strong> per modificare la porta predefinita per il traffico di rete HTTP o HTTPS in entrata.</li>
 <li><code><em>&lt;port&gt;</em></code>: immetti il numero di porta che desideri utilizzare per il traffico di rete HTTP o HTTPS in entrata.</li>
 </ul>
 <p><strong>Nota:</strong> quando viene specificata una porta personalizzata per HTTP o HTTPS, le porte predefinite non sono più valide. Ad esempio, per modificare la porta predefinita per HTTPS in 8443, ma utilizzare la porta predefinita per HTTP, devi impostare le porte personalizzate per entrambe: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Utilizzo</dt>
 <dd><ol><li>Controlla le porte aperte del tuo controller Ingress. **Nota: l'indirizzo IP deve essere un indirizzo IP del documento generico. Deve anche collegarsi alla cli kubectl di destinazione? Forse no.**
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


## Dimensione corpo richiesta client massima personalizzata (client-max-body-size)
{: #client-max-body-size}

Regola la dimensione massima del corpo che il client può inviare come parte di una richiesta.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per mantenere le prestazioni previste, la dimensione del corpo della richiesta client massima è impostata su 1 megabyte. Quando al controller Ingress viene inviata una richiesta client con una dimensione del corpo superiore al limite e il client non consente la divisione dei dati, il controller Ingress restituisce una risposta http 413 (Entità richiesta troppo grande) al client. Un collegamento tra il client e il controller Ingress non è possibile finché la dimensione del corpo della richiesta non viene ridotta. Quando il client consente che i dati vengano suddivisi in parti più piccole, vengono divisi in pacchetti di 1 megabyte e inviati al controller Ingress.

</br></br>
Potresti voler ridurre la dimensione del corpo massima perché ti attendi richieste client con una dimensione del corpo maggiore di 1 megabyte. Ad esempio, vuoi che il tuo client sia in grado di caricare file di grandi dimensioni. Aumentando la dimensione del corpo della richiesta massima potresti influenzare le prestazioni del tuo controller Ingress perché il collegamento al client deve rimanere aperto finché Non viene ricevuta la richiesta.
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
 <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Sostituisci il seguente valore:<ul>
 <li><code><em>&lt;size&gt;</em></code>: immetti la dimensione massima del corpo della risposta client. Ad esempio, per impostarla su 200 megabyte, definisci <strong>200m</strong>.

 </br></br>
 <strong>Nota:</strong> puoi impostare la dimensione su 0 per disabilitare il controllo della dimensione del corpo della richiesta client.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<torna qui>

## Servizi esterni (proxy-external-service)
{: #proxy-external-service}
Aggiungi definizioni di percorso a servizi esterni, ad esempio i servizi ospitati in {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Aggiungi le definizioni di percorso ai servizi esterni. Questa annotazione è per casi speciali perché non è valida per un servizio di back-end e funziona su un servizio esterno. Le annotazioni diverse da client-max-body-size, proxy-read-timeout, proxy-connect-timeout, proxy-buffering non sono supportate con la rotta di un servizio esterno.
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
    ingress.bluemix.net/proxy-external-service: "path=&lt;path&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - hosts:
    - &lt;mydomain&gt;
    secretName: mysecret
  rules:
  - host: &lt;mydomain&gt;
    http:
      paths:
      - path: &lt;path&gt;
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
 <td><code>annotations</code></td>
 <td>Sostituisci il seguente valore:
 <ul>
 <li><code><em>&lt;external_service&gt;</em></code>: immetti il servizi esterno da richiamare. Ad esempio, https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net.</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## Limiti di velocità globali
{: #global-rate-limit}

Per tutti i servizi, limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita provenienti da un singolo indirizzo IP per tutti gli host in un'associazione Ingress.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Per impostare il limite, le zone sono definite da `ngx_http_limit_conn_module` e `ngx_http_limit_req_module`. Queste zone vengono applicate nei blocchi del server che corrispondono a ciascun host in un'associazione Ingress.
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;key&gt;</em></code>: per impostare un limite globale per le richieste in entrata in base alla posizione o al servizio, utilizza `key=location`. Per impostare un limite globale per le richieste in entrata in base all'intestazione, utilizza `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: la velocità.</li>
  <li><code><em>&lt;conn&gt;</em></code>: il numero di connessioni.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## Reindirizzamenti HTTP a HTTPS (redirect-to-https)
 {: #redirect-to-https}

 Converti le richieste client http non sicure in https.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>Configura il tuo controller Ingress per proteggere il tuo dominio sicuro con il certificato TLS fornito da IBM o con il certificato TLS personalizzato. Alcuni utenti potrebbero tentare di accedere alle tue applicazioni utilizzando una richiesta http non sicura al tuo dominio del controller Ingress, ad esempio <code>http://www.myingress.com</code>, invece di utilizzare <code>https</code>. Puoi utilizzare l'annotazione di reindirizzamento per convertire sempre le richieste http non sicure in https. Se non utilizzi questa annotazione, le richieste HTTP non sicure non vengono convertite in richieste https per impostazione predefinita e potrebbero esporre al pubblico informazioni riservate non crittografate.

 </br></br>
 Il reindirizzamento delle richieste http in https è disabilitato per impostazione predefinita.</dd>
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




 <br />

 
 ## Richieste di keepalive (keepalive-requests)
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
    ingress.bluemix.net/keepalive-requests: "serviceName=&lt;service_name&gt; requests=&lt;max_requests&gt;"
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: sostituisci <em>&lt;service_name&gt;</em> con il nome del servizio Kubernetes che hai creato per la tua applicazione. Questo parametro è facoltativo. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Se il parametro viene fornito, le richieste di keepalive vengono impostate per il servizio specificato. Se il parametro non viene fornito, le richieste di keepalive vengono impostate al livello server del <code>nginx.conf</code> per tutti i servizi per i quali non sono configurate le richieste di keepalive.</li>
  <li><code><em>&lt;requests&gt;</em></code>: sostituisci <em>&lt;max_requests&gt;</em> con il numero massimo di richieste che possono essere offerte attraverso una connessione keepalive.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Timeout di keepalive (keepalive-timeout)
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
     ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;service_name&gt; timeout=&lt;time&gt;s"
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
   <td><code>annotations</code></td>
   <td>Sostituisci i seguenti valori:<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>: sostituisci <em>&lt;service_name&gt;</em> con il nome del servizio Kubernetes che hai creato per la tua applicazione. Questo parametro è facoltativo. Se il parametro viene fornito, il timeout di keepalive viene impostato per il servizio specificato. Se il parametro non viene fornito, il timeout di keepalive viene impostato al livello server del <code>nginx.conf</code> per tutti i servizi per i quali non è configurato il timeout di keepalive.</li>
   <li><code><em>&lt;timeout&gt;</em></code>: sostituisci <em>&lt;time&gt;</em> con una quantità di tempo in secondi. Esempio: <code><em>timeout=20s</em></code>. Un valore zero disabilita le connessioni client keepalive.</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## Autenticazione reciproca (mutual-auth)
 {: #mutual-auth}

 Configura l'autenticazione reciproca per il controller Ingress.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>
 Configura l'autenticazione reciproca per il controller Ingress. Il client autentica il server e anche il server autentica il client utilizzando i certificati. L'autenticazione reciproca è nota anche come autenticazione basata su certificato o autenticazione bidirezionale.
 </dd>

 <dt>Prerequisiti</dt>
 <dd>
 <ul>
 <li>[Devi disporre di un segreto valido che contenga l'autorità di certificazione (CA) richiesta](cs_apps.html#secrets). Per l'autenticazione reciproca sono necessari anche <code>client.key</code> e <code>client.crt</code>.</li>
 <li>Per abilitare l'autenticazione reciproca su una porta diversa da 443, [configura il programma di bilanciamento del carico per aprire la porta valida](cs_apps.html#opening_ingress_ports).</li>
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
    ingress.bluemix.net/mutual-auth: "port=&lt;port&gt; secretName=&lt;secretName&gt; serviceName=&lt;service1&gt;,&lt;service2&gt;"
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: il nome di una o più risorse Ingress. Questo parametro è facoltativo. </li>
  <li><code><em>&lt;secretName&gt;</em></code>: sostituisci <em>&lt;secret_name&gt;</em> con un nome per la risorsa del segreto.</li>
  <li><code><em>&lt;port&gt;</em></code>: immetti il numero di porta.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Buffer proxy (proxy-buffers)
 {: #proxy-buffers}
 
 Configura i buffer proxy per il controller Ingress.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>
 Imposta il numero e la dimensione dei buffer utilizzati per leggere una risposta per una singola connessione dal server proxy. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Ad esempio, se si specifica una configurazione come <code>serviceName=SERVICE number=2 size=1k</code>, al servizio viene applicato 1k. Se si specifica una configurazione come <code>number=2 size=1k</code>, 1k viene applicato a tutti i servizi nell'host Ingress.
 </dd>
 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffers: "serviceName=&lt;service_name&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:
  <ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: sostituisci <em>&lt;serviceName&gt;</em> con un nome per il servizio a cui applicare proxy-buffers. </li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code>: sostituisci <em>&lt;number_of_buffers&gt;</em> con un numero, ad esempio <em>2</em>.</li>
  <li><code><em>&lt;size&gt;</em></code>: immetti la dimensione di ciascun buffer in kilobyte (k o K), ad esempio <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## Dimensione buffer occupati del proxy (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 Configura la dimensione dei buffer occupati del proxy per il controller Ingress.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>
 Quando il buffering delle risposte dal server proxy è abilitato, limita la dimensione totale dei buffer che possono essere occupati a inviare una risposta al client mentre la risposta non è stata ancora completamente letta. Nel frattempo, il resto dei buffer può essere utilizzato per leggere la risposta e, se necessario, eseguire il buffer di una parte della risposta in un file temporaneo. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Ad esempio, se si specifica una configurazione come <code>serviceName=SERVICE size=1k</code>, al servizio viene applicato 1k. Se si specifica una configurazione come <code>size=1k</code>, 1k viene applicato a tutti i servizi nell'host Ingress.
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: sostituisci <em>&lt;serviceName&gt;</em> con un nome del servizio a cui applicare proxy-busy-buffers-size.</li>
  <li><code><em>&lt;size&gt;</em></code>: immetti la dimensione di ciascun buffer in kilobyte (k o K), ad esempio <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Dimensione buffer proxy (proxy-buffer-size)
 {: #proxy-buffer-size}

 Configura la dimensione del buffer proxy per il controller Ingress.
 {:shortdesc}

 <dl>
 <dt>Descrizione</dt>
 <dd>
 Imposta la dimensione del buffer utilizzato per leggere la prima parte della risposta ricevuta dal server proxy. Questa parte della risposta di solito contiene una piccola intestazione di risposta. La configurazione viene applicata a tutti i servizi nell'host Ingress, a meno che non venga specificato un servizio. Ad esempio, se si specifica una configurazione come <code>serviceName=SERVICE size=1k</code>, al servizio viene applicato 1k. Se si specifica una configurazione come <code>size=1k</code>, 1k viene applicato a tutti i servizi nell'host Ingress.
 </dd>


 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: sostituisci <em>&lt;serviceName&gt;</em> con un nome del servizio a cui applicare proxy-busy-buffers-size.</li>
  <li><code><em>&lt;size&gt;</em></code>: immetti la dimensione di ciascun buffer in kilobyte (k o K), ad esempio <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## Percorsi di riscrittura (rewrite-path)
{: #rewrite-path}

Instrada il traffico di rete in entrata su un percorso di dominio del controller Ingress a un percorso diverso su cui è in ascolto la tua applicazione di back-end.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Il tuo dominio del controller Ingress instrada il traffico di rete in entrata su <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> alla tua applicazione. La tua applicazione è in ascolto su <code>/coffee</code>, invece di <code>/beans</code>. Per inoltrare il traffico di rete in entrata alla tua applicazione, aggiungi l'annotazione di riscrittura al file di configurazione della tua risorsa Ingress. L'annotazione di riscrittura garantisce che il traffico di rete in entrata su <code>/beans</code> venga inoltrato alla tua applicazione utilizzando il percorso <code>/coffee</code>. Quando includi più servizi, utilizza solo un punto e virgola (;) per
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
    secretName: &lt;mytlssecret&gt;
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
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
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

<br />


## Limiti di velocità del servizio (service-rate-limit)
{: #service-rate-limit}

Per servizi specifici, limita la velocità di elaborazione delle richieste e il numero di connessioni per una chiave definita provenienti da un singolo indirizzo IP per tutti i percorsi dei back-end selezionati.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Per impostare il limite, vengono applicate le zone definite da `ngx_http_limit_conn_module` e da `ngx_http_limit_req_module` in tutti i blocchi di posizione che corrispondono a tutti i servizi specificati nell'annotazione dell'associazione Ingress.</dd>


 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;service_name&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: il nome della risorsa Ingress.</li>
  <li><code><em>&lt;key&gt;</em></code>: per impostare un limite globale per le richieste in entrata in base alla posizione o al servizio, utilizza `key=location`. Per impostare un limite globale per le richieste in entrata in base all'intestazione, utilizza `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: la velocità.</li>
  <li><code><em>&lt;conn&gt;</em></code>: il numero di connessioni.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## Affinità di sessione con i cookie (sticky-cookie-services)
{: #sticky-cookie-services}

Utilizza l'annotazione cookie permanente per aggiungere l'affinità di sessione al tuo controller Ingress e instradare sempre il traffico di rete in entrata allo stesso server upstream.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>Per l'alta disponibilità, alcune configurazioni di applicazione richiedono di distribuire più server upstream che gestiscono le richieste client in entrata. Quando un client si collega alla tua applicazione di back-end, puoi utilizzare l'affinità di sessione in modo che un client sia servito dallo stesso server upstream per la durata di una sessione o per il tempo necessario per completare un'attività. Puoi configurare il tuo controller Ingress per garantire che l'affinità di sessione instradi sempre il traffico di rete in entrata allo stesso server upstream.

</br></br>
Ad ogni client che si collega alla tua applicazione di back-end viene assegnato uno dei server upstream disponibili dal controller Ingress. Il controller Ingress crea un cookie di sessione che viene memorizzato nell'applicazione del client e che viene incluso nelle informazioni di intestazione di ogni richiesta tra il controller Ingress e il client. Le informazioni nel cookie garantiscono che tutte le richieste vengano gestite dallo stesso server upstream nella sessione.

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
  <caption>Descrizione dei componenti del file YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: il nome del servizio Kubernetes che hai creato
per la tua applicazione.</li>
  <li><code><em>&lt;cookie_name&gt;</em></code>: scegli un nome del cookie permanente creato durante una sessione.</li>
  <li><code><em>&lt;expiration_time&gt;</em></code>: il tempo in secondi, minuti o ore prima che il cookie permanente scada. Il tempo non è dipendente dall'attività utente. Dopo che il cookie è scaduto, viene eliminato dal browser web del client e non viene più inviato al controller Ingress. Ad esempio, per impostare un orario di scadenza di 1 secondo, 1 minuto o 1 ora, immetti <strong>1s</strong>, <strong>1m</strong> o <strong>1h</strong>.</li>
  <li><code><em>&lt;cookie_path&gt;</em></code>: il percorso accodato al dominio secondario Ingress e che indica per quali domini e domini secondari il cookie viene inviato al controller Ingress. Ad esempio, se il tuo dominio Ingress è <code>www.myingress.com</code> e desideri inviare il cookie in ogni richiesta client, devi impostare <code>path=/</code>. Se desideri inviare il cookie solo per <code>www.myingress.com/myapp</code> e a tutti i relativi domini secondari, devi impostare <code>path=/myapp</code>.</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code>: l'algoritmo hash che protegge le informazioni nel cookie. È
supportato solo <code>sha1</code>. SHA1 crea un riepilogo hash in base alle informazioni nel cookie e lo accoda ad esso. Il server può decrittografare le informazioni nel cookie e verificare l'integrità dei dati.
  </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## Supporto dei servizi SSL (ssl-services)
{: #ssl-services}

Consenti le richieste HTTPS e crittografa il traffico alle tue applicazioni upstream.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Crittografa il traffico verso le tue applicazioni upstream che richiedono HTTPS con i controller Ingress.

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
    ingress.bluemix.net/ssl-services: ssl-service=&lt;service1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;service2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;myservice&gt;</em></code>: immetti il nome del servizio che rappresenta la tua applicazione. Per questa applicazione, il traffico viene crittografato dal controller Ingress.</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>: immetti il segreto per il servizio. Questo parametro è facoltativo. Se il parametro viene fornito, il valore deve contenere la chiave e il certificato che la tua applicazione si aspetta dal client.  </li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM.
  <br><br>
  <strong>Nota:</strong> per evitare errori durante la creazione di Ingress, non utilizzare * per il tuo host o lascia vuota la proprietà host.</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Sostituisci <em>&lt;myservicepath&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione, in modo che il traffico di rete possa essere inoltrato all'applicazione.

  </br>
  Per ogni servizio Kubernetes,
puoi definire un percorso individuale che viene aggiunto al dominio fornito da IBM per creare un
percorso univoco alla tua applicazione, ad esempio <code>ingress_domain/myservicepath1</code>. Quando immetti questa rotta in un browser web,
il traffico di rete viene instradato al controller Ingress. Il controller Ingress cerca il servizio associato e invia il traffico di rete al servizio e ai pod in cui è in esecuzione l'applicazione utilizzando lo stesso percorso. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere
configurata per l'ascolto su questo percorso.

  </br></br>
  Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specifica. In questo caso, definisci il percorso root come
<code>/</code> e non specificare un percorso individuale per la tua applicazione.
  </br>
  Esempi: <ul><li>Per <code>http://ingress_host_name/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://ingress_host_name/myservicepath</code>, immetti <code>/myservicepath</code> come percorso.</li></ul>
  </br>
  <strong>Suggerimento:</strong> per configurare Ingress per l'ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'<a href="#rewrite-path" target="_blank">annotazione di riscrittura</a> per stabilire l'instradamento appropriato alla tua applicazione.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sostituisci <em>&lt;myservice&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione. </td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato
il servizio Kubernetes per la tua applicazione.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### Supporto dei servizi SSL con l'autenticazione
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
      ssl-service=&lt;service1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;service2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - hosts:
    - &lt;ibmdomain&gt;
    secretName: &lt;secret_name&gt;
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;service&gt;</em></code>: immetti il nome del servizio.</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code>: immetti il segreto per il servizio.</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>Sostituisci <em>&lt;ibmdomain&gt;</em> con il nome del <strong>Dominio secondario Ingress</strong> fornito da IBM.
  <br><br>
  <strong>Nota:</strong> per evitare errori durante la creazione di Ingress, non utilizzare * per il tuo host o lascia vuota la proprietà host.</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>Sostituisci <em>&lt;secret_name&gt;</em> con il nome del segreto che contiene il certificato e, per l'autenticazione reciproca, la chiave.
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Sostituisci <em>&lt;myservicepath&gt;</em> con una barra o il percorso univoco su cui è in ascolto la tua applicazione, in modo che il traffico di rete possa essere inoltrato all'applicazione.

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
  <strong>Suggerimento:</strong> per configurare Ingress per l'ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'<a href="#rewrite-path" target="_blank">annotazione di riscrittura</a> per stabilire l'instradamento appropriato alla tua applicazione.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sostituisci <em>&lt;myservice&gt;</em> con il nome del servizio che hai utilizzato alla creazione del servizio Kubernetes per la tua applicazione. </td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato
il servizio Kubernetes per la tua applicazione.</td>
  </tr>
  </tbody></table>

  </dd>



<dt>YAML del segreto di esempio per l'autenticazione unidirezionale</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt: &lt;certificate_name&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Sostituisci <em>&lt;secret_name&gt;</em> con un nome per la risorsa del segreto.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Sostituisci il seguente valore:<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>: immetti il nome del certificato attendibile.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>YAML del segreto di esempio per l'autenticazione reciproca</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt : &lt;certificate_name&gt;
    client.crt : &lt;client_certificate_name&gt;
    client.key : &lt;certificate_key&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Sostituisci <em>&lt;secret_name&gt;</em> con un nome per la risorsa del segreto.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>: immetti il nome del certificato attendibile.</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code>: immetti il nome del certificato client.</li>
  <li><code><em>&lt;certificate_key&gt;</em></code>: immetti la chiave per il certificato client.</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## Porte TCP per i controller Ingress (tcp-ports)
{: #tcp-ports}

Accedi a un'applicazione tramite una porta TCP non standard.
{:shortdesc}

<dl>
<dt>Descrizione</dt>
<dd>
Utilizza questa annotazione per un'applicazione che esegue un carico di lavoro di flussi TCP.

<p>**Nota**: il controller Ingress funziona in modalità pass-through e inoltra il traffico alle applicazioni di back-end. In questo caso, la terminazione SSL non è supportata.</p>
</dd>


 <dt>YAML risorsa Ingress di esempio</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/tcp-ports: "serviceName=&lt;service_name&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
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
  <td><code>annotations</code></td>
  <td>Sostituisci i seguenti valori:<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>: la porta TCP con cui vuoi accedere alla tua applicazione.</li>
  <li><code><em>&lt;serviceName&gt;</em></code>: il nome del servizio Kubernetes a cui accedere tramite una porta TCP non standard.</li>
  <li><code><em>&lt;servicePort&gt;</em></code>: questo parametro è facoltativo. Se fornito, la porta viene sostituita con questo valore prima che il traffico venga inviato all'applicazione di back-end. Altrimenti, la porta rimane uguale alla porta Ingress.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## Keepalive upstream (upstream-keepalive)
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
      ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;service_name&gt; keepalive=&lt;max_connections&gt;"
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
    <td><code>annotations</code></td>
    <td>Sostituisci i seguenti valori:<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>: sostituisci <em>&lt;service_name&gt;</em> con il nome del servizio Kubernetes che hai creato per la tua applicazione. </li>
    <li><code><em>&lt;keepalive&gt;</em></code>: sostituisci <em>&lt;max_connections&gt;</em> con il numero massimo di connessioni keepalive inattive al server upstream. Il valore predefinito è 64. Un valore zero disabilita le connessioni keepalive upstream per il servizio specificato.</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


