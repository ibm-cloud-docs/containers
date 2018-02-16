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


# 使用持久性卷存储器保存数据
{: #planning}

根据设计，容器的生命周期很短。但是，如下图所示，您可以在多个选项之间进行选择，以便在发生容器故障转移时持久存储数据以及在容器之间共享数据。
{:shortdesc}

**注**：如果您具有防火墙，那么[允许 egress 访问](cs_firewall.html#pvc)集群所在位置的 IBM Cloud infrastructure (SoftLayer) IP 范围（数据中心），以便您可以创建持久性卷申领。


![用于在 Kubernetes 集群中进行部署的持久存储选项](images/cs_planning_apps_storage.png)

|选项|描述|
|------|-----------|
|选项 1：使用 `/emptyDir` 通过工作程序节点上的可用磁盘空间来持久存储数据。<p>此功能可用于 Lite 和标准集群。</p>|使用此选项，可以在分配给 pod 的工作程序节点的磁盘空间上创建空卷。该 pod 中的容器可以对该卷执行读写操作。由于卷会分配给一个特定 pod，因此数据无法与副本集内的其他 pod 共享。
<p>从工作程序节点中永久删除分配的 pod 时，会除去 `/emptyDir` 卷及其数据。</p><p>**注**：如果 pod 内的容器崩溃，该卷中的数据在工作程序节点上仍可用。</p><p>有关更多信息，请参阅 [Kubernetes 卷 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/storage/volumes/)。</p>|
|选项 2：创建持久性卷申领以便为部署供应基于 NFS 的持久性存储器<p>此功能仅可用于标准集群。</p>|<p>使用此选项时，可以通过持久性卷来持久存储应用程序和容器数据。卷在 [Endurance 和 Performance 基于 NFS 的文件存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/details) 上托管。文件存储器将进行静态加密，您可以创建已存储数据的副本。</p> <p>可以创建[持久性卷申领](cs_storage.html)，以发起对基于 NFS 的文件存储器的请求。{{site.data.keyword.containershort_notm}} 会提供预定义存储类，用于定义存储器的大小范围、IOPS、删除策略以及卷的读写许可权。创建持久性卷申领时，可以在这些存储类中进行选择。提交持久性卷申领后，{{site.data.keyword.containershort_notm}} 会以动态方式供应在基于 NFS 的文件存储器上托管的持久性卷。可以[将持久性卷申领作为卷安装到部署](cs_storage.html#create)，以允许容器对该卷执行读写操作。持久性卷可以跨同一副本集共享，也可以与同一集群中的其他部署共享。</p><p>容器崩溃或从工作程序节点中除去 pod 时，数据不会除去，而是仍可由安装该卷的其他部署访问。持久性卷申领在持久性存储器上进行托管，但没有备份。如果需要备份数据，请创建手动备份。</p><p>**注**：持久性 NFS 文件共享存储器按月收费。如果为集群供应了持续存储器，但随后立即将其除去，那么即使只用了很短的时间，您也仍需支付该持久性存储器一个月的费用。</p>|
|选项 3：将 {{site.data.keyword.Bluemix_notm}} 数据库服务绑定到 pod<p>此功能可用于 Lite 和标准集群。</p>|使用此选项，可以利用 {{site.data.keyword.Bluemix_notm}} 数据库云服务，持久存储和访问数据。将 {{site.data.keyword.Bluemix_notm}} 服务绑定到集群中的名称空间时，将创建 Kubernetes 私钥。Kubernetes 私钥会保存有关该服务的保密信息，例如服务的 URL、用户名和密码。可以将私钥作为私钥卷安装到 pod，并使用该私钥中的凭证来访问该服务。通过将私钥卷安装到其他 pod，还可以在 pod 之间共享数据。<p>容器崩溃或从工作程序节点中除去 pod 时，数据不会除去，而是仍可由安装该私钥卷的其他 pod 访问。</p><p>大多数 {{site.data.keyword.Bluemix_notm}} 数据库服务都免费对较小的数据量提供磁盘空间，因此您可以测试其功能。
</p><p>有关如何将 {{site.data.keyword.Bluemix_notm}} 服务绑定到 pod 的更多信息，请参阅[在 {{site.data.keyword.containershort_notm}} 中为应用程序添加 {{site.data.keyword.Bluemix_notm}} 服务](cs_integrations.html#adding_app)。</p>|
{: caption="表. 用于在 Kubernetes 集群中进行部署的持久数据存储选项" caption-side="top"}

<br />



## 在集群中使用 NFS 文件共享
{: #existing}

如果在 IBM Cloud infrastructure (SoftLayer) 帐户中已经有要用于 Kubernetes 的现有 NFS 文件共享，那么可以通过在现有 NFS 文件共享上创建持久性卷来使用 NFS 文件共享。持久性卷是一块实际硬件，用作 Kubernetes 集群资源，并可以由集群用户使用。
{:shortdesc}

Kubernetes 会区分持久性卷（代表实际硬件）和持久性卷申领（通常由集群用户发起的对存储器的请求）。下图说明持久性卷与持久性卷申领之间的关系。

![创建持久性卷和持久性卷申领](images/cs_cluster_pv_pvc.png)

 如图所示，要使现有 NFS 文件共享可用于 Kubernetes，必须创建具有特定大小和访问方式的持久性卷，并创建与持久性卷规范相匹配的持久性卷申领。如果持久性卷和持久性卷申领相匹配，那么会将它们相互绑定。只有绑定的持久性卷申领才能由集群用户用于将相应卷安装到部署。此过程称为持久性存储器的静态供应。

开始之前，请确保您拥有可用于创建持久性卷的现有 NFS 文件共享。

**注**：持久性存储器的静态供应仅适用于现有 NFS 文件共享。如果没有现有 NFS 文件共享，那么集群用户可以使用[动态供应](cs_storage.html#create)过程来添加持久性卷。

要创建持久性卷及匹配的持久性卷申领，请执行以下步骤。

1.  在 IBM Cloud infrastructure (SoftLayer) 帐户中，查找要在其中创建持久性卷对象的 NFS 文件共享的标识和路径。此外，将文件存储器授权给集群中的子网。此授权可授予您对存储器的集群访问权。
    1.  登录到 IBM Cloud infrastructure (SoftLayer) 帐户。
    2.  单击**存储器**。
    3.  单击**文件存储器**并从**操作**菜单中，选择**授权主机**。
    4.  单击**子网**。授权后，子网上的每个工作程序节点都可以访问文件存储器。
    5.  从菜单中选择集群的公共 VLAN 的子网，然后单击**提交**。如果需要查找该子网，请运行 `bx cs cluster-get <cluster_name> --showResources`。
    6.  单击文件存储器的名称。
    7.  记下**安装点**字段。该字段显示为 `<server>:/<path>`。
2.  为持久性卷创建存储器配置文件。在文件存储器**安装点**字段中包含服务器和路径。

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
    <caption>表. 了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>输入要创建的持久性卷对象的名称。</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>输入现有 NFS 文件共享的存储器大小。输入的存储器大小必须以千兆字节为单位，例如 20Gi (20 GB) 或 1000Gi (1 TB)，并且大小必须与现有文件共享的大小相匹配。</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>访问方式定义了持久性卷申领可以安装到工作程序节点的方式。<ul><li>ReadWriteOnce (RWO)：此持久性卷只能安装到单个工作程序节点中的部署。安装到此持久性卷的部署可以对该卷执行读写操作。</li><li>ReadOnlyMany (ROX)：此持久性卷可以安装到在多个工作程序节点上托管的部署。安装到此持久性卷的部署只能对该卷执行读操作。</li><li>ReadWriteMany (RWX)：此持久性卷可以安装到在多个工作程序节点上托管的部署。安装到此持久性卷的部署可以对该卷执行读写操作。</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>输入 NFS 文件共享服务器标识。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>输入要在其中创建持久性卷对象的 NFS 文件共享的路径。</td>
    </tr>
    </tbody></table>

3.  在集群中创建持久性卷对象。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    示例

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  验证持久性卷是否已创建。

    ```
    kubectl get pv
    ```
    {: pre}

5.  创建另一个配置文件以创建持久性卷申领。为了使持久性卷申领与先前创建的持久性卷对象相匹配，必须为 `storage` 和 `accessMode` 选择相同的值。`storage-class` 字段必须为空。如果其中任何字段与持久性卷不匹配，那么会改为自动创建新的持久性卷。


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

6.  创建持久性卷申领。

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  验证持久性卷申领是否已创建并绑定到持久性卷对象。此过程可能需要几分钟时间。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    输出类似于以下内容。

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


您已成功创建持久性卷对象，并将其绑定到持久性卷申领。现在，集群用户可以[安装持久性卷申领](#app_volume_mount)至其部署，并开始对持久性卷对象执行读写操作。

<br />


## 为应用程序创建持久性存储器 
{: #create}

创建持久性卷申领 (pvc) 以便为集群供应 NFS 文件存储器。然后，将此申领安装到部署可确保即便 pod 崩溃或关闭，数据也仍然可用。
{:shortdesc}

支持持久性卷的 NFS 文件存储器由 IBM 建立集群，以便为数据提供高可用性。

1.  查看可用的存储类。{{site.data.keyword.containerlong}} 提供了八个预定义的存储类，因此集群管理员不必创建任何存储类。`ibmc-file-bronze` 存储类与 `default` 存储类相同。

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

2.  决定在删除 pvc 之后是否要保存数据和 NFS 文件共享。如果要保留数据，请选择 `retain` 存储类。如果要在删除 pvc 时删除数据和文件共享，请选择不带 `retain` 的存储类。

3.  查看存储类的 IOPS 和可用存储器大小。

    - 铜牌级、银牌级和金牌级存储类使用[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)，并且每个类每 GB 都具有单个已定义的 IOPS。总 IOPS 取决于存储器的大小。例如，每 GB 为 4 IOPS 的 1000Gi pvc 总共为 4000 IOPS。

      ```
    kubectl describe storageclasses ibmc-file-silver
    ```
      {: pre}

      **parameters** 字段提供与存储类关联的 IOPS/GB 以及可用大小（以千兆字节为单位）。

      ```
    Parameters: iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
      {: screen}

    - 定制存储类使用[性能存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)，并且具有针对总 IOPS 和大小的离散选项。

      ```
    kubectl describe storageclasses ibmc-file-retain-custom 
    ```
      {: pre}

      **parameters** 字段提供与存储类关联的 IOPS 以及可用大小（以千兆字节为单位）。例如，40Gi pvc 可以选择 100 - 2000 IOPS 范围内的 100 的倍数的 IOPS。

      ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
      {: screen}

4.  创建配置文件以定义持久性卷申领，并将配置保存为 `.yaml` 文件。

    铜牌级、银牌级和金牌级类的示例：

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

    定制类的示例：

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
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>输入持久性卷申领的名称。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>指定持久性卷的存储类：<ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze：2 IOPS/GB。</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver：4 IOPS/GB。</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold：10 IOPS/GB。</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom：多个 IOPS 值可用。

    </li> 如果未指定存储类，那么会使用铜牌级存储类来创建持久性卷。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>如果选择的大小不同于列出的大小，那么该大小会向上舍入。如果选择的大小大于最大大小，那么会对该大小向下舍入。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>此选项仅适用于 ibmc-file-custom / ibmc-file-retain-custom。指定存储器的总 IOPS。运行 `kubectl describe storageclasses ibmc-file-custom` 以查看所有选项。如果选择的 IOPS 不同于列出的 IOPS，那么该 IOPS 会向上舍入。</td>
    </tr>
    </tbody></table>

5.  创建持久性卷申领。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  验证持久性卷申领是否已创建并绑定到持久性卷。此过程可能需要几分钟时间。

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    输出类似于以下内容。

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

6.  {: #app_volume_mount}要将持久性卷申领安装到部署，请创建配置文件。将配置保存为 `.yaml` 文件。

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
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>部署的名称。</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>部署的标签。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>在部署中安装卷的目录的绝对路径。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>要安装到部署中的卷的名称。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>要安装到部署中的卷的名称。通常此名称与 <code>volumeMounts/name</code> 相同。</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>要用作卷的持久性卷申领的名称。将卷安装到部署时，Kubernetes 会识别绑定到该持久性卷申领的持久性卷，并支持用户对持久性卷执行读写操作。</td>
    </tr>
    </tbody></table>

8.  创建部署并安装持久性卷申领。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  验证是否已成功安装卷。

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




## 添加持久性存储器的非 root 用户访问权
{: #nonroot}

非 root 用户在支持 NFS 的存储器的卷安装路径上没有写许可权。要授予写许可权，您必须编辑映像的 Dockerfile，以在具有正确许可权的安装路径上创建目录。
{:shortdesc}

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

如果您使用需要对卷的写许可权的非 root 用户来设计应用程序，那么您必须将以下过程添加到 Dockerfile 和入口点脚本中：

-   创建非 root 用户。
-   临时向 root 组添加用户。
-   在具有正确用户许可权的卷安装路径中创建目录。

对于 {{site.data.keyword.containershort_notm}}，卷安装路径的缺省所有者是所有者 `nobody`。对于 NFS 存储器，如果在 pod 中本地不存在所有者，那么将创建 `nobody` 用户。卷设置为识别容器中的 root 用户；对于某些应用程序，该用户是容器中的唯一用户。但是，许多应用程序指定除了 `nobody` 之外的非 root 用户来写入容器安装路径。某些应用程序指定卷必须由 root 用户拥有。通常，出于安全考虑，应用程序不会使用 root 用户。但是，如果应用程序需要 root 用户，那么可以联系 [{{site.data.keyword.Bluemix_notm}} 支持](/docs/support/index.html#contacting-support)以获取帮助。


1.  在本地目录中创建 Dockerfile。此示例 Dockerfile 创建名为 `myguest` 的非 root 用户。

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  在与 Dockerfile 相同的本地文件夹中，创建入口点脚本。此示例入口点脚本将 `/mnt/myvol` 指定为卷安装路径。


    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  登录到 {{site.data.keyword.registryshort_notm}}。

    ```
    bx cr login
    ```
    {: pre}

4.  在本地构建映像。记住将 _&lt;my_namespace&gt;_ 替换为专用映像注册表的名称空间。如果您需要查找名称空间，请运行 `bx cr namespace-get`。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  将映像推送到 {{site.data.keyword.registryshort_notm}} 中的名称空间。

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  通过创建配置 `.yaml` 文件来创建持久性卷申领。此示例使用的是较低性能的存储类。运行 `kubectl get storageclasses` 可查看可用的存储类。

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

7.  创建持久性卷申领。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  创建配置文件以安装卷，并从非根映像运行 pod。卷安装路径 `/mnt/myvol` 与 Dockerfile 中指定的安装路径匹配。将配置保存为 `.yaml` 文件。

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

9.  创建 pod 并将持久性卷申领安装到该 pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. 验证卷是否已成功安装到 pod。

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    安装点会列在 **Volume Mounts** 字段中，卷会列在 **Volumes** 字段中。

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

11. 在 pod 开始运行之后，登录到该 pod。

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. 查看卷安装路径的许可权。

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

    此输出显示 root 用户在卷安装路径 `mnt/myvol/` 上具有读、写和执行许可权，但非 root 用户 myguest 对 `mnt/myvol/mydata` 文件夹具有读和写许可权。由于这些更新的许可权，非 root 用户现在可以向持久性卷写入数据。


