---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}}의 Kubernetes 버전
{: #cs_versions}

{{site.data.keyword.containerlong}}에서 사용 가능한 Kubernetes 버전을 검토하십시오.
{:shortdesc}

{{site.data.keyword.containershort_notm}}는 여러 버전의 Kubernetes를 지원합니다. 다른 버전을 지정하지 않은 경우 클러스터를 작성하거나 업데이트할 때 기본 버전이 사용됩니다. 사용 가능한 Kubernetes 버전은 다음과 같습니다.
- 1.8.6
- 1.7.4(기본 버전)
- 1.5.6

사용자가 로컬로 실행 중인 또는 사용자의 클러스터가 실행 중인 Kubernetes CLI의 버전을 확인하려면
다음 명령을 실행하고 버전을 확인하십시오.

```
        kubectl version  --short
```
{: pre}

출력 예:

```
Client Version: 1.7.4
Server Version: 1.7.4
```
{: screen}

## 업데이트 유형
{: #version_types}

Kubernetes는 다음 버전 업데이트 유형을 제공합니다.
{:shortdesc}

|업데이트 유형|버전 레이블의 예|업데이트 수행자|영향
|-----|-----|-----|-----|
|주요|1.x.x|사용자|스크립트 또는 배치를 포함한 클러스터의 오퍼레이션 변경.|
|보조|x.5.x|사용자|스크립트 또는 배치를 포함한 클러스터의 오퍼레이션 변경.|
|패치|x.x.3|IBM 및 사용자|스크립트 또는 배치 변경 없음. IBM은 자동으로 마스터를 업데이트하지만 사용자는 작업자 노드에 패치를 적용합니다.|
{: caption="Kubernetes 업데이트의 영향" caption-side="top"}

기본적으로 부 버전의 차이가 2를 넘게(상위) Kubernetes 마스터를 업데이트할 수 없습니다. 예를 들어, 현재 마스터가 버전 1.5이고 1.8로 업데이트하려면 먼저 1.7로 업데이트해야 합니다. 업데이트를 강제로 계속할 수 있지만 2를 넘는 부 버전 업데이트로 인해 예상치 못한 결과가 발생할 수 있습니다.
{: tip}

다음 표에는 클러스터를 새 버전으로 업데이트할 때 배치된 앱에 영향을 미칠 수 있는 업데이트가 요약되어 있습니다. Kubernetes 버전의 전체 변경사항 목록은 [Kubernetes changelog ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)를 검토하십시오.

업데이트 프로세스에 대한 자세한 정보는 [클러스터 업데이트](cs_cluster_update.html#master) 및 [작업자 노드 업데이트](cs_cluster_update.html#worker_node)를 참조하십시오.

## 버전 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="이 배지는 IBM Cloud 컨테이너 서비스에 대한 Kubernetes 버전 1.8 인증을 표시합니다."/> {{site.data.keyword.containerlong_notm}}는 CNCF Kubernetes Software Conformance Certification 프로그램에서 버전 1.8에 대해 인증된 Kubernetes 제품입니다. _Kubernetes®는 미국 또는 기타 국가에서 사용되는 Linux Foundation의 등록상표이며, Linux Foundation의 라이센스에 따라 사용됩니다. _</p>

Kubernetes 버전 1.8로 업데이트할 때 작성해야 할 변경사항을 검토하십시오.

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
<td colspan='2'>마스터를 업데이트하기 전에 필요한 변경사항 없음</td>
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
<td>버전 1.8에서 Kubernetes 대시보드에 액세스하기 위한 URL이 변경되었고 로그인 프로세스에 새 인증 단계가 포함됩니다. 자세한 정보는 [Kubernetes 대시보드에 액세스](cs_app.html#cli_dashboard)를 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 대시보드 권한</td>
<td>사용자가 신임 정보로 로그인하여 버전 1.8에서 클러스터 리소스를 보도록 하려면 1.7 ClusterRoleBinding RBAC 권한을 제거하십시오. `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`를 실행하십시오.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>`kubectl delete` 명령은 오브젝트가 삭제되기 전에 포드와 같은 워크로드 API 오브젝트를 더 이상 축소하지 않습니다. 오브젝트를 축소해야 하는 경우, 오브젝트를 삭제하기 전에 [kubectl 스케일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale)을 사용하십시오. </td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` 명령은 쉼표로 구분된 인수 대신 `--env`의 다중 플래그를 사용해야 합니다. 예를 들어, <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>가 아니라 <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code>를 실행하십시오. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` 명령은 더 이상 사용 가능하지 않습니다.</td>
</tr>
</tbody>
</table>


## 버전 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="이 배지는 IBM Cloud 컨테이너 서비스에 대한 Kubernetes 버전 1.7 인증을 표시합니다."/> {{site.data.keyword.containerlong_notm}}는 CNCF Kubernetes Software Conformance Certification 프로그램에서 버전 1.7에 대해 인증된 Kubernetes 제품입니다.</p>

Kubernetes 버전 1.7로 업데이트할 때 작성해야 할 변경사항을 검토하십시오.

<br/>

### 마스터 이전 업데이트
{: #17_before}

<table summary="버전 1.7 및 1.6에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.7로 업데이트하기 전에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>스토리지</td>
<td>`../to/dir`과 같은 상위 디렉토리 참조를 포함하는 `hostPath` 및 `mountPath`가 있는 구성 스크립트는 허용되지 않습니다. 경로를 단순 절대 경로(예: `/path/to/dir`)로 변경하십시오.
<ol>
  <li>스토리지 경로를 변경할지 여부를 판별하십시오.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>`Action required`가 리턴되면 작업자 노드를 모두 업데이트하기 전에 절대 경로를 참조하도록 포드를 변경하십시오. 다른 리소스(예: 배치)에서 포드를 소유하는 경우 해당 리소스 내에서 [_PodSpec_ ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core)을 변경하십시오.
</ol>
</td>
</tr>
</tbody>
</table>

### 마스터 이후 업데이트
{: #17_after}

<table summary="버전 1.7 및 1.6에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.7로 업데이트한 후 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>`kubectl` CLI 업데이트 후 이러한 `kubectl create` 명령은 쉼표로 구분된 인수 대신 다중 플래그를 사용해야 합니다.<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  예를 들어, `kubectl create role --resource-name <x> , <y>`이 아닌 `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>포드 연관관계 스케줄링</td>
<td> `scheduler.alpha.kubernetes.io/affinity` 어노테이션은 더 이상 사용되지 않습니다.
<ol>
  <li>`ibm-system` 및 `kube-system`을 제외한 각 네임스페이스에서 포드 선호도 스케줄링을 업데이트할지 여부를 판별하십시오.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br></li>
  <li>`"Action required"`가 리턴되는 경우 `scheduler.alpha.kubernetes.io/affinity` 어노테이션 대신 [_PodSpec_ ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _선호도_ 필드를 사용하십시오.</li>
</ol>
</tr>
<tr>
<td>네트워크 정책</td>
<td>`net.beta.kubernetes.io/network-policy` 어노테이션은 더 이상 사용 가능하지 않습니다.
<ol>
  <li>정책을 변경할지 여부를 판별하십시오.</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>`"Action required"`가 리턴되는 경우 나열된 각 Kubernetes 네임스페이스에 다음 네트워크 정책을 추가하십시오.</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> 네트워크 정책을 추가한 후 `net.beta.kubernetes.io/network-policy` 어노테이션을 제거하십시오.
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </li></ol>
</tr>
<tr>
<td>결함 허용</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` 어노테이션은 더 이상 사용 가능하지 않습니다.
<ol>
  <li>`ibm-system` 및 `kube-system`을 제외한 각 네임스페이스에서 결함 허용을 변경할지 여부를 판별하십시오.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>`"Action required"`가 리턴되는 경우 `scheduler.alpha.kubernetes.io/tolerations` 어노테이션 대신 [_PodSpec_ ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _결함 허용_ 필드를 사용하십시오.
</ol>
</tr>
<tr>
<td>오염</td>
<td>`scheduler.alpha.kubernetes.io/taints` 어노테이션은 더 이상 사용 가능하지 않습니다.
<ol>
  <li>오염을 변경할지 여부를 판별하십시오.</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>`"Action required"`가 리턴되는 경우 각 노드에 대해 `scheduler.alpha.kubernetes.io/taints` 어노테이션을 제거하십시오.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>각 노드에 오염을 추가하십시오.</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</tr>
<tr>
<td>StatefulSet 포드 DNS</td>
<td>StatefulSet 포드는 마스터를 업데이트한 후 해당 Kubernetes DNS 항목을 잃습니다. DNS 항목을 복원하려면 StatefulSet 포드를 삭제하십시오. Kubernetes는 포드를 다시 작성하고 자동으로 DNS 항목을 복원합니다. 자세한 정보는 [Kubernetes 문제 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/issues/48327)를 참조하십시오.
</tr>
</tbody>
</table>
