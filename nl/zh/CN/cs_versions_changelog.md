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



# 版本更改日志
{: #changelog}

查看可用于 {{site.data.keyword.containerlong}} Kubernetes 集群的主要更新、次要更新和补丁更新的版本更改信息。更改包括对 Kubernetes 和 {{site.data.keyword.Bluemix_notm}} Provider 组件的更新。
{:shortdesc}

有关主版本、次版本和补丁版本以及次版本之间的迁移操作的更多信息，请参阅 [Kubernetes 版本](cs_versions.html)。
{: tip}

有关自上一个版本以来的更改的信息，请参阅以下更改日志。
-  V1.11 [更改日志](#111_changelog)。
-  V1.10 [更改日志](#110_changelog)。
-  V1.9 [更改日志](#19_changelog)。
-  对不推荐使用或不受支持的版本的更改日志[归档](#changelog_archive)。

**注**：一些更改日志针对_工作程序节点修订包_，仅适用于工作程序节点。您必须[应用这些补丁](cs_cli_reference.html#cs_worker_update)才能确保工作程序节点的安全合规性。另一些更改日志针对_主节点修订包_，仅适用于集群主节点。主节点修订包可能不会自动应用。您可以选择[手动进行应用](cs_cli_reference.html#cs_cluster_update)。有关补丁类型的更多信息，请参阅[更新类型](cs_versions.html#update_types)。

</br>

## V1.11 更改日志
{: #111_changelog}

查看以下更改。


### 2018 年 10 月 15 日发布的主节点 FP1.11.3_1527 的更改日志
{: #1113_1527}

<table summary="自 V1.11.3_1524 以来进行的更改">
<caption>自 V1.11.3_1524 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>修订了 `calico-node` 容器就绪性探测器，以更好地处理节点故障。</td>
</tr>
<tr>
<td>集群更新</td>
<td>不适用</td>
<td>不适用</td>
<td>解决了从不支持的版本更新主节点时，更新集群附加组件时发生的问题。</td>
</tr>
</tbody>
</table>

### 2018 年 10 月 10 日发布的工作程序节点 FP1.11.3_1525 的更改日志
{: #1113_1525}

<table summary="自 V1.11.3_1524 以来进行的更改">
<caption>自 V1.11.3_1524 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>使用 [CVE-2018-14633 和 CVE-2018-17182 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
<tr>
<td>不活动会话超时</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，将不活动会话超时设置为 5 分钟。</td>
</tr>
</tbody>
</table>


### 2018 年 10 月 2 日发布的 1.11.3_1524 的更改日志
{: #1113_1524}

<table summary="自 V1.11.3_1521 以来进行的更改">
<caption>自 V1.11.3_1521 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>请参阅 [containerd 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/containerd/containerd/releases/tag/v1.1.4)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.11.3-91</td>
<td>V1.11.3-100</td>
<td>更新了负载均衡器错误消息中的文档链接。</td>
</tr>
<tr>
<td>IBM File Storage 类</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了 IBM File Storage 类中重复的 `reclaimPolicy` 参数。<br><br>
此外，现在更新集群主节点时，缺省 IBM File Storage 类会保持不变。如果要更改缺省存储类，请运行 `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`，并将 `<storageclass>` 替换为存储类的名称。</td>
</tr>
</tbody>
</table>

### 2018 年 9 月 20 日发布的 1.11.3_1521 的更改日志
{: #1113_1521}

<table summary="自 V1.11.2_1516 以来进行的更改">
<caption>自 V1.11.2_1516 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.11.2-71</td>
<td>V1.11.3-91</td>
<td>更新为支持 Kubernetes 1.11.3 发行版。</td>
</tr>
<tr>
<td>IBM File Storage 类</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了 IBM File Storage 类中的 `mountOptions`，以使用工作程序节点提供的缺省值。<br><br>
此外，现在更新集群主节点时，缺省 IBM File Storage 类会保持为 `ibmc-file-bronze`。如果要更改缺省存储类，请运行 `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`，并将 `<storageclass>` 替换为存储类的名称。</td>
</tr>
<tr>
<td>密钥管理服务提供程序</td>
<td>不适用</td>
<td>不适用</td>
<td>添加了在集群中使用 Kubernetes 密钥管理服务 (KMS) 提供程序的功能，以支持 {{site.data.keyword.keymanagementservicefull}}。[在集群中启用 {{site.data.keyword.keymanagementserviceshort}}](cs_encrypt.html#keyprotect) 时，会对所有 Kubernetes 私钥进行加密。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.11.2</td>
<td>V1.11.3</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3)。</td>
</tr>
<tr>
<td>Kubernetes DNS Autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>请参阅 [Kubernetes DNS Autoscaler 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0)。</td>
</tr>
<tr>
<td>日志循环</td>
<td>不适用</td>
<td>不适用</td>
<td>切换到使用 `systemd` 计时器，而不使用 `cronjobs`，以防止 `logrotate` 因工作程序节点 90 天内未重新装入或更新而失败。**注**：在该次发行版的所有更早版本中，由于日志不循环，因此在定时作业失败后，主磁盘会填满。在工作程序节点 90 天内处于活动状态而未更新或重新装入后，定时作业会失败。如果日志填满整个主磁盘，那么工作程序节点将进入故障状态。使用 `ibmcloud ks worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)或 `ibmcloud ks worker-update` [命令](cs_cli_reference.html#cs_worker_update)可以修复工作程序节点。</td>
</tr>
<tr>
<td>root 用户密码到期</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，工作程序节点的 root 用户密码会在 90 天后到期。如果自动化工具需要以 root 用户身份登录到工作程序节点，或者依赖于以 root 用户身份运行的定时作业，那么可以通过登录到工作程序节点并运行 `chage -M -1 root` 来禁用密码到期。**注**：如果您有阻止以 root 用户身份运行或阻止除去到期密码的安全合规性需求，请不要禁用到期。您可以改为至少每 90 天[更新](cs_cli_reference.html#cs_worker_update)或[重新装入](cs_cli_reference.html#cs_worker_reload)一次工作程序节点。</td>
</tr>
<tr>
<td>工作程序节点运行时组件（`kubelet`、`kube-proxy` 和 `containerd`）</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了运行时组件对主磁盘的依赖关系。此增强功能可防止工作程序节点在主磁盘填满时发生故障。</td>
</tr>
<tr>
<td>Systemd</td>
<td>不适用</td>
<td>不适用</td>
<td>定期清除瞬态安装单元，以防止它们变得不受控制。此操作解决了 [Kubernetes 问题 57345 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/issues/57345)。</td>
</tr>
</tbody>
</table>

### 2018 年 9 月 4 日发布的 1.11.2_1516 的更改日志
{: #1112_1516}

<table summary="自 V1.11.2_1514 以来进行的更改">
<caption>自 V1.11.2_1514 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V3.1.3</td>
<td>V3.2.1</td>
<td>请参阅 [Calico 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.2/releases/#v321)。</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>请参阅 [`containerd` 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/containerd/containerd/releases/tag/v1.1.3)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.11.2-60</td>
<td>V1.11.2-71</td>
<td>通过将 `externalTrafficPolicy` 设置为 `local`，更改了 Cloud Provider 配置以更好地处理负载均衡器服务的更新。</td>
</tr>
<tr>
<td>IBM File Storage 插件配置</td>
<td>不适用</td>
<td>不适用</td>
<td>已从 IBM 提供的文件存储类的安装选项中除去缺省 NFS 版本。主机的操作系统现在与 IBM Cloud infrastructure (SoftLayer) NFS 服务器协商 NFS 版本。要手动设置特定 NFS 版本，或者更改主机操作系统协商的 PV 的 NFS 版本，请参阅[更改缺省 NFS 版本](cs_storage_file.html#nfs_version_class)。</td>
</tr>
</tbody>
</table>

### 2018 年 8 月 23 日发布的工作程序节点 FP1.11.2_1514 的更改日志
{: #1112_1514}

<table summary="自 V1.11.2_1513 以来进行的更改">
<caption>自 V1.11.2_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>更新了 `systemd` 以修复 `cgroup` 泄漏。</td>
</tr>
<tr>
<td>内核</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>使用 [CVE-2018-3620、CVE-2018-3646 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://usn.ubuntu.com/3741-1/) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
</tbody>
</table>

### 2018 年 8 月 14 日发布的 1.11.2_1513 的更改日志
{: #1112_1513}

<table summary="自 V1.10.5_1518 以来进行的更改">
<caption>自 V1.10.5_1518 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>不适用</td>
<td>1.1.2</td>
<td>`containerd` 将 Docker 替换为 Kubernetes 的新容器运行时。请参阅 [`containerd` 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/containerd/containerd/releases/tag/v1.1.2)。有关必须执行的操作，请参阅[作为容器运行时迁移到 `containerd`](cs_versions.html#containerd)。</td>
</tr>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>`containerd` 将 Docker 替换为 Kubernetes 的新容器运行时以增强性能。有关必须执行的操作，请参阅[作为容器运行时迁移到 `containerd`](cs_versions.html#containerd)。</td>
</tr>
<tr>
<td>etcd</td>
<td>V3.2.14</td>
<td>V3.2.18</td>
<td>请参阅 [etcd 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/coreos/etcd/releases/v3.2.18)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.5-118</td>
<td>V1.11.2-60</td>
<td>更新为支持 Kubernetes 1.11 发行版。此外，负载均衡器 pod 现在使用新的 `ibm-app-cluster-critical` pod 优先级类。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>334</td>
<td>338</td>
<td>已将 `incubator` 版本更新为 1.8。将向选择的特定专区供应文件存储。您无法更新现有（静态）PV 实例标签，除非使用多专区集群并且需要[添加区域和专区标签](cs_storage_basics.html#multizone)。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.10.5</td>
<td>V1.11.2</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>更新了集群的 Kubernetes API 服务器的 OpenID Connect 配置以支持 {{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM) 访问组。向集群的 Kubernetes API 服务器的 `--enable-admission-plugins` 选项添加了 `Priority`，并将集群配置为支持 pod 优先级。有关更多信息，请参阅：<ul><li>[IAM 访问组](cs_users.html#rbac)</li>
<li>[配置 pod 优先级](cs_pod_priority.html#pod_priority)</li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>V1.5.2</td>
<td>V1.5.4</td>
<td>提高了 `heapster-nanny` 容器的资源限制。请参阅 [Kubernetes Heapster 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/heapster/releases/tag/v1.5.4)。</td>
</tr>
<tr>
<td>日志记录配置</td>
<td>不适用</td>
<td>不适用</td>
<td>容器日志目录现在为 `/var/log/pods/`，而不是先前的 `/var/lib/docker/containers/`。</td>
</tr>
</tbody>
</table>

<br />


## V1.10 更改日志
{: #110_changelog}

查看以下更改。

### 2018 年 10 月 15 日发布的主节点 FP1.10.8_1527 的更改日志
{: #1108_1527}

<table summary="自 V1.10.8_1524 以来进行的更改">
<caption>自 V1.10.8_1524 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>修订了 `calico-node` 容器就绪性探测器，以更好地处理节点故障。</td>
</tr>
<tr>
<td>集群更新</td>
<td>不适用</td>
<td>不适用</td>
<td>解决了从不支持的版本更新主节点时，更新集群附加组件时发生的问题。</td>
</tr>
</tbody>
</table>

### 2018 年 10 月 10 日发布的工作程序节点 FP1.10.8_1525 的更改日志
{: #1108_1525}

<table summary="自 V1.10.8_1524 以来进行的更改">
<caption>自 V1.10.8_1524 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>使用 [CVE-2018-14633 和 CVE-2018-17182 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
<tr>
<td>不活动会话超时</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，将不活动会话超时设置为 5 分钟。</td>
</tr>
</tbody>
</table>


### 2018 年 10 月 2 日发布的 1.10.8_1524 的更改日志
{: #1108_1524}

<table summary="自 V1.10.7_1520 以来进行的更改">
<caption>自 V1.10.7_1520 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>密钥管理服务提供程序</td>
<td>不适用</td>
<td>不适用</td>
<td>添加了在集群中使用 Kubernetes 密钥管理服务 (KMS) 提供程序的功能，以支持 {{site.data.keyword.keymanagementservicefull}}。[在集群中启用 {{site.data.keyword.keymanagementserviceshort}}](cs_encrypt.html#keyprotect) 时，会对所有 Kubernetes 私钥进行加密。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.10.7</td>
<td>V1.10.8</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8)。</td>
</tr>
<tr>
<td>Kubernetes DNS Autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>请参阅 [Kubernetes DNS Autoscaler 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.7-146</td>
<td>V1.10.8-172</td>
<td>更新为支持 Kubernetes 1.10.8 发行版。此外，还更新了负载均衡器错误消息中的文档链接。</td>
</tr>
<tr>
<td>IBM File Storage 类</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了 IBM File Storage 类中的 `mountOptions`，以使用工作程序节点提供的缺省值。除去了 IBM File Storage 类中重复的 `reclaimPolicy` 参数。<br><br>
此外，现在更新集群主节点时，缺省 IBM File Storage 类会保持不变。如果要更改缺省存储类，请运行 `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`，并将 `<storageclass>` 替换为存储类的名称。</td>
</tr>
</tbody>
</table>

### 2018 年 9 月 20 日发布的工作程序节点 FP1.10.7_1521 的更改日志
{: #1107_1521}

<table summary="自 V1.10.7_1520 以来进行的更改">
<caption>自 V1.10.7_1520 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>日志循环</td>
<td>不适用</td>
<td>不适用</td>
<td>切换到使用 `systemd` 计时器，而不使用 `cronjobs`，以防止 `logrotate` 因工作程序节点 90 天内未重新装入或更新而失败。**注**：在该次发行版的所有更早版本中，由于日志不循环，因此在定时作业失败后，主磁盘会填满。在工作程序节点 90 天内处于活动状态而未更新或重新装入后，定时作业会失败。如果日志填满整个主磁盘，那么工作程序节点将进入故障状态。使用 `ibmcloud ks worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)或 `ibmcloud ks worker-update` [命令](cs_cli_reference.html#cs_worker_update)可以修复工作程序节点。</td>
</tr>
<tr>
<td>工作程序节点运行时组件（`kubelet`、`kube-proxy` 和 `docker`）</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了运行时组件对主磁盘的依赖关系。此增强功能可防止工作程序节点在主磁盘填满时发生故障。</td>
</tr>
<tr>
<td>root 用户密码到期</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，工作程序节点的 root 用户密码会在 90 天后到期。如果自动化工具需要以 root 用户身份登录到工作程序节点，或者依赖于以 root 用户身份运行的定时作业，那么可以通过登录到工作程序节点并运行 `chage -M -1 root` 来禁用密码到期。**注**：如果您有阻止以 root 用户身份运行或阻止除去到期密码的安全合规性需求，请不要禁用到期。您可以改为至少每 90 天[更新](cs_cli_reference.html#cs_worker_update)或[重新装入](cs_cli_reference.html#cs_worker_reload)一次工作程序节点。</td>
</tr>
<tr>
<td>Systemd</td>
<td>不适用</td>
<td>不适用</td>
<td>定期清除瞬态安装单元，以防止它们变得不受控制。此操作解决了 [Kubernetes 问题 57345 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/issues/57345)。</td>
</tr>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>禁用了缺省 Docker 网桥，以便 `172.17.0.0/16` IP 范围现在可用于专用路由。如果通过直接在主机上执行 `docker` 命令或使用安装了 Docker 套接字的 pod 来依赖于在工作程序节点中构建 Docker 容器，请从以下选项中进行选择。<ul><li>要确保构建容器时的外部网络连接，请运行 `docker build . --network host`。</li>
<li>要显式创建在构建容器时要使用的网络，请运行 `docker network create`，然后使用此网络。</li></ul>
**注**：是否对 Docker 套接字或 Docker 有直接依赖关系？请[迁移到 `containerd`（而不是 `docker`）作为容器运行时](cs_versions.html#containerd)，以便准备好集群来运行 Kubernetes V1.11 或更高版本。</td>
</tr>
</tbody>
</table>

### 2018 年 9 月 4 日发布的 1.10.7_1520 的更改日志
{: #1107_1520}

<table summary="自 V1.10.5_1519 以来进行的更改">
<caption>自 V1.10.5_1519 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V3.1.3</td>
<td>V3.2.1</td>
<td>请参阅 Calico [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.2/releases/#v321)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.5-118</td>
<td>V1.10.7-146</td>
<td>更新为支持 Kubernetes 1.10.7 发行版。此外，通过将 `externalTrafficPolicy` 设置为 `local`，更改了 Cloud Provider 配置以更好地处理负载均衡器服务的更新。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>334</td>
<td>338</td>
<td>已将 incubator 版本更新为 1.8。将向选择的特定专区供应文件存储。您无法更新现有（静态）PV 实例的标签，除非使用多专区集群并且需要添加区域和专区标签。<br><br> 已从 IBM 提供的文件存储类的安装选项中除去缺省 NFS 版本。主机的操作系统现在与 IBM Cloud infrastructure (SoftLayer) NFS 服务器协商 NFS 版本。要手动设置特定 NFS 版本，或者更改主机操作系统协商的 PV 的 NFS 版本，请参阅[更改缺省 NFS 版本](cs_storage_file.html#nfs_version_class)。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.10.5</td>
<td>V1.10.7</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7)。</td>
</tr>
<tr>
<td>Kubernetes Heapster 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>提高了 `heapster-nanny` 容器的资源限制。</td>
</tr>
</tbody>
</table>

### 2018 年 8 月 23 日发布的工作程序节点 FP1.10.5_1519 的更改日志
{: #1105_1519}

<table summary="自 V1.10.5_1518 以来进行的更改">
<caption>自 V1.10.5_1518 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>更新了 `systemd` 以修复 `cgroup` 泄漏。</td>
</tr>
<tr>
<td>内核</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>使用 [CVE-2018-3620、CVE-2018-3646 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://usn.ubuntu.com/3741-1/) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
</tbody>
</table>


### 2018 年 8 月 13 日发布的工作程序节点 FP1.10.5_1518 的更改日志
{: #1105_1518}

<table summary="自 V1.10.5_1517 以来进行的更改">
<caption>自 V1.10.5_1517 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 软件包</td>
<td>不适用</td>
<td>不适用</td>
<td>已安装的 Ubuntu 软件包的更新。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 27 日发布的 1.10.5_1517 的更改日志
{: #1105_1517}

<table summary="自 V1.10.3_1514 以来进行的更改">
<caption>自 V1.10.3_1514 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V3.1.1</td>
<td>V3.1.3</td>
<td>请参阅 Calico [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/releases/#v313)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.3-85</td>
<td>V1.10.5-118</td>
<td>更新为支持 Kubernetes 1.10.5 发行版。此外，LoadBalancer 服务 `create failure` 事件现在包含任何可移植子网错误。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>320</td>
<td>334</td>
<td>将创建持久性卷的超时从 15 分钟增加到 30 分钟。将缺省计费类型更改为 `hourly`。向预定义存储类添加了安装选项。在 IBM Cloud Infrastructure (SoftLayer) 帐户的 NFS 文件存储器实例中，已将**注释**字段更改为 JSON 格式，并添加了 PV 部署到的 Kubernetes 名称空间。为了支持多专区集群，向持久性卷添加了专区和区域标签。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.10.3</td>
<td>V1.10.5</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5)。</td>
</tr>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载对工作程序节点网络设置进行了小幅改进。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署现在由 Kubernetes `addon-manager` 进行管理。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 3 日发布的工作程序节点 FP1.10.3_1514 的更改日志
{: #1103_1514}

<table summary="自 V1.10.3_1513 以来进行的更改">
<caption>自 V1.10.3_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载优化了 `sysctl`。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 21 日发布的工作程序节点 FP1.10.3_1513 的更改日志
{: #1103_1513}

<table summary="自 V1.10.3_1512 以来进行的更改">
<caption>自 V1.10.3_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>对于未加密的机器类型，重新装入或更新工作程序节点时，将通过获取全新文件系统来清除辅助磁盘。</td>
</tr>
</tbody>
</table>

### 2018 年 6 月 12 日发布的 1.10.3_1512 的更改日志
{: #1103_1512}

<table summary="自 V1.10.1_1510 以来进行的更改">
<caption>自 V1.10.1_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.10.1</td>
<td>V1.10.3</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 `--enable-admission-plugins` 选项添加了 `PodSecurityPolicy`，并将集群配置为支持 pod 安全策略。有关更多信息，请参阅[配置 pod 安全策略](cs_psp.html)。</td>
</tr>
<tr>
<td>Kubelet 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>启用了 `--authentication-token-webhook` 选项以支持 API 不记名令牌和服务帐户令牌认证到 `kubelet` HTTPS 端点。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.1-52</td>
<td>V1.10.3-85</td>
<td>更新为支持 Kubernetes 1.10.3 发行版。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>向在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署添加了 `livenessProbe`。</td>
</tr>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序节点映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>



### 2018 年 5 月 18 日发布的工作程序节点 FP1.10.1_1510 的更改日志
{: #1101_1510}

<table summary="自 V1.10.1_1509 以来进行的更改">
<caption>自 V1.10.1_1509 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 16 日发布的工作程序节点 FP1.10.1_1509 的更改日志
{: #1101_1509}

<table summary="自 V1.10.1_1508 以来进行的更改">
<caption>自 V1.10.1_1508 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 1 日发布的 1.10.1_1508 的更改日志
{: #1101_1508}

<table summary="自 V1.9.7_1510 以来进行的更改">
<caption>自 V1.9.7_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V2.6.5</td>
<td>V3.1.1</td>
<td>请参阅 Calico [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/releases/#v311)。</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>V1.5.0</td>
<td>V1.5.2</td>
<td>请参阅 Kubernetes Heapster [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2)。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.9.7</td>
<td>V1.10.1</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 <code>--enable-admission-plugins</code> 选项添加了 <code>StorageObjectInUseProtection</code>。</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>请参阅 Kubernetes DNS [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/dns/releases/tag/1.14.10)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.7-102</td>
<td>V1.10.1-52</td>
<td>更新为支持 Kubernetes 1.10 发行版。</td>
</tr>
<tr>
<td>GPU 支持</td>
<td>不适用</td>
<td>不适用</td>
<td>现在，可支持[图形处理单元 (GPU) 容器工作负载](cs_app.html#gpu_app)进行安排和执行。有关可用 GPU 机器类型的列表，请参阅[工作程序节点的硬件](cs_clusters_planning.html#shared_dedicated_node)。有关更多信息，请参阅 Kubernetes 文档以[安排 GPU ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)。</td>
</tr>
</tbody>
</table>

<br />


## V1.9 更改日志
{: #19_changelog}

查看以下更改。

### 2018 年 10 月 15 日发布的主节点 FP1.9.10_1530 的更改日志
{: #1910_1530}

<table summary="自 V1.9.10_1527 以来进行的更改">
<caption>自 V1.9.10_1527 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>集群更新</td>
<td>不适用</td>
<td>不适用</td>
<td>解决了从不支持的版本更新主节点时，更新集群附加组件时发生的问题。</td>
</tr>
</tbody>
</table>

### 2018 年 10 月 10 日发布的工作程序节点 FP1.9.10_1528 的更改日志
{: #1910_1528}

<table summary="自 V1.9.10_1527 以来进行的更改">
<caption>自 V1.9.10_1527 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>使用 [CVE-2018-14633 和 CVE-2018-17182 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
<tr>
<td>不活动会话超时</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，将不活动会话超时设置为 5 分钟。</td>
</tr>
</tbody>
</table>


### 2018 年 10 月 2 日发布的 1.9.10_1527 的更改日志
{: #1910_1527}

<table summary="自 V1.9.10_1523 以来进行的更改">
<caption>自 V1.9.10_1523 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.10-192</td>
<td>V1.9.10-219</td>
<td>更新了负载均衡器错误消息中的文档链接。</td>
</tr>
<tr>
<td>IBM File Storage 类</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了 IBM File Storage 类中的 `mountOptions`，以使用工作程序节点提供的缺省值。除去了 IBM File Storage 类中重复的 `reclaimPolicy` 参数。<br><br>
此外，现在更新集群主节点时，缺省 IBM File Storage 类会保持不变。如果要更改缺省存储类，请运行 `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`，并将 `<storageclass>` 替换为存储类的名称。</td>
</tr>
</tbody>
</table>

### 2018 年 9 月 20 日发布的工作程序节点 FP1.9.10_1524 的更改日志
{: #1910_1524}

<table summary="自 V1.9.10_1523 以来进行的更改">
<caption>自 V1.9.10_1523 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>日志循环</td>
<td>不适用</td>
<td>不适用</td>
<td>切换到使用 `systemd` 计时器，而不使用 `cronjobs`，以防止 `logrotate` 因工作程序节点 90 天内未重新装入或更新而失败。**注**：在该次发行版的所有更早版本中，由于日志不循环，因此在定时作业失败后，主磁盘会填满。在工作程序节点 90 天内处于活动状态而未更新或重新装入后，定时作业会失败。如果日志填满整个主磁盘，那么工作程序节点将进入故障状态。使用 `ibmcloud ks worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)或 `ibmcloud ks worker-update` [命令](cs_cli_reference.html#cs_worker_update)可以修复工作程序节点。</td>
</tr>
<tr>
<td>工作程序节点运行时组件（`kubelet`、`kube-proxy` 和 `docker`）</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了运行时组件对主磁盘的依赖关系。此增强功能可防止工作程序节点在主磁盘填满时发生故障。</td>
</tr>
<tr>
<td>root 用户密码到期</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，工作程序节点的 root 用户密码会在 90 天后到期。如果自动化工具需要以 root 用户身份登录到工作程序节点，或者依赖于以 root 用户身份运行的定时作业，那么可以通过登录到工作程序节点并运行 `chage -M -1 root` 来禁用密码到期。**注**：如果您有阻止以 root 用户身份运行或阻止除去到期密码的安全合规性需求，请不要禁用到期。您可以改为至少每 90 天[更新](cs_cli_reference.html#cs_worker_update)或[重新装入](cs_cli_reference.html#cs_worker_reload)一次工作程序节点。</td>
</tr>
<tr>
<td>Systemd</td>
<td>不适用</td>
<td>不适用</td>
<td>定期清除瞬态安装单元，以防止它们变得不受控制。此操作解决了 [Kubernetes 问题 57345 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/issues/57345)。</td>
</tr>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>禁用了缺省 Docker 网桥，以便 `172.17.0.0/16` IP 范围现在可用于专用路由。如果通过直接在主机上执行 `docker` 命令或使用安装了 Docker 套接字的 pod 来依赖于在工作程序节点中构建 Docker 容器，请从以下选项中进行选择。<ul><li>要确保构建容器时的外部网络连接，请运行 `docker build . --network host`。</li>
<li>要显式创建在构建容器时要使用的网络，请运行 `docker network create`，然后使用此网络。</li></ul>
**注**：是否对 Docker 套接字或 Docker 有直接依赖关系？请[迁移到 `containerd`（而不是 `docker`）作为容器运行时](cs_versions.html#containerd)，以便准备好集群来运行 Kubernetes V1.11 或更高版本。</td>
</tr>
</tbody>
</table>

### 2018 年 9 月 4 日发布的 1.9.10_1523 的更改日志
{: #1910_1523}

<table summary="自 V1.9.9_1522 以来进行的更改">
<caption>自 V1.9.9_1522 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.9-167</td>
<td>V1.9.10-192</td>
<td>更新为支持 Kubernetes 1.9.10 发行版。此外，通过将 `externalTrafficPolicy` 设置为 `local`，更改了 Cloud Provider 配置以更好地处理负载均衡器服务的更新。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>334</td>
<td>338</td>
<td>已将 incubator 版本更新为 1.8。将向选择的特定专区供应文件存储。您无法更新现有（静态）PV 实例的标签，除非使用多专区集群并且需要添加区域和专区标签。<br><br>已从 IBM 提供的文件存储类的安装选项中除去缺省 NFS 版本。主机的操作系统现在与 IBM Cloud infrastructure (SoftLayer) NFS 服务器协商 NFS 版本。要手动设置特定 NFS 版本，或者更改主机操作系统协商的 PV 的 NFS 版本，请参阅[更改缺省 NFS 版本](cs_storage_file.html#nfs_version_class)。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.9.9</td>
<td>V1.9.10</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10)。</td>
</tr>
<tr>
<td>Kubernetes Heapster 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>提高了 `heapster-nanny` 容器的资源限制。</td>
</tr>
</tbody>
</table>

### 2018 年 8 月 23 日发布的工作程序节点 FP1.9.9_1522 的更改日志
{: #199_1522}

<table summary="自 V1.9.9_1521 以来进行的更改">
<caption>自 V1.9.9_1521 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>更新了 `systemd` 以修复 `cgroup` 泄漏。</td>
</tr>
<tr>
<td>内核</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>使用 [CVE-2018-3620、CVE-2018-3646 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://usn.ubuntu.com/3741-1/) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
</tbody>
</table>


### 2018 年 8 月 13 日发布的工作程序节点 FP1.9.9_1521 的更改日志
{: #199_1521}

<table summary="自 V1.9.9_1520 以来进行的更改">
<caption>自 V1.9.9_1520 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 软件包</td>
<td>不适用</td>
<td>不适用</td>
<td>已安装的 Ubuntu 软件包的更新。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 27 日发布的 1.9.9_1520 的更改日志
{: #199_1520}

<table summary="自 V1.9.8_1517 以来进行的更改">
<caption>自 V1.9.8_1517 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.8-141</td>
<td>V1.9.9-167</td>
<td>更新为支持 Kubernetes 1.9.9 发行版。此外，LoadBalancer 服务 `create failure` 事件现在包含任何可移植子网错误。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>320</td>
<td>334</td>
<td>将创建持久性卷的超时从 15 分钟增加到 30 分钟。将缺省计费类型更改为 `hourly`。向预定义存储类添加了安装选项。在 IBM Cloud Infrastructure (SoftLayer) 帐户的 NFS 文件存储器实例中，已将**注释**字段更改为 JSON 格式，并添加了 PV 部署到的 Kubernetes 名称空间。为了支持多专区集群，向持久性卷添加了专区和区域标签。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.9.8</td>
<td>V1.9.9</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9)。</td>
</tr>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载对工作程序节点网络设置进行了小幅改进。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署现在由 Kubernetes `addon-manager` 进行管理。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 3 日发布的工作程序节点 FP1.9.8_1517 的更改日志
{: #198_1517}

<table summary="自 V1.9.8_1516 以来进行的更改">
<caption>自 V1.9.8_1516 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载优化了 `sysctl`。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 21 日发布的工作程序节点 FP1.9.8_1516 的更改日志
{: #198_1516}

<table summary="自 V1.9.8_1515 以来进行的更改">
<caption>自 V1.9.8_1515 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>对于未加密的机器类型，重新装入或更新工作程序节点时，将通过获取全新文件系统来清除辅助磁盘。</td>
</tr>
</tbody>
</table>

### 2018 年 6 月 19 日发布的 1.9.8_1515 的更改日志
{: #198_1515}

<table summary="自 V1.9.7_1513 以来进行的更改">
<caption>自 V1.9.7_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.9.7</td>
<td>V1.9.8</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 --admission-control 选项添加了 PodSecurityPolicy，并将集群配置为支持 pod 安全策略。有关更多信息，请参阅[配置 pod 安全策略](cs_psp.html)。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>V1.9.7-102</td>
<td>V1.9.8-141</td>
<td>更新为支持 Kubernetes 1.9.8 发行版。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>向在 <code>kube-system</code> 名称空间中运行的 OpenVPN 客户机 <code>vpn</code> 部署添加了 <code>livenessProbe</code>。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 11 日发布的工作程序节点 FP1.9.7_1513 的更改日志
{: #197_1513}

<table summary="自 V1.9.7_1512 以来进行的更改">
<caption>自 V1.9.7_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序节点映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 18 日发布的工作程序节点 FP1.9.7_1512 的更改日志
{: #197_1512}

<table summary="自 V1.9.7_1511 以来进行的更改">
<caption>自 V1.9.7_1511 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 16 日发布的工作程序节点 FP1.9.7_1511 的更改日志
{: #197_1511}

<table summary="自 V1.9.7_1510 以来进行的更改">
<caption>自 V1.9.7_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>

### 2018 年 4 月 30 日发布的 1.9.7_1510 的更改日志
{: #197_1510}

<table summary="自 V1.9.3_1506 以来进行的更改">
<caption>自 V1.9.3_1506 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.9.3</td>
<td>V1.9.7</td>
<td><p>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7)。此发行版解决了 [CVE-2017-1002101 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 和 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>注</strong>：现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，应用程序可以将数据写入这些卷，但系统可能会自动还原数据。如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</p></td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 `--runtime-config` 选项添加了 `admissionregistration.k8s.io/v1alpha1=true`。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.3-71</td>
<td>V1.9.7-102</td>
<td>`NodePort` 和 `LoadBalancer` 服务现在通过将 `service.spec.externalTrafficPolicy` 设置为 `Local` 来支持[保留客户机源 IP](cs_loadbalancer.html#node_affinity_tolerations)。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>修正旧集群的[边缘节点](cs_edge.html#edge)容忍度设置。</td>
</tr>
</tbody>
</table>

<br />


## 归档
{: #changelog_archive}

不支持的 Kubernetes 版本：
*  [V1.8](#18_changelog)
*  [V1.7](#17_changelog)

### V1.8 更改日志（不受支持）
{: #18_changelog}

查看以下更改。

### 2018 年 9 月 20 日发布的工作程序节点 FP1.8.15_1521 的更改日志
{: #1815_1521}

<table summary="自 V1.8.15_1520 以来进行的更改">
<caption>自 V1.8.15_1520 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>日志循环</td>
<td>不适用</td>
<td>不适用</td>
<td>切换到使用 `systemd` 计时器，而不使用 `cronjobs`，以防止 `logrotate` 因工作程序节点 90 天内未重新装入或更新而失败。**注**：在该次发行版的所有更早版本中，由于日志不循环，因此在定时作业失败后，主磁盘会填满。在工作程序节点 90 天内处于活动状态而未更新或重新装入后，定时作业会失败。如果日志填满整个主磁盘，那么工作程序节点将进入故障状态。使用 `ibmcloud ks worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)或 `ibmcloud ks worker-update` [命令](cs_cli_reference.html#cs_worker_update)可以修复工作程序节点。</td>
</tr>
<tr>
<td>工作程序节点运行时组件（`kubelet`、`kube-proxy` 和 `docker`）</td>
<td>不适用</td>
<td>不适用</td>
<td>除去了运行时组件对主磁盘的依赖关系。此增强功能可防止工作程序节点在主磁盘填满时发生故障。</td>
</tr>
<tr>
<td>root 用户密码到期</td>
<td>不适用</td>
<td>不适用</td>
<td>由于合规性原因，工作程序节点的 root 用户密码会在 90 天后到期。如果自动化工具需要以 root 用户身份登录到工作程序节点，或者依赖于以 root 用户身份运行的定时作业，那么可以通过登录到工作程序节点并运行 `chage -M -1 root` 来禁用密码到期。**注**：如果您有阻止以 root 用户身份运行或阻止除去到期密码的安全合规性需求，请不要禁用到期。您可以改为至少每 90 天[更新](cs_cli_reference.html#cs_worker_update)或[重新装入](cs_cli_reference.html#cs_worker_reload)一次工作程序节点。</td>
</tr>
<tr>
<td>Systemd</td>
<td>不适用</td>
<td>不适用</td>
<td>定期清除瞬态安装单元，以防止它们变得不受控制。此操作解决了 [Kubernetes 问题 57345 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/issues/57345)。</td>
</tr>
</tbody>
</table>

### 2018 年 8 月 23 日发布的工作程序节点 FP1.8.15_1520 的更改日志
{: #1815_1520}

<table summary="自 V1.8.15_1519 以来进行的更改">
<caption>自 V1.8.15_1519 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>更新了 `systemd` 以修复 `cgroup` 泄漏。</td>
</tr>
<tr>
<td>内核</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>使用 [CVE-2018-3620、CVE-2018-3646 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://usn.ubuntu.com/3741-1/) 的内核更新对工作程序节点映像进行了更新。</td>
</tr>
</tbody>
</table>

### 2018 年 8 月 13 日发布的工作程序节点 FP1.8.15_1519 的更改日志
{: #1815_1519}

<table summary="自 V1.8.15_1518 以来进行的更改">
<caption>自 V1.8.15_1518 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 软件包</td>
<td>不适用</td>
<td>不适用</td>
<td>已安装的 Ubuntu 软件包的更新。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 27 日发布的 1.8.15_1518 的更改日志
{: #1815_1518}

<table summary="自 V1.8.13_1516 以来进行的更改">
<caption>自 V1.8.13_1516 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.8.13-176</td>
<td>V1.8.15-204</td>
<td>更新为支持 Kubernetes 1.8.15 发行版。此外，LoadBalancer 服务 `create failure` 事件现在包含任何可移植子网错误。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>320</td>
<td>334</td>
<td>将创建持久性卷的超时从 15 分钟增加到 30 分钟。将缺省计费类型更改为 `hourly`。向预定义存储类添加了安装选项。在 IBM Cloud Infrastructure (SoftLayer) 帐户的 NFS 文件存储器实例中，已将**注释**字段更改为 JSON 格式，并添加了 PV 部署到的 Kubernetes 名称空间。为了支持多专区集群，向持久性卷添加了专区和区域标签。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.8.13</td>
<td>V1.8.15</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15)。</td>
</tr>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载对工作程序节点网络设置进行了小幅改进。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署现在由 Kubernetes `addon-manager` 进行管理。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 3 日发布的工作程序节点 FP1.8.13_1516 的更改日志
{: #1813_1516}

<table summary="自 V1.8.13_1515 以来进行的更改">
<caption>自 V1.8.13_1515 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载优化了 `sysctl`。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 21 日发布的工作程序节点 FP1.8.13_1515 的更改日志
{: #1813_1515}

<table summary="自 V1.8.13_1514 以来进行的更改">
<caption>自 V1.8.13_1514 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>对于未加密的机器类型，重新装入或更新工作程序节点时，将通过获取全新文件系统来清除辅助磁盘。</td>
</tr>
</tbody>
</table>

### 2018 年 6 月 19 日发布的 1.8.13_1514 的更改日志
{: #1813_1514}

<table summary="自 V1.8.11_1512 以来进行的更改">
<caption>自 V1.8.11_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.8.11</td>
<td>V1.8.13</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 --admission-control 选项添加了 PodSecurityPolicy，并将集群配置为支持 pod 安全策略。有关更多信息，请参阅[配置 pod 安全策略](cs_psp.html)。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>V1.8.11-126</td>
<td>V1.8.13-176</td>
<td>更新为支持 Kubernetes 1.8.13 发行版。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>向在 <code>kube-system</code> 名称空间中运行的 OpenVPN 客户机 <code>vpn</code> 部署添加了 <code>livenessProbe</code>。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 11 日发布的工作程序节点 FP1.8.11_1512 的更改日志
{: #1811_1512}

<table summary="自 V1.8.11_1511 以来进行的更改">
<caption>自 V1.8.11_1511 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序节点映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>


### 2018 年 5 月 18 日发布的工作程序节点 FP1.8.11_1511 的更改日志
{: #1811_1511}

<table summary="自 V1.8.11_1510 以来进行的更改">
<caption>自 V1.8.11_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 16 日发布的工作程序节点 FP1.8.11_1510 的更改日志
{: #1811_1510}

<table summary="自 V1.8.11_1509 以来进行的更改">
<caption>自 V1.8.11_1509 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>


### 2018 年 4 月 19 日发布的 1.8.11_1509 的更改日志
{: #1811_1509}

<table summary="自 V1.8.8_1507 以来进行的更改">
<caption>自 V1.8.8_1507 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.8.8</td>
<td>V1.8.11</td>
<td><p>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)。此发行版解决了 [CVE-2017-1002101 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 和 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>注</strong>：现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，应用程序可以将数据写入这些卷，但系统可能会自动还原数据。如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</p></td>
</tr>
<tr>
<td>暂停容器映像</td>
<td>3.0</td>
<td>3.1</td>
<td>除去继承的孤立 zombie 进程。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.8.8-86</td>
<td>V1.8.11-126</td>
<td>`NodePort` 和 `LoadBalancer` 服务现在通过将 `service.spec.externalTrafficPolicy` 设置为 `Local` 来支持[保留客户机源 IP](cs_loadbalancer.html#node_affinity_tolerations)。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>修正旧集群的[边缘节点](cs_edge.html#edge)容忍度设置。</td>
</tr>
</tbody>
</table>

<br />


### V1.7 更改日志（不受支持）
{: #17_changelog}

查看以下更改。

#### 2018 年 6 月 11 日发布的工作程序节点 FP1.7.16_1514 的更改日志
{: #1716_1514}

<table summary="自 V1.7.16_1513 以来进行的更改">
<caption>自 V1.7.16_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序节点映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>

#### 2018 年 5 月 18 日发布的工作程序节点 FP1.7.16_1513 的更改日志
{: #1716_1513}

<table summary="自 V1.7.16_1512 以来进行的更改">
<caption>自 V1.7.16_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

#### 2018 年 5 月 16 日发布的工作程序节点 FP1.7.16_1512 的更改日志
{: #1716_1512}

<table summary="自 V1.7.16_1511 以来进行的更改">
<caption>自 V1.7.16_1511 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>

#### 2018 年 4 月 19 日发布的 1.7.16_1511 的更改日志
{: #1716_1511}

<table summary="自 V1.7.4_1509 以来进行的更改">
<caption>自 V1.7.4_1509 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.7.4</td>
<td>V1.7.16</td>
<td><p>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)。此发行版解决了 [CVE-2017-1002101 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 和 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>注</strong>：现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，应用程序可以将数据写入这些卷，但系统可能会自动还原数据。如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.7.4-133</td>
<td>V1.7.16-17</td>
<td>`NodePort` 和 `LoadBalancer` 服务现在通过将 `service.spec.externalTrafficPolicy` 设置为 `Local` 来支持[保留客户机源 IP](cs_loadbalancer.html#node_affinity_tolerations)。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>修正旧集群的[边缘节点](cs_edge.html#edge)容忍度设置。</td>
</tr>
</tbody>
</table>
