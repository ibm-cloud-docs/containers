---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

다음 이미지의 영역을 클릭하여 앱을 배치하기 위한 일반 단계를 자세히 보십시오.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="CLI를 설치하십시오." title="CLI를 설치하십시오." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="앱의 구성 파일을 작성하십시오. Kubernetes의 우수 사례를 검토하십시오." title="앱의 구성 파일을 작성하십시오. Kubernetes의 우수 사례를 검토하십시오." shape="rect" coords="254, 64, 486, 231" />
<area href="#cs_apps_cli" target="_blank" alt="옵션 1: Kubernetes CLI에서 구성 파일을 실행하십시오." title="옵션 1: Kubernetes CLI에서 구성 파일을 실행하십시오." shape="rect" coords="544, 67, 730, 124" />
<area href="#cs_cli_dashboard" target="_blank" alt="옵션 2: Kubernetes 대시보드를 로컬로 시작하고 구성 파일을 실행하십시오." title="옵션 2: Kubernetes 대시보드를 로컬로 시작하고 구성 파일을 실행하십시오." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Kubernetes 대시보드 실행
{: #cs_cli_dashboard}

로컬 시스템의 Kubernetes 대시보드를 열어서 클러스터 및 해당 작업자 노드에 대한 정보를 봅니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 이 태스크에는 [관리자 액세스 정책](cs_cluster.html#access_ov)이 필요합니다. 현재 [액세스 정책](cs_cluster.html#view_access)을 확인하십시오. 

기본 포트를 사용하거나 자체 포트를 설정하여 클러스터에 대한 Kubernetes 대시보드를 실행할 수 있습니다. 

1.  Kubernetes 마스터 버전 1.7.4 이하가 있는 클러스터의 경우:

    1.  기본 포트 번호로 프록시를 설정하십시오. 

        ```
        kubectl proxy
        ```
        {: pre}

        출력:

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  웹 브라우저에서 Kubernetes 대시보드를 여십시오.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  Kubernetes 마스터 버전 1.8.2 이상이 있는 클러스터의 경우:

    1.  신임 정보를 다운로드하십시오.

        ```
  bx cs cluster-config <cluster_name> 
  ```
        {: codeblock}

    2.  다운로드한 클러스터 신임 정보를 보십시오. 이전 단계에서 내보내기에 지정된 파일 경로를 사용하십시오.

        macOS 또는 Linux의 경우:

        ```
        cat <filepath_to_cluster_credentials>
        ```
        {: codeblock}

        Windows의 경우:

        ```
        type <filepath_to_cluster_credentials>
        ```
        {: codeblock}

    3.  **id-token** 필드에서 토큰을 복사하십시오.

    4.  기본 포트 번호로 프록시를 설정하십시오. 

        ```
        kubectl proxy
        ```
        {: pre}

        CLI 출력은 다음과 같이 표시됩니다. 

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    6.  대시보드에 로그인하십시오.

        1.  브라우저에 이 URL을 복사하십시오.

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  사인온 페이지에서 **토큰** 인증 방법을 선택하십시오.

        3.  그런 다음 **id-token** 값을 **토큰** 필드에 붙여넣고 **로그인**을 클릭하십시오.

[그런 다음 대시보드에서 구성 파일을 실행할 수 있습니다.](#cs_apps_ui)

Kubernetes 대시보드에서 작업이 완료되면 `CTRL+C`를 사용하여 `proxy` 명령을 종료하십시오. 종료한 후에는 Kubernetes 대시보드를 더 이상 사용할 수 없습니다. `proxy` 명령을 실행하여 Kubernetes 대시보드를 다시 시작하십시오.



<br />


## 시크릿 작성
{: #secrets}

Kubernetes 시크릿은 사용자 이름, 비밀번호 또는 키와 같은 기밀 정보를 저장하는 안전한 방법입니다.



<table>
<caption>테이블. 태스크별로 시크릿에 저장해야 하는 파일</caption>
<thead>
<th>태스크</th>
<th>시크릿에 저장할 필수 파일</th>
</thead>
<tbody>
<tr>
<td>클러스터에 서비스 추가</td>
<td>없음. 클러스터에 서비스를 바인드할 때 시크릿이 작성됩니다.</td>
</tr>
<tr>
<td>선택사항: Ingress 시크릿을 사용하지 않는 경우 TLS를 사용하여 Ingress 서비스를 구성하십시오. <p><b>참고</b>: TLS는 기본적으로 이미 사용 가능하며 시크릿도 TLS 연결을 위해 이미 작성되어 있습니다.

기본 TLS 시크릿을 보려면 다음을 수행하십시오.
<pre>
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
대신 고유 시크릿을 작성하려면 이 주제의 단계를 완료하십시오.</td>
<td>서버 인증서 및 키: <code>server.crt</code> 및 <code>server.key</code></td>
<tr>
<td>상호 인증 어노테이션을 작성하십시오.</td>
<td>CA 인증서: <code>ca.crt</code></td>
</tr>
</tbody>
</table>

시크릿에 저장할 수 있는 항목에 대한 자세한 정보는 [Kubernetes 문서](https://kubernetes.io/docs/concepts/configuration/secret/)를 참조하십시오.



인증서로 시크릿을 작성하려면 다음을 수행하십시오.

1. 인증 제공자로부터 인증 기관(CA) 인증서 및 키를 생성하십시오. 고유 도메인이 있는 경우 도메인의 공식적 TLS 인증서를 구매하십시오. 테스트용으로 자체 서명 인증서를 생성할 수 있습니다.

 중요: [CN](https://support.dnsimple.com/articles/what-is-common-name/)이 인증서마다 다른지 확인하십시오.

 클라이언트 인증서 및 클라이언트 키는 신뢰할 수 있는 루트 인증서(이 경우 CA 인증서)까지 확인해야 합니다. 예:

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. 인증서를 Kubernetes 시크릿으로 작성하십시오.

 ```
 kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
 ```
 {: pre}

 예:
 - TLS 연결:

 ```
 kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
 ```
 {: pre}

 - 상호 인증 어노테이션:

 ```
 kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
 ```
 {: pre}

<br />



## 앱에 대한 공용 액세스 허용
{: #cs_apps_public}

인터넷에서 공용으로 앱을 사용할 수 있으려면 클러스터에 앱을 배치하기 전에 구성 파일을 업데이트해야 합니다.
{:shortdesc}

라이트 또는 표준 클러스터를 작성했는지 여부에 따라 인터넷에서 앱에 다양한 방법으로 액세스할 수 있습니다. 

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort 서비스</a>(라이트 및 표준 클러스터)</dt>
<dd>모든 작업자 노드에서 공용 포트를 노출시키고, 임의의 작업자 노드의 공인 IP 주소를 사용하여 클러스터의 서비스에 공용으로 액세스합니다. 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드가 제거되거나 다시 작성되면 새 공인 IP 주소가 작업자 노드에 지정됩니다. 앱에 대한 공용 액세스를 테스트하기 위해 또는 짧은 시간 동안에만 공용 액세스가 필요한 경우에 NodePort 서비스를 사용할 수 있습니다. 서비스 엔드포인트에 대한 추가 가용성과 안정적인 공인 IP 주소가 필요한 경우에는 LoadBalancer 서비스 또는 Ingress를 사용하여 앱을 노출하십시오. </dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer 서비스</a>(표준 클러스터 전용)</dt>
<dd>모든 표준 클러스터는 앱에 대한 외부 TCP/UDP 로드 밸런서를 작성하는 데 사용할 수 있는 4개의 포터블 공인 IP 주소 및 4개의 사설 IP 주소로 프로비저닝됩니다. 앱이 요구하는 포트를 노출함으로써 로드 밸런서를 사용자 정의할 수 있습니다. 로드 밸런서에 지정된 포터블 공인 IP 주소는 영구적이며 클러스터에서 작업자 노드가 다시 작성될 때 변경되지 않습니다.

</br>
앱에 대해 HTTP 또는 HTTPS 로드 밸런싱이 필요하며 하나의 공용 라우트를 사용하여 클러스터의 다중 앱을 서비스로서 노출시키려는 경우에는 {{site.data.keyword.containershort_notm}}의 기본 제공 Ingress 지원을 사용하십시오. </dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a>(표준 클러스터 전용)</dt>
<dd>안전하고 고유한 공용 시작점을 사용하여 수신 요청을 앱으로 라우팅하는 한 개의 외부 HTTP 또는 HTTPS 로드 밸런서를 작성하여 클러스터의 다중 앱을 노출시킵니다. Ingress는 두 개의 기본 컴포넌트(Ingress 리소스와 Ingress 제어기)로 구성되어 있습니다. Ingress 리소스는 앱에 대한 수신 요청을 라우팅하고 로드 밸런싱하는 방법에 대한 규칙을 정의합니다. 모든 Ingress 리소스는 수신 HTTP 또는 HTTPS 서비스 요청을 청취하고 각 Ingress 리소스에 정의된 규칙을 기반으로 요청을 전달하는 Ingress 제어기와 함께 등록되어야 합니다. 사용자 정의 라우팅 규칙으로 사용자 고유의 로드 밸런서를 구현하려는 경우와 앱에 대한 SSL 종료가 필요한 경우 Ingress를 사용하십시오.

</dd></dl>

### NodePort 서비스 유형을 사용하여 앱에 대한 공용 액세스 구성
{: #cs_apps_public_nodeport}

클러스터에서 작업자 노드의 공인 IP 주소를 사용하고 노드 포트를 노출하여 인터넷 액세스를 통해 앱이 사용 가능하게 하십시오. 
테스트 및 단기적 공용 액세스 용도로만 이 옵션을 사용하십시오. 

{:shortdesc}

라이트 또는 표준 클러스터에 대해 Kubernetes NodePort 서비스로 앱을 노출할 수 있습니다. 

{{site.data.keyword.Bluemix_dedicated_notm}} 환경의 경우 방화벽에서 공인 IP 주소를 차단합니다. 앱을 공개적으로 사용 가능하게 하려면 [LoadBalancer 서비스](#cs_apps_public_load_balancer) 또는 [Ingress](#cs_apps_public_ingress)를 대신 사용하십시오.

**참고:** 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드를 다시 작성해야 하는 경우에는 새 공인 IP 주소가 작업자 노드에 지정됩니다. 서비스에 대한 추가 가용성과 안정적인 공인 IP 주소가 필요한 경우에는 [LoadBalancer 서비스](#cs_apps_public_load_balancer) 또는 [Ingress](#cs_apps_public_ingress)를 사용하여 앱을 노출하십시오.




1.  구성 파일에 [서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/) 섹션을 정의하십시오.
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
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
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

### 로드 밸런서 서비스 유형을 사용하여 앱에 대한 액세스 구성
{: #cs_apps_public_load_balancer}

포트를 노출하고 로드 밸런서의 포터블 IP 주소를 사용하여 앱에 액세스하십시오. 공인 IP 주소를 사용하여 인터넷에서 앱에 액세스할 수 있게 하거나, 사설 IP 주소를 사용하여 사설 인프라 네트워크에서 앱에 액세스할 수 있게 하십시오.

NodePort 서비스와 다르게 로드 밸런서 서비스의 포터블 IP 주소는 앱이 배치된 작업자 노드에 의존하지 않습니다. 그러나 Kubernetes LoadBalancer 서비스도 NodePort 서비스입니다. LoadBalancer 서비스는 로드 밸런서 IP 주소 및 포트를 통해 앱을 사용할 수 있도록 하고 서비스의 노드 포트를 통해 앱을 사용할 수 있도록 합니다.

로드 밸런서의 포터블 IP 주소가 지정되며 사용자가 작업자 노드를 추가하거나 제거해도 변경되지 않습니다. 따라서 로드 밸런서 서비스가 NodePort 서비스보다 가용성이 더 높습니다. 사용자는 로드 밸런서에 대한 임의의 포트를 선택할 수 있으며, 이는 NodePort 포트 범위로 제한되지 않습니다. 사용자는 TCP 및 UDP 프로토콜에 대한 로드 밸런서 서비스를 사용할 수 있습니다. 

{{site.data.keyword.Bluemix_dedicated_notm}} 계정이 [클러스터에 사용](cs_ov.html#setup_dedicated)되면 로드 밸런서 IP 주소에 사용할 공용 서브넷을 요청할 수 있습니다. [지원 티켓을 열어](/docs/support/index.html#contacting-support) 서브넷을 작성한 다음 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 명령을 사용하여 클러스터에 서브넷을 추가하십시오. 

**참고:** 로드 밸런서 서비스는 TLS 종료를 지원하지 않습니다. 앱에서 TLS 종료가 필요한 경우 [Ingress](#cs_apps_public_ingress)를 사용하여 앱을 노출하거나 TLS 종료를 관리하도록 앱을 구성할 수 있습니다.

시작하기 전에:

-   이 기능은 표준 클러스터에 대해서만 사용 가능합니다.
-   로드 밸런서 서비스에 지정하는 데 사용할 수 있는 포터블 공인 또는 사설 IP 주소를 보유해야 합니다. 
-   포터블 사설 IP 주소를 사용하는 로드 밸런서 서비스에는 여전히 모든 작업 노드에서 열려 있는 공용 노드 포트가 있습니다.
공용 트래픽을 방지하기 위한 네트워크 정책을 추가하려면 [수신 트래픽 차단](cs_security.html#cs_block_ingress)을 참조하십시오.

로드 밸런서 서비스를 작성하려면 다음을 수행하십시오. 

1.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 
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
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>LoadBalancer의 유형을 지정하기 위한 어노테이션입니다. 값은 `private` 및 `public`입니다. 퍼블릭 VLAN의 클러스터에서 공용 LoadBalancer를 작성하는 경우 이 어노테이션은 필요하지 않습니다.
        </td>
        </tbody></table>
    3.  선택사항: 클러스터에 사용할 수 있는 로드 밸런서에 대해 특정 포터블 IP 주소를 사용하려면 스펙 섹션에 `loadBalancerIP`를 포함하여 해당 IP 주소를 지정할 수 있습니다. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/)을 참조하십시오.
    4.  선택사항: 스펙 섹션에 `loadBalancerSourceRanges`를 지정하여 방화벽을 구성하십시오. 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)을 참조하십시오.
    5.  클러스터에 서비스를 작성하십시오. 

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

    CLI 출력 예제:

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

**LoadBalancer Ingress** IP 주소는 로드 밸런서 서비스에 지정된 포터블 IP 주소입니다.
4.  공용 로드 밸런서를 작성한 경우 인터넷에서 앱에 액세스하십시오.
    1.  선호하는 웹 브라우저를 여십시오. 
    2.  로드 밸런서 및 포트의 포터블 공인 IP 주소를 입력하십시오. 위의 예제에서는 포터블 공인 IP 주소 `192.168.10.38`이 로드 밸런서 서비스에 지정되었습니다. 

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}




### Ingress 제어기를 사용하여 앱에 대한 액세스 구성
{: #cs_apps_public_ingress}

IBM 제공 Ingress 제어기가 관리하는 Ingress 리소스를 작성하여 클러스터에서 다중 앱을 노출합니다. Ingress 제어기는 안전하고 고유한 공용 또는 개인용 시작점을 사용하여 수신 요청을 클러스터 내부 또는 외부의 앱으로 라우팅하는 외부 HTTP 또는 HTTPS 로드 밸런서입니다.

**참고:** Ingress는 표준 클러스터에만 사용 가능하고 고가용성을 보장할 수 있도록 클러스터에 최소한 두 개의 작업자 노드가 있어야 하며 주기적 업데이트가 적용됩니다.Ingress를 설정하려면 [관리자 액세스 정책](cs_cluster.html#access_ov)이 필요합니다. 현재 [액세스 정책](cs_cluster.html#view_access)을 확인하십시오. 

표준 클러스터를 작성하면 포터블 공인 IP 주소 및 공용 라우트에 지정된 Ingress 제어기가 자동으로 작성되고 사용됩니다. 포터블 사설 IP 주소 및 개인용 라우트에 지정된 Ingress 제어기도 자동으로 작성되지만 자동으로 사용되지는 않습니다. 이러한 Ingress 제어기를 구성하고 공용 또는 사설 네트워크에 노출하는 모든 앱에 대해 개별 라우팅 규칙을 정의할 수 있습니다. Ingress를 통해 공용으로 노출된 모든 앱에는 고유 URL을 사용하여 클러스터에서 앱에 공용으로 액세스할 수 있도록 공용 라우트에 추가된 고유 경로가 지정됩니다.

{{site.data.keyword.Bluemix_dedicated_notm}} 계정이 [클러스터에 사용](cs_ov.html#setup_dedicated)되면 Ingress 제어기 IP 주소에 사용할 공용 서브넷을 요청할 수 있습니다. 그러면 Ingress 제어기가 작성되며 공용 라우트가 지정됩니다. [지원 티켓을 열어](/docs/support/index.html#contacting-support) 서브넷을 작성한 다음 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 명령을 사용하여 클러스터에 서브넷을 추가하십시오. 

앱을 공용으로 노출하기 위해 다음 시나리오에 맞게 공용 Ingress 제어기를 구성할 수 있습니다.

-   [TLS 종료 없이 IBM 제공 도메인 사용](#ibm_domain)
-   [TLS 종료와 함께 IBM 제공 도메인 사용](#ibm_domain_cert)
-   [TLS 종료를 수행하기 위해 사용자 정의 도메인 및 TLS 인증서 사용](#custom_domain_cert)
-   [클러스터 외부의 앱에 액세스하기 위해 TLS 종료와 함께 IBM 제공 또는 사용자 정의 도메인 사용](#external_endpoint)
-   [Ingress 로드 밸런서에서 포트 열기](#opening_ingress_ports)
-   [HTTP 레벨에서 SSL 프로토콜 및 SSL 암호 구성](#ssl_protocols_ciphers)
-   [어노테이션으로 Ingress 제어기 사용자 정의](cs_annotations.html)
{: #ingress_annotation}

사설 네트워크에 앱을 노출하려면 먼저 [사설 Ingress 제어기를 사용으로 설정](#private_ingress)하십시오. 그리고 다음 시나리오에 맞게 사설 Ingress 제어기를 구성할 수 있습니다.

-   [TLS 종료 없이 사용자 정의 도메인 사용](#private_ingress_no_tls)
-   [TLS 종료를 수행하기 위해 사용자 정의 도메인 및 TLS 인증서 사용](#private_ingress_tls)

#### TLS 종료 없이 IBM 제공 도메인 사용
{: #ibm_domain}

클러스터의 앱에 대한 HTTP 로드 밸런서로서 Ingress 제어기를 구성하고 인터넷에서 앱에 액세스하기 위해 IBM 제공 도메인을 사용할 수 있습니다. 

시작하기 전에:

-   클러스터가 아직 없으면 [표준 클러스터를 작성](cs_cluster.html#cs_cluster_ui)하십시오. 
-   클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하고 `kubectl` 명령을 실행하십시오.

Ingress 제어기를 구성하려면 다음을 수행하십시오. 

1.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 
2.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들어, `myservice.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
    1.  선호하는 편집기를 열고 예를 들어, `myingress.yaml`이라는 이름의 Ingress 구성 파일을 작성하십시오. 
    2.  IBM 제공 도메인을 사용하여 수신 네트워크 트래픽을 이전에 작성된 서비스로 라우팅하는 Ingress 리소스를 구성 파일에 정의하십시오. 

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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
        예:<ul><li><code>http://ingress_host_name/</code>의 경우 <code>/</code>를 경로로 입력하십시오. </li><li><code>http://ingress_host_name/myservicepath</code>의 경우 <code>/myservicepath</code>를 경로로 입력하십시오.</li></ul>
        </br>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 [재작성 어노테이션](cs_annotations.html#rewrite-path)을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
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

1.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함되도록록 앱이 실행 중인 모든 포드를 식별합니다. 
2.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들어, `myservice.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

3.  IBM 제공 도메인과 TLS 인증서를 확인하십시오. _&lt;mycluster&gt;_를 앱이 배치되는 클러스터의 이름으로 대체하십시오. 

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
    1.  선호하는 편집기를 열고 예를 들어, `myingress.yaml`이라는 이름의 Ingress 구성 파일을 작성하십시오. 
    2.  IBM 제공 도메인을 사용하여 수신 네트워크 트래픽을 서비스로 라우팅하고 IBM 제공 인증서를 사용하여 TLS 종료를 관리하는 Ingress 리소스를 구성 파일에 정의하십시오. 모든 서비스에 대해 IBM 제공 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://ingress_domain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 앱이 실행 중인 포드에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취해야 합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은
특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 `/`로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
        예:<ul><li><code>http://ingress_host_name/</code>의 경우 <code>/</code>를 경로로 입력하십시오. </li><li><code>http://ingress_host_name/myservicepath</code>의 경우 <code>/myservicepath</code>를 경로로 입력하십시오.</li></ul>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 [재작성 어노테이션](cs_annotations.html#rewrite-path)을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
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
    -   IP 주소를 레코드로 추가하여 IBM 제공 Ingress 제어기의 포터블 공인 IP 주소로 사용자 정의 도메인을 맵핑하십시오. Ingress 제어기의 포터블 공인 IP 주소를 찾으려면 다음을 수행하십시오. 
        1.  `bx cs cluster-get <mycluster>`을 실행하고 **Ingress subdomain** 필드를 찾으십시오.
        2.  `nslookup <Ingress subdomain>`을 실행하십시오.
3.  PEM 형식으로 인코딩된 사용자의 도메인에 대한 TLS 인증서 및 키를 작성하십시오. 
4.  TLS 인증서 및 키를 Kubernetes 시크릿에 저장하십시오. 
    1.  선호하는 편집기를 열고 예를 들어, `mysecret.yaml`이라는 이름의 Kubernetes 시크릿 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

    3.  구성 파일을 저장하십시오.
    4.  클러스터에 대한 TLS 시크릿을 작성하십시오. 

        ```
         kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 

6.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다. 

    1.  선호하는 편집기를 열고 예를 들어, `myservice.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
    1.  선호하는 편집기를 열고 예를 들어, `myingress.yaml`이라는 이름의 Ingress 구성 파일을 작성하십시오. 
    2.  사용자 정의 도메인을 사용하여 수신 네트워크 트래픽을 서비스로 라우팅하고 사용자 정의 인증서를 사용하여 TLS 종료를 관리하는 Ingress 리소스를 구성 파일에 정의하십시오. 모든 서비스에 대해 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://mydomain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 앱이 실행 중인 포드에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취하는 것이 중요합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은
특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 `/`로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 [재작성 어노테이션](cs_annotations.html#rewrite-path)을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
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
    1.  선호하는 편집기를 열고 예를 들어, `myexternalendpoint.yaml`이라는 이름의 엔드포인트 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
    1.  선호하는 편집기를 열고 예를 들어, `myexternalservice.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오.
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

3.  IBM 제공 도메인과 TLS 인증서를 확인하십시오. _&lt;mycluster&gt;_를 앱이 배치되는 클러스터의 이름으로 대체하십시오. 

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
    1.  선호하는 편집기를 열고 예를 들어, `myexternalingress.yaml`이라는 이름의 Ingress 구성 파일을 작성하십시오. 
    2.  이전에 정의한 외부 엔드포인트를 사용하여 수신 네트워크 트래픽을 사용자의 외부 앱으로 라우팅하기 위한 IBM 제공 도메인 및 TLS 인증서를 사용하는 Ingress 리소스를 구성 파일에 정의하십시오. 모든 서비스에 대해 IBM 제공 또는 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://ingress_domain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 외부 앱에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취하는 것이 중요합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은
특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 /로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 [재작성 어노테이션](cs_annotations.html#rewrite-path)을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
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



#### Ingress 로드 밸런서에서 포트 열기
{: #opening_ingress_ports}

기본적으로 포트 80과 443만 Ingress 로드 밸런서에 노출됩니다. 다른 포트를 노출하려면 ibm-cloud-provider-ingress-cm 구성 맵 리소스를 편집할 수 있습니다.

1.  ibm-cloud-provider-ingress-cm 구성 맵 리소스에 대한 로컬 버전의 구성 파일을 작성하십시오. <code>data</code> 섹션을 추가하고 공용 포트 80, 443 및 세미콜론(;)으로 구분된 구성 맵 파일에 추가할 다른 모든 포트를 지정하십시오.

 참고: 포트를 지정하는 경우 80과 443도 열린 상태를 유지하도록 포함되어야 합니다. 지정되지 않은 포트는 닫힙니다.

 ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

 예:
 ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```

2. 구성 파일을 적용하십시오.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. 구성 파일이 적용되었는지 확인하십시오.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 출력:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

구성 맵 리소스에 대한 자세한 정보는 [Kubernetes 문서](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/)를 참조하십시오.



#### HTTP 레벨에서 SSL 프로토콜과 SSL 암호 구성
{: #ssl_protocols_ciphers}

`ibm-cloud-provider-ingress-cm` 구성 맵을 편집하여 글로벌 HTTP 레벨에서 SSL 프로토콜과 암호를 사용으로 설정하십시오.

기본적으로 다음 값이 ssl-protocols 및 ssl-ciphers에 사용됩니다.

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

이러한 매개변수에 대한 자세한 정보는 [ssl-protocols ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols) 및 [ssl-ciphers ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers)에 대한 NGINX 문서를 참조하십시오.

기본값을 변경하려면 다음을 수행하십시오.
1. ibm-cloud-provider-ingress-cm 구성 맵 리소스에 대한 로컬 버전의 구성 파일을 작성하십시오.

 ```
 apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

2. 구성 파일을 적용하십시오.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. 구성 파일이 적용되었는지 확인하십시오.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 출력:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
 ```
 {: screen}


#### 사설 Ingress 제어기 사용
{: #private_ingress}

표준 클러스터를 작성하면 사설 Ingress 제어기가 자동으로 작성되지만 자동으로 사용되지는 않습니다. 사설 Ingress 제어기를 사용하려면 먼저 사전 지정된 IBM 제공 포터블 사설 IP 주소 또는 고유 포터블 사설 IP 주소를 사용하여 사용으로 설정해야 합니다. **참고**: 클러스터를 작성했을 때 `--no-subnet` 플래그를 사용한 경우, 사설 Ingress 제어기를 사용하려면 먼저 포터블 사설 서브넷 또는 사용자 관리 서브넷을 추가해야 합니다. 자세한 정보는 [클러스터의 추가 서브넷 요청](cs_cluster.html#add_subnet)을 참조하십시오.

시작하기 전에:

-   클러스터가 아직 없으면 [표준 클러스터를 작성](cs_cluster.html#cs_cluster_ui)하십시오. 
-   클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

사전 지정된 IBM 제공 포터블 사설 IP 주소를 사용하여 사설 Ingress 제어기를 사용으로 설정하려면 다음을 수행하십시오.

1. 클러스터에서 사용 가능한 Ingress 제어기를 나열하여 사설 Ingress 제어기의 ALB ID를 가져오십시오. <em>&lt;cluser_name&gt;</em>을 노출할 앱이 배치된 클러스터의 이름으로 대체하십시오.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    사설 Ingress 제어기의 **상태** 필드는 _disabled_입니다.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. 사설 Ingress 제어기를 사용으로 설정하십시오. 이전 단계의 출력에서 <em>&lt;private_ALB_ID&gt;</em>를 사설 Ingress 제어기의 ALB ID로 대체하십시오.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


고유 포터블 사설 IP 주소를 사용하여 사설 Ingress 제어기를 사용으로 설정하려면 다음을 수행하십시오.

1. 클러스터의 사설 VLAN에서 트래픽을 라우팅하도록 선택된 IP 주소의 사용자 관리 서브넷을 구성하십시오. <em>&lt;cluser_name&gt;</em>을 노출할 앱이 배치된 클러스터의 이름 또는 ID로, <em>&lt;subnet_CIDR&gt;</em>을 사용자 관리 서브넷의 CIDR로, <em>&lt;private_VLAN&gt;</em>을 사용 가능한 사설 VLAN ID로 대체하십시오. `bx cs vlans`를 실행하여 사용 가능한 사설 VLAN의 ID를 찾을 수 있습니다.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. 클러스터에서 사용 가능한 Ingress 제어기를 나열하여 사설 Ingress 제어기의 ALB ID를 가져오십시오.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    사설 Ingress 제어기의 **상태** 필드는 _disabled_입니다.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. 사설 Ingress 제어기를 사용으로 설정하십시오. 이전 단계의 출력에서 <em>&lt;private_ALB_ID&gt;</em>를 사설 Ingress 제어기의 ALB ID로 대체하고 <em>&lt;user_ip&gt;</em>를 사용할 사용자 관리 서브넷의 IP 주소로 대체하십시오.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

#### 사용자 정의 도메인에서 사설 Ingress 제어기 사용
{: #private_ingress_no_tls}

사용자 정의 도메인을 사용하여 수신 네트워크 트래픽을 클러스터의 앱으로 라우팅하도록 사설 Ingress 제어기를 구성할 수 있습니다.
{:shortdesc}

시작하기 전에 [사설 Ingress 제어기를 사용으로 설정](#private_ingress)하십시오.

사설 Ingress 제어기를 구성하려면 다음을 수행하십시오.

1.  사용자 정의 도메인을 작성하십시오. 사용자 정의 도메인을 작성하려면 도메인 이름 서비스(DNS) 제공업체를 찾아서 사용자 정의 도메인을 등록하십시오. 

2.  IP 주소를 레코드로 추가하여 IBM 제공 사설 Ingress 제어기의 포터블 사설 IP 주소로 사용자 정의 도메인을 맵핑하십시오. 사설 Ingress 제어기의 포터블 사설 IP 주소를 찾으려면 `bx cs albs --cluster<cluster_name>`를 실행하십시오.

3.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 

4.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. 사설 Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다.

    1.  선호하는 편집기를 열고 예를 들어, `myservice.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

    5.  사설 네트워크로 노출할 모든 앱에 대해 이러한 단계를 반복하십시오.
7.  Ingress 리소스를 작성하십시오. Ingress 리소스는 앱용으로 작성된 Kubernetes 서비스에 대한 라우팅 규칙을 정의하며, 수신 네트워크 트래픽을 서비스로 라우팅하기 위해 Ingress 제어기에 의해 사용됩니다. 클러스터 내에서 Kubernetes 서비스를 통해 모든 앱이 노출되는 한, 하나의 Ingress 리소스를 사용하여 다중 앱에 대한 라우팅 규칙을 정의할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들어, `myingress.yaml`이라는 이름의 Ingress 구성 파일을 작성하십시오. 
    2.  사용자 정의 도메인을 사용하여 수신 네트워크 트래픽을 사용자 서비스로 라우팅하는 Ingress 리소스를 구성 파일에 정의하십시오. 모든 서비스에 대해 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://mydomain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 앱이 실행 중인 포드에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취하는 것이 중요합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은
특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 `/`로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em>을 Ingress 리소스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td><em>&lt;private_ALB_ID&gt;</em>를 사설 Ingress 제어기의 ALB ID로 대체하십시오. <code>bx cs albs --cluster <my_cluster></code>를 실행하여 ALB ID를 찾으십시오.</td>
        </tr>
        <td><code>host</code></td>
        <td><em>&lt;mycustomdomain&gt;</em>을 사용자 정의 도메인으로 대체하십시오. 

        </br></br>
        <strong>참고:</strong> Ingress 작성 중에 실패하지 않으려면 호스트에 &ast;를 사용하거나 호스트 특성을 비워 두지 마십시오. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>네트워크 트래픽이 앱으로 전달될 수 있도록 <em>&lt;myservicepath1&gt;</em>을 슬래시 또는 앱이 청취 중인 고유 경로로 대체하십시오. 

        </br>
        모든 Kubernetes 서비스의 경우, 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 대한 고유 경로(예: <code>custom_domain/myservicepath1</code>)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾은 후에 네트워크 트래픽을 해당 서비스에, 그리고 동일한 경로를 사용하여 앱이 실행 중인 포드에 전송합니다. 수신 네트워크 트래픽을 수신하려면 이 경로에서 청취하도록 앱을 설정해야 합니다. 

        </br>
         많은 앱은 특정 경로에서 청취하지는 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 <code>/</code>로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        </br></br>
        예:<ul><li><code>https://mycustomdomain/</code>의 경우 <code>/</code>를 경로로 입력하십시오. </li><li><code>https://mycustomdomain/myservicepath</code>의 경우 <code>/myservicepath</code>를 경로로 입력하십시오.</li></ul>
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 [재작성 어노테이션](cs_annotations.html#rewrite-path)을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
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

8.  Ingress 리소스가 작성되었는지 확인하십시오. <em>&lt;myingressname&gt;</em>을 이전 단계에서 작성한 Ingress 리소스의 이름으로 대체하십시오.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **참고:** Ingress 리소스가 올바르게 작성되고 앱을 사용할 수 있으려면 몇 초가 걸릴 수 있습니다.

9.  인터넷에서 앱에 액세스하십시오. 
    1.  선호하는 웹 브라우저를 여십시오. 
    2.  액세스하려는 앱 서비스의 URL을 입력하십시오. 

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

#### 사용자 정의 도메인 및 TLS 인증서와 함께 사설 Ingress 제어기 사용
{: #private_ingress_tls}

사용자 정의 도메인을 사용하는 동안 수신 네트워크 트래픽을 클러스터의 앱으로 라우팅하도록 사설 Ingress 제어기를 구성하고 고유 TLS 인증서를 사용하여 TLS 종료를 관리할 수 있습니다.
{:shortdesc}

시작하기 전에 [사설 Ingress 제어기를 사용으로 설정](#private_ingress)하십시오.

Ingress 제어기를 구성하려면 다음을 수행하십시오. 

1.  사용자 정의 도메인을 작성하십시오. 사용자 정의 도메인을 작성하려면 도메인 이름 서비스(DNS) 제공업체를 찾아서 사용자 정의 도메인을 등록하십시오. 

2.  IP 주소를 레코드로 추가하여 IBM 제공 사설 Ingress 제어기의 포터블 사설 IP 주소로 사용자 정의 도메인을 맵핑하십시오. 사설 Ingress 제어기의 포터블 사설 IP 주소를 찾으려면 `bx cs albs --cluster<cluster_name>`를 실행하십시오.

3.  PEM 형식으로 인코딩된 사용자의 도메인에 대한 TLS 인증서 및 키를 작성하십시오. 

4.  TLS 인증서 및 키를 Kubernetes 시크릿에 저장하십시오. 
    1.  선호하는 편집기를 열고 예를 들어, `mysecret.yaml`이라는 이름의 Kubernetes 시크릿 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

    3.  구성 파일을 저장하십시오.
    4.  클러스터에 대한 TLS 시크릿을 작성하십시오. 

        ```
         kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [클러스터에 앱을 배치하십시오](#cs_apps_cli). 클러스터에 앱을 배치하면 컨테이너에서 앱을 실행하는 사용자에 대한 하나 이상의 포드가 작성됩니다. 구성 파일의 메타데이터 섹션에서 배치에 레이블을 추가했는지 확인하십시오. 이 레이블은 Ingress 로드 밸런싱에 포함될 수 있도록 앱이 실행 중인 모든 포드를 식별하는 데 필요합니다. 

6.  노출할 앱에 대한 Kubernetes 서비스를 작성하십시오. 사설 Ingress 제어기는 클러스터 내에서 Kubernetes 서비스를 통해 앱이 노출된 경우에만 앱을 Ingress 로드 밸런싱에 포함할 수 있습니다.

    1.  선호하는 편집기를 열고 예를 들어, `myservice.yaml`이라는 이름의 서비스 구성 파일을 작성하십시오. 
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

    5.  사설 네트워크에 노출할 모든 앱에 대해 이러한 단계를 반복하십시오.
7.  Ingress 리소스를 작성하십시오. Ingress 리소스는 앱용으로 작성된 Kubernetes 서비스에 대한 라우팅 규칙을 정의하며, 수신 네트워크 트래픽을 서비스로 라우팅하기 위해 Ingress 제어기에 의해 사용됩니다. 클러스터 내에서 Kubernetes 서비스를 통해 모든 앱이 노출되는 한, 하나의 Ingress 리소스를 사용하여 다중 앱에 대한 라우팅 규칙을 정의할 수 있습니다. 
    1.  선호하는 편집기를 열고 예를 들어, `myingress.yaml`이라는 이름의 Ingress 구성 파일을 작성하십시오. 
    2.  사용자 정의 도메인을 사용하여 수신 네트워크 트래픽을 서비스로 라우팅하고 사용자 정의 인증서를 사용하여 TLS 종료를 관리하는 Ingress 리소스를 구성 파일에 정의하십시오. 모든 서비스에 대해 사용자 정의 도메인에 추가된 개별 경로를 정의하여 사용자의 앱에 고유 경로(예: `https://mydomain/myapp`)를 작성할 수 있습니다. 이 라우트를 웹 브라우저에 입력하면 네트워크 트래픽이 Ingress 제어기로 라우팅됩니다. Ingress 제어기는 연관된 서비스를 찾아서 그 서비스에 네트워크 트래픽을 보내고 나서는 앱이 실행 중인 포드에 보냅니다. 

        **참고:** Ingress 리소스에 정의한 경로에서 앱이 청취하는 것이 중요합니다. 그렇지 않으면 네트워크 트래픽이 앱으로 전달될 수 없습니다. 대부분의 앱은 특정 경로에서 청취하지 않지만 루트 경로와 특정 포트를 사용합니다. 이 경우에는 루트 경로를 `/`로 정의하고 앱에 대한 개별 경로를 지정하지 마십시오. 

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
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
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em>을 Ingress 리소스의 이름으로 대체하십시오. </td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td><em>&lt;private_ALB_ID&gt;</em>를 사설 Ingress 제어기의 ALB ID로 대체하십시오. <code>bx cs albs --cluster <my_cluster></code>를 실행하여 ALB ID를 찾으십시오.</td>
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
        <td><em>&lt;mycustomdomain&gt;</em>을 TLS 종료를 위해 구성하려는 사용자 정의 도메인으로 대체하십시오. 

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
        <strong>팁:</strong> 앱이 청취하는 경로와는 다른 경로에서 청취하도록 Ingress를 구성하고자 하는 경우에는 [재작성 어노테이션](cs_annotations.html#rewrite-path)을 사용하여 앱에 대한 적절한 라우팅을 설정할 수 있습니다. </td>
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

8.  Ingress 리소스가 작성되었는지 확인하십시오. <em>&lt;myingressname&gt;</em>을 이전에 작성한 Ingress 리소스의 이름으로 대체하십시오. 

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **참고:** Ingress 리소스가 올바르게 작성되고 앱을 사용할 수 있으려면 몇 초가 걸릴 수 있습니다.

9.  인터넷에서 앱에 액세스하십시오. 
    1.  선호하는 웹 브라우저를 여십시오. 
    2.  액세스하려는 앱 서비스의 URL을 입력하십시오. 

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

## IP 주소 및 서브넷 관리
{: #cs_cluster_ip_subnet}

포터블 공인 및 사설 서브넷과 IP 주소를 사용하여 앱을 클러스터에 노출시켜 인터넷 또는 사설 네트워크에서 액세스 가능하도록 설정할 수 있습니다. {:shortdesc}

{{site.data.keyword.containershort_notm}}에서 사용자는 클러스터에 네트워크 서브넷을 추가하여 Kubernetes 서비스에 대한 안정적인 포터블 IP를 추가할 수 있습니다. 표준 클러스터를 작성하면 {{site.data.keyword.containershort_notm}}에서 포터블 공인 서브넷에 5개의 포터블 공인 IP 주소를, 포터블 사설 서브넷에 5개의 포터블 사설 IP 주소를 자동으로 프로비저닝합니다. 포터블 IP 주소는 정적이며 작업자 노드 또는 클러스터가 제거되더라도 변경되지 않습니다. 

 포터블 IP 주소 중 2개(하나는 공인, 하나는 사설)는 클러스터에서 다중 앱을 노출하는 데 사용할 수 있는 [Ingress 제어기](#cs_apps_public_ingress)에 사용됩니다. [로드 밸런서 서비스를 작성](#cs_apps_public_load_balancer)하여 앱을 노출시키는 데 4개의 포터블 공인 IP 주소와 4개의 포터블 사설 IP 주소를 사용할 수 있습니다.

**참고:** 포터블 공인 IP 주소는 매월 비용이 청구됩니다. 클러스터가 프로비저닝된 후에 포터블 공인 IP 주소를 제거하도록 선택한 경우, 비록 짧은 시간 동안만 사용했어도 월별 비용을 계속 지불해야 합니다. 



1.  `myservice.yaml`이라는 이름의 Kubernetes 서비스 구성 파일을 작성하고 더미 로드 밸런서 IP 주소를 사용하여 `LoadBalancer` 유형의 서비스를 정의하십시오. 다음 예는 로드 밸런서 IP 주소로 IP 주소 1.1.1.1을 사용합니다.  

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




1.  `myservice.yaml`이라는 이름의 Kubernetes 서비스 구성 파일을 작성하고 더미 로드 밸런서 IP 주소를 사용하여 `LoadBalancer` 유형의 서비스를 정의하십시오. 다음 예는 로드 밸런서 IP 주소로 IP 주소 1.1.1.1을 사용합니다.  

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

### 사용된 IP 주소 해제
{: #freeup_ip}

포터블 IP 주소를 사용 중인 로드 밸런서 서비스를 삭제하여 사용된 포터블 공인 IP 주소를 해제할 수 있습니다. 

[시작하기 전에, 사용할 클러스터의 컨텍스트를 설정하십시오.](cs_cli_install.html#cs_cli_configure)

1.  클러스터에서 사용 가능한 서비스를 나열하십시오. 

    ```
     kubectl get services
    ```
    {: pre}

2.  공인 또는 사설 IP 주소를 사용하는 로드 밸런서 서비스를 제거하십시오. 

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## GUI로 앱 배치
{: #cs_apps_ui}

Kubernetes 대시보드를 사용하여 클러스터에 앱을 배치하는 경우, 클러스터에서 포드를 작성하고 업데이트 및 관리하는 배치 리소스가 자동으로 작성됩니다.
{:shortdesc}

시작하기 전에:

-   필수 [CLI](cs_cli_install.html#cs_cli_install)를 설치하십시오. 
-   클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

앱을 배치하려면 다음을 수행하십시오. 

1.  [Kubernetes 대시보드를 여십시오](#cs_cli_dashboard).
2.  Kubernetes 대시보드에서 **+ 작성**을 클릭하십시오. 
3.  **아래의 앱 세부사항 지정**을 선택하여 GUI에서 앱 세부사항을 입력하거나, **YAML 또는 JSON 파일 업로드**를 선택하여 앱 [구성 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)을 업로드하십시오. 미국 남부 지역의 **ibmliberty** 이미지에서 컨테이너를 배포하려면 [이 예제 YAML 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml)을 사용하십시오. 
4.  Kubernetes 대시보드에서 **배치**를 클릭하여 배치가 작성되었는지 확인하십시오. 
5.  노드 포트 서비스, 로드 밸런서 서비스 또는 Ingress를 사용하여 앱을 공용으로 사용 가능하게 한 경우 앱에 액세스할 수 있는지 확인하십시오. 

<br />


## CLI로 앱 배치
{: #cs_apps_cli}

클러스터가 작성된 후에 Kubernetes CLI를 사용하여 해당 클러스터에 앱을 배치할 수 있습니다.
{:shortdesc}

시작하기 전에:

-   필수 [CLI](cs_cli_install.html#cs_cli_install)를 설치하십시오. 
-   클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

앱을 배치하려면 다음을 수행하십시오. 

1.  [Kubernetes 우수 사례 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/overview/)를 기반으로 구성 파일을 작성하십시오. 일반적으로, 구성 파일에는 Kubernetes에서 작성 중인 각각의 리소스에 대한 구성 세부사항이 포함되어 있습니다. 스크립트에는 하나 이상의 다음 섹션이 포함될 수 있습니다. 

    -   [배치 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): 포드와 복제본 세트 작성을 정의합니다. 포드에는 개별 컨테이너화된 앱이 포함되며, 복제본 세트는 포드의 다중 인스턴스를 제어합니다. 

    -   [서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/): 작업자 노드나 로드 밸런서 공인 IP 주소 또는 공용 Ingress 라우트를 사용하여 포드에 프론트 엔드 액세스를 제공합니다.

    -   [Ingress ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/ingress/): 공개적으로 앱에 액세스하는 라우트를 제공하는 로드 밸런서 유형을 지정합니다.

2.  클러스터의 컨텍스트에서 구성 파일을 실행하십시오. 

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  노드 포트 서비스, 로드 밸런서 서비스 또는 Ingress를 사용하여 앱을 공용으로 사용 가능하게 한 경우 앱에 액세스할 수 있는지 확인하십시오. 

<br />





## 앱 스케일링
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

애플리케이션에 대한 수요의 변경사항에 응답하고 필요 시에만 리소스를 사용하는 클라우드 애플리케이션을 배치하십시오. Auto-Scaling은 CPU를 기반으로 앱의 인스턴스 수를 자동으로 늘리거나 줄입니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

**참고:** Cloud Foundry 애플리케이션 스케일링에 대한 정보를 찾으십니까? [{{site.data.keyword.Bluemix_notm}}에 대한 IBM Auto-Scaling](/docs/services/Auto-Scaling/index.html)을 확인하십시오.

Kubernetes에서는 [수평 포드 Auto-Scaling ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)을 사용하여 CPU를 기반으로 앱을 스케일링할 수 있습니다.

1.  CLI에서 클러스터에 앱을 배치하십시오. 앱을 배치할 때는 CPU를 요청해야 합니다. 

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>배치하려는 애플리케이션입니다. </td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>컨테이너의 필수 CPU(밀리 코어 단위로 지정됨)입니다. 예: <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>true인 경우, 외부 서비스를 작성합니다. </td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>외부에서 앱이 사용 가능한 포트입니다. </td>
    </tr></tbody></table>

    **참고:** 보다 복잡한 배치를 위해서는 [구성 파일](#cs_apps_cli)을 작성해야 할 수 있습니다.
2.  Horizontal Pod Autoscaler를 작성하고 정책을 정의하십시오. `kubetcl autoscale` 명령으로 작업하는 방법에 대한 자세한 정보는 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale)를 참조하십시오.

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Horizontal Pod Autoscaler에서 유지하는 평균 CPU 사용률(백분율로 지정됨)입니다. </td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>지정된 CPU 사용 백분율을 유지하기 위해 사용되는 배치된 포드의 최소 수입니다. </td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>지정된 CPU 사용 백분율을 유지하기 위해 사용되는 배치된 포드의 최대 수입니다. </td>
    </tr>
    </tbody></table>

<br />


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

<br />


## {{site.data.keyword.Bluemix_notm}} 서비스 추가
{: #cs_apps_service}

암호화된 Kubernetes 시크릿을 사용하여 {{site.data.keyword.Bluemix_notm}} 서비스 세부사항과 신임 정보를 저장하고 서비스와 클러스터 간의 보안 통신을 허용합니다. 클러스터 사용자인 경우에는 포드에 볼륨으로서 마운트하여 이 시크릿에 액세스할 수 있습니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 앱에서 사용하려는 {{site.data.keyword.Bluemix_notm}} 서비스를 클러스터 관리자가 [클러스터에 추가](cs_cluster.html#cs_cluster_service)하게 하십시오.

Kubernetes 시크릿은 사용자 이름, 비밀번호 또는 키와 같은 기밀 정보를 저장하는 안전한 방법입니다. 환경 변수를 사용하거나 Dockerfile에서 직접 기밀 정보를 노출하는 대신 포드에서 실행 중인 컨테이너가 정보에 액세스할 수 있게 하려면 포드에 대한 시크릿 볼륨으로 시크릿을 마운트해야 합니다. 

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
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

이제 {{site.data.keyword.Bluemix_notm}} 서비스 세부사항과 신임 정보에 액세스할 수 있습니다. {{site.data.keyword.Bluemix_notm}} 서비스 관련 작업을 수행하려면, 마운트 디렉토리에서 서비스 시크릿 파일을 찾아서 JSON 컨텐츠를 구문 분석하고 서비스 세부사항을 판별하도록 앱이 구성되어 있는지 확인하십시오. 

<br />


## 지속적 스토리지 작성
{: #cs_apps_volume_claim}

클러스터의 NFS 파일 스토리지를 프로비저닝하는 PVC(persistent volume claim)를 작성합니다. 그런 다음, 포드에 장애가 발생하거나 종료된 경우에도 데이터를 사용할 수 있도록 이 클레임을 포드에 마운트합니다.
{:shortdesc}

 지속적 볼륨을 지원하는 NFS 파일 스토리지는 데이터에 대한 고가용성을 제공할 수 있도록 IBM에서 클러스터링합니다. 


{{site.data.keyword.Bluemix_dedicated_notm}} 계정이 [클러스터에 사용되는](cs_ov.html#setup_dedicated) 경우, 이 태스크를 사용하는 대신 [지원 티켓을 열어야](/docs/support/index.html#contacting-support) 합니다. 티켓을 열어 볼륨의 백업, 볼륨에서의 복구 및 기타 스토리지 기능을 요청할 수 있습니다.


1.  사용 가능한 스토리지 클래스를 검토하십시오. {{site.data.keyword.containerlong}}는 클러스터 관리자가 스토리지 클래스를 작성할 필요가 없도록 8개의 사전 정의된 스토리지 클래스를 제공합니다. `ibmc-file-bronze` 스토리지 클래스는 `default` 스토리지 클래스와 동일합니다.

    ```
     kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file 
    ```
    {: screen}

2.  pvc를 삭제한 후 데이터 및 NFS 파일 공유를 저장할지 여부를 결정하십시오. 데이터를 보존하려면 `retain` 스토리지 클래스를 선택하십시오. pvc를 삭제할 때 데이터 및 파일 공유가 삭제되도록 하려면 `retain`이 없는 스토리지 클래스를 선택하십시오.

3.  사용 가능한 스토리지 크기 및 스토리지 클래스의 IOPS를 검토하십시오. 
    - 브론즈, 실버 및 골드 스토리지 클래스는 Endurance 스토리지를 사용하며 각 클래스마다 GB당 하나의 정의된 IOPS를 보유합니다. 총 IOPS는 스토리지의 크기에 따라 다릅니다. 예를 들어, GB당 4IOPS의 1000Gi pvc에는 총 4000IOPS가 있습니다.

    ```
     kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    **매개변수** 필드는 스토리지 클래스와 연관된 GB당 IOPS 및 사용 가능한 크기(기가바이트 단위)를 제공합니다. 

    ```
     Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

    - 사용자 정의 스토리지 클래스는 [Performance 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/performance-storage)를 사용하며 총 IOPS 및 크기에 대한 별도의 옵션을 가집니다. 

    ```
    kubectl describe storageclasses ibmc-file-retain-custom 
    ```
    {: pre}

    **매개변수** 필드는 스토리지 클래스와 연관된 IOPS 및 사용 가능한 크기(기가바이트 단위)를 제공합니다. 예를 들어, 40Gi pvc는 100 - 2000IOPS 범위에 있는 100의 배수인 IOPS를 선택할 수 있습니다. 

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  지속적 볼륨 클레임을 정의하는 구성 파일을 작성하고 해당 구성을 `.yaml` 파일로 저장하십시오.

    브론즈, 실버, 골드 클래스에 대한 예제:

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

    사용자 정의 클래스에 대한 예제:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>지속적 볼륨 클레임의 이름을 입력하십시오. </td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>지속적 볼륨에 대한 스토리지 클래스를 정의하십시오.
      <ul>
      <li>ibmc-file-bronze/ibmc-file-retain-bronze: GB당 2IOPS</li>
      <li>ibmc-file-silver/ibmc-file-retain-silver: GB당 4IOPS</li>
      <li>ibmc-file-gold/ibmc-file-retain-gold: GB당 10IOPS</li>
      <li>ibmc-file-custom/ibmc-file-retain-custom: 다중 IOPS 값이 사용 가능합니다.

    </li> 스토리지 클래스를 지정하지 않으면 브론즈 스토리지 클래스로 지속적 볼륨이 작성됩니다. </td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> 나열된 크기 이외의 크기를 선택하면 해당 크기가 올림됩니다. 최대 크기보다 더 큰 크기를 선택하는 경우에는 내림됩니다. </td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>이 옵션은 ibmc-file-custom/ibmc-file-retain-custom에만 해당됩니다. 스토리지에 대한 총 IOPS를 지정하십시오. 모든 옵션을 보려면 `kubectl describe storageclasses ibmc-file-custom`을 실행하십시오. 나열된 것과 이외의 IOPS를 선택하면 IOPS가 올림됩니다.</td>
    </tr>
    </tbody></table>

5.  지속적 볼륨 클레임을 작성하십시오. 

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  지속적 볼륨 클레임이 작성되고 지속적 볼륨에 바인드되었는지 확인하십시오. 이 프로세스는 몇 분 정도 소요됩니다. 

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    출력은 다음과 같이 표시됩니다. 

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

6.  {: #cs_apps_volume_mount}지속적 볼륨 클레임을 포드에 마운트하려면 구성 파일을 작성하십시오. 구성을 `.yaml` 파일로 저장하십시오. 

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
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
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

8.  포드를 작성하고 지속적 볼륨 클레임을 포드에 마운트하십시오. 

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  볼륨이 포드에 정상적으로 마운트되었는지 확인하십시오. 

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

<br />


## 지속적 스토리지에 루트가 아닌 사용자 액세스 추가
{: #cs_apps_volumes_nonroot}

루트가 아닌 사용자에게는 NFS 지원 스토리지의 볼륨 마운트 경로에 대한 쓰기 권한이 없습니다. 쓰기 권한을 부여하려면, 이미지의 Dockerfile을 편집하여 올바른 권한으로 마운트 경로에서 디렉토리를 작성해야 합니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

볼륨에 대한 쓰기 권한이 필요한 비루트 사용자로 앱을 디자인하는 경우, 다음 프로세스를 Dockerfile 및 시작점 스크립트에 추가해야 합니다. 

-   비루트 사용자를 작성하십시오. 
-   임시로 사용자를 루트 그룹에 추가하십시오. 
-   올바른 사용자 권한으로 볼륨 마운트 경로에서 디렉토리를 작성하십시오. 

{{site.data.keyword.containershort_notm}}의 경우 볼륨 마운트 경로의 기본 소유자는 `nobody` 소유자입니다. NFS 스토리지에서 소유자가 포드의 로컬에 없으면 `nobody` 사용자가 작성됩니다. 볼륨은 컨테이너의 루트 사용자를 인식하도록 설정됩니다. 일부 앱에서는 이 사용자가 컨테이너의 유일한 사용자입니다. 그러나 다수의 앱에서는 `nobody`가 아니라 컨테이너 마운트 경로에 쓰는 루트가 아닌 사용자를 지정합니다. 일부 앱은 루트 사용자가 볼륨을 소유하도록 지정합니다. 일반적으로 앱은 보안 문제로 인해 루트 사용자를 사용하지 않습니다. 하지만 앱에 루트 사용자가 필요한 경우 도움을 받기 위해 [{{site.data.keyword.Bluemix_notm}} 지원](/docs/support/index.html#contacting-support)에 문의할 수 있습니다.


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

8.  볼륨을 마운트하고 루트가 아닌 이미지에서 포드를 실행하기 위한 구성 파일을 작성하십시오. 볼륨 마운트 경로 `/mnt/myvol`은 Dockerfile에 지정된 마운트 경로와 일치합니다. 구성을 `.yaml` 파일로 저장하십시오. 

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
