---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 管理叢集的 CLI 參考資料
{: #cs_cli_reference}

請參閱這些指令，以建立及管理叢集。
{:shortdesc}

**提示：**要尋找 `bx cr` 指令嗎？請參閱 [{{site.data.keyword.registryshort_notm}} CLI 參考資料](/docs/cli/plugins/registry/index.html)。要尋找 `kubectl` 指令嗎？請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)。


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="在 {{site.data.keyword.Bluemix_notm}} 上用來建立叢集的指令">
 <thead>
    <th colspan=5>在 {{site.data.keyword.Bluemix_notm}} 上用來建立叢集的指令</th>
 </thead>
 <tbody>
  <tr>
    <td>[bx cs albs](#cs_albs)</td>
    <td>[bx cs alb-configure](#cs_alb_configure)</td>
    <td>[bx cs alb-get](#cs_alb_get)</td>
    <td>[bx cs alb-types](#cs_alb_types)</td>
    <td>[bx cs cluster-config](#cs_cluster_config)</td>
  </tr>
 <tr>
    <td>[bx cs cluster-create](#cs_cluster_create)</td>
    <td>[bx cs cluster-get](#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[bx cs cluster-service-unbind](#cs_cluster_service_unbind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-services](#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[bx cs cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[bx cs cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[bx cs cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-update](#cs_cluster_update)</td>
    <td>[bx cs clusters](#cs_clusters)</td>
    <td>[bx cs credentials-set](#cs_credentials_set)</td>
    <td>[bx cs credentials-unset](#cs_credentials_unset)</td>
    <td>[bx cs help](#cs_help)</td>
 </tr>
 <tr>
    <td>[bx cs init](#cs_init)</td>
    <td>[bx cs kube-versions](#cs_kube_versions)</td>
    <td>[bx cs locations](#cs_datacenters)</td>
    <td>[bx cs logging-config-create](#cs_logging_create)</td>
    <td>[bx cs logging-config-get](#cs_logging_get)</td>
 </tr>
 <tr>
    <td>[bx cs logging-config-rm](#cs_logging_rm)</td>
    <td>[bx cs logging-config-update](#cs_logging_update)</td>
    <td>[bx cs machine-types](#cs_machine_types)</td>
    <td>[bx cs subnets](#cs_subnets)</td>
    <td>[bx cs vlans](#cs_vlans)</td>
 </tr>
 <tr>
    <td>[bx cs webhook-create](#cs_webhook_create)</td>
    <td>[bx cs worker-add](#cs_worker_add)</td>
    <td>[bx cs worker-get](#cs_worker_get)</td>
    <td>[bx cs worker-rm](#cs_worker_rm)</td>
    <td>[bx cs worker-update](#cs_worker_update)</td>
 </tr>
 <tr>
    <td>[bx cs worker-reboot](#cs_worker_reboot)</td>
    <td>[bx cs worker-reload](#cs_worker_reload)</td>
    <td>[bx cs workers](#cs_workers)</td>
 </tr>
 </tbody>
 </table>

**提示：**若要查看 {{site.data.keyword.containershort_notm}} 外掛程式的版本，請執行下列指令。

```
bx plugin list
```
{: pre}

## bx cs 指令
{: #cs_commands}


### bx cs albs --cluster CLUSTER
{: #cs_albs}

檢視叢集中所有應用程式負載平衡器 (ALB) 的狀態。ALB 也稱為 Ingress 控制器。如果未傳回任何 ALB ID，則叢集沒有可攜式子網路。您可以[建立](#cs_cluster_subnet_create)或[新增](#cs_cluster_subnet_add)子網路至叢集。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>列出其中可用應用程式負載平衡器的叢集的名稱或 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs albs --cluster mycluster
  ```
  {: pre}

### bx cs alb-configure --albID ALB_ID [--enable][--disable][--user-ip USERIP]
{: #cs_alb_configure}

在標準叢集中啟用或停用應用程式負載平衡器 (ALB)，也稱為 Ingress 控制器。依預設，會啟用公用應用程式負載平衡器。

**指令選項**：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的 ID。執行 <code>bx cs albs <em>--cluster </em>CLUSTER</code>，以檢視叢集中 ALB 的 ID。這是必要值。</dd>

   <dt><code>--enable</code></dt>
   <dd>包括此旗標，以在叢集中啟用 ALB。</dd>

   <dt><code>--disable</code></dt>
   <dd>包括此旗標，以在叢集中停用 ALB。</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>僅專用 ALB 才能使用此參數</li>
    <li>專用 ALB 是使用來自使用者提供之專用子網路的 IP 位址進行部署。如果未提供 IP 位址，則會使用來自 IBM Cloud 基礎架構 (SoftLayer) 中專用子網路的隨機 IP 位址來部署 ALB。</li>
   </ul>
   </dd>
   </dl>

**範例**：

  啟用 ALB 的範例：

  ```
  bx cs alb-configure --albID my_alb_id --enable
  ```
  {: pre}

  停用 ALB 的範例：

  ```
  bx cs alb-configure --albID my_alb_id --disable
  ```
  {: pre}

  以使用者提供的 IP 位址來啟用 ALB 的範例：

  ```
  bx cs alb-configure --albID my_private_alb_id --enable --user-ip user_ip
  ```
  {: pre}

### bx cs alb-get --albID ALB_ID
{: #cs_alb_get}

檢視應用程式負載平衡器 (ALB) 的詳細資料。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB 的 ID。執行 <code>bx cs albs --cluster <em>CLUSTER</em></code>，以檢視叢集中 ALB 的 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs alb-get --albID ALB_ID
  ```
  {: pre}

### bx cs alb-types
{: #cs_alb_types}

檢視區域中支援的應用程式負載平衡器類型。

<strong>指令選項</strong>：

   無

**範例**：

  ```
  bx cs alb-types
  ```
  {: pre}

### bx cs cluster-config CLUSTER [--admin][--export]
{: #cs_cluster_config}

登入之後，請下載 Kubernetes 配置資料及憑證來連接至叢集，以及執行 `kubectl` 指令。檔案會下載至 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`。

**指令選項**：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--admin</code></dt>
   <dd>下載「超級使用者」角色的 TLS 憑證及許可權檔案。您可以使用憑證，在叢集中自動執行作業，而無需重新鑑別。檔案會下載至 `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`。這是選用值。</dd>

   <dt><code>--export</code></dt>
   <dd>下載 Kubernets 配置資料及憑證，但不包含 export 指令以外的任何訊息。因為沒有顯示任何訊息，所以可以在建立自動化 Script 時使用此旗標。這是選用值。</dd>
   </dl>

**範例**：

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER]
{: #cs_cluster_create}

在組織中建立叢集。

<strong>指令選項</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>建立標準叢集之 YAML 檔案的路徑。您可以使用 YAML 檔案，而不是使用此指令中所提供的選項來定義叢集的特徵。

此值對於標準叢集是選用的，不適用於精簡叢集。

<p><strong>附註：</strong>如果您在指令中提供與 YAML 檔案中的參數相同的選項，則指令中的值優先順序會高於 YAML 中的值。例如，您在 YAML 檔案中定義了位置，並在指令中使用 <code>--location</code> 選項，則您在指令選項中輸入的值會置換 YAML 檔案中的值。<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
</code></pre>


<table>
    <caption>表 1. 瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>將 <code><em>&lt;cluster_name&gt;</em></code> 取代為叢集的名稱。</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>將 <code><em>&lt;location&gt;</em></code> 取代為您要建立叢集的位置。可用的位置取決於您所登入的地區。若要列出可用的位置，請執行 <code>bx cs locations</code>。</td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>依預設，公用及專用可攜式子網路都是建立在與叢集相關聯的 VLAN 上。將 <code><em>&lt;no-subnet&gt;</em></code> 取代為 <code><em>true</em></code>，以避免建立具有叢集的子網路。稍後，您可以[建立](#cs_cluster_subnet_create)或[新增](#cs_cluster_subnet_add)子網路至叢集。</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>將 <code><em>&lt;machine_type&gt;</em></code> 取代為您要用於工作者節點的機型。若要列出位置的可用機型，請執行 <code>bx cs machine-types <em>&lt;location&gt;</em></code>。</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>將 <code><em>&lt;private_vlan&gt;</em></code> 取代為您要用於工作者節點的專用 VLAN ID。若要列出可用的 VLAN，請執行 <code>bx cs vlans <em>&lt;location&gt;</em></code>，並尋找開頭為 <code>bcr</code>（後端路由器）的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>將 <code><em>&lt;public_vlan&gt;</em></code> 取代為您要用於工作者節點的公用 VLAN ID。若要列出可用的 VLAN，請執行 <code>bx cs vlans <em>&lt;location&gt;</em></code>，並尋找開頭為 <code>fcr</code>（前端路由器）的 VLAN 路由器。</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 <code>shared</code>。</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>將 <code><em>&lt;number_workers&gt;</em></code> 取代為您要部署的工作者節點數目。</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>叢集主節點的 Kubernetes 版本。這是選用值。除非另有指定，否則會使用支援的 Kubernetes 版本的預設值來建立叢集。若要查看可用的版本，請執行 <code>bx cs kube-versions</code>。</td>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作者節點的硬體隔離層次。若要讓可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。此值對於標準叢集是選用的，不適用於精簡叢集。</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>您要建立叢集的位置。可用的位置取決於您所登入的 {{site.data.keyword.Bluemix_notm}} 地區。選取實際上與您最接近的地區以獲得最佳效能。此值對於標準叢集是必要的，對於精簡叢集則是選用性。

<p>檢閱[可用位置](cs_regions.html#locations)。</p>

<p><strong>附註：</strong>若您選取的位置不在您的國家/地區境內，請謹記，您可能需要合法授權，才能實際將資料儲存在國外。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>您選擇的機型會影響工作者節點中所部署的容器可使用的記憶體及磁碟空間量。若要列出可用的機型，請參閱 [bx cs machine-types <em>LOCATION</em>](#cs_machine_types)。此值對於標準叢集是必要的，不適用於精簡叢集。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>叢集的名稱。這是必要值。</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>叢集主節點的 Kubernetes 版本。這是選用值。除非另有指定，否則會使用支援的 Kubernetes 版本的預設值來建立叢集。若要查看可用的版本，請執行 <code>bx cs kube-versions</code>。</dd>

<dt><code>--no-subnet</code></dt>
<dd>依預設，公用及專用可攜式子網路都是建立在與叢集相關聯的 VLAN 上。請包括 <code>--no-subnet</code> 旗標，以避免建立具有叢集的子網路。稍後，您可以[建立](#cs_cluster_subnet_create)或[新增](#cs_cluster_subnet_add)子網路至叢集。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>此參數不適用於精簡叢集。</li>
<li>如果此標準叢集是您在這個位置所建立的第一個標準叢集，請不要包括此旗標。建立叢集時，會自動建立一個專用 VLAN。</li>
<li>如果您之前已在此位置中建立標準叢集，或之前已在 IBM Cloud 基礎架構 (SoftLayer) 中建立專用 VLAN，則必須指定該專用 VLAN。

<p><strong>附註：</strong>您使用 create 指令所指定的公用及專用 VLAN 必須相符。專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。請不要使用不相符的公用及專用 VLAN 來建立叢集。</p></li>
</ul>

<p>若要找出您是否已有特定位置的專用 VLAN，或尋找現有專用 VLAN 的名稱，請執行 <code>bx cs vlans <em>&lt;location&gt;</em></code>。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>此參數不適用於精簡叢集。</li>
<li>如果此標準叢集是您在這個位置所建立的第一個標準叢集，請不要使用此旗標。建立叢集時，會自動建立一個公用 VLAN。</li>
<li>如果您之前已在此位置中建立標準叢集，或之前已在 IBM Cloud 基礎架構 (SoftLayer) 中建立公用 VLAN，則必須指定該公用 VLAN。

<p><strong>附註：</strong>您使用 create 指令所指定的公用及專用 VLAN 必須相符。專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。請不要使用不相符的公用及專用 VLAN 來建立叢集。</p></li>
</ul>

<p>若要找出您是否已有特定位置的公用 VLAN，或尋找現有公用 VLAN 的名稱，請執行 <code>bx cs vlans <em>&lt;location&gt;</em></code>。</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>您要在叢集中部署的工作者節點數目。如果您未指定此選項，則會建立具有 1 個工作者節點的叢集。此值對於標準叢集是選用的，不適用於精簡叢集。

<p><strong>附註：</strong>每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，在叢集建立之後即不得手動予以變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。</p></dd>
</dl>

**範例**：

  

  標準叢集的範例：
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  精簡叢集的範例：

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  「{{site.data.keyword.Bluemix_dedicated_notm}}」環境的範例：

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

檢視組織中叢集的相關資訊。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>顯示叢集的 VLAN 及子網路。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

從組織中移除叢集。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制移除叢集，而不出現任何使用者提示。這是選用值。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集。

**提示：**若為「{{site.data.keyword.Bluemix_dedicated_notm}}」使用者，請參閱[在 {{site.data.keyword.Bluemix_dedicated_notm}}中將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集（封閉測試版）](cs_cluster.html#binding_dedicated)。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名稱空間的名稱。這是必要值。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>您要連結的 {{site.data.keyword.Bluemix_notm}} 服務實例的 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

從叢集中移除 {{site.data.keyword.Bluemix_notm}} 服務。

**附註：**移除 {{site.data.keyword.Bluemix_notm}} 服務時，會從叢集中移除服務認證。如果 pod 仍在使用服務，會因為找不到服務認證而失敗。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名稱空間的名稱。這是必要值。</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>您要移除的 {{site.data.keyword.Bluemix_notm}} 服務實例的 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

列出連結至叢集中一個或所有 Kubernetes 名稱空間的服務。如果未指定任何選項，則會顯示 default 名稱空間的服務。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>包括連結至叢集中特定名稱空間的服務。這是選用值。</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>包括連結至叢集中所有名稱空間的服務。這是選用值。</dd>
    </dl>

**範例**：

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

將 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的子網路設為可供指定的叢集使用。

**附註：**當您讓叢集可以使用子網路時，會使用這個子網路的 IP 位址來進行叢集網路連線。若要避免 IP 位址衝突，請確定您使用的子網路只有一個叢集。請不要同時將子網路用於多個叢集或 {{site.data.keyword.containershort_notm}} 以外的其他用途。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>子網路的 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs cluster-subnet-create CLUSTER SIZE VLAN_ID
{: #cs_cluster_subnet_create}

在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中建立子網路，並將它設為可供 {{site.data.keyword.containershort_notm}} 中指定的叢集使用。

**附註：**當您讓叢集可以使用子網路時，會使用這個子網路的 IP 位址來進行叢集網路連線。若要避免 IP 位址衝突，請確定您使用的子網路只有一個叢集。請不要同時將子網路用於多個叢集或 {{site.data.keyword.containershort_notm}} 以外的其他用途。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。若要列出叢集，請使用 `bx cs clusters` [指令](#cs_clusters)。</dd>

   <dt><code><em>SIZE</em></code></dt>
   <dd>子網路 IP 位址的數目。這是必要值。可能的值為 8、16、32 或 64。</dd>

   <dt><code><em>VLAN_ID</em></code></dt>
   <dd>要在其中建立子網路的 VLAN。這是必要值。如果要列出可用的 VLAN，請使用 `bx cs vlans<location>` [指令](#cs_vlans)。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-subnet-create my_cluster 8 1764905
  ```
  {: pre}

### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

將您自己的專用子網路帶到 {{site.data.keyword.containershort_notm}} 叢集。

這個專用子網路不是 IBM Cloud 基礎架構 (SoftLayer) 所提供的專用子網路。因此，您必須配置子網路的任何入埠及出埠網路資料流量遞送。若要新增 IBM Cloud 基礎架構 (SoftLayer) 子網路，請使用 `bx cs cluster-subnet-add` [指令](#cs_cluster_subnet_add)。

**附註**：當您將專用使用者子網路新增至叢集時，這個子網路的 IP 位址會用於叢集中的專用「負載平衡器」。若要避免 IP 位址衝突，請確定您使用的子網路只有一個叢集。請不要同時將子網路用於多個叢集或 {{site.data.keyword.containershort_notm}} 以外的其他用途。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>子網路無類別跨網域遞送 (CIDR)。這是必要值，且不得與 IBM Cloud 基礎架構 (SoftLayer) 所使用的任何子網路衝突。

   支援的字首範圍從 `/30`（1 個 IP 位址）一直到 `/24`（253 個 IP 位址）。如果您將 CIDR 設在一個字首長度，之後又需要變更它，則請先新增新的 CIDR，然後[移除舊的 CIDR](#cs_cluster_user_subnet_rm)。</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>專用 VLAN 的 ID。這是必要值。它必須符合叢集中一個以上工作者節點的專用 VLAN ID。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

從指定的叢集移除您自己的專用子網路。

**附註：**從您自己的專用子網路部署至 IP 位址的任何服務，都會在移除子網路之後保持作用中。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>子網路無類別跨網域遞送 (CIDR)。這是必要值，且必須符合 `bx cs cluster-user-subnet-add` [指令](#cs_cluster_user_subnet_add)設定的 CIDR。</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>專用 VLAN 的 ID。這是必要值，且必須符合 `bx cs cluster-user-subnet-add` [指令](#cs_cluster_user_subnet_add)設定的 VLAN ID。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update]
{: #cs_cluster_update}

將 Kubernetes 主節點更新為預設 API 版本。在更新期間，您無法存取或變更叢集。已由使用者部署的工作者節點、應用程式及資源不會修改，並將繼續執行。

您可能需要變更 YAML 檔案以進行未來的部署。如需詳細資料，請檢閱此[版本注意事項](cs_versions.html)。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   
   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>叢集的 Kubernedes 版本。如果未指定此旗標，則 Kubernetes 主節點會更新為預設 API 版本。若要查看可用的版本，請執行 [bx cs kube-versions](#cs_kube_versions)。這是選用值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制更新主節點，而不出現任何使用者提示。這是選用值。</dd>
   
   <dt><code>--force-update</code></dt>
   <dd>即使變更大於兩個次要版本，也要嘗試更新。這是選用值。</dd>
   </dl>

**範例**：

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

檢視組織中的叢集清單。

<strong>指令選項</strong>：

  無

**範例**：

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

針對 {{site.data.keyword.Bluemix_notm}} 帳戶設定 IBM Cloud 基礎架構 (SoftLayer) 帳戶認證。這些認證可讓您透過 {{site.data.keyword.Bluemix_notm}} 帳戶存取 IBM Cloud 基礎架構 (SoftLayer) 組合。

**附註：**請勿為一個 {{site.data.keyword.Bluemix_notm}} 帳戶設定多個認證。每個 {{site.data.keyword.Bluemix_notm}} 帳戶僅會鏈結至一個 IBM Cloud 基礎架構 (SoftLayer) 組合。

<strong>指令選項</strong>：

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud 基礎架構 (SoftLayer) 帳戶使用者名稱。這是必要值。</dd>
   

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud 基礎架構 (SoftLayer) 帳戶 API 金鑰。這是必要值。

 <p>
  若要產生 API 金鑰，請執行下列動作：

  <ol>
  <li>登入 [IBM Cloud 基礎架構 (SoftLayer) 入口網站 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://control.softlayer.com/)。</li>
  <li>選取<strong>帳戶</strong>，然後選取<strong>使用者</strong>。</li>
  <li>按一下<strong>產生</strong>，以產生帳戶的 IBM Cloud 基礎架構 (SoftLayer) API 金鑰。</li>
  <li>複製 API 金鑰以便在這個指令中使用。</li>
  </ol>

  若要檢視現有的 API 金鑰，請執行下列動作：
  <ol>
  <li>登入 [IBM Cloud 基礎架構 (SoftLayer) 入口網站 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://control.softlayer.com/)。</li>
  <li>選取<strong>帳戶</strong>，然後選取<strong>使用者</strong>。</li>
  <li>按一下<strong>檢視</strong>，以查看現有的 API 金鑰。</li>
  <li>複製 API 金鑰以便在這個指令中使用。</li>
  </ol>
  </p></dd>
  </dl>

**範例**：

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

從您的 {{site.data.keyword.Bluemix_notm}} 帳戶中移除 IBM Cloud 基礎架構 (SoftLayer) 帳戶認證。移除認證之後，就無法再透過 {{site.data.keyword.Bluemix_notm}} 帳戶存取 IBM Cloud 基礎架構 (SoftLayer) 組合。

<strong>指令選項</strong>：

   無

**範例**：

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

檢視所支援指令及參數的清單。

<strong>指令選項</strong>：

   無

**範例**：

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

起始設定 {{site.data.keyword.containershort_notm}} 外掛程式，或指定您要建立或存取 Kubernetes 叢集的地區。

<strong>指令選項</strong>：

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>您要使用的 {{site.data.keyword.containershort_notm}} API 端點。這是選用值。範例：

    <ul>
    <li>美國南部：

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>美國東部：

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>附註</strong>：美國東部只能與 CLI 指令搭配使用。</p></li>

    <li>英國南部：

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>歐盟中部：

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>亞太地區南部：

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>



### bx cs kube-versions
{: #cs_kube_versions}

檢視 {{site.data.keyword.containershort_notm}} 中支援的 Kubernetes 版本清單。將您的[主要叢集](#cs_cluster_update)及[工作者節點](#cs_worker_update)更新為最新且功能穩定的預設版本。

**指令選項**：

  無

**範例**：

  ```
  bx cs kube-versions
  ```
  {: pre}

### bx cs locations
{: #cs_datacenters}

檢視可讓您在其中建立叢集的可用位置清單。

<strong>指令選項</strong>：

   無

**範例**：

  ```
  bx cs locations
  ```
  {: pre}

### bx cs logging-config-create CLUSTER --logsource LOG_SOURCE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME] [--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_create}

建立記載配置。依預設，名稱空間日誌會轉遞至 {{site.data.keyword.loganalysislong_notm}}。您可以使用這個指令，將名稱空間日誌轉遞至外部 syslog 伺服器。您也可以使用這個指令，將應用程式、工作者節點、Kubernetes 叢集及 Ingress 控制器的日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}} 或外部 syslog 伺服器。

<strong>指令選項</strong>：

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>叢集的名稱或 ID。</dd>
<dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
<dd>要為其啟用日誌轉遞的日誌來源。接受的值為 <code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。這是必要值。</dd>
<dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
<dd>您想要將日誌從該處轉遞至 syslog 的 Docker 容器名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。這對於名稱空間是必要值。如果未指定名稱空間，則容器中的所有名稱空間都會使用此配置。</dd>
<dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
<dd>日誌收集器伺服器的主機名稱或 IP 位址。當記載類型是 <code>syslog</code> 時，這是必要值。</dd>
<dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
<dd>日誌收集器伺服器的埠。當記載類型是 <code>syslog</code> 時，這是選用值。如果您未指定埠，則會將標準埠 <code>514</code> 用於 <code>syslog</code>。</dd>
<dt><code>--type <em>LOG_TYPE</em></code></dt>
<dd>您要使用的日誌轉遞通訊協定。目前支援 <code>syslog</code> 和 <code>ibm</code>。這是必要值。</dd>
</dl>

**範例**：

日誌來源 `namespace` 的範例：

  ```
  bx cs logging-config-create my_cluster --logsource namespaces --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}

日誌來源 `ingress` 的範例：

  ```
  bx cs logging-config-create my_cluster --logsource ingress --type ibm
  ```
  {: pre}

### bx cs logging-config-get CLUSTER [--logsource LOG_SOURCE]
{: #cs_logging_get}

檢視叢集的所有日誌轉遞配置，或根據日誌來源來過濾記載配置。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>您要過濾的日誌來源種類。只會傳回叢集中這個日誌來源的記載配置。接受的值為 <code>namespaces</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。這是選用值。</dd>
   </dl>

**範例**：

  ```
  bx cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER --id LOG_CONFIG_ID
{: #cs_logging_rm}

刪除日誌轉遞配置。若為 Docker 容器名稱空間，您可以停止將日誌轉遞至 syslog 伺服器。名稱空間會繼續將日誌轉遞至 {{site.data.keyword.loganalysislong_notm}}。若為 Docker 容器名稱空間以外的日誌來源，您可以停止將日誌轉遞至 syslog 伺服器或 {{site.data.keyword.loganalysisshort_notm}}。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>您要從日誌來源移除的記載配置 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs logging-config-rm my_cluster --id my_log_config_id
  ```
  {: pre}


### bx cs logging-config-update CLUSTER [--namespace NAMESPACE][--id LOG_CONFIG_ID] [--hostname LOG_SERVER_HOSTNAME][--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_update}

更新對您要使用之記載伺服器的日誌轉遞。若為 Docker 容器名稱空間，您可以使用這個指令來更新現行 syslog 伺服器的詳細資料，或變更為不同的 syslog 伺服器。若為非 Docker 容器名稱空間的記載來源，您可以使用這個指令來變更日誌收集器伺服器類型。目前支援的日誌類型有 'syslog' 和 'ibm'。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>
   <dt><code>--namespace <em>NAMESPACE</em></code></dt>
   <dd>您想要將日誌從該處轉遞至 syslog 的 Docker 容器名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。這對於名稱空間是必要值。</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>您要更新的記載配置 ID。如果日誌來源不是 Docker 容器名稱空間，則這是必要值。</dd>
   <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>日誌收集器伺服器的主機名稱或 IP 位址。當記載類型是 <code>syslog</code> 時，這是必要值。</dd>
   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>日誌收集器伺服器的埠。當記載類型是 <code>syslog</code> 時，這是選用值。如果您未指定埠，則會將標準埠 514 用於 <code>syslog</code>。</dd>
   <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>您要使用的日誌轉遞通訊協定。目前支援 <code>syslog</code> 和 <code>ibm</code>。這是必要值。</dd>
   </dl>

**日誌類型 `ibm`** 的範例：

  ```
  bx cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**日誌類型 `syslog`** 的範例：

  ```
  bx cs logging-config-update my_cluster --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### bx cs machine-types LOCATION
{: #cs_machine_types}

檢視工作者節點的可用機型清單。每一個機型都包括叢集中每一個工作者節點的虛擬 CPU、記憶體及磁碟空間量。 
- 名稱中具有 `u2c` 或 `b2c` 的機型會使用本端磁碟，而非儲存區網路 (SAN) 來取得可靠性。可靠性優點包括將位元組序列化到本端磁碟時的更高傳輸量，以及減少檔案系統由於網路故障而造成的退化。這些機型包含 25GB 本端磁碟儲存空間，供 OS 檔案系統使用，以及包含 100GB 本端磁碟儲存空間，供 `/var/lib/docker` 使用，而所有容器資料都會寫入至這個目錄中。 
- 名稱中包括 `encrypted` 的機型會加密主機的 Docker 資料。儲存所有容器資料的 `/var/lib/docker` 目錄是使用 LUKS 加密來進行加密。
- 名稱中具有 `u1c` 或 `b1c` 的機型已被淘汰，例如 `u1c.2x4`。若要開始使用 `u2c` 及 `b2c` 機型，請使用 `bx cs worker-add` 指令，利用更新的機型新增工作者節點。然後，使用 `bx cs worker-rm` 指令，移除正在使用已淘汰機型的工作者節點。
</p>


<strong>指令選項</strong>：

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>輸入您要列出可用機型的位置。這是必要值。檢閱[可用位置](cs_regions.html#locations)。</dd></dl>

**範例**：

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

檢視 IBM Cloud 基礎架構 (SoftLayer) 帳戶中可用的子網路清單。

<strong>指令選項</strong>：

   無

**範例**：

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

列出 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的位置可用的公用及專用 VLAN。若要列出可用的 VLAN，您必須具有付費帳戶。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>輸入您要列出專用及公用 VLAN 的位置。這是必要值。檢閱[可用位置](cs_regions.html#locations)。</dd>
   </dl>

**範例**：

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

建立 Webhook。

<strong>指令選項</strong>：

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>通知層次（例如 <code>Normal</code> 或 <code>Warning</code>）。<code>Warning</code> 是預設值。這是選用值。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Webhook 類型（例如 slack）。僅支援 slack。這是必要值。</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>Webhook 的 URL。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

將工作者節點新增至標準叢集。

<strong>指令選項</strong>：

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>叢集的名稱或 ID。這是必要值。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>將工作者節點新增至叢集之 YAML 檔案的路徑。您可以使用 YAML 檔案，而不是使用此指令中所提供的選項來定義其他工作者節點。這是選用值。

<p><strong>附註：</strong>如果您在指令中提供與 YAML 檔案中的參數相同的選項，則指令中的值優先順序會高於 YAML 中的值。例如，您在 YAML 檔案中定義了機型，並在指令中使用 --machine-type 選項，則您在指令選項中輸入的值會置換 YAML 檔案中的值。

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>

<table>
<caption>表 2. 瞭解 YAML 檔案元件</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>將 <code><em>&lt;cluster_name_or_id&gt;</em></code> 取代為您要新增工作者節點之叢集的名稱或 ID。</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>將 <code><em>&lt;location&gt;</em></code> 取代為您要部署工作者節點的位置。可用的位置取決於您所登入的地區。若要列出可用的位置，請執行 <code>bx cs locations</code>。</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>將 <code><em>&lt;machine_type&gt;</em></code> 取代為您要用於工作者節點的機型。若要列出位置的可用機型，請執行 <code>bx cs machine-types <em>&lt;location&gt;</em></code>。</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>將 <code><em>&lt;private_vlan&gt;</em></code> 取代為您要用於工作者節點的專用 VLAN ID。若要列出可用的 VLAN，請執行 <code>bx cs vlans <em>&lt;location&gt;</em></code>，並尋找開頭為 <code>bcr</code>（後端路由器）的 VLAN 路由器。</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>將 <code>&lt;public_vlan&gt;</code> 取代為您要用於工作者節點的公用 VLAN ID。若要列出可用的 VLAN，請執行 <code>bx cs vlans &lt;location&gt;</code>，並尋找開頭為 <code>fcr</code>（前端路由器）的 VLAN 路由器。</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>將 <code><em>&lt;number_workers&gt;</em></code> 取代為您要部署的工作者節點數目。</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>工作者節點的硬體隔離層次。如果您希望可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。這是選用值。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>您選擇的機型會影響工作者節點中所部署的容器可使用的記憶體及磁碟空間量。這是必要值。若要列出可用的機型，請參閱 [bx cs machine-types LOCATION](#cs_machine_types)。</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>整數，代表要在叢集中建立的工作者節點數目。預設值為 1。這是選用值。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>建立叢集時所指定的專用 VLAN。這是必要值。

<p><strong>附註：</strong>您指定的公用及專用 VLAN 必須相符。專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。請不要使用不相符的公用及專用 VLAN 來建立叢集。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>建立叢集時所指定的公用 VLAN。這是選用值。

<p><strong>附註：</strong>您指定的公用及專用 VLAN 必須相符。專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。請不要使用不相符的公用及專用 VLAN 來建立叢集。</p></dd>
</dl>

**範例**：

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --hardware shared
  ```
  {: pre}

  「{{site.data.keyword.Bluemix_dedicated_notm}}」的範例：

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u2c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

檢視工作者節點的詳細資料。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>工作者節點的 ID。執行 <code>bx cs workers <em>CLUSTER</em></code>，以檢視叢集中工作者節點的 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

將叢集中的工作者節點重新開機。如果工作者節點發生問題，請先嘗試將工作者節點重新開機，這樣會重新啟動工作者節點。如果重新開機無法解決問題，則請嘗試 `worker-reload` 指令。在重新開機期間，工作者節點的狀態不會變更。狀態會保持為 `deployed`，但狀態會更新。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制重新啟動工作者節點，而不出現任何使用者提示。這是選用值。</dd>

   <dt><code>--hard</code></dt>
   <dd>使用此選項，透過切斷工作者節點的電源來強制執行強迫重新啟動工作者節點。如果工作者節點無回應，或工作者節點的 Docker 當掉，請使用此選項。這是選用值。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的名稱或 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

重新載入叢集中的工作者節點。如果工作者節點發生問題，請先嘗試將工作者節點重新開機。如果重新開機無法解決問題，則請嘗試 `worker-reload` 指令，它會重新載入工作者節點的所有必要配置。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制重新載入工作者節點，而不出現任何使用者提示。這是選用值。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的名稱或 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

從叢集中移除一個以上的工作者節點。

<strong>指令選項</strong>：

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>叢集的名稱或 ID。這是必要值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制移除工作者節點，而不出現任何使用者提示。這是選用值。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的名稱或 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update]
{: #cs_worker_update}

將工作者節點更新為最新的 Kubernetes 版本。執行 `bx cs worker-update` 可能會導致應用程式及服務的關閉時間。在更新期間，所有 Pod 會重新排定到其他工作者節點，且資料若未儲存在 Pod 之外便會刪除。若要避免關閉時間，請確定您有足夠的工作者節點，可以處理所選取工作者節點在更新時的工作負載。

您可能需要變更 YAML 檔案以進行部署，然後才更新。如需詳細資料，請檢閱此[版本注意事項](cs_versions.html)。

<strong>指令選項</strong>：

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>列出可用工作者節點的叢集的名稱或 ID。這是必要值。</dd>
   
   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>叢集的 Kubernedes 版本。如果未指定此旗標，則工作者節點會更新為預設版本。若要查看可用的版本，請執行 [bx cs kube-versions](#cs_kube_versions)。這是選用值。</dd>

   <dt><code>-f</code></dt>
   <dd>使用此選項，以強制更新主節點，而不出現任何使用者提示。這是選用值。</dd>
   
   <dt><code>--force-update</code></dt>
   <dd>即使變更大於兩個次要版本，也要嘗試更新。這是選用值。</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>一個以上工作者節點的 ID。請使用空格來列出多個工作者節點。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

檢視工作者節點清單以及叢集中各工作者節點的狀態。

<strong>指令選項</strong>：

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>列出可用工作者節點的叢集的名稱或 ID。這是必要值。</dd>
   </dl>

**範例**：

  ```
  bx cs workers mycluster
  ```
  {: pre}
