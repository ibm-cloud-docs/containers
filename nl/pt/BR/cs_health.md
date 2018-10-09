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


# Criando log e monitorando
{: #health}

Configure a criação de log e o monitoramento no {{site.data.keyword.containerlong}} para ajudá-lo a solucionar problemas e melhorar o funcionamento e o desempenho de seus clusters e apps do Kubernetes.
{: shortdesc}

## Entendendo o cluster e o encaminhamento de log do app
{: #logging}

O monitoramento e a criação de log contínuos são a chave para detectar ataques em seu cluster e questões de resolução de problemas à medida que eles surgem. Monitoramento continuamente seu cluster, você é capaz de entender melhor a capacidade do cluster e a disponibilidade de recursos que estão disponíveis para seu app. Isso permite que você se prepare adequadamente para proteger seus apps com relação ao tempo de inatividade. Para configurar a criação de log, deve-se estar trabalhando com um cluster padrão do Kubernetes no {{site.data.keyword.containerlong_notm}}.
{: shortdesc}


**A IBM monitora o meu cluster?**
Cada mestre do Kubernetes é monitorado continuamente pela IBM. O {{site.data.keyword.containerlong_notm}} varre automaticamente cada nó no qual o mestre do Kubernetes é implementado para vulnerabilidades localizadas em correções de segurança específicas do Kubernetes e do S.O. Se vulnerabilidades forem localizadas, o {{site.data.keyword.containerlong_notm}} aplicará automaticamente as correções e resolverá as vulnerabilidades em nome do usuário para assegurar proteção do nó principal. Você é responsável por monitorar e analisar os logs para o restante de seu cluster.

**Quais são as origens para as quais eu posso configurar a criação de log?**

Na imagem a seguir, é possível ver o local das origens para as quais é possível configurar a criação de log.

![Log sources](images/log_sources.png)

<ol>
<li><p><code>application</code>: informações sobre eventos que ocorrem no nível do aplicativo. Isso pode ser uma notificação de que um evento ocorreu, como um login bem-sucedido, um aviso sobre armazenamento ou outras operações que podem ser executadas no nível do app.</p> <p>Caminhos: é possível configurar os caminhos para os quais seus logs são encaminhados. No entanto, para que os logs sejam enviados, é necessário usar um caminho absoluto em sua configuração de criação de log ou os logs não podem ser lidos. Se o seu caminho estiver montado em seu nó do trabalhador, ele poderá ter criado um link simbólico. Exemplo: se o caminho especificado for <code>/usr/local/<b>spark</b>/work/app-0546/0/stderr</code>, mas os logs realmente forem para <code>/usr/local/<b>spark-1.0-hadoop-1.2</b>/work/app-0546/0/stderr</code>, então os logs não poderão ser lidos.</p></li>

<li><p><code>container</code>: informações que são registradas por um contêiner em execução.</p> <p>Caminhos: qualquer coisa gravada em <code>STDOUT</code> ou <code>STDERR</code>.</p></li>

<li><p><code>ingress</code>: informações sobre o tráfego de rede que entra em um cluster por meio do Balanceador de Carga do Aplicativo do Ingress. Para obter informações de configuração específicas, efetue check-out da [documentação do Ingress](cs_ingress.html#ingress_log_format).</p> <p>Caminhos: <code>/var/log/alb/ids/&ast;.log</code> <code>/var/log/alb/ids/&ast;.err</code>, <code>/var/log/alb/customerlogs/&ast;.log</code>, <code>/var/log/alb/customerlogs/&ast;.err</code></p></li>

<li><p><code>kube-audit</code>: informações sobre as ações relacionadas ao cluster que são enviadas para o servidor de API do Kubernetes; incluindo o horário, o usuário e o recurso afetado.</p></li>

<li><p><code>kubernetes</code>: informações do kubelet, do kube-proxy e de outros eventos do Kubernetes que ocorrem no nó do trabalhador que são executados no namespace do kube-system.</p><p>Paths:  <code> /var/log/kubelet.log </code>,  <code> /var/log/kube-proxy.log </code>,  <code> /var/log/var/log/event-exporter/* .log </code></p></li>

<li><p><code>worker</code>: informações que são específicas para a configuração de infraestrutura que você tem para o nó do trabalhador. Os logs do trabalhador são capturados no syslog e contêm eventos do sistema operacional. No auth.log, é possível localizar informações sobre as solicitações de autenticação que são feitas para o S.O. </p><p>Paths:  <code> /var/log/syslog </code>  e  <code> /var/log/auth.log </code></p></li>
</ol>

</br>

**Quais são as opções de configuração que eu tenho? **

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
      <td>A origem da qual você deseja encaminhar logs. Os valores aceitos são <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code> e <code>kube-audit</code>.</td>
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
      <td><p>Para {{site.data.keyword.loganalysisshort_notm}}, use a [URL de ingestão](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se não especificar uma URL de ingestão, o terminal para a região na qual você criou o seu cluster será usado.</p>
      <p>Para syslog, especifique o nome do host ou endereço IP do serviço do coletor do log.</p></td>
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
      <td>O caminho em um contêiner no qual os apps são registrados. Para encaminhar logs com tipo de origem <code>application</code>, deve-se fornecer um caminho. Para especificar mais de um caminho, use uma lista separada por vírgula. Exemplo: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></td>
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

**Sou responsável por manter o Fluentd para criação de log atualizado?**

Para fazer mudanças em suas configurações de criação de log ou de filtro, o complemento de criação de log Fluentd deve estar na versão mais recente. Por padrão, as atualizações automáticas para o complemento são ativadas. Para desativar atualizações automáticas, consulte [Atualizando complementos do cluster: Fluentd para criação de log](cs_cluster_update.html#logging).

<br />


## Configurando o encaminhamento de log
{: #configuring}

É possível configurar a criação de log para o {{site.data.keyword.containerlong_notm}} por meio da GUI ou da CLI.
{: shortdesc}

### Ativando o encaminhamento de log com a GUI
{: #enable-forwarding-ui}

É possível configurar o encaminhamento de log no painel do {{site.data.keyword.containerlong_notm}}. Pode levar alguns minutos para o processo ser concluído, então, se você não vir logs imediatamente, tente esperar alguns minutos e, em seguida, verifique novamente.

Para criar uma configuração no nível de conta, para um namespace de contêiner específico ou para a criação de log do app, use a CLI.
{: tip}

1. Navegue para a guia **Visão geral** do painel.
2. Selecione a organização e o espaço do Cloud Foundry dos quais você deseja encaminhar logs. Quando você configura o encaminhamento de log no painel, os logs são enviados para o terminal padrão do {{site.data.keyword.loganalysisshort_notm}} para seu cluster. Para encaminhar logs para um servidor externo ou para outro terminal do {{site.data.keyword.loganalysisshort_notm}}, é possível usar a CLI para configurar a criação de log.
3. Selecione as origens de log das quais você deseja encaminhar logs.
4. Clique em
**Criar**.

</br>
</br>

### Ativando o encaminhamento de log com a CLI
{: #enable-forwarding}

É possível criar uma configuração para a criação de log do cluster. É possível diferenciar entre as diferentes opções de criação de log usando sinalizações.

** Forwarding logs para a IBM **

1. Verifique as permissões. Se você especificou um espaço quando criou o cluster ou a configuração de criação de log, o proprietário da conta e o proprietário da chave API do {{site.data.keyword.containerlong_notm}} precisam de [permissões](cs_users.html#access_policies) de Gerenciador, Desenvolvedor ou Auditor nesse espaço.
  * Se você não souber quem é o proprietário da chave API do {{site.data.keyword.containerlong_notm}}, execute o comando a seguir.
      ```
      ibmcloud ks api-key-info <cluster_name>
      ```
      {: pre}
  * Para aplicar imediatamente quaisquer mudanças feitas, execute o comando a seguir.
      ```
      ibmcloud ks logging-config-refresh <cluster_name>
      ```
      {: pre}

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

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
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.stage1.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

Se você tiver apps que são executados em seus contêineres que não podem ser configurados para gravar logs no STDOUT ou STDERR, será possível criar uma configuração de criação de log para encaminhar logs de arquivos de log do app.
{: tip}

</br>
</br>


**Encaminhando logs para seu próprio servidor sobre os protocolos `udp` ou `tcp`**

1. Para encaminhar logs para o syslog, configure um servidor que aceite um protocolo syslog de uma de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.

  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que executa um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

  É possível ver seus logs como JSON válido removendo prefixos de syslog. Para fazer isso, inclua o código a seguir na parte superior de seu arquivo <code>etc/rsyslog.conf</code> no qual o servidor rsyslog está em execução: <code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada. Se você está usando uma conta Dedicada, deve-se efetuar login no terminal público do {{site.data.keyword.cloud_notm}} e destinar a sua organização e o espaço públicos para ativar o encaminhamento de log.

3. Crie uma configuração de encaminhamento de log.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br>
</br>


**Encaminhando logs para o seu próprio servidor sobre o protocolo `tls`**

As etapas a seguir são instruções gerais. Antes de usar o contêiner em um ambiente de produção, certifique-se de que quaisquer requisitos de segurança necessários sejam atendidos.
{: tip}

1. Configure um servidor que aceite um protocolo syslog de uma de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.

  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que executa um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog. Será necessário injetar a Autoridade de Certificação e os certificados do lado do servidor relevantes e atualizar o `syslog.conf` para ativar `tls` em seu servidor.

2. Salve seu certificado de Autoridade de certificação em um arquivo denominado `ca-cert`. Deve ser esse nome exato.

3. Crie um segredo no namespace `kube-system` para o arquivo `ca-cert`. Ao criar sua configuração de criação de log, você usará o nome do segredo para a sinalização `--ca-cert`.
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

4. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada. Se você está usando uma conta Dedicada, deve-se efetuar login no terminal público do {{site.data.keyword.cloud_notm}} e destinar a sua organização e o espaço públicos para ativar o encaminhamento de log.

3. Crie uma configuração de encaminhamento de log.
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
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

* Para listar as configurações de criação de log para um tipo de origem de log:
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br>
</br>

### Atualizando o encaminhamento de log
{: #updating-forwarding}

É possível atualizar uma configuração de criação de log que você já criou.

1. Atualize uma configuração de encaminhamento de log.
    ```
    ibmcloud ks logging-config-update <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### Parando o encaminhamento de log
{: #log_sources_delete}

É possível parar o encaminhamento de logs em uma ou todas as configurações de criação de log para um cluster.
{: shortdesc}

1. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

2. Exclua a configuração de criação de log.
  <ul>
  <li>Para excluir uma configuração de criação de log:</br>
    <pre><code> ibmcloud ks logging-config-rm  &lt;cluster_name_or_ID&gt;  -- id  &lt;log_config_ID&gt;</pre></code></li>
  <li>Para excluir todas as configurações de criação de log:</br>
    <pre><code>ibmcloud ks logging-config-rm <my_cluster> --all</pre></code></li>
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

Se você usou os valores padrão para criar seu arquivo de configuração, seus logs podem ser localizados na conta, ou organização e espaço, em que o cluster foi criado. Se você especificou uma organização e espaço em seu arquivo de configuração, é possível localizar seus logs nesse espaço. Para obter mais informações sobre criação de log, consulte [Criação de log para o {{site.data.keyword.containerlong_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

Para acessar o painel do Kibana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você configurou o encaminhamento de log para o cluster.
- Sul e Leste dos EUA: https://logging.ng.bluemix.net
- Sul do Reino Unido: https://logging.eu-gb.bluemix.net
- UE Central: https://logging.eu-fra.bluemix.net
- AP-South: https://logging.au-syd.bluemix.net

Para obter mais informações sobre como visualizar logs, veja [Navegando para o Kibana por meio de um navegador da web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

</br>

** Logs do contêiner **

É possível alavancar os recursos de criação de log de tempo de execução do contêiner integrado para revisar as atividades nos fluxos de saída padrão STDOUT e STDERR. Para obter mais informações, veja [Visualizando logs de contêiner para um contêiner que é executado em um cluster do Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Filtrando logs
{: #filter-logs}

É possível escolher quais logs encaminhar ao filtrar logs específicos por um período de tempo. É possível diferenciar entre as diferentes opções de filtragem usando sinalizações.

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
  ibmcloud ks logging-filter-get <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. Atualize o filtro de log que você criou.
  ```
  ibmcloud ks logging-filter-update <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. Exclua um filtro de log que você criou.

  ```
  ibmcloud ks logging-filter-rm <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## Configurando o encaminhamento de log para os logs de auditoria da API do Kubernetes
{: #api_forward}

O Kubernetes audita automaticamente quaisquer eventos que são passados por meio de seu apiserver. É possível encaminhar os eventos para o {{site.data.keyword.loganalysisshort_notm}} ou para um servidor externo.
{: shortdesc}


Para obter mais informações sobre logs de auditoria do Kubernetes, consulte o <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">tópico de auditoria<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> na documentação do Kubernetes.

* O encaminhamento para logs de auditoria da API do Kubernetes é suportado somente para o Kubernetes versão 1.7 e mais recente.
* Atualmente, uma política de auditoria padrão é usada para todos os clusters com essa configuração de criação de log.
* Atualmente, os filtros não são suportados.
* Pode haver somente uma configuração `kube-audit` por cluster, mas é possível encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}} e um servidor externo criando uma configuração de criação de log e um webhook.
{: tip}


### Enviando logs de auditoria para {{site.data.keyword.loganalysisshort_notm}}
{: #audit_enable_loganalysis}

É possível encaminhar seus logs de auditoria do servidor de API do Kubernetes para o {{site.data.keyword.loganalysisshort_notm}}

**Antes de começar**

1. Verifique as permissões. Se tiver especificado um espaço quando criou o cluster ou a configuração de criação de log, o proprietário da conta e o proprietário da chave do {{site.data.keyword.containerlong_notm}} precisarão das permissões de Gerenciador, Desenvolvedor ou Auditor nesse espaço.

2. [Destino sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja coletar os logs de auditoria do servidor de API. **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

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
          <td>O terminal no qual você deseja encaminhar logs. Se você não especificar uma [URL de ingestão](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls), o terminal para a região na qual você criou o seu cluster será usado.</td>
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
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

    Exemplo de comando e saída:
    ```
    ibmcloud ks logging-config-get myCluster
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

2. [Destino sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja coletar os logs de auditoria do servidor de API. **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

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
    ibmcloud ks apiserver-refresh <cluster_name_or_ID>
    ```
    {: pre}

4. Opcional: se você desejar parar o encaminhamento de logs de auditoria, será possível desativar sua configuração.
    1. [Destine sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster que você deseja parar a coleta de logs de auditoria do servidor de API.
    2. Desative a configuração de backend de webhook para o servidor de API do cluster.

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. Aplique a atualização de configuração reiniciando o mestre dos Kubernetes.

        ```
        ibmcloud ks apiserver-refresh <cluster_name_or_ID>
        ```
        {: pre}

## Visualizando métricas
{: #view_metrics}

As métricas ajudam a monitorar o funcionamento e o desempenho de seus clusters. É possível usar os recursos padrão do Kubernetes e do tempo de execução do contêiner para monitorar o funcionamento de seus clusters e apps. **Nota**: o monitoramento é suportado somente para clusters padrão.
{:shortdesc}

<dl>
  <dt>Página de detalhes do cluster no {{site.data.keyword.Bluemix_notm}}</dt>
    <dd>O {{site.data.keyword.containerlong_notm}} fornece informações sobre o
funcionamento e a capacidade do cluster e o uso dos recursos de cluster. É possível usar essa GUI para ampliar o cluster, trabalhar com seu armazenamento persistente e incluir mais recursos em seu cluster por meio da ligação de serviços do {{site.data.keyword.Bluemix_notm}}. Para visualizar a página de detalhes do cluster, acesse o **Painel do {{site.data.keyword.Bluemix_notm}}** e selecione um cluster.</dd>
  <dt>Painel do Kubernetes</dt>
    <dd>O painel do Kubernetes é uma interface administrativa da web na qual é possível revisar o funcionamento de seus nós do trabalhador, localizar recursos do Kubernetes, implementar apps conteinerizados e solucionar problemas de apps com informações de criação de log e de monitoramento. Para obter mais informações sobre como acessar o painel do Kubernetes, veja [Ativando o painel do Kubernetes para o {{site.data.keyword.containerlong_notm}}](cs_app.html#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>As métricas para clusters padrão estão localizadas na conta do {{site.data.keyword.Bluemix_notm}} para a qual o login foi efetuado quando o cluster do Kubernetes foi criado. Se você especificou um espaço do {{site.data.keyword.Bluemix_notm}} quando criou o cluster, as métricas estão localizadas nesse espaço. As métricas do contêiner são coletadas automaticamente para todos os contêineres que são implementados em um cluster. Essas métricas são enviadas e disponibilizadas por meio de Grafana. Para obter mais informações sobre métricas, veja [Monitoramento para o {{site.data.keyword.containerlong_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).</p>
    <p>Para acessar o painel Grafana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você criou o cluster.</p> <table summary="A primeira linha na tabela abrange ambas as colunas. O restante das linhas deve ser lido da esquerda para a direita, com a zona do servidor na coluna um e os endereços IP para corresponder na coluna dois.">
  <caption>Endereços IP a serem abertos para o tráfego de monitoramento</caption>
        <thead>
        <th>Região do {{site.data.keyword.containerlong_notm}}</th>
        <th>Endereço de monitoramento</th>
        <th>Endereços IP de monitoramento</th>
        </thead>
      <tbody>
        <tr>
         <td>União Europeia Central</td>
         <td>Metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>Sul do Reino Unido</td>
         <td>Metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Leste dos EUA, Sul dos EUA, AP Norte, AP Sul</td>
          <td>Metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
 </dd>
</dl>

### Outras ferramentas de monitoramento de funcionamento
{: #health_tools}

É possível configurar outras ferramentas para mais recursos de monitoramento.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada para o Kubernetes. A ferramenta recupera informações detalhadas sobre o cluster, os nós do trabalhador e o funcionamento de implementação com base nas informações de criação de log do Kubernetes. Para obter informações de configuração, veja [Integrando serviços com o {{site.data.keyword.containerlong_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configurando o monitoramento de funcionamento para os nós do trabalhador com Recuperação automática
{: #autorecovery}

O sistema de Recuperação automática do {{site.data.keyword.containerlong_notm}} pode ser implementado em clusters existentes do Kubernetes versão 1.7 ou mais recente.
{: shortdesc}

O sistema de Recuperação automática usa várias verificações para consultar o status de funcionamento do nó do trabalhador. Se a Recuperação automática detecta um nó do trabalhador não funcional com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Somente um nó do trabalhador é submetido a uma ação corretiva por vez. O nó do trabalhador deve concluir com êxito a ação corretiva antes que qualquer nó do trabalhador seja submetido a uma ação corretiva. Para obter mais informações, consulte esta [postagem do blog automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).</br> </br>
**Nota**: a recuperação automática requer que pelo menos um nó funcional funcione corretamente. Configure a Recuperação automática com verificações ativas somente em clusters com dois ou mais nós do trabalhador.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja verificar os status do nó do trabalhador.

1. [Instale o Helm para seu cluster e inclua o repositório do {{site.data.keyword.Bluemix_notm}} em sua instância do Helm](cs_integrations.html#helm).

2. Crie um arquivo de mapa de configuração que define suas verificações no formato JSON. Por exemplo, o arquivo YAML a seguir define três verificações: uma verificação de HTTP e duas verificações do servidor da API do Kubernetes. Consulte as tabelas após o arquivo YAML de exemplo para obter informações sobre os três tipos de verificações e informações sobre os componentes individuais das verificações.
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
   <td>Define uma verificação de HTTP que verifica se um servidor HTTP executado em seu nó do trabalhador está funcional. Para usar essa verificação, deve-se implementar um servidor HTTP em cada nó do trabalhador em seu cluster usando um [DaemonSet ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). Deve-se implementar uma verificação de funcionamento que esteja disponível no caminho <code>/myhealth</code> e que possa verificar se o servidor HTTP está funcional. É possível definir outros caminhos mudando o parâmetro <strong>Route</strong>. Se o servidor HTTP estiver funcional, deve-se retornar o código de resposta HTTP definido em <strong>ExpectedStatus</strong>. O servidor HTTP deve ser configurado para atender no endereço IP privado do nó do trabalhador. É possível localizar o endereço IP privado executando <code>kubectl get nodes</code>.<br></br>
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
   <td>Quando o tipo de recurso for <code>POD</code>, insira o limite para a porcentagem de pods em um nó do trabalhador que pode estar em um estado [NotReady ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Essa porcentagem é baseada no número total de pods que estão planejados para um nó do trabalhador. Quando uma verificação determina que a porcentagem de pods não funcionais é maior que o limite, a verificação conta como uma falha.</td>
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
   <td>Quando o tipo de verificação é <code>HTTP</code>, insira a porta à qual o servidor HTTP deve ser ligado em nós do trabalhador. Essa porta deve ser exposta no IP de cada nó do trabalhador no cluster. A Recuperação automática requer um número de porta constante em todos os nós para verificar servidores. Use [DaemonSets ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) ao implementar um servidor customizado em um cluster.</td>
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
   <td><code>Namespace</code></td>
   <td> Opcional: para restringir <code>checkpod.json</code> a verificar somente os pods em um namespace, inclua o campo <code>Namespace</code> e insira o namespace.</td>
   </tr>
   </tbody>
   </table>

3. Crie o mapa de configuração em seu cluster.

    ```
    Kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

3. Verifique se você criou o mapa de configuração com o nome `ibm-worker-recovery-checks` no namespace `kube-system` com as verificações adequadas.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Implemente a Recuperação automática em seu cluster instalando o gráfico Helm `ibm-worker-recovery`.

    ```
    helm install --name ibm-worker-recovery ibm/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

5. Após alguns minutos, é possível verificar a seção `Events` na saída do comando a seguir para ver a atividade na implementação de Recuperação automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

6. Se você não está vendo atividade na implementação de Recuperação automática, é possível verificar a implementação de Helm executando os testes que estão incluídos na definição de gráfico de Recuperação automática.

    ```
    Helm test ibm-worker-recovery
    ```
    {: pre}
