---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-29"

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

使用 VPN 連線功能，您可將 Kubernetes 叢集中的應用程式安全地連接至內部部署網路。您也可以將叢集外部的應用程式連接至叢集內部執行的應用程式。
{:shortdesc}

## 使用 Strongswan IPSec VPN 服務 Helm 圖表設定 VPN 連線功能
{: #vpn-setup}

若要設定 VPN 連線功能，您可以使用「Helm 圖表」，在 Kubernetes Pod 內部配置及部署 [Strongswan IPSec VPN 服務 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.strongswan.org/)。接著會透過此 Pod 遞送所有 VPN 資料流量。如需用來設定 Strongswan 圖表之 Helm 指令的相關資訊，請參閱 <a href="https://docs.helm.sh/helm/" target="_blank">Helm 文件 <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。
{:shortdesc}

開始之前：

- [建立標準叢集。](cs_clusters.html#clusters_cli)
- [如果您要使用現有叢集，請將它更新至 1.7.4 版或更新版本。](cs_cluster_update.html#master)
- 叢集必須至少有一個可用的公用「負載平衡器」IP 位址。
- [將 Kubernetes CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

若要使用 Strongswan 設定 VPN 連線功能，請執行下列動作：

1. 如果尚未予以啟用，請安裝及起始設定叢集的 Helm。

    1. 安裝 <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。

    2. 起始設定 Helm，並安裝 `tiller`。

        ```
        helm init
        ```
        {: pre}

    3. 驗證 `tiller-deploy` Pod 在叢集中的狀態為 `Running`。

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        輸出範例：

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. 將 {{site.data.keyword.containershort_notm}} Helm 儲存庫新增至 Helm 實例。

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. 驗證 Strongswan 圖表列在 Helm 儲存庫中。

        ```
        helm search bluemix
        ```
        {: pre}

2. 將「Strongswan Helm 圖表」的預設配置設定儲存在本端 YAML 檔案中。

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. 開啟 `config.yaml` 檔案，並根據您要的 VPN 配置，對預設值進行下列變更。如果內容有可供您選擇的特定值，則那些值會列在檔案中每個內容上方的註解裡。**重要事項**：如果您不需要變更內容，請在它前面加上 `#` 來註銷該內容。

    <table>
    <caption>瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>如果您有想要使用的現有 <code>ipsec.conf</code> 檔案，請移除大括弧 (<code>{}</code>)，並在此內容之後新增檔案的內容。檔案內容必須縮排。**附註：**如果您使用自己的檔案，則不會使用 <code>ipsec</code>、<code>local</code> 及 <code>remote</code> 區段的任何值。</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>如果您有想要使用的現有 <code>ipsec.secrets</code> 檔案，請移除大括弧 (<code>{}</code>)，並在此內容之後新增檔案的內容。檔案內容必須縮排。**附註：**如果您使用自己的檔案，則不會使用 <code>preshared</code> 區段的任何值。</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>如果您的內部部署 VPN 通道端點不支援 <code>ikev2</code> 作為起始設定連線的通訊協定，請將此值變更為 <code>ikev1</code>。</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>將此值變更為內部部署 VPN 通道端點用於連線的 ESP 加密/鑑別演算法清單。</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>將此值變更為內部部署 VPN 通道端點用於連線的 IKE/ISAKMP SA 加密/鑑別演算法清單。</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>如果您希望叢集起始 VPN 連線，請將此值變更為 <code>start</code>。</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>將此值變更為要透過 VPN 連線公開給內部部署網路使用之叢集子網路 CIDR 的清單。此清單可能包括下列子網路：<ul><li>Kubernetes Pod 子網路 CIDR：<code>172.30.0.0/16</code></li><li>Kubernetes 服務子網路 CIDR：<code>172.21.0.0/16</code></li><li>如果在專用網路上您的應用程式是由 NodePort 服務公開，則為工作者節點的專用子網路 CIDR。若要尋找此值，請執行 <code>bx cs subnets | grep <xxx.yyy.zzz></code>，其中 <code>&lt;xxx.yyy.zzz&gt;</code> 是工作者節點專用 IP 位址的前三個八位元組。</li><li>如果您在專用網路上具有 LoadBalancer 服務所公開的應用程式，則為叢集的專用或使用者管理子網路 CIDR。若要尋找這些值，請執行 <code>bx cs cluster-get <cluster name> --showResources</code>。在 <b>VLANS</b> 區段中，請尋找 <b>Public</b> 值為 <code>false</code> 的 CIDR。</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>將此值變更為 VPN 通道端點用於連線的本端 Kubernetes 叢集端的字串 ID。</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>將此值變更為內部部署 VPN 閘道的公用 IP 位址。</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>將此值變更為容許 Kubernetes 叢集存取的內部部署專用子網路 CIDR 清單。</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>將此值變更為 VPN 通道端點用於連線的遠端內部部署端的字串 ID。</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>將此值變更為內部部署 VPN 通道端點閘道用於連線的預先共用密碼。</td>
    </tr>
    </tbody></table>

4. 儲存已更新的 `config.yaml` 檔案。

5. 使用已更新的 `config.yaml` 檔案，將「Helm 圖表」安裝至叢集。已更新的內容會儲存在圖表的配置對映中。

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. 檢查圖表部署狀態。圖表就緒時，輸出頂端附近的 **STATUS** 欄位值為 `DEPLOYED`。

    ```
    helm status vpn
    ```
    {: pre}

7. 部署圖表之後，請驗證已使用 `config.yaml` 檔案中的已更新設定。

    ```
    helm get values vpn
    ```
    {: pre}

8. 測試新的 VPN 連線功能。
    1. 如果內部部署閘道上的 VPN 為非作用中，請啟動 VPN。

    2. 設定 `STRONGSWAN_POD` 環境變數。

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. 檢查 VPN 的狀態。`ESTABLISHED` 狀態表示 VPN 連線成功。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        輸出範例：
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

      **附註**：
          - 第一次使用此「Helm 圖表」時，VPN 狀態很可能不是 `ESTABLISHED`。您可能需要檢查內部部署 VPN 端點設定，並回到步驟 3 數次變更 `config.yaml` 檔案，連線才會成功。
          - 如果 VPN Pod 處於 `ERROR` 狀態，或持續損毀並重新啟動，則可能是圖表配置對映中 `ipsec.conf` 設定的參數驗證所造成。請執行 `kubectl logs -n kube-system $STRONGSWAN_POD`，檢查 Strongswan Pod 日誌中是否有任何驗證錯誤。如果發生驗證錯誤，請執行 `helm delete --purge vpn`，並回到步驟 3 以修正 `config.yaml` 檔案中不正確的值，然後重複步驟 4 - 8。如果叢集具有大量工作者節點，您也可以使用 `helm upgrade` 更快速地套用您的變更，而不是執行 `helm delete` 及 `helm install`。

    4. VPN 的狀態為 `ESTABLISHED` 之後，請使用 `ping` 來測試連線。下列範例會將來自 Kubernetes 叢集中 VPN Pod 的 ping 傳送至內部部署 VPN 閘道的專用 IP 位址。請確定已在配置檔中指定正確的 `remote.subnet` 及 `local.subnet`，而且本端子網路清單包含您要從該處傳送 ping 的來源 IP 位址。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### 停用 Strongswan IPSec VPN 服務
{: vpn_disable}

1. 刪除「Helm 圖表」。

    ```
    helm delete --purge vpn
    ```
    {: pre}
