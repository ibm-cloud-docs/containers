---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Com o {{site.data.keyword.Bluemix_notm}} Public, é possível criar clusters do Kubernetes ou migrar grupos de contêineres únicos e escaláveis para clusters. Com o {{site.data.keyword.Bluemix_dedicated_notm}}, clique neste ícone para ver suas opções." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Introdução aos clusters do Kubernetes em{{site.data.keyword.Bluemix_notm}}" title="Introdução aos clusters do Kubernetes em{{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="Executando contêineres únicos e escaláveis em {{site.data.keyword.containershort_notm}}" title="Executando contêineres únicos e escaláveis em{{site.data.keyword.containershort_notm}}" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="Ambiente em nuvem do {{site.data.keyword.Bluemix_dedicated_notm}}" title="Ambiente em nuvem do {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="326, -10, 448, 218" />
</map>


## Introdução aos clusters
{: #clusters}

Então você deseja implementar um app em contêiner? Espere! Inicie criando um cluster do Kubernetes primeiro. Kubernetes é uma ferramenta de orquestração para contêineres. Com o Kubernetes, os desenvolvedores podem implementar apps altamente disponíveis em um flash usando o poder e a flexibilidade de clusters.
{:shortdesc}

E o que é um cluster? Um cluster é um conjunto de recursos, nós de trabalhador, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Após ter o seu cluster, é possível implementar seus apps em contêineres.


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
*   **Dica:** com uma conta {{site.data.keyword.Bluemix_notm}} Lite, é possível criar 1 cluster Lite com 2 CPUs e 4 GB de RAM e integrá-lo com serviços Lite. Para criar mais clusters, ter diferentes tipos de máquina e usar serviços integrais, [faça upgrade para uma conta {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go](/docs/pricing/billable.html#upgradetopayg).


**O que Vem a Seguir?**

Quando o cluster estiver funcionando, comece a fazer algo com o seu cluster.

* [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
* [Implementar um app no cluster.](cs_apps.html#cs_apps_cli)
* [Crie um cluster padrão com múltiplos
nós para disponibilidade mais alta.](cs_cluster.html#cs_cluster_ui)
* [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)


## Introdução aos clusters no {{site.data.keyword.Bluemix_dedicated_notm}} (Beta encerrado)
{: #dedicated}

Kubernetes é uma ferramenta de orquestração para planejar contêineres de app em um cluster de
máquinas de cálculo. Com o Kubernetes, os desenvolvedores poderão desenvolver rapidamente aplicativos altamente disponíveis usando o poder e a flexibilidade de contêineres em sua instância do {{site.data.keyword.Bluemix_dedicated_notm}}.
{:shortdesc}

Antes de iniciar, [configure seu ambiente {{site.data.keyword.Bluemix_dedicated_notm}} para usar clusters](cs_ov.html#setup_dedicated). Em seguida, será
possível criar um cluster. Um cluster é um conjunto de nós do trabalhador organizados em uma rede. O propósito do cluster é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantenham os aplicativos altamente disponíveis. Depois que você tiver um cluster, será possível implementar seu app nele.

**Dica:** se sua organização ainda não tem um ambiente {{site.data.keyword.Bluemix_dedicated_notm}}, talvez você não precise de um. [Tente primeiro um cluster padrão
dedicado no ambiente do {{site.data.keyword.Bluemix_notm}} Public.](cs_cluster.html#cs_cluster_ui)

Para implementar um cluster no {{site.data.keyword.Bluemix_dedicated_notm}}:

1.  Efetue login no console do {{site.data.keyword.Bluemix_notm}} Public ([https://console.bluemix.net ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/catalog/?category=containers)) com seu IBMid. Embora deva-se solicitar um cluster do {{site.data.keyword.Bluemix_notm}} Public, você o está implementando em sua conta do {{site.data.keyword.Bluemix_dedicated_notm}}.
2.  Se você tiver múltiplas contas, no menu de conta, selecione uma conta do {{site.data.keyword.Bluemix_notm}}.
3.  No catálogo, na categoria **Contêineres**, clique em **Cluster do Kubernetes**.
4.  Insira os detalhes do cluster.
    1.  Insira um **Nome do cluster**.
    2.  Selecione uma **Versão do Kubernetes** para usar nos nós do trabalhador. 
    3.  Selecione um **Tipo de máquina**. O tipo de máquina define a quantia de CPU e memória virtual que é configurada em cada nó do trabalhador e que está disponível para todos os contêineres que você implementar em seus nós.
    4.  Escolha o **Número de nós do trabalhador** que você precisa. Selecione 3 para maior disponibilidade de seu cluster.

    O tipo de cluster, o local, a VLAN pública, a VLAN privada e os campos de hardware são definidos durante o processo de criação da conta do {{site.data.keyword.Bluemix_dedicated_notm}}, então não é possível ajustar esses valores.
5.  Clique em **Criar Cluster**. Os detalhes para o cluster são abertos, mas os nós do trabalhador no cluster levam alguns minutos para provisão. É possível ver o status dos nós do trabalhador na guia **Nós do
trabalhador**. Quando o status atingir `Pronto`, seus nós do trabalhador estarão prontos para serem usados.

    Os nós do trabalhador são monitorados e gerenciados centralmente por um mestre do Kubernetes dedicado e altamente disponível pertencente à {{site.data.keyword.IBM_notm}} que controla e monitora todos os recursos do Kubernetes no cluster. É possível concentrar-se nos nós do trabalhador e nos
apps implementados neles sem também se preocupar com o gerenciamento desse mestre.

Bom Trabalho! Você criou seu primeiro cluster!


**O que Vem a Seguir?**

Quando o cluster estiver ativo e em execução, será possível verificar as tarefas a seguir.

* [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
* [Implementar um app em seu cluster.](cs_apps.html#cs_apps_cli)
* [Incluir serviços do {{site.data.keyword.Bluemix_notm}} em seu cluster.](cs_cluster.html#binding_dedicated)
* [Aprenda sobre as diferenças entre clusters no {{site.data.keyword.Bluemix_dedicated_notm}} e Public.](cs_ov.html#env_differences)

