---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

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

Projete sua configuração de cluster para máxima disponibilidade e capacidade.
{:shortdesc}


## Planejamento de configuração de cluster
{: #planning_clusters}

Use clusters padrão para aumentar a disponibilidade do app. É menos provável que seus usuários
experimentem tempo de inatividade quando você distribuir a configuração entre múltiplos nós do trabalhador e clusters. Recursos integrados, como balanceamento de carga e isolamento, aumentam a resiliência com relação a potenciais
falhas com hosts, redes ou apps.
{:shortdesc}

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

Ao criar um cluster padrão, os nós do trabalhador são pedidos na infraestrutura do IBM Cloud (SoftLayer) em seu nome e configurados no {{site.data.keyword.Bluemix_notm}}. A cada nó do trabalhador é designado
um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados após a criação do cluster. Dependendo do nível de
isolamento de hardware escolhido, os nós do trabalhador podem ser configurados como nós compartilhados ou dedicados. Também é possível escolher se você deseja que os nós do trabalhador se conectem a uma VLAN pública e VLAN privada ou somente a uma VLAN privada. Cada
nó do trabalhador é provisionado com um tipo específico de máquina que determina o número de vCPUs, memória
e espaço em disco que estão disponíveis para os contêineres que são implementados no nó do trabalhador. O Kubernetes limita o número máximo de nós do trabalhador que você pode ter em um cluster. Revise [cotas de nó do trabalhador e de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/cluster-large/) para obter mais informações.


### Hardware para nós do trabalhador
{: #shared_dedicated_node}

Cada nó do trabalhador é configurado como uma máquina virtual no hardware físico. Quando você cria um cluster padrão no {{site.data.keyword.Bluemix_notm}}, deve-se escolher se deseja que o hardware subjacente seja compartilhado por múltiplos clientes do {{site.data.keyword.IBM_notm}} (multiocupação) ou seja dedicado somente a você (ocupação única).
{:shortdesc}

Em uma configuração de diversos locatários, os recursos físicos, como CPU e memória, são compartilhados entre todas as
máquinas virtuais implementadas no mesmo hardware físico. Para assegurar que cada máquina
virtual possa ser executada independentemente, um monitor de máquina virtual, também referido como hypervisor,
segmenta os recursos físicos em entidades isoladas e aloca como recursos dedicados para
uma máquina virtual (isolamento de hypervisor).

Em uma configuração de locatário único, todos os recursos físicos são dedicados somente a você. É possível implementar
múltiplos nós do trabalhador como máquinas virtuais no mesmo host físico. Semelhante à configuração de diversos locatários,
o hypervisor assegura que cada nó do trabalhador obtenha seu compartilhamento dos recursos físicos
disponíveis.

Os nós compartilhados são geralmente mais baratos do que os nós dedicados porque os custos para o hardware
subjacente são compartilhados entre múltiplos clientes. No entanto, ao decidir entre nós compartilhados
e dedicados, você pode desejar verificar com seu departamento jurídico para discutir o nível de isolamento
e conformidade de infraestrutura que seu ambiente de app requer.

Ao criar um cluster grátis, seu nó do trabalhador é provisionado automaticamente como um nó compartilhado na conta de infraestrutura do IBM Cloud (SoftLayer).

### Conexão VLAN para nós do trabalhador
{: #worker_vlan_connection}

Ao criar um cluster, cada cluster é conectado automaticamente a uma VLAN de sua conta de infraestrutura do IBM Cloud (SoftLayer). Uma VLAN configura um grupo de
nós do trabalhador e pods como se eles estivessem conectados à mesma ligação física. A VLAN privada determina o endereço IP privado que é designado a um nó do trabalhador durante a criação de cluster e a VLAN pública determina o endereço IP público que é designado a um nó do trabalhador durante a criação de cluster.

Para clusters grátis, os nós do trabalhador do cluster são conectados a uma VLAN pública e VLAN privada pertencentes à IBM por padrão durante a criação de cluster. Para clusters padrão, é possível conectar seus nós do trabalhador a uma VLAN pública e uma VLAN privada ou somente a uma VLAN privada. Se você deseja conectar seus nós do trabalhador a somente uma VLAN privada, é possível designar o ID de uma VLAN privada existente durante a criação de cluster. No entanto, também deve-se configurar uma solução alternativa para permitir uma conexão segura entre os nós do trabalhador e o mestre do Kubernetes. Por exemplo, é possível configurar um Vyatta para passar tráfego dos nós do trabalhador da VLAN privada para o mestre do Kubernetes. Veja "Configurar um Vyatta customizado para conectar seus nós do trabalhador ao mestre do Kubernetes com segurança" na [documentação da infraestrutura do IBM Cloud (SoftLayer)o](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta) para obter mais informações.

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



<br />



## Criando clusters com a GUI
{: #clusters_ui}

Um cluster do Kubernetes é um conjunto de nós do trabalhador organizados em uma rede. O propósito do cluster é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantenham os aplicativos altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

Para criar um cluster:
1. No catálogo, selecione **Kubernetes Cluster**.
2. Selecione uma região no qual implementar o cluster.
3. Selecione um tipo de plano de cluster. É possível escolher **Grátis** ou **Pay-As-You-Go**. Com o plano Pay-As-You-Go, é possível provisionar um cluster padrão com recursos como múltiplos nós do trabalhador para um ambiente altamente disponível.
4. Configure os detalhes do seu cluster.
    1. Dê um nome ao seu cluster, escolha uma versão do Kubernetes e selecione um local no qual implementar o cluster. Para o melhor desempenho, selecione o local que é fisicamente mais próximo de você. Lembre-se de que uma autorização jurídica poderá ser requerida para que os dados possam ser armazenados fisicamente em um país estrangeiro se você selecionar um local que está fora de seu país.
    2. Selecione um tipo de máquina e especifique o número de nós do trabalhador que você precisa. O tipo de máquina define a quantia de CPU virtual, memória e espaço em disco que é configurada em cada nó do trabalhador e disponibilizada para os contêineres.
    3. Selecione uma VLAN pública e uma privada de sua conta de infraestrutura do IBM Cloud (SoftLayer). Ambas as VLANs se comunicam entre os nós do trabalhador, mas a VLAN pública também se comunica com o mestre do Kubernetes gerenciado pela IBM. É possível usar a mesma VLAN para múltiplos clusters.
        **Nota**: se você optar por não selecionar uma VLAN pública, deverá configurar uma solução alternativa. Veja [Conexão VLAN para nós do trabalhador](#worker_vlan_connection) para obter mais informações.
    4. Selecione um tipo de hardware.
        - **Dedicado**: seus nós do trabalhador são hospedados na infraestrutura que é dedicada à sua conta. Seus recursos estão completamente isolados.
        - **Compartilhado**: os recursos de infraestrutura, como o hypervisor e hardware físico, são distribuídos entre você e outros clientes IBM, mas cada nó do trabalhador é acessível somente por você. Embora essa opção seja menos cara e suficiente na maioria dos casos, você pode desejar verificar suas necessidades de desempenho e infraestrutura com suas políticas das empresas.
    5. Por padrão, **Criptografar disco local** é selecionado. Se você escolher limpar a caixa de seleção, os dados do Docker do host não serão criptografados.[Saiba mais sobre a criptografia](cs_secure.html#encrypted_disks).
4. Clique em **Criar cluster**. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**. Quando a implementação está pronta, é possível ver que seu cluster está pronto na guia **Visão geral**.
    **Nota:** a cada nó do trabalhador é designado um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.


**O que Vem a Seguir?**

Quando o cluster estiver funcionando, será possível verificar as tarefas a seguir:

-   [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
-   [Implementar um app no cluster.](cs_app.html#app_cli)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)
- Se você tiver um firewall, poderá ser necessário [abrir as portas requeridas](cs_firewall.html#firewall) para usar os comandos `bx`, `kubectl` ou `calicotl`, para permitir tráfego de saída do seu cluster ou para permitir tráfego de entrada para serviços de rede.

<br />


## Criando clusters com a CLI
{: #clusters_cli}

Um cluster é um conjunto de nós do trabalhador organizados em uma rede. O propósito do cluster é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantenham os aplicativos altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

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
    1.  Revise os locais que estão disponíveis. Os locais mostrados dependem da região do {{site.data.keyword.containershort_notm}} a que você está conectado.

        ```
        bx cs locations
        ```
        {: pre}

        Sua saída da CLI corresponde aos [locais para a região do contêiner](cs_regions.html#locations).

    2.  Escolha um local e revise os tipos de máquina disponíveis nesse local. O tipo de máquina especifica os recursos de cálculo virtual que estão disponíveis para cada nó do trabalhador.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Verifique se uma VLAN pública e uma privada já existem na infraestrutura do IBM Cloud (SoftLayer) para esta conta.

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

    4.  Execute o comando `cluster-create`. É possível escolher entre um cluster grátis, que inclui um nó do trabalhador configurado com 2vCPU e 4 GB de memória, ou um cluster padrão, que pode incluir quantos nós do trabalhador você escolher em sua conta de infraestrutura do IBM Cloud (SoftLayer). Ao criar um cluster padrão, por padrão, os discos do nó do trabalhador são criptografados, seu hardware é compartilhado por múltiplos clientes da IBM e são faturados por horas de uso. </br>Exemplo para um cluster padrão:

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        Exemplo para um cluster grátis:

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
        <td>Substitua <em>&lt;location&gt;</em> pelo ID do local do {{site.data.keyword.Bluemix_notm}} no qual você deseja criar seu cluster. [Locais disponíveis](cs_regions.html#locations) dependem da região do {{site.data.keyword.containershort_notm}} na qual você está conectado.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Se você estiver criando um cluster padrão, escolha um tipo de máquina. O tipo de máquina especifica os recursos de cálculo virtual que estão disponíveis para cada nó do trabalhador. Revise [Comparação de clusters livres e padrão para o {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) para obter mais informações. Para clusters livres, não é necessário definir o tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>O nível de isolamento de hardware para seu nó do trabalhador. Use dedicado para disponibilizar recursos físicos disponíveis apenas para você ou compartilhado para permitir que os recursos físicos sejam compartilhados com outros clientes da IBM. O padrão é shared. Esse valor é opcional para clusters padrão e não está disponível para clusters livres.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Para clusters grátis, você não precisa definir uma VLAN pública. O cluster grátis é conectado automaticamente a uma VLAN pública que é de propriedade da IBM.</li>
          <li>Para um cluster padrão, se você já tiver uma VLAN pública configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para esse local, insira o ID da VLAN pública. Se você não tiver ambas, uma VLAN pública e uma privada em sua conta, não especifique essa opção. O {{site.data.keyword.containershort_notm}} cria automaticamente uma VLAN pública para você.<br/><br/>
          <strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Para clusters grátis, você não precisa definir uma VLAN privada. O cluster grátis é conectado automaticamente a uma VLAN privada que é de propriedade da IBM.</li><li>Para um cluster padrão, se você já tiver uma VLAN privada configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para esse local, insira o ID da VLAN privada. Se você não tiver ambas, uma VLAN pública e uma privada em sua conta, não especifique essa opção. O {{site.data.keyword.containershort_notm}} cria automaticamente uma VLAN pública para você.<br/><br/><strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Substitua <em>&lt;name&gt;</em> por um nome para seu cluster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>O número de nós do trabalhador a serem incluídos no cluster. Se a opção <code>--workers</code> não for especificada, um nó do trabalhador será criado.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>A versão do Kubernetes para o nó principal do cluster. Esse valor é opcional. A menos que especificado, o cluster será criado com o padrão de versões do Kubernetes suportadas. Para ver versões disponíveis, execute <code>bx cs kube-versions</code>.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>Nós do trabalhador apresentam criptografia de disco por padrão; [saiba mais](cs_secure.html#encrypted_disks). Se desejar desativar a criptografia, inclua esta opção.</td>
        </tr>
        </tbody></table>

7.  Verifique se a criação do cluster foi solicitada.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta.

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
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
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
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
- Se você tiver um firewall, poderá ser necessário [abrir as portas requeridas](cs_firewall.html#firewall) para usar os comandos `bx`, `kubectl` ou `calicotl`, para permitir tráfego de saída do seu cluster ou para permitir tráfego de entrada para serviços de rede.

<br />


## Estados do cluster
{: #states}

É possível visualizar o estado atual do cluster executando o comando `bx cs clusters` e localizando o campo **Estado**. O estado do cluster fornece informações sobre a disponibilidade e a capacidade do cluster, além de problemas em potencial que possam ter ocorrido.
{:shortdesc}

|Estado do cluster|Motivo|
|-------------|------|

|Crítico|O mestre do Kubernetes não pode ser atingido ou todos os nós do trabalhador no cluster estão inativos. <ol><li>Liste os nós do trabalhador em seu cluster.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>Obtenha os detalhes para cada nó do trabalhador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Revise os campos <strong>Estado</strong> e <strong>Status</strong> para localizar o problema raiz do motivo de o nó do trabalhador está inativo.<ul><li>Se o estado do nó do trabalhador mostra <strong>Provision_failed</strong>, você pode não ter as permissões necessárias para provisionar um nó do trabalhador do portfólio de infraestrutura do IBM Cloud (SoftLayer). Para localizar as permissões necessárias, veja [Configurar o acesso ao portfólio de infraestrutura do IBM Cloud (SoftLayer) para criar clusters do Kubernetes padrão](cs_infrastructure.html#unify_accounts).</li><li>Se o estado do nó do trabalhador mostrar <strong>Crítico</strong> e o status mostrar <strong>Não pronto</strong>, então seu nó do trabalhador poderá não ser capaz de se conectar à infraestrutura do IBM Cloud (SoftLayer). Inicie a resolução, executando <code>bx cs worker-reboot -- difícil CLUSTER WORKER</code> primeiro. Se esse comando for malsucedido, execute <code>bx cs worker reload CLUSTER WORKER</code>.</li><li>Se o estado do nó do trabalhador mostrar <strong>Crítico</strong> e o status mostrar <strong>Sem disco
</strong>, então seu nó do trabalhador ficou sem capacidade. Será possível reduzir a carga de trabalho em seu nó do trabalhador ou incluir um nó do trabalhador em seu cluster para ajudar no balanceamento de carga da carga de trabalho.</li><li>Se o estado do nó do trabalhador mostrar <strong>Crítico</strong> e o status mostrar <strong>Desconhecido</strong>, então o mestre do Kubernetes não estará disponível. Entre em contato com o suporte do {{site.data.keyword.Bluemix_notm}} abrindo um [chamado de suporte do {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</li></ul></li></ol>|

|Implementando|O mestre do Kubernetes ainda não está totalmente implementado. Não é possível acessar seu cluster.|
|Normal|Todos os nós do trabalhador em um cluster estão funcionando. É possível acessar o cluster e implementar apps no cluster.|
|Pendente|O mestre do Kubernetes está implementado. Os nós do trabalhador estão sendo provisionados e ainda não estão disponíveis no cluster. É possível acessar o cluster, mas não é possível implementar apps no cluster.|

|Aviso|Pelo menos um nó do trabalhador no cluster não está disponível, mas outros nós do trabalhador estão disponíveis e podem assumir o controle da carga de trabalho. <ol><li>Liste os nós do trabalhador em seu cluster e anote o ID dos nós do trabalhador que mostram um estado <strong>Aviso</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Obtenha os detalhes para um nó do trabalhador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Revise os campos <strong>Estado</strong>, <strong>Status</strong> e <strong>Detalhes</strong> para localizar o problema raiz do motivo de o nó do trabalhador estar inativo.</li><li>Se o seu nó do trabalhador tiver quase atingido o limite de memória ou de espaço em disco, reduza a carga de trabalho no nó do trabalhador ou inclua um nó do trabalhador em seu cluster para ajudar no balanceamento de carga da carga de trabalho.</li></ol>|

{: caption="Tabela. Estados do cluster" caption-side="top"}

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
