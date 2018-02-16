---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터 관리를 위한 CLI 참조
{: #cs_cli_reference}

클러스터를 작성하고 관리하려면 다음 명령을 참조하십시오.
{:shortdesc}

## bx cs 명령
{: #cs_commands}

**팁:** `bx cr` 명령을 찾고 계십니까? [{{site.data.keyword.registryshort_notm}} CLI 참조](/docs/cli/plugins/registry/index.html)를 확인하십시오. `kubectl` 명령을 찾고 계십니까? [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)를 참조하십시오.


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="{{site.data.keyword.Bluemix_notm}}에서 클러스터를 작성하기 위한 명령">
 <thead>
    <th colspan=5>{{site.data.keyword.Bluemix_notm}}에서 클러스터를 작성하기 위한 명령</th>
 </thead>
 <tbody>
  <tr>
    <td>[bx cs alb-cert-deploy](#cs_alb_cert_deploy)</td>
    <td>[bx cs alb-cert-get](#cs_alb_cert_get)</td>
    <td>[bx cs alb-cert-rm](#cs_alb_cert_rm)</td>
    <td>[bx cs alb-certs](#cs_alb_certs)</td>
    <td>[bx cs alb-configure](#cs_alb_configure)</td>
 </tr>
 <tr>
    <td>[bx cs alb-get](#cs_alb_get)</td>
    <td>[bx cs alb-types](#cs_alb_types)</td>
    <td>[bx cs albs](#cs_albs)</td>
    <td>[bx cs api-key-info](#cs_api_key_info)</td>
    <td>[bx cs apiserver-config-set](#cs_apiserver_config_set)</td>
 </tr>
 <tr>
    <td>[bx cs apiserver-refresh](#cs_apiserver_refresh)</td>
    <td>[bx cs cluster-config](#cs_cluster_config)</td>
    <td>[bx cs cluster-create](#cs_cluster_create)</td>
    <td>[bx cs cluster-get](#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](#cs_cluster_rm)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[bx cs cluster-service-unbind](#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[bx cs cluster-subnet-create](#cs_cluster_subnet_create)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[bx cs cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
    <td>[bx cs cluster-update](#cs_cluster_update)</td>
    <td>[     bx cs clusters
    ](#cs_clusters)</td>
    <td>[bx cs credentials-set](#cs_credentials_set)</td>
 </tr>
 <tr>
    <td>[bx cs credentials-unset](#cs_credentials_unset)</td>
    <td>[bx cs help](#cs_help)</td>
    <td>[bx cs init](#cs_init)</td>
    <td>[bx cs kube-versions](#cs_kube_versions)</td>
    <td>[        bx cs locations
        ](#cs_datacenters)</td>
 </tr>
 <tr>
    <td>[bx cs logging-config-create](#cs_logging_create)</td>
    <td>[bx cs logging-config-get](#cs_logging_get)</td>
    <td>[bx cs logging-config-refresh](#cs_logging_refresh)</td>
    <td>[bx cs logging-config-rm](#cs_logging_rm)</td>
    <td>[bx cs logging-config-update](#cs_logging_update)</td>
 </tr>
 <tr>
    <td>[bx cs machine-types](#cs_machine_types)</td>
    <td>[bx cs region](#cs_region)</td>
    <td>[bx cs region-set](#cs_region-set)</td>
    <td>[bx cs regions](#cs_regions)</td>
    <td>[     bx cs subnets
    ](#cs_subnets)</td>
 </tr>
 <tr>
    <td>[bx cs vlans](#cs_vlans)</td>
    <td>[bx cs webhook-create](#cs_webhook_create)</td>
    <td>[bx cs worker-add](#cs_worker_add)</td>
    <td>[bx cs worker-get](#cs_worker_get)</td>
    <td>[bx cs worker-reboot](#cs_worker_reboot)</td>
 </tr>
 <tr>
    <td>[bx cs worker-reload](#cs_worker_reload)</td>
    <td>[bx cs worker-rm](#cs_worker_rm)</td>
    <td>[bx cs worker-update](#cs_worker_update)</td>
    <td>[bx cs workers](#cs_workers)</td>
 </tr>
 </tbody>
 </table>

**팁:** {{site.data.keyword.containershort_notm}} 플러그인의 버전을 보려면 다음 명령을 실행하십시오.

```
bx plugin list
```
{: pre}

## 애플리케이션 로드 밸런서 명령

### bx cs alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN
{: #cs_alb_cert_deploy}

{{site.data.keyword.cloudcerts_long_notm}} 인스턴스의 인증서를 클러스터의 애플리케이션 로드 밸런서에 배치하거나 업데이트합니다. 

**참고:**
* 관리자 액세스 역할이 있는 사용자만 이 명령을 실행할 수 있습니다. 
* 같은 {{site.data.keyword.cloudcerts_long_notm}} 인스턴스에서 가져온 인증서만 업데이트할 수 있습니다. 

<strong>명령 옵션</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--update</code></dt>
   <dd>클러스터의 애플리케이션 로드 밸런서 시크릿에 대한 인증서를 업데이트하려면 이 플래그를 포함하십시오. 이 값은 선택사항입니다.</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>애플리케이션 로드 밸런서 시크릿의 이름입니다. 이 값은 필수입니다.</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>인증서 CRN입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

애플리케이션 로드 밸런서 시크릿 배치 예: 

   ```
   bx cs alb-cert-deploy --secret-name my_alb_secret_name --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
 {: pre}

기존 애플리케이션 로드 밸런서 시크릿 업데이트 예: 

 ```
 bx cs alb-cert-deploy --update --secret-name my_alb_secret_name --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### bx cs alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN]
{: #cs_alb_cert_get}

클러스터의 애플리케이션 로드 밸런서 시크릿에 관한 정보를 봅니다. 

**참고:** 관리자 액세스 역할이 있는 사용자만 이 명령을 실행할 수 있습니다. 

<strong>명령 옵션</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>애플리케이션 로드 밸런서 시크릿의 이름입니다. 이 값은 클러스터의 특정 애플리케이션 로드 밸런서 시크릿에 관한 정보를 가져오는 데 필요합니다. </dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>인증서 CRN입니다. 이 값은 클러스터의 특정 인증서 CRN과 일치하는 모든 애플리케이션 로드 밸런서 시크릿에 관한 정보를 가져오는 데 필요합니다. </dd>
  </dl>

**예제**:

 애플리케이션 로드 밸런서 시크릿에 관한 정보 가져오기 예: 

 ```
 bx cs alb-cert-get --cluster my_cluster --secret-name my_alb_secret_name
 ```
 {: pre}

 지정된 인증서 CRN과 일치하는 모든 애플리케이션 로드 밸런서 시크릿에 관한 정보 가져오기 예: 

 ```
 bx cs alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### bx cs alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN]
{: #cs_alb_cert_rm}

클러스터의 애플리케이션 로드 밸런서 시크릿을 제거합니다. 

**참고:** 관리자 액세스 역할이 있는 사용자만 이 명령을 실행할 수 있습니다. 

<strong>명령 옵션</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB 시크릿의 이름입니다. 이 값은 클러스터의 특정 애플리케이션 로드 밸런서 시크릿을 제거하는 데 필요합니다. </dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>인증서 CRN입니다. 이 값은 클러스터의 특정 인증서 CRN과 일치하는 모든 애플리케이션 로드 밸런서 시크릿을 제거하는 데 필요합니다. </dd>
  </dl>

**예제**:

 애플리케이션 로드 밸런서 시크릿 제거 예: 

 ```
 bx cs alb-cert-rm --cluster my_cluster --secret-name my_alb_secret_name
 ```
 {: pre}

 지정된 인증서 CRN과 일치하는 모든 애플리케이션 로드 밸런서 시크릿 제거 예: 

 ```
 bx cs alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### bx cs alb-certs --cluster CLUSTER
{: #cs_alb_certs}

클러스터의 애플리케이션 로드 밸런서 시크릿 목록을 봅니다. 

**참고:** 관리자 액세스 역할이 있는 사용자만 이 명령을 실행할 수 있습니다. 

<strong>명령 옵션</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

 ```
 bx cs alb-certs --cluster my_cluster
 ```
 {: pre}


### bx cs alb-configure --albID ALB_ID [--enable][--disable][--user-ip USERIP]
{: #cs_alb_configure}

표준 클러스터에서 애플리케이션 로드 밸런서를 사용 또는 사용 안함으로 설정합니다. 기본적으로 공용 애플리케이션 로드 밸런서는 사용 가능합니다.

**명령 옵션**:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>애플리케이션 로드 밸런서의 ID입니다. 클러스터에서 애플리케이션 로드 밸런서의 ID를 보려면 <code>bx cs albs <em>--cluster </em>CLUSTER</code>를 실행하십시오. 이 값은 필수입니다.</dd>

   <dt><code>--enable</code></dt>
   <dd>클러스터에서 애플리케이션 로드 밸런서를 사용으로 설정하려면 이 플래그를 포함시키십시오.</dd>

   <dt><code>--disable</code></dt>
   <dd>클러스터에서 애플리케이션 로드 밸런서를 사용 안함으로 설정하려면 이 플래그를 포함시키십시오.</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>이 매개변수는 사설 애플리케이션 로드 밸런서에서만 사용 가능합니다.</li>
    <li>사설 애플리케이션 로드 밸런서는 사용자 제공 사설 서브넷의 IP 주소로 배치됩니다. IP 주소가 제공되지 않으면 애플리케이션 로드 밸런서는 클러스터를 작성할 때 자동으로 프로비저닝된 포터블 사설 서브넷의 사설 IP 주소로 배치됩니다.</li>
   </ul>
   </dd>
   </dl>

**예제**:

  애플리케이션 로드 밸런서를 사용으로 설정하는 예:

  ```
  bx cs alb-configure --albID my_alb_id --enable
  ```
  {: pre}

  애플리케이션 로드 밸런서를 사용 안함으로 설정하는 예:

  ```
  bx cs alb-configure --albID my_alb_id --disable
  ```
  {: pre}

  사용자 제공 IP 주소로 애플리케이션 로드 밸런서를 사용으로 설정하는 예:

  ```
  bx cs alb-configure --albID my_private_alb_id --enable --user-ip user_ip
  ```
  {: pre}

### bx cs alb-get --albID ALB_ID
{: #cs_alb_get}

애플리케이션 로드 밸런서의 세부사항을 봅니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>애플리케이션 로드 밸런서의 ID입니다. 클러스터에서 애플리케이션 로드 밸런서의 ID를 보려면 <code>bx cs albs <em>--cluster </em>CLUSTER</code>를 실행하십시오. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs alb-get --albID ALB_ID
  ```
  {: pre}

### bx cs alb-types
{: #cs_alb_types}

지역에서 지원되는 애플리케이션 로드 밸런서 유형을 봅니다.

<strong>명령 옵션</strong>:

   없음

**예제**:

  ```
  bx cs alb-types
  ```
  {: pre}


### bx cs albs --cluster CLUSTER
{: #cs_albs}

클러스터에서 모든 애플리케이션 로드 밸런서의 상태를 봅니다. 애플리케이션 로드 밸런서 ID가 리턴되지 않으면 클러스터에 포터블 서브넷이 없습니다. 서브넷을 [작성](#cs_cluster_subnet_create)하거나 클러스터에 [추가](#cs_cluster_subnet_add)할 수 있습니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>사용 가능한 애플리케이션 로드 밸런서를 나열하는 클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs albs --cluster mycluster
  ```
  {: pre}


## bx cs api-key-info CLUSTER
{: #cs_api_key_info}

클러스터의 IAM API 키 소유자의 이름과 이메일 주소를 봅니다. 

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs api-key-info my_cluster
  ```
  {: pre}


## bx cs apiserver-config-set
{: #cs_apiserver_config_set}

클러스터의 Kubernetes API 서버 구성에 대한 한 옵션을 설정합니다. 이 명령은 설정할 구성 옵션에 대한 다음 부속 명령 중 하나와 결합되어야 합니다.

### bx cs apiserver-config-get audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_get}

API 서버 감사 로그를 전송 중인 원격 로깅 서비스의 URL을 봅니다. URL은 API 서버 구성을 위한 웹후크 백엔드를 작성할 때 지정되었습니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs apiserver-config-get audit-webhook my_cluster
  ```
  {: pre}

### bx cs apiserver-config-set audit-webhook CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_api_webhook_set}

API 서버 구성을 위한 웹후크 백엔드를 설정합니다. 웹후크 백엔드는 API 서버 감사 로그를 원격 서버로 전달합니다. 웹후크 구성은 사용자가 이 명령의 플래그에 제공하는 정보를 기반으로 작성됩니다. 이 플래그에 정보를 제공하지 않은 경우에는 기본 웹후크 구성이 사용됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>감사 로그를 전송할 원격 로깅 서비스의 URL 또는 IP 주소입니다. 비보안 서버 URL을 제공하는 경우에는 모든 인증서가 무시됩니다.  이 값은 선택사항입니다.</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>원격 로깅 서비스를 확인하는 데 사용되는 CA 인증서의 파일 경로입니다.  이 값은 선택사항입니다.</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>원격 로깅 서비스에 대해 인증하는 데 사용되는 클라이언트 인증서의 파일 경로입니다.  이 값은 선택사항입니다.</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>원격 로깅 서비스에 연결하는 데 사용되는 해당 클라이언트 키의 파일 경로입니다.  이 값은 선택사항입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs apiserver-config-set audit-webhook my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}

### bx cs apiserver-config-unset audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_unset}

클러스터의 API 서버를 위한 웹후크 백엔드 구성을 사용 안함으로 설정합니다. 웹후크 백엔드를 사용 안함으로 설정하면 원격 서버로의 API 서버 감사 로그 전달이 중지됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs apiserver-config-unset audit-webhook my_cluster
  ```
  {: pre}

## bx cs apiserver-refresh CLUSTER
{: #cs_apiserver_refresh}

클러스터에서 Kubernetes 마스터를 다시 시작하여 변경사항을 API 서버 구성에 적용합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs apiserver-refresh my_cluster
  ```
  {: pre}

## 클러스터 명령

### bx cs cluster-config CLUSTER [--admin][--export]
{: #cs_cluster_config}

로그인한 다음 클러스터에 연결할 Kubernetes 구성 데이터 및 인증서를 다운로드하고 `kubectl` 명령을 실행합니다. 파일은 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`에 다운로드됩니다.

**명령 옵션**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--admin</code></dt>
   <dd>수퍼유저 역할을 위한 TLS 인증서와 권한 파일을 다운로드합니다. 재인증할 필요 없이 인증서를 사용하여 클러스터의 태스크를 자동화할 수 있습니다. 파일은 `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`에 다운로드됩니다.  이 값은 선택사항입니다.</dd>

   <dt><code>--export</code></dt>
   <dd>내보내기 명령 이외의 다른 메시지 없이 Kubernetes 구성 데이터와 인증서를 다운로드합니다. 메시지가 표시되지 않으므로 자동화된 스크립트를 작성할 때 이 플래그를 사용할 수 있습니다.  이 값은 선택사항입니다.</dd>
   </dl>

**예제**:

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER][--disable-disk-encrypt]
{: #cs_cluster_create}

조직에서 클러스터를 작성합니다.

<strong>명령 옵션</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>표준 클러스터를 작성하기 위한 YAML 파일의 경로입니다. 이 명령에 제공된 옵션을 사용하여 클러스터의 특징을 정의하지 않고 YAML 파일을 사용할 수 있습니다.  이 값은 표준 클러스터의 경우 선택사항이며 라이트 클러스터에는 사용할 수 없습니다.

<p><strong>참고:</strong> 명령에서 YAML 파일의 매개변수와 동일한 옵션을 제공하면 명령의 값이 YAML의 값보다 우선합니다. 예를 들어, YAML 파일의 위치를 정의하고 명령에서 <code>--location</code> 옵션을 사용하십시오. 그러면 명령 옵션에 입력한 값이 YAML 파일의 값을 대체합니다.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>

</code></pre>


<table>
    <caption>표 1. YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td><code><em>&lt;cluster_name&gt;</em></code>을 클러스터의 이름으로 대체합니다.</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td><code><em>&lt;location&gt;</em></code>을 클러스터를 작성할 위치로 대체합니다. 사용 가능한 위치는 사용자가 로그인한 지역에 따라 다릅니다. 사용 가능한 위치를 나열하려면 <code>bx cs locations</code>를 실행하십시오. </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>기본적으로 공용 및 사설 포터블 서브넷 둘 다 클러스터와 연관된 VLAN에서 작성됩니다. 클러스터에서 서브넷을 작성하지 않도록 하려면 <code><em>&lt;no-subnet&gt;</em></code>을 <code><em>true</em></code>로 대체하십시오. 나중에 서브넷을 [작성](#cs_cluster_subnet_create)하거나 클러스터에 [추가](#cs_cluster_subnet_add)할 수 있습니다.</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td><code><em>&lt;machine_type&gt;</em></code>을 작업자 노드에 사용하려는 시스템 유형으로 대체합니다. 사용자의 위치에서 사용 가능한 시스템 유형을 나열하려면 <code>bx cs machine-types <em>&lt;location&gt;</em></code>을 실행하십시오.</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td><code><em>&lt;private_vlan&gt;</em></code>을 작업자 노드에 사용하려는 프라이빗 VLAN의 ID로 대체합니다. 사용 가능한 VLAN을 나열하려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하고 <code>bcr</code>(백엔드 라우터)로 시작하는 VLAN 라우터를 찾으십시오.</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td><code><em>&lt;public_vlan&gt;</em></code>을 작업자 노드에 사용하려는 퍼블릭 VLAN의 ID로 대체합니다. 사용 가능한 VLAN을 나열하려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하고 <code>fcr</code>(프론트 엔드 라우터)로 시작하는 VLAN 라우터를 찾으십시오.</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스를 사용 가능하게 하려면 dedicated를 사용하고, 실제 리소스를 다른 IBM 고객과 공유하도록 허용하려면 shared를 사용하십시오. 기본값은 <code>shared</code>입니다.</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td><code><em>&lt;number_workers&gt;</em></code>를 배치할 작업자 노드 수로 대체합니다.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>클러스터 마스터 노드를 위한 Kubernetes 버전입니다. 이 값은 선택사항입니다. 지정되지 않는 경우 클러스터는 지원되는 Kubernetes 버전의 기본값으로 작성됩니다. 사용 가능한 버전을 보려면 <code>bx cs kube-versions</code>를 실행하십시오.</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_secure.html#worker). 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하고 값을 <code>false</code>로 설정하십시오.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스를 사용 가능하게 하려면 dedicated를 사용하고, 실제 리소스를 다른 IBM 고객과 공유하도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다.   이 값은 표준 클러스터의 경우 선택사항이며 라이트 클러스터에는 사용할 수 없습니다.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>클러스터를 작성하려는 위치입니다. 사용 가능한 위치는 사용자가 로그인한 {{site.data.keyword.Bluemix_notm}} 지역에 따라 다릅니다. 최고의 성능을 위해서는 실제로 사용자와 가장 가까운 지역을 선택하십시오.  이 값은 표준 클러스터의 경우 필수이며 라이트 클러스터의 경우 선택사항입니다.

<p>[사용 가능한 위치](cs_regions.html#locations)를 검토하십시오.
</p>

<p><strong>참고:</strong> 자국 외에 있는 위치를 선택하는 경우에는 외국에서 데이터를 물리적으로 저장하기 전에 법적 인가를 받아야 할 수 있다는 것을 기억하십시오.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>선택하는 시스템 유형은
작업자 노드에 배치된 컨테이너가 사용할 수 있는 메모리와 디스크 공간의 양에 영향을 줍니다. 사용 가능한 시스템 유형을 나열하려면 [bx cs machine-types <em>LOCATION</em>](#cs_machine_types)을,참조하십시오.   이 값은 표준 클러스터의 경우 필수이며 라이트 클러스터에는 사용할 수 없습니다.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>클러스터의 이름입니다.  이 값은 필수입니다.</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>클러스터 마스터 노드를 위한 Kubernetes 버전입니다. 이 값은 선택사항입니다. 지정되지 않는 경우 클러스터는 지원되는 Kubernetes 버전의 기본값으로 작성됩니다. 사용 가능한 버전을 보려면 <code>bx cs kube-versions</code>를 실행하십시오.</dd>

<dt><code>--no-subnet</code></dt>
<dd>기본적으로 공용 및 사설 포터블 서브넷 둘 다 클러스터와 연관된 VLAN에서 작성됩니다. 클러스터에서 서브넷을 작성하지 않도록 하려면 <code>--no-subnet</code> 플래그를 포함하십시오. 나중에 서브넷을 [작성](#cs_cluster_subnet_create)하거나 클러스터에 [추가](#cs_cluster_subnet_add)할 수 있습니다.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>라이트 클러스터에는 이 매개변수를 사용할 수 없습니다.</li>
<li>이 표준 클러스터가 이 위치에서 작성하는 첫 번째 표준 클러스터인 경우 이 플래그를 포함하지 마십시오. 클러스터가 작성되면 프라이빗 VLAN이 작성됩니다.</li>
<li>이 위치에서 이전에 표준 클러스터를 작성했거나 IBM Cloud 인프라(SoftLayer)에서 이전에 프라이빗 VLAN을 작성한 경우 이 프라이빗 VLAN을 지정해야 합니다.

<p><strong>참고:</strong> create 명령으로 지정하는 퍼블릭 및 프라이빗 VLAN은 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오.</p></li>
</ul>

<p>특정 위치에 대한 프라이빗 VLAN이 이미 있는지 찾거나 기존 프라이빗 VLAN의 이름을 찾으려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하십시오.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>라이트 클러스터에는 이 매개변수를 사용할 수 없습니다.</li>
<li>이 표준 클러스터가 이 위치에서 작성하는 첫 번째 표준 클러스터인 경우 이 플래그를 사용하지 마십시오. 클러스터가 작성되면 퍼블릭 VLAN이 작성됩니다.</li>
<li>이 위치에서 이전에 표준 클러스터를 작성했거나 IBM Cloud 인프라(SoftLayer)에서 이전에 퍼블릭 VLAN을 작성한 경우 해당 퍼블릭 VLAN을 지정해야 합니다.

<p><strong>참고:</strong> create 명령으로 지정하는 퍼블릭 및 프라이빗 VLAN은 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오.</p></li>
</ul>

<p>특정 위치에 대한 퍼블릭 VLAN이 이미 있는지 찾거나 기존 퍼블릭 VLAN의 이름을 찾으려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하십시오.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>클러스터에 배치하려는 작업자 노드의 수입니다. 이 옵션을 지정하지 않으면 1개의 작업자 노드가 있는 클러스터가 작성됩니다. 이 값은 표준 클러스터의 경우 선택사항이며 라이트 클러스터에는 사용할 수 없습니다.

<p><strong>참고:</strong> 모든 작업자 노드에는 클러스터가 작성된 이후 수동으로 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 클러스터를 관리할 수 없습니다.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_secure.html#worker). 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하십시오.</dd>
</dl>

**예제**:

  

  표준 클러스터의 예:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  라이트 클러스터의 예:

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}} 환경의 예:

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

조직의 클러스터에 대한 정보를 봅니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>클러스터에 대한 VLAN 및 서브넷을 표시합니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

조직에서 클러스터를 제거합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>-f</code></dt>
   <dd>사용자 프롬프트를 표시하지 않고 클러스터의 제거를 강제 실행하려면 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스를 추가합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 네임스페이스의 이름입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>바인드하려는 {{site.data.keyword.Bluemix_notm}} 서비스 인스턴스의 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

클러스터에서 {{site.data.keyword.Bluemix_notm}} 서비스를 제거합니다.

**참고:** {{site.data.keyword.Bluemix_notm}} 서비스를 제거하면 서비스 신임 정보도 클러스터에서 제거됩니다. 포드에서 서비스를 계속 사용 중인 경우,
서비스 신임 정보를 찾을 수 없기 때문에 실패합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 네임스페이스의 이름입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>제거하려는 {{site.data.keyword.Bluemix_notm}} 서비스 인스턴스의 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

클러스터에서 한 개 또는 모든 Kubernetes 네임스페이스에 바인드된 서비스를 나열합니다. 옵션이 지정되지 않은 경우 기본 네임스페이스를 위한 서비스가 표시됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>클러스터에서 특정 네임스페이스에 바인드된 서비스를 포함합니다.  이 값은 선택사항입니다.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>클러스터에서 모든 네임스페이스에 바인드된 서비스를 포함합니다.  이 값은 선택사항입니다.</dd>
    </dl>

**예제**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

IBM Cloud 인프라(SoftLayer) 계정의 서브넷을 지정된 클러스터에서 사용 가능하도록 설정합니다.

**참고:** 클러스터에 서브넷을 사용 가능하게 하면 이 서브넷의 IP 주소가 클러스터 네트워킹 목적으로 사용됩니다. IP 주소 충돌을 피하려면 한 개의 클러스터만 있는 서브넷을 사용해야 합니다. 동시에
{{site.data.keyword.containershort_notm}}의 외부에서
다른 목적으로 또는 다중 클러스터에 대한 서브넷으로 사용하지 마십시오.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>서브넷의 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs cluster-subnet-create CLUSTER SIZE VLAN_ID
{: #cs_cluster_subnet_create}

IBM Cloud 인프라(SoftLayer) 계정에서 서브넷을 작성하고 {{site.data.keyword.containershort_notm}}의 지정된 클러스터에 사용 가능하도록 설정합니다.

**참고:** 클러스터에 서브넷을 사용 가능하게 하면 이 서브넷의 IP 주소가 클러스터 네트워킹 목적으로 사용됩니다. IP 주소 충돌을 피하려면 한 개의 클러스터만 있는 서브넷을 사용해야 합니다. 동시에
{{site.data.keyword.containershort_notm}}의 외부에서
다른 목적으로 또는 다중 클러스터에 대한 서브넷으로 사용하지 마십시오.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다. 클러스터를 나열하려면 `bx cs clusters` [명령](#cs_clusters)을 사용하십시오.</dd>

   <dt><code><em>SIZE</em></code></dt>
   <dd>서브넷 IP 주소의 수입니다. 이 값은 필수입니다. 가능한 값은 8, 16, 32 또는 64입니다.</dd>

   <dt><code><em>VLAN_ID</em></code></dt>
   <dd>서브넷을 작성할 VLAN입니다. 이 값은 필수입니다. VLAN을 나열하려면 `bx cs vlans <location>` [명령](#cs_vlans)을 사용하십시오.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-subnet-create my_cluster 8 1764905
  ```
  {: pre}

### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

고유한 사설 서브넷을 {{site.data.keyword.containershort_notm}} 클러스터로 가져옵니다.

이 사설 서브넷은 IBM Cloud 인프라(SoftLayer)에서 제공되는 서브넷이 아닙니다. 따라서 서브넷에 대한 인바운드 및 아웃바운드 네트워크 트래픽 라우팅을 구성해야 합니다. IBM Cloud 인프라(SoftLayer) 서브넷을 추가하려면 `bx cs cluster-subnet-add` [명령](#cs_cluster_subnet_add)을 사용하십시오.

**참고:** 클러스터에 사설 사용자 서브넷을 추가하면 이 서브넷의 IP 주소가 클러스터의 사설 로드 밸런서로 사용됩니다. IP 주소 충돌을 피하려면 한 개의 클러스터만 있는 서브넷을 사용해야 합니다. 동시에
{{site.data.keyword.containershort_notm}}의 외부에서
다른 목적으로 또는 다중 클러스터에 대한 서브넷으로 사용하지 마십시오.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>서브넷 CIDR(Classless InterDomain Routing)입니다. 이 값은 필수이며 IBM Cloud 인프라(SoftLayer)에서 사용되는 서브넷과 충돌하지 않아야 합니다.

   지원되는 접두부의 범위는 `/30`(1개의 IP 주소) - `/24`(253개의 IP 주소)입니다. 하나의 접두부 길이에 CIDR을 설정하고 나중에 이를 변경해야 하는 경우 먼저 새 CIDR을 추가한 후 [이전 CIDR을 제거](#cs_cluster_user_subnet_rm)하십시오.</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>프라이빗 VLAN의 ID입니다. 이 값은 필수입니다. 클러스터에 있는 하나 이상의 작업자 노드의 프라이빗 VLAN ID와 일치해야 합니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

지정된 클러스터에서 고유한 사설 서브넷을 제거합니다.

**참고:** 고유한 사설 서브넷에서 IP 주소에 배치된 서비스는 서브넷이 제거된 후에도 활성 상태로 남아 있습니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>서브넷 CIDR(Classless InterDomain Routing)입니다. 이 값은 필수이며 `bx cs cluster-user-subnet-add` [명령](#cs_cluster_user_subnet_add)을 사용하여 설정된 CIDR과 일치해야 합니다.</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>프라이빗 VLAN의 ID입니다. 이 값은 필수이며 `bx cs cluster-user-subnet-add` [명령](#cs_cluster_user_subnet_add)을 사용하여 설정된 VLAN ID와 일치해야 합니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update]
{: #cs_cluster_update}

Kubernetes 마스터를 기본 API 버전으로 업데이트합니다. 업데이트 중에는 클러스터에 액세스하거나 클러스터를 변경할 수 없습니다. 사용자가 배치한 작업자 노드, 앱 및 리소스는 수정되지 않고 계속 실행됩니다.

차후 배치를 위해 YAML 파일을 변경해야 할 수도 있습니다. 세부사항은 이 [릴리스 정보](cs_versions.html)를 검토하십시오.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>클러스터의 Kubernetes 버전입니다. 이 플래그를 지정하지 않으면 Kubernetes 마스터가 기본 API 버전으로 업데이트됩니다. 사용 가능한 버전을 보려면 [bx cs kube-versions](#cs_kube_versions)를 실행하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code>-f</code></dt>
   <dd>사용자 프롬프트를 표시하지 않고 마스터 업데이트를 강제 실행하려면 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code>--force-update</code></dt>
   <dd>변경 시 부 버전의 차이가 2보다 큰 경우에도 업데이트를 시도합니다.  이 값은 선택사항입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

조직에서 클러스터의 목록을 봅니다.

<strong>명령 옵션</strong>:

  없음

**예제**:

  ```
  bx cs clusters
  ```
  {: pre}

## 신임 정보 명령

### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

{{site.data.keyword.Bluemix_notm}} 계정에 대한 IBM Cloud 인프라(SoftLayer) 계정 신임 정보를 설정합니다. 이러한 신임 정보를 사용하면 {{site.data.keyword.Bluemix_notm}} 계정을 통해 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스할 수 있습니다.

**참고:** 하나의 {{site.data.keyword.Bluemix_notm}} 계정에 대해 여러 신임 정보를 설정하지 마십시오. 모든 {{site.data.keyword.Bluemix_notm}} 계정이 하나의 IBM Cloud 인프라(SoftLayer) 포트폴리오에만 연결됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud 인프라(SoftLayer) 계정 사용자 이름입니다. 이 값은 필수입니다.</dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud 인프라(SoftLayer) 계정 API 키입니다. 이 값은 필수입니다.

 <p>

API 키를 생성하려면 다음을 수행하십시오.

  <ol>
  <li>[IBM Cloud 인프라(SoftLayer) 포털 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://control.softlayer.com/)에 로그인하십시오.</li>
  <li><strong>계정</strong>을 선택한 후에 <strong>사용자</strong>를 선택하십시오.</li>
  <li><strong>생성</strong>을 클릭하여 사용자 계정에 대한 IBM Cloud 인프라(SoftLayer) API 키를 생성하십시오.</li>
  <li>이 명령에서 사용할 API 키를 복사하십시오.</li>
  </ol>

  기존 API 키를 보려면 다음을 수행하십시오.
  <ol>
  <li>[IBM Cloud 인프라(SoftLayer) 포털 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://control.softlayer.com/)에 로그인하십시오.</li>
  <li><strong>계정</strong>을 선택한 후에 <strong>사용자</strong>를 선택하십시오.</li>
  <li><strong>보기</strong>를 클릭하여 기존 API 키를 확인하십시오.</li>
  <li>이 명령에서 사용할 API 키를 복사하십시오.</li>
  </ol>
  </p></dd>
  </dl>

**예제**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


###   bx cs credentials-unset
{: #cs_credentials_unset}

{{site.data.keyword.Bluemix_notm}} 계정에서 IBM Cloud 인프라(SoftLayer) 계정 신임 정보를 제거합니다. 신임 정보를 제거한 후에는 {{site.data.keyword.Bluemix_notm}} 계정을 통해 IBM Cloud 인프라(SoftLayer) 포트폴리오에 더 이상 액세스할 수 없습니다.

<strong>명령 옵션</strong>:

   없음

**예제**:

  ```
  bx cs credentials-unset
  ```
  {: pre}



##   bx cs help
{: #cs_help}

지원되는 명령 및 매개변수의 목록을 봅니다.

<strong>명령 옵션</strong>:

   없음

**예제**:

  ```
  bx cs help
  ```
  {: pre}


## bx cs init [--host HOST]
{: #cs_init}

{{site.data.keyword.containershort_notm}} 플러그인을 초기화하거나 Kubernetes 클러스터를 작성 또는 액세스할 지역을 지정합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>사용할 {{site.data.keyword.containershort_notm}} API 엔드포인트입니다.  이 값은 선택사항입니다. [사용 가능한 API 엔드포인트 값을 보십시오. ](cs_regions.html#container_regions)</dd>
   </dl>



```
        bx cs init --host https://uk-south.containers.bluemix.net
```
{: pre}

## bx cs kube-versions
{: #cs_kube_versions}

{{site.data.keyword.containershort_notm}}에서 지원되는 Kubernetes 버전 목록을 봅니다. [클러스터 마스터](#cs_cluster_update) 및 [작업자 노드](#cs_worker_update)를 안정적인 최신 기능을 위한 기본 버전으로 업데이트합니다.

**명령 옵션**:

  없음

**예제**:

  ```
  bx cs kube-versions
  ```
  {: pre}

##   bx cs locations
{: #cs_datacenters}

사용자가 클러스터를 작성하기 위해 사용할 수 있는 위치의 목록을 봅니다.

<strong>명령 옵션</strong>:

   없음

**예제**:

  ```
  bx cs locations
  ```
  {: pre}

## 로깅 명령

### bx cs logging-config-create CLUSTER --logsource LOG_SOURCE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG] --type LOG_TYPE [--json]
{: #cs_logging_create}

로깅 구성을 작성합니다. 이 명령을 사용하여 컨테이너, 애플리케이션, 작업자 노드, Kubernetes 클러스터 및 Ingress 애플리케이션 로드 밸런서에 대한 로그를 {{site.data.keyword.loganalysisshort_notm}} 또는 외부 syslog 서버로 전달할 수 있습니다.

<strong>명령 옵션</strong>:

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>클러스터의 이름 또는 ID입니다.</dd>
<dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
<dd>로그 전달을 사용할 로그 소스입니다. 허용되는 값은 <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> 및 <code>ingress</code>입니다. 이 값은 필수입니다.</dd>
<dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
<dd>로그를 전달할 Kubernetes 네임스페이스입니다. <code>ibm-system</code> 및 <code>kube-system</code> Kubernetes 네임스페이스의 경우 로그 전달이 지원되지 않습니다. 이 값은 컨테이너 로그 소스에 대해서만 유효하며 선택사항입니다. 네임스페이스를 지정하지 않으면 컨테이너의 모든 네임스페이스가 이 구성을 사용합니다. </dd>
<dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
<dd>로깅 유형이 <code>syslog</code>인 경우 로그 콜렉터 서버의 호스트 이름 또는 IP 주소입니다. 이 값은 <code>syslog</code>에 필수입니다. 로깅 유형이 <code>ibm</code>인 경우 {{site.data.keyword.loganalysislong_notm}} 유입 URL입니다. 사용 가능한 유입 URL 목록은 [여기](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)에서 찾을 수 있습니다. 유입 URL을 지정하지 않으면 클러스터가 작성된 지역의 엔드포인트가 사용됩니다.</dd>
<dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
<dd>로그 콜렉터 서버의 포트입니다. 이 값은 선택사항입니다. 포트를 지정하지 않으면 표준 포트 <code>514</code>가 <code>syslog</code>에 사용되고 표준 포트 <code>9091</code>이 <code>ibm</code>에 사용됩니다.</dd>
<dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
<dd>로그를 전송할 Cloud Foundry 영역의 이름입니다. 이 값은 <code>ibm</code> 로그 유형에 대해서만 유효하며 선택사항입니다. 영역을 지정하지 않으면 로그는 계정 레벨로 전송됩니다.</dd>
<dt><code>--org <em>CLUSTER_ORG</em></code></dt>
<dd>영역이 있는 Cloud Foundry 조직의 이름입니다. 이 값은 <code>ibm</code> 로그 유형에 대해서만 유효하며, 영역을 지정한 경우 필수입니다.</dd>
<dt><code>--type <em>LOG_TYPE</em></code></dt>
<dd>사용하려는 로그 전달 프로토콜입니다. 현재 <code>syslog</code> 및 <code>ibm</code>이 지원됩니다. 이 값은 필수입니다.</dd>
<dt><code>--json</code></dt>
<dd>선택적으로 명령 출력을 JSON 형식으로 인쇄합니다.</dd>
</dl>

**예제**:

기본 포트 9091에서 `container` 로그 소스로부터 전달하는 로그 유형 `ibm`의 예:

  ```
  bx cs logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

기본 포트 514에서 `container` 로그 소스로부터 전달하는 로그 유형 `syslog`의 예: 

  ```
  bx cs logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname my_hostname-or-IP --type syslog
  ```
  {: pre}

기본 포트가 아닌 다른 포트에서 `ingress` 소스로부터 로그를 전달하는 로그 유형 `syslog`의 예:

  ```
    bx cs logging-config-create my_cluster --logsource container --hostname my_hostname-or-IP --port 5514 --type syslog
  ```
  {: pre}

### bx cs logging-config-get CLUSTER [--logsource LOG_SOURCE][--json]
{: #cs_logging_get}

클러스터에 대한 모든 로그 전달 구성을 보거나 로그 소스를 기반으로 로깅 구성을 필터링합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>필터링하려는 로그 소스의 유형입니다. 클러스터에 있는 이 로그 소스의 로깅 구성만 리턴됩니다. 허용되는 값은 <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> 및 <code>ingress</code>입니다.  이 값은 선택사항입니다.</dd>
   <dt><code>--json</code></dt>
   <dd>선택적으로 명령 출력을 JSON 형식으로 인쇄합니다.</dd>
   </dl>

**예제**:

  ```
  bx cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-refresh CLUSTER
{: #cs_logging_refresh}

클러스터의 로깅 구성을 새로 고칩니다. 이렇게 하면 클러스터의 영역 레벨에 전달되는 모든 로깅 구성의 로깅 토큰이 새로 고쳐집니다. 

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs logging-config-refresh my_cluster
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER --id LOG_CONFIG_ID
{: #cs_logging_rm}

로그 전달 구성을 삭제합니다. 이렇게 하면 원격 syslog 서버 또는 {{site.data.keyword.loganalysisshort_notm}}로의 로그 전달이 중지됩니다. 

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>로그 소스에서 제거하려는 로깅 구성 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs logging-config-rm my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### bx cs logging-config-update CLUSTER --id LOG_CONFIG_ID [--hostname LOG_SERVER_HOSTNAME_OR_IP][--port LOG_SERVER_PORT] [--space CLUSTER_SPACE][--org CLUSTER_ORG] --type LOG_TYPE [--json]
{: #cs_logging_update}

로그 전달 구성의 세부사항을 업데이트합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>업데이트하려는 로깅 구성 ID입니다. 이 값은 필수입니다.</dd>
   <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>로깅 유형이 <code>syslog</code>인 경우 로그 콜렉터 서버의 호스트 이름 또는 IP 주소입니다. 이 값은 <code>syslog</code>에 필수입니다. 로깅 유형이 <code>ibm</code>인 경우 {{site.data.keyword.loganalysislong_notm}} 유입 URL입니다. 사용 가능한 유입 URL 목록은 [여기](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)에서 찾을 수 있습니다. 유입 URL을 지정하지 않으면 클러스터가 작성된 지역의 엔드포인트가 사용됩니다.</dd>
   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>로그 콜렉터 서버의 포트입니다. 로깅 유형이 <code>syslog</code>인 경우 이 값은 선택사항입니다. 포트를 지정하지 않으면 표준 포트 <code>514</code>가 <code>syslog</code>에 사용되고 <code>9091</code>이 <code>ibm</code>에 사용됩니다.</dd>
   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>로그를 전송할 영역의 이름입니다. 이 값은 <code>ibm</code> 로그 유형에 대해서만 유효하며 선택사항입니다. 영역을 지정하지 않으면 로그는 계정 레벨로 전송됩니다.</dd>
   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>영역이 있는 조직의 이름입니다. 이 값은 <code>ibm</code> 로그 유형에 대해서만 유효하며, 영역을 지정한 경우 필수입니다.</dd>
   <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>사용하려는 로그 전달 프로토콜입니다. 현재 <code>syslog</code> 및 <code>ibm</code>이 지원됩니다. 이 값은 필수입니다.</dd>
   <dt><code>--json</code></dt>
   <dd>선택적으로 명령 출력을 JSON 형식으로 인쇄합니다.</dd>
   </dl>

**로그 유형 `ibm`**에 대한 예제:

  ```
  bx cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**로그 유형 `syslog`**에 대한 예제:

  ```
  bx cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


##   bx cs machine-types LOCATION
{: #cs_machine_types}

작업자 노드에 대해 사용 가능한 시스템 유형의 목록을 봅니다. 각각의 시스템 유형에는
클러스터의 각 작업자 노드에 대한 가상 CPU, 메모리 및 디스크 공간의 양이 포함됩니다.
- 기본적으로 호스트의 Docker 데이터는 시스템 유형으로 암호화됩니다. 모든 컨테이너 데이터가 저장된 `/var/lib/docker` 디렉토리는 LUKS 암호화를 통해 암호화됩니다. 클러스터 작성 중 `disable-disk-encrypt` 옵션이 포함된 경우, 호스트의 Docker 데이터가 암호화되지 않습니다. [암호화에 대해 자세히 알아보십시오.](cs_secure.html#encrypted_disks)
- 이름에 `u2c` 또는 `b2c`가 있는 시스템 유형은 신뢰성을 위해 SAN(Storage Area Networing) 대신 로컬 디스크를 사용합니다. 신뢰성을 갖게 되면 로컬 디스크에 바이트를 직렬화하는 경우 처리량이 많아지고 네트워크 장애로 인한 파일 시스템 성능 저하를 줄일 수 있습니다. 이러한 시스템 유형에는 OS 파일 시스템을 위한 25GB 로컬 디스크 스토리지 및 모든 컨테이너 데이터가 기록되는 디렉토리 `/var/lib/docker`를 위한 100GB 로컬 디스크 스토리지가 포함됩니다.
- 이름에 `u1c` 또는 `b1c`가 있는 시스템 유형은 더 이상 사용되지 않습니다(예: `u1c.2x4`). `u2c` 및 `b2c` 시스템 유형 사용을 시작하려면 `bx cs worker-add` 명령을 사용하여 업데이트된 시스템 유형의 작업자 노드를 추가하십시오. 그런 다음 `bx cs worker-rm` 명령을 사용하여 더 이상 사용되지 않는 시스템 유형을 사용하는 작업자 노드를 제거하십시오.
</p>


<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>사용 가능한 시스템 유형을 나열하려는 위치를 입력하십시오. 이 값은 필수입니다. [사용 가능한 위치](cs_regions.html#locations)를 검토하십시오.</dd></dl>

**예제**:

  ```
  bx cs machine-types dal10
  ```
  {: pre}

## 지역 명령

### bx cs region
{: #cs_region}

사용자가 현재 있는 {{site.data.keyword.containershort_notm}} 지역을 찾습니다. 사용자는 영역에 특정한 클러스터를 작성하고 관리합니다. 지역을 변경하려면 `bx cs region-set` 명령을 사용하십시오.

**예제**:

```
bx cs region
```
{: pre}

**출력**:
```
Region: us-south
```
{: screen}

### bx cs region-set [REGION]
{: #cs_region-set}

{{site.data.keyword.containershort_notm}}의 지역을 설정합니다. 사용자는 지역에 특정한 클러스터를 작성 및 관리하며, 고가용성을 위해 여러 지역에서 클러스터를 원할 수 있습니다.

예를 들어, 미국 남부 지역에서 {{site.data.keyword.Bluemix_notm}}에 로그인하고 클러스터를 작성할 수 있습니다. 그런 다음, EU 중심부를 대상으로 하기 위해 `bx cs region-set eu-central`을 사용하고 다른 클러스터를 작성할 수 있습니다. 마지막으로, `bx cs region-set us-south`를 사용하여 미국 남부로 돌아가서 해당 지역의 클러스터를 관리할 수 있습니다.

**명령 옵션**:

<dl>
<dt><code><em>REGION</em></code></dt>
<dd>대상으로 할 지역을 입력하십시오. 이 값은 선택사항입니다. 지역을 제공하지 않은 경우 출력의 목록에서 선택할 수 있습니다.

사용 가능한 지역의 목록을 보려면 [지역 및 위치](cs_regions.html)를 검토하거나 `bx cs regions` [명령](#cs_regions)을 사용하십시오.</dd></dl>

**예제**:

```
bx cs region-set eu-central
```
{: pre}

```
bx cs region-set
```
{: pre}

**출력**:
```
Choose a region:
1. ap-north
2. ap-south
3. eu-central
4. uk-south
5. us-east
6. us-south
Enter a number> 3
OK
```
{: screen}

### bx cs regions
{: #cs_regions}

사용 가능한 지역을 나열합니다. `Region Name`은 {{site.data.keyword.containershort_notm}} 이름이고 `Region Alias`는 해당 지역의 일반 {{site.data.keyword.Bluemix_notm}} 이름입니다.

**예제**:

```
bx cs regions
```
{: pre}

**출력**:
```
Region Name   Region Alias
ap-north      jp-tok
ap-south      au-syd
eu-central    eu-de
uk-south      eu-gb
us-east       us-east
us-south      us-south
```
{: screen}

## bx cs subnets
{: #cs_subnets}

IBM Cloud 인프라(SoftLayer) 계정에서 사용 가능한 서브넷의 목록을 봅니다.

<strong>명령 옵션</strong>:

   없음

**예제**:

  ```
bx cs subnets
  ```
  {: pre}


## bx cs vlans LOCATION
{: #cs_vlans}

IBM Cloud 인프라(SoftLayer) 계정의 위치에 사용 가능한 퍼블릭 및 프라이빗 VLAN을 나열합니다. 사용 가능한 VLAN을 나열하려면 유료 계정이 있어야 합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>프라이빗 및 퍼블릭 VLAN을 나열하려는 위치를 입력하십시오. 이 값은 필수입니다. [사용 가능한 위치](cs_regions.html#locations)를 검토하십시오.</dd>
   </dl>

**예제**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


## bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

웹훅을 작성합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>알림 레벨(예: <code>Normal</code> 또는 <code>Warning</code>)입니다. 기본값은 <code>Warning</code>입니다.  이 값은 선택사항입니다.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>웹훅 유형(예: slack)입니다. slack만 지원됩니다. 이 값은 필수입니다.</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>웹훅의 URL입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}

## 작업자 명령

### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt]
{: #cs_worker_add}

표준 클러스터에 작업자 노드를 추가합니다.

<strong>명령 옵션</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>클러스터에 작업자 노드를 추가하기 위한 YAML 파일의 경로입니다. 이 명령에 제공된 옵션을 사용하여 추가 작업자 노드를 정의하지 않고 YAML 파일을 사용할 수 있습니다. 이 값은 선택사항입니다.

<p><strong>참고:</strong> 명령에서 YAML 파일의 매개변수와 동일한 옵션을 제공하면 명령의 값이 YAML의 값보다 우선합니다. 예를 들어, YAML 파일에 시스템 유형을 정의하고 명령에서 --machine-type 옵션을 사용하십시오. 명령 옵션에 입력한 값이 YAML 파일의 값을 대체합니다.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
</code></pre>

<table>
<caption>표 2. YAML 파일 컴포넌트 이해</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td><code><em>&lt;cluster_name_or_id&gt;</em></code>를 작업자 노드를 추가할 클러스터의 이름 또는 ID로 대체합니다.</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td><code><em>&lt;location&gt;</em></code>을 작업자 노드를 배치할 위치로 대체합니다. 사용 가능한 위치는 사용자가 로그인한 지역에 따라 다릅니다. 사용 가능한 위치를 나열하려면 <code>bx cs locations</code>를 실행하십시오.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td><code><em>&lt;machine_type&gt;</em></code>을 작업자 노드에 사용하려는 시스템 유형으로 대체합니다. 사용자의 위치에서 사용 가능한 시스템 유형을 나열하려면 <code>bx cs machine-types <em>&lt;location&gt;</em></code>을 실행하십시오.</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td><code><em>&lt;private_vlan&gt;</em></code>을 작업자 노드에 사용하려는 프라이빗 VLAN의 ID로 대체합니다. 사용 가능한 VLAN을 나열하려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하고 <code>bcr</code>(백엔드 라우터)로 시작하는 VLAN 라우터를 찾으십시오.</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td><code>&lt;public_vlan&gt;</code>을 작업자 노드에 사용하려는 퍼블릭 VLAN의 ID로 대체합니다. 사용 가능한 VLAN을 나열하려면 <code>bx cs vlans &lt;location&gt;</code>을 실행하고 <code>fcr</code>(프론트 엔드 라우터)로 시작하는 VLAN 라우터를 찾으십시오.</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스를 사용 가능하게 하려면 dedicated를 사용하고, 실제 리소스를 다른 IBM 고객과 공유하도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td><code><em>&lt;number_workers&gt;</em></code>를 배치할 작업자 노드 수로 대체합니다.</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_secure.html#worker). 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하고 값을 <code>false</code>로 설정하십시오.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스를 사용 가능하게 하려면 dedicated를 사용하고, 실제 리소스를 다른 IBM 고객과 공유하도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다.  이 값은 선택사항입니다.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>선택하는 시스템 유형은
작업자 노드에 배치된 컨테이너가 사용할 수 있는 메모리와 디스크 공간의 양에 영향을 줍니다. 이 값은 필수입니다. 사용 가능한 시스템 유형을 나열하려면 [bx cs machine-types LOCATION](#cs_machine_types)을 참조하십시오.</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>클러스터에서 작성할 작업자 노드의 수를 표시하는 정수입니다. 기본값은 1입니다. 이 값은 선택사항입니다.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>클러스터가 작성될 때 지정된 프라이빗 VLAN입니다. 이 값은 필수입니다.

<p><strong>참고:</strong> 지정하는 퍼블릭 및 프라이빗 VLAN이 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>클러스터가 작성될 때 지정된 퍼블릭 VLAN입니다. 이 값은 선택사항입니다.

<p><strong>참고:</strong> 지정하는 퍼블릭 및 프라이빗 VLAN이 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_secure.html#worker). 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하십시오.</dd>
</dl>

**예제**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}}의 예:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u2c.2x4
  ```
  {: pre}


### bx cs worker-get [CLUSTER_NAME_OR_ID] WORKER_NODE_ID
{: #cs_worker_get}

작업자 노드의 세부사항을 봅니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>작업자 노드 클러스터의 이름 또는 ID입니다.  이 값은 선택사항입니다.</dd>
   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>작업자 노드의 ID입니다. 클러스터로 작업자 노드를 위한 ID를 보려면 <code>bx cs workers <em>CLUSTER</em></code>를 실행하십시오. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs worker-get [CLUSTER_NAME_OR_ID] WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

클러스터에서 작업자 노드를 다시 부팅합니다. 작업자 노드에 문제점이 있으면
우선 작업자 노드의 재부팅을 시도하십시오. 작업자 노드가 다시 시작됩니다. 다시 부팅해도 문제가 해결되지 않으면 `worker-reload` 명령을 시도하십시오. 작업자의
상태(state)는 재부팅 중에 변경되지 않습니다. 상태(state)는 `deployed`를 유지하지만, 상태(status)가 업데이트됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>-f</code></dt>
   <dd>사용자 프롬프트를 표시하지 않고 작업자 노드의 다시 시작을 강제 실행하려면 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code>--hard</code></dt>
   <dd>작업자 노드의 전원을 끊어서 작업자 노드의 하드 다시 시작을 강제 실행하려면 이 옵션을 사용하십시오. 작업자 노드의 반응이 늦거나 작업자 노드에 Docker
정지가 된 경우 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>하나 이상의 작업자 노드의 이름 또는 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

클러스터에서 작업자 노드를 다시 로드합니다. 작업자 노드에 문제점이 있으면 우선 작업자 노드의 재부팅을 시도하십시오. 다시 부팅해도 문제가 해결되지 않으면 `worker-reload` 명령을 시도하십시오.
그러면 작업자 노드의 모든 필수 구성이 다시 로드됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>-f</code></dt>
   <dd>사용자 프롬프트를 표시하지 않고 작업자 노드의 다시 로드를 강제 실행하려면 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>하나 이상의 작업자 노드의 이름 또는 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

클러스터에서 하나 이상의 작업자 노드를 제거합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>-f</code></dt>
   <dd>사용자 프롬프트를 표시하지 않고 작업자 노드의 제거를 강제 실행하려면 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>하나 이상의 작업자 노드의 이름 또는 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update]
{: #cs_worker_update}

작업자 노드를 최신 Kubernetes 버전으로 업데이트합니다. `bx cs worker-update`를 실행하면 앱과 서비스의 가동이 중단될 수 있습니다. 업데이트 중에 모든 포드가 다른 작업자 노드로 재스케줄되고 포드 외부에 저장되지 않은 경우 데이터가 삭제됩니다. 가동 중단을 방지하려면 선택한 작업자 노드가 업데이트되는 동안 워크로드를 처리하기에 충분한 작업자 노드가 있는지 확인하십시오.

업데이트하기 전에 배치를 위해 YAML 파일을 변경해야 할 수도 있습니다. 세부사항은 이 [릴리스 정보](cs_versions.html)를 검토하십시오.

<strong>명령 옵션</strong>:

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>사용 가능한 작업자 노드를 나열하는 클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>클러스터의 Kubernetes 버전입니다. 이 플래그를 지정하지 않으면 작업자 노드 기본 버전으로 업데이트됩니다. 사용 가능한 버전을 보려면 [bx cs kube-versions](#cs_kube_versions)를 실행하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code>-f</code></dt>
   <dd>사용자 프롬프트를 표시하지 않고 마스터 업데이트를 강제 실행하려면 이 옵션을 사용하십시오.  이 값은 선택사항입니다.</dd>

   <dt><code>--force-update</code></dt>
   <dd>변경 시 부 버전의 차이가 2보다 큰 경우에도 업데이트를 시도합니다.  이 값은 선택사항입니다.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>하나 이상의 작업자 노드의 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

작업자 노드의 목록과 클러스터에서 각각의 상태(status)를 봅니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>사용 가능한 작업자 노드를 나열하는 클러스터의 이름 또는 ID입니다. 이 값은 필수입니다.</dd>
   </dl>

**예제**:

  ```
  bx cs workers mycluster
  ```
  {: pre}

<br />

