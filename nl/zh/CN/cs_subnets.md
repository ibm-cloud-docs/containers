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


# 配置集群的子网
{: #subnets}

通过向集群添加子网，更改可用的可移植公共或专用 IP 地址的池。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以通过将网络子网添加到集群来为 Kubernetes 服务添加稳定的可移植 IP。在这种情况下，不会将子网与 netmasking 一起使用，以在一个或多个集群间创建连接。相反，子网用于从可用于访问该服务的集群，为服务提供永久固定 IP。

创建标准集群时，{{site.data.keyword.containershort_notm}} 会自动供应具有 5 个 公共 IP 地址的可移植公共子网和具有 5 个专用 IP 地址的可移植专用子网。可移植公共和专用 IP 地址是静态的，不会在除去工作程序节点甚至集群时更改。对于每个子网，其中一个可移植公共 IP 地址和其中一个可移植专用 IP 地址供可用于公开集群中多个应用程序的[应用程序负载均衡器](cs_ingress.html)使用。剩余 4 个可移植公共 IP 地址和 4 个可移植专用 IP 地址可用于通过[创建 LoadBalancer 服务](cs_loadbalancer.html)向公众公开单个应用程序。

**注**：可移植公共 IP 地址按月收费。如果在供应集群后选择除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。

## 为集群请求其他子网
{: #request}

可以通过向集群分配子网，将稳定的可移植公共或专用 IP 添加到集群。

**注**：使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containershort_notm}} 外部的其他用途。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要在 IBM Cloud infrastructure (SoftLayer) 帐户中创建子网并使其可用于指定集群，请执行以下操作：

1. 供应新子网。

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>为集群供应子网的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>将 <code>&gt;cluster_name_or_id&lt;</code> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>将 <code>&gt;subnet_size&lt;</code> 替换为要从可移植子网中添加的 IP 地址数。接受的值为 8、16、32 或 64。<p>**注**：添加子网的可移植 IP 地址时，会使用 3 个 IP 地址来建立集群内部联网，所以不能将这 3 个地址用于应用程序负载均衡器或用于创建 LoadBalancer 服务。例如，如果请求 8 个可移植公共 IP 地址，那么可以使用其中 5 个地址向公众公开应用程序。</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>将 <code>&gt;VLAN_ID&lt;</code> 替换为要分配可移植公共或专用 IP 地址的公共或专用 VLAN 的标识。必须选择现有工作程序节点连接到的公用或专用 VLAN。要查看工作程序节点的公共或专用 VLAN ，请运行 <code>bx cs worker-get &gt;worker_id&lt;</code> 命令。</td>
    </tr>
    </tbody></table>

2.  验证子网已成功创建并添加到集群。子网 CIDR 在 **VLAN** 部分中列出。

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

<br />


