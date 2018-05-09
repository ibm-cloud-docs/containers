---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Introdução aos clusters no {{site.data.keyword.Bluemix_dedicated_notm}}
{: #dedicated}

Se você tem uma conta do {{site.data.keyword.Bluemix_dedicated}} para usar o {{site.data.keyword.containerlong}}, é possível implementar clusters do Kubernetes em um ambiente de nuvem dedicada (`https://<my-dedicated-cloud-instance>.bluemix.net`) e conectar-se aos serviços pré-selecionados do {{site.data.keyword.Bluemix}} que também estão em execução aí.
{:shortdesc}

Se você não tiver uma conta do {{site.data.keyword.Bluemix_dedicated_notm}}, será possível [iniciar com {{site.data.keyword.containershort_notm}}](container_index.html#container_index) em uma conta pública do {{site.data.keyword.Bluemix_notm}}.

## Sobre o ambiente de nuvem dedicada
{: #dedicated_environment}

Com uma conta do {{site.data.keyword.Bluemix_dedicated_notm}}, os recursos físicos disponíveis são dedicados somente ao seu cluster e não são compartilhados com clusters de outros clientes da {{site.data.keyword.IBM_notm}}. Você pode escolher configurar um ambiente {{site.data.keyword.Bluemix_dedicated_notm}} quando deseja isolamento para seu cluster e também requer esse isolamento para os outros serviços do {{site.data.keyword.Bluemix_notm}} que são usados. Se você não tem uma conta dedicada, é possível [criar clusters com hardware dedicado no {{site.data.keyword.Bluemix_notm}} público](cs_clusters.html#clusters_ui).

Com o {{site.data.keyword.Bluemix_dedicated_notm}}, é possível criar clusters usando o catálogo no console dedicado ou usando a CLI do {{site.data.keyword.containershort_notm}}. Quando você usa o console dedicado, você efetua login nas contas dedicadas e públicas simultaneamente usando seu IBMid. Esse login duplo permite acessar seus clusters públicos usando seu console dedicado. Quando você usa a CLI, você efetua login usando seu terminal dedicado (`api.<my-dedicated-cloud-instance>.bluemix.net.`) e destine o terminal da API do {{site.data.keyword.containershort_notm}} da região pública que está associada ao ambiente dedicado.

As diferenças mais significativas entre o {{site.data.keyword.Bluemix_notm}} público e dedicado são as seguintes.

*   No {{site.data.keyword.Bluemix_dedicated_notm}}, o {{site.data.keyword.IBM_notm}} possui e gerencia a conta de infraestrutura do IBM Cloud (SoftLayer) nos quais os nós do trabalhador, VLANs e sub-redes são implementados. No {{site.data.keyword.Bluemix_notm}} público, você possui a conta de infraestrutura do IBM Cloud (SoftLayer).
*   No {{site.data.keyword.Bluemix_dedicated_notm}}, as especificações para as VLANs e sub-redes na conta de infraestrutura do IBM Cloud (SoftLayer) gerenciada pelo {{site.data.keyword.IBM_notm}} são determinadas quando o ambiente Dedicado é ativado. No {{site.data.keyword.Bluemix_notm}} público, as especificações para as VLANs e sub-redes são determinadas quando o cluster é criado.

### Diferenças no gerenciamento de cluster entre os ambientes de nuvem
{: #dedicated_env_differences}

|Áreas|{{site.data.keyword.Bluemix_notm}} público|{{site.data.keyword.Bluemix_dedicated_notm}}|
|--|--------------|--------------------------------|
|Criação do cluster|Crie um cluster grátis ou especifique os detalhes a seguir para um cluster padrão:<ul><li>Tipo de cluster</li><li>Nome</li><li>Localização</li><li>Machine type</li><li>Número de nós do trabalhador</li><li>VLAN pública</li><li>VLAN privada</li><li>Hardware</li></ul>|Especifique os detalhes a seguir para um cluster padrão:<ul><li>Nome</li><li>Versão do Kubernetes</li><li>Machine type</li><li>Número de nós do trabalhador</li></ul><p>**Nota:** as configurações de VLANs e de Hardware são predefinidas durante a criação do ambiente do {{site.data.keyword.Bluemix_notm}}.</p>|
|Hardware de cluster e propriedade|Em clusters padrão, o hardware pode ser compartilhado por outros clientes {{site.data.keyword.IBM_notm}} ou dedicado somente a você. As VLANs públicas e privadas são pertencentes e gerenciadas por você em sua conta de infraestrutura do IBM Cloud (SoftLayer).|Em clusters no {{site.data.keyword.Bluemix_dedicated_notm}}, o hardware é sempre dedicado. As VLANs públicas e privadas pertencem e são gerenciadas pela IBM para você. O local é predefinido para o ambiente do {{site.data.keyword.Bluemix_notm}}.|
|Balanceador de carga e rede de Ingresso|Durante o fornecimento de clusters padrão, as ações a seguir ocorrem automaticamente.<ul><li>Uma sub-rede pública móvel e uma sub-rede privada móvel são ligadas ao seu cluster e designadas à sua conta do IBM Cloud infrastructure (SoftLayer).</li><li>Um endereço IP público portátil é usado para um balanceador de carga de aplicativos altamente disponível e uma rota pública exclusiva é atribuída no formato &lt;cluster_name&gt;.containers.mybluemix.net. É possível usar essa rota para expor múltiplos apps ao público. Um endereço IP privado móvel será usado para um balanceador de carga de aplicativo privado.</li><li>Quatro endereços IP públicos móveis e quatro endereços IP privados móveis são designados ao cluster e podem ser usados para expor apps por meio de serviços do balanceador de carga. Sub-redes adicionais podem ser solicitadas por meio de sua conta de infraestrutura do IBM Cloud (SoftLayer).</li></ul>|Quando você cria sua conta dedicada, você toma uma decisão de conectividade sobre como deseja expor e acessar seus serviços de cluster. Se você quer usar seus próprios intervalos de IP corporativos (IPs gerenciados pelo usuário), deve-se fornecê-los quando você [configura um ambiente de {{site.data.keyword.Bluemix_dedicated_notm}}](/docs/dedicated/index.html#setupdedicated). <ul><li>Por padrão, nenhuma sub-rede pública é ligada aos clusters que você cria em sua conta dedicada. Em vez disso, você tem a flexibilidade de escolher o modelo de conectividade que melhor combina com sua empresa.</li><li>Depois de criar o cluster, você escolhe o tipo de sub-rede que você deseja ligar e usar com seu cluster para a conectividade do balanceador de carga ou do Ingress.<ul><li>Para sub-redes móveis públicas ou privadas, é possível [incluir sub-redes nos clusters](cs_subnets.html#subnets)</li><li>Para endereços IP gerenciados pelo usuário que você forneceu à IBM na migração do dedicado, é possível [incluir sub-redes gerenciadas por usuário nos clusters](#dedicated_byoip_subnets).</li></ul></li><li>Depois de ligar uma sub-rede a seu cluster, o balanceador de carga do aplicativo de Ingresso é criado. Uma rota pública do Ingress será criada somente se você usar uma sub-rede pública móvel.</li></ul>|
|Rede de NodePort|Exponha uma porta pública em seu nó do trabalhador e use o endereço IP público do nó do trabalhador
para acessar publicamente seu serviço no cluster.|Todos os endereços IP públicos dos nós do trabalhador são bloqueados por um firewall. No entanto, para serviços do {{site.data.keyword.Bluemix_notm}} incluídos no cluster, a porta de nó pode ser acessada por meio de um endereço IP público ou de um endereço IP privado.|
|Armazenamento persistente|Use o [fornecimento
dinâmico](cs_storage.html#create) ou o [fornecimento
estático](cs_storage.html#existing) de volumes.|Use [fornecimento dinâmico](cs_storage.html#create) de volumes. [Abra um chamado de suporte](/docs/get-support/howtogetsupport.html#getting-customer-support) para solicitar um backup para seus volumes, solicitar uma restauração de seus volumes e executar outras funções de armazenamento.</li></ul>|
|URL do registro de imagem no {{site.data.keyword.registryshort_notm}}|<ul><li>Sul e Leste dos EUA: <code>registry.ng bluemix.net</code></li><li>Sul do Reino Unido: <code>registry.eu-gb.bluemix.net</code></li><li>UE Central (Frankfurt): <code>registry.eu-de.bluemix.net</code></li><li>Austrália (Sydney): <code>registry.au-syd.bluemix.net</code></li></ul>|<ul><li>Para novos namespaces, use os mesmos registros baseados em região que são definidos para o {{site.data.keyword.Bluemix_notm}} público.</li><li>Para namespaces que foram configurados para contêineres únicos e escaláveis no {{site.data.keyword.Bluemix_dedicated_notm}}, use <code>registro.&lt;dedicated_domain&gt;</code></li></ul>|
|Acessando o registro|Veja as opções em [Usando registros de imagem privada e pública com o {{site.data.keyword.containershort_notm}}](cs_images.html).|<ul><li>Para novos namespaces, veja as opções em [Usando registros de imagem privada e pública com o {{site.data.keyword.containershort_notm}}](cs_images.html).</li><li>Para namespaces que tenham sido configurados para grupos únicos e escaláveis, [use um token e crie um segredo do
Kubernetes](cs_dedicated_tokens.html#cs_dedicated_tokens) para autenticação.</li></ul>|
{: caption="Diferenças de recursos entre o {{site.data.keyword.Bluemix_notm}} público e o {{site.data.keyword.Bluemix_dedicated_notm}}" caption-side="top"}

<br />


### Arquitetura de serviço
{: #dedicated_ov_architecture}

Cada nó do trabalhador é configurado com um mecanismo de Docker gerenciado pelo {{site.data.keyword.IBM_notm}}, recursos de cálculo separados, rede e serviço de volume.
{:shortdesc}

Recursos de segurança integrados fornecem isolamento, capacidades de gerenciamento de recurso e conformidade de segurança do nó do trabalhador. O nó do trabalhador comunica-se com o mestre usando certificados TLS seguros e conexão openVPN.


*Arquitetura e rede do Kubernetes no {{site.data.keyword.Bluemix_dedicated_notm}}*

![{{site.data.keyword.containershort_notm}} Arquitetura do Kubernetes no {{site.data.keyword.Bluemix_dedicated_notm}}](images/cs_dedicated_arch.png)

<br />


## Configurando o {{site.data.keyword.containershort_notm}} no dedicado
{: #dedicated_setup}

Cada ambiente do {{site.data.keyword.Bluemix_dedicated_notm}} tem uma conta corporativa pública, de propriedade do cliente, no {{site.data.keyword.Bluemix_notm}}. Para que os usuários no ambiente Dedicado criem clusters, o administrador deve incluir os usuários em uma conta corporativa pública.
{:shortdesc}

Antes de iniciar:
  * [Configure um ambiente do {{site.data.keyword.Bluemix_dedicated_notm}}](/docs/dedicated/index.html#setupdedicated).
  * Caso o seu sistema local ou sua rede corporativa controle os terminais de Internet pública usando proxies ou firewalls, deve-se [abrir portas e endereços IP requeridos em seu firewall](cs_firewall.html#firewall).
  * [Faça download do Cloud Foundry CLI ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/cloudfoundry/cli/releases) e [inclua o plug-in IBM Cloud Admin CLI](/docs/cli/plugins/bluemix_admin/index.html#adding-the-ibm-cloud-admin-cli-plug-in).

Para permitir que os usuários do {{site.data.keyword.Bluemix_dedicated_notm}} acessem clusters:

1.  O proprietário de sua conta pública do {{site.data.keyword.Bluemix_notm}} deve gerar uma chave API.
    1.  Efetue login no endpoint para a sua instância do {{site.data.keyword.Bluemix_dedicated_notm}}. Insira as credenciais do {{site.data.keyword.Bluemix_notm}} para o proprietário da conta pública e selecione a conta quando solicitado.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Nota:** se você tiver um ID federado, usará `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem o `--sso` e é bem-sucedido com a opção `--sso`.

    2.  Gere uma chave API para convidar usuários para a conta pública. Anote o valor da chave API, pois o administrador de conta dedicada o usará na próxima etapa.

        ```
        bx iam api-key-create <key_name> -d "Key to invite users to <dedicated_account_name>"
        ```
        {: pre}

    3.  Anote o GUID da organização de conta pública para a qual você deseja convidar usuários, pois o administrador de conta dedicada o usará na próxima etapa.

        ```
        bx account orgs
        ```
        {: pre}

2.  O proprietário de sua conta do {{site.data.keyword.Bluemix_dedicated_notm}} pode convidar um único usuário ou vários para sua conta pública.
    1.  Efetue login no endpoint para a sua instância do {{site.data.keyword.Bluemix_dedicated_notm}}. Insira as credenciais do {{site.data.keyword.Bluemix_notm}} para o proprietário da conta dedicada e selecione a conta quando solicitado.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Nota:** se você tiver um ID federado, usará `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem o `--sso` e é bem-sucedido com a opção `--sso`.

    2.  Convide os usuários para a conta pública.
        * Para convidar um único usuário:

            ```
            bx cf bluemix-admin invite-users-to-public -userid=<user_email> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```
            {: pre}

            Substitua <em>&lt;user_IBMid&gt;</em> pelo e-mail do usuário que você deseja convidar, <em>&lt;public_api_key&gt;</em> pela chave de API gerada na etapa anterior e <em>&lt;public_org_id&gt;</em> pelo GUID da organização da conta pública. Consulte [Convidando um usuário do IBM Cloud Dedicated](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public) para obter mais informações sobre esse comando.

        * Para convidar todos os usuários atualmente em uma organização de conta dedicada:

            ```
            bx cf bluemix-admin invite-users-to-public -organization=<dedicated_org_id> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```

            Substitua <em>&lt;dedicated_org_id&gt;</em> pelo ID da organização da conta dedicada, <em>&lt;public_api_key&gt;</em> pela chave API gerada na etapa anterior e <em>&lt;public_org_id&gt;</em> pela GUID da organização de conta pública. Consulte [Convidando um usuário do IBM Cloud Dedicated](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public) para obter mais informações sobre esse comando.

    3.  Se um IBMid existe para um usuário, o usuário é automaticamente incluído na organização especificada na conta pública. Se um IBMid ainda não existe para um usuário, então um convite é enviado para o endereço de e-mail do usuário. Quando o usuário aceita o convite, um IBMid é criado para o usuário e o usuário é incluído na organização especificada na conta pública.

    4.  Verifique se os usuários foram incluídos na conta.

        ```
        bx cf bluemix-admin invite-users-status -apikey=<public_api_key>
        ```
        {: pre}

        Os usuários convidados que têm um IBMid existente terão um status de `ACTIVE`. Os usuários convidados que não tinham um IBMid existente terão um status de `PENDING` ou `ACTIVE`, dependendo se eles já aceitaram o convite para a conta ou não.

3.  Se qualquer usuário precisa de privilégios de criação de cluster, deve-se conceder a função de Administrador para esse usuário.

    1.  Na barra de menus no console público, clique em **Gerenciar > Segurança > Identidade e acesso** e, em seguida, clique em **Usuários**.

    2.  Na linha para o usuário que você deseja designar acesso, selecione o menu **Ações** e, em seguida, clique em **Designar acesso**.

    3.  Selecione **Designar acesso a recursos**.

    4.  Na lista **Serviços**, selecione **IBM Cloud Container Service**.

    5.  Na lista **Região**, selecione **Todas as regiões atuais** ou uma região específica, se solicitado.

    6. Em **Selecionar funções**, selecione Administrador.

    7. Clique em **Designar**.

4.  Os usuários podem agora efetuar login no terminal de conta dedicada para iniciar a criação de clusters.

    1.  Efetue login no endpoint para a sua instância do {{site.data.keyword.Bluemix_dedicated_notm}}. Insira seu IBMid quando solicitado.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Nota:** se você tiver um ID federado, usará `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem o `--sso` e é bem-sucedido com a opção `--sso`.

    2.  Se você estiver efetuando login pela primeira vez, forneça seu ID do usuário dedicado e senha quando solicitado. Isso autentica a conta dedicada e vincula as contas dedicadas e públicas. Toda vez que você efetuar o login após essa primeira vez, você usará somente o seu IBMid para fazer login. Para obter mais informações, veja [Conectando um ID dedicado ao seu IBMid público](/docs/cli/connect_dedicated_id.html#connect_dedicated_id).

        **Observação**: deve-se efetuar login em sua conta dedicada e em sua conta pública para criar clusters. Se você quiser efetuar login somente na sua conta dedicada, use a sinalização `--no-iam` ao efetuar login no terminal dedicado.

    3.  Para criar ou acessar clusters no ambiente dedicado, deve-se configurar a região associada a esse ambiente.

        ```
        bx cs region-set
        ```
        {: pre}

5.  Se desejar desvincular suas contas, será possível desconectar seu IBMid do seu ID do usuário dedicado. Para obter mais informações, veja [Desconectar o seu ID dedicado do IBMid público](/docs/cli/connect_dedicated_id.html#disconnect-your-dedicated-id-from-the-public-ibmid).

    ```
    bx iam dedicated-id-disconnect
    ```
    {: pre}

<br />


## Criando clusters
{: #dedicated_administering}

Projete sua configuração de cluster do {{site.data.keyword.Bluemix_dedicated_notm}} para máxima disponibilidade e capacidade.
{:shortdesc}

### Criando clusters com a GUI
{: #dedicated_creating_ui}

1.  Abra o console dedicado: `https://<my-dedicated-cloud-instance>.bluemix.net`.
2. Marque a caixa de seleção **Efetuar login também no {{site.data.keyword.Bluemix_notm}} Público** e clique em **Efetuar login**.
3. Siga os prompts para efetuar login com seu IBMid. Se esta for a primeira vez que você efetua login em sua conta dedicada, siga os prompts para efetuar login no {{site.data.keyword.Bluemix_dedicated_notm}}.
4.  No catálogo, selecione **Contêineres** e clique em **Cluster do Kubernetes**.
5.  Insira um **Nome do cluster**. O nome deve iniciar com uma letra, pode conter letras, números e - e deve ter 35 caracteres ou menos. Observe que o subdomínio do Ingresso designado à {{site.data.keyword.IBM_notm}} é derivado do nome do cluster. O nome do cluster e o subdomínio do Ingresso juntos formam o nome completo do domínio, que deve ser exclusivo dentro de uma região e ter 63 caracteres ou menos. Para atender a esses requisitos, o nome do cluster pode ser truncado ou o subdomínio pode ser designado a valores de caractere aleatórios.
6.  Selecione um **Tipo de máquina**. O tipo de máquina define a quantia de CPU e de memória virtual que é configurada em cada nó do trabalhador. Essa CPU e memória virtual está disponível para todos os contêineres que você implementa em seus nós.
    -   O tipo de máquina micro indica a menor opção.
    -   Um tipo de máquina balanceada tem uma quantia igual de memória designada a cada CPU, que otimiza o desempenho.
7.  Escolha o **Número de nós do trabalhador** que você precisa. Selecione `3` para assegurar a alta disponibilidade de seu cluster.
8.  Clique em **Criar Cluster**. Os detalhes para o cluster são abertos, mas os nós do trabalhador no cluster levam alguns minutos para provisão. Na guia **Nós do trabalhador**, é possível ver o progresso da implementação do nó do trabalhador. Quando os nós do trabalhador estão prontos, o estado muda para **Pronto**.

### Criando clusters com a CLI
{: #dedicated_creating_cli}

1.  Instale a CLI do {{site.data.keyword.Bluemix_notm}} e o plug-in do [{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Efetue login no endpoint para a sua instância do {{site.data.keyword.Bluemix_dedicated_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} e selecione sua conta quando solicitado.

    ```
    bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
    ```
    {: pre}

    **Nota:** se você tiver um ID federado, usará `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem o `--sso` e é bem-sucedido com a opção `--sso`.

3.  Para destinar uma região, execute `bx cs region-set`.

4.  Crie um cluster com o comando `cluster-create`. Ao criar um cluster padrão, o hardware do nó do trabalhador é faturado por horas de uso.

    Exemplo:

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code> cluster-create</code></td>
    <td>O comando para criar um cluster na organização do {{site.data.keyword.Bluemix_notm}}.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>Substitua &lt;location&gt; pelo ID do local do {{site.data.keyword.Bluemix_notm}} que seu ambiente dedicado está configurado para usar.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Se você estiver criando um cluster padrão, escolha um tipo de máquina. O tipo de máquina especifica os recursos de cálculo virtual que estão disponíveis para cada nó do trabalhador. Revise [Comparação de clusters livres e padrão para o {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) para obter mais informações. Para clusters livres, não é necessário definir o tipo de máquina.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Substitua <em>&lt;name&gt;</em> por um nome para seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e - e deve ter 35 caracteres ou menos. Observe que o subdomínio do Ingresso designado à {{site.data.keyword.IBM_notm}} é derivado do nome do cluster. O nome do cluster e o subdomínio do Ingresso juntos formam o nome completo do domínio, que deve ser exclusivo dentro de uma região e ter 63 caracteres ou menos. Para atender a esses requisitos, o nome do cluster pode ser truncado ou o subdomínio pode ser designado a valores de caractere aleatórios.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>O número de nós do trabalhador a serem incluídos no cluster. Se a opção <code>--workers</code> não for especificada, um nó do trabalhador será criado.</td>
    </tr>
    </tbody></table>

5.  Verifique se a criação do cluster foi solicitada.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta.

    Quando o fornecimento do cluster é concluído, o estado do cluster muda para **implementado**.

    ```
    Name         ID                                   State      Created          Workers   Location   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         dal10      1.8.8
    ```
    {: screen}

6.  Verifique o status dos nós do trabalhador.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster.

    ```
    ID Public IP Private IP Machine Type State Status Location Version prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1 169.47.223.113 10.171.42.93 free normal Ready dal10 1.8.8
    ```
    {: screen}

7.  Configure o cluster que você criou como o contexto para essa sessão. Conclua estas etapas de configuração toda vez que você trabalhar com o seu cluster.

    1.  Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração do Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

        Exemplo para OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.
    3.  Verifique se a variável de ambiente `KUBECONFIG` está configurada corretamente.

        Exemplo para OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Saída:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

8.  Acesse seu painel do Kubernetes com a porta padrão 8001.
    1.  Configure o proxy com o número da porta padrão.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Iniciando a entrega em 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra a URL a seguir em um navegador da web para ver o painel do Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

### Usando registros de imagem privada e pública
{: #dedicated_images}

Para novos namespaces, veja as opções em [Usando registros de imagem privada e pública com o {{site.data.keyword.containershort_notm}}](cs_images.html). Para namespaces que tenham sido configurados para grupos únicos e escaláveis, [use um token e crie um segredo do
Kubernetes](cs_dedicated_tokens.html#cs_dedicated_tokens) para autenticação.

### Incluindo sub-redes nos clusters
{: #dedicated_cluster_subnet}

Mude o conjunto de endereços IP públicos móveis disponíveis, incluindo sub-redes em seu cluster. Para obter mais informações, consulte [Incluindo sub-redes nos clusters](cs_subnets.html#subnets). Revise as diferenças a seguir para incluir sub-redes nos clusters dedicados.

#### Incluindo sub-redes gerenciadas pelo usuário e endereços IP adicionais em seus clusters do Kubernetes
{: #dedicated_byoip_subnets}

Forneça mais de suas próprias redes de uma rede no local que você deseja usar para acessar o {{site.data.keyword.containershort_notm}}. É possível incluir endereços IP privados dessas sub-redes nos serviços Ingress e de balanceamento de carga em seu cluster do Kubernetes. Sub-redes gerenciadas pelos usuários são configuradas de uma das duas maneiras, dependendo do formato da sub-rede que você deseja usar.

Requisitos:
- Sub-redes gerenciadas pelo usuário podem ser incluídas em VLANs privadas apenas.
- O limite de comprimento de prefixo de sub-rede é /24 para /30. Por exemplo, `203.0.113.0/24` especifica 253 endereços IP privados utilizáveis, enquanto `203.0.113.0/30` especifica 1 endereço IP privado utilizável.
- O primeiro endereço IP na sub-rede deve ser usado como o gateway para a sub-rede.

Antes de iniciar: configure o roteamento de tráfego de rede dentro e fora de sua rede corporativa para a rede do {{site.data.keyword.Bluemix_dedicated_notm}} que utilizará a sub-rede gerenciada pelo usuário.

1. Para usar sua própria sub-rede, [abra um chamado de suporte](/docs/get-support/howtogetsupport.html#getting-customer-support) e forneça a lista de sub-CIDRs que você deseja usar.
    **Observação**: a forma com que o ALB e os balanceadores de carga são gerenciados para conectividade de conta local e interna difere, dependendo do formato da sub-rede CIDR. Consulte a etapa final para ver as diferenças de configuração.

2. Após a {{site.data.keyword.IBM_notm}} provisionar as sub-redes gerenciadas pelo usuário, torne a sub-rede disponível para seu cluster do Kubernetes.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
    ```
    {: pre}
    Substitua <em>&lt;cluster_name&gt;</em> pelo nome ou o ID do cluster, <em>&lt;subnet_CIDR&gt;</em> por uma das sub-redes CIDRs que você forneceu no chamado de suporte e <em>&lt;private_VLAN&gt;</em> por um ID de VLAN privada disponível. É possível localizar o ID de uma VLAN privada disponível executando `bx cs vlans`.

3. Verifique se as sub-redes foram incluídas em seu cluster. O campo **Gerenciado por usuário** para sub-redes fornecidas pelo usuário é _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Opcional: [Ative o roteamento entre as sub-redes na mesma VLAN](cs_subnets.html#vlan-spanning).

5. Para configurar a conectividade de conta local e interna, escolha entre estas opções:
  - Se você usou um intervalo de endereços IP privados 10.x.x.x para a sub-rede, use os IPs válidos desse intervalo para configurar a conectividade de conta local e interna com o Ingress e um balanceador de carga. Para obter mais informações, consulte [Configurando acesso para um aplicativo](cs_network_planning.html#planning).
  - Se você não usou um intervalo de endereços IP privados 10.x.x.x para a sub-rede, use os IPs válidos desse intervalo para configurar a conectividade local com o Ingress e um balanceador de carga. Para obter mais informações, consulte [Configurando acesso para um aplicativo](cs_network_planning.html#planning). No entanto, deve-se usar uma sub-rede privada móvel de infraestrutura do IBM Cloud (SoftLayer) para configurar a conectividade de conta interna entre o seu cluster e outros serviços baseados no Cloud Foundry. É possível criar uma sub-rede privada móvel com o comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add). Para este cenário, seu cluster tem tanto uma sub-rede gerenciada pelo usuário para conectividade local quanto uma sub-rede privada móvel de infraestrutura do IBM Cloud (SoftLayer) para conectividade de conta interna.

### Outras configurações de cluster
{: #dedicated_other}

Revise as opções a seguir para outras configurações de cluster:
  * [Gerenciando o acesso ao cluster](cs_users.html#managing)
  * [Atualizando o mestre do Kubernetes](cs_cluster_update.html#master)
  * [Atualizando nós do trabalhador](cs_cluster_update.html#worker_node)
  * [Configurando a criação de log de cluster](cs_health.html#logging)
      * **Nota**: a ativação de log não é suportada no terminal Dedicado. Deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e espaço público para ativar o encaminhamento de log.
  * [Configurando o monitoramento de cluster](cs_health.html#monitoring)
      * **Observação**: um cluster `ibm-monitoring` existe dentro de cada conta do {{site.data.keyword.Bluemix_dedicated_notm}}. Esse cluster monitora continuamente o funcionamento do {{site.data.keyword.containerlong_notm}} no ambiente dedicado, verificando a estabilidade e a conectividade do ambiente. Não remova esse cluster do ambiente.
  * [Visualizando recursos de cluster do Kubernetes](cs_integrations.html#weavescope)
  * [Removendo Clusters](cs_clusters.html#remove)

<br />


## Implementando apps em clusters
{: #dedicated_apps}

É possível usar técnicas do Kubernetes para implementar apps em clusters do {{site.data.keyword.Bluemix_dedicated_notm}} e para assegurar que seus apps estejam sempre funcionando.
{:shortdesc}

Para implementar apps em clusters, é possível seguir as instruções para [implementar apps em clusters públicos do {{site.data.keyword.Bluemix_notm}}](cs_app.html#app). Revise as diferenças a seguir para clusters do {{site.data.keyword.Bluemix_dedicated_notm}}.

### Permitindo o acesso público a apps
{: #dedicated_apps_public}

Para ambientes do {{site.data.keyword.Bluemix_dedicated_notm}}, os endereços IP primários públicos são bloqueadas por um firewall. Para tornar um app publicamente disponível, use um [serviço LoadBalancer](#dedicated_apps_public_load_balancer) ou o [Ingress](#dedicated_apps_public_ingress) em vez de um serviço NodePort. Se você requerer acesso a um serviço LoadBalancer ou ao Ingress desses endereços IP públicos móveis, forneça uma lista de desbloqueio de firewall corporativo para a IBM tempo de onboarding do serviço.

#### Configurando o acesso a um app usando o tipo de serviço do balanceador de carga
{: #dedicated_apps_public_load_balancer}

Se você quiser usar endereços IP públicos para o balanceador de carga, assegure-se de que uma lista de desbloqueio firewall corporativo tenha sido fornecido para a IBM ou [abra um chamado de suporte](/docs/get-support/howtogetsupport.html#getting-customer-support) para configurar o desbloqueio de firewall. Depois, siga as etapas em [Configurando o acesso a um app usando o tipo de serviço de balanceador de carga](cs_loadbalancer.html#config).

#### Configurando o acesso público a um app usando o Ingress
{: #dedicated_apps_public_ingress}

Se você quiser usar endereços IP públicos para o balanceador de carga de aplicativo, assegure-se de que uma lista de desbloqueio firewall corporativo foi fornecido para a IBM ou [abra um chamado de suporte](/docs/get-support/howtogetsupport.html#getting-customer-support) para configurar o desbloqueio de firewall. Em seguida, siga as etapas em [Configurando acesso a um app usando Ingresso](cs_ingress.html#configure_alb).

### Criando armazenamento persistente
{: #dedicated_apps_volume_claim}

Para revisar as opções para criar armazenamento persistente, consulte [armazenamento de dados persistentes](cs_storage.html#planning). Para solicitar um backup para seus volumes, uma restauração de seus volumes e outras funções de armazenamento, deve-se [abrir um chamado de suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).
