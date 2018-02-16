---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 設定叢集
{: #clusters}

設計最大可用性及容量的叢集設定。
{:shortdesc}


## 叢集配置規劃
{: #planning_clusters}

使用標準叢集，以增加應用程式可用性。當您將設定分佈到多個工作者節點及叢集時，使用者遇到應用程式關閉的可能性越低。內建功能（例如負載平衡及隔離）可提高對於潛在主機、網路或應用程式失敗的備援。
{:shortdesc}

檢閱這些可能的叢集設定，它們依遞增的可用性程度進行排序：

![叢集高可用性階段](images/cs_cluster_ha_roadmap.png)

1.  一個具有多個工作者節點的叢集
2.  在相同地區的不同位置執行的兩個叢集，各具有多個工作者節點
3.  在不同地區執行的兩個叢集，各具有多個工作者節點

使用下列技術來提高叢集的可用性：

<dl>
<dt>將應用程式分散到工作者節點</dt>
<dd>容許開發人員針對每個叢集將其在容器中的應用程式分散到多個工作者節點。這三個工作者節點中每一個的應用程式實例都容許關閉一個工作者節點，而不會岔斷應用程式的使用。您可以指定從 [{{site.data.keyword.Bluemix_notm}} GUI](cs_clusters.html#clusters_ui) 或 [CLI](cs_clusters.html#clusters_cli) 建立叢集時要包含多少個工作者節點。Kubernetes 會限制您在叢集中可以具有的工作者節點數目上限，因此，請記住[工作者節點及 Pod 配額 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/cluster-large/)。
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>將應用程式分散到叢集</dt>
<dd>建立多個叢集，各具有多個工作者節點。如果其中一個叢集的運作中斷，使用者仍然可以存取同時部署在另一個叢集中的應用程式。<p>叢集 1：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>叢集 2：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>將應用程式分散到不同地區中的叢集</dt>
<dd>當您將應用程式分散到不同地區中的叢集時，可以容許根據使用者所在地區來進行負載平衡。如果一個地區的叢集、硬體，甚至整個位置關閉，資料流量會遞送至部署在另一個位置的容器。<p><strong>重要事項：</strong>配置自訂網域之後，即可使用這些指令來建立叢集。</p>
<p>位置 1：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>位置 2：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## 工作者節點配置規劃
{: #planning_worker_nodes}

Kubernetes 叢集包含工作者節點，並且由 Kubernetes 主節點集中進行監視及管理。叢集管理者可以決定如何設定工作者節點的叢集，以確保叢集使用者具有部署及執行叢集中應用程式的所有資源。
{:shortdesc}

當您建立標準叢集時，會代表您在 IBM Cloud 基礎架構 (SoftLayer) 中訂購以及在 {{site.data.keyword.Bluemix_notm}} 中設定工作者節點。每個工作者節點都會獲指派建立叢集之後即不得變更的唯一工作者節點 ID 及網域名稱。視您選擇的硬體隔離層次而定，工作者節點可以設定為共用或專用節點。每個工作者節點都會佈建特定機型，而此機型可決定部署至工作者節點的容器可用的 vCPU 數目、記憶體及磁碟空間。Kubernetes 會限制您在叢集中可以有的工作者節點數目上限。如需相關資訊，請檢閱[工作者節點及 Pod 配額 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/cluster-large/)。


### 工作者節點的硬體
{: #shared_dedicated_node}

每個工作者節點都會設定為實體硬體上的虛擬機器。當您在 {{site.data.keyword.Bluemix_notm}} 中建立標準叢集時，必須選擇是要由多個 {{site.data.keyword.IBM_notm}} 客戶共用基礎硬體（多方承租戶）還是基礎硬體只供您專用（單一承租戶）。
{:shortdesc}

在多方承租戶設定中，會在所有部署至相同實體硬體的虛擬機器之間共用實體資源（例如 CPU 及記憶體）。為了確保每個虛擬機器都可以獨立執行，虛擬機器監視器（也稱為 Hypervisor）會將實體資源分段為隔離實體，並將它們當成專用資源配置至虛擬機器（Hypervisor 隔離）。

在單一承租戶設定中，所有實體資源都只供您專用。您可以將多個工作者節點部署為相同實體主機上的虛擬機器。與多方承租戶設定類似，Hypervisor 確保每個工作者節點都可以共用可用的實體資源。

因為基礎硬體的成本是由多個客戶分攤，所以共用節點通常會比專用節點便宜。不過，當您決定共用或專用節點時，可能會想要與法務部門討論應用程式環境所需的基礎架構隔離層次及相符性。

當您建立精簡叢集時，工作者節點會自動佈建為 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的共用節點。

### 工作者節點記憶體限制
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} 會在每一個工作者節點上設定記憶體限制。當工作者節點上執行的 Pod 超出此記憶體限制時，就會移除這些 Pod。在 Kubernetes 中，此限制稱為[強制收回臨界值 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds)。
{:shortdesc}

如果經常移除 Pod，請將更多的工作者節點新增至叢集，或在 Pod 上設定[資源限制 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container)。

每一種機型都有不同的記憶體容量。如果工作者節點上可用的記憶體少於容許的最低臨界值，Kubernetes 會立即移除 Pod。如果有工作者節點可供使用，則 Pod 會重新排定至另一個工作者節點。

|工作者節點記憶體容量|工作者節點的最低記憶體臨界值|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB| 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

若要檢閱工作者節點上使用的記憶體數量，請執行 [kubectltop node ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top)。



<br />



## 使用 GUI 建立叢集
{: #clusters_ui}

Kubernetes 叢集是組織成網路的一組工作者節點。叢集的用途是要定義一組資源、節點、網路及儲存裝置，以讓應用程式保持高度可用。您必須先建立叢集並設定該叢集中工作者節點的定義，才能部署應用程式。
{:shortdesc}

若要建立叢集，請執行下列動作：
1. 在型錄中，選取 **Kubernetes 叢集**。
2. 選取叢集方案的類型。您可以選擇**精簡**或**隨收隨付制**。使用「隨收隨付制」方案，您可以針對高可用性環境，佈建一個具有例如多工作者節點之特性的標準叢集。
3. 配置叢集詳細資料。
    1. 為叢集命名、選擇 Kubernetes 的版本，以及選取要在其中部署的位置。選取實際上與您最接近的位置以獲得最佳效能。當您選取所在國家/地區以外的位置時，請謹記，您可能需要有合法授權，才能將資料實際儲存在其他國家/地區。
    2. 選取機器類型並指定您需要的工作者節點數目。機型會定義設定於每一個工作者節點中，且可供容器使用的虛擬 CPU 及記憶體數量。
        - 微機型指出最小選項。
        - 平衡機器具有指派給每一個 CPU 的相等記憶體數量，以最佳化效能。
        - 依預設，主機的 Docker 資料是以機型來加密。儲存所有容器資料的 `/var/lib/docker` 目錄是使用 LUKS 加密來進行加密。如果在建立叢集的期間包含了 `disable-disk-encrypt` 選項，則主機的 Docker 資料不會加密。[進一步瞭解加密。](cs_secure.html#encrypted_disks)
    3. 從 IBM Cloud 基礎架構 (SoftLayer) 帳戶中選取公用及專用 VLAN。兩個 VLAN 會在工作者節點之間進行通訊，但公用 VLAN 也與 IBM 管理的 Kubernetes 主節點通訊。您可以將相同的 VLAN 用於多個叢集。**附註**：如果您選擇不要選取公用 VLAN，則必須配置替代方案。
    4. 選取硬體類型。在大部分情況中，共用選項就已足夠。
        - **專用**：確保完整隔離實體資源。
        - **共用**：容許實體資源儲存在與其他 IBM 客戶相同的硬體上。
4. 按一下**建立叢集**。您可以在**工作者節點**標籤中查看工作者節點部署的進度。部署完成時，您可以在**概觀**標籤中看到叢集已備妥。**附註：**每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，在叢集建立之後即不得手動予以變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。


**下一步為何？**

當叢集開始執行時，您可以查看下列作業：

-   [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
-   [在叢集中部署應用程式。](cs_app.html#app_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)
- 如果您有防火牆，則可能需要[開啟必要埠](cs_firewall.html#firewall)，才能使用 `bx`、`kubectl` 或 `calicotl` 指令以容許來自叢集的出埠資料流量，或容許網路服務的入埠資料流量。

<br />


## 使用 CLI 建立叢集
{: #clusters_cli}

叢集是組織成網路的一組工作者節點。叢集的用途是要定義一組資源、節點、網路及儲存裝置，以讓應用程式保持高度可用。您必須先建立叢集並設定該叢集中工作者節點的定義，才能部署應用程式。
{:shortdesc}

若要建立叢集，請執行下列動作：
1.  安裝 {{site.data.keyword.Bluemix_notm}} CLI 及 [{{site.data.keyword.containershort_notm}} 外掛程式](cs_cli_install.html#cs_cli_install)。
2.  登入 {{site.data.keyword.Bluemix_notm}} CLI。系統提示時，請輸入您的 {{site.data.keyword.Bluemix_notm}} 認證。

    ```
    bx login
    ```
    {: pre}

    **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

3. 如果您有多個 {{site.data.keyword.Bluemix_notm}} 帳戶，請選取您要在其中建立 Kubernetes 叢集的帳戶。

4.  如果您要在先前所選取 {{site.data.keyword.Bluemix_notm}} 地區以外的地區中建立或存取 Kubernetes 叢集，請執行 `bx cs region-set`。

6.  建立叢集。
    1.  檢閱可用的位置。顯示的位置取決於您所登入的 {{site.data.keyword.containershort_notm}} 地區。

        ```
        bx cs locations
        ```
        {: pre}

        您的 CLI 輸出符合[容器地區的位置](cs_regions.html#locations)。

    2.  選擇位置，並檢閱該位置中可用的機型。機型指定每一個工作者節點可用的虛擬運算資源。

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  查看 IBM Cloud 基礎架構 (SoftLayer) 中是否已存在此帳戶的公用及專用 VLAN。

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10 
        ```
        {: screen}

        如果公用及專用 VLAN 已存在，請記下相符的路由器。專用 VLAN 路由器的開頭一律為 `bcr`（後端路由器），而公用 VLAN 路由器的開頭一律為 `fcr`（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。在範例輸出中，任何專用 VLAN 都可以與任何公用 VLAN 搭配使用，因為路由器都會包括 `02a.dal10`。

    4.  執行 `cluster-create` 指令。您可以選擇精簡叢集（包括一個已設定 2vCPU 及 4GB 記憶體的工作者節點）或標準叢集（可以在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中包括您所選擇數目的工作者節點）。當您建立標準叢集時，依預設，會加密工作者節點磁碟，其硬體由多位 IBM 客戶所共用，並且按使用時數計費。</br>標準叢集的範例：

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch>
        ```
        {: pre}

        精簡叢集的範例：

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>表格. 瞭解 <code>bx cs cluster-create</code> 指令元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>在 {{site.data.keyword.Bluemix_notm}} 組織中建立叢集的指令。</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>將 <em>&lt;location&gt;</em> 取代為您要建立叢集的 {{site.data.keyword.Bluemix_notm}} 位置 ID。[可用的位置](cs_regions.html#locations)取決於您所登入的 {{site.data.keyword.containershort_notm}} 地區。</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>如果您要建立標準叢集，請選擇機型。機型指定每一個工作者節點可用的虛擬運算資源。如需相關資訊，請檢閱[比較 {{site.data.keyword.containershort_notm}} 的精簡與標準叢集](cs_why.html#cluster_types)。若為精簡叢集，您不需要定義機型。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>若為精簡叢集，您不需要定義公用 VLAN。精簡叢集會自動連接至 IBM 所擁有的公用 VLAN。</li>
          <li>若為標準叢集，如果您已在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中設定該位置的公用 VLAN，請輸入公用 VLAN 的 ID。如果您的帳戶中未同時具有公用和專用 VLAN，請不要指定此選項。{{site.data.keyword.containershort_notm}} 會為您自動建立公用 VLAN。<br/><br/>
          <strong>附註</strong>：專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>若為精簡叢集，您不需要定義專用 VLAN。精簡叢集會自動連接至 IBM 所擁有的專用 VLAN。</li><li>若為標準叢集，如果您已在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中設定該位置的專用 VLAN，請輸入專用 VLAN 的 ID。如果您的帳戶中未同時具有公用和專用 VLAN，請不要指定此選項。{{site.data.keyword.containershort_notm}} 會為您自動建立公用 VLAN。<br/><br/><strong>附註</strong>：專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。這些字首後面的數字與字母組合必須相符，才能在建立叢集時使用這些 VLAN。</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>將 <em>&lt;name&gt;</em> 取代為叢集的名稱。</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>要包含在叢集中的工作者節點數目。如果未指定 <code>--workers</code> 選項，會建立 1 個工作者節點。</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>叢集主節點的 Kubernetes 版本。這是選用值。除非另有指定，否則會使用支援的 Kubernetes 版本的預設值來建立叢集。若要查看可用的版本，請執行 <code>bx cs kube-versions</code>。</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>依預設，工作者節點會具備磁碟加密；[進一步瞭解](cs_secure.html#encrypted_disks)。如果您要停用加密，請包括此選項。</td>
        </tr>
        </tbody></table>

7.  驗證已要求建立叢集。

    ```
    bx cs clusters
    ```
    {: pre}

    **附註：**訂購工作者節點機器，並在您的帳戶中設定及佈建叢集，最多可能需要 15 分鐘。

    叢集佈建完成之後，叢集的狀態會變更為 **deployed**。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1   
    ```
    {: screen}

8.  檢查工作者節點的狀態。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    工作者節點備妥後，狀態會變更為 **Normal**，而且狀態為 **Ready**。當節點狀態為 **Ready** 時，您就可以存取叢集。

    **附註：**每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，在叢集建立之後即不得手動予以變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. 將您建立的叢集設為此階段作業的環境定義。請在您每次使用叢集時，完成下列配置步驟。
    1.  取得指令來設定環境變數，並下載 Kubernetes 配置檔。

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        配置檔下載完成之後，會顯示一個指令，可讓您用來將本端 Kubernetes 配置檔的路徑設定為環境變數。

        OS X 的範例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  複製並貼上終端機中顯示的指令，以設定 `KUBECONFIG` 環境變數。
    3.  驗證 `KUBECONFIG` 環境變數已適當設定。

        OS X 的範例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        輸出：

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

10. 使用預設埠 `8001` 來啟動 Kubernetes 儀表板。
    1.  使用預設埠號來設定 Proxy。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 瀏覽器中開啟下列 URL，以查看 Kubernetes 儀表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**下一步為何？**

-   [在叢集中部署應用程式。](cs_app.html#app_cli)
-   [使用 `kubectl` 指令行管理叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")。](https://kubernetes.io/docs/user-guide/kubectl/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)
- 如果您有防火牆，則可能需要[開啟必要埠](cs_firewall.html#firewall)，才能使用 `bx`、`kubectl` 或 `calicotl` 指令以容許來自叢集的出埠資料流量，或容許網路服務的入埠資料流量。

<br />


## 叢集狀態
{: #states}

您可以執行 `bx cs clusters` 指令並找出 **State** 欄位，以檢視現行叢集狀態。叢集狀態可提供叢集可用性及容量的相關資訊，以及可能已發生的潛在問題。
{:shortdesc}

|叢集狀態|原因|
|-------------|------|
|Deploying|Kubernetes 主節點尚未完整部署。您無法存取叢集。|
|Pending|已部署 Kubernetes 主節點。正在佈建工作者節點，因此還無法在叢集中使用。您可以存取叢集，但無法將應用程式部署至叢集。|
|Normal|叢集中的所有工作者節點都已開始執行。您可以存取叢集，並將應用程式部署至叢集。|
|Warning|叢集中至少有一個工作者節點無法使用，但有其他工作者節點可用，並且可以接管工作負載。<ol><li>列出叢集中的工作者節點，並記下顯示 <strong>Warning</strong> 狀態之工作者節點的 ID。<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>取得工作者節點的詳細資料。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>檢閱 <strong>State</strong>、<strong>Status</strong> 及 <strong>Details</strong> 欄位，以尋找工作者節點為何關閉的根本問題。</li><li>如果您的工作者節點幾乎達到記憶體或磁碟空間限制，請減少工作者節點上的工作負載，或將工作者節點新增至叢集，以協助對工作負載進行負載平衡。</li></ol>|
|Critical|無法聯繫 Kubernetes 主節點，或叢集中的所有工作者節點都已關閉。<ol><li>列出叢集中的工作者節點。<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>取得每一個工作者節點的詳細資料。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>檢閱 <strong>State</strong> 及 <strong>Status</strong> 欄位，以尋找工作者節點為何關閉的根本問題。<ul><li>如果工作者節點狀態顯示 <strong>Provision_failed</strong>，則您可能沒有從 IBM Cloud 基礎架構 (SoftLayer) 組合佈建工作者節點的必要許可權。若要尋找必要許可權，請參閱[配置對 IBM Cloud 基礎架構 (SoftLayer) 組合的存取權以建立標準 Kubernetes 叢集](cs_infrastructure.html#unify_accounts)。</li><li>如果工作者節點狀態 (State) 顯示 <strong>Critical</strong>，而狀態 (Status) 顯示 <strong>Not Ready</strong>，則工作者節點可能無法連接至 IBM Cloud 基礎架構 (SoftLayer)。請先執行 <code>bx cs worker-reboot --hard CLUSTER WORKER</code>，來開始疑難排解。如果該指令不成功，則請執行 <code>bx cs worker reload CLUSTER WORKER</code>。</li><li>如果工作者節點狀態 (State) 顯示 <strong>Critical</strong>，而狀態 (Status) 顯示 <strong>Out of disk</strong>，則工作者節點已用完容量。您可以減少工作者節點上的工作負載，或將工作者節點新增至叢集，以協助對工作負載進行負載平衡。</li><li>如果工作者節點狀態 (State) 顯示 <strong>Critical</strong>，而狀態 (Status) 顯示 <strong>Unknown</strong>，則 Kubernetes 主節點無法使用。請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/support/index.html#getting-help)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</li></ul></li></ol>|
{: caption="表格。叢集狀態" caption-side="top"}

<br />


## 移除叢集
{: #remove}

當您完成叢集時，即可予以移除，讓叢集不再使用資源。
{:shortdesc}

不再需要使用「隨收隨付制」帳戶所建立的精簡及標準叢集時，使用者必須手動予以移除。

當您刪除叢集時，也會刪除叢集上的資源（包括容器、Pod、連結服務及 Secret）。如果您未在刪除叢集時刪除儲存空間，則可以透過 {{site.data.keyword.Bluemix_notm}} GUI 中的 IBM Cloud 基礎架構 (SoftLayer) 儀表板來刪除儲存空間。基於每月計費週期，不能在月底最後一天刪除持續性磁區宣告。如果您在該月份的最後一天刪除持續性磁區宣告，則刪除會保持擱置，直到下個月開始為止。

**警告：**不會在持續性儲存空間中建立叢集或資料的備份。刪除叢集是永久性的，無法復原。

-   從 {{site.data.keyword.Bluemix_notm}} GUI
    1.  選取叢集，然後按一下**其他動作...** 功能表中的**刪除**。
-   從 {{site.data.keyword.Bluemix_notm}} CLI
    1.  列出可用的叢集。

        ```
        bx cs clusters
        ```
        {: pre}

    2.  刪除叢集。

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  遵循提示，然後選擇是否刪除叢集資源。

移除叢集時，您可以選擇移除與其相關聯的可攜式子網路及持續性儲存空間：
- 子網路是用來將可攜式公用 IP 位址指派給負載平衡器服務或 Ingress 控制器。如果保留它們，則可以在新的叢集中重複使用它們，或稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除它們。
- 如果您使用[現有的檔案共用](cs_storage.html#existing)建立了持續性磁區宣告，則在刪除叢集時，無法刪除檔案共用。您必須稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除檔案共用。
- 持續性儲存空間為您的資料提供高可用性。如果刪除它，則無法回復您的資料。
