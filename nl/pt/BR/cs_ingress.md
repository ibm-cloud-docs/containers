---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

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

## Configurando o acesso a um app usando Ingress
{: #config}

Exponha múltiplos apps em seu cluster criando recursos de Ingresso que são gerenciados pelo controlador de Ingresso fornecido pela IBM. O controlador do Ingress cria os recursos necessários para usar um balanceador de carga de aplicativo. Um balanceador de carga de aplicativo é um balanceador de carga HTTP ou HTTPS externo que usa um ponto de entrada público ou privado assegurado e exclusivo para rotear solicitações recebidas para seus apps dentro ou fora do cluster.

**Nota:** o Ingresso está disponível somente para clusters padrão e requer pelo menos dois nós do trabalhador no cluster para assegurar alta disponibilidade e que atualizações periódicas sejam aplicadas. Configurar o Ingresso requer uma [política de acesso de Administrador](cs_users.html#access_policies). Verifique sua [política de acesso](cs_users.html#infra_access) atual.

Ao criar um cluster padrão, o controlador de Ingress automaticamente cria e ativa um balanceador de carga de aplicativo que é designado um endereço IP público móvel e uma rota pública. Um balanceador de carga de aplicativo que é designado a um endereço IP privado móvel e a uma rota privada também é criado automaticamente, mas não é ativado automaticamente. É possível configurar esses balanceadores de carga de aplicativo e definir regras de roteamento individuais para cada app que você expõe ao público ou às redes privadas. Cada app que é exposto ao público por meio do Ingresso é designado a um caminho exclusivo que é anexado à rota pública, para que seja possível usar uma URL exclusiva para acessar um app de forma pública em seu cluster.

Para expor seu app ao público, é possível configurar o balanceador de carga de aplicativo público para os cenários a seguir.

-   [Expor apps de forma pública usando o domínio fornecido pela IBM sem TLS](#ibm_domain)
-   [Expor apps de forma pública usando o domínio fornecido pela IBM com TLS](#ibm_domain_cert)
-   [Expor apps de forma pública usando um domínio customizado com TLS](#custom_domain_cert)
-   [Expor apps de forma pública que estão fora de seu cluster usando o domínio fornecido pela IBM ou um customizado com TLS](#external_endpoint)

Para expor seu app a redes privadas, primeiro [ative o balanceador de carga do aplicativo privado](#private_ingress). É possível, em seguida, configurar o balanceador de carga de aplicativo privado para os cenários a seguir.

-   [Expor apps de forma privada usando um domínio customizado sem TLS](#private_ingress_no_tls)
-   [Expor apps de forma privada usando um domínio customizado com TLS](#private_ingress_tls)

Depois de ter exposto seu app de forma pública ou de forma privada, é possível configurar ainda mais seu balanceador de carga de aplicativo com as opções a seguir.

-   [Abrindo portas no balanceador de carga de aplicativo de Ingresso](#opening_ingress_ports)
-   [Configurar protocolos SSL e cifras SSL no nível de HTTP](#ssl_protocols_ciphers)
-   [Customizando o seu balanceador de carga de aplicativo com anotações](cs_annotations.html)
{: #ingress_annotation}

Para escolher a melhor configuração para o Ingress, é possível seguir esta árvore de decisão:

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="Esta imagem orienta na escolha da melhor configuração para seu controlador do Ingress. Se esta imagem não estiver sendo exibida, as informações ainda poderão ser encontradas na documentação." style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="Expondo apps de forma privada usando um domínio customizado sem TLS" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="Expondo apps de forma privada usando um domínio customizado com TLS" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="Expondo apps de forma pública que estão fora de seu cluster usando o domínio fornecido pela IBM ou um customizado com TLS" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="Expondo apps de forma pública usando um domínio customizado com TLS" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="Expondo apps de forma pública usando o domínio fornecido pela IBM sem TLS" shape="rect" coords="414, 609, 569, 659"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="Expondo apps de forma pública usando o domínio fornecido pela IBM com TLS" shape="rect" coords="563, 681, 716, 734"/>
</map>

<br />


## Expor apps de forma pública usando o domínio fornecido pela IBM sem TLS
{: #ibm_domain}

É possível configurar o balanceador de carga de aplicativo como um balanceador de carga de HTTP para os apps em seu cluster e usar o domínio fornecido pela IBM para acessar seus apps na Internet.

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para configurar o balanceador de carga do aplicativo:

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.
2.  Crie um serviço do Kubernetes para o app a ser exposto. O controlador do Ingresso poderá incluir o seu app no balanceamento de carga do Ingresso somente se o seu app for exposto por meio de um serviço do Kubernetes dentro do cluster.
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
        <caption>Entendendo os componentes de arquivo do serviço de balanceador de carga de aplicativo</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para o serviço de balanceador de carga de aplicativo.</td>
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
4.  Crie um recurso do Ingresso. Recursos de ingresso definem as regras de roteamento para o serviço de Kubernetes que você criou para o seu aplicativo
e são usados pelo balanceador de carga do aplicativo para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
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
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e para os Pods em
que o aplicativo está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br></br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.
        </br>
        Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        </br>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a [anotação de nova gravação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para seu app.</td>
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

<br />


## Expor apps publicamente usando o domínio fornecido pela IBM com TLS
{: #ibm_domain_cert}

É possível configurar o balanceador de carga de aplicativo para gerenciar conexões TLS recebidas para seus apps, decriptografar o tráfego de rede usando o certificado TLS fornecido pela IBM e encaminhar a solicitação não criptografada para os apps expostos em seu cluster.

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para configurar o balanceador de carga do aplicativo:

1.  [Implemente o seu app no cluster](cs_app.html#app_cli). Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo identifica todos os pods nos quais o app está em execução, para que sejam incluídos no balanceamento de carga do Ingresso.
2.  Crie um serviço do Kubernetes para o app a ser exposto. O balanceador de carga do aplicativo poderá incluir seu aplicativo no balanceamento de carga de Ingresso somente se o seu
aplicativo for exposto por meio de um serviço Kubernetes dentro do cluster.
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
        <caption>Entendendo os componentes de arquivo do serviço de balanceador de carga de aplicativo</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice&gt;</em> por um nome para o serviço de balanceador de carga de aplicativo.</td>
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

4.  Crie um recurso do Ingresso. Recursos de ingresso definem as regras de roteamento para o serviço de Kubernetes que você criou para o seu aplicativo
e são usados pelo balanceador de carga do aplicativo para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio fornecido pela IBM para rotear o tráfego de rede recebido para seus serviços e o certificado fornecido pela IBM para gerenciar o encerramento do TLS para você. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, `https://ingress_domain/myapp`. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e também para
os Pods em que o aplicativo está em execução.

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
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e para os Pods em
que o aplicativo está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br>
        Exemplos: <ul><li>Para <code>http://ingress_host_name/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a [anotação de nova gravação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para seu app.</td>
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

<br />


## Expor apps de forma pública usando um domínio customizado com TLS
{: #custom_domain_cert}

É possível configurar o balanceador de carga de aplicativo para rotear o tráfego de rede recebido para os apps em seu cluster e usar seu próprio certificado TLS para gerenciar a finalização do TLS, enquanto usa seu domínio customizado em vez do domínio fornecido pela IBM.
{:shortdesc}

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.

Para configurar o balanceador de carga do aplicativo:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) para registrar seu domínio customizado.
2.  Configure seu domínio para rotear o tráfego de rede recebido para o balanceador de carga de aplicativo fornecido pela IBM. Escolha entre estas opções:
    -   Defina um alias para seu domínio customizado especificando o domínio fornecido pela IBM como um registro de Nome Canônico (CNAME). Para localizar o domínio de Ingresso fornecido pela IBM, execute `bx cs cluster-get <mycluster>` e procure o campo **Subdomínio do Ingresso**.
    -   Mapeie o seu domínio customizado para o endereço IP público móvel do balanceador de carga de aplicativo fornecido pela IBM, incluindo o endereço IP como um registro. Para localizar o endereço IP público móvel do balanceador de carga de aplicativo, execute `bx cs alb-se <public_alb_ID>`.
3.  Importe ou crie um certificado TLS e a chave secreta.
    * Se você já tem um certificado TLS armazenado no {{site.data.keyword.cloudcerts_long_notm}} que deseja usar, é possível importar seu segredo associado para o cluster executando o comando a seguir:

          ```
          bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
          ```
          {: pre}
    * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2.  Abra o seu editor preferencial e crie um arquivo de configuração de segredo do Kubernetes que seja chamado, por exemplo, de `mysecret.yaml`.
        3.  Defina um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;mytlssecret&gt;</em> por um nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> com o caminho
para o seu arquivo-chave TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> com o caminho para o seu arquivo de certificado TLS
customizado.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

        4.  Salve seu arquivo de configuração.
        5.  Crie o segredo do TLS para seu cluster.

            ```
            kubectl apply -f mysecret.yaml
            ```
            {: pre}

4.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.

5.  Crie um serviço do Kubernetes para o app a ser exposto. O balanceador de carga do aplicativo poderá incluir seu aplicativo no balanceamento de carga de Ingresso somente se o seu
aplicativo for exposto por meio de um serviço Kubernetes dentro do cluster.

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
        <caption>Entendendo os componentes de arquivo do serviço de balanceador de carga de aplicativo</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para o serviço de balanceador de carga de aplicativo.</td>
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
6.  Crie um recurso do Ingresso. Recursos de ingresso definem as regras de roteamento para o serviço de Kubernetes que você criou para o seu aplicativo
e são usados pelo balanceador de carga do aplicativo para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que use o domínio customizado para rotear o tráfego de rede recebido para seus serviços e o certificado customizado para gerenciar o encerramento do TLS. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, `https://mydomain/myapp`. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e também para
os Pods em que o aplicativo está em execução.

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
        <td>Substitua <em>&lt;mytlssecret&gt;</em> pelo nome do segredo que você criou anteriormente que retém seu certificado e chave TLS customizados. Se você importar um certificado do {{site.data.keyword.cloudcerts_short}}, execute <code>bx cs alb-cert-get --cluster < cluster_name_or_ID> -- cert-crn < certificate_crn></code> para ver os segredos associados a um certificado TLS.
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
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e para os Pods em
que o aplicativo está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a [anotação de nova gravação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para seu app.
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

    **Nota:** pode levar alguns minutos para que o recurso de Ingresso seja criado corretamente e para que o app fique disponível na Internet pública.

8.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


## Expor apps de forma pública que estão fora de seu cluster usando o domínio fornecido pela IBM ou um customizado com TLS
{: #external_endpoint}

É possível configurar o balanceador de carga de aplicativo para apps que estão localizados fora do cluster a serem incluídos no balanceamento de carga do cluster. As solicitações recebidas no domínio customizado ou fornecido pela IBM são encaminhadas automaticamente para o app externo.

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster para executar comandos `kubectl`.
-   Assegure-se de que o app externo que você deseja incluir no balanceamento de carga do cluster possa ser acessado usando um endereço IP público.

É possível configurar o balanceador de carga de aplicativo para rotear o tráfego de rede recebido no domínio fornecido pela IBM para apps que estão localizados fora do cluster. Se desejar usar um domínio customizado e um certificado TLS como alternativa, substitua o domínio fornecido pela IBM e o certificado TLS pelo seu [domínio customizado e certificado TLS](#custom_domain_cert).

1.  Configure um terminal do Kubernetes que defina o local externo do app que você deseja incluir no balanceamento de carga do cluster.
    1.  Abra seu editor preferencial e crie um arquivo de configuração do terminal que é chamado, por exemplo, de `myexternalendpoint.yaml`.
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
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
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
    1.  Abra seu editor preferencial e crie um arquivo de configuração de serviço que seja chamado, por exemplo, de `myexternalservice.yaml`.
    2.  Defina o serviço de balanceador de carga de aplicativo.

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
        <caption>Entendendo os componentes de arquivo do serviço de balanceador de carga de aplicativo</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Substitua <em>&lt;myexternalservice&gt;</em> pelo nome de seu serviço de balanceador de carga de aplicativo.</td>
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

4.  Crie um recurso do Ingresso. Recursos de ingresso definem as regras de roteamento para o serviço de Kubernetes que você criou para o seu aplicativo
e são usados pelo balanceador de carga do aplicativo para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps externos desde que cada app seja exposto com o seu terminal externo por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra seu editor preferencial e crie um arquivo de configuração do Ingresso que seja chamado, por exemplo, de `myexternalingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio fornecido pela IBM e o certificado TLS para rotear o tráfego de rede recebido para seu app externo usando o terminal externo que você definiu anteriormente. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio customizado ou fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, `https://ingress_domain/myapp`. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga de aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e, além disso, para o app externo.

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
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, <code>https://ibmdomain/myservicepath1</code>. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga de aplicativo procura o serviço associado e envia tráfego de rede para o app externo usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br></br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a [anotação de nova gravação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para seu app.</td>
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

<br />


## Ativando o balanceador de carga de aplicativo privado
{: #private_ingress}

Ao criar um cluster padrão, o controlador do Ingress cria automaticamente um balanceador de carga de aplicativo privado, mas não o ativa automaticamente. Antes de poder usar o balanceador de carga de aplicativo privado, deve-se ativá-lo com o endereço IP privado pré-designado, móvel, fornecido pela IBM ou seu próprio endereço IP privado móvel. **Observação**: se você usou a sinalização `-- no-subnet` quando criou o cluster, então deve-se incluir uma sub-rede privada móvel ou uma sub-rede gerenciada pelo usuário antes de poder ativar o balanceador de carga de aplicativo privado. Para obter mais informações, veja [Solicitando sub-redes adicionais para seu cluster](cs_subnets.html#request).

Antes de iniciar:

-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui).
-   [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para ativar o balanceador de carga do aplicativo privado usando o endereço IP privado móvel pré-designado e fornecido pela IBM:

1. Liste os balanceadores de carga de aplicativos disponíveis em seu cluster para obter o ID do balanceador de carga de aplicativo privado. Substitua <em>&lt;cluser_name&gt;</em> pelo nome do cluster no qual o app que você deseja expor está implementado.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    O campo **Status** para o balanceador de carga do aplicativo privado está _desativado_.
    ```
    ALB ID Enabled Status Type ALB IP private-cr6d779503319d419ea3b4ab171d12c3b8-alb1 false disabled private - public-cr6d779503319d419ea3b4ab171d12c3b8-alb1 true enabled public 169.46.63.150
    ```
    {: screen}

2. Ativar o balanceador de carga de aplicativo privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID para o balanceador de carga de aplicativo privado da saída na etapa anterior.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Para ativar o balanceador de carga de aplicativo privado usando seu próprio endereço IP privado móvel:

1. Configure a sub-rede gerenciada pelo usuário de seu endereço IP escolhido para rotear o tráfego na VLAN privada do seu cluster. Substitua <em>&lt;cluser_name&gt;</em> pelo nome ou ID do cluster no qual o app que você deseja expor está implementado, <em>&lt;subnet_CIDR&gt;</em> pelo CIDR de sua sub-rede gerenciada pelo usuário e <em>&lt;private_VLAN&gt;</em> por um ID de VLAN privada disponível. É possível localizar o ID de uma VLAN privada disponível executando `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Liste os balanceadores de carga de aplicativos disponíveis em seu cluster para obter o ID de balanceador de carga de aplicativo privado.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    O campo **Status** para o balanceador de carga do aplicativo privado está _desativado_.
    ```
    ALB ID Enabled Status Type ALB IP private-cr6d779503319d419ea3b4ab171d12c3b8-alb1 false disabled private - public-cr6d779503319d419ea3b4ab171d12c3b8-alb1 true enabled public 169.46.63.150
    ```
    {: screen}

3. Ativar o balanceador de carga de aplicativo privado. Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID para o balanceador de carga de aplicativo privado da saída na etapa anterior e <em>&lt;user_ip&gt;</em> com o endereço IP de sua sub-rede gerenciada pelo usuário gerenciado que você deseja usar.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

<br />


## Expor apps de forma privada usando um domínio customizado sem TLS
{: #private_ingress_no_tls}

É possível configurar o balanceador de carga de aplicativo privado para rotear o tráfego de rede recebido para os apps em seu cluster usando um domínio customizado.
{:shortdesc}

Antes de iniciar, [ative o balanceador de carga do aplicativo privado](#private_ingress).

Para configurar o balanceador de carga de aplicativo privado:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) para registrar seu domínio customizado.

2.  Mapeie seu domínio customizado para o endereço IP privado móvel do balanceador de carga do aplicativo privado fornecido pela
IBM incluindo o endereço IP como um registro. Para localizar o endereço IP privado móvel do balanceador de carga do aplicativo privado, execute `bx cs albs --cluster <cluster_name>`.

3.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.

4.  Crie um serviço do Kubernetes para o app a ser exposto. O balanceador de carga do aplicativo privado poderá incluir seu aplicativo no balanceamento de carga de Ingresso somente se o seu
aplicativo for exposto por meio de um serviço Kubernetes dentro do cluster.

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
        <caption>Entendendo os componentes de arquivo do serviço de balanceador de carga de aplicativo</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para o serviço de balanceador de carga de aplicativo.</td>
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
7.  Crie um recurso do Ingresso. Recursos de ingresso definem as regras de roteamento para o serviço de Kubernetes que você criou para o seu aplicativo
e são usados pelo balanceador de carga do aplicativo para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que usa o domínio customizado para rotear o tráfego de rede recebido para seus serviços. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, `https://mydomain/myapp`. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e também para
os Pods em que o aplicativo está em execução.

        **Nota:** é importante que o app atenda no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede não poderá ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

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
        <td>Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID do ALB para o seu controlador de Ingresso privado. Execute <code>bx cs albs --cluster <my_cluster></code> para localizar o ID do ALB. Para obter mais informações sobre essa anotação de Ingresso, veja [Roteamento do balanceador de carga de aplicativo privado](cs_annotations.html#alb-id).</td>
        </tr>
        <td><code>host</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo <code>custom_domain/myservicepath1</code>. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e para os Pods em
que o aplicativo está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a [anotação de nova gravação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para seu app.
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

8.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua <em>&lt;myingressname&gt;</em> pelo nome do recurso de Ingresso que você criou na etapa anterior.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** pode levar alguns segundos para o recurso de Ingresso ser criado corretamente e para que o app fique disponível.

9.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


## Expor apps de forma privada usando um domínio customizado com TLS
{: #private_ingress_tls}

É possível configurar o balanceador de carga de aplicativo privado para rotear o tráfego de rede recebido para os apps em seu cluster e usar seu próprio certificado TLS para gerenciar a finalização do TLS, enquanto usa seu domínio customizado.
{:shortdesc}

Antes de iniciar, [ative o balanceador de carga do aplicativo privado](#private_ingress).

Para configurar o balanceador de carga do aplicativo:

1.  Crie um domínio customizado. Para criar um domínio customizado, trabalhe com seu provedor Domain Name Service (DNS) para registrar seu domínio customizado.

2.  Mapeie seu domínio customizado para o endereço IP privado móvel do balanceador de carga do aplicativo privado fornecido pela
IBM incluindo o endereço IP como um registro. Para localizar o endereço IP privado móvel do balanceador de carga do aplicativo privado, execute `bx cs albs --cluster <cluster_name>`.

3.  Importe ou crie um certificado TLS e a chave secreta.
    * Se você já tiver um certificado TLS armazenado no {{site.data.keyword.cloudcerts_long_notm}} que deseja usar, é possível importar seu segredo associado para o cluster executando `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * Se você não tiver um certificado TLS pronto, siga estas etapas:
        1. Crie um certificado e chave TLS para seu domínio que é codificado no formato PEM.
        2.  Abra o seu editor preferencial e crie um arquivo de configuração de segredo do Kubernetes que seja chamado, por exemplo, de `mysecret.yaml`.
        3.  Defina um segredo que use seu certificado e chave do TLS. Substitua <em>&lt;mytlssecret&gt;</em> por um nome para o seu segredo do Kubernetes, <em>&lt;tls_key_filepath&gt;</em> com o caminho
para o seu arquivo-chave TLS customizado e <em>&lt;tls_cert_filepath&gt;</em> com o caminho para o seu arquivo de certificado TLS
customizado.

            ```
            kubectl create secret tls <mytlssecret> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}

        4.  Salve seu arquivo de configuração.
        5.  Crie o segredo do TLS para seu cluster.

            ```
            kubectl apply -f mysecret.yaml
            ```
            {: pre}

4.  [Implemente o seu app no cluster](cs_app.html#app_cli). Quando você implementa o seu app no cluster, são criados para você um ou mais pods que executam o seu app em um contêiner. Certifique-se de incluir um rótulo à sua implementação na seção de metadados de seu arquivo de configuração. Esse rótulo é necessário para identificar todos os pods nos quais o seu app está em execução, de modo que eles possam ser incluídos no balanceamento de carga do Ingresso.

5.  Crie um serviço do Kubernetes para o app a ser exposto. O balanceador de carga do aplicativo privado poderá incluir seu aplicativo no balanceamento de carga de Ingresso somente se o seu
aplicativo for exposto por meio de um serviço Kubernetes dentro do cluster.

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
        <caption>Entendendo os componentes de arquivo do serviço de balanceador de carga de aplicativo</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Substitua <em>&lt;myservice1&gt;</em> por um nome para o serviço de balanceador de carga de aplicativo.</td>
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
6.  Crie um recurso do Ingresso. Recursos de ingresso definem as regras de roteamento para o serviço de Kubernetes que você criou para o seu aplicativo
e são usados pelo balanceador de carga do aplicativo para rotear o tráfego de rede recebido para o serviço. Será possível usar um recurso do Ingresso para definir regras de roteamento para múltiplos apps desde que cada app seja exposto por meio de um serviço do Kubernetes dentro do cluster.
    1.  Abra o seu editor preferencial e crie um arquivo de configuração Ingresso que seja denominado, por exemplo, `myingress.yaml`.
    2.  Defina um recurso do Ingresso em seu arquivo de configuração que use o domínio customizado para rotear o tráfego de rede recebido para seus serviços e o certificado customizado para gerenciar o encerramento do TLS. Para cada serviço, é possível definir um caminho individual que seja anexado ao domínio customizado para criar um caminho exclusivo para seu app, por exemplo, `https://mydomain/myapp`. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e também para
os Pods em que o aplicativo está em execução.

        **Nota:** é importante que o app atenda no caminho definido no recurso de Ingresso. Caso contrário, o tráfego de rede


        não pode ser encaminhado para o app. A maioria dos apps não atende em um caminho específico, mas usa o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como `/` e não especifique um caminho individual para seu app.

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
        <td>Substitua <em>&lt;private_ALB_ID&gt;</em> pelo ID para o seu balanceador de carga de aplicativo privado. Execute <code>bx cs albs --cluster <my_cluster></code> para localizar o ID do balanceador de carga do aplicativo. Para obter mais informações sobre essa anotação do Ingress, consulte [Roteamento do balanceador de carga do aplicativo privado (ALB-ID)](cs_annotations.html#alb-id).</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Substitua <em>&lt;mycustomdomain&gt;</em> pelo seu domínio customizado que você deseja configurar para finalização do TLS.

        </br></br>
        <strong>Nota:</strong> não use &ast; para o seu host ou deixe a propriedade do host vazia para evitar falhas durante a criação do Ingresso.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Substitua <em>&lt;mytlssecret&gt;</em> pelo nome do segredo que você criou anteriormente e que retém o seu certificado e chave TLS customizados. Se você importar um certificado do {{site.data.keyword.cloudcerts_short}}, execute <code>bx cs alb-cert-get --cluster < cluster_name_or_ID> -- cert-crn < certificate_crn></code> para ver os segredos associados a um certificado TLS.
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
        <td>Substitua <em>&lt;myservicepath1&gt;</em> por uma barra ou pelo caminho exclusivo no qual seu app está atendendo, para que o tráfego de rede possa ser encaminhado para o app.

        </br>
        Para cada serviço do Kubernetes, é possível definir um caminho individual que seja anexado ao domínio fornecido pela IBM para criar um caminho exclusivo para seu app, por exemplo, <code>ingress_domain/myservicepath1</code>. Ao inserir essa rota em um navegador da web, o tráfego de rede é roteado para o balanceador de carga do aplicativo. O balanceador de carga do aplicativo consulta o serviço associado e envia o tráfego de rede para o serviço e para os Pods em
que o aplicativo está em execução usando o mesmo caminho. O app deve ser configurado para atender nesse caminho para receber o tráfego de rede de entrada.

        </br>
        Muitos apps não atendem em um caminho específico, mas usam o caminho raiz e uma porta específica. Nesse caso, defina o caminho raiz como <code>/</code> e não especifique um caminho individual para seu app.

        </br></br>
        Exemplos: <ul><li>Para <code>https://mycustomdomain/</code>, insira <code>/</code> como o caminho.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, insira <code>/myservicepath</code> como o caminho.</li></ul>
        <strong>Dica:</strong> se desejar configurar seu Ingresso para atender em um caminho que seja diferente daquele no qual seu app atende, será possível usar a [anotação de nova gravação](cs_annotations.html#rewrite-path) para estabelecer o roteamento adequado para seu app.
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

7.  Verifique se o recurso de Ingresso foi criado com êxito. Substitua <em>&lt;myingressname&gt;</em> pelo nome do recurso de Ingresso que você criou anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** pode levar alguns segundos para o recurso de Ingresso ser criado corretamente e para que o app fique disponível.

8.  Acesse seu app na Internet.
    1.  Abra seu navegador da web preferencial.
    2.  Insira a URL do serviço de app que você deseja acessar.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

<br />


## Abrindo portas no balanceador de carga de aplicativo de Ingresso
{: #opening_ingress_ports}

Por padrão, somente as portas 80 e 443 são expostas no balanceador de carga de aplicativo de Ingresso. Para expor outras portas, é possível editar o recurso de mapa de configuração `ibm-cloud-provider-ingress-cm`.

1.  Crie uma versão local do arquivo de configuração para o recurso de mapa de configuração `ibm-cloud-provider-ingress-cm`. Inclua uma seção <code>data</code> seção e especifique as portas públicas 80, 443 e quaisquer outras portas que você deseja incluir no arquivo de mapa de configuração separadas por um ponto e vírgula (;).

 Nota: ao especificar as portas, 80 e 443 também deverão ser incluídas para manter essas portas abertas. Qualquer porta não especificada será encerrada.

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

Para obter mais informações sobre recursos de mapa de configuração, veja a [documentação do Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).

<br />


## Configurando protocolos SSL e cifras SSL no nível de HTTP
{: #ssl_protocols_ciphers}

Ative os protocolos e cifras SSL no nível HTTP global editando o mapa de configuração `ibm-cloud-provider-ingress-cm`.

Por padrão, os valores a seguir são usados para ssl-protocols e ssl-ciphers:

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

Para obter mais informações sobre esses parâmetros, veja a documentação do NGINX para [ssl-protocols ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols) e [ssl-ciphers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers).

Para mudar os valores padrão:
1. Crie uma versão local do arquivo de configuração para o recurso de mapa de configuração ibm-cloud-provider-ingress-cm

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
