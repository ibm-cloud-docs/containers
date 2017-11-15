---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Regiões e locais
{{site.data.keyword.Bluemix}} é hospedado no mundo todo. Uma região é uma área geográfica que é acessada por um terminal. Os locais são data centers na região. Os serviços no {{site.data.keyword.Bluemix_notm}} podem ficar disponíveis globalmente ou dentro de uma região específica.
{:shortdesc}

Regiões do [{{site.data.keyword.Bluemix_notm}} ](#bluemix_regions) diferem de regiões do [{{site.data.keyword.containershort_notm}} ](#container_regions).

Regiões do {{site.data.keyword.containershort_notm}} suportadas:
  * AP Sul
  * União Europeia Central
  * Sul do Reino Unido
  * Leste dos EUA
  * SUL dos EUA

## Terminais de API de região do {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

É possível organizar seus recursos em serviços do {{site.data.keyword.Bluemix_notm}} usando regiões do {{site.data.keyword.Bluemix_notm}}. Por exemplo, é possível criar um cluster do Kubernetes usando uma imagem do Docker privada que é armazenada em seu {{site.data.keyword.registryshort_notm}} da mesma região.
{:shortdesc}

Para verificar qual região do {{site.data.keyword.Bluemix_notm}} em que você está atualmente, execute `bx info` e revise o campo **Região**.

As regiões do {{site.data.keyword.Bluemix_notm}} podem ser acessadas especificando o terminal de API ao efetuar login. Se não especificar uma região, você será conectado automaticamente à região mais próxima de você.

Os terminais de API de região do {{site.data.keyword.Bluemix_notm}} com log de exemplo em comandos:

  * Sul dos EUA e Leste dos EUA
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * Sydney
      ```
      bx login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * Alemanha
      ```
      bx login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * United Kingdom
      ```
      bx login -a api.eu-gb.bluemix.net
      ```
      {: pre}



<br />


## Terminais e locais de API de região do {{site.data.keyword.containershort_notm}}
{: #container_regions}

Usando regiões do {{site.data.keyword.containershort_notm}}, é possível criar ou acessar clusters do Kubernetes em uma região diferente da região do {{site.data.keyword.Bluemix_notm}} que você está com login efetuado. Os terminais de região do {{site.data.keyword.containershort_notm}} referem-se especificamente ao {{site.data.keyword.containershort_notm}}, não ao {{site.data.keyword.Bluemix_notm}} como um todo.
{:shortdesc}

Terminais de API de região do {{site.data.keyword.containershort_notm}}:
  * Sul AP: `https://ap-south.containers.bluemix.net`
  * UE Central: `https://eu-central.containers.bluemix.net`
  * Sul do Reino Unido: `https://uk-south.containers.bluemix.net`
  * Leste dos EUA: `https://us-east.containers.bluemix.net`
  * Sul dos EUA: `https://us-south.containers.bluemix.net`

**Nota:** o Leste dos EUA está disponível para uso com comandos da CLI somente.

Para verificar qual região do {{site.data.keyword.containershort_notm}} em que você está atualmente, execute `bx cs api` e revise o campo **Região**.

### Efetuando login em uma região de serviço de contêiner diferente
{: #container_login_endpoints}

Talvez queira efetuar login em outra região do {{site.data.keyword.containershort_notm}} pelas razões a seguir:
  * Você criou serviços do {{site.data.keyword.Bluemix_notm}} ou imagens privadas do Docker em uma região e deseja utilizá-los com o {{site.data.keyword.containershort_notm}} em outra região.
  * Você deseja acessar um cluster em uma região diferente da região padrão do {{site.data.keyword.Bluemix_notm}} a que está conectado.

</br>

Exemplos de comando para efetuar login em uma região do {{site.data.keyword.containershort_notm}}:
  * AP Sul:
    ```
    bx cs init --host https://ap-south.containers.bluemix.net
    ```
    {: pre}

  * União Europeia Central:
    ```
    bx cs init --host https://eu-central.containers.bluemix.net
    ```
    {: pre}

  * Sul do Reino Unido:
    ```
    bx cs init --host https://uk-south.containers.bluemix.net
    ```
    {: pre}

  * Leste dos EUA:
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * Sul dos EUA:
    ```
    bx cs init --host https://us-south.containers.bluemix.net
    ```
    {: pre}

### Criando clusters lite em regiões de serviço de contêiner
{: #lite_regions}

É possível criar os clusters lite do Kubernetes nas regiões a seguir:
  * AP Sul
  * União Europeia Central
  * Sul do Reino Unido
  * SUL dos EUA

### Locais disponíveis para o serviço de contêiner
{: #locations}

Os locais são data centers que estão disponíveis em uma região.

  | Região | Localização | Cidade |
  |--------|----------|------|
  | AP Sul     | mel01, syd01, syd04        | Melbourne, Sydney |
  | União Europeia Central     | ams03, fra02        | Amsterdã, Frankfurt |
  | Sul do Reino Unido      | lon02, lon04         | Londres |
  | Leste dos EUA      | wdc06, wdc07        | Washington, DC |
  | SUL dos EUA     | dal10, dal12, dal13       | Dallas |

### Usando comandos da API do serviço de contêiner
{: #container_api}

Para interagir com a API do {{site.data.keyword.containershort_notm}}, insira o tipo de comando e anexe `/v1/command` ao terminal.

Exemplo de API `GET /clusters` no Sul dos EUA:
  ```
  GET https://us-south.containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Para visualizar a documentação sobre os comandos da API, anexe `swagger-api` ao terminal da região a ser visualizada.
  * Sul AP: https://ap-south.containers.bluemix.net/swagger-api/
  * UE Central: https://eu-central.containers.bluemix.net/swagger-api/
  * Sul do Reino Unido: https://uk-south.containers.bluemix.net/swagger-api/
  * Leste dos EUA: https://us-east.containers.bluemix.net/swagger-api/
  * Sul dos EUA: https://us-south.containers.bluemix.net/swagger-api/
