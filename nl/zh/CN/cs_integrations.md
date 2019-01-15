---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# 集成服务
{: #integrations}

您可以将各种外部服务和目录服务用于 {{site.data.keyword.containerlong}} 中的标准 Kubernetes 集群。
{:shortdesc}


## DevOps 服务
{: #devops_services}
<table summary="可访问性摘要">
<caption>DevOps 服务</caption>
<thead>
<tr>
<th>服务</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>可以使用 <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来持续集成和交付容器。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 是 Kubernetes 软件包管理器。可以创建新的 Helm 图表或使用预先存在的 Helm 图表来定义、安装和升级在 {{site.data.keyword.containerlong_notm}} 集群中运行的复杂 Kubernetes 应用程序。<p>有关更多信息，请参阅[在 {{site.data.keyword.containerlong_notm}} 中设置 Helm](cs_integrations.html#helm)。</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>使用工具链自动构建应用程序并将容器部署到 Kubernetes 集群。有关设置信息，请参阅博客<a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">使用 DevOps 管道将 Kubernetes pod 部署到 {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 是一种开放式源代码服务，开发者可用于连接、保护、管理和监视云编排平台（如 Kubernetes）上的微服务网络（也称为服务网）。请查看有关 <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">IBM 共同建立并启动的 Istio <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 的博客帖子，以了解开放式源代码项目的更多信息。要在 {{site.data.keyword.containerlong_notm}} 中的 Kubernetes 集群上安装 Istio 并开始使用样本应用程序，请参阅[教程：使用 Istio 管理微服务](cs_tutorials_istio.html#istio_tutorial)。</td>
</tr>
</tbody>
</table>

<br />



## 日志记录和监视服务
{: #health_services}
<table summary="可访问性摘要">
<caption>日志记录和监视服务</caption>
<thead>
<tr>
<th>服务</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td>使用 <a href="https://www.newrelic.com/coscale" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可监视工作程序节点、容器、副本集、复制控制器和服务。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with CoScale <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Datadog</td>
<td>使用 <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可监视集群并查看基础架构和应用程序性能度量值。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Datadog <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>{{site.data.keyword.cloudaccesstrailfull}}</td>
<td>通过 Grafana 来分析日志，以监视集群中进行的管理活动。有关服务的更多信息，请参阅 [Activity Tracker](/docs/services/cloud-activity-tracker/index.html) 文档。有关可以跟踪的事件类型的更多信息，请参阅 [Activity Tracker 事件](cs_at_events.html)。</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>使用 {{site.data.keyword.loganalysisfull_notm}} 扩展日志收集、保留和搜索能力。有关更多信息，请参阅<a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">启用自动收集集群日志 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>通过将 LogDNA 作为第三方服务部署到工作程序节点来管理 pod 容器中的日志，从而将日志管理功能添加到集群。有关更多信息，请参阅[使用 {{site.data.keyword.loganalysisfull_notm}} 通过 LogDNA 管理 Kubernetes 集群日志](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube)。</td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>通过使用 {{site.data.keyword.monitoringlong_notm}} 定义规则和警报来扩展度量值收集和保留功能。有关更多信息，请参阅<a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">在 Grafana 中分析在 Kubernetes 集群中部署的应用程序的度量值 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>通过将 Sysdig 作为第三方服务部署到工作程序节点，以将度量值转发到 {{site.data.keyword.monitoringlong}}，从而从运营角度了解应用程序的性能和运行状况。有关更多信息，请参阅[分析在 Kubernetes 集群中部署的应用程序的度量值](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster)。**注**：如果将 {{site.data.keyword.mon_full_notm}} 用于运行 Kubernetes V1.11 或更高版本的集群，那么不会收集所有容器度量值，因为 Sysdig 当前不支持 `containerd`。</td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 通过 GUI 自动发现和映射应用程序，从而提供基础架构和应用程序性能监视。Istana 会捕获向应用程序发出的每一个请求，您可以利用这些信息进行故障诊断并执行根本原因分析，以防止问题再次发生。请查看有关<a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">在 {{site.data.keyword.containerlong_notm}} 中部署 Istana <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 的博客帖子，以了解更多信息。</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus 是一个开放式源代码监视、日志记录和警报工具，专为 Kubernetes 而设计。Prometheus 基于 Kubernetes 日志记录信息来检索有关集群、工作程序节点和部署运行状况的详细信息。针对集群中运行中的每个容器，都会收集 CPU、内存、I/O 和网络活动。可以在定制查询或警报中使用收集的数据，以监视集群中的性能和工作负载。

<p>要使用 Prometheus，请遵循 <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS 指示信息 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td>使用 <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可查看容器化应用程序的度量值和日志。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Monitoring and logging for containers with Sematext <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Sysdig</td>
<td>使用 <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可通过单个检测点来捕获应用程序、容器、statsd 和主机度量值。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope 提供了 Kubernetes 集群内资源（包括服务、pod、容器、进程、节点等等）的可视图。此外，Weave Scope 还提供了 CPU 和内存的交互式度量值，以及用于跟踪和执行到容器中的多种工具。<p>有关更多信息，请参阅[使用 Weave Scope 和 {{site.data.keyword.containerlong_notm}} 可视化 Kubernetes 集群资源](cs_integrations.html#weavescope)。</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## 安全服务
{: #security_services}

想要全面了解如何将 {{site.data.keyword.Bluemix_notm}} 安全服务与集群集成吗？请查看[将端到端安全性应用于云应用程序教程](/docs/tutorials/cloud-e2e-security.html)。
{: shortdesc}

<table summary="可访问性摘要">
<caption>安全服务</caption>
<thead>
<tr>
<th>服务</th>
<th>描述</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>使用 [{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted) 并要求用户登录，提高了应用程序的安全级别。要向应用程序认证 Web 或 API HTTP/HTTPS 请求，可以使用 [{{site.data.keyword.appid_short_notm}} 认证 Ingress 注释](cs_annotations.html#appid-auth)将 {{site.data.keyword.appid_short_notm}} 与 Ingress 服务集成。</td>
  </tr>
<tr>
<td>Aqua 安全性</td>
  <td>作为<a href="/docs/services/va/va_index.html" target="_blank">漏洞顾问程序</a>的补充，可以使用 <a href="https://www.aquasec.com/" target="_blank">Aqua 安全性 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>，通过减少允许应用程序执行的操作来提高容器部署的安全性。有关更多信息，请参阅 <a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Securing container deployments on {{site.data.keyword.Bluemix_notm}} with Aqua Security <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td>可以使用 <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来存储和管理应用程序的 SSL 证书。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Use {{site.data.keyword.cloudcerts_long_notm}} with {{site.data.keyword.containerlong_notm}} to deploy custom domain TLS Certificates <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>设置您自己的安全 Docker 映像存储库，在其中可以安全地存储映像并在集群用户之间共享这些映像。有关更多信息，请参阅 <a href="/docs/services/Registry/index.html" target="_blank">{{site.data.keyword.registrylong}} 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
  <td>{{site.data.keyword.keymanagementservicefull}}</td>
  <td>通过启用 {{site.data.keyword.keymanagementserviceshort}}，可对集群中的 Kubernetes 私钥进行加密。对 Kubernetes 私钥进行加密可防止未经授权的用户访问敏感集群信息。<br>要进行设置，请参阅<a href="cs_encrypt.html#keyprotect">使用 {{site.data.keyword.keymanagementserviceshort}} 对 Kubernetes 私钥进行加密</a>。<br>有关更多信息，请参阅 <a href="/docs/services/key-protect/index.html#getting-started-with-key-protect" target="_blank">{{site.data.keyword.keymanagementserviceshort}} 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>NeuVector</td>
<td>使用 <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可通过云本机防火墙来保护容器。有关更多信息，请参阅 <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Twistlock</td>
<td>作为<a href="/docs/services/va/va_index.html" target="_blank">漏洞顾问程序</a>的补充，可以使用 <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来管理防火墙、威胁防御和事件响应。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock on {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
</tbody>
</table>

<br />



## 存储服务
{: #storage_services}
<table summary="可访问性摘要">
<caption>存储服务</caption>
<thead>
<tr>
<th>服务</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio Ark</td>
  <td>可以使用 <a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来备份和复原集群资源和持久性卷。有关更多信息，请参阅 Heptio Ark <a href="https://github.com/heptio/ark/blob/release-0.9/docs/use-cases.md" target="_blank">Use cases for disaster recovery and cluster migration <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>使用 {{site.data.keyword.cos_short}} 存储的数据经过加密，分散在多个地理位置，并使用 REST API 通过 HTTP 进行访问。您可以使用 [ibm-backup-restore 映像](/docs/services/RegistryImages/ibm-backup-restore/index.html)来配置服务，以便为集群中的数据生成一次性备份或安排的备份。有关该服务的常规信息，请参阅 <a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">{{site.data.keyword.cos_short}} 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>{{site.data.keyword.cloudant_short_notm}} 是面向文档的数据库即服务 (DBaaS)，用于将数据存储为 JSON 格式的文档。该服务是针对可扩展性、高可用性和耐久性而构建的。有关更多信息，请参阅 <a href="/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant" target="_blank">{{site.data.keyword.cloudant_short_notm}} 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>{{site.data.keyword.composeForMongoDB}} 交付高可用性和冗余、自动化和随需应变的不中断备份、监视工具、与警报系统集成、性能分析视图等内容。有关更多信息，请参阅 <a href="/docs/services/ComposeForMongoDB/index.html#about-compose-for-mongodb" target="_blank">{{site.data.keyword.composeForMongoDB}} 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
  </tr>
</tbody>
</table>


<br />



## 将 {{site.data.keyword.Bluemix_notm}} 服务添加到集群
{: #adding_cluster}

添加 {{site.data.keyword.Bluemix_notm}} 服务以使用区域中的额外功能增强 Kubernetes 集群，例如，Watson AI、数据、安全性和物联网 (IoT)。
{:shortdesc}

只能绑定支持服务密钥的服务。要查找支持服务密钥的服务的列表，请参阅[使外部应用程序能够使用 {{site.data.keyword.Bluemix_notm}} 服务](/docs/resources/connect_external_app.html#externalapp)。
{: note}

开始之前：
- 确保您具有以下角色：
    - 对集群的 [{{site.data.keyword.Bluemix_notm}} IAM **编辑者**或**管理员**服务角色](cs_users.html#platform)。
    - 对要使用的空间的 [Cloud Foundry **开发者**角色](/docs/iam/mngcf.html#mngcf)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

要将 {{site.data.keyword.Bluemix_notm}} 服务添加到集群：
1. [创建 {{site.data.keyword.Bluemix_notm}} 服务的实例](/docs/apps/reqnsi.html#req_instance)。
    * 某些 {{site.data.keyword.Bluemix_notm}} 服务仅在精选区域中可用。仅当服务在与您的集群相同的区域中可用时，才可将服务绑定到集群。此外，如果想要在华盛顿专区中创建服务实例，必须使用 CLI。
    * 必须在集群所在的资源组中创建服务实例。只能在一个资源组中创建资源，并且在此之后无法更改资源组。

2. 检查创建的服务类型，并记下服务实例**名称**。
   - **Cloud Foundry 服务：**
     ```
    ibmcloud service list
    ```
     {: pre}

     输出示例：
        ```
     name                         service           plan    bound apps   last operation
     <cf_service_instance_name>   <service_name>    spark                create succeeded
     ```
     {: screen}

  - **{{site.data.keyword.Bluemix_notm}}支持 IAM 的服务：**
     ```
    ibmcloud resource service-instances
    ```
     {: pre}

     输出示例：
        ```
     Name                          Location   State    Type               Tags   
     <iam_service_instance_name>   <region>   active   service_instance      
     ```
     {: screen}

   您还可以在仪表板中查看作为 **Cloud Foundry 服务**和**服务**的不同服务类型。

3. 对于支持 {{site.data.keyword.Bluemix_notm}} IAM 的服务，创建 Cloud Foundry 别名，从而可将此服务绑定到集群。如果服务已经是 Cloud Foundry 服务，那么此步骤不是必需的，并且可继续下一步。
   1. 将 Cloud Foundry 组织和空间作为目标。
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. 为服务实例创建 Cloud Foundry 别名。
    ```
      ibmcloud resource service-alias-create <service_alias_name> --instance-name <iam_service_instance_name>
      ```
      {: pre}

   3. 验证是否已创建服务别名。
      ```
    ibmcloud service list
    ```
      {: pre}

4. 确定要用于添加服务的集群名称空间。在以下选项之间进行选择。
     ```
        kubectl get namespaces
        ```
     {: pre}

5.  将服务添加到集群。对于支持 {{site.data.keyword.Bluemix_notm}} IAM 的服务，确保使用先前创建的 Cloud Foundry 别名。
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}

    服务成功添加到集群后，将创建集群私钥，用于保存服务实例的凭证。将在 etcd 中自动加密私钥以保护数据。

    输出示例：
    ```
        ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  验证 Kubernetes 私钥中的服务凭证。
    1. 获取私钥的详细信息并记录 **binding** 值。**binding** 值采用 base64 编码，并且以 JSON 格式保存服务实例的凭证。
       ```
       kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
       ```
       {: pre}

       输出示例：
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

    2. 对绑定值进行解码。
       ```
       echo "<binding>" | base64 -D
       ```
       {: pre}

       输出示例：
        ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. 可选：在 {{site.data.keyword.Bluemix_notm}} 仪表板中，将在先前步骤中解码的服务凭证与针对服务实例找到的服务凭证进行比较。

7. 现在，您的服务已绑定到集群，必须配置应用程序以[访问 Kubernetes 私钥中的服务凭证](#adding_app)。


## 从应用程序访问服务凭证
{: #adding_app}

要从应用程序访问 {{site.data.keyword.Bluemix_notm}} 服务实例，必须使存储在 Kubernetes 私钥中的服务凭证可用于应用程序。
{: shortdesc}

服务实例凭证采用 base64 编码并且以 JSON 格式存储在私钥中。要访问私钥中的数据，请从以下选项中进行选择：
- [将私钥作为卷安装到 pod](#mount_secret)
- [在环境变量中引用私钥](#reference_secret)
<br>
想要使私钥更安全吗？请要求集群管理员在集群中[启用 {{site.data.keyword.keymanagementservicefull}}](cs_encrypt.html#keyprotect)，以加密新私钥和现有私钥，例如用于存储 {{site.data.keyword.Bluemix_notm}} 服务实例凭证的私钥。
{: tip}

开始前：

- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。
- [向集群添加 {{site.data.keyword.Bluemix_notm}} 服务](#adding_cluster)。

### 将私钥作为卷安装到 pod
{: #mount_secret}

将私钥作为卷安装到 pod 时，会将名为 `binding` 的文件存储在卷安装目录中。JSON 格式的 `binding` 文件包含访问 {{site.data.keyword.Bluemix_notm}} 服务所需的全部信息和凭证。
{: shortdesc}

1.  列出集群中的可用私钥并记下私钥的 **name**。查找类型为 **Opaque** 的私钥。如果存在多个私钥，请联系集群管理员来确定正确的服务私钥。

    ```
    kubectl get secrets
    ```
    {: pre}

    输出示例：

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    

    ```
    {: screen}

2.  针对 Kubernetes 部署创建 YAML 文件并将私钥作为卷安装到 pod。
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
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts.mountPath</code></td>
    <td>在容器中安装卷的目录的绝对路径。</td>
    </tr>
    <tr>
    <td><code>volumeMounts.name</code></br><code>volumes.name</code></td>
    <td>要安装到 pod 中的卷的名称。</td>
    </tr>
    <tr>
    <td><code>secret.defaultMode</code></td>
    <td>私钥的读写许可权。使用 `420` 可设置只读许可权。</td>
    </tr>
    <tr>
    <td><code>secret.secretName</code></td>
    <td>先前步骤中记录的私钥的名称。</td>
    </tr></tbody></table>

3.  创建 pod 并安装私钥作为卷。
    ```
    kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  验证 pod 是否已创建。
    ```
            kubectl get pods
            ```
    {: pre}

    示例 CLI 输出：

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  访问服务凭证。
    1. 登录到 pod。
       ```
       kubectl exec <pod_name> -it bash
       ```
       {: pre}

    2. 浏览至先前定义的卷安装路径并列出卷安装路径中的文件。
       ```
       cd <volume_mountpath> && ls
       ```
       {: pre}

       输出示例：
        ```
       binding
       ```
       {: screen}

       `binding` 文件包含存储在 Kubernetes 私钥中的服务凭证。

    4. 查看服务凭证。凭证以 JSON 格式存储为键值对。
       ```
       cat binding
       ```
       {: pre}

       输出示例：
        ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. 配置应用程序以解析 JSON 内容，并检索访问服务所需的信息。


### 在环境变量中引用私钥
{: #reference_secret}

您可以将来自 Kubernetes 私钥的服务凭证和其他键值对作为环境变量添加到部署中。   
{: shortdesc}

1. 列出集群中的可用私钥并记下私钥的 **name**。查找类型为 **Opaque** 的私钥。如果存在多个私钥，请联系集群管理员来确定正确的服务私钥。

    ```
    kubectl get secrets
    ```
    {: pre}

    输出示例：

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2. 获取私钥的详细信息，以查找可以引用为 pod 中的环境变量的潜在键值对。服务凭证存储在私钥的 `binding` 密钥中。
   ```
   kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
   ```
   {: pre}

   输出示例：
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

3. 为 Kubernetes 部署创建 YAML 文件，并指定引用 `binding` 密钥的环境变量。
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
     <caption>了解 YAML 文件的组成部分</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
     </thead>
     <tbody>
     <tr>
     <td><code>containers.env.name</code></td>
     <td>环境变量的名称。</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.name</code></td>
     <td>先前步骤中记录的私钥的名称。</td>
     </tr>
     <tr>
     <td><code>env.valueFrom.secretKeyRef.key</code></td>
     <td>属于私钥的一部分并且您想要在环境变量中引用的密钥。要引用服务凭证，必须使用 <strong>binding</strong> 密钥。</td>
     </tr>
     </tbody></table>

4. 创建引用私钥的 `binding` 密钥作为环境变量的 pod。
   ```
    kubectl apply -f secret-test.yaml
    ```
   {: pre}

5. 验证 pod 是否已创建。
   ```
            kubectl get pods
            ```
   {: pre}

   示例 CLI 输出：
   ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
   {: screen}

6. 验证是否已正确设置环境变量。
   1. 登录到 pod。
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. 列出 pod 中的所有环境变量。
      ```
      env
      ```
      {: pre}

      输出示例：
    ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. 配置应用程序以读取环境变量，并解析 JSON 内容以检索访问服务所需的信息。

   Python 中的示例代码：
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## 在 {{site.data.keyword.containerlong_notm}} 中设置 Helm
{: #helm}

[Helm ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://helm.sh) 是 Kubernetes 软件包管理器。可以创建 Helm 图表或使用预先存在的 Helm 图表来定义、安装和升级在 {{site.data.keyword.containerlong_notm}} 集群中运行的复杂 Kubernetes 应用程序。
{:shortdesc}

在将 Helm 图表与 {{site.data.keyword.containerlong_notm}} 配合使用之前，必须先安装并初始化集群中的 Helm 实例。然后，可以向 Helm 实例添加 {{site.data.keyword.Bluemix_notm}} Helm 存储库。

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

1. 安装 <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。

2. **重要信息**：要维护集群安全性，请通过应用 [{{site.data.keyword.Bluemix_notm}} `kube-samples` 存储库](https://github.com/IBM-Cloud/kube-samples/blob/master/rbac/serviceaccount-tiller.yaml)中的以下 `.yaml` 文件，在 `kube-system` 名称空间中为 Tiller 创建服务帐户，为 `tiller-deploy` pod 创建 Kubernetes RBAC 集群角色绑定。**注**：要在 `kube-system` 名称空间中安装具有服务帐户和集群角色绑定的 Tiller，您必须具有 [`cluster-admin` 角色](cs_users.html#access_policies)。
    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/rbac/serviceaccount-tiller.yaml
    ```
    {: pre}

3. 使用创建的服务帐户来初始化 Helm 并安装 `tiller`。

    ```
    helm init --service-account tiller
    ```
    {: pre}

4. 验证 `tiller-deploy` pod 在集群中的 **Status** 是否为 `Running`。

    ```
        kubectl get pods -n kube-system -l app=helm
        ```
    {: pre}

    输出示例：

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. 向 Helm 实例添加 {{site.data.keyword.Bluemix_notm}} Helm 存储库。

    ```
    helm repo add ibm  https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

    ```
    helm repo add ibm-charts https://registry.bluemix.net/helm/ibm-charts
    ```
    {: pre}

6. 列出 {{site.data.keyword.Bluemix_notm}} 存储库中当前可用的 Helm 图表。

    ```
    helm search ibm
    ```
    {: pre}

    ```
    helm search ibm-charts
    ```
    {: pre}

7. 要了解有关图表的更多信息，请列出其设置和缺省值。

    例如，要查看 strongSwan IPSec VPN 服务 Helm 图表的设置、文档和缺省值，请运行以下命令：

    ```
    helm inspect ibm/strongswan
    ```
    {: pre}


### 相关 Helm 链接
{: #helm_links}

* 要使用 strongSwan Helm 图表，请参阅[使用 strongSwan IPSec VPN 服务 Helm 图表设置 VPN 连接](cs_vpn.html#vpn-setup)。
* 在控制台中查看可在 [Helm 图表目录 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts) 中与 {{site.data.keyword.Bluemix_notm}} 配合使用的可用 Helm 图表。
* 在 <a href="https://docs.helm.sh/helm/" target="_blank">Helm 文档 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 中了解有关用于设置和管理 Helm 图表的 Helm 命令的更多信息。
* 了解有关如何[利用 Kubernetes Helm 图表提高部署速度 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/) 的更多信息。

## 可视化 Kubernetes 集群资源
{: #weavescope}

Weave Scope 提供了 Kubernetes 集群内资源（包括服务、pod、容器等等）的可视图。此外，Weave Scope 还提供了 CPU 和内存的交互式度量值，以及用于跟踪和执行到容器中的多种工具。
{:shortdesc}

开始之前：

-   切勿在公共因特网上公开您的集群信息。完成以下步骤以安全地部署 Weave Scope 并在本地从 Web 浏览器对其进行访问。
-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。Weave Scope 可以是 CPU 密集型，尤其是应用程序。请对更大型的标准集群（而不是免费集群）运行 Weave Scope。
-   [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。


要将 Weave Scope 用于集群，请执行以下操作：
2.  在集群中部署其中一个提供的 RBAC 许可权配置文件。

    启用读/写许可权：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    启用只读许可权：

    ```
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    输出：

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  部署 Weave Scope 服务，此服务专供集群 IP 地址访问。

    <pre class="pre">
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    输出：

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  运行端口转发命令以在计算机上打开该服务。下次访问 Weave Scope 时，可以运行以下端口转发命令，而不用再次完成先前的配置步骤。

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    输出：

    ```
Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  打开 Web 浏览器并转至 `http://localhost:4040`。未部署缺省组件时，将看到下图。可以选择查看集群中 Kubernetes 资源的拓扑图或表。

     <img src="images/weave_scope.png" alt="Weave Scope 中的示例拓扑" style="width:357px;" />


[了解有关 Weave Scope 功能的更多信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.weave.works/docs/scope/latest/features/)。

<br />

