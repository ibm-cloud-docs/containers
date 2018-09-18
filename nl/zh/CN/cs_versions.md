---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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

- 最新版本：1.10.5
- 缺省版本：1.10.5
- 其他版本：1.9.9 和 1.8.15

</br>

**不推荐的版本**：集群在不推荐的 Kubernetes 版本上运行时，您有 30 天的时间来复查并更新到支持的 Kubernetes 版本，30 天后此版本变为不受支持。在不推荐期间，系统仍完全支持您的集群。但是，不能创建使用不推荐的版本的新集群。

**不支持的版本**：如果是在不支持的 Kubernetes 版本上运行集群，请[查看潜在影响](#version_types)（与更新相关），然后立即[更新集群](cs_cluster_update.html#update)以继续接收重要的安全性更新和支持。 
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
Server Version: v1.10.5+IKS
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
|补丁|x.x.4_1510|IBM 和您|Kubernetes 补丁以及其他 {{site.data.keyword.Bluemix_notm}} Provider 组件更新，例如安全性和操作系统补丁。IBM 会自动更新主节点，但由您将补丁应用于工作程序节点。|
{: caption="Kubernetes 更新的影响" caption-side="top"}

更新可用时，您在查看有关工作程序节点的信息时（例如，使用 `ibmcloud ks workers <cluster>` 或 `ibmcloud ks worker-get <cluster> <worker>` 命令），会收到相应通知。
-  **主要更新和次要更新**：首先[更新主节点](cs_cluster_update.html#master)，然后[更新工作程序节点](cs_cluster_update.html#worker_node)。
   - 缺省情况下，您最多只能跨 Kubernetes 主节点的两个次版本进行更新。例如，如果当前主节点的版本是 1.5，而您要更新到 1.8，那么必须先更新到 1.7。可以强制更新继续，但跨两个以上的次版本更新可能会导致意外结果或失败。

   - 您使用的 `kubectl` CLI 版本至少应该与集群的 `major.minor` 版本相匹配，否则可能会遇到意外的结果。请确保 Kubernetes 集群版本和 [CLI 版本](cs_cli_install.html#kubectl)保持最新。

-  **补丁更新**：每月检查以了解更新是否可用，并使用 `ibmcloud ks worker-update` [命令](cs_cli_reference.html#cs_worker_update)或 `ibmcloud ks worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)来应用这些安全性和操作系统补丁。有关更多信息，请参阅[版本更改日志](cs_versions_changelog.html)。

<br/>

以下信息总结了在将集群从先前版本更新到新版本时，可能会对已部署应用程序产生影响的更新。
-  V1.10 [迁移操作](#cs_v110)。
-  V1.9 [迁移操作](#cs_v19)。
-  V1.8 [迁移操作](#cs_v18)。
-  对不推荐使用或不受支持版本的[归档](#k8s_version_archive)。

<br/>

有关完整的更改列表，请查看以下信息：
* [Kubernetes 更改日志 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)。
* [IBM 版本更改日志](cs_versions_changelog.html)。

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
<td>如果是将 [strongSwan](cs_vpn.html#vpn-setup) 用于 VPN 连接，那么在更新集群之前，必须通过运行 `helm delete --purge <release_name>` 除去图表。集群更新完成后，请重新安装 strongSwan Helm 图表。</td>
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



## V1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="padding-right: 10px;" align="left" alt="此角标指示 IBM Cloud Container Service 的 Kubernetes V1.8 证书。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 计划下经认证的 V1.8 的 Kubernetes 产品。_Kubernetes® 是 Linux Foundation 在美国和其他国家或地区的注册商标，并根据 Linux Foundation 的许可证进行使用。_</p>

查看 Kubernetes 从先前版本更新到 V1.8 时可能需要进行的更改。

<br/>

### 在更新主节点之前更新
{: #18_before}

<table summary="适用于 V1.8 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.8 之前要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>无</td>
<td>在更新主节点之前，不需要更改</td>
</tr>
</tbody>
</table>

### 在更新主节点之后更新
{: #18_after}

<table summary="适用于 V1.8 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.8 之后要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes 仪表板登录</td>
<td>更改了用于访问 V1.8 中 Kubernetes 仪表板的 URL，并且登录过程包含新的认证步骤。有关更多信息，请参阅[访问 Kubernetes 仪表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>Kubernetes 仪表板许可权</td>
<td>要强制用户使用其凭证登录以查看 V1.8 中的集群资源，请除去 1.7 ClusterRoleBinding RBAC 权限。运行 `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>`kubectl delete` 命令在删除对象之前，不再向下扩展工作负载 API 对象（例如 pod）。如果需要该对象向下扩展，请在删除对象之前使用 [`kubectl scale ` ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/#scale)。</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` 命令必须对 `--env` 使用多个标志而不是以逗号分隔的自变量。例如，运行 <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code>，而不是 <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>。</td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` 命令不再可用。</td>
</tr>
<tr>
<td>只读 API 数据卷</td>
<td>现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，允许应用程序将数据写入这些卷，但系统可能会自动还原这些卷。需要此迁移操作来修复安全漏洞 [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102)。
如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</td>
</tr>
</tbody>
</table>

<br />



## 归档
{: #k8s_version_archive}

### V1.7（不支持）
{: #cs_v17}

自 2018 年 6 月 21 日开始，不支持使用运行 [Kubernetes V1.7](cs_versions_changelog.html#changelog_archive) 的 {{site.data.keyword.containershort_notm}} 集群。V1.7 集群无法接收安全性更新或支持，除非更新到下一个最新版本 ([Kubernetes 1.8](#cs_v18))。

对于每个 Kubernetes 版本更新，请[查看潜在影响](cs_versions.html#cs_versions)，然后立即[更新集群](cs_cluster_update.html#update)，并且至少更新到 1.8。

### V1.5（不受支持）
{: #cs_v1-5}

自 2018 年 4 月 4 日开始，不支持使用运行 [Kubernetes V1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) 的 {{site.data.keyword.containershort_notm}} 集群。V1.5 集群无法接收安全性更新或支持，除非更新到下一个最新版本 ([Kubernetes 1.8](#cs_v18))。

对于每个 Kubernetes 版本更新，请[查看潜在影响](cs_versions.html#cs_versions)，然后立即[更新集群](cs_cluster_update.html#update)，并且至少更新到 1.8。
