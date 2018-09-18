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



# 버전 정보 및 업데이트 조치
{: #cs_versions}

## Kubernetes 버전 유형
{: #version_types}

{{site.data.keyword.containerlong}}는 동시에 여러 Kubernetes 버전을 지원합니다. 최신 버전이 릴리스될 때 최대 두 개의 이전 버전이(n-2)이 지원됩니다. 최신 버전보다 세 개 이상 이전인 버전(n-3)은 먼저 더 이상 사용되지 않게 되고 그런 다음 지원되지 않게 됩니다.
{:shortdesc}

**지원되는 Kubernetes 버전**:

- 최신: 1.10.5
- 기본: 1.10.5
- 기타: 1.9.9, 1.8.15

</br>

**더 이상 사용되지 않는 버전**: 더 이상 사용되지 않는 Kubernetes에서 클러스터가 실행되는 경우, 버전 지원이 중단되기 전에 지원되는 Kubernetes 버전을 검토하고 이로 업데이트할 수 있도록 30일이 제공됩니다. 폐기 기간 중에 클러스터는 여전히 전적으로 지원됩니다. 그러나 더 이상 사용되지 않는 버전을 사용하는 새 클러스터는 작성할 수 없습니다. 

**지원되지 않는 버전**: 지원되지 않는 Kubernetes 버전에서 클러스터를 실행 중인 경우에는 업데이트에 대한 [잠재적인 영향을 검토](#version_types)한 후에 즉시 [클러스터를 업데이트](cs_cluster_update.html#update)하여 중요한 보안 업데이트 및 지원을 계속 받으십시오. 
*  **주의**: 클러스터가 지원되는 버전 이전의 3개 이상의 부 버전일 때까지 기다리면 업데이트를 강제 실행해야 하며, 이로 인해 예상치 못한 결과나 장애가 발생할 수 있습니다.  
*  지원되지 않는 클러스터는 기존 작업자 노드를 추가하거나 다시 로드할 수 없습니다.  
*  지원되는 버전으로 클러스터를 업데이트한 후에는 클러스터가 정상 오퍼레이션을 재개하고 지원을 계속 받을 수 있습니다. 

</br>

클러스터의 서버 버전을 확인하려면 다음 명령을 실행하십시오.

```
kubectl version  --short | grep -i server
```
{: pre}

출력 예:

```
Server Version: v1.10.5+IKS
```
{: screen}


## 업데이트 유형
{: #update_types}

Kubernetes 클러스터에 대한 업데이트에는 세 가지 유형(주 버전, 부 버전 및 패치)가 있습니다.
{:shortdesc}

|업데이트 유형|버전 레이블의 예|업데이트 수행자|영향
|-----|-----|-----|-----|
|주 버전|1.x.x|사용자|스크립트 또는 배치를 포함한 클러스터의 오퍼레이션 변경.|
|부 버전|x.9.x|사용자|스크립트 또는 배치를 포함한 클러스터의 오퍼레이션 변경.|
|패치|x.x.4_1510|IBM 및 사용자|Kubernetes 패치 및 기타 {{site.data.keyword.Bluemix_notm}} Provider 컴포넌트 업데이트(보안 및 운영 체제 패치 등)입니다. 마스터는 IBM이 자동으로 업데이트하지만 작업자 노드에는 사용자가 패치를 적용해야 합니다.|
{: caption="Kubernetes 업데이트의 영향" caption-side="top"}

업데이트가 사용 가능한 경우에는 `ibmcloud ks workers <cluster>` 또는 `ibmcloud ks worker-get <cluster> <worker>` 명령 등을 사용하여 작업자 노드에 대한 정보를 볼 때 알림을 받습니다.
-  **주 버전 및 부 버전 업데이트**: 먼저 [마스터 노드를 업데이트](cs_cluster_update.html#master)한 후 [작업자 노드를 업데이트](cs_cluster_update.html#worker_node)하십시오.
   - 기본적으로 Kubernetes 마스터를 3개 이상의 부 버전 이후로 업데이트할 수 없습니다. 예를 들어, 현재 마스터가 버전 1.5이고 1.8로 업데이트하려면 먼저 1.7로 업데이트해야 합니다. 업데이트 강제 실행을 계속할 수 있지만, 3개 이상의 부 버전을 업데이트하면 예상치 못한 결과나 장애가 발생할 수 있습니다. 
   - 클러스터의 최소 `major.minor` CLI 버전과 일치하는 `kubectl` CLI 버전을 사용하는 경우 예상치 못한 결과가 발생할 수 있습니다. Kubernetes 클러스터 및 [CLI 버전](cs_cli_install.html#kubectl)을 최신 상태로 유지해야 합니다.
-  **패치 업데이트**: 업데이트가 사용 가능한지 여부를 매월 확인하고 `ibmcloud ks worker-update` [명령](cs_cli_reference.html#cs_worker_update) 또는 `ibmcloud ks worker-reload` [명령](cs_cli_reference.html#cs_worker_reload)을 사용하여 이러한 보안 및 운영 체제 패치를 적용하십시오. 자세한 정보는 [버전 변경 로그](cs_versions_changelog.html)를 참조하십시오.

<br/>

이 정보에는 클러스터를 이전 버전에서 새 버전으로 업데이트할 때 배치된 앱에 영향을 미칠 수 있는 업데이트가 요약되어 있습니다.
-  버전 1.10 [마이그레이션 조치](#cs_v110).
-  버전 1.9 [마이그레이션 조치](#cs_v19).
-  버전 1.8 [마이그레이션 조치](#cs_v18).
-  더 이상 사용되지 않거나 지원되지 않는 버전의 [아카이브](#k8s_version_archive).

<br/>

전체 변경사항 목록은 다음 정보를 검토하십시오.
* [Kubernetes 변경 로그 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [IBM 버전 변경 로그](cs_versions_changelog.html).

## 버전 1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="이 배지는 IBM Cloud 컨테이너 서비스에 대한 Kubernetes 버전 1.10 인증을 표시합니다."/> {{site.data.keyword.containerlong_notm}}는 CNCF Kubernetes Software Conformance Certification 프로그램에서 버전 1.10에 대해 인증된 Kubernetes 제품입니다. _Kubernetes®는 미국 또는 기타 국가에서 사용되는 Linux Foundation의 등록상표이며, Linux Foundation의 라이센스에 따라 사용됩니다. _</p>

이전 Kubernetes 버전에서 1.10으로 업데이트 중일 때 작성해야 할 변경사항을 검토하십시오.

**중요**: Kubernetes 1.10으로 업데이트하려면 먼저 [Calico v3으로 업데이트 준비](#110_calicov3)에 나열된 단계를 따라야 합니다.

<br/>

### 마스터 이전 업데이트
{: #110_before}

<table summary="버전 1.10에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.10으로 업데이트하기 전에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>Kubernetes 버전 1.10으로 업데이트하면 Calico도 v2.6.5에서 v3.1.1로 업데이트됩니다. <strong>중요</strong>: Kubernetes v1.10으로 업데이트하려면 먼저 [Calico v3으로 업데이트 준비](#110_calicov3)에 나열된 단계를 따라야 합니다.</td>
</tr>
<tr>
<td>Kubernetes 대시보드 네트워크 정책</td>
<td>Kubernetes 1.10에서는 <code>kube-system</code> 네임스페이스의 <code>kubernetes-dashboard</code> 네트워크 정책이 모든 팟(Pod)이 Kubernetes 대시보드에 액세스하지 못하도록 차단합니다. 그러나 {{site.data.keyword.Bluemix_notm}} 콘솔에서 또는 <code>kubectl proxy</code>를 사용하여 대시보드에 액세스하는 기능에는 영향을 미치지 <strong>않습니다</strong>. 팟(Pod)에 대시보드에 대한 액세스 권한이 필요한 경우 네임스페이스에 <code>kubernetes-dashboard-policy: allow</code> 레이블을 추가한 후 팟(Pod)을 네임스페이스에 배치할 수 있습니다.</td>
</tr>
<tr>
<td>Kubelet API 액세스</td>
<td>이제 Kubelet API 권한이 <code>Kubernetes API server</code>에 위임됩니다. Kubelet API에 대한 액세스는 <strong>노드</strong> 하위 리소스에 액세스하기 위한 권한을 부여하는 <code>ClusterRoles</code>를 기반으로 합니다. 기본적으로 Kubernetes Heapster에는 <code>ClusterRole</code> 및 <code>ClusterRoleBinding</code>이 있습니다. 그러나 다른 사용자 또는 앱에서 Kubelet API를 사용하는 경우 해당 사용자 또는 앱에 API를 사용할 수 있는 권한을 부여해야 합니다. [Kubelet 권한 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/)에 대한 Kubernetes 문서를 참조하십시오.</td>
</tr>
<tr>
<td>암호 스위트</td>
<td><code>Kubernetes API server</code> 및 Kubelet API에 대해 지원되는 암호 스위트가 이제 높은 강도의 암호화(128비트 이상)를 사용하는 서브세트로 제한됩니다. 강도가 낮은 암호를 사용하고 <code>Kubernetes API server</code> 또는 Kubelet API와의 통신에 의존하는 기존 자동화 또는 리소스가 있는 경우 마스터를 업데이트하기 전에 더 강력한 암호 지원을 사용으로 설정하십시오.</td>
</tr>
<tr>
<td>strongSwan VPN</td>
<td>VPN 연결에 [strongSwan](cs_vpn.html#vpn-setup)을 사용하는 경우에는 `helm delete --purge <release_name>`을 실행하여 클러스터를 업데이트하기 전에 차트를 제거해야 합니다. 클러스터 업데이트가 완료된 후에는 strongSwan Helm 차트를 다시 설치하십시오. </td>
</tr>
</tbody>
</table>

### 마스터 이후 업데이트
{: #110_after}

<table summary="버전 1.10에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.10으로 업데이트한 후 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>클러스터가 업데이트되면 클러스터에 적용된 기존의 모든 Calico 데이터가 Calico v3 구문을 사용하도록 자동으로 마이그레이션됩니다. Calico v3 구문을 사용하여 Calico 리소스를 보거나 추가하거나 수정하려면 [Calico CLI 구성을 버전 3.1.1로](#110_calicov3) 업데이트하십시오.</td>
</tr>
<tr>
<td>노드 <code>ExternalIP</code> 주소</td>
<td>이제 노드의 <code>ExternalIP</code> 필드가 노드의 공인 IP 주소 값으로 설정됩니다. 이 값이 종속되는 모든 리소스를 검토하고 업데이트하십시오.</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td>이제 <code>kubectl port-forward</code> 명령을 사용할 때 <code>-p</code> 플래그를 더 이상 지원하지 않습니다. 스크립트가 이전 동작에 의존하는 경우 <code>-p</code> 플래그를 팟(Pod) 이름으로 대체하도록 스크립트를 업데이트하십시오.</td>
</tr>
<tr>
<td>읽기 전용 API 데이터 볼륨</td>
<td>이제 `secret`, `configMap`, `downwardAPI` 및 투영된 볼륨은 읽기 전용으로 마운트됩니다.
이전에는 시스템이 자동으로 되돌릴 수 있는 이러한 볼륨에 앱이 데이터를
기록할 수 있었습니다. 이 마이그레이션 조치는 보안 취약성 [CVE-2017-1002102![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102)를 수정하는 데 필요합니다.
앱이 이전의 안전하지 않은 작동에 의존하는 경우에는 이를 적절히 수정하십시오.</td>
</tr>
<tr>
<td>strongSwan VPN</td>
<td>VPN 연결을 위해 [strongSwan](cs_vpn.html#vpn-setup)을 사용하며 클러스터를 업데이트하기 전에 차트를 삭제한 경우, 이제 strongSwan Helm 차트를 다시 설치할 수 있습니다. </td>
</tr>
</tbody>
</table>

### Calico v3으로 업데이트 준비
{: #110_calicov3}

시작하기 전에 클러스터 마스터 및 모든 작업자 노드가 Kubernetes 버전 1.8 이상을 실행 중이어야 하며 하나 이상의 작업자 노드를 보유해야 합니다.

**중요**: 마스터를 업데이트하기 전에 Calico v3 업데이트를 준비하십시오. 마스터를 Kubernetes v1.10으로 업그레이드하는 동안 새 팟(Pod) 및 새 Kubernetes 또는 Calico 네트워크 정책이 스케줄되지 않습니다. 업데이트로 인해 새로 스케줄링되지 못하는 시간은 경우에 따라 다릅니다. 소규모 클러스터에서는 몇 분이 소요되며 10개의 노드마다 몇 분이 더 추가될 수 있습니다. 기존 네트워크 정책 및 팟(Pod)은 계속 실행됩니다.

1.  Calico 팟(Pod)이 정상 상태인지 확인하십시오.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  팟(Pod)이 **실행 중** 상태가 아니면 해당 팟(Pod)을 삭제하고 계속하기 전에 **실행 중** 상태가 될 때까지 기다리십시오.

3.  Calico 정책 또는 Calico 리소스를 자동 생성하는 경우 [Calico v3 구문 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/)을 사용하여 이러한 리소스를 생성하도록 자동화 도구를 업데이트하십시오.

4.  VPN 연결을 위해 [strongSwan](cs_vpn.html#vpn-setup)을 사용하는 경우 strongSwan 2.0.0 Helm 차트는 Calico v3 또는 Kubernetes 1.10에서 작동하지 않습니다. Calico 2.6 및 Kubernetes 1.7, 1.8, 1.9와 역호환 가능한 2.1.0 Helm 차트로 [strongSwan을 업데이트](cs_vpn.html#vpn_upgrade)하십시오.

5.  [클러스터 마스터를 Kubernetes v1.10으로 업데이트](cs_cluster_update.html#master)하십시오.

<br />


## 버전 1.9
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="이 배지는 IBM Cloud 컨테이너 서비스에 대한 Kubernetes 버전 1.9 인증을 표시합니다."/> {{site.data.keyword.containerlong_notm}}는 CNCF Kubernetes Software Conformance Certification 프로그램에서 버전 1.9에 대해 인증된 Kubernetes 제품입니다. _Kubernetes®는 미국 또는 기타 국가에서 사용되는 Linux Foundation의 등록상표이며, Linux Foundation의 라이센스에 따라 사용됩니다. _</p>

이전 Kubernetes 버전에서 1.9로 업데이트 중일 때 작성해야 할 변경사항을 검토하십시오.

<br/>

### 마스터 이전 업데이트
{: #19_before}

<table summary="버전 1.9에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.9로 업데이트하기 전에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>웹훅 허가 API</td>
<td>API 서버가 허가 제어 웹훅을 호출할 때 사용되는 허가 API가 <code>admission.v1alpha1</code>에서 <code>admission.v1beta1</code>로 이동되었습니다. <em>클러스터를 업그레이드하기 전에 기존 웹훅을 삭제</em>하고 최신 API를 사용하도록 웹훅 구성 파일을 업데이트해야 합니다. 이 변경사항은 이전 버전과 호환 가능하지 않습니다.</td>
</tr>
</tbody>
</table>

### 마스터 이후 업데이트
{: #19_after}

<table summary="버전 1.9에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.9로 업데이트한 후 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>`kubectl` 출력</td>
<td>이제 `kubectl` 명령을 사용하여 `-o custom-columns`를 지정할 때 열이 오브젝트에 없는 경우 `<none>` 출력이 표시됩니다.<br>
이전에는 오퍼레이션이 실패하고 `xxx is not found`라는 오류 메시지가 표시되었습니다. 스크립트가 이전 동작에 의존하는 경우 스크립트를 업데이트하십시오.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>이제 패치된 리소스가 변경되지 않으면 `kubectl patch` 명령이 `exit code 1`과 함께 실패합니다. 스크립트가 이전 동작에 의존하는 경우 스크립트를 업데이트하십시오.</td>
</tr>
<tr>
<td>Kubernetes 대시보드 권한</td>
<td>사용자가 클러스터 리소스를 보려면 해당 신임 정보를 사용하여 Kubernetes 대시보드에 로그인해야 합니다. 기본 Kubernetes 대시보드 `ClusterRoleBinding` RBAC 권한이 제거되었습니다. 지시사항은 [Kubernetes 대시보드 실행](cs_app.html#cli_dashboard)을 참조하십시오.</td>
</tr>
<tr>
<td>읽기 전용 API 데이터 볼륨</td>
<td>이제 `secret`, `configMap`, `downwardAPI` 및 투영된 볼륨은 읽기 전용으로 마운트됩니다.
이전에는 시스템이 자동으로 되돌릴 수 있는 이러한 볼륨에 앱이 데이터를
기록할 수 있었습니다. 이 마이그레이션 조치는 보안 취약성
[CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102)를 수정하는 데 필요합니다.
앱이 이전의 안전하지 않은 작동에 의존하는 경우에는 이를 적절히 수정하십시오.</td>
</tr>
<tr>
<td>오염 및 결함 허용</td>
<td>`node.alpha.kubernetes.io/notReady` 및 `node.alpha.kubernetes.io/unreachable` 오염(taint)이 각각 `node.kubernetes.io/not-ready` 및 `node.kubernetes.io/unreachable`로 변경되었습니다.<br>
오염이 자동으로 업데이트되지만 이러한 오염에 대한 결함 허용(toleration)을 수동으로 업데이트해야 합니다. `ibm-system` 및 `kube-system`을 제외한 각 네임스페이스에서 결함 허용을 변경할지 여부를 판별하십시오.<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
`Action required`가 리턴되면 팟(Pod) 결함 허용을 적절히 수정하십시오.</td>
</tr>
<tr>
<td>웹훅 허가 API</td>
<td>클러스터를 업데이트하기 전에 기존 웹훅을 삭제한 경우 새 웹훅을 작성하십시오.</td>
</tr>
</tbody>
</table>

<br />



## 버전 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="padding-right: 10px;" align="left" alt="이 배지는 IBM Cloud 컨테이너 서비스에 대한 Kubernetes 버전 1.8 인증을 표시합니다."/> {{site.data.keyword.containerlong_notm}}는 CNCF Kubernetes Software Conformance Certification 프로그램에서 버전 1.8에 대해 인증된 Kubernetes 제품입니다. _Kubernetes®는 미국 또는 기타 국가에서 사용되는 Linux Foundation의 등록상표이며, Linux Foundation의 라이센스에 따라 사용됩니다. _</p>

이전 Kubernetes 버전에서 1.8로 업데이트 중일 때 작성해야 할 변경사항을 검토하십시오.

<br/>

### 마스터 이전 업데이트
{: #18_before}

<table summary="버전 1.8의 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.8로 업데이트하기 전에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>없음</td>
<td>마스터를 업데이트하기 전에 필요한 변경사항 없음</td>
</tr>
</tbody>
</table>

### 마스터 이후 업데이트
{: #18_after}

<table summary="버전 1.8의 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.8로 업데이트한 후 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes 대시보드 로그인</td>
<td>버전 1.8에서 Kubernetes 대시보드에 액세스하기 위한 URL이 변경되었고 로그인 프로세스에 새 인증 단계가 포함됩니다. 예를 들어, [Kubernetes 대시보드에 액세스](cs_app.html#cli_dashboard)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 대시보드 권한</td>
<td>사용자가 신임 정보로 로그인하여 버전 1.8에서 클러스터 리소스를 보도록 하려면 1.7 ClusterRoleBinding RBAC 권한을 제거하십시오. `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`를 실행하십시오.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>`kubectl delete` 명령은 오브젝트가 삭제되기 전에 팟(Pod)과 같은 워크로드 API 오브젝트를 더 이상 축소하지 않습니다. 오브젝트를 축소해야 하는 경우, 오브젝트를 삭제하기 전에 [`kubectl 스케일 ` ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/overview/#scale)을 사용하십시오.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` 명령은 쉼표로 구분된 인수 대신 `--env`의 다중 플래그를 사용해야 합니다. 예를 들어, <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>가 아니라 <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code>를 실행하십시오. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` 명령은 더 이상 사용 가능하지 않습니다.</td>
</tr>
<tr>
<td>읽기 전용 API 데이터 볼륨</td>
<td>이제 `secret`, `configMap`, `downwardAPI` 및 투영된 볼륨은 읽기 전용으로 마운트됩니다.
이전에는 시스템이 자동으로 되돌릴 수 있는 이러한 볼륨에 앱이 데이터를
기록할 수 있었습니다. 이 마이그레이션 조치는 보안 취약성
[CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102)를 수정하는 데 필요합니다.
앱이 이전의 안전하지 않은 작동에 의존하는 경우에는 이를 적절히 수정하십시오.</td>
</tr>
</tbody>
</table>

<br />



## 아카이브
{: #k8s_version_archive}

### 버전 1.7(지원되지 않음)
{: #cs_v17}

2018년 6월 21일 현재, [Kubernetes 버전 1.7](cs_versions_changelog.html#changelog_archive)을 실행하는 {{site.data.keyword.containershort_notm}} 클러스터는 지원되지 않습니다. 버전 1.7 클러스터는 다음 최신 버전([Kubernetes 1.8](#cs_v18))으로 업데이트되지 않는 한 보안 업데이트나 지원을 받을 수 없습니다. 

각 Kubernetes 버전 업데이트의 [잠재적인 영향을 검토](cs_versions.html#cs_versions)한 후에 최소한 버전 1.8로 즉시 [클러스터를 업데이트](cs_cluster_update.html#update)하십시오. 

### 버전 1.5(지원되지 않음)
{: #cs_v1-5}

2018년 4월 4일부터, [Kubernetes 버전 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md)를 실행하는 {{site.data.keyword.containershort_notm}} 클러스터는 지원되지 않습니다. 버전 1.5 클러스터는 다음 최신 버전([Kubernetes 1.8](#cs_v18))으로 업데이트되지 않는 한 보안 업데이트나 지원을 받을 수 없습니다. 

각 Kubernetes 버전 업데이트의 [잠재적인 영향을 검토](cs_versions.html#cs_versions)한 후에 최소한 버전 1.8로 즉시 [클러스터를 업데이트](cs_cluster_update.html#update)하십시오. 
