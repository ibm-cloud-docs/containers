---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# Tópicos populares para {{site.data.keyword.containerlong_notm}}
{: #cs_popular_topics}

Acompanhe o que está acontecendo no {{site.data.keyword.containerlong}}. Aprenda sobre os novos recursos para explorar, um truque para experimentar ou alguns tópicos populares que outros desenvolvedores estão achando úteis agora.
{:shortdesc}

## Tópicos populares em dezembro de 2018
{: #dec18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em dezembro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>6 de dezembro</td>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Obtenha visibilidade operacional para o desempenho e o funcionamento de seus apps implementando o Sysdig como um serviço de terceiro para os nós do trabalhador para encaminhar métricas para o {{site.data.keyword.monitoringlong}}. Para obter mais informações, consulte [Analisando métricas para um app implementado em um cluster do Kubernetes](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster). **Nota**: se você usar o {{site.data.keyword.mon_full_notm}} com clusters que executam o Kubernetes versão 1.11 ou mais recente, nem todas as métricas de contêiner serão coletadas, porque o Sysdig não suporta atualmente o `containerd`.</td>
</tr>
</tbody></table>

## Tópicos populares em novembro de 2018
{: #nov18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em novembro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>29 de novembro</td>
<td>[Zona disponível em Chennai](cs_regions.html)</td>
<td>Bem-vindo Chennai, Índia como uma nova zona para clusters na região Norte AP. Se você tiver um firewall, certifique-se de [abrir as portas de firewall](cs_firewall.html#firewall) para essa zona e as outras zonas dentro da região em que seu cluster está.</td>
</tr>
<tr>
<td>27 de novembro</td>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>Inclua recursos de gerenciamento de log no cluster implementando LogDNA como um serviço de terceiro para seus nós do trabalhador para gerenciar logs dos contêineres de pod. Para obter mais informações, consulte [Gerenciando logs de cluster do Kubernetes com o {{site.data.keyword.loganalysisfull_notm}} com LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube).</td>
</tr>
<tr>
<td>7 de novembro</td>
<td>Balanceador de carga 2.0 (beta)</td>
<td>Agora é possível escolher entre o [balanceador de carga 1.0 ou 2.0](cs_loadbalancer.html#planning_ipvs) para expor com segurança seus apps de cluster para o público.</td>
</tr>
<tr>
<td>7 de novembro</td>
<td>Kubernetes versão 1.12 disponível</td>
<td>Agora, é possível atualizar ou criar clusters que executam [Kubernetes versão 1.12](cs_versions.html#cs_v112)! Clusters 1.12 vêm com os mestres do Kubernetes altamente disponíveis por padrão.</td>
</tr>
<tr>
<td>7 de novembro</td>
<td>Mestres altamente disponíveis em clusters que executam o Kubernetes versão 1.10</td>
<td>Os mestres altamente disponíveis estão disponíveis para clusters que executam o Kubernetes versão 1.10! Todos os benefícios descritos na entrada anterior para clusters 1.11 se aplicam aos clusters 1.10, assim como as [etapas de preparação](cs_versions.html#110_ha-masters) que devem ser executadas.</td>
</tr>
<tr>
<td>1 de novembro</td>
<td>Mestres altamente disponíveis em clusters que executam o Kubernetes versão 1.11</td>
<td>Em uma zona única, seu mestre está altamente disponível e inclui réplicas em hosts físicos separados para seu servidor de API do Kubernetes, um etcd, um planejador e um gerenciador de controlador para proteger contra uma indisponibilidade, como durante uma atualização de cluster. Se o seu cluster estiver em uma zona com capacidade para várias zonas, o seu mestre altamente disponível também será distribuído entre zonas para ajudar a proteger contra uma falha zonal.<br>Para ações que devem ser executadas, consulte [Atualizando para os clusters mestres altamente disponíveis](cs_versions.html#ha-masters). Estas ações de preparação se aplicam:<ul>
<li>Se você tiver um firewall ou políticas de rede customizadas do Calico.</li>
<li>Se você estiver usando as portas do host `2040` ou `2041` nos nós do trabalhador.</li>
<li>Se você usou o endereço IP do cluster mestre para acesso no cluster ao mestre.</li>
<li>Se você tiver automação que chame a API ou a CLI do Calico (`calicoctl`), tal como para criar políticas do Calico.</li>
<li>Se você usar políticas de rede do Kubernetes ou do Calico para controlar o acesso de egresso do pod ao mestre.</li></ul></td>
</tr>
</tbody></table>

## Tópicos populares em outubro de 2018
{: #oct18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em outubro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>25 de Outubro</td>
<td>[ Zona disponível em Milão ](cs_regions.html)</td>
<td>Bem-vindo Milão, Itália, como uma nova zona para os clusters pagos na região central da UE. Anteriormente, Milão estava disponível somente para clusters grátis. Se você tiver um firewall, certifique-se de [abrir as portas de firewall](cs_firewall.html#firewall) para essa zona e as outras zonas dentro da região em que seu cluster está.</td>
</tr>
<tr>
<td>22 de Outubro</td>
<td>[ Nova posição de multisona de Londres,  ` lon05 ` ](cs_regions.html#zones)</td>
<td>A cidade metropolitana de múltiplas zonas de Londres substitui a zona `lon02` pela nova zona `lon05`, uma zona com mais recursos de infraestrutura do que `lon02`. Crie novos clusters multizona com  ` lon05 `. Os clusters existentes com `lon02` são suportados, mas os novos clusters de múltiplas zonas devem usar `lon05` no lugar.</td>
</tr>
<tr>
<td>05 de outubro</td>
<td>Integração com o  {{site.data.keyword.keymanagementservicefull}}</td>
<td>É possível criptografar os segredos do Kubernetes em seu cluster [ativando o {{site.data.keyword.keymanagementserviceshort}} (beta)](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>04 de outubro</td>
<td>[O {{site.data.keyword.registrylong}} está agora integrado ao {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM)](/docs/services/Registry/iam.html#iam)</td>
<td>É possível usar o {{site.data.keyword.Bluemix_notm}} IAM para controlar o acesso a seus recursos de registro, como puxar, enviar por push e construir imagens. Ao criar um cluster, você também cria um token de registro para que o cluster possa trabalhar com seu registro. Portanto, você precisa da função **Administrador** de gerenciamento de plataforma do registro de nível de conta para criar um cluster. Para ativar o {{site.data.keyword.Bluemix_notm}} IAM para sua conta de registro, veja [Ativando a aplicação de política para usuários existentes](/docs/services/Registry/registry_users.html#existing_users).</td>
</tr>
<tr>
<td>01 de outubro</td>
<td>[Grupos de recursos](cs_users.html#resource_groups)</td>
<td>É possível usar grupos de recursos para separar seus recursos do {{site.data.keyword.Bluemix_notm}} em pipelines, departamentos ou outros agrupamentos para ajudar a designar o acesso e medir o uso. Agora, o {{site.data.keyword.containerlong_notm}} suporta a criação de clusters no grupo `default` ou em qualquer outro grupo de recursos que você criar!</td>
</tr>
</tbody></table>

## Tópicos populares em setembro de 2018
{: #sept18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em setembro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>25 de setembro</td>
<td>[Novas zonas disponíveis](cs_regions.html)</td>
<td>Agora você tem ainda mais opções de onde implementar seus apps!
<ul><li>Bem-vindo a San Jose como duas novas zonas na região sul dos EUA, `sjc03` e `sjc04`. Se você tiver um firewall, certifique-se de [abrir as portas do firewall](cs_firewall.html#firewall) para essa zona e as outras dentro da região em que seu cluster estiver.</li>
<li>Com duas novas zonas `tok04` e `tok05`, agora é possível [criar clusters de múltiplas zonas](cs_clusters_planning.html#multizone) em Tóquio na região Norte de AP.</li></ul></td>
</tr>
<tr>
<td>05 de setembro</td>
<td>[ Zona disponível em Oslo ](cs_regions.html)</td>
<td>Bem-vindo Oslo, Noruega, como uma nova zona na região Central da UE. Se você tiver um firewall, certifique-se de [abrir as portas do firewall](cs_firewall.html#firewall) para essa zona e as outras dentro da região em que seu cluster estiver.</td>
</tr>
</tbody></table>

## Tópicos populares em agosto de 2018
{: #aug18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em agosto de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>31 de agosto</td>
<td>{{site.data.keyword.cos_full_notm}}  está agora integrado com o  {{site.data.keyword.containerlong}}</td>
<td>Use solicitações de volume persistente (PVC) nativas do Kubernetes para provisionar o {{site.data.keyword.cos_full_notm}} para seu cluster. O {{site.data.keyword.cos_full_notm}} é melhor usado para cargas de trabalho de leitura intensiva e se você deseja armazenar dados entre múltiplas zonas em um cluster de múltiplas zonas. Inicie [criando uma instância de serviço do {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#create_cos_service) e [instalando o plug-in do {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#install_cos) em seu cluster. </br></br>Não tem certeza de qual solução de armazenamento pode ser a correta para você? Inicie [aqui](cs_storage_planning.html#choose_storage_solution) para analisar seus dados e escolher a solução de armazenamento apropriada para seus dados. </td>
</tr>
<tr>
<td>14 de agosto</td>
<td>Atualizar seus clusters para o Kubernetes versões 1.11 para designar prioridade do pod</td>
<td>Depois de atualizar seu cluster para o [Kubernetes versão 1.11](cs_versions.html#cs_v111), é possível aproveitar novos recursos, como aumento de desempenho do tempo de execução do contêiner com `containerd` ou [designando a prioridade do pod](cs_pod_priority.html#pod_priority).</td>
</tr>
</tbody></table>

## Tópicos populares em julho de 2018
{: #july18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em julho de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>30 de julho</td>
<td>[ Traga seu próprio controlador de Ingresso ](cs_ingress.html#user_managed)</td>
<td>Você tem segurança muito específica ou outros requisitos customizados para o controlador de ingresso do seu cluster? Se sim, você pode desejar executar seu próprio controlador de ingresso em vez do padrão.</td>
</tr>
<tr>
<td>10 de julho</td>
<td>Introducing multizone clusters</td>
<td>Deseja melhorar a disponibilidade do cluster? Agora, é possível estender seu cluster em múltiplas zonas em áreas metro selecionadas. Para obter mais informações, veja [Criando clusters multizona no {{site.data.keyword.containerlong_notm}}](cs_clusters_planning.html#multizone).</td>
</tr>
</tbody></table>

## Tópicos populares em junho de 2018
{: #june18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em junho de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>13 de junho</td>
<td>O nome do comando da CLI `bx` está sendo mudado para a CLI `ic`</td>
<td>Ao fazer download da versão mais recente da CLI do {{site.data.keyword.Bluemix_notm}}, agora você executa comandos usando o prefixo `ic` em vez de `bx`. Por exemplo, liste seus clusters executando `ibmcloud ks clusters`.</td>
</tr>
<tr>
<td>12 de junho</td>
<td>[ Políticas de segurança do Pod ](cs_psp.html)</td>
<td>Para clusters que executam o Kubernetes 1.10.3 ou mais recente, é possível
configurar políticas de segurança de pod para autorizar quem pode criar e atualizar pods no {{site.data.keyword.containerlong_notm}}.</td>
</tr>
<tr>
<td>06 de junho</td>
<td>[Suporte do TLS para o subdomínio curinga do Ingresso fornecido pela IBM](cs_ingress.html#wildcard_tls)</td>
<td>Para clusters criados em ou após 6 de junho de 2018, o certificado TLS de subdomínio do Ingresso fornecido pela IBM agora é um certificado curinga e pode ser usado para o subdomínio curinga registrado. Para clusters criados antes de 6 de junho de 2018, o certificado do TLS será atualizado para um certificado curinga quando o certificado do TLS atual for renovado.</td>
</tr>
</tbody></table>

## Tópicos populares em maio de 2018
{: #may18}


<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em maio de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>24 de maio</td>
<td>[Novo Ingress subdomain formato](cs_ingress.html)</td>
<td>Os clusters criados após 24 de maio são designados a um subdomínio do Ingresso em um novo formato: <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>. Quando você usa o Ingresso para expor os seus apps, é possível usar o novo subdomínio para acessar os seus apps na Internet.</td>
</tr>
<tr>
<td>14 de maio</td>
<td>[Atualização: implementar cargas de trabalho na GPU bare metal no mundo todo](cs_app.html#gpu_app)</td>
<td>Se você tem um [tipo de máquina de unidade de processamento de gráfico (GPU) bare metal](cs_clusters_planning.html#shared_dedicated_node) em seu cluster, é possível planejar apps matematicamente intensivos. O nó do trabalhador de GPU pode processar a carga de trabalho de seu app na CPU e GPU para aumentar o desempenho.</td>
</tr>
<tr>
<td>Maio 03</td>
<td>[Contêiner Image Security Enforcement (beta)](/docs/services/Registry/registry_security_enforce.html#security_enforce)</td>
<td>Sua equipe precisa de uma ajuda extra para saber qual imagem puxar em seus contêineres de app? Experimente o beta do Container Image Security Enforcement para verificar imagens de contêiner antes de implementá-las. Disponível para clusters que executam o Kubernetes versão 1.9 ou mais recente.</td>
</tr>
<tr>
<td>Maio 01</td>
<td>[Implementar o painel do Kubernetes por meio do console](cs_app.html#cli_dashboard)</td>
<td>Alguma vez você desejou acessar o painel do Kubernetes com um clique? Confira o botão **Painel do Kubernetes** no console do {{site.data.keyword.Bluemix_notm}}.</td>
</tr>
</tbody></table>




## Tópicos populares em abril de 2018
{: #apr18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em abril de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>17 de abril</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>Instale o [plug-in](cs_storage_block.html#install_block) do {{site.data.keyword.Bluemix_notm}} Block Storage para salvar dados persistentes no armazenamento de bloco. Em seguida, é possível [criar um novo](cs_storage_block.html#add_block) armazenamento de bloco ou [usar um existente](cs_storage_block.html#existing_block) para seu cluster.</td>
</tr>
<tr>
<td>13 de abril</td>
<td>[Novo tutorial para migrar apps Cloud Foundry para clusters](cs_tutorials_cf.html#cf_tutorial)</td>
<td>Você tem um app Cloud Foundry? Saiba como implementar o mesmo código desse app em um contêiner executado em um cluster do Kubernetes.</td>
</tr>
<tr>
<td>05 de abril</td>
<td>[Filtrando logs](cs_health.html#filter-logs)</td>
<td>Filtrar logs específicos de serem encaminhados. Os logs podem ser filtrados em relação a um namespace, um nome de contêiner, um nível de log e uma sequência de mensagem específicos.</td>
</tr>
</tbody></table>

## Tópicos populares em março de 2018
{: #mar18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em março de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>16 de março</td>
<td>[Provisionar um cluster bare metal com Cálculo confiável](cs_clusters_planning.html#shared_dedicated_node)</td>
<td>Crie um cluster bare metal que execute o [Kubernetes versão 1.9](cs_versions.html#cs_v19) ou mais recente e ative o Cálculo confiável para verificar os nós do trabalhador com relação à violação.</td>
</tr>
<tr>
<td>14 de março</td>
<td>[Conexão segura com o {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Aprimore seus apps que estão em execução no {{site.data.keyword.containerlong_notm}} requerendo que os usuários se conectem.</td>
</tr>
<tr>
<td>13 de março</td>
<td>[Zona disponível em São Paulo](cs_regions.html)</td>
<td>Bem-vindo São Paulo, Brasil, como uma nova zona na região Sul dos EUA. Se você tiver um firewall, certifique-se de [abrir as portas do firewall](cs_firewall.html#firewall) para essa zona e as outras dentro da região em que seu cluster estiver.</td>
</tr>
<tr>
<td>12 de março</td>
<td>[Acabou de se associar ao {{site.data.keyword.Bluemix_notm}} com uma conta para Teste? Experimente um cluster grátis do Kubernetes!](container_index.html#clusters)</td>
<td>Com uma [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) para teste, é possível implementar um cluster grátis por 30 dias para testar os recursos do Kubernetes.</td>
</tr>
</tbody></table>

## Tópicos populares em fevereiro de 2018
{: #feb18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em fevereiro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td>27 de fevereiro</td>
<td>Imagens de Hardware Virtual Machine (HVM) para nós do trabalhador</td>
<td>Aumente o desempenho de E/S de suas cargas de trabalho com imagens de HVM. Ative em cada nó do trabalhador existente usando o [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` ou o [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>26 de fevereiro</td>
<td>[Ajuste automático de escala do KubeDNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>O KubeDNS agora é escalado com seu cluster conforme ele cresce. É possível ajustar as razões de ajuste de escala usando o comando a seguir: `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23 de fevereiro</td>
<td>Visualize o console da web para [criação de log](cs_health.html#view_logs) e [métricas](cs_health.html#view_metrics)</td>
<td>Visualize facilmente os dados de log e de métrica em seu cluster e seus componentes com uma UI da Web melhorada. Veja suas páginas de detalhes do cluster para obter acesso.</td>
</tr>
<tr>
<td>20 de fevereiro</td>
<td>Imagens criptografados e [conteúdo assinado e confiável](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>No {{site.data.keyword.registryshort_notm}}, é possível assinar e criptografar imagens para assegurar a sua integridade ao armazenar as imagens em seu namespace de registro. Execute suas instâncias de contêiner usando somente conteúdo confiável.</td>
</tr>
<tr>
<td>19 de fevereiro</td>
<td>[Configurar a VPN IPSec do strongSwan](cs_vpn.html#vpn-setup)</td>
<td>Implemente rapidamente o gráfico Helm da VPN IPSec strongSwan para conectar seu cluster do {{site.data.keyword.containerlong_notm}} de forma segura a seu data center no local sem um Virtual Router Appliance.</td>
</tr>
<tr>
<td>14 de fevereiro</td>
<td>[ Zona disponível em Seul ](cs_regions.html)</td>
<td>No prazo dos Jogos Olímpicos, implemente um cluster do Kubernetes para Seul na região Norte AP. Se você tiver um firewall, certifique-se de [abrir as portas do firewall](cs_firewall.html#firewall) para essa zona e as outras dentro da região em que seu cluster estiver.</td>
</tr>
<tr>
<td>08 de fevereiro</td>
<td>[Atualizar o Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>Revise as mudanças a serem feitas em seus clusters antes de atualizar para o Kubernetes 1.9.</td>
</tr>
</tbody></table>

## Tópicos populares em janeiro de 2018
{: #jan18}

<table summary="A tabela mostra tópicos populares. Linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em janeiro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<td>25 de janeiro</td>
<td>[Registro global disponível](../services/Registry/registry_overview.html#registry_regions)</td>
<td>Com o {{site.data.keyword.registryshort_notm}}, você pode usar o `registry.bluemix.net` global para puxar imagens públicas fornecidas pela IBM.</td>
</tr>
<tr>
<td>23 de janeiro</td>
<td>[Zonas disponíveis em Singapura e Montreal, CA](cs_regions.html)</td>
<td>Singapura e Montreal são zonas disponíveis nas regiões Norte de AP e Leste dos EUA do {{site.data.keyword.containerlong_notm}}. Se você tiver um firewall, certifique-se de [abrir as portas de firewall](cs_firewall.html#firewall) para essas zonas e as outras dentro da região em que seu cluster está.</td>
</tr>
<tr>
<td>08 de janeiro</td>
<td>[Enhanced sabores disponíveis](cs_cli_reference.html#cs_machine_types)</td>
<td>Os tipos de máquina virtual de série 2 incluem armazenamento SSD local e criptografia de disco. [Mova suas cargas de trabalho](cs_cluster_update.html#machine_type) para esses tipos para melhor desempenho e estabilidade.</td>
</tr>
</tbody></table>

## Bate-papo com desenvolvedores com os mesmos interesses no Slack
{: #slack}

É possível ver sobre o que os outros estão falando e fazer as suas próprias perguntas no [{{site.data.keyword.containerlong_notm}} Slack. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com)
{:shortdesc}

Se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}}, [solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para essa Folga.
{: tip}
