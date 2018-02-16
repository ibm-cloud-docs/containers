---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# NodePort 서비스 설정
{: #nodeport}

클러스터에서 작업자 노드의 공인 IP 주소를 사용하고 노드 포트를 노출하여 인터넷 액세스를 통해 앱이 사용 가능하게 하십시오. 
테스트 및 단기적 공용 액세스 용도로만 이 옵션을 사용하십시오.
{:shortdesc}

## NodePort 서비스 유형을 사용하여 앱에 대한 공용 액세스 구성
{: #config}

라이트 또는 표준 클러스터에 대해 Kubernetes NodePort 서비스로 앱을 노출할 수 있습니다.
{:shortdesc}

**참고:** 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드를 다시 작성해야 하는 경우에는 새 공인 IP 주소가 작업자 노드에 지정됩니다. 서비스에 대한 추가 가용성과 안정적인 공인 IP 주소가 필요한 경우에는 [LoadBalancer 서비스](cs_loadbalancer.html) 또는 [Ingress](cs_ingress.html)를 사용하여 앱을 노출하십시오.

앱이 아직 없는 경우, [Guestbook ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml)이라는 Kubernetes 예제 앱을 사용할 수 있습니다. 

1.  앱의 구성 파일에서 [서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/) 섹션을 정의하십시오. 

    예:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>이 YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> NodePort 서비스 섹션 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td><code><em>&lt;my-nodeport-service&gt;</em></code>를 NodePort 서비스 이름으로 대체합니다. </td>
    </tr>
    <tr>
    <td><code> run</code></td>
    <td><code><em>&lt;my-demo&gt;</em></code>를 배치 이름으로 대체합니다. </td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td><code><em>&lt;8081&gt;</em></code>을 서비스가 청취하는 포트로 대체합니다. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>선택사항: <code><em>&lt;31514&gt;</em></code>를 30000 - 32767 범위의 NodePort로 대체합니다. 다른 서비스에서 이미 사용 중인 NodePort는 지정하지 마십시오. NodePort가 지정되지 않으면 사용자를 위해 임의로 지정됩니다.<br><br>NodePort를 지정하며 이미 사용 중인 NodePort를 보려는 경우에는 다음 명령을 실행할 수 있습니다. <pre class="pre"><code>kubectl get svc</code></pre>사용 중인 모든 NodePort가 **Ports** 필드 아래에 표시됩니다. </td>
     </tr>
     </tbody></table>


    Guestbook 예제의 경우, 구성 파일에 프론트 엔드 서비스 섹션이 이미 있습니다. Guestbook 앱을 외부에서 사용하려면 NodePort 유형과 30000 - 32767 범위의 NodePort를 프론트 엔드 서비스 섹션에 추가하십시오. 

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  업데이트된 구성 파일을 저장하십시오. 

3.  이러한 단계를 반복하여 인터넷에 노출할 개별 앱의 NodePort 서비스를 작성하십시오. 

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
