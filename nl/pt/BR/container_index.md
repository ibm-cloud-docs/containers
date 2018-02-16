---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Introdução ao {{site.data.keyword.containerlong_notm}}
{: #container_index}

Tenha sucesso desde o início com o {{site.data.keyword.Bluemix_notm}} implementando apps altamente disponíveis em contêineres do Docker que são executados em clusters do Kubernetes. Os contêineres são uma maneira padrão de empacotar apps e todas as suas dependências para que seja possível mover perfeitamente os apps entre ambientes. Ao contrário de máquinas virtuais, os contêineres não empacotam o sistema operacional. Somente o código de app, o tempo de execução, as ferramentas de sistema, as bibliotecas e as configurações são empacotados dentro de contêineres. Os contêineres são mais leves, móveis e eficientes do que máquinas virtuais.
{:shortdesc}


Clique em uma opção para começar:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Clique em um ícone para inicir rapidamente com o{{site.data.keyword.containershort_notm}}. Com o {{site.data.keyword.Bluemix_dedicated_notm}}, clique neste ícone para ver suas opções." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Introdução aos clusters do Kubernetes em{{site.data.keyword.Bluemix_notm}}" title="Introdução aos clusters do Kubernetes em{{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Instalar as CLIs." title="Instalar as CLIs." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} ambiente de nuvem" title="{{site.data.keyword.Bluemix_notm}} ambiente de nuvem" shape="rect" coords="326, -10, 448, 218" />
</map>


## Introdução aos clusters
{: #clusters}

Então você deseja implementar um app em contêiner? Espere! Inicie criando um cluster do Kubernetes primeiro. Kubernetes é uma ferramenta de orquestração para contêineres. Com o Kubernetes, os desenvolvedores podem implementar apps altamente disponíveis em um flash usando o poder e a flexibilidade de clusters.
{:shortdesc}

E o que é um cluster? Um cluster é um conjunto de recursos, nós de trabalhador, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Após ter o seu cluster, é possível implementar seus apps em contêineres.

[Antes de iniciar, deve-se ter uma conta Pay-As-You-Go ou de Assinatura do {{site.data.keyword.Bluemix_notm}} para criar um cluster lite.](https://console.bluemix.net/registration/)


Para criar um cluster lite:

1.  No [**catálogo** ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/catalog/?category=containers), na categoria **Contêineres**, clique em **Cluster do Kubernetes**.

2.  Insira um **Nome do cluster**. O tipo de cluster padrão é lite. Na próxima vez, será possível criar um cluster padrão e definir customizações adicionais, como quantos
nós do trabalhador estão no cluster.

3.  Clique em **Criar Cluster**. Os detalhes para o cluster são abertos, mas o nó do trabalhador no cluster leva alguns minutos para
provisão. É possível ver o status do nó do trabalhador na guia **Nós do trabalhador**. Quando o status atingir `Pronto`, seu nó do trabalhador estará pronto para ser usado.

Bom Trabalho! Você criou seu primeiro cluster!

*   O cluster lite tem um nó do trabalhador com 2 CPUs e 4 GB de memória disponíveis para seus apps usarem.
*   O nó do trabalhador é monitorado e gerenciado centralmente por um mestre do Kubernetes dedicado e altamente disponível pertencente à {{site.data.keyword.IBM_notm}} que controla e monitora todos os recursos do Kubernetes no cluster. É possível concentrar-se em seu nó do trabalhador e nos apps implementados nele sem se preocupar também com o gerenciamento desse mestre.
*   Os recursos que são necessários para executar o cluster, como VLANS e endereços IP, são gerenciados em uma conta de infraestrutura do IBM Cloud (SoftLayer) de propriedade da {{site.data.keyword.IBM_notm}}. Ao criar um cluster padrão, você gerencia esses recursos em sua própria conta de infraestrutura do IBM Cloud (SoftLayer). É possível aprender mais sobre esses
recursos quando você cria um cluster padrão.


**O que Vem a Seguir?**

Quando o cluster estiver funcionando, comece a fazer algo com o seu cluster.

* [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
* [Implementar um app no cluster.](cs_app.html#app_cli)
* [Crie um cluster padrão com múltiplos
nós para disponibilidade mais alta.](cs_clusters.html#clusters_ui)
* [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)