## 向 Kibernetes 集群添加定制和现有子网
{: #custom}

可以向 Kubernetes 集群添加现有可移植公用或专用子网。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

如果 IBM Cloud infrastructure (SoftLayer) 产品服务组合中存在具有要使用的定制防火墙规则或可用 IP 地址的现有子网，请创建不具有子网的集群，并在集群供应时使现有子网可供集群使用。

1.  识别要使用的子网。记下子网的标识和 VLAN 标识。在此示例中，子网标识为 807861，VLAN 标识为 1901230。

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  确认 VLAN 所在的位置。在此示例中，位置为 dal10。

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10 
    ```
    {: screen}

3.  使用您识别的位置和 VLAN 标识来创建集群。包含 `--no-subnet` 标志，以阻止自动创建新的可移植公共 IP 子网和新的可移植专用 IP 子网。

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  验证是否请求了创建集群。

    ```
    bx cs clusters
    ```
    {: pre}

    **注**：可能需要最长 15 分钟时间，才能订购好工作程序节点计算机，并且在您的帐户中设置并供应集群。

    当完成集群供应时，集群的状态会更改为**已部署**。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3   
    ```
    {: screen}

5.  检查工作程序节点的状态。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    当工作程序节点已准备就绪时，状态会更改为 **normal**，而阶段状态为 **Ready**。节点阶段状态为 **Ready** 时，可以访问集群。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  通过指定子网标识，向集群添加子网。使子网可供集群使用后，将创建 Kubernetes 配置映射，其中包含所有可用的可移植公共 IP 地址以供您使用。如果尚不存在用于集群的应用程序负载均衡器，那么会自动使用一个可移植公共 IP 地址和一个可移植专用 IP 地址来创建公共和专用应用程序负载均衡器。其他所有可移植公共和专用 IP 地址都可用于为应用程序创建 LoadBalancer 服务。

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## 将用户管理的子网和 IP 地址添加到 Kubernetes 集群
{: #user_managed}

从要 {{site.data.keyword.containershort_notm}} 访问的内部部署网络中提供自己的子网。然后，可以将专用 IP 地址从该子网添加到 Kubernetes 集群中的 LoadBalancer 服务。

需求：
- 用户管理的子网只能添加到专用 VLAN。
- 子网前缀长度限制为 /24 到 /30。例如，`203.0.113.0/24` 指定了 253 个可用的专用 IP 地址，而 `203.0.113.0/30` 指定了 1 个可用的专用 IP 地址。
- 子网中的第一个 IP 地址必须用作子网的网关。

开始之前：
- 配置进出外部子网的网络流量的路径。
- 确认内部部署数据中心网关设备与 IBM Cloud infrastructure (SoftLayer) 产品服务组合中的专用网络 Vyatta 之间或与集群中运行的 Strongswan VPN 服务之间是否具有 VPN 连接。要使用 Vyatta，请参阅此[博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。要使用 Strongswan，请参阅[使用 Strongswan IPSec VPN 服务设置 VPN 连接](cs_vpn.html)。

1. 查看集群的专用 VLAN 的标识。找到 **VLAN** 部分。在 **User-managed** 字段中，识别带有 _false_ 的 VLAN 标识。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. 将外部子网添加到专用 VLAN。可移植专用 IP 地址将添加到集群的配置映射中。

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    示例：

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. 验证是否添加了用户提供的子网。**User-managed**字段为 _true_。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. 添加专用 LoadBalancer 服务或专用 Ingress 应用程序负载均衡器，以通过专用网络访问应用程序。如果要使用在创建专用负载均衡器或专用 Ingress 应用程序负载均衡器时添加的子网的专用 IP 地址，那么必须指定 IP 地址。否则，将在专用 VLAN 上的 IBM Cloud infrastructure (SoftLayer) 子网或用户提供的子网中随机选择 IP 地址。有关更多信息，请参阅[使用 LoadBalancer 服务类型配置对应用程序的访问](cs_loadbalancer.html#config)或[启用专用应用程序负载均衡器](cs_ingress.html#private_ingress)。

<br />


## 管理 IP 地址和子网
{: #manage}

您可以使用可移植公共和专用子网和 IP 地址公开集群中的应用程序，使其可通过因特网或专用网络进行访问。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以通过将网络子网添加到集群来为 Kubernetes 服务添加稳定的可移植 IP。创建标准集群时，{{site.data.keyword.containershort_notm}} 会自动供应具有 5 个可移植公共 IP 地址的可移植公用子网和具有 5 个可移植专用 IP 地址的可移植专用子网。可移植 IP 地址是静态的，不会在除去工作程序节点甚至集群时更改。

其中两个可移植 IP 地址（一个公共，一个专用）用于可用于公开集群中多个应用程序的 [Ingress 应用程序负载均衡器](cs_ingress.html)。通过[创建 LoadBalancer 服务](cs_loadbalancer.html)，可以使用 4 个可移植公共 IP 地址和 4 个专用 IP 地址来公开应用程序。

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

<br />




## 释放已用的 IP 地址
{: #free}

可以通过删除正在使用可移植 IP 地址的 LoadBalancer 服务，释放该已用可移植 IP 地址。

开始之前，请[为要使用的集群设置上下文](cs_cli_install.html#cs_cli_configure)。

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
