---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 네트워크 정책을 사용한 트래픽 제어
{: #network_policies}

모든 Kubernetes 클러스터는 Calico라는 네트워크 플러그인으로 설정됩니다. {{site.data.keyword.containerlong}}에서 모든 작업자 노드의 공용 네트워크 인터페이스 보안을 위해 기본 네트워크 정책이 설정됩니다.
{: shortdesc}

고유한 보안 요구사항이 있는 경우 또는 VLAN Spanning이 사용으로 설정된 다중 구역 클러스터가 있는 경우에는 Calico 및 Kubernetes를 사용하여 클러스터에 대한 네트워크 정책을 작성할 수 있습니다. Kubernetes 네트워크 정책을 사용하면 클러스터 내의 팟(Pod)에 대해 허용하거나 차단할 네트워크 트래픽을 지정할 수 있습니다. LoadBalancer 서비스에 대한 인바운드(Ingress) 트래픽 차단과 같은 고급 네트워크 정책을 설정하려면 Calico 네트워크 정책을 사용하십시오.

<ul>
  <li>
  [Kubernetes 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): 이러한 정책은 팟(Pod)이 다른 팟(Pod) 및 외부 엔드포인트와 통신할 수 있는 방법을 지정합니다. Kubernetes 버전 1.8부터 프로토콜, 포트 및 소스 또는 대상 IP 주소에 따라 수신 및 발신 네트워크 트래픽을 모두 허용하거나 차단할 수 있습니다. 팟(Pod) 및 네임스페이스 레이블에 따라 트래픽을 필터링할 수도 있습니다. `kubectl` 명령 또는 Kubernetes API를 사용하여 Kubernetes 네트워크 정책을 적용할 수 있습니다. 이러한 정책이 적용되면 자동으로 Calico 네트워크 정책으로 변환되고 Calico가 해당 정책을 적용합니다.
  </li>
  <li>
Kubernetes 버전 [1.10 이상 클러스터 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) 또는 [1.9 이상 클러스터 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)에 대한 Calico 네트워크 정책: 이러한 정책은 Kubernetes 네트워크 정책의 수퍼세트이며 `calicoctl` 명령을 사용하여 적용됩니다. Calico 정책은 다음 기능을 추가합니다.
    <ul>
    <li>Kubernetes 팟(Pod) 소스 또는 대상 IP 주소나 CIDR에 관계없이 특정 네트워크 인터페이스의 네트워크 트래픽을 허용하거나 차단합니다.</li>
    <li>네임스페이스 간에 팟(Pod)에 대한 네트워크 트래픽을 허용하거나 차단합니다.</li>
    <li>[LoadBalancer 또는 NodePort Kubernetes 서비스에 대한 인바운드(Ingress) 트래픽을 차단](#block_ingress)합니다.</li>
    </ul>
  </li>
  </ul>

Calico는 Kubernetes 작업자 노드에서 Linux iptables 규칙을 설정하여 자동으로 Calico 정책으로 변환된 Kubernetes 네트워크 정책을 포함하는 해당 정책을 적용합니다. Iptables 규칙은 대상으로 지정된 리소스에 전달되도록 네트워크 트래픽이 충족해야 하는 특성을 정의하기 위해
작업자 노드에 대한 방화벽의 역할을 합니다.

Ingress 및 LoadBalancer 서비스를 사용하려면 Calico 및 Kubernetes 정책을 사용하여 클러스터 내부로 또는 외부로의 네트워크 트래픽을 관리하십시오. IBM Cloud 인프라(SoftLayer) [보안 그룹](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups)은 사용하지 마십시오. IBM Cloud 인프라(SoftLayer) 보안 그룹은 하이퍼바이저 레벨에서 트래픽을 필터링하기 위해 단일 가상 서버의 네트워크 인터페이스에 적용됩니다. 그러나 보안 그룹은 LoadBalancer IP 주소의 관리를 위해 {{site.data.keyword.containershort_notm}}에서 사용하는 VRRP 프로토콜을 지원하지 않습니다. LoadBalancer IP의 관리를 위한 VRRP 프로토콜이 존재하지 않으면 Ingress 및 LoadBalancer 서비스가 제대로 작동하지 않습니다.
{: tip}

<br />


## 기본 Calico 및 Kubernetes 네트워크 정책
{: #default_policy}

공용 VLAN을 사용하는 클러스터가 작성될 때 각 작업자 노드 및 해당 공용 네트워크 인터페이스에 대해 레이블이 `ibm.role: worker_public`인 HostEndpoint 리소스가 자동으로 작성됩니다. 작업자 노드의 공용 네트워크 인터페이스를 보호하기 위해 레이블이 `ibm.role: worker_public`인 호스트 엔드포인트에 기본 Calico 정책이 적용됩니다.
{:shortdesc}

이러한 기본 Calico 정책은 모든 아웃바운드 네트워크 트래픽을 허용하고 Kubernetes NodePort, LoadBalancer 및 Ingress 서비스와 같은 특정 클러스터 컴포넌트에 대한 인바운드 트래픽을 허용합니다. 인터넷으로부터 기본 정책에 지정되지 않은 작업자 노드로의 기타 모든 인바운드 네트워크 트래픽은 차단됩니다. 기본 정책은 팟(Pod) 간 트래픽에는 영향을 미치지 않습니다.

자동으로 클러스터에 적용되는 다음과 같은 기본 Calico 네트워크 정책을 검토하십시오.

**중요:** 정책을 완전히 이해한 경우를 제외하고는 호스트 엔드포인트에 적용된 정책을 제거하지 마십시오. 정책에서 허용되는 트래픽이 필요하지 않은지 확인하십시오.

 <table summary="표에서 첫 번째 행은 두 열 모두에 걸쳐 있습니다. 나머지 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며, 서버 구역은 1열에 있고 일치시킬 IP 주소는 2열에 있습니다. ">
 <caption>각 클러스터의 기본 Calico 정책</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 각 클러스터의 기본 Calico 정책</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>아웃바운드 트래픽을 모두 허용합니다.</td>
    </tr>
    <tr>
      <td><code>allow-bigfix-port</code></td>
      <td>BigFix 앱에 대한 포트 52311의 수신 트래픽이 필요한 작업자 노드 업데이트를 허용하도록 합니다.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>수신 ICMP 패킷(ping)을 허용합니다.</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>해당 서비스가 노출되는 팟(Pod)에 대한 NodePort, LoadBalancer 및 Ingress 서비스 트래픽을 허용합니다. <strong>참고</strong>: Kubernetes는 대상 네트워크 주소 변환(DNAT)을 사용하여 서비스 요청을 올바른 팟(Pod)에 전달하므로 노출된 포트를 지정할 필요가 없습니다. 호스트 엔드포인트 정책이 iptables에 적용되기 전에 해당 전달이 이루어집니다.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>작업자 노드를 관리하는 데 사용되는 특정 IBM Cloud 인프라(SoftLayer) 시스템에 대한 수신 연결을 허용합니다.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>가상 IP 주소를 모니터하고 작업자 노드 간에 이동하는 데 사용되는 VRRP 패킷을 허용합니다.</td>
   </tr>
  </tbody>
</table>

Kubernetes 버전 1.10 이상 클러스터에서는 Kubernetes 대시보드에 대한 액세스를 제한하는 기본 Kubernetes 정책도 작성됩니다. Kubernetes 정책은 호스트 엔드포인트에 적용되지 않지만 대신 `kube-dashboard` 팟(Pod)에 적용됩니다. 이 정책은 사설 VLAN에만 연결된 클러스터와 공용 및 사설 VLAN에 연결된 클러스터에 적용됩니다.

<table>
<caption>각 클러스터의 기본 Kubernetes 정책</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 각 클러스터의 기본 Kubernetes 정책</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>Kubernetes v1.10에서만</b> <code>kube-system</code> 네임스페이스에 제공됨: 모든 팟(Pod)이 Kubernetes 대시보드에 액세스하지 못하도록 차단합니다. 이 정책은 {{site.data.keyword.Bluemix_notm}} UI 또는 <code>kubectl proxy</code>를 사용하여 대시보드에 액세스하는 기능에는 영향을 미치지 않습니다. 팟(Pod)에 대시보드에 대한 액세스 권한이 필요한 경우 <code>kubernetes-dashboard-policy: allow</code> 레이블이 있는 네임스페이스에 팟(Pod)을 배치하십시오.</td>
 </tr>
</tbody>
</table>

<br />


## Calico CLI 설치 및 구성
{: #cli_install}

Calico 정책을 확인, 관리 및 추가하려면 Calico CLI를 설치하여 구성하십시오.
{:shortdesc}

CLI 구성 및 정책에 대한 Calico 버전의 호환성은 클러스터의 Kubernetes 버전에 따라 다릅니다. Calico CLI를 설치 및 구성하려면 클러스터 버전에 따라 다음 링크 중 하나를 클릭하십시오.

* [Kubernetes 버전 1.10 이상 클러스터](#1.10_install)
* [Kubernetes 버전 1.9 이상 클러스터](#1.9_install)

클러스터를 Kubernetes 버전 1.9 이하에서 버전 1.10 이상으로 업데이트하기 전에 [Calico v3으로 업데이트 준비](cs_versions.html#110_calicov3)를 검토하십시오.
{: tip}

### Kubernetes 버전 1.10 이상을 실행 중인 클러스터용 버전 3.1.1 Calico CLI 설치 및 구성
{: #1.10_install}

시작하기 전에 클러스터를 [클러스터에 Kubernetes CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. `--admin` 옵션을 `ibmcloud ks cluster-config` 명령에 포함하십시오. 이는 인증서 및 권한 파일을 다운로드하는 데 사용됩니다. 이 다운로드에는 Calico 명령을 실행하는 데 필요한 수퍼유저 역할에 대한 키도 포함됩니다.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

3.1.1 Calico CLI를 설치 및 구성하려면 다음을 수행하십시오.

1. [Calico CLI를 다운로드 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1)하십시오.

    OSX를 사용하는 경우 `-darwin-amd64` 버전을 다운로드하십시오. Windows를 사용하는 경우 {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 Calico CLI를 설치하십시오. 이 설정을 사용하면 나중에 명령을 실행할 때 일부 파일 경로 변경이 필요하지 않습니다. 반드시 `calicoctl.exe`로 파일을 저장하십시오.
    {: tip}

2. OSX 및 Linux 사용자의 경우, 다음 단계를 완료하십시오.
    1. 실행 파일을 _/usr/local/bin_ 디렉토리로 이동하십시오.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS X:

          ```
              mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. 파일을 실행 파일로 설정하십시오.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Calico CLI 클라이언트 버전을 확인하여 `calico` 명령이 올바르게 실행되는지 확인하십시오.

    ```
        calicoctl version
    ```
    {: pre}

4. 회사 네트워크 정책으로 인해 프록시 또는 방화벽을 사용하여 로컬 시스템에서 공용 엔드포인트에 액세스하지 못하는 경우 [Calico 명령에 대한 TCP 액세스를 허용](cs_firewall.html#firewall)하십시오.

5. Linux 및 OS X의 경우에는 `/etc/calico` 디렉토리를 작성하십시오. Windows의 경우에는 임의의 디렉토리가 사용될 수 있습니다.

  ```
  sudo mkdir -p /etc/calico/
  ```
  {: pre}

6. `calicoctl.cfg` 파일을 작성하십시오.
    - Linux 및 OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: 텍스트 편집기로 파일을 작성하십시오.

7. <code>calicoctl.cfg</code> 파일에 다음 정보를 입력하십시오.

    ```
    apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. `<ETCD_URL>`을 검색하십시오.

      - Linux 및 OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

          출력 예:

          ```
          https://169.xx.xxx.xxx:30000
          ```
          {: screen}

      - Windows:
        <ol>
        <li>configmap에서 calico 구성 값을 가져오십시오. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>`data` 섹션에서 etcd_endpoints 값을 찾으십시오. 예: <code>https://169.xx.xxx.xxx:30000</code>
        </ol>

    2. Kubernetes 인증서가 다운로드되는 디렉토리인 `<CERTS_DIR>`을 검색하십시오.

        - Linux 및 OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          출력 예:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

            출력 예:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **참고**: 디렉토리 경로를 가져오려면 출력의 끝에서 파일 이름 `kube-config-prod-<zone>-<cluster_name>.yml`을 제거하십시오.

    3. `ca-*pem_file`을 검색하십시오.

        - Linux 및 OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>지난 단계에서 검색한 디렉토리를 여십시오.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> <code>ca-*pem_file</code> 파일을 찾으십시오.</ol>

8. 파일을 저장하고 자신의 현재 위치가 파일이 있는 디렉토리인지 확인하십시오. 

9. Calico 구성이 올바르게 작동하고 있는지 확인하십시오.

    - Linux 및 OS X:

      ```
      calicoctl get nodes
      ```
      {: pre}

    - Windows:

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


### Kubernetes 버전 1.9 이상을 실행 중인 클러스터용 버전 1.6.3 Calico CLI 설치 및 구성
{: #1.9_install}

시작하기 전에 클러스터를 [클러스터에 Kubernetes CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. `--admin` 옵션을 `ibmcloud ks cluster-config` 명령에 포함하십시오. 이는 인증서 및 권한 파일을 다운로드하는 데 사용됩니다. 이 다운로드에는 Calico 명령을 실행하는 데 필요한 수퍼유저 역할에 대한 키도 포함됩니다.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

1.6.3 Calico CLI를 설치 및 구성하려면 다음을 수행하십시오.

1. [Calico CLI를 다운로드 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3)하십시오.

    OSX를 사용하는 경우 `-darwin-amd64` 버전을 다운로드하십시오. Windows를 사용하는 경우 {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 Calico CLI를 설치하십시오. 이 설정을 사용하면 나중에 명령을 실행할 때 일부 파일 경로 변경이 필요하지 않습니다.
    {: tip}

2. OSX 및 Linux 사용자의 경우, 다음 단계를 완료하십시오.
    1. 실행 파일을 _/usr/local/bin_ 디렉토리로 이동하십시오.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. 파일을 실행 파일로 설정하십시오.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Calico CLI 클라이언트 버전을 확인하여 `calico` 명령이 올바르게 실행되는지 확인하십시오.

    ```
    calicoctl version
    ```
    {: pre}

4. 회사 네트워크 정책으로 인해 프록시 또는 방화벽을 사용하여 로컬 시스템에서 공용 엔드포인트에 액세스하지 못하는 경우 Calico 명령에 대한 TCP 액세스를 허용하는 방법에 대한 지시사항은 [방화벽 뒤에서 `calicoctl` 명령 실행](cs_firewall.html#firewall)을 참조하십시오.

5. Linux 및 OS X의 경우에는 `/etc/calico` 디렉토리를 작성하십시오. Windows의 경우에는 임의의 디렉토리가 사용될 수 있습니다.
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

6. `calicoctl.cfg` 파일을 작성하십시오.
    - Linux 및 OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: 텍스트 편집기로 파일을 작성하십시오.

7. <code>calicoctl.cfg</code> 파일에 다음 정보를 입력하십시오.

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

    1. `<ETCD_URL>`을 검색하십시오.

      - Linux 및 OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

      - 출력 예:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>configmap에서 calico 구성 값을 가져오십시오. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>`data` 섹션에서 etcd_endpoints 값을 찾으십시오. 예: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

    2. Kubernetes 인증서가 다운로드되는 디렉토리인 `<CERTS_DIR>`을 검색하십시오.

        - Linux 및 OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          출력 예:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

          출력 예:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **참고**: 디렉토리 경로를 가져오려면 출력의 끝에서 파일 이름 `kube-config-prod-<zone>-<cluster_name>.yml`을 제거하십시오.

    3. `ca-*pem_file`을 검색하십시오.

        - Linux 및 OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>지난 단계에서 검색한 디렉토리를 여십시오.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> <code>ca-*pem_file</code> 파일을 찾으십시오.</ol>

    4. Calico 구성이 올바르게 작동하고 있는지 확인하십시오.

        - Linux 및 OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

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

          **중요**: Windows 및 OS X 사용자는 `calicoctl` 명령이 실행될 때마다 `--config=filepath/calicoctl.cfg` 플래그를 포함해야 합니다. 

<br />


## 네트워크 정책 보기
{: #view_policies}

클러스터에 적용되는 기본 및 추가된 네트워크 정책에 대한 세부사항을 보십시오.
{:shortdesc}

시작하기 전에:
1. [Calico CLI를 설치 및 구성하십시오.](#cli_install)
2. [클러스터에 Kubernetes CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. `--admin` 옵션을 `ibmcloud ks cluster-config` 명령에 포함하십시오. 이는 인증서 및 권한 파일을 다운로드하는 데 사용됩니다. 이 다운로드에는 Calico 명령을 실행하는 데 필요한 수퍼유저 역할에 대한 키도 포함됩니다.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

CLI 구성 및 정책에 대한 Calico 버전의 호환성은 클러스터의 Kubernetes 버전에 따라 다릅니다. Calico CLI를 설치 및 구성하려면 클러스터 버전에 따라 다음 링크 중 하나를 클릭하십시오.

* [Kubernetes 버전 1.10 이상 클러스터](#1.10_examine_policies)
* [Kubernetes 버전 1.9 이상 클러스터](#1.9_examine_policies)

클러스터를 Kubernetes 버전 1.9 이하에서 버전 1.10 이상으로 업데이트하기 전에 [Calico v3으로 업데이트 준비](cs_versions.html#110_calicov3)를 검토하십시오.
{: tip}

### Kubernetes 버전 1.10 이상을 실행 중인 클러스터의 네트워크 정책 보기
{: #1.10_examine_policies}

Linux 사용자는 `--config=filepath/calicoctl.cfg` 플래그를 `calicoctl` 명령에 포함할 필요가 없습니다.
{: tip}

1. Calico 호스트 엔드포인트를 보십시오.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. 클러스터에 작성된 모든 Calico 및 Kubernetes 네트워크 정책을 보십시오. 이 목록에는 팟(Pod) 또는 호스트에 아직 적용되지 않았을 수 있는 정책이 포함됩니다. 네트워크 정책이 적용되려면 Calico 네트워크 정책에 정의된 선택기와 일치하는 Kubernetes 리소스를 찾아야 합니다.

    [네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy)의 범위는 특정 네임스페이스로 지정됩니다.
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide --config=filepath/calicoctl.cfg
    ```
    {:pre}

    [글로벌 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy)의 범위는 특정 네임스페이스로 지정되지 않습니다.
    ```
    calicoctl get GlobalNetworkPolicy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. 네트워크 정책의 세부사항을 보십시오.

    ```
    calicoctl get NetworkPolicy -o yaml <policy_name> --namespace <policy_namespace> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. 클러스터에 대한 모든 글로벌 네트워크 정책의 세부사항을 보십시오.

    ```
    calicoctl get GlobalNetworkPolicy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

### Kubernetes 버전 1.9 이하를 실행 중인 클러스터의 네트워크 정책 보기
{: #1.9_examine_policies}

Linux 사용자는 `--config=filepath/calicoctl.cfg` 플래그를 `calicoctl` 명령에 포함할 필요가 없습니다.
{: tip}

1. Calico 호스트 엔드포인트를 보십시오.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. 클러스터에 작성된 모든 Calico 및 Kubernetes 네트워크 정책을 보십시오. 이 목록에는 팟(Pod) 또는 호스트에 아직 적용되지 않았을 수 있는 정책이 포함됩니다. 네트워크 정책이 적용되려면 Calico 네트워크 정책에 정의된 선택기와 일치하는 Kubernetes 리소스를 찾아야 합니다.

    ```
    calicoctl get policy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. 네트워크 정책의 세부사항을 보십시오.

    ```
    calicoctl get policy -o yaml <policy_name> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. 클러스터에 대한 모든 네트워크 정책의 세부사항을 보십시오.

    ```
    calicoctl get policy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

<br />


## 네트워크 정책 추가
{: #adding_network_policies}

대부분의 경우, 기본 정책은 변경할 필요가 없습니다. 고급 시나리오에만 변경사항이 필요할 수 있습니다. 변경해야 하는 경우 사용자 고유의 네트워크 정책을 작성할 수 있습니다.
{:shortdesc}

Kubernetes 네트워크 정책을 작성하려면 [Kubernetes 네트워크 정책 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)를 참조하십시오.

Calico 정책을 작성하려면 다음 단계를 사용하십시오.

시작하기 전에:
1. [Calico CLI를 설치 및 구성하십시오.](#cli_install)
2. [클러스터에 Kubernetes CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. `--admin` 옵션을 `ibmcloud ks cluster-config` 명령에 포함하십시오. 이는 인증서 및 권한 파일을 다운로드하는 데 사용됩니다. 이 다운로드에는 Calico 명령을 실행하는 데 필요한 수퍼유저 역할에 대한 키도 포함됩니다.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

CLI 구성 및 정책에 대한 Calico 버전의 호환성은 클러스터의 Kubernetes 버전에 따라 다릅니다. 클러스터 버전에 따라 다음 링크 중 하나를 클릭하십시오.

* [Kubernetes 버전 1.10 이상 클러스터](#1.10_create_new)
* [Kubernetes 버전 1.9 이상 클러스터](#1.9_create_new)

클러스터를 Kubernetes 버전 1.9 이하에서 버전 1.10 이상으로 업데이트하기 전에 [Calico v3으로 업데이트 준비](cs_versions.html#110_calicov3)를 검토하십시오.
{: tip}

### Kubernetes 버전 1.10 이상을 실행 중인 클러스터에 Calico 정책 추가
{: #1.10_create_new}

1. 구성 스크립트(`.yaml`)를 작성하여 Calico [네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) 또는 [글로벌 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy)을 정의하십시오. 이러한 구성 파일에는 이러한 정책이 적용되는 팟(Pod), 네임스페이스 또는 호스트를 설명하는 선택기가 포함됩니다. 사용자 공유 정책을 작성하려면 이러한 [샘플 Calico 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy)을 참조하십시오.
    **참고**: Kubernetes 버전 1.10 이상 클러스터는 Calico v3 정책 구문을 사용합니다.

2. 클러스터에 정책을 적용하십시오.
    - Linux 및 OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

### Kubernetes 버전 1.9 이하를 실행 중인 클러스터에 Calico 정책 추가
{: #1.9_create_new}

1. 구성 스크립트(`.yaml`)를 작성하여 [Calico 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)을 정의하십시오. 이러한 구성 파일에는 이러한 정책이 적용되는 팟(Pod), 네임스페이스 또는 호스트를 설명하는 선택기가 포함됩니다. 사용자 공유 정책을 작성하려면 이러한 [샘플 Calico 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy)을 참조하십시오.
    **참고**: Kubernetes 버전 1.9 이하 클러스터는 Calico v2 정책 구문을 사용해야 합니다.


2. 클러스터에 정책을 적용하십시오.
    - Linux 및 OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

<br />


## LoadBalancer 또는 NodePort 서비스에 대한 인바운드 트래픽 제어
{: #block_ingress}

[기본적으로](#default_policy) Kubernetes NodePort 및 LoadBalancer 서비스는 앱을 모든 공용 및 사설 클러스터 인터페이스에서 사용 가능하게 하도록 설계되었습니다. 그러나 사용자는 Calico 정책을 사용하여 트래픽 소스 또는 대상을 기반으로 서비스에 대한 수신 트래픽을 차단할 수 있습니다.
{:shortdesc}

Kubernetes LoadBalancer 서비스는 NodePort 서비스이기도 합니다. LoadBalancer 서비스는 LoadBalancer IP 주소 및 포트를 통해 앱을 사용할 수 있도록 하고 서비스의 NodePort를 통해 앱을 사용할 수 있도록 합니다. 클러스터 내의 모든 노드에 대한 모든 IP 주소(공인 및 사설)에서 NodePort에 액세스할 수 있습니다.

클러스터 관리자는 Calico `preDNAT` 네트워크 정책을 사용하여 다음을 차단할 수 있습니다.

  - NodePort 서비스에 대한 트래픽. LoadBalancer 서비스에 대한 트래픽은 허용됩니다.
  - 소스 어댑터 또는 CIDR을 기반으로 하는 트래픽

Calico `preDNAT` 네트워크 정책에 대한 몇 가지 일반적 사용:

  - 사설 LoadBalancer 서비스의 공용 NodePort에 대한 트래픽을 차단합니다.
  - [에지 작업자 노드](cs_edge.html#edge)를 실행 중인 클러스터의 공용 NodePort에 대한 트래픽을 차단합니다. NodePort를 차단하면 에지 작업자 노드가 수신 트래픽을 처리하는 유일한 작업자 노드가 됩니다.

Kubernetes NodePort 및 LoadBalancer 서비스에 대해 생성된 DNAT iptables 규칙으로 인해 기본 Kubernetes 및 Calico 정책을 이러한 서비스의 보호에 적용하기 어렵습니다.

Calico `preDNAT` 네트워크 정책은 Calico 네트워크 정책 리소스를 기반으로 iptables 규칙을 생성하므로 도움이 될 수 있습니다. Kubernetes 버전 1.10 이상 클러스터는 [`calicoctl.cfg` v3 구문의 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy)을 사용합니다. 
Kubernetes 버전 1.9 이하 클러스터는 [`calicoctl.cfg` v2 구문의 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)을 사용합니다.

1. Kubernetes 서비스에 대한 Ingress(수신 트래픽) 액세스를 위한 Calico `preDNAT` 네트워크 정책을 정의하십시오.

    * Kubernetes 버전 1.10 이상 클러스터는 Calico v3 정책 구문을 사용해야 합니다.

        모든 NodePort를 차단하는 리소스 예:

        ```
        apiVersion: projectcalico.org/v3
        kind: GlobalNetworkPolicy
        metadata:
          name: deny-nodeports
        spec:
          applyOnForward: true
          ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: UDP
            source: {}
          preDNAT: true
          selector: ibm.role=='worker_public'
          order: 1100
          types:
          - Ingress
        ```
        {: codeblock}

    * Kubernetes 버전 1.9 이하 클러스터는 Calico v2 정책 구문을 사용해야 합니다.

        모든 NodePort를 차단하는 리소스 예:

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-nodeports
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

  - Linux 및 OS X:

    ```
    calicoctl apply -f deny-nodeports.yaml
    ```
    {: pre}

  - Windows:

    ```
    calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. 선택사항: 다중 구역 클러스터에서 MZLB 상태는 클러스터의 각 구역에서 ALB를 검사하며 이러한 상태 검사를 기반으로 하여 업데이트된 DNS 검색 결과를 보관합니다. 사전-DNAT 정책을 사용하여 Ingress 서비스에 대한 모든 수신 트래픽을 차단하는 경우, ALB의 상태 검사에 사용되는 [Cloudflare의 IPv4 IP ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.cloudflare.com/ips/) 역시 화이트리스트에 추가해야 합니다. 이러한 IP를 화이트리스트에 추가하기 위한 Calico 사전-DNAT 정책의 작성 방법에 대한 단계를 알아보려면 [Calico 네트워크 정책 튜토리얼](cs_tutorials_policies.html#lesson3)의 학습 3을 참조하십시오. 

소스 IP 주소를 화이트리스트 또는 블랙리스트에 추가하는 방법을 보려면 [Calico 네트워크 정책을 사용하여 트래픽 차단 튜토리얼](cs_tutorials_policies.html#policy_tutorial)을 참고하십시오. 클러스터와의 양방향 트래픽을 제어하는 추가적인 예제 Calico 네트워크 정책을 보려면 [스타 정책 데모 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) 및 [고급 네트워크 정책 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy)을 체크아웃할 수 있습니다.
{: tip}

## 팟(Pod) 간의 트래픽 제어
{: #isolate_services}

Kubernetes 정책은 내부 네트워크 트래픽으로부터 팟(Pod)을 보호합니다. 네임스페이스 내에서 서로 간에 또는 네임스페이스 간에 앱 마이크로서비스를 격리하기 위한 단순 Kubernetes 네트워크 정책을 작성할 수 있습니다.
{: shortdesc}

Kubernetes 네트워크 정책이 팟(Pod) 간의 트래픽을 제어하는 방법에 대한 자세한 정보와 추가적인 정책 예제를 보려면 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/services-networking/network-policies/)를 참조하십시오.
{: tip}

### 네임스페이스 내의 앱 서비스 격리
{: #services_one_ns}

다음 시나리오에서는 하나의 네임스페이스 내에서 앱 마이크로서비스 간에 트래픽을 관리하는 방법을 보여줍니다. 

Accounts 팀은 하나의 네임스페이스에 다중 앱 서비스를 배치하지만, 공용 네트워크를 통해 마이크로서비스 간에 필요한 통신만 허용하려면 격리가 필요합니다. 앱 Srv1의 경우, 팀에는 프론트 엔드, 백엔드 및 데이터베이스 서비스가 있습니다. 이들은 각 서비스의 레이블을 `app: Srv1` 레이블 및 `tier: frontend`, `tier: backend` 또는 `tier: db` 레이블로 지정합니다. 

<img src="images/cs_network_policy_single_ns.png" width="200" alt="네임스페이스 간의 트래픽을 관리하기 위한 네트워크 정책을 사용합니다." style="width:200px; border-style: none"/>

Accounts 팀은 프론트 엔드에서 백엔드로의 트래픽과 백엔드에서 데이터베이스로의 트래픽을 허용하고자 합니다. 이들은 자체 네트워크 정책의 레이블을 사용하여 마이크로서비스 간에 허용되는 트래픽 플로우를 지정합니다. 

우선 이들은 프론트 엔드에서 백엔드로의 트래픽을 허용하는 Kubernetes 네트워크 정책을 작성합니다. 

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

`spec.podSelector.matchLabels` 섹션에는 Srv1 백엔드 서비스에 대한 레이블이 나열되므로, 정책은 오직 해당 팟(Pod)_에만_ 적용됩니다. `spec.ingress.from.podSelector.matchLabels` 섹션에는 Srv1 프론트 엔드 서비스에 대한 레이블이 나열되므로, ingress는 오직 해당 팟(Pod)_에서만_ 허용됩니다. 

그리고 이들은 백엔드에서 데이터베이스로의 트래픽을 허용하는 유사한 Kubernetes 네트워크 정책을 작성합니다. 

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

`spec.podSelector.matchLabels` 섹션에는 Srv1 데이터베이스 서비스에 대한 레이블이 나열되므로, 정책은 오직 해당 팟(Pod)_에만_ 적용됩니다. `spec.ingress.from.podSelector.matchLabels` 섹션에는 Srv1 백엔드 서비스에 대한 레이블이 나열되므로, ingress는 오직 해당 팟(Pod)_에서만_ 허용됩니다. 

트래픽은 이제 프론트 엔드에서 백엔드로, 그리고 백엔드에서 데이터베이스로 이동할 수 있습니다. 데이터베이스는 백엔드에 응답할 수 있으며 백엔드는 프론트엔드에 응답할 수 있지만, 역방향 트래픽 연결은 설정될 수 없습니다. 

### 네임스페이스 간의 앱 서비스 격리
{: #services_across_ns}

다음 시나리오에서는 다중 네임스페이스에서 앱 마이크로서비스 간에 트래픽을 관리하는 방법을 보여줍니다. 

다른 하위 팀이 소유하는 서비스에서 통신이 필요하지만, 해당 서비스는 동일한 클러스터 내의 서로 다른 네임스페이스에 배치되어 있습니다. Accounts 팀은 Accounts 네임스페이스의 앱 Srv1에 대해 프론트 엔드, 백엔드 및 데이터베이스 서비스를 배치합니다. Finance 팀은 Finance 네임스페이스의 앱 Srv2에 대해 프론트 엔드, 백엔드 및 데이터베이스 서비스를 배치합니다. 두 팀은 모두 각 서비스의 레이블을 `app: Srv1` 또는 `app: Srv2` 레이블과 `tier: frontend`, `tier: backend` 또는 `tier: db` 레이블로 지정합니다. 이들은 `usage: finance` 또는 `usage: accounts` 레이블로 네임스페이스의 레이블을 지정합니다. 

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="네임스페이스 간의 트래픽을 관리하기 위한 네트워크 정책을 사용합니다." style="width:475px; border-style: none"/>

Finance 팀의 Srv2는 Accounts 팀의 Srv1 백엔드에서 정보를 호출해야 합니다. 따라서 Accounts 팀은 Finance 네임스페이스로부터 Accounts 네임스페이스의 Srv1 백엔드로의 모든 트래픽을 허용하는 레이블을 사용하는 Kubernetes 네트워크 정책을 작성합니다. 또한 팀에서는 해당 포트를 통한 액세스만 격리하기 위해 포트 3111도 지정합니다. 

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

`spec.podSelector.matchLabels` 섹션에는 Srv1 백엔드 서비스에 대한 레이블이 나열되므로, 정책은 오직 해당 팟(Pod)_에만_ 적용됩니다. ingress가 해당 네임스페이스의 서비스_에서만_ 허용될 수 있도록 `spec.ingress.from.NamespaceSelector.matchLabels` 섹션에는 Finance 네임스페이스에 대한 레이블이 나열되어 있습니다. 

이제 트래픽은 finance 마이크로서비스에서 accounts Srv1 백엔드로 이동할 수 있습니다. accounts Srv1 백엔드는 finance 마이크로서비스에 응답할 수 있지만 역방향 트래픽 연결은 설정할 수 없습니다. 

**참고**: `podSelector` 및 `namespaceSelector`를 결합할 수 없으므로, 사용자는 다른 네임스페이스의 특정 앱 팟(Pod)에서의 트래픽을 허용할 수 없습니다. 이 예제에서는 Finance 네임스페이스의 모든 마이크로서비스에서의 모든 트래픽이 허용됩니다. 
