---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 使用網路原則控制資料流量
{: #network_policies}

每個 Kubernetes 叢集都會設定稱為 Calico 的網路外掛程式。已設定預設的網路原則來保護 {{site.data.keyword.containerlong}} 中每個工作者節點的公用網路介面。
{: shortdesc}

當您有獨特的安全需求時，可以使用 Calico 及原生 Kubernetes 功能來配置叢集的其他網路原則。這些網路原則指定您要容許或封鎖的與叢集中 Pod 之間往來的網路資料流量。
您可以使用 Kubernetes 網路原則開始，但若需要更健全的功能，請使用 Calico 網路原則。

<ul>
  <li>[Kubernetes 網路原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)：提供部分基本選項，例如，指定可以彼此通訊的 Pod。對於通訊協定及埠，可以容許或封鎖送入的網路資料流量。可以根據正在嘗試連接至其他 Pod 之 Pod 的標籤及 Kubernetes 名稱空間來過濾此資料流量。</br>您可以使用 `kubectl` 指令或 Kubernetes API 來套用這些原則。這些原則在套用時會轉換為 Calico 網路原則，而 Calico 會強制執行這些原則。</li>
  <li>[Calico 網路原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)：這些原則是 Kubernetes 網路原則的超集，並且使用下列特性來加強原生 Kubernetes 功能。
</li>
    <ul><ul><li>容許或封鎖特定網路介面的網路資料流量，而不只是 Kubernetes Pod 資料流量。</li>
    <li>容許或封鎖送入 (Ingress) 及送出 (Egress) 的網路資料流量。</li>
    <li>[封鎖對 LoadBalancer 或 NodePort Kubernetes 服務的送入 (ingress) 資料流量](#block_ingress)。</li>
    <li>容許或封鎖根據來源或目的地 IP 位址或 CIDR 的資料流量。</li></ul></ul></br>

您可以使用 `calicoctl` 指令來套用這些原則。Calico 透過在 Kubernetes 工作者節點上設定 Linux iptables 規則，來強制執行這些原則（包括任何會轉換為 Calico 原則的 Kubernetes 網路原則）。iptables 規則作為工作者節點的防火牆，以定義網路資料流量必須符合才能轉遞至目標資源的特徵。</ul>

<br />


## 預設原則配置
{: #default_policy}

建立叢集時，會設定每一個工作者節點的公用網路介面的預設網路原則，以限制來自公用網際網路的送入資料流量。這些原則不會影響 Pod 對 Pod 的資料流量，並容許存取 Kubernetes nodeport、負載平衡器及 Ingress 服務。
{:shortdesc}

預設原則不會直接套用至 Pod：它們是使用 Calico 主機端點套用至工作者節點的公用網路介面。在 Calico 中建立主機端點時，會封鎖與該工作者節點的網路介面之間往來的所有資料流量，除非原則容許該資料流量。

**重要事項：**除非您完全瞭解原則，並且知道您不需要原則所容許的資料流量，否則請不要移除套用至主機端點的原則。


 <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器位置，第二欄則為要符合的 IP 位址。">
  <caption>每一個叢集的預設原則</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 每一個叢集的預設原則</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>容許所有出埠資料流量。</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>容許埠 52311 上對 bigfix 應用程式的送入資料流量，以容許必要的工作者節點更新。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>容許送入的 icmp 封包 (ping)。</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>容許 NodePort、負載平衡器及 Ingress 服務將公開至 pod 的送入 NodePort、負載平衡器及 Ingress 服務的資料流量。請注意，不需要指定這些服務在公用介面上公開的埠，因為 Kubernetes 會使用目的地網址轉譯 (DNAT) 將這些服務要求轉遞至正確的 Pod。該轉遞是在 iptables 套用主機端點原則之前進行。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>容許用來管理工作者節點之特定 IBM Cloud 基礎架構 (SoftLayer) 系統的送入連線。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>容許 vrrp 封包，用來監視及移動工作者節點之間的虛擬 IP 位址。</td>
   </tr>
  </tbody>
</table>

<br />


## 新增網路原則
{: #adding_network_policies}

在大部分情況下，不需要變更預設原則。只有進階情境會有可能需要變更。如果您發現必須進行變更，請安裝 Calico CLI，並建立自己的網路原則。
{:shortdesc}

開始之前：

1.  [安裝 {{site.data.keyword.containershort_notm}} 及 Kubernetes CLI。](cs_cli_install.html#cs_cli_install)
2.  [建立免費或標準叢集。](cs_clusters.html#clusters_ui)
3.  [將 Kubernetes CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。請在 `bx cs cluster-config` 指令包含 `--admin` 選項，這用來下載憑證及許可權檔案。此下載還包括「超級使用者」角色的金鑰，您需要此金鑰才能執行 Calico 指令。

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **附註**：支援 Calico CLI 1.6.1 版。

若要新增網路原則，請執行下列動作：
1.  安裝 Calico CLI。
    1.  [下載 Calico CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1)。

        **提示：**如果您使用的是 Windows，請將 Calico CLI 安裝在與 {{site.data.keyword.Bluemix_notm}} CLI 相同的目錄中。當您稍後執行指令時，此設定可為您省去一些檔案路徑變更。

    2.  若為 OSX 及 Linux 使用者，請完成下列步驟。
        1.  將執行檔移至 /usr/local/bin 目錄。
            -   Linux：

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS X：

              ```
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  使檔案成為可執行檔。

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  檢查 Calico CLI 用戶端版本，驗證已適當地執行 `calico` 指令。

        ```
        calicoctl version
        ```
        {: pre}

    4.  如果公司網路原則阻止透過 Proxy 或防火牆從本端系統存取公用端點，請參閱[從防火牆後面執行 `calicoctl` 指令](cs_firewall.html#firewall)，以取得如何容許對 Calico 指令進行 TCP 存取權的指示。

2.  配置 Calico CLI。

    1.  若為 Linux 及 OS X，請建立 `/etc/calico` 目錄。若為 Windows，任何目錄皆可使用。

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  建立 `calicoctl.cfg` 檔案。
        -   Linux 及 OS X：

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows：使用文字編輯器建立檔案。

    3.  在 <code>calicoctl.cfg</code> 檔案中，輸入下列資訊。

        ```
        apiVersion: v1
        kind: calicoApiConfig
        metadata:
        spec:
            etcdEndpoints: <ETCD_URL>
            etcdKeyFile: <CERTS_DIR>/admin-key.pem
            etcdCertFile: <CERTS_DIR>/admin.pem
            etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
        ```
        {: codeblock}

        1.  擷取 `<ETCD_URL>`。如果這個指令失敗，且出現 `calico-config` 錯誤，請參閱這個[疑難排解主題](cs_troubleshoot.html#cs_calico_fails)。

          -   Linux 及 OS X：

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   輸出範例：

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows：<ol>
            <li>從配置對映取得 calico 配置值。</br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>在 `data` 區段中，找到 etcd_endpoints 值。範例：<code>https://169.1.1.1:30001</code>
            </ol>

        2.  擷取 `<CERTS_DIR>`，這是將 Kubernetes 憑證下載至其中的目錄。

            -   Linux 及 OS X：

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                輸出範例：

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows：

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                輸出範例：

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **附註**：若要取得目錄路徑，請移除輸出結尾中的檔名 `kube-config-prod-<location>-<cluster_name>.yml`。

        3.  擷取 <code>ca-*pem_file<code>。

            -   Linux 及 OS X：

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows：<ol><li>開啟您在最後一個步驟中擷取的目錄。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> 找出 <code>ca-*pem_file</code> 檔案。</ol>

        4.  驗證 Calico 配置正確運作。

            -   Linux 及 OS X：

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows：

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              輸出：

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  檢查現有網路原則。

    -   檢視 Calico 主機端點。

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   檢視已為叢集建立的所有 Calico 及 Kubernetes 網路原則。這份清單包括可能尚未套用至任何 Pod 或主機的原則。若要強制執行網路原則，則必須找到符合 Calico 網路原則中所定義之選取器的 Kubernetes 資源。

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   檢視網路原則的詳細資料。

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   檢視叢集的所有網路原則的詳細資料。

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  建立要容許或封鎖資料流量的 Calico 網路原則。

    1.  建立配置 Script (.yaml)，以定義 [Calico 網路原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)。這些配置檔包含選取器，其說明這些原則適用的 Pod、名稱空間或主機。請參閱這些 [Calico 原則範例 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)，以協助您建立自己的原則。

    2.  將原則套用至叢集。
        -   Linux 及 OS X：

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows：

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}

<br />


## 封鎖對 LoadBalancer 或 NodePort 服務的送入資料流量
{: #block_ingress}

依預設，Kubernetes `NodePort` 及 `LoadBalancer` 服務的設計是要讓您的應用程式能夠在所有公用和專用叢集介面上使用。不過，您可以根據資料流量來源或目的地，封鎖對您服務的送入資料流量。
{:shortdesc}

Kubernetes LoadBalancer 服務也是 NodePort 服務。LoadBalancer 服務可讓您的應用程式透過負載平衡器 IP 位址及埠提供使用，並讓您的應用程式可透過服務的節點埠提供使用。叢集中每個節點的每個 IP 位址（公開和專用）上都可以存取節點埠。

叢集管理者可以使用 Calico `preDNAT` 網路原則來封鎖：

  - 對 NodePort 服務的資料流量。容許 LoadBalancer 服務的資料流量。
  - 根據來源位址或 CIDR 的資料流量。

Calico `preDNAT` 網路原則的一些常見用途：

  - 封鎖對專用 LoadBalancer 服務之公用節點埠的資料流量。
  - 封鎖對執行[邊緣工作者節點](cs_edge.html#edge)之叢集上公用節點埠的資料流量。封鎖節點埠可確保邊緣工作者節點是處理送入資料流量的唯一工作者節點。

`preDNAT` 網路原則很有用，因為預設的 Kubernetes 及 Calico 原則很難套用來保護 Kubernetes NodePort 和 LoadBalancer 服務，這是針對這些服務產生之 DNAT iptables 規則的緣故。

Calico `preDNAT` 網路原則會根據 [Calico 網路原則資源 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)產生 iptables 規則。

1. 針對 Kubernetes 服務的進入存取，定義 Calico `preDNAT` 網路原則。

  封鎖所有節點埠的範例：

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. 套用 Calico preDNAT 網路原則。大約需要 1 分鐘，才能在整個叢集中套用原則變更。

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}
