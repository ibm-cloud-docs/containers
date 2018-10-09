---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# 클러스터 네트워킹 문제점 해결
{: #cs_troubleshoot_network}

{{site.data.keyword.containerlong}}를 사용할 때 클러스터 네트워킹 관련 문제점을 해결하려면 이러한 기술을 고려하십시오.
{: shortdesc}

Ingress를 통해 앱에 연결하는 데 문제가 있습니까? [Ingress 디버깅](cs_troubleshoot_debug_ingress.html)을 시도하십시오.
{: tip}

## 로드 밸런서 서비스를 통해 앱에 연결하는 데 실패
{: #cs_loadbalancer_fails}

{: tsSymptoms}
클러스터에서 로드 밸런서 서비스를 작성하여 공용으로 앱을 노출했습니다. 로드 밸런서의 공인 IP 주소를 사용하여 앱에 연결하려고 할 때 연결에 실패했거나 제한시간이 초과되었습니다.

{: tsCauses}
다음과 이유 중 하나로 인해 로드 밸런서 서비스가 제대로 작동하지 않을 수 있습니다.

-   클러스터는 작업자 노드가 하나뿐인 표준 클러스터 또는 무료 클러스터입니다.
-   클러스터가 아직 완전히 배치되지 않았습니다.
-   로드 밸런서 서비스의 구성 스크립트에 오류가 포함되어 있습니다.

{: tsResolve}
로드 밸런서 서비스의 문제점을 해결하려면 다음을 수행하십시오.

1.  로드 밸런서 서비스의 고가용성을 보장할 수 있도록 2개 이상의 작업자 노드가 있으며 완전히 배치된 표준 클러스터를 설정했는지 확인하십시오. 

  ```
  ibmcloud ks workers <cluster_name_or_ID>
  ```
  {: pre}

    CLI 출력에서 작업자 노드의 **상태**에 **준비**가 표시되고 **머신 유형**에 **무료** 이외의 머신 유형이 표시되는지 확인하십시오.

2.  로드 밸런서 서비스의 구성 파일이 정확한지 확인하십시오.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myservice
    spec:
      type: LoadBalancer
      selector:
        <selector_key>:<selector_value>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: pre}

    1.  **LoadBalancer**를 서비스 유형으로 정의했는지 확인하십시오.
    2.  LoadBalancer 서비스의 `spec.selector` 섹션에서 `<selector_key>` 및 `<selector_value>`가 배치 yaml의 `spec.template.metadata.labels` 섹션에서 사용한 키/값 쌍과 동일한지 확인하십시오. 레이블이 일치하지 않으면 LoadBalancer 서비스의 **Endpoints** 섹션에 **`<none>`**이 표시되며 인터넷을 통해 앱에 액세스할 수 없습니다.
    3.  앱에서 청취하는 **port**를 사용했는지 확인하십시오.

3.  로드 밸런서 서비스를 확인하고 **Events** 섹션을 검토하여 잠재적 오류를 찾으십시오.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    다음 오류 메시지를 찾으십시오.

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>로드 밸런서 서비스를 사용하려면 두 개 이상의 작업자 노드가 있는 표준 클러스터가 있어야 합니다.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>이 오류 메시지는 로드 밸런서 서비스에 할당할 포터블 공인 IP 주소가 남아 있지 않음을 나타냅니다. 클러스터의 포터블 공인 IP 주소를 요청하는 방법에 대한 정보는 <a href="cs_subnets.html#subnets">클러스터에 서브넷 추가</a>를 참조하십시오. 포터블 공인 IP 주소를 클러스터에 사용할 수 있게 되면 로드 밸런서 서비스가 자동으로 작성됩니다.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>**loadBalancerIP** 섹션을 사용하여 로드 밸런서 서비스의 포터블 공인 IP 주소를 정의했지만, 이 포터블 공인 IP 주소는 포터블 공용 서브넷에서 사용할 수 없습니다. 구성 스크립트의 **loadBalancerIP** 섹션에서 기존 IP 주소를 제거하고 사용 가능한 포터블 공인 IP 주소 중 하나를 추가하십시오. 사용 가능한 포터블 공인 IP 주소를 자동으로 할당할 수 있도록 스크립트에서 **loadBalancerIP** 섹션을 제거할 수도 있습니다.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>로드 밸런서 서비스를 배치하는 데 충분한 작업자 노드가 없습니다. 그 이유 중 하나는 작업자 노드가 두 개 이상인 표준 클러스터를 배치했지만 작업자 노드의 프로비저닝에 실패했기 때문일 수 있습니다.</li>
    <ol><li>사용 가능한 작업자 노드를 나열하십시오.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>두 개 이상의 사용 가능한 작업자 노드를 발견하면 작업자 노드 세부사항을 나열하십시오.</br><pre class="codeblock"><code>ibmcloud ks worker-get [&lt;cluster_name_or_ID&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li><code>kubectl get nodes</code> 및 <code>ibmcloud ks [&lt;cluster_name_or_ID&gt;] worker-get</code> 명령에서 리턴된 작업자 노드의 공인 및 사설 VLAN ID가 일치하는지 확인하십시오.</li></ol></li></ul>

4.  사용자 정의 도메인을 사용하여 로드 밸런서 서비스에 연결하는 경우 사용자 정의 도메인이 로드 밸런서 서비스의 공인 IP 주소에 맵핑되었는지 확인하십시오.
    1.  로드 밸런서 서비스의 공인 IP 주소를 찾으십시오.

        ```
        kubectl describe service <service_name> | grep "LoadBalancer Ingress"
        ```
        {: pre}

    2.  사용자 정의 도메인이 포인터 레코드(PTR)에 있는 로드 밸런서 서비스의 포터블 공인 IP 주소에 맵핑되었는지 확인하십시오.

<br />


## Ingress를 통해 앱에 연결하는 데 실패
{: #cs_ingress_fails}

{: tsSymptoms}
클러스터에 앱의 Ingress 리소스를 작성하여 공용으로 앱을 노출했습니다. Ingress 애플리케이션 로드 밸런서(ALB)의 하위 도메인 또는 공인 IP 주소를 사용하여 앱에 연결하려고 할 때 연결에 실패했거나 제한시간이 초과되었습니다.

{: tsResolve}
ALB의 고가용성을 보장할 수 있도록 우선 클러스터가 완전히 배치되어 있으며 구역마다 2개 이상의 작업자 노드가 사용 가능한지 확인하십시오. 
    ```
      ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

CLI 출력에서 작업자 노드의 **상태**에 **준비**가 표시되고 **머신 유형**에 **무료** 이외의 머신 유형이 표시되는지 확인하십시오.

* 표준 클러스터가 완전히 배치되어 있으며 구역마다 2개 이상의 작업자 노드가 있지만 **Ingress 하위 도메인**을 사용할 수 없는 경우에는 [Ingress ALB의 하위 도메인을 가져올 수 없음](cs_troubleshoot_network.html#cs_subnet_limit)을 참조하십시오. 
* 기타 문제의 경우에는 [Ingress 디버깅](cs_troubleshoot_debug_ingress.html)의 단계에 따라 Ingress 설정의 문제점을 해결하십시오. 

<br />


## Ingress 애플리케이션 로드 밸런서 시크릿 문제
{: #cs_albsecret_fails}

{: tsSymptoms}
Ingress 애플리케이션 로드 밸런서(ALB) 시크릿을 클러스터에 배치한 후 {{site.data.keyword.cloudcerts_full_notm}}에서 인증서를 볼 때 `Description` 필드가 시크릿 이름으로 업데이트되지 않습니다.

ALB 시크릿에 대한 정보를 나열할 때 상태가 `*_failed`로 표시됩니다. 예: `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
ALB 시크릿이 실패할 수 있는 다음과 같은 이유와 해당 문제점 해결 단계를 검토하십시오.

<table>
<caption>Ingress 애플리케이션 로드 밸런서 시크릿 문제점 해결</caption>
 <thead>
 <th>발생 원인</th>
 <th>해결 방법</th>
 </thead>
 <tbody>
 <tr>
 <td>인증서 데이터 다운로드와 업데이트에 필요한 액세스 역할이 없습니다.</td>
 <td>{{site.data.keyword.cloudcerts_full_notm}} 인스턴스에 대한 **관리자** 및 **작성자** 역할을 모두 지정하도록 계정 관리자에게 요청하십시오. 자세한 정보는 {{site.data.keyword.cloudcerts_short}}에 대한 <a href="/docs/services/certificate-manager/access-management.html#managing-service-access-roles">서비스 액세스 관리</a>를 참조하십시오.</td>
 </tr>
 <tr>
 <td>작성, 업데이트 또는 제거 시 제공한 인증서 CRN이 클러스터와 동일한 계정에 속하지 않습니다.</td>
 <td>제공한 인증서 CRN을 클러스터와 동일한 계정에 배치된 {{site.data.keyword.cloudcerts_short}} 서비스 인스턴스로 가져왔는지 확인하십시오.</td>
 </tr>
 <tr>
 <td>작성 시 제공한 인증서 CRN이 잘못되었습니다.</td>
 <td><ol><li>제공한 인증서 CRN이 정확한지 확인하십시오.</li><li>인증서 CRN이 정확하다고 판단되면 <code>ibmcloud ks alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code>을 실행하여 시크릿을 업데이트해 보십시오.</li><li>이 명령을 실행한 결과로 <code>update_failed</code> 상태가 되면 <code>ibmcloud ks alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code>을 실행하여 시크릿을 제거하십시오.</li><li><code>ibmcloud ks alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code>을 실행하여 시크릿을 다시 배치하십시오.</li></ol></td>
 </tr>
 <tr>
 <td>업데이트 시 제공한 인증서 CRN이 잘못되었습니다.</td>
 <td><ol><li>제공한 인증서 CRN이 정확한지 확인하십시오.</li><li>인증서 CRN이 정확하다고 판단되면 <code>ibmcloud ks alb-cert-rm --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt;</code>을 실행하여 시크릿을 제거하십시오.</li><li><code>ibmcloud ks alb-cert-deploy --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code>을 실행하여 시크릿을 다시 배치하십시오.</li><li><code>ibmcloud ks alb-cert-deploy --update --cluster &lt;cluster_name_or_ID&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code>을 실행하여 시크릿을 업데이트해 보십시오.</li></ol></td>
 </tr>
 <tr>
 <td>{{site.data.keyword.cloudcerts_long_notm}} 서비스에서 가동 중단이 발생합니다.</td>
 <td>{{site.data.keyword.cloudcerts_short}} 서비스가 시작되어 실행 중인지 확인하십시오.</td>
 </tr>
 </tbody></table>

<br />


## Ingress ALB의 하위 도메인을 가져올 수 없음
{: #cs_subnet_limit}

{: tsSymptoms}
`ibmcloud ks cluster-get <cluster>`를 실행하면 클러스터는 `normal` 상태이지만 사용 가능한 **Ingress 하위 도메인**이 없습니다.

다음과 같은 오류 메시지가 표시될 수 있습니다.

```
There are already the maximum number of subnets permitted in this VLAN.
```
{: screen}

{: tsCauses}
표준 클러스터에서 구역의 클러스터를 처음으로 작성하는 경우, 해당 구역의 공용 VLAN 및 사설 VLAN은 IBM Cloud 인프라(SoftLayer) 계정에서 사용자를 위해 자동으로 프로비저닝됩니다. 해당 구역에서는 사용자가 지정하는 공용 VLAN에서 1개의 공용 포터블 서브넷이 요청되며 사용자가 지정하는 사설 VLAN에서 1개의 사설 포터블 서브넷이 요청됩니다. {{site.data.keyword.containerlong_notm}}의 경우 VLAN에는 서브넷이 40개로 제한되어 있습니다. 구역에서 클러스터의 VLAN이 이미 해당 한계에 도달한 경우에는 **Ingress 하위 도메인**이 프로비저닝에 실패합니다.

VLAN의 서브넷 수를 보려면 다음 작업을 수행하십시오.
1.  [IBM Cloud 인프라(SoftLayer) 콘솔](https://control.bluemix.net/)에서 **네트워크** > **IP 관리** > **VLAN**을 선택하십시오.
2.  클러스터를 작성하는 데 사용한 VLAN의 **VLAN 번호**를 클릭하십시오. **서브넷** 섹션을 검토하여 40개 이상의 서브넷이 있는지 확인하십시오.

{: tsResolve}
새 VLAN이 필요하면 [{{site.data.keyword.Bluemix_notm}} 지원에 문의](/docs/infrastructure/vlans/order-vlan.html#order-vlans)하여 VLAN을 주문하십시오. 그런 다음, 이 새 VLAN을 사용하는 [클러스터를 작성](cs_cli_reference.html#cs_cluster_create)하십시오.

사용 가능한 다른 VLAN이 있는 경우에는 기존 클러스터에 [VLAN Spanning을 설정](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)할 수 있습니다. 그 후에는 사용 가능한 서브넷이 있는 다른 VLAN을 사용하는 클러스터에 새 작업자 노드를 추가할 수 있습니다. VLAN Spanning이 이미 사용으로 설정되었는지 확인하려면 `ibmcloud ks vlan-spanning-get` [명령](cs_cli_reference.html#cs_vlan_spanning_get)을 사용하십시오. 

VLAN의 모든 서브넷을 사용 중인 경우가 아니면 클러스터에서 서브넷을 재사용할 수 있습니다.
1.  사용할 서브넷이 사용 가능한지 확인하십시오. **참고**: 사용 중인 인프라 계정이 여러 {{site.data.keyword.Bluemix_notm}} 계정 간에 공유되는 경우가 있습니다. 이 경우에는 `ibmcloud ks subnets` 명령을 실행하여 **바인딩된 클러스터**의 서브넷을 확인해도 사용자가 자체 클러스터에 대한 정보만 볼 수 있습니다. 인프라 계정 소유자에게 확인하여 해당 서브넷이 사용 가능하며 다른 계정 또는 팀에 의해 사용 중이 아닌지 확인하십시오.

2.  서비스가 새 서브넷을 작성하지 않도록 `--no-subnet` 옵션을 사용하여 [클러스터를 작성](cs_cli_reference.html#cs_cluster_create)하십시오. 재사용에 이용할 수 있는 서브넷이 있는 구역 및 VLAN을 지정하십시오.

3.  `ibmcloud ks cluster-subnet-add` [명령](cs_cli_reference.html#cs_cluster_subnet_add)을 사용하여 기존 서브넷을 클러스터에 추가하십시오. 자세한 정보는 [Kubernetes 클러스터에서 사용자 정의 및 기존 서브넷 추가 또는 재사용](cs_subnets.html#custom)을 참조하십시오.

<br />


## Ingress ALB가 구역에 배치되지 않음
{: #cs_multizone_subnet_limit}

{: tsSymptoms}
다중 구역 클러스터가 있으며 `ibmcloud ks albs <cluster>`를 실행하는 경우, ALB가 구역에 배치되지 않습니다. 예를 들어, 3개의 구역에 작업자 노드가 있으면 공용 ALB가 세 번째 구역에 배치되지 않은 다음과 유사한 출력을 볼 수 있습니다.
```
ALB ID                                            Enabled   Status     Type      ALB IP   
private-cr96039a75fddb4ad1a09ced6699c88888-alb1   false     disabled   private   -   
private-cr96039a75fddb4ad1a09ced6699c88888-alb2   false     disabled   private   -   
private-cr96039a75fddb4ad1a09ced6699c88888-alb3   false     disabled   private   -   
public-cr96039a75fddb4ad1a09ced6699c88888-alb1    true      enabled    public    169.xx.xxx.xxx
public-cr96039a75fddb4ad1a09ced6699c88888-alb2    true      enabled    public    169.xx.xxx.xxx
```
{: screen}

{: tsCauses}
각 구역에서는 사용자가 지정하는 공용 VLAN에서 1개의 공용 포터블 서브넷이 요청되며 사용자가 지정하는 사설 VLAN에서 1개의 사설 포터블 서브넷이 요청됩니다. {{site.data.keyword.containerlong_notm}}의 경우 VLAN에는 서브넷이 40개로 제한되어 있습니다. 구역에서 클러스터의 공용 VLAN이 이미 해당 한계에 도달한 경우에는 해당 구역에 대한 공용 Ingress ALB가 프로비저닝에 실패합니다.

{: tsResolve}
VLAN에서 서브넷의 수를 확인하고 다른 VLAN을 가져오는 방법에 대한 단계를 보려면 [Ingress ALB에 대한 하위 도메인을 가져올 수 없음](#cs_subnet_limit)을 참조하십시오.

<br />


## WebSocket을 통한 연결이 60초 후에 닫힘
{: #cs_ingress_websocket}

{: tsSymptoms}
Ingress 서비스는 WebSocket을 사용하는 앱을 노출합니다. 그러나 60초 동안 서로 간에 트래픽이 전송되지 않으면 클라이언트와 WebSocket 앱 간의 연결이 닫힙니다. 

{: tsCauses}
다음 이유 중 하나로 인해 60초 넘게 비활성 상태이면 WebSocket 앱에 대한 연결이 삭제될 수 있습니다. 

* 인터넷 연결에 장기 연결을 허용하지 않는 프록시 또는 방화벽이 있습니다. 
* WebSocket 앱에 대한 ALB의 제한시간 초과로 연결이 종료됩니다. 

{: tsResolve}
60초 넘게 비활성 상태여도 연결이 닫히지 않도록 하려면 다음을 수행하십시오. 

1. 프록시 또는 방화벽을 통해 WebSocket 앱에 연결하는 경우에는 프록시 또는 방화벽이 장기 연결을 자동 종료하도록 구성되지 않았는지 확인하십시오.

2. 연결이 활성 상태를 유지할 수 있도록 제한시간 값을 늘리거나 앱의 하트 비트를 설정할 수 있습니다. 
<dl><dt>제한시간 변경</dt>
<dd>ALB 구성에서 `proxy-read-timeout`의 값을 늘리십시오. 예를 들어, `60s`의 제한시간을 보다 큰 값(예: `300s`)으로 변경하고 다음의 [어노테이션](cs_annotations.html#connection)을 Ingress 리소스 파일에 추가하십시오. `ingress.bluemix.net/proxy-read-timeout: "serviceName=<service_name> timeout=300s"`. 클러스터의 모든 공용 ALB에 대해 제한시간이 변경됩니다. </dd>
<dt>하트비트 설정</dt>
<dd>ALB의 기본 읽기 제한시간 값을 변경하지 않으려면 WebSocket 앱의 하트비트를 설정하십시오. [WAMP ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://wamp-proto.org/) 등의 프레임워크를 사용하여 하트비트 프로토콜을 설정하는 경우, 앱의 업스트림 서버는 주기적으로 "ping" 메시지를 일정 시간 간격마다 전송하고 클라이언트는 "pong" 메시지로 응답합니다. 60초 제한시간이 적용되기 전에 "ping/pong" 트래픽이 열린 연결 상태를 유지할 수 있도록 하트비트 간격을 58초 이하로 설정하십시오. </dd></dl>

<br />


## strongSwan Helm 차트를 사용하여 VPN 연결을 설정할 수 없음
{: #cs_vpn_fails}

{: tsSymptoms}
`kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status`를 실행하여 VPN 연결을 확인하는 경우 `ESTABLISHED`의 상태가 표시되지 않거나 VPN 팟(Pod)이 `ERROR` 상태에 있거나 계속해서 중단된 후 다시 시작됩니다.

{: tsCauses}
Helm 차트 구성 파일에 올바르지 않은 값, 누락된 값 또는 구문 오류가 있습니다.

{: tsResolve}
strongSwan Helm 차트를 사용하여 VPN 연결을 설정하려는 경우 처음에 VPN 상태는 `ESTABLISHED`가 아닐 수 있습니다. 여러 유형의 문제를 확인하고 구성 파일을 적절하게 변경해야 할 수 있습니다. strongSwan VPN 연결의 문제점을 해결하려면 다음을 수행하십시오.

1. 구성 파일의 설정에 대한 온프레미스 VPN 엔드포인트 설정을 확인하십시오. 설정이 일치하지 않는 경우 다음을 수행하십시오.

    <ol>
    <li>기존 Helm 차트를 삭제하십시오.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li><code>config.yaml</code> 파일의 올바르지 않은 값을 수정한 후 업데이트된 파일을 저장하십시오.</li>
    <li>새 Helm 차트를 설치하십시오.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. VPN 팟(Pod)이 `ERROR` 상태이거나 계속 충돌하고 다시 시작되는 경우, 차트 구성 맵에 있는 `ipsec.conf` 설정의 매개변수 유효성 검증 때문일 수 있습니다.

    <ol>
    <li>strongSwan 팟(Pod) 로그에서 유효성 검증 오류를 확인하십시오.</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>로그에 유효성 검증 오류가 포함되어 있는 경우 기존 Helm 차트를 삭제하십시오.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>`config.yaml` 파일의 올바르지 않은 값을 수정한 후 업데이트된 파일을 저장하십시오.</li>
    <li>새 Helm 차트를 설치하십시오.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. strongSwan 차트 정의에 포함된 5회의 Helm 테스트를 실행하십시오.

    <ol>
    <li>Helm 테스트를 실행하십시오.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>테스트에 실패하는 경우 각 테스트에 대한 정보 및 실패 이유를 확인하려면 [Helm VPN 연결 테스트 이해](cs_vpn.html#vpn_tests_table)를 참조하십시오. <b>참고</b>: 일부 테스트에는 VPN 구성에서 선택적 설정인 요구사항이 포함됩니다. 일부 테스트가 실패하는 경우 실패는 선택적 설정의 지정 여부에 따라 허용될 수 있습니다.</li>
    <li>테스트 팟(Pod)의 로그를 확인하여 실패한 테스트의 출력을 보십시오.<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>기존 Helm 차트를 삭제하십시오.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li><code>config.yaml</code> 파일의 올바르지 않은 값을 수정한 후 업데이트된 파일을 저장하십시오.</li>
    <li>새 Helm 차트를 설치하십시오.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>변경사항을 확인하려면 다음을 수행하십시오.<ol><li>현재 테스트 팟(Pod)을 가져오십시오.</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>현재 테스트 팟(Pod)을 정리하십시오.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>테스트를 다시 실행하십시오.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. VPN 팟(Pod) 이미지의 내부에 패키징된 VPN 디버깅 도구를 실행하십시오.

    1. `STRONGSWAN_POD` 환경 변수를 설정하십시오.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. 디버깅 도구를 실행하십시오.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        도구는 공통 네트워킹 문제에 대한 여러 테스트를 실행할 때 정보의 여러 페이지를 출력합니다. `ERROR`, `WARNING`, `VERIFY` 또는 `CHECK`로 시작하는 출력 행에는 VPN 연결에 발생할 수 있는 오류가 표시됩니다.

    <br />


## 새 strongSwan Helm 차트 릴리스를 설치할 수 없음
{: #cs_strongswan_release}

{: tsSymptoms}
사용자가 strongSwan Helm 차트를 수정하고 `helm install -f config.yaml --namespace=kube-system --name=<new_release_name> bluemix/strongswan`을 실행하여 새 릴리스의 설치를 시도합니다. 그러나 다음 오류가 표시됩니다.
```
Error: release <new_release_name> failed: deployments.extensions "vpn-strongswan" already exists
```
{: screen}

{: tsCauses}
이 오류는 strongSwan 차트의 이전 릴리스가 완전히 설치 제거되지 않았음을 표시합니다.

{: tsResolve}

1. 이전 차트 릴리스를 삭제하십시오.
    ```
    helm delete --purge <old_release_name>
    ```
    {: pre}

2. 이전 릴리스에 대한 배치를 삭제하십시오. 배치 및 연관된 팟(Pod)을 삭제하려면 최대 1분이 소요됩니다.
    ```
    kubectl delete deploy -n kube-system vpn-strongswan
    ```
    {: pre}

3. 배치가 삭제되었는지 확인하십시오. `vpn-strongswan` 배치가 목록에 나타나지 않습니다.
    ```
    kubectl get deployments -n kube-system
    ```
    {: pre}

4. 새 릴리스 이름으로 업데이트된 strongSwan Helm 차트를 다시 설치하십시오.
    ```
    helm install -f config.yaml --namespace=kube-system --name=<new_release_name> bluemix/strongswan
    ```
    {: pre}

<br />


## 작업자 노드를 추가 또는 삭제한 후에 strongSwan VPN 연결이 실패함
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
이전에 strongSwan IPSec VPN 서비스를 사용하여 작동하는 VPN 연결을 설정했습니다. 그러나 클러스터의 작업자 노드를 추가하거나 삭제한 후 다음 증상 중 하나가 발생합니다.

* VPN 상태가 `ESTABLISHED`가 아님
* 온프레미스 네트워크에서 새 작업자 노드에 액세스할 수 없음
* 새 작업자 노드에서 실행 중인 팟(Pod)에서 원격 네트워크에 액세스할 수 없음

{: tsCauses}
작업자 풀에 작업자 노드를 추가한 경우:

* 작업자 노드가 기존 `localSubnetNAT` 또는 `local.subnet` 설정으로 VPN 연결에 노출되지 않은 새 사설 서브넷에 프로비저닝됨
* 작업자에게 기존 `tolerations` 또는 `nodeSelector` 설정에 포함되지 않은 오염(taint)이나 레이블이 있기 때문에 VPN 라우트를 작업자 노드에 추가할 수 없음
* VPN 팟(Pod)이 새 작업자 노드에서 실행 중이지만 해당 작업자 노드의 공인 IP 주소는 온프레미스 방화벽을 통해 허용되지 않음

작업자 노드를 삭제한 경우:

* 작업자 노드는 기존 `tolerations` 또는 `nodeSelector` 설정의 특정 오염 또는 레이블에 대한 제한사항으로 인해 VPN 팟(Pod)이 실행되는 유일한 노드임

{: tsResolve}
Helm 차트 값을 업데이트하여 작업자 노드 변경사항을 반영하려면 다음을 수행하십시오.

1. 기존 Helm 차트를 삭제하십시오.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. strongSwan VPN 서비스의 구성 파일을 여십시오.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 필요한 경우 다음 설정을 확인하고 삭제되거나 추가된 작업자 노드를 반영하도록 설정을 변경하십시오.

    작업자 노드를 추가한 경우:

    <table>
    <caption>작업자 노드 설정</caption?
     <thead>
     <th>설정</th>
     <th>설명</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>다른 작업자 노드가 있는 기존의 기타 서브넷과 다른 새 사설 서브넷에 추가된 작업자를 배치할 수 있습니다. 서브넷 NAT를 사용하여 클러스터의 사설 로컬 IP 주소를 다시 맵핑하는 중이고 작업자가 새 서브넷에 추가된 경우 새 서브넷 CIDR을 이 설정에 추가하십시오.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>이전에 VPN 팟(Pod) 배치를 특정 레이블이 있는 작업자로 제한한 경우 추가된 작업자 노드에도 해당 레이블이 있는지 확인하십시오.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>추가된 작업자 노드가 오염된 경우 VPN 팟(Pod)이 임의의 오염 또는 특정 오염이 있는 오염된 모든 작업자 노드에서 실행될 수 있도록 이 설정을 변경하십시오.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>다른 작업자가 있는 기존 서브넷과 다른 새 사설 서브넷에 추가된 작업자를 배치할 수 있습니다. 사설 네트워크의 NodePort 또는 LoadBalancer 서비스에서 앱을 노출하고 앱이 추가된 작업자에 있는 경우 새 서브넷 CIDR을 이 설정에 추가하십시오. **참고**: 값을 `local.subnet`에 추가하는 경우, 값도 업데이트되어야 하는지 확인하려면 온프레미스 서브넷에 대한 VPN 설정을 검사하십시오.</td>
     </tr>
     </tbody></table>

    작업자 노드를 삭제한 경우:

    <table>
    <caption>작업자 노드 설정</caption>
     <thead>
     <th>설정</th>
     <th>설명</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>서브넷 NAT를 사용하여 특정 사설 로컬 IP 주소를 다시 맵핑하는 경우 이 설정에서 이전 작업자의 IP 주소를 제거하십시오. 서브넷 NAT를 사용하여 전체 서브넷을 다시 맵핑하는 중이고 서브넷에 남아 있는 작업자가 없는 경우 이 설정에서 해당 서브넷 CIDR을 제거하십시오.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>이전에 VPN 팟(Pod) 배치를 단일 작업자로 제한했으며 해당 작업자가 삭제된 경우 VPN 팟(Pod)이 다른 작업자에서 실행될 수 있도록 이 설정을 변경하십시오.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>삭제한 작업자가 오염되지 않았지만 남아 있는 작업자 노드만 오염된 경우 VPN 팟(Pod)이 임의의 오염 또는 특정 오염이 있는 작업자에서 실행될 수 있도록 이 설정을 변경하십시오.
     </td>
     </tr>
     </tbody></table>

4. 업데이트된 값을 사용하여 새 Helm 차트를 설치하십시오.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. 차트 배치 상태를 확인하십시오. 차트가 준비 상태인 경우, 출력의 맨 위 근처에 있는 **STATUS** 필드의 값은 `DEPLOYED`입니다.

    ```
    helm status <release_name>
    ```
    {: pre}

6. 일부 경우, VPN 구성 파일에 작성한 변경사항과 일치하도록 온프레미스 설정 및 방화벽 설정을 변경해야 할 수 있습니다.

7. VPN을 시작하십시오.
    * VPN 연결이 클러스터로 시작된 경우(`ipsec.auto`가 `start`로 설정됨) 온프레미스 게이트웨이에서 VPN을 시작한 후 클러스터에서 VPN을 시작하십시오.
    * VPN 연결이 온프레미스 게이트웨이로 시작된 경우(`ipsec.auto`가 `auto`로 설정됨) 클러스터에서 VPN을 시작한 후 온프레미스 게이트웨이에서 VPN을 시작하십시오.

8. `STRONGSWAN_POD` 환경 변수를 설정하십시오.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. VPN의 상태를 확인하십시오.

    ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * VPN 연결이 `ESTABLISHED` 상태인 경우 VPN 연결이 성공했습니다. 추가 조치는 필요하지 않습니다.

    * 계속해서 연결 문제가 발생하는 경우 VPN 연결에 대한 문제점을 좀 더 해결하려면 [strongSwan Helm 차트를 사용하여 VPN 연결을 설정할 수 없음](#cs_vpn_fails)을 참조하십시오.

<br />



## Calico 네트워크 정책을 검색할 수 없음
{: #cs_calico_fails}

{: tsSymptoms}
`calicoctl get policy`를 실행하여 클러스터의 Calico 네트워크 정책을 보려고 할 때 다음과 같은 예상치 못한 결과 또는 오류 메시지 중 하나가 발생합니다.
- 비어 있는 목록
- v3 정책을 대신하는 이전 Calico v2 정책의 목록
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'projectcalico.org/v3'`

`calicoctl get GlobalNetworkPolicy`를 실행하여 클러스터의 Calico 네트워크 정책을 보려고 할 때 다음과 같은 예상치 못한 결과 또는 오류 메시지 중 하나가 발생합니다.
- 비어 있는 목록
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'v1'`
- `Failed to create Calico API client: syntax error in calicoctl.cfg: invalid config file: unknown APIVersion 'projectcalico.org/v3'`
- `Failed to get resources: Resource type 'GlobalNetworkPolicy' is not supported`

{: tsCauses}
Calico 정책을 사용하려면 클러스터 Kubernetes 버전, Calico CLI 버전, Calico 구성 파일 구문 및 정책 보기 명령 등 4개의 요인이 모두 맞아야 합니다. 이러한 요인 중 하나 이상의 버전이 올바르지 않습니다.

{: tsResolve}
클러스터가 [Kubernetes 버전 1.10 이상](cs_versions.html)이면 Calico CLI v3.1, `calicoctl.cfg` v3 구성 파일 구문, `calicoctl get GlobalNetworkPolicy` 및 `calicoctl get NetworkPolicy` 명령을 사용해야 합니다.

클러스터가 [Kubernetes 버전 1.9 이상](cs_versions.html)이면 Calico CLI v1.6.3, `calicoctl.cfg` v2 구성 파일 구문 및 `calicoctl get policy` 명령을 사용해야 합니다.

모든 Calico 요인이 맞는지 확인하려면 다음을 수행하십시오.

1. 클러스터 Kubernetes 버전을 확인하십시오.
    ```
    ibmcloud ks cluster-get <cluster_name>
    ```
    {: pre}

    * 클러스터가 Kubernetes 버전 1.10 이상인 경우 다음을 수행하십시오.
        1. [버전 3.1.1 Calico CLI를 설치 및 구성](cs_network_policy.html#1.10_install)하십시오. 구성에는 Calico v3 구문을 사용하도록 수동으로 `calicoctl.cfg` 파일을 업데이트하는 작업이 포함됩니다.
        2. 작성하고 클러스터에 적용할 정책이 [Calico v3 구문![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy)을 사용하는지 확인하십시오. Calico v2 구문으로 된 기존 정책 `.yaml` 또는 `.json` 파일이 있는 경우 [`calicoctl convert` 명령 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/commands/convert)을 사용하여 Calico v3 구문으로 변환할 수 있습니다.
        3. [정책을 보기](cs_network_policy.html#1.10_examine_policies) 위해 글로벌 정책의 경우 `calicoctl get GlobalNetworkPolicy`를 사용하고 특정 네임스페이스로 범위가 지정된 정책의 경우 `calicoctl get NetworkPolicy --namespace <policy_namespace>`를 사용 중인지 확인하십시오.

    * 클러스터가 Kubernetes 버전 1.9 이하인 경우 다음을 수행하십시오.
        1. [버전 1.6.3 Calico CLI를 설치 및 구성](cs_network_policy.html#1.9_install)하십시오. `calicoctl.cfg` 파일이 Calico v2 구문을 사용하는지 확인하십시오.
        2. 작성하여 클러스터에 적용할 정책이 [Calico v2 구문 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)을 사용하는지 확인하십시오.
        3. [정책을 보기 위해](cs_network_policy.html#1.9_examine_policies) `calicoctl get policy`를 사용 중인지 확인하십시오.

클러스터를 Kubernetes 버전 1.9 이하에서 버전 1.10 이상으로 업데이트하기 전에 [Calico v3으로 업데이트 준비](cs_versions.html#110_calicov3)를 검토하십시오.
{: tip}

<br />


## 올바르지 않은 VLAN ID로 인해 작업자 노드를 추가할 수 없음
{: #suspended}

{: tsSymptoms}
{{site.data.keyword.Bluemix_notm}} 계정이 일시중단되었거나 클러스터의 모든 작업자 노드가 삭제되었습니다. 계정이 다시 활성화된 후에는 작업자 풀의 크기를 조정하거나 리밸런싱할 때 작업자 노드를 추가할 수 없습니다. 다음과 유사한 오류 메시지가 표시될 수 있습니다.

```
SoftLayerAPIError(SoftLayer_Exception_Public): Could not obtain network VLAN with id #123456.
```
{: screen}

{: tsCauses}
계정이 일시중단되면 계정 내의 작업자 노드가 삭제됩니다. 클러스터에 작업자 노드가 없는 경우, IBM Cloud 인프라(SoftLayer)는 연관된 공용 및 사설 VLAN을 재확보합니다. 그러나 클러스터 작업자 풀에는 여전히 메타데이터에 이전 VLAN ID가 있으며 풀을 리밸런싱하거나 크기를 조정할 때 이러한 사용 불가능한 ID를 사용합니다. VLAN이 더 이상 클러스터와 연관되지 않으므로 노드의 작성에 실패합니다.

{: tsResolve}

사용자는 [기존 작업자 풀을 삭제](cs_cli_reference.html#cs_worker_pool_rm)한 후에 [새 작업자 풀을 작성](cs_cli_reference.html#cs_worker_pool_create)할 수 있습니다.

또는 새 VLAN을 주문하고 이를 사용하여 풀에서 새 작업자 노드를 작성하여 기존 작업자 풀을 유지할 수 있습니다.

시작하기 전에 클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

1.  새 VLAN ID가 필요한 구역을 가져오려면 다음 명령 출력의 **위치**를 기록해 두십시오. **참고**: 클러스터가 다중 구역인 경우에는 각 구역마다 VLAN ID가 필요합니다.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

2.  [{{site.data.keyword.Bluemix_notm}} 지원에 문의](/docs/infrastructure/vlans/order-vlan.html#order-vlans)하여 클러스터가 있는 각 구역에 대한 사설 및 공용 VLAN을 가져오십시오.

3.  각 구역에 대한 새 사설 및 공용 VLAN ID를 기록해 두십시오.

4.  작업자 풀의 이름을 기록해 두십시오.

    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

5.  `zone-network-set` [명령](cs_cli_reference.html#cs_zone_network_set)을 사용하여 작업자 풀 네트워크 메타데이터를 변경하십시오.

    ```
    ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> -- worker-pools <worker-pool> --private-vlan <private_vlan_ID> --public-vlan <public_vlan_ID>
    ```
    {: pre}

6.  **다중 구역 클러스터만 해당**: 클러스터의 각 구역에 대해 **5단계**를 반복하십시오.

7.  새 VLAN ID를 사용하는 작업자 노드를 추가할 수 있도록 작업자 풀을 리밸런싱하거나 크기를 조정하십시오. 예를 들어, 다음과 같습니다.

    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <worker_pool> --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

8.  작업자 노드가 작성되었는지 확인하십시오.

    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool>
    ```
    {: pre}

<br />



## 도움 및 지원 받기
{: #ts_getting_help}

클러스터에 여전히 문제점이 있습니까?
{: shortdesc}

-  터미널에서 `ibmcloud` CLI 및 플러그인에 대한 업데이트가 사용 가능한 시점을 사용자에게 알려줍니다. 사용 가능한 모든 명령과 플래그를 사용할 수 있도록 반드시 CLI를 최신 상태로 유지하십시오. 

-   {{site.data.keyword.Bluemix_notm}}가 사용 가능한지 확인하려면 [{{site.data.keyword.Bluemix_notm}} 상태 페이지를 확인 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/bluemix/support/#status)하십시오.
-   [{{site.data.keyword.containerlong_notm}} Slack ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://ibm-container-service.slack.com)에 질문을 게시하십시오.

{{site.data.keyword.Bluemix_notm}} 계정에 대해 IBM ID를 사용 중이 아닌 경우에는 이 Slack에 대한 [초대를 요청](https://bxcs-slack-invite.mybluemix.net/)하십시오.
    {: tip}
-   포럼을 검토하여 다른 사용자에게도 동일한 문제가 발생하는지 여부를 확인하십시오. 포럼을 사용하여 질문을 할 때는 {{site.data.keyword.Bluemix_notm}} 개발 팀이 볼 수 있도록 질문에 태그를 지정하십시오.

    -   {{site.data.keyword.containerlong_notm}}로 클러스터 또는 앱을 개발하거나 배치하는 데 대한 기술적 질문이 있으면 [Stack Overflow![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)에 질문을 게시하고 질문에 `ibm-cloud`, `kubernetes` 및 `containers` 태그를 지정하십시오.
    -   서비스 및 시작하기 지시사항에 대한 질문이 있으면 [IBM Developer Answers ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 포럼을 사용하십시오. `ibm-cloud` 및 `containers` 태그를 포함하십시오.
    포럼 사용에 대한 세부사항은 [도움 받기](/docs/get-support/howtogetsupport.html#using-avatar)를 참조하십시오.

-   티켓을 열어 IBM 지원 센터에 문의하십시오. IBM 지원 티켓 열기 또는 지원 레벨 및 티켓 심각도에 대해 알아보려면 [지원 문의](/docs/get-support/howtogetsupport.html#getting-customer-support)를 참조하십시오.

{: tip}
문제를 보고할 때 클러스터 ID를 포함시키십시오. 클러스터 ID를 가져오려면 `ibmcloud ks clusters`를 실행하십시오.

