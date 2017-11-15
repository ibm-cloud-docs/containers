---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

查看 {{site.data.keyword.containerlong}} 上提供的 Kubernetes 版本。
{:shortdesc}

该表包含在您将集群更新到新版本时可能对已部署应用程序产生影响的更新。请查看 [Kubernetes changelog ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)，以获取 Kubernetes 版本中更改的完整列表。

有关更新过程的更多信息，请参阅[更新集群](cs_cluster.html#cs_cluster_update)和[更新工作程序节点](cs_cluster.html#cs_cluster_worker_update)。



## V1.7
{: #cs_v17}

### 在更新主节点之前更新
{: #17_before}

<table summary="适用于 V1.7 和 V1.6 的 Kubernetes 更新">
<caption>表 1. 将主节点更新到 Kubernetes 1.7 之前要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</tr>
</thead>
<tbody>
<tr>
<td>存储器</td>
<td>不允许带有父目录引用（如 `../to/dir`）的 `hostPath` 和 `mountPath` 的配置脚本。请将路径更改为简单的绝对路径，例如 `/path/to/dir`。<ol>
  <li>运行此命令以确定是否需要更新存储器路径。</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>如果返回 `Action required`，请修改每个受影响的 pod 以引用绝对路径，然后更新所有工作程序节点。如果 pod 由其他资源（如部署）拥有，请修改该资源内的 [_PodSpec_ ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core)。
</ol>
</td>
</tr>
</tbody>
</table>

### 在更新主节点之后更新
{: #17_after}

<table summary="适用于 V1.7 和 V1.6 的 Kubernetes 更新">
<caption>表 2. 将主节点更新到 Kubernetes 1.7 之后要进行的更改</caption>
<thead>
<tr>
<th>类型</th>
<th>描述</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>将 `kubectl` CLI 更新到集群的版本后，这些 `kubectl` 命令必须使用多个标志而不是以逗号分隔的自变量。<ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  例如，运行 `kubectl create role --resource-name <x> --resource-name <y>` 而非 `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Pod 亲缘关系安排</td>
<td> 不推荐使用 `scheduler.alpha.kubernetes.io/affinity` 注释。<ol>
  <li>对除 `ibm-system` 和 `kube-system` 之外的每个名称空间运行此命令，以确定是否需要更新 pod 亲缘关系安排。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>如果返回 `"Action required"`，请修改受影响的 pod 以使用 [_PodSpec_ ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _亲缘关系_字段，而不是使用 `scheduler.alpha.kubernetes.io/affinity` 注释。</ol>
</tr>
<tr>
<td>网络策略</td>
<td>`net.beta.kubernetes.io/network-policy` 注释不再受支持。<ol>
  <li>运行此命令以确定是否需要更新网络策略。</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>如果返回 `Action required`，请将以下网络策略添加到列出的每个 Kubernetes 名称空间。</br>

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

  <li> 在使用网络策略的情况下，除去 `net.beta.kubernetes.io/network-policy` 注释。
```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>容忍度</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` 注释不再受支持。<ol>
  <li>对除 `ibm-system` 和 `kube-system` 之外的每个名称空间运行此命令，以确定是否需要更新容忍度。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>如果返回 `"Action required"`，请修改受影响的 pod 以使用 [_PodSpec_ ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _容忍度_字段，而不是使用 `scheduler.alpha.kubernetes.io/tolerations` 注释。</ol>
</tr>
<tr>
<td>污点</td>
<td>`scheduler.alpha.kubernetes.io/taints` 注释不再受支持。<ol>
  <li>运行此命令以确定是否需要更新污点。</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>如果返回 `"Action required"`，请除去具有不受支持注释的每个节点的 `scheduler.alpha.kubernetes.io/taints` 注释。</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>当除去不受支持的注释时，请向每个节点添加一个污点。您必须具有 `kubectl` CLI V1.6 或更新版本。</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
  
  
