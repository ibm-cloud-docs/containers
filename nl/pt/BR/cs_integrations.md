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




# Integrando Serviços
{: #integrations}

É possível usar vários serviços externos e serviços de catálogo com um cluster do Kubernetes padrão no {{site.data.keyword.containerlong}}.
{:shortdesc}


## Serviços de aplicativos
{: #application_services}
<table summary="Resumo para acessibilidade">
<caption>Serviços de aplicativos</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.blockchainfull}}</td>
<td>Implementar um ambiente de desenvolvimento publicamente disponível para o IBM Blockchain para um cluster do Kubernetes no {{site.data.keyword.containerlong_notm}}. Use esse ambiente para desenvolver e customizar sua própria rede de blockchain para implementar apps que compartilham um livro razão imutável para registrar o histórico de transações. Para obter mais informações, veja <a href="https://ibm-blockchain.github.io" target="_blank">Desenvolver em um ambiente de simulação de nuvem
IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Serviços DevOps
{: #devops_services}
<table summary="Resumo para acessibilidade">
<caption>Serviços DevOps</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>É possível usar o <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para a integração e entrega contínua de contêineres. Para obter mais informações, veja <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Usando o Codeship Pro para implementar cargas de trabalho no {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">O Helm <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> é um gerenciador de pacote do Kubernetes. É possível criar novos gráficos Helm ou usar gráficos Helm preexistente para definir, instalar e fazer upgrade de aplicativos complexos do Kubernetes que são executados em clusters do {{site.data.keyword.containerlong_notm}}. <p>Para obter mais informações, veja [Configurando o Helm no {{site.data.keyword.containerlong_notm}}](cs_integrations.html#helm).</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>Automatize as construções de app e as implementações do contêiner para clusters do Kubernetes usando uma cadeia de ferramentas. Para obter informações de configuração, consulte o blog <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Implementar pods do Kubernetes no {{site.data.keyword.containerlong_notm}} usando DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td>O <a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> é um serviço de software livre que fornece aos desenvolvedores uma maneira de conectar, proteger, gerenciar e monitorar uma rede de microsserviços, também conhecida como rede de serviços, em plataformas de orquestração de nuvem como o Kubernetes. Confira a postagem do blog sobre <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">como a IBM cofundou e lançou o Istio<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para descobrir mais sobre o projeto de software livre. Para instalar o Istio em seu cluster do Kubernetes no {{site.data.keyword.containerlong_notm}} e começar com um aplicativo de amostra, consulte [Tutorial: Gerenciando microsserviços com o Istio](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
</tbody>
</table>

<br />



## Serviços de criação de log e de monitoramento
{: #health_services}
<table summary="Resumo para acessibilidade">
<caption>Serviços de criação de log e de monitoramento</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td>Monitore nós do trabalhado, contêineres, conjuntos de réplicas, controladores de replicação e serviços com o <a href="https://www.coscale.com/" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. Para obter mais informações, veja <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitorando o {{site.data.keyword.containerlong_notm}} com o CoScale <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Datadog</td>
<td>Monitore seu cluster e visualize as métricas de desempenho da infraestrutura e do aplicativo com o <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. Para obter mais informações, veja <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitorando o {{site.data.keyword.containerlong_notm}} com o Datadog <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td> {{site.data.keyword.cloudaccesstrailfull}}</td>
<td>Monitore a atividade administrativa feita em seu cluster, analisando logs por meio do Grafana. Para obter mais informações sobre o serviço, consulte a documentação do [Activity Tracker](/docs/services/cloud-activity-tracker/index.html). Para obter mais informações sobre os tipos de eventos que podem ser rastreados, consulte [Eventos do Activity Tracker](/cs_at_events.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>Expanda as capacidades de coleção de logs, retenção e procura com o {{site.data.keyword.loganalysisfull_notm}}. Para obter mais informações, veja <a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">Ativando a coleta automática de logs de cluster <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>Expanda as capacidades de coleção e retenção de métricas definindo regras e alertas com o {{site.data.keyword.monitoringlong_notm}}. Para obter mais informações, veja <a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">Analisar métricas em Grafana para um app que é implementado em um cluster do Kubernetes <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> O <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> fornece monitoramento de desempenho de infraestrutura e app com uma GUI que descobre automaticamente e mapeia seus apps. O Istana captura cada solicitação para seus apps, que é possível usar para solucionar problemas e executar análise de causa raiz para evitar que os problemas aconteçam novamente. Verifique a postagem do blog sobre <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">implementando o Istana no {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para saber mais.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>O Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada especificamente para o Kubernetes. O Prometheus recupera informações detalhadas sobre o cluster, os nós do trabalhador e o funcionamento de implementação com base nas informações de criação de log do Kubernetes. A atividade de CPU, memória, E/S e rede é coletada para cada contêiner em execução em um cluster. É possível usar os dados coletados em consultas ou alertas customizados para monitorar o desempenho e as cargas de trabalho em seu cluster.

<p>Para usar o Prometheus, siga as <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">instruções do CoreOS <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td>Visualize métricas e logs para seus aplicativos conteinerizados usando o <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. Para obter mais informações, veja <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Monitoramento e criação de log para contêineres com o Sematext <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Sysdig</td>
<td>Capture métricas do app, contêiner, statsd e host com um único ponto de instrumentação usando o <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. Para obter mais informações, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitorando o {{site.data.keyword.containerlong_notm}} com o Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Weave Scope</td>
<td>O Weave Scope fornece um diagrama visual de seus recursos dentro de um cluster do Kubernetes, incluindo serviços, pods, contêineres, processos, nós e muito mais. O Weave Scope fornece métricas interativas para CPU e memória e também fornece ferramentas para uso de tail e executável em um contêiner.<p>Para obter mais informações, veja [Visualizando os recursos de cluster do Kubernetes com o Weave Scope e o {{site.data.keyword.containerlong_notm}}](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Serviços de segurança
{: #security_services}
<table summary="Resumo para acessibilidade">
<caption>Serviços de segurança</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>Inclua um nível de segurança para seus apps com [{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted), requerendo que os usuários se conectem. Para autenticar solicitações HTTP/HTTPS da web ou da API para seu app, é possível integrar o {{site.data.keyword.appid_short_notm}} com seu serviço de Ingresso usando a [anotação de Ingresso de autenticação do {{site.data.keyword.appid_short_notm}}](cs_annotations.html#appid-auth).</td>
  </tr>
<tr>
<td>Aqua Security</td>
  <td>Como um suplemento para o <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a>, é possível usar o <a href="https://www.aquasec.com/" target="_blank">Aqua Security <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para melhorar a segurança de implementações de contêiner, reduzindo o que seu app pode fazer. Para obter mais informações, consulte <a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Protegendo implementações de contêiner no {{site.data.keyword.Bluemix_notm}} com Aqua Security <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td>É possível usar o <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para armazenar e gerenciar certificados SSL para seus apps. Para obter mais informações, consulte <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Usar o {{site.data.keyword.cloudcerts_long_notm}} com o {{site.data.keyword.containerlong_notm}} para implementar certificados TLS de domínio customizado <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>Configure o seu próprio repositório de imagem assegurado do Docker no qual é possível armazenar e compartilhar imagens com segurança entre usuários do cluster. Para obter mais informações, veja a documentação do <a href="/docs/services/Registry/index.html" target="_blank">{{site.data.keyword.registrylong}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</td>
</tr>
<tr>
<td>NeuVector</td>
<td>Proteja os contêineres com um firewall de nuvem nativa usando o <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. Para obter mais informações, veja <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
<tr>
<td>Twistlock</td>
<td>Como um suplemento para o <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a>, é possível usar o <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para gerenciar firewalls, proteção de ameaça e resposta de incidente. Para obter mais informações, consulte <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock no {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Serviços de Armazenamento
{: #storage_services}
<table summary="Resumo para acessibilidade">
<caption>Serviços de Armazenamento</caption>
<thead>
<tr>
<th>Serviço</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio a Arca</td>
  <td>É possível usar o <a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> para fazer backup e restaurar recursos de cluster e volumes persistentes. Para obter mais informações, veja o Heptio Ark <a href="https://github.com/heptio/ark/blob/master/docs/use-cases.md#use-cases" target="_blank">Usar casos para recuperação de desastre e migração de cluster <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>Os dados armazenados com o {{site.data.keyword.cos_short}} são criptografados e dispersos em múltiplas localizações geográficas e acessados por HTTP usando uma API de REST. É possível usar [ibm-backup-restore image](/docs/services/RegistryImages/ibm-backup-restore/index.html) para configurar o serviço para fazer backups únicos ou planejados para dados em seus clusters. Para obter informações gerais sobre o serviço, veja a documentação do <a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">{{site.data.keyword.cos_short}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>O {{site.data.keyword.cloudant_short_notm}} é um Banco de dados como um serviço (DBaaS) orientado por documento que armazena dados como documentos no formato JSON. O serviço é construído para escalabilidade, alta disponibilidade e durabilidade. Para obter mais informações, veja a documentação do <a href="/docs/services/Cloudant/getting-started.html" target="_blank">{{site.data.keyword.cloudant_short_notm}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>O {{site.data.keyword.composeForMongoDB}} entrega alta disponibilidade e redundância, backups contínuos automatizados e sob demanda, ferramentas de monitoramento, integração em sistemas de alerta, visualizações de análise de desempenho e mais. Para obter mais informações, veja a documentação do <a href="/docs/services/ComposeForMongoDB/index.html" target="_blank">{{site.data.keyword.composeForMongoDB}} <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.</td>
  </tr>
</tbody>
</table>


<br />



## Incluindo serviços do {{site.data.keyword.Bluemix_notm}} nos clusters
{: #adding_cluster}

Inclua serviços do {{site.data.keyword.Bluemix_notm}} para aprimorar o cluster do Kubernetes com recursos extras em áreas como Watson AI, dados, segurança e Internet of Things (IoT).
{:shortdesc}

**Importante:** é possível ligar somente serviços que suportem chaves de serviço. Para localizar uma lista com serviços que suportem chaves de serviço, consulte [Ativando apps externos para usar serviços do {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#accser_external).

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Para incluir um serviço do {{site.data.keyword.Bluemix_notm}} em seu cluster:
1. [Crie uma instância do serviço do {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#req_instance). </br></br>**Nota:** alguns serviços do {{site.data.keyword.Bluemix_notm}} estão disponíveis somente em regiões selecionadas. Será possível ligar um serviço a seu cluster somente se o serviço estiver disponível na mesma região que seu cluster. Além disso, se você deseja criar uma instância de serviço na zona Washington DC, deve-se usar a CLI.

2. Verifique o tipo de serviço que você criou e anote o **Nome** da instância de serviço.
   - **Serviços do Cloud Foundry:**
     ```
     Lista de serviços ibmcloud
     ```
     {: pre}

     Saída de exemplo:
     ```
     name                         service           plan    bound apps   last operation
     <cf_service_instance_name>   <service_name>    spark                create succeeded
     ```
     {: screen}

  - **Serviços ativados pelo IAM:**
     ```
     ibmcloud resource service-instances
     ```
     {: pre}

     Saída de exemplo:
     ```
     Name                          Location   State    Type               Tags   
     <iam_service_instance_name>   <region>   active   service_instance      
     ```
     {: screen}

   Também é possível ver os diferentes tipos de serviço em seu painel como **Serviços do Cloud Foundry** e **Serviços**.

3. Para serviços ativados pelo IAM, crie um alias do Cloud Foundry para que seja possível ligar esse serviço a seu cluster. Se seu serviço já for um serviço do Cloud Foundry, esta etapa não será necessária e será possível continuar com a próxima etapa.
   1. Destinar uma organização e um espaço do Cloud Foundry.
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. Crie um alias do Cloud Foundry para a instância de serviço.
      ```
      ibmcloud resource service-alias-create <service_alias_name> --instance-name <iam_service_instance_name>
      ```
      {: pre}

   3. Verifique se o alias do serviço foi criado.
      ```
      Lista de serviços ibmcloud
      ```
      {: pre}

4. Identifique o espaço de nomes de cluster que você deseja usar para incluir o seu serviço. Escolha entre as opções a seguir.
   - Liste os namespaces existentes e escolha um namespace que você deseja usar.
     ```
     kubectl get namespaces
     ```
     {: pre}

   - Crie um namespace em seu cluster.
     ```
     kubectl create namespace <namespace_name>
     ```
     {: pre}

5.  Inclua o serviço em seu cluster. Para serviços ativados pelo IAM, assegure-se de usar o alias do Cloud Foundry que você criou anteriormente.
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}

    Quando o serviço é incluído com sucesso em seu cluster, é criado um segredo de cluster que contém as credenciais de sua instância de serviço. Os segredos são criptografados automaticamente em etcd para proteger seus dados.

    Saída de exemplo:
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Verifique as credenciais de serviço em seu segredo do Kubernetes.
    1. Obtenha os detalhes do segredo e anote o valor de **binding**. O valor de **binding** é codificado em Base64 e contém as credenciais para sua instância de serviço no formato JSON.
       ```
       kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
       ```
       {: pre}

       Saída de exemplo:
       ```
       apiVersion: v1
       data:
         binding: <binding>
       kind: Secret
       metadata:
         annotations:
           service-instance-id: 1111aaaa-a1aa-1aa1-1a11-111aa111aa11
           service-key-id: 2b22bb2b-222b-2bb2-2b22-b22222bb2222
         creationTimestamp: 2018-08-07T20:47:14Z
         name: binding-<service_instance_name>
         namespace: <namespace>
         resourceVersion: "6145900"
         selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
         uid: 33333c33-3c33-33c3-cc33-cc33333333c
       type: Opaque
       ```
       {: screen}

    2. Decode o valor de ligação.
       ```
       echo "<binding>" | base64 -D
       ```
       {: pre}

       Saída de exemplo:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. Opcional: compare as credenciais de serviço que você decodificou na etapa anterior com as credenciais de serviço localizadas para sua instância de serviço no painel do {{site.data.keyword.Bluemix_notm}}.

7. Agora que seu serviço está ligado a seu cluster, deve-se configurar seu app para [acessar as credenciais de serviço no segredo do Kubernetes](#adding_app).


## Acessando credenciais de serviço de seus apps
{: #adding_app}

Para acessar uma instância de serviço do {{site.data.keyword.Bluemix_notm}} por meio de seu app, deve-se tornar as credenciais de serviço que estão armazenadas no segredo do Kubernetes disponíveis para seu app.
{: shortdesc}

As credenciais de uma instância de serviço são codificadas em base64 e armazenadas dentro de seu segredo no formato JSON. Para acessar os dados em seu segredo, escolha entre as opções a seguir:
- [Montar o segredo como um volume para o pod](#mount_secret)
- [ Referenciar o segredo em variáveis de ambiente ](#reference_secret)

Antes de iniciar:
- [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.
- [ Inclua um serviço  {{site.data.keyword.Bluemix_notm}}  em seu cluster ](#adding_cluster).

### Montando o segredo como um volume em seu pod
{: #mount_secret}

Quando você monta o segredo como um volume em seu pod, um arquivo denominado `binding` é armazenado no diretório de montagem do volume. O arquivo `binding` em formato JSON inclui todas as informações e credenciais necessárias para acessar o serviço do {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

1.  Liste os segredos disponíveis em seu cluster e anote o **nome** de seu segredo. Procure um segredo do tipo **Opaco**. Se existirem múltiplos segredos, entre em contato com o administrador de cluster para identificar o segredo do serviço correto.

    ```
    kubectl get secrets
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Crie um arquivo YAML para sua implementação do Kubernetes e monte o segredo como um volume em seu pod.
    ```
    apiVersion: apps/v1beta1
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
          - image: registry.bluemix.net/ibmliberty:latest
            name: secret-test
            volumeMounts:
            - mountPath: <mount_path>
              name: <volume_name>
          volumes:
          - name: <volume_name>
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <caption>Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>O caminho absoluto do diretório no qual o volume está montado dentro do contêiner.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></br><code>volumes/name</code></td>
    <td>O nome do volume a ser montado no pod.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>As permissões de leitura e gravação no segredo. Use  ` 420 `  para configurar permissões somente leitura. </td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>O nome do segredo que você anotou na etapa anterior.</td>
    </tr></tbody></table>

3.  Crie o pod e monte o segredo como um volume.
    ```
    Kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  Verifique se o pod foi criado.
    ```
    kubectl get pods
    ```
    {: pre}

    Exemplo de saída da CLI:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  Acesse as credenciais de serviço.
    1. Efetue login em seu pod.
       ```
       kubectl exec < pod_name> -it bash
       ```
       {: pre}

    2. Navegue para o caminho de montagem do volume que você definiu anteriormente e liste os arquivos em seu caminho de montagem do volume.
       ```
       cd < volume_mountpath> & & ls
       ```
       {: pre}

       Saída de exemplo:
       ```
       ligando
       ```
       {: screen}

       O arquivo `binding` inclui as credenciais de serviço que você armazenou no segredo do Kubernetes.

    4. Visualize as credenciais de serviço. As credenciais são armazenadas como pares chave-valor em formato JSON.
       ```
       ligação cat
       ```
       {: pre}

       Saída de exemplo:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. Configure seu app para analisar o conteúdo JSON e recuperar as informações necessárias para acessar seu serviço.


### Referenciando o segredo em variáveis de ambiente
{: #reference_secret}

É possível incluir as credenciais de serviço e outros pares chave-valor de seu segredo do Kubernetes como variáveis de ambiente para a sua implementação.   
{: shortdesc}

1. Liste os segredos disponíveis em seu cluster e anote o **nome** de seu segredo. Procure um segredo do tipo **Opaco**. Se existirem múltiplos segredos, entre em contato com o administrador de cluster para identificar o segredo do serviço correto.

    ```
    kubectl get secrets
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m
    ```
    {: screen}

2. Obtenha os detalhes do seu segredo para localizar potenciais pares chave-valor que é possível referenciar como variáveis de ambiente em seu pod. As credenciais de serviço são armazenadas na chave `binding` de seu segredo.
   ```
   kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
   ```
   {: pre}

   Saída de exemplo:
   ```
   apiVersion: v1
   data:
     binding: <binding>
   kind: Secret
   metadata:
     annotations:
       service-instance-id: 7123acde-c3ef-4ba2-8c52-439ac007fa70
       service-key-id: 9h30dh8a-023f-4cf4-9d96-d12345ec7890
     creationTimestamp: 2018-08-07T20:47:14Z
     name: binding-<service_instance_name>
     namespace: <namespace>
     resourceVersion: "6145900"
     selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
     uid: 12345a31-9a83-11e8-ba83-cd49014748f
   type: Opaque
   ```
   {: screen}

3. Crie um arquivo YAML para a sua implementação do Kubernetes e especifique uma variável de ambiente que referencie a chave `binding`.
   ```
   apiVersion: apps/v1beta1
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
     template:
       metadata:
         labels:
           app: secret-test
       spec:
         containers:
         - image: registry.bluemix.net/ibmliberty:latest
           name: secret-test
           env:
           - name: BINDING
             valueFrom:
               secretKeyRef:
                 name: binding-<service_instance_name>
                 key: binding
     ```
     {: codeblock}

     <table>
     <caption>Entendendo os componentes de arquivo YAML</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
     </thead>
     <tbody>
     <tr>
     <td><code> contêineres / env/name </code></td>
     <td>O nome de sua variável de ambiente.</td>
     </tr>
     <tr>
     <td><code> env/valueFrom/secretKeyRef/name </code></td>
     <td>O nome do segredo que você anotou na etapa anterior.</td>
     </tr>
     <tr>
     <td><code> env/valueFrom/secretKeyRef/key </code></td>
     <td>A chave que faz parte de seu segredo e que você deseja referenciar em sua variável de ambiente. Para referenciar as credenciais de serviço, deve-se usar a chave <strong>binding</strong>.  </td>
     </tr>
     </tbody></table>

4. Crie o pod que referencia a chave `binding` de seu segredo como uma variável de ambiente.
   ```
   Kubectl apply -f secret-test.yaml
   ```
   {: pre}

5. Verifique se o pod foi criado.
   ```
   kubectl get pods
   ```
   {: pre}

   Exemplo de saída da CLI:
   ```
   NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
   ```
   {: screen}

6. Verifique se a variável de ambiente está configurada corretamente.
   1. Efetue login em seu pod.
      ```
      kubectl exec < pod_name> -it bash
      ```
      {: pre}

   2. Liste todas as variáveis de ambiente no pod.
      ```
      env
      ```
      {: pre}

      Saída de exemplo:
      ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. Configure seu app para ler a variável de ambiente e para analisar o conteúdo JSON para recuperar as informações que você precisa para acessar seu serviço.

   Código de exemplo em Python:
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## Configurando o Helm no  {{site.data.keyword.containerlong_notm}}
{: #helm}

[Helm ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://helm.sh) é um gerenciador de pacote do Kubernetes. É possível criar gráficos Helm ou usar gráficos Helm preexistentes para definir, instalar e fazer upgrade de aplicativos complexos do Kubernetes complexo de upgrade que são executados em clusters do {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Antes de usar os gráficos Helm com o {{site.data.keyword.containerlong_notm}}, deve-se instalar e inicializar uma instância do Helm em seu cluster. É possível então incluir o repositório do Helm do {{site.data.keyword.Bluemix_notm}} em sua instância do Helm.

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja usar um gráfico Helm.

1. Instale a <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">CLI do Helm <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.

2. **Importante**: para manter a segurança do cluster, crie uma conta de serviço para Tiller no namespace `kube-system` e uma ligação de função de cluster RBAC do Kubernetes para o pod `tiller-deploy`.

    1. Em seu editor preferencial, crie o arquivo a seguir e salve-o como `rbac-config.yaml`. **Nota**: para instalar o Tiller com a conta de serviço e a ligação de função de cluster no namespace `kube-system`, deve-se ter a função [`cluster-admin`](cs_users.html#access_policies). É possível escolher um namespace diferente de `kube-system`, mas todos os gráficos Helm da IBM devem ser instalados em `kube-system`. Sempre que você executa um comando `helm`, deve-se usar a sinalização `tiller-namespace <namespace>` para apontar para o outro namespace no qual o Tiller está instalado.

      ```
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: tiller
        namespace: kube-system
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: ClusterRoleBinding
      metadata:
        name: tiller
      roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
      subjects:
        - kind: ServiceAccount
          name: tiller
          namespace: kube-system
      ```
      {: codeblock}

    2. Crie a conta de serviço e a ligação da função de cluster.

        ```
        kubectl create -f rbac-config.yaml
        ```
        {: pre}

3. Inicialize o Helm e instale o `tiller` com a conta de serviço que você criou.

    ```
    Helm init -- tiller de serviço da conta
    ```
    {: pre}

4. Verifique se o pod `tiller-deploy` tem um **Status** de `Executando` em seu cluster.

    ```
    kubectl get pods -n kube-system -l app=helm
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. Inclua o repositório do Helm do {{site.data.keyword.Bluemix_notm}} em sua instância do Helm.

    ```
    helm repo add ibm https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

6. Liste os gráficos Helm que estão atualmente disponíveis no repositório do {{site.data.keyword.Bluemix_notm}}.

    ```
    helm search ibm
    ```
    {: pre}

7. Para saber mais sobre um gráfico, liste suas configurações e valores padrão.

    Por exemplo, para visualizar as configurações, a documentação e os valores padrão do gráfico Helm do serviço VPN do IPSec do strongSwan:

    ```
    Helm inspect ibm/strongswan
    ```
    {: pre}


### Links relacionados do Helm
{: #helm_links}

* Para usar o gráfico Helm do strongSwan, veja [Configurando a conectividade VPN com o gráfico Helm do serviço de VPN IPSec do strongSwan](cs_vpn.html#vpn-setup).
* Visualize os gráficos Helm disponíveis que podem ser usados com o {{site.data.keyword.Bluemix_notm}} na GUI do [Catálogo de gráficos Helm ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts).
* Saiba mais sobre os comandos do Helm que são usados para configurar e gerenciar os gráficos Helm na <a href="https://docs.helm.sh/helm/" target="_blank">documentação do Helm <img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a>.
* Saiba mais sobre como é possível [aumentar a velocidade de implementação com os gráficos Helm do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/).

## Visualizando recursos de cluster do Kubernetes
{: #weavescope}

O Weave Scope fornece um diagrama visual de seus recursos dentro de um cluster do Kubernetes, incluindo serviços, pods, contêineres e muito mais. O Weave Scope fornece métricas interativas para CPU e memória e ferramentas para rodapé e executável em um contêiner.
{:shortdesc}

Antes de iniciar:

-   Lembre-se de não expor as suas informações do cluster na Internet pública. Conclua estas etapas para implementar o Weave Scope com segurança e acessá-lo por meio de um navegador da web localmente.
-   Se você não tiver nenhum ainda, [crie um cluster padrão](cs_clusters.html#clusters_ui). O Weave Scope pode ser intensivo de CPU, especialmente o app. Execute o Weave Scope com clusters padrão maiores, não clusters grátis.
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
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
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
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Saída:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Execute um comando de encaminhamento de porta para abrir o serviço em seu computador. Na próxima vez que você acessar o Weave Scope, será possível executar esse comando de encaminhamento de porta sem concluir as etapas de configuração anteriores novamente.

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Saída:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Abra seu navegador da web para `http://localhost:4040`. Sem os componentes padrão implementados, você vê o diagrama a seguir. É possível escolher visualizar diagramas de topologia ou tabelas dos recursos do Kubernetes no cluster.

     <img src="images/weave_scope.png" alt="Topologia de exemplo do Weave Scope" style="width:357px;" />


[Saiba mais sobre os recursos do Weave Scope ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.weave.works/docs/scope/latest/features/).

<br />

