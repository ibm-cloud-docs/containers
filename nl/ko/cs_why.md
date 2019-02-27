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



# {{site.data.keyword.containerlong_notm}}를 선택해야 하는 이유
{: #cs_ov}

{{site.data.keyword.containerlong}}는 Docker 컨테이너, Kubernetes 기술, 직관적인 사용자 경험, 기본 제공 보안 및 격리를 결합하여 강력한 도구를 제공함으로써 컴퓨팅 호스트의 클러스터에서 컨테이너화된 앱의 배치, 오퍼레이션, 스케일링 및 모니터링을 자동화합니다. 인증 정보는 다음을 참조하십시오. [Compliance on the {{site.data.keyword.Bluemix_notm}} ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/compliance).
{:shortdesc}


## 서비스 사용의 이점
{: #benefits}

클러스터는 기본 Kubernetes 및 {{site.data.keyword.IBM_notm}} 특정 기능을 제공하는 컴퓨팅 호스트에 배치됩니다.
{:shortdesc}

|이점|설명|
|-------|-----------|
|컴퓨팅, 네트워크 및 스토리지 인프라가 격리된 싱글 테넌트 Kubernetes 클러스터|<ul><li>조직의 요구사항을 충족하는 고유의 사용자 정의된 인프라를 작성합니다.</li><li>IBM Cloud 인프라(SoftLayer)에서 제공하는 리소스를 사용하여 데디케이티드 및 보안 Kubernetes 마스터, 작업자 노드, 가상 네트워크 및 스토리지를 프로비저닝합니다.</li><li>클러스터를 사용 가능한 상태로 유지하도록 {{site.data.keyword.IBM_notm}}에서 지속적으로 모니터하고 업데이트하는 완전히 관리되는 Kubernetes 마스터.</li><li>신뢰할 수 있는 컴퓨팅을 사용하여 베어메탈 서버로 작업자 노드를 프로비저닝하는 옵션.</li><li>지속적 데이터를 저장하고, Kubernetes 팟(Pod) 간에 데이터를 공유하며, 통합 및 보안 볼륨 서비스에서 필요 시에 데이터를 복원합니다.</li><li>모든 기본 Kubernetes API에 대한 전체 지원의 이점.</li></ul>|
|고가용성을 높이기 위한 다중 구역 클러스터 | <ul><li>작업자 풀에서 동일한 머신 유형(CPU, 메모리, 가상 또는 실제)의 작업자 노드를 손쉽게 관리합니다.</li><li>선택된 다중 구역 간에 노드를 균등하게 전개하고 앱에 대해 반친화성 및 팟(Pod) 배치를 사용하여 구역 장애가 발생하지 않도록 경계합니다.</li><li>개별 클러스터에서 리소스를 복제하는 대신 다중 구역 클러스터를 사용하여 비용을 절감합니다.</li><li>클러스터의 각 구역에서 사용자를 위해 자동으로 설정되는 다중 구역 로드 밸런서(MZLB)를 사용한 앱 간의 자동 로드 밸런싱으로부터 이익을 얻습니다.</li></ul>|
| 고가용성 마스터 | <ul>Kubernetes 버전 1.10 이상을 실행하는 클러스터에서 사용 가능합니다.<li>클러스터 가동 중단 시간을 줄입니다(예: 클러스터 작성 시에 자동으로 프로비저닝된 고가용성 마스터의 마스터 업데이트 중에).</li><li>구역 장애로부터 클러스터를 보호하기 위해 [다중 구역 클러스터](cs_clusters_planning.html#multizone)의 구역 간에 마스터를 전개합니다.</li></ul> |
|Vulnerability Advisor에서 이미지 보안 준수|<ul><li>이미지가 저장되고 조직의 모든 사용자에 의해 공유되는 보안 Docker 개인용 이미지 레지스트리의 자체 저장소를 설정합니다.</li><li>개인용 {{site.data.keyword.Bluemix_notm}} 레지스트리에서 이미지를 자동 스캔하는 이점.</li><li>잠재적 취약점을 해결하기 위해 이미지에서 사용된 운영 체제에 특정한 권장사항을 검토합니다.</li></ul>|
|클러스터 상태의 지속적 모니터링|<ul><li>클러스터 대시보드를 사용하여 클러스터, 작업자 노드 및 컨테이너 배치의 상태를 빠르게 보고 관리합니다.</li><li>{{site.data.keyword.monitoringlong}}를 사용하여 세부 이용 메트릭을 찾아서 작업 로드를 충족하도록 클러스터를 신속하게 확장합니다.</li><li>{{site.data.keyword.loganalysislong}}를 사용하여 로깅 정보를 검토하고 자세한 클러스터 활동을 확인하십시오.</li></ul>|
|공용으로 앱을 안전하게 노출|<ul><li>인터넷에서 클러스터의 서비스에 액세스하기 위해 공인 IP 주소, {{site.data.keyword.IBM_notm}} 제공 라우트 또는 자체 사용자 정의 도메인 간에 선택합니다.</li></ul>|
|{{site.data.keyword.Bluemix_notm}} 서비스 통합|<ul><li>Watson API, Blockchain, 데이터 서비스 또는 Internet of Things와 같은 {{site.data.keyword.Bluemix_notm}} 서비스의 통합을 통해 앱에 부가 기능을 추가합니다.</li></ul>|
{: caption="{{site.data.keyword.containerlong_notm}}의 이점" caption-side="top"}

시작할 준비가 되셨습니까? [Kubernetes 클러스터 작성 튜토리얼](cs_tutorials.html#cs_cluster_tutorial)을 이용해 보십시오.

<br />


## 오퍼링 및 오퍼링 조합의 비교
{: #differentiation}

{{site.data.keyword.containerlong_notm}}는 {{site.data.keyword.Bluemix_notm}} 퍼블릭 또는 데디케이티드, {{site.data.keyword.Bluemix_notm}} Private, 또는 하이브리드 설정에서 실행할 수 있습니다.
{:shortdesc}


<table>
<caption>{{site.data.keyword.containerlong_notm}} 설정 간의 차이점</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>{{site.data.keyword.containerlong_notm}} 설정</th>
 <th>설명</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} 퍼블릭
 </td>
 <td>[공유 하드웨어, 전용 하드웨어 또는 베어메탈 머신](cs_clusters_planning.html#shared_dedicated_node)의 {{site.data.keyword.Bluemix_notm}} 퍼블릭을 사용하면 {{site.data.keyword.containerlong_notm}}를 사용하여 클러스터 내의 앱을 클라우드에서 호스팅할 수 있습니다. 다중 구역의 작업자 풀에서 클러스터를 작성하여 앱에 대한 고가용성을 높일 수도 있습니다. {{site.data.keyword.Bluemix_notm}} 퍼블릭의 {{site.data.keyword.containerlong_notm}}는 Docker 컨테이너, Kubernetes 기술, 직관적인 사용자 경험, 기본 제공 보안 및 격리를 결합하여 컴퓨팅 호스트의 클러스터에서 컨테이너화된 앱의 배치, 오퍼레이션, 스케일링 및 모니터링을 자동화하는 강력한 도구를 제공합니다.<br><br>자세한 정보는 [{{site.data.keyword.containerlong_notm}} 기술](cs_tech.html)을 참조하십시오.
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} 데디케이티드
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} 데디케이티드는 {{site.data.keyword.Bluemix_notm}} 퍼블릭과 동일한 클라우드 상의 {{site.data.keyword.containerlong_notm}} 기능을 제공합니다. 그러나 {{site.data.keyword.Bluemix_notm}} 데디케이티드 계정을 사용하면 사용 가능한 [실제 리소스가 사용자 클러스터 전용이 되며](cs_clusters_planning.html#shared_dedicated_node) 다른 {{site.data.keyword.IBM_notm}} 고객의 클러스터와 공유되지 않습니다. 사용하는 클러스터 및 다른 {{site.data.keyword.Bluemix_notm}} 서비스를 격리시켜야 하는 경우에는 {{site.data.keyword.Bluemix_notm}} 데디케이티드 환경을 설정하도록 선택할 수 있습니다.<br><br>자세한 정보는 [{{site.data.keyword.Bluemix_notm}} 데디케이티드에서 클러스터 시작하기](cs_dedicated.html#dedicated)를 참조하십시오.
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private은 사용자가 자신의 머신에 로컬로 설치할 수 있는 애플리케이션 플랫폼입니다. 컨테이너화된 온프레미스 앱을 방화벽으로 보호되는 사용자의 고유한 제어 환경에서 개발하고 관리해야 하는 경우에는 Kubernetes를 {{site.data.keyword.Bluemix_notm}} Private에서 사용하도록 선택할 수 있습니다. <br><br>자세한 정보는 [{{site.data.keyword.Bluemix_notm}} Private 제품 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)를 참조하십시오.
 </td>
 </tr>
 <tr>
 <td>하이브리드 설정
 </td>
 <td>하이브리드는 {{site.data.keyword.Bluemix_notm}} 퍼블릭 또는 데디케이티드에서 실행되는 서비스와 {{site.data.keyword.Bluemix_notm}} Private의 앱과 같은 온프레미스에서 실행되는 기타 서비스를 결합하여 사용합니다. 하이브리드 설정의 예는 다음과 같습니다. <ul><li>{{site.data.keyword.Bluemix_notm}} 퍼블릭의 {{site.data.keyword.containerlong_notm}}에서 클러스터를 프로비저닝하지만, 해당 클러스터를 온프레미스 데이터베이스에 연결합니다.</li><li>{{site.data.keyword.Bluemix_notm}} Private의 {{site.data.keyword.containerlong_notm}}에서 클러스터를 프로비저닝하고 해당 클러스터에 앱을 배치합니다. 그러나 이 앱이 {{site.data.keyword.toneanalyzershort}}와 같은 {{site.data.keyword.ibmwatson}} 서비스를 {{site.data.keyword.Bluemix_notm}} 퍼블릭에서 사용할 수 있습니다.</li></ul><br>{{site.data.keyword.Bluemix_notm}} 퍼블릭 또는 데디케이티드에서 실행 중인 서비스와 온프레미스에서 실행 중인 서비스가 서로 통신할 수 있게 하려면 [VPN 연결을 설정](cs_vpn.html)해야 합니다. 자세한 정보는 [{{site.data.keyword.Bluemix_notm}} Private에서 {{site.data.keyword.containerlong_notm}} 사용](cs_hybrid.html)을 참조하십시오.
 </td>
 </tr>
 </tbody>
</table>

<br />


## 무료 및 표준 클러스터 비교
{: #cluster_types}

하나의 무료 클러스터와 임의의 수의 표준 클러스터를 작성할 수 있습니다. 무료 클러스터를 사용해 봄으로써 일부 Kubernetes 기능에 친숙해지거나 표준 클러스터를 작성함으로써 Kubernetes의 전체 기능을 사용하여 앱을 배치할 수 있습니다. 무료 클러스터는 30일 후에 자동으로 삭제됩니다.
{:shortdesc}

무료 클러스터를 보유 중이며 표준 클러스터로 업그레이드하려는 경우에는 [표준 클러스터](cs_clusters.html#clusters_ui)를 작성할 수 있습니다. 그리고 무료 클러스터에서 작성한 Kubernetes 리소스에 대한 YAML을 표준 클러스터에 배치하십시오.

|특성|무료 클러스터|표준 클러스터|
|---------------|-------------|-----------------|
|[클러스터 내부 네트워킹](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[불안정한 IP 주소에 대한 NodePort 서비스의 공용 네트워크 앱 액세스](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[사용자 액세스 관리](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[클러스터 및 앱에서 {{site.data.keyword.Bluemix_notm}} 서비스 액세스](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[비지속적 스토리지에 대한 작업자 노드의 디스크 공간](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[모든 {{site.data.keyword.containerlong_notm}} 지역에서 클러스터를 작성할 수 있는 기능](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" /> |
|[앱 고가용성을 높이기 위한 다중 구역 클러스터](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
| 고가용성을 위해 복제된 마스터(Kubernetes 1.10 이상) | | <img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" /> |
|[용량 증가를 위한 스케일링 가능한 작업자 노드 수](cs_app.html#app_scaling)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[볼륨이 있는 지속적 NFS 파일 기반 스토리지](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[로드 밸런서 서비스에 의한 안정적인 IP 주소에 대한 공용 또는 사설 네트워크 앱 액세스](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[Ingress 서비스에 의한 안정적인 IP 주소 및 사용자 정의할 수 있는 URL에 대한 공용 네트워크 앱 액세스](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[포터블 공인 IP 주소](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[로깅 및 모니터링](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[실제(베어메탈) 서버에 작업자 노드를 프로비저닝하는 옵션](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[신뢰할 수 있는 컴퓨팅을 사용하여 베어메탈 작업자를 프로비저닝하는 옵션](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[{{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)에서 사용 가능| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
{: caption="무료 및 표준 클러스터의 특성" caption-side="top"}

<br />




## 가격 및 비용 청구
{: #pricing}

{{site.data.keyword.containerlong_notm}} 가격 및 비용 청구에 대한 몇 가지 자주 질문되는 내용(FAQ)을 검토하십시오. 계정 레벨 질문에 대해서는 [비용 청구 및 사용량 관리 문서](/docs/billing-usage/how_charged.html#charges)를 참조하십시오. 계정 계약에 대한 세부사항은 해당 [{{site.data.keyword.Bluemix_notm}} 이용 약관 및 알림](/docs/overview/terms-of-use/notices.html#terms)을 참조하십시오.
{: shortdesc}

### 내 사용량을 보고 관리하는 방법은 무엇입니까?
{: #usage}

**내 비용 청구 및 사용량을 확인하는 방법은 무엇입니까?**<br>
사용량 및 예상 총액을 확인하려면 [사용량 보기](/docs/billing-usage/viewing_usage.html#viewingusage)를 참고하십시오.

{{site.data.keyword.Bluemix_notm}} 및 IBM Cloud 인프라(SoftLayer) 계정을 서로 연결하면 통합된 청구서를 수신합니다. 자세한 정보는 [연결된 계정에 대한 통합 비용 청구](/docs/customer-portal/linking_accounts.html#unifybillaccounts)를 참조하십시오.

**비용 청구 목적을 위해 내 클라우드 리소스를 팀 또는 부서별로 그룹화할 수 있습니까?**<br>
비용 청구를 정리하기 위해 [리소스 그룹을 사용](/docs/resources/bestpractice_rgs.html#bp_resourcegroups)하여 클러스터를 포함한 {{site.data.keyword.Bluemix_notm}} 리소스를 그룹으로 정리할 수 있습니다.

### 청구 방식은 무엇입니까? 비용은 시간별이나 월별 중 어느 쪽으로 계산됩니까?
{: #monthly-charges}

비용은 사용하는 리소스 유형에 따라 달라지며 고정되거나, 사용량이 측정되거나, 계층별로 구분되거나, 예약될 수 있습니다. 자세한 정보는 [청구 방식](/docs/billing-usage/how_charged.html#charges)을 보십시오.

IBM Cloud 인프라(SoftLayer) 리소스는 {{site.data.keyword.containerlong_notm}}에서 시간별 또는 월별로 비용 청구될 수 있습니다.
* 가상 머신(VM) 작업자 노드는 시간별로 비용 청구됩니다.
* 실제(베어메탈) 작업자 노드는 {{site.data.keyword.containerlong_notm}}에서 월별로 비용 청구됩니다.
* 기타 인프라 리소스(파일 또는 블록 스토리지 등)의 경우에는 리소스를 작성할 때 시간별 또는 월별 비용 청구 중 하나를 선택할 수 있습니다.

월별 리소스는 해당 월의 1일에 이전 월의 사용량에 대해 비용이 청구됩니다. 특정 월의 중간에 월별 리소스를 주문하는 경우에는 해당 월에 대해 비례 계산된 금액이 청구됩니다. 그러나 월 중간에 리소스를 취소하는 경우에는 여전히 해당 월별 리소스에 대한 전체 금액이 청구됩니다.

### 내 비용을 예상해 볼 수 있습니까?
{: #estimate}

예, [비용 예상](/docs/billing-usage/estimating_costs.html#cost) 및 [비용 계산기 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/pricing/) 도구를 참조하십시오. 아웃바운드 네트워킹과 같이 비용 계산기에 포함되지 않은 비용에 대한 정보를 계속해서 읽으십시오.

### {{site.data.keyword.containerlong_notm}}를 사용할 때 비용이 청구되는 항목에는 무엇이 있습니까?
{: #cluster-charges}

{{site.data.keyword.containerlong_notm}} 클러스터를 사용하면 IBM Cloud 인프라(SoftLayer) 컴퓨팅, 네트워킹 및 스토리지 리소스를 Watson AI 또는 Compose DBaaS(Database-as-a-Service)와 같은 플랫폼 서비스와 함께 사용할 수 있습니다. 각 리소스는 해당 비용을 수반할 수 있습니다.
* [작업자 노드](#nodes)
* [아웃바운드 네트워킹](#bandwidth)
* [서브넷 IP 주소](#subnets)
* [스토리지](#storage)
* [{{site.data.keyword.Bluemix_notm}} 서비스](#services)

<dl>
<dt id="nodes">작업자 노드</dt>
  <dd><p>클러스터에는 가상 머신 또는 실제(베어메탈) 머신의 두 가지 주요 작업자 노드 유형이 있을 수 있습니다. 머신 유형 가용성 및 가격은 클러스터를 배치하는 구역에 따라 달라집니다.</p>
  <p><strong>가상 머신</strong>은 더 비용 효율적인 가격으로 베어메탈보다 더 뛰어난 유연성, 빠른 프로비저닝 시간 및 자동 확장성 기능을 제공합니다. 그러나 네트워킹 Gbps, RAM 및 메모리 임계값, 스토리지 옵션에서는 베어메탈 스펙과 비교했을 때 성능이 더 떨어집니다. 다음 요소는 VM 비용에 영향을 준다는 점을 참고하십시오.</p>
  <ul><li><strong>공유 대 전용</strong>: VM의 기반 하드웨어를 공유하는 경우에는 전용 하드웨어보다 비용이 낮아지지만 실제 리소스가 사용자의 VM 전용으로 사용되지 않습니다.</li>
  <li><strong>시간별 비용 청구 전용</strong>: 시간별 비용 청구는 VM을 주문하고 취소하는 데 있어서 더 큰 유연성을 제공합니다.
  <li><strong>월별 계층식 시간</strong>: 시간별 비용 청구가 계층식으로 이뤄집니다. 비용 청구 월 내에 VM의 사용 시간이 주문된 계층의 사용 시간을 초과하지 않으면 청구되는 시간별 요금이 줄어듭니다. 사용 시간 계층은 다음과 같습니다: 0 - 150시간, 151 - 290시간, 291 - 540시간, 541시간 이상.</li></ul>
  <p><strong>실제 머신(베어메탈)</strong>은 데이터, AI 및 GPU와 같은 워크로드에 대해 높은 성능상 이점을 제공합니다. 또한 모든 하드웨어 리소스가 사용자의 워크로드 전용으로 사용되어 "사용량이 많은 다른 항목"으로 인한 문제가 발생하지 않습니다. 다음 요소는 베어메탈 비용에 영향을 준다는 점을 참고하십시오.</p>
  <ul><li><strong>월별 비용 청구 전용</strong>: 모든 베어메탈은 월별로 청구됩니다.</li>
  <li><strong>더 긴 주문 프로세스</strong>: 베어메탈 서버의 주문 및 취소는 IBM Cloud 인프라(SoftLayer) 계정을 통한 수동 프로세스이므로 이는 완료하는 데 1영업일보다 오랜 시간이 소요될 수 있습니다.</li></ul>
  <p>머신 스펙에 대한 세부사항은 [작업자 노드에 대해 사용 가능한 하드웨어](/docs/containers/cs_clusters_planning.html#shared_dedicated_node)를 참조하십시오.</p></dd>

<dt id="bandwidth">공용 대역폭</dt>
  <dd><p>대역폭은 {{site.data.keyword.Bluemix_notm}} 리소스와 전 세계에 있는 데이터 센터에서의, 인바운드 및 아웃바운드 네트워크 트래픽의 공용 데이터 전송을 가리킵니다. 공용 대역폭은 GB당 비용 청구됩니다. [{{site.data.keyword.Bluemix_notm}} 콘솔](https://console.bluemix.net/)에 로그인하여 메뉴 ![메뉴 아이콘](../icons/icon_hamburger.svg "메뉴 아이콘")에서 **인프라**를 선택한 후에 **네트워크 > 대역폭 > 요약** 페이지를 선택하여 현재 대역폭 요약을 검토할 수 있습니다.
  <p>공용 대역폭 비용에 영향을 주는 다음 요소를 검토하십시오.</p>
  <ul><li><strong>위치</strong>: 작업자 노드와 마찬가지로, 비용은 리소스가 배치되는 구역에 따라 달라집니다.</li>
  <li><strong>대역폭 포함 또는 종량과금제</strong>: 작업자 노드 머신은 VM에 대해 250GB, 베어메탈에 대해 500GB와 같이 특정한 월별 아웃바운드 네트워킹 할당량과 함께 제공될 수 있습니다. 또는 이 할당이 GB 사용량에 따라 종량과금제가 될 수도 있습니다.</li>
  <li><strong>계층식 패키지</strong>: 포함된 대역폭을 초과하면 위치별로 다른 계층식 사용량 체계에 따라 비용이 청구됩니다. 계층 할당량을 초과하면 표준 데이터 전송 요금 또한 청구될 수 있습니다.</li></ul>
  <p>자세한 정보는 [Bandwidth packages ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/bandwidth)를 참조하십시오.</p></dd>

<dt id="subnets">서브넷 IP 주소</dt>
  <dd><p>표준 클러스터를 작성하면 8개의 공인 IP 주소를 포함하는 이동 가능한 공용 서브넷이 사용자의 계정으로 주문되어 매월 비용 청구됩니다.</p><p>인프라 계정에 이미 사용 가능한 서브넷이 있는 경우에는 이러한 서브넷을 대신 사용할 수 있습니다. `--no-subnets` [플래그](cs_cli_reference.html#cs_cluster_create)를 사용하여 클러스터를 작성한 후 [서브넷을 재사용](cs_subnets.html#custom)하십시오.</p>
  </dd>

<dt id="storage">스토리지</dt>
  <dd>스토리지를 프로비저닝할 때는 자신의 유스 케이스에 적합한 스토리지 유형 및 스토리지 클래스를 선택할 수 있습니다. 비용은 스토리지 유형, 위치, 스토리지 인스턴스의 스펙에 따라 달라집니다. 적절한 스토리지 솔루션을 선택하려면 [고가용성 지속적 스토리지 계획](cs_storage_planning.html#storage_planning)을 참조하십시오. 자세한 정보는 다음을 참조하십시오.
  <ul><li>[NFS 파일 스토리지 가격 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[블록 스토리지 가격 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Object Storage 플랜 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} 서비스</dt>
  <dd>사용자가 클러스터와 통합하는 각 서비스에는 해당 가격 모델이 있습니다. 자세한 정보는 각 제품 문서 및 [비용 계산기 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/pricing/)를 참조하십시오.</dd>

</dl>
