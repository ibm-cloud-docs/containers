---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Por que o {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

O {{site.data.keyword.containerlong}} entrega ferramentas poderosas, combinando contêineres do Docker, a tecnologia do Kubernetes, uma experiência do usuário intuitiva e segurança e isolamento integrados para automatizar a implementação, a operação, o ajuste de escala e o monitoramento de apps conteinerizados em um cluster de hosts de cálculo.
{:shortdesc}


## Benefícios de usar o serviço
{: #benefits}

Os clusters são implementados em hosts de cálculo que fornecem Kubernetes nativos e recursos específicos do {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Benefício|Descrição|
|-------|-----------|
|Clusters do Kubernetes de locatário único com isolamento de infraestrutura de cálculo, de rede e de armazenamento|<ul><li>Crie sua própria infraestrutura customizada que atenda aos requisitos de sua organização.</li><li>Provisione um mestre do Kubernetes dedicado e seguro, nós do trabalhador, redes virtuais e armazenamento usando os recursos fornecidos pela infraestrutura do IBM Cloud (SoftLayer).</li><li>O mestre do Kubernetes totalmente gerenciado que é continuamente monitorado e atualizado pelo {{site.data.keyword.IBM_notm}} para manter seu cluster disponível.</li><li>Opção para provisionar nós do trabalhador como servidores bare metal com Cálculo confiável.</li><li>Armazene dados persistentes, compartilhar dados entre pods do Kubernetes e restaure dados quando necessário com o
serviço de volume integrado e seguro.</li><li>Benefício do suporte integral para todas as APIs nativas do Kubernetes.</li></ul>|
| Clusters Multizone para Aumentar a Alta Disponibilidade | <ul><li>Gerencie facilmente os nós do trabalhador do mesmo tipo de máquina (CPU, memória, virtual ou física) com conjuntos de trabalhadores.</li><li>Proteja contra a falha de zona difundindo os nós uniformemente entre as múltiplas zonas selecionadas e usando implementações de pod de antiafinidade para seus apps.</li><li>Diminua seus custos usando os clusters de múltiplas zonas em vez de duplicar os recursos em um cluster separado.</li><li>Beneficie-se do balanceamento automático de carga entre apps com o multizone load balancer (MZLB) que é configurado automaticamente para você em cada zona do cluster.</li></ul>|
|Conformidade de segurança de imagem com o Vulnerability Advisor|<ul><li>Configure seu próprio repositório em nosso registro de imagem privada do Docker protegido em que as imagens são armazenadas e compartilhadas por todos os usuários na organização.</li><li>Benefício de varredura automática de imagens em seu registro privado do {{site.data.keyword.Bluemix_notm}}.</li><li>Revise as recomendações específicas para o sistema operacional usado na imagem para corrigir potenciais
vulnerabilidades.</li></ul>|
|Monitoramento contínuo do funcionamento do cluster|<ul><li>Use o painel de cluster para ver e gerenciar rapidamente o funcionamento de seu cluster, os nós do trabalhador
e as implementações de contêiner.</li><li>Localize métricas detalhadas de consumo usando o {{site.data.keyword.monitoringlong}} e expanda rapidamente o seu cluster para atender cargas de trabalho.</li><li>Revise as informações de criação de log usando o {{site.data.keyword.loganalysislong}} para ver atividades detalhadas do cluster.</li></ul>|
|Exposição segura de apps ao público|<ul><li>Escolha entre um endereço IP público, uma rota fornecida pela {{site.data.keyword.IBM_notm}} ou seu próprio domínio customizado para acessar serviços em seu cluster por meio da Internet.</li></ul>|
|Integração de serviço do {{site.data.keyword.Bluemix_notm}}|<ul><li>Inclua recursos extras no app por meio da integração de serviços do {{site.data.keyword.Bluemix_notm}}, como APIs do Watson, Blockchain, serviços de dados ou Internet of Things.</li></ul>|
{: caption="Benefícios do {{site.data.keyword.containerlong_notm}}" caption-side="top"}

Pronto para começar? Experimente o [tutorial de criação de um cluster do Kubernetes](cs_tutorials.html#cs_cluster_tutorial).

<br />


## Comparação de ofertas e suas combinações
{: #differentiation}

É possível executar o {{site.data.keyword.containerlong_notm}} no {{site.data.keyword.Bluemix_notm}} Public ou Dedicated, no {{site.data.keyword.Bluemix_notm}} Private ou em uma configuração híbrida.
{:shortdesc}


<table>
<caption>Diferenças entre configurações do {{site.data.keyword.containerlong_notm}}</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>Configuração do {{site.data.keyword.containerlong_notm}}</th>
 <th>Descrição</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>Com o {{site.data.keyword.Bluemix_notm}} Public no [hardware compartilhado ou dedicado ou em máquinas bare metal](cs_clusters_planning.html#shared_dedicated_node), é possível hospedar seus apps em clusters na nuvem usando o {{site.data.keyword.containerlong_notm}}. Também é possível criar um cluster com conjuntos de trabalhadores em múltiplas zonas para aumentar a alta disponibilidade para os seus apps. O {{site.data.keyword.containerlong_notm}} no {{site.data.keyword.Bluemix_notm}} Public entrega ferramentas poderosas, combinando contêineres do Docker, a tecnologia do Kubernetes, uma experiência do usuário intuitiva e segurança integrada e isolamento para automatizar a implementação, a operação, o ajuste de escala e o monitoramento de apps conteinerizados em um cluster de hosts de cálculo.<br><br>Para obter mais informações, veja  [ {{site.data.keyword.containerlong_notm}}  tecnologia ](cs_tech.html).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicado
 </td>
 <td>O {{site.data.keyword.Bluemix_notm}} Dedicated oferece os mesmos recursos do {{site.data.keyword.containerlong_notm}} na nuvem que o {{site.data.keyword.Bluemix_notm}} Public. No entanto, com uma conta do {{site.data.keyword.Bluemix_notm}} Dedicated, os [recursos físicos disponíveis são dedicados somente a seu cluster](cs_clusters_planning.html#shared_dedicated_node) e não são compartilhados com clusters de outros clientes {{site.data.keyword.IBM_notm}}. Você pode optar por configurar um ambiente do {{site.data.keyword.Bluemix_notm}} Dedicated quando requerer isolamento para seu cluster e os outros serviços do {{site.data.keyword.Bluemix_notm}} usados.<br><br>Para obter mais informações, veja [Introdução aos clusters no {{site.data.keyword.Bluemix_notm}} Dedicated](cs_dedicated.html#dedicated).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Privado
 </td>
 <td>O {{site.data.keyword.Bluemix_notm}} Private é uma plataforma de aplicativo que pode ser instalada localmente em suas próprias máquinas. Você pode optar por usar o {{site.data.keyword.containerlong_notm}} no {{site.data.keyword.Bluemix_notm}} Private quando precisar desenvolver e gerenciar apps conteinerizados no local, em seu próprio ambiente controlado protegido por um firewall. <br><br>Para obter mais informações, consulte a [documentação do produto {{site.data.keyword.Bluemix_notm}} Private ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
 </td>
 </tr>
 <tr>
 <td>Configuração híbrida
 </td>
 <td>Híbrido é o uso combinado de serviços que são executados no {{site.data.keyword.Bluemix_notm}} Public ou Dedicated e outros serviços que são executados no local, como um app no {{site.data.keyword.Bluemix_notm}} Private. Exemplos para uma configuração híbrida: <ul><li>Provisionando um cluster com o {{site.data.keyword.containerlong_notm}} no {{site.data.keyword.Bluemix_notm}} Public, mas conectando esse cluster a um banco de dados no local.</li><li>Provisionando um cluster com o {{site.data.keyword.containerlong_notm}} no {{site.data.keyword.Bluemix_notm}} Private e implementando um app nesse cluster. No entanto, esse app pode usar um serviço {{site.data.keyword.ibmwatson}}, como o {{site.data.keyword.toneanalyzershort}}, no {{site.data.keyword.Bluemix_notm}} Public.</li></ul><br>Para ativar a comunicação entre os serviços que estão em execução no {{site.data.keyword.Bluemix_notm}} Public ou Dedicated e serviços que estão em execução no local, deve-se [configurar uma conexão VPN](cs_vpn.html). Para obter mais informações, consulte [Usando o {{site.data.keyword.containerlong_notm}} com o {{site.data.keyword.Bluemix_notm}} Private](cs_hybrid.html).
 </td>
 </tr>
 </tbody>
</table>

<br />


## Comparação de clusters grátis e padrão
{: #cluster_types}

É possível criar um cluster grátis ou qualquer número de clusters padrão. Experimente os clusters grátis para familiarizar-se com alguns recursos do Kubernetes ou crie clusters padrão para usar os recursos integrais de Kubernetes para implementar apps. Os clusters grátis são excluídos automaticamente após 30 dias.
{:shortdesc}

Se você tiver um cluster grátis e desejar fazer upgrade para um cluster padrão, será possível [criar um cluster padrão](cs_clusters.html#clusters_ui). Em seguida, implemente quaisquer YAMLs para os recursos do Kubernetes que você fez com seu cluster grátis no cluster padrão.

|Características|Clusters grátis|Clusters padrão|
|---------------|-------------|-----------------|
|[Rede em cluster](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app de rede pública por um serviço NodePort para um endereço IP não estável](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Gerenciamento de acesso do usuário](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Acesso ao serviço {{site.data.keyword.Bluemix_notm}} do cluster e apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Espaço em disco no nó do trabalhador para armazenamento não persistente](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
| [Capacidade para criar cluster em cada região do {{site.data.keyword.containerlong_notm}}](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" /> |
|[Clusters de múltiplas zonas para aumentar a alta disponibilidade do app](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Armazenamento persistente baseado em arquivo NFS com volumes](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Acesso ao app de rede pública ou privada por um serviço de balanceador de carga para um endereço IP estável](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Acesso ao app de rede pública por um serviço de Ingresso para um endereço IP estável e URL customizável](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Endereços IP públicos móveis](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Criando log e monitorando](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Opção para provisionar os nós do trabalhador em servidores físicos (bare metal)](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Opção para provisionar trabalhadores bare metal com Cálculo Confiável](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|[Disponível no {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
{: caption="Características de clusters grátis e padrão" caption-side="top"}

<br />




{: #responsibilities}
**Nota**: procurando suas responsabilidades e termos do {{site.data.keyword.containerlong}} quando você usa o serviço?

{: #terms}
Veja  [ Responsabilidades do {{site.data.keyword.containerlong_notm}}  ](cs_responsibilities.html).
