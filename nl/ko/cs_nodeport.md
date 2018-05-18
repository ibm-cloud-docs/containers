---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

Kubernetes 클러스터에서 작업자 노드의 공인 IP 주소를 사용하고 노드 포트를 노출하여 인터넷 액세스를 통해 컨테이너화된 앱이 사용 가능하게 하십시오. {{site.data.keyword.containerlong}} 테스트 및 단기적 공용 액세스 용도로만 이 옵션을 사용하십시오.
{:shortdesc}

## NodePort 서비스로 외부 네트워킹 계획
{: #planning}

작업자 노드에서 공용 포트를 노출하고, 작업자 노드의 공인 IP 주소를 사용하여 인터넷을 통해 클러스터의 서비스에 공용으로 액세스하십시오.
{:shortdesc}

NodePort 유형의 Kubernetes 서비스를 작성하여 앱을 노출하면 30000 - 32767 범위의 NodePort 및 내부 클러스터 IP 주소가 서비스에 지정됩니다. NodePort 서비스는 앱의 수신 요청에 대한 외부 시작점 역할을 합니다. 지정된 NodePort는 클러스터에 있는 각 작업자 노드의 kubeproxy 설정에서 공용으로 노출됩니다. 모든 작업자 노드는 지정된 NodePort에서 서비스의 수신 입력을 청취하기 시작합니다. 인터넷에서 서비스에 액세스하기 위해, 사용자는 `<ip_address>:<nodeport>` 형식의 NodePort 및 클러스터 작성 중에 지정된 작업자 노드의 공인 IP 주소를 사용할 수 있습니다. 공인 IP 주소 이외에 작업자 노드의 사설 IP 주소를 통해 NodePort 서비스를 사용할 수 있습니다.

다음 다이어그램은 NodePort 서비스가 구성될 때 인터넷에서 앱으로 통신이 이루어지는 방식을 표시합니다.

<img src="images/cs_nodeport_planning.png" width="550" alt="NodePort를 사용하여 {{site.data.keyword.containershort_notm}}에서 앱 노출" style="width:550px; border-style: none"/>

1. 작업자 노드에서 NodePort와 작업자 노드의 공인 IP 주소를 사용하여 앱에 요청을 전송합니다. 

2. 요청은 자동으로 NodePort 서비스의 내부 클러스터 IP 주소 및 포트로 전달됩니다. 내부 클러스터 IP 주소는 클러스터 내에서만 액세스가 가능합니다. 

3. `kube-proxy`는 앱의 Kubernetes NodePort 서비스에 대한 요청을 라우팅합니다. 

4. 앱이 배치된 포드의 사설 IP 주소로 요청이 전달됩니다. 다중 앱 인스턴스가 클러스터에 배치되는 경우 NodePort 서비스는 앱 포드 간의 요청을 라우팅합니다. 

**참고:** 작업자 노드의 공인 IP 주소는 영구적이지 않습니다. 작업자 노드가 제거되거나 다시 작성되면 새 공인 IP 주소가 작업자 노드에 지정됩니다. 앱에 대한 공용 액세스를 테스트하기 위해 또는 짧은 시간 동안에만 공용 액세스가 필요한 경우에 NodePort 서비스를 사용할 수 있습니다. 서비스에 대한 추가 가용성과 안정적인 공인 IP 주소가 필요한 경우에는 [LoadBalancer 서비스](cs_loadbalancer.html#planning) 또는 [Ingress](cs_ingress.html#planning)를 사용하여 앱을 노출하십시오.

<br />


## NodePort 서비스를 사용하여 앱에 대한 공용 액세스 구성
{: #config}

무료 또는 표준 클러스터에 대해 Kubernetes NodePort 서비스로서 앱을 노출할 수 있습니다.
{:shortdesc}

앱이 아직 없는 경우, [Guestbook ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml)이라는 Kubernetes 예제 앱을 사용할 수 있습니다.

1.  앱의 구성 파일에서 [서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/service/) 섹션을 정의하십시오. **참고**: Guestbook 예제의 경우, 구성 파일에 프론트 엔드 서비스 섹션이 이미 있습니다. Guestbook 앱을 외부에서 사용하려면 NodePort 유형과 30000 - 32767 범위의 NodePort를 프론트 엔드 서비스 섹션에 추가하십시오.

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
    <td><code><em>&lt;my-nodeport-service&gt;</em></code>를 NodePort 서비스 이름으로 대체합니다.</td>
    </tr>
    <tr>
    <td><code> run</code></td>
    <td><code><em>&lt;my-demo&gt;</em></code>를 배치 이름으로 대체합니다.</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td><code><em>&lt;8081&gt;</em></code>을 서비스가 청취하는 포트로 대체합니다. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>선택사항: <code><em>&lt;31514&gt;</em></code>를 30000 - 32767 범위의 NodePort로 대체합니다. 다른 서비스에서 이미 사용 중인 NodePort는 지정하지 마십시오. NodePort가 지정되지 않으면 사용자를 위해 임의로 지정됩니다.<br><br>NodePort를 지정하며 이미 사용 중인 NodePort를 보려는 경우에는 다음 명령을 실행할 수 있습니다. <pre class="pre"><code>kubectl get svc</code></pre>사용 중인 모든 NodePort가 **Ports** 필드 아래에 표시됩니다.</td>
     </tr>
     </tbody></table>

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
