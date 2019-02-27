---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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

CLI 플러그인을 설치하려면 [CLI 설치](cs_cli_install.html#cs_cli_install_steps)를 참조하십시오.

각 CLI 플러그인 버전의 변경사항에 대한 요약은 다음 표를 참조하십시오.

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
<td>0.1.654</td>
<td>2018년 12월 5일</td>
<td>문서 및 번역본이 업데이트되었습니다.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>2018년 11월 15일</td>
<td>
<ul><li>[<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh) 명령이 추가되었습니다.</li>
<li><code>ibmcloud ks cluster-get</code> 및 <code>ibmcloud ks clusters</code>의 출력에 리소스 그룹 이름이 추가되었습니다.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>2018년 11월 6일</td>
<td>Ingress ALB 클러스터 추가 기능의 자동 업데이트를 관리하기 위해 [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable), [<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable), [<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get), [<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) 및 [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) 명령이 추가되었습니다.
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>2018년 10월 30일</td>
<td><ul>
<li>[<code>ibmcloud ks credential-get</code> 명령](cs_cli_reference.html#cs_credential_get)이 추가되었습니다.</li>
<li>모든 클러스터 로깅 명령에 <code>storage</code> 로그 소스에 대한 지원이 추가되었습니다. 자세한 정보는 <a href="cs_health.html#logging">클러스터 및 앱 로그 전달 이해</a>를 참조하십시오.</li>
<li>Calico 구성 파일을 다운로드하여 모든 Calico 명령을 실행하는 [<code>ibmcloud ks cluster-config</code> 명령](cs_cli_reference.html#cs_cluster_config)에 `--network` 플래그가 추가되었습니다.</li>
<li>사소한 버그 수정 및 리팩토링</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>2018년 10월 10일</td>
<td><ul><li><code>ibmcloud ks cluster-get</code>의 출력에 리소스 그룹 ID가 추가되었습니다.</li>
<li>클러스터의 키 관리 서비스(KMS) 제공자로서 [{{site.data.keyword.keymanagementserviceshort}}가 사용으로 설정](cs_encrypt.html#keyprotect)된 경우 <code>ibmcloud ks cluster-get</code>의 출력에 KMS enabled 필드가 추가됩니다.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2018년 10월 2일</td>
<td>[리소스 그룹](cs_clusters.html#prepare_account_level)에 대한 지원이 추가되었습니다.</td>
</tr>
<tr>
<td>0.1.590</td>
<td>2018년 10월 1일</td>
<td><ul>
<li>클러스터의 API 서버 로그를 수집하기 위한 [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) 및 [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) 명령이 추가되었습니다.</li>
<li>{{site.data.keyword.keymanagementserviceshort}}를 클러스터의 키 관리 서비스(KMS) 제공자로 사용할 수 있도록 하는 [<code>ibmcloud ks key-protect-enable</code> 명령](cs_cli_reference.html#cs_key_protect)이 추가되었습니다.</li>
<li>다시 부팅 또는 다시 로드를 시작하기 전에 마스터 상태 확인을 건너뛸 수 있도록 [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) 및 [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) 명령에 <code>--skip-master-health</code> 플래그가 추가되었습니다.</li>
<li><code>ibmcloud ks cluster-get</code>의 출력에서 <code>Owner Email</code>이 <code>Owner</code>로 바뀌었습니다.</li></ul></td>
</tr>
</tbody>
</table>
