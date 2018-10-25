---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Regioni e zone

Una regione è una specifica ubicazione geografica in cui puoi distribuire applicazioni, servizi e altre risorse {{site.data.keyword.Bluemix}}. [Le regioni {{site.data.keyword.Bluemix_notm}}](#bluemix_regions) sono diverse dalle [regioni {{site.data.keyword.containerlong}}](#container_regions). Le regioni sono costituite da una o più zone che sono data center fisici che ospitano le risorse di calcolo, rete e archiviazione, nonché il raffreddamento e l'alimentazione correlati, che ospitano i servizi e le applicazioni host. Le zone sono isolate l'una dall'altra, il che garantisce che non ci sia alcun singolo punto di malfunzionamento condiviso.
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} è ospitato in tutto il mondo. I servizi in {{site.data.keyword.Bluemix_notm}} potrebbero essere disponibili globalmente o all'interno di una regione specifica. Quando crei un cluster Kubernetes in {{site.data.keyword.containerlong_notm}}, le sue risorse rimangono nella regione in cui hai distribuito il cluster.

**Nota**: puoi creare dei cluster standard in ogni regione {{site.data.keyword.containerlong_notm}} supportata. I cluster gratuiti sono disponibili solo in regioni selezionate.

![{{site.data.keyword.containerlong_notm}} - regioni e zone](images/regions-mz.png)

_Regioni e zone {{site.data.keyword.containerlong_notm}}_

Le regioni {{site.data.keyword.containerlong_notm}} supportate sono le seguenti:
* Asia Pacifico Nord (solo cluster standard)
* Asia Pacifico Sud
* Europa Centrale
* Regno Unito Sud
* Stati Uniti Est (solo cluster standard)
* Stati Uniti Sud

<br />


## Regioni in {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

Puoi organizzare le tue risorse con nei servizi {{site.data.keyword.Bluemix_notm}} utilizzando le regioni {{site.data.keyword.Bluemix_notm}}. Ad esempio, puoi creare un cluster Kubernetes utilizzando un'immagine Docker privata archiviata nel {{site.data.keyword.registryshort_notm}} della stessa regione.
{:shortdesc}

Per verificare in quale regione {{site.data.keyword.Bluemix_notm}} sei al momento, esegui `ibmcloud info` e controlla il campo **Regione**.

È possibile accedere alle regioni {{site.data.keyword.Bluemix_notm}} specificando l'endpoint API quando accedi. Se non specifici una regione, viene automaticamente fatto accesso alla regione a te più vicina.

Ad esempio, puoi utilizzare i seguenti comandi per accedere agli endpoint API della regione {{site.data.keyword.Bluemix_notm}}:

  * Stati Uniti Sud
      ```
      ibmcloud login -a api.ng.bluemix.net
      ```
      {: pre}

  * Stati Uniti Est
      ```
      ibmcloud login -a api.us-east.bluemix.net
      ```
      {: pre}

  * Sydney e Tokyo
      ```
      ibmcloud login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * Germania
      ```
      ibmcloud login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * Regno Unito
      ```
      ibmcloud login -a api.eu-gb.bluemix.net
      ```
      {: pre}

<br />


