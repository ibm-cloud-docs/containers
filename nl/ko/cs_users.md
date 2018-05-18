---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


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

권한 부여된 사용자만 클러스터 관련 작업을 수행하고 {{site.data.keyword.containerlong}}의 클러스터에 컨테이너를 배치할 수 있도록 Kubernetes 클러스터에 대한 액세스 권한을 부여할 수 있습니다.
{:shortdesc}


## 통신 프로세스 계획
클러스터 관리자는 구성된 상태로 유지할 수 있도록 사용자 조직의 멤버를 위해 통신 프로세스를 설정하는 방법을 고려합니다.
{:shortdesc}

클러스터에 대한 액세스 권한 요청 방법 또는 클러스터 관리자로부터 모든 유형의 공통 태스크에 대한 도움말을 얻는 방법에 대한 지시사항을 클러스터 사용자에게 제공하십시오. Kubernetes가 이 통신 유형을 활용하지 않으므로 각 팀이 선호하는 프로세스에 따라 차이가 있을 수 있습니다. 

다음 방법 중 하나를 선택하거나 고유한 방법을 설정할 수 있습니다. 
- 티켓 시스템 작성
- 양식 템플리트 작성
- 위키 페이지 작성
- 이메일 요청 필요
- 팀의 일일 작업을 추적하는 데 이미 사용하고 있는 문제 추적 방법 사용


