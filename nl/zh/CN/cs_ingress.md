---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 使用 Ingress 公开应用程序
{: #ingress}

通过创建在 {{site.data.keyword.containerlong}} 中由 IBM 提供的应用程序负载均衡器管理的 Ingress 资源，公开 Kubernetes 集群中的多个应用程序。
{:shortdesc}

## 使用 Ingress 管理网络流量
{: #planning}

Ingress 是一种 Kubernetes 服务，通过将公共或专用请求转发到应用程序，均衡集群中的网络流量工作负载。可以使用 Ingress 通过唯一的公共或专用路径，向公用或专用网络公开多个应用程序服务。
{:shortdesc}

Ingress 由两个组件组成：
<dl>
<dt>应用程序负载均衡器</dt>
<dd>应用程序负载均衡器 (ALB) 是一种外部负载均衡器，用于侦听入局 HTTP、HTTPS、TCP 或 UDP 服务请求，并将这些请求转发到相应的应用程序 pod。创建标准集群时，{{site.data.keyword.containershort_notm}} 会自动为集群创建高可用性 ALB，并为其分配唯一公共路径。该公共路径链接到在集群创建期间供应到 IBM Cloud infrastructure (SoftLayer) 帐户中的可移植公共 IP 地址。另外，还会自动创建缺省专用 ALB，但不会自动启用该 ALB。</dd>
<dt>Ingress 资源</dt>
<dd>要使用 Ingress 公开应用程序，必须为应用程序创建 Kubernetes 服务，并通过定义 Ingress 资源向 ALB 注册此服务。Ingress 资源是一种 Kubernetes 资源，定义了有关如何对应用程序的入局请求进行路由的规则。Ingress 资源还指定应用程序服务的路径，该路径附加到公共路径，以构成唯一的应用程序 URL，例如 `mycluster.us-south.containers.mybluemix.net/myapp`。</dd>
</dl>

下图显示 Ingress 如何将通信从因特网定向到应用程序：

<img src="images/cs_ingress_planning.png" width="550" alt="使用 Ingress 公开 {{site.data.keyword.containershort_notm}} 中的应用程序" style="width:550px; border-style: none"/>

1. 用户通过访问应用程序的 URL 向应用程序发送请求。此 URL 是已公开应用程序的公共 URL，已附加 Ingress 资源路径，例如 `mycluster.us-south.containers.mybluemix.net/myapp`。

2. 充当全局负载均衡器的 DNS 系统服务会将该 URL 解析为集群中缺省公共 ALB 的可移植公共 IP 地址。

3. `kube-proxy` 将请求路由到应用程序的 Kubernetes ALB 服务。

4. Kubernetes 服务将请求路由到 ALB。

5. ALB 会检查集群中 `myapp` 路径的路由规则是否存在。如果找到匹配的规则，那么会根据在 Ingress 资源中定义的规则，将请求转发到部署了应用程序的 pod。如果集群中部署了多个应用程序实例，那么 ALB 会在应用程序 pod 之间对请求进行负载均衡。



**注**：Ingress 仅可用于标准集群，并要求集群中至少有两个工作程序节点以确保高可用性，同时要求定期进行更新。设置 Ingress 需要[管理员访问策略](cs_users.html#access_policies)。验证您当前的[访问策略](cs_users.html#infra_access)。

要为 Ingress 选择最佳配置，可以遵循以下决策树：

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="此图像指导您选择 Ingress 应用程序负载均衡器的最佳配置。如果此图像未显示，仍可在文档这找到这些信息。" style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="使用定制域（不带 TLS）以专用方式公开应用程序" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="使用定制域（带 TLS）以专用方式公开应用程序" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="使用 IBM 提供的域或定制域（带 TLS）以公共方式公开集群外部的应用程序" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="使用定制域（带 TLS）以公共方式公开应用程序" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="使用 IBM 提供的域（不带 TLS）以公共方式公开应用程序" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="使用 IBM 提供的域（带 TLS）以公共方式公开应用程序" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## 向公众公开应用程序
{: #ingress_expose_public}

创建标准集群时，会自动启用 IBM 提供的应用程序负载均衡器 (ALB)，并为其分配可移植公共 IP 地址和公共路径。
{:shortdesc}

通过 Ingress 向公众公开的每个应用程序都会分配有唯一路径，此路径会附加到公共路径，以便您可以使用唯一 URL 在集群中公共访问应用程序。要向公众公开应用程序，可以针对以下场景配置 Ingress。

-   [使用 IBM 提供的域（不带 TLS）以公共方式公开应用程序](#ibm_domain)
-   [使用 IBM 提供的域（带 TLS）以公共方式公开应用程序](#ibm_domain_cert)
-   [使用定制域（带 TLS）以公共方式公开应用程序](#custom_domain_cert)
-   [使用 IBM 提供的域或定制域（带 TLS）以公共方式公开集群外部的应用程序](#external_endpoint)

### 使用 IBM 提供的域（不带 TLS）以公共方式公开应用程序
{: #ibm_domain}

可以配置 ALB 对集群中应用程序的入局 HTTP 网络流量进行负载均衡，并使用 IBM 提供的域从因特网访问应用程序。
{:shortdesc}

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

要使用 IBM 提供的域来公开应用程序，请执行以下操作：

1.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

2.   针对要公开的应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myalbservice.yaml`。
      2.  针对 ALB 将向公众公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>了解 ALB 服务文件的组成部分</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 yaml 的 <code>spec.template.metadata.labels</code> 部分中使用的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  针对要向公众公开的每个应用程序，重复上述步骤。

3. 获取集群的详细信息以查看 IBM 提供的域。将 _&lt;cluster_name_or_ID&gt;_ 替换为部署了要向公众公开的应用程序的集群的名称。

    ```
    bx cs cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    输出示例：

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.8.11
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}

可以在 **Ingress subdomain** 字段中查看 IBM 提供的域。
4.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。如果每个应用程序都已通过集群内部的 Kubernetes 服务公开，必须使用一个 Ingress 资源来针对多个应用程序定义路由规则。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域将入局网络流量路由到先前创建的服务。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;ibm_domain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。

        </br></br>
        <strong>注：</strong>不要使用 * 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;service1_path&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 <code>ibm_domain/service1_path</code>。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。然后，该服务将流量转发到在运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
        </br>
        示例：<ul><li>对于 <code>http://ibm_domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://ibm_domain/service1_path</code>，请输入 <code>/service1_path</code> 作为路径。</li></ul>
        </br>
        <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;service1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
5.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

6.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用 IBM 提供的域（带 TLS）以公共方式公开应用程序
{: #ibm_domain_cert}

可以配置 Ingress ALB 来管理应用程序的入局 TLS 连接，使用 IBM 提供的 TLS 证书解密网络流量，然后将已解密的请求转发到集群中公开的应用程序。
{:shortdesc}

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

要使用 IBM 提供的域（带 TLS）来公开应用程序，请执行以下操作：

1.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

2.   针对要公开的应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myalbservice.yaml`。
      2.  针对 ALB 将向公众公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>了解 ALB 服务文件的组成部分</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 yaml 的 <code>spec.template.metadata.labels</code> 部分中使用的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  针对要向公众公开的每个应用程序，重复上述步骤。

3.   查看 IBM 提供的域和 TLS 证书。将 _&lt;cluster_name_or_ID&gt;_ 替换为部署了应用程序的集群的名称。

      ```
      bx cs cluster-get <cluster_name_or_ID>
      ```
      {: pre}

      输出示例：

      ```
      Name:                   mycluster
      ID:                     18a61a63c6a94b658596ca93d087aad9
      State:                  normal
      Created:                2018-01-12T18:33:35+0000
      Location:               dal10
      Master URL:             https://169.xx.xxx.xxx:26268
      Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
      Ingress Secret:         <ibm_tls_secret>
      Workers:                3
      Version:                1.8.11
      Owner Email:            owner@email.com
      Monitoring Dashboard:   <dashboard_URL>
      ```
      {: screen}

      可以在 **Ingress subdomain** 字段中查看 IBM 提供的域，在 **Ingress secret** 字段中查看 IBM 提供的证书。

4.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。如果每个应用程序都已通过集群内部的 Kubernetes 服务公开，必须使用一个 Ingress 资源来针对多个应用程序定义路由规则。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域将入局网络流量路由到先前创建的服务，并使用定制证书来管理 TLS 终止。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          tls:
          - hosts:
            - <ibm_domain>
            secretName: <ibm_tls_secret>
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>将 <em>&lt;ibm_domain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>将 <em>&lt;<ibm_tls_secret>&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress secret</strong> 名称。此证书用于管理 TLS 终止。</tr>
        <tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;ibm_domain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;service1_path&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。然后，该服务将流量转发到在运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br>
        示例：<ul><li>对于 <code>http://ibm_domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://ibm_domain/service1_path</code>，请输入 <code>/service1_path</code> 作为路径。</li></ul>
        <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;service1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
5.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

6.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用定制域（带 TLS）以公共方式公开应用程序
{: #custom_domain_cert}

使用定制域而不是 IBM 提供的域时，可以配置 ALB 以将入局网络流量路由到集群中的应用程序，并使用您自己的 TLS 证书来管理 TLS 终止。
{:shortdesc}

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

要使用定制域（带 TLS）来公开应用程序，请执行以下操作：

1.  创建定制域。要创建定制域，请使用域名服务 (DNS) 提供程序或 [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) 来注册定制域。
2.  配置域以将入局网络流量路由到 IBM 提供的 ALB。在以下选项之间进行选择：
    -   通过将 IBM 提供的域指定为规范名称记录 (CNAME)，定义定制域的别名。要找到 IBM 提供的 Ingress 域，请运行 `bx cs cluster-get <cluster_name>` 并查找 **Ingress subdomain** 字段。
    -   通过将 IBM 提供的 ALB 的可移植公共 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找 ALB 的可移植公共 IP 地址，请运行 `bx cs alb-get <public_alb_ID>`.
3.  导入或创建 TLS 证书和私钥：
    * 如果要使用存储在 {{site.data.keyword.cloudcerts_long_notm}} 中的 TLS 证书，那么可以通过运行以下命令，将其关联的私钥导入到集群：

      ```
          bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
          ```
      {: pre}

    * 如果还没有 TLS 证书，请执行以下步骤：
        1. 为域创建以 PEM 格式编码的 TLS 证书和密钥。
        2. 定义使用您的 TLS 证书和密钥的私钥。将 <em>&lt;tls_secret_name&gt;</em> 替换为您的 Kubernetes 私钥的名称，将 <em>&lt;tls_key_filepath&gt;</em> 替换为定制 TLS 密钥文件的路径，并将 <em>&lt;tls_cert_filepath&gt;</em> 替换为定制 TLS 证书文件的路径。

            ```
            kubectl create secret tls <tls_secret_name> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}
4.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

5.   针对要公开的应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myalbservice.yaml`。
      2.  针对 ALB 将向公众公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>了解 ALB 服务文件的组成部分</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 yaml 的 <code>spec.template.metadata.labels</code> 部分中使用的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  针对要向公众公开的每个应用程序，重复上述步骤。

6.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。如果每个应用程序都已通过集群内部的 Kubernetes 服务公开，必须使用一个 Ingress 资源来针对多个应用程序定义路由规则。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用定制域将入局网络流量路由到服务，并使用定制证书来管理 TLS 终止。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          tls:
          - hosts:
            - <custom_domain>
            secretName: <tls_secret_name>
          rules:
          - host: <custom_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>将 <em>&lt;custom_domain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>将 <em>&lt;tls_secret_name&gt;</em> 替换为先前创建的私钥的名称，此私钥用于保存定制 TLS 证书和密钥。如果已从 {{site.data.keyword.cloudcerts_short}} 导入证书，那么可以运行 <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> 来查看与 TLS 证书关联的私钥。
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;custom_domain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;service1_path&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个服务，可以定义附加到定制域的单独路径，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。然后，该服务将流量转发到在运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br></br>
        示例：<ul><li>对于 <code>https://custom_domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>https://custom_domain/service1_path</code>，请输入 <code>/service1_path</code> 作为路径。</li></ul>
        <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;service1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  保存更改。
    4.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
7.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

8.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用 IBM 提供的域或定制域（带 TLS）以公共方式公开集群外部的应用程序
{: #external_endpoint}

可以将 ALB 配置为包含位于集群外部的应用程序。IBM 提供的域或定制域上的入局请求会自动转发到外部应用程序。
{:shortdesc}

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。
-   确保要包含在集群负载均衡中的外部应用程序可以使用公共 IP 地址进行访问。

您可以将 IBM 提供的域上的入局网络流量路由到位于集群外部的应用程序。如果要改为使用定制域和 TLS 证书，请将 IBM 提供的域和 TLS 证书替换为[定制域和 TLS 证书](#custom_domain_cert)。

1.  为集群创建 Kubernetes 服务，以用于将入局请求转发到将创建的外部端点。
    1.  打开首选编辑器，并创建服务配置文件，例如名为 `myexternalservice.yaml`。
    2.  定义 ALB 服务。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>了解 ALB 服务文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>将 <em>&lt;myexternalservice&gt;</em> 替换为服务的名称。</td>
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
2.  配置 Kubernetes 端点以定义要包含在集群负载均衡中的应用程序的外部位置。
    1.  打开首选编辑器，并创建端点配置文件，例如名为 `myexternalendpoint.yaml`。
    2.  定义外部端点。包括所有可用于访问外部应用程序的公共 IP 地址和端口。


        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalendpoint
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>将 <em>&lt;myexternalendpoint&gt;</em> 替换为先前创建的 Kubernetes 服务的名称。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>将 <em>&lt;external_IP&gt;</em> 替换为用于连接到外部应用程序的公共 IP 地址。</td>
         </tr>
         <td><code>port</code></td>
         <td>将 <em>&lt;external_port&gt;</em> 替换为外部应用程序侦听的端口。</td>
         </tbody></table>

    3.  保存更改。
    4.  为集群创建 Kubernetes 端点。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}
3.   查看 IBM 提供的域和 TLS 证书。将 _&lt;cluster_name_or_ID&gt;_ 替换为部署了应用程序的集群的名称。

      ```
      bx cs cluster-get <cluster_name_or_ID>
      ```
      {: pre}

      输出示例：

      ```
      Name:                   mycluster
      ID:                     18a61a63c6a94b658596ca93d087aad9
      State:                  normal
      Created:                2018-01-12T18:33:35+0000
      Location:               dal10
      Master URL:             https://169.xx.xxx.xxx:26268
      Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
      Ingress Secret:         <ibm_tls_secret>
      Workers:                3
      Version:                1.8.11
      Owner Email:            owner@email.com
      Monitoring Dashboard:   <dashboard_URL>
      ```
      {: screen}

      可以在 **Ingress subdomain** 字段中查看 IBM 提供的域，在 **Ingress secret** 字段中查看 IBM 提供的证书。

4.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。可以使用一个 Ingress 资源来针对多个外部应用程序定义路由规则，前提是每个应用程序都已使用其外部端点通过集群内部的 Kubernetes 服务公开。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myexternalingress.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域和 TLS 证书，通过先前定义的外部端点将入局网络流量路由到外部应用程序。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myexternalingress
        spec:
          tls:
          - hosts:
            - <ibm_domain>
            secretName: <ibm_tls_secret>
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<external_service1_path>
                backend:
                  serviceName: <external_service1>
                  servicePort: 80
              - path: /<external_service2_path>
                backend:
                  serviceName: <external_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>将 <em>&lt;ibm_domain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>将 <em>&lt;ibm_tls_secret&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress secret</strong>。此证书用于管理 TLS 终止。</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>将 <em>&lt;ibm_domain&gt;</em> 替换为上一步中 IBM 提供的 <strong>Ingress subdomain</strong> 名称。此域已配置为使用 TLS 终止。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;external_service_path&gt;</em> 替换为斜杠或外部应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>
        对于每个服务，可以定义附加到 IBM 提供的域或定制域的单独路径，以创建应用程序的唯一路径，例如 <code>http://ibm_domain/external_service_path</code> 或 <code>http://custom_domain/</code>。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。该服务会将流量转发到外部应用程序。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br></br>
        <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;external_service&gt;</em> 替换为针对外部应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
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
5.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

6.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


## 向专用网络公开应用程序
{: #ingress_expose_private}

创建标准集群时，会创建 IBM 提供的应用程序负载均衡器 (ALB)，并为其分配可移植专用 IP 地址和专用路径。但是，不会自动启用缺省专用 ALB。{:shortdesc}

要向专用网络公开应用程序，请首先[启用缺省专用应用程序负载均衡器](#private_ingress)。


然后，可以针对以下场景配置 Ingress。
-   [使用定制域（不带 TLS）和外部 DNS 提供者以专用方式公开应用程序](#private_ingress_no_tls)
-   [使用定制域（带 TLS）和外部 DNS 提供者以专用方式公开应用程序](#private_ingress_tls)
-   [使用内部部署 DNS 服务以专用方式公开应用程序](#private_ingress_onprem_dns)

### 启用缺省专用应用程序负载均衡器
{: #private_ingress}

要能够使用缺省专用 ALB，必须先使用 IBM 提供的可移植专用 IP 地址或您自己的可移植专用 IP 地址来启用此 ALB。
{:shortdesc}

**注**：如果在创建集群时使用了 `--no-subnet` 标志，那么必须先添加可移植专用子网或用户管理的子网，然后才能启用专用 ALB。有关更多信息，请参阅[为集群请求更多子网](cs_subnets.html#request)。

开始之前：

-   如果还没有标准集群，请[创建标准集群](cs_clusters.html#clusters_ui)。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要使用预先分配的 IBM 提供的可移植专用 IP 地址来启用专用 ALB，请执行以下操作：

1. 列出集群中的可用 ALB，以获取专用 ALB 的标识。将 <em>&lt;cluser_name&gt;</em> 替换为部署了要公开的应用程序的集群的名称。

    ```
    bx cs albs --cluster <cluser_name>
    ```
    {: pre}

    专用 ALB 的 **Status** 字段为 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx
    ```
    {: screen}

2. 启用专用 ALB。将 <em>&lt;private_ALB_ID&gt;</em> 替换为上一步的输出中专用 ALB 的标识。

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


要使用您自己的可移植专用 IP 地址来启用专用 ALB，请执行以下操作：

1. 为所选 IP 地址配置用户管理的子网，以在集群的专用 VLAN 上路由流量。将 <em>&lt;cluser_name&gt;</em> 替换为部署了要公开的应用程序的集群的名称或标识，将 <em>&lt;subnet_CIDR&gt;</em> 替换为用户管理的子网的 CIDR，并将 <em>&lt;private_VLAN_ID&gt;</em> 替换为可用的专用 VLAN 标识。可以通过运行 `bx cs vlans` 来查找可用专用 VLAN 的标识。

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

2. 列出集群中的可用 ALB，以获取专用 ALB 的标识。

    ```
    bx cs albs --cluster <cluster_name>
    ```
    {: pre}

    专用 ALB 的 **Status** 字段为 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx
    ```
    {: screen}

3. 启用专用 ALB。将 <em>&lt;private_ALB_ID&gt;</em> 替换为上一步的输出中专用 ALB 的标识，并将 <em>&lt;user_IP&gt;</em> 替换为要使用的用户管理子网中的 IP 地址。

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

<br />


### 使用定制域（不带 TLS）和外部 DNS 提供者以专用方式公开应用程序
{: #private_ingress_no_tls}

可以配置专用 ALB 以使用定制域将入局网络流量路由到集群中的应用程序。
{:shortdesc}

开始之前：
* [启用专用应用程序负载均衡器](#private_ingress)。
* 如果您具有专用工作程序节点并且要使用外部 DNS 提供者，那么必须[配置具有公用访问权的边缘节点](cs_edge.html#edge)，然后[配置 Vyatta 网关设备 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。如果希望仅保持位于专用网络上，请改为参阅[使用内部部署 DNS 服务以专用方式公开应用程序](#private_ingress_onprem_dns)。

要使用定制域（不带 TLS）和外部 DNS 提供者以专用方式公开应用程序，请执行以下操作：

1.  创建定制域。要创建定制域，请使用域名服务 (DNS) 提供程序或 [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) 来注册定制域。
2.  通过将 IBM 提供的专用 ALB 的可移植专用 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找专用 ALB 的可移植专用 IP 地址，请运行 `bx cs albs --cluster <cluster_name>`.
3.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

4.   针对要公开的应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myalbservice.yaml`。
      2.  针对 ALB 将向专用网络公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>了解 ALB 服务文件的组成部分</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 yaml 的 <code>spec.template.metadata.labels</code> 部分中使用的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  针对要向专用网络公开的每个应用程序，重复上述步骤。

5.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。如果每个应用程序都已通过集群内部的 Kubernetes 服务公开，必须使用一个 Ingress 资源来针对多个应用程序定义路由规则。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用定制域将入局网络流量路由到服务。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          rules:
          - host: <custom_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>将 <em>&lt;private_ALB_ID&gt;</em> 替换为专用 ALB 的标识。运行 <code>bx cs albs --cluster <my_cluster></code> 以查找 ALB 标识。有关此 Ingress 注释的更多信息，请参阅[专用应用程序负载均衡器路由](cs_annotations.html#alb-id)。</td>
        </tr>
        <td><code>host</code></td>
        <td>将 <em>&lt;custom_domain&gt;</em> 替换为定制域。

        </br></br>
        <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>将 <em>&lt;service1_path&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

        </br>

                对于每个服务，可以定义附加到定制域的单独路径，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。然后，该服务将流量转发到在运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

        </br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

        </br></br>
        示例：<ul><li>对于 <code>https://custom_domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>https://custom_domain/service1_path</code>，请输入 <code>/service1_path</code> 作为路径。</li></ul>
        <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>将 <em>&lt;service1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
        </tr>
        </tbody></table>

    3.  保存更改。
    4.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
6.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

7.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用定制域（带 TLS）和外部 DNS 提供者以专用方式公开应用程序
{: #private_ingress_tls}

可以使用专用 ALB 将入局网络流量路由到集群中的应用程序。此外，使用定制域时，请使用您自己的 TLS 证书来管理 TLS 终止。
{:shortdesc}

开始之前：
* [启用专用应用程序负载均衡器](#private_ingress)。
* 如果您具有专用工作程序节点并且要使用外部 DNS 提供者，那么必须[配置具有公用访问权的边缘节点](cs_edge.html#edge)，然后[配置 Vyatta 网关设备 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。如果希望仅保持位于专用网络上，请改为参阅[使用内部部署 DNS 服务以专用方式公开应用程序](#private_ingress_onprem_dns)。

要使用定制域（带 TLS）和外部 DNS 提供者以专用方式公开应用程序，请执行以下操作：

1.  创建定制域。要创建定制域，请使用域名服务 (DNS) 提供程序或 [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) 来注册定制域。
2.  通过将 IBM 提供的专用 ALB 的可移植专用 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找专用 ALB 的可移植专用 IP 地址，请运行 `bx cs albs --cluster <cluster_name>`.
3.  导入或创建 TLS 证书和私钥：
    * 如果要使用存储在 {{site.data.keyword.cloudcerts_long_notm}} 中的 TLS 证书，那么可以通过运行 `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * 如果还没有 TLS 证书，请执行以下步骤：
        1. 为域创建以 PEM 格式编码的 TLS 证书和密钥。
        2. 定义使用您的 TLS 证书和密钥的私钥。将 <em>&lt;tls_secret_name&gt;</em> 替换为您的 Kubernetes 私钥的名称，将 <em>&lt;tls_key_filepath&gt;</em> 替换为定制 TLS 密钥文件的路径，并将 <em>&lt;tls_cert_filepath&gt;</em> 替换为定制 TLS 证书文件的路径。

            ```
            kubectl create secret tls <tls_secret_name> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}
4.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

5.   针对要公开的应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myalbservice.yaml`。
      2.  针对 ALB 将向专用网络公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>了解 ALB 服务文件的组成部分</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 yaml 的 <code>spec.template.metadata.labels</code> 部分中使用的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  针对要向专用网络公开的每个应用程序，重复上述步骤。

6.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。如果每个应用程序都已通过集群内部的 Kubernetes 服务公开，必须使用一个 Ingress 资源来针对多个应用程序定义路由规则。
    1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。
    2.  在配置文件中定义 Ingress 资源，该资源使用定制域将入局网络流量路由到服务，并使用定制证书来管理 TLS 终止。

          ```
          apiVersion: extensions/v1beta1
          kind: Ingress
          metadata:
            name: myingressresource
            annotations:
              ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
          spec:
            tls:
            - hosts:
              - <custom_domain>
              secretName: <tls_secret_name>
            rules:
            - host: <custom_domain>
              http:
                paths:
                - path: /<service1_path>
                  backend:
                    serviceName: <service1>
                    servicePort: 80
                - path: /<service2_path>
                  backend:
                    serviceName: <service2>
                    servicePort: 80
           ```
           {: pre}

           <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>ingress.bluemix.net/ALB-ID</code></td>
          <td>将 <em>&lt;private_ALB_ID&gt;</em> 替换为专用 ALB 的标识。运行 <code>bx cs albs --cluster <cluster_name></code> 以查找 ALB 标识。有关此 Ingress 注释的更多信息，请参阅[专用应用程序负载均衡器路由 (ALB-ID)](cs_annotations.html#alb-id)。</td>
          </tr>
          <tr>
          <td><code>tls/hosts</code></td>
          <td>将 <em>&lt;custom_domain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。

          </br></br>
          <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
          </tr>
          <tr>
          <td><code>tls/secretName</code></td>
          <td>将 <em>&lt;tls_secret_name&gt;</em> 替换为先前创建的私钥的名称，此私钥用于保存定制 TLS 证书和密钥。如果已从 {{site.data.keyword.cloudcerts_short}} 导入证书，那么可以运行 <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> 来查看与 TLS 证书关联的私钥。
        </tr>
          <tr>
          <td><code>host</code></td>
          <td>将 <em>&lt;custom_domain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。

          </br></br>
          <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
          </tr>
          <tr>
          <td><code>path</code></td>
          <td>将 <em>&lt;service1_path&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

          </br>
        对于每个服务，可以定义附加到定制域的单独路径，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，将网络流量发送到该服务，然后使用相同路径发送到运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。

          </br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。

          </br></br>
        示例：<ul><li>对于 <code>https://custom_domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>https://custom_domain/service1_path</code>，请输入 <code>/service1_path</code> 作为路径。</li></ul>
          <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。
        </td>
          </tr>
          <tr>
          <td><code>serviceName</code></td>
          <td>将 <em>&lt;service1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
          </tr>
          <tr>
          <td><code>servicePort</code></td>
          <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
          </tr>
           </tbody></table>

    3.  保存更改。
    4.  为集群创建 Ingress 资源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
7.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

8.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


有关如何使用专用 ALB（带 TLS）来保护跨集群的微服务对微服务通信的全面教程，请查看[此博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2)。

<br />


### 使用内部部署 DNS 服务以专用方式公开应用程序
{: #private_ingress_onprem_dns}

可以配置专用 ALB 以使用定制域将入局网络流量路由到集群中的应用程序。
当您有专用工作程序节点并且希望仅保持位于专用网络上时，可以使用专用的内部部署 DNS 来解析对应用程序的 URL 请求。
{:shortdesc}

1. [启用专用应用程序负载均衡器](#private_ingress)。
2. 要允许专用工作程序节点与 Kubernetes 主节点进行通信，请[设置 VPN 连接](cs_vpn.html)。
3. [配置 DNS 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。
4. 创建定制域并向 DNS 服务注册该定制域。
5.  通过将 IBM 提供的专用 ALB 的可移植专用 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找专用 ALB 的可移植专用 IP 地址，请运行 `bx cs albs --cluster <cluster_name>`.
6.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

7.   针对要公开的应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myalbservice.yaml`。
      2.  针对 ALB 将向专用网络公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>了解 ALB 服务文件的组成部分</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 yaml 的 <code>spec.template.metadata.labels</code> 部分中使用的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  针对要向专用网络公开的每个应用程序，重复上述步骤。

8.  创建 Ingress 资源。Ingress 资源针对您为应用程序创建的 Kubernetes 服务定义路由规则，并由 ALB 用于将入局网络流量路由到该服务。如果每个应用程序都已通过集群内部的 Kubernetes 服务公开，必须使用一个 Ingress 资源来针对多个应用程序定义路由规则。
  1.  打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。
  2.  在配置文件中定义 Ingress 资源，该资源使用定制域将入局网络流量路由到服务。

    **注**：如果您不想使用 TLS，请从以下示例中除去 `tls` 部分。

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      tls:
      - hosts:
        - <custom_domain>
        secretName: <tls_secret_name>
      rules:
      - host: <custom_domain>
        http:
          paths:
          - path: /<service1_path>
            backend:
              serviceName: <service1>
              servicePort: 80
          - path: /<service2_path>
            backend:
              serviceName: <service2>
              servicePort: 80
     ```
     {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>将 <em>&lt;private_ALB_ID&gt;</em> 替换为专用 ALB 的标识。运行 <code>bx cs albs --cluster <my_cluster></code> 以查找 ALB 标识。有关此 Ingress 注释的更多信息，请参阅[专用应用程序负载均衡器路由 (ALB-ID)](cs_annotations.html#alb-id)。</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>如果要使用 `tls` 部分，请将 <em>&lt;custom_domain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。
    </br></br>
    <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td>如果要使用 `tls` 部分，请将 <em>&lt;tls_secret_name&gt;</em> 替换为先前创建的私钥的名称，此私钥用于保存定制 TLS 证书和密钥。如果已从 {{site.data.keyword.cloudcerts_short}} 导入证书，那么可以运行 <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> 来查看与 TLS 证书关联的私钥。
        </tr>
    <tr>
    <td><code>host</code></td>
    <td>将 <em>&lt;custom_domain&gt;</em> 替换为要配置为使用 TLS 终止的定制域。
    </br></br>
    <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>将 <em>&lt;service1_path&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。</br>
        对于每个服务，可以定义附加到定制域的单独路径，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，将网络流量发送到该服务，然后使用相同路径发送到运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。</br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
        </br></br>
        示例：<ul><li>对于 <code>https://custom_domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>https://custom_domain/service1_path</code>，请输入 <code>/service1_path</code> 作为路径。</li></ul>
    <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)来建立应用程序的正确路由。
        </td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>将 <em>&lt;service1&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
    </tr>
    </tbody></table>

  3.  保存更改。
  4.  为集群创建 Ingress 资源。

      ```
      kubectl apply -f myingressresource.yaml
      ```
      {: pre}
9.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。

10.   在 Web 浏览器中，输入要访问的应用程序服务的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />





## 可选的应用程序负载均衡器配置
{: #configure_alb}

您可以使用以下选项进一步配置应用程序负载均衡器。

-   [在 Ingress 应用程序负载均衡器中打开端口](#opening_ingress_ports)
-   [在 HTTP 级别配置 SSL 协议和 SSL 密码](#ssl_protocols_ciphers)
-   [定制 Ingress 日志格式](#ingress_log_format)
-   [使用注释定制应用程序负载均衡器](cs_annotations.html)
{: #ingress_annotation}


### 在 Ingress 应用程序负载均衡器中打开端口
{: #opening_ingress_ports}

缺省情况下，Ingress ALB 中仅公开端口 80 和 443。要公开其他端口，可以编辑 `ibm-cloud-provider-ingress-cm` 配置映射资源。
{:shortdesc}

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 添加 <code>data</code> 部分，并指定公共端口 `80`、`443` 以及要公开的其他任何端口，端口之间以分号 (;) 分隔。

    **注**：指定端口时，还必须包括 80 和 443，以使这两个端口保持打开状态。未指定的任何端口都处于关闭状态。

    ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
    {: codeblock}

    示例：
    ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
    {: screen}

3. 保存配置文件。

4. 验证是否已应用配置映射更改。

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

 输出：
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;9443"
 ```
 {: screen}

有关配置映射资源的更多信息，请参阅 [Kubernetes 文档](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/)。

### 在 HTTP 级别配置 SSL 协议和 SSL 密码
{: #ssl_protocols_ciphers}

通过编辑 `ibm-cloud-provider-ingress-cm` 配置映射，在全局 HTTP 级别启用 SSL 协议和密码。
{:shortdesc}



**注**：如果指定启用的协议用于所有主机，那么仅当使用 OpenSSL 1.0.1 或更高版本时，TLSv1.1 和 TLSv1.2 参数（1.1.13 和 1.0.12）才有效。仅当使用通过 TLSv1.3 支持构建的 OpenSSL 1.1.1 时，TLSv1.3 参数 (1.13.0) 才有效。

要编辑配置映射以启用 SSL 协议和密码，请执行以下操作：

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 添加 SSL 协议和密码。根据 [OpenSSL 库密码列表格式 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html) 设置密码格式。

   ```
 apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
   {: codeblock}

3. 保存配置文件。

4. 验证是否已应用配置映射更改。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

   输出：
   ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
 ```
   {: screen}

### 定制 Ingress 日志内容和格式
{: #ingress_log_format}

可以定制为 Ingress ALB 收集的日志的内容和格式。
{:shortdesc}

缺省情况下，Ingress 日志设置为 JSON 格式并显示公共日志字段。但是，您还可以创建定制日志格式。要选择转发哪些日志组成部分以及这些组成部分在日志输出中的排列方式，请执行以下操作：

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 添加 <code>data</code> 部分。添加 `log-format` 字段以及（可选）`log-format-escape-json` 字段。

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 log-format 配置</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>将 <code>&lt;key&gt;</code> 替换为日志组成部分的名称，并将 <code>&lt;log_variable&gt;</code> 替换为希望在日志条目中收集的日志组成部分的变量。可以包含希望日志条目包含的文本和标点符号，如用于将字符串值括起的引号，以及用于分隔日志组成部分的逗号。例如，将组成部分的格式设置为诸如 <code>request: "$request",</code> 会在日志条目中生成以下内容：<code>request: "GET / HTTP/1.1",</code>。有关可以使用的所有变量的列表，请参阅 <a href="http://nginx.org/en/docs/varindex.html">Nginx 变量索引</a>。<br><br>要记录其他头（例如 <em>x-custom-ID</em>），请将以下键/值对添加到定制日志内容：<br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>请注意，连字符 (<code>-</code>) 会转换为下划线 (<code>_</code>)，并且必须在定制头名称的前面附加 <code>$http_</code>。</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>可选：缺省情况下，将生成文本格式的日志。要生成 JSON 格式的日志，请添加 <code>log-format-escape-json</code> 字段并使用值 <code>true</code>。</td>
    </tr>
    </tbody></table>
    </dd>
    </dl>

    例如，日志格式可能包含以下变量：
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    符合此格式的日志条目类似于以下内容：
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    如果要创建基于 ALB 日志缺省格式的定制日志格式，可以将以下部分添加到配置映射，并根据需要进行修改：
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. 保存配置文件。

5. 验证是否已应用配置映射更改。

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

 输出示例：
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  log-format: '{remote_address: $remote_addr, remote_user: "$remote_user", time_date: [$time_local], request: "$request", status: $status, http_referer: "$http_referer", http_user_agent: "$http_user_agent", request_id: $request_id}'
  log-format-escape-json: "true"
 ```
 {: screen}

4. 要查看 Ingress ALB 日志，请在集群中[为 Ingress 服务创建日志记录配置](cs_health.html#logging)。

<br />




