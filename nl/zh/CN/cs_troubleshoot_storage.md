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


# 集群存储故障诊断
{: #cs_troubleshoot_storage}

在使用 {{site.data.keyword.containerlong}} 时，请考虑对集群存储进行故障诊断的以下方法。
{: shortdesc}

如果您有更常规的问题，请尝试[集群调试](/docs/containers?topic=containers-cs_troubleshoot)。
{: tip}

## 在多专区集群中，持久卷安装到 pod 失败
{: #mz_pv_mount}

{: tsSymptoms}
集群先前是具有独立工作程序节点（不在工作程序池中）的单专区集群。您已成功安装了持久卷声明 (PVC)，其中描述了要用于应用程序的 pod 部署的持久卷 (PV)。现在，您已具有工作程序池，并且已向集群添加专区，但是 PV 安装到 pod 失败。

{: tsCauses}
对于多专区集群，PV 必须具有以下标签，这样 pod 就不会尝试在其他专区中安装卷。
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

具有可跨多个专区的工作程序池的新集群在缺省情况下会对 PV 进行标记。如果在引入工作程序池之前创建了集群，那么必须手动添加标签。

{: tsResolve}
[使用区域和专区标签更新集群中的 PV](/docs/containers?topic=containers-kube_concepts#storage_multizone)。

<br />


## 文件存储器：工作程序节点的文件系统更改为只读
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
您可能会看到下列其中一个症状：
- 当您运行 `kubectl get pods -o wide` 时，您会看到在同一工作程序节点上运行的多个 pod 陷入 `ContainerCreating` 状态。
- 运行 `kubectl describe` 命令时，在 **Events** 部分中看到以下错误：`MountVolume.SetUp failed for volume ... read-only file system`。

{: tsCauses}
工作程序节点上的文件系统是只读的。

{: tsResolve}
1.  备份可能存储在工作程序节点或容器中的任何数据。
2.  要对现有工作程序节点进行短时间修订，请重新装入工作程序节点。<pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;cluster_name&gt; --worker &lt;worker_ID&gt;</code></pre>

对于长期生效的修订，请[更新工作程序池的机器类型](/docs/containers?topic=containers-update#machine_type)。

<br />



## 文件存储器：非 root 用户拥有 NFS 文件存储器安装路径时，应用程序发生故障
{: #nonroot}

{: tsSymptoms}
向部署[添加 NFS 存储器](/docs/containers?topic=containers-file_storage#app_volume_mount)后，容器的部署失败。检索容器的日志时，您可能会看到如下所示的错误。pod 发生故障，并且卡在重新装入循环中。

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
缺省情况下，非 root 用户在支持 NFS 的存储器的卷安装路径上没有写许可权。一些公共应用程序映像（例如，Jenkins 和 Nexus3）会在 Dockerfile 中指定拥有安装路径的非 root 用户。通过此 Dockerfile 创建容器时，由于安装路径上非 root 用户的许可权不足，创建容器会失败。要授予写许可权，可以修改 Dockerfile，以在更改安装路径许可权之前将非 root 用户临时添加到 root 用户组，或者使用 init 容器。

如果使用 Helm 图表来部署映像，请编辑 Helm 部署以使用 init 容器。
{:tip}



{: tsResolve}
在部署中包含 [init 容器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) 时，可以向 Dockerfile 中指定的非 root 用户授予对容器内卷安装路径的写许可权。init 容器会在应用程序容器启动之前启动。init 容器在容器内创建卷安装路径，将安装路径更改为由正确的（非 root）用户拥有，然后关闭。随后，应用程序容器将以必须写入安装路径的非 root 用户身份启动。由于该路径已由非 root 用户拥有，因此写入安装路径成功。如果您不想使用 init 容器，那么可以修改 Dockerfile 以添加对 NFS 文件存储器的非 root 用户访问权。


开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  打开应用程序的 Dockerfile，并从要向其授予卷安装路径的写入者许可权的用户获取用户标识 (UID) 和组标识 (GID)。在来自 Jenkins Dockerfile 的示例中，信息为：
    - UID：`1000`
    - GID：`1000`

    **示例**：

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

2.  通过创建持久卷声明 (PVC) 将持久性存储器添加到应用程序。此示例使用 `ibmc-file-bronze` 存储类。要查看可用的存储类，请运行 `kubectl get storageclasses`。

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

3.  创建 PVC。

    ```
     kubectl apply -f mypvc.yaml
     ```
    {: pre}

4.  在部署 `.yaml` 文件中，添加 init 容器。包含您先前检索到的 UID 和 GID。

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

    Jenkins 部署的**示例**：

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

5.  创建 pod 并将 PVC 安装到该 pod。

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. 验证卷是否已成功安装到 pod。记下 pod 名称和 **Containers/Mounts** 路径。

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **示例输出**：

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

7.  使用先前记下的 pod 名称登录到 pod。

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. 验证容器安装路径的许可权。在示例中，安装路径为 `/var/jenkins_home`。

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **示例输出**：

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    此输出显示 Dockerfile 中的 GID 和 UID（在此示例中为 `1000` 和 `1000`）拥有容器内的安装路径。

<br />


## 文件存储器：添加持久性存储器的非 root 用户访问权失败
{: #cs_storage_nonroot}

{: tsSymptoms}
在[添加持久性存储器的非 root 用户访问权](#nonroot)或使用指定的非 root 用户标识部署 Helm chart 后，用户无法写入安装的存储器。

{: tsCauses}
部署或 Helm 图表配置为 pod 的 `fsGroup`（组标识）和 `runAsUser`（用户标识）指定了[安全上下文](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)。目前，{{site.data.keyword.containerlong_notm}} 不支持 `fsGroup` 规范，而仅支持将 `runAsUser` 设置为 `0`（root 用户许可权）。

{: tsResolve}
从映像、部署或 Helm 图表配置文件中除去配置的 `fsGroup` 和 `runAsUser` 的 `securityContext` 字段，然后重新部署。如果需要将安装路径的所有权从 `nobody` 更改为其他值，请[添加非 root 用户访问权](#nonroot)。添加[非 root 用户 `initContainer`](#nonroot) 后，请在容器级别（而非 pod 级别）设置 `runAsUser`。

<br />




## 块存储器：块存储器更改为只读
{: #readonly_block}

{: tsSymptoms}
您可能看到以下症状：
- 运行 `kubectl get pods -o wide` 时，您会看到同一工作程序节点上的多个 pod 卡在 `ContainerCreating` 或 `CrashLoopBackOff` 状态。所有这些 pod 都使用的是同一块存储器实例。
- 运行 `kubectl describe pod` 命令时，在 **Events** 部分中看到以下错误：`MountVolume.SetUp failed for volume ... read-only`。

{: tsCauses}
如果在 pod 写入卷时发生网络错误，IBM Cloud Infrastructure (SoftLayer) 会通过将此卷更改为只读方式，从而保护卷上的数据不被损坏。使用此卷的 pod 无法继续写入卷而失败。

{: tsResolve}
1. 检查集群中安装的 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的版本。
   ```
   helm ls
   ```
   {: pre}

2. 验证是否使用的是[最新版本的 {{site.data.keyword.Bluemix_notm}} Block Storage 插件](https://cloud.ibm.com/containers-kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin)。如果不是，请[更新插件](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in)。
3. 如果对 pod 使用的是 Kubernetes 部署，请通过除去失败的 pod 并允许 Kubernetes 重新创建该 pod，从而重新启动该 pod。如果未使用部署，请通过运行 `kubectl get pod <pod_name> -o yaml >pod.yaml` 来检索用于创建该 pod 的 YAML 文件。然后，删除并手动重新创建该 pod。
    ```
      kubectl delete pod <pod_name>
      ```
    {: pre}

4. 检查是否重新创建 pod 解决了该问题。如果没有解决问题，请重新装入工作程序节点。
   1. 查找运行 pod 的工作程序节点，并记下分配给工作程序节点的专用 IP 地址。
      ```
      kubectl describe pod <pod_name> | grep Node
      ```
      {: pre}

      输出示例：
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. 使用上一步中的专用 IP 地址来检索工作程序节点的**标识**。
      ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
      {: pre}

   3. 正常[重新装入工作程序节点](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload)。


<br />


## 块存储器：由于文件系统不正确，将现有块存储器安装到 pod 失败
{: #block_filesystem}

{: tsSymptoms}
运行 `kubectl describe pod <pod_name>` 时，会看到以下错误：
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
您具有设置为使用 `XFS` 文件系统的现有块存储设备。为了将此设备安装到 pod，您已[创建 PV](/docs/containers?topic=containers-block_storage#existing_block)，其中在 `spec/flexVolume/fsType` 部分中指定 `ext4` 作为文件系统，或者未指定任何文件系统。如果未定义任何文件系统，PV 将缺省为 `ext4`。PV 已成功创建，并且已链接到现有块存储器实例。但是，尝试使用匹配的 PVC 将 PV 安装到集群时，卷安装失败。无法将使用 `ext4` 文件系统的 `XFS` 块存储器实例安装到 pod。

{: tsResolve}
将现有 PV 中的文件系统从 `ext4` 更新为 `XFS`。

1. 列出集群中的现有 PV，并记下用于现有块存储器实例的 PV 的名称。
   ```
   kubectl get pv
   ```
   {: pre}

2. 将 PV YAML 保存到本地计算机。
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. 打开该 YAML 文件，并将 `fsType` 从 `ext4` 更改为 `xfs`。
4. 替换集群中的 PV。
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. 登录到安装了 PV 的 pod。
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. 验证文件系统是否已更改为 `XFS`。
   ```
   df -Th
   ```
   {: pre}

   输出示例：
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## Object Storage：安装 {{site.data.keyword.cos_full_notm}} `ibmc` Helm 插件失败
{: #cos_helm_fails}

{: tsSymptoms}
在安装 {{site.data.keyword.cos_full_notm}} `ibmc` Helm 创建时，安装失败，发生以下错误：
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
在安装 `ibmc` Helm 插件时，将创建从 `./helm/plugins/helm-ibmc` 目录到 `ibmc` Helm 插件位于本地系统上的目录（通常位于 `./ibmcloud-object-storage-plugin/helm-ibmc` 中）的符号链接。在从本地系统除去 `ibmc` Helm 插件时，或者将 `ibmc` Helm 插件目录移至其他位置时，不会除去符号链接。

{: tsResolve}
1. 除去 {{site.data.keyword.cos_full_notm}} Helm 插件。
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. [安装 {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-object_storage#install_cos)。

<br />


## Object Storage：由于找不到 Kubernetes 私钥，PVC 或 pod 创建失败
{: #cos_secret_access_fails}

{: tsSymptoms}
在创建 PVC 或部署安装 PVC 的 pod 时，创建或部署失败。

- PVC 创建失败的示例错误消息：
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- pod 创建失败的示例错误消息：
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}

{: tsCauses}
存储 {{site.data.keyword.cos_full_notm}} 服务凭证的 Kubernetes 私钥、PVC 和 pod 不是全都位于同一 Kubernetes 名称空间中。在将私钥部署到与 PVC 或 pod 不同的名称空间时，无法访问私钥。

{: tsResolve}
此任务需要对所有名称空间的 [{{site.data.keyword.Bluemix_notm}} IAM **写入者**或**管理者**服务角色](/docs/containers?topic=containers-users#platform)。

1. 列出集群中的私钥并查看创建 {{site.data.keyword.cos_full_notm}} 服务实例的 Kubernetes 私钥的 Kubernetes 名称空间。私钥必须将 `ibm/ibmc-s3fs` 显示为 **Type**。
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. 检查 PVC 和 pod 的 YAML 配置文件以验证使用相同的名称空间。如果不想在私钥所在的名称空间中部署 pod，请在要部署 pod 的名称空间中[创建另一个私钥](/docs/containers?topic=containers-object_storage#create_cos_secret)。

3. 在相应的名称空间中创建 PVC 或部署 pod。

<br />


## Object Storage：由于错误的凭证或访问被拒绝，PVC 创建失败
{: #cred_failure}

{: tsSymptoms}
在创建 PVC 时，看到类似于以下其中一项的错误消息：

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
用于访问服务实例的 {{site.data.keyword.cos_full_notm}} 服务凭证可能错误，或者仅允许对存储区执行读访问。

{: tsResolve}
1. 在服务详细信息页面上的导航中，单击**服务凭证**。
2. 查找凭证，然后单击**查看凭证**。
3. 验证在 Kubernetes 私钥中是否使用了正确的 **access_key_id** 和 **secret_access_key**。如果不是，请更新 Kubernetes 私钥。
   1. 获取用于创建私钥的 YAML。
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}

   2. 更新 **access_key_id** 和 **secret_access_key**。
   3. 更新私钥。
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

4. 在 **iam_role_crn** 部分中，验证您是否具有 `Writer` 或 `Manager` 角色。如果没有正确的角色，那么必须[使用正确的许可权创建新的 {{site.data.keyword.cos_full_notm}} 服务凭证](/docs/containers?topic=containers-object_storage#create_cos_service)。然后，使用新的服务凭证更新现有私钥或[创建新私钥](/docs/containers?topic=containers-object_storage#create_cos_secret)。

<br />


## Object Storage：无法访问现有存储区

{: tsSymptoms}
在创建 PVC 时，无法访问 {{site.data.keyword.cos_full_notm}} 中的存储区。您会看到类似于以下内容的错误消息：

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
您可能使用了错误的存储类来访问现有存储区，或者尝试访问未创建的存储区。

{: tsResolve}
1. 从 [{{site.data.keyword.Bluemix_notm}} 仪表板 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/)，选择 {{site.data.keyword.cos_full_notm}} 服务实例。
2. 选择**存储区**。
3. 查看现有存储区的**类**和**位置**信息。
4. 选择相应的[存储类](/docs/containers?topic=containers-object_storage#cos_storageclass_reference)。

<br />


## Object Storage：使用非 root 用户访问文件失败
{: #cos_nonroot_access}

{: tsSymptoms}
您已使用控制台或 REST API 将文件上传到 {{site.data.keyword.cos_full_notm}} 服务实例。在尝试使用通过 `runAsUser` 在应用程序部署中定义的非 root 用户访问这些文件时，将拒绝对文件的访问。

{: tsCauses}
在 Linux 中，文件或目录具有 3 个访问组：`Owner`、`Group` 和 `Other`。在使用控制台或 REST API 将文件上传到 {{site.data.keyword.cos_full_notm}} 时，将除去 `Owner`、`Group` 和 `Other` 的许可权。每个文件的许可权如下所示：

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

在使用 {{site.data.keyword.cos_full_notm}} 插件上传文件时，将保留文件的许可权而不进行更改。

{: tsResolve}
要使用非 root 用户访问文件，非 root 用户必须具有文件的读写许可权。作为 pod 部署的一部分更改文件的许可权需要写操作。{{site.data.keyword.cos_full_notm}} 不是针对写工作负载而设计的。在 pod 部署期间更新许可权可能阻止 pod 进入 `Running` 状态。

要解决此问题，请在将 PVC 安装到应用程序 pod 之前，创建另一个 pod 来为非 root 用户设置正确的许可权。

1. 检查存储区中文件的许可权。
   1. 针对 `test-permission` pod 创建配置文件并将文件命名为 `test-permission.yaml`。
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

   2. 创建 `test-permission` pod。
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}

   3. 登录到 pod。
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. 浏览到安装路径并列出文件的许可权。
      ```
      cd test && ls -al
      ```
      {: pre}

      输出示例：
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}

2. 删除 pod。
      
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. 针对要用于纠正文件许可权的 pod 创建配置文件，并将其命名为 `fix-permission.yaml`。
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

3. 创建 `fix-permission` pod。
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. 等待 pod 进入 `Completed` 状态。  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. 删除 `fix-permission` pod。
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. 重新创建先前用于检查许可权的 `test-permission` pod。
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. 验证是否更新了文件的许可权。
   1. 登录到 pod。
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. 浏览到安装路径并列出文件的许可权。
      ```
      cd test && ls -al
      ```
      {: pre}

      输出示例：
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}

6. 删除 `test-permission` pod。
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. 使用非 root 用户将 PVC 安装到应用程序。

   将非 root 用户定义为 `runAsUser`，同时不在部署 YAML 中设置 `fsGroup`。设置 `fsGroup` 将触发 {{site.data.keyword.cos_full_notm}} 插件以在部署 pod 时更新存储区中所有文件的组许可权。更新许可权是写操作，可能阻止 pod 进入 `Running` 状态。
   {: important}

在 {{site.data.keyword.cos_full_notm}} 服务实例中设置正确的文件许可权后，请勿通过使用控制台或 REST API 来上传文件。使用 {{site.data.keyword.cos_full_notm}} 插件以将文件添加到服务实例。
{: tip}

<br />




## 获取帮助和支持
{: #storage_getting_help}

集群仍然有问题吗？
{: shortdesc}

-  在终端中，在 `ibmcloud` CLI 和插件更新可用时，会通知您。请确保保持 CLI 为最新，从而可使用所有可用命令和标志。
-   要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，请[检查 {{site.data.keyword.Bluemix_notm}} 状态页面 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/status?selected=status)。
-   在 [{{site.data.keyword.containerlong_notm}} Slack ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://ibm-container-service.slack.com) 中发布问题。
    如果未将 IBM 标识用于 {{site.data.keyword.Bluemix_notm}} 帐户，请针对此 Slack [请求邀请](https://bxcs-slack-invite.mybluemix.net/)。
    {: tip}
-   请复查论坛，以查看是否有其他用户遇到相同的问题。使用论坛进行提问时，请使用适当的标记来标注您的问题，以方便 {{site.data.keyword.Bluemix_notm}} 开发团队识别。
    -   如果您有关于使用 {{site.data.keyword.containerlong_notm}} 开发或部署集群或应用程序的技术问题，请在 [Stack Overflow ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) 上发布您的问题，并使用 `ibm-cloud`、`kubernetes` 和 `containers` 标记您的问题。
    -   有关服务的问题和入门指示信息，请使用 [IBM Developer Answers ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 论坛。请加上 `ibm-cloud` 和 `containers` 标记。
    有关使用论坛的更多详细信息，请参阅[获取帮助](/docs/get-support?topic=get-support-getting-customer-support#using-avatar)。
-   通过开具案例来联系 IBM 支持人员。要了解有关开具 IBM 支持案例或有关支持级别和案例严重性的信息，请参阅[联系支持人员](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support)。报告问题时，请包含集群标识。要获取集群标识，请运行 `ibmcloud ks clusters`。您还可以使用 [{{site.data.keyword.containerlong_notm}} 诊断和调试工具](/docs/containers?topic=containers-cs_troubleshoot#debug_utility)从集群收集相关信息并导出这些信息，以便与 IBM 支持人员共享。
{: tip}

