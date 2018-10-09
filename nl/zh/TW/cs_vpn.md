---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 設定 VPN 連線功能
{: #vpn}

使用 VPN 連線功能，您可以在 {{site.data.keyword.containerlong}} 上將 Kubernetes 叢集裡的應用程式安全地連接至內部部署網路。您也可以將叢集以外的應用程式連接至叢集內執行的應用程式。
{:shortdesc}

若要將工作者節點及應用程式連接至內部部署資料中心，您可以配置下列其中一個選項。

- **strongSwan IPSec VPN 服務**：您可以設定 [strongSwan IPSec VPN 服務 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.strongswan.org/about.html)，以安全地連接 Kubernetes 叢集與內部部署網路。在根據業界標準網際網路通訊協定安全 (IPSec) 通訊協定套組的網際網路上，strongsWan IPSec VPN 服務提供安全的端對端通訊通道。若要設定叢集與內部部署網路之間的安全連線，請直接在叢集的 Pod 中[配置及部署 strongSwan IPSec VPN 服務](#vpn-setup)。

- **Virtual Router Appliance (VRA) 或 Fortigate Security Appliance (FSA)**：您可以選擇設定 [VRA](/docs/infrastructure/virtual-router-appliance/about.html) 或 [FSA](/docs/infrastructure/fortigate-10g/about.html)，以配置 IPSec VPN 端點。當您有較大的叢集、想要透過單一 VPN 存取多個叢集，或需要以路徑為基礎的 VPN 時，此選項十分有用。若要配置 VRA，請參閱[使用 VRA 設定 VPN 連線功能](#vyatta)。

## 使用 strongSwan IPSec VPN 服務 Helm 圖表
{: #vpn-setup}

使用 Helm 圖表，可以在 Kubernetes Pod 中配置及部署 strongSwan IPSec VPN 服務。
{:shortdesc}

因為 strongSwan 已整合在您的叢集內，所以您不需要外部閘道裝置。建立 VPN 連線功能時，會在叢集裡的所有工作者節點上自動配置路徑。這些路線容許透過 VPN 通道在任何工作者節點與遠端系統上的 Pod 之間進行雙向連線。例如，下圖顯示 {{site.data.keyword.containerlong_notm}} 中的應用程式如何透過 strongSwan VPN 連線與內部部署伺服器通訊：

<img src="images/cs_vpn_strongswan.png" width="700" alt="使用負載平衡器，在 {{site.data.keyword.containerlong_notm}} 中公開應用程式" style="width:700px; border-style: none"/>

1. 叢集裡的應用程式 (`myapp`) 會接收來自 Ingress 或 LoadBalancer 服務的要求，且需要安全地連接至內部部署網路中的資料。

2. 向內部部署資料中心發出的要求會轉遞至 IPSec strongSwan VPN Pod。目的地 IP 位址是用來判定要傳送至 IPSec strongSwan VPN Pod 的網路封包。

3. 此要求會加密並透過 VPN 通道傳送至內部部署資料中心。

4. 送入的要求會通過內部部署防火牆，並遞送至解密所在的 VPN 通道端點（路由器）。

5. VPN 通道端點（路由器）會將要求轉遞至內部部署伺服器或大型主機，視步驟 2 中指定的目的地 IP 位址而定。必要資料會藉由相同的處理程序，透過 VPN 連線傳回至 `myapp`。

## strongSwan VPN 服務考量
{: strongswan_limitations}

在使用 strongSwan Helm 圖表之前，請檢閱下列考量及限制。

* strongSwan Helm 圖表需要遠端 VPN 端點啟用 NAT 遍訪。除了預設 IPSec UDP 埠 500 外，NAT 遍訪還需要 UDP 埠 4500。這兩個 UDP 埠都需要容許通過配置的任何防火牆。
* strongSwan Helm 圖表不支援以路徑為基礎的 IPSec VPN。
* strongSwan Helm 圖表支援使用預先共用金鑰的 IPSec VPN，但不支援需要憑證的 IPSec VPN。
* strongSwan Helm 圖表不容許多個叢集和其他 IaaS 資源共用單一 VPN 連線。
* strongSwan Helm 圖表會在叢集內以 Kubernetes Pod 形式執行。Kubernetes 的記憶體及網路用量，以及在叢集裡執行的其他 Pod，都會影響 VPN 效能。如果您具有效能關鍵環境，請考慮使用在叢集以外的專用硬體上執行的 VPN 解決方案。
* strongSwan Helm 圖表會執行單一 VPN Pod，作為 IPSec 通道端點。如果 Pod 失敗，叢集會重新啟動 Pod。不過，當新 Pod 啟動並重新建立 VPN 連線時，您可能遭遇短暫的關閉時間。如果您需要更快速的錯誤回復，或更精心製作的高可用性解決方案，請考慮使用在叢集以外的專用硬體上執行的 VPN 解決方案。
* strongSwan Helm 圖表不會針對流過 VPN 連線的網路資料流量提供度量值或監視。如需所支援監視工具的清單，請參閱[記載及監視服務](cs_integrations.html#health_services)。

## 配置 strongSwan Helm 圖表
{: #vpn_configure}

開始之前：
* [在內部部署資料中心安裝 IPSec VPN 閘道](/docs/infrastructure/iaas-vpn/set-up-ipsec-vpn.html#setting-up-an-ipsec-connection)。
* [建立標準叢集](cs_clusters.html#clusters_cli)。
* [將 Kubernetes CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

### 步驟 1：取得 strongSwan Helm 圖表
{: #strongswan_1}

1. [安裝叢集的 Helm，並將 {{site.data.keyword.Bluemix_notm}} 儲存庫新增至 Helm 實例](cs_integrations.html#helm)。

2. 將 strongSwan Helm 圖表的預設配置設定儲存在本端 YAML 檔案中。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 開啟 `config.yaml` 檔案。

### 步驟 2：配置基本 IPSec 設定
{: #strongswan_2}

若要控制 VPN 連線的建立，請修改下列基本 IPSec 設定。

如需每一個設定的相關資訊，請閱讀 `config.yaml` 檔案內提供的 Helm 圖表文件。
{: tip}

1. 如果您的內部部署 VPN 通道端點不支援使用 `ikev2` 作為起始設定連線的通訊協定，請將 `ipsec.keyexchange` 的值變更為 `ikev1` 或 `ike`。
2. 將 `ipsec.esp` 設為內部部署 VPN 通道端點用於連線之 ESP 加密及鑑別演算法的清單。
    * 如果將 `ipsec.keyexchange` 設為 `ikev1`，則必須指定此設定。
    * 如果將 `ipsec.keyexchange` 設為 `ikev2`，則此設定為選用項目。
    * 如果您將此設定保留空白，則連線會使用預設 strongSwan 演算法 `aes128-sha1,3des-sha1`。
3. 將 `ipsec.ike` 設為內部部署 VPN 通道端點用於連線之 IKE/ISAKMP SA 加密及鑑別演算法的清單。這些演算法必須以特定格式 `encryption-integrity[-prf]-dhgroup` 表示。
    * 如果將 `ipsec.keyexchange` 設為 `ikev1`，則必須指定此設定。
    * 如果將 `ipsec.keyexchange` 設為 `ikev2`，則此設定為選用項目。
    * 如果您將此設定保留空白，則連線會使用預設 strongSwan 演算法 `aes128-sha1-modp2048,3des-sha1-modp1536`。
4. 將 `local.id` 的值變更為您要用來識別 VPN 通道端點所用本端 Kubernetes 叢集端的任何字串。預設值為 `ibm-cloud`。部分 VPN 實作需要您針對本端端點使用公用 IP 位址。
5. 將 `remote.id` 的值變更為您要用來識別 VPN 通道端點所用遠端內部部署端的任何字串。預設值為 `on-prem`。部分 VPN 實作需要您針對遠端端點使用公用 IP 位址。
6. 將 `preshared.secret` 的值變更為內部部署 VPN 通道端點閘道用於連線的預先共用密碼。此值儲存在 `ipsec.secrets` 中。
7. 選用項目：將 `remote.privateIPtoPing` 設為遠端子網路中的任何專用 IP 位址，以便在 Helm 連線功能驗證測試之中進行連線測試。

### 步驟 3：選取入埠或出埠 VPN 連線
{: #strongswan_3}

配置 strongSwan VPN 連線時，您可以選擇 VPN 連線是要入埠至叢集，還是從叢集出埠。
{: shortdesc}

<dl>
<dt>入埠</dt>
<dd>來自遠端網路的內部部署 VPN 端點會起始 VPN 連線，而叢集會接聽連線。</dd>
<dt>出埠</dt>
<dd>叢集會起始 VPN 連線，而來自遠端網路的內部部署 VPN 端點會接聽連線。</dd>
</dl>

若要建立入埠 VPN 連線，請修改下列設定：
1. 驗證 `ipsec.auto` 已設為 `add`。
2. 選用項目：將 `loadBalancerIP` 設為 strongSwan VPN 服務的可攜式公用 IP 位址。當您需要穩定的 IP 位址時（例如，當您必須指定允許哪些 IP 位址通過內部部署防火牆時），指定 IP 位址很有用。叢集必須至少有一個可用的公用「負載平衡器」IP 位址。[您可以查看可用的公用 IP 位址](cs_subnets.html#review_ip)或[釋放已使用的 IP 位址](cs_subnets.html#free)。<br>**附註**：
    * 如果將此設定保留空白，則會使用其中一個可用的可攜式公用 IP 位址。
    * 您也必須配置針對內部部署 VPN 端點上的叢集 VPN 端點選取的公用 IP 位址，或指派給它的公用 IP 位址。

若要建立出埠 VPN 連線，請修改下列設定：
1. 將 `ipsec.auto` 變更為 `start`。
2. 將 `remote.gateway` 設為遠端網路中內部部署 VPN 端點的公用 IP 位址。
3. 為叢集 VPN 端點的 IP 位址選擇下列其中一個選項：
    * **叢集專用閘道的公用 IP 位址**：如果您的工作者節點僅連接至專用 VLAN，則出埠 VPN 要求會透過專用閘道來遞送，以到達網際網路。專用閘道的公用 IP 位址用於 VPN 連線。
    * **strongSwan Pod 執行所在之工作者節點的公用 IP 位址**：如果 strongSwan Pod 執行所在的工作者節點已連接至公用 VLAN，則工作者節點的公用 IP 位址會用於 VPN 連線。<br>**附註**：
        * 如果 strongSwan Pod 已遭刪除，並重新排定至叢集裡的不同工作者節點，則 VPN 的公用 IP 位址會變更。遠端網路的內部部署 VPN 端點必須容許從任何叢集工作者節點的公用 IP 位址建立 VPN 連線。
        * 如果遠端 VPN 端點無法處理來自多個公用 IP 位址的 VPN 連線，請限制 strongSwan VPN Pod 部署至的節點。將 `nodeSelector` 設為特定工作者節點的 IP 位址或工作者節點標籤。例如，值 `kubernetes.io/hostname: 10.232.xx.xx` 容許 VPN Pod 僅部署至該工作者節點。`strongswan: vpn` 值將 VPN Pod 限制為只能在具有該標籤的任何工作者節點上執行。您可以使用任何工作者節點標籤。若要容許不同的工作者節點與不同的 Helm 圖表部署搭配使用，請使用 `strongswan: <release_name>`。如需高可用性，請至少選取兩個工作者節點。
    * **strongSwan 服務的公用 IP 位址**：若要使用 strongSwan VPN 服務的 IP 位址來建立連線，請將 `connectUsingLoadBalancerIP` 設為 `true`。strongSwan 服務 IP 位址是您可在 `loadBalancerIP` 設定中指定的可攜式公用 IP 位址，或是自動指派給服務的可用可攜式公用 IP 位址。<br>**附註**：
        * 如果您選擇使用 `loadBalancerIP` 設定來選取 IP 位址，則叢集必須至少具有一個可用的公用「負載平衡器」IP 位址。[您可以查看可用的公用 IP 位址](cs_subnets.html#review_ip)或[釋放已使用的 IP 位址](cs_subnets.html#free)。
        * 所有叢集工作者節點都必須位於相同的公用 VLAN 上。否則，您必須使用 `nodeSelector` 設定，以確保 VPN Pod 部署至與 `loadBalancerIP` 相同公用 VLAN 上的工作者節點。
        * 如果 `connectUsingLoadBalancerIP` 設為 `true`，且 `ipsec.keyexchange` 設為 `ikev1`，則您必須將 `enableServiceSourceIP` 設為 `true`。

### 步驟 4：透過 VPN 連線存取叢集資源
{: #strongswan_4}

決定哪些叢集資源必須可由遠端網路透過 VPN 連線存取。
{: shortdesc}

1. 將一個以上叢集子網路的 CIDR 新增至 `local.subnet` 設定。您必須在內部部署 VPN 端點上配置本端子網路 CIDR。此清單可能包括下列子網路：  
    * Kubernetes Pod 子網路 CIDR：`172.30.0.0/16`。在所有叢集 Pod 與遠端網路子網路（列在 `remote.subnet` 設定中）中的任何主機之間，會啟用雙向通訊。如果基於安全考量，您必須防止任何 `remote.subnet` 主機存取叢集 Pod，請不要將 Kubernetes Pod 子網路新增至 `local.subnet` 設定。
    * Kubernetes 服務子網路 CIDR：`172.21.0.0/16`。服務 IP 位址會提供一種公開多個應用程式 Pod 的方法，而這些應用程式 Pod 是部署在單一 IP 後面的數個工作者節點上。
    * 如果您的應用程式是由專用網路上的 NodePort 服務或專用 Ingress ALB 公開，請新增工作者節點的專用子網路 CIDR。藉由執行 `ibmcloud ks worker <cluster_name>`，來擷取工作者節點專用 IP 位址的前三個八位元組。比方說，如果它是 `10.176.48.xx`，請注意 `10.176.48`。接下來，執行下列指令，將 `<xxx.yyy.zz>` 取代為您先前擷取的八位元組，來取得工作者節點專用子網路 CIDR：`ibmcloud sl subnet list | grep <xxx.yyy.zzz>`。<br>**附註**：如果在新的專用子網路上新增工作者節點，則您必須將新的專用子網路 CIDR 新增至 `local.subnet` 設定及內部部署 VPN 端點。然後，必須重新啟動 VPN 連線。
    * 如果您的應用程式是由專用網路上的 LoadBalancer 服務公開，請新增叢集的專用使用者管理子網路 CIDR。若要尋找這些值，請執行 `ibmcloud ks cluster-get <cluster_name> --showResources`。在 **VLANS** 區段中，請尋找 **Public** 值為 `false` 的 CIDR。<br>
    **附註**：如果將 `ipsec.keyexchange` 設為 `ikev1`，則您只能指定一個子網路。不過，您可以使用 `localSubnetNAT` 設定，將多個叢集子網路結合成單一子網路。

2. 選用項目：使用 `localSubnetNAT` 設定來重新對映叢集子網路。子網路的「網址轉換 (NAT)」能針對叢集網路與內部部署遠端網路之間的子網路衝突，提供暫行解決方法。您可以使用 NAT，將叢集的專用本端 IP 子網路、Pod 子網路 (172.30.0.0/16) 或 Pod 服務子網路 (172.21.0.0/16) 重新對映至不同的專用子網路。VPN 通道會看到重新對映的 IP 子網路，而非原始子網路。重新對映發生在封包透過 VPN 通道傳送之前，以及封包從 VPN 通道抵達之後。您可以透過 VPN 同時公開重新對映及未重新對映的子網路。若要啟用 NAT，您可以新增整個子網路或新增個別 IP 位址。
    * 如果您以格式 `10.171.42.0/24=10.10.10.0/24` 新增整個子網路，則重新對映是 1 對 1：內部網路子網路中的所有 IP 位址都會對映到外部網路子網路，反之亦然。
    * 如果您以格式 `10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32` 新增個別 IP 位址，則只有那些內部 IP 位址會對映到指定的外部 IP 位址。

3. 2.2.0 版以及更新版本 strongSwan Helm 圖表的選用項目：藉由將 `enableSingleSourceIP` 設為 `true`，將所有叢集 IP 位址隱藏在單一 IP 位址之後。此選項為 VPN 連線提供其中一個最安全的配置，因為不允許從遠端網路回到叢集的任何連線。<br>**附註**：
    * 此設定要求流經 VPN 連線的所有資料流程都必須是出埠流程，無論 VPN 連線是從叢集建立，還是從遠端網路建立。
    * `local.subnet` 必須僅設為某個 /32 子網路。

4. 2.2.0 版以及更新版本 strongSwan Helm 圖表的選用項目：使用 `localNonClusterSubnet` 設定，讓 strongSwan 服務可將送入的要求從遠端網路遞送至存在於叢集以外的服務。<br>**附註**：
    * 非叢集服務必須存在於相同的專用網路上，或工作者節點可以連接的專用網路上。
    * 非叢集工作者節點無法起始透過 VPN 連線送至遠端網路的資料流量，但非叢集節點可以是來自遠端網路的送入要求目標。
    * 您必須在 `local.subnet` 設定中列出非叢集子網路的 CIDR。

### 步驟 5：透過 VPN 連線存取遠端網路資源
{: #strongswan_5}

決定哪些遠端網路資源必須可由叢集透過 VPN 連線存取。
{: shortdesc}

1. 將一個以上內部部署專用子網路的 CIDR 新增至 `remote.subnet` 設定。
    <br>**附註**：如果將 `ipsec.keyexchange` 設為 `ikev1`，則您只能指定一個子網路。
2. 2.2.0 版以及更新版本 strongSwan Helm 圖表的選用項目：使用 `remoteSubnetNAT` 設定來重新對映遠端網路子網路。子網路的「網址轉換 (NAT)」能針對叢集網路與內部部署遠端網路之間的子網路衝突，提供暫行解決方法。您可以使用 NAT，將遠端網路的 IP 子網路重新對映至不同的專用子網路。VPN 通道會看到重新對映的 IP 子網路，而非原始子網路。重新對映發生在封包透過 VPN 通道傳送之前，以及封包從 VPN 通道抵達之後。您可以透過 VPN 同時公開重新對映及未重新對映的子網路。

### 步驟 6：部署 Helm 圖表
{: #strongswan_6}

1. 如果您需要配置其他進階設定，請遵循提供的文件以瞭解 Helm 圖表中的每一個設定。

2. **重要事項**：如果您不需要 Helm 圖表中的設定，請在它前面加上 `#` 來註銷該內容。

3. 儲存已更新的 `config.yaml` 檔案。

4. 使用已更新的 `config.yaml` 檔案，將 Helm 圖表安裝至叢集。已更新的內容會儲存在圖表的 ConfigMap 中。

    **附註**：如果單一叢集裡有多個 VPN 部署，您可以選擇比 `vpn` 更具描述性的版本名稱，以避免命名衝突並區分您的部署。為了避免截斷版本名稱，請將版本名稱限制為 35 個字元以內。

    ```
    helm install -f config.yaml --name=vpn ibm/strongswan
    ```
    {: pre}

5. 檢查圖表部署狀態。圖表就緒時，輸出頂端附近的 **STATUS** 欄位會具有 `DEPLOYED` 值。

    ```
    helm status vpn
    ```
    {: pre}

6. 部署圖表之後，請驗證已使用 `config.yaml` 檔案中的已更新設定。

    ```
    helm get values vpn
    ```
    {: pre}

## 測試並驗證 strongSwan VPN 連線功能
{: #vpn_test}

部署 Helm 圖表之後，請測試 VPN 連線功能。
{:shortdesc}

1. 如果內部部署閘道上的 VPN 不在作用中，請啟動 VPN。

2. 設定 `STRONGSWAN_POD` 環境變數。

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. 檢查 VPN 的狀態。`ESTABLISHED` 狀態表示 VPN 連線成功。

    ```
    kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    輸出範例：

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.xxx.xxx[ibm-cloud]...192.xxx.xxx.xxx[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.xxx/26
    ```
    {: screen}

    **附註**：

    <ul>
    <li>當您嘗試使用 strongSwan Helm 圖表建立 VPN 連線功能時，有可能第一次的 VPN 狀態不是 `ESTABLISHED`。您可能需要檢查內部部署 VPN 端點設定，並數次變更配置檔，連線才會成功：<ol><li>執行 `helm delete --purge <release_name>`</li><li>修正配置檔中不正確的值。</li><li>執行 `helm install -f config.yaml --name=<release_name> ibm/strongswan`</li></ol>您也可以在下一步執行其他檢查。</li>
    <li>如果 VPN Pod 處於 `ERROR` 狀況，或持續當機並重新啟動，則可能是由於圖表的 ConfigMap 中 `ipsec.conf` 設定的參數驗證所造成。<ol><li>請執行 `kubectl logs -n $STRONGSWAN_POD`，檢查 strongSwan Pod 日誌中是否有任何驗證錯誤。</li><li>如果有驗證錯誤，請執行 `helm delete --purge <release_name>`<li>修正配置檔中不正確的值。</li><li>執行 `helm install -f config.yaml --name=<release_name> ibm/strongswan`</li></ol>如果叢集具有大量工作者節點，您也可以使用 `helm upgrade` 更快速地套用您的變更，而不要執行 `helm delete` 及 `helm install`。</li>
    </ul>

4. 您可以藉由執行內含在 strongSwan 圖表定義中的五個 Helm 測試，來進一步測試 VPN 連線功能。

    ```
    helm test vpn
    ```
    {: pre}

    * 如果所有的測試都通過，您的 strongSwan VPN 連線便已順利設定。

    * 如果有任何測試失敗，請繼續下一步。

5. 查看測試 Pod 的日誌，以檢視失敗測試的輸出。

    ```
    kubectl logs <test_program>
    ```
    {: pre}

    **附註**：部分測試的需求是 VPN 配置中的選用設定。如果某些測試失敗，則根據您是否指定這些選用設定，失敗也許是可接受的。如需每一個測試及其失敗原因的相關資訊，請參閱下表。

    {: #vpn_tests_table}
    <table>
    <caption>瞭解 Helm VPN 連線功能測試</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 Helm VPN 連線功能測試</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td>驗證從 <code>config.yaml</code> 檔案產生的 <code>ipsec.conf</code> 檔案的語法。此測試可能由於 <code>config.yaml</code> 檔案中的值不正確而失敗。</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>確認 VPN 連線的狀態為 <code>ESTABLISHED</code>。此測試可能因下列原因而失敗：<ul><li><code>config.yaml</code> 檔案中的值與內部部署 VPN 端點設定之間的差異。</li><li>如果叢集處於「接聽」模式（<code>ipsec.auto</code> 設為 <code>add</code>），則不會在內部部署端建立連線。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>對您在 <code>config.yaml</code> 檔案中配置的 <code>remote.gateway</code> 公用 IP 位址進行連線測試。此測試可能因下列原因而失敗：<ul><li>您未指定內部部署 VPN 閘道 IP 位址。如果 <code>ipsec.auto</code> 是設為 <code>start</code>，則需要 <code>remote.gateway</code> IP 位址。</li><li>VPN 連線沒有 <code>ESTABLISHED</code> 狀態。如需相關資訊，請參閱 <code>vpn-strongswan-check-state</code>。</li><li>VPN 連線功能是 <code>ESTABLISHED</code>，但 ICMP 封包遭到防火牆封鎖。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>從叢集裡的 VPN Pod，對內部部署 VPN 閘道的 <code>remote.privateIPtoPing</code> 專用 IP 位址進行連線測試。此測試可能因下列原因而失敗：<ul><li>您未指定 <code>remote.privateIPtoPing</code> IP 位址。如果您是故意不指定 IP 位址，則此失敗是可接受的。</li><li>您未在 <code>local.subnet</code> 清單中指定叢集 Pod 子網路 CIDR <code>172.30.0.0/16</code>。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>從叢集裡的工作者節點，對內部部署 VPN 閘道的 <code>remote.privateIPtoPing</code> 專用 IP 位址進行連線測試。此測試可能因下列原因而失敗：<ul><li>您未指定 <code>remote.privateIPtoPing</code> IP 位址。如果您是故意不指定 IP 位址，則此失敗是可接受的。</li><li>您未在 <code>local.subnet</code> 清單中指定叢集工作者節點專用子網路 CIDR。</li></ul></td>
    </tr>
    </tbody></table>

6. 刪除現行 Helm 圖表。

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. 開啟 `config.yaml` 檔案，並修正不正確的值。

8. 儲存已更新的 `config.yaml` 檔案。

9. 使用已更新的 `config.yaml` 檔案，將 Helm 圖表安裝至叢集。已更新的內容會儲存在圖表的 ConfigMap 中。

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

10. 檢查圖表部署狀態。圖表就緒時，輸出頂端附近的 **STATUS** 欄位值為 `DEPLOYED`。

    ```
    helm status vpn
    ```
    {: pre}

11. 部署圖表之後，請驗證已使用 `config.yaml` 檔案中的已更新設定。

    ```
    helm get values vpn
    ```
    {: pre}

12. 清除現行測試 Pod。

    ```
    kubectl get pods -a -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -l app=strongswan-test
    ```
    {: pre}

13. 重新執行測試。

    ```
    helm test vpn
    ```
    {: pre}

<br />


## 升級 strongSwan Helm 圖表
{: #vpn_upgrade}

藉由升級 strongSwan Helm 圖表，確定它保持最新。
{:shortdesc}

若要將 strongSwan Helm 圖表升級至最新版本，請執行下列動作：

  ```
  helm upgrade -f config.yaml <release_name> ibm/strongswan
  ```
  {: pre}

**重要事項**：strongSwan 2.0.0 Helm 圖表不適用於 Calico 第 3 版或 Kubernetes 1.10。[將叢集更新至 1.10](cs_versions.html#cs_v110) 之前，請將 strongSwan 更新至 2.2.0 Helm 圖表，其與 Calico 2.6 及 Kubernetes 1.8 及 1.9 舊版相容。

將您的叢集更新為 Kubernetes 1.10？首先，務必刪除您的 strongSwan Helm 圖表。然後，在更新後，重新予以安裝。
{:tip}

### 從 1.0.0 版升級
{: #vpn_upgrade_1.0.0}

由於在 1.0.0 版 Helm 圖表中使用的部分設定，您無法使用 `helm upgrade` 從 1.0.0 更新至最新版本。
{:shortdesc}

若要從 1.0.0 版升級，您必須刪除 1.0.0 圖表，並安裝最新版本：

1. 刪除 1.0.0 Helm 圖表。

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. 將 strongSwan Helm 圖表的最新版本的預設配置設定儲存在本端 YAML 檔案中。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 更新配置檔，並儲存含有您所做變更的檔案。

4. 使用已更新的 `config.yaml` 檔案，將 Helm 圖表安裝至叢集。

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

此外，1.0.0 中某些寫在程式中的 `ipsec.conf` 逾時設定，在未來版本中公開為可配置的內容。其中一些可配置的 `ipsec.conf` 逾時設定的名稱及預設值，也變更為更符合 strongSwan 標準。如果您要從 1.0.0 升級 Helm 圖表，且要保留 1.0.0 版的逾時設定預設值，請使用舊的預設值，將新設定新增至圖表配置檔中。



  <table>
  <caption>1.0.0 版與最新版本之間的 ipsec.conf 設定差異</caption>
  <thead>
  <th>1.0.0 設定名稱</th>
  <th>1.0.0 預設值</th>
  <th>最新版本設定名稱</th>
  <th>最新版本預設值</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## 停用 strongSwan IPSec VPN 服務
{: vpn_disable}

您可以藉由刪除 Helm 圖表來停用 VPN 連線。
{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}

<br />


## 使用 Virtual Router Appliance
{: #vyatta}

[Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) 提供適用於 x86 裸機伺服器的最新 Vyatta 5600 作業系統。您可以使用 VRA 作為 VPN 閘道，以安全地連接至內部部署網路。
{:shortdesc}

進入或退出叢集 VLAN 的所有公用及專用網路資料流量都會透過 VRA 遞送。您可以使用 VRA 作為 VPN 端點，在 IBM Cloud 基礎架構 (SoftLayer) 及內部部署資源中的伺服器之間建立已加密的 IPSec 通道。例如，下圖顯示 {{site.data.keyword.containerlong_notm}} 中僅限專用工作者節點上的應用程式如何透過 VRA VPN 連線與內部部署伺服器通訊：

<img src="images/cs_vpn_vyatta.png" width="725" alt="使用負載平衡器，在 {{site.data.keyword.containerlong_notm}} 中公開應用程式" style="width:725px; border-style: none"/>

1. 叢集裡的應用程式 (`myapp2`) 會接收來自 Ingress 或 LoadBalancer 服務的要求，且需要安全地連接至內部部署網路中的資料。

2. 因為 `myapp2` 位於僅限專用 VLAN 的工作者節點上，所以 VRA 在工作者節點與內部部署網路之間充當安全連線。VRA 會使用目的地 IP 位址，來判定要傳送至內部部署網路的網路封包。

3. 此要求會加密並透過 VPN 通道傳送至內部部署資料中心。

4. 送入的要求會通過內部部署防火牆，並遞送至解密所在的 VPN 通道端點（路由器）。

5. VPN 通道端點（路由器）會將要求轉遞至內部部署伺服器或大型主機，視步驟 2 中指定的目的地 IP 位址而定。必要資料會藉由相同的處理程序，透過 VPN 連線傳回至 `myapp2`。

若要設定 Virtual Router Appliance，請執行下列動作：

1. [訂購 VRA](/docs/infrastructure/virtual-router-appliance/getting-started.html)。

2. [在 VRA 上配置專用 VLAN](/docs/infrastructure/virtual-router-appliance/manage-vlans.html)。

3. 若要使用 VRA 啟用 VPN 連線，請[在 VRA 上配置 VRRP](/docs/infrastructure/virtual-router-appliance/vrrp.html#high-availability-vpn-with-vrrp)。

**附註**：如果您具有現有的路由器應用裝置，然後新增叢集，則不會在路由器應用裝置上配置針對叢集所訂購的新可攜式子網路。為了能夠使用網路服務，您必須[啟用 VLAN Spanning](cs_subnets.html#subnet-routing)，在相同 VLAN 上的子網路之間啟用遞送。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud s vlan-spanning` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。
