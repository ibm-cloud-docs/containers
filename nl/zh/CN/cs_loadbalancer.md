---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, lb2.0, nlb

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



# 使用负载均衡器公开应用程序
{: #loadbalancer}

公开一个端口，并使用第 4 层负载均衡器的可移植 IP 地址来访问容器化应用程序。
{:shortdesc}

LoadBalancer 服务仅可用于标准集群，并且不支持 TLS 终止。如果应用程序需要 TLS 终止，可以通过使用 [Ingress](/docs/containers?topic=containers-ingress) 公开应用程序，或者配置应用程序以管理 TLS 终止。
{: note}

首先，选择下列其中一个选项：


<img src="images/cs_loadbalancer_imagemap_1.png" usemap="#image-map-1" alt="此图像映射提供了此页面上配置主题的快速链接。">
<map name="image-map-1">
    <area target="" alt="概述" title="概述" href="#lb_overview" coords="35,44,175,72" shape="rect">
    <area target="" alt="比较 V1.0 和 V2.0 负载均衡器" title="比较 V1.0 和 V2.0 负载均衡器" href="#comparison" coords="34,83,173,108" shape="rect">
    <area target="" alt="V2.0：组件和体系结构 (Beta)" title="V2.0：组件和体系结构 (Beta)" href="#planning_ipvs" coords="273,45,420,72" shape="rect">
    <area target="" alt="V2.0：先决条件" title="V2.0：先决条件" href="#ipvs_provision" coords="277,85,417,108" shape="rect">
    <area target="" alt="V2.0：在多专区集群中设置 Load Balancer 2.0" title="V2.0：在多专区集群中设置 Load Balancer 2.0" href="#ipvs_multi_zone_config" coords="276,122,417,147" shape="rect">
    <area target="" alt="V2.0：在单专区集群中设置 Load Balancer 2.0" title="V2.0：在单专区集群中设置 Load Balancer 2.0" href="#ipvs_single_zone_config" coords="277,156,419,184" shape="rect">
    <area target="" alt="V2.0：调度算法" title="V2.0：调度算法" href="#scheduling" coords="276,196,419,220" shape="rect">
    <area target="" alt="V1.0：组件和体系结构" title="V1.0：组件和体系结构" href="#v1_planning" coords="519,47,668,74" shape="rect">
    <area target="" alt="V1.0：在多专区集群中设置 Load Balancer 1.0" title="V1.0：在多专区集群中设置 Load Balancer 1.0" href="#multi_zone_config" coords="520,85,667,110" shape="rect">
    <area target="" alt="V1.0：在单专区集群中设置 Load Balancer 1.0" title="V1.0：在单专区集群中设置 Load Balancer 1.0" href="#lb_config" coords="520,122,667,146" shape="rect">
    <area target="" alt="V1.0：启用源 IP 保留" title="V1.0：启用源 IP 保留" href="#node_affinity_tolerations" coords="519,157,667,194" shape="rect">
</map>


## 样本 YAML
{: #sample}

查看以下样本 YAML 文件可快速开始指定 Load Balancer 服务。
{: shortdesc}

**Load Balancer 2.0**</br>

已满足 [Load Balancer 2.0 的先决条件](#ipvs_provision)吗？可以使用以下部署 YAML 来创建 Load Balancer 2.0：

```
apiVersion: v1
kind: Service
metadata:
  name: myloadbalancer
  annotations:
    service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
    service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
    service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
    service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
    service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
spec:
  type: LoadBalancer
  selector:
    <selector_key>: <selector_value>
  ports:
   - protocol: TCP
     port: 8080
  loadBalancerIP: <IP_address>
  externalTrafficPolicy: Local
```
{: codeblock}

**Load Balancer 1.0**</br>

使用以下部署 YAML 来创建 Load Balancer 1.0：

```
apiVersion: v1
kind: Service
metadata:
 name: myloadbalancer
 annotations:
   service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
   service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
   service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
spec:
 type: LoadBalancer
 selector:
   <selector_key>: <selector_value>
 ports:
  - protocol: TCP
    port: 8080
 loadBalancerIP: <IP_address>
```
{: codeblock}

<br />


## 概述
{: #lb_overview}

创建标准集群时，{{site.data.keyword.containerlong}} 会自动供应可移植公共子网和可移植专用子网。
{: shortdesc}

* 可移植公用子网提供 5 个可用 IP 地址。1 个可移植公共 IP 地址由缺省[公共 Ingress ALB](/docs/containers?topic=containers-ingress) 使用。剩余 4 个可移植公共 IP 地址可用于通过创建公共 LoadBalancer 服务向因特网公开单个应用程序。
* 可移植专用子网提供 5 个可用 IP 地址。1 个可移植专用 IP 地址由缺省[专用 Ingress ALB](/docs/containers?topic=containers-ingress#private_ingress) 使用。剩余 4 个可移植专用 IP 地址可用于通过创建专用 LoadBalancer 服务向专用网络公开单个应用程序。

可移植公共和专用 IP 地址是静态浮动 IP，不会在除去工作程序节点时更改。如果除去了负载均衡器 IP 地址所在的工作程序节点，那么持续监视该 IP 的保持活动的守护程序会自动将该 IP 移至其他工作程序节点。您可以为负载均衡器分配任何端口。LoadBalancer 服务充当应用程序入局请求的外部入口点。要从因特网访问 Load Balancer 服务，可以使用负载均衡器的公共 IP 地址以及分配的端口，格式为 `<IP_address>:<port>`。

使用 LoadBalancer 服务公开应用程序时，该应用程序还会自动通过服务的 NodePort 可用。在集群内的每个工作程序节点的每个公共和专用 IP 地址上都可以访问 [NodePort](/docs/containers?topic=containers-nodeport)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](/docs/containers?topic=containers-network_policies#block_ingress)。

<br />


## 比较 V1.0 和 V2.0 负载均衡器
{: #comparison}

创建负载均衡器时，可以选择 V1.0 或 V2.0 负载均衡器。请注意，2.0 负载均衡器处于 Beta 阶段。
{: shortdesc}

**V1.0 和 V2.0 负载均衡器有哪些相似之处？**

V1.0 和 V2.0 负载均衡器都是仅在 Linux 内核空间中生存的第 4 层负载均衡器。这两个版本都在集群内运行，并使用工作程序节点资源。因此，负载均衡器的可用容量始终专用于您自己的集群。此外，这两个版本的负载均衡器都不会终止连接。而是会将连接转发到应用程序 pod。

**V1.0 和 V2.0 负载均衡器有哪些不同之处？**

客户机向应用程序发送请求时，负载均衡器会将请求包路由到应用程序 pod 所在的工作程序节点 IP 地址。V1.0 负载均衡器会使用网络地址转换 (NAT) 将请求包的源 IP 地址重写为负载均衡器 pod 所在的工作程序节点的 IP。在工作程序节点返回应用程序响应包时，会使用负载均衡器所在的工作程序节点 IP。然后，负载均衡器必须将响应包发送到客户机。为了防止重写 IP 地址，您可以[启用源 IP 保留](#node_affinity_tolerations)。但是，源 IP 保留需要负载均衡器 pod 和应用程序 pod 在同一工作程序上运行，这样请求就不必转发给其他工作程序。为此，您必须向应用程序 pod 添加节点亲缘关系和容忍度。

与 V1.0 负载均衡器不同，V2.0 负载均衡器在将请求转发到其他工作程序上的应用程序 pod 时不会使用 NAT。LoadBalancer 2.0 路由客户机请求时，会使用 IP-over-IP (IPIP) 将原始请求包封装到另一个新包中。此封装的 IPIP 包具有负载均衡器 pod 所在的工作程序节点的源 IP，这允许原始请求包保留客户机 IP 作为其源 IP 地址。然后，工作程序节点使用直接服务器返回 (DSR) 将应用程序响应包发送到客户机 IP。响应包会跳过负载均衡器而直接发送到客户机，从而减少了负载均衡器必须处理的流量。

<br />


## V2.0：组件和体系结构 (beta)
{: #planning_ipvs}

LoadBalancer 2.0 功能处于 Beta 阶段。要使用 V2.0 负载均衡器，必须[更新集群的主节点和工作程序节点](/docs/containers?topic=containers-update)至 Kubernetes V1.12 或更高版本。
{: note}

Load Balancer 2.0 是使用 Linux 内核的 IP 虚拟服务器 (IPVS) 的第 4 层负载均衡器。Load Balancer 2.0 支持 TCP 和 UDP，可在多个工作程序节点前端运行，并使用 IP-over-IP (IPIP) 隧道在这些工作程序节点之间分发到达单个负载均衡器 IP 地址的流量。

要了解有关 {{site.data.keyword.containerlong_notm}} 中可用负载均衡部署模式的更多详细信息吗？请查看此[博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/)。
{: tip}

### 单专区集群中的流量流
{: #ipvs_single}

下图显示 LoadBalancer 2.0 如何将来自因特网的通信定向到单专区集群中的应用程序。
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="使用 V2.0 负载均衡器在 {{site.data.keyword.containerlong_notm}} 中公开应用程序" style="width:600px; border-style: none"/>

1. 发送到应用程序的客户机请求使用负载均衡器的公共 IP 地址和工作程序节点上分配的端口。在此示例中，负载均衡器具有虚拟 IP 地址 169.61.23.130，该地址当前在工作程序 10.73.14.25 中。

2. 负载均衡器将客户机请求包（在图中标注为“CR”）封装在 IPIP 包（标注为“IPIP”）内。客户机请求包保留客户机 IP 作为其源 IP 地址。IPIP 封装包使用工作程序 10.73.14.25 IP 作为其源 IP 地址。

3. 负载均衡器将 IPIP 包路由到应用程序 pod 所在的工作程序 10.73.14.26 上。如果集群中部署了多个应用程序实例，那么负载均衡器会在部署了应用程序 pod 的工作程序之间路由请求。

4. 工作程序 10.73.14.26 对 IPIP 封装包解包，然后对客户机请求包解包。客户机请求包会转发到该工作程序节点上的应用程序 pod。

5. 然后，工作程序 10.73.14.26 使用原始请求包中的源 IP 地址（即客户机 IP），将应用程序 pod 的响应包直接返回给客户机。

### 多专区集群中的流量流
{: #ipvs_multi}

流经多专区集群的流量与[流经单专区集群的流量](#ipvs_single)遵循的路径相同。在多专区集群中，负载均衡器会将请求路由到其自己的专区中的应用程序实例以及其他专区中的应用程序实例。下图显示每个专区中的 V2.0 负载均衡器如何将来自因特网的流量定向到多专区集群中的应用程序。
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="使用 LoadBalancer 2.0 在 {{site.data.keyword.containerlong_notm}} 中公开应用程序" style="width:500px; border-style: none"/>

缺省情况下，一个专区中仅设置一个 V2.0 负载均衡器。通过在具有应用程序实例的每个专区中部署一个 V2.0 负载均衡器，可以实现更高的可用性。

<br />


## V2.0：先决条件
{: #ipvs_provision}

无法将现有 V1.0 负载均衡器更新为 2.0。您必须创建新的 V2.0 负载均衡器。请注意，您可以在一个集群中同时运行 V1.0 和 V2.0 负载均衡器。
{: shortdesc}

创建 2.0 负载均衡器之前，必须完成以下必备步骤。

1. [更新集群的主节点和工作程序节点](/docs/containers?topic=containers-update)至 Kubernetes V1.12 或更高版本。

2. 要允许 LoadBalancer 2.0 将请求转发到多个专区中的应用程序 pod，请开具支持用例以请求对 VLAN 进行配置设置。**重要信息**：必须为所有公用 VLAN 请求此配置。如果请求关联的新 VLAN，那么必须为该 VLAN 开具另一个凭单。
    1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://cloud.ibm.com/)。
    2. 在菜单栏中，单击**支持**，单击**管理案例**选项卡，然后单击**创建新案例**。
    3. 在案例字段中，输入以下内容：
       * 对于“支持类型”，选择**技术**。
       * 对于“类别”，选择 **VLAN 生成**。
       * 对于“主题”，输入**公用 VLAN 网络问题**。
    4. 将以下信息添加到描述：“请设置网络以允许与我的帐户关联的公用 VLAN 上进行容量聚集。此请求的引用凭单为：https://control.softlayer.com/support/tickets/63859145”。
    5. 单击**提交**。

3. 如果 VLAN 生成处于禁用状态，请为 IBM Cloud Infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。启用了 VLAN 生成后，V2.0 负载均衡器可以将包路由到帐户中的各种子网。您可以通过运行 `ibmcloud ks vlan-spanning-get` 来查看 VLAN 生成是否已启用。

4. 如果使用 [Calico DNAT 前网络策略](/docs/containers?topic=containers-network_policies#block_ingress)来管理流至 V2.0 负载均衡器 IP 地址的流量，那么必须向策略中的 `spec` 部分添加 `applyOnForward: true` 和 `doNotTrack: true` 字段，并从该部分中除去 `preDNAT: true`。`applyOnForward: true` 确保 Calico 策略应用于封装和转发的流量。`doNotTrack: true` 确保工作程序节点可以使用 DSR 将响应包直接返回给客户机，而无需跟踪连接。例如，如果使用 Calico 策略将仅从特定 IP 地址到负载均衡器 IP 地址的流量列入白名单，那么该策略类似于以下内容：
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
        ```
    {: screen}

接下来，您可以执行[在多专区集群中设置 LoadBalancer 2.0](#ipvs_multi_zone_config) 或[在单专区集群中设置 LoadBalancer 2.0](#ipvs_single_zone_config) 中的步骤。

<br />


## V2.0：在多专区集群中设置 Load Balancer 2.0
{: #ipvs_multi_zone_config}

**开始之前**：

* **重要信息**：完成 [LoadBalancer 2.0 先决条件](#ipvs_provision)。
* 要在多个专区中创建公共负载均衡器，至少一个公用 VLAN 必须在每个专区中提供可移植子网。要在多个专区中创建专用负载均衡器，至少一个专用 VLAN 必须在每个专区中提供可移植子网。您可以执行[配置集群的子网](/docs/containers?topic=containers-subnets)中的步骤来添加子网。
* 如果将网络流量限制为流至边缘工作程序节点，请确保每个专区中至少启用 2 个[边缘工作程序节点](/docs/containers?topic=containers-edge#edge)，以便负载均衡器能以均匀方式进行部署。
* 确保您具有对 `default` 名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。


要在多专区集群中设置 LoadBalancer 2.0，请执行以下操作：
1.  [将应用程序部署到集群](/docs/containers?topic=containers-app#app_cli)。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。

2.  针对要向公用因特网或专用网络公开的应用程序创建 Load Balancer 服务。
  1. 创建名为 `myloadbalancer.yaml`（举例来说）的服务配置文件。
  2. 针对要公开的应用程序定义 LoadBalancer 服务。您可以指定专区、VLAN 和 IP 地址。

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
      ```
      {: codeblock}

      <table>
      <caption>了解 YAML 文件的组成部分</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
          <td>用于指定 <code>private</code> 或 <code>public</code> 负载均衡器的注释。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>用于指定 LoadBalancer 服务部署到的专区的注释。要查看专区，请运行 <code>ibmcloud ks zones</code>。</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>用于指定 LoadBalancer 服务部署到的 VLAN 的注释。要查看 VLAN，请运行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>用于指定 V2.0 负载均衡器的注释。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>可选：用于指定调度算法的注释。接受的值为 <code>"rr"</code>（表示循环法，缺省值）或 <code>"sh"</code>（表示源散列）。有关更多信息，请参阅 [2.0：调度算法](#scheduling)。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>在应用程序部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中使用的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>)。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>服务侦听的端口。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>可选：要创建专用负载均衡器或要将特定可移植 IP 地址用于公共负载均衡器，请指定要使用的 IP 地址。该 IP 地址必须位于在注释中指定的专区和 VLAN 中。如果未指定 IP 地址：<ul><li>如果集群位于公用 VLAN 上，那么将使用可移植的公共 IP 地址。大多数集群都位于公用 VLAN 上。</li><li>如果集群仅位于专用 VLAN 上，那么将使用可移植的专用 IP 地址。</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>设置为 <code>Local</code>。</td>
      </tr>
      </tbody></table>

      用于在 `dal12` 中创建使用循环调度算法的 LoadBalancer 2.0 服务的示例配置文件：

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. 可选：通过在 `spec.loadBalancerSourceRanges` 字段中指定 IP，使 Load Balancer 服务仅可用于有限范围的 IP 地址。`loadBalancerSourceRanges` 由集群中的 `kube-proxy` 通过工作程序节点上的 Iptables 规则来实现。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

  4. 在集群中创建服务。

      ```
        kubectl apply -f myloadbalancer.yaml
        ```
      {: pre}

3. 验证 LoadBalancer 服务是否已成功创建。这可能需要几分钟时间，才能正确创建 LoadBalancer 服务并使应用程序可用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    示例 CLI 输出：

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 地址是分配给 LoadBalancer 服务的可移植 IP 地址。


4.  如果创建了公共负载均衡器，请从因特网访问该应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入负载均衡器的可移植公共 IP 地址和端口。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 要实现高可用性，请重复步骤 2 - 4，以在具有应用程序实例的每个专区中添加一个 Load Balancer 2.0。

6. 可选：LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](/docs/containers?topic=containers-nodeport)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](/docs/containers?topic=containers-network_policies#block_ingress)。



## V2.0：在单专区集群中设置 Load Balancer 2.0
{: #ipvs_single_zone_config}

**开始之前**：

* **重要信息**：完成 [LoadBalancer 2.0 先决条件](#ipvs_provision)。
* 必须有可用的可移植公共或专用 IP 地址可分配给 Load Balancer 服务。有关更多信息，请参阅[配置集群的子网](/docs/containers?topic=containers-subnets)。
* 确保您具有对 `default` 名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。

要在单专区集群中创建 LoadBalancer 2.0 服务，请执行以下操作：

1.  [将应用程序部署到集群](/docs/containers?topic=containers-app#app_cli)。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。
2.  针对要向公用因特网或专用网络公开的应用程序创建 Load Balancer 服务。
    1.  创建名为 `myloadbalancer.yaml`（举例来说）的服务配置文件。

    2.  针对要公开的应用程序定义 LoadBalancer 2.0 服务。
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>了解 YAML 文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>用于指定 <code>private</code> 或 <code>public</code> 负载均衡器的注释。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>可选：用于指定 LoadBalancer 服务部署到的 VLAN 的注释。要查看 VLAN，请运行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>用于指定 LoadBalancer 2.0 的注释。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>可选：用于指定调度算法的注释。接受的值为 <code>"rr"</code>（表示循环法，缺省值）或 <code>"sh"</code>（表示源散列）。有关更多信息，请参阅 [2.0：调度算法](#scheduling)。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>在应用程序部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中使用的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>)。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服务侦听的端口。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>可选：要创建专用负载均衡器或要将特定可移植 IP 地址用于公共负载均衡器，请指定要使用的 IP 地址。该 IP 地址必须位于在注释中指定的 VLAN 上。如果未指定 IP 地址：<ul><li>如果集群位于公用 VLAN 上，那么将使用可移植的公共 IP 地址。大多数集群都位于公用 VLAN 上。</li><li>如果集群仅位于专用 VLAN 上，那么将使用可移植的专用 IP 地址。</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>设置为 <code>Local</code>。</td>
        </tr>
        </tbody></table>

    3.  可选：通过在 `spec.loadBalancerSourceRanges` 字段中指定 IP，使 Load Balancer 服务仅可用于有限范围的 IP 地址。`loadBalancerSourceRanges` 由集群中的 `kube-proxy` 通过工作程序节点上的 Iptables 规则来实现。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在集群中创建服务。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  验证 LoadBalancer 服务是否已成功创建。可能需要几分钟时间，才能创建该服务并使应用程序可用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    示例 CLI 输出：

    ```
Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 地址是分配给 LoadBalancer 服务的可移植 IP 地址。


4.  如果创建了公共负载均衡器，请从因特网访问该应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入负载均衡器的可移植公共 IP 地址和端口。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 可选：LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](/docs/containers?topic=containers-nodeport)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](/docs/containers?topic=containers-network_policies#block_ingress)。



<br />


## V2.0：调度算法
{: #scheduling}

调度算法确定 V2.0 负载均衡器如何将网络连接分配给应用程序 pod。客户机请求到达集群时，负载均衡器会根据调度算法将请求包路由到工作程序节点。要使用调度算法，请在 Load Balancer 服务配置文件的调度程序注释中指定其保持活动短名称：`service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`。请查看以下列表以了解 {{site.data.keyword.containerlong_notm}} 中支持哪些调度算法。如果未指定调度算法，那么缺省情况下将使用循环法算法。有关更多信息，请参阅[保持活动文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://www.Keepalived.org/doc/scheduling_algorithms.html)。
{: shortdesc}

### 支持的调度算法
{: #scheduling_supported}

<dl>
<dt>循环法 (<code>rr</code>)</dt>
<dd>将连接路由到工作程序节点时，负载均衡器会在应用程序 pod 列表中循环，并对每个应用程序 pod 进行同等处理。循环法是 V2.0 负载均衡器的缺省调度算法。</dd>
<dt>源散列 (<code>sh</code>)</dt>
<dd>负载均衡器会基于客户机请求包的源 IP 地址生成一个散列键。然后，负载均衡器会在静态分配的散列表中查找该散列键，并将请求路由到用于处理该范围的散列的应用程序 pod。此算法可确保来自特定客户机的请求始终定向到同一应用程序 pod。</br>**注**：Kubernetes 使用的是 Iptables 规则，这会导致请求发送到工作程序上的随机 pod。要使用此调度算法，您必须确保每个工作程序节点仅部署一个应用程序 pod。例如，如果每个 pod 都有标签 <code>run=&lt;app_name&gt;</code>，请将以下反亲缘关系规则添加到应用程序部署的 <code>spec</code> 部分：</br>
<pre class="codeblock">
<code>
spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

您可以在[此 IBM Cloud 部署模式博客 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/) 中找到完整的示例。</dd>
</dl>

### 不支持的调度算法
{: #scheduling_unsupported}

<dl>
<dt>目标散列 (<code>dh</code>)</dt>
<dd>包的目标（即负载均衡器 IP 地址和端口）用于确定哪个工作程序节点处理入局请求。但是，{{site.data.keyword.containerlong_notm}} 中负载均衡器的 IP 地址和端口不会更改。负载均衡器被迫在其所在的工作程序节点中保留该请求，因此只有一个工作程序上的应用程序 pod 处理所有入局请求。</dd>
<dt>动态连接计数算法</dt>
<dd>以下算法取决于客户机与负载均衡器之间的动态连接计数。但是，由于直接服务返回 (DSR) 会阻止 LoadBalancer 2.0 pod 位于返回数据包路径中，因此负载均衡器不会跟踪建立的连接。<ul>
<li>最少连接数 (<code>lc</code>)</li>
<li>基于位置的最少连接数 (<code>lblc</code>)</li>
<li>使用复制的基于位置的最少连接数 (<code>lblcr</code>)</li>
<li>从不排队 (<code>nq</code>)</li>
<li>最短期望延迟 (<code>seq</code>)</li></ul></dd>
<dt>加权的 pod 算法</dt>
<dd>以下算法取决于加权的应用程序 pod。但是，在 {{site.data.keyword.containerlong_notm}} 中，所有应用程序 pod 会分配有相同的权重以实现负载均衡。<ul>
<li>加权最少连接数 (<code>wlc</code>)</li>
<li>加权循环法 (<code>wrr</code>)</li></ul></dd></dl>

<br />


## V1.0：组件和体系结构
{: #v1_planning}

TCP/UDP LoadBalancer 1.0 使用 Iptables（Linux 内核功能）对应用程序的各 pod 中的请求进行负载均衡。
{: shortdesc}

### 单专区集群中的流量流
{: #v1_single}

下图显示 Load Balancer 1.0 如何将来自因特网的通信定向到单专区集群中的应用程序。
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="使用 Load Balancer 1.0 在 {{site.data.keyword.containerlong_notm}} 中公开应用程序" style="width:410px; border-style: none"/>

1. 发送到应用程序的请求使用负载均衡器的公共 IP 地址和工作程序节点上分配的端口。

2. 请求会自动转发到 LoadBalancer 服务的内部集群 IP 地址和端口。该内部集群 IP 地址只能在集群内部访问。

3. `kube-proxy` 将请求路由到应用程序的 Kubernetes LoadBalancer 服务。

4. 该请求会转发到应用程序 pod 的专用 IP 地址。请求包的源 IP 地址将更改为运行应用程序 pod 的工作程序节点的公共 IP 地址。如果集群中部署了多个应用程序实例，那么负载均衡器会在应用程序 pod 之间路由请求。

### 多专区集群中的流量流
{: #v1_multi}

下图显示 LoadBalancer 1.0 如何将来自因特网的通信定向到多专区集群中的应用程序。
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="使用 Load Balancer 1.0 对多专区集群中的应用程序进行负载均衡" style="width:500px; border-style: none"/>

缺省情况下，一个专区中仅设置一个 LoadBalancer 1.0。要实现高可用性，必须在具有应用程序实例的每个专区中部署 LoadBalancer 1.0。请求会由各个专区中的负载均衡器循环处理。此外，每个负载均衡器都会将请求路由到其自己的专区中的应用程序实例以及其他专区中的应用程序实例。

<br />


## V1.0：在多专区集群中设置 Load Balancer 1.0
{: #multi_zone_config}

**开始之前**：
* 要在多个专区中创建公共负载均衡器，至少一个公用 VLAN 必须在每个专区中提供可移植子网。要在多个专区中创建专用负载均衡器，至少一个专用 VLAN 必须在每个专区中提供可移植子网。您可以执行[配置集群的子网](/docs/containers?topic=containers-subnets)中的步骤来添加子网。
* 如果将网络流量限制为流至边缘工作程序节点，请确保每个专区中至少启用 2 个[边缘工作程序节点](/docs/containers?topic=containers-edge#edge)，以便负载均衡器能以均匀方式进行部署。
* 为 IBM Cloud Infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)，以便工作程序节点可以在专用网络上彼此通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](/docs/containers?topic=containers-users#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。
* 确保您具有对 `default` 名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。


要在多专区集群中设置 LoadBalancer 1.0 服务，请执行以下操作：
1.  [将应用程序部署到集群](/docs/containers?topic=containers-app#app_cli)。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。

2.  针对要向公用因特网或专用网络公开的应用程序创建 Load Balancer 服务。
  1. 创建名为 `myloadbalancer.yaml`（举例来说）的服务配置文件。
  2. 针对要公开的应用程序定义 LoadBalancer 服务。您可以指定专区、VLAN 和 IP 地址。

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
        ```
      {: codeblock}

      <table>
      <caption>了解 YAML 文件的组成部分</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
          <td>用于指定 <code>private</code> 或 <code>public</code> 负载均衡器的注释。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>用于指定 LoadBalancer 服务部署到的专区的注释。要查看专区，请运行 <code>ibmcloud ks zones</code>。</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>用于指定 LoadBalancer 服务部署到的 VLAN 的注释。要查看 VLAN，请运行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>在应用程序部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中使用的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>)。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>服务侦听的端口。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>可选：要创建专用负载均衡器或要将特定可移植 IP 地址用于公共负载均衡器，请指定要使用的 IP 地址。该 IP 地址必须位于在注释中指定的 VLAN 和专区上。如果未指定 IP 地址：<ul><li>如果集群位于公用 VLAN 上，那么将使用可移植的公共 IP 地址。大多数集群都位于公用 VLAN 上。</li><li>如果集群仅位于专用 VLAN 上，那么将使用可移植的专用 IP 地址。</li></ul></td>
      </tr>
      </tbody></table>

      用于创建使用 `dal12` 中专用 VLAN `2234945` 上指定 IP 地址的专用 LoadBalancer 1.0 服务的示例配置文件：

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. 可选：通过在 `spec.loadBalancerSourceRanges` 字段中指定 IP，使 Load Balancer 服务仅可用于有限范围的 IP 地址。`loadBalancerSourceRanges` 由集群中的 `kube-proxy` 通过工作程序节点上的 Iptables 规则来实现。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

  4. 在集群中创建服务。

      ```
        kubectl apply -f myloadbalancer.yaml
        ```
      {: pre}

3. 验证 LoadBalancer 服务是否已成功创建。可能需要几分钟时间，才能创建该服务并使应用程序可用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    示例 CLI 输出：

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 地址是分配给 LoadBalancer 服务的可移植 IP 地址。


4.  如果创建了公共负载均衡器，请从因特网访问该应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入负载均衡器的可移植公共 IP 地址和端口。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}    

5. 重复步骤 2 - 4，以在每个专区中添加一个 V1.0 负载均衡器。    

6. 如果选择[为 Load Balancer V1.0 服务启用源 IP 保留](#node_affinity_tolerations)，请确保通过[向应用程序 pod 添加边缘节点亲缘关系](#edge_nodes)，将应用程序 pod 安排到边缘工作程序节点。应用程序 pod 必须安排到边缘节点才能接收入局请求。

7. 可选：LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](/docs/containers?topic=containers-nodeport)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](/docs/containers?topic=containers-network_policies#block_ingress)。



## V1.0：在单专区集群中设置 Load Balancer 1.0
{: #lb_config}

**开始之前**：
* 必须有可用的可移植公共或专用 IP 地址可分配给 Load Balancer 服务。有关更多信息，请参阅[配置集群的子网](/docs/containers?topic=containers-subnets)。
* 确保您具有对 `default` 名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。

要在单专区集群中创建 LoadBalancer 1.0 服务，请执行以下操作：

1.  [将应用程序部署到集群](/docs/containers?topic=containers-app#app_cli)。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。
2.  针对要向公用因特网或专用网络公开的应用程序创建 Load Balancer 服务。
    1.  创建名为 `myloadbalancer.yaml`（举例来说）的服务配置文件。

    2.  针对要公开的应用程序定义 LoadBalancer 服务。
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>了解 YAML 文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>用于指定 <code>private</code> 或 <code>public</code> 负载均衡器的注释。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>用于指定 LoadBalancer 服务部署到的 VLAN 的注释。要查看 VLAN，请运行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>在应用程序部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中使用的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>)。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服务侦听的端口。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>可选：要创建专用负载均衡器或要将特定可移植 IP 地址用于公共负载均衡器，请指定要使用的 IP 地址。该 IP 地址必须位于在注释中指定的 VLAN 上。如果未指定 IP 地址：<ul><li>如果集群位于公用 VLAN 上，那么将使用可移植的公共 IP 地址。大多数集群都位于公用 VLAN 上。</li><li>如果集群仅位于专用 VLAN 上，那么将使用可移植的专用 IP 地址。</li></ul></td>
        </tr>
        </tbody></table>

        用于创建使用专用 VLAN `2234945` 上指定 IP 地址的专用 LoadBalancer 1.0 服务的示例配置文件：

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3. 可选：通过在 `spec.loadBalancerSourceRanges` 字段中指定 IP，使 Load Balancer 服务仅可用于有限范围的 IP 地址。`loadBalancerSourceRanges` 由集群中的 `kube-proxy` 通过工作程序节点上的 Iptables 规则来实现。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在集群中创建服务。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  验证 LoadBalancer 服务是否已成功创建。可能需要几分钟时间，才能创建该服务并使应用程序可用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    示例 CLI 输出：

    ```
Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 地址是分配给 LoadBalancer 服务的可移植 IP 地址。


4.  如果创建了公共负载均衡器，请从因特网访问该应用程序。
    1.  打开首选的 Web 浏览器。
    2.  输入负载均衡器的可移植公共 IP 地址和端口。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 如果选择[为 Load Balancer V1.0 服务启用源 IP 保留](#node_affinity_tolerations)，请确保通过[向应用程序 pod 添加边缘节点亲缘关系](#edge_nodes)，将应用程序 pod 安排到边缘工作程序节点。应用程序 pod 必须安排到边缘节点才能接收入局请求。

6. 可选：LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](/docs/containers?topic=containers-nodeport)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](/docs/containers?topic=containers-network_policies#block_ingress)。



<br />


## V1.0：启用源 IP 保留
{: #node_affinity_tolerations}

此功能仅适用于 V1.0 负载均衡器。缺省情况下，V2.0 负载均衡器中会保留客户机请求的源 IP 地址。
{: note}

对应用程序的客户机请求发送到集群时，LoadBalancer 服务 pod 会收到该请求。如果在 LoadBalancer 服务 pod 所在的工作程序节点上不存在应用程序 pod，那么负载均衡器会将该请求转发到其他工作程序节点上的应用程序 pod。包的源 IP 地址将更改为运行 LoadBalancer 服务 pod 的工作程序节点的公共 IP 地址。
{: shortdesc}

要保留客户机请求的原始源 IP 地址，可以为 LoadBalancer 服务[启用源 IP ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip)。TCP 连接会一直连接到应用程序 pod，以便应用程序可以查看发起方的实际源 IP 地址。例如，在应用程序服务器必须应用安全性和访问控制策略的情况下，保留客户机的 IP 非常有用。

启用源 IP 后，LoadBalancer 服务 pod 必须将请求转发到仅部署到同一工作程序节点的应用程序 pod。通常，LoadBalancer 服务 pod 也会部署到应用程序 pod 所部署到的工作程序节点上。但是，在某些情况下，负载均衡器 pod 和应用程序 pod 可能未安排到同一工作程序节点上：


* 您具有有污点的边缘节点，所以只有 LoadBalancer 服务 pod 才能部署到这些节点。不允许应用程序 pod 部署到这些节点。
* 集群连接到多个公用或专用 VLAN，但应用程序 pod 可能会部署到仅连接到一个 VLAN 的工作程序节点。LoadBalancer 服务 pod 可能不会部署到这些工作程序节点，因为负载均衡器 IP 地址连接到的 VLAN 与工作程序节点连接到的不同。

要强制将应用程序部署到 LoadBalancer 服务 pod 也可以部署到的特定工作程序节点，必须将亲缘关系规则和容忍度添加到应用程序部署。

### 添加边缘节点亲缘关系规则和容忍度
{: #edge_nodes}

[将工作程序节点标注为边缘节点](/docs/containers?topic=containers-edge#edge_nodes)并且还[污染边缘节点](/docs/containers?topic=containers-edge#edge_workloads)后，LoadBalancer 服务 pod 仅部署到这些边缘节点，应用程序 pod 无法部署到边缘节点。为 LoadBalancer 服务启用源 IP 后，边缘节点上的负载均衡器 pod 无法将入局请求转发到其他工作程序节点上的应用程序 pod。
{:shortdesc}

要强制应用程序 pod 部署到边缘节点，请将边缘节点[亲缘关系规则 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) 和[容忍度 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) 添加到应用程序部署。

具有边缘节点亲缘关系和边缘节点容忍度的示例部署 YAML 文件：

```
apiVersion: apps/v1
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
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

**affinity** 和 **tolerations** 部分都将 `dedicated` 作为 `key`，将 `edge` 作为 `value`。

### 为多个公用或专用 VLAN 添加亲缘关系规则
{: #edge_nodes_multiple_vlans}

集群连接到多个公用或专用 VLAN 时，应用程序 pod 可能会部署到仅连接到一个 VLAN 的工作程序节点。如果负载均衡器 IP 地址连接到的 VLAN 与这些工作程序节点连接到的不同，那么 LoadBalancer 服务 pod 不会部署到这些工作程序节点。
{:shortdesc}

启用源 IP 后，通过将亲缘关系规则添加到应用程序部署，将应用程序 pod 安排在负载均衡器的 IP 地址所在的 VLAN 中的工作程序节点上。

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1. 获取 LoadBalancer 服务的 IP 地址。在 **LoadBalancer Ingress** 字段中查找该 IP 地址。
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. 检索 LoadBalancer 服务连接到的 VLAN 标识。

    1. 列出集群的可移植公用 VLAN。
        ```
        ibmcloud ks cluster-get --cluster <cluster_name_or_ID> --showResources
        ```
        {: pre}

        输出示例：
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. 在输出的 **Subnet VLANs** 下，查找与先前检索到的负载均衡器 IP 地址相匹配的子网 CIDR，并记下相应的 VLAN 标识。

        例如，如果 LoadBalancer 服务 IP 地址为 `169.36.5.xxx`，那么上一步的示例输出中的匹配子网为 `169.36.5.xxx/29`。该子网连接到的 VLAN 标识为 `2234945`。

3. 向上一步中记录的 VLAN 标识的应用程序部署[添加亲缘关系规则 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature)。

    例如，如果您有多个 VLAN，但希望应用程序 pod 仅部署到 `2234945` 公用 VLAN 上的工作程序节点：

    ```
    apiVersion: apps/v1
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
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    在示例 YAML 中，**affinity** 部分将 `publicVLAN` 作为 `key`，将 `"2234945"` 作为 `value`。

4. 应用已更新的部署配置文件。
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. 验证应用程序 pod 是否已部署到连接至指定 VLAN 的工作程序节点。

    1. 列出集群中的 pod。将 `<selector>` 替换为用于应用程序的标签。
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        输出示例：
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 在输出中，确定应用程序的 pod。记下该 pod 所在的工作程序节点的 **NODE** 标识。

        在上一步的示例输出中，应用程序 pod `cf-py-d7b7d94db-vp8pq` 位于工作程序节点 `10.176.48.78` 上。

    3. 列出工作程序节点的详细信息。

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        输出示例：

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. 在输出的 **Labels** 部分中，验证公用或专用 VLAN 是否为在先前步骤中指定的 VLAN。


