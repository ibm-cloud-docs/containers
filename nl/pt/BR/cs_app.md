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




# Implementando apps em clusters
{: #app}

É possível usar técnicas do Kubernetes no {{site.data.keyword.containerlong}} para implementar apps em contêineres e assegurar que os apps estejam funcionando sempre. Por exemplo, é possível executar atualizações e recuperações contínuas sem tempo de inatividade para seus usuários.
{: shortdesc}

Aprenda as etapas gerais para implementar apps clicando em uma área da imagem a seguir. Deseja aprender o básico primeiro? Experimente o  [ tutorial de implementação de apps ](cs_tutorials_apps.html#cs_apps_tutorial).

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
{: shortdesc}

Revise as potenciais configurações de app a seguir que são ordenadas com graus crescentes de disponibilidade.

![Estágios de alta disponibilidade para um app](images/cs_app_ha_roadmap-mz.png)

1.  Uma implementação com n+2 pods que são gerenciados por um conjunto de réplicas em um único nó em um cluster de zona única.
2.  Uma implementação com n+2 pods que são gerenciados por um conjunto de réplicas e difundidos em múltiplos nós (antiafinidade) em um cluster de zona única.
3.  Uma implementação com n+2 pods que são gerenciados por um conjunto de réplicas e difundidos entre múltiplos nós (antiafinidade) em um cluster de múltiplas zonas entre zonas.

Também é possível [conectar múltiplos clusters em regiões diferentes com um balanceador de carga global](cs_clusters_planning.html#multiple_clusters) para aumentar a alta disponibilidade.

### Aumentando a disponibilidade de seu app
{: #increase_availability}

<dl>
  <dt>Usar implementações e conjuntos de réplicas para implementar seu app e suas dependências</dt>
    <dd><p>Uma implementação é um recurso do Kubernetes que pode ser usado para declarar todos os componentes de seu app e suas dependências. Com as implementações, não é necessário anotar todas as etapas e, em vez disso, é possível se concentrar no app.</p>
    <p>Ao implementar mais de um pod, um conjunto de réplicas é criado automaticamente para as suas
implementações e monitora os pods e assegura que o número desejado de pods esteja ativo e em execução
sempre. Quando um pod fica inativo, o conjunto de réplicas substitui o pod não responsivo por um novo.</p>
    <p>É possível usar uma implementação para definir estratégias de atualização para seu app incluindo o número de
módulos que você deseja incluir durante uma atualização contínua e o número de pods que podem estar indisponíveis
por vez. Ao executar uma atualização contínua, a implementação verifica se a revisão está ou não
funcionando e para o lançamento quando falhas são detectadas.</p>
    <p>Com as implementações, é possível implementar simultaneamente múltiplas revisões com diferentes sinalizações. Por exemplo, é possível testar uma implementação primeiro antes de decidir enviá-la por push para a produção.</p>
    <p>As implementações permitem manter o controle de qualquer revisão implementada. Será possível usar esse histórico para recuperar uma versão anterior se você descobrir que as suas atualizações não estão funcionando conforme o esperado.</p></dd>
  <dt>Incluir réplicas suficientes para a carga de trabalho de seu app, mais duas</dt>
    <dd>Para tornar seu app ainda mais altamente disponível e mais resiliente à falha, considere a inclusão
de réplicas extras, além do mínimo, para manipular a carga de trabalho esperada. As réplicas extras podem manipular a
carga de trabalho no caso de um pod travar e o conjunto de réplicas ainda não tiver recuperado o pod travado. Para
proteção contra duas falhas simultâneas, inclua duas réplicas extras. Essa configuração é um padrão N + 2, em que N é o número de réplicas para manipular a carga de trabalho recebida e + 2 são duas réplicas extras. Desde que seu cluster tenha espaço suficiente, será possível ter tantos pods quantos você quiser.</dd>
  <dt>Difundir pods em múltiplos nós (antiafinidade)</dt>
    <dd><p>Quando você cria a sua implementação, cada pod pode ser implementado no mesmo nó do trabalhador. Isso é conhecido como afinidade ou colocação. Para proteger seu app contra falha do nó do trabalhador, será possível configurar sua implementação para difundir os pods em múltiplos nós do trabalhador usando a opção <em>podAntiAffinity</em> com seus clusters padrão. É possível definir dois tipos de antiafinidade do pod: preferencial ou necessário. Para obter mais informações, veja a documentação do Kubernetes no <a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(Abre em uma nova guia ou janela)">Designando pods aos nós</a>.</p>
    <p><strong>Nota</strong>: com a antiafinidade necessária, só será possível implementar a quantia de réplicas para as quais você tiver nós do trabalhador. Por exemplo, se você tiver 3 nós do trabalhador no cluster, mas definir 5 réplicas no arquivo YAML, apenas 3 réplicas serão implementadas. Cada réplica mora em um nó de trabalhador diferente. Os restantes 2 réplicas continuam pendentes. Se você incluir outro nó do trabalhador no cluster, uma das réplicas restantes será implementada no novo nó do trabalhador automaticamente.<p>
    <p><strong>Exemplo de arquivos YAML de implementação</strong>:<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="(Abre em uma nova guia ou janela)">App Nginx com antiafinidade preferencial de pod.</a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="(Abre em uma nova guia ou janela)">App IBM® WebSphere® Application Server Liberty com antiafinidade preferencial de pod.</a></li></ul></p>
    
    </dd>
<dt>Distribuir pods em múltiplas zonas ou regiões</dt>
  <dd><p>Para proteger seu app de uma falha de zona, é possível criar múltiplos clusters em zonas separadas ou incluir zonas em um conjunto de trabalhadores em um cluster de múltiplas zonas. Os clusters de múltiplas zonas estão disponíveis somente em [determinadas áreas metropolitanas](cs_regions.html#zones), como Dallas. Se você cria múltiplos clusters em zonas separadas, deve-se [configurar um balanceador de carga global](cs_clusters_planning.html#multiple_clusters).</p>
  <p>Ao usar um conjunto de réplicas e especificar a antiafinidade do pod, o Kubernetes difunde seus pods de app entre os nós. Se os seus nós estiverem em múltiplas zonas, os pods serão difundidos pelas zonas, aumentando a disponibilidade do seu app. Se você desejar limitar seus apps para serem executados somente em uma zona, será possível configurar a afinidade de pod ou criar e rotular um conjunto de trabalhadores em uma zona. Para obter mais informações, consulte [Alta disponibilidade para clusters de múltiplas zonas](cs_clusters_planning.html#ha_clusters).</p>
  <p><strong>Em uma implementação de cluster de múltiplas zonas, meus pods de app são distribuídos uniformemente entre os nós?</strong></p>
  <p>Os pods são distribuídos uniformemente entre as zonas, mas nem sempre entre os nós. Por exemplo, se você tiver um cluster com 1 nó em cada uma das 3 zonas e implementar um conjunto de réplicas de 6 pods, cada nó obterá dois pods. No entanto, se você tiver um cluster com 2 nós em cada uma das 3 zonas e implementar um conjunto de réplicas de 6 pods, cada zona terá 2 pods planejados e poderá ou não planejar 1 pod por nó. Para obter mais controle sobre o planejamento, é possível [configurar a afinidade de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node).</p>
  <p><strong> Se uma zona ficar inativa, como os pods serão reprogramados para os nós restantes nas outras zonas?</strong></br>Isso depende da política de planejamento que você usou na implementação. Se você incluiu a [afinidade de pod específica do nó ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature), seus pods não serão reprogramados. Se você não tiver feito isso, os pods serão criados em nós do trabalhador disponíveis em outras zonas, mas eles podem não ser balanceados. Por exemplo, os 2 pods podem ser difundidos entre os 2 nós disponíveis ou ambos podem ser planejados para 1 nó com capacidade disponível. Da mesma forma, quando a zona indisponível retornar, os pods não serão excluídos e rebalanceados automaticamente entre os nós. Se desejar que os pods sejam rebalanceados entre as zonas depois que a zona estiver de volta, considere usar o [Desplanejador do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/kubernetes-incubator/descheduler).</p>
  <p><strong>Dica</strong>: em clusters de múltiplas zonas, tente manter a capacidade do seu nó do trabalhador em 50% por zona, para que você tenha capacidade suficiente para proteger o seu cluster com relação a uma falha zonal.</p>
  <p><strong>E se eu desejar difundir meu app entre regiões?</strong></br>Para proteger seu app de uma falha de região, crie um segundo cluster em outra região, [configure um balanceador de carga global](cs_clusters_planning.html#multiple_clusters) para conectar seus clusters e use um YAML de implementação para implementar um conjunto de réplicas duplicado com [antiafinidade de pod ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) para seu app.</p>
  <p><strong>E se meus apps precisarem de armazenamento persistente?</strong></p>
  <p>Use um serviço de nuvem como o [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) ou o [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).</p></dd>
</dl>



### Implementação de app mínimo
{: #minimal_app_deployment}

Uma implementação básica de app em um cluster grátis ou padrão pode incluir os componentes a seguir.
{: shortdesc}

![Configuração de implementação](images/cs_app_tutorial_components1.png)

Para implementar os componentes para um app mínimo conforme descrito no diagrama, você usa um arquivo de configuração semelhante ao exemplo a seguir:
```
apiVersion: apps/v1beta1
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
        image: registry.bluemix.net/ibmliberty:latest
        ports:
        - containerPort: 9080        
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    app: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

**Nota:** para expor seu serviço, certifique-se de que o par de chave/valor usado na seção `spec.selector` do serviço é o mesmo par de chave/valor usado na seção `spec.template.metadata.labels` do yaml de sua implementação.
Para aprender mais sobre cada componente, revise os [Conceitos básicos do Kubernetes](cs_tech.html#kubernetes_basics).

<br />






## Ativando o painel do Kubernetes
{: #cli_dashboard}

Abra um painel do Kubernetes em seu sistema local para visualizar informações sobre um cluster e seus nós do trabalhador. [Na GUI](#db_gui), é possível acessar o painel com um conveniente botão de um clique. [Com a CLI](#db_cli), é possível acessar o painel ou usar as etapas em um processo de automação, como para um pipeline CI/CD.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

É possível usar a porta padrão ou configurar sua própria porta para ativar o painel do Kubernetes para um cluster.

**Ativando o painel do Kubernetes por meio da GUI**
{: #db_gui}

1.  Efetue login no [{{site.data.keyword.Bluemix_notm}} GUI](https://console.bluemix.net/).
2.  No seu perfil na barra de menus, selecione a conta que você deseja usar.
3.  No menu, clique em **Contêineres**.
4.  Na página **Clusters**, clique no cluster que você deseja acessar.
5.  Na página de detalhes do cluster, clique no botão **Painel do Kubernetes**.

</br>
</br>

**Ativando o painel do Kubernetes por meio da CLI**
{: #db_cli}

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

Quando estiver pronto com o painel do Kubernetes, use `CTRL+C` para sair do comando `proxy`. Depois de sair, o painel do Kubernetes não estará mais disponível. Execute o comando `proxy` para reiniciar o painel do Kubernetes.

[Em seguida, é possível executar um arquivo de configuração do painel.](#app_ui)

<br />


## Criando segredos
{: #secrets}

Segredos do Kubernetes são uma maneira segura para armazenar informação confidencial, como nomes de usuário,
senhas ou chaves.
{:shortdesc}

Revise as tarefas a seguir que requerem segredos. Para obter mais informações sobre o que é possível armazenar em segredos, consulte a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/secret/).

### Incluindo um serviço em um cluster
{: #secrets_service}

Quando você liga um serviço a um cluster, não é necessário criar um segredo. Um segredo é criado automaticamente para você. Para obter mais informações, consulte [Incluindo serviços do Cloud Foundry em clusters](cs_integrations.html#adding_cluster).

### Configurando o ALB do Ingresso para usar o TLS
{: #secrets_tls}

O ALB faz o balanceamento de carga do tráfego de rede HTTP para os apps no cluster. Para também balancear a carga de conexões HTTPS recebidas, será possível configurar o ALB para decriptografar o tráfego de rede e encaminhar a solicitação decriptografada para os apps expostos no cluster.

Se estiver usando o subdomínio do Ingresso fornecido pela IBM, será possível [usar o certificado TLS fornecido pela IBM](cs_ingress.html#public_inside_2). Para visualizar o segredo do TLS fornecido pela IBM, execute o comando a seguir:
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep "Ingress secret"
```
{: pre}

Se você estiver usando um domínio customizado, será possível usar seu próprio certificado para gerenciar a finalização do TLS. Para criar seu próprio segredo do TLS:
1. Gere uma chave e um certificado de uma das maneiras a seguir:
    * Gere um certificado de autoridade de certificação (CA) e a chave por meio do provedor de certificado. Se você tiver seu próprio domínio, compre um certificado TLS oficial para seu domínio.
      **Importante**: certifique-se de que o [CN ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://support.dnsimple.com/articles/what-is-common-name/) seja diferente para cada certificado.
    * Para propósitos de teste, é possível criar um certificado auto-assinado usando o OpenSSL. Para obter mais informações, consulte esse [tutorial de certificado SSL autoassinado ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Crie um  ` tls.key `.
            ```
            openssl genrsa -out tls.key 2048
            ```
            {: pre}
        2. Use a chave para criar um `tls.crt`.
            ```
            openssl req -new -x509 -key tls.key -out tls.crt
            ```
            {: pre}
2. [Converta o certificado e a chave para base-64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).
3. Crie um arquivo YAML secreto usando o certificado e a chave.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### Customizando o ALB do Ingresso com a anotação de serviços SSL
{: #secrets_ssl_services}

É possível usar a [anotação `ingress.bluemix.net/ssl-services`](cs_annotations.html#ssl-services) para criptografar o tráfego para seus apps de envio de dados por meio do ALB do Ingresso. Para criar o segredo:

1. Obtenha a chave e o certificado de autoridade de certificação (CA) de seu servidor de envio de dados.
2. [Converta o certificado na base 64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).
3. Crie um arquivo do YAML secreto usando o cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **Nota**: se você desejar também cumprir a autenticação mútua para o tráfego de envio de dados, será possível fornecer um `client.crt` e `client.key`, além do `trusted.crt` na seção de dados.
4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### Customizando o ALB do Ingresso com a anotação de autenticação mútua
{: #secrets_mutual_auth}

É possível usar a [anotação `ingresss.bluemix.net/mutual-auth`](cs_annotations.html#mutual-auth) para configurar a autenticação mútua do tráfego de recebimento de dados para o ALB do Ingress. Para criar um segredo de autenticação mútua:

1. Gere uma chave e um certificado de uma das maneiras a seguir:
    * Gere um certificado de autoridade de certificação (CA) e a chave por meio do provedor de certificado. Se você tiver seu próprio domínio, compre um certificado TLS oficial para seu domínio.
      **Importante**: certifique-se de que o [CN ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://support.dnsimple.com/articles/what-is-common-name/) seja diferente para cada certificado.
    * Para propósitos de teste, é possível criar um certificado auto-assinado usando o OpenSSL. Para obter mais informações, consulte esse [tutorial de certificado SSL autoassinado ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Crie um `ca.key`.
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. Use a chave para criar um `ca.crt`.
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. Use o `ca.crt` para criar um certificado autoassinado.
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [Converta o certificado na base 64 ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.base64encode.org/).
3. Crie um arquivo do YAML secreto usando o cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. Crie o certificado como um segredo do Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## Implementando apps com a GUI
{: #app_ui}

Ao implementar um app em seu cluster usando o painel do Kubernetes, um recurso de implementação cria, atualiza e gerencia automaticamente os pods em seu cluster.
{:shortdesc}

Antes de iniciar:

-   Instale as [CLIs](cs_cli_install.html#cs_cli_install) necessárias.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para implementar seu app:

1.  Abra o [painel](#cli_dashboard) do Kubernetes e clique em **+ Criar**.
2.  Insira os detalhes do app em uma de duas maneiras.
  * Selecione **Especificar detalhes do app abaixo** e insira os detalhes.
  * Selecione **Fazer upload de um arquivo YAML ou JSON** para fazer upload do [arquivo de configuração de seu app ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

  Precisa de ajuda com seu arquivo de configuração. Verifique este [arquivo YAML de exemplo ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml). Neste exemplo, um contêiner é implementado por meio da imagem **ibmliberty** na região sul dos EUA. Saiba mais sobre [como proteger suas informações pessoais](cs_secure.html#pi) quando trabalhar com recursos do Kubernetes.
  {: tip}

3.  Verifique se você implementou com sucesso o seu app em uma das maneiras a seguir.
  * No painel do Kubernetes, clique em **Implementações**. Uma lista de implementações bem-sucedidas é exibida.
  * Se o seu app estiver [publicamente disponível](cs_network_planning.html#public_access), navegue para a página de visão geral do cluster no painel do {{site.data.keyword.containerlong}}. Copie o subdomínio, que está localizado na seção de resumo do cluster e cole-o em um navegador para visualizar seu app.

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

    Saiba mais sobre [como proteger suas informações pessoais](cs_secure.html#pi) quando trabalhar com recursos do Kubernetes.

2.  Execute o arquivo de configuração no contexto de um cluster.

    ```
    Kubectl apply -f config.yaml
    ```
    {: pre}

3.  Se você disponibilizou o seu app publicamente usando um serviço de porta de nó, um serviço de balanceador de carga ou Ingresso, verifique se é possível acessar o app.

<br />


## Implementando apps em nós do trabalhador específicos usando rótulos
{: #node_affinity}

Ao implementar um app, os pods de app são implementados indiscriminadamente em vários nós do trabalhador em seu cluster. Em alguns casos, você pode desejar restringir os nós do trabalhador nos quais os pods de app são implementados. Por exemplo, você pode desejar que os pods de app sejam implementados somente em nós do trabalhador em um determinado conjunto de trabalhadores porque esses nós do trabalhador estão em máquinas bare metal. Para designar os nós do trabalhador nos quais os pods de app devem ser implementados, inclua uma regra de afinidade em sua implementação de app.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

1. Obtenha o nome do conjunto de trabalhadores no qual você deseja implementar os pods de app.
    ```
    ibmcloud ks worker-pools <cluster_name_or_ID>
    ```
    {:pre}

    Essas etapas usam um nome do conjunto de trabalhadores como um exemplo. Para implementar os pods de app em determinados nós do trabalhador com base em outro fator, obtenha esse valor no lugar. Por exemplo, para implementar pods de app somente em nós do trabalhador em uma VLAN específica, obterá o ID de VLAN executando `ibmcloud ks vlans <zone>`.
    {: tip}

2. [Inclua uma regra de afinidade ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) para o nome do conjunto de trabalhos para a implementação de app.

    Exemplo de yaml:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - < worker_pool_name>...
    ```
    {: codeblock}

    Na seção **affinity** do exemplo yaml, `workerPool` é a `key` e `<worker_pool_name>` é o `value`.

3. Aplique o arquivo de configuração de implementação atualizado.
    ```
    Kubectl apply -f com-node-affinity.yaml
    ```
    {: pre}

4. Verifique se os pods de app foram implementados nos nós do trabalhador corretos.

    1. Liste os pods em seu cluster.
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        Saída de exemplo:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Na saída, identifique um pod para seu app. Anote o endereço IP privado do **NODE** do nó do trabalhador no qual o pod está.

        Na saída de exemplo acima, o pod de app `cf-py-d7b7d94db-vp8pq` está em um nó do trabalhador com o endereço IP `10.176.48.78`.

    3. Liste os nós do trabalhador no conjunto de trabalhadores que você designou em sua implementação de app.

        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        Saída de exemplo:

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        Se você criou uma regra de afinidade de app baseada em outro fator, obtenha esse valor no lugar. Por exemplo, para verificar se o pod de app foi implementado em um nó do trabalhador em uma VLAN específica, visualize a VLAN em que o nó do trabalhador está executando `ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>`.
        {: tip}

    4. Na saída, verifique se o nó do trabalhador com o endereço IP privado que você identificou na etapa anterior está implementado nesse conjunto de trabalhadores.

<br />


## Implementando um app em uma máquina de GPU
{: #gpu_app}

Se você tem um [tipo de máquina de unidade de processamento de gráfico (GPU) bare metal](cs_clusters_planning.html#shared_dedicated_node), é possível planejar cargas de trabalho matematicamente intensivas no nó do trabalhador. Por exemplo, você pode executar um app 3D que usa a plataforma Compute Unified Device Architecture (CUDA) para compartilhar a carga de processamento da GPU e CPU para aumentar o desempenho.
{:shortdesc}

Nas etapas a seguir, você aprenderá como implementar cargas de trabalho que requerem a GPU. Também é possível [implementar apps](#app_ui) que não precisam processar suas cargas de trabalho na GPU e CPU. Depois, você pode achar útil experimentar cargas de trabalho matematicamente intensivas, como a estrutura de aprendizado de máquina [TensorFlow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.tensorflow.org/) com [esta demo do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/pachyderm/pachyderm/tree/master/doc/examples/ml/tensorflow).

Antes de iniciar:
* [Crie um tipo de máquina de GPU bare metal](cs_clusters.html#clusters_cli). Observe que esse processo pode levar mais de 1 dia útil para ser concluído.
* Seu cluster mestre e o nó do trabalhador de GPU devem executar o Kubernetes versão 1.10 ou mais recente.

Para executar uma carga de trabalho em uma máquina de GPU:
1.  Crie um arquivo YAML. Neste exemplo, um `Job` YAML gerencia cargas de trabalho em lote, fazendo um pod de curta duração que é executado até que o comando planejado para ser concluído com êxito seja finalizado.

    **Importante**: para cargas de trabalho de GPU, deve-se sempre fornecer o campo `resources: limits: nvidia.com/gpu` na especificação YAML.

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>Componentes do YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td>Metadados e nomes de rótulo</td>
    <td>Dê um nome e um rótulo para a tarefa e use o mesmo nome nos metadados do arquivo e nos metadados de `spec template`. Por exemplo, `nvidia-smi`.</td>
    </tr>
    <tr>
    <td><code>contêineres / imagem</code></td>
    <td>Forneça a imagem da qual o contêiner é uma instância em execução. Neste exemplo, o valor é configurado para usar a imagem do DockerHub CUDA:<code>nvidia/cuda:9.1-base-ubuntu16.04</code></td>
    </tr>
    <tr>
    <td><code>contêineres / comando</code></td>
    <td>Especifique um comando para ser executado no contêiner. Neste exemplo, o comando <code>[ "/usr/test/nvidia-smi" ]</code>refere-se a um binário que está na máquina de GPU; portanto, deve-se também configurar uma montagem do volume.</td>
    </tr>
    <tr>
    <td><code>contêineres / imagePullPolicy</code></td>
    <td>Para puxar uma nova imagem somente se a imagem não estiver atualmente no nó do trabalhador, especifique <code>IfNotPresent</code>.</td>
    </tr>
    <tr>
    <td><code>resources / limites</code></td>
    <td>Para máquinas de GPU, deve-se especificar o limite de recurso. O [Plug-in do dispositivo![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) do Kubernetes configura a solicitação de recurso padrão para corresponder ao limite.
    <ul><li>Deve-se especificar a chave como <code>nvidia.com/gpu</code>.</li>
    <li>Insira o número inteiro de GPUs que você solicitar, como <code>2</code>. <strong>Nota</strong>: os pods do contêiner não compartilham GPUs e as GPUs não podem estar supercomprometidas. Por exemplo, se você tem somente 1 máquina `mg1c.16x128`, então tem apenas 2 GPUs nessa máquina e pode especificar um máximo de `2`.</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>Nomeie o volume que está montado no contêiner, como <code>nvidia0</code>. Especifique o <code>mountPath</code> no contêiner para o volume. Neste exemplo, o caminho <code>/usr/test</code> corresponde ao caminho usado no comando de contêiner de tarefa.</td>
    </tr>
    <tr>
    <td><code>volumes</code></td>
    <td>Nomeie o volume de tarefa, como <code>nvidia0</code>. No <code>hostPath</code> do nó do trabalhador da GPU, especifique o <code>path</code> do volume no host, neste exemplo, <code>/usr/bin</code>. O contêiner <code>mountPath</code> é mapeado para o <code>path</code> do volume do host, que fornece esse acesso de tarefa aos binários do NVIDIA no nó do trabalhador da GPU para o comando de contêiner a ser executado.</td>
    </tr>
    </tbody></table>

2.  Aplique o arquivo YAML. Por exemplo:

    ```
    Kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  Verifique o pod de tarefa filtrando os pods pelo rótulo `nvidia-sim`. Verifique se o **STATUS** é **Concluído**.

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    Saída de exemplo:
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  Descreva o pod para ver como o plug-in do dispositivo de GPU planejou o pod.
    * Nos campos `Limits` e `Requests`, veja se o limite de recurso que você especificou corresponde à solicitação que o plug-in do dispositivo configurou automaticamente.
    * Nos eventos, verifique se o pod está designado ao seu nó do trabalhador da GPU.

    ```
    Kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    Saída de exemplo:
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  Para verificar se a tarefa usou a GPU para calcular sua carga de trabalho, é possível verificar os logs. O comando `[ "/usr/test/nvidia-smi" ]` da tarefa consultou o estado do dispositivo GPU no nó do trabalhador da GPU.

    ```
    Kubectl logs nvidia a simulação ppkd4
    ```
    {: pre}

    Saída de exemplo:
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    Neste exemplo, você vê que ambas as GPUs foram usadas para executar a tarefa porque foram planejadas no nó do trabalhador. Se o limite for configurado como 1, somente 1 GPU será mostrada.

## Ajuste de escala de apps
{: #app_scaling}

Com o Kubernetes, é possível ativar o [ajuste automático de escala de pod horizontal ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) para aumentar ou diminuir automaticamente o número de instâncias de seus apps com base na CPU.
{:shortdesc}

Procurando informações sobre ajuste de escala de aplicativos Cloud Foundry? Confira [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html). 
{: tip}

Antes de iniciar:
- [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.
- O monitoramento Heapster deve ser implementado no cluster em que você deseja ajustar a escala automaticamente.

Etapas:

1.  Implemente seu app em um cluster por meio da CLI. Ao implementar seu app, deve-se solicitar a CPU.

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>Componentes de comando para executar kubectl</caption>
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

    Para implementações mais complexas, você pode precisar criar um [arquivo de configuração](#app_cli).
    {: tip}

2.  Crie um ajustador automático de escala e defina sua política. Para obter mais informações sobre como trabalhar com o comando `kubectl autoscale`, veja [a documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <caption>Componentes de comando para kubectl autoscale</caption>
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

1.  [Apresente ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) uma mudança. Por exemplo, talvez você queira mudar a imagem usada na implementação inicial.

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

