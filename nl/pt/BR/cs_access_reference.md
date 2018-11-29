---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Permissões de acesso de
{: #understanding}



Ao [designar permissões de cluster](cs_users.html), pode ser difícil julgar qual função precisa ser designada a um usuário. Use as tabelas nas seções a seguir para determinar o nível mínimo de permissões que são necessárias para executar tarefas comuns no {{site.data.keyword.containerlong}}.
{: shortdesc}

## Plataforma IAM e Kubernetes RBAC
{: #platform}

O {{site.data.keyword.containerlong_notm}} é configurado para usar funções do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM). As funções da plataforma IAM determinam as ações que os usuários podem executar em um cluster. Cada usuário que é designado a uma função da plataforma IAM também é designado automaticamente a uma função correspondente de controle de acesso baseado na função (RBAC) do Kubernetes no namespace padrão. Além disso, as funções da plataforma IAM configuram automaticamente as permissões de infraestrutura básica para os usuários. Para configurar políticas do IAM, veja [Designando permissões da plataforma IAM](cs_users.html#platform). Para saber mais sobre funções RBAC, veja [Designando permissões de RBAC](cs_users.html#role-binding).

A tabela a seguir mostra as permissões de gerenciamento de cluster concedidas por cada função da plataforma IAM e as permissões de recurso do Kubernetes para as funções RBAC correspondentes.

<table>
  <tr>
    <th>Função da plataforma IAM</th>
    <th>Permissões de gerenciamento de cluster</th>
    <th>Função RBAC Correspondente e Permissões de Recursos</th>
  </tr>
  <tr>
    <td>**Viewer**</td>
    <td>
      Cluster:<ul>
        <li>Visualizar o nome e o endereço de e-mail para o proprietário da chave API do IAM para um grupo de recursos e região</li>
        <li>Se a sua conta do {{site.data.keyword.Bluemix_notm}} usar credenciais diferentes para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer), visualizar o nome do usuário da infraestrutura</li>
        <li>Listar todos ou visualizar detalhes para clusters, nós do trabalhador, conjuntos de trabalhadores, serviços em um cluster e webhooks</li>
        <li>Visualize o status do VLAN Spanning para a conta de infraestrutura</li>
        <li>Listar sub-redes disponíveis na conta de infraestrutura</li>
        <li>Quando configurado para um cluster: listar VLANs às quais o cluster está conectado em uma zona</li>
        <li>Quando configurado para todos os clusters na conta: listar todas as VLANs disponíveis em uma zona</li></ul>
      Criação de Log:<ul>
        <li>Visualizar o terminal de criação de log padrão para a região de destino</li>
        <li>Listar ou visualizar detalhes para configurações de encaminhamento e de filtragem de log</li>
        <li>Visualizar o status para atualizações automáticas do complemento Fluentd</li></ul>
      Ingresso:<ul>
        <li>Listar todos ou visualizar detalhes para ALBs em um cluster</li>
        <li>Visualizar tipos de ALB que são suportados na região</li></ul>
    </td>
    <td>A função de cluster <code>view</code> é aplicada pela ligação de função <code>ibm-view</code>, fornecendo as permissões a seguir no namespace <code>default</code>:<ul>
      <li>Acesso de leitura para recursos dentro do namespace padrão</li>
      <li>Nenhum acesso de leitura para segredos do Kubernetes</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Aplicativos** <br/><br/><strong>Dica</strong>: use essa função para desenvolvedores de aplicativos e designe a função **Desenvolvedor** do <a href="#cloud-foundry">Cloud Foundry</a>.</td>
    <td>Essa função tem todas as permissões da função Visualizador, além do seguinte:</br></br>
      Cluster:<ul>
        <li>Ligar e desvincular serviços do {{site.data.keyword.Bluemix_notm}} a um cluster</li></ul>
      Criação de Log:<ul>
        <li>Criar, atualizar e excluir webhooks de auditoria do servidor de API</li>
        <li>Criar webhooks de cluster</li>
        <li>Criar e excluir configurações de encaminhamento de logs para todos os tipos, exceto `kube-audit`</li>
        <li>Atualizar e atualizar configurações de encaminhamento de log</li>
        <li>Criar, atualizar e excluir configurações de filtragem de log</li></ul>
      Ingresso:<ul>
        <li>Ativar ou desativar ALBs</li></ul>
    </td>
    <td>A função de cluster <code>edit</code> é aplicada pela ligação de função <code>ibm-edit</code>, fornecendo as permissões a seguir no namespace <code>default</code>:
      <ul><li>Acesso de leitura/gravação para recursos dentro do namespace padrão</li></ul></td>
  </tr>
  <tr>
    <td>**Operador**</td>
    <td>Essa função tem todas as permissões da função Visualizador, além do seguinte:</br></br>
      Cluster:<ul>
        <li>Atualizar um cluster</li>
        <li>Atualize o mestre do Kubernetes</li>
        <li>Incluir e remover nós do trabalhador</li>
        <li>Reinicializar, recarregar e atualizar nós do trabalhador</li>
        <li>Criar e excluir conjuntos de trabalhadores</li>
        <li>Incluir e remover zonas de conjuntos de trabalhadores</li>
        <li>Atualize a configuração de rede para uma determinada zona em conjuntos de trabalhadores</li>
        <li>Redimensionar e rebalancear os conjuntos de</li>
        <li>Criar e incluir sub-redes em um cluster</li>
        <li>Incluir e remover sub-redes gerenciadas pelo usuário para e de um cluster</li></ul>
    </td>
    <td>A função de cluster <code>admin</code> é aplicada pela ligação de função de cluster <code>ibm-operate</code>, fornecendo as permissões a seguir:<ul>
      <li>Acesso de leitura/gravação para recursos dentro de um namespace, mas não para o próprio namespace</li>
      <li>Criar funções RBAC em um namespace</li></ul></td>
  </tr>
  <tr>
    <td>**Administrator**</td>
    <td>Essa função tem todas as permissões das funções Editor, Operador e Visualizador para todos os clusters nessa conta, além do seguinte:</br></br>
      Cluster:<ul>
        <li>Criar clusters grátis ou padrão</li>
        <li>Excluir clusters</li>
        <li>Criptografar segredos do Kubernetes usando  {{site.data.keyword.keymanagementservicefull}}</li>
        <li>Configurar a chave API para a conta do {{site.data.keyword.Bluemix_notm}} para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer) vinculado</li>
        <li>Configurar, visualizar e remover credenciais de infraestrutura para a conta do {{site.data.keyword.Bluemix_notm}} para acessar um portfólio de infraestrutura do IBM Cloud (SoftLayer) diferente</li>
        <li>Designar e mudar funções da plataforma IAM para outros usuários existentes na conta</li>
        <li>Quando configurado para todas as instâncias do {{site.data.keyword.containerlong_notm}} (clusters) em todas as regiões: listar todas as VLANs disponíveis na conta</ul>
      Criação de Log:<ul>
        <li>Criar e atualizar configurações de encaminhamento de log para o tipo `kube-audit`</li>
        <li>Coletar uma captura instantânea de logs do servidor de API em um bucket do {{site.data.keyword.cos_full_notm}}</li>
        <li>Ativar e desativar atualizações automáticas para o complemento de cluster Fluentd</li></ul>
      Ingresso:<ul>
        <li>Listar todos ou visualizar detalhes para segredos do ALB em um cluster</li>
        <li>Implementar um certificado de sua instância do {{site.data.keyword.cloudcerts_long_notm}} para um ALB</li>
        <li>Atualizar ou remover segredos do ALB de um cluster</li></ul>
      <strong>Nota</strong>: para criar recursos, como máquinas, VLANs e sub-redes, os usuários Administradores precisam da função de infraestrutura **Superusuário**.
    </td>
    <td>A função de cluster <code>cluster-admin</code> é aplicada pela ligação de função de cluster <code>ibm-admin</code>, fornecendo as permissões a seguir:
      <ul><li>Acesso de leitura/gravação para recursos em cada namespace</li>
      <li>Criar funções RBAC em um namespace</li>
      <li>Acessar o painel do Kubernetes</li>
      <li>Criar um recurso Ingress que disponibiliza apps publicamente</li></ul>
    </td>
  </tr>
