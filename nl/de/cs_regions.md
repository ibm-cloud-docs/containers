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

# Regionen und Standorte
{{site.data.keyword.Bluemix}} wird weltweit gehostet. Eine Region ist ein geografischer Bereich, auf den über einen Endpunkt zugegriffen wird. Standorte stellen Rechenzentren innerhalb der Region dar. Die Services in {{site.data.keyword.Bluemix_notm}} sind möglicherweise global verfügbar, oder aber nur innerhalb einer bestimmten Region.
{:shortdesc}

[{{site.data.keyword.Bluemix_notm}}-Regionen](#bluemix_regions) unterscheiden sich von [{{site.data.keyword.containershort_notm}}-Regionen](#container_regions).

![{{site.data.keyword.containershort_notm}}-Regionen und -Rechenzentren](/images/regions.png)

Abbildung 1. {{site.data.keyword.containershort_notm}}-Regionen und -Rechenzentren

Unterstützte {{site.data.keyword.containershort_notm}}-Regionen:
  * Asien-Pazifik (Norden)
  * Asien-Pazifik (Süden)
  * Zentraleuropa
  * Großbritannien (Süden)
  * Vereinigte Staaten (Osten)
  * Vereinigte Staaten (Süden)

Sie können Kubernetes-Lite-Cluster in den folgenden Regionen erstellen:
  * Asien-Pazifik (Süden)
  * Zentraleuropa
  * Großbritannien (Süden)
  * Vereinigte Staaten (Süden)

  **Hinweis**: Wenn Sie kein Bezahlkunde sind, können Sie keine Lite-Cluster in der Region 'Vereinigte Staaten (Süden)' erstellen.


## API-Endpunkte für {{site.data.keyword.Bluemix_notm}}-Regionen
{: #bluemix_regions}

Sie können Ihre Ressourcen übergreifend für die {{site.data.keyword.Bluemix_notm}}-Services organisieren, indem Sie die {{site.data.keyword.Bluemix_notm}}-Regionen verwenden. Sie können beispielsweise einen Kubernetes-Cluster mithilfe eines privaten Docker-Images erstellen, das in Ihrem {{site.data.keyword.registryshort_notm}} derselben Region gespeichert ist.
{:shortdesc}

Um zu überprüfen, in welcher {{site.data.keyword.Bluemix_notm}}-Region Sie sich momentan befinden, müssen Sie den Befehl `bx info` ausführen und dann den Wert im Feld **Region** überprüfen.

Auf {{site.data.keyword.Bluemix_notm}}-Regionen kann zugegriffen werden, indem bei der Anmeldung der API-Endpunkt angegeben wird. Wenn Sie keine Region angeben, werden Sie automatisch bei der nächstgelegenen Region angemeldet.

API-Endpunkte für {{site.data.keyword.Bluemix_notm}}-Regionen mit Beispiel für Anmeldebefehle:

  * Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten)
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * Sydney und Asien-Pazifik (Norden)
      ```
      bx login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * Deutschland
      ```
      bx login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * Großbritannien
      ```
      bx login -a api.eu-gb.bluemix.net
      ```
      {: pre}



<br />


## API-Endpunkte und Standorte für {{site.data.keyword.containershort_notm}}-Regionen
{: #container_regions}

Mithilfe von {{site.data.keyword.containershort_notm}}-Regionen können Sie Kubernetes-Cluster erstellen oder auf Kubernetes-Cluster in einer Region zugreifen, die von der {{site.data.keyword.Bluemix_notm}}-Region abweicht, in der Sie angemeldet sind. Die Endpunkte für die {{site.data.keyword.containershort_notm}}-Region verweisen speziell auf {{site.data.keyword.containershort_notm}} und nicht auf {{site.data.keyword.Bluemix_notm}} im Allgemeinen.
{:shortdesc}

API-Endpunkte für {{site.data.keyword.containershort_notm}}-Regionen:
  * Asien-Pazifik (Norden): `https://ap-north.containers.bluemix.net`
  * Asien-Pazifik (Süden): `https://ap-south.containers.bluemix.net`
  * Zentraleuropa: `https://eu-central.containers.bluemix.net`
  * Großbritannien (Süden): `https://uk-south.containers.bluemix.net`
  * Vereinigte Staaten (Osten): `https://us-east.containers.bluemix.net`
  * Vereinigte Staaten (Süden): `https://us-south.containers.bluemix.net`

Um zu überprüfen, in welcher {{site.data.keyword.containershort_notm}}-Region Sie sich momentan befinden, müssen Sie den Befehl `bx cs api` ausführen und dann den Wert im Feld **Region** überprüfen.

### Bei anderer Container-Service-Region anmelden
{: #container_login_endpoints}

Sie können sich beispielsweise aus den folgenden Gründen bei einer anderen Region als der {{site.data.keyword.containershort_notm}}-Region anmelden:
  * Sie haben {{site.data.keyword.Bluemix_notm}}-Services oder private Docker-Images in einer Region erstellt und wollen sie mit {{site.data.keyword.containershort_notm}} in einer anderen Region verwenden.
  * Sie möchten auf einen Cluster in einer Region zugreifen, die sich von der {{site.data.keyword.Bluemix_notm}}-Standardregion unterscheidet, bei der Sie angemeldet sind.

</br>

Beispielbefehle zur Anmeldung bei einer {{site.data.keyword.containershort_notm}}-Region:
  * Asien-Pazifik (Norden):
    ```
    bx cs init --host https://ap-north.containers.bluemix.net
    ```
  {: pre}

  * Asien-Pazifik (Süden):
    ```
    bx cs init --host https://ap-south.containers.bluemix.net
    ```
    {: pre}

  * Zentraleuropa:
    ```
    bx cs init --host https://eu-central.containers.bluemix.net
    ```
    {: pre}

  * Großbritannien (Süden):
    ```
    bx cs init --host https://uk-south.containers.bluemix.net
    ```
    {: pre}

  * Vereinigte Staaten (Osten):
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * Vereinigte Staaten (Süden):
    ```
    bx cs init --host https://us-south.containers.bluemix.net
    ```
    {: pre}


### Für den Container-Service verfügbare Standorte
{: #locations}

Bei Standorten handelt es sich um Rechenzentren, die in einer Region verfügbar sind.

  | Region | Standort | Ort |
  |--------|----------|------|
  | Asien-Pazifik (Norden)| hkg02, tok02 | Hongkong, Tokio |
  | Asien-Pazifik (Süden)     | mel01, syd01, syd04        | Melbourne, Sydney |
  | Zentraleuropa     | ams03, fra02, par01        | Amsterdam, Frankfurt, Paris |
  | Großbritannien (Süden)      | lon02, lon04         | London |
  | Vereinigte Staaten (Osten)      | tor01, wdc06, wdc07        | Toronto, Washington, DC |
  | Vereinigte Staaten (Süden)     | dal10, dal12, dal13       | Dallas |

### Container-Service-API-Befehle verwenden
{: #container_api}

Um mit der {{site.data.keyword.containershort_notm}}-API interagieren zu können, müssen Sie den Befehlstyp eingeben und an den Endpunkt die Zeichenfolge `/v1/command` anfügen.

Beispiel für die API `GET /clusters` in der Region 'Vereinigte Staaten (Süden)':
  ```
  GET https://us-south.containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Zur Anzeige der Dokumentation zu den API-Befehlen müssen Sie an den Endpunkt der Region, die angezeigt werden soll, die Zeichenfolge `swagger-api` anfügen.
  * Asien-Pazifik (Norden): https://ap-north.containers.bluemix.net/swagger-api/
  * Asien-Pazifik (Süden): https://ap-south.containers.bluemix.net/swagger-api/
  * Zentraleuropa: https://eu-central.containers.bluemix.net/swagger-api/
  * Großbritannien (Süden): https://uk-south.containers.bluemix.net/swagger-api/
  * Vereinigte Staaten (Osten): https://us-east.containers.bluemix.net/swagger-api/
  * Vereinigte Staaten (Süden): https://us-south.containers.bluemix.net/swagger-api/
