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


# 更新集群和工作程序节点
{: #update}

## 更新 Kubernetes 主节点
{: #master}

Kubernetes 会定期发布更新。这可能是[主要更新、次要更新或补丁更新](cs_versions.html#version_types)。根据更新类型，您可能要负责更新 Kubernetes 主节点。使工作程序节点保持最新始终是您的责任。进行更新时，会先更新 Kubernetes 主节点，后更新工作程序节点。
{:shortdesc}

缺省情况下，您最多只能跨当前版本 Kubernetes 主节点的两个次版本进行更新。例如，如果当前主节点的版本是 1.5，而您要更新到 1.8，那么必须先更新到 1.7。可以强制更新执行，但跨两个以上的次版本更新可能会导致意外结果。

下图显示更新主节点时可以执行的流程。

![主节点更新最佳实践](/images/update-tree.png)

图 1. Kubernetes 主节点更新流程图

**注意**：一旦执行更新过程后，即不能将集群回滚到先前版本。请确保使用测试集群并遵循指示信息来解决潜在问题，然后再更新生产主节点。

对于_主要_或_次要_更新，请完成以下步骤：

1. 查看 [Kubernetes 更改](cs_versions.html)，并对任何更新标记为_在更新主节点之前更新_。
2. 使用 GUI 或运行 [CLI 命令](cs_cli_reference.html#cs_cluster_update)来更新 Kubernetes 主节点。当您更新 Kubernetes 主节点时，主节点将关闭约 5 到 10 分钟。在更新期间，您无法访问或更改集群。但是，不会修改集群用户已部署的工作程序节点、应用程序和资源，并继续运行。
3. 确认更新已完成。在 {{site.data.keyword.Bluemix_notm}} 仪表板上查看 Kubernetes 版本，或运行 `bx cs clusters`。

Kubernetes 主节点更新完成后，可以更新工作程序节点。

<br />


## 更新工作程序节点
{: #worker_node}

您收到了工作程序节点更新通知。这意味着什么呢？这说明您的数据已存储在工作程序节点的 pod 内部。由于 Kubernetes 主节点的安全性更新和补丁已到位，因此您需要确保工作程序节点保持同步。工作程序主节点的版本不能高于 Kubernetes 主节点的版本。
{: shortdesc}

<ul>**注意**：</br>
<li>更新工作程序节点可能会导致应用程序和服务产生停机时间。</li>
<li>如果数据未存储在 pod 外，那么将删除数据。</li>
<li>在部署中使用 [replicas ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) 以在可用节点上重新安排 pod。</li></ul>

但如果我不能有停机时间该怎么办？

作为更新过程的一部分，特定的节点将停止运行一段时间。为了帮助避免应用程序产生停机时间，您可以在配置映射中定义唯一键，用于指定升级过程中特定类型节点的阈值百分比。通过定义基于标准 Kubernetes 标签的规则并给出允许不可用的最大节点数的百分比，可以确保应用程序保持开启和运行。如果节点尚未完成部署过程，那么该节点会视为不可用。

如何定义键？

在配置映射中，有一个包含数据信息的部分。您最多可以定义 10 个单独规则以在任意给定时间运行。要升级工作程序节点，这些节点必须满足映射中定义的每个规则。

键已定义。现在，我该怎样做？

一旦定义了规则，就可以运行 worker-upgrade 命令。如果返回成功的响应，说明工作程序节点在排队等待升级。但是，节点须满足所有规则后，才会执行升级过程。节点排队时，会按一定时间间隔检查规则，确定是否有任何节点可以升级。

如果选择不定义配置映射会怎样？

未定义配置映射时，将使用缺省值。缺省情况下，在更新过程中，每个集群的所有工作程序节点中最多有 20% 的节点不可用。

要更新工作程序节点，请执行以下操作：

1. 安装与 Kubernetes 主节点的 Kubernetes 版本相匹配的 [`kubectl cli` ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 版本。

2. 落实在 [Kubernetes 更改](cs_versions.html)中标记为_在主节点后更新_的任何更改。

3. 可选：定义配置映射。
    示例：

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是参数，第二列是匹配的描述。">
    <thead>
      <th colspan=2><img src="images/idea.png"/> 了解组成部分</th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> 缺省情况下，如果未以有效方式定义 ibm-cluster-update-configuration 映射，那么集群中只能有 20% 的节点同时不可用。如果在未使用全局缺省值的情况下定义了一个或多个有效规则，那么新的缺省值是允许 100% 的工作程序同时不可用。您可以通过创建缺省百分比来控制此比例。</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> 要为其设置规则的唯一键的示例。键名可以根据需要设置；信息由键内设置的配置进行解析。对于定义的每个键，只能为 <code>NodeSelectorKey</code> 和 <code>NodeSelectorValue</code> 设置一个值。如果要为多个区域或位置（数据中心）设置规则，请创建新的键条目。</td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> 对于指定键，允许不可用的最大节点数，指定为百分比。节点在部署、重新装入或供应过程中会不可用。如果排队的工作程序节点超过任何已定义的最大可用百分比，那么会阻止这些节点升级。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> 要为其设置规则的指定键标签的类型。您可以为 IBM 提供的缺省标签以及您创建的标签设置规则。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> 指定键内规则设置为评估的节点子集。</td>
      </tr>
    </tbody>
  </table>

    **注**：最多可以定义 10 个规则。如果向一个文件添加的键超过 10 个，那么只会解析其中一部分信息。

3. 通过 GUI 或运行 CLI 命令来更新工作程序节点。
  * 要从 {{site.data.keyword.Bluemix_notm}} 仪表板进行更新，请浏览到集群的 `Worker Nodes` 部分，然后单击 `Update Worker`。
  * 要获取工作程序节点标识，请运行 `bx cs workers <cluster_name_or_id>`. 如果选择多个工作程序节点，那么会将这些工作程序节点放入队列等待更新评估。如果在评估后认为工作程序节点已经准备就绪，那么将根据配置中设置的规则对其进行更新。

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. 可选：通过运行以下命令并查看**事件**，验证由配置映射触发的事件以及发生的任何验证错误。
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. 确认更新是否已完成：
  * 在 {{site.data.keyword.Bluemix_notm}}“仪表板”上查看 Kubernetes 版本，或运行 `bx cs workers <cluster_name_or_id>`.
  * 通过运行 `kubectl get nodes`，查看工作程序节点的 Kubernetes 版本。
  * 在某些情况下，较旧的集群可能会在更新后列出具有 **NotReady** 状态的重复工作程序节点。要除去重复项，请参阅[故障诊断](cs_troubleshoot.html#cs_duplicate_nodes)。

后续步骤：
  - 对其他集群重复更新过程。
  - 通知在集群中工作的开发者将其 `kubectl` CLI 更新到 Kubernetes 主节点的版本。
  - 如果 Kubernetes 仪表板未显示利用率图形，请[删除 `kube-dashboard` pod](cs_troubleshoot.html#cs_dashboard_graphs)。
<br />

