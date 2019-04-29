---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, logmet, logs, metrics

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



# Criando log e monitorando
{: #health}

Configure a criação de log e o monitoramento no {{site.data.keyword.containerlong}} para ajudá-lo a solucionar problemas e melhorar o funcionamento e o desempenho de seus clusters e apps do Kubernetes.
{: shortdesc}

O monitoramento e a criação de log contínuos são a chave para detectar ataques em seu cluster e questões de resolução de problemas à medida que eles surgem. Monitoramento continuamente seu cluster, você é capaz de entender melhor a capacidade do cluster e a disponibilidade de recursos que estão disponíveis para seu app. Com esse insight, é possível se preparar para proteger seus apps com relação ao tempo de inatividade. **Nota**: para configurar a criação de log e o monitoramento, deve-se usar um cluster padrão no {{site.data.keyword.containerlong_notm}}.

## Escolhendo uma solução de criação de log
{: #logging_overview}

Por padrão, os logs são gerados e gravados localmente para todos os seguintes componentes de cluster do {{site.data.keyword.containerlong_notm}}: nós do trabalhador, contêineres, aplicativos, armazenamento persistente, balanceador de carga do aplicativo Ingress, API do Kubernetes e o namespace `kube-system`. Várias soluções de criação de log estão disponíveis para coletar, encaminhar e visualizar esses logs.
{: shortdesc}

É possível escolher sua solução de criação de log com base em quais componentes de cluster você precisa para coletar logs. Uma implementação comum é escolher um serviço de criação de log que você prefira com base em seus recursos de análise e interface, como o {{site.data.keyword.loganalysisfull}}, o {{site.data.keyword.la_full}} ou um serviço de terceiro. Em seguida, é possível usar o {{site.data.keyword.cloudaccesstrailfull}} para auditar a atividade do usuário no cluster e fazer backup de logs do cluster mestre no {{site.data.keyword.cos_full}}. **Nota**: Para configurar a criação de log, você deve ter um cluster Kubernetes padrão.

<dl>

<dt>Fluentd com  {{site.data.keyword.loganalysisfull_notm}}  ou syslog</dt>
<dd>Para coletar, encaminhar e visualizar logs para um componente de cluster, é possível criar uma configuração de criação de log usando o Fluentd. Quando você cria uma configuração de criação de log, o complemento de cluster [Fluentd ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.fluentd.org/) coleta logs dos caminhos para uma origem especificada. O Fluentd então encaminha esses logs para o {{site.data.keyword.loganalysisfull_notm}} ou um servidor syslog externo.

<ul><li><strong>{{site.data.keyword.loganalysisfull_notm}}</strong>: [{{site.data.keyword.loganalysisshort}}](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_analysis_ov) expande a sua capacidade de retenção, procura e coleção de logs. Ao criar uma configuração de criação de log que encaminha os logs para uma origem para o {{site.data.keyword.loganalysisfull_notm}}, é possível visualizar os logs em um painel do Kibana.</li>

<li><strong>Servidor syslog externo</strong>: configure um servidor externo que aceite um protocolo syslog. Em seguida, é possível criar uma configuração de criação de log para uma origem em seu cluster para encaminhar logs para esse servidor externo.</li></ul>

Para iniciar, consulte [Entendendo o encaminhamento de log do cluster e do aplicativo](#logging).
</dd>

<dt>{{site.data.keyword.la_full_notm}}</dt>
<dd>Gerenciar logs de contêiner de pod implementando o LogDNA como um serviço de terceiro em seu cluster. Para usar o {{site.data.keyword.la_full_notm}}, deve-se implementar um agente de criação de log para cada nó do trabalhador em seu cluster. Esse agente coleta logs com a extensão `*.log ` e arquivos sem extensão que são armazenados no diretório `/var/log` de seu pod de todos os namespaces, incluindo `kube-system` Em seguida, o agente encaminha os logs para o serviço {{site.data.keyword.la_full_notm}}. Para obter mais informações sobre o serviço, consulte a documentação do [{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about). Para iniciar, consulte [Gerenciando logs do cluster Kubernetes {{site.data.keyword.loganalysisfull_notm}} com LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).</dd>

<dt>{{site.data.keyword.cloudaccesstrailfull_notm}}</dt>
<dd>Para monitorar a atividade administrativa iniciada pelo usuário feita em seu cluster, é possível coletar e encaminhar logs de auditoria para o {{site.data.keyword.cloudaccesstrailfull_notm}}. Clusters geram dois tipos de {{site.data.keyword.cloudaccesstrailshort}} eventos.

<ul><li>Os eventos de gerenciamento de cluster são gerados automaticamente e encaminhados para o {{site.data.keyword.cloudaccesstrailshort}}.</li>

<li>Os eventos de auditoria do servidor da API do Kubernetes são gerados automaticamente, mas deve-se [criar uma configuração de criação de log](#api_forward) para que o Fluentd possa encaminhar esses logs para o {{site.data.keyword.loganalysisshort}}. {{site.data.keyword.cloudaccesstrailshort}} , em seguida, puxa esses logs do  {{site.data.keyword.loganalysisshort}}.</li></ul>

Para obter mais informações sobre os tipos de eventos do {{site.data.keyword.containerlong_notm}} que podem ser rastreados, consulte [Eventos do Activity Tracker](/docs/containers?topic=containers-at_events). Para obter mais informações sobre o serviço, consulte a documentação do [Activity Tracker](/docs/services/cloud-activity-tracker?topic=cloud-activity-tracker-getting-started-with-cla).
</dd>

<dt>{{site.data.keyword.cos_full_notm}}</dt>
<dd>Para coletar, encaminhar e visualizar logs para o mestre do Kubernetes do cluster, é possível obter uma captura instantânea dos logs do mestre em qualquer momento para coletar em um depósito do {{site.data.keyword.cos_full_notm}}. A captura instantânea inclui qualquer coisa que é enviada por meio do servidor de API, como planejamento de pod, implementações ou políticas RBAC. Para iniciar, consulte [Coletando logs do mestre](#collect_master).</dd>

<dt>Serviços de terceiros</dt>
<dd>Se você tiver requisitos especiais, será possível configurar sua própria solução de criação de log. Confira os serviços de criação de log de terceiros que podem ser incluídos em seu cluster em [Integrações de criação de log e monitoramento](/docs/containers?topic=containers-integrations#health_services). Em clusters que executam o Kubernetes versão 1.11 ou mais recente, é possível coletar logs de contêiner por meio do caminho `/var/log/pods/`. Em clusters que executam o Kubernetes versão 1.10 ou anterior, é possível coletar logs de contêiner por meio do caminho `/var/lib/docker/containers/`.</dd>

</dl>

## Entendendo o cluster e o encaminhamento de log do app
{: #logging}

Por padrão, os logs são coletados pelo complemento [Fluentd ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.fluentd.org/) em seu cluster. Quando você cria uma configuração de criação de log para uma origem em seu cluster, como um contêiner, os logs que Fluentd coleta a partir dos caminhos dessa origem são encaminhados para {{site.data.keyword.loganalysisshort_notm}} ou para um servidor syslog externo. O tráfego da origem para o serviço de criação de log na porta de entrada está criptografado.
{: shortdesc}

**Quais são as origens para as quais eu posso configurar o encaminhamento de log?**

Na imagem a seguir, é possível ver o local das origens para as quais é possível configurar a criação de log.

<img src="images/log_sources.png" width="600" alt="Log sources in your cluster" style="width:600px; border-style: none"/>

1. `worker`: informações que são específicas para a configuração de infraestrutura que você tem para o nó do trabalhador. Os logs do trabalhador são capturados no syslog e contêm eventos do sistema operacional. Em `auth.log`, é possível localizar informações sobre as solicitações de autenticação que são feitas para o S.O.</br>** Caminhos **:
    * ` /var/log/syslog `
    * ` /var/log/auth.log `

2. `container`: informações que são registradas por um contêiner em execução.</br>**Caminhos**: qualquer coisa gravada em `STDOUT` ou `STDERR`.

3. `application`: informações sobre eventos que ocorrem no nível do aplicativo. Isso pode ser uma notificação de que um evento ocorreu, como um login bem-sucedido, um aviso sobre armazenamento ou outras operações que podem ser executadas no nível do app.</br>**Caminhos**: é possível configurar os caminhos para os quais seus logs são encaminhados. No entanto, para que os logs sejam enviados, é necessário usar um caminho absoluto em sua configuração de criação de log ou os logs não podem ser lidos. Se o seu caminho estiver montado em seu nó do trabalhador, ele poderá ter criado um link simbólico. Exemplo: se o caminho especificado for `/usr/local/spark/work/app-0546/0/stderr`, mas os logs forem realmente para `/usr/local/spark-1.0-hadoop-1.2/work/app-0546/0/stderr`, os logs não poderão ser lidos.

4. `storage`: informações sobre o armazenamento persistente que está configurado em seu cluster. Os logs de armazenamento podem ajudar a configurar painéis e alertas de determinação de problemas como parte de seu pipeline DevOps e liberações de produção. **Nota**: os caminhos `/var/log/kubelet.log` e `/var/log/syslog` também contêm logs de armazenamento, mas os logs desses caminhos são coletados pelas origens de log `kubernetes` e `worker`.</br>** Caminhos **:
    * `/var/log/ibmc-s3fs.log`
    * `/var/log/ibmc-block.log`

  **Pods**:
    * `portworx-***`
    * `ibmcloud-block-storage-attacher-***`
    * `ibmcloud-block-storage-driver-***`
    * `ibmcloud-block-storage-plugin-***`
    * `ibmcloud-object-storage-plugin-***`

5. `kubernetes`: informações do kubelet, do kube-proxy e de outros eventos do Kubernetes que acontecem no namespace kube-system do nó do trabalhador.</br>** Caminhos **:
    * ` /var/log/kubelet.log `
    * ` /var/log/kube-proxy.log `
    * ` /var/log/event-exporter/1 .. log `

6. `kube-audit`: informações sobre ações relacionadas ao cluster que são enviadas para o servidor de API do Kubernetes, incluindo o horário, o usuário e o recurso afetado.

7. `ingress`: informações sobre o tráfego de rede que entra em um cluster por meio do Balanceador de Carga do Aplicativo do Ingress. Para obter informações de configuração específicas, efetue check-out da [documentação do Ingress](/docs/containers?topic=containers-ingress_health#ingress_logs).</br>** Caminhos **:
    * ` /var/log/alb/ids/* .log `
    * ` /var/log/alb/ids/* .err `
    * `/var/log/alb/customerlogs/*.log`
    * ` /var/log/alb/customerlogs/* .err `

</br>

**Quais opções de configuração eu tenho?**

A tabela a seguir mostra as diferentes opções que você tem ao configurar a criação de log e suas descrições.

<table>
<caption> Entendendo as opções de configuração de criação</caption>
  <thead>
    <th>Opção</th>
    <th>Descrição</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
      <td>O nome ou ID do cluster.</td>
    </tr>
    <tr>
      <td><code> <em> -- log_source </em> </code></td>
      <td>A origem da qual você deseja encaminhar logs. Os valores aceitos são <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code>, <code>storage</code> e <code>kube-audit</code>. Esse argumento suporta uma lista separada por vírgula de origens de log para aplicar a configuração. Se você não fornecer uma origem de log, configurações de criação de log serão criadas para as origens de log <code>container</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
      <td><code> <em> -- type </em> </code></td>
      <td>Onde você deseja encaminhar os logs. As opções são <code>ibm</code>, que encaminha os logs para o {{site.data.keyword.loganalysisshort_notm}} e <code>syslog</code>, que encaminha os logs para um servidor externo.</td>
    </tr>
    <tr>
      <td><code> <em> -- namespace </em> </code></td>
      <td>Opcional: o namespace do Kubernetes do qual você deseja encaminhar logs. O encaminhamento de log não é suportado para os namespaces do Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Esse valor é válido somente para a origem de log do <code>container</code>. Se você não especificar um namespace, todos os namespaces no cluster usarão essa configuração.</td>
    </tr>
    <tr>
      <td><code> <em> -- hostname </em> </code></td>
      <td><p>Para {{site.data.keyword.loganalysisshort_notm}}, use a [URL de ingestão](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls). Se não especificar uma URL de ingestão, o terminal para a região na qual você criou o seu cluster será usado.</p>
      <p>Para syslog, especifique o nome do host ou o endereço IP do serviço do coletor do log.</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>A porta de ingestão. Se você não especificar uma porta, a porta padrão <code>9091</code> será usada.
      <p>Para syslog, especifique a porta do servidor do coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada.</td>
    </tr>
    <tr>
      <td><code><em>--space</em></code></td>
      <td>Opcional: o nome do espaço do Cloud Foundry para o qual você deseja enviar logs. Ao encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}}, o espaço e a organização são especificados no ponto de ingestão. Se você não especificar um espaço, os logs serão enviados para o nível de conta. Se você especifica um espaço, deve-se também especificar uma organização.</td>
    </tr>
    <tr>
      <td><code> <em> -- org </em> </code></td>
      <td>Opcional: o nome da organização do Cloud Foundry na qual o espaço estiver. Esse valor é necessário se você especificou um espaço.</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>Opcional: para encaminhar logs por meio de apps, é possível especificar o nome do contêiner que contém o seu app. É possível especificar mais de um contêiner usando uma lista separada por vírgula. Se nenhum contêiner é especificado, os logs são encaminhados de todos os contêineres que contêm os caminhos que você forneceu.</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>O caminho em um contêiner no qual os apps são registrados. Para encaminhar logs com tipo de origem <code>application</code>, deve-se fornecer um caminho. Para especificar mais de um caminho, use uma lista separada por vírgula. Exemplo: <code>/var/log/myApp1/*,/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>-- syslog-protocol</em></code></td>
      <td>Quando o tipo de criação de log é <code>syslog</code>, o protocolo de camada de transporte. É possível usar os protocolos a seguir: `udp`, `tls` ou `tcp`. Ao encaminhar para um servidor rsyslog com o protocolo <code>udp</code>, os logs com mais de 1 KB serão truncados.</td>
    </tr>
    <tr>
      <td><code> <em> -- ca-cert </em> </code></td>
      <td>Necessário: quando o tipo de criação de log for <code>syslog</code> e o protocolo for <code>tls</code>, o nome do segredo do Kubernetes que contém o certificado de Autoridade de certificação.</td>
    </tr>
    <tr>
      <td><code> <em> -- verify-mode </em> </code></td>
      <td>Quando o tipo de criação de log for <code>syslog</code> e o protocolo for <code>tls</code>, o modo de verificação. Os valores suportados são <code>verify-peer</code> e o padrão <code>verify-none</code>.</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>Opcional: ignore a validação dos nomes de organização e espaço quando forem especificados. Ignorar a validação diminui o tempo de processamento, mas uma configuração de criação de log inválida não encaminhará os logs corretamente.</td>
    </tr>
  </tbody>
</table>

**Sou responsável por manter o Fluentd atualizado?**

Para fazer mudanças em suas configurações de criação de log ou de filtro, o complemento de criação de log Fluentd deve estar na versão mais recente. Por padrão, as atualizações automáticas para o complemento são ativadas. Para desativar atualizações automáticas, consulte [Atualizando complementos do cluster: Fluentd para criação de log](/docs/containers?topic=containers-update#logging).

**É possível encaminhar alguns logs, mas não outros, de uma origem no meu cluster?**

Sim. Por exemplo, se você tiver um pod particularmente ativo, talvez você queira evitar que os logs desse pod ocupem o espaço de armazenamento de log, enquanto ainda permite que logs de outros pods sejam encaminhados. Para evitar que os logs de um pod específico sejam encaminhados, consulte [Filtrando logs](#filter-logs).

** Múltiplas equipes trabalham em um cluster. Como posso separar logs por equipe?**

É possível encaminhar logs de contêiner de um namespace para um espaço do Cloud Foundry e de logs de contêiner de outro namespace para um espaço do Cloud Foundry diferente. Para cada namespace, crie uma configuração de encaminhamento de log para a origem de log de `container`. Especifique o namespace da equipe no qual você deseja aplicar a configuração no sinalizador `--namespace` e o espaço da equipe no qual os logs são encaminhados para o sinalizador `--space`. Também é possível especificar opcionalmente uma organização do Cloud Foundry dentro do espaço no sinalizador `--org`.

<br />


## Configurando o encaminhamento de log do cluster e do app
{: #configuring}

É possível configurar a criação de log para clusters padrão do {{site.data.keyword.containerlong_notm}} por meio do console ou por meio da CLI.
{: shortdesc}

### Ativando o encaminhamento de log com o console do {{site.data.keyword.Bluemix_notm}}
{: #enable-forwarding-ui}

É possível configurar o encaminhamento de log no painel do {{site.data.keyword.containerlong_notm}}. Pode levar alguns minutos para o processo ser concluído, então, se você não vir logs imediatamente, tente esperar alguns minutos e, em seguida, verifique novamente.
{: shortdesc}

Para criar uma configuração no nível de conta, para um namespace de contêiner específico ou para a criação de log do app, use a CLI.
{: tip}

Antes de iniciar, [crie](/docs/containers?topic=containers-clusters#clusters) ou identifique um cluster padrão para usar.

1. Efetue login no [ console do {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/containers-kubernetes/clusters) e navegue para **Kubernetes > Clusters**.
2. Selecione seu cluster padrão e no campo **Logs** da guia **Visão geral**, clique em **Ativar**.
3. Selecione a **Organização do Cloud Foundry** e o **Espaço** dos quais deseja encaminhar os logs. Quando você configura o encaminhamento de log no painel, os logs são enviados para o terminal padrão do {{site.data.keyword.loganalysisshort_notm}} para seu cluster. Para encaminhar logs para um servidor externo ou para outro terminal do {{site.data.keyword.loganalysisshort_notm}}, é possível usar a CLI para configurar a criação de log.
4. Selecione as **Origens de log** das quais deseja encaminhar os logs.
5. Clique em
**Criar**.

</br>
</br>

### Ativando o encaminhamento de log com a CLI
{: #enable-forwarding}

É possível criar uma configuração para a criação de log do cluster. É possível diferenciar entre as diferentes opções de criação de log usando sinalizações.
{: shortdesc}

Antes de iniciar, [crie](/docs/containers?topic=containers-clusters#clusters) ou identifique um cluster padrão para usar.

** Forwarding logs para a IBM **

1. Verifique as permissões.
    1. Assegure-se de que você tenha a [função de **Editor** ou **Administrador** da plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform).
    2. Se você especificou um espaço quando criou o cluster, você e o proprietário da chave da API do {{site.data.keyword.containerlong_notm}} precisam da função [**Desenvolvedor** do Cloud Foundry](/docs/iam?topic=iam-mngcf) nesse espaço.
      * Se você não souber quem é o proprietário da chave API do {{site.data.keyword.containerlong_notm}}, execute o comando a seguir.
          ```
          ibmcloud ks api-key-info --cluster <cluster_name>
          ```
          {: pre}
      * Se você mudar as permissões, será possível aplicar imediatamente as mudanças executando o comando a seguir.
          ```
          ibmcloud ks logging-config-refresh --cluster <cluster_name>
          ```
          {: pre}

2.  Para o cluster padrão no qual a origem de log está localizada: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

    Se você está usando uma conta Dedicada, deve-se efetuar login no terminal público do {{site.data.keyword.cloud_notm}} e destinar a sua organização e o espaço públicos para ativar o encaminhamento de log.
    {: tip}

3. Crie uma configuração de encaminhamento de log.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --type ibm --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs> --skip-validation
    ```
    {: pre}

  * Exemplo de configuração de criação de log do contêiner para o namespace e a saída padrão:
    ```
    ibmcloud ks logging-config-create mycluster
    Creating cluster mycluster logging configurations...
    OK
    ID                                      Source      Namespace    Host                                 Port    Org  Space   Server Type   Protocol   Application Containers   Paths
    4e155cf0-f574-4bdb-a2bc-76af972cae47    container       *        ingest.logging.eu-gb.bluemix.net✣   9091✣    -     -        ibm           -                  -               -
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

  * Exemplo de configuração de criação de log do aplicativo e saída:
    ```
    ibmcloud ks logging-config-create cluster2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'container1,container2,container3'
    Creating logging configuration for application logs in cluster cluster2...
    OK
    Id                                     Source        Namespace   Host                                    Port    Org   Space   Server Type   Protocol   Application Containers               Paths
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

Se você tiver apps que são executados em seus contêineres que não podem ser configurados para gravar logs no STDOUT ou STDERR, será possível criar uma configuração de criação de log para encaminhar logs de arquivos de log do app.
{: tip}

</br>
</br>


**Encaminhando logs para seu próprio servidor sobre os protocolos `udp` ou `tcp`**

1. Assegure-se de que você tenha a [função de **Editor** ou **Administrador** da plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform).

2. Para o cluster no qual a origem de log está localizada: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure). **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

3. Para encaminhar logs para o syslog, configure um servidor que aceite um protocolo syslog de uma de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.

  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar esse [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que executa um contêiner em seu cluster. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

  É possível ver seus logs como JSON válido removendo prefixos de syslog. Para fazer isso, inclua o código a seguir na parte superior de seu arquivo <code>etc/rsyslog.conf</code> no qual o servidor rsyslog está em execução: <code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

4. Crie uma configuração de encaminhamento de log.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br>
</br>


**Encaminhando logs para o seu próprio servidor sobre o protocolo `tls`**

As etapas a seguir são instruções gerais. Antes de usar o contêiner em um ambiente de produção, certifique-se de que quaisquer requisitos de segurança necessários sejam atendidos.
{: tip}

1. Assegure-se de que você tenha as [funções do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) a seguir:
    * A função da plataforma **Editor** ou **Administrador** para o cluster
    * Função de serviço **Gravador** ou **Gerenciador** para o namespace `kube-system`

2. Para o cluster no qual a origem de log está localizada: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure). **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

3. Configure um servidor que aceite um protocolo syslog de uma de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.

  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar esse [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que executa um contêiner em seu cluster. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog. Será necessário injetar a Autoridade de Certificação e os certificados do lado do servidor relevantes e atualizar o `syslog.conf` para ativar `tls` em seu servidor.

4. Salve seu certificado de Autoridade de certificação em um arquivo denominado `ca-cert`. Deve ser esse nome exato.

5. Crie um segredo no namespace `kube-system` para o arquivo `ca-cert`. Ao criar sua configuração de criação de log, você usará o nome do segredo para a sinalização `--ca-cert`.
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

6. Crie uma configuração de encaminhamento de log.
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br>
</br>


### Verificando o encaminhamento de log
{: verify-logging}

É possível verificar se a configuração está definida corretamente de uma de duas maneiras:

* Para listar todas as configurações de criação de log em um cluster:
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

* Para listar as configurações de criação de log para um tipo de origem de log:
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br></br>

### Atualizando o encaminhamento de log
{: #updating-forwarding}

É possível atualizar uma configuração de criação de log que você já criou.
{: shortdesc}

1. Atualize uma configuração de encaminhamento de log.
    ```
    ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### Parando o encaminhamento de log
{: #log_sources_delete}

É possível parar o encaminhamento de logs em uma ou todas as configurações de criação de log para um cluster.
{: shortdesc}

1. Para o cluster no qual a origem de log está localizada: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

2. Exclua a configuração de criação de log.
  <ul>
  <li>Para excluir uma configuração de criação de log:</br>
    <pre><code>ibmcloud ks logging-config-rm -- cluster  &lt;cluster_name_or_ID&gt;  -- id  &lt;log_config_ID&gt;</pre></code></li>
  <li>Para excluir todas as configurações de criação de log:</br>
    <pre><code> ibmcloud ks logging-config-rm -- cluster < my_cluster > -- all</pre></code></li>
  </ul>

</br>
</br>

### Exibindo logs
{: #view_logs}

Para visualizar logs para clusters e contêineres, é possível usar os recursos padrão de criação de log do Kubernetes e de tempo de execução do contêiner.
{:shortdesc}

**{{site.data.keyword.loganalysislong_notm}}**
{: #view_logs_k8s}

É possível visualizar os logs que você encaminhou para o {{site.data.keyword.loganalysislong_notm}} por meio do painel do Kibana.
{: shortdesc}

Se você usou os valores padrão para criar seu arquivo de configuração, seus logs podem ser localizados na conta, ou organização e espaço, em que o cluster foi criado. Se você especificou uma organização e espaço em seu arquivo de configuração, é possível localizar seus logs nesse espaço. Para obter mais informações sobre criação de log, consulte [Criação de log para o {{site.data.keyword.containerlong_notm}}](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes).

Para acessar o painel do Kibana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você configurou o encaminhamento de log para o cluster.
- US-Sul e EUA/Leste:  ` https://logging.ng.bluemix.net `
- UK-Sul:  ` https://logging.eu-gb.bluemix.net `
- UE-Central:  ` https://logging.eu-fra.bluemix.net `
- AP-Sul e AP-Norte: `https://logging.au-syd.bluemix.net`

Para obter mais informações sobre como visualizar logs, veja [Navegando para o Kibana por meio de um navegador da web](/docs/services/CloudLogAnalysis/kibana?topic=cloudloganalysis-launch#launch_Kibana_from_browser).

</br>

** Logs do contêiner **

É possível alavancar os recursos de criação de log de tempo de execução do contêiner integrado para revisar as atividades nos fluxos de saída padrão STDOUT e STDERR. Para obter mais informações, veja [Visualizando logs de contêiner para um contêiner que é executado em um cluster do
Kubernetes](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes).

<br />


## Filtrando logs
{: #filter-logs}

É possível escolher quais logs encaminhar ao filtrar logs específicos por um período de tempo. É possível diferenciar entre as diferentes opções de filtragem usando sinalizações.
{: shortdesc}

<table>
<caption>Entendendo as opções para filtragem de log</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/>  Entendendo as opções de filtragem de log</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;cluster_name_or_ID&gt;</td>
      <td>Necessário: o nome ou ID do cluster para o qual você deseja filtrar os logs.</td>
    </tr>
    <tr>
      <td><code>&lt;log_type&gt;</code></td>
      <td>O tipo de logs nos quais você deseja aplicar o filtro. Atualmente <code>all</code>, <code>container</code> e <code>host</code> são suportados.</td>
    </tr>
    <tr>
      <td><code>&lt;configs&gt;</code></td>
      <td>Opcional: uma lista separada por vírgula de seus IDs de configuração de criação de log. Se não fornecido, o filtro será aplicado a todas as configurações de criação de log de cluster que forem passadas para o filtro. É possível visualizar as configurações de log que correspondem ao filtro usando a opção <code>--show-matching-configs</code>.</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes_namespace&gt;</code></td>
      <td>Opcional: o namespace do Kubernetes do qual você deseja encaminhar logs. Essa sinalização se aplicará apenas quando você estiver usando o tipo de log <code>container</code>.</td>
    </tr>
    <tr>
      <td><code>&lt;container_name&gt;</code></td>
      <td>Opcional: o nome do contêiner por meio do qual você deseja filtrar os logs.</td>
    </tr>
    <tr>
      <td><code>&lt;logging_level&gt;</code></td>
      <td>Opcional: filtrará os logs que estiverem no nível especificado e menos. Os valores aceitáveis na ordem canônica são <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> e <code>trace</code>. Como um exemplo, se você filtrou logs no nível <code>info</code>, <code>debug</code> e <code>trace</code> também serão filtrados. **Nota**: é possível usar essa sinalização apenas quando as mensagens de log estiverem em formato JSON e contiverem um campo de nível. Para exibir suas mensagens em JSON, anexe a sinalização <code>--json</code> ao comando.</td>
    </tr>
    <tr>
      <td><code>&lt;message&gt;</code></td>
      <td>Opcional: filtra os logs que contêm uma mensagem especificada que é gravada como uma expressão regular.</td>
    </tr>
    <tr>
      <td><code>&lt;filter_ID&gt;</code></td>
      <td>Opcional: o ID do filtro de log.</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>Opcional: mostre as configurações de criação de log às quais cada filtro se aplica.</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>Opcional: exclua todos os seus filtros de encaminhamento de log.</td>
    </tr>
  </tbody>
</table>

1. Crie um filtro de criação de log.
  ```
  ibmcloud ks logging-filter-create <cluster_name_or_ID> --type <log_type> --logging-configs <configs> --namespace <kubernetes_namespace> --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

2. Visualize o filtro de log que você criou.

  ```
  ibmcloud ks logging-filter-get --cluster <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. Atualize o filtro de log que você criou.
  ```
  ibmcloud ks logging-filter-update --cluster <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. Exclua um filtro de log que você criou.

  ```
  ibmcloud ks logging-filter-rm --cluster <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## Configurando o encaminhamento de log para os logs de auditoria da API do Kubernetes
{: #api_forward}

O Kubernetes audita automaticamente qualquer evento passado por meio de seu servidor de API do Kubernetes. É possível encaminhar os eventos para o {{site.data.keyword.loganalysisshort_notm}} ou para um servidor externo.
{: shortdesc}


Para obter mais informações sobre logs de auditoria do Kubernetes, consulte o <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">tópico de auditoria<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> na documentação do Kubernetes.

* Atualmente, uma política de auditoria padrão é usada para todos os clusters com essa configuração de criação de log.
* Atualmente, os filtros não são suportados.
* Pode haver somente uma configuração `kube-audit` por cluster, mas é possível encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}} e um servidor externo criando uma configuração de criação de log e um webhook.
* Deve-se ter a [ função da plataforma **Administrador** do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o cluster.


### Enviando logs de auditoria para {{site.data.keyword.loganalysisshort_notm}}
{: #audit_enable_loganalysis}

É possível encaminhar os logs de auditoria do servidor da API do Kubernetes para o {{site.data.keyword.loganalysisshort_notm}}.
{: shortdesc}

**Antes de começar**

1. Verifique as permissões. Se tiver especificado um espaço quando criou o cluster ou a configuração de criação de log, o proprietário da conta e o proprietário da chave do {{site.data.keyword.containerlong_notm}} precisarão das permissões de Gerenciador, Desenvolvedor ou Auditor nesse espaço.

2. Para o cluster do qual você deseja coletar logs de auditoria do servidor de API: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure). **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

**Encaminhando logs**

1. Crie uma configuração de criação de log.

    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource kube-audit --space <cluster_space> --org <cluster_org> --hostname <ingestion_URL> --type ibm
    ```
    {: pre}

    Exemplo de comando e saída:

    ```
    ibmcloud ks logging-config-create myCluster --logsource kube-audit
    Creating logging configuration for kube-audit logs in cluster myCluster...
    OK
    Id                                     Source      Namespace   Host                                   Port     Org    Space   Server Type   Protocol  Application Containers   Paths
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -         ingest-au-syd.logging.bluemix.net✣    9091✣     -       -         ibm          -              -                  -

    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

    ```
    {: screen}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
          <td>O nome ou ID do cluster.</td>
        </tr>
        <tr>
          <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
          <td>O terminal no qual você deseja encaminhar logs. Se você não especificar uma [URL de ingestão](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls), o terminal para a região na qual você criou seu cluster será usado.</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_space&gt;</em></code></td>
          <td>Opcional: o nome do espaço do Cloud Foundry para o qual você deseja enviar logs. Ao encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}}, o espaço e a organização são especificados no ponto de ingestão. Se você não especificar um espaço, os logs serão enviados para o nível de conta.</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_org&gt;</em></code></td>
          <td>O nome da organização do Cloud Foundry em que o espaço está. Esse valor é necessário se você especificou um espaço.</td>
        </tr>
      </tbody>
    </table>

2. Visualize sua configuração de criação de log de cluster para verificar se ela foi implementada da maneira desejada.

    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Exemplo de comando e saída:
    ```
    ibmcloud ks logging-config-get --cluster myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. Opcional: se você desejar parar o encaminhamento de logs de auditoria, será possível [excluir a sua configuração](#log_sources_delete).

<br />



### Enviando logs de auditoria para um servidor externo
{: #audit_enable}

**Antes de começar**

1. Configure um servidor de criação de log remoto para o qual é possível encaminhar os logs. Por exemplo, é possível [usar Logstash com o Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) para coletar eventos de auditoria.

2. Para o cluster do qual você deseja coletar logs de auditoria do servidor de API: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure). **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

Para encaminhar logs de auditoria da API do Kubernetes:

1. Configure o webhook. Se você não fornecer nenhuma informação nas sinalizações, uma configuração padrão será usada.

    ```
    ibmcloud ks apiserver-config-set audit-webhook <cluster_name_or_ID> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

  <table>
  <caption>Entendendo os componentes deste comando</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
        <td>O nome ou ID do cluster.</td>
      </tr>
      <tr>
        <td><code><em>&lt;server_URL&gt;</em></code></td>
        <td>A URL ou o endereço IP para o serviço de criação de log remoto para o qual você deseja enviar logs. Os certificados serão ignorados se você fornecer uma URL não segura do servidor.</td>
      </tr>
      <tr>
        <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
        <td>O caminho de arquivo para o certificado de CA que é usado para verificar o serviço de criação de log remoto.</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_cert_path&gt;</em></code></td>
        <td>O caminho de arquivo para o certificado de cliente que é usado para autenticar com relação ao serviço de criação de log remoto.</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_key_path&gt;</em></code></td>
        <td>O caminho de arquivo para a chave do cliente correspondente que é usada para se conectar ao serviço de criação de log remoto.</td>
      </tr>
    </tbody>
  </table>

2. Verifique se o encaminhamento de log foi ativado visualizando a URL para o serviço de criação de log remoto.

    ```
    ibmcloud ks apiserver-config-get audit-webhook <cluster_name_or_ID>
    ```
    {: pre}

    Saída de exemplo:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Aplique a atualização de configuração reiniciando o mestre dos Kubernetes.

    ```
    ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Opcional: se você desejar parar o encaminhamento de logs de auditoria, será possível desativar sua configuração.
    1. Para o cluster do qual você deseja parar a coleta de logs de auditoria do servidor de API: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
    2. Desative a configuração de backend de webhook para o servidor de API do cluster.

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. Aplique a atualização de configuração reiniciando o mestre dos Kubernetes.

        ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
        {: pre}

<br />


## Coletando logs principais
{: #collect_master}

Com o {{site.data.keyword.containerlong_notm}}, é possível tomar uma captura instantânea de seus logs principais em qualquer momento para coleta em um bucket do {{site.data.keyword.cos_full_notm}}. A captura instantânea inclui qualquer coisa que é enviada por meio do servidor de API, como planejamento de pod, implementações ou políticas RBAC.
{: shortdesc}

Como os logs do servidor de API do Kubernetes são transmitidos automaticamente, eles também são excluídos automaticamente para liberar espaço para os novos logs que estão chegando. Mantendo uma captura instantânea de logs em um momento específico, é possível solucionar melhor os problemas, examinar as diferenças de uso e localizar padrões para ajudar a manter os aplicativos mais seguros.

**Antes de começar**

* [Provisione uma instância](/docs/services/cloud-object-storage/basics?topic=cloud-object-storage-for-developers#provision-an-instance-of-ibm-cloud-object-storage) do {{site.data.keyword.cos_short}} por meio do catálogo do {{site.data.keyword.Bluemix_notm}}.
* Assegure-se de que você tenha a [função de **Administrador** da plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) para o cluster.

** Criando uma Captura Instantânea

1. Crie um depósito de Object Storage por meio do console do {{site.data.keyword.Bluemix_notm}}, seguindo [este tutorial de introdução](/docs/services/cloud-object-storage?topic=cloud-object-storage-getting-started-console-#create-buckets).

2. Gere [credenciais de serviço HMAC](/docs/services/cloud-object-storage/iam?topic=cloud-object-storage-service-credentials) no bucket que você criou.
  1. Na guia **Credenciais de serviço** do painel do {{site.data.keyword.cos_short}}, clique em **Nova credencial**.
  2. Forneça às credenciais HMAC a função de serviço `Writer`.
  3. No campo **Incluir parâmetros de configuração sequenciais**, especifique `{"HMAC":true}`.

3. Por meio da CLI, faça uma solicitação para uma captura instantânea de seus logs principais.

  ```
  ibmcloud ks logging-collect --cluster <cluster name or ID>  --type <type_of_log_to_collect> --cos-bucket <COS_bucket_name> --cos-endpoint <location_of_COS_bucket> --hmac-key-id <HMAC_access_key_ID> --hmac-key <HMAC_access_key> --type <log_type>
  ```
  {: pre}

  Exemplo de comando e resposta:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  There is no specified log type. O mestre padrão será usado.
  Enviando a solicitação de coleção de logs para logs principais para o cluster mycluster... OK A solicitação de coleção de logs foi enviada com êxito. Para visualizar o status da solicitação, execute ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

4. Verifique o status de sua solicitação. Pode levar algum tempo para que a captura instantânea seja concluída, mas é possível verificar se a solicitação está sendo concluída com êxito ou não. É possível localizar o nome do arquivo que contém os logs principais na resposta e usar o console do {{site.data.keyword.Bluemix_notm}} para fazer download do arquivo.

  ```
  ibmcloud ks logging-collect-status --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Saída de exemplo:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## Escolhendo uma solução de monitoramento
{: #view_metrics}

As métricas ajudam a monitorar o funcionamento e o desempenho de seus clusters. É possível usar os recursos padrão do Kubernetes e do tempo de execução do contêiner para monitorar o funcionamento de seus clusters e apps. **Nota**: o monitoramento é suportado somente para clusters padrão.
{:shortdesc}

**A IBM monitora o meu cluster?**

Cada mestre do Kubernetes é monitorado continuamente pela IBM. O {{site.data.keyword.containerlong_notm}} varre automaticamente cada nó no qual o mestre do Kubernetes é implementado para vulnerabilidades localizadas em correções de segurança específicas do Kubernetes e do S.O. Se vulnerabilidades forem localizadas, o {{site.data.keyword.containerlong_notm}} aplicará automaticamente as correções e resolverá as vulnerabilidades em nome do usuário para assegurar proteção do nó principal. Você é responsável por monitorar e analisar os logs para o restante de seus componentes de cluster.

Para evitar conflitos ao usar serviços de métricas, certifique-se de que os clusters entre os grupos de recursos e regiões tenham nomes exclusivos.
{: tip}

<dl>
  <dt>Página de detalhes do cluster no {{site.data.keyword.Bluemix_notm}}</dt>
    <dd>O {{site.data.keyword.containerlong_notm}} fornece informações sobre o
funcionamento e a capacidade do cluster e o uso dos recursos de cluster. É possível usar esse console para ampliar a escala do cluster, trabalhar com seu armazenamento persistente e incluir mais recursos no cluster por meio da ligação de serviços do {{site.data.keyword.Bluemix_notm}}. Para visualizar a página de detalhes do cluster, acesse o **Painel do {{site.data.keyword.Bluemix_notm}}** e selecione um cluster.</dd>
  <dt>Painel do Kubernetes</dt>
    <dd>O painel do Kubernetes é uma interface administrativa da web na qual é possível revisar o funcionamento de seus nós do trabalhador, localizar recursos do Kubernetes, implementar apps conteinerizados e solucionar problemas de apps com informações de criação de log e de monitoramento. Para obter mais informações sobre como acessar o painel do Kubernetes, veja [Ativando o painel do Kubernetes para o {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-app#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>As métricas para clusters padrão estão localizadas na conta do {{site.data.keyword.Bluemix_notm}} para a qual o login foi efetuado quando o cluster do Kubernetes foi criado. Se você especificou um espaço do {{site.data.keyword.Bluemix_notm}} quando criou o cluster, as métricas estão localizadas nesse espaço. As métricas do contêiner são coletadas automaticamente para todos os contêineres que são implementados em um cluster. Essas métricas são enviadas e disponibilizadas por meio de Grafana. Para obter mais informações sobre métricas, veja [Monitoramento para o {{site.data.keyword.containerlong_notm}}](/docs/services/cloud-monitoring/containers?topic=cloud-monitoring-monitoring_bmx_containers_ov#monitoring_bmx_containers_ov).</p>
    <p>Para acessar o painel Grafana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você criou o cluster.</p> <table summary="A primeira linha na tabela abrange ambas as colunas. O restante das linhas deve ser lido da esquerda para a direita, com a zona do servidor na coluna um e os endereços IP para corresponder na coluna dois.">
  <caption>Endereços IP a serem abertos para o tráfego de monitoramento</caption>
        <thead>
        <th>Região do {{site.data.keyword.containerlong_notm}}</th>
        <th>Endereço de monitoramento</th>
        <th>Monitorando sub-redes</th>
        </thead>
      <tbody>
        <tr>
         <td>União Europeia Central</td>
         <td><code>Metrics.eu-de.bluemix.net</code></td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>Sul do Reino Unido</td>
         <td><code>Metrics.eu-gb.bluemix.net</code></td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Leste dos EUA, Sul dos EUA, AP Norte, AP Sul</td>
          <td><code>Metrics.ng.bluemix.net</code></td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
 </dd>
  <dt>{{site.data.keyword.mon_full_notm}}</dt>
  <dd>Obtenha visibilidade operacional para o desempenho e o funcionamento de seus apps implementando o Sysdig como um serviço de terceiro para os nós do trabalhador para encaminhar métricas para o {{site.data.keyword.monitoringlong}}. Para obter mais informações, consulte [Analisando métricas para um app implementado em um cluster do Kubernetes](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster). **Nota**: o {{site.data.keyword.mon_full_notm}} não suporta o tempo de execução do contêiner `containerd`. Quando você usa o {{site.data.keyword.mon_full_notm}} com os clusters da versão 1.11 ou mais recente, nem todas as métricas de contêiner são coletadas.</dd>
</dl>

### Outras ferramentas de monitoramento de funcionamento
{: #health_tools}

É possível configurar outras ferramentas para mais recursos de monitoramento.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada para o Kubernetes. A ferramenta recupera informações detalhadas sobre o cluster, os nós do trabalhador e o funcionamento de implementação com base nas informações de criação de log do Kubernetes. Para obter informações de configuração, veja [Integrando serviços com o {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-integrations#integrations).</dd>
</dl>

<br />


## Configurando o monitoramento de funcionamento para os nós do trabalhador com Recuperação automática
{: #autorecovery}

O sistema de Recuperação automática usa várias verificações para consultar o status de funcionamento do nó do trabalhador. Se a Recuperação automática detecta um nó do trabalhador não funcional com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Somente um nó do trabalhador é submetido a uma ação corretiva por vez. O nó do trabalhador deve concluir com êxito a ação corretiva antes que qualquer nó do trabalhador seja submetido a uma ação corretiva. Para obter mais informações, consulte esta [postagem do blog automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
{: shortdesc}</br> </br>

A recuperação automática requer pelo menos um nó funcional para funcionar corretamente. Configure a Recuperação automática com verificações ativas somente em clusters com dois ou mais nós do trabalhador.
{: note}

Antes de iniciar:
- Assegure-se de que você tenha as [funções do {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) a seguir:
    - Função de plataforma ** Administrador **  para o cluster
    - Função de serviço **Gravador** ou **Gerenciador** para o namespace `kube-system`
- [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Para configurar a Autorização Automática:

1.  [Siga as instruções](/docs/containers?topic=containers-integrations#helm) para instalar o cliente Helm em sua máquina local, instale o servidor Helm (tiller) com uma conta do serviço e inclua o repositório Helm do {{site.data.keyword.Bluemix_notm}}.

2.  Verifique se o tiller está instalado com uma conta do serviço.

    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    Saída de exemplo:

    ```
    NAME SECRETS AGE tiller 1 2m
    ```
    {: screen}

3. Crie um arquivo de mapa de configuração que define suas verificações no formato JSON. Por exemplo, o arquivo YAML a seguir define três verificações: uma verificação de HTTP e duas verificações do servidor da API do Kubernetes. Consulte as tabelas após o arquivo YAML de exemplo para obter informações sobre os três tipos de verificações e informações sobre os componentes individuais das verificações.
</br>
   **Dica:** defina cada verificação como uma chave exclusiva na seção `data` do mapa de configuração.

   ```
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ibm-worker-recovery-checks
     namespace: kube-system
   data:
     checknode.json: |
       {
         "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
        }
      checkpod.json: |
        {
         "Check":"KUBEAPI",
         "Resource":"POD",
         "PodFailureThresholdPercent":50,
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
     checkhttp.json: |
       {
         "Check":"HTTP",
         "FailureThreshold":3,
         "CorrectiveAction":"REBOOT",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Port":80,
         "ExpectedStatus":200,
         "Route":"/myhealth",
         "Enabled":false
       }
   ```
   {:codeblock}

   <table summary="Entendendo os componentes do configmap">
   <caption>Entendendo os componentes do configmap</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/>Entendendo os componentes do configmap</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>O nome de configuração <code>ibm-worker-recovery-checks</code> é uma constante e não pode ser mudado.</td>
   </tr>
   <tr>
   <td><code> namespace</code></td>
   <td>O namespace <code>kube-system</code> é uma constante e não pode ser mudado.</td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Define uma verificação de nó da API do Kubernetes que verifica se cada nó do trabalhador está no estado <code>Ready</code>. A verificação de um nó do trabalhador específico será considerada uma falha se o nó do trabalhador não estiver no estado <code>Ready</code>. A verificação no YAML de exemplo é executada a cada 3 minutos. Se ele falhar três vezes consecutivas, o nó do trabalhador será recarregado. Essa ação é equivalente a executar o <code>ibmcloud ks worker-reload</code>.<br></br>A verificação de nó é ativada até que você configure o campo <b>Ativado</b> como <code>false</code> ou remova a verificação.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
   Define uma verificação de pod da API do Kubernetes que verifica a porcentagem total de pods <code>NotReady</code> em um nó do trabalhador com base no total de pods designados a esse nó do trabalhador. A verificação de um nó do trabalhador específico será considerada uma falha se a porcentagem total de pods <code>NotReady</code> for maior que o <code>PodFailureThresholdPercent</code> definido. A verificação no YAML de exemplo é executada a cada 3 minutos. Se ele falhar três vezes consecutivas, o nó do trabalhador será recarregado. Essa ação é equivalente a executar o <code>ibmcloud ks worker-reload</code>. Por exemplo, o <code>PodFailureThresholdPercent</code> padrão é 50%. Se a porcentagem de pods <code>NotReady</code> for maior que 50% por três vezes consecutivas, o nó do trabalhador será recarregado. <br></br>Por padrão, os pods em todos os namespaces são verificados. Para restringir a verificação somente a pods em um namespace especificado, inclua o campo <code>Namespace</code> na verificação. A verificação de pod é ativada até que você configure o campo <b>Ativado</b> para <code>false</code> ou remova a verificação.
   </td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>Define uma verificação de HTTP que verifica se um servidor HTTP executado em seu nó do trabalhador está funcional. Para usar essa verificação, deve-se implementar um servidor HTTP em cada nó do trabalhador em seu cluster usando um [conjunto de daemons ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). Deve-se implementar uma verificação de funcionamento que esteja disponível no caminho <code>/myhealth</code> e que possa verificar se o servidor HTTP está funcional. É possível definir outros caminhos mudando o parâmetro <strong>Route</strong>. Se o servidor HTTP estiver funcional, deve-se retornar o código de resposta HTTP definido em <strong><code>ExpectedStatus</code></strong>. O servidor HTTP deve ser configurado para atender no endereço IP privado do nó do trabalhador. É possível localizar o endereço IP privado executando <code>kubectl get nodes</code>.<br></br>
   Por exemplo, considere dois nós em um cluster que tenha os endereços IP privados 10.10.10.1 e 10.10.10.2. Nesse exemplo, duas rotas são verificadas para uma resposta HTTP 200: <code>http://10.10.10.1:80/myhealth</code> e <code>http://10.10.10.2:80/myhealth</code>.
   A verificação no YAML de exemplo é executada a cada 3 minutos. Se ela falhar três vezes consecutivas, o nó do trabalhador será reinicializado. Essa ação é equivalente a executar <code>ibmcloud ks worker-reboot</code>.<br></br>A verificação de HTTP é desativada até que você configure o campo <b>Ativado</b> para <code>true</code>.</td>
   </tr>
   </tbody>
   </table>

   <table summary="Understanding individual components of checks">
   <caption>Entendendo os componentes individuais de verificações</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/>Entendendo os componentes individuais de verificações </th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Insira o tipo de verificação que você deseja que a Recuperação automática use. <ul><li><code>HTTP</code>: a Recuperação automática chama os servidores HTTP que são executados em cada nó para determinar se os nós estão sendo executados de forma adequada.</li><li><code>KUBEAPI</code>: a Recuperação automática chama o servidor da API do Kubernetes e lê os dados de status de funcionamento relatados pelos nós do trabalhador.</li></ul></td>
   </tr>
   <tr>
   <td><code>Recurso</code></td>
   <td>Quando o tipo de verificação é <code>KUBEAPI</code>, insira o tipo de recurso que você deseja que a Recuperação automática verifique. Os valores aceitos são <code>NODE</code> ou <code>POD</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Insira o limite para o número de verificações de falhas consecutivas. Quando esse limite é atendido, a Recuperação automática aciona a ação corretiva especificada. Por exemplo, se o valor é 3 e a Recuperação automática falha uma verificação configurada três vezes consecutivas, a Recuperação automática aciona a ação corretiva que está associada à verificação.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>Quando o tipo de recurso for <code>POD</code>, insira o limite para a porcentagem de pods em um nó do trabalhador que pode estar em um estado [<strong><code>NotReady </code></strong> ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Essa porcentagem é baseada no número total de pods que estão planejados para um nó do trabalhador. Quando uma verificação determina que a porcentagem de pods não funcionais é maior que o limite, a verificação conta como uma falha.</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>Insira a ação a ser executada quando o limite de falha for atendido. Uma ação corretiva é executada somente enquanto nenhum outro trabalhador está sendo reparado e quando esse nó do trabalhador não está em um período de bloqueio de uma ação anterior. <ul><li><code>REBOOT</code>: reinicializa o nó do trabalhador.</li><li><code>RELOAD</code>: recarrega todas as configurações necessárias para o nó do trabalhador de um S.O. limpo.</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>Insira o número de segundos que a Recuperação automática deve esperar para emitir outra ação corretiva para um nó em que uma ação corretiva já foi emitida. O período de esfriamento se inicia no momento em que uma ação corretiva é emitida.</td>
   </tr>
   <tr>
   <td><code>IntervalSeconds</code></td>
   <td>Insira o número de segundos entre verificações consecutivas. Por exemplo, se o valor é 180, a Recuperação automática executa a verificação em cada nó a cada 3 minutos.</td>
   </tr>
   <tr>
   <td><code>TimeoutSeconds</code></td>
   <td>Insira o número máximo de segundos que leva uma chamada de verificação para o banco de dados antes de a Recuperação automática terminar a operação de chamada. O valor para <code>TimeoutSeconds</code> deve ser menor que o valor para <code>IntervalSeconds</code>.</td>
   </tr>
   <tr>
   <td><code>Porta</code></td>
   <td>Quando o tipo de verificação é <code>HTTP</code>, insira a porta à qual o servidor HTTP deve ser ligado em nós do trabalhador. Essa porta deve ser exposta no IP de cada nó do trabalhador no cluster. A Recuperação automática requer um número de porta constante em todos os nós para verificar servidores. Use [conjuntos de daemons ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) ao implementar um servidor customizado em um cluster.</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>Quando o tipo de verificação for <code>HTTP</code>, insira o status de servidor HTTP que você espera que seja retornado da verificação. Por exemplo, um valor de 200 indica que você espera uma resposta <code>OK</code> do servidor.</td>
   </tr>
   <tr>
   <td><code>Rota</code></td>
   <td>Quando o tipo de verificação é <code>HTTP</code>, insira o caminho que é solicitado do servidor HTTP. Esse valor é geralmente o caminho de métricas para o servidor que está em execução em todos os nós do trabalhador.</td>
   </tr>
   <tr>
   <td><code>Ativado</code></td>
   <td>Insira <code>true</code> para ativar a verificação ou <code>false</code> para desativar a verificação.</td>
   </tr>
   <tr>
   <td><code> Namespace </code></td>
   <td> Opcional: para restringir <code>checkpod.json</code> a verificar somente os pods em um namespace, inclua o campo <code>Namespace</code> e insira o namespace.</td>
   </tr>
   </tbody>
   </table>

4. Crie o mapa de configuração em seu cluster.

    ```
    Kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

5. Verifique se você criou o mapa de configuração com o nome `ibm-worker-recovery-checks` no namespace `kube-system` com as verificações adequadas.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

6. Implemente a Recuperação automática em seu cluster instalando o gráfico Helm `ibm-worker-recovery`.

    ```
    helm install --name ibm-worker-recovery ibm/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

7. Após alguns minutos, é possível verificar a seção `Events` na saída do comando a seguir para ver a atividade na implementação de Recuperação automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

8. Se você não está vendo atividade na implementação de Recuperação automática, é possível verificar a implementação de Helm executando os testes que estão incluídos na definição de gráfico de Recuperação automática.

    ```
    Helm test ibm-worker-recovery
    ```
    {: pre}
