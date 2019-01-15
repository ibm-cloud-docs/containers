---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# Por que o {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

O {{site.data.keyword.containerlong}} entrega ferramentas poderosas, combinando contêineres do Docker, a tecnologia do Kubernetes, uma experiência do usuário intuitiva e segurança e isolamento integrados para automatizar a implementação, a operação, o ajuste de escala e o monitoramento de apps conteinerizados em um cluster de hosts de cálculo. Para obter informações de certificação, consulte [Conformidade no {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/compliance).
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
| Mestres altamente disponíveis | <ul>Disponível em clusters que executam o Kubernetes versão 1.10 ou mais recente.<li>Reduza o tempo de inatividade do cluster, por exemplo, durante as atualizações principais com os mestres altamente disponíveis que são provisionados automaticamente ao criar um cluster.</li><li>Espalhe seus mestres em zonas em um [cluster de várias zonas](cs_clusters_planning.html#multizone) para proteger seu cluster contra falhas de zonas.</li></ul> |
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
 <td>O {{site.data.keyword.Bluemix_notm}} Private é uma plataforma de aplicativo que pode ser instalada localmente em suas próprias máquinas. Você pode escolher usar o Kubernetes no {{site.data.keyword.Bluemix_notm}} Private quando precisar desenvolver e gerenciar apps conteinerizados no local em seu próprio ambiente controlado atrás de um firewall. <br><br>Para obter mais informações, consulte a [documentação do produto {{site.data.keyword.Bluemix_notm}} Private ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
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
|[Gerenciamento de acesso do usuário](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao serviço {{site.data.keyword.Bluemix_notm}} do cluster e apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Espaço em disco no nó do trabalhador para armazenamento não persistente](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
| [Capacidade para criar cluster em cada região do {{site.data.keyword.containerlong_notm}}](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" /> |
|[Clusters de múltiplas zonas para aumentar a alta disponibilidade do app](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
| Mestres replicados para disponibilidade mais alta (Kubernetes 1.10 ou mais recente) | | <img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" /> |
|[Número escalável de nós do trabalhador para aumentar a capacidade](cs_app.html#app_scaling)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Armazenamento persistente baseado em arquivo NFS com volumes](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app de rede pública ou privada por um serviço de balanceador de carga para um endereço IP estável](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app de rede pública por um serviço de Ingresso para um endereço IP estável e URL customizável](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Endereços IP públicos móveis](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Criando log e monitorando](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Opção para provisionar os nós do trabalhador em servidores físicos (bare metal)](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Opção para provisionar trabalhadores bare metal com Cálculo Confiável](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Disponível no {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
{: caption="Características de clusters grátis e padrão" caption-side="top"}

<br />




## Precificação e faturamento
{: #pricing}

Revise algumas perguntas mais frequentes sobre precificação e faturamento do {{site.data.keyword.containerlong_notm}}. Para perguntas de nível de conta, consulte [Gerenciamento docs de faturamento e uso](/docs/billing-usage/how_charged.html#charges). Para obter detalhes sobre seus contratos de conta, consulte os [Termos e avisos do {{site.data.keyword.Bluemix_notm}}](/docs/overview/terms-of-use/notices.html#terms) apropriados.
{: shortdesc}

### Como posso visualizar e organizar meu uso?
{: #usage}

**Como posso verificar meu faturamento e uso?**<br>
Para verificar seu uso e os totais estimados, veja [Visualizando seu uso](/docs/billing-usage/viewing_usage.html#viewingusage).

Se vincular suas contas do {{site.data.keyword.Bluemix_notm}} e da infraestrutura do IBM Cloud (SoftLayer), você receberá uma conta consolidada. Para obter mais informações, veja [Faturamento consolidado para contas vinculadas](/docs/customer-portal/linking_accounts.html#unifybillaccounts).

**Posso agrupar meus recursos em nuvem por equipes ou departamentos para propósitos de faturamento?**<br>
É possível [usar grupos de recursos](/docs/resources/bestpractice_rgs.html#bp_resourcegroups) para organizar seus recursos do {{site.data.keyword.Bluemix_notm}}, incluindo clusters, em grupos para organizar seu faturamento.

### Como sou cobrado? Os encargos são por hora ou mensalmente?
{: #monthly-charges}

Seus encargos dependem do tipo de recurso que você usa e podem ser fixos, medidos, definidos em camadas ou reservados. Para obter mais informações, visualize [Como você é cobrado](/docs/billing-usage/how_charged.html#charges).

Os recursos de infraestrutura do IBM Cloud (SoftLayer) podem ser faturados por hora ou mensalmente no {{site.data.keyword.containerlong_notm}}.
* Os nós do trabalhador da máquina virtual (VM) são faturados por hora.
* Os nós do trabalhador físicos (bare metal) são recursos faturados mensalmente no {{site.data.keyword.containerlong_notm}}.
* Para outros recursos de infraestrutura, como armazenamento de arquivo ou de bloco, você pode ser capaz de escolher entre faturamento por hora ou mensal ao criar o recurso.

Os recursos mensais são faturados com base no primeiro dia do mês para uso no mês anterior. Se você pedir um recurso mensal no meio do mês, será cobrada uma quantia rateada para esse mês. No entanto, se você cancelar um recurso no meio do mês, ainda será cobrada a quantia integral para o recurso mensal.

### Posso estimar meus custos?
{: #estimate}

Sim, veja [Estimando seus custos](/docs/billing-usage/estimating_costs.html#cost) e a ferramenta [estimador de custo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/pricing/). Continue lendo para obter informações sobre os custos que não estão incluídos no estimador de custo, como a rede de saída.

### Pelo que eu sou cobrado quando uso o {{site.data.keyword.containerlong_notm}}?
{: #cluster-charges}

Com os clusters do {{site.data.keyword.containerlong_notm}}, é possível usar os recursos de cálculo, rede e armazenamento de infraestrutura do IBM Cloud (SoftLayer) com os serviços de plataforma, como o Watson AI ou o Compose Database-as-a-Service. Cada recurso pode resultar em seus próprios encargos.
* [Nós do trabalhador](#nodes)
* [ Rede de saída ](#bandwidth)
* [ Endereços IP de sub-rede ](#subnets)
* [Armazenamento](#storage)
* [{{site.data.keyword.Bluemix_notm}} remotos](#services)

<dl>
<dt id="nodes">Nós do trabalhador</dt>
  <dd><p>Os clusters podem ter dois tipos principais de nós do trabalhador: máquinas virtuais ou físicas (bare metal). A disponibilidade e a precificação do tipo de máquina variam de acordo com a zona na qual você implementa o cluster.</p>
  <p>As <strong>Máquinas virtuais</strong> apresentam maior flexibilidade, tempos de fornecimento mais rápidos e recursos de escalabilidade mais automáticos do que o bare metal, com um preço com custo mais reduzido do que o bare metal. No entanto, as VMs têm um troca de desempenho quando comparadas com especificações de bare metal, como limites de Gbps de rede, RAM e memória e opções de armazenamento. Tenha em mente estes fatores que afetam os custos da VM:</p>
  <ul><li><strong>Compartilhado vs. dedicado</strong>: se você compartilhar o hardware subjacente da VM, o custo será menor que o hardware dedicado, mas os recursos físicos não serão dedicados à sua VM.</li>
  <li><strong>Somente faturamento por hora</strong>: por hora oferece mais flexibilidade para pedir e cancelar VMs rapidamente.
  <li><strong>Horas em camadas por mês</strong>: o faturamento por hora é em camadas. À medida que sua VM permanece pedida para uma camada de horas dentro de um mês de faturamento, a taxa horária que é cobrada diminui. Os níveis de horas são os seguintes: 0 - 150 horas, 151 - 290 horas, 291 - 540 horas e 541+ horas.</li></ul>
  <p>As <strong>Máquinas físicas (bare metal)</strong> produzem benefícios de alto desempenho para cargas de trabalho, como dados, AI e GPU. Além disso, todos os recursos de hardware são dedicados às suas cargas de trabalho, para que você não tenha "vizinhos barulhentos". Tenha em mente estes fatores que afetam seus custos de bare metal:</p>
  <ul><li><strong>Somente faturamento mensal</strong>: todos os bare metals são cobrados mensalmente.</li>
  <li><strong>Processo de pedido mais longo</strong>: como o pedido e o cancelamento de servidores bare metal é um processo manual por meio de sua conta de infraestrutura do IBM Cloud (SoftLayer), isso pode levar mais de um dia útil para ser concluído.</li></ul>
  <p>Para obter detalhes sobre as especificações da máquina, veja [Hardware disponível para nós do trabalhador](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Largura da banda</dt>
  <dd><p>A largura da banda refere-se à transferência de dados públicos de tráfego de rede de entrada e saída, para e de recursos do {{site.data.keyword.Bluemix_notm}} em data centers no mundo inteiro. A largura da banda pública é cobrada por GB. É possível revisar seu resumo de largura de banda atual efetuando login no [console do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), no menu ![Ícone de menu](../icons/icon_hamburger.svg "Ícone de menu") selecionando **Infraestrutura** e, em seguida, selecionando a página **Rede > Largura de banda > Resumo**.
  <p>Revise os fatores a seguir que afetam os encargos de largura da banda pública:</p>
  <ul><li><strong>Local</strong>: como ocorre com os nós do trabalhador, os encargos variam dependendo da zona em que seus recursos são implementados.</li>
  <li><strong>Largura de banda incluída ou Pré-pago</strong>: as máquinas do nó do trabalhador podem vir com certa alocação de rede de saída por mês, como 250 GB para VMs ou 500 GB para bare metal. Ou, a alocação pode ser Pré-pago, com base no uso de GB.</li>
  <li><strong>Pacotes em camadas</strong>: depois de exceder qualquer largura da banda incluída, você será cobrado de acordo com um esquema de uso em camadas que varia por local. Se você exceder uma dotação de camada, também poderá ser cobrada uma taxa de transferência de dados padrão.</li></ul>
  <p>Para obter mais informações, veja [Pacotes de largura da banda ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">Endereços IP de sub-</dt>
  <dd><p>Quando você cria um cluster padrão, uma sub-rede pública móvel com 8 endereços IP públicos é pedida e cobrada em sua conta mensalmente.</p><p>Se você já tiver sub-redes disponíveis em sua conta de infraestrutura, será possível usar essas sub-redes no lugar. Crie o cluster com a [sinalização](cs_cli_reference.html#cs_cluster_create) `--no-subnets` e, em seguida [reutilize suas sub-redes](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Armazenamento</dt>
  <dd>Quando você provisiona o armazenamento, é possível escolher o tipo de armazenamento e a classe de armazenamento que são corretos para o seu caso de uso. Os encargos variam de acordo com o tipo de armazenamento, o local e as especificações da instância de armazenamento. Para escolher a solução de armazenamento correta, veja [Planejando o armazenamento persistente altamente disponível](cs_storage_planning.html#storage_planning). Para obter informações adicionais, veja:
  <ul><li>[Precificação de armazenamento de arquivo NFS![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Precificação de armazenamento de bloco![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Planos de armazenamento de objetos![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}}  serviços</dt>
  <dd>Cada serviço que você integra a seu cluster tem seu próprio modelo de precificação. Consulte cada documentação do produto e o [estimador de custo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/pricing/) para obter mais informações.</dd>

</dl>
