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



# 버전 정보 및 업데이트 조치
{: #cs_versions}

## Kubernetes 버전 유형
{: #version_types}

{{site.data.keyword.containerlong}}는 동시에 여러 Kubernetes 버전을 지원합니다. 최신 버전이 릴리스될 때 최대 두 개의 이전 버전이(n-2)이 지원됩니다. 최신 버전보다 세 개 이상 이전인 버전(n-3)은 먼저 더 이상 사용되지 않게 되고 그런 다음 지원되지 않게 됩니다.
{:shortdesc}

**지원되는 Kubernetes 버전**:

- 최신: 1.11.3
- 기본: 1.10.8
- 기타: 1.9.10

</br>

**더 이상 사용되지 않는 버전**: 더 이상 사용되지 않는 Kubernetes에서 클러스터가 실행되는 경우, 버전 지원이 중단되기 전에 지원되는 Kubernetes 버전을 검토하고 이로 업데이트할 수 있도록 30일이 제공됩니다. 폐기 기간 중에 클러스터는 여전히 전적으로 지원됩니다. 그러나 더 이상 사용되지 않는 버전을 사용하는 새 클러스터는 작성할 수 없습니다.

**지원되지 않는 버전**: 지원되지 않는 Kubernetes 버전에서 클러스터를 실행 중인 경우에는 아래 업데이트의 잠재적인 영향을 검토한 후에 즉시 [클러스터를 업데이트](cs_cluster_update.html#update)하여 중요한 보안 업데이트 및 지원을 계속 받으십시오. 
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
Server Version: v1.10.8+IKS
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
|패치|x.x.4_1510|IBM 및 사용자|Kubernetes 패치 및 기타 {{site.data.keyword.Bluemix_notm}} Provider 컴포넌트 업데이트(보안 및 운영 체제 패치 등)입니다. 마스터는 IBM이 자동으로 업데이트하지만 작업자 노드에는 사용자가 패치를 적용해야 합니다. 패치에 대한 자세한 정보는 다음 섹션을 참조하십시오. |
{: caption="Kubernetes 업데이트의 영향" caption-side="top"}

업데이트가 사용 가능한 경우에는 `ibmcloud ks workers <cluster>` 또는 `ibmcloud ks worker-get <cluster> <worker>` 명령 등을 사용하여 작업자 노드에 대한 정보를 볼 때 알림을 받습니다.
-  **주 버전 및 부 버전 업데이트**: 먼저 [마스터 노드를 업데이트](cs_cluster_update.html#master)한 후 [작업자 노드를 업데이트](cs_cluster_update.html#worker_node)하십시오.
   - 기본적으로 Kubernetes 마스터를 3개 이상의 부 버전 이후로 업데이트할 수 없습니다. 예를 들어, 현재 마스터가 버전 1.7이고 1.10로 업데이트하려면 먼저 1.9로 업데이트해야 합니다. 업데이트 강제 실행을 계속할 수 있지만, 3개 이상의 부 버전을 업데이트하면 예상치 못한 결과나 장애가 발생할 수 있습니다.
   - 클러스터의 최소 `major.minor` CLI 버전과 일치하는 `kubectl` CLI 버전을 사용하는 경우 예상치 못한 결과가 발생할 수 있습니다. Kubernetes 클러스터 및 [CLI 버전](cs_cli_install.html#kubectl)을 최신 상태로 유지해야 합니다.
-  **패치 업데이트**: 패치 간 변경사항은 [버전 변경 로그](cs_versions_changelog.html)에 기록되어 있습니다. 업데이트가 사용 가능한 경우에는 `ibmcloud ks clusters`, `cluster-get`, `workers` 또는 `worker-get` 등의 명령으로 GUI 또는 CLI에서 마스터 및 작업자 노드에 대한 정보를 볼 때 알림이 나타납니다.
   - **작업자 노드 패치**: 업데이트가 사용 가능한지 매월 확인하고, `ibmcloud ks worker-update` [명령](cs_cli_reference.html#cs_worker_update) 또는 `ibmcloud ks worker-reload` [명령](cs_cli_reference.html#cs_worker_reload)을 사용하여 이러한 보안 및 운영 체제 패치를 적용하십시오. 
   - **마스터 패치**: 마스터 패치는 며칠에 걸쳐 자동으로 적용되므로, 마스터에 적용되기 전에는 마스터 패치 버전이 사용 가능으로 표시되지 않을 수 있습니다. 업데이트 자동화는 비정상 상태이거나 현재 오퍼레이션이 진행 중인 클러스터 또한 건너뜁니다. 마스터가 한 부 버전에서 다른 부 버전으로 업데이트되는 경우에만 필요한 패치와 같은 특정 마스터 수정팩에 대해서는 IBM에서 자동 업데이트를 사용 안함으로 설정할 수 있습니다(변경 로그에 기록되어 있음). 이러한 경우에는 업데이트 자동화가 적용되기를 기다릴 필요 없이 직접 `ibmcloud ks cluster-update` [명령](cs_cli_reference.html#cs_cluster_update)을 사용할 수 있습니다. 

</br>

이 정보에는 클러스터를 이전 버전에서 새 버전으로 업데이트할 때 배치된 앱에 영향을 미칠 수 있는 업데이트가 요약되어 있습니다.
-  버전 1.11 [마이그레이션 조치](#cs_v111).
-  버전 1.10 [마이그레이션 조치](#cs_v110).
-  버전 1.9 [마이그레이션 조치](#cs_v19).
-  더 이상 사용되지 않거나 지원되지 않는 버전의 [아카이브](#k8s_version_archive).

<br/>

전체 변경사항 목록은 다음 정보를 검토하십시오.
* [Kubernetes 변경 로그 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [IBM 버전 변경 로그](cs_versions_changelog.html).

</br>

## 버전 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="이 배지는 IBM Cloud 컨테이너 서비스에 대한 Kubernetes 버전 1.11 인증을 표시합니다."/> {{site.data.keyword.containerlong_notm}}는 CNCF Kubernetes Software Conformance Certification 프로그램에서 버전 1.11에 대해 인증된 Kubernetes 제품입니다. _Kubernetes®는 미국 또는 기타 국가에서 사용되는 Linux Foundation의 등록상표이며, Linux Foundation의 라이센스에 따라 사용됩니다. _</p>

이전 Kubernetes 버전에서 1.11로 업데이트할 때 필요할 수 있는 변경사항을 검토하십시오.

**중요**:
Kubernetes 버전 1.9 이하에서 버전 1.11로 클러스터를 업데이트하려면 [Calico v3으로 업데이트 준비](#111_calicov3)에 나열된 단계를 따라야 합니다. 

### 마스터 이전 업데이트
{: #111_before}

<table summary="버전 1.11에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.11로 업데이트하기 전에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>`containerd` 새 Kubernetes 컨테이너 런타임</td>
<td><strong>중요</strong>: `containerd`는 Kubernetes의 새 컨테이너 런타임으로서 Docker를 대체합니다. 취해야 할 조치에 대해서는 [컨테이너 런타임으로서 `containerd`로 마이그레이션](#containerd)을 참조하십시오.</td>
</tr>
<tr>
<td>Kubernetes 컨테이너 볼륨 마운트 전파</td>
<td>컨테이너 `VolumeMount`에 대한 [`mountPropagation` 필드 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation)의 기본값이 `HostToContainer`에서 `None`으로 변경되었습니다. 이 변경사항으로 인해 Kubernetes 버전 1.9 이하에 존재하던 작동이 복원됩니다. 팟(Pod) 스펙이 기본값인 `HostToContainer`에 의존하는 경우에는 이를 업데이트하십시오.</td>
</tr>
<tr>
<td>Kubernetes API 서버 JSON 디시리얼라이저</td>
<td>Kubernetes API 서버 JSON 디시리얼라이저가 이제 대소문자를 구분합니다. 이 변경사항으로 인해 Kubernetes 버전 1.7 이하에 존재하던 작동이 복원됩니다. JSON 리소스 정의에서 올바르지 않은 대소문자를 사용하는 경우에는 이를 업데이트하십시오. <br><br>**참고**: 직접적인 Kubernetes API 서버 요청에만 영향이 있습니다. `kubectl` CLI가 Kubernetes 버전 1.7 이하에서 대소문자 구분 키를 계속해서 적용하므로, `kubectl`에서 리소스를 엄격하게 관리하는 경우에는 영향을 받지 않습니다.</td>
</tr>
</tbody>
</table>

### 마스터 이후 업데이트
{: #111_after}

<table summary="버전 1.11에 대한 Kubernetes 업데이트">
<caption>마스터를 Kubernetes 1.11로 업데이트한 후에 작성할 변경사항</caption>
<thead>
<tr>
<th>유형</th>
<th>설명</th>
</tr>
</thead>
<tbody>
<tr>
<td>클러스터 로깅 구성</td>
<td>`logging-autoupdate`를 사용하지 않아도 `fluentd` 클러스터 추가 기능이 버전 1.11에서 자동으로 업데이트됩니다.<br><br>
컨테이너 로그 디렉토리가 `/var/lib/docker/`에서 `/var/log/pods/`로 변경되었습니다. 이전 디렉토리를 모니터하는 자체 로깅 솔루션을 사용하는 경우에는 이에 맞게 업데이트하십시오.</td>
</tr>
<tr>
<td>Kubernetes 구성 새로 고치기</td>
<td>클러스터의 Kubernetes API 서버에 대한 OpenID Connect 구성이 {{site.data.keyword.Bluemix_notm}} Identity and Access Management(IAM) 액세스 그룹을 지원하도록 업데이트되었습니다. 따라서 클러스터의 Kubernetes v1.11 업데이트 이후에는 다음을 실행하여 Kubernetes 구성을 새로 고쳐야 합니다. `ibmcloud ks cluster-config --cluster <cluster_name_or_ID>`. <br><br>구성을 새로 고치지 않으면 다음 오류 메시지와 함께 클러스터 조치가 실패합니다. `You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>`kubectl` CLI</td>
<td>Kubernetes 버전 1.11용 `kubectl` CLI에서는 `apps/v1` API가 필요합니다. 따라서 v1.11 `kubectl` CLI는 Kubernetes 버전 1.8 이하를 실행하는 클러스터의 경우 작동하지 않습니다. 클러스터의 Kubernetes API 서버 버전과 일치하는 `kubectl` CLI의 버전을 사용하십시오.</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>이제 사용자에게 권한이 부여되지 않으면 `kubectl auth can-i` 명령이 `exit code 1`로 실패합니다. 스크립트가 이전 작동에 의존하는 경우에는 이를 업데이트하십시오.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>이제 레이블 등의 선택 기준을 사용하여 리소스를 삭제할 때 `kubectl delete` 명령이 기본적으로 `not found` 오류를 무시합니다. 스크립트가 이전 동작에 의존하는 경우 스크립트를 업데이트하십시오.</td>
</tr>
<tr>
<td>Kubernetes `sysctls` 기능</td>
<td>`security.alpha.kubernetes.io/sysctls` 어노테이션이 이제 무시됩니다. 대신 Kubernetes에서는 `sysctls`를 지정하고 제어하기 위해 `PodSecurityPolicy` 및 `Pod` 오브젝트에 필드를 추가했습니다. 자세한 정보는 [Kubernetes에서 sysctls 사용 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/)을 참조하십시오. <br><br>클러스터 마스터 및 작업자를 업데이트한 후에는 새 `sysctls` 필드를 사용할 수 있도록 `PodSecurityPolicy` 및 `Pod` 오브젝트를 업데이트하십시오.</td>
</tr>
</tbody>
</table>

### 컨테이너 런타임으로서 `containerd`로 마이그레이션
{: #containerd}

Kubernetes 버전 1.11 이상을 실행하는 클러스터의 경우, `containerd`는 성능 개선을 위해 Kubernetes의 새 컨테이너 런타임으로서 Docker를 대체합니다. 팟(Pod)이 Kubernetes 컨테이너 런타임으로서 Docker에 의존하는 경우, 사용자는 컨테이너 런타임으로서 `containerd`를 처리하도록 이를 업데이트해야 합니다. 자세한 정보는 [Kubernetes containerd 공지사항 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/)을 참조하십시오.
{: shortdesc}

**내 앱이 `containerd`가 아닌 `docker`에 의존하는지 어떻게 알 수 있습니까? **<br>
컨테이너 런타임으로서 Docker에 의존할 수 있는 경우의 예:
*  권한 부여된 컨테이너를 사용하여 직접 Docker 엔진 또는 API에 액세스하는 경우에는 런타임으로서 `containerd`를 지원하도록 팟(Pod)을 업데이트하십시오.
*  클러스터에 설치되는 일부 서드파티 추가 기능(예: 로깅 및 모니터링 도구)은 Docker 엔진에 의존할 수 있습니다. 제공업체에 문의하여 해당 도구가 `containerd`와 호환 가능한지 확인하십시오. 

<br>

**런타임에 대한 의존도 외에도 다른 마이그레이션 조치를 취해야 합니까?**<br>

**Manifest 도구**: Docker 버전 18.06 이전에 시범 `docker manifest` [도구 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.docker.com/edge/engine/reference/commandline/manifest/)로 빌드된 다중 플랫폼 이미지가 있는 경우에는 `containerd`를 사용하여 DockerHub에서 이미지를 가져올 수 없습니다.

팟(Pod) 이벤트를 확인할 때 다음과 같은 오류가 나타날 수 있습니다.
```
failed size validation
```
{: screen}

`containerd`와 함께 Manifest 도구를 사용하여 빌드된 이미지를 사용하려면 다음 옵션에서 선택하십시오.

*  [manifest 도구 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/estesp/manifest-tool)로 이미지를 다시 빌드합니다.
*  Docker 버전 18.06 이상으로 업데이트한 후에 `docker-manifest` 도구로 이미지를 다시 빌드합니다.

<br>

**영향을 받지 않는 것은 무엇입니까? 내 컨테이너를 배치하는 방법을 변경해야 합니까?**<br>
일반적으로 컨테이너 배치 프로세스는 변경되지 않습니다. 여전히 Dockerfile을 사용하여 Docker 이미지를 정의하고 앱에 대해 Docker 컨테이너를 빌드할 수 있습니다. `docker` 명령을 사용하여 이미지를 빌드하고 이를 레지스트리에 푸시하는 경우, 계속해서 `docker`를 사용하거나 `ibmcloud cr` 명령을 대신 사용할 수 있습니다.

### Calico v3으로 업데이트 준비
{: #111_calicov3}

**중요**: Kubernetes 버전 1.9 이하에서 버전 1.11로 클러스터를 업데이트하는 경우에는 마스터를 업데이트하기 전에 Calico v3 업데이트를 준비하십시오. 마스터를 Kubernetes v1.11로 업그레이드하는 동안에는 새 팟(Pod)과 새 Kubernetes 또는 Calico 네트워크 정책이 스케줄되지 않습니다. 업데이트로 인해 새로 스케줄되지 못하는 시간은 경우에 따라 다릅니다. 소규모 클러스터에서는 몇 분이 소요되며 10개의 노드마다 몇 분이 더 추가될 수 있습니다. 기존 네트워크 정책 및 팟(Pod)은 계속 실행됩니다.

**참고**: Kubernetes 버전 1.10 이하에서 버전 1.11로 클러스터를 업데이트하는 경우에는 이러한 단계를 1.10으로 업데이트할 때 완료했으므로 건너뛰십시오. 

이 작업을 시작하기 전에는 클러스터 마스터 및 모든 작업자 노드가 Kubernetes 버전 1.8 또는 1.9를 실행 중이어야 하며 하나 이상의 작업자 노드를 보유해야 합니다. 

1.  Calico 팟(Pod)이 정상 상태인지 확인하십시오.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  팟(Pod)이 **실행 중** 상태가 아니면 해당 팟(Pod)을 삭제하고 계속하기 전에 **실행 중** 상태가 될 때까지 기다리십시오.

3.  Calico 정책 또는 Calico 리소스를 자동 생성하는 경우 [Calico v3 구문 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/)을 사용하여 이러한 리소스를 생성하도록 자동화 도구를 업데이트하십시오.

4.  VPN 연결에 [strongSwan](cs_vpn.html#vpn-setup)을 사용하는 경우 strongSwan 2.0.0 Helm 차트는 Calico v3 또는 Kubernetes 1.11에서 작동하지 않습니다. Calico 2.6 및 Kubernetes 1.7, 1.8, 1.9와 역호환 가능한 2.1.0 Helm 차트로 [strongSwan을 업데이트](cs_vpn.html#vpn_upgrade)하십시오.

5.  [클러스터 마스터를 Kubernetes v1.11로 업데이트](cs_cluster_update.html#master)하십시오. 

<br />


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
<td>VPN 연결에 [strongSwan](cs_vpn.html#vpn-setup)을 사용하는 경우에는 `helm delete --purge <release_name>`을 실행하여 클러스터를 업데이트하기 전에 차트를 제거해야 합니다. 클러스터 업데이트가 완료된 후에는 strongSwan Helm 차트를 다시 설치하십시오.</td>
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
<td>VPN 연결을 위해 [strongSwan](cs_vpn.html#vpn-setup)을 사용하며 클러스터를 업데이트하기 전에 차트를 삭제한 경우, 이제 strongSwan Helm 차트를 다시 설치할 수 있습니다.</td>
</tr>
</tbody>
</table>

### Calico v3으로 업데이트 준비
{: #110_calicov3}

시작하기 전에 클러스터 마스터 및 모든 작업자 노드가 Kubernetes 버전 1.8 이상을 실행 중이어야 하며 하나 이상의 작업자 노드를 보유해야 합니다.

**중요**: 마스터를 업데이트하기 전에 Calico v3 업데이트를 준비하십시오. 마스터를 Kubernetes v1.10으로 업그레이드하는 동안 새 팟(Pod) 및 새 Kubernetes 또는 Calico 네트워크 정책이 스케줄되지 않습니다. 업데이트로 인해 새로 스케줄되지 못하는 시간은 경우에 따라 다릅니다. 소규모 클러스터에서는 몇 분이 소요되며 10개의 노드마다 몇 분이 더 추가될 수 있습니다. 기존 네트워크 정책 및 팟(Pod)은 계속 실행됩니다.

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
<td>사용자가 클러스터 리소스를 보려면 해당 인증 정보를 사용하여 Kubernetes 대시보드에 로그인해야 합니다. 기본 Kubernetes 대시보드 `ClusterRoleBinding` RBAC 권한이 제거되었습니다. 지시사항은 [Kubernetes 대시보드 실행](cs_app.html#cli_dashboard)을 참조하십시오.</td>
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



## 아카이브
{: #k8s_version_archive}

### 버전 1.8(지원되지 않음)
{: #cs_v18}

2018년 9월 22일부터, [Kubernetes 버전 1.8](cs_versions_changelog.html#changelog_archive)을 실행하는 {{site.data.keyword.containerlong_notm}} 클러스터는 지원되지 않습니다. 버전 1.8 클러스터는 다음 최신 버전([Kubernetes 1.9](#cs_v19))으로 업데이트되지 않는 한 보안 업데이트나 지원을 받을 수 없습니다. 

각 Kubernetes 버전 업데이트의 [잠재적인 영향을 검토](cs_versions.html#cs_versions)한 후에 버전 1.9 이상으로 즉시 [클러스터를 업데이트](cs_cluster_update.html#update)하십시오. 

### 버전 1.7(지원되지 않음)
{: #cs_v17}

2018년 6월 21일 현재, [Kubernetes 버전 1.7](cs_versions_changelog.html#changelog_archive)을 실행하는 {{site.data.keyword.containerlong_notm}} 클러스터는 지원되지 않습니다. 버전 1.7 클러스터는 다음 최신 버전([Kubernetes 1.9](#cs_v19))으로 업데이트되지 않는 한 보안 업데이트나 지원을 받을 수 없습니다. 

각 Kubernetes 버전 업데이트의 [잠재적인 영향을 검토](cs_versions.html#cs_versions)한 후에 버전 1.9 이상으로 즉시 [클러스터를 업데이트](cs_cluster_update.html#update)하십시오. 

### 버전 1.5(지원되지 않음)
{: #cs_v1-5}

2018년 4월 4일부터, [Kubernetes 버전 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md)를 실행하는 {{site.data.keyword.containerlong_notm}} 클러스터는 지원되지 않습니다. 버전 1.5 클러스터는 보안 업데이트 또는 지원을 받을 수 없습니다. 

{{site.data.keyword.containerlong_notm}}에서 앱을 계속해서 실행하려면 [새 클러스터를 작성](cs_clusters.html#clusters)하고 이 클러스터로 [앱을 마이그레이션](cs_app.html#app)하십시오. 
