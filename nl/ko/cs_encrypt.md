---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# 클러스터에 있는 민감한 정보 보호
{: #encryption}

민감한 클러스터 정보를 보호하면 데이터 무결성을 보장하고 권한 없는 사용자에게 데이터가 표시되는 것을 방지할 수 있습니다.
{: shortdesc}

적절한 보호가 필요한 클러스터의 여러 레벨로 민감한 데이터를 작성할 수 있습니다.
- **클러스터 레벨:** 클러스터 구성 데이터가 Kubernetes 마스터의 etcd 컴포넌트에 저장됩니다. Kubernetes 버전 1.10 이상을 실행하는 클러스터의 경우 etcd의 데이터는 Kubernetes 마스터의 로컬 디스크에 저장되고, {{site.data.keyword.cos_full_notm}}에 백업됩니다. 데이터는 {{site.data.keyword.cos_full_notm}}로 전환하고 저장하는 동안에 암호화됩니다. 클러스터에 대해 [{{site.data.keyword.keymanagementservicelong_notm}} 암호화를 사용으로 설정](cs_encrypt.html#encryption)하여 Kubernetes 마스터의 로컬 디스크에 있는 etcd 데이터에 대한 암호화를 사용으로 설정할 수 있습니다. 이전 버전의 Kubernetes를 실행하는 클러스터의 etcd 데이터는 IBM에서 관리하고 매일 백업하는 암호화된 디스크에 저장됩니다.
- **앱 레벨:** 앱을 배치할 때 인증 정보 또는 키와 같은 기밀 정보를 YAML 구성 파일, ConfigMap 또는 스크립트에 저장하지 마십시오. 대신 [Kubernetes secret ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/secret/)을 사용하십시오. 권한 없는 사용자가 민감한 클러스터 정보에 액세스하지 못하도록 [Kubernetes 시크릿에 있는 데이터를 암호화](#keyprotect)할 수도 있습니다.

클러스터를 보호하는 데 대한 자세한 정보는 [{{site.data.keyword.containerlong_notm}}에 대한 보안](cs_secure.html#security)을 참조하십시오.

![클러스터 암호화 개요](images/cs_encrypt_ov.png)
_그림: 클러스터의 데이터 암호화 개요_

1.  **etcd**: etcd는 Kubernetes 리소스의 데이터가 저장되는 마스터의 컴포넌트입니다(예: 오브젝트 구성 `.yaml` 파일 및 시크릿). Kubernetes 버전 1.10 이상을 실행하는 클러스터의 경우 etcd의 데이터는 Kubernetes 마스터의 로컬 디스크에 저장되고, {{site.data.keyword.cos_full_notm}}에 백업됩니다. 데이터는 {{site.data.keyword.cos_full_notm}}로 전환하고 저장하는 동안에 암호화됩니다. 클러스터에 대해 [{{site.data.keyword.keymanagementservicelong_notm}} 암호화를 사용으로 설정](#keyprotect)하여 Kubernetes 마스터의 로컬 디스크에 있는 etcd 데이터에 대한 암호화를 사용으로 설정할 수 있습니다. 이전 버전의 Kubernetes를 실행하는 클러스터의 etcd 데이터는 IBM에서 관리하고 매일 백업하는 암호화된 디스크에 저장됩니다. etcd 데이터가 팟(Pod)에 전송될 때 데이터는 데이터 보호와 무결성을 보장하기 위해 TLS를 통해 암호화됩니다.
2.  **작업자 노드의 보조 디스크**: 작업자 노드의 보조 디스크에는 컨테이너 파일 시스템 및 로컬에서 가져온 이미지가 저장됩니다. 디스크는 작업자 노드에 대해 고유한 LUKS 암호화 키로 암호화되고 etcd에 시크릿(IBM에서 관리함)으로 저장됩니다. 작업자 노드를 다시 로드하거나 업데이트하면 LUKS 키가 순환됩니다.
3.  **스토리지**: [파일, 블록 또는 오브젝트 지속적 스토리지를 설정](cs_storage_planning.html#persistent_storage_overview)하여 데이터를 저장할 수 있습니다. IBM Cloud 인프라(SoftLayer) 스토리지 인스턴스는 데이터를 암호화된 디스크에 저장하므로, 저장된 데이터는 암호화됩니다. 또한 오브젝트 스토리지를 선택한 경우에는 전송 중인 데이터도 암호화됩니다.
4.  **{{site.data.keyword.Bluemix_notm}} 서비스**: {{site.data.keyword.registryshort_notm}} 또는 {{site.data.keyword.watson}} 등의 [{{site.data.keyword.Bluemix_notm}} 서비스를 클러스터와 통합](cs_integrations.html#adding_cluster)할 수 있습니다. 서비스 인증 정보는 etcd에 저장된 시크릿에 저장되며, 앱에서는 시크릿을 볼륨으로 마운트하거나 시크릿을 [배치](cs_app.html#secret)의 환경 변수로 지정하여 액세스할 수 있습니다.
5.  **{{site.data.keyword.keymanagementserviceshort}}**: 클러스터에서 [{{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정](#keyprotect)하면 랩핑된 데이터 암호화 키(DEK)가 etcd에 저장됩니다. DEK는 서비스 인증 정보 및 LUKS 키를 포함하여 클러스터의 시크릿을 암호화합니다. 루트 키는 {{site.data.keyword.keymanagementserviceshort}} 인스턴스에 있으므로 암호화된 시크릿에 대한 액세스를 제어하십시오. {{site.data.keyword.keymanagementserviceshort}} 암호화가 작동하는 방식에 대한 자세한 정보는 [엔벨로프 암호화](/docs/services/key-protect/concepts/envelope-encryption.html#envelope-encryption)를 참조하십시오.

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


## {{site.data.keyword.keymanagementserviceshort}}를 사용하여 Kubernetes 마스터의 로컬 디스크 및 시크릿 암호화
{: #keyprotect}

[{{site.data.keyword.keymanagementservicefull}} ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](/docs/services/key-protect/index.html#getting-started-with-key-protect)를 클러스터의 Kubernetes [키 관리 서비스(KMS) 제공자 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)로 사용하여 Kubernetes 마스터의 etcd 컴포넌트 및 Kubernetes 시크릿을 암호화할 수 있습니다. KMS 제공자는 Kubernetes 버전 1.10 및 1.11의 알파 기능입니다.
{: shortdesc}

기본적으로 클러스터 구성 및 Kubernetes 시크릿은 IBM에서 관리하는 Kubernetes 마스터의 etcd 컴포넌트에 저장됩니다. 또한 작업자 노드의 보조 디스크는 etcd에 시크릿으로 저장되는 IBM 관리 LUKS 키로 암호화됩니다. Kubernetes 버전 1.10 이상을 실행하는 클러스터의 경우 etcd의 데이터는 Kubernetes 마스터의 로컬 디스크에 저장되고, {{site.data.keyword.cos_full_notm}}에 백업됩니다. 데이터는 {{site.data.keyword.cos_full_notm}}로 전환하고 저장하는 동안에 암호화됩니다. 그러나 Kubernetes 마스터의 로컬 디스크에 있는 etcd 컴포넌트의 데이터는 클러스터에 대해 {{site.data.keyword.keymanagementserviceshort}} 암호화를 사용으로 설정할 때까지 자동으로 암호화되지 않습니다. 이전 버전의 Kubernetes를 실행하는 클러스터의 etcd 데이터는 IBM에서 관리하고 매일 백업하는 암호화된 디스크에 저장됩니다.

클러스터에서 {{site.data.keyword.keymanagementserviceshort}}를 사용으로 설정하면 LUKS 시크릿을 포함하여 etcd의 데이터를 암호화하는 데 사용자 자신의 루트 키가 사용됩니다. 자신의 루트 키로 secret을 암호화함으로써 민감한 데이터에 대한 제어 능력을 향상시킬 수 있습니다. 자신의 고유한 암호화를 사용하면 etcd 데이터 및 Kubernetes 시크릿에 보안 계층이 추가되며 민감한 클러스터 정보에 액세스할 수 있는 사용자를 더 세부적으로 제어할 수 있습니다. etcd 또는 자신의 시크릿에 대한 액세스 권한을 불가역적으로 제거해야 하는 경우에는 루트 키를 삭제할 수 있습니다.

{{site.data.keyword.keymanagementserviceshort}} 인스턴스에서 루트 키를 삭제하면 etcd 데이터 또는 클러스터의 시크릿에 있는 데이터에 액세스하거나 이로부터 데이터를 제거할 수 없게 됩니다.
{: important}

시작하기 전에:
* [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](cs_cli_install.html#cs_cli_configure).
* `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>`를 실행하고 **Version** 필드를 확인하여 클러스터가 Kubernetes 버전 1.10.8_1524, 1.11.3_1521 또는 그 이상의 버전을 실행하는지 확인하십시오.
* 클러스터에 대해 [**관리자** {{site.data.keyword.Bluemix_notm}} IAM 플랫폼 역할](cs_users.html#platform)을 보유하고 있는지 확인하십시오.
* 클러스터가 있는 지역에 대해 설정된 API 키가 Key Protect를 사용할 수 있도록 권한 부여되었는지 확인하십시오. 지역에 대해 인증 정보가 저장되는 API 키 소유자를 확인하려면 `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`.

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

클러스터에서 {{site.data.keyword.keymanagementserviceshort}}가 사용으로 설정되고 나면 `etcd`의 데이터, 클러스터에 작성된 기존 시크릿 및 새 시크릿이 {{site.data.keyword.keymanagementserviceshort}} 루트 키를 사용하여 자동으로 암호화됩니다. 새 루트 키 ID를 사용하여 이러한 단계를 반복함으로써 키를 언제든지 순환시킬 수 있습니다.
