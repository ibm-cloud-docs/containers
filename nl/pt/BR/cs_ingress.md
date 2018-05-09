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


# Configurando serviços de Ingresso
{: #ingress}

Exponha múltiplos apps em seu cluster do Kubernetes criando recursos de Ingresso que são gerenciados pelo balanceador de carga de aplicativo fornecido pela IBM no {{site.data.keyword.containerlong}}.
{:shortdesc}

## Planejando a rede com serviços de Ingresso
{: #planning}

Com Ingresso, é possível expor múltiplos serviços em seu cluster e torná-los publicamente disponíveis usando um ponto de entrada público único.
{:shortdesc}

Em vez de criar um serviço de balanceador de carga para cada app que você deseja expor para o público, o Ingresso fornece uma rota pública exclusiva para encaminhar solicitações públicas para apps dentro e fora do seu cluster com base em seus caminhos individuais. O Ingresso consiste em dois componentes principais: o balanceador de carga de aplicativo e o recurso de Ingresso.

O application load balancer (ALB) é um balanceador de carga externo que atende solicitações de serviço HTTP ou HTTPS, TCP ou UDP recebidas e encaminha as solicitações para o pod de app apropriado. Ao criar um cluster padrão, o {{site.data.keyword.containershort_notm}} cria automaticamente um ALB altamente disponível para seu cluster e designa uma rota pública exclusiva para ele. A rota pública está vinculada a um endereço IP público móvel que é provisionado em sua conta de infraestrutura do IBM Cloud (SoftLayer) durante a criação do cluster. Um ALB privado padrão também é criado automaticamente, mas não é ativado automaticamente.

Para expor um app por meio de Ingresso, deve-se criar um serviço do Kubernetes para seu app e registrar esse serviço com o ALB definindo um recurso de Ingresso. O recurso de Ingresso especifica o caminho que é anexado à rota pública para formar uma URL exclusiva para seu app exposto, como `mycluster.us-south.containers.mybluemix.net/myapp` e define as regras de como rotear solicitações recebidas para um app.

O diagrama a seguir mostra como o Ingresso direciona a comunicação da internet para um app:

<img src="images/cs_ingress_planning.png" width="550" alt="Expor um app no {{site.data.keyword.containershort_notm}} usando Ingresso" style="width:550px; border-style: none"/>

1. Um usuário envia uma solicitação para seu app acessando a URL do app. Essa URL é a URL pública para seu app exposto com o caminho do recurso de Ingresso anexado a ela, como `mycluster.us-south.containers.mybluemix.net/myapp`.

2. Um serviço do sistema DNS que age como o balanceador de carga global resolve a URL para o endereço IP público móvel do ALB público padrão no cluster.

3. `kube-proxy` roteia a solicitação para o serviço ALB do Kubernetes para o app.

4. O serviço Kubernetes roteia a solicitação para o ALB.

5. O ALB verifica se uma regra de roteamento para o caminho `myapp` existe no cluster. Se uma regra de correspondência é localizada, a solicitação é encaminhada de acordo com as regras que você definiu no recurso de Ingresso para o pod no qual o app está implementado. Se múltiplas instâncias do app são implementadas no cluster, o ALB balanceia a carga de solicitações entre os pods de app.



**Nota:** o Ingresso está disponível somente para clusters padrão e requer pelo menos dois nós do trabalhador no cluster para assegurar alta disponibilidade e que atualizações periódicas sejam aplicadas. Configurar o Ingresso requer uma [política de acesso de Administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.

Para escolher a melhor configuração para o Ingress, é possível seguir esta árvore de decisão:

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="Esta imagem orienta você na escolha da melhor configuração para seu balanceador de carga de aplicativo de Ingresso. Se esta imagem não estiver sendo exibida, as informações ainda poderão ser localizadas na documentação." style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="Expor apps de forma privada usando um domínio customizado sem TLS" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="Expor apps de forma privada usando um domínio customizado com TLS" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="Expondo apps de forma pública que estão fora de seu cluster usando o domínio fornecido pela IBM ou um customizado com TLS" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="Expondo apps de forma pública usando um domínio customizado com TLS" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="Expondo apps de forma pública usando o domínio fornecido pela IBM sem TLS" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="Expondo apps de forma pública usando o domínio fornecido pela IBM com TLS" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## Expondo apps ao público
{: #ingress_expose_public}

Ao criar um cluster padrão, um application load balancer (ALB) fornecido pela IBM é ativado automaticamente e é designado um endereço IP público móvel e uma rota pública.
{:shortdesc}

Cada app que é exposto ao público por meio do Ingresso é designado a um caminho exclusivo que é anexado à rota pública, para que seja possível usar uma URL exclusiva para acessar um app publicamente em seu cluster. Para expor seu app ao público, é possível configurar o Ingresso para os cenários a seguir.

-   [Expor apps de forma pública usando o domínio fornecido pela IBM sem TLS](#ibm_domain)
-   [Expor apps de forma pública usando o domínio fornecido pela IBM com TLS](#ibm_domain_cert)
-   [Expor apps de forma pública usando um domínio customizado com TLS](#custom_domain_cert)
-   [Expor apps de forma pública que estão fora de seu cluster usando o domínio fornecido pela IBM ou um customizado com TLS](#external_endpoint)

### Expor apps de forma pública usando o domínio fornecido pela IBM sem TLS
{: #ibm_domain}

É possível configurar o ALB para balancear a carga do tráfego de rede HTTP recebido para os apps em seu cluster e usar o domínio fornecido pela IBM para acessar seus apps na Internet.
{:shortdesc}

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para expor um app usando o domínio fornecido pela IBM:

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.
2.  Crie um serviço do Kubernetes para o app a ser exposto. O ALB poderá incluir o seu app no balanceamento de carga do Ingresso somente se o app for exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myservice.yaml`.
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
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para seu serviço ALB.</td>
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
    Retrieving cluster <mycluster>... OK Name: <mycluster> ID: b9c6b00dc0aa487f97123440b4895f2d State: normal Created: 2017-04-26T19:47:08+0000 Location: dal10 Master URL: https://169.57.40.165:1931 Ingress subdomain: <ibmdomain> Ingress secret: <ibmtlssecret> Workers: 3 Version: 1.8.8
    ```
    {: screen}

    É possível ver o domínio fornecido pela IBM no campo **Subdomínio do Ingresso**.
4.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes criado para o seu app e são usados pelo ALB para rotear o tráfego de rede recebido para o serviço. Deve-se usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps se cada app é exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio fornecido pela IBM para rotear o tráfego de rede recebido para o serviço que você criou anteriormente.

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
        <caption>Entendendo os componentes do arquivo de recursos do Ingress</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
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
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br></br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.
        </br>
        Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        </br>
        <strong>Dica:</strong> para configurar o Ingresso para atender em um caminho que seja diferente do caminho no qual seu app atende, será possível usar a [nova gravação de anotação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para o app.</td>
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

    1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.

6.  Em um navegador da web, insira a URL do serviço de app a ser acessado.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

<br />


### Expor apps publicamente usando o domínio fornecido pela IBM com TLS
{: #ibm_domain_cert}

É possível configurar o ALB de Ingresso para gerenciar conexões TLS recebidas para seus apps, decriptografar o tráfego de rede usando o certificado TLS fornecido pela IBM e encaminhar a solicitação decriptografada para os apps expostos em seu cluster.
{:shortdesc}

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para expor um app usando o domínio fornecido pela IBM com TLS:

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo identifica todos os pods nos quais o app está em execução, para que sejam incluídos no balanceamento de carga do Ingresso.
2.  Crie um serviço do Kubernetes para o app a ser exposto. O ALB poderá incluir o seu app no balanceamento de carga do Ingresso somente se o app for exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço ALB para o app que você deseja expor ao público.

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
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para seu serviço ALB.</td>
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
    State:    normal
    Created:  2017-04-26T19:47:08+0000
    Location: dal10
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    Version: 1.8.8
    ```
    {: screen}

    É possível ver o domínio fornecido pela IBM no **Subdomínio do Ingresso** e o certificado fornecido pela IBM no campo **Segredo do Ingresso**.

4.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes criado para o seu app e são usados pelo ALB para rotear o tráfego de rede recebido para o serviço. Deve-se usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps se cada app é exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio fornecido pela IBM para rotear o tráfego de rede recebido para seus serviços e o certificado fornecido pela IBM para gerenciar o encerramento do TLS para você. Para cada serviço, é possível definir um caminho individual que é anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo `https://ingress_domain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e, posteriormente, para os pods nos quais o app está em execução.

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
        <caption>Entendendo os componentes do arquivo de recursos do Ingress</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
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
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br>
        Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> para configurar o Ingresso para atender em um caminho que seja diferente do caminho no qual seu app atende, será possível usar a [nova gravação de anotação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para o app.</td>
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

    1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.

6.  Em um navegador da web, insira a URL do serviço de app a ser acessado.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

<br />


### Expor apps de forma pública usando um domínio customizado com TLS
{: #custom_domain_cert}

É possível configurar o ALB para rotear o tráfego de rede recebido para os apps em seu cluster e usar seu próprio certificado TLS para gerenciar a finalização do TLS, enquanto usa seu domínio customizado em vez do domínio fornecido pela IBM.
{:shortdesc}

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para expor um app usando um domínio customizado com TLS:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) ou com o [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) para registrar seu domínio customizado.
2.  Configure seu domínio para rotear o tráfego de rede recebido para o ALB fornecido pela IBM. Escolha entre estas opções:
    -   Defina um alias para seu domínio customizado especificando o domínio fornecido pela IBM como um registro de Nome Canônico (CNAME). Para localizar o domínio de Ingresso fornecido pela IBM, execute `bx cs cluster-get <mycluster>` e procure o campo **Subdomínio do Ingresso**.
    -   Mapeie o seu domínio customizado para o endereço IP público móvel do ALB fornecido pela IBM incluindo o endereço IP como um registro. Para localizar o endereço IP público móvel do ALB, execute `bx cs alb-get<public_alb_ID>`.
3.  Importe ou crie um certificado TLS e a chave secreta.
    * Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:

      ```
      bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
      ```
      {: pre}

    * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2. Crie um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;mytlssecret&gt;</em> por um nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> com o caminho
para o seu arquivo-chave TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> com o caminho para o seu arquivo de certificado TLS
customizado.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

4.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.

5.  Crie um serviço do Kubernetes para o app a ser exposto. O ALB poderá incluir o seu app no balanceamento de carga do Ingresso somente se o app for exposto por meio de um serviço do Kubernetes dentro do cluster.

    1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço ALB para o app que você deseja expor ao público.

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
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para seu serviço ALB.</td>
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
6.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes criado para o seu app e são usados pelo ALB para rotear o tráfego de rede recebido para o serviço. Deve-se usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps se cada app é exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que use o domínio customizado para rotear o tráfego de rede recebido para seus serviços e o certificado customizado para gerenciar o encerramento do TLS. Para cada serviço, é possível definir um caminho individual que é anexado ao seu domínio customizado para criar um caminho exclusivo para seu app; por exemplo, `https://mydomain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e, posteriormente, para os pods nos quais o app está em execução.

        O app deve atender no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

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
        <caption>Entendendo os componentes do arquivo de recursos do Ingress</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
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
        <td>Substitua <em>&lt;mytlssecret&gt;</em> pelo nome do segredo que você criou anteriormente que retém seu certificado e chave TLS customizados. Se você tiver importado um certificado do {{site.data.keyword.cloudcerts_short}}, será possível executar <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver os segredos associados a um certificado TLS.
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
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> para configurar o Ingresso para atender em um caminho que seja diferente do caminho no qual seu app atende, será possível usar a [nova gravação de anotação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para o app.
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

7.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua _&lt;myingressname&gt;_ pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.

8.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


### Expor apps de forma pública que estão fora de seu cluster usando o domínio fornecido pela IBM ou um customizado com TLS
{: #external_endpoint}

É possível configurar o ALB para incluir apps que estão localizados fora do cluster. As solicitações recebidas no domínio customizado ou fornecido pela IBM
são encaminhadas automaticamente para o app externo.
{:shortdesc}

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.
-   Assegure-se de que o app externo que você deseja incluir no balanceamento de carga do cluster possa ser acessado usando um endereço IP público.

É possível rotear o tráfego de rede recebido no domínio fornecido pela IBM para apps que estão localizados fora do cluster. Se desejar usar um domínio customizado e um certificado TLS como alternativa, substitua o domínio fornecido pela IBM e o certificado TLS pelo seu [domínio customizado e certificado TLS](#custom_domain_cert).

1.  Crie um serviço do Kubernetes para seu cluster que encaminhará solicitações recebidas para um terminal externo que você criará.
    1.  Abra seu editor preferencial e crie um arquivo de configuração de serviço que seja chamado, por exemplo, de `myexternalservice.yaml`.
    2.  Defina o serviço ALB.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservicename>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Substitua <em>&lt;myservicename&gt;</em> por um nome para seu serviço.</td>
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

2.  Configure um terminal do Kubernetes que defina o local externo do app que você deseja incluir no balanceamento de carga do cluster.
    1.  Abra seu editor preferencial e crie um arquivo de configuração do terminal que é chamado, por exemplo, de `myexternalendpoint.yaml`.
    2.  Defina seu terminal externo. Inclua todos os endereços IP públicos e portas que podem ser usados para acessar seu app externo.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myservicename>
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
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myendpointname&gt;</em> pelo nome do serviço do Kubernetes que você criou anteriormente.</td>
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

3.  Visualize o domínio fornecido pela IBM e o certificado TLS. Substitua _&lt;mycluster&gt;_ pelo nome do cluster no qual o app está implementado.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    Sua saída de CLI é semelhante à seguinte.

    ```
    Retrieving cluster <mycluster>... OK Name: <mycluster> ID: b9c6b00dc0aa487f97123440b4895f2d State: normal Created: 2017-04-26T19:47:08+0000 Location: dal10 Master URL: https://169.57.40.165:1931 Ingress subdomain: <ibmdomain> Ingress secret: <ibmtlssecret> Workers: 3 Version: 1.8.8
    ```
    {: screen}

    É possível ver o domínio fornecido pela IBM no **Subdomínio do Ingresso** e o certificado fornecido pela IBM no campo **Segredo do Ingresso**.

4.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes criado para o seu app e são usados pelo ALB para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps externos desde que cada app seja exposto com o seu terminal externo por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um arquivo de configuração do Ingresso que seja chamado, por exemplo, de `myexternalingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio fornecido pela IBM e o certificado TLS para rotear o tráfego de rede recebido para seu app externo usando o terminal externo que você definiu anteriormente. Para cada serviço, é possível definir um caminho individual que é anexado ao domínio fornecido pela IBM ou customizado para criar um caminho exclusivo para o seu app, por exemplo `https://ingress_domain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e, além disso, para o app externo.

        O app deve atender no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como / e não especifique um caminho individual para seu app.

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
        <caption>Entendendo os componentes do arquivo de recursos do Ingress</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
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
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, <code>https://ibmdomain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o app externo usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br></br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        <strong>Dica:</strong> para configurar o Ingresso para atender em um caminho que seja diferente do caminho no qual seu app atende, será possível usar a [nova gravação de anotação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para o app.</td>
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

    1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.

6.  Acesse seu app externo.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL para acessar seu app externo.

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}

<br />


## Expondo apps para uma rede privada
{: #ingress_expose_private}

Ao criar um cluster padrão, um application load balancer (ALB) fornecido pela IBM é criado e designado a um endereço IP privado móvel e uma rota privada. No entanto, o ALB privado padrão não é ativado automaticamente. Para expor seu app a redes privadas, primeiro [ative o balanceador de carga de aplicativo privado padrão](#private_ingress).
{:shortdesc}

É possível então configurar o Ingresso para os cenários a seguir.
-   [Expor apps de forma privada usando um domínio customizado sem TLS](#private_ingress_no_tls)
-   [Expor apps de forma privada usando um domínio customizado com TLS](#private_ingress_tls)

### Ativando o balanceador de carga de aplicativo privado padrão
{: #private_ingress}

Antes de poder usar o ALB privado padrão, deve-se ativá-lo com o endereço IP privado móvel fornecido pela IBM ou seu próprio endereço IP privado móvel.
{:shortdesc}

**Nota**: se você usou a sinalização `--no-subnet` quando criou o cluster, deve-se incluir uma sub-rede privada móvel ou uma sub-rede gerenciada pelo usuário antes de poder ativar o ALB privado. Para obter mais informações, veja [Solicitando sub-redes adicionais para seu cluster](cs_subnets.html#request).

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para ativar o ALB privado usando o endereço IP privado móvel, fornecido pela IBM, pré-designado:

1. Liste os ALBs disponíveis em seu cluster para obter o ID do ALB privado. Substitua <em>&lt;cluser_name&gt;</em> pelo nome do cluster no qual o app que você deseja expor está implementado.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    O campo **Status** para o ALB privado está _desativado_.
    ```
    ALB ID Enabled Status Type ALB IP private-cr6d779503319d419ea3b4ab171d12c3b8-alb1 false disabled private - public-cr6d779503319d419ea3b4ab171d12c3b8-alb1 true enabled public 169.46.63.150
    ```
    {: screen}

2. Ative o ALB privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de ALB privado da saída na etapa anterior.

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Para ativar o ALB privado usando seu próprio endereço IP privado móvel:

1. Configure a sub-rede gerenciada pelo usuário de seu endereço IP escolhido para rotear o tráfego na VLAN privada do seu cluster. Substitua <em>&lt;cluser_name&gt;</em> pelo nome ou ID do cluster no qual o app que você deseja expor está implementado, <em>&lt;subnet_CIDR&gt;</em> pelo CIDR de sua sub-rede gerenciada pelo usuário e <em>&lt;private_VLAN&gt;</em> por um ID de VLAN privada disponível. É possível localizar o ID de uma VLAN privada disponível executando `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Liste os ALBs disponíveis em seu cluster para obter o ID de ALB privado.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    O campo **Status** para o ALB privado está _desativado_.
    ```
    ALB ID Enabled Status Type ALB IP private-cr6d779503319d419ea3b4ab171d12c3b8-alb1 false disabled private - public-cr6d779503319d419ea3b4ab171d12c3b8-alb1 true enabled public 169.46.63.150
    ```
    {: screen}

3. Ative o ALB privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID para o ALB privado da saída na etapa anterior e <em>&lt;user_ip&gt;</em> pelo endereço IP de sua sub-rede gerenciada pelo usuário que você deseja usar.

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

<br />


### Expor apps de forma privada usando um domínio customizado sem TLS
{: #private_ingress_no_tls}

É possível configurar o ALB privado para rotear o tráfego de rede recebido para os apps em seu cluster usando um domínio customizado.
{:shortdesc}

Antes de iniciar, [ative o balanceador de carga do aplicativo privado](#private_ingress).

Para expor um app de forma privada usando um domínio customizado sem TLS:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) ou com o [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) para registrar seu domínio customizado.

2.  Mapeie o seu domínio customizado para o endereço IP privado móvel do ALB privado fornecido pela IBM, incluindo o endereço IP como um registro. Para localizar o endereço IP privado móvel do ALB privado, execute `bx cs albs --cluster <cluster_name>`.

3.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo identifica todos os pods nos quais o seu app está em execução para que eles possam ser incluídos no balanceamento de carga de Ingresso.

4.  Crie um serviço do Kubernetes para o app a ser exposto. O ALB privado poderá incluir o seu app no balanceamento de carga do Ingresso somente se o app for exposto por meio de um serviço do Kubernetes dentro do cluster.

    1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço ALB para o app que você deseja expor ao público.

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
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para seu serviço ALB.</td>
        </tr>
        <tr>
        <td><code>seletor</code></td>
        <td>Insira o par de chave de etiqueta (<em>&lt;selectorkey&gt;</em>) e valor (<em>&lt;selectorvalue&gt;</em>) que você deseja usar para destinar os pods nos quais seu app é executado. Por exemplo, se você usar o seletor <code>app: code</code> a seguir, todos os pods que tiverem esse rótulo em seus metadados serão incluídos no balanceamento de carga. Insira o mesmo rótulo que você usou quando implementou o seu app no cluster. </td>
         </tr>
         <td><code>port</code></td>
         <td>A porta na qual o serviço atende.</td>
         </tbody></table>

    3.  Salve as suas mudanças.
    4.  Crie o serviço do Kubernetes em seu cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita essas etapas para cada app que você desejar expor para a rede privada.
7.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes criado para o seu app e são usados pelo ALB para rotear o tráfego de rede recebido para o serviço. Deve-se usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps se cada app é exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio customizado para rotear o tráfego de rede recebido para seus serviços. Para cada serviço, é possível definir um caminho individual que seja anexado ao seu domínio customizado para criar um caminho exclusivo para seu app, por exemplo, `https://mydomain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e, posteriormente, para os pods nos quais o app está em execução.

        O app deve atender no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
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
        <caption>Entendendo os componentes do arquivo de recursos do Ingress</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de seu ALB privado. Execute <code>bx cs albs --cluster <my_cluster></code> para localizar o ID do ALB. Para obter mais informações sobre essa anotação de Ingresso, veja [Roteamento do balanceador de carga de aplicativo privado](cs_annotations.html#alb-id).</td>
        </tr>
        <td><code>host</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo <code>custom_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> para configurar o Ingresso para atender em um caminho que seja diferente do caminho no qual seu app atende, será possível usar a [nova gravação de anotação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para o app.
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

    1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.

9.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


### Expor apps de forma privada usando um domínio customizado com TLS
{: #private_ingress_tls}

É possível usar ALBs privados para rotear o tráfego de rede recebido para apps em seu cluster. Além disso, use seu próprio certificado TLS para gerenciar a finalização de TLS enquanto usa seu domínio customizado.
{:shortdesc}

Antes de iniciar, [ative o balanceador de carga de aplicativo privado padrão](#private_ingress).

Para expor um app de forma privada usando um domínio customizado com TLS:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) ou com o [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) para registrar seu domínio customizado.

2.  Mapeie o seu domínio customizado para o endereço IP privado móvel do ALB privado fornecido pela IBM, incluindo o endereço IP como um registro. Para localizar o endereço IP privado móvel do ALB privado, execute `bx cs albs --cluster <cluster_name>`.

3.  Importe ou crie um certificado TLS e a chave secreta.
    * Se um certificado TLS é armazenado no {{site.data.keyword.cloudcerts_long_notm}} que você deseja usar, é possível importar seu segredo associado para o cluster executando `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2. Crie um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;mytlssecret&gt;</em> por um nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> com o caminho
para o seu arquivo-chave TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> com o caminho para o seu arquivo de certificado TLS
customizado.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

4.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.

5.  Crie um serviço do Kubernetes para o app a ser exposto. O ALB privado poderá incluir o seu app no balanceamento de carga do Ingresso somente se o app for exposto por meio de um serviço do Kubernetes dentro do cluster.

    1.  Abra o seu editor preferencial e crie um arquivo de configuração de serviço que seja denominado, por exemplo, `myservice.yaml`.
    2.  Defina um serviço de balanceador de carga de aplicativo para o app que você deseja expor para o público.

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
        <caption>Entendendo os componentes de arquivo de serviço do ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para seu serviço ALB.</td>
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

    5.  Repita essas etapas para cada app que você deseja expor na rede privada.
6.  Crie um recurso do Ingresso. Os recursos do Ingresso definem as regras de roteamento para o serviço do Kubernetes criado para o seu app e são usados pelo ALB para rotear o tráfego de rede recebido para o serviço. Deve-se usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps se cada app é exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que use o domínio customizado para rotear o tráfego de rede recebido para seus serviços e o certificado customizado para gerenciar o encerramento do TLS. Para cada serviço, é possível definir um caminho individual que seja anexado ao seu domínio customizado para criar um caminho exclusivo para seu app, por exemplo, `https://mydomain/myapp`. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e, posteriormente, para os pods nos quais o app está em execução.

        **Nota:** o app deve atender no caminho que você definiu no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
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
        <caption>Entendendo os componentes do arquivo de recursos do Ingress</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myingressname&gt;</em> por um nome para seu recurso de Ingresso.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID de seu ALB privado. Execute <code>bx cs albs --cluster <my_cluster></code> para localizar o ID do ALB. Para obter mais informações sobre essa anotação do Ingress, consulte [Roteamento do balanceador de carga do aplicativo privado (ALB-ID)](cs_annotations.html#alb-id).</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado que você deseja configurar para finalização do TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Substitua <em>&lt;mytlssecret&gt;</em> pelo nome do segredo que você criou anteriormente e que retém o seu certificado e chave TLS customizados. Se você tiver importado um certificado do {{site.data.keyword.cloudcerts_short}}, será possível executar <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> para ver os segredos associados a um certificado TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado que você deseja configurar para finalização TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Quando você insere essa rota em um navegador da web, o tráfego de rede é roteado para o ALB. O ALB consulta o serviço associado e envia o tráfego de rede para o serviço e para os pods nos quais o app está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> para configurar o Ingresso para atender em um caminho que seja diferente do caminho no qual seu app atende, será possível usar a [nova gravação de anotação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para o app.
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

7.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua _&lt;myingressname&gt;_ pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    1. Se as mensagens nos eventos descreverem um erro na configuração do recurso, mude os valores no arquivo de recursos e reaplique o arquivo para o recurso.

8.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

Para obter um tutorial abrangente sobre como assegurar a comunicação de microsserviço-para-microsserviço em seus clusters usando o ALB privado com TLS, veja [esta postagem do blog ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")]](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).

<br />




## Configurações opcionais do balanceador de carga de aplicativo
{: #configure_alb}

É possível configurar ainda mais um balanceador de carga de aplicativo com as opções a seguir.

-   [Abrindo portas no balanceador de carga de aplicativo de Ingresso](#opening_ingress_ports)
-   [Configurar protocolos SSL e cifras SSL no nível de HTTP](#ssl_protocols_ciphers)
-   [Customizando o seu balanceador de carga de aplicativo com anotações](cs_annotations.html)
{: #ingress_annotation}


### Abrindo portas no balanceador de carga de aplicativo de Ingresso
{: #opening_ingress_ports}

Por padrão, somente as portas 80 e 443 são expostas no ALB de Ingresso. Para expor outras portas, é possível editar o recurso configmpa `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

1.  Crie uma versão local do arquivo de configuração para o recurso configmap `ibm-cloud-provider-ingress-cm`. Inclua uma seção <code>data</code> e especifique as portas públicas 80, 443 e quaisquer outras portas que você deseja incluir no arquivo configmap separadas por um ponto e vírgula (;).

 Nota: ao especificar as portas, 80 e 443 também deverão ser incluídas para manter essas portas abertas. Qualquer porta que não esteja especificada é encerrada.

 ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

 Exemplo:
 ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```

2. Aplique o arquivo de configuração.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Verifique se o arquivo de configuração foi aplicado.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 Saída:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Dados ====

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

Para obter mais informações sobre os recursos configmap, veja a [documentação do Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).

### Configurando protocolos SSL e cifras SSL no nível de HTTP
{: #ssl_protocols_ciphers}

Ative os protocolos e cifras SSL no nível HTTP global editando o configmap `ibm-cloud-provider-ingress-cm`.
{:shortdesc}



**Nota**: quando você especifica os protocolos ativados para todos os hosts, os parâmetros TLSv1.1 e TLSv1.2 (1.1.13, 1.0.12) funcionam somente quando o OpenSSL 1.0.1 ou superior é usado. O parâmetro TLSv1.3 (1.13.0) funciona somente quando o OpenSSL 1.1.1 construído com o suporte TLSv1.3 é usado.

Para editar o configmap para ativar protocolos e cifras SSL:

1. Crie e abra uma versão local do arquivo de configuração para o recurso configmap ibm-cloud-provider-ingress-cm.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Inclua os protocolos e cifras SSL. Formate as cifras de acordo com o [Formato de lista de cifras da biblioteca OpenSSL ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

2. Aplique o arquivo de configuração.

   ```
   kubectl apply -f <path/to/configmap.yaml>
   ```
   {: pre}

3. Verifique se o arquivo de configuração é aplicado.

   ```
   kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
   ```
   {: pre}

   Saída:
   ```
   Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

   Dados ====

    ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
   ```
   {: screen}
