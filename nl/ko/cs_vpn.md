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

# VPN 연결 설정
{: #vpn}

VPN 연결을 통해 Kubernetes 클러스터의 앱을 온프레미스 네트워크에 안전하게 연결할 수 있습니다. 클러스터 내에서 실행 중인 앱에 클러스터 외부의 앱을 연결할 수도 있습니다.
{:shortdesc}

## Strongswan IPSec VPN 서비스 Helm 차트로 VPN 연결 설정
{: #vpn-setup}

VPN 연결을 설정하려면 Helm 차트를 사용하여 Kubernetes 포드 내에 [Strongswan IPSec VPN 서비스 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.strongswan.org/)를 구성하고 배치할 수 있습니다. 그러면 모든 VPN 트래픽은 이 포드를 통해 라우팅됩니다. Strongswan 차트를 설정하는 데 사용되는 Helm 명령에 대한 자세한 정보는 <a href="https://docs.helm.sh/helm/" target="_blank">Helm 문서 <img src="../icons/launch-glyph.svg" alt="외부 링크 아이콘"></a>를 참조하십시오.
{:shortdesc}

시작하기 전에:

- [표준 클러스터를 작성하십시오.
](cs_clusters.html#clusters_cli)
- [기존 클러스터를 사용 중인 경우 버전 1.7.4 이상으로 업데이트하십시오. ](cs_cluster_update.html#master)
- 클러스터에는 하나 이상의 사용 가능한 공인 로드 밸런서 IP 주소가 있어야 합니다.
- [Kubernetes CLI를 클러스터에 대상으로 지정하십시오](cs_cli_install.html#cs_cli_configure).

Strongswan으로 VPN 연결을 설정하려면 다음을 수행하십시오.

1. 아직 사용되지 않은 경우, 클러스터를 위해 Helm을 설치하고 초기화하십시오.

    1. <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="외부 링크 아이콘"></a>를 설치하십시오. 

    2. Helm을 초기화하고 `tiller`를 설치하십시오.

        ```
        helm init
        ```
        {: pre}

    3. `tiller-deploy` 포드가 클러스터에서 `Running` 상태인지 확인하십시오.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        출력 예:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. {{site.data.keyword.containershort_notm}} Helm 저장소를 Helm 인스턴스에 추가하십시오.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Strongswan 차트가 Helm 저장소에 나열되는지 확인하십시오.

        ```
        helm search bluemix
        ```
        {: pre}

2. Strongswan Helm 차트를 위한 기본 구성 설정을 로컬 YAML 파일에 저장하십시오.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. `config.yaml` 파일을 열고 원하는 VPN 구성에 따라 기본값을 다음과 같이 변경하십시오. 특성에 선택 가능한 특정 값이 있으면 해당 값이 파일의 개별 특성 위의 주석에 나열됩니다. **중요**: 특성을 변경할 필요가 없는 경우 해당 특성 앞에 `#`를 놓아서 주석 처리하십시오.

    <table>
    <caption>YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>사용할 기존 <code>ipsec.conf</code> 파일이 있는 경우, 중괄호(<code>{}</code>)를 제거하고 이 특성 뒤에 파일의 컨텐츠를 추가하십시오. 파일 컨텐츠는 들여써야 합니다. **참고:** 고유의 파일을 사용하는 경우, <code>ipsec</code>, <code>local</code> 및 <code>remote</code> 섹션의 값은 사용되지 않습니다.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>사용할 기존 <code>ipsec.secrets</code> 파일이 있는 경우, 중괄호(<code>{}</code>)를 제거하고 이 특성 뒤에 파일의 컨텐츠를 추가하십시오. 파일 컨텐츠는 들여써야 합니다. **참고:** 고유의 파일을 사용하는 경우, <code>preshared</code> 섹션의 값은 사용되지 않습니다.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>온프레미스 VPN 터널 엔드포인트가 연결 초기화를 위한 프로토콜로 <code>ikev2</code>를 지원하지 않는 경우, 이 값을 <code>ikev1</code>로 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>온프레미스 VPN 터널 엔드포인트가 연결에 사용하는 ESP 암호화/인증 알고리즘의 목록으로 이 값을 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>온프레미스 VPN 터널 엔드포인트가 연결에 사용하는 IKE/ISAKMP SA 암호화/인증 알고리즘의 목록으로 이 값을 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>클러스터가 VPN 연결을 시작하도록 하려면 이 값을 <code>start</code>로 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>VPN 연결을 통해 온프레미스 네트워크에 노출되어야 하는 클러스터 서브넷 CIDR의 목록으로 이 값을 변경하십시오. 이 목록은 다음 서브넷을 포함할 수 있습니다. <ul><li>Kubernetes 포드 서브넷 CIDR: <code>172.30.0.0/16</code></li><li>Kubernetes 서비스 서브넷 CIDR: <code>172.21.0.0/16</code></li><li>사설 네트워크에서 NodePort 서비스가 노출한 애플리케이션이 있는 경우, 작업자 노드의 사설 서브넷 CIDR입니다. 이 값을 찾으려면 <code>bx cs subnets | grep <xxx.yyy.zzz></code>를 실행하십시오. 여기서 &lt;xxx.yyy.zzz&gt;는 작업자 노드 사설 IP 주소의 처음 세 옥텟입니다.</li><li>사설 네트워크에서 LoadBalancer 서비스가 노출한 애플리케이션이 있는 경우, 클러스터의 사설 또는 사용자 관리 서브넷 CIDR입니다. 이러한 값을 찾으려면 <code>bx cs cluster-get <cluster name> --showResources</code>를 실행하십시오. <b>VLANS</b> 섹션에서 <b>Public</b> 값이 <code>false</code>인 CIDR을 찾으십시오.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>VPN 터널 엔드포인트가 연결에 사용하는 로컬 Kubernetes 클러스터 측 문자열 ID로 이 값을 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>온프레미스 VPN 게이트웨이의 공인 IP 주소로 이 값을 변경하십시오.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Kubernetes 클러스터가 액세스하도록 허용된 온프레미스 사설 서브넷 CIDR의 목록으로 이 값을 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>VPN 터널 엔드포인트가 연결에 사용하는 원격 온프레미스 측 문자열 ID로 이 값을 변경하십시오.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>온프레미스 VPN 터널 엔드포인트 게이트웨이가 연결에 사용하는 사전 공유된 시크릿으로 이 값을 변경하십시오.</td>
    </tr>
    </tbody></table>

4. 업데이트된 `config.yaml` 파일을 저장하십시오.

5. 업데이트된 `config.yaml` 파일로 Helm 차트를 클러스터에 설치하십시오. 업데이트된 특성은 차트의 구성 맵에 저장됩니다.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. 차트 배치 상태를 확인하십시오. 차트가 준비 상태인 경우, 출력의 맨 위 근처에 있는 **STATUS** 필드의 값은 `DEPLOYED`입니다.

    ```
    helm status vpn
    ```
    {: pre}

7. 차트가 배치된 후 `config.yaml` 파일에서 업데이트된 설정이 사용되었는지 확인하십시오.

    ```
    helm get values vpn
    ```
    {: pre}

8. 새 VPN 연결을 테스트하십시오.
    1. 온프레미스 게이트웨이에서 VPN이 활성이 아닌 경우 VPN을 시작하십시오.

    2. `STRONGSWAN_POD` 환경 변수를 설정하십시오.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. VPN의 상태를 확인하십시오. `ESTABLISHED` 상태는 VPN 연결이 성공임을 의미합니다.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        출력 예:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **참고**:
          - 이 Helm 차트를 처음 사용하는 경우 VPN의 상태는 `ESTABLISHED`가 아닐 가능성이 높습니다. 연결이 성공하기 전에 온프레미스 VPN 엔드포인트 설정을 확인하고 3단계로 돌아가서 `config.yaml` 파일을 여러 번 변경해야 할 수도 있습니다.
          - VPN 포드가 `ERROR` 상태이거나 계속 충돌하고 다시 시작되는 경우, 차트 구성 맵에 있는 `ipsec.conf` 설정의 매개변수 유효성 검증 때문일 수 있습니다. 이 경우에 해당하는지 확인하려면 `kubectl logs -n kube-system $STRONGSWAN_POD`를 실행하여 Strongswan 포드 로그에서 유효성 검증 오류가 있는지 확인하십시오. 유효성 검증 오류가 있는 경우, `helm delete --purge vpn`을 실행하고 3단계로 돌아가서 `config.yaml` 파일에서 잘못된 값을 수정한 후 4 - 8단계를 반복하십시오. 클러스터에 많은 수의 작업자 로드가 있는 경우에는 `helm delete` 및 `helm install`을 실행하는 대신 `helm upgrade`를 사용하여 변경사항을 더 빠르게 적용할 수도 있습니다.

    4. VPN이 `ESTABLISHED` 상태가 된 후 `ping`으로 연결을 테스트하십시오. 다음 예제는 Kubernetes 클러스터의 VPN 포드에서 온프레미스 VPN 게이트웨이의 사설 IP 주소로 Ping을 전송합니다. 구성 파일에 올바른 `remote.subnet` 및 `local.subnet`이 지정되었는지 확인하고 로컬 서브넷 목록에 Ping을 전송 중인 소스 IP 주소가 포함되었는지 확인하십시오.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### Strongswan IPSec VPN 서비스 사용 안함
{: vpn_disable}

1. Helm 차트를 삭제하십시오.

    ```
    helm delete --purge vpn
    ```
    {: pre}
