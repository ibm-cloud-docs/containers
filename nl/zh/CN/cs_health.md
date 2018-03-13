---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 日志记录和监视集群
{: #health}

配置集群日志记录和监视可帮助您对集群和应用程序的问题进行故障诊断，并监视集群的运行状况和性能。
{:shortdesc}

## 配置集群日志记录
{: #logging}

可以将日志发送到特定位置以进行处理或长期存储。在 {{site.data.keyword.containershort_notm}} 中的 Kubernetes 集群上，可以为集群启用日志转发并选择日志的转发位置。**注**：对于标准集群，仅支持日志转发。
{:shortdesc}

您可以为日志源（如容器、应用程序、工作程序节点、Kubernetes 集群和 Ingress 控制器）转发日志。
查看下表以获取有关每个日志源的信息。

|日志源|特征|日志路径|
|----------|---------------|-----|
|`container`|在 Kubernetes 集群中运行的容器的日志。|-|
|`application`|在 Kubernetes 集群中运行的自己应用程序的日志。|`/var/log/apps/**/*.log`、`/var/log/apps/**/*.err`|
|`worker`|Kubernetes 集群中虚拟机工作程序节点的日志。|`/var/log/syslog`、`/var/log/auth.log`|
|`Kubernetes`|Kubernetes 系统组件的日志。|`/var/log/kubelet.log`、`/var/log/kube-proxy.log`|
|`ingress`|Ingress 应用程序负载均衡器的日志，用于管理进入 Kubernetes 集群的网络流量。|`/var/log/alb/ids/*.log`、`/var/log/alb/ids/*.err`、`/var/log/alb/customerlogs/*.log`、`/var/log/alb/customerlogs/*.err`|
{: caption="日志源特征" caption-side="top"}

## 启用日志转发
{: #log_sources_enable}

可以将日志转发到 {{site.data.keyword.loganalysislong_notm}} 或外部 syslog 服务器。如果要将来自一个日志源的日志转发到两个日志收集器服务器，那么必须创建两个日志记录配置。
**注**：要转发应用程序的日志，请参阅[为应用程序启用日志转发](#apps_enable)。
{:shortdesc}

开始之前：

1. 如果要将日志转发到外部 syslog 服务器，可以通过以下两种方式来设置接受 syslog 协议的服务器：
  * 设置和管理自己的服务器，或者让提供者为您管理服务器。如果提供者为您管理服务器，请从日志记录提供者获取日志记录端点。
  * 从容器运行 syslog。例如，可以使用此[部署 .yaml 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) 来访存在 Kubernetes 集群中运行容器的 Docker 公共映像。该映像在公共集群 IP 地址上发布端口 `514`，并使用此公共集群 IP 地址来配置 syslog 主机。

2. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

要为容器、工作程序节点、Kubernetes 系统组件、应用程序或 Ingress 应用程序负载均衡器启用日志转发，请执行以下操作：

1. 创建日志转发配置。

  * 将日志转发到 {{site.data.keyword.loganalysislong_notm}}：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>用于创建 {{site.data.keyword.loganalysislong_notm}} 日志转发配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>将 <em>&lt;my_log_source&gt;</em> 替换为日志源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>将 <em>&lt;kubernetes_namespace&gt;</em> 替换为您希望从中转发日志的 Kubernetes 名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对容器日志源有效，并且是可选的。如果未指定名称空间，那么集群中的所有名称空间都将使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>将 <em>&lt;ingestion_URL&gt;</em> 替换为 {{site.data.keyword.loganalysisshort_notm}} 数据获取 URL。您可以在[此处](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)找到可用数据获取 URL 的列表。如果未指定数据获取 URL，那么将使用创建集群所在区域的端点。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>将 <em>&lt;ingestion_port&gt;</em> 替换为数据获取端口。如果未指定端口，那么将使用标准端口 <code>9091</code>。</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>将 <em>&lt;cluster_space&gt;</em> 替换为要将日志发送到的 Cloud Foundry 空间的名称。如果未指定空间，日志将发送到帐户级别。</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>将 <em>&lt;cluster_org&gt;</em> 替换为该空间所在的 Cloud Foundry 组织的名称。如果指定了空间，那么此值是必需的。</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>用于将日志发送到 {{site.data.keyword.loganalysisshort_notm}} 的日志类型。</td>
    </tr>
    </tbody></table>

  * 将日志转发到外部 syslog 服务器：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>用于创建 syslog 日志转发配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>将 <em>&lt;my_log_source&gt;</em> 替换为日志源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>将 <em>&lt;kubernetes_namespace&gt;</em> 替换为您希望从中转发日志的 Kubernetes 名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对容器日志源有效，并且是可选的。如果未指定名称空间，那么集群中的所有名称空间都将使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>将 <em>&lt;log_server_hostname&gt;</em> 替换为日志收集器服务的主机名或 IP 地址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>将 <em>&lt;log_server_port&gt;</em> 替换为日志收集器服务器的端口。如果未指定端口，那么将使用标准端口 <code>514</code>。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>用于将日志发送到 syslog 服务器的日志类型。</td>
    </tr>
    </tbody></table>

2. 验证是否已创建日志转发配置。

    * 列出集群中的所有日志记录配置：
      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      输出示例：

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 列出一种类型的日志源的日志记录配置：
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      输出示例：

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}


### 为应用程序启用日志转发
{: #apps_enable}

应用程序中的日志必须限于主机节点上的特定目录。可以通过使用安装路径将主机路径卷安装到容器来完成此操作。此安装路径充当容器上要将应用程序日志发送到的目录。创建卷安装时，会自动创建预定义的主机路径目录 `/var/log/apps`。

查看应用程序日志转发的以下方面：
* 日志以递归方式从 var/log/apps 路径中进行读取。这意味着可以将应用程序日志置于⁄var/log/apps 路径的子目录中。
* 仅会转发具有 `.log` 或 `.err` 文件扩展名的应用程序日志文件。
* 首次启用日志转发时，会从应用程序日志尾部进行读取，而不是从头进行读取。这意味着不会读取任何日志在启用应用程序日志记录之前已经存在的内容。日志会从启用日志记录时的位置开始进行读取。但是，首次启用日志转发之后，日志将始终从上次停止的位置继续。
* 将 `/var/log/apps` 主机路径卷安装到容器时，容器会全部写入此同一目录。这意味着如果容器要写入相同名称的文件，那么容器会写入主机上完全相同的文件。如果您并不打算这么做，可以通过采用不同方式对每个容器中的日志文件命名，以阻止容器覆盖相同的日志文件。
* 由于所有容器都会写入相同名称的文件，因此不要使用此方法来转发 ReplicaSets 的应用程序日志。可以改为将应用程序中的日志写入 STDOUT 和 STDERR，这会作为容器日志进行选取。要转发写入到 STDOUT 和 STDERR 的应用程序日志，请遵循[启用日志转发](cs_health.html#log_sources_enable)中的步骤。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

1. 打开应用程序的 pod 的 `.yaml` 配置文件。

2. 将以下 `volumeMounts` 和 `volumes` 添加到配置文件：

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

2. 将卷安装到 pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. 要创建日志转发配置，请遵循[启用日志转发](cs_health.html#log_sources_enable)中的步骤。

<br />


## 更新日志转发配置
{: #log_sources_update}

您可以更新容器、应用程序、工作程序节点、Kubernetes 系统组件或 Ingress 应用程序负载均衡器的日志记录配置。
{: shortdesc}

开始之前：

1. 如果要将日志收集器服务器更改为 syslog，那么可以通过以下两种方式来设置接受 syslog 协议的服务器：
  * 设置和管理自己的服务器，或者让提供者为您管理服务器。如果提供者为您管理服务器，请从日志记录提供者获取日志记录端点。
  * 从容器运行 syslog。例如，可以使用此[部署 .yaml 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) 来访存在 Kubernetes 集群中运行容器的 Docker 公共映像。该映像在公共集群 IP 地址上发布端口 `514`，并使用此公共集群 IP 地址来配置 syslog 主机。

2. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

要更改日志记录配置的详细信息，请执行以下操作：

1. 更新日志记录配置。

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>用于为日志源更新日志转发配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td>将 <em>&lt;log_config_id&gt;</em> 替换为日志源配置的标识。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>将 <em>&lt;my_log_source&gt;</em> 替换为日志源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>当日志记录类型为 <code>syslog</code> 时，请将 <em>&lt;log_server_hostname_or_IP&gt;</em> 替换为日志收集器服务的主机名或 IP 地址。当日志记录类型为 <code>ibm</code> 时，请将 <em>&lt;log_server_hostname&gt;</em> 替换为 {{site.data.keyword.loganalysislong_notm}} 数据获取 URL。您可以在[此处](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)找到可用数据获取 URL 的列表。如果未指定数据获取 URL，那么将使用创建集群所在区域的端点。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>将 <em>&lt;log_server_port&gt;</em> 替换为日志收集器服务器的端口。如果未指定端口，那么标准端口 <code>514</code> 将用于 <code>syslog</code>，并且 <code>9091</code> 将用于 <code>ibm</code>。</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>将 <em>&lt;cluster_space&gt;</em> 替换为要将日志发送到的 Cloud Foundry 空间的名称。此值仅对日志类型 <code>ibm</code> 有效，并且是可选的。如果未指定空间，日志将发送到帐户级别。</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>将 <em>&lt;cluster_org&gt;</em> 替换为该空间所在的 Cloud Foundry 组织的名称。此值仅对日志类型 <code>ibm</code> 有效，如果指定了空间，那么此值是必需的。</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>将 <em>&lt;logging_type&gt;</em> 替换为要使用的新日志转发协议。目前支持 <code>syslog</code> 和 <code>ibm</code>。</td>
    </tr>
    </tbody></table>

2. 验证日志转发配置是否已更新。

    * 列出集群中的所有日志记录配置：

      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      输出示例：

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 列出一种类型的日志源的日志记录配置：

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      输出示例：

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

<br />


## 停止日志转发
{: #log_sources_delete}

可以通过删除日志记录配置来停止日志转发。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

1. 删除日志记录配置。

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
将 <em>&lt;my_cluster&gt;</em> 替换为日志记录配置所在集群的名称，并将 <em>&lt;log_config_id&gt;</em> 替换为日志源配置的标识。




<br />


## 为 Kubernetes API 审计日志配置日志转发
{: #app_forward}

Kubernetes API 审计日志从集群中捕获对 Kubernetes API 服务器的任何调用。要开始收集 Kubernetes API 审计日志，您可以配置 Kubernetes API 服务器，以便为集群设置 Webhook 后端。通过此 Webhook 后端，可将日志发送到远程服务器。有关 Kubernetes 审计日志的更多信息，请参阅 Kubernetes 文档中的<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">审计主题 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。

**注**：
* 仅 Kubernetes V1.7 和更新版本支持 Kubernetes API 审计日志的转发。
* 目前，缺省审计策略用于具有此日志记录配置的所有集群。

### 启用 Kubernetes API 审计日志转发
{: #audit_enable}

开始之前：

1. 设置可以转发日志的远程日志记录服务器。例如，您可以[将 Logstash 用于 Kubernetes ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) 以收集审计事件。

2. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为要从中收集 API 服务器审计日志的集群。

转发 Kubernetes API 审计日志：

1. 设置 API 服务器配置的 Webhook 后端。根据您在此命令标志中提供的信息来创建 Webhook 配置。如果未在标志中提供任何信息，那么将使用缺省的 Webhook 配置。

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>用于为集群的 Kubernetes API 服务器配置设置选项的命令。</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>用于为集群的 Kubernetes API 服务器设置审计 Webhook 配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>将 <em>&lt;server_URL&gt;</em> 替换为要将日志发送到的远程日志记录服务的 URL 或 IP 地址。如果提供不安全的服务器 URL，那么将忽略任何证书。</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>将 <em>&lt;CA_cert_path&gt;</em> 替换为用于验证远程日志记录服务的 CA 证书的文件路径。</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>将 <em>&lt;client_cert_path&gt;</em> 替换为用于针对远程日志记录服务进行认证的客户机证书的文件路径。</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>将 <em>&lt;client_key_path&gt;</em> 替换为用于连接到远程日志记录服务的相应客户机密钥的文件路径。</td>
    </tr>
    </tbody></table>

2. 通过查看远程日志记录服务的 URL 来验证是否已启用日志转发。

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    输出示例：
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. 通过重新启动 Kubernetes 主节点来应用配置更新。

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### 停止 Kubernetes API 审计日志转发
{: #audit_delete}

您可以通过禁用集群的 API 服务器的 Webhook 后端配置来停止转发审计日志。

开始之前，请将[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)设置为要从中停止收集 API 服务器审计日志的集群。

1. 禁用集群 API 服务器的 Webhook 后端配置。

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. 通过重新启动 Kubernetes 主节点来应用配置更新。

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## 查看日志
{: #view_logs}

要查看集群和容器的日志，可以使用标准的 Kubernetes 和 Docker 日志记录功能。
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

对于标准集群，日志位于您创建 Kubernetes 集群时登录到的 {{site.data.keyword.Bluemix_notm}} 帐户中。如果在创建集群或创建日志记录配置时指定了 {{site.data.keyword.Bluemix_notm}} 空间，那么日志将位于该空间中。日志在容器外部监视和转发。可以使用 Kibana 仪表板来访问容器的日志。有关日志记录的更多信息，请参阅 [{{site.data.keyword.containershort_notm}} 的日志记录](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

**注**：如果在创建集群或日志记录配置时指定了空间，那么帐户所有者需要该空间的“管理员”、“开发者”或“审计员”许可权才能查看日志。有关更改 {{site.data.keyword.containershort_notm}} 访问策略和许可权的更多信息，请参阅[管理集群访问权](cs_users.html#managing)。更改许可权后，日志可能最长需要 24 小时才会开始显示。

要访问 Kibana 仪表板，请转至以下某个 URL，然后选择在其中创建了集群的 {{site.data.keyword.Bluemix_notm}} 帐户或空间。
- 美国南部和美国东部：https://logging.ng.bluemix.net
- 英国南部：https://logging.eu-gb.bluemix.net
- 欧洲中部：https://logging.eu-fra.bluemix.net
- 亚太南部：https://logging.au-syd.bluemix.net

有关查看日志的更多信息，请参阅[通过 Web 浏览器导航至 Kibana](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)。

### Docker 日志
{: #view_logs_docker}

可以利用内置 Docker 日志记录功能来查看标准 STDOUT 和 STDERR 输出流上的活动。有关更多信息，请参阅[查看在 Kubernetes 集群中运行的容器的容器日志](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

<br />


## 配置集群监视
{: #monitoring}

度量值可帮助您监视集群的运行状况和性能。可以配置工作程序节点的运行状况监视，以自动检测并更正进入已降级或非运行状态的任何工作程序。**注**：仅标准集群支持监视功能。
{:shortdesc}

## 查看度量值
{: #view_metrics}

您可以使用标准 Kubernetes 和 Docker 功能来监视集群和应用程序的运行状况。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}} 中的集群详细信息页面</dt>
<dd>{{site.data.keyword.containershort_notm}} 提供了有关集群的运行状况和容量以及集群资源使用情况的信息。可以使用此 GUI 通过 {{site.data.keyword.Bluemix_notm}} 服务绑定来向外扩展集群、使用持久性存储器以及向集群添加更多功能。要查看集群详细信息页面，请转至 **{{site.data.keyword.Bluemix_notm}} 仪表板**，然后选择集群。</dd>
<dt>Kubernetes 仪表板</dt>
<dd>Kubernetes 仪表板是一个管理 Web 界面，可以在其中查看工作程序节点的运行状况，查找 Kubernetes 资源，部署容器化应用程序，以及使用日志记录和监视信息对应用程序进行故障诊断。有关如何访问 Kubernetes 仪表板的更多信息，请参阅[启动 {{site.data.keyword.containershort_notm}} 的 Kubernetes 仪表板](cs_app.html#cli_dashboard)。</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>标准集群的度量值位于创建 Kubernetes 集群时登录到的 {{site.data.keyword.Bluemix_notm}} 帐户中。如果在创建集群时指定了 {{site.data.keyword.Bluemix_notm}} 空间，那么度量值将位于该空间中。将为集群中部署的所有容器自动收集容器度量值。这些度量值会通过 Grafana 发送并使其可用。有关度量值的更多信息，请参阅[监视 {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)。<p>要访问 Grafana 仪表板，请转至以下某个 URL，然后选择在其中已创建集群的 {{site.data.keyword.Bluemix_notm}} 帐户或空间。<ul><li>美国南部和美国东部：https://metrics.ng.bluemix.net
</li><li>英国南部：https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

### 其他运行状况监视工具
{: #health_tools}

可以配置其他工具来执行更多监视功能。
<dl>
<dt>Prometheus</dt>
<dd>Prometheus 是一个开放式源代码监视、日志记录和警报工具，专为 Kubernetes 而设计。该工具基于 Kubernetes 日志记录信息来检索有关集群、工作程序节点和部署运行状况的详细信息。有关设置信息，请参阅[将服务与 {{site.data.keyword.containershort_notm}} 集成](cs_integrations.html#integrations)。</dd>
</dl>

<br />


## 使用自动恢复为工作程序节点配置运行状况监视
{: #autorecovery}

可以将 {{site.data.keyword.containerlong_notm}} 自动恢复系统部署到 Kubernetes V1.7 或更高版本的现有集群中。自动恢复系统会使用各种检查来查询工作程序节点的运行状态。如果自动恢复根据配置的检查，检测到运行状况欠佳的工作程序节点，那么自动恢复会触发更正操作，例如在工作程序节点上重装操作系统。一次只会对一个工作程序节点执行更正操作。该工作程序节点必须成功完成更正操作后，才能对其他任何工作程序节点执行更正操作。
有关更多信息，请参阅此[自动恢复博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。**注**：自动恢复至少需要一个正常运行的节点才能有效运行。仅在具有两个或两个以上工作程序节点的集群中，将自动恢复配置为执行主动检查。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为要检查其工作程序节点状态的集群。

1. 创建配置映射文件以通过 JSON 格式定义检查。例如，以下 YAML 文件定义了三项检查：一项 HTTP 检查和两项 Kubernetes API 服务器检查。**注**：每项检查都需要定义为配置映射中 data 部分中的唯一键。

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


<table summary="了解配置映射的组成部分">
    <caption>了解配置映射的组成部分</caption>
<thead>
<th colspan=2><img src="images/idea.png"/> 了解配置映射的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>name</code></td>
<td>配置名称 <code>ibm-worker-recovery-checks</code> 是常量，无法更改。</td>
</tr>
<tr>
<td><code>namespace</code></td>
<td><code>kube-system</code> 名称空间是常量，无法更改。</td>
</tr>
<tr>
<td><code>checkhttp.json</code></td>
<td>定义 HTTP 检查，用于检查 HTTP 服务器是否在每个节点的 IP 地址的端口 80 上运行，并在路径 <code>/myhealth</code> 处返回 200 响应。可以通过运行 <code>kubectl get nodes</code> 来查找节点的 IP 地址。
                例如，假设集群中有两个节点，其 IP 地址分别为 10.10.10.1 和 10.10.10.2。在此示例中，会对下面两个路径检查是否返回“200 正常”响应：<code>http://10.10.10.1:80/myhealth</code> 和 <code>http://10.10.10.2:80/myhealth</code>。
               上例 YAML 中的检查每 3 分钟运行一次。如果连续失败 3 次，将重新引导节点。此操作相当于运行 <code>bx cs worker-reboot</code>。HTTP 检查会一直处于禁用状态，直到您将 <b>Enabled</b> 字段设置为 <code>true</code>。</td>
</tr>
<tr>
<td><code>checknode.json</code></td>
<td>定义 Kubernetes API 节点检查，用于检查是否每个节点都处于 <code>Ready</code> 状态。如果特定节点不处于 <code>Ready</code> 状态，那么对该节点的检查计为一次失败。
               上例 YAML 中的检查每 3 分钟运行一次。如果连续失败 3 次，将重新装入节点。此操作相当于运行 <code>bx cs worker-reload</code>。节点检查会一直处于启用状态，直到您将 <b>Enabled</b> 字段设置为 <code>false</code> 或除去检查。</td>
</tr>
<tr>
<td><code>checkpod.json</code></td>
<td>定义 Kubernetes API pod 检查，用于根据分配给节点的 pod 总数来检查该节点上 <code>NotReady</code> pod 的总百分比。如果特定节点的 <code>NotReady</code> pod 的总百分比大于定义的 <code>PodFailureThresholdPercent</code>，那么对该节点的检查计为一次失败。
               上例 YAML 中的检查每 3 分钟运行一次。如果连续失败 3 次，将重新装入节点。此操作相当于运行 <code>bx cs worker-reload</code>。pod 检查会一直处于启用状态，直到您将 <b>Enabled</b> 字段设置为 <code>false</code> 或除去检查。</td>
</tr>
</tbody>
</table>


<table summary="了解单个规则的组成部分">
    <caption>了解单个规则的组成部分</caption>
<thead>
<th colspan=2><img src="images/idea.png"/> 了解单个规则的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>Check</code></td>
<td>输入希望自动恢复使用的检查类型。<ul><li><code>HTTP</code>：自动恢复调用在每个节点上运行的 HTTP 服务器，以确定节点是否在正常运行。</li><li><code>KUBEAPI</code>：自动恢复调用 Kubernetes API 服务器并读取工作程序节点报告的运行状态数据。</li></ul></td>
</tr>
<tr>
<td><code>资源</code></td>
<td>检查类型为 <code>KUBEAPI</code> 时，输入希望自动恢复检查的资源类型。接受的值为 <code>NODE</code> 或 <code>PODS</code>。</td>
</tr>
<tr>
<td><code>FailureThreshold</code></td>
<td>输入检查连续失败次数的阈值。达到此阈值时，自动恢复会触发指定的更正操作。例如，如果值为 3 且自动恢复连续三次执行配置的检查失败，那么自动恢复会触发与检查关联的更正操作。</td>
</tr>
<tr>
<td><code>PodFailureThresholdPercent</code></td>
<td>资源类型为 <code>PODS</code> 时，请输入工作程序节点上可以处于 [NotReady ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状态的 pod 的百分比阈值。此百分比基于安排到一个工作程序节点的 pod 总数。检查确定运行状况欠佳的 pod 百分比大于阈值时，该检查计为一次失败。</td>
</tr>
<tr>
<td><code>CorrectiveAction</code></td>
<td>输入在达到失败阈值时要运行的操作。仅当没有其他工作程序在进行修复，并且此工作程序节点距离执行上一个更正操作的时间已超过等待期时，才会运行更正操作。<ul><li><code>REBOOT</code>：重新引导工作程序节点。</li><li><code>RELOAD</code>：从干净的操作系统重新装入工作程序节点的所有必需配置。</li></ul></td>
</tr>
<tr>
<td><code>CooloffSeconds</code></td>
<td>输入自动恢复在对节点发出更正操作后，必须等待多长时间才能再次向该节点发出其他更正操作（以秒为单位）。等待期自发出更正操作时开始计算。</td>
</tr>
<tr>
<td><code>IntervalSeconds</code></td>
<td>输入连续检查的间隔秒数。例如，如果值为 180，那么自动恢复会每 3 分钟对每个节点运行一次检查。</td>
</tr>
<tr>
<td><code>TimeoutSeconds</code></td>
<td>输入在自动恢复终止调用操作之前，对数据库执行检查调用所用的最长时间（以秒为单位）。<code>TimeoutSeconds</code> 的值必须小于 <code>IntervalSeconds</code> 的值。</td>
</tr>
<tr>
<td><code>端口</code></td>
<td>检查类型为 <code>HTTP</code> 时，请输入工作程序节点上 HTTP 服务器必须绑定到的端口。此端口必须在集群中每个工作程序节点的 IP 上公开。自动恢复需要一个跨所有节点的常量端口号以用于检查服务器。将定制服务器部署到集群中时，请使用 [DaemonSets ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。</td>
</tr>
<tr>
<td><code>ExpectedStatus</code></td>
<td>检查类型为 <code>HTTP</code> 时，请输入期望从检查返回的 HTTP 服务器状态。例如，值为 200 表示期望服务器返回 <code>OK</code> 响应。</td>
</tr>
<tr>
<td><code>Route</code></td>
<td>检查类型为 <code>HTTP</code> 时，请输入从 HTTP 服务器请求的路径。此值通常是在所有工作程序节点上运行的服务器的度量值路径。</td>
</tr>
<tr>
<td><code>Enabled</code></td>
<td>输入 <code>true</code> 以启用检查，或输入 <code>false</code> 以禁用检查。</td>
</tr>
</tbody>
</table>

2. 在集群中创建配置映射。

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 使用相应检查来验证是否已在 `kube-system` 名称空间中创建名称为 `ibm-worker-recovery-checks` 的配置映射。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}


4. 通过应用此 YAML 文件，将自动恢复部署到集群中。

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. 过几分钟后，可以检查以下命令的输出中的 `Events` 部分，以查看自动恢复部署上的活动。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
