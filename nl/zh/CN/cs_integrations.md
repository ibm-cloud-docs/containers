---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 集成服务
{: #integrations}

您可以将各种外部服务和 {{site.data.keyword.Bluemix_notm}}“目录”中的服务用于 {{site.data.keyword.containershort_notm}} 中的标准集群。
{:shortdesc}

<table summary="可访问性摘要">
<caption>表. Kubernetes 中集群和应用程序的集成选项</caption>
<thead>
<tr>
<th>服务</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Aqua 安全性</td>
  <td>作为<a href="/docs/services/va/va_index.html" target="_blank">漏洞顾问程序</a>的补充，可以使用 <a href="https://www.aquasec.com/" target="_blank">Aqua 安全性 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>，通过减少允许应用程序执行的操作来提高容器部署的安全性。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/06/protecting-container-deployments-bluemix-aqua-security/" target="_blank">Protecting container deployments on {{site.data.keyword.Bluemix_notm}} with Aqua Security <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Blockchain</td>
<td>将 IBM Blockchain 的公共可用的开发环境部署到 {{site.data.keyword.containerlong_notm}} 中的 Kubernetes 集群。使用此环境来开发和定制自己的区块链网络，以部署应用程序来共享用于记录交易历史记录的不可改变的分类帐。有关更多信息，请参阅<a href="https://ibm-blockchain.github.io" target="_blank">在云沙箱 IBM Blockchain Platform 中进行开发 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_short}}</td>
<td>可以使用 <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来存储和管理应用程序的 SSL 证书。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Use {{site.data.keyword.cloudcerts_long_notm}} with {{site.data.keyword.containershort_notm}} to deploy custom domain TLS Certificates <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Codeship</td>
<td>可以使用 <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来持续集成和交付容器。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containershort_notm}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_short}}</td>
<td>使用工具链自动构建应用程序并将容器部署到 Kubernetes 集群。有关设置信息，请参阅博客<a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">使用 DevOps 管道将 Kubernetes pod 部署到 {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>CoScale</td>
<td>使用 <a href="https://www.coscale.com/" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可监视工作程序节点、容器、副本集、复制控制器和服务。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitoring {{site.data.keyword.containershort_notm}} with CoScale <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Datadog</td>
<td>使用 <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可监视集群并查看基础架构和应用程序性能度量值。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitoring {{site.data.keyword.containershort_notm}} with Datadog <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh/" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 是 Kubernetes 软件包管理器。创建 Helm Chart，以定义、安装和升级在 {{site.data.keyword.containerlong_notm}} 集群中运行的复杂 Kubernetes 应用程序。了解有关如何<a href="https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/" target="_blank">利用 Kubernetes Helm Chart 提高部署速度 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 的更多信息。</td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 通过 GUI 自动发现和映射应用程序，从而提供基础架构和应用程序性能监视。Istana 会捕获向应用程序发出的每一个请求，支持您进行故障诊断并执行根本原因分析，以防止问题再次发生。请查看有关<a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">在 {{site.data.keyword.containershort_notm}} 中部署 Istana <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 的博客帖子，以了解更多信息。</td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 是一种开放式源代码服务，开发者可用于连接、保护、管理和监视云编排平台（如 Kubernetes）上的微服务网络（也称为服务网）。请查看有关 <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">IBM 共同建立并启动的 Istio <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 的博客帖子，以了解开放式源代码项目的更多信息。要在 {{site.data.keyword.containershort_notm}} 中的 Kubernetes 集群上安装 Istio 并开始使用样本应用程序，请参阅[教程：使用 Istio 管理微服务](cs_tutorials_istio.html#istio_tutorial)。</td>
</tr>
<tr>
<td>NeuVector</td>
<td>使用 <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可通过云本机防火墙来保护容器。有关更多信息，请参阅 <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus 是一个开放式源代码监视、日志记录和警报工具，专为 Kubernetes 而设计，可基于 Kubernetes 日志记录信息检索有关集群、工作程序节点和部署运行状况的详细信息。集群中所有运行中容器的 CPU、内存、I/O 和网络活动都会进行收集，并可用于定制查询或警报以监视集群中的性能和工作负载。