</table>



## Funções do Cloud Foundry
{: #cloud-foundry}

As funções do Cloud Foundry concedem acesso a organizações e espaços dentro da conta. Para ver a lista de serviços baseados no Cloud Foundry no {{site.data.keyword.Bluemix_notm}}, execute `ibmcloud service list`. Para saber mais, veja todas as [funções de organização e espaço](/docs/iam/cfaccess.html) disponíveis ou as etapas para [gerenciar o acesso ao Cloud Foundry](/docs/iam/mngcf.html) na documentação do IAM.

A tabela a seguir mostra as funções do Cloud Foundry necessárias para permissões de ação do cluster.

<table>
  <tr>
    <th>Função do Cloud Foundry</th>
    <th>Permissões de gerenciamento de cluster</th>
  </tr>
  <tr>
    <td>Função de espaço: gerenciador</td>
    <td>Gerenciar acesso de usuário a um espaço do  {{site.data.keyword.Bluemix_notm}}</td>
  </tr>
  <tr>
    <td>Função de espaço: desenvolvedor</td>
    <td>
      <ul><li>Criar instâncias de serviço do
{{site.data.keyword.Bluemix_notm}}</li>
      <li>Ligar instâncias de serviço do {{site.data.keyword.Bluemix_notm}} a clusters</li>
      <li>Visualizar logs da configuração de encaminhamento de logs de um cluster no nível de espaço</li></ul>
    </td>
  </tr>
</table>

## Funções de infraestrutura
{: #infra}

**Nota**: quando um usuário com a função de acesso de infraestrutura **Superusuário** [configura a chave API para uma região e um grupo de recursos](cs_users.html#api_key), as permissões de infraestrutura para os outros usuários na conta são configuradas pelas funções da plataforma IAM. Não é necessário editar as permissões de infraestrutura do IBM Cloud (SoftLayer) dos outros usuários. Use a tabela a seguir para customizar permissões de infraestrutura do IBM Cloud (SoftLayer) dos usuários somente quando não puder designar **Superusuário** ao usuário que configura a chave API. Para obter mais informações, veja [Customizando permissões de infraestrutura](cs_users.html#infra_access).

A tabela a seguir mostra as permissões de infraestrutura necessárias para concluir grupos de tarefas comuns.

<table summary="Permissões de infraestrutura para cenários comuns do {{site.data.keyword.containerlong_notm}}.">
 <caption>Permissões de infraestrutura normalmente necessárias para o {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Tarefas comuns no {{site.data.keyword.containerlong_notm}}</th>
  <th>Permissões de infraestrutura necessárias por guia</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Permissões mínimas</strong>: <ul><li>Crie um cluster.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Visualize os detalhes do Virtual Server</li><li>Reinicializar o servidor e visualizar informações do sistema IPMI</li><li>Emitir recarregamentos de OS e iniciar o kernel de resgate</li></ul><strong>Conta</strong>: <ul><li>Incluir servidor</li></ul></td>
   </tr>
   <tr>
     <td><strong>Administração de cluster</strong>: <ul><li>Criar, atualizar e excluir clusters.</li><li>Incluir, recarregar e reinicializar nós do trabalhador.</li><li>Visualizar VLANs.</li><li>Criar sub-redes.</li><li>Implementar pods e serviços do balanceador de carga.</li></ul></td>
     <td><strong>Suporte</strong>:<ul><li>Visualizar chamados</li><li>Incluir chamados</li><li>Editar chamados</li></ul>
     <strong>Dispositivos</strong>:<ul><li>Visualizar detalhes do hardware</li><li>Visualize os detalhes do Virtual Server</li><li>Reinicializar o servidor e visualizar informações do sistema IPMI</li><li>Emitir recarregamentos de OS e iniciar o kernel de resgate</li></ul>
     <strong>Rede</strong>:<ul><li>Incluir cálculo com porta de rede pública</li></ul>
     <strong>Conta</strong>:<ul><li>Cancelar servidor</li><li>Incluir servidor</li></ul></td>
   </tr>
   <tr>
     <td><strong>Armazenamento</strong>: <ul><li>Criar solicitações de volume persistente para provisionar volumes persistentes.</li><li>Criar e gerenciar recursos de infraestrutura de armazenamento.</li></ul></td>
     <td><strong>Serviços</strong>:<ul><li>Gerenciar armazenamento</li></ul><strong>Conta</strong>:<ul><li>Incluir armazenamento</li></ul></td>
   </tr>
   <tr>
     <td><strong>Rede privada</strong>: <ul><li>Gerenciar VLANs privadas para rede em cluster.</li><li>Configurar a conectividade VPN para redes privadas.</li></ul></td>
     <td><strong>Rede</strong>:<ul><li>Gerenciar rotas de sub-rede da rede</li></ul></td>
   </tr>
   <tr>
     <td><strong>Rede pública</strong>:<ul><li>Configurar o balanceador de carga pública ou rede de Ingresso para expor apps.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Editar nome do host/domínio</li><li>Gerenciar controle de porta</li></ul>
     <strong>Rede</strong>:<ul><li>Incluir cálculo com porta de rede pública</li><li>Gerenciar rotas de sub-rede da rede</li><li>Incluir endereços IP</li></ul>
     <strong>Serviços</strong>:<ul><li>Gerenciar DNS, DNS reverso e WHOIS</li><li>Visualizar certificados (SSL)</li><li>Gerenciar certificados (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
