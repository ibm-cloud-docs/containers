---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 지속적 볼륨 스토리지로 데이터 저장
{: #planning}

컨테이너는 설계 상으로 수명이 짧습니다. 하지만 다음 다이어그램에 표시된 대로 컨테이너 장애 복구 시에 데이터의 지속성을 유지하고 컨테이너 간에 데이터를 공유하기 위한 다수의 옵션 중에서 선택할 수 있습니다.
{:shortdesc}

**참고**: 방화벽이 있는 경우, 지속적 볼륨 클레임을 작성할 수 있도록 클러스터가 있는 위치(데이터 센터)의 IBM Cloud 인프라(SoftLayer) IP 범위에 대해 [egress 액세스를 허용](cs_firewall.html#pvc)하십시오.

![Kubernetes 클러스터의 배포를 위한 지속적 스토리지 옵션](images/cs_planning_apps_storage.png)

|옵션|설명|
|------|-----------|
|옵션 1: 작업자 노드에서 사용 가능한 디스크 공간을 사용하여 데이터의 지속성을 유지하도록 `/emptyDir` 사용<p>이 기능은 라이트 및 표준 클러스터에서 사용할 수 있습니다.</p>|이 옵션을 사용하면 포드에 지정된 작업자 노드의 디스크 공간에서 비어 있는 볼륨을 작성할 수 있습니다. 
해당 포드의 컨테이너는 해당 볼륨에서 읽고 쓰기가 가능합니다. 볼륨이 하나의 특정 포드에 지정되므로, 데이터는 복제본 세트의 기타 포드와 공유될 수 없습니다.<p>`/emptyDir` 볼륨과 해당 데이터는 지정된 포드가 작업자 노드에서 영구 삭제될 때 제거됩니다.</p><p>**참고:** 포드 내의 컨테이너에 장애가 발생하는 경우, 볼륨의 데이터는 작업자 노드에서 계속 사용 가능합니다.</p><p>자세한 정보는 [Kubernetes 볼륨 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/storage/volumes/)을 참조하십시오.</p>|
|옵션 2: 배치를 위한 NFS 기반 지속적 스토리지를 프로비저닝하는 지속적 볼륨 클레임 작성<p>이 기능은 표준 클러스터에 대해서만 사용 가능합니다.</p>|<p>이 옵션을 사용하면 지속적 볼륨을 통해 컨테이너 데이터와 앱의 지속적 스토리지를 보유할 수 있습니다. 볼륨은 [내구력 및 성능 NFS 기반 파일 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/file-storage/details)에서 호스팅됩니다. 파일 스토리지는 저장 시 암호화되며, 저장된 데이터의 복제본을 작성할 수 있습니다.</p> <p>NFS 기반 파일 스토리지의 요청을 시작하기 위해 [지속적 볼륨 클레임](cs_storage.html)을 작성합니다. {{site.data.keyword.containershort_notm}}는 스토리지 크기의 범위, IOPS, 삭제 정책 및 볼륨에 대한 읽기/쓰기 권한을 정의하는 사전 정의된 스토리지 클래스를 제공합니다. 지속적 볼륨 클레임을 작성할 때 이러한 스토리지 클래스 간에 선택할 수 있습니다. 지속적 볼륨 클레임을 제출한 후 {{site.data.keyword.containershort_notm}}는 NFS 기반 파일 스토리지에서 호스팅되는 지속적 볼륨을 동적으로 프로비저닝합니다. [지속적 볼륨 클레임을 배치에 대한 볼륨으로 마운트](cs_storage.html#create)하여 컨테이너가 볼륨에서 읽고 쓸 수 있도록 허용할 수 있습니다. 지속적 볼륨은 동일한 복제본 세트 간에 또는 동일한 클러스터 내의 다른 배치와 공유될 수 있습니다.</p><p>컨테이너에 장애가 발생하거나 포드가 작업자 노드에서 제거되는 경우, 데이터는 제거되지 않으며 볼륨을 마운트하는 기타 배치에 의해 계속해서 액세스될 수 있습니다. 지속적 볼륨 클레임은 지속적 스토리지에서 호스팅되지만 백업은 없습니다. 데이터를 백업해야 하는 경우 수동 백업을 작성하십시오.</p><p>**참고:** 지속적 NFS 파일 공유 스토리지는 월별 기반으로 비용이 부과됩니다. 클러스터에 대한 지속적 스토리지를 프로비저닝하고 이를 즉시 제거하는 경우, 짧은 시간 동안만 사용했어도 지속적 스토리지에 대한 월별 비용을 계속 지불해야 합니다.</p>|
|옵션 3: 포드에 {{site.data.keyword.Bluemix_notm}} 데이터베이스 서비스 바인드<p>이 기능은 라이트 및 표준 클러스터에서 사용할 수 있습니다.</p>|이 옵션을 사용하면 {{site.data.keyword.Bluemix_notm}} 데이터베이스 클라우드 서비스를 사용하여 데이터의 지속성을 유지하고 이에 액세스할 수 있습니다. {{site.data.keyword.Bluemix_notm}} 서비스를 클러스터의 네임스페이스에 바인드하면, Kubernetes 시크릿이 작성됩니다. Kubernetes 시크릿은 서비스에 대한 기밀 정보를 유지합니다(예: 서비스에 대한 URL, 사용자 이름 및 비밀번호). 시크릿을 시크릿 볼륨으로서 포드에 마운트하고, 시크릿의 신임 정보를 사용하여 서비스에 액세스할 수 있습니다. 시크릿 볼륨을 기타 포드에 마운트하여 포드 간의 데이터를 공유할 수도 있습니다.<p>컨테이너에 장애가 발생하거나 포드가 작업자 노드에서 제거되는 경우, 데이터는 제거되지 않으며 시크릿 볼륨을 마운트하는 기타 포드에 의해 계속해서 액세스될 수 있습니다.</p><p>대부분의 {{site.data.keyword.Bluemix_notm}} 데이터베이스 서비스에서는 적은 양의 데이터를 위한 디스크 공간을 무료로 제공하므로 해당 기능을 테스트할 수 있습니다.</p><p>{{site.data.keyword.Bluemix_notm}} 서비스를 포드에 바인드하는 방법에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}에서 앱의 {{site.data.keyword.Bluemix_notm}} 서비스 추가](cs_integrations.html#adding_app)를 참조하십시오. </p>|
{: caption="테이블. Kubernetes 클러스터에서의 배치를 위한 지속적 데이터 스토리지 옵션" caption-side="top"}

<br />



## 클러스터에서 기존 NFS 파일 공유 사용
{: #existing}

Kubernetes와 함께 사용할 IBM Cloud 인프라(SoftLayer) 계정의 기존 NFS 파일 공유가 이미 있는 경우, 기존 NFS 파일 공유에서 지속적 볼륨을 작성하여 수행할 수 있습니다. 지속적 볼륨은 Kubernetes 클러스터 리소스 역할을 하는 실제 하드웨어의 한 부분이며 클러스터 사용자가 이용할 수 있습니다.
{:shortdesc}

Kubernetes는 실제 하드웨어를 나타내는 지속적 볼륨과 일반적으로 클러스터 사용자가 시작하는 스토리지에 대한 요청인 지속적 볼륨 클레임을 구별합니다. 다음 다이어그램은 지속적 볼륨과 지속적 볼륨 클레임 간의 관계를 설명합니다.

![지속적 볼륨 및 지속적 볼륨 클레임 작성](images/cs_cluster_pv_pvc.png)

 다이어그램에 표시된 대로 기존 NFS 파일 공유가 Kubernetes와 함께 사용될 수 있도록 하려면 특정 크기와 액세스 모드로 지속적 볼륨을 작성하고 그 지속적 볼륨 스펙과 일치하는 지속적 볼륨 클레임을 작성해야 합니다. 지속적 볼륨과 지속적 볼륨 클레임이 일치하는 경우 서로 바인드됩니다. 바인드된 지속적 볼륨 클레임만 볼륨을 배치에 마운트하기 위해 클러스터 사용자가 사용할 수 있습니다. 이 프로세스를 지속적 스토리지의 정적 프로비저닝이라고 합니다.

시작하기 전에 지속적 볼륨을 작성하기 위해 사용할 수 있는 기존 NFS 파일 공유가 있는지 확인하십시오.

**참고:** 지속적 스토리지의 정적 프로비저닝은 기존 NFS 파일 공유에만 적용됩니다. 기존 NFS 파일 공유가 없는 경우, 클러스터 사용자는 지속적 볼륨을 추가하기 위해 [동적 프로비저닝](cs_storage.html#create) 프로세스를 사용할 수 있습니다.

지속적 볼륨 및 일치하는 지속적 볼륨 클레임을 작성하려면 다음 단계를 따르십시오.

1.  IBM Cloud 인프라(SoftLayer) 계정에서 지속적 볼륨 오브젝트를 작성할 NFS 파일 공유의 ID 및 경로를 검색하십시오. 또한 파일 스토리지에 클러스터의 서브넷에 대한 권한을 부여하십시오. 이 권한 부여는 클러스터에 스토리지에 대한 액세스 권한을 제공합니다.
    1.  IBM Cloud 인프라(SoftLayer) 계정에 로그인하십시오.
    2.  **스토리지**를 클릭하십시오.
    3.  **조치** 메뉴에서 **파일 스토리지**를 클릭하고 **호스트에 권한 부여**를 선택하십시오.
    4.  **서브넷**을 클릭하십시오. 권한을 부여한 후에는 서브넷 상의 모든 작업자 노드에 파일 스토리지에 대한 액세스 권한이 있습니다.
    5.  메뉴에서 클러스터의 퍼블릭 VLAN의 서브넷을 선택하고 **제출**을 클릭하십시오. 서브넷을 찾아야 하는 경우에는 `bx cs cluster-get <cluster_name> --showResources`를 실행하십시오.
    6.  파일 스토리지의 이름을 클릭하십시오.
    7.  **마운트 포인트** 필드를 기록해 두십시오. 이 필드는 `<server>:/<path>`로 표시됩니다.
2.  지속적 볼륨에 대한 스토리지 구성 파일을 작성하십시오. 파일 스토리지 **마운트 포인트** 필드의 서버 및 경로를 포함하십시오.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>테이블. YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>작성하려는 지속적 볼륨 오브젝트의 이름을 입력하십시오.</td>
    </tr>
    <tr>
    <td><code>스토리지</code></td>
    <td>기존 NFS 파일 공유의 스토리지 크기를 입력하십시오. 스토리지 크기는 기가바이트(예: 20Gi(20GB) 또는 1000Gi(1TB))로 기록되어야 하며 그 크기는 기존 파일 공유의 크기와 일치해야 합니다.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>액세스 모드는 지속적 볼륨이 작업자 노드에 마운트될 수 있는 방법을 정의합니다.<ul><li>ReadWriteOnce(RWO): 지속적 볼륨이 단일 작업자 노드의 배치에만 마운트될 수 있습니다. 이 지속적 볼륨에 마운트된 배치의 컨테이너는 볼륨에서 읽기 및 쓰기가 가능합니다.</li><li>ReadOnlyMany(ROX): 지속적 볼륨이 다중 작업자 노드에 호스팅된 배치에 마운트될 수 있습니다. 이 지속적 볼륨에 마운트된 배치는 볼륨에서 읽기만 가능합니다.</li><li>ReadWriteMany(RWX): 이 지속적 볼륨이 다중 작업자 노드에 호스팅된 배치에 마운트될 수 있습니다. 이 지속적 볼륨에 마운트된 배치는 볼륨에서 읽기 및 쓰기가 가능합니다.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>NFS 파일 공유 서버 ID를 입력하십시오.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>지속적 볼륨 오브젝트를 작성하려는 NFS 파일 공유에 대한 경로를 입력하십시오.</td>
    </tr>
    </tbody></table>

3.  클러스터에 지속적 볼륨 오브젝트를 작성하십시오.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    예

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  지속적 볼륨이 작성되었는지 확인하십시오.

    ```
    kubectl get pv
    ```
    {: pre}

5.  다른 구성 파일을 작성하여 지속적 볼륨 클레임을 작성하십시오. 지속적 볼륨 클레임이 이전에 작성한 지속적 볼륨 오브젝트와 일치하도록 `storage` 및 `accessMode`에 동일한 값을 선택해야 합니다. `storage-class` 필드는 비어 있어야 합니다. 이러한 필드 중에 지속적 볼륨과 일치하지 않는 것이 있는 경우에는 대신 새 지속적 볼륨이 자동으로 작성됩니다.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  지속적 볼륨 클레임을 작성하십시오.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  지속적 볼륨 클레임이 작성되고 지속적 볼륨 오브젝트에 바인드되었는지 확인하십시오. 이 프로세스는 몇 분 정도 소요됩니다.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    출력은 다음과 같이 표시됩니다.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


지속적 볼륨 오브젝트를 작성했으며 지속적 볼륨 클레임에 바인드했습니다. 이제 클러스터 사용자는 자신의 배치에 [지속적 볼륨 클레임을 마운트](#app_volume_mount)하고 지속적 볼륨 오브젝트에서 읽거나 쓰기를 시작할 수 있습니다.

<br />


## 앱의 지속적 스토리지 작성
{: #create}

클러스터의 NFS 파일 스토리지를 프로비저닝하는 PVC(persistent volume claim)를 작성합니다. 그런 다음, 포드가 충돌하거나 종료된 경우에도 데이터를 사용할 수 있도록 이 클레임을 배치에 마운트합니다.
{:shortdesc}

 지속적 볼륨을 지원하는 NFS 파일 스토리지는 데이터에 대한 고가용성을 제공할 수 있도록 IBM에서 클러스터링합니다.

1.  사용 가능한 스토리지 클래스를 검토하십시오. {{site.data.keyword.containerlong}}는 클러스터 관리자가 스토리지 클래스를 작성할 필요가 없도록 8개의 사전 정의된 스토리지 클래스를 제공합니다. `ibmc-file-bronze` 스토리지 클래스는 `default` 스토리지 클래스와 동일합니다.

    ```
     kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  pvc를 삭제한 후 데이터 및 NFS 파일 공유를 저장할지 여부를 결정하십시오. 데이터를 보존하려면 `retain` 스토리지 클래스를 선택하십시오. pvc를 삭제할 때 데이터 및 파일 공유가 삭제되도록 하려면 `retain`이 없는 스토리지 클래스를 선택하십시오.

3.  사용 가능한 스토리지 크기 및 스토리지 클래스의 IOPS를 검토하십시오.

    - 브론즈, 실버 및 골드 스토리지 클래스는 [Endurance 스토리지![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/endurance-storage)를 사용하며 각 클래스에 대해 GB당 하나의 IOPS가 정의되어 있습니다. 총 IOPS는 스토리지의 크기에 따라 다릅니다. 예를 들어, GB당 4IOPS의 1000Gi pvc에는 총 4000IOPS가 있습니다.

      ```
     kubectl describe storageclasses ibmc-file-silver
      ```
      {: pre}

      **매개변수** 필드는 스토리지 클래스와 연관된 GB당 IOPS 및 사용 가능한 크기(기가바이트 단위)를 제공합니다.

      ```
     Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
      ```
      {: screen}

    - 사용자 정의 스토리지 클래스는 [Performance 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/performance-storage)를 사용하며 총 IOPS 및 크기에 대한 별도의 옵션을 가집니다.

      ```
    kubectl describe storageclasses ibmc-file-retain-custom
      ```
      {: pre}

      **매개변수** 필드는 스토리지 클래스와 연관된 IOPS 및 사용 가능한 크기(기가바이트 단위)를 제공합니다. 예를 들어, 40Gi pvc는 100 - 2000IOPS 범위에 있는 100의 배수인 IOPS를 선택할 수 있습니다.

      ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
      ```
      {: screen}

4.  지속적 볼륨 클레임을 정의하는 구성 파일을 작성하고 해당 구성을 `.yaml` 파일로 저장하십시오.

    브론즈, 실버, 골드 클래스에 대한 예제:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    사용자 정의 클래스에 대한 예제:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>지속적 볼륨 클레임의 이름을 입력하십시오.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>지속적 볼륨에 대한 스토리지 클래스를 정의하십시오.
      <ul>
      <li>ibmc-file-bronze/ibmc-file-retain-bronze: GB당 2IOPS</li>
      <li>ibmc-file-silver/ibmc-file-retain-silver: GB당 4IOPS</li>
      <li>ibmc-file-gold/ibmc-file-retain-gold: GB당 10IOPS</li>
      <li>ibmc-file-custom/ibmc-file-retain-custom: 다중 IOPS 값이 사용 가능합니다.

    </li> 스토리지 클래스를 지정하지 않으면 브론즈 스토리지 클래스로 지속적 볼륨이 작성됩니다.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> 나열된 크기 이외의 크기를 선택하면 해당 크기가 올림됩니다. 최대 크기보다 더 큰 크기를 선택하는 경우에는 내림됩니다.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>이 옵션은 ibmc-file-custom/ibmc-file-retain-custom에만 해당됩니다. 스토리지에 대한 총 IOPS를 지정하십시오. 모든 옵션을 보려면 `kubectl describe storageclasses ibmc-file-custom`을 실행하십시오. 나열된 것과 이외의 IOPS를 선택하면 IOPS가 올림됩니다.</td>
    </tr>
    </tbody></table>

5.  지속적 볼륨 클레임을 작성하십시오.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  지속적 볼륨 클레임이 작성되고 지속적 볼륨에 바인드되었는지 확인하십시오. 이 프로세스는 몇 분 정도 소요됩니다.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    출력은 다음과 같이 표시됩니다.

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #app_volume_mount}지속적 볼륨 클레임을 배치에 마운트하려면 구성 파일을 작성하십시오. 구성을 `.yaml` 파일로 저장하십시오.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <deployment_name>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app_name>
    spec:
     containers:
     - image: <image_name>
       name: <container_name>
       volumeMounts:
       - mountPath: /<file_path>
         name: <volume_name>
     volumes:
     - name: <volume_name>
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>배치의 이름입니다.</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>배치의 레이블입니다.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>배치 내에서 볼륨이 마운트되는 디렉토리의 절대 경로입니다.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>배치에 마운트할 볼륨의 이름입니다.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>배치에 마운트할 볼륨의 이름입니다. 일반적으로 이 이름은 <code>volumeMounts/name</code>과 동일합니다.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>볼륨으로 사용할 지속적 볼륨 클레임의 이름입니다. 볼륨을 배치에 마운트하는 경우, Kubernetes는 지속적 볼륨 클레임에 바인드된 지속적 볼륨을 식별하며 사용자가 지속적 볼륨에서 읽고 쓸 수 있도록 합니다.</td>
    </tr>
    </tbody></table>

8.  배치를 작성하고 지속적 볼륨 클레임을 마운트하십시오.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  볼륨이 성공적으로 마운트되었는지 확인하십시오.

    ```
    kubectl describe deployment <deployment_name>
    ```
    {: pre}

    마운트 지점은 **볼륨 마운트** 필드에 있고 볼륨은 **볼륨** 필드에 있습니다.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />




## 지속적 스토리지에 루트가 아닌 사용자 액세스 추가
{: #nonroot}

루트가 아닌 사용자에게는 NFS 지원 스토리지의 볼륨 마운트 경로에 대한 쓰기 권한이 없습니다. 쓰기 권한을 부여하려면, 이미지의 Dockerfile을 편집하여 올바른 권한으로 마운트 경로에서 디렉토리를 작성해야 합니다.
{:shortdesc}

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

볼륨에 대한 쓰기 권한이 필요한 비루트 사용자로 앱을 디자인하는 경우, 다음 프로세스를 Dockerfile 및 시작점 스크립트에 추가해야 합니다.

-   비루트 사용자를 작성하십시오.
-   임시로 사용자를 루트 그룹에 추가하십시오.
-   올바른 사용자 권한으로 볼륨 마운트 경로에서 디렉토리를 작성하십시오.

{{site.data.keyword.containershort_notm}}의 경우 볼륨 마운트 경로의 기본 소유자는 `nobody` 소유자입니다. NFS 스토리지에서 소유자가 포드의 로컬에 없으면 `nobody` 사용자가 작성됩니다. 볼륨은 컨테이너의 루트 사용자를 인식하도록 설정됩니다. 일부 앱에서는 이 사용자가 컨테이너의 유일한 사용자입니다. 그러나 다수의 앱에서는 `nobody`가 아니라 컨테이너 마운트 경로에 쓰는 루트가 아닌 사용자를 지정합니다. 일부 앱은 루트 사용자가 볼륨을 소유하도록 지정합니다. 일반적으로 앱은 보안 문제로 인해 루트 사용자를 사용하지 않습니다. 하지만 앱에 루트 사용자가 필요한 경우 도움을 받기 위해 [{{site.data.keyword.Bluemix_notm}} 지원](/docs/support/index.html#contacting-support)에 문의할 수 있습니다.


1.  로컬 디렉토리에서 Dockerfile을 작성하십시오. 이 예제 Dockerfile은 이름이 `myguest`인 비루트 사용자를 작성합니다.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    #The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
        RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

        COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Dockerfile과 동일한 로컬 폴더에 시작점 스크립트를 작성하십시오. 이 예제 시작점 스크립트는 볼륨 마운트 경로로 `/mnt/myvol`을 지정합니다.

    ```
    #!/bin/bash
    set -e

    #This is the mount point for the shared volume.
        #By default the mount point is owned by the root user.
        MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
          #Add the non-root user to primary group of root user.
          usermod -aG root $MY_USER

          #Provide read-write-execute permission to the group for the shared volume mount path.
          chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #For security, remove the non-root user from root user group.
            deluser $MY_USER root

      #Change the shared volume mount path back to its original read-write-execute permission.
            chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

        #This command creates a long-running process for the purpose of this example.
        tail -F /dev/null
    ```
    {: codeblock}

3.  {{site.data.keyword.registryshort_notm}}에 로그인하십시오.

    ```
    bx cr login
    ```
    {: pre}

4.  로컬에서 이미지를 빌드하십시오. _&lt;my_namespace&gt;_를 개인용 이미지 레지스트리의 네임스페이스로 대체하십시오. 네임스페이스를 찾아야 하면 `bx cr namespace-get`를 실행하십시오.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  {{site.data.keyword.registryshort_notm}}에서 네임스페이스에 이미지를 푸시하십시오.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  구성 `.yaml` 파일을 작성하여 지속적 볼륨 클레임을 작성하십시오. 이 예에서는 낮은 성능 스토리지 클래스를 사용합니다. 사용 가능한 스토리지 클래스를 보려면 `kubectl get storageclasses`를 실행하십시오.

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

7.  지속적 볼륨 클레임을 작성하십시오.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  볼륨을 마운트하고 루트가 아닌 이미지에서 포드를 실행하기 위한 구성 파일을 작성하십시오. 볼륨 마운트 경로 `/mnt/myvol`은 Dockerfile에 지정된 마운트 경로와 일치합니다. 구성을 `.yaml` 파일로 저장하십시오.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  포드를 작성하고 지속적 볼륨 클레임을 포드에 마운트하십시오.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. 볼륨이 포드에 정상적으로 마운트되었는지 확인하십시오.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    마운트 지점이 **볼륨 마운트** 필드에 나열되며, 볼륨이 **볼륨** 필드에 나열됩니다.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. 포드가 실행된 후 포드에 로그인하십시오.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. 볼륨 마운트 경로의 권한을 보십시오.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
        drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    이 출력은 해당 루트에 볼륨 마운트 경로 `mnt/myvol/`에 대한 읽기, 쓰기 및 실행 권한이 있는 것으로 표시하지만 루트가 아닌 myguest 사용자에게는 `mnt/myvol/mydata` 폴더에 대한 읽기 및 쓰기 권한이 있습니다. 이 업데이트된 권한 때문에 비루트 사용자는 이제 데이터를 지속적 볼륨에 쓸 수 있습니다.


