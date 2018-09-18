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


# 클러스터 네트워킹 계획
{: #planning}

{{site.data.keyword.containerlong}}에서 사용자는 앱을 공용 또는 개인용으로 액세스 가능하게 하여 외부 네트워킹을 관리함은 물론 클러스터 내의 내부 네트워킹을 관리할 수도 있습니다.
{: shortdesc}

## NodePort, LoadBalancer 또는 Ingress 서비스 선택
{: #external}

[공용 인터넷](#public_access) 또는 [사설 인터넷](#private_both_vlans)에서 외부적으로 앱에 액세스할 수 있도록 하기 위해 {{site.data.keyword.containershort_notm}}에서는 3개의 네트워킹 서비스를 지원합니다.
{:shortdesc}

**[NodePort 서비스](cs_nodeport.html)**(무료 및 표준 클러스터)
* 모든 작업자 노드에서 포트를 노출시키고 작업자 노드의 공인 또는 사설 IP 주소를 사용하여 클러스터의 서비스에 액세스합니다. 
* Iptables는 로드 밸런스가 앱의 팟(Pod) 전체에서 요청하는 기능이며, 고성능 네트워크 라우팅과 네트워크 액세스 제어를 제공합니다.
* 작업자 노드의 공인 및 사설 IP 주소는 영구적이지 않습니다. 작업자 노드가 제거되거나 다시 작성되면 새 공인 및 새 사설 IP 주소가 작업자 노드에 지정됩니다. 
* NodePort 서비스는 공용 또는 개인용 액세스를 테스트하기에는 최상입니다. 짧은 시간 동안에만 공용 또는 개인용 액세스가 필요한 경우에도 이를 사용할 수 있습니다. 

**[LoadBalancer 서비스](cs_loadbalancer.html)**(표준 클러스터 전용)
* 모든 표준 클러스터는 앱에 대한 외부 TCP/UDP 로드 밸런서를 작성하는 데 사용할 수 있는 네 개의 포터블 공인 IP 주소 및 네 개의 사설 IP 주소로 프로비저닝됩니다.
* Iptables는 로드 밸런스가 앱의 팟(Pod) 전체에서 요청하는 기능이며, 고성능 네트워크 라우팅과 네트워크 액세스 제어를 제공합니다.
* 로드 밸런서에 지정된 포터블 공인 및 사설 IP 주소는 영구적이며, 클러스터에서 작업자 노드가 다시 작성될 때 변경되지 않습니다. 
* 앱이 요구하는 포트를 노출함으로써 로드 밸런서를 사용자 정의할 수 있습니다.

**[Ingress](cs_ingress.html)**(표준 클러스터 전용)
* 하나의 외부 HTTP 또는 HTTPS, TCP 또는 UDP 애플리케이션 로드 밸런서(ALB)를 작성하여 클러스터의 다중 앱을 노출합니다. ALB는 안전하고 고유한 공용 또는 사설 시작점을 사용하여 수신 요청을 앱으로 라우팅합니다. 
* 하나의 라우트를 사용하여 서비스로서 클러스터의 다중 앱을 노출할 수 있습니다. 
* Ingress는 다음 3개의 컴포넌트로 구성되어 있습니다. 
  * Ingress 리소스는 앱에 대한 수신 요청을 라우팅하고 로드 밸런싱하는 방법에 대한 규칙을 정의합니다.
  * ALB는 수신 HTTP 또는 HTTPS, TCP 또는 UDP 서비스 요청을 청취합니다. Ingress 리소스에 정의한 규칙을 기반으로 앱의 팟(Pod)에서 요청을 전달합니다.
  * 다중 구역 로드 밸런서(MZLB)는 앱에 대한 모든 수신 요청을 처리하며 다양한 구역의 ALB 간에 요청을 로드 밸런싱합니다. 
* 사용자 정의 라우팅 규칙으로 사용자 고유의 ALB를 구현하려고 하고 앱에 대한 SSL 종료가 필요한 경우 Ingress를 사용하십시오.

앱에 대한 최상의 네트워킹 서비스를 선택하려면 다음 의사결정 트리에 따라 시작하기 옵션 중 하나를 클릭할 수 있습니다. 

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="이 이미지는 애플리케이션을 위한 최고의 네트워킹 옵션을 선택하는 과정을 안내합니다. 이 이미지가 표시되지 않는 경우에도 문서에서 해당 정보를 찾을 수 있습니다. " style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Nodeport 서비스" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer 서비스" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress 서비스" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## 공용 외부 네트워킹 계획
{: #public_access}

{{site.data.keyword.containershort_notm}}에서 Kubernetes 클러스터를 작성하는 경우에는 클러스터를 공용 VLAN에 연결할 수 있습니다. 공용 VLAN은 각 작업자 노드에 지정된 공인 IP 주소를 판별하며, 이는 각 작업자 노드에 공용 네트워크 인터페이스를 제공합니다.
{:shortdesc}

인터넷에서 앱을 공용으로 사용할 수 있도록 하기 위해 NodePort, LoadBalancer 또는 Ingress 서비스를 작성할 수 있습니다. 각 서비스를 비교하려면 [NodePort, LoadBalancer 또는 Ingress 서비스 선택](#external)을 참조하십시오. 

다음의 다이어그램은 {{site.data.keyword.containershort_notm}}에서 Kubernetes가 공용 네트워크 트래픽을 전달하는 방법을 보여줍니다. 

![{{site.data.keyword.containershort_notm}} Kubernetes 아키텍처](images/networking.png)

*{{site.data.keyword.containershort_notm}}의 Kubernetes 데이터 평면*

무료 및 표준 클러스터 모두의 작업자 노드에 대한 공용 네트워크 인터페이스는 Calico 네트워크 정책으로 보호됩니다. 이러한 정책은 기본적으로 대부분의 인바운드 트래픽을 차단합니다. 그러나 NodePort, LoadBalancer 및 Ingress 서비스에 대한 연결과 마찬가지로 Kubernetes가 작동하는 데 필요한 인바운드 트래픽은 허용됩니다. 수정 방법을 포함하여 이러한 정책에 대한 자세한 정보는 [네트워크 정책](cs_network_policy.html#network_policies)을 참조하십시오.

<br />


## 공용 및 사설 VLAN 설정에 대한 사설 외부 네트워킹 계획
{: #private_both_vlans}

{{site.data.keyword.containershort_notm}}에서 Kubernetes 클러스터를 작성하는 경우에는 클러스터를 사설 VLAN에 연결해야 합니다. 사설 VLAN은 각 작업자 노드에 지정된 사설 IP 주소를 판별하며, 이는 각 작업자 노드에 사설 네트워크 인터페이스를 제공합니다.
{:shortdesc}

사설 네트워크에 대해서만 앱 연결을 유지하려면 표준 클러스터의 작업자 노드에 대해 사설 네트워크 인터페이스를 사용할 수 있습니다. 그러나 작업자 노드가 공용 및 사설 VLAN 모두에 연결된 경우에는 Calico 네트워크 정책을 사용하여 원하지 않는 공용 액세스로부터 클러스터 보호도 수행해야 합니다. 

다음 섹션에서는 앱을 사설 네트워크에 노출하고 원하지 않는 공용 액세스로부터 클러스터를 보호하기 위해 사용할 수 있는 {{site.data.keyword.containershort_notm}}에서의 기능을 설명합니다. 선택적으로, 네트워킹 워크로드를 분리하고 클러스터를 온프레미스 네트워크의 리소스에 연결할 수도 있습니다. 

### 사설 네트워크 서비스에서 앱 노출 및 Calico 네트워크 정책으로 클러스터 보호
{: #private_both_vlans_calico}

작업자 노드에 대한 공용 네트워크 인터페이스는 클러스터 작성 중에 모든 작업자 노드에서 구성된 [사전 정의된 Calico 네트워크 정책 설정](cs_network_policy.html#default_policy)에 의해 보호됩니다. 기본적으로, 모든 아웃바운드 네트워크 트래픽이 모든 작업자 노드에 대해 허용됩니다. 인바운드 네트워크 트래픽은 열려 있는 일부 포트를 제외하면 차단되어 있습니다. 따라서 네트워크 트래픽이 IBM에 의해 모니터될 수 있으며, IBM은 Kubernetes 마스터에 대한 보안 업데이트를 자동으로 설치할 수 있습니다. 작업자 노드의 kubelet에 대한 액세스는 OpenVPN 터널에 의해 보호됩니다. 자세한 정보는 [{{site.data.keyword.containershort_notm}} 아키텍처](cs_tech.html)를 참조하십시오. 

NodePort 서비스, LoadBalancer 서비스 또는 Ingress 애플리케이션 로드 밸런서를 사용하여 앱을 노출하는 경우, 기본 Calico 정책은 인터넷에서 이러한 서비스로의 인바운드 네트워크 트래픽도 허용합니다. 사설 네트워크에서만 앱의 액세스를 허용하려면 사설 NodePort, LoadBalancer 또는 Ingress 서비스만 사용하고 서비스에 대한 모든 공용 트래픽을 차단하도록 선택할 수 있습니다. 

**NodePort**
* [NodePort 서비스를 작성](cs_nodeport.html)하십시오. 공인 IP 주소 이외에 작업자 노드의 사설 IP 주소를 통해 NodePort 서비스를 사용할 수 있습니다.
* NodePort 서비스는 작업자 노드의 사설 및 공인 IP 주소 모두에서 작업자 노드의 포트를 엽니다. 사용자는 [Calico preDNAT 네트워크 정책](cs_network_policy.html#block_ingress)을 사용하여 공용 NodePort를 차단해야 합니다. 

**LoadBalancer**
* [사설 LoadBalancer 서비스를 작성](cs_loadbalancer.html)하십시오.
* 포터블 사설 IP 주소를 사용하는 로드 밸런서 서비스에는 여전히 모든 작업자 노드에서 열려 있는 공용 노드 포트가 있습니다. 사용자는 [Calico preDNAT 네트워크 정책](cs_network_policy.html#block_ingress)을 사용하여 이의 공용 노드를 차단해야 합니다. 

**Ingress**
* 클러스터를 작성하면 하나의 공용 및 사설 Ingress 애플리케이션 로드 밸런서(ALB)가 자동으로 작성됩니다. 기본적으로 공용 ALB는 사용되고 사설 ALB는 사용되지 않으므로, 사용자는 [공용 ALB 사용 안함](cs_cli_reference.html#cs_alb_configure) 및 [사설 ALB 사용](cs_ingress.html#private_ingress)을 설정해야 합니다. 
* 그리고 [사설 Ingress 서비스를 작성](cs_ingress.html#ingress_expose_private)하십시오.

각 서비스에 대한 자세한 정보는 [NodePort, LoadBalancer 또는 Ingress 서비스 선택](#external)을 참조하십시오. 

### 선택사항:에지 작업자 노드에 대한 네트워킹 워크로드 격리
{: #private_both_vlans_edge}

에지 작업자 노드는 외부에서 적은 수의 작업자 노드에 액세스할 수 있게 하고 네트워크 워크로드를 격리함으로써 클러스터의 보안을 향상시킬 수 있습니다. Ingress 및 로드 밸런서 팟(Pod)이 지정된 작업자 노드에만 배치되도록 보장하려면 [작업자 노드를 에지 노드로서 레이블링](cs_edge.html#edge_nodes)하십시오. 또한 기타 워크로드가 에지 노드에서 실행하지 못하도록 방지하려면 [에지 노드를 오염](cs_edge.html#edge_workloads)시키십시오.

그리고 [Calico preDNAT 네트워크 정책](cs_network_policy.html#block_ingress)을 사용하여 에지 작업자 노드를 실행 중인 클러스터의 공용 노드 포트에 대한 트래픽을 차단하십시오. 노드 포트를 차단하면 에지 작업자 노드가 수신 트래픽을 처리하는 유일한 작업자 노드가 됩니다.

### 선택사항: strongSwan VPN을 사용하여 온프레미스 데이터베이스에 연결
{: #private_both_vlans_vpn}

작업자 노드와 앱을 온프레미스 네트워크에 안전하게 연결할 수 있도록 [strongSwan IPSec VPN 서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.strongswan.org/about.html)를 설정할 수 있습니다. strongSwan IPSec VPN 서비스는 업계 표준 IPSec(Internet Protocol Security) 프로토콜 스위트를 기반으로 하는 인터넷 상의 엔드-투-엔드 보안 통신 채널을 제공합니다. 클러스터와 온프레미스 네트워크 간의 보안 연결을 설정하려면 클러스터 내의 팟(Pod)에 직접 [strongSwan IPSec VPN 서비스를 구성하고 배치](cs_vpn.html#vpn-setup)하십시오.

<br />


## 사설 VLAN 설정 전용의 사설 외부 네트워킹 계획
{: #private_vlan}

{{site.data.keyword.containershort_notm}}에서 Kubernetes 클러스터를 작성하는 경우에는 클러스터를 사설 VLAN에 연결해야 합니다. 사설 VLAN은 각 작업자 노드에 지정된 사설 IP 주소를 판별하며, 이는 각 작업자 노드에 사설 네트워크 인터페이스를 제공합니다.
{:shortdesc}

작업자 노드가 사설 VLAN에만 연결된 경우에는 작업자 노드에 대한 사설 네트워크 인터페이스를 사용하여 사설 네트워크에 대해서만 앱의 연결을 유지할 수 있습니다. 그리고 게이트웨이 어플라이언스를 사용하여 원하지 않는 공용 액세스로부터 클러스터를 보호할 수 있습니다. 

다음 섹션에서는 원하지 않는 공용 액세스로부터 클러스터를 보호하고 사설 네트워크에 앱을 노출하며 온프레미스 네트워크의 리소스에 액세스하기 위해 사용할 수 있는 {{site.data.keyword.containershort_notm}}에서의 기능을 설명합니다. 

### 게이트웨이 어플라이언스 구성
{: #private_vlan_gateway}

작업자 노드가 사설 VLAN 전용으로 설정된 경우에는 네트워크 연결에 대해 대체 솔루션을 구성해야 합니다. 사용자는 표준 클러스터에 대한 전용 네트워크 보안을 제공하고 네트워크 침입을 발견하여 이를 해결하기 위한 사용자 정의 네트워크 정책으로 방화벽을 설정할 수 있습니다. 예를 들어, 방화벽 역할을 수행하며 원하지 않는 트래픽을 차단하도록 [가상 라우터 어플라이언스](/docs/infrastructure/virtual-router-appliance/about.html) 또는 [Fortigate 보안 어플라이언스](/docs/infrastructure/fortigate-10g/about.html) 설정을 선택할 수 있습니다. 방화벽을 설정할 때 마스터와 작업자 노드가 통신할 수 있도록 각 지역의 [필수 포트와 IP 주소도 개방해야 합니다](cs_firewall.html#firewall_outbound). 

**참고**: 기존 라우터 어플라이언스가 있으며 클러스터를 추가하는 경우, 클러스터에 대해 주문된 새 포터블 서브넷은 라우터 어플라이언스에서 구성되지 않습니다. 네트워크 서비스를 사용하려면 [VLAN Spanning을 사용으로 설정](cs_subnets.html#vra-routing)하여 동일한 VLAN의 서브넷 간에 라우팅을 사용하도록 설정해야 합니다. 

### 사설 네트워크 서비스에서 앱 노출
{: #private_vlan_services}

사설 네트워크에서만 앱의 액세스를 허용하려면 사설 NodePort, LoadBalancer 또는 Ingress 서비스를 사용할 수 있습니다. 작업자 노드가 공용 VLAN에 연결되어 있지 않으므로 공용 트래픽은 이러한 서비스로 라우팅되지 않습니다. 

**NodePort**:
* [사설 NodePort 서비스를 작성](cs_nodeport.html)하십시오. 서비스는 작업자 노드의 사설 IP 주소에서만 사용 가능합니다. 
* 사설 방화벽에서 모든 작업자 노드가 트래픽을 허용할 수 있도록 서비스를 사설 IP 주소에 배치할 때 구성한 포트를 여십시오. 포트를 찾으려면 `kubectl get svc`를 실행하십시오. 포트는 20000 - 32000 범위에 있습니다.

**LoadBalancer**
* [사설 LoadBalancer 서비스를 작성](cs_loadbalancer.html)하십시오. 클러스터가 사설 VLAN에만 있는 경우 네 개의 사용 가능한 포터블 사설 IP 주소 중 하나가 사용됩니다.
* 사설 방화벽에서 서비스를 로드 밸런스 서비스의 사설 IP 주소에 배치할 때 구성한 포트를 여십시오. 

**Ingress**:
* 클러스터를 작성하면 사설 Ingress 애플리케이션 로드 밸런서(ALB)가 자동으로 작성되지만, 기본적으로 사용하도록 설정되지는 않습니다. 사용자가 [사설 ALB를 사용하도록 설정](cs_ingress.html#private_ingress)해야 합니다. 
* 그리고 [사설 Ingress 서비스를 작성](cs_ingress.html#ingress_expose_private)하십시오.
* 사설 방화벽에서 사설 ALB의 IP 주소에 대해 포트 80(HTTP의 경우) 또는 포트 443(HTTPS의 경우)을 여십시오. 


각 서비스에 대한 자세한 정보는 [NodePort, LoadBalancer 또는 Ingress 서비스 선택](#external)을 참조하십시오. 

### 선택사항: 게이트웨이 어플라이언스를 사용하여 온프레미스 데이터베이스에 연결
{: #private_vlan_vpn}

작업자 노드와 앱을 온프레미스 네트워크에 안전하게 연결하려면 VPN 게이트웨이를 설정해야 합니다. 방화벽으로 설정한 [VRA(Virtual Router Appliance)](/docs/infrastructure/virtual-router-appliance/about.html) 또는 [FSA(Fortigate Security Appliance)](/docs/infrastructure/fortigate-10g/about.html)를 사용하여 IPSec VPN 엔드포인트를 구성할 수도 있습니다. VRA를 구성하려면 [VRA를 사용하여 VPN 연결 설정](cs_vpn.html#vyatta)을 참조하십시오.

<br />


## 클러스터 내 네트워킹 계획
{: #in-cluster}

작업자 노드에 배치된 모든 팟(Pod)에는 172.30.0.0/16 범위의 사설 IP 주소가 지정되며 이는 작업자 노드 간에만 라우팅됩니다. 충돌을 피하려면 사용자의 작업자 노드와 통신하는 노드에 이 IP 범위를 사용하지 마십시오. 작업자 노드와 팟(Pod)은 사설 IP 주소를 사용하여 사설 네트워크에서 안전하게 통신할 수 있습니다. 그러나 팟(Pod)에 장애가 발생하거나 작업자 노드의 재작성이 필요한 경우에는 새 사설 IP 주소가 지정됩니다.

기본적으로 고가용성이어야 하는 앱에 대한 사설 IP 주소 변경을 추적하는 것은 어렵습니다. 그 대신에 기본 제공 Kubernetes 서비스 검색 기능을 사용하여 사설 네트워크에서 클러스터 IP 서비스로서 앱을 노출할 수 있습니다. Kubernetes 서비스는 팟(Pod) 세트를 그룹화하며, 각 팟(Pod)의 실제 사설 IP 주소를 노출함이 없이 클러스터의 기타 서비스에 대해 이러한 팟(Pod)으로의 네트워크 연결을 제공합니다. 서비스에는 클러스터 내에서만 액세스가 가능한 클러스터 내 IP 주소가 지정됩니다. 
* **이전 클러스터**: dal13 구역에서 2018년 2월 이전에 또는 기타 구역에서 2017년 10월 이전에 작성된 클러스터에서는 서비스에 10.10.10.0/24 범위의 254 IP 중 하나의 IP가 지정됩니다. 254 서비스의 한계에 도달하여 추가 서비스가 필요하면 새 클러스터를 작성해야 합니다. 
* **새 클러스터**: dal13 구역에서 2018년 2월 이후에 또는 기타 구역에서 2017년 10월 이후에 작성된 클러스터에서는 서비스에 172.21.0.0/16 범위의 65,000 IP 중 하나의 IP가 지정됩니다. 

충돌을 피하려면 사용자의 작업자 노드와 통신하는 노드에 이 IP 범위를 사용하지 마십시오. 또한 DNS 검색 항목이 서비스에 대해 작성되며 클러스터의 `kube-dns` 컴포넌트에 저장됩니다. DNS 항목에는 서비스의 이름, 서비스가 작성된 네임스페이스 및 지정된 클러스터 내 IP 주소에 대한 링크가 포함되어 있습니다. 

클러스터 IP 서비스의 뒤에 있는 팟(Pod)에 액세스하기 위해, 앱은 서비스의 클러스터 내 IP 주소를 사용하거나 서비스의 이름을 사용하여 요청을 전송할 수 있습니다. 서비스의 이름을 사용하는 경우, 해당 이름은 `kube-dns` 컴포넌트에서 검색되며 서비스의 클러스터 내 IP 주소로 라우팅됩니다. 요청이 서비스에 도달하는 경우, 서비스는 클러스터 내 IP 주소 및 이들이 배치된 작업자 노드와는 무관하게 모든 요청이 팟(Pod)에 동일하게 전달되도록 보장합니다. 