## Regioni in {{site.data.keyword.containerlong_notm}}
{: #container_regions}

Utilizzando le regioni {{site.data.keyword.containerlong_notm}}, puoi creare o accedere ai cluster Kubernetes in un'altra regione rispetto alla regione
{{site.data.keyword.Bluemix_notm}} in cui hai eseguito l'accesso. Gli endpoint della regione {{site.data.keyword.containerlong_notm}} fanno riferimento nello specifico a
{{site.data.keyword.containerlong_notm}}, non a {{site.data.keyword.Bluemix_notm}} nel suo insieme.
{:shortdesc}

**Nota**: puoi creare dei cluster standard in ogni regione {{site.data.keyword.containerlong_notm}} supportata. I cluster gratuiti sono disponibili solo in regioni selezionate.

Regioni {{site.data.keyword.containerlong_notm}} supportate:
  * Asia Pacifico Nord (solo cluster standard)
  * Asia Pacifico Sud
  * Europa Centrale
  * Regno Unito Sud
  * Stati Uniti Est (solo cluster standard)
  * Stati Uniti Sud

Puoi accedere a {{site.data.keyword.containerlong_notm}} tramite un endpoint globale: `https://containers.bluemix.net/v1`.
* Per verificare in quale regione {{site.data.keyword.containerlong_notm}} sei al momento, esegui `ibmcloud ks region`.
* Per richiamare un elenco di regioni disponibili e i relativi endpoint, esegui `ibmcloud ks regions`.

Per utilizzare l'API con l'endpoint globale, in tutte le richieste, trasmetti il nome della regione nell'intestazione `X-Region`.
{: tip}

### Accesso a una regione {{site.data.keyword.containerlong_notm}} differente
{: #container_login_endpoints}

Puoi modificare le regioni utilizzando la CLI {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Potresti voler accedere a un'altra regione {{site.data.keyword.containerlong_notm}} per i seguenti motivi:
  * Hai creato i servizi {{site.data.keyword.Bluemix_notm}} o le immagini Docker private in una regione e desideri utilizzarle con {{site.data.keyword.containerlong_notm}} in un'altra regione.
  * Vuoi accedere a un cluster in una regione diversa dalla regione {{site.data.keyword.Bluemix_notm}} predefinita a cui hai eseguito l'accesso.

Per selezionare velocemente la regione, esegui [`ibmcloud ks region-set`](cs_cli_reference.html#cs_region-set).

### Utilizzo dei comandi API {{site.data.keyword.containerlong_notm}}
{: #containers_api}

Per interagire con l'API {{site.data.keyword.containerlong_notm}}, immetti il tipo di comando e aggiungi `/v1/command` all'endpoint globale.
{:shortdesc}

Esempio di API `GET /clusters`:
  ```
  GET https://containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Per utilizzare l'API con l'endpoint globale, in tutte le richieste, trasmetti il nome della regione nell'intestazione `X-Region`. Per elencare le regioni disponibili, esegui `ibmcloud ks regions`.
{: tip}

Per visualizzare la documentazione sui comandi API, vedi [https://containers.bluemix.net/swagger-api/](https://containers.bluemix.net/swagger-api/).

## Zone in {{site.data.keyword.containerlong_notm}}
{: #zones}

Le zone sono data center fisici che sono disponibili in una regione {{site.data.keyword.Bluemix_notm}}. Le regioni sono uno strumento concettuale per organizzare le zone e possono includere zone (data center) in diversi paesi. La seguente tabella visualizza le zone disponibili per regione.
{:shortdesc}

* **Città metropolitana multizona**: I nodi di lavoro nei cluster creati in una città metropolitana multizona possono essere distribuiti tra le zone.
* **Città a zona singola**: i nodi di lavoro nei cluster creati in una città a singola zona rimangono in una singola zona. Non è possibile distribuire i nodi di lavoro tra più zone.

<table summary="La tabella mostra le zone disponibili in base alle regioni. Le righe sono da leggere da sinistra a destra, con la regione nella colonna uno, le città metropolitane multizona nella colonna due e le città a zona singola nella colonna tre.">
<caption>Zone singole e multizona disponibili per regione.</caption>
  <thead>
  <th>Regione</th>
  <th>Città metropolitana multizona</th>
  <th>Città a zona singola</th>
  </thead>
  <tbody>
    <tr>
      <td>Asia Pacifico Nord</td>
      <td>Tokyo: tok02, tok04, tok05</td>
      <td><p>Hong Kong S.A.R. della Repubblica Popolare Cinese: hkg02</p>
      <p>Seoul: seo01</p>
      <p>Singapore: sng01</p></td>
    </tr>
    <tr>
      <td>Asia Pacifico Sud</td>
      <td>Nessuno</td>
      <td><p>Sydney: syd01, syd04</p>
      <p>Melbourne: mel01</p></td>
    </tr>
    <tr>
      <td>Europa Centrale</td>
      <td>Francoforte: fra02, fra04, fra05</td>
      <td><p>Amsterdam: ams03</p>
      <p>Milano: mil01</p>
      <p>Oslo: osl01</p>
      <p>Parigi: par01</p>
      </td>
    </tr>
    <tr>
      <td>Regno Unito Sud</td>
      <td>Londra: lon02, lon04, lon06</td>
      <td></td>
    </tr>
    <tr>
      <td>Stati Uniti Est</td>
      <td>Washington DC: wdc04, wdc06, wdc07</td>
      <td><p>Montreal: mon01</p>
      <p>Toronto: tor01</p></td>
    </tr>
    <tr>
      <td>Stati Uniti Sud</td>
      <td>Dallas: dal10, dal12, dal13</td>
      <td><p>San Jose: sjc03, sjc04</p>
      <p>São Paulo: sao01</p></td>
    </tr>
  </tbody>
</table>

### Cluster a zona singola
{: #single_zone}

In un cluster a zona singola, le risorse del tuo cluster rimangono nella zona in cui viene distribuito il cluster. La seguente immagine evidenzia la relazione dei componenti del cluster a zona singola in una regione di esempio degli Stati Uniti Est:

![Descrizione della posizione in cui risiedono le risorse del cluster](/images/region-cluster-resources.png)

_Descrizione della posizione in cui risiedono le risorse del cluster a zona singola._

1.  Le risorse del tuo cluster, inclusi i nodi master e di lavoro, si trovano nella stessa zona in cui hai distribuito il cluster. Quando avvii azioni di orchestrazione del contenitore locale, come i comandi `kubectl`, le informazioni vengono scambiate tra i tuoi nodi master e di lavoro all'interno della stessa zona.

2.  Se configuri altre risorse del cluster, come archiviazione, rete, calcolo o applicazioni in esecuzione nei pod, le risorse e i loro dati rimangono nella zona in cui hai distribuito il tuo cluster.

3.  Quando avvii azioni di gestione del cluster, utilizzando ad esempio i comandi `ibmcloud ks`, le informazioni di base sul cluster (come nome, ID, utente, comando) vengono instradate tramite un endpoint regionale.

### Cluster multizona
{: #multizone}

In un cluster multizona, il nodo master viene distribuito in una zona con supporto multizona e le risorse del tuo cluster vengono distribuite tra più zone.

1.  I nodi di lavoro vengono distribuiti tra più zone in una singola regione per fornire maggiore disponibilità per il tuo cluster. Il master rimane nella stessa zona con supporto multizona in cui avevi distribuito il cluster. Quando avvii le azioni di orchestrazione del contenitore locali, quali i comandi `kubectl`, le informazioni vengono scambiate tra i tuoi nodi master e di lavoro tramite un endpoint regionale.

2.  La modalità di distribuzione nelle zone nel tuo cluster multizona di altre risorse del cluster, quali l'archiviazione, la rete, il calcolo o le applicazioni in esecuzione nei pod, varia. Per ulteriori informazioni, consulta questi argomenti:
    * Configurazione di [archiviazione file](cs_storage_file.html#add_file) e [archiviazione blocco](cs_storage_block.html#add_block) nei cluster multizona.
    * [Abilitazione dell'accesso pubblico o privato a un'applicazione utilizzando un servizio LoadBalancer in un cluster multizona](cs_loadbalancer.html#multi_zone_config)
    * [Gestione del traffico di rete utilizzando Ingress](cs_ingress.html#planning)
    * [Aumento della disponibilità della tua applicazione](cs_app.html#increase_availability)

3.  Quando avvii azioni di gestione del cluster, utilizzando ad esempio i comandi [`ibmcloud ks`](cs_cli_reference.html#cs_cli_reference), le informazioni di base sul cluster (come nome, ID, utente, comando) vengono instradate tramite un endpoint regionale.
