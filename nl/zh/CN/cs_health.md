---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-18"

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



# 日志记录和监视
{: #health}

在 {{site.data.keyword.containerlong}} 中设置日志记录和监视可帮助您对问题进行故障诊断，并提高 Kubernetes 集群和应用程序的运行状况和性能。
{: shortdesc}

持续监视和日志记录是检测对集群的攻击，并在发生问题时对问题进行故障诊断的关键。通过持续监视集群，可以更好地了解集群容量以及可供应用程序使用的资源的可用性。通过此洞察，您可以做好准备以保护应用程序免受停机时间的影响。**注**：要配置日志记录和监视，必须在 {{site.data.keyword.containerlong_notm}} 中使用标准集群。



## 选择日志记录解决方案
{: #logging_overview}

缺省情况下，会在本地为以下所有 {{site.data.keyword.containerlong_notm}} 集群组件生成并写入日志：工作程序节点、容器、应用程序、持久性存储器、Ingress 应用程序负载均衡器、Kubernetes API 和 `kube-system` 名称空间。有多个日志记录解决方案可用于收集、转发和查看这些日志。
{: shortdesc}

您可以根据需要收集其日志的集群组件来选择日志记录解决方案。常用实现是根据日志记录服务的分析和接口功能来选择首选的日志记录服务，例如 {{site.data.keyword.loganalysisfull}}、{{site.data.keyword.la_full}} 或第三方服务。然后，可以使用 {{site.data.keyword.cloudaccesstrailfull}} 来审计集群中的用户活动，并将集群主节点日志备份到 {{site.data.keyword.cos_full}}。**注**：要配置日志记录，必须具有标准 Kubernetes 集群。

<dl>

<dt>{{site.data.keyword.la_full_notm}}</dt>
<dd>通过将 LogDNA 作为第三方服务部署到集群来管理 pod 容器日志。要使用 {{site.data.keyword.la_full_notm}}，必须将日志记录代理程序部署到集群中的每个工作程序节点。此代理程序从所有名称空间（包括 `kube-system`）收集 pod 的 `/var/log` 目录中存储的扩展名为 `*.log` 的日志以及无扩展名文件。然后，代理程序会将这些日志转发到 {{site.data.keyword.la_full_notm}} 服务。有关该服务的更多信息，请参阅 [{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about) 文档。首先，请参阅[使用 {{site.data.keyword.loganalysisfull_notm}} with LogDNA 管理 Kubernetes 集群日志](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube)。</dd>

<dt>将 Fluentd 用于 {{site.data.keyword.loganalysisfull_notm}} 或 syslog</dt>
<dd>要收集、转发和查看集群组件的日志，可以使用 Fluentd 来创建日志记录配置。创建日志记录配置时，[Fluentd ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.fluentd.org/) 集群附加组件会从指定源的路径收集日志。然后，Fluentd 会将这些日志转发到 {{site.data.keyword.loganalysisfull_notm}} 或外部 syslog 服务器。

<ul><li><strong>{{site.data.keyword.loganalysisfull_notm}}</strong>：[{{site.data.keyword.loganalysisshort}}](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_analysis_ov) 扩展了日志收集、保留和搜索能力。创建用于将源的日志转发到 {{site.data.keyword.loganalysisshort_notm}} 的日志记录配置后，可以在 Kibana 仪表板中查看日志。<p class="deprecated">不推荐使用 {{site.data.keyword.loganalysisfull_notm}}。从 2019 年 4 月 30 日开始，您无法供应新的 {{site.data.keyword.loganalysisshort_notm}} 实例，并且所有轻量套餐实例都会被删除。对现有高端套餐实例的支持持续到 2019 年 9 月 30 日。要继续收集集群的日志，可以将 Fluentd 收集的日志转发到外部 syslog 服务器，或者设置 {{site.data.keyword.la_full_notm}}。</p></li>

<li><strong>外部 syslog 服务器</strong>：设置接受 syslog 协议的外部服务器。然后，可以为集群中的源创建日志记录配置，以将日志转发到该外部服务器。</li></ul>

首先，请参阅[了解集群和应用程序日志转发](#logging)。
</dd>

<dt>{{site.data.keyword.cloudaccesstrailfull_notm}}</dt>
<dd>要监视在集群中执行的用户启动的管理活动，您可以收集审计日志并将其转发到 {{site.data.keyword.cloudaccesstrailfull_notm}}。集群会生成两种类型的 {{site.data.keyword.cloudaccesstrailshort}} 事件。

<ul><li>集群管理事件会自动生成并转发到 {{site.data.keyword.cloudaccesstrailshort}}。</li>

<li>Kubernetes API 服务器审计事件会自动生成，但您必须[创建日志记录配置](#api_forward)，Fluentd 才能将这些日志转发到 {{site.data.keyword.cloudaccesstrailshort}}。</li></ul>

有关可以跟踪的 {{site.data.keyword.containerlong_notm}} 事件类型的更多信息，请参阅 [Activity Tracker 事件](/docs/containers?topic=containers-at_events)。有关服务的更多信息，请参阅 [Activity Tracker](/docs/services/cloud-activity-tracker?topic=cloud-activity-tracker-getting-started-with-cla) 文档。
</dd>

<dt>{{site.data.keyword.cos_full_notm}}</dt>
<dd>要收集、转发和查看集群 Kubernetes 主节点的日志，您可以在任意时间点拍摄要在 {{site.data.keyword.cos_full_notm}} 存储区中收集的主节点日志的快照。快照包含通过 API 服务器发送的任何内容，例如 pod 安排、部署或 RBAC 策略。
首先，请参阅[收集主节点日志](#collect_master)。</dd>

<dt>第三方服务</dt>
<dd>如果您有特殊需求，那么可以设置您自己的日志记录解决方案。在[日志记录和监视集成](/docs/containers?topic=containers-supported_integrations#health_services)中，查看可以添加到集群的第三方日志记录服务。在运行 Kubernetes V1.11 或更高版本的集群中，可以从 `/var/log/pods/` 路径中收集容器日志。在运行 Kubernetes V1.10 或更低版本的集群中，可以从 `/var/lib/docker/containers/` 路径中收集容器日志。</dd>

</dl>

## 了解如何将集群和应用程序日志转发到 syslog
{: #logging}

缺省情况下，日志由集群中的 [Fluentd ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.fluentd.org/) 附加组件进行收集。为集群中的源（如容器）创建日志记录配置后，Fluentd 从该源的路径中收集的日志会转发到 {{site.data.keyword.loganalysisshort_notm}} 或外部 syslog 服务器。系统会对摄入端口上从源到日志记录服务的流量进行加密。
{: shortdesc}

不推荐使用 {{site.data.keyword.loganalysisfull_notm}}。从 2019 年 4 月 30 日开始，您无法供应新的 {{site.data.keyword.loganalysisshort_notm}} 实例，并且所有轻量套餐实例都会被删除。对现有高端套餐实例的支持持续到 2019 年 9 月 30 日。要继续收集集群的日志，可以将 Fluentd 收集的日志转发到外部 syslog 服务器，或者设置 {{site.data.keyword.la_full_notm}}。
{: deprecated}

**可以为哪些源配置日志转发？**

在下图中，可以查看可为其配置日志记录的源的位置。

<img src="images/log_sources.png" width="600" alt="集群中的日志源" style="width:600px; border-style: none"/>

1. `worker`：特定于工作程序节点基础架构配置的信息。工作程序日志在 syslog 中进行捕获，并包含操作系统事件。在 `auth.log` 中，可以找到有关对操作系统发出的认证请求的信息。</br>**路径**：
    * `/var/log/syslog`
    * `/var/log/auth.log`

2. `container`：正在运行的容器记录的信息。</br>**路径**：写入 `STDOUT` 或 `STDERR` 的任何内容。

3. `application`：有关在应用程序级别发生的事件的信息。这可能是有关发生了事件（例如成功登录）的通知、有关存储器的警告或可在应用程序级别执行的其他操作。</br>**路径**：可以设置日志转发到的路径。但是，为了发送日志，必须在日志记录配置中使用绝对路径，否则无法读取日志。如果路径安装到工作程序节点上，那么可能已创建符号链接。示例：如果指定的路径为 `/usr/local/spark/work/app-0546/0/stderr`，但日志实际上会转至 `/usr/local/spark-1.0-hadoop-1.2/work/app-0546/0/stderr`，那么无法读取日志。

4. `storage`：有关集群中设置的持久性存储器的信息。存储器日志可以帮助您将问题确定仪表板和警报设置为 DevOps 管道和生产发布的一部分。**注**：路径 `/var/log/kubelet.log` 和 `/var/log/syslog` 也包含存储器日志，但这些路径中的日志由 `kubernetes` 和 `worker` 日志源进行收集。</br>**路径**：
    * `/var/log/ibmc-s3fs.log`
    * `/var/log/ibmc-block.log`

  **pod**：
    * `portworx-***`
    * `ibmcloud-block-storage-attacher-***`
    * `ibmcloud-block-storage-driver-***`
    * `ibmcloud-block-storage-plugin-***`
    * `ibmcloud-object-storage-plugin-***`

5. `kubernetes`：来自在工作程序节点的 kube-system 名称空间中所发生的 kubelet、kube-proxy 和其他 Kubernetes 事件的信息。</br>**路径**：
    * `/var/log/kubelet.log`
    * `/var/log/kube-proxy.log`
    * `/var/log/event-exporter/1..log`

6. `kube-audit`：有关发送到 Kubernetes API 服务器的集群相关操作的信息，包括时间、用户和受影响的资源。

7. `ingress`：有关通过 Ingress ALB 进入集群的网络流量的信息。</br>**路径**：
    * `/var/log/alb/ids/*.log`
    * `/var/log/alb/ids/*.err`
    * `/var/log/alb/customerlogs/*.log`
    * `/var/log/alb/customerlogs/*.err`

</br>

**有哪些配置选项？**

下表显示了配置日志记录时的不同选项及其描述。

<table>
<caption> 了解日志记录配置选项</caption>
  <thead>
    <th>选项</th>
    <th>描述</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
      <td>集群的名称或标识。</td>
    </tr>
    <tr>
      <td><code><em>--log_source</em></code></td>
      <td>要从中转发日志的源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code>、<code>storage</code> 和 <code>kube-audit</code>。此自变量支持要为其应用配置的日志源的逗号分隔列表。如果未提供日志源，那么会为 <code>container</code> 和 <code>ingress</code> 日志源创建日志记录配置。</td>
    </tr>
    <tr>
      <td><code><em>--type</em></code></td>
      <td>要转发日志的位置。选项为 <code>ibm</code>（将日志转发到 {{site.data.keyword.loganalysisshort_notm}}）和 <code>syslog</code>（将日志转发到外部服务器）。<p class="deprecated">不推荐使用 {{site.data.keyword.loganalysisfull_notm}}。对现有高端套餐实例的支持持续到 2019 年 9 月 30 日。请使用 <code>--type syslog</code> 将日志转发到外部 syslog 服务器。</td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>可选：要从中转发日志的 Kubernetes 名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对 <code>container</code> 日志源有效。如果未指定名称空间，那么集群中的所有名称空间都将使用此配置。</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>对于 {{site.data.keyword.loganalysisshort_notm}}，请使用[数据获取 URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls)。如果未指定数据获取 URL，那么将使用在其中创建集群的区域的端点。</p>
      <p>对于 syslog，请指定日志收集器服务的主机名或 IP 地址。</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>数据获取端口。如果未指定端口，那么将使用标准端口 <code>9091</code>。
      <p>对于 syslog，请指定日志收集器服务器的端口。如果未指定端口，那么将使用标准端口 <code>514</code>。</td>
    </tr>
    <tr>
      <td><code><em>--space</em></code></td>
      <td>可选：要向其发送日志的 Cloud Foundry 空间的名称。将日志转发到 {{site.data.keyword.loganalysisshort_notm}} 时，会在数据获取点中指定空间和组织。如果未指定空间，日志将发送到帐户级别。如果确实指定了空间，那么还必须指定组织。</td>
    </tr>
    <tr>
      <td><code><em>--org</em></code></td>
      <td>可选：该空间所在的 Cloud Foundry 组织的名称。如果指定了空间，那么此值是必需的。</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>可选：要转发来自应用程序的日志，可以指定包含应用程序的容器的名称。可以使用逗号分隔列表来指定多个容器。如果未指定任何容器，那么会转发来自包含所提供路径的所有容器中的日志。</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>容器上应用程序要将日志记录到的路径。要转发源类型为 <code>application</code> 的日志，必须提供路径。要指定多个路径，请使用逗号分隔列表。示例：<code>/var/log/myApp1/*,/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>--syslog-protocol</em></code></td>
      <td>日志记录类型为 <code>syslog</code> 时，为传输层协议。可以使用以下协议：`udp`、`tls` 或 `tcp`。使用 <code>udp</code> 协议转发到 rsyslog 服务器时，将截断超过 1 KB 的日志。</td>
    </tr>
    <tr>
      <td><code><em>--ca-cert</em></code></td>
      <td>必需：日志记录类型为 <code>syslog</code> 且协议为 <code>tls</code> 时，包含认证中心证书的 Kubernetes 私钥名称。</td>
    </tr>
    <tr>
      <td><code><em>--verify-mode</em></code></td>
      <td>日志记录类型为 <code>syslog</code> 且协议为 <code>tls</code> 时的验证方式。支持的值为 <code>verify-peer</code> 和缺省值 <code>verify-none</code>。</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>可选：跳过对指定组织和空间名称的验证。跳过验证可减少处理时间，但无效的日志记录配置将无法正确转发日志。</td>
    </tr>
  </tbody>
</table>

**由我负责使 Fluentd 保持更新吗？**

为了对日志记录或过滤器配置进行更改，Fluentd 日志记录附加组件必须为最新版本。缺省情况下，会启用附加组件的自动更新。
要禁用自动更新，请参阅[更新集群附加组件：用于日志记录的 Fluentd](/docs/containers?topic=containers-update#logging-up)。

**我能从集群中的一个源转发某些日志，但不转发其他日志吗？**

可以。例如，如果您有一个通信特别频繁的 pod，您可能希望阻止该 pod 的日志占用日志存储空间，同时仍允许转发其他 pod 的日志。要阻止转发特定 pod 的日志，请参阅[过滤日志](#filter-logs)。

**多个团队在一个集群中工作。如何按团队分隔日志？**

您可以将一个名称空间中的容器日志转发到一个 Cloud Foundry 空间，并将另一个名称空间中的容器日志转发到其他 Cloud Foundry 空间。对于每个名称空间，为 `container` 日志源创建日志转发配置。在 `--namespace` 标志中指定要应用配置的团队名称空间，并在 `--space` 标志中指定日志要转发到的团队空间。您还可以选择在 `--org` 标志中指定空间内的 Cloud Foundry 组织。

<br />


## 将集群和应用程序日志转发到 syslog
{: #configuring}

可以通过控制台或 CLI 为 {{site.data.keyword.containerlong_notm}} 标准集群配置日志记录。
{: shortdesc}

不推荐使用 {{site.data.keyword.loganalysisfull_notm}}。从 2019 年 4 月 30 日开始，您无法供应新的 {{site.data.keyword.loganalysisshort_notm}} 实例，并且所有轻量套餐实例都会被删除。对现有高端套餐实例的支持持续到 2019 年 9 月 30 日。要继续收集集群的日志，可以将 Fluentd 收集的日志转发到外部 syslog 服务器，或者设置 {{site.data.keyword.la_full_notm}}。
{: deprecated}

### 使用 {{site.data.keyword.Bluemix_notm}} 控制台启用日志转发
{: #enable-forwarding-ui}

可以在 {{site.data.keyword.containerlong_notm}} 仪表板中配置日志转发。完成此过程可能需要几分钟时间，因此，如果您未立即看到日志，请尝试等待几分钟，然后再检查。
{: shortdesc}

要在帐户级别、针对特定容器名称空间或针对应用程序日志记录创建配置，请使用 CLI。
{: tip}

开始之前，请[创建](/docs/containers?topic=containers-clusters#clusters)或识别要使用的标准集群。

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://cloud.ibm.com/kubernetes/clusters)，并浏览至 **Kubernetes > 集群**。
2. 选择标准集群，然后在**概述**选项卡的**日志**字段中，单击**启用**。
3. 选择要从中转发日志的 **Cloud Foundry 组织**和**空间**。在仪表板中配置日志转发时，日志将发送到集群的缺省 {{site.data.keyword.loganalysisshort_notm}} 端点。要将日志转发到外部服务器或其他 {{site.data.keyword.loganalysisshort_notm}} 端点，可以使用 CLI 来配置日志记录。
4. 选择要从中转发日志的**日志源**。
5. 单击**创建**。

</br>
</br>

### 使用 CLI 启用日志转发
{: #enable-forwarding}

可以针对集群日志记录创建配置。您可以使用标志来区分不同的日志记录选项。
{: shortdesc}

开始之前，请[创建](/docs/containers?topic=containers-clusters#clusters)或识别要使用的标准集群。

**通过 `udp` 或 `tcp` 协议将日志转发到您自己的服务器**

1. 确保您具有 [{{site.data.keyword.Bluemix_notm}} IAM **编辑者**或**管理员**平台角色](/docs/containers?topic=containers-users#platform)。

2. 对于日志源所在的集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. 要将日志转发到 syslog，请通过以下两种方式之一来设置接受 syslog 协议的服务器：
  * 设置和管理您自己的服务器，或者让提供者为您管理服务器。如果提供者为您管理服务器，请从日志记录提供者获取日志记录端点。

  * 从容器运行 syslog。例如，可以使用此[部署 .yaml 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) 来访存在集群中运行容器的 Docker 公共映像。该映像在公共集群 IP 地址上发布端口 `514`，并使用此公共集群 IP 地址来配置 syslog 主机。

  可以通过除去 syslog 前缀，将日志作为有效 JSON 进行查看。为此，请将以下代码添加到运行 rsyslog 服务器的 <code>etc/rsyslog.conf</code> 文件的顶部：<code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

4. 创建日志转发配置。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br></br>

**通过 `tls` 协议将日志转发到您自己的服务器**

以下步骤是常规指示信息。在生产环境中使用容器之前，请确保满足所需的任何安全需求。
{: tip}

1. 确保您具有以下 [{{site.data.keyword.Bluemix_notm}} IAM 角色](/docs/containers?topic=containers-users#platform)：
    * 对集群的**编辑者**或**管理员**平台角色
    * 对 `kube-system` 名称空间的**写入者**或**管理者**服务角色

2. 对于日志源所在的集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. 通过以下两种方式之一来设置接受 syslog 协议的服务器：
  * 设置和管理您自己的服务器，或者让提供者为您管理服务器。如果提供者为您管理服务器，请从日志记录提供者获取日志记录端点。

  * 从容器运行 syslog。例如，可以使用此[部署 .yaml 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) 来访存在集群中运行容器的 Docker 公共映像。该映像在公共集群 IP 地址上发布端口 `514`，并使用此公共集群 IP 地址来配置 syslog 主机。您必须注入相关认证中心和服务器端证书，并更新 `syslog.conf` 以在服务器上启用 `tls`。

4. 将认证中心证书保存为名为 `ca-cert` 的文件。名称必须与此完全相同。

5. 在 `kube-system` 名称空间中为 `ca-cert` 文件创建私钥。创建日志记录配置时，将私钥名称用于 `--ca-cert` 标志。
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

6. 创建日志转发配置。
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br></br>

**将日志转发到 {{site.data.keyword.loganalysisfull_notm}}**

不推荐使用 {{site.data.keyword.loganalysisfull_notm}}。从 2019 年 4 月 30 日开始，您无法供应新的 {{site.data.keyword.loganalysisshort_notm}} 实例，并且所有轻量套餐实例都会被删除。对现有高端套餐实例的支持持续到 2019 年 9 月 30 日。要继续收集集群的日志，可以将 Fluentd 收集的日志转发到外部 syslog 服务器，或者设置 {{site.data.keyword.la_full_notm}}。
{: deprecated}

1. 验证许可权。
    1. 确保您具有 [{{site.data.keyword.Bluemix_notm}} IAM **编辑者**或**管理员**平台角色](/docs/containers?topic=containers-users#platform)。
    2. 如果在创建集群时指定了空间，那么您和 {{site.data.keyword.containerlong_notm}} API 密钥所有者都需要该空间的 [Cloud Foundry **开发者**角色](/docs/iam?topic=iam-mngcf)。
      * 如果您不知道谁是 {{site.data.keyword.containerlong_notm}} API 密钥所有者，请运行以下命令。
      ```
          ibmcloud ks api-key-info --cluster <cluster_name>
          ```
          {: pre}
      * 如果更改了许可权，那么可以通过运行以下命令来立即应用更改。
          ```
          ibmcloud ks logging-config-refresh --cluster <cluster_name>
          ```
          {: pre}

2.  对于日志源所在的标准集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. 创建日志转发配置。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --type ibm --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs> --skip-validation
    ```
    {: pre}

  * 缺省名称空间的容器日志记录配置以及输出示例：
      ```
    ibmcloud ks logging-config-create mycluster
    Creating cluster mycluster logging configurations...
    OK
    ID                                      Source      Namespace    Host                                 Port    Org  Space   Server Type   Protocol   Application Containers   Paths
    4e155cf0-f574-4bdb-a2bc-76af972cae47    container       *        ingest.logging.eu-gb.bluemix.net✣   9091✣    -     -        ibm           -                  -               -
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

      ```
    {: screen}

  * 应用程序日志记录配置和输出示例：
      ```
    ibmcloud ks logging-config-create cluster2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'container1,container2,container3'
    Creating logging configuration for application logs in cluster cluster2...
    OK
    Id                                     Source        Namespace   Host                                    Port    Org   Space   Server Type   Protocol   Application Containers               Paths
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

      ```
    {: screen}

如果在容器中运行的应用程序无法配置为将日志写入到 STDOUT 或 STDERR，那么可以创建日志记录配置以从应用程序日志文件转发日志。
{: tip}

</br></br>

### 验证日志转发
{: verify-logging}

可以通过以下两种方式之一来验证配置是否正确设置：

* 列出集群中的所有日志记录配置：
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

* 列出一种类型日志源的日志记录配置：
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br></br>

### 更新日志转发
{: #updating-forwarding}

可以更新已创建的日志记录配置。
{: shortdesc}

1. 更新日志转发配置。
    ```
    ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### 停止日志转发
{: #log_sources_delete}

可以停止集群的一个或全部日志记录配置的日志转发。
{: shortdesc}

1. 对于日志源所在的集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

2. 删除日志记录配置。
  <ul>
  <li>删除一个日志记录配置：</br>
    <pre><code>ibmcloud ks logging-config-rm --cluster &lt;cluster_name_or_ID&gt; --id &lt;log_config_ID&gt;</pre></code></li>
  <li>删除所有日志记录配置：</br>
    <pre><code>ibmcloud ks logging-config-rm --cluster <my_cluster> --all</pre></code></li>
  </ul>

</br>
</br>

### 查看日志
{: #view_logs}

要查看集群和容器的日志，可以使用标准的 Kubernetes 和容器运行时日志记录功能。
{:shortdesc}

**{{site.data.keyword.loganalysislong_notm}}**
{: #view_logs_k8s}

可以通过 Kibana 仪表板查看转发到 {{site.data.keyword.loganalysislong_notm}} 的日志。
{: shortdesc}

如果使用缺省值来创建配置文件，那么可以在创建集群的帐户或者组织和空间中找到日志。如果在配置文件中指定了组织和空间，那么可以在该空间中找到日志。有关日志记录的更多信息，请参阅 [{{site.data.keyword.containerlong_notm}} 的日志记录](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes)。

要访问 Kibana 仪表板，请转至下列其中一个 URL，然后选择在其中配置了集群日志转发的 {{site.data.keyword.Bluemix_notm}} 帐户或空间。
- 美国南部和美国东部：`https://logging.ng.bluemix.net`
- 英国南部：`https://logging.eu-gb.bluemix.net`
- 欧洲中部：`https://logging.eu-fra.bluemix.net`
- 亚太地区南部和亚太地区北部：`https://logging.au-syd.bluemix.net`

有关查看日志的更多信息，请参阅[通过 Web 浏览器导航至 Kibana](/docs/services/CloudLogAnalysis/kibana?topic=cloudloganalysis-launch#launch_Kibana_from_browser)。

</br>

**容器日志**

可以利用内置容器运行时日志记录功能来查看标准 STDOUT 和 STDERR 输出流上的活动。有关更多信息，请参阅[查看在 Kubernetes 集群中运行的容器的容器日志](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes)。

<br />


## 过滤转发到 syslog 的日志
{: #filter-logs}

可以通过过滤掉某段时间内的特定日志来选择转发的日志。您可以使用标志来区分不同的过滤选项。
{: shortdesc}

<table>
<caption>了解日志过滤的选项</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解日志过滤选项</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;cluster_name_or_ID&gt;</td>
      <td>必需：要过滤其日志的集群的名称或标识。</td>
    </tr>
    <tr>
      <td><code>&lt;log_type&gt;</code></td>
      <td>要应用过滤器的日志的类型。目前支持 <code>all</code>、<code>container</code> 和 <code>host</code>。</td>
    </tr>
    <tr>
      <td><code>&lt;configs&gt;</code></td>
      <td>可选：日志记录配置标识的逗号分隔列表。如果未提供，过滤器将应用于传递到过滤器的所有集群日志记录配置。可以使用 <code>--show-matching-configs</code> 选项来查看与过滤器相匹配的日志配置。</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes_namespace&gt;</code></td>
      <td>可选：要从中转发日志的 Kubernetes 名称空间。仅当使用日志类型 <code>container</code> 时，此标志才适用。</td>
    </tr>
    <tr>
      <td><code>&lt;container_name&gt;</code></td>
      <td>可选：要从中过滤日志的容器的名称。</td>
    </tr>
    <tr>
      <td><code>&lt;logging_level&gt;</code></td>
      <td>可选：过滤掉处于指定级别及更低级别的日志。规范顺序的可接受值为 <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code> 和 <code>trace</code>。例如，如果过滤掉 <code>info</code> 级别的日志，那么还会过滤掉 <code>debug</code> 和 <code>trace</code>。**注**：仅当日志消息为 JSON 格式且包含 level 字段时，才能使用此标志。要以 JSON 格式显示消息，请向命令附加 <code>--json</code> 标志。</td>
    </tr>
    <tr>
      <td><code>&lt;message&gt;</code></td>
      <td>可选：过滤掉包含编写为正则表达式的指定消息的日志。</td>
    </tr>
    <tr>
      <td><code>&lt;filter_ID&gt;</code></td>
      <td>可选：日志过滤器的标识。</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>可选：显示每个过滤器应用于的日志记录配置。</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>可选：删除所有日志转发过滤器。</td>
    </tr>
  </tbody>
</table>

1. 创建日志记录过滤器。
  ```
  ibmcloud ks logging-filter-create <cluster_name_or_ID> --type <log_type> --logging-configs <configs> --namespace <kubernetes_namespace> --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

2. 查看创建的日志过滤器。

  ```
  ibmcloud ks logging-filter-get --cluster <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. 更新创建的日志过滤器。
  ```
  ibmcloud ks logging-filter-update --cluster <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. 删除创建的日志过滤器。

  ```
  ibmcloud ks logging-filter-rm --cluster <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## 将 Kubernetes API 审计日志转发到 {{site.data.keyword.cloudaccesstrailfull_notm}} 或 syslog
{: #api_forward}

Kubernetes 会自动审计通过 Kubernetes API 服务器传递的任何事件。可以将日志转发到 {{site.data.keyword.cloudaccesstrailfull_notm}} 或外部服务器。
{: shortdesc}

有关 Kubernetes 审计日志的更多信息，请参阅 Kubernetes 文档中的<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">审计主题 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。

* 目前，缺省审计策略用于具有此日志记录配置的所有集群。
* 目前不支持过滤器。
* 每个集群只能有一个 `kube-audit` 配置，但可以通过创建日志记录配置和 Webhook，将日志转发到 {{site.data.keyword.cloudaccesstrailshort}} 和外部服务器。

* 您必须具有对集群的 [{{site.data.keyword.Bluemix_notm}} IAM **管理员**平台角色](/docs/containers?topic=containers-users#platform)。

### 将审计日志转发到 {{site.data.keyword.cloudaccesstrailfull_notm}}
{: #audit_enable_loganalysis}

可以将 Kubernetes API 服务器审计日志转发到 {{site.data.keyword.cloudaccesstrailfull_notm}}。
{: shortdesc}

**开始之前**

1. 验证许可权。如果在创建集群时指定了空间，那么帐户所有者和 {{site.data.keyword.containerlong_notm}} 密钥所有者都需要该空间的“管理者”、“开发者”或“审计员”许可权。

2. 对于要从中收集 API 服务器审计日志的集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

**转发日志**

1. 创建日志记录配置。

    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource kube-audit --space <cluster_space> --org <cluster_org> --hostname <ingestion_URL> --type ibm
    ```
    {: pre}

    示例命令和输出：

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
    <caption>了解此命令的组成部分</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
          <td>集群的名称或标识。</td>
        </tr>
        <tr>
          <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
          <td>要从中转发日志的端点。如果未指定[数据获取 URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls)，那么将使用在其中创建集群的区域的端点。</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_space&gt;</em></code></td>
          <td>可选：要向其发送日志的 Cloud Foundry 空间的名称。将日志转发到 {{site.data.keyword.loganalysisshort_notm}} 时，会在数据获取点中指定空间和组织。如果未指定空间，日志将发送到帐户级别。</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_org&gt;</em></code></td>
          <td>该空间所在 Cloud Foundry 组织的名称。如果指定了空间，那么此值是必需的。</td>
        </tr>
      </tbody>
    </table>

2. 查看集群日志记录配置，以验证它是否已按预期方式实现。

    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    示例命令和输出：
    ```
    ibmcloud ks logging-config-get --cluster myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. 可选：如果要停止转发审计日志，可以[删除配置](#log_sources_delete)。

### 将审计日志转发到外部 syslog 服务器
{: #audit_enable}

**开始之前**

1. 设置可以转发日志的远程日志记录服务器。例如，您可以[将 Logstash 用于 Kubernetes ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) 以收集审计事件。

2. 对于要从中收集 API 服务器审计日志的集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

转发 Kubernetes API 审计日志：

1. 设置 Webhook。如果未在标志中提供任何信息，那么将使用缺省配置。

    ```
    ibmcloud ks apiserver-config-set audit-webhook <cluster_name_or_ID> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

  <table>
  <caption>了解此命令的组成部分</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
        <td>集群的名称或标识。</td>
      </tr>
      <tr>
        <td><code><em>&lt;server_URL&gt;</em></code></td>
        <td>要向其发送日志的远程日志记录服务的 URL 或 IP 地址。如果提供了不安全的服务器 URL，那么将忽略证书。</td>
      </tr>
      <tr>
        <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
        <td>用于验证远程日志记录服务的 CA 证书的文件路径。</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_cert_path&gt;</em></code></td>
        <td>用于向远程日志记录服务进行认证的客户机证书的文件路径。</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_key_path&gt;</em></code></td>
        <td>用于连接到远程日志记录服务的相应客户机密钥的文件路径。</td>
      </tr>
    </tbody>
  </table>

2. 通过查看远程日志记录服务的 URL 来验证是否已启用日志转发。

    ```
    ibmcloud ks apiserver-config-get audit-webhook <cluster_name_or_ID>
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
    ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. 可选：如果要停止转发审计日志，可以禁用配置。
    1. 对于要停止从中收集 API 服务器审计日志的集群：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2. 禁用集群 API 服务器的 Webhook 后端配置。

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. 通过重新启动 Kubernetes 主节点来应用配置更新。

        ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
        {: pre}

<br />


## 在 {{site.data.keyword.cos_full_notm}} 存储区中收集主节点日志
{: #collect_master}

通过 {{site.data.keyword.containerlong_notm}}，您可以获取任意时间点的主节点日志的快照，以在 {{site.data.keyword.cos_full_notm}} 存储区中进行收集。快照包含通过 API 服务器发送的任何内容，例如 pod 安排、部署或 RBAC 策略。
{: shortdesc}

由于 Kubernetes API 服务器日志会自动流式传输，因此还会自动删除这些日志，以便为新日志流入腾出空间。通过保存特定时间点的日志快照，可以更好地对问题进行故障诊断，查看使用情况差异以及查找模式，以帮助维护更安全的应用程序。

**开始之前**

* 在 {{site.data.keyword.Bluemix_notm}}“目录”中[供应 {{site.data.keyword.cos_short}} 实例](/docs/services/cloud-object-storage/basics?topic=cloud-object-storage-gs-dev)。
* 确保您具有对集群的 [{{site.data.keyword.Bluemix_notm}} IAM **管理员**平台角色](/docs/containers?topic=containers-users#platform)。

**创建快照**

1. 通过遵循[此入门教程](/docs/services/cloud-object-storage?topic=cloud-object-storage-getting-started#gs-create-buckets)以使用 {{site.data.keyword.Bluemix_notm}} 控制台来创建 Object Storage 存储区。

2. 在已创建的存储区中生成 [HMAC 服务凭证](/docs/services/cloud-object-storage/iam?topic=cloud-object-storage-service-credentials)。
  1. 在 {{site.data.keyword.cos_short}} 仪表板的**服务凭证**选项卡中，单击**新建凭证**。
  2. 为 HMAC 凭证指定`写入者`服务角色。
  3. 在**添加内联配置参数**字段中，指定 `{"HMAC":true}`。

3. 通过 CLI，发出获取主节点日志快照的请求。

  ```
  ibmcloud ks logging-collect --cluster <cluster name or ID>  --type <type_of_log_to_collect> --cos-bucket <COS_bucket_name> --cos-endpoint <location_of_COS_bucket> --hmac-key-id <HMAC_access_key_ID> --hmac-key <HMAC_access_key> --type <log_type>
  ```
  {: pre}

  示例命令和响应：

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

4. 检查请求的状态。快照可能需要一些时间才能完成，但是您可以检查以确定您的请求是否成功完成。您可以在响应中找到包含主节点日志的文件的名称，并使用 {{site.data.keyword.Bluemix_notm}} 控制台来下载该文件。

  ```
  ibmcloud ks logging-collect-status --cluster <cluster_name_or_ID>
  ```
  {: pre}

  输出示例：

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


## 选择监视解决方案
{: #view_metrics}

度量值可帮助您监视集群的运行状况和性能。您可以使用标准 Kubernetes 和容器运行时功能来监视集群和应用程序的运行状况。
**注**：仅标准集群支持监视功能。
{:shortdesc}

**IBM 会监视集群吗？**

每个 Kubernetes 主节点都由 IBM 持续监视。{{site.data.keyword.containerlong_notm}} 会自动扫描部署了 Kubernetes 主节点的每个节点，以确定是否有在 Kubernetes 中找到的漏洞，以及特定于操作系统的安全修订。如果找到了漏洞，{{site.data.keyword.containerlong_notm}} 会自动代表用户应用修订并解决漏洞，以确保保护主节点。您负责监视和分析其余集群组件的日志。

为了避免在使用度量值服务时发生冲突，请确保各个资源组和区域上的集群具有唯一名称。
{: tip}

<dl>
  <dt>{{site.data.keyword.Bluemix_notm}} 中的集群详细信息页面</dt>
    <dd>{{site.data.keyword.containerlong_notm}} 提供了有关集群的运行状况和容量以及集群资源使用情况的信息。可以使用此控制台通过 {{site.data.keyword.Bluemix_notm}} 服务绑定来横向扩展集群，使用持久性存储器以及向集群添加更多功能。要查看集群详细信息页面，请转至 **{{site.data.keyword.Bluemix_notm}} 仪表板**，然后选择集群。</dd>
  <dt>Kubernetes 仪表板</dt>
    <dd>Kubernetes 仪表板是一个管理 Web 界面，可以在其中查看工作程序节点的运行状况，查找 Kubernetes 资源，部署容器化应用程序，以及使用日志记录和监视信息对应用程序进行故障诊断。有关如何访问 Kubernetes 仪表板的更多信息，请参阅[启动 {{site.data.keyword.containerlong_notm}} 的 Kubernetes 仪表板](/docs/containers?topic=containers-app#cli_dashboard)。</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>标准集群的度量值位于创建 Kubernetes 集群时登录到的 {{site.data.keyword.Bluemix_notm}} 帐户中。如果在创建集群时指定了 {{site.data.keyword.Bluemix_notm}} 空间，那么度量值将位于该空间中。将为集群中部署的所有容器自动收集容器度量值。这些度量值会通过 Grafana 发送并使其可用。有关度量值的更多信息，请参阅[监视 {{site.data.keyword.containerlong_notm}}](/docs/services/cloud-monitoring/containers?topic=cloud-monitoring-monitoring_bmx_containers_ov#monitoring_bmx_containers_ov)。</p>
    <p>要访问 Grafana 仪表板，请转至以下某个 URL，然后选择在其中已创建集群的 {{site.data.keyword.Bluemix_notm}} 帐户或空间。</p>
    <table summary="表中第一行跨两列。其他行应从左到右阅读，其中第一列是服务器专区，第二列是要匹配的 IP 地址。">
  <caption>要为监视流量打开的 IP 地址</caption>
            <thead>
            <th>{{site.data.keyword.containerlong_notm}} 区域</th>
            <th>监视地址</th>
            <th>监视子网</th>
            </thead>
          <tbody>
            <tr>
             <td>欧洲中部</td>
             <td><code>metrics.eu-de.bluemix.net</code></td>
             <td><code>158.177.65.80/30</code></td>
            </tr>
            <tr>
             <td>英国南部</td>
             <td><code>metrics.eu-gb.bluemix.net</code></td>
             <td><code>169.50.196.136/29</code></td>
            </tr>
            <tr>
              <td>美国东部、美国南部、亚太地区北部和亚太地区南部</td>
              <td><code>metrics.ng.bluemix.net</code></td>
              <td><code>169.47.204.128/29</code></td>
             </tr>
            </tbody>
          </table> </dd>
  <dt>{{site.data.keyword.mon_full_notm}}</dt>
  <dd>通过将 Sysdig 作为第三方服务部署到工作程序节点，以将度量值转发到 {{site.data.keyword.monitoringlong}}，从而从运营角度了解应用程序的性能和运行状况。有关更多信息，请参阅[分析在 Kubernetes 集群中部署的应用程序的度量值](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster)。</dd>
</dl>

### 其他运行状况监视工具
{: #health_tools}

可以配置其他工具来执行更多监视功能。
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus 是一个开放式源代码监视、日志记录和警报工具，专为 Kubernetes 而设计。该工具基于 Kubernetes 日志记录信息来检索有关集群、工作程序节点和部署运行状况的详细信息。有关更多信息，请参阅 [CoreOS 指示信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus)。</dd>
</dl>

<br />


## 使用自动恢复为工作程序节点配置运行状况监视
{: #autorecovery}

自动恢复系统会使用各种检查来查询工作程序节点的运行状态。如果自动恢复根据配置的检查，检测到运行状况欠佳的工作程序节点，那么自动恢复会触发更正操作，例如在工作程序节点上重装操作系统。一次只会对一个工作程序节点执行更正操作。该工作程序节点必须成功完成更正操作后，才能对其他任何工作程序节点执行更正操作。
有关更多信息，请参阅此[自动恢复博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。
{: shortdesc}</br> </br>

自动恢复至少需要一个正常运行的节点才能有效运行。仅在具有两个或两个以上工作程序节点的集群中，将自动恢复配置为执行主动检查。
{: note}

开始之前：
- 确保您具有以下 [{{site.data.keyword.Bluemix_notm}} IAM 角色](/docs/containers?topic=containers-users#platform)：
    - 对集群的**管理员**平台角色
    - 对 `kube-system` 名称空间的**写入者**或**管理者**服务角色
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。为集群设置上下文。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

要配置自动恢复，请执行以下操作：

1.  [遵循指示信息](/docs/containers?topic=containers-helm#public_helm_install)在本地计算机上安装 Helm 客户机，使用服务帐户安装 Helm 服务器 (Tiller)，然后添加 {{site.data.keyword.Bluemix_notm}} Helm 存储库。

2.  验证 Tiller 是否已使用服务帐户进行安装。
    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    输出示例：
    ```
    NAME                                 SECRETS   AGE
    tiller                               1         2m
    ```
    {: screen}

3. 创建配置映射文件以通过 JSON 格式定义检查。例如，以下 YAML 文件定义了三项检查：一项 HTTP 检查和两项 Kubernetes API 服务器检查。请参阅示例 YAML 文件后面的表，以获取有关三种检查的信息以及有关这些检查的各个组成部分的信息。
</br>
   **提示**：将每项检查定义为配置映射中 `data` 部分中的唯一键。

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

   <table summary="了解配置映射的组成部分">
   <caption>了解配置映射的组成部分</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解配置映射的组成部分</th>
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
   <td><code>checknode.json</code></td>
   <td>定义 Kubernetes API 节点检查，用于检查是否每个工作程序节点都处于 <code>Ready</code> 状态。如果特定工作程序节点不处于 <code>Ready</code> 状态，那么对该工作程序节点的检查计为一次失败。示例 YAML 中的检查每 3 分钟运行一次。如果连续失败三次，将重新装入该工作程序节点。此操作相当于运行 <code>ibmcloud ks worker-reload</code>。<br></br>节点检查会一直处于启用状态，直到您将 <b>Enabled</b> 字段设置为 <code>false</code> 或除去检查。</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
定义 Kubernetes API pod 检查，用于根据分配给工作程序节点的 pod 总数来检查该工作程序节点上 <code>NotReady</code> pod 的总百分比。如果特定工作程序节点的 <code>NotReady</code> pod 的总百分比大于定义的 <code>PodFailureThresholdPercent</code>，那么对该工作程序节点的检查计为一次失败。示例 YAML 中的检查每 3 分钟运行一次。如果连续失败三次，将重新装入该工作程序节点。此操作相当于运行 <code>ibmcloud ks worker-reload</code>。例如，缺省 <code>PodFailureThresholdPercent</code>为 50%。如果 <code>NotReady</code> pod 的百分比连续三次超过 50%，那么将重新装入工作程序节点。<br></br>缺省情况下，将检查所有名称空间中的 pod。要将检查限制为仅检查指定名称空间中的 pod，请将 <code>Namespace</code> 字段添加到检查。pod 检查会一直处于启用状态，直到您将 <b>Enabled</b> 字段设置为 <code>false</code> 或除去检查。
   </td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>定义 HTTP 检查，用于检查在工作程序节点上运行的 HTTP 服务器是否运行正常。要使用此检查，必须使用 [DaemonSet ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) 在集群中的每个工作程序节点上部署 HTTP 服务器。必须实现在 <code>/myhealth</code> 路径中可用并且可以验证 HTTP 服务器是否运行正常的运行状况检查。您可以通过更改 <strong>Route</strong> 参数来定义其他路径。如果 HTTP 服务器运行正常，那么必须返回 <strong><code>ExpectedStatus</code></strong> 中定义的 HTTP 响应代码。必须将 HTTP 服务器配置为侦听工作程序节点的专用 IP 地址。可以通过运行 <code>kubectl get nodes</code> 来查找专用 IP 地址。<br></br>
      例如，假设集群中有两个节点，其专用 IP 地址分别为 10.10.10.1 和 10.10.10.2。在此示例中，会对下面两个路径检查是否返回 200 HTTP 响应：<code>http://10.10.10.1:80/myhealth</code> 和 <code>http://10.10.10.2:80/myhealth</code>。
   示例 YAML 中的检查每 3 分钟运行一次。如果连续失败三次，将重新引导该工作程序节点。此操作相当于运行 <code>ibmcloud ks worker-reboot</code>。<br></br>HTTP 检查会一直处于禁用状态，直到您将 <b>Enabled</b> 字段设置为 <code>true</code>。</td>
   </tr>
   </tbody>
   </table>

   <table summary="了解检查的各个组成部分">
   <caption>了解检查的各个组成部分</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解检查的各个组成部分</th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>输入希望自动恢复使用的检查类型。<ul><li><code>HTTP</code>：自动恢复调用在每个节点上运行的 HTTP 服务器，以确定节点是否在正常运行。</li><li><code>KUBEAPI</code>：自动恢复调用 Kubernetes API 服务器并读取工作程序节点报告的运行状态数据。</li></ul></td>
   </tr>
   <tr>
   <td><code>资源</code></td>
   <td>检查类型为 <code>KUBEAPI</code> 时，输入希望自动恢复检查的资源类型。接受的值为 <code>NODE</code> 或 <code>POD</code>。</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>输入检查连续失败次数的阈值。达到此阈值时，自动恢复会触发指定的更正操作。例如，如果值为 3 且自动恢复连续三次执行配置的检查失败，那么自动恢复会触发与检查关联的更正操作。</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>资源类型为 <code>POD</code> 时，请输入工作程序节点上可以处于 [<strong><code>NotReady </code></strong> ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状态的 pod 的百分比阈值。此百分比基于安排到一个工作程序节点的 pod 总数。检查确定运行状况欠佳的 pod 百分比大于阈值时，该检查计为一次失败。</td>
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
   <td>检查类型为 <code>HTTP</code> 时，请输入工作程序节点上 HTTP 服务器必须绑定到的端口。此端口必须在集群中每个工作程序节点的 IP 上公开。自动恢复需要一个跨所有节点的常量端口号以用于检查服务器。将定制服务器部署到集群中时，请使用 [DaemonSet ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。</td>
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
   <tr>
   <td><code>Namespace</code></td>
   <td> 可选：要将 <code>checkpod.json</code> 限制为仅检查一个名称空间中的 pod，请添加 <code>Namespace</code> 字段并输入名称空间。</td>
   </tr>
   </tbody>
   </table>

4. 在集群中创建配置映射。
    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

5. 使用相应检查来验证是否已在 `kube-system` 名称空间中创建名称为 `ibm-worker-recovery-checks` 的配置映射。
    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

6. 通过安装 `ibm-worker-recovery` Helm 图表，将自动恢复部署到集群中。
    ```
    helm install --name ibm-worker-recovery iks-charts/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

7. 过几分钟后，可以检查以下命令的输出中的 `Events` 部分，以查看自动恢复部署上的活动。
    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

8. 如果未看到自动恢复部署上有活动，可以通过运行自动恢复图表定义中包含的测试来检查 Helm 部署。
    ```
helm test ibm-worker-recovery
    ```
    {: pre}




