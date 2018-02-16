---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 设置 LoadBalancer 服务
{: #loadbalancer}

公开一个端口，并使用负载均衡器的可移植 IP 地址来访问应用程序。使用公共 IP 地址使应用程序可在因特网上进行访问，或使用专用 IP 地址使应用程序可在专用基础架构网络上进行访问。
{:shortdesc}

## 使用 LoadBalancer 服务类型来配置对应用程序的访问权
{: #config}

与 NodePort 服务不同，LoadBalancer 服务的可移植 IP 地址不依赖于应用程序所部署到的工作程序节点。但是，Kubernetes LoadBalancer 服务也是 NodePort 服务。LoadBalancer 服务通过负载均衡器 IP 地址和端口提供应用程序，并通过服务的节点端口使应用程序可用。
{:shortdesc}

系统将为您分配负载均衡器的可移植 IP 地址，并且在添加或除去工作程序节点时不会更改此 IP 地址。因此，LoadBalancer 服务要比 NodePort 服务具有更高的可用性。用户可以选择负载均衡器的任何端口，端口不限于 NodePort 端口范围。可以将 LoadBalancer 服务用于 TCP 和 UDP 协议。

**注**：LoadBalancer 服务不支持 TLS 终止。如果应用程序需要 TLS 终止，可以通过使用 [Ingress](cs_ingress.html) 公开应用程序，或者配置应用程序以管理 TLS 终止。

开始之前：

-   此功能仅可用于标准集群。
-   必须有可移植公共或专用 IP 地址可用于分配给 LoadBalancer 服务。
-   具有可移植专用 IP 地址的 LoadBalancer 服务仍在每个工作程序节点上打开公共节点端口。要添加网络策略以防止公共流量，请参阅[阻止入局流量](cs_network_policy.html#block_ingress)。

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
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>了解 LoadBalancer 服务文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
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
          <td>指定 LoadBalancer 类型的注释。值为 `private` 和 `public`。在公用 VLAN 上的集群中创建公共 LoadBalancer 时，不需要此注释。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>创建专用 LoadBalancer 或要将特定可移植 IP 地址用于公共 LoadBalancer 时，请将 <em>&lt;loadBalancerIP&gt;</em> 替换为要使用的 IP 地址。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)。</td>
        </tr>
        </tbody></table>

    3.  可选：通过在 spec 部分中指定 `loadBalancerSourceRanges` 来配置防火墙。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在集群中创建服务。

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
