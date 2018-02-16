---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Integrando Serviços
{: #integrations}

É possível usar vários serviços externos e serviços no Catálogo do {{site.data.keyword.Bluemix_notm}} com um cluster padrão no {{site.data.keyword.containershort_notm}}.
{:shortdesc}

<table summary="Resumo para acessibilidade">
<caption>Tabela. Opções de integração para
clusters e apps no Kubernetes</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Blockchain</td>
<td>Implementar um ambiente de desenvolvimento publicamente disponível para o IBM Blockchain para um cluster do Kubernetes no {{site.data.keyword.containerlong_notm}}. Use esse ambiente para desenvolver e customizar sua própria rede de blockchain para implementar apps que compartilham um livro razão imutável para registrar o histórico de transações. Para obter mais informações, veja <a href="https://ibm-blockchain.github.io" target="_blank">Desenvolver em um ambiente de simulação de nuvem
IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Entrega Contínua</td>
<td>Automatize as construções de app e as implementações do contêiner para clusters do Kubernetes usando uma cadeia de ferramentas. Para obter informações de configuração, consulte o blog <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Implementar pods do Kubernetes no {{site.data.keyword.containerlong_notm}} usando DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh/" target="_blank">O Helm <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> é um gerenciador de pacote do Kubernetes. Crie Gráficos do Helm para definir, instalar e atualizar aplicativos complexos do Kubernetes em execução nos clusters do {{site.data.keyword.containerlong_notm}}. Saiba mais sobre como é possível <a href="https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/" target="_blank">aumentar a velocidade de implementação com os Gráficos do Helm do Kubernetes <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> O <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> fornece monitoramento de desempenho de infraestrutura e app com uma GUI que descobre automaticamente e mapeia seus apps. Além disso, o Istana captura cada solicitação para seus apps, que permite solucionar problemas e executar análise de causa raiz para evitar que os problemas aconteçam novamente. Confira a postagem do blog sobre <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">implementando o Istana no {{site.data.keyword.containershort_notm}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para saber mais.</td>
</tr>
<tr>
<td>Istio</td>
<td>O <a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> é um serviço de software livre que fornece aos desenvolvedores uma maneira de conectar, proteger, gerenciar e monitorar uma rede de microsserviços, também conhecida como rede de serviços, em plataformas de orquestração de nuvem como o Kubernetes. Confira a postagem do blog sobre <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">como a IBM cofundou e lançou o Istio<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para descobrir mais sobre o projeto de software livre. Para instalar o Istio em seu cluster do Kubernetes no {{site.data.keyword.containershort_notm}} e começar com um aplicativo de amostra, consulte [Tutorial: Gerenciando microsserviços com o Istio](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada
especificamente para o Kubernetes para recuperar informações detalhadas sobre o cluster, os nós do trabalhador e
o funcionamento de implementação com base nas informações de criação de log do Kubernetes. A atividade de CPU, memória, E/S e rede
de todos os contêineres em execução em um cluster é coletada e pode ser usada em consultas ou alertas customizados
para monitorar o desempenho e as cargas de trabalho em seu cluster.
<p>Para usar o Prometheus.</p>
<ol>
<li>Instale o Prometheus seguindo <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">as instruções do CoreOS <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.
<ol>
<li>Ao executar o comando de exportação, use seu namespace kube-system. <p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>Após o Prometheus ser implementado em seu cluster, edite a origem de dados do Orometheus no Grafana para
se referir a <code>prometheus.kube-system:30900</code>.</li>
</ol>
</td>
</tr>
<tr>
<td>{{site.data.keyword.bpshort}}</td>
<td>{{site.data.keyword.bplong}} é uma ferramenta de automação que usa o Terraform para implementar sua infraestrutura como código. Ao implementar sua infraestrutura como uma única unidade, é possível reutilizar essas definições de recurso em nuvem em qualquer número de ambientes. Para definir um cluster do Kubernetes como um recurso com o {{site.data.keyword.bpshort}}, tente criar um ambiente com o [modelo de cluster de contêiner](https://console.bluemix.net/schematics/templates/details/Cloud-Schematics%2Fcontainer-cluster). Para obter mais informações sobre diagramas, consulte [Sobre o {{site.data.keyword.bplong_notm}}](/docs/services/schematics/schematics_overview.html#about).</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>O Weave Scope fornece um diagrama visual de seus recursos dentro de um cluster do Kubernetes, incluindo serviços, pods, contêineres, processos, nós e muito mais. O Weave Scope fornece métricas interativas para CPU e memória e também fornece ferramentas para uso de tail e executável em um contêiner.<p>Para obter mais informações, veja [Visualizando os recursos de cluster do Kubernetes com o Weave Scope e o {{site.data.keyword.containershort_notm}}](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Incluindo serviços em clusters
{: #adding_cluster}

Incluindo uma instância de serviço existente do {{site.data.keyword.Bluemix_notm}} em seu cluster para permitir que os usuários do cluster acessem e usem o serviço do {{site.data.keyword.Bluemix_notm}} ao implementarem um app no cluster.
{:shortdesc}

Antes de iniciar:

1. [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.
2. [Solicite uma instância do serviço do {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).
   **Nota:** para criar uma instância de um serviço no local Washington DC, deve-se usar a CLI.

**Nota:**
<ul><ul>
<li>É possível incluir apenas serviços do {{site.data.keyword.Bluemix_notm}}
que suportem chaves de serviço. Se o serviço não suporta chaves de serviço, veja [Ativando apps externos para usar serviços do {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#accser_external).</li>
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


Para usar o serviço em um pod que é implementado no cluster, os usuários do cluster podem acessar as credenciais de serviço do serviço {{site.data.keyword.Bluemix_notm}} [montando o segredo do Kubernetes como um volume de segredo em um pod](cs_integrations.html#adding_app).

<br />



## Incluindo serviços em apps
{: #adding_app}

Os segredos criptografados do Kubernetes são usados para armazenar detalhes e credenciais do serviço do {{site.data.keyword.Bluemix_notm}} e permitem a comunicação segura entre o serviço e o cluster. Como usuário do cluster, é possível acessar esse segredo montando-o como um volume em um pod.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster. Certifique-se de que o serviço do {{site.data.keyword.Bluemix_notm}} que você deseja usar no app tenha sido [incluído no cluster](cs_integrations.html#adding_cluster) pelo administrador de cluster.

Segredos do Kubernetes são uma maneira segura para armazenar informação confidencial, como nomes de usuário, senhas ou chaves. Em vez de expor a informação confidencial por meio de variáveis de ambiente ou diretamente no Dockerfile, os segredos devem ser montados como um volume de segredo em um pod para serem acessíveis por um contêiner em execução em um pod.

Quando você monta um volume de segredo para o seu pod, um arquivo denominado ligação é armazenado no diretório de montagem do volume, incluindo todas as informações e credenciais necessárias para acessar o serviço do {{site.data.keyword.Bluemix_notm}}.

1.  Liste os segredos disponíveis em seu namespace do cluster.

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Procure um segredo do tipo **Opaco** e anote o **nome** do segredo. Se existirem múltiplos segredos, entre em contato com o administrador de cluster para identificar o segredo do serviço correto.

3.  Abra seu editor preferencial.

4.  Crie um arquivo YAML para configurar um pod que possa acessar os detalhes do serviço por meio de um volume de segredo.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>O nome do volume de segredo que você deseja montar em seu contêiner.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Insira um nome para o volume de segredo que você deseja montar em seu contêiner.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Configure as permissões somente leitura para o segredo do serviço.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Insira o nome do segredo que você anotou anteriormente.</td>
    </tr></tbody></table>

5.  Crie o pod e monte o volume de segredo.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  Verifique se o pod foi criado.

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    Exemplo de saída da CLI:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  Anote o **NOME** de seu pod.
8.  Obtenha os detalhes sobre o pod e procure o nome do segredo.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Saída:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  Ao implementar seu app, configure-o para localizar o arquivo de segredo chamado **binding** no diretório de montagem, analise o conteúdo de JSON e determine a URL e as credenciais de serviço para acessar o serviço do {{site.data.keyword.Bluemix_notm}}.

Agora é possível acessar os detalhes e as credenciais de serviço do {{site.data.keyword.Bluemix_notm}}. Para trabalhar com o serviço do {{site.data.keyword.Bluemix_notm}}, certifique-se de que o seu app esteja configurado para localizar o arquivo de segredo de serviço no diretório de montagem, analise o conteúdo JSON e determine os detalhes do serviço.

<br />



## Visualizando recursos de cluster do Kubernetes
{: #weavescope}

O Weave Scope fornece um diagrama visual de seus recursos dentro de um cluster do Kubernetes, incluindo serviços, pods, contêineres, processos, nós e muito mais. O Weave Scope fornece métricas interativas para CPU e memória e também fornece ferramentas para uso de tail e executável em um contêiner.
{:shortdesc}

Antes de iniciar:

-   Lembre-se de não expor as suas informações do cluster na Internet pública. Conclua estas etapas para implementar o Weave Scope com segurança e acessá-lo por meio de um navegador da web localmente.
-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui). O Weave Scope pode ser intensivo de CPU, especialmente o app. Execute o Weave Scope com clusters padrão maiores, não clusters lite.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.


Para usar o Weave Scope com um cluster:
2.  Implemente um dos arquivos de configuração de permissões do RBAC no cluster.

    Para ativar permissões de leitura/gravação:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Para ativar permissões somente leitura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
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

