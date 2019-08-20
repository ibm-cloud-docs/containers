---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}


# Notas sobre a liberação
{: #iks-release}

Use as notas sobre a liberação para aprender sobre as mudanças mais recentes para a documentação do {{site.data.keyword.containerlong}} que são agrupadas por mês.
{:shortdesc}

Os ícones a seguir são usados para indicar se uma nota de liberação se aplica apenas a uma determinada plataforma de contêiner. Se nenhum ícone for usado, a nota de liberação se aplicará tanto ao cluster OpenShift quanto ao cluster Kubernetes da comunidade.<br>
<img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> Aplica-se apenas a clusters Kubernetes da comunidade.<br>
<img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/> Aplica-se apenas a clusters OpenShift, liberados como beta em 5 de junho de 2019.
{: note}

## Agosto de 2019
{: #aug19}

<table summary="A tabela mostra notas sobre a liberação. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Atualizações da documentação em agosto de 2019</caption>
<thead>
<th>Data</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
  <td>1º de agosto 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/><strong>Red Hat OpenShift on IBM Cloud</strong>: o Red Hat OpenShift on IBM Cloud está geralmente disponível a partir de 1º de agosto de 2019 à 0h UTC. Todos os clusters beta expiram em 30 dias. É possível [criar um cluster GA](/docs/openshift?topic=openshift-openshift_tutorial) e, em seguida, reimplementar qualquer aplicativo que você use nos clusters beta antes que os clusters beta sejam removidos.<br><br>Como a infraestrutura em nuvem lógica e subjacente do {{site.data.keyword.containerlong_notm}} é a mesma, muitos tópicos são reutilizados na documentação para os clusters [Kubernetes da comunidade](/docs/containers?topic=containers-getting-started) e [OpenShift](/docs/openshift?topic=openshift-getting-started), como esse tópico das notas sobre a liberação.</td>
</tr>
</tbody></table>

## Julho de 2019
{: #jul19}

<table summary="A tabela mostra notas sobre a liberação. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Atualizações da documentação do {{site.data.keyword.containerlong_notm}} em julho de 2019</caption>
<thead>
<th>Data</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
  <td>30 de julho de 2019</td>
  <td><ul>
  <li><strong>Log de mudanças da CLI</strong>: atualizada a página de log de mudanças do plug-in do {{site.data.keyword.containerlong_notm}} para a [liberação da versão 0.3.95](/docs/containers?topic=containers-cs_cli_changelog).</li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizada a imagem `nginx-ingress` do ALB para a construção 515 para a [verificação de prontidão de pod do ALB](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Removendo sub-redes de um cluster</strong>: etapas incluídas para remover de um cluster as sub-redes [em uma conta de infraestrutura do IBM Cloud](/docs/containers?topic=containers-subnets#remove-sl-subnets) ou [em uma rede no local](/docs/containers?topic=containers-subnets#remove-user-subnets). </li>
  </ul></td>
</tr>
<tr>
  <td>26 de julho de 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Ícone de OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: incluídos os tópicos [Integrações](/docs/openshift?topic=openshift-openshift_integrations), [Localizações](/docs/openshift?topic=openshift-regions-and-zones) e [Restrições do contexto de segurança](/docs/openshift?topic=openshift-openshift_scc). Incluídas as funções de cluster `basic-users` e `self-provisioning` no tópico [Função de serviço do IAM para sincronização de RBAC](/docs/openshift?topic=openshift-access_reference#service).</td>
</tr>
<tr>
  <td>23 de julho de 2019</td>
  <td><strong>Log de mudanças do Fluentd</strong>: corrige as [vulnerabilidades do Alpine](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</td>
</tr>
<tr>
  <td>22 de julho de 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Política de versão</strong>: aumentado o período de [descontinuação de versão](/docs/containers?topic=containers-cs_versions#version_types) de 30 para 45 dias.</li>
      <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Logs de mudanças de versão</strong>: atualizados os logs de mudanças para as atualizações de correção de nó do trabalhador [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529_worker) e [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560_worker).</li>
    <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Log de mudanças de versão</strong>: a [Versão 1.11](/docs/containers?topic=containers-changelog#111_changelog) não é suportada.</li></ul>
  </td>
</tr>
<tr>
  <td>19 de julho de 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: incluída a [documentação do Red Hat OpenShift on IBM Cloud em um repositório separado](/docs/openshift?topic=openshift-getting-started). Como a infraestrutura em nuvem lógica e subjacente do {{site.data.keyword.containerlong_notm}} é a mesma, muitos tópicos são reutilizados na documentação para o cluster OpenShift e Kubernetes da comunidade, como este tópico das notas sobre a liberação.
  </td>
</tr>
<tr>
  <td>17 de julho de 2019</td>
  <td><strong>Log de mudanças de ALB do Ingress</strong>: [Corrige vulnerabilidades do `rbash`](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).
  </td>
</tr>
<tr>
  <td>15 de julho de 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>ID do cluster e do nó do trabalhador</strong>: o formato do ID para clusters e nós do trabalhador foi mudado. Os clusters existentes e os nós do trabalhador mantêm seus IDs existentes. Se você tiver automação que conta com o formato anterior, atualize-o para novos clusters.<ul>
  <li>**ID do cluster**: no formato de expressão regular `{a-v0-9}[7]{a-z0-9}[2]{a-v0-9}[11]`</li>
  <li>**ID do nó do trabalhador**: no formato `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`</li></ul></li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizada a imagem `nginx-ingress` do [ALB para a construção 497](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Resolução de problemas de clusters</strong>: incluídas [etapas de resolução de problemas](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_totp) para quando não é possível gerenciar clusters e nós do trabalhador porque a opção de senha descartável baseada em tempo (TOTP) está ativada para a sua conta.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Logs de mudanças de versão</strong>: atualizados os log de mudanças para as atualizações de fix pack do mestre [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529) e [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560).</li></ul>
  </td>
</tr>
<tr>
  <td>08 de julho de 2019</td>
  <td><ul>
  <li><strong>Rede de aplicativos</strong>: agora é possível localizar informações sobre a rede de aplicativos com os NLBs e os ALBs do Ingress nas páginas a seguir:
    <ul><li>[Balanceamento de carga básico e DSR com balanceadores de carga de rede (NLB)](/docs/containers?topic=containers-cs_sitemap#sitemap-nlb)</li>
    <li>[Balanceamento de carga HTTPS com balanceadores de carga do aplicativo (ALB) Ingress](/docs/containers?topic=containers-cs_sitemap#sitemap-ingress)</li></ul>
  </li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Log de mudanças de versão</strong>: atualizados os logs de mudanças para as atualizações de correção do nó do trabalhador [1.14.3_1525](/docs/containers?topic=containers-changelog#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-changelog#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-changelog#1129_1559) e [1.11.10_1564](/docs/containers?topic=containers-changelog#11110_1564).</li></ul>
  </td>
</tr>
<tr>
  <td>02 de julho de 2019</td>
  <td><strong>Log de mudanças da CLI</strong>: atualizada a página de log de mudanças do plug-in da CLI do {{site.data.keyword.containerlong_notm}} para a [liberação da versão 0.3.58](/docs/containers?topic=containers-cs_cli_changelog).</td>
</tr>
<tr>
  <td>01 de julho de 2019</td>
  <td><ul>
  <li><strong>Permissões de infraestrutura</strong>: Atualizadas as [funções de infraestrutura clássica](/docs/containers?topic=containers-access_reference#infra) necessárias para casos de uso comuns.</li>
  <li><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/><strong>Perguntas mais frequentes do OpenShift</strong>: expandidas as [Perguntas mais frequentes](/docs/containers?topic=containers-faqs#container_platforms) para incluir informações sobre os clusters OpenShift.</li>
  <li><strong>Protegendo aplicativos gerenciados pelo Istio com o {{site.data.keyword.appid_short_notm}}</strong>: informações incluídas sobre o [Adaptador de identidade e acesso de aplicativo](/docs/containers?topic=containers-istio#app-id).</li>
  <li><strong>Serviço VPN strongSwan</strong>: se você instalar o strongSwan em um cluster multizona e usar a configuração `enableSingleSourceIP=true`, agora será possível [configurar `local.subnet` para a variável `%zoneSubnet` e usar `local.zoneSubnet` para especificar um endereço IP como uma sub-rede /32 para cada zona do cluster](/docs/containers?topic=containers-vpn#strongswan_4).</li>
  </ul></td>
</tr>
</tbody></table>


## Junho de 2019
{: #jun19}

<table summary="A tabela mostra notas sobre a liberação. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Atualizações da documentação do {{site.data.keyword.containerlong_notm}} em junho de 2019</caption>
<thead>
<th>Data</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
  <td>24 de junho de 2019</td>
  <td><ul>
  <li><strong>Políticas de rede do Calico</strong>: Incluído um conjunto de [políticas públicas do Calico](/docs/containers?topic=containers-network_policies#isolate_workers_public) e expandido o conjunto de [políticas privadas do Calico](/docs/containers?topic=containers-network_policies#isolate_workers) para proteger seu cluster em redes públicas e privadas.</li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizada a imagem `nginx-ingress` do [ALB para a construção 477](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Limitações de serviço</strong>: atualizada a [limitação de número máximo de pods por nó do trabalhador](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits). Para nós do trabalhador que executam Kubernetes 1.13.7_1527, 1.14.3_1524 ou mais recente e que têm mais de 11 núcleos de CPU, os nós do trabalhador podem suportar 10 pods por núcleo, até um limite de 250 pods por nó do trabalhador.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Logs de mudanças de versão</strong>: incluídos logs de mudanças para as atualizações de correção do nó do trabalhador [1.14.3_1524](/docs/containers?topic=containers-changelog#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-changelog#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-changelog#1129_1558) e [1.11.10_1563](/docs/containers?topic=containers-changelog#11110_1563).</li>
  </ul></td>
</tr>
<tr>
  <td>21 de junho de 2019</td>
  <td><ul>
  <li><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Acessando clusters OpenShift</strong>: incluídas etapas para [automatizar o acesso a um cluster OpenShift usando um token de login do OpenShift](/docs/containers?topic=containers-cs_cli_install#openshift_cluster_login).</li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Acessando o mestre do Kubernetes por meio do terminal em serviço privado</strong>: incluídas etapas para [editar o arquivo de configuração do Kubernetes local](/docs/containers?topic=containers-clusters#access_on_prem) quando os terminais em serviço público e privado estão ativados, mas você deseja acessar o mestre do Kubernetes por meio do terminal em serviço privado apenas.</li>
  <li><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Solucionando problemas dos clusters OpenShift</strong>: incluída uma [seção de resolução de problemas](/docs/openshift?topic=openshift-openshift_tutorial#openshift_troubleshoot) no tutorial Criando um cluster do Red Hat OpenShift on IBM Cloud (beta).</li>
  </ul></td>
</tr>
<tr>
  <td>18 de junho de 2019</td>
  <td><ul>
  <li><strong>Log de mudanças da CLI</strong>: atualizada a página de log de mudanças do plug-in da CLI do {{site.data.keyword.containerlong_notm}} para a [liberação das versões 0.3.47 e 0.3.49](/docs/containers?topic=containers-cs_cli_changelog).</li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizadas a [imagem `nginx-ingress` do ALB para a construção 473 e a imagem `ingress-auth` para a construção 331](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Versões de complementos gerenciados</strong>: Atualizou a versão do Complemento gerenciado Istio para 1.1.7 e o complemento gerenciado Knativo para 0.6.0.</li>
  <li><strong>Removendo armazenamento persistente</strong>: Atualizou as informações de como você é faturado ao [excluir armazenamento persistente](/docs/containers?topic=containers-cleanup).</li>
  <li><strong>Ligações de serviços com terminal privado</strong>: [Etapas incluídas](/docs/containers?topic=containers-service-binding) para como criar credenciais de serviço manualmente com o terminal em serviço privado ao ligar o serviço ao seu cluster.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Logs de mudanças de versão</strong>: atualizados os logs de mudança para as atualizações de correção [1.14.3_1523](/docs/containers?topic=containers-changelog#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-changelog#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-changelog#1129_1557) e [1.11.10_1562](/docs/containers?topic=containers-changelog#11110_1562).</li>
  </ul></td>
</tr>
<tr>
  <td>14 de junho de 2019</td>
  <td><ul>
  <li><strong>Resolução de problemas do `kubectl`</strong>: incluído um [tópico de resolução de problemas](/docs/containers?topic=containers-cs_troubleshoot_clusters#kubectl_fails) para quando você tiver uma versão do cliente `kubectl` que tenha duas ou mais versões de diferença da versão do servidor ou da versão do OpenShift do `kubectl`, que não funciona com os clusters Kubernetes da comunidade.</li>
  <li><strong>Página inicial de tutoriais</strong>: substituída a página de links relacionados por uma nova [página inicial de tutoriais](/docs/containers?topic=containers-tutorials-ov) para todos os tutoriais que são específicos para o {{site.data.keyword.containershort_notm}}.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Tutorial para criar um cluster e implementar um aplicativo</strong>: combinados os tutoriais para a criação de clusters e a implementação de aplicativos em um [tutorial](/docs/containers?topic=containers-cs_cluster_tutorial) abrangente.</li>
  <li><strong>Usando as sub-redes existentes para criar um cluster</strong>: para [reutilizar sub-redes de um cluster desnecessário quando você cria um novo cluster](/docs/containers?topic=containers-subnets#subnets_custom), as sub-redes devem ser sub-redes gerenciadas pelo usuário que você incluiu manualmente por meio de uma rede no local. Todas as sub-redes que foram automaticamente pedidas durante a criação do cluster são excluídas imediatamente após a exclusão de um cluster e não será possível reutilizar essas sub-redes para criar um novo cluster.</li>
  </ul></td>
</tr>
<tr>
  <td>12 de junho de 2019</td>
  <td><strong>Agregando funções de cluster</strong>: etapas incluídas para [ampliar as permissões existentes dos usuários agregando funções de cluster](/docs/containers?topic=containers-users#rbac_aggregate).</td>
</tr>
<tr>
  <td>07 de junho de 2019</td>
  <td><ul>
  <li><strong>Acesso aos mestre do Kubernetes por meio do terminal em serviço privado</strong>: incluídas [etapas](/docs/containers?topic=containers-clusters#access_on_prem) para expor o terminal em serviço privado por meio de um balanceador de carga privado. Depois de concluir essas etapas, seus usuários de cluster autorizados poderão acessar o principal do Kubernetes por meio de uma conexão VPN ou {{site.data.keyword.cloud_notm}} Direct Link.</li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: incluído o {{site.data.keyword.cloud_notm}} Direct Link nas páginas [Conectividade VPN](/docs/containers?topic=containers-vpn) e [nuvem híbrida](/docs/containers?topic=containers-hybrid_iks_icp) como uma maneira de criar uma conexão privada direta entre seus ambientes de rede remota e o {{site.data.keyword.containerlong_notm}} sem rotear pela Internet pública.</li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizado a imagem [`ingress-auth` do ALB para construção 330](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/> <strong>OpenShift beta</strong>: [incluída uma lição](/docs/openshift?topic=openshift-openshift_tutorial#openshift_logdna_sysdig) sobre como modificar as implementações de aplicativo para restrições de contexto de segurança privilegiados para os complementos {{site.data.keyword.la_full_notm}} e {{site.data.keyword.mon_full_notm}}.</li>
  </ul></td>
</tr>
<tr>
  <td>06 de junho de 2019</td>
  <td><ul>
  <li><strong>Log de mudanças do Fluentd</strong>: incluído um [log de mudanças da versão do Fluentd](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizada a imagem [`nginx-ingress` do ALB para construção 470](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>05 de junho de 2019</td>
  <td><ul>
  <li><strong>Referência da CLI</strong>: atualizada a [página de referência da CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para refletir múltiplas mudanças para a [liberação da versão 0.3.34](/docs/containers?topic=containers-cs_cli_changelog) do plug-in da CLI do {{site.data.keyword.containerlong_notm}}.</li>
  <li><img src="images/logo_openshift.svg" alt="Ícone do OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Novo! Clusters do Red Hat OpenShift on IBM Cloud clusters (beta)</strong>: com o beta do Red Hat OpenShift no IBM Cloud, é possível criar clusters do {{site.data.keyword.containerlong_notm}} com nós do trabalhador que vêm instalados com o software da plataforma de orquestração de contêiner do OpenShift. Você obtém todas as vantagens do {{site.data.keyword.containerlong_notm}} gerenciado para seu ambiente de infraestrutura do cluster, juntamente com o [conjunto de ferramentas e o catálogo do OpenShift ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.openshift.com/container-platform/3.11/welcome/index.html) que são executados no Red Hat Enterprise Linux para suas implementações do app. Para obter a introdução, consulte [Tutorial: criando um cluster do Red Hat OpenShift on IBM Cloud (beta)](/docs/openshift?topic=openshift-openshift_tutorial).</li>
  </ul></td>
</tr>
<tr>
  <td>04 de junho de 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Ícone do Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Logs de mudanças de versão</strong>: atualizados os logs de mudanças para as liberações de correção [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555) e [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561).</li></ul>
  </td>
</tr>
<tr>
  <td>03 de junho de 2019</td>
  <td><ul>
  <li><strong>Trazendo seu próprio controlador do Ingress</strong>: atualizadas as [etapas](/docs/containers?topic=containers-ingress-user_managed) para refletir as mudanças no controlador de comunidade padrão e para requerer uma verificação de funcionamento para endereços IP do controlador em clusters de multizona.</li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: atualizadas as [etapas](/docs/containers?topic=containers-object_storage#install_cos) para instalar o plug-in do {{site.data.keyword.cos_full_notm}} com ou sem o servidor do Helm, o Tiller.</li>
  <li><strong>Log de mudanças do ALB do Ingress</strong>: atualizada a imagem [`nginx-ingress` do ALB para construção 467](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Kustomize</strong>: incluído um exemplo de [reutilização de arquivos de configuração do Kubernetes em múltiplos ambientes com o Kustomize](/docs/containers?topic=containers-app#kustomize).</li>
  <li><strong>Razee</strong>: incluído o [Razee ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/razee-io/Razee) nas integrações suportadas para visualizar informações de implementação no cluster e para automatizar a implementação de recursos do Kubernetes. </li></ul>
  </td>
</tr>
</tbody></table>


## Maio de 2019
{: #may19}

<table summary="A tabela mostra notas sobre a liberação. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Atualizações da documentação do {{site.data.keyword.containerlong_notm}} em maio de 2019</caption>
<thead>
<th>Data</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
  <td>30 de maio de 2019</td>
  <td><ul>
  <li><strong>Referência da CLI</strong>: atualizada a [página de referência da CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para refletir múltiplas mudanças para a [liberação da versão 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) do plug-in da CLI do {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Armazenamento de resolução de problemas</strong>: <ul>
  <li>Incluído um tópico de resolução de problemas de armazenamento de arquivo e de bloco para [estados pendentes da PVC](/docs/containers?topic=containers-cs_troubleshoot_storage#file_pvc_pending).</li>
  <li>Incluído um tópico de resolução de problemas de armazenamento de bloco para quando [um app não pode acessar ou gravar na PVC](/docs/containers?topic=containers-cs_troubleshoot_storage#block_app_failures).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>28 de maio de 2019</td>
  <td><ul>
  <li><strong>Log de mudanças de complementos do cluster</strong>: atualizada a imagem [`nginx-ingress` do ALB para construção 462](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Registro de resolução de problemas</strong>: incluído um [tópico de resolução de problemas](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create) para quando seu cluster não pode fazer pull de imagens do {{site.data.keyword.registryfull}} devido a um erro durante a criação do cluster.
  </li>
  <li><strong>Armazenamento de resolução de problemas</strong>: <ul>
  <li>Incluído um tópico para [depurar falhas de armazenamento persistente](/docs/containers?topic=containers-cs_troubleshoot_storage#debug_storage).</li>
  <li>Incluído um tópico de resolução de problemas para [falhas de criação da PVC devido a permissões ausentes](/docs/containers?topic=containers-cs_troubleshoot_storage#missing_permissions).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>23 de maio de 2019</td>
  <td><ul>
  <li><strong>Referência da CLI</strong>: atualizada a [página de referência da CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para refletir múltiplas mudanças para a [liberação da versão 0.3.28](/docs/containers?topic=containers-cs_cli_changelog) do plug-in da CLI do {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Log de mudanças de complementos do cluster</strong>: atualizada a imagem [`nginx-ingress` do ALB para construção 457](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Estados do cluster e do trabalhador</strong>: atualizada a [página Criação de log e monitoramento](/docs/containers?topic=containers-health#states) para incluir tabelas de referência sobre estados do cluster e do nó do trabalhador.</li>
  <li><strong>Planejamento e criação de cluster</strong>: agora é possível localizar informações sobre planejamento, criação e remoção de cluster e planejamento de rede nas páginas a seguir:
    <ul><li>[Planejando a configuração de rede do cluster](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[Planejando seu cluster para alta disponibilidade](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[Planejando a configuração do nó do trabalhador](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[Criando clusters](/docs/containers?topic=containers-clusters)</li>
    <li>[Incluindo nós do trabalhador e zonas em clusters](/docs/containers?topic=containers-add_workers)</li>
    <li>[Removendo clusters](/docs/containers?topic=containers-remove)</li>
    <li>[Mudando Terminais em serviço ou conexões VLAN](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>Atualizações de versão do cluster</strong>: atualizada a [política de versões não suportadas](/docs/containers?topic=containers-cs_versions) para mencionar que não será possível atualizar clusters se a versão do principal for três ou mais versões atrás da versão suportada mais antiga. É possível visualizar se o cluster é **não suportado** revisando o campo **Estado** ao listar clusters.</li>
  <li><strong>Istio</strong>: atualizada a [página Istio](/docs/containers?topic=containers-istio) para remover a limitação de que o Istio não funciona em clusters que estão conectados somente a uma VLAN privada. Incluída uma etapa no [tópico Atualizando complementos gerenciados](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) para recriar os gateways do Istio que usam seções do TLS após a atualização do complemento gerenciado pelo Istio ser concluída.</li>
  <li><strong>Tópicos populares</strong>: substituídos os tópicos populares por essa página de notas sobre a liberação para obter novos recursos e atualizações que são específicos para o {{site.data.keyword.containershort_notm}}. Para obter as informações mais recentes sobre produtos do {{site.data.keyword.cloud_notm}}, consulte os [Anúncios](https://www.ibm.com/cloud/blog/announcements).</li>
  </ul></td>
</tr>
<tr>
  <td>20 de maio de 2019</td>
  <td><ul>
  <li><strong>Logs de mudanças de versão</strong>: incluídos os [logs de mudanças do fix pack do nó do trabalhador](/docs/containers?topic=containers-changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>16 de maio de 2019</td>
  <td><ul>
  <li><strong>Referência da CLI</strong>: atualizada a [página de referência da CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para incluir os terminais COS para comandos `logging-collect` e para esclarecer que `apiserver-refresh` reinicia os componentes do principal do Kubernetes.</li>
  <li><strong>Não suportado: Kubernetes versão 1.10</strong>: o [Kubernetes versão 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) agora não é suportado.</li>
  </ul></td>
</tr>
<tr>
  <td>15 de maio de 2019</td>
  <td><ul>
  <li><strong>Versão do Kubernetes padrão</strong>: a versão padrão do Kubernetes é agora 1.13.6.</li>
  <li><strong>Limites de serviço</strong>: incluído um [tópico de limitações de serviço](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits).</li>
  </ul></td>
</tr>
<tr>
  <td>13 de maio de 2019</td>
  <td><ul>
  <li><strong>Logs de mudanças de versão</strong>: incluído que as novas atualizações de correção estão disponíveis para [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558) e [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558).</li>
  <li><strong>Tipos de nó do trabalhador</strong>: removidos todos os [tipos de nó do trabalhador da máquina virtual](/docs/containers?topic=containers-planning_worker_nodes#vm) que têm 48 ou mais núcleos por [status de nuvem ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status). Ainda é possível provisionar [nós do trabalhador de bare metal](/docs/containers?topic=containers-plan_clusters#bm) com 48 ou mais núcleos.</li></ul></td>
</tr>
<tr>
  <td>08 de maio de 2019</td>
  <td><ul>
  <li><strong>API</strong>: incluído um link para os [docs do swagger da API global ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://containers.cloud.ibm.com/global/swagger-global-api/#/).</li>
  <li><strong>Cloud Object Storage</strong>: [incluído um guia de resolução de problemas para o Cloud Object Storage](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) em seus clusters do {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Estratégia do Kubernetes</strong>: incluído um tópico sobre [Quais conhecimentos e qualificações técnicas é bom ter antes de mover meus apps para o {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).</li>
  <li><strong>Kubernetes versão 1.14</strong>: incluído que a [liberação do Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) é certificada.</li>
  <li><strong>Tópicos de referência</strong>: informações atualizadas para várias operações de ligação de serviço, `logging` e `nlb` nas páginas de referência de [acesso de usuário](/docs/containers?topic=containers-access_reference) e [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli).</li></ul></td>
</tr>
<tr>
  <td>07 de maio de 2019</td>
  <td><ul>
  <li><strong>Provedor DNS do cluster</strong>: [explicados os benefícios do CoreDNS](/docs/containers?topic=containers-cluster_dns) agora que os clusters que executam o Kubernetes 1.14 e mais recente suportam somente o CoreDNS.</li>
  <li><strong>Nós de borda</strong>: incluído o suporte ao balanceador de carga privado incluído para [nós de borda](/docs/containers?topic=containers-edge).</li>
  <li><strong>Clusters grátis</strong>: esclarecido onde os [clusters grátis](/docs/containers?topic=containers-regions-and-zones#regions_free) são suportados.</li>
  <li><strong>Novo! Integrações</strong>: incluídas informações reestruturadas sobre [integrações de serviço e de terceiro do {{site.data.keyword.cloud_notm}}](/docs/containers?topic=containers-ibm-3rd-party-integrations), [integrações populares](/docs/containers?topic=containers-supported_integrations) e [parcerias](/docs/containers?topic=containers-service-partners).</li>
  <li><strong>Novo! Kubernetes versão 1.14</strong>: crie ou atualize seus clusters para o [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114).</li>
  <li><strong>Descontinuado o Kubernetes versão 1.11</strong>: [atualize](/docs/containers?topic=containers-update) quaisquer clusters que executem o [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) antes de se tornarem não suportados.</li>
  <li><strong>Permissões</strong>: incluída uma pergunta mais frequente, [Quais políticas de acesso eu forneço aos meus usuários do cluster?](/docs/containers?topic=containers-faqs#faq_access)</li>
  <li><strong>Conjuntos de trabalhadores</strong>: incluídas instruções de como [aplicar rótulos a conjuntos de trabalhadores existentes](/docs/containers?topic=containers-add_workers#worker_pool_labels).</li>
  <li><strong>Tópicos de referência</strong>: para suportar novos recursos, tais como Kubernetes 1.14, as páginas de referência do [log de mudanças](/docs/containers?topic=containers-changelog#changelog) são atualizadas.</li></ul></td>
</tr>
<tr>
  <td>1º de maio de 2019</td>
  <td><strong>Designando acesso à infraestrutura</strong>: revise as [etapas para designar permissões do IAM para abrir casos de suporte](/docs/containers?topic=containers-users#infra_access).</td>
</tr>
</tbody></table>


