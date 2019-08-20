---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb, health check, dns, host name

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


# Registrazione di un nome host NLB
{: #loadbalancer_hostname}

Dopo aver configurato gli NLB (network load balancer), puoi creare le voci DNS per gli IP NLB creando dei nomi host. Puoi anche configurare i monitoraggi TCP/HTTP(S) per controllare l'integrità degli indirizzi IP NLB dietro ciascun nome host.
{: shortdesc}

<dl>
<dt>Nome host</dt>
<dd>Quando crei un NLB pubblico in un cluster a zona singola o multizona, puoi esporre la tua applicazione a Internet creando un nome host per l'indirizzo IP NLB. Inoltre, {{site.data.keyword.cloud_notm}} genera e aggiorna automaticamente il certificato SSL jolly per il nome host.
<p>Nei cluster multizona, puoi creare un nome host e aggiungere l'indirizzo IP NLB in ciascuna zona a quella voce DNS del nome host. Ad esempio, se hai distribuito gli NLB per la tua applicazione in tre zone negli Stati Uniti Sud, puoi creare il nome host `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` per i tre indirizzi IP NLB. Quando un utente accede al nome host della tua applicazione, il client accede a uno di questi IP a caso e la richiesta viene inviata a tale NLB.</p>
Nota che attualmente non è possibile creare nomi host per NLB privati.</dd>
<dt>Monitoraggio del controllo di integrità</dt>
<dd>Abilita i controlli di integrità sugli indirizzi IP NLB dietro un unico nome host per determinare se sono disponibili o meno. Quando abiliti un monitoraggio per il tuo nome host, esso controlla lo stato di integrità di ciascun IP NLB e mantiene aggiornati i risultati della ricerca DNS sulla base dei controlli di integrità effettuati. Ad esempio, se i tuoi NLB hanno gli indirizzi IP `1.1.1.1`, `2.2.2.2` e `3.3.3.3`, una normale operazione di ricerca DNS del tuo nome host restituisce tutti e 3 gli IP e il client accede a uno di essi in modo casuale. Se l'NLB con indirizzo IP `3.3.3.3` diventa per un qualsiasi motivo non disponibile, ad esempio a causa di un malfunzionamento di zona, il controllo dell'integrità per tale IP non riesce, il monitoraggio rimuove l'IP non riuscito dal nome host e la ricerca DNS restituisce solo gli IP `1.1.1.1` e `2.2.2.2` integri.</dd>
</dl>

Puoi visualizzare tutti i nomi host registrati per i IP NLB nel tuo cluster, eseguendo il seguente comando.
```
ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
```
{: pre}

</br>

## Registrazione degli IP NLB con un nome host DNS
{: #loadbalancer_hostname_dns}

Esponi la tua applicazione all'Internet pubblico creando un nome host per l'indirizzo IP NLB (network load balancer).
{: shortdesc}

Prima di iniziare:
* Esamina le seguenti considerazioni e limitazioni.
  * Puoi creare nomi host per NLB pubblici, versione 1.0 e 2.0.
  * Al momento non puoi creare i nomi host per NLB privati.
  * Puoi registrare fino a 128 nomi host. Questo limite può essere innalzato su richiesta, aprendo un [caso
di supporto](/docs/get-support?topic=get-support-getting-customer-support).
* [Crea un NLB per la tua applicazione in un cluster a zona singola](/docs/containers?topic=containers-loadbalancer#lb_config) o [crea NLB in ciascuna zona di un cluster multizona](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

Per creare un nome host per uno o più indirizzi IP NLB:

1. Ottieni l'indirizzo **EXTERNAL-IP** per il tuo NLB. Se hai NLB in ciascuna zona di un cluster multizona e tali NLB espongono una sola applicazione, ottieni gli IP per ciascun NLB.
  ```
  kubectl get svc
  ```
  {: pre}

  Nel seguente output di esempio, gli **EXTERNAL-IP** dell'NLB sono `168.2.4.5` e `88.2.4.5`.
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. Registra l'IP creando un nome host DNS. Nota che inizialmente puoi creare il nome host con un solo indirizzo IP.
  ```
  ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <NLB_IP>
  ```
  {: pre}

3. Verifica che il nome host sia stato creato.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Output di esempio:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. Se hai NLB in ciascuna zona di un cluster multizona e tali NLB espongono una sola applicazione, aggiungi gli IP degli altri NLB al nome host. Nota che devi eseguire
il seguente comando per ciascun indirizzo IP che desideri aggiungere.
  ```
  ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
  ```
  {: pre}

5. Facoltativo: verificare che gli IP siano registrati con il tuo nome host eseguendo un `host` o `ns lookup`.
  Comando di esempio:
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  Output di esempio:
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. In un browser Web, immetti l'URL per accedere alla tua applicazione attraverso il nome host che hai creato.

In seguito, puoi [abilitare i controlli di integrità sul nome host creando un monitoraggio dell'integrità](#loadbalancer_hostname_monitor).

</br>

## Descrizione del formato del nome host
{: #loadbalancer_hostname_format}

I nomi host per l'NLB utilizzano il formato `<cluster_name>-<globally_unique_account_HASH>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud`.
{: shortdesc}

Ad esempio, se crei un nome host per un NLB potrebbe essere simile al seguente:
`mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud`. La seguente tabella descrive ciascun componente del nome host.

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione del formato del nome host di bilanciamento del carico</th>
</thead>
<tbody>
<tr>
<td><code>&lt;cluster_name&gt;</code></td>
<td>Il nome del tuo cluster.
<ul><li>Se la lunghezza del nome del cluster è minore o uguale a 26 caratteri, il nome del cluster viene incluso per intero senza modifiche: <code>myclustername</code>.</li>
<li>Se la lunghezza del nome del cluster è uguale o maggiore di 26 caratteri e il nome del cluster è univoco all'interno della regione, vengono utilizzati solo i suoi primi 24 caratteri: <code>myveryverylongclusternam</code>.</li>
<li>Se la lunghezza del nome del cluster è uguale o maggiore di 26 caratteri ed esiste già un altro cluster con lo stesso nome all'interno della regione, vengono utilizzati solo i primi 17 caratteri del nome del cluster e viene aggiunto un trattino seguito da sei caratteri casuali: <code>myveryverylongclu-ABC123</code>.</li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>Viene creato un HASH univoco a livello globale per il tuo account {{site.data.keyword.cloud_notm}}, che viene utilizzato da tutti i nomi host che crei per gli NLB nei cluster del tuo account.</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
Il primo e il secondo carattere, <code>00</code>, indicano un nome host pubblico. Il terzo e il quarto carattere, quali <code>01</code> o un altro numero, fungono da contatore per ognuno dei nomi host che crei.</td>
</tr>
<tr>
<td><code>&lt;region&gt;</code></td>
<td>La regione in cui viene creato il cluster.</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>Il dominio secondario per i nomi host {{site.data.keyword.containerlong_notm}}.</td>
</tr>
</tbody>
</table>

</br>

## Abilita i controlli di integrità su un nome host creando un monitoraggio dell'integrità
{: #loadbalancer_hostname_monitor}

Abilita i controlli di integrità sugli indirizzi IP NLB dietro un unico nome host per determinare se sono disponibili o meno.
{: shortdesc}

Prima di iniziare, [registra gli IP NLB con un nome host DNS](#loadbalancer_hostname_dns).

1. Ottieni il nome del tuo nome host. Nell'output, osserva che lo **Stato** di monitoraggio dell'host è `Unconfigured`.
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  Output di esempio:
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. Crea un monitoraggio del controllo di integrità per il nome host. Se non includi un parametro di configurazione, viene utilizzato il valore predefinito.
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>Descrizione dei componenti di questo comando</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;cluster_name_or_ID&gt;</code></td>
  <td>Obbligatorio: il nome o l'ID del cluster in cui è registrato il nome host.</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;host_name&gt;</code></td>
  <td>Obbligatorio: il nome host per cui abilitare un monitoraggio di controllo dell'integrità.</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>Obbligatorio: abilita il monitoraggio del controllo di integrità per il nome host.</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>Descrizione del monitoraggio dell'integrità.</td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>Il protocollo da utilizzare per il controllo di integrità: <code>HTTP</code>, <code>HTTPS</code> o <code>TCP</code>. Impostazione predefinita: <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>Metodo da utilizzare per il controllo di integrità. Impostazione predefinita per il <code>type</code> <code>HTTP</code> e <code>HTTPS</code>: <code>GET</code>. Impostazione predefinita per il <code>type</code> <code>TCP</code>: <code>connection_established</code>.</td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td>Quando il <code>type</code> è <code>HTTPS</code>: il percorso dell'endpoint per cui viene eseguito il controllo di integrità. Impostazione predefinita: <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>Timeout, in secondi, prima che l'IP venga considerato non integro. Impostazione predefinita: <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>Quando si verifica un timeout, il numero di tentativi da eseguire prima che l'IP venga considerato non integro. I nuovi tentativi vengono effettuati immediatamente. Impostazione predefinita: <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>Intervallo, in secondi, tra ogni controllo di integrità. L'uso di intervalli brevi potrebbe diminuire il tempo di failover, ma aumentare il carico sugli IP. Impostazione predefinita: <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>Il numero di porta a cui connettersi per il controllo di integrità. Se <code>type</code> è <code>TCP</code>, questo parametro è obbligatorio. Se <code>type</code> è <code>HTTP</code> o <code>HTTPS</code>, definisci la porta solo se utilizzi una porta diversa da 80 per HTTP o 443 per HTTPS. Valore predefinito per il TCP: <code>0</code>. Valore predefinito per l'HTTP: <code>80</code>. Valore predefinito per l'HTTPS: <code>443</code>.</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td>Quando il <code>type</code> è <code>HTTP</code> o <code>HTTPS</code>: una stringa secondaria senza distinzione di maiuscole/minuscole che il controllo di integrità ricerca nel corpo della risposta. Se
questa stringa non viene trovata, l'IP viene considerato non integro.</td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td>Se il <code>type</code> è <code>HTTP</code> o <code>HTTPS</code>: codici HTTP che il controllo di integrità ricerca nella risposta. Se il codice HTTP non viene trovato, l'IP viene considerato non integro. Impostazione predefinita: <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td>Se il <code>type</code> è <code>HTTP</code> o <code>HTTPS</code>: impostalo su <code>true</code> per non convalidare il certificato.</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td>Se il <code>type</code> è <code>HTTP</code> o <code>HTTPS</code>: impostalo su <code>true</code> per seguire i reindirizzamenti restituiti dall'IP.</td>
  </tr>
  </tbody>
  </table>

  Comando di esempio:
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60 --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. Verifica che il monitoraggio del controllo di integrità sia configurato con le impostazioni corrette.
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Output di esempio:
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. Visualizza lo stato di controllo di integrità degli IP NLB che stanno dietro il tuo nome host.
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  Output di esempio:
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### Aggiornamento e rimozione di IP e monitoraggi dai nomi host
{: #loadbalancer_hostname_delete}

Puoi aggiungere e rimuovere gli indirizzi IP NLB dai nomi host che hai generato. Puoi anche disabilitare e abilitare i monitoraggi del controllo di integrità per i nomi host in base alle necessità.
{: shortdesc}

**IP NLB**

Se successivamente aggiungi ulteriori NLB in altre zone del tuo cluster per esporre la stessa applicazione, puoi aggiungere gli IP NLB al nome host esistente. Nota che devi eseguire
il seguente comando per ciascun indirizzo IP che desideri aggiungere.
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

Puoi anche rimuovere gli indirizzi IP degli NLB che non desideri più siano registrati con un nome host. Nota che devi eseguire
il seguente comando per ciascun indirizzo IP che desideri rimuovere. Se rimuovi tutti gli IP da un nome host, il nome host esiste ancora, ma non è associato ad alcun IP.
```
ibmcloud ks nlb-dns-rm --cluster <cluster_name_or_id> --ip <ip1,ip2> --nlb-host <host_name>
```
{: pre}

</br>

**Monitoraggi del controllo di integrità**

Se devi modificare la configurazione del tuo monitoraggio dell'integrità, puoi modificare le impostazioni specifiche. Includi solo gli indicatori per le impostazioni che desideri modificare.
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

Puoi disabilitare il monitoraggio del controllo di integrità per un nome host in qualsiasi momento, eseguendo il seguente comando:
```
ibmcloud ks nlb-dns-monitor-disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

Per riabilitare un monitoraggio per un nome host, esegui il seguente comando:
```
ibmcloud ks nlb-dns-monitor-enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}
