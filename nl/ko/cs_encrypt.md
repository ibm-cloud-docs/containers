---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터에 있는 민감한 정보 보호
{: #encryption}

기본적으로 {{site.data.keyword.containerlong}} 클러스터는 암호화된 디스크를 사용하여 구성과 같은 정보를 `etcd` 또는 작업자 노드 보조 디스크에서 실행되는 컨테이너 파일 시스템에 저장합니다. 앱을 배치할 때는 YAML 구성 파일, ConfigMap 또는 스크립트에 인증 정보나 키와 같은 기밀 정보를 저장하지 마십시오. 대신 [Kubernetes secret ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/secret/)을 사용하십시오. Kubernetes secret에 있는 데이터를 암호화하여 권한 없는 사용자가 민감한 클러스터 정보에 액세스하지 못하도록 할 수도 있습니다.
{: shortdesc}

클러스터를 보호하는 데 대한 자세한 정보는 [{{site.data.keyword.containerlong_notm}}에 대한 보안](cs_secure.html#security)을 참조하십시오. 



## secret을 사용하는 경우 이해
{: #secrets}

Kubernetes 시크릿은 사용자 이름, 비밀번호 또는 키와 같은 기밀 정보를 저장하는 안전한 방법입니다. 기밀 정보를 암호화해야 하는 경우에는 [{{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정](#keyprotect)하여 secret을 암호화하십시오. 시크릿에 무엇을 저장할 수 있는지에 대한 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/secret/)를 참조하십시오.
{:shortdesc}

시크릿이 필요한 다음 태스크를 검토하십시오.

### 클러스터에 서비스 추가
{: #secrets_service}

서비스를 클러스터에 바인드할 때는 서비스 인증 정보를 저장할 secret을 작성할 필요가 없습니다. 시크릿은 사용자를 위해 자동으로 작성됩니다. 자세한 정보는 [클러스터에 Cloud Foundry 서비스 추가](cs_integrations.html#adding_cluster)를 참조하십시오.

### TLS 시크릿을 사용하여 앱에 대한 트래픽을 암호화
{: #secrets_tls}

ALB는 클러스터의 앱에 대한 HTTP 네트워크 트래픽을 로드 밸런싱합니다. 수신 HTTPS 연결도 로드 밸런싱하려면 네트워크 트래픽을 복호화하고 클러스터에 노출된 앱으로 복호화된 요청을 전달하도록 ALB를 구성할 수 있습니다. 자세한 정보는 [Ingress 구성 문서](cs_ingress.html#public_inside_3)를 참조하십시오. 

또한, HTTPS 프로토콜을 필요로 하는 앱이 있으며 트래픽이 암호화된 상태를 유지해야 하는 경우에는 `ssl-services` 어노테이션을 사용하여 단방향 또는 상호 인증 시크릿을 사용할 수 있습니다. 자세한 정보는 [Ingress 어노테이션 문서](cs_annotations.html#ssl-services)를 참조하십시오. 

### Kubernetes `imagePullSecret`에 저장된 인증 정보를 사용하여 레지스트리에 액세스
{: #imagepullsecret}

클러스터를 작성하면 {{site.data.keyword.registrylong}} 인증 정보에 대한 secret이 `default` Kubernetes 네임스페이스에 자동으로 작성됩니다. 그러나 다음 상황에서 컨테이너를 배치하려는 경우에는 [자신의 고유 imagePullSecret을 작성](cs_images.html#other)해야 합니다. 
* {{site.data.keyword.registryshort_notm}} 레지스트리에 있는 이미지에서 `default` 외의 Kubernetes 네임스페이스로 배치하는 경우. 
* 다른 {{site.data.keyword.Bluemix_notm}} 지역 또는 {{site.data.keyword.Bluemix_notm}} 계정에 저장된 {{site.data.keyword.registryshort_notm}} 레지스트리에 있는 이미지에서 배치하는 경우. 
* {{site.data.keyword.Bluemix_notm}} 데디케이티드 계정에 저장된 이미지에서 배치하는 경우. 
* 외부 개인용 레지스트리에 저장된 이미지에서 배치하는 경우. 

<br />


## {{site.data.keyword.keymanagementserviceshort}}를 사용한 Kubernetes secret 암호화
{: #keyprotect}

[{{site.data.keyword.keymanagementservicefull}} ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](/docs/services/key-protect/index.html#getting-started-with-key-protect)를 클러스터의 Kubernetes [키 관리 서비스(KMS) 제공자 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)로 사용하여 Kubernetes secret을 암호화할 수 있습니다. KMS 제공자는 Kubernetes 버전 1.10 및 1.11의 알파 기능입니다.
{: shortdesc}

기본적으로 Kubernetes secret은 IBM 관리 Kubernetes 마스터의 `etcd` 컴포넌트에 있는 암호화된 디스크에 저장됩니다. 작업자 노드에는 secret으로 클러스터에 저장된 IBM 관리 LUKS 키에 의해 암호화되는 보조 디스크도 있습니다. 클러스터에서 {{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정하면 LUKS 시크릿을 포함한 Kubernetes secret을 암호화하는 데 사용자 자신의 루트 키가 사용됩니다. 자신의 루트 키로 secret을 암호화함으로써 민감한 데이터에 대한 제어 능력을 향상시킬 수 있습니다. 자신의 고유한 암호화를 사용하면 Kubernetes secret에 보안 계층이 추가되며 민감한 클러스터 정보에 액세스할 수 있는 사용자를 더 세부적으로 제어할 수 있습니다. 자신의 secret에 대한 액세스 권한을 불가역적으로 제거해야 하는 경우에는 루트 키를 삭제할 수 있습니다. 

**중요**: {{site.data.keyword.keymanagementserviceshort}} 인스턴스에서 루트 키를 삭제하면 클러스터의 secret에 액세스하거나 이로부터 데이터를 제거할 수 없게 됩니다. 

시작하기 전에:
* [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](cs_cli_install.html#cs_cli_configure). 
* `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>`를 실행하고 **Version** 필드를 확인하여 클러스터가 Kubernetes 버전 1.10.8_1524, 1.11.3_1521 또는 그 이상의 버전을 실행하는지 확인하십시오. 
* 이러한 단계를 완료하려면 [**관리자** 권한](cs_users.html#access_policies)이 있는지 확인하십시오. 
* 클러스터가 있는 지역에 대해 설정된 API 키가 Key Protect를 사용할 수 있도록 권한 부여되었는지 확인하십시오. 지역에 대해 인증 정보가 저장되는 API 키 소유자를 확인하려면 `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`를 실행하십시오. 

{{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정하거나, 클러스터의 secret을 암호화하는 인스턴스 또는 루트 키를 업데이트하려면 다음 작업을 수행하십시오. 

1.  [{{site.data.keyword.keymanagementserviceshort}} 인스턴스를 작성](/docs/services/key-protect/provision.html#provision)하십시오. 

2.  가져오기 인스턴스 ID를 가져오십시오. 

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [루트 키를 작성](/docs/services/key-protect/create-root-keys.html#create-root-keys)하십시오. 기본적으로 루트 키는 만료 날짜 없이 작성됩니다. 

    내부 보안 정책을 준수하기 위해 만료 날짜를 설정해야 하십니까? [API를 사용하여 루트 키를 작성](/docs/services/key-protect/create-root-keys.html#api)하고 `expirationDate` 매개변수를 포함시키십시오. **중요**: 루트 키가 만료되기 전에 이러한 단계를 반복하여 클러스터가 새 루트 키를 사용하도록 업데이트해야 합니다. 이렇게 하지 않으면 secret의 암호화를 해제할 수 없습니다.
    {: tip}

4.  [루트 키 **ID**](/docs/services/key-protect/view-keys.html#gui)를 기록하십시오. 

5.  인스턴스의 [{{site.data.keyword.keymanagementserviceshort}} 엔드포인트](/docs/services/key-protect/regions.html#endpoints)를 가져오십시오. 

6.  {{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정할 클러스터의 이름을 가져오십시오. 

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  클러스터에서 {{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정하십시오. 플래그를 이전에 검색한 정보로 채우십시오. 

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

클러스터에서 {{site.data.keyword.keymanagementserviceshort}}가 사용으로 설정되고 나면 클러스터에서 작성된 기존 secret 및 새 secret이 {{site.data.keyword.keymanagementserviceshort}} 루트 키를 사용하여 자동으로 암호화됩니다. 새 루트 키 ID를 사용하여 이러한 단계를 반복함으로써 키를 언제든지 순환시킬 수 있습니다. 
