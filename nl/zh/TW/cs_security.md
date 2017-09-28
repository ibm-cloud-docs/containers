---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# {{site.data.keyword.containerlong_notm}} 的安全
{: #cs_security}

您可以使用內建的安全特性，以進行風險分析及安全保護。這些特性可協助您保護叢集基礎架構及網路通訊、隔離運算資源，以及確保基礎架構元件和容器部署的安全相符性。
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png"><img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} 叢集安全" style="width:400px;" /></a>

<table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器位置，第二欄則為要符合的 IP 位址。">
  <thead>
  <th colspan=2><img src="images/idea.png"/> {{site.data.keyword.containershort_notm}} 中的內建叢集安全設定</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes 主節點</td>
      <td>每一個叢集中的 Kubernetes 主節點都是由 IBM 管理，並且具備高可用性。它包括 {{site.data.keyword.containershort_notm}} 安全設定，可確保安全相符性及進出工作者節點的安全通訊。IBM 會視需要執行更新。專用 Kubernetes 主節點可集中控制及監視叢集中的所有 Kubernetes 資源。根據叢集中的部署需求及容量，Kubernetes 主節點會自動排定容器化應用程式，在可用的工作者節點之間進行部署。如需相關資訊，請參閱 [Kubernetes 主節點安全](#cs_security_master)。</td>
    </tr>
    <tr>
      <td>工作者節點</td>
      <td>容器部署於叢集專用的工作者節點，可確保 IBM 客戶的運算、網路及儲存空間隔離。{{site.data.keyword.containershort_notm}} 提供內建安全特性，讓工作者節點在專用及公用網路上保持安全，以及確保工作者節點的安全相符性。如需相關資訊，請參閱[工作者節點安全](#cs_security_worker)。</td>
     </tr>
     <tr>
      <td>映像檔</td>
      <td>身為叢集管理者，您可以在 {{site.data.keyword.registryshort_notm}} 中設定您自己的安全 Docker 映像檔儲存庫，您可以在其中儲存 Docker 映像檔並且在叢集使用者之間進行共用。為了確保安全容器部署，「漏洞警告器」會掃描專用登錄中的每個映像檔。「漏洞警告器」是 {{site.data.keyword.registryshort_notm}} 的元件，可掃描以尋找潛在漏洞、提出安全建議，並提供解決漏洞的指示。如需相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 中的映像檔安全](#cs_security_deployment)。</td>
    </tr>
  </tbody>
</table>

## Kubernetes 主節點
{: #cs_security_master}

檢閱內建 Kubernetes 主節點安全特性，此安全特性用來保護 Kubernetes 主節點，以及保護叢集網路通訊安全。
{: shortdesc}

<dl>
  <dt>完整受管理及專用的 Kubernetes 主節點</dt>
    <dd>{{site.data.keyword.containershort_notm}} 中的每個 Kubernetes 叢集都是 IBM 透過 IBM 擁有的 {{site.data.keyword.BluSoftlayer_full}} 帳戶所管理的專用 Kubernetes 主節點予以控制。Kubernetes 主節點已設定下列未與其他 IBM 客戶共用的專用元件。<ul><ul><li>etcd 資料儲存庫：儲存叢集的所有 Kubernetes 資源（例如「服務」、「部署」及 Pod）。Kubernetes ConfigMap 及 Secret 是儲存為金鑰值組的應用程式資料，因此，Pod 中執行的應用程式可以使用它們。傳送至 Pod 時，etcd 中的資料會儲存在 IBM 所管理並透過 TLS 加密的已加密磁碟中，以確保資料保護及完整性。<li>kube-apiserver：提供為從工作者節點到 Kubernetes 主節點的所有要求的主要進入點。kube-apiserver 會驗證及處理要求，並且可以讀取及寫入 etcd 資料儲存庫。<li><kube-scheduler：考量容量及效能需求、軟硬體原則限制、反親緣性規格及工作負載需求，以決定在何處部署 Pod。如果找不到符合需求的工作者節點，則不會在叢集中部署 Pod。<li>kube-controller-manager：負責監視抄本集，以及建立對應的 Pod 來達到想要的狀態。<li>OpenVPN：{{site.data.keyword.containershort_notm}} 特定元件，提供所有 Kubernetes 主節點與工作者節點的通訊的安全網路連線功能。</ul></ul></dd>
  <dt>所有工作者節點與 Kubernetes 主節點的通訊的 TLS 安全網路連線功能</dt>
    <dd>為了保護與 Kubernetes 主節點的網路通訊安全，{{site.data.keyword.containershort_notm}} 會產生 TLS 憑證，以加密每個叢集的 kube-apiserver 及 etcd 資料儲存庫元件的進出通訊。這些憑證絕不會在叢集或 Kubernetes 主節點元件之間共用。</dd>
  <dt>所有 Kubernetes 主節點與工作者節點的通訊的 OpenVPN 安全網路連線功能</dt>
    <dd>雖然 Kubernetes 會使用 `https` 通訊協定來保護 Kubernetes 主節點與工作者節點之間的通訊，但是預設不會提供工作者節點的鑑別。為了保護此通訊，{{site.data.keyword.containershort_notm}} 會在建立叢集時自動設定 Kubernetes 主節點與工作者節點之間的 OpenVPN 連線。</dd>
  <dt>持續 Kubernetes 主節點網路監視</dt>
    <dd>IBM 會持續監視每個 Kubernetes 主節點，以控制及重新修補處理程序層次的「拒絕服務 (DOS)」攻擊。</dd>
  <dt>Kubernetes 主節點節點安全相符性</dt>
    <dd>{{site.data.keyword.containershort_notm}} 會自動掃描每個已部署 Kubernetes 主節點的節點，以尋找需要套用以確保主節點保護的 Kubernetes 及 OS 特定安全修正程式中存在的漏洞。如果找到漏洞，{{site.data.keyword.containershort_notm}} 會自動套用修正程式，並代表使用者來解決漏洞。</dd>
</dl>  

## 工作者節點
{: #cs_security_worker}

檢閱內建的工作者節點安全特性，以保護工作者節點環境，以及確保資源、網路及儲存空間隔離。
{: shortdesc}

<dl>
  <dt>運算、網路及儲存空間基礎架構隔離</dt>
    <dd>當您建立叢集時，會將虛擬機器佈建為客戶 {{site.data.keyword.BluSoftlayer_notm}} 帳戶中的工作者節點，或由 IBM 將虛擬機器佈建為專用 {{site.data.keyword.BluSoftlayer_notm}} 帳戶中的工作者節點。工作者節點專用於某一個叢集，而且不會管理其他叢集的工作負載。</br>每個 {{site.data.keyword.Bluemix_notm}} 帳戶都已設定 {{site.data.keyword.BluSoftlayer_notm}} VLAN，確保工作者節點上的優質網路效能及隔離。</br>若要持續保存叢集中的資料，您可以從 {{site.data.keyword.BluSoftlayer_notm}} 佈建專用 NFS 型檔案儲存空間，並運用該平台的內建資料安全特性。</dd>
  <dt>設定受保護的工作者節點</dt>
    <dd>每個工作者節點都設定了 Ubuntu 作業系統，且使用者無法變更。為了保護工作者節點的作業系統不會受到潛在攻擊，每個工作者節都會以 Linux iptables 規則所強制執行的專家級防火牆設定來進行配置。</br> 在 Kubernetes 上執行的所有容器都受到預先定義的 Calico 網路原則設定所保護，這些設定是在建立叢集期間，配置於每個工作者節點上。這項設定確保工作者節點與 Pod 之間的安全網路通訊。若要進一步限制容器可以在工作者節點上執行的動作，使用者可以選擇在工作者節點上配置 [AppArmor 原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tutorials/clusters/apparmor/)。</br> 依預設，工作者節點上會停用 root 使用者的 SSH 存取權。如果您要在工作者節點上安裝其他特性，則可以針對您要在每個工作者節點上執行的所有項目，使用 [Kubernetes 常駐程式集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset)，或是針對您必須執行的任何一次性動作，使用 [Kubernetes 工作 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/)。</dd>
  <dt>Kubernetes 工作者節點安全相符性</dt>
    <dd>IBM 會與安全諮詢小組在內部及外部合作，以識別工作者節點的潛在安全相符性問題，並持續發行相符性更新項目及安全修補程式來解決任何發現的漏洞。IBM 會將更新項目及安全修補程式自動部署至工作者節點的作業系統。為了執行該作業，IBM 會維護對工作者節點的 SSH 存取權。</br> <b>附註</b>：部分更新項目需要工作者節點重新開機。不過，在安裝更新項目或安全修補程式期間，IBM 不會將工作者節點重新開機。建議使用者定期將工作者節點重新開機，確保更新項目或安全修補程式的安裝能夠完成。</dd>
  <dt>SoftLayer 網路防火牆支援</dt>
    <dd>{{site.data.keyword.containershort_notm}} 與所有 [{{site.data.keyword.BluSoftlayer_notm}} 防火牆供應項目 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/network-security) 相容。在「{{site.data.keyword.Bluemix_notm}} 公用」上，您可以使用自訂網路原則來設定防火牆，以提供叢集的專用網路安全，以及偵測及重新修補網路侵入。例如，您可能選擇設定 [Vyatta ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/vyatta-1) 作為防火牆，並且封鎖不想要的資料流量。當您設定防火牆時，[也必須開啟必要埠及 IP 位址](#opening_ports)（針對每一個地區），讓主節點與工作者節點可以進行通訊。在「{{site.data.keyword.Bluemix_notm}} 專用」上，防火牆、DataPower、Fortigate 及 DNS 已配置為標準專用環境部署的一部分。</dd>
  <dt>將服務維持為專用狀態，或選擇性地將服務及應用程式公開給公用網際網路使用</dt>
    <dd>您可以選擇將服務及應用程式維持為專用狀態，並運用本主題所述的內建安全特性，來確保工作者節點與 Pod 之間的安全通訊。若要將服務及應用程式公開給公用網際網路使用，您可以運用 Ingress 及負載平衡器支援，安全地將服務設為可公開使用。</dd>
  <dt>將工作者節點及應用程式安全地連接至內部部署資料中心</dt>
    <dd>您可以設定 Vyatta Gateway Appliance 或 Fortigate Appliance，以配置 IPSec VPN 端點，連接 Kubernetes 叢集與內部部署資料中心。透過加密通道，所有在 Kubernetes 叢集中執行的服務都可以安全地與內部部署應用程式進行通訊（例如使用者目錄、資料庫或大型主機）。如需相關資訊，請參閱[將叢集連接至內部部署資料中心 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。</dd>
  <dt>叢集活動的持續監視及記載</dt>
    <dd>對於標準叢集，{{site.data.keyword.containershort_notm}} 會記載並監視所有叢集相關事件，例如新增工作者節點、漸進式更新進度或容量使用資訊，這些事件也會傳送至 IBM Monitoring and Logging Service。</dd>
</dl>

### 在防火牆中開啟必要埠及 IP 位址
{: #opening_ports}

如果您設定工作者節點的防火牆，或在 {{site.data.keyword.BluSoftlayer_notm}} 帳戶中自訂防火牆設定，則必須開啟特定埠及 IP 位址，讓工作者節點與 Kubernetes 主節點可以進行通訊。

1.  記下叢集中所有工作者節點的公用 IP 位址。

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  在您的防火牆中，容許下列進出工作者節點的連線。

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>若為來自工作者節點的 OUTBOUND 連線，容許從來源工作者節點到 `<each_worker_node_publicIP>` 之目的地 TCP/UDP 埠範圍 20000-32767 及下列 IP 位址和網路群組的送出網路資料流量：</br>
    

    <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器位置，第二欄則為要符合的 IP 位址。">
  <thead>
      <th colspan=2><img src="images/idea.png"/> 出埠 IP 位址</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## 網路原則
{: #cs_security_network_policies}

每個 Kubernetes 叢集都會設定稱為 Calico 的網路外掛程式。已設定預設的網路原則來保護每個工作者節點的公用網路介面。當您有獨特的安全需求時，可以使用 Calico 及原生 Kubernetes 功能來配置叢集的其他網路原則。這些網路原則指定您要容許或封鎖的與叢集中 Pod 之間往來的網路資料流量。
{: shortdesc}

您可以選擇 Calico 與原生 Kubernetes 功能，以建立叢集的網路原則。您可以使用 Kubernetes 網路原則開始，但若需要更健全的功能，請使用 Calico 網路原則。

<ul><li>[Kubernetes 網路原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)：提供部分基本選項，例如，指定可以彼此通訊的 Pod。根據嘗試與其連接的 Pod 的標籤及 Kubernetes 名稱空間，可以容許或封鎖通訊協定及埠的 Pod 的送入網路資料流量。</br>您可以使用 `kubectl` 指令或 Kubernetes API 來套用這些原則。這些原則在套用時會轉換為 Calico 網路原則，而 Calico 會強制執行這些原則。<li>[Calico 網路原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy)：這些原則是 Kubernetes 網路原則的超集，並且使用下列特性來加強原生 Kubernetes 功能。
<ul><ul><li>容許或封鎖特定網路介面的網路資料流量，而不只是 Kubernetes Pod 資料流量。<li>容許或封鎖送入 (Ingress) 及送出 (Egress) 的網路資料流量。<li>容許或封鎖根據來源或目的地 IP 位址或 CIDR 的資料流量。</ul></ul></br>
您可以使用 `calicoctl` 指令來套用這些原則。Calico 透過在 Kubernetes 工作者節點上設定 Linux iptables 規則，來強制執行這些原則（包括任何會轉換為 Calico 原則的 Kubernetes 網路原則）。iptables 規則作為工作者節點的防火牆，以定義網路資料流量必須符合才能轉遞至目標資源的特徵。</ul>


### 預設原則配置
{: #concept_nq1_2rn_4z}

建立叢集時，會自動設定每一個工作者節點的公用網路介面的預設網路原則，以限制工作者節點來自公用網際網路的送入資料流量。這些原則不會影響 Pod 對 Pod 的資料流量，並且設定以容許存取 Kubernetes NodePort、負載平衡器及 Ingress 服務。

預設原則不會直接套用至 Pod：它們是使用 Calico [主機端點 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal) 套用至工作者節點的公用網路介面。在 Calico 中建立主機端點時，會封鎖與該工作者節點的網路介面之間往來的所有資料流量，除非原則容許該資料流量。

請注意，容許 SSH 的原則不存在，因此會封鎖透過公用網路介面的 SSH 存取，也會封鎖沒有原則可開啟它們的所有其他埠。每一個工作者節點的專用網路介面上都可以進行 SSH 存取及其他存取。

**重要事項：**除非您完全瞭解原則，並且知道您不需要原則所容許的資料流量，否則請不要移除套用至主機端點的原則。



  <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器位置，第二欄則為要符合的 IP 位址。">
  <thead>
  <th colspan=2><img src="images/idea.png"/> 每一個叢集的預設原則</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>容許所有出埠資料流量。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>容許送入的 icmp 封包 (ping)。</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>容許埠 10250 的所有送入資料流量，而此埠是 kubelet 所使用的埠。此原則容許 `kubectl logs` 及 `kubectl exec` 在 Kubernetes 叢集中適當地運作。</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>容許 NodePort、負載平衡器及 Ingress 服務將公開至 pod 的送入 NodePort、負載平衡器及 Ingress 服務的資料流量。請注意，不需要指定這些服務在公用介面上公開的埠，因為 Kubernetes 會使用目的地網址轉譯 (DNAT) 將這些服務要求轉遞至正確的 Pod。該轉遞是在 iptables 套用主機端點原則之前進行。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>容許用來管理工作者節點的特定 {{site.data.keyword.BluSoftlayer_notm}} 系統的送入連線。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>容許 vrrp 封包，用來監視及移動工作者節點之間的虛擬 IP 位址。</td>
   </tr>
  </tbody>
</table>


### 新增網路原則
{: #adding_network_policies}

在大部分情況下，不需要變更預設原則。只有進階情境會有可能需要變更。如果您發現必須進行變更，請安裝 Calico CLI，並建立自己的網路原則。

開始之前，請完成下列步驟。

1.  [安裝 {{site.data.keyword.containershort_notm}} 及 Kubernetes CLI。](cs_cli_install.html#cs_cli_install)
2.  [建立精簡或標準叢集。](cs_cluster.html#cs_cluster_ui)
3.  [將 Kubernetes CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。請在 `bx cs cluster-config` 指令包含 `--admin` 選項，這用來下載憑證及許可權檔案。此下載還包括「管理者」rbac 角色的金鑰，您需要此金鑰才能執行 Calico 指令。


  ```
  bx cs cluster-config <cluster_name> 
  ```
  {: pre}


若要新增網路原則，請執行下列動作：
1.  安裝 Calico CLI。
    1.  [下載 Calico CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/projectcalico/calicoctl/releases/)。

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
              mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  將二進位檔轉換成執行檔。

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  檢查 Calico CLI 用戶端版本，驗證已適當地執行 `calico` 指令。

        ```
        calicoctl version
        ```
        {: pre}

2.  配置 Calico CLI。

    1.  若為 Linux 及 OS X，請建立 '/etc/calico' 目錄。若為 Windows，任何目錄皆可使用。

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  建立 'calicoctl.cfg' 檔案。
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
      {: pre}

        1.  擷取 `<ETCD_URL>`。

          -   Linux 及 OS X：

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   輸出範例：

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows：<ol>
            <li>取得 kube-system 名稱空間中的 Pod 清單，並找出 Calico 控制器 Pod。</br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>範例：</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>檢視 Calico 控制器 Pod 的詳細資料。</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>找出 ETCD 端點值。範例：<code>https://169.1.1.1:30001</code>
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
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows：<ol><li>開啟您在最後一個步驟中擷取的目錄。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
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

    -   檢視已為叢集建立的所有 Calico 及 Kubernetes 網路原則。這份清單包含可能尚未套用至任何 Pod 或主機的原則。若要強制執行網路原則，則必須找到符合 Calico 網路原則中所定義之選取器的 Kubernetes 資源。

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

    1.  建立配置 Script (.yaml)，以定義 [Calico 網路原則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy)。這些配置檔包含選取器，其說明這些原則適用的 Pod、名稱空間或主機。請參閱這些 [Calico 原則範例 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy)，以協助您建立自己的原則。

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


## 映像檔
{: #cs_security_deployment}

使用內建安全特性來管理映像檔的安全及完整性。
{: shortdesc}

### {{site.data.keyword.registryshort_notm}} 中的安全 Docker 專用映像檔儲存庫：

 您可以在多方承租戶中設定您自己的 Docker 映像檔儲存庫、高可用性，以及由 IBM 所管理的可擴充專用映像檔儲存庫，以建置、安全地儲存 Docker 映像檔，並且在叢集使用者之間進行共用。

### 映像檔安全相符性：

當您使用 {{site.data.keyword.registryshort_notm}} 時，可以運用「漏洞警告器」所提供的內建安全掃描。會自動掃描每個推送至您名稱空間的映像檔，以對照已知 CentOS、Debian、Red Hat 及 Ubuntu 問題資料庫，掃描漏洞。如果發現漏洞，「漏洞警告器」會提供其解決方式的指示，以確保映像檔的完整性及安全。

若要檢視映像檔的漏洞評量，請執行下列動作：

1.  從**型錄**中，選取**容器**。
2.  選取您要查看漏洞評量的映像檔。
3.  在**漏洞評量**區段中，按一下**檢視報告**。
