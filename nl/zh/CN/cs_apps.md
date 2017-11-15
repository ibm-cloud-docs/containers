---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-05"

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
{: #cs_apps}

您可以使用 Kubernetes 方法来部署应用程序，并确保应用程序始终正常运行。例如，可以执行滚动更新以及回滚，而不给用户造成任何停机时间。
{:shortdesc}

部署应用程序通常包含以下步骤。

1.  [安装 CLI](cs_cli_install.html#cs_cli_install)。

2.  为应用程序创建配置文件。[查看 Kubernetes 中的最佳实践。![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  通过使用以下某种方法来运行配置文件。
    -   [Kubernetes CLI](#cs_apps_cli)
    -   Kubernetes 仪表板
        1.  [启动 Kubernetes 仪表板](#cs_cli_dashboard)。
        2.  [运行配置文件。](#cs_apps_ui)

<br />


## 启动 Kubernetes 仪表板
{: #cs_cli_dashboard}

在本地系统上打开 Kubernetes 仪表板，以查看有关集群及其工作程序节点的信息。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。此任务需要[管理员访问策略](cs_cluster.html#access_ov)。验证您当前的[访问策略](cs_cluster.html#view_access)。

可以使用缺省端口或设置自己的端口来启动集群的 Kubernetes 仪表板。
-   使用缺省端口 8001 启动 Kubernetes 仪表板。
    1.  使用缺省端口号设置代理。

        ```
        kubectl proxy
        ```
        {: pre}

        CLI 输出将类似于以下内容：

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 浏览器中打开以下 URL 以查看 Kubernetes 仪表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   使用您自己的端口启动 Kubernetes 仪表板。
    1.  使用您自己的端口号设置代理。

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  在浏览器中打开以下 URL。

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


对 Kubernetes 仪表板操作完毕后，使用 `CTRL+C` 以退出 `proxy` 命令。退出后，Kubernetes 仪表板不再可用。再次运行 `proxy` 命令以重新启动 Kubernetes 仪表板。

<br />


## 允许对应用程序进行公共访问
{: #cs_apps_public}

要使应用程序公开可用，必须先更新配置文件，然后再将应用程序部署到集群中。
{:shortdesc}

根据创建的是 Lite 集群还是标准集群，有不同的方式使应用程序可从因特网进行访问。

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort 服务</a>（Lite 和标准集群）</dt>
<dd>在每个工作程序节点上公开一个公共端口，并使用任一工作程序节点的公共 IP 地址来公共访问集群中的服务。工作程序节点的公共 IP 地址不是永久固定的。除去或重新创建工作程序节点时，将为该工作程序节点分配新的公共 IP 地址。在测试应用程序的公共访问权时，或者仅在短时间内需要公共访问权时，可以使用 NodePort 服务。需要服务端点具有稳定的公共 IP 地址和更高可用性时，请使用 LoadBalancer 服务或 Ingress 来公开应用程序。</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer 服务</a>（仅限标准集群）</dt>
<dd>每个标准集群供应有 4 个可移植的公共 IP 地址和 4 个可移植的专用 IP 地址，这些 IP 地址可以用于为应用程序创建外部 TCP/UDP 负载均衡器。您可以通过公开应用程序需要的任何端口来定制负载均衡器。分配给负载均衡器的可移植公共 IP 地址是永久固定的，在集群中重新创建工作程序节点时不会更改。</br>
如果需要对应用程序进行 HTTP 或 HTTPS 负载均衡，并且要使用一个公共路径将集群中的多个应用程序作为服务公开，请使用 {{site.data.keyword.containershort_notm}} 的内置 Ingress 支持。</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a>（仅限标准集群）</dt>
<dd>通过创建一个外部 HTTP 或 HTTPS 负载均衡器来使用安全的唯一公共入口点将入局请求路由到集群中的多个应用程序，从而公开这些应用程序。Ingress 由两个主要组件组成：Ingress 资源和 Ingress 控制器。Ingress 资源用于定义如何对应用程序的入局请求进行路由和负载均衡的规则。所有 Ingress 资源都必须向 Ingress 控制器进行注册；Ingress 控制器基于为每个 Ingress 资源定义的规则来侦听入局 HTTP 或 HTTPS 服务请求并转发请求。如果要使用定制路由规则实施自己的负载均衡器，并且需要对应用程序进行 SSL 终止，请使用 Ingress。</dd></dl>

### 使用 NodePort 服务类型来配置对应用程序的公共访问权
{: #cs_apps_public_nodeport}

通过使用集群中任何工作程序节点的公共 IP 地址并公开节点端口，使应用程序公共可用。此选项可用于测试公共访问权和短期使用公共访问权。
{:shortdesc}

对于 Lite 或标准集群，可以将应用程序公开为 Kubernetes NodePort 服务。

对于 {{site.data.keyword.Bluemix_notm}} Dedicated 环境，防火墙会阻止公共 IP 地址。要使应用程序公开可用，请改为使用 [LoadBalancer 服务](#cs_apps_public_load_balancer)或 [Ingress](#cs_apps_public_ingress)。

**注**：工作程序节点的公共 IP 地址不是永久固定的。如果必须重新创建工作程序节点，那么将为该工作程序节点分配新的公共 IP 地址。如果需要服务具有稳定的公共 IP 地址和更高可用性，请使用 [LoadBalancer 服务](#cs_apps_public_load_balancer)或 [Ingress](#cs_apps_public_ingress) 来公开应用程序。




1.  在配置文件中定义 [service ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/) 部分。
2.  在 service 的 `spec` 部分中，添加 NodePort 类型。

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  可选：在 `ports` 部分中，添加范围为 30000-32767 的 NodePort。不要指定其他服务已经在使用的 NodePort。如果不确定哪些 NodePort 已经在使用，请不要进行分配。如果未分配 NodePort，系统将为您分配随机的 NodePort。

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    如果要指定 NodePort，并希望查看哪些 NodePort 已在使用，可以运行以下命令。


    ```
    kubectl get svc
    ```
    {: pre}

    输出：

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  保存更改。
5.  重复上述步骤以为每个应用程序创建服务。

    示例：

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**接下来要做什么？**

应用程序部署后，可以使用任何工作程序节点的公共 IP 地址和 NodePort 来构成公共 URL，以用于在浏览器中访问该应用程序。

1.  获取集群中工作程序节点的公共 IP 地址。

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    输出：

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
    ```
    {: screen}

2.  如果分配了随机 NodePort，请了解分配的是哪个 NodePort。

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    输出：

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    在此示例中，NodePort为 `30872`。

3.  使用其中一个工作程序节点公共 IP 地址和 NodePort 来构成 URL。示例：`http://192.0.2.23:30872`

### 使用 LoadBalancer 服务类型来配置对应用程序的访问权
{: #cs_apps_public_load_balancer}

公开一个端口，并使用负载均衡器的可移植公共或专用 IP 地址来访问应用程序。与 NodePort 服务不同，LoadBalancer 服务的可移植 IP 地址不依赖于应用程序所部署到的工作程序节点。但是，Kubernetes LoadBalancer 服务也是 NodePort 服务。LoadBalancer 服务通过负载均衡器 IP 地址和端口提供应用程序，并通过服务的节点端口使应用程序可用。 

 系统将为您分配负载均衡器的可移植 IP 地址，并且在添加或除去工作程序节点时不会更改此 IP 地址。因此，LoadBalancer 服务要比 NodePort 服务具有更高的可用性。用户可以选择负载均衡器的任何端口，端口不限于 NodePort 端口范围。可以将 LoadBalancer 服务用于 TCP 和 UDP 协议。

[已针对集群启用](cs_ov.html#setup_dedicated) {{site.data.keyword.Bluemix_notm}} Dedicated 帐户时，可以请求将公共子网用于负载均衡器 IP 地址。请[开具支持凭单](/docs/support/index.html#contacting-support)来创建子网，然后使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 命令将子网添加到集群。

**注**：LoadBalancer 服务不支持 TLS 终止。如果应用程序需要 TLS 终止，可以通过使用 [Ingress](#cs_apps_public_ingress) 公开应用程序，或者配置应用程序以管理 TLS 终止。

开始之前：

-   此功能仅可用于标准集群。
-   必须有可移植公共或专用 IP 地址可用于分配给 LoadBalancer 服务。
-   具有可移植专用 IP 地址的 LoadBalancer 服务仍在每个工作程序节点上打开公共节点端口。要添加网络策略以防止公共流量，请参阅[阻止入局流量](cs_security.html#cs_block_ingress)。

要创建 LoadBalancer 服务，请执行以下操作：

1.  [将应用程序部署到集群](#cs_apps_cli)。将应用程序部署到集群时，将创建一个或多个 pod 以用于在容器中运行应用程序。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。
2.  针对要公开的应用程序创建 LoadBalancer 服务。要使应用程序在公共因特网或专用网络上可用，请为您的应用程序创建 Kubernetes 服务。配置该服务以在负载均衡中包含构成该应用程序的所有 pod。
    1.  创建名为 `myloadbalancer.yaml`（举例来说）的服务配置文件。
    2.  针对要公开的应用程序定义 LoadBalancer 服务。
        - 如果集群位于公用 VLAN 上，那么将使用可移植的公共 IP 地址。大多数集群都位于公用 VLAN 上。
        - 如果集群仅在专用 VLAN 上可用，那么将使用可移植的专用 IP 地址。 
        - 通过向配置文件添加注释，可请求用于 LoadBalancer 服务的可移植公共或专用 IP 地址。

        使用缺省 IP 地址的 LoadBalancer 服务：
        
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}
        
        使用注释来指定专用或公共 IP 地址的 LoadBalancer 服务：
        
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations: 
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private> 
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>将 <em>&lt;myservice&gt;</em> 替换为 LoadBalancer 服务的名称。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>输入要用于将应用程序运行所在 pod 设定为目标的标签键 (<em>&lt;selectorkey&gt;</em>) 和值 (<em>&lt;selectorvalue&gt;</em>) 对。例如，如果使用 selector <code>app: code</code>，那么在其元数据中具有此标签的所有 pod 都会包含在负载均衡中。输入将应用程序部署到集群时使用的标签。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服务侦听的端口。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>指定 LoadBalancer 类型的注释。值为 `private` 和 `public`。在公用 VLAN 上的集群中创建公共 LoadBalancer 时，不需要此注释。</tbody></table>
    3.  可选：要将特定可移植 IP 地址用于可供集群使用的负载均衡器，可以通过在 spec 部分中包含 `loadBalancerIP` 来指定该 IP 地址。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/)。
    4.  可选：通过在 spec 部分中指定 `loadBalancerSourceRanges` 来配置防火墙。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。
    5.  在集群中创建服务。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

创建 LoadBalancer 服务时，会自动为负载均衡器分配一个可移植 IP 地址。如果没有可移植 IP 地址可用，那么无法创建 LoadBalancer 服务。
3.  验证 LoadBalancer 服务是否已成功创建。将 _&lt;myservice&gt;_ 替换为在上一步中创建的 LoadBalancer 服务的名称。

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **注**：可能需要几分钟时间，才能正确创建 LoadBalancer 服务并使应用程序可用。

    示例 CLI 输出：

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

**LoadBalancer Ingress** IP 地址是分配给 LoadBalancer 服务的可移植 IP 地址。
4.  如果创建了公共负载均衡器，请从因特网访问该应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入负载均衡器的可移植公共 IP 地址和端口。在上述示例中，可移植公共 IP 地址 `192.168.10.38` 已分配给 LoadBalancer 服务。

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### 使用 Ingress 控制器来配置对应用程序的公共访问权
{: #cs_apps_public_ingress}

通过创建由 IBM 提供的 Ingress 控制器管理的 Ingress 资源，公开集群中的多个应用程序。Ingress 控制器是一个外部 HTTP 或 HTTPS 负载均衡器，使用安全的唯一公共入口点将入局请求路由到集群内部或外部的应用程序。

**注**：Ingress 仅可用于标准集群，并要求集群中至少有两个工作程序节点以确保高可用性。设置 Ingress 需要[管理员访问策略](cs_cluster.html#access_ov)。验证您当前的[访问策略](cs_cluster.html#view_access)。

创建标准集群时，会自动创建 Ingress 控制器，并为其分配一个可移植公共 IP 地址和一个公共路径。可以配置 Ingress 控制器，并为您向公众公开的每个应用程序定义单独的路由规则。通过 Ingress 公开的每个应用程序都会分配有唯一路径，此路径会附加到公共路径，以便您可以使用唯一 URL 在集群中公共访问应用程序。

[已针对集群启用](cs_ov.html#setup_dedicated) {{site.data.keyword.Bluemix_notm}} Dedicated 帐户时，可以请求将公用子网用于 Ingress 控制器 IP 地址。随后，创建 Ingress 控制器并分配公共路径。请[开具支持凭单](/docs/support/index.html#contacting-support)来创建子网，然后使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 命令将子网添加到集群。

可以针对以下场景配置 Ingress 控制器。

-   [使用 IBM 提供的域（不带 TLS 终止）](#ibm_domain)
-   [使用 IBM 提供的域（带 TLS 终止）](#ibm_domain_cert)
-   [使用定制域和 TLS 证书执行 TLS 终止](#custom_domain_cert)
-   [使用 IBM 提供的域或定制域（带 TLS 终止）访问集群外部的应用程序](#external_endpoint)
-   [使用注释定制 Ingress 控制器](#ingress_annotation)

#### 使用 IBM 提供的域（不带 TLS 终止）
{: #ibm_domain}

可以配置 Ingress 控制器作为集群中应用程序的 HTTP 负载均衡器，并使用 IBM 提供的域从因特网访问应用程序。

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_cluster.html#cs_cluster_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

要配置 Ingress 控制器，请执行以下操作：

1.  [将应用程序部署到集群](#cs_apps_cli)。将应用程序部署到集群时，将创建一个或多个 pod 以用于在容器中运行应用程序。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。
2.  针对要公开的应用程序创建 Kubernetes 服务。仅当通过集群内部的 Kubernetes 服务公开应用程序时，Ingress 控制器才能将该应用程序包含到 Ingress 负载均衡中。
    1.  打开首选编辑器，并创建服务配置文件，例如名为 `myservice.yaml`。
    2.  针对要向公众公开的应用程序定义服务。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myservice&gt;</em> 替换为 LoadBalancer 服务的名称。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>输入要用于将应用程序运行所在 pod 设定为目标的标签键 (<em>&lt;selectorkey&gt;</em>) 和值 (<em>&lt;selectorvalue&gt;</em>) 对。例如，如果使用 selector <code>app: code</code>，那么在其元数据中具有此标签的所有 pod 都会包含在负载均衡中。输入将应用程序部署到集群时使用的标签。</td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>服务侦听的端口。</td>
         </tr>
         </tbody></table>
    3.  保存更改。
    4.  在集群中创建服务。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  针对要向公众公开的每个应用程序，重复上述步骤。
3.  获取集群的详细信息以查看 IBM 提供的域。将 _&lt;mycluster&gt;_ 替换为要向公众公开的应用程序部署所在集群的名称。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 输出类似于以下内容。

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

可以在 **Ingress subdomain** 字段中查看 IBM 提供的域。
4.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 Ingress 控制器用于将入局网络流量路由到该服务。可以使用一个 Ingress 资源来针对多个应用程序定义路由规则，前提是每个应用程序都已通过集群内部的 Kubernetes 服务公开。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingress.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域将入局网络流量路由到先前创建的服务。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myingressname&gt;</em> 替换为 Ingress 资源的名称。</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;ibmdomain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。

        </br></br>
        <strong>注：</strong>不要使用 * 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;myservicepath1&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 <code>ingress_domain/myservicepath1</code>。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器会查找关联的服务，将网络流量发送到该服务，并使用相同路径发送到应用程序运行所在的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
        </br>
        示例：<ul><li>对于 <code>http://ingress_host_name/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://ingress_host_name/myservicepath</code>，请输入 <code>/myservicepath</code> 作为路径。</li></ul>
        </br>
        <strong>提示</strong>：如果要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，那么可以使用 <a href="#rewrite" target="_blank">rewrite 注释</a>来确定应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;myservice1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  验证 Ingress 资源是否已成功创建。将 _&lt;myingressname&gt;_ 替换为先前创建的 Ingress 资源的名称。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **注**：可能需要几分钟时间，才能创建好 Ingress 资源并使应用程序在公共因特网上可用。
6.  在 Web 浏览器中，输入要访问的应用程序服务的 URL。

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### 使用 IBM 提供的域（带 TLS 终止）
{: #ibm_domain_cert}

可以配置 Ingress 控制器来管理应用程序的入局 TLS 连接，使用 IBM 提供的 TLS 证书解密网络流量，然后将未加密的请求转发到集群中公开的应用程序。

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_cluster.html#cs_cluster_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

要配置 Ingress 控制器，请执行以下操作：

1.  [将应用程序部署到集群](#cs_apps_cli)。确保在配置文件的 metadata 部分中添加针对您的部署的标签。此标签用于识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。
2.  针对要公开的应用程序创建 Kubernetes 服务。仅当通过集群内部的 Kubernetes 服务公开应用程序时，Ingress 控制器才能将该应用程序包含到 Ingress 负载均衡中。
    1.  打开首选编辑器，并创建服务配置文件，例如名为 `myservice.yaml`。
    2.  针对要向公众公开的应用程序定义服务。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myservice&gt;</em> 替换为 Kubernetes 服务的名称。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>输入要用于将应用程序运行所在 pod 设定为目标的标签键 (<em>&lt;selectorkey&gt;</em>) 和值 (<em>&lt;selectorvalue&gt;</em>) 对。例如，如果使用 selector <code>app: code</code>，那么在其元数据中具有此标签的所有 pod 都会包含在负载均衡中。输入将应用程序部署到集群时使用的标签。</td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>服务侦听的端口。</td>
         </tr>
         </tbody></table>

    3.  保存更改。
    4.  在集群中创建服务。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  针对要向公众公开的每个应用程序，重复上述步骤。

3.  查看 IBM 提供的域和 TLS 证书。将 _&lt;mycluster&gt;_ 替换为在其中部署应用程序的集群的名称。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 输出类似于以下内容。

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    可以在 **Ingress subdomain** 字段中查看 IBM 提供的域，在 **Ingress secret** 字段中查看 IBM 提供的证书。

4.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 Ingress 控制器用于将入局网络流量路由到该服务。可以使用一个 Ingress 资源来针对多个应用程序定义路由规则，前提是每个应用程序都已通过集群内部的 Kubernetes 服务公开。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingress.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域将入局网络流量路由到服务，并使用 IBM 提供的证书来管理 TLS 终止。对于每个服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 `https://ingress_domain/myapp`。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器会查找关联的服务，并将网络流量发送到该服务，然后进一步发送到应用程序运行所在的 pod。

        **注**：应用程序必须侦听的是 Ingress 资源中定义的路径。否则，网络流量无法转发到该应用程序。大多数应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 `/`，并且不要为应用程序指定单独的路径。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myingressname&gt;</em> 替换为 Ingress 资源的名称。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>将 <em>&lt;ibmdomain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>将 <em>&lt;ibmtlssecret&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress secret</strong> 名称。此证书用于管理 TLS 终止。</tr>
        <tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;ibmdomain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;myservicepath1&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 <code>ingress_domain/myservicepath1</code>。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器会查找关联的服务，将网络流量发送到该服务，并使用相同路径发送到应用程序运行所在的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br>
        示例：<ul><li>对于 <code>http://ingress_host_name/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://ingress_host_name/myservicepath</code>，请输入 <code>/myservicepath</code> 作为路径。</li></ul>
        <strong>提示</strong>：如果要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，那么可以使用 <a href="#rewrite" target="_blank">rewrite 注释</a>来确定应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;myservice1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  验证 Ingress 资源是否已成功创建。将 _&lt;myingressname&gt;_ 替换为先前创建的 Ingress 资源的名称。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注**：可能需要几分钟时间，才能正确创建 Ingress 资源并使应用程序在公共因特网上可用。
6.  在 Web 浏览器中，输入要访问的应用程序服务的 URL。

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### 将 Ingress 控制器用于定制域和 TLS 证书
{: #custom_domain_cert}

使用定制域而不是 IBM 提供的域时，可以配置 Ingress 控制器以将入局网络流量路由到集群中的应用程序，并使用您自己的 TLS 证书来管理 TLS 终止。
{:shortdesc}

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_cluster.html#cs_cluster_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

要配置 Ingress 控制器，请执行以下操作：

1.  创建定制域。要创建定制域，请使用域名服务 (DNS) 提供程序来注册定制域。
2.  配置域以将入局网络流量路由到 IBM Ingress 控制器。在以下选项之间进行选择：
    -   通过将 IBM 提供的域指定为规范名称记录 (CNAME)，定义定制域的别名。要找到 IBM 提供的 Ingress 域，请运行 `bx cs cluster-get <mycluster>` 并查找 **Ingress subdomain** 字段。
    -   通过将 IBM 提供的 Ingress 控制器的可移植公共 IP 地址添加为记录，将定制域映射到该 IP 地址。要找到 Ingress 控制器的可移植公共 IP 地址，请执行以下操作：
        1.  运行 `bx cs cluster-get <mycluster>` 并查找 **Ingress subdomain** 字段。
        2.  运行 `nslookup <Ingress subdomain>`.
3.  为域创建以 PEM 格式编码的 TLS 证书和密钥。
4.  将 TLS 证书和密钥存储在 Kubernetes 私钥中。
    1.  打开首选编辑器，并创建 Kubernetes 私钥配置文件，例如名为 `mysecret.yaml`。
    2.  定义使用您的 TLS 证书和密钥的私钥。

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;mytlssecret&gt;</em> 替换为 Kubernetes 私钥的名称。</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>将 <em>&lt;tlscert&gt;</em> 替换为以基本 64 位格式编码的定制 TLS 证书。</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>将 <em>&lt;tlskey&gt;</em> 替换为以基本 64 位格式编码的定制 TLS 密钥。</td>
         </tbody></table>

    3.  保存配置文件。
    4.  为集群创建 TLS 私钥。

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [将应用程序部署到集群](#cs_apps_cli)。将应用程序部署到集群时，将创建一个或多个 pod 以用于在容器中运行应用程序。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

6.  针对要公开的应用程序创建 Kubernetes 服务。仅当通过集群内部的 Kubernetes 服务公开应用程序时，Ingress 控制器才能将该应用程序包含到 Ingress 负载均衡中。

    1.  打开首选编辑器，并创建服务配置文件，例如名为 `myservice.yaml`。
    2.  针对要向公众公开的应用程序定义服务。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myservice1&gt;</em> 替换为 Kubernetes 服务的名称。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>输入要用于将应用程序运行所在 pod 设定为目标的标签键 (<em>&lt;selectorkey&gt;</em>) 和值 (<em>&lt;selectorvalue&gt;</em>) 对。例如，如果使用 selector <code>app: code</code>，那么在其元数据中具有此标签的所有 pod 都会包含在负载均衡中。输入将应用程序部署到集群时使用的标签。</td>
         </tr>
         <td><code>port</code></td>
         <td>服务侦听的端口。</td>
         </tbody></table>

    3.  保存更改。
    4.  在集群中创建服务。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  针对要向公众公开的每个应用程序，重复上述步骤。
7.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 Ingress 控制器用于将入局网络流量路由到该服务。可以使用一个 Ingress 资源来针对多个应用程序定义路由规则，前提是每个应用程序都已通过集群内部的 Kubernetes 服务公开。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingress.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用定制域将入局网络流量路由到服务，并使用定制证书来管理 TLS 终止。对于每个服务，可以定义附加到定制域的单独路径，以创建应用程序的唯一路径，例如 `https://mydomain/myapp`。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器会查找关联的服务，并将网络流量发送到该服务，然后进一步发送到应用程序运行所在的 pod。

        **注**：务必确保应用程序侦听的是 Ingress 资源中定义的路径。否则，网络流量无法转发到该应用程序。大多数应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 `/`，并且不要为应用程序指定单独的路径。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myingressname&gt;</em> 替换为 Ingress 资源的名称。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>将 <em>&lt;mycustomdomain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>将 <em>&lt;mytlssecret&gt;</em> 替换为先前创建的私钥的名称，此私钥保存用于管理定制域的 TLS 终止的定制 TLS 证书和密钥。</tr>
        <tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;mycustomdomain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;myservicepath1&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 <code>ingress_domain/myservicepath1</code>。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器会查找关联的服务，将网络流量发送到该服务，并使用相同路径发送到应用程序运行所在的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br></br>
        示例：<ul><li>对于 <code>https://mycustomdomain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>https://mycustomdomain/myservicepath</code>，请输入 <code>/myservicepath</code> 作为路径。</li></ul>
        <strong>提示</strong>：如果要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，那么可以使用 <a href="#rewrite" target="_blank">rewrite 注释</a>来确定应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;myservice1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  保存更改。
    4.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  验证 Ingress 资源是否已成功创建。将 _&lt;myingressname&gt;_ 替换为先前创建的 Ingress 资源的名称。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注**：可能需要几分钟时间，才能正确创建 Ingress 资源并使应用程序在公共因特网上可用。


9.  通过因特网访问应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入要访问的应用程序服务的 URL。

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### 配置 Ingress 控制器以将网络流量路由到集群外部的应用程序
{: #external_endpoint}

可以针对要包含在集群负载均衡中的集群外部应用程序配置 Ingress 控制器。IBM 提供的域或定制域上的入局请求会自动转发到外部应用程序。

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_cluster.html#cs_cluster_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。
-   确保要包含在集群负载均衡中的外部应用程序可以使用公共 IP 地址进行访问。

您可以配置 Ingress 控制器，以将 IBM 提供的域上的入局网络流量路由到位于集群外部的应用程序。如果要改为使用定制域和 TLS 证书，请将 IBM 提供的域和 TLS 证书替换为[定制域和 TLS 证书](#custom_domain_cert)。

1.  配置 Kubernetes 端点以定义要包含在集群负载均衡中的应用程序的外部位置。
    1.  打开首选编辑器，并创建端点配置文件，例如名为 `myexternalendpoint.yaml`。
    2.  定义外部端点。包括所有可用于访问外部应用程序的公共 IP 地址和端口。


        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myendpointname&gt;</em> 替换为 Kubernetes 端点的名称。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>将 <em>&lt;externalIP&gt;</em> 替换为用于连接到外部应用程序的公共 IP 地址。</td>
         </tr>
         <td><code>port</code></td>
         <td>将 <em>&lt;externalport&gt;</em> 替换为外部应用程序侦听的端口。</td>
         </tbody></table>

    3.  保存更改。
    4.  为集群创建 Kubernetes 端点。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  为集群创建 Kubernetes 服务，并将其配置为将入局请求转发到先前创建的外部端点。
    1.  打开首选编辑器，并创建服务配置文件，例如名为 `myexternalservice.yaml`。
    2.  定义服务。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>将 <em>&lt;myexternalservice&gt;</em> 替换为 Kubernetes 服务的名称。</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>将 <em>&lt;myendpointname&gt;</em> 替换为先前创建的 Kubernetes 端点的名称。</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>服务侦听的端口。</td>
        </tr></tbody></table>

    3.  保存更改。
    4.  为集群创建 Kubernetes 服务。

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

3.  查看 IBM 提供的域和 TLS 证书。将 _&lt;mycluster&gt;_ 替换为在其中部署应用程序的集群的名称。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 输出类似于以下内容。

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    可以在 **Ingress subdomain** 字段中查看 IBM 提供的域，在 **Ingress secret** 字段中查看 IBM 提供的证书。

4.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 Ingress 控制器用于将入局网络流量路由到该服务。可以使用一个 Ingress 资源来针对多个外部应用程序定义路由规则，前提是每个应用程序都已使用其外部端点通过集群内部的 Kubernetes 服务公开。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myexternalingress.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域和 TLS 证书，通过先前定义的外部端点将入局网络流量路由到外部应用程序。对于每个服务，可以定义附加到 IBM 提供的域或定制域的单独路径，以创建应用程序的唯一路径，例如 `https://ingress_domain/myapp`。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器会查找关联的服务，并将网络流量发送到该服务，然后进一步发送到外部应用程序。


        **注**：务必确保应用程序侦听的是 Ingress 资源中定义的路径。否则，网络流量无法转发到该应用程序。大多数应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 /，并且不要为应用程序指定单独的路径。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myingressname&gt;</em> 替换为 Ingress 资源的名称。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>将 <em>&lt;ibmdomain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>将 <em>&lt;ibmtlssecret&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress secret</strong>。此证书用于管理 TLS 终止。</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>将 <em>&lt;ibmdomain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;myexternalservicepath&gt;</em> 替换为斜杠或外部应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个 Kubernetes 服务，可以定义附加到您的域的单独路径，以创建应用程序的唯一路径，例如 <code>https://ibmdomain/myservicepath1</code>。在 Web 浏览器中输入此路径时，网络流量会路由到 Ingress 控制器。Ingress 控制器查找关联的服务，并使用相同的路径将网络流量发送到外部应用程序。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br></br>
        <strong>提示</strong>：如果要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，那么可以使用 <a href="#rewrite" target="_blank">rewrite 注释</a>来确定应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;myexternalservice&gt;</em> 替换为针对外部应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。</td>
        </tr>
        </tbody></table>

    3.  保存更改。
    4.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  验证 Ingress 资源是否已成功创建。将 _&lt;myingressname&gt;_ 替换为先前创建的 Ingress 资源的名称。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注**：可能需要几分钟时间，才能正确创建 Ingress 资源并使应用程序在公共因特网上可用。


6.  访问外部应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入用于访问外部应用程序的 URL。

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}


#### 支持的 Ingress 注释
{: #ingress_annotation}

可以为 Ingress 资源指定元数据，以向 Ingress 控制器添加功能。
{: shortdesc}

|支持的注释|描述|
|--------------------|-----------|
|[重写](#rewrite)|将入局网络流量路由到后端应用程序侦听的其他路径。|
|[使用 cookie 确保会话亲缘关系](#sticky_cookie)|使用粘性 cookie 始终将入局网络流量路由到同一个上游服务器。|
|[额外的客户机请求或响应头](#add_header)|向客户机请求添加额外的头信息，然后将该请求转发到后端应用程序，或者向客户机响应添加额外的头信息，然后将该响应发送到客户机。|
|[除去客户机响应头](#remove_response_headers)|从客户机响应中除去头信息，然后将该响应转发到客户机。|
|[HTTP 重定向到 HTTPS](#redirect_http_to_https)|将域上的不安全的 HTTP 请求重定向到 HTTPS。|
|[客户机响应数据缓冲](#response_buffer)|禁用在向客户机发送响应时 Ingress 控制器上的客户机响应缓冲。|
|[定制连接超时和读取超时](#timeout)|调整 Ingress 控制器等待连接到后端应用程序以及从后端应用程序进行读取的时间，超过该时间后，后端应用程序将视为不可用。|
|[定制最大客户机请求主体大小](#client_max_body_size)|调整允许发送到 Ingress 控制器的客户机请求主体的大小。|
|[定制 HTTP 和 HTTPS 端口](#custom_http_https_ports)|更改 HTTP 和 HTTPS 网络流量的缺省端口。|


##### **使用重写将入局网络流量路由至另一路径**
{: #rewrite}

使用 rewrite 注释将 Ingress 控制器域路径上的入局网络流量路由到后端应用程序侦听的其他路径。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 控制器域将 <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> 上的入局网络流量路由到应用程序。应用程序侦听的是 <code>/coffee</code>，而不是 <code>/beans</code>。要将入局网络流量转发到应用程序，请将 rewrite 注释添加到 Ingress 资源配置文件，以便使用 <code>/coffee</code> 路径将 <code>/beans</code> 上的入局网络流量转发到应用程序。当包含多个服务时，请仅使用分号 (;) 来分隔这些服务。</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;target_path2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>将 <em>&lt;service_name&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称，将 <em>&lt;target-path&gt;</em> 替换为应用程序侦听的路径。Ingress 控制器域上的入局网络流量会使用此路径转发到 Kubernetes 服务。大多数应用程序不会侦听特定路径，而是使用根路径和特定端口。在本例中，将 <code>/</code> 定义为应用程序的 <em>rewrite-path</em>。</td>
</tr>
<tr>
<td><code>path</code></td>
<td>将 <em>&lt;domain_path&gt;</em> 替换为要附加到 Ingress 控制器域的路径。此路径上的入局网络流量会转发到在注释中定义的重写路径。在上述示例中，将域路径设置为 <code>/beans</code> 以在 Ingress 控制器的负载均衡中包含此路径。</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>将 <em>&lt;service_name&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称。此处使用的服务名称必须与在注释中定义的名称相同。</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>将 <em>&lt;service_port&gt;</em> 替换为服务侦听的端口。</td>
</tr></tbody></table>

</dd></dl>


##### **使用粘性 cookie 始终将入局网络流量路由到同一个上游服务器**
{: #sticky_cookie}

使用粘性 cookie 注释向 Ingress 控制器添加会话亲缘关系。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>应用程序设置可能需要部署多个上游服务器来处理入局客户机请求并确保更高的可用性。客户机连接到后端应用程序时，在会话期间或完成任务所需的时间内，客户机由同一个上游服务器提供服务可能会很有用。您可以将 Ingress 控制器配置为始终将入局网络流量路由到同一个上游服务器来确保会话亲缘关系。
</br>
连接到后端应用程序的每个客户机都会由 Ingress 控制器分配其中一个可用的上游服务器。Ingress 控制器会创建会话 cookie，该会话 cookie 存储在客户机的应用程序中，并且包含在 Ingress 控制器和客户机之间每个请求的头信息中。该 cookie 中的信息将确保在整个会话中的所有请求都由同一个上游服务器进行处理。
</br></br>
当包含多个服务时，请使用分号 (;) 来分隔这些服务。</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>表 12. 了解 YAML 文件的组成部分</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul><li><code><em>&lt;service_name&gt;</em></code>：针对您应用程序创建的 Kubernetes 服务的名称。</li><li><code><em>&lt;cookie_name&gt;</em></code>：选择在会话期间创建的粘性 cookie 的名称。</li><li><code><em>&lt;expiration_time&gt;</em></code>：距离粘性 cookie 到期的时间（以秒、分钟或小时为单位）。此时间与用户活动无关。该 cookie 到期后，会被客户机 Web 浏览器删除，并且不会再发送到 Ingress 控制器。例如，要将到期时间设置为 1 秒、1 分钟或 1 小时，请输入 <strong>1s</strong>、<strong>1m</strong> 或 <strong>1h</strong>。</li><li><code><em>&lt;cookie_path&gt;</em></code>：附加到 Ingress 子域的路径，该路径指示将 cookie 发送到 Ingress 控制器的哪些域和子域。例如，如果 Ingress 域为 <code>www.myingress.com</code>，并且您希望在每个客户机请求中都发送 cookie，那么必须设置 <code>path=/</code>。如果希望仅针对 <code>www.myingress.com/myapp</code> 及其所有子域发送 cookie，那么必须设置 <code>path=/myapp</code>。</li><li><code><em>&lt;hash_algorithm&gt;</em></code>：用于保护 cookie 中信息的散列算法。仅支持 <code>sha1</code>。SHA1 基于 cookie 中的信息创建散列总和，并将此散列总和附加到 cookie。服务器可以解密 cookie 中的信息并验证数据完整性。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **将定制 HTTP 头添加到客户机请求或客户机响应**
{: #add_header}

使用此注释可向客户机请求添加额外的头信息，然后将该请求转发到后端应用程序，或者向客户机响应添加额外的头信息，然后将该响应发送到客户机。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 控制器充当客户机应用程序和后端应用程序之间的代理。发送到 Ingress 控制器的客户机请求经过处理（通过代理传递）后放入新的请求中，然后将该新请求从 Ingress 控制器发送到后端应用程序。通过代理传递请求会除去初始从客户机发送的 HTTP 头信息，例如用户名。如果后端应用程序需要这些信息，那么可以使用 <strong>ingress.bluemix.net/proxy-add-headers</strong> 注释向客户机请求添加头信息，然后将该请求从 Ingress 控制器转发到后端应用程序。
</br></br>
后端应用程序向客户机发送响应时，将由 Ingress 控制器作为代理传递响应，并且会从响应中除去 HTTP 头。客户机 Web 应用程序可能需要此头信息才能成功处理响应。可以使用 <strong>ingress.bluemix.net/response-add-headers</strong> 注释向客户机响应添加头信息，然后将该响应从 Ingress 控制器转发到客户机 Web 应用程序。
</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul><li><code><em>&lt;service_name&gt;</em></code>：针对您应用程序创建的 Kubernetes 服务的名称。</li><li><code><em>&lt;header&gt;</em></code>：要添加到客户机请求或客户机响应的头信息的键。</li><li><code><em>&lt;value&gt;</em></code>：要添加到客户机请求或客户机响应的头信息的值。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **从客户机的响应中除去 HTTP 头信息**
{: #remove_response_headers}

使用此注释可除去后端应用程序的客户机响应中包含的头信息，然后将该响应发送到客户机。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 控制器充当后端应用程序和客户机 Web 浏览器之间的代理。发送到 Ingress 控制器的来自后端应用程序的客户机响应经过处理（通过代理传递）后放入新的响应中，然后将该新响应从 Ingress 控制器发送到客户机 Web 浏览器。尽管通过代理传递响应会除去初始从后端应用程序发送的 HTTP 头信息，但此过程可能不会除去所有特定于后端应用程序的头。使用此注释可从客户机响应中除去头信息，然后将该响应从 Ingress 控制器转发到客户机 Web 浏览器。
</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;service_name2&gt; {
      "&lt;header3&gt;";
      }
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul><li><code><em>&lt;service_name&gt;</em></code>：针对您应用程序创建的 Kubernetes 服务的名称。</li><li><code><em>&lt;header&gt;</em></code>：要从客户机响应中除去的头的键。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **将不安全的 HTTP 客户机请求重定向到 HTTPS**
{: #redirect_http_to_https}

使用重定向注释可将不安全的 HTTP 客户机请求转换为 HTTPS。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>将 Ingress 控制器设置为通过 IBM 提供的 TLS 证书或您的定制 TLS 证书来保护域。某些用户可能会尝试向您的 Ingress 控制器域发出不安全的 HTTP 请求（例如 <code>http://www.myingress.com</code>，而不是使用 <code>https</code>）来访问您的应用程序。可以使用重定向注释始终将不安全的 HTTP 请求转换为 HTTPS。如果不使用此注释，缺省情况下，不安全的 HTTP 请求不会转换为 HTTPS 请求，并且可能会向公众公开未加密的保密信息。
</br></br>
缺省情况下，HTTP 请求到 HTTPS 的重定向是禁用的。</dd>
<dt>样本 Ingress 资源 YAML</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **在 Ingress 控制器上禁用后端响应缓冲**
{: #response_buffer}

使用缓冲注释可禁止在将数据发送到客户机期间，在 Ingress 控制器上存储响应数据。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 控制器充当后端应用程序和客户机 Web 浏览器之间的代理。当响应从后端应用程序发送到客户机时，缺省情况下会在 Ingress 控制器上对响应数据进行缓冲。Ingress 控制器作为代理传递客户机响应，并开始按客户机的速度将响应发送到客户机。Ingress 控制器接收到来自后端应用程序的所有数据后，会关闭与后端应用程序的连接。Ingress 控制器与客户机的连接会保持打开状态，直到客户机接收完所有数据为止。
</br></br>
如果在 Ingress 控制器上禁用响应数据缓冲，那么数据会立即从 Ingress 控制器发送到客户机。客户机必须能够按 Ingress 控制器的速度来处理入局数据。如果客户机速度太慢，数据可能会丢失。
</br></br>
缺省情况下，Ingress 控制器上启用了响应数据缓冲。</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **为 Ingress 控制器设置定制连接超时和读取超时**
{: #timeout}

调整 Ingress 控制器等待连接到后端应用程序以及从后端应用程序进行读取的时间，在超过该时间后，后端应用程序将视为不可用。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>将客户机请求发送到 Ingress 控制器时，Ingress 控制器会打开与后端应用程序的连接。缺省情况下，Ingress 控制器会等待 60 秒以接收来自后端应用程序的应答。如果后端应用程序在 60 秒内未应答，那么连接请求将异常中止，并且后端应用程序将视为不可用。
</br></br>
Ingress 控制器连接到后端应用程序时，Ingress 控制器会读取来自后端应用程序的响应数据。在此读操作期间，Ingress 控制器在两次读操作之间等待接收来自后端应用程序的数据的最长时间为 60 秒。如果后端应用程序在 60 秒内未发送数据，那么与后端应用程序的连接请求将关闭，并且后端应用程序将视为不可用。
</br></br>
60 秒连接超时和读取超时是代理上的缺省超时，理想情况下不应进行更改。
</br></br>
如果由于工作负载过高而导致应用程序的可用性不稳定或应用程序响应速度缓慢，那么您可能会希望增大连接超时或读取超时。请记住，增大超时会影响 Ingress 控制器的性能，因为与后端应用程序的连接必须保持打开状态，直至达到超时为止。
</br></br>
另一方面，您可以减小超时以提高 Ingress 控制器的性能。确保后端应用程序能够在指定的超时内处理请求，即使在更高的工作负载期间。</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul><li><code><em>&lt;connect_timeout&gt;</em></code>：输入等待连接到后端应用程序的秒数，例如 <strong>65s</strong>。

  </br></br>
  <strong>注</strong>：连接超时不能超过 75 秒。</li><li><code><em>&lt;read_timeout&gt;</em></code>：输入读取后端应用程序前等待的秒数，例如 <strong>65s</strong>。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **设置允许的最大客户机请求主体大小**
{: #client_max_body_size}

调整客户机可以作为请求一部分发送的主体的大小。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>为了保持期望的性能，最大客户机请求主体大小设置为 1 兆字节。将主体大小超出此限制的客户机请求发送到 Ingress 控制器，并且客户机不允许将数据拆分成多个区块时，Ingress 控制器会向客户机返回 413（请求实体太大）HTTP 响应。除非减小请求主体的大小，否则无法在客户机和 Ingress 控制器之间建立连接。当客户机允许数据拆分为多个区块时，数据将分成 1 兆字节的包并发送到 Ingress 控制器。
</br></br>
您可能希望增大最大主体大小，因为您预期客户机请求的主体大小大于 1 兆字节。例如，您希望客户机能够上传大型文件。增大最大请求主体大小可能会影响 Ingress 控制器的性能，因为与客户机的连接必须保持打开状态，直到接收完请求为止。
</br></br>
<strong>注</strong>：某些客户机 Web 浏览器无法正确显示 413 HTTP 响应消息。</dd>
<dt>样本 Ingress 资源 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul><li><code><em>&lt;size&gt;</em></code>：输入客户机响应主体的最大大小。例如，要将其设置为 200 兆字节，请定义 <strong>200m</strong>。

  </br></br>
  <strong>注</strong>：可以将大小设置为 0 以禁止检查客户机请求主体大小。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>
  

##### **更改 HTTP 和 HTTPS 网络流量的缺省端口**
{: #custom_http_https_ports}

使用此注释来更改 HTTP（端口 80）和 HTTPS（端口 443）网络流量的缺省端口。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>缺省情况下，Ingress 控制器配置为在端口 80 上侦听入局 HTTP 网络流量，在端口 443 上侦听入局 HTTPS 网络流量。您可以更改缺省端口以增加 Ingress 控制器域的安全性，或仅启用 HTTPS 端口。</dd>


<dt>样本 Ingress 资源 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/custom-port: "protocol=&lt;protocol1&gt; port=&lt;port1&gt;;protocol=&lt;protocol2&gt;port=&lt;port2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul><li><code><em>&lt;protocol&gt;</em></code>：输入 <strong>http</strong> 或 <strong>https</strong> 以更改入局 HTTP 或 HTTPS 网络流量的缺省端口。</li>
  <li><code><em>&lt;port&gt;</em></code>：输入要用于入局 HTTP 或 HTTPS 网络流量的端口号。</li></ul>
  <p><strong>注：</strong>当为 HTTP 或 HTTPS 指定定制端口时，缺省端口对于 HTTP 和 HTTPS 都不再有效。例如，要将 HTTPS 的缺省端口更改为 8443，而对 HTTP 使用缺省端口，那么必须为两者设置定制端口：<code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>。</p>
  </td>
  </tr>
  </tbody></table>

  </dd>
  <dt>用法</dt>
  <dd><ol><li>查看 Ingress 控制器的打开端口。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 输出类似于以下内容：
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>打开 Ingress 控制器配置映射。
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>将非缺省 HTTP 和 HTTPS 端口添加到配置映射。将 &lt;port&gt; 替换为要打开的 HTTP 或 HTTPS 端口。
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
data:
  public-ports: &lt;port1&gt;;&lt;port2&gt;
metadata:
  creationTimestamp: 2017-08-22T19:06:51Z
  name: ibm-cloud-provider-ingress-cm
  namespace: kube-system
  resourceVersion: "1320"
  selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
  uid: &lt;uid&gt;</code></pre></li>
  <li>验证是否使用非缺省端口重新配置了您的 Ingress 控制器。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 输出类似于以下内容：
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>配置 Ingress 以在将入局网络流量路由到服务时使用非缺省端口。在此引用中使用样本 YAML 文件。</li>
<li>更新 Ingress 控制器配置。
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>打开首选 Web 浏览器以访问您的应用程序。示例：<code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>








<br />


## 管理 IP 地址和子网
{: #cs_cluster_ip_subnet}

您可以使用可移植公共和专用子网和 IP 地址公开集群中的应用程序，使其可通过因特网或专用网络进行访问。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以通过将网络子网添加到集群来为 Kubernetes 服务添加稳定的可移植 IP。创建标准集群时，{{site.data.keyword.containershort_notm}} 会自动供应可移植公共子网、5 个 可移植公共 IP 地址和 5 个可移植专用 IP 地址。可移植 IP 地址是静态的，不会在除去工作程序节点甚至集群时更改。

 两个可移植 IP 地址，一个公共一个专用，用于 [Ingress 控制器](#cs_apps_public_ingress)，此控制器可用于通过一个公共路径公开集群中的多个应用程序。通过[创建 LoadBalancer 服务](#cs_apps_public_load_balancer)，可以使用 4 个可移植公共 IP 地址和 4 个专用 IP 地址来公开应用程序。 

**注**：可移植公共 IP 地址按月收费。如果在供应集群后选择除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。



1.  创建名为 `myservice.yaml` 的 Kubernetes 服务配置文件，并使用哑元负载均衡器 IP 地址定义类型为 `LoadBalancer` 的服务。以下示例使用 IP 地址 1.1.1.1 作为负载均衡器 IP 地址。



    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  在集群中创建服务。

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  检查服务。

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **注**：由于 Kubernetes 主节点在 Kubernetes 配置映射中找不到指定的负载均衡器 IP 地址，因此创建此服务失败。运行此命令时，可能会看到错误消息以及该集群的可用公共 IP 地址列表。

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### 释放已用的 IP 地址
{: #freeup_ip}

可以通过删除正在使用可移植 IP 地址的 LoadBalancer 服务，释放该已用可移植 IP 地址。

[开始之前，请为要使用的集群设置上下文。](cs_cli_install.html#cs_cli_configure)

1.  列出集群中的可用服务。

    ```
    kubectl get services
    ```
    {: pre}

2.  除去使用公共或专用 IP 地址的 LoadBalancer 服务。

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## 使用 GUI 部署应用程序
{: #cs_apps_ui}

使用 Kubernetes 仪表板将应用程序部署到集群时，会自动创建用于在集群中创建、更新和管理 pod 的部署资源。
{:shortdesc}

开始之前：

-   安装必需的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要部署应用程序，请执行以下操作：

1.  [打开 Kubernetes 仪表板](#cs_cli_dashboard)。
2.  在 Kubernetes 仪表板中，单击 **+ 创建**。
3.  选择**在下面指定应用程序详细信息**以在 GUI 上输入应用程序详细信息，或者选择**上传 YAML 或 JSON 文件**以上传应用程序[配置文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。使用[此示例 YAML 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) 通过美国南部区域的 **ibmliberty** 映像部署容器。
4.  在 Kubernetes 仪表板中，单击**部署**以验证部署是否已创建。
5.  如果使用 NodePort 服务、LoadBalancer 服务或 Ingress 使应用程序公共可用，请验证您是否可以访问该应用程序。

<br />


## 使用 CLI 部署应用程序
{: #cs_apps_cli}

创建集群后，可以使用 Kubernetes CLI 将应用程序部署到该集群。
{:shortdesc}

开始之前：

-   安装必需的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要部署应用程序，请执行以下操作：

1.  根据 [Kubernetes 最佳实践 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/overview/) 创建配置文件。通常，配置文件包含要在 Kubernetes 中创建的每个资源的配置详细信息。脚本可能包含以下一个或多个部分：

    -   [部署 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)：定义 pod 和副本集的创建。pod 包含单个容器化应用程序，而副本集用于控制多个 pod 实例。

    -   [服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/)：使用工作程序节点或负载均衡器公共 IP 地址或公共 Ingress 路径，提供对 Pod 的前端访问。

    -   [Ingress ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/ingress/)：指定一种类型的负载均衡器，以提供用于公开访问应用程序的路径。

2.  在集群上下文中运行配置文件。

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  如果使用 NodePort 服务、LoadBalancer 服务或 Ingress 使应用程序公共可用，请验证您是否可以访问该应用程序。

<br />


## 扩展应用程序
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

部署能够响应应用程序需求变化以及仅在需要时使用资源的云应用程序。自动扩展会根据 CPU 来自动增加或减少应用程序的实例数。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

**注：**是否需要有关扩展 Cloud Foundry 应用程序的信息？请查看 [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html)。

使用 Kubernetes，可以启用[水平 Pod 自动扩展 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) 以基于 CPU 扩展应用程序。

1.  通过 CLI 将应用程序部署到集群。部署应用程序时，必须请求 CPU。


    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 了解此命令的组件</th>
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

    **注：**对于更复杂的部署，有关更复杂的部署，可能需要创建[配置文件](#cs_apps_cli)。
2.  创建 Horizontal Pod Autoscaler，然后定义策略。有关使用 `kubetcl autoscale` 命令的更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale)。

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 了解此命令的组件</th>
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
{: #cs_apps_rolling}

可以通过自动和受控方式来管理如何应用您的更改。如果应用未按计划开展，那么可以将部署回滚到先前的修订版。
{:shortdesc}

开始之前，请创建[部署](#cs_apps_cli)。

1.  [应用 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) 更改。例如，您可能希望更改初始部署中使用的映像。

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


## 添加 {{site.data.keyword.Bluemix_notm}} 服务
{: #cs_apps_service}

加密的 Kubernetes 私钥用于存储 {{site.data.keyword.Bluemix_notm}} 服务详细信息和凭证，并允许该服务与集群之间进行安全通信。作为集群用户，您可以通过将此私钥作为卷安装到 pod 以访问此私钥。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。确保您要在应用程序中使用的 {{site.data.keyword.Bluemix_notm}} 服务已由集群管理员[添加到集群](cs_cluster.html#cs_cluster_service)。

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

4.  创建 YAML 文件，以配置可以通过私钥卷访问服务详细信息的 pod。

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
    <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
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


## 创建持久性存储器
{: #cs_apps_volume_claim}

创建持久性卷申领 (pvc) 以便为集群供应 NFS 文件存储器。然后，将此申领安装到 pod 可确保即便该 pod 崩溃或关闭，数据也仍然可用。
{:shortdesc}

支持持久性卷的 NFS 文件存储器由 IBM 建立集群，以便为数据提供高可用性。

1.  查看可用的存储类。{{site.data.keyword.containerlong}} 提供了八个预定义的存储类，因此集群管理员不必创建任何存储类。`ibmc-file-bronze` 存储类与 `default` 存储类相同。

    ```
    kubectl get storageclasses
    ```
    {: pre}
    
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file 
    ```
    {: screen}

2.  决定在删除 pvc 之后是否要保存数据和 NFS 文件共享。如果要保留数据，请选择 `retain` 存储类。如果要在删除 pvc 时删除数据和文件共享，请选择不带 `retain` 的存储类。

3.  查看存储类的 IOPS 和可用存储器大小。
    - 铜牌级、银牌级和金牌级存储类使用耐久性存储器，并且每个类每 GB 都具有单个已定义的 IOPS。总 IOPS 取决于存储器的大小。例如，每 GB 为 4 IOPS 的 1000Gi pvc 总共为 4000 IOPS。
 
    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    **parameters** 字段提供与存储类关联的 IOPS/GB 以及可用大小（以千兆字节为单位）。

    ```
    Parameters: iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}
    
    - 定制存储类使用[性能存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)，并且具有针对总 IOPS 和大小的离散选项。

    ```
    kubectl describe storageclasses ibmc-file-retain-custom 
    ```
    {: pre}

    **parameters** 字段提供与存储类关联的 IOPS 以及可用大小（以千兆字节为单位）。例如，40Gi pvc 可以选择 100 - 2000 IOPS 范围内的 100 的倍数的 IOPS。

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  创建配置文件以定义持久性卷申领，并将配置保存为 `.yaml` 文件。
    
    铜牌级、银牌级和金牌级类的示例：

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}
    
    定制类的示例：

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>输入持久性卷申领的名称。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>指定持久性卷的存储类：<ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze：2 IOPS/GB。</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver：4 IOPS/GB。</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold：10 IOPS/GB。</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom：多个 IOPS 值可用。

    </li> 如果未指定存储类，那么会使用铜牌级存储类来创建持久性卷。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>如果选择的大小不同于列出的大小，那么该大小会向上舍入。如果选择的大小大于最大大小，那么会对该大小向下舍入。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>此选项仅适用于 ibmc-file-custom / ibmc-file-retain-custom。指定存储器的总 IOPS。运行 `kubectl describe storageclasses ibmc-file-custom` 以查看所有选项。如果选择的 IOPS 不同于列出的 IOPS，那么该 IOPS 会向上舍入。</td>
    </tr>
    </tbody></table>

5.  创建持久性卷申领。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  验证持久性卷申领是否已创建并绑定到持久性卷。此过程可能需要几分钟时间。

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    输出类似于以下内容。

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}要将持久性卷申领安装到 pod，请创建配置文件。将配置保存为 `.yaml` 文件。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>pod 的名称。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>在容器内安装卷的目录的绝对路径。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>要安装到容器的卷的名称。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>要安装到容器的卷的名称。通常此名称与 <code>volumeMounts/name</code> 相同。</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>要用作卷的持久性卷申领的名称。将卷安装到 pod 时，Kubernetes 会识别绑定到该持久性卷申领的持久性卷，并支持用户对持久性卷执行读写操作。</td>
    </tr>
    </tbody></table>

8.  创建 pod 并将持久性卷申领安装到该 pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  验证卷是否已成功安装到 pod。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    安装点位于 **Volume Mounts** 字段中，卷位于 **Volumes** 字段中。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />


## 添加持久性存储器的非 root 用户访问权
{: #cs_apps_volumes_nonroot}

非 root 用户在支持 NFS 的存储器的卷安装路径上没有写许可权。要授予写许可权，您必须编辑映像的 Dockerfile，以在具有正确许可权的安装路径上创建目录。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

如果您使用需要对卷的写许可权的非 root 用户来设计应用程序，那么您必须将以下过程添加到 Dockerfile 和入口点脚本中：

-   创建非 root 用户。
-   临时向 root 组添加用户。
-   在具有正确用户许可权的卷安装路径中创建目录。

对于 {{site.data.keyword.containershort_notm}}，卷安装路径的缺省所有者是所有者 `nobody`。对于 NFS 存储器，如果在 pod 中本地不存在所有者，那么将创建 `nobody` 用户。卷设置为识别容器中的 root 用户；对于某些应用程序，该用户是容器中的唯一用户。但是，许多应用程序指定除了 `nobody` 之外的非 root 用户来写入容器安装路径。

1.  在本地目录中创建 Dockerfile。此示例 Dockerfile 创建名为 `myguest` 的非 root 用户。

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  在与 Dockerfile 相同的本地文件夹中，创建入口点脚本。此示例入口点脚本将 `/mnt/myvol` 指定为卷安装路径。


    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  登录到 {{site.data.keyword.registryshort_notm}}。

    ```
    bx cr login
    ```
    {: pre}

4.  在本地构建映像。记住将 _&lt;my_namespace&gt;_ 替换为专用映像注册表的名称空间。如果您需要查找名称空间，请运行 `bx cr namespace-get`。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  将映像推送到 {{site.data.keyword.registryshort_notm}} 中的名称空间。

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  通过创建配置 `.yaml` 文件来创建持久性卷申领。此示例使用的是较低性能的存储类。运行 `kubectl get storageclasses` 可查看可用的存储类。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  创建持久性卷申领。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  创建配置文件以安装卷，并从非根映像运行 pod。卷安装路径 `/mnt/myvol` 与 Dockerfile 中指定的安装路径匹配。将配置保存为 `.yaml` 文件。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  创建 pod 并将持久性卷申领安装到该 pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. 验证卷是否已成功安装到 pod。

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    安装点会列在 **Volume Mounts** 字段中，卷会列在 **Volumes** 字段中。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. 在 pod 开始运行之后，登录到该 pod。

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. 查看卷安装路径的许可权。

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    此输出显示 root 用户在卷安装路径 `mnt/myvol/` 上具有读、写和执行许可权，但非 root 用户 myguest 对 `mnt/myvol/mydata` 文件夹具有读和写许可权。由于这些更新的许可权，非 root 用户现在可以向持久性卷写入数据。


