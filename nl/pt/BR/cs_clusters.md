---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}



# Criando clusters
{: #clusters}

Crie um cluster Kubernetes no {{site.data.keyword.containerlong}}.
{: shortdesc}

Ainda está sendo iniciado? Experimente o [tutorial de criação de um cluster do Kubernetes](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial). Não tem certeza de qual configuração de cluster escolher? Consulte [Planejando a configuração de rede do cluster](/docs/containers?topic=containers-plan_clusters).
{: tip}

Você já criou um cluster antes e está apenas procurando comandos de exemplo rápidos? Tente estes exemplos.
*  ** Cluster grátis **:
   ```
   ibmcloud ks cluster-create --name my_cluster
   ```
   {: pre}
*  ** Cluster padrão, máquina virtual compartilhada **:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  ** Cluster padrão, bare metal **:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **Cluster padrão, máquina virtual com terminais em serviço público e privado em uma conta ativada para VRF**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **Cluster padrão que usa somente VLANs privadas e o terminal em serviço privado**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_VLAN_ID> --private-only
   ```
   {: pre}
*   **Para um cluster multizona, depois de criar o cluster em uma [área metropolitana multizona](/docs/containers?topic=containers-regions-and-zones#zones), [inclua as zonas](/docs/containers?topic=containers-add_workers#add_zone)**:
    ```
    ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
    ```
    {: pre}

<br />



## Preparar para criar clusters no nível da conta
{: #cluster_prepare}

Prepare sua conta do {{site.data.keyword.cloud_notm}} para o {{site.data.keyword.containerlong_notm}}. Essas são preparações que, depois que são feitas pelo administrador de conta, talvez não precisem ser mudadas cada vez que você criar um cluster. No entanto, cada vez que um cluster é criado, você ainda deseja verificar se o estado atual do nível de conta é o que precisa que seja.
{: shortdesc}

1. [Crie ou faça upgrade de sua conta para uma conta faturável ({{site.data.keyword.cloud_notm}} Pré-pago ou Assinatura)](https://cloud.ibm.com/registration/).

2. [Configure uma chave de API do {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-users#api_key) nas regiões em que você desejar criar clusters. Designar a chave API com as permissões apropriadas para criar clusters:
  * A função **Superusuário** ou as [permissões mínimas necessárias](/docs/containers?topic=containers-access_reference#infra) para a infraestrutura clássica.
  * Função de gerenciamento de plataforma **Administrador** para o {{site.data.keyword.containershort_notm}} no nível de conta.
  * Função de gerenciamento da plataforma **Administrador** para o registro do contêiner no nível da conta. Se a sua conta for anterior a 4 de outubro de 2018, será necessário [ativar as políticas do {{site.data.keyword.cloud_notm}} IAM para o {{site.data.keyword.registryshort_notm}}](/docs/services/Registry?topic=registry-user#existing_users). Com as políticas do IAM, é possível controlar o acesso a recursos como namespaces de registro.

  Você é o proprietário da conta? Você já tem as permissões necessárias! Ao criar um cluster, a chave API para essa região e grupo de recursos é configurada com suas credenciais.
  {: tip}

3. Verifique se você tem a função da plataforma **Administrador** para o {{site.data.keyword.containerlong_notm}}. Para permitir que seu cluster faça pull de imagens do registro privado, também será necessária a função da plataforma **Administrador** para o {{site.data.keyword.registrylong_notm}}.
  1. Na barra de menus do [console do {{site.data.keyword.cloud_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/), clique em **Gerenciar > Acesso (IAM)**.
  2. Clique na página **Usuários** e, em seguida, na tabela, selecione você mesmo.
  3. Na guia **Políticas de acesso**, confirme se sua **Função** é **Administrador**. É possível ser o **Administrador** para todos os recursos na conta ou, pelo menos, para o {{site.data.keyword.containershort_notm}}. **Nota**: se você tem a função **Administrador** para o {{site.data.keyword.containershort_notm}} em somente um grupo de recursos ou região em vez da conta inteira, deve-se ter pelo menos a função **Visualizador** no nível de conta para ver as VLANs da conta.
  <p class="tip">Certifique-se de que o administrador da sua conta não designe a você a função da plataforma **Administrador** ao mesmo tempo que uma função de serviço. Deve-se designar funções de plataforma e de serviço separadamente.</p>

4. Se a sua conta usar múltiplos grupos de recursos, descubra a estratégia de sua conta para [gerenciar grupos de recursos](/docs/containers?topic=containers-users#resource_groups).
  * O cluster é criado no grupo de recursos que você destina ao efetuar login no {{site.data.keyword.cloud_notm}}. Se você não destinar um grupo de recursos, o grupo de recursos padrão será automaticamente destinado.
  * Se você desejar criar um cluster em um grupo de recursos diferente do padrão, precisará pelo menos da função **Visualizador** para o grupo de recursos. Se você não tiver nenhuma função para o grupo de recursos, mas ainda for um **Administrador** para o serviço dentro do grupo de recursos, seu cluster será criado no grupo de recursos padrão.
  * Não é possível mudar o grupo de recursos de um cluster. Além disso, se você precisar usar o [comando](/docs/containers-cli-plugin?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_service_bind) `ibmcloud ks cluster-service-bind` para [integrar com um serviço do {{site.data.keyword.cloud_notm}}](/docs/containers?topic=containers-service-binding#bind-services), esse serviço deverá estar no mesmo grupo de recursos que o cluster. Os serviços que não usam grupos de recursos como {{site.data.keyword.registrylong_notm}} ou que não precisam de ligação de serviços como {{site.data.keyword.la_full_notm}} funcionarão mesmo se o cluster estiver em um grupo de recursos diferente.
  * Se você planeja usar o [{{site.data.keyword.monitoringlong_notm}} para métricas](/docs/containers?topic=containers-health#view_metrics), planeje fornecer a seu cluster um nome que seja exclusivo em todos os grupos de recursos e regiões em sua conta para evitar conflitos de nomenclatura de métricas.
  * Os clusters grátis são criados no grupo de recursos `default`.

5. **Clusters padrão**: planeje a [configuração de rede](/docs/containers?topic=containers-plan_clusters) do cluster para que seu cluster atenda às necessidades de suas cargas de trabalho e ambiente. Em seguida, configure a sua rede de infraestrutura do IBM Cloud para permitir a comunicação do trabalhador com o mestre e do usuário com o mestre:
  * Para usar somente o terminal em serviço privado ou os terminais em serviço público e privado (execute cargas de trabalho voltadas à Internet ou amplie seu data center no local):
    1. Ative o [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) em sua conta de infraestrutura do IBM Cloud. Para verificar se um VRF já está ativado, use o comando `ibmcloud account show`.
    2. [Ative sua conta do {{site.data.keyword.cloud_notm}} para usar os terminais em serviço](/docs/resources?topic=resources-private-network-endpoints#getting-started).
    <p class="note">O mestre do Kubernetes será acessível por meio do terminal em serviço privado se usuários de cluster autorizados estiverem em sua rede privada do {{site.data.keyword.cloud_notm}} ou se forem conectados à rede privada por meio de uma [conexão VPN](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) ou do [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link). No entanto, a comunicação com o mestre do Kubernetes por meio do terminal em serviço privado deve passar pelo intervalo de endereços IP <code>166.X.X.X</code>, que não é roteável por meio de uma conexão VPN ou por meio do {{site.data.keyword.cloud_notm}} Direct Link. É possível expor o terminal em serviço privado do mestre para os usuários do cluster usando um balanceador de carga de rede (NLB) privado. O NLB privado expõe o terminal em serviço privado do mestre como um intervalo interno de endereços IP <code>10.X.X.X</code> que os usuários podem acessar com a VPN ou com a conexão do {{site.data.keyword.cloud_notm}} Direct Link. Se você ativar apenas o terminal em serviço privado, será possível usar o painel do Kubernetes ou ativar temporariamente o terminal em serviço público para criar o NLB privado. Para obter mais informações, consulte [Acessando clusters por meio do terminal em serviço privado](/docs/containers?topic=containers-clusters#access_on_prem).</p>

  * Para usar somente o terminal em serviço público (executar cargas de trabalho voltadas para a Internet):
    1. Ative a [Ampliação de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) para sua conta de infraestrutura do IBM Cloud para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](/docs/containers?topic=containers-users#infra_access) **Rede > Gerenciar a rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se a ampliação de VLAN já está ativada, use o [comando](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
  * Para usar um dispositivo de gateway (ampliar seu data center no local):
    1. Ative a [Ampliação de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) para sua conta de infraestrutura do IBM Cloud para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](/docs/containers?topic=containers-users#infra_access) **Rede > Gerenciar a rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se a ampliação de VLAN já está ativada, use o [comando](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
    2. Configure um dispositivo de gateway. Por exemplo, é possível escolher configurar um [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) ou um [Fortigate Security Appliance](/docs/services/vmwaresolutions/services?topic=vmware-solutions-fsa_considerations) para agir como seu firewall para permitir o tráfego necessário e bloquear o tráfego indesejado.
    3. [Abra os endereços IP e portas privados necessários](/docs/containers?topic=containers-firewall#firewall_outbound) para cada região para que o principal e os nós do trabalhador possam se comunicar e para os serviços do {{site.data.keyword.cloud_notm}} que você planeja usar.

<br />


## Preparar-se para criar clusters no nível do cluster
{: #prepare_cluster_level}

Depois de configurar sua conta para criar clusters, prepare a configuração de seu cluster. Essas são preparações que afetam seu cluster cada vez que você cria um cluster.
{: shortdesc}

1. Decida entre um [cluster grátis ou padrão](/docs/containers?topic=containers-cs_ov#cluster_types). É possível criar um cluster grátis para testar alguns dos recursos por 30 dias ou criar clusters padrão totalmente customizáveis com sua opção de isolamento de hardware. Crie um cluster padrão para obter mais benefícios e controle sobre o desempenho do cluster.

2. Para clusters padrão, planeje a configuração do cluster.
  * Decida se deve ser criado um cluster de [zona única](/docs/containers?topic=containers-ha_clusters#single_zone) ou de [múltiplas zonas](/docs/containers?topic=containers-ha_clusters#multizone). Observe que os clusters de várias zonas estão disponíveis somente em locais selecionados.
  * Escolha qual tipo de [hardware e isolamento](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes) você deseja para os nós do trabalhador do cluster, incluindo a decisão entre máquinas virtuais ou bare metal.

3. Para clusters padrão, é possível [estimar o custo](/docs/billing-usage?topic=billing-usage-cost#cost) no console do {{site.data.keyword.cloud_notm}}. Para obter mais informações sobre os encargos que podem não estar incluídos no estimador, consulte [Precificação e faturamento](/docs/containers?topic=containers-faqs#charges).

4. Se criar o cluster em um ambiente por trás de um firewall, como para clusters que ampliam seu data center no local, [permita o tráfego de rede de saída para os IPs públicos e privados](/docs/containers?topic=containers-firewall#firewall_outbound) para os serviços do {{site.data.keyword.cloud_notm}} que você planeja usar.

<br />


## Criando um cluster grátis
{: #clusters_free}

É possível usar o seu cluster grátis para se familiarizar com o funcionamento do {{site.data.keyword.containerlong_notm}}. Com clusters grátis, é possível aprender a terminologia, concluir um tutorial e orientar-se antes de dar o salto para os clusters padrão de nível de produção. Não se preocupe, você ainda obterá um cluster grátis mesmo se tiver uma conta faturável.
{: shortdesc}

Os clusters grátis incluem um nó do trabalhador configurado com dois vCPUs e quatro GB de memória e têm uma duração de 30 dias. Após esse tempo, o cluster expira e o cluster e seus dados são excluídos. Os dados excluídos não são submetidos a backup pelo {{site.data.keyword.cloud_notm}} e não podem ser restaurados. Certifique-se de fazer backup de quaisquer dados importantes.
{: note}

### Criando um cluster grátis no console
{: #clusters_ui_free}

1. No [catálogo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/catalog?category=containers), selecione **{{site.data.keyword.containershort_notm}}** para criar um cluster.
2. Selecione o plano de cluster  ** Grátis ** .
3. Selecione uma geografia no qual implementar seu cluster.
4. Selecione um local de área metropolitana na geografia. Seu cluster é criado em uma zona dentro dessa área metropolitana.
5. Forneça um nome ao seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e hífen (-) e deve ter 35 caracteres ou menos. Use um nome que seja exclusivo entre as regiões.
6. Clique em **Criar cluster**. Por padrão, um conjunto de trabalhadores com um nó do trabalhador é criado. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**. Quando a implementação é feita, é possível ver que seu cluster está pronto na guia **Visão geral**. Observe que, mesmo se o cluster está pronto, algumas partes do cluster que são usadas por outros serviços, como segredos de pull de imagem de registro, podem ainda estar em processo.

  A cada nó do trabalhador é designado um ID do nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o
mestre do Kubernetes gerencie o cluster.
  {: important}
7. Após a criação do cluster, é possível [começar a trabalhar com seu cluster configurando sua sessão da CLI](#access_internet).

### Criando um cluster grátis na CLI
{: #clusters_cli_free}

Antes de iniciar, instale a CLI do {{site.data.keyword.cloud_notm}} e o [plug-in do {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).

1. Efetue login na CLI do {{site.data.keyword.cloud_notm}}.
  1. Efetue login e insira suas credenciais do {{site.data.keyword.cloud_notm}} quando solicitado.
     ```
     ibmcloud login
     ```
     {: pre}

     Se você tiver um ID federado, use `ibmcloud login --sso` para efetuar login na CLI do {{site.data.keyword.cloud_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem o `--sso` e é bem-sucedido com a opção `--sso`.
     {: tip}

  2. Se você tiver várias contas do {{site.data.keyword.cloud_notm}}, selecione a conta na qual deseja criar seu cluster do Kubernetes.

  3. Para criar o cluster grátis em uma região específica, deve-se ter essa região como destino. É possível criar um cluster grátis em `ap-south`, `eu-central`, `uk-south` ou `us-south`. O cluster é criado em uma zona dentro dessa região.
     ```
     ibmcloud ks region-set
     ```
     {: pre}

2. Crie um cluster.
  ```
  ibmcloud ks cluster-create --name my_cluster
  ```
  {: pre}

3. **Clusters grátis somente na área metropolitana de Londres**: atualmente, deve-se ter como destino a API regional da UE Central para trabalhar com o seu cluster.
  ```
  ibmcloud ks init --host https://eu-gb.containers.cloud.ibm.com
  ```
  {: pre}

3. Verifique se a criação do cluster foi solicitada. Pode levar alguns minutos para que a máquina do nó do trabalhador seja pedida.
    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.
    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.13.8      Default
    ```
    {: screen}

4. Verifique o status do nó do trabalhador.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Quando o nó do trabalhador estiver pronto, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster. Observe que mesmo se o cluster estiver pronto, algumas de suas partes usadas por outros serviços, como segredos do Ingress ou segredos de extração de imagem, ainda poderão estar em processo.
    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.13.8      Default
    ```
    {: screen}

    A cada nó do trabalhador é designado um ID do nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o
mestre do Kubernetes gerencie o cluster.
    {: important}

5. Após a criação do cluster, é possível [começar a trabalhar com seu cluster configurando sua sessão da CLI](#access_internet).

<br />


## Criando um cluster padrão
{: #clusters_standard}

Use a CLI do {{site.data.keyword.cloud_notm}} ou o console do {{site.data.keyword.cloud_notm}} para criar um cluster padrão totalmente customizável com sua opção de isolamento de hardware e acesso a recursos, como múltiplos nós do trabalhador para um ambiente altamente disponível.
{: shortdesc}

### Criando um cluster padrão no console
{: #clusters_ui}

1. No [catálogo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/catalog?category=containers), selecione **{{site.data.keyword.containershort_notm}}** para criar um cluster.

2. Selecione um grupo de recursos no qual criar seu cluster.
    * Um cluster pode ser criado em apenas um grupo de recursos e, após sua criação, não é possível mudar seu grupo de recursos.
    * Para criar clusters em um grupo de recursos diferente do padrão, deve-se ter pelo menos a [função **Visualizador**](/docs/containers?topic=containers-users#platform) para o grupo de recursos.

3. Selecione uma geografia no qual implementar seu cluster.

4. Forneça seu cluster um nome exclusivo. O nome deve iniciar com uma letra, pode conter letras, números e hífen (-) e deve ter 35 caracteres ou menos. Use um nome que seja exclusivo entre as regiões. O nome do cluster e a região na qual o cluster está implementado formam o nome completo do domínio para o subdomínio do Ingress. Para assegurar que o subdomínio do Ingress seja exclusivo dentro de uma região, o nome do cluster pode ser truncado e anexado com um valor aleatório dentro do nome de domínio do Ingress.
 **Nota**: mudar o ID exclusivo ou nome de domínio que é designado durante a criação bloqueia o mestre do Kubernetes de gerenciar seu cluster.

5. Selecione a disponibilidade  ** Zona única **  ou  ** Multizona ** . Em um cluster de múltiplas zonas, o nó principal é implementado em uma zona com capacidade de múltiplas zonas e os recursos de seu cluster são difundidos entre múltiplas zonas.

6. Insira os detalhes de área metropolitana e zona.
  * Clusters de multizona:
    1. Selecione um local de área metropolitana. Para obter o melhor desempenho, selecione o local de área metropolitana que esteja fisicamente próximo a você. Suas opções podem ser limitadas pela geografia.
    2. Selecione as zonas específicas nas quais você deseja hospedar seu cluster. Deve-se selecionar pelo menos uma zona, mas é possível selecionar quantas você desejar. Se você selecionar mais de uma zona, os nós do trabalhador serão distribuídos entre as zonas que você escolher, o que fornece maior disponibilidade. Se você selecionar apenas uma zona, poderá [incluir zonas em seu cluster](/docs/containers?topic=containers-add_workers#add_zone) depois de ser criada.
  * Clusters de zona única: selecione uma zona na qual você deseja hospedar seu cluster. Para obter o melhor desempenho, selecione a zona que está fisicamente mais próxima a você. Suas opções podem ser limitadas pela geografia.

7. Para cada zona, escolha VLANs.
  * Para criar um cluster no qual é possível executar cargas de trabalho voltadas à Internet:
    1. Selecione uma VLAN pública e uma VLAN privada da sua conta de infraestrutura do IBM Cloud para cada zona. Os nós do trabalhador se comunicam entre si usando a VLAN privada e podem se comunicar com o principal do Kubernetes usando a VLAN pública ou privada. Se você não tiver uma VLAN pública ou privada nessa zona, uma VLAN pública e uma privada serão criadas automaticamente. É possível usar a mesma VLAN para múltiplos clusters.
  * Para criar um cluster que amplie seu data center no local somente na rede privada, que amplie seu data center no local com a opção de incluir acesso público limitado posteriormente ou que amplie seu data center no local e forneça acesso público limitado por meio de um dispositivo de gateway:
    1. Selecione uma VLAN privada da sua conta de infraestrutura do IBM Cloud para cada zona. Os nós do trabalhador se comunicam uns com os outros usando a VLAN privada. Se você não tiver uma VLAN privada em uma zona, uma VLAN privada será criada automaticamente. É possível usar a mesma VLAN para múltiplos clusters.
    2. Para a VLAN pública, selecione **Nenhum**.

8. Para **Terminal em serviço principal**, escolha como os nós principais e do trabalhador do Kubernetes se comunicam.
  * Para criar um cluster no qual é possível executar cargas de trabalho voltadas à Internet:
    * Se os terminais de VRF e de serviço estiverem ativados em sua conta do {{site.data.keyword.cloud_notm}}, selecione **Terminais público e privado**.
    * Se não for possível ou não desejar ativar o VRF, selecione **Somente o terminal público**.
  * Para criar um cluster que amplie somente seu data center no local ou um cluster que amplie seu data center local e forneça acesso público limitado aos nós do trabalhador de borda, selecione **Tanto o terminal público quanto o privado** ou **Somente o terminal privado**. Assegure-se de que você tenha ativado o VRF ou os terminais em serviço em sua conta do {{site.data.keyword.cloud_notm}}. Observe que, se você ativa somente o terminal em serviço privado, deve-se [expor o terminal principal por meio de um balanceador de carga de rede privada](#access_on_prem) para que os usuários possam acessar o principal por meio de uma VPN ou uma conexão do {{site.data.keyword.BluDirectLink}}.
  * Para criar um cluster que amplie seu data center no local e forneça acesso público limitado a um dispositivo de gateway, selecione **Somente terminal público**.

9. Configure seu conjunto de trabalhadores padrão. Os conjuntos de trabalhadores são grupos de nós do trabalhador que compartilham a mesma configuração. É possível sempre incluir mais conjuntos de trabalhadores em seu cluster posteriormente.
  1. Escolha a versão do servidor da API do Kubernetes para o nó principal do cluster e nós do trabalhador.
  2. Filtre os tipos de trabalhador selecionando um tipo de máquina. Virtual é faturado por hora e bare metal é faturado mensalmente.
    - **Bare metal**: os servidores bare metal faturados mensalmente são provisionados manualmente pela infraestrutura do IBM Cloud após o pedido e podem levar mais de um dia útil para serem concluídos. Bare metal é mais adequado para aplicativos de alto desempenho que precisam de mais recursos e controle do host. Certifique-se de que deseja provisionar uma máquina bare metal. Como o faturamento é mensal, se ele for cancelado imediatamente após uma ordem por engano, você ainda será cobrado pelo mês integral.
    - **Virtual - compartilhado**: os recursos de infraestrutura, como o hypervisor e hardware físico, são compartilhados entre você e outros clientes IBM, mas cada nó do trabalhador é acessível somente por você. Embora essa opção seja menos cara e suficiente na maioria dos casos, você pode desejar verificar suas necessidades de desempenho e infraestrutura com suas políticas da empresa.
    - **Virtual - dedicado**: seus nós do trabalhador são hospedados na infraestrutura que é dedicada à sua conta. Os seus recursos físicos estão completamente isolados.
  3. Selecione um tipo. O tipo define a quantia de CPU virtual, memória e espaço em disco que é configurada em cada nó do trabalhador e disponibilizada para os contêineres. Os tipos de bare metal e máquinas virtuais disponíveis variam de acordo com a zona na qual você implementa o cluster. Depois de criar seu cluster, é possível incluir diferentes tipos ao incluir um trabalhador ou conjunto no cluster.
  4. Especifique o número de nós do trabalhador que você precisa no cluster. O número de trabalhadores que você insere é replicado em todo o número de zonas que você selecionou. Isso significa que, se você tiver duas zonas e selecionar três nós do trabalhador, seis nós serão provisionados e três nós ficarão em cada zona.

10. Clique em **Criar cluster**. Um conjunto de trabalhadores é criado com o número de trabalhadores que você especificou. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**.
    *   Quando a implementação é feita, é possível ver que seu cluster está pronto na guia **Visão geral**. Observe que mesmo se o cluster estiver pronto, algumas de suas partes usadas por outros serviços, como segredos do Ingress ou segredos de extração de imagem, ainda poderão estar em processo.
    *   A cada nó do trabalhador é designado um ID do nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.<p class="tip">Seu cluster não está em um estado **implementado**? Consulte o guia [Clusters de depuração](/docs/containers?topic=containers-cs_troubleshoot) para obter ajuda. Por exemplo, se o seu cluster for provisionado em uma conta protegida por um dispositivo de gateway de firewall, você deverá [definir as configurações do firewall para permitir o tráfego de saída para as portas e endereços IP apropriados](/docs/containers?topic=containers-firewall#firewall_outbound).</p>

11. Após a criação do cluster, é possível [começar a trabalhar com seu cluster configurando sua sessão da CLI](#access_cluster).

### Criando um cluster padrão na CLI
{: #clusters_cli_steps}

Antes de iniciar, instale a CLI do {{site.data.keyword.cloud_notm}} e o [plug-in do {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).

1. Efetue login na CLI do {{site.data.keyword.cloud_notm}}.
  1. Efetue login e insira suas credenciais do {{site.data.keyword.cloud_notm}} quando solicitado.
     ```
     ibmcloud login
     ```
     {: pre}

     Se você tiver um ID federado, use `ibmcloud login --sso` para efetuar login na CLI do {{site.data.keyword.cloud_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem o `--sso` e é bem-sucedido com a opção `--sso`.
     {: tip}

  2. Se você tiver várias contas do {{site.data.keyword.cloud_notm}}, selecione a conta na qual deseja criar seu cluster do Kubernetes.

  3. Para criar clusters em um grupo de recursos diferente do padrão, destine esse grupo de recursos.

      * Um cluster pode ser criado em apenas um grupo de recursos e, após sua criação, não é possível mudar seu grupo de recursos.
      * Deve-se ter pelo menos a [função **Visualizador**](/docs/containers?topic=containers-users#platform) para o grupo de recursos.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

3. Revise as zonas que estão disponíveis. Na saída do comando a seguir, as zonas têm um **Tipo de Local** de `dc`. Para abranger seu cluster entre zonas, deve-se criar o cluster em uma [zona com capacidade para múltiplas zonas](/docs/containers?topic=containers-regions-and-zones#zones). As zonas com capacidade de multizona têm um valor de área metropolitana na coluna **Metro de multizona**.
    ```
    ibmcloud ks supported-locations
    ```
    {: pre}
    Quando você seleciona uma zona que está localizada fora de seu país, tenha em mente que você pode requerer autorização legal antes que os dados possam ser armazenados fisicamente em um país estrangeiro.
    {: note}

4. Revise os tipos de nó do trabalhador que estão disponíveis nessa zona. O tipo de trabalhador especifica os hosts de cálculo virtual ou físico que estão disponíveis para cada nó do trabalhador.
  - **Virtual**: faturadas por hora, as máquinas virtuais são provisionadas em hardware compartilhado ou dedicado.
  - **Físico**: os servidores bare metal faturados mensalmente são provisionados manualmente pela infraestrutura do IBM Cloud após o pedido e podem levar mais de um dia útil para serem concluídos. Bare metal é mais adequado para aplicativos de alto desempenho que precisam de mais recursos e controle do host.
  - **tipos**: para decidir qual tipo deve ser implementado, revise as combinações de núcleo, memória e armazenamento do [hardware do nó do trabalhador disponível](/docs/containers?topic=containers-planning_worker_nodes#shared_dedicated_node). Depois de criar seu cluster, é possível incluir diferentes tipos físicos ou virtuais ao [incluir um conjunto de trabalhadores](/docs/containers?topic=containers-add_workers#add_pool).

     Certifique-se de que deseja provisionar uma máquina bare metal. Como o faturamento é mensal, se ele for cancelado imediatamente após uma ordem por engano, você ainda será cobrado pelo mês integral.
     {:tip}

  ```
  ibmcloud ks flavors --zone <zone>
  ```
  {: pre}

4. Verifique se as VLANs para a zona já existem na infraestrutura do IBM Cloud para essa conta.
  ```
  ibmcloud ks vlans --zone <zone>
  ```
  {: pre}

  Saída de exemplo:
  ```
  ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
  ```
  {: screen}
  * Para criar um cluster no qual é possível executar cargas de trabalho voltadas à Internet, verifique para ver se existe uma VLAN pública e privada. Se uma VLAN pública e privada já existe, observe os roteadores correspondentes. Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). Ao criar um cluster e especificar as VLANs públicas e privadas, a combinação de número e letra após esses prefixos devem corresponder. Na saída de exemplo, quaisquer VLANs privadas podem ser usadas com quaisquer VLANs públicas porque todos os roteadores incluem `02a.dal10`.
  * Para criar um cluster que amplia o seu data center local apenas na rede privada, que amplia o seu data center local com a opção de incluir acesso público limitado posteriormente por meio dos nós do trabalhador de borda ou que amplia o seu data center local e fornece acesso público limitado por meio de um dispositivo de gateway, verifique para ver se existe uma VLAN privada. Se você tiver uma VLAN privada, anote o ID.

5. Execute o comando `cluster-create`. Por padrão, os discos do nó do trabalhador são criptografados por AES de 256 bits e o cluster é faturado por horas de uso.
  * Para criar um cluster no qual é possível executar cargas de trabalho voltadas à Internet:
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type <flavor> --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers <number> --name <cluster_name> --kube-version <major.minor.patch> [--private-service-endpoint] [--public-service-endpoint] [--disable-disk-encrypt]
    ```
    {: pre}
  * Para criar um cluster que amplie seu data center no local na rede privada, com a opção de incluir acesso público limitado posteriormente por meio dos nós do trabalhador de borda:
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type <flavor> --hardware <shared_or_dedicated> --private-vlan <private_VLAN_ID> --private-only --workers <number> --name <cluster_name> --kube-version <major.minor.patch> --private-service-endpoint [--public-service-endpoint] [--disable-disk-encrypt]
    ```
    {: pre}
  * Para criar um cluster que amplie seu data center no local e forneça acesso público limitado por meio de um dispositivo de gateway:
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type <flavor> --hardware <shared_or_dedicated> --private-vlan <private_VLAN_ID> --private-only --workers <number> --name <cluster_name> --kube-version <major.minor.patch> --public-service-endpoint [--disable-disk-encrypt]
    ```
    {: pre}

    <table>
    <caption>Os componentes de criação de cluster</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>O comando para criar um cluster na organização do {{site.data.keyword.cloud_notm}}.</td>
    </tr>
    <tr>
    <td><code>--zone <em>&lt;zone&gt;</em></code></td>
    <td>Especifique o ID da zona do {{site.data.keyword.cloud_notm}} no qual você deseja criar seu cluster que escolheu na etapa 4.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Especifique o tipo que você escolheu na etapa 5.</td>
    </tr>
    <tr>
    <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
    <td>Especifique com o nível de isolamento de hardware para seu nó do trabalhador. Use dedicado para disponibilizar recursos físicos disponíveis apenas para você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes da IBM. O padrão é shared. Esse valor é opcional para clusters padrão da VM. Para os tipos bare metal, especifique `dedicated`.</td>
    </tr>
    <tr>
    <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
    <td>Se você já tiver uma VLAN pública configurada em sua conta de infraestrutura do IBM Cloud para essa zona, insira o ID da VLAN pública que você localizou na etapa 4.<p>Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). Ao criar um cluster e especificar as VLANs públicas e privadas, a combinação de número e letra após esses prefixos devem corresponder.</p></td>
    </tr>
    <tr>
    <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
    <td>Se você já tiver uma VLAN privada configurada em sua conta de infraestrutura do IBM Cloud para essa zona, insira o ID da VLAN privada que você localizou na etapa 4. Se você não tiver uma VLAN privada em sua conta, não especifique essa opção. O {{site.data.keyword.containerlong_notm}} cria automaticamente uma VLAN privada para você.<p>Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). Ao criar um cluster e especificar as VLANs públicas e privadas, a combinação de número e letra após esses prefixos devem corresponder.</p></td>
    </tr>
    <tr>
    <td><code>-- somente privado </code></td>
    <td>Crie o cluster somente com VLANs privadas. Se você incluir essa opção, não inclua a opção <code>--public-vlan</code>.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Especifique um nome para seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e hífen (-) e deve ter 35 caracteres ou menos. Use um nome que seja exclusivo entre as regiões. O nome do cluster e a região na qual o cluster está implementado formam o nome completo do domínio para o subdomínio do Ingress. Para assegurar que o subdomínio do Ingress seja exclusivo dentro de uma região, o nome do cluster pode ser truncado e anexado com um valor aleatório dentro do nome de domínio do Ingress.
