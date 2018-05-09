---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 로드 밸런서 서비스 설정
{: #loadbalancer}

포트를 노출하고 로드 밸런서의 포터블 IP 주소를 사용하여 컨테이너화된 앱에 액세스하십시오.
{:shortdesc}

## LoadBalancer 서비스로 외부 네트워킹 계획
{: #planning}

표준 클러스터를 작성할 때 {{site.data.keyword.containershort_notm}}는 다섯 개의 포터블 공인 IP 주소와 다섯 개의 포터블 사설 IP 주소를 자동으로 요청하며 클러스터 작성 중에 IBM Cloud 인프라(SoftLayer) 계정에 프로비저닝합니다. 포터블 IP 주소 중 2개(하나는 공인, 하나는 사설)는 [Ingress 애플리케이션 로드 밸런서](cs_ingress.html#planning)에 사용됩니다. 네 개의 포터블 공인 IP 주소와 네 개의 포터블 사설 IP 주소는 LoadBalancer 서비스를 작성하여 앱을 노출하는 데 사용될 수 있습니다.

퍼블릭 VLAN의 클러스터에 Kubernetes LoadBalancer 서비스를 작성하는 경우 외부 로드 밸런서가 작성됩니다. LoadBalancer 서비스를 작성할 때 IP 주소의 옵션은 다음과 같습니다.

- 클러스터가 퍼블릭 VLAN에 있는 경우 네 개의 사용 가능한 포터블 공인 IP 주소 중 하나가 사용됩니다.
- 클러스터가 프라이빗 VLAN에만 있는 경우 네 개의 사용 가능한 포터블 사설 IP 주소 중 하나가 사용됩니다.
- 구성 파일에 다음과 같은 어노테이션을 추가하여 LoadBalancer 서비스의 포터블 공인 또는 사설 IP 주소를 요청할 수 있습니다. `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`

LoadBalancer 서비스에 지정된 포터블 공인 IP 주소는 영구적이며 작업자 노드가 제거되거나 다시 작성될 때 변경되지 않습니다. 따라서 LoadBalancer 서비스가 NodePort 서비스보다 고가용성입니다. NodePort 서비스와 다르게 로드 밸런서에 포트를 지정할 수 있으며 특정 포트 범위에 바인드되지 않습니다. LoadBalancer 서비스를 사용하는 경우 작업자 노드의 각 IP 주소에서 노드 포트를 사용할 수도 있습니다. LoadBalancer 서비스를 사용하는 동안 노드 포트에 대한 액세스를 차단하려면 [수신 트래픽 차단](cs_network_policy.html#block_ingress)을 참조하십시오.

LoadBalancer 서비스는 앱의 수신 요청에 대한 외부 시작점 역할을 합니다. 인터넷에서 LoadBalancer 서비스에 액세스하려면, `<ip_address>:<port>` 형식의 지정된 포트와 로드 밸런서의 공인 IP 주소를 사용하십시오. 다음 다이어그램은 로드 밸런서가 인터넷에서 앱으로 통신하는 방식을 표시합니다.

<img src="images/cs_loadbalancer_planning.png" width="550" alt="로드 밸런서를 사용하여 {{site.data.keyword.containershort_notm}}에 앱 노출" style="width:550px; border-style: none"/>

1. 작업자 노드에서 지정된 포트와 로드 밸런서의 공인 IP 주소를 사용하여 앱에 요청을 전송합니다. 

2. 요청은 자동으로 로드 밸런서 서비스의 내부 클러스터 IP 주소 및 포트로 전달됩니다. 내부 클러스터 IP 주소는 클러스터 내에서만 액세스가 가능합니다. 

3. `kube-proxy`는 앱의 Kubernetes 로드 밸런서 서비스에 대한 요청을 라우팅합니다. 

4. 앱이 배치된 포드의 사설 IP 주소로 요청이 전달됩니다. 다중 앱 인스턴스가 클러스터에 배치되는 경우 로드 밸런서는 앱 포드 간의 요청을 라우팅합니다. 




<br />




## 로드 밸런서를 사용하여 앱에 대한 액세스 구성
{: #config}

시작하기 전에:

-   이 기능은 표준 클러스터에 대해서만 사용 가능합니다.
-   로드 밸런서 서비스에 지정하는 데 사용할 수 있는 포터블 공인 또는 사설 IP 주소를 보유해야 합니다.
-   포터블 사설 IP 주소를 사용하는 로드 밸런서 서비스에는 여전히 모든 작업 노드에서 열려 있는 공용 노드 포트가 있습니다. 공용 트래픽을 방지하기 위한 네트워크 정책을 추가하려면 [수신 트래픽 차단](cs_network_policy.html#block_ingress)을 참조하십시오.

로드 밸런서 서비스를 작성하려면 다음을 수행하십시오.

1.  [클러스터에 앱을 배치](cs_app.html#app_cli)하십시오. 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다.
2.  노출시키려는 앱에 대해 로드 밸런서 서비스를 정의하십시오. 공용 인터넷 또는 사설 네트워크에서 앱을 사용할 수 있으려면 앱에 대한 Kubernetes 서비스를 작성하십시오. 앱을 구성하는 모든 포드를 로드 밸런싱에 포함하도록 서비스를 구성하십시오.
    1.  예를 들어, `myloadbalancer.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오.

    2.  노출하려는 앱에 대한 로드 밸런서 서비스를 정의하십시오.
        - 클러스터가 퍼블릭 VLAN에 있는 경우 포터블 공인 IP 주소가 사용됩니다. 대부분의 클러스터는 퍼블릭 VLAN에 있습니다.
        - 클러스터가 프라이빗 VLAN에서만 사용 가능한 경우 포터블 사설 IP 주소가 사용됩니다.
        - 구성 파일에 어노테이션을 추가하여 LoadBalancer 서비스에 대한 포터블 공인 또는 사설 IP 주소를 요청할 수 있습니다.

        기본 IP 주소를 사용하는 LoadBalancer 서비스:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        어노테이션을 사용하여 사설 또는 공인 IP 주소를 지정하는 LoadBalancer 서비스:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>로드 밸런서 서비스 파일 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td><em>&lt;myservice&gt;</em>를 로드 밸런서 서비스의 이름으로 대체하십시오.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>사용자의 앱이 실행되는 포드를 대상으로 지정하기 위해 사용하려는 레이블 키(<em>&lt;selectorkey&gt;</em>) 및 값(<em>&lt;selectorvalue&gt;</em>) 쌍을 입력하십시오. 예를 들어, 다음 선택기 <code>app: code</code>를 사용하는 경우 메타데이터에 이 레이블이 있는 포드는 모두 로드 밸런싱에 포함됩니다. 클러스터에 앱을 배치할 때 사용된 것과 동일한 레이블을 입력하십시오. </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>서비스가 청취하는 포트입니다.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>LoadBalancer의 유형을 지정하기 위한 어노테이션입니다. 값은 `private` 및 `public`입니다. 퍼블릭 VLAN의 클러스터에서 공용 LoadBalancer를 작성하는 경우 이 어노테이션은 필요하지 않습니다.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>사설 로드 밸런서를 작성하거나 공용 로드 밸런서의 특정 포터블 IP 주소를 사용하려면 <em>&lt;loadBalancerIP&gt;</em>를 사용할 IP 주소로 대체하십시오. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)를 참조하십시오.</td>
        </tr>
        </tbody></table>

    3.  선택사항: 스펙 섹션에 `loadBalancerSourceRanges`를 지정하여 방화벽을 구성하십시오. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)를 참조하십시오.

    4.  클러스터에 서비스를 작성하십시오.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

                로드 밸런서 서비스가 작성되면 포터블 IP 주소가 자동으로 로드 밸런서에 지정됩니다. 사용 가능한 포터블 IP 주소가 없는 경우에는 로드 밸런서 서비스를 작성할 수 없습니다.

3.  로드 밸런서 서비스가 정상적으로 작성되었는지 확인하십시오. _&lt;myservice&gt;_를 이전 단계에서 작성된 로드 밸런서 서비스의 이름으로 대체하십시오.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **참고:** 로드 밸런서 서비스가 올바르게 작성되고 앱을 사용할 수 있으려면 몇 분이 걸릴 수 있습니다.

    CLI 출력 예:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
    ---------	--------	-----	----			-------------	--------	------			-------
      10s		10s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
      10s		10s		1	{service-controller }			Normal		CreatedLoadBalancer	 Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 주소는 로드 밸런서 서비스에 지정된 포터블 IP 주소입니다.

4.  공용 로드 밸런서를 작성한 경우 인터넷에서 앱에 액세스하십시오.
    1.  선호하는 웹 브라우저를 여십시오.
    2.  로드 밸런서 및 포트의 포터블 공인 IP 주소를 입력하십시오. 위의 예제에서는 포터블 공인 IP 주소 `192.168.10.38`이 로드 밸런서 서비스에 지정되었습니다.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}
