---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 設定叢集
{: #cs_cluster}

設計最大可用性及容量的叢集設定。
{:shortdesc}

下圖包括具有遞增可用性的一般叢集配置。

![叢集高可用性階段](images/cs_cluster_ha_roadmap.png)

如圖所示，在多個工作者節點上部署應用程式，可讓應用程式的可用性更高。跨多個叢集部署應用程式，可讓它們的可用性更高。如需最高可用性，請跨不同地區的叢集部署應用程式。[如需詳細資料，請檢閱高可用性叢集配置的選項。](cs_planning.html#cs_planning_cluster_config)

<br />


## 使用 GUI 建立叢集
{: #cs_cluster_ui}

Kubernetes 叢集是一組組織成網路的工作者節點。叢集的用途是要定義一組資源、節點、網路及儲存裝置，以讓應用程式保持高度可用。您必須先建立叢集並設定該叢集中工作者節點的定義，才能部署應用程式。
{:shortdesc}
若為「{{site.data.keyword.Bluemix_dedicated_notm}}」使用者，請改為參閱[在 {{site.data.keyword.Bluemix_dedicated_notm}}中從 GUI 建立 Kubernetes 叢集（封閉測試版）](#creating_ui_dedicated)。

若要建立叢集，請執行下列動作：
1. 在型錄中，選取 **Kubernetes 叢集**。
2. 選取叢集方案的類型。您可以選擇**精簡**或**隨收隨付制**。使用「隨收隨付制」方案，您可以針對高可用性環境，佈建一個具有例如多工作者節點之特性的標準叢集。
3. 配置叢集詳細資料。
    1. 為叢集命名、選擇 Kubernetes 的版本，以及選取要在其中部署的位置。選取實際上與您最接近的位置以獲得最佳效能。當您選取所在國家/地區以外的位置時，請謹記，您可能需要有合法授權，才能將資料實際儲存在其他國家/地區。
    2. 選取機器類型並指定您需要的工作者節點數目。機型會定義設定於每一個工作者節點中，且可供容器使用的虛擬 CPU 及記憶體數量。
        - 微機型指出最小選項。
        - 平衡機器具有指派給每一個 CPU 的相等記憶體數量，以最佳化效能。
    3. 從 IBM Cloud 基礎架構 (SoftLayer) 帳戶中選取公用及專用 VLAN。兩個 VLAN 會在工作者節點之間進行通訊，但公用 VLAN 也與 IBM 管理的 Kubernetes 主節點通訊。您可以將相同的 VLAN 用於多個叢集。**附註**：如果您選擇不要選取公用 VLAN，則必須配置替代方案。
    4. 選取硬體類型。在大部分情況中，共用選項就已足夠。
        - **專用**：確保完整隔離實體資源。
        - **共用**：容許實體資源儲存在與其他 IBM 客戶相同的硬體上。
4. 按一下**建立叢集**。您可以在**工作者節點**標籤中查看工作者節點部署的進度。部署完成時，您可以在**概觀**標籤中看到叢集已備妥。**附註：**每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，在叢集建立之後即不得手動予以變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。


**下一步為何？**

當叢集開始執行時，您可以查看下列作業：

-   [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
-   [在叢集中部署應用程式。](cs_apps.html#cs_apps_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)


### 在 {{site.data.keyword.Bluemix_dedicated_notm}}中使用 GUI 建立叢集（封閉測試版）
{: #creating_ui_dedicated}

1.  使用 IBM ID，登入「{{site.data.keyword.Bluemix_notm}} 公用」主控台 ([https://console.bluemix.net ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net))。
2.  從帳戶功能表中，選取「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶。即會使用「{{site.data.keyword.Bluemix_dedicated_notm}}」實例的服務及資訊來更新主控台。
3.  從型錄中，選取**容器**，然後按一下 **Kubernetes 叢集**。
4.  輸入**叢集名稱**。
5.  選取**機型**。機型會定義設定於每一個工作者節點中，且可供節點中部署之所有容器使用的虛擬 CPU 及記憶體數量。
    -   微機型指出最小選項。
    -   平衡機型具有指派給每一個 CPU 的相等記憶體數量，以最佳化效能。
6.  選擇您需要的**工作者節點數目**。選取 `3`，確保叢集的高可用性。
7.  按一下**建立叢集**。即會開啟叢集的詳細資料，但叢集中的工作者節點需要數分鐘的時間進行佈建。在**工作者節點**標籤中，您可以看到工作者節點部署的進度。工作者節點備妥後，狀態會變更為 **Ready**。

**下一步為何？**

當叢集開始執行時，您可以查看下列作業：

-   [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
-   [在叢集中部署應用程式。](cs_apps.html#cs_apps_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)

<br />


## 使用 CLI 建立叢集
{: #cs_cluster_cli}

叢集是一組組織成網路的工作者節點。叢集的用途是要定義一組資源、節點、網路及儲存裝置，以讓應用程式保持高度可用。您必須先建立叢集並設定該叢集中工作者節點的定義，才能部署應用程式。
{:shortdesc}

若為「{{site.data.keyword.Bluemix_dedicated_notm}}」使用者，請改為參閱[在 {{site.data.keyword.Bluemix_dedicated_notm}}中從 CLI 建立 Kubernetes 叢集（封閉測試版）](#creating_cli_dedicated)。

若要建立叢集，請執行下列動作：
1.  安裝 {{site.data.keyword.Bluemix_notm}} CLI 及 [{{site.data.keyword.containershort_notm}} 外掛程式](cs_cli_install.html#cs_cli_install)。
2.  登入 {{site.data.keyword.Bluemix_notm}} CLI。系統提示時，請輸入您的 {{site.data.keyword.Bluemix_notm}} 認證。若要指定 {{site.data.keyword.Bluemix_notm}} 地區，請[包括 API 端點](cs_regions.html#bluemix_regions)。

    ```
    bx login
    ```
    {: pre}

    **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

3. 如果您有多個 {{site.data.keyword.Bluemix_notm}} 帳戶，請選取您要在其中建立 Kubernetes 叢集的帳戶。

4.  如果您要在先前所選取 {{site.data.keyword.Bluemix_notm}} 地區以外的地區中建立或存取 Kubernetes 叢集，請[指定 {{site.data.keyword.containershort_notm}} 地區 API 端點](cs_regions.html#container_login_endpoints)。

    **附註**：如果您要在美國東部建立叢集，您必須使用 `bx cs init --host https://us-east.containers.bluemix.net` 指令來指定美國東部容器地區 API 端點。

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

    4.  執行 `cluster-create` 指令。您可以選擇精簡叢集（包括一個已設定 2vCPU 及 4GB 記憶體的工作者節點）或標準叢集（可以在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中包括您所選擇數目的工作者節點）。當您建立標準叢集時，依預設，工作者節點的硬體由多位 IBM 客戶所共用，並且按小時計費。</br>標準叢集的範例：

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
        <caption>表 1. 瞭解 <code>bx cs cluster-create</code> 指令元件</caption>
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
        <td>如果您要建立標準叢集，請選擇機型。機型指定每一個工作者節點可用的虛擬運算資源。如需相關資訊，請檢閱[比較 {{site.data.keyword.containershort_notm}} 的精簡與標準叢集](cs_planning.html#cs_planning_cluster_type)。若為精簡叢集，您不需要定義機型。</td>
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

-   [在叢集中部署應用程式。](cs_apps.html#cs_apps_cli)
-   [使用 `kubectl` 指令行管理叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")。](https://kubernetes.io/docs/user-guide/kubectl/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)

### 在 {{site.data.keyword.Bluemix_dedicated_notm}}中使用 CLI 建立叢集（封閉測試版）
{: #creating_cli_dedicated}

1.  安裝 {{site.data.keyword.Bluemix_notm}} CLI 及 [{{site.data.keyword.containershort_notm}} 外掛程式](cs_cli_install.html#cs_cli_install)。
2.  登入 {{site.data.keyword.containershort_notm}} 的公用端點。系統提示時，請輸入 {{site.data.keyword.Bluemix_notm}} 認證，然後選取「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶。

    ```
    bx login -a api.<region>.bluemix.net
    ```
    {: pre}

    **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

3.  使用 `cluster-create` 指令來建立叢集。當您建立標準叢集時，工作者節點的硬體會按小時計費。

    範例：

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>表 2. 瞭解此指令的元件</caption>
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
    <td>將 &lt;location&gt; 取代為您要建立叢集的 {{site.data.keyword.Bluemix_notm}} 位置 ID。[可用的位置](cs_regions.html#locations)取決於您所登入的 {{site.data.keyword.containershort_notm}} 地區。</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>如果您要建立標準叢集，請選擇機型。機型指定每一個工作者節點可用的虛擬運算資源。如需相關資訊，請檢閱[比較 {{site.data.keyword.containershort_notm}} 的精簡與標準叢集](cs_planning.html#cs_planning_cluster_type)。若為精簡叢集，您不需要定義機型。</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>將 <em>&lt;name&gt;</em> 取代為叢集的名稱。</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>要包含在叢集中的工作者節點數目。如果未指定 <code>--workers</code> 選項，會建立 1 個工作者節點。</td>
    </tr>
    </tbody></table>

4.  驗證已要求建立叢集。

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

5.  檢查工作者節點的狀態。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    工作者節點備妥後，狀態會變更為 **Normal**，而且狀態為 **Ready**。當節點狀態為 **Ready** 時，您就可以存取叢集。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  將您建立的叢集設為此階段作業的環境定義。請在您每次使用叢集時，完成下列配置步驟。

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

7.  使用預設埠 8001 來存取 Kubernetes 儀表板。
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

-   [在叢集中部署應用程式。](cs_apps.html#cs_apps_cli)
-   [使用 `kubectl` 指令行管理叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")。](https://kubernetes.io/docs/user-guide/kubectl/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)

<br />


## 使用專用及公用映像檔登錄
{: #cs_apps_images}

Docker 映像檔是您建立的每個容器的基礎。映像檔是從 Dockerfile 所建立的，該 Dockerfile 檔案包含建置映像檔的指示。Dockerfile 可能會參照其指示中個別儲存的建置構件（例如應用程式、應用程式的配置及其相依關係）。映像檔通常會儲存在登錄中，而該登錄可供公開存取（公用登錄）或已設定一小組使用者的有限存取（專用登錄）。
{:shortdesc}

請檢閱下列選項，以尋找如何設定映像檔登錄以及如何使用登錄中之映像檔的相關資訊。

-   [存取 {{site.data.keyword.registryshort_notm}} 中的名稱空間，以使用 IBM 提供的映像檔及您自己的專用 Docker 映像檔](#bx_registry_default)。
-   [從 Docker Hub 存取公用映像檔](#dockerhub)。
-   [存取儲存在其他專用登錄中的專用映像檔](#private_registry)。

### 存取 {{site.data.keyword.registryshort_notm}} 中的名稱空間，以使用 IBM 提供的映像檔及您自己的專用 Docker 映像檔
{: #bx_registry_default}

您可以將容器從 IBM 提供的公用映像檔或 {{site.data.keyword.registryshort_notm}} 的名稱空間中所儲存的專用映像檔部署至叢集中。

開始之前：

1. [在「{{site.data.keyword.Bluemix_notm}} 公用」或「{{site.data.keyword.Bluemix_dedicated_notm}}」上，於 {{site.data.keyword.registryshort_notm}} 中設定名稱空間，並將映像檔推送至此名稱空間](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2. [建立叢集](#cs_cluster_cli)。
3. [將 CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

當您建立叢集時，會自動為叢集建立不會過期的登錄記號。此記號是用來授權 {{site.data.keyword.registryshort_notm}} 中所設定的任何名稱空間的唯讀存取，因此您可以使用 IBM 提供的公用及您自己的專用 Docker 映像檔。當您部署容器化應用程式時，記號必須儲存在 Kubernetes `imagePullSecret` 中，才能供 Kubernetes 叢集存取。建立叢集時，{{site.data.keyword.containershort_notm}} 會自動將此記號儲存在 Kubernetes `imagePullSecret` 中。`imagePullSecret` 會新增至預設 Kubernetes 名稱空間、該名稱空間的 ServiceAccount 中的預設 Secret 清單，以及 kube-system 名稱空間。

**附註：**使用此起始設定，即可將容器從 {{site.data.keyword.Bluemix_notm}} 帳戶之名稱空間中可用的任何映像檔，部署至叢集的 **default** 名稱空間。如果您要將容器部署至叢集的其他名稱空間，或者要使用儲存在另一個 {{site.data.keyword.Bluemix_notm}} 地區或另一個 {{site.data.keyword.Bluemix_notm}} 帳戶中的映像檔，則必須[為叢集建立您自己的 imagePullSecret](#bx_registry_other)。

若要將容器部署至叢集的 **default** 名稱空間，請建立配置檔。

1.  建立名稱為 `mydeployment.yaml` 的部署配置檔。
2.  從 {{site.data.keyword.registryshort_notm}} 中的名稱空間，定義您要使用的部署及映像檔。

    若要使用 {{site.data.keyword.registryshort_notm}} 的名稱空間中的專用映像檔：

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **提示：**若要擷取名稱空間資訊，請執行 `bx cr namespace-list`。

3.  在叢集中建立部署。

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **提示：**您也可以部署現有配置檔，例如其中一個 IBM 提供的公用映像檔。此範例在美國南部地區使用 **ibmliberty** 映像檔。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### 將映像檔部署至其他 Kubernetes 名稱空間，或存取其他 {{site.data.keyword.Bluemix_notm}} 地區及帳戶中的映像檔
{: #bx_registry_other}

您可以將容器部署至其他 Kubernetes 名稱空間、使用儲存在其他 {{site.data.keyword.Bluemix_notm}} 地區或帳戶中的映像檔，或使用儲存在「{{site.data.keyword.Bluemix_dedicated_notm}}」中的映像檔，方法是建立您自己的 imagePullSecret。

開始之前：

1.  [在「{{site.data.keyword.Bluemix_notm}} 公用」或「{{site.data.keyword.Bluemix_dedicated_notm}}」上，於 {{site.data.keyword.registryshort_notm}} 中設定名稱空間，並將映像檔推送至此名稱空間](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2.  [建立叢集](#cs_cluster_cli)。
3.  [將 CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

若要建立您自己的 imagePullSecret，請執行下列動作：

**附註：**ImagePullSecret 僅適用於建立它們的 Kubernetes 名稱空間。請針對您要部署容器的每個名稱空間，重複這些步驟。來自 [DockerHub](#dockerhub) 的映像檔不需要 ImagePullSecret。

1.  如果您沒有記號，請[為您要存取的登錄建立記號](/docs/services/Registry/registry_tokens.html#registry_tokens_create)。
2.  列出 {{site.data.keyword.Bluemix_notm}} 帳戶中的記號。

    ```
    bx cr token-list
    ```
    {: pre}

3.  記下您要使用的記號 ID。
4.  擷取記號的值。將 <em>&lt;token_id&gt;</em> 取代為您在前一個步驟中所擷取的記號 ID。

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    您的記號值會顯示在 CLI 輸出的**記號**欄位中。

5.  建立用來儲存記號資訊的 Kubernetes Secret。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表 3. 瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必要。您要使用 Secret 並在其中部署容器的叢集的 Kubernetes 名稱空間。執行 <code>kubectl get namespaces</code>，以列出叢集中的所有名稱空間。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必要。您要用於 imagePullSecret 的名稱。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必要。已設定名稱空間的映像檔登錄的 URL。<ul><li>對於美國南部及美國東部所設定的名稱空間：registry.ng.bluemix.net</li><li>對於英國南部所設定的名稱空間：registry.eu-gb.bluemix.net</li><li>對於歐盟中部（法蘭克福）所設定的名稱空間：registry.eu-de.bluemix.net</li><li>對於澳洲（雪梨）所設定的名稱空間：registry.au-syd.bluemix.net</li><li>對於「{{site.data.keyword.Bluemix_dedicated_notm}}」所設定的名稱空間：registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必要。登入專用登錄的使用者名稱。對於 {{site.data.keyword.registryshort_notm}}，使用者名稱會設為 <code>token</code>。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必要。先前所擷取的登錄記號值。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必要。如果您有 Docker 電子郵件位址，請輸入它。否則，請輸入虛構的電子郵件位址，例如 a@b.c。此電子郵件是建立 Kubernetes Secret 的必要項目，但在建立之後就不再使用。</td>
    </tr>
    </tbody></table>

6.  驗證已順利建立 Secret。將 <em>&lt;kubernetes_namespace&gt;</em> 取代為已建立 imagePullSecret 的名稱空間的名稱。

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  建立會參照 imagePullSecret 的 Pod。
    1.  建立名稱為 `mypod.yaml` 的 Pod 配置檔。
    2.  定義您要用來存取專用 {{site.data.keyword.Bluemix_notm}} 登錄的 Pod 及 imagePullSecret。

        名稱空間中的專用映像檔：

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        {{site.data.keyword.Bluemix_notm}} 公用映像檔：

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表 4. 瞭解 YAML 檔案元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>您要部署至叢集的容器的名稱。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>在其中儲存映像檔的名稱空間。若要列出可用的名稱空間，請執行 `bx cr namespace-list`。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>您要使用的映像檔的名稱。若要列出 {{site.data.keyword.Bluemix_notm}} 帳戶中的可用映像檔，請執行 `bx cr image-list`。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>您要使用的映像檔的版本。如果未指定任何標籤，預設會使用標記為<strong>最新</strong>的映像檔。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>您先前建立的 imagePullSecret 的名稱。</td>
        </tr>
        </tbody></table>

   3.  儲存變更。
   4.  在叢集中建立部署。

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


### 從 Docker Hub 存取公用映像檔
{: #dockerhub}

您可以使用儲存在 Docker Hub 中的任何公用映像檔來將容器部署至叢集，而不需要進行任何額外配置。

開始之前：

1.  [建立叢集](#cs_cluster_cli)。
2.  [將 CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

建立部署配置檔。

1.  建立名稱為 `mydeployment.yaml` 的配置檔。
2.  從 Docker Hub 中，定義您要使用的部署及公用映像檔。下列配置檔使用 Docker Hub 上可用的公用 NGINX 映像檔。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  在叢集中建立部署。

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **提示：**或者，您也可以部署現有配置檔。下列範例使用相同的公用 NGINX 映像檔，但直接將它套用至叢集。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### 存取儲存在其他專用登錄中的專用映像檔
{: #private_registry}

如果您已具有想要使用的專用登錄，則必須將登錄認證儲存至 Kubernetes imagePullSecret 中，然後在配置檔中參照此 Secret。

開始之前：

1.  [建立叢集](#cs_cluster_cli)。
2.  [將 CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

若要建立 imagePullSecret，請執行下列動作：

**附註：**ImagePullSecret 適用於建立它們的 Kubernetes 名稱空間。請針對您要從專用 {{site.data.keyword.Bluemix_notm}} 登錄的映像檔中部署容器的每個名稱空間，重複這些步驟。

1.  建立用來儲存專用登錄認證的 Kubernetes Secret。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表 5. 瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必要。您要使用 Secret 並在其中部署容器的叢集的 Kubernetes 名稱空間。執行 <code>kubectl get namespaces</code>，以列出叢集中的所有名稱空間。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必要。您要用於 imagePullSecret 的名稱。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必要。儲存專用映像檔的登錄的 URL。</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必要。登入專用登錄的使用者名稱。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必要。先前所擷取的登錄記號值。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必要。如果您有 Docker 電子郵件位址，請輸入它。否則，請輸入虛構的電子郵件位址，例如 a@b.c。此電子郵件是建立 Kubernetes Secret 的必要項目，但在建立之後就不再使用。</td>
    </tr>
    </tbody></table>

2.  驗證已順利建立 Secret。將 <em>&lt;kubernetes_namespace&gt;</em> 取代為已建立 imagePullSecret 的名稱空間的名稱。

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  建立會參照 imagePullSecret 的 Pod。
    1.  建立名稱為 `mypod.yaml` 的 Pod 配置檔。
    2.  定義您要用來存取專用 {{site.data.keyword.Bluemix_notm}} 登錄的 Pod 及 imagePullSecret。若要使用專用登錄中的專用映像檔：

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表 6. 瞭解 YAML 檔案元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>您要建立的 Pod 的名稱。</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>您要部署至叢集的容器的名稱。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>專用登錄中您要使用的映像檔的完整路徑。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>您要使用的映像檔的版本。如果未指定任何標籤，預設會使用標記為<strong>最新</strong>的映像檔。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>您先前建立的 imagePullSecret 的名稱。</td>
        </tr>
        </tbody></table>

  3.  儲存變更。
  4.  在叢集中建立部署。

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## 將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集
{: #cs_cluster_service}

將現有 {{site.data.keyword.Bluemix_notm}} 服務實例新增至叢集，讓叢集使用者在將應用程式部署至叢集時能夠存取及使用 {{site.data.keyword.Bluemix_notm}} 服務。
{:shortdesc}

開始之前：

1. [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。
2. [要求 {{site.data.keyword.Bluemix_notm}} 服務的實例](/docs/manageapps/reqnsi.html#req_instance)。
   **附註：**若要在華盛頓特區中建立服務實例，您必須使用 CLI。
3. 若為「{{site.data.keyword.Bluemix_dedicated_notm}}」使用者，請改為參閱[在 {{site.data.keyword.Bluemix_dedicated_notm}}中將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集（封閉測試版）](#binding_dedicated)。

**附註：**
<ul><ul>
<li>您只能新增支援服務金鑰的 {{site.data.keyword.Bluemix_notm}} 服務。如果服務不支援服務金鑰，請參閱[啟用外部應用程式以使用 {{site.data.keyword.Bluemix_notm}} 服務](/docs/manageapps/reqnsi.html#req_instance)。</li>
<li>必須完全部署叢集及工作者節點，才能新增服務。</li>
</ul></ul>


若要新增服務，請執行下列動作：
2.  列出可用的 {{site.data.keyword.Bluemix_notm}} 服務。

    ```
    bx service list
    ```
    {: pre}

    CLI 輸出範例：

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  記下您要新增至叢集的服務實例的**名稱**。
4.  識別您要用來新增服務的叢集名稱空間。請選擇下列選項。
    -   列出現有名稱空間，並選擇您要使用的名稱空間。

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   在叢集中建立新的名稱空間。

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  將服務新增至叢集。

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    將服務順利新增至叢集之後，即會建立叢集 Secret，以保留服務實例認證。CLI 輸出範例：

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  驗證已在叢集名稱空間中建立 Secret。

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


若要在叢集中所部署的 Pod 中使用服務，叢集使用者可以存取 {{site.data.keyword.Bluemix_notm}} 服務的服務認證，方法是[將 Kubernetes 密碼以密碼磁區形式裝載至 Pod](cs_apps.html#cs_apps_service)。

### 在 {{site.data.keyword.Bluemix_dedicated_notm}}中將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集（封閉測試版）
{: #binding_dedicated}

**附註**：必須完全部署叢集及工作者節點，才能新增服務。

1.  將本端「{{site.data.keyword.Bluemix_dedicated_notm}}」配置檔的路徑設為 `DEDICATED_BLUEMIX_CONFIG` 環境變數。

    ```
    export DEDICATED_BLUEMIX_CONFIG=<path_to_config_directory>
    ```
    {: pre}

2.  將上面定義的相同路徑設定為 `BLUEMIX_HOME` 環境變數。

    ```
    export BLUEMIX_HOME=$DEDICATED_BLUEMIX_CONFIG
    ```
    {: pre}

3.  登入您要在其中建立服務實例的「{{site.data.keyword.Bluemix_dedicated_notm}}」環境。

    ```
    bx login -a api.<dedicated_domain> -u <user> -p <password> -o <org> -s <space>
    ```
    {: pre}

4.  列出 {{site.data.keyword.Bluemix_notm}} 型錄中的可用服務。

    ```
    bx service offerings
    ```
    {: pre}

5.  建立您要連結至叢集的服務實例。

    ```
    bx service create <service_name> <service_plan> <service_instance_name>
    ```
    {: pre}

6.  列出可用的 {{site.data.keyword.Bluemix_notm}} 服務來驗證您已建立服務實例。

    ```
    bx service list
    ```
    {: pre}

    CLI 輸出範例：

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

7.  取消設定 `BLUEMIX_HOME` 環境變數，以回到使用「{{site.data.keyword.Bluemix_notm}} 公用」。

    ```
    unset $BLUEMIX_HOME
    ```
    {: pre}

8.  登入 {{site.data.keyword.containershort_notm}} 的公用端點，並將 CLI 的目標設為「{{site.data.keyword.Bluemix_dedicated_notm}}」環境中的叢集。
    1.  使用 {{site.data.keyword.containershort_notm}} 的公用端點登入帳戶。系統提示時，請輸入 {{site.data.keyword.Bluemix_notm}} 認證，然後選取「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶。

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

        **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

    2.  取得可用叢集清單，並識別 CLI 中要設為目標的叢集名稱。

        ```
        bx cs clusters
        ```
        {: pre}

    3.  取得指令來設定環境變數，並下載 Kubernetes 配置檔。

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

    4.  複製並貼上終端機中顯示的指令，以設定 `KUBECONFIG` 環境變數。

9.  識別您要用來新增服務的叢集名稱空間。請選擇下列選項。
    * 列出現有名稱空間，並選擇您要使用的名稱空間。
        ```
        kubectl get namespaces
        ```
        {: pre}

    * 在叢集中建立新的名稱空間。
        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

10.  將服務實例連結至叢集。

      ```
      bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
      ```
      {: pre}

<br />


## 管理叢集存取
{: #cs_cluster_user}

您可以將叢集的存取權授與其他使用者，讓他們可以存取叢集、管理叢集，以及將應用程式部署至叢集。
{:shortdesc}

每位使用 {{site.data.keyword.containershort_notm}} 的使用者都必須在「身分及存取管理」中獲指派服務特定使用者角色，以判斷此使用者可以執行的動作。「身分及存取管理」可區分下列存取許可權。

<dl>
<dt>{{site.data.keyword.containershort_notm}} 存取原則</dt>
<dd>存取原則可以判斷您可對叢集執行的叢集管理動作，例如，建立或移除叢集，以及新增或移除額外的工作者節點。</dd>
<dt>資源群組</dt>
<dd>資源群組是一種將 {{site.data.keyword.Bluemix_notm}} 服務組織成群組的方式，讓您可以一次快速地指派使用者對多個資源的存取權。瞭解如何[使用資源群組來管理使用者](/docs/admin/resourcegroups.html#rgs)。</dd>
<dt>RBAC 角色</dt>
<dd>每位獲指派 {{site.data.keyword.containershort_notm}} 存取原則的使用者都會自動獲指派 RBAC 角色。RBAC 角色可以判斷您可對叢集內 Kubernetes 資源執行的動作。只有 default 名稱空間才能設定 RBAC 角色。叢集管理者可以為叢集中的其他名稱空間新增 RBAC 角色。如需相關資訊，請參閱 Kubernetes 文件中的[使用 RBAC 授權 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</dd>
<dt>Cloud Foundry 角色</dt>
<dd>每位使用者都必須獲指派 Cloud Foundry 使用者角色。此角色可以判斷使用者可對 {{site.data.keyword.Bluemix_notm}} 帳戶執行的動作，例如，邀請其他使用者，或檢視配額用量。若要檢閱每一個角色的許可權，請參閱 [Cloud Foundry 角色](/docs/iam/cfaccess.html#cfaccess)。</dd>
</dl>

請選擇下列動作，以繼續進行：

-   [檢視使用叢集的必要存取原則及許可權](#access_ov)。
-   [檢視現行存取原則](#view_access)。
-   [變更現有使用者的存取原則](#change_access)。
-   [將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶](#add_users)。

### 必要 {{site.data.keyword.containershort_notm}} 存取原則及許可權概觀
{: #access_ov}

檢閱您可以授與 {{site.data.keyword.Bluemix_notm}} 帳戶中使用者的存取原則及許可權。操作員及編輯者角色具有個別的許可權。例如，如果您想要使用者新增工作者節點及連結服務，您必須同時將操作員及編輯者角色指派給使用者。

|存取原則|叢集管理許可權|Kubernetes 資源許可權|
|-------------|------------------------------|-------------------------------|
|<ul><li>角色：管理者</li><li>服務實例：所有現行服務實例</li></ul>|<ul><li>建立精簡或標準叢集</li><li>設定 {{site.data.keyword.Bluemix_notm}} 帳戶的認證，以存取 IBM Cloud 基礎架構 (SoftLayer) 組合</li><li>移除叢集</li><li>指派及變更此帳戶中其他現有使用者的 {{site.data.keyword.containershort_notm}} 存取原則。</li></ul><br/>此角色會繼承此帳戶中所有叢集的「編輯者」、「操作員」及「檢視者」角色的許可權。|<ul><li>RBAC 角色：cluster-admin</li><li>每個名稱空間中資源的讀寫存取</li><li>建立名稱空間內的角色</li><li>存取 Kubernetes 儀表板</li><li>建立 Ingress 資源，使應用程式公開可用</li></ul>|
|<ul><li>角色：管理者</li><li>服務實例：特定叢集 ID</li></ul>|<ul><li>移除特定叢集。</li></ul><br/>此角色會繼承所選取叢集的「編輯者」、「操作員」及「檢視者」角色的許可權。|<ul><li>RBAC 角色：cluster-admin</li><li>每個名稱空間中資源的讀寫存取</li><li>建立名稱空間內的角色</li><li>存取 Kubernetes 儀表板</li><li>建立 Ingress 資源，使應用程式公開可用</li></ul>|
|<ul><li>角色：操作員</li><li>服務實例：所有現行服務實例/特定叢集 ID</li></ul>|<ul><li>將其他工作者節點新增至叢集</li><li>移除叢集中的工作者節點</li><li>重新啟動工作者節點</li><li>重新載入工作者節點</li><li>將子網路新增至叢集</li></ul>|<ul><li>RBAC 角色：admin</li><li>讀寫存取預設名稱空間內的資源，但不會讀寫存取名稱空間本身</li><li>建立名稱空間內的角色</li></ul>|
|<ul><li>角色：編輯者</li><li>服務實例：所有現行服務實例或特定叢集 ID</li></ul>|<ul><li>將 {{site.data.keyword.Bluemix_notm}} 服務連結至叢集。</li><li>取消 {{site.data.keyword.Bluemix_notm}} 服務與叢集的連結。</li><li>建立 Webhook。</li></ul><br/>請對應用程式開發人員使用此角色。|<ul><li>RBAC 角色：edit</li><li>default 名稱空間內資源的讀寫存取</li></ul>|
|<ul><li>角色：檢視者</li><li>服務實例：所有現行服務實例/特定叢集 ID</li></ul>|<ul><li>列出叢集</li><li>檢視叢集的詳細資料</li></ul>|<ul><li>RBAC 角色：view</li><li>default 名稱空間內資源的讀取權</li><li>沒有 Kubernetes Secret 的讀取權</li></ul>|
|<ul><li>Cloud Foundry 組織角色：管理員</li></ul>|<ul><li>將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶</li></ul>| |
|<ul><li>Cloud Foundry 空間角色：開發人員</li></ul>|<ul><li>建立 {{site.data.keyword.Bluemix_notm}} 服務實例</li><li>將 {{site.data.keyword.Bluemix_notm}} 服務實例連結至叢集</li></ul>| |
{: caption="表 7. 必要 {{site.data.keyword.containershort_notm}} 存取原則及許可權的概觀" caption-side="top"}

### 驗證您的 {{site.data.keyword.containershort_notm}} 存取原則
{: #view_access}

您可以檢閱及驗證您已獲指派的 {{site.data.keyword.containershort_notm}} 存取原則。存取原則可以判斷您可執行的叢集管理動作。

1.  選取您要驗證您的 {{site.data.keyword.containershort_notm}} 存取原則的 {{site.data.keyword.Bluemix_notm}} 帳戶。
2.  從功能表列中，按一下**管理** > **安全** > **身分及存取**。**使用者**視窗會顯示一份使用者清單，其中包含其電子郵件位址以及對所選取帳戶的現行狀態。
3.  選取您要檢查存取原則的使用者。
4.  在**存取原則**區段中，檢閱使用者的存取原則。若要尋找您可以使用此角色執行之動作的詳細資訊，請參閱[必要 {{site.data.keyword.containershort_notm}} 存取原則及許可權的概觀](#access_ov)。
5.  選用項目：[變更現行存取原則](#change_access)。

    **附註：**只有具有 {{site.data.keyword.containershort_notm}} 中所有資源的已指派「管理者」服務原則的使用者，才能變更現有使用者的存取原則。若要將更多使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶，您必須具有此帳戶的「管理員」Cloud Foundry 角色。若要尋找 {{site.data.keyword.Bluemix_notm}} 帳戶擁有者的 ID，請執行 `bx iam accounts`，並尋找**擁有者使用者 ID**。


### 變更現有使用者的 {{site.data.keyword.containershort_notm}} 存取原則
{: #change_access}

您可以變更現有使用者的存取原則，以授與 {{site.data.keyword.Bluemix_notm}} 帳戶中叢集的叢集管理許可權。

開始之前，請針對 {{site.data.keyword.containershort_notm}} 中的所有資源，[驗證您已獲指派「管理者」存取原則](#view_access)。

1.  選取您要變更現有使用者的 {{site.data.keyword.containershort_notm}} 存取原則的 {{site.data.keyword.Bluemix_notm}} 帳戶。
2.  從功能表列中，按一下**管理** > **安全** > **身分及存取**。**使用者**視窗會顯示一份使用者清單，其中包含其電子郵件位址以及對所選取帳戶的現行狀態。
3.  尋找您要變更存取原則的使用者。如果您找不到所要尋找的使用者，請[邀請此使用者加入 {{site.data.keyword.Bluemix_notm}} 帳戶](#add_users)。
4.  從**存取原則**中，於**角色**列的**動作**欄下，展開並按一下**編輯原則**。
5.  從**服務**下拉清單中，選取 **{{site.data.keyword.containershort_notm}}**。
6.  從**地區**下拉清單中，選取您要變更其原則的地區。
7.  從**服務實例**下拉清單中，選取您要變更其原則的叢集。若要尋找特定叢集的 ID，請執行 `bx cs clusters`。
8.  在**選取角色**區段中，按一下您要變更使用者存取權的角色。若要尋找每個角色的支援動作清單，請參閱[必要 {{site.data.keyword.containershort_notm}} 存取原則及許可權的概觀](#access_ov)。
9.  按一下**儲存**，以儲存您的變更。

### 將使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶
{: #add_users}

您可以將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶，以授與對叢集的存取權。

開始之前，請驗證您已獲指派 {{site.data.keyword.Bluemix_notm}} 帳戶的「管理員」Cloud Foundry 角色。

1.  選取您要新增使用者的 {{site.data.keyword.Bluemix_notm}} 帳戶。
2.  從功能表列中，按一下**管理** > **安全** > **身分及存取**。「使用者」視窗會顯示一份使用者清單，其中包含其電子郵件位址以及對所選取帳戶的現行狀態。
3.  按一下**邀請使用者**。
4.  在**電子郵件位址** 中，輸入您要新增至 {{site.data.keyword.Bluemix_notm}} 帳戶之使用者的電子郵件位址。
5.  在**存取**區段中，展開**服務**。
6.  從**指派存取權**下拉清單中，決定您只要將存取權授與 {{site.data.keyword.containershort_notm}} 帳戶（**資源**），還是授與您帳戶內各種資源的集合（**資源群組**）。
7.  如果是**資源**：
    1. 從**服務**下拉清單中，選取 **{{site.data.keyword.containershort_notm}}**。
    2. 從**地區**下拉清單中，選取您要邀請使用者加入的地區。
    3. 從**服務實例**下拉清單中，選取您要邀請使用者加入的叢集。若要尋找特定叢集的 ID，請執行 `bx cs clusters`。
    4. 在**選取角色**區段中，按一下您要變更使用者存取權的角色。若要尋找每個角色的支援動作清單，請參閱[必要 {{site.data.keyword.containershort_notm}} 存取原則及許可權的概觀](#access_ov)。
8. 如果是**資源群組**：
    1. 從**資源群組**下拉清單中，選取包括您帳戶之 {{site.data.keyword.containershort_notm}} 資源許可權的資源群組。
    2. 從**指派對資源群組的存取權**下拉清單中，選取您要受邀使用者具有的角色。若要尋找每個角色的支援動作清單，請參閱[必要 {{site.data.keyword.containershort_notm}} 存取原則及許可權的概觀](#access_ov)。
9. 選用項目：若要容許此使用者將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶，請將 Cloud Foundry 組織角色指派給使用者。
    1. 在 **Cloud Foundry 角色**區段中，從**組織**下拉清單中，選取您要授與使用者許可權的組織。
    2. 從**組織角色**下拉清單中，選取**管理員**。
    3. 從**地區**下拉清單中，選取您要授與使用者許可權的地區。
    4. 從**空間**下拉清單中，選取您要授與使用者許可權的空間。
    5. 從**空間角色**下拉清單中，選取**管理員**。
10. 按一下**邀請使用者**。

<br />


## 更新 Kubernetes 主節點
{: #cs_cluster_update}

Kubernetes 會定期更新[主要、次要及修補程式版本](cs_versions.html#version_types)，這會影響您的叢集。更新叢集是包含兩個步驟的程序。首先，您必須更新 Kubernetes 主節點，然後即可更新每個工作者節點。

依預設，Kibernetes 主節點無法更新超過兩個次要版本。例如，如果現行主節點是 1.5 版，而您要更新至 1.8，則必須先更新至 1.7。您可以強制更新繼續進行，但更新超過兩個次要版本可能會造成非預期的結果。

**注意**：請遵循更新指示，並使用測試叢集來解決更新期間的潛在應用程式中斷及岔斷。您無法將叢集回復至舊版。

進行_主要_ 或_次要_ 更新時，請完成下列步驟。

1. 檢閱 [Kubernetes 變更](cs_versions.html)，並更新標示為_在主節點之前更新_ 的任何項目。
2. 使用 GUI 或執行 [CLI 指令](cs_cli_reference.html#cs_cluster_update)來更新 Kubernetes 主節點。當您更新 Kubernetes 主節點時，主節點會關閉大約 5 - 10 分鐘。在更新期間，您無法存取或變更叢集。不過，叢集使用者部署的工作者節點、應用程式和資源不會修改，並將繼續執行。
3. 確認更新已完成。在 {{site.data.keyword.Bluemix_notm}} 儀表板上檢閱 Kubernetes 版本，或執行 `bx cs clusters`。

當 Kubernetes 主節點更新完成時，您可以更新工作者節點。

<br />


## 更新工作者節點
{: #cs_cluster_worker_update}

當 IBM 自動將修補程式套用至 Kubernetes 主節點時，您必須明確地更新工作者節點以進行主要及次要更新。工作者節點版本不能高於 Kubernetes 主節點。

**注意**：更新工作者節點可能會導致應用程式及服務關閉：
- 如果資料未儲存在 Pod 外，便會刪除資料。
- 在您的部署中，使用[抄本 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas)，在可用節點上重新排定 Pod。

更新正式作業層次叢集：
- 為了協助避免應用程式關閉，更新程序會阻止在更新期間於工作者節點上排定 Pod。如需相關資訊，請參閱 [`kubectl drain` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#drain)。
- 使用測試叢集驗證您的工作負載及交付處理程序不受更新的影響。您無法將工作者節點回復至舊版。
- 正式作業層次叢集應該有撐過工作者節點失敗存活下來的能力。如果您的叢集沒有，請在更新叢集之前，先新增工作者節點。
- 要求升級多個工作者節點時，會執行漸進式更新。叢集中可同時升級的工作者節點總數上限為 20 %。升級程序會等待工作者節點完成升級後，另一個工作者才開始升級。


1. 安裝符合 Kubernetes 主節點之 Kubernetes 版本的 [`kibectl cli` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 版本。

2. 進行 [Kubernetes 變更](cs_versions.html)中標示為_在主節點之後更新_ 的任何變更。

3. 更新您的工作者節點：
  * 若要從 {{site.data.keyword.Bluemix_notm}} 儀表板更新，請導覽至叢集的`工作者節點`區段，然後按一下`更新工作者`。
  * 若要取得工作者節點 ID，請執行 `bx cs wokers<cluster_name_or_id>`。如果您選取多個工作者節點，則會一次更新一個工作者節點。

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. 確認更新已完成：
  * 在 {{site.data.keyword.Bluemix_notm}} 儀表板上檢閱 Kubernetes 版本，或執行 `bx cs workers<cluster_name_or_id>`。
  * 執行 `kudectl get nodes` 來檢閱工作者節點的 Kibernets 版本。
  * 在部分情況下，較舊的叢集可能在更新之後將重複的工作者節點列為 **NotReady** 狀態。若要移除重複項目，請參閱[疑難排解](cs_troubleshoot.html#cs_duplicate_nodes)。

完成更新之後：
  - 對其他叢集重複更新程序。
  - 通知在叢集內工作的開發人員，將 `kubectl` CLI 更新至 Kubernetes 主節點的版本。
  - 如果 Kubernetes 儀表板未顯示使用率圖形，則會[刪除 `kudbe-dashboard` Pod](cs_troubleshoot.html#cs_dashboard_graphs)。

<br />


## 將子網路新增至叢集
{: #cs_cluster_subnet}

將子網路新增至叢集，以變更可用的可攜式公用或專用 IP 位址的儲存區。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以將網路子網路新增至叢集，為 Kubernetes 服務新增穩定的可攜式 IP。當您建立標準叢集時，{{site.data.keyword.containershort_notm}} 會自動佈建 1 個可攜式公用子網路（含 5 個公用 IP 位址）及 1 個可攜式專用子網路（含 5 個專用 IP 位址）。可攜式公用及專用 IP 位址是靜態的，不會在移除工作者節點或甚至叢集時變更。

將其中一個可攜式公用 IP 位址及其中一個可攜式專用 IP 位址用於 [Ingress 控制器](cs_apps.html#cs_apps_public_ingress)，您可以使用 Ingress 控制器，公開叢集中的多個應用程式。藉由[建立負載平衡器服務](cs_apps.html#cs_apps_public_load_balancer)，即可使用其餘 4 個可攜式公用 IP 位址及 4 個可攜式專用 IP 位址，將單一應用程式公開給大眾使用。

**附註：**可攜式公用 IP 位址是按月收費。如果您選擇在佈建叢集之後移除可攜式公用 IP 位址，則仍需要按月支付費用，即使您僅短時間使用。

### 要求叢集的其他子網路
{: #add_subnet}

您可以藉由將子網路指派給叢集，來為叢集新增穩定的可攜式公用或專用 IP。

若為「{{site.data.keyword.Bluemix_dedicated_notm}}」使用者，您必須[開立支援問題單](/docs/support/index.html#contacting-support)來建立子網路，然後使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 指令將子網路新增至叢集，而不是使用此作業。

開始之前，請確定您可以透過 {{site.data.keyword.Bluemix_notm}} GUI 存取 IBM Cloud 基礎架構 (SoftLayer) 組合。若要存取組合，您必須設定或使用現有的「{{site.data.keyword.Bluemix_notm}} 隨收隨付制」帳戶。

1.  從型錄中，選取**基礎架構**區段中的**網路**。
2.  選取**子網路/IP**，然後按一下**建立**。
3.  從**選取要新增至此帳戶的子網路類型**下拉功能表中，選取**可攜式公用**或**可攜式專用**。
4.  從可攜式子網路中，選取您要新增的 IP 位址數目。

    **附註：**當您新增子網路的可攜式 IP 位址時，會使用三個 IP 位址來建立叢集內部網路，因此，您無法將它們用於 Ingress 控制器，或是使用它們來建立負載平衡器服務。例如，如果您要求八個可攜式公用 IP 位址，則可以使用其中的五個將您的應用程式公開給大眾使用。

5.  選取您要將可攜式公用或專用 IP 位址遞送至其中的公用或專用 VLAN。您必須選取現有工作者節點所連接的公用或專用 VLAN。請檢閱工作者節點的公用或專用 VLAN。

    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  完成問卷，然後按一下**下單**。

    **附註：**可攜式公用 IP 位址是按月收費。如果您在建立可攜式公用 IP 位址之後選擇將它移除，則仍必須按月支付費用，即使您只使用不到一個月。

7.  佈建子網路之後，讓子網路可供 Kubernetes 叢集使用。
    1.  從「基礎架構」儀表板中，選取您已建立的子網路，並記下子網路的 ID。
    2.  登入 {{site.data.keyword.Bluemix_notm}} CLI。若要指定 {{site.data.keyword.Bluemix_notm}} 地區，請[包括 API 端點](cs_regions.html#bluemix_regions)。

        ```
        bx login
        ```
        {: pre}

        **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

    3.  列出帳戶中的所有叢集，並記下您要在其中使用子網路的叢集的 ID。

        ```
        bx cs clusters
        ```
        {: pre}

    4.  將子網路新增至叢集。當您將子網路設為可供叢集使用時，會自動建立 Kubernetes 配置對映，其中包括您可以使用的所有可用的可攜式公用或專用 IP 位址。如果您的叢集沒有 Ingress 控制器，則會自動使用某個可攜式公用 IP 位址來建立公用 Ingress 控制器，以及自動使用某個可攜式專用 IP 位址來建立專用 Ingress 控制器。所有其他可攜式公用或專用 IP 位址，則可用來為您的應用程式建立負載平衡器服務。

        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  驗證子網路已順利新增至叢集。子網路 CIDR 列在 **VLAN** 區段中。

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### 將自訂及現有子網路新增至 Kubernetes 叢集
{: #custom_subnet}

您可以將現有可攜式公用或專用子網路新增至 Kubernetes 叢集。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

如果 IBM Cloud 基礎架構 (SoftLayer) 組合中的現有子網路具有自訂防火牆規則或您要使用的可用 IP 位址，則請建立沒有子網路的叢集，並在叢集佈建時，將現有子網路設為可供叢集使用。

1.  識別要使用的子網路。請記下子網路的 ID 及 VLAN ID。在此範例中，子網路 ID 是 807861，而 VLAN ID 是 1901230。

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public      
    
    ```
    {: screen}

2.  確認 VLAN 所在的位置。在此範例中，位置是 dal10。

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10 
    ```
    {: screen}

3.  使用您所識別的位置及 VLAN ID 來建立叢集。包括 `--no-subnet` 旗標，以防止自動建立新的可攜式公用 IP 子網路及新的可攜式專用 IP 子網路。

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  驗證已要求建立叢集。

    ```
    bx cs clusters
    ```
    {: pre}

    **附註：**訂購工作者節點機器，並在您的帳戶中設定及佈建叢集，最多可能需要 15 分鐘。

    叢集佈建完成之後，叢集的狀態會變更為 **deployed**。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3   
    ```
    {: screen}

5.  檢查工作者節點的狀態。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    工作者節點備妥後，狀態會變更為 **Normal**，而且狀態為 **Ready**。當節點狀態為 **Ready** 時，您就可以存取叢集。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  指定子網路 ID，以將子網路新增至叢集。當您讓叢集可以使用子網路時，會自動建立 Kubernetes 配置對映，其中包括您可以使用的所有可用的可攜式公用 IP 位址。如果您的叢集還沒有 Ingress 控制器，會自動使用某個可攜式公用 IP 位址來建立 Ingress 控制器。所有其他可攜式公用 IP 位址，則可用來為您的應用程式建立負載平衡器服務。

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### 將使用者管理的子網路及 IP 位址新增至 Kubernetes 叢集
{: #user_subnet}

從您想要 {{site.data.keyword.containershort_notm}} 存取的內部部署網路，提供您自己的子網路。然後，您可以將來自該個子網路的專用 IP 位址，新增到 Kubernetes 叢集中的負載平衡器服務。

需求：
- 使用者管理的子網路只能新增至專用 VLAN。
- 子網路字首長度限制為 /24 到 /30。例如，`203.0.113.0/24` 指定 253 個可用的專用 IP 位址，而 `203.0.113.0/30` 指定 1 個可用的專用 IP 位址。
- 子網路中的第一個 IP 位址必須用來作為子網路的閘道。

開始之前：請配置網路資料流量進出外部子網路的遞送。此外，請確認您在內部部署資料中心閘道裝置與 IBM Cloud 基礎架構 (SoftLayer) 組合中的專用網路 Vyatta 之間具有 VPN 連線功能。如需相關資訊，請參閱此[部落格文章 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。

1. 檢視叢集「專用 VLAN」的 ID。找出 **VLAN** 區段。在 **User-managed** 欄位中，將 VLAN ID 識別為 _false_。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. 將外部子網路新增至您的專用 VLAN。可攜式專用 IP 位址會新增至叢集的配置對映。

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    範例：

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. 驗證已新增使用者提供的子網路。**User-managed** 欄位為 _true_。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. 新增專用負載平衡器，以透過專用網路存取您的應用程式。如果您要使用來自所新增之子網路的專用 IP 位址，在建立專用負載平衡器時必須指定 IP 位址。否則，會從 IBM Cloud 基礎架構 (SoftLayer) 子網路或專用 VLAN 上使用者提供的子網路中，隨機選擇一個 IP 位址。如需相關資訊，請參閱[配置應用程式的存取](cs_apps.html#cs_apps_public_load_balancer)。

    具有指定 IP 位址的專用負載平衡器服務的範例配置檔：

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <myservice>
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    spec:
      type: LoadBalancer
      selector:
        <selectorkey>:<selectorvalue>
      ports:
       - protocol: TCP
         port: 8080
      loadBalancerIP: <private_ip_address>
    ```
    {: codeblock}

<br />


## 使用叢集中的現有 NFS 檔案共用
{: #cs_cluster_volume_create}

如果您要使用 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的現有 NFS 檔案共用與 Kubernetes 搭配使用，則可以藉由在現有 NFS 檔案共用上建立持續性磁區來進行。持續性磁區是實際硬體的一部分，可作為 Kubernetes 叢集資源，並可供叢集使用者使用。
{:shortdesc}

Kubernetes 會區分代表實際硬體的持續性磁區與通常由叢集使用者所起始之儲存要求的持續性磁區宣告。下圖說明持續性磁區與持續性磁區宣告之間的關係。

![建立持續性磁區及持續性磁區宣告](images/cs_cluster_pv_pvc.png)

 如圖所示，若要啟用與 Kubernetes 搭配使用的現有 NFS 檔案共用時，您必須建立具有特定大小及存取模式的持續性磁區，以及建立與持續性磁區規格相符的持續性磁區宣告。如果持續性磁區與持續性磁區宣告相符，它們會彼此連結。叢集使用者只能使用連結的持續性磁區宣告，將磁區裝載至 Pod。此處理程序稱為靜態佈建的持續性儲存空間。

開始之前，請確定您有可用來建立持續性磁區的現有 NFS 檔案共用。

**附註：**靜態佈建持續性儲存空間只適用於現有 NFS 檔案共用。如果您沒有現有 NFS 檔案共用，叢集使用者可以使用[動態佈建](cs_apps.html#cs_apps_volume_claim)處理程序來新增持續性磁區。

若要建立持續性磁區及相符的持續性磁區宣告，請遵循下列步驟。

1.  在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中，查閱您要建立持續性磁區物件的 NFS 檔案共用的 ID 及路徑。
    1.  登入您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶。
    2.  按一下**儲存空間**。
    3.  按一下**檔案儲存空間**，記下您要使用的 NFS 檔案共用的 ID 及路徑。
2.  開啟您偏好的編輯器。
3.  建立持續性磁區的儲存空間配置檔。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.softlayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>表 8. 瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>輸入您要建立的持續性磁區物件的名稱。</td>
    </tr>
    <tr>
    <td><code>儲存空間</code></td>
    <td>輸入現有 NFS 檔案共用的儲存空間大小。儲存空間大小必須以 GB 為單位寫入（例如，20Gi (20 GB) 或 1000Gi (1 TB)），而且大小必須符合現有檔案共用的大小。</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>存取模式可定義將持續性磁區宣告裝載至工作者節點的方式。<ul><li>ReadWriteOnce (RWO)：持續性磁區只能裝載至單一工作者節點中的 Pod。裝載至此持續性磁區的 Pod 可以讀取及寫入磁區。</li><li>ReadOnlyMany (ROX)：持續性磁區可以裝載至在多個工作者節點上管理的 Pod。裝載至此持續性磁區的 Pod 只能讀取磁區。</li><li>ReadWriteMany (RWX)：此持續性磁區可以裝載至在多個工作者節點上管理的 Pod。裝載至此持續性磁區的 Pod 可以讀取及寫入磁區。</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>輸入 NFS 檔案共用伺服器 ID。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>輸入您要建立持續性磁區物件的 NFS 檔案共用的路徑。</td>
    </tr>
    </tbody></table>

4.  在叢集中建立持續性磁區物件。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    範例

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

5.  驗證已建立持續性磁區。

    ```
    kubectl get pv
    ```
    {: pre}

6.  建立另一個配置檔來建立持續性磁區宣告。為了讓持續性磁區宣告符合您先前建立的持續性磁區物件，您必須對 `storage` 及 `accessMode` 選擇相同的值。`storage-class` 欄位必須是空的。如果其中有任何欄位不符合持續性磁區，則會改為自動建立新的持續性磁區。

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

7.  建立持續性磁區宣告。

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

8.  驗證持續性磁區宣告已建立並連結至持續性磁區物件。此處理程序可能需要幾分鐘的時間。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    您的輸出會與下列內容類似。

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


您已順利建立持續性磁區物件，並將其連結至持續性磁區宣告。叢集使用者現在可以[將持續性磁區宣告裝載](cs_apps.html#cs_apps_volume_mount)至其 Pod，並開始讀取及寫入至持續性磁區物件。

<br />


## 配置叢集記載
{: #cs_logging}

日誌可協助您對叢集及應用程式的問題進行疑難排解。有時，您可能想要將日誌傳送至用來處理或長期儲存的特定位置。在 {{site.data.keyword.containershort_notm}} 的 Kubernetes 叢集上，您可以針對叢集啟用日誌轉遞，並選擇日誌的轉遞位置。**附註**：只有標準叢集支援日誌轉遞。
{:shortdesc}

### 檢視日誌
{: #cs_view_logs}

若要檢視叢集及容器的日誌，您可以使用標準 Kubernetes 及 Docker 記載特性。
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

若為標準叢集，日誌位於您在建立 Kubernetes 叢集時所登入的 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您在建立叢集時指定了 {{site.data.keyword.Bluemix_notm}} 空間，則日誌位於該空間中。容器日誌是在容器外進行監視及轉遞。您可以使用 Kibana 儀表板來存取容器的日誌。如需記載的相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 的記載功能](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

**附註**：如果日誌位於您在建立叢集時所指定的空間，則帳戶擁有者必須對該空間具有「管理員」、「開發人員」或「審核員」許可權，才能檢視日誌。如需變更 {{site.data.keyword.containershort_notm}} 存取原則及許可權的相關資訊，請參閱[管理叢集存取](cs_cluster.html#cs_cluster_user)。在變更許可權之後，日誌最多需要 24 小時才會開始出現。

若要存取 Kibana 儀表板，請移至下列其中一個 URL，然後選取您建立叢集所在的 {{site.data.keyword.Bluemix_notm}} 帳戶或空間。
- 美國南部及美國東部：https://logging.ng.bluemix.net
- 英國南部或歐盟中部：https://logging.eu-fra.bluemix.net

如需檢視日誌的相關資訊，請參閱[從 Web 瀏覽器導覽至 Kibana](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)。

#### Docker 日誌
{: #cs_view_logs_docker}

您可以運用內建 Docker 記載功能來檢閱標準 STDOUT 及 STDERR 輸出串流的活動。如需相關資訊，請參閱[檢視在 Kubernetes 叢集中執行的容器的容器日誌](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

### 針對 Docker 容器名稱空間配置日誌轉遞
{: #cs_configure_namespace_logs}

依預設，{{site.data.keyword.containershort_notm}} 會將 Docker 容器名稱空間日誌轉遞給 {{site.data.keyword.loganalysislong_notm}}。您也可以建立新的日誌轉遞配置，將容器名稱空間日誌轉遞至外部 syslog 伺服器。
{:shortdesc}

**附註**：若要檢視雪梨位置的日誌，您必須將日誌轉遞至外部 syslog 伺服器。

#### 啟用對 syslog 的日誌轉遞
{: #cs_namespace_enable}

開始之前：

1. 使用下列兩種方式之一來設定可接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。
  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集中執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。

2. [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)名稱空間所在的叢集。

若要將名稱空間日誌轉遞至 syslog 伺服器，請執行下列動作：

1. 建立記載配置。

    ```
    bx cs logging-config-create <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 9. 瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>用來為您的名稱空間建立日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--namespace <em>&lt;my_namespace&gt;</em></code></td>
    <td>將 <em>&lt;my_namespace&gt;</em> 取代為名稱空間的名稱。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。如果未指定名稱空間，則容器中的所有名稱空間都會使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>將 <em>&lt;log_server_hostname&gt;</em> 取代為日誌收集器伺服器的主機名稱或 IP 位址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>將 <em>&lt;log_server_port&gt;</em> 取代為日誌收集器伺服器的埠。如果您未指定埠，則會將標準埠 <code>514</code> 用於 syslog。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>syslog 的日誌類型。</td>
    </tr>
    </tbody></table>

2. 驗證已建立日誌轉遞配置。

    * 列出叢集中的所有記載配置：
      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      輸出範例：

      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

    * 僅列出名稱空間記載配置：
      ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
      {: pre}

      輸出範例：

      ```
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

#### 更新 syslog 伺服器配置
{: #cs_namespace_update}

如果您想要更新現行 syslog 伺服器配置的詳細資料，或變更為不同的 syslog 伺服器，您可以更新記載轉遞配置。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為名稱空間所在的叢集。

1. 更新日誌轉遞配置。

    ```
    bx cs logging-config-update <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 10. 瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>用來為您的名稱空間更新日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--namepsace <em>&lt;my_namespace&gt;</em></code></td>
    <td>將 <em>&lt;my_namespace&gt;</em> 取代為具有記載配置之名稱空間的名稱。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>將 <em>&lt;log_server_hostname&gt;</em> 取代為日誌收集器伺服器的主機名稱或 IP 位址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>將 <em>&lt;log_server_port&gt;</em> 取代為日誌收集器伺服器的埠。如果您未指定埠，則會使用標準埠 <code>514</code>。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td><code>syslog</code> 的記載類型。</td>
    </tr>
    </tbody></table>

2. 驗證已更新日誌轉遞配置。
    ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
    {: pre}

    輸出範例：

    ```
    Namespace         Host             Port    Protocol
    default           myhostname.com   5514    syslog
    my-namespace      localhost        5514    syslog
    ```
    {: screen}

#### 停止對 syslog 的日誌轉遞
{: #cs_namespace_delete}

您可以刪除記載配置，來停止從名稱空間轉遞日誌。

**附註**：這個動作只會刪除將日誌轉遞至 syslog 伺服器的配置。名稱空間的日誌會繼續轉遞至 {{site.data.keyword.loganalysislong_notm}}。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為名稱空間所在的叢集。

1. 刪除記載配置。

    ```
    bx cs logging-config-rm <my_cluster> --namespace <my_namespace>
    ```
    {: pre}
    將 <em>&lt;my_cluster&gt;</em> 取代為記載配置所在叢集的名稱，並將 <em>&lt;my_namespace&gt;</em> 取代為名稱空間的名稱。


### 針對應用程式、工作者節點、Kubernetes 系統元件及 Ingress 控制器配置日誌轉遞
{: #cs_configure_log_source_logs}

依預設，{{site.data.keyword.containershort_notm}} 會將 Docker 容器名稱空間日誌轉遞給 {{site.data.keyword.loganalysislong_notm}}。您也可以針對其他日誌來源（例如應用程式、工作者節點、Kubernetes 叢集及 Ingress 控制器）配置日誌轉遞。
{:shortdesc}

如需每一個日誌來源的相關資訊，請檢閱下列選項。

|日誌來源|特徵|日誌路徑|
|----------|---------------|-----|
|`application`|在 Kubernetes 叢集中執行之自己的應用程式的日誌。|`/var/log/apps/**/*.log`、`/var/log/apps/**/*.err`
|`worker`|Kubernetes 叢集內虛擬機器工作者節點的日誌。|`/var/log/syslog`、`/var/log/auth.log`
|`kubernetes`|Kubernetes 系統元件的日誌。|`/var/log/kubelet.log`、`/var/log/kube-proxy.log`
|`ingress`|管理進入 Kubernetes 叢集的網路資料流量的 Ingress 控制器的日誌。|`/var/log/alb/ids/*.log`、`/var/log/alb/ids/*.err`、`/var/log/alb/customerlogs/*.log`、`/var/log/alb/customerlogs/*.err`
{: caption="表 11. 日誌來源特徵" caption-side="top"}

#### 啟用應用程式的日誌轉遞
{: #cs_apps_enable}

來自應用程式的日誌必須限制為主機節點上的特定目錄。您可以使用裝載路徑，將主機路徑磁區裝載至您的容器，來執行此動作。此裝載路徑可充當容器上應用程式日誌傳送至其中的目錄。建立磁區裝載時，會自動建立預先定義的主機路徑目錄 (`/var/log/apps`)。

請檢閱應用程式日誌轉遞的下列各層面：
* 從 /var/log/apps 路徑遞迴地讀取日誌。這表示可以將應用程式日誌放入 /var/log/apps 路徑的子目錄中。
* 只會轉遞副檔名為 `.log` 或 `.err` 的應用程式日誌檔。
* 第一次啟用日誌轉遞時，應用程式日誌會加在後面，而不是從頭讀取。這表示在啟用應用程式記載之前，已存在之所有日誌的內容都不會被讀取。日誌是從啟用記載的時間點開始讀取。不過，在第一次啟用日誌轉遞之後，一律會從前次離開的位置來挑選日誌。
* 當您將 `/var/log/apps` 主機路徑磁區裝載至容器時，容器全都會寫入至這個相同的目錄。這表示如果您的容器寫入至相同的檔名，則容器會寫入至主機上完全相同的檔案。如果這不是您的本意，您可以使用不同方式命名來自每一個容器的日誌檔，以防止容器改寫相同的日誌檔。
* 因為所有容器都會寫入至相同的檔名，所以請不要使用此方法來轉遞 ReplicaSets 的應用程式日誌。反之，您可以將應用程式中的日誌寫入至 STDOUT 及 STDERR。系統會挑選這些日誌作為容器日誌，而且容器日誌會自動轉遞至 {{site.data.keyword.loganalysisshort_notm}}。若要將寫入至 STDOUT 及 STDERR 的應用程式日誌改為轉遞至外部 syslog 伺服器，請遵循[啟用對 syslog 的日誌轉遞](cs_cluster.html#cs_namespace_enable)中的步驟。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

1. 開啟應用程式 Pod 的 `.yaml` 配置檔。

2. 將下列 `volumeMounts` 及 `volumes` 新增至配置檔：

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. 將磁區裝載至 Pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. 若要建立日誌轉遞配置，請遵循[啟用工作者節點、Kubernetes 系統元件及 Ingress 控制器的日誌轉遞](cs_cluster.html#cs_log_sources_enable)中的步驟。

#### 啟用工作者節點、Kubernetes 系統元件及 Ingress 控制器的日誌轉遞
{: #cs_log_sources_enable}

您可以將日誌轉遞至 {{site.data.keyword.loganalysislong_notm}} 或轉遞至外部 syslog 伺服器。如果您將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}}，則它們會轉遞至您在其中建立叢集的同一個空間。如果您要將某個日誌來源中的日誌轉遞至這兩個日誌收集器伺服器，則必須建立兩個記載配置。
{:shortdesc}

開始之前：

1. 如果您要將日誌轉遞至外部 syslog 伺服器，可以使用下列兩種方式來設定接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。
  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集中執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。**附註**：若要檢視雪梨位置的日誌，您必須將日誌轉遞至外部 syslog 伺服器。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

若要啟用工作者節點、Kubernetes 系統元件或 Ingress 控制器的日誌轉遞，請執行下列動作：

1. 建立日誌轉遞配置。

  * 若要將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}}，請執行下列指令：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --type ibm
    ```
    {: pre}
將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。將 <em>&lt;my_log_source&gt;</em> 取代為日誌來源。接受的值為 `application`、`worker`、`kubernetes` 及 `ingress`。  * 若要將日誌轉遞至外部 syslog 伺服器，請執行下列指令：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 12. 瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>用來為您的日誌來源建立 syslog 日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>將 <em>&lt;my_log_source&gt;</em> 取代為日誌來源。接受的值為 <code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>將 <em>&lt;log_server_hostname&gt;</em> 取代為日誌收集器伺服器的主機名稱或 IP 位址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>將 <em>&lt;log_server_port&gt;</em> 取代為日誌收集器伺服器的埠。如果您未指定埠，則會將標準埠 <code>514</code> 用於 syslog。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>外部 syslog 伺服器的日誌類型。</td>
    </tr>
    </tbody></table>

2. 驗證已建立日誌轉遞配置。

    * 若要列出叢集中的所有記載配置，請執行下列指令：
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      輸出範例：

      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

    * 若要列出某種類型日誌來源的記載配置，請執行下列指令：
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      輸出範例：

      ```
      Id                                    Source      Host        Port   Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker      localhost   5514   syslog     /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker      -           -      ibm        /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### 更新日誌收集器伺服器
{: #cs_log_sources_update}

您可以藉由變更日誌收集器伺服器或日誌類型，來更新應用程式、工作者節點、Kubernetes 系統元件及 Ingress 控制器的記載配置。
{: shortdesc}

**附註**：若要檢視雪梨位置的日誌，您必須將日誌轉遞至外部 syslog 伺服器。

開始之前：

1. 如果您要將日誌收集器伺服器變更為 syslog，可以使用下列兩種方式來設定接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。
  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集中執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

若要變更日誌來源的日誌收集器伺服器，請執行下列動作：

1. 更新記載配置。

    ```
    bx cs logging-config-update <my_cluster> --id <log_source_id> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>表 13. 瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>用來為您的日誌來源更新日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_source_id&gt;</em></code></td>
    <td>將 <em>&lt;log_source_id&gt;</em> 取代為日誌來源配置的 ID。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>將 <em>&lt;my_log_source&gt;</em> 取代為日誌來源。接受的值為 <code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>將 <em>&lt;log_server_hostname&gt;</em> 取代為日誌收集器伺服器的主機名稱或 IP 位址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>將 <em>&lt;log_server_port&gt;</em> 取代為日誌收集器伺服器的埠。如果您未指定埠，則會將標準埠 <code>514</code> 用於 syslog。</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>將 <em>&lt;logging_type&gt;</em> 取代為您要使用的新日誌轉遞通訊協定。目前支援 <code>syslog</code> 和 <code>ibm</code>。</td>
    </tr>
    </tbody></table>

2. 驗證已更新日誌轉遞配置。

  * 若要列出叢集中的所有記載配置，請執行下列指令：
    ```
    bx cs logging-config-get <my_cluster>
    ```
    {: pre}

    輸出範例：

    ```
    Logging Configurations
    ---------------------------------------------
    Id                                    Source        Host             Port    Protocol   Paths
    f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
    5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

    Container Log Namespace configurations
    ---------------------------------------------
    Namespace         Host             Port    Protocol
    default           myhostname.com   5514    syslog
    my-namespace      localhost        5514    syslog
    ```
    {: screen}

  * 若要列出某種類型日誌來源的記載配置，請執行下列指令：
    ```
    bx cs logging-config-get <my_cluster> --logsource worker
    ```
    {: pre}

    輸出範例：

    ```
    Id                                    Source      Host        Port   Protocol   Paths
    f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker      localhost   5514   syslog     /var/log/syslog,/var/log/auth.log
    5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker      -           -      ibm        /var/log/syslog,/var/log/auth.log
    ```
    {: screen}

#### 停止日誌轉遞
{: #cs_log_sources_delete}

您可以藉由刪除記載配置來停止轉遞日誌。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

1. 刪除記載配置。

    ```
    bx cs logging-config-rm <my_cluster> --id <log_source_id>
    ```
    {: pre}
    將 <em>&lt;my_cluster&gt;</em> 取代為記載配置所在的叢集的名稱，並將 <em>&lt;log_source_id&gt;</em> 取代為日誌來源配置的 ID。

## 配置叢集監視
{: #cs_monitoring}

度量值可以協助您監視叢集的性能及效能。您可以配置工作者節點的性能監視，以自動偵測並更正任何進入欠佳或非作業狀態的工作者。**附註**：只有標準叢集支援監視。
{:shortdesc}

### 檢視度量值
{: #cs_view_metrics}

您可以使用標準 Kubernetes 及 Docker 特性，來監視叢集及應用程式的性能。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}} 中的叢集詳細資料頁面</dt>
<dd>{{site.data.keyword.containershort_notm}} 提供叢集性能及容量以及叢集資源使用情形的相關資訊。您可以使用此 GUI 來橫向擴充叢集、使用持續性儲存空間，以及透過 {{site.data.keyword.Bluemix_notm}} 服務連結將更多功能新增至叢集。若要檢視叢集詳細資料頁面，請移至 **{{site.data.keyword.Bluemix_notm}} 儀表板**，然後選取一個叢集。</dd>
<dt>Kubernetes 儀表板</dt>
<dd>Kubernetes 儀表板是一個管理 Web 介面，可用來檢閱工作者節點的性能、尋找 Kubernetes 資源、部署容器化應用程式，以及使用記載及監視資訊來進行應用程式疑難排解。如需如何存取 Kubernetes 儀表板的相關資訊，請參閱[啟動 {{site.data.keyword.containershort_notm}} 的 Kubernetes 儀表板](cs_apps.html#cs_cli_dashboard)。</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>標準叢集的度量值位於在建立 Kubernetes 叢集時所登入的 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您在建立叢集時指定了 {{site.data.keyword.Bluemix_notm}} 空間，則度量值位於該空間中。會自動收集叢集中所部署的所有容器的容器度量值。這些度量值會透過 Grafana 傳送並設為可供使用。如需度量值的相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 的監視功能](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)。<p>若要存取 Grafana 儀表板，請移至下列其中一個 URL，然後選取您建立叢集所在的 {{site.data.keyword.Bluemix_notm}} 帳戶或空間。<ul><li>美國南部及美國東部：https://metrics.ng.bluemix.net</li><li>英國南部：https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### 其他性能監視工具
{: #cs_health_tools}

您可以配置其他工具來取得更多的監視功能。
<dl>
<dt>Prometheus</dt>
<dd>Prometheus 是一個針對 Kubernetes 所設計的開放程式碼監視、記載及警示工具。此工具會根據 Kubernetes 記載資訊來擷取叢集、工作者節點及部署性能的詳細資訊。如需設定資訊，請參閱[整合服務與 {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_integrations)。</dd>
</dl>

### 針對具有自動回復的工作者節點配置性能監視
{: #cs_configure_worker_monitoring}

{{site.data.keyword.containerlong_notm}} 的「自動回復」系統可以部署至 Kubernetes 1.7 版或更新版本的現有叢集。「自動回復」系統會使用各種檢查來查詢工作者節點性能狀態。如果「自動回復」根據配置的檢查，偵測到性能不佳的工作者節點，則「自動回復」會觸發更正動作，如在工作者節點上重新載入 OS。一次只有一個工作者節點進行一個更正動作。工作者節點必須先順利完成更正動作，然後任何其他工作者節點才能進行更正動作。
**附註**：「自動回復」至少需要一個性能良好的節點，才能正常運作。只在具有兩個以上工作者節點的叢集中，配置具有主動檢查的「自動回復」。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要在其中檢查工作者節點狀態的叢集。

1. 以 JSON 格式建立配置對映檔，以定義您的檢查。例如，下列 YAML 檔案定義三個檢查：一個 HTTP 檢查及兩個 Kubernetes API 伺服器檢查。

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>表 15. 瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>配置名稱 <code>ibm-worker-recovery-checks- checks</code> 是一個常數，且無法變更。</td>
    </tr>
    <tr>
    <td><code>namespace</code></td>
    <td><code>kube-system</code> 名稱空間是一個常數，且無法變更。</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>輸入您要「自動回復」使用的檢查類型。<ul><li><code>HTTP</code>：「自動回復」會呼叫每一個節點上執行的 HTTP 伺服器，以判斷節點是否適當地執行。</li><li><code>KUBEAPI</code>：「自動回復」會呼叫 Kubernetes API 伺服器，並讀取工作者節點所回報的性能狀態資料。</li></ul></td>
    </tr>
    <tr>
    <td><code>Resource</code></td>
    <td>當檢查類型為 <code>KUBEAPI</code> 時，請輸入您要「自動回復」檢查的資源類型。接受的值為 <code>NODE</code> 或 <code>PODS</code>。</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>輸入連續失敗檢查次數的臨界值。符合此臨界值時，「自動回復」會觸發指定的更正動作。例如，如果值為 3，且「自動回復」連續三次無法進行配置的檢查，則「自動回復」會觸發與該檢查相關聯的更正動作。</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>資源類型為 <code>PODS</code> 時，請輸入工作者節點上可以處於 [NotReady ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 狀態之 Pod 的百分比臨界值。此百分比是以排定給工作者節點的 Pod 總數為基礎。當檢查判定性能不佳之 Pod 的百分比大於臨界值時，此檢查會將其算成一次失敗。</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>輸入當符合失敗臨界值時要執行的動作。只有在未修復任何其他工作者，且此工作者節點不在前一個動作的冷卻期內時，才會執行更正動作。<ul><li><code>REBOOT</code>：重新啟動工作者節點。</li><li><code>RELOAD</code>：從全新的 OS 重新載入工作者節點的所有必要配置。</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>輸入「自動回復」必須等待幾秒，才能對已發出更正動作的節點發出另一個更正動作。冷卻期從發出更正動作的時間開始。</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>輸入連續檢查之間的秒數。例如，如果值為 180，則「自動回復」每 3 分鐘會對每一個節點執行一次檢查。</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>輸入在「自動回復」終止呼叫作業之前，對資料庫進行檢查呼叫所花費的秒數上限。<code>TimeoutSeconds</code> 的值必須小於 <code>IntervalSeconds</code> 的值。</td>
    </tr>
    <tr>
    <td><code>Port</code></td>
    <td>檢查類型為 <code>HTTP</code> 時，請輸入工作者節點上 HTTP 伺服器必須連結的埠。此埠必須公開在叢集中每個工作者節點的 IP 上。「自動回復」需要在所有節點之中固定不變的埠號，以檢查伺服器。將自訂伺服器部署至叢集時，請使用 [DaemonSets ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>檢查類型為 <code>HTTP</code> 時，請輸入您預期從檢查傳回的 HTTP 伺服器狀態。例如，值 200 指出您預期伺服器傳回 <code>OK</code> 回應。</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>檢查類型為 <code>HTTP</code> 時，請輸入 HTTP 伺服器所要求的路徑。此值通常是在所有工作者節點上執行之伺服器的度量值路徑。</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>輸入 <code>true</code> 以啟用檢查，或輸入 <code>false</code> 以停用檢查。</td>
    </tr>
    </tbody></table>

2. 在叢集中建立配置對映。

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 使用適當的檢查，驗證您已在 `kube-system` 名稱空間中建立名稱為 `ibm-worker-recovery-checks` 的配置對映。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. 確定您已在 `kube-system` 名稱空間中建立名稱為 `international-registry-docker-secret` 的 Docker 取回 Secret。「自動回復」是在 {{site.data.keyword.registryshort_notm}} 的國際 Docker 登錄中進行管理。如果您尚未建立一個包含國際登錄之有效認證的 Docker 登錄 Secret，請建立一個以執行「自動回復」系統。

    1. 安裝 {{site.data.keyword.registryshort_notm}} 外掛程式。

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. 將目標設為國際登錄。

        ```
        bx cr region-set international
        ```
        {: pre}

    3. 建立國際登錄記號。

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. 將 `INTERNATIONAL_REGISTRY_TOKEN` 環境變數設為您已建立的記號。

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. 將 `DOCKER_EMAIL` 環境變數設為現行使用者。只需要您的電子郵件位址，即可在下一步中執行 `kubectl` 指令。

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. 建立 Docker 取回 Secret。

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. 套用此 YAML 檔案，以將「自動回復」部署至叢集。

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. 幾分鐘之後，您可以檢查下列指令輸出中的 `Events` 區段，以查看「自動回復」部署上的活動。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## 視覺化 Kubernetes 叢集資源
{: #cs_weavescope}

Weave Scope 提供 Kubernetes 叢集內資源（包括服務、Pod、容器、處理程序、節點等項目）的視覺圖。Weave Scope 提供 CPU 及記憶體的互動式度量值，也提供工具來調整並執行至容器。
{:shortdesc}

開始之前：

-   請記住不要在公用網際網路上公開叢集資訊。請完成下列步驟，以安全地部署 Weave Scope，並於本端從 Web 瀏覽器進行存取。
-   如果您還沒有叢集，請[建立標準叢集](#cs_cluster_ui)。Weave Scope 可能需要大量 CPU，特別是應用程式。請搭配執行 Weave Scope 與較大的標準叢集，而非精簡叢集。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。


若要搭配使用 Weave Scope 與叢集，請執行下列動作：
2.  在叢集中部署其中一個提供的 RBAC 許可權配置檔。

    若要啟用讀寫許可權，請執行下列指令：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    若要啟用唯讀許可權，請執行下列動作：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    輸出：

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  部署 Weave Scope 服務（只能透過叢集 IP 位址進行私密存取）。

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    輸出：

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  在您的電腦上執行埠轉遞指令，以啟動服務。既然 Weave Scope 已配置叢集，則下一次存取 Weave Scope 時，您就可以執行此埠轉遞指令，而不需要再次完成先前的配置步驟。

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    輸出：

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  開啟 Web 瀏覽器，並前往 `http://localhost:4040`。若未部署預設元件，您會看到下圖。您可以選擇檢視拓蹼圖，或叢集中的 Kubernetes 資源表格。

     <img src="images/weave_scope.png" alt="來自 Weave Scope 的拓蹼範例" style="width:357px;" />


[進一步瞭解 Weave Scope 特性 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.weave.works/docs/scope/latest/features/)。

<br />


## 移除叢集
{: #cs_cluster_remove}

當您完成叢集時，即可予以移除，讓叢集不再使用資源。
{:shortdesc}

不再需要使用 {{site.data.keyword.Bluemix_notm}} 精簡或「隨收隨付制」帳戶所建立的精簡及標準叢集時，使用者必須手動予以移除。

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
- 如果您使用[現有的檔案共用](#cs_cluster_volume_create)建立了持續性磁區宣告，則在刪除叢集時，無法刪除檔案共用。您必須稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除檔案共用。
- 持續性儲存空間為您的資料提供高可用性。如果刪除它，則無法回復您的資料。
