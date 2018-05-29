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

# 버전 변경 로그
{: #changelog}

{{site.data.keyword.containerlong}} Kubernetes 클러스터에 대해 사용 가능한 주 버전, 부 버전 및 패치 업데이트의 버전 변경 정보를 보십시오. 변경사항에는 Kubernetes 및 {{site.data.keyword.Bluemix_notm}} Provider 컴포넌트에 대한 업데이트가 포함됩니다.
{:shortdesc}

IBM은 마스터에 자동으로 패치 레벨 업데이트를 적용하지만, [작업자 노드 업데이트](cs_cluster_update.html#worker_node)는 수동으로 수행해야 합니다. 사용 가능한 업데이트를 매월 확인하십시오. 업데이트가 사용 가능해지면 `bx cs workers <cluster>` 또는 `bx cs worker-get <cluster> <worker>` 명령 등을 사용하여 작업자 노드에 대한 정보를 볼 때 알림을 받습니다. 

마이그레이션 조치에 대한 요약은 [Kubernetes 버전](cs_versions.html)을 참조하십시오.
{: tip}

이전 버전에서 변경된 사항에 대한 정보는 다음 변경 로그를 보십시오. 
-  버전 1.8 [변경 로그](#18_changelog). 
-  버전 1.7 [변경 로그](#17_changelog). 


## 버전 1.8 변경 로그
{: #18_changelog}

다음 변경사항을 검토하십시오. 

### 1.8.11_1509의 변경 로그
{: #1811_1509}

<table summary="버전 1.8.8_1507 이후의 변경사항">
<caption>버전 1.8.8_1507 이후의 변경사항</caption>
<thead>
<tr>
<th>컴포넌트</th>
<th>이전</th>
<th>현재</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)를 참조하십시오. </td>
</tr>
<tr>
<td>컨테이너 이미지 일시정지</td>
<td>3.0</td>
<td>3.1</td>
<td>상속된 고아 좀비 프로세스를 제거합니다. </td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>`NodePort` 및 `LoadBalancer` 서비스는 이제 `service.spec.externalTrafficPolicy`를 `Local`로 설정하여 [클라이언스 소스 IP를 유지](cs_loadbalancer.html#node_affinity_tolerations)하는 것을 지원합니다. </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>이전 클러스터의 [에지 노드](cs_edge.html#edge) 결함 허용 설정을 수정합니다. </td>
</tr>
</tbody>
</table>

## 버전 1.7 변경 로그
{: #17_changelog}

다음 변경사항을 검토하십시오. 

### 1.7.16_1511의 변경 로그
{: #1716_1511}

<table summary="버전 1.7.4_1509 이후의 변경사항">
<caption>버전 1.7.4_1509 이후의 변경사항</caption>
<thead>
<tr>
<th>컴포넌트</th>
<th>이전</th>
<th>현재</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)를 참조하십시오. </td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort` 및 `LoadBalancer` 서비스는 이제 `service.spec.externalTrafficPolicy`를 `Local`로 설정하여 [클라이언스 소스 IP를 유지](cs_loadbalancer.html#node_affinity_tolerations)하는 것을 지원합니다. </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>이전 클러스터의 [에지 노드](cs_edge.html#edge) 결함 허용 설정을 수정합니다. </td>
</tr>
</tbody>
</table>

