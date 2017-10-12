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


# {{site.data.keyword.containerlong_notm}}에 대한 보안
{: #cs_security}

위험성 분석과 보안 보장을 위해 기본 제공 보안 기능을 사용할 수 있습니다. 이러한 기능을 사용하면 클러스터 인프라 및 네트워크 통신을 보호하고 컴퓨팅 리소스를 격리하며 인프라 컴포넌트 및 컨테이너 배치에서 보안 준수를 보장하는 데 도움이 됩니다.
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png"><img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} 클러스터 보안" style="width:400px;" /></a>

<table summary="테이블의 첫 번째 행에는 두 개의 열이 있습니다. 나머지 행은 왼쪽에서 오른쪽으로 읽어야 하며 1열에는 서버 위치, 2열에는 일치시킬 IP 주소가 있습니다.">
      <thead>
  <th colspan=2><img src="images/idea.png"/> {{site.data.keyword.containershort_notm}}의 기본 제공 클러스터 보안 설정</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes 마스터</td>
      <td>각 클러스터의 Kubernetes 마스터는 IBM에서 관리하고 가용성이 높습니다. 작업자 노드와의 양방향 보안 통신과 보안 준수를 보장하는 {{site.data.keyword.containershort_notm}} 보안 설정이 포함됩니다. 필요하면 IBM에 의해 업데이트가 수행됩니다. 전용 Kubernetes 마스터는 클러스터에서 모든 Kubernetes 리소스를 중앙 집중식으로 제어하고 모니터합니다. 클러스터의 용량 및 배치 요구사항에 따라 Kubernetes 마스터는 사용 가능한 작업자 노드 간에 배치하도록 컨테이너화된 앱을 자동으로 스케줄링합니다. 자세한 정보는 [Kubernetes 마스터 보안](#cs_security_master)을 참조하십시오. </td>
    </tr>
    <tr>
      <td>작업자 노드</td>
      <td>컨테이너는 클러스터 전용이며 IBM 고객을 위한 컴퓨팅, 네트워크 및 스토리지 격리를 보장하는 작업자 노드에 배치됩니다. {{site.data.keyword.containershort_notm}}는 공용 및 사설 네트워크에서 작업자 노드의 보안을 유지하고 작업자 노드 보안 준수를 보장할 수 있도록 기본 제공되는 보안 기능을 제공합니다. 자세한 정보는 [작업자 노드 보안](#cs_security_worker)을 참조하십시오. </td>
     </tr>
     <tr>
      <td>이미지</td>
      <td>클러스터 관리자인 경우에는 Docker 이미지를 저장하고 이를 클러스터 사용자 간에 공유할 수 있는 {{site.data.keyword.registryshort_notm}}의 사용자 고유의 보안 Docker 이미지 저장소를 설정할 수 있습니다. 안전한 컨테이너 배치를 보장하기 위해, 개인용 레지스트리의 모든 이미지는 Vulnerability Advisor에 의해 스캔됩니다. Vulnerability Advisor는 잠재적 취약점을 스캔하고 보안 권장사항을 작성하며 취약점 해결을 위한 지시사항을 제공하는 {{site.data.keyword.registryshort_notm}}의 컴포넌트입니다. 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 이미지 보안](#cs_security_deployment)을 참조하십시오.</td>
    </tr>
  </tbody>
</table>

## Kubernetes 마스터
{: #cs_security_master}

Kubernetes 마스터를 보호하고 클러스터 네트워크 통신을 보호하기 위해 기본 제공되는 Kubernetes 마스터 보안 기능을 검토합니다.
{: shortdesc}

<dl>
  <dt>완전 관리되는 전용 Kubernetes 마스터</dt>
    <dd>{{site.data.keyword.containershort_notm}}의
모든 Kubernetes 클러스터는 IBM 소유 {{site.data.keyword.BluSoftlayer_full}} 계정에서 IBM이 관리하는 전용 Kubernetes 마스터에 의해 제어됩니다. Kubernetes 마스터는 다른 IBM 고객과 공유하지 않는 다음의 전용 컴포넌트로 설정됩니다. <ul><ul><li>etcd 데이터 저장소: 서비스, 배치, 포드와 같은 클러스터의 모든 Kubernetes 리소스를 저장합니다. Kubernetes ConfigMaps 및 시크릿은 포드에서 실행되는 앱에서 사용할 수 있도록 키 값 쌍으로 저장되는 앱 데이터입니다. etcd의 데이터는 IBM에서 관리하는 암호화된 디스크에 저장되며 데이터 보호와 무결성을 보장하기 위해 포드에 전송될 때 TLS를 통해
암호화됩니다. <li>kube-apiserver: Kubernetes 마스터에 대한 작업자 노드의 모든 요청에 대해 기본 시작점 역할을 합니다. 
kube-apiserver는 요청을 유효성 검증하고 처리하며 etcd 데이터 저장소에서 읽고 쓰기가 가능합니다. <li><kube-scheduler: 용량 및 성능 요구사항, 하드웨어 및 소프트웨어 정책 제한조건, 연관관계 방지 스펙, 그리고 워크로드 요구사항을 고려하여 포드가 배치될 위치를 결정합니다. 
요구사항과 일치하는 작업자 노드를 찾을 수 없으면 포드가 클러스터에 배치되지 않습니다. <li>kube-controller-manager: 원하는 상태를 얻기 위한 상대 포드의 작성과 복제본 세트의 모니터링을 담당합니다. <li>OpenVPN: 모든 Kubernetes 마스터 대 작업자 노드 통신을 위한 보안 네트워크 연결을 제공하기 위한
{{site.data.keyword.containershort_notm}} 특정 컴포넌트. </ul></ul></dd>
  <dt>모든 작업자 노드 대 Kubernetes 마스터 통신을 위한 TLS 보안 네트워크 연결</dt>
    <dd>Kubernetes 마스터에 대한 네트워크 통신을 보호하기 위해,
{{site.data.keyword.containershort_notm}}는 모든 클러스터에 대한
kube-apiserver 및 etcd 데이터 저장소 컴포넌트와의 양방향 통신을 암호화하는 TLS 인증서를 생성합니다.
이러한 인증서는 클러스터 간에 또는 Kubernetes 마스터 컴포넌트 간에 절대 공유되지 않습니다. </dd>
  <dt>모든 Kubernetes 마스터 대 작업자 노드 통신을 위한 OpenVPN 보안 네트워크 연결</dt>
    <dd>Kubernetes가 `https` 프로토콜을 사용하여 Kubernetes 마스터 및 작업자 노드 간의 통신을 보호하지만, 기본적으로 작업자 노드에서는 인증이 제공되지 않습니다. 이 통신을 보호하기 위해 {{site.data.keyword.containershort_notm}}는 클러스터가 작성될 때 Kubernetes 마스터 및 작업자 노드 간의 OpenVPN 연결을 자동으로 설정합니다. </dd>
  <dt>지속적 Kubernetes 마스터 네트워크 모니터링</dt>
    <dd>모든 Kubernetes 마스터는 프로세스 레벨 서비스 거부(DoS) 공격을 제어하고 처리하기 위해 IBM에 의해 지속적으로 모니터됩니다. </dd>
  <dt>Kubernetes 마스터 노드 보안 준수</dt>
    <dd>{{site.data.keyword.containershort_notm}}는 마스터 노드 보호를 보장하기 위해 적용이 필요한 OS 특정 보안 수정사항 및 Kubernetes에서 발견된 취약점에 대해 Kubernetes 마스터가 배치된 모든 노드를 자동으로 스캔합니다. 취약점이 발견된 경우, {{site.data.keyword.containershort_notm}}는 자동으로 수정사항을 적용하며 사용자를 위해 취약점을 해결합니다. </dd>
</dl>  

## 작업자 노드
{: #cs_security_worker}

작업자 노드 환경을 보호하고 리소스, 네트워크 및 스토리지 격리를 보장하기 위해 기본 제공되는 작업자 노드 보안 기능을 검토합니다.
{: shortdesc}

<dl>
  <dt>컴퓨팅, 네트워크 및 스토리지 인프라 격리</dt>
    <dd>클러스터를 작성하는 경우 가상 머신은 고객 {{site.data.keyword.BluSoftlayer_notm}} 계정 또는 IBM의 전용 {{site.data.keyword.BluSoftlayer_notm}} 계정의 작업자 노드로 프로비저닝됩니다. 작업자 노드는 클러스터 전용이며, 기타 클러스터의 워크로드를 호스팅하지 않습니다. </br> 모든 {{site.data.keyword.Bluemix_notm}} 계정은 작업자 노드에서 고품질 네트워크 성능과 격리를 보장할 수 있도록 {{site.data.keyword.BluSoftlayer_notm}} VLAN으로 설정됩니다. </br>클러스터에서 데이터의 지속성을 위해 사용자는 {{site.data.keyword.BluSoftlayer_notm}}에서 전용 NFS 기반 파일 스토리지를 프로비저닝할 수 있으며 해당 플랫폼의 기본 제공되는 데이터 보안 기능을 최대한 활용할 수 있습니다. </dd>
  <dt>안전한 작업자 노드 설정</dt>
    <dd>모든 작업자 노드는 사용자가 변경할 수 없는 Ubuntu 운영 체제로 설정됩니다. 잠재적인 공격으로부터 작업자 노드의 운영 체제를 보호하기 위해 모든 작업자 노드가 Linux iptable 규칙이 적용되는 전문 방화벽 설정으로 구성됩니다. </br> Kubernetes에서 실행되는 모든 컨테이너는 클러스터 작성 중에 모든 작업자 노드에서 구성되는 사전 정의된 Calico 네트워크 정책 설정에 의해 보호됩니다. 이 설정은 작업자 노드와 포드 간의 보안 네트워크 통신을 보장합니다. 컨테이너가 작업자 노드에서 수행할 수 있는 조치를 제한하기 위해 사용자가 작업자 노드에서 [AppArmor 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tutorials/clusters/apparmor/)을 구성하도록 선택할 수 있습니다. </br> 기본적으로, 루트 사용자에 대한 SSH 액세스는 작업자 노드에서 사용 불가능합니다. 작업자 노드에서 추가 기능을 설치하려면 모든 작업자 노드에서 실행할 모든 항목에 대해 [Kubernetes 디먼 세트 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset)를 사용하거나 실행해야 하는 일회성 조치에 대해서는 [Kubernetes 작업 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/)을 사용하십시오.</dd>
  <dt>Kubernetes 작업자 노드 보안 준수</dt>
    <dd>IBM은 보안 자문 팀과 내부 및 외부적으로 공동 작업함으로써 작업자 노드에 대한 잠재적 보안 준수 문제를 식별하며 발견된 취약점을 해결할 수 있도록 지속적으로 준수 업데이트 및 보안 패치를 릴리스합니다. 업데이트 및 보안 패치는 IBM에 의해 작업자 노드의 운영 체제에 자동으로 배포됩니다. 이를 수행하기 위해 IBM은 작업자 노드에 대한 SSH 액세스를 유지합니다. </br> <b>노트</b>: 일부 업데이트를 수행하려면 작업자 노드를 다시 부팅해야 합니다. 그러나 IBM은 업데이트나 보안 패치의 설치 중에 작업자 노드를 다시 부팅하지 않습니다. 업데이트와 보안 패치의 설치 완료를 확인하기 위해 사용자에게는 정기적으로 작업자 노드를 다시 부팅하도록 권장됩니다. </dd>
  <dt>SoftLayer 네트워크 방화벽 지원</dt>
    <dd>{{site.data.keyword.containershort_notm}}는 모든 [{{site.data.keyword.BluSoftlayer_notm}} 방화벽 오퍼링 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud-computing/bluemix/network-security)과 호환 가능합니다. {{site.data.keyword.Bluemix_notm}} 퍼블릭에서 사용자는 클러스터에 대한 전용 네트워크 보안을 제공하고 네트워크 침입을 발견하여 이를 해결하기 위한 사용자 정의 네트워크 정책으로 방화벽을 설정할 수 있습니다. 예를 들어, [Vyatta ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/vyatta-1)가 방화벽 역할을 수행하여 원하지 않는 트래픽을 차단하게 설정하도록 선택할 수 있습니다. 방화벽을 설정할 때 마스터와 작업자 노드가 통신할 수 있도록 각 지역의 [필수 포트와 IP 주소도 개방해야 합니다](#opening_ports). {{site.data.keyword.Bluemix_notm}} 데디케이티드에서 방화벽, DataPower, Fortigate 및 DNS는 표준 전용 환경 배치의 일부로서 이미 구성되어 있습니다. </dd>
  <dt>서비스를 개인용으로 설정하거나 일부 서비스 및 앱을 선택적으로 공용 인터넷에 노출</dt>
    <dd>사용자는 작업자 노드와 포드 간에 보안 통신을 보장하기 위해 서비스와 앱을 개인용으로 유지하고 이 주제에서 설명하는 기본 제공 보안 기능을 최대로 활용하도록 선택할 수 있습니다. 서비스와 앱을 공용 인터넷에 노출하기 위해, 공용으로 안전하게 서비스를 사용할 수 있도록 Ingress 및 로드 밸런서 지원을 활용할 수 있습니다. </dd>
  <dt>작업자 노드와 앱을 온프레미스 데이터 센터에 안전하게 연결하십시오.</dt>
    <dd>Kubernetes 클러스터를 온프레미스 데이터 센터와 연결하는 IPSec VPN 엔드포인트를 구성하도록 Vyatta Gateway Appliance 또는 Fortigate Appliance를 설정할 수 있습니다. 암호화된 터널을 통해 Kubernetes 클러스터에서 실행되는 모든 서비스가 사용자 디렉토리, 데이터베이스 또는 메인프레임과 같은 온프레미스 앱과 안전하게 통신할 수 있습니다. 자세한 정보는 [온프레미스 데이터 센터에 클러스터 연결![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)을 참조하십시오.</dd>
  <dt>클러스터 활동의 지속적 모니터링 및 로깅</dt>
    <dd>표준 클러스터인 경우에는 용량 사용 정보 또는 롤링 업데이트 진행상태, 작업자 노드 추가 등의 모든 클러스터 관련 이벤트를 {{site.data.keyword.containershort_notm}}에서 로깅하고 모니터링하며 IBM 모니터링 및 로깅 서비스로 전송됩니다. </dd>
</dl>

### 방화벽에서 필수 포트와 IP 주소 열기
{: #opening_ports}

작업자 노드용으로 방화벽을 설정하거나 {{site.data.keyword.BluSoftlayer_notm}} 계정에서 방화벽 설정을 사용자 정의할 때 작업자 노드와 Kubernetes 마스터가 통신할 수 있도록 특정 포트와 IP 주소를 열어야 합니다.

1.  클러스터에서 모든 작업자 노드에 대한 공인 IP 주소를 기록해 놓으십시오. 

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  방화벽에서 작업자 노드와 양방향으로 다음 연결을 허용하십시오. 

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>작업자 노드에서의 OUTBOUND 연결의 경우 `<each_worker_node_publicIP>`의 소스 작업자 노드에서 대상 TCP/UDP 포트 범위 20000-32767 및 다음 IP 주소와 네트워크 그룹으로의 발신 네트워크 트래픽을 허용하십시오.</br>
    

    <table summary="테이블의 첫 번째 행에는 두 개의 열이 있습니다. 나머지 행은 왼쪽에서 오른쪽으로 읽어야 하며 1열에는 서버 위치, 2열에는 일치시킬 IP 주소가 있습니다.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> 아웃바운드 IP 주소</th>
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


## 네트워크 정책
{: #cs_security_network_policies}

모든 Kubernetes 클러스터는 Calico라는 네트워크 플러그인으로 설정됩니다. 모든 작업자 노드의 공용 네트워크 인터페이스 보안을 위해 기본 네트워크 정책이 설정됩니다. 고유 보안 요구사항이 있을 때 Calico 및 기본 Kubernetes 기능을 사용하여 클러스터에 대한 네트워크 정책을 더 구성할 수 있습니다. 이러한 네트워크 정책은 클러스터에서 포드에 허용하거나 차단하고자 하는 네트워크 트래픽을 지정합니다.
{: shortdesc}

클러스터에 대한 네트워크 정책을 작성하기 위해 Calico 및 기본 Kubernetes 기능 중에서 선택할 수 있습니다. Kubernetes 네트워크 정책을 사용하여 시작할 수 있지만, 더 강력한 기능을 위해서는 Calico 네트워크 정책을 사용하십시오. 

<ul><li>[Kubernetes 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): 포드가 서로 통신할 수 있는지 지정하는 등의 일부 기본 옵션이 제공됩니다. 포드에 대한 수신 네트워크 트래픽은 연결을 시도하는 포드의 Kubernetes 네임스페이스 및
레이블을 기반으로 프로토콜 및 포트에 대해 허용되거나 차단될 수 있습니다. </br>이러한 정책은
`kubectl` 명령 또는 Kubernetes API를 사용하여 적용될 수 있습니다. 해당 정책이 적용되면
Calico 네트워크 정책으로 변환되고 Calico는 이러한 정책을 시행합니다. <li>[Calico 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy): 이러한 정책은 Kubernetes 네트워크 정책의 수퍼세트이며 다음 기능으로 기본 Kubernetes 기능을 향상시킵니다.
<ul><ul><li>Kubernetes 포드 트래픽뿐만 아니라 특정 네트워크 인터페이스에서 네트워크 트래픽을 허용하거나 차단합니다. <li>수신(ingress) 및 발신(egress) 네트워크 트래픽을 허용하거나 차단합니다. <li>소스 또는 대상 IP 주소 또는 CIDR을 기반으로 하는 트래픽을 허용하거나 차단합니다. </ul></ul></br>
이러한 정책은 `calicoctl` 명령을 사용하여 적용됩니다. Calico는
Kubernetes 작업자 노드에서 Linux iptables 규칙을 설정하여 Calico 정책으로 변환된 Kubernetes 네트워크 정책을 포함하는 해당 정책을
시행합니다. Iptables 규칙은 대상으로 지정된 리소스에 전달되도록 네트워크 트래픽이 충족해야 하는 특성을 정의하기 위해
작업자 노드에 대한 방화벽의 역할을 합니다. </ul>


### 기본 정책 구성
{: #concept_nq1_2rn_4z}

클러스터가 작성되면 공용 인터넷에서 작업자 노드에 대한 수신 트래픽을 제한하기 위해 기본 네트워크 정책이 각 작업자 노드의 공용 네트워크 인터페이스에
대해 자동으로 설정됩니다. 이러한 정책은 포드에서 포드 트래픽에 영향을 미치지 않으며
Kubernetes 노드 포트, 로드 밸런서 및 Ingress 서비스에 대한 액세스를 허용하도록 설정됩니다. 

기본 정책은 포드에 직접 적용되지 않습니다. Calico [호스트 엔드포인트 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal)를 사용하여 작업자 노드의 공용 네트워크 인터페이스에 적용됩니다. 호스트 엔드포인트가 Calico에서 작성되면
그 작업자 노드의 네트워크 인터페이스에서 나가고 들어오는 모든 트래픽은 그 트래픽이 정책에서 허용되는 경우를 제외하고 차단됩니다. 

포트를 여는 정책이 없는 다른 모든 포트가 그렇듯이 SSH를 허용하는 정책이 존재하지 않아서 공용 네트워크 인터페이스를 통하는 SSH 액세스가
차단된다는 점을 참고하십시오. SSH 액세스 및 기타 액세스는 각 작업자 노드의
사설 네트워크 인터페이스에서 사용 가능합니다. 

**중요:** 정책을 완전히 이해하고 정책에서 허용하고 있는 트래픽이 필요하지 않다는 것을 아는 경우를 제외하고는 호스트 엔드포인트에 적용된 정책을 제거하지 마십시오. 



  <table summary="테이블의 첫 번째 행에는 두 개의 열이 있습니다. 나머지 행은 왼쪽에서 오른쪽으로 읽어야 하며 1열에는 서버 위치, 2열에는 일치시킬 IP 주소가 있습니다.">
      <thead>
  <th colspan=2><img src="images/idea.png"/> 각 클러스터의 기본 정책</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>아웃바운드 트래픽을 모두 허용합니다. </td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>수신 icmp 패킷(ping)을 허용합니다. </td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>kubelet에서 사용되는 포트인 포트 10250으로 모든 수신 트래픽을 허용합니다. 이 정책은 `kubectl logs` 및 `kubectl exec`가 Kubernetes
클러스터에서 올바르게 작동하도록 허용합니다. </td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>해당 서비스가 노출된 포드에 수신 노드 포트, 로드 밸런서 및 Ingress 서비스 트래픽을 허용합니다. Kubernetes는 해당 서비스 요청을 올바른 포드에 전달하기 위해 대상 네트워크 주소 변환(DNAT)을
사용하기 때문에 해당 서비스가 공용 인터페이스에서 노출하는 포트를 지정할 필요가 없다는 점을 참고하십시오. 호스트 엔드포인트 정책이 iptables에 적용되기 전에 해당 전달이 이루어집니다. </td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>작업자 노드를 관리하는 데 사용되는 특정 {{site.data.keyword.BluSoftlayer_notm}} 시스템에 대한 수신 연결을 허용합니다. </td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>작업자 노드 사이에서 가상 IP 주소를 모니터링하고 이동하는 데 사용되는 vrrp 패킷을 허용합니다. </td>
   </tr>
  </tbody>
</table>


### 네트워크 정책 추가
{: #adding_network_policies}

대부분의 경우, 기본 정책은 변경할 필요가 없습니다. 고급 시나리오에만 변경사항이 필요할 수 있습니다. 변경사항을 작성해야 하는 경우, Calico CLI를 설치하고 사용자 고유의 네트워크 정책을 작성하십시오.

시작하기 전에 다음 단계를 완료하십시오.

1.  [{{site.data.keyword.containershort_notm}} 및 Kubernetes CLI를 설치하십시오.](cs_cli_install.html#cs_cli_install)
2.  [라이트 또는 표준 클러스터를 작성하십시오.](cs_cluster.html#cs_cluster_ui)
3.  [Kubernetes CLI를 클러스터에 대상으로 지정하십시오](cs_cli_install.html#cs_cli_configure). 
`--admin` 옵션을 `bx cs cluster-config` 명령에 포함하십시오. 이는 인증서 및 권한 파일을 다운로드하는 데 사용됩니다.
이 다운로드에는 Calico 명령을 실행하는 데 필요한 관리자 rbac 역할에 대한 키도 포함됩니다. 

  ```
  bx cs cluster-config <cluster_name> 
  ```
  {: pre}


네트워크 정책을 추가하려면 다음을 수행하십시오. 
1.  Calico CLI를 설치하십시오. 
    1.  [Calico CLI 다운로드 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/projectcalico/calicoctl/releases/).

        **팁:** Windows를 사용하는 경우, {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 Calico CLI를 설치하십시오. 이 설정을 사용하면 나중에 명령을 실행할 때 일부 파일 경로 변경이 필요하지 않습니다. 

    2.  OSX 및 Linux 사용자의 경우, 다음 단계를 완료하십시오. 
        1.  실행 파일을 /usr/local/bin 디렉토리로 이동하십시오.
            -   Linux:


              ```
               mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS X:

              ```
              mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  바이너리 파일을 실행 파일로 변환하십시오. 

            ```
           chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Calico CLI 클라이언트 버전을 확인하여 `calico` 명령이 올바르게 실행되는지 확인하십시오. 

        ```
        calicoctl version
        ```
        {: pre}

2.  Calico CLI를 구성하십시오. 

    1.  Linux 및 OS X의 경우에는 '/etc/calico' 디렉토리를 작성하십시오. Windows의 경우에는 임의의 디렉토리가 사용될 수 있습니다. 

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  'calicoctl.cfg' 파일을 작성하십시오. 
        -   Linux 및 OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: 텍스트 편집기로 파일을 작성하십시오.

    3.  <code>calicoctl.cfg</code> 파일에 다음 정보를 입력하십시오. 

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

        1.  `<ETCD_URL>`을 검색하십시오.

          -   Linux 및 OS X:

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   출력 예:

              ```
               https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:<ol>
            <li>kube-system 네임스페이스에서 포드의 목록을 가져오고 Calico 제어기 포드를 찾으십시오. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>예:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>Calico 제어기 포드의 세부사항을 보십시오. </br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>ETCD 엔드포인트 값을 찾으십시오. 예: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Kubernetes 인증서가 다운로드되는 디렉토리인 `<CERTS_DIR>`을 검색하십시오. 

            -   Linux 및 OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                출력 예:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                출력 예:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **참고**: 디렉토리 경로를 가져오려면 출력의 끝에서 파일 이름 `kube-config-prod-<location>-<cluster_name>.yml`을 제거하십시오.

        3.  <code>ca-*pem_file<code>을 검색하십시오. 

            -   Linux 및 OS X:

              ```
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows:<ol><li>이전 단계에서 검색한 디렉토리를 여십시오. </br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
              <li> <code>ca-*pem_file</code> 파일을 찾으십시오. </ol>

        4.  Calico 구성이 올바르게 작동하고 있는지 확인하십시오. 

            -   Linux 및 OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              출력:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  기존 네트워크 정책을 조사하십시오. 

    -   Calico 호스트 엔드포인트를 보십시오. 

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   클러스터에 작성된 모든 Calico 및 Kubernetes 네트워크 정책을 보십시오. 이 목록에는 포드 또는 호스트에 아직 적용되지 않았을 수 있는 정책이 포함됩니다. 네트워크 정책이 적용되려면 Calico 네트워크 정책에 정의된 선택기와 일치하는 Kubernetes 리소스를 찾아야 합니다. 

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   네트워크 정책의 세부사항을 보십시오. 

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   클러스터에 대한 모든 네트워크 정책의 세부사항을 보십시오. 

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  트래픽을 허용하거나 차단하도록 Calico 네트워크 정책을 작성하십시오. 

    1.  구성 스크립트(.yaml)를 작성하여 [Calico 네트워크 정책![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy)을 정의하십시오. 이러한 구성 파일에는 이러한 정책이 적용되는 포드, 네임스페이스 또는 호스트를 설명하는 선택기가 포함됩니다. 사용자 공유 정책을 작성하려면 이러한 [샘플 Calico 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy)을 참조하십시오.

    2.  클러스터에 정책을 적용하십시오. 
        -   Linux 및 OS X:

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}


## 이미지
{: #cs_security_deployment}

기본 제공 보안 기능으로 이미지의 보안과 무결성을 관리합니다.
{: shortdesc}

### {{site.data.keyword.registryshort_notm}}의 보안 Docker 개인용 이미지 저장소:

 Docker 이미지를 빌드하고 안전하게 저장하며 이를 클러스터 사용자 간에 공유할 수 있도록 IBM이 호스팅하고 관리하는 멀티 테넌트, 고가용성 및 확장 가능한 개인용 이미지 레지스트리의 사용자 고유의 Docker 이미지 저장소를 설정할 수 있습니다. 

### 이미지 보안 준수:

{{site.data.keyword.registryshort_notm}}를 사용하는 경우에는 Vulnerability Advisor에서 제공하는 기본 제공 보안 스캐닝을 활용할 수 있습니다. 네임스페이스에 푸시되는 모든 이미지는 알려진 CentOS, Debian, Red Hat 및 Ubuntu 문제의 데이터베이스에 대한 취약점이 자동으로 스캔됩니다. 취약점이 발견되는 경우, Vulnerability Advisor는 이미지 무결성과 보안을 보장하기 위해 이를 해결하는 방법에 대한 지시사항을 제공합니다. 

이미지에 대한 취약성 평가를 보려면 다음을 수행하십시오. 

1.  **카탈로그**에서 **컨테이너**를 선택하십시오.
2.  취약성 평가를 보고자 하는 이미지를 선택하십시오. 
3.  **취약성 평가** 섹션에서 **보고서 보기**를 클릭하십시오. 
