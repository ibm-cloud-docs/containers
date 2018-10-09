---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터 액세스 지정
{: #users}

클러스터 관리자는 Kubernetes 클러스터에 대한 액세스 정책을 정의하여 다양한 사용자에 대해 서로 다른 액세스 레벨을 작성할 수 있습니다. 예를 들어, 특정 사용자는 클러스터 리소스에 대해 작업할 수 있도록 하고 다른 사용자는 컨테이너 배치만 수행할 수 있도록 권한 부여할 수 있습니다.
{: shortdesc}


## 액세스 정책 및 권한 이해
{: #access_policies}

<dl>
  <dt>액세스 정책을 설정해야 합니까?</dt>
    <dd>{{site.data.keyword.containerlong_notm}}에 대해 작업하는 모든 사용자에 대해 액세스 정책을 정의해야 합니다. 액세스 정책의 범위는 사용자가 수행할 수 있도록 허용된 조치를 결정하는 사용자 정의 역할을 기반으로 합니다. 일부 정책은 사전 정의되어 있으나, 그 외의 정책은 사용자 정의할 수 있습니다. IBM Cloud 인프라(SoftLayer)에서 조치가 완료되는 경우에도 사용자가 {{site.data.keyword.containerlong_notm}} GUI에서나 CLI를 통해 요청을 수행하는지에 관계없이 동일한 정책이 적용됩니다.</dd>

  <dt>권한의 유형은 무엇입니까?</dt>
    <dd><p><strong>플랫폼</strong>: {{site.data.keyword.containerlong_notm}}는 {{site.data.keyword.Bluemix_notm}} 플랫폼 역할을 사용하여 개인이 클러스터에서 수행할 수 있는 조치를 판별하도록 구성되어 있습니다. 역할 권한은 서로 간에 빌드됩니다. 이는 `Editor` 역할에 `Viewer` 역할과 동일한 모든 권한이 있으며, 이외에 편집자에게 부여된 권한이 추가됨을 의미합니다. 이러한 정책은 지역별로 설정할 수 있습니다. 이러한 정책은 인프라 정책과 함께 설정되어야 하며, 이에는 기본 네임스페이스에 자동으로 지정된 대응되는 RBAC 역할이 역할이 있어야 합니다. 조치의 예를 들면 클러스터 작성 또는 제거, 작업자 노드 추가 등이 있습니다.</p> <p><strong>인프라</strong>: 클러스터 노드 머신, 네트워킹 또는 스토리지 리소스와 같은 인프라에 대한 액세스 레벨을 결정할 수 있습니다. 이 유형의 정책은 {{site.data.keyword.containerlong_notm}} 플랫폼 액세스 정책과 함께 설정해야 합니다. 사용 가능한 역할에 대해 알아보려면 [인프라 권한](/docs/iam/infrastructureaccess.html#infrapermission)을 참조하십시오. 특정 인프라 역할을 부여하는 것 이외에 인프라에 대해 작업하는 사용자에게 디바이스 액세스 권한도 부여해야 합니다. 역할 지정을 시작하려면 [사용자의 인프라 권한 사용자 정의](#infra_access)의 단계를 따르십시오. <strong>참고</strong>: 인가된 사용자가 지정된 권한에 따라 IBM Cloud 인프라(SoftLayer) 계정에서 조치를 수행할 수 있도록 {{site.data.keyword.Bluemix_notm}} 계정이 [IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한으로 설정](cs_troubleshoot_clusters.html#cs_credentials)되어 있는지 확인하십시오.</p> <p><strong>RBAC</strong>: 역할 기반 액세스 제어(RBAC)는 클러스터 내의 리소스를 보호하고 누가 어떤 Kubernetes 조치를 수행할 수 있는지를 판별하는 방법입니다. 플랫폼 액세스 정책이 지정된 모든 사용자에게는 자동으로 Kubernetes 역할이 지정됩니다. Kubernetes에서 [역할 기반 액세스 제어(RBAC) ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview)는 사용자가 클러스터 내의 리소스에 대해 수행할 수 있는 조치를 결정합니다. <strong>참고</strong>: RBAC 역할은 기본 네임스페이스에 대한 플랫폼 역할과 결합하여 자동으로 설정됩니다. 클러스터 관리자인 경우에는 기타 네임스페이스에 대해 [역할을 업데이트하거나 지정](#rbac)할 수 있습니다.</p> <p><strong>Cloud Foundry</strong>: Cloud IAM으로 관리할 수 없는 서비스도 있습니다. 이러한 서비스 중 하나를 사용하고 있는 경우에는 [Cloud Foundry 사용자 역할](/docs/iam/cfaccess.html#cfaccess)을 계속 사용하여 서비스에 대한 액세스를 제어할 수 있습니다. 예제 조치는 서비스 바인딩 또는 새 서비스 인스턴스 작성입니다.</p></dd>

  <dt>권한을 어떻게 설정할 수 있습니까?</dt>
    <dd><p>플랫폼 권한을 설정할 때는 특정 사용자, 사용자 그룹 또는 기본 리소스 그룹에 대한 액세스를 지정할 수 있습니다. 플랫폼 권한을 설정하면 기본 네임스페이스에 대해 RBAC 역할이 자동으로 구성되며 역할 바인딩이 작성됩니다.</p>
    <p><strong>사용자</strong>: 팀의 나머지 구성원보다 더 많거나 적은 권한이 필요한 특정 사용자가 있을 수 있습니다. 각 개인이 자체 태스크를 완료하는 데 필요한 적절한 양의 권한을 보유할 수 있도록 개인별로 권한을 사용자 정의할 수 있습니다.</p>
    <p><strong>액세스 그룹</strong>: 사용자의 그룹을 작성한 후에 특정 그룹에 권한을 지정할 수 있습니다. 예를 들어, 모든 팀 리더를 그룹화하고 해당 그룹에 관리자 액세스 권한을 부여할 수 있습니다. 이와 동시에 개발자의 그룹에는 쓰기 액세스 권한만 있습니다.</p>
    <p><strong>리소스 그룹</strong>: IAM에서는 리소스의 그룹에 대해 액세스 정책을 작성하고 이 그룹에 사용자 액세스 권한을 부여할 수 있습니다. 이러한 리소스는 하나의 {{site.data.keyword.Bluemix_notm}} 서비스의 일부일 수 있습니다. 또는 사용자가 서비스 인스턴스 간에 리소스를 그룹화할 수도 있습니다(예: {{site.data.keyword.containerlong_notm}} 클러스터 및 CF 앱).</p> <p>**중요**: {{site.data.keyword.containerlong_notm}}는 <code>default</code> 리소스 그룹만 지원합니다. 모든 클러스터 관련 리소스는 <code>default</code> 리소스 그룹에서 자동으로 사용 가능하게 됩니다. 클러스터에서 사용할 {{site.data.keyword.Bluemix_notm}} 계정의 기타 서비스가 있으면 해당 서비스가 <code>default</code> 리소스 그룹에도 있어야 합니다.</p></dd>
</dl>


무엇을 해야 할지 잘 모르시겠습니까? [사용자, 팀 및 애플리케이션 구성에 대한 우수 사례](/docs/tutorials/users-teams-applications.html)와 관련된 튜토리얼을 수행해 보십시오.
{: tip}

<br />


## IBM Cloud 인프라(SoftLayer) 포트폴리오 액세스
{: #api_key}

<dl>
  <dt>IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스해야 하는 이유는 무엇입니까?</dt>
    <dd>계정의 클러스터를 프로비저닝하고 관련 작업을 수행하려면 계정이 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하도록 올바르게 설정되었는지 확인해야 합니다. 계정 설정에 따라서는 IAM API 키를 사용하거나 `ibmcloud ks credentials-set` 명령을 사용하여 수동으로 설정된 인프라 인증 정보를 사용합니다.</dd>

  <dt>IAM API 키는 {{site.data.keyword.containerlong_notm}}에서 어떻게 작동합니까?</dt>
    <dd><p>IAM(Identity and Access Management) API 키는 {{site.data.keyword.containerlong_notm}} 관리자 액세스 권한이 필요한 첫 번째 조치가 수행될 때 지역에 대해 자동으로 설정됩니다. 예를 들어, 관리 사용자 중 한 명이 <code>us-south</code> 지역에서 첫 번째 클러스터를 작성합니다. 이를 수행하면 이 사용자의 IAM API 키가 이 지역의 계정에 저장됩니다. API 키는 새 작업자 노드 또는 VLAN과 같은 IBM Cloud 인프라(SoftLayer)를 정렬하는 데 사용됩니다.</p> <p>다른 사용자가 새 클러스터 작성 또는 작업자 노드 다시 로드와 같이 IBM Cloud 인프라(SoftLayer) 포트폴리오와의 상호작용이 필요한 조치를 이 지역에서 수행하는 경우 저장된 API 키를 사용하여 해당 조치를 수행하는 데 충분한 권한이 있는지 여부를 판별합니다. 클러스터의 인프라 관련 조치를 수행할 수 있는지 확인하려면 {{site.data.keyword.containerlong_notm}} 관리 사용자에게 <strong>수퍼유저</strong> 인프라 액세스 정책을 지정하십시오.</p> <p>[<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info)를 실행하여 현재 API 키 소유자를 찾을 수 있습니다. 지역에 대해 저장된 API 키를 업데이트해야 한다고 판단되면 [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 명령을 실행하여 이를 수행할 수 있습니다. 이 명령은 {{site.data.keyword.containerlong_notm}} 관리자 액세스 정책이 필요하고 계정에서 이 명령을 실행하는 사용자의 API 키를 저장합니다. IBM Cloud 인프라(SoftLayer) 인증 정보가 <code>ibmcloud ks credentials-set</code> 명령을 사용하여 수동으로 설정된 경우에는 지역에 대해 저장된 API 키가 사용되지 않을 수 있습니다.</p> <p><strong>참고:</strong> 키의 재설정을 원하는지 확인하고 앱에 미치는 영향을 파악하십시오. 키는 여러 다른 위치에서 사용되며 이를 불필요하게 변경하면 기타 컴포넌트에 영향을 줄 수 있는 변경사항(breaking changes)이 발생할 수 있습니다.</p></dd>

  <dt><code>ibmcloud ks credentials-set</code> 명령의 역할은 무엇입니까?</dt>
    <dd><p>{{site.data.keyword.Bluemix_notm}} 종량과금제 계정이 있는 경우 기본적으로 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한이 제공됩니다. 그러나 이미 보유 중인 다른 IBM Cloud 인프라(SoftLayer) 계정을 사용하여 지역 내의 클러스터에 대한 인프라를 주문하고자 할 수 있습니다. [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set) 명령을 사용하여 이 인프라 계정을 {{site.data.keyword.Bluemix_notm}} 계정에 연결할 수 있습니다.</p> <p>수동으로 설정된 IBM Cloud 인프라(SoftLayer) 인증 정보를 제거하기 위해 [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 명령을 사용할 수 있습니다. 인증 정보가 제거된 후 인프라를 정렬하는 데 IAM API 키를 사용합니다.</p></dd>

  <dt>인프라 인증 정보와 API 키 간에 차이가 있습니까? </dt>
    <dd>API 키와 <code>ibmcloud ks credentials-set</code> 명령은 둘 다 동일한 태스크를 수행합니다. <code>ibmcloud ks credentials-set</code> 명령을 사용하여 수동으로 인증 정보를 설정하는 경우, 설정된 인증 정보는 API 키로 부여된 액세스 권한을 대체합니다. 그러나 해당 인증 정보가 저장된 사용자에게 인프라를 주문하기 위한 필수 권한이 없는 경우에는 클러스터 작성 또는 작업자 노드 재로드 등의 인프라 관련 조치에 실패할 수 있습니다.</dd>
    
  <dt>내 인프라 계정 인증 정보가 다른 계정을 사용하도록 설정되어 있는지 어떻게 알 수 있습니까?</dt>
    <dd>[{{site.data.keyword.containerlong_notm}} GUI ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/containers-kubernetes/clusters)를 열고 클러스터를 선택하십시오. **개요** 탭에서 **인프라 사용자** 필드를 찾으십시오. 해당 필드가 나타나는 경우에는 이 지역에서 종량과금제 계정과 함께 제공되는 기본 인프라 인증 정보를 사용하지 않는 것입니다. 대신 다른 인프라 계정 인증 정보를 사용하도록 지역이 설정됩니다.</dd>

  <dt>IBM Cloud 인프라(SoftLayer) 권한을 보다 쉽게 지정할 수 있는 방법이 있습니까? </dt>
    <dd><p>일반적으로 사용자에게는 특정 IBM Cloud 인프라(SoftLayer) 권한이 필요하지 않습니다. 그 대신에 올바른 인프라 권한으로 API 키를 설정하고, 클러스터가 필요한 각 지역에서 해당 API 키를 사용하십시오. API 키는 관리 및 감사의 용이성에 따라 계정 소유자, 기능 ID 또는 사용자에 속할 수 있습니다. </p> <p>새 지역의 클러스터를 작성하려면 적절한 인프라 인증 정보로 설정된 API 키의 소유자에 의해 첫 번째 클러스터가 작성되었는지 확인하십시오. 그 이후에는 개별 사용자, IAM 그룹 또는 서비스 계정 사용자를 해당 지역에 초대할 수 있습니다. 계정 내의 사용자는 작업자 노드 추가 등의 인프라 조치 수행을 위해 API 키 인증 정보를 공유합니다. 사용자가 수행할 수 있는 인프라 조치를 제어하려면 IAM에서 적절한 {{site.data.keyword.containerlong_notm}} 역할을 지정하십시오. </p><p>예를 들어, `Viewer` IAM 역할이 있는 사용자는 작업자 노드를 추가할 권한이 없습니다. 따라서 API 키에 올바른 인프라 권한이 있어도 `worker-add` 조치가 실패합니다. IAM에서 사용자 역할을 `Operator`로 변경하면 사용자에게 작업자 노드를 추가할 권한이 부여됩니다. 사용자 역할에 권한이 부여되고 API 키가 올바로 설정되었으므로 `worker-add` 조치가 성공합니다. 사용자의 IBM Cloud 인프라(SoftLayer) 권한을 편집할 필요는 없습니다. </p> <p>권한 설정에 대한 자세한 정보는 [사용자의 인프라 권한에 대한 사용자 정의](#infra_access)를 확인하십시오. </p></dd>
</dl>


<br />



## 역할 관계 이해
{: #user-roles}

각 조치를 수행할 수 있는 역할을 이해하기 전에, 역할이 서로 간에 어떻게 맞물려 있는지를 이해하는 것이 중요합니다.
{: shortdesc}

다음 이미지는 조직의 각 개인 유형에 필요할 수 있는 역할을 보여줍니다. 그러나 이는 모든 조직에 대해 서로 다릅니다. 참고로, 일부 사용자에게는 인프라에 대한 사용자 정의 권한이 필요합니다. IBM Cloud 인프라(SoftLayer) 권한의 정의와 함께 어떤 사용자에게 어떤 권한이 필요한지 알아보려면 반드시 [IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스](#api_key)를 자세히 읽어보십시오.  

![{{site.data.keyword.containerlong_notm}} 액세스 역할](/images/user-policies.png)

그림. 역할 유형별 {{site.data.keyword.containerlong_notm}} 액세스 권한

<br />



## GUI에서 역할 지정
{: #add_users}

{{site.data.keyword.Bluemix_notm}} 계정에 사용자를 추가하여 GUI에서 클러스터에 대한 액세스 권한을 부여할 수 있습니다.
{: shortdesc}

**시작하기 전에**

- 사용자가 계정에 추가되었는지 확인하십시오. 추가되지 않았으면 [사용자](../iam/iamuserinv.html#iamuserinv)를 추가하십시오.
- 작업 중인 {{site.data.keyword.Bluemix_notm}} 계정에 대해 `Manager` [Cloud Foundry 역할](/docs/iam/mngcf.html#mngcf)이 자신에게 지정되었는지 확인하십시오.

**사용자에 대한 액세스 지정**

1. **관리 > 사용자**로 이동하십시오. 계정에 대한 액세스 권한이 있는 사용자의 목록이 표시됩니다.

2. 해당 권한을 설정할 사용자의 이름을 클릭하십시오. 사용자가 표시되지 않으면 **사용자 초대**를 클릭하여 사용자를 계정에 추가하십시오.

3. 정책을 지정하십시오.
  * 리소스 그룹의 경우:
    1. **기본** 리소스 그룹을 선택하십시오. {{site.data.keyword.containerlong_notm}} 액세스는 기본 리소스 그룹의 경우에만 구성될 수 있습니다.
  * 특정 리소스의 경우:
    1. **서비스** 목록에서 **{{site.data.keyword.containerlong_notm}}**를 선택하십시오.
    2. **지역** 목록에서 지역을 선택하십시오.
    3. **서비스 인스턴스** 목록에서 사용자가 초대될 클러스터를 선택하십시오. 특정 클러스터의 ID를 찾으려면 `ibmcloud ks clusters`를 실행하십시오.

4. **역할 선택** 섹션에서 역할을 선택하십시오. 

5. **지정**을 클릭하십시오.

6. [Cloud Foundry 역할](/docs/iam/mngcf.html#mngcf)을 지정하십시오.

7. 선택사항: [인프라 역할](/docs/iam/infrastructureaccess.html#infrapermission)을 지정하십시오.

</br>

**그룹에 대한 액세스 지정**

1. **관리 > 액세스 그룹**으로 이동하십시오.

2. 액세스 그룹을 작성하십시오.
  1. **작성**을 클릭하고 그룹에 **이름** 및 **설명**을 부여하십시오. **작성**을 클릭하십시오.
  2. **사용자 추가**를 클릭하여 사용자를 액세스 그룹에 추가하십시오. 계정에 대한 액세스 권한이 있는 모든 사용자가 표시됩니다.
  3. 그룹에 추가할 사용자 옆의 상자를 선택하십시오. 대화 상자가 표시됩니다.
  4. **그룹에 추가**를 클릭하십시오.

3. 특정 서비스에 대한 액세스를 지정하려면 서비스 ID를 추가하십시오.
  1. **서비스 ID 추가**를 클릭하십시오.
  2. 그룹에 추가할 사용자 옆의 상자를 선택하십시오. 팝업 상자가 표시됩니다.
  3. **그룹에 추가**를 클릭하십시오.

4. 액세스 정책을 지정하십시오. 반드시 그룹에 추가되는 사용자를 재차 확인하십시오. 그룹의 모든 사용자에게는 동일한 레벨의 액세스가 제공됩니다.
    * 리소스 그룹의 경우:
        1. **기본** 리소스 그룹을 선택하십시오. {{site.data.keyword.containerlong_notm}} 액세스는 기본 리소스 그룹의 경우에만 구성될 수 있습니다.
    * 특정 리소스의 경우:
        1. **서비스** 목록에서 **{{site.data.keyword.containerlong_notm}}**를 선택하십시오.
        2. **지역** 목록에서 지역을 선택하십시오.
        3. **서비스 인스턴스** 목록에서 사용자가 초대될 클러스터를 선택하십시오. 특정 클러스터의 ID를 찾으려면 `ibmcloud ks clusters`를 실행하십시오.

5. **역할 선택** 섹션에서 역할을 선택하십시오. 

6. **지정**을 클릭하십시오.

7. [Cloud Foundry 역할](/docs/iam/mngcf.html#mngcf)을 지정하십시오.

8. 선택사항: [인프라 역할](/docs/iam/infrastructureaccess.html#infrapermission)을 지정하십시오.

<br />



## CLI로 역할 지정
{: #add_users_cli}

{{site.data.keyword.Bluemix_notm}} 계정에 사용자를 추가하여 CLI로 클러스터에 대한 액세스 권한을 부여할 수 있습니다.
{: shortdesc}

**시작하기 전에**

작업 중인 {{site.data.keyword.Bluemix_notm}} 계정에 대해 `Manager` [Cloud Foundry 역할](/docs/iam/mngcf.html#mngcf)이 자신에게 지정되었는지 확인하십시오.

**특정 사용자에 대한 액세스 지정**

1. 사용자를 계정에 초대하십시오. 
  ```
  ibmcloud account user-invite <user@email.com>
  ```
  {: pre}
2. {{site.data.keyword.containerlong_notm}}에 대한 권한 설정을 위한 IAM 액세스 정책을 작성하십시오. 역할에 대해 뷰어, 편집자, 운영자 및 관리자를 선택할 수 있습니다.
  ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

**그룹에 대한 액세스 지정**

1. 사용자가 아직 계정의 일부가 아닌 경우에는 해당 사용자를 초대하십시오.
  ```
  ibmcloud account user-invite <user_email>
  ```
  {: pre}

2. 그룹을 작성하십시오.
  ```
  ibmcloud iam access-group-create <team_name>
  ```
  {: pre}

3. 사용자를 그룹에 추가하십시오. 
  ```
  ibmcloud iam access-group-user-add <team_name> <user_email>
  ```
  {: pre}

4. 사용자를 그룹에 추가하십시오. 역할에 대해 뷰어, 편집자, 운영자 및 관리자 중에서 선택할 수 있습니다.
  ```
  ibmcloud iam access-group-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

5. RoleBinding을 생성하도록 클러스터 구성을 업데이트하시오.
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  RoleBinding:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <binding>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <role>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <group_name>
    namespace: default
  ```
  {: screen}

이전 지시사항에서는 모든 {{site.data.keyword.containerlong_notm}} 리소스에 대한 액세스 권한을 사용자 그룹에 부여하는 방법을 보여줍니다. 자신이 관리자인 경우에는 지역 또는 클러스터 인스턴스 레벨에서 서비스에 대한 액세스를 제한할 수도 있습니다.
{: tip}

<br />


## RBAC 역할 바인딩으로 사용자에게 권한 부여
{: #role-binding}

모든 클러스터는 클러스터의 기본 네임스페이스에 대해 구성된 사전 정의된 RBAC 역할로 설정됩니다. 기본 네임스페이스의 RBAC 역할을 클러스터의 다른 네임스페이스로 복사하여 동일한 레벨의 사용자 액세스를 적용할 수 있습니다.

**RBAC RoleBinding은 무엇입니까?**

역할 바인딩(role binding)은 Kubernetes 리소스 특정 액세스 정책입니다. 역할 바인딩을 사용하여 클러스터 내의 네임스페이스, 팟(Pod) 또는 기타 리소스에 특정한 정책을 설정할 수 있습니다. {{site.data.keyword.containerlong_notm}}에서는 IAM의 플랫폼 역할에 대응되는 사전 정의된 RBAC 역할을 제공합니다. IAM 플랫폼 역할을 사용자에게 지정하면 RBAC 역할 바인딩이 클러스터의 네임스페이스에서 사용자를 위해 자동으로 작성됩니다. 

**RBAC 클러스터 역할 바인딩은 무엇입니까?**

RBAC 역할 바인딩이 하나의 리소스(예: 네임스페이스 또는 팟(Pod))에 특정한 반면, RBAC 클러스터 역할 바인딩은 모든 네임스페이스가 포함된 클러스터 레벨의 권한 설정에 사용될 수 있습니다. 클러스터 역할 바인딩은 플랫폼 역할이 설정될 때 기본 네임스페이스에 대해 자동으로 작성됩니다. 해당 역할 바인딩을 다른 네임스페이스에 복사할 수 있습니다. 


<table>
  <tr>
    <th>플랫폼 역할</th>
    <th>RBAC 역할</th>
    <th>역할 바인딩</th>
  </tr>
  <tr>
    <td>뷰어</td>
    <td>보기</td>
    <td><code>ibm-view</code></td>
  </tr>
  <tr>
    <td>편집자</td>
    <td>편집</td>
    <td><code>ibm-edit</code></td>
  </tr>
  <tr>
    <td>운영자</td>
    <td>관리자</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>관리자</td>
    <td>클러스터 관리자</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

**RoleBindings 관련 작업 시에 특정 요구사항이 있습니까?**

IBM Helm 차트 관련 작업을 수행하려면 `kube-system` 네임스페이스에 Tiller를 설치해야 합니다. Tiller를 설치하려면 `kube-system` 네임스페이스 내에서 [`cluster-admin` 역할](cs_users.html#access_policies)이 있어야 합니다. 기타 Helm 차트의 경우에는 다른 네임스페이스를 선택할 수 있습니다. 그러나 `helm` 명령을 실행할 때는 `tiller-namespace <namespace>` 플래그를 사용하여 Tiller가 설치된 네임스페이스를 지시해야 합니다. 


### RBAC RoleBinding 복사

플랫폼 정책을 구성하면 기본 네임스페이스에 대해 클러스터 역할 바인딩이 자동으로 생성됩니다. 해당 정책을 설정할 네임스페이스의 바인딩을 업데이트하여 다른 네임스페이스로 바인딩을 복사할 수 있습니다. 예를 들어, `team-a`라고 하는 개발자 그룹이 있으며 이들에게 서비스 간의 `view` 액세스 권한은 있지만 `teama` 네임스페이스에 대한 `edit` 액세스 권한이 추가로 필요하다고 가정합니다. 자동 생성된 RoleBinding을 편집하여 리소스 레벨에서 필요한 액세스 권한을 이들에게 부여할 수 있습니다. 

1. [플랫폼 역할로 액세스 권한을 지정](#add_users_cli)하여 기본 네임스페이스에 대한 RBAC 역할 바인딩을 작성하십시오. 
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}
출력 예:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. 해당 구성을 다른 네임스페이스로 복사하십시오. 
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role> --namespace <namespace>
  ```
  {: pre}
  이전 시나리오에서 나는 다른 네임스페이스의 구성을 변경했습니다. 업데이트된 구성은 다음과 유사합니다.
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### 사용자 정의 Kubernetes RBAC 역할 작성
{: #rbac}

대응되는 플랫폼 액세스 정책과는 다른 기타 Kubernetes 역할을 권한 부여하기 위해, RBAC 역할을 사용자 정의한 후에 해당 역할을 개인 또는 사용자 그룹에 지정할 수 있습니다.
{: shortdesc}

IAM 정책에서 허용하는 것보다 세부 단위의 클러스터 액세스 정책이 필요합니까? 걱정하지 마십시오! 특정 Kubernetes 리소스에 대한 액세스 정책을 사용자, 사용자 그룹(Kubernetes v1.11 이상을 실행하는 클러스터의) 또는 서비스 계정에 지정할 수 있습니다. 역할을 작성한 후에 해당 역할을 특정 사용자 또는 그룹에 바인드할 수 있습니다. 자세한 정보는 Kubernetes 문서에 있는 [RBAC 권한 사용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview)을 참조하십시오.

그룹에 대해 바인딩이 작성되면 이는 해당 그룹에서 추가 또는 제거된 사용자에게 영향을 줍니다. 그룹에 사용자를 추가하는 경우, 해당 사용자는 추가 액세스 권한도 보유합니다. 이를 제거하면 해당 액세스 권한이 취소됩니다.
{: tip}

지속적 딜리버리 도구 체인 등의 서비스에 대한 액세스 권한을 지정하려면 [Kubernetes 서비스 계정 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)을 사용할 수 있습니다. 

**시작하기 전에**

- 클러스터를 [Kubernetes CLI](cs_cli_install.html#cs_cli_configure)의 대상으로 지정하십시오.
- 사용자 또는 그룹에게 서비스 레벨에서 최소한 `Viewer` 액세스 권한이 있는지 확인하십시오.


**RBAC 역할의 사용자 정의**

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
        <caption>이 YAML 컴포넌트 이해</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 YAML 컴포넌트 이해</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>`Role`을 사용하여 단일 네임스페이스 내 리소스에 액세스 권한을 부여하거나 클러스터 전반의 리소스에 `ClusterRole`을 사용하십시오.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Kubernetes 1.8 이상을 실행하는 클러스터의 경우 `rbac.authorization.k8s.io/v1`을 사용하십시오. </li><li>이전 버전의 경우 `apiVersion: rbac.authorization.k8s.io/v1beta1`을 사용하십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>`Role` 유형의 경우: 액세스 권한이 부여되는 Kubernetes 네임스페이스를 지정하십시오.</li><li>클러스터 레벨에 적용하는 `ClusterRole`을 작성하는 경우 `namespace` 필드를 사용하지 마십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>나중에 역할을 바인딩할 때 역할의 이름을 지정하고 이름을 사용하십시오.</td>
            </tr>
            <tr>
              <td><code>rules/apiGroups</code></td>
              <td><ul><li>`"apps"`, `"batch"` 또는 `"extensions"`와 같이 사용자가 상호작용할 수 있도록 Kubernetes API 그룹을 지정하십시오. </li><li>REST 경로 `api/v1`의 코어 API 그룹에 액세스하려면 그룹을 `[""]`와 같이 공백으로 두십시오.</li><li>자세한 정보는 Kubernetes 문서의 [API 그룹![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)을 참조하십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>`"daemonsets"`, `"deployments"`, `"events"` 또는 `"ingresses"`와 같이 액세스 권한을 부여할 Kubernetes 리소스를 지정하십시오.</li><li>`"nodes"`를 지정하는 경우 역할 유형은 `ClusterRole`이어야 합니다.</li><li>리소스 목록은 Kubernetes 치트 시트에서 [리소스 유형 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)의 표를 참조하십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>`"get"`, `"list"`, `"describe"`, `"create"` 또는 `"delete"`와 같이 사용자가 수행할 수 있는 조치의 유형을 지정하십시오. </li><li>verb에 대한 전체 목록은 [`kubectl` 문서![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/overview/)를 참조하십시오.</li></ul></td>
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

2.  역할을 사용자에 바인딩하십시오.

    1. `.yaml` 파일을 작성하여 역할에 사용자를 바인딩하십시오. 각 주제의 이름에 사용할 고유한 URL을 기록해 두십시오.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>이 YAML 컴포넌트 이해</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 YAML 컴포넌트 이해</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>두 가지 유형의 역할 `.yaml` 파일(네임스페이스 `Role` 및 클러스터 전반의 `ClusterRole`)에 대해 `kind`를 `RoleBinding`으로 지정하십시오.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Kubernetes 1.8 이상을 실행하는 클러스터의 경우 `rbac.authorization.k8s.io/v1`을 사용하십시오. </li><li>이전 버전의 경우 `apiVersion: rbac.authorization.k8s.io/v1beta1`을 사용하십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>`Role` 유형의 경우: 액세스 권한이 부여되는 Kubernetes 네임스페이스를 지정하십시오.</li><li>클러스터 레벨에 적용하는 `ClusterRole`을 작성하는 경우 `namespace` 필드를 사용하지 마십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>역할 바인딩의 이름을 지정하십시오.</td>
            </tr>
            <tr>
              <td><code>subjects/kind</code></td>
              <td>유형을 다음 중 하나로 지정하십시오.
              <ul><li>`User`: RBAC 역할을 계정의 개인 사용자에 바인드하십시오. </li>
              <li>`Group`: Kubernetes 1.11 이상을 실행하는 클러스터의 경우, RBAC 역할을 계정의 [IAM 그룹](/docs/iam/groups.html#groups)에 바인드하십시오. </li>
              <li>`ServiceAccount`: RBAC 역할을 클러스터의 네임스페이스의 서비스 계정에 바인드하십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**`User`의 경우**: 개별 사용자의 이메일 주소를 URL `https://iam.ng.bluemix.net/kubernetes#`에 추가하십시오. 예를 들면, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`입니다.</li>
              <li>**`Group`의 경우**: Kubernetes 1.11 이상을 실행하는 클러스터의 경우, 계정에서 [IAM 그룹](/docs/iam/groups.html#groups)의 이름을 지정하십시오. </li>
              <li>**`ServiceAccount`의 경우**: 서비스 계정 이름을 지정하십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>**`User` 또는 `Group`의 경우**: `rbac.authorization.k8s.io`를 사용하십시오. </li>
              <li>**`ServiceAccount`의 경우**: 이 필드를 포함하지 마십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/namespace</code></td>
              <td>**`ServiceAccount`에만 해당**: 서비스 계정이 배치된 Kubernetes 네임스페이스의 이름을 지정하십시오. </td>
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
        kubectl apply -f filepath/my_role_binding.yaml
        ```
        {: pre}

    3.  바인딩이 작성되었는지 확인하십시오.

        ```
        kubectl get rolebinding
        ```
        {: pre}

이제 사용자 정의 Kubernetes RBAC 역할을 작성하고 바인딩했습니다. 사용자에게 후속 조치를 취하십시오. 팟(Pod) 삭제와 같은 역할로 인해 완료할 권한이 있는 조치를 테스트하도록 사용자에게 요청하십시오.


<br />



## 사용자의 인프라 권한 사용자 정의
{: #infra_access}

Identity and Access Management에서 인프라 정책을 설정할 때 사용자에게 역할과 연관된 권한이 부여됩니다. 일부 정책은 사전 정의되어 있으나, 그 외의 정책은 사용자 정의할 수 있습니다. 해당 권한을 사용자 정의하려면 IBM Cloud 인프라(SoftLayer)에 로그인하고 거기에서 권한을 조정해야 합니다.
{: #view_access}

예를 들어, **기본 사용자**는 작업자 노드를 다시 부팅할 수 있지만 작업자 노드를 다시 로드할 수는 없습니다. 사용자에게 **수퍼유저** 권한을 부여하지 않고 IBM Cloud 인프라(SoftLayer) 권한을 조정하여 다시 로드 명령을 실행할 권한을 추가할 수 있습니다.

다중 구역 클러스터가 있는 경우, IBM Cloud 인프라(SoftLayer) 계정 소유자는 서로 다른 영역의 노드가 클러스터 내에서 통신할 수 있도록 VLAN Spanning을 켜야 합니다. 사용자가 VLAN Spanning을 사용으로 설정할 수 있도록 계정 소유자가 사용자에게 **네트워크 > 네트워크 VLAN Spanning 관리** 권한을 지정할 수도 있습니다. VLAN Spanning이 이미 사용으로 설정되었는지 확인하려면 `ibmcloud ks vlan-spanning-get` [명령](cs_cli_reference.html#cs_vlan_spanning_get)을 사용하십시오.
{: tip}


1.  [{{site.data.keyword.Bluemix_notm}} 계정](https://console.bluemix.net/)에 로그인한 후 메뉴에서 **인프라**를 선택하십시오.

2.  **계정** > **사용자** > **사용자 목록**으로 이동하십시오.

3.  권한을 수정하려면 사용자 프로파일의 이름 또는 **디바이스 액세스** 열을 선택하십시오.

4.  **포털 권한** 탭에서 사용자의 액세스 권한을 사용자 정의하십시오. 사용자에게 필요한 권한은 사용하는 데 필요한 인프라 리소스에 따라 달라집니다.

    * **빠른 권한** 드롭 다운 목록을 사용하여 사용자에게 모든 권한을 제공하는 **수퍼유저** 역할을 지정합니다.
    * **빠른 권한** 드롭 다운 목록을 사용하여 사용자에게 일부 필요한 권한(모든 권한은 아님)을 제공하는 **기본 사용자** 역할을 지정합니다.
    * **수퍼유저** 역할이 포함된 모든 권한을 부여하지 않거나 **기본 사용자** 역할 이상의 권한을 추가해야 하는 경우 {{site.data.keyword.containerlong_notm}}에서 공통 태스크를 수행하는 데 필요한 권한에 대해 설명하는 다음 표를 검토하십시오.

    <table summary="공통 {{site.data.keyword.containerlong_notm}} 시나리오에 대한 인프라 권한">
     <caption>{{site.data.keyword.containerlong_notm}}에 공통으로 필요한 인프라 권한</caption>
     <thead>
      <th>{{site.data.keyword.containerlong_notm}}의 공통 태스크</th>
      <th>탭에서 필요한 인프라 권한</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>최소 권한</strong>: <ul><li>클러스터 작성.</li></ul></td>
         <td><strong>디바이스</strong>:<ul><li>Virtual Server 세부사항 보기</li><li>서버 다시 부팅 및 IPMI 시스템 정보 보기</li><li>OS 다시 로드 실행 및 복구 커널 시작</li></ul><strong>계정</strong>: <ul><li>클라우드 인스턴스 추가/업그레이드</li><li>서버 추가</li></ul></td>
       </tr>
       <tr>
         <td><strong>클러스터 관리</strong>: <ul><li>클러스터 작성, 업데이트 및 삭제</li><li>작업자 노드 추가, 다시 로드 및 다시 부팅</li><li>VLAN 보기</li><li>서브넷 작성</li><li>팟(Pod) 및 로드 밸런서 서비스 배치</li></ul></td>
         <td><strong>지원</strong>:<ul><li>티켓 보기</li><li>티켓 추가</li><li>티켓 편집</li></ul>
         <strong>디바이스</strong>:<ul><li>Virtual Server 세부사항 보기</li><li>서버 다시 부팅 및 IPMI 시스템 정보 보기</li><li>서버 업그레이드</li><li>OS 다시 로드 실행 및 복구 커널 시작</li></ul>
         <strong>서비스</strong>:<ul><li>SSH 키 관리</li></ul>
         <strong>계정</strong>:<ul><li>계정 요약 보기</li><li>클라우드 인스턴스 추가/업그레이드</li><li>서버 취소</li><li>서버 추가</li></ul></td>
       </tr>
       <tr>
         <td><strong>스토리지</strong>: <ul><li>지속적 볼륨 클레임을 작성하여 지속적 볼륨 프로비저닝</li><li>스토리지 인프라 리소스 작성 및 관리</li></ul></td>
         <td><strong>서비스</strong>:<ul><li>스토리지 관리</li></ul><strong>계정</strong>:<ul><li>스토리지 추가</li></ul></td>
       </tr>
       <tr>
         <td><strong>사설 네트워크</strong>: <ul><li>클러스터 내부 네트워킹을 위한 사설 VLAN 관리</li><li>VPN 연결을 사설 네트워크에 설정</li></ul></td>
         <td><strong>네트워크</strong>:<ul><li>네트워크 서브넷 라우트 관리</li><li>IPSEC 네트워크 터널 관리</li><li>네트워크 게이트웨이 관리</li><li>VPN 관리</li></ul></td>
       </tr>
       <tr>
         <td><strong>사설 네트워킹</strong>:<ul><li>공용 로드 밸런서 또는 Ingress 네트워킹을 설정하여 앱 노출</li></ul></td>
         <td><strong>디바이스</strong>:<ul><li>Load Balancers 관리</li><li>호스트 이름/도메인 편집</li><li>포트 제어 관리</li></ul>
         <strong>네트워크</strong>:<ul><li>공용 네트워크 포트로 컴퓨팅 추가</li><li>네트워크 서브넷 라우트 관리</li><li>IP 주소 추가</li></ul>
         <strong>서비스</strong>:<ul><li>DNS, 리버스 DNS 및 WHOIS 관리</li><li>인증서(SSL) 보기</li><li>인증서(SSL) 관리</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  변경사항을 저장하려면 **포털 권한 편집**을 클릭하십시오.

6.  **디바이스 액세스** 탭에서 액세스 권한을 부여할 디바이스를 선택하십시오.

    * **디바이스 유형** 드롭 다운 목록에서 **모든 Virtual Server**에 대한 액세스 권한을 부여할 수 있습니다.
    * 사용자가 작성된 새 디바이스에 액세스할 수 있도록 허용하려면 **새 디바이스가 추가될 때 자동으로 액세스 권한 부여**를 선택하십시오.
    * 변경사항을 저장하려면 **디바이스 액세스 업데이트**를 클릭하십시오.

권한을 다운그레이드하고 계십니까? 이 조치가 완료되려면 몇 분 정도 소요됩니다.
{: tip}

<br />

