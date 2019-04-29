---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# 配置集群的子网
{: #subnets}

通过向 Kubernetes 集群添加子网，更改用于 LoadBalancer 服务的可用可移植公共或专用 IP 地址的池。
{:shortdesc}

## 使用定制或现有 IBM Cloud Infrastructure (SoftLayer) 子网创建集群
{: #subnets_custom}

创建标准集群时，将自动创建子网。但是，您可以不使用自动供应的子网，而改为使用 IBM Cloud Infrastructure (SoftLayer) 帐户中的现有可移植子网，或者复用已删除集群中的子网。
{:shortdesc}

使用此选项可在集群除去和创建操作之后保留稳定的静态 IP 地址，也可用于订购更大的 IP 地址块。如果希望改为使用您自己的内部部署网络子网来获取用于集群 Load Balancer 服务的更多可移植专用 IP 地址，请参阅[通过向专用 VLAN 添加用户管理的子网来添加可移植专用 IP](#user_managed)。

可移植公共 IP 地址按月收费。如果在供应集群后除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。
{: note}

开始之前：
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
- 要复用不再需要的集群中的子网，请删除不再需要的集群。请立即创建新集群，因为不复用的子网会在 24 小时内删除。

   ```
   ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
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

2. 使用识别到的 VLAN 标识来[创建集群](/docs/containers?topic=containers-clusters#clusters_cli)。包含 `--no-subnet` 标志，以阻止自动创建新的可移植公共 IP 子网和新的可移植专用 IP 子网。

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    如果记不住 VLAN 所在的专区以用于 `--zone` 标志，您可以通过运行 `ibmcloud ks vlans --zone <zone>` 来检查 VLAN 是否位于特定专区中。
    {: tip}

3.  验证集群是否已创建。可能最多需要 15 分钟时间，才能订购好工作程序节点机器，并在您的帐户中设置和供应集群。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    集群完全供应时，**State** 会更改为 `deployed`。

    ```
    Name         ID                                   State      Created          Workers    Zone      Version     Resource Group Name
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3          dal10     1.12.6      Default
    ```
    {: screen}

4.  检查工作程序节点的状态。

    ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
    {: pre}

    在继续执行下一步之前，工作程序节点必须准备就绪。即，**State** 更改为 `normal`，并且 **Status** 为 `Ready`。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone     Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.12.6
    ```
    {: screen}

5.  通过指定子网标识，向集群添加子网。使子网可供集群使用后，将创建 Kubernetes 配置映射，其中包含所有可用的可移植公共 IP 地址以供您使用。如果子网的 VLAN 所在的专区中不存在 Ingress ALB，那么会自动使用一个可移植公共 IP 地址和一个可移植专用 IP 地址来为该专区创建公共和专用 ALB。可以使用子网中的其他所有可移植公共和专用 IP 地址来为应用程序创建 LoadBalancer 服务。

  ```
  ibmcloud ks cluster-subnet-add --cluster <cluster_name_or_id> --subnet-id <subnet_ID>
  ```
  {: pre}

  示例命令：
  ```
  ibmcloud ks cluster-subnet-add --cluster mycluster --subnet-id 807861
  ```
  {: screen}

6. **重要信息**：要启用同一 VLAN 的不同子网上的工作程序之间的通信，必须[启用同一 VLAN 上子网之间的路由](#subnet-routing)。

<br />


## 管理现有可移植 IP 地址
{: #managing_ips}

缺省情况下，4 个可移植公共 IP 地址和 4 个可移植专用 IP 地址可用于通过[创建 LoadBalancer 服务](/docs/containers?topic=containers-loadbalancer)向公用或专用网络公开单个应用程序。要创建 LoadBalancer 服务，您必须至少有 1 个可用且类型正确的可移植 IP 地址。可以查看可用的可移植 IP 地址，或者释放已用的可移植 IP 地址。
{: shortdesc}

### 查看可用的可移植公用 IP 地址
{: #review_ip}

要列出集群中的所有可移植 IP 地址（已用和可用），可以运行以下命令。
{: shortdesc}

```
  kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
  ```
{: pre}

要仅列出可用于创建负载均衡器的可移植公共 IP 地址，可以使用以下步骤：

开始之前：
-  确保您具有对 `default` 名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

要列出可用的可移植公共 IP 地址，请执行以下操作：

1.  创建名为 `myservice.yaml` 的 Kubernetes 服务配置文件，并使用哑元负载均衡器 IP 地址定义类型为 `LoadBalancer` 的服务。以下示例使用 IP 地址 1.1.1.1 作为负载均衡器 IP 地址。

将 `<zone>` 替换为要在其中检查可用 IP 的专区。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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

    由于 Kubernetes 主节点在 Kubernetes 配置映射中找不到指定的负载均衡器 IP 地址，因此创建此服务失败。运行此命令时，可能会看到错误消息以及该集群的可用公共 IP 地址列表。

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IP addresses are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### 释放使用的 IP 地址
{: #free}

可以通过删除正在使用可移植 IP 地址的 LoadBalancer 服务，释放该已用可移植 IP 地址。
{:shortdesc}

开始之前：
-  确保您具有对 `default` 名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

要删除负载均衡器，请执行以下操作：

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

缺省情况下，4 个可移植公共 IP 地址和 4 个可移植专用 IP 地址可用于通过[创建 LoadBalancer 服务](/docs/containers?topic=containers-loadbalancer)向公用或专用网络公开单个应用程序。要创建 4 个以上的公共负载均衡器或 4 个以上的专用负载均衡器，可以通过向集群添加网络子网来获取更多可移植 IP 地址。
{: shortdesc}

使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containerlong_notm}} 外部的其他用途。
{: important}

可移植公共 IP 地址按月收费。如果在供应子网后除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。
{: note}

### 通过订购更多子网来添加可移植 IP
{: #request}

通过在 IBM Cloud Infrastructure (SoftLayer) 帐户中创建新子网，并使其可用于指定的集群，可以获取用于 LoadBalancer 服务的更多可移植 IP。
{:shortdesc}

开始之前：
-  确保您具有对集群的 [{{site.data.keyword.Bluemix_notm}} IAM **操作员**或**管理员**平台角色](/docs/containers?topic=containers-users#platform)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

要订购子网，请执行以下操作：

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
    <td>将 <code>&lt;subnet_size&gt;</code> 替换为要从可移植子网中添加的 IP 地址数。接受的值为 8、16、32 或 64。<p class="note"> 添加子网的可移植 IP 地址时，会使用 3 个 IP 地址来建立集群内部联网。所以不能将这 3 个 IP 地址用于应用程序负载均衡器或用于创建 LoadBalancer 服务。例如，如果请求 8 个可移植公共 IP 地址，那么可以使用其中 5 个地址向公众公开应用程序。</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>将 <code>&lt;VLAN_ID&gt;</code> 替换为要分配可移植公共或专用 IP 地址的公共或专用 VLAN 的标识。必须选择现有工作程序节点连接到的公共或专用 VLAN。要查看工作程序节点的公用或专用 VLAN，请运行 <code>ibmcloud ks worker-get --worker &lt;worker_id&gt;</code> 命令。<子网会在 VLAN 所在的专区中进行供应。</td>
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


### 通过向专用 VLAN 添加用户管理的子网来添加可移植专用 IP
{: #user_managed}

通过使内部部署网络中的子网可用于集群，可以获取用于 LoadBalancer 服务的更多可移植专用 IP。
{:shortdesc}

要改为复用 IBM Cloud Infrastructure (SoftLayer) 帐户中的现有可移植子网吗？请参阅[使用定制或现有 IBM Cloud Infrastructure (SoftLayer) 子网创建集群](#subnets_custom)。
{: tip}

需求：
- 用户管理的子网只能添加到专用 VLAN。
- 子网前缀长度限制为 /24 到 /30。例如，`169.xx.xxx.xxx/24` 指定了 253 个可用的专用 IP 地址，而 `169.xx.xxx.xxx/30` 指定了 1 个可用的专用 IP 地址。
- 子网中的第一个 IP 地址必须用作子网的网关。

开始之前：
- 配置进出外部子网的网络流量的路径。
- 确认内部部署数据中心网关与专用网络虚拟路由器设备或与集群中运行的 strongSwan VPN 服务之间是否具有 VPN 连接。有关更多信息，请参阅[设置 VPN 连接](/docs/containers?topic=containers-vpn)。
-  确保您具有对集群的 [{{site.data.keyword.Bluemix_notm}} IAM **操作员**或**管理员**平台角色](/docs/containers?topic=containers-users#platform)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。


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

5. 添加[专用 LoadBalancer 服务](/docs/containers?topic=containers-loadbalancer)或启用[专用 Ingress ALB](/docs/containers?topic=containers-ingress#private_ingress)，以通过专用网络访问应用程序。要使用已添加子网中的专用 IP 地址，必须指定子网 CIDR 中的 IP 地址。否则，将在专用 VLAN 上的 IBM Cloud Infrastructure (SoftLayer) 子网或用户提供的子网中随机选择 IP 地址。

<br />


## 管理子网路由
{: #subnet-routing}

如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud Infrastructure (SoftLayer) 帐户启用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview)，从而使工作程序节点可以在专用网络上相互通信。要启用 VRF，请[联系 IBM Cloud Infrastructure (SoftLayer) 客户代表](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion)。如果无法启用 VRF 或不想启用 VRF，请启用 [VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](/docs/containers?topic=containers-users#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。

请查看以下场景，其中还需要 VLAN 生成。

### 启用同一 VLAN 上主子网之间的路由
{: #vlan-spanning}

创建集群时，会在公用和专用 VLAN 上供应主公用和专用子网。主公用子网以 `/28` 结尾，提供 14 个公共 IP 用于工作程序节点。主专用子网以 `/26` 结尾，提供的专用 IP 最多可用于 62 个工作程序节点。
{:shortdesc}

如果在同一 VLAN 上的同一位置中具有一个大型集群或具有多个较小的集群，那么用于工作程序节点的 IP 可能会超过初始 14 个公共 IP 和 62 个专用 IP。公用或专用子网达到工作程序节点的限制时，系统将订购同一 VLAN 中的另一个主子网。

要确保同一 VLAN 上的这些主子网中的工作程序可以进行通信，必须开启 VLAN 生成。有关指示信息，请参阅[启用或禁用 VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。

要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。
{: tip}

### 管理网关设备的子网路由
{: #vra-routing}

创建集群时，会在集群连接到的 VLAN 上订购可移植公用子网和可移植专用子网。这些子网提供用于 Ingress 和负载均衡器联网服务的 IP 地址。
{: shortdesc}

但是，如果您有现有路由器设备（例如，[虚拟路由器设备 (VRA)](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra)），那么不会在路由器上配置集群连接到的这些 VLAN 中新添加的可移植子网。要使用 Ingress 或负载均衡器联网服务，必须通过[启用 VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)确保网络设备可以在同一 VLAN 上的不同子网之间进行路由。

要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。
{: tip}
