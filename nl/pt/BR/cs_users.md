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


# Designando acesso ao cluster
{: #users}

Como um administrador de cluster, é possível definir políticas de acesso para seu cluster do {{site.data.keyword.containerlong}} para criar diferentes níveis de acesso para diferentes usuários. Por exemplo, é possível autorizar determinados usuários a trabalhar com recursos de infraestrutura do cluster e outros a implementar somente contêineres.
{: shortdesc}

## Entendendo políticas de acesso e funções
{: #access_policies}

As políticas de acesso determinam o nível de acesso que os usuários em sua conta do {{site.data.keyword.Bluemix_notm}} têm para os recursos em toda a plataforma {{site.data.keyword.Bluemix_notm}}. Uma política designa a um usuário uma ou mais funções que definem o escopo de acesso a um único serviço ou a um conjunto de serviços e recursos organizados juntos em um grupo de recursos. Cada serviço no {{site.data.keyword.Bluemix_notm}} pode requerer seu próprio conjunto de políticas de acesso.
{: shortdesc}

À medida que você desenvolver seu plano para gerenciar o acesso de usuário, considere as etapas gerais a seguir:
1.  [Escolher a política de acesso e a função corretas para seus usuários](#access_roles)
2.  [Designar funções de acesso a indivíduos ou grupos de usuários no IAM](#iam_individuals_groups)
3.  [Definir o escopo de acesso de usuário a instâncias de cluster ou grupos de recursos](#resource_groups)

Depois de entender como funções, usuários e recursos em sua conta podem ser gerenciados, consulte [Configurando o acesso ao cluster](#access-checklist) para obter uma lista de verificação de como configurar o acesso.

### Escolher a política de acesso e a função corretas para seus usuários
{: #access_roles}

Deve-se definir políticas de acesso para cada usuário que trabalhe com o {{site.data.keyword.containerlong_notm}}. O escopo de uma política de acesso baseia-se em uma função ou funções definidas pelo usuário que determinam as ações que o usuário pode executar. Algumas políticas são predefinidas, mas outras podem ser customizadas. A mesma política é cumprida se o usuário faz a solicitação na GUI do {{site.data.keyword.containerlong_notm}} ou por meio da CLI, mesmo quando as ações são concluídas na infraestrutura do IBM Cloud (SoftLayer).
{: shortdesc}

Aprenda sobre os diferentes tipos de permissões e funções, qual função pode executar cada ação e como as funções se relacionam umas às outras.

Para ver as permissões específicas do {{site.data.keyword.containerlong_notm}} por função, consulte o tópico de referência [Permissões de acesso de usuário](cs_access_reference.html).
{: tip}

<dl>

<dt><a href="#platform"> Plataforma IAM </a></dt>
<dd>O {{site.data.keyword.containerlong_notm}} usa funções do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) para conceder aos usuários acesso para o cluster. As funções da plataforma IAM determinam as ações que os usuários podem executar em um cluster. É possível configurar as políticas para essas funções por região. Cada usuário que é designado a uma função da plataforma IAM também é automaticamente designado a uma função RBAC correspondente no namespace do Kubernetes `default`. Além disso, as funções da plataforma IAM autorizam você a executar ações de infraestrutura no cluster, mas não concedem acesso aos recursos de infraestrutura do IBM Cloud (SoftLayer). O acesso aos recursos de infraestrutura do IBM Cloud (SoftLayer) é determinado pela [chave API que está configurada para a região](#api_key).</br></br>
As ações de exemplo que são permitidas pelas funções da plataforma IAM estão criando ou removendo clusters, ligando serviços a um cluster ou incluindo nós extras do trabalhador.</dd>
<dt><a href="#role-binding"> RBAC </a></dt>
<dd>No Kubernetes, o controle de acesso baseado na função (RBAC) é uma maneira de proteger os recursos dentro de seu cluster. As funções RBAC determinam as ações do Kubernetes que os usuários podem executar nesses recursos. Cada usuário que é designado a uma função da plataforma IAM é designado automaticamente a uma função de cluster RBAC correspondente no Kubernetes `default`. Essa função de cluster RBAC é aplicada no namespace padrão ou em todos os namespaces, dependendo da função da plataforma IAM escolhida.</br></br>
As ações de exemplo que são permitidas pelas funções RBAC estão criando objetos como pods ou lendo logs de pod.</dd>
<dt><a href="#api_key"> Infraestrutura </a></dt>
<dd>As funções de infraestrutura permitem o acesso a seus recursos de infraestrutura do IBM Cloud (SoftLayer). Configure um usuário com a função de infraestrutura **Superusuário ** e armazene as credenciais de infraestrutura desse usuário em uma chave API. Em seguida, configure a chave API em cada região na qual você deseja criar clusters. Depois de configurar a chave API, outros usuários para os quais você concede acesso ao {{site.data.keyword.containerlong_notm}} não precisam de funções de infraestrutura porque a chave API é compartilhada para todos os usuários dentro da região. Em vez disso, as funções da plataforma IAM determinam as ações de infraestrutura que os usuários têm permissão para executar. Se você não configurar a chave API com a infraestrutura de <strong>Superusuário</strong> integral ou precisar conceder acesso ao dispositivo específico para os usuários, será possível [customizar as permissões de infraestrutura](#infra_access). </br></br>
As ações de exemplo que são permitidas por funções de infraestrutura estão visualizando os detalhes das máquinas de nó do trabalhador do cluster ou editando os recursos de rede e armazenamento.</dd>
<dt>Cloud Foundry</dt>
<dd>Nem todos os serviços podem ser gerenciados com o {{site.data.keyword.Bluemix_notm}} IAM. Se você estiver usando um desses serviços, será possível continuar a usar as funções de usuário do Cloud Foundry para controlar o acesso a esses serviços. As funções do Cloud Foundry concedem acesso a organizações e espaços dentro da conta. Para ver a lista de serviços baseados no Cloud Foundry no {{site.data.keyword.Bluemix_notm}}, execute <code>ibmcloud service list</code>.</br></br>
As ações de exemplo que são permitidas pelas funções do Cloud Foundry estão criando uma nova instância de serviço do Cloud Foundry ou ligando uma instância de serviço do Cloud Foundry a um cluster. Para saber mais, veja as [funções de organização e espaço](/docs/iam/cfaccess.html) ou as etapas para [gerenciar o acesso do Cloud Foundry](/docs/iam/mngcf.html) na documentação do IAM.</dd>
</dl>

### Designar funções de acesso a indivíduos ou grupos de usuários no IAM
{: #iam_individuals_groups}

Quando você configura políticas do IAM, é possível designar funções a um usuário individual ou a um grupo de usuários.
{: shortdesc}

<dl>
<dt>Usuários individuais</dt>
<dd>Você pode ter um usuário específico que precise de mais ou menos permissões do que o restante de sua equipe. É possível customizar permissões em uma base individual para que cada pessoa tenha as permissões que elas precisam para concluir suas tarefas. É possível designar mais de uma função do IAM para cada usuário.</dd>
<dt>Vários usuários em um grupo de acesso</dt>
<dd>É possível criar um grupo de usuários e, em seguida, designar permissões a esse grupo. Por exemplo, é possível agrupar todos os chefes de equipe e designar acesso de administrador ao grupo. Em seguida, é possível agrupar todos os desenvolvedores e designar somente acesso de gravação a esse grupo. É possível designar mais de uma função do IAM para cada grupo de acesso. Quando você designa permissões a um grupo, qualquer usuário que é incluído ou removido desse grupo é afetado. Se você incluir um usuário no grupo, ele também terá o acesso adicional. Se ele for removido, seu acesso será revogado.</dd>
</dl>

As funções do IAM não podem ser designadas a uma conta de serviço. Em vez disso, é possível [designar funções RBAC a contas de serviço](#rbac) diretamente.
{: tip}

Deve-se também especificar se os usuários têm acesso a um cluster em um grupo de recursos, todos os clusters em um grupo de recursos ou todos os clusters em todos os grupos de recursos em sua conta.

### Definir o escopo de acesso de usuário a instâncias de cluster ou grupos de recursos
{: #resource_groups}

No IAM, é possível designar funções de acesso de usuário a instâncias de recurso ou grupos de recursos.
{: shortdesc}

Quando você cria sua conta do {{site.data.keyword.Bluemix_notm}}, o grupo de recursos padrão é criado automaticamente. Se você não especificar um grupo de recursos quando criar o recurso, as instâncias de recurso (clusters) pertencerão ao grupo de recursos padrão. Se você desejar incluir um grupo de recursos em sua conta, veja [Melhores práticas para configurar a sua conta ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications) e [Configurando seus grupos de recursos](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups).

<dl>
<dt>Instância de recurso</dt>
  <dd><p>Cada serviço do {{site.data.keyword.Bluemix_notm}} em sua conta é um recurso que tem instâncias. A instância difere por serviço. Por exemplo, no {{site.data.keyword.containerlong_notm}}, a instância é um cluster, mas no {{site.data.keyword.cloudcerts_long_notm}}, a instância é um certificado. Por padrão, os recursos também pertencem ao grupo de recursos padrão em sua conta. É possível designar aos usuários uma função de acesso a uma instância de recurso para os cenários a seguir.
  <ul><li>Todos os serviços do IAM em sua conta, incluindo todos os clusters no {{site.data.keyword.containerlong_notm}} e imagens no {{site.data.keyword.registrylong_notm}}.</li>
  <li>Todas as instâncias dentro de um serviço, como todos os clusters no {{site.data.keyword.containerlong_notm}}.</li>
  <li>Todas as instâncias dentro de uma região de um serviço, como todos os clusters na região **Sul dos EUA** do {{site.data.keyword.containerlong_notm}}.</li>
  <li>Para uma instância individual, como um cluster.</li></ul></dd>
<dt>Grupo de Recurso</dt>
  <dd><p>É possível organizar seus recursos de conta em agrupamentos customizáveis para que seja possível designar rapidamente a indivíduos ou grupos de usuários acesso a mais de um recurso de cada vez. Os grupos de recursos podem ajudar operadores e administradores a filtrar recursos para visualizar seu uso atual, solucionar problemas e gerenciar equipes.</p>
  <p>**Importante**: se tiver outros serviços em sua conta do {{site.data.keyword.Bluemix_notm}} que você deseja usar com seu cluster, os serviços e seu cluster deverão estar no mesmo grupo de recursos. Um recurso pode ser criado em apenas um grupo de recursos que não pode ser mudado posteriormente. Se você cria um cluster no grupo de recursos errado, deve-se excluir o cluster e recriá-lo no grupo de recursos correto.</p>
  <p>Se você planeja usar o [{{site.data.keyword.monitoringlong_notm}} para métricas ](cs_health.html#view_metrics), considere fornecer nomes exclusivos de clusters em grupos de recursos e regiões em sua conta para evitar conflitos de nomenclatura de métricas. Não é possível renomear um cluster.</p>
  <p>É possível designar aos usuários uma função de acesso a um grupo de recursos para os cenários a seguir. Observe que, diferentemente das instâncias de recurso, não é possível conceder acesso a uma instância individual dentro de um grupo de recursos.</p>
  <ul><li>Todos os serviços do IAM no grupo de recursos, incluindo todos os clusters no {{site.data.keyword.containerlong_notm}} e imagens no {{site.data.keyword.registrylong_notm}}.</li>
  <li>Todas as instâncias dentro de um serviço no grupo de recursos, como todos os clusters no {{site.data.keyword.containerlong_notm}}.</li>
  <li>Todas as instâncias dentro de uma região de um serviço no grupo de recursos, como todos os clusters na região **Sul dos EUA** do {{site.data.keyword.containerlong_notm}}.</li></ul></dd>
</dl>

<br />


## Configurando o acesso ao cluster
{: #access-checklist}

Depois de [entender como as funções, os usuários e os recursos em sua conta](#access_policies) podem ser gerenciados, use a lista de verificação a seguir para configurar o acesso de usuário em seu cluster.
{: shortdesc}

1. [Configure a chave API](#api_key) para todas as regiões e os grupos de recursos nos quais você deseja criar clusters.
2. Convide os usuários para sua conta e [designe a eles funções do IAM](#platform) para o {{site.data.keyword.containerlong_notm}}. 
3. Para permitir que os usuários liguem serviços ao cluster ou visualizem logs que são encaminhados de configurações de criação de log de cluster, [conceda aos usuários funções do Cloud Foundry](/docs/iam/mngcf.html) para a organização e o espaço nos quais os serviços estão implementados ou onde os logs são coletados.
4. Se você usar namespaces do Kubernetes para isolar recursos dentro do cluster, [copie as ligações de função RBAC do Kubernetes para as funções da plataforma IAM **Visualizador** e **Editor** para outros namespaces](#role-binding).
5. Para qualquer conjunto de ferramentas de automação, como em seu pipeline CI/CD, configure as contas de serviço e [designe às contas de serviço as permissões RBAC do Kubernetes](#rbac).
6. Para obter outras configurações avançadas para controlar o acesso a seus recursos de cluster no nível do pod, veja [Configurando a segurança do pod](/docs/containers/cs_psp.html).

</br>

Para obter mais informações sobre a configuração de sua conta e recursos, tente este tutorial sobre as [melhores práticas para organizar usuários, equipes e aplicativos](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications).
{: tip}

<br />


## Configurando a chave API para permitir o acesso ao portfólio de infraestrutura
{: #api_key}

Para provisionar e trabalhar com clusters com êxito, deve-se assegurar que a sua conta do {{site.data.keyword.Bluemix_notm}} esteja configurada corretamente para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer).
{: shortdesc}

**Maioria de casos**: a sua conta Pré-paga do {{site.data.keyword.Bluemix_notm}} já tem acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer). Para configurar o acesso do {{site.data.keyword.containerlong_notm}} ao portfólio, o **proprietário da conta** deve configurar a chave API para a região e o grupo de recursos.

1. Efetue login no terminal como o proprietário da conta.
    ```
    ibmcloud login [ -- sso ]
    ```
    {: pre}

2. Destine o grupo de recursos no qual você deseja configurar a chave API. Se você não destinar um grupo de recursos, a chave API será configurada para o grupo de recursos padrão.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. Se você estiver em uma região diferente, mude para a região na qual você deseja configurar a chave API.
    ```
    ibmcloud ks region-set
    ```
    {: pre}

4. Configure a chave API para a região e o grupo de recursos.
    ```
    ibmcloud ks api-key-reset
    ```
    {: pre}    

5. Verifique se a chave API está configurada.
    ```
    ibmcloud ks api-key-info <cluster_name_or_ID>
    ```
    {: pre}

6. Repita para cada região e grupo de recursos no qual você deseja criar clusters.

**Opções alternativas e mais informações**: para obter maneiras diferentes de acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer), consulte as seções a seguir.
* Se você não tiver certeza se a sua conta já tem acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer), veja [Entendendo o acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer)](#understand_infra).
* Se o proprietário da conta não estiver configurando a chave API, [assegure-se de que o usuário que configura a chave API tenha as permissões corretas](#owner_permissions).
* Para obter mais informações sobre como usar sua conta padrão para configurar a chave API, veja [Acessando o portfólio de infraestrutura com a sua conta Pré-paga padrão do {{site.data.keyword.Bluemix_notm}}](#default_account).
* Se você não tiver uma conta Pré-paga padrão ou precisar usar uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente, veja [Acessando uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente](#credentials).

### Entendendo o acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer)
{: #understand_infra}

Determine se sua conta tem acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer) e aprenda como o {{site.data.keyword.containerlong_notm}} usa a chave API para acessar o portfólio.
{: shortdesc}

**A minha conta já tem acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer)?**</br>

Para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer), você usa uma conta Pré-paga do {{site.data.keyword.Bluemix_notm}}. Se você tiver um tipo diferente de conta, visualize suas opções na tabela a seguir.

<table summary="A tabela mostra as opções de criação do cluster padrão por tipo de conta. As linhas devem ser lidas da esquerda para a direita, com a descrição da conta na coluna um e as opções para criar um cluster padrão na coluna dois.">
<caption>Opções de criação de cluster padrão por tipo de conta</caption>
  <thead>
  <th>Descrição da conta</th>
  <th>Opções para criar um cluster padrão</th>
  </thead>
  <tbody>
    <tr>
      <td>**Contas Lite** não podem provisionar clusters.</td>
      <td>[Faça upgrade de sua conta Lite para uma conta Pré-paga do {{site.data.keyword.Bluemix_notm}}](/docs/account/index.html#paygo).</td>
    </tr>
    <tr>
      <td>As contas **Pré-pagas** vêm com acesso ao portfólio de infraestrutura.</td>
      <td>É possível criar clusters padrão. Use uma chave API para configurar permissões de infraestrutura para seus clusters.</td>
    </tr>
    <tr>
      <td>As **contas de assinatura** não são configuradas com acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer).</td>
      <td><p><strong>Opção 1:</strong> [Criar uma nova conta pré-paga](/docs/account/index.html#paygo) que é configurada com acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer). Ao escolher essa opção, você tem duas contas e faturamentos separados do {{site.data.keyword.Bluemix_notm}}.</p><p>Se você deseja continuar usando a sua conta de Assinatura, é possível usar sua nova conta pré-paga para gerar uma chave API na infraestrutura do IBM Cloud (SoftLayer). Em seguida, deve-se configurar manualmente a chave API de infraestrutura do IBM Cloud (SoftLayer) para a sua conta de Assinatura. Mantenha em mente que os recursos de infraestrutura do IBM Cloud (SoftLayer) são cobrados através de sua nova conta pré-paga.</p><p><strong>Opção 2:</strong> se você já tiver uma conta de infraestrutura do IBM Cloud (SoftLayer) existente que deseja usar, será possível configurar manualmente as credenciais de infraestrutura do IBM Cloud (SoftLayer) para sua conta do {{site.data.keyword.Bluemix_notm}}.</p><p>**Nota:** quando você se vincula manualmente a uma conta de infraestrutura do IBM Cloud (SoftLayer), as credenciais são usadas para cada ação específica da infraestrutura do IBM Cloud (SoftLayer) em sua conta do {{site.data.keyword.Bluemix_notm}}. Deve-se assegurar que a chave API configurada possua [permissões de infraestrutura suficientes](cs_users.html#infra_access) para que os usuários possam criar e trabalhar com clusters.</p></td>
    </tr>
    <tr>
      <td>**Contas de infraestrutura do IBM Cloud (SoftLayer)**, nenhuma conta do {{site.data.keyword.Bluemix_notm}}</td>
      <td><p>[ Crie uma conta  {{site.data.keyword.Bluemix_notm}}  Pay-As-You-Go ](/docs/account/index.html#paygo). Você tem duas contas de infraestrutura do IBM Cloud (SoftLayer) separadas e faturamento.</p><p>Por padrão, a sua nova conta do {{site.data.keyword.Bluemix_notm}} usa a nova conta de infraestrutura. Para continuar usando a conta de infraestrutura antiga, configure manualmente as credenciais.</p></td>
    </tr>
  </tbody>
  </table>

**Agora que meu portfólio de infraestrutura está configurado, como o {{site.data.keyword.containerlong_notm}} acessa o portfólio?**</br>

O {{site.data.keyword.containerlong_notm}} acessa o portfólio de infraestrutura do IBM Cloud (SoftLayer) usando uma chave API. A chave API armazena as credenciais de um usuário com acesso a uma conta de infraestrutura do IBM Cloud (SoftLayer). As chaves de API são configuradas por região dentro de um grupo de recursos e são compartilhadas por usuários nessa região.
 
Para permitir que todos os usuários acessem o portfólio de infraestrutura do IBM Cloud (SoftLayer), o usuário cujas credenciais você armazena na chave API deve ter [a função de infraestrutura **Superusuário** e a função de plataforma **Administrador**](#owner_permissions) para o {{site.data.keyword.containerlong_notm}} em sua conta do IBM Cloud. Em seguida, permita que esse usuário execute a primeira ação de administrador em uma região. As credenciais de infraestrutura do usuário são armazenadas em uma chave API para essa região. Outros usuários dentro da conta compartilham a chave API para acessar a infraestrutura. É possível, então, controlar quais ações de infraestrutura os usuários podem executar, designando a [função de plataforma IAM](#platform) apropriada.

Por exemplo, se desejar criar um cluster em uma nova região, certifique-se de que o primeiro cluster seja criado por um usuário com a função de infraestrutura **Superusuário**, como o proprietário da conta. Depois, é possível convidar usuários individuais ou usuários em grupos de acesso do IAM para essa região, configurando políticas de gerenciamento da plataforma IAM para eles nessa região. Um usuário com uma função da plataforma IAM `Viewer` não tem autorização para incluir um nó do trabalhador. Portanto, a ação `worker-add` falha, mesmo que a chave API tenha as permissões de infraestrutura corretas. Se você mudar a função da plataforma IAM do usuário para **Operador**, o usuário será autorizado a incluir um nó do trabalhador. A ação `worker-add` é bem-sucedida porque a função de usuário está autorizada e a chave API está configurada corretamente. Não é necessário editar as permissões de infraestrutura do IBM Cloud (SoftLayer) do usuário.

**E se eu não desejar designar ao proprietário da chave da API ou ao proprietário de credenciais a função de infraestrutura de Superusuário?**</br>

Por motivos de conformidade, segurança ou faturamento, talvez você não queira fornecer a função de infraestrutura **Superusuário** para o usuário que configura a chave API ou cujas credenciais são configuradas com o comando `ibmcloud ks credentials-set`. No entanto, se esse usuário não tiver a função **Superusuário**, as ações relacionadas à infraestrutura, como a criação de um cluster ou o recarregamento de um nó do trabalhador, poderão falhar. Em vez de usar as funções da plataforma IAM para controlar o acesso de infraestrutura dos usuários, deve-se [configurar permissões específicas de infraestrutura do IBM Cloud (SoftLayer)](#infra_access) para os usuários.

**Como configurar a chave API para meu cluster?**</br>

Depende de qual tipo de conta você está usando para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer):
* [ Uma conta  {{site.data.keyword.Bluemix_notm}}  Pay-As-You-Go padrão ](#default_account)
* [Uma conta diferente da infraestrutura do IBM Cloud (SoftLayer) que não está vinculada à sua {{site.data.keyword.Bluemix_notm}}conta Pré-paga](#credentials) padrão

### Assegurando que o proprietário das credenciais de chave API ou de infraestrutura tenha as permissões corretas
{: #owner_permissions}

Para assegurar que todas as ações relacionadas à infraestrutura possam ser concluídas com êxito no cluster, o usuário cujas credenciais você deseja configurar para a chave API devem ter as permissões adequadas.
{: shortdesc}

1. Efetue login no console do [{{site.data.keyword.Bluemix_notm}}![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/).

2. Para certificar-se de que todas as ações relacionadas à conta possam ser executadas com êxito, verifique se o usuário tem as funções corretas da plataforma IAM.
    1. Navegue para  ** Gerenciar > Conta > Usuários **.
    2. Clique no nome do usuário para o qual deseja configurar a chave API ou cujas credenciais você deseja configurar para a chave API.
    3. Se o usuário não tiver a função **Administrador** para todos os clusters do {{site.data.keyword.containerlong_notm}} em todas as regiões, [designe essa função de plataforma ao usuário](#platform).
    4. Se o usuário não tiver pelo menos a função **Visualizador** para o grupo de recursos no qual você deseja configurar a chave API, [designe essa função de grupo de recursos ao usuário](#platform).
    5. Para criar clusters, o usuário também precisa da função **Administrador** para o {{site.data.keyword.registryshort_notm}}.

3. Para certificar-se de que todas as ações relacionadas à infraestrutura em seu cluster possam ser executadas com êxito, verifique se o usuário tem as políticas de acesso de infraestrutura corretas.
    1. No menu de expansão, selecione **Infraestrutura**.
    2. Na barra de menus, selecione **Conta** > **Usuários** > **Lista de usuários**.
    3. Na coluna **Chave API**, verifique se o usuário possui uma Chave API ou clique em **Gerar**.
    4. Selecione o nome do perfil do usuário e verifique as permissões do usuário.
    5. Se o usuário não tiver a função **Superusuário**, clique na guia **Permissões do portal**.
        1. Use a lista suspensa **Permissões rápidas** para designar a função **Superusuário**.
        2. Clique em  ** Configurar Permissões **.

### Acessando o portfólio da infraestrutura com sua conta Pré-paga padrão do {{site.data.keyword.Bluemix_notm}}
{: #default_account}

Se tiver uma conta Pré-paga do {{site.data.keyword.Bluemix_notm}}, você terá acesso a um portfólio de infraestrutura do IBM Cloud (SoftLayer) vinculado por padrão. A chave API é usada para pedir recursos de infraestrutura desse portfólio de infraestrutura do IBM Cloud (SoftLayer), como novos nós do trabalhador ou VLANs.
{: shortdec}

É possível localizar o proprietário da chave API atual executando [`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info). Se você achar que precisa atualizar a chave API que está armazenada para uma região, é possível fazer isso executando o comando [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset). Esse comando requer a política de acesso de administrador do {{site.data.keyword.containerlong_notm}} e armazena a chave API do usuário que executa esse comando na conta. **Nota**: tenha certeza de que deseja reconfigurar a chave e entender o impacto em seu app. A chave é usada em vários locais diferentes e poderá causar mudanças radicais se ela for mudada desnecessariamente.

** Antes de iniciar **:
- Se o proprietário da conta não estiver configurando a chave API, [assegure-se de que o usuário que configura a chave API tenha as permissões corretas](#owner_permissions).
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

Para configurar a chave API para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer):

1.  Configure a chave API para a região e o grupo de recursos em que o cluster está.
    1.  Efetue login no terminal com o usuário cujas permissões de infraestrutura você deseja usar.
    2.  Destine o grupo de recursos no qual você deseja configurar a chave API. Se você não destinar um grupo de recursos, a chave API será configurada para o grupo de recursos padrão.
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  Se você estiver em uma região diferente, mude para a região na qual você deseja configurar a chave API.
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  Configure a chave API do usuário para a região.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  Verifique se a chave API está configurada.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

2. [Criar um cluster](cs_clusters.html). Para criar o cluster, as credenciais da chave API que você configura para a região e o grupo de recursos são usadas.

### Acessando uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente
{: #credentials}

Em vez de usar a conta padrão de infraestrutura do IBM Cloud (SoftLayer) vinculada para pedir a infraestrutura para clusters em uma região, talvez seja melhor usar uma conta de infraestrutura do IBM Cloud (SoftLayer) diferente da que você já tem. É possível vincular essa conta de infraestrutura à sua conta do {{site.data.keyword.Bluemix_notm}} usando o comando [`ibmcloud ks credentials-set`](cs_cli_reference.html#cs_credentials_set). As credenciais de infraestrutura do IBM Cloud (SoftLayer) são usadas em vez das credenciais de conta Pré-paga padrão que são armazenadas para a região.

**Importante**: as credenciais de infraestrutura do IBM Cloud (SoftLayer) configuradas pelo comando `ibmcloud ks credentials-set` persistem após o término da sessão. Se você remover as credenciais de infraestrutura do IBM Cloud (SoftLayer) que foram configuradas manualmente com o comando [`ibmcloud ks credentials-unset`](cs_cli_reference.html#cs_credentials_unset), as credenciais de conta Pré-paga padrão serão usadas. No entanto, essa mudança nas credenciais de conta de infraestrutura pode causar [clusters órfãos](cs_troubleshoot_clusters.html#orphaned).

** Antes de iniciar **:
- Se não estiver usando as credenciais do proprietário da conta, [assegure-se de que o usuário cujas credenciais você deseja configurar para a chave API tenha as permissões corretas](#owner_permissions).
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

Para configurar as credenciais de conta de infraestrutura para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer):

1. Obtenha a conta de infraestrutura que você deseja usar para acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer). Você tem opções diferentes que dependem de seu [tipo de conta atual](#understand_infra).

2.  Configure as credenciais de API de infraestrutura com o usuário para a conta correta.

    1.  Obter as credenciais da API de infraestrutura do usuário. **Nota**: as credenciais são diferentes do IBMid.

        1.  No console do [{{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/), tabela **Infraestrutura** > **Conta** > **Usuários** > **Lista de usuários**, clique no **IBMid ou nome do usuário**.

        2.  Na seção **Informações de acesso à API**, visualize o **Nome do usuário da API** e a **Chave de autenticação**.    

    2.  Configure as credenciais de API de infraestrutura a serem usadas.
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

    3. Verifique se as credenciais corretas estão configuradas.
        ```
        ibmcloud ks credential-get
        ```
        Saída de exemplo:
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [Criar um cluster](cs_clusters.html). Para criar o cluster, as credenciais de infraestrutura configuradas para a região e o grupo de recursos são usadas.

4. Verifique se o seu cluster usa as credenciais de conta de infraestrutura configuradas.
  1. Abra a [GUI do IBM Cloud Kubernetes Service ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/containers-kubernetes/clusters) e selecione seu cluster. 
  2. Na guia Visão geral, procure um campo **Usuário de infraestrutura**. 
  3. Se vir esse campo, você não usará as credenciais de infraestrutura padrão que vêm com sua conta Pré-paga nessa região. Em vez disso, a região é configurada para usar as credenciais de conta de infraestrutura diferentes que você configurou.

<br />


## Concedendo aos usuários acesso ao seu cluster por meio do IAM
{: #platform}

Configure as políticas de gerenciamento da plataforma IAM na [GUI](#add_users) ou [CLI](#add_users_cli) para que os usuários possam trabalhar com clusters no {{site.data.keyword.containerlong_notm}}. Antes de iniciar, consulte [Entendendo políticas e funções de acesso](#access_policies) para revisar quais são as políticas, a quem é possível designar políticas e a quais recursos as políticas podem ser concedidas.
{: shortdesc}

As funções do IAM não podem ser designadas a uma conta de serviço. Em vez disso, é possível [designar funções RBAC a contas de serviço](#rbac) diretamente.
{: tip}

### Designando funções IAM com a GUI
{: #add_users}

Conceda aos usuários acesso a seus clusters designando funções de gerenciamento da plataforma IAM com a GUI.
{: shortdesc}

Antes de iniciar, verifique se você está designado à função **Administrador** da plataforma IAM para a conta do {{site.data.keyword.Bluemix_notm}} na qual está trabalhando.

1. Efetue login na [GUI do IBM Cloud](https://console.bluemix.net/) e navegue para **Gerenciar > Conta > Usuários**.

2. Selecione os usuários individualmente ou crie um grupo de acesso de usuários.
    * Para designar funções a um usuário individual:
      1. Clique no nome do usuário para o qual você deseja configurar permissões. Se o usuário não for mostrado, clique em **Convidar usuários** para incluí-los na conta.
      2. Clique em  ** Designar acesso **.
    * Para designar funções a múltiplos usuários em um grupo de acesso:
      1. Na navegação à esquerda, clique em **Grupos de acesso**.
      2. Clique em **Criar** e forneça a seu grupo um **Nome** e uma **Descrição**. Clique em
**Criar**.
      3. Clique em **Incluir usuários** para incluir pessoas em seu grupo de acesso. Uma lista de usuários que têm acesso à sua conta é mostrada.
      4. Marque a caixa ao lado dos usuários que você deseja incluir no grupo. Uma caixa de diálogo é exibida.
      5. Clique em **Incluir no grupo**.
      6. Clique em **Políticas de acesso**.
      7. Clique em  ** Designar acesso **.

3. Designar uma política.
  * Para acesso a todos os clusters em um grupo de recursos:
    1. Clique em **Designar acesso dentro de um grupo de recursos**.
    2. Selecione o nome do grupo de recursos.
    3. Na lista **Serviços** , selecione **{{site.data.keyword.containershort_notm}}**.
    4. Na lista **Região**, selecione uma ou todas as regiões.
    5. Selecione uma  ** Função de acesso da plataforma **. Para localizar uma lista de ações suportadas por função, consulte [Permissões de acesso do usuário](/cs_access_reference.html#platform).
    6. Clique em **Designar**.
  * Para acesso a um cluster em um grupo de recursos ou a todos os clusters em todos os grupos de recursos:
    1. Clique em  ** Designar acesso a recursos **.
    2. Na lista **Serviços** , selecione **{{site.data.keyword.containershort_notm}}**.
    3. Na lista **Região**, selecione uma ou todas as regiões.
    4. Na lista **Instância de serviço**, selecione um nome de cluster ou **Todas as instâncias de serviço**.
    5. Na seção **Selecionar funções**, escolha uma função de acesso da plataforma IAM. Para localizar uma lista de ações suportadas por função, consulte [Permissões de acesso do usuário](/cs_access_reference.html#platform). Nota: se você designa a um usuário a função **Administrador** da plataforma IAM para somente um cluster, deve-se também designar ao usuário a função **Visualizador** para todos os clusters nessa região no grupo de recursos.
    6. Clique em **Designar**.

4. Se você desejar que os usuários sejam capazes de trabalhar com clusters em um grupo de recursos diferente do padrão, eles precisarão de acesso adicional aos grupos de recursos nos quais os clusters estão. É possível designar esses usuários pelo menos à função **Visualizador** para grupos de recursos.
  1. Clique em **Designar acesso dentro de um grupo de recursos**.
  2. Selecione o nome do grupo de recursos.
  3. Na lista **Designar acesso a um grupo de recursos**, selecione a função **Visualizador**. Essa função permite que os usuários acessem o grupo de recursos em si, mas não os recursos dentro do grupo.
  4. Clique em **Designar**.

### Designando funções do IAM com a CLI
{: #add_users_cli}

Conceda aos usuários acesso a seus clusters designando funções de gerenciamento de plataforma IAM com a CLI.
{: shortdesc}

** Antes de iniciar **:

- Verifique se você está designado à função `cluster-admin` da plataforma IAM para a conta do {{site.data.keyword.Bluemix_notm}} na qual está trabalhando.
- Verifique se o usuário está incluído na conta. Se o usuário não estiver, convide-o para sua conta executando `ibmcloud account user-invite <user@email.com>`.
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

**Para designar funções do IAM a um usuário individual com a CLI:**

1.  Crie uma política de acesso do IAM para configurar permissões para o {{site.data.keyword.containerlong_notm}} (**`--service-name containers-kubernetes`**). É possível escolher Visualizador, Editor, Operador e Administrador para a função da plataforma IAM. Para localizar uma lista de ações suportadas por função, consulte [Permissões de acesso do usuário](cs_access_reference.html#platform).
    * Para designar acesso a um cluster em um grupo de recursos:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Nota**: caso você designe a um usuário a função **Administrador** da plataforma IAM para somente um cluster, deve-se também designar ao usuário a função **Visualizador** para todos os clusters na região do grupo de recursos.

    * Para designar acesso a todos os clusters em um grupo de recursos:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * Para designar acesso a todos os clusters em todos os grupos de recursos:
      ```
      ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

2. Se você desejar que os usuários sejam capazes de trabalhar com clusters em um grupo de recursos diferente do padrão, eles precisarão de acesso adicional aos grupos de recursos nos quais os clusters estão. É possível designar esses usuários pelo menos à função **Visualizador** para grupos de recursos. É possível localizar o ID do grupo de recursos executando `ibmcloud resource group <resource_group_name> -- id `.
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. Para que as mudanças entrem em vigor, atualize a configuração do cluster.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. A função da plataforma IAM é aplicada automaticamente como uma [ligação de função RBAC ou ligação de função de cluster](#role-binding) correspondente. Verifique se o usuário foi incluído na função RBAC executando um dos comandos a seguir para a função da plataforma IAM designada:
    * Visualizador:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-opera -o yaml
        ```
        {: pre}
    * Administrador:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  Por exemplo, se você designar ao usuário `john@email.com` a função **Visualizador** da plataforma IAM e executar `kubectl get rolebinding ibm-view -o yaml -n default`, a saída será semelhante à seguinte:

  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-view
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-view
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: view
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: https://iam.ng.bluemix.net/IAM#user@email.com
  ```
  {: screen}


** Para designar funções da plataforma IAM a múltiplos usuários em um grupo de acesso com a CLI:**

1. Crie um grupo de acesso.
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. Inclua usuários no grupo de acesso.
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. Crie uma política de acesso do IAM para configurar permissões para o {{site.data.keyword.containerlong_notm}}. É possível escolher Visualizador, Editor, Operador e Administrador para a função da plataforma IAM. Para localizar uma lista de ações suportadas por função, consulte [Permissões de acesso do usuário](/cs_access_reference.html#platform).
  * Para designar acesso a um cluster em um grupo de recursos:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Nota**: caso você designe a um usuário a função **Administrador** da plataforma IAM para somente um cluster, deve-se também designar ao usuário a função **Visualizador** para todos os clusters na região do grupo de recursos.

  * Para designar acesso a todos os clusters em um grupo de recursos:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * Para designar acesso a todos os clusters em todos os grupos de recursos:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. Se você desejar que os usuários sejam capazes de trabalhar com clusters em um grupo de recursos diferente do padrão, eles precisarão de acesso adicional aos grupos de recursos nos quais os clusters estão. É possível designar esses usuários pelo menos à função **Visualizador** para grupos de recursos. É possível localizar o ID do grupo de recursos executando `ibmcloud resource group <resource_group_name> -- id `.
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. Se você tiver designado acesso a todos os clusters em todos os grupos de recursos, repita esse comando para cada grupo de recursos na conta.

5. Para que as mudanças entrem em vigor, atualize a configuração do cluster.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. A função da plataforma IAM é aplicada automaticamente como uma [ligação de função RBAC ou ligação de função de cluster](#role-binding) correspondente. Verifique se o usuário foi incluído na função RBAC executando um dos comandos a seguir para a função da plataforma IAM designada:
    * Visualizador:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-opera -o yaml
        ```
        {: pre}
    * Administrador:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  Por exemplo, se você designar ao grupo de acesso `team1` a função **Visualizador** da plataforma IAM e executar ` kubectl get rolebinding ibm-view -o yaml -n default`, a saída será semelhante à seguinte:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-edit
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-edit
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team1
  ```
  {: screen}

<br />




## Designando permissões de RBAC
{: #role-binding}

**O que são funções RBAC e funções de cluster?**</br>

As funções RBAC e as funções de cluster definem um conjunto de permissões de como os usuários podem interagir com recursos do Kubernetes em seu cluster. Uma função tem o escopo definido para recursos dentro de um namespace específico, como uma implementação. Uma função de cluster tem o escopo definido para recursos em todo o cluster (como nós do trabalhador) ou para recursos com escopo definido por namespace que podem ser localizados em cada namespace, como pods.

**O que são ligações de função RBAC e ligações de função de cluster?**</br>

As ligações de função aplicam funções RBAC ou funções de cluster a um namespace específico. Ao usar uma ligação de função para aplicar uma função, você fornece a um usuário acesso a um recurso específico em um namespace específico. Ao usar uma ligação de função para aplicar uma função de cluster, você fornece a um usuário acesso a recursos com escopo definido por namespace que podem ser localizados em cada namespace, como pods, mas somente dentro de um namespace específico.

As ligações de função de cluster aplicam funções de cluster RBAC a todos os namespaces no cluster. Ao usar uma ligação de função de cluster para aplicar uma função de cluster, você fornece a um usuário acesso a recursos em todo o cluster (como nós do trabalhador) ou a recursos com escopo definido por namespace em cada namespace, como pods.

**Como essas funções se parecem em meu cluster?**</br>

Cada usuário que é designado a uma [função de gerenciamento da plataforma IAM](#platform) é designado automaticamente a uma função de cluster RBAC correspondente. Essas funções de cluster RBAC são predefinidas e permitem que os usuários interajam com recursos do Kubernetes em seu cluster. Além disso, uma ligação de função é criada para aplicar a função de cluster a um namespace específico ou uma ligação de função de cluster é criada para aplicar a função de cluster a todos os namespaces.

A tabela a seguir descreve os relacionamentos entre as funções da plataforma IAM e as funções de cluster e ligações de função correspondentes ou ligações de função de cluster que são criadas automaticamente para as funções da plataforma IAM.

<table>
  <tr>
    <th>Função da plataforma IAM</th>
    <th>Função do cluster RBAC</th>
    <th>Ligação de função RBAC</th>
    <th>Ligação de função de cluster RBAC</th>
  </tr>
  <tr>
    <td>Viewer</td>
    <td><code> visualização </code></td>
    <td><code> ibm-view </code>  no namespace padrão</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Aplicativos</td>
    <td><code> editar </code></td>
    <td><code> ibm-edit </code>  no namespace padrão</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Operador</td>
    <td><code> admin </code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrator</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code> ibm-admin </code></td>
  </tr>
</table>

Para saber mais sobre as ações permitidas por função RBAC, consulte o tópico de referência [Permissões de acesso de usuário](cs_access_reference.html#platform).
{: tip}

**Como posso gerenciar permissões de RBAC para namespaces específicos em meu cluster?**

Se você usa [namespaces do Kubernetes para particionar seu cluster e fornecer isolamento para cargas de trabalho](cs_secure.html#container), deve-se designar acesso de usuário a namespaces específicos. Quando você designa a um usuário as funções **Operador** ou **Administrador** da plataforma IAM, as funções de cluster predefinidas `admin` e `cluster-admin` correspondentes são aplicadas automaticamente ao cluster inteiro. No entanto, quando você designa a um usuário as funções **Visualizador** ou **Editor** da plataforma IAM, as funções de cluster predefinidas `view` e `edit` correspondentes são aplicadas automaticamente somente no namespace padrão. Para cumprir o mesmo nível de acesso de usuário em outros namespaces, é possível [copiar as ligações de função](#rbac_copy) para estas funções de cluster, `ibm-view` e `ibm-edit`, para outros namespaces.

**Posso criar funções customizadas ou funções de cluster?**

As funções de cluster `view`, `edit`, `admin` e `cluster-admin` são funções predefinidas que são criadas automaticamente quando você designa a um usuário a função da plataforma IAM correspondente. Para conceder outras permissões do Kubernetes, é possível [criar permissões customizadas de RBAC](#rbac).

**Quando eu preciso usar ligações de função de cluster e ligações de função que não estão vinculadas às permissões do IAM que eu configuro?**

Você pode desejar autorizar quem pode criar e atualizar os pods em seu cluster. Com [políticas de segurança de pod](https://console.bluemix.net/docs/containers/cs_psp.html#psp), é possível usar ligações de função de cluster existentes fornecidas com seu cluster ou criar suas próprias.

Você também pode desejar integrar complementos a seu cluster. Por exemplo, ao [configurar o Helm em seu cluster](cs_integrations.html#helm), deve-se criar uma conta de serviço para o Tiller no namespace `kube-system` e uma ligação de função de cluster RBAC do Kubernetes para o pod `tiller-deploy`.

### Copiando uma ligação de função RBAC para outro namespace
{: #rbac_copy}

Algumas funções e funções de cluster são aplicadas somente a um namespace. Por exemplo, as funções de cluster predefinidas `view` e `edit` são aplicadas automaticamente somente no namespace `default`. Para cumprir o mesmo nível de acesso de usuário em outros namespaces, é possível copiar as ligações de função para essas funções ou funções de cluster para outros namespaces.
{: shortdesc}

Por exemplo, digamos que você designe ao usuário "john@email.com" a função de gerenciamento **Editor** da plataforma IAM. A função de cluster RBAC `edit` predefinida é criada automaticamente em seu cluster e a ligação de função `ibm-edit` aplica as permissões no namespace `default`. Você deseja que "john@email.com" também tenha acesso de Editor em seu namespace de desenvolvimento, portanto, copia a ligação de função `ibm-edit` de `default` para `development`. **Nota**: deve-se copiar a ligação de função toda vez que um usuário é incluído nas funções `view` ou `edit`.

1. Copie a ligação de função de `default` para outro namespace.
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    Por exemplo, para copiar a ligação de função `ibm-edit` para o namespace `testns`:
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. Verifique se a ligação de função `ibm-edit` é copiada.
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### Criando permissões customizadas de RBAC para usuários, grupos ou contas de serviço
{: #rbac}

As funções de cluster `view`, `edit`, `admin` e `cluster-admin` são criadas automaticamente quando você designa a função de gerenciamento da plataforma IAM correspondente. Você precisa que suas políticas de acesso do cluster sejam mais granulares do que essas permissões predefinidas permitem? Sem problemas! É possível criar funções RBAC customizadas e funções de cluster.
{: shortdesc}

É possível designar funções RBAC customizadas e funções de cluster para usuários individuais, grupos de usuários (em clusters que executam o Kubernetes v1.11 ou mais recente) ou contas de serviço. Quando uma ligação é criada para um grupo, ela afeta qualquer usuário que é incluído ou removido desse grupo. Quando você inclui usuários em um grupo, eles obtêm os direitos de acesso do grupo, além de quaisquer direitos de acesso individuais concedidos a eles. Se ele for removido, seu acesso será revogado. **Nota**: não é possível incluir contas de serviço nos grupos de acesso.

Se você desejar designar acesso a um processo que é executado em pods, como uma cadeia de ferramentas de entrega contínua, será possível usar [ServiceAccounts do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). Para seguir um tutorial que demonstra como configurar as contas de serviço para Travis e Jenkins e para designar funções RBAC customizadas aos ServiceAccounts, veja a postagem do blog [ServiceAccounts do Kubernetes para uso em sistemas automatizados ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982).

**Nota**: para evitar mudanças radicais, não mude as funções de cluster predefinidas `view`, `edit`, `admin` e `cluster-admin`.

**Eu crio uma função ou uma função de cluster? Eu aplico isso a uma ligação de função ou a uma ligação de função de cluster?**

* Para permitir que um usuário, um grupo de acesso ou uma conta de serviço acesse um recurso dentro de um namespace específico, escolha uma das combinações a seguir:
  * Criar uma função e aplicá-la a uma ligação de função. Essa opção é útil para controlar o acesso a um recurso exclusivo que existe somente em um namespace, como uma implementação de app.
  * Criar uma função de cluster e aplicá-la a uma ligação de função. Essa opção é útil para controlar o acesso a recursos gerais em um namespace, como os pods.
* Para permitir que um usuário ou um grupo de acesso acesse recursos em todo o cluster ou recursos em todos os namespaces, crie uma função de cluster e aplique-a a uma ligação de função de cluster. Essa opção é útil para controlar o acesso a recursos que não estão com escopo definido para namespace (como nós do trabalhador) ou recursos em todos os namespaces em seu cluster (como os pods em cada namespace).

Antes de iniciar:

- Destine a [CLI do Kubernetes](cs_cli_install.html#cs_cli_configure) para seu cluster.
- Para designar o acesso para usuários individuais ou para usuários em um grupo de acesso, assegure-se de que o usuário ou o grupo tenha sido designado a pelo menos uma [função da plataforma IAM](#platform) no nível de serviço do {{site.data.keyword.containerlong_notm}}.

Para criar permissões customizadas de RBAC:

1. Crie a função ou a função de cluster com o acesso que você deseja designar.

    1. Crie um arquivo `.yaml` para definir a função ou a função de cluster.

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
        <caption>Entendendo os componentes do YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Idea icon"/>  entendendo os componentes do YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Use `Role` para conceder acesso a recursos dentro de um namespace específico. Use `ClusterRole` para conceder acesso a recursos em todo o cluster (como nós do trabalhador) ou a recursos com escopo definido por namespace (como os pods em todos os namespaces).</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Para clusters que executam o Kubernetes 1.8 ou mais recente, use `rbac.authorization.k8s.io/v1`. </li><li>Para versões anteriores, use `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code> metadata.namespace </code></td>
              <td>Somente para o tipo `Role`: especifique o namespace do Kubernetes para o qual o acesso é concedido.</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Nomeie a função ou função de cluster.</td>
            </tr>
            <tr>
              <td><code> rules.apiGroups </code></td>
              <td>Especifique os [grupos de APIs ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) do Kubernetes com os quais você deseja que os usuários possam interagir, como `"apps"`, `"batch"` ou `"extensions"`. Para acesso ao grupo principal de APIs no caminho de REST `api/v1`, deixe o grupo em branco: `[""]`.</td>
            </tr>
            <tr>
              <td><code> rules.resources </code></td>
              <td>Especifique os [tipos de recurso ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) do Kubernetes para os quais você deseja conceder acesso, como `"daemonsets"`, `"deployments"`, `"events"` ou `"ingresses"`. Se você especificar `"nodes"`, o tipo deverá ser `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code> rules.verbs </code></td>
              <td>Especifique os tipos de [ações ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/) que você deseja que os usuários possam executar, como `"get"`, `"list"`, `"describe"`, `"create"` ou `"delete"`.</td>
            </tr>
          </tbody>
        </table>

    2. Crie a função ou a função de cluster em seu cluster.

        ```
        kubectl aplicar -f my_role.yaml
        ```
        {: pre}

    3. Verifique se a função ou a função de cluster foi criada.
      * Função:
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * Função de cluster:
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. Ligue usuários à função ou função de cluster.

    1. Crie um arquivo `.yaml` para ligar os usuários à sua função ou função de cluster. Anote a URL exclusiva a ser usada para o nome de cada assunto.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/IAM#user1@example.com
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
        <caption>Entendendo os componentes do YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Idea icon"/>  entendendo os componentes do YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>Especifique `RoleBinding` para um `Role` ou `ClusterRole` específico do namespace.</li><li>Especifique  ` ClusterRoleBinding `  para um cluster  ` ClusterRole ` em todo o cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Para clusters que executam o Kubernetes 1.8 ou mais recente, use `rbac.authorization.k8s.io/v1`. </li><li>Para versões anteriores, use `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code> metadata.namespace </code></td>
              <td><ul><li>Para o tipo `RoleBinding`: especifique o namespace do Kubernetes para o qual o acesso é concedido.</li><li>Para o tipo `ClusterRoleBinding`: não use o campo `namespace`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>Nomeie a ligação de função ou a ligação de função de cluster.</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>Especifique o tipo como um dos seguintes:
              <ul><li>`User`: ligue a função RBAC ou a função de cluster a um usuário individual em sua conta.</li>
              <li>`Group`: para clusters que executam o Kubernetes 1.11 ou mais recente, ligue a função RBAC ou a função de cluster a um [grupo de acesso do IAM](/docs/iam/groups.html#groups) em sua conta.</li>
              <li>`ServiceAccount`: ligue a função RBAC ou a função de cluster a uma conta de serviço em um namespace em seu cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code> subjects.name </code></td>
              <td><ul><li>Para `User`: anexe o endereço de e-mail do usuário individual a uma das URLs a seguir.<ul><li>Para clusters que executam o Kubernetes 1.11 ou mais recente: <code>https://iam.ng.bluemix.net/IAM#user_email</code></li><li>Para clusters que executam o Kubernetes 1.10 ou anterior: <code>https://iam.ng.bluemix.net/kubernetes#user_email</code></li></ul></li>
              <li>Para `Group`: para clusters que executam o Kubernetes 1.11 ou mais recente, especifique o nome do [grupo do IAM ](/docs/iam/groups.html#groups) em sua conta.</li>
              <li>Para `ServiceAccount`: especifique o nome da conta do serviço.</li></ul></td>
            </tr>
            <tr>
              <td><code> subjects.apiGroup </code></td>
              <td><ul><li>Para  ` Usuário `  ou  ` Grupo `: use  ` rbac.authorization.k8s.io `.</li>
              <li>Para  ` ServiceAccount `: não inclua esse campo.</li></ul></td>
            </tr>
            <tr>
              <td><code> subjects.namespace </code></td>
              <td>Somente para `ServiceAccount`: especifique o nome do namespace do Kubernetes no qual a conta do serviço é implementada.</td>
            </tr>
            <tr>
              <td><code> roleRef.kind </code></td>
              <td>Insira o mesmo valor que o `kind` no arquivo `.yaml` de função: `Role` ou `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code> roleRef.name </code></td>
              <td>Insira o nome do arquivo `.yaml` de função.</td>
            </tr>
            <tr>
              <td><code> roleRef.apiGroup </code></td>
              <td>Use `rbac.authorization.k8s.io`.</td>
            </tr>
          </tbody>
        </table>

    2. Crie a ligação de função ou o recurso de ligação de função de cluster em seu cluster.

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  Verifique se a ligação foi criada.

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

Agora que você criou e ligou uma função RBAC ou uma função de cluster customizada do Kubernetes, acompanhe os usuários. Peça-lhes para testar uma ação que eles tenham permissão para concluir devido à função, como excluir um pod.

<br />




## Customizando permissões de infraestrutura
{: #infra_access}

Quando você designa a função de infraestrutura **Superusuário** ao administrador que configura a chave API ou cujas credenciais de infraestrutura estão configuradas, outros usuários dentro da conta compartilham a chave API ou credenciais para executar ações de infraestrutura. É possível, então, controlar quais ações de infraestrutura os usuários podem executar, designando a [função de plataforma IAM](#platform) apropriada. Não é necessário editar as permissões de infraestrutura do IBM Cloud (SoftLayer) do usuário.
{: shortdesc}

Por motivos de conformidade, segurança ou faturamento, talvez você não queira fornecer a função de infraestrutura **Superusuário** para o usuário que configura a chave API ou cujas credenciais são configuradas com o comando `ibmcloud ks credentials-set`. No entanto, se esse usuário não tiver a função **Superusuário**, as ações relacionadas à infraestrutura, como a criação de um cluster ou o recarregamento de um nó do trabalhador, poderão falhar. Em vez de usar as funções da plataforma IAM para controlar o acesso de infraestrutura dos usuários, deve-se configurar permissões específicas de infraestrutura do IBM Cloud (SoftLayer) para os usuários.

Se você tiver clusters de múltiplas zonas, o proprietário da conta de infraestrutura do IBM Cloud (SoftLayer) precisará ativar o VLAN Spanning para que os nós em diferentes zonas possam se comunicar dentro do cluster. O proprietário da conta também pode designar a um usuário a permissão **Rede > Gerenciar VLAN Spanning** para que o usuário possa ativar o VLAN Spanning. Para verificar se o VLAN Spanning já está ativado, use o [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

Antes de iniciar, certifique-se de que você seja o proprietário da conta ou tenha **Superusuário** e todo o acesso ao dispositivo. Não é possível conceder a um usuário acesso que você não tem.

1. Efetue login na [GUI do IBM Cloud](https://console.bluemix.net/) e navegue para **Gerenciar > Conta > Usuários**.

2. Clique no nome do usuário para o qual você deseja configurar permissões.

3. Clique em **Designar acesso** e clique em **Designar acesso à sua conta do SoftLayer**.

4. Clique na guia **Permissões do portal** para customizar o acesso do usuário. As permissões que os usuários precisam dependem de quais recursos de infraestrutura eles precisam usar. Você tem duas opções para designar acesso:
    * Use a lista suspensa **Permissões rápidas** para designar uma das funções predefinidas a seguir. Depois de selecionar uma função, clique em **Configurar permissões**.
        * **Usuário somente de visualização** fornece as permissões de usuário para visualizar somente detalhes da infraestrutura.
        * **Usuário básico** fornece ao usuário algumas, mas não todas, permissões de infraestrutura.
        * **Superusuário** fornece ao usuário todas as permissões de infraestrutura.
    * Selecione permissões individuais em cada guia. Para revisar permissões que são necessárias para executar tarefas comuns no {{site.data.keyword.containerlong_notm}}, veja [Permissões de acesso de usuário](cs_access_reference.html#infra).

5.  Para salvar as suas mudanças, clique em **Editar permissões do portal**.

6.  Na guia **Acesso ao dispositivo**, selecione os dispositivos aos quais conceder acesso.

    * Na lista suspensa **Tipo de dispositivo**, é possível conceder acesso a **Todos os dispositivos** para que os usuários possam trabalhar com os tipos de máquinas virtual e física (hardware bare metal) para nós do trabalhador.
    * Para permitir que os usuários acessem novos dispositivos que são criados, selecione **Conceder acesso automaticamente quando novos dispositivos forem incluídos**.
    * Na tabela de dispositivos, certifique-se de que os dispositivos apropriados estejam selecionados.

7. Para salvar suas mudanças, clique em **Atualizar acesso ao dispositivo**.

Reduzindo permissões? A ação pode levar alguns minutos para ser concluída.
{: tip}

<br />



