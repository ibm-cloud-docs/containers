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





# 更新集群、工作程序节点和附加组件
{: #update}

可以通过安装更新，使 {{site.data.keyword.containerlong}} 中的 Kubernetes 集群保持最新。
{:shortdesc}

## 更新 Kubernetes 主节点
{: #master}

Kubernetes 会定期发布[主要更新、次要更新或补丁更新](cs_versions.html#version_types)。更新会影响 Kubernetes 主节点中的 Kubernetes API 服务器版本或其他组件。IBM 会更新补丁版本，但主节点的主版本和次版本必须由您进行更新。
{:shortdesc}

**如何知道何时更新主节点？**</br>
更新可用时，您会在 GUI 和 CLI 中收到相关通知，此外还可以查看[支持的版本](cs_versions.html)页面。

**主节点可以落后于最新版本多少个版本？**</br>
IBM 通常在给定时间支持 3 个版本的 Kubernetes。更新 Kubernetes API 服务器时，可以更新的版本不能超过其当前版本的 2 个版本。

例如，如果当前 Kubernetes API 服务器的版本是 1.7，而您要更新到 1.10，那么必须先更新到 1.8 或 1.9。可以强制更新执行，但跨三个或三个以上的次版本更新可能会导致意外结果或失败。

如果集群运行的是不支持的 Kubernetes 版本，那么可能必须强制执行此更新。因此，请使集群保持最新，以避免操作影响。

**工作程序节点能否运行高于主节点的版本？**</br>
不能。请首先[更新主节点](#update_master)至最新的 Kubernetes 版本。然后，在集群中[更新工作程序节点](#worker_node)。与主节点不同的是，您还必须为工作程序更新每个补丁版本。

**主节点更新期间会发生什么情况？**</br>
更新 Kubernetes API 服务器时，该 API 服务器将关闭约 5 到 10 分钟。在更新期间，您无法访问或更改集群。但是，不会修改集群用户已部署的工作程序节点、应用程序和资源，并继续运行。

**可以回滚更新吗？**</br>
不能，在执行更新过程后，无法将集群回滚到先前版本。请确保使用测试集群并遵循指示信息来解决潜在问题，然后再更新生产主节点。

**更新主节点时可以遵循什么流程？**</br>
下图显示更新主节点时可以执行的流程。

![主节点更新最佳实践](/images/update-tree.png)

图 1. Kubernetes 主节点更新流程图

{: #update_master}
要更新 Kubernetes 主节点的_主_版本或_次_版本，请执行以下操作：

1.  查看 [Kubernetes 更改](cs_versions.html)，并对任何更新标记为_在更新主节点之前更新_。

2.  使用 GUI 或运行 CLI `ibmcloud ks cluster-update` [命令](cs_cli_reference.html#cs_cluster_update)来更新 Kubernetes API 服务器和关联的 Kubernetes 主节点组件。

3.  稍等几分钟，然后确认更新是否已完成。在 {{site.data.keyword.Bluemix_notm}}“仪表板”上查看 Kubernetes API 服务器版本，或运行 `ibmcloud ks clusters`。

4.  安装与 Kubernetes 主节点中运行的 Kubernetes API 服务器版本相匹配的 [`kubectl cli`](cs_cli_install.html#kubectl) 版本。

Kubernetes API 服务器更新完成后，可以更新工作程序节点。

<br />


## 更新工作程序节点
{: #worker_node}

您收到了工作程序节点更新通知。这意味着什么呢？由于 Kubernetes API 服务器和其他 Kubernetes 主节点组件的安全性更新和补丁已到位，因此您必须确保工作程序节点保持同步。
{: shortdesc}

开始之前：
- [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。
- [更新 Kubernetes 主节点](#master)。工作程序节点 Kubernetes 版本不能高于在 Kubernetes 主节点中运行的 Kubernetes API 服务器版本。
- 落实在 [Kubernetes 更改](cs_versions.html)中标记为_在主节点后更新_的任何更改。
- 如果要应用补丁更新，请查看 [Kubernetes 版本更改日志](cs_versions_changelog.html#changelog)。</br>

**注意**：更新工作程序节点可能会导致应用程序和服务产生停机时间。如果数据未[存储在 pod 外部](cs_storage_planning.html#persistent_storage_overview)，那么将删除数据。


**更新期间应用程序会发生什么情况？**</br>
如果在更新的工作程序节点上作为部署的一部分运行应用程序，那么会将应用程序重新安排到集群中的其他工作程序节点上。这些工作程序节点可能位于其他工作程序池中，或者如果您具有独立工作程序节点，那么可能会将应用程序安排到独立工作程序节点上。要避免应用程序产生停机时间，必须确保集群中有足够的容量来执行工作负载。

**如何控制更新期间在给定时间停止运行的工作程序节点数？**
如果需要所有工作程序节点都启动并运行，请考虑通过[调整工作程序池大小](cs_cli_reference.html#cs_worker_pool_resize)或[添加独立工作程序节点](cs_cli_reference.html#cs_worker_add)来添加更多工作程序节点。可以在更新完成后除去其他工作程序节点。

此外，还可以创建 Kubernetes 配置映射，用于指定在更新期间可以同时不可用的最大工作程序节点数。工作程序节点通过工作程序节点标签进行标识。可以使用 IBM 提供的标签，也可以使用已添加到工作程序节点的定制标签。

**如果选择不定义配置映射会怎样？**</br>
未定义配置映射时，将使用缺省值。缺省情况下，在更新过程中，每个集群的所有工作程序节点中最多可以有 20% 的节点不可用。

要创建配置映射并更新工作程序节点，请执行以下操作：

1.  列出可用的工作程序节点，并记录其专用 IP 地址。

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2. 查看工作程序节点的标签。可以在 CLI 输出的 **Labels** 部分找到工作程序节点标签。每个标签都由 `NodeSelectorKey` 和 `NodeSelectorValue` 组成。
   ```
   kubectl describe node <private_worker_IP>
   ```
   {: pre}

   输出示例：
   ```
   Name:               10.184.58.3
   Roles:              <none>
   Labels:             arch=amd64
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    failure-domain.beta.kubernetes.io/region=us-south
                    failure-domain.beta.kubernetes.io/zone=dal12
                    ibm-cloud.kubernetes.io/encrypted-docker-data=true
                    ibm-cloud.kubernetes.io/iaas-provider=softlayer
                    ibm-cloud.kubernetes.io/machine-type=u2c.2x4.encrypted
                    kubernetes.io/hostname=10.123.45.3
                    privateVLAN=2299001
                    publicVLAN=2299012
   Annotations:        node.alpha.kubernetes.io/ttl=0
                    volumes.kubernetes.io/controller-managed-attach-detach=true
   CreationTimestamp:  Tue, 03 Apr 2018 15:26:17 -0400
   Taints:             <none>
   Unschedulable:      false
   ```
   {: screen}

3. 创建配置映射，并定义工作程序节点的不可用性规则。以下示例显示了 4 个检查：`zonecheck.json`、`regioncheck.json` 和 `defaultcheck.json` 和一个检查模板。可以使用这些示例检查来为特定专区中的工作程序节点定义规则 (`zonechk.json`)、为区域中的工作程序节点定义规则 (`regioncheck.json`)，或为与在配置映射中定义的任何检查不匹配的所有工作程序节点定义规则 (`defaultcheck.json`)。使用检查模板可创建自己的检查。对于每个检查，要识别工作程序节点，必须选择在上一步中检索到的其中一个工作程序节点标签。  

   **注：**对于每个检查，只能为 <code>NodeSelectorKey</code> 和 <code>NodeSelectorValue</code> 设置一个值。如果要为多个区域、专区或其他工作程序节点标签设置规则，请创建新的检查。在配置映射中最多可定义 10 个检查。如果添加更多检查，将忽略这些检查。

   示例：
   ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     drain_timeout_seconds: "120"
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 30,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
        "NodeSelectorValue": "dal13"
      }
    regioncheck.json: |
       {
         "MaxUnavailablePercentage": 20,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
        "NodeSelectorValue": "us-south"
      }
    defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 20
      }
    <check_name>: |
      {
        "MaxUnavailablePercentage": <value_in_percentage>,
        "NodeSelectorKey": "<node_selector_key>",
        "NodeSelectorValue": "<node_selector_value>"
      }
   ```
   {:pre}

   <table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是参数，第二列是匹配的描述。">
    <caption>ConfigMap 组成部分</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解组成部分</th>
    </thead>
    <tbody>
      <tr>
        <td><code>drain_timeout_seconds</code></td>
        <td> 可选：等待[放弃 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/) 完成的超时（以秒为单位）。放弃工作程序节点可安全地从工作程序节点中除去所有现有 pod，然后将这些 pod 重新安排到集群中的其他工作程序节点上。接受的值为 1 到 180 之间的整数。缺省值为 30。</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td>两个检查，用于为一组工作程序节点定义规则，可以使用指定的 <code>NodeSelectorKey</code> 和 <code>NodeSelectorValue</code> 标识工作程序节点。<code>zonecheck.json</code> 根据工作程序节点的专区标签来识别工作程序节点，<code>regioncheck.json</code> 使用在供应期间添加到每个工作程序节点的区域标签。在此示例中，更新期间，将 <code>dal13</code> 作为其专区标签的所有工作程序节点中，可以有 30% 不可用，<code>us-south</code> 中的所有工作程序节点中，可以有 20% 不可用。</td>
      </tr>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td>如果未创建配置映射或未正确配置映射，那么会应用 Kubernetes 缺省值。缺省情况下，在给定时间，集群中只能有 20% 的工作程序节点不可用。您可以通过向配置映射添加缺省检查来覆盖缺省值。在此示例中，专区和区域检查（<code>dal13</code> 或 <code>us-south</code>）中未指定的每个工作程序节点在更新期间都可以不可用。</td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td>对于指定的标签键和值，允许不可用的最大节点数，指定为百分比。工作程序节点在部署、重新装入或供应过程中会不可用。如果排队的工作程序节点超过任何定义的最大不可用百分比，那么会阻止这些节点更新。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td>要为其设置规则的工作程序节点的标签键。可以为 IBM 提供的缺省标签以及您创建的工作程序节点标签设置规则。<ul><li>如果要为属于一个工作程序池的工作程序节点添加规则，可以使用 <code>ibm-cloud.kubernetes.io/machine-type</code> 标签。</li><li> 如果有多个具有相同机器类型的工作程序池，请使用定制标签。</li></ul></td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td>必须为定义的规则考虑工作程序节点的标签值。</td>
      </tr>
    </tbody>
   </table>

4. 在集群中创建配置映射。
   ```
   kubectl apply -f <filepath/configmap.yaml>
   ```
   {: pre}

5. 验证配置映射是否已创建。
   ```
   kubectl get configmap --namespace kube-system
   ```
   {: pre}

6.  更新工作程序节点。

    ```
    ibmcloud ks worker-update <cluster_name_or_ID> <worker_node1_ID> <worker_node2_ID>
    ```
    {: pre}

7. 可选：验证由配置映射触发的事件以及发生的任何验证错误。可以在 CLI 输出的 **Events** 部分中查看这些事件。
   ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
   {: pre}

8. 通过复查工作程序节点的 Kubernetes 版本，确认更新是否已完成。  
   ```
kubectl get nodes
```
   {: pre}

9. 验证是否没有重复的工作程序节点。在某些情况下，较旧的集群可能会在更新后列出具有 **NotReady** 状态的重复工作程序节点。要除去重复项，请参阅[故障诊断](cs_troubleshoot_clusters.html#cs_duplicate_nodes)。

后续步骤：
  - 对其他工作程序池重复更新过程。
  - 通知在集群中工作的开发者将其 `kubectl` CLI 更新到 Kubernetes 主节点的版本。
  - 如果 Kubernetes 仪表板未显示利用率图形，请[删除 `kube-dashboard` pod](cs_troubleshoot_health.html#cs_dashboard_graphs)。

<br />



## 更新机器类型
{: #machine_type}

可以通过添加新工作程序节点并除去旧工作程序节点来更新工作程序节点的机器类型。例如，如果在其名称中含有 `u1c` 或 `b1c` 的不推荐机器类型上具有虚拟工作程序节点，请创建使用其名称中含有 `u2c` 或 `b2c` 的机器类型的工作程序节点。
{: shortdesc}

开始之前：
- [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。
- 如果是将数据存储在工作程序节点上，而没有[存储在工作程序节点外部](cs_storage_planning.html#persistent_storage_overview)，那么将删除数据。


**注意**：更新工作程序节点可能会导致应用程序和服务产生停机时间。如果数据未[存储在 pod 外部](cs_storage_planning.html#persistent_storage_overview)，那么将删除数据。

1. 列出可用的工作程序节点，并记录其专用 IP 地址。
   - **对于工作程序池中的工作程序节点**：
     1. 列出集群中的可用工作程序池。
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

     2. 列出工作程序池中的工作程序节点。
        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
        ```
        {: pre}

     3. 获取工作程序节点的详细信息，并记录专区、专用和公用 VLAN 标识。
        ```
        ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>
        ```
        {: pre}

   - **不推荐：对于独立工作程序节点**：
        
     1. 列出可用的工作程序节点。
        ```
        ibmcloud ks workers <cluster_name_or_ID>
        ```
        {: pre}

     2. 获取工作程序节点的详细信息，并记录专区、专用和公用 VLAN 标识。
        ```
        ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>
        ```
        {: pre}

2. 列出专区中可用的机器类型。
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

3. 创建具有新机器类型的工作程序节点。
   - **对于工作程序池中的工作程序节点**：
     1. 创建工作程序池，其中的工作程序节点数与要替换的节点数相同。
        ```
        ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
        ```
        {: pre}

     2. 验证工作程序池是否已创建。
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

     3. 将专区添加到先前检索到的工作程序池。添加专区时，工作程序池中定义的工作程序节点将在专区中供应，并考虑用于未来的工作负载安排。如果要跨多个专区分布工作程序节点，请选择[支持多专区的专区](cs_regions.html#zones)。
        ```
        ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
        ```
        {: pre}

   - **不推荐：对于独立工作程序节点**：
       ```
       ibmcloud ks worker-add --cluster <cluster_name> --machine-type <machine_type> --number <number_of_worker_nodes> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
       ```
       {: pre}

4. 等待工作程序节点进行部署。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

   工作程序节点的状态更改为 **Normal** 时，说明部署完成。

5. 除去旧的工作程序节点。**注**：如果要除去按月计费的机器类型（如裸机），那么仍将对整个月收费。
   - **对于工作程序池中的工作程序节点**：
     1. 除去具有旧机器类型的工作程序池。除去工作程序池将除去所有专区中该池中的所有工作程序节点。此过程可能需要几分钟才能完成。
        ```
        ibmcloud ks worker-pool-rm --worker-pool <pool_name> --cluster <cluster_name_or_ID>
        ```
        {: pre}

     2. 验证工作程序池是否已除去。
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

   - **不推荐：对于独立工作程序节点**：
      ```
      ibmcloud ks worker-rm <cluster_name> <worker_node>
      ```
      {: pre}

6. 验证工作程序节点是否已从集群中除去。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

7. 重复这些步骤以将其他工作程序池或独立工作程序节点更新到不同的机器类型。

## 更新集群附加组件
{: #addons}

{{site.data.keyword.containerlong_notm}} 集群随附在供应集群时自动安装的**附加组件**，例如用于日志记录的 Fluentd。这些附加组件必须独立于主节点和工作程序节点进行更新。
{: shortdesc}

**必须单独更新集群中的哪些缺省附加组件？**
* [用于日志记录的 Fluentd](#logging)

**是否存在不需要更新且无法更改的附加组件？**</br>
是的，集群部署有以下无法更改的受管附加组件以及关联资源。如果尝试更改下列其中一个部署附加组件，其原始设置会定期复原。 

* `heapster`
* `ibm-file-plugin`
* `ibm-storage-watcher`
* `ibm-keepalived-watcher`
* `kube-dns-amd64`
* `kube-dns-autoscaler`
* `kubernetes-dashboard`
* `vpn`

您可以使用 `addonmanager.kubernetes.io/mode: Reconcile` 标签来查看这些资源。例如：

```
kubectl get deployments --all-namespaces -l addonmanager.kubernetes.io/mode=Reconcile
```
{: pre}

**可以安装其他非缺省附加组件吗？**</br>
可以。{{site.data.keyword.containerlong_notm}} 提供了其他附加组件，您可以选择这些附加组件以向集群添加功能。例如，您可能希望[使用 Helm 图表](cs_integrations.html#helm)来安装[块存储器插件](cs_storage_block.html#install_block)、[Istio](cs_tutorials_istio.html#istio_tutorial) 或 [strongSwan VPN](cs_vpn.html#vpn-setup)。您必须通过遵循指示信息来更新 Helm 图表，从而分别更新每个附加组件。

### 用于日志记录的 Fluentd
{: #logging}

为了对日志记录或过滤器配置进行更改，Fluentd 附加组件必须为最新版本。缺省情况下，会启用附加组件的自动更新。
{: shortdesc}

可以通过运行 `ibmcloud ks logging-autoupdate-get --cluster <cluster_name_or_ID>` [命令](cs_cli_reference.html#cs_log_autoupdate_get)来检查是否启用了自动更新。

要禁用自动更新，请运行 `ibmcloud ks logging-autoupdate-disable` [命令](cs_cli_reference.html#cs_log_autoupdate_disable)。

如果禁用了自动更新，但您需要对配置进行更改，那么有两个选项。

*  启用 Fluentd pod 的自动更新。

    ```
    ibmcloud ks logging-autoupdate-enable --cluster <cluster_name_or_ID>
    ```
    {: pre}

*  使用包含 `--force-update` 选项的日志记录命令时，强制执行一次性更新。**注**：pod 会更新到最新版本的 Fluentd 附加组件，但 Fluentd 此后不会自动更新。

    示例命令：

    ```
    ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> --id <log_config_ID> --type <log_type> --force-update
    ```
    {: pre}

## 从独立工作程序节点更新到工作程序池
{: #standalone_to_workerpool}

通过引入多专区集群，可将具有相同配置（如机器类型）的工作程序节点分组到工作程序池中。创建新集群时，会自动创建名为 `default` 的工作程序池。
{: shortdesc}

可以使用工作程序池在专区之间均匀分布工作程序节点，并构建均衡的集群。均衡的集群具有更高可用性，对故障的弹性也更高。如果从专区中除去工作程序节点，那么可以重新均衡工作程序池，并自动为该专区供应新的工作程序节点。工作程序池还用于将 Kubernetes 版本更新安装到所有工作程序节点。  

**重要信息：**如果在多专区集群可用之前创建了集群，那么工作程序节点仍然独立，而不会自动分组到工作程序池中。您必须更新这些集群才能使用工作程序池。如果未更新，那么不能将单专区集群更改为多专区集群。

查看下图以了解从独立工作程序节点移至工作程序池时，集群设置如何更改。

<img src="images/cs_cluster_migrate.png" alt="“将集群从独立工作程序节点更新到工作程序池" width="600" style="width:600px; border-style: none"/>

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

1. 列出集群中的现有独立工作程序节点，并记录 **ID**、**Machine Type** 和 **Private IP**。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

2. 创建工作程序池，并确定要添加到该池的机器类型和工作程序节点数。
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

3. 列出可用专区，并确定要供应工作程序池中工作程序节点的位置。要查看供应独立工作程序节点的专区，请运行 `ibmcloud ks cluster-get <cluster_name_or_ID>`. 如果要跨多个专区分布工作程序节点，请选择[支持多专区的专区](cs_regions.html#zones)。
   ```
   ibmcloud ks zones
   ```
   {: pre}

4. 列出在上一步中选择的专区的可用 VLAN。如果在该专区中尚未有 VLAN，那么在将该专区添加到工作程序池时，会自动创建 VLAN。
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

5. 将专区添加到工作程序池。将专区添加到工作程序池时，工作程序池中定义的工作程序节点将在专区中供应，并考虑用于未来的工作负载安排。{{site.data.keyword.containerlong}} 会自动将区域的 `failure-domain.beta.kubernetes.io/region` 标签和专区的 `failure-domain.beta.kubernetes.io/zone` 标签添加到每个工作程序节点。Kubernetes 调度程序使用这些标签在同一区域内的各个专区之间分布 pod。
   1. **将一个专区添加到一个工作程序池**：将 `<pool_name>` 替换为工作程序池的名称，并使用先前检索到的信息来填写集群标识、专区和 VLAN。如果在该专区中没有专用和公用 VLAN，请勿指定此选项。系统将自动创建专用和公用 VLAN。

      如果要对不同工作程序池使用不同的 VLAN，请对每个 VLAN 及其相应的工作程序池重复此命令。任何新的工作程序节点都会添加到指定的 VLAN，但不会更改任何现有工作程序节点的 VLAN。
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   2. **将该专区添加到多个工作程序池**：将多个工作程序池添加到 `ibmcloud ks zone-add` 命令。要将一个专区添加到多个工作程序池，必须在该专区中具有现有专用和公用 VLAN。如果在该专区中没有公用和专用 VLAN，请考虑首先将该专区添加到一个工作程序池，以便创建公用和专用 VLAN。然后，可以将该专区添加到其他工作程序池。</br></br>务必将所有工作程序池中的工作程序节点供应到所有专区中，以确保集群可跨专区均衡。如果要对不同工作程序池使用不同的 VLAN，请对要用于工作程序池的 VLAN 重复此命令。如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](cs_users.html#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果使用 {{site.data.keyword.BluDirectLink}}，那么必须改为使用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。要启用 VRF，请联系 IBM Cloud infrastructure (SoftLayer) 帐户代表。
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name1,pool_name2,pool_name3> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   3. **将多个专区添加到多个工作程序池**：使用不同专区重复 `ibmcloud ks zone-add` 命令，并指定要在该专区中供应的工作程序池。通过向集群添加更多专区，可将集群从单专区集群更改为[多专区集群](cs_clusters_planning.html#multizone)。

6. 等待工作程序节点在每个专区中进行部署。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}
   工作程序节点的状态更改为 **Normal** 时，说明部署完成。

7. 除去独立工作程序节点。如果有多个独立工作程序节点，请一次除去一个。
   1. 列出集群中的工作程序节点，并将此命令中的专用 IP 地址与在开始时检索到的专用 IP 地址进行比较，以找到独立工作程序节点。
      ```
kubectl get nodes
```
      {: pre}
   2. 在称为“封锁”的过程中将工作程序节点标记为不可安排。封锁工作程序节点后，该节点即不可用于未来的 pod 安排。请使用 `kubectl get nodes` 命令中返回的 `name`。
      ```
   kubectl cordon <worker_name>
   ```
      {: pre}
   3. 验证是否已对工作程序节点禁用了 pod 安排。
      ```
kubectl get nodes
```
      {: pre}
   如果阶段状态显示为 **SchedulingDisabled**，说明已禁止工作程序节点用于 pod 安排。

   4. 强制从独立工作程序节点中除去 pod，并将其重新安排到剩余的未封锁独立工作程序节点以及工作程序池中的工作程序节点上。
      ```
      kubectl drain <worker_name> --ignore-daemonsets
      ```
      {: pre}
此过程可能需要几分钟时间。

   5. 除去独立工作程序节点。使用通过 `ibmcloud ks workers <cluster_name_or_ID>` 命令检索到的工作程序节点的标识。
      ```
      ibmcloud ks worker-rm <cluster_name_or_ID> <worker_ID>
      ```
      {: pre}
   6. 重复这些步骤，直到除去所有独立工作程序节点。


**接下来要做什么？**
</br>
现在，您已将集群更新为使用工作程序池，因此可以通过向集群添加更多专区来提高可用性。通过向集群添加更多专区，可将集群从单专区集群更改为[多专区集群](cs_clusters_planning.html#ha_clusters)。将单专区集群更改为多专区集群时，Ingress 域会从 `<cluster_name>.<region>.containers.mybluemix.net` 更改为 `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`。现有 Ingress 域仍然有效，可用于向应用程序发送请求。
