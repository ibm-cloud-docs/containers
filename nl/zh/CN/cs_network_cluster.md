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

# 设置集群网络
{: #cs_network_cluster}

在 {{site.data.keyword.containerlong}} 集群中设置联网配置。
{:shortdesc}

此页面可帮助您设置集群的网络配置。不确定要选择哪个设置？请参阅[规划集群网络](/docs/containers?topic=containers-cs_network_ov)。
{: tip}

## 设置使用公用和专用 VLAN 的集群联网
{: #both_vlans}

为集群设置对[公用 VLAN 和专用 VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options) 的访问权。下图显示了可以使用此设置为集群配置的网络选项。
{: shortdesc}

此联网设置包含以下在集群创建期间必需的联网配置以及在集群创建后可选的联网配置。

1. 如果是在防火墙后的环境中创建集群，请针对计划使用的 {{site.data.keyword.Bluemix_notm}} 服务，[允许流至公共和专用 IP 的出站网络流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

2. 创建连接到公用和专用 VLAN 的集群。如果创建多专区集群，那么可以为每个专区选择 VLAN 对。

3. 选择 Kubernetes 主节点和工作程序节点之间的通信方式。
  * 如果在 {{site.data.keyword.Bluemix_notm}} 帐户中启用了 VRF，请启用[仅公共](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)、[公共和专用](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)或[仅专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)。
  * 如果无法或不想启用 VRF，请启用[仅公共服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)。

4. 创建集群后，可以配置以下联网选项：
  * 设置 [strongSwan VPN 连接服务](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public)，以允许集群与内部部署网络或 {{site.data.keyword.icpfull_notm}} 之间的通信。
  * 创建 [Kubernetes 发现服务](/docs/containers?topic=containers-cs_network_planning#in-cluster)，以允许 pod 之间进行集群内通信。
  * 创建[公共](/docs/containers?topic=containers-cs_network_planning#public_access) Ingress、LoadBalancer 或 NodePort 服务，以将应用程序公开到公用网络。
  * 创建[专用](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) Ingress、LoadBalancer 或 NodePort 服务，以将应用程序公开到专用网络，并创建 Calico 网络策略来保护集群不受公共访问。
  * 将联网工作负载隔离到[边缘工作程序节点](/docs/containers?topic=containers-cs_network_planning#both_vlans_private_edge)。
  * [隔离专用网络上的集群](/docs/containers?topic=containers-cs_network_planning#isolate)。

<br />


## 设置仅使用专用 VLAN 的集群联网
{: #setup_private_vlan}

如果您有特定安全性需求，或者需要创建定制网络策略和路由规则，以提供专用网络安全性，请为集群设置对[仅专用 VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options) 的访问权。下图显示了可以使用此设置为集群配置的网络选项。
{: shortdesc}

此联网设置包含以下在集群创建期间必需的联网配置以及在集群创建后可选的联网配置。

1. 如果是在防火墙后的环境中创建集群，请针对计划使用的 {{site.data.keyword.Bluemix_notm}} 服务，[允许流至公共和专用 IP 的出站网络流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

2. 创建连接到[仅专用 VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options) 的集群。如果创建多专区集群，那么可以为每个专区选择专用 VLAN。

3. 选择 Kubernetes 主节点和工作程序节点之间的通信方式。
  * 如果在 {{site.data.keyword.Bluemix_notm}} 帐户中启用了 VRF，请[启用专用服务端点](#set-up-private-se)。
  * 如果无法或不想启用 VRF，那么 Kubernetes 主节点和工作程序节点无法自动连接到主节点。必须为集群配置[网关设备](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private)。

4. 创建集群后，可以配置以下联网选项：
  * [设置 VPN 网关](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private)，以允许集群与内部部署网络或 {{site.data.keyword.icpfull_notm}} 之间的通信。如果先前设置了 VRA 或 FSA，以允许主节点和工作程序节点之间进行通信，那么可以在 VRA 或 FSA 上配置 IPSec VPN 端点。
  * 创建 [Kubernetes 发现服务](/docs/containers?topic=containers-cs_network_planning#in-cluster)，以允许 pod 之间进行集群内通信。
  * 创建[专用](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan) Ingress、LoadBalancer 或 NodePort 服务，以将应用程序公开到专用网络。
  * 将联网工作负载隔离到[边缘工作程序节点](/docs/containers?topic=containers-cs_network_planning#both_vlans_private_edge)。
  * [隔离专用网络上的集群](/docs/containers?topic=containers-cs_network_planning#isolate)。

<br />


## 更改工作程序节点 VLAN 连接
{: #change-vlans}

创建集群时，选择是将工作程序节点连接到专用和公用 VLAN，还是连接到仅专用 VLAN。工作程序节点是工作程序池的一部分，用于存储联网元数据，其中包含要用于供应池中未来工作程序节点的 VLAN。日后遇到如下情况时，您可能希望更改集群的 VLAN 连接设置。
{: shortdesc}

* 专区中的工作程序池 VLAN 的容量不足，您需要供应一个新的 VLAN 以供集群工作程序节点使用。
* 您有一个集群，包含的工作程序节点同时位于公用和专用 VLAN 上，但您希望更改为[仅专用集群](#setup_private_vlan)。
* 您具有仅专用的集群，但需要某些工作程序节点（例如，公用 VLAN 上的[边缘节点](/docs/containers?topic=containers-edge#edge)的工作程序池）在因特网上公开应用程序。

要尝试转而更改用于主节点与工作程序之间通信的服务端点？请查看设置[公共](#set-up-public-se)和[专用](#set-up-private-se)服务端点的主题。
{: tip}

开始之前：
* [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
* 如果工作程序节点是独立节点（不是工作程序池的一部分），请[将其更新到工作程序池](/docs/containers?topic=containers-update#standalone_to_workerpool)。

要更改工作程序池用于供应工作程序节点的 VLAN，请执行以下操作：

1. 列出集群中工作程序池的名称。
  ```
  ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. 确定其中一个工作程序池的专区。在输出中，查找 **Zones** 字段。
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. 对于在上一步中找到的每个专区，获取相互兼容的可用公用和专用 VLAN。

  1. 检查输出中 **Type** 下列出的可用公用和专用 VLAN。
    ```
    ibmcloud ks vlans --zone <zone>
    ```
    {: pre}

  2. 检查专区中的公用和专用 VLAN 是否兼容。要使两者兼容，**Router** 必须具有相同的 pod 标识。在此示例输出中，**Router** pod 标识匹配：`01a` 和 `01a`。如果一个 pod 标识为 `01a`，另一个为 `02a`，那么无法为工作程序池设置公用和专用 VLAN 标识。
    ```
    ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
    ```
    {: screen}

  3. 如果需要为专区订购新的公用或专用 VLAN，那么可以在 [{{site.data.keyword.Bluemix_notm}} 控制台](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans)中进行订购或使用以下命令。请记住，VLAN 必须兼容，并且 **Router** pod 标识匹配，如上一步中所示。如果要创建一对新的公用和专用 VLAN，那么这些 VLAN 必须相互兼容。
    ```
    ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
    ```
    {: pre}

  4. 记下兼容 VLAN 的标识。

4. 为每个专区设置具有新的 VLAN 网络元数据的工作程序池。可以创建新的工作程序池，也可以修改现有工作程序池。

  * **创建新的工作程序池**：请参阅[通过创建新的工作程序池来添加工作程序节点](/docs/containers?topic=containers-clusters#add_pool)。

  * **修改现有工作程序池**：设置工作程序池的网络元数据以将 VLAN 用于每个专区。池中已创建的工作程序节点会继续使用先前的 VLAN，但池中的新工作程序节点将使用设置的新 VLAN 元数据。

    * 添加公用和专用 VLAN 的示例（例如，从仅专用 VLAN 更改为专用和公共 VLAN）：
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * 添加仅专用 VLAN 的示例（例如，在您有使用服务端点的[启用 VRF 的帐户](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)时，从公用和专用 VLAN 更改为仅专用 VLAN）：
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. 通过调整池大小，向工作程序池添加工作程序节点。
  ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
  {: pre}

  如果要除去使用先前网络元数据的工作程序节点，请将每个专区的工作程序数更改为先前每个专区的工作程序数的两倍。以后在这些步骤中，可以封锁、放弃和除去先前的工作程序节点。
  {: tip}

6. 验证是否新工作程序节点是使用输出中的相应 **Public IP** 和 **Private IP** 创建的。例如，如果将工作程序池从公用和专用 VLAN 更改为仅专用 VLAN，那么新的工作程序节点仅具有专用 IP。如果将工作程序池从仅专用 VLAN 更改为公用和专用 VLAN，那么新的工作程序节点将同时具有公用和专用 IP。
  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

7. 可选：从工作程序池中除去具有先前网络元数据的工作程序节点。
  1. 在上一步的输出中，记下要从工作程序池中除去的工作程序节点的 **ID** 和 **Private IP**。
  2. 在称为“封锁”的过程中将工作程序节点标记为不可安排。封锁工作程序节点后，该节点即不可用于未来的 pod 安排。
    ```
    kubectl cordon <worker_private_ip>
    ```
    {: pre}
  3. 验证是否已对工作程序节点禁用了 pod 安排。
      ```
kubectl get nodes
```
    {: pre}
如果阶段状态显示为 **`SchedulingDisabled`**，说明已禁止工作程序节点用于 pod 安排。

  4. 强制从工作程序节点中除去 pod，并将其重新安排到集群中的剩余工作程序节点上。
    ```
    kubectl drain <worker_private_ip>
    ```
    {: pre}
此过程可能需要几分钟时间。
  5. 除去工作程序节点。使用先前检索到的工作程序标识。
    ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
    {: pre}
  6. 验证工作程序节点是否已除去。
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

8. 可选：对于集群中的每个工作程序池，可以重复步骤 2 到 7。完成这些步骤后，集群中的所有工作程序节点都将设置为使用新的 VLAN。

9. 集群中的缺省 ALB 仍绑定到旧 VLAN，因为这些 ALB 的 IP 地址来自旧 VLAN 上的子网。由于 ALB 无法在 VLAN 之间移动，因此可以改为[在新 VLAN 上创建 ALB 并禁用旧 VLAN 上的 ALB](/docs/containers?topic=containers-ingress#migrate-alb-vlan)。

<br />


## 设置专用服务端点
{: #set-up-private-se}

在运行 Kubernetes V1.11 或更高版本的集群中，启用或禁用集群的专用服务端点。
{: shortdesc}

通过专用服务端点，能使 Kubernetes 主节点可供专用访问。工作程序节点和授权集群用户可以通过专用网络与 Kubernetes 主节点进行通信。要确定是否可以启用专用服务端点，请参阅[规划主节点与工作程序之间的通信](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)。请注意，在启用专用服务端点后，即无法将其禁用。

**在创建集群期间要启用的步骤**</br>
1. 在您的 IBM Cloud Infrastructure (SoftLayer) 帐户中启用 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview)。
2. [启用 {{site.data.keyword.Bluemix_notm}} 帐户以使用服务端点](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)。
3. 如果是在防火墙后的环境中创建集群，请针对基础架构资源和计划使用的 {{site.data.keyword.Bluemix_notm}} 服务，[允许流至公共和专用 IP 的出站网络流量](/docs/containers?topic=containers-firewall#firewall_outbound)。
4. 创建集群：
  * [使用 CLI 创建集群](/docs/containers?topic=containers-clusters#clusters_cli)，并使用 `--private-service-endpoint` 标志。如果还要启用公共服务端点，请同时使用 `--public-service-endpoint` 标志。
  * [使用 UI 创建集群](/docs/containers?topic=containers-clusters#clusters_ui_standard)，并选择**仅专用端点**。如果还要启用公共服务端点，请选择**公共和专用端点**。
5. 如果在防火墙后的环境中为集群启用了仅专用服务端点：
  1. 验证您是位于 {{site.data.keyword.Bluemix_notm}} 专用网络中，还是已通过 VPN 连接来连接到专用网络。
  2. [允许授权集群用户运行 `kubectl` 命令](/docs/containers?topic=containers-firewall#firewall_kubectl)，以通过专用服务端点来访问主节点。集群用户必须位于 {{site.data.keyword.Bluemix_notm}} 专用网络中，或者通过 VPN 连接来连接到专用网络，才能运行 `kubectl` 命令。
  3. 如果网络访问受公司防火墙保护，那么必须[在防火墙中允许访问 `ibmcloud` API 和 `ibmcloud ks` API 的公共端点](/docs/containers?topic=containers-firewall#firewall_bx)。虽然与主节点的所有通信都通过专用网络执行，但 `ibmcloud`和 `ibmcloud ks` 命令必须通过公共 API 端点执行。

  </br>

**创建集群后要启用的步骤**</br>
1. 在您的 IBM Cloud Infrastructure (SoftLayer) 帐户中启用 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview)。
2. [启用 {{site.data.keyword.Bluemix_notm}} 帐户以使用服务端点](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)。
3. 启用专用服务端点。
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. 刷新 Kubernetes 主节点 API 服务器以使用专用服务端点。您可以遵循 CLI 中的提示进行操作，也可以手动运行以下命令。
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

5. [创建配置映射](/docs/containers?topic=containers-update#worker-up-configmap)，用于控制集群中可以同时不可用的最大工作程序节点数。更新工作程序节点时，配置映射可帮助防止应用程序产生停机时间，因为应用程序会有序地重新安排到可用的工作程序节点上。
6. 更新集群中的所有工作程序节点以选取专用服务端点配置。

  <p class="important">通过发出更新命令，会重新装入工作程序节点以选取服务端点配置。如果没有工作程序更新可用，那么必须[手动重新装入工作程序节点](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)。如果重新装入，请确保封锁、放弃和管理工作程序节点，以控制可以同时不可用的最大工作程序节点数。</p>
  ```
  ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}

8. 如果集群位于防火墙后的环境中：
  * [允许授权集群用户运行 `kubectl` 命令，以通过专用服务端点来访问主节点](/docs/containers?topic=containers-firewall#firewall_kubectl)。
  * 针对基础架构资源和计划使用的 {{site.data.keyword.Bluemix_notm}} 服务，[允许流至专用 IP 的出站网络流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

9. 可选：要仅使用专用服务端点，请禁用公共服务端点。
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
  </br>

**禁用步骤**</br>
无法禁用专用服务端点。

## 设置公共服务端点
{: #set-up-public-se}

启用或禁用集群的公共服务端点。
{: shortdesc}

通过公共服务端点，能使 Kubernetes 主节点可供公共访问。工作程序节点和授权集群用户可以安全地通过公用网络与 Kubernetes 主节点进行通信。要确定是否可以启用公共服务端点，请参阅[规划工作程序节点与 Kubernetes 主节点之间的通信](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)。

**在创建集群期间要启用的步骤**</br>

1. 如果是在防火墙后的环境中创建集群，请针对计划使用的 {{site.data.keyword.Bluemix_notm}} 服务，[允许流至公共和专用 IP 的出站网络流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

2. 创建集群：
  * [使用 CLI 创建集群](/docs/containers?topic=containers-clusters#clusters_cli)，并使用 `--public-service-endpoint` 标志。如果还要启用专用服务端点，请同时使用 `--private-service-endpoint` 标志。
  * [使用 UI 创建集群](/docs/containers?topic=containers-clusters#clusters_ui_standard)，并选择**仅公共端点**。如果还要启用专用服务端点，请选择**公共和专用端点**。

3. 如果是在防火墙后的环境中创建集群，请[允许授权集群用户运行 `kubectl` 命令，以仅通过公共服务端点或同时通过公共和专用服务端点访问主节点](/docs/containers?topic=containers-firewall#firewall_kubectl)。

  </br>

**创建集群后要启用的步骤**</br>
如果先前禁用了公共端点，那么可以重新启用该端点。
1. 启用公共服务端点。
  ```
  ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2. 刷新 Kubernetes 主节点 API 服务器以使用公共服务端点。您可以遵循 CLI 中的提示进行操作，也可以手动运行以下命令。
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

  </br>

**禁用步骤**</br>
要禁用公共服务端点，必须首先启用专用服务端点，以便工作程序节点可以与 Kubernetes 主节点进行通信。
1. 启用专用服务端点。
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2. 通过遵循 CLI 提示进行操作或手动运行以下命令，刷新 Kubernetes 主节点 API 服务器以使用专用服务端点。
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
3. [创建配置映射](/docs/containers?topic=containers-update#worker-up-configmap)，用于控制集群中可以同时不可用的最大工作程序节点数。更新工作程序节点时，配置映射可帮助防止应用程序产生停机时间，因为应用程序会有序地重新安排到可用的工作程序节点上。

4. 更新集群中的所有工作程序节点以选取专用服务端点配置。

  <p class="important">通过发出更新命令，会重新装入工作程序节点以选取服务端点配置。如果没有工作程序更新可用，那么必须[手动重新装入工作程序节点](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)。如果重新装入，请确保封锁、放弃和管理工作程序节点，以控制可以同时不可用的最大工作程序节点数。</p>
  ```
  ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}
5. 禁用公共服务端点。
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}

## 从公共服务端点切换到专用服务端点
{: #migrate-to-private-se}

在运行 Kubernetes V1.11 或更高版本的集群中，通过启用专用服务端点，使工作程序节点能够通过专用网络而不是公用网络与主节点进行通信。
{: shortdesc}

缺省情况下，连接到公用和专用 VLAN 的所有集群都使用公共服务端点。工作程序节点和授权集群用户可以安全地通过公用网络与 Kubernetes 主节点进行通信。要使工作程序节点能够通过专用网络而不是公用网络与 Kubernetes 主节点进行通信，可以启用专用服务端点。之后，您可以选择禁用公共服务端点。
* 如果启用了专用服务端点，并同时使公共服务端点保持启用状态，那么工作程序始终通过专用网络与主节点进行通信，但用户可以通过公用网络或专用网络与主节点进行通信。
* 如果启用了专用服务端点，而禁用了公共服务端点，那么工作程序和用户必须通过专用网络与主节点进行通信。

请注意，在启用专用服务端点后，即无法将其禁用。

1. 在您的 IBM Cloud Infrastructure (SoftLayer) 帐户中启用 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview)。
2. [启用 {{site.data.keyword.Bluemix_notm}} 帐户以使用服务端点](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)。
3. 启用专用服务端点。
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. 通过遵循 CLI 提示进行操作或手动运行以下命令，刷新 Kubernetes 主节点 API 服务器以使用专用服务端点。
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
5. [创建配置映射](/docs/containers?topic=containers-update#worker-up-configmap)，用于控制集群中可以同时不可用的最大工作程序节点数。更新工作程序节点时，配置映射可帮助防止应用程序产生停机时间，因为应用程序会有序地重新安排到可用的工作程序节点上。

6.  更新集群中的所有工作程序节点以选取专用服务端点配置。

    <p class="important">通过发出更新命令，会重新装入工作程序节点以选取服务端点配置。如果没有工作程序更新可用，那么必须[手动重新装入工作程序节点](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)。如果重新装入，请确保封锁、放弃和管理工作程序节点，以控制可以同时不可用的最大工作程序节点数。</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. 可选：禁用公共服务端点。
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
