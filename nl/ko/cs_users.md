---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터에 사용자 액세스 지정
{: #users}

권한 부여된 사용자만 클러스터 관련 작업을 수행하고 클러스터에 앱을 배치할 수 있도록 조직의 다른 사용자에게 클러스터에 대한 액세스 권한을 부여할 수 있습니다.
{:shortdesc}




## 클러스터 액세스 관리
{: #managing}

{{site.data.keyword.containershort_notm}}로 작업하는 모든 사용자에게 해당 사용자가 수행할 수 있는 조치를 판별하는 서비스 특정 사용자 역할의 조합이 지정되어야 합니다.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 액세스 정책</dt>
<dd>Identity and Access Management에서 {{site.data.keyword.containershort_notm}} 액세스 정책은 클러스터에 대해 수행할 수 있는 클러스터 관리 조치(예: 클러스터 작성 또는 제거, 추가 작업 노드 추가 또는 제거)를 판별합니다. 이러한 정책은 인프라 정책과 함께 설정되어야 합니다.</dd>
<dt>인프라 액세스 정책</dt>
<dd>Identity and Access Management에서 인프라 액세스 정책은 {{site.data.keyword.containershort_notm}} 사용자 인터페이스 또는 CLI에서 요청되는 조치가 IBM Cloud 인프라(SoftLayer)에서 완료될 수 있도록 허용합니다. 이러한 정책은 {{site.data.keyword.containershort_notm}} 액세스 정책과 함께 설정되어야 합니다. [사용 가능한 인프라 역할에 대해 자세히 알아보십시오](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>리소스 그룹</dt>
<dd>리소스 그룹은 한 번에 둘 이상의 리소스에 사용자 액세스를 신속하게 지정할 수 있도록 {{site.data.keyword.Bluemix_notm}} 서비스를 그룹으로 구성하는 방법입니다. [리소스 그룹을 사용하여 사용자를 관리하는 방법을 학습](/docs/admin/resourcegroups.html#rgs)하십시오.</dd>
<dt>Cloud Foundry 역할</dt>
<dd>Identity and Access Management에서 모든 사용자에게 Cloud Foundry 사용자 역할이 지정되어야 합니다. 이 역할은 사용자가 {{site.data.keyword.Bluemix_notm}} 계정에서 수행할 수 있는 조치(예: 다른 사용자 초대 또는 할당 사용량 보기)를 판별합니다. [사용 가능한 Cloud Foundry 역할에 대해 자세히 알아보십시오](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Kubernetes RBAC 역할</dt>
<dd>{{site.data.keyword.containershort_notm}} 액세스 정책이 지정된 모든 사용자는 자동으로 Kubernetes RBAC 역할이 지정됩니다. Kubernetes에서 RBAC 역할은 클러스터 내부의 Kubernetes 리소스에서 수행할 수 있는 조치를 판별합니다. RBAC 역할은 기본 네임스페이스에 대해서만 설정됩니다. 클러스터 관리자는 클러스터에서 다른 네임스페이스에 대한 RBAC 역할을 추가할 수 있습니다. 자세한 정보는 Kubernetes 문서의 [RBAC 인증 사용![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)을 참조하십시오.</dd>
</dl>

<br />


## 액세스 정책 및 권한
{: #access_policies}

{{site.data.keyword.Bluemix_notm}} 계정에서 사용자에게 권한을 부여할 수 있는 액세스 정책 및 권한을 검토하십시오. 운영자 및 편집자 역할에는 별도의 권한이 있습니다. 예를 들어, 사용자가 작업자 노드를 추가하고 서비스를 바인드하게 하려면 운영자와 편집자 역할 둘 다를 사용자에게 지정해야 합니다.

|{{site.data.keyword.containershort_notm}} 액세스 정책|클러스터 관리 권한|Kubernetes 리소스 권한|
|-------------|------------------------------|-------------------------------|
|관리자|이 역할은 이 계정의 모든 클러스터에 대한 편집자, 운영자 및 뷰어 역할에서 권한을 상속합니다. <br/><br/>모든 현재 서비스 인스턴스에 대해서 설정된 경우:<ul><li>라이트 또는 표준 클러스터 작성</li><li>IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하도록 {{site.data.keyword.Bluemix_notm}} 계정의 신임 정보 설정</li><li>클러스터 제거</li><li>이 계정의 다른 기존 사용자에 대한 {{site.data.keyword.containershort_notm}} 액세스 정책 지정 및 변경.</li></ul><p>특정 클러스터 ID에 대해 설정된 경우:<ul><li>특정 클러스터 제거</li></ul></p>해당 인프라 액세스 정책: 수퍼유저<br/><br/><b>참고</b>: 시스템, VLAN 및 서브넷과 같은 리소스를 작성하려면 사용자에게 **수퍼유저** 인프라 역할이 필요합니다.|<ul><li>RBAC 역할: cluster-admin</li><li>모든 네임스페이스의 리소스에 대한 읽기/쓰기 액세스 권한</li><li>네임스페이스 내에서 역할 작성</li><li>Kubernetes 대시보드에 액세스</li><li>앱을 공용으로 사용할 수 있도록 하는 Ingress 리소스 작성</li></ul>|
|운영자|<ul><li>추가 작업자 노드를 클러스터에 추가</li><li>작업자 노드를 클러스터에서 제거</li><li>작업자 노드를 다시 부팅</li><li>작업자 노드를 다시 로드</li><li>클러스터에 서브넷 추가</li></ul><p>해당 인프라 액세스 정책: 기본 사용자</p>|<ul><li>RBAC 역할: 관리</li><li>기본 네임스페이스 내의 리소스에 대한 읽기/쓰기 액세스 권한(네임스페이스 자체에는 해당되지 않음)</li><li>네임스페이스 내에서 역할 작성</li></ul>|
|편집자 <br/><br/><b>팁</b>: 앱 개발자의 경우 이 역할을 사용하십시오.|<ul><li>클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스 바인드.</li><li>클러스터에 대한 {{site.data.keyword.Bluemix_notm}} 서비스 바인드 해제.</li><li>웹훅을 작성합니다.</li></ul><p>해당 인프라 액세스 정책: 기본 사용자|<ul><li>RBAC 역할: 편집</li><li>기본 네임스페이스 내부의 리소스에 대한 읽기/쓰기 액세스 권한</li></ul></p>|
|뷰어|<ul><li>클러스터 나열</li><li>클러스터의 세부사항 보기</li></ul><p>해당 인프라 액세스 정책: 보기 전용</p>|<ul><li>RBAC 역할: 보기</li><li>기본 네임스페이스 내부의 리소스에 대한 읽기 액세스 권한</li><li>Kubernetes 시크릿에 대한 읽기 액세스 권한 없음</li></ul>|

|Cloud Foundry 액세스 정책|계정 관리 권한|
|-------------|------------------------------|
|조직 역할: 관리자|<ul><li>{{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가</li></ul>| |
|영역 역할: 개발자|<ul><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스 작성</li><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스를 클러스터에 바인드</li></ul>| 

<br />


## {{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가
{: #add_users}

{{site.data.keyword.Bluemix_notm}} 계정에 사용자를 추가하여 클러스터에 액세스를 부여할 수 있습니다.

시작하기 전에 {{site.data.keyword.Bluemix_notm}} 계정의 관리자 Cloud Foundry 역할이 지정되어 있는지 확인하십시오.

1.  [사용자를 계정에 추가](../iam/iamuserinv.html#iamuserinv)하십시오.
2.  **액세스** 섹션에서 **서비스**를 펼치십시오.
3.  {{site.data.keyword.containershort_notm}} 액세스 역할을 지정하십시오. **액세스 지정 대상** 드롭 다운 목록에서 {{site.data.keyword.containershort_notm}} 계정(**리소스**)에만 액세스를 부여할지 아니면 계정 내 다양한 리소스의 콜렉션(**리소스 그룹**)에 액세스를 지정할지를 결정하십시오.
  -  **리소스**의 경우:
      1. **서비스** 드롭 다운 목록에서 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
      2. **지역** 드롭 다운 목록에서 사용자를 초대할 지역을 선택하십시오.
      3. **서비스 인스턴스** 드롭 다운 목록에서 사용자를 초대할 클러스터를 선택하십시오. 특정 클러스터의 ID를 찾으려면 `bx cs clusters`를 실행하십시오.
      4. **역할 선택** 섹션에서 역할을 선택하십시오. 역할에 대해 지원되는 조치 목록을 찾으려면 [액세스 정책 및 권한](#access_policies)을 참조하십시오.
  - **리소스 그룹**의 경우:
      1. **리소스 그룹** 드롭 다운 목록에서 계정의 {{site.data.keyword.containershort_notm}} 리소스 권한이 포함된 리소스 그룹을 선택하십시오.
      2. **리소스 그룹에 액세스 지정** 드롭 다운 목록에서 역할을 선택하십시오. 역할에 대해 지원되는 조치 목록을 찾으려면 [액세스 정책 및 권한](#access_policies)을 참조하십시오.
4. [선택사항: 인프라 역할을 지정](/docs/iam/mnginfra.html#managing-infrastructure-access)하십시오.
5. [선택사항: Cloud Foundry 역할을 지정](/docs/iam/mngcf.html#mngcf)하십시오.
5. **사용자 초대**를 클릭하십시오.

<br />


## 사용자의 인프라 권한 사용자 정의
{: #infra_access}

Identity and Access Management에서 인프라 정책을 설정할 때 사용자에게 역할과 연관된 권한이 부여됩니다. 해당 권한을 사용자 정의하려면 IBM Cloud 인프라(SoftLayer)에 로그인하고 거기에서 권한을 조정해야 합니다.
{: #view_access}

예를 들어, 기본 사용자는 작업자 노드를 다시 부팅할 수 있지만 작업자 노드를 다시 로드할 수는 없습니다. 사용자에게 수퍼유저 권한을 부여하지 않고 IBM Cloud 인프라(SoftLayer) 권한을 조정하여 다시 로드 명령을 실행할 권한을 추가할 수 있습니다.

1.  IBM Cloud 인프라(SoftLayer) 계정에 로그인하십시오.
2.  업데이트할 사용자 프로파일을 선택하십시오.
3.  **포털 권한**에서 사용자의 액세스 권한을 사용자 정의하십시오. 예를 들어, 다시 로드 권한을 추가하려면 **디바이스** 탭에서 **OS 다시 로드 실행 및 복구 커널 시작**을 선택하십시오.
9.  변경사항을 저장하십시오.
