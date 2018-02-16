---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-05"

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

Sie können auf {{site.data.keyword.containershort_notm}} über einen globalen Endpunkt zugreifen: `https://containers.bluemix.net/`.
* Um zu überprüfen, in welcher {{site.data.keyword.containershort_notm}}-Region Sie sich momentan befinden, führen Sie `bx cs region` aus.
* Um eine Liste der verfügbaren Region samt den zugehörigen Endpunkten abzurufen, führen Sie den Befehl `bx cs regions` aus.

Um die API mit dem globalen Endpunkt zu verwenden, übergeben Sie in allen Ihren Anforderungen den Regionsnamen in einem Header vom Typ `X-Region`.
{: tip}

### Bei anderer Container-Service-Region anmelden
{: #container_login_endpoints}

Sie können sich beispielsweise aus den folgenden Gründen bei einer anderen Region als der {{site.data.keyword.containershort_notm}}-Region anmelden:
  * Sie haben {{site.data.keyword.Bluemix_notm}}-Services oder private Docker-Images in einer Region erstellt und wollen sie mit {{site.data.keyword.containershort_notm}} in einer anderen Region verwenden.
  * Sie möchten auf einen Cluster in einer Region zugreifen, die sich von der {{site.data.keyword.Bluemix_notm}}-Standardregion unterscheidet, bei der Sie angemeldet sind.

</br>

Um schnell zwischen Regionen zu wechseln, führen Sie `bx cs region-set`.

### Für den Container-Service verfügbare Standorte
{: #locations}

Bei Standorten handelt es sich um Rechenzentren, die in einer Region verfügbar sind.

  | Region | Standort | Ort |
  |--------|----------|------|
  | Asien-Pazifik (Norden) | hkg02, sng01, tok02 | Hongkong, Singapur, Tokio |
  | Asien-Pazifik (Süden)     | mel01, syd01, syd04        | Melbourne, Sydney |
  | Zentraleuropa     | ams03, fra02, mil01, par01        | Amsterdam, Frankfurt, Mailand, Paris |
  | Großbritannien (Süden)      | lon02, lon04         | London |
  | Vereinigte Staaten (Osten)      | <ph class="mon">mon01, </ph>tor01, wdc06, wdc07        | <ph class="mon">Montreal, </ph>Toronto, Washington, DC |
  | Vereinigte Staaten (Süden)     | dal10, dal12, dal13, sao01<!--sao-paolo--></ph>       | Dallas, São Paolo<!--sao-paolo--></ph> |

**Hinweis**: Mailand (mil01) ist nur für Lite-Cluster verfügbar.

### Container-Service-API-Befehle verwenden
{: #container_api}

Um mit der {{site.data.keyword.containershort_notm}}-API interagieren zu können, müssen Sie den Befehlstyp eingeben und an den globalen Endpunkt die Zeichenfolge `/v1/command` anfügen.

Beispiel für die API `GET /clusters`:
  ```
  GET https://containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Um die API mit dem globalen Endpunkt zu verwenden, übergeben Sie in allen Ihren Anforderungen den Regionsnamen in einem Header vom Typ `X-Region`. Um die verfügbaren Regionen aufzulisten, führen Sie den Befehl `bx cs regions` aus.
{: tip}

Die Dokumentation zu den API-Befehlen finden Sie unter [https://containers.bluemix.net/swagger-api/](https://containers.bluemix.net/swagger-api/).
