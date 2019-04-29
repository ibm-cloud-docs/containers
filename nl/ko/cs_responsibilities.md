---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

subcollection: containers

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



#  {{site.data.keyword.containerlong_notm}} 사용 시 사용자의 책임
{{site.data.keyword.containerlong}} 사용 시 지켜야 하는 클러스터 관리 책임 및 이용 약관에 대해 알아보십시오.
{:shortdesc}

## 클러스터 관리 책임
{: #responsibilities}

클러스터를 관리하기 위해 IBM과 공유하는 책임을 검토하십시오.
{:shortdesc}

**IBM은 다음을 담당합니다.**

- 클러스터 작성 시 마스터, 작업자 노드 및 클러스터 내의 관리 컴포넌트(예: Ingress 애플리케이션 로드 밸런서) 배치
- 클러스터의 Kubernetes 마스터에 대한 보안 업데이트, 모니터링, 격리 및 복구 제공
- 클러스터 작업자 노드에 적용할 수 있는 버전 업데이트 및 보안 패치 작성
- 작업자 노드의 상태를 모니터링하고 해당 작업자 노드의 업데이트 및 복구 자동화 제공
- 작업자 노드 추가, 작업자 노드 제거 및 기본 서브넷 작성을 포함하여 인프라 계정에 대한 자동화 태스크 수행
- 클러스터 내의 운영 컴포넌트(예: Ingress 애플리케이션 로드 밸런서 및 스토리지 플러그인) 관리, 업데이트 및 복구
- 지속적 볼륨 클레임에서 요청될 때 스토리지 볼륨 프로비저닝
- 모든 작업자 노드에 대한 보안 설정 제공

</br>

**사용자는 다음을 담당합니다.**

- [IBM Cloud 인프라(SoftLayer) 포트폴리오 및 기타 {{site.data.keyword.Bluemix_notm}} 서비스에 액세스할 수 있는 권한으로 {{site.data.keyword.containerlong_notm}} API 키 구성](/docs/containers?topic=containers-users#api_key)
- [클러스터 내의 Kubernetes 리소스(예: 팟(Pod), 서비스 및 배치) 배치 및 관리](/docs/containers?topic=containers-app#app_cli)
- [서비스 및 Kubernetes의 기능을 활용하여 앱의 고가용성 보장](/docs/containers?topic=containers-app#highly_available_apps)
- [작업자 풀의 크기를 조정하여 클러스터 용량 추가 또는 제거](/docs/containers?topic=containers-clusters#add_workers)
- [VLAN Spanning 사용 및 구역 간 다중 구역 작업자 풀의 밸런스 유지](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [ 클러스터의 네트워크 격리를 위해 IBM Cloud 인프라(SoftLayer)에서 공용 및 사설 VLAN 작성](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [모든 작업자 노드에서 Kubernetes 서비스 엔드포인트 URL에 네트워크로 연결할 수 있는지 확인](/docs/containers?topic=containers-firewall#firewall) <p class="note">작업자 노드에 공용 및 사설 VLAN이 둘 다 있으면 네트워크 연결이 구성됩니다. 작업자 노드가 사설 VLAN 전용으로 설정된 경우에는 [개인 서비스 엔드포인트를 사용으로 설정](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)하거나 [게이트웨이 디바이스를 구성](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)하여 작업자 노드와 클러스터 마스터가 통신할 수 있도록 해야 합니다. 방화벽을 설정하는 경우, 클러스터에서 사용하는 {{site.data.keyword.containerlong_notm}} 및 기타 {{site.data.keyword.Bluemix_notm}} 서비스에 대한 액세스를 허용하도록 해당 설정을 관리하고 구성해야 합니다.</p>
- [Kubernetes 버전 업데이트가 사용 가능한 경우 마스터 kube-apiserver 업데이트](/docs/containers?topic=containers-update#master)
- [작업자 노드를 주, 부 및 패치 버전에 대해 최신 상태로 유지](/docs/containers?topic=containers-update#worker_node) <p class="note">작업자 노드의 운영 체제를 변경하거나 작업자 노드에 로그인할 수 없습니다. 작업자 노드 업데이트는 IBM이 최신 보안 패치를 포함하는 전체 작업자 노드 이미지로 제공합니다. 업데이트를 적용하려면 새 이미지를 사용하여 작업자 노드를 다시 이미징하고 다시 로드해야 합니다. 루트 사용자의 키는 작업자 노드가 다시 로드되면 자동으로 순환됩니다. </p>
- [클러스터 컴포넌트에 대한 로그 전달을 설정하여 클러스터 상태 모니터링](/docs/containers?topic=containers-health#health).   
- [`kubectl` 명령(예: `cordon` 또는 `drain`) 및 `ibmcloud ks` 명령(예: `reboot`, `reload` 또는 `delete`)을 실행하여 문제가 발생한 작업자 노드 복구](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [필요에 따라 IBM Cloud 인프라(SoftLayer)에서 서브넷 추가 또는 제거](/docs/containers?topic=containers-subnets#subnets)
- [IBM Cloud 인프라(SoftLayer)의 지속적 스토리지에 데이터 백업 및 복원 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- 클러스터의 상태와 성능을 지원하기 위한 [로깅](/docs/containers?topic=containers-health#logging) 및 [모니터링](/docs/containers?topic=containers-health#view_metrics) 서비스 설정
- [자동 복구를 통해 작업자 노드의 상태 모니터링 구성](/docs/containers?topic=containers-health#autorecovery)
- [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events)의 사용을 통해 {{site.data.keyword.containerlong_notm}} 인스턴스의 상태를 변경하는 사용자 시작 활동을 보는 등 클러스터의 리소스를 변경하는 이벤트 감사

<br />


## {{site.data.keyword.containerlong_notm}}의 오용
{: #terms}

클라이언트는 {{site.data.keyword.containerlong_notm}}를 오용할 수 없습니다.
{:shortdesc}

오용에는 다음이 포함됩니다.

*   불법적 활동
*   맬웨어의 배포 또는 실행
*   {{site.data.keyword.containerlong_notm}}에 손상을 주거나 사용자의 {{site.data.keyword.containerlong_notm}} 사용을 방해함
*   기타 서비스 또는 시스템에 손상을 주거나 사용자의 사용을 방해함
*   서비스 또는 시스템에 대한 비인가된 액세스
*   서비스 또는 시스템의 비인가된 수정
*   기타 사용자의 권한 위반

전체 이용 약관은 [클라우드 서비스 이용 약관](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms)을 참조하십시오.
