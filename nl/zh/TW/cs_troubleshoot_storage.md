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


# 叢集儲存空間的疑難排解
{: #cs_troubleshoot_storage}

在您使用 {{site.data.keyword.containerlong}} 時，請考慮使用這些技術來進行叢集儲存空間的疑難排解。
{: shortdesc}

如果您有更一般性的問題，請嘗試[叢集除錯](/docs/containers?topic=containers-cs_troubleshoot)。
{: tip}

## 在多區域叢集裡，持續性磁區無法裝載至 Pod
{: #mz_pv_mount}

{: tsSymptoms}
您的叢集先前是單一區域叢集，而其獨立式工作者節點不在工作者節點儲存區中。您已順利裝載持續性磁區要求 (PVC)，其說明要用於應用程式 Pod 部署的持續性磁區 (PV)。現在，您具有工作者節點儲存區，並已將區域新增至叢集，不過，PV 無法裝載至 Pod。

{: tsCauses}
若為多區域叢集，PV 必須具有下列標籤，因此 Pod 不會嘗試裝載不同區域中的磁區。
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

依預設，其工作者節點儲存區可以跨越多個區域的新叢集會標示 PV。如果您在建立工作者節點儲存區之前建立叢集，則必須手動新增標籤。

{: tsResolve}
[使用地區及區域標籤更新叢集裡的 PV](/docs/containers?topic=containers-kube_concepts#storage_multizone)。

<br />


## 檔案儲存空間：工作者節點的檔案系統變更為唯讀
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
您可能會看到下列其中一個症狀：
- 當您執行 `kubectl get pods -o wide` 時，您會看到在同一個工作者節點上執行的多個位置停留在 `ContainerCreating` 狀況中。
- 當您執行 `kubectl describe` 指令時，會在 **Events** 區段中看到下列錯誤：`MountVolume.SetUp failed for volume ... read-only file system`。

{: tsCauses}
工作者節點上的檔案系統是唯讀的。

{: tsResolve}
1.  備份可能儲存在工作者節點或容器上的任何資料。
2.  若要對現有工作者節點進行短期修正，請重新載入工作者節點。<pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;cluster_name&gt; --worker &lt;worker_ID&gt;</code></pre>

如需長期修正，請[更新工作者節點儲存區的機型](/docs/containers?topic=containers-update#machine_type)。

<br />



## 檔案儲存空間：當非 root 使用者擁有 NFS 檔案儲存空間裝載路徑時，應用程式會失敗
{: #nonroot}

{: tsSymptoms}
[新增 NFS 儲存空間](/docs/containers?topic=containers-file_storage#app_volume_mount)至您的部署之後，您的容器部署失敗。當您擷取容器的日誌時，可能會看到如下錯誤。Pod 失敗，並停留在重新載入的循環中。

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
依預設，非 root 使用者對於支援 NFS 的儲存空間的磁區裝載路徑沒有寫入權。部分一般應用程式映像檔（例如 Jenkins 及 Nexus3）會在 Dockerfile 中指定擁有裝載路徑的非 root 使用者。當您從這個 Dockerfile 建立容器時，會由於非 root 使用者對裝載路徑的權限不足，而造成建立容器失敗。若要授與寫入權，您可以修改 Dockerfile，以在變更裝載路徑許可權之前，暫時將非 root 使用者新增至 root 使用者群組，或使用 init 容器。

如果您使用 Helm 圖表來部署映像檔，則請編輯 Helm 部署以使用 init 容器。
{:tip}



{: tsResolve}
當您在部署中包括 [init 容器 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) 時，可以授與 Dockerfile 中所指定的非 root 使用者對於容器內的磁區裝載路徑的寫入權。init 容器會在您的應用程式容器啟動之前啟動。init 容器會在容器內建立磁區裝載路徑，將裝載路徑變更為由正確的（非 root）使用者所擁有，然後關閉。然後，會使用必須寫入至裝載路徑的非 root 使用者來啟動您的應用程式容器。因為路徑已由非 root 使用者擁有，所以會成功寫入至裝載路徑。如果您不想要使用 init 容器，則可以修改 Dockerfile，以新增非 root 使用者對 NFS 檔案儲存空間的存取權。


開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  開啟應用程式的 Dockerfile，然後取得您要授與磁區裝載路徑寫入權的使用者的使用者 ID (UID) 及群組 ID (GID)。在 Jenkins Dockerfile 的範例中，其資訊如下：
    - UID：`1000`
    - GID：`1000`

    **範例**：

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

2.  藉由建立持續性磁區要求 (PVC)，將持續性儲存空間新增至應用程式。這個範例使用 `ibmc-file-bronze` 儲存空間類別。若要檢閱可用的儲存空間類別，請執行 `kubectl get storageclasses`。

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

3.  建立 PVC。

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  在您的部署 `.yaml` 檔案中，新增 init 容器。包括您先前擷取的 UID 及 GID。

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

    Jenkins 部署的**範例**：

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

5.  建立 Pod，並將 PVC 裝載至 Pod。

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. 驗證磁區已順利裝載至 Pod。請記下 Pod 名稱及 **Containers/Mounts** 路徑。

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **輸出範例**：

    ```
    Name:		    mypod-123456789
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
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    

    ```
    {: screen}

7.  使用您先前記下的 Pod 名稱來登入 Pod。

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. 驗證容器裝載路徑的許可權。在此範例中，裝載路徑為 `/var/jenkins_home`。

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **輸出範例**：

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    此輸出顯示 Dockerfile 中的 GID 及 UID（在此範例中是 `1000` 及 `1000`）擁有容器內的裝載路徑。

<br />


## 檔案儲存空間：新增非 root 使用者對持續性儲存空間的存取權失敗
{: #cs_storage_nonroot}

{: tsSymptoms}
在您[新增非 root 使用者對持續性儲存空間的存取權](#nonroot)之後，或在指定非 root 使用者 ID 的情況下部署 Helm 圖表之後，使用者無法寫入已裝載的儲存空間。

{: tsCauses}
部署或 Helm 圖表配置為 Pod 的 `fsGroup`（群組 ID）及 `runAsUser`（使用者 ID）指定[安全環境定義](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)。目前，{{site.data.keyword.containerlong_notm}} 不支援 `fsGroup` 規格，僅支援 `runAsUser` 設為 `0`（root 許可權）。

{: tsResolve}
請從映像檔、部署或 Helm 圖表配置檔中，移除 `fsGroup` 及 `runAsUser` 的配置的 `securityContext` 欄位，然後重新部署。如果您需要變更 `nobody` 的裝載路徑的所有權，請[新增非 root 使用者存取權](#nonroot)。在您新增[非 root `initContainer`](#nonroot) 之後，請在容器層次設定 `runAsUser`，而非 Pod 層次。

<br />




## 區塊儲存空間：區塊儲存空間變更為唯讀
{: #readonly_block}

{: tsSymptoms}
您可能會看到下列狀況：
- 當您執行 `kubectl get pods -o wide` 時，您會看到同一個工作者節點上有多個 Pod 停留在 `ContainerCreating` 或 `CrashLoopBackOff` 狀態中。這些 Pod 全部都使用相同的區塊儲存空間實例。
- 當您執行 `kubectl describe pod` 指令時，您會在**事件**區段中看到下列錯誤：`MountVolume.SetUp failed for volume ... read-only`。

{: tsCauses}
如果在 Pod 寫入磁區時發生網路錯誤，IBM Cloud 基礎架構 (SoftLayer) 會將磁區變更為唯讀模式，以保護磁區上的資料免於毀損。使用此磁區的 Pod 無法繼續寫入磁區，並發生失敗。

{: tsResolve}
1. 檢查叢集中已安裝的 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式版本。
   ```
   helm ls
   ```
   {: pre}

2. 驗證您使用[最新版本的 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式](https://cloud.ibm.com/containers-kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin)。如果不是，請[更新外掛程式](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in)。
3. 如果您的 Pod 使用 Kubernetes 部署，請移除失敗的 Pod 並讓 Kubernetes 重建它，以重新啟動該 Pod。如果您未使用部署，請執行下列指令以擷取用來建立 Pod 的 YAML 檔：`kubectl getpod <pod_name> -o yaml >pod.yaml`。然後，刪除並手動重建 Pod。
    ```
    kubectl delete pod <pod_name>
    ```
    {: pre}

4. 檢查重建 Pod 是否已解決問題。如果沒有，請重新載入工作者節點。
   1. 尋找 Pod 執行所在的工作者節點，並記下指派給工作者節點的專用 IP 位址。
      ```
      kubectl describe pod <pod_name> | grep Node
      ```
      {: pre}

      輸出範例：
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. 透過使用前一個步驟的專用 IP 位址，來擷取工作者節點的 **ID**。
      ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}

   3. 溫和地[重新載入工作者節點](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload)。


<br />


## 區塊儲存空間：將現有區塊儲存空間裝載至 Pod 失敗，因為檔案系統錯誤
{: #block_filesystem}

{: tsSymptoms}
當您執行 `kubectl describe pod <pod_name>` 時，會看到下列錯誤：
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
您的現有區塊儲存裝置已設定 `XFS` 檔案系統。若要將此裝置裝載至您的 Pod，您已[建立 PV](/docs/containers?topic=containers-block_storage#existing_block)，其將 `ext4` 指定為檔案系統或 `spec/flexVolume/fsType` 區段中未指定檔案系統。如果未定義任何檔案系統，則 PV 預設為 `ext4`。PV 已順利建立並鏈結至現有區塊儲存空間實例。不過，當您嘗試使用相符的 PVC 將 PV 裝載到叢集時，會無法裝載磁區。您無法將具有 `ext4` 檔案系統的 `XFS` 區塊儲存空間實例裝載到 Pod。

{: tsResolve}
將現有 PV 中的檔案系統從 `ext4` 更新至 `XFS`。

1. 列出叢集裡的現有 PV，並記下用於現有區塊儲存空間實例的 PV 名稱。
   ```
   kubectl get pv
   ```
   {: pre}

2. 將 PV YAML 儲存在您的本端機器上。
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. 開啟 YAML 檔案，並將 `fsType` 從 `ext4` 變更為 `xfs`。
4. 取代叢集裡的 PV。
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. 登入已裝載 PV 的 Pod。
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. 驗證檔案系統已變更為 `XFS`。
   ```
   df -Th
   ```
   {: pre}

   輸出範例：
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## 物件儲存空間：安裝 {{site.data.keyword.cos_full_notm}} `ibmc` Helm 外掛程式失敗
{: #cos_helm_fails}

{: tsSymptoms}
當您安裝 {{site.data.keyword.cos_full_notm}} `ibmc` Helm 外掛程式時，安裝失敗，錯誤如下：
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
安裝 `ibmc` Helm 外掛程式時，會建立從 `./helm/plugins/helm-ibmc` 目錄到本端系統上 `ibmc` Helm 外掛程式所在目錄（通常在 `./ibmcloud-object-storage-plugin/helm-ibmc` 中）的符號鏈結。當您從本端系統移除 `ibmc` Helm 外掛程式時，或將 `ibmc` Helm 外掛程式目錄移至不同的位置時，不會移除符號鏈結。

{: tsResolve}
1. 移除 {{site.data.keyword.cos_full_notm}} Helm 外掛程式。
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. [安裝 {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-object_storage#install_cos)。

<br />


## 物件儲存空間：因為找不到 Kubernetes 密碼，所以無法建立 PVC 或 Pod
{: #cos_secret_access_fails}

{: tsSymptoms}
當您建立 PVC 或部署可裝載 PVC 的 Pod 時，建立或部署會失敗。

- PVC 建立失敗的錯誤訊息範例：
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- Pod 建立失敗的錯誤訊息範例：
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}

{: tsCauses}
儲存 {{site.data.keyword.cos_full_notm}} 服務認證的 Kubernetes 的密碼、PVC 及 Pod 不是都在相同的 Kubernetes 名稱空間中。將密碼部署至與 PVC 或 Pod 不同的名稱空間時，無法存取密碼。

{: tsResolve}
此作業需要所有名稱空間的[**撰寫者**或**管理員** {{site.data.keyword.Bluemix_notm}} IAM 服務角色](/docs/containers?topic=containers-users#platform)。

1. 列出叢集裡的密碼，並檢閱已建立 {{site.data.keyword.cos_full_notm}} 服務實例之 Kubernetes 密碼的 Kubernetes 名稱空間。密碼必須將 `ibm/ibmc-s3fs` 顯示為**類型**。
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. 檢查 PVC 及 Pod 的 YAML 配置檔，驗證您已使用相同的名稱空間。如果您要將 Pod 部署至非密碼所在的名稱空間中，則請在該名稱空間中[建立另一個密碼](/docs/containers?topic=containers-object_storage#create_cos_secret)。

3. 在適當的名稱空間中建立 PVC 或部署 Pod。

<br />


## 物件儲存空間：PVC 建立失敗，因為認證錯誤或拒絕存取
{: #cred_failure}

{: tsSymptoms}
當您建立 PVC 時，會看到與下列其中一則類似的錯誤訊息：

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
您用來存取服務實例的 {{site.data.keyword.cos_full_notm}} 服務認證可能錯誤，或只容許對儲存區進行讀取。

{: tsResolve}
1. 在「服務詳細資料」頁面的導覽中，按一下**服務認證**。
2. 尋找您的認證，然後按一下**檢視認證**。
3. 驗證您在 Kubernetes 密碼中使用正確的 **access_key_id** 及 **secret_access_key**。否則，請更新 Kubernetes 密碼。
   1. 取得您用來建立密碼的 YAML。
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}

   2. 更新 **access_key_id** 及 **secret_access_key**。
   3. 更新密碼。
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

4. 在 **iam_role_crn** 區段中，驗證您具有 `Writer` 或 `Manager` 角色。如果您沒有正確的角色，則必須[建立具有正確許可權的新 {{site.data.keyword.cos_full_notm}} 服務認證](/docs/containers?topic=containers-object_storage#create_cos_service)。然後，更新現有密碼，或使用新的服務認證來[建立新的密碼](/docs/containers?topic=containers-object_storage#create_cos_secret)。

<br />


## 物件儲存空間：無法存取現有儲存區

{: tsSymptoms}
當您建立 PVC 時，無法存取 {{site.data.keyword.cos_full_notm}} 中的儲存區。您會看到與下列內容類似的錯誤訊息：

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
您可能使用錯誤的儲存空間類別來存取現有儲存區，或嘗試存取您未建立的儲存區。

{: tsResolve}
1. 從 [{{site.data.keyword.Bluemix_notm}} 儀表板 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/) 中，選取 {{site.data.keyword.cos_full_notm}} 服務實例。
2. 選取**儲存區**。
3. 檢閱現有儲存區的**類別**及**位置**資訊。
4. 選擇適當的[儲存空間類別](/docs/containers?topic=containers-object_storage#cos_storageclass_reference)。

<br />


## 物件儲存空間：使用非 root 使用者身分存取檔案失敗
{: #cos_nonroot_access}

{: tsSymptoms}
您已使用主控台或 REST API，將檔案上傳至 {{site.data.keyword.cos_full_notm}} 服務實例。當您嘗試在應用程式部署中以使用 `runAsUser` 所定義的非 root 使用者身分存取這些檔案時，會拒絕對檔案的存取。

{: tsCauses}
在 Linux 中，檔案或目錄有 3 個存取群組：`Owner`、`Group` 及 `Other`。當您使用主控台或 REST API 將檔案上傳至 {{site.data.keyword.cos_full_notm}} 時，會移除 `Owner`、`Group` 及 `Other` 的許可權。每個檔案的許可權都如下所示：

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

當您使用 {{site.data.keyword.cos_full_notm}} 外掛程式上傳檔案時，會保留檔案的許可權而且不會變更。

{: tsResolve}
若要使用非 root 使用者身分存取檔案，非 root 使用者必須具有該檔案的讀取及寫入權。在 Pod 部署期間變更檔案的許可權，需要寫入作業。{{site.data.keyword.cos_full_notm}} 不是針對寫入工作負載所設計。在 Pod 部署期間更新許可權可能會讓您的 Pod 無法進入 `Running` 狀態。

若要解決此問題，在將 PVC 裝載至應用程式 Pod 之前，請建立另一個 Pod 以設定非 root 使用者的正確許可權。

1. 檢查儲存區中您檔案的許可權。
   1. 建立 `test-permission` Pod 的配置檔，並將檔案命名為 `test-permission.yaml`。
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

   2. 建立 `test-permission` Pod。
      ```
   kubectl apply -f test-permission.yaml
   ```
      {: pre}

   3. 登入 Pod。
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. 導覽至您的裝載路徑，並列出檔案的許可權。
      ```
      cd test && ls -al
      ```
      {: pre}

      輸出範例：
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}

2. 刪除 Pod。
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. 建立您用來更正檔案許可權之 Pod 的配置檔，並將它命名為 `fix-permission.yaml`。
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

3. 建立 `fix-permission` Pod。
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. 等待 Pod 進入 `Completed` 狀態。  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. 刪除 `fix-permission` Pod。
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. 重建您稍早用來檢查許可權的 `test-permission` Pod。
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. 驗證已更新檔案的許可權。
   1. 登入 Pod。
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. 導覽至您的裝載路徑，並列出檔案的許可權。
      ```
      cd test && ls -al
      ```
      {: pre}

      輸出範例：
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}

6. 刪除 `test-permission` Pod。
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. 使用非 root 使用者身分，將 PVC 裝載至應用程式。

   將非 root 使用者定義為 `runAsUser`，而不需要同時在部署 YAML 中設定 `fsGroup`。設定 `fsGroup`，即會在部署 Pod 時觸發 {{site.data.keyword.cos_full_notm}} 外掛程式更新儲存區中所有檔案的群組許可權。更新許可權是一項寫入作業，而且可能會讓您的 Pod 無法進入 `Running` 狀態。
   {: important}

在您於 {{site.data.keyword.cos_full_notm}} 服務實例中設定正確的檔案許可權之後，請不要使用主控台或 REST API 來上傳檔案。請使用 {{site.data.keyword.cos_full_notm}} 外掛程式，將檔案新增至服務實例。
{: tip}

<br />




## 取得協助及支援
{: #storage_getting_help}

叢集仍有問題？
{: shortdesc}

-  在終端機中，有 `ibmcloud` CLI 及外掛程式的更新可用時，就會通知您。請務必保持最新的 CLI，讓您可以使用所有可用的指令及旗標。
-   若要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，請[檢查 {{site.data.keyword.Bluemix_notm}} 狀態頁面 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/status?selected=status)。
-   將問題張貼到 [{{site.data.keyword.containerlong_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com)。如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請[要求邀請](https://bxcs-slack-invite.mybluemix.net/)以加入此 Slack。
    {: tip}
-   檢閱討論區，以查看其他使用者是否發生過相同的問題。使用討論區提問時，請標記您的問題，以便 {{site.data.keyword.Bluemix_notm}} 開發團隊能看到它。
    -   如果您在使用 {{site.data.keyword.containerlong_notm}} 開發或部署叢集或應用程式時有技術方面的問題，請將問題張貼到 [Stack Overflow ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)，並使用 `ibm-cloud`、`kubernetes` 及 `containers` 來標記問題。
    -   若為服務及開始使用指示的相關問題，請使用 [IBM Developer Answers ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 討論區。請包含 `ibm-cloud` 及 `containers` 標籤。如需使用討論區的詳細資料，請參閱[取得協助](/docs/get-support?topic=get-support-getting-customer-support#using-avatar)。
-   開立案例，以與「IBM 支援中心」聯絡。若要瞭解如何開立 IBM 支援中心案例，或是瞭解支援層次與案例嚴重性，請參閱[與支援中心聯絡](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support)。當您報告問題時，請包含您的叢集 ID。若要取得叢集 ID，請執行 `ibmcloud ks clusters`。您也可以使用 [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility)，來收集及匯出叢集中的相關資訊，以與 IBM 支援中心共用。
{: tip}

