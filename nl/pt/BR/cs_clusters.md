---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurando clusters e nós do trabalhador
{: #clusters}
Crie clusters e inclua nós do trabalhador para aumentar a capacidade do cluster no {{site.data.keyword.containerlong}}. Ainda está sendo iniciado? Experimente o [tutorial de criação de um cluster do Kubernetes](cs_tutorials.html#cs_cluster_tutorial).
{: shortdesc}

## Criando clusters com a GUI
{: #clusters_ui}

O propósito do cluster do Kubernetes é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

**Antes de começar**
* Deve-se ter uma conta para Teste, pré-paga ou de Assinatura do [{{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/).
* Decida entre um [cluster grátis ou padrão](cs_why.html#cluster_types).
* Se você criar um cluster padrão, será possível [estimar o custo com a calculadora de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes). **Nota**: deve-se incluir uma **Rede dedicada (1 sub-rede com 8 IPs públicos móveis)** para cada cluster para sua estimativa. Além disso, o custo para a largura da banda de rede de saída varia por uso e é um encargo adicional além dos encargos na calculadora de precificação.

Para customizar completamente os clusters com sua opção de isolamento de hardware, zona, versão da API e mais, crie um cluster padrão.
{: tip}

** Para criar um cluster grátis **

É possível usar 1 cluster grátis para se familiarizar com o funcionamento do {{site.data.keyword.containerlong_notm}}. Com clusters grátis, é possível aprender a terminologia, concluir um tutorial e orientar-se antes de dar o salto para os clusters padrão de nível de produção. Não se preocupe, você ainda terá um cluster grátis, mesmo que tenha uma conta Pré-paga ou de Assinatura. **Nota**: os clusters grátis têm um tempo de vida de 30 dias. Após esse tempo, o cluster expira e o cluster e seus dados são excluídos. Os dados excluídos não são submetidos a backup pelo {{site.data.keyword.Bluemix_notm}} e não podem ser restaurados. Certifique-se de fazer backup de quaisquer dados importantes.

1. No catálogo, selecione **{{site.data.keyword.containerlong_notm}}**.

2. Selecione uma região no qual implementar o cluster. **Nota**: não é possível criar clusters grátis nas regiões Leste dos EUA ou Norte AP e zonas correspondentes.

3. Selecione o plano de cluster  ** Grátis ** .

4. Forneça um nome ao seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e hífen (-) e deve ter 35 caracteres ou menos. O nome do cluster e a região na qual o cluster está implementado formam o nome completo do domínio para o subdomínio do Ingress. Para assegurar que o subdomínio do Ingress seja exclusivo dentro de uma região, o nome do cluster pode ser truncado e anexado com um valor aleatório dentro do nome de domínio do Ingress.


5. Clique em **Criar cluster**. Por padrão, um conjunto de trabalhadores com um nó do trabalhador é criado. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**. Quando a implementação está pronta, é possível ver que seu cluster está pronto na guia **Visão geral**.

    Mudar o ID exclusivo ou o nome de domínio que é designado durante a criação bloqueia o mestre do Kubernetes de gerenciar o seu cluster.
    {: tip}

</br>

** Para criar um cluster padrão **

1. No catálogo, selecione **{{site.data.keyword.containerlong_notm}}**.

2. Selecione uma região no qual implementar o cluster. Para obter o melhor desempenho, selecione a região que está fisicamente mais próxima de você. Lembre-se de que se você selecionar uma zona que está fora de seu país, poderá requerer autorização legal antes de os dados serem armazenados.

3. Selecione o plano de cluster  ** Padrão ** . Com um cluster padrão, você tem acesso a recursos como múltiplos nós do trabalhador para um ambiente altamente disponível.

4. Insira os detalhes da zona.

    1. Selecione a disponibilidade  ** Zona única **  ou  ** Multizona ** . Em um cluster de múltiplas zonas, o nó principal é implementado em uma zona com capacidade para múltiplas zonas e os recursos de seu cluster são difundidos entre múltiplas zonas. Suas opções podem ser limitadas por região.

    2. Selecione as zonas específicas nas quais você deseja hospedar seu cluster. Deve-se selecionar pelo menos 1 zona, mas é possível selecionar quantas você desejar. Se você selecionar mais de 1 zona, os nós do trabalhador serão difundidos entre as zonas que você escolher, o que fornece disponibilidade mais alta. Se você selecionar somente 1 zona, será possível [incluir zonas em seu cluster](#add_zone) após ele ser criado.

    3. Selecione uma VLAN pública (opcional) e uma VLAN privada (obrigatório) de sua conta de infraestrutura do IBM Cloud (SoftLayer). Os nós do trabalhador se comunicam uns com os outros usando a VLAN privada. Para se comunicar com o mestre do Kubernetes, deve-se configurar a conectividade pública para o seu nó do trabalhador.  Se você não tiver uma VLAN pública ou privada nessa zona, deixe-a em branco. Uma VLAN pública e uma privada são criadas automaticamente para você. Se você tiver VLANs existentes e não especificar uma VLAN pública, considere configurar um firewall, como um [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html#about). É possível usar a mesma VLAN para múltiplos clusters.
        **Nota**: se os nós do trabalhador estiverem configurados com apenas uma VLAN privada, será necessário configurar uma solução alternativa para conectividade de rede. Para obter mais informações, veja [Planejando a rede de cluster somente privada](cs_network_cluster.html#private_vlan).

5. Configure seu conjunto de trabalhadores padrão. Os conjuntos de trabalhadores são grupos de nós do trabalhador que compartilham a mesma configuração. É possível sempre incluir mais conjuntos de trabalhadores em seu cluster posteriormente.

    1. Selecione um tipo de isolamento de hardware. Virtual é faturado por hora e bare metal é faturado mensalmente.

        - **Virtual - Dedicado**: os seus nós do trabalhador são hospedados na infraestrutura que é dedicada à sua conta. Os seus recursos físicos estão completamente isolados.

        - **Virtual - Compartilhado**: os recursos de infraestrutura, como o hypervisor e hardware físico, são compartilhados entre você e outros clientes IBM, mas cada nó do trabalhador é acessível somente por você. Embora essa opção seja menos cara e suficiente na maioria dos casos, você pode desejar verificar suas necessidades de desempenho e infraestrutura com suas políticas da empresa.

        - **Bare metal**: faturados mensalmente, os servidores bare metal são provisionados pela interação manual com a infraestrutura do IBM Cloud (SoftLayer) e podem levar mais de um dia útil para serem concluídos. Bare metal é mais adequado para aplicativos de alto desempenho que precisam de mais recursos e controle do host. Para clusters que executam o Kubernetes versão 1.9 ou mais recente, também é possível escolher ativar o [Cálculo confiável](cs_secure.html#trusted_compute) para verificar seus nós do trabalhador com relação à violação. O Cálculo confiável está disponível para selecionar tipos de máquina bare metal. Por exemplo, os tipos GPU `mgXc` não suportam o Cálculo confiável. Se você não ativar a confiança durante a criação do cluster, mas desejar posteriormente, será possível usar o comando `ibmcloud ks feature-enable` [](cs_cli_reference.html#cs_cluster_feature_enable). Depois de ativar a confiança, não é possível desativá-la posteriormente.

        Certifique-se de que deseja provisionar uma máquina bare metal. Como o faturamento é mensal, se ele for cancelado imediatamente após uma ordem por engano, você ainda será cobrado pelo mês integral.
        {:tip}

    2. Selecione um tipo de máquina. O tipo de máquina define a quantia de CPU virtual, memória e espaço em disco que é configurada em cada nó do trabalhador e disponibilizada para os contêineres. Os tipos de bare metal e máquinas virtuais disponíveis variam de acordo com a zona na qual você implementa o cluster. Depois de criar seu cluster, é possível incluir diferentes tipos de máquina incluindo um trabalhador ou um conjunto no cluster.

    3. Especifique o número de nós do trabalhador que você precisa no cluster. O número de trabalhadores que você insere é replicado em todo o número de zonas que você selecionou. Isso significa que se você tiver 2 zonas e selecionar 3 nós do trabalhador, 6 nós serão provisionados e 3 nós residirão em cada zona.

6. Forneça seu cluster um nome exclusivo. **Nota**: mudar o ID exclusivo ou nome de domínio que é designado durante a criação bloqueia o mestre do Kubernetes de gerenciar seu cluster.

7. Escolha a versão do servidor da API do Kubernetes para o nó principal do cluster.

8. Clique em **Criar cluster**. Um conjunto de trabalhadores é criado com o número de trabalhadores que você especificou. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**. Quando a implementação está pronta, é possível ver que seu cluster está pronto na guia **Visão geral**.

**O que vem a seguir?**

Quando o cluster estiver funcionando, será possível verificar as tarefas a seguir:

-   Espalhe nós do trabalhador ao longo de múltiplas zonas [incluindo uma zona em seu cluster](#add_zone).
-   [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
-   [Implementar um app no cluster.](cs_app.html#app_cli)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)
- Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).
- Se você tiver um firewall, poderá ser necessário [abrir as portas necessárias](cs_firewall.html#firewall) para usar os comandos `ibmcloud`, `kubectl` ou `calicotl`, para permitir o tráfego de saída de seu cluster ou para permitir o tráfego de entrada para serviços de rede.
-  Clusters com o Kubernetes versão 1.10 ou mais recente: controle quem pode criar pods em seu cluster com [políticas de segurança de pod](cs_psp.html).

<br />


## Criando clusters com a CLI
{: #clusters_cli}

O propósito do cluster do Kubernetes é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

Antes de iniciar:
- Deve-se ter uma [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) pré-paga ou de Assinatura que é configurada para [acessar o portfólio de infraestrutura do IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials). É possível criar 1 cluster grátis para testar alguns dos recursos por 30 dias ou criar clusters padrão totalmente customizáveis com sua opção de isolamento de hardware.
- [Certifique-se de que você tenha as permissões mínimas necessárias na infraestrutura do IBM Cloud (SoftLayer) para provisionar um cluster padrão](cs_users.html#infra_access).
- Instale a CLI do  {{site.data.keyword.Bluemix_notm}}  e o  [ plug-in do {{site.data.keyword.containerlong_notm}}  ](cs_cli_install.html#cs_cli_install).
- Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).
- Decida entre um [cluster grátis ou padrão](cs_why.html#cluster_types). Com seu 1 cluster grátis, você obtém um número limitado de dias para experimentar recursos do Kubernetes. Crie um cluster padrão para obter mais benefícios e controle sobre o desempenho do cluster.
- Se você criar um cluster padrão, será possível [estimar o custo com a calculadora de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes). **Nota**: deve-se incluir uma **Rede dedicada (1 sub-rede com 8 IPs públicos móveis)** para cada cluster para sua estimativa. Além disso, o custo para a largura da banda de rede de saída varia por uso e é um encargo adicional além dos encargos na calculadora de precificação.

Para criar um cluster:

1.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}.

    1.  Efetue login e insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitado.

        ```
        ibmcloud login
        ```
        {: pre}

        **Nota:** se você tiver um ID federado, use `ibmcloud login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

    2. Se você tiver várias contas do {{site.data.keyword.Bluemix_notm}}, selecione a conta na qual deseja criar seu cluster do Kubernetes.

    3.  Se você deseja criar ou acessar clusters do Kubernetes em uma região diferente da região do {{site.data.keyword.Bluemix_notm}} selecionada anteriormente, execute `ibmcloud ks region-set`.

3.  Crie um cluster. **Nota**: os clusters padrão podem ser criados em qualquer região e zona disponível. Os clusters grátis não podem ser criados nas regiões Leste dos EUA ou Norte AP e em zonas correspondentes, e não é possível selecionar a zona.

    1.  **Clusters padrão**: revise as zonas que estão disponíveis. As zonas que são mostradas dependem da região do {{site.data.keyword.containerlong_notm}} em que você efetuou login.

        **Nota**: para abranger seu cluster entre as zonas, deve-se criar o cluster em uma [zona com capacidade para múltiplas zonas](cs_regions.html#zones).

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **Clusters padrão**: escolha uma zona e revise os tipos de máquina disponíveis nessa zona. O tipo de máquina especifica os hosts de cálculo virtual ou físico que estão disponíveis para cada nó do trabalhador.

        -  Visualize o campo **Tipo de servidor** para escolher máquinas virtuais ou físicas (bare metal).
        -  **Virtual**: faturadas por hora, as máquinas virtuais são provisionadas em hardware compartilhado ou dedicado.
        -  **Físico**: faturados mensalmente, os servidores bare metal são provisionados pela interação manual com a infraestrutura do IBM Cloud (SoftLayer) e podem levar mais de um dia útil para serem concluídos. Bare metal é mais adequado para aplicativos de alto desempenho que precisam de mais recursos e controle do host.
        - **Máquinas físicas com Cálculo confiável**: para clusters bare metal que executam o Kubernetes versão 1.9 ou mais recente, também é possível escolher ativar o [Cálculo confiável](cs_secure.html#trusted_compute) para verificar seus nós do trabalhador bare metal com relação à violação. O Cálculo confiável está disponível para selecionar tipos de máquina bare metal. Por exemplo, os tipos GPU `mgXc` não suportam o Cálculo confiável. Se você não ativar a confiança durante a criação do cluster, mas desejar posteriormente, será possível usar o comando `ibmcloud ks feature-enable` [](cs_cli_reference.html#cs_cluster_feature_enable). Depois de ativar a confiança, não é possível desativá-la posteriormente.
        -  **Tipos de máquina**: para decidir qual tipo de máquina implementar, revise as combinações de núcleo, memória e armazenamento do [hardware do nó do trabalhador disponível](cs_clusters_planning.html#shared_dedicated_node). Depois de criar seu cluster, é possível incluir diferentes tipos de máquina física ou virtual [incluindo um conjunto de trabalhadores](#add_pool).

           Certifique-se de que deseja provisionar uma máquina bare metal. Como o faturamento é mensal, se ele for cancelado imediatamente após uma ordem por engano, você ainda será cobrado pelo mês integral.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **Clusters padrão**: verifique se uma VLAN pública e privada já existe na infraestrutura do IBM Cloud (SoftLayer) para esta conta.

        ```
        ibmcloud ks vlans <zone>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Se uma VLAN pública e privada já existe, observe os roteadores correspondentes. Os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador de backend) e roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador de front-end). Ao criar um cluster e especificar as VLANs públicas e privadas, o número e a combinação de letras após esses prefixos devem corresponder. Na saída de exemplo, quaisquer VLANs privadas podem ser usadas com quaisquer VLANs públicas porque todos os roteadores incluem `02a.dal10`.

        Deve-se conectar os nós do trabalhador a uma VLAN privada e, opcionalmente, é possível conectá-los a uma VLAN pública. **Nota**: se os nós do trabalhador estiverem configurados com apenas uma VLAN privada, será necessário configurar uma solução alternativa para conectividade de rede. Para obter mais informações, veja [Planejando a rede de cluster somente privada](cs_network_cluster.html#private_vlan).

    4.  **Clusters grátis e padrão**: execute o comando `cluster-create`. É possível escolher entre um cluster grátis, que inclui um nó do trabalhador configurado com 2vCPU e 4 GB de memória e é excluído automaticamente após 30 dias. Ao criar um cluster padrão, por padrão, os discos do nó do trabalhador são criptografados, seu hardware é compartilhado por múltiplos clientes da IBM e são faturados por horas de uso. </br>Exemplo para um cluster padrão. Especifique as opções do cluster:

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        Exemplo para um cluster grátis. Especifique o nome do cluster:

        ```
        ibmcloud ks cluster-create --name my_cluster
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
        <td>O comando para criar um cluster na organização do {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**Clusters padrão**: substitua <em>&lt;zone&gt;</em> pelo ID de zona do {{site.data.keyword.Bluemix_notm}} no qual você deseja criar o seu cluster. As zonas disponíveis dependem da região do {{site.data.keyword.containerlong_notm}} em que você efetuou login.<br></br>**Nota**: os nós do trabalhador do cluster são implementados nessa zona. Para abranger seu cluster entre zonas, deve-se criar o cluster em uma [zona com capacidade para múltiplas zonas](cs_regions.html#zones). Após o cluster ser criado, é possível [incluir uma zona no cluster](#add_zone).</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Clusters padrão**: escolha um tipo de máquina. É possível implementar os nós do trabalhador como máquinas virtuais em hardware compartilhado ou dedicado ou como máquinas físicas no bare metal. Os tipos de máquinas físicas e virtuais disponíveis variam de acordo com a zona na qual você implementa o cluster. Para obter mais informações, consulte a documentação para o comando `ibmcloud ks machine-type` [](cs_cli_reference.html#cs_machine_types). Para clusters livres, não é necessário definir o tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Somente clusters padrão virtuais**: o nível de isolamento de hardware para seu nó do trabalhador. Use dedicado para disponibilizar recursos físicos disponíveis apenas para você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes da IBM. O padrão é shared. Esse valor é opcional para clusters padrão e não está disponível para clusters livres.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Clusters grátis**: você não precisa definir uma VLAN pública. O cluster grátis é conectado automaticamente a uma VLAN pública que é de propriedade da IBM.</li>
          <li>**Clusters padrão**: se você já tiver uma VLAN pública configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para essa zona, insira o ID da VLAN pública. Se você deseja conectar seus nós do trabalhador somente a uma VLAN privada, não especifique esta opção. **Nota**: se os nós do trabalhador estiverem configurados com apenas uma VLAN privada, será necessário configurar uma solução alternativa para conectividade de rede. Para obter mais informações, veja [Planejando a rede de cluster somente privada](cs_network_cluster.html#private_vlan).<br/><br/>
          <strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). Ao criar um cluster e especificar as VLANs públicas e privadas, o número e a combinação de letras após esses prefixos devem corresponder.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Clusters grátis**: você não precisa definir uma VLAN privada. O cluster grátis é conectado automaticamente a uma VLAN privada que é de propriedade da IBM.</li><li>**Clusters padrão**: se você já tiver uma VLAN privada configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para essa zona, insira o ID da VLAN privada. Se você não tem uma VLAN privada em sua conta, não especifique esta opção. O {{site.data.keyword.containerlong_notm}} cria automaticamente uma VLAN privada para você.<br/><br/><strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). Ao criar um cluster e especificar as VLANs públicas e privadas, o número e a combinação de letras após esses prefixos devem corresponder.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Clusters grátis e padrão**: substitua <em>&lt;name&gt;</em> por um nome para seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e hífen (-) e deve ter 35 caracteres ou menos. O nome do cluster e a região na qual o cluster está implementado formam o nome completo do domínio para o subdomínio do Ingress. Para assegurar que o subdomínio do Ingress seja exclusivo dentro de uma região, o nome do cluster pode ser truncado e anexado com um valor aleatório dentro do nome de domínio do Ingress.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Clusters padrão**: o número de nós do trabalhador para incluir no cluster. Se a opção <code>--workers</code> não for especificada, um nó do trabalhador será criado.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Clusters padrão**: a versão do Kubernetes para o nó principal do cluster. Esse valor é opcional. Quando a versão não for especificada, o cluster será criado com o padrão de versões do Kubernetes suportadas. Para ver as versões disponíveis, execute <code>ibmcloud ks kube-versions</code>.
</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Clusters grátis e padrão**: os nós do trabalhador apresentam criptografia de disco por padrão; [saiba mais](cs_secure.html#encrypted_disk). Se desejar desativar a criptografia, inclua esta opção.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Clusters bare metal padrão**: ative [Cálculo confiável](cs_secure.html#trusted_compute) para verificar seus nós do trabalhador bare metal com relação à violação. O Cálculo confiável está disponível para selecionar tipos de máquina bare metal. Por exemplo, os tipos GPU `mgXc` não suportam o Cálculo confiável. Se você não ativar a confiança durante a criação do cluster, mas desejar posteriormente, será possível usar o comando `ibmcloud ks feature-enable` [](cs_cli_reference.html#cs_cluster_feature_enable). Depois de ativar a confiança, não é possível desativá-la posteriormente.</td>
        </tr>
        </tbody></table>

4.  Verifique se a criação do cluster foi solicitada.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    **Nota:** para máquinas virtuais, pode levar alguns minutos para as máquinas do nó do trabalhador serem pedidas e para o cluster ser configurado e provisionado em sua conta. As máquinas físicas bare metal são provisionadas pela interação manual com a infraestrutura do IBM Cloud (SoftLayer) e podem levar mais de um dia útil para serem concluídas.

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.

    ```
    Name ID State Created Workers Zone Version my_cluster paf97e8843e29941b49c598f516de72101 deployed 20170201162433 1 mil01 1.10.7
    ```
    {: screen}

5.  Verifique o status dos nós do trabalhador.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster.

    **Nota:** a cada nó do trabalhador é designado um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.

    ```
    ID Public IP Private IP Machine Type State Status Zone Version kube-mil01-paf97e8843e29941b49c598f516de72101-w1 169.xx.xxx.xxx 10.xxx.xx.xxx free normal Ready mil01 1.10.7
    ```
    {: screen}

6.  Configure o cluster criado como o contexto para esta sessão. Conclua estas etapas de configuração toda vez que você trabalhar com o seu cluster.
    1.  Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração do Kubernetes.

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

        Exemplo para OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

7.  Ative seu painel do Kubernetes com a porta padrão `8001`.
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


**O que vem a seguir?**

-   Espalhe nós do trabalhador ao longo de múltiplas zonas [incluindo uma zona em seu cluster](#add_zone).
-   [Implementar um app no cluster.](cs_app.html#app_cli)
-   [Gerenciar seu cluster com a linha de comandos de `kubectl`. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)
- Se você tiver um firewall, poderá ser necessário [abrir as portas necessárias](cs_firewall.html#firewall) para usar os comandos `ibmcloud`, `kubectl` ou `calicotl`, para permitir o tráfego de saída de seu cluster ou para permitir o tráfego de entrada para serviços de rede.
-  Clusters com o Kubernetes versão 1.10 ou mais recente: controle quem pode criar pods em seu cluster com [políticas de segurança de pod](cs_psp.html).

<br />



## Incluindo nós do trabalhador e zonas em clusters
{: #add_workers}

Para aumentar a disponibilidade de seus apps, é possível incluir nós do trabalhador em uma zona existente ou em múltiplas zonas existentes em seu cluster. Para ajudar a proteger seus apps contra falhas de zona, é possível incluir zonas em seu cluster.
{:shortdesc}

Quando você cria um cluster, os nós do trabalhador são provisionados em um conjunto de trabalhadores. Após a criação do cluster, é possível incluir mais nós do trabalhador em um conjunto, redimensionando-o ou incluindo mais conjuntos de trabalhadores. Por padrão, o conjunto de trabalhadores existe em uma zona. Os clusters que têm um conjunto de trabalhadores em somente uma zona são chamados de clusters de zona única. Quando você incluir mais zonas no cluster, o conjunto de trabalhadores existirá entre as zonas. Os clusters que têm um conjunto de trabalhadores que é difundido em mais de uma zona são chamados de clusters de múltiplas zonas.

Se você tiver um cluster de múltiplas zonas, mantenha seus recursos do nó do trabalhador balanceados. Certifique-se de que todos os conjuntos de trabalhadores estejam difundidos pelas mesmas zonas e inclua ou remova os trabalhadores redimensionando os conjuntos em vez de incluir nós individuais.
{: tip}

As seções a seguir mostram como:
  * [Incluir nós do trabalhador redimensionando um conjunto de trabalhadores existente em seu cluster](#resize_pool)
  * [Incluir nós do trabalhador incluindo um conjunto de trabalhadores em seu cluster](#add_pool)
  * [Incluir uma zona em seu cluster e replicar os nós do trabalhador em seus conjuntos de trabalhadores em múltiplas zonas](#add_zone)
  * [Descontinuado: incluir um nó do trabalhador independente em um cluster](#standalone)


### Incluindo nós do trabalhador redimensionando um conjunto de trabalhadores existente
{: #resize_pool}

É possível incluir ou reduzir o número de nós do trabalhador em seu cluster, redimensionando um conjunto de trabalhadores existente, independentemente de se o conjunto de trabalhadores está em uma zona ou difundido entre múltiplas zonas.
{: shortdesc}

Por exemplo, considere um cluster com um conjunto de trabalhadores que tenha três nós do trabalhador por zona.
* Se o cluster for uma zona única e existir em `dal10`, o conjunto de trabalhadores terá três nós do trabalhador em `dal10`. O cluster tem um total de três nós do trabalhador.
* Se o cluster for de múltiplas zonas e existir em `dal10` e `dal12`, o conjunto de trabalhadores terá três nós do trabalhador em `dal10` e três nós do trabalhador em `dal12`. O cluster terá um total de seis nós do trabalhador.

Para conjuntos de trabalhadores bare metal, tenha em mente que o faturamento é mensal. Se você redimensionar para cima ou para baixo, isso impactará os seus custos para o mês.
{: tip}

Para redimensionar o conjunto de trabalhadores, mude o número de nós do trabalhador que o conjunto de trabalhadores implementa em cada zona:

1. Obtenha o nome do conjunto de trabalhadores que você deseja redimensionar.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Redimensione o conjunto de trabalhadores designando o número de nós do trabalhador que você deseja implementar em cada zona. O valor mínimo é 1.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Verifique se o conjunto de trabalhadores está redimensionado.
    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Saída de exemplo para um conjunto de trabalhadores que está em duas zonas, `dal10` e `dal12`, e é redimensionado para dois nós do trabalhador por zona:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Incluindo nós do trabalhador criando um novo conjunto de trabalhadores
{: #add_pool}

É possível incluir nós do trabalhador em seu cluster, criando um novo conjunto de trabalhadores.
{:shortdesc}

1. Liste as zonas disponíveis e escolha a zona na qual você deseja implementar os nós do trabalhador em seu conjunto de trabalhadores. Se você planeja difundir seus nós do trabalhador em múltiplas zonas, escolha uma [zona com capacidade para múltiplas zonas](cs_regions.html#zones).
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Para cada zona, liste as VLANs privadas e públicas disponíveis. Observe a VLAN privada e a VLAN pública que você deseja usar. Se você não tiver uma VLAN privada ou pública, ela será criada automaticamente quando você incluir uma zona em seu conjunto de trabalhadores.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Crie um conjunto de trabalhadores. Para opções de tipo de máquina, revise a documentação do [comando `machine-types`](cs_cli_reference.html#cs_machine_types).
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

4. Verifique se o conjunto de trabalhadores foi criado.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

5. Por padrão, incluir um conjunto de trabalhadores cria um conjunto sem zonas. Para implementar nós do trabalhador em uma zona, deve-se incluir zonas no conjunto de trabalhadores. Se você deseja difundir os nós do trabalhador em múltiplas zonas, repita esse comando com uma zona com capacidade para múltiplas zonas.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

6. Verifique se os nós do trabalhador são provisionados na zona que você incluiu.
   ```
   ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Saída de exemplo:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Incluindo nós do trabalhador incluindo uma zona em um conjunto de trabalhadores
{: #add_zone}

É possível estender seu cluster entre múltiplas zonas em uma região incluindo uma zona em seu conjunto de trabalhadores existente.
{:shortdesc}

Quando você inclui uma zona em um conjunto de trabalhadores, os nós do trabalhador que estão definidos em seu conjunto de trabalhadores são provisionados na nova zona e considerados para planejamento futuro de carga de trabalho. O {{site.data.keyword.containerlong_notm}} inclui automaticamente o rótulo `failure-domain.beta.kubernetes.io/region` para a região e o rótulo `failure-domain.beta.kubernetes.io/zone` para a zona em cada nó do trabalhador. O planejador do Kubernetes usa esses rótulos para difundir pods ao longo de zonas dentro da mesma região.

**Nota**: se você tiver múltiplos conjuntos de trabalhadores em seu cluster, inclua a zona em todos eles para que os nós do trabalhador sejam difundidos uniformemente em seu cluster.

Antes de iniciar:
*  Para incluir uma zona em seu conjunto de trabalhadores, o conjunto de trabalhadores deve estar em uma [zona com capacidade de múltiplas zonas](cs_regions.html#zones). Se o seu conjunto de trabalhadores não estiver em uma zona com capacidade de múltiplas zonas, considere [criar um novo conjunto de trabalhadores](#add_pool).
*  Se você tem múltiplas VLANs para um cluster, múltiplas sub-redes na mesma VLAN ou um cluster multizona, deve-se ativar o [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para sua conta de infraestrutura do IBM Cloud (SoftLayer) para que os nós do trabalhador possam se comunicar entre si na rede privada. Para executar essa ação, você precisa da [permissão de infraestrutura](cs_users.html#infra_access) **Rede > Gerenciar rede VLAN Spanning** ou é possível solicitar ao proprietário da conta para ativá-la. Para verificar se o VLAN Spanning já está ativado, use o [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se você está usando o {{site.data.keyword.BluDirectLink}}, deve-se usar um [ Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para ativar o VRF, entre em contato com o representante de conta da infraestrutura do IBM Cloud (SoftLayer).

Para incluir uma zona com nós do trabalhador em seu conjunto de trabalhadores:

1. Liste as zonas disponíveis e escolha a zona que você deseja incluir em seu conjunto de trabalhadores. A zona que você escolhe deve ser uma zona com capacidade para múltiplas zonas.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Listar VLANs disponíveis nessa zona. Se você não tiver uma VLAN privada ou pública, ela será criada automaticamente quando você incluir uma zona em seu conjunto de trabalhadores.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Liste os conjuntos de trabalhadores em seu cluster e anote seus nomes.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Inclua a zona em seu conjunto de trabalhadores. Se você tiver múltiplos conjuntos de trabalhadores, inclua a zona em todos os seus conjuntos de trabalhadores para que o seu cluster seja balanceado em todas as zonas. Substitua `<pool1_id_or_name,pool2_id_or_name,...>` pelos nomes de todos os conjuntos de trabalhadores em uma lista separada por vírgula. </br>**Nota:** uma VLAN privada e uma pública devem existir antes que seja possível incluir uma zona em múltiplos conjuntos de trabalhadores. Se não houver uma VLAN privada e uma pública nessa zona, inclua a zona em um conjunto de trabalhadores primeiro para que uma VLAN privada e uma pública sejam criadas para você. Em seguida, é possível incluir a zona em outros conjuntos de trabalhadores especificando a VLAN privada e a pública que foram criadas para você.

   Se você desejar usar VLANs diferentes para diferentes conjuntos de trabalhadores, repita este comando para cada VLAN e os seus conjuntos de trabalhadores correspondentes. Todos os novos nós do trabalhador são incluídos nas VLANs especificadas, mas as VLANs para quaisquer nós do trabalhador existentes não mudam.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. Verifique se a zona foi incluída em seu cluster. Procure a zona incluída no campo **Zonas do trabalhador** da saída. Observe que o número total de trabalhadores no campo **Trabalhadores** aumentou porque novos nós do trabalhador são provisionados na zona incluída.
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Saída de exemplo:
    ```
    Name:               mycluster
    ID:                 a20a637238aa471f8d4a8b881aaa4988
    State:              normal
    Created:            2018-04-19T01:49:22+0000
    Master zone:    us-south
    Worker zones:       dal10,dal12
    Master URL:         https://169.xx.xxx.xxx:21111
    Ingress subdomain:  ...
    Ingress secret:     ...
    Workers:            6
    Version:            1.8.6_1504
    ```
    {: screen}  

### Descontinuado: Incluindo nós do trabalhador independentes
{: #standalone}

Se você tem um cluster que foi criado antes de os conjuntos de trabalhadores serem introduzidos, é possível usar os comandos descontinuados para incluir nós do trabalhador independentes.
{: shortdesc}

**Nota:** se você tem um cluster que foi criado depois que os conjuntos de trabalhadores foram introduzidos, não é possível incluir nós do trabalhador independentes. Como alternativa, é possível [criar um conjunto de trabalhadores](#add_pool), [redimensionar um conjunto de trabalhadores existente](#resize_pool) ou [incluir uma zona em um conjunto de trabalhadores](#add_zone) para incluir nós do trabalhador em seu cluster.

1. Liste as zonas disponíveis e escolha a zona na qual você deseja incluir nós do trabalhador.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Liste as VLANs disponíveis nessa zona e anote seus IDs.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Liste os tipos de máquina disponíveis nessa zona.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

4. Inclua nós do trabalhador independentes no cluster.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. Verifique se os nós do trabalhador estão criados.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}



## Visualizando estados do cluster
{: #states}

Revise o estado de um cluster do Kubernetes para obter informações sobre a disponibilidade e a capacidade do cluster, além de problemas em potencial que possam ter ocorrido.
{:shortdesc}

Para visualizar informações sobre um cluster específico, como suas zonas, a URL principal, o subdomínio do Ingress, a versão, o proprietário e o painel de monitoramento, use o [comando](cs_cli_reference.html#cs_cluster_get) `ibmcloud ks cluster-get <cluster_name_or_ID>`. Inclua a sinalização `--showResources` para visualizar mais recursos de cluster, como complementos para os pods de armazenamento ou VLANs de sub-rede para IPs públicos e privados.

É possível visualizar o estado do cluster atual, executando o comando `ibmcloud ks clusters` e localizando o campo **Estado**. Para solucionar problemas de seu cluster e nós do trabalhador, veja [Resolução de problemas de clusters](cs_troubleshoot.html#debug_clusters).

<table summary="Cada linha da tabela deve ser lida da esquerda para a direita, com o estado do cluster na coluna um e uma descrição na coluna dois.">
<caption>Estados do cluster</caption>
   <thead>
   <th>Estado do cluster</th>
   <th>Descrição</th>
   </thead>
   <tbody>
<tr>
   <td>Interrompido</td>
   <td>A exclusão do cluster é solicitada pelo usuário antes da implementação do mestre do Kubernetes. Depois que a exclusão do cluster é concluída, o cluster é removido do painel. Se o seu cluster estiver preso nesse estado por muito tempo, abra um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
 <tr>
     <td>Crítico</td>
     <td>O mestre do Kubernetes não pode ser atingido ou todos os nós do trabalhador no cluster estão inativos. </td>
    </tr>
   <tr>
     <td>Exclusão com falha</td>
     <td>O mestre do Kubernetes ou pelo menos um nó do trabalhador não pode ser excluído.  </td>
   </tr>
   <tr>
     <td>Excluído</td>
     <td>O cluster foi excluído, mas ainda não foi removido de seu painel. Se o seu cluster estiver preso nesse estado por muito tempo, abra um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Exclusão</td>
   <td>O cluster está sendo excluído e a infraestrutura de cluster está sendo desmantelada. Não é possível acessar o cluster.  </td>
   </tr>
   <tr>
     <td>Implementação com falha</td>
     <td>A implementação do mestre do Kubernetes não pôde ser concluída. Não é possível resolver esse estado. Entre em contato com o suporte do IBM Cloud abrindo um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Implementando</td>
       <td>O mestre do Kubernetes não está totalmente implementado ainda. Não é possível acessar seu cluster. Aguarde até que seu cluster seja totalmente implementado para revisar seu funcionamento.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos os nós do trabalhador em um cluster estão funcionando. É possível acessar o cluster e implementar apps no cluster. Esse estado é considerado funcional e não requer uma ação sua. **Nota**: embora os nós do trabalhador possam ser normais, outros recursos de infraestrutura, como [redes](cs_troubleshoot_network.html) e [armazenamento](cs_troubleshoot_storage.html), ainda podem precisar de atenção.</td>
    </tr>
      <tr>
       <td>Pendente</td>
       <td>O mestre do Kubernetes foi implementado. Os nós do trabalhador estão sendo provisionados e ainda não estão disponíveis no cluster. É possível acessar o cluster, mas não é possível implementar apps no cluster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Uma solicitação para criar o cluster e pedir a infraestrutura para os nós principal e do trabalhador do Kubernetes é enviada. Quando a implementação do cluster é iniciada, o estado do cluster muda para <code>Deploying</code>. Se o seu cluster estiver preso no estado <code>Requested</code> por muito tempo, abra um chamado de suporte do [{{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Atualizando</td>
     <td>O servidor da API do Kubernetes executado no mestre do Kubernetes está sendo atualizado para uma nova versão de API do Kubernetes. Durante a atualização, não é possível acessar nem mudar o cluster. Nós do trabalhador, apps e recursos implementados pelo usuário não são modificados e continuarão a ser executados. Aguarde a atualização ser concluída para revisar o funcionamento de seu cluster. </td>
   </tr>
    <tr>
       <td>Avisar</td>
       <td>Pelo menos um nó do trabalhador no cluster não está disponível, mas outros nós do trabalhador estão disponíveis e podem assumir o controle da carga de trabalho. </td>
    </tr>
   </tbody>
 </table>


<br />


## Removendo Clusters
{: #remove}

Os clusters grátis e padrão criados com uma conta pré-paga deverão ser removidos manualmente quando não forem mais necessários, para que não consumam mais recursos.
{:shortdesc}

**Aviso:
**
  - Nenhum backup é criado de seu cluster ou dos dados no armazenamento persistente. A exclusão de um cluster ou do armazenamento persistente é permanente e não pode ser desfeita.
  - Ao remover um cluster, você também remove quaisquer sub-redes que foram provisionadas automaticamente ao criar o cluster e que foram criadas usando o comando `ibmcloud ks cluster-subnet-create`. No entanto, se você incluiu manualmente as sub-redes existentes em seu cluster usando o comando `ibmcloud ks cluster-subnet-subnet-add`, essas sub-redes não são removidas de sua conta de infraestrutura do IBM Cloud (SoftLayer) e é possível reutilizá-las em outros clusters.

Antes de iniciar:
* Anote o ID do cluster. Você pode precisar do ID do cluster para investigar e remover os recursos da infraestrutura do IBM Cloud (SoftLayer) relacionados que não são excluídos automaticamente com seu cluster.
* Se você desejar excluir os dados em seu armazenamento persistente, [entenda as opções de exclusão](cs_storage_remove.html#cleanup).

Para remover um cluster:

-   Por meio da GUI do {{site.data.keyword.Bluemix_notm}}
    1.  Selecione seu cluster e clique em **Excluir** no menu **Mais ações...**.

-   No {{site.data.keyword.Bluemix_notm}} CLI
    1.  Liste os clusters disponíveis.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Exclua o cluster.

        ```
        ibmcloud ks cluster-rm <cluster_name_or_ID>
        ```
        {: pre}

    3.  Siga os prompts e escolha se deseja excluir recursos de cluster, que inclui contêineres, pods, serviços de limite, armazenamento persistente e segredos.
      - **Armazenamento persistente**: o armazenamento persistente fornece alta disponibilidade para seus dados. Se você criou uma solicitação de volume persistente usando um [compartilhamento de arquivo existente](cs_storage_file.html#existing_file), não será possível excluir o compartilhamento de arquivo quando excluir o cluster. Deve-se excluir manualmente o compartilhamento de arquivo posteriormente de seu portfólio de infraestrutura do IBM Cloud (SoftLayer).

          **Nota**: devido ao ciclo de faturamento mensal, uma solicitação de volume persistente não pode ser excluída no último dia de um mês. Se você excluir a solicitação de volume persistente no último dia do mês, a exclusão permanecerá pendente até o início do mês seguinte.

Próximas etapas:
- Depois que ele não estiver mais listado na lista de clusters disponíveis quando você executar o comando `ibmcloud ks clusters`, será possível reutilizar o nome de um cluster removido.
- Se você tiver mantido as sub-redes, será possível [reutilizá-las em um novo cluster](cs_subnets.html#custom) ou excluí-las manualmente mais tarde de seu portfólio de infraestrutura do IBM Cloud (SoftLayer).
- Se você manteve o armazenamento persistente, será possível [excluir seu armazenamento](cs_storage_remove.html#cleanup) posteriormente por meio do painel de infraestrutura do IBM Cloud (SoftLayer) na GUI do {{site.data.keyword.Bluemix_notm}}.
