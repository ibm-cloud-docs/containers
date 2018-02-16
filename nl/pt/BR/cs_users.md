---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Designando acesso de usuário para clusters
{: #users}

É possível conceder acesso a um cluster para outros usuários em sua organização para assegurar que
somente os usuários autorizados possam trabalhar com o cluster e implementar apps no cluster.
{:shortdesc}




## Gerenciando o acesso ao cluster
{: #managing}

A cada usuário que trabalha com o {{site.data.keyword.containershort_notm}} deve ser designada uma combinação de funções de usuário específicas do serviço que determinam quais ações o usuário pode executar.
{:shortdesc}

<dl>
<dt>Políticas de acesso do {{site.data.keyword.containershort_notm}}</dt>
<dd>No Identity and Access Management, as políticas de acesso do {{site.data.keyword.containershort_notm}} determinam as ações de gerenciamento de cluster que podem ser executadas em um cluster, como criar ou remover clusters e incluir ou remover nós do trabalhador adicionais. Essas políticas devem ser configuradas em conjunto com políticas de infraestrutura.</dd>
<dt>Políticas de acesso de infraestrutura</dt>
<dd>No Identity and Access Management, as políticas de acesso de infraestrutura permitem que as ações que são solicitadas da interface com o usuário do {{site.data.keyword.containershort_notm}} ou da CLI sejam concluídas na infraestrutura do IBM Cloud (SoftLayer). Essas políticas devem ser configuradas em conjunto com as políticas de acesso do {{site.data.keyword.containershort_notm}}. [Saiba mais sobre as funções de infraestrutura disponíveis](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Grupos de recursos</dt>
<dd>Um grupo de recursos é uma maneira de organizar serviços do {{site.data.keyword.Bluemix_notm}} em agrupamentos para que seja possível designar rapidamente acesso de usuário para mais de um recurso por vez. [Saiba como gerenciar os usuários que estão usando grupos de recursos](/docs/admin/resourcegroups.html#rgs).</dd>
<dt>Funções do Cloud Foundry</dt>
<dd>No Identity and Access Management, cada usuário deve ser designado a uma função de usuário do Cloud Foundry. Essa função determina as ações que o usuário pode executar na conta do {{site.data.keyword.Bluemix_notm}}, como convidar outros usuários ou visualizar o uso de cota. [Saiba mais sobre as funções do Cloud Foundry disponíveis](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Funções RBAC do Kubernetes</dt>
<dd>Cada usuário que é designado a uma política de acesso do {{site.data.keyword.containershort_notm}} é automaticamente designada à função RBAC do Kubernetes. No Kubernetes, as funções RBAC determinam as ações que podem ser executadas em recursos do Kubernetes dentro do cluster. As funções RBAC são configuradas somente para o namespace padrão. O administrador de cluster pode incluir funções RBAC para outros namespaces no cluster. Veja [Usando a autorização RBAC ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) na documentação do Kubernetes para obter mais informações.</dd>
</dl>

<br />


## Políticas de acesso e permissões
{: #access_policies}

Revise as políticas e permissões de acesso que é possível conceder aos usuários em sua conta do {{site.data.keyword.Bluemix_notm}}. As funções de operador e editor têm permissões separadas. Se você deseja que um usuário, por exemplo, inclua nós do trabalhador e serviços de ligação, deve-se designar ao usuário as funções de operador e editor.

|Política de acesso do {{site.data.keyword.containershort_notm}}|Permissões de gerenciamento de cluster|Permissões de recursos do Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrator|Essa função herda permissões do Editor, do Operador e funções do Visualizador para todos os clusters
nessa conta. <br/><br/>Quando configurado para todas as instâncias de serviço atuais:<ul><li>Criar um cluster lite ou padrão</li><li>Configure credenciais para uma conta do {{site.data.keyword.Bluemix_notm}} para acessar o portfólio da infraestrutura do IBM Cloud (SoftLayer)</li><li>Remover um Cluster</li><li>Designar e mudar as políticas de acesso do {{site.data.keyword.containershort_notm}} para outros usuários existentes nessa conta.</li></ul><p>Quando configurado para um ID do cluster específico:<ul><li>Remover um cluster específico</li></ul></p>Política de acesso de infraestrutura correspondente: superusuário<br/><br/><b>Observação</b>: para criar recursos como máquinas, VLANs e sub-redes, os usuários precisam da função de infraestrutura do **Superusuário**.|<ul><li>Função RBAC: cluster-admin</li><li>Acesso de leitura/gravação para recursos em cada namespace</li><li>Criar funções dentro de um namespace</li><li>Acessar o painel do Kubernetes</li><li>Crie um recurso Ingresso que torne os aplicativos disponíveis</li></ul>|
|Operador|<ul><li>Incluir nós do trabalhador adicionais em um cluster</li><li>Remover nós do trabalhador de um cluster</li><li>Reinicializar um nó do trabalhador</li><li>Recarregar um nó do trabalhador</li><li>Incluir uma sub-rede em um cluster</li></ul><p>Política de acesso à infraestrutura correspondente: usuário básico</p>|<ul><li>Função do RBAC: administrador</li><li>Acesso de leitura/gravação para recursos dentro do namespace padrão, mas não no próprio namespace</li><li>Criar funções dentro de um namespace</li></ul>|
|Aplicativos <br/><br/><b>Dica</b>: utilize essa função para desenvolvedores de aplicativo.|<ul><li>Ligar um serviço do {{site.data.keyword.Bluemix_notm}} a um cluster.</li><li>Desvincular um serviço do {{site.data.keyword.Bluemix_notm}} para um cluster.</li><li>Criar um webhook.</li></ul><p>Política de acesso à infraestrutura correspondente: usuário básico|<ul><li>Funções RBAC: editar</li><li>Acesso de leitura/gravação para recursos dentro do namespace padrão</li></ul></p>|
|Viewer|<ul><li>Listar um cluster</li><li>Visualizar detalhes para um cluster</li></ul><p>Política de acesso de infraestrutura correspondente: somente visualizar</p>|<ul><li>Funções RBAC: visualização</li><li>Acesso de leitura para recursos dentro do namespace padrão</li><li>Nenhum acesso de leitura para segredos do Kubernetes</li></ul>|

|Política de acesso do Cloud Foundry|Permissões de gerenciamento de conta|
|-------------|------------------------------|
|Função de organização: gerenciador|<ul><li>Incluir usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Função de espaço: desenvolvedor|<ul><li>Criar instâncias de serviço do
{{site.data.keyword.Bluemix_notm}}</li><li>Ligar instâncias de serviço do {{site.data.keyword.Bluemix_notm}} a clusters</li></ul>| 

<br />


## Incluindo usuários em uma conta do {{site.data.keyword.Bluemix_notm}}
{: #add_users}

É possível incluir usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}} para conceder acesso aos seus clusters.

Antes de iniciar, verifique se você foi designado à função de Gerenciador do Cloud Foundry para uma conta do {{site.data.keyword.Bluemix_notm}}.

1.  [Inclua o usuário na conta](../iam/iamuserinv.html#iamuserinv).
2.  Na seção **Acesso**, expanda **Serviços**.
3.  Designe uma função de acesso do {{site.data.keyword.containershort_notm}}. Na lista suspensa **Designar acesso a**, decida se você deseja conceder acesso somente à sua conta do {{site.data.keyword.containershort_notm}} (**Recurso**) ou a uma coleção de vários recursos dentro de sua conta (**Grupo de recursos**).
  -  Para **Recurso**:
      1. Na lista suspensa **Serviços**, selecione **{{site.data.keyword.containershort_notm}}**.
      2. Na lista suspensa **Região**, selecione a região para a qual convidar o usuário.
      3. Na lista suspensa **Instância de serviço**, selecione o cluster para o qual convidar o usuário. Para localizar o ID de um cluster específico, execute `bx cs clusters`.
      4. Na seção **Selecionar funções**, escolha uma função. Para localizar uma lista de ações suportadas por função, consulte [Políticas e permissões de
acesso](#access_policies).
  - Para **Grupo de recursos**:
      1. Na lista suspensa **Grupo de recursos**, selecione o grupo de recursos que inclui permissões para o recurso {{site.data.keyword.containershort_notm}} de sua conta.
      2. Na lista suspensa **Designar acesso a um grupo de recursos**, selecione uma função. Para localizar uma lista de ações suportadas por função, consulte [Políticas e permissões de
acesso](#access_policies).
4. [Opcional: designe uma infraestrutura de função](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Opcional: designe uma função do Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. Clique em **Convidar usuários**.

<br />


## Customizando as permissões de infraestrutura para um usuário
{: #infra_access}

Quando você configura políticas de infraestrutura no Identity and Access Management, um usuário recebe permissões associadas a uma função. Para customizar essas permissões, deve-se efetuar login na infraestrutura do IBM Cloud (SoftLayer) e ajustar as permissões nesse local.
{: #view_access}

Por exemplo, os usuários básicos podem reinicializar um nó do trabalhador, mas não podem recarregar um nó do trabalhador. Sem dar a essa pessoa permissões de superusuário, é possível ajustar as permissões da infraestrutura do IBM Cloud (SoftLayer) e incluir a permissão para executar um comando de recarregamento.

1.  Efetue login em sua conta de infraestrutura do IBM Cloud (SoftLayer).
2.  Selecione um perfil de usuário para atualizar.
3.  Em **Permissões do portal**, customize o acesso de usuário. Por exemplo, para incluir a permissão de recarregamento, na guia **Dispositivos**, selecione **Emitir recarregas do S.O e inicializar o kernel de resgate**.
9.  Salve as suas mudanças.
