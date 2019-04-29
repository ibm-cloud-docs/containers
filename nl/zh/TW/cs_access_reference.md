---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="blank"}
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


# 使用者存取許可權
{: #access_reference}

當您[指派叢集許可權](/docs/containers?topic=containers-users)時，很難判斷您需要指派給使用者的角色。使用下列各節中的表格，來判定在 {{site.data.keyword.containerlong}} 中執行一般作業所需的最低許可權層次。
{: shortdesc}

自 2019 年 1 月 30 日起，{{site.data.keyword.containerlong_notm}} 有一個新方式來授權使用者使用 {{site.data.keyword.Bluemix_notm}} IAM：[服務存取角色](#service)。這些服務角色用來授與對叢集中資源的存取權，例如 Kubernetes 名稱空間。如需相關資訊，請看部落格[介紹 IAM 中的服務角色和名稱空間，對於叢集存取有更精細的控制 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2019/02/introducing-service-roles-and-namespaces-in-iam-for-more-granular-control-of-cluster-access/)。
{: note}

## {{site.data.keyword.Bluemix_notm}} IAM 平台角色
{: #iam_platform}

{{site.data.keyword.containerlong_notm}} 會配置為使用 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 角色。{{site.data.keyword.Bluemix_notm}} IAM 平台角色決定使用者可對 {{site.data.keyword.Bluemix_notm}} 資源（例如叢集、工作者節點及 Ingress 應用程式負載平衡器）執行的動作。{{site.data.keyword.Bluemix_notm}} IAM 平台角色也為使用者自動設定基本基礎架構許可權。若要設定平台角色，請參閱[指派 {{site.data.keyword.Bluemix_notm}} IAM 平台許可權](/docs/containers?topic=containers-users#platform)。
{: shortdesc}

下列每一節的表格顯示每一個 {{site.data.keyword.Bluemix_notm}} IAM 平台角色所授與的叢集管理、記載和 Ingress 許可權。這些表格是按 CLI 指令名稱的字母順序來排列。

* [不需要許可權的動作](#none-actions)
* [檢視者動作](#view-actions)
* [編輯者動作](#editor-actions)
* [操作員動作](#operator-actions)
* [管理者動作](#admin-actions)

### 不需要許可權的動作
{: #none-actions}

您帳戶中執行 CLI 指令或對下表中的動作進行 API 呼叫的任何使用者都會看到結果（即使該使用者沒有指派的許可權）。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中不需要許可權的 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="none-actions-action">叢集管理動作</th>
<th id="none-actions-cli">CLI 指令</th>
<th id="none-actions-api">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>瞄準或檢視 {{site.data.keyword.containerlong_notm}} 的 API 端點。</td>
<td><code>[ibmcloud ks api](/docs/containers?topic=containers-cs_cli_reference#cs_api)</code></td>
<td>-</td>
</tr>
<tr>
<td>檢視所支援指令及參數的清單。</td>
<td><code>[ibmcloud ks help](/docs/containers?topic=containers-cs_cli_reference#cs_help)</code></td>
<td>-</td>
</tr>
<tr>
<td>起始設定 {{site.data.keyword.containerlong_notm}} 外掛程式，或指定您要建立或存取 Kubernetes 叢集的地區。</td>
<td><code>[ibmcloud ks init](/docs/containers?topic=containers-cs_cli_reference#cs_init)</code></td>
<td>-</td>
</tr>
<tr>
<td>檢視 {{site.data.keyword.containerlong_notm}} 中支援的 Kubernetes 版本清單。</td><td><code>[ibmcloud ks kube-versions](/docs/containers?topic=containers-cs_cli_reference#cs_kube_versions)</code></td>
<td><code>[GET /v1/kube-versions](https://containers.cloud.ibm.com/swagger-api/#!/util/GetKubeVersions)</code></td>
</tr>
<tr>
<td>檢視工作者節點的可用機型清單。</td>
<td><code>[ibmcloud ks machine-types](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/machine-types](https://containers.cloud.ibm.com/swagger-api/#!/util/GetDatacenterMachineTypes)</code></td>
</tr>
<tr>
<td>檢視 IBMid 使用者的現行訊息。</td>
<td><code>[ibmcloud ks messages](/docs/containers?topic=containers-cs_cli_reference#cs_messages)</code></td>
<td><code>[GET /v1/messages](https://containers.cloud.ibm.com/swagger-api/#!/util/GetMessages)</code></td>
</tr>
<tr>
<td>尋找您目前所在的 {{site.data.keyword.containerlong_notm}} 地區。</td>
<td><code>[ibmcloud ks region](/docs/containers?topic=containers-cs_cli_reference#cs_region)</code></td>
<td>-</td>
</tr>
<tr>
<td>設定 {{site.data.keyword.containerlong_notm}} 的地區。</td>
<td><code>[ibmcloud ks region-set](/docs/containers?topic=containers-cs_cli_reference#cs_region-set)</code></td>
<td>-</td>
</tr>
<tr>
<td>列出可用的地區。</td>
<td><code>[ibmcloud ks regions](/docs/containers?topic=containers-cs_cli_reference#cs_regions)</code></td>
<td><code>[GET /v1/regions](https://containers.cloud.ibm.com/swagger-api/#!/util/GetRegions)</code></td>
</tr>
<tr>
<td>檢視可讓您在其中建立叢集的可用區域清單。</td>
<td><code>[ibmcloud ks zones](/docs/containers?topic=containers-cs_cli_reference#cs_datacenters)</code></td>
<td><code>[GET /v1/zones](https://containers.cloud.ibm.com/swagger-api/#!/util/GetZones)</code></td>
</tr>
</tbody>
</table>

### 檢視者動作
{: #view-actions}

**檢視者**平台角色包括[不需要許可權的動作](#none-actions)，以及下表所顯示的許可權。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「檢視者」平台角色的叢集管理 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="view-actions-mngt">叢集管理動作</th>
<th id="view-actions-cli">CLI 指令</th>
<th id="view-actions-api">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>檢視資源群組及地區之 {{site.data.keyword.Bluemix_notm}} IAM API 金鑰擁有者的名稱及電子郵件位址。</td>
<td><code>[ibmcloud ks api-key-info](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_info)</code></td>
<td><code>[GET /v1/logging/{idOrName}/clusterkeyowner](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetClusterKeyOwner)</code></td>
</tr>
<tr>
<td>下載 Kubernetes 配置資料及憑證來連接至叢集，並執行 `kubectl` 指令。</td>
<td><code>[ibmcloud ks cluster-config](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/config](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterConfig)</code></td>
</tr>
<tr>
<td>檢視叢集的資訊。</td>
<td><code>[ibmcloud ks cluster-get](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetCluster)</code></td>
</tr>
<tr>
<td>列出所有連結至叢集的名稱空間中的所有服務。</td>
<td><code>[ibmcloud ks cluster-services](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_services)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ListServicesForAllNamespaces)</code></td>
</tr>
<tr>
<td>列出所有叢集。</td>
<td><code>[ibmcloud ks clusters](/docs/containers?topic=containers-cs_cli_reference#cs_clusters)</code></td>
<td><code>[GET /v1/clusters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusters)</code></td>
</tr>
<tr>
<td>取得針對 {{site.data.keyword.Bluemix_notm}} 帳戶設定的基礎架構認證，以存取不同的 IBM Cloud 基礎架構 (SoftLayer) 組合。</td>
<td><code>[ibmcloud ks credential-get](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get)</code></td><td><code>[GET /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/accounts/GetUserCredentials)</code></td>
</tr>
<tr>
<td>列出所有連結至特定名稱空間的服務。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/services/{namespace}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ListServicesInNamespace)</code></td>
</tr>
<tr>
<td>列出所有連結至叢集的使用者管理的子網路。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterUserSubnet)</code></td>
</tr>
<tr>
<td>列出基礎架構帳戶中的可用子網路。</td>
<td><code>[ibmcloud ks subnets](/docs/containers?topic=containers-cs_cli_reference#cs_subnets)</code></td>
<td><code>[GET /v1/subnets](https://containers.cloud.ibm.com/swagger-api/#!/properties/ListSubnets)</code></td>
</tr>
<tr>
<td>檢視基礎架構帳戶的 VLAN Spanning 狀態。</td>
<td><code>[ibmcloud ks vlan-spanning-get](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)</code></td>
<td><code>[GET /v1/subnets/vlan-spanning](https://containers.cloud.ibm.com/swagger-api/#!/accounts/GetVlanSpanning)</code></td>
</tr>
<tr>
<td>針對一個叢集設定時：列出區域中叢集所連接的 VLAN。</br>針對帳戶中的所有叢集設定時：列出區域中所有可用的 VLAN。</td>
<td><code>[ibmcloud ks vlans](/docs/containers?topic=containers-cs_cli_reference#cs_vlans)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/vlans](https://containers.cloud.ibm.com/swagger-api/#!/properties/GetDatacenterVLANs)</code></td>
</tr>
<tr>
<td>列出叢集的所有 Webhook。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterWebhooks)</code></td>
</tr>
<tr>
<td>檢視工作者節點的資訊。</td>
<td><code>[ibmcloud ks worker-get](/docs/containers?topic=containers-cs_cli_reference#cs_worker_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkers)</code></td>
</tr>
<tr>
<td>檢視工作者節點儲存區的資訊。</td>
<td><code>[ibmcloud ks worker-pool-get](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkerPool)</code></td>
</tr>
<tr>
<td>列出叢集中的所有工作者節點儲存區。</td>
<td><code>[ibmcloud ks worker-pools](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pools)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkerPools)</code></td>
</tr>
<tr>
<td>列出叢集中的所有工作者節點。</td>
<td><code>[ibmcloud ks workers](/docs/containers?topic=containers-cs_cli_reference#cs_workers)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterWorkers)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「檢視者」平台角色的 Ingress CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="view-actions-ingress">Ingress 動作</th>
<th id="view-actions-cli2">CLI 指令</th>
<th id="view-actions-api2">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>檢視 Ingress ALB 的資訊。</td>
<td><code>[ibmcloud ks alb-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_get)</code></td>
<td><code>[GET /albs/{albId}](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetClusterALB)</code></td>
</tr>
<tr>
<td>檢視地區中支援的 ALB 類型。</td>
<td><code>[ibmcloud ks alb-types](/docs/containers?topic=containers-cs_cli_reference#cs_alb_types)</code></td>
<td><code>[GET /albtypes](https://containers.cloud.ibm.com/swagger-alb-api/#!/util/GetAvailableALBTypes)</code></td>
</tr>
<tr>
<td>列出叢集中的所有 Ingress ALB。</td>
<td><code>[ibmcloud ks albs](/docs/containers?topic=containers-cs_cli_reference#cs_albs)</code></td>
<td><code>[GET /clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetClusterALBs)</code></td>
</tr>
</tbody>
</table>


<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「檢視者」平台角色的記載 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="view-actions-log">記載動作</th>
<th id="view-actions-cli3">CLI 指令</th>
<th id="view-actions-api3">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>檢視 Fluentd 附加程式的自動更新狀態。</td>
<td><code>[ibmcloud ks logging-autoupdate-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>檢視目標地區的預設記載端點。</td>
<td>-</td>
<td><code>[GET /v1/logging/{idOrName}/default](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetDefaultLoggingEndpoint)</code></td>
</tr>
<tr>
<td>列出叢集中或叢集中特定的日誌來源的所有日誌轉遞配置。</td>
<td><code>[ibmcloud ks logging-config-get](/docs/containers?topic=containers-cs_cli_reference#cs_logging_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/swagger-logging/#!/logging/FetchLoggingConfigs) and [GET /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/FetchLoggingConfigsForSource)</code></td>
</tr>
<tr>
<td>檢視日誌過濾配置的資訊。</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/FetchFilterConfig)</code></td>
</tr>
<tr>
<td>列出叢集中的所有記載過濾器配置。</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/FetchFilterConfigs)</code></td>
</tr>
</tbody>
</table>

### 編輯者動作
{: #editor-actions}

**編輯者**平台角色包括**檢視者**授與的許可權，以及下列許可權。**提示**：請對應用程式開發人員使用此角色，並指派 <a href="#cloud-foundry">Cloud Foundry</a> **開發人員**角色。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「編輯者」平台角色的叢集管理 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="editor-actions-mngt">叢集管理動作</th>
<th id="editor-actions-cli">CLI 指令</th>
<th id="editor-actions-api">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>將服務連結至叢集。**附註**：也需要該服務所在空間中的 Developer Cloud Foundry 角色。</td>
<td><code>[ibmcloud ks cluster-service-bind](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_service_bind)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/swagger-api/#!/clusters/BindServiceToNamespace)</code></td>
</tr>
<tr>
<td>將服務與叢集取消連結。**附註**：也需要該服務所在空間中的 Developer Cloud Foundry 角色。</td>
<td><code>[ibmcloud ks cluster-service-unbind](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_service_unbind)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/services/{namespace}/{serviceInstanceId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UnbindServiceFromNamespace)</code></td>
</tr>
<tr>
<td>在叢集中建立 Webhook。</td>
<td><code>[ibmcloud ks webhook-create](/docs/containers?topic=containers-cs_cli_reference#cs_webhook_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterWebhooks)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「編輯者」平台角色的 Ingress CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="editor-actions-ingress">Ingress 動作</th>
<th id="editor-actions-cli2">CLI 指令</th>
<th id="editor-actions-api2">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>停用 Ingress ALB 附加程式的自動更新。</td>
<td><code>[ibmcloud ks alb-autoupdate-disable](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>啟用 Ingress ALB 附加程式的自動更新。</td>
<td><code>[ibmcloud ks alb-autoupdate-enable](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>檢查是否已啟用 Ingress ALB 附加程式的自動更新。</td>
<td><code>[ibmcloud ks alb-autoupdate-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</code></td>
<td><code>[GET /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>啟用或停用 Ingress ALB。</td>
<td><code>[ibmcloud ks alb-configure](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure)</code></td>
<td><code>[POST /albs](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/EnableALB) and [DELETE /albs/{albId}](https://containers.cloud.ibm.com/swagger-alb-api/#/)</code></td>
</tr>
<tr>
<td>將 Ingress ALB 附加程式更新回復至您的 ALB Pod 先前執行的建置。</td>
<td><code>[ibmcloud ks alb-rollback](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</code></td>
<td><code>[PUT /clusters/{idOrName}/updaterollback](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/RollbackUpdate)</code></td>
</tr>
<tr>
<td>手動更新 Ingress ALB 附加程式，以強制一次性更新您的 ALB Pod。</td>
<td><code>[ibmcloud ks alb-update](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</code></td>
<td><code>[PUT /clusters/{idOrName}/update](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/UpdateALBs)</code></td>
</tr>
</tbody>
</table>



<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「編輯者」平台角色的記載 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="editor-log">記載動作</th>
<th id="editor-cli3">CLI 指令</th>
<th id="editor-api3">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>建立 API 伺服器審核 Webhook。</td>
<td><code>[ibmcloud ks apiserver-config-set](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_config_set)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/swagger-api/#!/clusters/apiserverconfigs/UpdateAuditWebhook)</code></td>
</tr>
<tr>
<td>刪除 API 伺服器審核 Webhook。</td>
<td><code>[ibmcloud ks apiserver-config-unset](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_config_unset)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/swagger-api/#!/apiserverconfigs/DeleteAuditWebhook)</code></td>
</tr>
<tr>
<td>為所有日誌來源（<code>kube-audit</code> 除外）建立日誌轉遞配置。</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cs_cli_reference#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>重新整理日誌轉遞配置。</td>
<td><code>[ibmcloud ks logging-config-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_logging_refresh)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/refresh](https://containers.cloud.ibm.com/swagger-logging/#!/logging/RefreshLoggingConfig)</code></td>
</tr>
<tr>
<td>為所有日誌來源（<code>kube-audit</code> 除外）刪除日誌轉遞配置。</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cs_cli_reference#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfig)</code></td>
</tr>
<tr>
<td>刪除叢集的所有日誌轉遞配置。</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfigs)</code></td>
</tr>
<tr>
<td>更新日誌轉遞配置。
    </td>
<td><code>[ibmcloud ks logging-config-update](/docs/containers?topic=containers-cs_cli_reference#cs_logging_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/UpdateLoggingConfig)</code></td>
</tr>
<tr>
<td>建立日誌過濾配置。</td>
<td><code>[ibmcloud ks logging-filter-create](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/CreateFilterConfig)</code></td>
</tr>
<tr>
<td>刪除日誌過濾配置。</td>
<td><code>[ibmcloud ks logging-filter-rm](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_delete)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/DeleteFilterConfig)</code></td>
</tr>
<tr>
<td>刪除 Kubernetes 叢集的所有記載過濾器配置。</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/DeleteFilterConfigs)</code></td>
</tr>
<tr>
<td>更新日誌過濾配置。</td>
<td><code>[ibmcloud ks logging-filter-update](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/UpdateFilterConfig)</code></td>
</tr>
</tbody>
</table>

### 操作員動作
{: #operator-actions}

**操作員**平台角色包括**檢視者**授與的許可權，以及下表所顯示的許可權。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「操作員」平台角色的叢集管理 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="operator-mgmt">叢集管理動作</th>
<th id="operator-cli">CLI 指令</th>
<th id="operator-api">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>重新整理 Kubernetes 主節點。</td>
<td><code>[ibmcloud ks apiserver-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>建立叢集的 {{site.data.keyword.Bluemix_notm}} IAM 服務 ID，為在 {{site.data.keyword.registrylong_notm}} 中指派**讀者**服務存取角色的服務 ID 建立一個原則，然後建立服務 ID 的 API 金鑰。</td>
<td><code>[ibmcloud ks cluster-pull-secret-apply](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_pull_secret_apply)</code></td>
<td>-</td>
</tr>
<tr>
<td>重新啟動叢集主節點，以套用新的 Kubernet API 配置變更。</td>
<td><code>[ibmcloud ks cluster-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>將子網路新增至叢集。</td>
<td><code>[ibmcloud ks cluster-subnet-add](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_subnet_add)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterSubnet)</code></td>
</tr>
<tr>
<td>建立子網路。</td>
<td><code>[ibmcloud ks cluster-subnet-create](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_subnet_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateClusterSubnet)</code></td>
</tr>
<tr>
<td>更新叢集。</td>
<td><code>[ibmcloud ks cluster-update](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateCluster)</code></td>
</tr>
<tr>
<td>將使用者管理的子網路新增至叢集。</td>
<td><code>[ibmcloud ks cluster-user-subnet-add](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_user_subnet_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterUserSubnet)</code></td>
</tr>
<tr>
<td>從叢集中移除使用者管理的子網路。</td>
<td><code>[ibmcloud ks cluster-user-subnet-rm](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_user_subnet_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveClusterUserSubnet)</code></td>
</tr>
<tr>
<td>新增工作者節點。</td>
<td><code>[ibmcloud ks worker-add (deprecated)](/docs/containers?topic=containers-cs_cli_reference#cs_worker_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterWorkers)</code></td>
</tr>
<tr>
<td>建立工作者節點儲存區。</td>
<td><code>[ibmcloud ks worker-pool-create](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateWorkerPool)</code></td>
</tr>
<tr>
<td>重新平衡工作者節點儲存區。</td>
<td><code>[ibmcloud ks worker-pool-rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>調整工作者節點儲存區的大小。</td>
<td><code>[ibmcloud ks worker-pool-resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>刪除工作者節點儲存區。</td>
<td><code>[ibmcloud ks worker-pool-rm](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveWorkerPool)</code></td>
</tr>
<tr>
<td>重新啟動工作者節點。</td>
<td><code>[ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>重新載入工作者節點。</td>
<td><code>[ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>移除工作者節點。</td>
<td><code>[ibmcloud ks worker-rm](/docs/containers?topic=containers-cs_cli_reference#cs_worker_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveClusterWorker)</code></td>
</tr>
<tr>
<td>更新工作者節點。</td>
<td><code>[ibmcloud ks worker-update](/docs/containers?topic=containers-cs_cli_reference#cs_worker_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>將區域新增至工作者節點儲存區。</td>
<td><code>[ibmcloud ks zone-add](/docs/containers?topic=containers-cs_cli_reference#cs_zone_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddWorkerPoolZone)</code></td>
</tr>
<tr>
<td>更新工作者節點儲存區中給定的區域的網路配置。</td>
<td><code>[ibmcloud ks zone-network-set](/docs/containers?topic=containers-cs_cli_reference#cs_zone_network_set)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddWorkerPoolZoneNetwork)</code></td>
</tr>
<tr>
<td>從工作者節點儲存區中移除區域。</td>
<td><code>[ibmcloud ks zone-rm](/docs/containers?topic=containers-cs_cli_reference#cs_zone_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveWorkerPoolZone)</code></td>
</tr>
</tbody>
</table>

### 管理者動作
{: #admin-actions}

**管理者**平台角色包括**檢視者**、**編輯者**及**操作員**角色授與的所有許可權，以及下列許可權。若要建立機器、VLAN 及子網路之類的資源，「管理者」使用者需要**超級使用者**<a href="#infra">基礎架構角色</a>。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「管理者」平台角色的叢集管理 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="admin-mgmt">叢集管理動作</th>
<th id="admin-cli">CLI 指令</th>
<th id="admin-api">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>設定 {{site.data.keyword.Bluemix_notm}} 帳戶的 API 金鑰，以存取鏈結的 IBM Cloud 基礎架構 (SoftLayer) 組合。</td>
<td><code>[ibmcloud ks api-key-reset](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_reset)</code></td>
<td><code>[POST /v1/keys](https://containers.cloud.ibm.com/swagger-api/#!/accounts/ResetUserAPIKey)</code></td>
</tr>
<tr>
<td>在叢集中停用受管理的附加程式，例如，Istio 或 Knative。</td>
<td><code>[ibmcloud ks cluster-addon-disable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>在叢集中啟用受管理的附加程式，例如，Istio 或 Knative。</td>
<td><code>[ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>列出叢集中已啟用的受管理附加程式，例如，Istio 或 Knative。</td>
<td><code>[ibmcloud ks cluster-addons](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterAddons)</code></td>
</tr>
<tr>
<td>建立免費或標準叢集。**附註**：也需要 {{site.data.keyword.registrylong_notm}} 的「管理者」平台角色以及「超級使用者」基礎架構角色。</td>
<td><code>[ibmcloud ks cluster-create](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create)</code></td>
<td><code>[POST /v1/clusters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateCluster)</code></td>
</tr>
<tr>
<td>停用叢集的指定特性，例如主要叢集的公用服務端點。</td>
<td><code>[ibmcloud ks cluster-feature-disable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable)</code></td>
<td>-</td>
</tr>
<tr>
<td>啟用叢集的指定特性，例如主要叢集的專用服務端點。</td>
<td><code>[ibmcloud ks cluster-feature-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)</code></td>
<td>-</td>
</tr>
<tr>
<td>列出叢集中已啟用的特性。</td>
<td><code>[ibmcloud ks cluster-features](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_ls)</code></td>
<td>-</td>
</tr>
<tr>
<td>刪除叢集。</td>
<td><code>[ibmcloud ks cluster-rm](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveCluster)</code></td>
</tr>
<tr>
<td>設定 {{site.data.keyword.Bluemix_notm}} 帳戶的基礎架構認證，以存取不同的 IBM Cloud 基礎架構 (SoftLayer) 組合。</td>
<td><code>[ibmcloud ks credential-set](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_set)</code></td>
<td><code>[POST /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/clusters/accounts/StoreUserCredentials)</code></td>
</tr>
<tr>
<td>移除 {{site.data.keyword.Bluemix_notm}} 帳戶的基礎架構認證，以存取不同的 IBM Cloud 基礎架構 (SoftLayer) 組合。</td>
<td><code>[ibmcloud ks credential-unset](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_unset)</code></td>
<td><code>[DELETE /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/clusters/accounts/RemoveUserCredentials)</code></td>
</tr>
<tr>
<td>使用 {{site.data.keyword.keymanagementservicefull}} 來加密 Kubernetes 密碼。</td>
<td><code>[ibmcloud ks key-protect-enable](/docs/containers?topic=containers-cs_cli_reference#cs_messages)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/kms](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateKMSConfig)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「管理者」平台角色的 Ingress CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="admin-ingress">Ingress 動作</th>
<th id="admin-cli2">CLI 指令</th>
<th id="admin-api2">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>將 {{site.data.keyword.cloudcerts_long_notm}} 實例中的憑證部署或更新至 ALB。</td>
<td><code>[ibmcloud ks alb-cert-deploy](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_deploy)</code></td>
<td><code>[POST /albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/CreateALBSecret) or [PUT /albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/UpdateALBSecret)</code></td>
</tr>
<tr>
<td>檢視叢集中 ALB 密碼的詳細資料。</td>
<td><code>[ibmcloud ks alb-cert-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_get)</code></td>
<td><code>[GET /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ViewClusterALBSecrets)</code></td>
</tr>
<tr>
<td>從叢集中移除 ALB 密碼。</td>
<td><code>[ibmcloud ks alb-cert-rm](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/DeleteClusterALBSecrets)</code></td>
</tr>
<tr>
<td>列出叢集中的所有 ALB 密碼。</td>
<td><code>[ibmcloud ks alb-certs](/docs/containers?topic=containers-cs_cli_reference#cs_alb_certs)</code></td>
<td>-</td>
</tr>
</tbody>
</table>

<table>
<caption>{{site.data.keyword.containerlong_notm}} 中需要「管理者」平台角色的記載 CLI 指令及 API 呼叫的概觀</caption>
<thead>
<th id="admin-log">記載動作</th>
<th id="admin-cli3">CLI 指令</th>
<th id="admin-api3">API 呼叫</th>
</thead>
<tbody>
<tr>
<td>停用 Fluentd 叢集附加程式的自動更新。</td>
<td><code>[ibmcloud ks logging-autoupdate-disable](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_disable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>啟用 Fluentd 叢集附加程式的自動更新。</td>
<td><code>[ibmcloud ks logging-autoupdate-enable](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_enable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>收集 {{site.data.keyword.cos_full_notm}} 儲存區中 API 伺服器日誌的 Snapshot。</td>
<td><code>[ibmcloud ks logging-collect](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect)</code></td>
<td>-</td>
</tr>
<tr>
<td>請參閱 API 伺服器日誌 Snapshot 要求的狀態。</td>
<td><code>[ibmcloud ks logging-collect-status](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status)</code></td>
<td>-</td>
</tr>
<tr>
<td>建立 <code>kube-audit</code> 日誌來源的日誌轉遞配置。</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cs_cli_reference#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>刪除 <code>kube-audit</code> 日誌來源的日誌轉遞配置。</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cs_cli_reference#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfig)</code></td>
</tr>
</tbody>
</table>

<br />


## {{site.data.keyword.Bluemix_notm}} IAM 服務角色
{: #service}

獲指派 {{site.data.keyword.Bluemix_notm}} IAM 服務存取角色的每一位使用者，也會在特定名稱空間中自動獲指派一個對應的 Kubernetes 角色型存取控制 (RBAC) 角色。如果要進一步瞭解服務存取角色，請參閱 [{{site.data.keyword.Bluemix_notm}} IAM 服務角色](/docs/containers?topic=containers-users#platform)。若要進一步瞭解 RBAC 角色，請參閱[指派 RBAC 許可權](/docs/containers?topic=containers-users#role-binding)。
{: shortdesc}

想要知道每個服務角色透過 RBAC 授與哪些 Kubernetes 動作？請參閱[每個 RBAC 角色的 Kubernetes 資源許可權](#rbac)。
{: tip}

下表顯示每個服務角色及其對應的 RBAC 角色所授與的 Kubernetes 資源許可權。

<table>
<caption>依服務及對應 RBAC 角色的 Kubernetes 資源許可權</caption>
<thead>
    <th id="service-role">服務角色</th>
    <th id="rbac-role">對應的 RBAC 角色、連結及範圍</th>
    <th id="kube-perm">Kubernetes 資源許可權</th>
</thead>
<tbody>
  <tr>
    <td id="service-role-reader" headers="service-role">讀者角色</td>
    <td headers="service-role-reader rbac-role">範圍限定為一個名稱空間時：由該名稱空間中的 <strong><code>ibm-view</code></strong> 角色連結所套用的 <strong><code>view</code></strong> 叢集角色</br><br>範圍限定為所有名稱空間時：由叢集的每一個名稱空間中的 <strong><code>ibm-view</code></strong> 角色連結所套用的 <strong><code>view</code></strong> 叢集角色</td>
    <td headers="service-role-reader kube-perm"><ul>
      <li>對名稱空間中的資源的讀取權</li>
      <li>對角色和角色連結或對 Kubernetes 密碼沒有讀取權</li>
      <li>存取 Kubernetes 儀表板以檢視名稱空間中的資源</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-writer" headers="service-role">撰寫者角色</td>
    <td headers="service-role-writer rbac-role">範圍限定為一個名稱空間時：由該名稱空間中的 <strong><code>ibm-edit</code></strong> 角色連結所套用的 <strong><code>edit</code></strong> 叢集角色</br><br>範圍限定為所有名稱空間時：由叢集的每一個名稱空間中的 <strong><code>ibm-edit</code></strong> 角色連結所套用的 <strong><code>edit</code></strong> 叢集角色</td>
    <td headers="service-role-writer kube-perm"><ul><li>對名稱空間中的資源的讀寫權</li>
    <li>對角色和角色連結沒有讀寫權</li>
    <li>存取 Kubernetes 儀表板以檢視名稱空間中的資源</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-manager" headers="service-role">管理者角色</td>
    <td headers="service-role-manager rbac-role">範圍限定為一個名稱空間時：由該名稱空間中的 <strong><code>ibm-operate</code></strong> 角色連結所套用的 <strong><code>admin</code></strong> 叢集角色</br><br>範圍限定為所有名稱空間時：由套用至所有名稱空間的 <strong><code>ibm-admin</code></strong> 叢集角色連結所套用的 <strong><code>cluster-admin</code></strong> 叢集角色</td>
    <td headers="service-role-manager kube-perm">範圍限定為一個名稱空間時：
      <ul><li>對名稱空間中的所有資源有讀寫權，但對資源配額或名稱空間本身沒有讀寫權</li>
      <li>在名稱空間中建立 RBAC 角色及角色連結</li>
      <li>存取 Kubernetes 儀表板以檢視名稱空間中的所有資源</li></ul>
    </br>範圍限定為所有名稱空間時：
        <ul><li>對每個名稱空間中所有資源的讀寫權</li>
        <li>在一個名稱空間中建立 RBAC 角色及角色連結，或在所有名稱空間中建立叢集角色及叢集角色連結</li>
        <li>存取 Kubernetes 儀表板</li>
        <li>建立 Ingress 資源，讓應用程式公開可用</li>
        <li>檢閱叢集度量，例如使用 <code>kubectl top pods</code>、<code>kubectl top nodes</code> 或 <code>kubectl get nodes</code> 指令</li></ul>
    </td>
  </tr>
</tbody>
</table>

<br />


## 每個 RBAC 角色的 Kubernetes 資源許可權
{: #rbac}

獲指派 {{site.data.keyword.Bluemix_notm}} IAM 服務存取角色的每一位使用者，也會自動獲指派一個對應的 Kubernetes 角色型存取控制 (RBAC) 角色。如果您計劃管理自己的自訂 Kubernetes RBAC 角色，請參閱[針對使用者、群組或服務帳戶建立自訂 RBAC 許可權](/docs/containers?topic=containers-users#rbac)。
{: shortdesc}

想知道您是否有正確的許可權可對名稱空間中的資源執行特定 `kubectl` 指令？可嘗試 [`kubectl auth can-i` 指令 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em-)。
{: tip}

下表顯示每個 RBAC 角色授與個別 Kubernetes 資源的許可權。許可權顯示為具有該角色的使用者可以針對資源完成的動詞，例如 "get"、"list"、"describe"、"create" 或 "delete"。

<table>
 <caption>每一個預先定義的 RBAC 角色授與的 Kubernetes 資源許可權</caption>
 <thead>
  <th>Kubernetes 資源</th>
  <th><code>view</code></th>
  <th><code>edit</code></th>
  <th><code>admin</code> 及 <code>cluster-admin</code></th>
 </thead>
<tbody>
<tr>
  <td>bindings</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>configmaps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>cronjobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.apps </td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>endpoints</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>events</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>horizontalpodautoscalers.autoscaling</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>ingresses.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>jobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>limitranges</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>localsubjectaccessreviews</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code></td>
</tr><tr>
  <td>namespaces</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></br>**cluster-admin only:** <code>create</code>, <code>delete</code></td>
</tr><tr>
  <td>namespaces/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>persistentvolumeclaims</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>poddisruptionbudgets.policy</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>top</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/attach</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/exec</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/log</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/portforward</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>rolebindings</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>roles</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>secrets</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>serviceaccounts</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
</tr><tr>
  <td>服務</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>services/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr>
</tbody>
</table>

<br />


## Cloud Foundry 角色
{: #cloud-foundry}

Cloud Foundry 角色會授與對帳戶內組織及空間的存取權。若要查看 {{site.data.keyword.Bluemix_notm}} 中的 Cloud Foundry 型服務清單，請執行 `ibmcloud service list`。若要進一步瞭解，請參閱 {{site.data.keyword.Bluemix_notm}} IAM 文件中的所有可用[組織和空間角色](/docs/iam?topic=iam-cfaccess)或[管理 Cloud Foundry 存取](/docs/iam?topic=iam-mngcf)的步驟。
{: shortdesc}

下表顯示叢集動作許可權所需的 Cloud Foundry 角色。

<table>
  <caption>依 Cloud Foundry 角色的叢集管理許可權</caption>
  <thead>
    <th>Cloud Foundry 角色</th>
    <th>叢集管理許可權</th>
  </thead>
  <tbody>
  <tr>
    <td>空間角色：管理員</td>
    <td>管理使用者存取 {{site.data.keyword.Bluemix_notm}} 空間</td>
  </tr>
  <tr>
    <td>空間角色：開發人員</td>
    <td>
      <ul><li>建立 {{site.data.keyword.Bluemix_notm}} 服務實例</li>
      <li>將 {{site.data.keyword.Bluemix_notm}} 服務實例連結至叢集</li>
      <li>檢視來自空間層次之叢集日誌轉遞配置的日誌</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## 基礎架構角色
{: #infra}

當具有**超級使用者**基礎架構存取角色的使用者[設定地區和資源群組的 API 金鑰](/docs/containers?topic=containers-users#api_key)時，帳戶中其他使用者的基礎架構許可權是由 {{site.data.keyword.Bluemix_notm}} IAM 平台角色設定。您不需要編輯其他使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。只有在您無法將**超級使用者**指派給設定 API 金鑰的使用者時，才會使用下表來自訂使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。如需相關資訊，請參閱[ 自訂基礎架構許可權](/docs/containers?topic=containers-users#infra_access)。
{: shortdesc}

下表顯示完成一般作業群組所需的基礎架構許可權。

<table>
 <caption>{{site.data.keyword.containerlong_notm}} 一般需要的基礎架構許可權</caption>
 <thead>
  <th>{{site.data.keyword.containerlong_notm}} 的一般作業</th>
  <th>依種類列出的必要基礎架構許可權</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>最少許可權</strong>：<ul><li>建立叢集。</li></ul></td>
     <td><strong>裝置</strong>：<ul><li>檢視虛擬伺服器詳細資料</li><li>重新啟動伺服器並檢視 IPMI 系統資訊</li><li>發出 OS 重新載入及起始救援核心</li></ul><strong>帳戶</strong>：<ul><li>新增伺服器</li></ul></td>
   </tr>
   <tr>
     <td><strong>叢集管理</strong>：<ul><li>建立、更新及刪除叢集。</li><li>新增、重新載入及重新啟動工作者節點。</li><li>檢視 VLAN。</li><li>建立子網路。</li><li>部署 Pod 及負載平衡器服務。</li></ul></td>
     <td><strong>支援</strong>：<ul><li>檢視問題單</li><li>新增問題單</li><li>編輯問題單</li></ul>
     <strong>裝置</strong>：<ul><li>檢視硬體詳細資料</li><li>檢視虛擬伺服器詳細資料</li><li>重新啟動伺服器並檢視 IPMI 系統資訊</li><li>發出 OS 重新載入及起始救援核心</li></ul>
     <strong>網路</strong>：<ul><li>新增運算與公用網路埠</li></ul>
     <strong>帳戶</strong>：<ul><li>取消伺服器</li><li>新增伺服器</li></ul></td>
   </tr>
   <tr>
     <td><strong>儲存空間</strong>：<ul><li>建立持續性磁區要求，以佈建持續性磁區。</li><li>建立及管理儲存空間基礎架構資源。</li></ul></td>
     <td><strong>服務</strong>：<ul><li>管理儲存空間</li></ul><strong>帳戶</strong>：<ul><li>新增儲存空間</li></ul></td>
   </tr>
   <tr>
     <td><strong>專用網路</strong>：<ul><li>管理專用 VLAN 來建立叢集內網路連線。</li><li>設定專用網路的 VPN 連線功能。</li></ul></td>
     <td><strong>網路</strong>：<ul><li>管理網路子網路路徑</li></ul></td>
   </tr>
   <tr>
     <td><strong>公用網路</strong>：<ul><li>設定公用負載平衡器或 Ingress 網路來公開應用程式。</li></ul></td>
     <td><strong>裝置</strong>：<ul><li>編輯主機名稱/網域</li><li>管理埠控制</li></ul>
     <strong>網路</strong>：<ul><li>新增運算與公用網路埠</li><li>管理網路子網路路徑</li><li>新增 IP 位址</li></ul>
     <strong>服務</strong>：<ul><li>管理 DNS、反向 DNS 及 WHOIS</li><li>檢視憑證 (SSL)</li><li>管理憑證 (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
