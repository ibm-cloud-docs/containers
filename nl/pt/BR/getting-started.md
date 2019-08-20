---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, containers

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


# Introdução ao {{site.data.keyword.containerlong_notm}}
{: #getting-started}

Tenha sucesso desde o início com o {{site.data.keyword.containerlong}} implementando apps altamente disponíveis em contêineres do Docker que são executados em clusters do Kubernetes.
{:shortdesc}

Os contêineres são uma maneira padrão de empacotar apps e todas as suas dependências para que seja possível mover perfeitamente os apps entre ambientes. Ao contrário de máquinas virtuais, os contêineres não empacotam o sistema operacional. Somente o código de app, o tempo de execução, as ferramentas de sistema, as bibliotecas e as configurações são empacotados dentro de contêineres. Os contêineres são mais leves, móveis e eficientes do que máquinas virtuais.

## Introdução aos clusters
{: #clusters_gs}

Então você deseja implementar um app em um contêiner? Espere! Inicie criando um cluster do Kubernetes primeiro. Kubernetes é uma ferramenta de orquestração para contêineres. Com o Kubernetes, os desenvolvedores podem implementar apps altamente disponíveis em um flash usando o poder e a flexibilidade de clusters.
{:shortdesc}

E o que é um cluster? Um cluster é um conjunto de recursos, nós de trabalhador, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Após ter o seu cluster, é possível implementar seus apps em contêineres.

Antes de iniciar, obtenha o [tipo de conta do {{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/registration) adequado para você:
* **Faturável (Pagamento por uso ou Assinatura)**: é possível criar um cluster grátis. Também é possível provisionar recursos de infraestrutura do IBM Cloud para criar e usar em clusters padrão.
* **Lite**: não é possível criar um cluster grátis ou padrão. [Faça upgrade de sua conta](/docs/account?topic=account-accountfaqs#changeacct) para uma conta faturável.

Para criar um cluster grátis:

1.  No [catálogo do {{site.data.keyword.cloud_notm}}****![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/catalog?category=containers), selecione **{{site.data.keyword.containershort_notm}}** e clique em **Criar**. Uma página de configuração do cluster é aberta. Por padrão, o **grátis cluster** é selecionado.

2.  Forneça seu cluster um nome exclusivo.

3.  Clique em **Criar Cluster**. É criado um conjunto de trabalhadores que contém um nó do trabalhador. O nó do trabalhador pode demorar alguns minutos para provisionar, mas é possível ver o progresso na guia **Nós do trabalhador**. Quando o status atinge `Ready`, é possível começar a trabalhar com seu cluster!

<br>

Bom Trabalho! Você criou seu primeiro cluster do Kubernetes. Aqui estão alguns detalhes sobre seu cluster grátis:

*   **Tipo**: o cluster grátis possui um nó do trabalhador virtual que é agrupado em um conjunto de trabalhadores, com 2 CPU, 4 GB de memória e um único disco SAN de 100 GB disponível para usar seus aplicativos. Ao criar um cluster padrão, é possível escolher entre máquinas físicas (bare metal) ou virtuais, juntamente com vários tamanhos de máquina.
*   **Principal gerenciado**: o nó do trabalhador é monitorado e gerenciado centralmente por um mestre do Kubernetes dedicado e altamente disponível pertencente à {{site.data.keyword.IBM_notm}} que controla e monitora todos os recursos do Kubernetes no cluster. É possível concentrar-se em seu nó do trabalhador e nos apps implementados nele sem se preocupar também com o gerenciamento desse mestre.
*   **Recursos de infraestrutura**: os recursos que são necessários para executar o cluster, como VLANs e endereços IP, são gerenciados em uma conta de infraestrutura do IBM Cloud {{site.data.keyword.IBM_notm}}pertencente à IBM. Ao criar um cluster padrão, você gerencia esses recursos em sua própria conta de infraestrutura do IBM Cloud. É possível aprender mais sobre esses recursos e as [permissões que são necessárias](/docs/containers?topic=containers-users#infra_access) quando você cria um cluster padrão.
*   **Outras opções**: os clusters grátis são implementados dentro da região que você seleciona, mas não é possível escolher qual zona. Para controlar a zona, a rede e o armazenamento persistente, crie um cluster padrão. [Saiba mais sobre os benefícios de clusters grátis e padrão](/docs/containers?topic=containers-cs_ov#cluster_types).

<br>

**O que vem a seguir?**</br>
Experimente algumas coisas com seu cluster grátis antes de expirar.

* Acesse o [tutorial do {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial) para instalar a CLI ou usar o terminal Kubernetes, criando um registro privado, configurando seu ambiente de cluster, incluindo um serviço em seu cluster e implementando um aplicativo {{site.data.keyword.watson}}.
* [Crie um cluster padrão](/docs/containers?topic=containers-clusters#clusters_ui) com múltiplos nós para disponibilidade mais alta.
* Experimente um [{{site.data.keyword.openshifshort}} cluster](/docs/openshift?topic=openshift-openshift_tutorial).


