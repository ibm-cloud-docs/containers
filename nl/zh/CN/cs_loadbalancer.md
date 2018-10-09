---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# 使用 LoadBalancer 公开应用程序
{: #loadbalancer}

公开一个端口，并使用第 4 层负载均衡器的可移植 IP 地址来访问容器化应用程序。
{:shortdesc}



## 负载均衡器组件和体系结构
{: #planning}

创建标准集群时，{{site.data.keyword.containerlong_notm}} 会自动供应可移植公共子网和可移植专用子网。

* 可移植公共子网提供了 1 个由缺省[公共 Ingress ALB](cs_ingress.html) 使用的可移植公共 IP 地址。剩余 4 个可移植公共 IP 地址可用于通过创建公共 LoadBalancer 服务向因特网公开单个应用程序。
* 可移植专用子网提供了 1 个由缺省[专用 Ingress ALB](cs_ingress.html#private_ingress) 使用的可移植专用 IP 地址。剩余 4 个可移植专用 IP 地址可用于通过创建专用 LoadBalancer 服务向专用网络公开单个应用程序。

      可移植公共和专用 IP 地址是静态的，不会在除去工作程序节点时更改。如果除去了负载均衡器 IP 地址所在的工作程序节点，那么持续监视该 IP 的保持活动的守护程序会自动将该 IP 移至其他工作程序节点。您可以为负载均衡器分配任何端口，而不限于特定端口范围。

LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](cs_nodeport.html)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](cs_network_policy.html#block_ingress)。

LoadBalancer 服务充当应用程序入局请求的外部入口点。要从因特网访问 LoadBalancer 服务，请使用负载均衡器的公共 IP 地址以及分配的端口，格式为 `<IP_address>:<port>`. 下图显示负载均衡器如何将通信从因特网定向到应用程序。

<img src="images/cs_loadbalancer_planning.png" width="550" alt="使用负载均衡器在 {{site.data.keyword.containerlong_notm}} 中公开应用程序" style="width:550px; border-style: none"/>

1. 发送到应用程序的请求使用负载均衡器的公共 IP 地址和工作程序节点上分配的端口。

2. 请求会自动转发到 LoadBalancer 服务的内部集群 IP 地址和端口。该内部集群 IP 地址只能在集群内部访问。

3. `kube-proxy` 将请求路由到应用程序的 Kubernetes LoadBalancer 服务。

4. 该请求会转发到应用程序 pod 的专用 IP 地址。请求包的源 IP 地址将更改为运行应用程序 pod 的工作程序节点的公共 IP 地址。如果集群中部署了多个应用程序实例，那么负载均衡器会在应用程序 pod 之间路由请求。

**多专区集群**：

如果您有多区域集群，那么应用程序实例会部署在跨不同专区的工作程序上的 pod 中。请查看用于将请求负载均衡到多个专区中应用程序实例的这些 LoadBalancer 设置。

<img src="images/cs_loadbalancer_planning_multizone.png" width="800" alt="使用 LoadBalancer 服务在多专区集群中对应用程序进行负载均衡" style="width:700px; border-style: none"/>

1. **可用性更低：在一个专区中部署的负载均衡器。**缺省情况下，各个负载均衡器仅在一个专区中进行设置。仅部署了一个负载均衡器时，负载均衡器必须将请求路由到其自己专区中的应用程序实例以及其他专区中的应用程序实例。

2. **可用性更高：在每个专区中部署的负载均衡器。**在具有应用程序实例的每个专区中部署负载均衡器时，可以实现更高的可用性。请求会由各个专区中的负载均衡器循环处理。此外，每个负载均衡器都会将请求路由到其自己的专区中的应用程序实例以及其他专区中的应用程序实例。


<br />



## 启用对多专区集群中应用程序的公共或专用访问权
{: #multi_zone_config}

注：
  * 此功能仅可用于标准集群。
  * LoadBalancer 服务不支持 TLS 终止。如果应用程序需要 TLS 终止，可以通过使用 [Ingress](cs_ingress.html) 公开应用程序，或者配置应用程序以管理 TLS 终止。

开始之前：
  * 具有可移植专用 IP 地址的 LoadBalancer 服务仍会在每个工作程序节点上打开一个公共 NodePort。要添加网络策略以防止公共流量，请参阅[阻止入局流量](cs_network_policy.html#block_ingress)。
  * 必须在每个专区中部署一个负载均衡器，并且每个负载均衡器都在该专区中分配有自己的 IP 地址。要创建公共负载均衡器，在每个专区中至少有一个公用 VLAN 必须具有可用的可移植子网。要添加专用负载均衡器服务，在每个专区中至少有一个专用 VLAN 必须具有可用的可移植子网。要添加子网，请参阅[为集群配置子网](cs_subnets.html)。
  * 如果将网络流量限制为流至边缘工作程序节点，请确保每个专区中必须至少启用 2 个[边缘工作程序节点](cs_edge.html#edge)。如果边缘工作程序节点在一些专区中已启用，而在其他专区中未启用，那么负载均衡器不会均匀进行部署。在一些专区中，负载均衡器将部署到边缘节点上，但在其他专区中，将部署到常规工作程序节点上。
  * 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。


要在多专区集群中设置 LoadBalancer 服务，请执行以下操作：
1.  [将应用程序部署到集群](cs_app.html#app_cli)。将应用程序部署到集群时，将创建一个或多个 pod 以用于在容器中运行应用程序。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。

2.  针对要公开的应用程序创建 LoadBalancer 服务。要使应用程序在公共因特网或专用网络上可用，请为您的应用程序创建 Kubernetes 服务。配置该服务以在负载均衡中包含构成该应用程序的所有 pod。
  1. 创建名为 `myloadbalancer.yaml`（举例来说）的服务配置文件。
  2. 针对要公开的应用程序定义 LoadBalancer 服务。可以指定专用或公共可移植子网中的 IP 地址，同时指定专区。
      - 要同时选择专区和 IP 地址，请使用 `ibm-load-balancer-cloud-provider-zone` 注释来指定专区，使用 `loadBalancerIP` 字段来指定位于该专区中的公共或专用 IP 地址。
      - 要仅选择 IP 地址，请使用 `loadBalancerIP` 字段来指定公共或专用 IP 地址。负载均衡器将在 IP 地址的 VLAN 所在的专区中进行创建。
      - 要仅选择专区，请使用 `ibm-load-balancer-cloud-provider-zone` 注释来指定专区。这将使用指定专区中的可移植 IP 地址。
      - 如果未指定 IP 地址或专区，并且集群位于公用 VLAN 上，那么将使用可移植公共 IP 地址。大多数集群都位于公用 VLAN 上。如果集群仅在专用 VLAN 上可用，那么将使用可移植的专用 IP 地址。负载均衡器将在该 VLAN 所在的专区中进行创建。

      LoadBalancer 服务使用 annotations 来指定专用或公共负载均衡器以及专区，使用 `loadBalancerIP` 部分来指定 IP 地址：

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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
          <td>指定 LoadBalancer 类型的注释。接受的值为 <code>private</code> 和 <code>public</code>。如果要在公用 VLAN 上的集群中创建公共 LoadBalancer，那么不需要此注释。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>用于指定专区的注释。要查看专区，请运行 <code>ibmcloud ks zones</code>。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请检查 <em>&lt;selectorkey&gt;</em> 和 <em>&lt;selectorvalue&gt;</em> 值。确保这些值与部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中使用的<em>键/值</em>对相同。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>服务侦听的端口。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>要创建专用 LoadBalancer 或要将特定可移植 IP 地址用于公共 LoadBalancer，请将 <em>&lt;IP_address&gt;</em> 替换为要使用的 IP 地址。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)。</td>
      </tr>
      </tbody></table>

  3. 可选：通过在 **spec** 部分中指定 `loadBalancerSourceRanges` 来配置防火墙。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

  4. 在集群中创建服务。

      ```
        kubectl apply -f myloadbalancer.yaml
        ```
      {: pre}

3. 验证 LoadBalancer 服务是否已成功创建。将 _&lt;myservice&gt;_ 替换为在上一步中创建的 LoadBalancer 服务的名称。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **注**：可能需要几分钟时间，才能正确创建 LoadBalancer 服务并使应用程序可用。

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

5. 如果选择[为 LoadBalancer 服务启用源 IP 保留 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)，请确保通过[向应用程序 pod 添加边缘节点亲缘关系](cs_loadbalancer.html#edge_nodes)，将应用程序 pod 安排到边缘工作程序节点。应用程序 pod 必须安排到边缘节点才能接收入局请求。

6. 要处理从其他专区发送到应用程序的入局请求，请重复上述步骤以在每个专区中添加一个负载均衡器。

7. 可选：LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](cs_nodeport.html)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](cs_network_policy.html#block_ingress)。

## 启用对单专区集群中应用程序的公共或专用访问权
{: #config}

开始之前：

-   此功能仅可用于标准集群。
-   必须有可移植公共或专用 IP 地址可用于分配给 LoadBalancer 服务。
-   具有可移植专用 IP 地址的 LoadBalancer 服务仍会在每个工作程序节点上打开一个公共 NodePort。要添加网络策略以防止公共流量，请参阅[阻止入局流量](cs_network_policy.html#block_ingress)。

要创建 LoadBalancer 服务，请执行以下操作：

1.  [将应用程序部署到集群](cs_app.html#app_cli)。将应用程序部署到集群时，将创建一个或多个 pod 以用于在容器中运行应用程序。确保在配置文件的 metadata 部分中添加针对您的部署的标签。需要此标签才能识别运行应用程序的所有 pod，以便可以将这些 pod 包含在负载均衡中。
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
          name: myloadbalancer
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
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
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
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
          <td><code>selector</code></td>
          <td>输入要用于将运行应用程序的 pod 设定为目标的标签键 (<em>&lt;selector_key&gt;</em>) 和值 (<em>&lt;selector_value&gt;</em>) 对。要将 pod 设定为目标并将其包含在服务负载均衡中，请检查 <em>&lt;selector_key&gt;</em> 和 <em>&lt;selector_value&gt;</em> 值。确保这些值与部署 YAML 的 <code>spec.template.metadata.labels</code> 部分中使用的<em>键/值</em>对相同。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服务侦听的端口。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>指定 LoadBalancer 类型的注释。接受的值为 `private` 和 `public`。如果要在公用 VLAN 上的集群中创建公共 LoadBalancer，那么不需要此注释。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>要创建专用 LoadBalancer 或要将特定可移植 IP 地址用于公共 LoadBalancer，请将 <em>&lt;IP_address&gt;</em> 替换为要使用的 IP 地址。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)。</td>
        </tr>
        </tbody></table>

    3.  可选：通过在 **spec** 部分中指定 `loadBalancerSourceRanges` 来配置防火墙。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在集群中创建服务。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        创建 LoadBalancer 服务时，会自动为负载均衡器分配一个可移植 IP 地址。如果没有可移植 IP 地址可用，那么无法创建 LoadBalancer 服务。


3.  验证 LoadBalancer 服务是否已成功创建。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **注**：可能需要几分钟时间，才能正确创建 LoadBalancer 服务并使应用程序可用。

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

5. 如果选择[为 LoadBalancer 服务启用源 IP 保留 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)，请确保通过[向应用程序 pod 添加边缘节点亲缘关系](cs_loadbalancer.html#edge_nodes)，将应用程序 pod 安排到边缘工作程序节点。应用程序 pod 必须安排到边缘节点才能接收入局请求。

6. 可选：LoadBalancer 服务还可使应用程序在服务的 NodePort 上可用。对于集群内的每个节点，在每个公共和专用 IP 地址上都可以访问 [NodePort](cs_nodeport.html)。要在使用 LoadBalancer 服务时阻止流至 NodePort 的流量，请参阅[控制流至 LoadBalancer 或 NodePort 服务的入站流量](cs_network_policy.html#block_ingress)。

<br />


## 向源 IP 的应用程序 pod 添加节点亲缘关系和容忍度
{: #node_affinity_tolerations}

对应用程序的客户机请求发送到集群时，该请求会路由到用于公开应用程序的 LoadBalancer 服务 pod。如果在 LoadBalancer 服务 pod 所在的工作程序节点上不存在应用程序 pod，那么负载均衡器会将该请求转发到其他工作程序节点上的应用程序 pod。软件包的源 IP 地址将更改为运行应用程序 pod 的工作程序节点的公共 IP 地址。

要保留客户机请求的原始源 IP 地址，可以为 LoadBalancer 服务[启用源 IP ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip)。TCP 连接会一直连接到应用程序 pod，以便应用程序可以查看发起方的实际源 IP 地址。例如，在应用程序服务器必须应用安全性和访问控制策略的情况下，保留客户机的 IP 非常有用。

启用源 IP 后，LoadBalancer 服务 pod 必须将请求转发到仅部署到同一工作程序节点的应用程序 pod。通常，LoadBalancer 服务 pod 也会部署到应用程序 pod 所部署到的工作程序节点上。但是，在某些情况下，负载均衡器 pod 和应用程序 pod 可能未安排到同一工作程序节点上：


* 您具有有污点的边缘节点，所以只有 LoadBalancer 服务 pod 才能部署到这些节点。不允许应用程序 pod 部署到这些节点。
* 集群连接到多个公用或专用 VLAN，但应用程序 pod 可能会部署到仅连接到一个 VLAN 的工作程序节点。LoadBalancer 服务 pod 可能不会部署到这些工作程序节点，因为负载均衡器 IP 地址连接到的 VLAN 与工作程序节点连接到的不同。

要强制将应用程序部署到 LoadBalancer 服务 pod 也可以部署到的特定工作程序节点，必须将亲缘关系规则和容忍度添加到应用程序部署。

### 添加边缘节点亲缘关系规则和容忍度
{: #edge_nodes}

[将工作程序节点标记为边缘节点](cs_edge.html#edge_nodes)并且还[污染边缘节点](cs_edge.html#edge_workloads)后，LoadBalancer 服务 pod 仅部署到这些边缘节点，应用程序 pod 无法部署到边缘节点。为 LoadBalancer 服务启用源 IP 后，边缘节点上的负载均衡器 pod 无法将入局请求转发到其他工作程序节点上的应用程序 pod。
{:shortdesc}

要强制应用程序 pod 部署到边缘节点，请将边缘节点[亲缘关系规则 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) 和[容忍度 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) 添加到应用程序部署。

具有边缘节点亲缘关系和边缘节点容忍度的部署 YAML 示例：

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

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

1. 获取 LoadBalancer 服务的 IP 地址。在 **LoadBalancer Ingress** 字段中查找该 IP 地址。
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. 检索 LoadBalancer 服务连接到的 VLAN 标识。

    1. 列出集群的可移植公用 VLAN。
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
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

