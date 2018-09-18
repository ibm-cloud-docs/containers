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

您可以使用 {{site.data.keyword.cloudaccesstrailshort}} 服務，檢檢視、管理及審核 {{site.data.keyword.containershort_notm}} 叢集裡的使用者起始活動。
{: shortdesc}

## 尋找資訊
{: #at-find}

{{site.data.keyword.cloudaccesstrailshort}} 事件位於 {{site.data.keyword.cloudaccesstrailshort}} **帳戶網域** 中，而此帳戶網域位於產生事件的 {{site.data.keyword.Bluemix_notm}} 地區中。{{site.data.keyword.cloudaccesstrailshort}} 事件位於 {{site.data.keyword.cloudaccesstrailshort}} **空間網域**中，而此空間網域與佈建 {{site.data.keyword.cloudaccesstrailshort}} 服務的 Cloud Foundry 空間相關聯。

若要監視管理活動，請執行下列動作：

1. 登入 {{site.data.keyword.Bluemix_notm}} 帳戶。
2. 從型錄中，在與 {{site.data.keyword.containershort_notm}} 實例相同的帳戶中佈建 {{site.data.keyword.cloudaccesstrailshort}} 服務實例。
3. 在 {{site.data.keyword.cloudaccesstrailshort}} 儀表板的**管理**標籤上，按一下**在 Kibana 中檢視**。
4. 設定您要檢視其日誌的時間範圍。預設值為 15 分鐘。
5. 在**可用的欄位**清單中，按一下**類型**。按一下 **Activity Tracker** 的放大鏡圖示，將日誌限制為僅服務所追蹤的日誌。
6. 您可以使用其他可用的欄位，來縮小搜尋範圍。



## 追蹤事件
{: #events}

請查看下列各表來取得傳送至 {{site.data.keyword.cloudaccesstrailshort}} 的事件清單。

如需服務運作方式的相關資訊，請參閱 [{{site.data.keyword.cloudaccesstrailshort}} 文件](/docs/services/cloud-activity-tracker/index.html)。

如需所追蹤 Kubernetes 動作的相關資訊，請檢閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/home/)。

<table>
  <tr>
    <th>動作</th>
    <th>說明</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>已建立連結。</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>已建立配置對映。</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>已刪除配置對映。</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>已修補配置對映。</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>已更新配置對映。</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>已建立事件。</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>已刪除事件。</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>已修補事件。</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>已更新事件。</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>已建立範圍限制。</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>已刪除範圍限制。</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>已修補範圍限制。</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>已更新範圍限制。</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>已建立名稱空間。</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>已刪除名稱空間。</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>已修補名稱空間。</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>已更新名稱空間。</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>已建立節點。</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>已刪除節點。</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>已刪除節點。</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>已修補節點。</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>已更新節點。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>已建立持續性磁區要求。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>已刪除持續性磁區要求。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>已修補持續性磁區要求。</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>已更新持續性磁區要求。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>已建立持續性磁區。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>已刪除持續性磁區。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>已修補持續性磁區。</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>已更新持續性磁區。</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>已建立 Pod。</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>已刪除 Pod。</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>已修補 Pod。</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>已更新 Pod。</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>已建立 Pod 範本。</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>已刪除 Pod 範本。</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>已修補 Pod 範本。</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>已更新 Pod 範本。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>已建立抄寫控制器。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>已刪除抄寫控制器。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>已修補抄寫控制器。</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>已更新抄寫控制器。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>已建立資源配額。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>已刪除資源配額。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>已修補資源配額。</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>已更新資源配額。</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>已建立密碼。</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>已刪除密碼。</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>已檢視密碼。</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>已修補密碼。</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>已更新密碼。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>已建立服務帳戶。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>已刪除服務帳戶。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>已修補服務帳戶。</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>已更新服務帳戶。</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>已建立服務。</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>已刪除服務。</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>已修補服務。</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>已更新服務。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已建立變異 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已刪除變異 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已修補變異 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已更新變異 Webhook 配置。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已建立 Webhook 配置驗證。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已刪除 Webhook 配置驗證。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已修補 Webhook 配置驗證。</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>在 Kubernetes 1.9 版及更新版本中，已更新 Webhook 配置驗證。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>在 Kubernetes 1.8 版中，已建立外部許可連結鉤配置。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>在 Kubernetes 1.8 版中，已刪除外部許可連結鉤配置。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>在 Kubernetes 1.8 版中，已修補外部許可連結鉤配置。</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>在 Kubernetes 1.8 版中，已更新外部許可連結鉤配置。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>已建立控制器修訂。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>已刪除控制器修訂。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>已修補控制器修訂。</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>已更新控制器修訂。</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>已建立常駐程式集。</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>已刪除常駐程式集。</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>已修補常駐程式集。</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>已更新常駐程式集。</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>已建立部署。</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>已刪除部署。</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>已修補部署。</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>已更新部署。</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>已建立抄本集。</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>已刪除抄本集。</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>已修補抄本集。</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>已更新抄本集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>已建立有狀態集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>已刪除有狀態集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>已修補有狀態集。</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>已更新有狀態集。</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>已建立記號檢閱。</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>已建立本端主題存取檢閱。</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>已建立自我主題存取檢閱。</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>已建立自我主題規則檢閱。</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>已建立主題存取檢閱。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>已建立水平 Pod 自動調整原則。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>已刪除水平 Pod 自動調整原則。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>已修補水平 Pod 自動調整原則。</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>已更新水平 Pod 自動調整原則。</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>已建立工作。</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>已刪除工作。</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>已修補工作。</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>已更新工作。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>已建立簽署憑證要求。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>已刪除簽署憑證要求。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>已修補簽署憑證要求。</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>已更新簽署憑證要求。</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>已建立 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>已刪除 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>已修補 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>已更新 Ingress ALB。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>已建立網路原則。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>已刪除網路原則。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>已修補網路原則。</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>已更新網路原則。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>針對 Kubernetes 1.10 版及更新版本，已建立 Pod 安全原則。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>針對 Kubernetes 1.10 版及更新版本，已刪除 Pod 安全原則。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>針對 Kubernetes 1.10 版及更新版本，已修補 Pod 安全原則。</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>針對 Kubernetes 1.10 版及更新版本，已更新 Pod 安全原則。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.create</code></td>
    <td>已建立 Pod 中斷 buget。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.delete</code></td>
    <td>已刪除 Pod 中斷 buget。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.patch</code></td>
    <td>已修補 Pod 中斷 buget。</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.update</code></td>
    <td>已更新 Pod 中斷 buget。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>已建立叢集角色連結。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>已刪除叢集角色連結。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>已修補叢集角色連結。</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>已更新叢集角色連結。</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>已建立叢集角色。</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>已刪除叢集角色。</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>已修補叢集角色。</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>已更新叢集角色。</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>已建立角色連結。</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>已刪除角色連結。</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>已修補角色連結。</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>已更新角色連結。</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>已建立角色。</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>已刪除角色。</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>已修補角色。</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>已更新角色。</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>已建立 Pod 預設。</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>已刪除 Pod 預設。</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>已修補 Pod 預設。</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>已更新 Pod 預設。</td>
  </tr>
</table>
