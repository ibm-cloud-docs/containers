---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 외부 네트워킹 계획
{: #planning}

클러스터를 작성할 때 모든 클러스터가 퍼블릭 VLAN에 연결되어야 합니다. 퍼블릭 VLAN은 클러스터 작성 중에 작업자 노드에 지정된 공인 IP 주소를 판별합니다.
{:shortdesc}

무료 및 표준 클러스터 모두의 작업자 노드에 대한 공용 네트워크 인터페이스는 Calico 네트워크 정책으로 보호됩니다. 이러한 정책은 기본적으로 대부분의 인바운드 트래픽을 차단합니다. 그러나 NodePort, Loadbalancer 및 Ingress 서비스에 대한 연결과 마찬가지로 Kubernetes가 작동하는 데 필요한 인바운드 트래픽은 허용됩니다. 수정 방법을 포함하여 이러한 정책에 대한 자세한 정보는 [네트워크 정책](cs_network_policy.html#network_policies)을 참조하십시오.

|클러스터 유형|클러스터의 퍼블릭 VLAN 관리자|
|------------|------------------------------------------|
|{{site.data.keyword.Bluemix_notm}}의 무료 클러스터|{{site.data.keyword.IBM_notm}}|
|{{site.data.keyword.Bluemix_notm}}의 표준 클러스터|IBM Cloud 인프라(SoftLayer) 계정의 사용자|
{: caption="VLAN 관리 책임" caption-side="top"}

작업자 노드와 포드 간의 클러스터 내 네트워크 통신에 대한 정보는 [클러스터 내부 네트워킹](cs_secure.html#in_cluster_network)을 참조하십시오. Kubernetes 클러스터에서 실행 중인 앱을 온프레미스 네트워크 또는 클러스터 외부의 앱에 안전하게 연결하는 데 대한 정보는 [VPN 연결 설정](cs_vpn.html)을 참조하십시오.

## 앱에 대한 공용 액세스 허용
{: #public_access}

인터넷에서 공용으로 앱을 사용할 수 있으려면 클러스터에 앱을 배치하기 전에 구성 파일을 업데이트해야 합니다.
{:shortdesc}

*{{site.data.keyword.containershort_notm}}의 Kubernetes 데이터 평면*

![{{site.data.keyword.containerlong_notm}} Kubernetes 아키텍처](images/networking.png)

이 다이어그램은 Kubernetes가 {{site.data.keyword.containershort_notm}}에서 사용자 네트워크 트래픽을 운반하는 방법을 보여줍니다. 무료 또는 표준 클러스터를 작성했는지에 따라 인터넷에서 앱에 다양한 방법으로 액세스할 수 있습니다.

<dl>
<dt><a href="#nodeport" target="_blank">NodePort 서비스</a>(무료 및 표준 클러스터)</dt>
<dd>
 <ul>
  <li>모든 작업자 노드에서 공용 포트를 노출시키고, 임의의 작업자 노드의 공인 IP 주소를 사용하여 클러스터의 서비스에 공용으로 액세스합니다.</li>
  <li>Iptables는 로드 밸런스가 앱의 포드 전체에서 요청하는 기능이며, 고성능 네트워크 라우팅과 네트워크 액세스 제어를 제공합니다.</li>
  <li>작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드가 제거되거나 다시 작성되면 새 공인 IP 주소가 작업자 노드에 지정됩니다.</li>
  <li>NodePort 서비스는 공용 액세스를 테스트하기에 좋습니다. 짧은 시간 동안만 공용 액세스가 필요한 경우에도 사용할 수 있습니다.</li>
 </ul>
</dd>
<dt><a href="#loadbalancer" target="_blank">LoadBalancer 서비스</a>(표준 클러스터 전용)</dt>
<dd>
 <ul>
  <li>모든 표준 클러스터는 앱에 대한 외부 TCP/UDP 로드 밸런서를 작성하는 데 사용할 수 있는 4개의 포터블 공인 IP 주소 및 4개의 사설 IP 주소로 프로비저닝됩니다.</li>
  <li>Iptables는 로드 밸런스가 앱의 포드 전체에서 요청하는 기능이며, 고성능 네트워크 라우팅과 네트워크 액세스 제어를 제공합니다.</li>
  <li>로드 밸런서에 지정된 포터블 공인 IP 주소는 영구적이며 클러스터에서 작업자 노드가 다시 작성될 때 변경되지 않습니다.</li>
  <li>앱이 요구하는 포트를 노출함으로써 로드 밸런서를 사용자 정의할 수 있습니다.</li></ul>
</dd>
<dt><a href="#ingress" target="_blank">Ingress</a>(표준 클러스터 전용)</dt>
<dd>
 <ul>
  <li>안전하고 고유한 공용 시작점을 사용하여 수신 요청을 앱으로 라우팅하는 한 개의 외부 HTTP 또는 HTTPS 로드 밸런서를 작성하여 클러스터의 다중 앱을 노출시킵니다.</li>
  <li>하나의 공용 라우트를 사용하여 여러 앱을 클러스터에 서비스로 노출할 수 있습니다.</li>
  <li>Ingress는 두 개의 기본 컴포넌트(Ingress 리소스와 애플리케이션 로드 밸런서)로 구성되어 있습니다. <ul>
    <li>Ingress 리소스는 앱에 대한 수신 요청을 라우팅하고 로드 밸런싱하는 방법에 대한 규칙을 정의합니다.</li>
    <li>애플리케이션 로드 밸런서는 수신 HTTP 또는 HTTPS 서비스 요청을 청취하고 각 Ingress 리소스에 대해 정의된 규칙을 기반으로 앱의 포드에서 요청을 전달합니다. </li>
   </ul>
  <li>사용자 정의 라우팅 규칙으로 사용자 고유의 애플리케이션 로드 밸런서를 구현하려는 경우와 앱에 대한 SSL 종료가 필요한 경우 Ingress를 사용하십시오.</li>
 </ul>
</dd></dl>

다음 의사결정 트리에 따라 애플리케이션을 위한 최고의 네트워킹 옵션을 선택할 수 있습니다.

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="이 이미지는 애플리케이션을 위한 최고의 네트워킹 옵션을 선택하는 과정을 안내합니다. 이 이미지가 표시되지 않는 경우에도 문서에서 해당 정보를 찾을 수 있습니다. " style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html#config" alt="Nodeport 서비스" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html#config" alt="Loadbalancer 서비스" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html#config" alt="Ingress 서비스" shape="circle" coords="445, 420, 45"/>
</map>


<br />


## NodePort 서비스를 사용하여 인터넷에 앱 노출
{: #nodeport}

작업자 노드에서 공용 포트를 노출하고, 작업자 노드의 공인 IP 주소를 사용하여 인터넷을 통해 클러스터의 서비스에 공용으로 액세스하십시오.
{:shortdesc}

NodePort 유형의 Kubernetes 서비스를 작성하여 앱을 노출하면 30000 - 32767 범위의 NodePort 및 내부 클러스터 IP 주소가 서비스에 지정됩니다. NodePort 서비스는 앱의 수신 요청에 대한 외부 시작점 역할을 합니다. 지정된 NodePort는 클러스터에 있는 각 작업자 노드의 kubeproxy 설정에서 공용으로 노출됩니다. 모든 작업자 노드는 지정된 NodePort에서 서비스의 수신 입력을 청취하기 시작합니다. 인터넷에서 서비스에 액세스하기 위해, 사용자는 `<ip_address>:<nodeport>` 형식의 NodePort 및 클러스터 작성 중에 지정된 작업자 노드의 공인 IP 주소를 사용할 수 있습니다. 공인 IP 주소 이외에 작업자 노드의 사설 IP 주소를 통해 NodePort 서비스를 사용할 수 있습니다.

다음 다이어그램은 NodePort 서비스가 구성될 때 인터넷에서 앱으로 통신이 이루어지는 방식을 표시합니다.

![Kubernetes NodePort 서비스를 사용하여 서비스 노출](images/cs_nodeport.png)

다이어그램에 표시된 대로, 요청이 NodePort 서비스에 도달하면 자동으로 서비스의 내부 클러스터 IP에 전달되며 추가로 `kube-proxy` 컴포넌트에서 앱이 배치된 포드의 사설 IP 주소로 전달됩니다. 클러스터 IP는 클러스터 내에서만 액세스가 가능합니다. 서로 다른 포드에서 실행 중인 앱의 다중 복제본이 있는 경우 `kube-proxy` 컴포넌트가 모든 복제본 간에 수신 요청을 로드 밸런싱합니다.

**참고:** 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드가 제거되거나 다시 작성되면 새 공인 IP 주소가 작업자 노드에 지정됩니다. 앱에 대한 공용 액세스를 테스트하기 위해 또는 짧은 시간 동안에만 공용 액세스가 필요한 경우에 NodePort 서비스를 사용할 수 있습니다. 서비스에 대한 추가 가용성과 안정적인 공인 IP 주소가 필요한 경우에는 [LoadBalancer 서비스](#loadbalancer) 또는 [Ingress](#ingress)를 사용하여 앱을 노출하십시오.

{{site.data.keyword.containershort_notm}}에서 NodePort 유형의 서비스를 작성하는 방법에 대한 지시사항은 [NodePort 서비스 유형을 사용하여 앱에 대한 공용 액세스 구성](cs_nodeport.html#config)을 참조하십시오.

<br />



## LoadBalancer 서비스를 사용하여 인터넷에 앱 노출
{: #loadbalancer}

포트를 노출하고 로드 밸런서의 공인 또는 사설 IP 주소를 사용하여 앱에 액세스합니다.
{:shortdesc}


표준 클러스터를 작성할 때 {{site.data.keyword.containershort_notm}}는 다섯 개의 포터블 공인 IP 주소와 다섯 개의 포터블 사설 IP 주소를 자동으로 요청하며 클러스터 작성 중에 IBM Cloud 인프라(SoftLayer) 계정에 프로비저닝합니다. 포터블 IP 주소 중 2개(하나는 공인, 하나는 사설)는 [Ingress 애플리케이션 로드 밸런서](#ingress)에 사용됩니다. 네 개의 포터블 공인 IP 주소와 네 개의 포터블 사설 IP 주소는 LoadBalancer 서비스를 작성하여 앱을 노출하는 데 사용될 수 있습니다.

퍼블릭 VLAN의 클러스터에 Kubernetes LoadBalancer 서비스를 작성하는 경우 외부 로드 밸런서가 작성됩니다. 4개의 사용 가능한 공인 IP 주소 중 하나가 로드 밸런서에 지정됩니다. 포터블 공인 IP 주소를 사용할 수 없는 경우에는 LoadBalancer 서비스를 작성할 수 없습니다. LoadBalancer 서비스는 앱의 수신 요청에 대한 외부 시작점 역할을 합니다. NodePort 서비스와 다르게 로드 밸런서에 포트를 지정할 수 있으며 특정 포트 범위에 바인드되지 않습니다. LoadBalancer 서비스에 지정된 포터블 공인 IP 주소는 영구적이며 작업자 노드가 제거되거나 다시 작성될 때 변경되지 않습니다. 따라서 LoadBalancer 서비스가 NodePort 서비스보다 고가용성입니다. 인터넷에서 LoadBalancer 서비스에 액세스하려면, `<ip_address>:<port>` 형식의 지정된 포트와 로드 밸런서의 공인 IP 주소를 사용하십시오.

다음 다이어그램은 LoadBalancer가 인터넷에서 앱으로 통신하는 방식을 표시합니다.

![LoadBalancer 서비스 유형을 사용하여 서비스 노출](images/cs_loadbalancer.png)

다이어그램에 표시된 대로 요청이 LoadBalancer 서비스에 도달하면 서비스 작성 중에 LoadBalancer 서비스에 지정된 내부 클러스터 IP 주소로 자동으로 전달됩니다. 
클러스터 IP 주소는 클러스터 내에서만 액세스가 가능합니다. 클러스터 IP 주소에서 수신 요청이 추가로 작업자 노드의 `kube-proxy` 컴포넌트로 전달됩니다. 그런 다음, 앱이 배치된 포드의 사설 IP 주소로 요청이 전달됩니다. 서로 다른 포드에서 실행 중인 앱의 다중 복제본이 있는 경우 `kube-proxy` 컴포넌트가 모든 복제본 간에 수신 요청을 로드 밸런싱합니다.

LoadBalancer 서비스를 사용하는 경우 작업자 노드의 각 IP 주소에서 노드 포트를 사용할 수도 있습니다. LoadBalancer 서비스를 사용하는 동안 노드 포트에 대한 액세스를 차단하려면 [수신 트래픽 차단](cs_network_policy.html#block_ingress)을 참조하십시오.

LoadBalancer 서비스를 작성할 때 IP 주소의 옵션은 다음과 같습니다.

- 클러스터가 퍼블릭 VLAN에 있는 경우 포터블 공인 IP 주소가 사용됩니다.
- 클러스터가 프라이빗 VLAN에서만 사용 가능한 경우 포터블 사설 IP 주소가 사용됩니다.
- 구성 파일에 `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.



{{site.data.keyword.containershort_notm}}에서 LoadBalancer 서비스를 작성하는 방법에 대한 지시사항은 [로드 밸런서 서비스 유형을 사용하여 앱에 대한 공용 액세스 구성](cs_loadbalancer.html#config)을 참조하십시오.


<br />



## Ingress로 인터넷에 앱 노출
{: #ingress}

Ingress를 사용하면 클러스터에서 여러 서비스를 노출할 수 있으며 단일 공용 시작점을 사용하여 이를 공용으로 사용 가능하게 할 수 있습니다.
{:shortdesc}

공개하려는 각 앱에 대한 로드 밸런서 서비스를 작성하기 보다는 Ingress에서는 해당 개별 경로를 기반으로 클러스터 내부 및 외부의 앱으로 공용 요청을 전달할 수 있도록 허용하는 고유 공용 라우트를 제공합니다. 
Ingress는 두 개의 기본 컴포넌트로 구성되어 있습니다. Ingress 리소스는 앱의 수신 요청을 라우팅하는 방법에 대한 규칙을 정의합니다. 모든 Ingress 리소스는 수신 HTTP 또는 HTTPS 서비스 요청을 청취하고 각 Ingress 리소스에 대해 정의된 규칙을 기반으로 요청을 전달하는 Ingress 애플리케이션 로드 밸런서에 등록되어야 합니다.

표준 클러스터를 작성할 때 {{site.data.keyword.containershort_notm}}에서 자동으로 클러스터용 고가용성 애플리케이션 로드 밸런서를 작성하고 `<cluster_name>.<region>.containers.mybluemix.net` 형식의 고유 공용 라우트를 이에 지정합니다. 공용 라우트는 클러스터 작성 중에 IBM Cloud 인프라(SoftLayer) 계정으로 프로비저닝된 포터블 공인 IP 주소에 링크됩니다. 사설 애플리케이션 로드 밸런서도 자동으로 작성되지만 자동으로 사용으로 설정되지는 않습니다.

다음 다이어그램은 Ingress가 인터넷에서 앱으로 통신하는 방식을 표시합니다.

![{{site.data.keyword.containershort_notm}} Ingress 지원을 사용하여 서비스 노출](images/cs_ingress.png)

Ingress를 통해 앱을 노출하려면 앱에 대한 Kubernetes 서비스를 작성하고 Ingress 리소스를 정의하여 애플리케이션 로드 밸런서에 이 서비스를 등록해야 합니다. Ingress 리소스는 노출된 앱에 대한 고유 URL을 형성하기 위해 공용 라우트에 추가하려는 경로(예: `mycluster.us-south.containers.mybluemix.net/myapp`)를 지정합니다. 다이어그램에 표시된 대로 이 라우트를 웹 브라우저에 입력하면 요청이 애플리케이션 로드 밸런서의 링크된 포터블 공인 IP 주소로 전송됩니다. 애플리케이션 로드 밸런서는 `mycluster` 클러스터에서 `myapp` 경로에 대한 라우팅 규칙이 존재하는지 여부를 확인합니다. 일치하는 규칙이 발견된 경우에는 원래 Ingress 리소스 오브젝트에 정의된 규칙을 고려하여 개별 경로가 포함된 요청이 앱이 배치된 포드에 전달됩니다. 앱이 수신 요청을 처리할 수 있도록 하려면, 앱이 Ingress 리소스에 정의된 개별 경로에서 청취하는지 확인하십시오.



다음 시나리오를 위해 앱에 대한 수신 네트워크 트래픽을 관리하도록 애플리케이션 로드 밸런서를 구성할 수 있습니다.

-   TLS 종료 없이 IBM 제공 도메인 사용
-   TLS 종료와 함께 IBM 제공 도메인 사용
-   TLS 종료와 함께 사용자 정의 도메인 사용
-   클러스터 외부의 앱에 액세스하기 위해 TLS 종료와 함께 IBM 제공 또는 사용자 정의 도메인 사용
-   TLS 종료 없이 사설 애플리케이션 로드 밸런서와 사용자 정의 도메인 사용
-   TLS 종료와 함께 사설 애플리케이션 로드 밸런서와 사용자 정의 도메인 사용
-   어노테이션을 사용하여 애플리케이션 로드 밸런서에 기능 추가

{{site.data.keyword.containershort_notm}}에서 Ingress를 사용하는 방법에 대한 지시사항은 [Ingress를 사용하여 앱에 대한 공용 액세스 구성](cs_ingress.html#ingress)을 참조하십시오.

<br />

