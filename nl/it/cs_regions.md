---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Regioni e ubicazioni
{{site.data.keyword.Bluemix}} è ospitato in tutto il mondo. Una regione è un'area geografica a cui è possibile accedere da un endpoint. Le ubicazioni sono data center all'interno della regione. I servizi in {{site.data.keyword.Bluemix_notm}} potrebbero essere disponibili globalmente o all'interno di una regione specifica.
{:shortdesc}

[Le regioni {{site.data.keyword.Bluemix_notm}}](#bluemix_regions) sono diverse dalle regioni [{{site.data.keyword.containershort_notm}}](#container_regions).

![{{site.data.keyword.containershort_notm}} - Regioni e data center](/images/regions.png)

Figura 1. Regioni e data center {{site.data.keyword.containershort_notm}}

Regioni {{site.data.keyword.containershort_notm}} supportate:
  * Asia Pacifico Nord
  * Asia Pacifico Sud
  * Europa Centrale
  * Regno Unito Sud
  * Stati Uniti Est
  * Stati Uniti Sud

Puoi creare cluster lite Kubernetes nelle seguenti regioni:
  * Asia Pacifico Sud
  * Europa Centrale
  * Regno Unito Sud
  * Stati Uniti Sud

  **Nota**: se non sei cliente di un servizio a pagamento, non puoi creare i cluster lite nella regione Stati Uniti Sud.


## Endpoint API regione {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

Puoi organizzare le tue risorse con nei servizi {{site.data.keyword.Bluemix_notm}} utilizzando le regioni {{site.data.keyword.Bluemix_notm}}. Ad esempio, puoi creare un cluster Kubernetes utilizzando un'immagine Docker privata archiviata nel {{site.data.keyword.registryshort_notm}} della stessa regione.
{:shortdesc}

Per verificare in quale regione {{site.data.keyword.Bluemix_notm}} sei al momento, esegui `bx info` e controlla il campo **Regione**.

È possibile accedere alle regioni {{site.data.keyword.Bluemix_notm}} specificando l'endpoint API quando accedi. Se non specifici una regione, viene automaticamente fatto accesso alla regione a te più vicina.

Endpoint API della regione {{site.data.keyword.Bluemix_notm}} con i comandi di accesso di esempio:

  * Stati Uniti Sud e Stati Uniti Est
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * Sydney e Asia Pacifico Nord
      ```
      bx login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * Germania
      ```
      bx login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * Regno Unito
      ```
      bx login -a api.eu-gb.bluemix.net
      ```
      {: pre}



<br />


## Ubicazioni e endpoint API della regione {{site.data.keyword.containershort_notm}}
{: #container_regions}

Utilizzando le regioni {{site.data.keyword.containershort_notm}}, puoi creare o accedere ai cluster Kubernetes in un'altra regione rispetto alla regione
{{site.data.keyword.Bluemix_notm}} in cui hai eseguito l'accesso. Gli endpoint della regione {{site.data.keyword.containershort_notm}} fanno riferimento nello specifico a
{{site.data.keyword.containershort_notm}}, non a {{site.data.keyword.Bluemix_notm}} nel suo insieme.
{:shortdesc}

Endpoint API regione {{site.data.keyword.containershort_notm}}:
  * Asia Pacifico Nord: `https://ap-north.containers.bluemix.net`
  * Asia Pacifico Sud: `https://ap-south.containers.bluemix.net`
  * Europa centrale: `https://eu-central.containers.bluemix.net`
  * Regno Unito Sud: `https://uk-south.containers.bluemix.net`
  * Stati Uniti Est: `https://us-east.containers.bluemix.net`
  * Stati Uniti Sud: `https://us-south.containers.bluemix.net`

Per verificare in quale regione {{site.data.keyword.containershort_notm}} sei al momento, esegui `bx cs api` e controlla il campo **Regione**.

### Accesso a una diversa regione del servizio del contenitore
{: #container_login_endpoints}

Potresti voler accedere a un'altra regione {{site.data.keyword.containershort_notm}} per i seguenti motivi:
  * Hai creato i servizi {{site.data.keyword.Bluemix_notm}} o le immagini Docker private in una regione e desideri utilizzarle con {{site.data.keyword.containershort_notm}} in un'altra regione.
  * Vuoi accedere a un cluster in una regione diversa dalla regione {{site.data.keyword.Bluemix_notm}} predefinita a cui hai eseguito l'accesso.

</br>

Comandi di esempio per accedere a una regione {{site.data.keyword.containershort_notm}}:
  * Asia Pacifico Nord:
    ```
    bx cs init --host https://ap-north.containers.bluemix.net
    ```
  {: pre}

  * Asia Pacifico Sud:
    ```
    bx cs init --host https://ap-south.containers.bluemix.net
    ```
    {: pre}

  * Europa Centrale:
    ```
    bx cs init --host https://eu-central.containers.bluemix.net
    ```
    {: pre}

  * Regno Unito Sud:
    ```
    bx cs init --host https://uk-south.containers.bluemix.net
    ```
    {: pre}

  * Stati Uniti Est:
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * Stati Uniti Sud:
    ```
    bx cs init --host https://us-south.containers.bluemix.net
    ```
    {: pre}


### Ubicazioni disponibili per il servizio del contenitore
{: #locations}

Le ubicazioni sono data center disponibili in una regione.

  | Regione | Ubicazione | Città |
  |--------|----------|------|
  | Asia Pacifico Nord | hkg02, tok02 | Hong Kong, Tokyo |
  | Asia Pacifico Sud     | mel01, syd01, syd04        | Melbourne, Sydney |
  | Europa Centrale     | ams03, fra02, par01        | Amsterdam, Francoforte, Parigi |
  | Regno Unito Sud      | lon02, lon04         | Londra |
  | Stati Uniti Est      | tor01, wdc06, wdc07        | Toronto, Washington, DC |
  | Stati Uniti Sud     | dal10, dal12, dal13       | Dallas |

### Utilizzo dei comandi API del servizio del contenitore
{: #container_api}

Per interagire con l'API {{site.data.keyword.containershort_notm}}, immetti il tipo di comando e aggiungi `/v1/command` all'endpoint.

Esempio di API `GET /clusters` in Stati Uniti Sud:
  ```
  GET https://us-south.containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Per visualizzare la documentazione sui comandi API, aggiungi `swagger-api` all'endpoint della regione da visualizzare.
  * Asia Pacifico Nord: https://ap-north.containers.bluemix.net/swagger-api/
  * Asia Pacifico Sud: https://ap-south.containers.bluemix.net/swagger-api/
  * Europa centrale: https://eu-central.containers.bluemix.net/swagger-api/
  * Regno Unito Sud: https://uk-south.containers.bluemix.net/swagger-api/
  * Stati Uniti Est: https://us-east.containers.bluemix.net/swagger-api/
  * Stati Uniti Sud: https://us-south.containers.bluemix.net/swagger-api/