## 클러스터 액세스 관리
{: #managing}

{{site.data.keyword.containershort_notm}}로 작업하는 모든 사용자에게 해당 사용자가 수행할 수 있는 조치를 판별하는 서비스 특정 사용자 역할의 조합이 지정되어야 합니다.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 액세스 정책</dt>
<dd>Identity and Access Management에서 {{site.data.keyword.containershort_notm}} 액세스 정책은 클러스터에 대해 수행할 수 있는 클러스터 관리 조치(예: 클러스터 작성 또는 제거, 추가 작업 노드 추가 또는 제거)를 판별합니다. 이러한 정책은 인프라 정책과 함께 설정되어야 합니다. 지역별로 클러스터에 대한 액세스 권한을 부여할 수 있습니다.</dd>
<dt>인프라 액세스 정책</dt>
<dd>Identity and Access Management에서 인프라 액세스 정책은 {{site.data.keyword.containershort_notm}} 사용자 인터페이스 또는 CLI에서 요청되는 조치가 IBM Cloud 인프라(SoftLayer)에서 완료될 수 있도록 허용합니다. 이러한 정책은 {{site.data.keyword.containershort_notm}} 액세스 정책과 함께 설정되어야 합니다. [사용 가능한 인프라 역할에 대해 자세히 알아보십시오](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>리소스 그룹</dt>
<dd>리소스 그룹은 한 번에 둘 이상의 리소스에 사용자 액세스를 신속하게 지정할 수 있도록 {{site.data.keyword.Bluemix_notm}} 서비스를 그룹으로 구성하는 방법입니다. [리소스 그룹을 사용하여 사용자를 관리하는 방법을 학습](/docs/account/resourcegroups.html#rgs)하십시오.</dd>
<dt>Cloud Foundry 역할</dt>
<dd>Identity and Access Management에서 모든 사용자에게 Cloud Foundry 사용자 역할이 지정되어야 합니다. 이 역할은 사용자가 {{site.data.keyword.Bluemix_notm}} 계정에서 수행할 수 있는 조치(예: 다른 사용자 초대 또는 할당 사용량 보기)를 판별합니다. [사용 가능한 Cloud Foundry 역할에 대해 자세히 알아보십시오](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Kubernetes RBAC 역할</dt>
<dd>{{site.data.keyword.containershort_notm}} 액세스 정책이 지정된 모든 사용자는 자동으로 Kubernetes RBAC 역할이 지정됩니다.  Kubernetes에서 RBAC 역할은 클러스터 내부의 Kubernetes 리소스에서 수행할 수 있는 조치를 판별합니다. RBAC 역할은 기본 네임스페이스에 대해서만 설정됩니다. 클러스터 관리자는 클러스터에서 다른 네임스페이스에 대한 RBAC 역할을 추가할 수 있습니다. 각각의 {{site.data.keyword.containershort_notm}} 액세스 정책에 해당되는 RBAC 역할을 확인하려면 [액세스 정책 및 권한](#access_policies) 섹션에 있는 다음 표를 참조하십시오. 일반적인 RBAC 역할에 대한 자세한 정보는 Kubernetes 문서에 있는 [RBAC 권한 사용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)을 참조하십시오.</dd>
</dl>

<br />


## 액세스 정책 및 권한
{: #access_policies}

{{site.data.keyword.Bluemix_notm}} 계정에서 사용자에게 권한을 부여할 수 있는 액세스 정책 및 권한을 검토하십시오.
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} Identity Access and Management(IAM) 운영자 및 편집자 역할에는 별도의 권한이 있습니다. 예를 들어, 사용자가 작업자 노드를 추가하고 서비스를 바인드하게 하려면 운영자와 편집자 역할 둘 다를 사용자에게 지정해야 합니다. 해당 인프라 액세스 정책에 대한 자세한 정보는 [사용자를 위한 인프라 권한 사용자 정의](#infra_access)를 참조하십시오.<br/><br/>사용자의 액세스 정책을 변경하면 클러스터의 변경사항과 연관된 RBAC 정책을 정리합니다.</br></br>**참고:** 뷰어 액세스 권한을 이전 클러스터 관리자에게 지정하려는 경우와 같이 권한을 다운그레이드할 때 다운그레이드를 완료하는 데 몇 분이 소요됩니다. 

|{{site.data.keyword.containershort_notm}} 액세스 정책|클러스터 관리 권한|Kubernetes 리소스 권한|
|-------------|------------------------------|-------------------------------|
|관리자|이 역할은 이 계정의 모든 클러스터에 대한 편집자, 운영자 및 뷰어 역할에서 권한을 상속합니다. <br/><br/>모든 현재 서비스 인스턴스에 대해서 설정된 경우:<ul><li>무료 또는 표준 클러스터 작성</li><li>IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하도록 {{site.data.keyword.Bluemix_notm}} 계정의 신임 정보 설정</li><li>클러스터 제거</li><li>이 계정의 다른 기존 사용자에 대한 {{site.data.keyword.containershort_notm}} 액세스 정책 지정 및 변경</li></ul><p>특정 클러스터 ID에 대해 설정된 경우:<ul><li>특정 클러스터 제거</li></ul></p>해당 인프라 액세스 정책: 수퍼유저<br/><br/><strong>참고</strong>: 머신, VLAN 및 서브넷과 같은 리소스를 작성하려면 사용자에게 **수퍼유저** 인프라 역할이 필요합니다.|<ul><li>RBAC 역할: cluster-admin</li><li>모든 네임스페이스의 리소스에 대한 읽기/쓰기 액세스 권한</li><li>네임스페이스 내에서 역할 작성</li><li>Kubernetes 대시보드에 액세스</li><li>앱을 공용으로 사용할 수 있도록 하는 Ingress 리소스 작성</li></ul>|
|운영자|<ul><li>추가 작업자 노드를 클러스터에 추가</li><li>작업자 노드를 클러스터에서 제거</li><li>작업자 노드를 다시 부팅</li><li>작업자 노드를 다시 로드</li><li>클러스터에 서브넷 추가</li></ul><p>해당 인프라 액세스 정책: [사용자 정의](#infra_access)</p>|<ul><li>RBAC 역할: 관리</li><li>기본 네임스페이스 내의 리소스에 대한 읽기/쓰기 액세스 권한(네임스페이스 자체에는 해당되지 않음)</li><li>네임스페이스 내에서 역할 작성</li></ul>|
|편집자 <br/><br/><strong>팁</strong>: 앱 개발자의 경우 이 역할을 사용하십시오.|<ul><li>클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스 바인드.</li><li>클러스터에 대한 {{site.data.keyword.Bluemix_notm}} 서비스 바인드 해제.</li><li>웹훅 작성.</li></ul><p>해당 인프라 액세스 정책: [사용자 정의](#infra_access)|<ul><li>RBAC 역할: 편집</li><li>기본 네임스페이스 내부의 리소스에 대한 읽기/쓰기 액세스 권한</li></ul></p>|
|뷰어|<ul><li>클러스터 나열</li><li>클러스터의 세부사항 보기</li></ul><p>해당 인프라 액세스 정책: 보기 전용</p>|<ul><li>RBAC 역할: 보기</li><li>기본 네임스페이스 내부의 리소스에 대한 읽기 액세스 권한</li><li>Kubernetes 시크릿에 대한 읽기 액세스 권한 없음</li></ul>|

|Cloud Foundry 액세스 정책|계정 관리 권한|
|-------------|------------------------------|
|조직 역할: 관리자|<ul><li>{{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가</li></ul>| |
|영역 역할: 개발자|<ul><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스 작성</li><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스를 클러스터에 바인드</li></ul>| 

<br />



## IAM API 키 및 `bx cs credentials-set` 명령 이해
{: #api_key}

사용자의 계정의 클러스터를 프로비저닝하고 관련 작업을 수행하려면 사용자의 계정이 올바르게 설정되어 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스할 수 있는지 확인해야 합니다. 사용자의 계정 설정에 따라 IAM API 키 또는 `bx cs credentials-set` 명령을 사용하여 수동으로 설정한 인프라 신임 정보를 사용합니다. 

<dl>
  <dt>IAM API 키</dt>
  <dd>IAM(Identity and Access Management) API 키는 {{site.data.keyword.containershort_notm}} 관리자 액세스 권한이 필요한 첫 번째 조치가 수행될 때 지역에 대해 자동으로 설정됩니다. 예를 들어, 관리 사용자 중 한 명이 <code>us-south</code> 지역에서 첫 번째 클러스터를 작성합니다. 이를 수행하면 이 지역의 계정에 저장됩니다. API 키는 새 작업자 노드 또는 VLAN과 같은 IBM Cloud 인프라(SoftLayer)를 정렬하는 데 사용됩니다. </br></br>
다른 사용자가 새 클러스터 작성 또는 작업자 노드 다시 로드와 같이 IBM Cloud 인프라(SoftLayer) 포트폴리오와의 상호작용이 필요한 이 지역의 조치를 수행하는 경우 저장된 API 키는 해당 조치를 수행하는 데 충분한 권한이 있는지 판별하는 데 사용됩니다. 클러스터의 인프라 관련 조치를 수행할 수 있는지 확인하려면 {{site.data.keyword.containershort_notm}} 관리 사용자에게 <strong>수퍼유저</strong> 인프라 액세스 정책을 지정하십시오. </br></br>[<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info)를 실행하여 현재 API 키 소유자를 찾을 수 있습니다. 지역에 대해 저장된 API 키를 업데이트해야 하는 경우 [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 명령을 사용하여 이를 수행할 수 있습니다. 이 명령은 {{site.data.keyword.containershort_notm}} 관리자 액세스 정책이 필요하고 계정에서 이 명령을 실행하는 사용자의 API 키를 저장합니다. </br></br> <strong>참고:</strong> IBM Cloud 인프라(SoftLayer) 신임 정보가 <code>bx cs credentials-set</code> 명령을 사용하여 수동으로 설정된 경우 지역에 대해 저장된 API 키가 사용되지 않을 수 있습니다. </dd>
<dt><code>bx cs credentials-set</code>를 통한 IBM Cloud 인프라(SoftLayer) 신임 정보</dt>
<dd>{{site.data.keyword.Bluemix_notm}} 종량과금제 계정이 있는 경우 기본적으로 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한이 제공됩니다. 그러나 인프라를 정렬하기 위해 이미 보유하고 있는 다른 IBM Cloud 인프라(SoftLayer) 계정을 사용하려고 할 수 있습니다. [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set) 명령을 사용하여 이 인프라 계정을 {{site.data.keyword.Bluemix_notm}} 계정에 연결할 수 있습니다. </br></br>IBM Cloud 인프라(SoftLayer) 신임 정보가 수동으로 설정되면 IAM API 키가 이미 계정에 대해 존재하는 경우에도 인프라를 정렬하는 데 이 신임 정보가 사용됩니다. 신임 정보를 저장하는 사용자에게 인프라를 정렬하기 위한 필수 권한이 없는 경우 클러스터 작성 또는 작업자 노드 다시 로드와 같은 인프라 관련 조치에 실패할 수 있습니다. </br></br> 수동으로 설정된 IBM Cloud 인프라(SoftLayer) 신임 정보를 제거하기 위해 [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 명령을 사용할 수 있습니다. 신임 정보가 제거된 후 인프라를 정렬하는 데 IAM API 키를 사용합니다. </dd>
</dl>

## {{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가
{: #add_users}

{{site.data.keyword.Bluemix_notm}} 계정에 사용자를 추가하여 클러스터에 액세스 권한을 부여할 수 있습니다.
{:shortdesc}

시작하기 전에 {{site.data.keyword.Bluemix_notm}} 계정의 관리자 Cloud Foundry 역할이 지정되어 있는지 확인하십시오.

1.  [사용자를 계정에 추가](../iam/iamuserinv.html#iamuserinv)하십시오.
2.  **액세스** 섹션에서 **서비스**를 펼치십시오.
3.  {{site.data.keyword.containershort_notm}} 액세스 역할을 지정하십시오. **액세스 지정 대상** 드롭 다운 목록에서 {{site.data.keyword.containershort_notm}} 계정(**리소스**)에만 액세스를 부여할지 아니면 계정 내 다양한 리소스의 콜렉션(**리소스 그룹**)에 액세스를 지정할지를 결정하십시오.
  -  **리소스**의 경우:
      1. **서비스** 드롭 다운 목록에서 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
      2. **지역** 드롭 다운 목록에서 사용자를 초대할 지역을 선택하십시오. **참고**: [AP 북부 지역](cs_regions.html#locations)의 클러스터에 액세스하려면 [AP 북부 지역 내 클러스터를 위해 사용자에게 IAM 액세스 권한 부여](#iam_cluster_region)를 참조하십시오.
      3. **서비스 인스턴스** 드롭 다운 목록에서 사용자를 초대할 클러스터를 선택하십시오. 특정 클러스터의 ID를 찾으려면 `bx cs clusters`를 실행하십시오.
      4. **역할 선택** 섹션에서 역할을 선택하십시오. 역할에 대해 지원되는 조치 목록을 찾으려면 [액세스 정책 및 권한](#access_policies)을 참조하십시오.
  - **리소스 그룹**의 경우:
      1. **리소스 그룹** 드롭 다운 목록에서 계정의 {{site.data.keyword.containershort_notm}} 리소스 권한이 포함된 리소스 그룹을 선택하십시오.
      2. **리소스 그룹에 액세스 지정** 드롭 다운 목록에서 역할을 선택하십시오. 역할에 대해 지원되는 조치 목록을 찾으려면 [액세스 정책 및 권한](#access_policies)을 참조하십시오.
4. [선택사항: Cloud Foundry 역할을 지정](/docs/iam/mngcf.html#mngcf)하십시오.
5. [선택사항: 인프라 역할을 지정](/docs/iam/infrastructureaccess.html#infrapermission)하십시오.
6. **사용자 초대**를 클릭하십시오.

<br />


### AP 북부 지역 내 클러스터를 위해 사용자에게 IAM 액세스 권한 부여
{: #iam_cluster_region}

[사용자를 {{site.data.keyword.Bluemix_notm}} 계정에 추가](#add_users)하는 경우 액세스 권한이 부여된 지역을 선택할 수 있습니다. 그러나 콘솔에서 사용할 수 없을 수 있는 일부 지역(예: AP 북부)은 CLI를 사용하여 추가되어야 합니다.
{:shortdesc}

시작하기 전에 {{site.data.keyword.Bluemix_notm}} 계정의 관리자인지 확인하십시오. 

1.  {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용할 계정을 선택하십시오.

    ```
    bx login [--sso]
    ```
    {: pre}

    **참고:** 연합 ID가 있는 경우 `bx login --sso`를 사용하여 {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용자 이름을 입력하고 CLI 출력에서 제공된 URL을 사용하여 일회성 패스코드를 검색하십시오. `--sso` 옵션을 사용하지 않으면 로그인에 실패하고 `--sso` 옵션을 사용하면 성공하는 경우에는 연합 ID를 보유하고 있다는 것입니다.

2.  예를 들어, AP 북부 지역(`jp-tok`)에 권한을 부여하려는 환경을 대상으로 지정하십시오. 조직 및 영역과 같은 명령 옵션에 대한 자세한 내용은 [`bluemix target` 명령](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target)을 참조하십시오. 

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  액세스 권한을 부여할 지역의 클러스터에 대한 이름 또는 ID를 가져오십시오. 

    ```
         bx cs clusters
    ```
    {: pre}

4.  액세스 권한을 부여할 사용자 ID를 가져오십시오. 

    ```
    bx account users
    ```
    {: pre}

5.  액세스 정책에 대한 역할을 선택하십시오. 

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  적절한 역할이 있는 클러스터에 사용자 액세스 권한을 부여하십시오. 이 예에서는 세 클러스터의 `Operator` 및 `Editor` 역할을 `user@example.com`에 지정합니다. 

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    지역의 기존 및 이후 클러스터에 액세스 권한을 부여하려면 `--service-instance` 플래그를 지정하지 마십시오. 자세한 정보는 [`bluemix iam user-policy-create` 명령](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create)을 참조하십시오.
    {:tip}

## 사용자의 인프라 권한 사용자 정의
{: #infra_access}

Identity and Access Management에서 인프라 정책을 설정할 때 사용자에게 역할과 연관된 권한이 부여됩니다. 해당 권한을 사용자 정의하려면 IBM Cloud 인프라(SoftLayer)에 로그인하고 거기에서 권한을 조정해야 합니다.
{: #view_access}

예를 들어, **기본 사용자**는 작업자 노드를 다시 부팅할 수 있지만 작업자 노드를 다시 로드할 수는 없습니다. 사용자에게 **수퍼유저** 권한을 부여하지 않고 IBM Cloud 인프라(SoftLayer) 권한을 조정하여 다시 로드 명령을 실행할 권한을 추가할 수 있습니다.

1.  [{{site.data.keyword.Bluemix_notm}} 계정](https://console.bluemix.net/)에 로그인한 후 메뉴에서 **인프라**를 선택하십시오.

2.  **계정** > **사용자** > **사용자 목록**으로 이동하십시오.

3.  권한을 수정하려면 사용자 프로파일의 이름 또는 **디바이스 액세스** 열을 선택하십시오. 

4.  **포털 권한** 탭에서 사용자의 액세스 권한을 사용자 정의하십시오. 사용자에게 필요한 권한은 사용하는 데 필요한 인프라 리소스에 따라 달라집니다. 

    * **빠른 권한** 드롭 다운 목록을 사용하여 사용자에게 모든 권한을 제공하는 **수퍼유저** 역할을 지정합니다. 
    * **빠른 권한** 드롭 다운 목록을 사용하여 사용자에게 일부 필요한 권한(모든 권한 아님)을 제공하는 **기본 사용자** 역할을 지정합니다. 
    * **수퍼유저** 역할이 포함된 모든 권한을 부여하지 않거나 **기본 사용자** 역할 이상의 권한을 추가해야 하는 경우 {{site.data.keyword.containershort_notm}}에서 공통 태스크를 수행하는 데 필요한 권한에 대해 설명하는 다음 표를 검토하십시오 .

    <table summary="공통 {{site.data.keyword.containershort_notm}} 시나리오에 대한 인프라 권한">
     <caption>{{site.data.keyword.containershort_notm}}에 공통으로 필요한 인프라 권한</caption>
     <thead>
     <th>{{site.data.keyword.containershort_notm}}의 공통 태스크</th>
     <th>탭에서 필요한 인프라 권한</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>최소 권한</strong>: <ul><li>클러스터를 작성하십시오.</li></ul></td>
     <td><strong>디바이스</strong>:<ul><li>가상 서버 세부사항 보기</li><li>서버 다시 부팅 및 IPMI 시스템 정보 보기</li><li>OS 다시 로드 실행 및 복구 커널 시작</li></ul><strong>계정</strong>: <ul><li>클라우드 인스턴스 추가/업그레이드</li><li>서버 추가</li></ul></td>
     </tr>
     <tr>
     <td><strong>클러스터 관리</strong>: <ul><li>클러스터 작성, 업데이트 및 삭제</li><li>작업자 노드 추가, 다시 로드 및 다시 부팅</li><li>VLAN 보기</li><li>서브넷 작성</li><li>포드 및 로드 밸런서 서비스 배치</li></ul></td>
     <td><strong>지원</strong>:<ul><li>티켓 보기</li><li>티켓 추가</li><li>티켓 편집</li></ul>
     <strong>디바이스</strong>:<ul><li>가상 서버 세부사항 보기</li><li>서버 다시 부팅 및 IPMI 시스템 정보 보기</li><li>서버 업그레이드</li><li>OS 다시 로드 실행 및 복구 커널 시작</li></ul>
     <strong>서비스</strong>:<ul><li>SSH 키 관리</li></ul>
     <strong>계정</strong>: <ul><li>계정 요약 보기</li><li>클라우드 인스턴스 추가/업그레이드</li><li>서버 취소</li><li>서버 추가</li></ul></td>
     </tr>
     <tr>
     <td><strong>스토리지</strong>: <ul><li>지속적 볼륨 클레임을 작성하여 지속적 볼륨 프로비저닝</li><li>스토리지 인프라 리소스 작성 및 관리</li></ul></td>
     <td><strong>서비스</strong>:<ul><li>스토리지 관리</li></ul><strong>계정</strong>: <ul><li>스토리지 추가</li></ul></td>
     </tr>
     <tr>
     <td><strong>사설 네트워크</strong>: <ul><li>클러스터 내부 네트워킹을 위한 프라이빗 VLAN 관리</li><li>VPN 연결을 사설 네트워크에 설정</li></ul></td>
     <td><strong>네트워크</strong>:<ul><li>네트워크 서브넷 라우트 관리</li><li>네트워크 VLAN Spanning 관리</li><li>IPSEC 네트워크 터널 관리</li><li>네트워크 게이트웨이 관리</li><li>VPN 관리</li></ul></td>
     </tr>
     <tr>
     <td><strong>사설 네트워킹</strong>:<ul><li>공용 로드 밸런서 또는 Ingress 네트워킹을 설정하여 앱 노출</li></ul></td>
     <td><strong>디바이스</strong>:<ul><li>로드 밸런서 관리</li><li>호스트 이름/도메인 편집</li><li>포트 제어 관리</li></ul>
     <strong>네트워크</strong>:<ul><li>공용 네트워크 포트로 컴퓨팅 추가</li><li>네트워크 서브넷 라우트 관리</li><li>네트워크 VLAN Spanning 관리</li><li>IP 주소 추가</li></ul>
     <strong>서비스</strong>:<ul><li>DNS, 리버스 DNS 및 WHOIS 관리</li><li>인증서(SSL) 보기</li><li>인증서(SSL) 관리</li></ul></td>
     </tr>
     </tbody></table>

5.  변경사항을 저장하려면 **포털 권한 편집**을 클릭하십시오.

6.  **디바이스 액세스** 탭에서 액세스 권한을 부여할 디바이스를 선택하십시오.

    * **디바이스 유형** 드롭 다운에서 액세스 권한을 **모든 가상 서버**에 부여할 수 있습니다.
    * 사용자가 작성된 새 디바이스에 대한 사용자 액세스를 허용하려면 **새 디바이스가 추가될 때 자동으로 액세스 권한 부여**를 확인하십시오.
    * 변경사항을 저장하려면 **디바이스 액세스 업데이트**를 클릭하십시오.

7.  사용자 프로파일 목록으로 돌아간 후 **디바이스 액세스**가 부여되었는지 확인하십시오.

## 사용자 정의 Kubernetes RBAC 역할이 포함된 사용자 권한 부여
{: #rbac}

{{site.data.keyword.containershort_notm}} 액세스 정책은 [액세스 정책 및 권한](#access_policies)에 설명된 대로 특정 Kubernetes 역할 기반 액세스 제어(RBAC)와 일치합니다. 해당 액세스 정책과 다른 기타 Kubernetes 역할에 권한을 부여하기 위해 RBAC 역할을 사용자 정의한 후 개인 또는 사용자의 그룹에 역할을 지정할 수 있습니다.
{: shortdesc}

예를 들어, 개발자의 팀에 특정 API 그룹 또는 클러스터의 특정 Kubernetes 네임스페이스 내의(전체 클러스터 전체는 아님) 리소스에 대해 작업할 수 있는 권한을 부여하고자 할 수 있습니다. {{site.data.keyword.containershort_notm}}에 고유한 사용자 이름을 사용하여 역할을 작성한 후 역할을 사용자에 바인드합니다. 자세한 정보는 Kubernetes 문서에 있는 [RBAC 권한 사용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)을 참조하십시오. 

시작하기 전에 클러스터를 [Kubernetes CLI를 클러스터에 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

1.  지정할 액세스 권한으로 역할을 작성하십시오. 

    1. `.yaml` 파일을 작성하여 지정할 액세스 권한으로 역할을 정의하십시오. 

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>표. 이 YAML 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 YAML 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>`Role`을 사용하여 단일 네임스페이스 내 리소스에 액세스 권한을 부여하거나 클러스터 전반의 리소스에 `ClusterRole`을 사용하십시오. </td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Kubernetes 1.8 이상을 실행하는 클러스터의 경우 `rbac.authorization.k8s.io/v1`을 사용하십시오. </li><li>이전 버전의 경우 `apiVersion: rbac.authorization.k8s.io/v1beta1`을 사용하십시오.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>`Role` 유형의 경우: 액세스 권한이 부여되는 Kubernetes 네임스페이스를 지정하십시오. </li><li>클러스터 레벨에 적용하는 `ClusterRole`을 작성하는 경우 `namespace` 필드를 사용하지 마십시오. </li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>나중에 역할을 바인드할 때 역할의 이름을 지정하고 이름을 사용하십시오. </td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>`"apps"`, `"batch"` 또는 `"extensions"`와 같이 사용자가 상호작용할 수 있도록 Kubernetes API 그룹을 지정하십시오. </li><li>REST 경로 `api/v1`의 코어 API 그룹에 액세스하려면 그룹을 `[""]`와 같이 공백으로 두십시오.</li><li>자세한 정보는 Kubernetes 문서의 [API 그룹![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/api-overview/#api-groups)을 참조하십시오. </li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>`"daemonsets"`, `"deployments"`, `"events"` 또는 `"ingresses"`와 같이 액세스 권한을 부여할 Kubernetes 리소스를 지정하십시오.</li><li>`"nodes"`를 지정하는 경우 역할 유형은 `ClusterRole`이어야 합니다.</li><li>리소스의 목록은 Kubernetes 치트 시트에서 [리소스 유형![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)의 표를 참조하십시오.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>`"get"`, `"list"`, `"describe"`, `"create"` 또는 `"delete"`와 같이 사용자가 수행할 수 있는 조치의 유형을 지정하십시오. </li><li>verb에 대한 전체 목록은 [`kubectl` 문서![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)를 참조하십시오.</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  클러스터에 역할을 작성하십시오.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  역할이 작성되었는지 확인하십시오.

        ```
        kubectl get roles
        ```
        {: pre}

2.  역할을 사용자에 바인드하십시오.

    1. `.yaml` 파일을 작성하여 역할에 사용자를 바인드하십시오. 각 주제의 이름에 사용할 고유한 URL을 기록해 두십시오.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>표. 이 YAML 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 YAML 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>두 가지 유형의 역할 `.yaml` 파일(네임스페이스 `Role` 및 클러스터 전반의 `ClusterRole`)에 대해 `kind`를 `RoleBinding`으로 지정하십시오. </td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Kubernetes 1.8 이상을 실행하는 클러스터의 경우 `rbac.authorization.k8s.io/v1`을 사용하십시오. </li><li>이전 버전의 경우 `apiVersion: rbac.authorization.k8s.io/v1beta1`을 사용하십시오.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>`Role` 유형의 경우: 액세스 권한이 부여되는 Kubernetes 네임스페이스를 지정하십시오. </li><li>클러스터 레벨에 적용하는 `ClusterRole`을 작성하는 경우 `namespace` 필드를 사용하지 마십시오. </li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>역할 바인딩의 이름을 지정하십시오. </td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>`User`로 유형을 지정하십시오.</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>사용자의 이메일 주소를 `https://iam.ng.bluemix.net/kubernetes#` URL에 추가하십시오.</li><li>예를 들면, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`입니다.</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>`rbac.authorization.k8s.io`를 사용하십시오.</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>역할 `.yaml` 파일(`Role` 또는 `ClusterRole`)에서 `kind`와 동일한 값을 입력하십시오.</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>역할 `.yaml` 파일의 이름을 입력하십시오.</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>`rbac.authorization.k8s.io`를 사용하십시오.</td>
        </tr>
        </tbody>
        </table>

    2. 클러스터에 역할 바인딩 리소스를 작성하십시오. 

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  바인딩이 작성되었는지 확인하십시오.

        ```
        kubectl get rolebinding
        ```
        {: pre}

이제 사용자 정의 Kubernetes RBAC 역할을 작성하고 바인드했습니다. 사용자에게 후속 조치를 취하십시오. 포드 삭제와 같은 역할로 인해 완료할 권한이 있는 조치를 테스트하도록 사용자에게 요청하십시오. 
