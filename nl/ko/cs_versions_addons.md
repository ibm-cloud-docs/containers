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


# 클러스터 추가 기능 변경 로그

{{site.data.keyword.containerlong}} 클러스터는 IBM에 의해 자동으로 업데이트되는 추가 기능을 제공합니다. 일부 추가 기능에 대한 자동 업데이트를 사용 안함으로 설정하고 마스터 및 작업자 노드와 별도로 수동으로 업데이트할 수도 있습니다. 각 버전의 변경사항에 대한 요약은 다음 절에 나와 있는 표를 참조하십시오.
{: shortdesc}

## Ingress ALB 추가 기능 변경 로그
{: #alb_changelog}

{{site.data.keyword.containerlong_notm}} 클러스터에 있는 Ingress 애플리케이션 로드 밸런서(ALB)에 대한 빌드 버전 변경사항을 확인하십시오.
{:shortdesc}

Ingress ALB 추가 기능이 업데이트되면 모든 ALB 팟(Pod)에 있는 `nginx-ingress` 및 `ingress-auth` 컨테이너가 최신 빌드 버전으로 업데이트됩니다. 기본적으로 추가 기능에 대한 자동 업데이트가 사용으로 설정되어 있지만, 자동 업데이트를 사용 안함으로 설정하고 추가 기능을 수동으로 업데이트할 수 있습니다. 자세한 정보는 [Ingress 애플리케이션 로드 밸런서 업데이트](cs_cluster_update.html#alb)를 참조하십시오.

Ingress ALB 추가 기능의 빌드별 변경사항에 대한 요약은 다음 표를 참조하십시오.

<table summary="Ingress 애플리케이션 로드 밸런서 추가 기능에 대한 빌드 변경사항 개요">
<caption>Ingress 애플리케이션 로드 밸런서 추가 기능에 대한 변경 로그</caption>
<thead>
<tr>
<th>`nginx-ingress` / `ingress-auth` 빌드</th>
<th>릴리스 날짜</th>
<th>비파괴적 변경사항</th>
<th>파괴적 변경사항</th>
</tr>
</thead>
<tbody>
<tr>
<td>393 / 282</td>
<td>2018년 11월 29일</td>
<td>{{site.data.keyword.appid_full}}에 대한 성능이 향상되었습니다.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018년 11월 14일</td>
<td>{{site.data.keyword.appid_full}}의 로깅 및 로그아웃 기능이 향상되었습니다.</td>
<td>`*.containers.mybluemix.net`에 대한 자체 서명 인증서가 자동으로 생성되어 클러스터에서 사용되는 LetsEncrypt 서명 인증서로 대체되었습니다. `*.containers.mybluemix.net` 자체 서명 인증서는 제거되었습니다.</td>
</tr>
<tr>
<td>350 / 192</td>
<td>2018년 11월 5일</td>
<td>Ingress ALB 추가 기능의 자동 업데이트를 사용 및 사용 안함으로 설정할 수 있는 지원이 추가되었습니다.</td>
<td>-</td>
</tr>
</tbody>
</table>
