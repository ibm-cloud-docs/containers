---

copyright:
  years: 2014, 2018
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





# IBM Block Storage for IBM Cloud에 데이터 저장
{: #block_storage}


## 클러스터에 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인 설치
{: #install_block}

{{site.data.keyword.Bluemix_notm}} Block Storage 플러그인을 Helm 차트와 함께 설치하여 블록 스토리지를 위한 사전 정의된 스토리지 클래스를 설정하십시오. 이러한 스토리지 클래스를 사용하여 앱을 위한 블록 스토리지를 프로비저닝하는 데 필요한 PVC를 작성할 수 있습니다.
{: shortdesc}

시작하기 전에 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인을 설치할 클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.


1. [지시사항](cs_integrations.html#helm)에 따라 로컬 머신에 Helm 클라이언트를 설치하고 클러스터에 Helm 서버(Tiller)를 설치한 후에 {{site.data.keyword.Bluemix_notm}} Helm 차트 저장소를 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인이 사용될 클러스터에 추가하십시오.

   **중요:** Helm 버전 2.9 이상을 사용 중이면 [서비스 계정](cs_integrations.html#helm)으로 Tiller를 설치했는지 확인하십시오.


2. Helm 저장소를 업데이트하여 이 저장소에 있는 모든 Helm 차트의 최신 버전을 검색하십시오.
   ```
   helm repo update
   ```
   {: pre}

3. {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인을 설치하십시오. 플러그인을 설치하면 사전 정의된 블록 스토리지 클래스가 클러스터에 추가됩니다.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   출력 예:
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. 설치가 완료되었는지 확인하십시오.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   출력 예:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   하나의 `ibmcloud-block-storage-plugin` 팟(Pod)과 하나 이상의 `ibmcloud-block-storage-driver` 팟(Pod)이 표시되면 설치에 성공한 것입니다. 
`ibmcloud-block-storage-driver` 팟(Pod)의 수는 클러스터에 있는 작업자 노드의 수와 동일합니다. 모든 팟(Pod)이 **실행 중(Running)** 상태여야 합니다.

5. 블록 스토리지를 위한 스토리지 클래스가 클러스터에 추가되었는지 확인하십시오.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   출력 예:
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. 블록 스토리지를 프로비저닝할 모든 클러스터에 대해 이러한 단계를 반복하십시오.

이제 앱을 위한 블록 스토리지를 프로비저닝하는 데 필요한 [PVC의 작성](#add_block)을 진행할 수 있습니다.


### {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인 업데이트
기존 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인을 최신 버전으로 업그레이드할 수 있습니다.
{: shortdesc}

시작하기 전에 클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

1. Helm 저장소를 업데이트하여 이 저장소에 있는 모든 Helm 차트의 최신 버전을 검색하십시오.
   ```
   helm repo update
   ```
   {: pre}

2. 선택사항: 최신 Helm 차트를 로컬 머신에 다운로드하십시오. 그리고 패키지를 압축 해제하고 `release.md` 파일을 검토하여 최신 릴리스 정보를 찾으십시오.
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. 클러스터에 설치한 블록 스토리지 Helm 차트의 이름을 찾으십시오.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   출력 예:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인을 최신 버전으로 업그레이드하십시오.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. 선택사항: 플러그인을 업데이트하면 `default` 스토리지 클래스가 설정 해제됩니다. 기본 스토리지 클래스를 자체 선정한 스토리지 클래스로 설정하려면 다음 명령을 실행하십시오.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인 제거
클러스터에서 {{site.data.keyword.Bluemix_notm}} Block Storage의 프로비저닝과 사용을 원하지 않으면 Helm 차트를 설치 제거할 수 있습니다.
{: shortdesc}

**참고:** 이 플러그인을 제거해도 기존 PVC, PV 또는 데이터는 제거되지 않습니다. 플러그인을 제거할 때는 모든 관련 팟(Pod) 및 디먼 세트만 클러스터에서 제거됩니다. 플러그인을 제거한 후에는 클러스터에 대해 새 블록 스토리지를 프로비저닝하거나, 기존 블록 스토리지 PVC 및 PV를 사용할 수 없습니다.

시작하기 전에:
- 클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.
- 블록 스토리지를 사용하는 클러스터에 PVC 또는 PV가 없는지 확인하십시오.

플러그인을 제거하려면 다음을 수행하십시오.

1. 클러스터에 설치한 블록 스토리지 Helm 차트의 이름을 찾으십시오.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   출력 예:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인을 삭제하십시오.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. 블록 스토리지 팟(Pod)이 제거되었는지 확인하십시오.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   CLI 출력에 팟(Pod)이 표시되지 않으면 팟(Pod) 제거가 성공한 것입니다.

4. 블록 스토리지 스토리지 클래스가 제거되었는지 확인하십시오.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   CLI 출력에 스토리지 클래스가 표시되지 않으면 스토리지 클래스 제거가 성공한 것입니다.

<br />



## 블록 스토리지 구성 결정
{: #predefined_storageclass}

{{site.data.keyword.containerlong}}는 특정 구성으로 블록 스토리지를 프로비저닝하는 데 사용할 수 있는 블록 스토리지의 사전 정의된 스토리지 클래스를 제공합니다.
{: shortdesc}

모든 스토리지 클래스는 사용 가능한 크기, IOPS, 파일 시스템 및 보유 정책을 포함하여 사용자가 프로비저닝하는 블록 스토리지의 유형을 지정합니다.  

**중요:** 데이터를 저장할 만한 충분한 용량을 보유하도록 반드시 스토리지 구성을 신중하게 선택하십시오. 스토리지 클래스를 사용하여 특정 유형의 스토리지를 프로비저닝한 후에는 스토리지 디바이스에 대한 크기, 유형, IOPS 또는 보유 정책을 변경할 수 없습니다. 추가적인 스토리지나 다른 구성의 스토리지가 필요하면 [새 스토리지 인스턴스를 작성하고 이전 스토리지 인스턴스의 데이터를 새 스토리지 인스턴스로 복사](cs_storage_basics.html#update_storageclass)해야 합니다.

1. {{site.data.keyword.containerlong}}에서 사용 가능한 스토리지 클래스를 나열하십시오.
    ```
    kubectl get storageclasses | grep block
    ```
    {: pre}

    출력 예:
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

2. 스토리지 클래스의 구성을 검토하십시오.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   각 스토리지 클래스에 대한 자세한 정보는 [스토리지 클래스 참조](#storageclass_reference)를 참조하십시오. 원하는 항목을 찾지 못한 경우에는 사용자 정의된 스토리지 클래스의 작성을 고려하십시오. 시작하려면 [사용자 정의된 스토리지 클래스 샘플](#custom_storageclass)을 체크아웃하십시오.
   {: tip}

3. 프로비저닝하고자 하는 블록 스토리지의 유형을 선택하십시오.
   - **브론즈, 실버 및 골드 스토리지 클래스:** 이 스토리지 클래스는 [Endurance 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/endurance-storage)를 프로비저닝합니다. Endurance 스토리지를 사용하면 사전 정의된 IOPS 티어에서 기가바이트 단위로 스토리지의 크기를 선택할 수 있습니다.
   - **사용자 정의 스토리지 클래스:** 이 스토리지 클래스는 [성능 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/performance-storage)를 프로비저닝합니다. 성능 스토리지를 사용하면 IOPS 및 스토리지의 크기에 대한 추가적인 제어가 가능합니다.

4. 블록 스토리지의 크기와 IOPS를 선택하십시오. IOPS의 크기와 수는 스토리지의 속도에 대한 지표의 역할을 하는 IOPS(Input/output Operations Per Second) 수의 총계를 정의합니다. 스토리지에 총 IOPS가 많을 수록 읽기/쓰기 오퍼레이션의 처리 속도가 빨라집니다.
   - **브론즈, 실버 및 골드 스토리지 클래스:** 이 스토리지 클래스는 기가바이트당 고정된 수의 IOPS가 제공되며 SSD 하드 디스크에 프로비저닝됩니다. IOPS 수의 총계는 선택하는 스토리지의 크기에 따라 다릅니다. 허용된 크기 범위 내에서 GB 단위의 정수를 선택할 수 있습니다(예: 20Gi, 256Gi 또는 11854Gi). IOPS 수의 총계를 판별하려면 IOPS를 선택된 크기와 곱해야 합니다. 예를 들어, GB당 4 IOPS가 제공되는 실버 스토리지 클래스에서 1000Gi 블록 스토리지 크기를 선택하는 경우에는 스토리지에 총 4000 IOPS가 있습니다.  
     <table>
         <caption>스토리지 클래스 크기 범위 및 GB당 IOPS의 표</caption>
         <thead>
         <th>스토리지 클래스</th>
         <th>GB당 IOPS</th>
         <th>크기 범위(GB)</th>
         </thead>
         <tbody>
         <tr>
         <td>브론즈</td>
         <td>2IOPS/GB</td>
         <td>20 - 12000Gi</td>
         </tr>
         <tr>
         <td>실버</td>
         <td>4IOPS/GB</td>
         <td>20 - 12000Gi</td>
         </tr>
         <tr>
         <td>골드</td>
         <td>10 IOPS/GB</td>
         <td>20 - 4000Gi</td>
         </tr>
         </tbody></table>
   - **사용자 정의 스토리지 클래스:** 이 스토리지 클래스를 선택하면 원하는 IOPS와 크기에 대해 추가적인 제어가 가능합니다. 크기의 경우, 허용된 크기 범위 내에서 GB 단위의 정수를 선택할 수 있습니다. 사용자가 선택하는 크기에 따라 사용 가능한 IOPS 범위가 결정됩니다. 지정된 범위 내에 있는 100의 배수인 IOPS를 선택할 수 있습니다. 선택하는 IOPS는 정적이며 스토리지의 크기에 따라 스케일링되지 않습니다. 예를 들어, 100 IOPS와 함께 40Gi를 선택하면 총 IOPS는 100을 유지합니다. </br></br>IOPS 대 기가바이트 비율은 사용자를 위해 프로비저닝되는 하드 디스크의 유형도 결정합니다. 예를 들어, 100 IOPS의 500Gi를 보유 중이면 IOPS 대 기가바이트 비율은 0.2입니다. 비율이 0.3 이하인 스토리지는 SATA 하드 디스크에서 프로비저닝됩니다. 비율이 0.3을 초과하는 스토리지는 SSD 하드 디스크에서 프로비저닝됩니다.
     <table>
         <caption>스토리지 클래스 크기 범위 및 IOPS의 표</caption>
         <thead>
         <th>크기 범위(GB)</th>
         <th>100의 배수로 된 IOPS 범위</th>
         </thead>
         <tbody>
         <tr>
         <td>20 - 39Gi</td>
         <td>100 - 1000IOPS</td>
         </tr>
         <tr>
         <td>40 - 79Gi</td>
         <td>100 - 2000IOPS</td>
         </tr>
         <tr>
         <td>80 - 99Gi</td>
         <td>100 - 4000IOPS</td>
         </tr>
         <tr>
         <td>100 - 499Gi</td>
         <td>100 - 6000IOPS</td>
         </tr>
         <tr>
         <td>500 - 999Gi</td>
         <td>100 - 10000IOPS</td>
         </tr>
         <tr>
         <td>1000 - 1999Gi</td>
         <td>100 - 20000IOPS</td>
         </tr>
         <tr>
         <td>2000 - 2999Gi</td>
         <td>200 - 40000IOPS</td>
         </tr>
         <tr>
         <td>3000 - 3999Gi</td>
         <td>200 - 48000IOPS</td>
         </tr>
         <tr>
         <td>4000 - 7999Gi</td>
         <td>300 - 48000IOPS</td>
         </tr>
         <tr>
         <td>8000 - 9999Gi</td>
         <td>500 - 48000IOPS</td>
         </tr>
         <tr>
         <td>10000 - 12000Gi</td>
         <td>1000 - 48000IOPS</td>
         </tr>
         </tbody></table>

5. 클러스터 또는 지속적 볼륨 클레임(PVC)이 삭제된 후에 데이터를 보존하고자 하는지를 선택하십시오.
   - 데이터를 보존하려면 `retain` 스토리지 클래스를 선택하십시오. PVC를 삭제하면 PVC만 삭제됩니다. PV, IBM Cloud 인프라(SoftLayer) 계정의 실제 스토리지 디바이스 및 데이터는 여전히 존재합니다. 스토리지를 재확보하고 이를 클러스터에서 다시 사용하려면 PV를 제거하고 [기존 블록 스토리지 사용](#existing_block)의 단계를 따라야 합니다.
   - PVC를 삭제할 때 PV, 데이터 및 실제 블록 스토리지 디바이스가 삭제되도록 하려면 `retain` 없이 스토리지 클래스를 선택하십시오.

6. 시간별 또는 월별로 청구되기를 원하는지 선택하십시오. 자세한 정보는 [가격 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)을 확인하십시오. 기본적으로, 모든 블록 스토리지 디바이스는 시간별 비용 청구 유형으로 프로비저닝됩니다.

<br />



## 앱에 블록 스토리지 추가
{: #add_block}

지속적 볼륨 클레임(PVC)을 작성하여 클러스터에 대한 블록 스토리지를 [동적으로 프로비저닝](cs_storage_basics.html#dynamic_provisioning)할 수 있습니다. 동적 프로비저닝은 일치하는 지속적 볼륨(PV)을 자동으로 작성하고 IBM Cloud 인프라(SoftLayer) 계정에서 실제 스토리지 디바이스를 주문합니다.
{:shortdesc}

**중요**: 블록 스토리지는 `ReadWriteOnce` 액세스 모드로 제공됩니다. 한 번에 클러스터에 있는 하나의 작업자 노드의 하나의 팟(Pod)에만 마운트할 수 있습니다.

시작하기 전에:
- 방화벽이 있는 경우에는 PVC를 작성할 수 있도록 클러스터가 있는 구역의 IBM Cloud 인프라(SoftLayer) IP 범위에 대해 [egress 액세스를 허용](cs_firewall.html#pvc)하십시오.
- [{{site.data.keyword.Bluemix_notm}} Block Storage 플러그인](#install_block)을 설치하십시오.
- [사전 정의된 스토리지 클래스를 결정](#predefined_storageclass)하거나 [사용자 정의된 스토리지 클래스](#custom_storageclass)를 작성하십시오.

블록 스토리지를 추가하려면 다음을 수행하십시오.

1.  지속적 볼륨 클레임(PVC)을 정의하는 구성 파일을 작성하고 이 구성을 `.yaml` 파일로 저장하십시오.

    -  **브론즈, 실버, 골드 스토리지 클래스의 예**:
       다음의 `.yaml` 파일은 `"ibmc-block-silver"` 스토리지 클래스의 이름이 `mypvc`이고 `"hourly"`로 청구되며 GB 크기가 `24Gi`인 클레임을 작성합니다.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **사용자 정의 스토리지 클래스 사용의 예**:
       다음의 `.yaml` 파일은 스토리지 클래스 `ibmc-block-retain-custom`의 이름이 `mypvc`이고 `"hourly"`로 청구되며 GB 크기가 `45Gi`이고 IOPS가 `"300"`인 클레임을 작성합니다.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 45Gi
             iops: "300"
        ```
        {: codeblock}

        <table>
        <caption>YAML 파일 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>PVC의 이름을 입력하십시오.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>블록 스토리지를 프로비저닝하는 데 사용할 스토리지 클래스의 이름입니다. </br> 스토리지 클래스를 지정하지 않으면 기본 스토리지 클래스 <code>ibmc-file-bronze</code>로 PV가 작성됩니다.<p>**팁:** 기본 스토리지 클래스를 변경하려면 <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code>를 실행하고 <code>&lt;storageclass&gt;</code>를 스토리지 클래스의 이름으로 대체하십시오.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>스토리지 요금이 계산되는 빈도를 "월별" 또는 "시간별"로 지정하십시오. 기본값은 "시간별"입니다.</td>
        </tr>
	<tr>
	<td><code>metadata/labels/region</code></td>
        <td>블록 스토리지를 프로비저닝할 지역을 지정하십시오. 지역을 지정하는 경우에는 구역도 지정해야 합니다. 지역을 지정하지 않거나 지정된 지역을 찾을 수 없는 경우, 스토리지는 클러스터와 동일한 지역에 작성됩니다. </br><strong>참고:</strong> 이 옵션은 IBM Cloud Block Storage 플러그인 버전 1.0.1 이상에서만 지원됩니다. 이전 플러그인 버전의 경우, 다중 구역 클러스터를 보유 중이면 모든 구역 간에 볼륨 요청의 균등한 밸런스를 유지하기 위해 스토리지가 프로비저닝되는 구역이 라운드 로빈 기반으로 선택됩니다. 스토리지에 대한 구역을 지정하려면 우선 [사용자 정의된 스토리지 클래스](#multizone_yaml)를 작성하십시오. 그리고 사용자 정의된 스토리지 클래스로 PVC를 작성하십시오.</td>
	</tr>
	<tr>
	<td><code>metadata/labels/zone</code></td>
	<td>블록 스토리지를 프로비저닝할 구역을 지정하십시오. 구역을 지정하는 경우에는 지역도 지정해야 합니다. 구역을 지정하지 않거나 지정된 구역을 다중 구역 클러스터에서 찾을 수 없으면 구역이 라운드 로빈 기반으로 선택됩니다. </br><strong>참고:</strong> 이 옵션은 IBM Cloud Block Storage 플러그인 버전 1.0.1 이상에서만 지원됩니다. 이전 플러그인 버전의 경우, 다중 구역 클러스터를 보유 중이면 모든 구역 간에 볼륨 요청의 균등한 밸런스를 유지하기 위해 스토리지가 프로비저닝되는 구역이 라운드 로빈 기반으로 선택됩니다. 스토리지에 대한 구역을 지정하려면 우선 [사용자 정의된 스토리지 클래스](#multizone_yaml)를 작성하십시오. 그리고 사용자 정의된 스토리지 클래스로 PVC를 작성하십시오.</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>블록 스토리지의 크기를 GB(Gi) 단위로 입력하십시오. </br></br><strong>참고</strong>: 스토리지가 프로비저닝된 후에는 블록 스토리지의 크기를 변경할 수 없습니다. 저장할 데이터의 크기와 일치하도록 크기를 지정해야 합니다. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>이 옵션은 사용자 정의 스토리지 클래스(`ibmc-block-custom / ibmc-block-retain-custom`)에만 사용 가능합니다. 허용 가능한 범위 내에서 100의 배수를 선택하여 스토리지에 대한 총 IOPS를 지정하십시오. 나열된 것과 이외의 IOPS를 선택하면 IOPS가 올림됩니다.</td>
        </tr>
        </tbody></table>

    사용자 정의된 스토리지 클래스를 사용하려면 해당 스토리지 클래스 이름, 올바른 IOPS 및 크기를 사용하여 PVC를 작성하십시오.   
    {: tip}

2.  PVC를 작성하십시오.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  PVC가 작성되고 PV에 바인딩되는지 확인하십시오. 이 프로세스에는 몇 분 정도 소요될 수 있습니다.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    출력 예:

    ```
    Name:		mypvc
    Namespace:	default
    StorageClass:	""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-block", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}PV를 배치에 마운트하려면 구성 `.yaml` 파일을 작성하고 PV를 바인드하는 PVC를 지정하십시오.

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>배치의 레이블입니다.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>앱의 레이블입니다.</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>배치의 레이블입니다.</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>사용하려는 이미지의 이름입니다. {{site.data.keyword.registryshort_notm}} 계정에서 사용 가능한 이미지를 나열하려면 `ibmcloud cr image-list`를 실행하십시오.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>클러스터에 배치하려는 컨테이너의 이름입니다.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>컨테이너 내에서 볼륨이 마운트되는 디렉토리의 절대 경로입니다. 마운트 경로에 쓰여진 데이터는 실제 파일 스토리지 인스턴스의 루트 디렉토리 아래에 저장됩니다. 실제 파일 스토리지 인스턴스의 디렉토리를 작성하려면 마운트 경로의 서브디렉토리를 작성해야 합니다. </td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>팟(Pod)에 마운트할 볼륨의 이름입니다.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>팟(Pod)에 마운트할 볼륨의 이름입니다. 일반적으로 이 이름은 <code>volumeMounts/name</code>과 동일합니다.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>사용하려는 PV를 바인드하는 PVC의 이름입니다. </td>
    </tr>
    </tbody></table>

5.  배치를 작성하십시오.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  PV가 성공적으로 마운트되었는지 확인하십시오.

     ```
     kubectl describe deployment <deployment_name>
     ```
     {: pre}

     마운트 지점은 **Volume Mounts** 필드에 있고 볼륨은 **Volumes** 필드에 있습니다.

     ```
      Volume Mounts:
           /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
           /volumemount from myvol (rw)
     ...
     Volumes:
       myvol:
         Type:	PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
         ClaimName:	mypvc
         ReadOnly:	false
     ```
     {: screen}

<br />




## 클러스터의 기존 블록 스토리지 사용
{: #existing_block}

클러스터에서 사용할 기존의 실제 스토리지 디바이스가 있는 경우, 스토리지를 [정적으로 프로비저닝](cs_storage_basics.html#static_provisioning)하기 위해 PV 및 PVC를 수동으로 작성할 수 있습니다.

기존 스토리지를 앱에 마운트하려면 우선 PV에 대한 모든 필수 정보를 검색해야 합니다.  
{: shortdesc}

### 1단계: 기존 블록 스토리지의 정보 검색

1.  IBM Cloud 인프라(SoftLayer) 계정의 API 키를 검색하거나 생성하십시오.
    1. [IBM Cloud 인프라(SoftLayer) 포털 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://control.bluemix.net/)에 로그인하십시오.
    2. **계정**을 선택한 후 **사용자**, **사용자 목록**을 선택하십시오.
    3. 자신의 사용자 ID를 찾으십시오.
    4. **API 키** 열에서 **생성**을 클릭하여 API 키를 생성하거나 **보기**를 클릭하여 기존 API 키를 보십시오.
2.  IBM Cloud 인프라(SoftLayer) 계정의 API 사용자 이름을 검색하십시오.
    1. **사용자 목록** 메뉴에서 자신의 사용자 ID를 선택하십시오.
    2. **API 액세스 정보** 섹션에서 **API 사용자 이름**을 찾으십시오.
3.  IBM Cloud 인프라 CLI 플러그인에 로그인하십시오.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  IBM Cloud 인프라(SoftLayer) 계정의 사용자 이름 및 API 키를 사용하여 인증하도록 선택하십시오.
5.  이전 단계에서 검색한 사용자 이름 및 API 키를 입력하십시오.
6.  사용 가능한 블록 스토리지 디바이스를 나열하십시오.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    출력 예:
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  클러스터에 마운트할 블록 스토리지 디바이스의 `id`, `ip_addr`, `capacity_gb`, `datacenter` 및 `lunId`를 기록해 두십시오. **참고:** 클러스터에 기존 스토리지를 마운트하려면 스토리지와 동일한 구역에 작업자 노드가 있어야 합니다. 작업자 노드의 구역을 확인하려면 `ibmcloud ks workers <cluster_name_or_ID>`를 실행하십시오.

### 2단계: 지속적 볼륨(PV) 및 일치하는 지속적 볼륨 클레임(PVC) 작성

1.  선택사항: `retain` 스토리지 클래스로 프로비저닝한 스토리지가 있으면 PVC를 제거할 때 PV 및 실제 스토리지 디바이스가 제거되지 않습니다. 클러스터의 스토리지를 재사용하려면 우선 PV를 제거해야 합니다.
    1. 기존 PV를 나열하십시오.
       ```
       kubectl get pv
       ```
       {: pre}

       지속적 스토리지에 속하는 PV를 찾으십시오. PV는 `released` 상태입니다.

    2. PV를 제거하십시오.
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}

    3. PV가 제거되었는지 확인하십시오.
       ```
       kubectl get pv
       ```
       {: pre}

2.  PV에 대한 구성 파일을 작성하십시오. 이전에 검색한 블록 스토리지 `id`, `ip_addr`, `capacity_gb`, `datacenter` 및 `lunIdID`를 포함하십시오.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region: <region>
         failure-domain.beta.kubernetes.io/zone: <zone>
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
      ```
      {: codeblock}

    <table>
    <caption>YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>작성할 PV의 이름을 입력하십시오.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>이전에 검색한 지역 및 구역을 입력하십시오. 클러스터에서 스토리지를 마운트하려면 지속적 스토리지와 동일한 지역 및 구역에 작업자 노드가 최소한 하나 이상 있어야 합니다. 스토리지에 대한 PV가 이미 존재하는 경우에는 PV에 [구역 및 지역 레이블을 추가](cs_storage_basics.html#multizone)하십시오.
    </tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>기존 블록 스토리지에 대해 구성된 파일 시스템 유형을 입력하십시오. <code>ext4</code> 또는 <code>xfs</code> 중에서 선택하십시오. 이 옵션을 지정하지 않으면 기본적으로 PV가 <code>ext4</code>로 설정됩니다. 잘못된 fsType이 정의된 경우 PV 작성에 성공하지만 PV를 팟(Pod)에 마운트하는 데 실패합니다. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>이전 단계에서 <code>capacity-gb</code>로 검색한 기존 블록 스토리지의 스토리지 크기를 입력하십시오. 이 스토리지 크기는 기가바이트 단위로 기록해야 합니다(예: 20Gi(20GB) 또는 1000Gi(1TB)).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td><code>lunId</code>로서 이전에 검색한 블록 스토리지의 LUN ID를 입력하십시오.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td><code>ip_addr</code>로서 이전에 검색한 블록 스토리지의 IP 주소를 입력하십시오. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td><code>id</code>로서 이전에 검색한 블록 스토리지의 ID를 입력하십시오.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>볼륨 이름을 입력하십시오.</td>
	    </tr>
    </tbody></table>

3.  클러스터에 PV를 작성하십시오.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. PV가 작성되었는지 확인하십시오.
    ```
    kubectl get pv
    ```
    {: pre}

5. 다른 구성 파일을 작성하여 PVC를 작성하십시오. PVC가 이전에 작성한 PV와 일치하려면 `storage` 및 `accessMode`에 대해 동일한 값을 선택해야 합니다. `storage-class` 필드는 비어 있어야 합니다. 이러한 필드 중에 PV와 일치하지 않는 것이 있는 경우에는 대신 새 PV가 자동으로 작성됩니다.

     ```
     kind: PersistentVolumeClaim
     apiVersion: v1
     metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: ""
     spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "<storage_size>"
     ```
     {: codeblock}

6.  PVC 사용자를 작성하십시오.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  PVC가 작성되어 이전에 작성한 PV에 바인딩되었는지 확인하십시오. 이 프로세스에는 몇 분 정도 소요될 수 있습니다.
     ```
     kubectl describe pvc mypvc
     ```
     {: pre}

     출력 예:

     ```
     Name: mypvc
     Namespace: default
     StorageClass:	""
     Status: Bound
     Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     Labels: <none>
     Capacity: 20Gi
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

PV를 작성하여 PVC에 바인딩했습니다. 이제 클러스터 사용자는 자신의 배치에 [PVC를 마운트](#app_volume_mount)하고 PV에서 읽기 또는 쓰기를 시작할 수 있습니다.

<br />



## 데이터 백업 및 복원
{: #backup_restore}

블록 스토리지는 클러스터의 작업자 노드와 동일한 위치로 프로비저닝됩니다. 이 스토리지는 서버의 작동이 중지되는 경우에 가용성을 제공하기 위해 IBM에 의해 클러스터된 서버에서 호스팅됩니다. 그러나 블록 스토리지는 자동으로 백업되지 않으며 전체 위치에서 장애가 발생하면 액세스가 불가능할 수 있습니다. 데이터가 유실되거나 손상되지 않도록 하기 위해, 필요한 경우 데이터를 복원하는 데 사용할 수 있는 주기적 백업을 설정할 수 있습니다.

백업 스토리지에 대한 다음의 백업 및 복원 옵션을 검토하십시오.

<dl>
  <dt>주기적 스냅샷 설정</dt>
  <dd><p>특정 시점에 인스턴스 상태를 캡처하는 읽기 전용 이미지인 [블록 스토리지에 대한 주기적 스냅샷을 설정](/docs/infrastructure/BlockStorage/snapshots.html#snapshots)할 수 있습니다. 스냅샷을 저장하려면 블록 스토리지의 스냅샷 영역을 요청해야 합니다. 스냅샷은 동일한 구역 내의 기본 스토리지 인스턴스에 저장됩니다. 사용자가 실수로 볼륨에서 중요한 데이터를 제거한 경우 스냅샷에서 데이터를 복원할 수 있습니다. <strong>참고</strong>: Dedicated 계정이 있는 경우에는 <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">지원 티켓을 열어야</a> 합니다. </br></br> <strong>볼륨에 대한 스냅샷을 작성하려면 다음을 수행하십시오. </strong><ol><li>클러스터에 있는 기존 PV를 나열하십시오. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>스냅샷 영역을 작성할 PV에 대한 세부사항을 가져오고 볼륨 ID, 크기 및 IOPS를 기록해 두십시오. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> 크기 및 IOPS는 CLI 출력의 <strong>레이블</strong> 섹션에 표시됩니다. 볼륨 ID을 찾으려면 CLI 출력의 <code>ibm.io/network-storage-id</code> 어노테이션을 검토하십시오. </li><li>이전 단계에서 검색한 매개변수를 사용하여 기존 볼륨의 스냅샷 크기를 작성하십시오. <pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>스냅샷 크기가 작성될 때까지 기다리십시오. <pre class="pre">대표전화서비스: 02-3781-7114
<code>slcli block volume-detail &lt;volume_id&gt;</code></pre>CLI 출력의 <strong>Snapshot Capacity (GB)</strong>가 0에서 주문한 크기로 변경된 경우 스냅샷 크기가 성공적으로 프로비저닝된 것입니다. </li><li>볼륨에 대한 스냅샷을 작성하고 작성된 스냅샷의 ID를 기록해 두십시오. <pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>스냅샷이 작성되었는지 확인하십시오. <pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>스냅샷의 데이터를 기본 볼륨에 복원하려면 다음을 수행하십시오. </strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>다른 구역으로 스냅샷 복제</dt>
 <dd><p>구역 장애로부터 데이터를 보호하기 위해 다른 구역에서 설정된 블록 스토리지 인스턴스로 [스냅샷을 복제](/docs/infrastructure/BlockStorage/replication.html#replicating-data)할 수 있습니다. 데이터는 기본 스토리지에서 백업 스토리지로만 복제할 수 있습니다. 복제된 블록 스토리지 인스턴스를 클러스터에 마운트할 수는 없습니다. 기본 스토리지에서 장애가 발생하는 경우에는 복제된 백업 스토리지가 기본 스토리지가 되도록 수동으로 설정할 수 있습니다. 그런 다음 클러스터에 이를 추가할 수 있습니다. 기본 스토리지가 복원되고 나면 백업 스토리지로부터 데이터를 복원할 수 있습니다. <strong>참고</strong>: Dedicated 계정이 있는 경우에는 스냅샷을 다른 구역으로 복제할 수 없습니다. </p></dd>
 <dt>스토리지 복제(duplicate)</dt>
 <dd><p>원본 스토리지 인스턴스와 동일한 구역에서 [블록 스토리지 인스턴스를 복제](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume)할 수 있습니다. 복제본(duplicate)에는 복제본(duplicate)을 작성한 시점의 원본 스토리지 인스턴스와 동일한 데이터가 저장되어 있습니다. 복제본(replica)과 다르게 복제본(duplicate)은 원본과 별개인 스토리지 인스턴스로 사용하십시오. 복제(duplicate)하려면 먼저 볼륨의 스냅샷을 설정하십시오. <strong>참고</strong>: Dedicated 계정이 있는 경우에는 <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">지원 티켓을 열어야</a> 합니다. </p></dd>
  <dt>{{site.data.keyword.cos_full}}로 데이터 백업</dt>
  <dd><p>[**ibm-backup-restore 이미지**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter)를 사용하여 클러스터에서 백업을 회전하고 팟(Pod)을 복원할 수 있습니다. 이 팟(Pod)에는 클러스터의 지속적 볼륨 클레임(PVC)에 대한 일회성 또는 주기적 백업을 실행하는 스크립트가 포함되어 있습니다. 데이터는 구역에 설정된 {{site.data.keyword.cos_full}} 인스턴스에 저장됩니다.</p><strong>참고:</strong> 블록 스토리지는 RWO 액세스 모드로 마운트됩니다. 이 액세스를 사용하면 한 번에 하나의 팟(Pod)만 블록 스토리지에 마운트할 수 있습니다. 데이터를 백업하려면 스토리지에서 앱 팟(Pod)을 마운트 해제하고 이를 백업 팟(Pod)에 마운트한 후에 데이터를 백업하고 스토리지를 앱 팟(Pod)에 다시 마운트해야 합니다. </br></br>
데이터의 고가용성을 개선하고 구역 장애로부터 앱을 보호하려면 두 번째 {{site.data.keyword.cos_short}} 인스턴스를 설정하고 구역 간에 데이터를 복제하십시오. {{site.data.keyword.cos_short}} 인스턴스에서 데이터를 복원해야 하는 경우 이미지와 함께 제공된 복원 스크립트를 사용하십시오.</dd>
<dt>팟(Pod) 및 컨테이너에서 데이터 복사</dt>
<dd><p>`kubectl cp` [명령 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/kubectl/overview/#cp)을 사용하여 클러스터의 팟(Pod) 또는 특정 컨테이너에서 파일 및 디렉토리를 복사할 수 있습니다.</p>
<p>시작하기 전에 사용할 클러스터에 [Kubernetes CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. <code>-c</code>를 사용하여 컨테이너를 지정하지 않는 경우 이 명령은 팟(Pod)의 사용 가능한 첫 번째 컨테이너를 사용합니다.</p>
<p>이 명령은 다양한 방식으로 사용할 수 있습니다.</p>
<ul>
<li>로컬 머신에서 클러스터의 팟(Pod)으로 데이터 복사: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>클러스터의 팟(Pod)에서 로컬 머신으로 데이터 복사: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>로컬 시스템의 데이터를 클러스터의 팟에서 실행되는 특정 컨테이너로 복사: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## 스토리지 클래스 참조
{: #storageclass_reference}

### 브론즈
{: #bronze}

<table>
<caption>블록 스토리지 클래스: 브론즈</caption>
<thead>
<th>특성</th>
<th>설정</th>
</thead>
<tbody>
<tr>
<td>이름</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>유형</td>
<td>[Endurance 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>파일 시스템</td>
<td>ext4</td>
</tr>
<tr>
<td>GB당 IOPS</td>
<td>2</td>
</tr>
<tr>
<td>크기 범위(GB)</td>
<td>20 - 12000Gi</td>
</tr>
<tr>
<td>하드 디스크</td>
<td>SSD</td>
</tr>
<tr>
<td>비용 청구</td>
<td>기본 비용 청구 유형은 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인의 버전에 따라 다릅니다. <ul><li> 버전 1.0.1 이상: 시간별</li><li>버전 1.0.0 이하: 월별</li></ul></td>
</tr>
<tr>
<td>가격</td>
<td>[가격 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### 실버
{: #silver}

<table>
<caption>블록 스토리지 클래스: 실버</caption>
<thead>
<th>특성</th>
<th>설정</th>
</thead>
<tbody>
<tr>
<td>이름</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>유형</td>
<td>[Endurance 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>파일 시스템</td>
<td>ext4</td>
</tr>
<tr>
<td>GB당 IOPS</td>
<td>4</td>
</tr>
<tr>
<td>크기 범위(GB)</td>
<td>20 - 12000Gi</td>
</tr>
<tr>
<td>하드 디스크</td>
<td>SSD</td>
</tr>
<tr>
<td>비용 청구</td>
<td>기본 비용 청구 유형은 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인의 버전에 따라 다릅니다. <ul><li> 버전 1.0.1 이상: 시간별</li><li>버전 1.0.0 이하: 월별</li></ul></td>
</tr>
<tr>
<td>가격</td>
<td>[가격 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### 골드
{: #gold}

<table>
<caption>블록 스토리지 클래스: 골드</caption>
<thead>
<th>특성</th>
<th>설정</th>
</thead>
<tbody>
<tr>
<td>이름</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>유형</td>
<td>[Endurance 스토리지 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>파일 시스템</td>
<td>ext4</td>
</tr>
<tr>
<td>GB당 IOPS</td>
<td>10</td>
</tr>
<tr>
<td>크기 범위(GB)</td>
<td>20 - 4000Gi</td>
</tr>
<tr>
<td>하드 디스크</td>
<td>SSD</td>
</tr>
<tr>
<td>비용 청구</td>
<td>기본 비용 청구 유형은 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인의 버전에 따라 다릅니다. <ul><li> 버전 1.0.1 이상: 시간별</li><li>버전 1.0.0 이하: 월별</li></ul></td>
</tr>
<tr>
<td>가격</td>
<td>[가격 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### 사용자 정의
{: #custom}

<table>
<caption>블록 스토리지 클래스: 사용자 정의</caption>
<thead>
<th>특성</th>
<th>설정</th>
</thead>
<tbody>
<tr>
<td>이름</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>유형</td>
<td>[성능 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>파일 시스템</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS 및 크기</td>
<td><strong>크기 범위(기가바이트) / IOPS 범위(100의 배수)</strong><ul><li>20-39Gi / 100-1000 IOPS</li><li>40-79Gi / 100-2000 IOPS</li><li>80-99Gi / 100-4000 IOPS</li><li>100-499Gi / 100-6000 IOPS</li><li>500-999Gi / 100-10000 IOPS</li><li>1000-1999Gi / 100-20000 IOPS</li><li>2000-2999Gi / 200-40000 IOPS</li><li>3000-3999Gi / 200-48000 IOPS</li><li>4000-7999Gi / 300-48000 IOPS</li><li>8000-9999Gi / 500-48000 IOPS</li><li>10000-12000Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>하드 디스크</td>
<td>IOPS 대 기가바이트 비율은 프로비저닝되는 하드 디스크의 유형을 결정합니다. IOPS 대 기가바이트 비율을 결정하려면 IOPS를 스토리지의 크기로 나누십시오. </br></br>예: </br>100 IOPS의 500Gi 스토리지를 선택합니다. 비율은 0.2(100 IOPS/500Gi)입니다. </br></br><strong>비율당 하드 디스크 유형의 개요:</strong><ul><li>0.3 이하: SATA</li><li>0.3 초과: SSD</li></ul></td>
</tr>
<tr>
<td>비용 청구</td>
<td>기본 비용 청구 유형은 {{site.data.keyword.Bluemix_notm}} Block Storage 플러그인의 버전에 따라 다릅니다. <ul><li> 버전 1.0.1 이상: 시간별</li><li>버전 1.0.0 이하: 월별</li></ul></td>
</tr>
<tr>
<td>가격</td>
<td>[가격 정보 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## 사용자 정의된 샘플 스토리지 클래스
{: #custom_storageclass}

### 다중 구역 클러스터에 대한 구역 지정
{: #multizone_yaml}

다음의 `.yaml` 파일은 `ibm-block-silver` 비-보유(non-retaining) 스토리지 클래스를 기반으로 하는 스토리지 클래스를 사용자 정의합니다. 여기서 `type`은 `"Endurance"`이고, `iopsPerGB`는 `4`이며, `sizeRange`는 `"[20-12000]Gi"`이고, `reclaimPolicy`는 `"Delete"`로 설정됩니다. 구역은 `dal12`로서 지정됩니다. `ibmc` 스토리지 클래스에 대한 이전 정보를 검토하면 이에 대해 허용되는 값을 선택하는 데 도움이 될 수 있습니다. </br>

다른 스토리지 클래스를 자신의 기반으로 사용하려면 [스토리지 클래스 참조](#storageclass_reference)를 참조하십시오.

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### `XFS` 파일 시스템에서 블록 스토리지 마운트
{: #xfs}

다음 예제에서는 `XFS` 파일 시스템에서 성능 블록 스토리지를 프로비저닝하는 `ibmc-block-custom-xfs`라는 이름의 스토리지 클래스를 작성합니다.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ibmc-block-custom-xfs
  labels:
    addonmanager.kubernetes.io/mode: Reconcile
provisioner: ibm.io/ibmc-block
parameters:
  type: "Performance"
  sizeIOPSRange: |-
    [20-39]Gi:[100-1000]
    [40-79]Gi:[100-2000]
    [80-99]Gi:[100-4000]
    [100-499]Gi:[100-6000]
    [500-999]Gi:[100-10000]
    [1000-1999]Gi:[100-20000]
    [2000-2999]Gi:[200-40000]
    [3000-3999]Gi:[200-48000]
    [4000-7999]Gi:[300-48000]
    [8000-9999]Gi:[500-48000]
    [10000-12000]Gi:[1000-48000]
  fsType: "xfs"
  reclaimPolicy: "Delete"
  classVersion: "2"
```
{: codeblock}

<br />

