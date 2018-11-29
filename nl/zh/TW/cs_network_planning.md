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


# 規劃使用外部網路功能公開您的應用程式
{: #planning}

透過 {{site.data.keyword.containerlong}}，您可以讓應用程式進行公用或專用存取，以管理外部網路功能。
{: shortdesc}

## 選擇 NodePort、LoadBalancer 或 Ingress 服務
{: #external}

為了讓您的應用程式可從公用網際網路或專用網路進行外部存取，{{site.data.keyword.containerlong_notm}} 支援三個網路服務。
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

當您在 {{site.data.keyword.containerlong_notm}} 中建立 Kubernetes 叢集時，可以將叢集連接至公用 VLAN。公用 VLAN 會判定指派給每一個工作者節點的公用 IP 位址，以將公用網路介面提供給每一個工作者節點。
{:shortdesc}

若要將應用程式設為可在網際網路上公開使用，您可以建立 NodePort、LoadBalancer 或 Ingress 服務。若要比較每一個服務，請參閱[選擇 NodePort、LoadBalancer 或 Ingress 服務](#external)。

下圖顯示 Kubernetes 在 {{site.data.keyword.containerlong_notm}} 中如何轉遞公用網路資料流量。

![{{site.data.keyword.containerlong_notm}} Kubernetes 架構](images/networking.png)

*{{site.data.keyword.containerlong_notm}} 中的 Kubernetes 資料平面*

免費和標準叢集裡的工作者節點公用網路介面都受到 Calico 網路原則的保護。依預設，這些原則會封鎖大部分入埠資料流量。不過，會容許 Kubernetes 運作所需的入埠資料流量，也會容許與 NodePort、LoadBalancer 及 Ingress 服務的連線。如需這些原則的相關資訊，包括如何修改它們，請參閱[網路原則](cs_network_policy.html#network_policies)。

如需設定叢集網路功能的相關資訊，包括子網路、防火牆及 VPN 的相關資訊，請參閱[規劃預設叢集網路功能](cs_network_cluster.html#both_vlans)。

<br />


## 規劃公用及專用 VLAN 設定的專用外部網路功能
{: #private_both_vlans}

當您的工作者節點同時連接至公用及專用 VLAN 時，您可以透過建立專用 NodePort、LoadBalancer 或 Ingress 服務，讓您的應用程式只能從專用網路存取。然後，您可以建立 Calico 原則來封鎖服務的公用資料流量。

**NodePort**
* [建立 NodePort 服務](cs_nodeport.html)。除了公用 IP 位址之外，在工作者節點的專用 IP 位址上，也可以使用 NodePort 服務。
* NodePort 服務會透過工作者節點的專用及公用 IP 位址在工作者節點上開啟埠。您必須使用 [Calico DNAT 前網路原則](cs_network_policy.html#block_ingress)來封鎖公用 NodePort。

**LoadBalancer**
* [建立專用 LoadBalancer 服務](cs_loadbalancer.html)。
* 具有可攜式專用 IP 位址的負載平衡器服務仍然會在每個工作者節點上開啟一個公用節點埠。您必須使用 [Calico DNAT 前網路原則](cs_network_policy.html#block_ingress)來封鎖其上的公用節點埠。

**Ingress**
* 當您建立叢集時，會自動建立一個公用及一個專用 Ingress 應用程式負載平衡器 (ALB)。因為依預設會啟用公用 ALB 並停用專用 ALB，所以您必須[停用公用 ALB](cs_cli_reference.html#cs_alb_configure) 以及[啟用專用 ALB](cs_ingress.html#private_ingress)。
* 然後，[建立專用 Ingress 服務](cs_ingress.html#ingress_expose_private)。

舉例來說，假設您已建立專用負載平衡器服務。您也建立了 Calico DNAT 前原則來封鎖公用資料流量，使其無法到達負載平衡器所開啟的公用 NodePort。可以透過下列方式存取此專用負載平衡器：
* 此一相同叢集中的任何 Pod
* 相同 IBM Cloud 帳戶中任何叢集的任何 Pod
* 如果您[已啟用 VLAN Spanning](cs_subnets.html#subnet-routing)，則為任何已連接至位於相同 IBM Cloud 帳戶中之任何專用 VLAN 的系統
* 如果您不屬於 IBM Cloud 帳戶，而仍然在公司防火牆背後，則為透過 VPN 連線連至負載平衡器 IP 所在的子網路的任何系統
* 如果您屬於不同的 IBM Cloud 帳戶，則為透過 VPN 連線連至負載平衡器 IP 所在的子網路的任何系統

如需設定叢集網路功能的相關資訊，包括子網路、防火牆及 VPN 的相關資訊，請參閱[規劃預設叢集網路功能](cs_network_cluster.html#both_vlans)。

<br />


## 規劃僅限專用 VLAN 設定的專用外部網路功能
{: #private_vlan}

當您的工作者節點連接至僅限專用 VLAN 時，您可以透過建立專用 NodePort、LoadBalancer 或 Ingress 服務，讓您的應用程式只能從專用網路存取。因為您的工作者節點未連接至公用 VLAN，所以不會有任何公用資料流量遞送至這些服務。

**NodePort**:
* [建立專用 NodePort 服務](cs_nodeport.html)。透過工作者節點的專用 IP 位址也可以使用此服務。
* 在您的專用防火牆中，開啟您在將服務部署至所有工作者節點的公用 IP 位址時所配置的埠，以容許接收資料流量。若要尋找埠，請執行 `kubectl get svc`。該埠在 20000-32000 的範圍內。

**LoadBalancer**
* [建立專用 LoadBalancer 服務](cs_loadbalancer.html)。如果您的叢集只能在專用 VLAN 上使用，則會使用四個可用的可攜式專用 IP 位址的其中一個。
* 在您的專用防火牆中，開啟您在將服務部署至負載平衡器服務的專用 IP 位址時所配置的埠。

**Ingress**：
* 您必須配置[專用網路上可用的 DNS 服務![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。
* 當您建立叢集時，會自動建立專用 Ingress 應用程式負載平衡器 (ALB)，但依預設未啟用。您必須[啟用專用 ALB](cs_ingress.html#private_ingress)。
* 然後，[建立專用 Ingress 服務](cs_ingress.html#ingress_expose_private)。
* 在您的專用防火牆中，針對專用 ALB 的 IP 位址，開啟埠 80（適用於 HTTP）或埠 443（適用於 HTTPS）。

如需設定叢集網路功能的相關資訊，包括子網路及閘道應用裝置的相關資訊，請參閱[規劃僅限專用 VLAN 設定的網路功能](cs_network_cluster.html#private_vlan)。
