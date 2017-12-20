---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---
{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurando clusters
{: #cs_cluster}

Projete sua configuração de cluster para máxima disponibilidade e capacidade.
{:shortdesc}

O diagrama a seguir inclui configurações de cluster comum com o aumento de disponibilidade.

![Estágios de alta disponibilidade para um cluster](images/cs_cluster_ha_roadmap.png)

Conforme mostrado no diagrama, implementar os seus apps em múltiplos nós do trabalhador torna os apps mais altamente disponíveis. Implementar os apps em múltiplos clusters os torna ainda mais altamente disponíveis. Para a maior disponibilidade, implemente seus apps em clusters em diferentes regiões. [Para obter mais detalhes, revise as opções para configurações de cluster altamente disponível.](cs_planning.html#cs_planning_cluster_config)

<br />


## Criando clusters com a GUI
{: #cs_cluster_ui}

Um cluster do Kubernetes é um conjunto de nós do trabalhador organizados em uma rede. O propósito do cluster é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantenham os aplicativos altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}
Para usuários do {{site.data.keyword.Bluemix_dedicated_notm}}, veja [Criando clusters do Kubernetes por meio da GUI no {{site.data.keyword.Bluemix_dedicated_notm}} (beta encerrado)](#creating_ui_dedicated).

Para criar um cluster:
1. No catálogo, selecione **Kubernetes Cluster**.
2. Selecione um tipo de plano de cluster. É possível escolher **Lite** ou **Pay-As-You-Go**. Com o plano Pay-As-You-Go, é possível provisionar um cluster padrão com recursos como múltiplos nós do trabalhador para um ambiente altamente disponível.
3. Configure os detalhes do seu cluster.
    1. Dê um nome ao seu cluster, escolha uma versão do Kubernetes e selecione um local no qual implementar. Selecione o local que é fisicamente mais próximo de você para o melhor desempenho. Lembre-se de que você pode precisar de autorização legal antes que os dados possam ser armazenados fisicamente em um país estrangeiro se você selecionar um local fora de seu país.
    2. Selecione um tipo de máquina e especifique o número de nós do trabalhador que você precisa. O tipo de máquina define a quantia de CPU e memória virtual configurada em cada nó do trabalhador e disponibilizada para os contêineres.
        - O tipo de máquina micro indica a menor opção.
        - Uma máquina balanceada tem uma quantia igual de memória que está designada a cada CPU, que otimiza o desempenho.
    3. Selecione uma VLAN pública e uma privada de sua conta de infraestrutura do IBM Cloud (SoftLayer). Ambas as VLANs se comunicam entre os nós do trabalhador, mas a VLAN pública também se comunica com o mestre do Kubernetes gerenciado pela IBM. É possível usar a mesma VLAN para múltiplos clusters.
        **Nota**: se você optar por não selecionar uma VLAN pública, deverá configurar uma solução alternativa.
    4. Selecione um tipo de hardware. Compartilhado é uma opção suficiente para a maioria das situações.
        - **Dedicado**: assegure o isolamento completo de seus recursos físicos.
        - **Compartilhado**: permita o armazenamento de seus recursos físicos no mesmo hardware que outros clientes IBM.
4. Clique em **Criar cluster**. É possível ver o progresso da implementação do nó do trabalhador na guia **Nós do trabalhador**. Quando a implementação está pronta, é possível ver que seu cluster está pronto na guia **Visão geral**.
    **Nota:** a cada nó do trabalhador é designado um ID de nó do trabalhador e um nome de domínio exclusivos que não devem ser mudados manualmente após a criação do cluster. Mudar o ID ou o nome do domínio evita que o mestre do Kubernetes gerencie o cluster.


**O que Vem a Seguir?**

Quando o cluster estiver funcionando, será possível verificar as tarefas a seguir:

-   [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
-   [Implementar um app no cluster.](cs_apps.html#cs_apps_cli)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)


### Criando clusters com a GUI no {{site.data.keyword.Bluemix_dedicated_notm}} (beta encerrado)
{: #creating_ui_dedicated}

1.  Efetue login no Console público do {{site.data.keyword.Bluemix_notm}} ([https://console.bluemix.net ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net)) com o seu IBMid.
2.  No menu de conta, selecione a sua conta do {{site.data.keyword.Bluemix_dedicated_notm}}. O console é atualizado com os serviços e as informações para a sua instância do {{site.data.keyword.Bluemix_dedicated_notm}}.
3.  No catálogo, selecione **Contêineres** e clique em **Cluster do Kubernetes**.
4.  Insira um **Nome do cluster**.
5.  Selecione um **Tipo de máquina**. O tipo de máquina define a quantia de CPU e memória virtual que é configurada em cada nó do trabalhador e que está disponível para todos os contêineres que você implementar em seus nós.
    -   O tipo de máquina micro indica a menor opção.
    -   Um tipo de máquina balanceada tem uma quantia igual de memória designada a cada CPU, que otimiza o desempenho.
6.  Escolha o **Número de nós do trabalhador** que você precisa. Selecione `3` para assegurar a alta disponibilidade de seu cluster.
7.  Clique em **Criar Cluster**. Os detalhes para o cluster são abertos, mas os nós do trabalhador no cluster levam alguns minutos para provisão. Na guia **Nós do trabalhador**, é possível ver o progresso da implementação do nó do trabalhador. Quando os nós do trabalhador estão prontos, o estado muda para **Pronto**.

**O que Vem a Seguir?**

Quando o cluster estiver funcionando, será possível verificar as tarefas a seguir:

-   [Instale as CLIs para iniciar o trabalho com seu cluster.](cs_cli_install.html#cs_cli_install)
-   [Implementar um app no cluster.](cs_apps.html#cs_apps_cli)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)

<br />


## Criando clusters com a CLI
{: #cs_cluster_cli}

Um cluster é um conjunto de nós do trabalhador organizados em uma rede. O propósito do cluster é definir um conjunto de recursos, nós, redes e dispositivos de armazenamento que mantenham os aplicativos altamente disponíveis. Para poder implementar um app, deve-se criar um cluster e configurar as definições para os nós do trabalhador nesse cluster.
{:shortdesc}

Para usuários do {{site.data.keyword.Bluemix_dedicated_notm}}, veja [Criando clusters do Kubernetes da CLI no {{site.data.keyword.Bluemix_dedicated_notm}} (beta encerrado)](#creating_cli_dedicated).

Para criar um cluster:
1.  Instale a CLI do {{site.data.keyword.Bluemix_notm}} e o plug-in do [{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas. Para especificar uma região do {{site.data.keyword.Bluemix_notm}}, [inclua o terminal de API](cs_regions.html#bluemix_regions).

    ```
    bx login
    ```
    {: pre}

    **Nota:** se você tiver um ID federado, use `bx login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

3. Se você tiver várias contas do {{site.data.keyword.Bluemix_notm}}, selecione a conta na qual deseja criar seu cluster do Kubernetes.

4.  Se você deseja criar ou acessar clusters do Kubernetes em uma região diferente da região do {{site.data.keyword.Bluemix_notm}} que selecionou anteriormente, [especifique o terminal de API de região do {{site.data.keyword.containershort_notm}}](cs_regions.html#container_login_endpoints).

    **Nota**: se você desejar criar um cluster no leste dos EUA, deverá especificar o terminal de API da região de contêiner do leste dos EUA usando o comando `bx cs init --host https://us-east.containers.bluemix.net`.

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

    4.  Execute o comando `cluster-create`. É possível escolher entre um cluster Lite, que inclui um nó do trabalhador configurado com 2vCPU e 4 GB de memória, ou um cluster padrão, que pode incluir quantos nós do trabalhador você escolher em sua conta de infraestrutura do IBM Cloud (SoftLayer). Ao criar um cluster padrão, o hardware do nó do trabalhador, por padrão, é compartilhado por múltiplos clientes IBM e faturado por horas de uso. </br>Exemplo para um cluster padrão:

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch>
        ```
        {: pre}

        Exemplo para um cluster lite:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tabela 1. Entendendo os componentes do comando <code>bx cs cluster-create</code></caption>
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
        <td>Substitua <em>&lt;location&gt;</em> pelo ID do local do {{site.data.keyword.Bluemix_notm}} no qual você deseja criar seu cluster. [Locais disponíveis](cs_regions.html#locations) dependem da região do {{site.data.keyword.containershort_notm}} na qual você está conectado.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Se você estiver criando um cluster padrão, escolha um tipo de máquina. O tipo de máquina especifica os recursos de cálculo virtual que estão disponíveis para cada nó do trabalhador. Revise [Comparação de clusters lite e padrão do {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type) para obter mais informações. Para clusters lite, não é necessário definir o tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Para clusters lite, não é necessário definir uma VLAN pública. Seu cluster lite é conectado automaticamente a uma VLAN pública pertencente à IBM.</li>
          <li>Para um cluster padrão, se você já tiver uma VLAN pública configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para esse local, insira o ID da VLAN pública. Se você não tiver ambas, uma VLAN pública e uma privada em sua conta, não especifique essa opção. O {{site.data.keyword.containershort_notm}} cria automaticamente uma VLAN pública para você.<br/><br/>
          <strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Para clusters lite, não é necessário definir uma VLAN privada. Seu cluster lite é conectado automaticamente a uma VLAN privada pertencente à IBM.</li><li>Para um cluster padrão, se você já tiver uma VLAN privada configurada em sua conta de infraestrutura do IBM Cloud (SoftLayer) para esse local, insira o ID da VLAN privada. Se você não tiver ambas, uma VLAN pública e uma privada em sua conta, não especifique essa opção. O {{site.data.keyword.containershort_notm}} cria automaticamente uma VLAN pública para você.<br/><br/><strong>Nota</strong>: os roteadores de VLAN privada sempre iniciam com <code>bcr</code> (roteador backend) e os roteadores de VLAN pública sempre iniciam com <code>fcr</code> (roteador frontend). A combinação de número e letra após esses prefixos deve corresponder para usar essas VLANs ao criar um cluster.</li></ul></td>
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

-   [Implementar um app no cluster.](cs_apps.html#cs_apps_cli)
-   [Gerenciar seu cluster com a linha de comandos de `kubectl`. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)

### Criando clusters com a CLI no {{site.data.keyword.Bluemix_dedicated_notm}} (beta encerrado)
{: #creating_cli_dedicated}

1.  Instale a CLI do {{site.data.keyword.Bluemix_notm}} e o plug-in do [{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Efetue login no terminal público do {{site.data.keyword.containershort_notm}}. Insira as suas credenciais do {{site.data.keyword.Bluemix_notm}} e selecione a conta do {{site.data.keyword.Bluemix_dedicated_notm}} quando solicitado.

    ```
    bx login -a api.<region>.bluemix.net
    ```
    {: pre}

    **Nota:** se você tiver um ID federado, use `bx login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

3.  Crie um cluster com o comando `cluster-create`. Ao criar um cluster padrão, o hardware do nó do trabalhador é faturado por horas de uso.

    Exemplo:

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>Tabela 2. Entendendo os componentes deste comando</caption>
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
    <td>Substitua &lt;location&gt; pelo ID do local do {{site.data.keyword.Bluemix_notm}} no qual você deseja criar seu cluster. [Locais disponíveis](cs_regions.html#locations) dependem da região do {{site.data.keyword.containershort_notm}} na qual você está conectado.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Se você estiver criando um cluster padrão, escolha um tipo de máquina. O tipo de máquina especifica os recursos de cálculo virtual que estão disponíveis para cada nó do trabalhador. Revise [Comparação de clusters lite e padrão do {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type) para obter mais informações. Para clusters lite, não é necessário definir o tipo de máquina.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Substitua <em>&lt;name&gt;</em> por um nome para seu cluster.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>O número de nós do trabalhador a serem incluídos no cluster. Se a opção <code>--workers</code> não for especificada, um nó do trabalhador será criado.</td>
    </tr>
    </tbody></table>

4.  Verifique se a criação do cluster foi solicitada.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta.

    Quando o fornecimento do cluster é concluído, o estado do cluster muda para **implementado**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

5.  Verifique o status dos nós do trabalhador.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Configure o cluster criado como o contexto para esta sessão. Conclua estas etapas de configuração toda vez que você trabalhar com o seu cluster.

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

7.  Acesse seu painel do Kubernetes com a porta padrão 8001.
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

-   [Implementar um app no cluster.](cs_apps.html#cs_apps_cli)
-   [Gerenciar seu cluster com a linha de comandos de `kubectl`. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configure seu próprio registro privado no {{site.data.keyword.Bluemix_notm}} para armazenar e compartilhar imagens do Docker com outros usuários.](/docs/services/Registry/index.html)

<br />


## Usando registros de imagem privada e pública
{: #cs_apps_images}

Uma imagem do Docker é a base para cada contêiner que você cria. Uma imagem é criada por meio de um Dockerfile, que é um arquivo que contém instruções para construir a imagem. Um Dockerfile pode referenciar os artefatos de construção em suas instruções que são armazenadas separadamente, como um app, a configuração do app e suas dependências. As imagens geralmente são armazenadas em um registro que pode ser acessado pelo público (registro público) ou configurado com acesso limitado para um pequeno grupo de usuários (registro privado).
{:shortdesc}

Revise as opções a seguir para localizar informações sobre como configurar um registro de imagem e como usar uma imagem do registro.

-   [Acessando um namespace no {{site.data.keyword.registryshort_notm}} para trabalhar com imagens fornecidas pela IBM e com suas próprias imagens privadas do Docker](#bx_registry_default).
-   [Acessando imagens públicas do Docker Hub](#dockerhub).
-   [Acessando imagens privadas que são armazenadas em outros registros privados](#private_registry).

### Acessando um namespace no {{site.data.keyword.registryshort_notm}} para trabalhar com imagens fornecidas pela IBM e as suas próprias imagens privadas do Docker
{: #bx_registry_default}

É possível implementar contêineres em seu cluster de uma imagem pública fornecida pela IBM ou de uma imagem privada que é armazenada em seu namespace no {{site.data.keyword.registryshort_notm}}.

Antes de iniciar:

1. [Configure um namespace no {{site.data.keyword.registryshort_notm}} no {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_dedicated_notm}} e envie por push imagens para esse namespace](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Crie um cluster](#cs_cluster_cli).
3. [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Ao criar um cluster, um token de registro sem expiração será criado automaticamente para o cluster. Esse token é usado para autorizar acesso somente leitura a qualquer um dos namespaces que você configurar no {{site.data.keyword.registryshort_notm}} para que possa trabalhar com as imagens públicas fornecidas pela IBM e com suas próprias imagens privadas do Docker. Os tokens deverão ser armazenados em um `imagePullSecret` do Kubernetes para que fiquem acessíveis a um cluster do Kubernetes quando você implementar um app conteinerizado. Quando o cluster é criado, o {{site.data.keyword.containershort_notm}} armazena automaticamente esse token em um Kubernetes `imagePullSecret`. O `imagePullSecret` é incluído no namespace padrão do Kubernetes, na lista padrão de segredos na ServiceAccount para esse namespace e no namespace kube-system.

**Nota:** ao usar essa configuração inicial, será possível implementar contêineres de qualquer imagem que estiver disponível em um namespace na conta do {{site.data.keyword.Bluemix_notm}} no namespace **padrão** do cluster. Se você deseja implementar um contêiner em outros namespaces de seu cluster ou se deseja usar uma imagem que está armazenada em outra região do {{site.data.keyword.Bluemix_notm}} ou em outra conta do {{site.data.keyword.Bluemix_notm}}, deve-se [criar seu próprio imagePullSecret para o cluster](#bx_registry_other).

Para implementar um contêiner no namespace **padrão** de seu cluster, crie um arquivo de configuração.

1.  Crie um arquivo de configuração de implementação que é chamado de `mydeployment.yaml`.
2.  Defina a implementação e a imagem que você deseja usar por meio de seu namespace no {{site.data.keyword.registryshort_notm}}.

    Para usar uma imagem privada de um namespace no {{site.data.keyword.registryshort_notm}}:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **Dica:** para recuperar informações de seu namespace, execute `bx cr namespace-list`.

3.  Crie a implementação em seu cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Dica:** também é possível implementar um arquivo de configuração existente, como uma das imagens públicas fornecidas pela IBM. Este exemplo usa a imagem **ibmliberty** na região sul dos EUA.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Implementando imagens em outros namespaces do Kubernetes ou acessando imagens em outras regiões e contas do {{site.data.keyword.Bluemix_notm}}
{: #bx_registry_other}

É possível implementar contêineres em outros namespaces do Kubernetes, usar imagens armazenadas em outras regiões ou contas do {{site.data.keyword.Bluemix_notm}} ou usar imagens armazenadas no {{site.data.keyword.Bluemix_dedicated_notm}} criando o seu próprio imagePullSecret.

Antes de iniciar:

1.  [Configure um namespace no {{site.data.keyword.registryshort_notm}} no {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_dedicated_notm}} e envie por push imagens para esse namespace](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Crie um cluster](#cs_cluster_cli).
3.  [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Para criar seu próprio imagePullSecret:

**Nota:** os ImagePullSecrets são válidos apenas para os namespaces do Kubernetes para os quais foram criados. Repita essas etapas para cada namespace no qual você desejar implementar contêineres. Imagens do [DockerHub](#dockerhub) não requerem ImagePullSecrets.

1.  Se você não tiver um token, [crie um token para o registro que você desejar acessar.](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Liste tokens em sua conta. {{site.data.keyword.Bluemix_notm}}

    ```
    bx cr token-list
    ```
    {: pre}

3.  Anote o ID de token que você deseja usar.
4.  Recupere o valor para seu token. Substitua <em>&lt;token_id&gt;</em>
pelo ID do token que você recuperou na etapa anterior.

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    Seu valor do token é exibido no campo **Token** de sua saída da CLI.

5.  Crie o segredo do Kubernetes para armazenar suas informações do token.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabela 3. Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Necessário. O namespace do Kubernetes do cluster no qual você deseja usar o segredo e implementar contêineres. Execute <code>kubectl get namespaces</code> para listar todos os namespaces em seu cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Necessário. O nome que você deseja usar para seu imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Necessário. A URL para o registro de imagem no qual o seu namespace está configurado.<ul><li>Para namespaces configurados no registry.ng.bluemix.net do Sul e Leste dos EUA.</li><li>Para namespaces configurados no sul do Reino Unido registry.eu-gb.bluemix.net</li><li>Para namespaces configurados na UE Central (Frankfurt) registry.eu-de.bluemix.net</li><li>Para namespaces configurados na Austrália (Sydney) registry.au-syd.bluemix.net</li><li>Para namespaces configurados no {{site.data.keyword.Bluemix_dedicated_notm}} registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Necessário. O nome do usuário para efetuar login no seu registro privado. Para {{site.data.keyword.registryshort_notm}}, o nome de usuário é configurado como <code>token</code>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Necessário. O valor do token de registro que você recuperou anteriormente.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Necessário. Se você tiver um, insira seu endereço de e-mail do Docker. Se não tiver um, insira um endereço de e-mail fictício, por exemplo a@b.c. Esse e-mail é obrigatório para criar um segredo do Kubernetes, mas não é usado após a criação.</td>
    </tr>
    </tbody></table>

6.  Verifique se o segredo foi criado com êxito. Substitua <em>&lt;kubernetes_namespace&gt;</em> pelo nome do namespace no qual você criou o imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  Crie um pod que referencie o imagePullSecret.
    1.  Crie um arquivo de configuração de pod que seja denominado `mypod.yaml`.
    2.  Defina o pod e o imagePullSecret que você deseja usar para acessar o registro privado do {{site.data.keyword.Bluemix_notm}}.

        Uma imagem privada de um namespace:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        Uma imagem pública do {{site.data.keyword.Bluemix_notm}}:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tabela 4. Entendendo os componentes de arquivo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>O nome do contêiner que você deseja implementar em seu cluster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>O namespace no qual sua imagem está armazenada. Para listar os namespaces disponíveis, execute `bx cr namespace-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>O nome da imagem que você deseja usar. Para listar as imagens disponíveis em uma conta do {{site.data.keyword.Bluemix_notm}}, execute `bx cr image-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>A versão da imagem que você deseja usar. Se nenhuma tag for especificada, a imagem identificada como <strong>mais recente</strong> será usada por padrão.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>O nome do imagePullSecret que você criou anteriormente.</td>
        </tr>
        </tbody></table>

   3.  Salve as suas mudanças.
   4.  Crie a implementação em seu cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


### Acessando imagens públicas do Docker Hub
{: #dockerhub}

É possível usar qualquer imagem pública que esteja armazenada no Docker Hub para implementar um contêiner em seu
cluster sem nenhuma configuração adicional.

Antes de iniciar:

1.  [Crie um cluster](#cs_cluster_cli).
2.  [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Crie um arquivo de configuração de implementação.

1.  Crie um arquivo de configuração que é denominado `mydeployment.yaml`.
2.  Defina a implementação e a imagem pública do Docker Hub que você deseja usar. O arquivo de configuração a seguir usa a imagem pública NGINX disponível no Docker Hub.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  Crie a implementação em seu cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Dica:** como alternativa, implemente um arquivo de configuração existente. O exemplo a seguir usa a mesma imagem NGINX pública, mas a aplica diretamente em seu cluster.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### Acessando imagens privadas que são armazenadas em outros registros privados
{: #private_registry}

Se você já tiver um registro privado que você deseje usar, deverá armazenar as credenciais de registro em um imagePullSecret do Kubernetes e referenciar esse segredo em seu arquivo de configuração.

Antes de iniciar:

1.  [Crie um cluster](#cs_cluster_cli).
2.  [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Para criar um imagePullSecret:

**Nota:** os ImagePullSecrets são válidos para os namespaces do Kubernetes para os quais foram criados. Repita essas etapas para cada namespace no qual você deseja implementar contêineres de uma imagem em um registro privado do {{site.data.keyword.Bluemix_notm}}.

1.  Crie o segredo do Kubernetes para armazenar suas credenciais de registro privado.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabela 5. Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Necessário. O namespace do Kubernetes do cluster no qual você deseja usar o segredo e implementar contêineres. Execute <code>kubectl get namespaces</code> para listar todos os namespaces em seu cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Necessário. O nome que você deseja usar para seu imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Necessário. A URL para o registro no qual as imagens privadas são armazenadas.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Necessário. O nome do usuário para efetuar login no seu registro privado.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Necessário. O valor do token de registro que você recuperou anteriormente.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Necessário. Se você tiver um, insira seu endereço de e-mail do Docker. Se não tiver um, insira um endereço de e-mail fictício, por exemplo a@b.c. Esse e-mail é obrigatório para criar um segredo do Kubernetes, mas não é usado após a criação.</td>
    </tr>
    </tbody></table>

2.  Verifique se o segredo foi criado com êxito. Substitua <em>&lt;kubernetes_namespace&gt;</em> pelo nome do namespace no qual você criou o imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  Crie um pod que referencie o imagePullSecret.
    1.  Crie um arquivo de configuração de pod que seja denominado `mypod.yaml`.
    2.  Defina o pod e o imagePullSecret que você deseja usar para acessar o registro privado do {{site.data.keyword.Bluemix_notm}}. Para usar uma imagem privada do seu registro privado:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tabela 6. Entendendo os componentes de arquivo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>O nome do pod que você deseja criar.</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>O nome do contêiner que você deseja implementar em seu cluster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>O caminho completo para a imagem em seu registro privado que você deseja usar.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>A versão da imagem que você deseja usar. Se nenhuma tag for especificada, a imagem identificada como <strong>mais recente</strong> será usada por padrão.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>O nome do imagePullSecret que você criou anteriormente.</td>
        </tr>
        </tbody></table>

  3.  Salve as suas mudanças.
  4.  Crie a implementação em seu cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## Incluindo serviços do {{site.data.keyword.Bluemix_notm}} nos clusters
{: #cs_cluster_service}

Incluindo uma instância de serviço existente do {{site.data.keyword.Bluemix_notm}} em seu cluster para permitir que os usuários do cluster acessem e usem o serviço do {{site.data.keyword.Bluemix_notm}} ao implementarem um app no cluster.
{:shortdesc}

Antes de iniciar:

1. [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.
2. [Solicite uma instância do serviço do {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).
   **Nota:** para criar uma instância de um serviço no local Washington DC, deve-se usar a CLI.
3. Para usuários do {{site.data.keyword.Bluemix_dedicated_notm}}, veja [Incluindo serviços do {{site.data.keyword.Bluemix_notm}} em clusters no {{site.data.keyword.Bluemix_dedicated_notm}} (beta encerrado)](#binding_dedicated).

**Nota:**
<ul><ul>
<li>É possível incluir apenas serviços do {{site.data.keyword.Bluemix_notm}}
que suportem chaves de serviço. Se o serviço não suportar chaves de serviço, veja [Ativando apps externos para usar serviços do {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).</li>
<li>O cluster e os nós do trabalhador devem ser implementados totalmente antes de poder incluir um serviço.</li>
</ul></ul>


Para incluir um serviço:
2.  Liste os serviços do {{site.data.keyword.Bluemix_notm}} disponíveis.

    ```
    bx service list
    ```
    {: pre}

    Exemplo de saída da CLI:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  Anote o **nome** da instância de serviço que você deseja incluir em seu cluster.
4.  Identifique o espaço de nomes de cluster que você deseja usar para incluir o seu serviço. Escolha entre as opções a seguir.
    -   Liste os namespaces existentes e escolha um namespace que você deseja usar.

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   Crie um novo namespace no cluster.

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  Inclua o serviço em seu cluster.

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    Quando o serviço é incluído com sucesso em seu cluster, é criado um segredo de cluster que contém as credenciais de sua instância de serviço. Exemplo de saída da CLI:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Verifique se o segredo foi criado no namespace do cluster.

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


Para usar o serviço em um pod implementado no cluster, os usuários do cluster poderão acessar as credenciais de serviço do serviço do {{site.data.keyword.Bluemix_notm}} [montando o segredo do Kubernetes como um volume de segredo para um pod](cs_apps.html#cs_apps_service).

### Incluindo serviços do {{site.data.keyword.Bluemix_notm}} em clusters no {{site.data.keyword.Bluemix_dedicated_notm}} (beta encerrado)
{: #binding_dedicated}

**Nota**: o cluster e os nós do trabalhador devem ser implementados totalmente antes de poder incluir um serviço.

1.  Configure o caminho para seu arquivo de configuração local do {{site.data.keyword.Bluemix_dedicated_notm}} como a variável de ambiente `DEDICATED_BLUEMIX_CONFIG`.

    ```
    export DEDICATED_BLUEMIX_CONFIG=<path_to_config_directory>
    ```
    {: pre}

2.  Configure o mesmo caminho definido acima como a variável de ambiente `BLUEMIX_HOME`.

    ```
    export BLUEMIX_HOME=$DEDICATED_BLUEMIX_CONFIG
    ```
    {: pre}

3.  Efetue login no ambiente do {{site.data.keyword.Bluemix_dedicated_notm}} no qual você deseja criar a instância de serviço.

    ```
    bx login -a api.<dedicated_domain> -u <user> -p <password> -o <org> -s <space>
    ```
    {: pre}

4.  Liste os serviços disponíveis no catálogo do {{site.data.keyword.Bluemix_notm}}.

    ```
    bx service offerings
    ```
    {: pre}

5.  Crie uma instância do serviço que você desejar ligar ao cluster.

    ```
    bx service create <service_name> <service_plan> <service_instance_name>
    ```
    {: pre}

6.  Verifique se você criou sua instância de serviço listando os serviços do {{site.data.keyword.Bluemix_notm}} disponíveis.

    ```
    bx service list
    ```
    {: pre}

    Exemplo de saída da CLI:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

7.  Desconfigure a variável de ambiente `BLUEMIX_HOME` para retornar ao uso do {{site.data.keyword.Bluemix_notm}} Public.

    ```
    unset $BLUEMIX_HOME
    ```
    {: pre}

8.  Efetue login no terminal público para o {{site.data.keyword.containershort_notm}} e direcione sua CLI para o cluster em seu ambiente do {{site.data.keyword.Bluemix_dedicated_notm}}.
    1.  Efetue login na conta usando o terminal público do {{site.data.keyword.containershort_notm}}. Insira as suas credenciais do {{site.data.keyword.Bluemix_notm}} e selecione a conta do {{site.data.keyword.Bluemix_dedicated_notm}} quando solicitado.

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

        **Nota:** se você tiver um ID federado, use `bx login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

    2.  Obtenha uma lista de clusters disponíveis e identifique o nome do cluster a ser destinado em sua CLI.

        ```
        bx cs clusters
        ```
        {: pre}

    3.  Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração do Kubernetes.

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

    4.  Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.

9.  Identifique o espaço de nomes de cluster que você deseja usar para incluir o seu serviço. Escolha entre as opções a seguir.
    * Liste os namespaces existentes e escolha um namespace que você deseja usar.
        ```
        kubectl get namespaces
        ```
        {: pre}

    * Crie um novo namespace no cluster.
        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

10.  Ligue a instância de serviço ao seu cluster.

      ```
      bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
      ```
      {: pre}

<br />


## Gerenciando o acesso ao cluster
{: #cs_cluster_user}

É possível conceder acesso a seu cluster para outros usuários, para que eles possam acessar o cluster, gerenciar o cluster e implementar apps no cluster.
{:shortdesc}

Cada usuário que trabalha com o {{site.data.keyword.containershort_notm}} deve ser designado a uma função de usuário específica do serviço no Identity and Access Management que determina quais ações esse usuário pode executar. O Identity and Access Management diferencia entre as permissões de acesso a seguir.

<dl>
<dt>Políticas de acesso do {{site.data.keyword.containershort_notm}}</dt>
<dd>As políticas de acesso determinam as ações de gerenciamento de cluster que é possível executar em um cluster, como criar ou remover clusters e incluir ou remover nós do trabalhador extras.</dd>
<dt>Grupos de recursos</dt>
<dd>Um grupo de recursos é uma maneira de organizar serviços do {{site.data.keyword.Bluemix_notm}} em agrupamentos para que seja possível designar rapidamente acesso de usuário para mais de um recurso por vez. Aprenda como [gerenciar usuários usando grupos de recursos](/docs/admin/resourcegroups.html#rgs).</dd>
<dt>Funções do RBAC</dt>
<dd>Cada usuário que é designado a uma política de acesso do {{site.data.keyword.containershort_notm}} é designado automaticamente a uma função RBAC. As funções RBAC determinam as ações que é possível executar em recursos do Kubernetes dentro do cluster. As funções RBAC são configuradas somente para o namespace padrão. O administrador de cluster pode incluir funções RBAC para outros namespaces no cluster. Veja [Usando a autorização RBAC ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) na documentação do Kubernetes para obter mais informações.</dd>
<dt>Funções do Cloud Foundry</dt>
<dd>Cada usuário deve ser designado a uma função de usuário do Cloud Foundry. Essa função determina as ações que o usuário pode executar na conta do {{site.data.keyword.Bluemix_notm}}, como convidar outros usuários ou visualizar o uso de cota. Para revisar as permissões de cada função, veja [Funções do Cloud Foundry](/docs/iam/cfaccess.html#cfaccess).</dd>
</dl>

Escolha entre as ações a seguir para continuar:

-   [Visualizar políticas e permissões de acesso necessárias para trabalhar com clusters](#access_ov).
-   [Visualizar sua política de acesso atual](#view_access).
-   [Mudar a política de acesso de um usuário existente](#change_access).
-   [Incluir usuários adicionais na conta do {{site.data.keyword.Bluemix_notm}}](#add_users).

### Visão geral de políticas e permissões de acesso necessárias do {{site.data.keyword.containershort_notm}}
{: #access_ov}

Revise as políticas e permissões de acesso que é possível conceder aos usuários em sua conta do {{site.data.keyword.Bluemix_notm}}. As funções de operador e editor têm permissões separadas. Se você deseja que um usuário, por exemplo, inclua nós do trabalhador e serviços de ligação, deve-se designar ao usuário as funções de operador e editor.

|Política de acesso|Permissões de gerenciamento de cluster|Permissões de recurso do Kubernetes|
|-------------|------------------------------|-------------------------------|
|<ul><li>Função: Administrador</li><li>Instâncias de serviço: todas as instâncias de serviço atuais</li></ul>|<ul><li>Criar um cluster lite ou padrão</li><li>Configure credenciais para uma conta do {{site.data.keyword.Bluemix_notm}} para acessar o portfólio da infraestrutura do IBM Cloud (SoftLayer)</li><li>Remover um Cluster</li><li>Designar e mudar as políticas de acesso do {{site.data.keyword.containershort_notm}} para outros usuários existentes nessa conta.</li></ul><br/>Essa função herda permissões do Editor, do Operador e funções do Visualizador para todos os clusters nessa conta.|<ul><li>Função RBAC: cluster-admin</li><li>Acesso de leitura/gravação para recursos em cada namespace</li><li>Criar funções dentro de um namespace</li><li>Acessar o painel do Kubernetes</li><li>Crie um recurso Ingresso que torne os aplicativos disponíveis</li></ul>|
|<ul><li>Função: Administrador</li><li>Instâncias de serviço: um ID de cluster específico</li></ul>|<ul><li>Remover um cluster específico.</li></ul><br/>Essa função herda permissões do Editor, do Operador e funções Visualizador para o cluster selecionado.|<ul><li>Função RBAC: cluster-admin</li><li>Acesso de leitura/gravação para recursos em cada namespace</li><li>Criar funções dentro de um namespace</li><li>Acessar o painel do Kubernetes</li><li>Crie um recurso Ingresso que torne os aplicativos disponíveis</li></ul>|
|<ul><li>Função: Operador</li><li>Instâncias de serviço: todas as instâncias de serviço atuais/um ID do cluster específico</li></ul>|<ul><li>Incluir nós do trabalhador adicionais em um cluster</li><li>Remover nós do trabalhador de um cluster</li><li>Reinicializar um nó do trabalhador</li><li>Recarregar um nó do trabalhador</li><li>Incluir uma sub-rede em um cluster</li></ul>|<ul><li>Função do RBAC: administrador</li><li>Acesso de leitura/gravação para recursos dentro do namespace padrão, mas não no próprio namespace</li><li>Criar funções dentro de um namespace</li></ul>|
|<ul><li>Função: editor</li><li>Instâncias de serviço: todas as instâncias de serviço atuais/um ID do cluster específico</li></ul>|<ul><li>Ligar um serviço do {{site.data.keyword.Bluemix_notm}} a um cluster.</li><li>Desvincular um serviço do {{site.data.keyword.Bluemix_notm}} para um cluster.</li><li>Criar um webhook.</li></ul><br/>Use essa função para seus desenvolvedores de aplicativo.|<ul><li>Funções RBAC: editar</li><li>Acesso de leitura/gravação para recursos dentro do namespace padrão</li></ul>|
|<ul><li>Função: visualizador</li><li>Instâncias de serviço: todas as instâncias de serviço atuais/um ID do cluster específico</li></ul>|<ul><li>Listar um cluster</li><li>Visualizar detalhes para um cluster</li></ul>|<ul><li>Funções RBAC: visualização</li><li>Acesso de leitura para recursos dentro do namespace padrão</li><li>Nenhum acesso de leitura para segredos do Kubernetes</li></ul>|
|<ul><li>Função de organização do Cloud Foundry: gerenciador</li></ul>|<ul><li>Incluir usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|<ul><li>Função de espaço do Cloud Foundry: desenvolvedor</li></ul>|<ul><li>Criar {{site.data.keyword.Bluemix_notm}} instâncias de serviço/li><li>Ligar instâncias de serviço do {{site.data.keyword.Bluemix_notm}} a clusters</li></ul>| |
{: caption="Tabela 7. Visão geral das políticas de acesso e permissões do {{site.data.keyword.containershort_notm}} necessárias" caption-side="top"}

### Verificando sua política de acesso do {{site.data.keyword.containershort_notm}}
{: #view_access}

É possível revisar e verificar sua política de acesso designada para o {{site.data.keyword.containershort_notm}}. A política de acesso determina as ações de gerenciamento de cluster que é possível executar.

1.  Selecione a conta do {{site.data.keyword.Bluemix_notm}} na qual você deseja verificar sua política de acesso do {{site.data.keyword.containershort_notm}}.
2.  Na barra de menus, clique em **Gerenciar** > **Segurança** > **Identidade e acesso**. A janela **Usuários** exibe uma lista de usuários com seus endereços de e-mail e status atual para a conta selecionada.
3.  Selecione o usuário para o qual você deseja verificar a política de acesso.
4.  Na seção **Políticas de acesso**, revise a política de acesso para o usuário. Para localizar informações detalhadas sobre as ações que podem ser executadas com essa função, veja [Visão Geral de políticas e permissões de acesso necessárias do {{site.data.keyword.containershort_notm}}](#access_ov).
5.  Opcional: [Mude sua política de acesso atual](#change_access).

    **Nota:** apenas usuários com uma política de serviço de Administrador designada para todos os recursos no {{site.data.keyword.containershort_notm}} pode mudar a política de acesso para um usuário existente. Para incluir usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}}, deve-se ter a função de Gerenciador do Cloud Foundry para a conta. Para localizar o ID do proprietário da conta do {{site.data.keyword.Bluemix_notm}}, execute `bx iam accounts` e procure o **ID do usuário do proprietário**.


### Mudando a política de acesso do {{site.data.keyword.containershort_notm}} para um usuário existente
{: #change_access}

É possível mudar a política de acesso para um usuário existente para conceder permissões de gerenciamento de cluster para um cluster em sua conta do {{site.data.keyword.Bluemix_notm}}.

Antes de iniciar, [verifique se você foi designado à política de acesso de Administrador](#view_access) para todos os recursos no {{site.data.keyword.containershort_notm}}.

1.  Selecione a conta do {{site.data.keyword.Bluemix_notm}} na qual você deseja mudar a política de acesso do {{site.data.keyword.containershort_notm}} para um usuário existente.
2.  Na barra de menus, clique em **Gerenciar** > **Segurança** > **Identidade e acesso**. A janela **Usuários** exibe uma lista de usuários com seus endereços de e-mail e status atual para a conta selecionada.
3.  Localize o usuário para quem você deseja mudar a política de acesso. Se você não localizar o usuário que está procurando, [convide esse usuário para a conta do {{site.data.keyword.Bluemix_notm}}](#add_users).
4.  Nas **Políticas de acesso**, na linha **Função**, sob a coluna **Ações**, expanda e clique em **Editar política**.
5.  Na lista suspensa **Serviço**, selecione **{{site.data.keyword.containershort_notm}}**.
6.  Na lista suspensa **Regiões**, selecione a região para a qual você deseja mudar a política.
7.  Na lista suspensa **Instância de serviço**, selecione o cluster para o qual você deseja mudar a política. Para localizar o ID de um cluster específico, execute `bx cs clusters`.
8.  Na seção **Selecionar funções**, clique na função para a qual você deseja mudar o acesso do usuário. Para localizar uma lista de ações suportadas por função, veja [Visão geral de políticas de acesso e permissões do {{site.data.keyword.containershort_notm}} necessárias](#access_ov).
9.  Clique em **Salvar** para salvar suas mudanças.

### Incluindo usuários em uma conta do {{site.data.keyword.Bluemix_notm}}
{: #add_users}

É possível incluir usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}} para conceder acesso aos seus clusters.

Antes de iniciar, verifique se você foi designado à função de Gerenciador do Cloud Foundry para uma conta do {{site.data.keyword.Bluemix_notm}}.

1.  Selecione a conta do {{site.data.keyword.Bluemix_notm}} na qual deseja incluir usuários.
2.  Na barra de menus, clique em **Gerenciar** > **Segurança** > **Identidade e acesso**. A janela Usuários exibe uma lista de usuários com seus endereços de e-mail e o status atual para a conta selecionada.
3.  Clique em **Convidar usuários**.
4.  Em **Endereço de e-mail**, insira o endereço de e-mail do usuário que você deseja incluir na conta do {{site.data.keyword.Bluemix_notm}}.
5.  Na seção **Acesso**, expanda **Serviços**.
6.  Na lista suspensa **Designar acesso a**, decida se você deseja conceder acesso somente à sua conta do {{site.data.keyword.containershort_notm}} (**Recurso**) ou a uma coleção de vários recursos dentro de sua conta (**Grupo de recursos**).
7.  Se **Recurso**:
    1. Na lista suspensa **Serviços**, selecione **{{site.data.keyword.containershort_notm}}**.
    2. Na lista suspensa **Região**, selecione a região para a qual você deseja convidar o usuário.
    3. Na lista suspensa **Instância de serviço**, selecione o cluster para o qual você deseja convidar o usuário. Para localizar o ID de um cluster específico, execute `bx cs clusters`.
    4. Na seção **Selecionar funções**, clique na função para a qual você deseja mudar o acesso do usuário. Para localizar uma lista de ações suportadas por função, veja [Visão geral de políticas de acesso e permissões do {{site.data.keyword.containershort_notm}} necessárias](#access_ov).
8. Se **Grupo de recursos**:
    1. Na lista suspensa **Grupo de recursos**, selecione o grupo de recursos que inclui permissões para o recurso {{site.data.keyword.containershort_notm}} de sua conta.
    2. Na lista suspensa **Designar acesso a um grupo de recursos**, selecione a função que você deseja que o usuário convidado tenha. Para localizar uma lista de ações suportadas por função, veja [Visão geral de políticas de acesso e permissões do {{site.data.keyword.containershort_notm}} necessárias](#access_ov).
9. Opcional: para permitir que esse usuário inclua usuários adicionais em uma conta do {{site.data.keyword.Bluemix_notm}}, designe ao usuário uma função de organização do Cloud Foundry.
    1. Na seção **Funções do Cloud Foundry**, na lista suspensa **Organização**, selecione a organização para a qual você deseja conceder as permissões de usuário.
    2. Na lista suspensa **Funções de organização**, selecione **Gerenciador**.
    3. Na lista suspensa **Região**, selecione a região para a qual você deseja conceder as permissões de usuário.
    4. Na lista suspensa **Espaço**, selecione o espaço para o qual você deseja conceder permissões de usuário.
    5. Na lista suspensa **Funções de espaço**, selecione **Gerenciador**.
10. Clique em **Convidar usuários**.

<br />


## Atualizando o mestre do Kubernetes
{: #cs_cluster_update}

O Kubernetes atualiza periodicamente as [versões principal, secundária e de correção](cs_versions.html#version_types), o que afeta os clusters. Atualizar um cluster é um processo de duas etapas. Primeiro, deve-se atualizar o mestre do Kubernetes e, em seguida, é possível atualizar cada um dos nós do trabalhador.

Por padrão, não será possível atualizar um mestre do Kubernetes mais de duas versões secundárias à frente. Por exemplo, se o seu mestre atual for versão 1.5 e você desejar atualizar para 1.8, deve-se atualizar para 1.7 primeiro. É possível forçar a atualização para continuar, mas atualizar mais de duas versões secundárias poderá causar resultados inesperados.

**Atenção**: siga as instruções de atualização e use um cluster de teste para direcionar potenciais indisponibilidades de app e interrupções durante a atualização. Não é possível recuperar um cluster para uma versão anterior.

Ao fazer uma atualização _principal_ ou _menor_, conclua as etapas a seguir.

1. Revise as [mudanças do Kubernetes](cs_versions.html) e faça as atualizações marcadas como _Atualizar antes do mestre_.
2. Atualize seu mestre do Kubernetes usando a GUI ou executando o [comando da CLI](cs_cli_reference.html#cs_cluster_update). Ao atualizar o mestre do Kubernetes, o mestre estará inativo por cerca de 5 a 10 minutos. Durante a atualização, não é possível acessar nem mudar o cluster. No entanto, os nós do trabalhador, apps e recursos que os usuários do cluster implementaram não serão modificados e continuarão a executar.
3. Confirme que a atualização foi concluída. Revise a versão do Kubernetes no Painel do {{site.data.keyword.Bluemix_notm}} ou execute `bx cs clusters`.

Quando a atualização do mestre do Kubernetes for concluída, será possível atualizar seus nós do trabalhador.

<br />


## Atualizando nós do trabalhador
{: #cs_cluster_worker_update}

Embora a IBM aplique correções automaticamente ao mestre do Kubernetes, deve-se atualizar explicitamente os nós do trabalhador para as atualizações principal e secundária. A versão do nó do trabalhador não pode ser maior que o mestre do Kubernetes.

**Atenção**: as atualizações para os nós do trabalhador podem causar tempo de inatividade para seus apps e serviços:
- Os dados são excluídos se não armazenados fora do pod.
- Use [réplicas ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) em suas implementações para reagendar os pods em nós disponíveis.

Atualizando clusters de nível de produção:
- Para ajudar a evitar o tempo de inatividade para seus apps, o processo de atualização evita que os pods sejam planejados no nó do trabalhador durante a atualização. Veja [`kubectl drain` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#drain) para obter mais informações.
- Use um cluster de teste para validar que suas cargas de trabalho e o processo de entrega não sejam afetados pela atualização. Não é possível retroceder nós do trabalhador para uma versão anterior.
- Os clusters de nível de produção devem ter capacidade para permanecer no caso de falha do nó do trabalhador. Se seu cluster não permanecer, inclua um nó do trabalhador antes de atualizar o cluster.
- Uma atualização contínua é executada quando múltiplos nós do trabalhador são solicitados para fazer upgrade. Um máximo de 20 por cento da quantia total de nós do trabalhador em um cluster pode ser atualizada simultaneamente. O processo de upgrade aguarda um nó do trabalhador concluir o upgrade antes que outro trabalhador inicie o upgrade.


1. Instale a versão do [`kubectl cli` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) que corresponde à versão do Kubernetes do mestre do Kubernetes.

2. Faça quaisquer mudanças que estejam marcadas como _Atualizar após o mestre_ em [Mudanças do Kubernetes](cs_versions.html).

3. Atualize seus nós do trabalhador:
  * Para atualizar do Painel do {{site.data.keyword.Bluemix_notm}}, navegue para a seção `Nós do trabalhador` de seu cluster e clique em `Atualizar trabalhador`.
  * Para obter IDs de nó do trabalhador, execute `bx cs workers <cluster_name_or_id>`. Se você selecionar múltiplos nós do trabalhador, os nós do trabalhador serão atualizados um por vez.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Confirme se a atualização foi concluída:
  * Revise a versão do Kubernetes no Painel do {{site.data.keyword.Bluemix_notm}} ou execute `bx cs workers <cluster_name_or_id>`.
  * Revise a versão do Kubernets dos nós do trabalhador executando `kubectl get nodes`.
  * Em alguns casos, clusters mais velhos podem listar nós do trabalhador duplicados com um status de **NotReady** após uma atualização. Para remover duplicatas, consulte [Resolução de problemas](cs_troubleshoot.html#cs_duplicate_nodes).

Depois de concluir a atualização:
  - Repita o processo de atualização com outros clusters.
  - Informe aos desenvolvedores que trabalham no cluster para atualizar sua CLI `kubectl` para a versão do mestre do Kubernetes.
  - Se o painel do Kubernetes não exibir gráficos de utilização, [exclua o pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).

<br />


## Incluindo sub-redes nos clusters
{: #cs_cluster_subnet}

Mude o conjunto de endereços IP públicos ou privados móveis disponíveis, incluindo sub-redes em seu cluster.
{:shortdesc}

No {{site.data.keyword.containershort_notm}}, é possível incluir IPs móveis estáveis para serviços do Kubernetes, incluindo sub-redes da rede no cluster. Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} provisiona automaticamente uma sub-rede pública móvel com 5 endereços IP públicos e uma sub-rede privada móvel com 5 endereços IP privados. Os endereços IP públicos e privados móveis são estáticos e não mudam quando um nó do trabalhador ou mesmo o cluster é removido.

Um dos endereços IP públicos móveis e um dos endereços IP privados móveis são usados para [Controladores de Ingresso](cs_apps.html#cs_apps_public_ingress) que podem ser usados para expor múltiplos apps em seu cluster. Os 4 endereços IP públicos móveis e os 4 endereços IP privados móveis podem ser usados para expor apps únicos ao público [criando um serviço de balanceador de carga](cs_apps.html#cs_apps_public_load_balancer).

**Nota:** os endereços IP públicos móveis são cobrados mensalmente. Se escolher remover os endereços IP públicos móveis depois que o cluster for provisionado, ainda assim terá que pagar o encargo mensal, mesmo se você os usou por um curto tempo.

### Solicitando sub-redes adicionais para seu cluster
{: #add_subnet}

É possível incluir IPs públicos ou privados móveis e estáveis no cluster designando sub-redes para o cluster.

Para usuários do {{site.data.keyword.Bluemix_dedicated_notm}}, em vez de usar essa tarefa, deve-se [abrir um chamado de suporte](/docs/support/index.html#contacting-support) para criar a sub-rede e, em seguida, usar o comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para incluir a sub-rede no cluster.

Antes de iniciar, certifique-se de que seja possível acessar o portfólio da infraestrutura do IBM Cloud (SoftLayer) por meio da GUI do {{site.data.keyword.Bluemix_notm}}. Para acessar o portfólio, deve-se configurar ou usar uma conta Pay-As-You-Go existente do {{site.data.keyword.Bluemix_notm}}.

1.  No catálogo, na seção **Infraestrutura**, selecione **Rede**.
2.  Selecione **Sub-rede/IPs** e clique em **Criar**.
3.  No menu suspenso **Selecione o tipo de sub-rede para incluir nesta conta**, selecione **Público móvel** ou **Privado móvel**.
4.  Selecione o número de endereços IP que você deseja incluir de sua sub-rede móvel.

    **Nota:** quando você inclui endereços IP móveis para sua sub-rede, três endereços IP são usados para estabelecer a rede interna do cluster, de forma que não seja possível usá-los para seu controlador do Ingresso ou para criar um serviço de balanceador de carga. Por exemplo, se você solicitar oito endereços IP públicos móveis, será possível usar cinco deles para expor os seus apps ao público.

5.  Selecione a VLAN pública ou privada para a qual você deseja rotear os endereços IP públicos ou privados móveis. Deve-se selecionar a VLAN pública ou privada à qual um nó do trabalhador existente está conectado. Revise a VLAN pública ou privada para um nó do trabalhador.

    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  Preencha o questionário e clique em **Fazer pedido**.

    **Nota:** os endereços IP públicos móveis são cobrados mensalmente. Se você escolher remover os endereços
IP públicos móveis após criá-los, ainda assim deve-se pagar o encargo mensal, mesmo se os tiver usado
somente parte do mês.

7.  Após a sub-rede ser provisionada, torne a sub-rede disponível para seu cluster do Kubernetes.
    1.  No painel Infraestrutura, selecione a sub-rede criada e anote o ID da sub-rede.
    2.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Para especificar uma região do {{site.data.keyword.Bluemix_notm}}, [inclua o terminal de API](cs_regions.html#bluemix_regions).

        ```
        bx login
        ```
        {: pre}

        **Nota:** se você tiver um ID federado, use `bx login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.

    3.  Liste todos os clusters em sua conta e anote o ID do cluster no qual você deseja tornar sua sub-rede disponível.

        ```
        bx cs clusters
        ```
        {: pre}

    4.  Inclua a sub-rede em seu cluster. Quando você disponibiliza uma sub-rede para um cluster, é criado um mapa de configuração do Kubernetes para você que inclui todos os endereços IP públicos ou privados móveis disponíveis que podem ser usados. Se não existir nenhum controlador de Ingresso para o cluster, um endereço IP público móvel será usado automaticamente para criar o controlador de Ingresso público e um endereço IP privado móvel será usado automaticamente para criar o controlador de Ingresso privado. Todos os outros endereços IP públicos e privados móveis podem ser usados para criar serviços de balanceador de carga para seus apps.

        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  Verifique se a sub-rede foi incluída com êxito em seu cluster. A sub-rede CIDR é listada na seção **VLANs**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Incluindo sub-redes customizadas e existentes nos clusters do Kubernetes
{: #custom_subnet}

É possível incluir sub-redes públicas ou privadas móveis existentes em seu cluster do Kubernetes.

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Se você tiver uma sub-rede existente no portfólio da infraestrutura do IBM Cloud (SoftLayer) com regras de firewall customizado ou endereços IP disponíveis que deseja usar, crie um cluster sem sub-rede e disponibilize sua sub-rede existente para o cluster quando o cluster provisionar.

1.  Identifique a sub-rede a ser usada. Observe o ID da sub-rede e o ID da VLAN. Neste exemplo, o ID da sub-rede é 807861 e o ID da VLAN é 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Confirme a localização da VLAN. Neste exemplo, o local é dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Crie um cluster usando o local e o ID da VLAN identificados. Inclua a sinalização `--no-subnet` para evitar que uma nova sub-rede IP pública móvel e uma nova sub-rede IP privada móvel seja criada automaticamente.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Verifique se a criação do cluster foi solicitada.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** pode levar até 15 minutos para que as máquinas do nó do trabalhador sejam ordenadas e para que o cluster seja configurado e provisionado em sua conta.

    Quando o fornecimento do cluster é concluído, o status do cluster muda para **implementado**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Verifique o status dos nós do trabalhador.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando os nós do trabalhador estiverem prontos, o estado mudará para **normal** e o status será **Pronto**. Quando o status do nó for **Pronto**, será possível, então, acessar o cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Inclua a sub-rede em seu cluster especificando o ID da sub-rede. Quando você disponibiliza uma sub-rede para um cluster, é criado um mapa de configuração do Kubernetes para você que inclui todos os endereços IP públicos móveis disponíveis que podem ser usados. Se nenhum controlador do Ingresso já existir para o seu cluster, um endereço IP público móvel será automaticamente usado para criar o controlador do Ingresso. Todos os outros endereços IP públicos móveis podem ser usados para criar serviços de balanceador de carga para os seus apps.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Incluindo sub-redes gerenciadas por usuário e endereços IP para clusters do Kubernetes
{: #user_subnet}

Forneça sua própria sub-rede de uma rede no local que você desejar que o {{site.data.keyword.containershort_notm}} acesse. Em seguida, é possível incluir endereços IP privados dessa sub-rede para serviços de balanceador de carga em seu cluster do Kubernetes.

Requisitos:
- Sub-redes gerenciadas pelo usuário podem ser incluídas em VLANs privadas apenas.
- O limite de comprimento de prefixo de sub-rede é /24 para /30. Por exemplo, `203.0.113.0/24` especifica 253 endereços IP privados utilizáveis, enquanto `203.0.113.0/30` especifica 1 endereço IP privado utilizável.
- O primeiro endereço IP na sub-rede deve ser usado como o gateway para a sub-rede.

Antes de iniciar: configure o roteamento de tráfego de rede dentro e fora da sub-rede externa. Além disso, confirme se você tem conectividade VPN entre o dispositivo de gateway do data center no local e a rede privada Vyatta em seu portfólio de infraestrutura do IBM Cloud (SoftLayer). Para obter mais informações, consulte esta [postagem do blog ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

1. Visualize o ID de VLAN privada do seu cluster. Localize a seção **VLANs**. No campo **Gerenciado pelo usuário**, identifique o ID da VLAN com _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Inclua a sub-rede externa em sua VLAN privada. Os endereços IP privados móveis são incluídos no mapa de configuração do cluster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemplo:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Verifique se a sub-rede fornecida pelo usuário foi incluída. O campo **Gerenciado pelo usuário** é _true_.

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

4. Inclua um balanceador de carga privado para acessar seu app na rede privada. Se você desejar usar um endereço IP privado por meio da sub-rede que você incluiu, deverá especificar um endereço IP ao criar um balanceador de carga privado. Caso contrário, um endereço IP será escolhido aleatoriamente das sub-redes de infraestrutura do IBM Cloud (SoftLayer) ou sub-redes fornecidas pelo usuário na VLAN privada. Para obter mais informações, consulte [Configurando acesso a um app](cs_apps.html#cs_apps_public_load_balancer).

    Arquivo de configuração de exemplo para um serviço de balanceador de carga privado com um endereço IP especificado:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <myservice>
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    spec:
      type: LoadBalancer
      selector:
        <selectorkey>:<selectorvalue>
      ports:
       - protocol: TCP
         port: 8080
      loadBalancerIP: <private_ip_address>
    ```
    {: codeblock}

<br />


## Usando compartilhamentos de arquivo NFS existentes em clusters
{: #cs_cluster_volume_create}

Se você já tiver compartilhamentos de arquivos NFS existentes em sua conta de infraestrutura do IBM Cloud (SoftLayer) que deseja usar com o Kubernetes, será possível fazer isso criando volumes persistentes em seu compartilhamento de arquivo NFS existente. Um volume persistente é uma parte de hardware real que serve como um recurso de cluster do Kubernetes e pode ser consumido pelo usuário do cluster.
{:shortdesc}

O Kubernetes diferencia entre volumes persistentes que representam o hardware real e as solicitações de volume persistente que são solicitações para armazenamento geralmente iniciado pelo usuário do cluster. O diagrama a seguir ilustra o relacionamento entre volumes persistentes e solicitações de volumes persistentes.

![Criar volumes persistentes e solicitações de volumes persistentes](images/cs_cluster_pv_pvc.png)

 Conforme descrito no diagrama, para permitir que os compartilhamentos de arquivos NFS existentes sejam usados com o Kubernetes, deve-se criar volumes persistentes com um determinado tamanho e modo de acesso e criar uma solicitação de volume persistente que corresponda à especificação de volume persistente. Se o volume persistente e a solicitação de volume persistente correspondem, eles estão ligados entre si. Somente as solicitações de volume persistente ligadas podem ser usadas pelo usuário do cluster para montar o volume em um pod. Esse processo é referido como fornecimento estático de armazenamento persistente.

Antes de iniciar, certifique-se de que você tenha um compartilhamento de arquivo NFS existente que seja possível usar para criar seu volume persistente.

**Nota:** o fornecimento estático de armazenamento persistente se aplica somente a compartilhamentos de arquivo NFS existentes. Se você não tem compartilhamentos de arquivo NFS existentes, os usuários do cluster podem usar o processo de [fornecimento dinâmico](cs_apps.html#cs_apps_volume_claim) para incluir volumes persistentes.

Para criar um volume persistente e uma solicitação de volume persistente correspondente, siga estas etapas.

1.  Em sua conta de infraestrutura do IBM Cloud (SoftLayer), consulte o ID e o caminho do compartilhamento de arquivo NFS no qual você deseja criar seu objeto de volume persistente.
    1.  Efetue login em sua conta de infraestrutura do IBM Cloud (SoftLayer).
    2.  Clique em **Armazenamento**.
    3.  Clique em **Armazenamento de arquivo** e anote o ID e o caminho do compartilhamento de arquivo NFS que você deseja usar.
2.  Abra seu editor preferencial.
3.  Crie um arquivo de configuração de armazenamento para seu volume persistente.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.softlayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Tabela 8. Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Insira o nome do objeto de volume persistente que você deseja criar.</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>Insira o tamanho de armazenamento do compartilhamento de arquivo NFS existente. O tamanho de armazenamento deve ser gravado em gigabytes, por exemplo, 20Gi (20 GB) ou 1000Gi (1 TB), e o tamanho deve corresponder ao tamanho do compartilhamento de arquivo existente.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Os modos de acesso definem a maneira como a solicitação de volume persistente pode ser montada em um nó do trabalhador.<ul><li>ReadWriteOnce (RWO): o volume persistente pode ser montado em pods somente em um único nó do trabalhador. Os pods que são montados nesse volume persistente pode ler e gravar no volume.</li><li>ReadOnlyMany (ROX): o volume persistente pode ser montado em pods que estão hospedados em múltiplos nós do trabalhador. Os pods que são montados nesse volume persistente podem ler somente no volume.</li><li>ReadWriteMany (RWX): esse volume persistente pode ser montado em pods que estão hospedados em múltiplos nós do trabalhador. Os pods que são montados nesse volume persistente pode ler e gravar no volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Insira o ID do servidor de compartilhamento de arquivo NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Insira o caminho para o compartilhamento de arquivo NFS no qual você deseja criar o objeto de volume persistente.</td>
    </tr>
    </tbody></table>

4.  Crie o objeto de volume persistente em seu cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Exemplo

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

5.  Verifique se o volume persistente é criado.

    ```
    kubectl get pv
    ```
    {: pre}

6.  Crie outro arquivo de configuração para criar sua solicitação de volume persistente. Para que a solicitação de volume persistente corresponda ao objeto de volume persistente que você criou anteriormente, deve-se escolher o mesmo valor para `storage` e `accessMode`. O campo `storage-class` deve estar vazio. Se algum desses campos não corresponder ao volume persistente, um novo volume persistente será criado automaticamente no lugar.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

7.  Crie sua solicitação de volume persistente.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

8.  Verifique se sua solicitação de volume persistente foi criada e ligada ao objeto de volume persistente. Esse processo pode levar alguns minutos.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Sua saída é semelhante à mostrada a seguir.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Você criou com êxito um objeto de volume persistente e o ligou a uma solicitação de volume persistente. Os usuários do cluster agora podem [montar a solicitação de volume persistente](cs_apps.html#cs_apps_volume_mount) para seu pod e começar a ler e gravar no objeto de volume persistente.

<br />


## Configurando a criação de log de cluster
{: #cs_logging}

Os logs o ajudam a solucionar problemas com seus clusters e apps. Às vezes, você pode desejar enviar logs para um local específico para processamento ou armazenamento de longo prazo. Em um cluster do Kubernetes no {{site.data.keyword.containershort_notm}}, é possível ativar o encaminhamento de log para seu cluster e escolher para onde os logs serão encaminhados. **Nota**: o encaminhamento de log é suportado somente para clusters padrão.
{:shortdesc}

### Exibindo logs
{: #cs_view_logs}

Para visualizar os logs para clusters e contêineres, é possível usar os recursos padrão do Kubernetes e de criação de log do Docker.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

Para clusters padrão, os logs estão localizados na conta do {{site.data.keyword.Bluemix_notm}} na qual você efetuou login quando criou o cluster do Kubernetes. Se você especificou um espaço do {{site.data.keyword.Bluemix_notm}} quando criou o cluster, então os logs estão localizados nesse espaço. Os logs de contêiner são monitorados e encaminhados para fora do contêiner. É possível acessar logs
para um contêiner usando o painel do Kibana. Para obter mais informações sobre a criação de log, consulte [Criação de log para o {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Nota**: se os logs estão localizados no espaço que você especificou na criação do cluster, o proprietário da conta precisa de permissões de Gerenciador, Desenvolvedor ou Auditor para esse espaço para visualizar logs. Para obter mais informações sobre como mudar políticas de acesso e permissões do {{site.data.keyword.containershort_notm}}, veja [Gerenciando o acesso ao cluster](cs_cluster.html#cs_cluster_user). Quando as permissões são mudadas, pode levar até 24 horas para os logs começarem a aparecer.

Para acessar o painel do Kibana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} em que você criou o cluster.
- Sul e Leste dos EUA: https://logging.ng.bluemix.net
- Sul do Reino Unido e UE Central: https://logging.eu-fra.bluemix.net

Para obter mais informações sobre como visualizar logs, veja [Navegando para o Kibana por meio de um navegador da web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

#### Logs do Docker
{: #cs_view_logs_docker}

É possível alavancar os recursos de criação de log do Docker integrados para revisar as atividades nos fluxos
de saída padrão STDOUT e STDERR. Para obter mais informações, veja [Visualizando logs de contêiner para um contêiner que é executado em um cluster do
Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

### Configurando o encaminhamento de log para um namespace do contêiner do Docker
{: #cs_configure_namespace_logs}

Por padrão, o {{site.data.keyword.containershort_notm}} encaminha logs de namespace de contêiner do Docker para o {{site.data.keyword.loganalysislong_notm}}. Também é possível encaminhar logs de namespace do contêiner para um servidor syslog externo criando uma nova configuração de encaminhamento de log.
{:shortdesc}

**Nota**: para visualizar logs no local Sydney, deve-se encaminhar logs para um servidor syslog externo.

#### Ativando o encaminhamento de log para syslog
{: #cs_namespace_enable}

Antes de iniciar:

1. Configure um servidor que possa aceitar um protocolo syslog de uma de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.
  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que execute um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

2. [Coloque como destino a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual o namespace estiver localizado.

Para encaminhar os logs do seu namespace para um servidor syslog:

1. Crie a configuração de criação de log.

    ```
    bx cs logging-config-create <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabela 9. Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>O comando para criar a configuração de encaminhamento de log para seu namespace.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--namespace <em>&lt;my_namespace&gt;</em></code></td>
    <td>Substitua <em>&lt;my_namespace&gt;</em> pelo nome do namespace. O encaminhamento de log não é suportado para os namespaces do Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Se você não especificar um namespace, então, todos os namespaces no contêiner usarão essa configuração.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_hostname&gt;</em> por um nome do host ou endereço IP do servidor coletor do log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_port&gt;</em> pela porta do servidor coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada para syslog.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>O tipo de log para syslog.</td>
    </tr>
    </tbody></table>

2. Verifique se a configuração de encaminhamento de log foi criada.

    * Para listar todas as configurações de criação de log no cluster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Saída de exemplo:

      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Configurações de namespace de log do contêiner --------------------------------------------- Protocolo de porta do host de namespace padrão myhostname.com 5514 syslog meu namespace localhost 5514 syslog
      ```
      {: screen}

    * Para listar as configurações de criação de log de namespace apenas:
      ```
      bx cs logging-config-get <my_cluster> --logsource namespaces
      ```
      {: pre}

      Saída de exemplo:

      ```
      Protocolo de porta do host de namespace padrão myhostname.com 5514 syslog meu namespace localhost 5514 syslog
      ```
      {: screen}

#### Atualizando a configuração do servidor syslog
{: #cs_namespace_update}

Se você desejar atualizar os detalhes para a configuração do servidor syslog atual ou mudar para um servidor syslog diferente, será possível atualizar a configuração de encaminhamento de criação de log.
{:shortdesc}

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual o namespace está localizado.

1. Atualize a configuração de encaminhamento de log.

    ```
    bx cs logging-config-update <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabela 10. Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>O comando para atualizar a configuração de encaminhamento de log para seu namespace.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--namepsace <em>&lt;my_namespace&gt;</em></code></td>
    <td>Substitua <em>&lt;my_namespace&gt;</em> pelo nome do namespace com a configuração de criação de log.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_hostname&gt;</em> por um nome do host ou endereço IP do servidor coletor do log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_port&gt;</em> pela porta do servidor coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>O tipo de criação de log para <code>syslog</code>.</td>
    </tr>
    </tbody></table>

2. Verifique se a configuração de encaminhamento de log foi atualizada.
    ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
    {: pre}

    Saída de exemplo:

    ```
    Protocolo de porta do host de namespace padrão myhostname.com 5514 syslog meu namespace localhost 5514 syslog
    ```
    {: screen}

#### Parando o encaminhamento de log para o syslog
{: #cs_namespace_delete}

É possível parar os logs de encaminhamento de um namespace excluindo a configuração de criação de log.

**Nota**: esta ação exclui apenas a configuração para logs de encaminhamento para um servidor syslog. Logs para o namespace continuam sendo encaminhados para o {{site.data.keyword.loganalysislong_notm}}.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual o namespace está localizado.

1. Exclua a configuração de criação de log.

    ```
    bx cs logging-config-rm <my_cluster> --namespace <my_namespace>
    ```
    {: pre}
    Substitua <em>&lt;my_cluster&gt;</em> pelo nome do cluster em que a configuração de criação de log está e <em>&lt;my_namespace&gt;</em> pelo nome do namespace.

### Configurando o encaminhamento de log para aplicativos, nós do trabalhador, o componente do sistema Kubernetes e o controlador de Ingresso
{: #cs_configure_log_source_logs}

Por padrão, o {{site.data.keyword.containershort_notm}} encaminha logs de namespace de contêiner do Docker para o {{site.data.keyword.loganalysislong_notm}}. Também é possível configurar o encaminhamento de log para outras origens de log, como aplicativos, nós do trabalhador, clusters do Kubernetes e controladores de Ingresso.
{:shortdesc}

Revise as opções a seguir para obter informações sobre cada origem de log.

|Origem de log|Características|Caminhos de log|
|----------|---------------|-----|
|`aplicação`|Logs para o seu próprio aplicativo que é executado em um cluster do Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`
|`worker`|Logs para os nós do trabalhador da máquina virtual em um cluster do Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`
|`kubernetes`|Logs para o componente do sistema Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`
|`ingress`|Logs para um controlador de Ingresso que gerencia o tráfego de rede entrando em um cluster do Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`
{: caption="Tabela 11. Características da origem de log." caption-side="top"}

#### Ativando o encaminhamento de log para aplicativos
{: #cs_apps_enable}

Logs de aplicativos devem ser restringidos a um diretório específico no nó do host. É possível fazer isso montando um volume de caminho do host para seus contêineres com um caminho de montagem. Esse caminho de montagem serve como o diretório em seus contêineres nos quais os logs de aplicativos são enviados. O diretório do caminho do host predefinido, `/var/log/apps`, é criado automaticamente quando você cria a montagem do volume.

Revise os aspectos de encaminhamento de log do aplicativo a seguir:
* Os logs são lidos recursivamente do caminho /var/log/apps. Isso significa que é possível colocar logs de aplicativos em subdiretórios do caminho /var/log/apps.
* Somente arquivos de log do aplicativo com extensões de arquivo `.log` ou `.err` são encaminhados.
* Quando você ativa o encaminhamento de log pela primeira vez, os logs de aplicativos são unilaterais em vez de serem lidos do topo. Isso significa que os conteúdos de quaisquer logs já presentes antes que a criação de log do aplicativo fosse ativada não são lidos. Os logs são lidos do ponto em que a criação de log foi ativada. No entanto, após a primeira vez que o encaminhamento de log é ativado, os logs são sempre capturados de onde eles pararam da última vez.
* Ao montar o volume do caminho do host `/var/log/apps` para contêineres, todos os contêineres são gravados nesse mesmo diretório. Isso significa que se os contêineres estiverem gravando no mesmo nome de arquivo, os contêineres gravarão exatamente no mesmo arquivo no host. Se essa não for a sua intenção, será possível evitar que seus contêineres sobrescrevam os mesmos arquivos de log nomeando os arquivos de log de cada contêiner de forma diferente.
* Como todos os contêineres gravam no mesmo nome de arquivo, não use esse método para encaminhar logs de aplicativos para ReplicaSets. Em vez disso, é possível gravar logs de aplicativos para STDOUT e STDERR. Esses logs são capturados como logs do contêiner e os logs do contêiner são encaminhados automaticamente para o {{site.data.keyword.loganalysisshort_notm}}. Para encaminhar logs de aplicativos gravados em STDOUT e STDERR para um servidor syslog externo, siga as etapas em [Ativando o encaminhamento de log para syslog](cs_cluster.html#cs_namespace_enable).

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

1. Abra o arquivo de configuração `.yaml` para o pod do aplicativo.

2. Inclua os `volumeMounts` e `volumes` no arquivo de configuração:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Monte o volume para o pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Para criar uma configuração de encaminhamento de log, siga as etapas em [Ativando o encaminhamento de log para os nós do trabalhador, o componente do sistema do Kubernetes e o controlador de Ingresso](cs_cluster.html#cs_log_sources_enable).

#### Ativando o encaminhamento de log para os nós do trabalhador, o componente do sistema do Kubernetes e o controlador de Ingresso
{: #cs_log_sources_enable}

É possível encaminhar logs para o {{site.data.keyword.loganalysislong_notm}} ou para um servidor syslog externo. Se você encaminha logs para o {{site.data.keyword.loganalysisshort_notm}}, eles são encaminhados para o mesmo espaço no qual o cluster foi criado. Se você deseja encaminhar logs de uma origem de log para ambos os servidores de coletor do log, deve-se criar duas configurações de criação de log.
{:shortdesc}

Antes de iniciar:

1. Se você deseja encaminhar logs para um servidor syslog externo, é possível configurar um servidor que aceite um protocolo do syslog de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.
  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que execute um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.
**Nota**: para visualizar logs no local Sydney, deve-se encaminhar logs para um servidor syslog externo.

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

Para ativar o encaminhamento de log para os nós do trabalhador, o componente do sistema do Kubernetes ou um controlador de Ingresso:

1. Crie uma configuração de encaminhamento de log.

  * Para encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}}:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --type ibm
    ```
    {: pre}
    Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster. Substitua <em>&lt;my_log_source&gt;</em> pela origem de log. Os valores aceitos são `application`, `worker`, `kubernetes` e `ingress`.

  * Para encaminhar logs para um servidor syslog externo:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabela 12. Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>O comando para criar a configuração de encaminhamento de log do syslog para sua origem de log.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Substitua <em>&lt;my_log_source&gt;</em> pela origem de log. Os valores aceitos são <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_hostname&gt;</em> por um nome do host ou endereço IP do servidor coletor do log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_port&gt;</em> pela porta do servidor coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada para syslog.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>O tipo de log para um servidor syslog externo.</td>
    </tr>
    </tbody></table>

2. Verifique se a configuração de encaminhamento de log foi criada.

    * Para listar todas as configurações de criação de log no cluster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Saída de exemplo:

      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Configurações de namespace de log do contêiner --------------------------------------------- Protocolo de porta do host de namespace padrão myhostname.com 5514 syslog meu namespace localhost 5514 syslog
      ```
      {: screen}

    * Para listar as configurações de criação de log para um tipo de origem de log:
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Saída de exemplo:

      ```
      Caminhos de protocolo de porta do host de origem de ID f4bc77c0-ee7d-422d-aabf-a4e6b977264e host local do trabalhador 5514 syslog /var/log/syslog,/var/log/auth.log 5bd9c609-13c8-4c48-9d6e-3a6664c825a9 trabalhador - - ibm /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### Atualizando o servidor de coletor do log
{: #cs_log_sources_update}

É possível atualizar uma configuração de criação de log para um aplicativo, os nós do trabalhador, o componente do sistema do Kubernetes e o controlador de Ingresso, mudando o servidor de coletor do log ou o tipo de log.
{: shortdesc}

**Nota**: para visualizar logs no local Sydney, deve-se encaminhar logs para um servidor syslog externo.

Antes de iniciar:

1. Se você estiver mudando o servidor de coletor do log para syslog, será possível configurar um servidor que aceite um protocolo do syslog de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.
  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que execute um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

Para mudar o servidor de coletor do log para sua origem de log:

1. Atualize a configuração de criação de log.

    ```
    bx cs logging-config-update <my_cluster> --id <log_source_id> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Tabela 13. Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>O comando para atualizar a configuração de encaminhamento de log para sua origem de log.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_source_id&gt;</em></code></td>
    <td>Substitua <em>&lt;log_source_id&gt;</em> pelo ID da configuração da origem de log.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Substitua <em>&lt;my_log_source&gt;</em> pela origem de log. Os valores aceitos são <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_hostname&gt;</em> por um nome do host ou endereço IP do servidor coletor do log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_port&gt;</em> pela porta do servidor coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada para syslog.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Substitua <em>&lt;logging_type&gt;</em> pelo novo protocolo de encaminhamento de log que você deseja usar. Atualmente, <code>syslog</code> e <code>ibm</code> são suportados.</td>
    </tr>
    </tbody></table>

2. Verifique se a configuração de encaminhamento de log foi atualizada.

  * Para listar todas as configurações de criação de log no cluster:
    ```
    bx cs logging-config-get <my_cluster>
    ```
    {: pre}

    Saída de exemplo:

    ```
    Logging Configurations
    ---------------------------------------------
    Id                                    Source        Host             Port    Protocol   Paths
    f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
    5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

    Configurações de namespace de log do contêiner --------------------------------------------- Protocolo de porta do host de namespace padrão myhostname.com 5514 syslog meu namespace localhost 5514 syslog
    ```
    {: screen}

  * Para listar as configurações de criação de log para um tipo de origem de log:
    ```
    bx cs logging-config-get <my_cluster> --logsource worker
    ```
    {: pre}

    Saída de exemplo:

    ```
    Caminhos de protocolo de porta do host de origem de ID f4bc77c0-ee7d-422d-aabf-a4e6b977264e host local do trabalhador 5514 syslog /var/log/syslog,/var/log/auth.log 5bd9c609-13c8-4c48-9d6e-3a6664c825a9 trabalhador - - ibm /var/log/syslog,/var/log/auth.log
    ```
    {: screen}

#### Parando o encaminhamento de log
{: #cs_log_sources_delete}

É possível parar os logs de encaminhamento excluindo a configuração de criação de log.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster no qual a origem de log está localizada.

1. Exclua a configuração de criação de log.

    ```
    bx cs logging-config-rm <my_cluster> --id <log_source_id>
    ```
    {: pre}
    Substitua <em>&lt;my_cluster&gt;</em> pelo nome do cluster em que a configuração de criação de log está e <em>&lt;log_source_id&gt;</em> pelo ID da configuração de origem de log.


## Configurando o monitoramento de cluster
{: #cs_monitoring}

As métricas ajudam a monitorar o funcionamento e o desempenho de seus clusters. É possível configurar o monitoramento de funcionamento para os nós do trabalhador para detectar e corrigir automaticamente quaisquer trabalhadores que entrarem em um estado comprometido ou não operacional. **Nota**: o monitoramento é suportado somente para clusters padrão.
{:shortdesc}

### Visualizando métricas
{: #cs_view_metrics}

É possível usar os recursos padrão do Kubernetes e do Docker para monitorar o funcionamento de seus clusters e apps.
{:shortdesc}

<dl>
<dt>Página de detalhes do cluster no {{site.data.keyword.Bluemix_notm}}</dt>
<dd>O {{site.data.keyword.containershort_notm}} fornece informações sobre o
funcionamento e a capacidade do cluster e o uso dos recursos de cluster. É possível usar essa GUI para ampliar o cluster, trabalhar com seu armazenamento persistente e incluir mais recursos em seu cluster por meio da ligação de serviços do {{site.data.keyword.Bluemix_notm}}. Para visualizar a página de detalhes do cluster, acesse o **Painel do {{site.data.keyword.Bluemix_notm}}** e selecione um cluster.</dd>
<dt>Painel do Kubernetes</dt>
<dd>O painel do Kubernetes é uma interface administrativa da web na qual é possível revisar o funcionamento de seus nós do trabalhador, localizar recursos do Kubernetes, implementar apps conteinerizados e solucionar problemas de apps usando informações de criação de log e de monitoramento. Para obter mais informações sobre como acessar o painel do Kubernetes, veja [Ativando o painel do Kubernetes para o {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>As métricas para clusters padrão estão localizadas na conta do {{site.data.keyword.Bluemix_notm}} para a qual o login foi efetuado quando o cluster do Kubernetes foi criado. Se você especificou um espaço do {{site.data.keyword.Bluemix_notm}} quando criou o cluster, as métricas estão localizadas nesse espaço. As métricas do contêiner são coletadas automaticamente para todos os contêineres que são implementados em um cluster. Essas métricas são enviadas e disponibilizadas por meio de Grafana. Para obter mais informações sobre métricas, veja [Monitoramento para o {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Para acessar o painel Grafana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você criou o cluster.<ul><li>Sul e Leste dos EUA: https://metrics.ng.bluemix.net</li><li>Sul do Reino Unido: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### Outras ferramentas de monitoramento de funcionamento
{: #cs_health_tools}

É possível configurar outras ferramentas para mais recursos de monitoramento.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada para o Kubernetes. A ferramenta recupera informações detalhadas sobre o cluster, os nós do trabalhador e o funcionamento de implementação com base nas informações de criação de log do Kubernetes. Para obter informações de configuração, veja [Integrando serviços com o {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_integrations).</dd>
</dl>

### Configurando o monitoramento de funcionamento para os nós do trabalhador com Recuperação automática
{: #cs_configure_worker_monitoring}

O sistema de Recuperação automática do {{site.data.keyword.containerlong_notm}} pode ser implementado em clusters existentes do Kubernetes versão 1.7 ou mais recente. O sistema de Recuperação automática usa várias verificações para consultar o status de funcionamento do nó do trabalhador. Se a Recuperação automática detecta um nó do trabalhador que não está saudável com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Somente um nó do trabalhador é submetido a uma ação corretiva por vez. O nó do trabalhador deve concluir com êxito a ação corretiva antes que qualquer nó do trabalhador seja submetido a uma ação corretiva.
**NOTA**: a Recuperação automática requer pelo menos um nó saudável para funcionar de maneira adequada. Configure a Recuperação automática com verificações ativas somente em clusters com dois ou mais nós do trabalhador.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja verificar os status do nó do trabalhador.

1. Crie um arquivo de mapa de configuração que define suas verificações no formato JSON. Por exemplo, o arquivo YAML a seguir define três verificações: uma verificação de HTTP e duas verificações do servidor da API do Kubernetes.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>Tabela 15. Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>O nome de configuração <code>ibm-worker-recovery-checks</code> é uma constante e não pode ser mudado.</td>
    </tr>
    <tr>
    <td><code> namespace</code></td>
    <td>O namespace <code>kube-system</code> é uma constante e não pode ser mudado.</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>Insira o tipo de verificação que você deseja que a Recuperação automática use. <ul><li><code>HTTP</code>: a Recuperação automática chama os servidores HTTP que são executados em cada nó para determinar se os nós estão sendo executados de forma adequada.</li><li><code>KUBEAPI</code>: a Recuperação automática chama o servidor da API do Kubernetes e lê os dados de status de funcionamento relatados pelos nós do trabalhador.</li></ul></td>
    </tr>
    <tr>
    <td><code>Recurso</code></td>
    <td>Quando o tipo de verificação é <code>KUBEAPI</code>, insira o tipo de recurso que você deseja que a Recuperação automática verifique. Os valores aceitos são <code>NODE</code> ou <code>PODS</code>.</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>Insira o limite para o número de verificações de falhas consecutivas. Quando esse limite é atendido, a Recuperação automática aciona a ação corretiva especificada. Por exemplo, se o valor é 3 e a Recuperação automática falha uma verificação configurada três vezes consecutivas, a Recuperação automática aciona a ação corretiva que está associada à verificação.</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>Quando o tipo de recurso é <code>PODS</code>, insira o limite para a porcentagem de pods em um nó do trabalhador que pode estar em um estado [NotReady ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Essa porcentagem é baseada no número total de pods que estão planejados para um nó do trabalhador. Quando uma verificação determina que a porcentagem de pods não saudáveis é maior que o limite, a verificação conta como uma falha.</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>Insira a ação a ser executada quando o limite de falha for atendido. Uma ação corretiva é executada somente enquanto nenhum outro trabalhador está sendo reparado e quando esse nó do trabalhador não está em um período de bloqueio de uma ação anterior. <ul><li><code>REBOOT</code>: reinicializa o nó do trabalhador.</li><li><code>RELOAD</code>: recarrega todas as configurações necessárias para o nó do trabalhador de um S.O. limpo.</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>Insira o número de segundos que a Recuperação automática deve esperar para emitir outra ação corretiva para um nó em que uma ação corretiva já foi emitida. O período de bloqueio se inicia no momento em que uma ação corretiva é emitida.</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>Insira o número de segundos entre verificações consecutivas. Por exemplo, se o valor é 180, a Recuperação automática executa a verificação em cada nó a cada 3 minutos.</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>Insira o número máximo de segundos que leva uma chamada de verificação para o banco de dados antes de a Recuperação automática terminar a operação de chamada. O valor para <code>TimeoutSeconds</code> deve ser menor que o valor para <code>IntervalSeconds</code>.</td>
    </tr>
    <tr>
    <td><code>Porta</code></td>
    <td>Quando o tipo de verificação é <code>HTTP</code>, insira a porta à qual o servidor HTTP deve ser ligado em nós do trabalhador. Essa porta deve ser exposta no IP de cada nó do trabalhador no cluster. A Recuperação automática requer um número de porta constante em todos os nós para verificar servidores. Use [DaemonSets ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) ao implementar um servidor customizado em um cluster.</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>Quando o tipo de verificação for <code>HTTP</code>, insira o status de servidor HTTP que você espera que seja retornado da verificação. Por exemplo, um valor de 200 indica que você espera uma resposta <code>OK</code> do servidor.</td>
    </tr>
    <tr>
    <td><code>Rota</code></td>
    <td>Quando o tipo de verificação é <code>HTTP</code>, insira o caminho que é solicitado do servidor HTTP. Esse valor é geralmente o caminho de métricas para o servidor que está em execução em todos os nós do trabalhador.</td>
    </tr>
    <tr>
    <td><code>Ativado</code></td>
    <td>Insira <code>true</code> para ativar a verificação ou <code>false</code> para desativar a verificação.</td>
    </tr>
    </tbody></table>

2. Crie o mapa de configuração em seu cluster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Verifique se você criou o mapa de configuração com o nome `ibm-worker-recovery-checks` no namespace `kube-system` com as verificações adequadas.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Assegure-se de que você tenha criado um segredo de pull do Docker com o nome `international-registry-docker-secret` no namespace `kube-system`. A Recuperação automática é hospedada no registro internacional do Docker do {{site.data.keyword.registryshort_notm}}. Se você não tiver criado um segredo de registro do Docker que contenha credenciais válidas para o registro internacional, crie um para executar o sistema de Recuperação automática.

    1. Instale o plug-in do {{site.data.keyword.registryshort_notm}}.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Direcione o registro internacional.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Crie um token de registro internacional.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Configure a variável de ambiente `INTERNATIONAL_REGISTRY_TOKEN` para o token que você criou.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Configure a variável de ambiente `DOCKER_EMAIL` para o usuário atual. Seu endereço de e-mail é necessário somente para executar o comando `kubectl` na próxima etapa.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Crie o segredo de pull do Docker.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Implemente a Recuperação automática em seu cluster aplicando esse arquivo YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. Após alguns minutos, é possível verificar a seção `Events` na saída do comando a seguir para ver a atividade na implementação de Recuperação automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## Visualizando recursos de cluster do Kubernetes
{: #cs_weavescope}

O Weave Scope fornece um diagrama visual de seus recursos dentro de um cluster do Kubernetes, incluindo serviços, pods, contêineres, processos, nós e muito mais. O Weave Scope fornece métricas interativas para CPU e memória e também fornece ferramentas para uso de tail e executável em um contêiner.
{:shortdesc}

Antes de iniciar:

-   Lembre-se de não expor as suas informações do cluster na Internet pública. Conclua estas etapas para implementar o Weave Scope com segurança e acessá-lo por meio de um navegador da web localmente.
-   Se você não tiver nenhum ainda, [crie um cluster padrão](#cs_cluster_ui). O Weave Scope pode ser intensivo de CPU, especialmente o app. Execute o Weave Scope com clusters padrão maiores, não clusters lite.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.


Para usar o Weave Scope com um cluster:
2.  Implemente um dos arquivos de configuração de permissões do RBAC no cluster.

    Para ativar permissões de leitura/gravação:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Para ativar permissões somente leitura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Saída:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Implemente o serviço do Weave Scope, que é particularmente acessível pelo endereço IP de cluster.

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Saída:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Execute um comando de encaminhamento de porta para exibir o serviço em seu computador. Agora que o Weave Scope está configurado com o cluster, para acessar o Weave Scope da próxima vez, será possível executar esse comando de encaminhamento sem concluir as etapas de configuração anteriores novamente.

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Saída:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Abra seu navegador da web para `http://localhost:4040`. Sem os componentes padrão implementados, você vê o diagrama a seguir. É possível escolher visualizar diagramas de topologia ou tabelas dos recursos do Kubernetes no cluster.

     <img src="images/weave_scope.png" alt="Topologia de exemplo do Weave Scope" style="width:357px;" />


[Saiba mais sobre os recursos do Weave Scope ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.weave.works/docs/scope/latest/features/).

<br />


## Removendo Clusters
{: #cs_cluster_remove}

Quando tiver concluído com um cluster, será possível removê-lo para que o cluster não consuma mais recursos.
{:shortdesc}

Os clusters Lite e padrão criados com uma conta Lite ou Pagamento por uso do {{site.data.keyword.Bluemix_notm}} deverão ser removidos manualmente pelo usuário quando eles não forem mais necessários.

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
- As sub-redes são usadas para designar endereços IP públicos móveis para serviços de balanceador de carga ou para seu controlador de Ingresso. Se elas forem mantidas, será possível reutilizá-las em um novo cluster ou excluí-las manualmente mais tarde de seu portfólio de infraestrutura do IBM Cloud (SoftLayer).
- Se você criou uma solicitação de volume persistente usando um (compartilhamento de arquivo existente)[#cs_cluster_volume_create ], não será possível excluir o compartilhamento de arquivo quando excluir o cluster. Deve-se excluir manualmente o compartilhamento de arquivo posteriormente de seu portfólio de infraestrutura do IBM Cloud (SoftLayer).
- O armazenamento persistente fornece alta disponibilidade para seus dados. Se você excluí-lo, não será possível recuperar seus dados.
