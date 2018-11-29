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



# 版本信息和更新操作
{: #cs_versions}

## Kubernetes 版本类型
{: #version_types}

{{site.data.keyword.containerlong}} 同时支持多个版本的 Kubernetes。发布最新版本 (n) 时，支持最多低 2 (n-2) 的版本。比最新版本低 2 以上的版本 (n-3) 将首先不推荐使用，然后不再支持。
{:shortdesc}

**支持的 Kubernetes 版本**：

- 最新版本：1.11.3
- 缺省版本：1.10.8
- 其他版本：1.9.10

</br>

**不推荐的版本**：集群在不推荐的 Kubernetes 版本上运行时，您有 30 天的时间来复查并更新到支持的 Kubernetes 版本，30 天后此版本变为不受支持。在不推荐期间，系统仍完全支持您的集群。但是，不能创建使用不推荐的版本的新集群。

**不支持的版本**：如果是在不支持的 Kubernetes 版本上运行集群，请查看下面与更新相关的潜在影响，然后立即[更新集群](cs_cluster_update.html#update)以继续接收重要的安全性更新和支持。
*  **注意**：如果您等到集群低于受支持版本三个或更多次版本时才更新，那么必须强制更新，但这可能会导致意外结果或失败。
*  不支持的集群无法添加或重新装入现有工作程序节点。
*  将集群更新为支持的版本后，集群可以恢复正常运行并继续接收支持。

</br>

要检查集群的服务器版本，请运行以下命令。

```
kubectl version  --short | grep -i server
```
{: pre}

输出示例：

```
Server Version: v1.10.8+IKS
```
{: screen}


## 更新类型
{: #update_types}

Kubernetes 集群有三种类型的更新：主要更新、次要更新和补丁更新。
{:shortdesc}

|更新类型|版本标签示例|更新者|影响
|-----|-----|-----|-----|
|主要|1.x.x|您|集群的操作更改，包括脚本或部署。|
|次要|x.9.x|您|集群的操作更改，包括脚本或部署。|
|补丁|x.x.4_1510|IBM 和您|Kubernetes 补丁以及其他 {{site.data.keyword.Bluemix_notm}} Provider 组件更新，例如安全性和操作系统补丁。IBM 会自动更新主节点，但由您将补丁应用于工作程序节点。请参阅以下部分中有关补丁的更多信息。|
{: caption="Kubernetes 更新的影响" caption-side="top"}

更新可用时，您在查看有关工作程序节点的信息时（例如，使用 `ibmcloud ks workers <cluster>` 或 `ibmcloud ks worker-get <cluster> <worker>` 命令），会收到相应通知。
-  **主要更新和次要更新**：首先[更新主节点](cs_cluster_update.html#master)，然后[更新工作程序节点](cs_cluster_update.html#worker_node)。
   - 缺省情况下，您最多只能跨 Kubernetes 主节点的两个次版本进行更新。例如，如果当前主节点的版本是 1.7，而您要更新到 1.10，那么必须先更新到 1.9。可以强制更新继续，但跨两个以上的次版本更新可能会导致意外结果或失败。

   - 您使用的 `kubectl` CLI 版本至少应该与集群的 `major.minor` 版本相匹配，否则可能会遇到意外的结果。请确保 Kubernetes 集群版本和 [CLI 版本](cs_cli_install.html#kubectl)保持最新。

-  **补丁更新**：各补丁之间的更改会记录在[版本更改日志](cs_versions_changelog.html)中。更新可用时，您在 GUI 或 CLI 中查看有关主节点和工作程序节点的信息时（例如，使用 `ibmcloud ks clusters`、`cluster-get`、`workers` 或 `worker-get` 命令），会收到相关通知。
   - **工作程序节点补丁**：每月检查以了解更新是否可用，并使用 `ibmcloud ks worker-update` [命令](cs_cli_reference.html#cs_worker_update)或 `ibmcloud ks worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)来应用这些安全性和操作系统补丁。
   - **主节点补丁**：主节点补丁会自动应用，但需要若干天时间，因此主节点补丁版本在应用于主节点之前可能会显示为可用。自动更新还会跳过运行状况欠佳或当前有操作正在执行的集群。有时，IBM 可能会对特定主节点修订包禁用自动更新（如更改日志中所注释），例如仅当主节点从一个次版本更新到另一个次版本时才需要的补丁。在上述任何情况下，您都可以选择自行安全地使用 `ibmcloud ks cluster-update` [命令](cs_cli_reference.html#cs_cluster_update)，而无需等待应用自动更新。

</br>

以下信息总结了在将集群从先前版本更新到新版本时，可能会对已部署应用程序产生影响的更新。
-  V1.11 [迁移操作](#cs_v111)。
-  V1.10 [迁移操作](#cs_v110)。
-  V1.9 [迁移操作](#cs_v19)。
-  对不推荐使用或不受支持版本的[归档](#k8s_version_archive)。

<br/>

有关完整的更改列表，请查看以下信息：
* [Kubernetes 更改日志 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)。
* [IBM 版本更改日志](cs_versions_changelog.html)。

</br>

## V1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="此角标指示 IBM Cloud Container Service 的 Kubernetes V1.11 证书。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 计划下经认证的 V11.1 的 Kubernetes 产品。_Kubernetes® 是 Linux Foundation 在美国和其他国家或地区的注册商标，并根据 Linux Foundation 的许可证进行使用。_</p>

查看 Kubernetes 从先前版本更新到 V1.11 时可能需要进行的更改。

**重要信息**：必须执行[准备更新到 Calico V3](#111_calicov3) 中列出的步骤后，才能成功将集群从 Kubernetes V1.9 或更低版本更新到 V1.11。

### 在更新主节点之前更新
{: #111_before}

<table summary="适用于 V1.11 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.11 之前要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>`containerd`：新的 Kubernetes 容器运行时</td>
<td><strong>重要信息</strong>：`containerd` 将 Docker 替换为 Kubernetes 的新容器运行时。有关必须执行的操作，请参阅[作为容器运行时迁移到 `containerd`](#containerd)。</td>
</tr>
<tr>
<td>Kubernetes 容器卷安装传播</td>
<td>容器 `VolumeMount` 的 [`mountPropagation` 字段 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) 的缺省值已从 `HostToContainer` 更改为 `None`。此更改复原在 Kubernetes V1.9 以及更低版本中存在的行为。如果 pod 规范依赖于 `HostToContainer` 成为缺省值，请进行更新。</td>
</tr>
<tr>
<td>Kubernetes API 服务器 JSON 反序列化器</td>
<td>Kubernetes API 服务器 JSON 反序列化器现在区分大小写。此更改复原在 Kubernetes V1.7 以及更低版本中存在的行为。如果 JSON 资源定义使用不正确的大小写，请进行更新。<br><br>**注**：仅影响直接 Kubernetes API 服务器请求。`kubectl` CLI 继续在 Kubernetes V1.7 以及更高版本中强制实施区分大小写的密钥，因此如果使用 `kubectl` 严格管理资源，那么您不会受到影响。</td>
</tr>
</tbody>
</table>

### 在更新主节点之后更新
{: #111_after}

<table summary="适用于 V1.11 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.11 之后要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>集群日志记录配置</td>
<td>`fluentd` 集群附加组件自动更新为 V1.11，即使禁用了 `logging-autoupdate`。<br><br>
容器日志目录已从 `/var/lib/docker/` 更改为 `/var/log/pods/`。如果使用自己的日志记录解决方案来监视先前目录，请相应更新。</td>
</tr>
<tr>
<td>刷新 Kubernetes 配置</td>
<td>更新集群的 Kubernetes API 服务器的 OpenID Connect 配置以支持 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 访问组。因此，在通过运行 `ibmcloud ks cluster-config --cluster <cluster_name_or_ID>` 更新主 Kubernetes v1.11 后，必须刷新集群的 Kubernetes 配置。<br><br>如果不刷新配置，那么集群操作将失败，并显示以下错误消息：`You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>`kubectl` CLI</td>
<td>`kubectl` CLI for Kubernetes V1.11 需要 `apps/v1` API。因此，V1.11 `kubectl` CLI 不适用于运行 Kubernetes V1.8 或更低版本的集群。使用与集群的 Kubernetes API 服务器版本相匹配的 `kubectl` CLI 的版本。</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>现在，如果未授权用户，那么 `kubectl auth can-i` 命令失败，并返回 `exit code 1`。如果脚本依赖于先前的行为，请进行更新。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>现在，在使用选择条件（例如，标签）删除资源时，缺省情况下，`kubectl delete` 命令忽略 `not found` 错误。如果脚本依赖于先前的行为，请更新这些脚本。</td>
</tr>
<tr>
<td>Kubernetes `sysctls` 功能</td>
<td>现在会忽略 `security.alpha.kubernetes.io/sysctls` 注释。相反，Kubernetes 向 `PodSecurityPolicy` 和 `Pod` 对象添加字段以指定和控制 `sysctls`。有关更多信息，请参阅[在 Kubernetes 中使用 sysctls ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/)。<br><br>在更新集群主节点和工作程序后，更新 `PodSecurityPolicy` 和 `Pod` 对象以使用新的 `sysctls` 字段。</td>
</tr>
</tbody>
</table>

### 作为容器运行时迁移至 `containerd`
{: #containerd}

对于运行 Kubernetes V1.11 或更高版本的集群，`containerd` 将 Docker 替换为 Kubernetes 的新容器运行时以增强性能。如果 pod 依赖于 Docker 作为 Kubernetes 容器运行时，那么必须更新它们以作为容器运行时处理 `containerd`。有关更多信息，请参阅 [Kubernetes containerd 声明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/)。
{: shortdesc}

**如何知道应用程序是否依赖于 `docker` 而不是 `containerd`？**<br>
依赖于 Docker 作为容器运行时的情况的示例：
*  如果使用特权容器直接访问 Docker 引擎或 API，那么更新 pod 以支持 `containerd` 作为运行时。
*  集群中安装的某些第三方附加组件（例如，日志记录和监视工具）可能依赖于 Docker 引擎。请检查提供程序以确保工具兼容 `containerd`。

<br>

**除了依赖于运行时，是否还需要执行其他迁移操作？**<br>

**清单工具**：如果您具有使用 Docker V18.06 之前的试验性 `docker manifest` [工具 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.docker.com/edge/engine/reference/commandline/manifest/) 构建的多平台映像，那么无法使用 `containerd` 从 DockerHub 拉取映像。

在检查 pod 事件时，可能会看到如下错误。
```
failed size validation
```
{: screen}

要使用通过清单工具以及 `containerd` 构建的映像，请从以下选项中进行选择。

*  使用[清单工具 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/estesp/manifest-tool) 重新构建映像。
*  在更新为 Docker V18.06 或更高版本后，使用 `docker-manifest` 工具重新构建映像。

<br>

**什么不受影响？是否需要更改部署容器的方式？**<br>
通常，容器部署过程不会更改。您仍可以使用 Dockerfile 来定义 Docker 映像并针对应用程序构建 Docker 容器。如果使用 `docker` 命令来构建映像并将其推送到注册表，那么可继续使用 `docker` 或者改为使用 `ibmcloud cr` 命令。

### 准备更新到 Calico V3
{: #111_calicov3}

**重要信息**：如果要将集群从 Kubernetes V1.9 或更低版本更新到 V1.11，请在更新主节点之前准备 Calico V3 更新。在将主节点升级到 Kubernetes V1.11 期间，不会安排新的 pod 和新的 Kubernetes 或 Calico 网络策略。更新阻止新安排的时间长短不同。小型集群可能需要几分钟，每 10 个节点需要额外增加几分钟时间。现有网络策略和 pod 会继续运行。

**注**：如果要将集群从 Kubernetes V1.10 更新到 V1.11，请跳过这些步骤，因为在更新到 1.10 时已完成这些步骤。

开始之前，集群主节点和所有工作程序节点都必须运行的是 Kubernetes V1.8 或 V1.9，并且必须至少有一个工作程序节点。

1.  验证 Calico pod 是否运行正常。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  如果任何 pod 未处于**正在运行**状态，请删除该 pod，并等到它处于**正在运行**状态后再继续。

3.  如果是自动生成的 Calico 策略或其他 Calico 资源，请更新自动化工具，以使用 [Calico V3 语法 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) 生成这些资源。

4.  如果是将 [strongSwan](cs_vpn.html#vpn-setup) 用于 VPN 连接，那么 strongSwan 2.0.0 Helm 图表不适用于 Calico V3 或 Kubernetes 1.11。请[更新 strongSwan](cs_vpn.html#vpn_upgrade) 至 2.1.0 Helm 图表，此版本向后兼容 Calico 2.6 以及 Kubernetes 1.7、1.8 和 1.9。

5.  [将集群主节点更新到 Kubernetes V1.11](cs_cluster_update.html#master)。

<br />


## V1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="此角标指示 IBM Cloud Container Service 的 Kubernetes V1.10 证书。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 计划下经认证的 V1.10 的 Kubernetes 产品。_Kubernetes® 是 Linux Foundation 在美国和其他国家或地区的注册商标，并根据 Linux Foundation 的许可证进行使用。_</p>

查看 Kubernetes 从先前版本更新到 V1.10 时可能需要进行的更改。

**重要信息**：必须执行[准备更新到 Calico V3](#110_calicov3) 中列出的步骤后，才能成功更新到 Kubernetes 1.10。

<br/>

### 在更新主节点之前更新
{: #110_before}

<table summary="适用于 V1.10 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.10 之前要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico V3</td>
<td>更新 Kubernetes V1.10 还会将 Calico 从 V2.6.5 更新到 V3.1.1。<strong>重要信息</strong>：必须执行[准备更新到 Calico V3](#110_calicov3) 中列出的步骤后，才能成功更新到 Kubernetes V1.10。</td>
</tr>
<tr>
<td>Kubernetes 仪表板网络策略</td>
<td>在 Kubernetes 1.10 中，<code>kube-system</code> 名称空间中的 <code>kubernetes-dashboard</code> 网络策略会阻止所有 pod 访问 Kubernetes 仪表板。但是，这<strong>不会</strong>影响通过 {{site.data.keyword.Bluemix_notm}} 控制台或使用 <code>kubectl proxy</code> 来访问仪表板的能力。如果 pod 需要访问该仪表板，那么可以将 <code>kubernetes-dashboard-policy: allow</code> 标签添加到名称空间，然后将 pod 部署到该名称空间。</td>
</tr>
<tr>
<td>Kubelet API 访问</td>
<td>现在，Kubelet API 授权已委派给 <code>Kubernetes API 服务器</code>。对 Kubelet API 的访问基于用于授予访问 <strong>node</strong> 子资源的许可权的 <code>ClusterRole</code>。缺省情况下，Kubernetes Heapster 具有 <code>ClusterRole</code> 和 <code>ClusterRoleBinding</code>。但是，如果其他用户或应用程序要使用 Kubelet API，您必须向其授予使用该 API 的许可权。请参阅 Kubernetes 文档中有关 [Kubelet 授权 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/) 的信息。</td>
</tr>
<tr>
<td>密码套件</td>
<td>现在，<code>Kubernetes API 服务器</code> 和 Kubelet API 的受支持密码套件仅限用于采用高强度加密（128 位或更多位）的子集。如果您有使用较低强度密码的现有自动化或资源，并且依赖于与 <code>Kubernetes API 服务器</code> 或 Kubelet API 进行通信，请在更新主节点之前启用更高强度的密码支持。</td>
</tr>
<tr>
<td>strongSwan VPN
</td>
<td>如果是将 [strongSwan](cs_vpn.html#vpn-setup) 用于 VPN 连接，那么在更新集群之前，必须通过运行 `helm delete --purge <release_name>`. 集群更新完成后，请重新安装 strongSwan Helm 图表。</td>
</tr>
</tbody>
</table>

### 在更新主节点之后更新
{: #110_after}

<table summary="适用于 V1.10 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.10 之后要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico V3</td>
<td>更新集群时，会自动迁移应用于集群的所有现有 Calico 数据，以使用 Calico V3 语法。要使用 Calico V3 语法来查看、添加或修改 Calico 资源，请[将 Calico CLI 配置更新到 V3.1.1](#110_calicov3)。</td>
</tr>
<tr>
<td>节点 <code>ExternalIP</code> 地址</td>
<td>现在，节点的 <code>ExternalIP</code> 字段设置为节点的公用 IP 地址值。复查并更新依赖于此值的所有资源。</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td>现在，使用 <code>kubectl port-forward</code> 命令时，此命令不再支持 <code>-p</code> 标志。如果脚本依赖于先前的行为，请更新这些脚本，将 <code>-p</code> 标志替换为 pod 名称。</td>
</tr>
<tr>
<td>只读 API 数据卷</td>
<td>现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，允许应用程序将数据写入这些卷，但系统可能会自动还原这些卷。需要此迁移操作来修复安全漏洞 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102)。
如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</td>
</tr>
<tr>
<td>strongSwan VPN
</td>
<td>如果是将 [strongSwan](cs_vpn.html#vpn-setup) 用于 VPN 连接，并且在更新集群之前删除了图表，那么现在可以重新安装 strongSwan Helm 图表。</td>
</tr>
</tbody>
</table>

### 准备更新到 Calico V3
{: #110_calicov3}

开始之前，集群主节点和所有工作程序节点都必须运行的是 Kubernetes V1.8 或更高版本，并且必须至少有一个工作程序节点。

**重要信息**：在更新主节点之前，请先为 Calico V3 更新做好准备工作。在将主节点升级到 Kubernetes V1.10 期间，不会安排新的 pod 和新的 Kubernetes 或 Calico 网络策略。更新阻止新安排的时间长短不同。小型集群可能需要几分钟，每 10 个节点需要额外增加几分钟时间。现有网络策略和 pod 会继续运行。

1.  验证 Calico pod 是否运行正常。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  如果任何 pod 未处于**正在运行**状态，请删除该 pod，并等到它处于**正在运行**状态后再继续。

3.  如果是自动生成的 Calico 策略或其他 Calico 资源，请更新自动化工具，以使用 [Calico V3 语法 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) 生成这些资源。

4.  如果是将 [strongSwan](cs_vpn.html#vpn-setup) 用于 VPN 连接，那么 strongSwan 2.0.0 Helm 图表不适用于 Calico V3 或 Kubernetes 1.10。请[更新 strongSwan](cs_vpn.html#vpn_upgrade) 至 2.1.0 Helm 图表，此版本向后兼容 Calico 2.6 以及 Kubernetes 1.7、1.8 和 1.9。

5.  [将集群主节点更新到 Kubernetes V1.10](cs_cluster_update.html#master)。

<br />


## V1.9
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="此角标指示 IBM Cloud Container Service 的 Kubernetes V1.9 证书。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 计划下经认证的 V1.9 的 Kubernetes 产品。_Kubernetes® 是 Linux Foundation 在美国和其他国家或地区的注册商标，并根据 Linux Foundation 的许可证进行使用。_</p>

查看 Kubernetes 从先前版本更新到 V1.9 时可能需要进行的更改。

<br/>

### 在更新主节点之前更新
{: #19_before}

<table summary="适用于 V1.9 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.9 之前要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Webhook 许可 API</td>
<td>许可 API 已从 <code>admission.v1alpha1</code> 移至 <code>admission.v1beta1</code>，并在 API 服务器调用许可控制 Webhook 时使用。<em>升级集群之前必须删除所有现有 Webhook</em>，然后更新 Webhook 配置文件以使用最新的 API。此更改不向后兼容。</td>
</tr>
</tbody>
</table>

### 在更新主节点之后更新
{: #19_after}

<table summary="适用于 V1.9 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.9 之后要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>`kubectl` 输出</td>
<td>现在，使用 `kubectl` 命令来指定 `-o custom-columns`，但在对象中找不到列时，将会看到输出为 `<none>`.<br>
先前，此操作失败，并且您看到错误消息 `xxx is not found`。如果脚本依赖于先前的行为，请更新这些脚本。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>现在，当未对已打补丁的资源进行任何更改时，`kubectl patch` 命令会失败，并返回 `exit code 1`。如果脚本依赖于先前的行为，请更新这些脚本。</td>
</tr>
<tr>
<td>Kubernetes 仪表板许可权</td>
<td>用户需要使用其凭证登录到 Kubernetes 仪表板，以查看集群资源。除去了缺省 Kubernetes 仪表板 `ClusterRoleBinding` RBAC 权限。有关指示信息，请参阅[启动 Kubernetes 仪表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>只读 API 数据卷</td>
<td>现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，允许应用程序将数据写入这些卷，但系统可能会自动还原这些卷。需要此迁移操作来修复安全漏洞 [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102)。
如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</td>
</tr>
<tr>
<td>污点和容忍度</td>
<td>`node.alpha.kubernetes.io/notReady` 和 `node.alpha.kubernetes.io/unreachable` 污点已分别更改为 `node.kubernetes.io/not-ready` 和 `node.kubernetes.io/unreachable`。<br>
虽然会自动更新污点，但您必须手动更新这些污点的容忍度。对于除 `ibm-system` 和 `kube-system` 之外的每个名称空间，确定是否需要更改容忍度：<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
如果返回 `Action required`，请相应地修改 pod 容忍度。</td>
</tr>
<tr>
<td>Webhook 许可 API</td>
<td>如果在更新集群之前删除了现有的 Webhook，请创建新的 Webhook。</td>
</tr>
</tbody>
</table>

<br />



## 归档
{: #k8s_version_archive}

### V1.8（不受支持）
{: #cs_v18}

自 2018 年 9 月 22 日开始，不支持使用运行 [Kubernetes V1.8](cs_versions_changelog.html#changelog_archive) 的 {{site.data.keyword.containerlong_notm}} 集群。V1.8 集群无法接收安全性更新或支持，除非更新到下一个最新版本 ([Kubernetes 1.9](#cs_v19))。

对于每个 Kubernetes 版本更新，请[查看潜在影响](cs_versions.html#cs_versions)，然后立即[更新集群](cs_cluster_update.html#update)，并且至少更新到 1.9。

### V1.7（不支持）
{: #cs_v17}

自 2018 年 6 月 21 日开始，不支持使用运行 [Kubernetes V1.7](cs_versions_changelog.html#changelog_archive) 的 {{site.data.keyword.containerlong_notm}} 集群。V1.7 集群无法接收安全性更新或支持，除非更新到下一个最新支持的版本 ([Kubernetes 1.9](#cs_v19))。

对于每个 Kubernetes 版本更新，请[查看潜在影响](cs_versions.html#cs_versions)，然后立即[更新集群](cs_cluster_update.html#update)，并且至少更新到 1.9。

### V1.5（不受支持）
{: #cs_v1-5}

自 2018 年 4 月 4 日开始，不支持使用运行 [Kubernetes V1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) 的 {{site.data.keyword.containerlong_notm}} 集群。V1.5 集群无法接收安全性更新或支持。

要继续在 {{site.data.keyword.containerlong_notm}} 中运行应用程序，请[创建新集群](cs_clusters.html#clusters)并[迁移应用程序](cs_app.html#app)至该集群。
