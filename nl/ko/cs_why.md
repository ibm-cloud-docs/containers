---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}}를 선택해야 하는 이유
{: #cs_ov}

{{site.data.keyword.containershort}}는 Docker와 Kubernetes 기술을 결합한 강력한 도구, 직관적인 사용자 경험, 기본 제공 보안 및 격리를 제공하여 컴퓨팅 호스트의 클러스터에서 컨테이너화된 앱의 배치, 오퍼레이션, 스케일링 및 모니터링을 자동화합니다.
{:shortdesc}

## 클러스터 사용의 이점
{: #benefits}

클러스터는 기본 Kubernetes 및 {{site.data.keyword.IBM_notm}} 추가 기능을 제공하는 컴퓨팅 호스트에 배치됩니다.
{:shortdesc}

|이점|설명|
|-------|-----------|
|컴퓨팅, 네트워크 및 스토리지 인프라가 격리된 단일 테넌트 Kubernetes 클러스터|<ul><li>조직의 요구사항을 충족하는 고유의 사용자 정의된 인프라를 작성하십시오.</li><li>IBM Cloud 인프라(SoftLayer)에서 제공하는 리소스를 사용하여 데디케이티드 및 보안 Kubernetes 마스터, 작업자 노드, 가상 네트워크 및 스토리지를 프로비저닝합니다.</li><li>지속적 데이터를 저장하고, Kubernetes 포드 간에 데이터를 공유하며, 통합 및 보안 볼륨 서비스에서 필요 시에 데이터를 복원합니다.</li><li>클러스터를 사용 가능한 상태로 유지하도록 {{site.data.keyword.IBM_notm}}에서 지속적으로 모니터하고 업데이트하는 완전히 관리되는 Kubernetes 마스터.</li><li>모든 기본 Kubernetes API에 대한 전체 지원의 이점.</li></ul>|
|Vulnerability Advisor에서 이미지 보안 준수|<ul><li>이미지가 저장되고 조직의 모든 사용자에 의해 공유되는 자체 보안 Docker 개인용 이미지 레지스트리를 설정합니다.</li><li>개인용 {{site.data.keyword.Bluemix_notm}} 레지스트리에서 이미지를 자동 스캔하는 이점.</li><li>잠재적 취약점을 해결하기 위해 이미지에서 사용된 운영 체제에 특정한 권장사항을 검토합니다.</li></ul>|
|앱의 자동 스케일링|<ul><li>CPU 및 메모리 이용률을 기반으로 앱을 확장하고 축소하는 사용자 정의 정책을 정의합니다.</li></ul>|
|클러스터 상태의 지속적 모니터링|<ul><li>클러스터 대시보드를 사용하여 클러스터, 작업자 노드 및 컨테이너 배치의 상태를 빠르게 보고 관리합니다.</li><li>{{site.data.keyword.monitoringlong}}를 사용하여 세부 이용 메트릭을 찾아서 작업 로드를 충족하도록 클러스터를 신속하게 확장합니다.</li><li>{{site.data.keyword.loganalysislong}}를 사용하여 로깅 정보를 검토하고 자세한 클러스터 활동을 확인하십시오.</li></ul>|
|비정상 컨테이너의 자동 복구|<ul><li>작업자 노드에 배치된 컨테이너에 대한 지속성 상태 검사.</li><li>장애 발생 시에 컨테이너의 자동 재작성.</li></ul>|
|서비스 검색 및 서비스 관리|<ul><li>공용으로 노출하지 않고 클러스터의 기타 앱이 사용할 수 있도록 앱 서비스를 중앙 집중식으로 등록합니다.</li><li>IP 주소 또는 컨테이너 ID의 변경을 추적하지 않고 등록된 서비스를 검색하며, 사용 가능한 인스턴스로 자동 라우팅하는 이점을 활용합니다.</li></ul>|
|공용으로 서비스를 안전하게 노출|<ul><li>클러스터 내의 IP 주소 변경을 추적함이 없이 앱을 공용으로 사용하고 다중 작업자 노드 간의 워크로드 밸런싱을 수행할 수 있도록 전체 로드 밸런서와 Ingress 지원이 제공되는 사설 오버레이 네트워크.</li><li>인터넷에서 클러스터의 서비스에 액세스하기 위해 공인 IP 주소, {{site.data.keyword.IBM_notm}} 제공 라우트 또는 자체 사용자 정의 도메인 간에 선택합니다.</li></ul>|
|{{site.data.keyword.Bluemix_notm}} 서비스 통합|<ul><li>Watson API, 블록체인, 데이터 서비스 또는 Internet of Things와 같은 {{site.data.keyword.Bluemix_notm}} 서비스의 통합을 통해 앱에 부가 기능을 추가하고, 클러스터 사용자가 앱 개발과 컨테이너 관리 프로세스를 단순화할 수 있도록 도움을 줍니다.</li></ul>|

<br />


## 라이트 및 표준 클러스터 비교
{: #cluster_types}

라이트 또는 표준 클러스터를 작성할 수 있습니다. 몇몇 Kubernetes 기능을 익히고 테스트하려면 라이트 클러스터를 작성하고, 전체 Kubernetes 기능을 사용하여 앱을 배치하려면 표준 클러스터를 작성하십시오.
{:shortdesc}

|특성|라이트 클러스터|표준 클러스터|
|---------------|-------------|-----------------|
|[{{site.data.keyword.Bluemix_notm}}에서 사용 가능](cs_why.html)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[클러스터 내부 네트워킹](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[NodePort 서비스에 의한 공용 네트워크 앱 액세스](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[사용자 액세스 관리](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[클러스터와 앱에서 {{site.data.keyword.Bluemix_notm}} 서비스 액세스](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[스토리지를 위한 작업자 노드의 디스크 공간](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[볼륨이 있는 지속적 NFS 파일 기반 스토리지](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[로드 밸런서 서비스에 의한 공용 또는 사설 네트워크 앱 액세스](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[Ingress 서비스에 의한 공용 네트워크 앱 액세스](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[포터블 공인 IP 주소](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[로깅 및 모니터링](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|
|[{{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)에서 사용 가능| |<img src="images/confirm.svg" width="32" alt="사용 가능한 기능" style="width:32px;" />|

<br />



## 클러스터 관리 책임
{: #responsibilities}

클러스터를 관리하기 위해 IBM과 공유하는 책임을 검토하십시오.
{:shortdesc}

**IBM은 다음을 담당합니다.**

- 클러스터 작성 시 마스터, 작업자 노드 및 클러스터 내의 관리 컴포넌트(예: Ingress 제어기) 배치
- 클러스터에 대한 Kubernetes 마스터의 업데이트, 모니터링 및 복구 관리
- 작업자 노드의 상태를 모니터하고 해당 작업자 노드의 업데이트 및 복구 자동화 제공
- 작업자 노드 추가, 작업자 노드 제거 및 기본 서브넷 작성을 포함하여 인프라 계정에 대한 자동화 태스크 수행
- 클러스터 내의 운영 컴포넌트(예: Ingress 제어기 및 스토리지 플러그인) 관리, 업데이트 및 복구
- 지속적 볼륨 클레임에서 요청될 때 스토리지 볼륨 프로비저닝
- 모든 작업자 노드에 대한 보안 설정 제공

</br>
**사용자는 다음을 담당합니다.**

- [클러스터 내의 Kubernetes 리소스(예: 포드, 서비스 및 배치) 배치 및 관리](cs_app.html#app_cli)
- [서비스 및 Kubernetes의 기능을 활용하여 앱의 고가용성 보장](cs_app.html#highly_available_apps)
- [CLI를 통해 작업자 노드를 추가하거나 제거하여 기능 추가 또는 제거](cs_cli_reference.html#cs_worker_add)
- [ 클러스터의 네트워크 격리를 위해 IBM Cloud 인프라(SoftLayer)에서 퍼블릭 및 프라이빗 VLAN 작성](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [모든 작업자 노드에서 Kubernetes 마스터 URL에 네트워크로 연결할 수 있는지 확인](cs_firewall.html#firewall) <p>**참고**: 작업자 노드에 퍼블릭 및 프라이빗 VLAN이 모두 있는 경우 네트워크 연결이 구성됩니다. 작업자 노드에 프라이빗 VLAN만 설정되어 있는 경우 네트워크 연결을 제공하려면 Vyatta가 필요합니다.</p>
- [Kubernetes 주 또는 부 버전 업데이트가 사용 가능한 경우 마스터 kube-apiserver 및 작업자 노드 업데이트](cs_cluster_update.html#master)
- [`kubectl` 명령(예: `cordon` 또는 `drain`)을 실행하고 `bx cs` 명령(예: `reboot`, `reload` 또는 `delete`)을 실행하여 문제가 발생한 작업자 노드를 복구하기 위한 조치 수행](cs_cli_reference.html#cs_worker_reboot)
- [필요에 따라 IBM Cloud 인프라(SoftLayer)에서 더 많은 서브넷 추가 또는 제거](cs_subnets.html#subnets)
- [IBM Cloud 인프라(SoftLayer)의 지속적 스토리지에 데이터 백업 및 복원 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## 컨테이너의 오용
{: #terms}

클라이언트는 {{site.data.keyword.containershort_notm}}를 잘못 사용할 수 없습니다.
{:shortdesc}

오용에는 다음이 포함됩니다.

*   불법적 활동
*   맬웨어의 배포 또는 실행
*   {{site.data.keyword.containershort_notm}}에 손상을 주거나 사용자의 {{site.data.keyword.containershort_notm}} 사용을 방해함
*   기타 서비스 또는 시스템에 손상을 주거나 사용자의 사용을 방해함
*   서비스 또는 시스템에 대한 비인가된 액세스
*   서비스 또는 시스템의 비인가된 수정
*   기타 사용자의 권한 위반

전체 이용 약관은 [클라우드 서비스 이용 약관](/docs/navigation/notices.html#terms)을 참조하십시오.
