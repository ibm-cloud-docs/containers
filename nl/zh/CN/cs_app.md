---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# 在集群中部署应用程序
{: #app}

您可以在 {{site.data.keyword.containerlong}} 中使用 Kubernetes 方法来部署容器中的应用程序，并确保这些应用程序始终保持启动并正常运行。例如，可以执行滚动更新以及回滚，而不给用户造成任何停机时间。
{: shortdesc}

通过单击下图中的某个区域可了解用于部署应用程序的常规步骤。要首先了解基础知识吗？请试用[部署应用程序教程](cs_tutorials_apps.html#cs_apps_tutorial)。

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="基本部署过程"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="安装 CLI。" title="安装 CLI。" shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="为应用程序创建配置文件。请查看 Kubernetes 中的最佳实践。" title="为应用程序创建配置文件。请查看 Kubernetes 中的最佳实践。" shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="选项 1：通过 Kubernetes CLI 运行配置文件。" title="选项 1：通过 Kubernetes CLI 运行配置文件。" shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="选项 2：在本地启动 Kubernetes 仪表板，然后运行配置文件。" title="选项 2：在本地启动 Kubernetes 仪表板，然后运行配置文件。" shape="rect" coords="544, 141, 728, 204" />
</map>

<br />




## 规划高可用性部署
{: #highly_available_apps}

设置在多个工作程序节点和集群上分发得越广泛，用户使用应用程序时遭遇停机时间的可能性就越低。
{: shortdesc}

查看以下潜在的应用程序设置（按可用性程度从低到高排序）。


![应用程序的高可用性阶段](images/cs_app_ha_roadmap-mz.png)

1.  部署具有 n+2 个 pod，这些 pod 由单专区集群中单个节点中的副本集管理。
2.  部署具有 n+2 个 pod，这些 pod 由副本集管理并跨单专区集群的多个节点分布（反亲缘关系）。
3.  部署具有 n+2 个 pod，这些 pod 由副本集管理并在多个专区中跨多专区集群的多个节点分布（反亲缘关系）。

您还可以[使用全局负载均衡器连接不同区域中的多个集群](cs_clusters.html#multiple_clusters)，以提高高可用性。

### 提高应用程序的可用性
{: #increase_availability}

<dl>
  <dt>使用部署和副本集来部署应用程序及其依赖项</dt>
    <dd><p>部署是一种 Kubernetes 资源，可用于声明应用程序的所有组件以及应用程序的依赖项。通过部署，您不必记下所有这些步骤，而可以将重点放在应用程序上。</p>
    <p>部署多个 pod 时，会自动为部署创建副本集；副本集用于监视这些 pod，并确保始终有所需数量的 pod 正常运行。pod 发生故障时，副本集会将无响应的 pod 替换为新的 pod。</p>
    <p>您可以使用部署来定义应用程序的更新策略，包括在滚动更新期间要添加的 pod 数，以及允许同时不可用的 pod 数。执行滚动更新时，部署将检查修订版是否有效，并在检测到故障时停止应用。</p>
    <p>通过部署，可以同时部署多个具有不同标志的修订版。例如，您可以先测试部署，然后再决定是否将其推送到生产环境。</p>
    <p>部署允许您跟踪任何已部署的修订版。如果遇到更新无法按预期运行的情况，可以使用此历史记录回滚到上一个版本。</p></dd>
  <dt>包含足够多的副本用于应用程序的工作负载，在此基础上再额外增加两个副本</dt>
    <dd>要使应用程序具有更高可用性且在出现故障时能够更快恢复，请考虑在处理预期工作负载所需最低要求的副本数基础上，再包含额外的副本。在某个 pod 崩溃且副本集尚未恢复已崩溃 pod 的情况下，额外的副本可处理工作负载。要针对同时发生两个故障的情况进行防护，请包含两个额外的副本。此设置是 N+2 模式，其中 N 是处理入局工作负载的副本数，+2 是额外两个副本。只要集群具有足够的空间，就可以拥有任意数量的 pod。</dd>
  <dt>跨多个节点分布 pod（反亲缘关系）</dt>
    <dd><p>创建部署时，各个 pod 可部署到同一工作程序节点。这称为亲缘关系或共存。为了保护应用程序不受工作程序节点故障的影响，可以在标准集群中使用 <em>podAntiAffinity</em> 选项将部署配置为跨多个工作程序节点分布 pod。可以定义两种类型的 pod 反亲缘关系：首选或必需。有关更多信息，请参阅有关<a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="（在新选项卡或窗口中打开）">为节点分配 pod</a> 的 Kubernetes 文档。</p>
    <p><strong>注</strong>：在需要反亲缘关系的情况下，可以部署的副本数不超过您拥有的工作程序节点数。例如，如果集群中有 3 个工作程序节点，但在 YAML 文件中定义了 5 个副本，那么仅部署 3 个副本。每个副本位于不同的工作程序节点上。剩余的 2 个副本保持暂挂状态。如果将另一个工作程序节点添加到集群，那么其中一个剩余副本将自动部署到这一新的工作程序节点。<p>
    <p><strong>部署 YAML 文件示例</strong>：<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="（在新选项卡或窗口中打开）">具有首选 pod 反亲缘关系的 Nginx 应用程序。</a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="（在新选项卡或窗口中打开）">具有必需 pod 反亲缘关系的 IBM® WebSphere® Application Server Liberty 应用程序。</a></li></ul></p>
    
    </dd>
<dt>跨多个专区或区域分布 pod</dt>
  <dd><p>要保护应用程序不受专区故障的影响，可以在不同专区中创建多个集群，或者向多专区集群的工作程序池添加专区。多专区集群仅在[特定大城市区域](cs_regions.html#zones)（例如，达拉斯）中可用。如果在不同专区中创建多个集群，那么必须[设置全局负载均衡器](cs_clusters.html#multiple_clusters)。</p>
  <p>使用副本集并指定 pod 反亲缘关系时，Kubernetes 会跨节点分布应用程序 pod。如果节点位于多个专区中，那么 pod 会跨这些专区分布，从而提高应用程序的可用性。如果要限制应用程序仅在一个专区中运行，您可以配置 pod 亲缘关系，或者在一个专区中创建并标记工作程序池。有关更多信息，请参阅[多专区集群的高可用性](cs_clusters.html#ha_clusters)。</p>
  <p><strong>在多专区集群部署中，应用程序 pod 会跨节点均匀分布吗？</strong></p>
  <p>pod 会跨专区均匀分布，但不一定会跨节点均匀分布。例如，如果有一个集群在 3 个专区中分别有 1 个节点，并且部署了包含 6 个 pod 的副本集，那么每个节点会获得 2 个 pod。但是，如果集群在 3 个专区中分别有 2 个节点，并且部署了包含 6 个 pod 的副本集，那么每个专区会安排 2 个 pod，这 2 个 pod 可能会每个节点安排 1 个，也可能 2 个 pod 都安排在一个节点上。要对安排具有更多控制权，可以[设置 pod 亲缘关系 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node)。</p>
  <p><strong>如果某个专区发生故障，如何将 pod 重新安排到其他专区中的剩余节点上？</strong></br>这取决于您在部署中使用的安排策略。如果包含[特定于节点的 pod 亲缘关系 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature)，那么不会重新安排 pod。如果未包含此策略，那么会在其他专区中的可用工作程序节点上创建 pod，但可能不会对这些 pod 进行均衡。例如，2 个 pod 可能分布在 2 个可用节点上，也可能都安排到 1 个具有可用容量的节点上。与此类似，当不可用专区恢复时，不会自动删除 pod 并跨节点对这些 pod 进行重新均衡。如果要在该专区恢复后跨专区重新均衡 pod，请考虑使用 [Kubernetes Descheduler ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes-incubator/descheduler)。</p>
  <p><strong>提示</strong>：在多专区集群中，请尽量使每个专区的工作程序节点容量保持在 50%，以便您有足够的容量来保护集群不受专区故障的影响。</p>
  <p><strong>如果要跨区域分布应用程序该怎么做？</strong></br>要保护应用程序不受区域故障的影响，请在另一个区域中创建第二个集群，[设置全局负载均衡器](cs_clusters.html#multiple_clusters)以连接集群，并使用部署 YAML 为应用程序部署具有 [pod 反亲缘关系 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) 的重复副本集。</p>
  <p><strong>如果应用程序需要持久性存储器该怎么做？</strong></p>
  <p>使用云服务，例如 [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) 或 [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)。</p></dd>
</dl>



### 最低应用程序部署
{: #minimal_app_deployment}

免费或标准集群中的基本应用程序部署可能包含以下组件。
{: shortdesc}

![部署设置](images/cs_app_tutorial_components1.png)

要部署图中所示的最简应用程序的组件，请使用类似于以下示例的配置文件：
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.bluemix.net/ibmliberty:latest
        ports:
        - containerPort: 9080        
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    app: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

**注**：要公开服务，请确保在服务的 `spec.selector` 部分中使用的键/值对与部署 YAML 的 `spec.template.metadata.labels` 部分中使用的键/值对相同。要了解有关每个组件的更多信息，请查看 [Kubernetes 基础知识](cs_tech.html#kubernetes_basics)。

<br />






## 启动 Kubernetes 仪表板
{: #cli_dashboard}

在本地系统上打开 Kubernetes 仪表板，以查看有关集群及其工作程序节点的信息。
[在 GUI 中](#db_gui)，可以使用方便的一次单击按钮来访问该仪表板。[通过 CLI](#db_cli)，可以访问该仪表板或使用自动化过程中的步骤，例如针对 CI/CD 管道的步骤。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

可以使用缺省端口或设置自己的端口来启动集群的 Kubernetes 仪表板。

**通过 GUI 启动 Kubernetes 仪表板**
{: #db_gui}

1.  登录到 [{{site.data.keyword.Bluemix_notm}} GUI](https://console.bluemix.net/)。
2.  从菜单栏的概要文件中，选择要使用的帐户。
3.  在菜单中，单击**容器**。
4.  在**集群**页面上，单击要访问的集群。
5.  在集群详细信息页面中，单击 **Kubernetes 仪表板**按钮。

</br>
</br>

**通过 CLI 启动 Kubernetes 仪表板**
{: #db_cli}

1.  获取 Kubernetes 的凭证。

    ```
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2.  复制输出中显示的 **id-token** 值。

3.  使用缺省端口号设置代理。

    ```
    kubectl proxy
    ```
    {: pre}

    输出示例：

    ```
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4.  登录到仪表板。

  1.  在浏览器中，浏览至以下 URL：

      ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
      {: codeblock}

  2.  在登录页面中，选择**令牌**认证方法。

  3.  接下来，将先前复制的 **id-token** 值粘贴到**令牌**字段中，然后单击**登录**。

对 Kubernetes 仪表板操作完毕后，使用 `CTRL+C` 以退出 `proxy` 命令。退出后，Kubernetes 仪表板不再可用。运行 `proxy` 命令以重新启动 Kubernetes 仪表板。

[接下来，可以通过仪表板来运行配置文件。](#app_ui)

<br />


## 创建私钥
{: #secrets}

Kubernetes 私钥是一种存储保密信息（如用户名、密码或密钥）的安全方法。
{:shortdesc}

查看以下需要私钥的任务。有关在私钥中可以存储哪些内容的更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/secret/)。

### 向集群添加服务
{: #secrets_service}

将服务绑定到集群时，无需创建私钥。系统将自动创建私钥。有关更多信息，请参阅[向集群添加 Cloud Foundry 服务](cs_integrations.html#adding_cluster)。

### 将 Ingress ALB 配置为使用 TLS
{: #secrets_tls}

ALB 会对流至集群中应用程序的 HTTP 网络流量进行负载均衡。要同时对入局 HTTPS 连接进行负载均衡，可以配置 ALB 来解密网络流量，然后将已解密的请求转发到集群中公开的应用程序。

如果使用的是 IBM 提供的 Ingress 子域，那么可以[使用 IBM 提供的 TLS 证书](cs_ingress.html#public_inside_2)。要查看 IBM 提供的 TLS 私钥，请运行以下命令：
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep "Ingress secret"
```
{: pre}

如果使用的是定制域，那么可以使用您自己的证书来管理 TLS 终止。要创建自己的 TLS 私钥，请执行以下操作：
1. 通过下列其中一种方式生成密钥和证书：
    * 通过证书提供者生成认证中心 (CA) 证书和密钥。如果您有自己的域，请为您的域购买正式的 TLS 证书。**重要信息**：请确保每个证书的 [CN ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://support.dnsimple.com/articles/what-is-common-name/) 都是不同的。
    * 出于测试目的，可以使用 OpenSSL 创建自签名证书。有关更多信息，请参阅此[自签名 SSL 证书教程 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.akadia.com/services/ssh_test_certificate.html)。
        1. 创建 `tls.key`。
            ```
            openssl genrsa -out tls.key 2048
            ```
            {: pre}
        2. 使用密钥创建 `tls.crt`。
            ```
            openssl req -new -x509 -key tls.key -out tls.crt
            ```
            {: pre}
2. [将证书和密钥转换为 Base64 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.base64encode.org/)。
3. 使用证书和密钥创建私钥 YAML 文件。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. 将证书创建为 Kubernetes 私钥。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### 使用 SSL 服务注释定制 Ingress ALB
{: #secrets_ssl_services}

可以使用 [`ingress.bluemix.net/ssl-services` 注释](cs_annotations.html#ssl-services)通过 Ingress ALB 加密流至上游应用程序的流量。要创建私钥，请执行以下操作：

1. 从上游服务器获取认证中心 (CA) 密钥和证书。
2. [将证书转换为 Base64 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.base64encode.org/)。
3. 使用证书创建私钥 YAML 文件。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **注**：如果您还希望对上游流量强制执行相互认证，那么除了 data 部分中的 `trusted.crt` 外，还可以提供 `client.crt` 和 `client.key`。
4. 将证书创建为 Kubernetes 私钥。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### 使用相互认证注释定制 Ingress ALB
{: #secrets_mutual_auth}

可以使用 [`ingress.bluemix.net/mutual-auth` 注释](cs_annotations.html#mutual-auth)来配置 Ingress ALB 的下游流量相互认证。要创建相互认证私钥，请执行以下操作:

1. 通过下列其中一种方式生成密钥和证书：
    * 通过证书提供者生成认证中心 (CA) 证书和密钥。如果您有自己的域，请为您的域购买正式的 TLS 证书。**重要信息**：请确保每个证书的 [CN ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://support.dnsimple.com/articles/what-is-common-name/) 都是不同的。
    * 出于测试目的，可以使用 OpenSSL 创建自签名证书。有关更多信息，请参阅此[自签名 SSL 证书教程 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.akadia.com/services/ssh_test_certificate.html)。
        1. 创建 `ca.key`。
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. 使用密钥创建 `ca.crt`。
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. 使用 `ca.crt` 创建自签名证书。
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [将证书转换为 Base64 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.base64encode.org/)。
3. 使用证书创建私钥 YAML 文件。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. fg将证书创建为 Kubernetes 私钥。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## 使用 GUI 部署应用程序
{: #app_ui}

使用 Kubernetes 仪表板将应用程序部署到集群时，部署资源会在集群中自动创建、更新和管理 pod。
{:shortdesc}

开始之前：

-   安装必需的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要部署应用程序，请执行以下操作：

1.  在 Kubernetes [仪表板](#cli_dashboard)中，单击 **+ 创建**。
2.  通过下面两种方式中的一种来输入应用程序详细信息。
  * 选择**在下面指定应用程序详细信息**，然后输入详细信息。
  * 选择**上传 YAML 或 JSON 文件**以上传应用程序[配置文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。

  需要配置文件的相关帮助？请查看此 [YAML 文件示例 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml)。在此示例中，将从美国南部区域中的 **ibmliberty** 映像部署容器。
  使用 Kubernetes 资源时，请了解有关[确保个人信息安全](cs_secure.html#pi)的更多信息。
  {: tip}

3.  通过下列其中一种方式验证是否已成功部署应用程序。
  * 在 Kubernetes 仪表板中，单击**部署**。这将显示成功部署的列表。
  * 如果应用程序[公开可用](cs_network_planning.html#public_access)，请浏览至 {{site.data.keyword.containerlong}} 仪表板中的集群概述页面。复制位于“集群摘要”部分中的子域，并将其粘贴到浏览器以查看应用程序。

<br />


## 使用 CLI 部署应用程序
{: #app_cli}

创建集群后，可以使用 Kubernetes CLI 将应用程序部署到该集群。
{:shortdesc}

开始之前：

-   安装必需的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要部署应用程序，请执行以下操作：

1.  根据 [Kubernetes 最佳实践 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/overview/) 创建配置文件。通常，配置文件包含要在 Kubernetes 中创建的每个资源的配置详细信息。脚本可能包含以下一个或多个部分：

    -   [部署 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)：定义 pod 和副本集的创建。pod 包含单个容器化应用程序，而副本集用于控制多个 pod 实例。

    -   [服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/)：使用工作程序节点或负载均衡器公共 IP 地址或公共 Ingress 路径，提供对 pod 的前端访问。

    -   [Ingress ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/ingress/)：指定一种类型的负载均衡器，以提供用于公开访问应用程序的路径。

    使用 Kubernetes 资源时，请了解有关[确保个人信息安全](cs_secure.html#pi)的更多信息。

2.  在集群上下文中运行配置文件。

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  如果使用 NodePort 服务、LoadBalancer 服务或 Ingress 使应用程序公共可用，请验证您是否可以访问该应用程序。

<br />


## 使用标签将应用程序部署到特定工作程序节点
{: #node_affinity}

部署应用程序时，应用程序 pod 会不加选择地部署到集群中的各种工作程序节点。在某些情况下，您可能希望限制应用程序 pod 部署到的工作程序节点。例如，您可能希望应用程序 pod 仅部署到特定工作程序池中的工作程序节点，因为这些工作程序节点位于裸机机器上。要指定应用程序 pod 必须部署到的工作程序节点，请将亲缘关系规则添加到应用程序部署。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

1. 获取要将应用程序 pod 部署到的工作程序池的名称。
    ```
    ibmcloud ks worker-pools <cluster_name_or_ID>
    ```
    {:pre}

    这些步骤使用工作程序池名称作为示例。要根据其他因素将应用程序 pod 部署到特定工作程序节点，请改为获取该因素的值。例如，要仅将应用程序 pod 部署到特定 VLAN 上的工作程序节点，请通过运行 `ibmcloud ks vlans <zone>` 来获取 VLAN 标识。
    {: tip}

2. 向应用程序部署[添加亲缘关系规则 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature)（针对工作程序池名称）。

    示例 YAML：

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - <worker_pool_name>
    ...
    ```
    {: codeblock}

    在示例 YAML 的 **affinity** 部分中，`workerPool` 为 `key`，`<worker_pool_name>` 为 `value`。

3. 应用已更新的部署配置文件。
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

4. 验证应用程序 pod 是否部署到正确的工作程序节点。

    1. 列出集群中的 pod。
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        输出示例：
        ```
                NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 在输出中，确定应用程序的 pod。记下该 pod 所在的工作程序节点的 **NODE** 专用 IP 地址。

        在上面的示例输出中，应用程序 pod `cf-py-d7b7d94db-vp8pq` 位于 IP 地址为 `10.176.48.78` 的工作程序节点上。

    3. 列出在应用程序部署中指定的工作程序池中的工作程序节点。

        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        输出示例：

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        如果基于其他因素创建了应用程序亲缘关系规则，请改为获取该因素的值。例如，要验证部署到特定 VLAN 上工作程序节点的应用程序 pod，请通过运行 `ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>` 查看工作程序节点所在的 VLAN。
        {: tip}

    4. 在输出中，验证在先前步骤中识别的具有专用 IP 地址的工作程序节点是否部署在此工作程序池中。

<br />


## 在 GPU 机器上部署应用程序
{: #gpu_app}

如果您有[裸机图形处理单元 (GPU) 机器类型](cs_clusters.html#shared_dedicated_node)，那么可以在工作程序节点上安排数学密集型工作负载。例如，您可以运行使用计算统一设备体系结构 (CUDA) 平台的 3D 应用程序，使处理负载在 GPU 和 CPU 上共享以提高性能。
{:shortdesc}

在以下步骤中，您将了解如何部署需要 GPU 的工作负载。您还可以[部署应用程序](#app_ui)，这些应用程序无需处理 GPU 和 CPU 上的工作负载。之后，您可能会发现使用数学密集型工作负载（例如，[此 Kubernetes 演示 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/pachyderm/pachyderm/tree/master/doc/examples/ml/tensorflow) 中的 [TensorFlow ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.tensorflow.org/) 机器学习框架）非常有用。

开始之前：
* [创建裸机 GPU 机器类型](cs_clusters.html#clusters_cli)。请注意，完成此过程可能需要超过 1 个工作日的时间。
* 集群主节点和 GPU 工作程序节点必须运行 Kubernetes V1.10 或更高版本。

要在 GPU 机器上执行工作负载，请执行以下操作：
1.  创建 YAML 文件。在此示例中，`Job` YAML 管理类似批处理的工作负载的方式是，生成一个运行时间很短的 pod，该 pod 一直运行到将其安排为完成的命令成功终止。

    **重要信息**：对于 GPU 工作负载，必须始终在 YAML 规范中提供 `resources: limits: nvidia.com/gpu` 字段。

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>YAML 的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td>元数据和标签名称</td>
    <td>为作业提供名称和标签，并在文件的元数据和 `spec template` 元数据中使用相同的名称。例如，`nvidi-smi`。</td>
    </tr>
    <tr>
    <td><code>containers/image</code></td>
    <td>提供容器是其运行实例的映像。在此示例中，该值设置为使用 DockerHub CUDA 映像：<code>nvidia/cuda:9.1-base-ubuntu16.04</code></td>
    </tr>
    <tr>
    <td><code>containers/command</code></td>
    <td>指定要在容器中运行的命令。在此示例中，<code>[ "/usr/test/nvidia-smi" ]</code> 命令引用 GPU 机器上的二进制文件，因此您还必须设置卷安装。</td>
    </tr>
    <tr>
    <td><code>containers/imagePullPolicy</code></td>
    <td>要仅在映像当前不在工作程序节点上时才拉取新映像，请指定 <code>IfNotPresent</code>。</td>
    </tr>
    <tr>
    <td><code>resources/limits</code></td>
    <td>对于 GPU 机器，必须指定资源限制。Kubernetes [设备插件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) 会设置缺省资源请求以与该限制相匹配。
    <ul><li>必须将键指定为 <code>nvidia.com/gpu</code>。</li>
    <li>输入整数表示请求的 GPU 数，例如 <code>2</code>。<strong>注</strong>：容器 pod 不会共享 GPU，并且 GPU 也无法超量使用。例如，如果只有 1 个 `mg1c.16x128` 机器，那么该机器中只有 2 个 GPU，因此可以指定的最大值为 `2`。</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>对安装到容器上的卷命名，例如 <code>nvipi0</code>。指定该卷在容器上的 <code>mountPath</code>。在此示例中，路径 <code>/usr/test</code> 与作业容器命令中使用的路径相匹配。</td>
    </tr>
    <tr>
    <td><code>volumes</code></td>
    <td>对作业卷命名，例如 <code>nvia0</code>。在 GPU 工作程序节点的 <code>hostPath</code> 中，指定卷在主机上的 <code>path</code>，在此示例中为 <code>/usr/bin</code>。容器 <code>mountPath</code> 会映射到主机卷 <code>path</code>，这使此作业能够访问 GPU 工作程序节点上供容器命令运行的 NVIDIA 二进制文件。</td>
    </tr>
    </tbody></table>

2.  应用 YAML 文件。例如：

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  通过按 `nvipia-sim` 标签过滤 pod 来检查作业 pod。验证 **STATUS** 是否为 **Completed**。

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    输出示例：
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  对 pod 执行 describe 命令，以查看 GPU 设备插件是如何安排 pod 的。
    * 在 `Limits` 和 `Requests` 字段中，确保指定的资源限制与设备插件自动设置的请求相匹配。
    * 在 Events 中，验证是否已将 pod 分配给 GPU 工作程序节点。

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    输出示例：
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  要验证作业是否使用了 GPU 来计算其工作负载，可以检查日志。从作业发出的 `[ "/usr/test/nvidia-smi" ]` 命令查询 GPU 工作程序节点上的 GPU 设备状态。

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    输出示例：
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    在此示例中，您看到两个 GPU 都用于执行作业，因为这两个 GPU 均已安排在工作程序节点中。如果限制设置为 1，那么仅显示 1 个 GPU。

## 扩展应用程序
{: #app_scaling}

使用 Kubernetes，可以启用[水平 pod 自动扩展 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)，以根据 CPU 来自动增加或减少应用程序的实例数。
{:shortdesc}

需要有关扩展 Cloud Foundry 应用程序的信息？请查看 [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html)。
{: tip}

开始之前：
- [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。
- 必须在要自动扩展的集群中部署 heapster 监视。

步骤：

1.  通过 CLI 将应用程序部署到集群。部署应用程序时，必须请求 CPU。


    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>kubectl run 的命令组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>要部署的应用程序。</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>容器的必需 CPU，以千分之一核心数为单位指定。例如，<code>--requests=200m</code>。</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>为 true 时，创建外部服务。</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>应用程序对外部可用的端口。</td>
    </tr></tbody></table>

    对于更复杂的部署，您可能需要创建[配置文件](#app_cli)。
    {: tip}

2.  创建自动扩展程序并定义策略。有关使用 `kubectl autoscale` 命令的更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale)。

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <caption>kubectl autoscale 的命令组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Horizontal Pod Autoscaler 保持的平均 CPU 使用率，以百分比为单位指定。</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>用于保持指定 CPU 使用率百分比的最小部署 Pod 数。</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>用于保持指定 CPU 使用率百分比的最大部署 Pod 数。</td>
    </tr>
    </tbody></table>


<br />


## 管理滚动部署
{: #app_rolling}

可以通过自动和受控方式来管理如何应用您的更改。如果应用未按计划开展，那么可以将部署回滚到先前的修订版。
{:shortdesc}

开始之前，请创建[部署](#app_cli)。

1.  [应用 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) 更改。例如，您可能希望更改初始部署中使用的映像。

    1.  获取部署名称。

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  获取 pod 名称。

        ```
            kubectl get pods
            ```
        {: pre}

    3.  获取在 pod 中运行的容器的名称。

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  设置新映像以供部署使用。

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    运行命令时，更改会立即应用并会记录在应用历史记录中。

2.  检查部署的状态。

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  回滚更改。
    1.  查看部署的应用历史记录，并确定上次部署的修订版号。

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **提示**：要查看特定修订版的详细信息，请包含相应的修订版号。

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  回滚到先前的版本或指定修订版。要回滚到先前的版本，请使用以下命令。

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />

