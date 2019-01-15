---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# 规划利用外部联网来公开应用程序
{: #planning}

借助 {{site.data.keyword.containerlong}}，您可以通过支持以公开或专用方式访问应用程序来管理外部联网。
{: shortdesc}

## 选择 NodePort、LoadBalancer 或 Ingress 服务
{: #external}

为了支持通过公用因特网或专用网络从外部访问应用程序，{{site.data.keyword.containerlong_notm}} 支持三种联网服务。
{:shortdesc}

**[NodePort 服务](cs_nodeport.html)**（免费和标准集群）
* 在每个工作程序节点上公开一个端口，并使用任一工作程序节点的公共或专用 IP 地址来访问集群中的服务。
* Iptables 是一个 Linux 内核功能，用于在应用程序的 pod 之间对请求进行负载均衡，提供高性能的网络路由，并提供网络访问控制。
* 工作程序节点的公共和专用 IP 地址不是永久固定的。除去或重新创建工作程序节点时，将为该工作程序节点分配新的公共 IP 地址和新的专用 IP 地址。
* NodePort 服务适合于测试公共或专用访问。如果您只需要短时间的公共或专用访问，那么也可以使用此服务。

**[LoadBalancer 服务](cs_loadbalancer.html)**（仅限标准集群）
* 每个标准集群供应有四个可移植的公共 IP 地址和四个可移植的专用 IP 地址，这些 IP 地址可以用于为应用程序创建外部 TCP/UDP 负载均衡器。
* Iptables 是一个 Linux 内核功能，用于在应用程序的 pod 之间对请求进行负载均衡，提供高性能的网络路由，并提供网络访问控制。
* 分配给负载均衡器的可移植公共和专用 IP 地址是永久固定的，在集群中重新创建工作程序节点时不会更改。
* 您可以通过公开应用程序需要的任何端口来定制负载均衡器。

**[Ingress](cs_ingress.html)**（仅限标准集群）
* 通过创建一个外部 HTTP 或 HTTPS、TCP 或 UDP 应用程序负载均衡器 (ALB)，公开集群中的多个应用程序。ALB 使用安全的唯一公共或专用入口点将入局请求路由到应用程序。
* 可以使用一个路径，将集群中的多个应用程序公开为服务。
* Ingress 由三个组件组成：
  * Ingress 资源用于定义如何对应用程序的入局请求进行路由和负载均衡的规则。
  * ALB 用于侦听入局 HTTP 或 HTTPS、TCP 或 UDP 服务请求。ALB 根据在 Ingress 资源中定义的规则，在各个应用程序 pod 之间转发请求。
  * 多专区负载均衡器 (MZLB) 用于处理对应用程序的所有入局请求，并在各个专区中的 ALB 之间对请求进行负载均衡。
* 如果要通过定制路由规则来实施您自己的 ALB，并需要对应用程序进行 SSL 终止，可使用 Ingress。

要为应用程序选择最佳联网服务，可以遵循以下决策树，并单击其中一个选项以开始使用。

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="此图像指导您选择应用程序的最佳联网选项。如果此图像未显示，仍可在文档这找到此信息。" style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Nodeport 服务" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer 服务" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress 服务" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## 规划公用外部联网
{: #public_access}

在 {{site.data.keyword.containerlong_notm}} 中创建 Kubernetes 集群时，可以将集群连接到公用 VLAN。公用 VLAN 用于确定分配给每个工作程序节点的公共 IP 地址，这将为每个工作程序节点提供一个公用网络接口。
{:shortdesc}

要使应用程序在因特网上公开可用，可以创建 NodePort、LoadBalancer 或 Ingress 服务。要比较每个服务，请参阅[选择 NodePort、LoadBalancer 或 Ingress 服务](#external)。

下图显示了在 {{site.data.keyword.containerlong_notm}} 中 Kubernetes 如何转发公用网络流量。

![{{site.data.keyword.containerlong_notm}} Kubernetes 体系结构](images/networking.png)

*{{site.data.keyword.containerlong_notm}} 中的 Kubernetes 数据平面*

免费集群和标准集群中的工作程序节点的公用网络接口受 Calico 网络策略保护。缺省情况下，这些策略将阻止大多数入站流量。但是，允许 Kubernetes 正常运行所需的入站流量，正如与 NodePort、LoadBalancer 和 Ingress 服务的连接一样。有关这些策略的更多信息（包括如何修改这些策略），请参阅[网络策略](cs_network_policy.html#network_policies)。

有关设置集群进行联网的更多信息（包括有关子网、防火墙和 VPN 的信息），请参阅[规划缺省集群联网](cs_network_cluster.html#both_vlans)。

<br />


## 为公用和专用 VLAN 设置规划专用外部联网
{: #private_both_vlans}

工作程序节点同时连接至公用 VLAN 和专用 VLAN 时，可以通过创建专用 NodePort、LoadBalancer 或 Ingress 服务来使应用程序只能从专用网络进行访问。然后，可以创建 Calico 策略以阻止流至服务的公共流量。

**NodePort**
* [创建 NodePort 服务](cs_nodeport.html)。除了公共 IP 地址外，NodePort 服务还可用于工作程序节点的专用 IP 地址。
* NodePort 服务通过工作程序节点的专用和公共 IP 地址，在工作程序节点上打开一个端口。必须使用 [Calico DNAT 前网络策略](cs_network_policy.html#block_ingress)来阻止公共 NodePort。

**LoadBalancer**
* [创建专用 LoadBalancer 服务](cs_loadbalancer.html)。
* 具有可移植专用 IP 地址的 LoadBalancer 服务仍在每个工作程序节点上打开公共节点端口。必须使用 [Calico DNAT 前网络策略](cs_network_policy.html#block_ingress)来阻止其上的公共节点端口。

**Ingress**
* 创建集群时，会自动创建一个公共和一个专用 Ingress 应用程序负载均衡器 (ALB)。由于缺省情况下会启用公共 ALB，而禁用专用 ALB，因此必须[禁用公共 ALB](cs_cli_reference.html#cs_alb_configure) 而[启用专用 ALB](cs_ingress.html#private_ingress)。
* 然后，[创建专用 Ingress 服务](cs_ingress.html#ingress_expose_private)。

例如，假设创建了专用 LoadBalancer 服务。另外还创建了 Calico DNAT 前策略，以阻止公共流量到达负载均衡器打开的公共 NodePort。可通过以下对象访问此专用负载均衡器：
* 同一集群中的任何 pod
* 同一 IBM Cloud 帐户中任何集群中的任何 pod
* 连接到同一 IBM Cloud 帐户中任何专用 VLAN 的任何系统（如果已[启用 VLAN 生成](cs_subnets.html#subnet-routing)）
* 通过 VPN 连接到负载均衡器 IP 所在子网的任何系统（如果您不在 IBM Cloud 帐户中，但仍在公司防火墙后）
* 通过 VPN 连接到负载均衡器 IP 所在子网的任何系统（如果您位于其他 IBM Cloud 帐户中）

有关设置集群进行联网的更多信息（包括有关子网、防火墙和 VPN 的信息），请参阅[规划缺省集群联网](cs_network_cluster.html#both_vlans)。

<br />


## 为仅专用 VLAN 设置规划专用外部联网
{: #private_vlan}

工作程序节点仅连接至专用 VLAN 时，可以通过创建专用 NodePort、LoadBalancer 或 Ingress 服务来使应用程序只能从专用网络进行访问。由于工作程序节点未连接到公用 VLAN，因此不会将公共流量路由到这些服务。

**NodePort**：
* [创建专用 NodePort 服务](cs_nodeport.html)。该服务通过工作程序节点的专用 IP 地址可用。
* 在专用防火墙中，打开将服务部署到允许流量流至的所有工作程序节点的专用 IP 地址时所配置的端口。要查找该端口，请运行 `kubectl get svc`。端口在 20000-32000 范围内。

**LoadBalancer**
* [创建专用 LoadBalancer 服务](cs_loadbalancer.html)。如果集群仅在专用 VLAN 上可用，那么将使用 4 个可用的可移植专用 IP 地址中的一个地址。
* 在专用防火墙中，打开将服务部署到 LoadBalancer 服务的专用 IP 地址时所配置的端口。

**Ingress**：
* 必须配置[专用网络上可用的 DNS 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。
* 创建集群时，会自动创建专用 Ingress 应用程序负载均衡器 (ALB)，但缺省情况下并未启用 ALB。必须[启用专用 ALB](cs_ingress.html#private_ingress)。
* 然后，[创建专用 Ingress 服务](cs_ingress.html#ingress_expose_private)。
* 在专用防火墙中，针对专用 ALB 的 IP 地址打开端口 80（对于 HTTP）或端口 443（对于 HTTPS）。

有关设置集群进行联网的更多信息（包括有关子网和网关设备的信息），请参阅[为仅专用 VLAN 设置规划联网](cs_network_cluster.html#private_vlan)。
