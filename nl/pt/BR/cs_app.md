---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Implementando apps em clusters
{: #app}

É possível usar técnicas do Kubernetes para implementar apps e assegurar que seus aplicativos estejam funcionando em todos os momentos. Por exemplo, é possível executar atualizações e recuperações contínuas sem tempo de inatividade para seus usuários.
{:shortdesc}

Aprenda as etapas gerais para implementar apps clicando em uma área da imagem a seguir.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="Processo de implementação básica"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Instalar as CLIs." title="Instalar as CLIs." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Crie um arquivo de configuração para o seu app. Revise as melhores práticas do Kubernetes." title="Crie um arquivo de configuração para o seu app. Revise as melhores práticas do Kubernetes." shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="Opção 1: execute os arquivos de configuração da CLI do Kubernetes." title="Opção 1: execute os arquivos de configuração da CLI do Kubernetes." shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="Opção 2: inicie o painel do Kubernetes localmente e execute os arquivos de configuração." title="Opção 2: inicie o painel do Kubernetes localmente e execute os arquivos de configuração." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Planejando implementações altamente disponíveis
{: #highly_available_apps}

Quanto mais amplamente você distribui a configuração entre múltiplos nós do trabalhador e clusters,
menos provável que os usuários tenham que experimentar tempo de inatividade com seu app.

Revise as potenciais configurações de app a seguir que são ordenadas com graus crescentes de disponibilidade.
{:shortdesc}

![Estágios de alta disponibilidade para um app](images/cs_app_ha_roadmap.png)

1.  Uma implementação com n + 2 pods que são gerenciados por um conjunto de réplicas.
2.  Uma implementação com n + 2 pods que são gerenciados por um conjunto de réplicas e difundidos em múltiplos nós
(antiafinidade) no mesmo local.
3.  Uma implementação com n+2 pods que são gerenciados por um conjunto de réplicas e difundidos em
múltiplos nós (antiafinidade) em diferentes locais.
4.  Uma implementação com n + 2 pods que são gerenciados por um conjunto de réplicas e difundidos em
múltiplos nós (antiafinidade) em diferentes regiões.

Saiba mais sobre as técnicas para aumentar a disponibilidade de seu app:

<dl>
<dt>Usar implementações e conjuntos de réplicas para implementar seu app e suas dependências</dt>
<dd>Uma implementação é um recurso do Kubernetes que pode ser usado para declarar todos os componentes do app e
suas dependências. Descrever os componentes únicos em vez de escrever todas as etapas necessárias
e a ordem para criá-las, é possível se concentrar em como o app deve se parecer quando estiver
em execução.
</br></br>
Ao implementar mais de um pod, um conjunto de réplicas é criado automaticamente para as suas
implementações e monitora os pods e assegura que o número desejado de pods esteja ativo e em execução
sempre. Quando um pod fica inativo, o conjunto de réplicas substitui o pod não responsivo por um novo.
</br></br>
É possível usar uma implementação para definir estratégias de atualização para seu app incluindo o número de
módulos que você deseja incluir durante uma atualização contínua e o número de pods que podem estar indisponíveis
por vez. Ao executar uma atualização contínua, a implementação verifica se a revisão está ou não
funcionando e para o lançamento quando falhas são detectadas.
</br></br>
As implementações também fornecem a possibilidade
de implementar simultaneamente múltiplas revisões com diferentes sinalizações, portanto é possível, por exemplo, testar uma
implementação primeiro antes de decidir enviá-la por push para a produção.
</br></br>
Cada implementação mantém o controle
das revisões que foram implementadas. É possível usar esse histórico de revisões para retroceder para uma versão
anterior quando encontrar que as atualizações não estão funcionando conforme o esperado.</dd>
<dt>Incluir réplicas suficientes para a carga de trabalho de seu app, mais duas</dt>
<dd>Para tornar seu app ainda mais altamente disponível e mais resiliente à falha, considere a inclusão
de réplicas extras, além do mínimo, para manipular a carga de trabalho esperada. As réplicas extras podem manipular a
carga de trabalho no caso de um pod travar e o conjunto de réplicas ainda não tiver recuperado o pod travado. Para
proteção contra duas falhas simultâneas, inclua duas réplicas extras. Essa configuração é um padrão
N + 2, em que N é o número de réplicas para manipular a carga de trabalho recebida e + 2 são duas
réplicas extras. É possível ter quantos pods você desejar em um cluster, contanto que o cluster tenha espaço suficiente para eles.</dd>
<dt>Difundir pods em múltiplos nós (antiafinidade)</dt>
<dd>Ao criar sua implementação, cada pod pode ser implementado no mesmo nó do trabalhador. Essa configuração
na qual os pods existem no mesmo nó do trabalhador é conhecida como afinidade ou colocação. Para proteger o app
de uma falha do nó do trabalhador, é possível impingir a implementação para difundir os pods em múltiplos
nós do trabalhador usando a opção <strong>podAntiAffinity</strong>. Essa opção está disponível
somente para clusters padrão.

</br></br>
<strong>Nota:</strong> o arquivo YAML a seguir garante que cada pod seja implementado em um nó do trabalhador diferente. Quando você tem mais réplicas definidas do que tem nós do trabalhador disponíveis
no cluster, somente o número de réplicas que podem cumprir o requisito de antiafinidade
é implementado. Quaisquer réplicas adicionais permanecem em um estado pendente até que os nós do trabalhador adicionais sejam
incluídos no cluster.

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Deployment
metadados:
  name: wasliberty
spec:
  replicas: 3
  :
    metadados:
      labels:
        app: wasliberty
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - wasliberty
              topologyKey: kubernetes.io/hostname
      containers:
      - name: wasliberty
        image: registry.&lt;region&gt;.bluemix.net/ibmliberty
        ports:
        - containerPort: 9080
---
apiVersion: v1
kind: Service
metadata:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
    # the port that this service should serve on
  - port: 9080
  selector:
    app: wasliberty
  type: NodePort</code></pre>

</dd>
<dt>Distribuir pods em múltiplos locais ou regiões</dt>
<dd>Para proteger o app contra uma falha de local ou de região, será possível criar um segundo cluster em outro local ou região e usar um YAML de implementação para implementar um conjunto de réplicas duplicadas para o seu app. Incluindo uma rota e um balanceador de carga compartilhados na frente de seus clusters, é possível difundir a
carga de trabalho entre os locais e regiões. Para obter mais informações sobre compartilhamento de uma rota entre clusters, veja <a href="cs_clusters.html#clusters" target="_blank">Alta disponibilidade de clusters</a>.

Para obter mais detalhes, revise as opções para <a href="cs_clusters.html#planning_clusters" target="_blank">implementações altamente disponíveis</a>.</dd>
</dl>


### Implementação de app mínimo
{: #minimal_app_deployment}

Uma implementação básica de app em um cluster grátis ou padrão pode incluir os componentes a seguir.
{:shortdesc}

![Configuração de implementação](images/cs_app_tutorial_components1.png)

Para implementar os componentes para um app mínimo conforme descrito no diagrama, você usa um arquivo de configuração semelhante ao exemplo a seguir:
```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.<region>.bluemix.net/ibmliberty:latest
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    run: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

Para aprender mais sobre cada componente, revise os [Conceitos básicos do Kubernetes](cs_tech.html#kubernetes_basics).

<br />




## Ativando o painel do Kubernetes
{: #cli_dashboard}

Abra um painel do Kubernetes em seu sistema local para visualizar informações sobre um cluster e seus nós do trabalhador.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster. Essa tarefa requer a [política de acesso de Administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.

É possível usar a porta padrão ou configurar sua própria porta para ativar o painel do Kubernetes para um cluster.

1.  Para clusters com uma versão mestre do Kubernetes de 1.7.4 ou anterior:

    1.  Configure o proxy com o número da porta padrão.

        ```
        kubectl proxy
        ```
        {: pre}

        Saída:

        ```
        Iniciando a entrega em 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra o painel do Kubernetes em um navegador da web.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  Para clusters com uma versão mestre do Kubernetes de 1.8.2 ou mais recente:

    1.  Obtenha suas credenciais para o Kubernetes.

        ```
        kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
        ```
        {: pre}

    2.  Copie o valor **id-token** que é mostrado na saída.

    3.  Configure o proxy com o número da porta padrão.

        ```
        kubectl proxy
        ```
        {: pre}

        Saída de exemplo:

        ```
        Iniciando a entrega em 127.0.0.1:8001
        ```
        {: screen}

    4.  Conecte-se ao painel.

        1.  Em seu navegador, navegue para a URL a seguir:

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  Na página de conexão, selecione o método de autenticação **Token**.

        3.  Em seguida, cole o valor **id-token** que você copiou anteriormente no campo **Token** e clique em **CONECTAR**.

[Em seguida, é possível executar um arquivo de configuração do painel.](#app_ui)

Quando estiver pronto com o painel do Kubernetes, use `CTRL+C` para sair do comando `proxy`. Depois de sair, o painel do Kubernetes não estará mais disponível. Execute o comando `proxy` para reiniciar o painel do Kubernetes.



<br />




## Criando segredos
{: #secrets}

Segredos do Kubernetes são uma maneira segura para armazenar informação confidencial, como nomes de usuário,
senhas ou chaves.
{:shortdesc}

<table>
<caption>Tabela. Os arquivos necessários que precisam ser armazenados em segredos por tarefa</caption>
<thead>
<th>Tarefas</th>
<th>Os arquivos necessários para armazenar em segredos</th>
</thead>
<tbody>
<tr>
<td>Incluir um serviço em um cluster</td>
<td>Nenhuma. Um segredo é criado quando você liga um serviço a um cluster.</td>
</tr>
<tr>
<td>Opcional: configure o serviço de Ingresso com TLS, se você não estiver usando o segredo do ingresso. <p><b>Nota</b>: o TLS já está ativado por padrão e um segredo já está criado pela Conexão TLS.

Para visualizar o segredo do TLS padrão:
<pre>
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
Para criar o seu próprio, conclua as etapas neste tópico.</td>
<td>Certificado e chave do servidor: <code>server.crt</code> e <code>server.key</code></td>
<tr>
<td>Crie a anotação de autenticação mútua.</td>
<td>Certificado de CA: <code>ca.crt</code></td>
</tr>
</tbody>
</table>

Para obter mais informações sobre o que é possível armazenar em segredos, veja a [documentação do Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/).



Para criar um segredo com um certificado:

1. Gere o certificado e a chave da autoridade de certificação (CA) de seu provedor de certificado. Se você tiver seu próprio domínio, compre um certificado TLS oficial para seu domínio. Para propósitos de teste, é possível gerar um certificado autoassinado.

 Importante: assegure-se de que o [CN](https://support.dnsimple.com/articles/what-is-common-name/) seja diferente para cada certificado.

 O certificado do cliente e a chave do cliente devem ser verificados até o certificado de raiz confiável que, neste caso, é o certificado de CA. Exemplo:

 ```
 Certificado do cliente: emitido pelo Certificado intermediário
 Certificado intermediário: emitido pelo Certificado raiz
 Certificado raiz: emitido por si mesmo
 ```
 {: codeblock}

2. Crie o certificado como um segredo do Kubernetes.

   ```
   kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
   ```
   {: pre}

   Exemplos:
   - Conexão TLS:

     ```
     kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
     ```
     {: pre}

   - Anotação de autenticação mútua:

     ```
     kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
     ```
     {: pre}

<br />





## Implementando apps com a GUI
{: #app_ui}

Ao implementar um app em seu cluster usando o painel do Kubernetes, um recurso de implementação que cria, atualiza e gerencia os pods em seu cluster, será automaticamente criado.
{:shortdesc}

Antes de iniciar:

-   Instale as [CLIs](cs_cli_install.html#cs_cli_install) necessárias.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para implementar seu app:

1.  [Abra o painel do Kubernetes](#cli_dashboard).
2.  No painel do Kubernetes, clique em **+ Criar**.
3.  Selecione **Especificar detalhes do app abaixo** para inserir os detalhes do app na GUI ou **Fazer upload de um arquivo YAML ou JSON** para fazer upload do [arquivo de configuração do app ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). Use [este exemplo de arquivo YAML ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) para implementar um contêiner da imagem **ibmliberty** na região sul dos EUA.
4.  No painel do Kubernetes, clique em **Implementações** para verificar se a implementação foi criada.
5.  Se você disponibilizou o seu aplicativo publicamente usando um serviço de porta de nó, um serviço de balanceamento de carga ou Ingresso, verifique se você pode acessar o aplicativo.

<br />


## Implementando apps com a CLI
{: #app_cli}

Após um cluster ser criado, é possível implementar um app nesse cluster usando a CLI do Kubernetes.
{:shortdesc}

Antes de iniciar:

-   Instale as [CLIs](cs_cli_install.html#cs_cli_install) necessárias.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para implementar seu app:

1.  Crie um arquivo de configuração com base nas [melhores práticas do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/overview/). Geralmente, um arquivo de configuração contém detalhes de configuração para cada um dos recursos que você estiver criando no Kubernetes. Seu script pode incluir uma ou mais das seções a seguir:

    -   [Implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): define a criação de pods e conjuntos de réplicas. Um pod inclui um app conteinerizado individual e os conjuntos de réplicas controlam múltiplas instâncias de pods.

    -   [Serviço ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/): fornece acesso de front-end para os pods usando um nó do trabalhador ou um endereço IP público do balanceador de carga ou uma rota pública do Ingresso.

    -   [Ingresso ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/): especifica um tipo de balanceador de carga que fornece rotas para acessar seu app publicamente.

2.  Execute o arquivo de configuração no contexto de um cluster.

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  Se você disponibilizou o seu aplicativo publicamente usando um serviço de porta de nó, um serviço de balanceamento de carga ou Ingresso, verifique se você pode acessar o aplicativo.

<br />





## Ajuste de escala de apps
{: #app_scaling}

Implemente aplicativos em nuvem que respondam a mudanças em demanda para seus aplicativos e que usem recursos somente quando necessário. O Auto-scaling aumenta ou diminui automaticamente o número de instâncias de seus apps com base na CPU.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

**Nota:** você está procurando informações sobre ajuste de escala de aplicativos Cloud Foundry? Confira [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html).

Com o Kubernetes, é possível ativar o [Auto-scaling do pod horizontal ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale) para escalar seus apps com base na CPU.

1.  Implemente seu app no cluster a partir da CLI. Ao implementar seu app, deve-se solicitar a CPU.

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>O aplicativo que você deseja implementar.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>A CPU necessária para o contêiner, que é especificada em milinúcleos. Como um exemplo, <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>Quando true, cria um serviço externo.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>A porta em que seu app está disponível externamente.</td>
    </tr></tbody></table>

    **Nota:** para implementações mais complexas, pode ser necessário criar um [arquivo de configuração](#app_cli).
2.  Crie um Escalador automático de ajuste de pod horizontal e defina sua política. Para obter mais informações sobre como trabalhar com o comando `kubectl autoscale`, consulte [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>A utilização média da CPU que é mantida pelo Escalador automático de ajuste de pod horizontal, que é especificada em porcentagem.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>O número mínimo de pods implementados que são usados para manter a porcentagem de utilização da CPU especificada.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>O número máximo de pods implementados que são usados para manter a porcentagem de utilização da CPU especificada.</td>
    </tr>
    </tbody></table>



<br />


## Gerenciando implementações de rolagem
{: #app_rolling}

É possível gerenciar o lançamento de suas mudanças de forma automatizada e controlada. Se a sua apresentação não estiver indo de acordo com o plano, será possível recuperar a sua implementação para a revisão anterior.
{:shortdesc}

Antes de iniciar, crie uma [implementação](#app_cli).

1.  [Apresente ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout) uma mudança. Por exemplo, talvez você queira mudar a imagem usada na implementação inicial.

    1.  Obtenha o nome da implementação.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Obtenha o nome do pod.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Obtenha o nome do contêiner que está em execução no pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Configure a nova imagem para a implementação para usar.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    Ao executar os comandos, a mudança é imediatamente aplicada e registrada no histórico de apresentação.

2.  Verifique o status de sua implementação.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Recupere uma mudança.
    1.  Visualize o histórico de apresentação da implementação e identifique o número da revisão de sua última implementação.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Dica:** para ver os detalhes de uma revisão específica, inclua o número da revisão.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Recupere para a versão anterior ou especifique uma revisão. Para recuperar para a versão anterior, use o comando a seguir.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />

