---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}} 的 Kubernetes 版本
{: #cs_versions}

{{site.data.keyword.containerlong}} 同时支持多个版本的 Kubernetes：最新版本、缺省版本以及通常比最新版本低两个版本的受支持版本。缺省版本可能与最新版本相同，并且除非您指定其他版本，否则在创建或更新集群时将使用缺省版本。
{:shortdesc}

当前支持的 Kubernetes 版本为：

- 最新版本：1.9.2
- 缺省版本：1.8.6
- 受支持版本：1.7.4

如果是在当前不支持的 Kubernetes 版本上运行集群，请[查看潜在影响](#version_types)以获取更新，然后立即[更新集群](cs_cluster_update.html#update)以继续接收重要的安全性更新和支持。要检查服务器版本，请运行以下命令。

```
kubectl version  --short | grep -i server
```
{: pre}

输出示例：

```
Server Version: 1.8.6
```
{: screen}

## 更新类型
{: #version_types}

Kubernetes 提供以下版本更新类型：
{:shortdesc}

|更新类型|版本标签示例|更新者|影响
|-----|-----|-----|-----|
|主要|1.x.x|您|集群的操作更改，包括脚本或部署。|
|次要|x.5.x|您|集群的操作更改，包括脚本或部署。|
|补丁|x.x.3|IBM 和您|不对脚本或部署进行更改。IBM 会自动更新主节点，但由您将补丁应用于工作程序节点。|
{: caption="Kubernetes 更新的影响" caption-side="top"}

缺省情况下，您最多只能跨 Kubernetes 主节点的两个次版本进行更新。例如，如果当前主节点的版本是 1.5，而您要更新到 1.8，那么必须先更新到 1.7。可以强制更新继续，但跨两个以上的次版本更新可能会导致意外结果。
{: tip}

以下信息总结了在将集群从先前版本更新到新版本时，可能会对已部署应用程序产生影响的更新。请查看 [Kubernetes changelog ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)，以获取 Kubernetes 版本中更改的完整列表。

有关更新过程的更多信息，请参阅[更新集群](cs_cluster_update.html#master)和[更新工作程序节点](cs_cluster_update.html#worker_node)。

## V1.9
{: #cs_v19}



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
<td>现在，使用 `kubectl` 命令来指定 `-o custom-columns`，但在对象中找不到列时，将会看到输出为 `<none>`。<br>
先前，此操作失败，并且您看到错误消息 `xxx is not found`。如果脚本依赖于先前的行为，请更新这些脚本。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>现在，当未对已打补丁的资源进行任何更改时，`kubectl patch` 命令会失败，并返回 `exit code 1`。如果脚本依赖于先前的行为，请更新这些脚本。</td>
</tr>
<tr>
<td>Kubernetes 仪表板许可权</td>
<td>现在，用户需要使用其凭证登录到 Kubernetes 仪表板，以查看集群资源。已除去缺省 Kubernetes 仪表板 `ClusterRoleBinding` RBAC 权限。有关指示信息，请参阅[启动 Kubernetes 仪表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>`default` `ServiceAccount` 的 RBAC</td>
<td>除去了 `default` 名称空间中 `default` `ServiceAccount` 的管理员 `ClusterRoleBinding`。如果应用程序依赖于此 RBAC 策略来访问 Kubernetes API，请[更新 RBAC 策略](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</td>
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


## V1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="此角标指示 IBM Cloud Container Service 的 Kubernetes V1.8 证书。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 计划下经认证的 V1.8 的 Kubernetes 产品。_Kubernetes® 是 Linux Foundation 在美国和其他国家或地区的注册商标，并根据 Linux Foundation 的许可证进行使用。_</p>

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
<td colspan='2'>在更新主节点之前，不需要更改</td>
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
<td>用于访问 V1.8 中 Kubernetes 仪表板的 URL 已更改，并且登录过程包含新的认证步骤。有关更多信息，请参阅[访问 Kubernetes 仪表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>Kubernetes 仪表板许可权</td>
<td>要强制用户使用其凭证登录以查看 V1.8 中的集群资源，请除去 1.7 ClusterRoleBinding RBAC 权限。运行 `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>`kubectl delete` 命令在删除对象之前，不再向下扩展工作负载 API 对象（例如 pod）。如果需要该对象向下扩展，请在删除对象之前使用 [kubectl scale ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale)。</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` 命令必须对 `--env` 使用多个标志而不是以逗号分隔的自变量。例如，运行 <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code>，而不是 <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>。</td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` 命令不再可用。</td>
</tr>
</tbody>
</table>


## V1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="此角标指示 IBM Cloud Container Service 的 Kubernetes V1.7 证书。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 计划下经认证的 V1.7 的 Kubernetes 产品。</p>

查看 Kubernetes 从先前版本更新到 V1.7 时可能需要进行的更改。

<br/>

### 在更新主节点之前更新
{: #17_before}

<table summary="适用于 V1.7 和 V1.6 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.7 之前要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>存储器</td>
<td>不允许带有父目录引用（如 `../to/dir`）的 `hostPath` 和 `mountPath` 的配置脚本。请将路径更改为简单的绝对路径，例如 `/path/to/dir`。<ol>
  <li>确定是否需要更改存储器路径：</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>如果返回 `Action required`，请更改 pod 以引用绝对路径，然后更新所有工作程序节点。如果 pod 由其他资源（如部署）拥有，请更改该资源内的 [_PodSpec_ ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core)。
</ol>
</td>
</tr>
</tbody>
</table>

### 在更新主节点之后更新
{: #17_after}

<table summary="适用于 V1.7 和 V1.6 的 Kubernetes 更新">
<caption>在将主节点更新到 Kubernetes 1.7 之后要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>`kubectl` CLI 更新后，这些 `kubectl` 命令必须使用多个标志而不是以逗号分隔的自变量：<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  例如，运行 `kubectl create role --resource-name <x> --resource-name <y>` 而非 `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Pod 亲缘关系安排</td>
<td> 不推荐使用 `scheduler.alpha.kubernetes.io/affinity` 注释。<ol>
  <li>对于除 `ibm-system` 和 `kube-system` 之外的每个名称空间，确定是否需要更新 pod 亲缘关系安排：</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br></li>
  <li>如果返回 `"Action required"`，请使用 [_PodSpec_ ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ 字段，而不是使用 `scheduler.alpha.kubernetes.io/affinity` 注释。</li>
</ol>
</tr>
<tr>
<td>网络策略</td>
<td>`net.beta.kubernetes.io/network-policy` 注释不再可用。<ol>
  <li>确定是否需要更改策略：</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>如果返回 `"Action required"`，请将以下网络策略添加到列出的每个 Kubernetes 名称空间：</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> 添加网络策略后，除去 `net.beta.kubernetes.io/network-policy` 注释：
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </li></ol>
</tr>
<tr>
<td>容忍度</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` 注释不再可用。
<ol>
  <li>对于除 `ibm-system` 和 `kube-system` 之外的每个名称空间，确定是否需要更改容忍度：</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>如果返回 `"Action required"`，请使用 [_PodSpec_ ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ 字段，而不是使用 `scheduler.alpha.kubernetes.io/tolerations` 注释。</ol>
</tr>
<tr>
<td>污点</td>
<td>`scheduler.alpha.kubernetes.io/taints` 注释不再可用。
<ol>
  <li>确定是否需要更改污点：</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>如果返回 `"Action required"`，请除去每个节点的 `scheduler.alpha.kubernetes.io/taints` 注释：</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>向每个节点添加污点：</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</tr>
<tr>
<td>StatefulSet pod DNS</td>
<td>更新主节点后，StatefulSet pod 会丢失其 Kubernetes DNS 条目。要恢复 DNS 条目，请删除 StatefulSet pod。Kubernetes 会重新创建 pod，并自动恢复 DNS 条目。有关更多信息，请参阅 [Kubernetes 问题 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/issues/48327)。</tr>
</tbody>
</table>
