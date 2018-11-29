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



# 로드 밸런서를 사용한 앱 노출
{: #loadbalancer}

포트를 노출하고 계층 4 로드 밸런서의 포터블 IP 주소를 사용하여 컨테이너화된 앱에 액세스하십시오.
{:shortdesc}



## 로드 밸런서 컴포넌트 및 아키텍처
{: #planning}

표준 클러스터를 작성하면 {{site.data.keyword.containerlong_notm}}에서 포터블 공용 서브넷과 포터블 사설 서브넷을 자동으로 프로비저닝합니다.

* 포터블 공용 서브넷은 기본 [공용 Ingress ALB](cs_ingress.html)에서 사용하는 1개의 포터블 공인 IP 주소를 제공합니다. 나머지 4개의 포터블 공인 IP 주소는 공용 로드 밸런서 서비스 작성을 통해 단일 앱을 인터넷에 노출하는 데 사용될 수 있습니다.
* 포터블 사설 서브넷은 기본 [사설 Ingress ALB](cs_ingress.html#private_ingress)에서 사용하는 1개의 포터블 사설 IP 주소를 제공합니다. 나머지 4개의 포터블 사설 IP 주소는 사설 로드 밸런서 서비스 작성을 통해 단일 앱을 사설 네트워크에 노출하는 데 사용될 수 있습니다.

      포터블 공인 및 사설 IP 주소는 정적이며 작업자 노드가 제거될 때 변경되지 않습니다. 로드 밸런서 IP 주소가 있는 작업자 노드가 제거되는 경우에는 해당 IP 주소를 지속적으로 모니터하는 Keepalived 디먼이 이 IP 주소를 다른 작업자 노드로 자동으로 이동시킵니다. 사용자는 로드 밸런서에 포트를 지정할 수 있으며 특정 포트 범위에 바인딩되지 않습니다.

로드 밸런서 서비스는 또한 서비스의 NodePort를 통해 앱을 사용할 수 있도록 합니다. [NodePort](cs_nodeport.html)는 클러스터 내의 모든 노드에 대한 모든 공인 및 사설 IP 주소에서 액세스가 가능합니다. 로드 밸런서 서비스를 사용하는 동안 NodePort에 대한 트래픽을 차단하려면 [로드 밸런서 또는 NodePort 서비스에 대한 인바운드 트래픽 제어](cs_network_policy.html#block_ingress)를 참조하십시오. 

로드 밸런서 서비스는 앱의 수신 요청에 대한 외부 시작점 역할을 합니다. 인터넷에서 로드 밸런서 서비스에 액세스하려면 로드 밸런서의 공인 IP 주소와 `<IP_address>:<port>` 형식의 지정된 포트를 사용하십시오. 다음 다이어그램은 로드 밸런서가 인터넷에서 앱으로 통신하는 방식을 표시합니다.

<img src="images/cs_loadbalancer_planning.png" width="550" alt="로드 밸런서를 사용하여 {{site.data.keyword.containerlong_notm}}에서 앱 노출" style="width:550px; border-style: none"/>

1. 앱에 대한 요청은 작업자 노드에서 지정된 포트와 로드 밸런서의 공인 IP 주소를 사용합니다.

2. 요청은 자동으로 로드 밸런서 서비스의 내부 클러스터 IP 주소 및 포트로 전달됩니다. 내부 클러스터 IP 주소는 클러스터 내에서만 액세스가 가능합니다.

3. `kube-proxy`는 앱의 Kubernetes 로드 밸런서 서비스에 대한 요청을 라우팅합니다.

4. 요청은 앱 팟(Pod)의 사설 IP 주소로 전달됩니다. 요청 패키지의 소스 IP 주소는 앱 팟(Pod)이 실행 중인 작업자 노드의 공인 IP 주소로 변경됩니다. 다중 앱 인스턴스가 클러스터에 배치되는 경우 로드 밸런서는 앱 팟(Pod) 간의 요청을 라우팅합니다.

**다중 구역 클러스터**:

다중 구역 클러스터가 있는 경우, 앱 인스턴스는 서로 다른 구역 간에 작업자의 팟(Pod)에 배치됩니다. 다음 다이어그램은 전형적인 로드 밸런서가 인터넷에서 다중 구역 클러스터의 앱으로 통신을 유도하는 방법을 보여줍니다. 

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="로드 밸런서 서비스를 사용하여 다중 구역 클러스터에 있는 앱 간에 로드 밸런싱 수행" style="width:500px; border-style: none"/>

기본적으로 각 로드 밸런서는 하나의 구역에서만 설정됩니다. 고가용성을 달성하려면 앱 인스턴스가 있는 모든 구역에 로드 밸런서를 배치해야 합니다. 요청은 라운드 로빈 주기로 다양한 구역에서 로드 밸런서에 의해 처리됩니다. 또한 각 로드 밸런서는 자체 구역의 앱 인스턴스와 기타 구역의 앱 인스턴스로 요청을 라우팅합니다.

<br />


## 다중 구역 클러스터에서 앱에 대한 공용 또는 개인용 액세스 사용
{: #multi_zone_config}

참고:
  * 이 기능은 표준 클러스터에 대해서만 사용 가능합니다.
  * 로드 밸런서 서비스는 TLS 종료를 지원하지 않습니다. 앱에서 TLS 종료가 필요한 경우 [Ingress](cs_ingress.html)를 사용하여 앱을 노출하거나 TLS 종료를 관리하도록 앱을 구성할 수 있습니다.

시작하기 전에:
  * 포터블 사설 IP 주소를 사용하는 로드 밸런서 서비스에는 여전히 모든 작업자 노드에서 열려 있는 공용 NodePort가 있습니다. 공용 트래픽을 방지하기 위한 네트워크 정책을 추가하려면 [수신 트래픽 차단](cs_network_policy.html#block_ingress)을 참조하십시오.
  * 각 구역에 로드 밸런서를 배치해야 하며, 각 로드 밸런서에는 해당 구역의 자체 IP 주소가 지정됩니다. 공용 로드 밸런서를 작성하려면 하나 이상의 공용 VLAN에 각 구역에서 사용 가능한 포터블 서브넷이 있어야 합니다. 개인용 로드 밸런서 서비스를 작성하려면 하나 이상의 사설 VLAN에 각 구역에서 사용 가능한 포터블 서브넷이 있어야 합니다. 서브넷을 추가하려면 [클러스터에 대한 서브넷 구성](cs_subnets.html)을 참조하십시오.
  * 에지 작업자 노드로 네트워크 트래픽을 제한하는 경우에는 각 구역에서 최소한 2개의 [에지 작업자 노드](cs_edge.html#edge)가 사용으로 설정되었는지 확인하십시오. 에지 작업자 노드가 일부 구역에서는 사용으로 설정되었지만 기타 구역에서는 사용으로 설정되지 않는 경우에는 로드 밸런서가 균등하게 배치되지 않습니다. 로드 밸런서는 일부 구역에서는 에지 노드에 배치되지만 기타 구역에서는 일반 작업자 노드에 배치됩니다.
  * 클러스터용 다중 VLAN, 동일한 VLAN의 다중 서브넷 또는 다중 구역 클러스터가 있는 경우에는 작업자 노드가 사설 네트워크에서 서로 간에 통신할 수 있도록 IBM Cloud 인프라(SoftLayer) 계정에 대해 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)을 사용으로 설정해야 합니다. 이 조치를 수행하려면 **네트워크 > 네트워크 VLAN Spanning 관리** [인프라 권한](cs_users.html#infra_access)이 필요합니다. 또는 이를 사용으로 설정하도록 계정 소유자에게 요청할 수 있습니다. VLAN Spanning이 이미 사용으로 설정되었는지 확인하려면 `ibmcloud ks vlan-spanning-get` [명령](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)을 사용하십시오. {{site.data.keyword.BluDirectLink}}를 사용 중인 경우에는 [VRF(Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)를 대신 사용해야 합니다. VRF를 사용하려면 IBM Cloud 인프라(SoftLayer) 계정 담당자에게 문의하십시오.


다중 구역 클러스터에 로드 밸런서 서비스를 설정하려면 다음 작업을 수행하십시오. 
1.  [클러스터에 앱을 배치](cs_app.html#app_cli)하십시오. 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 팟(Pod)이 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 팟(Pod)을 식별하는 데 필요합니다.

2.  노출시키려는 앱에 대해 로드 밸런서 서비스를 정의하십시오. 공용 인터넷 또는 사설 네트워크에서 앱을 사용할 수 있으려면 앱에 대한 Kubernetes 서비스를 작성하십시오. 앱을 구성하는 모든 팟(Pod)을 로드 밸런싱에 포함하도록 서비스를 구성하십시오.
  1. 예를 들어, `myloadbalancer.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오.
  2. 노출하려는 앱에 대한 로드 밸런서 서비스를 정의하십시오. 구역과 IP 주소를 지정할 수 있습니다. 

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
      ```
      {: codeblock}

      <table>
      <caption>YAML 파일 컴포넌트 이해</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>로드 밸런서의 유형을 지정하기 위한 어노테이션입니다. 허용되는 값은 <code>private</code> 및 <code>public</code>입니다. 공용 VLAN의 클러스터에 공용 로드 밸런서를 작성하는 경우에는 이 어노테이션이 필요하지 않습니다. </td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>로드 밸런서 서비스가 배치되는 구역을 지정하기 위한 어노테이션입니다. 구역을 보려면 <code>ibmcloud ks zones</code>를 실행하십시오.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>앱이 실행되는 팟(Pod)을 대상으로 지정하는 데 사용할 레이블 키(<em>&lt;selector_key&gt;</em>) 및 값(<em>&lt;selector_value&gt;</em>) 쌍을 입력하십시오. 팟(Pod)을 대상으로 지정하여 서비스 로드 밸런싱에 포함시키려면 <em>&lt;selectorkey&gt;</em> 및 <em>&lt;selectorvalue&gt;</em> 값을 확인하십시오. 배치 yaml의 <code>spec.template.metadata.labels</code> 섹션에서 사용한 <em>키/값</em> 쌍과 동일한지 확인하십시오.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>서비스가 청취하는 포트입니다.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>선택사항: 개인용 로드 밸런서를 작성하거나 공용 로드 밸런서의 특정 포터블 IP 주소를 사용하려면 <em>&lt;IP_address&gt;</em>를 사용할 IP 주소로 대체하십시오. 구역을 지정하는 경우에는 해당 IP 주소가 이 VLAN 또는 구역에 속해야 합니다. IP 주소를 지정하지 않는 경우:<ul><li>클러스터가 공용 VLAN에 있는 경우 포터블 공인 IP 주소가 사용됩니다. 대부분의 클러스터는 공용 VLAN에 있습니다.</li><li>클러스터가 사설 VLAN에서만 사용 가능한 경우 포터블 사설 IP 주소가 사용됩니다.</li></td>
      </tr>
      </tbody></table>

      `dal12`의 지정된 IP 주소를 사용하는 전형적인 공용 로드 밸런서 서비스를 작성하기 위한 구성 파일 예:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. 선택사항: **spec** 섹션에 `loadBalancerSourceRanges`를 지정하여 방화벽을 구성하십시오. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)를 참조하십시오.

  4. 클러스터에 서비스를 작성하십시오.

      ```
        kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. 로드 밸런서 서비스가 정상적으로 작성되었는지 확인하십시오. _&lt;myservice&gt;_를 이전 단계에서 작성한 로드 밸런서 서비스의 이름으로 대체하십시오.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **참고:** 로드 밸런서 서비스가 올바르게 작성되고 앱을 사용할 수 있으려면 몇 분 정도 걸릴 수 있습니다.

    CLI 출력 예:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }	  Normal CreatedLoadBalancer	 Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 주소는 로드 밸런서 서비스에 지정된 포터블 IP 주소입니다.

4.  공용 로드 밸런서를 작성한 경우 인터넷에서 앱에 액세스하십시오.
    1.  선호하는 웹 브라우저를 여십시오.
    2.  로드 밸런서 및 포트의 포터블 공인 IP 주소를 입력하십시오.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. [로드 밸런서 서비스에 대해 소스 IP 유지를 사용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)하도록 선택하는 경우에는 [에지 노드 친화성을 앱 팟(Pod)에 추가](cs_loadbalancer.html#edge_nodes)하여 앱 팟(Pod)이 에지 작업자 노드에 스케줄되도록 하십시오. 수신 요청을 받도록 앱 팟(Pod)이 에지 노드에 스케줄되어야 합니다.

6. 다른 구역에서 앱에 대한 수신 요청을 처리하려면 위의 단계를 반복하여 각 구역에 로드 밸런서를 추가하십시오.

7. 선택사항: 로드 밸런서 서비스는 또한 서비스의 NodePort를 통해 앱을 사용할 수 있도록 합니다. [NodePort](cs_nodeport.html)는 클러스터 내의 모든 노드에 대한 모든 공인 및 사설 IP 주소에서 액세스가 가능합니다. 로드 밸런서 서비스를 사용하는 동안 NodePort에 대한 트래픽을 차단하려면 [로드 밸런서 또는 NodePort 서비스에 대한 인바운드 트래픽 제어](cs_network_policy.html#block_ingress)를 참조하십시오. 

## 단일 구역 클러스터에서 앱에 대한 공용 또는 개인용 액세스 사용
{: #config}

시작하기 전에:

-   이 기능은 표준 클러스터에 대해서만 사용 가능합니다.
-   로드 밸런서 서비스에 지정하는 데 사용할 수 있는 포터블 공인 또는 사설 IP 주소를 보유해야 합니다.
-   포터블 사설 IP 주소를 사용하는 로드 밸런서 서비스에는 여전히 모든 작업자 노드에서 열려 있는 공용 NodePort가 있습니다. 공용 트래픽을 방지하기 위한 네트워크 정책을 추가하려면 [수신 트래픽 차단](cs_network_policy.html#block_ingress)을 참조하십시오.

로드 밸런서 서비스를 작성하려면 다음을 수행하십시오.

1.  [클러스터에 앱을 배치](cs_app.html#app_cli)하십시오. 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 팟(Pod)이 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 팟(Pod)을 식별하는 데 필요합니다.
2.  노출시키려는 앱에 대해 로드 밸런서 서비스를 정의하십시오. 공용 인터넷 또는 사설 네트워크에서 앱을 사용할 수 있으려면 앱에 대한 Kubernetes 서비스를 작성하십시오. 앱을 구성하는 모든 팟(Pod)을 로드 밸런싱에 포함하도록 서비스를 구성하십시오.
    1.  예를 들어, `myloadbalancer.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오.

    2.  노출하려는 앱에 대한 로드 밸런서 서비스를 정의하십시오.
        ```
                apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
        ```
        {: codeblock}

        <table>
        <caption>YAML 파일 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>로드 밸런서의 유형을 지정하기 위한 어노테이션입니다. 허용되는 값은 `private` 및 `public`입니다. 공용 VLAN의 클러스터에 공용 로드 밸런서를 작성하는 경우에는 이 어노테이션이 필요하지 않습니다. </td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>앱이 실행되는 팟(Pod)을 대상으로 지정하는 데 사용할 레이블 키(<em>&lt;selector_key&gt;</em>) 및 값(<em>&lt;selector_value&gt;</em>) 쌍을 입력하십시오. 팟(Pod)을 대상으로 지정하여 서비스 로드 밸런싱에 포함시키려면 <em>&lt;selector_key&gt;</em> 및 <em>&lt;selector_value&gt;</em> 값을 확인하십시오. 배치 yaml의 <code>spec.template.metadata.labels</code> 섹션에서 사용한 <em>키/값</em> 쌍과 동일한지 확인하십시오.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>서비스가 청취하는 포트입니다.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>선택사항: 개인용 로드 밸런서를 작성하거나 공용 로드 밸런서의 특정 포터블 IP 주소를 사용하려면 <em>&lt;IP_address&gt;</em>를 사용할 IP 주소로 대체하십시오. IP 주소를 지정하지 않는 경우:<ul><li>클러스터가 공용 VLAN에 있는 경우 포터블 공인 IP 주소가 사용됩니다. 대부분의 클러스터는 공용 VLAN에 있습니다.</li><li>클러스터가 사설 VLAN에서만 사용 가능한 경우 포터블 사설 IP 주소가 사용됩니다.</li></td>
        </tr>
        </tbody></table>

        지정된 IP 주소를 사용하는 전형적인 공용 로드 밸런서 서비스를 작성하기 위한 구성 파일 예:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3.  선택사항: **spec** 섹션에 `loadBalancerSourceRanges`를 지정하여 방화벽을 구성하십시오. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)를 참조하십시오.

    4.  클러스터에 서비스를 작성하십시오.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

                로드 밸런서 서비스가 작성되면 포터블 IP 주소가 자동으로 로드 밸런서에 지정됩니다. 사용 가능한 포터블 IP 주소가 없는 경우에는 로드 밸런서 서비스를 작성할 수 없습니다.

3.  로드 밸런서 서비스가 정상적으로 작성되었는지 확인하십시오.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **참고:** 로드 밸런서 서비스가 올바르게 작성되고 앱을 사용할 수 있으려면 몇 분 정도 걸릴 수 있습니다.

    CLI 출력 예:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }	  Normal CreatedLoadBalancer	 Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 주소는 로드 밸런서 서비스에 지정된 포터블 IP 주소입니다.

4.  공용 로드 밸런서를 작성한 경우 인터넷에서 앱에 액세스하십시오.
    1.  선호하는 웹 브라우저를 여십시오.
    2.  로드 밸런서 및 포트의 포터블 공인 IP 주소를 입력하십시오.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. [로드 밸런서 서비스에 대해 소스 IP 유지를 사용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)하도록 선택하는 경우에는 [에지 노드 친화성을 앱 팟(Pod)에 추가](cs_loadbalancer.html#edge_nodes)하여 앱 팟(Pod)이 에지 작업자 노드에 스케줄되도록 하십시오. 수신 요청을 받도록 앱 팟(Pod)이 에지 노드에 스케줄되어야 합니다.

6. 선택사항: 로드 밸런서 서비스는 또한 서비스의 NodePort를 통해 앱을 사용할 수 있도록 합니다. [NodePort](cs_nodeport.html)는 클러스터 내의 모든 노드에 대한 모든 공인 및 사설 IP 주소에서 액세스가 가능합니다. 로드 밸런서 서비스를 사용하는 동안 NodePort에 대한 트래픽을 차단하려면 [로드 밸런서 또는 NodePort 서비스에 대한 인바운드 트래픽 제어](cs_network_policy.html#block_ingress)를 참조하십시오. 

<br />


## 앱 팟(Pod)에 소스 IP에 대한 노드 친화성 및 결함 허용 추가
{: #node_affinity_tolerations}

앱에 대한 클라이언트 요청이 클러스터에 전송되는 경우, 요청은 앱을 노출시키는 로드 밸런서 서비스 팟(Pod)으로 라우팅됩니다. 앱 팟(Pod)이 로드 밸런서 서비스 팟(Pod)과 동일한 작업자 노드에 없는 경우 로드 밸런서는 다른 작업자 노드의 앱 팟(Pod)으로 요청을 전달합니다. 패키지의 소스 IP 주소는 앱 팟(Pod)이 실행 중인 작업자 노드의 공인 IP 주소로 변경됩니다.

클라이언트 요청의 원본 소스 IP 주소를 유지하려는 경우 로드 밸런서 서비스에 대해 [소스 IP를 사용하도록 설정 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip)할 수 있습니다. 앱이 개시자의 실제 소스 IP 주소를 볼 수 있도록 TCP 연결은 앱 팟(Pod)으로 계속 진행됩니다. 앱 서버가 보안 및 액세스 제어 정책을 적용해야 하는 경우 등에는 클라이언트의 IP를 유지하는 것이 유용합니다.

소스 IP를 사용할 수 있도록 설정하면 로드 밸런서 서비스 팟(Pod)은 동일한 작업자 노드에 배치된 앱 팟(Pod)에만 요청을 전달해야 합니다. 일반적으로, 로드 밸런서 서비스 팟(Pod)은 앱 팟(Pod)이 배치되는 작업자 노드에도 배치됩니다. 그러나 다음과 같은 일부 상황에서는 로드 밸런서 팟(Pod)과 앱 팟(Pod)이 동일한 작업자 노드에 스케줄되지 않습니다.

* 로드 밸런서 서비스 팟(Pod)만 배치할 수 있도록 오염(taint)된 에지 노드가 있습니다. 이러한 노드에는 앱 팟(Pod)을 배치할 수 없습니다.
* 클러스터가 여러 공용 또는 사설 VLAN에 연결되어 있으며 앱 팟(Pod)이 하나의 VLAN에만 연결된 작업자 노드에 배치될 가능성이 있습니다. 로드 밸런서 서비스 팟(Pod)이 작업자 노드와 다른 VLAN에 연결되어 있어 이러한 작업자 노드에 로드 밸런서 서비스 팟(Pod)을 배치하지 못할 수 있습니다.

로드 밸런서 서비스 팟(Pod) 역시 배치할 수 있는 특정 작업자 노드에 배치하도록 앱을 강제 실행하려면 앱 배치에 친화성 규칙(affinity rule) 및 결함 허용(toleration)을 추가해야 합니다.

### 에지 노드 친화성 규칙 및 결함 허용 추가
{: #edge_nodes}

[작업자 노드의 레이블을 에지 노드로 지정](cs_edge.html#edge_nodes)하고 [에지 노드를 오염(taint)](cs_edge.html#edge_workloads)시키면 로드 밸런서 서비스 팟(Pod)이 해당 에지 노드에만 배치되며 앱 팟(Pod)을 에지 노드에 배치할 수 없습니다. 소스 IP가 로드 밸런서 서비스에 대해 사용으로 설정되면 에지 노드의 로드 밸런서 팟(Pod)이 다른 작업자 노드의 앱 팟(Pod)에 수신 요청을 전달할 수 없습니다.
{:shortdesc}

앱 팟(Pod)이 에지 노드에 배치되도록 강제하려면 앱 배치에 에지 노드 [친화성 규칙 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) 및 [결함 허용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts)을 추가하십시오.

에지 노드 친화성 및 에지 노드 결함 허용을 포함하는 배치 yaml 예는 다음과 같습니다.

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

**affinity** 및 **tolerations** 섹션 모두에서 `dedicated`가 `key`이고 `edge`가 `value`입니다.

### 여러 공용 또는 사설 VLAN에 대한 친화성 규칙 추가
{: #edge_nodes_multiple_vlans}

클러스터가 여러 공용 또는 사설 VLAN에 연결되어 있으면 앱 팟(Pod)이 하나의 VLAN에만 연결된 작업자 노드에 배치될 가능성이 있습니다. 로드 밸런서 IP 주소가 작업자 노드와 다른 VLAN에 연결되어 있는 경우에는 로드 밸런서 서비스 팟(Pod)이 이러한 작업자 노드에 배치되지 않습니다.
{:shortdesc}

소스 IP를 사용할 수 있도록 설정된 경우에는 앱 배치에 친화성 규칙을 추가하여 로드 밸런서의 IP 주소와 동일한 VLAN인 작업자 노드에 앱 팟(Pod)을 스케줄하십시오.

시작하기 전에: [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](cs_cli_install.html#cs_cli_configure). 

1. 로드 밸런서 서비스의 IP 주소를 가져오십시오. **LoadBalancer Ingress** 필드에서 IP 주소를 확인하십시오.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. 로드 밸런서 서비스가 연결된 VLAN ID를 검색하십시오.

    1. 클러스터의 포터블 공용 VLAN을 나열하십시오.
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
        ```
        {: pre}

        출력 예:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. **Subnet VLANs** 아래의 출력에서 이전에 검색한 로드 밸런서 IP 주소와 일치하는 서브넷 CIDR을 찾고 VLAN ID를 기록해 두십시오.

        예를 들어, 로드 밸런서 서비스 IP 주소가 `169.36.5.xxx`인 경우 이전 단계의 출력 예에서 일치하는 서브넷은 `169.36.5.xxx/29`입니다. 해당 서브넷이 연결된 VLAN ID는 `2234945`입니다.

3. 이전 단계에서 기록한 VLAN ID에 대한 앱 배치에 [친화성 규칙을 추가 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature)하십시오.

    예를 들어, 여러 VLAN이 있으나 앱 팟(Pod)이 `2234945` 공용 VLAN의 작업자 노드에만 배치되도록 하려면 다음과 같이 입력하십시오.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    YAML 예에서는 **affinity** 섹션에서 `publicVLAN`이 `key`이며 `"2234945"`가 `value`입니다.

4. 업데이트된 배치 구성 파일을 적용하십시오.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. 지정된 VLAN에 연결된 작업자 노드에 앱 팟(Pod)이 배치되었는지 확인하십시오.

    1. 클러스터 내의 팟(Pod)을 나열하십시오. `<selector>`를 앱에 대해 사용한 레이블로 대체하십시오.
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        출력 예:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 출력에서 앱의 팟(Pod)을 식별하십시오. 해당 팟(Pod)이 있는 작업자 노드의 **NODE** ID를 기록해 두십시오.

        이전 단계의 출력 예에서는 앱 팟(Pod) `cf-py-d7b7d94db-vp8pq`가 작업자 노드 `10.176.48.78`에 있습니다.

    3. 작업자 노드의 세부사항을 나열하십시오.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        출력 예:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. 출력의 **Labels** 섹션에서 공용 또는 사설 VLAN이 이전 단계에서 지정한 VLAN인지 확인하십시오.

