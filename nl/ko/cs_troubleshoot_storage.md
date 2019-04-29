---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

subcollection: containers

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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# 클러스터 스토리지 문제점 해결
{: #cs_troubleshoot_storage}

{{site.data.keyword.containerlong}}를 사용할 때 클러스터 스토리지 관련 문제점을 해결하려면 이러한 기술을 고려하십시오.
{: shortdesc}

더 일반적인 문제점이 있는 경우에는 [클러스터 디버깅](/docs/containers?topic=containers-cs_troubleshoot)을 시도해 보십시오.
{: tip}

## 다중 구역 클러스터에서 지속적 볼륨이 팟(Pod)에 마운트되지 않음
{: #mz_pv_mount}

{: tsSymptoms}
클러스터가 이전에는 작업자 풀에 없는 독립형 작업자 노드의 단일 구역 클러스터였습니다. 사용자가 앱의 팟(Pod) 배치에 사용할 지속적 볼륨(PV)을 기술한 지속적 볼륨 클레임(PVC)을 성공적으로 마운트했습니다. 이제 작업자 풀을 보유하며 구역을 클러스터에 추가했지만 PV가 팟(Pod)에 마운트되지 않습니다.

{: tsCauses}
다중 구역 클러스터의 경우, 팟(Pod)이 다른 구역에서 볼륨 마운트를 시도하지 않도록 PV에는 다음 레이블이 있어야 합니다.
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

다중 구역에 전개될 수 있는 작업자 풀이 있는 새 클러스터는 기본적으로 PV의 레이블을 지정합니다. 작업자 풀이 도입되기 전에 클러스터를 작성한 경우에는 레이블을 수동으로 추가해야 합니다.

{: tsResolve}
[지역 및 구역 레이블로 클러스터의 PV를 업데이트](/docs/containers?topic=containers-kube_concepts#storage_multizone)하십시오.

<br />


## 파일 스토리지: 작업자 노드의 파일 시스템이 읽기 전용으로 변경됨
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
다음 증상 중 하나가 표시될 수 있습니다.
- `kubectl get pods -o wide`를 실행할 때 동일한 작업자 노드에서 실행 중인 여러 팟(Pod)이 계속 `ContainerCreating` 상태에 있음을 알게 됩니다.
- `kubectl describe` 명령을 실행할 때 **Events** 섹션에 `MountVolume.SetUp failed for volume ... read-only file system` 오류가 표시됩니다.

{: tsCauses}
작업자 노드의 파일 시스템은 읽기 전용입니다.

{: tsResolve}
1.  작업자 노드 또는 컨테이너에 저장될 수 있는 데이터를 백업하십시오.
2.  기존 작업자 노드에 대한 단기 수정사항의 경우 작업자 노드를 다시 로드하십시오.
    <pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;cluster_name&gt; --worker &lt;worker_ID&gt;</code></pre>

장기 수정사항의 경우에는 [작업자 풀의 머신 유형을 업데이트](/docs/containers?topic=containers-update#machine_type)하십시오.

<br />



## 파일 스토리지: 비-루트 사용자가 NFS 파일 스토리지 마운트 경로를 소유하면 앱에 장애가 발생함
{: #nonroot}

{: tsSymptoms}
배치에 [NFS 스토리지를 추가](/docs/containers?topic=containers-file_storage#app_volume_mount)한 후 컨테이너의 배치가 실패합니다. 컨테이너의 로그를 검색할 때 다음 과 같은 오류가 표시될 수 있습니다. 팟(Pod)에 장애가 발생하여 다시 로드 순환에서 벗어나지 못합니다.

```
write-permission
```
{: screen}

```
do not have required permission
```
{: screen}

```
cannot create directory '/bitnami/mariadb/data': Permission denied
```
{: screen}

{: tsCauses}
기본적으로, 루트가 아닌 사용자에게는 NFS 지원 스토리지의 볼륨 마운트 경로에 대한 쓰기 권한이 없습니다. Jenkins 및 Nexus3과 같은 일부 일반적인 앱 이미지에서는 Dockerfile에 마운트 경로를 소유하는 루트가 아닌 사용자를 지정합니다. 이 Dockerfile에서 컨테이너를 작성하는 경우 마운트 경로에 루트가 아닌 사용자에 대한 권한이 충분하지 않기 때문에 컨테이너의 작성에 실패합니다. 쓰기 권한을 부여하기 위해 마운트 경로 권한을 변경하기 전에 Dockerfile 파일을 수정하여 임시로 루트가 아닌 사용자를 루트 사용자 그룹에 추가하거나 init 컨테이너를 사용할 수 있습니다.

Helm 차트를 사용하여 이미지를 배치하는 경우 init 컨테이너를 사용하도록 Helm 배치를 편집하십시오.
{:tip}



{: tsResolve}
배치에 [init 컨테이너 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)를 포함하는 경우 컨테이너 내부의 볼륨 마운트 경로에 대해 Dockerfile 쓰기 권한에 지정된 루트가 아닌 사용자를 제공할 수 있습니다. 앱 컨테이너가 시작되기 전에 init 컨테이너가 시작됩니다. init 컨테이너는 컨테이너 내부에 볼륨 마운트 경로를 작성하고 올바른(루트가 아닌) 사용자가 소유하도록 마운트 경로를 변경한 후 닫습니다. 그런 다음, 마운트 경로에 쓰기를 수행해야 하는 루트가 아닌 사용자가 포함된 앱 컨테이너가 시작됩니다. 루트가 아닌 사용자가 경로를 이미 소유하고 있기 때문에 마운트 경로 쓰기에 성공합니다. init 컨테이너를 사용하지 않을 경우 Dockerfile을 수정하여 루트가 아닌 사용자 액세스를 NFS 파일 스토리지에 추가할 수 있습니다.


시작하기 전에: [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  앱의 Dockerfile을 열고 볼륨 마운트 경로에 대한 쓰기 권한을 제공하려는 사용자로부터 사용자 ID(UID) 및 그룹 ID(GID)를 가져오십시오. Jenkins Dockerfile의 예에서 정보는 다음과 같습니다.
    - UID: `1000`
    - GID: `1000`

    **예제**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update &&apt-get install -y git curl &&rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  지속적 볼륨 클레임(PVC)을 작성하여 지속적 스토리지를 앱에 추가하십시오. 이 예에서는 `ibmc-file-bronze` 스토리지 클래스를 사용합니다. 사용 가능한 스토리지 클래스를 검토하려면 `kubectl get storageclasses`를 실행하십시오.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

3.  PVC를 작성하십시오.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  배치 `.yaml` 파일에서 init 컨테이너를 추가하십시오. 이전에 검색한 UID 및 GID를 포함하십시오.

    ```
    initContainers:
    - name: initcontainer # Or replace the name
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Replace UID and GID with values from the Dockerfile
      volumeMounts:
      - name: volume # Or you can replace with any name
        mountPath: /mount # Must match the mount path in the args line
    ```
    {: codeblock}

    Jenkins 배치의 **예**:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  팟(Pod)을 작성하고 PVC를 팟(Pod)에 마운트하십시오.

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. 볼륨이 팟(Pod)에 정상적으로 마운트되었는지 확인하십시오. 팟(Pod) 이름 및 **컨테이너/마운트** 경로를 기록해 두십시오.

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **출력 예**:

    ```
    Name:       mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type:	PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName:	mypvc
        ReadOnly:	  false

    ```
    {: screen}

7.  이전에 기록해 놓은 팟(Pod) 이름을 사용하여 팟(Pod)에 로그인하십시오.

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. 컨테이너의 마운트 경로에 대한 권한을 확인하십시오. 예를 들어, 마운트 경로는 `/var/jenkins_home`입니다.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **출력 예**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    이 출력은 Dockerfile의 GID 및 UID(이 예에서 `1000` 및 `1000`)가 컨테이너 내부의 마운트 경로를 소유함을 표시합니다.

<br />


## 파일 스토리지: 지속적 스토리지에 비-루트 사용자 액세스를 추가할 수 없음
{: #cs_storage_nonroot}

{: tsSymptoms}
[지속적 스토리지에 루트가 아닌 사용자 액세스를 추가](#nonroot)하거나 지정된 루트가 아닌 사용자 ID로 Helm 차트를 배치한 후 사용자가 마운트된 스토리지에 쓸 수 없습니다.

{: tsCauses}
배치 또는 Helm 차트 구성은 팟(Pod)의 `fsGroup`(그룹 ID) 및 `runAsUser`(사용자 ID)에 대한 [보안 컨텍스트](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)를 지정합니다. 현재 {{site.data.keyword.containerlong_notm}}는 `fsGroup` 스펙을 지원하지 않으며 `0`으로 설정된 `runAsUser`(루트 권한)만 지원합니다.

{: tsResolve}
이미지, 배치 또는 Helm 차트 구성 파일 및 다시 배치에서 `fsGroup` 및 `runAsUser`에 대한 구성의 `securityContext` 필드를 제거하십시오. `nobody`에서 마운트 경로의 소유권을 변경해야 하는 경우 [루트가 아닌 사용자 액세스 추가](#nonroot)를 수행하십시오. [루트가 아닌 `initContainer`](#nonroot)를 추가한 후에는 팟(Pod) 레벨이 아니라 컨테이너 레벨에서 `runAsUser`를 설정하십시오.

<br />




## 블록 스토리지: 블록 스토리지가 읽기 전용으로 변경됨
{: #readonly_block}

{: tsSymptoms}
다음과 같은 증상이 표시될 수 있습니다.
- `kubectl get pods -o wide`를 실행할 때 동일한 작업자 노드에서 여러 팟(Pod)이 계속 `ContainerCreating` 또는 `CrashLoopBackOff` 상태에 있음을 알게 됩니다. 이러한 모든 팟(Pod)은 동일한 블록 스토리지 인스턴스를 사용합니다.
- `kubectl describe pod` 명령을 실행할 때 **이벤트** 섹션에 `MountVolume.SetUp failed for volume ... read-only` 오류가 표시됩니다.

{: tsCauses}
팟(Pod)이 볼륨에 기록하는 동안 네트워크 오류가 발생하면 IBM Cloud 인프라(SoftLayer)는 볼륨을 읽기 전용 모드로 변경하여 볼륨에 있는 데이터가 손상되지 않도록 보호합니다. 이 볼륨을 사용하는 팟(Pod)은 볼륨에 계속 기록할 수 없으며 실패합니다.

{: tsResolve}
1. 클러스터에 설치한 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인 버전을 확인하십시오.
   ```
   helm ls
   ```
   {: pre}

2. [{{site.data.keyword.Bluemix_notm}} Block Storage 플러그인의 최신 버전](https://cloud.ibm.com/containers-kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin)을 사용하는지 확인하십시오. 그렇지 않은 경우에는 [플러그인을 업데이트](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in)하십시오.
3. 팟(Pod)에 대해 Kubernetes 배치를 사용한 경우 팟(Pod)을 제거하고 Kubernetes가 이를 다시 작성하도록 하여 실패한 팟(Pod)을 다시 시작하십시오. 배치를 사용하지 않은 경우, 다음 명령을 실행하여 팟(Pod)을 작성하는 데 사용된 YAML 파일을 검색하십시오. `kubectl get pod <pod_name> -o yaml >pod.yaml`. 그런 다음, 팟(Pod)을 삭제하고 수동으로 다시 작성하십시오.
    ```
      kubectl delete pod <pod_name>
    ```
    {: pre}

4. 팟(Pod)을 다시 작성하여 문제가 해결되는지 확인하십시오. 그렇지 않으면, 작업자 노드를 다시 로드하십시오.
   1. 팟(Pod)이 실행되는 작업자 노드를 찾아 작업자 노드에 지정된 사설 IP 주소를 기록해 두십시오.
      ```
      kubectl describe pod <pod_name> | grep Node
      ```
      {: pre}

      출력 예:
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. 이전 단계의 사설 IP 주소를 사용하여 작업자 노드의 **ID**를 검색하십시오.
      ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}

   3. 올바르게 [작업자 노드를 다시 로드](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload)하십시오.


<br />


## 블록 스토리지: 파일 시스템 오류로 인해 기존 블록 스토리지를 팟(Pod)에 마운트할 수 없음
{: #block_filesystem}

{: tsSymptoms}
`kubectl describe pod <pod_name>`을 실행할 때 다음 오류가 표시됩니다.
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
`XFS` 파일 시스템을 사용하여 설정된 기존 블록 스토리지 디바이스가 있습니다. 이 디바이스를 팟(Pod)에 마운트하기 위해 `spec/flexVolume/fsType`에서 `ext4`를 파일 시스템으로 지정하거나 파일 시스템을 지정하지 않은 [PV를 작성](/docs/containers?topic=containers-block_storage#existing_block)했습니다. 파일 시스템이 정의되지 않으면 기본적으로 PV가 `ext4`로 설정됩니다.
PV가 성공적으로 작성되고 기존 블록 스토리지 인스턴스에 링크되었습니다. 그러나 일치하는 PVC를 사용하여 PV를 클러스터에 마운트하려고 하면 볼륨 마운트에 실패합니다. `ext4` 파일 시스템을 사용하는 `XFS` 블록 스토리지 인스턴스를 팟(Pod)에 마운트할 수 없습니다.

{: tsResolve}
기존 PV의 파일 시스템을 `ext4`에서 `XFS`로 업데이트하십시오.

1. 클러스터에 있는 기존 PV를 나열하고 기존 블록 스토리지 인스턴스에 사용한 PV의 이름을 기록해 두십시오.
   ```
   kubectl get pv
   ```
   {: pre}

2. 로컬 머신에 PV YAML을 저장하십시오.
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. YAML 파일을 열고 `fsType`을 `ext4`에서 `xfs`로 변경하십시오.
4. 클러스터의 PV를 대체하십시오.
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. PV를 마운트한 팟(Pod)에 로그인하십시오.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. 파일 시스템이 `XFS`로 변경되었는지 확인하십시오.
   ```
   df -Th
   ```
   {: pre}

   출력 예:
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## 오브젝트 스토리지: {{site.data.keyword.cos_full_notm}} `ibmc` Helm 플러그인 설치에 실패함
{: #cos_helm_fails}

{: tsSymptoms}
{{site.data.keyword.cos_full_notm}} `ibmc` Helm 플러그인을 설치하면 다음 오류로 설치에 실패합니다.
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
`ibmc` Helm 플러그인이 설치되면 `./helm/plugins/helm-ibmc` 디렉토리에서 `ibmc` Helm 플러그인이 시스템에 위치한 디렉토리(일반적으로 `./ibmcloud-object-storage-plugin/helm-ibmc`에 있음)로 symlink가 작성됩니다. 로컬 시스템에서 `ibmc` Helm 플러그인을 제거하거나 `ibmc` Helm 플러그인 디렉토리를 다른 위치로 이동하는 경우, symlink가 제거되지 않습니다.

{: tsResolve}
1. {{site.data.keyword.cos_full_notm}} Helm 플러그인을 제거하십시오.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. [{{site.data.keyword.cos_full_notm}}을 설치](/docs/containers?topic=containers-object_storage#install_cos)하십시오.

<br />


## 오브젝트 스토리지: Kubernetes 시크릿을 찾을 수 없으므로 PVC 또는 팟(Pod) 작성에 실패함
{: #cos_secret_access_fails}

{: tsSymptoms}
PVC를 작성하거나 PVC를 마운트하는 팟(Pod)을 배치할 때 작성이나 배치에 실패합니다.

- PVC 작성 실패에 대한 오류 메시지의 예:
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- 팟(Pod) 작성 실패에 대한 오류 메시지의 예:
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}

{: tsCauses}
{{site.data.keyword.cos_full_notm}} 서비스 인증 정보, PVC 및 팟(Pod)이 저장된 Kubernetes 시크릿이 모두 동일한 Kubernetes 네임스페이스에 있지 않습니다. 시크릿이 PVC 또는 팟(Pod)과 다른 네임스페이스에 배치되면 시크릿에 액세스할 수 없습니다.

{: tsResolve}
이 태스크에서는 네임스페이스에 대해 [**작성자** 또는 **관리자** {{site.data.keyword.Bluemix_notm}} IAM 서비스 역할](/docs/containers?topic=containers-users#platform)이 필요합니다.

1. 클러스터의 시크릿을 나열하고 {{site.data.keyword.cos_full_notm}} 서비스 인스턴스의 Kubernetes 시크릿이 작성된 Kubernetes 네임스페이스를 검토하십시오. 시크릿은 `ibm/ibmc-s3fs`를 **유형**으로 표시해야 합니다.
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. PVC 및 팟(Pod)의 YAML 구성 파일을 검사하여 동일한 네임스페이스가 사용되었는지 확인하십시오. 시크릿이 존재하는 네임스페이스와는 다른 네임스페이스에 팟(Pod)을 배치하려면 해당 네임스페이스에서 [다른 시크릿을 작성](/docs/containers?topic=containers-object_storage#create_cos_secret)하십시오.

3. PVC를 작성하거나 적절한 네임스페이스에 팟(Pod)을 배치하십시오.

<br />


## 오브젝트 스토리지: 잘못된 인증 정보 또는 액세스 거부로 인해 PVC 작성에 실패함
{: #cred_failure}

{: tsSymptoms}
PVC를 작성할 때 다음 중 하나와 유사한 오류 메시지가 나타납니다.

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403
```
{: screen}

```
CredentialsEndpointError: failed to load credentials
```
{: screen}

{: tsCauses}
서비스 인스턴스에 액세스하기 위해 사용하는 {{site.data.keyword.cos_full_notm}} 서비스 인증 정보가 올바르지 않거나 버킷에 대한 읽기 액세스만 허용합니다.

{: tsResolve}
1. 서비스 세부사항 페이지의 탐색에서 **서비스 인증 정보**를 클릭하십시오.
2. 인증 정보를 찾은 후에 **인증 정보 보기**를 클릭하십시오.
3. Kubernetes 시크릿의 올바른 **access_key_id** 및 **secret_access_key**를 사용 중인지 확인하십시오. 그렇지 않은 경우에는 Kubernetes 시크릿을 업데이트하십시오.
   1. 시크릿 작성에 사용한 YAML을 가져오십시오.
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}

   2. **access_key_id** 및 **secret_access_key**를 업데이트하십시오.
   3. 시크릿을 업데이트하십시오.
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

4. **iam_role_crn** 섹션에서 `Writer` 또는 `Manager` 역할을 보유하는지 확인하십시오. 올바른 역할이 없는 경우에는 [올바른 권한으로 새 {{site.data.keyword.cos_full_notm}} 서비스 인증 정보를 작성](/docs/containers?topic=containers-object_storage#create_cos_service)해야 합니다. 그리고 기존 시크릿을 업데이트하거나 새 서비스 인증 정보로 [새 시크릿을 작성](/docs/containers?topic=containers-object_storage#create_cos_secret)하십시오.

<br />


## 오브젝트 스토리지: 기존 버킷에 액세스할 수 없음

{: tsSymptoms}
PVC를 작성할 때 {{site.data.keyword.cos_full_notm}}의 버킷에 액세스할 수 없습니다. 다음과 유사한 오류 메시지가 표시될 수 있습니다.

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
올바르지 않은 스토리지 클래스를 사용하여 기존 버킷에 액세스했거나 작성하지 않은 버킷에 액세스를 시도했을 수 있습니다.

{: tsResolve}
1. [{{site.data.keyword.Bluemix_notm}} 대시보드 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/)에서 {{site.data.keyword.cos_full_notm}} 서비스 인스턴스를 선택하십시오.
2. **버킷**을 선택하십시오.
3. 기존 버킷의 **클래스** 및 **위치** 정보를 검토하십시오.
4. 적합한 [스토리지 클래스](/docs/containers?topic=containers-object_storage#cos_storageclass_reference)를 선택하십시오.

<br />


## 오브젝트 스토리지: 비-루트 사용자로 파일 액세스에 실패함
{: #cos_nonroot_access}

{: tsSymptoms}
콘솔 또는 REST API를 사용하여 {{site.data.keyword.cos_full_notm}} 서비스 인스턴스에 파일을 업로드했습니다. 앱 배치에서 `runAsUser`로 정의된 비-루트 사용자로 이러한 파일에 액세스를 시도하면 파일에 대한 액세스가 거부됩니다.

{: tsCauses}
Linux에서는 파일 또는 디렉토리에 3개의 액세스 그룹(`Owner`, `Group` 및 `Other`)이 있습니다. 콘솔 또는 REST API를 사용하여 {{site.data.keyword.cos_full_notm}}에 파일을 업로드하면 `Owner`, `Group` 및 `Other`에 대한 권한이 제거됩니다. 각 파일의 권한은 다음과 같이 나타날 수 있습니다.

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

{{site.data.keyword.cos_full_notm}} 플러그인을 사용하여 파일을 업로드하면 파일에 대한 권한이 유지되며 변경되지 않습니다.

{: tsResolve}
비-루트 사용자로 파일에 액세스하려면 비-루트 사용자에게 해당 파일에 대한 읽기 및 쓰기 권한이 있어야 합니다. 팟(Pod) 배치의 일부로서 파일에 대한 권한을 변경하려면 쓰기 권한이 필요합니다. {{site.data.keyword.cos_full_notm}}는 쓰기 워크로드용으로 디자인되지 않았습니다. 팟(Pod) 배치 중에 권한을 업데이트하면 팟(Pod)이 `Running` 상태가 되지 못할 수 있습니다.

이 문제를 해결하려면 PVC를 앱 팟(Pod)에 마운트하기 전에 다른 팟(Pod)을 작성하여 비-루트 사용자에 대한 올바른 권한을 설정하십시오.

1. 버킷에서 파일의 권한을 확인하십시오.
   1. `test-permission` 팟(Pod)의 구성 파일을 작성하고 파일 이름을 `test-permission.yaml`로 지정하십시오.
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc_name>
      ```
      {: codeblock}

   2. `test-permission` 팟(Pod)을 작성하십시오.
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}

   3. 팟(Pod)에 로그인하십시오.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. 마운트 경로로 이동하고 파일에 대한 권한을 나열하십시오.
      ```
      cd test && ls -al
      ```
      {: pre}

      출력 예:
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}

2. 팟(Pod)을 삭제하십시오.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. 파일의 권한 정정에 사용되는 팟(Pod)의 구성 파일을 작성하고 이름을 `fix-permission.yaml`로 지정하십시오.
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission 
     namespace: <namespace>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nonroot_userID> <mount_path>/*; find <mount_path>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mount_path>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

3. `fix-permission` 팟(Pod)을 작성하십시오.
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. 팟(Pod)이 `Completed` 상태가 될 때까지 대기하십시오.  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. `fix-permission` 팟(Pod)을 삭제하십시오.
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. 권한 확인을 위해 이전에 사용된 `test-permission` 팟(Pod)을 재작성하십시오.
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. 파일에 대한 권한이 업데이트되었는지 확인하십시오.
   1. 팟(Pod)에 로그인하십시오.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. 마운트 경로로 이동하고 파일에 대한 권한을 나열하십시오.
      ```
      cd test && ls -al
      ```
      {: pre}

      출력 예:
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}

6. `test-permission` 팟(Pod)을 삭제하십시오.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. 비-루트 사용자로 PVC를 앱에 마운트하십시오.

   동시에 배치 YAML에서 `fsGroup` 설정 없이 `runAsUser`로서 비-루트 사용자를 정의하십시오. `fsGroup`을 설정하면 팟(Pod) 배치 시에 버킷의 모든 파일에 대한 그룹 권한을 업데이트하도록 {{site.data.keyword.cos_full_notm}} 플러그인이 트리거됩니다. 권한 업데이트는 쓰기 오퍼레이션이며, 이로 인해 팟(Pod)이 `Running` 상태가 되지 못할 수 있습니다.
   {: important}

{{site.data.keyword.cos_full_notm}} 서비스 인스턴스에서 올바른 파일 권한을 설정한 후에는 콘솔 또는 REST API를 사용하여 파일을 업로드하지 마십시오. {{site.data.keyword.cos_full_notm}} 플러그인을 사용하여 파일을 서비스 인스턴스에 추가하십시오.
{: tip}

<br />




## 도움 및 지원 받기
{: #storage_getting_help}

클러스터에 여전히 문제점이 있습니까?
{: shortdesc}

-  터미널에서 `ibmcloud` CLI 및 플러그인에 대한 업데이트가 사용 가능한 시점을 사용자에게 알려줍니다. 사용 가능한 모든 명령과 플래그를 사용할 수 있도록 반드시 CLI를 최신 상태로 유지하십시오.
-   {{site.data.keyword.Bluemix_notm}}가 사용 가능한지 확인하려면 [{{site.data.keyword.Bluemix_notm}} 상태 페이지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")를 확인](https://cloud.ibm.com/status?selected=status)하십시오.
-   [{{site.data.keyword.containerlong_notm}} Slack ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://ibm-container-service.slack.com)에 질문을 게시하십시오.
    {{site.data.keyword.Bluemix_notm}} 계정에 대해 IBM ID를 사용 중이 아닌 경우에는 이 Slack에 대한 [초대를 요청](https://bxcs-slack-invite.mybluemix.net/)하십시오.
    {: tip}
-   포럼을 검토하여 다른 사용자에게도 동일한 문제가 발생하는지 여부를 확인하십시오. 포럼을 사용하여 질문을 할 때는 {{site.data.keyword.Bluemix_notm}} 개발 팀이 볼 수 있도록 질문에 태그를 지정하십시오.
    -   {{site.data.keyword.containerlong_notm}}로 클러스터 또는 앱을 개발하거나 배치하는 데 대한 기술적 질문이 있으면 [Stack Overflow![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)에 질문을 게시하고 질문에 `ibm-cloud`, `kubernetes` 및 `containers` 태그를 지정하십시오.
    -   서비스 및 시작하기 지시사항에 대한 질문이 있으면 [IBM Developer Answers ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 포럼을 사용하십시오. `ibm-cloud` 및 `containers` 태그를 포함하십시오.
    포럼 사용에 대한 세부사항은 [도움 받기](/docs/get-support?topic=get-support-getting-customer-support#using-avatar)를 참조하십시오.
-   케이스를 열어 IBM 지원 센터에 문의하십시오. IBM 지원 케이스 열기 또는 지원 레벨 및 케이스 심각도에 대해 알아보려면 [지원 문의](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support)를 참조하십시오.
문제를 보고할 때 클러스터 ID를 포함시키십시오. 클러스터 ID를 가져오려면 `ibmcloud ks clusters`를 실행하십시오. 또한 [{{site.data.keyword.containerlong_notm}} 진단 및 디버그 도구](/docs/containers?topic=containers-cs_troubleshoot#debug_utility)를 사용하여 IBM 지원 센터와 공유할 관련 정보를 클러스터에서 수집하고 내보낼 수도 있습니다.
{: tip}

