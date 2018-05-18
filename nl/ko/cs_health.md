---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터 로깅 및 모니터링
{: #health}

{{site.data.keyword.containerlong}}의 로깅 및 모니터링을 설정하면 문제를 해결하고 Kubernetes 클러스터 및 앱의 상태와 성능을 향상시킬 수 있습니다.
{: shortdesc}


## 로그 전달 구성
{: #logging}

{{site.data.keyword.containershort_notm}}의 표준 Kubernetes 클러스터를 사용하면 다른 소스의 로그를 {{site.data.keyword.loganalysislong_notm}}, 외부 syslog 서버(또는 둘 다)로 전달할 수 있습니다.
{: shortdesc}

하나의 소스의 로그를 두 콜렉터 서버로 전달하려면 두 개의 로깅 구성을 작성해야 합니다.
{: tip}

여러 가지 로그 소스에 대한 정보를 보려면 다음 표를 확인하십시오.

<table><caption>로그 소스 특성</caption>
  <thead>
    <tr>
      <th>로그 소스</th>
      <th>특성</th>
      <th>로그 경로</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>container</code></td>
      <td>Kubernetes 클러스터에서 실행되는 사용자의 컨테이너에 대한 로그입니다.</td>
      <td>컨테이너에서 STDOUT 또는 STDERR에 로깅된 모든 경로입니다.</td>
    </tr>
    <tr>
      <td><code>application</code></td>
      <td>Kubernetes 클러스터에서 실행되는 고유 애플리케이션의 로그입니다.</td>
      <td>경로를 설정할 수 있습니다.</td>
    </tr>
    <tr>
      <td><code>worker</code></td>
      <td>Kubernetes 클러스터 내 가상 머신 작업자 노드의 로그입니다.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>kubernetes</code></td>
      <td>Kubernetes 시스템 컴포넌트의 로그입니다.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>ingress</code></td>
      <td>클러스터로 수신되는 네트워크 트래픽을 관리하는 Ingress 애플리케이션 로드 밸런서의 로그입니다.</td>
      <td><code>/var/log/alb/ids/&ast;.log</code>, <code>/var/log/alb/ids/&ast;.err</code>, <code>/var/log/alb/customerlogs/&ast;.log</code>, <code>/var/log/alb/customerlogs/&ast;.err</code></td>
    </tr>
  </tbody>
</table>

UI를 통해 로깅을 구성하는 경우 조직 또는 영역을 지정해야 합니다. 계정 레벨에서 로깅을 사용하려는 경우 CLI를 통해 이를 수행할 수 있습니다.
{: tip}


### 시작하기 전에

1. 권한을 확인하십시오. 클러스터 또는 로깅 구성을 작성했을 때 영역을 지정한 경우 계정 소유자 및 {{site.data.keyword.containershort_notm}} 키 소유자 모두는 해당 영역의 관리자, 개발자 또는 감사자 권한을 필요로 합니다. 
  * {{site.data.keyword.containershort_notm}} 키 소유자가 누구인지 모르는 경우 다음 명령을 실행하십시오. 
      ```
      bx cs api-key-info <cluster_name>
      ```
      {: pre}
  * 권한에 대한 변경사항을 즉시 적용하려면 다음 명령을 실행하십시오.
      ```
      bx cs logging-config-refresh <cluster_name>
      ```
      {: pre}

  {{site.data.keyword.containershort_notm}} 액세스 정책 및 권한 변경에 대한 자세한 정보는 [클러스터 액세스 관리](cs_users.html#managing)를 참조하십시오.
  {: tip}

2. 로그 소스가 있는 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

  데디케이티드 계정을 사용 중인 경우 로그 전달을 사용으로 설정하려면 퍼블릭 {{site.data.keyword.cloud_notm}} 엔드포인트에 로그인하고 퍼블릭 조직 및 영역을 대상으로 지정해야 합니다.
  {: tip}

3. 로그를 syslog에 전달하려면 다음 두 가지 방법 중 하나를 사용하여 syslog 프로토콜을 허용하는 서버를 설정하십시오.
  * 자체 서버를 설정하여 관리하거나 제공자가 관리하도록 하십시오. 제공자가 사용자 대신 서버를 관리하는 경우 로깅 제공자로부터 로깅 엔드포인트를 가져오십시오.
  * 컨테이너에서 syslog를 실행하십시오. 예를 들어, 이 [배치 .yaml 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)을 사용하여 Kubernetes 클러스터에서 컨테이너를 실행하는 Docker 공용 이미지를 페치할 수 있습니다. 이미지는 공용 클러스터 IP 주소에 포트 `514`를 공개하고 이 공용 클러스터 IP 주소를 사용하여 syslog 호스트를 구성합니다.

### 로그 전달 사용

1. 로그 전달 구성을 작성하십시오.
    * {{site.data.keyword.loganalysisshort_notm}}에 로그를 전달하려면 다음을 수행하십시오.
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

      ```
      $ cs logging-config-create zac2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'zac1,zac2,zac3'
      Creating logging configuration for application logs in cluster zac2...
      OK
      Id                                     Source        Namespace   Host                                    Port    Org   Space   Protocol   Application Containers   Paths
      aa2b415e-3158-48c9-94cf-f8b298a5ae39   application   -           ingest.logging.stage1.ng.bluemix.net✣   9091✣   -     -       ibm        zac1,zac2,zac3           /var/log/apps.log
      ```
      {: screen}

    * 로그를 syslog에 전달하려면 다음을 수행하십시오.
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

  <table>
    <caption>이 명령의 컴포넌트 이해</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;my_cluster&gt;</em></code></td>
      <td>클러스터의 이름 또는 ID입니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;my_log_source&gt;</em></code></td>
      <td>로그를 전달할 소스입니다. 허용되는 값은 <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> 및 <code>ingress</code>입니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
      <td>선택사항: 로그를 전달할 Kubernetes 네임스페이스입니다. <code>ibm-system</code> 및 <code>kube-system</code> Kubernetes 네임스페이스의 경우 로그 전달이 지원되지 않습니다. 이 값은 <code>container</code> 로그 소스에 대해서만 유효합니다. 네임스페이스를 지정하지 않으면 컨테이너의 모든 네임스페이스가 이 구성을 사용합니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
      <td><p>{{site.data.keyword.loganalysisshort_notm}}의 경우 [유입 URL](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)을 사용하십시오. 유입 URL을 지정하지 않으면 클러스터가 작성된 지역의 엔드포인트가 사용됩니다.</p>
      <p>syslog의 경우 로그 콜렉터 서비스의 호스트 이름 또는 IP 주소를 지정하십시오. </p></td>
    </tr>
    <tr>
      <td><code><em>&lt;port&gt;</em></code></td>
      <td>유입 포트입니다. 포트를 지정하지 않으면 표준 포트 <code>9091</code>이 사용됩니다.
      <p>syslog의 경우 로그 콜렉터 서버의 포트를 지정하십시오. 포트를 지정하지 않으면 표준 포트 <code>514</code>가 사용됩니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_space&gt;</em></code></td>
      <td>선택사항: 로그를 전송할 Cloud Foundry 영역의 이름입니다. 로그를 {{site.data.keyword.loganalysisshort_notm}}로 전달하는 경우 영역 및 조직이 유입 지점에서 지정됩니다. 영역을 지정하지 않으면 로그는 계정 레벨로 전송됩니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_org&gt;</em></code></td>
      <td>영역이 있는 Cloud Foundry 조직의 이름입니다. 영역을 지정한 경우 이 값은 필수입니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;type&gt;</em></code></td>
      <td>로그를 전달할 위치입니다. 옵션은 <code>ibm</code>(로그를 {{site.data.keyword.loganalysisshort_notm}}로 전달) 및 <code>syslog</code>(로그를 외부 서버로 전달)입니다. </td>
    </tr>
    <tr>
      <td><code><em>&lt;paths_to_logs&gt;</em></code></td>
      <td>앱이 로깅되는 컨테이너에 대한 경로입니다. 소스 유형이 <code>application</code>인 로그를 전달하려면 경로를 제공해야 합니다. 두 개 이상의 경로를 지정하려면 쉼표로 구분된 목록을 사용하십시오. 예를 들면, <code>/var/log/myApp1/*/var/log/myApp2/*</code>입니다.</td>
    </tr>
    <tr>
      <td><code><em>&lt;containers&gt;</em></code></td>
      <td>선택사항: 앱에서 로그를 전달하려면 앱이 포함된 컨테이너의 이름을 지정할 수 있습니다. 쉼표로 구분된 목록을 사용하여 두 개 이상의 컨테이너를 지정할 수 있습니다. 컨테이너가 지정되지 않은 경우 로그는 사용자가 제공한 경로가 포함된 모든 컨테이너에서 전달됩니다. </td>
    </tr>
  </tbody>
  </table>

2. 다음 방법 중 하나를 사용하여 구성이 올바른지 확인하십시오.

    * 클러스터의 모든 로깅 구성을 나열하려면 다음을 실행하십시오.
      ```
    bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      출력 예:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 로그 소스의 한 가지 유형에 대한 로깅 구성을 나열하려면 다음을 실행하십시오.
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      출력 예:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

구성을 업데이트하려면 같은 단계를 따라야 하지만 `bx cs logging-config-create`를 `bx cs logging-config-update`로 대체하십시오. 업데이트를 확인하십시오.
{: tip}

<br />


## 로그 보기
{: #view_logs}

클러스터 및 컨테이너에 대한 로그를 보기 위해 표준 Kubernetes 및 Docker 로깅 기능으로 사용할 수 있습니다.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Kibana 대시보드를 통해 {{site.data.keyword.loganalysislong_notm}}에 전달한 로그를 볼 수 있습니다.
{: shortdesc}

구성 파일을 작성하는 데 기본값을 사용한 경우 클러스터가 작성된 계정 또는 조직 및 영역에서 로그를 찾을 수 있습니다. 구성 파일에서 조직 및 영역을 지정한 경우 해당 영역에서 로그를 찾을 수 있습니다. 로깅에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}에 대한 로깅](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)을 참조하십시오.

Kibana 대시보드에 액세스하려면 다음 URL 중 하나로 이동하여 클러스터를 작성한 {{site.data.keyword.Bluemix_notm}} 계정 또는 영역을 선택하십시오.
- 미국 남부 및 미국 동부: https://logging.ng.bluemix.net
- 영국 남부: https://logging.eu-gb.bluemix.net
- 중앙 유럽: https://logging.eu-fra.bluemix.net
- AP 남부: https://logging.au-syd.bluemix.net

로그 보기에 대한 자세한 정보는 [웹 브라우저에서 Kibana로 이동](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)을 참조하십시오.

### Docker 로그
{: #view_logs_docker}

기본 제공 Docker 로깅 기능을 활용하여 표준 STDOUT 및 STDERR 출력 스트림에서 활동을 검토할 수 있습니다. 자세한 정보는 [Kubernetes 클러스터에서 실행되는 컨테이너에 대한 컨테이너 로그 보기](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)를 참조하십시오.

<br />


## 로그 전달 중지
{: #log_sources_delete}

클러스터에 대한 하나 또는 모든 로깅 구성의 로그 전달을 중지할 수 있습니다.
{: shortdesc}

1. 로그 소스가 있는 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

2. 로깅 구성을 삭제하십시오.
<ul>
<li>하나의 로깅 구성을 삭제하려면 다음을 수행하십시오.</br>
  <pre><code>bx cs logging-config-rm &lt;my_cluster&gt; --id &lt;log_config_id&gt;</pre></code>
  <table>
    <caption>이 명령의 컴포넌트 이해</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
      </thead>
        <tbody>
        <tr>
          <td><code><em>&lt;my_cluster&gt;</em></code></td>
          <td>로깅 구성이 있는 클러스터의 이름입니다. </td>
        </tr>
        <tr>
          <td><code><em>&lt;log_config_id&gt;</em></code></td>
          <td>로그 소스 구성의 ID입니다.</td>
        </tr>
        </tbody>
  </table></li>
<li>모든 로깅 구성을 삭제하려면 다음을 수행하십시오.</br>
  <pre><code>bx cs logging-config-rm <my_cluster> --all</pre></code></li>
</ul>

<br />


## Kubernetes API 감사 로그의 로그 전달 구성
{: #app_forward}

Kubernetes API 서버를 통해 웹훅을 구성하여 클러스터에서 모든 호출을 캡처할 수 있습니다. 웹훅이 사용으로 설정되면 로그를 원격 서버로 전송할 수 있습니다.
{: shortdesc}

Kubernetes 감사 로그에 대한 자세한 정보는 Kubernetes 문서에서 <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">감사 주제<img src="../icons/launch-glyph.svg" alt="외부 링크 아이콘"></a>를 참조하십시오.

* Kubernetes API 감사 로그의 전달은 Kubernetes 버전 1.7 이상에서만 지원됩니다.
* 현재 이 로깅 구성의 모든 클러스터에 대해 기본 감사 정책이 사용됩니다.
* 감사 로그는 외부 서버로만 전달할 수 있습니다.
{: tip}

### Kubernetes API 감사 로그 전달 사용
{: #audit_enable}

시작하기 전에:

1. 로그를 전달할 수 있는 원격 로깅 서버를 설정하십시오. 예를 들어, [Logstash를 Kubernetes와 함께 사용![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend)하여 감사 이벤트를 수집할 수 있습니다.

2. API 서버 감사 로그를 수집할 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. **참고**: 데디케이티드 계정을 사용 중인 경우 로그 전달을 사용으로 설정하려면 퍼블릭 {{site.data.keyword.cloud_notm}} 엔드포인트에 로그인하고 공용 조직 및 영역을 대상으로 지정해야 합니다.

Kubernetes API 감사 로그를 전달하려면 다음을 수행하십시오.

1. 웹훅을 구성하십시오. 이 플래그에 정보를 제공하지 않은 경우에는 기본 구성이 사용됩니다.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>클러스터의 이름 또는 ID입니다.</td>
    </tr>
    <tr>
    <td><code><em>&lt;server_URL&gt;</em></code></td>
    <td>로그를 전송할 원격 로깅 서비스의 URL 또는 IP 주소입니다. 비보안 서버 URL을 제공한 경우 인증서가 무시됩니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
    <td>원격 로깅 서비스를 확인하는 데 사용되는 CA 인증서의 파일 경로입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;client_cert_path&gt;</em></code></td>
    <td>원격 로깅 서비스에 대해 인증하는 데 사용되는 클라이언트 인증서의 파일 경로입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;client_key_path&gt;</em></code></td>
    <td>원격 로깅 서비스에 연결하는 데 사용되는 해당 클라이언트 키의 파일 경로입니다. </td>
    </tr>
    </tbody></table>

2. 원격 로깅 서비스의 URL을 확인하여 로그 전달이 사용으로 설정되었는지 확인하십시오.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    출력 예:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Kubernetes 마스터를 다시 시작하여 구성 업데이트를 적용하십시오.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Kubernetes API 감사 로그 전달 중지
{: #audit_delete}

클러스터의 API 서버를 위한 웹후크 백엔드 구성을 사용 안함으로 설정하여 감사 로그의 전달을 중지할 수 있습니다.

시작하기 전에 API 서버 감사 로그 수집을 중지할 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

1. 클러스터의 API 서버를 위한 웹후크 백엔드 구성을 사용 안함으로 설정하십시오.

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Kubernetes 마스터를 다시 시작하여 구성 업데이트를 적용하십시오.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## 클러스터 모니터링 구성
{: #monitoring}

메트릭은 클러스터의 상태와 성능을 모니터하는 데 도움이 됩니다. 성능이 저하된 상태 또는 작동되지 않는 상태가 된 작업자를 자동으로 발견하여 정정하도록 작업자 노드의 상태 모니터링을 구성할 수 있습니다. **참고**: 모니터링은 표준 클러스터에서만 지원됩니다.
{:shortdesc}

## 메트릭 보기
{: #view_metrics}

표준 Kubernetes 및 Docker 기능을 사용하여 클러스터 및 앱의 상태를 모니터할 수 있습니다.
{:shortdesc}

<dl>
  <dt>{{site.data.keyword.Bluemix_notm}}의 클러스터 세부사항 페이지</dt>
    <dd>{{site.data.keyword.containershort_notm}}는 클러스터의 상태와 용량 및 클러스터 리소스의 사용에 대한 정보를 제공합니다. 이 GUI를 사용하면 클러스터를 확장하고 지속적 스토리지 관련 작업을 수행하며 {{site.data.keyword.Bluemix_notm}} 서비스 바인딩을 통해 클러스터에 기능을 추가할 수 있습니다. 클러스터 세부사항 페이지를 보려면 **{{site.data.keyword.Bluemix_notm}}대시보드**로 이동하고 클러스터를 선택하십시오.</dd>
  <dt>Kubernetes 대시보드</dt>
    <dd>Kubernetes 대시보드는 작업자 노드의 상태를 검토하고 Kubernetes 리소스를 찾으며 컨테이너화된 앱을 배치하고 로깅 및 모니터링 정보를 사용하여 앱의 문제점을 해결할 수 있는 관리 웹 인터페이스입니다. Kubernetes 대시보드에 액세스하는 방법에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 Kubernetes 대시보드 시작](cs_app.html#cli_dashboard)을 참조하십시오.</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd>표준 클러스터의 메트릭은 Kubernetes 클러스터가 작성될 때 로그인된 {{site.data.keyword.Bluemix_notm}} 계정에 위치합니다. 클러스터를 작성할 때 {{site.data.keyword.Bluemix_notm}} 영역을 지정한 경우 메트릭은 해당 영역에 위치합니다. 컨테이너 메트릭은 클러스터에 배치된 모든 컨테이너에 대해 자동으로 수집됩니다. 이러한 메트릭이 전송되고
Grafana를 통해 사용 가능하게 됩니다. 메트릭에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 모니터링](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)을 참조하십시오.<p>Grafana 대시보드에 액세스하려면 다음 URL 중 하나로 이동하여 클러스터를 작성한 {{site.data.keyword.Bluemix_notm}} 계정 또는 영역을 선택하십시오.<ul><li>미국 남부 및 미국 동부: https://metrics.ng.bluemix.net</li><li>미국 남부: https://metrics.eu-gb.bluemix.net</li><li>중앙 유럽: https://metrics.eu-de.bluemix.net</li></ul></p></dd>
</dl>

### 기타 상태 모니터링 도구
{: #health_tools}

추가 모니터링 기능을 위해 다른 도구를 구성할 수 있습니다.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus는 Kubernetes에 맞게 설계된 오픈 소스 모니터링, 로깅 및 경보 도구입니다. 도구는 클러스터, 작업자 노드 및 Kubernetes 로깅 정보를 기반으로 한 배치 상태에 대한 자세한 정보를 검색합니다. 설정 정보는 [{{site.data.keyword.containershort_notm}}와 서비스 통합](cs_integrations.html#integrations)을 참조하십시오.</dd>
</dl>

<br />


## 자동 복구를 통해 작업자 노드의 상태 모니터링 구성
{: #autorecovery}

{{site.data.keyword.containerlong_notm}} 자동 복구 시스템은 Kubernetes 버전 1.7 이상의 기존 클러스터에 배치할 수 있습니다.
{: shortdesc}

자동 복구 시스템은 다양한 검사를 통해 작업자 노드 상태를 조회합니다. 자동 복구는 구성된 검사에 따라 비정상적인 작업자 노드를 발견하면 작업자 노드에서 OS 다시 로드와 같은 정정 조치를 트리거합니다. 한 번에 하나의 작업자 노드에서만 정정 조치가 이루어집니다. 다른 작업자 노드에서 정정 조치가 이루어지려면 먼저 현재 작업자 노드가 정정 조치를 완료해야 합니다. 자세한 정보는 이 [자동 복구 블로그 게시물![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)을 참조하십시오.
**참고**: 자동 복구에서는 하나 이상의 정상 노드가 올바르게 작동되어야 합니다. 둘 이상의 작업자 노드가 있는 클러스터에서만 활성 검사를 통한 자동 복구를 구성하십시오.

시작하기 전에 작업자 노드 상태를 검사할 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

1. 검사를 JSON 형식으로 정의하는 구성 맵 파일을 작성하십시오. 예를 들어, 다음 YAML 파일은 세 가지 검사(하나의 HTTP 검사와 두 개의 Kubernetes API 서버 검사)를 정의합니다.</br>
   **팁**: 구성 맵의 데이터 섹션에서 고유 키로 각 선택란을 정의하십시오. 

   ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
         "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
         "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
        }
      checkpod.json: |
        {
         "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
      }
   ```
   {:codeblock}

   <table summary="configmap의 컴포넌트 이해">
   <caption>configmap 컴포넌트 이해</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> configmap 컴포넌트 이해</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>구성 이름 <code>ibm-worker-recovery-checks</code>는 상수이고 변경될 수 없습니다.</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td><code>kube-system</code> 네임스페이스는 상수이고 변경될 수 없습니다.</td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>HTTP 서버가 포트 80에서 개별 노드의 IP 주소에서 실행 중인지 그리고 경로 <code>/myhealth</code>에서 200 응답을 리턴하는지 검사하는 HTTP 검사를 정의합니다. <code>kubectl get nodes</code>를 실행하여 노드의 IP 주소를 찾을 수 있습니다.
예를 들어, 클러스터에 IP 주소 10.10.10.1 및 10.10.10.2를 사용하는 두 개의 노드가 있다고 가정합니다. 이 예에서는 다음 두 개의 라우트가 200 OK 응답을 리턴하는지 검사됩니다. <code>http://10.10.10.1:80/myhealth</code> 및 <code>http://10.10.10.2:80/myhealth</code>.
예제의 검사에서는 3분 마다 YAML이 실행됩니다. 3회 연속 실패 시, 노드가 다시 부팅됩니다. 이 조치는 <code>bx cs worker-reboot</code>를 실행하는 것과 같습니다. HTTP 검사는 <b>Enabled</b> 필드를 <code>true</code>로 설정할 때까지 비활성화됩니다.      </td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>개별 노드가 <code>Ready</code> 상태인지 검사하는 Kubernetes API 노드 검사를 정의합니다. 노드 상태가 <code>Ready</code>가 아니면 해당 노드에 대한 검사는 실패로 간주됩니다.
예제의 검사에서는 3분 마다 YAML이 실행됩니다. 3회 연속 실패 시, 노드가 다시 로드됩니다. 이 조치는 <code>bx cs worker-reload</code>를 실행하는 것과 같습니다. 노드 검사는 <b>Enabled</b> 필드를 <code>false</code>로 설정하거나 검사를 제거할 때까지 활성화됩니다.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>해당 노드에 지정된 총 포드를 기반으로 한 노드에서 <code>NotReady</code> 포드의 전체 백분율을 검사하는 Kubernetes API 포드 검사를 정의합니다. <code>NotReady</code> 포드의 전체 백분율이 정의된 <code>PodFailureThresholdPercent</code>보다 큰 경우 해당 노드에 대한 검사가 실패로 간주됩니다.
예제의 검사에서는 3분 마다 YAML이 실행됩니다. 3회 연속 실패 시, 노드가 다시 로드됩니다. 이 조치는 <code>bx cs worker-reload</code>를 실행하는 것과 같습니다. 이 포드 검사는 <b>Enabled</b> 필드를 <code>false</code>로 설정하거나 검사를 제거할 때까지 활성화됩니다.</td>
   </tr>
   </tbody>
   </table>


   <table summary="개별 규칙 컴포넌트 이해">
   <caption>개별 규칙 컴포넌트 이해</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 개별 규칙 컴포넌트 이해</th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>자동 복구에서 사용할 검사 유형을 입력하십시오. <ul><li><code>HTTP</code>: 자동 복구는 각 노드에서 실행되는 HTTP 서버를 호출하여 노드가 올바르게 실행 중인지 여부를 판별합니다.</li><li><code>KUBEAPI</code>: 자동 복구는 Kubernetes API 서버를 호출하고 작업자 노드에서 보고된 상태 데이터를 읽습니다.</li></ul></td>
   </tr>
   <tr>
   <td><code>Resource</code></td>
   <td>검사 유형이 <code>KUBEAPI</code>인 경우 자동 복구에서 검사할 리소스 유형을 입력하십시오. 허용된 값은 <code>NODE</code> 또는 <code>PODS</code>입니다.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>연속 실패한 검사의 수에 대한 임계값을 입력하십시오. 이 임계값에 도달하면 자동 복구가 지정된 정정 조치를 트리거합니다. 예를 들어, 값이 3이고 자동 복구가 구성된 검사에 세 번 연속 실패하면 자동 복구가 검사와 연관된 정정 조치를 트리거합니다.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>리소스 유형이 <code>PODS</code>인 경우 [NotReady ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 상태인 작업자 노드의 포드 백분율에 대한 임계값을 입력하십시오. 이 백분율은 작업자 노드에 대해 스케줄된 총 포드 수를 기준으로 합니다. 검사에서 비정상 포드의 백분율이 임계값을 초과한다고 판별되면 하나의 오류로 계수합니다.</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>오류 임계값에 도달할 때 실행할 조치를 입력하십시오. 정정 조치는 다른 작업자가 수리되지 않는 동안에 그리고 작업자 노드가 이전 조치의 쿨오프 주기가 아닌 경우에만 실행됩니다. <ul><li><code>REBOOT</code>: 작업자 노드를 다시 부팅합니다.</li><li><code>RELOAD</code>: 클린 OS에서 작업자 노드에 필요한 모든 구성을 다시 로드합니다.</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>자동 복구가 이미 정정 조치가 실행된 노드로 인해 다른 정정 조치를 실행할 때까지 대기해야 하는 시간(초)을 입력하십시오. 쿨 오프 주기는 정정 조치가 실행될 때 시작됩니다.</td>
   </tr>
   <tr>
   <td><code>IntervalSeconds</code></td>
   <td>연속 검사 간 시간(초)을 입력하십시오. 예를 들어, 값이 180이면 자동 복구는 3분마다 각 노드에서 검사를 실행합니다.</td>
   </tr>
   <tr>
   <td><code>TimeoutSeconds</code></td>
   <td>자동 복구가 호출 오퍼레이션을 종료하기 전까지 데이터베이스에 대한 검사 호출에 걸리는 최대 시간(초)을 입력하십시오. <code>TimeoutSeconds</code> 값은 <code>IntervalSeconds</code> 값보다 작아야 합니다.</td>
   </tr>
   <tr>
   <td><code>Port</code></td>
   <td>검사 유형이 <code>HTTP</code>인 경우 HTTP 서버가 작업자 노드에서 바인드해야 하는 포트를 입력하십시오. 이 포트는 클러스터에 있는 모든 작업자 노드의 IP에 노출되어야 합니다. 자동 복구에는 서버 검사를 위해 모든 노드에서 일정한 포트 번호가 필요합니다. 사용자 정의 서버를 클러스터에 배치할 때 [DaemonSets ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)를 사용하십시오.</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>검사 유형이 <code>HTTP</code>인 경우 검사에서 리턴될 HTTP 서버 상태를 입력하십시오. 예를 들어, 값 200은 서버의 <code>OK</code> 응답을 예상함을 표시합니다.</td>
   </tr>
   <tr>
   <td><code>Route</code></td>
   <td>검사 유형이 <code>HTTP</code>인 경우 HTTP 서버에서 요청되는 경로를 입력하십시오. 이 값은 일반적으로 모든 작업자 노드에서 실행 중인 서버의 메트릭 경로입니다.</td>
   </tr>
   <tr>
   <td><code>Enabled</code></td>
   <td>검사를 사용으로 설정하려면 <code>true</code>를 입력하고 사용 안함으로 설정하려면 <code>false</code>를 입력하십시오.</td>
   </tr>
   </tbody>
   </table>

2. 클러스터에서 구성 맵을 작성하십시오.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 적절한 검사를 통해 `kube-system` 네임스페이스에서 이름이 `ibm-worker-recovery-checks`인 구성 맵을 작성했는지 확인하십시오.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. 이 YAML 파일을 적용하여 클러스터에 자동 복구를 배치하십시오.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. 몇 분 후에 다음 명령의 출력에서 `Events` 섹션을 확인하여 자동 복구 배치의 활동을 볼 수 있습니다.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
