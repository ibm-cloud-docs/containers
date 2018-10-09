---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Tutorial: criando clusters do Kubernetes
{: #cs_cluster_tutorial}

Com este tutorial, é possível implementar e gerenciar um cluster do Kubernetes no {{site.data.keyword.containerlong}}. Saiba como automatizar a implementação, a operação, o ajuste de escala e o monitoramento de apps conteinerizados em um cluster.
{:shortdesc}

Nesta série de tutoriais, é possível ver como uma firma fictícia de relações públicas usa os recursos do Kubernetes para implementar um app conteinerizado no {{site.data.keyword.Bluemix_notm}}. Usando o {{site.data.keyword.toneanalyzerfull}}, o escritório de RP analisa seus press releases e recebe feedback.


## Objetivos

Neste primeiro tutorial, você atua como administrador de networking do escritório de RP. Você configura um cluster do Kubernetes customizado que é usado para implementar e testar uma versão do Hello World do app no {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

-   Crie um cluster com 1 conjunto de trabalhadores que tenha 1 nó do trabalhador.
-   Instale as CLIs para executar [comandos do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/) e gerenciando imagens do Docker no {{site.data.keyword.registrylong_notm}}.
-   Crie um repositório de imagem privada no {{site.data.keyword.registrylong_notm}} para armazenar as suas imagens.
-   Inclua o serviço {{site.data.keyword.toneanalyzershort}} no cluster para que qualquer app no cluster possa usar esse serviço.


## Tempo Necessário

40
minutos


## Público

Este tutorial é destinado a desenvolvedores de software e administradores de rede que estão criando um cluster do Kubernetes pela primeira vez.
{: shortdesc}

## Pré-requisitos

-  Uma conta pré-paga ou de Assinatura [{{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/registration/)
-  A [função de infraestrutura **Superusuário**](cs_users.html#infra_access) da infraestrutura do IBM Cloud (SoftLayer) ou confirme se a [chave API para a região está configurada](cs_troubleshoot_clusters.html#apikey) com as permissões apropriadas
-  A [função **Desenvolvedor** do Cloud Foundry](/docs/iam/mngcf.html#mngcf) no espaço do cluster em que você deseja trabalhar


## Lição 1: criando um cluster e configurando a CLI
{: #cs_cluster_tutorial_lesson1}

Crie seu cluster do Kubernetes na GUI e instale as CLIs necessárias.
{: shortdesc}

**Para criar seu cluster**

Como pode levar alguns minutos para provisão, crie seu cluster antes de instalar as CLIs.

1.  [Na GUI ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/containers-kubernetes/catalog/cluster/create), crie um cluster grátis ou padrão com 1 conjunto de trabalhadores que contenha um nó do trabalhador.

    Também é possível criar um [cluster na CLI](cs_clusters.html#clusters_cli).
    {: tip}

Como seu cluster é provisionado, instale as CLIs a seguir que são usadas para gerenciar clusters:
-   CLI do {{site.data.keyword.Bluemix_notm}}
-   Plug-in do {{site.data.keyword.containerlong_notm}}
-   Kubernetes CLI
-   Plug-in do {{site.data.keyword.registryshort_notm}}

</br>
**Para instalar as CLIs e os seus pré-requisitos**

1.  Como um pré-requisito para o plug-in do {{site.data.keyword.containerlong_notm}}, instale a [CLI do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://clis.ng.bluemix.net/ui/home.html). Para executar comandos da CLI do {{site.data.keyword.Bluemix_notm}}, use o prefixo `ibmcloud`.
2.  Siga os prompts para selecionar uma conta e uma organização do {{site.data.keyword.Bluemix_notm}}. Os clusters são específicos para uma conta, mas são independentes de uma organização ou espaço do {{site.data.keyword.Bluemix_notm}}.

4.  Instale o plug-in do {{site.data.keyword.containerlong_notm}} para criar clusters do Kubernetes e gerenciar nós do trabalhador. Para executar os comandos do plug-in do {{site.data.keyword.containerlong_notm}}, use o prefixo `ibmcloud ks`.

    ```
    ibmcloud plugin install container-service -r Bluemix
    ```
    {: pre}

5.  Para implementar apps em seus clusters, [instale a CLI do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Para executar comandos usando a CLI do Kubernetes, use o prefixo `kubectl`.
    1.  Para obter compatibilidade funcional completa, faça download da versão de CLI do Kubernetes que corresponda à versão do cluster do Kubernetes que você planeja usar. A versão atual do Kubernetes padrão do {{site.data.keyword.containerlong_notm}} é 1.10.7.

        OS X: [https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/darwin/amd64/kubectl ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/darwin/amd64/kubectl)

        Linux: [https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/linux/amd64/kubectl ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/linux/amd64/kubectl)

        Windows: [https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/windows/amd64/kubectl.exe ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/windows/amd64/kubectl.exe)

          **Dica:** se estiver usando o Windows, instale a CLI do Kubernetes no mesmo diretório que a CLI do {{site.data.keyword.Bluemix_notm}}. Essa configuração economiza algumas
mudanças de caminho de arquivo ao executar comandos posteriormente.

    2.  Se você estiver usando o S.O. X ou Linux, conclua as etapas a seguir.
        1.  Mova o arquivo executável para o diretório `/usr/local/bin`.

            ```
            Mv filepath / kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Certifique-se de que `/usr/local/bin` esteja listado em sua variável do sistema `PATH`. A variável `PATH` contém todos os diretórios nos quais o sistema operacional pode localizar arquivos executáveis. Os diretórios que estão listados na variável `PATH` servem propósitos diferentes. `/usr/local/bin` é usado para armazenar arquivos executáveis para o software que não faz parte do sistema operacional e que foi instalado manualmente pelo administrador do sistema.

            ```
            echo $PATH
            ```
            {: pre}

            Sua saída de CLI é semelhante à seguinte.

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Torne o arquivo executável.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6. Para configurar e gerenciar um repositório de imagem privada no {{site.data.keyword.registryshort_notm}}, instale o plug-in do {{site.data.keyword.registryshort_notm}}. Para executar comandos de registro, use o prefixo `ibmcloud cr`.

    ```
    ibmcloud plugin install container-registry -r Bluemix
    ```
    {: pre}

    Para verificar se o serviço de contêiner e os plug-ins de registro de contêiner estão instalados corretamente, execute o comando a seguir:

    ```
    ibmcloud plugin list
    ```
    {: pre}

Parabéns! Você instalou com êxito as CLIs para as lições e os tutoriais a seguir. Em seguida, configure seu ambiente em cluster e inclua o serviço {{site.data.keyword.toneanalyzershort}}.


## Lição 2: configurando seu registro privado
{: #cs_cluster_tutorial_lesson2}

Configure um repositório de imagem privada no {{site.data.keyword.registryshort_notm}} e inclua segredos em seu cluster do Kubernetes para que o app possa acessar o serviço {{site.data.keyword.toneanalyzershort}}.
{: shortdesc}

1.  Efetue login na CLI do {{site.data.keyword.Bluemix_notm}} usando suas credenciais {{site.data.keyword.Bluemix_notm}}, quando solicitado.

    ```
    ibmcloud login [ -- sso ]
    ```
    {: pre}

    **Nota:** se você tiver um ID federado, use a sinalização `--sso` para efetuar login. Insira seu nome do usuário e use a URL fornecida na saída da CLI para recuperar sua senha descartável.

2.  Configure o seu próprio repositório de imagem privada no {{site.data.keyword.registryshort_notm}} para armazenar com segurança e compartilhar imagens do Docker com todos os usuários do cluster. Um repositório de imagem privada no {{site.data.keyword.Bluemix_notm}} é identificado por um namespace. O namespace é usado para criar uma URL exclusiva para o seu repositório de imagem que
os desenvolvedores podem usar para acessar imagens privadas do Docker.

    Saiba mais sobre [como proteger suas informações pessoais](cs_secure.html#pi) quando trabalhar com imagens de contêiner.

    Neste exemplo, a firma PR deseja criar somente um repositório de imagem no {{site.data.keyword.registryshort_notm}}; portanto, eles escolhem _pr_firm_ como o seu namespace para agrupar todas as imagens em sua conta. Substitua _&lt;namespace&gt;_ por um namespace de sua preferência que não esteja relacionado ao tutorial.

    ```
    ibmcloud cr namespace-add <namespace>
    ```
    {: pre}

3.  Antes de continuar com a próxima etapa, verifique se a implementação de seu nó do trabalhador está concluída.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Quando seu nó do trabalhador conclui o fornecimento, o status muda para **Pronto** e é possível iniciar a ligação de serviços do {{site.data.keyword.Bluemix_notm}}.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.10.7
    ```
    {: screen}

## Lição 3: configurando seu ambiente em cluster
{: #cs_cluster_tutorial_lesson3}

Configure o contexto para seu cluster do Kubernetes em sua CLI.
{: shortdesc}

Toda vez que você efetua login na CLI do {{site.data.keyword.containerlong}} para trabalhar com clusters, deve-se executar esses comandos para configurar o caminho para o arquivo de configuração do cluster como uma variável de sessão. O Kubernetes CLI usa essa variável para localizar um arquivo de configuração local e certificados que são necessárias para se conectar ao cluster no {{site.data.keyword.Bluemix_notm}}.

1.  Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração do Kubernetes.

    ```
    ibmcloud ks cluster-config <cluster_name_or_ID>
    ```
    {: pre}

    Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

    Exemplo para OS X:

    ```
    export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
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
    /Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
    ```
    {: screen}

4.  Verifique se os comandos `kubectl` são executados adequadamente com seu cluster verificando a versão do servidor de CLI do Kubernetes.

    ```
    kubectl version  --short
    ```
    {: pre}

    Saída de exemplo:

    ```
    Versão do cliente: v1.10.7 Versão do servidor: v1.10.7
    ```
    {: screen}

## Lição 4: incluindo um serviço em seu cluster
{: #cs_cluster_tutorial_lesson4}

Com serviços {{site.data.keyword.Bluemix_notm}}, é possível aproveitar a funcionalidade já desenvolvida nos apps. Qualquer serviço do {{site.data.keyword.Bluemix_notm}} que está ligado ao cluster do Kubernetes pode ser usado por qualquer app que esteja implementado nesse cluster. Repita as etapas a seguir para cada serviço do {{site.data.keyword.Bluemix_notm}} que você deseja usar com seus apps.
{: shortdesc}

1.  Inclua o serviço {{site.data.keyword.toneanalyzershort}} em sua conta do {{site.data.keyword.Bluemix_notm}}. Substitua <service_name> por um nome para sua instância de serviço.

    **Nota:** quando você incluir o serviço {{site.data.keyword.toneanalyzershort}} em sua conta, será exibida uma mensagem de que o serviço não é grátis. Se você limitar sua chamada API, este tutorial não incorrerá em encargos do serviço {{site.data.keyword.watson}}. [Revise as informações de precificação para o serviço {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block).

    ```
    ibmcloud service create tone_analyzer standard <service_name>
    ```
    {: pre}

2.  Ligue a instância do {{site.data.keyword.toneanalyzershort}} ao namespace `padrão` do Kubernetes para o cluster. Posteriormente, será possível criar seus próprios namespaces para gerenciar o acesso de usuário aos recursos do Kubernetes, mas por enquanto, use o namespace `padrão`. Os namespaces do Kubernetes são diferentes do namespace de registro que você criou anteriormente.

    ```
    ibmcloud ks cluster-service-bind <cluster_name> default <service_name>
    ```
    {: pre}

    Saída:

    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}

3.  Verifique se o segredo do Kubernetes foi criado em seu namespace do cluster. Cada serviço do {{site.data.keyword.Bluemix_notm}} é definido por um arquivo JSON que inclui informação confidencial, como o nome do usuário, senha e URL que o contêiner usa para obter acesso. Para armazenar essas informações com segurança, segredos do Kubernetes são usados. Neste exemplo, o segredo inclui as credenciais para acessar a instância do {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} que é provisionada em sua conta.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Saída:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
Bom trabalho! Seu cluster está configurado e seu ambiente local está pronto para você começar a implementar apps no cluster.

## O que Vem a Seguir?
{: #next}

* Teste seu conhecimento e [faça este questionário ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)!
* Tente o [Tutorial: implementando apps em clusters do Kubernetes](cs_tutorials_apps.html#cs_apps_tutorial) para implementar o app da firma PR no cluster que você criou.
