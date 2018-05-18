---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Tópicos populares para {{site.data.keyword.containershort_notm}}
{: #cs_popular_topics}

Verifique quais desenvolvedores de contêiner estão interessados em aprender sobre o {{site.data.keyword.containerlong}}.
{:shortdesc}

## Tópicos populares em março de 2018
{: #mar18}

<table summary="A tabela mostra os tópicos populares. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
<caption>Tópicos populares para contêineres e clusters do Kubernetes em fevereiro de 2018</caption>
<thead>
<th>Data</th>
<th>Título (Title)</th>
<th>Descrição</th>
</thead>
<tbody>
<tr>
<td> 16 de março</td>
<td>[Provisionar um cluster bare metal com Cálculo confiável](cs_clusters.html#shared_dedicated_node)</td>
<td>Crie um cluster bare metal que execute o [Kubernetes versão 1.9](cs_versions.html#cs_v19) ou mais recente e ative o Cálculo confiável para verificar os nós do trabalhador com relação à violação.</td>
</tr>
<tr>
<td>14 de março</td>
<td>[Conexão segura com o {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Aprimore seus apps que estão em execução no {{site.data.keyword.containershort_notm}} requerendo que os usuários se conectem.</td>
</tr>
<tr>
<td>13 de março</td>
<td>[Local disponível em São Paulo](cs_regions.html)</td>
<td>Bem-vindo São Paulo, Brasil, como um novo local na região sul dos EUA. Se você tiver um firewall, certifique-se de [abrir as portas necessárias do firewall](cs_firewall.html#firewall) para esse local, assim como as outras na região em que seu cluster estiver.</td>
</tr>
<tr>
<td>12 de março</td>
<td>[Acabou de se associar ao {{site.data.keyword.Bluemix_notm}} com uma conta para Teste? Experimente um cluster grátis do Kubernetes!](container_index.html#clusters)</td>
<td>Com uma [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) para Teste, é possível implementar 1 cluster grátis por 21 dias para testar os recursos do Kubernetes.</td>
</tr>
</tbody></table>

## Tópicos populares em fevereiro de 2018
{: #feb18}

<table summary="A tabela mostra os tópicos populares. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
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
<td>Aumente o desempenho de E/S de suas cargas de trabalho com imagens de HVM. Ative em cada nó do trabalhador existente usando o [comando](cs_cli_reference.html#cs_worker_reload) `bx cs worker-reload` ou o [comando](cs_cli_reference.html#cs_worker_update) `bx cs worker-update`.</td>
</tr>
<tr>
<td>26 de fevereiro</td>
<td>[Ajuste automático de escala do KubeDNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>O KubeDNS agora é escalado com seu cluster conforme ele cresce. É possível ajustar as razões de ajuste de escala usando o comando a seguir: `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23 de fevereiro</td>
<td>Visualize a UI da web para [criação de log](cs_health.html#view_logs) e [métricas](cs_health.html#view_metrics)</td>
<td>Visualize facilmente os dados de log e de métrica em seu cluster e seus componentes com uma UI da Web melhorada. Veja suas páginas de detalhes do cluster para obter acesso.</td>
</tr>
<tr>
<td>20 de fevereiro</td>
<td>Imagens criptografados e [conteúdo assinado e confiável](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>No {{site.data.keyword.registryshort_notm}}, é possível assinar e criptografar imagens para assegurar sua integridade ao armazenar em seu namespace de registro. Construa contêineres usando somente conteúdo confiável.</td>
</tr>
<tr>
<td>19 de fevereiro</td>
<td>[Configurar a VPN IPSec do strongSwan](cs_vpn.html#vpn-setup)</td>
<td>Implemente rapidamente o gráfico Helm da VPN IPSec do strongSwan para conectar seu cluster do {{site.data.keyword.containershort_notm}} de forma segura a seu data center no local sem um Vyatta.</td>
</tr>
<tr>
<td>14 de fevereiro</td>
<td>[Local disponível em Seul](cs_regions.html)</td>
<td>No prazo dos Jogos Olímpicos, implemente um cluster do Kubernetes para Seul na região Norte AP. Se você tiver um firewall, certifique-se de [abrir as portas necessárias do firewall](cs_firewall.html#firewall) para esse local, assim como as outras na região em que seu cluster estiver.</td>
</tr>
<tr>
<td>8 de fevereiro</td>
<td>[Atualizar o Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>Revise as mudanças feitas em seus clusters antes de atualizar o Kubernetes 1.9.</td>
</tr>
</tbody></table>

## Tópicos populares em janeiro de 2018
{: #jan18}

<table summary="A tabela mostra os tópicos populares. As linhas devem ser lidas da esquerda para a direita, com a data na coluna um, o título do recurso na coluna dois e uma descrição na coluna três.">
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
<td>[Locais disponíveis em Singapura e Montreal, CA](cs_regions.html)</td>
<td>Singapura e Montreal são locais disponíveis nas regiões Norte AP e Leste dos EUA do {{site.data.keyword.containershort_notm}}. Se você tiver um firewall, certifique-se de [abrir a portas de firewall necessárias](cs_firewall.html#firewall) para esses locais, assim como os outros na região em que seu cluster está.</td>
</tr>
<tr>
<td>8 de janeiro</td>
<td>[Tipos de máquina aprimorados disponíveis](cs_cli_reference.html#cs_machine_types)</td>
<td>Os tipos de máquina da Série 2 incluem armazenamento SSD local e criptografia de disco. [Migre suas cargas de trabalho](cs_cluster_update.html#machine_type) para esses tipos de máquina para melhor desempenho e estabilidade.</td>
</tr>
</tbody></table>

## Bate-papo com desenvolvedores com os mesmos interesses no Slack
{: #slack}

É possível ver sobre o que os outros estão falando e fazer suas próprias perguntas no [{{site.data.keyword.containershort_notm}} Slack. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com)
{:shortdesc}

Dica: se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}},
[solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para esse Slack.
