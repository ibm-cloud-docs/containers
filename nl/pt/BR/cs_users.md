---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


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

É possível conceder acesso a um cluster do Kubernetes para assegurar que somente os usuários autorizados possam trabalhar com o cluster e implementar contêineres para o cluster no {{site.data.keyword.containerlong}}.
{:shortdesc}


## Planejando processos de comunicação
Como um administrador de cluster, considere como pode estabelecer um processo de comunicação para os membros de sua organização para comunicar solicitações de acesso a você para que mantenha-se organizado.
{:shortdesc}

Forneça instruções para seus usuários do cluster sobre como solicitar acesso a um cluster ou como obter ajuda com quaisquer tipos de tarefas comuns de um administrador de cluster. Como o Kubernetes não facilita esse tipo de comunicação, cada equipe pode ter variações em seu processo preferencial.

Você pode escolher qualquer um dos métodos a seguir ou estabelecer seu próprio método.
- Criar um sistema de chamado
- Criar um modelo de formulário
- Crie uma página da wiki
- Requerer uma solicitação de e-mail
- Use o método de rastreamento de problema que você já usa para controlar o trabalho diário de sua equipe


## Gerenciando o acesso ao cluster
{: #managing}

A cada usuário que trabalha com o {{site.data.keyword.containershort_notm}} deve ser designada uma combinação de funções de usuário específicas do serviço que determinam quais ações o usuário pode executar.
{:shortdesc}

<dl>
<dt>Políticas de acesso do {{site.data.keyword.containershort_notm}}</dt>
<dd>No Identity and Access Management, as políticas de acesso do {{site.data.keyword.containershort_notm}} determinam as ações de gerenciamento de cluster que podem ser executadas em um cluster, como criar ou remover clusters e incluir ou remover nós do trabalhador adicionais. Essas políticas devem ser configuradas em conjunto com políticas de infraestrutura. É possível conceder acesso a clusters em uma base regional.</dd>
<dt>Políticas de acesso de infraestrutura</dt>
<dd>No Identity and Access Management, as políticas de acesso de infraestrutura permitem que as ações que são solicitadas da interface com o usuário do {{site.data.keyword.containershort_notm}} ou da CLI sejam concluídas na infraestrutura do IBM Cloud (SoftLayer). Essas políticas devem ser configuradas em conjunto com as políticas de acesso do {{site.data.keyword.containershort_notm}}. [Saiba mais sobre as funções de infraestrutura disponíveis](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Grupos de recursos</dt>
<dd>Um grupo de recursos é uma maneira de organizar serviços do {{site.data.keyword.Bluemix_notm}} em agrupamentos para que seja possível designar rapidamente acesso de usuário para mais de um recurso por vez. [Saiba como gerenciar os usuários que estão usando grupos de recursos](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Funções do Cloud Foundry</dt>
<dd>No Identity and Access Management, cada usuário deve ser designado a uma função de usuário do Cloud Foundry. Essa função determina as ações que o usuário pode executar na conta do {{site.data.keyword.Bluemix_notm}}, como convidar outros usuários ou visualizar o uso de cota. [Saiba mais sobre as funções do Cloud Foundry disponíveis](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Funções RBAC do Kubernetes</dt>
<dd>Cada usuário que é designado a uma política de acesso do {{site.data.keyword.containershort_notm}} é automaticamente designada à função RBAC do Kubernetes.  No Kubernetes, as funções RBAC determinam as ações que podem ser executadas em recursos do Kubernetes dentro do cluster. As funções RBAC são configuradas somente para o namespace padrão. O administrador de cluster pode incluir funções RBAC para outros namespaces no cluster. Veja a tabela a seguir na seção [Acessar políticas e permissões](#access_policies) para ver qual função RBAC corresponde a qual política de acesso do {{site.data.keyword.containershort_notm}}. Para obter mais informações sobre funções RBAC em geral, veja [Usando autorização RBAC ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) na documentação do Kubernetes.</dd>
</dl>

<br />


## Políticas de acesso e permissões
{: #access_policies}

Revise as políticas e permissões de acesso que é possível conceder aos usuários em sua conta do {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

As funções de operador e editor do {{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM) têm permissões separadas. Se você deseja que um usuário, por exemplo, inclua nós do trabalhador e serviços de ligação, deve-se designar ao usuário as funções de operador e editor. Para obter mais detalhes sobre as políticas de acesso de infraestrutura correspondente, veja [Customizando permissões de infraestrutura para um usuário](#infra_access).<br/><br/>Se você muda a política de acesso de um usuário, as políticas do RBAC associadas à mudança em seu cluster são limpas. </br></br>**Nota:** quando você faz downgrade de permissões, por exemplo, deseja designar acesso de visualizador a um administrador de cluster antigo, deve-se aguardar alguns minutos para o downgrade ser concluído.

|Política de acesso do {{site.data.keyword.containershort_notm}}|Permissões de gerenciamento de cluster|Permissões de recursos do Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrator|Essa função herda permissões do Editor, do Operador e funções do Visualizador para todos os clusters
nessa conta. <br/><br/>Quando configurado para todas as instâncias de serviço atuais:<ul><li>Crie um cluster grátis ou padrão</li><li>Configure credenciais para uma conta do {{site.data.keyword.Bluemix_notm}} para acessar o portfólio da infraestrutura do IBM Cloud (SoftLayer)</li><li>Remover um Cluster</li><li>Designar e mudar as políticas de acesso do {{site.data.keyword.containershort_notm}} para outros usuários existentes nessa conta.</li></ul><p>Quando configurado para um ID do cluster específico:<ul><li>Remover um cluster específico</li></ul></p>Política de acesso de infraestrutura correspondente: superusuário<br/><br/><strong>Observação</strong>: para criar recursos como máquinas, VLANs e sub-redes, os usuários precisam da função de infraestrutura do **Superusuário**.|<ul><li>Função RBAC: cluster-admin</li><li>Acesso de leitura/gravação para recursos em cada namespace</li><li>Criar funções dentro de um namespace</li><li>Acessar o painel do Kubernetes</li><li>Crie um recurso Ingresso que torne os aplicativos disponíveis</li></ul>|
|Operador|<ul><li>Incluir nós do trabalhador adicionais em um cluster</li><li>Remover nós do trabalhador de um cluster</li><li>Reinicializar um nó do trabalhador</li><li>Recarregar um nó do trabalhador</li><li>Incluir uma sub-rede em um cluster</li></ul><p>Política de acesso de infraestrutura correspondente: [Customizada](#infra_access)</p>|<ul><li>Função do RBAC: administrador</li><li>Acesso de leitura/gravação para recursos dentro do namespace padrão, mas não no próprio namespace</li><li>Criar funções dentro de um namespace</li></ul>|
|Aplicativos <br/><br/><strong>Dica</strong>: use essa função para desenvolvedores de app.|<ul><li>Ligar um serviço do {{site.data.keyword.Bluemix_notm}} a um cluster.</li><li>Desvincular um serviço do {{site.data.keyword.Bluemix_notm}} para um cluster.</li><li>Criar um webhook.</li></ul><p>Política de acesso de infraestrutura correspondente: [Customizada](#infra_access)|<ul><li>Funções RBAC: editar</li><li>Acesso de leitura/gravação para recursos dentro do namespace padrão</li></ul></p>|
|Viewer|<ul><li>Listar um cluster</li><li>Visualizar detalhes para um cluster</li></ul><p>Política de acesso de infraestrutura correspondente: somente visualizar</p>|<ul><li>Funções RBAC: visualização</li><li>Acesso de leitura para recursos dentro do namespace padrão</li><li>Nenhum acesso de leitura para segredos do Kubernetes</li></ul>|

|Política de acesso do Cloud Foundry|Permissões de gerenciamento de conta|
|-------------|------------------------------|
|Função de organização: gerenciador|<ul><li>Incluir usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Função de espaço: desenvolvedor|<ul><li>Criar instâncias de serviço do
{{site.data.keyword.Bluemix_notm}}</li><li>Ligar instâncias de serviço do {{site.data.keyword.Bluemix_notm}} a clusters</li></ul>| 

<br />



## Entendendo a chave API do IAM e o comando `bx cs credentials-set`
{: #api_key}

Para provisionar com êxito e trabalhar com clusters em sua conta, deve-se assegurar que sua conta esteja configurada corretamente para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer). Dependendo de sua configuração de conta, use a chave API do IAM ou as credenciais de infraestrutura que você configurou manualmente usando o comando `bx cs credentials-set`.

<dl>
  <dt>Chave API do IAM</dt>
  <dd>A chave API do Identity and Access Management (IAM) é configurada automaticamente para uma região quando a primeira ação que requer a política de acesso de administrador do {{site.data.keyword.containershort_notm}} é executada. Por exemplo, um dos seus usuários administradores cria o primeiro cluster na região <code>us-south</code>. Ao fazer isso, a chave API do IAM para esse usuário é armazenada na conta para essa região. A chave API é usada para pedir a infraestrutura do IBM Cloud (SoftLayer), como novos nós do trabalhador ou VLANs. </br></br>
Quando um usuário diferente executa uma ação nessa região que requer interação com o portfólio da infraestrutura do IBM Cloud (SoftLayer), como a criação de um novo cluster ou o recarregamento de um nó do trabalhador, a chave API armazenada é usada para determinar se existem permissões suficientes para executar essa ação. Para certificar-se de que as ações relacionadas à infraestrutura em seu cluster possam ser executadas com sucesso, designe a seus usuários administradores do {{site.data.keyword.containershort_notm}} a política de acesso de infraestrutura <strong>Superusuário</strong>. </br></br>É possível localizar o proprietário da chave API atual executando [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Se você acha que precisa atualizar a chave API armazenada para uma região, é possível fazer isso executando o comando [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Esse comando requer a política de acesso de administrador do {{site.data.keyword.containershort_notm}} e armazena a chave API do usuário que executa esse comando na conta. </br></br> <strong>Nota:</strong> a chave API armazenada para a região pode não ser usada se as credenciais de infraestrutura do IBM Cloud (SoftLayer) foram configuradas manualmente usando o comando <code>bx cs credentials-set</code>. </dd>
<dt>Credenciais do IBM Cloud (SoftLayer) via <code>bx cs credentials-set</code></dt>
<dd>Se você tiver uma {{site.data.keyword.Bluemix_notm}}conta Pay As You Go, terá acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer) por padrão. No entanto, talvez você queira usar uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente da que você já tem para pedir a infraestrutura. É possível vincular essa conta de infraestrutura à sua conta do {{site.data.keyword.Bluemix_notm}} usando o comando [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set). </br></br>Se as credenciais de infraestrutura do IBM Cloud (SoftLayer) são configuradas manualmente, essas credenciais são usadas para pedir a infraestrutura, mesmo se uma chave API do IAM já existe para a conta. Se o usuário cujas credenciais estão armazenadas não tiver as permissões necessárias para pedir a infraestrutura, as ações relacionadas à infraestrutura, como a criação de um cluster ou o recarregamento de um nó do trabalhador, poderão falhar. </br></br> Para remover as credenciais de infraestrutura do IBM Cloud (SoftLayer) que foram configuradas manualmente, é possível usar o comando [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Após as credenciais serem removidas, a chave API do IAM é usada para pedir infraestrutura. </dd>
</dl>

## Incluindo usuários em uma conta do {{site.data.keyword.Bluemix_notm}}
{: #add_users}

É possível incluir usuários em uma conta do {{site.data.keyword.Bluemix_notm}} para conceder acesso aos seus clusters.
{:shortdesc}

Antes de iniciar, verifique se você foi designado à função de Gerenciador do Cloud Foundry para uma conta do {{site.data.keyword.Bluemix_notm}}.

1.  [Inclua o usuário na conta](../iam/iamuserinv.html#iamuserinv).
2.  Na seção **Acesso**, expanda **Serviços**.
3.  Designe uma função de acesso do {{site.data.keyword.containershort_notm}}. Na lista suspensa **Designar acesso a**, decida se você deseja conceder acesso somente à sua conta do {{site.data.keyword.containershort_notm}} (**Recurso**) ou a uma coleção de vários recursos dentro de sua conta (**Grupo de recursos**).
  -  Para **Recurso**:
      1. Na lista suspensa **Serviços**, selecione **{{site.data.keyword.containershort_notm}}**.
      2. Na lista suspensa **Região**, selecione a região para a qual convidar o usuário. **Nota**: para acesso aos clusters na [região Norte AP](cs_regions.html#locations), veja [Concedendo acesso do IAM aos usuários para clusters dentro da região Norte AP](#iam_cluster_region).
      3. Na lista suspensa **Instância de serviço**, selecione o cluster para o qual convidar o usuário. Para localizar o ID de um cluster específico, execute `bx cs clusters`.
      4. Na seção **Selecionar funções**, escolha uma função. Para localizar uma lista de ações suportadas por função, consulte [Políticas e permissões de
acesso](#access_policies).
  - Para **Grupo de recursos**:
      1. Na lista suspensa **Grupo de recursos**, selecione o grupo de recursos que inclui permissões para o recurso {{site.data.keyword.containershort_notm}} de sua conta.
      2. Na lista suspensa **Designar acesso a um grupo de recursos**, selecione uma função. Para localizar uma lista de ações suportadas por função, consulte [Políticas e permissões de
acesso](#access_policies).
4. [Opcional: designe uma função do Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. [Opcional: designe uma função de infraestrutura](/docs/iam/infrastructureaccess.html#infrapermission).
6. Clique em **Convidar usuários**.

<br />


### Concedendo acesso do IAM aos usuários para clusters dentro da região Norte AP
{: #iam_cluster_region}

Ao [incluir usuários em sua conta do {{site.data.keyword.Bluemix_notm}}](#add_users), você seleciona as regiões para as quais eles receberam acesso. No entanto, algumas regiões, como Norte AP, podem não estar disponíveis no console e devem ser incluídas usando a CLI.
{:shortdesc}

Antes de iniciar, verifique se você é um administrador para a conta do {{site.data.keyword.Bluemix_notm}}.

1.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Selecione a conta que você deseja usar.

    ```
    bx login [--sso]
    ```
    {: pre}

    **Nota:** se você tiver um ID federado, use `bx login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

2.  Destine o ambiente para o qual você deseja conceder permissões, como a região Norte AP (`jp-tok`). Para obter mais detalhes sobre as opções de comando, como organização e espaço, veja o [comando `bluemix target`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target).

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  Obtenha o nome ou IDs dos clusters da região aos quais você deseja conceder acesso.

    ```
    bx cs clusters
    ```
    {: pre}

4.  Obtenha os IDs de usuário aos quais você deseja conceder acesso.

    ```
    bx account users
    ```
    {: pre}

5.  Selecione as funções para a política de acesso.

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  Conceda o acesso de usuário para o cluster com a função apropriada. Este exemplo designa ao `user@example.com` as funções `Operator` e `Editor` para três clusters.

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    Para conceder acesso aos clusters existentes e futuros região, não especifique a sinalização `--service-instance`. Para obter mais informações, veja o [comando `bluemix iam user-policy-create`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create).
    {:tip}

## Customizando as permissões de infraestrutura para um usuário
{: #infra_access}

Quando você configura políticas de infraestrutura no Identity and Access Management, um usuário recebe permissões que estão associadas a uma função. Para customizar essas permissões, deve-se efetuar login na infraestrutura do IBM Cloud (SoftLayer) e ajustar as permissões lá.
{: #view_access}

Por exemplo, **Usuários básicos** podem reinicializar um nó do trabalhador, mas não podem recarregar um nó do trabalhador. Sem fornecer a essa pessoa as permissões de **Superusuário**, é possível ajustar as permissões de infraestrutura do IBM Cloud (SoftLayer) e incluir a permissão para executar um comando de recarregamento.

1.  Efetue login na [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), em seguida, selecione **Infraestrutura** no menu.

2.  Acesse **Conta** > **Usuários** > **Lista de usuários**.

3.  Para modificar permissões, selecione o nome de um perfil do usuário ou a coluna **Acesso ao dispositivo**.

4.  Na guia **Permissões do portal**, customize o acesso de usuário. As permissões que os usuários precisam dependem de quais recursos de infraestrutura eles precisam usar:

    * Use a lista suspensa **Permissões rápidas** para designar a função **Superusuário**, que fornece ao usuário todas as permissões.
    * Use a lista suspensa **Permissões rápidas** para designar a função **Usuário básico**, que fornece ao usuário algumas, mas não todas, permissões necessárias.
    * Se você não deseja conceder todas as permissões com a função **Superusuário** ou precisa incluir permissões além da função **Usuário básico**, revise a tabela a seguir que descreve as permissões necessárias para executar tarefas comuns no {{site.data.keyword.containershort_notm}}.

    <table summary="Permissões de infraestrutura para cenários comuns do {{site.data.keyword.containershort_notm}}.">
     <caption>Permissões de infraestrutura normalmente necessárias para o {{site.data.keyword.containershort_notm}}</caption>
     <thead>
     <th>Tarefas comuns no {{site.data.keyword.containershort_notm}}</th>
     <th>Permissões de infraestrutura necessárias por guia</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>Permissões mínimas</strong>: <ul><li>Crie um cluster.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Visualize os detalhes do servidor virtual</li><li>Reinicializar o servidor e visualizar informações do sistema IPMI</li><li>Emitir recarregamentos de OS e iniciar o kernel de resgate</li></ul><strong>Conta</strong>: <ul><li>Incluir/fazer upgrade de instâncias da nuvem</li><li>Incluir servidor</li></ul></td>
     </tr>
     <tr>
     <td><strong>Administração de cluster</strong>: <ul><li>Criar, atualizar e excluir clusters.</li><li>Incluir, recarregar e reinicializar nós do trabalhador.</li><li>Visualizar VLANs.</li><li>Criar sub-redes.</li><li>Implementar pods e serviços do balanceador de carga.</li></ul></td>
     <td><strong>Suporte</strong>:<ul><li>Visualizar chamados</li><li>Incluir chamados</li><li>Editar chamados</li></ul>
     <strong>Dispositivos</strong>:<ul><li>Visualize os detalhes do servidor virtual</li><li>Reinicializar o servidor e visualizar informações do sistema IPMI</li><li>Fazer upgrade do servidor</li><li>Emitir recarregamentos de OS e iniciar o kernel de resgate</li></ul>
     <strong>Serviços</strong>:<ul><li>Gerenciar chaves SSH</li></ul>
     <strong>Conta</strong>:<ul><li>Visualizar resumo da conta</li><li>Incluir/fazer upgrade de instâncias da nuvem</li><li>Cancelar servidor</li><li>Incluir servidor</li></ul></td>
     </tr>
     <tr>
     <td><strong>Armazenamento</strong>: <ul><li>Criar solicitações de volume persistente para provisionar volumes persistentes.</li><li>Criar e gerenciar recursos de infraestrutura de armazenamento.</li></ul></td>
     <td><strong>Serviços</strong>:<ul><li>Gerenciar armazenamento</li></ul><strong>Conta</strong>:<ul><li>Incluir armazenamento</li></ul></td>
     </tr>
     <tr>
     <td><strong>Rede privada</strong>: <ul><li>Gerenciar VLANs privadas para rede em cluster.</li><li>Configurar a conectividade VPN para redes privadas.</li></ul></td>
     <td><strong>Rede</strong>:<ul><li>Gerenciar rotas de sub-rede da rede</li><li>Gerenciar ampliação de VLAN da rede</li><li>Gerenciar túneis de rede do IPSEC</li><li>Gerenciar gateways de rede</li><li>Administração da VPN</li></ul></td>
     </tr>
     <tr>
     <td><strong>Rede pública</strong>:<ul><li>Configurar o balanceador de carga pública ou rede de Ingresso para expor apps.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Gerenciar balanceadores de carga</li><li>Editar nome do host/domínio</li><li>Gerenciar controle de porta</li></ul>
     <strong>Rede</strong>:<ul><li>Incluir cálculo com porta de rede pública</li><li>Gerenciar rotas de sub-rede da rede</li><li>Gerenciar ampliação de VLAN da rede</li><li>Incluir endereços IP</li></ul>
     <strong>Serviços</strong>:<ul><li>Gerenciar DNS, DNS reverso e WHOIS</li><li>Visualizar certificados (SSL)</li><li>Gerenciar certificados (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  Para salvar as suas mudanças, clique em **Editar permissões do portal**.

6.  Na guia **Acesso ao dispositivo**, selecione os dispositivos aos quais conceder acesso.

    * Na lista suspensa **Tipo de dispositivo**, é possível conceder acesso para **Todos os servidores virtuais**.
    * Para permitir que os usuários acessem os novos dispositivos que são criados, marque **Conceder acesso automaticamente quando novos dispositivos forem incluídos**.
    * Para salvar suas mudanças, clique em **Atualizar acesso ao dispositivo**.

7.  Retorne para a lista de perfis do usuário e verifique se **Acesso ao dispositivo** foi concedido.

## Autorizando usuários com funções RBAC customizadas do Kubernetes
{: #rbac}

As políticas de acesso do {{site.data.keyword.containershort_notm}} correspondem a determinadas funções de controle de acesso baseado na função (RBAC) do Kubernetes conforme descrito em [Políticas e permissões de acesso](#access_policies). Para autorizar outras funções do Kubernetes que diferem da política de acesso correspondente, é possível customizar as funções RBAC e, em seguida, designar as funções para indivíduos ou grupos de usuários.
{: shortdesc}

Por exemplo, você pode desejar conceder permissões a uma equipe de desenvolvedores para trabalhar em um determinado grupo de APIs ou com recursos dentro de um namespace do Kubernetes no cluster, mas não no cluster inteiro. Você cria uma função e depois liga a função aos usuários, usando um nome de usuário exclusivo para o {{site.data.keyword.containershort_notm}}. Para obter informações mais detalhadas, veja [Usando autorização RBAC ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) na documentação do Kubernetes.

Antes de iniciar, [destine a CLI do Kubernetes para o cluster](cs_cli_install.html#cs_cli_configure).

1.  Crie a função com o acesso que você deseja designar.

    1. Faça um arquivo `.yaml` para definir a função com o acesso que você deseja designar.

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Tabela. Entendendo os componentes deste YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone Ideia"/> Entendendo os componentes deste YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Use `Função` para conceder acesso a recursos em um único namespace ou `ClusterRole` para recursos de cluster inteiro.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Para clusters que executam o Kubernetes 1.8 ou mais recente, use `rbac.authorization.k8s.io/v1`. </li><li>Para versões anteriores, use `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Para o tipo `Role`: especifique o namespace do Kubernetes ao qual o acesso é concedido.</li><li>Não use o campo `namespace` se estiver criando um `ClusterRole` que se aplique ao nível do cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Nomeie a função e use o nome posteriormente quando você ligar a função.</td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>Especifique os grupos da API do Kubernetes com os quais você deseja que os usuários sejam capazes de interagir, como `"apps"`, `"batch"` ou `"extensions"`. </li><li>Para acesso ao grupo principal de APIs no caminho de REST `api/v1`, deixe o grupo em branco: `[""]`.</li><li>Para obter mais informações, veja [Grupos de APIs![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/api-overview/#api-groups) na documentação do Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>Especifique os recursos do Kubernetes aos quais você deseja conceder acesso, como `"daemonsets"`, `"deployments"`, `"events"` ou `"ingresses"`.</li><li>Se você especificar `"nodes"`, o tipo de função deverá ser `ClusterRole`.</li><li>Para obter uma lista de recursos, veja a tabela de [Tipos de recursos![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) na folha de dicas do Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>Especifique os tipos de ações que você deseja que os usuários sejam capazes de executar, como `"get"`, `"list"`, `"describe"`, `"create"` ou `"delete"`. </li><li>Para obter uma lista integral de verbos, veja a [documentação do `kubectl`![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  Crie a função em seu cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Verifique se a função foi criada.

        ```
        kubectl get roles
        ```
        {: pre}

2.  Ligue os usuários à função.

    1. Faça um arquivo `.yaml` para ligar os usuários à sua função. Anote a URL exclusiva a ser usada para o nome de cada assunto.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Tabela. Entendendo os componentes deste YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone Ideia"/> Entendendo os componentes deste YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Especifique o `kind` como `RoleBinding` para ambos os tipos de arquivos `.yaml` de função: namespace `Role` e `ClusterRole` de cluster inteiro.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Para clusters que executam o Kubernetes 1.8 ou mais recente, use `rbac.authorization.k8s.io/v1`. </li><li>Para versões anteriores, use `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Para o tipo `Role`: especifique o namespace do Kubernetes ao qual o acesso é concedido.</li><li>Não use o campo `namespace` se estiver criando um `ClusterRole` que se aplique ao nível do cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Nomeie a ligação de função.</td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>Especifique o tipo como `User`.</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>Anexe o endereço de e-mail do usuário à URL a seguir: `https://iam.ng.bluemix.net/kubernetes#`.</li><li>Por exemplo, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>Use `rbac.authorization.k8s.io`.</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>Insira o mesmo valor que o `kind` no arquivo `.yaml` de função: `Role` ou `ClusterRole`.</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>Insira o nome do arquivo `.yaml` de função.</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>Use `rbac.authorization.k8s.io`.</td>
        </tr>
        </tbody>
        </table>

    2. Crie o recurso de ligação de função em seu cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Verifique se a ligação foi criada.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Agora que você criou e ligou uma função RBAC customizada do Kubernetes, acompanhe com usuários. Peça-lhes para testar uma ação que eles tenham permissão para concluir devido à função, como excluir um pod.
