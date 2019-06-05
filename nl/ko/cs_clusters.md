---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}


# 클러스터 및 작업자 노드 설정
{: #clusters}
클러스터를 작성하고 작업자 노드를 추가하여 {{site.data.keyword.containerlong}}에서 클러스터 용량을 늘릴 수 있습니다. 아직도 시작 단계입니까? [Kubernetes 클러스터 작성 튜토리얼](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial)을 이용해 보십시오.
{: shortdesc}

## 클러스터 작성 준비
{: #cluster_prepare}

{{site.data.keyword.containerlong_notm}}를 사용하면, 기본 제공되거나 구성 가능한 많은 추가 기능을 통해 앱을 위한 안전한 고가용성 환경을 작성할 수 있습니다. 클러스터에 대해 다양한 가능성이 있다는 것은 클러스터를 작성할 때 많은 의사결정을 내려야 한다는 의미이기도 합니다. 다음 단계는 계정, 권한, 리소스 그룹, VLAN Spanning, 구역 및 하드웨어에 대한 클러스터 설정, 비용 청구 정보를 설정할 때 고려해야 하는 항목을 간략히 설명합니다.
{: shortdesc}

이 목록은 두 부분으로 나뉘어 있습니다.
*  **계정 레벨**: 이 준비 항목들은 계정 관리자가 한 번 수행하고 나면 클러스터를 작성할 때마다 변경하지 않아도 되는 항목입니다. 그러나 클러스터를 작성할 때마다 현재 계정 레벨 상태가 원하는 상태인지 확인하는 것은 여전히 중요합니다.
*  **클러스터 레벨**: 이 준비 항목들은 클러스터를 작성할 때마다 클러스터에 영향을 주는 항목입니다.

### 계정 레벨
{: #prepare_account_level}

다음 단계에 따라 {{site.data.keyword.containerlong_notm}}에 대한 {{site.data.keyword.Bluemix_notm}} 계정을 준비하십시오.
{: shortdesc}

1.  [계정을 작성하거나 청구 가능 계정({{site.data.keyword.Bluemix_notm}} 종량과금제 또는 구독)으로 업그레이드](https://cloud.ibm.com/registration/)하십시오.
2.  클러스터를 작성할 지역에 [{{site.data.keyword.containerlong_notm}} API 키를 설정](/docs/containers?topic=containers-users#api_key)하십시오. 이 API 키에 클러스터를 작성할 수 있는 권한을 지정하십시오.
    *  IBM Cloud 인프라(SoftLayer)에 대한 **수퍼유저** 역할.
    *  계정 레벨에서 {{site.data.keyword.containerlong_notm}}에 대한 **관리자** 플랫폼 관리 역할.
    *  계정 레벨에서 {{site.data.keyword.registrylong_notm}}에 대한 **관리자** 플랫폼 관리 역할. 사용자 계정이 2018년 10월 4일 이전의 계정인 경우, [{{site.data.keyword.registryshort_notm}}에 대한 {{site.data.keyword.Bluemix_notm}} IAM 정책을 사용으로 설정](/docs/services/Registry?topic=registry-user#existing_users)하십시오. IAM 정책을 사용하면 레지스트리 네임스페이스와 같은 리소스에 대한 액세스를 제어할 수 있습니다.

    계정 소유자이십니까? 이 경우에는 이미 필요한 권한을 갖고 있습니다. 클러스터를 작성하면 지역 및 리소스 그룹에 대한 API 키가 사용자의 인증 정보를 사용하여 설정됩니다.
    {: tip}

3.  계정이 여러 리소스 그룹을 사용하는 경우에는 계정의 [리소스 그룹 관리](/docs/containers?topic=containers-users#resource_groups) 전략을 파악하십시오. 
    *  클러스터는 {{site.data.keyword.Bluemix_notm}}에 로그인할 때 대상으로 지정하는 리소스 그룹에 작성됩니다. 특정 리소스 그룹을 대상으로 지정하지 않으면 기본 리소스 그룹이 자동으로 대상으로 지정됩니다.
    *  기본이 아닌 리소스 그룹에 클러스터를 작성하려는 경우에는 해당 리소스 그룹에 대해 **Viewer** 이상의 역할을 갖고 있어야 합니다. 사용자에게 해당 리소스 그룹에 대한 역할이 전혀 없지만 사용자가 여전히 이 리소스 그룹 내에 있는 서비스의 **Administrator**인 경우에는 클러스터가 기본 리소스 그룹에 작성됩니다.
    *  클러스터의 리소스 그룹은 변경할 수 없습니다. 또한 `ibmcloud ks cluster-service-bind` [명령](/docs/containers-cli-plugin?topic=containers-cli-plugin-cs_cli_reference#cs_cluster_service_bind)을 사용하여 [{{site.data.keyword.Bluemix_notm}} 서비스와 통합](/docs/containers?topic=containers-service-binding#bind-services)해야 하는 경우 해당 서비스는 클러스터와 동일한 리소스 그룹에 있어야 합니다. 리소스 그룹(예: {{site.data.keyword.registrylong_notm}})을 사용하지 않거나 서비스 바인딩(예: {{site.data.keyword.la_full_notm}})이 필요하지 않은 서비스는 클러스터가 다른 리소스 그룹에 있는 경우에도 작동합니다. 
    *  [메트릭에 대해 {{site.data.keyword.monitoringlong_notm}}](/docs/containers?topic=containers-health#view_metrics)을 사용하려는 경우에는 메트릭 이름 충돌을 방지하기 위해 계정 내 모든 리소스 그룹 및 지역 전체에서 고유한 이름을 클러스터에 지정하도록 계획하십시오.

4.  IBM Cloud 인프라(SoftLayer) 네트워킹을 설정하십시오. 다음 옵션 중에서 선택할 수 있습니다.
    *  **VRF 사용**: VRF(virtual routing and forwarding)와 여러 해당 격리 분리 기술을 사용하면 공용 및 개인 서비스 엔드포인트를 사용하여 Kubernetes 버전 1.11 이상에서 실행되는 Kubernetes 마스터와 통신할 수 있습니다. [개인 서비스 엔드포인트](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)를 사용하면 Kubernetes 마스터와 작업자 노드 간의 통신이 사설 VLAN에서 유지됩니다. 클러스터에 대해 로컬 시스템에서 `kubectl` 명령을 실행하려는 경우 Kubernetes 마스터가 있는 동일한 사설 VLAN에 연결되어 있어야 합니다. 앱을 인터넷에 노출하려면 작업자 노드를 공용 VLAN에 연결해야 수신 네트워크 트래픽이 앱으로 전달될 수 있습니다. 인터넷을 통해 클러스터에 대해 `kubectl` 명령을 실행하기 위해 공용 서비스 엔드포인트를 사용할 수 있습니다. 공용 서비스 엔드포인트를 사용하면 네트워크 트래픽은 공용 VLAN을 통해 라우팅되며 OpenVPN 터널을 사용하여 보호됩니다. 개인 서비스 엔드포인트를 사용하려면 IBM Cloud 인프라(SoftLayer) 지원 케이스를 열어야 하는 VRF와 서비스 엔드포인트에 대한 계정을 사용으로 설정해야 합니다. 자세한 정보는 [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)에서 VRF 개요 및 [서비스 엔드포인트에 대한 사용자 계정 사용](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)을 참조하십시오.
    *  **비 VRF**: 계정ㅇ VRF를 사용하지 않으려고 하거나 사용할 수 없는 경우, 작업자 노드는 [공용 서비스 엔드포인트](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)를 통해 공용 네트워크를 거쳐 Kubernetes 마스터에 자동으로 연결할 수 있습니다. 이 통신을 보호하기 위해 {{site.data.keyword.containerlong_notm}}는 클러스터가 작성될 때 Kubernetes 마스터 및 작업자 노드 간의 OpenVPN 연결을 자동으로 설정합니다. 클러스터용 다중 VLAN, 동일한 VLAN의 다중 서브넷 또는 다중 구역 클러스터가 있는 경우에는 작업자 노드가 사설 네트워크에서 서로 간에 통신할 수 있도록 IBM Cloud 인프라(SoftLayer) 계정에 대해 [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)을 사용으로 설정해야 합니다. 이 조치를 수행하려면 **네트워크 > 네트워크 VLAN Spanning 관리** [인프라 권한](/docs/containers?topic=containers-users#infra_access)이 필요합니다. 또는 이를 사용으로 설정하도록 계정 소유자에게 요청할 수 있습니다. VLAN Spanning이 이미 사용으로 설정되었는지 확인하려면 `ibmcloud ks vlan-spanning-get` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)을 사용하십시오.

### 클러스터 레벨
{: #prepare_cluster_level}

다음 단계에 따라 클러스터 설정을 준비하십시오.
{: shortdesc}

1.  {{site.data.keyword.containerlong_notm}}에 대한 **Administrator** 플랫폼 역할이 있는지 확인하십시오. 클러스터가 사설 레지스트리에서 이미지를 가져올 수 있도록 하려면 {{site.data.keyword.registrylong_notm}}에 대한 **관리자** 플랫폼 역할도 필요합니다. 
    1.  [{{site.data.keyword.Bluemix_notm}} 콘솔 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/) 메뉴 표시줄에서 **관리 > 액세스(IAM)**를 클릭하십시오.
    2.  **사용자** 페이지를 클릭한 후, 테이블에서 자신을 선택하십시오.
    3.  **액세스 정책** 탭에서 자신의 **역할**이 **Administrator**인지 확인하십시오. 사용자는 계정 내 모든 리소스에 대한 **Administrator**이거나, 적어도 {{site.data.keyword.containershort_notm}}에 대해 이 역할일 수 있습니다. **참고**: 사용자가 전체 계정이 아니라 하나의 리소스 그룹 또는 지역에서만 {{site.data.keyword.containershort_notm}}에 대한 **Administrator** 역할을 갖고 있는 경우에는 계정의 VLAN을 보려면 계정 레벨에서 **Viewer** 이상의 역할을 갖고 있어야 합니다.
    <p class="tip">계정 관리자가 서비스 역할과 동시에 **관리자** 플랫폼 역할을 지정하지 않는지 확인하십시오. 플랫폼 및 서비스 역할을 별도로 지정해야 합니다.</p>
2.  [무료 또는 표준 클러스터](/docs/containers?topic=containers-cs_ov#cluster_types) 간에 결정하십시오. 1개의 무료 클러스터를 작성하여 30일 동안 일부 기능을 사용해 보거나, 선택한 하드웨어 격리로 완벽히 사용자 정의가 가능한 표준 클러스터를 작성할 수 있습니다. 더 많은 혜택을 받아 보고 클러스터 성능을 제어하고자 하려면 표준 클러스터를 작성하십시오.
3.  [클러스터 설정을 계획](/docs/containers?topic=containers-plan_clusters#plan_clusters)하십시오.
    *  [단일 구역](/docs/containers?topic=containers-plan_clusters#single_zone) 또는 [다중 구역](/docs/containers?topic=containers-plan_clusters#multizone) 클러스터 중 무엇을 작성할지 결정하십시오. 다중 구역 클러스터는 선택된 위치에서만 사용 가능하다는 점을 참고하십시오.
    *  공용으로 액세스할 수 없는 클러스터를 작성하려는 경우에는 추가 [사설 클러스터 단계](/docs/containers?topic=containers-plan_clusters#private_clusters)를 검토하십시오.
    *  가상 머신 또는 베어메탈 머신 중에서 선택하는 것을 포함, 클러스터의 작업자 노드에 대해 사용할 [하드웨어 및 격리](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node) 유형을 선택하십시오.
4.  표준 클러스터의 경우에는 {{site.data.keyword.Bluemix_notm}} 콘솔에서 [비용을 예측](/docs/billing-usage?topic=billing-usage-cost#cost)할 수 있습니다. 예측기에 포함되지 않을 수 있는 비용에 대한 자세한 정보는 [가격 및 비용 청구](/docs/containers?topic=containers-faqs#charges)를 참조하십시오.
5.  방화벽으로 보호되는 환경에 클러스터를 작성하는 경우 사용하려는 {{site.data.keyword.Bluemix_notm}} 서비스에 대해 [공인 및 사설 IP에 대한 아웃바운드 네트워크 트래픽을 허용](/docs/containers?topic=containers-firewall#firewall_outbound)하십시오.
<br>
<br>

**다음에 수행할 작업**
* [{{site.data.keyword.Bluemix_notm}} 콘솔을 사용하여 클러스터 작성](#clusters_ui)
* [{{site.data.keyword.Bluemix_notm}} CLI를 사용하여 클러스터 작성](#clusters_cli)

## {{site.data.keyword.Bluemix_notm}} 콘솔을 사용하여 클러스터 작성
{: #clusters_ui}

Kubernetes 클러스터의 용도는 앱의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 앱을 배치하려면 우선 클러스터를 작성하고 해당 클러스터에서 작업자 노드에 대한 정의를 설정해야 합니다.
{:shortdesc}

[마스터와 작업자 간의 통신](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)을 위해 [서비스 엔드포인트](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)를 사용하는 클러스터를 작성하시겠습니까? [CLI를 사용](#clusters_cli)하여 클러스터를 작성해야 합니다.
{: note}

### 무료 클러스터 작성
{: #clusters_ui_free}

1개의 무료 클러스터를 사용하여 {{site.data.keyword.containerlong_notm}}의 작동 방법에 친숙해질 수 있습니다. 무료 클러스터를 사용하면 전문 용어를 배우고 튜토리얼을 마치며 프로덕션 레벨 표준 클러스터로 도약하기 전에 방향감을 터득할 수 있습니다. 걱정 마십시오. 청구 가능 계정이 있어도 여전히 무료 클러스터를 받을 수 있습니다.
{: shortdesc}

무료 클러스터의 유효 기간은 30일입니다. 이 기간이 지나면 클러스터가 만료되며 클러스터와 해당 데이터가 삭제됩니다. 삭제된 데이터는 {{site.data.keyword.Bluemix_notm}}에 의해 백업되지 않으며 이를 복원할 수 없습니다. 중요한 데이터는 반드시 백업을 받으십시오.
{: note}

1. 올바른 {{site.data.keyword.Bluemix_notm}} 계정 설정과 사용자 권한이 있는지 확인하고 사용하고자 하는 리소스 그룹과 클러스터 설정을 결정할 수 있도록 [클러스터 작성을 준비](#cluster_prepare)하십시오.
2. [카탈로그 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/catalog?category=containers)에서 클러스터를 작성할 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
3. 클러스터를 배치할 지역을 선택하십시오. 클러스터가 이 지역 내의 구역에 작성됩니다. 
4. **무료** 클러스터 플랜을 선택하십시오.
5. 클러스터에 이름을 지정하십시오. 이름은 문자로 시작해야 하며 35자 이하의 문자, 숫자 및 하이픈(-)을 포함할 수 있습니다. 클러스터 이름과 클러스터가 배치된 지역이 Ingress 하위 도메인의 완전한 이름을 형성합니다. 특정 Ingress 하위 도메인이 지역 내에서 고유하도록 하기 위해 클러스터 이름을 자르고 Ingress 도메인 이름 내의 무작위 값을 추가할 수 있습니다.

6. **클러스터 작성**을 클릭하십시오. 기본적으로는 1개의 작업자 노드가 있는 작업자 풀이 작성됩니다. **작업자 노드** 탭에서 작업자 노드 배치의 진행상태를 볼 수 있습니다. 배치가 완료되면 **개요** 탭에서 클러스터가 준비되었는지 확인할 수 있습니다. 클러스터가 준비된 상태인 경우에도 Ingress 시크릿 또는 레지스트리 이미지 풀 시크릿과 같은 기타 서비스에서 사용하는 클러스터의 일부분이 계속 처리 중일 수 있다는 점에 유의하십시오. 

    작성 중에 지정된 고유 ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 더 이상 클러스터를 관리할 수 없습니다.
    {: note}

</br>

### 표준 클러스터 작성
{: #clusters_ui_standard}

1. 올바른 {{site.data.keyword.Bluemix_notm}} 계정 설정과 사용자 권한이 있는지 확인하고 사용하고자 하는 리소스 그룹과 클러스터 설정을 결정할 수 있도록 [클러스터 작성을 준비](#cluster_prepare)하십시오.
2. [카탈로그 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/catalog?category=containers)에서 클러스터를 작성할 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
3. 클러스터를 작성할 리소스 그룹을 선택하십시오.
  **참고**:
    * 특정 클러스터는 하나의 리소스 그룹에서만 작성될 수 있으며, 클러스터가 작성되고 나면 해당 리소스 그룹을 변경할 수 없습니다.
    * 무료 클러스터는 기본 리소스 그룹에 자동으로 작성됩니다.
    * 기본 외의 리소스 그룹에 클러스터를 작성하려면 해당 리소스 그룹에 대해 [**Viewer** 역할](/docs/containers?topic=containers-users#platform) 이상의 역할을 갖고 있어야 합니다.
4. 클러스터가 배치될 [{{site.data.keyword.Bluemix_notm}} 위치](/docs/containers?topic=containers-regions-and-zones#regions-and-zones)를 선택하십시오. 최상의 성능을 얻으려면 실제로 사용자와 가장 가까운 위치를 선택하십시오. 자국 외에 있는 구역을 선택하는 경우에는 데이터를 저장하기 전에 법적 인가를 받아야 할 수 있음을 유념하십시오.
5. **표준** 클러스터 플랜을 선택하십시오. 표준 클러스터를 사용하면 고가용성 환경을 위한 다중 작업자 노드와 같은 기능에 대한 액세스 권한을 갖게 됩니다.
6. 구역 세부사항을 입력하십시오.
    1. **단일 구역** 또는 **다중 구역** 가용성을 선택하십시오. 다중 구역 클러스터에서 마스터 노드는 다중 구역 가능 구역에 배치되며 클러스터의 리소스는 다중 구역 간에 전개됩니다. 선택사항은 지역에 따라 제한될 수 있습니다.
    2. 클러스터가 호스팅될 특정 구역을 선택하십시오. 최소한 1개의 구역을 선택해야 하지만 원하는 수만큼 선택할 수 있습니다. 둘 이상의 구역을 선택하면 사용자가 선택한 구역 간에 작업자 노드가 전개되므로 보다 높은 고가용성이 제공됩니다. 1개의 구역만 선택하는 경우에는 작성 이후에 [클러스터에 구역을 추가](#add_zone)할 수 있습니다.
    3. IBM Cloud 인프라(SoftLayer) 계정에서 공용 VLAN(선택사항) 및 사설 VLAN(필수)을 선택하십시오. 작업자 노드는 사설 VLAN을 사용하여 서로 간에 통신합니다. Kubernetes 마스터와 통신하려면 작업자 노드에 대한 공용 연결을 구성해야 합니다.  이 구역에 공용 또는 사설 VLAN이 없는 경우에는 이를 그대로 공백으로 두십시오. 공용 및 사설 VLAN이 사용자를 위해 자동으로 작성됩니다. 기존 VLAN을 보유 중이며 공용 VLAN을 지정하지 않은 경우에는 [가상 라우터 어플라이언스](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra) 등의 방화벽 구성을 고려하십시오. 다중 클러스터에 대해 동일한 VLAN을 사용할 수 있습니다.
        작업자 노드가 사설 VLAN 전용으로 설정된 경우에는 [개인 서비스 엔드포인트를 사용으로 설정](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)하거나 [게이트웨이 디바이스를 구성](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)하여 작업자 노드와 클러스터 마스터가 통신할 수 있도록 해야 합니다.
        {: note}

7. 기본 작업자 풀을 구성하십시오. 작업자 풀은 동일한 구성을 공유하는 작업자 노드의 그룹입니다. 나중에 언제든지 클러스터에 작업자 풀을 더 추가할 수 있습니다.

    1. 하드웨어 격리의 유형을 선택하십시오. 가상은 시간별로 비용이 청구되고 베어메탈은 월별로 비용이 청구됩니다.

        - **가상 - 데디케이티드**: 작업자 노드가 사용자 계정에 전념하는 인프라에서 호스팅됩니다. 실제 리소스가 완전히 격리됩니다.

        - **가상 - 공유**: 하이퍼바이저 및 실제 하드웨어와 같은 인프라 리소스가 사용자와 다른 IBM 고객 간에 공유되지만 해당 사용자만 각 작업자 노드에 액세스할 수 있습니다. 이 옵션은 비용이 적게 들고 대부분의 경우에 충분하지만 회사 정책에 따라 성능 및 인프라 요구사항을 확인해야 할 수 있습니다.

        - **베어메탈**: 월별로 비용이 청구되는 베어메탈 서버는 주문 후 IBM Cloud 인프라(SoftLayer)에 의해 수동으로 프로비저닝되며 완료하는 데 영업일 기준으로 이틀 이상 걸릴 수 있습니다. 베어메탈은 추가 리소스 및 호스트 제어가 필요한 고성능 애플리케이션에 가장 적합합니다. [신뢰할 수 있는 컴퓨팅](/docs/containers?topic=containers-security#trusted_compute)을 사용으로 설정하여 작업자 노드의 변조 여부를 확인하도록 선택할 수도 있습니다. 신뢰할 수 있는 컴퓨팅은 선택된 베어메탈 머신 유형에만 사용할 수 있습니다. 예를 들어, `mgXc` GPU 특성(flavor)은 신뢰할 수 있는 컴퓨팅을 지원하지 않습니다. 클러스터 작성 중에 신뢰 사용을 설정하지 않고 나중에 이를 수행하려면 `ibmcloud ks feature-enable` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)을 사용할 수 있습니다. 신뢰를 사용하도록 설정한 후에는 나중에 사용하지 않도록 설정할 수 없습니다.

        베어메탈 머신을 프로비저닝하려는지 확인하십시오. 월별로 비용이 청구되므로 실수로 주문한 후 즉시 취소하는 경우 한 달의 요금이 청구됩니다.
        {:tip}

    2. 머신 유형을 선택하십시오. 머신 유형은 각 작업자 노드에서 설정되고 컨테이너에 사용 가능한 가상 CPU, 메모리 및 디스크 공간의 양을 정의합니다. 사용 가능한 베어메탈 및 가상 머신 유형은 클러스터가 배치되는 구역에 따라 다양합니다. 클러스터를 작성한 후에 작업자 또는 풀을 클러스터에 추가하여 서로 다른 머신 유형을 추가할 수 있습니다.

    3. 클러스터에서 필요한 작업자 노드의 수를 지정하십시오. 사용자가 입력하는 작업자의 수는 선택한 구역의 수에 따라 복제됩니다. 이는 2개의 구역을 보유 중이며 3개의 작업자 노드를 선택하는 경우에 6개의 노드가 프로비저닝되고 각 구역에서 3개의 노드가 라이브 상태임을 의미합니다.

8. 클러스터에 고유 이름을 지정하십시오. **참고**: 작성 중에 지정된 고유 ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 더 이상 클러스터를 관리할 수 없습니다.
9. 클러스터 마스터 노드의 Kubernetes API 서버 버전을 선택하십시오.
10. **클러스터 작성**을 클릭하십시오. 작업자 풀은 사용자가 지정한 작업자 수로 작성됩니다. **작업자 노드** 탭에서 작업자 노드 배치의 진행상태를 볼 수 있습니다. 배치가 완료되면 **개요** 탭에서 클러스터가 준비되었는지 확인할 수 있습니다. 클러스터가 준비된 상태인 경우에도 Ingress 시크릿 또는 레지스트리 이미지 풀 시크릿과 같은 기타 서비스에서 사용하는 클러스터의 일부분이 계속 처리 중일 수 있다는 점에 유의하십시오.

**다음에 수행할 작업**

클러스터가 시작되어 실행 중인 경우에는 다음 태스크를 수행할 수 있습니다.

-   다중 구역 가능 구역에 클러스터를 작성한 경우에는 [클러스터에 구역을 추가](#add_zone)하여 작업자 노드를 분산시키십시오.
-   [CLI를 설치](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)하거나 [웹 브라우저에서 직접 CLI를 사용하도록 Kubernetes 터미널을 실행](/docs/containers?topic=containers-cs_cli_install#cli_web)하여 클러스터 관련 작업을 시작하십시오. 
-   [클러스터에 앱을 배치합니다. ](/docs/containers?topic=containers-app#app_cli)
-   [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정합니다.](/docs/services/Registry?topic=registry-getting-started)
-   방화벽이 있는 경우, 클러스터의 아웃바운드 트래픽을 허용하거나 네트워킹 서비스를 위한 인바운드 트래픽을 허용하려면 [필수 포트를 열어서](/docs/containers?topic=containers-firewall#firewall) `ibmcloud`, `kubectl` 또는 `calicotl` 명령을 사용해야 할 수 있습니다.
-   워크로드 리소스 요청을 기반으로 작업자 풀에 작업자 노드를 자동으로 추가하거나 제거하려면 [클러스터 오토스케일러를 설정](/docs/containers?topic=containers-ca#ca)합니다.
-   [팟(Pod) 보안 정책](/docs/containers?topic=containers-psp)으로 클러스터에서 팟을 작성할 수 있는 사용자를 제어합니다.

<br />


## {{site.data.keyword.Bluemix_notm}} CLI를 사용하여 클러스터 작성
{: #clusters_cli}

Kubernetes 클러스터의 용도는 앱의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 앱을 배치하려면 우선 클러스터를 작성하고 해당 클러스터에서 작업자 노드에 대한 정의를 설정해야 합니다.
{:shortdesc}

### 샘플 CLI `ibmcloud ks cluster-create` 명령
{: #clusters_cli_samples}

이전에 클러스터를 작성했고 빠른 예제 명령을 찾을 수 있으십니까? 이 예제를 사용해 보십시오.
*  **무료 클러스터**:
   ```
        ibmcloud ks cluster-create --name my_cluster
   ```
   {: pre}
*  **표준 클러스터, 공유 가상 머신**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **표준 클러스터, 베어메탈**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **표준 클러스터, VRF 사용 계정의 [공용 및 개인 서비스 엔드포인트](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)가 포함된 가상 머신**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*   **표준 클러스터, 사설 VLAN 전용 및 개인 서비스 엔드포인트 전용**. 사설 클러스터 네트워킹 구성에 대한 자세한 정보는 [사설 VLAN만 사용하여 클러스터 네트워킹 설정](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan)을 참조하십시오.
    ```
    ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_VLAN_ID> --private-only
    ```
    {: pre}

### CLI에서 클러스터를 작성하는 단계
{: #clusters_cli_steps}

시작하기 전에, {{site.data.keyword.Bluemix_notm}} CLI 및 [{{site.data.keyword.containerlong_notm}} 플러그인](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)을 설치하십시오.

클러스터를 작성하려면 다음을 수행하십시오.

1. 올바른 {{site.data.keyword.Bluemix_notm}} 계정 설정과 사용자 권한이 있는지 확인하고 사용하고자 하는 리소스 그룹과 클러스터 설정을 결정할 수 있도록 [클러스터 작성을 준비](#cluster_prepare)하십시오.

2.  {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오.

    1.  로그인을 수행하고 프롬프트가 표시되면 {{site.data.keyword.Bluemix_notm}} 인증 정보를 입력하십시오.

        ```
        ibmcloud login
        ```
        {: pre}

        연합 ID가 있는 경우에는 `ibmcloud login --sso`를 사용하여 {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용자 이름을 입력하고 CLI 출력에서 제공된 URL을 사용하여 일회성 패스코드를 검색하십시오. `--sso` 옵션을 사용하지 않으면 로그인에 실패하고 `--sso` 옵션을 사용하면 성공하는 경우에는 연합 ID를 보유하고 있다는 것입니다.
        {: tip}

    2. 여러 {{site.data.keyword.Bluemix_notm}} 계정이 있는 경우에는 Kubernetes 클러스터를 작성할 계정을 선택하십시오.

    3.  기본 외의 리소스 그룹에 클러스터를 작성하려면 해당 리소스 그룹을 대상으로 지정하십시오.
      **참고**:
        * 특정 클러스터는 하나의 리소스 그룹에서만 작성될 수 있으며, 클러스터가 작성되고 나면 해당 리소스 그룹을 변경할 수 없습니다.
        * 해당 리소스 그룹에 대해 [**Viewer** 역할](/docs/containers?topic=containers-users#platform) 이상의 역할을 갖고 있어야 합니다.
        * 무료 클러스터는 기본 리소스 그룹에 자동으로 작성됩니다.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4. **무료 클러스터**: 특정 지역에서 무료 클러스터를 작성할 경우 `ibmcloud ks region-set`를 실행하여 해당 지역을 대상으로 지정해야 합니다.

4.  클러스터를 작성하십시오. 표준 클러스터는 임의의 지역 및 사용 가능한 구역에서 작성될 수 있습니다. 무료 클러스터는 `ibmcloud ks region-set` 명령을 사용하여 대상으로 설정하는 지역에서 작성할 수 있으나 구역을 선택할 수 없습니다. 

    1.  **표준 클러스터**: 사용 가능한 구역을 검토하십시오. 표시되는 구역은 사용자가 로그인한 {{site.data.keyword.containerlong_notm}} 지역에 따라 다릅니다. 구역 간에 클러스터를 전개하려면 [다중 구역 가능 구역](/docs/containers?topic=containers-regions-and-zones#zones)에서 클러스터를 작성해야 합니다.
        ```
        ibmcloud ks zones
        ```
        {: pre}
자국 외에 있는 구역을 선택하는 경우에는 외국에서 데이터를 실제로 저장하기 전에 법적 인가를 받아야 할 수 있음을 유념하십시오.
        {: note}

    2.  **표준 클러스터**: 구역을 선택하고 해당 구역에서 사용할 수 있는 머신 유형을 검토하십시오. 머신 유형은 각 작업자 노드가 사용할 수 있는 가상 또는 실제 컴퓨팅 호스트를 지정합니다.

        -  가상 또는 실제(베어메탈) 머신을 선택하려면 **서버 유형** 필드를 보십시오.
        -  **가상**: 시간별로 비용이 청구되는 가상 머신은 공유 또는 전용 하드웨어에 프로비저닝됩니다.
        -  **실제**: 월별로 비용이 청구되는 베어메탈 서버는 주문 후 IBM Cloud 인프라(SoftLayer)에 의해 수동으로 프로비저닝되며 완료하는 데 영업일 기준으로 이틀 이상 걸릴 수 있습니다. 베어메탈은 추가 리소스 및 호스트 제어가 필요한 고성능 애플리케이션에 가장 적합합니다.
        - **신뢰할 수 있는 컴퓨팅의 실제 머신**: [신뢰할 수 있는 컴퓨팅](/docs/containers?topic=containers-security#trusted_compute)이 베어메탈 작업자 노드의 변조 여부를 확인할 수 있도록 선택할 수도 있습니다. 신뢰할 수 있는 컴퓨팅은 선택된 베어메탈 머신 유형에만 사용할 수 있습니다. 예를 들어, `mgXc` GPU 특성(flavor)은 신뢰할 수 있는 컴퓨팅을 지원하지 않습니다. 클러스터 작성 중에 신뢰 사용을 설정하지 않고 나중에 이를 수행하려면 `ibmcloud ks feature-enable` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)을 사용할 수 있습니다. 신뢰를 사용하도록 설정한 후에는 나중에 사용하지 않도록 설정할 수 없습니다.
        -  **머신 유형**: 배치할 머신 유형을 결정하려면 [사용 가능한 작업자 노드 하드웨어](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)의 코어, 메모리 및 스토리지 조합을 검토하십시오. 클러스터를 작성한 후에 [작업자 풀을 추가](#add_pool)하여 서로 다른 실제 또는 가상 머신 유형을 추가할 수 있습니다.

           베어메탈 머신을 프로비저닝하려는지 확인하십시오. 월별로 비용이 청구되므로 실수로 주문한 후 즉시 취소하는 경우 한 달의 요금이 청구됩니다.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **표준 클러스터**: 공용 및 사설 VLAN이 이 계정에 대한 IBM Cloud 인프라(SoftLayer)에 이미 존재하는지 확인하십시오.

        ```
        ibmcloud ks vlans --zone <zone>
        ```
        {: pre}

        ```
        ID        Name   Number   Type      Router
        1519999   vlan   1355     private   bcr02a.dal10
        1519898   vlan   1357     private   bcr02a.dal10
        1518787   vlan   1252     public    fcr02a.dal10
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        공용 및 사설 VLAN이 이미 존재하는 경우 일치하는 라우터를 기록해 두십시오. 사설 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 공용 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터를 작성하고 공인 및 사설 VLAN을 지정할 때는 이러한 접두부 뒤의 숫자 및 문자 조합이 일치해야 합니다. 출력 예에서는 라우터가 모두 `02a.dal10`을 포함하고 있기 때문에 사설 VLAN이 공용 VLAN과 함께 사용될 수 있습니다.

        사용자는 작업자 노드를 사설 VLAN에 연결해야 하며, 선택적으로 작업자 노드를 공용 VLAN에도 연결할 수 있습니다. **참고**: 작업자 노드가 사설 VLAN 전용으로 설정된 경우에는 [개인 서비스 엔드포인트를 사용으로 설정](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)하거나 [게이트웨이 디바이스를 구성](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)하여 작업자 노드와 클러스터 마스터가 통신할 수 있도록 해야 합니다.

    4.  **무료 및 표준 클러스터**: `cluster-create` 명령을 실행하십시오. 2vCPU 및 4GB 메모리로 설정된 하나의 작업자 노드를 포함하며 30일 후에 자동으로 삭제되는 무료 클러스터와 표준 클러스터 간에 선택할 수 있습니다. 표준 클러스터를 작성하는 경우, 기본적으로 작업자 노드 디스크가 AES 256비트 암호화되고 해당 하드웨어가 다중 IBM 고객에 의해 공유되며 사용 시간을 기준으로 비용이 청구됩니다. </br>표준 클러스터의 예입니다. 클러스터의 옵션을 지정하십시오.

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b3c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--private-service-endpoint][--public-service-endpoint] [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        무료 클러스터의 예입니다. 클러스터 이름을 지정하십시오.

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>cluster-create 컴포넌트</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>{{site.data.keyword.Bluemix_notm}} 조직에 클러스터를 작성하는 명령입니다.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**표준 클러스터**: <em>&lt;zone&gt;</em>을 클러스터가 작성될 {{site.data.keyword.Bluemix_notm}} 구역 ID로 대체하십시오. 사용 가능한 구역은 사용자가 로그인한 {{site.data.keyword.containerlong_notm}} 지역에 따라 다릅니다.<p class="note">클러스터 작업자 노드는 이 구역에 배치됩니다. 구역 간에 클러스터를 전개하려면 [다중 구역 가능 구역](/docs/containers?topic=containers-regions-and-zones#zones)에서 클러스터를 작성해야 합니다. 클러스터를 작성한 후에는 [클러스터에 구역을 추가](#add_zone)할 수 있습니다.</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**표준 클러스터**: 머신 유형을 선택하십시오. 공유 또는 전용 하드웨어에서 가상 머신으로서 또는 베어메탈에서 실제 머신으로서 작업자 노드를 배치할 수 있습니다. 사용 가능한 실제 및 가상 머신 유형은 클러스터가 배치되는 구역에 따라 다양합니다. 자세한 정보는 `ibmcloud ks machine-type` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)에 대한 문서를 참조하십시오. 무료 클러스터의 경우에는 머신 유형을 정의할 필요가 없습니다.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**표준 클러스터**: 작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스를 사용 가능하게 하려면 dedicated를 사용하고, 실제 리소스를 다른 IBM 고객과 공유하도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다. 이 값은 VM 표준 클러스터의 경우 선택사항이며 무료 클러스터에는 사용할 수 없습니다. 베어메탈 머신 유형의 경우에는 `dedicated`를 지정하십시오.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**무료 클러스터**: 공용 VLAN을 정의할 필요가 없습니다. 무료 클러스터는 IBM이 소유하고 있는 공용 VLAN에 자동으로 연결됩니다.</li>
          <li>**표준 클러스터**: 해당 구역에 대한 IBM Cloud 인프라(SoftLayer) 계정에서 공용 VLAN이 이미 설정되어 있으면 공용 VLAN의 ID를 입력하십시오. 작업자 노드가 사설 VLAN에만 연결하려는 경우 이 옵션을 지정하지 마십시오.
          <p>사설 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 공용 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터를 작성하고 공인 및 사설 VLAN을 지정할 때는 이러한 접두부 뒤의 숫자 및 문자 조합이 일치해야 합니다.</p>
          <p class="note">작업자 노드가 사설 VLAN 전용으로 설정된 경우에는 [개인 서비스 엔드포인트를 사용으로 설정](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)하거나 [게이트웨이 디바이스를 구성](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)하여 작업자 노드와 클러스터 마스터가 통신할 수 있도록 해야 합니다.</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**무료 클러스터**: 사설 VLAN을 정의할 필요가 없습니다. 무료 클러스터는 IBM이 소유하고 있는 사설 VLAN에 자동으로 연결됩니다.</li><li>**표준 클러스터**: 해당 구역에 대한 IBM Cloud 인프라(SoftLayer) 계정에서 사설 VLAN이 이미 설정되어 있으면 사설 VLAN의 ID를 입력하십시오. 계정에 사설 VLAN이 없는 경우 이 옵션을 지정하지 마십시오. {{site.data.keyword.containerlong_notm}}에서 사용자를 위해 자동으로 사설 VLAN을 작성합니다.<p>사설 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 공용 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터를 작성하고 공인 및 사설 VLAN을 지정할 때는 이러한 접두부 뒤의 숫자 및 문자 조합이 일치해야 합니다.</p></li>
        <li>[사설 VLAN 전용 클러스터](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan)를 작성하려면 이 `--private-vlan` 플래그와 `--private-only` 플래그를 포함하여 선택사항을 확인하십시오. `--public-vlan` 및 `--public-service-endpoint` 플래그를 포함하지 **마십시오**. 마스터와 작업자 노드 간의 연결을 사용으로 설정하려면 `--private-service-endpoint` 플래그를 포함하거나 고유한 게이트웨이 어플라이언스 디바이스를 설정해야 합니다. </li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**무료 및 표준 클러스터**: <em>&lt;name&gt;</em>을 클러스터의 이름으로 바꾸십시오. 이름은 문자로 시작해야 하며 35자 이하의 문자, 숫자 및 하이픈(-)을 포함할 수 있습니다. 클러스터 이름과 클러스터가 배치된 지역이 Ingress 하위 도메인의 완전한 이름을 형성합니다. 특정 Ingress 하위 도메인이 지역 내에서 고유하도록 하기 위해 클러스터 이름을 자르고 Ingress 도메인 이름 내의 무작위 값을 추가할 수 있습니다.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**표준 클러스터**: 클러스터에 포함할 작업자 노드의 수입니다. <code>--workers</code> 옵션이 지정되지 않은 경우 1개의 작업자 노드가 작성됩니다.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**표준 클러스터**: 클러스터 마스터 노드를 위한 Kubernetes 버전입니다. 이 값은 선택사항입니다. 버전이 지정되지 않은 경우에는 클러스터가 지원되는 Kubernetes 버전의 기본값으로 작성됩니다. 사용 가능한 버전을 보려면 <code>ibmcloud ks kube-versions</code>를 실행하십시오.
</td>
        </tr>
        <tr>
        <td><code>--private-service-endpoint</code></td>
        <td>**[VRF 사용 계정](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)의 표준 클러스터**: Kubernetes 마스터와 작업자 노드가 사설 VLAN을 통해 통신하도록 [개인 서비스 엔드포인트](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)를 사용으로 설정합니다. 또한 `--public-service-endpoint` 플래그를 사용하여 공용 서비스 엔드포인트를 사용하도록 선택하여 인터넷을 통해 클러스터에 액세스할 수 있습니다. 개인 서비스 엔드포인트만 사용으로 설정한 경우 사설 VLAN에 연결되어 Kubernetes 마스터와 통신해야 합니다. 개인 서비스 엔드포인트를 사용으로 설정한 후에는 나중에 사용 안함으로 설정할 수 없습니다.<br><br>클러스터를 작성한 후 `ibmcloud ks cluster-get <cluster_name_or_ID>`를 실행하여 엔드포인트를 가져올 수 있습니다.</td>
        </tr>
        <tr>
        <td><code>--public-service-endpoint</code></td>
        <td>**표준 클러스터**: 공용 네트워크를 통해 Kubernetes 마스터에 액세스할 수 있도록 [공용 서비스 엔드포인트](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)를 사용으로 설정합니다(예: 터미널에서 `kubectl` 명령 실행). `--private-service-endpoint` 플래그도 포함하면 [마스터와 작업자 노드 간 통신](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)은 VRF 사용 계정의 사설 네트워크에서 수행됩니다. 사설 전용 클러스터가 필요한 경우 나중에 공용 서비스 엔드포인트를 사용 안함으로 설정할 수 있습니다.<br><br>클러스터를 작성한 후 `ibmcloud ks cluster-get <cluster_name_or_ID>`를 실행하여 엔드포인트를 가져올 수 있습니다.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**무료 및 표준 클러스터**: 작업자 노드는 기본적으로 AES 256비트 [디스크 암호화](/docs/containers?topic=containers-security#encrypted_disk) 기능을 합니다. 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하십시오.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**표준 베어메탈 클러스터**: [신뢰할 수 있는 컴퓨팅](/docs/containers?topic=containers-security#trusted_compute)을 사용하여 베어메탈 작업자 노드의 변조 여부를 확인합니다. 신뢰할 수 있는 컴퓨팅은 선택된 베어메탈 머신 유형에만 사용할 수 있습니다. 예를 들어, `mgXc` GPU 특성(flavor)은 신뢰할 수 있는 컴퓨팅을 지원하지 않습니다. 클러스터 작성 중에 신뢰 사용을 설정하지 않고 나중에 이를 수행하려면 `ibmcloud ks feature-enable` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)을 사용할 수 있습니다. 신뢰를 사용하도록 설정한 후에는 나중에 사용하지 않도록 설정할 수 없습니다.</td>
        </tr>
        </tbody></table>

5.  클러스터 작성이 요청되었는지 확인하십시오. 가상 머신의 경우 작업자 노드 머신을 정렬하며 클러스터를 설정하고 계정에 프로비저닝하는 데 몇 분 정도 걸릴 수 있습니다. 베어메탈 실제 머신은 IBM Cloud 인프라(SoftLayer)의 수동 상호작용으로 프로비저닝되며 완료하는 데 영업일 기준으로 이틀 이상 걸릴 수 있습니다.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    클러스터의 프로비저닝이 완료되면 클러스터의 상태가 **배치됨(deployed)**으로 변경됩니다.

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.12.7      Default
    ```
    {: screen}

6.  작업자 노드의 상태를 확인하십시오.

    ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    작업자 노드가 준비되면 상태(state)가 **정상(normal)**으로 변경되며, 상태(status)는 **준비(Ready)**입니다. 노드 상태(status)가 **준비(Ready)**인 경우에는 클러스터에 액세스할 수 있습니다. 클러스터가 준비된 상태인 경우에도 Ingress 시크릿 또는 레지스트리 이미지 풀 시크릿과 같은 기타 서비스에서 사용하는 클러스터의 일부분이 계속 처리 중일 수 있다는 점에 유의하십시오. 

    모든 작업자 노드에는 클러스터가 작성된 이후 수동으로 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 클러스터를 관리할 수 없습니다.
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.12.7      Default
    ```
    {: screen}

7.  작성한 클러스터를 이 세션에 대한 컨텍스트로 설정하십시오. 클러스터 관련 작업을 수행할 때마다 다음 구성 단계를 완료하십시오.
    1.  환경 변수를 설정하기 위한 명령을 가져오고 Kubernetes 구성 파일을 다운로드하십시오.

        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        구성 파일 다운로드가 완료되면 환경 변수로서 경로를 로컬 Kubernetes 구성 파일로 설정하는 데 사용할 수 있는 명령이 표시됩니다.

        OS X에 대한 예:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 환경 변수를 설정하려면 터미널에 표시되는 명령을 복사하여 붙여넣기하십시오.
    3.  `KUBECONFIG` 환경 변수가 올바르게 설정되었는지 확인하십시오.

        OS X에 대한 예:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        출력:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  기본 포트 `8001`로 Kubernetes 대시보드를 실행하십시오.
    1.  기본 포트 번호로 프록시를 설정하십시오.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  웹 브라우저에서 다음 URL을 열어서 Kubernetes 대시보드를 보십시오.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**다음에 수행할 작업**

-   다중 구역 가능 구역에 클러스터를 작성한 경우에는 [클러스터에 구역을 추가](#add_zone)하여 작업자 노드를 분산시키십시오.
-   [클러스터에 앱을 배치합니다. ](/docs/containers?topic=containers-app#app_cli)
-   [`kubectl` 명령행을 사용하여 클러스터를 관리합니다. ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubectl.docs.kubernetes.io/)
-   [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정합니다.](/docs/services/Registry?topic=registry-getting-started)
- 방화벽이 있는 경우, 클러스터의 아웃바운드 트래픽을 허용하거나 네트워킹 서비스를 위한 인바운드 트래픽을 허용하려면 [필수 포트를 열어서](/docs/containers?topic=containers-firewall#firewall) `ibmcloud`, `kubectl` 또는 `calicotl` 명령을 사용해야 할 수 있습니다.
-   워크로드 리소스 요청을 기반으로 작업자 풀에 작업자 노드를 자동으로 추가하거나 제거하려면 [클러스터 오토스케일러를 설정](/docs/containers?topic=containers-ca#ca)합니다.
-  [팟(Pod) 보안 정책](/docs/containers?topic=containers-psp)으로 클러스터에서 팟을 작성할 수 있는 사용자를 제어합니다.

<br />



## 클러스터에 작업자 노드 및 구역 추가
{: #add_workers}

앱의 가용성을 높이기 위해 클러스터의 한 기존 구역 또는 다수의 기존 구역에 작업자 노드를 추가할 수 있습니다. 구역 장애로부터 앱을 보호하는 데 도움이 되도록 클러스터에 구역을 추가할 수 있습니다.
{:shortdesc}

클러스터를 작성하면 작업자 노드가 작업자 풀에서 프로비저닝됩니다. 클러스터 작성 후에는 해당 크기를 조정하거나 작업자 풀을 더 추가하여 풀에 작업자 노드를 더 추가할 수 있습니다. 기본적으로 작업자 풀은 하나의 구역에 존재합니다. 하나의 구역에만 작업자 풀이 있는 클러스터를 단일 구역 클러스터(single zone cluster)라고 합니다. 클러스터에 구역을 더 추가하면 작업자 풀이 구역 간에 존재합니다. 둘 이상의 구역 간에 전개된 작업자 풀이 있는 클러스터를 다중 구역 클러스터(multizone cluster)라고 합니다.

다중 구역 클러스터가 있으면 해당 작업자 노드 리소스의 밸런스를 유지하십시오. 모든 작업자 풀이 동일한 구역 간에 전개되어 있는지 확인하고 개별 노드를 추가하는 대신 풀의 크기를 조정하여 작업자를 추가하거나 제거하십시오.
{: tip}

시작하기 전에, [**운영자** 또는 **관리자** {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 역할](/docs/containers?topic=containers-users#platform)이 있는지 확인하십시오. 그리고 다음 섹션 중 하나를 선택하십시오.
  * [클러스터에서 기존 작업자 풀의 크기를 조정하여 작업자 노드 추가](#resize_pool)
  * [클러스터에 작업자 풀을 추가하여 작업자 노드 추가](#add_pool)
  * [클러스터에 구역을 추가하고 다중 구역 간의 작업자 풀에서 작업자 노드 복제](#add_zone)
  * [더 이상 사용되지 않음: 클러스터에 독립형 작업자 노드 추가](#standalone)

작업자 풀을 설정한 후, 워크로드 리소스 요청을 기반으로 작업자 풀에 작업자 노드를 자동으로 추가하거나 제거하려면 [클러스터 오토스케일러를 설정](/docs/containers?topic=containers-ca#ca)할 수 있습니다.
{:tip}

### 기존 작업자 풀의 크기를 조정하여 작업자 노드 추가
{: #resize_pool}

작업자 풀이 하나의 구역에 있는지 또는 다중 구역 간에 전개되었는지 여부와 무관하게, 기존 작업자 풀의 크기를 조정하여 클러스터에 있는 작업자 노드의 수를 늘리거나 줄일 수 있습니다.
{: shortdesc}

예를 들어, 구역별로 3개의 작업자 노드가 있는 하나의 작업자 풀이 있는 클러스터를 고려하십시오.
* 클러스터가 단일 구역이고 `dal10`에 존재하는 경우, 작업자 풀에는 `dal10`에 3개의 작업자 노드가 있습니다. 클러스터에는 총 3개의 작업자 노드가 있습니다.
* 클러스터가 다중 구역이고 `dal10` 및 `dal12`에 존재하는 경우, 작업자 풀에는 `dal10`에 3개의 작업자 노드가 있으며 `dal12`에 3개의 작업자 노드가 있습니다. 클러스터에는 총 6개의 작업자 노드가 있습니다.

베어메탈 작업자 풀의 경우에는 비용이 매월 청구됨을 유념하십시오. 크기를 늘리거나 줄이는 경우, 이는 해당 월의 비용에 영향을 줍니다.
{: tip}

작업자 풀의 크기를 조정하려면 각 구역에서 작업자 풀에 배치된 작업자 노드의 수를 변경하십시오.

1. 크기 조정을 원하는 작업자 풀의 이름을 가져오십시오.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. 각 구역에서 배치할 작업자 노드의 수를 지정하여 작업자 풀의 크기를 조정하십시오. 최소값은 1입니다.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. 작업자 풀의 크기가 조정되었는지 확인하십시오.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Example output for a worker pool that is in two zones, `dal10` and `dal12`, and is resized to two worker nodes per zone:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### 새 작업자 풀을 작성하여 작업자 노드 추가
{: #add_pool}

새 작업자 풀을 작성하여 클러스터에 작업자 노드를 추가할 수 있습니다.
{:shortdesc}

1. 클러스터의 **작업자 구역**을 검색하고 작업자 풀에 작업자 노드를 배치할 구역을 선택하십시오. 단일 구역 클러스터를 보유하는 경우에는 **작업자 구역** 필드에 나타난 구역을 사용해야 합니다. 다중 구역 클러스터의 경우에는 클러스터의 기존 **작업자 구역**을 선택하거나 클러스터가 있는 지역의 [다중 구역 메트로 위치](/docs/containers?topic=containers-regions-and-zones#zones) 중 하나를 선택할 수 있습니다. `ibmcloud ks zones`를 실행하여 사용 가능한 구역을 나열할 수 있습니다.
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   출력 예:
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. 각 구역에 대해 사용 가능한 사설 및 공용 VLAN을 나열하십시오. 사용할 사설 및 공용 VLAN을 기록해 두십시오. 사설 또는 공용 VLAN이 없으면 구역을 작업자 풀에 추가할 때 사용자를 위해 VLAN이 자동으로 작성됩니다.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  각 구역의 [작업자 노드에 사용 가능한 머신 유형](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)을 검토하십시오.

    ```
        ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. 작업자 풀을 작성하십시오. 베어메탈 작업자 풀을 프로비저닝하는 경우에는 `--hardware dedicated`를 지정하십시오.
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. 작업자 풀이 작성되었는지 확인하십시오.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. 기본적으로, 작업자 풀을 추가하면 구역이 없는 풀이 작성됩니다. 구역에 작업자 노드를 배치하려면 이전에 검색한 구역을 작업자 풀에 추가해야 합니다. 다중 구역 전체에 작업자 노드를 분산시키려는 경우에는 각 구역에 대해 이 명령을 반복하십시오.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. 사용자가 추가한 구역에서 작업자 노드의 프로비저닝을 확인하십시오. 상태가 **provision_pending**에서 **normal**로 변경되면 작업자 노드가 준비된 것입니다.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   출력 예:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### 작업자 풀에 구역을 추가하여 작업자 노드 추가
{: #add_zone}

기존 작업자 풀에 구역을 추가하여 한 지역 내의 다중 구역 간에 클러스터를 전개할 수 있습니다.
{:shortdesc}

작업자 풀에 구역을 추가하면 작업자 풀에서 정의된 작업자 노드가 새 구역에서 프로비저닝되며 향후 워크로드 스케줄을 위해 고려됩니다. {{site.data.keyword.containerlong_notm}}는 지역에 대한 `failure-domain.beta.kubernetes.io/region` 레이블과 구역에 대한 `failure-domain.beta.kubernetes.io/zone` 레이블을 각 작업자 노드에 자동으로 추가합니다. Kubernetes 스케줄러는 이러한 레이블을 사용하여 동일한 지역 내의 구역 간에 팟(Pod)을 전개합니다.

클러스터에 다중 작업자 풀이 있는 경우에는 작업자 노드가 클러스터에서 균등하게 전개되도록 이들 모두에 구역을 추가하십시오.

시작하기 전에:
*  작업자 풀에 구역을 추가하려면 작업자 풀이 [다중 구역 가능 구역](/docs/containers?topic=containers-regions-and-zones#zones)에 있어야 합니다. 작업자 풀이 다중 구역 가능 구역에 없으면 [새 작업자 풀 작성](#add_pool)을 고려하십시오.
*  클러스터용 다중 VLAN, 동일한 VLAN의 다중 서브넷 또는 다중 구역 클러스터가 있는 경우에는 작업자 노드가 사설 네트워크에서 서로 간에 통신할 수 있도록 IBM Cloud 인프라(SoftLayer) 계정에 대해 [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)을 사용으로 설정해야 합니다. VRF를 사용으로 설정하려면 [IBM Cloud 인프라(SoftLayer) 계정 담당자에게 문의하십시오](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). VRF를 사용할 수 없거나 사용하지 않으려면 [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)을 사용으로 설정하십시오. 이 조치를 수행하려면 **네트워크 > 네트워크 VLAN Spanning 관리** [인프라 권한](/docs/containers?topic=containers-users#infra_access)이 필요합니다. 또는 이를 사용으로 설정하도록 계정 소유자에게 요청할 수 있습니다. VLAN Spanning이 이미 사용으로 설정되었는지 확인하려면 `ibmcloud ks vlan-spanning-get` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)을 사용하십시오.

작업자 노드가 있는 구역을 작업자 풀에 추가하려면 다음을 수행하십시오.

1. 사용 가능한 구역을 나열하고 작업자 풀에 추가할 구역을 선택하십시오. 선택하는 구역은 다중 구역 가능 구역이어야 합니다.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 해당 구역의 사용 가능한 VLAN을 나열하십시오. 사설 또는 공용 VLAN이 없으면 구역을 작업자 풀에 추가할 때 사용자를 위해 VLAN이 자동으로 작성됩니다.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. 클러스터의 작업자 풀을 나열하고 해당 이름을 기록해 두십시오.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. 작업자 풀에 구역을 추가하십시오. 다중 작업자 풀이 있는 경우에는 모든 구역에서 클러스터의 밸런스가 유지되도록 모든 작업자 풀에 구역을 추가하십시오. `<pool1_id_or_name,pool2_id_or_name,...>`을 모든 작업자 풀 이름의 쉼표로 구분된 목록으로 대체하십시오.

    다중 작업자 풀에 구역을 추가하려면 우선 사설 및 공용 VLAN이 있어야 합니다. 해당 구역에 공용 및 사설 VLAN이 없는 경우에는 공용 및 사설 VLAN이 사용자를 위해 작성되도록 우선 하나의 작업자 풀에 구역을 추가하십시오. 그러면 사용자를 위해 작성된 사설 및 공용 VLAN을 지정하여 다른 작업자 풀에 구역을 추가할 수 있습니다.
    {: note}

   서로 다른 작업자 풀에 대해 서로 다른 VLAN을 사용하려면 각 VLAN 및 이의 대응되는 작업자 풀에 대해 이 명령을 반복하십시오. 지정된 VLAN에 임의의 새 작업자 노드가 추가되지만, 기존 작업자 노드에 대한 VLAN은 변경되지 않습니다.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. 구역이 클러스터에 추가되었는지 확인하십시오. 출력의 **Worker zones** 필드에서 추가된 구역을 찾으십시오. 추가된 구역에서 새 작업자 노드가 프로비저닝되었으므로 **Workers** 필드에서 총 작업자 수가 증가되었음을 유의하십시오.
  ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  출력 예:
  ```
  Name:                           mycluster
  ID:                             df253b6025d64944ab99ed63bb4567b6
  State:                          normal
  Created:                        2018-09-28T15:43:15+0000
  Location:                       dal10
  Master URL:                     https://c3.<region>.containers.cloud.ibm.com:30426
  Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  Master Location:                Dallas
  Master Status:                  Ready (21 hours ago)
  Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
  Ingress Secret:                 mycluster
  Workers:                        6
  Worker Zones:                   dal10, dal12
  Version:                        1.11.3_1524
  Owner:                          owner@email.com
  Monitoring Dashboard:           ...
  Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:            Default
  ```
  {: screen}  

### 더 이상 사용되지 않음: 독립형 작업자 노드 추가
{: #standalone}

작업자 풀이 도입되기 전에 작성된 클러스터가 있는 경우에는 더 이상 사용되지 않는 명령을 사용하여 독립형 작업자 노드를 추가할 수 있습니다.
{: deprecated}

작업자 풀이 도입된 후에 작성된 클러스터가 있는 경우에는 독립형 작업자 노드를 추가할 수 없습니다. 그 대신에 [작업자 풀을 작성](#add_pool)하고 [기존 작업자 풀의 크기를 조정](#resize_pool)하거나 [작업자 풀에 구역을 추가](#add_zone)하여 클러스터에 작업자 노드를 추가할 수 있습니다.
{: note}

1. 사용 가능한 구역을 나열하고 작업자 노드를 추가할 구역을 선택하십시오.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 해당 구역의 사용 가능한 VLAN을 나열하고 해당 ID를 기록하십시오.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. 해당 구역에서 사용 가능한 머신 유형을 나열하십시오.
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. 클러스터에 독립형 작업자 노드를 추가하십시오. 베어메탈 머신 유형의 경우에는 `dedicated`를 지정하십시오.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. 작업자 노드가 작성되었는지 확인하십시오.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## 클러스터 상태 보기
{: #states}

Kubernetes 클러스터의 상태를 검토하여 클러스터의 가용성과 용량에 대한 정보 및 발생할 수 있는 잠재적 문제점에 대한 정보를 가져오십시오.
{:shortdesc}

특정 클러스터에 대한 정보(예: 해당 구역, 서비스 엔드포인트 URL, Ingress 하위 도메인, 버전, 소유자 및 모니터링 대시보드)를 보려면 `ibmcloud ks cluster-get <cluster_name_or_ID>` [명령](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)을 사용하십시오. `--showResources` 플래그를 포함하여 스토리지 팟(Pod)의 추가 기능 또는 공인 및 사설 IP의 서브넷 VLAN과 같은 추가 클러스터 리소스를 보십시오.

`ibmcloud ks clusters` 명령을 실행하고 **상태(State)** 필드를 찾아서 현재 클러스터 상태를 볼 수 있습니다. 클러스터 및 작업자 노드에 대한 문제점을 해결하려면 [클러스터 문제점 해결](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters)을 참조하십시오.

<table summary="모든 테이블 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며 1열에는 클러스터의 상태, 2열에는 설명이 있어야 합니다.">
<caption>클러스터 상태</caption>
   <thead>
   <th>클러스터 상태</th>
   <th>설명</th>
   </thead>
   <tbody>
<tr>
   <td>중단됨(Aborted)</td>
   <td>Kubernetes 마스터가 배치되기 전에 사용자가 클러스터 삭제를 요청합니다. 클러스터 삭제가 완료된 후 대시보드에서 클러스터가 제거됩니다. 클러스터가 오랜 기간 동안 이 상태인 경우에는 [{{site.data.keyword.Bluemix_notm}} 지원 케이스](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)를 여십시오.</td>
   </tr>
 <tr>
     <td>위험(Critical)</td>
     <td>Kubernetes 마스터에 도달할 수 없거나 클러스터의 모든 작업자 노드가 작동 중지되었습니다. </td>
    </tr>
   <tr>
     <td>삭제에 실패함(Delete failed)</td>
     <td>Kubernetes 마스터 또는 최소 하나의 작업자 노드를 삭제할 수 없습니다.  </td>
   </tr>
   <tr>
     <td>삭제됨(Deleted)</td>
     <td>클러스터가 삭제되었으나 아직 대시보드에서 제거되지 않았습니다. 클러스터가 오랜 기간 동안 이 상태인 경우에는 [{{site.data.keyword.Bluemix_notm}} 지원 케이스](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)를 여십시오. </td>
   </tr>
   <tr>
   <td>삭제 중(Deleting)</td>
   <td>클러스터가 삭제 중이고 클러스터 인프라가 해체되고 있습니다. 클러스터에 액세스할 수 없습니다.  </td>
   </tr>
   <tr>
     <td>배치에 실패함(Deploy failed)</td>
     <td>Kubernetes 마스터의 배치를 완료하지 못했습니다. 이 상태를 해결할 수 없습니다. [{{site.data.keyword.Bluemix_notm}} 지원 케이스](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)를 열어서 IBM Cloud 지원 팀에 문의하십시오.</td>
   </tr>
     <tr>
       <td>배치 중(Deploying)</td>
       <td>Kubernetes 마스터가 아직 완전히 배치되지 않았습니다. 클러스터에 액세스할 수 없습니다. 클러스터가 완전히 배치될 때까지 기다렸다가 클러스터의 상태를 검토하십시오.</td>
      </tr>
      <tr>
       <td>정상(Normal)</td>
       <td>클러스터의 모든 작업자 노드가 시작되어 실행 중입니다. 클러스터에 액세스하고 클러스터에 앱을 배치할 수 있습니다. 이 상태는 정상으로 간주되고 사용자의 조치가 필요하지 않습니다.<p class="note">작업자 노드가 정상인 경우에도 [네트워킹](/docs/containers?topic=containers-cs_troubleshoot_network) 및 [스토리지](/docs/containers?topic=containers-cs_troubleshoot_storage)와 같은 기타 인프라 리소스에는 여전히 주의를 기울여야 합니다. 클러스터를 방금 작성한 경우 Ingress 시크릿 또는 레지스트리 이미지 풀 시크릿과 같은 기타 서비스에서 사용하는 클러스터의 일부분이 계속 처리 중일 수 있다는 점에 유의하십시오. </p></td>
    </tr>
      <tr>
       <td>보류 중(Pending)</td>
       <td>Kubernetes 마스터가 배치됩니다. 작업자 노드를 프로비저닝 중이므로 아직 클러스터에서 사용할 수 없습니다. 클러스터에 액세스할 수 있지만 클러스터에 앱을 배치할 수 없습니다.  </td>
     </tr>
   <tr>
     <td>요청됨(Requested)</td>
     <td>클러스터 작성 및 Kubernetes 마스터 및 작업자 노드의 인프라 정렬에 대한 요청이 전송되었습니다. 클러스터의 배치가 시작되면 클러스터 상태가 <code>Deploying</code>으로 변경됩니다. 클러스터가 오랜 기간 동안 <code>Requested</code> 상태인 경우에는 [{{site.data.keyword.Bluemix_notm}} 지원 케이스](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)를 여십시오. </td>
   </tr>
   <tr>
     <td>업데이트 중(Updating)</td>
     <td>Kubernetes 마스터에서 실행되는 Kubernetes API 서버가 새 Kubernetes API 버전으로 업데이트 중입니다. 업데이트 중에는 클러스터에 액세스하거나 클러스터를 변경할 수 없습니다. 사용자가 배치한 작업자 노드, 앱 및 리소스는 수정되지 않고 계속 실행됩니다. 업데이트가 완료될 때까지 기다렸다가 클러스터의 상태를 검토하십시오. </td>
   </tr>
    <tr>
       <td>경고(Warning)</td>
       <td>클러스터에 있는 하나 이상의 작업자 노드를 사용할 수 없지만, 다른 작업자 노드가 사용 가능하며 워크로드를 인계받을 수 있습니다. </td>
    </tr>
   </tbody>
 </table>


<br />


## 클러스터 제거
{: #remove}

청구 가능 계정으로 작성된 무료 및 표준 클러스터가 더 이상 필요하지 않은 경우에는 해당 클러스터가 더 이상 리소스를 이용하지 않도록 이를 수동으로 제거해야 합니다.
{:shortdesc}

<p class="important">
클러스터 또는 지속적 스토리지의 데이터에 대한 백업이 작성되지 않았습니다. 클러스터를 삭제할 때 지속적 스토리지를 삭제하도록 선택할 수 있습니다. 지속적 스토리지를 삭제하도록 선택하면 `delete` 스토리지 클래스를 사용하여 프로비저닝한 지속적 스토리지는 IBM Cloud 인프라(SoftLayer)에서 영구적으로 삭제됩니다. `retain` 스토리지 클래스를 사용하여 지속적 스토리지를 프로비저닝하고 스토리지를 삭제하도록 선택한 경우, 클러스터, PV 및 PVC는 삭제되지만 IBM Cloud 인프라(SoftLayer) 계정의 지속적인 스토리지 인스턴스는 유지됩니다.</br>
</br>클러스터를 제거하면 클러스터를 작성할 때 자동으로 프로비저닝된 서브넷과 `ibmcloud ks cluster-subnet-create` 명령을 사용하여 작성된 서브넷도 역시 제거됩니다. 그러나 `ibmcloud ks cluster-subnet-add` 명령을 사용하여 클러스터에 기존 서브넷을 수동으로 추가한 경우, 이러한 서브넷은 IBM Cloud 인프라(SoftLayer) 계정에서 제거되지 않으며 다른 클러스터에서 이를 재사용할 수 있습니다.</p>

시작하기 전에:
* 클러스터 ID를 기록해 두십시오. 클러스터와 함께 자동으로 삭제되지 않는 관련 IBM Cloud 인프라(SoftLayer) 리소스를 조사하여 이를 제거하려면 클러스터 ID가 필요할 수 있습니다.
* 지속적 스토리지의 데이터를 삭제하려면 [삭제 옵션을 잘 숙지](/docs/containers?topic=containers-cleanup#cleanup)하십시오.
* [**관리자** {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 역할](/docs/containers?topic=containers-users#platform)이 있는지 확인하십시오.

클러스터를 제거하려면 다음 작업을 수행하십시오.

-   {{site.data.keyword.Bluemix_notm}} 콘솔에서
    1.  클러스터를 선택하고 **추가 조치...** 메뉴에서 **삭제**를 클릭하십시오.

-   {{site.data.keyword.Bluemix_notm}} CLI에서
    1.  사용 가능한 클러스터를 나열하십시오.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  클러스터를 삭제하십시오.

        ```
        ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3.  프롬프트에 따라 클러스터 리소스(컨테이너, 팟(Pod), 바인딩된 서비스, 지속적 스토리지, 시크릿 등) 삭제 여부를 선택하십시오.
      - **지속적 스토리지**: 지속적 스토리지는 데이터에 대한 고가용성을 제공합니다. [기존 파일 공유](/docs/containers?topic=containers-file_storage#existing_file)를 사용하여 지속적 볼륨 클레임을 작성한 경우 클러스터를 삭제할 때 파일 공유를 삭제할 수 없습니다. 나중에 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 파일 공유를 수동으로 삭제해야 합니다.

          월별 비용 청구 주기로 인해, 매월 말일에는 지속적 볼륨 클레임(PVC)을 삭제할 수 없습니다. 해당 월의 말일에 지속적 볼륨 클레임을 삭제하는 경우 다음 달이 시작될 때까지 삭제는 보류 상태를 유지합니다.
          {: note}

다음 단계:
- 제거된 클러스터의 이름이 `ibmcloud ks clusters` 명령 실행 시 사용 가능한 클러스터 목록에 더 이상 나열되지 않으면 이 이름을 재사용할 수 있습니다.
- 서브넷을 보존한 경우에는 [이를 새 클러스터에서 다시 사용](/docs/containers?topic=containers-subnets#subnets_custom)하거나 나중에 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 수동으로 삭제할 수 있습니다.
- 지속적 스토리지를 보유한 경우에는 {{site.data.keyword.Bluemix_notm}} 콘솔의 IBM Cloud 인프라(SoftLayer) 대시보드를 통해 나중에 [스토리지를 삭제](/docs/containers?topic=containers-cleanup#cleanup)할 수 있습니다.
