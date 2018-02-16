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


# Criação de log e monitoramento de clusters
{: #health}

Configure a criação de log e o monitoramento de clusters para ajudá-lo a solucionar problemas com seus clusters e apps e monitorar o funcionamento e o desempenho de seus clusters.
{:shortdesc}

## Configurando a criação de log de cluster
{: #logging}

É possível enviar logs para um local específico para processamento ou armazenamento de longo prazo. Em um cluster do Kubernetes no {{site.data.keyword.containershort_notm}}, é possível ativar o encaminhamento de log para seu cluster e escolher para onde os logs serão encaminhados. **Nota**: o encaminhamento de log é suportado somente para clusters padrão.
{:shortdesc}

É possível encaminhar logs para origens de log como contêineres, aplicativos, nós do trabalhador, clusters do Kubernetes e controladores do Ingress. Revise a tabela a seguir para obter informações sobre cada origem de log.

|Origem de log|Características|Caminhos de log|
|----------|---------------|-----|
|`contêiner`|Logs para seu contêiner que são executados em um cluster do Kubernetes.|-|
|`aplicação`|Logs para o seu próprio aplicativo que é executado em um cluster do Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Logs para os nós do trabalhador da máquina virtual em um cluster do Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Logs para o componente do sistema Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Logs para um balanceador de carga de aplicativo, gerenciado pelo controlador do Ingress, que gerencia o tráfego de rede que entra em um cluster do Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Características da origem de log" caption-side="top"}

## Ativando o encaminhamento de log
{: #log_sources_enable}

É possível encaminhar logs para o {{site.data.keyword.loganalysislong_notm}} ou para um servidor syslog externo. Se você deseja encaminhar logs de uma origem de log para ambos os servidores de coletor do log, deve-se criar duas configurações de criação de log. **Observação**: para encaminhar logs para aplicativos, consulte [Ativando o encaminhamento de log para aplicativos](#apps_enable).
{:shortdesc}

Antes de iniciar:

1. Se você deseja encaminhar logs para um servidor syslog externo, é possível configurar um servidor que aceite um protocolo do syslog de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.
  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que execute um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

Para ativar o encaminhamento de log para um contêiner, um nó do trabalhador, um componente do sistema Kubernetes, um aplicativo ou um balanceador de carga do aplicativo Ingress:

1. Crie uma configuração de encaminhamento de log.

  * Para encaminhar logs para o {{site.data.keyword.loganalysislong_notm}}:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>O comando para criar uma configuração do encaminhamento de log do {{site.data.keyword.loganalysislong_notm}}.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Substitua <em>&lt;my_log_source&gt;</em> pela origem de log. Os valores aceitos são <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Substitua <em>&lt;kubernetes_namespace&gt;</em> pelo namespace do Kubernetes do qual você deseja encaminhar logs. O encaminhamento de log não é suportado para os namespaces do Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Esse valor é válido somente para a origem de log do contêiner e é opcional. Se você não especificar um namespace, todos os namespaces no cluster usarão essa configuração.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>Substitua <em>&lt;ingestion_URL&gt;</em> pela URL de ingestão do {{site.data.keyword.loganalysisshort_notm}}. É possível localizar a lista de URLs de ingestão disponíveis [aqui](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se você não especificar uma URL de ingestão, o endpoint para a região na qual seu cluster foi criado será usado.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>Substitua <em>&lt;ingestion_port&gt;</em> com a porta de ingestão. Se você não especificar uma porta, a porta padrão <code>9091</code> será usada.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Substitua <em>&lt;cluster_space&gt;</em> pelo nome do espaço do Cloud Foundry para o qual você deseja enviar logs. Se você não especificar um espaço, os logs serão enviados para o nível de conta.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Substitua <em>&lt;cluster_org&gt;</em> pelo nome da organização do Cloud Foundry em que o espaço está. Esse valor é necessário se você especificou um espaço.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>O tipo de log para enviar logs para o {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Para encaminhar logs para um servidor syslog externo:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>O comando para criar uma configuração de encaminhamento do log syslog.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Substitua <em>&lt;my_log_source&gt;</em> pela origem de log. Os valores aceitos são <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Substitua <em>&lt;kubernetes_namespace&gt;</em> pelo namespace do Kubernetes do qual você deseja encaminhar logs. O encaminhamento de log não é suportado para os namespaces do Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Esse valor é válido somente para a origem de log do contêiner e é opcional. Se você não especificar um namespace, todos os namespaces no cluster usarão essa configuração.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_hostname&gt;</em> pelo nome do host ou pelo endereço IP do serviço de coletor do log.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_port&gt;</em> pela porta do servidor coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>O tipo de log para enviar logs para um servidor syslog externo.</td>
    </tr>
    </tbody></table>

2. Verifique se a configuração de encaminhamento de log foi criada.

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


### Ativando o encaminhamento de log para aplicativos
{: #apps_enable}

Logs de aplicativos devem ser restringidos a um diretório específico no nó do host. É possível fazer isso montando um volume de caminho do host para seus contêineres com um caminho de montagem. Esse caminho de montagem serve como o diretório em seus contêineres nos quais os logs de aplicativos são enviados. O diretório do caminho do host predefinido, `/var/log/apps`, é criado automaticamente quando você cria a montagem do volume.

Revise os aspectos de encaminhamento de log do aplicativo a seguir:
* Os logs são lidos recursivamente do caminho /var/log/apps. Isso significa que é possível colocar logs de aplicativos em subdiretórios do caminho /var/log/apps.
* Somente arquivos de log do aplicativo com extensões de arquivo `.log` ou `.err` são encaminhados.
* Quando você ativa o encaminhamento de log pela primeira vez, os logs de aplicativos são unilaterais em vez de serem lidos do topo. Isso significa que os conteúdos de quaisquer logs já presentes antes que a criação de log do aplicativo fosse ativada não são lidos. Os logs são lidos do ponto em que a criação de log foi ativada. No entanto, após a primeira vez que o encaminhamento de log é ativado, os logs são sempre capturados de onde eles pararam da última vez.
* Ao montar o volume do caminho do host `/var/log/apps` para contêineres, todos os contêineres são gravados nesse mesmo diretório. Isso significa que se os contêineres estiverem gravando no mesmo nome de arquivo, os contêineres gravarão exatamente no mesmo arquivo no host. Se essa não for a sua intenção, será possível evitar que seus contêineres sobrescrevam os mesmos arquivos de log nomeando os arquivos de log de cada contêiner de forma diferente.
* Como todos os contêineres gravam no mesmo nome de arquivo, não use esse método para encaminhar logs de aplicativos para ReplicaSets. Em vez disso, é possível gravar logs de aplicativos para STDOUT e STDERR, que são retirados como logs do contêiner. Para encaminhar logs de aplicativos gravados em STDOUT e STDERR, siga as etapas em [Ativando o encaminhamento de log](cs_health.html#log_sources_enable).

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

1. Abra o arquivo de configuração `.yaml` para o pod do aplicativo.

2. Inclua os `volumeMounts` e `volumes` no arquivo de configuração:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Monte o volume para o pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Para criar uma configuração de encaminhamento de log, siga as etapas em [Ativando o encaminhamento de log](cs_health.html#log_sources_enable).

<br />


## Atualizando a configuração de encaminhamento de log
{: #log_sources_update}

É possível atualizar uma configuração de criação de log para um contêiner, um aplicativo, um nó do trabalhador, um componente do sistema Kubernetes ou um balanceador de carga do aplicativo Ingress.
{: shortdesc}

Antes de iniciar:

1. Se você estiver mudando o servidor de coletor do log para syslog, será possível configurar um servidor que aceite um protocolo do syslog de duas maneiras:
  * Configure e gerencie seu próprio servidor ou faça com que um provedor gerencie-o para você. Se um provedor gerenciar o servidor para você, obtenha o terminal de criação de log do provedor de criação de log.
  * Execute syslog por meio de um contêiner. Por exemplo, é possível usar este [arquivo .yaml de implementação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para buscar uma imagem pública do Docker que execute um contêiner em um cluster do Kubernetes. A imagem publica a porta `514` no endereço IP do cluster público e usa esse endereço IP do cluster público para configurar o host do syslog.

2. [Destine a sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual a origem de log está localizada.

Para mudar os detalhes de uma configuração de log:

1. Atualize a configuração de criação de log.

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Entendendo os componentes deste comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes desse comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>O comando para atualizar a configuração de encaminhamento de log para sua origem de log.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td>Substitua <em>&lt;log_config_id&gt;</em> pelo ID da configuração de origem de log.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Substitua <em>&lt;my_log_source&gt;</em> pela origem de log. Os valores aceitos são <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Quando o tipo de criação de log for <code>syslog</code>, substitua <em>&lt;log_server_hostname_or_IP&gt;</em> pelo nome do host ou pelo endereço IP do serviço do coletor de log. Quando o tipo de criação de log for <code>ibm</code>, substitua <em>&lt;log_server_hostname&gt;</em> pela URL de ingestão do {{site.data.keyword.loganalysislong_notm}}. É possível localizar a lista de URLs de ingestão disponíveis [aqui](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se você não especificar uma URL de ingestão, o endpoint para a região na qual seu cluster foi criado será usado.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Substitua <em>&lt;log_server_port&gt;</em> pela porta do servidor coletor do log. Se você não especificar uma porta, a porta padrão <code>514</code> será usada para <code>syslog</code> e <code>9091</code> será usada para <code>ibm</code>.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Substitua <em>&lt;cluster_space&gt;</em> pelo nome do espaço do Cloud Foundry para o qual você deseja enviar logs. Esse valor é válido somente para o tipo de log <code>ibm</code> e é opcional. Se você não especificar um espaço, os logs serão enviados para o nível de conta.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Substitua <em>&lt;cluster_org&gt;</em> pelo nome da organização do Cloud Foundry em que o espaço está. Esse valor é válido somente para o tipo de log <code>ibm</code> e é necessário se você especificou um espaço.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Substitua <em>&lt;logging_type&gt;</em> pelo novo protocolo de encaminhamento de log que você deseja usar. Atualmente, <code>syslog</code> e <code>ibm</code> são suportados.</td>
    </tr>
    </tbody></table>

2. Verifique se a configuração de encaminhamento de log foi atualizada.

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

<br />


## Parando o encaminhamento de log
{: #log_sources_delete}

É possível parar os logs de encaminhamento excluindo a configuração de criação de log.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster no qual a origem de log está localizada.

1. Exclua a configuração de criação de log.

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
    Substitua <em>&lt;my_cluster&gt;</em> pelo nome do cluster em que a configuração de criação de log está e <em>&lt;log_config_id&gt;</em> pelo ID da configuração de origem de log.

<br />


## Configurando o encaminhamento de log para os logs de auditoria da API do Kubernetes
{: #app_forward}

Os logs de auditoria da API do Kubernetes capturam todas as chamadas para o servidor da API do Kubernetes de seu cluster. Para iniciar a coleta de logs de auditoria da API do Kubernetes, é possível configurar o servidor da API do Kubernetes para configurar um backend de webhook para seu cluster. Esse backend de webhook permite que os logs sejam enviados para um servidor remoto. Para obter mais informações sobre logs de auditoria do Kubernetes, consulte o <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">tópico de auditoria<img src="../icons/launch-glyph.svg" alt="Ícone de link externo"></a> na documentação do Kubernetes.

**Nota**:
* O encaminhamento para os logs de auditoria da API do Kubernetes é suportado apenas para o Kubernetes versão 1.7 e mais recente.
* Atualmente, uma política de auditoria padrão é usada para todos os clusters com essa configuração de criação de log.

### Ativando o encaminhamento de log de auditoria da API do Kubernetes
{: #audit_enable}

Antes de iniciar:

1. Configure um servidor de criação de log remoto para o qual é possível encaminhar os logs. Por exemplo, é possível [usar Logstash com o Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) para coletar eventos de auditoria.

2. [Destino sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja coletar os logs de auditoria do servidor de API.

Para encaminhar logs de auditoria da API do Kubernetes:

1. Configure o backend de webhook para a configuração do servidor de API. Uma configuração de webhook é criada com base nas informações fornecidas nas sinalizações desse comando. Se você não fornecer nenhuma informação nas sinalizações, uma configuração de webhook padrão será usada.

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
    <td><code>apiserver-config-set</code></td>
    <td>O comando para definir uma opção para a configuração do servidor da API do Kubernetes do cluster.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>O subcomando para definir a configuração de webhook de auditoria para o servidor da API do Kubernetes do cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Substitua <em>&lt;my_cluster&gt;</em> pelo nome ou ID do cluster.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>Substitua <em>&lt;server_URL&gt;</em> pela URL ou pelo endereço IP para o serviço de criação de log remoto para o qual você deseja enviar logs. Se você fornecer um serverURL inseguro, todos os certificados serão ignorados.</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Substitua <em>&lt;CA_cert_path&gt;</em> pelo caminho para o certificado de autoridade de certificação que é usado para verificar o serviço de criação de log remoto.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>Substitua <em>&lt;client_cert_path&gt;</em> pelo caminho de arquivo para o certificado de cliente que é usado para autenticar o serviço de registro remoto.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>Substitua <em>&lt;client_key_path&gt;</em> pelo caminho de arquivo para a chave do cliente correspondente que é usada para se conectar ao serviço de registro remoto.</td>
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


## Exibindo logs
{: #view_logs}

Para visualizar os logs para clusters e contêineres, é possível usar os recursos padrão do Kubernetes e de criação de log do Docker.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Para clusters padrão, os logs estão localizados na conta do {{site.data.keyword.Bluemix_notm}} na qual você efetuou login quando criou o cluster do Kubernetes. Se você especificou um espaço {{site.data.keyword.Bluemix_notm}} quando criou o cluster ou quando criou a configuração de criação de log, então os logs estarão localizados nesse espaço. Os logs são monitorados e encaminhados para fora do contêiner. É possível acessar logs para um contêiner usando o painel do Kibana. Para obter mais informações sobre a criação de log, consulte [Criação de log para o {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Observação**: se você especificou um espaço quando criou o cluster ou a configuração de criação de log, então o proprietário da conta precisará das permissões de Gerenciador, de Desenvolvedor ou de Auditor para esse espaço para visualizar logs. Para obter mais informações sobre como mudar políticas e permissões de acesso do {{site.data.keyword.containershort_notm}}, veja [Gerenciando o acesso ao cluster](cs_users.html#managing). Quando as permissões são mudadas, pode levar até 24 horas para os logs começarem a aparecer.

Para acessar o painel do Kibana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} em que você criou o cluster.
- Sul e Leste dos EUA: https://logging.ng.bluemix.net
- Sul do Reino Unido e UE Central: https://logging.eu-fra.bluemix.net
- AP-South: https://logging.au-syd.bluemix.net

Para obter mais informações sobre como visualizar logs, veja [Navegando para o Kibana por meio de um navegador da web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Logs do Docker
{: #view_logs_docker}

É possível alavancar os recursos de criação de log do Docker integrados para revisar as atividades nos fluxos de saída padrão STDOUT e STDERR. Para obter mais informações, veja [Visualizando logs de contêiner para um contêiner que é executado em um cluster do Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

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
<dd>O painel do Kubernetes é uma interface administrativa da web na qual é possível revisar o funcionamento de seus nós do trabalhador, localizar recursos do Kubernetes, implementar apps conteinerizados e solucionar problemas de apps usando informações de criação de log e de monitoramento. Para obter mais informações sobre como acessar o painel do Kubernetes, veja [Ativando o painel do Kubernetes para o {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>As métricas para clusters padrão estão localizadas na conta do {{site.data.keyword.Bluemix_notm}} para a qual o login foi efetuado quando o cluster do Kubernetes foi criado. Se você especificou um espaço do {{site.data.keyword.Bluemix_notm}} quando criou o cluster, as métricas estão localizadas nesse espaço. As métricas do contêiner são coletadas automaticamente para todos os contêineres que são implementados em um cluster. Essas métricas são enviadas e disponibilizadas por meio de Grafana. Para obter mais informações sobre métricas, veja [Monitoramento para o {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Para acessar o painel Grafana, acesse uma das URLs a seguir e selecione a conta ou o espaço do {{site.data.keyword.Bluemix_notm}} no qual você criou o cluster.<ul><li>Sul e Leste dos EUA: https://metrics.ng.bluemix.net</li><li>Sul do Reino Unido: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

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

O sistema de Recuperação automática do {{site.data.keyword.containerlong_notm}} pode ser implementado em clusters existentes do Kubernetes versão 1.7 ou mais recente. O sistema de Recuperação automática usa várias verificações para consultar o status de funcionamento do nó do trabalhador. Se a Recuperação automática detecta um nó do trabalhador que não está saudável com base nas verificações configuradas, a Recuperação automática aciona uma ação corretiva como um recarregamento do S.O. no nó do trabalhador. Somente um nó do trabalhador é submetido a uma ação corretiva por vez. O nó do trabalhador deve concluir com êxito a ação corretiva antes que qualquer nó do trabalhador seja submetido a uma ação corretiva. Para obter mais informações, consulte esta [postagem do blog automática ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**NOTA**: a Recuperação automática requer pelo menos um nó saudável para funcionar de maneira adequada. Configure a Recuperação automática com verificações ativas somente em clusters com dois ou mais nós do trabalhador.

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual você deseja verificar os status do nó do trabalhador.

1. Crie um arquivo de mapa de configuração que define suas verificações no formato JSON. Por exemplo, o arquivo YAML a seguir define três verificações: uma verificação de HTTP e duas verificações do servidor da API do Kubernetes. **Nota**: cada verificação precisa ser definida como uma chave exclusiva na seção de dados do mapa de configuração.

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


    <table summary="Entendendo os componentes de mapa de configuração">
    <caption>Entendendo os componentes de mapa de configuração</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>Entendendo os componentes de mapa de configuração</th>
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
               Por exemplo, considere dois nós em um cluster que têm os endereços IP 10.10.10.1 e 10.10.10.2. Neste exemplo, duas rotas são verificadas para respostas 200 OK: <code>http://10.10.10.1:80/myhealth</code> e <code>http://10.10.10.2:80/myhealth</code>.
               O check-in no YAML do exemplo acima é executado a cada três minutos. Se ele falha 3 vezes consecutivas, o nó é reinicializado. Essa ação é equivalente a executar <code>bx cs worker-reboot</code>. A verificação de HTTP é desativada até que você configure o campo <b>Ativado</b> para <code>true</code>.</td>
        </tr>
        <tr>
          <td><code>checknode.json</code></td>
          <td>Define uma verificação de nó da API do Kubernetes que verifica se cada nó está no estado <code>Ready</code>. A verificação de um nó específico conta como uma falha se o nó não está no estado <code>Ready</code>.
               O check-in no YAML do exemplo acima é executado a cada três minutos. Se ele falhar 3 vezes consecutivas, o nó será recarregado. Essa ação é equivalente a executar o <code>bx cs worker-reload</code>. A verificação de nó é ativada até que você configure o campo <b>Ativado</b> como <code>false</code> ou remova a verificação.</td>
        </tr>
        <tr>
          <td><code>checkpod.json</code></td>
          <td>Define uma verificação de pod da API do Kubernetes que verifica a porcentagem total de pods <code>NotReady</code> em um nó com base no total de pods designados a esse nó. A verificação de um nó específico conta como uma falha se a porcentagem total de pods <code>NotReady</code> é maior que o <code>PodFailureThresholdPercent</code> definido.
               O check-in no YAML do exemplo acima é executado a cada três minutos. Se ele falhar 3 vezes consecutivas, o nó será recarregado. Essa ação é equivalente a executar o <code>bx cs worker-reload</code>. A verificação de pod é ativada até que você configure o campo <b>Ativado</b> para <code>false</code> ou remova a verificação.</td>
        </tr>
      </tbody>
    </table>


    <table summary="Entendendo os componentes de regras individuais">
    <caption>Entendendo os componentes de regras individuais</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>Entendendo os componentes de regras individuais </th>
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
            <td>Insira o número de segundos que a Recuperação automática deve esperar para emitir outra ação corretiva para um nó em que uma ação corretiva já foi emitida. O período de bloqueio se inicia no momento em que uma ação corretiva é emitida.</td>
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

4. Assegure-se de que você tenha criado um segredo de pull do Docker com o nome `international-registry-docker-secret` no namespace `kube-system`. A Recuperação automática é hospedada no registro internacional do Docker do {{site.data.keyword.registryshort_notm}}. Se você não tiver criado um segredo de registro do Docker que contenha credenciais válidas para o registro internacional, crie um para executar o sistema de Recuperação automática.

    1. Instale o plug-in do {{site.data.keyword.registryshort_notm}}.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Direcione o registro internacional.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Crie um token de registro internacional.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Configure a variável de ambiente `INTERNATIONAL_REGISTRY_TOKEN` para o token que você criou.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Configure a variável de ambiente `DOCKER_EMAIL` para o usuário atual. Seu endereço de e-mail é necessário somente para executar o comando `kubectl` na próxima etapa.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Crie o segredo de pull do Docker.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Implemente a Recuperação automática em seu cluster aplicando esse arquivo YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. Após alguns minutos, é possível verificar a seção `Events` na saída do comando a seguir para ver a atividade na implementação de Recuperação automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
