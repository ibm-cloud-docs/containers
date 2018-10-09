---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

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

## Ingress 组件和体系结构
{: #planning}

Ingress 是一种 Kubernetes 服务，通过将公共或专用请求转发到应用程序，均衡集群中的网络流量工作负载。可以使用 Ingress 通过唯一的公共或专用路径，向公共或专用网络公开多个应用程序服务。
{:shortdesc}

### Ingress 随附了哪些组件？
{: #components}

Ingress 由三个组件组成：
<dl>
<dt>Ingress 资源</dt>
<dd>要使用 Ingress 公开应用程序，必须为应用程序创建 Kubernetes 服务，并通过定义 Ingress 资源向 Ingress 注册此服务。Ingress 资源是一种 Kubernetes 资源，定义了有关如何对应用程序的入局请求进行路由的规则。Ingress 资源还指定应用程序服务的路径，该路径附加到公共路径，以构成唯一的应用程序 URL，例如 `mycluster.us-south.containers.appdomain.cloud/myapp1`。<br></br>**注**：从 2018 年 5 月 24 日开始，更改了新集群的 Ingress 子域格式。新的子域格式中包含的区域或专区名称是根据在其中创建集群的专区生成的。如果您具有对一致应用程序域名的管道依赖项，那么可以使用自己的定制域，而不使用 IBM 提供的 Ingress 子域。<ul><li>对于 2018 年 5 月 24 日之后创建的所有集群，将为其分配新格式的子域：<code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code>。</li><li>2018 年 5 月 24 日之前创建的单专区集群将继续使用旧格式的已分配子域：<code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code>。</li><li>如果您第一次通过[向集群添加专区](cs_clusters.html#add_zone)来更改在 2018 年 5 月 24 日之前创建的单专区集群，那么集群将继续使用旧格式的已分配子域 <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code>，同时会为其分配使用新格式的子域 <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code>。可以使用其中任一种子域。</li></ul></br>**多专区集群**：Ingress 资源是全局资源，对于多专区集群，每个名称空间只需要一个 Ingress 资源。</dd>
<dt>应用程序负载均衡器 (ALB)</dt>
<dd>应用程序负载均衡器 (ALB) 是一种外部负载均衡器，用于侦听入局 HTTP、HTTPS、TCP 或 UDP 服务请求。然后，ALB 会根据 Ingress 资源中定义的规则将请求转发到相应的应用程序 pod。创建标准集群时，{{site.data.keyword.containerlong_notm}} 会自动为集群创建高可用性 ALB，并为其分配唯一公共路径。该公共路径链接到在集群创建期间供应到 IBM Cloud Infrastructure (SoftLayer) 帐户中的可移植公共 IP 地址。另外，还会自动创建缺省专用 ALB，但不会自动启用该 ALB。<br></br>**多专区集群**：向集群添加专区时，会添加一个可移植公用子网，并在该专区的子网上自动创建并启用新的公共 ALB。集群中的所有缺省公共 ALB 都共享一个公共路径，但具有不同的 IP 地址。另外，还会在每个专区中自动创建缺省专用 ALB，但不会自动将其启用。</dd>
<dt>多专区负载均衡器 (MZLB)</dt>
<dd><p>**多专区集群**：在创建多专区集群或者[向单专区集群添加专区](cs_clusters.html#add_zone)时，将自动创建并部署 Cloudflare 多专区负载均衡器 (MZLB)，从而对于每个区域存在 1 个 MZLB。MZLB 将 ALB 的 IP 地方放在同一主机名后，并且在这些 IP 地址上启用运行状况检查以确定它们是否可用。例如，如果工作程序节点位于美国东部区域的 3 个专区中，那么主机名 `yourcluster.us-east.containers.appdomain.cloud` 具有 3 个 ALB IP 地址。MZLB 运行状况检查会检查区域的每个专区中的公共 ALB IP，并根据这些运行状况检查使 DNS 查找结果保持更新。例如，如果 ALB 具有 IP 地址 `1.1.1.1`、`2.2.2.2` 和 `3.3.3.3`，那么 Ingress 子域的正常操作 DNS 查找将返回所有 3 个 IP，客户机可以随机访问其中 1 个 IP 地址。如果 IP 地址为 `3.3.3.3` 的 ALB 由于任何原因变为不可用，例如，由于专区故障，那么此专区的运行状况检查失败，MZLB 从主机名中除去发生故障的 IP，并且 DNS 查找仅返回正常运行的 `1.1.1.1` 和 `2.2.2.2` ALB IP。子域具有 30 秒生存时间 (TTL)，因此在 30 秒后，新客户机应用程序只能访问一个可用且正常运行的 ALB IP。</p><p>在极少数情况下，30 秒 TTL 后，某些 DNS 解析器或客户机应用程序可能会继续使用不正常的 ALB IP。在客户机应用程序放弃 `3.3.3.3` IP 并尝试连接到 `1.1.1.1` 或 `2.2.2.2` 之前，这些客户机应用程序可能会遇到较长的装入时间。根据客户机浏览器或客户机应用程序设置，延迟范围从数秒到完整 TCP 超时不等。</p>
<p>MZLB 仅对使用 IBM 提供的 Ingress 子域的公共 ALB 进行负载均衡。如果仅使用了专用 ALB，那么必须手动检查 ALB 的运行状况，并更新 DNS 查找结果。如果使用的是采用定制域的公共 ALB，那么可以通过在 DNS 条目中创建 CNAME 以在 MZLB 负载均衡中包含这些 ALB，从而将请求从定制域转发到集群的 IBM 提供的 Ingress 子域。</p>
<p><strong>注</strong>：如果使用 Calico DNAT 前网络策略来阻止所有入局流量流至 Ingress 服务，那么还必须将用于检查 ALB 运行状况的 <a href="https://www.cloudflare.com/ips/">Cloudflare 的 IPv4 IP <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a> 列入白名单。有关如何创建 Calico DNAT 前策略以将这些 IP 列入白名单的步骤，请参阅 <a href="cs_tutorials_policies.html#lesson3">Calico 网络策略教程</a>中的第 3 课。</dd>
</dl>

### 请求如何通过 Ingress 到达单专区集群中的应用程序？
{: #architecture-single}

下图显示 Ingress 如何将通信从因特网定向到单专区集群中的应用程序：

<img src="images/cs_ingress_singlezone.png" alt="使用 Ingress 公开单专区集群中的应用程序" style="border-style: none"/>

1. 用户通过访问应用程序的 URL 向应用程序发送请求。此 URL 是已公开应用程序的公共 URL，并附加有 Ingress 资源路径，例如 `mycluster.us-south.containers.appdomain.cloud/myapp`。

2. DNS 系统服务将 URL 中的主机名解析为用于公开集群中 ALB 的负载均衡器的可移植公共 IP 地址。

3. 根据解析的 IP 地址，客户机将请求发送到用于公开 ALB 的 LoadBalancer 服务。

4. LoadBalancer 服务将请求路由到 ALB。

5. ALB 会检查集群中 `myapp` 路径的路由规则是否存在。如果找到匹配的规则，那么会根据在 Ingress 资源中定义的规则，将请求转发到部署了应用程序的 pod。包的源 IP 地址将更改为运行应用程序 pod 的工作程序节点的公共 IP 地址。如果集群中部署了多个应用程序实例，那么 ALB 会在应用程序 pod 之间对请求进行负载均衡。

### 请求如何通过 Ingress 到达多专区集群中的应用程序？
{: #architecture-multi}

下图显示 Ingress 如何将通信从因特网定向到多专区集群中的应用程序：

<img src="images/cs_ingress_multizone.png" alt="使用 Ingress 公开多专区集群中的应用程序" style="border-style: none"/>

1. 用户通过访问应用程序的 URL 向应用程序发送请求。此 URL 是已公开应用程序的公共 URL，并附加有 Ingress 资源路径，例如 `mycluster.us-south.containers.appdomain.cloud/myapp`。

2. 充当全局负载均衡器的 DNS 系统服务将 URL 中的主机名解析为 MZLB 报告为运行状况正常的可用 IP 地址。MZLB 会持续检查用于公开集群的每个专区中公共 ALB 的 LoadBalancer 服务的可移植公共 IP 地址。IP 地址在循环周期中进行解析，确保请求在不同专区中运行状况正常的 ALB 之间进行均匀负载均衡。

3. 客户机向用于公开 ALB 的 LoadBalancer 服务的 IP 地址发送请求。

4. LoadBalancer 服务将请求路由到 ALB。

5. ALB 会检查集群中 `myapp` 路径的路由规则是否存在。如果找到匹配的规则，那么会根据在 Ingress 资源中定义的规则，将请求转发到部署了应用程序的 pod。包的源 IP 地址将更改为运行应用程序 pod 的工作程序节点的公共 IP 地址。如果集群中部署了多个应用程序实例，那么 ALB 会在跨所有专区的应用程序 pod 之间对请求进行负载均衡。

<br />


## 先决条件
{: #config_prereqs}

开始使用 Ingress 之前，请查看以下先决条件。
{:shortdesc}

**所有 Ingress 配置的先决条件：**
- Ingress 仅可用于标准集群，并要求至少每个专区有两个工作程序节点以确保高可用性，同时要求定期进行更新。
- 设置 Ingress 需要[管理员访问策略](cs_users.html#access_policies)。验证您当前的[访问策略](cs_users.html#infra_access)。

**在多专区集群中使用 Ingress 的先决条件**：
 - 如果将网络流量限制为[边缘工作程序节点](cs_edge.html)，那么每个专区必须至少启用 2 个边缘工作程序节点，才可实现 Ingress pod 的高可用性。[创建边缘节点工作程序池](cs_clusters.html#add_pool)，此池跨集群中的所有专区，并且每个专区至少有 2 个工作程序节点。
 - 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。
 - 如果某个专区发生故障，那么您可能会看到对该专区中 Ingress ALB 的请求中出现间歇性故障。

<br />


## 规划单个或多个名称空间的联网
{: #multiple_namespaces}

在有要公开的应用程序的每个名称空间中，至少需要一个 Ingress 资源。
{:shortdesc}

### 所有应用程序位于一个名称空间中
{: #one-ns}

如果集群中的应用程序全部位于同一名称空间中，那么至少需要一个 Ingress 资源，以定义在其中公开的应用程序的路由规则。例如，如果您有由服务在开发名称空间中公开的 `app1` 和 `app2`，那么可以在该名称空间中创建 Ingress 资源。该资源将 `domain.net` 指定为主机，并向 `domain.net` 注册每个应用程序侦听的路径。


<img src="images/cs_ingress_single_ns.png" width="300" alt="每个名称空间至少需要一个资源。" style="width:300px; border-style: none"/>
### 应用程序位于多个名称空间中
{: #multi-ns}

如果集群中的应用程序位于不同的名称空间中，那么必须为每个名称空间至少创建一个资源，以定义在其中公开的应用程序的规则。要向集群的 Ingress ALB 注册多个 Ingress 资源，必须使用通配符域。如果已注册通配符域（例如 `*.domain.net`），那么多个子域将全部解析为同一主机。然后，可以在每个名称空间中创建 Ingress 资源，并在每个 Ingress 资源中指定不同的子域。


例如，假设有以下场景：
* 您有同一应用程序的两个版本 `app1` 和 `app3` 用于测试。
* 您将应用程序部署在同一集群的两个不同名称空间中：`app1` 部署在开发名称空间中，`app3` 部署在编译打包名称空间中。

要使用同一集群 ALB 来管理这两个应用程序的流量，请创建以下服务和资源：
* 在开发名称空间中创建 Kubernetes 服务，用于公开 `app1`。
* 在将主机指定为 `dev.domain.net` 的开发名称空间中创建 Ingress 资源。
* 在编译打包名称空间中创建 Kubernetes 服务，用于公开 `app3`。
* 在将主机指定为 `stage.domain.net` 的编译打包名称空间中创建 Ingress 资源。
</br>
<img src="images/cs_ingress_multi_ns.png" width="500" alt="在名称空间内，使用一个或多个资源中的子域。" style="width:500px; border-style: none"/>


现在，这两个 URL 会解析为同一个域，因此都由同一 ALB 进行维护。但是，由于编译打包名称空间中的资源已向 `stage` 子域注册，因此 Ingress ALB 会将来自 `stage.domain.net/app3` URL 的请求正确路由到仅 `app3`。

{: #wildcard_tls}
**注**：
* 缺省情况下，已为集群注册 IBM 提供的 Ingress 子域通配符 `*.<cluster_name>.<region>.containers.appdomain.cloud`。IBM 提供的 TLS 证书是通配符证书，可用于通配符子域。
* 如果要使用定制域，您必须将定制域注册为通配符域，例如 `*.custom_domain.net`。要使用 TLS，必须获取通配符证书。

### 一个名称空间内多个域
{: #multi-domains}

在单个名称空间中，可以使用一个域来访问该名称空间中的所有应用程序。如果要对单个名称空间中的应用程序使用不同的域，请使用通配符域。如果已注册通配符域（例如 `*.mycluster.us-sous.containers.appdomain.cloud`），那么多个子域将全部解析为同一主机。然后，可以使用一个资源来指定该资源内的多个子域主机。或者，可以在该名称空间中创建多个 Ingress 资源，并在每个 Ingress 资源中指定不同的子域。


<img src="images/cs_ingress_single_ns_multi_subs.png" alt="每个名称空间至少需要一个资源。" style="border-style: none"/>

**注**：
* 缺省情况下，已为集群注册 IBM 提供的 Ingress 子域通配符 `*.<cluster_name>.<region>.containers.appdomain.cloud`。IBM 提供的 Ingress TLS 证书是通配符证书，可用于通配符子域。
* 如果要使用定制域，您必须将定制域注册为通配符域，例如 `*.custom_domain.net`。要使用 TLS，必须获取通配符证书。

<br />


## 向公众公开集群内部应用程序
{: #ingress_expose_public}

使用公共 Ingress ALB 可向公众公开集群内部应用程序。
{:shortdesc}

开始之前：

* 查看 Ingress [先决条件](#config_prereqs)。
* [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

### 步骤 1：部署应用程序并创建应用程序服务
{: #public_inside_1}

首先部署应用程序，并创建 Kubernetes 服务来公开这些应用程序。
{: shortdesc}

1.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

2.   针对要公开的每个应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myappservice.yaml`。
      2.  针对 ALB 将公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 ALB 服务 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。如果应用程序部署在集群中的多个名称空间中，请确保该服务部署到要公开的应用程序所在的名称空间中。

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  针对要公开的每一个应用程序，重复上述步骤。


### 步骤 2：选择应用程序域和 TLS 终止
{: #public_inside_2}

配置公共 ALB 时，可以选择可用于访问应用程序的域，并选择是否使用 TLS 终止。
{: shortdesc}

<dl>
<dt>域</dt>
<dd>可以使用 IBM 提供的域（例如 <code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code>）通过因特网访问应用程序。要改为使用定制域，可以设置 CNAME 记录，以将定制域映射到 IBM 提供的域，或者通过使用 ALB 公共 IP 地址的 DNS 提供程序设置 A 记录。</dd>
<dt>TLS 终止</dt>
<dd>ALB 会对流至集群中应用程序的 HTTP 网络流量进行负载均衡。要同时对入局 HTTPS 连接进行负载均衡，可以配置 ALB 来解密网络流量，然后将已解密的请求转发到集群中公开的应用程序。<ul><li>如果使用的是 IBM 提供的 Ingress 子域，那么可以使用 IBM 提供的 TLS 证书。IBM 提供的 TLS 证书由 LetsEncrypt 签署，并由 IBM 全面管理。证书将每 90 天到期一次，并在到期前 7 天会自动更新。</li><li>如果您使用定制域，那么可以使用自己的 TLS 证书来管理 TLS 终止。如果仅在一个名称空间中具有应用程序，那么可以在同一名称空间中导入或创建证书的 TLS 私钥。如果在多个名称空间中具有应用程序，请在 <code>default</code> 名称空间中导入或创建证书的 TLS 私钥，以便 ALB 可以在每个名称空间中访问和使用该证书。<strong>注</strong>：不支持包含预先共享密钥 (TLS-PSK) 的 TLS 证书。</li></ul></dd>
</dl>

#### 要使用 IBM 提供的 Ingress 域，请执行以下操作：
获取 IBM 提供的域，并且如果想要使用 TLS，那么获取 IBM 为集群提供的 TLS 私钥。将 _&lt;cluster_name_or_ID&gt;_ 替换为部署了应用程序的集群的名称。**注**：有关通配符 TLS 证书的信息，请参阅[此注释](#wildcard_tls)。
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep Ingress
```
{: pre}

输出示例：

```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}


#### 要使用定制域，请执行以下操作：
1.    创建定制域。要注册定制域，请使用您的域名服务 (DNS) 提供者或 [{{site.data.keyword.Bluemix_notm}} DNS](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns)。
      * 如果希望 Ingress 公开的应用程序位于一个集群的不同名称空间中，请将定制域注册为通配符域，例如 `*.custom_domain.net`。

2.  配置域以将入局网络流量路由到 IBM 提供的 ALB。在以下选项之间进行选择：
    -   通过将 IBM 提供的域指定为规范名称记录 (CNAME)，定义定制域的别名。要查找 IBM 提供的 Ingress 域，请运行 `ibmcloud ks cluster-get <cluster_name>` 并查找 **Ingress subdomain** 字段。使用 CNAME 为首选，因为 IBM 在 IBM 子域上提供自动运行状况检查并从 DNS 响应除去任何失败的 IP。
    -   通过将 IBM 提供的 ALB 的可移植公共 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找 ALB 的可移植公共 IP 地址，请运行 `ibmcloud ks alb-get <public_alb_ID>`.
3.   可选：要使用 TLS，请导入或创建 TLS 证书和私钥。如果使用通配符域，请确保在 <code>default</code> 名称空间中导入或创建通配符证书，以便 ALB 可以在每个名称空间中访问并使用该证书。<strong>注</strong>：不支持包含预先共享密钥 (TLS-PSK) 的 TLS 证书。
      * 如果要使用存储在 {{site.data.keyword.cloudcerts_long_notm}} 中的 TLS 证书，那么可以通过运行以下命令，将其关联的私钥导入到集群：
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * 如果还没有 TLS 证书，请执行以下步骤：
        1. 为域创建以 PEM 格式编码的 TLS 证书和密钥。
        2. 定义使用您的 TLS 证书和密钥的私钥。将 <em>&lt;tls_secret_name&gt;</em> 替换为您的 Kubernetes 私钥的名称，将 <em>&lt;tls_key_filepath&gt;</em> 替换为定制 TLS 密钥文件的路径，并将 <em>&lt;tls_cert_filepath&gt;</em> 替换为定制 TLS 证书文件的路径。
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### 步骤 3：创建 Ingress 资源
{: #public_inside_3}

Ingress 资源定义 ALB 用于将流量路由到应用程序服务的路由规则。
{: shortdesc}

**注：**如果集群的多个名称空间中公开了应用程序，那么每个名称空间至少需要一个 Ingress 资源。但是，每个名称空间都必须使用不同的主机。必须注册通配符域并在每个资源中指定一个不同的子域。有关更多信息，请参阅[规划单个或多个名称空间的联网](#multiple_namespaces)。

1. 打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。

2. 在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域或定制域将入局网络流量路由到先前创建的服务。

    不使用 TLS 的示例 YAML：
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    使用 TLS 的示例 YAML：
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
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
    <td>要使用 TLS，请将 <em>&lt;domain&gt;</em> 替换为 IBM 提供的 Ingress 子域或定制域。

    </br></br>
    <strong>注：</strong><ul><li>如果应用程序由服务在一个集群的不同名称空间中公开，请将通配符子域附加到该域的开头，例如 `subdomain1.custom_domain.net` 或 `subdomain1.mycluster.us-south.containers.appdomain.cloud`。请对在集群中创建的每个资源使用唯一子域。</li><li>不要使用 &ast; 表示主机，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>如果使用 IBM 提供的 Ingress 域，请将 <em>&lt;tls_secret_name&gt;</em> 替换为 IBM 提供的 Ingress 私钥的名称。</li><li>如果使用定制域，请将 <em>&lt;tls_secret_name&gt;</em> 替换为您先前创建用于保存定制 TLS 证书和密钥的私钥。如果已从 {{site.data.keyword.cloudcerts_short}} 导入证书，那么可以运行 <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> 来查看与 TLS 证书关联的私钥。</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>将 <em>&lt;domain&gt;</em> 替换为 IBM 提供的 Ingress 子域或定制域。

    </br></br>
    <strong>注：</strong><ul><li>如果应用程序由服务在一个集群的不同名称空间中公开，请将通配符子域附加到该域的开头，例如 `subdomain1.custom_domain.net` 或 `subdomain1.mycluster.us-south.containers.appdomain.cloud`。请对在集群中创建的每个资源使用唯一子域。</li><li>不要使用 &ast; 表示主机，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>将 <em>&lt;app_path&gt;</em> 替换为斜杠或应用程序正在侦听的路径。该路径将附加到 IBM 提供的域或定制域，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。然后，该服务将流量转发到在运行应用程序的 pod。</br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
                示例：<ul><li>对于 <code>http://domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://domain/app1_path</code>，请输入 <code>/app1_path</code> 作为路径。</li></ul>
    </br>
    <strong>提示：</strong>要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>将 <em>&lt;app1_service&gt;</em> 和 <em>&lt;app2_service&gt;</em> 等替换为已创建用于公开应用程序的服务的名称。如果应用程序由服务在一个集群的不同名称空间中公开，请仅包含位于同一名称空间中的应用程序服务。必须为要在其中公开应用程序的每个名称空间创建一个 Ingress 资源。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
    </tr>
    </tbody></table>

3.  为集群创建 Ingress 资源。确保资源部署到在资源中指定的应用程序服务所在的名称空间中。

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。


Ingress 资源已在应用程序服务所在的名称空间中创建。此名称空间中的应用程序已向集群的 Ingress ALB 注册。

### 步骤 4：通过因特网访问应用程序
{: #public_inside_4}

在 Web 浏览器中，输入要访问的应用程序服务的 URL。

```
https://<domain>/<app1_path>
```
{: pre}

如果公开了多个应用程序，请通过更改附加到该 URL 的路径来访问这些应用程序。

```
https://<domain>/<app2_path>
```
{: pre}

如果使用通配符域在不同名称空间中公开应用程序，请使用其各自的子域来访问这些应用程序。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


通过 Ingress 连接到应用程序时遇到问题？请尝试[调试 Ingress](cs_troubleshoot_debug_ingress.html)。
{: tip}

<br />


## 向公众公开集群外部应用程序
{: #external_endpoint}

通过在公共 Ingress ALB 负载均衡中包含集群外部应用程序，可向公众公开这些应用程序。IBM 提供的域或定制域上的入局公共请求会自动转发到外部应用程序。
{:shortdesc}

开始之前：

* 查看 Ingress [先决条件](#config_prereqs)。
* 确保要包含在集群负载均衡中的外部应用程序可以使用公共 IP 地址进行访问。
* [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。

### 步骤 1：创建应用程序服务和外部端点
{: #public_outside_1}

首先创建 Kubernetes 服务以公开外部应用程序，然后配置应用程序的 Kubernetes 外部端点。
{: shortdesc}

1.  为集群创建 Kubernetes 服务，以用于将入局请求转发到将创建的外部端点。
    1.  打开首选编辑器，并创建服务配置文件，例如名为 `myexternalservice.yaml`。
    2.  针对 ALB 将公开的应用程序定义服务。

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
        <td>将 <em>&lt;myexternalservice&gt;</em> 替换为服务的名称。<p>使用 Kubernetes 资源时，请了解有关[确保个人信息安全](cs_secure.html#pi)的更多信息。</p></td>
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

### 步骤 2：选择应用程序域和 TLS 终止
{: #public_outside_2}

配置公共 ALB 时，可以选择可用于访问应用程序的域，并选择是否使用 TLS 终止。
{: shortdesc}

<dl>
<dt>域</dt>
<dd>可以使用 IBM 提供的域（例如 <code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code>）通过因特网访问应用程序。要改为使用定制域，可以设置 CNAME 记录，以将定制域映射到 IBM 提供的域，或者通过使用 ALB 公共 IP 地址的 DNS 提供程序设置 A 记录。</dd>
<dt>TLS 终止</dt>
<dd>ALB 会对流至应用程序的 HTTP 网络流量进行负载均衡。要同时对入局 HTTPS 连接进行负载均衡，可以配置 ALB 来解密网络流量，然后将已解密的请求转发到集群中公开的应用程序。<ul><li>如果使用的是 IBM 提供的 Ingress 子域，那么可以使用 IBM 提供的 TLS 证书。IBM 提供的 TLS 证书由 LetsEncrypt 签署，并由 IBM 全面管理。证书将每 90 天到期一次，并在到期前 7 天会自动更新。</li><li>如果您使用定制域，那么可以使用自己的 TLS 证书来管理 TLS 终止。在集群的 <code>default</code> 名称空间中为证书导入或创建 TLS 私钥。<strong>注</strong>：不支持包含预先共享密钥 (TLS-PSK) 的 TLS 证书。</li></ul></dd>
</dl>

#### 要使用 IBM 提供的 Ingress 域，请执行以下操作：
获取 IBM 提供的域，并且如果想要使用 TLS，那么获取 IBM 为集群提供的 TLS 私钥。将 _&lt;cluster_name_or_ID&gt;_ 替换为部署了应用程序的集群的名称。**注**：有关通配符 TLS 证书的信息，请参阅[此注释](#wildcard_tls)。
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep Ingress
```
{: pre}

输出示例：

```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}


#### 要使用定制域，请执行以下操作：
1.    创建定制域。要注册定制域，请使用您的域名服务 (DNS) 提供者或 [{{site.data.keyword.Bluemix_notm}} DNS](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns)。
      * 如果希望 Ingress 公开的应用程序位于一个集群的不同名称空间中，请将定制域注册为通配符域，例如 `*.custom_domain.net`。

2.  配置域以将入局网络流量路由到 IBM 提供的 ALB。在以下选项之间进行选择：
    -   通过将 IBM 提供的域指定为规范名称记录 (CNAME)，定义定制域的别名。要查找 IBM 提供的 Ingress 域，请运行 `ibmcloud ks cluster-get <cluster_name>` 并查找 **Ingress subdomain** 字段。使用 CNAME 为首选，因为 IBM 在 IBM 子域上提供自动运行状况检查并从 DNS 响应除去任何失败的 IP。
    -   通过将 IBM 提供的 ALB 的可移植公共 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找 ALB 的可移植公共 IP 地址，请运行 `ibmcloud ks alb-get <public_alb_ID>`.
3.   可选：要使用 TLS，请导入或创建 TLS 证书和私钥。如果使用通配符域，请确保在 <code>default</code> 名称空间中导入或创建通配符证书，以便 ALB 可以在每个名称空间中访问并使用该证书。<strong>注</strong>：不支持包含预先共享密钥 (TLS-PSK) 的 TLS 证书。
      * 如果要使用存储在 {{site.data.keyword.cloudcerts_long_notm}} 中的 TLS 证书，那么可以通过运行以下命令，将其关联的私钥导入到集群：
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * 如果还没有 TLS 证书，请执行以下步骤：
        1. 为域创建以 PEM 格式编码的 TLS 证书和密钥。
        2. 定义使用您的 TLS 证书和密钥的私钥。将 <em>&lt;tls_secret_name&gt;</em> 替换为您的 Kubernetes 私钥的名称，将 <em>&lt;tls_key_filepath&gt;</em> 替换为定制 TLS 密钥文件的路径，并将 <em>&lt;tls_cert_filepath&gt;</em> 替换为定制 TLS 证书文件的路径。
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### 步骤 3：创建 Ingress 资源
{: #public_outside_3}

Ingress 资源定义 ALB 用于将流量路由到应用程序服务的路由规则。
{: shortdesc}

**注：**如果要公开多个外部应用程序，并且在[步骤 1](#public_outside_1) 中为应用程序创建的服务位于不同的名称空间中，那么每个名称空间至少需要一个 Ingress 资源。但是，每个名称空间都必须使用不同的主机。必须注册通配符域并在每个资源中指定一个不同的子域。有关更多信息，请参阅[规划单个或多个名称空间的联网](#multiple_namespaces)。

1. 打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myexternalingress.yaml`。

2. 在配置文件中定义 Ingress 资源，该资源使用 IBM 提供的域或定制域将入局网络流量路由到先前创建的服务。

    不使用 TLS 的示例 YAML：
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<external_app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<external_app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    使用 TLS 的示例 YAML：
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<external_app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<external_app2_path>
            backend:
              serviceName: <app2_service>
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
    <td>要使用 TLS，请将 <em>&lt;domain&gt;</em> 替换为 IBM 提供的 Ingress 子域或定制域。

    </br></br>
    <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>如果使用 IBM 提供的 Ingress 域，请将 <em>&lt;tls_secret_name&gt;</em> 替换为 IBM 提供的 Ingress 私钥的名称。</li><li>如果使用定制域，请将 <em>&lt;tls_secret_name&gt;</em> 替换为您先前创建用于保存定制 TLS 证书和密钥的私钥。如果已从 {{site.data.keyword.cloudcerts_short}} 导入证书，那么可以运行 <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> 来查看与 TLS 证书关联的私钥。</li><ul><td>
    </tr>
    <tr>
    <td><code>rules/host</code></td>
    <td>将 <em>&lt;domain&gt;</em> 替换为 IBM 提供的 Ingress 子域或定制域。

    </br></br>
    <strong>注</strong>：不要使用 &ast; 表示主机名，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>将 <em>&lt;external_app_path&gt;</em> 替换为斜杠或应用程序正在侦听的路径。该路径将附加到 IBM 提供的域或定制域，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。该服务会将流量转发到外部应用程序。应用程序必须设置为侦听此路径，才能接收入局网络流量。</br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
                示例：<ul><li>对于 <code>http://domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://domain/app1_path</code>，请输入 <code>/app1_path</code> 作为路径。</li></ul>
    </br></br>
    <strong>提示：</strong>要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>将 <em>&lt;app1_service&gt;</em> 和 <em>&lt;app2_service&gt;</em> 等替换为已创建用于公开外部应用程序的服务的名称。如果应用程序由服务在一个集群的不同名称空间中公开，请仅包含位于同一名称空间中的应用程序服务。必须为要在其中公开应用程序的每个名称空间创建一个 Ingress 资源。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
    </tr>
    </tbody></table>

3.  为集群创建 Ingress 资源。确保资源部署到在资源中指定的应用程序服务所在的名称空间中。

    ```
    kubectl apply -f myexternalingress.yaml -n <namespace>
    ```
    {: pre}
4.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。


Ingress 资源已在应用程序服务所在的名称空间中创建。此名称空间中的应用程序已向集群的 Ingress ALB 注册。

### 步骤 4：通过因特网访问应用程序
{: #public_outside_4}

在 Web 浏览器中，输入要访问的应用程序服务的 URL。

```
https://<domain>/<app1_path>
```
{: pre}

如果公开了多个应用程序，请通过更改附加到该 URL 的路径来访问这些应用程序。

```
https://<domain>/<app2_path>
```
{: pre}

如果使用通配符域在不同名称空间中公开应用程序，请使用其各自的子域来访问这些应用程序。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


通过 Ingress 连接到应用程序时遇到问题？请尝试[调试 Ingress](cs_troubleshoot_debug_ingress.html)。
{: tip}

<br />


## 向专用网络公开应用程序
{: #ingress_expose_private}

使用专用 Ingress ALB 可将应用程序公开到专用网络。
{:shortdesc}

开始之前：
* 查看 Ingress [先决条件](#config_prereqs)。
* 在工作程序节点连接到[公用和专用 VLAN](cs_network_planning.html#private_both_vlans) 或连接到[仅专用 VLAN](cs_network_planning.html#private_vlan) 时，查看用于规划应用程序专用访问权的选项。
    * 如果工作程序节点仅连接到专用 VLAN，那么必须配置[专用网络上可用的 DNS 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。

### 步骤 1：部署应用程序并创建应用程序服务
{: #private_1}

首先部署应用程序，并创建 Kubernetes 服务来公开这些应用程序。
{: shortdesc}

1.  [将应用程序部署到集群](cs_app.html#app_cli)。确保在配置文件的 metadata 部分中向部署添加标签，例如 `app: code`。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在 Ingress 负载均衡中。

2.   针对要公开的每个应用程序创建 Kubernetes 服务。应用程序必须由 Kubernetes 服务公开才能被集群 ALB 包含在 Ingress 负载均衡中。
      1.  打开首选编辑器，并创建服务配置文件，例如名为 `myappservice.yaml`。
      2.  针对 ALB 将公开的应用程序定义服务。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 ALB 服务 YAML 文件的组成部分</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请确保 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 与部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中的键/值对相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服务侦听的端口。</td>
           </tr>
           </tbody></table>
      3.  保存更改。
      4.  在集群中创建服务。如果应用程序部署在集群中的多个名称空间中，请确保该服务部署到要公开的应用程序所在的名称空间中。

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  针对要公开的每一个应用程序，重复上述步骤。


### 步骤 2：启用缺省专用 ALB
{: #private_ingress}

创建标准集群时，会在具有工作程序节点的每个专区中创建 IBM 提供的专用应用程序负载均衡器 (ALB)，并为其分配可移植专用 IP 地址和专用路径。但是，不会自动启用每个专区中的缺省专用 ALB。要使用缺省专用 ALB 对流至应用程序的专用网络流量进行负载均衡，必须先使用 IBM 提供的可移植专用 IP 地址或您自己的可移植专用 IP 地址来启用此 ALB。
{:shortdesc}

**注**：如果在创建集群时使用了 `--no-subnet` 标志，那么必须先添加可移植专用子网或用户管理的子网，然后才能启用专用 ALB。有关更多信息，请参阅[为集群请求更多子网](cs_subnets.html#request)。

**要使用预先分配的 IBM 提供的可移植专用 IP 地址来启用缺省专用 ALB，请执行以下操作：**

1. 获取要启用的缺省专用 ALB 的标识。将 <em>&lt;cluster_name&gt;</em> 替换为部署了要公开的应用程序的集群的名称。

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    专用 ALB 的 **Status** 字段为 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419aa3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2   false     disabled   private   -               dal12
    public-cr6d779503319d419aa3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    public-crb2f60e9735254ac8b20b9c1e38b649a5-alb2    true      enabled    public    169.xx.xxx.xxx  dal12
    ```
    {: screen}
    在多专区集群中，ALB ID 的编号后缀指示添加 ALB 的顺序。
    * 例如，ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` 的 `-alb1` 后缀指示这是创建的第一个缺省专用 ALB。它位于在其中创建集群的专区中。在以上示例中，集群是在 `dal10` 中创建的。
    * ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` 的 `-alb2` 后缀指示这是创建的第二个缺省专用 ALB。它位于添加到集群的第二个专区中。在以上示例中，第二个专区为 `dal12`。

2. 启用专用 ALB。将 <em>&lt;private_ALB_ID&gt;</em> 替换为上一步的输出中专用 ALB 的标识。

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

3. **多专区集群**：为实现高可用性，请针对每个专区中的专用 ALB 重复上述步骤。

<br>
**要使用您自己的可移植专用 IP 地址来启用专用 ALB，请执行以下操作：**

1. 为所选 IP 地址配置用户管理的子网，以在集群的专用 VLAN 上路由流量。

   ```
   ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解命令的组成部分</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;cluster_name&gt;</code></td>
   <td>要公开的应用程序部署所在集群的名称或标识。</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>用户管理的子网的 CIDR。</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>可用的专用 VLAN 标识。可以通过运行 `ibmcloud ks vlans` 来查找可用专用 VLAN 的标识。</td>
   </tr>
   </tbody></table>

2. 列出集群中的可用 ALB，以获取专用 ALB 的标识。

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    专用 ALB 的 **Status** 字段为 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    ```
    {: screen}

3. 启用专用 ALB。将 <em>&lt;private_ALB_ID&gt;</em> 替换为上一步的输出中专用 ALB 的标识，并将 <em>&lt;user_IP&gt;</em> 替换为要使用的用户管理子网中的 IP 地址。

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **多专区集群**：为实现高可用性，请针对每个专区中的专用 ALB 重复上述步骤。

### 步骤 3：映射定制域并选择 TLS 终止
{: #private_3}

配置专用 ALB 时，可以使用可用于访问应用程序的定制域，并选择是否使用 TLS 终止。
{: shortdesc}

ALB 会对流至应用程序的 HTTP 网络流量进行负载均衡。要同时对入局 HTTPS 连接进行负载均衡，可以配置 ALB，以便可以使用您自己的 TLS 证书来解密网络流量。然后，ALB 会将已解密的请求转发到集群中公开的应用程序。
1.   创建定制域。要注册定制域，请使用您的域名服务 (DNS) 提供者或 [{{site.data.keyword.Bluemix_notm}} DNS](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns)。
      * 如果希望 Ingress 公开的应用程序位于一个集群的不同名称空间中，请将定制域注册为通配符域，例如 `*.custom_domain.net`。

2. 通过将 IBM 提供的专用 ALB 的可移植专用 IP 地址添加为记录，将定制域映射到该 IP 地址。要查找专用 ALB 的可移植专用 IP 地址，请运行 `ibmcloud ks albs --cluster <cluster_name>`.
3.   可选：要使用 TLS，请导入或创建 TLS 证书和私钥。如果使用通配符域，请确保在 <code>default</code> 名称空间中导入或创建通配符证书，以便 ALB 可以在每个名称空间中访问并使用该证书。<strong>注</strong>：不支持包含预先共享密钥 (TLS-PSK) 的 TLS 证书。
      * 如果要使用存储在 {{site.data.keyword.cloudcerts_long_notm}} 中的 TLS 证书，那么可以通过运行以下命令，将其关联的私钥导入到集群：
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * 如果还没有 TLS 证书，请执行以下步骤：
        1. 为域创建以 PEM 格式编码的 TLS 证书和密钥。
        2. 定义使用您的 TLS 证书和密钥的私钥。将 <em>&lt;tls_secret_name&gt;</em> 替换为您的 Kubernetes 私钥的名称，将 <em>&lt;tls_key_filepath&gt;</em> 替换为定制 TLS 密钥文件的路径，并将 <em>&lt;tls_cert_filepath&gt;</em> 替换为定制 TLS 证书文件的路径。
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### 步骤 4：创建 Ingress 资源
{: #private_4}

Ingress 资源定义 ALB 用于将流量路由到应用程序服务的路由规则。
{: shortdesc}

**注：**如果集群的多个名称空间中公开了应用程序，那么每个名称空间至少需要一个 Ingress 资源。但是，每个名称空间都必须使用不同的主机。必须注册通配符域并在每个资源中指定一个不同的子域。有关更多信息，请参阅[规划单个或多个名称空间的联网](#multiple_namespaces)。

1. 打开首选编辑器，并创建 Ingress 配置文件，例如名为 `myingressresource.yaml`。

2.  在配置文件中定义 Ingress 资源，该资源使用定制域将入局网络流量路由到先前创建的服务。

    不使用 TLS 的示例 YAML：
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    使用 TLS 的示例 YAML：
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
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
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
    <td>将 <em>&lt;private_ALB_ID&gt;</em> 替换为专用 ALB 的标识。运行 <code>ibmcloud ks albs --cluster <my_cluster></code> 以查找 ALB 标识。有关此 Ingress 注释的更多信息，请参阅[专用应用程序负载均衡器路由](cs_annotations.html#alb-id)。</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>要使用 TLS，请将 <em>&lt;domain&gt;</em> 替换为定制域。</br></br><strong>注：</strong><ul><li>如果应用程序由服务在一个集群的不同名称空间中公开，请将通配符子域附加到该域的开头，例如 `subdomain1.custom_domain.net`。请对在集群中创建的每个资源使用唯一子域。</li><li>不要使用 &ast; 表示主机，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td>将 <em>&lt;tls_secret_name&gt;</em> 替换为先前创建的私钥的名称，此私钥用于保存定制 TLS 证书和密钥。如果已从 {{site.data.keyword.cloudcerts_short}} 导入证书，那么可以运行 <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> 来查看与 TLS 证书关联的私钥。
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>将 <em>&lt;domain&gt;</em> 替换为定制域。
    </br></br>
    <strong>注：</strong><ul><li>如果应用程序由服务在一个集群的不同名称空间中公开，请将通配符子域附加到该域的开头，例如 `subdomain1.custom_domain.net`。请对在集群中创建的每个资源使用唯一子域。</li><li>不要使用 &ast; 表示主机，也不要将主机属性保留为空，以避免创建 Ingress 期间发生失败。</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>将 <em>&lt;app_path&gt;</em> 替换为斜杠或应用程序正在侦听的路径。该路径将附加到定制域，以创建应用程序的唯一路径。在 Web 浏览器中输入此路径时，网络流量会路由到 ALB。ALB 会查找关联的服务，并将网络流量发送到该服务。然后，该服务将流量转发到在运行应用程序的 pod。</br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
                示例：<ul><li>对于 <code>http://domain/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://domain/app1_path</code>，请输入 <code>/app1_path</code> 作为路径。</li></ul>
    </br>
    <strong>提示：</strong>要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 [rewrite 注释](cs_annotations.html#rewrite-path)。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>将 <em>&lt;app1_service&gt;</em> 和 <em>&lt;app2_service&gt;</em> 等替换为已创建用于公开应用程序的服务的名称。如果应用程序由服务在一个集群的不同名称空间中公开，请仅包含位于同一名称空间中的应用程序服务。必须为要在其中公开应用程序的每个名称空间创建一个 Ingress 资源。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
    </tr>
    </tbody></table>

3.  为集群创建 Ingress 资源。确保资源部署到在资源中指定的应用程序服务所在的名称空间中。

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   验证 Ingress 资源是否已成功创建。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果 events 中的消息描述了资源配置中的错误，请更改资源文件中的值，然后将该文件重新应用于资源。


Ingress 资源已在应用程序服务所在的名称空间中创建。此名称空间中的应用程序已向集群的 Ingress ALB 注册。

### 步骤 5：通过专用网络访问应用程序
{: #private_5}

1. 在访问应用程序之前，请确保可以访问 DNS 服务。
  * 公用和专用 VLAN：要使用缺省外部 DNS 提供程序，必须[配置具有公共访问权的边缘节点](cs_edge.html#edge)以及[配置虚拟路由器设备 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。
  * 仅限专用 VLAN：必须配置[专用网络上可用的 DNS 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。

2. 在专用网络防火墙内，在 Web 浏览器中输入应用程序服务的 URL。

```
https://<domain>/<app1_path>
```
{: pre}

如果公开了多个应用程序，请通过更改附加到该 URL 的路径来访问这些应用程序。

```
https://<domain>/<app2_path>
```
{: pre}

如果使用通配符域在不同名称空间中公开应用程序，请使用其各自的子域来访问这些应用程序。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


有关如何使用专用 ALB（带 TLS）来保护跨集群的微服务对微服务通信的全面教程，请查看[此博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2)。
{: tip}

<br />


## 使用注释定制 Ingress 资源
{: #annotations}

要向 Ingress 应用程序负载均衡器 (ALB) 添加功能，可以将特定于 IBM 的注释添加为 Ingress 资源中的元数据。
{: shortdesc}

开始使用一些最常用的注释。
* [redirect-to-https](cs_annotations.html#redirect-to-https)：将不安全的 HTTP 客户机请求转换为 HTTPS。
* [rewrite-path](cs_annotations.html#rewrite-path)：将入局网络流量路由到后端应用程序侦听的其他路径。
* [ssl-services](cs_annotations.html#ssl-services)：使用 TLS 加密流至需要 HTTPS 的上游应用程序的流量。
* [client-max-body-size](cs_annotations.html#client-max-body-size)：设置客户机可以作为请求一部分发送的主体的最大大小。

有关受支持注释的完整列表，请参阅[使用注释定制 Ingress](cs_annotations.html)。

<br />


## 在 Ingress ALB 中打开端口
{: #opening_ingress_ports}

缺省情况下，Ingress ALB 中仅公开端口 80 和 443。要公开其他端口，可以编辑 `ibm-cloud-provider-ingress-cm` 配置映射资源。
{:shortdesc}

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 添加 <code>data</code> 部分，并指定公共端口 `80`、`443` 以及要公开的其他任何端口，端口之间以分号 (;) 分隔。

    **重要信息**：缺省情况下，端口 80 和 443 已打开。如果要使 80 和 443 保持打开，那么必须在 `public-ports` 字段中包含这两个端口以及您指定的其他任何端口。未指定的任何端口都处于关闭状态。如果启用了专用 ALB，那么还必须在 `private-ports` 字段中指定要保持打开的任何端口。

    ```
apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    使端口 `80`、`443` 和 `9443` 保持打开的示例：
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

有关配置映射资源的更多信息，请参阅 [Kubernetes 文档](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)。

<br />


## 保留源 IP 地址
{: #preserve_source_ip}

缺省情况下，不会保留客户机请求的源 IP 地址。对应用程序的客户机请求发送到集群时，该请求会路由到用于公开 ALB 的 LoadBalancer 服务的 pod。如果在 LoadBalancer 服务 pod 所在的工作程序节点上不存在应用程序 pod，那么负载均衡器会将该请求转发到其他工作程序节点上的应用程序 pod。软件包的源 IP 地址将更改为运行应用程序 pod 的工作程序节点的公共 IP 地址。

要保留客户机请求的原始源 IP 地址，可以[启用源 IP 保留 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)。例如，在应用程序服务器必须应用安全性和访问控制策略的情况下，保留客户机的 IP 非常有用。

**注**：如果[禁用 ALB](cs_cli_reference.html#cs_alb_configure)，那么对用于公开 ALB 的 LoadBalancer 服务进行的任何源 IP 更改都将丢失。重新启用 ALB 时，必须重新启用源 IP。

要启用源 IP 保留，请编辑用于公开 Ingress ALB 的 LoadBalancer 服务：

1. 为单个 ALB 或集群中的所有 ALB 启用源 IP 保留。
    * 为单个 ALB 设置源 IP 保留：
        1. 获取要为其启用源 IP 的 ALB 的标识。ALB 服务的格式类似于 `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`（对于公共 ALB）或 `private-cr18e61e63c6e94b658596ca93d087eed9-alb1`（对于专用 ALB）。
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. 打开用于公开 ALB 的 LoadBalancer 服务的 YAML。
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. 在 **spec** 下，将 **externalTrafficPolicy** 的值从 `Cluster` 更改为 `Local`。

        4. 保存并关闭配置文件。输出将类似于以下内容：

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * 要为集群中的所有公共 ALB 设置源 IP 保留，请运行以下命令：
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        输出示例：
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * 要为集群中的所有专用 ALB 设置源 IP 保留，请运行以下命令：
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        输出示例：
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. 在 ALB pod 日志中验证源 IP 是否得到保留。
    1. 获取修改的 ALB 的 pod 的标识。
        ```
kubectl get pods -n kube-system | grep alb
      ```
        {: pre}

    2. 打开该 ALB pod 的日志。验证 `client` 字段的 IP 地址是否为客户机请求 IP 地址，而不是 LoadBalancer 服务 IP 地址。
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. 现在，查找发送到后端应用程序的请求的标题时，可以在 `x-forwarded-for` 头中看到客户机 IP 地址。

4. 如果您不再希望保留源 IP，那么可以还原对服务进行的更改。
    * 要还原公共 ALB 的源 IP 保留，请运行以下命令：
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * 要还原专用 ALB 的源 IP 保留，请运行以下命令：
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## 在 HTTP 级别配置 SSL 协议和 SSL 密码
{: #ssl_protocols_ciphers}

通过编辑 `ibm-cloud-provider-ingress-cm` 配置映射，在全局 HTTP 级别启用 SSL 协议和密码。
{:shortdesc}

缺省情况下，TLS 1.2 协议用于使用 IBM 提供的域的所有 Ingress 配置。通过执行以下步骤，可以覆盖缺省值以改为使用 TLS 1.1 或 1.0 协议。

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

<br />


## 调整 ALB 性能
{: #perf_tuning}

要优化 Ingress ALB 的性能，可以根据需要更改缺省设置。
{: shortdesc}

### 启用日志缓冲和清空超时
{: #access-log}

缺省情况下，Ingress ALB 记录到达的每个请求。如果环境使用频繁，那么记录到达的每个请求可能会大幅提升磁盘 I/O 利用率。为避免持续的磁盘 I/O，可以通过编辑 `ibm-cloud-provider-ingress-cm` Ingress 配置映射，针对 ALB 启用日志缓冲和清空超时。在启用缓冲时，不用针对每个日志条目执行单独的写操作，ALB 会缓冲一系列条目并在单个操作中将它们一起写入到文件。

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 编辑配置映射。
    1. 通过添加 `access-log-buffering` 字段并将其设置为 `"true"`，启用日志缓冲。

    2. 设置 ALB 应将缓冲区内容写入日志的阈值。
        * 时间间隔：添加 `flush-interval` 字段并将其设置为 ALB 应写入日志的频率。例如，如果使用缺省值 `5m`，那么 ALB 每 5 分钟将缓冲区内容写入一次日志。
        * 缓冲区大小：添加 `buffer-size` 字段并将其设置为在 ALB 将缓冲区内容写入日志之前可在缓冲区中保留的日志内存量。例如，如果使用缺省值 `100KB`，那么每次缓冲区的日志内容到达 100kb 时，ALB 会将缓冲区内容写入日志。
        * 时间间隔或缓冲区大小：同时设置了 `flush-interval` 和 `buffer-size` 时，ALB 根据首个满足的其中任何一个阈值参数将缓冲区内容写入到日志。

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. 保存配置文件。

4. 验证已使用访问日志更改配置 ALB。

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### 更改保持活动连接的数量或持续时间
{: #keepalive_time}

保持活动连接通过减少打开和关闭连接所需的 CPU 和网络开销，会对性能产生重大影响。要优化 ALB 的性能，您可以更改 ALB 和客户机之间保持活动连接的最大数量以及保持活动连接可持续的时间。
{: shortdesc}

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 更改 `keep-alive-requests` 和 `keep-alive` 的值。
    * `keep-alive-requests`：可保持向 Ingress ALB 打开的保持活动客户机连接的数量。缺省值为 `4096`。
    * `keep-alive`：超时（以秒为单位），在此期间保持活动客户机连接将保持向 Ingress ALB 打开。缺省值为 `8s`。
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
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


### 更改暂挂连接待办事项
{: #backlog}

您可以针对服务器队列中可等待的暂挂连接数量降低缺省待办事项设置。
{: shortdesc}

在 `ibm-cloud-provider-ingress-cm` Ingress 配置映射中，`backlog` 字段设置可在服务器队列中等待的暂挂连接的最大数量。缺省情况下，`backlog` 设置为 `32768`。可以通过编辑 Ingress 配置映射来覆盖缺省值。

1. 为 `ibm-cloud-provider-ingress-cm` 配置映射资源创建并打开配置文件的本地版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 将 `backlog` 的值从 `32768` 更改为较小的值。该值必须等于或小于 32768。

   ```
   apiVersion: v1
   data:
     backlog: "32768"
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


### 调整内核性能
{: #kernel}

要优化 Ingress ALB 的性能，您还可以[更改工作程序节点上的 Linux 内核 `sysctl` 参数](cs_performance.html)。根据优化的内核调整自动供应工作程序节点，因此仅在具有特定性能优化需求时才更改这些设置。

<br />


## 自带 Ingress 控制器
{: #user_managed}

自带 Ingress 控制器并在利用分配给集群的 IBM 提供的 Ingress 子域和 TLS 证书时在 {{site.data.keyword.Bluemix_notm}} 上运行此控制器。
{: shortdesc}

当您有特定 Ingress 需求时，配置自己的定制 Ingress 控制器可能非常有用。如果自带 Ingress 控制器而不是使用 IBM 提供的 Ingress ALB，那么由您负责提供控制器映像，维护控制器以及更新控制器。

1. 获取缺省公共 ALB 的标识。公共 ALB 的格式类似于 `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`。
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. 禁用缺省公共 ALB。`--disable-deployment` 标志会禁用 IBM 提供的 ALB 部署，但对于 IBM 提供的 Ingress 子域或用于公开 Ingress 控制器的 LoadBalancer 服务，不会除去其 DNS 注册。
    ```
    ibmcloud ks alb-configure --albID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. 准备好 Ingress 控制器的配置文件。例如，可以将 YAML 配置文件用于 [Nginx 社区 Ingress 控制器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/ingress-nginx/blob/master/deploy/mandatory.yaml)。

4. 部署您自己的 Ingress 控制器。**重要信息**：要继续使用用于公开控制器的 LoadBalancer 服务以及 IBM 提供的 Ingress 子域，您的控制器必须部署在 `kubbe-system` 名称空间中。
    ```
    kubectl apply -f customingress.yaml -n kube-system
    ```
    {: pre}

5. 获取定制 Ingress 部署上的标签。
    ```
    kubectl get deploy nginx-ingress-controller -n kube-system --show-labels
    ```
    {: pre}

    在以下示例输出中，标签值为 `ingress-nginx`：
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

5. 使用步骤 1 中获取的 ALB ID，打开用于公开 ALB 的 LoadBalancer 服务。
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

6. 更新 LoadBalancer 服务以指向定制 Ingress 部署。在 `spec/selector` 下，从 `app` 标签中除去 ALB 标识，并添加在步骤 5 中获取的您自己 Ingress 控制器的标签。
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. 可选：缺省情况下，LoadBalancer 服务允许端口 80 和 443 上的流量。如果定制 Ingress 控制器需要一组不同的端口，请将这些端口添加到 `ports` 部分。

7. 保存并关闭配置文件。输出将类似于以下内容：
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

8. 验证 ALB 的 `Selector` 现在是否指向您的控制器。
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    输出示例：
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

8. 部署定制 Ingress 控制器所需的其他任何资源，例如配置映射。

9. 如果您有多专区集群，请对每个 ALB 重复这些步骤。

10. 通过执行[向公众公开集群内部的应用程序](#ingress_expose_public)中的步骤，为应用程序创建 Ingress 资源。

现在，应用程序已由定制 Ingress 控制器公开。要复原 IBM 提供的 ALB 部署，请重新启用该 ALB。该 ALB 会重新部署，并且 LoadBalancer 服务会自动重新配置为指向该 ALB。

```
ibmcloud ks alb-configure --alb-ID <alb ID> --enable
```
{: pre}
