---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Criação de log e monitoramento de clusters
{: #health}

Configure a criação de log e o monitoramento no {{site.data.keyword.containerlong}} para ajudá-lo a solucionar problemas e melhorar o funcionamento e o desempenho de seus clusters e apps do Kubernetes.
{: shortdesc}


## Configurando o encaminhamento de log
{: #logging}

Com um cluster do Kubernetes padrão no {{site.data.keyword.containershort_notm}}, é possível encaminhar logs de diferentes origens para o {{site.data.keyword.loganalysislong_notm}}, para um servidor syslog externo ou para ambos.
{: shortdesc}

Se você deseja encaminhar logs de uma origem para ambos os servidores de coletor, deve-se criar duas configurações de criação de log.
{: tip}

Verifique a tabela a seguir para obter informações sobre as diferentes origens de log.

<table><caption>Características da origem de log</caption>
  <thead>
    <tr>
      <th>Origem de log</th>
      <th>Características</th>
      <th>Caminhos de log</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>contêiner</code></td>
      <td>Logs para seu contêiner que são executados em um cluster do Kubernetes.</td>
      <td>Qualquer coisa que é registrada em STDOUT ou STDERR em seus contêineres.</td>
    </tr>
    <tr>
      <td><code>aplicação</code></td>
      <td>Logs para o seu próprio aplicativo que é executado em um cluster do Kubernetes.</td>
      <td>É possível configurar os caminhos.</td>
    </tr>
    <tr>
      <td><code>worker</code></td>
      <td>Logs para os nós do trabalhador da máquina virtual em um cluster do Kubernetes.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>kubernetes</code></td>
      <td>Logs para o componente do sistema Kubernetes.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>ingress</code></td>
      <td>Logs para um balanceador de carga de aplicativo de Ingresso que gerencia o tráfego de rede que entra em um cluster.</td>
      <td><code>/var/log/alb/ids/&ast;.log</code>, <code>/var/log/alb/ids/&ast;.err</code>, <code>/var/log/alb/customerlogs/&ast;.log</code>, <code>/var/log/alb/customerlogs/&ast;.err</code></td>
    </tr>
  </tbody>
</table>

Ao configurar a criação de log por meio da UI, deve-se especificar uma organização e um espaço. Se você deseja ativar a criação de log no nível de conta, é possível fazer isso por meio da CLI.
{: tip}


### Antes de começar

1. Verifique as permissões. Se você especificou um espaço quando criou o cluster ou a configuração de criação de log, o proprietário da conta e o proprietário da chave do {{site.data.keyword.containershort_notm}} precisam de permissões de Gerenciador, Desenvolvedor ou Auditor nesse espaço.
  * Se você não sabe quem é o proprietário da chave do {{site.data.keyword.containershort_notm}}, execute o comando a seguir.
      ```
      bx cs api-key-info <cluster_name>
      ```
      {: pre}
  * Para aplicar imediatamente quaisquer mudanças feitas em suas permissões, execute o comando a seguir.
      ```
      bx cs logging-config-refresh <cluster_name>
      ```
      {: pre}

  Para obter mais informações sobre como mudar políticas e permissões de acesso do {{site.data.keyword.containershort_notm}}, veja [Gerenciando o acesso ao cluster](cs_users.html#managing).
  {: tip}

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

  Se você está usando uma conta Dedicada, deve-se efetuar login no terminal público do {{site.data.keyword.cloud_notm}} e destinar a sua organização e o espaço públicos para ativar o encaminhamento de log.
  {: tip}

3. Para encaminhar logs para o syslog, configure um servidor que aceite um protocolo syslog de uma de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.
  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que executa um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

### Ativando o encaminhamento de log

1. Crie uma configuração de encaminhamento de log.
    * Para encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}}:
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

      ```
      $ cs logging-config-create zac2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'zac1,zac2,zac3'
      Creating logging configuration for application logs in cluster zac2...
      OK
      Id                                     Source        Namespace   Host                                    Port    Org   Space   Protocol   Application Containers   Paths
      aa2b415e-3158-48c9-94cf-f8b298a5ae39   application   -           ingest.logging.stage1.ng.bluemix.net✣   9091✣   -     -       ibm        zac1,zac2,zac3           /var/log/apps.log
      ```
      {: screen}

    * Para encaminhar logs para o syslog:
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

  <table>
    <caption>Entendendo os componentes deste comando</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;my_cluster&gt;</em></code></td>
      <td>O nome ou ID do cluster.</td>
    </tr>
    <tr>
      <td><code><em>&lt;my_log_source&gt;</em></code></td>
      <td>A origem da qual você deseja encaminhar logs. Os valores aceitos são <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
      <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
      <td>Opcional: o namespace do Kubernetes do qual você deseja encaminhar logs. O encaminhamento de log não é suportado para os namespaces do Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Esse valor é válido somente para a origem de log do <code>container</code>. Se você não especificar um namespace, todos os namespaces no cluster usarão essa configuração.</td>
    </tr>
    <tr>
      <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
      <td><p>Para {{site.data.keyword.loganalysisshort_notm}}, use a [URL de ingestão](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se não especificar uma URL de ingestão, o terminal para a região na qual você criou o seu cluster será usado.</p>
      <p>Para syslog, especifique o nome do host ou endereço IP do serviço do coletor do log.</p></td>
    </tr>
    <tr>
      <td><code><em>&lt;port&gt;</em></code></td>
      <td>A porta de ingestão. Se você não especificar uma porta, a porta padrão <code>9091</code> será usada.
      <p>Para syslog, especifique a porta do servidor do coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_space&gt;</em></code></td>
      <td>Opcional: o nome do espaço do Cloud Foundry para o qual você deseja enviar logs. Ao encaminhar logs para o {{site.data.keyword.loganalysisshort_notm}}, o espaço e a organização são especificados no ponto de ingestão. Se você não especificar um espaço, os logs serão enviados para o nível de conta.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_org&gt;</em></code></td>
      <td>O nome da organização do Cloud Foundry em que o espaço está. Esse valor é necessário se você especificou um espaço.</td>
    </tr>
    <tr>
      <td><code><em>&lt;type&gt;</em></code></td>
      <td>Onde você deseja encaminhar os logs. As opções são <code>ibm</code>, que encaminha os logs para o {{site.data.keyword.loganalysisshort_notm}} e <code>syslog</code>, que encaminha os logs para um servidor externo.</td>
    </tr>
    <tr>
      <td><code><em>&lt;paths_to_logs&gt;</em></code></td>
      <td>O caminho em seus contêineres no qual os apps estão registrando. Para encaminhar logs com tipo de origem <code>application</code>, deve-se fornecer um caminho. Para especificar mais de um caminho, use uma lista separada por vírgula. Exemplo: <code>/var/log/myApp1/*/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>&lt;containers&gt;</em></code></td>
      <td>Opcional: quando você encaminha logs de apps, é possível especificar o nome do contêiner que contém o seu app. É possível especificar mais de um contêiner usando uma lista separada por vírgula. Se nenhum contêiner é especificado, os logs são encaminhados de todos os contêineres que contêm os caminhos que você forneceu.</td>
    </tr>
  </tbody>
  </table>

2. Verifique se sua configuração está correta de uma de duas maneiras:

    * Para listar todas as configurações de criação de log no cluster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Saída de exemplo:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Para listar as configurações de criação de log para um tipo de origem de log:
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Saída de exemplo:

      ```
      Id Source Namespace Host Port Org Space Protocol Paths f4bc77c0-ee7d-422d-aabf-a4e6b977264e worker - ingest.logging.ng.bluemix.net 9091 - - ibm /var/log/syslog,/var/log/auth.log 5bd9c609-13c8-4c48-9d6e-3a6664c825a9 worker - 172.30.162.138 5514 - - syslog /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

Para fazer uma atualização em sua configuração, siga as mesmas etapas, mas substitua `bx cs logging-config-create` por `bx cs logging-config-update`. Certifique-se de verificar sua atualização.
{: tip}

<br />


## Exibindo logs
{: #view_logs}

Para visualizar os logs para clusters e contêineres, é possível usar os recursos padrão do Kubernetes e de criação de log do Docker.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

É possível visualizar os logs que você encaminhou para o {{site.data.keyword.loganalysislong_notm}} por meio do painel do Kibana.
{: shortdesc}

Se você usou os valores padrão para criar seu arquivo de configuração, seus logs podem ser localizados na conta, ou organização e espaço, em que o cluster foi criado. Se você especificou uma organização e espaço em seu arquivo de configuração, é possível localizar seus logs nesse espaço. Para obter mais informações sobre a criação de log, consulte [Criação de log para o {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

Para acessar o painel do Kibana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} em que você criou o cluster.
- Sul e Leste dos EUA: https://logging.ng.bluemix.net
- Sul do Reino Unido: https://logging.eu-gb.bluemix.net
- UE Central: https://logging.eu-fra.bluemix.net
- AP-South: https://logging.au-syd.bluemix.net

Para obter mais informações sobre como visualizar logs, veja [Navegando para o Kibana por meio de um navegador da web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Logs do Docker
{: #view_logs_docker}

É possível alavancar os recursos de criação de log do Docker integrados para revisar as atividades nos fluxos de saída padrão STDOUT e STDERR. Para obter mais informações, veja [Visualizando logs de contêiner para um contêiner que é executado em um cluster do Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Parando o encaminhamento de log
{: #log_sources_delete}

É possível parar o encaminhamento de logs em uma ou todas as configurações de criação de log para um cluster.
{: shortdesc}

1. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

2. Exclua a configuração de criação de log.
<ul>
<li>Para excluir uma configuração de criação de log:</br>
  <pre><code>bx cs logging-config-rm &lt;my_cluster&gt; --id &lt;log_config_id&gt;</pre></code>
  <table>
    <caption>Entendendo os componentes deste comando</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
      </thead>
        <tbody>
        <tr>
          <td><code><em>&lt;my_cluster&gt;</em></code></td>
          <td>O nome do cluster em que a configuração de criação de log está.</td>
        </tr>
        <tr>
          <td><code><em>&lt;log_config_id&gt;</em></code></td>
          <td>O ID da configuração de origem de log.</td>
        </tr>
        </tbody>
  </table></li>
<li>Para excluir todas as configurações de criação de log:</br>
  <pre><code>bx cs logging-config-rm <my_cluster> --all</pre></code></li>
</ul>

<br />


## Configurando o encaminhamento de log para os logs de auditoria da API do Kubernetes
{: #app_forward}

É possível configurar um webhook por meio do servidor da API do Kubernetes para capturar quaisquer chamadas de seu cluster. Com um webhook ativado, os logs podem ser enviados para um servidor remoto.
{: shortdesc}

Para obter mais informações sobre logs de auditoria do Kubernetes, consulte o <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">tópico de auditoria<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> na documentação do Kubernetes.

* O encaminhamento para logs de auditoria da API do Kubernetes é suportado somente para o Kubernetes versão 1.7 e mais recente.
* Atualmente, uma política de auditoria padrão é usada para todos os clusters com essa configuração de criação de log.
* Os logs de auditoria podem ser encaminhados somente para um servidor externo.
{: tip}

### Ativando o encaminhamento de log de auditoria da API do Kubernetes
{: #audit_enable}

Antes de iniciar:

1. Configure um servidor de criação de log remoto para o qual é possível encaminhar os logs. Por exemplo, é possível [usar Logstash com o Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) para coletar eventos de auditoria.

2. [Destino sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja coletar os logs de auditoria do servidor de API. **Nota**: se você estiver usando uma conta Dedicada, deve-se efetuar login no terminal do {{site.data.keyword.cloud_notm}} público e destinar sua organização e seu espaço públicos para ativar o encaminhamento de log.

Para encaminhar logs de auditoria da API do Kubernetes:

1. Configure o webhook. Se você não fornecer nenhuma informação nas sinalizações, uma configuração padrão será usada.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
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
    </tbody></table>

2. Verifique se o encaminhamento de log foi ativado visualizando a URL para o serviço de criação de log remoto.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
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
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Parando o encaminhamento de log de auditoria da API do Kubernetes
{: #audit_delete}

É possível parar os logs de encaminhamento, desativando a configuração de backend de webhook para o servidor da API do cluster.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster que você deseja parar a coleta de logs de auditoria do servidor de API.

1. Desativar a configuração de backend do webhook para o servidor de API do cluster.

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Aplique a atualização de configuração reiniciando o mestre dos Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## Configurando o monitoramento de cluster
{: #monitoring}

As métricas ajudam a monitorar o funcionamento e o desempenho de seus clusters. É possível configurar o monitoramento de funcionamento para os nós do trabalhador para detectar e corrigir automaticamente quaisquer trabalhadores que entrarem em um estado comprometido ou não operacional. **Nota**: o monitoramento é suportado somente para clusters padrão.
{:shortdesc}

## Visualizando métricas
{: #view_metrics}

É possível usar os recursos padrão do Kubernetes e do Docker para monitorar o funcionamento de seus clusters e apps.
{:shortdesc}

<dl>
  <dt>Página de detalhes do cluster no {{site.data.keyword.Bluemix_notm}}</dt>
    <dd>O {{site.data.keyword.containershort_notm}} fornece informações sobre o funcionamento e a capacidade do cluster e o uso dos recursos de cluster. É possível usar essa GUI para ampliar o cluster, trabalhar com seu armazenamento persistente e incluir mais recursos em seu cluster por meio da ligação de serviços do {{site.data.keyword.Bluemix_notm}}. Para visualizar a página de detalhes do cluster, acesse o **Painel do {{site.data.keyword.Bluemix_notm}}** e selecione um cluster.</dd>
  <dt>Painel do Kubernetes</dt>
    <dd>O painel do Kubernetes é uma interface administrativa da web na qual é possível revisar o funcionamento de seus nós do trabalhador, localizar recursos do Kubernetes, implementar apps conteinerizados e solucionar problemas de apps com informações de criação de log e de monitoramento. Para obter mais informações sobre como acessar o painel do Kubernetes, veja [Ativando o painel do Kubernetes para o {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd>As métricas para clusters padrão estão localizadas na conta do {{site.data.keyword.Bluemix_notm}} para a qual o login foi efetuado quando o cluster do Kubernetes foi criado. Se você especificou um espaço do {{site.data.keyword.Bluemix_notm}} quando criou o cluster, as métricas estão localizadas nesse espaço. As métricas do contêiner são coletadas automaticamente para todos os contêineres que são implementados em um cluster. Essas métricas são enviadas e disponibilizadas por meio de Grafana. Para obter mais informações sobre métricas, veja [Monitoramento para o {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Para acessar o painel Grafana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você criou o cluster.<ul><li>Sul e Leste dos EUA: https://metrics.ng.bluemix.net</li><li>Sul do Reino Unido: https://metrics.eu-gb.bluemix.net</li><li>UE Central: https://metrics.eu-de.bluemix.net</li></ul></p></dd>
</dl>

### Outras ferramentas de monitoramento de funcionamento
{: #health_tools}

É possível configurar outras ferramentas para mais recursos de monitoramento.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus é uma ferramenta de monitoramento, criação de log e alerta de software livre que foi projetada para o Kubernetes. A ferramenta recupera informações detalhadas sobre o cluster, os nós do trabalhador e o funcionamento de implementação com base nas informações de criação de log do Kubernetes. Para obter informações de configuração, veja [Integrando serviços com o {{site.data.keyword.containershort_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configurando o monitoramento de funcionamento para os nós do trabalhador com Recuperação automática
{: #autorecovery}

O sistema de Recuperação automática do {{site.data.keyword.containerlong_notm}} pode ser implementado em clusters existentes do Kubernetes versão 1.7 ou mais recente.
{: shortdesc}

O sistema de Recuperação automática usa várias verificações para consultar o status de funcionamento do nó do trabalhador. Se a Recuperação automática detecta um nó do trabalhador que não está saudável com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Somente um nó do trabalhador é submetido a uma ação corretiva por vez. O nó do trabalhador deve concluir com êxito a ação corretiva antes que qualquer nó do trabalhador seja submetido a uma ação corretiva. Para obter mais informações, consulte esta [postagem do blog automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**NOTA**: a Recuperação automática requer pelo menos um nó saudável para funcionar de maneira adequada. Configure a Recuperação automática com verificações ativas somente em clusters com dois ou mais nós do trabalhador.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja verificar os status do nó do trabalhador.

1. Crie um arquivo de mapa de configuração que define suas verificações no formato JSON. Por exemplo, o arquivo YAML a seguir define três verificações: uma verificação de HTTP e duas verificações do servidor da API do Kubernetes.</br>
   **Dica:** defina cada verificação como uma chave exclusiva na seção de dados do mapa de configuração.

   ```
   kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
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
   <td><code>checkhttp.json</code></td>
   <td>Define uma verificação de HTTP que verifica se um servidor HTTP está em execução em cada endereço IP do nó na porta 80 e retorna uma resposta 200 no caminho <code>/myhealth</code>. É possível localizar o endereço IP para um nó executando <code>kubectl get nodes</code>.
Por exemplo, considere dois nós em um cluster que têm endereços IP de 10.10.10.1 e 10.10.10.2. Neste exemplo, duas rotas são verificadas para respostas 200 OK: <code>http://10.10.10.1:80/myhealth</code> e <code>http://10.10.10.2:80/myhealth</code>.
A verificação no YAML de exemplo é executada a cada 3 minutos. Se isso falha três vezes consecutivas, o nó é reinicializado. Essa ação é equivalente a executar <code>bx cs worker-reboot</code>. A verificação de HTTP é desativada até que você configure o campo <b>Ativado</b> para <code>true</code>.      </td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Define uma verificação de nó da API do Kubernetes que verifica se cada nó está no estado <code>Ready</code>. A verificação de um nó específico conta como uma falha se o nó não está no estado <code>Ready</code>.
A verificação no YAML de exemplo é executada a cada 3 minutos. Se falhar três vezes consecutivas, o nó será recarregado. Essa ação é equivalente a executar o <code>bx cs worker-reload</code>. A verificação de nó é ativada até que você configure o campo <b>Ativado</b> como <code>false</code> ou remova a verificação.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>Define uma verificação de pod da API do Kubernetes que verifica a porcentagem total de pods <code>NotReady</code> em um nó com base no total de pods que são designados a esse nó. A verificação de um nó específico conta como uma falha se a porcentagem total de pods <code>NotReady</code> é maior que o <code>PodFailureThresholdPercent</code> definido.
A verificação no YAML de exemplo é executada a cada 3 minutos. Se falhar três vezes consecutivas, o nó será recarregado. Essa ação é equivalente a executar o <code>bx cs worker-reload</code>. A verificação de pod é ativada até que você configure o campo <b>Ativado</b> para <code>false</code> ou remova a verificação.</td>
   </tr>
   </tbody>
   </table>


   <table summary="Entendendo os componentes de regras individuais">
   <caption>Entendendo os componentes de regras individuais</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/>Entendendo os componentes de regras individuais</th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Insira o tipo de verificação que você deseja que a Recuperação automática use. <ul><li><code>HTTP</code>: a Recuperação automática chama os servidores HTTP que são executados em cada nó para determinar se os nós estão sendo executados de forma adequada.</li><li><code>KUBEAPI</code>: a Recuperação automática chama o servidor da API do Kubernetes e lê os dados de status de funcionamento relatados pelos nós do trabalhador.</li></ul></td>
   </tr>
   <tr>
   <td><code>Recurso</code></td>
   <td>Quando o tipo de verificação é <code>KUBEAPI</code>, insira o tipo de recurso que você deseja que a Recuperação automática verifique. Os valores aceitos são <code>NODE</code> ou <code>PODS</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Insira o limite para o número de verificações de falhas consecutivas. Quando esse limite é atendido, a Recuperação automática aciona a ação corretiva especificada. Por exemplo, se o valor é 3 e a Recuperação automática falha uma verificação configurada três vezes consecutivas, a Recuperação automática aciona a ação corretiva que está associada à verificação.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>Quando o tipo de recurso é <code>PODS</code>, insira o limite para a porcentagem de pods em um nó do trabalhador que pode estar em um estado [NotReady ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Essa porcentagem é baseada no número total de pods que estão planejados para um nó do trabalhador. Quando uma verificação determina que a porcentagem de pods não saudáveis é maior que o limite, a verificação conta como uma falha.</td>
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
   </tbody>
   </table>

2. Crie o mapa de configuração em seu cluster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Verifique se você criou o mapa de configuração com o nome `ibm-worker-recovery-checks` no namespace `kube-system` com as verificações adequadas.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Implemente a Recuperação automática em seu cluster aplicando esse arquivo YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. Após alguns minutos, é possível verificar a seção `Events` na saída do comando a seguir para ver a atividade na implementação de Recuperação automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
