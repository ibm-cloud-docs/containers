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

# Ingress 로깅 및 모니터링
{: #ingress_health}

문제를 해결하고 Ingress 구성의 성능을 개선하는 데 도움이 되도록 로깅을 사용자 정의하고 모니터링을 설정합니다.
{: shortdesc}

## Ingress 로그 보기
{: #ingress_logs}

로그는 Ingress ALB에 대해 자동으로 수집됩니다. ALB 로그를 보려면 2개의 옵션 중에서 선택하십시오.
* 클러스터에서 [Ingress 서비스에 대한 로깅 구성을 작성](cs_health.html#configuring)하십시오.
* CLI에서 로그를 확인하십시오.
    1. ALB에 대한 팟(Pod)의 ID를 가져오십시오.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. 해당 ALB 팟(Pod)의 로그를 여십시오. 로그가 업데이트된 형식을 따르는지 확인하십시오.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>기본 Ingress 로그 컨텐츠는 JSON으로 형식화되어 있으며, 클라이언트와 앱 간의 연결 세션을 설명하는 공통 필드를 표시합니다. 기본 필드의 예제 로그는 다음과 같습니다.

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>기본 Ingress 로그 형식의 필드 이해</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 기본 Ingress 로그 형식의 필드 이해</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>로그가 작성될 때 ISO 8601 표준 형식의 로컬 시간입니다.</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>클라이언트가 사용자 앱에 보낸 요청 패키지의 IP 주소입니다. 이 IP는 다음 상황에 따라 변경될 수 있습니다.<ul><li>앱에 대한 클라이언트 요청이 클러스터에 전송되는 경우, 요청은 ALB를 노출시키는 로드 밸런서 서비스에 대해 팟(Pod)으로 라우팅됩니다. 앱 팟(Pod)이 로드 밸런서 서비스 팟(Pod)과 동일한 작업자 노드에 없는 경우 로드 밸런서는 다른 작업자 노드의 앱 팟(Pod)으로 요청을 전달합니다. 요청 패키지의 소스 IP 주소는 앱 팟(Pod)이 실행 중인 작업자 노드의 공인 IP 주소로 변경됩니다.</li><li>[소스 IP 유지가 사용](cs_ingress.html#preserve_source_ip)되는 경우에는 앱에 대한 클라이언트 요청의 원래 IP 주소가 대신 기록됩니다.</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>앱이 액세스할 수 있는 호스트 또는 하위 도메인입니다. 이 호스트는 ALB의 Ingress 리소스 파일에 구성되어 있습니다.</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>요청 유형: <code>HTTP</code> 또는 <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>백엔드 앱에 대한 요청 호출의 메소드입니다(예: <code>GET</code> 또는 <code>POST</code>).</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>앱 경로에 대한 원래 요청 URI입니다. ALB는 앱이 청취하는 경로를 접두부로 처리합니다. ALB가 앱에 대한 클라이언트의 요청을 수신하는 경우, ALB는 요청 URI의 경로과 일치하는 경로(접두부로서)의 Ingress 리소스를 확인합니다.</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>16 랜덤 바이트에서 생성된 고유 요청 ID입니다.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>연결 세션에 대한 상태 코드입니다.<ul>
<li><code>200</code>: 세션이 성공적으로 완료됨</li>
<li><code>400</code>: 클라이언트 데이터를 구문 분석할 수 없음</li>
<li><code>403</code>: 액세스가 금지됨(예: 특정 클라이언트 IP 주소에 대해 액세스가 제한된 경우)</li>
<li><code>500</code>: 내부 서버 오류</li>
<li><code>502</code>: 잘못된 게이트웨이(예: 업스트림 서버를 선택하거나 이에 접근할 수 없는 경우)</li>
<li><code>503</code>: 사용 불가능한 서비스(예: 연결의 수로 인해 액세스가 제한되는 경우)</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>업스트림 서버의 UNIX-도메인 소켓에 대한 IP 주소 및 포트 또는 경로입니다. 요청 처리 중에 여러 서버에 접속하는 경우, 해당 주소는 쉼표로 구분됩니다(예: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>). 요청이 하나의 서버 그룹에서 다른 서버 그룹으로 내부적으로 경로 재지정되는 경우, 서로 다른 그룹의 서버 주소는 콜론으로 구분됩니다(예: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>). ALB가 서버를 선택할 수 없는 경우에는 서버 그룹의 이름이 대신 로깅됩니다.</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>백엔드 앱의 업스트림 서버에서 가져온 응답의 상태 코드입니다(예: 표준 HTTP 응답 코드). 여러 응답의 상태 코드는 <code>$upstream_addr</code> 변수의 주소와 같이 쉼표와 콜론으로 구분됩니다. ALB가 서버를 선택할 수 없는 경우에는 502(잘못된 게이트웨이) 상태 코드가 로깅됩니다.</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>밀리초 해상도의 초 단위로 측정되는 요청 처리 시간입니다. 이 시간은 ALB가 클라이언트 요청의 첫 번째 바이트를 읽을 때 시작되며, ALB가 응답의 마지막 바이트를 클라이언트에 전송할 때 중지됩니다. 로그는 요청 처리 시간이 중지된 직후에 쓰여집니다.</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>ALB가 백엔드 앱에 대한 업스트림 서버의 응답을 수신하는 데 걸리는 시간이며, 밀리초 해상도의 시간(초)으로 측정됩니다. 여러 응답의 시간은 <code>$upstream_addr</code> 변수의 주소와 같이 쉼표와 콜론으로 구분됩니다.</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>ALB가 백엔드 앱에 대한 업스트림 서버와의 연결을 설정하는 데 걸리는 시간이며, 밀리초 해상도의 시간(초)으로 측정됩니다. Ingress 리소스 구성에서 TLS/SSL을 사용하는 경우, 이 시간에는 핸드쉐이크에서 사용된 시간이 포함됩니다. 여러 연결의 시간은 <code>$upstream_addr</code> 변수의 주소와 같이 쉼표와 콜론으로 구분됩니다.</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>ALB가 백엔드 앱에 대한 업스트림 서버의 응답 헤더를 수신하는 데 걸리는 시간이며, 밀리초 해상도의 시간(초)으로 측정됩니다. 여러 연결의 시간은 <code>$upstream_addr</code> 변수의 주소와 같이 쉼표와 콜론으로 구분됩니다.</td>
</tr>
</tbody></table>

## Ingress 로그 컨텐츠 및 형식 사용자 정의
{: #ingress_log_format}

Ingress ALB에 대해 수집되는 로그의 컨텐츠 및 형식을 사용자 정의할 수 있습니다.
{:shortdesc}

기본적으로 Ingress 로그는 JSON으로 형식화되며 일반적인 로그 필드를 표시합니다. 그러나 사용자가 사용자 정의 로그 형식을 작성할 수도 있습니다. 전달되는 로그 컴포넌트와 컴포넌트가 로그 출력에서 배열되는 방식을 선택하려면 다음을 수행하십시오.

1. `ibm-cloud-provider-ingress-cm` configmap 리소스에 대한 구성 파일의 로컬 버전을 작성하고 여십시오.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. <code>data</code> 섹션을 추가하십시오. `log-format` 필드를 추가하고 선택적으로 `log-format-escape-json` 필드를 추가하십시오.

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>YAML 파일 컴포넌트</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> log-format 구성 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td><code>&lt;key&gt;</code>를 로그 컴포넌트의 이름으로 대체하고 <code>&lt;log_variable&gt;</code>을 로그 항목에서 수집할 로그 컴포넌트에 대한 변수로 대체하십시오. 문자열 값 앞뒤의 따옴표나 로그 컴포넌트 구분을 위한 쉼표와 같이 로그 항목이 포함하도록 할 텍스트 및 구두점을 포함시킬 수 있습니다. 예를 들어, <code>request: "$request"</code>와 같은 컴포넌트를 형식화하면 로그 항목에 <code>request: "GET / HTTP/1.1"</code>이 생성됩니다. 사용할 수 있는 모든 변수의 목록은 <a href="http://nginx.org/en/docs/varindex.html">Nginx 변수 색인</a>을 참조하십시오.<br><br><em>x-custom-ID</em>와 같은 추가 헤더를 로그하려면 사용자 정의 로그 컨텐츠에 다음 키-값 쌍을 추가하십시오. <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>하이픈(<code>-</code>)이 밑줄(<code>_</code>)로 변환되며 <code>$http_</code>가 사용자 정의 헤더 이름 앞에 추가되어야 합니다.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>선택사항: 기본적으로 로그는 텍스트 형식으로 생성됩니다. JSON 형식으로 로그를 생성하려면 <code>log-format-escape-json</code> 필드를 추가하고 값 <code>true</code>를 사용하십시오.</td>
    </tr>
    </tbody></table>

    예를 들면, 로그 형식은 다음 변수를 포함할 수 있습니다.
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    이 형식을 따르는 로그 항목은 다음 예와 같습니다.
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    ALB 로그의 기본 형식을 기반으로 하는 사용자 정의 로그 형식을 작성하려면 필요에 따라 다음 섹션을 수정하여 configmap에 추가하십시오.
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. 구성 파일을 저장하십시오.

5. configmap 변경사항이 적용되었는지 확인하십시오.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Ingress ALB 로그를 보려면 2개의 옵션 중에서 선택하십시오.
    * 클러스터에서 [Ingress 서비스에 대한 로깅 구성을 작성](cs_health.html#logging)하십시오.
    * CLI에서 로그를 확인하십시오.
        1. ALB에 대한 팟(Pod)의 ID를 가져오십시오.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. 해당 ALB 팟(Pod)의 로그를 여십시오. 로그가 업데이트된 형식을 따르는지 확인하십시오.
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Ingress 메트릭 콜렉션에 대한 공유 메모리 구역 크기 늘리기
{: #vts_zone_size}

작업자 프로세스가 캐시, 세션 지속성 및 속도 한계 등의 정보를 공유할 수 있도록 공유 메모리 구역이 정의됩니다. 가상 호스트 트래픽 상태 구역이라고 하는 공유 메모리 구역은 Ingress가 ALB에 대한 메트릭 데이터를 수집할 수 있도록 설정되어 있습니다.
{:shortdesc}

`ibm-cloud-provider-ingress-cm` Ingress configmap에서 `vts-status-zone-size` 필드는 메트릭 데이터 콜렉션에 대한 공유 메모리 구역의 크기를 설정합니다. 기본적으로 `vts-status-zone-size`는 `10m`로 설정되어 있습니다. 메트릭 콜렉션을 위해 추가 메모리가 필요한 대형 환경을 보유한 경우에는 다음 단계에 따라 보다 큰 값을 대신 사용하도록 기본값을 대체할 수 있습니다.

1. `ibm-cloud-provider-ingress-cm` configmap 리소스에 대한 구성 파일의 로컬 버전을 작성하고 여십시오.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. `vts-status-zone-size`의 값을 `10m`에서 보다 큰 값으로 변경하십시오.

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. 구성 파일을 저장하십시오.

4. configmap 변경사항이 적용되었는지 확인하십시오.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
