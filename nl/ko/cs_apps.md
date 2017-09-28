---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터에 앱 배치
{: #cs_apps}

Kubernetes 기술을 사용하여 앱을 배치하고 앱이 시작되어 실행 중인지 항상 확인할 수 있습니다. 예를 들어, 사용자를 위해 작동 중단 시간 없이 롤링 업데이트 및 롤백을 수행할 수 있습니다.
{:shortdesc}

앱 배치에는 일반적으로 다음 단계가 포함됩니다. 

1.  [CLI를 설치하십시오](cs_cli_install.html#cs_cli_install).

2.  앱에 대한 구성 스크립트를 작성하십시오. [Kubernetes의 우수 사례를 검토하십시오. ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  다음 방법 중 하나를 사용하여 구성 스크립트를 실행하십시오. 
    -   [Kubernetes CLI](#cs_apps_cli)
    -   Kubernetes 대시보드
        1.  [Kubernetes 대시보드를 시작하십시오.](#cs_cli_dashboard)
        2.  [구성 스크립트를 실행하십시오.](#cs_apps_ui)


## Kubernetes 대시보드 실행
{: #cs_cli_dashboard}

로컬 시스템의 Kubernetes 대시보드를 열어서 클러스터 및 해당 작업자 노드에 대한 정보를 봅니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 이 태스크에는 [관리자 액세스 정책](cs_cluster.html#access_ov)이 필요합니다. 현재 [액세스 정책](cs_cluster.html#view_access)을 확인하십시오. 

기본 포트를 사용하거나 자체 포트를 설정하여 클러스터에 대한 Kubernetes 대시보드를 실행할 수 있습니다. 
-   기본 포트 8001로 Kubernetes 대시보드를 실행하십시오. 
    1.  기본 포트 번호로 프록시를 설정하십시오. 

        ```
        kubectl proxy
        ```
        {: pre}

        CLI 출력은 다음과 같이 표시됩니다. 

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  웹 브라우저에서 다음 URL을 열어 Kubernetes 대시보드를 확인하십시오. 

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   자체 포트로 Kubernetes 대시보드를 실행하십시오. 
    1.  자체 포트 번호로 프록시를 설정하십시오. 

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  브라우저에서 다음 URL을 여십시오. 

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


Kubernetes 대시보드에서 작업이 완료되면 `CTRL+C`를 사용하여 `proxy` 명령을 종료하십시오. 

## 앱에 대한 공용 액세스 허용
{: #cs_apps_public}

공용으로 앱을 사용할 수 있으려면, 클러스터에 앱을 배치하기 전에 구성 스크립트를 업데이트해야 합니다.
{:shortdesc}

라이트 또는 표준 클러스터를 작성했는지 여부에 따라 인터넷에서 앱에 다양한 방법으로 액세스할 수 있습니다. 

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort 유형의 서비스</a>(라이트 및 표준 클러스터)</dt>
<dd>모든 작업자 노드에서 공용 포트를 노출시키고, 임의의 작업자 노드의 공인 IP 주소를 사용하여 클러스터의 서비스에 공용으로 액세스합니다. 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드가 제거되거나 다시 작성되면 새 공인 IP 주소가 작업자 노드에 지정됩니다. 앱에 대한 공용 액세스를 테스트하는 용도로 또는 짧은 시간 동안에만 공용 액세스가 필요한 경우에는 NodePort 유형의 서비스를 사용할 수 있습니다. 서비스 엔드포인트에 대한 추가 가용성과 안정적인 공인 IP 주소가 필요한 경우에는 LoadBalancer 또는 Ingress 유형의 서비스를 사용하여 앱을 노출시키십시오. </dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer 유형의 서비스</a>(표준 클러스터 전용)</dt>
<dd>모든 표준 클러스터는 앱에 대한 외부 TCP/UDP 로드 밸런서 작성에 사용할 수 있는 네 개의 포터블 공인 IP 주소로 프로비저닝됩니다. 앱이 요구하는 포트를 노출함으로써 로드 밸런서를 사용자 정의할 수 있습니다. 로드 밸런서에 지정된 포터블 공인 IP 주소는 영구적이며 클러스터에서 작업자 노드가 다시 작성될 때 변경되지 않습니다.

</br>
앱에 대해 HTTP 또는 HTTPS 로드 밸런싱이 필요하며 하나의 공용 라우트를 사용하여 클러스터의 다중 앱을 서비스로서 노출시키려는 경우에는 {{site.data.keyword.containershort_notm}}의 기본 제공 Ingress 지원을 사용하십시오. </dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a>(표준 클러스터 전용)</dt>
<dd>안전하고 고유한 공용 시작점을 사용하여 수신 요청을 앱으로 라우팅하는 한 개의 외부 HTTP 또는 HTTPS 로드 밸런서를 작성하여 클러스터의 다중 앱을 노출시킵니다. Ingress는 두 개의 기본 컴포넌트(Ingress 리소스와 Ingress 제어기)로 구성되어 있습니다. Ingress 리소스는 앱에 대한 수신 요청을 라우팅하고 로드 밸런싱하는 방법에 대한 규칙을 정의합니다. 모든 Ingress 리소스는 수신 HTTP 또는 HTTPS 서비스 요청을 청취하고 각 Ingress 리소스에 정의된 규칙을 기반으로 요청을 전달하는 Ingress 제어기와 함께 등록되어야 합니다. 사용자 정의 라우팅 규칙으로 사용자 고유의 로드 밸런서를 구현하려는 경우와 앱에 대한 SSL 종료가 필요한 경우 Ingress를 사용하십시오.

</dd></dl>

### NodePort 서비스 유형을 사용하여 앱에 대한 공용 액세스 구성
{: #cs_apps_public_nodeport}

클러스터의 작업자 노드의 공인 IP 주소를 사용하고 노드 포트를 노출시켜 앱이 공용으로 사용되도록 합니다. 테스트 및 단기적 공용 액세스 용도로만 이 옵션을 사용하십시오.
{:shortdesc}

라이트 또는 표준 클러스터에 대해 NodePort 유형의 Kubernetes 서비스로서 앱을 노출할 수 있습니다. 

{{site.data.keyword.Bluemix_notm}} 데디케이티드 환경의 경우 방화벽에서 공인 IP 주소를 차단합니다. 앱을 공개적으로 사용 가능하게 하려면 [LoadBalancer 유형의 서비스](#cs_apps_public_load_balancer) 또는 [Ingress](#cs_apps_public_ingress)를 대신 사용하십시오.

**참고:** 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드를 다시 작성해야 하는 경우에는 새 공인 IP 주소가 작업자 노드에 지정됩니다. 서비스에 대한 추가 가용성과 안정적 공인 IP 주소가 필요한 경우에는 [LoadBalancer 유형의 서비스](#cs_apps_public_load_balancer) 또는 [Ingress](#cs_apps_public_ingress)를 사용하여 앱을 노출시키십시오. 




1.  구성 스크립트에 [서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/) 섹션을 정의하십시오.
2.  서비스의 `spec` 섹션에서 NodePort 유형을 추가하십시오.

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  선택사항: `ports` 섹션에서 30000 - 32767 범위의 NodePort를 추가하십시오. 다른 서비스에서 이미 사용 중인 NodePort는 지정하지 마십시오. 이미 사용 중인 NodePort를 잘 모르는 경우에는 따로 지정하지 마십시오. NodePort가 지정되지 않으면 사용자를 위해 임의로 지정됩니다. 

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    NodePort를 지정하며 이미 사용 중인 NodePort를 보려는 경우에는 다음 명령을 실행할 수 있습니다. 

    ```
    kubectl get svc
    ```
    {: pre}

    출력:

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  변경사항을 저장하십시오. 
5.  모든 앱에 대해 서비스 작성을 반복하십시오. 

    예:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**다음 단계:**

앱이 배치된 경우에는 작업자 노드의 공인 IP 주소와 NodePort를 사용하여 브라우저에서 앱에 액세스하기 위한 공용 URL을 구성할 수 있습니다. 

1.  클러스터의 작업자 노드에 대한 공인 IP 주소를 가져오십시오. 

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    출력:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
    ```
    {: screen}

2.  랜덤 NodePort가 지정된 경우에는 지정된 NodePort를 찾으십시오. 

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    출력:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    이 예에서 NodePort는 `30872`입니다. 

3.  NodePort 및 작업자 노드 공인 IP 주소 중 하나로 URL을 구성하십시오. 예: `http://192.0.2.23:30872`

### 로드 밸런서 서비스 유형을 사용하여 앱에 대한 공용 액세스 구성
{: #cs_apps_public_load_balancer}

포트를 노출시키고 로드 밸런서의 포터블 공인 IP 주소를 사용하여 앱에 액세스합니다. NodePort 서비스와는 달리, 로드 밸런서 서비스의 포터블 공인 IP 주소는 앱이 배치된 작업자 노드에 의존하지 않습니다. 로드 밸런서의 포터블 공인 IP 주소는 사용자에 대해 지정되며 사용자가 작업자 노드를 추가하거나 제거해도 변경되지 않습니다. 이는 로드 밸런서 서비스가 NodePort 서비스보다 고가용성임을 의미합니다. 사용자는 로드 밸런서에 대한 임의의 포트를 선택할 수 있으며, 이는 NodePort 포트 범위로 제한되지 않습니다. 사용자는 TCP 및 UDP 프로토콜에 대한 로드 밸런서 서비스를 사용할 수 있습니다. 

{{site.data.keyword.Bluemix_notm}} 데디케이티드 계정이 [클러스터에 사용](cs_ov.html#setup_dedicated)되면 로드 밸런서 IP 주소에 사용할 공용 서브넷을 요청할 수 있습니다. [지원 티켓을 열어](/docs/support/index.html#contacting-support) 서브넷을 작성한 다음 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 명령을 사용하여 클러스터에 서브넷을 추가하십시오. 

**참고:** 로드 밸런서 서비스는 TLS 종료를 지원하지 않습니다. 앱에서 TLS 종료가 필요한 경우, 사용자는 [Ingress](#cs_apps_public_ingress)를 통해 앱을 노출시키거나 TLS 종료를 관리하도록 앱을 구성할 수 있습니다. 

시작하기 전에:

-   이 기능은 표준 클러스터에 대해서만 사용 가능합니다.
-   사용자는 로드 밸런서 서비스에 지정하는 데 사용할 수 있는 포터블 공인 IP 주소를 보유해야 합니다. 

로드 밸런서 서비스를 작성하려면 다음을 수행하십시오. 

1.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 스크립트의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 
2.  노출시키려는 앱에 대해 로드 밸런서 서비스를 정의하십시오. 공용 인터넷에서 앱을 사용할 수 있으려면 앱에 대한 Kubernetes 서비스를 작성하고 로드 밸런싱에 앱을 구성하는 모든 포드를 포함하도록 서비스를 구성해야 합니다. 
    1.  선호하는 편집기를 열고 서비스 구성 스크립트(예: `myloadbalancer.yaml`)를 작성하십시오. 
    2.  공용으로 노출시키려는 앱에 대해 로드 밸런서 서비스를 정의하십시오. 

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

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em>를 로드 밸런서 서비스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>사용자의 앱이 실행되는 포드를 대상으로 지정하기 위해 사용하려는 레이블 키(<em>&lt;selectorkey&gt;</em>) 및 값(<em>&lt;selectorvalue&gt;</em>) 쌍을 입력하십시오. 예를 들어, 다음 선택기 <code>app: code</code>를 사용하는 경우 메타데이터에 이 레이블이 있는 포드는 모두 로드 밸런싱에 포함됩니다. 클러스터에 앱을 배치할 때 사용된 것과 동일한 레이블을 입력하십시오. </td>
         </tr>
         <td><code>port</code></td>
         <td>서비스가 청취하는 포트입니다. </td>
         </tbody></table>
    3.  선택사항: 클러스터가 사용할 수 있는 로드 밸런서에 대해 특정 포터블 공인 IP 주소를 사용하려는 경우에는 스펙 섹션에 `loadBalancerIP`를 포함하여 해당 IP 주소를 지정할 수 있습니다. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/)을 참조하십시오.
    4.  선택사항: 스펙 섹션에 `loadBalancerSourceRanges`를 지정하여 방화벽을 구성하도록 선택할 수 있습니다. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)을 참조하십시오.
    5.  변경사항을 저장하십시오. 
    6.  클러스터에 서비스를 작성하십시오. 

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        로드 밸런서 서비스가 작성되면 포터블 공인 IP 주소가 자동으로 로드 밸런서에 지정됩니다. 사용 가능한 포터블 공인 IP 주소가 없는 경우에는 로드 밸런서 서비스를 작성할 수 없습니다.
3.  로드 밸런서 서비스가 정상적으로 작성되었는지 확인하십시오. _&lt;myservice&gt;_를 이전 단계에서 작성된 로드 밸런서 서비스의 이름으로 대체하십시오. 

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **참고:** 로드 밸런서 서비스가 올바르게 작성되고 공용 인터넷에서 앱을 사용할 수 있으려면 수 분이 소요될 수 있습니다. 

    CLI 출력이 다음과 유사하게 나타납니다. 

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

**LoadBalancer Ingress** IP 주소는 로드 밸런서 서비스에 지정된 포터블 공인 IP 주소입니다.
4.  인터넷에서 앱에 액세스하십시오. 
    1.  선호하는 웹 브라우저를 여십시오. 
    2.  로드 밸런서 및 포트의 포터블 공인 IP 주소를 입력하십시오. 위의 예제에서는 포터블 공인 IP 주소 `192.168.10.38`이 로드 밸런서 서비스에 지정되었습니다. 

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### Ingress 제어기를 사용하여 앱에 대한 공용 액세스 구성
{: #cs_apps_public_ingress}

IBM 제공 Ingress 제어기가 관리하는 Ingress 리소스를 작성하여 클러스터에서 다중 앱을 노출합니다. Ingress 제어기는 안전하고 고유한 공용 시작점을 사용하여 수신 요청을 클러스터 내부 또는 외부의 앱으로 라우팅하는 중요한 외부 HTTP 또는 HTTPS 로드 밸런서입니다. 

**참고:** Ingress는 표준 클러스터에만 사용 가능하며, 고가용성을 보장할 수 있도록 클러스터에 최소한 두 개의 작업자 노드가 있어야 합니다. 

표준 클러스터를 작성하면 Ingress 제어기가 사용자에 대해 자동으로 작성되며 포터블 공인 IP 주소 및 공용 라우트가 지정됩니다. Ingress 제어기를 구성하고 공용으로 노출시키는 모든 앱에 대해 개별 라우팅 규칙을 정의할 수 있습니다. Ingress를 통해 노출된 모든 앱에는 고유 URL을 사용하여 클러스터에서 앱에 공용으로 액세스할 수 있도록 공용 라우트에 추가된 고유 경로가
지정됩니다. 

{{site.data.keyword.Bluemix_notm}} 데디케이티드 계정이 [클러스터에 사용](cs_ov.html#setup_dedicated)되면 Ingress 제어기 IP 주소에 사용할 공용 서브넷을 요청할 수 있습니다. 그러면 Ingress 제어기가 작성되며 공용 라우트가 지정됩니다. [지원 티켓을 열어](/docs/support/index.html#contacting-support) 서브넷을 작성한 다음 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 명령을 사용하여 클러스터에 서브넷을 추가하십시오. 

다음 시나리오에 맞게 Ingress 제어기를 구성할 수 있습니다. 

-   [TLS 종료 없이 IBM 제공 도메인 사용](#ibm_domain)
-   [TLS 종료와 함께 IBM 제공 도메인 사용](#ibm_domain_cert)
-   [TLS 종료를 수행하기 위해 사용자 정의 도메인 및 TLS 인증서 사용](#custom_domain_cert)
-   [클러스터 외부의 앱에 액세스하기 위해 TLS 종료와 함께 IBM 제공 또는 사용자 정의 도메인 사용](#external_endpoint)
-   [어노테이션으로 Ingress 제어기 사용자 정의](#ingress_annotation)

#### TLS 종료 없이 IBM 제공 도메인 사용
{: #ibm_domain}

클러스터의 앱에 대한 HTTP 로드 밸런서로서 Ingress 제어기를 구성하고 인터넷에서 앱에 액세스하기 위해 IBM 제공 도메인을 사용할 수 있습니다. 

시작하기 전에:

-   클러스터가 아직 없으면 [표준 클러스터를 작성](cs_cluster.html#cs_cluster_ui)하십시오. 
-   클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하고 `kubectl` 명령을 실행하십시오.

Ingress 제어기를 구성하려면 다음을 수행하십시오. 

1.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 스크립트의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 
2.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들면 `myservice.yaml`로 이름 지정된 서비스 구성 스크립트를 작성하십시오. 
    2.  공용으로 노출시키려는 앱에 대해 서비스를 정의하십시오. 

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em>를 로드 밸런서 서비스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>사용자의 앱이 실행되는 포드를 대상으로 지정하기 위해 사용하려는 레이블 키(<em>&lt;selectorkey&gt;</em>) 및 값(<em>&lt;selectorvalue&gt;</em>) 쌍을 입력하십시오. 예를 들어, 다음 선택기 <code>app: code</code>를 사용하는 경우 메타데이터에 이 레이블이 있는 포드는 모두 로드 밸런싱에 포함됩니다. 클러스터에 앱을 배치할 때 사용된 것과 동일한 레이블을 입력하십시오. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>서비스가 청취하는 포트입니다. </td>
         </tr>
         </tbody></table>
    3.  변경사항을 저장하십시오. 
    4.  클러스터에 서비스를 작성하십시오. 

        ```
         kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  공용으로 노출시키려는 모든 앱에 대해 이러한 단계를 반복하십시오. 
3.  IBM 제공 도메인을 보려면 사용자의 클러스터에 대한 세부사항을 가져오십시오. _&lt;mycluster&gt;_를 공용으로 노출시키려는 앱이 배치된 클러스터의 이름으로 대체하십시오. 

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 출력이 다음과 유사하게 나타납니다. 

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    **Ingress 하위 도메인** 필드에서 IBM 제공 도메인을 볼 수 있습니다.
4.  Ingress 리소스를 작성하십시오. Ingress 리소스는 앱용으로 작성된 Kubernetes 서비스에 대한 라우팅 규칙을 정의하며, 수신 네트워크 트래픽을 서비스로 라우팅하기 위해 Ingress 제어기에 의해 사용됩니다. 클러스터 내에서 Kubernetes 서비스를 통해 모든 앱이 노출되는 한, 하나의 Ingress 리소스를 사용하여 다중 앱에 대한 라우팅 규칙을 정의할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들면 `myingress.yaml`로 이름 지정된 Ingress 구성 스크립트를 작성하십시오. 
    2.  IBM 제공 도메인을 사용하여 수신 네트워크 트래픽을 이전에 작성된 서비스로 라우팅하는 구성 스크립트에서 Ingress 리소스를 정의하십시오. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em>을 Ingress 리소스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td><em>&lt;ibmdomain&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 하위 도메인</strong> 이름으로 대체하십시오. 

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 *를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>네트워크 트래픽이 앱으로 전달될 수 있도록 <em>&lt;myservicepath1&gt;</em>을 슬래시 또는 앱이 청취 중인 고유 경로로 대체하십시오. 

        </br>
        모든 Kubernetes 서비스의 경우, IBM 제공 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 대한 고유 경로(예: <code>ingress_domain/myservicepath1</code>)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾은 후에 네트워크 트래픽을 해당 서비스에, 그리고 동일한 경로를 사용하여 앱이 실행 중인 포드에 전송합니다. 수신 네트워크 트래픽을 수신하려면 이 경로에서 청취하도록 앱을 설정해야 합니다. 

        </br></br>
        많은 앱은 특정 경로에서 청취하지는 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 <code>/</code>로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오.
        </br>
        예: <ul><li><code>http://ingress_host_name/</code>의 경우 <code>/</code>를 경로로 입력하십시오. </li><li><code>http://ingress_host_name/myservicepath</code>의 경우 <code>/myservicepath</code>를 경로로 입력하십시오.</li></ul>
        </br>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 <a href="#rewrite" target="_blank">재작성 어노테이션</a>을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em>을 앱에 대한 Kubernetes 서비스를 작성했을 때 사용한 서비스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>서비스가 청취하는 포트입니다. 앱에 대한 Kubernetes 서비스를 작성했을 때 정의한 동일한 포트를 사용하십시오. </td>
        </tr>
        </tbody></table>

    3.  클러스터에 대한 Ingress 리소스를 작성하십시오. 

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Ingress 리소스가 작성되었는지 확인하십시오. _&lt;myingressname&gt;_을 이전에 작성한 Ingress 리소스의 이름으로 대체하십시오. 

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **참고:** Ingress 리소스가 작성되고 공용 인터넷에서 앱을 사용할 수 있으려면 수 분이 소요될 수 있습니다. 
6.  웹 브라우저에서 액세스할 앱 서비스의 URL을 입력하십시오.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### TLS 종료와 함께 IBM 제공 도메인 사용
{: #ibm_domain_cert}

앱에 대한 수신 TLS 연결을 관리하도록 Ingress 제어기를 구성하며, IBM 제공 TLS 인증서를 사용하여 네트워크 트래픽을 복호화하고, 클러스터에 노출된 앱으로 암호화되지 않은 요청을 전달할 수 있습니다. 

시작하기 전에:

-   클러스터가 아직 없으면 [표준 클러스터를 작성](cs_cluster.html#cs_cluster_ui)하십시오. 
-   클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하고 `kubectl` 명령을 실행하십시오.

Ingress 제어기를 구성하려면 다음을 수행하십시오. 

1.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 구성 스크립트의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함되도록록 앱이 실행 중인 모든 포드를 식별합니다. 
2.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들면 `myservice.yaml`로 이름 지정된 서비스 구성 스크립트를 작성하십시오. 
    2.  공용으로 노출시키려는 앱에 대해 서비스를 정의하십시오. 

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em> 서비스의 이름으로 대체합니다.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>사용자의 앱이 실행되는 포드를 대상으로 지정하기 위해 사용하려는 레이블 키(<em>&lt;selectorkey&gt;</em>) 및 값(<em>&lt;selectorvalue&gt;</em>) 쌍을 입력하십시오. 예를 들어, 다음 선택기 <code>app: code</code>를 사용하는 경우 메타데이터에 이 레이블이 있는 포드는 모두 로드 밸런싱에 포함됩니다. 클러스터에 앱을 배치할 때 사용된 것과 동일한 레이블을 입력하십시오. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>서비스가 청취하는 포트입니다. </td>
         </tr>
         </tbody></table>

    3.  변경사항을 저장하십시오. 
    4.  클러스터에 서비스를 작성하십시오. 

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  공용으로 노출시키려는 모든 앱에 대해 이러한 단계를 반복하십시오. 

3.  IBM 제공 도메인과 TLS 인증서를 보십시오. _&lt;mycluster&gt;_를 앱이 배치되는 클러스터의 이름으로 대체하십시오. 

    ```
     bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 출력이 다음과 유사하게 나타납니다. 

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    **Ingress 하위 도메인**에서 IBM 제공 도메인을 볼 수 있으며, **Ingress 시크릿** 필드에서 IBM 제공 인증서를 볼 수 있습니다. 

4.  Ingress 리소스를 작성하십시오. Ingress 리소스는 앱용으로 작성된 Kubernetes 서비스에 대한 라우팅 규칙을 정의하며, 수신 네트워크 트래픽을 서비스로 라우팅하기 위해 Ingress 제어기에 의해 사용됩니다. 클러스터 내에서 Kubernetes 서비스를 통해 모든 앱이 노출되는 한, 하나의 Ingress 리소스를 사용하여 다중 앱에 대한 라우팅 규칙을 정의할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들면 `myingress.yaml`로 이름 지정된 Ingress 구성 스크립트를 작성하십시오. 
    2.  수신 네트워크 트래픽을 서비스로 라우팅하기 위한 IBM 제공 도메인 및 TLS 종료를 관리하기 위한 IBM 제공 인증서를 사용하는 구성 스크립트에 Ingress 리소스를 정의하십시오. 모든 서비스에 대해 IBM 제공 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://ingress_domain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 앱이 실행 중인 포드에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취해야 합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은 특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 `/`로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em>을 Ingress 리소스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;ibmdomain&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 하위 도메인</strong> 이름으로 대체하십시오. 이 도메인은 TLS 종료를 위해 구성됩니다. 

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;ibmtlssecret&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 시크릿</strong> 이름으로 대체하십시오. 이 인증서는 TLS 종료를 관리합니다.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td><em>&lt;ibmdomain&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 하위 도메인</strong> 이름으로 대체하십시오. 이 도메인은 TLS 종료를 위해 구성됩니다. 

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>네트워크 트래픽이 앱으로 전달될 수 있도록 <em>&lt;myservicepath1&gt;</em>을 슬래시 또는 앱이 청취 중인 고유 경로로 대체하십시오. 

        </br>
        모든 Kubernetes 서비스의 경우, IBM 제공 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 대한 고유 경로(예: <code>ingress_domain/myservicepath1</code>)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾은 후에 네트워크 트래픽을 해당 서비스에, 그리고 동일한 경로를 사용하여 앱이 실행 중인 포드에 전송합니다. 수신 네트워크 트래픽을 수신하려면 이 경로에서 청취하도록 앱을 설정해야 합니다. 

        </br>
         많은 앱은 특정 경로에서 청취하지는 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 <code>/</code>로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        </br>
         예: <ul><li><code>http://ingress_host_name/</code>의 경우 <code>/</code>를 경로로 입력하십시오. </li><li><code>http://ingress_host_name/myservicepath</code>의 경우 <code>/myservicepath</code>를 경로로 입력하십시오.</li></ul>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 <a href="#rewrite" target="_blank">재작성 어노테이션</a>을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em>을 앱에 대한 Kubernetes 서비스를 작성했을 때 사용한 서비스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>서비스가 청취하는 포트입니다. 앱에 대한 Kubernetes 서비스를 작성했을 때 정의한 동일한 포트를 사용하십시오. </td>
        </tr>
        </tbody></table>

    3.  클러스터에 대한 Ingress 리소스를 작성하십시오. 

        ```
         kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Ingress 리소스가 작성되었는지 확인하십시오. _&lt;myingressname&gt;_을 이전에 작성한 Ingress 리소스의 이름으로 대체하십시오. 

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **참고:** Ingress 리소스가 올바르게 작성되고 공용 인터넷에서 앱을 사용할 수 있으려면 수 분이 소요될 수 있습니다.
6.  웹 브라우저에서 액세스할 앱 서비스의 URL을 입력하십시오.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### 사용자 정의 도메인 및 TLS 인증서와 함께 Ingress 제어기 사용
{: #custom_domain_cert}

IBM 제공 도메인이 아니라 사용자 정의 도메인을 사용하는 동안 수신 네트워크 트래픽을 클러스터의 앱으로 라우팅하도록 Ingress 제어기를 구성하고 고유 TLS 인증서를 사용하여 TLS 종료를 관리할 수 있습니다.
{:shortdesc}

시작하기 전에:

-   클러스터가 아직 없으면 [표준 클러스터를 작성](cs_cluster.html#cs_cluster_ui)하십시오. 
-   클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하고 `kubectl` 명령을 실행하십시오.

Ingress 제어기를 구성하려면 다음을 수행하십시오. 

1.  사용자 정의 도메인을 작성하십시오. 사용자 정의 도메인을 작성하려면 도메인 이름 서비스(DNS) 제공업체를 찾아서 사용자 정의 도메인을 등록하십시오. 
2.  수신 네트워크 트래픽을 IBM Ingress 제어기로 라우팅하도록 사용자의 도메인을 구성하십시오. 다음 옵션 중에서 선택하십시오.
    -   표준 이름 레코드(CNAME)로서 IBM 제공 도메인을 지정하여 사용자 정의 도메인의 별명을 정의하십시오. IBM 제공 Ingress 도메인을 찾으려면 `bx cs cluster-get <mycluster>`을 실행하고 **Ingress subdomain** 필드를 찾으십시오.
    -   포인터 레코드(PTR)로서 IP 주소를 추가하여 IBM 제공 Ingress 제어기의 포터블 공인 IP 주소로 사용자 정의 도메인을 맵핑하십시오. Ingress 제어기의 포터블 공인 IP 주소를 찾으려면 다음을 수행하십시오. 
        1.  `bx cs cluster-get <mycluster>`을 실행하고 **Ingress subdomain** 필드를 찾으십시오.
        2.  `nslookup <Ingress subdomain>`을 실행하십시오.
3.  base64 형식으로 인코딩된 사용자의 도메인에 대한 TLS 인증서 및 키를 작성하십시오. 
4.  TLS 인증서 및 키를 Kubernetes 시크릿에 저장하십시오. 
    1.  선호하는 편집기를 열고 예를 들면 `mysecret.yaml`로 이름 지정된 Kubernetes 시크릿 구성 스크립트를 작성하십시오. 
    2.  TLS 인증서 및 키를 사용하는 시크릿을 정의하십시오.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;mytlssecret&gt;</em>을 Kubernetes 시크릿의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td><em>&lt;tlscert&gt;</em>를 base64 형식으로 인코딩된 사용자 정의 TLS 인증서로 대체하십시오. </td>
         </tr>
         <td><code>tls.key</code></td>
         <td><em>&lt;tlskey&gt;</em>를 base64 형식으로 인코딩된 사용자 정의 TLS 키로 대체하십시오. </td>
         </tbody></table>

    3.  구성 스크립트를 저장하십시오. 
    4.  클러스터에 대한 TLS 시크릿을 작성하십시오. 

        ```
         kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 스크립트의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 

6.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다. 

    1.  선호하는 편집기를 열고 예를 들면 `myservice.yaml`로 이름 지정된 서비스 구성 스크립트를 작성하십시오. 
    2.  공용으로 노출시키려는 앱에 대해 서비스를 정의하십시오. 

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice1&gt;</em>을 Kubernetes 서비스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>사용자의 앱이 실행되는 포드를 대상으로 지정하기 위해 사용하려는 레이블 키(<em>&lt;selectorkey&gt;</em>) 및 값(<em>&lt;selectorvalue&gt;</em>) 쌍을 입력하십시오. 예를 들어, 다음 선택기 <code>app: code</code>를 사용하는 경우 메타데이터에 이 레이블이 있는 포드는 모두 로드 밸런싱에 포함됩니다. 클러스터에 앱을 배치할 때 사용된 것과 동일한 레이블을 입력하십시오. </td>
         </tr>
         <td><code>port</code></td>
         <td>서비스가 청취하는 포트입니다. </td>
         </tbody></table>

    3.  변경사항을 저장하십시오. 
    4.  클러스터에 서비스를 작성하십시오. 

        ```
         kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  공용으로 노출시키려는 모든 앱에 대해 이러한 단계를 반복하십시오. 
7.  Ingress 리소스를 작성하십시오. Ingress 리소스는 앱용으로 작성된 Kubernetes 서비스에 대한 라우팅 규칙을 정의하며, 수신 네트워크 트래픽을 서비스로 라우팅하기 위해 Ingress 제어기에 의해 사용됩니다. 클러스터 내에서 Kubernetes 서비스를 통해 모든 앱이 노출되는 한, 하나의 Ingress 리소스를 사용하여 다중 앱에 대한 라우팅 규칙을 정의할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들면 `myingress.yaml`로 이름 지정된 Ingress 구성 스크립트를 작성하십시오. 
    2.  수신 네트워크 트래픽을 서비스로 라우팅하기 위한 사용자 정의 도메인 및 TLS 종료를 관리하기 위한 사용자 정의 인증서를 사용하는 구성 스크립트에 Ingress 리소스를 정의하십시오. 모든 서비스에 대해 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://mydomain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 앱이 실행 중인 포드에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취하는 것이 중요합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은 특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 `/`로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em>을 Ingress 리소스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;mycustomdomain&gt;</em>을 TLS 종료를 위해 구성하려는 사용자 정의 도메인으로 대체합니다.

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;mytlssecret&gt;</em>을 이전에 작성했으며 사용자 정의 도메인을 위한 TLS 종료를 관리하기 위한 사용자 정의 TLS 인증서 및 키를 보유하고 있는 시크릿의 이름으로 대체하십시오. </tr>
        <tr>
        <td><code>host</code></td>
        <td><em>&lt;mycustomdomain&gt;</em>을 TLS 종료를 위해 구성하려는 사용자 정의 도메인으로 대체합니다.

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>네트워크 트래픽이 앱으로 전달될 수 있도록 <em>&lt;myservicepath1&gt;</em>을 슬래시 또는 앱이 청취 중인 고유 경로로 대체하십시오. 

        </br>
        모든 Kubernetes 서비스의 경우, IBM 제공 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 대한 고유 경로(예: <code>ingress_domain/myservicepath1</code>)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾은 후에 네트워크 트래픽을 해당 서비스에, 그리고 동일한 경로를 사용하여 앱이 실행 중인 포드에 전송합니다. 수신 네트워크 트래픽을 수신하려면 이 경로에서 청취하도록 앱을 설정해야 합니다. 

        </br>
        많은 앱은 특정 경로에서 청취하지는 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 <code>/</code>로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        </br></br>
        예:<ul><li><code>https://mycustomdomain/</code>의 경우 <code>/</code>를 경로로 입력하십시오. </li><li><code>https://mycustomdomain/myservicepath</code>의 경우 <code>/myservicepath</code>를 경로로 입력하십시오.</li></ul>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 <a href="#rewrite" target="_blank">재작성 어노테이션</a>을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em>을 앱에 대한 Kubernetes 서비스를 작성했을 때 사용한 서비스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>서비스가 청취하는 포트입니다. 앱에 대한 Kubernetes 서비스를 작성했을 때 정의한 동일한 포트를 사용하십시오. </td>
        </tr>
        </tbody></table>

    3.  변경사항을 저장하십시오. 
    4.  클러스터에 대한 Ingress 리소스를 작성하십시오. 

        ```
         kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Ingress 리소스가 작성되었는지 확인하십시오. _&lt;myingressname&gt;_을 이전에 작성한 Ingress 리소스의 이름으로 대체하십시오. 

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **참고:** Ingress 리소스가 올바르게 작성되고 공용 인터넷에서 앱을 사용할 수 있으려면 수 분이 소요될 수 있습니다. 

9.  인터넷에서 앱에 액세스하십시오. 
    1.  선호하는 웹 브라우저를 여십시오. 
    2.  액세스하려는 앱 서비스의 URL을 입력하십시오. 

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### 클러스터 외부의 앱으로 네트워크 트래픽을 라우팅하도록 Ingress 제어기 구성
{: #external_endpoint}

클러스터 로드 밸런싱에 포함될 클러스터의 외부에 위치하는 앱에 대한 Ingress 제어기를 구성할 수 있습니다. IBM 제공 또는 사용자 정의 도메인의 수신 요청이 외부 앱으로 자동으로 전달됩니다. 

시작하기 전에:

-   클러스터가 아직 없으면 [표준 클러스터를 작성](cs_cluster.html#cs_cluster_ui)하십시오. 
-   클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하고 `kubectl` 명령을 실행하십시오.
-   클러스터 로드 밸런싱에 포함시키고자 하는 외부 앱에 공인 IP 주소를 사용하여 액세스할 수 있는지 확인하십시오. 

IBM 제공 도메인에서 수신 네트워크 트래픽을 클러스터의 외부에 위치한 앱으로 라우팅하기 위해 Ingress 제어기를 구성할 수 있습니다. 사용자 정의 도메인 및 TLS 인증서를 대신 사용하려는 경우, IBM 제공 도메인 및 TLS 인증서를 [사용자 정의 도메인 및 TLS 인증서](#custom_domain_cert)로 대체하십시오. 

1.  클러스터 로드 밸런싱에 포함시키고자 하는 앱의 외부 위치를 정의하는 Kubernetes 엔드포인트를 구성하십시오. 
    1.  선호하는 편집기를 열고 예를 들면 `myexternalendpoint.yaml`로 이름 지정된 엔드포인트 구성 스크립트를 작성하십시오. 
    2.  외부 엔드포인트를 정의하십시오. 외부 앱에 액세스하기 위해 사용할 수 있는 모든 공인 IP 주소 및 포트를 포함하십시오.


        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myendpointname&gt;</em>을 Kubernetes 엔드포인트의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>외부 앱에 연결하기 위해 <em>&lt;externalIP&gt;</em>를 공인 IP 주소로 대체하십시오.</td>
         </tr>
         <td><code>port</code></td>
         <td><em>&lt;externalport&gt;</em>를 사용자의 외부 앱이 청취하는 포트로 대체하십시오. </td>
         </tbody></table>

    3.  변경사항을 저장하십시오. 
    4.  클러스터에 대한 Kubernetes 엔드포인트를 작성하십시오. 

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  클러스터에 대한 Kubernetes 서비스를 작성하고 이전에 작성한 외부 엔드포인트로 수신 요청을 전달하도록 구성하십시오. 
    1.  선호하는 편집기를 열고 예를 들면 `myexternalservice.yaml`로 이름 지정된 서비스 구성 스크립트를 작성하십시오.
    2.  서비스를 정의하십시오.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td><em>&lt;myexternalservice&gt;</em>를 Kubernetes 서비스의 이름으로 대체합니다.</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td><em>&lt;myendpointname&gt;</em>을 이전에 작성한 Kubernetes 엔드포인트의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>서비스가 청취하는 포트입니다. </td>
        </tr></tbody></table>

    3.  변경사항을 저장하십시오. 
    4.  클러스터에 대한 Kubernetes 서비스를 작성하십시오. 

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

3.  IBM 제공 도메인과 TLS 인증서를 보십시오. _&lt;mycluster&gt;_를 앱이 배치되는 클러스터의 이름으로 대체하십시오. 

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 출력이 다음과 유사하게 나타납니다. 

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    **Ingress 하위 도메인**에서 IBM 제공 도메인을 볼 수 있으며, **Ingress 시크릿** 필드에서 IBM 제공 인증서를 볼 수 있습니다. 

4.  Ingress 리소스를 작성하십시오. Ingress 리소스는 앱용으로 작성된 Kubernetes 서비스에 대한 라우팅 규칙을 정의하며, 수신 네트워크 트래픽을 서비스로 라우팅하기 위해 Ingress 제어기에 의해 사용됩니다. 클러스터 내에서 Kubernetes 서비스를 통해 모든 앱이 자체 외부 엔드포인트로 노출되는 한, 하나의 Ingress 리소스를 사용하여 다중 외부 앱에 대한 라우팅 규칙을 정의할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들면 `myexternalingress.yaml`로 이름 지정된 Ingress 구성 스크립트를 작성하십시오. 
    2.  이전에 정의한 외부 엔드포인트를 사용하여 수신 네트워크 트래픽을 사용자의 외부 앱으로 라우팅하기 위한 IBM 제공 도메인 및 TLS 인증서를 사용하는 구성 스크립트에 Ingress 리소스를 정의하십시오. 모든 서비스에 대해 IBM 제공 또는 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://ingress_domain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 외부 앱에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취하는 것이 중요합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은 특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 /로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em>을 Ingress 리소스의 이름으로 대체하십시오.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;ibmdomain&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 하위 도메인</strong> 이름으로 대체하십시오. 이 도메인은 TLS 종료를 위해 구성됩니다. 

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;ibmtlssecret&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 시크릿</strong>으로 대체합니다. 이 인증서는 TLS 종료를 관리합니다. </td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td><em>&lt;ibmdomain&gt;</em>을 이전 단계의 IBM 제공 <strong>Ingress 하위 도메인</strong> 이름으로 대체하십시오. 이 도메인은 TLS 종료를 위해 구성됩니다. 

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>네트워크 트래픽이 앱으로 전달될 수 있도록 <em>&lt;myexternalservicepath&gt;</em>를 슬래시 또는 외부 앱이 청취 중인 고유 경로로 대체하십시오. 

        </br>
        모든 Kubernetes 서비스에 대해 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: <code>https://ibmdomain/myservicepath1</code>)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾고 동일한 경로를 사용하여 네트워크 트래픽을 외부 앱에 전송합니다. 수신 네트워크 트래픽을 수신하려면 이 경로에서 청취하도록 앱을 설정해야 합니다. 

        </br></br>
        많은 앱은 특정 경로에서 청취하지는 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 <code>/</code>로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        </br></br>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 <a href="#rewrite" target="_blank">재작성 어노테이션</a>을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myexternalservice&gt;</em>를 외부 앱에 대한 Kubernetes 서비스를 작성했을 때 사용한 서비스의 이름으로 대체합니다. </td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>서비스가 청취하는 포트입니다. </td>
        </tr>
        </tbody></table>

    3.  변경사항을 저장하십시오. 
    4.  클러스터에 대한 Ingress 리소스를 작성하십시오. 

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  Ingress 리소스가 작성되었는지 확인하십시오. _&lt;myingressname&gt;_을 이전에 작성한 Ingress 리소스의 이름으로 대체하십시오. 

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **참고:** Ingress 리소스가 올바르게 작성되고 공용 인터넷에서 앱을 사용할 수 있으려면 수 분이 소요될 수 있습니다. 

6.  사용자의 외부 앱에 액세스하십시오. 
    1.  선호하는 웹 브라우저를 여십시오. 
    2.  사용자의 외부 앱에 액세스하기 위한 URL을 입력하십시오. 

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}


#### 지원되는 Ingress 어노테이션
{: #ingress_annotation}

Ingress 리소스에 대한 메타데이터를 지정하여 Ingress 제어기에 기능을 추가할 수 있습니다.
{: shortdesc}

|지원되는 어노테이션 |설명       |
|--------------------|-----------|
|[재작성](#rewrite)|백엔드 앱이 청취하는 다른 경로로 수신 네트워크 트래픽을 라우팅하십시오.|
|[쿠키를 사용하는 세션 선호도](#sticky_cookie)|스티키 쿠키(sticky cookie)를 사용하여 동일한 업스트림 서버에 수신 네트워크 트래픽을 항상 라우팅하십시오.|
|[추가 클라이언트 요청 또는 응답 헤더](#add_header)|백엔드 앱에 요청을 전달하기 전에 클라이언트 요청에 추가 헤더 정보를 추가하거나 클라이언트에 응답을 전송하기 전에 클라이언트 응답에 해당 헤더 정보를 추가하십시오.|
|[클라이언트 응답 헤더 제거](#remove_response_headers)|클라이언트에 응답을 전달하기 전에 클라이언트 응답에서 헤더 정보를 제거하십시오.|
|[HTTP의 경로를 HTTPs로 재지정](#redirect_http_to_https)|도메인에서 비보안 HTTP 요청의 경로를 HTTPs로 재지정|
|[클라이언트 응답 데이터 버퍼링](#response_buffer)|클라이언트에 요청을 보내는 동안 Ingress 제어기에서 클라이언트 응답의 버퍼링을 사용하지 않게 설정하십시오.|
|[사용자 정의 연결 제한시간 및 읽기 제한시간](#timeout)|백엔드 앱이 사용 가능하지 않은 것으로 간주되기 전에 백엔드 앱에 연결하여 읽기 위해 Ingress 제어기가 대기하는 시간을 조정하십시오.|
|[사용자 정의 최대 클라이언트 요청 본문 크기](#client_max_body_size)|Ingress 제어기에 전송할 수 있는 클라이언트 요청 본문의 크기를 조정하십시오.|

##### **재작성을 사용하여 다른 경로로 수신 네트워크 트래픽 라우팅**
{: #rewrite}

재작성 어노테이션을 사용하여 Ingress 제어기 도메인 경로의 수신 네트워크 트래픽을 백엔드 애플리케이션이 청취하는 다른 경로로 라우팅하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>Ingress 제어기 도메인은 <code>mykubecluster.us-south.containers.mybluemix.net/beans</code>의 수신 네트워크 트래픽을 사용자 앱에 라우팅합니다. 사용자 앱은 <code>/beans</code> 대신 <code>/coffee</code>를 청취합니다. 수신 네트워크 트래픽을 사용자 앱에 전달하려면 <code>/coffee</code> 경로를 사용하여 <code>/beans</code>의 수신 네트워크 트래픽을 사용자 앱으로 전달할 수 있도록 재작성 어노테이션을 Ingress 리소스 구성 파일에 추가하십시오. 여러 서비스가 포함된 경우에는 세미콜론(;)만 사용하여 이를 분리하십시오. </dd>
<dt>샘플 Ingress 리소스 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;rewrite_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;rewrite_path2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td><em>&lt;service_name&gt;</em>을 앱에 대해 작성된 Kubernetes 서비스의 이름으로
대체하고 <em>&lt;rewrite-path&gt;</em>를 앱이 청취하는 경로로 대체하십시오. 
Ingress 제어기 도메인의 수신 네트워크 트래픽은 이 경로를 사용하여 Kubernetes 서비스에 전달됩니다. 대부분의 앱은
특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 <code>/</code>를 앱의 <em>&lt;rewrite-path&gt;</em>로 정의하십시오. </td>
</tr>
<tr>
<td><code>path</code></td>
<td><em>&lt;domain_path&gt;</em>를 Ingress 제어기 도메인에 추가할 경로로 대체하십시오. 
이 경로의 수신 네트워크 트래픽은 어노테이션에 정의된 재작성 경로로 전달됩니다. 위의 예제에서 도메인 경로를 <code>/beans</code>로 설정하여 Ingress 제어기의 로드 밸런싱에 이 경로를 포함시키십시오.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td><em>&lt;service_name&gt;</em>을 앱에 대해 작성된 Kubernetes 서비스의 이름으로 대체하십시오. 
여기서 사용되는 서비스 이름은 어노테이션에 정의된 이름과 동일해야 합니다. </td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td><em>&lt;service_port&gt;</em>를 서비스가 청취하는 포트로 대체하십시오. </td>
</tr></tbody></table>

</dd></dl>


##### **스티키 쿠키(sticky cookie)를 사용하여 동일한 업스트림 서버에 수신 네트워크 트래픽을 항상 라우팅**
{: #sticky_cookie}

스티키 쿠키 어노테이션을 사용하여 Ingress 제어기에 세션 선호도를 추가하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>앱 설정에 따라 수신 클라이언트 요청을 처리하고 고가용성을 보장하는 여러 업스트림 서버를 배치해야 할 수 있습니다. 클라이언트에서 백엔드 앱에 연결할 때 세션 지속 기간 동안 또는 태스크를 완료할 때까지 소요되는 시간 동안 동일한 업스트림 서버에서 클라이언트에 서비스를 제공하는 것이 유용합니다. 수신 네트워크 트래픽이 항상 동일한 업스트림 서버로 라우팅되게 하여 세션 선호도를 보장하도록 Ingress 제어기를 구성할 수 있습니다.

</br>
백엔드 앱에 연결하는 모든 클라이언트는 Ingress 제어기를 통해 사용 가능한 업스트림 서버 중 하나에 지정됩니다. Ingress 제어기에서 클라이언트 앱에 저장되고 Ingress 제어기와 클라이언트 간 모든 요청의 헤더 정보에 포함되는 세션 쿠키를 작성합니다. 쿠키의 정보를 사용하면 세션 전체에서 동일한 업스트림 서버가 모든 요청을 처리할 수 있습니다.

</br></br>
여러 서비스가 포함된 경우에는 세미콜론(;)을 사용하여 분리하십시오. </dd>
<dt>샘플 Ingress 리소스 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>표 12. YAML 파일 컴포넌트 이해</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>다음 값을 대체하십시오.<ul><li><code><em>&lt;service_name&gt;</em></code>: 앱에 대해 작성된 Kubernetes 서비스의 이름입니다. </li><li><code><em>&lt;cookie_name&gt;</em></code>: 세션 중에 작성되는 스티키 쿠키의 이름을 선택합니다. </li><li><code><em>&lt;expiration_time&gt;</em></code>: 스티키 쿠키가 만기되기 전의 시간(초, 분 또는 시간)입니다. 이 시간은 사용자 활동과 무관합니다. 쿠키가 만료되고 나면 클라이언트 웹 브라우저에서 쿠키가 삭제되어 더 이상 Ingress 제어기에 전송되지 않습니다. 예를 들어, 만기 시간을 1초, 1분 또는 1시간으로 설정하려면 <strong>1s</strong>, <strong>1m</strong> 또는 <strong>1h</strong>를 입력하십시오.</li><li><code><em>&lt;cookie_path&gt;</em></code>: Ingress 하위 도메인에 추가되고 쿠키가 Ingress 제어기에 전송하는 도메인과 하위 도메인을 표시하는 경로입니다. 예를 들어, Ingress 도메인이 <code>www.myingress.com</code>이고 모든 클라이언트 요청에 해당 쿠키를 전송하려는 경우 <code>path=/</code>를 설정해야 합니다. <code>www.myingress.com/myapp</code> 및 해당 하위 도메인 모두에 대해서만 쿠키를 전송하려는 경우 <code>path=/myapp</code>으로 설정해야 합니다.</li><li><code><em>&lt;hash_algorithm&gt;</em></code>: 쿠키의 정보를 보호하는 해시 알고리즘입니다. <code>sha1
</code>만 지원됩니다. SHA1은 쿠키의 정보를 기반으로 해시 합계를 작성하고 이 해시 합계를 쿠키에 추가합니다. 서버에서 쿠키의 정보를 복호화하고 데이터 무결성을 확인할 수 있습니다.</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **클라이언트 요청 또는 클라이언트 응답에 사용자 정의 http 헤더 추가**
{: #add_header}

백엔드 앱에 요청을 전송하기 전에 클라이언트 요청에 추가 헤더 정보를 추가하거나 클라이언트에 응답을 전송하기 전에 클라이언트 응답에 해당 헤더 정보를 추가하려면 이 어노테이션을 사용하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>Ingress 제어기는 클라이언트 앱과 백엔드 앱 사이의 프록시 역할을 합니다. Ingress 제어기에 전송되는 클라이언트 요청을 처리(프록시됨)하여 Ingress 제어기에서 백엔드 앱으로 전송될 새 요청에 둡니다. 요청을 프록시하면 클라이언트에서 처음에 전송된 http 헤더 정보(예: 사용자 이름)가 제거됩니다. 백엔드 앱에 이 정보가 필요하면 Ingress 제어기에서 백엔드 앱에 요청을 전달하기 전에 <strong>ingress.bluemix.net/proxy-add-headers</strong> 어노테이션을 사용하여 클라이언트 요청에 헤더 정보를 추가할 수 있습니다.
</br></br>
백엔드 앱에서 클라이언트에 응답을 전송하면 Ingress 제어기에서 응답을 프록시하고 응답에서 http 헤더가 제거됩니다. 클라이언트 웹 앱에서 응답을 제대로 처리하려면 이 헤더 정보가 필요합니다. Ingress 제어기에서 클라이언트 웹 앱으로 응답을 전달하기 전에 <strong>ingress.bluemix.net/response-add-headers</strong> 어노테이션을 사용하여 헤더 정보를 클라이언트 응답에 추가할 수 있습니다.</dd>
<dt>샘플 Ingress 리소스 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>다음 값을 대체하십시오.<ul><li><code><em>&lt;service_name&gt;</em></code>: 앱에 대해 작성된 Kubernetes 서비스의 이름입니다. </li><li><code><em>&lt;header&gt;</em></code>: 클라이언트 요청 또는 클라이언트 응답에 추가할 헤더 정보의 키입니다.</li><li><code><em>&lt;value&gt;</em></code>: 클라이언트 요청 또는 클라이언트 응답에 추가할 헤더 정보의 값입니다.</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **클라이언트의 응답에서 http 헤더 정보 제거**
{: #remove_response_headers}

응답을 클라이언트에 전송하기 전에 백엔드 앱에서 클라이언트 응답에 포함되는 헤더 정보를 제거하려면 이 어노테이션을 사용하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>Ingress 제어기는 백엔드 앱과 클라이언트 웹 브라우저 간의 프록시로 작동합니다. Ingress 제어기에 전송되는 백엔드 앱의 클라이언트 응답을 처리(프록시됨)하여 Ingress 제어기에서 클라이언트 웹 브라우저로 전송될 새 응답에 둡니다. 응답을 프록시 처리하면 백엔드 앱에서 처음에 전송된 http 헤더 정보가 제거되지만 이 프로세스에서는 모든 백엔드 앱 고유 헤더를 제거하지 않을 수 있습니다. Ingress 제어기에서 클라이언트 웹 브라우저로 응답을 전달하기 전에 클라이언트 응답에서 헤더 정보를 제거하려면 이 어노테이션을 사용하십시오.</dd>
<dt>샘플 Infress 리소스 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;service_name2&gt; {
      "&lt;header3&gt;";
      }
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>다음 값을 대체하십시오.<ul><li><code><em>&lt;service_name&gt;</em></code>: 앱에 대해 작성된 Kubernetes 서비스의 이름입니다. </li><li><code><em>&lt;header&gt;</em></code>: 클라이언트 응답에서 제거할 헤더의 키입니다.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **비보안 http 클라이언트 요청의 경로를 https로 재지정**
{: #redirect_http_to_https}

비보안 http 클라이언트 요청을 https로 변환하려면 경로 재지정 어노테이션을 사용하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>IBM 제공 TLS 인증서 또는 사용자 정의 TLS 인증서로 도메인을 보호하도록 Ingress 제어기를 설정합니다. 일부 사용자는 <code>https</code>를 사용하지 않고 Ingress 제어기 도메인에 대한 비보안 http 요청을 사용하여 앱에 액세스하려고 할 수 있습니다(예: <code>http://www.myingress.com</code>). 경로 재지정 어노테이션을 사용하여 항상 비보안 http 요청을 https로 변환할 수 있습니다. 이 어노테이션을 사용하지 않으면 기본적으로 비보안 http 요청이 https 요청으로 변환되지 않으며, 기밀 정보를 암호화하지 않고 공용으로 노출할 수 있습니다.

</br></br>
http 요청의 경로를 https로 재지정하는 기능은 기본적으로 사용되지 않습니다.</dd>
<dt>샘플 Ingress 리소스 YAML</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **Ingress 제어기에서 백엔드 응답 버퍼링 사용 안함**
{: #response_buffer}

데이터를 클라이언트에 전송하는 동안 Ingress 제어기에서 응답 데이터의 스토리지를 사용하지 않게 설정하려면 버퍼 어노테이션을 사용하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>Ingress 제어기는 백엔드 앱과 클라이언트 웹 브라우저 간의 프록시로 작동합니다. 백엔드 앱에서 클라이언트로 응답을 전송하면 기본적으로 응답 데이터가 Ingress 제어기에 버퍼링됩니다. Ingress 제어기에서 클라이언트 응답을 프록시하고 클라이언트의 속도에 맞춰 클라이언트에 응답을 전송하기 시작합니다. Ingress 제어기가 백엔드 앱에서 모든 데이터를 받고 나면 백엔드 앱에 대한 연결이 종료됩니다. 클라이언트가 모든 데이터를 받을 때까지 Ingress 제어기에서 클라이언트로의 연결은 열린 상태로 남아 있습니다.

</br></br>
Ingress 제어기에서 응답 데이터 버퍼링을 사용하지 않으면 Ingress 제어기에서 클라이언트로 데이터가 즉시 전송됩니다. 클라이언트는 Ingress 제어기의 속도에 따라 수신되는 데이터를 처리할 수 있어야 합니다. 클라이언트가 너무 느리면 데이터가 유실될 수 있습니다.
</br></br>
Ingress 제어기에서 응답 데이터 버퍼링은 기본적으로 사용됩니다.</dd>
<dt>샘플 Ingress 리소스 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **Ingress 제어기의 사용자 정의 연결 제한시간 및 읽기 제한시간 설정**
{: #timeout}

백엔드 앱이 사용 가능하지 않은 것으로 간주되기 전에 백엔드 앱에 연결하여 읽는 동안 Ingress 제어기가 대기하는 시간을 조정하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>Ingress 제어기에 클라이언트 요청을 전송할 때 Ingress 제어기에서 백엔드 앱에 대한 연결을 엽니다. 기본적으로 Ingress 제어기는 백엔드 앱에서 응답을 수신하기 위해 60초를 기다립니다. 백엔드 앱에서 60초 내에 응답하지 않으면 연결 요청이 중단되며 백엔드 앱이 사용 가능하지 않은 것으로 간주됩니다.

</br></br>
Ingress 제어기가 백엔드 앱에 연결되고 나면 Ingress 제어기에서 백엔드 앱의 응답 데이터를 읽습니다. 이 읽기 작업 중에는 Ingress 제어기가 백엔드 앱에서 데이터를 받기 위한 두 읽기 작업 사이에 최대 60초 동안 대기합니다. 백엔드 앱에서 60초 내에 데이터를 보내지 않으면 백엔드 앱에 대한 연결이 닫히며 앱을 사용할 수 없는 것으로 간주합니다.
</br></br>
프록시에서는 60초 연결 제한시간 및 읽기 제한시간이 기본 제한시간이며 변경하지 않는 것이 좋습니다.
</br></br>
앱의 가용성이 안정되지 않거나 높은 워크로드 때문에 앱이 느리게 응답하는 경우 연결 제한시간 또는 읽기 제한시간을 늘릴 수 있습니다. 제한시간에 도달할 때까지 백엔드 앱에 대한 연결이 열린 상태로 있어야 하므로 제한시간을 늘리면 Ingress 제어기의 성능에 영향을 미칠 수 있습니다.
</br></br>
반대로 Ingress 제어기의 성능을 높이기 위해 제한시간을 줄일 수 있습니다. 워크로드가 높은 경우에도 백엔드 앱에서 지정된 제한시간 내에 요청을 처리할 수 있는지 확인하십시오.</dd>
<dt>샘플 Ingress 리소스 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>다음 값을 대체하십시오.<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: 백엔드 앱에 연결하기 위해 대기하는 시간(초)을 입력하십시오(예: <strong>65s</strong>).

  </br></br>
  <strong>참고:</strong> 연결 제한시간은 75초를 초과할 수 없습니다. </li><li><code><em>&lt;read_timeout&gt;</em></code>: 백엔드 앱에서 읽기 위해 대기하는 시간(초)을 입력하십시오(예: <strong>65s</strong>).</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **클라이언트 요청 본문에 허용되는 최대 크기 설정**
{: #client_max_body_size}

클라이언트가 요청의 일부로 전송할 수 있는 본문의 크기를 조정하는 데 이 어노테이션을 사용하십시오.
{:shortdesc}

<dl>
<dt>설명</dt>
<dd>예상 성능을 유지보수하려면 최대 클라이언트 요청 본문 크기를 1MB로 설정하십시오. 본문 크기가 한계를 초과하는 클라이언트 요청을 Ingress 제어기에 전송하고 클라이언트에서 데이터를 여러 청크로 분할하지 못하게 하면 Ingress 제어기에서 413(요청 엔티티가 너무 큼) http 응답을 클라이언트에 리턴합니다. 요청 본문 크기에 도달할 때까지 클라이언트와 Ingress 제어기 간에는 연결할 수 없습니다. 클라이언트에서 데이터를 여러 청크로 분할하게 허용하면 데이터를 1MB의 패키지로 나누어 Ingress 제어기에 전송합니다.

</br></br>
본문 크기가 1MB보다 큰 클라이언트 요청을 예상하므로 최대 본문 크기를 늘릴 수 있습니다. 예를 들어, 클라이언트에서 큰 파일을 업로드할 수 있게 합니다. 요청을 받을 때까지 클라이언트에 대한 연결이 열린 상태를 유지해야 하므로 최대 요청 본문 크기를 늘리면 Ingress 제어기의 성능에 영향을 미칠 수 있습니다.
</br></br>
<strong>참고:</strong> 일부 클라이언트 웹 브라우저에서 413 http 응답 메시지를 제대로 표시할 수 없습니다.</dd>
<dt>샘플 Ingress 리소스 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>다음 값을 대체하십시오.<ul><li><code><em>&lt;size&gt;</em></code>: 클라이언트 응답 본문의 최대 크기를 입력하십시오. 예를 들어, 200MB로 설정하려면 <strong>200m</strong>을 정의하십시오.

  </br></br>
  <strong>참고:</strong> 클라이언트 요청 본문 크기 검사를 사용하지 않게 크기를 0으로 설정할 수 있습니다.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


## IP 주소 및 서브넷 관리
{: #cs_cluster_ip_subnet}

클러스터에서 앱을 노출시키고 인터넷에서 액세스 가능하도록 하기 위해 포터블 공인 서브넷 및 IP 주소를 사용할 수 있습니다.
{:shortdesc}

{{site.data.keyword.containershort_notm}}에서 사용자는 클러스터에 네트워크 서브넷을 추가하여 Kubernetes 서비스에 대한 안정적인 포터블 IP를 추가할 수 있습니다. 표준 클러스터를 작성하면 {{site.data.keyword.containershort_notm}}에서 포터블 공인 서브넷과 5개의 IP 주소를 자동으로 프로비저닝합니다. 포터블 공인 IP 주소는 정적이며 작업자 노드 또는 클러스터가 제거되더라도 변경되지 않습니다. 

공용 라우트를 사용하여 클러스터의 다중 앱을 노출시키는 데 사용할 수 있는 [Ingress 제어기](#cs_apps_public_ingress)에 포터블 공인 IP 주소 중 하나가 사용됩니다. 나머지 네 개의 포터블 공인 IP 주소는 [로드 밸런서 서비스 작성](#cs_apps_public_load_balancer)을 통해 단일 앱을 공용으로 노출시키는 데 사용될 수 있습니다. 

**참고:** 포터블 공인 IP 주소는 매월 비용이 청구됩니다. 클러스터가 프로비저닝된 후에 포터블 공인 IP 주소를 제거하도록 선택한 경우, 비록 짧은 시간 동안만 사용했어도 월별 비용을 계속 지불해야 합니다. 



1.  `myservice.yaml`로 이름 지정된 Kubernetes 서비스 구성 스크립트를 작성하고 더미 로드 배런서 IP 주소와 함께 유형 `LoadBalancer`의 서비스를 정의하십시오. 다음 예는 로드 밸런서 IP 주소로 IP 주소 1.1.1.1을 사용합니다.  

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  클러스터에 서비스를 작성하십시오. 

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  서비스를 검사하십시오.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **참고:** Kubernetes 마스터가 Kubernetes 구성 맵에서 지정된 로드 밸런서 IP 주소를 찾을 수 없기 때문에 이 서비스의 작성에 실패합니다. 이 명령을 실행하면 오류 메시지 및 클러스터에 사용 가능한 공인 IP 주소의 목록을 볼 수 있습니다.


    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### 사용된 공인 IP 주소 해제
{: #freeup_ip}

포터블 공인 IP 주소를 사용하고 있는 로드 밸런서 서비스를 삭제하여 사용된 포터블 공인 IP 주소를 해제할 수 있습니다. 

[시작하기 전에, 사용할 클러스터의 컨텍스트를 설정하십시오.](cs_cli_install.html#cs_cli_configure)

1.  클러스터에서 사용 가능한 서비스를 나열하십시오. 

    ```
     kubectl get services
    ```
    {: pre}

2.  공인 IP 주소를 사용하는 로드 밸런서 서비스를 제거하십시오. 

    ```
    kubectl delete service <myservice>
    ```
    {: pre}


## GUI로 앱 배치
{: #cs_apps_ui}

Kubernetes 대시보드를 사용하여 클러스터에 앱을 배치하는 경우, 클러스터에서 포드를 작성하고 업데이트하며 관리하는 배치가 사용자를 위해 자동으로 작성됩니다.
{:shortdesc}

시작하기 전에:

-   필수 [CLI](cs_cli_install.html#cs_cli_install)를 설치하십시오. 
-   클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

앱을 배치하려면 다음을 수행하십시오. 

1.  [Kubernetes 대시보드를 여십시오](#cs_cli_dashboard).
2.  Kubernetes 대시보드에서 **+ 작성**을 클릭하십시오. 
3.  **아래의 앱 세부사항 지정**을 선택하여 GUI에서 앱 세부사항을 입력하거나, **YAML 또는 JSON 파일 업로드**를 선택하여 앱 [구성 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)을 업로드하십시오. 
미국 남부 지역의 **ibmliberty** 이미지에서 컨테이너를 배포하려면 [이 예제 YAML 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml)을 사용하십시오. 
4.  Kubernetes 대시보드에서 **배치**를 클릭하여 배치가 작성되었는지 확인하십시오. 
5.  노드 포트 서비스, 로드 밸런서 서비스 또는 Ingress를 사용하여 앱을 공용으로 사용 가능하게 한 경우 [앱에 액세스할 수 있는지 확인](#cs_apps_public)하십시오.

## CLI로 앱 배치
{: #cs_apps_cli}

클러스터가 작성된 후에 Kubernetes CLI를 사용하여 해당 클러스터에 앱을 배치할 수 있습니다.
{:shortdesc}

시작하기 전에:

-   필수 [CLI](cs_cli_install.html#cs_cli_install)를 설치하십시오. 
-   클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

앱을 배치하려면 다음을 수행하십시오. 

1.  [Kubernetes 우수 사례 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/overview/)를 기반으로 구성 스크립트를 작성하십시오. 일반적으로, 구성 스크립트에는 Kubernetes에서 작성 중인 각각의 리소스에 대한 구성 세부사항이 포함되어 있습니다. 스크립트에는 하나 이상의 다음 섹션이 포함될 수 있습니다.


    -   [배치 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): 포드와 복제본 세트 작성을 정의합니다. 포드에는 개별 컨테이너화된 앱이 포함되며, 복제본 세트는 포드의 다중 인스턴스를 제어합니다. 

    -   [서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/): 작업자 노드나 로드 밸런서 공인 IP 주소 또는 공용 Ingress 라우트를 사용하여 포드에 프론트 엔드 액세스를 제공합니다.

    -   [Ingress ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/ingress/): 공개적으로 앱에 액세스하는 라우트를 제공하는 로드 밸런서 유형을 지정합니다.

2.  클러스터의 컨텍스트에서 구성 스크립트를 실행하십시오. 

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  노드 포트 서비스, 로드 밸런서 서비스 또는 Ingress를 사용하여 앱을 공용으로 사용 가능하게 한 경우 [앱에 액세스할 수 있는지 확인](#cs_apps_public)하십시오.



## 롤링 배치 관리
{: #cs_apps_rolling}

자동화되고 제어 가능한 방식으로 변경사항의 롤아웃을 관리할 수 있습니다. 롤아웃이 계획대로 진행되지 않으면 배치를 이전 개정으로 롤백할 수 있습니다.
{:shortdesc}

시작하기 전에 [배치](#cs_apps_cli)를 작성하십시오.

1.  변경사항을 [롤아웃 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout)하십시오. 예를 들어, 초기 배치에 사용된 이미지를 변경할 수 있습니다.

    1.  배치 이름을 가져오십시오. 

        ```
         kubectl get deployments
        ```
        {: pre}

    2.  포드 이름을 가져오십시오. 

        ```
         kubectl get pods
        ```
        {: pre}

    3.  포드에서 실행 중인 컨테이너의 이름을 가져오십시오. 

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  사용할 배치에 대해 새 이미지를 설정하십시오. 

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    명령을 실행하면 변경사항이 즉시 적용되며 롤아웃 히스토리에 로깅됩니다. 

2.  배치의 상태를 확인하십시오. 

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  변경사항을 롤백하십시오. 
    1.  배치의 롤아웃 히스토리를 보고 마지막 배치의 개정 번호를 식별하십시오.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **팁:** 특정 개정에 대한 세부사항을 보려면 개정 번호를 포함하십시오.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  이전 버전으로 롤백하거나 개정을 지정하십시오. 이전 버전으로 롤백하려면 다음 명령을 사용하십시오.


        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

## {{site.data.keyword.Bluemix_notm}} 서비스 추가
{: #cs_apps_service}

암호화된 Kubernetes 시크릿을 사용하여 {{site.data.keyword.Bluemix_notm}} 서비스 세부사항과 신임 정보를 저장하고 서비스와 클러스터 간의 보안 통신을 허용합니다. 클러스터 사용자인 경우에는 포드에 볼륨으로서 마운트하여 이 시크릿에 액세스할 수 있습니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 앱에서 사용하려는 {{site.data.keyword.Bluemix_notm}} 서비스를 클러스터 관리자가 [클러스터에 추가](cs_cluster.html#cs_cluster_service)하게 하십시오.

Kubernetes 시크릿은 사용자 이름, 비밀번호 또는 키와 같은 기밀 정보를 저장하는 안전한 방법입니다.
환경 변수를 사용하거나 Dockerfile에서 직접 기밀 정보를 노출하는 대신 포드에서 실행 중인 컨테이너가 정보에 액세스할 수 있게 하려면
포드에 대한 시크릿 볼륨으로 시크릿을 마운트해야 합니다. 

시크릿 볼륨을 포드에 마운트하면, 이름이 binding인 파일이 {{site.data.keyword.Bluemix_notm}} 서비스에 액세스하는 데 필요한 모든 정보와 신임 정보가 포함된 볼륨 마운트 디렉토리에 저장됩니다. 

1.  클러스터 네임스페이스에서 사용 가능한 시크릿을 나열하십시오. 

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    출력 예: 

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  **오파크** 유형의 시크릿을 찾아서 시크릿의 **이름**을 기록해 놓으십시오. 다수의 시크릿이 존재하면 클러스터 관리자에게 문의하여 올바른 서비스 시크릿을 식별하십시오. 

3.  선호하는 편집기를 여십시오. 

4.  시크릿 볼륨을 통해 서비스 세부사항에 액세스할 수 있는 포드를 구성하기 위한 YAML 파일을 작성하십시오. 

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>컨테이너에 마운트할 시크릿 볼륨의 이름입니다. </td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>컨테이너에 마운트할 시크릿 볼륨의 이름을 입력하십시오. </td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>서비스 시크릿에 대한 읽기 전용 권한을 설정하십시오. </td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>이전에 기록한 시크릿의 이름을 입력하십시오. </td>
    </tr></tbody></table>

5.  포드를 작성하고 시크릿 볼륨을 마운트하십시오. 

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  포드가 작성되었는지 확인하십시오. 

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    CLI 출력 예제:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  포드의 **이름**을 기록해 놓으십시오. 
8.  포드에 대한 세부사항을 가져오고 시크릿 이름을 찾으십시오. 

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    출력:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  앱을 구현할 때 마운트 디렉토리에서 이름이 **binding**이라는 시크릿 파일을 찾고 JSON 컨텐츠를 구문 분석하며 {{site.data.keyword.Bluemix_notm}} 서비스에 액세스하기 위한 URL 및 서비스 신임 정보를 판별하도록 앱을 구성하십시오.

이제 {{site.data.keyword.Bluemix_notm}} 서비스 세부사항과 신임 정보에 액세스할 수 있습니다. {{site.data.keyword.Bluemix_notm}} 서비스 관련
작업을 수행하려면, 마운트 디렉토리에서 서비스 시크릿 파일을 찾아서 JSON 컨텐츠를 구문 분석하고
서비스 세부사항을 판별하도록 앱이 구성되어 있는지 확인하십시오. 

## 지속적 스토리지 작성
{: #cs_apps_volume_claim}

클러스터의 NFS 파일 스토리지를 프로비저닝하는 지속적 볼륨 클레임을 작성합니다. 포드에 장애가 발생하거나 종료되어도 데이터를 사용할 수 있도록 이 클레임을 포드에 마운트합니다.
{:shortdesc}

 지속적 볼륨을 지원하는 NFS 파일 스토리지는 데이터에 대한 고가용성을 제공할 수 있도록 IBM에서 클러스터링합니다. 

1.  사용 가능한 스토리지 클래스를 검토하십시오. {{site.data.keyword.containerlong}}는 클러스터 관리자가 스토리지 클래스를 작성할 필요가 없도록 세 개의 사전 정의된 스토리지 클래스를 제공합니다. 

    ```
     kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  사용 가능한 크기 또는 스토리지 클래스의 IOPS를 검토하십시오. 

    ```
     kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    **매개변수** 필드는 스토리지 클래스와 연관된 GB당 IOPS 및 사용 가능한 크기(기가바이트 단위)를 제공합니다. 

    ```
     Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

3.  선호하는 텍스트 편집기에서 지속적 볼륨 클레임을 정의하는 구성 스크립트를 작성한 후에 해당 구성을 `.yaml` 파일로 저장하십시오. 

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>지속적 볼륨 클레임의 이름을 입력하십시오. </td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>지속적 볼륨에 대한 호스트 파일 공유의 GB당 IOPS를 정의하는 스토리지 클래스를 지정합니다. <ul><li>ibmc-file-bronze: GB당 2 IOPS. </li><li>ibmc-file-silver: GB당 4 IOPS. </li><li>ibmc-file-gold: GB당 10 IOPS. </li>

    </li> 스토리지 클래스를 지정하지 않은 경우, 브론즈 스토리지 클래스로 지속적 볼륨이 작성됩니다. </td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> 나열된 크기 이외의 크기를 선택하면 해당 크기가 올림됩니다. 최대 크기보다 더 큰 크기를 선택하는 경우에는 내림됩니다. </td>
    </tr>
    </tbody></table>

4.  지속적 볼륨 클레임을 작성하십시오. 

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

5.  지속적 볼륨 클레임이 작성되고 지속적 볼륨에 바인드되었는지 확인하십시오. 이 프로세스는 몇 분 정도 소요됩니다. 

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    출력은
다음과 같이 표시됩니다. 

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}지속적 볼륨 클레임을 포드에 마운트하려면 구성 스크립트를 작성하십시오. 구성을 `.yaml` 파일로 저장하십시오.


    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>포드의 이름입니다.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>컨테이너 내에서 볼륨이 마운트되는 디렉토리의 절대 경로입니다. </td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>컨테이너에 마운트하는 볼륨의 이름입니다. </td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>컨테이너에 마운트하는 볼륨의 이름입니다. 일반적으로 이 이름은 <code>volumeMounts/name</code>과 동일합니다. </td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>볼륨으로 사용할 지속적 볼륨 클레임의 이름입니다. 볼륨을 포드에 마운트하는 경우, Kubernetes는 지속적 볼륨 클레임에 바인드된 지속적 볼륨을 식별하며 사용자가 지속적 볼륨에서 읽고 쓸 수 있도록 합니다. </td>
    </tr>
    </tbody></table>

7.  포드를 작성하고 지속적 볼륨 클레임을 포드에 마운트하십시오. 

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

8.  볼륨이 포드에 정상적으로 마운트되었는지 확인하십시오. 

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    마운트 지점은 **볼륨 마운트** 필드에 있고 볼륨은 **볼륨** 필드에 있습니다.


    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

## 지속적 스토리지에 루트가 아닌 사용자 액세스 추가
{: #cs_apps_volumes_nonroot}

루트가 아닌 사용자에게는 NFS 지원 스토리지의 볼륨 마운트 경로에 대한 쓰기 권한이 없습니다. 쓰기 권한을 부여하려면, 이미지의 Dockerfile을 편집하여 올바른 권한으로 마운트 경로에서 디렉토리를 작성해야 합니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

볼륨에 대한 쓰기 권한이 필요한 비루트 사용자로 앱을 디자인하는 경우, 다음 프로세스를 Dockerfile 및 시작점 스크립트에 추가해야 합니다. 

-   비루트 사용자를 작성하십시오. 
-   임시로 사용자를 루트 그룹에 추가하십시오. 
-   올바른 사용자 권한으로 볼륨 마운트 경로에서 디렉토리를 작성하십시오. 

{{site.data.keyword.containershort_notm}}의 경우 볼륨 마운트 경로의 기본 소유자는 `nobody` 소유자입니다. NFS 스토리지에서 소유자가 포드의 로컬에 없으면 `nobody` 사용자가 작성됩니다. 볼륨은 컨테이너의 루트 사용자를 인식하도록 설정됩니다. 일부 앱에서는 이 사용자가 컨테이너의 유일한 사용자입니다. 그러나 다수의 앱에서는 `nobody`가 아니라 컨테이너 마운트 경로에 쓰는 루트가 아닌 사용자를 지정합니다. 

1.  로컬 디렉토리에서 Dockerfile을 작성하십시오. 이 예제 Dockerfile은 이름이 `myguest`인 비루트 사용자를 작성합니다. 

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    #The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest
    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Dockerfile과 동일한 로컬 폴더에 시작점 스크립트를 작성하십시오. 이 예제 시작점 스크립트는 볼륨 마운트 경로로 `/mnt/myvol`을 지정합니다. 

    ```
    #!/bin/bash
    set -e

    #This is the mount point for the shared volume.
    #By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
    #Add the non-root user to primary group of root user.
    usermod -aG root $MY_USER

    #Provide read-write-execute permission to the group for the shared volume mount path.
    chmod 775 $MOUNTPATH

    # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #For security, remove the non-root user from root user group.
      deluser $MY_USER root

      #Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    #This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  {{site.data.keyword.registryshort_notm}}에 로그인하십시오.

    ```
    bx cr login
    ```
    {: pre}

4.  로컬에서 이미지를 빌드하십시오. _&lt;my_namespace&gt;_를 개인용 이미지 레지스트리의 네임스페이스로 대체하십시오. 네임스페이스를 찾아야 하면 `bx cr namespace-get`를 실행하십시오.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  {{site.data.keyword.registryshort_notm}}에서 네임스페이스에 이미지를 푸시하십시오.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  구성 `.yaml` 파일을 작성하여 지속적 볼륨 클레임을 작성하십시오. 이 예에서는 낮은 성능 스토리지 클래스를 사용합니다. 사용 가능한 스토리지 클래스를 보려면 `kubectl get storageclasses`를 실행하십시오.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  지속적 볼륨 클레임을 작성하십시오. 

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  볼륨을 마운트하고 루트가 아닌 이미지에서 포드를 실행하기 위해 구성 스크립트를 작성하십시오. 볼륨 마운트 경로 `/mnt/myvol`은 Dockerfile에 지정된 마운트 경로와 일치합니다. 구성을 `.yaml` 파일로 저장하십시오. 

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  포드를 작성하고 지속적 볼륨 클레임을 포드에 마운트하십시오. 

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. 볼륨이 포드에 정상적으로 마운트되었는지 확인하십시오. 

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    마운트 지점이 **볼륨 마운트** 필드에 나열되며, 볼륨이 **볼륨** 필드에 나열됩니다. 

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. 포드가 실행된 후 포드에 로그인하십시오. 

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. 볼륨 마운트 경로의 권한을 보십시오. 

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    이 출력은 해당 루트에 볼륨 마운트 경로 `mnt/myvol/`에 대한 읽기, 쓰기 및 실행 권한이 있는 것으로 표시하지만 루트가 아닌 myguest 사용자에게는 `mnt/myvol/mydata` 폴더에 대한 읽기 및 쓰기 권한이 있습니다. 이 업데이트된 권한 때문에 비루트 사용자는 이제 데이터를 지속적 볼륨에 쓸 수 있습니다. 


