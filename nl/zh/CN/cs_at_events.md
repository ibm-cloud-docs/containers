---

copyright:
  years: 2017, 2018
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


# {{site.data.keyword.cloudaccesstrailshort}} 事件
{: #at_events}

您可以使用 {{site.data.keyword.cloudaccesstrailshort}} 服务来查看、管理和审计 {{site.data.keyword.containershort_notm}} 集群中用户启动的活动。
{: shortdesc}

## 查找信息
{: #at-find}

{{site.data.keyword.cloudaccesstrailshort}} 事件在生成这些事件的 {{site.data.keyword.Bluemix_notm}} 区域中可用的 {{site.data.keyword.cloudaccesstrailshort}} **帐户域**中提供。{{site.data.keyword.cloudaccesstrailshort}} 事件还在与供应 {{site.data.keyword.cloudaccesstrailshort}} 服务的 Cloud Foundry 空间相关联的 {{site.data.keyword.cloudaccesstrailshort}} **空间域**中提供。

要监视管理活动，请执行以下操作：

1. 登录到 {{site.data.keyword.Bluemix_notm}} 帐户。
2. 在目录中，在 {{site.data.keyword.containershort_notm}} 的实例所在的帐户中供应 {{site.data.keyword.cloudaccesstrailshort}} 服务的实例。
3. 在 {{site.data.keyword.cloudaccesstrailshort}} 仪表板的 **管理** 选项卡上，单击**在 Kibana 中查看**。
4. 设置要查看其日志的时间范围。缺省值为 15 分钟。
5. 在**可用字段**列表中，单击**类型**。单击 **Activity Tracker** 的放大镜图标，以将日志仅限于该服务跟踪的日志。
6. 可以使用其他可用字段来缩小搜索范围。



## 跟踪事件
{: #events}

查看下表以获取发送到 {{site.data.keyword.cloudaccesstrailshort}} 的事件的列表。

有关服务如何工作的更多信息，请参阅 [{{site.data.keyword.cloudaccesstrailshort}} 文档](/docs/services/cloud-activity-tracker/index.html)。

有关跟踪的 Kubernetes 操作的更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/home/)。

<table>
  <tr>
    <th>操作</th>
    <th>描述</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>创建了绑定。</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>创建了配置映射。</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>删除了配置映射。</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>修补了配置映射。</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>更新了配置映射。</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>创建了事件。</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>删除了事件。</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>修补了事件。</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>更新了事件。</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>创建了范围限制。</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>删除了范围限制。</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>修补了范围限制。</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>更新了范围限制。</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>创建了名称空间。</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>删除了名称空间。</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>修补了名称空间。</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>更新了名称空间。</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>创建了节点。</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>删除了节点。</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>删除了节点。</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>修补了节点。</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>更新了节点。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>创建了持久性卷申领。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>删除了持久性卷申领。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>修补了持久性卷申领。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>更新了持久性卷申领。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>创建了持久性卷。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>删除了持久性卷。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>修补了持久性卷。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>更新了持久性卷。</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>创建了 pod。</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>删除了 pod。</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>修补了 pod。</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>更新了 pod。</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>创建了 pod 模板。</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>删除了 pod 模板。</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>修补了 pod 模板。</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>更新了 pod 模板。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>创建了复制控制器。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>删除了复制控制器。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>修补了复制控制器。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>更新了复制控制器。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>创建了资源配额。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>删除了资源配额。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>修补了资源配额。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>更新了资源配额。</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>创建了私钥。</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>删除了私钥。</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>查看了私钥。</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>修补了私钥。</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>更新了私钥。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>创建了服务帐户。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>删除了服务帐户。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>修补了服务帐户。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>更新了服务帐户。</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>创建了服务。</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>删除了服务。</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>修补了服务。</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>更新了服务。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，创建了修改 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，删除了修改 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，修补了修改 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，更新了修改 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，创建了 Webhook 配置验证。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，删除了 Webhook 配置验证。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，修补了 Webhook 配置验证。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>在 Kubernetes V1.9 和更高版本中，更新了 Webhook 配置验证。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>在 Kubernetes V1.8 中，创建了外部许可 Hook 配置。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>在 Kubernetes V1.8 中，删除了外部许可 Hook 配置。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>在 Kubernetes V1.8 中，修补了外部许可 Hook 配置。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>在 Kubernetes V1.8 中，更新了外部许可 Hook 配置。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>创建了控制器修订版。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>删除了控制器修订版。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>修补了控制器修订版。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>更新了控制器修订版。</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>创建了守护程序集。</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>删除了守护程序集。</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>修补了守护程序集。</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>更新了守护程序集。</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>创建了部署。</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>删除了部署。</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>修补了部署。</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>更新了部署。</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>创建了副本集。</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>删除了副本集。</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>修补了副本集。</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>更新了副本集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>创建了有状态集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>删除了有状态集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>修补了有状态集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>更新了有状态集。</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>创建了令牌复查。</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>创建了本地主题访问权复查。</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>创建了自助主题访问权复查。</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>创建了自助主题规则复查。</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>创建了主题访问权复查。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>创建了水平 pod 自动扩展策略。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>删除了水平 pod 自动扩展策略。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>修补了水平 pod 自动扩展策略。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>更新了水平 pod 自动扩展策略。</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>创建了作业。</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>删除了作业。</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>修补了作业。</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>更新了作业。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>创建了证书签名请求。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>删除了证书签名请求。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>修补了证书签名请求。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>更新了证书签名请求。</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>创建了 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>删除了 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>修补了 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>更新了 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>创建了网络策略。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>删除了网络策略。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>修补了网络策略。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>更新了网络策略。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>对于 Kubernetes V1.10 和更高版本，创建了 pod 安全策略。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>对于 Kubernetes V1.10 和更高版本，删除了 pod 安全策略。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>对于 Kubernetes V1.10 和更高版本，修补了 pod 安全策略。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>对于 Kubernetes V1.10 和更高版本，更新了 pod 安全策略。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.create</code></td>
    <td>创建了 pod 中断预算。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.delete</code></td>
    <td>删除了 pod 中断预算。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.patch</code></td>
    <td>修补了 pod 中断预算。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.update</code></td>
    <td>更新了 pod 中断预算。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>创建了集群角色绑定。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>删除了集群角色绑定。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>修补了集群角色绑定。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>更新了集群角色绑定。</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>创建了集群角色。</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>删除了集群角色。</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>修补了集群角色。</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>更新了集群角色。</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>创建了角色绑定。</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>删除了角色绑定。</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>修补了角色绑定。</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>更新了角色绑定。</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>创建了角色。</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>删除了角色。</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>修补了角色。</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>更新了角色。</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>创建了 pod 预设。</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>删除了 pod 预设。</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>修补了 pod 预设。</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>更新了 pod 预设。</td>
  </tr>
</table>
