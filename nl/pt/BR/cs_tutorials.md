---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

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



# Tutorial: criando clusters do Kubernetes
{: #cs_cluster_tutorial}

Com este tutorial, é possível implementar e gerenciar um cluster do Kubernetes no {{site.data.keyword.containerlong}}. Acompanhe uma empresa de relações públicas fictícia para aprender como automatizar a implementação, a operação, o ajuste de escala e o monitoramento de aplicativos conteinerizados em um cluster que se integram a outros serviços de nuvem como o {{site.data.keyword.ibmwatson}}.
{:shortdesc}

## Objetivos
{: #tutorials_objectives}

Neste tutorial, você trabalha para uma empresa de relações públicas (PR) e completa uma série de lições para configurar e configurar um ambiente em cluster Kubernetes customizado. Primeiro, você configura a CLI do {{site.data.keyword.cloud_notm}}, cria um cluster do {{site.data.keyword.containershort_notm}} e armazena as imagens de sua empresa PR em um {{site.data.keyword.registrylong}} privado. Em seguida, você provisiona um serviço {{site.data.keyword.toneanalyzerfull}} e liga-o ao seu cluster. Depois de implementar e testar um aplicativo Hello World em seu cluster, você implementa versões progressivamente mais complexas e altamente disponíveis do seu aplicativo {{site.data.keyword.watson}} para que sua empresa PR possa analisar press releases e receber feedback com a mais recente tecnologia de IA.
{:shortdesc}

O diagrama a seguir fornece uma visão geral do que você configurou neste tutorial.

<img src="images/tutorial_ov.png" width="500" alt="Crie um cluster e implemente um diagrama de visão geral do aplicativo Watson" style="width:500px; border-style: none"/>

## Tempo Necessário
{: #tutorials_time}

60 minutos


## Público
{: #tutorials_audience}

Esse tutorial destina-se a desenvolvedores de software e administradores de sistema que estão criando um cluster Kubernetes e implementando um aplicativo pela primeira vez.
{: shortdesc}

## Pré-requisitos
{: #tutorials_prereqs}

-  Verifique as etapas que você precisa executar para [preparar-se para criar um cluster](/docs/containers?topic=containers-clusters#cluster_prepare).
-  Assegure-se de que tenha as políticas de acesso a seguir:
    - A [função da plataforma **Administrador** do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o {{site.data.keyword.containerlong_notm}}
    - A [função da plataforma **Administrador** do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o {{site.data.keyword.registrylong_notm}}
    - A função de serviço [**Gravador** ou **Gerenciador** do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o {{site.data.keyword.containerlong_notm}}

## Lição 1: Configurando o ambiente em cluster
{: #cs_cluster_tutorial_lesson1}

Crie o cluster Kubernetes no console do {{site.data.keyword.Bluemix_notm}}, instale as CLIs necessárias, configure seu registro de contêiner e configure o contexto para o cluster Kubernetes na CLI.
{: shortdesc}

Como pode demorar alguns minutos para provisionar, crie seu cluster antes de configurar o restante de seu ambiente em cluster.

1.  [No console do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/kubernetes/catalog/cluster/create), crie um cluster grátis ou padrão com um conjunto de trabalhadores que tenha um nó do trabalhador nele.

    Também é possível criar um [cluster na CLI](/docs/containers?topic=containers-clusters#clusters_cli_steps).
    {: tip}
2.  Enquanto seu cluster é provisionado, instale a [CLI do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](/docs/cli?topic=cloud-cli-getting-started). Esta instalação inclui:
    -   A CLI do {{site.data.keyword.Bluemix_notm}} base (`ibmcloud`).
    -   O plug-in do {{site.data.keyword.containerlong_notm}} (`ibmcloud ks`). Use esse plug-in para gerenciar os clusters Kubernetes, como redimensionar os conjuntos de trabalhadores para a capacidade de cálculo incluída ou para ligar os serviços do {{site.data.keyword.Bluemix_notm}} ao cluster.
    -   Plug-in {{site.data.keyword.registryshort_notm}} (`ibmcloud cr`). Use esse plug-in para configurar e gerenciar um repositório de imagem privada no {{site.data.keyword.registryshort_notm}}.
    -   A CLI do Kubernetes (`kubectl`). Use essa CLI para implementar e gerenciar recursos do Kubernetes, como os pods e serviços do seu aplicativo.

    Se, em vez disso, desejar usar o console do {{site.data.keyword.Bluemix_notm}} após a criação de seu cluster, será possível executar comandos da CLI diretamente de seu navegador da web no [Terminal do Kubernetes](/docs/containers?topic=containers-cs_cli_install#cli_web).
    {: tip}
3.  Em seu terminal, efetue login na sua conta do {{site.data.keyword.Bluemix_notm}}. Insira suas credenciais do {{site.data.keyword.Bluemix_notm}} quando solicitadas. Se você tiver um ID federado, use o sinalizador `--sso` para efetuar login. Selecione a região e, se aplicável, o destino do grupo de recursos (`-g`) no qual você criou o cluster.
    ```
    ibmcloud login [-g <resource_group>] [--sso]
    ```
    {: pre}
5.  Verifique se os plug-ins estão instalados corretamente.
    ```
    ibmcloud plugin list
    ```
    {: pre}

    O plug-in do {{site.data.keyword.containerlong_notm}} é exibido nos resultados como **kubernetes-service** e o plug-in do {{site.data.keyword.registryshort_notm}} é exibido nos resultados como **container-registry**.
6.  Configure o seu próprio repositório de imagem privada no {{site.data.keyword.registryshort_notm}} para armazenar com segurança e compartilhar imagens do Docker com todos os usuários do cluster. Um repositório de imagem privada no {{site.data.keyword.Bluemix_notm}} é identificado por um namespace. O namespace é usado para criar uma URL exclusiva para o seu repositório de imagem que
os desenvolvedores podem usar para acessar imagens privadas do Docker.
    Saiba mais sobre [como proteger suas informações pessoais](/docs/containers?topic=containers-security#pi) quando trabalhar com imagens de contêiner.

    Neste exemplo, a firma PR deseja criar somente um repositório de imagem no {{site.data.keyword.registryshort_notm}}; portanto, eles escolhem `pr_firm` como o seu namespace para agrupar todas as imagens em sua conta. Substitua `<namespace>` por um namespace de sua escolha que não esteja relacionado ao tutorial.

    ```
    ibmcloud cr namespace-add <namespace>
    ```
    {: pre}
7.  Antes de continuar com a próxima etapa, verifique se a implementação de seu nó do trabalhador está concluída.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Quando seu nó do trabalhador conclui o fornecimento, o status muda para **Pronto** e é possível iniciar a ligação de serviços do {{site.data.keyword.Bluemix_notm}}.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.13.8
    ```
    {: screen}
8.  Configure o contexto para seu cluster do Kubernetes em sua CLI.
    1.  Obtenha o comando para configurar a variável de ambiente e fazer download dos arquivos de configuração
do Kubernetes. Toda vez que você efetua login na CLI do {{site.data.keyword.containerlong}} para trabalhar com clusters, deve-se executar esses comandos para configurar o caminho para o arquivo de configuração do cluster como uma variável de sessão. O Kubernetes CLI usa essa variável para localizar um arquivo de configuração local e certificados que são necessárias para se conectar ao cluster no {{site.data.keyword.Bluemix_notm}}.<p class="tip">Usando o Windows PowerShell? Inclua a sinalização `--powershell` para obter variáveis de ambiente no formato PowerShell do Windows.</p>
        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Quando o download dos arquivos de configuração estiver concluído, será exibido um comando que poderá ser usado para configurar o caminho para o seu arquivo de configuração local do Kubernetes como uma variável de ambiente.

        Exemplo para OS X:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/    pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}
    2.  Copie e cole o comando que é exibido em seu terminal para configurar a variável de ambiente `KUBECONFIG`.
    3.  Verifique se a variável de ambiente `KUBECONFIG` está configurada corretamente.

        Exemplo para OS X:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Saída de exemplo:

        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Verifique se os comandos `kubectl` são executados adequadamente com seu cluster verificando a versão do servidor de CLI do Kubernetes.
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

Bom trabalho! Você instalou com êxito as CLIs e configurou seu contexto de cluster para as lições a seguir. Em seguida, configure seu ambiente em cluster e inclua o serviço {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.

<br />


## Lição 2: Incluindo um serviço do IBM Cloud em seu cluster
{: #cs_cluster_tutorial_lesson2}

Com serviços {{site.data.keyword.Bluemix_notm}}, é possível aproveitar a funcionalidade já desenvolvida nos apps. Qualquer serviço do {{site.data.keyword.Bluemix_notm}} que está ligado ao cluster do Kubernetes pode ser usado por qualquer app que esteja implementado nesse cluster. Repita as etapas a seguir para cada serviço do {{site.data.keyword.Bluemix_notm}} que você deseja usar com seus apps.
{: shortdesc}

1.  Inclua o serviço {{site.data.keyword.toneanalyzershort}} em sua conta do {{site.data.keyword.Bluemix_notm}} na mesma região que seu cluster. Substitua `<service_name>` por um nome para a instância de serviço e `<region>` por uma região, como aquela em que seu cluster está.

    Quando você inclui o serviço do {{site.data.keyword.toneanalyzershort}} em sua conta, uma mensagem é exibida de que o serviço não está livre. Se você limitar sua chamada API, este tutorial não incorrerá em encargos do serviço {{site.data.keyword.watson}}. [Revise as informações de precificação para o serviço {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://cloud.ibm.com/catalog/services/tone-analyzer).
    {: note}

    ```
    ibmcloud resource service-instance-create <service_name> tone-analyzer standard <region>
    ```
    {: pre}
2.  Ligue a instância do {{site.data.keyword.toneanalyzershort}} ao namespace `padrão` do Kubernetes para o cluster. Posteriormente, será possível criar seus próprios namespaces para gerenciar o acesso de usuário aos recursos do Kubernetes, mas por enquanto, use o namespace `padrão`. Os namespaces do Kubernetes são diferentes do namespace de registro que você criou anteriormente.
    ```
    ibmcloud ks cluster-service-bind --cluster <cluster_name> --namespace default --service <service_name>
    ```
    {: pre}

    Saída de exemplo:
    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}
3.  Verifique se o segredo do Kubernetes foi criado em seu namespace do cluster. Quando você [liga um serviço {{site.data.keyword.Bluemix_notm}} ao seu cluster](/docs/containers?topic=containers-service-binding), é gerado um arquivo JSON que inclui informações confidenciais, como a chave de API do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) e a URL que o contêiner usa para obter acesso ao serviço. Para armazenar com segurança essas informações, o arquivo JSON é armazenado em um segredo do Kubernetes.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
Bom trabalho! Seu cluster está configurado e seu ambiente local está pronto para você começar a implementar apps no cluster.

Antes de continuar com a próxima lição, por que não testar seu conhecimento e [responder a um curto teste ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)?
{: note}

<br />


## Lição 3: Implementando aplicativos de instância única para clusters Kubernetes
{: #cs_cluster_tutorial_lesson3}

Na lição anterior, você configurou um cluster com um nó do trabalhador. Nesta lição, você configura uma implementação e implementa uma instância única do app em um pod do Kubernetes no nó do trabalhador.
{:shortdesc}

Os componentes que você implementa concluindo esta lição são mostrados no diagrama a seguir.

![Configuração de implementação](images/cs_app_tutorial_mz-components1.png)

Para implementar o app:

1.  Clone o código-fonte para o [app Hello World ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM/container-service-getting-started-wt) para o diretório inicial do usuário. O repositório contém versões diferentes de um app semelhante em pastas iniciadas com `Lab`. Cada versão contém os arquivos a seguir:
    *   `Dockerfile`: as definições de construção para a imagem.
    *   `app.js`: o app Hello World.
    *   `package.json`: metadados sobre o app.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

2.  Navegue para o diretório `Lab 1`.
    ```
    cd 'container-service-getting-started-wt/Lab 1'
    ```
    {: pre}
3.  Efetue login na CLI do {{site.data.keyword.registryshort_notm}}.
    ```
    ibmcloud cr login
    ```
    {: pre}

    Se você esqueceu o seu namespace no {{site.data.keyword.registryshort_notm}}, execute o comando a seguir.
    ```
    ibmcloud cr namespace-list
    ```
    {: pre}
4.  Construa uma imagem do Docker que inclua os arquivos de aplicativo do diretório `Lab 1` e envie por push a imagem para o namespace do {{site.data.keyword.registryshort_notm}} que você criou na lição anterior. Caso seja necessário fazer uma mudança no app no futuro, repita estas etapas para criar outra versão da imagem. **Nota**: saiba mais sobre [proteção de suas informações pessoais](/docs/containers?topic=containers-security#pi) quando você trabalhar com imagens de contêiner.

    Use caracteres alfanuméricos minúsculos ou sublinhados (`_`) somente no nome da imagem. Não esqueça o ponto (`.`) no final do comando. O ponto indica
ao Docker para verificar dentro do diretório atual para o Dockerfile e construir artefatos para construir a
imagem. **Nota**: deve-se especificar uma [região de registro](/docs/services/Registry?topic=registry-registry_overview#registry_regions), tal como `us`. Para obter a região de registro em que você está atualmente, execute `ibmcloud cr region`.

    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:1 .
    ```
    {: pre}

    Quando a construção estiver completa, verifique se você vê a mensagem de êxito a seguir:

    ```
    Successfully built <image_ID> Successfully tagged <region>.icr.io/<namespace>/hello-world:1 The push refers to a repository [<region>.icr.io/<namespace>/hello-world] 29042bc0b00c: Pushed f31d9ee9db57: Pushed 33c64488a635: Pushed 0804854a4553: Layer already exists 6bd4a62f5178: Layer already exists 9dfa40a0da3b: Layer already exists 1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
5.  Crie uma implementação. As implementações são usadas para gerenciar pods, que incluem instâncias conteinerizadas de um app. O comando a seguir implementa o aplicativo em uma única pod ao referir-se à imagem que você construiu em seu registro privado. Para os propósitos deste tutorial, a implementação é denominada **hello-world-deployment**, mas é possível fornecer à implementação qualquer nome que você desejar.
    ```
    kubectl create deployment hello-world-deployment --image=<region>.icr.io/<namespace>/hello-world:1
    ```
    {: pre}

    Saída de exemplo:
    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Saiba mais sobre [como proteger suas informações pessoais](/docs/containers?topic=containers-security#pi) quando trabalhar com recursos do Kubernetes.
6.  Torne o app acessível ao mundo expondo a implementação como um serviço NodePort. Assim como você pode expor uma porta para um app Cloud Foundry, o NodePort que você expõe é a porta na qual o nó do trabalhador atende o tráfego.
    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Saída de exemplo:
    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table summary="Informações sobre os parâmetros de comando de exposição.">
    <caption>Mais sobre os parâmetros de exposição</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> Mais sobre os parâmetros de exposição</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Exponha um recurso como um serviço do Kubernetes e disponibilize-o publicamente para os usuários.</td>
    </tr>
    <tr>
    <td><code>deployment/<em>&lt;hello-world-deployment&gt;</em></code></td>
    <td>O tipo de recurso e o nome do recurso a serem expostos com este serviço.</td>
    </tr>
    <tr>
    <td><code>--name=<em>&lt;hello-world-service&gt;</em></code></td>
    <td>O nome do serviço.</td>
    </tr>
    <tr>
    <td><code>--port=<em>&lt;8080&gt;</em></code></td>
    <td>A porta na qual o serviço atende.</td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>O tipo de serviço a ser criado.</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>A porta para a qual o serviço direciona o tráfego. Nessa instância, a porta de destino é a mesma que a porta, mas outros apps que você criar poderão diferir.</td>
    </tr>
    </tbody></table>
7. Agora que todo o trabalho de implementação está pronto, é possível testar seu app em um navegador. Obtenha os detalhes para formar a URL.
    1.  Obtenha informações sobre o serviço para ver qual NodePort foi designado.
        ```
        Kubectl describe service hello-world-service
        ```
        {: pre}

        Saída de exemplo:
        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.xxx.xx.xxx
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.xxx.xxx:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Os NodePorts são designados aleatoriamente quando são gerados com o comando `expose`, mas dentro de 30000-32767. Neste exemplo, o NodePort é 30872.
    2.  Obtenha o endereço IP público para o nó do trabalhador no cluster.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Saída de exemplo:
        ```
        ibmcloud ks workers --cluster pr_firm_cluster
        Listing cluster workers...
        OK
        ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
        kube-mil01-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.13.8
        ```
        {: screen}
8. Abra um navegador e consulte o aplicativo com a URL a seguir: `http://<IP_address>:<NodePort>`. Com os valores de exemplo, a URL é `http://169.xx.xxx.xxx:30872`. Ao
inserir essa URL em um navegador, é possível ver o texto
a seguir.
    ```
    Hello world! Seu app está funcionando em um contêiner!
    ```
    {: screen}

    Para ver se o app está publicamente disponível, tente inseri-lo em um navegador em seu telefone celular.
    {: tip}
9. [ Ativar o painel do Kubernetes ](/docs/containers?topic=containers-app#cli_dashboard).

    Se você selecionar seu cluster no [console do {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/), será possível usar o botão **Painel do Kubernetes** para ativar o painel com um clique.
    {: tip}
10. Na guia **Cargas de trabalho**, é possível ver os recursos que você criou.

Bom trabalho! Você implementou sua primeira versão do app.

Muitos comandos nesta lição? Acordado. Que tal usar um script de configuração para fazer alguns dos trabalhos para você? Para usar um script de configuração para a segunda versão do app e para criar maior disponibilidade implementando múltiplas instâncias desse app, continue com a próxima lição.

**Limpeza**<br>
Deseja excluir os recursos que você criou nesta lição antes de seguir em frente? Quando você criou a implementação, o Kubernetes designou a implementação de um rótulo, `app=hello-world-deployment` (ou o nome que você deu à implementação). Em seguida, quando você expôs a implementação, o Kubernetes aplicou o mesmo rótulo ao serviço que foi criado. Rótulos são ferramentas úteis para você organizar seus recursos do Kubernetes para que você possa aplicar ações em massa, como `get` ou `delete` para elas.

  É possível verificar todos os recursos que têm o rótulo `app=hello-world-deployment`.
  ```
  kubectl get all -l app=hello-world-deployment
  ```
  {: pre}

  Em seguida, é possível excluir todos os recursos com o rótulo.
  ```
  kubectl delete all -l app=hello-world-deployment
  ```
  {: pre}

  Saída de exemplo:
  ```
  pod "hello-world-deployment-5c78f9b898-b9klb" deleted
  service "hello-world-service" deleted
  deployment.apps "hello-world-deployment" deleted
  ```
  {: screen}

<br />


## Lição 4: Implementando e atualizando aplicativos com alta disponibilidade
{: #cs_cluster_tutorial_lesson4}

Nessa lição, você implementa três instâncias do app Hello World em um cluster para obter maior disponibilidade que a primeira versão do app.
{:shortdesc}

Disponibilidade mais alta significa que o acesso de usuário é dividido entre as três instâncias. Quando muitos usuários estão tentando acessar a mesma instância do app, eles podem observar tempos de resposta lentos. Múltiplas instâncias podem significar tempos de resposta mais rápidos para seus usuários. Nesta lição, você também aprenderá como as verificações de funcionamento e atualizações de implementação podem funcionar com o Kubernetes. O diagrama a seguir inclui os componentes que você implementa concluindo esta lição.

![Configuração de implementação](images/cs_app_tutorial_mz-components2.png)

Nas lições anteriores, você criou seu cluster com um nó do trabalhador e implementou uma única instância de um aplicativo. Nesta lição, você configura uma implementação e implementa três instâncias do app Hello World. Cada instância é implementada em um pod do Kubernetes como parte de um conjunto de réplicas no nó do trabalhador. Para torná-la publicamente disponível, você também cria um serviço do Kubernetes.

Conforme definido no script de configuração, o Kubernetes pode usar uma verificação de disponibilidade para ver se um contêiner em um pod está em execução ou não. Por exemplo, essas verificações podem capturar conflitos, em que um app está em execução, mas não consegue progredir. Reiniciar um contêiner que está nessa condição pode ajudar a tornar o app mais disponível apesar de erros. Então, o Kubernetes usa uma verificação de prontidão para saber quando um contêiner está pronto para começar a aceitar o tráfego novamente. Um pod é considerado pronto quando seu contêiner está pronto. Quando o pod está pronto, ele é iniciado novamente. Nesta versão do app, a cada 15 segundos, ele atinge o tempo limite. Com uma verificação de funcionamento configurada no script de configuração, os contêineres serão recriados se a verificação de funcionamento localizar um problema com um app.

Se você fez uma pausa na última lição e iniciou um novo terminal, certifique-se de efetuar login novamente em seu cluster.

1.  Em seu terminal, navegue para o diretório `Lab 2`.
    ```
    cd 'container-service-getting-started-wt/Lab 2'
    ```
    {: pre}
2.  Construa, identifique e envie por push o app como uma imagem para seu namespace no {{site.data.keyword.registryshort_notm}}. Não esqueça o ponto (`.`) no final do comando.
    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:2 .
      ```
    {: pre}

    Verifique se você vê a mensagem
de êxito.
    ```
    Successfully built <image_ID> Successfully tagged <region>.icr.io/<namespace>/hello-world:1 The push refers to a repository [<region>.icr.io/<namespace>/hello-world] 29042bc0b00c: Pushed f31d9ee9db57: Pushed 33c64488a635: Pushed 0804854a4553: Layer already exists 6bd4a62f5178: Layer already exists 9dfa40a0da3b: Layer already exists 1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
3.  No diretório `Lab 2`, abra o arquivo `healthcheck.yml` com um editor de texto. Esse script de configuração combina algumas etapas da lição anterior para criar uma implementação e um serviço ao mesmo tempo. Os desenvolvedores de app da firma PR podem usar esses scripts quando atualizações são feitas ou para solucionar problemas ao recriar os pods.
    1.  Atualize os detalhes para a imagem em seu namespace de registro privado.
        ```
        image: "<region>.icr.io/<namespace>/hello-world:2"
        ```
        {: codeblock}
    2.  Na seção **Implementação**, observe as `replicas`. As réplicas
são o número de instâncias de seu app. Executar três instâncias torna o app mais altamente disponível
do que apenas uma instância.
        ```
        replicas: 3
        ```
        {: codeblock}
    3.  Observe a análise de vivacidade de HTTP que verifica o funcionamento do contêiner a cada 5 segundos.
        ```
        livenessProbe:
                    httpGet:
                      path: /healthz
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 5
        ```
        {: codeblock}
    4.  Na seção **Serviço**, observe o `NodePort`. Em vez de gerar um NodePort aleatório como você fez na lição anterior, é possível especificar uma porta no intervalo 30000 - 32767. Esse exemplo usa 30072.
4.  Alterne de volta para a CLI que você usou para configurar seu contexto de cluster e execute o script de configuração. Quando a implementação e o serviço são criados, o app fica disponível para os usuários da firma PR verem.
    ```
    kubectl apply -f healthcheck.yml
    ```
    {: pre}

    Saída de exemplo:
    ```
    deployment "hw-demo-deployment" created
  service "hw-demo-service" created
    ```
    {: screen}
5.  Agora que o trabalho de implementação está feito, abra um navegador e efetue o registro de saída do aplicativo. Para formar a URL, tome o mesmo endereço IP público que você usou na lição anterior para seu nó do trabalhador e combine-o com o NodePort que foi especificado no script de configuração. Para obter o endereço IP público para o nó do trabalhador:
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Com os valores de exemplo, a URL é `http://169.xx.xxx.xxx:30072`. Em um navegador, você poderá ver o texto a seguir. Se não vir este texto, não se preocupe. Este app está
projetado para ficar ativo e
inativo.
    ```
    Hello world! Bom trabalho em deixar o segundo estágio funcionando.
    ```
    {: screen}

    Também é possível verificar `http://169.xx.xxx.xxx:30072/healthz` para obter o status.

    Para os primeiros 10 - 15 segundos, uma mensagem 200 é retornada, assim você sabe que o app está sendo executado com êxito. Após esses 15 segundos, uma mensagem de tempo limite é exibida. Este é um comportamento esperado.
    ```
    {
      "error": "Timeout, Health check error!"
  }
    ```
    {: screen}
6.  Verifique seu status do pod para monitorar o funcionamento de seu app no Kubernetes. É possível verificar o status na CLI ou no painel do Kubernetes.
    *   **Na CLI**: consulte o que está acontecendo com seus pods à medida que eles mudam o status.
        ```
        kubectl get pods -o wide -w
        ```
        {: pre}
    *   **No painel do Kubernetes**:
        1.  [ Ativar o painel do Kubernetes ](/docs/containers?topic=containers-app#cli_dashboard).
        2.  Na guia **Cargas de trabalho**, é possível ver os recursos que você criou. Nessa guia, é possível atualizar continuamente e ver que a verificação de funcionamento está funcionando. Na seção **Pods**, é possível ver quantas vezes os pods são reiniciados quando os contêineres dentro deles são recriados. Se acontecer de você capturar o erro a seguir no painel, esta mensagem indicará que a verificação de funcionamento capturou um problema. Espere alguns minutos e atualize novamente. Você verá o número de mudança de reinicializações para cada
pod.
        ```
        Liveness probe failed: HTTP probe failed with statuscode: 500
        Back-off restarting failed docker container
        Error syncing pod, skipping: failed to "StartContainer" for "hw-container" w      CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-d     deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
        ```
        {: screen}

Legal, você implementou a segunda versão do aplicativo. Você teve que usar menos comandos, aprendeu como funciona a verificação de funcionamento e editou uma implementação, o que é ótimo. O app Hello World passou no teste para a firma PR. Agora, é possível implementar um app mais útil para que a firma PR comece a analisar os press releases.

**Limpeza**<br>
Pronto para excluir o que você criou antes de continuar com a próxima lição? Desta vez, é possível usar o mesmo script de configuração para excluir ambos os recursos que você criou.

  ```
  kubectl delete -f healthcheck.yml
  ```
  {: pre}

  Saída de exemplo:

  ```
  deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
  ```
  {: screen}

<br />


## Lição 5: Implementando e atualizando o aplicativo Watson Tone Analyzer
{: #cs_cluster_tutorial_lesson5}

Nas lições anteriores, os apps foram implementados como componentes únicos em um nó do trabalhador. Nesta lição, é possível implementar dois componentes de um app em um cluster que usam o serviço {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.
{:shortdesc}

Separar os componentes em diferentes contêineres assegura que seja possível atualizar um sem afetar os outros. Em seguida, você atualiza o app para escalá-lo para cima com mais réplicas para torná-lo mais altamente disponível. O diagrama a seguir inclui os componentes que você implementa concluindo esta lição.

![Configuração de implementação](images/cs_app_tutorial_mz-components3.png)

No tutorial anterior, você tem a sua conta e um cluster com um nó do trabalhador. Nesta lição, você cria uma instância do serviço {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} em sua conta do {{site.data.keyword.Bluemix_notm}} e configura duas implementações, uma implementação para cada componente do app. Cada componente é implementado em um pod do Kubernetes no nó do trabalhador. Para tornar ambos os componentes publicamente disponíveis, você também cria um serviço do Kubernetes para cada componente.


### Lição 5a: Implementando o aplicativo {{site.data.keyword.watson}}{{site.data.keyword.toneanalyzershort}}
{: #lesson5a}

Implemente os aplicativos {{site.data.keyword.watson}}, acesse o serviço publicamente e analise algum texto com o aplicativo.
{: shortdesc}

Se você fez uma pausa na última lição e iniciou um novo terminal, certifique-se de efetuar login novamente em seu cluster.

1.  Em uma CLI, navegue para o diretório `Lab 3`.
    ```
    cd 'container-service-getting-started-wt/Lab 3'
    ```
    {: pre}

2.  Construa a primeira imagem {{site.data.keyword.watson}}.
    1.  Navegue para o diretório `watson`.
        ```
        cd watson
        ```
        {: pre}
    2.  Construa, identifique e envie por push o app `watson` como uma imagem para seu namespace no {{site.data.keyword.registryshort_notm}}. Novamente, não esqueça o ponto (`.`) no final do comando.
        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson .
        ```
        {: pre}

        Verifique se você vê a mensagem
de êxito.
        ```
        Successfully built <image_id>
        ```
        {: screen}
    3.  Repita essas etapas para construir a segunda imagem do `watson-talk`.
        ```
        cd 'container-service-getting-started-wt/Lab 3/watson-talk'
        ```
        {: pre}

        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson-talk .
        ```
        {: pre}
3.  Verifique se as imagens foram incluídas com êxito em seu namespace de registro.
    ```
    imagens ibmcloud cr
    ```
    {: pre}

    Saída de exemplo:

    ```
    Listing images...

    REPOSITORY                        NAMESPACE  TAG      DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    us.icr.io/namespace/watson        namespace  latest   fedbe587e174   3 minutes ago   274 MB   OK
    us.icr.io/namespace/watson-talk   namespace  latest   fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}
4.  No diretório `Lab 3`, abra o arquivo `watson-deployment.yml` com um editor de texto. Esse script de configuração inclui uma implementação e um serviço para ambos os componentes do app, `watson` e `watson-talk`.
    1.  Atualize os detalhes para a imagem em seu namespace de registro para ambas as implementações.
        **watson**:
        ```
        image: "<region>.icr.io/<namespace>/watson"
        ```
        {: codeblock}

        **watson-talk**:
        ```
        image: "<region>.icr.io/<namespace>/watson-talk"
        ```
        {: codeblock}
    2.  Na seção de volumes da implementação `watson-pod`, atualize o nome do {{site.data.keyword.watson}}segredo do {{site.data.keyword.toneanalyzershort}} que você criou na [Lição 2](#cs_cluster_tutorial_lesson2). Ao montar o segredo do Kubernetes como um volume para sua implementação, você disponibiliza a chave de API do {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) para o contêiner que está em execução em seu pod. Os componentes do app do {{site.data.keyword.watson}} neste tutorial são configurados para consultar a chave de API usando o caminho de montagem do volume.
        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-mytoneanalyzer
        ```
        {: codeblock}

        Se você esqueceu como nomeou o segredo, execute o comando a seguir.
        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}
    3.  Na seção do serviço watson-talk, anote o valor que está configurado para o `NodePort`. Esse exemplo usa 30080.
5.  Execute o script de configuração.
    ```
    kubectl apply -f watson-deployment.yml
    ```
    {: pre}
6.  Opcional: verifique se o segredo do {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} está montado como um volume para o pod.
    1.  Para obter o nome de um pod do watson, execute o comando a seguir.
        ```
        kubectl get pods
        ```
        {: pre}

        Saída de exemplo:
        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}
    2.  Obtenha os detalhes sobre o pod e procure o nome do segredo.
        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

        Saída de exemplo:
        ```
        Volumes:
          service-bind-volume:
            Type:       Secret (a volume populated by a Secret)
            SecretName: binding-mytoneanalyzer
          default-token-j9mgd:
            Type:       Secret (a volume populated by a Secret)
            SecretName: default-token-j9mgd
        ```
        {: codeblock}
7.  Abra um navegador e analise algum texto. O formato da URL é `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"`.
    Exemplo:
    ```
    http://169.xx.xxx.xxx:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    Em um navegador, é possível ver a resposta JSON para o texto inserido.
    ```
    {
      "document_tone": {
        "tone_categories": [
          {
            "tones": [
              {
                "score": 0.011593,
                "tone_id": "anger",
                "tone_name": "Anger"
              },
              ...
            "category_id": "social_tone",
            "category_name": "Social Tone"
          }
        ]
      }
    }
    ```
    {: screen}
8. [ Ativar o painel do Kubernetes ](/docs/containers?topic=containers-app#cli_dashboard).
9. Na guia **Cargas de trabalho**, é possível ver os recursos que você criou.

### Lição 5b: Atualizando a implementação do Watson Tone Analyzer em execução
{: #lesson5b}

Enquanto uma implementação está em execução, é possível editá-la para mudar valores no modelo de pod. Nesta lição, a firma PR deseja mudar o aplicativo na implementação atualizando a imagem que é usada.
{: shortdesc}

Mude o nome da imagem:

1.  Abra os detalhes da configuração para a implementação em execução.
    ```
    kubectl edit deployment/watson-talk-pod
    ```
    {: pre}

    Dependendo do seu sistema operacional, um editor de vi ou um editor de texto se abre.
2.  Mude o nome da imagem para a imagem `ibmliberty`.
    ```
    spec:
          containers:
          - image: <region>.icr.io/ibmliberty:latest
    ```
    {: codeblock}
3.  Salve as mudanças e saia do editor.
4.  Aplique as mudanças na implementação em execução.
    ```
    kubectl rollout status deployment/watson-talk-pod
    ```
    {: pre}

    Aguarde a confirmação
de que o lançamento esteja
completo.
    ```
    deployment "watson-talk-pod" successfully rolled out
    ```
    {: screen}
    Quando você apresenta uma mudança, outro pod é criado e testado pelo Kubernetes. Quando o teste é bem-sucedido, o pod antigo é removido.

Bom trabalho! Você implementou o {{site.data.keyword.watson}} aplicativo{{site.data.keyword.toneanalyzershort}} e aprendeu a executar uma atualização simples do aplicativo. A empresa PR pode usar essa implementação para iniciar a análise de seus press releases com a tecnologia mais recente de IA.

**Limpeza**<br>
Pronto para excluir o aplicativo {{site.data.keyword.watson}}{{site.data.keyword.toneanalyzershort}} que você criou em seu cluster do {{site.data.keyword.containerlong_notm}}? É possível usar o script de configuração para excluir os recursos criados.

  ```
  kubectl delete -f watson-deployment.yml
  ```
  {: pre}

  Saída de exemplo:

  ```
  deployment "watson-pod" deleted
deployment "watson-talk-pod" deleted
service "watson-service" deleted
service "watson-talk-service" deleted
  ```
  {: screen}

  Se você não deseja manter o cluster, é possível excluí-lo também.

  ```
  ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
  ```
  {: pre}

Hora do teste! Você estudou muito material, portanto, [certifique-se de que você entendeu tudo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php). Não se preocupe, o teste não é cumulativo.
{: note}

<br />


## O que Vem a Seguir?
{: #tutorials_next}

Agora que você conquistou o básico, é possível mover para atividades mais avançadas. Considere experimentar um dos recursos a seguir para fazer mais com o {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

*   Conclua um [laboratório mais complicado ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM/container-service-getting-started-wt#lab-overview) no repositório.
*   Saiba como criar [aplicativos altamente disponíveis](/docs/containers?topic=containers-ha) usando recursos como clusters multizona, armazenamento persistente, escalador automático de cluster e escala automática de pod horizontal para aplicativos.
*   Explore os padrões de código de orquestração do contêiner no [IBM Developer ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/technologies/containers/).
