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



# 指令參考手冊
{: #cs_cli_reference}

請參閱這些指令，以在 {{site.data.keyword.containerlong}} 中建立及管理 Kubernetes 叢集。
{:shortdesc}

若要安裝 CLI 外掛程式，請參閱[安裝 CLI](cs_cli_install.html#cs_cli_install_steps)。

在終端機中，當您更新至 `ibmcloud`CLI 和外掛程式時，會通知您。務必將 CLI 保持為最新狀態，以使用所有可用的指令及旗標。

要尋找 `ibmcloud cr` 指令嗎？請參閱 [{{site.data.keyword.registryshort_notm}} CLI 參考資料](/docs/cli/plugins/registry/index.html)。要尋找 `kubectl` 指令嗎？請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/)。
{:tip}

## ibmcloud ks 指令
{: #cs_commands}

**提示：**若要查看 {{site.data.keyword.containerlong_notm}} 外掛程式的版本，請執行下列指令。

```
ibmcloud plugin list
```
{: pre}



<table summary="API 指令表格">
<caption>API 指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>API 指令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks api](#cs_api)</td>
    <td>[ibmcloud ks api-key-info](#cs_api_key_info)</td>
    <td>[ibmcloud ks api-key-reset](#cs_api_key_reset)</td>
    <td>[ibmcloud ks apiserver-config-get](#cs_apiserver_config_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks apiserver-config-set](#cs_apiserver_config_set)</td>
    <td>[ibmcloud ks apiserver-config-unset](#cs_apiserver_config_unset)</td>
    <td>[ibmcloud ks apiserver-refresh](#cs_apiserver_refresh)</td>
    <td></td>
 </tr>
</tbody>
</table>

<br>

<table summary="CLI 外掛程式用法指令表格">
<caption>CLI 外掛程式用法指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>CLI 外掛程式用法指令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks help](#cs_help)</td>
    <td>[ibmcloud ks init](#cs_init)</td>
    <td>[ibmcloud ks messages](#cs_messages)</td>
    <td></td>
  </tr>
</tbody>
</table>

<br>

<table summary="叢集指令：管理表格">
<caption>叢集指令：管理指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>叢集指令：管理</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-config](#cs_cluster_config)</td>
    <td>[ibmcloud ks cluster-create](#cs_cluster_create)</td>
    <td>[ibmcloud ks cluster-feature-enable](#cs_cluster_feature_enable)</td>
    <td>[ibmcloud ks cluster-get](#cs_cluster_get)</td>
  </tr>
  <tr>
  <td>[ibmcloud ks cluster-rm](#cs_cluster_rm)</td>
    <td>[ibmcloud ks cluster-update](#cs_cluster_update)</td>
    <td>[ibmcloud ks clusters](#cs_clusters)</td>
    <td>[ibmcloud ks kube-versions](#cs_kube_versions)</td>
  </tr>
</tbody>
</table>

<br>

<table summary="叢集指令：服務與整合表格">
<caption>叢集指令：服務與整合指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>叢集指令：服務與整合</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[ibmcloud ks cluster-service-unbind](#cs_cluster_service_unbind)</td>
    <td>[ibmcloud ks cluster-services](#cs_cluster_services)</td>
    <td>[ibmcloud ks va](#cs_va)</td>
  </tr>
    <td>[ibmcloud ks webhook-create](#cs_webhook_create)</td>
  <tr>
  </tr>
</tbody>
</table>

</br>

<table summary="叢集指令：子網路表格">
<caption>叢集指令：子網路指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>叢集指令：子網路</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[ibmcloud ks cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[ibmcloud ks cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[ibmcloud ks cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks subnets](#cs_subnets)</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>

</br>



<table summary="基礎架構指令表格">
<caption>叢集指令：基礎架構指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>基礎架構指令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks credentials-set](#cs_credentials_set)</td>
    <td>[ibmcloud ks credentials-unset](#cs_credentials_unset)</td>
    <td>[ibmcloud ks machine-types](#cs_machine_types)</td>
    <td>[ibmcloud ks vlans](#cs_vlans)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks vlan-spanning-get](#cs_vlan_spanning_get)</td>
    <td> </td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

</br>

<table summary="Ingress 應用程式負載平衡器 (ALB) 指令表格">
<caption>Ingress 應用程式負載平衡器 (ALB) 指令</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Ingress 應用程式負載平衡器 (ALB) 指令</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks alb-cert-deploy](#cs_alb_cert_deploy)</td>
      <td>[ibmcloud ks alb-cert-get](#cs_alb_cert_get)</td>
      <td>[ibmcloud ks alb-cert-rm](#cs_alb_cert_rm)</td>
      <td>[ibmcloud ks alb-certs](#cs_alb_certs)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-configure](#cs_alb_configure)</td>
      <td>[ibmcloud ks alb-get](#cs_alb_get)</td>
      <td>[ibmcloud ks alb-types](#cs_alb_types)</td>
      <td>[ibmcloud ks albs](#cs_albs)</td>
    </tr>
  </tbody>
</table>

</br>

<table summary="記載指令表格">
<caption>記載指令</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>記載指令</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks logging-config-create](#cs_logging_create)</td>
      <td>[ibmcloud ks logging-config-get](#cs_logging_get)</td>
      <td>[ibmcloud ks logging-config-refresh](#cs_logging_refresh)</td>
      <td>[ibmcloud ks logging-config-rm](#cs_logging_rm)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-config-update](#cs_logging_update)</td>
      <td>[ibmcloud ks logging-filter-create](#cs_log_filter_create)</td>
      <td>[ibmcloud ks logging-filter-update](#cs_log_filter_update)</td>
      <td>[ibmcloud ks logging-filter-get](#cs_log_filter_view)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-filter-rm](#cs_log_filter_delete)</td>
      <td>[ibmcloud ks logging-autoupdate-enable](#cs_log_autoupdate_enable)</td>
      <td>[ibmcloud ks logging-autoupdate-disable](#cs_log_autoupdate_disable)</td>
      <td>[ibmcloud ks logging-autoupdate-get](#cs_log_autoupdate_get)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-collect](#cs_log_collect)</td>
      <td>[ibmcloud ks logging-collect-status](#cs_log_collect_status)</td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

</br>

<table summary="地區指令表格">
<caption>地區指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>地區指令</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks zones](#cs_datacenters)</td>
    <td>[ibmcloud ks region](#cs_region)</td>
    <td>[ibmcloud ks region-set](#cs_region-set)</td>
    <td>[ibmcloud ks regions](#cs_regions)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="工作者節點指令表格">
<caption>工作者節點指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>工作者節點指令</th>
 </thead>
 <tbody>
    <tr>
      <td>已淘汰：[ibmcloud ks worker-add](#cs_worker_add)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks worker-update](#cs_worker_update)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
    </tr>
  </tbody>
</table>

<table summary="工作者節點儲存區指令表格">
<caption>工作者節點儲存區指令</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>工作者節點儲存區指令</th>
 </thead>
 <tbody>
    <tr>
      <td>[ibmcloud ks worker-pool-create](#cs_worker_pool_create)</td>
      <td>[ibmcloud ks worker-pool-get](#cs_worker_pool_get)</td>
      <td>[ibmcloud ks worker-pool-rebalance](#cs_rebalance)</td>
      <td>[ibmcloud ks worker-pool-resize](#cs_worker_pool_resize)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-pool-rm](#cs_worker_pool_rm)</td>
      <td>[ibmcloud ks worker-pools](#cs_worker_pools)</td>
      <td>[ibmcloud ks zone-add](#cs_zone_add)</td>
      <td>[ibmcloud ks zone-network-set](#cs_zone_network_set)</td>
    </tr>
    <tr>
     <td>[ibmcloud ks zone-rm](#cs_zone_rm)</td>
     <td></td>
    </tr>
  </tbody>
</table>

## API 指令
{: #api_commands}

### ibmcloud ks api --endpoint ENDPOINT [--insecure][--skip-ssl-validation] [--api-version VALUE][-s]
{: #cs_api}

將目標設為 {{site.data.keyword.containerlong_notm}} 的 API 端點。如果您未指定端點，則可以檢視已設定目標之現行端點的相關資訊。

要切換地區嗎？請改用 `ibmcloud ks region-set` [指令](#cs_region-set)。
{: tip}

<strong>最低必要許可權</strong>：無

<strong>指令選項</strong>：

   <dl>
   <dt><code>--endpoint <em>ENDPOINT</em></code></dt>
   <dd>{{site.data.keyword.containerlong_notm}} API 端點。請注意，此端點與 {{site.data.keyword.Bluemix_notm}} 端點不同。設定 API 端點需要此值。接受值如下：<ul>
   <li>全球端點：https://containers.bluemix.net</li>
   <li>亞太地區北部端點：https://ap-north.containers.bluemix.net</li>
   <li>亞太地區南部端點：https://ap-south.containers.bluemix.net</li>
   <li>歐盟中部端點：https://eu-central.containers.bluemix.net</li>
   <li>英國南部端點：https://uk-south.containers.bluemix.net</li>
   <li>美國東部端點：https://us-east.containers.bluemix.net</li>
   <li>美國南部端點：https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>容許不安全的 HTTP 連線。這是選用旗標。</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>容許不安全的 SSL 憑證。這是選用旗標。</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>指定您要使用之服務的 API 版本。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：檢視已設定目標之現行 API 端點的相關資訊。
```
ibmcloud ks api
```
{: pre}

```
API Endpoint:          https://containers.bluemix.net   
API Version:           v1   
Skip SSL Validation:   false   
Region:                us-south
```
{: screen}


### ibmcloud ks api-key-info --cluster CLUSTER [--json][-s]
{: #cs_api_key_info}

檢視 {{site.data.keyword.containerlong_notm}} 資源群組及地區中 IAM API 金鑰的擁有者的名稱及電子郵件位址。

執行第一個需要 {{site.data.keyword.containerlong_notm}} 管理存取原則的動作時，會針對資源群組及地區自動設定 Identity and Access Management (IAM) API 金鑰。例如，其中一位管理使用者會在 `us-south` 地區的 `default` 資源群組中建立第一個叢集。如此一來，會在帳戶中針對這個資源群組及地區儲存這位使用者的 IAM API 金鑰。此 API 金鑰是用來訂購 IBM Cloud 基礎架構 (SoftLayer) 中的資源，例如新的工作者節點或 VLAN。您可以針對資源群組內的每一個地區設定不同的 API 金鑰。

當另一位使用者在此資源群組及地區中執行需要與 IBM Cloud 基礎架構 (SoftLayer) 組合互動的動作（例如建立新叢集或重新載入工作者節點）時，會使用儲存的 API 金鑰來判斷是否有足夠的許可權可執行該動作。為了確保可以順利在叢集裡執行基礎架構相關動作，請對 {{site.data.keyword.containerlong_notm}} 管理使用者指派**超級使用者**基礎架構存取原則。如需相關資訊，請參閱[管理使用者存取](cs_users.html#infra_access)。

如果您發現需要更新針對資源群組及地區而儲存的 API 金鑰，則可以執行 [ibmcloud ks api-key-reset](#cs_api_key_reset) 指令來達成此目的。這個指令需要 {{site.data.keyword.containerlong_notm}} 管理存取原則，它會將執行這個指令的使用者的 API 金鑰儲存在帳戶中。

**提示：**如果使用 [ibmcloud ks credentials-set](#cs_credentials_set) 指令手動設定 IBM Cloud 基礎架構 (SoftLayer) 認證，則可能無法使用這個指令所傳回的 API 金鑰。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks api-key-info --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks api-key-reset [-s]
{: #cs_api_key_reset}

取代 {{site.data.keyword.containerlong_notm}} 地區中的現行 IAM API 金鑰。

這個指令需要 {{site.data.keyword.containerlong_notm}} 管理存取原則，它會將執行這個指令的使用者的 API 金鑰儲存在帳戶中。需要有 IAM API 金鑰，才能訂購 IBM Cloud 基礎架構 (SoftLayer) 組合中的基礎架構。儲存之後，API 金鑰即會用於地區中的每個動作，這些動作需要基礎架構許可權（與執行這個指令的使用者無關）。如需 IAM API 金鑰運作方式的相關資訊，請參閱 [`ibmcloud ks api-key-info` 指令](#cs_api_key_info)。

**重要事項**：在使用這個指令之前，請確定執行這個指令的使用者具有必要的 [{{site.data.keyword.containerlong_notm}} 及 IBM Cloud 基礎架構 (SoftLayer) 許可權](cs_users.html#users)。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>


**範例**：

  ```
  ibmcloud ks api-key-reset
  ```
  {: pre}


### ibmcloud ks apiserver-config-get
{: #cs_apiserver_config_get}

取得叢集 Kubernetes API 伺服器配置之選項的相關資訊。這個指令必須與您要取得其相關資訊之配置選項的下列其中一個次指令一起使用。

#### ibmcloud ks apiserver-config-get audit-webhook --cluster CLUSTER
{: #cs_apiserver_config_get}

檢視您要將 API 伺服器審核日誌傳送至其中的遠端記載服務的 URL。URL 是在建立 API 伺服器配置的 Webhook 後端時指定。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks apiserver-config-get audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-config-set
{: #cs_apiserver_config_set}

設定叢集 Kubernetes API 伺服器配置的選項。這個指令必須與您要設定之配置選項的下列其中一個次指令一起使用。

#### ibmcloud ks apiserver-config-set audit-webhook --cluster CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_set}

設定 API 伺服器配置的 Webhook 後端。Webhook 後端會將 API 伺服器審核日誌轉遞至遠端伺服器。將根據您在這個指令旗標中提供的資訊，來建立 Webhook 配置。如果您未在旗標中提供任何資訊，則會使用預設 Webhook 配置。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>您要將審核日誌傳送至其中的遠端記載服務的 URL 或 IP 位址。如果您提供不安全的伺服器 URL，則會忽略任何憑證。這是選用值。</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>用來驗證遠端記載服務之 CA 憑證的檔案路徑。這是選用值。</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>用來對遠端記載服務進行鑑別之用戶端憑證的檔案路徑。這是選用值。</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>用來連接至遠端記載服務之對應用戶端金鑰的檔案路徑。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks apiserver-config-set audit-webhook --cluster my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud ks apiserver-config-unset
{: #cs_apiserver_config_unset}

停用叢集 Kubernetes API 伺服器配置的選項。這個指令必須與您要取消設定之配置選項的下列其中一個次指令一起使用。

#### ibmcloud ks apiserver-config-unset audit-webhook --cluster CLUSTER
{: #cs_apiserver_unset}

停用叢集 API 伺服器的 Webhook 後端配置。停用 Webhook 後端會停止將 API 伺服器審核日誌轉遞至遠端伺服器。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks apiserver-config-unset audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-refresh --cluster CLUSTER [-s]
{: #cs_apiserver_refresh}

重新啟動主要叢集，以套用新的 Kubernet API 配置變更。您的工作者節點、應用程式及資源不會進行修改，而且會繼續執行。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks apiserver-refresh --cluster my_cluster
  ```
  {: pre}


<br />


## CLI 外掛程式用法指令
{: #cli_plug-in_commands}

### ibmcloud ks help
{: #cs_help}

檢視所支援指令及參數的清單。

<strong>最低必要許可權</strong>：無

<strong>指令選項</strong>：

   無

**範例**：

  ```
  ibmcloud ks help
  ```
  {: pre}


### ibmcloud ks init [--host HOST][--insecure] [-p][-u] [-s]
{: #cs_init}

起始設定 {{site.data.keyword.containerlong_notm}} 外掛程式，或指定您要建立或存取 Kubernetes 叢集的地區。

<strong>最低必要許可權</strong>：無

<strong>指令選項</strong>：

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>要使用的 {{site.data.keyword.containerlong_notm}} API 端點。這是選用值。[檢視可用的 API 端點值。](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>容許不安全的 HTTP 連線。</dd>

   <dt><code>-p</code></dt>
   <dd>您的 IBM Cloud 密碼。</dd>

   <dt><code>-u</code></dt>
   <dd>您的 IBM Cloud 使用者名稱。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：


```
ibmcloud ks init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud ks messages
{: #cs_messages}

檢視 IBMid 使用者的現行訊息。

<strong>最低必要許可權</strong>：無

**範例**：

```
ibmcloud ks messages
```
{: pre}


<br />


## 叢集指令：管理
{: #cluster_mgmt_commands}



### ibmcloud ks cluster-config --cluster CLUSTER [--admin][--export] [--network][-s] [--yaml]
{: #cs_cluster_config}

登入之後，請下載 Kubernetes 配置資料及憑證來連接至叢集，以及執行 `kubectl` 指令。檔案會下載至 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`。

**最低必要許可權**：無

**指令選項**：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--admin</code></dt>
   <dd>下載「超級使用者」角色的 TLS 憑證及許可權檔案。您可以使用憑證，在叢集裡自動執行作業，而無需重新鑑別。檔案會下載至 `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`。這是選用值。</dd>

   <dt><code>--network</code></dt>
   <dd>下載在叢集中執行 <code>calicoctl</code> 指令所需的 Calico 配置檔、TLS 憑證及許可權檔案。這是選用值。**附註**：若要取得已下載 Kubernetes 配置資料及憑證的 export 指令，您必須在沒有此旗標的情況下執行以下指令。</dd>

   <dt><code>--export</code></dt>
   <dd>下載 Kubernets 配置資料及憑證，但不包含 export 指令以外的任何訊息。因為沒有顯示任何訊息，所以可以在建立自動化 Script 時使用此旗標。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

  <dt><code>--yaml</code></dt>
  <dd>以 YAML 格式列印指令輸出。這是選用值。</dd>

   </dl>

**範例**：

```
ibmcloud ks cluster-config --cluster my_cluster
```
{: pre}


### ibmcloud ks cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --zone ZONE --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--private-only][--workers WORKER] [--disable-disk-encrypt][--trusted] [-s]
{: #cs_cluster_create}

在您的組織中建立叢集。對於免費叢集，您只要指定叢集名稱；其他所有項目都設為預設值。在 30 天之後，會自動刪除免費的叢集。您一次可以有一個免費叢集。若要充分運用 Kubernetes 的完整功能，請建立標準叢集。

<strong>最低必要許可權</strong>：
* {{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色
* {{site.data.keyword.registrylong_notm}} 的**管理者** IAM 平台角色
* IBM Cloud 基礎架構 (SoftLayer) 的**超級使用者**基礎架構角色。

<strong>指令選項</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>建立標準叢集之 YAML 檔案的路徑。您可以使用 YAML 檔案，而不是使用這個指令中所提供的選項來定義叢集的特徵。此值對於標準叢集是選用的，不適用於免費叢集。

<p><strong>附註：</strong>如果您在指令中提供與 YAML 檔案中的參數相同的選項，則指令中的值優先順序會高於 YAML 中的值。例如，您在 YAML 檔案中已定義位置，並在指令中使用 <code>--zone</code> 選項，則您在指令選項中輸入的值會置換 YAML 檔案中的值。

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
zone: <em>&lt;zone&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
diskEncryption: <em>false</em>
trusted: <em>true</em>
</code></pre>


<table>
    <caption>瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>將 <code><em>&lt;cluster_name&gt;</em></code> 取代為叢集的名稱。此名稱必須以字母開頭，可以包含字母、數字及連字號 (-)，且長度不得超過 35 個字元。叢集名稱和叢集部署所在的地區會形成 Ingress 子網域的完整網域名稱。為了確保 Ingress 子網域在地區內是唯一的，叢集名稱可能會被截斷，並在 Ingress 網域名稱內附加一個隨機值。</td>
    </tr>
    <tr>
    <td><code><em>zone</em></code></td>
    <td>將 <code><em>&lt;zone&gt;</em></code> 取代為您要建立叢集的區域。可用的區域取決於您所登入的地區。若要列出可用的區域，請執行 <code>ibmcloud ks zones</code>。</td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>依預設，公用及專用可攜式子網路都是建立在與叢集相關聯的 VLAN 上。將 <code><em>&lt;no-subnet&gt;</em></code> 取代為 <code><em>true</em></code>，以避免建立具有叢集的子網路。稍後，您可以[建立](#cs_cluster_subnet_create)或[新增](#cs_cluster_subnet_add)子網路至叢集。</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>將 <code><em>&lt;machine_type&gt;</em></code> 取代為您要將工作者節點部署至其中的機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-type` [指令](cs_cli_reference.html#cs_machine_types)的文件。</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>將 <code><em>&lt;private_VLAN&gt;</em></code> 取代為您要用於工作者節點的專用 VLAN ID。若要列出可用的 VLAN，請執行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>，並尋找開頭為 <code>bcr</code>（後端路由器）的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>將 <code><em>&lt;public_VLAN&gt;</em></code> 取代為您要用於工作者節點的公用 VLAN ID。若要列出可用的 VLAN，請執行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>，並尋找開頭為 <code>fcr</code>（前端路由器）的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>若為虛擬機器類型：您的工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 <code>shared</code>。</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>將 <code><em>&lt;number_workers&gt;</em></code> 取代為您要部署的工作者節點數目。</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>叢集主節點的 Kubernetes 版本。這是選用值。未指定版本時，會使用支援的 Kubernetes 版本的預設值來建立叢集。若要查看可用的版本，請執行 <code>ibmcloud ks kube-versions</code>。
</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>依預設，工作者節點會具備磁碟加密；[進一步瞭解](cs_secure.html#encrypted_disk)。若要停用加密，請包含此選項，並將值設為 <code>false</code>。</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**僅限裸機**：啟用[授信運算](cs_secure.html#trusted_compute)，以驗證裸機工作者節點是否遭到竄改。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](cs_cli_reference.html#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作者節點的硬體隔離層次。若要讓可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。此值對於標準叢集是選用的，不適用於免費叢集。</dd>

<dt><code>--zone <em>ZONE</em></code></dt>
<dd>您要建立叢集的區域。可用的區域取決於您所登入的 {{site.data.keyword.Bluemix_notm}} 地區。選取實際上與您最接近的地區以獲得最佳效能。此值對於標準叢集是必要的，對於免費叢集則是選用性。

<p>檢閱[可用區域](cs_regions.html#zones)。</p>

<p><strong>附註：</strong>若您選取的區域不在您的國家/地區境內，請謹記，您可能需要合法授權，才能實際將資料儲存在其他國家/地區。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>選擇機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-types` [指令](cs_cli_reference.html#cs_machine_types)的文件。此值對於標準叢集是必要的，不適用於免費叢集。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>叢集的名稱。這是必要值。此名稱必須以字母開頭，可以包含字母、數字及連字號 (-)，且長度不得超過 35 個字元。叢集名稱和叢集部署所在的地區會形成 Ingress 子網域的完整網域名稱。為了確保 Ingress 子網域在地區內是唯一的，叢集名稱可能會被截斷，並在 Ingress 網域名稱內附加一個隨機值。</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>叢集主節點的 Kubernetes 版本。這是選用值。未指定版本時，會使用支援的 Kubernetes 版本的預設值來建立叢集。若要查看可用的版本，請執行 <code>ibmcloud ks kube-versions</code>。
</dd>

<dt><code>--no-subnet</code></dt>
<dd>依預設，公用及專用可攜式子網路都是建立在與叢集相關聯的 VLAN 上。請包括 <code>--no-subnet</code> 旗標，以避免建立具有叢集的子網路。稍後，您可以[建立](#cs_cluster_subnet_create)或[新增](#cs_cluster_subnet_add)子網路至叢集。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>此參數不適用於免費叢集。</li>
<li>如果此標準叢集是您在這個區域所建立的第一個標準叢集，請不要包括此旗標。建立叢集時，會自動建立一個專用 VLAN。</li>
<li>如果您之前已在此區域中建立標準叢集，或之前已在 IBM Cloud 基礎架構 (SoftLayer) 中建立專用 VLAN，則必須指定該專用 VLAN。

<p><strong>附註：</strong>專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</p></li>
</ul>

<p>若要找出您是否已有特定區域的專用 VLAN，或尋找現有專用 VLAN 的名稱，請執行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>此參數不適用於免費叢集。</li>
<li>如果此標準叢集是您在這個區域所建立的第一個標準叢集，請不要使用此旗標。建立叢集時，會自動建立一個公用 VLAN。</li>
<li>如果您之前已在此區域中建立標準叢集，或之前已在 IBM Cloud 基礎架構 (SoftLayer) 中建立公用 VLAN，請指定該公用 VLAN。如果您只要將工作者節點連接至專用 VLAN，請不要指定此選項。

<p><strong>附註：</strong>專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</p></li>
</ul>

<p>若要找出您是否已有特定區域的公用 VLAN，或尋找現有公用 VLAN 的名稱，請執行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>。</p></dd>

<dt><code>--private-only </code></dt>
  <dd>使用此選項，以防止建立公用 VLAN。只有在您指定 `--private-vlan` 旗標時才為必要項目，並且請不要包括 `--public-vlan` 旗標。**附註**：如果您想要僅限專用叢集，則必須配置閘道應用裝置來連接網路。如需相關資訊，請參閱[專用叢集](cs_clusters_planning.html#private_clusters)。</dd>

<dt><code>--workers WORKER</code></dt>
<dd>您要在叢集裡部署的工作者節點數目。如果您未指定此選項，則會建立具有 1 個工作者節點的叢集。此值對於標準叢集是選用的，不適用於免費叢集。

<p><strong>附註：</strong>每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，在叢集建立之後即不得手動予以變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>依預設，工作者節點會具備磁碟加密；[進一步瞭解](cs_secure.html#encrypted_disk)。若要停用加密，請包含此選項。</dd>

<dt><code>--trusted</code></dt>
<dd><p>**僅限裸機**：啟用[授信運算](cs_secure.html#trusted_compute)，以驗證裸機工作者節點是否遭到竄改。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](cs_cli_reference.html#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。</p>
<p>若要檢查裸機機型是否支援信任，請檢查 `ibmcloud ks machine-types <zone>` [指令](#cs_machine_types)輸出中的 `Trustable` 欄位。若要驗證叢集已啟用信任，請檢視 `ibmcloud ks cluster-get` [指令](#cs_cluster_get)輸出中的 **Trust ready** 欄位。若要驗證裸機工作者節點已啟用信任，請檢視 `ibmcloud ks worker-get` [指令](#cs_worker_get)輸出中的 **Trust** 欄位。</p></dd>

<dt><code>-s</code></dt>
<dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  

  **建立免費叢集**：只指定叢集名稱；其他所有項目都設為預設值。在 30 天之後，會自動刪除免費的叢集。您一次可以有一個免費叢集。若要充分運用 Kubernetes 的完整功能，請建立標準叢集。

  ```
  ibmcloud ks cluster-create --name my_cluster
  ```
  {: pre}

  **建立您的第一個標準叢集**：在區域中建立的第一個標準叢集也會建立專用 VLAN。因此，請不要包括 `--public-vlan` 旗標。
  {: #example_cluster_create}

  ```
  ibmcloud ks cluster-create --zone dal10 --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **建立後續標準叢集**：如果您已在此區域中建立標準叢集，或之前已在 IBM Cloud 基礎架構 (SoftLayer) 中建立公用 VLAN，請使用 `--public-vlan` 旗標來指定該公用 VLAN。若要找出您是否已有特定區域的公用 VLAN，或尋找現有公用 VLAN 的名稱，請執行 `ibmcloud ks vlans <zone>`。

  ```
  ibmcloud ks cluster-create --zone dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **在 {{site.data.keyword.Bluemix_dedicated_notm}} 環境中建立叢集**：

  ```
  ibmcloud ks cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}

### ibmcloud ks cluster-feature-enable [-f] --cluster CLUSTER [--trusted][-s]
{: #cs_cluster_feature_enable}

在現有叢集上啟用特性。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制執行 <code>--trusted</code> 選項，而不出現使用者提示。這是選用值。</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>包括此旗標，以對叢集裡所有受支援的裸機工作者節點啟用[授信運算](cs_secure.html#trusted_compute)。啟用信任之後，以後您就無法針對叢集予以停用。</p>
   <p>若要檢查裸機機型是否支援信任，請檢查 **ibmcloud ks machine-types <zone>` [指令](#cs_machine_types)輸出中的 `Trustable** 欄位。若要驗證叢集已啟用信任，請檢視 `ibmcloud ks cluster-get` [指令](#cs_cluster_get)輸出中的 **Trust ready** 欄位。若要驗證裸機工作者節點已啟用信任，請檢視 `ibmcloud ks worker-get` [指令](#cs_worker_get)輸出中的 **Trust** 欄位。</p></dd>

  <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**指令範例**：

  ```
  ibmcloud ks cluster-feature-enable --cluster my_cluster --trusted=true
  ```
  {: pre}

### ibmcloud ks cluster-get --cluster CLUSTER [--json][--showResources] [-s]
{: #cs_cluster_get}

檢視組織中叢集的相關資訊。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>顯示其他叢集資源，例如附加程式、VLAN、子網路及儲存空間。</dd>


  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>



**指令範例**：

  ```
  ibmcloud ks cluster-get --cluster my_cluster --showResources
  ```
  {: pre}

**輸出範例**：

  ```
  Name:                   mycluster
  ID:                     df253b6025d64944ab99ed63bb4567b6
  State:                  normal
  Created:                2018-09-28T15:43:15+0000
  Location:               dal10
  Master URL:             https://169.xx.xxx.xxx:30426
  Master Location:        Dallas
  Master Status:          Ready (21 hours ago)
  Ingress Subdomain:      ...
  Ingress Secret:         mycluster
  Workers:                6
  Worker Zones:           dal10, dal12
  Version:                1.11.3_1524
  Owner:                  owner@email.com
  Monitoring Dashboard:   ...
  Resource Group ID:      a8a12accd63b437bbd6d58fb6a462ca7

  Addons
  Name                   Enabled
  customer-storage-pod   true
  basic-ingress-v2       true
  storage-watcher-pod    true

  Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false

  ```
  {: screen}

### ibmcloud ks cluster-rm --cluster CLUSTER [--force-delete-storage][-f] [-s]
{: #cs_cluster_rm}

從組織移除叢集。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--force-delete-storage</code></dt>
   <dd>刪除叢集以及叢集所使用的任何持續性儲存空間。**注意**：如果您包括此旗標，則無法回復儲存至叢集或其關聯儲存空間實例的資料。這是選用值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制移除叢集，而不出現使用者提示。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks cluster-rm --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks cluster-update [-f] --cluster CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update] [-f][-s]
{: #cs_cluster_update}

將 Kubernetes 主節點更新為預設 API 版本。在更新期間，您無法存取或變更叢集。由使用者部署的工作者節點、應用程式及資源不會遭到修改，並會繼續執行。

您可能需要變更 YAML 檔案以進行未來的部署。如需詳細資料，請檢閱此[版本注意事項](cs_versions.html)。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>叢集的 Kubernedes 版本。如果您未指定版本，則 Kubernetes 主節點會更新為預設 API 版本。若要查看可用的版本，請執行 [ibmcloud ks kube-versions](#cs_kube_versions)。這是選用值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制更新主節點，而不出現使用者提示。這是選用值。</dd>

   <dt><code>--force-update</code></dt>
   <dd>即使變更大於兩個次要版本，也要嘗試更新。這是選用值。</dd>

   <dt><code>-f</code></dt>
   <dd>強制執行指令，而不出現使用者提示。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks cluster-update --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks clusters [--json][-s]
{: #cs_clusters}

檢視組織中的叢集清單。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**範例**：

  ```
  ibmcloud ks clusters
  ```
  {: pre}


### ibmcloud ks kube-versions [--json][-s]
{: #cs_kube_versions}

檢視 {{site.data.keyword.containerlong_notm}} 中支援的 Kubernetes 版本清單。將您的[主要叢集](#cs_cluster_update)及[工作者節點](cs_cli_reference.html#cs_worker_update)更新為最新且功能穩定的預設版本。

<strong>最低必要許可權</strong>：無

**指令選項**：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**範例**：

  ```
  ibmcloud ks kube-versions
  ```
  {: pre}

<br />



## 叢集指令：服務與整合
{: #cluster_services_commands}


### ibmcloud ks cluster-service-bind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_NAME [-s]
{: #cs_cluster_service_bind}

將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集。若要從 {{site.data.keyword.Bluemix_notm}} 型錄檢視可用的 {{site.data.keyword.Bluemix_notm}} 服務，請執行 `ibmcloud service offerings`。**附註**：您只能新增支援服務金鑰的 {{site.data.keyword.Bluemix_notm}} 服務。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色，以及**開發人員** Cloud Foundry 角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名稱空間的名稱。這是必要值。</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_NAME</em></code></dt>
   <dd>您要連結的 {{site.data.keyword.Bluemix_notm}} 服務實例的名稱。若要尋找服務實例的名稱，請執行 <code>ibmcloud service list</code>。如果帳戶中有多個實例具有相同名稱，請使用服務實例 ID 而非名稱。若要尋找 ID，請執行 <code>ibmcloud service show <service instance name> --guid</code>。其中一個值是必要的。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks cluster-service-bind --cluster my_cluster --namespace my_namespace --service my_service_instance
  ```
  {: pre}


### ibmcloud ks cluster-service-unbind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_GUID [-s]
{: #cs_cluster_service_unbind}

從叢集裡移除 {{site.data.keyword.Bluemix_notm}} 服務。

**附註：**移除 {{site.data.keyword.Bluemix_notm}} 服務時，會從叢集裡移除服務認證。如果 pod 仍在使用服務，會因為找不到服務認證而失敗。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色，以及**開發人員** Cloud Foundry 角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名稱空間的名稱。這是必要值。</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>您要移除的 {{site.data.keyword.Bluemix_notm}} 服務實例的 ID。若要尋找服務實例的 ID，請執行 `ibmcloud ks cluster-services <cluster_name_or_ID>`。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks cluster-service-unbind --cluster my_cluster --namespace my_namespace --service 8567221
  ```
  {: pre}


### ibmcloud ks cluster-services --cluster CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces] [--json][-s]
{: #cs_cluster_services}

列出連結至叢集裡一個或所有 Kubernetes 名稱空間的服務。如果未指定任何選項，則會顯示 default 名稱空間的服務。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>包括連結至叢集裡特定名稱空間的服務。這是選用值。</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>包括連結至叢集裡所有名稱空間的服務。這是選用值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks cluster-services --cluster my_cluster --namespace my_namespace
  ```
  {: pre}

### ibmcloud ks va --container CONTAINER_ID [--extended][--vulnerabilities] [--configuration-issues][--json]
{: #cs_va}

在您[安裝容器掃描器](/docs/services/va/va_index.html#va_install_container_scanner)之後，請檢視叢集裡容器的詳細漏洞評量報告。

<strong>最低必要許可權</strong>：{{site.data.keyword.registryshort_notm}} 的**讀者** IAM 服務存取角色

**指令選項**：

<dl>
<dt><code>--container CONTAINER_ID</code></dt>
<dd><p>容器的 ID。這是必要值。</p>
<p>若要尋找容器的 ID，請執行下列動作：<ol><li>[將 Kubernetes CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。</li><li>執行 `kubectl get pods`，以列出 Pod。</li><li>尋找 `kubectl describe pod <pod_name>` 指令輸出中的 **Container ID** 欄位。例如，`Container ID: containerd://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`。</li><li>先移除 ID 中的 `containerd://` 字首，再使用 `ibmcloud ks va` 指令的容器 ID。例如，`1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`。</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>擴充指令輸出，以顯示有漏洞之套件的更多修正資訊。這是選用值。</p>
<p>依預設，掃描結果會顯示 ID、原則狀態、受影響套件和解決方式。使用 `--extended` 旗標，它會新增摘要、供應商安全注意事項及正式注意事項鏈結這類資訊。</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>限制指令輸出僅顯示套件漏洞。這是選用值。如果您使用 `--configuration-issues` 旗標，則無法使用此旗標。</dd>

<dt><code>--configuration-issues</code></dt>
<dd>限制指令輸出僅顯示配置問題。這是選用值。如果您使用 `--vulnerabilities` 旗標，則無法使用此旗標。</dd>

<dt><code>--json</code></dt>
<dd>以 JSON 格式列印指令輸出。這是選用值。</dd>
</dl>

**範例**：

```
ibmcloud ks va --container 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}

### ibmcloud ks key-protect-enable --cluster CLUSTER_NAME_OR_ID --key-protect-url ENDPOINT --key-protect-instance INSTANCE_GUID --crk ROOT_KEY_ID
{: #cs_key_protect}

在叢集中使用 [{{site.data.keyword.keymanagementservicefull}} ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](/docs/services/key-protect/index.html#getting-started-with-key-protect) 作為[金鑰管理服務 (KMS) 提供者 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)，來加密 Kubernetes 密碼。
{: shortdesc}

**重要事項**：如果您刪除 {{site.data.keyword.keymanagementserviceshort}} 實例中的主要金鑰，則無法在叢集中存取或移除密碼中的資料。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

**指令選項**：

<dl>
<dt><code>--container CLUSTER_NAME_OR_ID</code></dt>
<dd>叢集的名稱或 ID。</dd>

<dt><code>--key-protect-url ENDPOINT</code></dt>
<dd>叢集實例的 {{site.data.keyword.keymanagementserviceshort}} 端點。若要取得端點，請參閱[服務端點（依地區）](/docs/services/key-protect/regions.html#endpoints)。</dd>

<dt><code>--key-protect-instance INSTANCE_GUID</code></dt>
<dd>您的 {{site.data.keyword.keymanagementserviceshort}} 實例 GUID。若要取得實例 GUID，請執行 <code>ibmcloud resource service-instance SERVICE_INSTANCE_NAME --id</code>，並複製第二個值（不是完整 CRN）。</dd>

<dt><code>--crk ROOT_KEY_ID</code></dt>
<dd>您的 {{site.data.keyword.keymanagementserviceshort}} 主要金鑰 ID。若要取得 CRK，請參閱[檢視金鑰](/docs/services/key-protect/view-keys.html#view-keys)。</dd>
</dl>

**範例**：

```
ibmcloud ks key-protect-enable --cluster mycluster --key-protect-url keyprotect.us-south.bluemix.net --key-protect-instance a11aa11a-bbb2-3333-d444-e5e555e5ee5 --crk 1a111a1a-bb22-3c3c-4d44-55e555e55e55
```
{: pre}


### ibmcloud ks webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-s]
{: #cs_webhook_create}

登錄 Webhook。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>通知層次（例如 <code>Normal</code> 或 <code>Warning</code>）。<code>Warning</code> 是預設值。這是選用值。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Webhook 類型。目前支援 Slack。這是必要值。</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>Webhook 的 URL。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## 叢集指令：子網路
{: #cluster_subnets_commands}

### ibmcloud ks cluster-subnet-add --cluster CLUSTER --subnet-id SUBNET [-s]
{: #cs_cluster_subnet_add}

您可以將現有可攜式公用或專用子網路從 IBM Cloud 基礎架構 (SoftLayer) 帳戶新增至 Kubernetes 叢集，或重複使用來自已刪除叢集的子網路，而不是使用自動佈建的子網路。

**附註：**
* 可攜式公用 IP 位址是按月計費。如果您在佈建叢集之後移除可攜式公用 IP 位址，則仍須支付一個月的費用，即使您只是短時間使用也是一樣。
* 當您讓子網路可供叢集使用時，會使用這個子網路的 IP 位址來進行叢集網路連線。若要避免 IP 位址衝突，請確定一個子網路只搭配使用一個叢集。請不要同時將一個子網路用於多個叢集或 {{site.data.keyword.containerlong_notm}} 以外的其他用途。
* 若要啟用相同 VLAN 之不同子網路上的工作者節點之間的通訊，您必須[在相同 VLAN 的子網路之間啟用遞送](cs_subnets.html#subnet-routing)。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--subnet-id <em>SUBNET</em></code></dt>
   <dd>子網路的 ID。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks cluster-subnet-add --cluster my_cluster --subnet-id 1643389
  ```
  {: pre}


### ibmcloud ks cluster-subnet-create --cluster CLUSTER --size SIZE --vlan VLAN_ID [-s]
{: #cs_cluster_subnet_create}

在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中建立子網路，並將它設為可供 {{site.data.keyword.containerlong_notm}} 中指定的叢集使用。

**附註：**
* 當您讓子網路可供叢集使用時，會使用這個子網路的 IP 位址來進行叢集網路連線。若要避免 IP 位址衝突，請確定一個子網路只搭配使用一個叢集。請不要同時將一個子網路用於多個叢集或 {{site.data.keyword.containerlong_notm}} 以外的其他用途。
* 如果一個叢集具有多個 VLAN，相同的 VLAN 上具有多個子網路，或多個區域叢集，您必須針對 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud s vlan-spanning` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果您使用 {{site.data.keyword.BluDirectLink}}，則必須改用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。若要啟用 VRF，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 客戶業務代表。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。若要列出叢集，請使用 `ibmcloud ks clusters` [指令](#cs_clusters)。</dd>

   <dt><code>--size <em>SIZE</em></code></dt>
   <dd>子網路 IP 位址的數目。這是必要值。可能的值為 8、16、32 或 64。</dd>

   <dd>要在其中建立子網路的 VLAN。這是必要值。若要列出可用的 VLANS，請使用 `ibmcloud ks vlans <zone>` [指令](#cs_vlans)。子網路佈建於 VLAN 所在的同一個區域中。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks cluster-subnet-create --cluster my_cluster --size 8 --vlan 1764905
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-add --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

將您自己的專用子網路帶到 {{site.data.keyword.containerlong_notm}} 叢集。

這個專用子網路不是 IBM Cloud 基礎架構 (SoftLayer) 所提供的專用子網路。因此，您必須配置子網路的任何入埠及出埠網路資料流量遞送。若要新增 IBM Cloud 基礎架構 (SoftLayer) 子網路，請使用 `ibmcloud ks cluster-subnet-add` [指令](#cs_cluster_subnet_add)。

**附註**：
* 當您將專用使用者子網路新增至叢集時，這個子網路的 IP 位址會用於叢集裡的專用「負載平衡器」。若要避免 IP 位址衝突，請確定一個子網路只搭配使用一個叢集。請不要同時將一個子網路用於多個叢集或 {{site.data.keyword.containerlong_notm}} 以外的其他用途。
* 如果一個叢集具有多個 VLAN，相同的 VLAN 上具有多個子網路，或多個區域叢集，您必須針對 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud s vlan-spanning` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果您使用 {{site.data.keyword.BluDirectLink}}，則必須改用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。若要啟用 VRF，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 客戶業務代表。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>子網路無類別跨網域遞送 (CIDR)。這是必要值，且不得與 IBM Cloud 基礎架構 (SoftLayer) 所使用的任何子網路衝突。

   支援的字首範圍從 `/30`（1 個 IP 位址）一直到 `/24`（253 個 IP 位址）。如果您將 CIDR 設在一個字首長度，之後又需要變更它，則請先新增新的 CIDR，然後[移除舊的 CIDR](#cs_cluster_user_subnet_rm)。</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>專用 VLAN 的 ID。這是必要值。它必須符合叢集裡一個以上工作者節點的專用 VLAN ID。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks cluster-user-subnet-add --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-rm --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

從指定的叢集移除您自己的專用子網路。

**附註：**從您自己的專用子網路部署至 IP 位址的任何服務，都會在移除子網路之後保持作用中。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>子網路無類別跨網域遞送 (CIDR)。這是必要值，且必須符合 `ibmcloud ks cluster-user-subnet-add` [指令](#cs_cluster_user_subnet_add)所設定的 CIDR。</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>專用 VLAN 的 ID。這是必要值，且必須符合 `ibmcloud ks cluster-user-subnet-add` [指令](#cs_cluster_user_subnet_add)所設定的 VLAN ID。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks cluster-user-subnet-rm --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}

### ibmcloud ks subnets [--json][-s]
{: #cs_subnets}

檢視 IBM Cloud 基礎架構 (SoftLayer) 帳戶中可用的子網路清單。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**範例**：

  ```
  ibmcloud ks subnets
  ```
  {: pre}


<br />


## Ingress 應用程式負載平衡器 (ALB) 指令
{: #alb_commands}

### ibmcloud ks alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN [--update][-s]
{: #cs_alb_cert_deploy}

將 {{site.data.keyword.cloudcerts_long_notm}} 實例中的憑證部署或更新至叢集裡的 ALB。

**附註：**您只能更新從相同 {{site.data.keyword.cloudcerts_long_notm}} 實例匯入的憑證。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--update</code></dt>
   <dd>更新叢集裡 ALB 密碼的憑證。這是選用值。</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>ALB 密碼的名稱。這是必要值。</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>憑證 CRN。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

部署 ALB 密碼的範例：

   ```
   ibmcloud ks alb-cert-deploy --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

更新現有 ALB 密碼的範例：

 ```
 ibmcloud ks alb-cert-deploy --update --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud ks alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [--json][-s]
{: #cs_alb_cert_get}

檢視叢集裡的 ALB 密碼的相關資訊。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB 密碼的名稱。需要有這個值，才能取得叢集裡特定 ALB 密碼的相關資訊。</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>憑證 CRN。需要有這個值，才能取得符合叢集裡特定憑證 CRN 的所有 ALB 密碼的相關資訊。</dd>

  <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**範例**：

 提取 ALB 密碼相關資訊的範例：

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 提取符合指定憑證 CRN 的所有 ALB 密碼的相關資訊的範例：

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

移除叢集裡的 ALB 密碼。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB 密碼的名稱。需要有這個值，才能移除叢集裡的特定 ALB 密碼。</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>憑證 CRN。需要有這個值，才能移除符合叢集裡特定憑證 CRN 的所有 ALB 密碼。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

  </dl>

**範例**：

 移除 ALB 密碼的範例：

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 移除符合指定憑證 CRN 的所有 ALB 密碼的範例：

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-certs --cluster CLUSTER [--json][-s]
{: #cs_alb_certs}

檢視叢集裡的 ALB 密碼清單。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>
   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

 ```
 ibmcloud ks alb-certs --cluster my_cluster
 ```
 {: pre}

### ibmcloud ks alb-configure --albID ALB_ID [--enable][--user-ip USERIP] [--disable][--disable-deployment] [-s]
{: #cs_alb_configure}

在標準叢集裡啟用或停用 ALB。依預設，會啟用公用 ALB。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

**指令選項**：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的 ID。執行 <code>ibmcloud ks albs <em>--cluster </em>CLUSTER</code>，以檢視叢集裡 ALB 的 ID。這是必要值。</dd>

   <dt><code>--enable</code></dt>
   <dd>包括此旗標，以在叢集裡啟用 ALB。</dd>

   <dt><code>--disable</code></dt>
   <dd>包括此旗標，以在叢集裡停用 ALB。</dd>

   <dt><code>--disable-deployment</code></dt>
   <dd>包括此旗標，以停用 IBM 提供的 ALB 部署。此旗標不會針對 IBM 提供的 Ingress 子網域或用來公開 Ingress 控制器的負載平衡器服務，移除 DNS 登錄。</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>此參數僅適用於啟用專用 ALB。</li>
    <li>專用 ALB 是使用來自使用者提供的專用子網路的 IP 位址進行部署。如果未提供 IP 位址，則會使用您建立叢集時自動佈建的可攜式專用子網路中的專用 IP 位址進行部署。</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  啟用 ALB 的範例：

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  以使用者提供的 IP 位址啟用 ALB 的範例：

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip user_ip
  ```
  {: pre}

  停用 ALB 的範例：

  ```
  ibmcloud ks alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud ks alb-get --albID ALB_ID [--json][-s]
{: #cs_alb_get}

檢視 ALB 的詳細資料。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的 ID。執行 <code>ibmcloud ks albs --cluster <em>CLUSTER</em></code>，以檢視叢集裡 ALB 的 ID。這是必要值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud ks alb-types [--json][-s]
{: #cs_alb_types}

檢視地區中支援的 ALB 類型。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

  <dl>
  <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**範例**：

  ```
  ibmcloud ks alb-types
  ```
  {: pre}


### ibmcloud ks albs --cluster CLUSTER [--json][-s]
{: #cs_albs}

檢視叢集裡所有 ALB 的狀態。如果未傳回任何 ALB ID，則叢集沒有可攜式子網路。您可以[建立](#cs_cluster_subnet_create)或[新增](#cs_cluster_subnet_add)子網路至叢集。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>您列出可用 ALB 之叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks albs --cluster my_cluster
  ```
  {: pre}


<br />


## 基礎架構指令
{: #infrastructure_commands}



### ibmcloud ks credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME [-s]
{: #cs_credentials_set}

設定 {{site.data.keyword.containerlong_notm}} 資源群組及地區的 IBM Cloud 基礎架構 (SoftLayer) 帳戶認證。

如果您有 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶，依預設，您便可以存取 IBM Cloud 基礎架構 (SoftLayer) 組合。不過，建議您使用您已具有的不同 IBM Cloud 基礎架構 (SoftLayer) 帳戶來訂購基礎架構。您可以使用這個指令，將此基礎架構帳戶鏈結至 {{site.data.keyword.Bluemix_notm}} 帳戶。

如果已手動設定地區及資源群組的 IBM Cloud 基礎架構 (SoftLayer) 認證，則會使用這些認證來訂購資源群組中該地區內所有叢集的基礎架構。這些認證是用來判斷基礎架構許可權，即使該資源群組及地區已有 [IAM API 金鑰](#cs_api_key_info)。如果已儲存其認證的使用者沒有訂購基礎架構的必要許可權，則基礎架構相關動作（例如建立叢集或重新載入工作者節點）可能會失敗。

您無法為同一個 {{site.data.keyword.containerlong_notm}} 資源群組及地區設定多個認證。

**重要事項：**在使用這個指令之前，請確定使用其認證的使用者具有必要的 [{{site.data.keyword.containerlong_notm}} 及 IBM Cloud 基礎架構 (SoftLayer) 許可權](cs_users.html#users)。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud 基礎架構 (SoftLayer) 帳戶 API 使用者名稱。這是必要值。**附註**：基礎架構 API 使用者名稱與 IBM ID 不同。若要檢視基礎架構 API 使用者名稱，請執行下列動作：
   <ol><li>登入 [{{site.data.keyword.Bluemix_notm}} 入口網站 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/)。</li>
   <li>從展開功能表中，選取**基礎架構**。</li>
   <li>從功能表列中，選取**帳戶** > **使用者** > **使用者清單**。</li>
   <li>針對您要檢視的使用者，按一下 **IBM ID 或使用者名稱**。</li>
   <li>在 **API 存取資訊**區段中，檢視 **API 使用者名稱**。</li>
   </ol></dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud 基礎架構 (SoftLayer) 帳戶 API 金鑰。這是必要值。

 <p>
  若要產生 API 金鑰，請執行下列動作：

  <ol>
  <li>登入 [IBM Cloud 基礎架構 (SoftLayer) 入口網站 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://control.bluemix.net/)。</li>
  <li>選取<strong>帳戶</strong>，然後選取<strong>使用者</strong>。</li>
  <li>按一下<strong>產生</strong>，以產生帳戶的 IBM Cloud 基礎架構 (SoftLayer) API 金鑰。</li>
  <li>複製 API 金鑰以便在這個指令中使用。</li>
  </ol>

  若要檢視現有的 API 金鑰，請執行下列動作：
  <ol>
  <li>登入 [IBM Cloud 基礎架構 (SoftLayer) 入口網站 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://control.bluemix.net/)。</li>
  <li>選取<strong>帳戶</strong>，然後選取<strong>使用者</strong>。</li>
  <li>按一下<strong>檢視</strong>，以查看現有的 API 金鑰。</li>
  <li>複製 API 金鑰以便在這個指令中使用。</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

  </dl>

**範例**：

  ```
  ibmcloud ks credentials-set --infrastructure-api-key <api_key> --infrastructure-username dbmanager
  ```
  {: pre}

### ibmcloud ks credentials-unset
{: #cs_credentials_unset}

移除 {{site.data.keyword.containerlong_notm}} 地區的 IBM Cloud 基礎架構 (SoftLayer) 帳戶認證。

移除認證之後，會使用 [IAM API 金鑰](#cs_api_key_info)來訂購 IBM Cloud 基礎架構 (SoftLayer) 中的資源。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

  <dl>
  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**範例**：

  ```
  ibmcloud ks credentials-unset
  ```
  {: pre}


### ibmcloud ks machine-types --zone ZONE [--json][-s]
{: #cs_machine_types}

檢視工作者節點的可用機型清單。機型因區域而異。每一個機型都包括叢集裡每一個工作者節點的虛擬 CPU、記憶體及磁碟空間量。依預設，儲存所有容器資料的次要儲存空間磁碟目錄是使用 LUKS 加密來進行加密。如果在建立叢集的期間包括 `disable-disk-encrypt` 選項，則主機的容器運行環境資料不會加密。[進一步瞭解加密](cs_secure.html#encrypted_disk)。
{:shortdesc}

您可以將工作者節點佈建為共用或專用硬體上的虛擬機器，或佈建為裸機上的實體機器。[進一步瞭解機型選項](cs_clusters_planning.html#shared_dedicated_node)。

<strong>最低必要許可權</strong>：無

<strong>指令選項</strong>：

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>輸入您要列出可用機型的區域。這是必要值。檢閱[可用區域](cs_regions.html#zones)。</dd>

   <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**指令範例**：

  ```
  ibmcloud ks machine-types --zone dal10
  ```
  {: pre}

### ibmcloud ks vlans --zone ZONE [--all][--json] [-s]
{: #cs_vlans}

列出 IBM Cloud 基礎架構 (SoftLayer) 帳戶中區域可用的公用及專用 VLAN。若要列出可用的 VLAN，您必須具有付費帳戶。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>輸入您要列出專用及公用 VLAN 的區域。這是必要值。檢閱[可用區域](cs_regions.html#zones)。</dd>

   <dt><code>--all</code></dt>
   <dd>列出所有可用的 VLAN。依預設會過濾 VLAN，只顯示那些有效的 VLAN。VLAN 若要有效，則必須與基礎架構相關聯，且該基礎架構可以管理具有本端磁碟儲存空間的工作者節點。</dd>

   <dt><code>--json</code></dt>
  <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks vlans --zone dal10
  ```
  {: pre}


### ibmcloud ks vlan-spanning-get [--json][-s]
{: #cs_vlan_spanning_get}

檢視 IBM Cloud 基礎架構 (SoftLayer) 帳戶的 VLAN Spanning 狀態。VLAN 跨越會讓帳戶上的所有裝置都透過專用網路彼此通訊，而不論其指派的 VLAN 為何。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
    <dt><code>--json</code></dt>
      <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

    <dt><code>-s</code></dt>
      <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks vlan-spanning-get
  ```
  {: pre}

<br />


## 記載指令
{: #logging_commands}

### ibmcloud ks logging-config-create --cluster CLUSTER --logsource LOG_SOURCE --type LOG_TYPE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS][--syslog-protocol PROTOCOL]  [--json][--skip-validation] [--force-update][-s]
{: #cs_logging_create}

建立記載配置。您可以使用這個指令，將容器、應用程式、工作者節點、Kubernetes 叢集和 Ingress 應用程式負載平衡器的日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}} 或外部 syslog 伺服器。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色（若為 `kube-audit` 以外的所有日誌來源），以及 {{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色（若為 `kube-audit` 日誌來源）

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>    
    <dd>要為其啟用日誌轉遞的日誌來源。此引數支援以逗點區隔的日誌來源（要套用其配置）清單。接受值為 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> 及 <code>kube-audit</code>。如果您未提供日誌來源，則會建立 <code>container</code> 及 <code>ingress</code> 的配置。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>您要轉遞日誌的位置。選項為 <code>ibm</code>，它會將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}}，還有 <code>syslog</code>，它會將日誌轉遞至外部伺服器。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>您要從該處轉遞日誌的 Kubernetes 名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。此值僅對容器日誌來源有效且為選用。如果未指定名稱空間，則叢集裡的所有名稱空間都會使用此配置。</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
    <dd>記載類型是 <code>syslog</code> 時，則為日誌收集器伺服器的主機名稱或 IP 位址。這對於 <code>syslog</code> 是必要值。記載類型是 <code>ibm</code> 時，則為 {{site.data.keyword.loganalysislong_notm}} 汲取 URL。您可以在[這裡](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)尋找可用的汲取 URL 清單。如果您未指定汲取 URL，則會使用您在其中建立叢集之地區的端點。</dd>

  <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
    <dd>日誌收集器伺服器的埠。這是選用值。如果您未指定埠，則會將標準埠 <code>514</code> 用於 <code>syslog</code>，而將標準埠 <code>9091</code> 用於 <code>ibm</code>。</dd>

  <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
    <dd>選用項目：您要將日誌傳送至其中的 Cloud Foundry 空間的名稱。此值僅對日誌類型 <code>ibm</code> 有效且為選用。如果您未指定空間，則會將日誌傳送至帳戶層次。如果已指定，則必須同時指定組織。</dd>

  <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
    <dd>選用項目：空間所在的 Cloud Foundry 組織的名稱。此值僅對日誌類型 <code>ibm</code> 有效，而且如果您已指定空間，則這是必要值。</dd>

  <dt><code>--app-paths</code></dt>
    <dd>應用程式記載至的容器上的路徑。若要使用來源類型 <code>application</code> 轉遞日誌，您必須提供路徑。若要指定多個路徑，請使用逗點區隔清單。這對於日誌來源 <code>application</code> 是必要值。範例：<code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>記載類型為 <code>syslog</code> 時，所使用的傳送層通訊協定。支援的值為 <code>tcp</code>、<code>tls</code> 及預設 <code>udp</code>。使用 <code>udp</code> 通訊協定轉遞至 rsyslog 伺服器時，會截斷超過 1KB 的日誌。</dd>

  <dt><code>--app-containers</code></dt>
    <dd>若要從應用程式中轉遞日誌，可以指定包含您應用程式之容器的名稱。您可以使用逗點區隔清單來指定多個容器。如果未指定任何容器，則會從包含您所提供路徑的所有容器轉遞日誌。此選項僅適用於日誌來源 <code>application</code>。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>在指定組織及空間名稱時跳過其驗證。跳過驗證可減少處理時間，但是無效的記載配置不會正確轉遞日誌。這是選用值。</dd>

  <dt><code>--force-update</code></dt>
    <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

    <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

在預設埠 9091 上從 `container` 日誌來源轉遞之日誌類型 `ibm` 的範例：

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

在預設埠 514 上從 `container` 日誌來源轉遞之日誌類型 `syslog` 的範例：

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

在與預設值不同的埠上從 `ingress` 來源轉遞日誌之日誌類型 `syslog` 的範例：

  ```
  ibmcloud ks logging-config-create --cluster my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud ks logging-config-get --cluster CLUSTER [--logsource LOG_SOURCE][--json] [-s]
{: #cs_logging_get}

檢視叢集的所有日誌轉遞配置，或根據日誌來源來過濾記載配置。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

 <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
    <dd>您要過濾的日誌來源種類。只會傳回叢集裡這個日誌來源的記載配置。接受值為 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> 及 <code>kube-audit</code>。這是選用值。</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>顯示將先前過濾器呈現為已作廢的記載過濾器。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
 </dl>

**範例**：

  ```
  ibmcloud ks logging-config-get --cluster my_cluster --logsource worker
  ```
  {: pre}


### ibmcloud ks logging-config-refresh --cluster CLUSTER  [--force-update]  [-s]
{: #cs_logging_refresh}

重新整理叢集的記載配置。這會為轉遞至您叢集空間層次的任何記載配置，重新整理其記載記號。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--force-update</code></dt>
     <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

   <dt><code>-s</code></dt>
     <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks logging-config-refresh --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks logging-config-rm --cluster CLUSTER [--id LOG_CONFIG_ID] [--all] [--force-update] [-s]
{: #cs_logging_rm}

刪除叢集的一個日誌轉遞配置或所有記載配置。這會停止將日誌轉遞至遠端 syslog 伺服器或 {{site.data.keyword.loganalysisshort_notm}}。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色（若為 `kube-audit` 以外的所有日誌來源），以及 {{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色（若為 `kube-audit` 日誌來源）

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>如果您要移除單一記載配置，則為記載配置 ID。</dd>

  <dt><code>--all</code></dt>
   <dd>此旗標會移除叢集裡的所有記載配置。</dd>

  <dt><code>--force-update</code></dt>
    <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

   <dt><code>-s</code></dt>
     <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks logging-config-rm --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud ks logging-config-update --cluster CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE] [--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT] [--space CLUSTER_SPACE] [--org CLUSTER_ORG] [--app-paths PATH] [--app-containers PATH] [--json] [--skipValidation] [--force-update] [-s]
{: #cs_logging_update}

更新日誌轉遞配置的詳細資料。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>您要更新的記載配置 ID。這是必要值。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>您要使用的日誌轉遞通訊協定。目前支援 <code>syslog</code> 和 <code>ibm</code>。這是必要值。</dd>

  <dt><code>--namespace <em>NAMESPACE</em></code>
    <dd>您要從該處轉遞日誌的 Kubernetes 名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。此值僅適用於 <code>container</code> 日誌來源。如果未指定名稱空間，則叢集裡的所有名稱空間都會使用此配置。</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>記載類型是 <code>syslog</code> 時，則為日誌收集器伺服器的主機名稱或 IP 位址。這對於 <code>syslog</code> 是必要值。記載類型是 <code>ibm</code> 時，則為 {{site.data.keyword.loganalysislong_notm}} 汲取 URL。您可以在[這裡](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)尋找可用的汲取 URL 清單。如果您未指定汲取 URL，則會使用您在其中建立叢集之地區的端點。</dd>

   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>日誌收集器伺服器的埠。當記載類型是 <code>syslog</code> 時，這是選用值。如果您未指定埠，則會將標準埠 <code>514</code> 用於 <code>syslog</code>，而將 <code>9091</code> 用於 <code>ibm</code>。</dd>

   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>選用項目：您要將日誌傳送至其中的空間名稱。此值僅對日誌類型 <code>ibm</code> 有效且為選用。如果您未指定空間，則會將日誌傳送至帳戶層次。如果已指定，則必須同時指定組織。</dd>

   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>選用項目：空間所在的 Cloud Foundry 組織的名稱。此值僅對日誌類型 <code>ibm</code> 有效，而且如果您已指定空間，則這是必要值。</dd>

   <dt><code>--app-paths <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>容器中要從中收集日誌的絕對檔案路徑。可以使用萬用字元（例如 '/var/log/*.log'），但無法使用遞迴 Glob（例如 '/var/log/**/test.log'）。若要指定多個路徑，請使用逗點區隔清單。當您針對日誌來源指定 'application' 時，這是必要值。</dd>

   <dt><code>--app-containers <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>應用程式記載至的容器上的路徑。若要使用來源類型 <code>application</code> 轉遞日誌，您必須提供路徑。若要指定多個路徑，請使用逗點區隔清單。範例：<code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>在指定組織及空間名稱時跳過其驗證。跳過驗證可減少處理時間，但是無效的記載配置不會正確轉遞日誌。這是選用值。</dd>

  <dt><code>--force-update</code></dt>
    <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

   <dt><code>-s</code></dt>
     <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

**日誌類型 `ibm`** 的範例：

  ```
  ibmcloud ks logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**日誌類型 `syslog`** 的範例：

  ```
  ibmcloud ks logging-config-update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud ks logging-filter-create --cluster CLUSTER --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_create}

建立記載過濾器。您可以使用這個指令來過濾掉記載配置所轉遞的日誌。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要為其建立記載過濾器之叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>您要將過濾器套用至其中的日誌類型。目前支援 <code>all</code>、<code>container</code> 及 <code>host</code>。</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>以逗點區隔的記載配置 ID 清單。如果未提供，過濾器會套用至傳遞給過濾器的所有叢集記載配置。您可以使用 <code>--show-matching-configs</code> 旗標與指令搭配，來檢視符合過濾器的日誌配置。這是選用值。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>您要從中過濾日誌的 Kubernetes 名稱空間。這是選用值。</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>您要從中過濾掉日誌的容器名稱。只有在您使用日誌類型 <code>container</code> 時，此旗標才適用。這是選用值。</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>過濾掉指定層次以下的日誌。可接受的值依其標準順序為 <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code> 及 <code>trace</code>。這是選用值。舉例來說，如果您過濾掉 <code>info</code> 層次的日誌，則也會過濾掉 <code>debug</code> 及 <code>trace</code>。**附註**：只有在日誌訊息是 JSON 格式且包含 level 欄位時，才能使用此旗標。輸出範例：<code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>過濾掉日誌中任何位置包含指定訊息的任何日誌。這是選用值。範例：訊息 "Hello"、"!" 及 "Hello, World!" 將套用至日誌 "Hello, World!"。</dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>過濾掉日誌中任何位置包含撰寫為正規表示式之指定訊息的任何日誌。這是選用值。範例：型樣 "hello [0-9]" 將套用至 "hello 1"、"hello 2" 及 "hello 9"。</dd>

  <dt><code>--force-update</code></dt>
    <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

這個範例會過濾掉從 default 名稱空間中名為 `test-container` 的容器轉遞而來、在 debug 層次以下，並且具有包含 "GET request" 之日誌訊息的所有日誌。

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

這個範例會過濾掉從特定叢集轉遞且在 info 層次以下的所有日誌。輸出會以 JSON 傳回。

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud ks logging-filter-get --cluster CLUSTER [--id FILTER_ID] [--show-matching-configs] [--show-covering-filters] [--json] [-s]
{: #cs_log_filter_view}

檢視記載過濾器配置。您可以使用這個指令來檢視您所建立的記載過濾器。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要檢視其過濾器之叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>您要檢視的日誌過濾器 ID。</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>顯示符合您正在檢視之配置的記載配置。這是選用值。</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>顯示將先前過濾器呈現為已作廢的記載過濾器。這是選用值。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>-s</code></dt>
     <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

```
ibmcloud ks logging-filter-get mycluster --id 885732 --show-matching-configs
```
{: pre}

### ibmcloud ks logging-filter-rm --cluster CLUSTER [--id FILTER_ID] [--all] [--force-update] [-s]
{: #cs_log_filter_delete}

刪除記載過濾器。您可以使用這個指令來移除您所建立的記載過濾器。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要從中刪除過濾器之叢集的名稱或 ID。</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>要刪除的日誌過濾器 ID。</dd>

  <dt><code>--all</code></dt>
    <dd>刪除所有日誌轉遞過濾器。這是選用值。</dd>

  <dt><code>--force-update</code></dt>
    <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

```
ibmcloud ks logging-filter-rm mycluster --id 885732
```
{: pre}

### ibmcloud ks logging-filter-update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_update}

更新記載過濾器。您可以使用這個指令來更新您所建立的記載過濾器。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**編輯者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要更新其記載過濾器之叢集的名稱或 ID。這是必要值。</dd>

 <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>要更新的日誌過濾器 ID。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>您要將過濾器套用至其中的日誌類型。目前支援 <code>all</code>、<code>container</code> 及 <code>host</code>。</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>以逗點區隔的記載配置 ID 清單。如果未提供，過濾器會套用至傳遞給過濾器的所有叢集記載配置。您可以使用 <code>--show-matching-configs</code> 旗標與指令搭配，來檢視符合過濾器的日誌配置。這是選用值。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>您要從中過濾日誌的 Kubernetes 名稱空間。這是選用值。</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>您要從中過濾掉日誌的容器名稱。只有在您使用日誌類型 <code>container</code> 時，此旗標才適用。這是選用值。</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>過濾掉指定層次以下的日誌。可接受的值依其標準順序為 <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code> 及 <code>trace</code>。這是選用值。舉例來說，如果您過濾掉 <code>info</code> 層次的日誌，則也會過濾掉 <code>debug</code> 及 <code>trace</code>。**附註**：只有在日誌訊息是 JSON 格式且包含 level 欄位時，才能使用此旗標。輸出範例：<code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>過濾掉日誌中任何位置包含指定訊息的任何日誌。這是選用值。範例：訊息 "Hello"、"!" 及 "Hello, World!" 將套用至日誌 "Hello, World!"。</dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>過濾掉日誌中任何位置包含撰寫為正規表示式之指定訊息的任何日誌。這是選用值。範例：型樣 "hello [0-9]" 將套用至 "hello 1"、"hello 2" 及 "hello 9"</dd>

  <dt><code>--force-update</code></dt>
    <dd>強制 Fluentd Pod 更新成最新版本。Fluentd 必須為最新版本，才能變更記載配置。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

這個範例會過濾掉從 default 名稱空間中名為 `test-container` 的容器轉遞而來、在 debug 層次以下，並且具有包含 "GET request" 之日誌訊息的所有日誌。

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 885274 --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

這個範例會過濾掉從特定叢集轉遞且在 info 層次以下的所有日誌。輸出會以 JSON 傳回。

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 274885 --type all --level info --json
  ```
  {: pre}

### ibmcloud ks logging-autoupdate-enable --cluster CLUSTER
{: #cs_log_autoupdate_enable}

啟用自動更新特定叢集裡的 Fluentd Pod。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要更新其記載過濾器之叢集的名稱或 ID。這是必要值。</dd>
</dl>

**範例：**
```
ibmcloud ks logging-autoupdate-enable --cluster mycluster
```
{: pre}

### ibmcloud ks logging-autoupdate-disable --cluster CLUSTER
{: #cs_log_autoupdate_disable}

停用自動更新特定叢集裡的 Fluentd Pod。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要更新其記載過濾器之叢集的名稱或 ID。這是必要值。</dd>
</dl>

**範例：**
```
ibmcloud ks logging-autoupdate-disable --cluster mycluster
```
{: pre}

### ibmcloud ks logging-autoupdate-get --cluster CLUSTER
{: #cs_log_autoupdate_get}

檢視是否將您的 Fluentd Pod 設為在特定叢集裡自動更新。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要更新其記載過濾器之叢集的名稱或 ID。這是必要值。</dd>
</dl>

**範例：**
```
ibmcloud ks logging-autoupdate-get --cluster mycluster
```
{: pre}

### ibmcloud ks logging-collect --cluster CLUSTER --cos-bucket BUCKET_NAME --cos-endpoint ENDPOINT --hmac-key-id HMAC_KEY_ID --hmac-key HMAC_KEY --type LOG_TYPE [-s]
{: #cs_log_collect}

要求日誌在特定時間點的 Snapshot，然後將日誌儲存在 {{site.data.keyword.cos_full_notm}} 儲存區中。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要為其建立 Snapshot 之叢集的名稱或 ID。這是必要值。</dd>

 <dt><code>--cos-bucket <em>BUCKET_NAME</em></code></dt>
    <dd>您想要在其中儲存日誌之 {{site.data.keyword.cos_short}} 儲存區的名稱。這是必要值。</dd>

  <dt><code>--cos-endpoint <em>ENDPOINT</em></code></dt>
    <dd>您要在其中儲存日誌之儲存區的 {{site.data.keyword.cos_short}} 端點。這是必要值。</dd>

  <dt><code>--hmac-key-id <em>HMAC_KEY_ID</em></code></dt>
    <dd>「物件儲存空間」實例之 HMAC 認證的唯一 ID。這是必要值。</dd>

  <dt><code>--hmac-key <em>HMAC_KEY</em></code></dt>
    <dd>{{site.data.keyword.cos_short}} 實例的 HMAC 金鑰。這是必要值。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>您要建立 Snapshot 的日誌類型。目前，`master` 是唯一選項，以及預設值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  ```
  {: pre}

**輸出範例**：

  ```
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

### ibmcloud ks logging-collect-status --cluster CLUSTER [--json][-s]
{: #cs_log_collect_status}

檢查叢集的日誌收集 Snapshot 要求的狀態。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**管理者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要為其建立 Snapshot 之叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  ```
  {: pre}

**輸出範例**：

  ```
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## 地區指令
{: #region_commands}

### ibmcloud ks zones [--region-only] [--json] [-s]
{: #cs_datacenters}

檢視可讓您在其中建立叢集的可用區域清單。可用的區域因您登入的地區而異。若要切換地區，請執行 `ibmcloud ks region-set`。

<strong>最低必要許可權</strong>：無

<strong>指令選項</strong>：

   <dl>
   <dt><code>--region-only</code></dt>
   <dd>僅列出您所登入地區內的多區域。這是選用值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks zones
  ```
  {: pre}


### ibmcloud ks region
{: #cs_region}

尋找您目前所在的 {{site.data.keyword.containerlong_notm}} 地區。您可以建立及管理地區特定的叢集。使用 `ibmcloud ks region-set` 指令來變更地區。

<strong>最低必要許可權</strong>：無

**範例**：

```
ibmcloud ks region
```
{: pre}

**輸出**：
```
Region: us-south
```
{: screen}

### ibmcloud ks region-set [--region REGION]
{: #cs_region-set}

設定 {{site.data.keyword.containerlong_notm}} 的地區。您可以建立及管理地區特定的叢集，而且可能要多個地區中都有叢集，才能獲得高可用性。

例如，您可以在美國南部地區登入 {{site.data.keyword.Bluemix_notm}}，並建立叢集。接下來，您可以使用 `ibmcloud ks region-set eu-central` 來將目標設為歐盟中部地區，並建立另一個叢集。最後，您可以使用 `ibmcloud ks region-set us-south` 回到美國南部，以管理該地區中的叢集。

<strong>最低必要許可權</strong>：無

**指令選項**：

<dl>
<dt><code>--region <em>REGION</em></code></dt>
<dd>輸入您要設為目標的地區。這是選用值。如果您未提供地區，則可以從輸出的清單中選取該地區。



如需可用地區清單，請檢閱[地區及區域](cs_regions.html)，或使用 `ibmcloud ks regions` [指令](#cs_regions)。</dd></dl>

**範例**：

```
ibmcloud ks region-set eu-central
```
{: pre}

```
ibmcloud ks region-set
```
{: pre}

**輸出**：
```
Choose a region:
1. ap-north
2. ap-south
3. eu-central
4. uk-south
5. us-east
6. us-south
Enter a number> 3
OK
```
{: screen}

### ibmcloud ks regions
{: #cs_regions}

列出可用的地區。`Region Name` 是 {{site.data.keyword.containerlong_notm}} 名稱，而 `Region Alias` 是地區的一般 {{site.data.keyword.Bluemix_notm}} 名稱。

<strong>最低必要許可權</strong>：無

**範例**：

```
ibmcloud ks regions
```
{: pre}

**輸出**：
```
Region Name   Region Alias
ap-north      jp-tok
ap-south      au-syd
eu-central    eu-de
uk-south      eu-gb
us-east       us-east
us-south      us-south
```
{: screen}


<br />


## 工作者節點指令
{: worker_node_commands}


### 已淘汰：ibmcloud ks worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt][-s]
{: #cs_worker_add}

將獨立式工作者節點新增至不在工作者節點儲存區中的標準叢集。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>叢集的名稱或 ID。這是必要值。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>將工作者節點新增至叢集之 YAML 檔案的路徑。您可以使用 YAML 檔案，而不是使用這個指令中所提供的選項來定義其他工作者節點。這是選用值。

<p><strong>附註：</strong>如果您在指令中提供與 YAML 檔案中的參數相同的選項，則指令中的值優先順序會高於 YAML 中的值。例如，您在 YAML 檔案中定義了機型，並在指令中使用 --machine-type 選項，則您在指令選項中輸入的值會置換 YAML 檔案中的值。



<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_ID&gt;</em>
zone: <em>&lt;zone&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
diskEncryption: <em>false</em></code></pre>

<table>
<caption>瞭解 YAML 檔案元件</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>將 <code><em>&lt;cluster_name_or_ID&gt;</em></code> 取代為您要新增工作者節點之叢集的名稱或 ID。</td>
</tr>
<tr>
<td><code><em>zone</em></code></td>
<td>將 <code><em>&lt;zone&gt;</em></code> 取代為您要部署工作者節點的區域。可用的區域取決於您所登入的地區。若要列出可用的區域，請執行 <code>ibmcloud ks zones</code>。</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>將 <code><em>&lt;machine_type&gt;</em></code> 取代為您要將工作者節點部署至其中的機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-types` [指令](cs_cli_reference.html#cs_machine_types)。</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>將 <code><em>&lt;private_VLAN&gt;</em></code> 取代為您要用於工作者節點的專用 VLAN ID。若要列出可用的 VLAN，請執行 <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>，並尋找開頭為 <code>bcr</code>（後端路由器）的 VLAN 路由器。</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>將 <code>&lt;public_VLAN&gt;</code> 取代為您要用於工作者節點的公用 VLAN ID。若要列出可用的 VLAN，請執行 <code>ibmcloud ks vlans &lt;zone&gt;</code>，並尋找開頭為 <code>fcr</code>（前端路由器）的 VLAN 路由器。<br><strong>附註</strong>：如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線。如需相關資訊，請參閱[規劃僅專用叢集網路](cs_network_cluster.html#private_vlan)。</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>若為虛擬機器類型：您的工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>將 <code><em>&lt;number_workers&gt;</em></code> 取代為您要部署的工作者節點數目。</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>依預設，工作者節點會具備磁碟加密；[進一步瞭解](cs_secure.html#encrypted_disk)。若要停用加密，請包含此選項，並將值設為 <code>false</code>。</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。這是選用值。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>選擇機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-types` [指令](cs_cli_reference.html#cs_machine_types)的文件。此值對於標準叢集是必要的，不適用於免費叢集。</dd>

<dt><code>--workers <em>NUMBER</em></code></dt>
<dd>整數，代表要在叢集裡建立的工作者節點數目。預設值為 1。這是選用值。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>建立叢集時所指定的專用 VLAN。這是必要值。

<p><strong>附註：</strong>專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>建立叢集時所指定的公用 VLAN。這是選用值。如果想要工作者節點僅存在於專用 VLAN 上，請不要提供公用 VLAN ID。<strong>附註</strong>：如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線。如需相關資訊，請參閱[規劃僅專用叢集網路](cs_network_cluster.html#private_vlan)。

<p><strong>附註：</strong>專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>依預設，工作者節點會具備磁碟加密；[進一步瞭解](cs_secure.html#encrypted_disk)。若要停用加密，請包含此選項。</dd>

<dt><code>-s</code></dt>
<dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

</dl>

**範例**：

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}} 的範例：

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud ks worker-get --cluster [CLUSTER_NAME_OR_ID] --worker WORKER_NODE_ID [--json][-s]
{: #cs_worker_get}

檢視工作者節點的詳細資料。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>工作者節點叢集的名稱或 ID。這是選用值。</dd>

   <dt><code>--worker <em>WORKER_NODE_ID</em></code></dt>
   <dd>工作者節點的名稱。執行 <code>ibmcloud ks workers <em>CLUSTER</em></code>，以檢視叢集裡工作者節點的 ID。這是必要值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**指令範例**：

  ```
  ibmcloud ks worker-get --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**輸出範例**：

  ```
  ID:           kube-dal10-123456789-w1
  State:        normal
  Status:       Ready
  Trust:        disabled
  Private VLAN: 223xxxx
  Public VLAN:  223xxxx
  Private IP:   10.xxx.xx.xxx
  Public IP:    169.xx.xxx.xxx
  Hardware:     shared
  Zone:         dal10
  Version:      1.8.11_1509
  ```
  {: screen}

### ibmcloud ks worker-reboot [-f][--hard] --cluster CLUSTER --worker WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reboot}

重新啟動叢集裡的工作者節點。在重新啟動期間，工作者節點的狀況不會變更。例如，如果 IBM Cloud 基礎架構 (SoftLayer) 中的工作者節點狀態為 `Powered Off`，且您需要開啟工作程式節點，則可以使用重新開機。

**注意：**重新啟動工作者節點，可能會造成工作者節點上的資料毀損。當您知道重新啟動可以協助回復工作者節點時，請小心使用這個指令。除此之外，請改為[重新載入工作者節點](#cs_worker_reload)。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

在您重新啟動工作者節點之前，請確定在其他工作者節點上的 Pod 已重新排程，這有助於避免應用程式關閉，或工作者節點上的資料毀損。

1. 列出叢集裡的所有工作者節點，並記下您要重新啟動的工作者節點的**名稱**。
   ```
   kubectl get nodes
   ```
   {: pre}
   這個指令傳回的**名稱**是指派給工作者節點的專用 IP 位址。您可以執行 `ibmcloud ks workers <cluster_name_or_ID>` 指令並尋找具有相同**專用 IP** 位址的工作者節點，來找到工作者節點的相關資訊。
2. 在一個稱為隔離的處理程序中，將工作者節點標示為無法排程。當您隔離工作者節點時，會使它無法用於未來 Pod 排程。請使用您在前一個步驟中擷取之工作者節點的**名稱**。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. 驗證已停用工作者節點的 Pod 排程。
   ```
   kubectl get nodes
   ```
   {: pre}
   如果狀態顯示 **SchedulingDisabled**，表示工作者節點已停用 Pod 排程。
 4. 強制從工作者節點移除 Pod，並將其重新排程至叢集裡的其餘工作者節點。
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    此處理程序可能需要幾分鐘的時間。
 5. 重新啟動工作者節點。請使用從 `ibmcloud ks workers <cluster_name_or_ID>` 指令傳回的工作者節點 ID。
    ```
    ibmcloud ks worker-reboot --cluster <cluster_name_or_ID> --workers <worker_name_or_ID>
    ```
    {: pre}
 6. 在讓工作者節點可用於 pod 排程之前等待大約 5 分鐘，以確定重新啟動已完成。在重新啟動期間，工作者節點的狀況不會變更。工作者節點的重新啟動通常會在幾秒鐘內完成。
 7. 讓工作者節點可用於 Pod 排程。請使用從 `kubectl get node` 指令傳回的工作者節點的**名稱**。
    ```
    kubectl uncordon <worker_name>
    ```
    {: pre}

    </br>

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制重新啟動工作者節點，而不出現使用者提示。這是選用值。</dd>

   <dt><code>--hard</code></dt>
   <dd>使用此選項，透過切斷工作者節點的電源來強制執行強迫重新啟動工作者節點。如果工作者節點沒有回應，或工作者節點的容器運行環境沒有回應，請使用此選項。這是選用值。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的名稱或 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>在重新載入或重新啟動工作者節點之前，跳過主節點的性能檢查。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks worker-reboot --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-reload [-f] --cluster CLUSTER --worker WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reload}

重新載入工作者節點的所有必要配置。如果您的工作者節點遇到問題，例如效能變慢，或工作者節點停留在不健全的狀況下，則重新載入可能會很有幫助。

重新載入工作者節點會將修補程式版本更新套用至您的工作者節點，但不會套用主要或次要更新。若要查看從某個修補程式版本到下一個修補程式版本的變更，請檢閱[版本變更日誌](cs_versions_changelog.html#changelog)文件。
{: tip}

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

在您重新載入工作者節點之前，請確定在其他工作者節點上的 Pod 已重新排程，這有助於避免應用程式關閉，或工作者節點上的資料毀損。

1. 列出叢集裡的所有工作者節點，並記下您要重新載入的工作者節點的**名稱**。
   ```
   kubectl get nodes
   ```
   這個指令傳回的**名稱**是指派給工作者節點的專用 IP 位址。您可以執行 `ibmcloud ks workers <cluster_name_or_ID>` 指令並尋找具有相同**專用 IP** 位址的工作者節點，來找到工作者節點的相關資訊。
2. 在一個稱為隔離的處理程序中，將工作者節點標示為無法排程。當您隔離工作者節點時，會使它無法用於未來 Pod 排程。請使用您在前一個步驟中擷取之工作者節點的**名稱**。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. 驗證已停用工作者節點的 Pod 排程。
   ```
   kubectl get nodes
   ```
   {: pre}
   如果狀態顯示 **SchedulingDisabled**，表示工作者節點已停用 Pod 排程。
 4. 強制從工作者節點移除 Pod，並將其重新排程至叢集裡的其餘工作者節點。
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    此處理程序可能需要幾分鐘的時間。
 5. 重新載入工作者節點。請使用從 `ibmcloud ks workers <cluster_name_or_ID>` 指令傳回的工作者節點 ID。
    ```
    ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
 6. 等待重新載入完成。
 7. 讓工作者節點可用於 Pod 排程。請使用從 `kubectl get node` 指令傳回的工作者節點的**名稱**。
    ```
    kubectl uncordon <worker_name>
    ```
</br>
<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制重新載入工作者節點，而不出現使用者提示。這是選用值。</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的名稱或 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>在重新載入或重新啟動工作者節點之前，跳過主節點的性能檢查。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks worker-reload --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-rm [-f] --cluster CLUSTER --workers WORKER[,WORKER] [-s]
{: #cs_worker_rm}

從叢集裡移除一個以上的工作者節點。如果您移除工作者節點，叢集會變成不平衡。您可以執行 `ibmcloud ks worker-pool-rebalance` [指令](#cs_rebalance)，以自動重新平衡工作者節點儲存區。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

在您移除工作者節點之前，請確定在其他工作者節點上的 Pod 已重新排程，這有助於避免應用程式關閉，或工作者節點上的資料毀損。
{: tip}

1. 列出叢集裡的所有工作者節點，並記下您要移除的工作者節點的**名稱**。
   ```
   kubectl get nodes
   ```
   這個指令傳回的**名稱**是指派給工作者節點的專用 IP 位址。您可以執行 `ibmcloud ks workers <cluster_name_or_ID>` 指令並尋找具有相同**專用 IP** 位址的工作者節點，來找到工作者節點的相關資訊。
2. 在一個稱為隔離的處理程序中，將工作者節點標示為無法排程。當您隔離工作者節點時，會使它無法用於未來 Pod 排程。請使用您在前一個步驟中擷取之工作者節點的**名稱**。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. 驗證已停用工作者節點的 Pod 排程。
   ```
   kubectl get nodes
   ```
   {: pre}
   如果狀態顯示 **SchedulingDisabled**，表示工作者節點已停用 Pod 排程。
4. 強制從工作者節點移除 Pod，並將其重新排程至叢集裡的其餘工作者節點。
   ```
   kubectl drain <worker_name>
   ```
   {: pre}
   此處理程序可能需要幾分鐘的時間。
5. 移除工作者節點。請使用從 `ibmcloud ks workers <cluster_name_or_ID>` 指令傳回的工作者節點 ID。
   ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
   {: pre}

6. 驗證已移除工作者節點。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
</br>
<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制移除工作者節點，而不出現使用者提示。這是選用值。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的名稱或 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks worker-rm --cluster my_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-update [-f] --cluster CLUSTER --workers WORKER[,WORKER] [--kube-version MAJOR.MINOR.PATCH] [--force-update] [-s]
{: #cs_worker_update}

更新工作者節點以將最新的安全更新及修補程式套用至作業系統，並更新 Kubernetes 版本以符合 Kubernetes 主節點的版本。您可以使用 `ibmcloud ks cluster-update` [指令](cs_cli_reference.html#cs_cluster_update)來更新 Kubernetes 主節點版本。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

**重要事項**：執行 `ibmcloud ks worker-update` 可能會導致應用程式及服務關閉。在更新期間，所有 Pod 會重新排定到其他工作者節點，且資料若未儲存在 Pod 之外便會刪除。若要避免關閉時間，[請確定您有足夠的工作者節點，可以處理所選取工作者節點在更新時的工作負載](cs_cluster_update.html#worker_node)。

您可能需要變更 YAML 檔案以進行部署，然後才更新。如需詳細資料，請檢閱此[版本注意事項](cs_versions.html)。

<strong>指令選項</strong>：

   <dl>

   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>列出可用工作者節點的叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制更新主節點，而不出現使用者提示。這是選用值。</dd>

   <dt><code>--force-update</code></dt>
   <dd>即使變更大於兩個次要版本，也要嘗試更新。這是選用值。</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
     <dd>您要用來更新工作者節點的 Kubernetes 版本。如果未指定此值，則會使用預設版本。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>

   <dt><code>-s</code></dt>
   <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

   </dl>

**範例**：

  ```
  ibmcloud ks worker-update --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}

### ibmcloud ks workers --cluster CLUSTER [--worker-pool POOL] [--show-pools] [--show-deleted] [--json] [-s]
{: #cs_workers}

檢視工作者節點清單以及叢集裡各工作者節點的狀態。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>可用工作者節點之叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--worker-pool <em>POOL</em></code></dt>
   <dd>僅檢視屬於工作者節點儲存區的工作者節點。若要列出可用的工作者節點儲存區，請執行 `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`。這是選用值。</dd>

   <dt><code>--show-pools</code></dt>
   <dd>列出每一個工作者節點所屬的工作者節點儲存區。這是選用值。</dd>

   <dt><code>--show-deleted</code></dt>
   <dd>檢視已從叢集裡刪除的工作者節點，包括刪除的原因。這是選用值。</dd>

   <dt><code>--json</code></dt>
   <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
  <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
   </dl>

**範例**：

  ```
  ibmcloud ks workers --cluster my_cluster
  ```
  {: pre}

<br />


## 工作者節點儲存區指令
{: #worker-pool}

### ibmcloud ks worker-pool-create --name POOL_NAME --cluster CLUSTER --machine-type MACHINE_TYPE --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION [--labels LABELS][--disable-disk-encrypt] [-s][--json]
{: #cs_worker_pool_create}

您可以在叢集裡建立工作者節點儲存區。當您新增工作者節點儲存區時，依預設，不會將區域指派給工作者節點儲存區。您可以指定每一個區域中您想要的工作者節點數目以及工作者節點的機型。工作者節點儲存區會獲指定預設 Kubernetes 版本。若要完成建立工作者節點，請[新增一或數個區域](#cs_zone_add)至儲存區。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：
<dl>

  <dt><code>--name <em>POOL_NAME</em></code></dt>
    <dd>您要指定給工作者節點儲存區的名稱。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>選擇機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-types` [指令](cs_cli_reference.html#cs_machine_types)的文件。此值對於標準叢集是必要的，不適用於免費叢集。</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>要在每一個區域中建立的工作者節點數目。這是必要值，而且必須是 1 或更大的值。</dd>

  <dt><code>--hardware <em>ISOLATION</em></code></dt>
    <dd>工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 `dedicated`，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 `shared`。預設值為 `shared`。若為裸機機型，請指定 `dedicated`。這是必要值。</dd>

  <dt><code>--labels <em>LABELS</em></code></dt>
    <dd>您要在儲存區中指派給工作者節點的標籤。範例：<key1>=<val1>,<key2>=<val2></dd>

  <dt><code>--disable-disk-encrpyt</code></dt>
    <dd>指定磁碟未加密。預設值為 <code>false</code>。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**指令範例**：

  ```
  ibmcloud ks worker-pool-create --name my_pool --cluster my_cluster --machine-type b2c.4x16 --size-per-zone 6
  ```
  {: pre}

### ibmcloud ks worker-pool-get --worker-pool WORKER_POOL --cluster CLUSTER [-s] [--json]
{: #cs_worker_pool_get}

檢視工作者節點儲存區的詳細資料。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>您要檢視其詳細資料之工作者節點儲存區的名稱。若要列出可用的工作者節點儲存區，請執行 `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`。這是必要值。</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>工作者節點儲存區所在之叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**指令範例**：

  ```
  ibmcloud ks worker-pool-get --worker-pool pool1 --cluster my_cluster
  ```
  {: pre}

**輸出範例**：

  ```
  Name:               pool   
  ID:                 a1a11b2222222bb3c33c3d4d44d555e5-f6f777g   
  State:              active   
  Hardware:           shared   
  Zones:              dal10,dal12   
  Workers per zone:   3   
  Machine type:       b2c.4x16.encrypted   
  Labels:             -   
  Version:            1.10.8_1512
  ```
  {: screen}

### ibmcloud ks worker-pool-rebalance --cluster CLUSTER --worker-pool WORKER_POOL [-s]
{: #cs_rebalance}

在您刪除工作者節點之後，可以重新平衡工作者節點儲存區。當您執行這個指令時，會將一或數個新工作者節點新增至工作者節點儲存區。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code><em>--cluster CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。這是必要值。</dd>
  <dt><code><em>--worker-pool WORKER_POOL</em></code></dt>
    <dd>您要重新平衡的工作者節點儲存區。這是必要值。</dd>
  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks worker-pool-rebalance --cluster my_cluster --worker-pool my_pool
  ```
  {: pre}

### ibmcloud ks worker-pool-resize --worker-pool WORKER_POOL --cluster CLUSTER --size-per-zone WORKERS_PER_ZONE [-s]
{: #cs_worker_pool_resize}

調整工作者節點儲存區的大小，以增加或減少叢集之每一個區域中的工作者節點數目。工作者節點儲存區必須至少有 1 個工作者節點。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>您要更新之工作者節點儲存區的名稱。這是必要值。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要調整其工作者節點儲存區大小之叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>您要在每一個區域中包含的工作者節點數目。這是必要值，而且必須是 1 或更大的值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>

</dl>

**指令範例**：

  ```
  ibmcloud ks worker-pool-resize --cluster my_cluster --worker-pool my_pool --size-per-zone 3
  ```
  {: pre}

### ibmcloud ks worker-pool-rm --worker-pool WORKER_POOL --cluster CLUSTER [-s]
{: #cs_worker_pool_rm}

從叢集裡移除工作者節點儲存區。這會刪除儲存區中的所有工作者節點。刪除時會重新排定您的 Pod。為了避免當機，請確定您有足夠的工作者節點來執行工作負載。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>您要移除之工作者節點儲存區的名稱。這是必要值。</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>您要從中移除工作者節點儲存區之叢集的名稱或 ID。這是必要值。</dd>
  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**指令範例**：

  ```
  ibmcloud ks worker-pool-rm --cluster my_cluster --worker-pool pool1
  ```
  {: pre}

### ibmcloud ks worker-pools --cluster CLUSTER [--json] [-s]
{: #cs_worker_pools}

檢視您在叢集裡具有的工作者節點儲存區。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**檢視者** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
    <dd>您要列出其工作者節點儲存區之叢集的名稱或 ID。這是必要值。</dd>
  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>
  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**指令範例**：

  ```
  ibmcloud ks worker-pools --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks zone-add --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN] [--private-only] [--json] [-s]
{: #cs_zone_add}

**僅限多區域叢集**：在您建立叢集或工作者節點儲存區之後，則可以新增區域。當您新增區域時，會將工作者節點新增至新區域，以符合每個區域中針對工作者節點儲存區所指定的工作者節點數目。

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>您要新增的區域。它必須是叢集地區內的[具有多區域功能的區域](cs_regions.html#zones)。這是必要值。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>在其中新增區域的工作者節點儲存區清單（以逗點區隔）。需要至少 1 個工作者節點儲存區。</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd><p>專用 VLAN 的 ID。此值是有條件的。</p>
    <p>如果您在區域中有專用 VLAN，則此值必須符合叢集裡一個以上工作者節點的專用 VLAN ID。若要查看您可用的 VLAN，請執行 <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>。</p>
    <p>如果您在該區域中沒有專用或公用 VLAN，請不要指定此選項。您一開始將新的區域新增至工作者節點儲存區時，即會自動為您建立專用及公用 VLAN。</p>
    <p>如果一個叢集具有多個 VLAN，相同的 VLAN 上具有多個子網路，或多個區域叢集，您必須針對 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud s vlan-spanning` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果您使用 {{site.data.keyword.BluDirectLink}}，則必須改用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。若要啟用 VRF，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 客戶業務代表。</p>
<p>**附註**：新的工作者節點會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。</p></dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd><p>公用 VLAN 的 ID。如果您要在建立叢集之後將節點上的工作負載公開給大眾使用，則這是必要值。它必須符合區域之叢集裡一個以上工作者節點的公用 VLAN ID。若要查看您可用的 VLAN，請執行 <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>。</p>
    <p>如果您在該區域中沒有專用或公用 VLAN，請不要指定此選項。您一開始將新的區域新增至工作者節點儲存區時，即會自動為您建立專用及公用 VLAN。</p>
    <p>如果一個叢集具有多個 VLAN，相同的 VLAN 上具有多個子網路，或多個區域叢集，您必須針對 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud s vlan-spanning` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果您使用 {{site.data.keyword.BluDirectLink}}，則必須改用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。若要啟用 VRF，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 客戶業務代表。</p>
    <p>**附註**：新的工作者節點會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。</p></dd>

  <dt><code>--private-only </code></dt>
    <dd>使用此選項，以防止建立公用 VLAN。只有在您指定 `--private-vlan` 旗標時才為必要項目，並且請不要包括 `--public-vlan` 旗標。**附註**：如果您想要僅限專用叢集，則必須配置閘道應用裝置來連接網路。如需相關資訊，請參閱[專用叢集](cs_clusters_planning.html#private_clusters)。</dd>

  <dt><code>--json</code></dt>
    <dd>以 JSON 格式列印指令輸出。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks zone-add --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

  ### ibmcloud ks zone-network-set --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN] [-f] [-s]
  {: #cs_zone_network_set}

  **僅限多區域叢集**：將工作者節點儲存區的網路 meta 資料設定成使用與先前使用之區域不同的公用或專用 VLAN。已在儲存區中建立的工作者節點會繼續使用前一個公用或專用 VLAN，但儲存區中的新工作者節點會使用新的網路資料。

  <strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

  專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。
  <ol><li>請檢查叢集中可用的 VLAN。<pre class="pre"><code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt; --showResources</code></pre><p>輸出範例：</p>
  <pre class="screen"><code>Subnet VLANs
VLAN ID   Subnet CIDR         Public   User-managed
229xxxx   169.xx.xxx.xxx/29   true     false
229xxxx   10.xxx.xx.x/29      false    false</code></pre></li>
  <li>檢查您要使用的公用及專用 VLAN ID 是相容的。為了能夠相容，<strong>路由器</strong>必須具有相同的 Pod ID。<pre class="pre"><code>ibmcloud ks vlans --zone &lt;zone&gt;</code></pre><p>輸出範例：</p>
  <pre class="screen"><code>ID        Name   Number   Type      Router         Supports Virtual Workers
229xxxx          1234     private   bcr01a.dal12   true
229xxxx          5678     public    fcr01a.dal12   true</code></pre><p>請注意，<strong>路由器</strong> Pod ID 相符項：`01a` 及 `01a`。如果有一個 Pod ID 是 `01a`，而另一個是 `02a`，則您無法對工作者節點儲存區設定這些公用及專用 VLAN ID。</p></li>
  <li>如果您沒有任何可用的 VLAN，則可以<a href="/docs/infrastructure/vlans/order-vlan.html#order-vlans">訂購新的 VLAN</a>。</li></ol>

  <strong>指令選項</strong>：

  <dl>
    <dt><code>--zone <em>ZONE</em></code></dt>
      <dd>您要新增的區域。它必須是叢集地區內的[具有多區域功能的區域](cs_regions.html#zones)。這是必要值。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>在其中新增區域的工作者節點儲存區清單（以逗點區隔）。需要至少 1 個工作者節點儲存區。</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>專用 VLAN 的 ID。不論您是要使用與用於其他工作者節點相同還是不同的專用 VLAN，都需要此值。<br><br><strong>重要事項</strong>：專用及公用 VLAN 必須相容，您可以從**路由器** ID 字首判定。<br><br>**附註**：新的工作者節點會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。</dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>公用 VLAN 的 ID。只有在您要變更區域的公用 VLAN 時，才需要此值。若要變更公用 VLAN，您必須一律提供相容的專用 VLAN。<br><br><strong>重要事項</strong>：專用及公用 VLAN 必須相容，您可以從**路由器** ID 字首判定。<br><br>**附註**：新的工作者節點會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。</dd>

  <dt><code>-f</code></dt>
    <dd>強制執行指令，而不出現使用者提示。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
  </dl>

  **範例**：

  ```
  ibmcloud ks zone-network-set --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

### ibmcloud ks zone-rm --zone ZONE --cluster CLUSTER [-f] [-s]
{: #cs_zone_rm}

**僅限多區域叢集**：移除叢集裡所有工作者節點儲存區的區域。這會刪除此區域之工作者節點儲存區中的所有工作者節點。

在您移除區域之前，請確定叢集的其他區域中有足夠的工作者節點，因此 Pod 可以重新排定以協助避免應用程式關閉，或工作者節點上的資料毀損。
{: tip}

<strong>最低必要許可權</strong>：{{site.data.keyword.containerlong_notm}} 的**操作員** IAM 平台角色

<strong>指令選項</strong>：

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>您要新增的區域。它必須是叢集地區內的[具有多區域功能的區域](cs_regions.html#zones)。這是必要值。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>叢集的名稱或 ID。這是必要值。</dd>

  <dt><code>-f</code></dt>
    <dd>強制執行更新，而不出現使用者提示。這是選用值。</dd>

  <dt><code>-s</code></dt>
    <dd>不要顯示日或更新提示的訊息。這是選用值。</dd>
</dl>

**範例**：

  ```
  ibmcloud ks zone-rm --zone dal10 --cluster my_cluster
  ```
  {: pre}
