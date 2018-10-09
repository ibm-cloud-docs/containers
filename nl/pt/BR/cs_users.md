---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Designando acesso ao cluster
{: #users}

Como um administrador de cluster, é possível definir políticas de acesso para seu cluster do Kubernetes para criar diferentes níveis de acesso para diferentes usuários. Por exemplo, é possível autorizar determinados usuários para trabalhar com recursos de cluster enquanto outros podem somente implementar contêineres.
{: shortdesc}


## Entendendo políticas e permissões de acesso
{: #access_policies}

<dl>
  <dt>Eu tenho que configurar políticas de acesso?</dt>
    <dd>Deve-se definir políticas de acesso para cada usuário que trabalhe com o {{site.data.keyword.containerlong_notm}}. O escopo de uma política de acesso baseia-se em uma função ou funções definidas pelos usuários que determinam as ações que eles têm permissão para executar. Algumas políticas são predefinidas, mas outras podem ser customizadas. A mesma política é cumprida se o usuário faz a solicitação na GUI do {{site.data.keyword.containerlong_notm}} ou por meio da CLI, mesmo quando as ações são concluídas na infraestrutura do IBM Cloud (SoftLayer).</dd>

  <dt>Quais são os tipos de permissões?</dt>
    <dd><p><strong>Plataforma</strong>: o {{site.data.keyword.containerlong_notm}} é configurado para usar funções de plataforma do {{site.data.keyword.Bluemix_notm}} para determinar as ações que os indivíduos podem executar em um cluster. As permissões de função se baseiam umas nas outras, o que significa que a função `Editor` tem todas as mesmas permissões que a função `Viewer`, além das permissões que são concedidas a um editor. É possível configurar essas políticas por região. Essas políticas devem ser configuradas juntamente com as políticas de infraestrutura e têm as funções RBAC correspondentes que são designadas automaticamente ao namespace padrão. Exemplo de ações que estão criando ou removendo clusters ou incluindo nós extras do trabalhador.</p> <p><strong>Infraestrutura</strong>: é possível determinar os níveis de acesso para sua infraestrutura, como as máquinas do nó do cluster, rede ou recursos de armazenamento. Deve-se configurar esse tipo de política junto com as políticas de acesso de plataforma do {{site.data.keyword.containerlong_notm}}. Para conhecer as funções disponíveis, verifique as [permissões de infraestrutura](/docs/iam/infrastructureaccess.html#infrapermission). Além de conceder funções de infraestrutura específicas, deve-se também conceder acesso ao dispositivo para usuários que trabalham com infraestrutura. Para começar a designar funções, siga as etapas em [Customizando permissões de infraestrutura para um usuário](#infra_access). <strong>Nota</strong>: certifique-se de que a sua conta do {{site.data.keyword.Bluemix_notm}} esteja [configurada com acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials) para que os usuários autorizados possam executar ações na conta de infraestrutura do IBM Cloud (SoftLayer) com base nas permissões designadas.</p> <p><strong>RBAC</strong>: o controle de acesso baseado na função (RBAC) é uma maneira de proteger seus recursos que estão dentro do seu cluster e decidir quem pode executar quais ações do Kubernetes. Cada usuário a quem é designada uma política de acesso de plataforma é designado automaticamente a uma função do Kubernetes. No Kubernetes, o [Role Based Access Control (RBAC) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) determina as ações que um usuário pode executar nos recursos dentro de um cluster. <strong>Nota</strong>: as funções RBAC são configuradas automaticamente em conjunto com a função de plataforma para o namespace padrão. Como um administrador de cluster, é possível [atualizar ou designar funções](#rbac) para outros namespaces.</p> <p><strong>Cloud Foundry</strong>: nem todos os serviços podem ser gerenciados com o Cloud IAM. Se você estiver usando um desses serviços, será possível continuar usando as [funções de usuário do Cloud Foundry](/docs/iam/cfaccess.html#cfaccess) para controlar o acesso a seus serviços. As ações de exemplo estão ligando um serviço ou criando uma nova instância de serviço.</p></dd>

  <dt>Como posso configurar as permissões?</dt>
    <dd><p>Ao configurar permissões de Plataforma, é possível designar acesso a um usuário específico, um grupo de usuários ou ao grupo de recursos padrão. Quando você configura as permissões de plataforma, as funções RBAC são configuradas automaticamente para o namespace padrão e um RoleBinding é criado.</p>
    <p><strong>Usuários</strong>: você pode ter um usuário específico que precise de mais ou menos permissões do que o resto de sua equipe. É possível customizar as permissões em uma base individual para que cada pessoa tenha a quantia certa de permissões necessárias para concluir a sua tarefa.</p>
    <p><strong>Grupos de acesso</strong>: é possível criar grupos de usuários e, em seguida, designar permissões a um grupo específico. Por exemplo, seria possível agrupar todos os líderes de equipe e conceder a esse grupo acesso de administrador. Ao mesmo tempo, seu grupo de desenvolvedores tem somente acesso de gravação.</p>
    <p><strong>Grupos de recursos</strong>: com o IAM, é possível criar políticas de acesso para um grupo de recursos e conceder aos usuários acesso a esse grupo. Esses recursos podem fazer parte de um serviço do {{site.data.keyword.Bluemix_notm}} ou também é possível agrupar recursos entre as instâncias de serviço, como um cluster do {{site.data.keyword.containerlong_notm}} e um app CF.</p> <p>**Importante**: o {{site.data.keyword.containerlong_notm}} suporta somente o grupo de recursos <code>default</code>. Todos os recursos relacionados ao cluster são disponibilizados automaticamente no grupo de recursos <code>default</code>. Se houver outros serviços em sua conta do {{site.data.keyword.Bluemix_notm}} que você deseja usar com seu cluster, os serviços também deverão estar no grupo de recursos <code>default</code>.</p></dd>
</dl>


Sente-se sobrecarregado? Experimente este tutorial sobre as [melhores práticas para organizar usuários, equipes e aplicativos](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Acessando o portfólio de infraestrutura do IBM Cloud (SoftLayer)
{: #api_key}

<dl>
  <dt>Por que eu preciso de acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer)?</dt>
    <dd>Para provisionar e trabalhar com êxito com clusters em sua conta, deve-se assegurar que sua conta esteja configurada corretamente para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer). Dependendo de sua configuração de conta, você usa a chave API do IAM ou as credenciais de infraestrutura que configurou manualmente usando o comando `ibmcloud ks credentials-set`.</dd>

  <dt>Como a chave API do IAM funciona com o {{site.data.keyword.containerlong_notm}}?</dt>
    <dd><p>A chave API do Identity and Access Management (IAM) é configurada automaticamente para uma região quando a primeira ação que requer a política de acesso de administrador do {{site.data.keyword.containerlong_notm}} é executada. Por exemplo, um dos seus usuários administradores cria o primeiro cluster na região <code>us-south</code>. Ao fazer isso, a chave API do IAM para esse usuário é armazenada na conta para essa região. A chave API é usada para pedir a infraestrutura do IBM Cloud (SoftLayer), como novos nós do trabalhador ou VLANs.</p> <p>Quando um usuário diferente executa uma ação nessa região que requer interação com o portfólio de infraestrutura do IBM Cloud (SoftLayer), como a criação de um novo cluster ou o recarregamento de um nó do trabalhador, a chave API armazenada é usada para determinar se existem permissões suficientes para executar essa ação. Para certificar-se de que as ações relacionadas à infraestrutura em seu cluster possam ser executadas com sucesso, designe a seus usuários administradores do {{site.data.keyword.containerlong_notm}} a política de acesso de infraestrutura <strong>Superusuário</strong>.</p> <p>É possível localizar o proprietário da chave API atual, executando [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Se você achar que é necessário atualizar a chave API que está armazenada para uma região, será possível fazer isso executando o comando [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Esse comando requer a política de acesso de administrador do {{site.data.keyword.containerlong_notm}} e armazena a chave API do usuário que executa esse comando na conta. A chave API que está armazenada para a região poderá não ser usada se as credenciais de infraestrutura do IBM Cloud (SoftLayer) foram configuradas manualmente usando o comando <code>ibmcloud ks credentials-set</code>.</p> <p><strong>Nota:</strong> certifique-se de que você deseja reconfigurar a chave e entenda o impacto em seu app. A chave é usada em vários locais diferentes e poderá causar mudanças drásticas se for mudada desnecessariamente.</p></dd>

  <dt>O que o comando <code>ibmcloud ks credentials-set</code> faz?</dt>
    <dd><p>Se você tiver uma {{site.data.keyword.Bluemix_notm}}conta pré-paga, terá acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer) por padrão. No entanto, talvez deseje usar uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente da que você já tem para pedir a infraestrutura para clusters dentro de uma região. É possível vincular essa conta de infraestrutura à sua conta do {{site.data.keyword.Bluemix_notm}} usando o comando [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set).</p> <p>Para remover as credenciais de infraestrutura do IBM Cloud (SoftLayer) que foram configuradas manualmente, é possível usar o comando [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Após as credenciais serem removidas, a chave API do IAM é usada para pedir infraestrutura.</p></dd>

  <dt>Há uma diferença entre as credenciais de infraestrutura e a chave API?</dt>
    <dd>A chave API e o comando <code>ibmcloud ks credentials-set</code> realizam a mesma tarefa. Se você configurar manualmente as credenciais com o comando <code>ibmcloud ks credentials-set</code>, as credenciais configuradas substituirão qualquer acesso que for concedido pela chave API. No entanto, se o usuário cujas credenciais estão armazenadas não tiver as permissões necessárias para pedir a infraestrutura, as ações relacionadas à infraestrutura, como a criação de um cluster ou o recarregamento de um nó do trabalhador, poderão falhar.</dd>
    
  <dt>Como saber se minhas credenciais de conta de infraestrutura estão configuradas para usar uma conta diferente?</dt>
    <dd>Abra a [GUI do {{site.data.keyword.containerlong_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/containers-kubernetes/clusters) e selecione seu cluster. Na guia **Visão geral**, procure um campo **Usuário de infraestrutura**. Se vir esse campo, você não usará as credenciais de infraestrutura padrão que vêm com sua conta Pré-paga nessa região. Em vez disso, a região será configurada para usar credenciais de conta de infraestrutura diferentes.</dd>

  <dt>Há uma maneira de tornar a designação de permissões de infraestrutura do IBM Cloud (SoftLayer) mais fácil?</dt>
    <dd><p>Os usuários geralmente não precisam de permissões específicas da infraestrutura do IBM Cloud (SoftLayer). Em vez disso, configure a chave API com as permissões de infraestrutura corretas e use essa chave API em cada região em que você deseja os clusters. A chave API pode pertencer ao proprietário da conta, a um ID funcional ou a um usuário, dependendo do que for mais fácil para você gerenciar e auditar.</p> <p>Se desejar criar um cluster em uma nova região, certifique-se de que o primeiro cluster seja criado por quem possua a chave API que você configurou com as credenciais de infraestrutura adequadas. Depois, é possível convidar pessoas individuais, grupos do IAM ou usuários da conta do serviço para essa região. Os usuários dentro da conta compartilham as credenciais de chave API para executar ações de infraestrutura, como incluir nós do trabalhador. Para controlar quais ações de infraestrutura que um usuário pode executar, designe a função apropriada do {{site.data.keyword.containerlong_notm}} no IAM.</p><p>Por exemplo, um usuário com uma função `Viewer` do IAM não está autorizado a incluir um nó do trabalhador. Portanto, a ação `worker-add` falha, mesmo que a chave API tenha as permissões de infraestrutura corretas. Se você mudar a função de usuário para`Operator` no IAM, o usuário será autorizado a incluir um nó do trabalhador. A ação `worker-add` é bem-sucedida porque a função de usuário está autorizada e a chave API está configurada corretamente. Não é necessário editar as permissões de infraestrutura do IBM Cloud (SoftLayer) do usuário.</p> <p>Para obter mais informações sobre a configuração de permissões, verifique [Customizando as permissões de infraestrutura para um usuário](#infra_access)</p></dd>
</dl>


<br />



## Entendendo os relacionamentos de função
{: #user-roles}

Para poder entender qual função pode executar cada ação, é importante entender como as funções se ajustam.
{: shortdesc}

A imagem a seguir mostra as funções que cada tipo de pessoa em sua organização pode precisar. No entanto, isso é diferente para cada organização. Você pode observar que alguns usuários requerem permissões customizadas para infraestrutura. Certifique-se de ler [Acessando o portfólio de infraestrutura do IBM Cloud (SoftLayer)](#api_key) para saber sobre quais são as permissões de infraestrutura do IBM Cloud (SoftLayer) e quem precisa de quais permissões. 

![{} access roles](/images/user-policies.png)

Figura. {{site.data.keyword.containerlong_notm}}  permissões de acesso por tipo de função

<br />



## Designando funções com a GUI
{: #add_users}

É possível incluir usuários em uma conta do {{site.data.keyword.Bluemix_notm}} para conceder acesso aos seus clusters com a GUI.
{: shortdesc}

**Antes de começar**

- Verifique se seu usuário está incluído na conta. Se não, inclua-[o](../iam/iamuserinv.html#iamuserinv).
- Verifique se você está designado à [função do Cloud Foundry](/docs/iam/mngcf.html#mngcf) `Manager` para a conta do {{site.data.keyword.Bluemix_notm}} na qual você está trabalhando.

** Para designar acesso a um usuário **

1. Navegue para  ** Gerenciar > Usuários **. Uma lista dos usuários com acesso à conta é mostrada.

2. Clique no nome do usuário para o qual você deseja configurar permissões. Se o usuário não for mostrado, clique em **Convidar usuários** para incluí-los na conta.

3. Designar uma política.
  * Para um grupo de recursos:
    1. Selecione o grupo de recursos **padrão**. O acesso ao {{site.data.keyword.containerlong_notm}} pode ser configurado somente para o grupo de recursos padrão.
  * Para um recurso específico:
    1. Na lista **Serviços** , selecione **{{site.data.keyword.containerlong_notm}}**.
    2. Na lista de **Regiões**, selecione uma região.
    3. Na lista de **Instâncias de serviço**, selecione o cluster para o qual convidar o usuário. Para localizar o ID de um cluster específico, execute `ibmcloud ks clusters`.

4. Na seção **Selecionar funções**, escolha uma função. 

5. Clique em **Designar**.

6. Designe uma [função do Cloud Foundry](/docs/iam/mngcf.html#mngcf).

7. Opcional: designe uma [função de infraestrutura](/docs/iam/infrastructureaccess.html#infrapermission).

</br>

** Para designar acesso a um grupo **

1. Navegue para  ** Gerenciar > Grupos de acesso **.

2. Crie um grupo de acesso.
  1. Clique em **Criar** e forneça a seu grupo um **Nome** e uma **Descrição**. Clique em
**Criar**.
  2. Clique em **Incluir usuários** para incluir pessoas em seu grupo de acesso. Uma lista de usuários que têm acesso à sua conta é mostrada.
  3. Marque a caixa ao lado dos usuários que você deseja incluir no grupo. Uma caixa de diálogo é exibida.
  4. Clique em **Incluir no grupo**.

3. Para designar acesso a um serviço específico, inclua um ID do serviço.
  1. Clique em  ** Incluir ID de serviço **.
  2. Marque a caixa ao lado dos usuários que você deseja incluir no grupo. Um pop-up é exibido.
  3. Clique em **Incluir no grupo**.

4. Designar políticas de acesso. Não se esqueça de verificar duas vezes as pessoas que você incluir em seu grupo. Todos no grupo recebem o mesmo nível de acesso.
    * Para um grupo de recursos:
        1. Selecione o grupo de recursos **padrão**. O acesso ao {{site.data.keyword.containerlong_notm}} pode ser configurado somente para o grupo de recursos padrão.
    * Para um recurso específico:
        1. Na lista **Serviços** , selecione **{{site.data.keyword.containerlong_notm}}**.
        2. Na lista de **Regiões**, selecione uma região.
        3. Na lista de **Instâncias de serviço**, selecione o cluster para o qual convidar o usuário. Para localizar o ID de um cluster específico, execute `ibmcloud ks clusters`.

5. Na seção **Selecionar funções**, escolha uma função. 

6. Clique em **Designar**.

7. Designe uma [função do Cloud Foundry](/docs/iam/mngcf.html#mngcf).

8. Opcional: designe uma [função de infraestrutura](/docs/iam/infrastructureaccess.html#infrapermission).

<br />



## Designando funções com a CLI
{: #add_users_cli}

É possível incluir usuários em uma conta do {{site.data.keyword.Bluemix_notm}} para conceder acesso a seus clusters com a CLI.
{: shortdesc}

**Antes de começar**

Verifique se você está designado à [função do Cloud Foundry](/docs/iam/mngcf.html#mngcf) `Manager` para a conta do {{site.data.keyword.Bluemix_notm}} na qual você está trabalhando.

**Para designar acesso a um usuário específico**

1. Convide o usuário para sua conta.
  ```
  ibmcloud account user-invite <user@email.com>
  ```
  {: pre}
2. Crie uma política de acesso do IAM para configurar permissões para o {{site.data.keyword.containerlong_notm}}. É possível escolher entre Visualizador, Editor, Operador e Administrador para a função.
  ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

** Para designar acesso a um grupo **

1. Se o usuário ainda não for parte de sua conta, convide-o.
  ```
  ibmcloud account user-invite <user_email>
  ```
  {: pre}

2. Crie um grupo.
  ```
  ibmcloud iam access-group-create <team_name>
  ```
  {: pre}

3. Inclua o usuário no grupo.
  ```
  ibmcloud iam access-group-user-add <team_name> <user_email>
  ```
  {: pre}

4. Inclua o usuário no grupo. É possível escolher entre Visualizador, Editor, Operador e Administrador para a função.
  ```
  ibmcloud iam access-group-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

5. Atualize a sua configuração de cluster para gerar um RoleBinding.
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  RoleBinding:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <binding>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <role>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <group_name>
    namespace: default
  ```
  {: screen}

As instruções anteriores mostram como fornecer a um grupo de usuários acesso a todos os recursos do {{site.data.keyword.containerlong_notm}}. Como um administrador, também é possível limitar o acesso ao serviço no nível de região ou de instância de cluster.
{: tip}

<br />


## Autorizando Usuários com Ligações de Função RBAC
{: #role-binding}

Cada cluster é configurado com funções RBAC predefinidas que são configuradas para o namespace padrão de seu cluster. É possível copiar funções RBAC do namespace padrão para outros namespaces em seu cluster para cumprir o mesmo nível de acesso de usuário.

** O que é um RBAC RoleBinding? **

Uma ligação de função é uma política de acesso específica do recurso do Kubernetes. É possível usar ligações de função para configurar políticas que são específicas para namespaces, pods ou outros recursos dentro de seu cluster. O {{site.data.keyword.containerlong_notm}} fornece funções RBAC predefinidas que correspondem às funções de plataforma no IAM. Quando você designa a um usuário uma função de plataforma do IAM, uma ligação de função RBAC é criada automaticamente para o usuário no namespace padrão do cluster.

**O que é uma ligação de função de cluster RBAC?**

Enquanto uma ligação de função RBAC é específica para um recurso, como um namespace ou um pod, uma ligação de função de cluster RBAC pode ser usada para configurar permissões no nível de cluster que inclui todos os namespaces. As ligações de função de cluster são criadas automaticamente para o namespace padrão quando as funções de plataforma são configuradas. É possível copiar essa ligação de função para outros namespaces.


<table>
  <tr>
    <th>Função da plataforma</th>
    <th>Função RBAC</th>
    <th>Ligação de Função</th>
  </tr>
  <tr>
    <td>Viewer</td>
    <td>Visualizar</td>
    <td><code> ibm-view </code></td>
  </tr>
  <tr>
    <td>Aplicativos</td>
    <td>Editar</td>
    <td><code> ibm-edit </code></td>
  </tr>
  <tr>
    <td>Operador</td>
    <td>Administrador</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrator</td>
    <td>Administrador de cluster</td>
    <td><code> ibm-admin </code></td>
  </tr>
</table>

**Há algum requisito específico ao trabalhar com RoleBindings?**

Para trabalhar com o IBM Helm Charts, deve-se instalar o Tiller no namespace `kube-system`. Para instalar o Tiller, deve-se ter a [função `cluster-admin`](cs_users.html#access_policies)
dentro do namespace `kube-system`. Para outros gráficos Helm, é possível escolher um outro namespace. No entanto, quando você executa um comando `helm`, deve-se usar a sinalização `tiller-namespace <namespace>` para apontar para o namespace no qual o Tiller está instalado.


### Copiando um RBAC RoleBinding

Quando você configura suas políticas de plataforma, uma ligação de função de cluster é gerada automaticamente para o namespace padrão. É possível copiar a ligação em outros namespaces atualizando a ligação com o namespace para o qual você deseja configurar a política. Por exemplo, vamos supor que você tenha um grupo de desenvolvedores chamado `team-a` e eles tenham acesso `view` no serviço, mas eles precisam de acesso `edit` ao namespace `teama`. É possível editar o RoleBinding gerado automaticamente para dar a eles o acesso que eles precisam no nível de recurso.

1. Crie uma ligação de função RBAC para o namespace padrão [designando acesso com uma função de plataforma](#add_users_cli).
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}
  Saída de exemplo:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. Copie essa configuração em outro namespace.
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role> --namespace <namespace>
  ```
  {: pre}
  No cenário prévio, eu fiz uma mudança na configuração para um outro namespace. A configuração atualizada seria semelhante à seguinte:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### Criando funções do RBAC customizadas do Kubernetes
{: #rbac}

Para autorizar outras funções do Kubernetes que são diferentes da política de acesso de plataforma correspondente, é possível customizar as funções RBAC e, em seguida, designar as funções a indivíduos ou grupos de usuários.
{: shortdesc}

Você precisa que as políticas de acesso de cluster sejam mais granulares do que uma política do IAM permite? Sem problemas! É possível designar políticas de acesso para recursos específicos do Kubernetes para usuários, grupos de usuários (em clusters que executam os Kubernetes v1.11 ou mais recentes) ou contas de serviço. É possível criar uma função e, em seguida, ligar a função a usuários específicos ou a um grupo. Para obter mais informações, consulte [Usando a autorização RBAC ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) na documentação do Kubernetes.

Quando uma ligação é criada para um grupo, ela afeta qualquer usuário que é incluído ou removido desse grupo. Se você incluir um usuário no grupo, ele também terá o acesso adicional. Se ele for removido, seu acesso será revogado.
{: tip}

Se você deseja designar acesso a um serviço, como uma cadeia de ferramentas de entrega contínua, é possível usar [Contas de serviço do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

**Antes de começar**

- Destine a [CLI do Kubernetes](cs_cli_install.html#cs_cli_configure) para seu cluster.
- Assegure-se de que o usuário ou grupo tenha no mínimo o acesso `Viewer` no nível de serviço.


** Para customizar funções RBAC **

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
        <caption>Entendendo os componentes deste YAML</caption>
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
              <td><ul><li>Especifique os grupos da API do Kubernetes com os quais você deseja que os usuários sejam capazes de interagir, como `"apps"`, `"batch"` ou `"extensions"`. </li><li>Para acesso ao grupo principal de APIs no caminho de REST `api/v1`, deixe o grupo em branco: `[""]`.</li><li>Para obter mais informações, veja [Grupos de APIs![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) na documentação do Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>Especifique os recursos do Kubernetes aos quais você deseja conceder acesso, como `"daemonsets"`, `"deployments"`, `"events"` ou `"ingresses"`.</li><li>Se você especificar `"nodes"`, o tipo de função deverá ser `ClusterRole`.</li><li>Para obter uma lista de recursos, veja a tabela de [Tipos de recursos![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) na folha de dicas do Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>Especifique os tipos de ações que você deseja que os usuários sejam capazes de executar, como `"get"`, `"list"`, `"describe"`, `"create"` ou `"delete"`. </li><li>Para obter uma lista integral de verbos, veja a [documentação do `kubectl`![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/).</li></ul></td>
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
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Entendendo os componentes deste YAML</caption>
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
              <td>Especifique o tipo como um dos seguintes:
              <ul><li>`User`: ligar a função RBAC a um usuário individual em sua conta.</li>
              <li>`Group`: para clusters que executam o Kubernetes 1.11 ou mais recente, ligue a função RBAC a um [grupo do IAM](/docs/iam/groups.html#groups) em sua conta.</li>
              <li>`ServiceAccount`: ligue a função RBAC a uma conta do serviço em um namespace em seu cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**Para `User`**: anexe o endereço de e-mail do usuário individual à URL a seguir: `https://iam.ng.bluemix.net/kubernetes#`. Por exemplo, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Para `Group`**: para clusters que executam o Kubernetes 1.11 ou mais recente, especifique o nome do [grupo do IAM](/docs/iam/groups.html#groups) em sua conta.</li>
              <li>**Para `ServiceAccount`**: especifique o nome da conta do serviço.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>** Para  ` Usuário `  ou  ` Grupo ` **: use  ` rbac.authorization.k8s.io `.</li>
              <li>**Para `ServiceAccount`**: não inclua esse campo.</li></ul></td>
            </tr>
            <tr>
              <td><code> assuntos / namespace </code></td>
              <td>**Somente para `ServiceAccount`**: especifique o nome do namespace do Kubernetes no qual a conta do serviço está implementada.</td>
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
        kubectl apply -f filepath/my_role_binding.yaml
        ```
        {: pre}

    3.  Verifique se a ligação foi criada.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Agora que você criou e ligou uma função RBAC customizada do Kubernetes, acompanhe com usuários. Peça-lhes para testar uma ação que eles tenham permissão para concluir devido à função, como excluir um pod.


<br />



## Customizando as permissões de infraestrutura para um usuário
{: #infra_access}

Quando você configura políticas de infraestrutura no Identity and Access Management, um usuário recebe permissões que estão associadas a uma função. Algumas políticas são predefinidas, mas outras podem ser customizadas. Para customizar essas permissões, deve-se efetuar login na infraestrutura do IBM Cloud (SoftLayer) e ajustar as permissões lá.
{: #view_access}

Por exemplo, **Usuários básicos** podem reinicializar um nó do trabalhador, mas não podem recarregar um nó do trabalhador. Sem fornecer a essa pessoa as permissões de **Superusuário**, é possível ajustar as permissões de infraestrutura do IBM Cloud (SoftLayer) e incluir a permissão para executar um comando de recarregamento.

Se você tiver clusters de múltiplas zonas, o proprietário da conta de infraestrutura do IBM Cloud (SoftLayer) precisará ativar o VLAN Spanning para que os nós em diferentes zonas possam se comunicar dentro do cluster. O proprietário da conta também pode designar a um usuário a permissão **Rede > Gerenciar VLAN Spanning** para que o usuário possa ativar o VLAN Spanning. Para verificar se o VLAN Spanning já está ativado, use o [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}


1.  Efetue login em sua [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), em seguida, no menu, selecione **Infraestrutura**.

2.  Acesse **Conta** > **Usuários** > **Lista de usuários**.

3.  Para modificar permissões, selecione o nome de um perfil do usuário ou a coluna **Acesso ao dispositivo**.

4.  Na guia **Permissões do portal**, customize o acesso de usuário. As permissões que os usuários precisam dependem de quais recursos de infraestrutura eles precisam usar:

    * Use a lista suspensa **Permissões rápidas** para designar a função **Superusuário**, que fornece ao usuário todas as permissões.
    * Use a lista suspensa **Permissões rápidas** para designar a função **Usuário básico**, que fornece ao usuário algumas, mas não todas, permissões necessárias.
    * Se você não desejar conceder todas as permissões com a função **Superusuário** ou precisar incluir permissões além da função **Usuário básico**, revise a tabela a seguir que descreve as permissões necessárias para executar tarefas comuns no {{site.data.keyword.containerlong_notm}}.

    <table summary="Permissões de infraestrutura para cenários comuns do {{site.data.keyword.containerlong_notm}}.">
     <caption>Permissões de infraestrutura normalmente necessárias para o {{site.data.keyword.containerlong_notm}}</caption>
     <thead>
      <th>Tarefas comuns no {{site.data.keyword.containerlong_notm}}</th>
      <th>Permissões de infraestrutura necessárias por guia</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>Permissões mínimas</strong>: <ul><li>Crie um cluster.</li></ul></td>
         <td><strong>Dispositivos</strong>:<ul><li>Visualize os detalhes do Virtual Server</li><li>Reinicializar o servidor e visualizar informações do sistema IPMI</li><li>Emitir recarregamentos de OS e iniciar o kernel de resgate</li></ul><strong>Conta</strong>: <ul><li>Incluir/fazer upgrade de instâncias da nuvem</li><li>Incluir servidor</li></ul></td>
       </tr>
       <tr>
         <td><strong>Administração de cluster</strong>: <ul><li>Criar, atualizar e excluir clusters.</li><li>Incluir, recarregar e reinicializar nós do trabalhador.</li><li>Visualizar VLANs.</li><li>Criar sub-redes.</li><li>Implementar pods e serviços do balanceador de carga.</li></ul></td>
         <td><strong>Suporte</strong>:<ul><li>Visualizar chamados</li><li>Incluir chamados</li><li>Editar chamados</li></ul>
         <strong>Dispositivos</strong>:<ul><li>Visualize os detalhes do Virtual Server</li><li>Reinicializar o servidor e visualizar informações do sistema IPMI</li><li>Fazer upgrade do servidor</li><li>Emitir recarregamentos de OS e iniciar o kernel de resgate</li></ul>
         <strong>Serviços</strong>:<ul><li>Gerenciar chaves SSH</li></ul>
         <strong>Conta</strong>:<ul><li>Visualizar resumo da conta</li><li>Incluir/fazer upgrade de instâncias da nuvem</li><li>Cancelar servidor</li><li>Incluir servidor</li></ul></td>
       </tr>
       <tr>
         <td><strong>Armazenamento</strong>: <ul><li>Criar solicitações de volume persistente para provisionar volumes persistentes.</li><li>Criar e gerenciar recursos de infraestrutura de armazenamento.</li></ul></td>
         <td><strong>Serviços</strong>:<ul><li>Gerenciar armazenamento</li></ul><strong>Conta</strong>:<ul><li>Incluir armazenamento</li></ul></td>
       </tr>
       <tr>
         <td><strong>Rede privada</strong>: <ul><li>Gerenciar VLANs privadas para rede em cluster.</li><li>Configurar a conectividade VPN para redes privadas.</li></ul></td>
         <td><strong>Rede</strong>:<ul><li>Gerenciar rotas de sub-rede da rede</li><li>Gerenciar túneis de rede do IPSEC</li><li>Gerenciar gateways de rede</li><li>Administração da VPN</li></ul></td>
       </tr>
       <tr>
         <td><strong>Rede pública</strong>:<ul><li>Configurar o balanceador de carga pública ou rede de Ingresso para expor apps.</li></ul></td>
         <td><strong>Dispositivos</strong>:<ul><li>Gerenciar Load Balancers</li><li>Editar nome do host/domínio</li><li>Gerenciar controle de porta</li></ul>
         <strong>Rede</strong>:<ul><li>Incluir cálculo com porta de rede pública</li><li>Gerenciar rotas de sub-rede da rede</li><li>Incluir endereços IP</li></ul>
         <strong>Serviços</strong>:<ul><li>Gerenciar DNS, DNS reverso e WHOIS</li><li>Visualizar certificados (SSL)</li><li>Gerenciar certificados (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  Para salvar as suas mudanças, clique em **Editar permissões do portal**.

6.  Na guia **Acesso ao dispositivo**, selecione os dispositivos aos quais conceder acesso.

    * Na lista suspensa **Tipo de dispositivo**, é possível conceder acesso para **Todos os Virtual Servers**.
    * Para permitir que os usuários acessem novos dispositivos que são criados, selecione **Conceder acesso automaticamente quando novos dispositivos forem incluídos**.
    * Para salvar suas mudanças, clique em **Atualizar acesso ao dispositivo**.

Reduzindo permissões? Pode levar alguns minutos para a ação ser concluída.
{: tip}

<br />