<p>要使用 Prometheus，请遵循 <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS 指示信息 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</p>
</td>
</tr>
<tr>
<td>{{site.data.keyword.bpshort}}</td>
<td>{{site.data.keyword.bplong}} 是一种自动化工具，使用 Terraform 将您的基础架构部署为代码。将基础架构部署为单个单元时，可以在任意数量的环境中复用这些云资源定义。要使用 {{site.data.keyword.bpshort}} 将 Kubernetes 集群定义为资源，请尝试使用 [container-cluster 模板](https://console.bluemix.net/schematics/templates/details/Cloud-Schematics%2Fcontainer-cluster)创建环境。有关 Schematics 的更多信息，请参阅[关于 {{site.data.keyword.bplong_notm}}](/docs/services/schematics/schematics_overview.html#about)。</td>
</tr>
<tr>
<td>Sematext</td>
<td>使用 <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可查看容器化应用程序的度量值和日志。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Monitoring & logging for containers with Sematext <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Sysdig</td>
<td>使用 <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 可通过单个检测点来捕获应用程序、容器、statsd 和主机度量值。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitoring {{site.data.keyword.containershort_notm}} with Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Twistlock</td>
<td>作为<a href="/docs/services/va/va_index.html" target="_blank">漏洞顾问程序</a>的补充，可以使用 <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 来管理防火墙、威胁防御和事件响应。有关更多信息，请参阅 <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock on {{site.data.keyword.containershort_notm}} <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope 提供了 Kubernetes 集群内资源（包括服务、pod、容器、进程、节点等等）的可视图。此外，Weave Scope 还提供了 CPU 和内存的交互式度量值，以及用于跟踪和执行到容器中的多种工具。<p>有关更多信息，请参阅[使用 Weave Scope 和 {{site.data.keyword.containershort_notm}} 可视化 Kubernetes 集群资源](cs_integrations.html#weavescope)。</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## 向集群添加服务
{: #adding_cluster}

将现有 {{site.data.keyword.Bluemix_notm}} 服务实例添加到集群，以支持集群用户在将应用程序部署到集群时，访问和使用 {{site.data.keyword.Bluemix_notm}} 服务。
{:shortdesc}

开始之前：

1. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。
2. [请求 {{site.data.keyword.Bluemix_notm}} 服务的实例](/docs/apps/reqnsi.html#req_instance)。**注：**要在华盛顿位置创建服务的实例，必须使用 CLI。

**注：**
<ul><ul>
<li>只能添加支持服务密钥的 {{site.data.keyword.Bluemix_notm}} 服务。如果服务不支持服务密钥，请参阅[使外部应用程序能够使用 {{site.data.keyword.Bluemix_notm}} 服务](/docs/apps/reqnsi.html#accser_external)。</li>
<li>必须完全部署集群和工作程序节点后，才能添加服务。</li>
</ul></ul>


要添加服务，请执行以下操作：
2.  列出可用的 {{site.data.keyword.Bluemix_notm}} 服务。

    ```
    bx service list
    ```
    {: pre}

    示例 CLI 输出：

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  记下要添加到集群的服务实例的**名称**。
4.  确定要用于添加服务的集群名称空间。在以下选项之间进行选择。

    -   列出现有名称空间，并选择要使用的名称空间。


        ```
        kubectl get namespaces
        ```
        {: pre}

    -   在集群中创建新的名称空间。

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  将服务添加到集群。

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    服务成功添加到集群后，将创建集群私钥，用于保存服务实例的凭证。示例 CLI 输出：

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  验证是否已在集群名称空间中创建私钥。

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


要在集群中部署的 pod 中使用服务，集群用户可以[将 Kubernetes 私钥作为私钥卷安装到 pod](cs_integrations.html#adding_app)，以访问 {{site.data.keyword.Bluemix_notm}} 服务的服务凭证。

<br />



## 向应用程序添加服务
{: #adding_app}

加密的 Kubernetes 私钥用于存储 {{site.data.keyword.Bluemix_notm}} 服务详细信息和凭证，并允许该服务与集群之间进行安全通信。作为集群用户，您可以通过将此私钥作为卷安装到 pod 以访问此私钥。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。确保您要在应用程序中使用的 {{site.data.keyword.Bluemix_notm}} 服务已由集群管理员[添加到集群](cs_integrations.html#adding_cluster)。

Kubernetes 私钥是一种存储保密信息（如用户名、密码或密钥）的安全方法。私钥不会通过环境变量或直接在 Dockerfile 中公开保密信息，而是必须作为私钥卷安装到 pod，才可供正在 pod 中运行的容器访问。

将私钥卷安装到 pod 时，会将名为 binding 的文件存储在卷安装目录中；此文件包含访问 {{site.data.keyword.Bluemix_notm}} 服务所需的全部信息和凭证。

1.  列出集群名称空间中的可用私钥。

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    输出示例：

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  查找类型为 **Opaque** 的私钥，并记录该私钥的**名称**。如果存在多个私钥，请联系集群管理员来确定正确的服务私钥。

3.  打开首选的编辑器。

4.  创建 YAML 文件，以配置可以通过私钥卷访问服务详细信息的 pod。如果绑定了多个服务，请验证每个私钥是否与正确的服务相关联。

    ```
    apiVersion: extensions/v1beta1
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
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>要安装到容器的私钥卷的名称。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>输入要安装到容器的私钥卷的名称。</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>为服务私钥设置只读许可权。</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>输入先前记下的私钥的名称。</td>
    </tr></tbody></table>

5.  创建 pod 并安装私钥卷。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  验证 pod 是否已创建。

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    示例 CLI 输出：

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  记下 pod 的 **NAME**。
8.  获取有关 pod 的详细信息，并查找私钥名称。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    输出：

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  实施应用程序时，将其配置为在安装目录中查找名为 **binding** 的私钥文件，解析 JSON 内容，并确定用于访问 {{site.data.keyword.Bluemix_notm}} 服务的 URL 和服务凭证。

现在，您可以访问 {{site.data.keyword.Bluemix_notm}} 服务详细信息和凭证。要使用 {{site.data.keyword.Bluemix_notm}} 服务，请确保将应用程序配置为在安装目录中查找服务私钥文件，解析 JSON 内容，并确定服务详细信息。

<br />



## 可视化 Kubernetes 集群资源
{: #weavescope}

Weave Scope 提供了 Kubernetes 集群内资源（包括服务、pod、容器、进程、节点等等）的可视图。此外，Weave Scope 还提供了 CPU 和内存的交互式度量值，以及用于跟踪和执行到容器中的多种工具。
{:shortdesc}

开始之前：

-   切勿在公共因特网上公开您的集群信息。完成以下步骤以安全地部署 Weave Scope 并在本地从 Web 浏览器对其进行访问。
-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。Weave Scope 可以是 CPU 密集型，尤其是应用程序。请对更大型的标准集群（而不是免费集群）运行 Weave Scope。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。


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

4.  运行端口转发命令以在计算机上启动该服务。现在，Weave Scope 已配置用于集群；下次访问 Weave Scope 时，可以运行以下端口转发命令，而不用再次完成先前的配置步骤。

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    输出：

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  打开 Web 浏览器并转至 `http://localhost:4040`。未部署缺省组件时，将看到下图。可以选择查看集群中 Kubernetes 资源的拓扑图或表。

     <img src="images/weave_scope.png" alt="Weave Scope 中的示例拓扑" style="width:357px;" />


[了解有关 Weave Scope 功能的更多信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.weave.works/docs/scope/latest/features/)。

<br />

