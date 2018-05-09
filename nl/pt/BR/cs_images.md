---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Construindo contêineres de imagens
{: #images}

Uma imagem do Docker é a base para cada contêiner que você cria com o {{site.data.keyword.containerlong}}.
{:shortdesc}

Uma imagem é criada por meio de um Dockerfile, que é um arquivo que contém instruções para construir a imagem. Um Dockerfile pode
referenciar os artefatos de construção em suas instruções que são armazenadas separadamente, como um app, a configuração
do app e suas dependências.



## Planejando registros de imagem
{: #planning}

As imagens geralmente são armazenadas em um registro que pode ser acessado pelo público (registro público) ou configurado com acesso
limitado para um pequeno grupo de usuários (registro privado). 
{:shortdesc}

Os registros
públicos, como Docker Hub, podem ser usados na introdução ao Docker e Kubernetes para criar seu
primeiro app conteinerizado em um cluster. Mas quando se trata de aplicativos corporativos, use um registro
privado como aquele fornecido no {{site.data.keyword.registryshort_notm}} para proteger suas imagens de serem usadas
e mudadas por usuários não autorizados. Os registros
privados devem ser configurados pelo administrador de cluster para assegurar que as credenciais para acessar o registro
privado estejam disponíveis para os usuários do cluster.


É possível usar múltiplos registros com o {{site.data.keyword.containershort_notm}} para implementar apps em seu cluster.

|Registro|Descrição|Benefício|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|Com essa opção, é possível configurar o seu próprio repositório de imagem do Docker seguro no {{site.data.keyword.registryshort_notm}} no qual é possível armazenar e compartilhar as imagens com segurança entre
usuários do cluster.|<ul><li>Gerencie o acesso a imagens em sua conta.</li><li>Use imagens e apps de amostra fornecidos pela {{site.data.keyword.IBM_notm}}, como o {{site.data.keyword.IBM_notm}} Liberty, como uma imagem pai e inclua seu próprio código de app nela.</li><li>Varredura automática de imagens para potenciais vulnerabilidades pelo Vulnerability Advisor, incluindo
recomendações específicas do S.O. para corrigi-las.</li></ul>|
|Qualquer outro registro privado|Conecte qualquer registro privado existente a seu cluster criando um [imagePullSecret ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/containers/images/). O segredo é usado para salvar com segurança sua URL de registro e credenciais em um
segredo do Kubernetes.|<ul><li>Use os registros privados existentes independentemente de sua origem (Docker Hub, registros pertencentes
à organização ou outros registros de Nuvem privada).</li></ul>|
|Docker Hub público|Use essa opção para usar imagens públicas existentes diretamente do Docker Hub quando nenhuma mudança
do Dockerfile for necessária. <p>**Nota:** lembre-se de que essa opção poderá não atender aos requisitos de segurança de sua organização, como gerenciamento de acesso, varredura de vulnerabilidade ou privacidade de app.</p>|<ul><li>Nenhuma configuração adicional é necessária para seu cluster.</li><li>Inclui uma variedade de aplicativos de software livre.</li></ul>|
{: caption="Tabela. Opções de registro de imagem pública e privada" caption-side="top"}

Depois de configurar um registro de imagem, os usuários do cluster podem usar as imagens para suas implementações de app
no cluster.


<br />



## Acessando um namespace no {{site.data.keyword.registryshort_notm}}
{: #namespace}

É possível implementar contêineres em seu cluster de uma imagem pública fornecida pela IBM ou de uma imagem privada que é armazenada em seu namespace no {{site.data.keyword.registryshort_notm}}.
{:shortdesc}

Antes de iniciar:

1. [Configure um namespace no {{site.data.keyword.registryshort_notm}} no {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_dedicated_notm}} e envie por push imagens para esse namespace](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Crie um cluster](cs_clusters.html#clusters_cli).
3. [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Ao criar um cluster, segredos e tokens de registro sem expiração são criados automaticamente para o [registro regional mais próximo e o registro global](/docs/services/Registry/registry_overview.html#registry_regions). O registro global armazena com segurança as imagens públicas fornecidas pela IBM às quais é possível se referir em suas implementações em vez de ter referências diferentes para imagens que são armazenadas em cada registro regional. O registro regional armazena com segurança suas próprias imagens privadas do Docker, bem como as mesmas imagens públicas que são armazenadas no registro global. Os tokens são usados para autorizar acesso somente leitura a qualquer um dos namespaces que você configurou no {{site.data.keyword.registryshort_notm}} para que possa trabalhar com essas imagens públicas (registro global) e privadas (registros regionais).

Cada token deve ser armazenado em um `imagePullSecret` do Kubernetes para que ele seja acessível para um cluster do Kubernetes quando você implementa um app conteinerizado. Quando o cluster é criado, o {{site.data.keyword.containershort_notm}} armazena automaticamente os tokens para os registros globais (imagens públicas fornecidas pela IBM) e regionais nos segredos de pull de imagem do Kubernetes. Os segredos de pull de imagem são incluídos no namespace do Kubernetes `default`, na lista padrão de segredos no `ServiceAccount` para esse namespace e no namespace `kube-system`.

**Nota:** ao usar essa configuração inicial, será possível implementar contêineres de qualquer imagem que estiver disponível em um namespace na conta do {{site.data.keyword.Bluemix_notm}} no namespace **padrão** do cluster. Se você deseja implementar um contêiner em outros namespaces de seu cluster ou se deseja usar uma imagem que está armazenada em outra região do {{site.data.keyword.Bluemix_notm}} ou em outra conta do {{site.data.keyword.Bluemix_notm}}, deve-se [criar seu próprio imagePullSecret para o cluster](#other).

Para implementar um contêiner no namespace **padrão** de seu cluster, crie um arquivo de configuração.

1.  Crie um arquivo de configuração de implementação que é chamado de `mydeployment.yaml`.
2.  Defina a implementação e a imagem que você deseja usar por meio de seu namespace no {{site.data.keyword.registryshort_notm}}.

    Para usar uma imagem privada de um namespace no {{site.data.keyword.registryshort_notm}}:

    ```
    apiVersion: apps/v1beta1
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
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}


<br />



## Acessando imagens em outros namespaces do Kubernetes, regiões do {{site.data.keyword.Bluemix_notm}} e contas
{: #other}

É possível implementar contêineres em outros namespaces do Kubernetes, usar imagens armazenadas em outras regiões ou contas do {{site.data.keyword.Bluemix_notm}} ou usar imagens armazenadas no {{site.data.keyword.Bluemix_dedicated_notm}} criando o seu próprio imagePullSecret.
{:shortdesc}

Antes de iniciar:

1.  [Configure um namespace no {{site.data.keyword.registryshort_notm}} no {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_dedicated_notm}} e envie por push imagens para esse namespace](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Crie um cluster](cs_clusters.html#clusters_cli).
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
    <caption>Tabela. Entendendo os componentes deste comando</caption>
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
        <caption>Tabela. Entendendo os componentes de arquivo YAML</caption>
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


<br />



## Acessando imagens públicas do Docker Hub
{: #dockerhub}

É possível usar qualquer imagem pública que esteja armazenada no Docker Hub para implementar um contêiner em seu
cluster sem nenhuma configuração adicional.
{:shortdesc}

Antes de iniciar:

1.  [Crie um cluster](cs_clusters.html#clusters_cli).
2.  [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Crie um arquivo de configuração de implementação.

1.  Crie um arquivo de configuração que é denominado `mydeployment.yaml`.
2.  Defina a implementação e a imagem pública do Docker Hub que você deseja usar. O arquivo de configuração a seguir usa a imagem pública NGINX disponível no Docker Hub.

    ```
    apiVersion: apps/v1beta1
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
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}

<br />



## Acessando imagens que são armazenadas em outros registros privados
{: #private_images}

Se você já tem um registro privado para uso, deve-se armazenar as credenciais de registro em um imagePullSecret do Kubernetes e referenciar esse segredo em seu arquivo de configuração.
{:shortdesc}

Antes de iniciar:

1.  [Crie um cluster](cs_clusters.html#clusters_cli).
2.  [Destine sua CLI para seu cluster](cs_cli_install.html#cs_cli_configure).

Para criar um imagePullSecret:

**Nota:** os ImagePullSecrets são válidos para os namespaces do Kubernetes para os quais foram criados. Repita essas etapas para cada namespace no qual você deseja implementar contêineres de uma imagem em um registro privado do {{site.data.keyword.Bluemix_notm}}.

1.  Crie o segredo do Kubernetes para armazenar suas credenciais de registro privado.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabela. Entendendo os componentes deste comando</caption>
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
        <caption>Tabela. Entendendo os componentes de arquivo YAML</caption>
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
