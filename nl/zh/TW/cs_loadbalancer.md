---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

---

{:new_window: target="_blank"}
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



# 使用負載平衡器公開應用程式
{: #loadbalancer}

公開埠並使用可攜式 IP 位址，讓第 4 層負載平衡器可以存取容器化應用程式。
{:shortdesc}

當您建立標準叢集時，{{site.data.keyword.containerlong}} 會自動佈建 1 個可攜式公用子網路及 1 個可攜式專用子網路。

* 可攜式公用子網路提供 5 個可用 IP 位址。1 個可攜式公用 IP 位址是由預設[公用 Ingress ALB](cs_ingress.html) 使用。藉由建立公用負載平衡器服務，即可使用其餘 4 個可攜式公用 IP 位址，將單一應用程式公開至網際網路。
* 可攜式專用子網路提供 5 個可用 IP 位址。1 個可攜式專用 IP 位址是由預設[專用 Ingress ALB](cs_ingress.html#private_ingress) 使用。藉由建立專用負載平衡器服務，即可使用其餘 4 個可攜式專用 IP 位址，將單一應用程式公開至專用網路。

可攜式公用及專用 IP 位址是靜態浮動 IP，而且不會在移除工作者節點時變更。如果移除負載平衡器 IP 位址所在的工作者節點，則持續監視 IP 的 Keepalived 常駐程式會自動將 IP 移至另一個工作者節點。您可以將任何埠指派給負載平衡器，而且未連結至特定埠範圍。負載平衡器服務是作為應用程式送入要求的外部進入點。若要從網際網路存取負載平衡器服務，請使用負載平衡器的公用 IP 位址以及 `<IP_address>:<port>` 格式的已指派埠。

當您利用負載平衡器服務公開應用程式時，也會透過服務的 NodePorts 自動讓您的應用程式可供使用。叢集內每個工作者節點的每個公用及專用 IP 位址上都可以存取 [NodePort](cs_nodeport.html)。若要在使用負載平衡器服務時封鎖流向 NodePort 的資料流量，請參閱[控制負載平衡器或 NodePort 服務的入埠資料流量](cs_network_policy.html#block_ingress)。

## 負載平衡器 2.0 元件及架構（測試版）
{: #planning_ipvs}

測試版提供負載平衡器 2.0 功能。若要使用 2.0 版負載平衡器，您必須[更新叢集的主節點及工作者節點](cs_cluster_update.html)至 Kubernets 1.12 版或更新版本。
{: note}

負載平衡器 2.0 是使用 Linux Kernel 的「IP 虛擬伺服器 (IPVS)」來實作的「第 4 層」負載平衡器。負載平衡器 2.0 支援 TCP 及 UDP、在多個工作者節點的前面執行，並使用 IP over IP (IPIP) 通道作業，將到達單一負載平衡器 IP 位址的資料流量分佈在那些工作者節點之間。

如需詳細資料，您也可以參閱這篇有關負載平衡器 2.0 的[部落格文章 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/)。

### 1.0 版與 2.0 版負載平衡器有何類似之處？
{: #similarities}

1.0 版及 2.0 版負載平衡器都是「第 4 層」負載平衡器，僅存在於 Linux Kernel 空間中。這兩個版本都在叢集內執行，並使用工作者節點資源。因此，負載平衡器的可用容量一律專用於您自己的叢集。此外，這兩個版本的負載平衡器不會終止連線。相反地，它們會將連線轉遞至應用程式 Pod。

### 1.0 版與 2.0 版負載平衡器有何不同？
{: #differences}

當用戶端將要求傳送至您的應用程式時，負載平衡器會將要求封包遞送至應用程式 Pod 所在的工作者節點 IP 位址。1.0 版負載平衡器會使用網址轉換 (NAT)，將要求封包的來源 IP 位址重寫為負載平衡器 Pod 所在之工作者節點的 IP。當工作者節點傳回應用程式回應封包時，它會使用負載平衡器所在的工作者節點 IP。然後，負載平衡器必須將回應封包傳送至用戶端。若要防止 IP 位址重寫，您可以[啟用來源 IP 保留](#node_affinity_tolerations)。不過，來源 IP 保留需要負載平衡器 Pod 和應用程式 Pod 在相同的工作者節點上執行，以便要求不需要轉遞至另一個工作者節點。您必須將節點親緣性及容忍新增至應用程式 Pod。

相對於 1.0 版負載平衡器，2.0 版負載平衡器在轉遞要求至其他工作者節點上的應用程式 Pod 時，不會使用 NAT。當負載平衡器 2.0 遞送用戶端要求時，它會使用 IP over IP (IPIP)，將原始要求封包封裝至另一個新封包。此封裝 IPIP 封包具有負載平衡器 Pod 所在之工作者節點的來源 IP，如此可讓原始要求封包保留用戶端 IP 作為其來源 IP 位址。然後，工作者節點會使用直接伺服器傳回 (DSR)，將應用程式回應封包傳送至用戶端 IP。回應封包會跳過負載平衡器，並直接傳送至用戶端，因而可減少負載平衡器必須處理的資料流量。

### 如何使用單一區域叢集中的 2.0 版負載平衡器，讓要求傳入我的應用程式？
{: #ipvs_single}

下圖顯示負載平衡器 2.0 如何將通訊從網際網路導向至單一區域叢集中的應用程式。

<img src="images/cs_loadbalancer_ipvs_planning.png" width="550" alt="使用 2.0 版負載平衡器公開 {{site.data.keyword.containerlong_notm}} 中的應用程式" style="width:550px; border-style: none"/>

1. 應用程式的用戶端要求會使用負載平衡器的公用 IP 位址，以及工作者節點上的已指派埠。在此範例中，負載平衡器的虛擬 IP 位址為 169.61.23.130，目前位於工作者節點 10.73.14.25 上。

2. 負載平衡器會在 IPIP 封包（標示為 "IPIP"）內封裝用戶端要求封包（標示為映像檔中的 "CR"）。用戶端要求封包會將用戶端 IP 保留為其來源 IP 位址。IPIP 封裝封包會使用工作者節點 10.73.14.25 IP 作為其來源 IP 位址。

3. 負載平衡器會將 IPIP 封包遞送至應用程式 Pod 所在的工作者節點，即 10.73.14.26。如果叢集中已部署多個應用程式實例，則負載平衡器會在應用程式 Pod 部署所在的工作者節點之間遞送要求。

4. 工作者節點 10.73.14.26 會解壓縮 IPIP 封裝封包，然後解壓縮用戶端要求封包。用戶端要求封包會轉遞至該工作者節點上的應用程式 Pod。

5. 然後，工作者節點 10.73.14.26 會使用來自原始要求封包的來源 IP 位址（用戶端 IP），將應用程式 Pod 的回應封包直接傳回給用戶端。

### 如何使用多區域叢集中的 2.0 版負載平衡器，讓要求傳入我的應用程式？
{: #ipvs_multi}

透過多區域叢集的資料傳輸流與[透過單一區域叢集的資料傳輸流](#ipvs_single)遵循相同的路徑。在多區域叢集中，負載平衡器會將要求遞送至其專屬區域中的應用程式實例，以及遞送至其他區域中的應用程式實例。下圖顯示每一個區域中的 2.0 版負載平衡器如何將網際網路中的資料流量導向至多區域叢集中的應用程式。

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="使用負載平衡器 2.0 公開 {{site.data.keyword.containerlong_notm}} 中的應用程式" style="width:500px; border-style: none"/>

依預設，每一個 2.0 版負載平衡器只會設定在某個區域中。在您具有應用程式實例的每個區域中部署 2.0 版負載平衡器，即可達到更高可用性。

<br />


## 負載平衡器 2.0 排程演算法
{: #scheduling}

排程演算法決定 2.0 版負載平衡器如何將網路連線指派給您的應用程式 Pod。當用戶端要求到達您的叢集時，負載平衡器會根據排程演算法，將要求封包遞送至工作者節點。若要使用排程演算法，請在負載平衡器服務配置檔的排程器註釋中指定其 Keepalived 簡稱：`service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`。請檢查下列清單，以查看 {{site.data.keyword.containerlong_notm}} 中支援哪些排程演算法。如果您未指定排程演算法，則依預設會使用「循環式」演算法。如需相關資訊，請參閱 [Keepalived 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://www.Keepalived.org/doc/scheduling_algorithms.html)。

### 支援的排程演算法
{: #scheduling_supported}

<dl>
<dt>循環式 (<code>rr</code>)</dt>
<dd>將連線遞送至工作者節點時，負載平衡器會在整個應用程式 Pod 清單中循環，同等地對待每一個應用程式 Pod。「循環式」是 2.0 版負載平衡器的預設排程演算法。</dd>
<dt>來源雜湊 (<code>sh</code>)</dt>
<dd>負載平衡器會根據用戶端要求封包的來源 IP 位址來產生雜湊金鑰。然後，負載平衡器會在靜態指派的雜湊表中查閱雜湊金鑰，並將該要求遞送至處理該範圍雜湊的應用程式 Pod。此演算法可確保來自特定用戶端的要求一律導向至相同的應用程式 Pod。</br>**附註**：Kubernetes 會使用 Iptables 規則，這會導致將要求傳送至工作者節點的隨機 Pod。若要使用此排程演算法，您必須確保每個工作者節點都只部署一個應用程式 Pod。例如，如果每個 Pod 都有標籤 <code>run=&lt;app_name&gt;</code>，請將下列反親緣性規則新增至應用程式部署的 <code>spec</code> 區段：</br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

您可以在[這個 IBM Cloud 部署型樣部落格 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/) 中找到完整範例。</dd>
</dl>

### 不受支援的排程演算法
{: #scheduling_unsupported}

<dl>
<dt>目的地雜湊 (<code>dh</code>)</dt>
<dd>封包的目的地（即負載平衡器 IP 位址及埠）是用來判定哪個工作者節點會處理送入的要求。不過，{{site.data.keyword.containerlong_notm}} 中負載平衡器的 IP 位址及埠不會變更。負載平衡器被迫將要求保留在其所在之相同工作者節點內，因此只有某個工作者節點上的應用程式 Pod 才可處理所有送入的要求。</dd>
<dt>動態連線計數演算法</dt>
<dd>下列演算法取決於用戶端與負載平衡器之間的動態連線計數。不過，因為直接服務傳回 (DSR) 會避免負載平衡器 2.0 Pod 在傳回封包路徑中，因此負載平衡器不會追蹤已建立的連線。<ul>
<li>最少連線 (<code>lc</code>)</li>
<li>地區型最少連線 (<code>lblc</code>)</li>
<li>搭配抄寫的地區型最少連線 (<code>lblcr</code>)</li>
<li>永不列入佇列 (<code>nq</code>)</li>
<li>最短的預期延遲 (<code>seq</code>)</li></ul></dd>
<dt>加權 Pod 演算法</dt>
<dd>下列演算法取決於加權應用程式 Pod。不過，在 {{site.data.keyword.containerlong_notm}} 中，所有應用程式 Pod 都會獲指派相等的負載平衡加權。<ul>
<li>加權最少連線 (<code>wlc</code>)</li>
<li>加權循環式 (<code>wrr</code>)</li></ul></dd></dl>

<br />


## 負載平衡器 2.0 必要條件
{: #ipvs_provision}

您無法將現有的 1.0 版負載平衡器更新至 2.0。您必須建立新的 2.0 版負載平衡器。請注意，您可以在叢集中同步執行 1.0 版和 2.0 版負載平衡器。

在建立 2.0 版負載平衡器之前，您必須完成下列必要步驟。

1. [更新叢集的主節點及工作者節點](cs_cluster_update.html)至 Kubernetes 1.12 版或更新版本。

2. 若要容許負載平衡器 2.0 將要求轉遞至多個區域中的應用程式 Pod，請開立支援案例以要求 VLAN 的配置設定。**重要事項**：您必須針對所有公用 VLAN 要求此配置。如果您要求新的關聯 VLAN，則必須針對該 VLAN 開立另一個問題單。
    1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)。
    2. 在功能表中，導覽至**基礎架構**，然後導覽至**支援 > 新增問題單**。
    3. 在案例欄位中，選取**技術**、**基礎架構**，以及**公用網路問題。**
    4. 將下列資訊新增至說明：「請設定網路，以容許在與我的帳戶相關聯的公用 VLAN 上進行容量聚集。此要求的參照問題單如下：https://control.softlayer.com/support/tickets/63859145」。
    5. 按一下**提交問題單**。

3. 將 VLAN 配置為具有容量聚集之後，請針對您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)。啟用 VLAN Spanning 時，2.0 版負載平衡器可以將封包遞送至帳戶中的各種子網路。

4. 如果您使用 [Calleo 前置 DNAT 網路原則](cs_network_policy.html#block_ingress)，來管理 2.0 版負載平衡器之 IP 位址的資料流量，則必須將 `applyOnForward: true` 及 `doNotTrack: true` 欄位新增至原則中的 `spec` 區段。`applyOnForward: true` 確保在封裝和轉遞時，將 Calico 原則套用至資料流量。`doNotTrack: true` 確保工作者節點可以使用 DSR，直接將回應封包傳回給用戶端，而不需要追蹤連線。例如，如果您使用 Calico 原則，僅將從特定 IP 位址到負載平衡器 IP 位址的資料流量列入白名單，則此原則與下列內容類似：
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

接下來，您可以遵循[在多區域叢集中設定負載平衡器 2.0](#ipvs_multi_zone_config) 或[在單一區域叢集中設定負載平衡器 2.0](#ipvs_single_zone_config) 中的步驟。

<br />


## 在多區域叢集中設定負載平衡器 2.0
{: #ipvs_multi_zone_config}

負載平衡器服務僅適用於標準叢集，而且不支援 TLS 終止。如果您的應用程式需要 TLS 終止，您可以使用 [Ingress](cs_ingress.html) 來公開應用程式，或配置應用程式來管理 TLS 終止。
{: note}

**開始之前**：

  * **重要事項**：請完成[負載平衡器 2.0 必要條件](#ipvs_provision)。
  * 若要在多個區域中建立公用負載平衡器，則必須至少有一個公用 VLAN 在每一個區域中具有可用的可攜式子網路。若要在多個區域中建立專用負載平衡器，則必須至少有一個專用 VLAN 在每一個區域中具有可用的可攜式子網路。若要新增子網路，請參閱[配置叢集的子網路](cs_subnets.html)。
  * 如果您將網路資料流量限制為邊緣工作者節點，請確定在每一個區域中至少啟用 2 個[邊緣工作者節點](cs_edge.html#edge)。如果在部分區域中啟用邊緣工作者節點，但在其他區域中未啟用，則不會統一部署負載平衡器。負載平衡器將會部署至部分區域中的邊緣節點，但不會部署至其他區域中的一般工作者節點。


若要在多區域叢集中設定負載平衡器 2.0，請執行下列動作：
1.  [將應用程式部署至叢集](cs_app.html#app_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。

2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路或專用網路上使用，請建立應用程式的 Kubernetes 服務。請配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
  1. 例如，建立名稱為 `myloadbalancer.yaml` 的服務配置檔。
  2. 為您要公開的應用程式定義負載平衡器服務。您可以指定區域、VLAN 及 IP 位址。

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
      ```
      {: codeblock}

      <table>
      <caption>瞭解 YAML 檔案元件</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
          <td>用來指定負載平衡器類型的註釋。接受值為 <code>private</code> 及 <code>public</code>。如果您要在公用 VLAN 的叢集中建立公用負載平衡器，則不需要此註釋。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>用來指定負載平衡器服務要部署至其中之區域的註釋。若要查看區域，請執行 <code>ibmcloud ks zones</code>。</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>用來指定負載平衡器服務要部署至其中之 VLAN 的註釋。若要查看 VLAN，請執行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>用來指定 2.0 版負載平衡器的註釋。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>選用項目：用來指定排程演算法的註釋。接受值為 <code>"rr"</code> 代表「循環式」（預設值）或 <code>"sh"</code> 代表「來源雜湊」。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>輸入標籤索引鍵 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將 Pod 設為目標，並在服務負載平衡中包括它們，請勾選 <em>&lt;selectorkey&gt;</em> 及 <em>&lt;selectorvalue&gt;</em> 值。確定它們與您在部署 yaml 的 <code>spec.template.metadata.labels</code> 區段中所使用的<em>鍵值組</em> 相同。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>服務所接聽的埠。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>選用項目：若要建立專用負載平衡器，或針對公用負載平衡器使用特定的可攜式 IP 位址，請將 <em>&lt;IP_address&gt;</em> 取代為您要使用的 IP 位址。如果您指定 VLAN 或區域，則 IP 位址必須位於該 VLAN 或區域中。如果您未指定 IP 位址：<ul><li>如果叢集是在公用 VLAN 上，則會使用可攜式公用 IP 位址。大部分叢集都在公用 VLAN 上。</li><li>如果您的叢集只能在專用 VLAN 上使用，則會使用可攜式專用 IP 位址。</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>設為 <code>Local</code>。</td>
      </tr>
      </tbody></table>

      這個範例配置檔用來在 `dal12` 中建立使用「循環式」排程演算法的負載平衡器 2.0 服務：

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. 選用項目：在 **spec** 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

  4. 在叢集裡建立服務。

      ```
        kubectl apply -f myloadbalancer.yaml
        ```
      {: pre}

3. 驗證已順利建立負載平衡器服務。將 _&lt;myservice&gt;_ 取代為您在前一個步驟中建立之負載平衡器服務的名稱。這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，並讓應用程式可供使用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 輸出範例：

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。

4.  如果您已建立公用負載平衡器，請從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 若要達到高可用性，請重複上述步驟，在您具有應用程式實例的每一個區域中新增負載平衡器 2.0。

6. 選用項目：負載平衡器服務也可讓您的應用程式透過服務的 NodePort 提供使用。叢集內每個節點的每個公用及專用 IP 位址上都可以存取 [NodePort](cs_nodeport.html)。若要在使用負載平衡器服務時封鎖流向 NodePort 的資料流量，請參閱[控制負載平衡器或 NodePort 服務的入埠資料流量](cs_network_policy.html#block_ingress)。

## 在單一區域叢集中設定負載平衡器 2.0
{: #ipvs_single_zone_config}

開始之前：

* 只有標準叢集才能使用此特性。
* 您必須要有可指派給負載平衡器服務的可攜式公用或專用 IP 位址。
* **重要事項**：請完成[負載平衡器 2.0 必要條件](#ipvs_provision)。

若要在單一區域叢集中建立負載平衡器 2.0 服務，請執行下列動作：

1.  [將應用程式部署至叢集](cs_app.html#app_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。
2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路或專用網路上使用，請建立應用程式的 Kubernetes 服務。請配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
    1.  例如，建立名稱為 `myloadbalancer.yaml` 的服務配置檔。

    2.  為您要公開的應用程式定義負載平衡器 2.0 服務。
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>瞭解 YAML 檔案元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>用來指定負載平衡器類型的註釋。接受值為 `private` 及 `public`。如果您要在公用 VLAN 的叢集中建立公用負載平衡器，則不需要此註釋。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>用來指定負載平衡器服務要部署至其中之 VLAN 的註釋。若要查看 VLAN，請執行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>用來指定負載平衡器 2.0 的註釋。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>用來指定排程演算法的註釋。接受值為 <code>"rr"</code> 代表「循環式」（預設值）或 <code>"sh"</code> 代表「來源雜湊」。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>輸入標籤索引鍵 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將 Pod 設為目標，並在服務負載平衡中包括它們，請勾選 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 值。確定它們與您在部署 yaml 的 <code>spec.template.metadata.labels</code> 區段中所使用的<em>鍵值組</em> 相同。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服務所接聽的埠。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>選用項目：若要建立專用負載平衡器，或針對公用負載平衡器使用特定的可攜式 IP 位址，請將 <em>&lt;IP_address&gt;</em> 取代為您要使用的 IP 位址。如果您指定 VLAN，則 IP 位址必須位於該 VLAN 上。如果您未指定 IP 位址：<ul><li>如果叢集是在公用 VLAN 上，則會使用可攜式公用 IP 位址。大部分叢集都在公用 VLAN 上。</li><li>如果您的叢集只能在專用 VLAN 上使用，則會使用可攜式專用 IP 位址。</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>設為 <code>Local</code>。</td>
        </tr>
        </tbody></table>

    3.  選用項目：在 **spec** 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在叢集裡建立服務。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

                若已建立負載平衡器服務，可攜式 IP 位址即會自動指派給負載平衡器。如果沒有可用的可攜式 IP 位址，則無法建立負載平衡器服務。


3.  驗證已順利建立負載平衡器服務。這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，並讓應用程式可供使用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 輸出範例：

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。

4.  如果您已建立公用負載平衡器，請從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 選用項目：負載平衡器服務也可讓您的應用程式透過服務的 NodePort 提供使用。叢集內每個節點的每個公用及專用 IP 位址上都可以存取 [NodePort](cs_nodeport.html)。若要在使用負載平衡器服務時封鎖流向 NodePort 的資料流量，請參閱[控制負載平衡器或 NodePort 服務的入埠資料流量](cs_network_policy.html#block_ingress)。

<br />


## 負載平衡器 1.0 元件及架構
{: #planning}

TCP/UDP 負載平衡器 1.0 會使用 Iptables（Linux Kernel 特性），跨應用程式的 Pod 對要求進行負載平衡。

**如何使用單一區域叢集中的 1.0 版負載平衡器，讓要求傳入我的應用程式？**

下圖顯示負載平衡器 1.0 如何將通訊從網際網路導向至應用程式。

<img src="images/cs_loadbalancer_planning.png" width="450" alt="使用負載平衡器 1.0 公開 {{site.data.keyword.containerlong_notm}} 中的應用程式" style="width:450px; border-style: none"/>

1. 應用程式的要求使用負載平衡器的公用 IP 位址及工作者節點上的已指派埠。

2. 該要求會自動轉遞至負載平衡器服務的內部叢集 IP 位址及埠。內部叢集 IP 位址只能在叢集內部存取。

3. `kube-proxy` 會將要求遞送至應用程式的 Kubernetes 負載平衡器服務。

4. 要求會轉遞至應用程式 Pod 的專用 IP 位址。要求套件的來源 IP 位址會變更為應用程式 Pod 執行所在之工作者節點的公用 IP 位址。如果叢集裡已部署多個應用程式實例，則負載平衡器會在應用程式 Pod 之間遞送要求。

**如何使用多區域叢集中的 1.0 版負載平衡器，讓要求傳入我的應用程式？**

如果您有多區域叢集，則應用程式實例會部署至不同區域的工作者節點上的 Pod。下圖顯示負載平衡器 1.0 如何將通訊從網際網路導向至多區域叢集中的應用程式。

<img src="images/cs_loadbalancer_planning_multizone.png" width="475" alt="使用負載平衡器 1.0 對多區域叢集中的應用程式進行負載平衡" style="width:475px; border-style: none"/>

依預設，每一個負載平衡器 1.0 只會設定在某個區域中。若要達到高可用性，必須在您具有應用程式實例的每個區域中部署負載平衡器 1.0。各種區域中的負載平衡器會以循環式週期處理要求。此外，每一個負載平衡器都會將要求遞送至其專屬區域中的應用程式實例，以及遞送至其他區域中的應用程式實例。

<br />


## 在多區域叢集中設定負載平衡器 1.0
{: #multi_zone_config}

負載平衡器服務僅適用於標準叢集，而且不支援 TLS 終止。如果您的應用程式需要 TLS 終止，您可以使用 [Ingress](cs_ingress.html) 來公開應用程式，或配置應用程式來管理 TLS 終止。
{: note}

**開始之前**：
  * 您必須在每一個區域中部署負載平衡器，且每一個負載平衡器獲指派其本身在該區域的 IP 位址。若要建立公用負載平衡器，則必須至少有一個公用 VLAN 在每一個區域中具有可用的可攜式子網路。若要新增專用負載平衡器服務，則必須至少有一個專用 VLAN 在每一個區域中具有可用的可攜式子網路。若要新增子網路，請參閱[配置叢集的子網路](cs_subnets.html)。
  * 如果您將網路資料流量限制為邊緣工作者節點，請確定在每一個區域中至少啟用 2 個[邊緣工作者節點](cs_edge.html#edge)。如果在部分區域中啟用邊緣工作者節點，但在其他區域中未啟用，則不會統一部署負載平衡器。負載平衡器將會部署至部分區域中的邊緣節點，但不會部署至其他區域中的一般工作者節點。
  * 針對您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud s vlan-spanning` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。


若要在多區域叢集中設定負載平衡器 1.0 服務，請執行下列動作：
1.  [將應用程式部署至叢集](cs_app.html#app_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。

2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路或專用網路上使用，請建立應用程式的 Kubernetes 服務。請配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
  1. 例如，建立名稱為 `myloadbalancer.yaml` 的服務配置檔。
  2. 為您要公開的應用程式定義負載平衡器服務。您可以指定區域、VLAN 及 IP 位址。

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
        ```
      {: codeblock}

      <table>
      <caption>瞭解 YAML 檔案元件</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
          <td>用來指定負載平衡器類型的註釋。接受值為 <code>private</code> 及 <code>public</code>。如果您要在公用 VLAN 的叢集中建立公用負載平衡器，則不需要此註釋。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>用來指定負載平衡器服務要部署至其中之區域的註釋。若要查看區域，請執行 <code>ibmcloud ks zones</code>。</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>用來指定負載平衡器服務要部署至其中之 VLAN 的註釋。若要查看 VLAN，請執行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>輸入標籤索引鍵 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將 Pod 設為目標，並在服務負載平衡中包括它們，請勾選 <em>&lt;selectorkey&gt;</em> 及 <em>&lt;selectorvalue&gt;</em> 值。確定它們與您在部署 yaml 的 <code>spec.template.metadata.labels</code> 區段中所使用的<em>鍵值組</em> 相同。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>服務所接聽的埠。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>選用項目：若要建立專用負載平衡器，或針對公用負載平衡器使用特定的可攜式 IP 位址，請將 <em>&lt;IP_address&gt;</em> 取代為您要使用的 IP 位址。如果您指定 VLAN 或區域，則 IP 位址必須位於該 VLAN 或區域中。如果您未指定 IP 位址：<ul><li>如果叢集是在公用 VLAN 上，則會使用可攜式公用 IP 位址。大部分叢集都在公用 VLAN 上。</li><li>如果您的叢集只能在專用 VLAN 上使用，則會使用可攜式專用 IP 位址。</li></ul></td>
      </tr>
      </tbody></table>

      這個範例配置檔用來建立專用負載平衡器 1.0 服務，其會使用 `dal12` 中專用 VLAN `2234945` 上指定的 IP 位址：

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. 選用項目：在 **spec** 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

  4. 在叢集裡建立服務。

      ```
        kubectl apply -f myloadbalancer.yaml
        ```
      {: pre}

3. 驗證已順利建立負載平衡器服務。將 _&lt;myservice&gt;_ 取代為您在前一個步驟中建立之負載平衡器服務的名稱。這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，並讓應用程式可供使用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 輸出範例：

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。

4.  如果您已建立公用負載平衡器，請從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. 如果您選擇[針對 1.0 版負載平衡器服務啟用來源 IP 保留 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)，請確保藉由[將邊緣節點親緣性新增至應用程式 Pod](cs_loadbalancer.html#edge_nodes)，在邊緣工作者節點上排定應用程式 Pod。必須在邊緣節點上排定應用程式 Pod，才能接收送入要求。

6. 重複上述步驟，在每一個區域中新增 1.0 版負載平衡器。

7. 選用項目：負載平衡器服務也可讓您的應用程式透過服務的 NodePort 提供使用。叢集內每個節點的每個公用及專用 IP 位址上都可以存取 [NodePort](cs_nodeport.html)。若要在使用負載平衡器服務時封鎖流向 NodePort 的資料流量，請參閱[控制負載平衡器或 NodePort 服務的入埠資料流量](cs_network_policy.html#block_ingress)。

## 在單一區域叢集中設定負載平衡器 1.0
{: #config}

開始之前：

* 只有標準叢集才能使用此特性。
* 您必須要有可指派給負載平衡器服務的可攜式公用或專用 IP 位址。

若要在單一區域叢集中建立負載平衡器 1.0 服務，請執行下列動作：

1.  [將應用程式部署至叢集](cs_app.html#app_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。
2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路或專用網路上使用，請建立應用程式的 Kubernetes 服務。請配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
    1.  例如，建立名稱為 `myloadbalancer.yaml` 的服務配置檔。

    2.  為您要公開的應用程式定義負載平衡器服務。
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>瞭解 YAML 檔案元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>用來指定負載平衡器類型的註釋。接受值為 `private` 及 `public`。如果您要在公用 VLAN 的叢集中建立公用負載平衡器，則不需要此註釋。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>用來指定負載平衡器服務要部署至其中之 VLAN 的註釋。若要查看 VLAN，請執行 <code>ibmcloud ks vlans --zone <zone></code>。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>輸入標籤索引鍵 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將 Pod 設為目標，並在服務負載平衡中包括它們，請勾選 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 值。確定它們與您在部署 yaml 的 <code>spec.template.metadata.labels</code> 區段中所使用的<em>鍵值組</em> 相同。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>服務所接聽的埠。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>選用項目：若要建立專用負載平衡器，或針對公用負載平衡器使用特定的可攜式 IP 位址，請將 <em>&lt;IP_address&gt;</em> 取代為您要使用的 IP 位址。如果您指定 VLAN，則 IP 位址必須位於該 VLAN 上。如果您未指定 IP 位址：<ul><li>如果叢集是在公用 VLAN 上，則會使用可攜式公用 IP 位址。大部分叢集都在公用 VLAN 上。</li><li>如果您的叢集只能在專用 VLAN 上使用，則會使用可攜式專用 IP 位址。</li></ul></td>
        </tr>
        </tbody></table>

        這個範例配置檔用來建立專用負載平衡器 1.0 服務，其會使用專用 VLAN `2234945` 上指定的 IP 位址：

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3.  選用項目：在 **spec** 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。

    4.  在叢集裡建立服務。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

                若已建立負載平衡器服務，可攜式 IP 位址即會自動指派給負載平衡器。如果沒有可用的可攜式 IP 位址，則無法建立負載平衡器服務。


3.  驗證已順利建立負載平衡器服務。這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，並讓應用程式可供使用。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 輸出範例：

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。

4.  如果您已建立公用負載平衡器，請從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 如果您選擇[針對負載平衡器 1.0 服務啟用來源 IP 保留 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)，請確保藉由[將邊緣節點親緣性新增至應用程式 Pod](cs_loadbalancer.html#edge_nodes)，在邊緣工作者節點上排定應用程式 Pod。必須在邊緣節點上排定應用程式 Pod，才能接收送入要求。

6. 選用項目：負載平衡器服務也可讓您的應用程式透過服務的 NodePort 提供使用。叢集內每個節點的每個公用及專用 IP 位址上都可以存取 [NodePort](cs_nodeport.html)。若要在使用負載平衡器服務時封鎖流向 NodePort 的資料流量，請參閱[控制負載平衡器或 NodePort 服務的入埠資料流量](cs_network_policy.html#block_ingress)。

<br />


## 針對 1.0 版負載平衡器啟用來源 IP 保留
{: #node_affinity_tolerations}

此特性僅適用於 1.0 版負載平衡器。在 2.0 版負載平衡器中，依預設會保留用戶端要求的來源 IP 位址。
{: note}

將應用程式的用戶端要求傳送至叢集時，負載平衡器服務 Pod 會接收此要求。如果沒有應用程式 Pod 存在於與負載平衡器服務 Pod 相同的工作者節點上，則負載平衡器會將要求轉遞至不同工作者節點上的應用程式 Pod。套件的來源 IP 位址會變更為負載平衡器服務 Pod 執行所在之工作者節點的公用 IP 位址。

若要保留用戶端要求的原始來源 IP 位址，您可以針對負載平衡器服務[啟用來源 IP ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip)。TCP 連線會繼續一路連線至應用程式 Pod，讓應用程式可以看到起始器的實際來源 IP 位址。例如，當應用程式伺服器必須套用安全及存取控制原則時，保留用戶端的 IP 是很有用的。

在啟用來源 IP 之後，負載平衡器服務 Pod 必須將要求轉遞至僅部署至相同工作者節點的應用程式 Pod。一般而言，負載平衡器服務 Pod 也會部署至應用程式 Pod 部署至其中的工作者節點。不過，存在某些狀況，可能未在相同的工作者節點上排定負載平衡器 Pod 及應用程式 Pod。


* 您有已受污染、因此僅負載平衡器服務 Pod 可以部署至其中的邊緣節點。不允許將應用程式 Pod 部署至那些節點。
* 您的叢集連接至多個公用或專用 VLAN，但您的應用程式 Pod 可能部署至僅連接至某個 VLAN 的工作者節點。負載平衡器服務 Pod 可能未部署至那些工作者節點，因為負載平衡器 IP 位址連接至不同於工作者節點的 VLAN。

若要將您的應用程式強制部署至負載平衡器服務 Pod 也可以部署至其中的特定工作者節點，您必須將親緣性規則及容忍新增至您的應用程式部署。

### 新增邊緣節點親緣性規則及容忍
{: #edge_nodes}

當您[將工作者節點標示為邊緣節點](cs_edge.html#edge_nodes)，且同時[污染邊緣節點](cs_edge.html#edge_workloads)時，負載平衡器服務 Pod 只會部署至那些邊緣節點，而且應用程式 Pod 無法部署至邊緣節點。啟用負載平衡器服務的來源 IP 時，邊緣節點上的負載平衡器 Pod 無法將送入要求轉遞至其他工作者節點上的應用程式 Pod。
{:shortdesc}

若要強制您的應用程式 Pod 部署至邊緣節點，請將邊緣節點[親緣性規則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) 及[容忍 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) 新增至應用程式部署。

具有邊緣節點親緣性及邊緣節點容忍的部署 YAML 檔案範例：

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

**affinity** 及 **tolerations** 區段同時具有 `dedicated` 作為 `key`，及具有 `edge` 作為 `value`。

### 新增多個公用或專用 VLAN 的親緣性規則
{: #edge_nodes_multiple_vlans}

當您的叢集連接至多個公用或專用 VLAN 時，您的應用程式 Pod 可能部署至僅連接至某個 VLAN 的工作者節點。如果負載平衡器 IP 位址連接至與這些工作者節點不同的 VLAN，則負載平衡器服務 Pod 不會部署至那些工作者節點。
{:shortdesc}

啟用來源 IP 時，請將親緣性規則新增至應用程式部署，以在其 VLAN 與負載平衡器的 IP 位址相同的工作者節點上排定應用程式 Pod。

開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

1. 取得負載平衡器服務的 IP 位址。在 **LoadBalancer Ingress** 欄位中尋找 IP 位址。
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. 擷取負載平衡器服務連接至其中的 VLAN ID。

    1. 列出叢集的可攜式公用 VLAN。
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
        ```
        {: pre}

        輸出範例：
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. 在 **Subnet VLANs** 下的輸出中，尋找符合您先前所擷取之負載平衡器 IP 位址的子網路 CIDR，並記下 VLAN ID。

        例如，如果負載平衡器服務 IP 位址為 `169.36.5.xxx`，則前一個步驟之輸出範例中的相符子網路為 `169.36.5.xxx/29`。子網路連接至其中的 VLAN ID 為 `22334945`。

3. 針對您在前一個步驟中記下的 VLAN ID，[新增親緣性規則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) 至應用程式部署。

    比方說，如果您有數個 VLAN，但想要應用程式 Pod 僅部署至 `2234945` 公用 VLAN 上的工作者節點，請執行下列指令：

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    在 YAML 範例中，**affinity** 區段具有 `publicVLAN` 作為 `key`，以及具有 `"224945"` 作為 `value`。

4. 套用已更新的部署配置檔。
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. 驗證部署至工作者節點的應用程式 Pod 是否已連接至指定的 VLAN。

    1. 列出叢集裡的 Pod。將 `<selector>` 取代為您用於應用程式的標籤。
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        輸出範例：
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 在輸出中，識別應用程式的 Pod。記下 Pod 所在之工作者節點的**節點** ID。

        在前一個步驟的輸出範例中，應用程式 Pod `cf-py-d7b7d94db-vp8pq` 位於工作者節點 `10.176.48.78` 上。

    3. 列出工作者節點的詳細資料。

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        輸出範例：

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. 在輸出的 **Labels** 區段中，驗證公用或專用 VLAN 是否為您在先前步驟中指定的 VLAN。
