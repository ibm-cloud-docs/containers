---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks

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


# Regiões e Zonas
{: #regions-and-zones}

Uma região é uma localização geográfica específica na qual é possível implementar apps, serviços e outros recursos do {{site.data.keyword.Bluemix}}. [ {{site.data.keyword.Bluemix_notm}}  regiões ](#bluemix_regions)  diferem de  [ {{site.data.keyword.containerlong}}  regiões ](#container_regions). As regiões consistem em uma ou mais zonas, que são data centers físicos que hospedam os recursos de cálculo, rede e armazenamento e o resfriamento e energia relacionados que hospedam serviços e aplicativos. As zonas são isoladas umas das outras, o que assegura nenhum ponto único de falha compartilhado.
{:shortdesc}

![{} regions and zones](images/regions-mz.png)

_Regiões e zonas do {{site.data.keyword.containerlong_notm}}_

 {{site.data.keyword.Bluemix_notm}} é hospedado no mundo todo. Os serviços no {{site.data.keyword.Bluemix_notm}} podem ficar disponíveis globalmente ou dentro de uma região específica. Ao criar um cluster do Kubernetes no {{site.data.keyword.containerlong_notm}}, seus recursos permanecem na região na qual você implementa o cluster.

 É possível criar clusters padrão em cada região suportada do {{site.data.keyword.containerlong_notm}}. Os clusters grátis estão disponíveis somente em regiões selecionadas.
{: note}

 | Região do {{site.data.keyword.containerlong_notm}} | Local do {{site.data.keyword.Bluemix_notm}} correspondente |
| --- | --- |
| AP Norte (somente clusters padrão) | Tóquio |
| AP Sul | Sydney |
| União Europeia Central | Frankfurt |
| Sul do Reino Unido | Londres |
| Leste dos EUA (somente clusters padrão) | Washington DC |
| SUL dos EUA | Dallas |
{: caption="As regiões de serviço do Kubernetes suportadas e as localizações do IBM Cloud correspondentes." caption-side="top"}

 <br />


## Localizações no {{site.data.keyword.Bluemix_notm}}
{: #bluemix_regions}

É possível organizar seus recursos em serviços do {{site.data.keyword.Bluemix_notm}} usando locais do {{site.data.keyword.Bluemix_notm}}, também chamados regiões. Por exemplo, é possível criar um cluster do Kubernetes usando uma imagem privada do Docker que é armazenada em seu {{site.data.keyword.registryshort_notm}} do mesmo local.
{:shortdesc}

É possível especificar uma região do {{site.data.keyword.Bluemix_notm}} quando você efetua login no terminal de API global. Para listar regiões disponíveis, execute `ibmcloud regions`. Para verificar em qual {{site.data.keyword.Bluemix_notm}} localização você está atualmente, execute `ibmcloud target` e revise o campo **Região**. Se você não especificar uma região, será solicitado a selecionar uma.

Por exemplo, para efetuar login no terminal de API global na região de Dallas (`us-south`):
```
ibmcloud login -a https://cloud.ibm.com -r us-south
```
{: pre}

Para efetuar login no terminal de API global e selecionar uma região:
```
ibmcloud login -a https://cloud.ibm.com
```
{: pre}

Saída de exemplo:
```
API endpoint: cloud.ibm.com

Get One Time Code from https://identity-2.eu-central.iam.cloud.ibm.com/identity/passcode to proceed.
Open the URL in the default browser? [ S/n ] >y
Um Código de Tempo >
Autenticando ...
OK

Selecione uma conta: 1. MyAccount (00a11aa1a11aa11a1111a1111aaa1111aaa11aa) <-> 1234567 2. TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321
Enter a number> 2
Targeted account TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321


Padrão do grupo de recursos destinado

Select a region (or press enter to skip):
1. au-syd 2. jp-tok 3. eu-de 4. eu-gb 5. us-south 6. us-east
Enter a number> 5
Targeted region us-south


API endpoint:      https://cloud.ibm.com
Region:            us-south
User:              first.last@email.com
Account:           TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321
Resource group:    default
CF API endpoint:
Org:
Space:

...
```
{: screen}

<br />


## Regiões no  {{site.data.keyword.containerlong_notm}}
{: #container_regions}

Usando regiões do {{site.data.keyword.containerlong_notm}}, é possível criar ou acessar clusters do Kubernetes em uma região diferente da região do {{site.data.keyword.Bluemix_notm}} que você está com login efetuado. Os terminais de região do {{site.data.keyword.containerlong_notm}} referem-se especificamente ao {{site.data.keyword.containerlong_notm}}, não ao {{site.data.keyword.Bluemix_notm}} como um todo.
{:shortdesc}

É possível criar clusters padrão em cada região suportada do {{site.data.keyword.containerlong_notm}}. Os clusters grátis estão disponíveis somente em regiões selecionadas.
{: note}

 Regiões do {{site.data.keyword.containerlong_notm}} suportadas:
  * AP Norte (somente clusters padrão)
  * AP Sul
  * União Europeia Central
  * Sul do Reino Unido
  * Leste dos EUA (somente clusters padrão)
  * SUL dos EUA

É possível acessar o {{site.data.keyword.containerlong_notm}} por meio de um terminal global: `https://containers.cloud.ibm.com/v1`.
* Para verificar em qual região do {{site.data.keyword.containerlong_notm}} você está atualmente, execute `ibmcloud ks region`.
* Para recuperar uma lista de regiões disponíveis e os seus terminais, execute `ibmcloud ks regions`.

Para usar a API com o terminal global em todas as suas solicitações, passe o nome da região no cabeçalho `X-Region`.
{: tip}

### Efetuando login em uma região  {{site.data.keyword.containerlong_notm}}  diferente
{: #container_login_endpoints}

É possível mudar regiões usando a CLI do {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Talvez queira efetuar login em outra região do {{site.data.keyword.containerlong_notm}} pelas razões a seguir:
  * Você criou serviços do {{site.data.keyword.Bluemix_notm}} ou imagens privadas do Docker em uma região e deseja utilizá-los com o {{site.data.keyword.containerlong_notm}} em outra região.
  * Você deseja acessar um cluster em uma região que é diferente da região padrão do {{site.data.keyword.Bluemix_notm}} à qual está conectado.

Para alternar regiões rapidamente, execute [`ibmcloud ks region-set`](/docs/containers?topic=containers-cs_cli_reference#cs_region-set).

### Usando comandos da API {{site.data.keyword.containerlong_notm}}
{: #containers_api}

Para interagir com a API do {{site.data.keyword.containerlong_notm}}, insira o tipo de comando e anexe `/v1/command` no terminal global.
{:shortdesc}

 Exemplo da API `GET /clusters`:
  ```
  GET https://containers.cloud.ibm.com/v1/clusters
  ```
  {: codeblock}

 </br>

Para usar a API com o terminal global em todas as suas solicitações, passe o nome da região no cabeçalho `X-Region`. Para listar as regiões disponíveis, execute `ibmcloud ks regions`.
{: tip}

Para visualizar a documentação sobre os comandos da API, visualize [https://containers.cloud.ibm.com/swagger-api/](https://containers.cloud.ibm.com/swagger-api/).

## Zonas no  {{site.data.keyword.containerlong_notm}}
{: #zones}

Zonas são data centers físicos que estão disponíveis em uma região do {{site.data.keyword.Bluemix_notm}}. Regiões são uma ferramenta conceitual para organizar zonas e podem incluir zonas (data centers) em diferentes países. A tabela a seguir exibe as zonas disponíveis por região.
{:shortdesc}

* **Local metro multizona**: se você criar um cluster em um local metro multizona, as réplicas de seu principal do Kubernetes altamente disponível serão automaticamente difundidas entre as zonas. Você tem a opção de difundir os nós do trabalhador por meio de zonas para proteger seus apps de uma falha de zona.
* **Local de zona única**: se você criar um cluster em um local de zona única, será possível criar diversos nós do trabalhador, mas não será possível espalhá-los pelas zonas. O mestre altamente disponível inclui três réplicas em hosts separados, mas não se difunde entre zonas.

<table summary="A tabela mostra as zonas disponíveis por regiões. As linhas devem ser lidas da esquerda para a direita, com a região na coluna um, os locais metro multizona na coluna dois e os locais de zona única na coluna três.">
<caption>Disponível e multisona disponível por região.</caption>
  <thead>
  <th>Região</th>
  <th>Local metro multizona</th>
  <th>Local de zona única</th>
  </thead>
  <tbody>
    <tr>
      <td>AP Norte</td>
      <td>Tóquio: tok02, tok04, tok05</td>
      <td><p>Chennai: che01</p>
      <p>Hong Kong S.A.R. of the PRC: hkg02</p>
      <p>Seul: seo01</p>
      <p>Singapura: sng01</p></td>
    </tr>
    <tr>
      <td>AP Sul</td>
      <td>Sydney: syd01, syd04, syd05</td>
      <td>Melbourne: mel01</td>
    </tr>
    <tr>
      <td>União Europeia Central</td>
      <td>Frankfurt: fra02, fra04, fra05</td>
      <td><p>Amsterdã: ams03</p>
      <p>Milão: mil01</p>
      <p>Oslo: osl01</p>
      <p>Paris: par01</p>
      </td>
    </tr>
    <tr>
      <td>Sul do Reino Unido</td>
      <td>Londres: lon04, lon05 `*`, lon06</td>
      <td></td>
    </tr>
    <tr>
      <td>Leste dos EUA</td>
      <td>Washington DC: wdc04, wdc06, wdc07</td>
      <td><p>Montreal: mon01</p>
      <p>Toronto: tor01</p></td>
    </tr>
    <tr>
      <td>SUL dos EUA</td>
      <td>Dallas: dal10, dal12, dal13</td>
      <td><p>México: mex01</p><p>San Jose: sjc03, sjc04</p><p>São Paulo: sao01</p></td>
    </tr>
  </tbody>
</table>

` * `  lon05 substitui lon02. Os novos clusters devem usar lon05 e somente lon05 suporta difusão de mestres altamente disponíveis entre zonas.
{: note}

### Clusters de zona única
{: #regions_single_zone}

Em um cluster de zona única, os recursos de seu cluster permanecem na zona na qual o cluster é implementado. A imagem a seguir destaca o relacionamento de componentes de cluster de zona única em uma região de exemplo do Leste dos EUA:

<img src="/images/region-cluster-resources.png" width="650" alt="Understanding where your cluster resources reside" style="width:650px; border-style: none"/>

_Entendendo em que local estão os seus recursos de cluster de zona única._

1.  Os recursos de seu cluster, incluindo os nós principal e do trabalhador, estão na mesma zona na qual você implementou o cluster. Quando você inicia ações de orquestração de contêiner local, como comandos `kubectl`, as informações são trocadas entre os nós principal e do trabalhador dentro da mesma zona.

2.  Se você configurar outros recursos de cluster, como armazenamento, rede, cálculo ou apps em execução em pods, os recursos e seus dados permanecerão na zona na qual você implementou o cluster.

3.  Quando você inicia ações de gerenciamento de cluster, como usar os comandos `ibmcloud ks`, as informações básicas sobre o cluster (como nome, ID, usuário, o comando) são roteadas por meio de um terminal regional.

### Clusters de múltiplas zonas
{: #regions_multizone}

Em um cluster de múltiplas zonas, o nó principal é implementado em uma zona com capacidade de múltiplas zonas e os recursos de seu cluster são difundidos entre múltiplas zonas.

1.  Os nós do trabalhador são difundidos em múltiplas zonas em uma região para fornecer mais disponibilidade para seu cluster. O mestre permanece na mesma zona com capacidade de múltiplas zonas na qual você implementou o cluster. Quando você inicia as ações de orquestração de contêiner local, como comandos `kubectl`, as informações são trocadas entre os nós principal e do trabalhador por meio de um terminal regional.

2.  Outros recursos de cluster, como armazenamento, rede, cálculo ou apps em execução em pods, variam em como são implementados nas zonas em seu cluster de múltiplas zonas. Para obter mais informações, revise estes tópicos:
  * Configurando o [armazenamento de arquivo](/docs/containers?topic=containers-file_storage#add_file) e o [armazenamento de bloco](/docs/containers?topic=containers-block_storage#add_block) em clusters de múltiplas zonas
  * [ Ativando o acesso público ou privado a um app usando um serviço LoadBalancer em um cluster de múltiplas zonas](/docs/containers?topic=containers-loadbalancer#multi_zone_config)
  * [ Gerenciando o tráfego de rede usando o Ingresso ](/docs/containers?topic=containers-ingress#planning)
  * [Aumentando a disponibilidade de seu app](/docs/containers?topic=containers-app#increase_availability)

3.  Quando você inicia ações de gerenciamento de cluster, como o uso de [comandos `ibmcloud ks`](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference), informações básicas sobre o cluster (como o nome, o ID, o usuário e o comando) são roteadas por meio de um terminal regional.




