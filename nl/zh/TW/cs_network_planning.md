---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 規劃叢集網路
{: #planning}

使用 {{site.data.keyword.containerlong}}，您可以讓應用程式可供公用或專用存取，來管理外部網路以及管理叢集內的內部網路。
{: shortdesc}

## 選擇 NodePort、LoadBalancer 或 Ingress 服務
{: #external}

為了讓應用程式可從[公用網際網路](#public_access)或[專用網路](#private_both_vlans)外部進行存取，{{site.data.keyword.containershort_notm}} 支援三個網路服務。
{:shortdesc}

**[NodePort 服務](cs_nodeport.html)**（免費及標準叢集）
* 公開每個工作者節點上的埠，並使用任何工作者節點的公用或專用 IP 位址來存取您在叢集裡的服務。
* Iptables 是一種 Linux Kernel 特性，可對應用程式 Pod 之間的要求進行負載平衡、提供高效能網路遞送，以及提供網路存取控制。
* 工作者節點的公用及專用 IP 位址不是永久性的。移除或重建工作者節點時，會將新的公用及新的專用 IP 位址指派給工作者節點。
* NodePort 服務十分適用於測試公用或專用存取。如果您只是短時間需要公用或專用存取，也可以使用此選項。

**[LoadBalancer 服務](cs_loadbalancer.html)**（僅限標準叢集）
* 每個標準叢集裡都會佈建四個可攜式公用 IP 位址及四個可攜式專用 IP 位址，您可用來建立應用程式的外部 TCP/UDP 負載平衡器。
* Iptables 是一種 Linux Kernel 特性，可對應用程式 Pod 之間的要求進行負載平衡、提供高效能網路遞送，以及提供網路存取控制。
* 指派給負載平衡器的可攜式公用及專用 IP 位址是永久性的，因此在叢集裡重建工作者節點時並不會變更。
* 您可以公開應用程式所需的任何埠來自訂負載平衡器。

**[Ingress](cs_ingress.html)**（僅限標準叢集）
* 建立一個外部 HTTP 或 HTTPS、TCP 或 UDP 應用程式負載平衡器 (ALB)，來公開叢集裡的多個應用程式。ALB 使用安全且唯一的公用或專用進入點，將送入要求遞送至您的應用程式。
* 您可以使用一個路徑，將叢集裡的多個應用程式公開為服務。
* Ingress 包含三個元件：
  * Ingress 資源會定義如何遞送及負載平衡應用程式送入要求的規則。
  * ALB 會接聽送入的 HTTP 或 HTTPS、TCP 或 UDP 服務要求。它會根據您在 Ingress 資源中所定義的規則，在應用程式的 Pod 之間轉遞要求。
  * 多區域負載平衡器 (MZLB) 處理應用程式的所有送入要求，並負載平衡各種區域中 ALB 之間的要求。
* 使用 Ingress 以利用自訂遞送規則來實作自己的 ALB，而且您的應用程式需要 SSL 終止。

若要選擇應用程式的最佳網路服務，您可以遵循此決策樹狀結構，然後按一下其中一個選項來開始使用。

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="此圖會引導您完成選擇應用程式的最佳網路選項。如果未顯示此圖，仍然可以在文件中找到這項資訊。" style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Nodeport 服務" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer 服務" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress 服務" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## 規劃公用外部網路
{: #public_access}

當您在 {{site.data.keyword.containershort_notm}} 中建立 Kubernetes 叢集時，可以將叢集連接至公用 VLAN。公用 VLAN 會判定指派給每一個工作者節點的公用 IP 位址，以將公用網路介面提供給每一個工作者節點。
{:shortdesc}

若要將應用程式設為可在網際網路上公開使用，您可以建立 NodePort、LoadBalancer 或 Ingress 服務。若要比較每一個服務，請參閱[選擇 NodePort、LoadBalancer 或 Ingress 服務](#external)。

下圖顯示 Kubernetes 在 {{site.data.keyword.containershort_notm}} 中如何轉遞公用網路資料流量。

![{{site.data.keyword.containershort_notm}} Kubernetes 架構](images/networking.png)

*{{site.data.keyword.containershort_notm}} 中的 Kubernetes 資料平面*

免費和標準叢集裡的工作者節點公用網路介面都受到 Calico 網路原則的保護。依預設，這些原則會封鎖大部分入埠資料流量。不過，會容許 Kubernetes 運作所需的入埠資料流量，也會容許與 NodePort、LoadBalancer 及 Ingress 服務的連線。如需這些原則的相關資訊，包括如何修改它們，請參閱[網路原則](cs_network_policy.html#network_policies)。

<br />


## 規劃公用及專用 VLAN 設定的專用外部網路
{: #private_both_vlans}

當您在 {{site.data.keyword.containershort_notm}} 建立 Kubernetes 叢集時，必須將叢集連接至專用 VLAN。專用 VLAN 會判定指派給每一個工作者節點的專用 IP 位址，以將專用網路介面提供給每一個工作者節點。
{:shortdesc}

當您要讓應用程式只連接至專用網路時，可以使用標準叢集裡工作者節點的專用網路介面。不過，當您的工作者節點連接至公用及專用 VLAN 時，也必須使用 Calico 網路原則來保護叢集免於不想要的公用存取。

下列各節說明 {{site.data.keyword.containershort_notm}} 中的功能，可用來向應用程式公開專用網路，並保護叢集免於不想要的公用存取。您也可以選擇性地隔離網路工作負載，並將叢集連接至內部部署網路中的資源。

### 使用專用網路服務公開應用程式並使用 Calico 網路原則保護叢集
{: #private_both_vlans_calico}

工作者節點的公用網路介面受到[預先定義的 Calico 網路原則設定](cs_network_policy.html#default_policy)所保護，這些設定是在建立叢集期間配置於每個工作者節點上。依預設，所有工作者節點都允許所有出埠網路資料流量。而封鎖入埠網路資料流量，但下列少數埠除外：開啟讓 IBM 可以監視網路資料流量的埠，以及讓 IBM 自動安裝 Kubernetes 主節點的安全更新的埠。工作者節點的 Kubelet 存取受到 OpenVPN 通道的保護。如需相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 架構](cs_tech.html)。

如果您使用 NodePort 服務、LoadBalancer 服務或 Ingress 應用程式負載平衡器來公開您的應用程式，則預設 Calico 原則也容許從網際網路到這些服務的入埠網路資料流量。若要讓應用程式只可從專用網路進行存取，您可以選擇只使用專用 NodePort、LoadBalancer 或 Ingress 服務，並封鎖服務的所有公用資料流量。

**NodePort**
* [建立 NodePort 服務](cs_nodeport.html)。除了公用 IP 位址之外，在工作者節點的專用 IP 位址上，也可以使用 NodePort 服務。
* NodePort 服務會透過工作者節點的專用及公用 IP 位址在工作者節點上開啟埠。您必須使用 [Calico preDNAT 網路原則](cs_network_policy.html#block_ingress)來封鎖公用 NodePort。

**LoadBalancer**
* [建立專用 LoadBalancer 服務](cs_loadbalancer.html)。
* 具有可攜式專用 IP 位址的負載平衡器服務仍然會在每個工作者節點上開啟一個公用節點埠。您必須使用 [Calico preDNAT 網路原則](cs_network_policy.html#block_ingress)來封鎖其上的公用節點埠。

**Ingress
        **
* 當您建立叢集時，會自動建立一個公用及一個專用 Ingress 應用程式負載平衡器 (ALB)。因為依預設會啟用公用 ALB 並停用專用 ALB，所以您必須[停用公用 ALB](cs_cli_reference.html#cs_alb_configure) 以及[啟用專用 ALB](cs_ingress.html#private_ingress)。
* 然後，[建立專用 Ingress 服務](cs_ingress.html#ingress_expose_private)。

如需每一個服務的相關資訊，請參閱[選擇 NodePort、LoadBalancer 或 Ingress 服務](#external)。

### 選用項目：將網路工作負載隔離至邊緣工作者節點
{: #private_both_vlans_edge}

邊緣工作者節點可以藉由容許較少的工作者節點可在外部進行存取，以及隔離網路工作負載，來增進叢集的安全。若要確定只將 Ingress 及負載平衡器 Pod 部署至指定的工作者節點，請[將工作者節點標示為邊緣節點](cs_edge.html#edge_nodes)。若也要防止在邊緣節點上執行其他工作負載，請[污染邊緣節點](cs_edge.html#edge_workloads)。

然後，使用 [Calico preDNAT 網路原則](cs_network_policy.html#block_ingress)來封鎖執行邊緣工作者節點之叢集上的公用節點埠的資料流量。封鎖節點埠可確保邊緣工作者節點是處理送入資料流量的唯一工作者節點。

### 選用項目：使用 strongSwan VPN 連接至內部部署資料庫
{: #private_both_vlans_vpn}

若要將工作者節點及應用程式安全地連接至內部部署網路，您可以設定 [strongSwan IPSec VPN 服務 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.strongswan.org/about.html)。在根據業界標準網際網路通訊協定安全 (IPSec) 通訊協定套組的網際網路上，strongsWan IPSec VPN 服務提供安全的端對端通訊通道。若要設定叢集與內部部署網路之間的安全連線，請直接在叢集的 Pod 中[配置及部署 strongSwan IPSec VPN 服務](cs_vpn.html#vpn-setup)。

<br />


## 僅規劃專用 VLAN 設定的專用外部網路
{: #private_vlan}

當您在 {{site.data.keyword.containershort_notm}} 建立 Kubernetes 叢集時，必須將叢集連接至專用 VLAN。專用 VLAN 會判定指派給每一個工作者節點的專用 IP 位址，以將專用網路介面提供給每一個工作者節點。
{:shortdesc}

當您的工作者節點只連接至專用 VLAN 時，可以使用工作者節點的專用網路介面，讓應用程式只連接至專用網路。您接著可以使用閘道應用裝置，保護叢集免於不想要的公用存取。

下列各節說明 {{site.data.keyword.containershort_notm}} 中的功能，可用來保護叢集免於不想要的公用存取、向專用網路公開應用程式，以及連接至內部部署網路中的資源。

### 配置閘道應用裝置
{: #private_vlan_gateway}

如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線。您可以使用自訂網路原則來設定防火牆，以提供標準叢集的專用網路安全，以及偵測及重新修補網路侵入。例如，您可能選擇設定 [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) 或 [Fortigate Security Appliance](/docs/infrastructure/fortigate-10g/about.html) 作為防火牆，並且封鎖不想要的資料流量。當您設定防火牆時，[也必須開啟必要埠及 IP 位址](cs_firewall.html#firewall_outbound)（針對每一個地區），讓主節點與工作者節點可以進行通訊。 

**附註**：如果您具有現有的路由器應用裝置，然後新增叢集，則不會在路由器應用裝置上配置針對叢集所訂購的新可攜式子網路。為了能夠使用網路服務，您必須[啟用 VLAN Spanning](cs_subnets.html#vra-routing)，在相同 VLAN 上的子網路之間啟用遞送。

### 使用專用網路服務公開應用程式
{: #private_vlan_services}

若要讓應用程式只可從專用網路進行存取，您可以使用專用 NodePort、LoadBalancer 或 Ingress 服務。因為您的工作者節點未連接至公用 VLAN，所以不會有任何公用資料流量遞送至這些服務。

**NodePort**:
* [建立專用 NodePort 服務](cs_nodeport.html)。透過工作者節點的專用 IP 位址也可以使用此服務。
* 在您的專用防火牆中，開啟您在將服務部署至所有工作者節點的公用 IP 位址時所配置的埠，以容許接收資料流量。若要尋找埠，請執行 `kubectl get svc`。該埠在 20000-32000 的範圍內。

**LoadBalancer**
* [建立專用 LoadBalancer 服務](cs_loadbalancer.html)。如果您的叢集只能在專用 VLAN 上使用，則會使用四個可用的可攜式專用 IP 位址的其中一個。
* 在您的專用防火牆中，開啟您在將服務部署至負載平衡器服務的專用 IP 位址時所配置的埠。

**Ingress**：
* 當您建立叢集時，會自動建立專用 Ingress 應用程式負載平衡器 (ALB)，但依預設未啟用。您必須[啟用專用 ALB](cs_ingress.html#private_ingress)。
* 然後，[建立專用 Ingress 服務](cs_ingress.html#ingress_expose_private)。
* 在您的專用防火牆中，針對專用 ALB 的 IP 位址，開啟埠 80（適用於 HTTP）或埠 443（適用於 HTTPS）。


如需每一個服務的相關資訊，請參閱[選擇 NodePort、LoadBalancer 或 Ingress 服務](#external)。

### 選用項目：使用閘道應用裝置連接至內部部署資料庫
{: #private_vlan_vpn}

若要將工作者節點及應用程式安全地連接至內部部署網路，您必須設定 VPN 閘道。您可以使用設定為防火牆的 [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) 或 [Fortigate Security Appliance (FSA)](/docs/infrastructure/fortigate-10g/about.html)，以同時配置 IPSec VPN 端點。若要配置 VRA，請參閱[使用 VRA 設定 VPN 連線功能](cs_vpn.html#vyatta)。

<br />


## 規劃叢集內網路
{: #in-cluster}

所有已部署至工作者節點的 Pod 會獲指派 172.30.0.0/16 範圍中的專用 IP 位址，並且只在工作者節點之間遞送。若要避免衝突，請不要在與工作者節點通訊的任何節點上使用此 IP 範圍。使用專用 IP 位址，工作者節點及 Pod 可以在專用網路上安全地進行通訊。不過，Pod 損毀或需要重建工作者節點時，會指派新的專用 IP 位址。

依預設，對必須為高可用性的應用程式，很難追蹤其變更中的專用 IP 位址。相反地，您可以使用內建 Kubernetes 服務探索特性，將應用程式公開為專用網路上的叢集 IP 服務。Kubernetes 服務會建立一組 Pod，並為叢集裡的其他服務提供這些 Pod 的網路連線，而不公開每一個 Pod 的實際專用 IP 位址。服務會獲指派只能在叢集內部存取的叢集內 IP 位址。
* **較舊的叢集**：在 2018 年 2 月之前於 dal13 區域建立的叢集中，或在 2017 年 10 月之前於任何其他區域建立的叢集中，服務會獲指派 10.10.10.0/24 範圍中 254 個 IP 內的其中一個 IP。如果您已達 254 個服務的限制，而且需要更多服務，則必須建立新的叢集。
* **較新的叢集**：在 2018 年 2 月之後於 dal13 區域建立的叢集中，或在 2017 年 10 月之後於任何其他區域建立的叢集中，服務會獲指派 172.21.0.0/16 範圍中 65,000 個 IP 內的其中一個 IP。

若要避免衝突，請不要在與工作者節點通訊的任何節點上使用此 IP 範圍。也會建立服務的 DNS 查閱項目，並將其儲存在叢集的 `kube-dns` 元件中。DNS 項目包含服務的名稱、已建立服務的名稱空間，以及已指派叢集內 IP 位址的鏈結。

若要存取受叢集 IP 服務保護的 Pod，應用程式可以使用服務的叢集內 IP 位址，或使用服務的名稱來傳送要求。當您使用服務的名稱時，會在 `kube-dns` 元件中查閱該名稱，並將其遞送至服務的叢集內 IP 位址。要求到達服務時，服務確保所有要求會平均地轉遞至 Pod，與其叢集內 IP 位址及在其中部署它們的工作者節點無關。
