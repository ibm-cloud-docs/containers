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


# Configurando clusters
{: #clusters}

Projete a sua configuração de cluster do Kubernetes para máxima disponibilidade e capacidade do contêiner com o {{site.data.keyword.containerlong}}.
{:shortdesc}

## Planejamento de configuração de cluster
{: #planning_clusters}

Use clusters padrão para aumentar a disponibilidade do app.
{:shortdesc}

É menos provável que seus usuários
experimentem tempo de inatividade quando você distribuir a configuração entre múltiplos nós do trabalhador e clusters. Recursos integrados, como balanceamento de carga e isolamento, aumentam a resiliência com relação a potenciais
falhas com hosts, redes ou apps.

Revise estas potenciais configurações de cluster que são ordenadas com graus crescentes de
disponibilidade:

![Estágios de alta disponibilidade para um cluster](images/cs_cluster_ha_roadmap.png)

1.  Um cluster com múltiplos nós do trabalhador
2.  Dois clusters que são executados em diferentes locais na mesma região, cada um com
múltiplos nós do trabalhador
3.  Dois clusters que são executados em diferentes regiões, cada um com múltiplos nós do trabalhador

Aumente a disponibilidade de seu cluster com estas técnicas:

<dl>
<dt>Difundir apps pelos nós do trabalhador</dt>
<dd>Permita que os desenvolvedores difundam seus apps em contêineres em múltiplos nós do trabalhador por cluster. Uma instância de aplicativo em cada um dos três nós do trabalhador permite o tempo de inatividade de um nó do trabalhador, sem interromper o uso do aplicativo. É possível especificar quantos nós do trabalhador incluir ao criar um cluster por meio da [GUI do {{site.data.keyword.Bluemix_notm}}](cs_clusters.html#clusters_ui) ou da [CLI](cs_clusters.html#clusters_cli). O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster, portanto, lembre-se do [nó do trabalhador e das cotas de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/cluster-large/).
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>Difundir apps entre clusters</dt>
<dd>Crie múltiplos clusters, cada um com múltiplos nós do trabalhador. Se uma indisponibilidade ocorrer com o
cluster, ainda assim os usuários poderão acessar um app que também esteja implementado em outro cluster.
<p>Cluster
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Cluster
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>Difundir apps entre clusters em diferentes regiões</dt>
<dd>Ao difundir aplicativos entre clusters em diferentes regiões, será possível permitir que o balanceamento de carga ocorra com base na região em que o usuário está. Se o cluster, hardware ou até mesmo um local inteiro em
uma região ficar inativo, o tráfego será roteado para o contêiner que estiver implementado em outro local.
<p><strong>Importante:</strong> depois de configurar um domínio customizado, você poderá usar esses comandos para criar os clusters.</p>
<p>Local 1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Local 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />





## Planejamento de configuração de nó do trabalhador
{: #planning_worker_nodes}

Um cluster do Kubernetes consiste em nós do trabalhador e é monitorado e gerenciado centralmente pelo mestre do Kubernetes. Os administradores de cluster decidem como configurar o cluster de nós do trabalhador para assegurar que os usuários do cluster tenham todos os recursos para implementar e executar apps no cluster.
{:shortdesc}

Ao criar um cluster padrão, os nós do trabalhador são pedidos na infraestrutura do IBM Cloud (SoftLayer) em seu nome e incluídos no conjunto de nós do trabalhador padrão em seu cluster. A cada nó do trabalhador é designado
um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados após a criação do cluster.

É possível escolher entre servidores virtuais ou físicos (bare metal). Dependendo do nível de isolamento de hardware escolhido, os nós do trabalhador virtual podem ser configurados como nós compartilhados ou dedicados. Também é possível escolher se você deseja que os nós do trabalhador se conectem a uma VLAN pública e VLAN privada ou somente a uma VLAN privada. Cada
nó do trabalhador é provisionado com um tipo específico de máquina que determina o número de vCPUs, memória
e espaço em disco que estão disponíveis para os contêineres que são implementados no nó do trabalhador. O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster. Revise [cotas de nó do trabalhador e de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/cluster-large/) para obter mais informações.





### Hardware para nós do trabalhador
{: #shared_dedicated_node}

Ao criar um cluster padrão no {{site.data.keyword.Bluemix_notm}}, você escolhe provisionar seus nós do trabalhador como máquinas físicas (bare metal) ou como máquinas virtuais que são executadas no hardware físico. Ao criar um cluster grátis, seu nó do trabalhador é provisionado automaticamente como um nó virtual compartilhado na conta de infraestrutura do IBM Cloud (SoftLayer).
{:shortdesc}

![Opções de hardware para nós do trabalhador em um cluster padrão](images/cs_clusters_hardware.png)

<dl>
<dt>Máquinas físicas (bare metal)</dt>
<dd>É possível provisionar o nó do trabalhador como um servidor físico de único locatário, também referido como bare metal. O bare metal dá acesso direto aos recursos físicos na máquina, como a memória ou CPU. Essa configuração elimina o hypervisor da máquina virtual que aloca recursos físicos para máquinas virtuais executadas no host. Em vez disso, todos os recursos de uma máquina bare metal são dedicados exclusivamente ao trabalhador, portanto, você não precisará se preocupar com "vizinhos barulhentos" compartilhando recursos ou diminuindo o desempenho.
<p><strong>Faturamento mensal</strong>: os servidores bare metal são mais caros do que os virtuais e são mais adequados para aplicativos de alto desempenho que precisam de mais recursos e controle do host. Os servidores bare metal são faturados mensalmente. Se você cancelar um servidor bare metal antes do final do mês, será cobrado até o final do mês. Ao provisionar servidores bare metal, você interage diretamente com a infraestrutura do IBM Cloud (SoftLayer) e assim, esse processo manual pode levar mais de um dia útil para ser concluído.</p>
<p><strong>Opção para ativar o Cálculo confiável</strong>: somente em nós do trabalhador bare metal selecionados que executam o Kubernetes versão 1.9 ou mais recente, é possível ativar o Cálculo confiável para verificar os nós do trabalhador com relação à violação. Se você não ativar a confiança durante a criação do cluster, mas quiser fazer isso mais tarde, será possível usar o [comando](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Depois de ativar a confiança, não é possível desativá-la posteriormente. Para obter mais informações sobre como a confiança funciona durante o processo de inicialização do nó, veja [{{site.data.keyword.containershort_notm}} com Cálculo confiável](cs_secure.html#trusted_compute). Quando você executa o [comando](cs_cli_reference.html#cs_machine_types) `bx cs machine-types <location>`, é possível ver quais máquinas suportam confiança, revisando o campo `Confiável`.</p>
<p><strong>Grupos do tipo de máquina bare metal</strong>: os tipos de máquina bare metal vêm em grupos com recursos de cálculo diferentes, e é possível escolher um deles para atender às necessidades de seu aplicativo. Os tipos de máquina física têm armazenamento local mais alto do que os virtuais e alguns têm RAID para fazer backup de dados locais. Para aprender sobre os diferentes tipos de ofertas bare metal, veja o [comando](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`.
<ul><li>`mb1c`: escolha este tipo para uma configuração balanceada de recursos da máquina física para seus nós do trabalhador. Este tipo inclui acesso às redes Duais Redundantes de 10 GBps e a uma configuração de HDD de SSD dual. Ele geralmente apresenta um disco de armazenamento primário de 1 TB e um disco secundário de 1,7 ou 2 TB.</li>
<li>`mr1c`: escolha este tipo para maximizar a RAM disponível para seus nós do trabalhador.</li>
<li>`md1c`: escolha este tipo se seus nós do trabalhador requerem uma quantia significativa de armazenamento em disco local, incluindo RAID para fazer backup dos dados armazenados localmente na máquina. Os discos de armazenamento primário de 1 TB são configurados para RAID1 e os discos de armazenamento secundário de 4 TB são configurados para RAID10.</li>

</ul></p></dd>
<dt>Máquinas virtuais</dt>
<dd>Ao criar um cluster virtual padrão, deve-se escolher se deseja que o hardware subjacente seja compartilhado por múltiplos clientes {{site.data.keyword.IBM_notm}} (ocupação variada) ou seja dedicado somente a você (ocupação única).
<p>Em uma configuração de diversos locatários, os recursos físicos, como CPU e memória, são compartilhados entre todas as
máquinas virtuais implementadas no mesmo hardware físico. Para assegurar que cada máquina
virtual possa ser executada independentemente, um monitor de máquina virtual, também referido como hypervisor,
segmenta os recursos físicos em entidades isoladas e aloca como recursos dedicados para
uma máquina virtual (isolamento de hypervisor).</p>
<p>Em uma configuração de locatário único, todos os recursos físicos são dedicados somente a você. É possível implementar
múltiplos nós do trabalhador como máquinas virtuais no mesmo host físico. Semelhante à configuração de diversos locatários,
o hypervisor assegura que cada nó do trabalhador obtenha seu compartilhamento dos recursos físicos
disponíveis.</p>
<p>Os nós compartilhados são geralmente mais baratos do que os nós dedicados porque os custos para o hardware
subjacente são compartilhados entre múltiplos clientes. No entanto, ao decidir entre nós compartilhados
e dedicados, você pode desejar verificar com seu departamento jurídico para discutir o nível de isolamento
e conformidade de infraestrutura que seu ambiente de app requer.</p></dd>
</dl>

Os tipos de máquinas físicas e virtuais disponíveis variam pelo local no qual o cluster é implementado. Para obter mais informações, veja o [comando](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. É possível implementar clusters usando a [UI do console](#clusters_ui) ou a [CLI](#clusters_cli).

### Conexão VLAN para nós do trabalhador
{: #worker_vlan_connection}

Ao criar um cluster, cada cluster é conectado automaticamente a uma VLAN de sua conta de infraestrutura do IBM Cloud (SoftLayer).
{:shortdesc}

Uma VLAN configura um grupo de
nós do trabalhador e pods como se eles estivessem conectados à mesma ligação física. A VLAN privada determina o endereço IP privado que é designado a um nó do trabalhador durante a criação de cluster e a VLAN pública determina o endereço IP público que é designado a um nó do trabalhador durante a criação de cluster.

Para clusters grátis, os nós do trabalhador do cluster são conectados a uma VLAN pública e VLAN privada pertencentes à IBM por padrão durante a criação de cluster. Para clusters padrão, deve-se conectar os seus nós do trabalhador a uma VLAN privada. É possível conectar seus nós do trabalhador a uma VLAN pública e à VLAN privada ou somente à VLAN privada. Se você deseja conectar seus nós do trabalhador somente a uma VLAN privada, é possível designar o ID de uma VLAN privada existente durante a criação do cluster ou [criar uma nova VLAN privada](/docs/cli/reference/softlayer/index.html#sl_vlan_create). No entanto, também deve-se configurar uma solução alternativa para permitir uma conexão segura entre os nós do trabalhador e o mestre do Kubernetes. Por exemplo, é possível configurar um Vyatta para passar tráfego dos nós do trabalhador da VLAN privada para o mestre do Kubernetes. Veja "Configurar um Vyatta customizado para conectar seus nós do trabalhador ao mestre do Kubernetes com segurança" na [documentação da infraestrutura do IBM Cloud (SoftLayer)o](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta) para obter mais informações.

**Nota**: se você tem múltiplas VLANs para um cluster ou múltiplas redes na mesma VLAN, deve-se ativar a ampliação da VLAN para que seus nós do trabalhador possam se comunicar uns com os outros na rede privada. Para obter instruções, veja [Ativar ou desativar a ampliação de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).

### Limites de memória do nó do trabalhador
{: #resource_limit_node}

O {{site.data.keyword.containershort_notm}} configura um limite de memória em cada nó do trabalhador. Quando os pods que estão em execução no nó do trabalhador excedem esse limite de memória, os pods são removidos. No Kubernetes, esse limite é chamado de [limite máximo de despejo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Se os pods são removidos frequentemente, inclua mais nós do trabalhador em seu cluster ou configure [limites de recursos ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) em seu pods.

Cada tipo de máquina tem uma capacidade de memória diferente. Quando há menos memória disponível no nó do trabalhador do que o limite mínimo que é permitido, o Kubernetes remove imediatamente o pod. O pod reagenda em outro nó do trabalhador se um nó do trabalhador está disponível.

|Capacidade de memória do nó do trabalhador|Limite mínimo de memória de um nó do trabalhador|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB | 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

Para revisar quanta memória é usada em seu nó do trabalhador, execute [kubectl top node ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top).

### Recuperação automática para seus nós do trabalhador
`Docker`, `kubelet`, `kube-proxy` e `calico` são componentes críticos que devem ser funcionais para ter um nó do trabalhador do Kubernetes saudável. Com o tempo, esses componentes podem se dividir e podem deixar o nó do trabalhador em um estado não funcional. Os nós do trabalhador não funcionais diminuem a capacidade total do cluster e podem resultar em tempo de inatividade para seu app.

É possível [configurar verificações de funcionamento para seu nó do trabalhador e ativar a Recuperação automática](cs_health.html#autorecovery). Se a Recuperação automática detecta um nó do trabalhador que não está saudável com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Para obter mais informações sobre como a Recuperação automática funciona, veja o [blog de Recuperação automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />



## Criando clusters com a GUI
{: #clusters_ui}

O propósito do cluster do Kubernetes é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

Antes de iniciar, deve-se ter uma [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) Pay-As-You-Go ou de Assinatura. É possível criar 1 cluster grátis para experimentar alguns dos recursos ou criar clusters padrão para clusters totalmente customizáveis com sua opção de isolamento de hardware.

Para criar um cluster:

1. No catálogo, selecione **Kubernetes Cluster**.

2. Selecione uma região no qual implementar o cluster.

3. Selecione um tipo de plano de cluster. É possível escolher **Grátis** ou **Padrão**. Com um cluster padrão, você tem acesso a recursos como múltiplos nós do trabalhador para um ambiente altamente disponível.

4. Configure os detalhes do seu cluster.

    1. **Grátis e padrão**: forneça um nome ao seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e - e deve ter 35 caracteres ou menos. Observe que o subdomínio do Ingresso designado à {{site.data.keyword.IBM_notm}} é derivado do nome do cluster. O nome do cluster e o subdomínio do Ingresso juntos formam o nome completo do domínio, que deve ser exclusivo dentro de uma região e ter 63 caracteres ou menos. Para atender a esses requisitos, o nome do cluster pode ser truncado ou o subdomínio pode ser designado a valores de caractere aleatórios.

    2. **Padrão**: escolha uma versão do Kubernetes e selecione um local no qual implementar o cluster. Para o melhor desempenho, selecione o local que é fisicamente mais próximo de você. Lembre-se de que uma autorização jurídica poderá ser requerida para que os dados possam ser armazenados fisicamente em um país estrangeiro se você selecionar um local que está fora de seu país.

    3. **Padrão**: selecione um tipo de isolamento de hardware. Virtual é faturado por hora e bare metal é faturado mensalmente.

        - **Virtual - Dedicado**: os seus nós do trabalhador são hospedados na infraestrutura que é dedicada à sua conta. Os seus recursos físicos estão completamente isolados.

        - **Virtual - Compartilhado**: os recursos de infraestrutura, como o hypervisor e hardware físico, são compartilhados entre você e outros clientes IBM, mas cada nó do trabalhador é acessível somente por você. Embora essa opção seja menos cara e suficiente na maioria dos casos, você pode desejar verificar suas necessidades de desempenho e infraestrutura com suas políticas da empresa.

        - **Bare metal**: faturados mensalmente, os servidores bare metal são provisionados pela interação manual com a infraestrutura do IBM Cloud (SoftLayer) e podem levar mais de um dia útil para serem concluídos. Bare metal é mais adequado para aplicativos de alto desempenho que precisam de mais recursos e controle do host. Para clusters que executam o Kubernetes versão 1.9 ou mais recente, também é possível escolher ativar o [Cálculo confiável](cs_secure.html#trusted_compute) para verificar seus nós do trabalhador com relação à violação. Se você não ativar a confiança durante a criação do cluster, mas quiser fazer isso mais tarde, será possível usar o [comando](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Depois de ativar a confiança, não é possível desativá-la posteriormente.

        Certifique-se de que deseja provisionar uma máquina bare metal. Como o faturamento é mensal, se ele for cancelado imediatamente após uma ordem por engano, você ainda será cobrado pelo mês integral.
        {:tip}

    4.  **Padrão**: selecione um tipo de máquina e especifique o número de nós do trabalhador que você precisa. O tipo de máquina define a quantia de CPU virtual, memória e espaço em disco que é configurada em cada nó do trabalhador e disponibilizada para os contêineres. Os tipos de máquinas virtuais e bare metal disponíveis variam pelo local no qual você implementa o cluster. Para obter mais informações, veja a documentação do [comando](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Depois de criar seu cluster, é possível incluir tipos de máquina diferentes, incluindo um novo nó do trabalhador no cluster.

    5. **Padrão**: selecione uma VLAN pública (opcional) e uma VLAN privada (necessária) por meio de sua conta de infraestrutura do IBM Cloud (SoftLayer). Ambas as VLANs se comunicam entre os nós do trabalhador, mas a VLAN pública também se comunica com o mestre do Kubernetes gerenciado pela IBM. É possível usar a mesma VLAN para múltiplos clusters.
        **Nota**: se você optar por não selecionar uma VLAN pública, deverá configurar uma solução alternativa. Veja [Conexão VLAN para nós do trabalhador](#worker_vlan_connection) para obter mais informações.

    6. Por padrão, **Criptografar disco local** é selecionado. Se você escolher limpar a caixa de seleção, os dados do Docker do host não serão criptografados.[Saiba mais sobre a criptografia](cs_secure.html#encrypted_disks).

4. Clique em **Criar cluster**. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**. Quando a implementação está pronta, é possível ver que seu cluster está pronto na guia **Visão geral**.
    **Nota:** a cada nó do trabalhador é designado um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.

**O que Vem a Seguir?**

Quando o cluster estiver funcionando, será possível verificar as tarefas a seguir:

-   [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
-   [Implementar um app no cluster.](cs_app.html#app_cli)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)
- Se você tem múltiplas VLANs para um cluster ou múltiplas sub-redes na mesma VLAN, deve-se [ativar a ampliação de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) para que os nós do trabalhador possam se comunicar entre si na rede privada.
- Se você tiver um firewall, poderá ser necessário [abrir as portas requeridas](cs_firewall.html#firewall) para usar os comandos `bx`, `kubectl` ou `calicotl`, para permitir tráfego de saída do seu cluster ou para permitir tráfego de entrada para serviços de rede.

<br />


## Criando clusters com a CLI
{: #clusters_cli}

O propósito do cluster do Kubernetes é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantêm os apps altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

Antes de iniciar:
- Deve-se ter uma [conta do {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) Pay-As-You-Go ou de Assinatura. É possível criar 1 cluster grátis para experimentar alguns dos recursos ou criar clusters padrão para clusters totalmente customizáveis com sua opção de isolamento de hardware.
- [Certifique-se de que você tenha as permissões mínimas necessárias na infraestrutura do IBM Cloud (SoftLayer) para provisionar um cluster padrão](cs_users.html#infra_access).

Para criar um cluster:

1.  Instale a CLI do {{site.data.keyword.Bluemix_notm}} e o plug-in do [{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).

2.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas.

    ```
    bx login
    ```
    {: pre}

    **Nota:** se você tiver um ID federado, use `bx login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

3. Se você tiver várias contas do {{site.data.keyword.Bluemix_notm}}, selecione a conta na qual deseja criar seu cluster do Kubernetes.

4.  Se desejar criar ou acessar clusters de Kubernetes em uma região diferente da região do
{{site.data.keyword.Bluemix_notm}} que você selecionou anteriormente, execute `bx cs region-set`.

6.  Crie um cluster.

    1.  **Clusters padrão**: revise os locais que estão disponíveis. Os locais mostrados dependem da região do {{site.data.keyword.containershort_notm}} a que você está conectado.

        ```
        bx cs locations
        ```
        {: pre}

        Sua saída da CLI corresponde aos [locais para a região do contêiner](cs_regions.html#locations).

    2.  **Clusters padrão**: escolha um local e revise os tipos de máquina disponíveis nesse local. O tipo de máquina especifica os hosts de cálculo virtual ou físico que estão disponíveis para cada nó do trabalhador.

        -  Visualize o campo **Tipo de servidor** para escolher máquinas virtuais ou físicas (bare metal).
        -  **Virtual**: faturadas por hora, as máquinas virtuais são provisionadas em hardware compartilhado ou dedicado.
        -  **Físico**: faturados mensalmente, os servidores bare metal são provisionados pela interação manual com a infraestrutura do IBM Cloud (SoftLayer) e podem levar mais de um dia útil para serem concluídos. Bare metal é mais adequado para aplicativos de alto desempenho que precisam de mais recursos e controle do host.
        - **Máquinas físicas com Cálculo confiável**: para clusters bare metal que executam o Kubernetes versão 1.9 ou mais recente, também é possível escolher ativar o [Cálculo confiável](cs_secure.html#trusted_compute) para verificar seus nós do trabalhador bare metal com relação à violação. Se você não ativar a confiança durante a criação do cluster, mas quiser fazer isso mais tarde, será possível usar o [comando](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Depois de ativar a confiança, não é possível desativá-la posteriormente.
        -  **Tipos de máquina**: para decidir qual tipo de máquina implementar, revise as combinações de núcleo, memória e armazenamento ou consulte a [documentação do comando](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Depois de criar o cluster, é possível incluir diferentes tipos de máquina física ou virtual usando o [comando](cs_cli_reference.html#cs_worker_add) `bx cs worker-add`.

           Certifique-se de que deseja provisionar uma máquina bare metal. Como o faturamento é mensal, se ele for cancelado imediatamente após uma ordem por engano, você ainda será cobrado pelo mês integral.
           {:tip}

        <pre class="pre">bx cs machine-types &lt;location&gt;</pre>

    3.  **Clusters padrão**: verifique se uma VLAN pública e privada já existe na infraestrutura do IBM Cloud (SoftLayer) para esta conta.

        ```
        bx cs vlans <location>
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

        Se uma VLAN pública e privada já existe, observe os roteadores correspondentes. Os roteadores de VLAN privada sempre iniciam com `bcr` (roteador de backend) e roteadores de VLAN pública sempre iniciam com `fcr` (roteador de front-end). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster. Na saída de exemplo, quaisquer VLANs privadas podem ser usadas com quaisquer VLANs públicas porque todos os roteadores incluem `02a.dal10`.

        Deve-se conectar seus nós do trabalhador a uma VLAN privada e também é possível, opcionalmente, conectar seus nós do trabalhador a uma VLAN pública. **Nota**: se você optar por não selecionar uma VLAN pública, deverá configurar uma solução alternativa. Veja [Conexão VLAN para nós do trabalhador](#worker_vlan_connection) para obter mais informações.

    4.  **Clusters grátis e padrão**: execute o comando `cluster-create`. É possível escolher entre um cluster grátis, que inclui um nó do trabalhador configurado com 2vCPU e 4 GB de memória, ou um cluster padrão, que pode incluir quantos nós do trabalhador você escolher em sua conta de infraestrutura do IBM Cloud (SoftLayer). Ao criar um cluster padrão, por padrão, os discos do nó do trabalhador são criptografados, seu hardware é compartilhado por múltiplos clientes da IBM e são faturados por horas de uso. </br>Exemplo para um cluster padrão. Especifique as opções do cluster:

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt] [--trusted]
        ```
        {: pre}

        Exemplo para um cluster grátis. Especifique o nome do cluster:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tabela. Entendendo os componentes do comando <code>bx cs cluster-create</code></caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>O comando para criar um cluster na organização do {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>**Clusters padrão**: substitua <em>&lt;location&gt;</em> pelo ID de local do {{site.data.keyword.Bluemix_notm}} no qual você deseja criar seu cluster. [Locais disponíveis](cs_regions.html#locations) dependem da região do {{site.data.keyword.containershort_notm}} na qual você está conectado.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Clusters padrão**: escolha um tipo de máquina. É possível implementar os nós do trabalhador como máquinas virtuais em hardware compartilhado ou dedicado ou como máquinas físicas no bare metal. Os tipos de máquinas físicas e virtuais disponíveis variam pelo local no qual o cluster é implementado. Para obter mais informações, veja a documentação do [comando](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Para clusters livres, não é necessário definir o tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Somente clusters padrão virtuais**: o nível de isolamento de hardware para seu nó do trabalhador. Use dedicado para disponibilizar recursos físicos disponíveis apenas para você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes da IBM. O padrão é shared. Esse valor é opcional para clusters padrão e não está disponível para clusters livres.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Clusters grátis**: você não precisa definir uma VLAN pública. O cluster grátis é conectado automaticamente a uma VLAN pública que é de propriedade da IBM.</li>
          <li>**clusters padrão**: se você já tem uma VLAN pública configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para esse local, insira o ID da VLAN pública. Se você deseja conectar seus nós do trabalhador somente a uma VLAN privada, não especifique esta opção. **Nota**: se você optar por não selecionar uma VLAN pública, deverá configurar uma solução alternativa. Veja [Conexão VLAN para nós do trabalhador](#worker_vlan_connection) para obter mais informações.<br/><br/>
          <strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Clusters grátis**: você não precisa definir uma VLAN privada. O cluster grátis é conectado automaticamente a uma VLAN privada que é de propriedade da IBM.</li><li>**Clusters padrão**: se você já tem uma VLAN privada configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para esse local, insira o ID da VLAN privada. Se você não tem uma VLAN privada em sua conta, não especifique esta opção. O {{site.data.keyword.containershort_notm}} cria automaticamente uma VLAN privada para você.<br/><br/><strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Clusters grátis e padrão**: substitua <em>&lt;name&gt;</em> por um nome para seu cluster. O nome deve iniciar com uma letra, pode conter letras, números e - e deve ter 35 caracteres ou menos. Observe que o subdomínio do Ingresso designado à {{site.data.keyword.IBM_notm}} é derivado do nome do cluster. O nome do cluster e o subdomínio do Ingresso juntos formam o nome completo do domínio, que deve ser exclusivo dentro de uma região e ter 63 caracteres ou menos. Para atender a esses requisitos, o nome do cluster pode ser truncado ou o subdomínio pode ser designado a valores de caractere aleatórios.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Clusters padrão**: o número de nós do trabalhador para incluir no cluster. Se a opção <code>--workers</code> não for especificada, um nó do trabalhador será criado.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Clusters padrão**: a versão do Kubernetes para o nó principal do cluster. Esse valor é opcional. A menos que especificado, o cluster será criado com o padrão de versões do Kubernetes suportadas. Para ver versões disponíveis, execute <code>bx cs kube-versions</code>.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Clusters grátis e padrão**: os nós do trabalhador apresentam criptografia de disco por padrão; [saiba mais](cs_secure.html#encrypted_disks). Se desejar desativar a criptografia, inclua esta opção.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Clusters bare metal padrão**: ative [Cálculo confiável](cs_secure.html#trusted_compute) para verificar seus nós do trabalhador bare metal com relação à violação. Se você não ativar a confiança durante a criação do cluster, mas quiser fazer isso mais tarde, será possível usar o [comando](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Depois de ativar a confiança, não é possível desativá-la posteriormente.</td>
        </tr>
        </tbody></table>

7.  Verifique se a criação do cluster foi solicitada.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** para máquinas virtuais, pode levar alguns minutos para as máquinas do nó do trabalhador serem pedidas e para o cluster ser configurado e provisionado em sua conta. As máquinas físicas bare metal são provisionadas pela interação manual com a infraestrutura do IBM Cloud (SoftLayer) e podem levar mais de um dia útil para serem concluídas.

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.

    ```
    Name         ID                                   State      Created          Workers   Location   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.8.8
    ```
    {: screen}

8.  Verifique o status dos nós do trabalhador.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster.

    **Nota:** a cada nó do trabalhador é designado um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Location   Version
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.47.223.113  10.171.42.93    free           normal   Ready    mil01      1.8.8
    ```
    {: screen}

9. Configure o cluster criado como o contexto para esta sessão. Conclua estas etapas de configuração toda vez que você trabalhar com o seu cluster.
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

10. Ative seu painel do Kubernetes com a porta padrão `8001`.
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


**O que Vem a Seguir?**

-   [Implementar um app no cluster.](cs_app.html#app_cli)
-   [Gerenciar seu cluster com a linha de comandos de `kubectl`. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)
- Se você tem múltiplas VLANs para um cluster ou múltiplas sub-redes na mesma VLAN, deve-se [ativar a ampliação de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) para que os nós do trabalhador possam se comunicar entre si na rede privada.
- Se você tiver um firewall, poderá ser necessário [abrir as portas requeridas](cs_firewall.html#firewall) para usar os comandos `bx`, `kubectl` ou `calicotl`, para permitir tráfego de saída do seu cluster ou para permitir tráfego de entrada para serviços de rede.

<br />




## Visualizando estados do cluster
{: #states}

Revise o estado de um cluster do Kubernetes para obter informações sobre a disponibilidade e a capacidade do cluster, além de problemas em potencial que possam ter ocorrido.
{:shortdesc}

Para visualizar informações sobre um cluster específico, como seu local, URL mestre, subdomínio de Ingresso, versão, trabalhadores, proprietário e painel de monitoramento, use o [comando](cs_cli_reference.html#cs_cluster_get) `bx cs cluster-get <mycluster>`. Inclua a sinalização `--showResources` para visualizar mais recursos de cluster, como complementos para os pods de armazenamento ou VLANs de sub-rede para IPs públicos e privados.

É possível visualizar o estado atual do cluster executando o comando `bx cs clusters` e localizando o campo **Estado**. Para solucionar problemas de seu cluster e nós do trabalhador, veja [Resolução de problemas de clusters](cs_troubleshoot.html#debug_clusters).

<table summary="Cada linha da tabela deve ser lida da esquerda para a direita, com o estado do cluster na coluna um e uma descrição na coluna dois.">
   <thead>
   <th>Estado do cluster</th>
   <th>Descrição</th>
   </thead>
   <tbody>
<tr>
   <td>Interrompido</td>
   <td>A exclusão do cluster é solicitada pelo usuário antes da implementação do mestre do Kubernetes. Depois que a exclusão do cluster é concluída, o cluster é removido do painel. Se o seu cluster estiver preso nesse estado por muito tempo, abra um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
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
     <td>O cluster foi excluído, mas ainda não foi removido de seu painel. Se o seu cluster estiver preso nesse estado por muito tempo, abra um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
   <td>Exclusão</td>
   <td>O cluster está sendo excluído e a infraestrutura de cluster está sendo desmantelada. Não é possível acessar o cluster.  </td>
   </tr>
   <tr>
     <td>Implementação com falha</td>
     <td>A implementação do mestre do Kubernetes não pôde ser concluída. Não é possível resolver esse estado. Entre em contato com o suporte IBM Cloud abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
     <tr>
       <td>Implementando</td>
       <td>O mestre do Kubernetes não está totalmente implementado ainda. Não é possível acessar seu cluster. Aguarde até que seu cluster seja totalmente implementado para revisar seu funcionamento.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos os nós do trabalhador em um cluster estão funcionando. É possível acessar o cluster e implementar apps no cluster. Esse estado é considerado saudável e não requer uma ação sua.</td>
    </tr>
      <tr>
       <td>Pendente</td>
       <td>O mestre do Kubernetes foi implementado. Os nós do trabalhador estão sendo provisionados e ainda não estão disponíveis no cluster. É possível acessar o cluster, mas não é possível implementar apps no cluster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Uma solicitação para criar o cluster e pedir a infraestrutura para os nós principal e do trabalhador do Kubernetes é enviada. Quando a implementação do cluster é iniciada, o estado do cluster muda para <code>Deploying</code>. Se o seu cluster estiver preso no estado <code>Requested</code> por muito tempo, abra um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
     <td>Atualizando</td>
     <td>O servidor da API do Kubernetes executado no mestre do Kubernetes está sendo atualizado para uma nova versão de API do Kubernetes. Durante a atualização, não é possível acessar nem mudar o cluster. Nós do trabalhador, apps e recursos que foram implementados pelo usuário não são modificados e continuam a ser executados. Aguarde a atualização ser concluída para revisar o funcionamento de seu cluster. </td>
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

Quando tiver concluído com um cluster, será possível removê-lo para que o cluster não consuma mais recursos.
{:shortdesc}

Os clusters grátis e padrão criados com uma conta Pay-As-You-Go devem ser removidos manualmente pelo usuário quando eles não são mais necessários.

Ao excluir um cluster, você também estará excluindo recursos no cluster, incluindo contêineres, pods, serviços ligados e segredos. Se você não excluir seu armazenamento quando excluir o cluster, será possível excluir seu armazenamento por meio do painel de infraestrutura do IBM Cloud (SoftLayer) na GUI do {{site.data.keyword.Bluemix_notm}}. Devido ao ciclo de faturamento mensal, uma solicitação de volume persistente não pode ser excluída no último dia de um mês. Se você excluir a solicitação de volume persistente no último dia do mês, a exclusão permanecerá pendente até o início do mês seguinte.

**Aviso:** não são criados backups de seu cluster ou de seus dados em seu armazenamento persistente. A exclusão de um cluster é permanente e não pode ser desfeita.

-   Por meio da GUI do {{site.data.keyword.Bluemix_notm}}
    1.  Selecione seu cluster e clique em **Excluir** no menu **Mais ações...**.
-   No {{site.data.keyword.Bluemix_notm}} CLI
    1.  Liste os clusters disponíveis.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Exclua o cluster.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  Siga os prompts e escolha se deseja excluir recursos de cluster.

Quando você remove um cluster, é possível escolher remover as sub-redes móveis e o armazenamento persistente associado a ele:
- As sub-redes são usadas para designar endereços IP públicos móveis a serviços de balanceador de carga ou balanceador de carga de aplicativo de Ingresso. Se elas forem mantidas, será possível reutilizá-las em um novo cluster ou excluí-las manualmente mais tarde de seu portfólio de infraestrutura do IBM Cloud (SoftLayer).
- Se você criou uma solicitação de volume persistente usando um [compartilhamento de arquivo existente](cs_storage.html#existing), não será possível excluir o compartilhamento de arquivo quando excluir o cluster. Deve-se excluir manualmente o compartilhamento de arquivo posteriormente de seu portfólio de infraestrutura do IBM Cloud (SoftLayer).
- O armazenamento persistente fornece alta disponibilidade para seus dados. Se você excluí-lo, não será possível recuperar seus dados.