</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>Especifique o número de nós do trabalhador a serem incluídos no cluster. Se a opção <code>--workers</code> não for especificada, um nó do trabalhador será criado.</td>
    </tr>
    <tr>
    <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
    <td>A versão do Kubernetes para o nó principal do cluster. Esse valor é opcional. Quando a versão não for especificada, o cluster será criado com o padrão de versões do Kubernetes suportadas. Para ver as versões disponíveis, execute <code>ibmcloud ks versions</code>.
</td>
    </tr>
    <tr>
    <td><code>--private-service-endpoint </code></td>
    <td>**Em [Contas ativadas pelo VRF](/docs/resources?topic=resources-private-network-endpoints#getting-started)**: ative o terminal em serviço privado para que o seu principal do Kubernetes e os nós do trabalhador possam se comunicar pela VLAN privada. Além disso, é possível escolher ativar o terminal em serviço público usando a sinalização `--public-service-endpoint` para acessar seu cluster por meio da Internet. Se você ativa somente o terminal em serviço privado, deve-se estar conectado à VLAN privada para se comunicar com seu mestre do Kubernetes. Depois de ativar um terminal em serviço privado, não será possível desativá-lo posteriormente.<br><br>Depois de criar o cluster, é possível obter o terminal executando `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>`.</td>
    </tr>
    <tr>
    <td><code>--public-service-endpoint </code></td>
    <td>Ative o terminal em serviço público para que o principal do Kubernetes possa ser acessado pela rede pública, por exemplo, para executar comandos `kubectl` em seu terminal e para que o principal do Kubernetes e os nós do trabalhador possam se comunicar pela VLAN pública. É possível desativar posteriormente o terminal em serviço público se você desejar um cluster somente privado.<br><br>Depois de criar o cluster, é possível obter o terminal executando `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>`.</td>
    </tr>
    <tr>
    <td><code>--disable-disk-encrypt</code></td>
    <td>Os nós do trabalhador apresentam a [criptografia de disco](/docs/containers?topic=containers-security#encrypted_disk) do AES de 256 bits por padrão. Se desejar desativar a criptografia, inclua esta opção.</td>
    </tr>
    </tbody></table>

6. Verifique se a criação do cluster foi solicitada. Para máquinas virtuais, pode levar alguns minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta. As máquinas físicas bare metal são provisionadas por interação manual com a infraestrutura do IBM Cloud e podem levar mais de um dia útil para serem concluídas.
    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.
    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.13.8      Default
    ```
    {: screen}

    Seu cluster não está em um estado **implementado**? Consulte o guia [Clusters de depuração](/docs/containers?topic=containers-cs_troubleshoot) para obter ajuda. Por exemplo, se o seu cluster for provisionado em uma conta protegida por um dispositivo de gateway de firewall, você deverá [definir as configurações do firewall para permitir o tráfego de saída para as portas e endereços IP apropriados](/docs/containers?topic=containers-firewall#firewall_outbound).
    {: tip}

7. Verifique o status dos nós do trabalhador.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster. Observe que mesmo se o cluster estiver pronto, algumas de suas partes usadas por outros serviços, como segredos do Ingress ou segredos de extração de imagem, ainda poderão estar em processo. Observe que, se você criou seu cluster somente com uma VLAN privada, nenhum endereço **IP público** será designado aos nós do trabalhador.

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   standard       normal   Ready    mil01       1.13.8      Default
    ```
    {: screen}

    A cada nó do trabalhador é designado um ID do nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o
mestre do Kubernetes gerencie o cluster.
    {: important}

8. Após a criação do cluster, é possível [começar a trabalhar com seu cluster configurando sua sessão da CLI](#access_cluster).

<br />


## Acessando seu cluster
{: #access_cluster}

Após a criação do cluster, é possível começar a trabalhar com seu cluster configurando a sessão da CLI.
{: shortdesc}

### Acessando clusters por meio do terminal em serviço público
{: #access_internet}

Para trabalhar com seu cluster, configure o cluster que você criou como o contexto para uma sessão CLI para executar comandos `kubectl`.
{: shortdesc}

Se desejar usar o console do {{site.data.keyword.cloud_notm}}, será possível executar comandos da CLI diretamente de seu navegador da web no [Terminal do Kubernetes](/docs/containers?topic=containers-cs_cli_install#cli_web).
{: tip}

1. Se a sua rede estiver protegida por um firewall da empresa, permita acesso aos terminais e portas de API do {{site.data.keyword.cloud_notm}} e do {{site.data.keyword.containerlong_notm}}.
  1. [Permita acesso aos terminais públicos para a API `ibmcloud` e a API `ibmcloud ks` em seu firewall](/docs/containers?topic=containers-firewall#firewall_bx).
  2. [Permita que os usuários do cluster autorizados executem comandos `kubectl`](/docs/containers?topic=containers-firewall#firewall_kubectl) para acessar o principal por meio dos terminais em serviço somente público, somente privado ou público e privado.
  3. [Permita que os usuários do cluster autorizados executem comandos `calicotl`](/docs/containers?topic=containers-firewall#firewall_calicoctl) para gerenciar as políticas de rede do Calico em seu cluster.

2. Configure o cluster que você criou como o contexto para essa sessão. Conclua estas etapas de configuração toda vez que você trabalhar com o seu cluster.
  1. Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração
do Kubernetes.
      ```
      ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
      ```
      {: pre}
      Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

      Exemplo para OS X:
      ```
      export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
      ```
      {: screen}
  2. Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.
  3. Verifique se a variável de ambiente `KUBECONFIG` está configurada corretamente.
      Exemplo para OS X:
      ```
      echo $KUBECONFIG
      ```
      {: pre}

      Saída:
      ```
      /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
      ```
      {: screen}

3. Ative seu painel do Kubernetes com a porta padrão `8001`.
  1. Configure o proxy com o número da porta padrão.
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

### Acessando clusters por meio do terminal em serviço privado
{: #access_on_prem}

O mestre do Kubernetes será acessível por meio do terminal em serviço privado se usuários de cluster autorizados estiverem em sua rede privada do {{site.data.keyword.cloud_notm}} ou se forem conectados à rede privada por meio de uma [conexão VPN](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) ou do [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link). No entanto, a comunicação com o mestre do Kubernetes por meio do terminal em serviço privado deve passar pelo intervalo de endereços IP <code>166.X.X.X</code>, que não é roteável por meio de uma conexão VPN ou por meio do {{site.data.keyword.cloud_notm}} Direct Link. É possível expor o terminal em serviço privado do mestre para os usuários do cluster usando um balanceador de carga de rede (NLB) privado. O NLB privado expõe o terminal em serviço privado do mestre como um intervalo interno de endereços IP <code>10.X.X.X</code> que os usuários podem acessar com a VPN ou com a conexão do {{site.data.keyword.cloud_notm}} Direct Link. Se você ativar apenas o terminal em serviço privado, será possível usar o painel do Kubernetes ou ativar temporariamente o terminal em serviço público para criar o NLB privado.
{: shortdesc}

1. Se a sua rede estiver protegida por um firewall da empresa, permita acesso aos terminais e portas de API do {{site.data.keyword.cloud_notm}} e do {{site.data.keyword.containerlong_notm}}.
  1. [Permita acesso aos terminais públicos para a API `ibmcloud` e a API `ibmcloud ks` em seu firewall](/docs/containers?topic=containers-firewall#firewall_bx).
  2. [Permita que os usuários do cluster autorizados executem comandos `kubectl`](/docs/containers?topic=containers-firewall#firewall_kubectl). Observe que não é possível testar a conexão com seu cluster na etapa 6 até que você exponha o terminal em serviço privado do principal para o cluster usando um NLB privado.

2. Obtenha a URL do terminal em serviço privado e a porta para seu cluster.
  ```
  ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Nesta saída de exemplo, a **URL do terminal em serviço privado** é `https://c1.private.us-east.containers.cloud.ibm.com:25073`.
  ```
  Name:                           setest
  ID:                             b8dcc56743394fd19c9f3db7b990e5e3
  State:                          normal
  Created:                        2019-04-25T16:03:34+0000
  Location:                       wdc04
  Master URL:                     https://c1.private.us-east.containers.cloud.ibm.com:25073
  Public Service Endpoint URL:    -
  Private Service Endpoint URL:   https://c1.private.us-east.containers.cloud.ibm.com:25073
  Master Location:                Washington D.C.
  ...
  ```
  {: screen}

3. Crie um arquivo YAML que seja denominado `kube-api-via-nlb.yaml`. Esse YAML cria um serviço privado do `LoadBalancer` e expõe o terminal em serviço privado por meio desse NLB. Substitua `<private_service_endpoint_port>` pela porta que você localizou na etapa anterior.
  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: kube-api-via-nlb
    annotations:
      service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    namespace: default
  spec:
    type: LoadBalancer
    ports:
    - protocol: TCP
      port: <private_service_endpoint_port>
      targetPort: <private_service_endpoint_port>
  ---
  kind: Endpoints
  apiVersion: v1
  metadata:
    name: kube-api-via-nlb
  subsets:
    - addresses:
        - ip: 172.20.0.1
      ports:
        - port: 2040
  ```
  {: codeblock}

4. Para criar o NLB privado, deve-se estar conectado ao cluster principal. Como ainda não é possível se conectar por meio do terminal em serviço privado de uma VPN ou do {{site.data.keyword.cloud_notm}} Direct Link, deve-se se conectar ao cluster principal e criar o NLB usando o terminal em serviço público ou o painel do Kubernetes.
  * Se você ativou somente o terminal em serviço privado, é possível usar o painel Kubernetes para criar o NLB. O painel roteia automaticamente todas as solicitações para o terminal em serviço privado do principal.
    1.  Efetue login no [console do {{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/).
    2.  Na barra de menus, selecione a conta que você deseja usar.
    3.  No menu ![Ícone de menu](../icons/icon_hamburger.svg "Ícone de menu"), clique em **Kubernetes**.
    4.  Na página **Clusters**, clique no cluster que você deseja acessar.
    5.  Na página de detalhes do cluster, clique no **Painel do Kubernetes**.
    6.  Clique em **+ Criar**.
    7.  Selecione **Criar por meio do arquivo**, faça upload do arquivo `kube-api-via-nlb.yaml` e clique em **Upload**.
    8.  Na página **Visão geral**, verifique se o serviço `kube-api-via-nlb` é criado. Na coluna **Terminais externos**, anote o endereço `10.x.x.x`. Esse endereço IP expõe o terminal em serviço privado do mestre do Kubernetes na porta especificada em seu arquivo YAML.

  * Se você também tiver ativado o terminal em serviço público, já terá acesso ao principal.
    1. Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração
do Kubernetes.
        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}
        Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

        Exemplo para OS X:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}
    2. Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.
    3. Crie o NLB e o terminal.
      ```
      kubectl apply -f kube-api-via-nlb.yaml
      ```
      {: pre}
    4. Verifique se o NLB `kube-api-via-nlb` é criado. Na saída, anote o endereço **EXTERNAL-IP** `10.x.x.x`. Esse endereço IP expõe o terminal em serviço privado do mestre do Kubernetes na porta especificada em seu arquivo YAML.
      ```
      kubectl get svc -o wide
      ```
      {: pre}

      Nesta saída de exemplo, o endereço IP para o terminal em serviço privado do principal do Kubernetes é `10.186.92.42`.
      ```
      NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE   SELECTOR
      kube-api-via-nlb         LoadBalancer   172.21.150.118   10.186.92.42     443:32235/TCP    10m   <none>
      ...
      ```
      {: screen}

  <p class="note">Se você deseja se conectar ao principal usando o [serviço VPN do strongSwan](/docs/containers?topic=containers-vpn#vpn-setup), anote o **IP do cluster** `172.21.x.x` para usar na próxima etapa. Como o pod de VPN do strongSwan é executado dentro de seu cluster, ele pode acessar o NLB usando o endereço IP do serviço IP do cluster interno. No arquivo `config.yaml` para o gráfico do Helm do strongSwan, assegure-se de que o CIDR da sub-rede de serviço do Kubernetes, `172.21.0.0/16`, esteja listado na configuração `local.subnet`.</p>

5. Nas máquinas do cliente em que você ou seus usuários executam comandos `kubectl`, inclua o endereço IP do NLB e a URL do terminal em serviço privado no arquivo `/etc/hosts`. Não inclua nenhuma porta no endereço IP e na URL e não inclua `https://` na URL.
  * Para usuários do OSX e Linux:
    ```
    sudo nano /etc/hosts
    ```
    {: pre}
  * Para usuários do Windows:
    ```
    notepad C:\Windows\System32\drivers\etc\hosts
    ```
    {: pre}

    Dependendo de suas permissões de máquina local, talvez seja necessário executar o Notepad como um administrador para editar o arquivo de hosts.
    {: tip}

  Texto de exemplo a ser incluído:
  ```
  10.186.92.42      c1.private.us-east.containers.cloud.ibm.com
  ```
  {: codeblock}

6. Verifique se você está conectado à rede privada por meio de uma VPN ou da conexão do {{site.data.keyword.cloud_notm}} Direct Link.

7. Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração
do Kubernetes.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
    ```
    {: pre}
    Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

    Exemplo para OS X:
    ```
    export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
    ```
    {: screen}

8. Opcional: se ambos os terminais em serviço, o público e o privado, estiverem ativados, atualize o seu arquivo de configuração do Kubernetes local para usar o terminal em serviço privado. Por padrão, o terminal em serviço público é transferido por download para o arquivo de configuração.
  1. Navegue para o diretório `kubeconfig` e abra o arquivo.
    ```
    cd /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/<cluster_name> && nano touch kube-config-prod-dal10-mycluster.yml
    ```
    {: pre}
  2. Edite o arquivo de configuração do Kubernetes para incluir a palavra `private` na URL do terminal em serviço. Por exemplo, no arquivo de configuração do Kubernetes `kube-config-prod-dal10-mycluster.yml`, o campo do servidor pode se parecer com `server: https://c1.us-east.containers.cloud.ibm.com:30426`. É possível mudar essa URL para a URL do terminal em serviço privado mudando o campo do servidor para `server: https://c1.private.us-east.containers.cloud.ibm.com:30426`.
  3. Repita essas etapas cada vez que executar `ibmcloud ks cluster-config`.

9. Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.

10. Verifique se os comandos `kubectl` são executados corretamente com seu cluster por meio do terminal em serviço privado, verificando a versão do servidor da CLI do Kubernetes.
  ```
  kubectl version  --short
  ```
  {: pre}

  Saída de exemplo:
  ```
  Client Version: v1.13.8
  Server Version: v1.13.8
  ```
  {: screen}

<br />


## Etapas Seguintes
{: #next_steps}

Quando o cluster estiver funcionando, será possível verificar as tarefas a seguir:
- Se você criou o cluster em uma zona com capacidade para multizona, [difunda os nós do trabalhador incluindo uma zona em seu cluster](/docs/containers?topic=containers-add_workers).
- [Implementar um app no cluster.](/docs/containers?topic=containers-app#app_cli)
- [Configure seu próprio registro privado no {{site.data.keyword.cloud_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry?topic=registry-getting-started)
- [Configure o ajustador automático de escala](/docs/containers?topic=containers-ca#ca) para incluir ou remover automaticamente os nós do trabalhador de seus conjuntos do trabalhadores com base em suas solicitações de recurso de carga de trabalho.
- Controle quem pode criar pods em seu cluster com [políticas de segurança do pod](/docs/containers?topic=containers-psp).
- Ative os complementos gerenciados pelo [Istio](/docs/containers?topic=containers-istio) e pelo [Knative](/docs/containers?topic=containers-serverless-apps-knative) para ampliar seus recursos de cluster.

Em seguida, é possível conferir as etapas de configuração de rede a seguir para a configuração do cluster:

### Executar cargas de trabalho do app voltadas para a Internet em um cluster
{: #next_steps_internet}

* Isole as cargas de trabalho de rede para os [nós do trabalhador de borda](/docs/containers?topic=containers-edge).
* Exponha seus apps com [serviços de rede pública](/docs/containers?topic=containers-cs_network_planning#public_access).
* Controle o tráfego público para os serviços de rede que expõem seus apps criando [políticas pré-DNAT do Calico](/docs/containers?topic=containers-network_policies#block_ingress), tais como políticas de lista de desbloqueio e lista de bloqueio.
* Conecte seu cluster a serviços em redes privadas fora de sua conta do {{site.data.keyword.cloud_notm}} configurando um [serviço VPN de IPSec do strongSwan](/docs/containers?topic=containers-vpn).

### Ampliar seu data center no local para um cluster e permitir o acesso público limitado usando nós de borda e políticas de rede do Calico
{: #next_steps_calico}

* Conecte seu cluster a serviços em redes privadas fora de sua conta do {{site.data.keyword.cloud_notm}} configurando o [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) ou o [serviço VPN de IPSec do strongSwan](/docs/containers?topic=containers-vpn#vpn-setup). O {{site.data.keyword.cloud_notm}} Direct Link permite a comunicação entre apps e serviços em seu cluster e uma rede no local pela rede privada, enquanto o strongSwan permite a comunicação por meio de um túnel VPN criptografado pela rede pública.
* Isole as cargas de trabalho de rede pública criando um [conjunto de trabalhadores de borda](/docs/containers?topic=containers-edge) de nós do trabalhador que estão conectados a VLANs públicas e privadas.
* Exponha seus apps com [serviços de rede privada](/docs/containers?topic=containers-cs_network_planning#private_access).
* Crie políticas de rede do host Calico para isolar o seu cluster na [rede pública](/docs/containers?topic=containers-network_policies#isolate_workers_public) e na [rede privada](/docs/containers?topic=containers-network_policies#isolate_workers).

### Ampliar seu data center no local para um cluster e permitir o acesso público limitado usando um dispositivo de gateway
{: #next_steps_gateway}

* Se você também configura seu firewall de gateway para a rede privada, deve-se [permitir a comunicação entre os nós do trabalhador e permitir que o cluster acesse seus recursos de infraestrutura de acesso pela rede privada](/docs/containers?topic=containers-firewall#firewall_private).
* Para conectar de forma segura seus nós do trabalhador e apps a redes privadas fora de sua conta do {{site.data.keyword.cloud_notm}}, configure um terminal de VPN IPSec em seu dispositivo de gateway. Em seguida, [configure o serviço de VPN IPSec do strongSwan](/docs/containers?topic=containers-vpn#vpn-setup) em seu cluster para usar o terminal VPN em seu gateway ou [configurar a conectividade VPN diretamente com o VRA](/docs/containers?topic=containers-vpn#vyatta).
* Exponha seus apps com [serviços de rede privada](/docs/containers?topic=containers-cs_network_planning#private_access).
* [Abra as portas necessárias e os endereços IP](/docs/containers?topic=containers-firewall#firewall_inbound) em seu firewall de dispositivo de gateway para permitir o tráfego de entrada para serviços de rede.

### Ampliar seu data center no local para um cluster somente na rede privada
{: #next_steps_extend}

* Se você tiver um firewall na rede privada, [permita a comunicação entre os nós do trabalhador e permita que seu cluster acesse os recursos de infraestrutura por meio da rede privada](/docs/containers?topic=containers-firewall#firewall_private).
* Conecte seu cluster a serviços em redes privadas fora de sua conta do {{site.data.keyword.cloud_notm}} configurando o [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link).
* Exponha seus apps na rede privada com [serviços de rede privada](/docs/containers?topic=containers-cs_network_planning#private_access).
