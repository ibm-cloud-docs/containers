---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-30"

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

O {{site.data.keyword.containershort}} fornece ferramentas poderosas, combinando s tecnologias Docker e Kubernetes, uma experiência intuitiva do usuário e a segurança e o isolamento integrados para automatizar a implementação, a operação, o ajuste de escala e o monitoramento de apps conteinerizados em um cluster de hosts de cálculo.
{:shortdesc}

## Benefícios de usar o serviço
{: #benefits}

Os clusters são implementados em hosts de cálculo que fornecem Kubernetes nativos e recursos específicos do {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Benefício|Descrição|
|-------|-----------|
|Clusters do Kubernetes de locatário único com isolamento de infraestrutura de cálculo, de rede e de armazenamento|<ul><li>Crie sua própria infraestrutura customizada que atenda aos requisitos de sua organização.</li><li>Provisione um mestre do Kubernetes dedicado e seguro, nós do trabalhador, redes virtuais e armazenamento usando os recursos fornecidos pela infraestrutura do IBM Cloud (SoftLayer).</li><li>O mestre do Kubernetes totalmente gerenciado que é continuamente monitorado e atualizado pelo {{site.data.keyword.IBM_notm}} para manter seu cluster disponível.</li><li>Armazene dados persistentes, compartilhar dados entre pods do Kubernetes e restaure dados quando necessário com o
serviço de volume integrado e seguro.</li><li>Benefício do suporte integral para todas as APIs nativas do Kubernetes.</li></ul>|
|Conformidade de segurança de imagem com o Vulnerability Advisor|<ul><li>Configure seu próprio registro de imagem privada assegurada do Docker no qual as imagens são armazenadas e compartilhadas por todos
os usuários na organização.</li><li>Benefício de varredura automática de imagens em seu registro privado do {{site.data.keyword.Bluemix_notm}}.</li><li>Revise as recomendações específicas para o sistema operacional usado na imagem para corrigir potenciais
vulnerabilidades.</li></ul>|
|Monitoramento contínuo do funcionamento do cluster|<ul><li>Use o painel de cluster para ver e gerenciar rapidamente o funcionamento de seu cluster, os nós do trabalhador
e as implementações de contêiner.</li><li>Localize métricas detalhadas de consumo usando o {{site.data.keyword.monitoringlong}} e expanda rapidamente o seu cluster para atender cargas de trabalho.</li><li>Revise as informações de criação de log usando o {{site.data.keyword.loganalysislong}} para ver atividades detalhadas do cluster.</li></ul>|
|Exposição segura de apps ao público|<ul><li>Escolha entre um endereço IP público, uma rota fornecida pela {{site.data.keyword.IBM_notm}} ou seu próprio domínio customizado para acessar serviços em seu cluster por meio da Internet.</li></ul>|
|Integração de serviço do {{site.data.keyword.Bluemix_notm}}|<ul><li>Inclua recursos extras no app por meio da integração de serviços do {{site.data.keyword.Bluemix_notm}}, como APIs do Watson, Blockchain, serviços de dados ou Internet of Things.</li></ul>|



<br />


## Comparação de clusters grátis e padrão
{: #cluster_types}

É possível criar um cluster grátis ou qualquer número de clusters padrão. Experimente clusters grátis para familiarizar-se e testar alguns recursos do Kubernetes ou crie clusters padrão para usar os recursos integrais do Kubernetes para implementar apps.
{:shortdesc}

|Características|Clusters grátis|Clusters padrão|
|---------------|-------------|-----------------|
|[Rede em cluster](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app de rede pública por um serviço NodePort](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Gerenciamento de acesso do usuário](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao serviço {{site.data.keyword.Bluemix_notm}} do cluster e apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Espaço em disco no nó do trabalhador para armazenamento](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Armazenamento persistente baseado em arquivo NFS com volumes](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app de rede pública ou privada por um serviço de balanceador de carga](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Acesso ao app de rede pública por um serviço de Ingresso](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Endereços IP públicos móveis](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Criando log e monitorando](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|
|[Disponível no {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Recurso disponível" style="width:32px;" />|

<br />



## Responsabilidades de gerenciamento de cluster
{: #responsibilities}

Revise as responsabilidades que você compartilha com a IBM para gerenciar seus clusters.
{:shortdesc}

**A IBM é responsável por:**

- Implementar o mestre, os nós do trabalhador e componentes de gerenciamento dentro do cluster, como o controlador do Ingresso, no momento da criação do cluster
- Gerenciar as atualizações, o monitoramento e a recuperação do mestre do Kubernetes para o cluster
- Monitorar o funcionamento dos nós do trabalhador e fornecer automação para a atualização e a recuperação dos nós do trabalhador
- Executar tarefas de automação em sua conta de infraestrutura, incluindo adicionar nós do trabalhador, remover nós do trabalhador e criar uma sub-rede padrão
- Gerenciar, atualizar e recuperar componentes operacionais dentro do cluster, como o controlador do Ingresso e o plug-in de armazenamento
- Provisionar volumes de armazenamento quando solicitado pelas solicitações de volume persistente
- Fornecer configurações de segurança em todos os nós do trabalhador

</br>
**Você é responsável por:**

- [Implementar e gerenciar recursos do Kubernetes, como pods, serviços e implementações no cluster](cs_app.html#app_cli)
- [Usar os recursos do serviço e o Kubernetes para assegurar a alta disponibilidade de apps](cs_app.html#highly_available_apps)
- [Incluir ou remover capacidade usando a CLI para incluir ou remover nós do trabalhador](cs_cli_reference.html#cs_worker_add)
- [Criar VLANs públicas e privadas na infraestrutura do IBM Cloud (SoftLayer) para isolamento da rede de seu cluster](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [Assegurar que todos os nós do trabalhador tenham conectividade de rede com a URL do mestre](cs_firewall.html#firewall) <p>**Nota**: se um nó do trabalhador possuir duas VLANs públicas e privadas, a conectividade de rede será configurada. Se o nó do trabalhador tiver somente uma VLAN privada configurada, então um Vyatta é necessário para fornecer conectividade de rede.</p>
- [Atualizar o mestre kube-apiserver e os nós do trabalhador quando atualizações de versão principal ou secundária do Kubernetes estão disponíveis](cs_cluster_update.html#master)
- [Recuperando nós do trabalhador problemáticos executando comandos `kubectl`, como `cordon` ou `drain`, e executando comandos `bx cs`, como `reboot`, `reload` ou `delete`](cs_cli_reference.html#cs_worker_reboot)
- [Incluindo ou removendo sub-redes na infraestrutura do IBM Cloud (SoftLayer) conforme necessário](cs_subnets.html#subnets)
- [Fazer backup e restaurar dados no armazenamento persistente na infraestrutura do IBM Cloud (SoftLayer) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## Abuso de contêineres
{: #terms}

Os clientes não podem fazer uso inadequado do {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Uso inadequado inclui:

*   Qualquer atividade ilegal
*   Distribuição ou execução de malware
*   Prejudicar o {{site.data.keyword.containershort_notm}} ou interferir no
uso de alguém do {{site.data.keyword.containershort_notm}}
*   Prejudicar ou interferir no uso de alguém de qualquer outro serviço ou sistema
*   Acesso não autorizado a qualquer serviço ou sistema
*   Modificação não autorizada de qualquer serviço ou sistema
*   Violação dos direitos de outros

Veja [Termos dos serviços
de nuvem](/docs/navigation/notices.html#terms) para obter os termos gerais de uso.
