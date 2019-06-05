---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# CLI 변경 로그
{: #cs_cli_changelog}

터미널에서 `ibmcloud` CLI 및 플러그인에 대한 업데이트가 사용 가능한 시점을 사용자에게 알려줍니다. 사용 가능한 모든 명령과 플래그를 사용할 수 있도록 반드시 CLI를 최신 상태로 유지하십시오.
{:shortdesc}

{{site.data.keyword.containerlong}} CLI 플러그인을 설치하려면 [CLI 설치](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps)를 참조하십시오.

각 {{site.data.keyword.containerlong_notm}} CLI 플러그인 버전의 변경사항에 대한 요약은 다음 표를 참조하십시오.

<table summary="{{site.data.keyword.containerlong_notm}} CLI 플러그인에 대한 버전 변경 개요">
<caption>{{site.data.keyword.containerlong_notm}} CLI 플러그인에 대한 변경 로그</caption>
<thead>
<tr>
<th>버전</th>
<th>릴리스 날짜</th>
<th>변경사항</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.2.102</td>
<td>2019년 4월 15일</td>
<td>네트워크 로드 밸런서(NLB) IP 주소에 대한 호스트 이름을 등록하고 관리하기 위해 [명령의 `ibmcloud ks nlb-dns` 그룹](/docs/containers?topic=containers-cs_cli_reference#nlb-dns)을 추가하고, NLB 호스트 이름에 대한 상태 검사 모니터를 작성하고 수정하기 위해 [명령의 `ibmcloud ks nlb-dns-monitor` 그룹](/docs/containers?topic=containers-cli-plugin-cs_cli_reference#cs_nlb-dns-monitor)을 추가합니다. 자세한 정보는 [DNS 호스트 이름으로 NLB IP 등록](/docs/containers?topic=containers-loadbalancer#loadbalancer_hostname_dns)을 참조하십시오.
</td>
</tr>
<tr>
<td>0.2.99</td>
<td>2019년 4월 9일</td>
<td><ul>
<li>도움말 텍스트를 업데이트합니다.</li>
<li>Go 버전을 1.12.2로 업데이트합니다.</li>
</ul></td>
</tr>
<tr>
<td>0.2.95</td>
<td>2019년 4월 3일</td>
<td><ul>
<li>관리 클러스터 추가 기능에 대한 버전화 지원을 추가합니다.</li>
<ul><li>[<code>ibmcloud ks addon-versions</code>](/docs/containers?topic=containers-cs_cli_reference#cs_addon_versions) 명령이 추가되었습니다.</li>
<li><code>--version</code> 플래그를 [ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable) 명령에 추가합니다.</li></ul>
<li>도움말 텍스트의 번역을 업데이트합니다.</li>
<li>도움말 텍스트의 문서에 대한 짧은 링크를 업데이트합니다.</li>
<li>JSON 오류 메시지가 올바르지 않은 형식으로 인쇄된 버그를 수정합니다. </li>
<li>일부 명령에서 자동 플래그(`-s`)를 사용하여 인쇄 오류를 방지한 버그를 수정합니다. </li>
</ul></td>
</tr>
<tr>
<td>0.2.80</td>
<td>2019년 3월 19일</td>
<td><ul>
<li>[VRF 사용 계정](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)에서 Kubernetes 버전 1.11 이상을 실행하는 표준 클러스터에 [서비스 엔드포인트를 사용하여 마스터와 작업자 간 통신](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)을 사용으로 설정하기 위한 지원이 추가되었습니다.<ul>
<li>`--private-service-endpoint` 및 `--public-service-endpoint` 플래그가 [<code>ibmcloud ks cluster-create</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create) 명령에 추가되었습니다.</li>
<li>**공용 서비스 엔드포인트 URL** 및 **개인 서비스 엔드포인트 URL** 필드가 <code>ibmcloud ks cluster-get</code>의 출력에 추가되었습니다.</li>
<li>[<code>ibmcloud ks cluster-feature-enable private-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_private_service_endpoint) 명령이 추가되었습니다.</li>
<li>[<code>ibmcloud ks cluster-feature-enable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_public_service_endpoint) 명령이 추가되었습니다.</li>
<li>[<code>ibmcloud ks cluster-feature-disable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable) 명령이 추가되었습니다.</li>
</ul></li>
<li>문서 및 번역본이 업데이트되었습니다.</li>
<li>Go 버전을 1.11.6으로 업데이트합니다.</li>
<li>macOS 사용자에 해당하는 중간 네트워킹 문제가 해결되었습니다.</li>
</ul></td>
</tr>
<tr>
<td>0.2.75</td>
<td>2019년 3월 14일</td>
<td><ul><li>오류 출력에서 원시 HTML을 숨깁니다.</li>
<li>도움말 텍스트의 오타가 수정되었습니다.</li>
<li>도움말 텍스트의 번역이 정정되었습니다.</li>
</ul></td>
</tr>
<tr>
<td>0.2.61</td>
<td>2019년 2월 26일</td>
<td><ul>
<li>`default` Kubernetes 네임스페이스에서 실행되는 컨테이너가 IBM Cloud Container Registry에서 이미지를 가져올 수 있도록 클러스터의 IAM 서비스 ID, 정책, API 키 및 이미지 풀 시크릿을 작성하는 `cluster-pull-secret-apply` 명령이 추가되었습니다. 새 클러스터의 경우, IAM 인증 정보를 사용하는 이미지 풀 시크릿이 기본적으로 작성됩니다. 이 명령을 사용하여 기존 클러스터를 업데이트하거나 클러스터에 이미지 풀 시크릿 작성 중에 오류가 발생하는 경우 이 명령을 사용하십시오. 자세한 정보는 [문서](https://test.cloud.ibm.com/docs/containers?topic=containers-images#cluster_registry_auth)를 참조하십시오.</li>
<li>`ibmcloud ks init` 오류로 인해 도움말 출력이 인쇄되는 버그가 해결되었습니다.</li>
</ul></td>
</tr>
<tr>
<td>0.2.53</td>
<td>2019년 2월 19일</td>
<td><ul><li>`ibmcloud ks api-key-reset`, `ibmcloud ks credential-get/set` 및 `ibmcloud ks vlan-spanning-get`에 대해 지역이 제외된 버그가 해결되었습니다.</li>
<li>`ibmcloud ks worker-update`에 대한 성능이 향상되었습니다.</li>
<li>`ibmcloud ks cluster-addon-enable` 프롬프트에 추가 기능 버전이 추가되었습니다.</li>
</ul></td>
</tr>
<tr>
<td>0.2.44</td>
<td>2019년 2월 8일</td>
<td><ul>
<li>{{site.data.keyword.Bluemix_notm}} IAM 서비스 액세스 역할을 기반으로 한 사용자 Kubernetes RBAC 역할을 클러스터 구성에 추가하는 것을 건너뛰도록 `--skip-rbac` 옵션이 `ibmcloud ks cluster-config` 명령에 추가되었습니다. [사용자 고유의 Kubernetes RBAC 역할을 관리](/docs/containers?topic=containers-users#rbac)하는 경우에만 이 옵션을 포함합니다. [{{site.data.keyword.Bluemix_notm}} IAM 서비스 액세스 역할](/docs/containers?topic=containers-access_reference#service)을 사용하여 모든 RBAC 사용자를 관리하는 경우 이 옵션을 포함하지 마십시오.</li>
<li>Go 버전을 1.11.5로 업데이트합니다.</li>
</ul></td>
</tr>
<tr>
<td>0.2.40</td>
<td>2019년 2월 6일</td>
<td><ul>
<li>{{site.data.keyword.containerlong_notm}}의 [Istio](/docs/containers?topic=containers-istio) 및 [Knative](/docs/containers?topic=containers-knative_tutorial) 관리 추가 기능과 같은 관리 클러스터 추가 기능으로 작업할 수 있도록 [<code>ibmcloud ks cluster-addons</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons), [<code>ibmcloud ks cluster-addon-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable) 및 [<code>ibmcloud ks cluster-addon-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable) 명령이 추가되었습니다.</li>
<li><code>ibmcloud ks vlans</code> 명령의 {{site.data.keyword.Bluemix_dedicated_notm}} 사용자를 위한 도움말 텍스트가 향상되었습니다.</li></ul></td>
</tr>
<tr>
<td>0.2.30</td>
<td>2019년 1월 31일</td>
<td>`ibmcloud ks cluster-config`의 기본 제한시간 값이 `500s`로 증가되었습니다.</td>
</tr>
<tr>
<td>0.2.19</td>
<td>2019년 1월 16일</td>
<td><ul><li>{{site.data.keyword.containerlong_notm}} 플러그인 CLI의 다시 디자인된 베타 버전을 활성화하도록 `IKS_BETA_VERSION` 환경 변수가 추가되었습니다. 다시 디자인된 버전을 사용해 보려면 [베타 명령 구조 사용](/docs/containers?topic=containers-cs_cli_reference#cs_beta)을 참조하십시오.</li>
<li>`ibmcloud ks subnets`의 기본 제한시간 값이 `60s`로 증가되었습니다.</li>
<li>사소한 버그와 번역이 수정되었습니다.</li></ul></td>
</tr>
<tr>
<td>0.1.668</td>
<td>2018년 12월 18일</td>
<td><ul><li>기본 API 엔드포인트를 <code>https://containers.bluemix.net</code>에서 <code>https://containers.cloud.ibm.com</code>으로 변경합니다.</li>
<li>번역이 명령 도움말 및 오류 메시지에 대해 올바르게 표시되도록 버그가 해결되었습니다.</li>
<li>명령 도움말을 더 빠르게 표시합니다.</li></ul></td>
</tr>
<tr>
<td>0.1.654</td>
<td>2018년 12월 5일</td>
<td>문서 및 번역본이 업데이트되었습니다.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>2018년 11월 15일</td>
<td>
<ul><li>[<code>ibmcloud ks cluster-refresh</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh) 명령이 추가되었습니다.</li>
<li><code>ibmcloud ks cluster-get</code> 및 <code>ibmcloud ks clusters</code>의 출력에 리소스 그룹 이름이 추가되었습니다.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>2018년 11월 6일</td>
<td>Ingress ALB 클러스터 추가 기능의 자동 업데이트 관리 명령이 추가되었습니다.<ul>
<li>[<code>ibmcloud ks alb-autoupdate-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</li>
<li>[<code>ibmcloud ks alb-rollback</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</li>
<li>[<code>ibmcloud ks alb-update</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</li>
</ul></td>
</tr>
<tr>
<td>0.1.621</td>
<td>2018년 10월 30일</td>
<td><ul>
<li>[<code>ibmcloud ks credential-get</code> 명령](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get)이 추가되었습니다.</li>
<li>모든 클러스터 로깅 명령에 <code>storage</code> 로그 소스에 대한 지원이 추가되었습니다. 자세한 정보는 <a href="/docs/containers?topic=containers-health#logging">클러스터 및 앱 로그 전달 이해</a>를 참조하십시오.</li>
<li>Calico 구성 파일을 다운로드하여 모든 Calico 명령을 실행하는 [<code>ibmcloud ks cluster-config</code> 명령](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config)에 `--network` 플래그가 추가되었습니다.</li>
<li>사소한 버그 수정 및 리팩토링</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>2018년 10월 10일</td>
<td><ul><li><code>ibmcloud ks cluster-get</code>의 출력에 리소스 그룹 ID가 추가되었습니다.</li>
<li>클러스터의 키 관리 서비스(KMS) 제공자로서 [{{site.data.keyword.keymanagementserviceshort}}가 사용으로 설정](/docs/containers?topic=containers-encryption#keyprotect)된 경우 <code>ibmcloud ks cluster-get</code>의 출력에 KMS enabled 필드가 추가됩니다.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2018년 10월 2일</td>
<td>[리소스 그룹](/docs/containers?topic=containers-clusters#prepare_account_level)에 대한 지원이 추가되었습니다.</td>
</tr>
<tr>
<td>0.1.590</td>
<td>2018년 10월 1일</td>
<td><ul>
<li>클러스터의 API 서버 로그를 수집하기 위한 [<code>ibmcloud ks logging-collect</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect) 및 [<code>ibmcloud ks logging-collect-status</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status) 명령이 추가되었습니다.</li>
<li>{{site.data.keyword.keymanagementserviceshort}}를 클러스터의 키 관리 서비스(KMS) 제공자로 사용할 수 있도록 하는 [<code>ibmcloud ks key-protect-enable</code> 명령](/docs/containers?topic=containers-cs_cli_reference#cs_key_protect)이 추가되었습니다.</li>
<li>다시 부팅 또는 다시 로드를 시작하기 전에 마스터 상태 검사를 건너뛸 수 있도록 [ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) 및 [ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) 명령에 <code>--skip-master-health</code> 플래그가 추가되었습니다.</li>
<li><code>ibmcloud ks cluster-get</code>의 출력에서 <code>Owner Email</code>이 <code>Owner</code>로 바뀌었습니다.</li></ul></td>
</tr>
</tbody>
</table>
