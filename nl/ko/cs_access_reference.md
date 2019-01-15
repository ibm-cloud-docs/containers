---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"


---

{:new_window: target="blank"}
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

# 사용자 액세스 권한
{: #understanding}



[클러스터 권한을 지정](cs_users.html)할 때는 사용자에게 어느 역할을 지정해야 할지 판단하기 어려울 수 있습니다. 다음 섹션의 표를 사용하여 {{site.data.keyword.containerlong}}에서 일반적인 태스크를 수행하는 데 필요한 최소한의 권한 레벨을 판별하십시오.
{: shortdesc}

## {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 및 Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}}는 {{site.data.keyword.Bluemix_notm}} Identity and Access Management(IAM) 역할을 사용하도록 구성됩니다. {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 역할은 사용자가 클러스터에 대해 수행할 수 있는 조치를 결정합니다. 플랫폼 역할이 지정된 모든 사용자에게는 기본 네임스페이스의 해당 Kubernetes 역할 기반 액세스 제어(RBAC) 역할도 자동으로 지정됩니다. 또한 플랫폼 역할은 사용자의 기본 인프라 권한을 자동으로 설정합니다. 정책을 설정하려면 [{{site.data.keyword.Bluemix_notm}} IAM 플랫폼 권한 지정](cs_users.html#platform)을 참조하십시오. RBAC 역할에 대해 자세히 알아보려면 [RBAC 권한 지정](cs_users.html#role-binding)을 참조하십시오.
{: shortdesc}

다음 표는 각 플랫폼 역할에 의해 부여되는 클러스터 관리 권한과 해당 RBAC 역할에 대한 Kubernetes 리소스 권한을 보여줍니다. 

<table summary="표에서는 IAM 플랫폼 역할과 해당되는 RBAC 정책에 대한 사용자 권한을 보여줍니다. 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며, IAM 플랫폼 역할은 1열에 있고 클러스터 권한은 2열에 있으며 해당되는 RBAC 역할은 3열에 있습니다. ">
<caption>플랫폼 및 RBAC 역할별 클러스터 관리 권한</caption>
<thead>
    <th>플랫폼 역할</th>
    <th>클러스터 관리 권한</th>
    <th>해당 RBAC 역할 및 리소스 권한</th>
</thead>
<tbody>
  <tr>
    <td>**뷰어**</td>
    <td>
      클러스터:<ul>
        <li>리소스 그룹 및 지역에 대해 {{site.data.keyword.Bluemix_notm}} IAM API 키 소유자의 이름 및 이메일 주소 보기</li>
        <li>인프라 사용자 이름 보기({{site.data.keyword.Bluemix_notm}} 계정이 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 데 다른 인증 정보를 사용하는 경우)</li>
        <li>모든 클러스터, 작업자 노드, 작업자 풀, 클러스터 내 서비스, 웹훅을 나열하거나 해당 세부사항 보기</li>
        <li>인프라 계정의 VLAN Spanning 상태 보기</li>
        <li>인프라 계정의 사용 가능한 서브넷 나열</li>
        <li>한 클러스터에 대해 설정된 경우: 구역 내에서 해당 클러스터가 연결된 VLAN 나열</li>
        <li>계정 내 모든 클러스터에 대해 설정된 경우: 구역 내의 모든 사용 가능한 VLAN 나열</li></ul>
      로깅:<ul>
        <li>대상 지역의 기본 로깅 엔드포인트 보기</li>
        <li>로그 전달 및 필터링 구성 나열 또는 세부사항 보기</li>
        <li>Fluentd 추가 기능에 대한 자동 업데이트의 상태 보기</li></ul>
Ingress:<ul>
        <li>클러스터 내 모든 ALB 나열 또는 세부사항 보기</li>
        <li>지역에서 지원되는 ALB 유형 보기</li></ul>
    </td>
    <td><code>view</code> 클러스터 역할은 <code>ibm-view</code> 역할 바인딩에 의해 적용되며, <code>default</code> 네임스페이스에서 다음 권한을 제공합니다.<ul>
      <li>기본 네임스페이스 내부의 리소스에 대한 읽기 액세스 권한</li>
      <li>Kubernetes 시크릿에 대한 읽기 액세스 권한 없음</li></ul>
    </td>
  </tr>
  <tr>
    <td>**편집자** <br/><br/><strong>팁</strong>: 이 역할은 앱 개발자에 대해 사용하고, <a href="#cloud-foundry">Cloud Foundry</a> **개발자** 역할을 지정하십시오.</td>
    <td>이 역할에는 뷰어 역할의 모든 권한이 있으며 그 외에 다음 권한이 포함되어 있습니다.</br></br>
      클러스터:<ul>
        <li>{{site.data.keyword.Bluemix_notm}} 서비스를 클러스터에 바인드하거나 바인드를 해제함</li></ul>
      로깅:<ul>
        <li>API 서버 감사 웹훅 작성, 업데이트 및 삭제</li>
        <li>클러스터 웹훅 작성</li>
        <li>`kube-audit`을 제외한 모든 유형의 로그 전달 구성 작성 및 삭제</li>
        <li>로그 전달 구성 업데이트 및 새로 고치기</li>
        <li>로그 필터링 구성 작성, 업데이트 및 삭제</li></ul>
Ingress:<ul>
        <li>ALB 사용 또는 사용 안함 설정</li></ul>
    </td>
    <td><code>edit</code> 클러스터 역할은 <code>ibm-edit</code> 역할 바인딩에 의해 적용되며, <code>default</code> 네임스페이스에서 다음 권한을 제공합니다.
      <ul><li>기본 네임스페이스 내부의 리소스에 대한 읽기/쓰기 액세스 권한</li></ul></td>
  </tr>
  <tr>
    <td>**운영자**</td>
    <td>이 역할에는 뷰어 역할의 모든 권한이 있으며 그 외에 다음 권한이 포함되어 있습니다.</br></br>
      클러스터:<ul>
        <li>클러스터 업데이트</li>
        <li>Kubernetes 마스터 새로 고치기</li>
        <li>작업자 노드 추가 및 제거</li>
        <li>작업자 노드 다시 부팅, 다시 로드 및 업데이트</li>
        <li>작업자 풀 작성 및 삭제</li>
        <li>작업자 풀에서 구역 추가 및 제거</li>
        <li>작업자 풀에서의 특정 구역에 대한 네트워크 구성 업데이트</li>
        <li>작업자 풀 크기 조정 및 리밸런싱</li>
        <li>서브넷 작성 및 클러스터에 서브넷 추가</li>
        <li>클러스터에서의 사용자 관리 서브넷 추가 및 제거</li></ul>
    </td>
    <td><code>admin</code> 클러스터 역할은 <code>ibm-operate</code> 클러스터 역할 바인딩에 의해 적용되며 다음 권한을 제공합니다.<ul>
      <li>네임스페이스 내 리소스에 대한 읽기/쓰기 액세스 권한(네임스페이스 자체는 해당되지 않음)</li>
      <li>네임스페이스 내에서의 RBAC 역할 작성</li></ul></td>
  </tr>
  <tr>
    <td>**관리자**</td>
    <td>이 역할에는 이 계정의 모든 클러스터에 대한 편집자, 운영자 및 뷰어 역할의 모든 권한이 있으며, 그 외에도 다음 권한이 있습니다.</br></br>
      클러스터:<ul>
        <li>무료 또는 표준 클러스터 작성</li>
        <li>클러스터 삭제</li>
        <li>{{site.data.keyword.keymanagementservicefull}}를 사용한 Kubernetes secret 암호화</li>
        <li>연결된 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하기 위한 {{site.data.keyword.Bluemix_notm}} 계정의 API 키 설정</li>
        <li>다른 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하기 위한 {{site.data.keyword.Bluemix_notm}} 계정의 인프라 인증 정보 설정, 보기 및 제거</li>
        <li>계정의 기타 기존 사용자에 대한 {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 역할 지정 및 변경</li>
        <li>모든 지역의 모든 {{site.data.keyword.containerlong_notm}} 인스턴스(클러스터)에 대해 설정된 경우: 계정 내의 모든 사용 가능한 VLAN 나열</ul>
      로깅:<ul>
        <li>유형 `kube-audit`의 로그 전달 구성 작성 및 삭제</li>
        <li>{{site.data.keyword.cos_full_notm}} 버킷의 API 서버 로그 스냅샷 수집</li>
        <li>Fluentd 클러스터 추가 기능에 대한 자동 업데이트의 사용 또는 사용 안함 설정</li></ul>
Ingress:<ul>
        <li>클러스터 내 모든 ALB 시크릿 나열 또는 세부사항 보기</li>
        <li>{{site.data.keyword.cloudcerts_long_notm}} 인스턴스에서 ALB로 인증서 배치</li>
        <li>클러스터에서 ALB 시크릿 업데이트 또는 제거</li></ul>
      <p class="note">머신, VLAN 및 서브넷과 같은 리소스를 작성하려면 관리자에게 **수퍼유저** 인프라 역할이 필요합니다. </p>
    </td>
    <td><code>cluster-admin</code> 클러스터 역할은 <code>ibm-admin</code> 클러스터 역할 바인딩에 의해 적용되며 다음 권한을 제공합니다.
      <ul><li>모든 네임스페이스의 리소스에 대한 읽기/쓰기 액세스 권한</li>
      <li>네임스페이스 내에서의 RBAC 역할 작성</li>
      <li>Kubernetes 대시보드에 액세스</li>
      <li>앱을 공용으로 사용할 수 있도록 하는 Ingress 리소스 작성</li></ul>
    </td>
  </tr>
  </tbody>
</table>



## Cloud Foundry 역할
{: #cloud-foundry}

Cloud Foundry 역할은 계정 내 조직 및 영역에 대한 액세스 권한을 부여합니다. {{site.data.keyword.Bluemix_notm}}에 있는 Cloud Foundry 기반 서비스의 목록을 보려면 `ibmcloud service list`를 실행하십시오. 보다 자세히 알아보려면 {{site.data.keyword.Bluemix_notm}} IAM 문서에서 사용 가능한 모든 [조직 및 영역 역할](/docs/iam/cfaccess.html) 또는 [Cloud Foundry 액세스 권한 관리](/docs/iam/mngcf.html) 단계를 참조하십시오.
{: shortdesc}

다음 표에는 클러스터 조치 권한에 필요한 Cloud Foundry 역할이 표시되어 있습니다.

<table summary="표에서는 Cloud Foundry에 대한 사용자 권한을 보여줍니다. 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며, Cloud Foundry 역할은 1열에 있고 클러스터 권한은 2열에 있습니다. ">
  <caption>Cloud Foundry 역할별 클러스터 관리 권한</caption>
  <thead>
    <th>Cloud Foundry 역할</th>
    <th>클러스터 관리 권한</th>
  </thead>
  <tbody>
  <tr>
    <td>영역 역할: 관리자</td>
    <td>{{site.data.keyword.Bluemix_notm}} 영역에 대한 사용자 액세스 관리</td>
  </tr>
  <tr>
    <td>영역 역할: 개발자</td>
    <td>
      <ul><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스 작성</li>
      <li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스를 클러스터에 바인드</li>
      <li>영역 레벨에서 클러스터의 로그 전달 구성의 로그 보기</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## 인프라 역할
{: #infra}

**수퍼유저** 인프라 액세스 역할이 있는 사용자가 [지역 및 리소스 그룹의 API를 설정](cs_users.html#api_key)하는 경우, 계정의 기타 사용자에 대한 인프라 권한은 {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 역할에 의해 설정됩니다. 사용자가 다른 사용자의 IBM Cloud 인프라(SoftLayer) 권한을 편집할 필요는 없습니다. API 키를 설정하는 사용자에게 **수퍼유저**를 지정할 수 없는 경우에만 다음 표를 사용하여 사용자의 IBM Cloud 인프라(SoftLayer) 권한을 사용자 정의하십시오. 자세한 정보는 [인프라 권한 사용자 정의](cs_users.html#infra_access)를 참조하십시오.
{: shortdesc}

다음 표는 일반적인 태스크 그룹을 완료하는 데 필요한 인프라 권한을 보여줍니다.

<table summary="공통 {{site.data.keyword.containerlong_notm}} 시나리오에 대한 인프라 권한">
 <caption>{{site.data.keyword.containerlong_notm}}에 공통으로 필요한 인프라 권한</caption>
 <thead>
  <th>{{site.data.keyword.containerlong_notm}}의 공통 태스크</th>
  <th>탭에서 필요한 인프라 권한</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>최소 권한</strong>: <ul><li>클러스터 작성.</li></ul></td>
     <td><strong>디바이스</strong>:<ul><li>Virtual Server 세부사항 보기</li><li>서버 다시 부팅 및 IPMI 시스템 정보 보기</li><li>OS 다시 로드 실행 및 복구 커널 시작</li></ul><strong>계정</strong>: <ul><li>서버 추가</li></ul></td>
   </tr>
   <tr>
     <td><strong>클러스터 관리</strong>: <ul><li>클러스터 작성, 업데이트 및 삭제</li><li>작업자 노드 추가, 다시 로드 및 다시 부팅</li><li>VLAN 보기</li><li>서브넷 작성</li><li>팟(Pod) 및 로드 밸런서 서비스 배치</li></ul></td>
     <td><strong>지원</strong>:<ul><li>티켓 보기</li><li>티켓 추가</li><li>티켓 편집</li></ul>
     <strong>디바이스</strong>:<ul><li>하드웨어 세부사항 보기</li><li>Virtual Server 세부사항 보기</li><li>서버 다시 부팅 및 IPMI 시스템 정보 보기</li><li>OS 다시 로드 실행 및 복구 커널 시작</li></ul>
     <strong>네트워크</strong>:<ul><li>공용 네트워크 포트로 컴퓨팅 추가</li></ul>
     <strong>계정</strong>:<ul><li>서버 취소</li><li>서버 추가</li></ul></td>
   </tr>
   <tr>
     <td><strong>스토리지</strong>: <ul><li>지속적 볼륨 클레임을 작성하여 지속적 볼륨 프로비저닝</li><li>스토리지 인프라 리소스 작성 및 관리</li></ul></td>
     <td><strong>서비스</strong>:<ul><li>스토리지 관리</li></ul><strong>계정</strong>:<ul><li>스토리지 추가</li></ul></td>
   </tr>
   <tr>
     <td><strong>사설 네트워크</strong>: <ul><li>클러스터 내부 네트워킹을 위한 사설 VLAN 관리</li><li>VPN 연결을 사설 네트워크에 설정</li></ul></td>
     <td><strong>네트워크</strong>:<ul><li>네트워크 서브넷 라우트 관리</li></ul></td>
   </tr>
   <tr>
     <td><strong>사설 네트워킹</strong>:<ul><li>공용 로드 밸런서 또는 Ingress 네트워킹을 설정하여 앱 노출</li></ul></td>
     <td><strong>디바이스</strong>:<ul><li>호스트 이름/도메인 편집</li><li>포트 제어 관리</li></ul>
     <strong>네트워크</strong>:<ul><li>공용 네트워크 포트로 컴퓨팅 추가</li><li>네트워크 서브넷 라우트 관리</li><li>IP 주소 추가</li></ul>
     <strong>서비스</strong>:<ul><li>DNS, 리버스 DNS 및 WHOIS 관리</li><li>인증서(SSL) 보기</li><li>인증서(SSL) 관리</li></ul></td>
   </tr>
 </tbody>
</table>
