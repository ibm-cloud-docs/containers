---

copyright:
  years: 2017, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# {{site.data.keyword.cloudaccesstrailshort}} 이벤트
{: #at_events}

{{site.data.keyword.cloudaccesstrailshort}} 서비스를 사용하여 {{site.data.keyword.containerlong_notm}} 클러스터에서 사용자가 시작한 활동을 보고 관리하며 감사할 수 있습니다.
{: shortdesc}



서비스의 작동 방법에 대한 자세한 정보는 [{{site.data.keyword.cloudaccesstrailshort}} 문서](/docs/services/cloud-activity-tracker/index.html)를 참조하십시오. 추적되는 Kubernetes 조치에 대한 자세한 정보를 보려면 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/home/)를 검토하십시오. 


## Kubernetes 감사 이벤트에 대한 정보 찾기
{: #kube-find}

{{site.data.keyword.cloudaccesstrailshort}} 이벤트는 해당 이벤트가 생성된 {{site.data.keyword.Bluemix_notm}} 지역에서 사용 가능한 {{site.data.keyword.cloudaccesstrailshort}} **계정 도메인**에서 사용될 수 있습니다. {{site.data.keyword.cloudaccesstrailshort}} 이벤트는 {{site.data.keyword.cloudaccesstrailshort}} 서비스가 프로비저닝된 Cloud Foundry 영역과 연관된 {{site.data.keyword.cloudaccesstrailshort}} **영역 도메인**에서 사용 가능합니다.

관리 활동을 모니터하려면 다음을 수행하십시오.

1. {{site.data.keyword.Bluemix_notm}} 계정에 로그인하십시오.
2. 카탈로그에서 {{site.data.keyword.containerlong_notm}}의 인스턴스와 동일한 계정으로 {{site.data.keyword.cloudaccesstrailshort}} 서비스의 인스턴스를 프로비저닝하십시오. 
3. {{site.data.keyword.cloudaccesstrailshort}} 대시보드의 **관리** 탭에서 **Kibana에서 보기**를 클릭하십시오.
4. 해당 로그를 보고자 하는 시간 범위를 설정하십시오. 기본값은 15분입니다.
5. **사용 가능한 필드** 목록에서 **유형**을 클릭하십시오. **활동 트래커**에 대한 돋보기 아이콘을 클릭하여 서비스에서 추적하는 대상으로만 로그를 제한하십시오.
6. 기타 사용 가능한 필드를 사용하여 검색 범위를 좁힐 수 있습니다.

다른 사용자가 계정 및 영역 이벤트를 볼 수 있도록 허용하려면 [계정 이벤트를 볼 수 있도록 권한 부여](/docs/services/cloud-activity-tracker/how-to/grant_permissions.html#grant_permissions)를 참조하십시오.
{: tip}

## Kubernetes 감사 이벤트 추적
{: #kube-events}

{{site.data.keyword.cloudaccesstrailshort}}에 전송되는 이벤트의 목록은 다음 표를 확인하십시오.
{: shortdesc}

**시작하기 전에**

클러스터가 [Kubernetes API 감사 이벤트](cs_health.html#api_forward)를 전달하도록 구성되어 있는지 확인하십시오. 

**전달되는 이벤트**

<table>
  <tr>
    <th>조치</th>
    <th>설명</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>바인딩이 작성되었습니다. </td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>구성 맵이 작성되었습니다. </td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>구성 맵이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>구성 맵이 패치되었습니다. </td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>구성 맵이 업데이트되었습니다. </td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>이벤트가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>이벤트가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>이벤트가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>이벤트가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>범위 한계가 작성되었습니다. </td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>범위 한계가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>범위 한계가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>범위 한계가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>네임스페이스가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>네임스페이스가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>네임스페이스가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>네임스페이스가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>노드가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>노드가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>노드가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>노드가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>노드가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>지속적 볼륨 클레임이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>지속적 볼륨 클레임이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>지속적 볼륨 클레임이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>지속적 볼륨 클레임이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>지속적 볼륨이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>지속적 볼륨이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>지속적 볼륨이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>지속적 볼륨이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>팟(Pod)이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>팟(Pod)이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>팟(Pod)이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>팟(Pod)이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>팟(Pod) 템플리트가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>팟(Pod) 템플리트가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>팟(Pod) 템플리트가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>팟(Pod) 템플리트가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>복제 제어기가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>복제 제어기가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>복제 제어기가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>복제 제어기가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>리소스 할당량이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>리소스 할당량이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>리소스 할당량이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>리소스 할당량이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>시크릿이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>시크릿이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>시크릿을 확인했습니다.</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>시크릿이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>시크릿이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>서비스 계정이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>서비스 계정이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>서비스 계정이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>서비스 계정이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>서비스가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>서비스가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>서비스가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>서비스가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>Kubernetes v1.9 이상에서 변형된 웹훅 구성이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>Kubernetes v1.9 이상에서 변형된 웹훅 구성이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>Kubernetes v1.9 이상에서 변형된 웹훅 구성이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>Kubernetes v1.9 이상에서 변형된 웹훅 구성이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>Kubernetes v1.9 이상에서 웹훅 구성 유효성 검증이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>Kubernetes v1.9 이상에서 웹훅 구성 유효성 검증이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>Kubernetes v1.9 이상에서 웹훅 구성 유효성 검증이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>Kubernetes v1.9 이상에서 웹훅 구성 유효성 검증이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>Kubernetes v1.8에서 외부 허용 훅 구성이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>Kubernetes v1.8에서 외부 허용 훅 구성이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>Kubernetes v1.8에서 외부 허용 훅 구성이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>Kubernetes v1.8에서 외부 허용 훅 구성이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>제어기 개정이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>제어기 개정이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>제어기 개정이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>제어기 개정이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>디먼 세트가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>디먼 세트가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>디먼 세트가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>디먼 세트가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>배치가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>배치가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>배치가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>배치가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>복제본 세트가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>복제본 세트가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>복제본 세트가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>복제본 세트가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>stateful 세트가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>stateful 세트가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>stateful 세트가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>stateful 세트가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>토큰 검토가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>로컬 주제 액세스 검토가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>셀프 주제 액세스 검토가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>셀프 주제 규칙 검토가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>주제 액세스 검토가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>수평 팟(Pod) Auto-Scaling 정책이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>수평 팟(Pod) Auto-Scaling 정책이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>수평 팟(Pod) Auto-Scaling 정책이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>수평 팟(Pod) Auto-Scaling 정책이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>작업이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>작업이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>작업이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>작업이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>인증서 서명 요청이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>인증서 서명 요청이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>인증서 서명 요청이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>인증서 서명 요청이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>Ingress ALB가 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>Ingress ALB가 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>Ingress ALB가 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>Ingress ALB가 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>네트워크 정책이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>네트워크 정책이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>네트워크 정책이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>네트워크 정책이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>Kubernetes v1.10 이상에 대해 팟(Pod) 보안 정책이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>Kubernetes v1.10 이상에 대해 팟(Pod) 보안 정책이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>Kubernetes v1.10 이상에 대해 팟(Pod) 보안 정책이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Kubernetes v1.10 이상에 대해 팟(Pod) 보안 정책이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.create</code></td>
    <td>팟(Pod) 중단 buget이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.delete</code></td>
    <td>팟(Pod) 중단 buget이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.patch</code></td>
    <td>팟(Pod) 중단 buget이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbugets.update</code></td>
    <td>팟(Pod) 중단 buget이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>클러스터 역할 바인딩이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>클러스터 역할 바인딩이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>클러스터 역할 바인딩이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>클러스터 역할 바인딩이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>클러스터 역할이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>클러스터 역할이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>클러스터 역할이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>클러스터 역할이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>역할 바인딩이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>역할 바인딩이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>역할 바인딩이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>역할 바인딩이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>역할이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>역할이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>역할이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>역할이 업데이트되었습니다.</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>팟(Pod) 사전 설정이 작성되었습니다.</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>팟(Pod) 사전 설정이 삭제되었습니다.</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>팟(Pod) 사전 설정이 패치되었습니다.</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>팟(Pod) 사전 설정이 업데이트되었습니다.</td>
  </tr>
</table>
