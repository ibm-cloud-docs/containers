---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

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

通过向 Kubernetes 集群添加子网，更改用于 LoadBalancer 服务的可用可移植公共或专用 IP 地址的池。
{:shortdesc}

## 集群的缺省 VLAN、子网和 IP
{: #default_vlans_subnets}

在创建集群期间，集群工作程序节点和缺省子网会自动连接到 VLAN。

### VLAN
{: #vlans}

创建集群时，集群的工作程序节点会自动连接到 VLAN。VLAN 会将一组工作程序节点和 pod 视为连接到同一物理连线那样进行配置，并为工作程序和 pod 之间的连接提供通道。


<dl>
<dt>免费集群的 VLAN</dt>
<dd>在免费集群中，缺省情况下集群的工作程序节点会连接到 IBM 拥有的公用 VLAN 和专用 VLAN。因为是 IBM 控制 VLAN、子网和 IP 地址，所以无法创建多专区集群或向集群添加子网，而只能使用 NodePort 服务来公开应用程序。</dd>
<dt>标准集群的 VLAN</dt>
<dd>在标准集群中，首次在某个专区中创建集群时，会自动在 IBM Cloud Infrastructure (SoftLayer) 帐户中供应该专区中的公用 VLAN 和专用 VLAN。对于在该专区中创建的每个后续集群，可复用相同的公用和专用 VLAN，因为多个集群可以共享 VLAN。</br></br>可以将工作程序节点连接到公用 VLAN 和专用 VLAN，也可以仅连接到专用 VLAN。如果要将工作程序节点仅连接到专用 VLAN，那么可以在集群创建期间使用现有专用 VLAN 的标识，或者[创建专用 VLAN](/docs/cli/reference/ibmcloud/cli_vlan.html#ibmcloud-sl-vlan-create) 并使用其标识。</dd></dl>

要查看每个专区中为帐户供应的 VLAN，请运行 `ibmcloud ks vlans <zone>.` 要查看供应一个集群的 VLAN，请运行 `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources`，并查找 **Subnet VLANs** 部分。

**注**：
* 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。
* IBM Cloud infrastructure (SoftLayer) 管理在专区中创建第一个集群时自动供应的 VLAN。如果使 VLAN 变为未使用（例如，从 VLAN 中除去所有工作程序节点），那么 IBMCloud infrastructure (SoftLayer) 将回收此 VLAN。此后，如果需要新 VLAN，[请联系 {{site.data.keyword.Bluemix_notm}} 支持](/docs/infrastructure/vlans/order-vlan.html#order-vlans)。

### 子网和 IP 地址
{: #subnets_ips}

除了工作程序节点和 pod 外，还会将子网自动供应到 VLAN。子网通过为集群组件分配 IP 地址来提供与这些组件的网络连接。

在缺省公用和专用 VLAN 上会自动供应以下子网：

**公用 VLAN 子网**
* 主公用子网用于确定在集群创建期间分配给工作程序节点的公共 IP 地址。位于同一 VLAN 中的多个集群可以共享一个主公用子网。
* 可移植公用子网只绑定到一个集群，并为该集群提供 8 个公共 IP 地址。3 个 IP 保留用于 IBM Cloud Infrastructure (SoftLayer) 功能。1 个 IP 由缺省公共 Ingress ALB 使用，剩余 4 个 IP 可用于创建公共负载均衡器联网服务。可移植公共 IP 是永久的固定 IP 地址，可用于通过因特网访问 LoadBalancer 服务。如果需要 4 个以上的 IP 用于公共负载均衡器，请参阅[添加可移植 IP 地址](#adding_ips)。

**专用 VLAN 子网**
* 主专用子网用于确定在集群创建期间分配给工作程序节点的专用 IP 地址。位于同一 VLAN 中的多个集群可以共享一个主专用子网。
* 可移植专用子网只绑定到一个集群，并为该集群提供 8 个专用 IP 地址。3 个 IP 保留用于 IBM Cloud Infrastructure (SoftLayer) 功能。1 个 IP 由缺省专用 Ingress ALB 使用，剩余 4 个 IP 可用于创建专用负载均衡器联网服务。可移植专用 IP 是永久的固定 IP 地址，可用于通过因特网访问 LoadBalancer 服务。如果需要 4 个以上的 IP 用于专用负载均衡器，请参阅[添加可移植 IP 地址](#adding_ips)。

要查看帐户中供应的所有子网，请运行 `ibmcloud ks subnets`。要查看绑定到一个集群的可移植公用子网和可移植专用子网，可以运行 `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources`，并查找 **Subnet VLANs** 部分。

**注**：在 {{site.data.keyword.containerlong_notm}} 中，VLAN 的子网数限制为 40 个。如果达到此限制，请首先检查以了解是否可以[在 VLAN 中复用子网以创建新集群](#custom)。如果需要新的 VLAN，请通过[联系 {{site.data.keyword.Bluemix_notm}} 支持](/docs/infrastructure/vlans/order-vlan.html#order-vlans)进行订购。然后，[创建集群](cs_cli_reference.html#cs_cluster_create)以使用这一新的 VLAN。

<br />


## 使用定制或现有子网创建集群
{: #custom}

创建标准集群时，将自动创建子网。但是，您可以不使用自动供应的子网，而改为使用 IBM Cloud Infrastructure (SoftLayer) 帐户中的现有可移植子网，或者复用已删除集群中的子网。
{:shortdesc}

使用此选项可在集群除去和创建操作之后保留稳定的静态 IP 地址，也可用于订购更大的 IP 地址块。

**注**：可移植公共 IP 地址按月收费。如果在供应集群后除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。

开始之前：
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。
- 要复用不再需要的集群中的子网，请删除不再需要的集群。请立即创建新集群，因为不复用的子网会在 24 小时内删除。

   ```
  ibmcloud ks cluster-rm <cluster_name_or_ID>
  ```
   {: pre}

要将 IBM Cloud Infrastructure (SoftLayer) 产品服务组合中的现有子网与定制防火墙规则或可用 IP 地址配合使用，请执行以下操作：

1. 获取要使用的子网的标识以及该子网所在的 VLAN 的标识。

    ```
    ibmcloud ks subnets
    ```
    {: pre}

    在此示例输出中，子网标识为 `1602829`，VLAN 标识为 `2234945`：
    ```
        Getting subnet list...
    OK
    ID        Network             Gateway          VLAN ID   Type      Bound Cluster
    1550165   10.xxx.xx.xxx/26    10.xxx.xx.xxx    2234947   private
    1602829   169.xx.xxx.xxx/28   169.xx.xxx.xxx   2234945   public

    ```
    {: screen}

2. 使用识别到的 VLAN 标识来[创建集群](cs_clusters.html#clusters_cli)。包含 `--no-subnet` 标志，以阻止自动创建新的可移植公共 IP 子网和新的可移植专用 IP 子网。

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    如果记不住 VLAN 所在的专区以用于 `--zone` 标志，您可以通过运行 `ibmcloud ks vlans <zone>`.
    {: tip}

3.  验证集群是否已创建。**注**：可能需要最长 15 分钟时间，才能订购好工作程序节点机器，并且在您的帐户中设置并供应集群。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    集群完全供应时，**State** 会更改为 `deployed`。

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3         dal10      1.10.8
    ```
    {: screen}

4.  检查工作程序节点的状态。

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    在继续执行下一步之前，工作程序节点必须准备就绪。即，**State** 更改为 `normal`，并且 **Status** 为 `Ready`。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.10.8
    ```
    {: screen}

5.  通过指定子网标识，向集群添加子网。使子网可供集群使用后，将创建 Kubernetes 配置映射，其中包含所有可用的可移植公共 IP 地址以供您使用。如果子网的 VLAN 所在的专区中不存在 Ingress ALB，那么会自动使用一个可移植公共 IP 地址和一个可移植专用 IP 地址来为该专区创建公共和专用 ALB。可以使用子网中的其他所有可移植公共和专用 IP 地址来为应用程序创建 LoadBalancer 服务。

    ```
    ibmcloud ks cluster-subnet-add mycluster 807861
    ```
    {: pre}

6. **重要信息**：要启用同一 VLAN 的不同子网上的工作程序之间的通信，必须[启用同一 VLAN 上子网之间的路由](#subnet-routing)。

<br />


## 管理现有可移植 IP 地址
{: #managing_ips}

缺省情况下，4 个可移植公共 IP 地址和 4 个可移植专用 IP 地址可用于通过[创建 LoadBalancer 服务](cs_loadbalancer.html)向公共或专用网络公开单个应用程序。要创建 LoadBalancer 服务，您必须至少有 1 个可用且类型正确的可移植 IP 地址。可以查看可用的可移植 IP 地址，或者释放已用的可移植 IP 地址。

### 查看可用的可移植公用 IP 地址
{: #review_ip}

要列出集群中的所有可移植 IP 地址（已用和可用），可以运行以下命令：

```
  kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
  ```
{: pre}

要仅列出可用于创建负载均衡器的可移植公共 IP 地址，可以使用以下步骤：

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

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
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IP addresses are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### 释放使用的 IP 地址
{: #free}

可以通过删除正在使用可移植 IP 地址的 LoadBalancer 服务，释放该已用可移植 IP 地址。
{:shortdesc}

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

1.  列出集群中的可用服务。

    ```
    kubectl get services
    ```
    {: pre}

2.  除去使用公共或专用 IP 地址的 LoadBalancer 服务。

    ```
    kubectl delete service <service_name>
    ```
    {: pre}

<br />


## 添加可移植 IP 地址
{: #adding_ips}

缺省情况下，4 个可移植公共 IP 地址和 4 个可移植专用 IP 地址可用于通过[创建 LoadBalancer 服务](cs_loadbalancer.html)向公共或专用网络公开单个应用程序。要创建 4 个以上的公共负载均衡器或 4 个以上的专用负载均衡器，可以通过向集群添加网络子网来获取更多可移植 IP 地址。

**注：**
* 使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containerlong_notm}} 外部的其他用途。
* 可移植公共 IP 地址按月收费。如果在供应子网后除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。

### 通过订购更多子网来添加可移植 IP
{: #request}

通过在 IBM Cloud Infrastructure (SoftLayer) 帐户中创建新子网，并使其可用于指定的集群，可以获取用于 LoadBalancer 服务的更多可移植 IP。
{:shortdesc}

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

1. 供应新子网。

    ```
    ibmcloud ks cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
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
    <td>将 <code>&lt;cluster_name_or_id&gt;</code> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>将 <code>&lt;subnet_size&gt;</code> 替换为要从可移植子网中添加的 IP 地址数。接受的值为 8、16、32 或 64。<p>**注**：添加子网的可移植 IP 地址时，会使用 3 个 IP 地址来建立集群内部联网。所以不能将这 3 个 IP 地址用于应用程序负载均衡器或用于创建 LoadBalancer 服务。例如，如果请求 8 个可移植公共 IP 地址，那么可以使用其中 5 个地址向公众公开应用程序。</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>将 <code>&lt;VLAN_ID&gt;</code> 替换为要分配可移植公共或专用 IP 地址的公共或专用 VLAN 的标识。必须选择现有工作程序节点连接到的公共或专用 VLAN。要查看工作程序节点的公用或专用 VLAN，请运行 <code>ibmcloud ks worker-get &lt;worker_id&gt;</code> 命令。<子网会在 VLAN 所在的专区中进行供应。</td>
    </tr>
    </tbody></table>

2. 验证子网已成功创建并添加到集群。子网 CIDR 在 **Subnet VLANs** 部分中列出。

    ```
    ibmcloud ks cluster-get --showResources <cluster_name_or_ID>
    ```
    {: pre}

    在此示例输出中，第二个子网已添加到 `2234945` 公用 VLAN：
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

3. **重要信息**：要启用同一 VLAN 的不同子网上的工作程序之间的通信，必须[启用同一 VLAN 上子网之间的路由](#subnet-routing)。

<br />


### 使用用户管理的子网添加可移植专用 IP
{: #user_managed}

通过使内部部署网络中的子网可用于指定的集群，可以获取用于 LoadBalancer 服务的更多可移植专用 IP。
{:shortdesc}

需求：
- 用户管理的子网只能添加到专用 VLAN。
- 子网前缀长度限制为 /24 到 /30。例如，`169.xx.xxx.xxx/24` 指定了 253 个可用的专用 IP 地址，而 `169.xx.xxx.xxx/30` 指定了 1 个可用的专用 IP 地址。
- 子网中的第一个 IP 地址必须用作子网的网关。

开始之前：
- 配置进出外部子网的网络流量的路径。
- 确认内部部署数据中心网关与专用网络虚拟路由器设备或与集群中运行的 strongSwan VPN 服务之间是否具有 VPN 连接。有关更多信息，请参阅[设置 VPN 连接](cs_vpn.html)。

要从内部部署网络添加子网，请执行以下操作：

1. 查看集群的专用 VLAN 的标识。找到 **Subnet VLANs** 部分。在 **User-managed** 字段中，识别带有 _false_ 的 VLAN 标识。

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false

  ```
    {: screen}

2. 将外部子网添加到专用 VLAN。可移植专用 IP 地址将添加到集群的配置映射中。

    ```
    ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    示例：

    ```
    ibmcloud ks cluster-user-subnet-add mycluster 10.xxx.xx.xxx/24 2234947
    ```
    {: pre}

3. 验证是否添加了用户提供的子网。**User-managed** 字段为 _true_。

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    在此示例输出中，第二个子网已添加到 `2234947` 专用 VLAN：
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR       Public   User-managed
    2234947   10.xxx.xx.xxx/29  false    false
    2234945   169.xx.xxx.xxx/29 true     false
    2234947   10.xxx.xx.xxx/24  false    true
    ```
    {: screen}

4. [启用同一 VLAN 上子网之间的路由](#subnet-routing)。

5. 添加[专用 LoadBalancer 服务](cs_loadbalancer.html)或启用[专用 Ingress ALB](cs_ingress.html#private_ingress)，以通过专用网络访问应用程序。要使用已添加子网中的专用 IP 地址，必须指定子网 CIDR 中的 IP 地址。否则，将在专用 VLAN 上的 IBM Cloud Infrastructure (SoftLayer) 子网或用户提供的子网中随机选择 IP 地址。

<br />


## 管理子网路由
{: #subnet-routing}

如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。

请查看以下场景，其中还需要 VLAN 生成。

### 启用同一 VLAN 上主子网之间的路由
{: #vlan-spanning}

创建集群时，将在缺省专用主 VLAN 上供应以 `/26` 结尾的子网。专用主子网可以最多为 62 个工作程序节点提供 IP。
{:shortdesc}

如果是大型集群，或者在同一 VLAN 上有单个区域中的多个较小集群，可能会超过此 62 个工作程序节点的限制。达到 62 个工作程序节点的限制时，将订购同一 VLAN 中的第二个专用主子网。

要确保同一 VLAN 上的这些主子网中的工作程序可以进行通信，必须开启 VLAN 生成。有关指示信息，请参阅[启用或禁用 VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)。

要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](cs_cli_reference.html#cs_vlan_spanning_get)。
{: tip}

### 管理网关设备的子网路由
{: #vra-routing}

创建集群时，会在集群连接到的 VLAN 上订购可移植公用子网和可移植专用子网。这些子网提供用于 Ingress 和负载均衡器联网服务的 IP 地址。

但是，如果您有现有路由器设备（例如，[虚拟路由器设备 (VRA)](/docs/infrastructure/virtual-router-appliance/about.html#about)），那么不会在路由器上配置集群连接到的这些 VLAN 中新添加的可移植子网。要使用 Ingress 或负载均衡器联网服务，必须通过[启用 VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)确保网络设备可以在同一 VLAN 上的不同子网之间进行路由。

要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](cs_cli_reference.html#cs_vlan_spanning_get)。
{: tip}
