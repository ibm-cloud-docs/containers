---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, compliance, security standards

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
{:download: .download}
{:faq: data-hd-content-type='faq'}

# FAQ
{: #faqs}

## Kubernetes란 무엇입니까?
{: #kubernetes}
{: faq}

Kubernetes는 여러 호스트에서 발생하는 컨테이너화된 워크로드와 서비스를 관리하기 위한 오픈 소스 플랫폼으로, 수동 개입은 최소화하면서 컨테이너화된 앱을 배치, 자동화, 모니터링 및 스케일링하는 관리 도구를 제공합니다. 마이크로서비스를 구성하는 모든 컨테이너는 손쉬운 관리와 검색을 보증하는 논리 장치인 팟(Pod)으로 그룹화됩니다. 이러한 팟(Pod)은 이식성과 확장성이 뛰어나고 장애 시 자체 수리되는 Kubernetes 클러스터에서 관리되는 컴퓨팅 호스트에서 실행됩니다. 
{: shortdesc}

Kubernetes에 대한 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational)를 참조하십시오. 

## IBM Cloud Kubernetes Service는 어떻게 작동됩니까?
{: #kubernetes_service}
{: faq}

{{site.data.keyword.containerlong_notm}}를 사용하면 사용자 고유의 Kubernetes 클러스터를 작성하여 {{site.data.keyword.Bluemix_notm}}에서 컨테이너화된 앱을 배치하고 관리할 수 있습니다. 컨테이너화된 앱은 작업자 노드라고 하는 IBM Cloud 인프라(SoftLayer) 컴퓨팅 호스트에서 호스팅됩니다. 컴퓨팅 호스트를 공유 또는 전용 리소스가 있는 [가상 머신](/docs/containers?topic=containers-plan_clusters#vm)으로 프로비저닝하거나, GPU 및 SDS(Software-Defined Storage) 사용량에 맞게 최적화할 수 있는 [베어메탈 머신](/docs/containers?topic=containers-plan_clusters#bm)으로 프로비저닝하도록 선택할 수 있습니다. 작업자 노드는 IBM에서 구성, 모니터링 및 관리하는 높은 가용성의 구성 마스터를 통해 제어됩니다. {{site.data.keyword.containerlong_notm}} API 또는 CLI는 클러스터 인프라 리소스를 처리하는 데 사용하고, Kubernetes API 또는 CLI는 배치 및 서비스를 관리하는 데 사용할 수 있습니다. 

클러스터 리소스 설정 방법에 대한 자세한 정보는 [서비스 아키텍처](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture)를 참조하십시오. 기능 및 이점 목록을 찾으려면 [{{site.data.keyword.containerlong_notm}}를 선택해야 하는 이유](/docs/containers?topic=containers-cs_ov#cs_ov)를 참조하십시오.

## IBM Cloud Kubernetes Service를 사용해야 하는 이유는 무엇입니까?
{: #faq_benefits}
{: faq}

{{site.data.keyword.containerlong_notm}}는 신속한 앱 제공을 위해 강력한 도구, 직관적인 사용자 환경 및 기본 제공 보안을 제공하는 관리되는 Kubernetes 오퍼링으로, IBM Watson®, AI, IoT, DevOps, 보안 및 데이터 분석 관련 클라우드 서비스에 바인딩할 수 있습니다. {{site.data.keyword.containerlong_notm}}는 공인된 Kubernetes 제공자로서, 지능형 스케줄링, 자가 수리, 수평적 확장, 서비스 검색 및 로드 밸런싱, 자동화된 롤아웃 및 롤백, 시크릿 및 구성 관리를 제공합니다. 이 서비스는 또한 단순화된 클러스터 관리, 컨테이너 보안 및 격리 정책에 기반한 고급 기능, 자체 클러스터 디자인 기능 및 배치 일관성을 위한 통합 운영 도구도 제공합니다.

기능 및 이점에 대한 자세한 내용은 [{{site.data.keyword.containerlong_notm}}를 선택해야 하는 이유](/docs/containers?topic=containers-cs_ov#cs_ov)를 참조하십시오. 

## 서비스는 관리되는 Kubernetes 마스터 및 작업자 노드와 함께 제공됩니까?
{: #managed_master_worker}
{: faq}

{{site.data.keyword.containerlong_notm}}의 모든 Kubernetes 클러스터는 IBM에서 IBM 소유 {{site.data.keyword.Bluemix_notm}} 인프라 계정으로 관리하는 전용 Kubernetes 마스터에 의해 제어됩니다. Kubernetes 마스터(모든 마스터 컴포넌트, 컴퓨팅, 네트워킹 및 스토리지 리소스 포함)는 IBM 사이트 신뢰성 엔지니어(SRE)에 의해 지속적으로 모니터링됩니다. SRE는 최신 보안 표준을 적용하고, 악성 활동을 발견하고 교정하며 {{site.data.keyword.containerlong_notm}}의 신뢰성 및 가용성을 보장하기 위해 작업을 수행합니다. 클러스터를 프로비저닝할 때 자동으로 설치되는 추가 기능(예: 로깅을 위한 Fluentd)은 IBM에서 자동으로 업데이트합니다. 그러나 일부 추가 기능에 대한 자동 업데이트를 사용 안함으로 설정하고 마스터 및 작업자 노드와 별도로 수동으로 업데이트할 수 있습니다. 자세한 정보는 [클러스터 추가 기능 업데이트](/docs/containers?topic=containers-update#addons)를 참조하십시오. 

주기적으로, Kubernetes는 [주 버전 업데이트, 부 버전 업데이트 또는 패치 업데이트](/docs/containers?topic=containers-cs_versions#version_types)를 릴리스합니다. 이러한 업데이트는 Kubernetes 마스터의 Kubernetes API 서버 버전 또는 다른 컴포넌트에 영향을 줄 수 있습니다. 패치 버전은 IBM에서 자동으로 업데이트하지만, 마스터 주 버전과 부 버전은 사용자가 업데이트해야 합니다. 자세한 정보는 [Kubernetes 마스터 업데이트](/docs/containers?topic=containers-update#master)를 참조하십시오. 

표준 클러스터의 작업자 노드는 {{site.data.keyword.Bluemix_notm}} 인프라 계정에 프로비전됩니다. 작업자 노드는 사용자 계정 전용이며 사용자는 작업자 노드 OS 및 {{site.data.keyword.containerlong_notm}} 컴포넌트가 최신 보안 업데이트와 패치를 적용하도록 보장하기 위해 작업자 노드에 대한 시기 적절한 업데이트를 요청할 책임이 있습니다. 보안 업데이트 및 패치는 취약성 및 보안 규제 준수 문제를 발견하기 위해 작업자 노드에 설치된 Linux 이미지를 지속적으로 모니터링하는 IBM 사이트 신뢰성 엔지니어(SRE)가 제공합니다. 자세한 정보는 [작업자 노드 업데이트](/docs/containers?topic=containers-update#worker_node)를 참조하십시오. 

## Kubernetes 마스터 및 작업자 노드는 고가용성 노드입니까?
{: #faq_ha}
{: faq}

{{site.data.keyword.containerlong_notm}} 아키텍처 및 인프라는 신뢰성, 짧은 처리 대기 시간 및 최대 가동 시간을 보장하도록 디자인되었습니다. 기본적으로, Kubernetes 버전 1.10 이상을 실행하는 {{site.data.keyword.containerlong_notm}}의 모든 클러스터는 Kubernetes 마스터 인스턴스 중 하나 이상이 사용 불가능하더라도 클러스터 리소스의 가용성과 접근성을 보장하기 위해 다중 Kubernetes 마스터 인스턴스를 사용하도록 설정되었습니다. 

지역의 다중 구역에 있는 다중 작업자 노드에 워크로드를 분산시키면 클러스터의 고가용성을 높이고 앱을 작동 중단 시간으로부터 보호할 수 있습니다. 이 설정을 [다중 구역 클러스터](/docs/containers?topic=containers-plan_clusters#multizone)라고 하며, 이 설정을 사용하면 작업자 노드 또는 전체 구역을 사용할 수 없는 경우에도 앱에 액세스할 수 있습니다. 

전체 지역 실패로부터 보호하려면 [다중 클러스터를 작성하고 이를 {{site.data.keyword.containerlong_notm}} 지역 전체에 분산](/docs/containers?topic=containers-plan_clusters#multiple_clusters)시키십시오. 클러스터에 대해 로드 밸런서를 설정하면 클러스터에 대해 교차 지역 로드 밸런싱 및 교차 지역 네트워킹을 구현할 수 있습니다. 

가동 중단이 발생하더라도 반드시 사용 가능해야 하는 데이터가 있는 경우에는 데이터를 [지속적 스토리지](/docs/containers?topic=containers-storage_planning#storage_planning)에 저장해야 합니다. 

클러스터에 대해 고가용성을 달성하는 자세한 방법은 [{{site.data.keyword.containerlong_notm}}의 고가용성](/docs/containers?topic=containers-ha#ha)을 참조하십시오. 

## 내 클러스터를 보안 설정하기 위한 옵션에는 무엇이 있습니까?
{: #secure_cluster}
{: faq}

{{site.data.keyword.containerlong_notm}}의 기본 제공 보안 기능을 사용하면 클러스터의 컴포넌트, 데이터 및 앱 배치를 보호하여 보안 준수 및 데이터 무결성을 보장할 수 있습니다. Kubernetes API 서버, etcd 데이터 저장소, 작업자 노드, 네트워크, 스토리지, 이미지 및 배치를 악의적인 공격으로부터 보호하려면 이 기능을 사용하십시오. 기본 제공 로깅 및 모니터링 도구를 사용하여 악의적인 공격과 의심스러운 사용량 패턴을 발견할 수도 있습니다. 

클러스터 컴포넌트 및 각 클러스터의 보안 방법에 대한 자세한 정보는 [{{site.data.keyword.containerlong_notm}}에 대한 보안](/docs/containers?topic=containers-security#security)을 참조하십시오. 

## 클러스터에 영향을 주는 보안 게시판 목록은 어디에서 찾을 수 있습니까? 
{: #faq_security_bulletins}
{: faq}

Kubernetes에서 취약성이 발견되면 Kubernetes는 보안 게시판에 CVE를 릴리스하여 사용자에게 알리고 사용자가 취약성을 해결하기 위해 수행해야 하는 조치에 대해 설명합니다. {{site.data.keyword.containerlong_notm}} 사용자 또는 {{site.data.keyword.Bluemix_notm}} 플랫폼에 영향을 미치는 Kubernetes 보안 게시판은 [{{site.data.keyword.Bluemix_notm}} 보안 게시판](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security)에서 공개됩니다. 

일부 CVE는 {{site.data.keyword.containerlong_notm}}의 정기 [클러스터 업데이트 프로세스](/docs/containers?topic=containers-update#update)의 파트로 설치할 수 있는 Kubernetes 버전의 최신 패치 업데이트가 필요합니다. 악성 공격으로부터 클러스터를 보호하려면 적시에 보안 패치를 적용해야 합니다. 보안 패치에 포함된 내용에 대한 정보는 [버전 변경 로그](/docs/containers?topic=containers-changelog#changelog)를 참조하십시오. 

## 서비스가 베어메탈 및 GPU에 대한 지원을 제공합니까? 
{: #bare_metal_gpu}
{: faq}

예, 작업자 노드를 싱글 테넌트 실제 베어메탈 서버로 프로비저닝할 수 있습니다. 베어메탈 서버는 데이터, AI 및 GPU와 같은 워크로드에 대해 뛰어난 성능 이점을 제공합니다. 또한 모든 하드웨어 리소스가 사용자의 워크로드 전용으로 사용되므로 "사용량이 많은 다른 항목(noisy neighbors)"문제를 신경쓰지 않아도 됩니다.

사용 가능한 베어메탈 특성 및 베어메탈과 가상 버신의 차이점에 대한 자세한 정보는 [실제 머신(베어메탈)](/docs/containers?topic=containers-plan_clusters#bm)을 참조하십시오.

## 서비스가 지원하는 Kubernetes 버전은 무엇입니까? 
{: #supported_kube_versions}
{: faq}

{{site.data.keyword.containerlong_notm}}는 동시에 여러 Kubernetes 버전을 지원합니다. 최신 버전이 릴리스될 때 최대 두 개의 이전 버전이(n-2)이 지원됩니다. 최신 버전보다 세 개 이상 이전인 버전(n-3)은 먼저 더 이상 사용되지 않게 되고 그런 다음 지원되지 않게 됩니다. 현재 지원되는 버전은 다음과 같습니다. 

- 최신: 1.13.4
- 기본: 1.12.6
- 기타: 1.11.8

지원되는 버전 및 한 버전에서 다른 버전으로 이동하기 위해 수행해야 하는 업데이트 조치에 대한 자세한 정보는 [버전 정보 및 업데이트 조치](/docs/containers?topic=containers-cs_versions#cs_versions)를 참조하십시오.

## 서비스는 어디에서 사용 가능합니까?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}}는 전 세계에서 사용 가능합니다. 지원되는 모든 {{site.data.keyword.containerlong_notm}} 지역에서 표준 클러스터를 작성할 수 있습니다. 무료 클러스터는 선택된 지역에서만 사용 가능합니다.

지원되는 지역에 대한 자세한 정보는 [지역 및 구역](/docs/containers?topic=containers-regions-and-zones#regions-and-zones)을 참조하십시오.

## 서비스가 따라야 하는 표준은 무엇입니까? 
{: #standards}
{: faq}

{{site.data.keyword.containerlong_notm}}는 다음 표준에 상응하는 제어를 구현합니다. 
- HIPAA(Health Insurance Portability and Accountability Act)
- Service Organization Control 표준(SOC 1, SOC 2 유형 1)
- ISAE(International Standard on Assurance Engagements) 3402, 서비스 조직의 제어에 대한 보증 보고서
- ISO(International Organization for Standardization) 27001, ISO 27017, ISO 27018
- PCI DSS(Payment Card Industry Data Security Standard)

## 내 클러스터에서 IBM Cloud 및 다른 서비스를 사용할 수 있습니까?
{: #faq_integrations}
{: faq}

자동화 사용, 보안 향상 또는 클러스터의 모니터링 및 로깅 기능 향상을 위해 {{site.data.keyword.Bluemix_notm}} 플랫폼 및 인프라 서비스와 서드파티 공급업체의 서비스를 {{site.data.keyword.containerlong_notm}} 클러스터에 추가할 수 있습니다.

지원되는 서비스 목록은 [서비스 통합](/docs/containers?topic=containers-integrations#integrations)을 참조하십시오.

## IBM Cloud Public에 있는 내 클러스터를 온프레미스 데이터 센터에서 실행되는 앱과 연결할 수 있습니까?
{: #hybrid}
{: faq}

{{site.data.keyword.Bluemix_notm}} Public에 있는 서비스를 온프레미스 데이터 센터와 연결하여 사용자 고유의 하이브리드 클라우드 설정을 작성할 수 있습니다. {{site.data.keyword.Bluemix_notm}} Public 및 Private을 온프레미스 데이터 센터에서 실행되는 앱과 함께 활용하는 방식에 대한 예는 다음과 같습니다. 
- {{site.data.keyword.Bluemix_notm}} Public 또는 Dedicated에서 {{site.data.keyword.containerlong_notm}}로 클러스터를 작성하되, 클러스터를 온프레미스 데이터베이스와 연결하려고 합니다.
- Kubernetes 클러스터를 자체 데이터 센터의 {{site.data.keyword.Bluemix_notm}} Private에 작성하고 앱을 클러스터에 배치합니다. 그러나 이 앱이 Tone Analyzer와 같은 {{site.data.keyword.ibmwatson_notm}} 서비스를 {{site.data.keyword.Bluemix_notm}} Public에서 사용할 수 있습니다.

{{site.data.keyword.Bluemix_notm}} Public 또는 Dedicated에서 실행되는 서비스와 온프레미스에서 실행되는 서비스가 서로 통신할 수 있게 하려면 [VPN 연결을 설정](/docs/containers?topic=containers-vpn#vpn)해야 합니다. {{site.data.keyword.Bluemix_notm}} Public 또는 Dedicated 환경을 {{site.data.keyword.Bluemix_notm}} Private 환경과 연결하려면 [{{site.data.keyword.Bluemix_notm}} Private에서 {{site.data.keyword.containerlong_notm}} 사용](/docs/containers?topic=containers-hybrid_iks_icp#hybrid_iks_icp)을 참조하십시오.

지원되는 {{site.data.keyword.containerlong_notm}} 오퍼링의 개요는 [오퍼링 및 오퍼링 조합의 비교](/docs/containers?topic=containers-cs_ov#differentiation)를 참조하십시오.

## IBM Cloud Kubernetes Service를 자체 데이터 센터에 배치할 수 있습니까?
{: #private}
{: faq}

앱을 {{site.data.keyword.Bluemix_notm}} Public 또는 Dedicated로 이동하고 싶지는 않지만, {{site.data.keyword.containerlong_notm}}의 기능은 계속 사용하고 싶은 경우, {{site.data.keyword.Bluemix_notm}} Private을 설치할 수 있습니다. {{site.data.keyword.Bluemix_notm}} Private은 사용자가 자신 머신에 로컬로 설치할 수 있는 애플리케이션 플랫폼으로, 컨테이너화된 온프레미스 앱을 방화벽으로 보호되는 사용자의 고유한 제어 환경에서 개발하고 관리하는 데 사용할 수 있습니다. 

자세한 정보는 [{{site.data.keyword.Bluemix_notm}} Private 제품 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)를 참조하십시오. 

## IBM Cloud Kubernetes Service를 사용할 때 비용이 청구되는 항목에는 무엇이 있습니까?
{: #charges}
{: faq}

{{site.data.keyword.containerlong_notm}} 클러스터를 사용하면 IBM Cloud 인프라(SoftLayer) 컴퓨팅, 네트워킹 및 스토리지 리소스를 Watson AI 또는 Compose DBaaS(Database-as-a-Service)와 같은 플랫폼 서비스와 함께 사용할 수 있습니다. 각 리소스는 해당 비용을 수반할 수 있습니다([고정, 측정, 계층, 예약](/docs/billing-usage?topic=billing-usage-charges#charges)). 
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
  <li><strong>더 긴 주문 프로세스</strong>: 베어메탈 서버를 주문하거나 취소하면 해당 프로세스는 IBM Cloud 인프라(SoftLayer) 계정에서 수동으로 완료됩니다. 그래서 완료하는 데 영업일 기준으로 이틀 이상 걸릴 수 있습니다.</li></ul>
  <p>머신 스펙에 대한 세부사항은 [작업자 노드에 대해 사용 가능한 하드웨어](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)를 참조하십시오.</p></dd>

<dt id="bandwidth">공용 대역폭</dt>
  <dd><p>대역폭은 {{site.data.keyword.Bluemix_notm}} 리소스와 전 세계에 있는 데이터 센터에서의, 인바운드 및 아웃바운드 네트워크 트래픽의 공용 데이터 전송을 가리킵니다. 공용 대역폭은 GB당 비용 청구됩니다. [{{site.data.keyword.Bluemix_notm}} 콘솔](https://cloud.ibm.com/)에 로그인하여 메뉴 ![메뉴 아이콘](../icons/icon_hamburger.svg "메뉴 아이콘")에서 **클래식 인프라**를 선택한 후 **네트워크 > 대역폭 > 요약** 페이지를 선택하여 현재 대역폭 요약을 검토할 수 있습니다.
  <p>공용 대역폭 비용에 영향을 주는 다음 요소를 검토하십시오.</p>
  <ul><li><strong>위치</strong>: 작업자 노드와 마찬가지로, 비용은 리소스가 배치되는 구역에 따라 달라집니다.</li>
  <li><strong>대역폭 포함 또는 종량과금제</strong>: 작업자 노드 머신은 VM에 대해 250GB, 베어메탈에 대해 500GB와 같이 특정한 월별 아웃바운드 네트워킹 할당량과 함께 제공될 수 있습니다. 또는 이 할당이 GB 사용량에 따라 종량과금제가 될 수도 있습니다.</li>
  <li><strong>계층식 패키지</strong>: 포함된 대역폭을 초과하면 위치별로 다른 계층식 사용량 체계에 따라 비용이 청구됩니다. 계층 할당량을 초과하면 표준 데이터 전송 요금 또한 청구될 수 있습니다.</li></ul>
  <p>자세한 정보는 [Bandwidth packages ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/bandwidth)를 참조하십시오.</p></dd>

<dt id="subnets">서브넷 IP 주소</dt>
  <dd><p>표준 클러스터를 작성하면 8개의 공인 IP 주소를 포함하는 이동 가능한 공용 서브넷이 사용자의 계정으로 주문되어 매월 비용 청구됩니다.</p><p>인프라 계정에 이미 사용 가능한 서브넷이 있는 경우에는 이러한 서브넷을 대신 사용할 수 있습니다. `--no-subnets` [플래그](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create)를 사용하여 클러스터를 작성한 후 [서브넷을 재사용](/docs/containers?topic=containers-subnets#subnets_custom)하십시오.</p>
  </dd>

<dt id="storage">스토리지</dt>
  <dd>스토리지를 프로비저닝할 때는 자신의 유스 케이스에 적합한 스토리지 유형 및 스토리지 클래스를 선택할 수 있습니다. 비용은 스토리지 유형, 위치, 스토리지 인스턴스의 스펙에 따라 달라집니다. 파일 및 블록 스토리지와 같은 일부 스토리지 솔루션은 시간별 플랜 및 월별 플랜(둘 중 하나를 선택할 수 있음)을 제공합니다. 적절한 스토리지 솔루션을 선택하려면 [고가용성 지속적 스토리지 계획](/docs/containers?topic=containers-storage_planning#storage_planning)을 참조하십시오. 자세한 정보는 다음을 참조하십시오.
  <ul><li>[NFS 파일 스토리지 가격 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[블록 스토리지 가격 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Object Storage 플랜 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} 서비스</dt>
  <dd>사용자가 클러스터와 통합하는 각 서비스에는 해당 가격 모델이 있습니다. 각 제품 문서를 참조하여 {{site.data.keyword.Bluemix_notm}} 콘솔을 사용하여 [비용을 예상](/docs/billing-usage?topic=billing-usage-cost#cost)하십시오.</dd>

</dl>

월별 리소스는 해당 월의 1일에 이전 월의 사용량에 대해 비용이 청구됩니다. 특정 월의 중간에 월별 리소스를 주문하는 경우에는 해당 월에 대해 비례 계산된 금액이 청구됩니다. 그러나 월 중간에 리소스를 취소하는 경우에는 여전히 해당 월별 리소스에 대한 전체 금액이 청구됩니다.
{: note}

## 플랫폼 및 인프라 리소스가 한 개의 청구서에 통합됩니까?
{: #bill}
{: faq}

청구 가능한 {{site.data.keyword.Bluemix_notm}} 계정을 사용하는 경우 플랫폼 및 인프라 리소스는 한 개의 청구서에 요약됩니다.
{{site.data.keyword.Bluemix_notm}} 및 IBM Cloud 인프라(SoftLayer) 계정을 서로 연결하면 {{site.data.keyword.Bluemix_notm}} 플랫폼 및 인프라 리소스에 대한 [통합 청구서](/docs/customer-portal?topic=customer-portal-unifybillaccounts#unifybillaccounts)를 수신하게 됩니다. 

## 내 비용을 예상해 볼 수 있습니까?
{: #cost_estimate}
{: faq}

예, [비용 예상](/docs/billing-usage?topic=billing-usage-cost#cost)을 참조하십시오. 증가된 시간별 사용량에 대한 계층식 가격과 같은 일부 비용은 예상에 반영되지 않습니다. 자세한 정보는 [{{site.data.keyword.containerlong_notm}}를 사용할 때 비용이 청구되는 항목에는 무엇이 있습니까?](#charges)를 참조하십시오.

## 내 현재 사용량을 확인할 수 있습니까? 
{: #usage}
{: faq}

{{site.data.keyword.Bluemix_notm}} 플랫폼 및 인프라 리소스에 대한 현재 사용량 및 예상 월별 총계를 확인할 수 있습니다. 자세한 정보는 [사용량 보기](/docs/billing-usage?topic=billing-usage-viewingusage#viewingusage)를 참조하십시오. 비용 청구를 구성하기 위해 리소스를 [리소스 그룹](/docs/resources?topic=resources-bp_resourcegroups#bp_resourcegroups)으로 그룹화할 수 있습니다. 
