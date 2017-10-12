---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-13"

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
{: #cs_apps}

É possível usar técnicas do Kubernetes para implementar apps e assegurar que seus aplicativos estejam funcionando em todos os momentos. Por exemplo, é possível executar atualizações e recuperações contínuas sem tempo de inatividade para seus usuários.
{:shortdesc}

Implementar um app geralmente inclui as etapas a seguir.

1.  [Instale as CLIs](cs_cli_install.html#cs_cli_install).

2.  Crie um script de configuração para seu app. [Revise as melhores práticas do Kubernetes. ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  Execute o script de configuração usando um dos métodos a seguir.
    -   [A CLI do Kubernetes](#cs_apps_cli)
    -   O painel do Kubernetes
        1.  [Inicie o painel do Kubernetes.](#cs_cli_dashboard)
        2.  [Execute o script de configuração.](#cs_apps_ui)


## Ativando o painel do Kubernetes
{: #cs_cli_dashboard}

Abra um painel do Kubernetes em seu sistema local para visualizar informações sobre um cluster e seus nós do trabalhador.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster. Essa tarefa requer a [política de acesso de Administrador](cs_cluster.html#access_ov). Verifique sua [política de acesso atual](cs_cluster.html#view_access).

É possível usar a porta padrão ou configurar sua própria porta para ativar o painel do Kubernetes para um cluster.
-   Ative seu painel do Kubernetes com a porta padrão 8001.
    1.  Configure o proxy com o número da porta padrão.

        ```
        kubectl proxy
        ```
        {: pre}

        Sua saída da CLI é semelhante à seguinte:

        ```
        Iniciando a entrega em 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra a URL a seguir em um navegador da web para ver o painel do Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   Ative seu painel do Kubernetes com sua própria porta.
    1.  Configure o proxy com seu próprio número de porta.

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  Abra a URL a seguir em um navegador.

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


Quando estiver pronto com o painel do Kubernetes, use `CTRL+C` para sair do comando `proxy`.

## Permitindo o acesso público a apps
{: #cs_apps_public}

Para disponibilizar um app publicamente, deve-se atualizar seu script de configuração antes de implementar o app em um cluster.
{:shortdesc}

Dependendo de você ter criado um cluster lite ou padrão, existem maneiras diferentes de tornar seu app acessível na Internet.

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">Serviço do tipo NodePort</a> (clusters lite e padrão)</dt>
<dd>Exponha uma porta pública em cada nó do trabalhador e use o endereço IP público de qualquer nó do trabalhador para acessar publicamente seu serviço no cluster. O endereço IP público do nó do trabalhador não é permanente. Quando um nó do trabalhador é removido ou recriado, um novo endereço IP público é designado ao nó do trabalhador. É possível usar o serviço do tipo NodePort para testar o acesso público para seu app ou quando o acesso público é necessário por somente um curto tempo. Quando um endereço IP público estável e mais disponibilidade para seu terminal em serviço forem requeridos, exponha seu app usando um serviço do tipo LoadBalancer ou Ingresso.</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">Serviço do tipo LoadBalancer</a> (somente clusters padrão)</dt>
<dd>Cada cluster padrão é provisionado com 4 endereços IP públicos móveis que podem ser usados para criar um balanceador de carga TCP/UDP externo para seu app. É possível customizar seu balanceador de carga expondo qualquer porta que seu app requer. O endereço IP público móvel que é designado para o balanceador de carga é permanente e não muda quando um nó do trabalhador é recriado no cluster.

</br>
Se você precisar de balanceamento de carga de HTTP ou HTTPS para o seu app e desejar usar uma rota pública para expor múltiplos apps em seu cluster como serviços, use o suporte do Ingresso integrado com o {{site.data.keyword.containershort_notm}}.</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingresso</a> (somente clusters padrão)</dt>
<dd>Exponha múltiplos apps no cluster criando um balanceador de carga HTTP ou HTTPS externo que use um ponto de entrada público assegurado e exclusivo para rotear solicitações recebidas para seus apps. O ingresso consiste em dois componentes principais, o recurso de Ingresso e o controlador de Ingresso. O recurso de Ingresso define as regras de como rotear e balancear a carga de solicitações recebidas para um app. Todos os recursos de Ingresso devem ser registrados com o controlador de Ingresso que atende a solicitações de serviço HTTP ou HTTPS recebidas e encaminha solicitações com base nas regras definidas para cada recurso de Ingresso. Use Ingresso se desejar implementar seu próprio balanceador de carga com regras de roteamento customizadas e se precisar de finalização SSL para seus apps.

</dd></dl>

### Configurando o acesso público para um app usando o tipo de serviço NodePort
{: #cs_apps_public_nodeport}

Torne seu app publicamente disponível usando o endereço IP público de qualquer nó do trabalhador em um cluster e expondo uma porta do nó. Use essa opção para teste e acesso público de curto prazo.
{:shortdesc}

É possível expor seu app como um serviço do Kubernetes do tipo NodePort para clusters lite ou padrão.

Para ambientes do {{site.data.keyword.Bluemix_notm}} Dedicated, endereços IP públicos são bloqueadas por um firewall. Para disponibilizar um app publicamente, use um [serviço do tipo LoadBalancer](#cs_apps_public_load_balancer) ou o [Ingresso](#cs_apps_public_ingress), como alternativa.

**Nota:** o endereço IP público de um nó do trabalhador não é permanente. Se o nó do trabalhador precisar ser recriado, um novo endereço IP público será designado ao nó do trabalhador. Se você precisar de um endereço IP público estável e de mais disponibilidade para seu serviço, exponha seu app usando um [serviço do tipo LoadBalancer](#cs_apps_public_load_balancer) ou o [Ingresso](#cs_apps_public_ingress).




1.  Defina uma seção de [serviço ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/) no script de configuração.
2.  Na seção `spec` do serviço, inclua o tipo NodePort.

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  Opcional: na seção `ports`, inclua um NodePort no intervalo de 30.000 a 32.767. Não especifique um NodePort que já esteja em uso por outro serviço. Se estiver inseguro sobre quais NodePorts já estão em uso, não designe um. Se nenhum NodePort for designado, um aleatório será designado para você.

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    Se você desejar especificar um NodePort e desejar ver quais NodePorts já estão em uso, será possível executar o comando a seguir.

    ```
    kubectl get svc
    ```
    {: pre}

    Saída:

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  Salve as alterações.
5.  Repita para criar um serviço para cada app.

    Exemplo:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**E agora?**

Quando o app for implementado, será possível usar o endereço IP público de qualquer nó do trabalhador e o NodePort para formar a URL pública para acessar o app em um navegador.

1.  Obtenha o endereço IP público para um nó do trabalhador no cluster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Saída:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
    ```
    {: screen}

2.  Se um NodePort aleatório foi designado, descubra qual foi designado.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Saída:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    Neste exemplo, o NodePort é `30872`.

3.  Forme a URL com um dos endereços IP públicos do nó do trabalhador e o NodePort. Exemplo: `http://192.0.2.23:30872`

### Configurando o acesso público a um app usando o tipo de serviço do balanceador de carga
{: #cs_apps_public_load_balancer}

Exponha uma porta e use um endereço IP público móvel para o balanceador de carga para acessar o app. Diferentemente do serviço do NodePort, o endereço IP público móvel do serviço de balanceador de carga não é dependente do nó do trabalhador no qual o app é implementado. O endereço IP público móvel do balanceador de carga é designado para você e não muda quando você inclui ou remove nós do trabalhador, o que significa que os serviços do balanceador de carga são mais altamente disponíveis do que os serviços do NodePort. Os usuários podem selecionar qualquer porta para o balanceador de carga e não são limitados ao intervalo de portas NodePort. É possível usar serviços de balanceador de carga para os protocolos TCP e UDP.

Quando uma conta do {{site.data.keyword.Bluemix_notm}} Dedicated é [ativada para clusters](cs_ov.html#setup_dedicated), é possível solicitar que sub-redes públicas sejam usadas para endereços IP do balanceador de carga. [Abra um chamado de suporte](/docs/support/index.html#contacting-support) para criar a sub-rede e, em seguida, use o comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para incluir a sub-rede no cluster.

**Nota:** os serviços do balanceador de carga não suportam finalização do TLS. Se o seu app requerer finalização do TLS, será possível expor o seu app por meio do [Ingresso](#cs_apps_public_ingress) ou configurar o seu app para gerenciar a finalização do TLS.

Antes de iniciar:

-   Este recurso está disponível somente para clusters padrão.
-   Deve-se ter um endereço IP público móvel disponível para designar ao serviço de balanceador de carga.

Para criar um serviço de balanceador de carga:

1.  [Implemente o seu app no cluster](#cs_apps_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu script de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga.
2.  Crie um serviço de balanceador de carga para o app que você deseja expor. Para disponibilizar o seu app na Internet pública, deve-se criar um serviço do Kubernetes para o seu app e configurar o seu serviço para incluir todos os pods que compõem o seu app no balanceamento de carga.
    1.  Abra o seu editor preferencial e crie um script de configuração de serviço com o nome, por exemplo, de `myloadbalancer.yaml`.
    2.  Defina um serviço de balanceador de carga para o app que você deseja expor para o público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para o seu serviço de balanceador de carga.</td>
        </tr>
        <tr>
        <td><code>seletor</code></td>
        <td>Insira o par de chave de etiqueta (<em>&lt;selectorkey&gt;</em>) e valor (<em>&lt;selectorvalue&gt;</em>) que você deseja usar para destinar os pods nos quais seu app é executado. Por exemplo, se você usar o seletor <code>app: code</code> a seguir, todos os pods que tiverem esse rótulo em seus metadados serão incluídos no balanceamento de carga. Insira o mesmo rótulo que você usou quando implementou o seu app no cluster. </td>
         </tr>
         <td><code>port</code></td>
         <td>A porta na qual o serviço atende.</td>
         </tbody></table>
    3.  Opcional: se você desejar usar um endereço IP público móvel específico para o balanceador de carga que esteja disponível para seu cluster, será possível especificar esse endereço IP incluindo o `loadBalancerIP` na seção de especificação. Para obter mais informações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/).
    4.  Opcional: é possível optar por configurar um firewall especificando o `loadBalancerSourceRanges` na seção de especificação. Para obter mais informações, veja a [documentação do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).
    5.  Salve as suas mudanças.
    6.  Crie o serviço em seu cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando o seu balanceador de carga for criado, um endereço IP público móvel será designado automaticamente para o balanceador de carga. Se nenhum endereço IP público móvel estiver disponível, a criação do serviço de balanceador de carga falhará.
3.  Verifique se o serviço de balanceador de carga foi criado com êxito. Substitua _&lt;myservice&gt;_ pelo nome do serviço de balanceador de carga que você criou na etapa anterior.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Nota:** pode levar alguns minutos para que o serviço de balanceador de carga seja criado corretamente e para que o app fique disponível na Internet pública.

    A saída da CLI é semelhante à seguinte:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    O endereço IP do **Ingresso de LoadBalancer** é o endereço IP público móvel que foi designado para o seu serviço de balanceador de carga.
4.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira o endereço IP público móvel do balanceador de carga e a porta. No exemplo acima, o endereço IP público móvel `192.168.10.38` foi designado ao serviço de balanceador de carga.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### Configurando o acesso público a um app usando o controlador de Ingresso
{: #cs_apps_public_ingress}

Exponha múltiplos apps em seu cluster criando recursos de Ingresso que são gerenciados pelo controlador de Ingresso fornecido pela IBM. O controlador de Ingresso é um balanceador de carga HTTP ou HTTPS externo que usa um ponto de entrada público assegurado e exclusivo para rotear solicitações recebidas para seus apps dentro ou fora do cluster.

**Nota:** o Ingresso está disponível apenas para clusters padrão e requer pelo menos dois nós do trabalhador no cluster para assegurar alta disponibilidade.

Quando você criar um cluster padrão, um controlador do Ingresso será criado automaticamente e designado com um endereço IP público móvel e uma rota pública. É possível configurar o controlador de Ingresso e definir regras de roteamento individuais para cada app que você expõe ao público. Cada app exposto por meio de Ingresso é designado um caminho exclusivo anexado à rota pública, para que seja possível usar uma URL exclusiva para acessar um app publicamente em seu cluster.

Quando uma conta do {{site.data.keyword.Bluemix_notm}} Dedicated é [ativada para clusters](cs_ov.html#setup_dedicated), é possível solicitar que sub-redes públicas sejam usadas para endereços IP do controlador de Ingresso. Em seguida, o controlador de Ingresso é criado e uma rota pública é designada. [Abra um chamado de suporte](/docs/support/index.html#contacting-support) para criar a sub-rede e, em seguida, use o comando [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para incluir a sub-rede no cluster.

É possível configurar o controlador de Ingresso para os cenários a seguir.

-   [Usar o domínio fornecido pela IBM sem finalização TLS](#ibm_domain)
-   [Usar o domínio fornecido pela IBM com finalização TLS](#ibm_domain_cert)
-   [Usar um domínio customizado e certificado TLS para executar a finalização TLS](#custom_domain_cert)
-   [Usar o domínio fornecido pela IBM ou um customizado com finalização TLS para acessar apps fora de seu cluster](#external_endpoint)
-   [Customizar seu controlador do Ingresso com anotações](#ingress_annotation)

#### Usando o domínio fornecido pela IBM sem finalização TLS
{: #ibm_domain}

É possível configurar o controlador Ingresso como um balanceador de carga de HTTP para os apps em seu cluster e usar o domínio fornecido pela IBM para acessar seus apps na Internet.

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_cluster.html#cs_cluster_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para configurar o controlador de Ingresso:

1.  [Implemente o seu app no cluster](#cs_apps_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu script de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.
2.  Crie um serviço do Kubernetes para o app a ser exposto. O controlador do Ingresso poderá incluir o seu app no balanceamento de carga do Ingresso somente se o seu app for exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de serviço que seja nomeado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço para o app que você deseja expor para o público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para o seu serviço de balanceador de carga.</td>
        </tr>
        <tr>
        <td><code>seletor</code></td>
        <td>Insira o par de chave de etiqueta (<em>&lt;selectorkey&gt;</em>) e valor (<em>&lt;selectorvalue&gt;</em>) que você deseja usar para destinar os pods nos quais seu app é executado. Por exemplo, se você usar o seletor <code>app: code</code> a seguir, todos os pods que tiverem esse rótulo em seus metadados serão incluídos no balanceamento de carga. Insira o mesmo rótulo que você usou quando implementou o seu app no cluster. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>A porta na qual o serviço atende.</td>
         </tr>
         </tbody></table>
    3.  Salve as suas mudanças.
    4.  Crie o serviço em seu cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  Repita essas etapas para cada app que você desejar expor para o público.
3.  Obtenha os detalhes de seu cluster para visualizar o domínio fornecido pela IBM. Substitua _&lt;mycluster&gt;_ pelo nome do cluster no qual o app está implementado que você deseja expor para o público.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    Sua saída de CLI é semelhante à seguinte.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    É possível ver o domínio fornecido pela IBM no campo **Subdomínio do Ingresso**.
4.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes que você criou para o seu app e são usados pelo controlador do Ingresso para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de Ingresso que seja nomeado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu script de configuração que use o domínio fornecido pela IBM para rotear o tráfego de rede recebido para o serviço que você criou anteriormente.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>Subdomínio do Ingresso</strong> fornecido pela IBM na etapa anterior.

        </br></br>
        <strong>Nota:</strong> não use * para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br></br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.
        </br>
        Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        </br>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a <a href="#rewrite" target="_blank">anotação de nova gravação</a> para estabelecer o roteamento adequado para seu app.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> pelo nome do serviço que você usou quando criou o serviço do Kubernetes para seu app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
        </tr>
        </tbody></table>

    3.  Crie o recurso de Ingresso para seu cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua _&lt;myingressname&gt;_ pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **Nota:** pode levar alguns minutos para que o recurso de Ingresso seja criado e para que o app fique disponível na Internet pública.
6.  Em um navegador da web, insira a URL do serviço de app a ser acessado.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### Usando o domínio fornecido pela IBM com finalização TLS
{: #ibm_domain_cert}

É possível configurar o controlador de Ingresso para gerenciar conexões TLS recebidas para seus apps, decriptografar o tráfego de rede usando o certificado TLS fornecido pela IBM e encaminhar a solicitação não criptografada para os apps expostos em seu cluster.

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_cluster.html#cs_cluster_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para configurar o controlador de Ingresso:

1.  [Implemente o seu app no cluster](#cs_apps_cli). Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu script de configuração. Esse rótulo identifica todos os pods nos quais o app está em execução, para que sejam incluídos no balanceamento de carga do Ingresso.
2.  Crie um serviço do Kubernetes para o app a ser exposto. O controlador do Ingresso poderá incluir o seu app no balanceamento de carga do Ingresso somente se o seu app for exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de serviço que seja nomeado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço para o app que você deseja expor para o público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para o seu serviço do Kubernetes.</td>
        </tr>
        <tr>
        <td><code>seletor</code></td>
        <td>Insira o par de chave de etiqueta (<em>&lt;selectorkey&gt;</em>) e valor (<em>&lt;selectorvalue&gt;</em>) que você deseja usar para destinar os pods nos quais seu app é executado. Por exemplo, se você usar o seletor <code>app: code</code> a seguir, todos os pods que tiverem esse rótulo em seus metadados serão incluídos no balanceamento de carga. Insira o mesmo rótulo que você usou quando implementou o seu app no cluster. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>A porta na qual o serviço atende.</td>
         </tr>
         </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o serviço em seu cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita essas etapas para cada app que você desejar expor para o público.

3.  Visualize o domínio fornecido pela IBM e o certificado TLS. Substitua _&lt;mycluster&gt;_ pelo nome do cluster no qual o app está implementado.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    Sua saída de CLI é semelhante à seguinte.

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    É possível ver o domínio fornecido pela IBM no **Subdomínio do Ingresso** e o certificado fornecido pela IBM no campo **Segredo do Ingresso**.

4.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes que você criou para o seu app e são usados pelo controlador do Ingresso para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de Ingresso que seja nomeado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso de Ingresso em seu script de configuração que use o domínio fornecido pela IBM para rotear o tráfego de rede recebido para seus serviços e o certificado fornecido pela IBM para gerenciar a finalização TLS para você. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, `https://ingress_domain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia o tráfego de rede para o serviço e, além disso, para os pods nos quais o app está em execução.

        **Nota:** seu app deve atender no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>Subdomínio do Ingresso</strong> fornecido pela IBM na etapa anterior. Esse domínio é configurado para finalização TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Substitua <em>&lt;ibmtlssecret&gt;</em> pelo nome do <strong>Segredo do ingresso</strong> fornecido pela IBM da etapa anterior. Esse certificado gerencia a finalização do TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>Subdomínio do Ingresso</strong> fornecido pela IBM na etapa anterior. Esse domínio é configurado para finalização TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br>
        Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a <a href="#rewrite" target="_blank">anotação de nova gravação</a> para estabelecer o roteamento adequado para seu app.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> pelo nome do serviço que você usou quando criou o serviço do Kubernetes para seu app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
        </tr>
        </tbody></table>

    3.  Crie o recurso de Ingresso para seu cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua _&lt;myingressname&gt;_ pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** pode levar alguns minutos para que o recurso de Ingresso seja criado corretamente e para que o app fique disponível na Internet pública.
6.  Em um navegador da web, insira a URL do serviço de app a ser acessado.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### Usando o controlador de Ingresso com um domínio customizado e certificado TLS
{: #custom_domain_cert}

É possível configurar o controlador de Ingresso para rotear o tráfego de rede recebido para os apps no cluster e usar seu próprio certificado TLS para gerenciar a finalização do TLS, enquanto usa seu domínio customizado em vez do domínio fornecido pela IBM.
{:shortdesc}

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_cluster.html#cs_cluster_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para configurar o controlador de Ingresso:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) para registrar seu domínio customizado.
2.  Configure seu domínio para rotear o tráfego de rede recebido para o controlador de Ingresso IBM. Escolha entre estas opções:
    -   Defina um alias para seu domínio customizado especificando o domínio fornecido pela IBM como um registro de Nome Canônico (CNAME). Para localizar o domínio de Ingresso fornecido pela IBM, execute `bx cs cluster-get <mycluster>` e procure o campo **Subdomínio do Ingresso**.
    -   Mapeie o seu domínio customizado para o endereço IP público móvel do controlador do Ingresso fornecido pela IBM incluindo o endereço IP como um Registro de ponteiro (PTR). Para localizar o endereço IP público móvel do controlador do Ingresso:
        1.  Execute `bx cs cluster-get <mycluster>` e procure o campo **Subdomínio do Ingresso**.
        2.  Execute `nslookup <Ingress subdomain>`.
3.  Crie um certificado e chave TLS para seu domínio que sejam codificados no formato base64.
4.  Armazene o certificado e chave TLS em um segredo do Kubernetes.
    1.  Abra seu editor preferencial e crie um script de configuração de segredo do Kubernetes que seja nomeado, por exemplo, `mysecret.yaml`.
    2.  Defina um segredo que use seu certificado e chave do TLS.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;mytlssecret&gt;</em> por um nome para seu segredo do Kubernetes.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Substitua <em>&lt;tlscert&gt;</em> por seu certificado TLS customizado que está codificado no formato base64.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Substitua <em>&lt;tlskey&gt;</em> por sua chave TLS customizada que está codificada no formato base64.</td>
         </tbody></table>

    3.  Salve seu script de configuração.
    4.  Crie o segredo do TLS para seu cluster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Implemente o seu app no cluster](#cs_apps_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Assegure-se de incluir um rótulo em sua implementação na seção de metadados de seu script de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.

6.  Crie um serviço do Kubernetes para o app a ser exposto. O controlador do Ingresso poderá incluir o seu app no balanceamento de carga do Ingresso somente se o seu app for exposto por meio de um serviço do Kubernetes dentro do cluster.

    1.  Abra seu editor preferencial e crie um script de configuração de serviço que seja nomeado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço para o app que você deseja expor para o público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para seu serviço do Kubernetes.</td>
        </tr>
        <tr>
        <td><code>seletor</code></td>
        <td>Insira o par de chave de etiqueta (<em>&lt;selectorkey&gt;</em>) e valor (<em>&lt;selectorvalue&gt;</em>) que você deseja usar para destinar os pods nos quais seu app é executado. Por exemplo, se você usar o seletor <code>app: code</code> a seguir, todos os pods que tiverem esse rótulo em seus metadados serão incluídos no balanceamento de carga. Insira o mesmo rótulo que você usou quando implementou o seu app no cluster. </td>
         </tr>
         <td><code>port</code></td>
         <td>A porta na qual o serviço atende.</td>
         </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o serviço em seu cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita essas etapas para cada app que você desejar expor para o público.
7.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes que você criou para o seu app e são usados pelo controlador do Ingresso para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de Ingresso que seja nomeado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso de Ingresso em seu script de configuração que use o domínio customizado para rotear o tráfego de rede recebido para seus serviços e o certificado customizado para gerenciar a finalização TLS. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, `https://mydomain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia o tráfego de rede para o serviço e, além disso, para os pods nos quais o app está em execução.

        **Nota:** é importante que o app atenda no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado que você deseja configurar para finalização do TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Substitua <em>&lt;mytlssecret&gt;</em> pelo nome do segredo que você criou anteriormente e que retém o seu certificado e chave TLS customizados para gerenciar a finalização TLS para seu domínio customizado.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado que você deseja configurar para finalização do TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a <a href="#rewrite" target="_blank">anotação de nova gravação</a> para estabelecer o roteamento adequado para seu app.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> pelo nome do serviço que você usou quando criou o serviço do Kubernetes para seu app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>A porta na qual o serviço atende. Use a mesma porta que você definiu quando criou o serviço do Kubernetes para seu app.</td>
        </tr>
        </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o recurso de Ingresso para seu cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua _&lt;myingressname&gt;_ pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** pode levar alguns minutos para que o recurso de Ingresso seja criado corretamente e para que o app fique disponível na Internet pública.

9.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### Configurando o controlador de Ingresso para rotear o tráfego de rede para apps fora do cluster
{: #external_endpoint}

É possível configurar o controlador de Ingresso para apps que estão localizados fora do cluster para ser incluído no balanceamento de carga do cluster. As solicitações recebidas no domínio customizado ou fornecido pela IBM são encaminhadas automaticamente para o app externo.

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_cluster.html#cs_cluster_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.
-   Assegure-se de que o app externo que você deseja incluir no balanceamento de carga do cluster possa ser acessado usando um endereço IP público.

É possível configurar o controlador de Ingresso para rotear o tráfego de rede recebido no domínio fornecido pela IBM para apps localizados fora do cluster. Se desejar usar um domínio customizado e um certificado TLS como alternativa, substitua o domínio fornecido pela IBM e o certificado TLS pelo seu [domínio customizado e certificado TLS](#custom_domain_cert).

1.  Configure um terminal do Kubernetes que defina o local externo do app que você deseja incluir no balanceamento de carga do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de terminal com o nome, por exemplo, de `myexternalendpoint.yaml`.
    2.  Defina seu terminal externo. Inclua todos os endereços IP públicos e portas que podem ser usados para acessar seu app externo.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myendpointname&gt;</em> pelo nome de seu terminal do Kubernetes.</td>
        </tr>
        <tr>
        <td><code>IP</code></td>
        <td>Substitua <em>&lt;externalIP&gt;</em> pelos endereços IP públicos para se conectar ao app externo.</td>
         </tr>
         <td><code>port</code></td>
         <td>Substitua <em>&lt;externalport&gt;</em> pela porta na qual seu app externo atende.</td>
         </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o terminal do Kubernetes para seu cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  Crie um serviço do Kubernetes para seu cluster e configure-o para encaminhar solicitações recebidas para o terminal externo que você criou anteriormente.
    1.  Abra seu editor preferencial e crie um script de configuração de serviço com o nome, por exemplo, de `myexternalservice.yaml`.
    2.  Defina o serviço.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Substitua <em>&lt;myexternalservice&gt;</em> pelo nome de seu serviço do Kubernetes.</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>Substitua <em>&lt;myendpointname&gt;</em> pelo nome do terminal do Kubernetes que você criou anteriormente.</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>A porta na qual o serviço atende.</td>
        </tr></tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o serviço do Kubernetes para seu cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

3.  Visualize o domínio fornecido pela IBM e o certificado TLS. Substitua _&lt;mycluster&gt;_ pelo nome do cluster no qual o app está implementado.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    Sua saída de CLI é semelhante à seguinte.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    É possível ver o domínio fornecido pela IBM no **Subdomínio do Ingresso** e o certificado fornecido pela IBM no campo **Segredo do Ingresso**.

4.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes que você criou para o seu app e são usados pelo controlador do Ingresso para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps externos desde que cada app seja exposto com o seu terminal externo por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um script de configuração de Ingresso com o nome, por exemplo, de `myexternalingress.yaml`.
    2.  Defina um recurso de Ingresso em seu script de configuração que use o domínio fornecido pela IBM e certificado TLS para rotear o tráfego de rede recebido para seu app externo usando o terminal externo que você definiu anteriormente. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio customizado ou fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, `https://ingress_domain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia o tráfego de rede para o serviço e, além disso, para o app externo.

        **Nota:** é importante que o app atenda no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como / e não especifique um caminho individual para seu app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myingressname&gt;</em> pelo nome do recurso de Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>Subdomínio do Ingresso</strong> fornecido pela IBM na etapa anterior. Esse domínio é configurado para finalização TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Substitua <em>&lt;ibmtlssecret&gt;</em> pelo <strong>segredo do Ingresso</strong> fornecido pela IBM na etapa anterior. Esse certificado gerencia a finalização do TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Substitua <em>&lt;ibmdomain&gt;</em> pelo nome do <strong>Subdomínio do Ingresso</strong> fornecido pela IBM na etapa anterior. Esse domínio é configurado para finalização TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myexternalservicepath&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app externo está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, <code>https://ibmdomain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o controlador de Ingresso. O controlador de Ingresso consulta o serviço associado e envia tráfego de rede para o app externo usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br></br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a <a href="#rewrite" target="_blank">anotação de nova gravação</a> para estabelecer o roteamento adequado para seu app.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Substitua <em>&lt;myexternalservice&gt;</em> pelo nome do serviço que você usou quando criou o serviço do Kubernetes para seu app externo.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>A porta na qual o serviço atende.</td>
        </tr>
        </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o recurso de Ingresso para seu cluster.

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua _&lt;myingressname&gt;_ pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** pode levar alguns minutos para que o recurso de Ingresso seja criado corretamente e para que o app fique disponível na Internet pública.

6.  Acesse seu app externo.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL para acessar seu app externo.

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}


#### Anotações do Ingresso suportadas
{: #ingress_annotation}

É possível especificar metadados para o seu recurso do Ingresso para incluir recursos em seu controlador do Ingresso.
{: shortdesc}

|Anotação suportada|Descrição|
|--------------------|-----------|
|[Grava novamente](#rewrite)|Rotear tráfego de rede recebido para um caminho diferente no qual seu app backend atenda.|
|[Afinidade de sessão com cookies](#sticky_cookie)|Sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados usando um cookie permanente.|
|[Solicitação do cliente ou cabeçalho de resposta adicional](#add_header)|Incluir informações extras do cabeçalho em uma solicitação do cliente antes de encaminhar a solicitação para seu app backend ou para uma resposta do cliente antes de enviar a resposta para o cliente.|
|[Remoção do cabeçalho de resposta do cliente](#remove_response_headers)|Remover informações do cabeçalho de uma resposta do cliente antes de encaminhar a resposta para o cliente.|
|[HTTP redireciona para HTTPs](#redirect_http_to_https)|Redirecionar solicitações de HTTP não seguras em seu domínio para HTTPs.|
|[Armazenamento em buffer de dados de resposta do cliente](#response_buffer)|Desativar o armazenamento em buffer de uma resposta do cliente no controlador de Ingresso ao enviar a resposta para o cliente.|
|[Tempos limite de conexão e tempos limite de leitura customizados](#timeout)|Ajustar o tempo que o controlador de Ingresso aguarda para conectar e ler do app backend antes de o app backend ser considerado não disponível.|
|[Tamanho máximo do corpo de solicitação do cliente customizado](#client_max_body_size)|Ajustar o tamanho do corpo de solicitação do cliente que tem permissão para ser enviado para o controlador de Ingresso.|

##### **Rotear tráfego de rede recebido para um caminho diferente usando a anotação de nova gravação**
{: #rewrite}

Use a anotação de regravação para rotear o tráfego de rede recebido em um caminho de domínio do controlador de Ingresso para um caminho diferente no qual seu aplicativo backend atenda.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O seu domínio de controlador do Ingresso roteia o tráfego de rede recebido em <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> para o seu app. O seu app atende em <code>/coffee</code>, em vez de <code>/beans</code>. Para encaminhar o tráfego de rede recebido para o seu app, inclua a anotação de nova gravação em seu arquivo de configuração de recurso do Ingresso, para que o tráfego de rede recebido em <code>/beans</code> seja encaminhado para o seu app usando o caminho <code>/coffee</code>. Ao incluir múltiplos serviços, use apenas um ponto e vírgula (;) para separá-los.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;rewrite_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;rewrite_path2&gt;"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app e <em>&lt;rewrite-path&gt;</em> pelo caminho no qual o seu app atende. O tráfego de rede recebido no domínio do controlador do Ingresso é encaminhado para o serviço do Kubernetes usando este caminho. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Neste caso, defina <code>/</code> como o <em>&lt;rewrite-path&gt;</em> para o seu app.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Substitua <em>&lt;domain_path&gt;</em> pelo caminho que você deseja anexar em seu domínio de controlador do Ingresso. O tráfego de rede recebido nesse caminho é encaminhado para o caminho de regravação que você definiu em sua anotação. No exemplo acima, configure o caminho de domínio como <code>/beans</code> para incluir esse caminho no balanceamento de carga de seu controlador do Ingresso.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Substitua <em>&lt;service_name&gt;</em> pelo nome do serviço do Kubernetes que você criou para o seu app. O nome do serviço que você usa aqui deve ser o mesmo nome que você definiu em sua anotação.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Substitua <em>&lt;service_port&gt;</em> pela porta na qual o seu serviço atende.</td>
</tr></tbody></table>

</dd></dl>


##### **Sempre rotear o tráfego de rede recebido para o mesmo servidor de envio de dados usando um cookie permanente**
{: #sticky_cookie}

Use a anotação de cookie permanente para incluir a afinidade de sessão no seu controlador de Ingresso.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>A configuração de seu app pode requerer a implementação de múltiplos servidores de envio de dados que manipulam solicitações de cliente recebidas e que asseguram maior disponibilidade. Quando um cliente se conecta ao app backend, pode ser útil que ele seja servido pelo mesmo servidor de envio de dados pela duração de uma sessão ou pelo tempo que leva para concluir uma tarefa. É possível configurar o controlador de Ingresso para assegurar a afinidade de sessão sempre roteando o tráfego de rede recebido para o mesmo servidor de envio de dados.

</br>
Cada cliente que se conecta ao app backend é designado a um dos servidores de envio de dados disponíveis pelo controlador de Ingresso. O controlador de Ingresso cria um cookie de sessão que é armazenado no app do cliente e que está incluído nas informações do cabeçalho de cada solicitação entre o controlador de Ingresso e o cliente. As informações no cookie asseguram que todas as solicitações sejam manipuladas pelo mesmo servidor de envio de dados em toda a sessão.

</br></br>
Ao incluir múltiplos serviços, use um ponto e vírgula (;) para separá-los.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>Tabela 12. Entendendo os componentes de arquivo YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul><li><code><em>&lt;service_name&gt;</em></code>: o nome do serviço do Kubernetes criado para o seu app.</li><li><code><em>&lt;cookie_name&gt;</em></code>: escolha um nome do cookie permanente que é criado durante uma sessão.</li><li><code><em>&lt;expiration_time&gt;</em></code>: o tempo em segundos, minutos ou horas antes da expiração do cookie permanente. Esse tempo é independente da atividade do usuário. Depois que o cookie expira, ele é excluído pelo navegador da web do cliente e não é mais enviado para o controlador de Ingresso. Por exemplo, para configurar um prazo de expiração de 1 segundo, 1 minuto ou 1 hora, insira <strong>1s</strong>, <strong>1m</strong> ou <strong>1h</strong>.</li><li><code><em>&lt;cookie_path&gt;</em></code>: o caminho que é anexado ao subdomínio do Ingresso e que indica para quais domínios e subdomínios o cookie é enviado para o controlador de Ingresso. Por exemplo, se o seu domínio do Ingresso for <code>www.myingress.com</code> e você desejar enviar o cookie em cada solicitação do cliente, deverá configurar <code>path=/</code>. Se desejar enviar o cookie somente para <code>www.myingress.com/myapp</code> e todos os seus subdomínios, então deverá configurar <code>path=/myapp</code>.</li><li><code><em>&lt;hash_algorithm&gt;</em></code>: o algoritmo hash que protege as informações no cookie. Somente <code>sha1
</code> é suportado. SHA1 cria uma soma de hash com base nas informações no cookie e anexa essa soma de hash ao cookie. O servidor pode decriptografar as informações no cookie e verificar a integridade de dados.</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **Incluindo cabeçalhos de HTTP customizados em uma solicitação ou uma resposta do cliente**
{: #add_header}

Use essa anotação para incluir informações de cabeçalho extras em uma solicitação do cliente antes de enviar a solicitação para o app backend ou para uma resposta do cliente antes de enviar a resposta para o cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O controlador de Ingresso age como um proxy entre o app cliente e o app backend. As solicitações do cliente enviadas para o controlador de Ingresso são processadas (por proxy) e colocadas em uma nova solicitação que é então enviada do controlador de Ingresso para o app backend. Transmitir uma solicitação por proxy remove as informações do cabeçalho de HTTP, como o nome do usuário, que foi inicialmente enviado do cliente. Se o seu app backend requerer essas informações, será possível usar a anotação <strong>ingress.bluemix.net/proxy-add-headers</strong> para incluir informações do cabeçalho na solicitação do cliente antes de a solicitação ser encaminhada do controlador de Ingresso para seu app backend.

</br></br>
Quando um app backend envia uma resposta para o cliente, a resposta é transmitida por proxy pelo controlador de Ingresso e os cabeçalhos de HTTP são removidos da resposta. O app da web do cliente pode requerer essas informações de cabeçalho para processar com êxito a resposta. É possível usar a anotação <strong>ingress.bluemix.net/response-add-headers</strong> para incluir informações do cabeçalho na resposta do cliente antes de a resposta ser encaminhada do controlador de Ingresso para o app da web do cliente.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul><li><code><em>&lt;service_name&gt;</em></code>: o nome do serviço do Kubernetes criado para o seu app.</li><li><code><em>&lt;header&gt;</em></code>: a chave das informações do cabeçalho a serem incluídas na solicitação ou na resposta do cliente.</li><li><code><em>&lt;value&gt;</em></code>: o valor das informações do cabeçalho a serem incluídas na solicitação ou na resposta do cliente.</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **Removendo informações do cabeçalho de HTTP de uma resposta do cliente**
{: #remove_response_headers}

Use essa anotação para remover informações do cabeçalho incluídas na resposta do cliente do app de término de backend antes de a resposta ser enviada para o cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O controlador de Ingresso age como um proxy entre seu app backend e o navegador da web do cliente. As respostas do cliente do app backend enviadas para o controlador de Ingresso são processadas (por proxy) e colocadas em uma nova resposta que é então enviada do controlador de Ingresso para o navegador da web do cliente. Embora a transmissão de uma resposta por proxy remova as informações do cabeçalho de HTTP inicialmente enviadas do app backend, esse processo pode não remover todos os cabeçalhos específicos do app backend. Use essa anotação para remover as informações do cabeçalho de uma resposta do cliente antes de a resposta ser encaminhada do controlador de Ingresso para o navegador da web do cliente.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;service_name2&gt; {
      "&lt;header3&gt;";
      }
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul><li><code><em>&lt;service_name&gt;</em></code>: o nome do serviço do Kubernetes criado para o seu app.</li><li><code><em>&lt;header&gt;</em></code>: a chave do cabeçalho a ser removida da resposta do cliente.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **Redirecionando solicitações inseguras do cliente HTTP para HTTPS**
{: #redirect_http_to_https}

Use a anotação de redirecionamento para converter solicitações inseguras de clientes HTTP em HTTPs.{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Configure seu controlador do Ingresso para proteger seu domínio com o certificado TLS fornecido pela IBM ou seu certificado TLS customizado. Alguns usuários podem tentar acessar seus apps usando uma solicitação de HTTP insegura para seu domínio do controlador de Ingresso, por exemplo, <code>http://www.myingress.com</code>, em vez de usar <code>https</code>. É possível usar a anotação de redirecionamento para sempre converter solicitações de HTTP inseguras em HTTPs. Se você não usar essa anotação, as solicitações de HTTP inseguras não serão convertidas em solicitações de HTTP por padrão e poderão expor informações confidenciais ao público sem criptografia.

</br></br>
O redirecionamento de solicitações de HTTP para HTTPs é desativado por padrão.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **Desativando o armazenamento em buffer de respostas de backend em seu controlador do Ingresso**
{: #response_buffer}

Use a anotação de buffer para desativar o armazenamento de dados de resposta no controlador de Ingresso enquanto os dados são enviados para o cliente.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>O controlador de Ingresso age como um proxy entre seu app backend e o navegador da web do cliente. Quando uma resposta é enviada do app backend para o cliente, os dados de resposta são armazenados em buffer no controlador de Ingresso por padrão. O controlador de Ingresso transmite por proxy a resposta do cliente e começa a enviar a resposta para o cliente no ritmo do cliente. Depois que todos os dados do app backend são recebidos pelo controlador de Ingresso, a conexão com o app backend é encerrada. A conexão do controlador de Ingresso com o cliente permanece aberta até que o cliente tenha recebido todos os dados.

</br></br>
Se o armazenamento em buffer de dados de resposta no controlador de Ingresso estiver desativado, os dados serão enviados imediatamente do controlador de Ingresso para o cliente. O cliente deverá estar apto a manipular os dados recebidos no ritmo do controlador de Ingresso. Se o cliente for muito lento, poderá haver perda de dados.
</br></br>
O armazenamento em buffer de dados de resposta no controlador de Ingresso é ativado por padrão.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **Configurando um tempo limite de conexão ou de leitura customizado para o controlador de Ingresso**
{: #timeout}

Ajuste o tempo que o controlador de Ingresso deve esperar enquanto se conecta e lê o app backend antes ser considerado não disponível.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Quando uma solicitação do cliente é enviada para o controlador de Ingresso, uma conexão com o app backend é aberta pelo controlador de Ingresso. Por padrão, o controlador de Ingresso aguarda 60 segundos para receber uma resposta do app backend. Se o app backend não responder dentro de 60 segundos, a solicitação de conexão será interrompida e o app backend será considerado não disponível.

</br></br>
Depois que o controlador de Ingresso for conectado ao app backend, dados de resposta do app backend serão lidos pelo controlador de Ingresso. Durante essa operação de leitura, o controlador de Ingresso aguarda um máximo de 60 segundos entre duas operações de leitura para receber dados do app backend. Se o app backend não enviar dados dentro de 60 segundos, a conexão com o app backend será encerrada e o app será considerado não disponível.
</br></br>
Um tempo limite de conexão e de leitura de 60 segundos é o tempo limite padrão em um proxy e idealmente não deve ser mudado.
</br></br>
Se a disponibilidade de seu app não for estável ou seu app estiver lento para responder em razão de altas cargas de trabalho, talvez você queira aumentar o tempo limite de conexão ou de leitura. Lembre-se de que aumentar o tempo limite afetará o desempenho do controlador de Ingresso, pois a conexão com o app backend deverá permanecer aberta até que o tempo limite seja atingido.
</br></br>
Por outro lado, será possível diminuir o tempo limite para ganhar desempenho no controlador de Ingresso. Assegure-se de que seu app backend seja capaz de manipular solicitações dentro do tempo limite especificado, mesmo durante cargas de trabalho mais altas.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua os seguintes valores:<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: insira o número de segundos que se deve esperar para se conectar ao app backend, por exemplo, <strong>65s</strong>.

  </br></br>
  <strong>Nota:</strong> um tempo limite de conexão não pode exceder 75 segundos.</li><li><code><em>&lt;read_timeout&gt;</em></code>: insira o número de segundos que se deve esperar para ler o app backend, por exemplo, <strong>65s</strong>.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **Configurando o tamanho máximo permitido do corpo de solicitação do cliente**
{: #client_max_body_size}

Use essa anotação para ajustar o tamanho do corpo que o cliente pode enviar como parte de uma solicitação.
{:shortdesc}

<dl>
<dt>Descrição</dt>
<dd>Para manter o desempenho esperado, o tamanho máximo do corpo de solicitação do cliente é configurado como 1 megabyte. Quando uma solicitação de cliente com um tamanho de corpo superior ao limite é enviada para o controlador de Ingresso e o cliente não permite dividir os dados em múltiplos chunks, o controlador de Ingresso retorna uma resposta de HTTP 413 (Entidade de solicitação muito grande) para o cliente. Uma conexão entre o cliente e o controlador de Ingresso não será possível até que o tamanho do corpo de solicitação seja reduzido. Quando o cliente permite a divisão dos dados em múltiplos chunks, os dados são divididos em pacotes de 1 megabyte e enviados para o controlador de Ingresso.

</br></br>
Talvez você queira aumentar o tamanho máximo do corpo porque espera solicitações do cliente com um tamanho de corpo maior que 1 megabyte. Por exemplo, você deseja que seu cliente possa fazer upload de arquivos grandes. Aumentar o tamanho máximo do corpo de solicitação poderá afetar o desempenho de seu controlador de Ingresso, pois a conexão com o cliente deverá permanecer aberta até que a solicitação seja recebida.
</br></br>
<strong>Nota:</strong> alguns navegadores da web do cliente não podem exibir a mensagem de resposta de HTTP 413 corretamente.</dd>
<dt>YAML do recurso de Ingresso de amostra</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadados:
  name: myingress
  annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
  tls:
  - System z:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Substitua o valor a seguir:<ul><li><code><em>&lt;size&gt;</em></code>: insira o tamanho máximo do corpo de resposta do cliente. Por exemplo, para configurá-lo como 200 megabytes, defina <strong>200 m</strong>.

  </br></br>
  <strong>Nota:</strong> será possível configurar o tamanho como 0 para desativar a verificação do tamanho do corpo de solicitação do cliente.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


## Gerenciando endereços IP e sub-redes
{: #cs_cluster_ip_subnet}

É possível usar sub-redes e endereços IP públicos móveis para expor apps em seu cluster e torná-los acessíveis na Internet.
{:shortdesc}

No {{site.data.keyword.containershort_notm}}, é possível incluir IPs móveis estáveis para serviços do Kubernetes, incluindo sub-redes da rede no cluster. Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} provisiona automaticamente uma sub-rede e 5 endereços IP públicos móveis. Os endereços IP públicos móveis são estáticos e não mudam quando um nó do trabalhador ou até mesmo o cluster, é removido.

Um dos endereços IP públicos móveis é usado para o [Controlador de ingresso](#cs_apps_public_ingress), que pode ser usado para expor múltiplos apps em seu cluster usando uma rota pública. Os outros 4 endereços IP públicos móveis podem ser usados para expor apps únicos ao público [criando um serviço de balanceador de carga](#cs_apps_public_load_balancer).

**Nota:** os endereços IP públicos móveis são cobrados mensalmente. Se escolher remover os endereços IP públicos móveis depois que o cluster for provisionado, ainda assim terá que pagar o encargo mensal, mesmo se você os usou por um curto tempo.



1.  Crie um script de configuração de serviço do Kubernetes que seja nomeado `myservice.yaml` e defina um serviço do tipo `LoadBalancer` com um endereço IP de balanceador de carga simulado. O exemplo a seguir usa o endereço IP 1.1.1.1 como o endereço IP do balanceador de carga.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Crie o serviço em seu cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspecione o serviço.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** a criação desse serviço falha porque o mestre do Kubernetes não pode localizar o endereço IP do balanceador de carga especificado no mapa de configuração do Kubernetes. Quando você executa esse comando, é possível ver a mensagem de erro e a lista de endereços IP públicos disponíveis para o cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. Os IPs do provedor em nuvem a seguir estão disponíveis: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### Liberando os endereços IP públicos usados
{: #freeup_ip}

É possível liberar um endereço IP público móvel usado excluindo o serviço de balanceador de carga que está usando o endereço IP público móvel.

[Antes de iniciar, configure o contexto para o cluster que você deseja usar.](cs_cli_install.html#cs_cli_configure)

1.  Liste os serviços disponíveis em seu cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Remova o serviço de balanceador de carga que usa um endereço IP público.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}


## Implementando apps com a GUI
{: #cs_apps_ui}

Ao implementar um app em seu cluster usando o painel do Kubernetes, uma implementação que cria, atualiza e gerencia os pods em seu cluster é criada automaticamente.
{:shortdesc}

Antes de iniciar:

-   Instale as [CLIs](cs_cli_install.html#cs_cli_install) necessárias.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para implementar seu app:

1.  [Abra o painel do Kubernetes](#cs_cli_dashboard).
2.  No painel do Kubernetes, clique em **+ Criar**.
3.  Selecione **Especificar detalhes do app abaixo** para inserir os detalhes do app na GUI ou **Fazer upload de um arquivo YAML ou JSON** para fazer upload do [arquivo de configuração do app ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). Use [este exemplo de arquivo YAML ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) para implementar um contêiner da imagem **ibmliberty** na região sul dos EUA.
4.  No painel do Kubernetes, clique em **Implementações** para verificar se a implementação foi criada.
5.  Se você tiver disponibilizado publicamente o seu app usando um serviço de porta de nó, um serviço de balanceador de carga ou o Ingresso, [verifique se será possível acessar o app](#cs_apps_public).

## Implementando apps com a CLI
{: #cs_apps_cli}

Após um cluster ser criado, é possível implementar um app nesse cluster usando a CLI do Kubernetes.
{:shortdesc}

Antes de iniciar:

-   Instale as [CLIs](cs_cli_install.html#cs_cli_install) necessárias.
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para implementar seu app:

1.  Crie um script de configuração com base nas [melhores práticas do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/configuration/overview/). Geralmente, um script de configuração contém detalhes de configuração para cada um dos recursos que você cria no Kubernetes. Seu script pode incluir uma ou mais das seções a seguir:

    -   [Implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): define a criação de pods e conjuntos de réplicas. Um pod inclui um app conteinerizado individual e os conjuntos de réplicas controlam múltiplas instâncias de pods.

    -   [Serviço ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/service/): fornece acesso de front-end para os pods usando um nó do trabalhador ou um endereço IP público do balanceador de carga ou uma rota pública do Ingresso.

    -   [Ingresso ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/): especifica um tipo de balanceador de carga que fornece rotas para acessar seu app publicamente.

2.  Execute o script de configuração no contexto de um cluster.

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  Se você tiver disponibilizado publicamente o seu app usando um serviço de porta de nó, um serviço de balanceador de carga ou o Ingresso, [verifique se será possível acessar o app](#cs_apps_public).



## Gerenciando implementações de rolagem
{: #cs_apps_rolling}

É possível gerenciar o lançamento de suas mudanças de forma automatizada e controlada. Se a sua apresentação não estiver indo de acordo com o plano, será possível recuperar a sua implementação para a revisão anterior.
{:shortdesc}

Antes de iniciar, crie uma [implementação](#cs_apps_cli).

1.  [Apresente ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) uma mudança. Por exemplo, talvez você queira mudar a imagem usada na implementação inicial.

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

## Incluindo serviços do {{site.data.keyword.Bluemix_notm}}
{: #cs_apps_service}

Os segredos criptografados do Kubernetes são usados para armazenar detalhes e credenciais do serviço do {{site.data.keyword.Bluemix_notm}} e permitem a comunicação segura entre o serviço e o cluster. Como usuário do cluster, é possível acessar esse segredo montando-o como um volume em um pod.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster. Certifique-se de que o serviço do {{site.data.keyword.Bluemix_notm}} que você deseja usar no app tenha sido [incluído no cluster](cs_cluster.html#cs_cluster_service) pelo administrador de cluster.

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
    <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
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

## Criando armazenamento persistente
{: #cs_apps_volume_claim}

Você cria uma solicitação de volume persistente para provisionar armazenamento de arquivo NFS para seu cluster. Você monta essa solicitação em um pod para assegurar-se de que os dados estejam disponíveis, mesmo no caso de travamento ou encerramento do pod.
{:shortdesc}

O armazenamento de arquivo NFS que suporta o volume persistente é armazenado em cluster pela IBM para fornecer alta disponibilidade para seus dados.

1.  Revise as classes de armazenamento disponíveis. O {{site.data.keyword.containerlong}} fornece três classes predefinidas de armazenamento para que o administrador de cluster não precise criar quaisquer classes de armazenamento.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Revise o IOPS de uma classe de armazenamento ou os tamanhos disponíveis.

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    O campo **Parâmetros** fornece o IOPS por GB associado à classe de armazenamento e os tamanhos disponíveis em gigabytes.

    ```
    Parâmetros:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

3.  Em seu editor de texto preferencial, crie um script de configuração para definir sua solicitação de volume persistente e salvar a configuração como um arquivo `.yaml`.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Insira o nome da solicitação de volume persistente.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Especifique a classe de armazenamento que define o IOPS por GB do compartilhamento de arquivo host para o volume persistente:<ul><li>ibmc-file-bronze: 2 IOPS por GB.</li><li>ibmc-file-silver: 4 IOPS por GB.</li><li>ibmc-file-gold: 10 IOPS por GB.</li>

    </li> Se você não especificar uma classe de armazenamento, o volume persistente será criado com a classe de armazenamento bronze.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Se você escolher um tamanho diferente do listado, ele será arredondado. Se você selecionar um tamanho maior que o maior tamanho, então o tamanho será arredondado para baixo.</td>
    </tr>
    </tbody></table>

4.  Crie a solicitação de volume persistente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

5.  Verifique se a sua solicitação de volume persistente foi criada e ligada ao volume persistente. Esse processo pode levar alguns minutos.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    Sua saída é semelhante à mostrada a seguir.

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}Para montar a solicitação de volume persistente em seu pod, crie um script de configuração. Salve a configuração como um arquivo `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Entendendo os componentes de arquivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>O nome do pod.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>O caminho absoluto do diretório no qual o volume está montado dentro do contêiner.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>O nome do volume que você monta em seu contêiner.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>O nome do volume que você monta em seu contêiner. Geralmente, esse nome é o mesmo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>O nome da solicitação de volume persistente que você deseja usar como seu volume. Ao montar o volume no pod, o Kubernetes identifica o volume persistente que está ligado à solicitação de volume persistente e permite que o usuário leia e grave no volume persistente.</td>
    </tr>
    </tbody></table>

7.  Crie o pod e monte a solicitação de volume persistente em seu pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

8.  Verifique se o volume foi montado com êxito no pod.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    O ponto de montagem está no campo **Montagens de volume** e o volume está no campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

## Incluindo acesso de usuário não raiz no armazenamento persistente
{: #cs_apps_volumes_nonroot}

Os usuários não raiz não têm permissão de gravação no caminho de montagem do volume para armazenamento suportado por NFS. Para conceder permissão de gravação, deve-se editar o Dockerfile da imagem para criar um diretório no caminho de montagem com a permissão correta.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Se você estiver projetando um app com um usuário não raiz que requeira permissão de gravação para o volume, deverá incluir os processos a seguir no Dockerfile e no script de ponto de entrada:

-   Crie um usuário não raiz.
-   Inclua o usuário temporariamente no grupo raiz.
-   Crie um diretório no caminho de montagem do volume com as permissões de usuário corretas.

Para o {{site.data.keyword.containershort_notm}}, o proprietário padrão do caminho de montagem do volume é o proprietário `nobody`. Com o armazenamento NFS, se o proprietário não existir localmente no pod, o usuário `nobody` será criado. Os volumes são configurados para reconhecer o usuário raiz no contêiner que, para alguns apps, é o único usuário dentro de um contêiner. No entanto, muitos apps especificam um usuário não raiz diferente de `nobody` que grava no caminho de montagem do contêiner.

1.  Crie um Dockerfile em um diretório local. Este exemplo de Dockerfile está criando um usuário não raiz chamado `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    #The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Crie o script de ponto de entrada na mesma pasta local do Dockerfile. Este script de ponto de entrada de exemplo está especificando `/mnt/myvol` como o caminho de montagem do volume.

    ```
    #!/bin/bash
    set -e

    #This is the mount point for the shared volume.
    #By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      #Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #For security, remove the non-root user from root user group.
      deluser $MY_USER root

      #Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    #This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Efetue login no {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

4.  Construa a imagem localmente. Lembre-se de substituir _&lt;my_namespace&gt;_ pelo namespace de seu registro de imagens privadas. Execute `bx cr namespace-get` se precisar localizar seu namespace.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  Envie a imagem por push para o seu namespace no {{site.data.keyword.registryshort_notm}}.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  Crie uma solicitação de volume persistente criando um arquivo de configuração `.yaml`. Esse exemplo usa uma classe de armazenamento de desempenho inferior. Execute `kubectl get storageclasses` para ver as classes de armazenamento disponíveis.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Crie a solicitação de volume persistente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Crie um script de configuração para montar o volume e executar o pod por meio da imagem não raiz. O caminho de montagem do volume `/mnt/myvol` corresponde ao caminho de montagem especificado no Dockerfile. Salve a configuração como um arquivo `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Crie o pod e monte a solicitação de volume persistente em seu pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. Verifique se o volume foi montado com êxito no pod.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    O ponto de montagem é listado no campo **Montagens de volume** e o volume é listado no campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Efetue login no pod após a execução do pod.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Visualize permissões de seu caminho de montagem do volume.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Essa saída mostra que a raiz possui permissões de leitura, gravação e execução no caminho de montagem do volume `mnt/myvol/`, mas o usuário myguest não raiz tem permissão para ler e gravar na pasta `mnt/myvol/mydata`. Por causa dessas permissões atualizadas, o usuário não raiz pode agora gravar dados no volume persistente.


