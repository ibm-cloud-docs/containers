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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# 클러스터 디버깅
{: #cs_troubleshoot}

{{site.data.keyword.containerlong}}를 사용할 때 일반적인 문제점을 해결하고 클러스터를 디버깅하려면 이러한 기술을 고려하십시오. [{{site.data.keyword.Bluemix_notm}} 시스템의 상태 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/bluemix/support/#status)를 확인할 수도 있습니다.
{: shortdesc}

다음과 같은 일반 단계를 수행하여 클러스터가 최신 상태인지 확인할 수 있습니다.
- [작업자 노드를 업데이트](cs_cli_reference.html#cs_worker_update)하는 데 사용할 수 있는 보안 및 운영 체제 패치를 매월 확인하십시오.
- 최신 기본 [Kubernetes 버전](cs_versions.html)으로 {{site.data.keyword.containerlong_notm}}의 [클러스터를 업데이트](cs_cli_reference.html#cs_cluster_update)하십시오.

## 클러스터 디버깅
{: #debug_clusters}

클러스터를 디버그하기 위한 옵션을 검토하고 실패의 근본 원인을 찾습니다.

1.  클러스터를 나열하고 클러스터의 상태(`Status`)를 찾으십시오.

  ```
  ibmcloud ks clusters
  ```
  {: pre}

2.  클러스터의 상태(`State`)를 검토하십시오. 클러스터가 **위험**, **삭제에 실패함** 또는 **경고** 상태이거나 오랜 기간 동안 **보류 중** 상태에 있으면 [작업자 노드 디버깅](#debug_worker_nodes)을 시작하십시오.

    <table summary="모든 테이블 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며 1열에는 클러스터의 상태, 2열에는 설명이 있어야 합니다.">
<caption>클러스터 상태</caption>
   <thead>
   <th>클러스터 상태</th>
   <th>설명</th>
   </thead>
   <tbody>
<tr>
   <td>중단됨(Aborted)</td>
   <td>Kubernetes 마스터가 배치되기 전에 사용자가 클러스터 삭제를 요청합니다. 클러스터 삭제가 완료된 후 대시보드에서 클러스터가 제거됩니다. 클러스터가 오랜 기간 동안 이 상태인 경우 [{{site.data.keyword.Bluemix_notm}} 지원 티켓](cs_troubleshoot.html#ts_getting_help)을 여십시오.</td>
   </tr>
 <tr>
     <td>위험(Critical)</td>
     <td>Kubernetes 마스터에 도달할 수 없거나 클러스터의 모든 작업자 노드가 작동 중지되었습니다. </td>
    </tr>
   <tr>
     <td>삭제에 실패함(Delete failed)</td>
     <td>Kubernetes 마스터 또는 최소 하나의 작업자 노드를 삭제할 수 없습니다.  </td>
   </tr>
   <tr>
     <td>삭제됨(Deleted)</td>
     <td>클러스터가 삭제되었으나 아직 대시보드에서 제거되지 않았습니다. 클러스터가 오랜 기간 동안 이 상태인 경우 [{{site.data.keyword.Bluemix_notm}} 지원 티켓](cs_troubleshoot.html#ts_getting_help)을 여십시오. </td>
   </tr>
   <tr>
   <td>삭제 중(Deleting)</td>
   <td>클러스터가 삭제 중이고 클러스터 인프라가 해체되고 있습니다. 클러스터에 액세스할 수 없습니다.  </td>
   </tr>
   <tr>
     <td>배치에 실패함(Deploy failed)</td>
     <td>Kubernetes 마스터의 배치를 완료하지 못했습니다. 이 상태를 해결할 수 없습니다. [{{site.data.keyword.Bluemix_notm}} 지원 티켓](cs_troubleshoot.html#ts_getting_help)을 열어 IBM Cloud 지원에 문의하십시오.</td>
   </tr>
     <tr>
       <td>배치 중(Deploying)</td>
       <td>Kubernetes 마스터가 아직 완전히 배치되지 않았습니다. 클러스터에 액세스할 수 없습니다. 클러스터가 완전히 배치될 때까지 기다렸다가 클러스터의 상태를 검토하십시오.</td>
      </tr>
      <tr>
       <td>정상(Normal)</td>
       <td>클러스터의 모든 작업자 노드가 시작되어 실행 중입니다. 클러스터에 액세스하고 클러스터에 앱을 배치할 수 있습니다. 이 상태는 정상으로 간주되고 사용자의 조치가 필요하지 않습니다. **참고**: 작업자 노드가 정상이더라도 [네트워킹](cs_troubleshoot_network.html) 및 [스토리지](cs_troubleshoot_storage.html)와 같은 기타 인프라 리소스에는 여전히 문제가 있을 수 있습니다.</td>
    </tr>
      <tr>
       <td>보류 중(Pending)</td>
       <td>Kubernetes 마스터가 배치됩니다. 작업자 노드를 프로비저닝 중이므로 아직 클러스터에서 사용할 수 없습니다. 클러스터에 액세스할 수 있지만 클러스터에 앱을 배치할 수 없습니다.  </td>
     </tr>
   <tr>
     <td>요청됨(Requested)</td>
     <td>클러스터 작성 및 Kubernetes 마스터 및 작업자 노드의 인프라 정렬에 대한 요청이 전송되었습니다. 클러스터의 배치가 시작되면 클러스터 상태가 <code>Deploying</code>으로 변경됩니다. 클러스터가 오랜 기간 동안 <code>Requested</code> 상태인 경우 [{{site.data.keyword.Bluemix_notm}} 지원 티켓](cs_troubleshoot.html#ts_getting_help)을 여십시오. </td>
   </tr>
   <tr>
     <td>업데이트 중(Updating)</td>
     <td>Kubernetes 마스터에서 실행되는 Kubernetes API 서버가 새 Kubernetes API 버전으로 업데이트 중입니다. 업데이트 중에는 클러스터에 액세스하거나 클러스터를 변경할 수 없습니다. 사용자가 배치한 작업자 노드, 앱 및 리소스는 수정되지 않고 계속 실행됩니다. 업데이트가 완료될 때까지 기다렸다가 클러스터의 상태를 검토하십시오. </td>
   </tr>
    <tr>
       <td>경고(Warning)</td>
       <td>클러스터에 있는 하나 이상의 작업자 노드를 사용할 수 없지만, 다른 작업자 노드가 사용 가능하며 워크로드를 인계받을 수 있습니다. </td>
    </tr>
   </tbody>
 </table>


**참고**: [Kubernetes 마스터](cs_tech.html#architecture)는 클러스터의 시작과 실행을 유지하는 기본 컴포넌트입니다. 마스터는 클러스터에 대한 SPOT(Single Point of Truth) 역할을 하는 etcd 데이터베이스에 클러스터 리소스와 해당 구성을 저장합니다. Kubernetes API 서버는 마스터에 대한 작업자 노드의 모든 클러스터 관리 요청을 위한 기본 시작점입니다. 또는 클러스터 리소스와 상호 작용하고자 할 때의 시작점이기도 합니다.<br><br>마스터 장애 발생 시에 워크로드는 작업자 노드에서 계속 실행되지만, 마스터의 Kubernetes API 서버가 백업될 때까지는 사용자가 `kubectl` 명령을 사용하여 클러스터 리소스 관련 작업을 수행하거나 클러스터 상태를 확인할 수 없습니다. 마스터 가동 중단 중에 팟(Pod)이 중지되는 경우에는 작업자 노드가 다시 Kubernetes API 서버에 접속할 수 있을 때까지 팟(Pod)을 다시 스케줄할 수 없습니다.<br><br>마스터 가동 중단 중에도 사용자는 여전히 {{site.data.keyword.containerlong_notm}} API에 대해 `ibmcloud ks` 명령을 실행하여 인프라 리소스(예: 작업자 노드 또는 VLAN) 관련 작업을 수행할 수 있습니다. 작업자 노드를 클러스터에 추가하거나 이에서 제거하여 현재 클러스터 구성을 변경하는 경우에는 마스터가 백업될 때까지 변경사항이 발생하지 않습니다. **참고**: 마스터 가동 중단 중에는 작업자 노드를 다시 시작하거나 재부팅하지 마십시오. 이 조치를 수행하면 작업자 노드에서 팟(Pod)이 제거됩니다. Kubernetes API 서버가 사용 불가능하므로 클러스터의 다른 작업자 노드로 팟(Pod)을 다시 스케줄할 수 없습니다.


<br />


## 작업자 노드 디버깅
{: #debug_worker_nodes}

작업자 노드를 디버그하기 위한 옵션을 검토하고 실패의 근본 원인을 찾습니다.


1.  클러스터가 **위험**, **삭제에 실패함** 또는 **경고** 상태이거나 오랜 기간 동안 **보류 중** 상태에 있으면 작업자 노드의 상태를 검토하십시오.

  ```
  ibmcloud ks workers <cluster_name_or_id>
  ```
  {: pre}

2.  CLI 출력의 모든 작업자 노드에 대한 상태(`State` 및 `Status`) 필드를 검토하십시오.

  <table summary="모든 테이블 행은 왼쪽에서 오른쪽 방향으로 읽어야 하며 1열에는 클러스터의 상태, 2열에는 설명이 있어야 합니다.">
  <caption>작업자 노드 상태</caption>
    <thead>
    <th>작업자 노드 상태</th>
    <th>설명</th>
    </thead>
    <tbody>
  <tr>
      <td>위험(Critical)</td>
      <td>작업자 노드는 여러 이유로 인해 위험 상태가 될 수 있습니다. <ul><li>작업자 노드의 유출 및 드레인 없이 작업자 노드에 대한 다시 부팅을 시작했습니다. 작업자 노드를 다시 부팅하면 <code>containerd</code>, <code>kubelet</code>, <code>kube-proxy</code> 및 <code>calico</code>에서 데이터 손상이 발생할 수 있습니다. </li><li>작업자 노드에 배치된 팟(Pod)은 [메모리 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) 및 [CPU ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)에 대한 리소스 한계를 사용하지 않습니다. 리소스 한계 없이 팟(Pod)은 사용 가능한 모든 리소스를 이용할 수 있으며 이 작업자 노드에 실행할 기타 팟(Pod)에 대한 리소스를 남기지 않습니다. 워크로드의 과도한 사용으로 인해 작업자 노드가 실패하게 됩니다. </li><li>시간이 지남에 따라 수백 또는 수천 개의 컨테이너를 실행한 후 <code>containerd</code>, <code>kubelet</code> 또는 <code>calico</code>가 복구 불가능한 상태가 되었습니다. </li><li>작업자 노드 및 Kubernetes 마스터 간 통신의 성능을 저하시키거나 차단하는 작업자 노드에 대한 가상 라우터 어플라이언스를 설정합니다. </li><li> 현재 네트워킹 작업자 노드와 Kubernetes 마스터 간의 통신 실패의 원인이 되는 {{site.data.keyword.containerlong_notm}} 또는 IBM Cloud 인프라(SoftLayer)의 현재 네트워킹 문제점입니다.</li><li>작업자 노드의 용량이 부족합니다. 작업자 노드의 <strong>상태</strong>를 확인하여 <strong>디스크 부족</strong> 또는 <strong>메모리 부족</strong>이 표시되는지 확인하십십시오. 작업자 노드의 용량이 부족하면 워크로드의 로드 밸런싱을 지원하기 위해 작업자 노드의 워크로드를 줄이거나 작업자 노드를 클러스터에 추가해보십시오.</li></ul> 많은 경우 작업자 노드를 [다시 로드](cs_cli_reference.html#cs_worker_reload)하면 문제점을 해결할 수 있습니다. 작업자 노드를 다시 로드하면 최신 [패치 버전](cs_versions.html#version_types)이 작업자 노드에 적용됩니다. 주 버전 및 부 버전은 변경되지 않습니다. 작업자 노드를 다시 로드하기 전에 기존 팟(Pod)이 정상적으로 종료되고 남아 있는 작업자 노드로 다시 스케줄되었는지 확인하려면 작업자 노드를 유출하고 드레인하십시오. </br></br> 작업자 노드를 다시 로드해도 문제가 해결되지 않으면 다음 단계로 이동하여 작업자 노드의 문제점 해결을 계속 진행하십시오. </br></br><strong>팁:</strong> [작업자 노드에 대한 상태 검사를 구성하고 자동 복구를 사용으로 설정](cs_health.html#autorecovery)할 수 있습니다. 자동 복구는 구성된 검사에 따라 비정상적인 작업자 노드를 발견하면 작업자 노드에서 OS 다시 로드와 같은 정정 조치를 트리거합니다. 자동 복구 작동 방식에 대한 자세한 정보는 [자동 복구 블로그 게시물![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)을 참조하십시오.
      </td>
     </tr>
     <tr>
     <td>배치됨(Deployed)</td>
     <td>업데이트가 작업자 노드에 성공적으로 배치되었습니다. 업데이트가 배치된 후에는 {{site.data.keyword.containerlong_notm}}에서 작업자 노드에 대한 상태 검사를 시작합니다. 상태 검사에 성공하면 작업자 노드가 <code>Normal</code> 상태가 됩니다. <code>Deployed</code> 상태의 작업자 노드는 일반적으로 워크로드 수신 준비가 되어 있으며, 이는 <code>kubectl get nodes</code>를 실행하고 상태가 <code>Normal</code>을 표시하는지 확인하여 검사할 수 있습니다. </td>
     </tr>
      <tr>
        <td>배치 중(Deploying)</td>
        <td>작업자 노드의 Kubernetes 버전을 업데이트할 때 업데이트 설치를 위해 작업자 노드가 다시 배치됩니다. 작업자 노드를 다시 로드하거나 재부팅하면 작업자 노드가 다시 배치되어 최신 패치 버전을 자동으로 설치합니다. 작업자 노드가 오랫동안 이 상태로 고착되어 있는 경우 다음 단계로 진행하여 배치 중에 문제점이 발생했는지 확인하십시오. </td>
     </tr>
        <tr>
        <td>정상(Normal)</td>
        <td>작업자 노드가 완전히 프로비저닝되어 클러스터에서 사용할 준비가 되었습니다. 이 상태는 정상으로 간주되고 사용자의 조치가 필요하지 않습니다. **참고**: 작업자 노드가 정상이더라도 [네트워킹](cs_troubleshoot_network.html) 및 [스토리지](cs_troubleshoot_storage.html)와 같은 기타 인프라 리소스에는 여전히 문제가 있을 수 있습니다.</td>
     </tr>
   <tr>
        <td>프로비저닝 중(Provisioning)</td>
        <td>작업자 노드를 프로비저닝 중이므로 아직 클러스터에서 사용할 수 없습니다. CLI 출력의 <strong>상태(Status)</strong> 열에서 프로비저닝 프로세스를 모니터할 수 있습니다. 작업자 노드가 오랫동안 이 상태로 고착되어 있는 경우 다음 단계로 진행하여 프로비저닝 중에 문제점이 발생했는지 확인하십시오.</td>
      </tr>
      <tr>
        <td>프로비저닝 실패(Provision_failed)</td>
        <td>작업자 노드를 프로비저닝할 수 없습니다. 다음 단계로 진행하여 실패에 관한 세부사항을 찾으십시오.</td>
      </tr>
   <tr>
        <td>다시 로드 중(Reloading)</td>
        <td>작업자 노드를 다시 로드 중이므로 클러스터에서 사용할 수 없습니다. CLI 출력의 <strong>상태(Status)</strong> 열에서 다시 로드 프로세스를 모니터할 수 있습니다. 작업자 노드가 오랫동안 이 상태로 고착되어 있는 경우 다음 단계로 진행하여 다시 로드하는 중에 문제점이 발생했는지 확인하십시오.</td>
       </tr>
       <tr>
        <td>다시 로드 실패(Reloading_failed) </td>
        <td>작업자 노드를 다시 로드할 수 없습니다. 다음 단계로 진행하여 실패에 관한 세부사항을 찾으십시오.</td>
      </tr>
      <tr>
        <td>다시 로드 보류 중(Reload_pending) </td>
        <td>작업자 노드의 Kubernetes 버전을 다시 로드하거나 업데이트하는 요청이 전송되었습니다. 작업자 노드가 다시 로드되면 상태가 <code>다시 로드 중</code>으로 변경됩니다. </td>
      </tr>
      <tr>
       <td>알 수 없음(Unknown)</td>
       <td>다음 이유 중 하나로 인해 Kubernetes 마스터에 연결할 수 없습니다.<ul><li>Kubernetes 마스터의 업데이트를 요청했습니다. 업데이트 중에 작업자 노드의 상태를 검색할 수 없습니다.</li><li>작업자 노드를 보호 중이거나 최근에 방화벽 설정을 변경한 다른 방화벽이 있을 수 있습니다. {{site.data.keyword.containerlong_notm}}에서는 작업자 노드와 Kubernetes 마스터 간의 양방향 통신을 허용하기 위해 특정 IP 주소와 포트를 열도록 요구합니다. 자세한 정보는 [방화벽으로 인해 작업자 노드를 연결할 수 없음](cs_troubleshoot_clusters.html#cs_firewall)을 참조하십시오.</li><li>Kubernetes 마스터가 작동 중단되었습니다. [{{site.data.keyword.Bluemix_notm}} 지원 티켓](#ts_getting_help)을 열어 {{site.data.keyword.Bluemix_notm}} 지원에 문의하십시오.</li></ul></td>
  </tr>
     <tr>
        <td>경고(Warning)</td>
        <td>작업자 노드가 메모리 또는 디스크 공간의 한계에 도달하고 있습니다. 작업자 노드의 작업 로드를 줄이거나 클러스터에 작업자 노드를 추가하여 작업 로드의 로드 밸런스를 맞출 수 있습니다.</td>
  </tr>
    </tbody>
  </table>

5.  작업자 노드의 세부사항을 나열하십시오. 세부사항에 오류 메시지가 포함되는 경우 [작업자 노드에 대한 일반 오류 메시지](#common_worker_nodes_issues)의 목록을 검토하여 문제점 해결 방법을 알아보십시오.

   ```
   ibmcloud ks worker-get <worker_id>
   ```
   {: pre}

  ```
  ibmcloud ks worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

<br />


## 작업자 노드에 대한 일반 문제
{: #common_worker_nodes_issues}

일반 오류 메시지를 검토하고 해결 방법을 알아보십시오.

  <table>
  <caption>공통 오류 메시지</caption>
    <thead>
    <th>오류 메시지</th>
    <th>설명 및 해결
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Your account is currently prohibited from ordering 'Computing Instances'.</td>
        <td>IBM Cloud 인프라(SoftLayer) 계정이 컴퓨팅 리소스를 주문하지 못하게 제한되었을 수 있습니다. [{{site.data.keyword.Bluemix_notm}} 지원 티켓](#ts_getting_help)을 열어 {{site.data.keyword.Bluemix_notm}} 지원에 문의하십시오.</td>
      </tr>
      <tr>
      <td>{{site.data.keyword.Bluemix_notm}} infrastructure exception: Could not place order.<br><br>
      {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not place order. There are insufficient resources behind router 'router_name' to fulfill the request for the following guests: 'worker_id'.</td>
      <td>선택한 구역에 작업자 노드를 프로비저닝할 수 있는 충분한 인프라 용량이 없을 수 있습니다. 또는 IBM Cloud 인프라(SoftLayer) 계정의 한계를 초과했을 수 있습니다. 이를 해결하려면 다음 옵션 중 하나를 사용해 보십시오.
      <ul><li>구역의 인프라 리소스 가용성은 자주 변동될 수 있습니다. 잠시 기다린 후 다시 시도하십시오.</li>
      <li>단일 구역 클러스터의 경우에는 다른 구역에서 클러스터를 작성하십시오. 다중 구역 클러스터의 경우에는 클러스터에 구역을 추가하십시오.</li>
      <li>IBM Cloud 인프라(SoftLayer) 계정의 작업자 노드에 대해 다른 공용 및 사설 VLAN 쌍을 지정하십시오. 작업자 풀에 있는 작업자 노드의 경우에는 <code>ibmcloud ks zone-network-set</code> [명령](cs_cli_reference.html#cs_zone_network_set)을 사용할 수 있습니다.</li>
      <li>IBM Cloud 인프라(SoftLayer) 계정 관리자에게 문의하여 글로벌 할당량 등의 계정 한계를 초과하지 않는지 확인하십시오.</li>
      <li>[IBM Cloud 인프라(SoftLayer) 지원 티켓](#ts_getting_help)을 여십시오.</li></ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not obtain network VLAN with ID: &lt;vlan id&gt;.</td>
        <td>다음 이유 중 하나로 인해 선택된 VLAN ID를 찾을 수 없으므로 작업자 노드를 프로비저닝할 수 없습니다.<ul><li>VLAN ID가 아니라 VLAN 번호를 지정했을 수 있습니다. VLAN 번호는 3 또는 4자리 숫자이지만 VLAN ID는 7자리 숫자입니다. <code>ibmcloud ks vlans &lt;zone&gt;</code>을 실행하여 VLAN ID를 검색하십시오.<li>사용하는 IBM Cloud 인프라(SoftLayer) 계정과 VLAN ID가 연관되지 않았을 수 있습니다. <code>ibmcloud ks vlans &lt;zone&gt;</code>을 실행하여 계정에 대해 사용 가능한 VLAN ID를 나열하십시오. IBM Cloud 인프라(SoftLayer) 계정을 변경하려면 [`ibmcloud ks credentials-set`](cs_cli_reference.html#cs_credentials_set)를 참조하십시오. </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500).</td>
        <td>선택된 데이터센터에서 컴퓨팅 리소스를 주문하도록 IBM Cloud 인프라(SoftLayer)가 설정되지 않았습니다. [{{site.data.keyword.Bluemix_notm}} 지원](#ts_getting_help)에 문의하여 계정이 올바르게 설정되었는지 확인하십시오.</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers
        </br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.
        </br></br>
        The {{site.data.keyword.Bluemix_notm}} infrastructure credentials could not be validated.</td>
        <td>IBM Cloud 인프라(SoftLayer) 포트폴리오에서 조치를 수행하는 데 필요한 권한이 없거나 잘못된 인프라 인증 정보를 사용 중입니다. [인프라 포트폴리오에 대한 액세스를 가능하게 하기 위한 API 키 설정](cs_users.html#api_key)을 참조하십시오. </td>
      </tr>
      <tr>
       <td>Worker unable to talk to {{site.data.keyword.containerlong_notm}} servers. Please verify your firewall setup is allowing traffic from this worker.
       <td><ul><li>방화벽이 있으면 [방화벽 설정을 구성하여 적절한 포트 및 IP 주소로 발신 트래픽을 허용](cs_firewall.html#firewall_outbound)하십시오.</li><li>`ibmcloud ks workers &lt;mycluster&gt;`를 실행하여 클러스터에 공인 IP가 없는지 여부를 확인하십시오. 공인 IP가 나열되지 않으면 클러스터에 사설 VLAN만 있는 것입니다.<ul><li>클러스터가 사설 VLAN만 보유하도록 하려면 [VLAN 연결](cs_clusters_planning.html#private_clusters) 및 [방화벽](cs_firewall.html#firewall_outbound)을 설정하십시오.</li><li>클러스터가 공인 IP를 사용하려는 경우 공용 및 사설 VLAN을 모두 사용하여 [새 작업자 노드를 추가](cs_cli_reference.html#cs_worker_add)하십시오.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>Cannot create IMS portal token, as no IMS account is linked to the selected BSS account</br></br>Provided user not found or active</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: User account is currently cancel_pending.</br></br>Waiting for machine to be visible to the user</td>
  <td>IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 데 사용되는 API 키의 소유자에 조치를 수행하는 데 필요한 권한이 없거나 삭제를 보류 중일 수 있습니다.</br></br><strong>사용자</strong>는 다음 단계를 수행하십시오. <ol><li>여러 계정에 대한 액세스 권한이 있는 경우 {{site.data.keyword.containerlong_notm}} 관련 작업을 수행하려는 계정에 로그인되어 있는지 확인하십시오. </li><li><code>ibmcloud ks api-key-info</code>를 실행하여 IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하는 데 사용되는 현재 API 키 소유자를 보십시오. </li><li><code>ibmcloud account list</code>를 실행하여 현재 사용하는 {{site.data.keyword.Bluemix_notm}} 계정의 소유자를 보십시오. </li><li>{{site.data.keyword.Bluemix_notm}} 계정의 소유자에게 연락하여 API 키 소유자에게 IBM Cloud 인프라(SoftLayer)에 대한 충분한 권한이 없거나 삭제 보류 상태일 수 있음을 보고하십시오. </li></ol></br><strong>계정 소유자</strong>는 다음 단계를 수행하십시오. <ol><li>[IBM Cloud 인프라(SoftLayer)의 필수 권한](cs_users.html#infra_access)을 검토하여 이전에 실패한 조치를 수행하십시오. </li><li>[<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 명령을 사용하여 API 키 소유자의 권한을 수정하거나 새 API 키를 작성하십시오. </li><li>자신이나 다른 계정 관리자가 수동으로 계정의 IBM Cloud 인프라(SoftLayer) 인증 정보를 설정하는 경우에는 [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset)을 실행하여 계정에서 인증 정보를 제거하십시오.</li></ol></td>
  </tr>
    </tbody>
  </table>



<br />




## 앱 배치 디버깅
{: #debug_apps}

앱 배치를 디버그해야 하는 옵션을 검토하고 실패의 근본 원인을 찾습니다.

1. `describe` 명령을 실행하여 서비스 또는 배치 리소스의 비정상 항목을 찾으십시오.

 예:
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [컨테이너가 ContainerCreating 상태인지 확인](cs_troubleshoot_storage.html#stuck_creating_state)하십시오.

3. 클러스터가 `Critical` 상태인지 확인하십시오. 클러스터가 `Critical` 상태이면 방화벽 규칙을 검사하고 마스터가 작업자 노드와 통신할 수 있는지 확인하십시오.

4. 서비스가 올바른 포트에서 청취하는지 확인하십시오.
   1. 팟(Pod)의 이름을 가져오십시오.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. 컨테이너에 로그인하십시오.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. 컨테이너 내에서 앱을 curl하십시오. 포트에 액세스할 수 없는 경우 서비스가 올바른 포트에서 청취 중이지 않거나 앱에 문제가 있을 수 있습니다. 서비스의 구성 파일을 올바른 포트로 업데이트하고 앱에 대한 잠재적인 문제를 재배치하거나 조사하십시오.
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. 서비스가 팟(Pod)에 올바르게 링크되었는지 확인하십시오.
   1. 팟(Pod)의 이름을 가져오십시오.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. 컨테이너에 로그인하십시오.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. 서비스의 클러스터 IP 주소 및 포트를 curl하십시오. IP 주소 및 포트에 액세스할 수 없는 경우 서비스의 엔드포인트를 살펴보십시오. 엔드포인트가 나열되지 않으면 서비스의 선택기가 팟(Pod)과 일치되지 않습니다. 엔드포인트가 나열된 경우 서비스의 대상 포트 필드를 살펴보고 대상 포트가 팟(Pod)에 사용된 것과 동일한지 확인하십시오.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Ingress 서비스의 경우 클러스터 내에서 서비스에 액세스할 수 있는지 확인하십시오.
   1. 팟(Pod)의 이름을 가져오십시오.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. 컨테이너에 로그인하십시오.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Ingress 서비스에 대해 지정된 URL을 curl하십시오. URL에 액세스할 수 없는 경우 클러스터와 외부 엔드포인트 간의 방화벽 문제를 확인하십시오. 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />



## 도움 및 지원 받기
{: #ts_getting_help}

클러스터에 여전히 문제점이 있습니까?
{: shortdesc}

-  터미널에서 `ibmcloud` CLI 및 플러그인에 대한 업데이트가 사용 가능한 시점을 사용자에게 알려줍니다. 사용 가능한 모든 명령과 플래그를 사용할 수 있도록 반드시 CLI를 최신 상태로 유지하십시오.

-   {{site.data.keyword.Bluemix_notm}}가 사용 가능한지 확인하려면 [{{site.data.keyword.Bluemix_notm}} 상태 페이지를 확인 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/bluemix/support/#status)하십시오.
-   [{{site.data.keyword.containerlong_notm}} Slack ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://ibm-container-service.slack.com)에 질문을 게시하십시오.

{{site.data.keyword.Bluemix_notm}} 계정에 대해 IBM ID를 사용 중이 아닌 경우에는 이 Slack에 대한 [초대를 요청](https://bxcs-slack-invite.mybluemix.net/)하십시오.
    {: tip}
-   포럼을 검토하여 다른 사용자에게도 동일한 문제가 발생하는지 여부를 확인하십시오. 포럼을 사용하여 질문을 할 때는 {{site.data.keyword.Bluemix_notm}} 개발 팀이 볼 수 있도록 질문에 태그를 지정하십시오.

    -   {{site.data.keyword.containerlong_notm}}로 클러스터 또는 앱을 개발하거나 배치하는 데 대한 기술적 질문이 있으면 [Stack Overflow![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)에 질문을 게시하고 질문에 `ibm-cloud`, `kubernetes` 및 `containers` 태그를 지정하십시오.
    -   서비스 및 시작하기 지시사항에 대한 질문이 있으면 [IBM Developer Answers ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 포럼을 사용하십시오. `ibm-cloud` 및 `containers` 태그를 포함하십시오.
    포럼 사용에 대한 세부사항은 [도움 받기](/docs/get-support/howtogetsupport.html#using-avatar)를 참조하십시오.

-   티켓을 열어 IBM 지원 센터에 문의하십시오. IBM 지원 티켓 열기 또는 지원 레벨 및 티켓 심각도에 대해 알아보려면 [지원 문의](/docs/get-support/howtogetsupport.html#getting-customer-support)를 참조하십시오.

{: tip}
문제를 보고할 때 클러스터 ID를 포함시키십시오. 클러스터 ID를 가져오려면 `ibmcloud ks clusters`를 실행하십시오.

