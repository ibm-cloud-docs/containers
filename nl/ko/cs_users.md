---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"


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

클러스터 관리자는 {{site.data.keyword.containerlong}} 클러스터에 대한 액세스 정책을 정의하여 다양한 사용자에 대해 서로 다른 액세스 레벨을 작성할 수 있습니다. 예를 들어, 특정 사용자는 클러스터 인프라 리소스에 대해 작업할 수 있도록 하고 다른 사용자는 컨테이너만 배치할 수 있도록 권한 부여할 수 있습니다.
{: shortdesc}

## 액세스 정책 및 역할 이해
{: #access_policies}

액세스 정책은 {{site.data.keyword.Bluemix_notm}} 계정의 사용자가 {{site.data.keyword.Bluemix_notm}} 플랫폼에서 리소스에 대해 갖는 액세스 권한 레벨을 결정합니다. 정책은 사용자에게 하나의 서비스, 또는 서비스와 리소스의 세트로 구성된 리소스 그룹에 대한 액세스 권한 범위를 정의하는 역할을 하나 이상 지정합니다. {{site.data.keyword.Bluemix_notm}}의 각 서비스는 자체 액세스 정책 세트를 필요로 할 수 있습니다.
{: shortdesc}

사용자 액세스 권한을 관리할 계획을 수립할 때는 다음과 같은 일반적인 단계를 고려하십시오. 
1.  [사용자에게 적합한 액세스 정책 및 역할 선택](#access_roles)
2.  [IAM에서 개별 사용자 또는 사용자 그룹에 액세스 역할 지정](#iam_individuals_groups)
3.  [사용자 액세스 권한을 클러스터 인스턴스 또는 리소스 그룹으로 범위 지정](#resource_groups)

계정 내 역할, 사용자 및 리소스의 관리 방법을 이해한 후에는 [클러스터에 대한 액세스 권한 설정](#access-checklist)에서 액세스 권한 구성 방법에 대한 체크리스트를 확인하십시오. 

### 사용자에게 적합한 액세스 정책 및 역할 선택
{: #access_roles}

{{site.data.keyword.containerlong_notm}}에 대해 작업하는 모든 사용자에 대해 액세스 정책을 정의해야 합니다. 액세스 정책의 범위는 사용자가 수행할 수 있는 조치를 결정하는, 사용자에게 정의된 역할을 기반으로 합니다. 일부 정책은 사전 정의되어 있으나, 그 외의 정책은 사용자 정의할 수 있습니다. IBM Cloud 인프라(SoftLayer)에서 조치가 완료되는 경우에도 사용자가 {{site.data.keyword.containerlong_notm}} GUI에서나 CLI를 통해 요청을 수행하는지에 관계없이 동일한 정책이 적용됩니다.
{: shortdesc}

다양한 권한 및 역할의 유형, 각 역할이 수행할 수 있는 조치, 각 역할의 연관 관계에 대해 알아보십시오. 

구체적인 각 역할별 {{site.data.keyword.containerlong_notm}} 권한을 보려면 [사용자 액세스 권한](cs_access_reference.html) 참조 주제를 참조하십시오.
{: tip}

<dl>

<dt><a href="#platform">IAM 플랫폼</a></dt>
<dd>{{site.data.keyword.containerlong_notm}}는 {{site.data.keyword.Bluemix_notm}} Identity and Access Management(IAM) 역할을 사용하여 클러스터에 대한 사용자 액세스 권한을 부여합니다. IAM 플랫폼 역할은 사용자가 클러스터에 대해 수행할 수 있는 조치를 결정합니다. 이러한 역할에 대한 정책은 지역별로 설정할 수 있습니다. IAM 플랫폼 역할이 지정된 모든 사용자에게는 `default` Kubernetes 네임스페이스의 해당 RBAC 역할이 자동으로 지정됩니다. 또한, IAM 플랫폼 역할은 사용자에게 클러스터에 대해 인프라 조치를 수행할 수 있도록 권한 부여하지만 IBM Cloud 인프라(SoftLayer) 리소스에 대한 액세스 권한은 부여하지 않습니다. IBM Cloud 인프라(SoftLayer) 리소스에 대한 액세스 권한은 [지역에 대해 설정된 API 키](#api_key)가 결정합니다. </br></br>
IAM 플랫폼 역할에 의해 허용되는 조치의 예를 들면 클러스터 작성 또는 제거, 클러스터에 서비스 바인딩, 작업자 노드 추가 등이 있습니다. </dd>
<dt><a href="#role-binding">RBAC</a></dt>
<dd>Kubernetes에서 역할 기반 액세스 제어(RBAC)는 클러스터 내의 리소스를 보호하는 방법입니다. RBAC 역할은 사용자가 리소스에 대해 수행할 수 있는 Kubernetes 조치를 결정합니다. IAM 플랫폼 역할이 지정된 모든 사용자에게는 `default` Kubernetes 네임스페이스의 해당 RBAC 클러스터 역할이 자동으로 지정됩니다. 이 RBAC 클러스터 역할은 선택하는 IAM 플랫폼 역할에 따라 기본 네임스페이스 또는 모든 네임스페이스에서 적용됩니다. </br></br>
RBAC 역할에 의해 허용되는 조치의 예를 들면 팟(Pod)과 같은 오브젝트의 작성, 팟(Pod) 로그 읽기 등이 있습니다. </dd>
<dt><a href="#api_key">인프라</a></dt>
<dd>인프라 역할은 IBM Cloud 인프라(SoftLayer) 리소스에 액세스할 수 있도록 합니다. 특정 사용자에게 **수퍼유저** 인프라 역할을 설정하고 이 사용자의 인프라 인증 정보를 API 키에 저장하십시오. 그 후, 클러스터를 작성할 각 지역에 해당 API 키를 설정하십시오. API 키를 설정하고 나면 해당 API 키를 지역 내 모든 사용자가 공유하므로 {{site.data.keyword.containerlong_notm}}에 대해 액세스 권한이 부여되는 다른 사용자에게 인프라 역할이 필요하지 않습니다. 대신 IAM 플랫폼 역할이 사용자가 수행할 수 있도록 허용되는 인프라 조치를 결정합니다. 전체 <strong>수퍼유저</strong> 인프라 역할로 API 키를 설정하지 않거나 사용자에게 특정 디바이스에 대한 액세스 권한을 부여해야 하는 경우에는 [인프라 권한을 사용자 정의](#infra_access)할 수 있습니다. </br></br>
인프라 역할에 의해 허용되는 조치의 예를 들면 클러스터 작업자 노드의 세부사항 보기, 네트워킹 및 스토리지 리소스 편집 등이 있습니다. </dd>
<dt>Cloud Foundry</dt>
<dd>{{site.data.keyword.Bluemix_notm}} IAM으로 관리할 수 없는 서비스도 있습니다. 이러한 서비스 중 하나를 사용하고 있는 경우에는 Cloud Foundry 사용자 역할을 계속 사용하여 해당 서비스에 대한 액세스를 제어할 수 있습니다. Cloud Foundry 역할은 계정 내 조직 및 영역에 대한 액세스 권한을 부여합니다. {{site.data.keyword.Bluemix_notm}}에 있는 Cloud Foundry 기반 서비스의 목록을 보려면 <code>ibmcloud service list</code>를 실행하십시오. </br></br>
Cloud Foundry 역할에 의해 허용되는 조치의 예를 들면 새 Cloud Foundry 서비스 인스턴스 작성, 클러스터에 Cloud Foundry 서비스 인스턴스 바인딩 등이 있습니다. 더 자세히 알아보려면 IAM 문서에서 사용 가능한 [조직 및 영역 역할](/docs/iam/cfaccess.html)을 참조하거나 [Cloud Foundry 액세스 권한 관리](/docs/iam/mngcf.html) 단계를 참조하십시오. </dd>
</dl>

### IAM에서 개별 사용자 또는 사용자 그룹에 액세스 역할 지정
{: #iam_individuals_groups}

IAM 정책을 설정하면 개별 사용자 또는 사용자 그룹에 역할을 지정할 수 있습니다.
{: shortdesc}

<dl>
<dt>개별 사용자</dt>
<dd>팀의 나머지 구성원보다 더 많거나 적은 권한이 필요한 특정 사용자가 있을 수 있습니다. 각 사용자가 자신의 태스크를 완료하는 데 필요한 권한을 보유할 수 있도록 개인별로 권한을 사용자 정의할 수 있습니다. 각 사용자에게는 둘 이상의 IAM 역할을 지정할 수 있습니다. </dd>
<dt>액세스 그룹의 여러 사용자</dt>
<dd>사용자 그룹을 작성하고 해당 그룹에 권한을 지정할 수 있습니다. 예를 들면, 모든 팀 리더를 그룹화하고 해당 그룹에 관리자 액세스 권한을 지정할 수 있습니다. 그 후에는 모든 개발자를 그룹화하고 해당 그룹에 쓰기 액세스 권한만 지정할 수 있습니다. 각 액세스 그룹에는 둘 이상의 IAM 역할을 지정할 수 있습니다. 그룹에 권한을 지정하면 해당 그룹에서 추가되거나 제거되는 모든 사용자가 영향을 받습니다.  그룹에 사용자를 추가하는 경우, 해당 사용자는 추가 액세스 권한도 보유합니다. 이를 제거하면 해당 액세스 권한이 취소됩니다.</dd>
</dl>

IAM 역할은 서비스 계정에 지정될 수 없습니다. 대신 직접 [서비스 계정에 RBAC 역할을 지정](#rbac)할 수 있습니다.
{: tip}

사용자가 액세스 권한을 갖는 계정 내 항목의 범위(한 리소스 그룹 내의 한 클러스터, 한 리소스 그룹 내의 모든 클러스터, 모든 리소스 그룹 내의 모든 클러스터) 또한 지정해야 합니다. 

### 사용자 액세스 권한을 클러스터 인스턴스 또는 리소스 그룹으로 범위 지정
{: #resource_groups}

IAM에서는 리소스 인스턴스 또는 리소스 그룹에 대해 사용자 액세스 역할을 지정할 수 있습니다.
{: shortdesc}

{{site.data.keyword.Bluemix_notm}} 계정을 작성하면 기본 리소스 그룹이 자동으로 작성됩니다. 리소스를 작성할 때 리소스 그룹을 지정하지 않으면 리소스 인스턴스(클러스터)가 기본 리소스 그룹에 속하게 됩니다. 계정에 리소스 그룹을 추가하려는 경우에는 [계정 설정에 대한 우수 사례 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications) 및 [리소스 그룹 설정](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups)을 참조하십시오. 

<dl>
<dt>리소스 인스턴스</dt>
  <dd><p>계정 내의 각 {{site.data.keyword.Bluemix_notm}} 서비스는 인스턴스를 보유하는 리소스입니다. 인스턴스는 서비스에 따라 다릅니다. 예를 들면, {{site.data.keyword.containerlong_notm}}에서는 인스턴스가 클러스터이지만, {{site.data.keyword.cloudcerts_long_notm}}에서는 인스턴스가 인증서입니다. 기본적으로 리소스는 계정의 기본 리소스 그룹에도 속합니다. 다음 시나리오의 경우에는 사용자에게 리소스 인스턴스에 대한 액세스 역할을 지정할 수 있습니다.
  <ul><li>{{site.data.keyword.containerlong_notm}}의 모든 클러스터와 {{site.data.keyword.registrylong_notm}}의 이미지를 포함, 계정 내 모든 IAM 서비스. </li>
  <li>{{site.data.keyword.containerlong_notm}}의 모든 클러스터와 같은, 특정 서비스 내의 모든 인스턴스. </li>
  <li>{{site.data.keyword.containerlong_notm}}의 **미국 남부** 지역에 있는 모든 클러스터와 같은, 특정 서비스의 특정 지역 내에 있는 모든 인스턴스. </li>
  <li>하나의 클러스터와 같은 개별 인스턴스. </li></ul></dd>
<dt>리소스 그룹</dt>
  <dd><p>개별 사용자 또는 사용자 그룹에 한 번에 둘 이상의 리소스에 대한 액세스 권한을 신속하게 지정할 수 있도록 계정 리소스를 사용자 정의할 수 있는 그룹으로 구성할 수 있습니다. 리소스 그룹은 운영자 및 관리자가 리소스를 해당 용도별로 보고, 문제를 해결하고, 팀을 관리하기 위해 리소스를 필터링하는 데 도움을 줍니다. </p>
  <p>**중요**: {{site.data.keyword.Bluemix_notm}} 계정에 클러스터에서 사용할 다른 서비스가 있는 경우에는 해당 서비스와 클러스터가 동일한 리소스 그룹에 속해야 합니다. 특정 리소스는 하나의 리소스 그룹에서만 작성될 수 있으며 이후에는 이를 변경할 수 없습니다. 클러스터를 잘못된 리소스 그룹에 작성한 경우에는 해당 클러스터를 삭제하고 올바른 리소스 그룹에서 다시 작성해야 합니다. </p>
  <p>[메트릭에 대해 {{site.data.keyword.monitoringlong_notm}}](cs_health.html#view_metrics)을 사용하려는 경우에는 메트릭 이름 충돌을 방지하기 위해 계정 내 리소스 그룹 및 지역 전체에서 클러스터에 고유한 이름을 지정하는 것을 고려하십시오. 클러스터의 이름은 바꿀 수 없습니다. </p>
  <p>다음 시나리오의 경우에는 사용자에게 리소스 그룹에 대한 액세스 역할을 지정할 수 있습니다. 리소스 인스턴스와 달리, 특정 리소스 그룹 내의 개별 인스턴스에 대해 액세스 권한을 부여할 수는 없다는 점을 참고하십시오. </p>
  <ul><li>{{site.data.keyword.containerlong_notm}}의 모든 클러스터와 {{site.data.keyword.registrylong_notm}}의 이미지를 포함, 리소스 그룹 내 모든 IAM 서비스. </li>
  <li>{{site.data.keyword.containerlong_notm}}의 모든 클러스터와 같은, 리소스 그룹 내 특정 서비스에 속한 모든 인스턴스. </li>
  <li>{{site.data.keyword.containerlong_notm}}의 **미국 남부** 지역에 있는 모든 클러스터와 같은, 리소스 그룹 내 특정 서비스의 특정 지역에 속한 모든 인스턴스. </li></ul></dd>
</dl>

<br />


## 클러스터에 대한 액세스 권한 설정
{: #access-checklist}

[계정 내 역할, 사용자 및 리소스의 관리 방법을 이해](#access_policies)한 후에는 다음 체크리스트를 사용하여 클러스터 내의 사용자 액세스 권한을 구성하십시오.
{: shortdesc}

1. 클러스터를 작성할 모든 지역 및 리소스 그룹에 대해 [API 키를 설정](#api_key)하십시오. 
2. 사용자를 계정으로 초대하고 {{site.data.keyword.containerlong_notm}}에 대한 [IAM 역할을 지정](#platform)하십시오. 
3. 사용자가 클러스터에 서비스를 바인드하거나 클러스터 로깅 구성으로부터 전달된 로그를 볼 수 있도록 허용하려면 서비스가 배치되거나 로그가 수집된 조직 및 영역에 대해 [사용자에게 Cloud Foundry 역할을 부여](/docs/iam/mngcf.html)하십시오. 
4. 클러스터 내 리소스를 격리하기 위해 Kubernetes 네임스페이스를 사용하는 경우에는 [다른 네임스페이스에 **Viewer** 및 **Editor** IAM 플랫폼 역할에 대한 Kubernetes RBAC 역할 바인딩을 복사](#role-binding)하십시오. 
5. CI/CD 파이프라인과 같은 자동화 도구의 경우에는 서비스 계정을 설정하고 [서비스 계정 Kubernetes RBAC 권한을 지정](#rbac)하십시오. 
6. 팟(Pod) 레벨에서 클러스터 리소스에 대한 액세스를 제어하기 위한 기타 고급 구성에 대해서는 [팟(Pod) 보안 구성](/docs/containers/cs_psp.html)을 참조하십시오. 

</br>

계정 및 리소스를 설정하는 데 대한 자세한 정보를 얻으려면 [사용자, 팀 및 애플리케이션 구성에 대한 우수 사례](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications)와 관련된 튜토리얼을 수행해 보십시오.
{: tip}

<br />


## 인프라 포트폴리오에 대한 액세스를 가능하게 하기 위한 API 키 설정
{: #api_key}

클러스터를 프로비저닝하고 이에 대해 작업하려면 {{site.data.keyword.Bluemix_notm}} 계정이 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스할 수 있도록 올바르게 설정되었는지 확인해야 합니다.
{: shortdesc}

**대부분의 경우**: 사용자의 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정에는 이미 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한이 있습니다. 이 포트폴리오에 액세스할 수 있도록 {{site.data.keyword.containerlong_notm}}를 설정하려면 **계정 소유자**가 지역 및 리소스 그룹에 대해 API 키를 설정해야 합니다. 

1. 터미널에 계정 소유자로서 로그인하십시오.
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. API 키를 설정할 리소스 그룹을 대상으로 지정하십시오. 리소스 그룹을 대상으로 지정하지 않으면 API 키가 기본 리소스 그룹에 대해 설정됩니다.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. 다른 지역에 있는 경우에는 API 키를 설정할 지역으로 변경하십시오.
    ```
ibmcloud ks region-set
    ```
    {: pre}

4. 지역 및 리소스 그룹에 대해 API 키를 설정하십시오.
    ```
  ibmcloud ks api-key-reset
    ```
    {: pre}    

5. API 키가 설정되었는지 확인하십시오.
    ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
    ```
    {: pre}

6. 클러스터를 작성할 각 지역 및 리소스 그룹에 대해 작업을 반복하십시오. 

**대체 방법 및 자세한 정보**: IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 다른 방법은 다음 섹션을 참조하십시오. 
* 계정의 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한 유무를 모르는 경우에는 [IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 이해](#understand_infra)를 참조하십시오. 
* 계정 소유자가 API 키를 설정하지 않는 경우에는 [API 키를 설정하는 사용자에게 올바른 권한이 있는지 확인](#owner_permissions)하십시오. 
* API 키를 설정하기 위해 기본 계정을 사용하는 데 대한 자세한 정보는 [기본 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정을 사용하여 인프라 포트폴리오에 액세스](#default_account)를 참조하십시오. 
* 기본 종량과금제 계정이 없거나 다른 IBM Cloud 인프라(SoftLayer) 계정을 사용해야 하는 경우에는 [다른 IBM Cloud 인프라(SoftLayer) 계정에 액세스](#credentials)를 참조하십시오. 

### IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 이해
{: #understand_infra}

계정에 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한이 있는지 판별하고, {{site.data.keyword.containerlong_notm}}가 어떻게 API 키를 사용하여 이 포트폴리오에 액세스하는지 알아보십시오.
{: shortdesc}

**내 계정에 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한이 있습니까?**</br>

IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 데는 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정을 사용합니다. 다른 유형의 계정이 있는 경우에는 다음 표에 있는 선택사항을 보십시오. 

<table summary="표에서는 계정 유형별로 표준 클러스터 작성 옵션을 보여줍니다. 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며, 계정 설명은 1열에 있고 표준 클러스터 작성을 위한 옵션은 2열에 있습니다.">
<caption>계정 유형별 표준 클러스터 작성 옵션</caption>
  <thead>
  <th>계정 설명</th>
  <th>표준 클러스터를 작성하기 위한 옵션</th>
  </thead>
  <tbody>
    <tr>
      <td>**Lite 계정**은 클러스터를 프로비저닝할 수 없습니다.</td>
      <td>[Lite 계정을 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정으로 업그레이드](/docs/account/index.html#paygo)하십시오. </td>
    </tr>
    <tr>
      <td>**종량과금제** 계정에는 인프라 포트폴리오에 대한 액세스 권한이 함께 제공됩니다. </td>
      <td>표준 클러스터를 작성할 수 있습니다. API 키를 사용하여 클러스터의 인프라 권한을 설정하십시오. </td>
    </tr>
    <tr>
      <td>**구독 계정**은 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한으로 설정되어 있지 않습니다.</td>
      <td><p><strong>옵션 1:</strong> IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한으로 설정된 [새 종량과금제 계정을 작성](/docs/account/index.html#paygo)합니다. 이 옵션을 선택하는 경우에는 두 개의 별도 {{site.data.keyword.Bluemix_notm}} 계정과 비용 청구가 있습니다.</p><p>계속해서 구독 계정을 사용하려는 경우 새 종량과금제 계정을 사용하여 IBM Cloud 인프라(SoftLayer)에 API 키를 생성할 수 있습니다. 그리고 구독 계정에 대한 IBM Cloud 인프라(SoftLayer) API 키를 수동으로 설정해야 합니다. IBM Cloud 인프라(SoftLayer) 리소스가 새 종량과금제 계정을 통해 비용 청구된다는 점을 유념하십시오.</p><p><strong>옵션 2:</strong> 사용하고자 하는 기존 IBM Cloud 인프라(SoftLayer) 계정을 이미 보유 중인 경우에는 {{site.data.keyword.Bluemix_notm}} 계정에 대한 IBM Cloud 인프라(SoftLayer) 인증 정보를 수동으로 설정할 수 있습니다.</p><p>**참고:** IBM Cloud 인프라(SoftLayer) 계정에 수동으로 연결하는 경우 인증 정보가 {{site.data.keyword.Bluemix_notm}} 계정의 모든 IBM Cloud 인프라(SoftLayer) 특정 조치에 대해 사용됩니다. 사용자가 클러스터를 작성하고 작업할 수 있도록 설정한 API 키에 [충분한 인프라 권한](cs_users.html#infra_access)이 있는지 확인해야 합니다.</p></td>
    </tr>
    <tr>
      <td>**IBM Cloud 인프라(SoftLayer) 계정**({{site.data.keyword.Bluemix_notm}} 계정이 아님)</td>
      <td><p>[{{site.data.keyword.Bluemix_notm}} 종량과금제 계정을 작성](/docs/account/index.html#paygo)하십시오. 두 개의 별도 IBM Cloud 인프라(SoftLayer) 계정과 비용 청구가 있습니다.</p><p>기본적으로 새 {{site.data.keyword.Bluemix_notm}} 계정은 새 인프라 계정을 사용합니다. 이전 인프라 계정을 계속 사용하려면 인증 정보를 수동으로 설정하십시오. </p></td>
    </tr>
  </tbody>
  </table>

**내 인프라 포트폴리오가 설정된 상태에서, {{site.data.keyword.containerlong_notm}}는 이 포트폴리오에 어떻게 액세스합니까?**</br>

{{site.data.keyword.containerlong_notm}}는 API 키를 사용하여 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스합니다. 이 API 키는 IBM Cloud 인프라(SoftLayer) 계정에 대한 액세스 권한이 있는 사용자의 인증 정보를 저장합니다. API 키는 리소스 그룹 내에서 지역별로 설정되며, 해당 지역의 사용자는 이를 공유합니다.
 
모든 사용자가 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스할 수 있도록 하려면 API 키에 인증 정보가 저장되는 사용자에게 IBM Cloud 계정에 있는 {{site.data.keyword.containerlong_notm}}에 대한 [**수퍼유저** 인프라 역할 및 **Administrator** 플랫폼 역할](#owner_permissions)이 있어야 합니다. 그 후 해당 사용자가 지역에서의 첫 번째 관리 조치를 수행하도록 하십시오. 이 사용자의 인프라 인증 정보가 해당 지역에 대한 API 키에 저장됩니다. 계정의 다른 사용자는 이 API 키를 공유하여 인프라에 액세스합니다. 이 경우에는 적절한 [IAM 플랫폼 역할](#platform)을 지정함으로써 사용자가 수행할 수 있는 인프라 조치를 제어할 수 있습니다. 

예를 들어, 새 지역에 클러스터를 작성하려는 경우에는 계정 소유자와 같이 **수퍼유저** 인프라 역할이 있는 사용자가 첫 번째 클러스터를 작성하도록 하십시오. 그 후에는 특정 지역의 IAM 엑세스 그룹에 속한 사용자에 대한 IAM 플랫폼 관리 정책을 설정함으로써 이러한 사용자를 해당 지역으로 초대할 수 있습니다. `Viewer` IAM 플랫폼 역할이 있는 사용자에게는 작업자 노드를 추가할 권한이 없습니다. 따라서 API 키에 올바른 인프라 권한이 있어도 `worker-add` 조치가 실패합니다. 이 사용자의 IAM 플랫폼 역할을 **Operator**로 변경하면 이 사용자에게 작업자 노드를 추가할 권한이 부여됩니다. 사용자 역할에 권한이 부여되고 API 키가 올바로 설정되었으므로 `worker-add` 조치가 성공합니다. 이 사용자의 IBM Cloud 인프라(SoftLayer) 권한을 편집할 필요는 없습니다. 

**API 키 소유자 또는 인증 정보 소유자에게 수퍼유저 인프라 역할을 지정하지 않으면 어떻게 됩니까?**</br>

규제 준수, 보안 또는 비용 청구 관련 이유로 인해 API 키를 설정하는 사용자 또는 `ibmcloud ks credentials-set` 명령으로 인증 정보가 설정되는 사용자에게 **수퍼유저** 인프라 역할을 지정하지 않으려 하는 경우가 있습니다. 그러나 이 사용자에게 **수퍼유저** 역할이 없으면 클러스터 작성 또는 작업자 노드 다시 로드와 같은 인프라 관련 조치가 실패할 수 있습니다. 이 경우에는 IAM 플랫폼 역할을 사용하여 사용자의 인프라 액세스를 제어하는 대신, 사용자에 대해 [특정 IBM Cloud 인프라(SoftLayer) 권한을 설정](#infra_access)해야 합니다. 

**클러스터에 대해 API 키를 설정하는 방법은 무엇입니까?**</br>

이는 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 데 사용하는 계정의 유형에 따라 달라집니다. 
* [기본 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정](#default_account)
* [기본 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정과 연결되지 않은, 다른 IBM Cloud 인프라(SoftLayer) 계정](#credentials)

### API 키 또는 인프라 인증 정보 소유자의 올바른 권한 보유 확인
{: #owner_permissions}

클러스터에서 모든 인프라 관련 조치를 완료할 수 있도록 하려면 API 키에 대해 인증 정보가 설정되는 사용자에게 적절한 권한이 있어야 합니다.
{: shortdesc}

1. [{{site.data.keyword.Bluemix_notm}} 콘솔![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/)에 로그인하십시오.

2. 모든 계정 관련 조치가 성공적으로 수행될 수 있도록 하려면 사용자에게 올바른 IAM 플랫폼 역할이 있는지 확인하십시오. 
    1. **관리 > 계정 > 사용자**로 이동하십시오. 
    2. API 키를 설정할 사용자 또는 API 키에 대해 인증 정보를 설정할 사용자의 이름을 클릭하십시오. 
    3. 해당 사용자에게 모든 지역의 모든 {{site.data.keyword.containerlong_notm}} 클러스터에 대한 **Administrator** 역할이 없는 경우에는 [이 사용자에게 해당 플랫폼 역할을 지정](#platform)하십시오. 
    4. 해당 사용자에게 API 키를 설정할 리소스 그룹에 대한 **Viewer** 이상의 역할이 없는 경우에는 [이 사용자에게 해당 리소스 그룹 역할을 지정](#platform)하십시오. 
    5. 이 사용자는 클러스터를 작성하기 위해 {{site.data.keyword.registryshort_notm}}에 대한 **Administrator** 역할 또한 필요로 합니다. 

3. 클러스터 내의 모든 인프라 관련 조치가 성공적으로 수행될 수 있도록 하려면 사용자에게 올바른 인프라 액세스 정책이 있는지 확인하십시오. 
    1. 펼치기 메뉴에서 **인프라**를 선택하십시오.
    2. 메뉴 표시줄에서 **계정** > **사용자** > **사용자 목록**을 선택하십시오.
    3. **API 키** 열에서 사용자가 API 키를 보유하는지 확인하거나 **생성**을 클릭하십시오.
    4. 사용자 프로파일의 이름을 선택하고 사용자의 권한을 확인하십시오. 
    5. 해당 사용자에게 **수퍼유저** 역할이 없는 경우에는 **포털 권한** 탭을 클릭하십시오. 
        1. **빠른 권한** 드롭 다운 목록을 사용하여 **수퍼유저** 역할을 지정하십시오. 
        2. **권한 설정**을 클릭하십시오. 

### 기본 {{site.data.keyword.Bluemix_notm}} 종량과금제 계정을 사용하여 인프라 포트폴리오에 액세스
{: #default_account}

{{site.data.keyword.Bluemix_notm}} 종량과금제 계정이 있는 경우에는 연결된 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 권한이 기본적으로 제공됩니다. API 키는 이 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 새 작업자 노드 또는 VLAN과 같은 인프라 리소스를 주문하는 데 사용됩니다.
{: shortdec}

[`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info)를 실행하여 현재 API 키 소유자를 찾을 수 있습니다. 지역에 대해 저장된 API 키를 업데이트해야 한다고 판단되면 [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset) 명령을 실행하여 이를 수행할 수 있습니다. 이 명령은 {{site.data.keyword.containerlong_notm}} 관리자 액세스 정책이 필요하고 계정에서 이 명령을 실행하는 사용자의 API 키를 저장합니다. **참고**: 키를 재설정할지 확인하고, 이 작업이 앱에 미치는 영향을 파악하십시오. 키는 여러 다른 위치에서 사용되며 이를 불필요하게 변경하면 기타 컴포넌트에 영향을 줄 수 있는 변경사항(breaking changes)이 발생할 수 있습니다. 

**시작하기 전에**:
- 계정 소유자가 API 키를 설정하지 않는 경우에는 [API 키를 설정하는 사용자에게 올바른 권한이 있는지 확인](#owner_permissions)하십시오. 
- [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](cs_cli_install.html#cs_cli_configure). 

IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하기 위해 API 키를 설정하려면 다음 작업을 수행하십시오. 

1.  클러스터가 속한 지역 및 리소스 그룹에 대한 API 키를 설정하십시오. 
    1.  사용하고자 하는 인프라 권한이 있는 사용자로 터미널에 로그인하십시오.
    2.  API 키를 설정할 리소스 그룹을 대상으로 지정하십시오. 리소스 그룹을 대상으로 지정하지 않으면 API 키가 기본 리소스 그룹에 대해 설정됩니다.
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  다른 지역에 있는 경우에는 API 키를 설정할 지역으로 변경하십시오.
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  지역에 대한 사용자의 API 키를 설정하십시오.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  API 키가 설정되었는지 확인하십시오.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

2. [클러스터를 작성](cs_clusters.html)하십시오. 클러스터를 작성하는 데는 지역 및 리소스 그룹에 대해 설정한 API 키 인증 정보가 사용됩니다. 

### 다른 IBM Cloud 인프라(SoftLayer) 계정에 액세스
{: #credentials}

지역 내 클러스터를 위한 인프라를 주문하는 데 IBM Cloud 인프라(SoftLayer) 계정을 사용하는 대신, 이미 보유하고 있는 다른 IBM Cloud 인프라(SoftLayer) 계정을 사용하려 하는 경우가 있습니다. [`ibmcloud ks credentials-set`](cs_cli_reference.html#cs_credentials_set) 명령을 사용하여 이 인프라 계정을 {{site.data.keyword.Bluemix_notm}} 계정에 연결할 수 있습니다. 지역에 대해 저장된 기본 종량과금제 계정의 인증 정보 대신 이 IBM Cloud 인프라(SoftLayer) 인증 정보가 사용됩니다. 

**중요**: `ibmcloud ks credentials-set` 명령에 의해 설정된 IBM Cloud 인프라(SoftLayer) 인증 정보는 세션이 종료된 후 지속됩니다. [`ibmcloud ks credentials-unset`](cs_cli_reference.html#cs_credentials_unset) 명령을 사용하여 수동으로 설정한 IBM Cloud 인프라(SoftLayer) 인증 정보를 제거하면 기본 종량과금제 계정 인증 정보가 사용됩니다. 그러나 이 인프라 계정 인증 정보 변경은 [고아 클러스터](cs_troubleshoot_clusters.html#orphaned)를 발생시킬 수 있습니다. 

**시작하기 전에**:
- 계정 소유자의 인증 정보를 사용하고 있지 않은 경우에는 [API 키에 대해 인증 정보를 설정할 사용자에게 올바른 권한이 있는지 확인](#owner_permissions)하십시오. 
- [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](cs_cli_install.html#cs_cli_configure). 

IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하기 위해 인프라 계정 인증 정보를 설정하려면 다음 작업을 수행하십시오. 

1. IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 데 사용할 인프라 계정을 가져오십시오. [현재 계정 유형](#understand_infra)에 따라 여러 선택사항이 있습니다. 

2.  올바른 계정의 사용자로 인프라 API 인증 정보를 설정하십시오.

    1.  사용자의 인프라 API 인증 정보를 가져오십시오. **참고**: 인증 정보는 IBM ID와는 다릅니다.

        1.  [{{site.data.keyword.Bluemix_notm}} ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/) 콘솔 **인프라** > **계정** > **사용자** > **사용자 목록** 테이블에서 **IBM ID 또는 사용자 이름**을 클릭하십시오.

        2.  **API 액세스 정보** 섹션에서 **API 사용자 이름** 및 **인증 키**를 보십시오.    

    2.  사용할 인프라 API 인증 정보를 설정하십시오.   
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

    3. 올바른 인증 정보가 설정되었는지 확인하십시오.
        ```
        ibmcloud ks credential-get
        ```
출력 예:
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [클러스터를 작성](cs_clusters.html)하십시오. 클러스터를 작성하는 데는 지역 및 리소스 그룹에 대해 설정한 인프라 인증 정보가 사용됩니다. 

4. 자신이 설정한 인프라 계정 신임 정보를 클러스터가 사용하는지 확인하십시오. 
  1. [IBM Cloud Kubernetes Service GUI ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/containers-kubernetes/clusters)를 열고 클러스터를 선택하십시오. 
  2. 개요 탭에서 **인프라 사용자** 필드를 찾으십시오. 
  3. 해당 필드가 나타나는 경우에는 이 지역에서 종량과금제 계정과 함께 제공되는 기본 인프라 인증 정보를 사용하지 않는 것입니다. 대신, 이 지역은 사용자가 설정한 것과 다른 인프라 계정 인증 정보를 사용하도록 설정되어 있습니다. 

<br />


## IAM을 통해 클러스터에 대한 사용자 액세스 권한 부여
{: #platform}

사용자가 {{site.data.keyword.containerlong_notm}} 내의 클러스터에 대해 작업할 수 있도록 [GUI](#add_users) 또는 [CLI](#add_users_cli)에서 IAM 플랫폼 관리 정책을 설정하십시오. 시작하기 전에, [액세스 정책 및 역할 이해](#access_policies)를 참조하여 어떤 정책이 있는지, 정책을 누구에게 지정할 수 있는지, 어떤 리소스에 정책을 부여할 수 있는지 검토하십시오.
{: shortdesc}

IAM 역할은 서비스 계정에 지정될 수 없습니다. 대신 직접 [서비스 계정에 RBAC 역할을 지정](#rbac)할 수 있습니다.
{: tip}

### GUI를 사용하여 IAM 역할 지정
{: #add_users}

GUI를 사용하여 IAM 플랫폼 관리 역할을 지정함으로써 사용자에게 클러스터에 대한 액세스 권한을 부여하십시오.
{: shortdesc}

시작하기 전에, 사용자에게 작업 중인 {{site.data.keyword.Bluemix_notm}} 계정에 대한 **Administrator** IAM 플랫폼 역할이 지정되었는지 확인하십시오. 

1. [IBM Cloud GUI](https://console.bluemix.net/)에 로그인하여 **관리 > 계정 > 사용자**로 이동하십시오. 

2. 사용자를 개별적으로 선택하거나 사용자의 액세스 그룹을 작성하십시오. 
    * 개별 사용자에게 역할을 지정하려면 다음 작업을 수행하십시오. 
      1. 해당 권한을 설정할 사용자의 이름을 클릭하십시오. 사용자가 표시되지 않으면 **사용자 초대**를 클릭하여 사용자를 계정에 추가하십시오. 
      2. **액세스 권한 지정**을 클릭하십시오. 
    * 액세스 그룹 내의 여러 사용자에게 역할을 지정하려면 다음 작업을 수행하십시오. 
      1. 왼쪽 탐색에서 **액세스 그룹**을 클릭하십시오. 
      2. **작성**을 클릭하고 그룹에 **이름** 및 **설명**을 부여하십시오. **작성**을 클릭하십시오.
      3. **사용자 추가**를 클릭하여 사용자를 액세스 그룹에 추가하십시오. 계정에 대한 액세스 권한이 있는 모든 사용자가 표시됩니다.
      4. 그룹에 추가할 사용자 옆의 상자를 선택하십시오. 대화 상자가 표시됩니다.
      5. **그룹에 추가**를 클릭하십시오.
      6. **액세스 정책**을 클릭하십시오. 
      7. **액세스 권한 지정**을 클릭하십시오. 

3. 정책을 지정하십시오.
  * 한 리소스 그룹 내의 모든 클러스터에 대한 액세스의 경우에는 다음 작업을 수행하십시오. 
    1. **한 리소스 그룹 내의 액세스 권한 지정**을 클릭하십시오. 
    2. 리소스 그룹 이름을 선택하십시오. 
    3. **서비스** 목록에서 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
    4. **지역** 목록에서 한 지역 또는 모든 지역을 선택하십시오. 
    5. **플랫폼 액세스 역할**을 선택하십시오. 각 역할에 대해 지원되는 조치의 목록을 찾으려면 [사용자 액세스 권한](/cs_access_reference.html#platform)을 참조하십시오. 
    6. **지정**을 클릭하십시오.
  * 한 리소스 그룹 내의 한 클러스터, 또는 모든 리소스 그룹 내의 모든 클러스터에 대한 액세스의 경우에는 다음 작업을 수행하십시오. 
    1. **리소스에 대한 액세스 권한 지정**을 클릭하십시오. 
    2. **서비스** 목록에서 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
    3. **지역** 목록에서 한 지역 또는 모든 지역을 선택하십시오. 
    4. **서비스 인스턴스** 목록에서 클러스터 이름 또는 **모든 서비스 인스턴스**를 선택하십시오. 
    5. **역할 선택** 섹션에서 IAM 플랫폼 역할을 선택하십시오. 각 역할에 대해 지원되는 조치의 목록을 찾으려면 [사용자 액세스 권한](/cs_access_reference.html#platform)을 참조하십시오. 참고: 특정 사용자에게 하나의 클러스터에 대한 **Administrator** IAM 플랫폼 역할만 지정하는 경우에는 이 사용자에게 리소스 그룹에서 해당 지역에 속한 모든 클러스터에 대한 **Viewer** 역할도 지정해야 합니다. 
    6. **지정**을 클릭하십시오.

4. 사용자가 기본 외의 리소스 그룹에 속한 클러스터에 대해 작업할 수 있도록 하려는 경우 이러한 사용자에게는 클러스터가 속한 리소스 그룹에 대한 추가 액세스 권한이 필요합니다. 이러한 사용자에게는 리소스 그룹에 대한 **Viewer** 이상의 역할을 지정할 수 있습니다. 
  1. **한 리소스 그룹 내의 액세스 권한 지정**을 클릭하십시오. 
  2. 리소스 그룹 이름을 선택하십시오. 
  3. **한 리소스 그룹에 대한 액세스 권한 지정** 목록에서 **Viewer** 역할을 선택하십시오. 이 역할은 사용자가 해당 리소스 그룹 자체에 액세스하는 것은 허용하지만, 이 그룹 내의 리소스에 액세스하는 것은 허용하지 않습니다. 
  4. **지정**을 클릭하십시오.

### CLI를 사용하여 IAM 역할 지정
{: #add_users_cli}

CLI를 사용하여 IAM 플랫폼 관리 역할을 지정함으로써 사용자에게 클러스터에 대한 액세스 권한을 부여하십시오.
{: shortdesc}

**시작하기 전에**:

- 사용자에게 작업 중인 {{site.data.keyword.Bluemix_notm}} 계정에 대한 `cluster-admin` IAM 플랫폼 역할이 지정되었는지 확인하십시오. 
- 사용자가 계정에 추가되었는지 확인하십시오. 사용자가 계정에 추가되지 않은 경우에는 `ibmcloud account user-invite <user@email.com>`을 실행하여 사용자를 계정으로 초대하십시오. 
- [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](cs_cli_install.html#cs_cli_configure). 

**CLI를 사용하여 개별 사용자에게 IAM 역할을 지정하려면 다음 작업을 수행하십시오. **

1.  {{site.data.keyword.containerlong_notm}}(**`--service-name containers-kubernetes`**)에 대한 권한을 설정하기 위한 IAM 액세스 정책을 작성하십시오. IAM 플랫폼 역할에 대해 Viewer, Editor, Operator 및 Administrator를 선택할 수 있습니다. 각 역할에 대해 지원되는 조치의 목록을 찾으려면 [사용자 액세스 권한](cs_access_reference.html#platform)을 참조하십시오. 
    * 한 리소스 그룹 내의 한 클러스터에 대한 액세스 권한을 지정하려면 다음 명령을 실행하십시오.
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **참고**: 특정 사용자에게 하나의 클러스터에 대한 **Administrator** IAM 플랫폼 역할만 지정하는 경우에는 이 사용자에게 리소스 그룹에서 해당 지역에 속한 모든 클러스터에 대한 **Viewer** 역할도 지정해야 합니다. 

    * 한 리소스 그룹 내의 모든 클러스터에 대한 액세스 권한을 지정하려면 다음 명령을 실행하십시오.
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * 모든 리소스 그룹 내의 모든 클러스터에 대한 액세스 권한을 지정하려면 다음 명령을 실행하십시오.
      ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

2. 사용자가 기본 외의 리소스 그룹에 속한 클러스터에 대해 작업할 수 있도록 하려는 경우 이러한 사용자에게는 클러스터가 속한 리소스 그룹에 대한 추가 액세스 권한이 필요합니다. 이러한 사용자에게는 리소스 그룹에 대한 **Viewer** 이상의 역할을 지정할 수 있습니다. 리소스 그룹 ID는 `ibmcloud resource group <resource_group_name> --id`를 실행하여 찾을 수 있습니다.
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. 변경사항을 적용하려면 클러스터 구성을 새로 고치십시오.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. IAM 플랫폼 역할이 해당 [RBAC 역할 바인딩 또는 클러스터 역할 바인딩](#role-binding)으로 자동으로 적용됩니다. 지정한 IAM 플랫폼 역할에 대해 다음 명령 중 하나를 실행하여 사용자가 해당 RBAC 역할에 추가되었는지 확인하십시오. 
    * Viewer:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Administrator:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  예를 들어, 사용자 `john@email.com`에게 **Viewer** IAM 플랫폼 역할을 지정하고 `kubectl get rolebinding ibm-view -o yaml -n default`를 실행하면 다음과 같은 출력이 표시됩니다. 

  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-view
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-view
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: view
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: https://iam.ng.bluemix.net/IAM#user@email.com
  ```
  {: screen}


**CLI를 사용하여 액세스 그룹 내의 여러 사용자에게 IAM 플랫폼 역할을 지정하려면 다음 작업을 수행하십시오. **

1. 액세스 그룹을 작성하십시오.
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. 액세스 그룹에 사용자를 추가하십시오.
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. {{site.data.keyword.containerlong_notm}}에 대한 권한 설정을 위한 IAM 액세스 정책을 작성하십시오. IAM 플랫폼 역할에 대해 Viewer, Editor, Operator 및 Administrator를 선택할 수 있습니다. 각 역할에 대해 지원되는 조치의 목록을 찾으려면 [사용자 액세스 권한](/cs_access_reference.html#platform)을 참조하십시오. 
  * 한 리소스 그룹 내의 한 클러스터에 대한 액세스 권한을 지정하려면 다음 명령을 실행하십시오.
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **참고**: 특정 사용자에게 하나의 클러스터에 대한 **Administrator** IAM 플랫폼 역할만 지정하는 경우에는 이 사용자에게 리소스 그룹에서 해당 지역에 속한 모든 클러스터에 대한 **Viewer** 역할도 지정해야 합니다. 

  * 한 리소스 그룹 내의 모든 클러스터에 대한 액세스 권한을 지정하려면 다음 명령을 실행하십시오.
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * 모든 리소스 그룹 내의 모든 클러스터에 대한 액세스 권한을 지정하려면 다음 명령을 실행하십시오.
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. 사용자가 기본 외의 리소스 그룹에 속한 클러스터에 대해 작업할 수 있도록 하려는 경우 이러한 사용자에게는 클러스터가 속한 리소스 그룹에 대한 추가 액세스 권한이 필요합니다. 이러한 사용자에게는 리소스 그룹에 대한 **Viewer** 이상의 역할을 지정할 수 있습니다. 리소스 그룹 ID는 `ibmcloud resource group <resource_group_name> --id`를 실행하여 찾을 수 있습니다.
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. 모든 리소스 그룹 내의 모든 클러스터에 대한 액세스 권한을 지정한 경우에는 계정에 있는 각 리소스 그룹에 대해 이 명령을 반복하십시오. 

5. 변경사항을 적용하려면 클러스터 구성을 새로 고치십시오.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. IAM 플랫폼 역할이 해당 [RBAC 역할 바인딩 또는 클러스터 역할 바인딩](#role-binding)으로 자동으로 적용됩니다. 지정한 IAM 플랫폼 역할에 대해 다음 명령 중 하나를 실행하여 사용자가 해당 RBAC 역할에 추가되었는지 확인하십시오. 
    * Viewer:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Administrator:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  예를 들어, 액세스 그룹 `team1`에 **Viewer** IAM 플랫폼 역할을 지정하고 `kubectl get rolebinding ibm-view -o yaml -n default`를 실행하면 다음과 같은 출력이 표시됩니다. 
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-edit
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-edit
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team1
  ```
  {: screen}

<br />




## RBAC 권한 지정
{: #role-binding}

**RBAC 역할과 클러스터 역할은 무엇입니까?**</br>

RBAC 역할 및 클러스터 역할은 사용자가 클러스터에 있는 Kubernetes 리소스와 상호작용할 수 있는 방식에 대한 권한 세트를 정의합니다. 역할의 범위는 배치와 같은 특정 네임스페이스 내의 리소스로 지정됩니다. 클러스터 역할의 범위는 작업자 노드와 같은 클러스터 전체 리소스, 또는 팟(Pod)과 같이 각 네임스페이스에서 찾을 수 있는 네임스페이스 범위 리소스로 지정됩니다. 

**RBAC 역할 바인딩과 클러스터 역할 바인딩은 무엇입니까?**</br>

역할 바인딩은 RBAC 역할 또는 클러스터 역할을 특정 네임스페이스에 적용합니다. 역할을 적용하기 위해 역할 바인딩을 사용하면 사용자에게 특정 네임스페이스의 특정 리소스에 대한 액세스 권한을 부여하게 됩니다. 클러스터 역할을 적용하기 위해 역할 바인딩을 사용하면 사용자에게 특정 네임스페이스 한정으로, 각 네임스페이스에서 찾을 수 있는 네임스페이스 범위 리소스(팟(Pod) 등)에 대한 액세스 권한을 부여하게 됩니다. 

클러스터 역할 바인딩은 클러스터의 모든 네임스페이스에 RBAC 클러스터 역할을 적용합니다. 클러스터 역할을 적용하기 위해 클러스터 역할 바인딩을 사용하면 사용자에게 클러스터 전체 리소스(작업자 노드 등) 또는 모든 네임스페이스의 네임스페이스 범위 리소스(팟(Pod) 등)에 대한 액세스 권한을 부여하게 됩니다. 

**이러한 역할은 내 클러스터에서 어떻게 보입니까?**</br>

[IAM 플랫폼 관리 역할](#platform)이 지정된 모든 사용자에게는 해당 RBAC 클러스터 역할이 자동으로 지정됩니다. 이러한 RBAC 클러스터 역할은 사전 정의되며 사용자가 클러스터 내의 Kubernetes 리소스와 상호작용할 수 있도록 해 줍니다. 또한, 역할 바인딩은 특정 네임스페이스에 클러스터 역할을 적용하기 위해 작성되고, 클러스터 역할 바인딩은 모든 네임스페이스에 클러스터 역할을 적용하기 위해 작성됩니다. 

다음 표에서는 IAM 플랫폼 역할과 IAM 플랫폼 역할에 대해 자동으로 작성되는 해당 클러스터 역할, 역할 바인딩 또는 클러스터 역할 바인딩 간의 관계에 대해 설명합니다. 

<table>
  <tr>
    <th>IAM 플랫폼 역할</th>
    <th>RBAC 클러스터 역할</th>
    <th>RBAC 역할 바인딩</th>
    <th>RBAC 클러스터 역할 바인딩</th>
  </tr>
  <tr>
    <td>뷰어</td>
    <td><code>view</code></td>
    <td>기본 네임스페이스의 <code>ibm-view</code></td>
    <td>-</td>
  </tr>
  <tr>
    <td>편집자</td>
    <td><code>edit</code></td>
    <td>기본 네임스페이스의 <code>ibm-edit</code></td>
    <td>-</td>
  </tr>
  <tr>
    <td>운영자</td>
    <td><code>admin</code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>관리자</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

각 RBAC 역할에 허용되는 조치에 대해 자세히 알아보려면 [사용자 액세스 권한](cs_access_reference.html#platform) 참조 주제를 참조하십시오.
{: tip}

**내 클러스터에 있는 특정 네임스페이스의 RBAC 권한은 어떻게 관리합니까?**

[Kubernetes 네임스페이스를 사용하여 클러스터를 파티셔닝하고 워크로드의 격리를 제공](cs_secure.html#container)하는 경우에는 특정 네임스페이스에 대한 사용자 액세스 권한을 지정해야 합니다. 사용자에게 **Operator** 또는 **Administrator** IAM 플랫폼 역할을 지정하면 사전 정의된 해당 `admin` 및 `cluster-admin` 클러스터 역할이 전체 클러스터에 자동으로 적용됩니다. 그러나 사용자에게 **Viewer** 또는 **Editor** IAM 플랫폼 역할을 지정하면 사전 정의된 해당 `view` 및 `edit` 클러스터 역할이 기본 네임스페이스에만 자동으로 적용됩니다. 다른 네임스페이스에서 동일한 사용자 액세스 권한 레벨을 적용하려는 경우에는 이러한 클러스터 역할의 [역할 바인딩을 복사](#rbac_copy)하여 다른 네임스페이스에 복사할 수 있습니다(`ibm-view` 및 `ibm-edit`). 

**사용자 정의 역할 또는 클러스터 역할을 작성할 수 있습니까?**

`view`, `edit`, `admin` 및 `cluster-admin` 클러스터 역할은 사용자에게 해당 IAM 플랫폼 역할을 지정하면 자동으로 작성되는 사전 정의된 역할입니다. 그 외의 Kubernetes 권한을 부여하려는 경우에는 [사용자 정의 RBAC 권한을 작성](#rbac)할 수 있습니다. 

**내가 설정한, IAM 권한과 연결되어 있지 않은 클러스터 역할 바인딩 및 역할 바인딩은 언제 사용해야 합니까?**

클러스터에서 팟(Pod)을 작성하고 업데이트할 수 있도록 사용자에게 권한을 부여하고자 하는 경우가 있을 수 있습니다. [팟(Pod) 보안 정책](https://console.bluemix.net/docs/containers/cs_psp.html#psp)을 사용하면 클러스터와 함께 제공된 기존 클러스터 역할 바인딩을 사용하거나 고유한 클러스터 역할 바인딩을 작성할 수 있습니다. 

클러스터에 추가 기능을 통합하려는 경우도 있을 수 있습니다. 예를 들어, [클러스터에 Helm을 설정](cs_integrations.html#helm)한 경우에는 `kube-system` 네임스페이스에 Tiller에 대한 서비스 계정을 작성하고 `tiller-deploy` 팟(Pod)에 대한 Kubernetes RBAC 클러스터 역할 바인딩을 작성해야 합니다. 

### RBAC 역할 바인딩을 다른 네임스페이스로 복사
{: #rbac_copy}

일부 역할 및 클러스터 역할은 하나의 네임스페이스에만 적용됩니다. 예를 들어, 사전 정의된 `view` 및 `edit` 클러스터 역할은 `default` 네임스페이스에만 자동으로 적용됩니다. 다른 네임스페이스에서 동일한 사용자 액세스 권한 레벨을 적용하려는 경우에는 이러한 역할 또는 클러스터 역할의 역할 바인딩을 다른 네임스페이스에 복사할 수 있습니다.
{: shortdesc}

예를 들면, 사용자 "john@email.com"에게 **Editor** IAM 플랫폼 관리 역할을 지정했다고 가정하십시오. 사전 정의된 RBAC 클러스터 역할 `edit`이 클러스터에 자동으로 작성되며, `ibm-edit` 역할 바인딩이 `default` 네임스페이스에서 해당 권한을 적용합니다. 사용자는 "john@email.com"이 개발 네임스페이스에서도 Editor 액세스 권한을 갖도록 하기 위해 `ibm-edit` 역할 바인딩을 `default`에서 `development`로 복사합니다. **참고**: 사용자가 `view` 또는 `edit` 역할에 추가될 때마다 역할 바인딩을 복사해야 합니다. 

1. `default`에서 다른 네임스페이스로 역할 바인딩을 복사하십시오.
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    예를 들어, `ibm-edit` 역할 바인딩을 `testns` 네임스페이스에 복사하려는 경우에는 다음 명령을 실행하십시오.
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. `ibm-edit` 역할 바인딩이 복사되었는지 확인하십시오.
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### 사용자, 그룹 또는 서비스 계정에 대한 사용자 정의 RBAC 권한 작성
{: #rbac}

`view`, `edit`, `admin` 및 `cluster-admin` 클러스터 역할은 해당 IAM 플랫폼 관리 역할을 지정하면 자동으로 작성됩니다. 클러스터 액세스 정책이 이러한 사전 정의된 권한보다 더 세부적으로 권한을 부여하도록 하려 하십니까? 걱정하지 마십시오! 이러한 경우에는 사용자 정의 RBAC 역할 및 클러스터 역할을 작성할 수 있습니다.
{: shortdesc}

사용자는 사용자 정의 RBAC 역할 및 클러스터 역할을 개별 사용자, 사용자 그룹(Kubernetes v1.11 이상을 실행하는 클러스터의) 또는 서비스 계정에 지정할 수 있습니다. 그룹에 대해 바인딩이 작성되면 이는 해당 그룹에서 추가 또는 제거된 사용자에게 영향을 줍니다. 사용자를 그룹에 추가하면 이들은 자신에게 부여된 개별 액세스 권한 외에 해당 그룹의 액세스 권한 또한 얻습니다. 이를 제거하면 해당 액세스 권한이 취소됩니다. **참고**: 액세스 그룹에는 서비스 계정을 추가할 수 없습니다. 

지속적 딜리버리 도구 체인과 같이 팟(Pod)에서 실행되는 프로세스에 대한 액세스 권한을 지정하려는 경우에는 [Kubernetes ServiceAccount ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)를 사용할 수 있습니다. Travis 및 Jenkins용 서비스 계정을 설정하는 방법을 보여주는 튜토리얼을 수행하고 ServiceAccount에 사용자 정의 RBAC 역할을 지정하려는 경우에는 블로그 게시물 [Kubernetes ServiceAccounts for use in automated systems ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982)를 참조하십시오. 

**참고**: 기타 컴포넌트에 영향을 줄 수 있는 변경사항(breaking changes)을 방지하기 위해, 사전 정의된 `view`, `edit`, `admin` 및 `cluster-admin` 클러스터 역할을 변경하지 마십시오. 

**역할 또는 클러스터 역할 중 어느 것을 작성해야 합니까? 이는 역할 바인딩 또는 클러스터 역할 바인딩 중 어느 것을 사용하여 적용해야 합니까?**

* 사용자, 액세스 그룹 또는 서비스 계정이 특정 네임스페이스 내의 리소스에 액세스할 수 있도록 하려는 경우에는 다음 조합 중 하나를 선택하십시오. 
  * 역할을 작성하고 역할 바인딩을 사용하여 이를 적용합니다. 이 선택사항은 앱 배치와 같이 하나의 네임스페이스만 있는 고유 리소스에 대한 액세스를 제어하는 데 유용합니다. 
  * 클러스터 역할을 작성하고 역할 바인딩을 사용하여 이를 적용합니다. 이 선택사항은 팟(Pod)과 같이 하나의 네임스페이스에 있는 일반 리소스에 대한 액세스를 제어하는 데 유용합니다. 
* 사용자 또는 액세스 그룹이 클러스터 전체 리소스 또는 모든 네임스페이스의 리소스에 액세스할 수 있도록 하려는 경우에는 클러스터 역할을 작성하고 클러스터 역할 바인딩을 사용하여 이를 적용하십시오. 이 선택사항은 작업자 노드와 같이 네임스페이스보다 범위가 큰 리소스, 또는 각 네임스페이스에 있는 팟(Pod)과 같이 클러스터의 모든 네임스페이스에 있는 리소스에 대한 액세스를 제어하는 데 유용합니다. 

시작하기 전에:

- 클러스터를 [Kubernetes CLI](cs_cli_install.html#cs_cli_configure)의 대상으로 지정하십시오.
- 개별 사용자 또는 액세스 그룹의 사용자에게 액세스 권한을 지정하려는 경우에는 {{site.data.keyword.containerlong_notm}} 서비스 레벨에서 해당 사용자 또는 그룹에 하나 이상의 [IAM 플랫폼 역할](#platform)이 지정되지 않았는지 확인하십시오. 

사용자 정의 RBAC 권한을 작성하려면 다음 작업을 수행하십시오. 

1. 지정할 액세스 권한을 가진 역할 또는 클러스터 역할을 작성하십시오. 

    1. `.yaml` 파일을 작성하여 역할 또는 클러스터 역할을 정의하십시오. 

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
        <caption>YAML 컴포넌트 이해</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 컴포넌트 이해</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>특정 네임스페이스 내의 리소스에 대한 액세스 권한을 부여하려면 `Role`을 사용하십시오. 작업자 노드와 같은 클러스터 전체 리소스, 또는 모든 네임스페이스의 팟(Pod)과 같은 네임스페이스 범위 리소스에 대한 액세스 권한을 부여하려면 `ClusterRole`을 사용하십시오. </td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Kubernetes 1.8 이상을 실행하는 클러스터의 경우 `rbac.authorization.k8s.io/v1`을 사용하십시오. </li><li>이전 버전의 경우 `apiVersion: rbac.authorization.k8s.io/v1beta1`을 사용하십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>`Role` 유형 한정: 액세스 권한이 부여되는 Kubernetes 네임스페이스를 지정하십시오. </td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>역할 또는 클러스터 역할의 이름입니다. </td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>`"apps"`, `"batch"` 또는 `"extensions"`와 같이 사용자가 상호작용할 수 있도록 할 Kubernetes [API 그룹 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)을 지정하십시오. REST 경로 `api/v1`의 코어 API 그룹에 액세스하려면 그룹을 `[""]`와 같이 공백으로 두십시오.</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>`"daemonsets"`, `"deployments"`, `"events"` 또는 `"ingresses"`와 같이 액세스 권한을 부여할 Kubernetes [리소스 유형 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)을 지정하십시오. `"nodes"`를 지정하는 경우 유형은 `ClusterRole`이어야 합니다. </td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>`"get"`, `"list"`, `"describe"`, `"create"` 또는 `"delete"`와 같이 사용자가 수행할 수 있도록 할 [조치 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/overview/)의 유형을 지정하십시오. </td>
            </tr>
          </tbody>
        </table>

    2. 클러스터에 역할 또는 클러스터 역할을 작성하십시오. 

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. 역할 또는 클러스터 역할이 작성되었는지 확인하십시오. 
      * 역할:
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * 클러스터 역할:
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. 사용자를 역할 또는 클러스터 역할에 바인드하십시오. 

    1. `.yaml` 파일을 작성하여 사용자를 역할 또는 클러스터 역할에 바인드하십시오. 각 주제의 이름에 사용할 고유한 URL을 기록해 두십시오.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/IAM#user1@example.com
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
        <caption>YAML 컴포넌트 이해</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 컴포넌트 이해</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>네임스페이스 고유 `Role` 또는 `ClusterRole`에 대해 `RoleBinding`을 지정하십시오. </li><li>클러스터 전체 `ClusterRole`에 대해 `ClusterRoleBinding`을 지정하십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Kubernetes 1.8 이상을 실행하는 클러스터의 경우 `rbac.authorization.k8s.io/v1`을 사용하십시오. </li><li>이전 버전의 경우 `apiVersion: rbac.authorization.k8s.io/v1beta1`을 사용하십시오.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>`RoleBinding` 유형의 경우: 액세스 권한이 부여되는 Kubernetes 네임스페이스를 지정하십시오. </li><li>`ClusterRoleBinding` 유형의 경우: `namespace` 필드를 사용하지 마십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>역할 바인딩 또는 클러스터 역할 바인딩의 이름을 지정하십시오. </td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>유형을 다음 중 하나로 지정하십시오.
              <ul><li>`User`: RBAC 역할 또는 클러스터 역할을 계정 내의 개별 사용자에 바인드하십시오. </li>
              <li>`Group`: Kubernetes 1.11 이상을 실행하는 클러스터의 경우, RBAC 역할 또는 클러스터 역할을 계정 내의 [IAM 액세스 그룹](/docs/iam/groups.html#groups)에 바인드하십시오. </li>
              <li>`ServiceAccount`: RBAC 역할 또는 클러스터 역할을 클러스터 내의 네임스페이스에 있는 서비스 계정에 바인드하십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>`User`의 경우: 개별 사용자의 이메일 주소를 다음 URL에 추가하십시오. <ul><li>Kubernetes 1.11 이상을 실행하는 클러스터의 경우: <code>https://iam.ng.bluemix.net/IAM#user_email</code></li><li>Kubernetes 1.10 이하를 실행하는 클러스터의 경우: <code>https://iam.ng.bluemix.net/kubernetes#user_email</code></li></ul></li>
              <li>`Group`의 경우: Kubernetes 1.11 이상을 실행하는 클러스터의 경우, 계정에 있는 [IAM 그룹](/docs/iam/groups.html#groups)의 이름을 지정하십시오. </li>
              <li>`ServiceAccount`의 경우: 서비스 계정 이름을 지정하십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>`User` 또는 `Group`의 경우: `rbac.authorization.k8s.io`를 사용하십시오. </li>
              <li>`ServiceAccount`의 경우: 이 필드를 포함시키지 마십시오. </li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>`ServiceAccount` 한정: 서비스 계정이 배치되는 Kubernetes 네임스페이스의 이름을 지정하십시오. </td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>역할 `.yaml` 파일(`Role` 또는 `ClusterRole`)에서 `kind`와 동일한 값을 입력하십시오.</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>역할 `.yaml` 파일의 이름을 입력하십시오.</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>`rbac.authorization.k8s.io`를 사용하십시오.</td>
            </tr>
          </tbody>
        </table>

    2. 클러스터에 역할 바인딩 또는 클러스터 역할 바인딩 리소스를 작성하십시오. 

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  바인딩이 작성되었는지 확인하십시오.

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

사용자 정의 Kubernetes RBAC 역할 또는 클러스터 역할의 작성 및 바인드가 완료되었습니다. 사용자에게 후속 조치를 취하십시오. 팟(Pod) 삭제와 같은 역할로 인해 완료할 권한이 있는 조치를 테스트하도록 사용자에게 요청하십시오.

<br />




## 인프라 권한 사용자 정의
{: #infra_access}

API 키를 설정하는 관리자 또는 인프라 인증 정보 설정에 사용되는 관리자에게 **수퍼유저** 인프라 역할을 지정하면 계정 내의 다른 사용자들이 인프라 조치를 수행하기 위해 해당 API 키 또는 인증 정보를 공유합니다. 이 경우에는 적절한 [IAM 플랫폼 역할](#platform)을 지정함으로써 사용자가 수행할 수 있는 인프라 조치를 제어할 수 있습니다. 이 사용자의 IBM Cloud 인프라(SoftLayer) 권한을 편집할 필요는 없습니다.
{: shortdesc}

규제 준수, 보안 또는 비용 청구 관련 이유로 인해 API 키를 설정하는 사용자 또는 `ibmcloud ks credentials-set` 명령으로 인증 정보가 설정되는 사용자에게 **수퍼유저** 인프라 역할을 지정하지 않으려 하는 경우가 있습니다. 그러나 이 사용자에게 **수퍼유저** 역할이 없으면 클러스터 작성 또는 작업자 노드 다시 로드와 같은 인프라 관련 조치가 실패할 수 있습니다. 이 경우에는 IAM 플랫폼 역할을 사용하여 사용자의 인프라 액세스를 제어하는 대신, 사용자에 대해 특정 IBM Cloud 인프라(SoftLayer) 권한을 설정해야 합니다. 

다중 구역 클러스터가 있는 경우, IBM Cloud 인프라(SoftLayer) 계정 소유자는 서로 다른 영역의 노드가 클러스터 내에서 통신할 수 있도록 VLAN Spanning을 켜야 합니다. 사용자가 VLAN Spanning을 사용으로 설정할 수 있도록 계정 소유자가 사용자에게 **네트워크 > 네트워크 VLAN Spanning 관리** 권한을 지정할 수도 있습니다. VLAN Spanning이 이미 사용으로 설정되었는지 확인하려면 `ibmcloud ks vlan-spanning-get` [명령](cs_cli_reference.html#cs_vlan_spanning_get)을 사용하십시오.
{: tip}

시작하기 전에, 자신이 계정 소유자이거나 자신에게 **수퍼유저** 및 모든 디바이스 액세스 권한이 있는지 확인하십시오. 자신에게 없는 액세스 권한을 다른 사용자에게 부여할 수는 없습니다. 

1. [IBM Cloud GUI](https://console.bluemix.net/)에 로그인하여 **관리 > 계정 > 사용자**로 이동하십시오. 

2. 해당 권한을 설정할 사용자의 이름을 클릭하십시오.

3. **액세스 권한 지정**을 클릭하고 **SoftLayer 계정에 대한 액세스 권한 지정**을 클릭하십시오. 

4. **포털 권한** 탭을 클릭하여 사용자의 액세스 권한을 사용자 정의하십시오. 사용자에게 필요한 권한은 이들이 사용해야 하는 인프라 리소스에 따라 달라집니다. 액세스 권한 지정에는 두 가지 선택사항이 있습니다. 
    * 다음 사전 정의된 역할 중 하나를 지정하려면 **빠른 권한** 드롭 다운 목록을 사용하십시오. 역할을 선택한 후 **권한 설정**을 클릭하십시오. 
        * **보기만 가능한 사용자**는 사용자에게 인프라 세부사항을 볼 수 있는 권한만 제공합니다. 
        * **기본 사용자**는 사용자에게 인프라 권한을 일부 부여합니다. 
        * **수퍼유저**는 사용자에게 모든 인프라 권한을 부여합니다. 
    * 각 탭에서 개별 권한을 선택하십시오. {{site.data.keyword.containerlong_notm}}에서 일반적인 태스크를 수행하는 데 필요한 권한을 검토하려면 [사용자 액세스 권한](cs_access_reference.html#infra)을 참조하십시오. 

5.  변경사항을 저장하려면 **포털 권한 편집**을 클릭하십시오.

6.  **디바이스 액세스** 탭에서 액세스 권한을 부여할 디바이스를 선택하십시오.

    * **디바이스 유형** 드롭 다운 목록에서는 사용자가 가상 및 실제(베어메탈 하드웨어) 머신 유형의 작업자 노드 모두에 대해 작업을 수행할 수 있도록 **모든 디바이스**에 대한 액세스 권한을 부여할 수 있습니다. 
    * 사용자가 작성된 새 디바이스에 액세스할 수 있도록 허용하려면 **새 디바이스가 추가될 때 자동으로 액세스 권한 부여**를 선택하십시오.
    * 디바이스 테이블에서 적절한 장치가 선택되었는지 확인하십시오. 

7. 변경사항을 저장하려면 **디바이스 액세스 업데이트**를 클릭하십시오.

권한을 다운그레이드하고 계십니까? 이 조치는 완료하는 데 몇 분 정도 소요될 수 있습니다.
{: tip}

<br />



