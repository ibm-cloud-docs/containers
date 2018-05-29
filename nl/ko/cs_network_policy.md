---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 네트워크 정책 관련 트래픽 제어
{: #network_policies}

모든 Kubernetes 클러스터는 Calico라는 네트워크 플러그인으로 설정됩니다. {{site.data.keyword.containerlong}}에서 모든 작업자 노드의 공용 네트워크 인터페이스 보안을 위해 기본 네트워크 정책이 설정됩니다.
{: shortdesc}

고유 보안 요구사항이 있을 때 Calico 및 기본 Kubernetes 기능을 사용하여 클러스터에 대한 네트워크 정책을 더 구성할 수 있습니다. 이러한 네트워크 정책은 클러스터에서 팟(Pod)에 허용하거나 차단하고자 하는 네트워크 트래픽을 지정합니다. Kubernetes 네트워크 정책을 사용하여 시작할 수 있지만, 더 강력한 기능을 위해서는 Calico 네트워크 정책을 사용하십시오.

<ul>
  <li>[Kubernetes 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): 팟(Pod)이 서로 통신할 수 있는지 지정하는 등의 일부 기본 옵션이 제공됩니다. 프로토콜 및 포트에 대한 수신 네트워크 트래픽을 허용하거나 차단할 수 있습니다. 다른 팟(Pod)에 연결하려고 시도하는 팟(Pod)의 Kubernetes 네임스페이스 및 레이블을 기반으로 이 트래픽을 필터링할 수 있습니다.</br>이러한 정책은
`kubectl` 명령 또는 Kubernetes API를 사용하여 적용될 수 있습니다. 해당 정책이 적용되면
Calico 네트워크 정책으로 변환되고 Calico는 이러한 정책을 시행합니다.</li>
  <li>[Calico 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): 이러한 정책은 Kubernetes 네트워크 정책의 수퍼세트이며 다음 기능으로 기본 Kubernetes 기능을 향상시킵니다.</li>
    <ul><ul><li>Kubernetes 팟(Pod) 트래픽뿐만 아니라 특정 네트워크 인터페이스에서 네트워크 트래픽을 허용하거나 차단합니다.</li>
    <li>수신(ingress) 및 발신(egress) 네트워크 트래픽을 허용하거나 차단합니다.</li>
    <li>[LoadBalancer 또는 NodePort Kubernetes 서비스에 대한 수신(ingress) 트래픽을 차단](#block_ingress)합니다.</li>
    <li>소스 또는 대상 IP 주소 또는 CIDR을 기반으로 하는 트래픽을 허용하거나 차단합니다.</li></ul></ul></br>

이러한 정책은 `calicoctl` 명령을 사용하여 적용됩니다. Calico는
Kubernetes 작업자 노드에서 Linux iptables 규칙을 설정하여 Calico 정책으로 변환된 Kubernetes 네트워크 정책을 포함하는 해당 정책을
시행합니다. Iptables 규칙은 대상으로 지정된 리소스에 전달되도록 네트워크 트래픽이 충족해야 하는 특성을 정의하기 위해
작업자 노드에 대한 방화벽의 역할을 합니다.</ul>

<br />


## 기본 정책 구성
{: #default_policy}

클러스터가 작성되면 공용 인터넷에서 수신 트래픽을 제한하기 위해 기본 네트워크 정책이 각 작업자 노드의 공용 네트워크 인터페이스에 대해 설정됩니다. 이러한 정책은 팟(Pod)에서 팟(Pod) 트래픽에 영향을 미치지 않으며 Kubernetes 노드 포트, 로드 밸런서 및 Ingress 서비스에 대한 액세스를 허용합니다.
{:shortdesc}

기본 정책은 팟(Pod)에 직접 적용되지 않습니다. Calico 호스트 엔드포인트를 사용하여 작업자 노드의 공용 네트워크 인터페이스에 적용됩니다. 호스트 엔드포인트가 Calico에서 작성되면
그 작업자 노드의 네트워크 인터페이스에서 나가고 들어오는 모든 트래픽은 그 트래픽이 정책에서 허용되는 경우를 제외하고 차단됩니다.

**중요:** 정책을 완전히 이해하고 정책에서 허용하고 있는 트래픽이 필요하지 않다는 것을 아는 경우를 제외하고는 호스트 엔드포인트에 적용된 정책을 제거하지 마십시오.


 <table summary="테이블의 첫 번째 행에는 두 개의 열이 있습니다. 나머지 행은 왼쪽에서 오른쪽으로 읽어야 하며 1열에는 서버 위치, 2열에는 일치시킬 IP 주소가 있습니다.">
  <thead>
  <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 각 클러스터의 기본 정책</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>아웃바운드 트래픽을 모두 허용합니다.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>bigfix 앱에 대한 포트 52311의 수신 트래픽이 가능하게 하여 필수 작업자 노드 업데이트를 허용합니다.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>수신 icmp 패킷(ping)을 허용합니다.</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>해당 서비스가 노출된 팟(Pod)에 수신 노드 포트, 로드 밸런서 및 Ingress 서비스 트래픽을 허용합니다. Kubernetes는 해당 서비스 요청을 올바른 팟(Pod)에 전달하기 위해 대상 네트워크 주소 변환(DNAT)을
사용하기 때문에 해당 서비스가 공용 인터페이스에서 노출하는 포트를 지정할 필요가 없다는 점을 참고하십시오. 호스트 엔드포인트 정책이 iptables에 적용되기 전에 해당 전달이 이루어집니다.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>작업자 노드를 관리하는 데 사용되는 특정 IBM Cloud 인프라(SoftLayer) 시스템에 대한 수신 연결을 허용합니다.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>작업자 노드 사이에서 가상 IP 주소를 모니터하고 이동하는 데 사용되는 vrrp 패킷을 허용합니다.</td>
   </tr>
  </tbody>
</table>

<br />


## 네트워크 정책 추가
{: #adding_network_policies}

대부분의 경우, 기본 정책은 변경할 필요가 없습니다. 고급 시나리오에만 변경사항이 필요할 수 있습니다. 변경사항을 작성해야 하는 경우, Calico CLI를 설치하고 사용자 고유의 네트워크 정책을 작성하십시오.
{:shortdesc}

시작하기 전에:

1.  [{{site.data.keyword.containershort_notm}} 및 Kubernetes CLI를 설치](cs_cli_install.html#cs_cli_install)하십시오.
2.  [무료 또는 표준 클러스터를 작성](cs_clusters.html#clusters_ui)하십시오.
3.  [Kubernetes CLI를 클러스터에 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 
`--admin` 옵션을 `bx cs cluster-config` 명령에 포함하십시오. 이는 인증서 및 권한 파일을 다운로드하는 데 사용됩니다. 이 다운로드에는 Calico 명령을 실행하는 데 필요한 수퍼유저 역할에 대한 키도 포함됩니다.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **참고:** Calico CLI 버전 1.6.1이 지원됩니다.

네트워크 정책을 추가하려면 다음을 수행하십시오.
1.  Calico CLI를 설치하십시오.
    1.  [Calico CLI를 다운로드 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1)하십시오.

        **팁:** Windows를 사용하는 경우, {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 Calico CLI를 설치하십시오. 이 설정을 사용하면 나중에 명령을 실행할 때 일부 파일 경로 변경이 필요하지 않습니다.

    2.  OSX 및 Linux 사용자의 경우, 다음 단계를 완료하십시오.
        1.  실행 파일을 /usr/local/bin 디렉토리로 이동하십시오.
            -   Linux:

              ```
              mv filepath/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS X:

              ```
              mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  파일을 실행 가능하도록 설정하십시오.

            ```
           chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Calico CLI 클라이언트 버전을 확인하여 `calico` 명령이 올바르게 실행되는지 확인하십시오.

        ```
        calicoctl version
        ```
        {: pre}

    4.  회사 네트워크 정책으로 인해 로컬 시스템에서 프록시 또는 방화벽을 통해 공용 엔드포인트에 액세스하지 못하는 경우 Calico 명령에 대한 TCP 액세스를 허용하는 방법에 대한 지시사항은 [방화벽 뒤에서 `calicoctl` 명령 실행](cs_firewall.html#firewall)을 참조하십시오.

2.  Calico CLI를 구성하십시오.

    1.  Linux 및 OS X의 경우에는 `/etc/calico` 디렉토리를 작성하십시오. Windows의 경우에는 임의의 디렉토리가 사용될 수 있습니다.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  `calicoctl.cfg` 파일을 작성하십시오.
        -   Linux 및 OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: 텍스트 편집기로 파일을 작성하십시오.

    3.  <code>calicoctl.cfg</code> 파일에 다음 정보를 입력하십시오.

        ```
      apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
        ```
        {: codeblock}

        1.  `<ETCD_URL>`을 검색하십시오. 이 명령이 실패하고 `calico-config not found` 오류가 발생하는 경우 이 [문제점 해결 주제](cs_troubleshoot_network.html#cs_calico_fails)를 참조하십시오.

          -   Linux 및 OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   출력 예:

              ```
              https://169.xx.xxx.xxx:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>구성 맵에서 calico 구성 값을 가져오십시오. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>`data` 섹션에서 etcd_endpoints 값을 찾으십시오. 예: <code>https://169.xx.xxx.xxx:30001</code>
            </ol>

        2.  Kubernetes 인증서가 다운로드되는 디렉토리인 `<CERTS_DIR>`을 검색하십시오.

            -   Linux 및 OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                출력 예:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                출력 예:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
              ```
              {: screen}

            **참고**: 디렉토리 경로를 가져오려면 출력의 끝에서 파일 이름 `kube-config-prod-<location>-<cluster_name>.yml`을 제거하십시오.

        3.  <code>ca-*pem_file<code>을 검색하십시오.

            -   Linux 및 OS X:

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>이전 단계에서 검색한 디렉토리를 여십시오.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> <code>ca-*pem_file</code> 파일을 찾으십시오.</ol>

        4.  Calico 구성이 올바르게 작동하고 있는지 확인하십시오.

            -   Linux 및 OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=filepath/calicoctl.cfg
              ```
              {: pre}

              출력:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  기존 네트워크 정책을 조사하십시오.

    -   Calico 호스트 엔드포인트를 보십시오.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   클러스터에 작성된 모든 Calico 및 Kubernetes 네트워크 정책을 보십시오. 이 목록에는 팟(Pod) 또는 호스트에 아직 적용되지 않았을 수 있는 정책이 포함됩니다. 네트워크 정책이 적용되려면 Calico 네트워크 정책에 정의된 선택기와 일치하는 Kubernetes 리소스를 찾아야 합니다.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   네트워크 정책의 세부사항을 보십시오.

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   클러스터에 대한 모든 네트워크 정책의 세부사항을 보십시오.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  트래픽을 허용하거나 차단하도록 Calico 네트워크 정책을 작성하십시오.

    1.  구성 스크립트(.yaml)를 작성하여 [Calico 네트워크 정책![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)을 정의하십시오. 이러한 구성 파일에는 이러한 정책이 적용되는 팟(Pod), 네임스페이스 또는 호스트를 설명하는 선택기가 포함됩니다. 사용자 공유 정책을 작성하려면 이러한 [샘플 Calico 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)을 참조하십시오.

    2.  클러스터에 정책을 적용하십시오.
        -   Linux 및 OS X:

          ```
          calicoctl apply -f policy.yaml
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
          ```
          {: pre}

<br />


## LoadBalancer 또는 NodePort 서비스에 대한 수신 트래픽 차단
{: #block_ingress}

기본적으로 Kubernetes `NodePort` 및 `LoadBalancer` 서비스는 앱을 모든 퍼블릭 및 프라이빗 클러스터 인터페이스에서 사용 가능하게 하도록 설계되었습니다. 그러나 트래픽 소스 또는 대상을 기반으로 서비스에 대한 수신 트래픽을 차단할 수 있습니다.
{:shortdesc}

Kubernetes LoadBalancer 서비스는 NodePort 서비스이기도 합니다. LoadBalancer 서비스는 로드 밸런서 IP 주소 및 포트를 통해 앱을 사용할 수 있도록 하고 서비스의 노드 포트를 통해 앱을 사용할 수 있도록 합니다. 클러스터 내의 모든 노드에 대한 모든 IP 주소(공인 및 사설)에서 노드 포트에 액세스할 수 있습니다.

클러스터 관리자는 Calico `preDNAT` 네트워크 정책을 사용하여 다음을 차단할 수 있습니다.

  - NodePort 서비스에 대한 트래픽. LoadBalancer 서비스에 대한 트래픽을 허용됩니다.
  - 소스 어댑터 또는 CIDR을 기반으로 하는 트래픽

Calico `preDNAT` 네트워크 정책에 대한 몇 가지 일반적 사용:

  - 사설 LoadBalancer 서비스의 공용 노드 포트에 대한 트래픽을 차단합니다.
  - [에지 작업자 노드](cs_edge.html#edge)를 실행하는 클러스터의 공용 노드 포트에 대한 트래픽을 차단합니다. 노드 포트를 차단하면 에지 작업자 노드가 수신 트래픽을 처리하는 유일한 작업자 노드가 됩니다.

Kubernetes NodePort 및 LoadBalancer 서비스에 대해 생성된 DNAT iptables 규칙으로 인해 기본 Kubernetes 및 Calico 정책을 이러한 서비스의 보호에 적용하기 어렵기 때문에 `preDNAT` 네트워크 정책이 유용합니다.

Calico `preDNAT` 네트워크 정책은 [Calico 네트워크 정책 리소스
![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)를 기반으로 iptables 규칙을 생성합니다.

1. Kubernetes 서비스에 대한 Ingress 액세스를 위한 Calico `preDNAT` 네트워크 정책을 정의하십시오.

  모든 노드 포트를 차단하는 예:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Calico preDNAT 네트워크 정책을 적용하십시오. 클러스터 전체에 정책 변경사항을 적용하는 데 약 1분이 걸립니다.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}

