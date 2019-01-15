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


# 规划集群和工作程序节点设置
{: #plan_clusters}
通过 {{site.data.keyword.containerlong}} 设计标准集群，以实现应用程序的最大可用性和容量。

## 高可用性集群
{: #ha_clusters}

跨多个工作程序节点、专区和集群分布应用程序时，用户不太可能会遇到停机时间。内置功能（例如负载均衡和隔离）可在主机、网络或应用程序发生潜在故障时更快恢复。
{: shortdesc}

查看以下潜在的集群设置（按可用性程度从低到高排序）。

![集群的高可用性](images/cs_cluster_ha_roadmap_multizone.png)

1. [单专区集群](#single_zone)，在一个工作程序池中具有多个工作程序节点。
2. [多专区集群](#multizone)，跨一个区域内的多个专区分布工作程序节点。
3. [多集群](#multiple_clusters)，跨专区或区域设置并通过全局负载均衡器连接。

## 单专区集群
{: #single_zone}

要提高应用程序的可用性，并允许在一个工作程序节点在集群中不可用时进行故障转移，请向单专区集群添加更多工作程序节点。
{: shortdesc}

<img src="images/cs_cluster_singlezone.png" alt="单专区中集群的高可用性" width="230" style="width:230px; border-style: none"/>

缺省情况下，单专区集群会设置为使用名为 `default` 的工作程序池。工作程序池将使用集群创建期间所定义的相同配置（如机器类型）的工作程序节点分组在一起。可以通过[调整现有工作程序池大小](cs_clusters.html#resize_pool)或[添加新的工作程序池](cs_clusters.html#add_pool)，向集群添加更多工作程序节点。

添加更多工作程序节点时，可以跨多个工作程序节点分布应用程序实例。如果一个工作程序节点停止运行，可用工作程序节点上的应用程序实例会继续运行。Kubernetes 会自动重新安排不可用工作程序节点中的 pod，以确保应用程序的性能和容量。要确保 pod 均匀分布在不同工作程序节点上，请实现 [pod 亲缘关系](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature)。

**可以将单专区集群转换为多专区集群吗？**</br>
如果集群位于某个[受支持的多专区大城市](cs_regions.html#zones)中，那么是。请参阅[从独立工作程序节点更新到工作程序池](cs_cluster_update.html#standalone_to_workerpool)。


**必须使用多专区集群吗？**</br>
不是。您可以根据需要创建任意数量的单专区集群。实际上，为了简化管理，或者在集群必须位于特定[单专区城市](cs_regions.html#zones)中时，您可能更愿意使用单专区集群。

**在单个专区中可以有高可用性主节点吗？**</br>
可以，运行 Kubernetes V1.10 或更高版本的集群可以有高可用性主节点。在单个专区中，主节点具有高可用性，在分别用于 Kubernetes API 服务器、etcd、调度程序和控制器管理器的不同物理主机上包含多个副本，以防止发生中断，例如在主节点更新期间。要避免受到专区故障的影响，可以执行以下操作：
* [在支持多专区的专区中创建集群](cs_clusters_planning.html#multizone)，其中主节点在各专区中分布。
* [创建多个集群](#multiple_clusters)并使用全局负载均衡器连接这些集群。

## 多专区集群
{: #multizone}

通过 {{site.data.keyword.containerlong}}，可以创建多专区集群。使用工作程序池跨多个工作程序节点和专区分布应用程序时，用户不太可能会遇到停机时间。通过内置功能（如负载均衡），可在主机、网络或应用程序发生潜在专区故障时更快恢复。如果一个专区中的资源停止运行，集群工作负载仍会在其他专区中运行。
**注：**只有单专区集群可用于 {{site.data.keyword.Bluemix_dedicated_notm}} 实例。
{: shortdesc}

**什么是工作程序池？**</br>
工作程序池是具有相同类型模板（例如，机器类型、CPU 和内存）的工作程序节点的集合。在创建集群时，会自动为您创建缺省工作程序池。要使工作程序节点分布在跨专区的池中、将工作程序节点添加到池或者更新工作程序节点，那么可以使用新的 `ibmcloud ks worker-pool` 命令。

**仍可以使用独立工作程序节点吗？**</br>
支持独立工作程序节点的先前集群设置，但不推荐使用。确保[向集群添加工作程序池](cs_clusters.html#add_pool)，然后[使用工作程序池](cs_cluster_update.html#standalone_to_workerpool)来组织工作程序节点，以取代独立工作程序节点。

**可以将单专区集群转换为多专区集群吗？**</br>
如果集群位于某个[受支持的多专区大城市](cs_regions.html#zones)中，那么是。请参阅[从独立工作程序节点更新到工作程序池](cs_cluster_update.html#standalone_to_workerpool)。


### 我想了解有关多专区集群设置的更多信息
{: #mz_setup}

<img src="images/cs_cluster_multizone-ha.png" alt="多专区集群的高可用性" width="500" style="width:500px; border-style: none"/>

您可以向集群添加更多专区，以在一个区域内跨多个专区的工作程序池中复制工作程序节点。多专区集群旨在跨工作程序节点和专区均匀安排 pod，以确保可用性和故障恢复。如果工作程序节点未跨专区均匀分布，或者其中一个专区中的容量不足，那么 Kubernetes 调度程序可能无法安排所有请求的 pod。结果，pod 可能会进入**暂挂**状态，直到有足够的容量可用为止。如果要更改缺省行为，以使 Kubernetes 调度程序在多个专区中以最佳分布方式分布 pod，请使用 `preferredDuringSchedulingIgnoredDuringExecution` [pod 亲缘关系策略](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature)。

**为什么需要工作程序节点位于 3 个专区中？**</br>
在 3 个专区中分布工作负载可确保应用程序的高可用性，以防一个或两个专区不可用的情况，同时这也使集群设置更符合成本效益。您可能会问为什么？下面是一个示例。

假设您需要具有 6 个核心的工作程序节点来处理应用程序的工作负载。要使集群的可用性更高，您具有以下选项：

- **在另一个专区中复制资源：**使用此选项时，会有 2 个工作程序节点，每个节点在每个专区中有 6 个核心，总计 12 个核心。</br>
- **在 3 个专区中分布资源：**使用此选项时，每个专区会部署 3 个核心，总容量为 9 个核心。要处理工作负载，在同一时间必须有两个专区在正常运行。如果一个专区不可用，那么其他两个专区可以处理工作负载。如果两个专区不可用，那么剩余 3 个核心将处理工作负载。每个区域部署 3 个核心意味着机器更小，从而降低了成本。</br>

**如何设置我的 Kubernetes 主节点？**</br>
多专区集群可设置单个 Kubernetes 主节点或高可用性（Kubernetes 1.10 或更高版本）Kubernetes 主节点，该主节点在工作程序所在的大城市区域中进行供应。此外，如果创建多专区集群，那么高可用性主节点会在各专区中分布。例如，如果集群位于 `dal10`、`dal12` 或 `dal13` 专区中，那么主节点会在达拉斯多专区大城市中的各专区中分布。

**Kubernetes 主节点变得不可用时会发生什么情况？**</br>
[Kubernetes 主节点](cs_tech.html#architecture)是用于保持集群正常启动并运行的主组件。主节点将集群资源及其配置存储在充当集群单个事实点的 etcd 数据库中。Kubernetes API 服务器是从工作程序节点到主节点的所有集群管理请求或者想要与集群资源交互时的主入口点。<br><br>如果主节点发生故障，那么工作负载将继续在工作程序节点上运行，但是无法使用 `kubectl` 命令来处理集群资源或查看集群运行状况，直至主节点中的 Kubernetes API 服务器恢复运行。如果在主节点停运期间 pod 停止运行，那么在工作程序节点可再次访问 Kubernetes API 服务器之前，将无法重新调度 pod。<br><br>在主节点停运期间，您仍可以针对 {{site.data.keyword.containerlong_notm}} API 运行 `ibmcloud ks` 命令以处理基础架构资源，例如，工作程序节点或 VLAN。如果通过向集群添加或从中除去工作程序节点来更改当前集群配置，那么在主节点恢复运行前，更改不会发生。

在主节点停运期间，请勿重新启动或重新引导工作程序节点。此操作会从工作程序节点中除去 pod。因为 Kubernetes API 服务器不可用，因此无法将 pod 重新调度到集群中的其他工作程序节点。
{: important}


要保护集群不受 Kubernetes 主节点故障的影响或在多专区集群不可用的区域中保护集群，可以[设置多个集群并通过全局负载均衡器连接](#multiple_clusters)。

**是否必须执行任何操作从而使主节点可跨专区与工作程序进行通信？**</br>
可以。如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud Infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud Infrastructure (SoftLayer) 帐户代表。

**如何允许用户通过公共因特网访问应用程序？**</br>
可以使用 Ingress 应用程序负载均衡器 (ALB) 或 LoadBalancer 服务来公开应用程序。

- **Ingress 应用程序负载均衡器 (ALB)：**缺省情况下，会自动在集群的每个专区中创建并启用公共 ALB。此外，还会自动创建并部署集群的 Cloudflare 多专区负载均衡器 (MZLB)，从而对于每个区域存在 1 个 MZLB。MZLB 将 ALB 的 IP 地方放在同一主机名后，并且在这些 IP 地址上启用运行状况检查以确定它们是否可用。例如，如果工作程序节点位于美国东部区域的 3 个专区中，那么主机名 `yourcluster.us-east.containers.appdomain.cloud` 具有 3 个 ALB IP 地址。MZLB 运行状况检查会检查区域的每个专区中的公共 ALB IP，并根据这些运行状况检查使 DNS 查找结果保持更新。有关更多信息，请参阅 [Ingress 组件和体系结构](cs_ingress.html#planning)。

- **LoadBalancer 服务：**LoadBalancer 服务只需在一个专区中设置。应用程序的入局请求会从一个专区路由到其他专区中的所有应用程序实例。如果此专区变得不可用，那么可能无法通过因特网访问应用程序。考虑到单专区故障，您可以在其他专区中设置更多 LoadBalancer 服务。有关更多信息，请参阅高可用性 [LoadBalancer 服务](cs_loadbalancer.html#multi_zone_config)。

**是否可为多专区集群设置持久性存储器？**</br>
对于高可用性持久性存储器，请使用云服务，例如 [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) 或 [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)。

NFS 文件和块存储器不可跨专区共享。持久性卷只能在实际存储设备所在的专区中使用。如果想要继续使用集群中的现有 NFS 文件或块存储器，那么必须将区域和专区标签应用于现有持久性卷。这些标签可帮助 kube-scheduler 确定在何处安排使用持久性卷的应用程序。运行以下命令并将 `<mycluster>` 替换为您的集群名称。

```
bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster>
```
{: pre}

**我已创建多专区集群。为什么仍然只有一个专区？如何向集群添加专区？**</br>
如果是[使用 CLI 创建多专区集群](cs_clusters.html#clusters_cli)的，那么会创建集群，但您必须将专区添加到工作程序池才能完成该过程。要跨多个专区，集群必须位于[多专区大城市](cs_regions.html#zones)中。要向集群添加专区，并跨专区分布工作程序节点，请参阅[向集群添加专区](cs_clusters.html#add_zone)。

### 目前管理集群的方式会有哪些变化？
{: #mz_new_ways}

引入工作程序池后，可以使用一组新的 API 和命令来管理集群。可以在 [CLI 文档页面](cs_cli_reference.html#cs_cli_reference)中或通过在终端中运行 `ibmcloud ks help` 来查看这些新命令。

下表比较了几种常见集群管理操作的旧方法和新方法。
<table summary="该表显示了执行多专区命令的新方法的描述。每行从左到右阅读，其中第一列是描述，第二列是旧方法，第三列是新的多专区方法。">
<caption>多专区工作程序池命令的新方法。</caption>
  <thead>
  <th>描述</th>
  <th>旧的独立工作程序节点</th>
  <th>新的多专区工作程序池</th>
  </thead>
  <tbody>
    <tr>
    <td>向集群添加工作程序节点。</td>
    <td><p class="deprecated"><code>ibmcloud ks worker-add</code>，用于添加独立工作程序节点。</p></td>
    <td><ul><li>要添加与现有池不同的机器类型，请创建新的工作程序池：<code>ibmcloud ks worker-pool-create</code> [命令](cs_cli_reference.html#cs_worker_pool_create)。</li>
    <li>要向现有池添加工作程序节点，请调整池中每个专区的节点数：<code>ibmcloud ks worker-pool-resize</code> [命令](cs_cli_reference.html#cs_worker_pool_resize)。</li></ul></td>
    </tr>
    <tr>
    <td>从集群中除去工作程序节点。</td>
    <td><code>ibmcloud ks worker-rm</code>，仍可以使用此命令从集群中删除有问题的工作程序节点。</td>
    <td><ul><li>如果工作程序池不均衡（例如，除去工作程序节点后），请对其进行重新均衡：<code>ibmcloud ks worker-pool-rebalance</code> [命令](cs_cli_reference.html#cs_rebalance)。</li>
    <li>要减少池中的工作程序节点数，请调整每个专区的工作程序节点数（最小值为 1）：<code>ibmcloud ks worker-pool-resize</code> [命令](cs_cli_reference.html#cs_worker_pool_resize)。</li></ul></td>
    </tr>
    <tr>
    <td>将新的 VLAN 用于工作程序节点。</td>
    <td><p class="deprecated">添加使用新的专用或公用 VLAN 的新工作程序节点：<code>ibmcloud ks worker-add</code>。</p></td>
    <td>将工作程序池设置为使用不同于先前所用的公用或专用 VLAN：<code>ibmcloud ks zone-network-set</code> [命令](cs_cli_reference.html#cs_zone_network_set)。</td>
    </tr>
  </tbody>
  </table>

## 通过全局负载均衡器连接的多个集群
{: #multiple_clusters}

要保护应用程序不受 Kubernetes 主节点故障的影响以及对于多专区集群不可用的区域保护应用程序，可以在一个区域的不同专区中创建多个集群，并通过全局负载均衡器将集群连接在一起。
{: shortdesc}

<img src="images/cs_multiple_cluster_zones.png" alt="多个集群的高可用性" width="700" style="width:700px; border-style: none"/>

要跨多个集群均衡工作负载，必须设置全局负载均衡器，并将应用程序负载均衡器 (ALB) 或 LoadBalancer 服务的 IP 地址添加到域。通过添加这些 IP 地址，可以在集群之间路由入局流量。要使全局负载均衡器检测其中一个集群是否不可用，请考虑向每个 IP 地址添加基于 ping 操作的运行状况检查。设置此检查后，DNS 提供程序会定期对添加到域的 IP 地址执行 ping 操作。如果一个 IP 地址变为不可用，那么不会再将流量发送到此 IP 地址。但是，Kubernetes 不会在可用集群中工作程序节点上自动重新启动不可用集群中的 pod。如果希望 Kubernetes 在可用集群中自动重新启动可用集群中的 pod，请考虑设置[多专区集群](#multizone)。

**为什么需要 3 个集群位于 3 个专区中？**</br>
类似于[在多专区集群中使用 3 个专区](#multizone)，您可以通过设置跨专区的 3 个集群，为应用程序提供更高可用性。此外，还可以通过购买更小的机器来处理工作负载，从而降低成本。

**如果要跨区域设置多个集群该怎么做？**</br>
可以在一个地理位置的不同区域（如美国南部和美国东部）或不同地理位置（如美国南部和欧洲中部）中设置多个集群。这两种设置为应用程序提供的可用性级别相同，但同时在数据共享和数据复制方面增加了复杂性。在大多数情况下，保持在同一地理位置中就足以满足需求。但是，如果您的用户分布在世界各地，那么最好设置用户所在的集群，以便用户在向应用程序发送请求时不会遇到很长的等待时间。

**要设置用于多个集群的全局负载均衡器，请执行以下操作：**

1. 在多个专区或区域中[创建集群](cs_clusters.html#clusters)。
2. 如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud Infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud Infrastructure (SoftLayer) 帐户代表。
3. 在每个集群中，使用[应用程序负载均衡器 (ALB)](cs_ingress.html#ingress_expose_public) 或 [LoadBalancer 服务](cs_loadbalancer.html)来公开应用程序。
4. 对于每个集群，列出 ALB 或 LoadBalancer 服务的公共 IP 地址。
   - 要列出集群中所有支持公共的 ALB 的 IP 地址，请运行以下命令：
     ```
     ibmcloud ks albs --cluster <cluster_name_or_id>
     ```
     {: pre}

   - 要列出 LoadBalancer 服务的 IP 地址，请运行以下命令：
     ```
    kubectl describe service <myservice>
    ```
     {: pre}

          **LoadBalancer Ingress** IP 地址是分配给 LoadBalancer 服务的可移植 IP 地址。


4.  使用 {{site.data.keyword.Bluemix_notm}} Internet Services (CIS) 来设置全局负载均衡器，或设置您自己的全局负载均衡器。

    **要使用 CIS 全局负载均衡器**：
    1.  通过执行 [{{site.data.keyword.Bluemix_notm}}Internet Services (CIS) 入门](/docs/infrastructure/cis/getting-started.html#getting-started-with-ibm-cloud-internet-services-cis-)中的步骤 1-4 来设置服务。
        *  步骤 1-3 会引导您供应服务实例、添加应用程序域以及配置名称服务器。
        * 步骤 4 会将引导您创建 DNS 记录。请为收集的每个 ALB 或负载均衡器 IP 地址创建 DNS 记录。这些 DNS 记录会将应用程序域映射到所有集群 ALB 或负载均衡器，并确保在循环周期中将对应用程序域的请求转发到集群。
    2. 为 ALB 或负载均衡器[添加运行状况检查](/docs/infrastructure/cis/glb-setup.html#add-a-health-check)。可以对所有集群中的 ALB 或负载均衡器使用相同的运行状况检查，或者创建特定运行状况检查以用于特定集群。
    3. 通过添加集群的 ALB 或负载均衡器 IP，为每个集群[添加源池](/docs/infrastructure/cis/glb-setup.html#add-a-pool)。例如，如果您有 3 个集群，每个集群有 2 个 ALB，请创建 3 个源池，每个池 2 个 ALB IP 地址。为创建的每个源池添加运行状况检查。
    4. [添加全局负载均衡器](/docs/infrastructure/cis/glb-setup.html#set-up-and-configure-your-load-balancers)。

    **要使用自己的全局负载均衡器**：
    1. 通过将所有支持公共的 ALB 和 LoadBalancer 服务的 IP 地址添加到域，将域配置为将入局流量路由到 ALB 或 LoadBalancer 服务。
    2. 对于每个 IP 地址，启用基于 ping 操作的运行状况检查，以便 DNS 提供程序可以检测到运行状况欠佳的 IP 地址。如果检测到运行状况欠佳的 IP 地址，那么流量不会再路由到此 IP 地址。

## 专用集群
{: #private_clusters}

缺省情况下，{{site.data.keyword.containerlong_notm}} 将集群设置为具有专用 VLAN 和公用 VLAN 的访问权。专用 VLAN 用于确定分配给每个工作程序节点的专用 IP 地址，这将为每个工作程序节点提供一个专用网络接口。
公用 VLAN 允许工作程序节点自动、安全地连接到主节点。

如果要锁定集群以允许专用 VLAN 上的专用流量，但阻止公用 VLAN 上的公共流量，那么可以[使用 Calico 网络策略保护集群不被公共访问](cs_network_cluster.html#both_vlans_private_services)。这些 Calico 网络策略不会阻止工作程序节点与主节点进行通信。通过[将联网工作负载隔离到边缘工作程序节点](cs_edge.html)，您还可以限制集群中漏洞的浮现，而无需锁定公共流量。

如果想要创建仅具有专用 VLAN 访问权的集群，那么可创建单专区或多专区专用集群。但是，在工作程序节点仅连接到专用 VLAN 时，工作程序节点无法自动连接到主节点。必须配置网关设备以在工作程序节点和主节点之间提供网络连接。


您无法将连接到公用和专用 VLAN 的集群转换为仅专用集群。从集群除去所有公用 VLAN 将导致多个集群组件停止工作。必须使用以下步骤来创建新集群。
{: note}

如果想要创建仅具有专用 VLAN 访问权的集群：

1.  查看[规划仅专用集群联网](cs_network_cluster.html#private_vlan)。
2.  针对网络连接配置网关设备。请注意，您必须在防火墙中[打开必需的端口和 IP 地址](cs_firewall.html#firewall_outbound)并针对子网[启用 VLAN 生成](cs_subnets.html#vra-routing)。
3.  通过包含 `--private-only` 标志，[使用 CLI 创建集群](cs_clusters.html#clusters_cli)。
4.  如果想要使用专用 NodePort、LoadBalancer 或 Ingress 服务向专用网络公开应用程序，请查看[针对仅专用 VLAN 设置规划专用外部联网](cs_network_planning.html#private_vlan)。该服务仅可供专用 IP 地址进行访问，必须在防火墙中配置端口以使用专用 IP 地址。


## 工作程序池和工作程序节点
{: #planning_worker_nodes}

Kubernetes 集群由分组成工作程序节点池的工作程序节点组成，并由 Kubernetes 主节点进行集中监视和管理。集群管理员决定如何设置工作程序节点的集群，以确保集群用户具备在集群中部署和运行应用程序所需的所有资源。
{:shortdesc}

创建标准集群时，会在 IBM Cloud Infrastructure (SoftLayer) 中代表您订购具有相同内存、CPU 和磁盘空间规格（类型模板）的工作程序节点，然后将其添加到集群中的缺省工作程序节点池。为每个工作程序节点分配唯一的工作程序节点标识和域名，在创建集群后，不得更改该标识和域名。您可以选择虚拟服务器或物理（裸机）服务器。根据选择的硬件隔离级别，可以将虚拟工作程序节点设置为共享或专用节点。要将不同的类型模板添加到集群，请[创建其他工作程序池](cs_cli_reference.html#cs_worker_pool_create)。

Kubernetes 限制了在一个集群中可以拥有的最大工作程序节点数。有关更多信息，请查看[工作程序节点和 pod 配额 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/setup/cluster-large/)。



## 工作程序节点的可用硬件
{: #shared_dedicated_node}

在 {{site.data.keyword.Bluemix_notm}} 中创建标准集群时，选择工作程序池包含的工作程序节点是物理机器（裸机）还是在物理硬件上运行的虚拟机。还可以选择工作程序节点类型模板，或者内存、CPU 和其他机器规格（例如，磁盘存储器）组合。
{:shortdesc}

![标准集群中工作程序节点的硬件选项](images/cs_clusters_hardware.png)

如果想要多个工作程序节点类型模板，那么必须为每个类型模板创建一个工作程序池。创建免费集群时，工作程序节点会自动作为 IBM Cloud Infrastructure (SoftLayer) 帐户中的虚拟共享节点进行供应。
在标准集群中，可以选择最适合工作负载的机器类型。规划时，请考虑有关总 CPU 和内存容量的[工作程序节点资源保留量](#resource_limit_node)。

可以使用[控制台 UI](cs_clusters.html#clusters_ui) 或 [CLI](cs_clusters.html#clusters_cli) 来部署集群。

选择以下一个选项以决定想要的工作程序池的类型。
* [虚拟机](#vm)
* [物理机器（裸机）](#bm)
* [软件定义的存储 (SDS) 机器](#sds)

### 虚拟机
{: #vm}

相对于裸机，使用虚拟机 (VM) 能以更具成本效益的价格获得更高灵活性、更短供应时间以及更多自动可扩展性功能。您可以将 VM 用于最通用的用例，例如测试和开发环境、编译打包和生产环境、微服务以及业务应用程序。但是，在性能方面会有所牺牲。如果需要针对 RAM 密集型、数据密集型或 GPU 密集型工作负载进行高性能计算，请使用[裸机](#bm)。
{: shortdesc}

**是想要共享还是专用硬件？**</br>
创建标准虚拟集群时，必须选择是希望底层硬件由多个 {{site.data.keyword.IBM_notm}} 客户共享（多租户）还是仅供您专用（单租户）。


* **在多租户、共享硬件设置中**：物理资源（如 CPU 和内存）在部署到同一物理硬件的所有虚拟机之间共享。要确保每个虚拟机都能独立运行，虚拟机监视器（也称为系统管理程序）会将物理资源分段成隔离的实体，并将其作为专用资源分配给虚拟机（系统管理程序隔离）。
* **在单租户、专用硬件设置中**：所有物理资源都仅供您专用。您可以将多个工作程序节点作为虚拟机部署在同一物理主机上。与多租户设置类似，系统管理程序也会确保每个工作程序节点在可用物理资源中获得应有的份额。

共享节点通常比专用节点更便宜，因为底层硬件的开销由多个客户分担。但是，在决定是使用共享还是专用节点时，可能需要咨询您的法律部门，以讨论应用程序环境所需的基础架构隔离和合规性级别。

**VM 有哪些常规功能部件？**</br>
虚拟机使用本地磁盘（而不是存储区联网 (SAN)）来实现可靠性。可靠性优势包括在将字节序列化到本地磁盘时可提高吞吐量，以及减少因网络故障而导致的文件系统降级。每个 VM 具备 1000Mbps 联网速度、用于操作系统文件系统的 25 GB 主本地磁盘存储和用于数据（例如，容器运行时和 `kubelet`）的 100 GB 辅助本地磁盘存储。工作程序节点上的本地存储器仅用于短期处理，更新或重新装入工作程序节点时将擦除主磁盘和辅助磁盘。对于持久性存储器解决方案，请参阅[规划高可用性持久性存储器](cs_storage_planning.html#storage_planning)。

**如果我拥有不推荐使用的 `u1c` 或 `b1c` 机器类型该怎么办？**</br>要开始使用 `u2c` 和 `b2c` 机器类型，请[通过添加工作程序节点来更新机器类型](cs_cluster_update.html#machine_type)。

**哪些虚拟机类型模板可用？**</br>
机器类型因专区而变化。要查看专区中可用的机器类型，请运行 `ibmcloud ks machine-types <zone>`. 您还可以复查可用[裸机](#bm)或 [SDS](#sds) 机器类型。

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中的可用虚拟机类型。</caption>
<thead>
<th>名称和用例</th>
<th>核心数/内存</th>
<th>主/辅助磁盘</th>
<th>网络速度</th>
</thead>
<tbody>
<tr>
<td><strong>虚拟，u2c.2x4</strong>：对于快速测试、概念验证和其他轻型工作负载，请使用此最小大小的 VM。</td>
<td>2 / 4 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>虚拟，b2c.4x16</strong>：对于测试和开发以及其他轻型工作负载，请选择此均衡的 VM。</td>
<td>4 / 16 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>虚拟，b2c.16x64</strong>：对于中型工作负载，请选择此均衡的 VM。</td></td>
<td>16 / 64 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>虚拟，b2c.32x128</strong>：对于中型到大型工作负载（例如，具有大量并发用户的数据库和动态 Web 站点），请选择此均衡的 VM。</td></td>
<td>32 / 128 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>虚拟，b2c.56x242</strong>：对于大型工作负载（例如，具有大量并发用户的数据库和多个应用程序），请选择此均衡的 VM。</td></td>
<td>56 / 242 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>虚拟，c2c.16x16</strong>：如果想要针对轻型工作负载完全均衡来自工作程序节点的计算资源，请使用此类型模板。</td></td>
<td>16 / 16GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr><tr>
<td><strong>虚拟，c2c.16x32</strong>：如果想要针对轻型到中型工作负载提供工作程序节点中比率为 1:2 的 CPU 和内存资源，请使用此类型模板。</td></td>
<td>16 / 32GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr><tr>
<td><strong>虚拟，c2c.32x32</strong>：如果想要针对中型工作负载完全均衡来自工作程序节点的计算资源，请使用此类型模板。</td></td>
<td>32 / 32GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr><tr>
<td><strong>虚拟，c2c.32x64</strong>：如果想要针对中型工作负载提供工作程序节点中比率为 1:2 的 CPU 和内存资源，请使用此类型模板。</td></td>
<td>32 / 64GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
</tbody>
</table>

### 物理机器（裸机）
{: #bm}

可以将工作程序节点作为单租户物理服务器（也称为裸机）进行供应。
{: shortdesc}

**裸机与 VM 有何不同？**</br>
通过裸机，您可以直接访问机器上的物理资源，例如内存或 CPU。此设置无需虚拟机系统管理程序将物理资源分配给在主机上运行的虚拟机。相反，裸机机器的所有资源都仅供工作程序专用，因此您无需担心“吵闹的邻居”共享资源或降低性能。物理机器类型的本地存储器大于虚拟机，并且某些类型具有用于提高数据可用性的 RAID。工作程序节点上的本地存储器仅用于短期处理，更新或重新装入工作程序节点时将擦除主磁盘和辅助磁盘。对于持久性存储器解决方案，请参阅[规划高可用性持久性存储器](cs_storage_planning.html#storage_planning)。

**除了更优秀的性能规格外，是否有些事情是裸机能做而 VM 无法做到的？**</br>
可以。利用裸机，可以选择启用“可信计算”来验证工作程序节点是否被篡改。如果在创建集群期间未启用信任，但希望日后启用，那么可以使用 `ibmcloud ks feature-enable` [命令](cs_cli_reference.html#cs_cluster_feature_enable)。启用信任后，日后无法将其禁用。可以创建不含信任的新集群。有关节点启动过程中的信任工作方式的更多信息，请参阅[具有可信计算的 {{site.data.keyword.containerlong_notm}}](cs_secure.html#trusted_compute)。可信计算可用于特定的裸机机器类型。运行 `ibmcloud ks machine-types <zone>` [命令](cs_cli_reference.html#cs_machine_types)后，可以通过查看 **Trustable** 字段来了解哪些机器支持信任。例如，`mgXc` GPU 类型模板不支持可信计算。

**裸机听起来很不错！现在，有什么阻止我订购？**</br>
裸机服务器比虚拟服务器更昂贵，最适用于需要更多资源和主机控制的高性能应用程序。

裸机服务器按月计费。如果您在月底之前取消裸机服务器，那么仍将收取该整月的费用。订购和取消裸机服务器是通过 IBM Cloud Infrastructure (SoftLayer) 帐户进行的手动过程。完成此过程可能需要超过一个工作日的时间。
{: important}

**我可订购哪些裸机类型模板？**</br>
机器类型因专区而变化。要查看专区中可用的机器类型，请运行 `ibmcloud ks machine-types <zone>`. 您还可以复查可用 [VM](#vm) 或 [SDS](#sds) 机器类型。

裸机针对不同用例进行了优化，例如，RAM 密集型、数据密集型或 GPU 密集型工作负载。

选择具有正确的存储配置的机器类型以支持您的工作负载。一些类型模板具有以下磁盘和存储配置的组合。例如，一些类型模板可能具有一个 SATA 主磁盘以及一个原始 SSD 辅助磁盘。

* **SATA**：磁性旋转磁盘存储设备，通常用于存储操作系统文件系统的工作程序节点的主磁盘。
* **SSD**：用于高性能数据的固态驱动器存储设备。
* **原始**：存储设备未进行格式化，全部容量可供使用。
* **RAID**：存储设备针对冗余和高性能分布数据，根据 RAID 级别的不同而变化。例如，可供使用的磁盘容量会有所不同。


<table>
<caption>{{site.data.keyword.containerlong_notm}} 中的可用裸机类型。</caption>
<thead>
<th>名称和用例</th>
<th>核心数/内存</th>
<th>主/辅助磁盘</th>
<th>网络速度</th>
</thead>
<tbody>
<tr>
<td><strong>RAM 密集型裸机，mr1c.28x512</strong>：最大限度提高可用于工作程序节点的 RAM。</td>
<td>28 / 512 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>GPU 裸机，mg1c.16x128</strong>：对于数学密集型工作负载（例如，高性能计算、机器学习或 3D 应用程序），请选择此类型。此类型模板有 1 块 Tesla K80 物理卡，每块卡有 2 个图形处理单元 (GPU)，共有 2 个 GPU。</td>
<td>16 / 128 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>GPU 裸机，mg1c.28x256</strong>：对于数学密集型工作负载（例如，高性能计算、机器学习或 3D 应用程序），请选择此类型。此类型模板有 2 块 Tesla K80 物理卡，每块卡有 2 个 GPU，共有 4 个 GPU。</td>
<td>28 / 256 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>数据密集型裸机，md1c.16x64.4x4tb</strong>：要将大量本地磁盘存储（包括用于提高数据可用性的 RAID）用于分布式文件系统、大型数据库和大数据分析等工作负载，请使用此类型。</td>
<td>16 / 64 GB</td>
<td>2 个 2 TB RAID1 / 4 个 4 TB SATA RAID10</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>数据密集型裸机，md1c.28x512.4x4tb</strong>：要将大量本地磁盘存储（包括用于提高数据可用性的 RAID）用于分布式文件系统、大型数据库和大数据分析等工作负载，请使用此类型。</td>
<td>28 / 512 GB</td>
<td>2 个 2 TB RAID1 / 4 个 4 TB SATA RAID10</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>均衡裸机，mb1c.4x32</strong>：用于需要的计算资源比虚拟机所提供的计算资源更多的均衡工作负载。</td>
<td>4 / 32 GB</td>
<td>2 TB SATA / 2 TB SATA</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>均衡裸机，mb1c.16x64</strong>：用于需要的计算资源比虚拟机所提供的计算资源更多的均衡工作负载。</td>
<td>16 / 64 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
</tbody>
</table>

### 软件定义的存储 (SDS) 机器
{: #sds}

软件定义的存储 (SDS) 类型模板是供应有物理本地存储的其他原始磁盘的物理机器。与本地主磁盘和本地辅助磁盘不同，这些原始磁盘在工作节点更新或重新装入期间不会被擦除。因为数据与计算节点并存，SDS 机器适合高性能工作负载。
{: shortdesc}

**何时使用 SDS 类型模板？**</br>
在下列情况下，通常使用 SDS 机器：
*  如果对集群使用 SDS 附加组件，请使用 SDS 机器。
*  如果应用程序是需要本地存储器的 [StatefulSet ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)，那么可使用 SDS 机器并供应 [Kubernetes 本地持久性卷 (beta) ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/blog/2018/04/13/local-persistent-volumes-beta/)。
*  您可能具有需要其他原始本地存储器的定制应用程序。

有关更多存储解决方案的信息，请参阅[规划高可用性持久性存储器](cs_storage_planning.html#storage_planning)。

**我可订购哪些 SDS 类型模板？**</br>
机器类型因专区而变化。要查看专区中可用的机器类型，请运行 `ibmcloud ks machine-types <zone>`. 您还可以复查可用[裸机](#bm)或 [VM](#vm) 机器类型。

选择具有正确的存储配置的机器类型以支持您的工作负载。一些类型模板具有以下磁盘和存储配置的组合。例如，一些类型模板可能具有一个 SATA 主磁盘以及一个原始 SSD 辅助磁盘。

* **SATA**：磁性旋转磁盘存储设备，通常用于存储操作系统文件系统的工作程序节点的主磁盘。
* **SSD**：用于高性能数据的固态驱动器存储设备。
* **原始**：存储设备未进行格式化，全部容量可供使用。
* **RAID**：存储设备针对冗余和高性能分布数据，根据 RAID 级别的不同而变化。例如，可供使用的磁盘容量会有所不同。


<table>
<caption>{{site.data.keyword.containerlong_notm}} 中的可用 SDS 机器类型。</caption>
<thead>
<th>名称和用例</th>
<th>核心数/内存</th>
<th>主/辅助磁盘</th>
<th>其他原始磁盘</th>
<th>网络速度</th>
</thead>
<tbody>
<tr>
<td><strong>具有 SDS 的裸机，ms2c.4x32.1.9tb.ssd</strong>：如果需要额外的本地存储器以获取性能，请使用支持软件定义的存储 (SDS) 的这一磁盘密集型类型模板。</td>
<td>4 / 32 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>1.9 TB 原始 SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>具有 SDS 的裸机，ms2c.16x64.1.9tb.ssd</strong>：如果需要额外的本地存储器以获取性能，请使用支持软件定义的存储 (SDS) 的这一磁盘密集型类型模板。</td>
<td>16 / 64 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>1.9 TB 原始 SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>具有 SDS 的裸机，ms2c.28x256.3.8tb.ssd</strong>：如果需要额外的本地存储器以获取性能，请使用支持软件定义的存储 (SDS) 的这一磁盘密集型类型模板。</td>
<td>28 / 256 GB</td>
<td>2TB SATA / 1.9TB SSD</td>
<td>3.8TB 原始 SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>具有 SDS 的裸机，ms2c.28x512.4x3.8tb.ssd</strong>：如果需要额外的本地存储器以获取性能，请使用支持软件定义的存储 (SDS) 的这一磁盘密集型类型模板。</td>
<td>28 / 512 GB</td>
<td>2TB SATA / 1.9TB SSD</td>
<td>4 个磁盘，3.8TB 原始 SSD</td>
<td>10000 Mbps</td>
</tr>
</tbody>
</table>

## 工作程序节点资源保留量
{: #resource_limit_node}

{{site.data.keyword.containerlong_notm}} 会设置计算资源保留量，用于限制每个工作程序节点上的可用计算资源。保留的内存和 CPU 资源不能由工作程序节点上的 pod 使用，因此每个工作程序节点上的可分配资源会变少。最初部署 pod 时，如果工作程序节点没有足够的可分配资源，部署会失败。此外，如果 pod 超过工作程序节点资源限制，那么会逐出这些 pod。在 Kubernetes 中，此限制称为[硬逐出阈值 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds)。
{:shortdesc}

如果可用的 CPU 或内存少于工作程序节点保留量，Kubernetes 会开始逐出 pod，以复原足够的计算资源。如果有其他工作程序节点可用，那么 pod 会重新安排到该工作程序节点上。如果频繁逐出 pod，请向集群添加更多工作程序节点，或者对 pod 设置[资源限制 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container)。

在工作程序节点上保留的资源取决于工作程序节点随附的 CPU 和内存量。{{site.data.keyword.containerlong_notm}} 定义了内存和 CPU 层，如下表中所示。如果工作程序节点随附多个层中的计算资源，那么将为每个层保留一定百分比的 CPU 和内存资源。

要查看工作程序节点上当前使用的计算资源量，请运行 [`kubectl top node` ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/#top)。
{: tip}

<table summary="工作程序节点内存保留量（按层）。">
<caption>工作程序节点内存保留量（按层）。</caption>
<thead>
<tr>
  <th>内存层</th>
  <th>保留的 % 或保留量</th>
  <th>`b2c.4x16` 工作程序节点 (16 GB) 示例</th>
  <th>`mg1c.28x256` 工作程序节点 (256 GB) 示例</th>
</tr>
</thead>
<tbody>
<tr>
  <td>前 16 GB (0-16 GB)</td>
  <td>10% 的内存</td>
  <td>1.6 GB</td>
  <td>1.6 GB</td>
</tr>
<tr>
  <td>接下来 112 GB (17-128 GB)</td>
  <td>6% 的内存</td>
  <td>不适用</td>
  <td>6.72 GB</td>
</tr>
<tr>
  <td>剩余 GB（129 GB 及更多）</td>
  <td>2% 的内存</td>
  <td>不适用</td>
  <td>2.54 GB</td>
</tr>
<tr>
  <td>用于 [`kubelet` 逐出 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/) 的其他保留量</td>
  <td>100 MB</td>
  <td>100 MB（固定量）</td>
  <td>100 MB（固定量）</td>
</tr>
<tr>
  <td>**总保留量**</td>
  <td>**（变化）**</td>
  <td>**1.7 GB，共 16 GB**</td>
  <td>**10.96 GB，共 256 GB**</td>
</tr>
</tbody>
</table>

<table summary="工作程序节点 CPU 保留量（按层）。">
<caption>工作程序节点 CPU 保留量（按层）。</caption>
<thead>
<tr>
  <th>CPU 层</th>
  <th>保留的 %</th>
  <th>`b2c.4x16` 工作程序节点（4 个核心）示例</th>
  <th>`mg1c.28x256` 工作程序节点（28 个核心）示例</th>
</tr>
</thead>
<tbody>
<tr>
  <td>第 1 个核心（核心 1）</td>
  <td>6% 的核心</td>
  <td>0.06 的核心</td>
  <td>0.06 的核心</td>
</tr>
<tr>
  <td>后 2 个核心（核心 2-3）</td>
  <td>1% 的核心</td>
  <td>0.02 的核心</td>
  <td>0.02 的核心</td>
</tr>
<tr>
  <td>后 2 个核心（核心 4-5）</td>
  <td>0.5% 的核心</td>
  <td>0.005 的核心</td>
  <td>0.01 的核心</td>
</tr>
<tr>
  <td>剩余核心（核心 6 及更多核心）</td>
  <td>0.25% 的核心</td>
  <td>不适用</td>
  <td>0.0575 的核心</td>
</tr>
<tr>
  <td>**总保留量**</td>
  <td>**（变化）**</td>
  <td>**0.085 的核心，共 4 个核心**</td>
  <td>**0.1475 的核心，共 28 个核心**</td>
</tr>
</tbody>
</table>

## 自动恢复工作程序节点
{: #autorecovery}

关键组件（例如，`containerd`、`kubelet`、`kube-proxy` 和 `calico`）必须正常运行才能拥有正常运行的 Kubernetes 工作程序节点。随着时间变化，这些组件可能会中断，这可能使工作程序节点处于非正常运行状态。非正常运行的工作程序节点会使集群总容量下降，并可能导致应用程序产生停机时间。
{:shortdesc}

可以[为工作程序节点配置运行状况检查并启用自动恢复](cs_health.html#autorecovery)。如果自动恢复根据配置的检查，检测到运行状况欠佳的工作程序节点，那么自动恢复会触发更正操作，例如在工作程序节点上重装操作系统。有关自动恢复的工作方式的更多信息，请参阅[自动恢复博客 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。

<br />

