---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

표에 클러스터를 새 버전으로 업데이트할 때 배치된 앱에 영향을 미칠 수 있는 업데이트가 포함되어 있습니다. Kubernetes 버전의 전체 변경사항 목록은 [Kubernetes changelog ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)을 검토하십시오.

업데이트 프로세스에 대한 자세한 정보는 [클러스터 업데이트](cs_cluster.html#cs_cluster_update) 및 [작업자 노드 업데이트](cs_cluster.html#cs_cluster_worker_update)를 참조하십시오.



## 버전 1.7
{: #cs_v17}

### 마스터 이전 업데이트
{: #17_before}

<table summary="버전 1.7 및 1.6에 대한 Kubernetes 업데이트">
<caption>표 1. 마스터를 Kubernetes 1.7로 업데이트하기 전에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</tr>
</thead>
<tbody>
<tr>
<td>스토리지</td>
<td>`../to/dir`과 같은 상위 디렉토리 참조를 포함하는 `hostPath` 및 `mountPath`가 있는 구성 스크립트는 허용되지 않습니다. 경로를 단순 절대 경로(예: `/path/to/dir`)로 변경하십시오.
<ol>
  <li>스토리지 경로를 업데이트해야 하는지 여부를 판별하려면 다음 명령을 실행하십시오.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>`Action required`가 리턴되면 작업자 노드를 업데이트하기 전에 절대 경로를 참조하도록 영향을 받는 각 포드를 수정하십시오.
다른 리소스(예: 배치)에서 포드를 소유하는 경우 해당 리소스 내에서 [_PodSpec_ ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core)을 수정하십시오.
</ol>
</td>
</tr>
</tbody>
</table>

### 마스터 이후 업데이트
{: #17_after}

<table summary="버전 1.7 및 1.6에 대한 Kubernetes 업데이트">
<caption>표 2. 마스터를 Kubernetes 1.7로 업데이트한 후에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>`kubectl` CLI를 클러스터의 버전으로 업데이트한 후 다음 `kubectl` 명령에서 쉼표로 구분된 인수 대신 여러 개의 플래그를 사용해야 합니다. <ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  예를 들어, `kubectl create role --resource-name <x>,<y>`이 아닌 `kubectl create role --resource-name <x> --resource-name<y>`을 실행하십시오.</td>
</tr>
<tr>
<td>포드 연관관계 스케줄링</td>
<td> `scheduler.alpha.kubernetes.io/affinity` 어노테이션은 더 이상 사용되지 않습니다.
<ol>
  <li>포드 연관관계 스케줄링을 업데이트해야 하는지 여부를 판별하려면 `ibm-system` 및 `kube-system`을 제외한 각 네임스페이스에 대해 다음 명령을 실행하십시오.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>`"Action required"`가 리턴되는 경우 `scheduler.alpha.kubernetes.io/affinity` 어노테이션 대신 [_PodSpec_ ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _선호도_ 필드를 사용하도록 영향을 받는 포드를 수정하십시오.
</ol>
</tr>
<tr>
<td>네트워크 정책</td>
<td>`net.beta.kubernetes.io/network-policy` 어노테이션은 더 이상 지원되지 않습니다.
<ol>
  <li>네트워크 정책을 업데이트해야 하는지 여부를 판별하려면 다음 명령을 실행하십시오.</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>`Action required`가 리턴되는 경우 나열된 각 Kubernetes 네임스페이스에 다음 네트워크 정책을 추가하십시오.</br>

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

  <li> 네트워크 정책이 준비되면 `net.beta.kubernetes.io/network-policy` 어노테이션을 제거하십시오.
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>결함 허용</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` 어노테이션은 더 이상 지원되지 않습니다.
<ol>
  <li>결함 허용을 업데이트해야 하는지 여부를 판별하려면 `ibm-system` 및 `kube-system`을 제외한 각 네임스페이스에 대해 다음 명령을 실행하십시오.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>`"Action required"`가 리턴되는 경우 `scheduler.alpha.kubernetes.io/tolerations` 어노테이션 대신 [_PodSpec_ ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _결함 허용_ 필드를 사용하도록 영향받는 포드를 수정하십시오.
</ol>
</tr>
<tr>
<td>오염</td>
<td>`scheduler.alpha.kubernetes.io/taints` 어노테이션은 더 이상 지원되지 않습니다.
<ol>
  <li>오염을 업데이트해야 하는지 여부를 판별하려면 다음 명령을 실행하십시오. </br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>`"Action required"`가 리턴되는 경우 지원되지 않는 어노테이션이 있는 각 노드에 대한 `scheduler.alpha.kubernetes.io/taints` 어노테이션을 제거하십시오.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>지원되지 않는 어노테이션이 제거되면 각 노드에 오염을 추가하십시오. `kubectl` CLI 버전 1.6 이상이 있어야 합니다.</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
  
  
