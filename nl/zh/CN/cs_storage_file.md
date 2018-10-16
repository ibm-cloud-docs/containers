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




# 在 IBM File Storage for IBM Cloud 上存储数据
{: #file_storage}


## 决定文件存储器配置
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} 为文件存储器提供了预定义的存储类，可以使用这些类来供应具有特定配置的文件存储器。
{: shortdesc}

每个存储类指定供应的文件存储器的类型，包括可用大小、IOPS、文件系统和保留策略。  

**重要信息：**确保仔细选择存储配置，以便具有足够的容量来存储数据。使用存储类来供应特定类型的存储器后，即无法更改存储设备的大小、类型、IOPS 或保留策略。如果需要更多存储器或需要具有不同配置的存储器，那么必须[创建新的存储实例并复制数据](cs_storage_basics.html#update_storageclass)，即把旧存储实例中的数据复制到新存储实例。

1. 列出 {{site.data.keyword.containerlong}} 中的可用存储类。
    ```
    kubectl get storageclasses | grep file
    ```
    {: pre}

    输出示例：
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
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

2. 查看存储类的配置。
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   有关每个存储类的更多信息，请参阅[存储类参考](#storageclass_reference)。如果找不到要查找的内容，请考虑创建您自己的定制存储类。首先，请查看[定制存储类样本](#custom_storageclass)。
   {: tip}

3. 选择要供应的文件存储器的类型。
   - **铜牌级、银牌级和金牌级存储类：**这些存储类供应[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)。通过耐久性存储器，可以选择预定义 IOPS 层的存储器大小（以千兆字节为单位）。
   - **定制存储类：**此存储类供应[性能存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)。通过性能存储器，可以控制存储器和 IOPS 的大小。

4. 选择文件存储器的大小和 IOPS。IOPS 的大小和数量定义了 IOPS（每秒输入/输出操作数）的总数，这用于指示存储器的速度。存储器的总 IOPS 越高，处理读写操作的速度越快。
   - **铜牌级、银牌级和金牌级存储类：**这些存储类随附固定数量的 IOPS/千兆字节，并在 SSD 硬盘上供应。IOPS 的总数取决于您选择的存储器大小。您可以在允许的大小范围内选择任意整数的千兆字节（例如，20 Gi、256 Gi、11854 Gi）。要确定 IOPS 的总数，必须将 IOPS 乘以所选大小。例如，如果在随附 4 IOPS/GB 的银牌级存储类中选择 1000 Gi 文件存储器大小，那么存储器总计有 4000 IOPS。
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
   - **定制存储类：**选择此存储类时，可以对所需大小和 IOPS 具有更多控制权。对于大小，可以在允许的大小范围内选择任意整数的千兆字节。选择的大小将确定可供您使用的 IOPS 范围。您可以选择指定范围内是 100 的倍数的 IOPS。您选择的 IOPS 是静态的，不会随存储器大小进行扩展。例如，如果选择了 40 Gi 和 100 IOPS，那么总 IOPS 仍为 100。</br></br> IOPS 与千兆字节的比率还可确定供应的硬盘类型。例如，如果对于 100 IOPS 选择了 500 Gi，那么 IOPS 与千兆字节的比率为 0.2。比率小于或等于 0.3 的存储器在 SATA 硬盘上供应。如果比率大于 0.3，那么会在 SSD 硬盘上供应存储器。  
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
   - 如果要保留数据，请选择 `retain` 存储类。删除 PVC 时，仅会删除 PVC。PV、IBM Cloud Infrastructure (SoftLayer) 帐户中的物理存储设备以及数据仍会存在。要回收存储器并再次在集群中使用，必须除去 PV，并执行[使用现有文件存储器](#existing_file)的步骤。
   - 如果要在删除 PVC 时删除 PV、数据和物理文件存储设备，请选择不带 `retain` 的存储类。**注**：如果您有 Dedicated 帐户，那么选择不带 `retain` 的存储类以阻止 IBM Cloud Infrastructure (SoftLayer) 中出现孤线程卷。

6. 选择是要按小时还是按月计费。有关更多信息，请查看[定价 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/pricing)。缺省情况下，所有文件存储设备都以按小时计费类型进行供应。
   **注：**如果选择按月计费类型，那么除去持久性存储器时，即使只用了很短的时间，您也仍需支付该持久性存储器一个月的费用。

<br />



## 向应用程序添加文件存储器
{: #add_file}

创建持久性卷申领 (PVC) 以便为集群[动态供应](cs_storage_basics.html#dynamic_provisioning)文件存储器。动态供应将自动创建匹配的持久性卷 (PV)，并在 IBM Cloud Infrastructure (SoftLayer) 帐户中订购物理存储设备。
{:shortdesc}

开始之前：
- 如果您有防火墙，请针对集群所在专区的 IBM Cloud Infrastructure (SoftLayer) IP 范围[允许流出访问](cs_firewall.html#pvc)，以便您可以创建 PVC。
- [决定预定义的存储类](#predefined_storageclass)或创建[定制存储类](#custom_storageclass)。

  **提示：**如果您有多专区集群，那么将循环选择供应存储器的专区，以在所有专区中均匀均衡卷请求。如果要为存储器指定专区，请首先创建[定制存储类](#multizone_yaml)。然后，执行本主题中的步骤，使用定制存储类来供应存储器。

要添加文件存储器，请执行以下操作：

1.  创建配置文件以定义持久性卷申领 (PVC)，并将配置保存为 `.yaml` 文件。

    -  **铜牌级、银牌级或金牌级存储类的示例**：
       以下 `.yaml` 文件创建名为 `mypvc` 的申领，其中存储类为 `"ibmc-file-silver"`，计费类型为 `"monthly"`，千兆字节大小为 `24Gi`。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **使用定制存储类的示例**：
       以下 `.yaml` 文件创建名为 `mypvc` 的申领，其中存储类为 `ibmc-file-retain-custom`，计费类型为 `"hourly"`，千兆字节大小为 `45Gi`，IOPS 为 `"300"`。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteMany
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
        <td>要用于供应文件存储器的存储类的名称。</br> 如果未指定存储类，那么会使用缺省存储类 <code>ibmc-file-bronze</code> 来创建 PV。<p>**提示：**如果要更改缺省存储类，请运行 <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code>，并将 <code>&lt;storageclass&gt;</code> 替换为存储类的名称。</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>指定用于计算存储器帐单的频率："monthly" 或 "hourly"。如果未指定计费类型，那么会为存储器供应按小时计费类型。 </td>
        </tr>
        <tr>
        <td><code>spec/accessMode</code></td>
        <td>指定下列选项之一：<ul><li><strong>ReadWriteMany：</strong>多个 pod 可安装 PVC。所有 pod 可对卷进行读取和写入。</li><li><strong>ReadOnlyMany：</strong>PVC 可由多个 pod 安装。所有 pod 都具有只读访问权。<li><strong>ReadWriteOnce：</strong>PVC 只能由一个 pod 安装。此 pod 可对卷进行读取和写入。</li></ul></td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>输入文件存储器的大小，以千兆字节 (Gi) 为单位。</br></br><strong>注：</strong>供应存储器后，即不能更改文件存储器的大小。因此，请确保指定与要存储的数据量相匹配的大小。</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>此选项仅适用于定制存储类 (`ibmc-file-custom / ibmc-file-retain-custom`)。请指定存储器的总 IOPS，在允许范围内选择 100 的倍数。如果选择的 IOPS 不同于列出的 IOPS，那么该 IOPS 会向上舍入。</td>
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
      3m		3m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}要将存储器安装到部署，请创建配置 `.yaml` 文件，并指定绑定该 PV 的 PVC。

    如果应用程序需要非 root 用户写入持久性存储器，或者应用程序需要安装路径由 root 用户拥有，请参阅[添加对 NFS 文件存储器的非 root 用户访问权](cs_troubleshoot_storage.html#nonroot)或[启用对 NFS 文件存储器的 root 用户许可权](cs_troubleshoot_storage.html#nonroot)。
    {: tip}

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
    <td>在容器中安装卷的目录的绝对路径。写入安装路径的数据存储在物理文件存储实例的 <coode>root</code> 目录下。要在物理文件存储实例中创建目录，必须在安装路径中创建子目录。</td>
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




## 使用集群中的现有文件存储器
{: #existing_file}

如果您具有要在集群中使用的现有物理存储设备，那么可以手动创建 PV 和 PVC，以[静态供应](cs_storage_basics.html#static_provisioning)存储器。

开始之前，请确保在现有文件存储器实例所在的专区中至少存在一个工作程序节点。

### 步骤1：准备现有存储器。

在开始将现有存储器安装到应用程序之前，必须检索 PV 的所有必要信息，并准备存储器以使其可供在集群中访问。  

**对于使用 `retain` 存储类供应的存储器：**</br>
如果使用 `retain` 存储类供应了存储器，那么在除去 PVC 时，不会自动除去 PV 和物理存储设备。要在集群中复用该存储器，必须首先除去剩余 PV。

要在供应现有存储器的集群之外的其他集群中使用该存储器，请执行[在集群外部创建的存储器](#external_storage)的步骤，以将存储器添加到工作程序节点的子网。
{: tip}

1. 列出现有 PV。
       
   ```
    kubectl get pv
    ```
   {: pre}

   查找属于持久性存储器的 PV。该 PV 处于 `released` 状态。

2. 获取该 PV 的详细信息。
   ```
   kubectl describe pv <pv_name>
   ```
   {: pre}

3. 记下 `CapacityGb`、`storageClass`、`failure-domain.beta.kubernetes.io/region`、`failure-domain.beta.kubernetes.io/zone`、`server` 和 `path`。

4. 除去该 PV。
   ```
   kubectl delete pv <pv_name>
   ```
   {: pre}

5. 验证 PV 是否已除去。
   ```
    kubectl get pv
    ```
   {: pre}

</br>

**对于在集群外部供应的持久性存储器：**</br>
如果要使用先前供应但从未在集群中使用的现有存储器，那么必须使存储器在工作程序节点所在的子网中可用。

**注**：如果您有 Dedicated 帐户，那么必须[开具支持凭单](/docs/get-support/howtogetsupport.html#getting-customer-support)。

1.  {: #external_storage}在 [IBM Cloud Infrastructure (SoftLayer) 门户网站 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://control.bluemix.net/) 中，单击**存储**。
2.  单击**文件存储器**并从**操作**菜单中，选择**授权主机**。
3.  选择**子网**。
4.  从下拉列表中，选择工作程序节点连接到的专用 VLAN 子网。要查找工作程序节点的子网，请运行 `ibmcloud ks workers <cluster_name>`，并将工作程序节点的`专用 IP` 与下拉列表中找到的子网进行比较。
5.  单击**提交**。
6.  单击文件存储器的名称。
7.  记录 `Mount Point`、`size` 和 `Location` 字段。`Mount Point` 字段显示为 `<nfs_server>:<file_storage_path>`.

### 步骤 2：创建持久性卷 (PV) 和匹配的持久性卷申领 (PVC)

1.  为 PV 创建存储器配置文件。包含先前检索到的值。

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
       storage: "<size>"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "<nfs_server>"
       path: "<file_storage_path>"
    ```
    {: codeblock}

    <table>
    <caption>了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>输入要创建的 PV 对象的名称。</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>输入先前检索到的区域和专区。必须在持久性存储器所在的区域和专区中至少有一个工作程序节点，才能在集群中安装该存储器。如果存储器的 PV 已存在，请向 PV [添加专区和区域标签](cs_storage_basics.html#multizone)。
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>输入先前检索到的现有 NFS 文件共享的存储器大小。输入的存储器大小必须以千兆字节为单位，例如 20Gi (20 GB) 或 1000Gi (1 TB)，并且大小必须与现有文件共享的大小相匹配。</td>
    </tr>
    <tr>
    <td><code>spec/accessMode</code></td>
    <td>指定下列选项之一：<ul><li><strong>ReadWriteMany：</strong>多个 pod 可安装 PVC。所有 pod 可对卷进行读取和写入。</li><li><strong>ReadOnlyMany：</strong>PVC 可由多个 pod 安装。所有 pod 都具有只读访问权。<li><strong>ReadWriteOnce：</strong>PVC 只能由一个 pod 安装。此 pod 可对卷进行读取和写入。</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>输入先前检索到的 NFS 文件共享服务器标识。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>输入先前检索到的 NFS 文件共享的路径。</td>
    </tr>
    </tbody></table>

3.  在集群中创建 PV。
    

    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4.  验证 PV 是否已创建。

    ```
    kubectl get pv
    ```
    {: pre}

5.  创建另一个配置文件以创建 PVC。为了使 PVC 与先前创建的 PV 相匹配，必须为 `storage` 和 `accessMode` 选择相同的值。`storage-class` 字段必须为空。如果其中任何字段与 PV 不匹配，那么会[动态供应](cs_storage_basics.html#dynamic_provisioning)新的 PV 和新的物理存储器实例。

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
         storage: "<size>"
    ```
    {: codeblock}

6.  创建 PVC。

    ```
     kubectl apply -f mypvc.yaml
     ```
    {: pre}

7.  验证 PVC 是否已创建并与 PV 绑定。此过程可能需要几分钟时间。

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
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


您已成功创建 PV，并将其绑定到 PVC。现在，集群用户可以[将 PVC 安装到其部署](#app_volume_mount)，并开始对 PV 对象执行读写操作。

<br />



## 更改缺省 NFS 版本
{: #nfs_version}

文件存储器的版本确定了用于与 {{site.data.keyword.Bluemix_notm}} 文件存储服务器通信的协议。缺省情况下，所有文件存储器实例都设置为使用 NFS V4。如果应用程序需要特定版本才能正常运行，那么可以将现有 PV 更改为较旧的 NFS 版本。
{: shortdesc}

要更改缺省 NFS 版本，您可以创建新的存储类以在集群中动态供应文件存储器，或者选择更改已安装到 pod 的现有 PV。

**重要信息：**要应用最新的安全性更新并提高性能，请使用缺省 NFS 版本，而不要更改为较旧的 NFS 版本。

**要使用所需的 NFS 版本来创建定制存储类，请执行以下操作：**
1. 使用要供应的 NFS 版本创建[定制存储类](#nfs_version_class)。
2. 在集群中创建存储类。
   ```
   kubectl apply -f nfsversion_storageclass.yaml
   ```
   {: pre}

3. 验证是否已创建定制存储类。
   ```
    kubectl get storageclasses
    ```
   {: pre}

4. 向[文件存储器](#add_file)供应定制存储类。

**要将现有 PV 更改为使用其他 NFS 版本，请执行以下操作：**

1. 获取要在其中更改 NFS 版本的文件存储器的 PV，并记下该 PV 的名称。
   ```
    kubectl get pv
    ```
   {: pre}

2. 向 PV 添加注释。将 `<version_number>` 替换为要使用的 NFS 版本。例如，要更改为 NFS V3.0，请输入 **3**。  
   ```
   kubectl patch pv <pv_name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<version_number>"}}}'
   ```
   {: pre}

3. 删除使用文件存储器的 pod，然后重新创建 pod。
   1. 将 pod yaml 保存到本地计算机。
      ```
      kubect get pod <pod_name> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. 删除 pod。
      ```
      kubectl deleted pod <pod_name>
      ```
      {: pre}

   3. 重新创建 pod。
      ```
      kubectl apply -f pod.yaml
      ```
      {: pre}

4. 等待 pod 部署。
   ```
            kubectl get pods
            ```
   {: pre}

   状态更改为 `Running` 时，说明 pod 已完全部署。

5. 登录到 pod。
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. 验证文件存储器是否已安装了您先前指定的 NFS 版本。
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   输出示例：
   ```
   nfs vers=3.0
   ```
   {: screen}

<br />


## 备份和复原数据
{: #backup_restore}

文件存储器已供应到集群中的工作程序节点所在的位置。存储器由 IBM 在集群服务器上托管，以在其中某个服务器停止运行时提供可用性。但是，文件存储器不会自动进行备份，因此在整个位置发生故障时可能无法进行访问。为了防止数据丢失或损坏，可以设置定期备份，以便在需要时可用于复原数据。
{: shortdesc}

查看文件存储器的以下备份和复原选项：

<dl>
  <dt>设置定期快照</dt>
  <dd><p>可以[为文件存储器设置定期快照](/docs/infrastructure/FileStorage/snapshots.html)，这是捕获某个时间点的实例状态的只读映像。要存储快照，必须在文件存储器上请求快照空间。快照会存储在同一专区的现有存储器实例上。如果用户意外地从卷中除去了重要数据，那么可以通过快照来复原数据。<strong>注</strong>：如果您有 Dedicated 帐户，那么必须[开具支持凭单](/docs/get-support/howtogetsupport.html#getting-customer-support)。</br></br> <strong>要为卷创建快照，请执行以下操作：</strong><ol><li>列出集群中的现有 PV。<pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>获取要为其创建快照空间的 PV 的详细信息，并记下卷标识、大小和 IOPS。<pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> 可以在 CLI 输出的 <strong>Labels</strong> 部分中找到卷标识、大小和 IOPS。</li><li>使用您在先前步骤中检索到的参数为现有卷创建快照大小。<pre class="pre"><code>slcli file snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>等待快照大小创建。<pre class="pre"><code>slcli file volume-detail &lt;volume_id&gt;</code></pre>CLI 输出中的 <strong>Snapshot Capacity (GB)</strong> 从 0 更改为您所订购的大小时，说明已成功供应快照大小。</li><li>为卷创建快照，并记下创建的快照的标识。<pre class="pre"><code>slcli file snapshot-create &lt;volume_id&gt;</code></pre></li><li>验证快照是否已成功创建。<pre class="pre"><code>slcli file volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>要将数据从快照复原到现有卷，请运行以下命令：</strong><pre class="pre"><code>slcli file snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>将快照复制到其他专区</dt>
 <dd><p>为了保护数据不受专区故障的影响，可以[复制快照](/docs/infrastructure/FileStorage/replication.html#replicating-data)到其他专区中设置的文件存储器实例。数据只能从主存储器复制到备份存储器。不能将复制的文件存储器实例安装到集群。主存储器发生故障时，可以手动将复制的备份存储器设置为主存储器。然后，可以将其安装到集群。复原主存储器后，可以从备份存储器复原数据。<strong>注</strong>：如果您有 Dedicated 帐户，那么无法将快照复制到其他专区。</p></dd>
 <dt>复制存储器</dt>
 <dd><p>可以在原始存储器实例所在的专区中，[复制文件存储器实例](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage)。复制项采用原始存储器实例在创建该复制项的时间点的数据。与副本不同，复制项用作独立于原始项的存储器实例。要进行复制，请首先[为卷设置快照](/docs/infrastructure/FileStorage/snapshots.html)。<strong>注</strong>：如果您有 Dedicated 帐户，那么必须<a href="/docs/get-support/howtogetsupport.html#getting-customer-support">开具支持凭单</a>。</p></dd>
  <dt>将数据备份到 {{site.data.keyword.cos_full}}</dt>
  <dd><p>可以使用 [**ibm-backup-restore 映像**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter)来加快集群中的备份和复原 pod。此 pod 包含一个脚本，用于对集群中的任何持久性卷申领 (PVC) 运行一次性或定期备份。数据存储在您在某个专区设置的 {{site.data.keyword.cos_full}} 实例中。</p>
  <p>要使数据具有更高可用性，并保护应用程序不受专区故障的影响，请设置第二个 {{site.data.keyword.cos_full}} 实例，并在各个专区之间复制数据。如果需要从 {{site.data.keyword.cos_full}} 实例复原数据，请使用随映像一起提供的复原脚本。</p></dd>
<dt>将数据复制到 pod 和容器，以及从 pod 和容器中复制数据</dt>
<dd><p>可以使用 `kubectl cp` [命令 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) 将文件和目录复制到集群中的 pod 或特定容器，或者从集群中的 pod 或特定容器中复制文件和目录。</p>
<p>开始之前，请[设定 Kubernetes CLI 的目标](cs_cli_install.html#cs_cli_configure)为要使用的集群。如果未使用 <code>-c</code> 来指定容器，那么此命令将使用 pod 中的第一个可用容器。</p>
<p>可以通过以下各种方法来使用此命令：</p>
<ul>
<li>将本地机器中的数据复制到集群中的 pod：<pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>将集群的 pod 中的数据复制到本地机器：<pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>将数据从本地计算机复制到在集群中的 pod 中运行的特定容器：<pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## 存储类参考
{: #storageclass_reference}

### 铜牌级
{: #bronze}

<table>
<caption>文件存储类：铜牌级</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-file-bronze</code></br><code>ibmc-file-retain-bronze</code></td>
</tr>
<tr>
<td>类型</td>
<td>[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>NFS</td>
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
<td>按小时</td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>


### 银牌级
{: #silver}

<table>
<caption>文件存储类：银牌级</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-file-silver</code></br><code>ibmc-file-retain-silver</code></td>
</tr>
<tr>
<td>类型</td>
<td>[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>NFS</td>
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
<td>按小时</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### 金牌级
{: #gold}

<table>
<caption>文件存储类：金牌级</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-file-gold</code></br><code>ibmc-file-retain-gold</code></td>
</tr>
<tr>
<td>类型</td>
<td>[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>NFS</td>
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
<td>按小时</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### 定制
{: #custom}

<table>
<caption>文件存储类：定制</caption>
<thead>
<th>特征</th>
<th>设置</th>
</thead>
<tbody>
<tr>
<td>名称</td>
<td><code>ibmc-file-custom</code></br><code>ibmc-file-retain-custom</code></td>
</tr>
<tr>
<td>类型</td>
<td>[性能 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>文件系统</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS 和大小</td>
<td><p><strong>大小范围（以千兆字节计）/ IOPS 范围（100 的倍数）</strong></p><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>硬盘</td>
<td>IOPS 与千兆字节的比率确定供应的硬盘类型。要确定 IOPS 与千兆字节的比率，请将 IOPS 除以存储器的大小。</br></br>示例：</br>对于 100 IOPS，您选择了 500 Gi 存储器。因此，比率为 0.2 (100 IOPS/500 Gi)。</br></br><strong>每个比率的硬盘类型概述：</strong><ul><li>小于或等于 0.3：SATA</li><li>大于 0.3：SSD</li></ul></td>
</tr>
<tr>
<td>计费</td>
<td>按小时</li></ul></td>
</tr>
<tr>
<td>定价</td>
<td>[定价信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## 样本定制存储类
{: #custom_storageclass}

### 为多专区集群指定专区
{: #multizone_yaml}

以下 `.yaml` 文件定制基于 `ibm-file-silver` 非保留存储类的存储类：`type` 为 `"Endurance"`，`iopsPerGB` 为 `4`，`sizeRange` 为 `"[20-12000]Gi"`，`reclaimPolicy` 设置为 `"Delete"`。专区指定为 `dal12`。可以查看有关 `ibmc` 存储类的先前信息，以帮助您为这些项选择可接受的值。</br>

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-file-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-file
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### 更改缺省 NFS 版本
{: #nfs_version_class}

以下定制存储类基于 [`ibmc-file-bronze` 存储类](#bronze)，并允许您定义要供应的 NFS 版本。例如，要供应 NFS V3.0，请将 `<nfs_version>` 替换为 **3.0**。
```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-file-mount
     #annotations:
     #  storageclass.beta.kubernetes.io/is-default-class: "true"
     labels:
       kubernetes.io/cluster-service: "true"
   provisioner: ibm.io/ibmc-file
   parameters:
     type: "Endurance"
     iopsPerGB: "2"
     sizeRange: "[1-12000]Gi"
     reclaimPolicy: "Delete"
     classVersion: "2"
     mountOptions: nfsvers=<nfs_version>
   ```
{: codeblock}
