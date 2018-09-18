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



# 버전 변경 로그
{: #changelog}

{{site.data.keyword.containerlong}} Kubernetes 클러스터에 대해 사용 가능한 주 버전, 부 버전 및 패치 업데이트의 버전 변경 정보를 보십시오. 변경사항에는 Kubernetes 및 {{site.data.keyword.Bluemix_notm}} Provider 컴포넌트에 대한 업데이트가 포함됩니다.
{:shortdesc}

IBM은 패치 레벨 업데이트를 마스터에 자동으로 적용하지만 사용자는 [작업자 노드 패치를 업데이트](cs_cluster_update.html#worker_node)해야 합니다. 마스터 및 작업자 노드 모두의 경우, 사용자는 [기본 및 보조](cs_versions.html#update_types) 업데이트를 적용해야 합니다. 사용 가능한 업데이트를 매월 확인하십시오. 업데이트가 사용 가능한 경우에는 `ibmcloud ks clusters`, `cluster-get`, `workers` 또는 `worker-get` 등의 명령으로 GUI 또는 CLI에서 마스터 및 작업자 노드에 대한 정보를 볼 때 알림이 나타납니다. 

마이그레이션 조치에 대한 요약은 [Kubernetes 버전](cs_versions.html)을 참조하십시오.
{: tip}

이전 버전에서 변경된 사항에 대한 정보는 다음 변경 로그를 보십시오.
-  버전 1.10 [변경 로그](#110_changelog).
-  버전 1.9 [변경 로그](#19_changelog).
-  버전 1.8 [변경 로그](#18_changelog).
-  더 이상 사용되지 않거나 지원되지 않는 버전에 대한 변경 로그의 [아카이브](#changelog_archive). 

## 버전 1.10 변경 로그
{: #110_changelog}

다음 변경사항을 검토하십시오.

### 2018년 7월 27일에 릴리스된 1.10.5_1517에 대한 변경 로그
{: #1105_1517}

<table summary="버전 1.10.3_1514 이후에 작성된 변경사항">
<caption>버전 1.10.3_1514 이후의 변경사항</caption>
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
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>Calico [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/releases/#v313)를 참조하십시오.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Kubernetes 1.10.5 릴리스를 지원하도록 업데이트되었습니다. 또한 LoadBalancer 서비스 `create failure` 이벤트에 이제 포터블 서브넷 오류가 포함되어 있습니다. </td>
</tr>
<tr>
<td>IBM 파일 스토리지 플러그인</td>
<td>320</td>
<td>334</td>
<td>지속적 볼륨 작성에 대한 제한시간이 15분에서 30분으로 증가되었습니다. 기본 비용 청구 유형이 `hourly`로 변경되었습니다. 사전 정의된 스토리지 클래스에 마운트 옵션이 추가되었습니다. IBM Cloud 인프라(SoftLayer) 계정의 NFS 파일 스토리지 인스턴스에서 **참고** 필드가 JSON 형식으로 변경되었으며 PV가 배치된 Kubernetes 네임스페이스가 추가되었습니다. 다중 구역 클러스터를 지원하기 위해 지속적 볼륨에 구역 및 지역 레이블이 추가되었습니다. </td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>Kubernetes [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5)를 참조하십시오.</td>
</tr>
<tr>
<td>Kernel</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>고성능 네트워킹 워크로드에 대한 작업자 노드 네트워크 설정이 다소 개선되었습니다. </td>
</tr>
<tr>
<td>OpenVPN 클라이언트</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kube-system` 네임스페이스에서 실행되는 OpenVPN 클라이언트 `vpn` 배치가 이제 Kubernetes `addon-manager`에 의해 관리됩니다. </td>
</tr>
</tbody>
</table>

### 2018년 7월 3일에 릴리스된 작업자 노드 수정팩 1.10.3_1514에 대한 변경 로그
{: #1103_1514}

<table summary="버전 1.10.3_1513 이후에 작성된 변경사항">
<caption>버전 1.10.3_1513 이후의 변경사항</caption>
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
<td>Kernel</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>고성능 네트워킹 워크로드에 대해 최적화된 `sysctl`. </td>
</tr>
</tbody>
</table>


### 2018년 6월 21일에 릴리스된 작업자 노드 수정팩 1.10.3_1513에 대한 변경 로그
{: #1103_1513}

<table summary="버전 1.10.3_1512 이후에 작성된 변경사항">
<caption>버전 1.10.3_1512 이후의 변경사항</caption>
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
<td>Docker</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>암호화되지 않은 머신 유형의 경우, 보조 디스크는 작업자 노드를 다시 로드하거나 업데이트할 때 새 파일 시스템을 가져오면 정리됩니다. </td>
</tr>
</tbody>
</table>

### 2018년 6월 12일에 릴리스된 1.10.3_1512에 대한 변경 로그
{: #1103_1512}

<table summary="버전 1.10.1_1510 이후에 작성된 변경사항">
<caption>버전 1.10.1_1510 이후의 변경사항</caption>
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
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>Kubernetes [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 구성</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>클러스터의 Kubernetes API 서버에 대한 `--enable-admission-plugins` 옵션에 `PodSecurityPolicy`가 추가되었으며 팟(Pod) 보안 정책을 지원하도록 클러스터가 구성되었습니다. 자세한 정보는 [팟(Pod) 보안 정책 구성](cs_psp.html)을 참조하십시오. </td>
</tr>
<tr>
<td>Kubelet 구성</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kubelet` HTTPS 엔드포인트에 대한 인증을 위한 API 베어러 및 서비스 계정 토큰을 지원하기 위해 `--authentication-token-webhook` 옵션이 사용됩니다. </td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Kubernetes 1.10.3 릴리스를 지원하도록 업데이트되었습니다. </td>
</tr>
<tr>
<td>OpenVPN 클라이언트</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kube-system` 네임스페이스에서 실행되는 OpenVPN 클라이언트 `vpn` 배치에 `livenessProbe`가 추가되었습니다. </td>
</tr>
<tr>
<td>커널 업데이트</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639)에 대한 커널 업데이트가 있는 새 작업자 이미지. </td>
</tr>
</tbody>
</table>



### 2018년 5월 18일에 릴리스된 작업자 노드 수정팩 1.10.1_1510에 대한 변경 로그
{: #1101_1510}

<table summary="버전 1.10.1_1509 이후에 작성된 변경사항">
<caption>버전 1.10.1_1509 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>블록 스토리지 플러그인을 사용한 경우 발생한 버그를 해결하기 위한 수정사항입니다.</td>
</tr>
</tbody>
</table>

### 2018년 5월 16일에 릴리스된 작업자 노드 수정팩 1.10.1_1509에 대한 변경 로그
{: #1101_1509}

<table summary="버전 1.10.1_1508 이후에 작성된 변경사항">
<caption>버전 1.10.1_1508 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kubelet` 루트 디렉토리에 저장하는 데이터가 이제 작업자 노드 머신의 더 큰 보조 디스크에 저장됩니다.</td>
</tr>
</tbody>
</table>

### 2018년 5월 1일에 릴리스된 1.10.1_1508에 대한 변경 로그
{: #1101_1508}

<table summary="버전 1.9.7_1510 이후에 작성된 변경사항">
<caption>버전 1.9.7_1510 이후의 변경사항</caption>
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
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>Calico [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/releases/#v311)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>Kubernetes Heapster [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>Kubernetes [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 구성</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>클러스터의 Kubernetes API 서버에 대한 <code>--enable-admission-plugins</code> 옵션에 <code>StorageObjectInUseProtection</code>이 추가되었습니다.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>Kubernetes DNS [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/dns/releases/tag/1.14.10)를 참조하십시오.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Kubernetes 1.10 릴리스를 지원하도록 업데이트되었습니다.</td>
</tr>
<tr>
<td>GPU 지원</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>이제 스케줄링 및 실행을 위해 [그래픽 처리 장치(GPU) 컨테이너 워크로드](cs_app.html#gpu_app)에 대한 지원을 사용할 수 있습니다. 사용 가능한 GPU 머신 유형의 목록은 [작업자 노드에 대한 하드웨어](cs_clusters.html#shared_dedicated_node)를 참조하십시오. 자세한 정보는 [GPU 스케줄 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)에 대한 Kubernetes 문서를 참조하십시오.</td>
</tr>
</tbody>
</table>

## 버전 1.9 변경 로그
{: #19_changelog}

다음 변경사항을 검토하십시오.

### 2018년 7월 27일에 릴리스된 1.9.9_1520에 대한 변경 로그
{: #199_1520}

<table summary="버전 1.9.8_1517 이후에 작성된 변경사항">
<caption>버전 1.9.8_1517 이후의 변경사항</caption>
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
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Kubernetes 1.9.9 릴리스를 지원하도록 업데이트되었습니다. 또한 LoadBalancer 서비스 `create failure` 이벤트에 이제 포터블 서브넷 오류가 포함되어 있습니다. </td>
</tr>
<tr>
<td>IBM 파일 스토리지 플러그인</td>
<td>320</td>
<td>334</td>
<td>지속적 볼륨 작성에 대한 제한시간이 15분에서 30분으로 증가되었습니다. 기본 비용 청구 유형이 `hourly`로 변경되었습니다. 사전 정의된 스토리지 클래스에 마운트 옵션이 추가되었습니다. IBM Cloud 인프라(SoftLayer) 계정의 NFS 파일 스토리지 인스턴스에서 **참고** 필드가 JSON 형식으로 변경되었으며 PV가 배치된 Kubernetes 네임스페이스가 추가되었습니다. 다중 구역 클러스터를 지원하기 위해 지속적 볼륨에 구역 및 지역 레이블이 추가되었습니다. </td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>Kubernetes [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9)를 참조하십시오.</td>
</tr>
<tr>
<td>Kernel</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>고성능 네트워킹 워크로드에 대한 작업자 노드 네트워크 설정이 다소 개선되었습니다. </td>
</tr>
<tr>
<td>OpenVPN 클라이언트</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kube-system` 네임스페이스에서 실행되는 OpenVPN 클라이언트 `vpn` 배치가 이제 Kubernetes `addon-manager`에 의해 관리됩니다. </td>
</tr>
</tbody>
</table>

### 2018년 7월 3일에 릴리스된 작업자 노드 수정팩 1.9.8_1517에 대한 변경 로그
{: #198_1517}

<table summary="버전 1.9.8_1516 이후에 작성된 변경사항">
<caption>버전 1.9.8_1516 이후의 변경사항</caption>
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
<td>Kernel</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>고성능 네트워킹 워크로드에 대해 최적화된 `sysctl`. </td>
</tr>
</tbody>
</table>


### 2018년 6월 21일에 릴리스된 작업자 노드 수정팩 1.9.8_1516에 대한 변경 로그
{: #198_1516}

<table summary="버전 1.9.8_1515 이후에 작성된 변경사항">
<caption>버전 1.9.8_1515 이후의 변경사항</caption>
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
<td>Docker</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>암호화되지 않은 머신 유형의 경우, 보조 디스크는 작업자 노드를 다시 로드하거나 업데이트할 때 새 파일 시스템을 가져오면 정리됩니다. </td>
</tr>
</tbody>
</table>

### 2018년 6월 19일에 릴리스된 1.9.8_1515에 대한 변경 로그
{: #198_1515}

<table summary="버전 1.9.7_1513 이후에 작성된 변경사항">
<caption>버전 1.9.7_1513 이후의 변경사항</caption>
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
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 구성</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>클러스터의 Kubernetes API 서버에 대한 --admission-control 옵션에 PodSecurityPolicy가 추가되었으며 팟(Pod) 보안 정책을 지원하도록 클러스터가 구성되었습니다. 자세한 정보는 [팟(Pod) 보안 정책 구성](cs_psp.html)을 참조하십시오. </td>
</tr>
<tr>
<td>IBM Cloud 제공자</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Kubernetes 1.9.8 릴리스를 지원하도록 업데이트되었습니다. </td>
</tr>
<tr>
<td>OpenVPN 클라이언트</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td><code>kube-system</code> 네임스페이스에서 실행되는 OpenVPN 클라이언트 <code>vpn</code> 배치에 <code>livenessProbe</code>가 추가되었습니다. </td>
</tr>
</tbody>
</table>


### 2018년 6월 11일에 릴리스된 작업자 노드 수정팩 1.9.7_1513에 대한 변경 로그
{: #197_1513}

<table summary="버전 1.9.7_1512 이후에 작성된 변경사항">
<caption>버전 1.9.7_1512 이후의 변경사항</caption>
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
<td>커널 업데이트</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639)에 대한 커널 업데이트가 있는 새 작업자 이미지. </td>
</tr>
</tbody>
</table>

### 2018년 5월 18일에 릴리스된 작업자 노드 수정팩 1.9.7_1512에 대한 변경 로그
{: #197_1512}

<table summary="버전 1.9.7_1511 이후에 작성된 변경사항">
<caption>버전 1.9.7_1511 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>블록 스토리지 플러그인을 사용한 경우 발생한 버그를 해결하기 위한 수정사항입니다.</td>
</tr>
</tbody>
</table>

### 2018년 5월 16일에 릴리스된 작업자 노드 수정팩 1.9.7_1511에 대한 변경 로그
{: #197_1511}

<table summary="버전 1.9.7_1510 이후에 작성된 변경사항">
<caption>버전 1.9.7_1510 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kubelet` 루트 디렉토리에 저장하는 데이터가 이제 작업자 노드 머신의 더 큰 보조 디스크에 저장됩니다.</td>
</tr>
</tbody>
</table>

### 2018년 4월 30일에 릴리스된 1.9.7_1510에 대한 변경 로그
{: #197_1510}

<table summary="버전 1.9.3_1506 이후에 작성된 변경사항">
<caption>버전 1.9.3_1506 이후의 변경사항</caption>
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
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7)를 참조하십시오. 이 릴리스에서는 [CVE-2017-1002101 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 및 [CVE-2017-1002102 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 취약성이 해결되었습니다.</p><p><strong>참고</strong>: 이제 `secret`, `configMap`, `downwardAPI` 및 투영된 볼륨은 읽기 전용으로 마운트됩니다. 이전에는 시스템이 자동으로 되돌릴 수 있는 이러한 볼륨에 앱이 데이터를 쓸 수 있었습니다. 앱이 이전의 안전하지 않은 작동에 의존하는 경우에는 이를 적절히 수정하십시오.</p></td>
</tr>
<tr>
<td>Kubernetes 구성</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>클러스터의 Kubernetes API 서버에 대한 `--runtime-config` 옵션에 <code>admissionregistration.k8s.io/v1alpha1=true</code>가 추가되었습니다.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>`NodePort` 및 `LoadBalancer` 서비스는 이제 `service.spec.externalTrafficPolicy`를 `Local`로 설정하여 [클라이언스 소스 IP를 유지](cs_loadbalancer.html#node_affinity_tolerations)하는 것을 지원합니다.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>이전 클러스터의 [에지 노드](cs_edge.html#edge) 결함 허용(toleration) 설정을 수정합니다.</td>
</tr>
</tbody>
</table>

## 버전 1.8 변경 로그
{: #18_changelog}

다음 변경사항을 검토하십시오.

### 2018년 7월 27일에 릴리스된 1.8.15_1518에 대한 변경 로그
{: #1815_1518}

<table summary="버전 1.8.13_1516 이후에 작성된 변경사항">
<caption>버전 1.8.13_1516 이후의 변경사항</caption>
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
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Kubernetes 1.8.15 릴리스를 지원하도록 업데이트되었습니다. 또한 LoadBalancer 서비스 `create failure` 이벤트에 이제 포터블 서브넷 오류가 포함되어 있습니다. </td>
</tr>
<tr>
<td>IBM 파일 스토리지 플러그인</td>
<td>320</td>
<td>334</td>
<td>지속적 볼륨 작성에 대한 제한시간이 15분에서 30분으로 증가되었습니다. 기본 비용 청구 유형이 `hourly`로 변경되었습니다. 사전 정의된 스토리지 클래스에 마운트 옵션이 추가되었습니다. IBM Cloud 인프라(SoftLayer) 계정의 NFS 파일 스토리지 인스턴스에서 **참고** 필드가 JSON 형식으로 변경되었으며 PV가 배치된 Kubernetes 네임스페이스가 추가되었습니다. 다중 구역 클러스터를 지원하기 위해 지속적 볼륨에 구역 및 지역 레이블이 추가되었습니다. </td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>Kubernetes [릴리스 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15)를 참조하십시오.</td>
</tr>
<tr>
<td>Kernel</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>고성능 네트워킹 워크로드에 대한 작업자 노드 네트워크 설정이 다소 개선되었습니다. </td>
</tr>
<tr>
<td>OpenVPN 클라이언트</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kube-system` 네임스페이스에서 실행되는 OpenVPN 클라이언트 `vpn` 배치가 이제 Kubernetes `addon-manager`에 의해 관리됩니다. </td>
</tr>
</tbody>
</table>

### 2018년 7월 3일에 릴리스된 작업자 노드 수정팩 1.8.13_1516에 대한 변경 로그
{: #1813_1516}

<table summary="버전 1.8.13_1515 이후에 작성된 변경사항">
<caption>버전 1.8.13_1515 이후의 변경사항</caption>
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
<td>Kernel</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>고성능 네트워킹 워크로드에 대해 최적화된 `sysctl`. </td>
</tr>
</tbody>
</table>


### 2018년 6월 21일에 릴리스된 작업자 노드 수정팩 1.8.13_1515에 대한 변경 로그
{: #1813_1515}

<table summary="버전 1.8.13_1514 이후에 작성된 변경사항">
<caption>버전 1.8.13_1514 이후의 변경사항</caption>
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
<td>Docker</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>암호화되지 않은 머신 유형의 경우, 보조 디스크는 작업자 노드를 다시 로드하거나 업데이트할 때 새 파일 시스템을 가져오면 정리됩니다. </td>
</tr>
</tbody>
</table>

### 2018년 6월 19일에 릴리스된 1.8.13_1514에 대한 변경 로그
{: #1813_1514}

<table summary="버전 1.8.11_1512 이후에 작성된 변경사항">
<caption>버전 1.8.11_1512 이후의 변경사항</caption>
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
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 구성</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>클러스터의 Kubernetes API 서버에 대한 --admission-control 옵션에 PodSecurityPolicy가 추가되었으며 팟(Pod) 보안 정책을 지원하도록 클러스터가 구성되었습니다. 자세한 정보는 [팟(Pod) 보안 정책 구성](cs_psp.html)을 참조하십시오. </td>
</tr>
<tr>
<td>IBM Cloud 제공자</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Kubernetes 1.8.13 릴리스를 지원하도록 업데이트되었습니다. </td>
</tr>
<tr>
<td>OpenVPN 클라이언트</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td><code>kube-system</code> 네임스페이스에서 실행되는 OpenVPN 클라이언트 <code>vpn</code> 배치에 <code>livenessProbe</code>가 추가되었습니다. </td>
</tr>
</tbody>
</table>


### 2018년 6월 11일에 릴리스된 작업자 노드 수정팩 1.8.11_1512에 대한 변경 로그
{: #1811_1512}

<table summary="버전 1.8.11_1511 이후에 작성된 변경사항">
<caption>버전 1.8.11_1511 이후의 변경사항</caption>
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
<td>커널 업데이트</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639)에 대한 커널 업데이트가 있는 새 작업자 이미지. </td>
</tr>
</tbody>
</table>


### 2018년 5월 18일에 릴리스된 작업자 노드 수정팩 1.8.11_1511에 대한 변경 로그
{: #1811_1511}

<table summary="버전 1.8.11_1510 이후에 작성된 변경사항">
<caption>버전 1.8.11_1510 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>블록 스토리지 플러그인을 사용한 경우 발생한 버그를 해결하기 위한 수정사항입니다.</td>
</tr>
</tbody>
</table>

### 2018년 5월 16일에 릴리스된 작업자 노드 수정팩 1.8.11_1510에 대한 변경 로그
{: #1811_1510}

<table summary="버전 1.8.11_1509 이후에 작성된 변경사항">
<caption>버전 1.8.11_1509 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kubelet` 루트 디렉토리에 저장하는 데이터가 이제 작업자 노드 머신의 더 큰 보조 디스크에 저장됩니다.</td>
</tr>
</tbody>
</table>


### 2018년 4월 19일에 릴리스된 1.8.11_1509에 대한 변경 로그
{: #1811_1509}

<table summary="버전 1.8.8_1507 이후에 작성된 변경사항">
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
<td><p>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)를 참조하십시오. 이 릴리스에서는 [CVE-2017-1002101 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 및 [CVE-2017-1002102 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 취약성이 해결되었습니다.</p><p><strong>참고</strong>: 이제 `secret`, `configMap`, `downwardAPI` 및 투영된 볼륨은 읽기 전용으로 마운트됩니다. 이전에는 시스템이 자동으로 되돌릴 수 있는 이러한 볼륨에 앱이 데이터를 쓸 수 있었습니다. 앱이 이전의 안전하지 않은 작동에 의존하는 경우에는 이를 적절히 수정하십시오.</p></td>
</tr>
<tr>
<td>컨테이너 이미지 일시정지</td>
<td>3.0</td>
<td>3.1</td>
<td>상속된 고아 좀비 프로세스를 제거합니다.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>`NodePort` 및 `LoadBalancer` 서비스는 이제 `service.spec.externalTrafficPolicy`를 `Local`로 설정하여 [클라이언스 소스 IP를 유지](cs_loadbalancer.html#node_affinity_tolerations)하는 것을 지원합니다.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>이전 클러스터의 [에지 노드](cs_edge.html#edge) 결함 허용(toleration) 설정을 수정합니다.</td>
</tr>
</tbody>
</table>

## 아카이브
{: #changelog_archive}

### 버전 1.7 변경 로그(지원되지 않음)
{: #17_changelog}

다음 변경사항을 검토하십시오.

#### 2018년 6월 11일에 릴리스된 작업자 노드 수정팩 1.7.16_1514에 대한 변경 로그
{: #1716_1514}

<table summary="버전 1.7.16_1513 이후에 작성된 변경사항">
<caption>버전 1.7.16_1513 이후의 변경사항</caption>
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
<td>커널 업데이트</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639)에 대한 커널 업데이트가 있는 새 작업자 이미지. </td>
</tr>
</tbody>
</table>

#### 2018년 5월 18일에 릴리스된 작업자 노드 수정팩 1.7.16_1513에 대한 변경 로그
{: #1716_1513}

<table summary="버전 1.7.16_1512 이후에 작성된 변경사항">
<caption>버전 1.7.16_1512 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>블록 스토리지 플러그인을 사용한 경우 발생한 버그를 해결하기 위한 수정사항입니다.</td>
</tr>
</tbody>
</table>

#### 2018년 5월 16일에 릴리스된 작업자 노드 수정팩 1.7.16_1512에 대한 변경 로그
{: #1716_1512}

<table summary="버전 1.7.16_1511 이후에 작성된 변경사항">
<caption>버전 1.7.16_1511 이후의 변경사항</caption>
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
<td>Kubelet</td>
<td>해당사항 없음</td>
<td>해당사항 없음</td>
<td>`kubelet` 루트 디렉토리에 저장하는 데이터가 이제 작업자 노드 머신의 더 큰 보조 디스크에 저장됩니다.</td>
</tr>
</tbody>
</table>

#### 2018년 4월 19일에 릴리스된 1.7.16_1511에 대한 변경 로그
{: #1716_1511}

<table summary="버전 1.7.4_1509 이후에 작성된 변경사항">
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
<td><p>[Kubernetes 릴리스 정보![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)를 참조하십시오. 이 릴리스에서는 [CVE-2017-1002101 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 및 [CVE-2017-1002102 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 취약성이 해결되었습니다.</p><p><strong>참고</strong>: 이제 `secret`, `configMap`, `downwardAPI` 및 투영된 볼륨은 읽기 전용으로 마운트됩니다. 이전에는 시스템이 자동으로 되돌릴 수 있는 이러한 볼륨에 앱이 데이터를 쓸 수 있었습니다. 앱이 이전의 안전하지 않은 작동에 의존하는 경우에는 이를 적절히 수정하십시오.</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort` 및 `LoadBalancer` 서비스는 이제 `service.spec.externalTrafficPolicy`를 `Local`로 설정하여 [클라이언스 소스 IP를 유지](cs_loadbalancer.html#node_affinity_tolerations)하는 것을 지원합니다.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>이전 클러스터의 [에지 노드](cs_edge.html#edge) 결함 허용(toleration) 설정을 수정합니다.</td>
</tr>
</tbody>
</table>
