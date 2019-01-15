---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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





# Configurando a CLI e API
{: #cs_cli_install}

É possível usar a CLI ou API do {{site.data.keyword.containerlong}} para criar e gerenciar seus clusters do Kubernetes.
{:shortdesc}

<br />


## Instalando a CLI
{: #cs_cli_install_steps}

Instale as CLIs necessárias para criar e gerenciar seus clusters do Kubernetes no {{site.data.keyword.containerlong_notm}} e implementar apps conteinerizados em seu cluster.
{:shortdesc}

Esta tarefa inclui as informações para instalar essas CLIs e plug-ins:

-   {{site.data.keyword.Bluemix_notm}}  CLI versão 0.8.0 ou mais recente
-   Plug-in do {{site.data.keyword.containerlong_notm}}
-   A versão da CLI do Kubernetes que corresponde à versão `major.minor` de seu cluster
-   Opcional: plug-in do {{site.data.keyword.registryshort_notm}}

<br>
Para instalar as CLIs:

1.  Como um pré-requisito para o plug-in do {{site.data.keyword.containerlong_notm}}, instale a [CLI do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](../cli/index.html#overview). O prefixo para executar comandos usando a CLI do {{site.data.keyword.Bluemix_notm}} é `ibmcloud`.

    Planeja usar muito a CLI? Tente [Ativando a conclusão automática de shell para a CLI do {{site.data.keyword.Bluemix_notm}} (somente Linux/MacOS)](/docs/cli/reference/ibmcloud/enable_cli_autocompletion.html#enabling-shell-autocompletion-for-ibm-cloud-cli-linux-macos-only-).
    {: tip}

2.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas.

    ```
    ibmcloud login
    ```
    {: pre}

    Se você tiver um ID federado, use `ibmcloud login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.
    {: tip}

3.  Para criar clusters do Kubernetes e gerenciar nós do trabalhador, instale o plug-in do {{site.data.keyword.containerlong_notm}}. O prefixo para executar comandos usando o plug-in do {{site.data.keyword.containerlong_notm}} é `ibmcloud ks`.

    ```
    ibmcloud plugin install container-service 
    ```
    {: pre}

    Para verificar se o plug-in está instalado adequadamente, execute o comando a seguir:

    ```
    ibmcloud plugin list
    ```
    {: pre}

    O plug-in do {{site.data.keyword.containerlong_notm}} é exibido nos resultados como container-service.

4.  {: #kubectl}Para visualizar uma versão local do painel do Kubernetes e implementar apps em seus clusters, [instale a CLI do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). O prefixo para executar comandos usando o Kubernetes CLI é `kubectl`.

    1.  Faça download da versão `major.minor` da CLI do Kubernetes que corresponda à versão `major.minor` do cluster do Kubernetes que você planeja usar. A versão atual do Kubernetes padrão do {{site.data.keyword.containerlong_notm}} é 1.10.11.

        Se você usar uma versão da CLI `kubectl` que não corresponda pelo menos à versão `major.minor` de seus clusters, poderá ter resultados inesperados. Certifique-se de manter as versões de cluster e de CLI do Kubernetes atualizadas.
        {: note}

        - **S.O X**:   [https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/darwin/amd64/kubectl ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/darwin/amd64/kubectl)
        - **Linux**:   [https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/linux/amd64/kubectl ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/linux/amd64/kubectl)
        - **Windows**:    [https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/windows/amd64/kubectl.exe ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://storage.googleapis.com/kubernetes-release/release/v1.10.11/bin/windows/amd64/kubectl.exe)

    2.  **Para OSX e Linux**: conclua as etapas a seguir.
        1.  Mova o arquivo executável para o diretório `/usr/local/bin`.

            ```
            Mv /filepath/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Certifique-se de que `/usr/local/bin` esteja listado na variável do sistema `PATH`. A variável `PATH` contém todos os diretórios nos quais o sistema operacional pode localizar arquivos executáveis. Os diretórios que estão listados na variável `PATH` servem propósitos diferentes. `/usr/local/bin` é usado para armazenar arquivos executáveis para o software que não faz parte do sistema operacional e que foi instalado manualmente pelo administrador do sistema.

            ```
            echo $PATH
            ```
            {: pre}

            Exemplo de saída da CLI:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Torne o arquivo executável.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

    3.  **Para Windows**: instale a CLI do Kubernetes no mesmo diretório que a CLI do {{site.data.keyword.Bluemix_notm}}. Essa configuração economiza algumas
mudanças de caminho de arquivo ao executar comandos posteriormente.

5.  Para gerenciar um repositório de imagem privada, instale o plug-in do {{site.data.keyword.registryshort_notm}}. Use esse plug-in para configurar o seu próprio namespace em um registro de imagem privada de múltiplos locatários, altamente disponível e escalável que é hospedado pela IBM e para armazenar e compartilhar imagens do Docker com outros usuários. As imagens do Docker são necessárias para implementar contêineres em um cluster. O prefixo para executar comandos de registro é `ibmcloud cr`.

    ```
    ibmcloud plugin install container-registry 
    ```
    {: pre}

    Para verificar se o plug-in está instalado adequadamente, execute o comando a seguir:

    ```
    ibmcloud plugin list
    ```
    {: pre}

    O plug-in é exibido nos resultados como registro do contêiner.

Em seguida, inicie [Criando clusters do Kubernetes por meio da CLI com o {{site.data.keyword.containerlong_notm}}](cs_clusters.html#clusters_cli).

Para obter informações de referência sobre essas CLIs, veja a documentação para essas ferramentas.

-   [Comandos `ibmcloud`](../cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli)
-   [ Comandos ` ibmcloud ks `  ](cs_cli_reference.html#cs_cli_reference)
-   [Comandos `kubectl` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [comandos `ibmcloud cr`](/docs/container-registry-cli-plugin/container-registry-cli.html#containerregcli)

<br />




## Executando a CLI em um contêiner em seu computador
{: #cs_cli_container}

Em vez de instalar cada uma das CLIs individualmente em seu computador, é possível instalar as CLIs em um contêiner que é executado em seu computador.
{:shortdesc}

Antes de iniciar, [instale o Docker ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.docker.com/community-edition#/download) para construir e executar imagens localmente. Se você estiver usando o Windows 8 ou anterior, será possível instalar o [Docker Toolbox ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://docs.docker.com/toolbox/toolbox_install_windows/) como alternativa.

1. Crie uma imagem do Dockerfile fornecido.

    ```
    Docker build -t < image_name> https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/install-clis-container/Dockerfile
    ```
    {: pre}

2. Implemente a imagem localmente como um contêiner e monte um volume para acessar arquivos locais.

    ```
    docker run -it -v /local/path:/container/volume <image_name>
    ```
    {: pre}

3. Inicie executando os comandos `ibmcloud ks` e `kubectl` no shell interativo. Se você criar dados que deseja salvar, salve esses dados no volume montado. Quando você sair do shell, o contêiner será parado.

<br />



## Configurando a CLI para executar `kubectl`
{: #cs_cli_configure}

É possível usar os comandos que são fornecidos com a CLI do Kubernetes para gerenciar clusters no {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Todos os comandos `kubectl` que estão disponíveis no Kubernetes 1.10.11 são suportados para uso com clusters no {{site.data.keyword.Bluemix_notm}}. Após criar um cluster, configure o contexto para sua CLI local para esse cluster com uma variável de ambiente. Então, é possível executar os comandos `kubectl` do Kubernetes para trabalhar com o seu cluster no {{site.data.keyword.Bluemix_notm}}.

Antes de poder executar os comandos `kubectl`:
* [ Instale as CLIs necessárias ](#cs_cli_install).
* [Crie um cluster](cs_clusters.html#clusters_cli).

Para usar os comandos `kubectl`:

1.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas. Para especificar uma região do {{site.data.keyword.Bluemix_notm}}, [inclua o terminal de API](cs_regions.html#bluemix_regions).

    ```
    ibmcloud login
    ```
    {: pre}

    Se você tiver um ID federado, use `ibmcloud login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.
    {: tip}

2.  Selecione uma conta do {{site.data.keyword.Bluemix_notm}}. Se você estiver designado para múltiplas organizações do {{site.data.keyword.Bluemix_notm}}, selecione a organização na qual o cluster foi criado. Os clusters são específicos para uma organização, mas são independentes de um espaço do {{site.data.keyword.Bluemix_notm}}. Portanto, não é necessário selecionar um espaço.

3.  Para criar e trabalhar com clusters em um grupo de recursos diferente do padrão, destine esse grupo de recursos. Para ver o grupo de recursos ao qual cada cluster pertence, execute `ibmcloud ks clusters`. **Nota**: deve-se ter [acesso **Visualizador**](cs_users.html#platform) para o grupo de recursos.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

4.  Para criar ou acessar clusters do Kubernetes em uma região diferente da região do {{site.data.keyword.Bluemix_notm}} que você selecionou anteriormente, destinar a região.
    ```
    ibmcloud ks region-set
    ```
    {: pre}

5.  Liste todos os clusters na conta para obter o nome do cluster.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

6.  Configure o cluster criado como o contexto para esta sessão. Conclua estas etapas de configuração toda vez que você trabalhar com o seu cluster.
    1.  Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração do Kubernetes.

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        Depois de fazer download dos arquivos de configuração, será exibido um comando que poderá ser usado para configurar o caminho para o arquivo de configuração local do Kubernetes como uma variável de ambiente.

        Exemplo:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.

        **Usuário do Mac ou Linux**: em vez de executar o comando `ibmcloud ks cluster-config` e copiar a variável de ambiente `KUBECONFIG`, é possível executar `(ibmcloud ks cluster-config "<cluster-name>" | grep export) `.
        {:tip}

    3.  Verifique se a variável de ambiente `KUBECONFIG` está configurada corretamente.

        Exemplo:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Saída:
        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

7.  Verifique se os comandos `kubectl` são executados adequadamente com seu cluster verificando a versão do servidor de CLI do Kubernetes.

    ```
    kubectl version  --short
    ```
    {: pre}

    Saída de exemplo:

    ```
    Versão do cliente: v1.10.11 Versão do servidor: v1.10.11
    ```
    {: screen}

Agora, é possível executar comandos `kubectl` para gerenciar seus clusters no {{site.data.keyword.Bluemix_notm}}. Para obter uma lista completa de comandos, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/).

**Dica:** se estiver usando o Windows e a CLI do Kubernetes não estiver instalada no mesmo diretório que a CLI do {{site.data.keyword.Bluemix_notm}}, você deverá mudar os diretórios para o caminho no qual a CLI do Kubernetes está instalada para executar comandos `kubectl` com êxito.


<br />


## Atualizando a CLI
{: #cs_cli_upgrade}

Talvez você queira atualizar as CLIs periodicamente para usar novos recursos.
{:shortdesc}

Esta tarefa inclui as informações para atualizar essas CLIs.

-   {{site.data.keyword.Bluemix_notm}}  CLI versão 0.8.0 ou mais recente
-   Plug-in do {{site.data.keyword.containerlong_notm}}
-   CLI do Kubernetes versão 1.10.11 ou mais recente
-   Plug-in do {{site.data.keyword.registryshort_notm}}

<br>
Para atualizar as CLIs:

1.  Atualize a CLI do {{site.data.keyword.Bluemix_notm}}. Faça download da [versão mais recente ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](../cli/index.html#overview) e execute o instalador.

2. Efetue login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas. Para especificar uma região do {{site.data.keyword.Bluemix_notm}}, [inclua o terminal de API](cs_regions.html#bluemix_regions).

    ```
    ibmcloud login
    ```
    {: pre}

     Se você tiver um ID federado, use `ibmcloud login --sso` para efetuar login na CLI do {{site.data.keyword.Bluemix_notm}}. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável. Você sabe que tem um ID federado quando o login falha sem a opção `--sso` e é bem-sucedido com a opção `--sso`.
     {: tip}

3.  Atualize o plug-in {{site.data.keyword.containerlong_notm}}.
    1.  Instale a atualização do repositório do plug-in do {{site.data.keyword.Bluemix_notm}}.

        ```
        ibmcloud plugin update container-service 
        ```
        {: pre}

    2.  Verifique a instalação do plug-in executando o comando a seguir e verificando a lista dos plug-ins instalados.

        ```
        ibmcloud plugin list
        ```
        {: pre}

        O plug-in do {{site.data.keyword.containerlong_notm}} é exibido nos resultados como container-service.

    3.  Inicialize a CLI.

        ```
        ibmcloud ks init
        ```
        {: pre}

4.  [Atualize a CLI do Kubernetes](#kubectl).

5.  Atualize o plug-in {{site.data.keyword.registryshort_notm}}.
    1.  Instale a atualização do repositório do plug-in do {{site.data.keyword.Bluemix_notm}}.

        ```
        ibmcloud plugin update container-registry 
        ```
        {: pre}

    2.  Verifique a instalação do plug-in executando o comando a seguir e verificando a lista dos plug-ins instalados.

        ```
        ibmcloud plugin list
        ```
        {: pre}

        O plug-in de registro é exibido nos resultados como registro do contêiner.

<br />


## Desinstalando a CLI
{: #cs_cli_uninstall}

Se você não precisar mais da CLI, será possível desinstalá-la.
{:shortdesc}

Esta tarefa inclui as informações para remover estas CLIs:


-   Plug-in do {{site.data.keyword.containerlong_notm}}
-   Kubernetes CLI
-   Plug-in do {{site.data.keyword.registryshort_notm}}

Para desinstalar as CLIs:

1.  Desinstale o plug-in do {{site.data.keyword.containerlong_notm}}.

    ```
    ibmcloud plugin uninstall container-service
    ```
    {: pre}

2.  Desinstale o plug-in do {{site.data.keyword.registryshort_notm}}.

    ```
    ibmcloud plugin uninstall container-registry
    ```
    {: pre}

3.  Verifique se os plug-ins foram desinstalados executando o comando a seguir e verificando a lista dos plug-ins instalados.

    ```
    ibmcloud plugin list
    ```
    {: pre}

    Os plug-ins container-service e container-registry não são exibidos nos resultados.

<br />


## Automatizando implementações de cluster com a API
{: #cs_api}

É possível usar a API do {{site.data.keyword.containerlong_notm}} para automatizar a criação, a implementação e o gerenciamento de seus clusters do Kubernetes.
{:shortdesc}

A API do {{site.data.keyword.containerlong_notm}} requer informações do cabeçalho que devem ser fornecidas na solicitação de API e que podem variar, dependendo da API que você deseja usar. Para determinar quais informações do cabeçalho são necessárias para sua API, consulte a [documentação da API do {{site.data.keyword.containerlong_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://us-south.containers.bluemix.net/swagger-api).

Para se autenticar com o {{site.data.keyword.containerlong_notm}}, deve-se fornecer um token do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) que é gerado com suas credenciais do {{site.data.keyword.Bluemix_notm}} e que inclui o ID da conta do {{site.data.keyword.Bluemix_notm}} em que o cluster foi criado. Dependendo da maneira que você autenticar com o {{site.data.keyword.Bluemix_notm}}, será possível escolher entre as opções a seguir para automatizar a criação de seu token do {{site.data.keyword.Bluemix_notm}} IAM.

Também é possível usar o [arquivo JSON do swagger de API ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://containers.bluemix.net/swagger-api-json) para gerar um cliente que possa interagir com a API como parte de seu trabalho de automação.
{: tip}

<table>
<caption>Tipos de ID e opções</caption>
<thead>
<th>ID do {{site.data.keyword.Bluemix_notm}}</th>
<th>Minhas opções</th>
</thead>
<tbody>
<tr>
<td>ID não federado</td>
<td><ul><li><strong>Nome de usuário e senha do {{site.data.keyword.Bluemix_notm}}:</strong> é possível seguir as etapas neste tópico para automatizar totalmente a criação de seu token de acesso do {{site.data.keyword.Bluemix_notm}} IAM.</li>
<li><strong>Gerar uma chave API do {{site.data.keyword.Bluemix_notm}}:</strong> como uma alternativa ao uso de nome do usuário e senha do {{site.data.keyword.Bluemix_notm}}, é possível <a href="../iam/apikeys.html#manapikey" target="_blank">usar chaves API do {{site.data.keyword.Bluemix_notm}}</a>. As chaves API do {{site.data.keyword.Bluemix_notm}} são dependentes da conta do {{site.data.keyword.Bluemix_notm}} para a qual elas são geradas. Não é possível combinar sua chave de API do {{site.data.keyword.Bluemix_notm}} com um ID de conta diferente no mesmo token do IAM do {{site.data.keyword.Bluemix_notm}}. Para acessar os clusters que foram criados com uma conta diferente daquela na qual a sua chave API do {{site.data.keyword.Bluemix_notm}} é baseada; deve-se efetuar login na conta para gerar uma nova chave API. </li></ul></tr>
<tr>
<td>ID federado</td>
<td><ul><li><strong>Gerar uma chave API do {{site.data.keyword.Bluemix_notm}}:</strong> <a href="../iam/apikeys.html#manapikey" target="_blank">as chaves API do {{site.data.keyword.Bluemix_notm}}</a> são dependentes da conta do {{site.data.keyword.Bluemix_notm}} para a qual elas são geradas. Não é possível combinar sua chave de API do {{site.data.keyword.Bluemix_notm}} com um ID de conta diferente no mesmo token do IAM do {{site.data.keyword.Bluemix_notm}}. Para acessar os clusters que foram criados com uma conta diferente daquela na qual a sua chave API do {{site.data.keyword.Bluemix_notm}} é baseada; deve-se efetuar login na conta para gerar uma nova chave API. </li><li><strong>Use uma senha descartável:</strong> se você autenticar com o {{site.data.keyword.Bluemix_notm}} usando uma senha descartável, não será possível automatizar totalmente a criação de seu token do {{site.data.keyword.Bluemix_notm}} IAM porque a recuperação de sua senha única requer uma interação manual com seu navegador da web. Para automatizar totalmente a criação de seu token do {{site.data.keyword.Bluemix_notm}} IAM, deve-se criar uma chave de API do {{site.data.keyword.Bluemix_notm}}. </ul></td>
</tr>
</tbody>
</table>

1.  Crie seu token de acesso do {{site.data.keyword.Bluemix_notm}} IAM. As informações do corpo incluídas em sua solicitação variam com base no método de autenticação do {{site.data.keyword.Bluemix_notm}} usado. Substitua os seguintes valores:
  - _&lt;username&gt;_: seu nome de usuário do {{site.data.keyword.Bluemix_notm}}.
  - _&lt;password&gt;_: sua senha do {{site.data.keyword.Bluemix_notm}}.
  - _&lt;api_key&gt;_: sua chave API do {{site.data.keyword.Bluemix_notm}}.
  - _&lt;passcode&gt;_: O {{site.data.keyword.Bluemix_notm}} senha descartável. Execute `ibmcloud login --sso` e siga as instruções em sua saída da CLI para recuperar sua senha descartável usando o navegador da web.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    Exemplo:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    Para especificar uma região {{site.data.keyword.Bluemix_notm}}, [revise as
abreviações de região conforme elas são usadas nos endpoints de API](cs_regions.html#bluemix_regions).

    <table summary-"Input parameters to retrieve tokens">
    <caption>Os parâmetros de entrada para obter tokens</caption>
    <thead>
        <th>Parâmetros de Entrada</th>
        <th>Values</th>
    </thead>
    <tbody>
    <tr>
    <td>Cabeçalho (Header)</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><strong>Nota</strong>: <code>Yng6Yng=</code> é igual à autorização codificada por URL para o nome do usuário <strong>bx</strong> e a senha <strong>bx</strong>.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Corpo para nome do usuário e senha do {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam uaa</li>
    <li>username: <em>&lt;username&gt;</em></li>
    <li>password: <em>&lt;password&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li></ul>
    <strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    <tr>
    <td>Corpo para chaves API do {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam uaa</li>
    <li>apikey: <em>&lt;api_key&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li></ul>
    <strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    <tr>
    <td>Corpo para senha única do {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam uaa</li>
    <li>passcode: <em>&lt;passcode&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li></ul>
    <strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    </tbody>
    </table>

    Exemplo de saída da API:

    ```
    {
    "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    É possível localizar o token do {{site.data.keyword.Bluemix_notm}} IAM no campo **access_token** de sua saída da API. Anote o token do {{site.data.keyword.Bluemix_notm}} IAM para recuperar informações adicionais do cabeçalho nas próximas etapas.

2.  Recupere o ID da conta do {{site.data.keyword.Bluemix_notm}} em que o cluster foi criado. Substitua _&lt;iam_token&gt;_ pelo token do {{site.data.keyword.Bluemix_notm}} IAM que você recuperou na etapa anterior.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="Parâmetros de entrada para obter o ID da conta {{site.data.keyword.Bluemix_notm}}">
    <caption>Parâmetros de entrada para obter um ID da conta do {{site.data.keyword.Bluemix_notm}}</caption>
    <thead>
  	<th>Parâmetros de entrada</th>
  	<th>Values</th>
    </thead>
    <tbody>
  	<tr>
  		<td>Cabeçalhos</td>
  		<td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
  	</tr>
    </tbody>
    </table>

    Exemplo de saída da API:

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<account_ID>",
            "url": "/v1/accounts/<account_ID>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    É possível localizar o ID de sua conta do {{site.data.keyword.Bluemix_notm}} no campo **resources/metadata/guid** de sua saída da API.

3.  Gere um novo token do {{site.data.keyword.Bluemix_notm}} IAM que inclua suas credenciais do {{site.data.keyword.Bluemix_notm}} e o ID da conta no qual o cluster foi criado. Substitua _&lt;account_ID&gt;_ pelo ID da conta do {{site.data.keyword.Bluemix_notm}} recuperada na etapa anterior.

    Se você estiver usando uma chave de API do {{site.data.keyword.Bluemix_notm}}, deverá usar o ID da conta do {{site.data.keyword.Bluemix_notm}} para o qual a chave de API foi criada. Para acessar clusters em outras contas, efetue login nessa conta e crie uma chave API do {{site.data.keyword.Bluemix_notm}} que seja baseada nessa conta.
    {: note}

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    Exemplo:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    Para especificar uma região {{site.data.keyword.Bluemix_notm}}, [revise as
abreviações de região conforme elas são usadas nos endpoints de API](cs_regions.html#bluemix_regions).

    <table summary-"Input parameters to retrieve tokens">
    <caption>Os parâmetros de entrada para obter tokens</caption>
    <thead>
        <th>Parâmetros de Entrada</th>
        <th>Values</th>
    </thead>
    <tbody>
    <tr>
    <td>Cabeçalho (Header)</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><strong>Nota</strong>: <code>Yng6Yng=</code> é igual à autorização codificada por URL para o nome do usuário <strong>bx</strong> e a senha <strong>bx</strong>.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Corpo para nome do usuário e senha do {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam uaa</li>
    <li>username: <em>&lt;username&gt;</em></li>
    <li>password: <em>&lt;password&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_ID&gt;</em></li></ul>
    <strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    <tr>
    <td>Corpo para chaves API do {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam uaa</li>
    <li>apikey: <em>&lt;api_key&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_ID&gt;</em></li></ul>
      <strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    <tr>
    <td>Corpo para senha única do {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam uaa</li>
    <li>passcode: <em>&lt;passcode&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_ID&gt;</em></li></ul><strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    </tbody>
    </table>

    Exemplo de saída da API:

    ```
    {
      "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    É possível localizar o token do {{site.data.keyword.Bluemix_notm}} IAM no **access_token** e o token de atualização no **refresh_token**.

4.  Liste todos os clusters do Kubernetes em sua conta. Use as informações que você recuperou nas etapas anteriores para construir as informações do cabeçalho.

     ```
     GET https://containers.bluemix.net/v1/clusters
     ```
     {: codeblock}

     <table summary="Parâmetros de entrada para trabalhar com a API">
     <caption>Parâmetros de entrada para trabalhar com a API</caption>
     <thead>
     <th>Parâmetros de entrada</th>
     <th>Values</th>
     </thead>
     <tbody>
     <tr>
     <td>Cabeçalho (Header)</td>
     <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li>
     <li>X-Auth-Refresh-Token: <em>&lt;refresh_token&gt;</em></li></ul></td>
     </tr>
     </tbody>
     </table>

5.  Revise a [documentação da API do {{site.data.keyword.containerlong_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://containers.bluemix.net/swagger-api) para localizar uma lista de APIs suportadas.

<br />


## Atualizando os tokens de acesso do {{site.data.keyword.Bluemix_notm}} IAM e obtendo novos tokens de atualização com a API
{: #cs_api_refresh}

Cada token de acesso do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) que é emitido por meio da API expira após uma hora. Deve-se atualizar seu token de acesso regularmente para assegurar acesso à
API do {{site.data.keyword.Bluemix_notm}}. É possível usar as mesmas etapas para obter um novo token de atualização.
{:shortdesc}

Antes de iniciar, certifique-se de que você tenha um token de atualização do {{site.data.keyword.Bluemix_notm}} IAM ou uma chave de API do {{site.data.keyword.Bluemix_notm}} que possa ser usada para solicitar um novo token de acesso.
- **Token de atualização:** siga as instruções em [Automatizando a criação do cluster e o processo de gerenciamento com a {{site.data.keyword.Bluemix_notm}}API do ](#cs_api).
- **Chave API:** Recupere sua chave API do [{{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/) conforme a seguir.
   1. Na barra de menus, clique em **Gerenciar** > **Segurança** > **Chaves API da plataforma**.
   2. Clique em
**Criar**.
   3. Insira um **Nome** e uma **Descrição** para sua chave API e clique em **Criar**.
   4. Clique em **Mostrar** para ver a chave API que foi gerado para você.
   5. Copie a chave de API para que seja possível usá-la para recuperar seu novo token de acesso do {{site.data.keyword.Bluemix_notm}} IAM.

Use as etapas a seguir se você desejar criar um token do {{site.data.keyword.Bluemix_notm}} IAM ou se desejar obter um novo token de atualização.

1.  Gere um novo token de acesso do {{site.data.keyword.Bluemix_notm}} IAM usando o token de atualização ou a chave de API do {{site.data.keyword.Bluemix_notm}}.
    ```
    POST https://iam.bluemix.net/identity/token
    ```
    {: codeblock}

    <table summary="Parâmetros de entrada para o novo token IAM">
    <caption>Parâmetros de entrada para um novo token do {{site.data.keyword.Bluemix_notm}} IAM</caption>
    <thead>
    <th>Parâmetros de entrada</th>
    <th>Values</th>
    </thead>
    <tbody>
    <tr>
    <td>Cabeçalho (Header)</td>
    <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
      <li>Authorization: Basic Yng6Yng=</br></br><strong>Nota:</strong> <code>Yng6Yng=</code> é igual à autorização codificada por URL para o nome do usuário <strong>bx</strong> e a senha <strong>bx</strong>.</li></ul></td>
    </tr>
    <tr>
    <td>Corpo ao usar o token de atualização</td>
    <td><ul><li>grant_type: refresh_token</li>
    <li>response_type: cloud_iam uaa</li>
    <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
    <li>uaa_client_ID: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_ID&gt;</em></li></ul><strong>Nota</strong>: inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    <tr>
      <td>Corpo ao usar a chave API do {{site.data.keyword.Bluemix_notm}}</td>
      <td><ul><li>grant_type: <code>urn:ibm:params:oauth:grant-type:apikey</code></li>
    <li>response_type: cloud_iam uaa</li>
    <li>apikey: <em>&lt;api_key&gt;</em></li>
    <li>uaa_client_ID: cf</li>
        <li>uaa_client_secret:</li></ul><strong>Nota:</strong> inclua a chave <code>uaa_client_secret</code> sem valor especificado.</td>
    </tr>
    </tbody>
    </table>

    Exemplo de saída da API:

    ```
    {
      "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    É possível localizar seu novo token do {{site.data.keyword.Bluemix_notm}} IAM no **access_token** e o token de atualização no campo **refresh_token** de sua saída da API.

2.  Continue trabalhando com a [documentação da API do {{site.data.keyword.containerlong_notm}}![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://containers.bluemix.net/swagger-api) usando o token da etapa anterior.

<br />


## Atualizando tokens de acesso do {{site.data.keyword.Bluemix_notm}} IAM e obtendo novos tokens de atualização com a CLI
{: #cs_cli_refresh}

Quando você inicia uma nova sessão da CLI ou se 24 horas expiraram em sua sessão da CLI atual, deve-se configurar o contexto para seu cluster executando `ibmcloud ks cluster-config <cluster_name>`. Quando você configura o contexto para seu cluster com esse comando, o arquivo `kubeconfig` para seu cluster do Kubernetes é transferido por download. Além disso, um token de ID do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) e um token de atualização são emitidos para fornecer autenticação.
{: shortdesc}

**Token de ID**: cada token de ID do IAM que é emitido por meio da CLI expira após uma hora. Quando o token de ID expira, o token de atualização é enviado para o provedor de token para atualizar o token de ID. Sua autenticação é atualizada e é possível continuar a executar comandos com relação ao seu cluster.

**Token de atualização**: os tokens de atualização expiram a cada 30 dias. Quando o token de atualização expira, o token de ID não pode ser atualizado e não é possível continuar executando os comandos na CLI. É possível obter um novo token de atualização executando `ibmcloud ks cluster-config <cluster_name>`. Esse comando também atualiza seu token de ID.
