---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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
{{site.data.keyword.Bluemix}} é hospedado no mundo todo. Uma região é uma área geográfica que é acessada por um terminal. Os locais são data centers na região. Os serviços no {{site.data.keyword.Bluemix_notm}} podem ficar disponíveis globalmente ou dentro de uma região específica. Ao criar um cluster do Kubernetes no {{site.data.keyword.containerlong}}, seus recursos permanecem na região na qual você implementa o cluster.
{:shortdesc}

Regiões do [{{site.data.keyword.Bluemix_notm}} ](#bluemix_regions) diferem de regiões do [{{site.data.keyword.containershort_notm}} ](#container_regions).

![{{site.data.keyword.containershort_notm}} Regiões e data centers](/images/regions.png)

Regiões e data centers do {{site.data.keyword.containershort_notm}}

Regiões do {{site.data.keyword.containershort_notm}} suportadas:
  * AP Norte
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

Terminais de API de região do {{site.data.keyword.Bluemix_notm}} com comandos de login de exemplo:

  * Sul dos EUA e Leste dos EUA
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * Sydney e Norte AP
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

É possível acessar o {{site.data.keyword.containershort_notm}} por meio de um terminal global: `https://containers.bluemix.net/`.
* Para verificar em qual região do {{site.data.keyword.containershort_notm}} você está atualmente, execute `bx cs region`.
* Para recuperar uma lista de regiões disponíveis e seus terminais, execute `bx cs regions`.

Para usar a API com o terminal global, em todas as suas solicitações, passe o nome da região em um cabeçalho `X-Region`.
{: tip}

### Efetuando login em uma região de serviço de contêiner diferente
{: #container_login_endpoints}

É possível mudar locais usando a CLI do {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Talvez queira efetuar login em outra região do {{site.data.keyword.containershort_notm}} pelas razões a seguir:
  * Você criou serviços do {{site.data.keyword.Bluemix_notm}} ou imagens privadas do Docker em uma região e deseja utilizá-los com o {{site.data.keyword.containershort_notm}} em outra região.
  * Você deseja acessar um cluster em uma região diferente da região padrão do {{site.data.keyword.Bluemix_notm}} a que está conectado.

</br>

Para alternar rapidamente regiões, execute `bx cs region-set`.

### Usando comandos da API do serviço de contêiner
{: #containers_api}

Para interagir com a API do {{site.data.keyword.containershort_notm}}, insira o tipo de comando e anexe `/v1/command` no terminal global.
{:shortdesc}

Exemplo da API `GET /clusters`:
  ```
  GET https://containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

Para usar a API com o terminal global, em todas as suas solicitações, passe o nome da região em um cabeçalho `X-Region`. Para listar as regiões disponíveis, execute `bx cs regions`.
{: tip}

Para visualizar a documentação nos comandos da API, visualize [https://containers.bluemix.net/swagger-api/](https://containers.bluemix.net/swagger-api/).

## Locais disponíveis no {{site.data.keyword.containershort_notm}}
{: #locations}

Locais são data centers físicos que estão disponíveis em uma região do {{site.data.keyword.Bluemix_notm}}. Regiões são uma ferramenta conceitual para organizar locais e podem incluir locais (data centers) em diferentes países. A tabela a seguir exibe os locais disponíveis por região.
{:shortdesc}

| Região | Localização | Cidade |
|--------|----------|------|
| AP Norte | hkg02, seo01, sng01, tok02 | Hong Kong, Seul, Singapura, Tóquio |
| AP Sul     | mel01, syd01, syd04        | Melbourne, Sydney |
| União Europeia Central     | ams03, fra02, par01        | Amsterdã, Frankfurt, Paris |
| Sul do Reino Unido      | lon02, lon04         | Londres |
| Leste dos EUA      | mon01, tor01, wdc06, wdc07        | Montreal, Toronto, Washington DC |
| SUL dos EUA     | dal10, dal12, dal13, sao01       | Dallas, São Paulo |

Os recursos de seu cluster permanecem no local (data center) no qual o cluster é implementado. A imagem a seguir destaca o relacionamento de seu cluster em uma região de exemplo de Leste dos EUA:

1.  Os recursos de seu cluster, incluindo os nós principal e do trabalhador, estão no mesmo local em que você implementou o cluster. Quando você inicia ações de orquestração de contêiner local, como comandos `kubectl`, as informações são trocadas entre os nós principal e do trabalhador dentro do mesmo local.

2.  Se você configura outros recursos de cluster, como armazenamento, rede, cálculo ou apps em execução em pods, os recursos e seus dados permanecem no local em que você implementou seu cluster.

3.  Quando você inicia ações de gerenciamento de cluster, como usar comandos `bx cs`, informações básicas sobre o cluster (como nome, ID, usuário, o comando) são roteadas para um terminal regional.

![Entendendo onde seus recursos de cluster residem](/images/region-cluster-resources.png)

Entendendo onde seus recursos de cluster residem.

