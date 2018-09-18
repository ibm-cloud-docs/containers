---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# 在 IBM Block Storage for IBM Cloud 上存储数据
{: #block_storage}


## 在集群中安装 {{site.data.keyword.Bluemix_notm}} Block Storage 插件
{: #install_block}

安装 {{site.data.keyword.Bluemix_notm}} Block Storage 插件和 Helm 图表，以便为块存储器设置预定义的存储类。可以使用这些存储类来创建用于为应用程序供应块存储器的 PVC。
{: shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为要在其中安装 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的集群。


1. 遵循[指示信息](cs_integrations.html#helm)在本地计算机上安装 Helm 客户机，在集群中安装 Helm 服务器 (Tiller)，然后将 {{site.data.keyword.Bluemix_notm}} Helm 图表存储库添加到要在其中使用 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的集群。
2. 更新 Helm 存储库以检索此存储库中最新版本的所有 Helm 图表。
   ```
        helm repo update
        ```
   {: pre}

3. 安装 {{site.data.keyword.Bluemix_notm}} Block Storage 插件。安装该插件时，会将预定义的块存储类添加到集群中。
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   输出示例：
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

4. 验证安装是否已成功。
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   输出示例：
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   看到一个 `ibmcloud-block-storage-plugin` pod 以及一个或多个 `ibmcloud-block-storage-driver` pod 时，说明安装成功。`ibmcloud-block-storage-driver` pod 的数量等于集群中的工作程序节点数。所有 pod 都必须处于 **Running** 状态。

5. 验证块存储器的存储类是否已添加到集群。
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   输出示例：
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

6. 对要供应块存储器的每个集群，重复这些步骤。

现在可以继续[创建 PVC](#add_block)，以用于为应用程序供应块存储器。


### 更新 {{site.data.keyword.Bluemix_notm}} Block Storage 插件
现在，可以将现有 {{site.data.keyword.Bluemix_notm}} Block Storage 插件升级到最新版本。
{: shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

1. 更新 Helm 存储库以检索此存储库中最新版本的所有 Helm 图表。
   ```
        helm repo update
        ```
   {: pre}
   
2. 可选：将最新 Helm 图表下载到本地计算机。然后，解压缩该包并查看 `release.md` 文件，以了解最新的发行版信息。 
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. 找到已安装在集群中的 Block Storage Helm 图表的名称。
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   输出示例：
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. 将 {{site.data.keyword.Bluemix_notm}} Block Storage 插件升级到最新版本。
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. 可选：更新插件时，会取消设置`缺省`存储类。如果要将缺省存储类设置为您选择的存储类，请运行以下命令。
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### 除去 {{site.data.keyword.Bluemix_notm}} Block Storage 插件
如果不想在集群中供应和使用 {{site.data.keyword.Bluemix_notm}} Block Storage，那么可以卸载 Helm 图表。
{: shortdesc}

**注**：除去该插件不会除去现有 PVC、PV 或数据。除去该插件时，将从集群中除去所有相关的 pod 和守护程序集。除去该插件后，无法为集群供应新的块存储器，也无法使用现有块存储器 PVC 和 PV。

开始之前：
- [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。 
- 确保集群中没有任何使用块存储器的 PVC 或 PV。

要除去该插件，请执行以下操作： 

1. 找到已安装在集群中的 Block Storage Helm 图表的名称。
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   输出示例：
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. 删除 {{site.data.keyword.Bluemix_notm}} Block Storage 插件。
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. 验证块存储器 pod 是否已除去。
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   如果 CLI 输出中未显示任何 pod，说明 pod 除去操作成功。

4. 验证块存储器的存储类是否已除去。
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   如果 CLI 输出中未显示任何存储类，说明存储类除去操作成功。

<br />



## 决定块存储器配置
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} 为块存储器提供了预定义的存储类，可以使用这些类来供应具有特定配置的块存储器。
{: shortdesc}

每个存储类指定供应的块存储器的类型，包括可用大小、IOPS、文件系统和保留策略。  

**重要信息：**确保仔细选择存储配置，以便具有足够的容量来存储数据。使用存储类来供应特定类型的存储器后，即无法更改存储设备的大小、类型、IOPS 或保留策略。如果需要更多存储器或需要具有不同配置的存储器，那么必须[创建新的存储实例并复制数据](cs_storage_basics.html#update_storageclass)，即把旧存储实例中的数据复制到新存储实例。 

1. 列出 {{site.data.keyword.containerlong}} 中的可用存储类。
    ```
   kubectl get storageclasses | grep block
   ```
    {: pre}

    输出示例：
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

2. 查看存储类的配置。 
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}
   
   有关每个存储类的更多信息，请参阅[存储类参考](#storageclass_reference)。如果找不到要查找的内容，请考虑创建自己的定制存储类。首先，请查看[定制存储类样本](#custom_storageclass)。
   {: tip}
   
3. 选择要供应的块存储器的类型。 
   - **铜牌级、银牌级和金牌级存储类：**这些存储类供应[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)。通过耐久性存储器，可以选择预定义 IOPS 层的存储器大小（以千兆字节为单位）。
   - **定制存储类：**此存储类供应[性能存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)。通过性能存储器，可以控制存储器和 IOPS 的大小。 
     
4. 选择块存储器的大小和 IOPS。IOPS 的大小和数量定义了 IOPS（每秒输入/输出操作数）的总数，这用于指示存储器的速度。存储器的总 IOPS 越高，处理读写操作的速度越快。 
   - **铜牌级、银牌级和金牌级存储类：**这些存储类随附固定数量的 IOPS/千兆字节，并在 SSD 硬盘上供应。IOPS 的总数取决于您选择的存储器大小。您可以在允许的大小范围内选择任意整数的千兆字节（例如，20 Gi、256 Gi、11854 Gi）。要确定 IOPS 的总数，必须将 IOPS 乘以所选大小。例如，如果在随附 4 IOPS/GB 的银牌级存储类中选择 1000 Gi 块存储器大小，那么存储器总计有 4000 IOPS。  
     <table>
         <caption>存储类大小范围和 IOPS/千兆字节表</caption>
         <thead>
         <th>存储类</th>
         <th>IOPS/千兆字节</th>
         <th>大小范围（千兆字节）</th>
         </thead>
         <tbody>
         <tr>
         <td>铜牌级</td>
         <td>2 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>银牌级</td>
         <td>4 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>金牌级</td>
         <td>10 IOPS/GB</td>
         <td>20-4000 Gi</td>
         </tr>
         </tbody></table>
   - **定制存储类：**选择此存储类时，可以对所需大小和 IOPS 具有更多控制权。对于大小，可以在允许的大小范围内选择任意整数的千兆字节。选择的大小将确定可供您使用的 IOPS 范围。您可以选择指定范围内是 100 的倍数的 IOPS。您选择的 IOPS 是静态的，不会随存储器大小进行扩展。例如，如果选择了 40 Gi 和 100 IOPS，那么总 IOPS 仍为 100。</br></br>IOPS 与千兆字节的比率还可确定供应的硬盘类型。例如，如果对于 100 IOPS 选择了 500 Gi，那么 IOPS 与千兆字节的比率为 0.2。比率小于或等于 0.3 的存储器在 SATA 硬盘上供应。如果比率大于 0.3，那么会在 SSD 硬盘上供应存储器。
     <table>
         <caption>定制存储类大小范围和 IOPS 表</caption>
         <thead>
         <th>大小范围（千兆字节）</th>
         <th>IOPS 范围（100 的倍数）</th>
         </thead>
         <tbody>
         <tr>
         <td>20-39 Gi</td>
         <td>100-1000 IOPS</td>
         </tr>
         <tr>
         <td>40-79 Gi</td>
         <td>100-2000 IOPS</td>
         </tr>
         <tr>
         <td>80-99 Gi</td>
         <td>100-4000 IOPS</td>
         </tr>
         <tr>
         <td>100-499 Gi</td>
         <td>100-6000 IOPS</td>
         </tr>
         <tr>
         <td>500-999 Gi</td>
         <td>100-10000 IOPS</td>
         </tr>
         <tr>
         <td>1000-1999 Gi</td>
         <td>100-20000 IOPS</td>
         </tr>
         <tr>
         <td>2000-2999 Gi</td>
         <td>200-40000 IOPS</td>
         </tr>
         <tr>
         <td>3000-3999 Gi</td>
         <td>200-48000 IOPS</td>
         </tr>
         <tr>
         <td>4000-7999 Gi</td>
         <td>300-48000 IOPS</td>
         </tr>
         <tr>
         <td>8000-9999 Gi</td>
         <td>500-48000 IOPS</td>
         </tr>
         <tr>
         <td>10000-12000 Gi</td>
         <td>1000-48000 IOPS</td>
         </tr>
         </tbody></table>

5. 选择在删除集群或持久性卷申领 (PVC) 后是否要保留数据。 
   - 如果要保留数据，请选择 `retain` 存储类。删除 PVC 时，仅会删除 PVC。PV、IBM Cloud Infrastructure (SoftLayer) 帐户中的物理存储设备以及数据仍会存在。要回收存储器并再次在集群中使用，必须除去 PV，并执行[使用现有块存储器](#existing_block)的步骤。 
   - 如果要在删除 PVC 时删除 PV、数据和物理块存储设备，请选择不带 `retain` 的存储类。
   
6. 选择是要按小时还是按月计费。有关更多信息，请查看[定价 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/block-storage/pricing)。缺省情况下，所有块存储设备都以按小时计费类型进行供应。 

<br />



## 向应用程序添加块存储器
{: #add_block}

创建持久性卷申领 (PVC) 以便为集群[动态供应](cs_storage_basics.html#dynamic_provisioning)块存储器。动态供应将自动创建匹配的持久性卷 (PV)，并在 IBM Cloud Infrastructure (SoftLayer) 帐户中订购实际存储设备。
{:shortdesc}

**重要信息**：块存储器随附 `ReadWriteOnce` 访问方式。一次只能将其安装到集群中一个工作程序节点上的一个 pod。

开始之前：
- 如果您有防火墙，请针对集群所在专区的 IBM Cloud Infrastructure (SoftLayer) IP 范围[允许流出访问](cs_firewall.html#pvc)，以便您可以创建 PVC。
- 安装 [{{site.data.keyword.Bluemix_notm}} Block Storage 插件](#install_block)。
- [决定预定义的存储类](#predefined_storageclass)或创建[定制存储类](#custom_storageclass)。 

要添加块存储器，请执行以下操作：

1.  创建配置文件以定义持久性卷申领 (PVC)，并将配置保存为 `.yaml` 文件。

    -  **铜牌级、银牌级或金牌级存储类的示例**：
       以下 `.yaml` 文件创建名为 `mypvc` 的申领，其中存储类为 `"ibmc-block-silver"`，计费类型为 `"hourly"`，千兆字节大小为 `24Gi`。 

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

    -  **使用定制存储类的示例**：
       以下 `.yaml` 文件创建名为 `mypvc` 的申领，其中存储类为 `ibmc-block-retain-custom`，计费类型为 `"hourly"`，千兆字节大小为 `45Gi`，IOPS 为 `"300"`。 

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
        <caption>了解 YAML 文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>输入 PVC 的名称。</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>要用于供应块存储器的存储类的名称。</br> 如果未指定存储类，那么会使用缺省存储类 <code>ibmc-file-bronze</code> 来创建 PV。<p>**提示：**如果要更改缺省存储类，请运行 <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code>，并将 <code>&lt;storageclass&gt;</code> 替换为存储类的名称。</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>指定用于计算存储器帐单的频率："monthly" 或 "hourly"。缺省值为 "hourly"。</td>
        </tr>
	<tr>
	<td><code>metadata/region</code></td>
        <td>指定要在其中供应块存储器的区域。如果指定了区域，那么还必须指定专区。如果未指定区域，或者找不到指定的区域，那么会在集群所在的区域中创建存储器。</br><strong>注：</strong>仅 IBM Cloud Block Storage 插件 V1.0.1 或更高版本支持此选项。对于更旧的插件版本，如果您有多专区集群，那么将循环选择供应存储器的专区，以在所有专区中均匀均衡卷请求。如果要为存储器指定专区，请首先创建[定制存储类](#multizone_yaml)。然后，使用定制存储类创建 PVC。</td>
	</tr>
	<tr>
	<td><code>metadata/zone</code></td>
	<td>指定要在其中供应块存储器的专区。如果指定了专区，那么还必须指定区域。如果未指定专区或在多专区集群中找不到指定的专区，那么将循环选择专区。</br><strong>注：</strong>仅 IBM Cloud Block Storage 插件 V1.0.1 或更高版本支持此选项。对于更旧的插件版本，如果您有多专区集群，那么将循环选择供应存储器的专区，以在所有专区中均匀均衡卷请求。如果要为存储器指定专区，请首先创建[定制存储类](#multizone_yaml)。然后，使用定制存储类创建 PVC。</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>输入块存储器的大小，以千兆字节 (Gi) 为单位。</br></br><strong>注：</strong>供应存储器后，即不能更改块存储器的大小。因此，请确保指定与要存储的数据量相匹配的大小。</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>此选项仅适用于定制存储类 (`ibmc-block-custom / ibmc-block-retain-custom`)。请指定存储器的总 IOPS，在允许范围内选择 100 的倍数。如果选择的 IOPS 不同于列出的 IOPS，那么该 IOPS 会向上舍入。</td>
        </tr>
        </tbody></table>

    如果要使用定制存储类，请使用相应的存储类名称、有效的 IOPS 和大小来创建 PVC。   
    {: tip}

2.  创建 PVC。

    ```
     kubectl apply -f mypvc.yaml
     ```
    {: pre}

3.  验证 PVC 是否已创建并与 PV 绑定。此过程可能需要几分钟时间。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    输出示例：

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     

    ```
    {: screen}

4.  {: #app_volume_mount}要将 PV 安装到部署，请创建配置 `.yaml` 文件，并指定绑定该 PV 的 PVC。

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
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>部署的标签。</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>应用程序的标签。</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>部署的标签。</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>要使用的映像的名称。要列出 {{site.data.keyword.registryshort_notm}} 帐户中的可用映像，请运行 `ibmcloud cr image-list`。</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>要部署到集群的容器的名称。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>在容器中安装卷的目录的绝对路径。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>要安装到 pod 中的卷的名称。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>要安装到 pod 中的卷的名称。通常此名称与 <code>volumeMounts/name</code> 相同。</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>绑定要使用的 PV 的 PVC 的名称。</td>
    </tr>
    </tbody></table>

5.  创建部署。
     ```
    kubectl apply -f <local_yaml_path>
    ```
     {: pre}

6.  验证 PV 是否已成功安装。

     ```
    kubectl describe deployment <deployment_name>
    ```
     {: pre}

     安装点位于 **Volume Mounts** 字段中，卷位于 **Volumes** 字段中。

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




## 使用集群中的现有块存储器
{: #existing_block}

如果您具有要在集群中使用的现有物理存储设备，那么可以手动创建 PV 和 PVC，以[静态供应](cs_storage_basics.html#static_provisioning)存储器。

在开始将现有存储器安装到应用程序之前，必须检索 PV 的所有必要信息。  
{: shortdesc}

### 步骤 1：检索现有块存储器的信息

1.  检索或生成 IBM Cloud Infrastructure (SoftLayer) 帐户的 API 密钥。
    1. 登录到 [IBM Cloud Infrastructure (SoftLayer) 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.bluemix.net/)。
    2. 选择**帐户**，再选择**用户**，然后选择**用户列表**。
    3. 找到您的用户标识。
    4. 在 **API 密钥**列中，单击**生成**以生成 API 密钥，或者单击**查看**以查看现有 API 密钥。
2.  检索 IBM Cloud Infrastructure (SoftLayer) 帐户的 API 用户名。
    1. 从**用户列表**菜单中，选择您的用户标识。
    2. 在 **API 访问信息**部分中，找到您的 **API 用户名**。
3.  登录到 IBM Cloud Infrastructure CLI 插件。
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  选择使用 IBM Cloud Infrastructure (SoftLayer) 帐户的用户名和 API 密钥进行认证。
5.  输入在先前步骤中检索到的用户名和 API 密钥。
6.  列出可用的块存储设备。
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    输出示例：
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  记下要安装到集群的块存储设备的 `id`、`ip_addr`、`capacity_gb`、`datacenter` 和 `lunId`。**注：**要将现有存储器安装到集群，必须在存储器所在的专区中有工作程序节点。要验证工作程序节点的专区，请运行 `ibmcloud ks workers <cluster_name_or_ID>`。 

### 步骤 2：创建持久性卷 (PV) 和匹配的持久性卷申领 (PVC)

1.  可选：如果您具有使用 `retain` 存储类供应的存储器，那么在除去 PVC 时，不会除去 PV 和物理存储设备。要在集群中复用存储器，必须首先除去 PV。 
    1. 列出现有 PV。
       ```
    kubectl get pv
    ```
       {: pre}
     
       查找属于持久性存储器的 PV。该 PV 处于 `released` 状态。 
     
    2. 除去该 PV。
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}
   
    3. 验证 PV 是否已除去。
       ```
    kubectl get pv
    ```
       {: pre}

2.  为 PV 创建配置文件。包含先前检索到的块存储器 `id`、`ip_addr`、`capacity_gb`、`datacenter` 和 `lunIdID`。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region=<region>
         failure-domain.beta.kubernetes.io/zone=<zone>
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
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>输入要创建的 PV 的名称。</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>输入先前检索到的区域和专区。必须在持久性存储器所在的区域和专区中至少有一个工作程序节点，才能在集群中安装该存储器。如果存储器的 PV 已存在，请向 PV [添加专区和区域标签](cs_storage_basics.html#multizone)。
    </tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>输入为现有块存储器配置的文件系统类型。选择 <code>ext4</code> 或 <code>xfs</code>。如果未指定此选项，PV 将缺省为 <code>ext4</code>。如果定义了错误的 fsType，那么 PV 创建会成功，但将 PV 安装到 pod 会失败。</td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>输入在先前步骤中检索到的现有块存储器的存储器大小作为 <code>capacity-gb</code>。存储器大小必须以千兆字节为单位，例如 20Gi (20 GB) 或 1000Gi (1 TB)。</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>输入先前检索到的块存储器的 LUN 标识作为 <code>lunId</code>。</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>输入先前检索到的块存储器的 IP 地址作为 <code>ip_addr</code>。</td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>输入先前检索到的块存储器的标识作为 <code>id</code>。</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>输入卷的名称。</td>
	    </tr>
    </tbody></table>

3.  在集群中创建 PV。
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. 验证 PV 是否已创建。
    ```
    kubectl get pv
    ```
    {: pre}

5. 创建另一个配置文件以创建 PVC。为了使 PVC 与先前创建的 PV 相匹配，必须为 `storage` 和 `accessMode` 选择相同的值。`storage-class` 字段必须为空。如果其中任何字段与 PV 不匹配，那么会改为自动创建新的 PV。

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

6.  创建 PVC。
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  验证 PVC 是否已创建并与先前创建的 PV 绑定。此过程可能需要几分钟时间。
     ```
    kubectl describe pvc mypvc
    ```
     {: pre}

     输出示例：

     ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
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

您已成功创建 PV，并将其绑定到 PVC。现在，集群用户可以向自己的部署[安装 PVC](#app_volume_mount)，并开始对 PV 执行读写操作。

<br />



## 备份和复原数据 
{: #backup_restore}

块存储器已供应到集群中的工作程序节点所在的位置。存储器由 IBM 在集群服务器上托管，以在服务器停止运行时提供可用性。但是，块存储器不会自动进行备份，因此在整个位置发生故障时可能无法进行访问。为了防止数据丢失或损坏，可以设置定期备份，以便在需要时可用于复原数据。


查看块存储器的以下备份和复原选项：

<dl>
  <dt>设置定期快照</dt>
  <dd><p>可以[为块存储器设置定期快照](/docs/infrastructure/BlockStorage/snapshots.html#snapshots)，这是捕获某个时间点的实例状态的只读图像。要存储快照，必须在块存储器上请求快照空间。快照会存储在同一专区的现有存储器实例上。如果用户意外地从卷中除去了重要数据，那么可以通过快照来复原数据。</br></br> <strong>要为卷创建快照，请执行以下操作：</strong><ol><li>列出集群中的现有 PV。<pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>获取要为其创建快照空间的 PV 的详细信息，并记下卷标识、大小和 IOPS。<pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> 大小和 IOPS 会显示在 CLI 输出的 <strong>Labels</strong> 部分中。要查找卷标识，请查看 CLI 输出的 <code>ibm.io/network-storage-id</code> 注释。</li><li>使用您在先前步骤中检索到的参数为现有卷创建快照大小。<pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>等待快照大小创建。<pre class="pre"><code>slcli block volume-detail &lt;volume_id&gt;</code></pre>CLI 输出中的 <strong>Snapshot Capacity (GB)</strong> 从 0 更改为您所订购的大小时，说明已成功供应快照大小。</li><li>为卷创建快照，并记下创建的快照的标识。<pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>验证快照是否已成功创建。<pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>要将数据从快照复原到现有卷，请运行以下命令：</strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>将快照复制到其他专区</dt>
 <dd><p>为了保护数据不受专区故障的影响，可以[复制快照](/docs/infrastructure/BlockStorage/replication.html#replicating-data)到其他专区中设置的块存储器实例。数据只能从主存储器复制到备份存储器。不能将复制的块存储器实例安装到集群。主存储器发生故障时，可以手动将复制的备份存储器设置为主存储器。然后，可以将其安装到集群。复原主存储器后，可以从备份存储器复原数据。</p></dd>
 <dt>复制存储器</dt>
 <dd><p>可以在原始存储器实例所在的专区中[复制块存储器实例](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume)。复制项采用原始存储器实例在创建该复制项的时间点的数据。与副本不同，复制项用作独立于原始项的存储器实例。要进行复制，请首先为该卷设置快照。</p></dd>
  <dt>将数据备份到 {{site.data.keyword.cos_full}}</dt>
  <dd><p>可以使用 [**ibm-backup-restore 映像**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter)来加快集群中的备份和复原 pod。此 pod 包含一个脚本，用于对集群中的任何持久性卷申领 (PVC) 运行一次性或定期备份。数据存储在您在某个专区中设置的 {{site.data.keyword.cos_full} 实例中。</p><strong>注：</strong>块存储器使用 RWO 访问方式进行安装。此访问权仅允许一次将一个 pod 安装到块存储器。要备份数据，必须从存储器中卸载应用程序 pod，将其安装到备份 pod，备份数据，然后将存储器重新安装到应用程序 pod。</br></br>
要使数据具有更高可用性，并保护应用程序不受专区故障的影响，请设置第二个 {{site.data.keyword.cos_full}} 实例，并在各个专区之间复制数据。如果需要从 {{site.data.keyword.cos_full}} 实例复原数据，请使用随映像一起提供的复原脚本。</dd>
<dt>将数据复制到 pod 和容器，以及从 pod 和容器中复制数据</dt>
<dd><p>可以使用 `kubectl cp` [命令 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) 将文件和目录复制到集群中的 pod 或特定容器，或者从集群中的 pod 或特定容器中复制文件和目录。</p>
<p>开始之前，请[设定 Kubernetes CLI 的目标](cs_cli_install.html#cs_cli_configure)为要使用的集群。如果未使用 <code>-c</code> 来指定容器，那么此命令将使用 pod 中的第一个可用容器。</p>
<p>可以通过以下各种方法来使用此命令：</p>
<ul>
<li>将本地机器中的数据复制到集群中的 pod：<pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>将集群的 pod 中的数据复制到本地机器：<pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>将集群的 pod 中的数据复制到其他集群的其他 pod 中的特定容器：<pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## 存储类参考
{: #storageclass_reference}

### 铜牌级
{: #bronze}

<table>
<caption>块存储类：铜牌级</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>类型</td>
<td>[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS/千兆字节</td>
<td>2</td>
</tr>
<tr>
<td>大小范围（千兆字节）</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>硬盘</td>
<td>SSD</td>
</tr>
<tr>
<td>计费</td>
<td>缺省计费类型取决于 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的版本：<ul><li> V1.0.1 和更高版本：按小时</li><li>V1.0.0 和更低版本：按月</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### 银牌级
{: #silver}

<table>
<caption>块存储类：银牌级</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>类型</td>
<td>[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS/千兆字节</td>
<td>4</td>
</tr>
<tr>
<td>大小范围（千兆字节）</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>硬盘</td>
<td>SSD</td>
</tr>
<tr>
<td>计费</td>
<td>缺省计费类型取决于 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的版本：<ul><li> V1.0.1 和更高版本：按小时</li><li>V1.0.0 和更低版本：按月</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### 金牌级
{: #gold}

<table>
<caption>块存储类：金牌级</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>类型</td>
<td>[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS/千兆字节</td>
<td>10</td>
</tr>
<tr>
<td>大小范围（千兆字节）</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>硬盘</td>
<td>SSD</td>
</tr>
<tr>
<td>计费</td>
<td>缺省计费类型取决于 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的版本：<ul><li> V1.0.1 和更高版本：按小时</li><li>V1.0.0 和更低版本：按月</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### 定制
{: #custom}

<table>
<caption>块存储类：定制</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>类型</td>
<td>[性能 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS 和大小</td>
<td><strong>大小范围（以千兆字节计）/ IOPS 范围（100 的倍数）</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>硬盘</td>
<td>IOPS 与千兆字节的比率确定供应的硬盘类型。要确定 IOPS 与千兆字节的比率，请将 IOPS 除以存储器的大小。</br></br>示例：
    </br>对于 100 IOPS，您选择了 500 Gi 存储器。因此，比率为 0.2 (100 IOPS/500 Gi)。</br></br><strong>每个比率的硬盘类型概述：</strong><ul><li>小于或等于 0.3：SATA</li><li>大于 0.3：SSD</li></ul></td>
</tr>
<tr>
<td>计费</td>
<td>缺省计费类型取决于 {{site.data.keyword.Bluemix_notm}} Block Storage 插件的版本：<ul><li> V1.0.1 和更高版本：按小时</li><li>V1.0.0 和更低版本：按月</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## 样本定制存储类
{: #custom_storageclass}

### 为多专区集群指定专区
{: #multizone_yaml}

以下 `.yaml` 文件定制基于 `ibm-block-silver` 非保留存储类的存储类：`type` 为 `"Endurance"`，`iopsPerGB` 为 `4`，`sizeRange` 为 `"[20-12000]Gi"`，`reclaimPolicy` 设置为 `"Delete"`。专区指定为 `dal12`。可以查看有关 `ibmc` 存储类的先前信息，以帮助您为这些项选择可接受的值。</br>

要将其他存储类用作您的基础，请参阅[存储类参考](#storageclass_reference)。 

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

### 使用 `XFS` 文件系统安装块存储器
{: #xfs}

以下示例创建名为 `ibmc-block-custom-xfs` 的存储类，并使用 `XFS` 文件系统来供应性能块存储器。 

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

