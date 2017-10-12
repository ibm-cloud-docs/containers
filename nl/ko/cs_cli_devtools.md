---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

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

**팁:** `bx cr` 명령을 찾고 계십니까? [{{site.data.keyword.registryshort_notm}} CLI 참조](/docs/cli/plugins/registry/index.html#containerregcli)를 확인하십시오. `kubectl` 명령을 찾고 계십니까? [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)를 참조하십시오.

 
<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="{{site.data.keyword.Bluemix_notm}}">에서 클러스터를 작성하기 위한 명령
 <thead>
    <th colspan=5>{{site.data.keyword.Bluemix_notm}}에서 클러스터를 작성하기 위한 명령</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td> 
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td> 
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
  </tr>
 </tbody>
 </table> 
    
**팁:** {{site.data.keyword.containershort_notm}} 플러그인의 버전을 보려면 다음 명령을 실행하십시오.

```
bx plugin list
```
{: pre}



## bx cs 명령
{: #cs_commands}

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

로그인한 다음 클러스터에 연결할 Kubernetes 구성 데이터 및 인증서를 다운로드하고 `kubectl` 명령을 실행하십시오. 파일은 `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`에 다운로드됩니다.

**명령 옵션**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>--admin</code></dt>
   <dd>(선택사항) 관리자 rbac 역할을 위한 인증서와 권한 파일을 다운로드합니다. 이러한 파일이 있는 사용자는 클러스터에 관리자 조치(예: 클러스터 제거)를 수행할 수 있습니다. </dd>
   </dl>

**예제**:

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

조직에서 클러스터를 작성합니다. 

<strong>명령 옵션</strong>

<dl>
   <dt><code>--file <em>FILE_LOCATION</em></code></dt>

   <dd>(표준 클러스터의 경우 선택사항입니다. 라이트 클러스터에서는 사용할 수 없습니다.) 표준 클러스터를 작성하기 위한 YAML 파일의 경로입니다. 이 명령에 제공된 옵션을 사용하여 클러스터의 특징을 정의하지 않고 YAML 파일을 사용할 수 있습니다.

    <p><strong>참고:</strong> 명령에서 YAML 파일의 매개변수와 동일한 옵션을 제공하면 명령의 값이 YAML의 값보다 우선합니다. 예를 들어, YAML 파일의 위치를 정의하고 명령에서 <code>--location</code> 옵션을 사용하십시오. 그러면 명령 옵션에 입력한 값이 YAML 파일의 값을 대체합니다.

    <pre class="codeblock"><code>
    name: <em>&lt;cluster_name&gt;</em>
    location: <em>&lt;location&gt;</em>
    machine-type: <em>&lt;machine_type&gt;</em>
    private-vlan: <em>&lt;private_vlan&gt;</em>
    public-vlan: <em>&lt;public_vlan&gt;</em>
    hardware: <em>&lt;shared_or_dedicated&gt;</em>
    workerNum: <em>&lt;number_workers&gt;</em></code></pre>


    <table>
    <caption>표 1. YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
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
     <td><code><em>machine-type</em></code></td>
     <td><code><em>&lt;machine_type&gt;</em></code>을 작업자 노드에 사용하려는 시스템 유형으로 대체합니다. 사용자의 위치에서 사용 가능한 시스템 유형을 나열하려면 <code>bx cs machine-types <em>&lt;location&gt;</em></code>을 실행하십시오. </td> 
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
     <td>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스가 사용 가능하도록 하려면 dedicated를 사용하고, 실제 리소스가 다른 IBM 고객과 공유되도록 허용하려면 shared를 사용하십시오. 기본값은 <code>shared</code>입니다. </td> 
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td><code><em>&lt;number_workers&gt;</em></code>를 배치할 작업자 노드 수로 대체합니다.</td> 
     </tr>
     </tbody></table>
    </p></dd>
    
    <dt><code>--hardware <em>HARDWARE</em></code></dt>
    <dd>(표준 클러스터의 경우 선택사항입니다. 라이트 클러스터에서는 사용할 수 없습니다.) 작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스가 사용 가능하도록 하려면 dedicated를 사용하고, 실제 리소스가 다른 IBM 고객과 공유되도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다.</dd>

    <dt><code>--location <em>LOCATION</em></code></dt>
    <dd>(표준 클러스터의 경우 필수입니다. 라이트 클러스터에는 선택사항입니다.) 클러스터를 작성하려는 위치입니다. 사용 가능한 위치는 사용자가 로그인한 {{site.data.keyword.Bluemix_notm}} 지역에 따라 다릅니다. 최고의 성능을 위해서는 실제로 사용자와 가장 가까운 지역을 선택하십시오.


        <p>사용 가능한 위치는 다음과 같습니다. <ul><li>미국 남부<ul><li>dal10 [댈러스]</li><li>dal12 [댈러스]</li></ul></li><li>영국 남부<ul><li>lon02 [런던]</li><li>lon04 [런던]</li></ul></li><li>중앙 유럽<ul><li>ams03 [암스테르담]</li><li>ra02 [프랑크푸르트]</li></ul></li><li>AP 남부<ul><li>syd01 [시드니]</li><li>syd04 [시드니]</li></ul></li></ul>
        </p>

        <p><strong>참고:</strong> 자국 외에 있는 위치를 선택하는 경우에는 외국에서 데이터를 물리적으로 저장하기 전에 법적 인가를 받아야 할 수 있음을 유념하십시오. </p>
        </dd>

    <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>(표준 클러스터의 경우 필수입니다. 라이트 클러스터에서는 사용할 수 없습니다.) 선택하는 시스템 유형은 작업자 노드에 배치된 컨테이너가 사용할 수 있는 메모리와 디스크 공간의 양에 영향을 줍니다. 사용 가능한 시스템 유형을 나열하려면 [bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types)을 참조하십시오.</dd>

    <dt><code>--name <em>NAME</em></code></dt>
    <dd>(필수) 클러스터의 이름입니다. </dd>

    <dt><code>--no-subnet</code></dt>
    <dd>포터블 서브넷 없이 클러스터를 작성하기 위한 플래그를 포함합니다. 기본값은 플래그를 사용하지 않고 {{site.data.keyword.BluSoftlayer_full}} 포트폴리오에서 서브넷을 작성하는 것입니다. </dd>

    <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>(라이트 클러스터의 경우 사용할 수 없습니다.) 

        <ul>
        <li>이 위치에서 작성하는 첫 번째 클러스터가 이 클러스터인 경우 이 플래그를 포함하지 마십시오. 클러스터가 작성되면 프라이빗 VLAN이 작성됩니다. </li>
        <li>이 위치에서 이전에 클러스터를 작성했거나 {{site.data.keyword.BluSoftlayer_notm}}에서 이전에 프라이빗 VLAN을 작성한 경우, 그 프라이빗 VLAN을 지정해야 합니다. 

            <p><strong>참고:</strong> create 명령으로 지정하는 퍼블릭 및 프라이빗 VLAN은 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오. </p></li>
        </ul>

    <p>특정 위치에 대한 프라이빗 VLAN이 이미 있는지 찾거나 기존 프라이빗 VLAN의 이름을 찾으려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하십시오.</p></dd>

    <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>(라이트 클러스터의 경우 사용할 수 없습니다.) 

        <ul>
        <li>이 위치에서 작성하는 첫 번째 클러스터가 이 클러스터인 경우 이 플래그를 사용하지 마십시오. 클러스터가 작성되면 퍼블릭 VLAN이 작성됩니다. </li>
        <li>이 위치에서 이전에 클러스터를 작성했거나 {{site.data.keyword.BluSoftlayer_notm}}에서 이전에 퍼블릭 VLAN을 작성한 경우, 그 퍼블릭 VLAN을 지정해야 합니다. 

            <p><strong>참고:</strong> create 명령으로 지정하는 퍼블릭 및 프라이빗 VLAN은 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오. </p></li>
        </ul>

    <p>특정 위치에 대한 퍼블릭 VLAN이 이미 있는지 찾거나 기존 퍼블릭 VLAN의 이름을 찾으려면 <code>bx cs vlans <em>&lt;location&gt;</em></code>을 실행하십시오.</p></dd>

    <dt><code>--workers WORKER</code></dt>
    <dd>(표준 클러스터의 경우 선택사항입니다. 라이트 클러스터에서는 사용할 수 없습니다.) 클러스터에 배치하려는 작업자 노드의 수입니다. 이 옵션을 지정하지 않으면 1개의 작업자 노드가 있는 클러스터가 작성됩니다. 

    <p><strong>참고:</strong> 모든 작업자 노드에는 클러스터가 작성된 이후 수동으로 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 클러스터를 관리할 수 없습니다. </p></dd>
  </dl>

**예제**:

  my_public_vlan_id --private-vlan my_private_vlan_id --name my_cluster
  ```
  {: pre}
    
  </staging>
  
  표준 클러스터의 예제:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  라이트 클러스터의 예제:

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  {{site.data.keyword.Bluemix_notm}} 데디케이티드 환경에 대한 예제:

  ```

  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name

  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

조직의 클러스터에 대한 정보를 봅니다.

<strong>명령 옵션</strong>:<dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>
   </dl>

**예제**:

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

조직에서 클러스터를 제거합니다.

<strong>명령 옵션</strong>:<dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>-f</code></dt>
   <dd>(선택사항) 사용자 프롬프트를 표시하지 않고 클러스터의 제거를 강제 실행하려면 이 옵션을 사용하십시오. </dd>
   </dl>

**예제**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스를 추가합니다.

**팁:** {{site.data.keyword.Bluemix_notm}} 데디케이티드 사용자의 경우 [{{site.data.keyword.Bluemix_notm}} 서비스를 {{site.data.keyword.Bluemix_notm}} 데디케이티드(비공개 베타)의 클러스터에 추가](cs_cluster.html#binding_dedicated)를 확인하십시오.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(필수) Kubernetes 네임스페이스의 이름입니다. </dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(필수) 바인드하려는 {{site.data.keyword.Bluemix_notm}} 서비스 인스턴스의 ID입니다. </dd>
   </dl>

**예제**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

클러스터에서 {{site.data.keyword.Bluemix_notm}} 서비스를 제거하십시오.

**참고:** {{site.data.keyword.Bluemix_notm}} 서비스를 제거하면 클러스터에서 서비스 신임 정보가 제거됩니다. 포드에서 서비스를 계속 사용 중인 경우,
서비스 신임 정보를 찾을 수 없기 때문에 실패합니다. <strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(필수) Kubernetes 네임스페이스의 이름입니다. </dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(필수) 제거하려는 {{site.data.keyword.Bluemix_notm}} 서비스 인스턴스의 ID입니다. </dd>
   </dl>

**예제**:

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE] [--all-namespaces]
{: #cs_cluster_services}

클러스터에서 하나 또는 모든 Kubernetes 네임스페이스에 바인드된 서비스를 나열하십시오. 옵션이 지정되지 않은 경우 기본 네임스페이스를 위한 서비스가 표시됩니다. <strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(선택사항) 클러스터에서 특정 네임스페이스에 바인드된 서비스를 포함합니다. </dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>(선택사항) 클러스터에서 모든 네임스페이스에 바인드된 서비스를 포함합니다. </dd>
    </dl>

**예제**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

지정된 클러스터에서 {{site.data.keyword.BluSoftlayer_notm}} 계정의 서브넷을 사용 가능하게 만듭니다.

**참고:** 클러스터에 서브넷을 사용 가능하게 하면 이 서브넷의 IP 주소가 클러스터 네트워킹 목적으로 사용됩니다. IP 주소 충돌을 피하려면 한 개의 클러스터만 있는 서브넷을 사용해야 합니다. 동시에
{{site.data.keyword.containershort_notm}}의 외부에서
다른 목적으로 또는 다중 클러스터에 대한 서브넷으로 사용하지 마십시오. <strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>(필수) 서브넷의 ID입니다. </dd>
   </dl>

**예제**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

조직의 클러스터 목록을 보십시오.

<strong>명령 옵션</strong>:

   None

**예제**:

  ```
   bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

{{site.data.keyword.Bluemix_notm}} 계정의 {{site.data.keyword.BluSoftlayer_notm}} 계정 신임 정보를 설정하십시오. 이러한 신임 정보는 {{site.data.keyword.Bluemix_notm}} 계정을 통해
{{site.data.keyword.BluSoftlayer_notm}}
포트폴리오에 액세스하도록 허용합니다. <strong>명령 옵션</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>(필수) {{site.data.keyword.BluSoftlayer_notm}} 계정 사용자 이름입니다. </dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>(필수) {{site.data.keyword.BluSoftlayer_notm}} 계정 API 키입니다. <p>

API 키를 생성하려면 다음을 수행하십시오. <ol>
  <li>{{site.data.keyword.BluSoftlayer_notm}} 포털에 로그인하십시오. ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://control.softlayer.com/).</li>
  <li><strong>계정</strong>을 선택한 후에 <strong>사용자</strong>를 선택하십시오. </li>
  <li><strong>생성</strong>을 클릭하여 사용자 계정에 대한
{{site.data.keyword.BluSoftlayer_notm}} API 키를 생성하십시오. </li>
  <li>이 명령에서 사용할 API 키를 복사하십시오. </li>
  </ol>

기존 API 키를 보려면 다음을 수행하십시오. <ol>
  <li>{{site.data.keyword.BluSoftlayer_notm}} 포털에 로그인하십시오. ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://control.softlayer.com/).</li>
  <li><strong>계정</strong>을 선택한 후에 <strong>사용자</strong>를 선택하십시오. </li>
  <li><strong>보기</strong>를 클릭하여 기존 API 키를 확인하십시오. </li>
  <li>이 명령에서 사용할 API 키를 복사하십시오. </li>
  </ol></p></dd>
    
**예제**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

{{site.data.keyword.Bluemix_notm}} 계정에서 {{site.data.keyword.BluSoftlayer_notm}} 계정 신임 정보를 제거합니다. 신임 정보를 제거한 후에는 {{site.data.keyword.Bluemix_notm}}
계정을 통하여 {{site.data.keyword.BluSoftlayer_notm}} 포트폴리오에 더 이상 액세스할 수 없습니다. <strong>명령 옵션</strong>:

   None

**예제**:

  ```
  bx cs credentials-unset
  ```
  {: pre}


### bx cs locations
{: #cs_datacenters}

클러스터를 작성하는 데 사용할 수 있는 위치 목록을 봅니다.

<strong>명령 옵션</strong>:

   None

**예제**:

  ```
  bx cs locations
  ```
  {: pre}


### bx cs help
{: #cs_help}

지원되는 명령 및 매개변수 목록을 봅니다.

<strong>명령 옵션</strong>:

   None

**예제**:

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

{{site.data.keyword.containershort_notm}} 플러그인을 초기화하거나 Kubernetes 클러스터를 작성하거나 액세스할 지역을 지정합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>(선택사항) 사용하려는 {{site.data.keyword.containershort_notm}} API 엔드포인트입니다. 예:<ul>
    <li>미국 남부:<pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>영국 남쪽:

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>중앙 유럽:
<pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>AP 남부:<pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>


### bx cs machine-types LOCATION
{: #cs_machine_types}

작업자 노드에 사용 가능한 시스템 유형 목록을 봅니다. 각각의 시스템 유형에는
클러스터의 각 작업자 노드에 대한 가상 CPU, 메모리 및 디스크 공간의 양이 포함됩니다. <strong>명령 옵션</strong>:

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>(필수) 사용 가능한 시스템 유형을 나열하려는 위치를 입력하십시오. 사용 가능한 위치는 다음과 같습니다. <ul><li>미국 남부<ul><li>dal10 [댈러스]</li><li>dal12 [댈러스]</li></ul></li><li>영국 남부<ul><li>lon02 [런던]</li><li>lon04 [런던]</li></ul></li><li>중앙 유럽<ul><li>ams03 [암스테르담]</li><li>ra02 [프랑크푸르트]</li></ul></li><li>AP 남부<ul><li>syd01 [시드니]</li><li>syd04 [시드니]</li></ul></li></ul></dd></dl>
   
**예제**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

{{site.data.keyword.BluSoftlayer_notm}} 계정에서 사용할 수 있는 서브넷 목록을 봅니다.

<strong>명령 옵션</strong>:

   None

**예제**:

  ```
   bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

{{site.data.keyword.BluSoftlayer_notm}} 계정의 위치에 사용할 수 있는 퍼블릭 및 프라이빗 VLAN을 나열하십시오. 사용 가능한 VLAN을 나열하려면 유료 계정이 있어야 합니다. <strong>명령 옵션</strong>:

   <dl>
   <dt>LOCATION</dt>
   <dd>(필수) 프라이빗 및 퍼블릭 VLAN을 나열하려는 위치를 입력하십시오. 사용 가능한 위치는 다음과 같습니다. <ul><li>미국 남부<ul><li>dal10 [댈러스]</li><li>dal12 [댈러스]</li></ul></li><li>영국 남부<ul><li>lon02 [런던]</li><li>lon04 [런던]</li></ul></li><li>중앙 유럽<ul><li>ams03 [암스테르담]</li><li>ra02 [프랑크푸르트]</li></ul></li><li>AP 남부<ul><li>syd01 [시드니]</li><li>syd04 [시드니]</li></ul></li></ul></dd>
   </dl>
   
**예제**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

웹훅을 작성합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>(선택사항) 알림 레벨(예: <code>Normal</code> 또는 <code>Warning</code>)입니다. 기본값은 <code>Warning</code>입니다. </dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>(필수) 웹훅 유형(예: slack)입니다. slack만 지원됩니다. </dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>(필수) 웹훅의 URL입니다. </dd>
   </dl>

**예제**:

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION] [--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

표준 클러스터에 작업자 노드를 추가합니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

    <dt><code>--file <em>FILE_LOCATION</em></dt>
    <dd>클러스터에 작업자 노드를 추가하기 위한 YAML 파일의 경로입니다. 이 명령에 제공된 옵션을 사용하여 추가 작업자 노드를 정의하지 않고 YAML 파일을 사용할 수 있습니다.

<p><strong>참고:</strong> 명령에서 YAML 파일의 매개변수와 동일한 옵션을 제공하면 명령의 값이 YAML의 값보다 우선합니다. 예를 들어, YAML 파일에 시스템 유형을 정의하고 명령에서 --machine-type 옵션을 사용하십시오. 명령 옵션에 입력한 값이 YAML 파일의 값을 대체합니다.

      <pre class="codeblock"><code>
      name: <em>&lt;cluster_name_or_id&gt;</em>
    location: <em>&lt;location&gt;</em>
    machine-type: <em>&lt;machine_type&gt;</em>
    private-vlan: <em>&lt;private_vlan&gt;</em>
    public-vlan: <em>&lt;public_vlan&gt;</em>
    hardware: <em>&lt;shared_or_dedicated&gt;</em>
    workerNum: <em>&lt;number_workers&gt;</em></code></pre>
        
        <table>
        <caption>표 2. YAML 파일 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>name</em></code></td>
        <td><code><em>&lt;cluster_name_or_id&gt;</em></code>를 작업자 노드를 추가할 클러스터의 이름 또는 ID로 대체합니다.</td> 
        </tr>
        <tr>
        <td><code><em>location</em></code></td>
        <td><code><em>&lt;location&gt;</em></code>을 작업자 노드를 배치할 위치로 대체합니다. 사용 가능한 위치는 사용자가 로그인한 지역에 따라 다릅니다. 사용 가능한 위치를 나열하려면 <code>bx cs locations</code>를 실행하십시오. </td> 
        </tr>
        <tr>
        <td><code><em>machine-type</em></code></td>
        <td><code><em>&lt;machine_type&gt;</em></code>을 작업자 노드에 사용하려는 시스템 유형으로 대체합니다. 사용자의 위치에서 사용 가능한 시스템 유형을 나열하려면 <code>bx cs machine-types <em>&lt;location&gt;</em></code>을 실행하십시오. </td> 
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
        <td>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스가 사용 가능하도록 하려면 dedicated를 사용하고, 실제 리소스가 다른 IBM 고객과 공유되도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다.</td> 
        </tr>
        <tr>
        <td><code>workerNum</code></td>
        <td><code><em>&lt;number_workers&gt;</em></code>를 배치할 작업자 노드 수로 대체합니다.</td> 
        </tr>
        </tbody></table></p></dd>

    <dt><code>--hardware <em>HARDWARE</em></dt>
    <dd>(선택사항) 작업자 노드의 하드웨어 격리 레벨입니다. 사용자 전용으로만 실제 리소스가 사용 가능하도록 하려면 dedicated를 사용하고, 실제 리소스가 다른 IBM 고객과 공유되도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다.</dd>

    <dt><code>--machine-type <em>MACHINE_TYPE</em></dt>
    <dd>(필수) 선택하는 시스템 유형은
작업자 노드에 배치된 컨테이너가 사용할 수 있는 메모리와 디스크 공간의 양에 영향을 줍니다. 사용 가능한 시스템 유형을 나열하려면 [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types)를 참조하십시오.</dd>

    <dt><code>--number <em>NUMBER</em></dt>
    <dd>(필수) 클러스터에서 작성할 작업자 노드의 수를 표시하는 정수입니다. </dd>

    <dt><code>--private-vlan <em>PRIVATE_VLAN</em></dt>
    <dd>(필수) 위치에서 사용할 수 있는 프라이빗 VLAN이 있는 경우 VLAN을 지정해야 합니다. 이 위치에서
작성하는 첫 번째 클러스터가 이 클러스터인 경우 이 플래그를 사용하지 마십시오. 프라이빗 VLAN이 작성됩니다. <p><strong>참고:</strong> create 명령으로 지정하는 퍼블릭 및 프라이빗 VLAN은 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상
<code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이
일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오. </p></dd>

    <dt><code>--public-vlan <em>PUBLIC_VLAN</em></dt>
    <dd>(필수) 위치에서 사용할 수 있는 퍼블릭 VLAN이 있는 경우 VLAN을 지정해야 합니다. 이 위치에서
작성하는 첫 번째 클러스터가 이 클러스터인 경우 이 플래그를 사용하지 마십시오. 퍼블릭 VLAN이 작성됩니다. <p><strong>참고:</strong> create 명령으로 지정하는 퍼블릭 및 프라이빗 VLAN은 일치해야 합니다. 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상
<code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이
일치해야 합니다. 클러스터를 작성하기 위해 일치하지 않는 퍼블릭 및 프라이빗 VLAN을 사용하지 마십시오. </p></dd>
        </dl>

**예제**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_notm}} 데디케이티드의 예제:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

작업자 노드의 세부사항을 봅니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>작업자 노드의 ID입니다. 클러스터로 작업자 노드를 위한 ID를 보려면 <code>bx cs workers <em>CLUSTER</em></code>를 실행하십시오. </dd>
   </dl>

**예제**:

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f] [--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

클러스터의 작업자 노드를 다시 부팅합니다. 작업자 노드에 문제점이 있으면
우선 작업자 노드의 재부팅을 시도하십시오. 작업자 노드가 다시 시작됩니다. 다시 부팅해도 문제가 해결되지 않으면 `worker-reload` 명령을 시도하십시오. 작업자의
상태(state)는 재부팅 중에 변경되지 않습니다.
상태가 `배치됨`을 유지하지만 상태가 업데이트됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>-f</code></dt>
   <dd>(선택사항) 사용자 프롬프트를 표시하지 않고 작업자 노드의 다시 시작을 강제 실행하려면 이 옵션을 사용하십시오. </dd>

   <dt><code>--hard</code></dt>
   <dd>(선택사항) 작업자 노드의 전원을 끊어서 작업자 노드의 하드 다시 시작을 강제 실행하려면 이 옵션을 사용하십시오. 작업자 노드의 반응이 늦거나 작업자 노드에 Docker
정지가 된 경우 이 옵션을 사용하십시오. </dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(필수) 하나 이상의 작업자 노드의 이름 또는 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. </dd>
   </dl>

**예제**:

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

클러스터의 작업자 노드를 다시 로드합니다. 작업자 노드에 문제점이 있으면 우선 작업자 노드의 재부팅을 시도하십시오. 다시 부팅해도 문제가 해결되지 않으면 `worker-reload` 명령을 시도하십시오. 그러면 작업자 노드의 모든 필수 구성이 다시 로드됩니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>-f</code></dt>
   <dd>(선택사항) 사용자 프롬프트를 표시하지 않고 작업자 노드의 다시 로드를 강제 실행하려면 이 옵션을 사용하십시오. </dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(필수) 하나 이상의 작업자 노드의 이름 또는 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. </dd>
   </dl>

**예제**:

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

클러스터에서 하나 이상의 작업자 노드를 제거하십시오.

<strong>명령 옵션</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(필수) 클러스터의 이름 또는 ID입니다. </dd>

   <dt><code>-f</code></dt>
   <dd>(선택사항) 사용자 프롬프트를 표시하지 않고 작업자 노드의 제거를 강제 실행하려면 이 옵션을 사용하십시오. </dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(필수) 하나 이상의 작업자 노드의 이름 또는 ID입니다. 여러 작업자 노드를 나열하려면 공백을 사용하십시오. </dd>
   </dl>

**예제**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

클러스터에 있는 작업자 노드 목록과 각각의 상태를 봅니다.

<strong>명령 옵션</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>(필수) 사용 가능한 작업자 노드를 나열하는 클러스터의 이름 또는 ID입니다. </dd>
   </dl>

**예제**:

  ```
  bx cs workers mycluster
  ```
  {: pre}

## Cluster states
{: #cs_cluster_states}

bx cs clusters 명령을 실행하고 **State** 필드를 찾아 현재 클러스터 상태를 볼 수 있습니다. 클러스터 상태를 통해 클러스터의 가용성과 용량에 대한 정보 및 발생할 수 있는 잠재적 문제점에 대한 정보를 제공합니다.
{:shortdesc}

|클러스터 상태|이유|
|-------------|------|
|배치 중|Kubernetes 마스터가 아직 완전히 배치되지 않았습니다. 클러스터에 액세스할 수 없습니다.|
|보류|Kubernetes 마스터가 배치됩니다. 작업자 노드를 프로비저닝 중이므로 아직 클러스터에서 사용할 수 없습니다. 클러스터에 액세스할 수 있지만 클러스터에 앱을 배치할 수 없습니다.|
|정상|클러스터의 모든 작업자 노드가 시작되어 실행 중입니다. 클러스터에 액세스하고 클러스터에 앱을 배치할 수 있습니다.|
|경고|클러스터에 있는 하나 이상의 작업자 노드를 사용할 수 없지만, 다른 작업자 노드가 사용 가능하며 워크로드를 인계받을 수 있습니다.<ol><li>클러스터의 작업자 노드를 나열하고 <strong>경고</strong> 상태를 표시하는 작업자 노드의 ID를 기록해 두십시오.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>작업자 노드의 세부사항을 가져옵니다.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li><strong>상태</strong>, <strong>상태</strong> 및 <strong>세부사항</strong> 필드를 검토하여 작업자 노드가 작동 중단된 이유의 근본적인 문제점을 찾으십시오. </li><li>작업자 노드가 메모리 또는 디스크 공간 한계에 거의 도달하면 작업자 노드의 작업 로드를 줄이거나 클러스터에 작업자 노드를 추가하여 작업 로드의 로드 밸런스를 맞출 수 있습니다.</li></ol>|
|중요|Kubernetes 마스터에 도달할 수 없거나 클러스터의 모든 작업자 노드가 작동 중지되었습니다.<ol><li>클러스터의 작업자 노드를 나열합니다.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>각 작업자 노드의 세부사항을 가져옵니다.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li><strong>상태</strong>, <strong>상태</strong> 및 <strong>세부사항</strong> 필드를 검토하여 작업자 노드가 작동 중단된 이유의 근본적인 문제점을 찾으십시오. </li><li>작업자 노드 상태가 <strong>프로비저닝_실패</strong>로 표시되면 {{site.data.keyword.BluSoftlayer_notm}} 포트폴리오에서 작업자 노드를 프로비저닝하는 데 필요한 권한이 없을 수 있습니다. 필수 권한을 찾으려면 [표준 Kubernetes 클러스터를 작성하기 위해 {{site.data.keyword.BluSoftlayer_notm}} 포트폴리오에 대한 액세스 구성](cs_planning.html#cs_planning_unify_accounts)을 참조하십시오.</li><li>작업자 노드 상태에 <strong>중요</strong>가 표시되고 작업자 노드 상태에 <strong>디스크 부족</strong>이 표시되면 작업자 노드의 용량이 부족합니다. 작업자 노드의 작업 로드를 줄이거나 클러스터에 작업자 노드를 추가하여 작업 로드의 로드 밸런스를 맞출 수 있습니다.</li><li>작업자 노드 상태에 <strong>중요</strong>가 표시되고 작업자 노드 상태에 <strong>알 수 없음</strong>이 표시되면 Kubernetes 마스터를 사용할 수 없습니다. [{{site.data.keyword.Bluemix_notm}} 지원 티켓]을 열어 {{site.data.keyword.Bluemix_notm}} 지원에 문의하십시오(/docs/support/index.html#contacting-support).</li></ol>|
{: caption="표 3. 클러스터 상태" caption-side="top"}
