---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 保存集群中的数据
{: #storage}
您可以将数据持久存储在 {{site.data.keyword.containerlong}} 中，以在应用程序实例之间共享数据，并保护数据以免在 Kubernetes 集群中的某个组件发生故障时丢失。

## 规划高可用性存储
{: #planning}

在 {{site.data.keyword.containerlong_notm}} 中，可以从多个选项中进行选择，以存储应用程序数据并在集群中的各个 pod 之间共享数据。但是，对于集群中的组件或整个站点发生故障的情况，并非所有存储选项都提供相同级别的持久性和可用性。
{: shortdesc}

### 非持久性数据存储选项
{: #non_persistent}

如果数据不需要持久性存储，那么可以使用非持久性存储选项，以便可以在集群中的某个组件发生故障后恢复数据，或者用于数据无需在应用程序实例间共享的情况。非持久性存储选项还可用于对应用程序组件进行单元测试或试用新功能。
{: shortdesc}

下图显示 {{site.data.keyword.containerlong_notm}} 中可用的非持久性数据存储选项。这些选项可用于免费和标准集群。
<p>
<img src="images/cs_storage_nonpersistent.png" alt="非持久性数据存储选项" width="450" style="width: 450px; border-style: none"/></p>

<table summary="此表显示非持久性存储选项。各行都应从左到右阅读，其中第一列是选项编号，第二列是选项标题，第三列是描述。" style="width: 100%">
<caption>表. 非持久性存储选项</caption>
  <thead>
  <th>选项</th>
  <th>描述</th>
  </thead>
  <tbody>
    <tr>
      <td>1. 在容器或 pod 内</td>
      <td>根据设计，容器和 pod 的生存时间短，并且可能会意外发生故障。但是，您可以将数据写入容器的本地文件系统，以存储容器整个生命周期内的数据。容器内的数据不能与其他容器或 pod 共享，并且在容器崩溃或被除去时会丢失。有关更多信息，请参阅[存储容器中的数据](https://docs.docker.com/storage/)。</td>
    </tr>
  <tr>
    <td>2. 在工作程序节点上
</td>
    <td>每个工作程序节点都设置有主存储器和辅助存储器，这由您为工作程序节点选择的机器类型确定。主存储器用于存储来自操作系统的数据，并且无法使用 [Kubernetes <code>hostPath</code> 卷 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) 对其进行访问。辅助存储器用于将数据存储在 <code>/var/lib/docker</code> 中，这是所有容器数据写入的目录。可以使用 [Kubernetes <code>emptyDir</code> 卷 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) 来访问辅助存储器。<br/><br/>虽然 <code>hostPath</code> 卷用于将文件从工作程序节点文件系统安装到 pod，但 <code>emptyDir</code> 会创建一个空目录，此目录将分配给集群中的 pod。该 pod 中的所有容器可以对该卷执行读写操作。由于卷会分配给一个特定 pod，因此数据无法与副本集内的其他 pod 共享。
<br/><br/><p>对于以下情况，会除去 <code>hostPath</code> 或 <code>emptyDir</code> 卷及其数据：<ul><li>工作程序节点已删除。</li><li>工作程序节点已重新装入或更新。</li><li>集群已删除。</li><li>{{site.data.keyword.Bluemix_notm}} 帐户进入暂挂状态。</li></ul></p><p>此外，在以下情况下，也将除去 <code>emptyDir</code> 卷中的数据：<ul><li>从工作程序节点中永久删除分配的 pod。</li><li>在其他工作程序节点上安排了分配的 pod。</li></ul></p><p><strong>注</strong>：如果 pod 内的容器崩溃，该卷中的数据在工作程序节点上仍可用。</p></td>
    </tr>
    </tbody>
    </table>

### 用于高可用性的持久性数据存储选项
{: persistent}

创建高可用性有状态应用程序时，主要困难是如何在多个位置的多个应用程序实例中持久存储数据，并使数据始终保持同步。对于高可用性数据，您希望确保有一个主数据库及多个实例，这些实例分布在多个数据中心甚或多个区域中，并且会持续复制此主数据库中的数据。集群中的所有实例都必须对此主数据库执行读写操作。如果主数据库的一个实例停止运行，其他实例可以接管工作负载，避免您的应用程序发生停机时间。
{: shortdesc}

下图显示您在 {{site.data.keyword.containerlong_notm}} 中具有的可使数据在标准集群中实现高可用性的选项。适合您的选项取决于以下因素：
  * **拥有的应用程序的类型：**例如，您可能有一个应用程序必须基于文件存储数据，而不是在数据库内存储数据。
  * **数据存储和路由的法律要求：**例如，您可能只能在美国存储和路由数据，而不能使用位于欧洲的服务。
  * **备份和复原选项：**每个存储选项都随附数据备份和复原功能。检查可用的备份和复原选项是否满足灾难恢复计划的需求，例如备份频率或在主数据中心外部存储数据的功能。
  * **全局复制：**为了实现高可用性，您可能希望设置多个存储器实例以分布在全球各数据中心并进行复制。

<br/>
<img src="images/cs_storage_ha.png" alt="持久性存储的高可用性选项"/>

<table summary="此表显示持久性存储选项。各行都应从左到右阅读，其中第一列是选项编号，第二列是选项标题，第三列是描述。">
  <caption>表. 持久性数据存储选项</caption>
  <thead>
  <th>选项</th>
  <th>描述</th>
  </thead>
  <tbody>
  <tr>
  <td>1. NFS 文件存储器</td>
  <td>使用此选项时，可以利用 Kubernetes 持久性卷来持久存储应用程序和容器数据。卷在[基于 NFS 的耐久性和高性能文件存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/details) 上托管，可以用于基于文件存储数据而不是在数据库中存储数据的应用程序。文件存储器在 REST 上进行加密。<p>{{site.data.keyword.containershort_notm}} 会提供预定义存储类，用于定义存储器的大小范围、IOPS、删除策略以及卷的读写许可权。要对基于 NFS 的文件存储器发起请求，必须创建[持久性卷申领 (PVC)](cs_storage.html#create)。提交 PVC 后，{{site.data.keyword.containershort_notm}} 会以动态方式供应在基于 NFS 的文件存储器上托管的持久性卷。可以[将 PVC 作为卷安装到部署](cs_storage.html#app_volume_mount)，以允许容器对该卷执行读写操作。</p><p>持久性卷在工作程序节点所在的数据中心进行供应。您可以跨同一副本集共享数据，也可以与同一集群中的其他部署共享数据。集群位于不同数据中心或区域中时，不能在集群间共享数据。</p><p>缺省情况下，不会自动备份 NFS 存储器。您可以使用提供的[备份和复原机制](cs_storage.html#backup_restore)为集群设置定期备份。容器崩溃或从工作程序节点中除去 pod 时，数据不会除去，而是仍可由安装该卷的其他部署访问。</p><p><strong>注</strong>：持久性 NFS 文件共享存储器按月收费。如果为集群供应了持续存储器，但随后立即将其除去，那么即使只用了很短的时间，您也仍需支付该持久性存储器一个月的费用。</p></td>
  </tr>
  <tr>
    <td>2. Cloud 数据库服务</td>
    <td>使用此选项时，可以利用 {{site.data.keyword.Bluemix_notm}} 数据库云服务（例如 [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant)）来持久存储数据。通过此选项存储的数据可以跨集群、位置和区域进行访问。<p> 您可以选择配置单个数据库实例供所有应用程序访问，或[跨数据中心和复制设置多个实例](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery)以在实例之间实现更高可用性。在 IBM Cloudant NoSQL 数据库中，不会自动备份数据。您可以使用提供的[备份和复原机制](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery)来保护数据不受站点故障影响。</p> <p> 要在集群中使用服务，必须[绑定 {{site.data.keyword.Bluemix_notm}} 服务](cs_integrations.html#adding_app)到集群中的名称空间。将该服务绑定到集群时，将创建 Kubernetes 私钥。Kubernetes 私钥会保存有关该服务的保密信息，例如服务的 URL、用户名和密码。可以将私钥作为私钥卷安装到 pod，并使用该私钥中的凭证来访问该服务。通过将私钥卷安装到其他 pod，还可以在 pod 之间共享数据。容器崩溃或从工作程序节点中除去 pod 时，数据不会除去，而是仍可由安装该私钥卷的其他 pod 访问。<p>大多数 {{site.data.keyword.Bluemix_notm}} 数据库服务都免费对较小的数据量提供磁盘空间，因此您可以测试其功能。
</p></td>
  </tr>
  <tr>
    <td>3. 内部部署数据库</td>
    <td>如果由于法律原因必须在现场存储数据，请[设置 VPN 连接](cs_vpn.html#vpn)以连接到内部部署数据库，并使用数据中心内的现有存储、备份和复制机制。</td>
  </tr>
  </tbody>
  </table>

{: caption="表. 用于在 Kubernetes 集群中进行部署的持久数据存储选项" caption-side="top"}

<br />



## 在集群中使用 NFS 文件共享
{: #existing}

如果在 IBM Cloud Infrastructure (SoftLayer) 帐户中已经有要用于 Kubernetes 的现有 NFS 文件共享，那么可以通过为现有存储器创建持久性卷 (PV) 来使用 NFS 文件共享。
{:shortdesc}

持久性卷 (PV) 是一种 Kubernetes 资源，用于表示在数据中心内供应的实际存储设备。持久性卷提取 IBM Cloud Storage 如何供应特定存储类型的详细信息。要将 PV 安装到集群，必须通过创建持久性卷申领 (PVC) 来为 pod 请求持久性存储器。下图说明 PV 与 PVC 之间的关系。

![创建持久性卷和持久性卷申领](images/cs_cluster_pv_pvc.png)

 如图所示，要使现有 NFS 文件共享可用于 Kubernetes，必须创建具有特定大小和访问方式的 PV，并创建与 PV 规范相匹配的 PVC。如果 PV 和 PVC 相匹配，那么会将它们相互绑定。只有绑定的 PVC 才能由集群用户用于将相应卷安装到部署。此过程称为持久性存储器的静态供应。

开始之前，请确保您拥有可用于创建 PV 的现有 NFS 文件共享。例如，如果先前已[使用 `retain` 存储类策略创建 PVC](#create)，那么可以将现有 NFS 文件共享中的相应保留数据用于此新 PVC。

**注**：持久性存储器的静态供应仅适用于现有 NFS 文件共享。如果没有现有 NFS 文件共享，那么集群用户可以使用[动态供应](cs_storage.html#create)过程来添加 PV。

要创建 PV 和匹配的 PVC，请执行以下步骤。

1.  在 IBM Cloud Infrastructure (SoftLayer) 帐户中，查找要在其中创建 PV 对象的 NFS 文件共享的标识和路径。此外，将文件存储器授权给集群中的子网。此授权可授予您对存储器的集群访问权。
    1.  登录到 IBM Cloud infrastructure (SoftLayer) 帐户。
    2.  单击**存储器**。
    3.  单击**文件存储器**并从**操作**菜单中，选择**授权主机**。
    4.  选择**子网**。
    5.  从下拉列表中，选择工作程序节点连接到的专用 VLAN 子网。要查找工作程序节点的子网，请运行 `bx cs workers <cluster_name>`，并将工作程序节点的`专用 IP` 与下拉列表中找到的子网进行比较。
    6.  单击**提交**。
    6.  单击文件存储器的名称。
    7.  记下**安装点**字段。该字段显示为 `<server>:/<path>`.
2.  为 PV 创建存储器配置文件。在文件存储器**安装点**字段中包含服务器和路径。

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
       path: "/IBM01SEV8491247_0908/data01"
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
    <td>输入要创建的 PV 对象的名称。</td>
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>输入现有 NFS 文件共享的存储器大小。输入的存储器大小必须以千兆字节为单位，例如 20Gi (20 GB) 或 1000Gi (1 TB)，并且大小必须与现有文件共享的大小相匹配。</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>访问方式定义了 PVC 可以安装到工作程序节点的方式。<ul><li>ReadWriteOnce (RWO)：此 PV 只能安装到单个工作程序节点中的部署。安装到此 PV 的部署中的容器可以对该卷执行读写操作。</li><li>ReadOnlyMany (ROX)：此 PV 可以安装到在多个工作程序节点上托管的部署。安装到此 PV 的部署只能对该卷执行读操作。</li><li>ReadWriteMany (RWX)：此 PV 可以安装到在多个工作程序节点上托管的部署。安装到此 PV 的部署可以对该卷执行读写操作。</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>输入 NFS 文件共享服务器标识。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>输入要在其中创建 PV 对象的 NFS 文件共享的路径。</td>
    </tr>
    </tbody></table>

3.  在集群中创建 PV 对象。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    示例

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  验证 PV 是否已创建。

    ```
    kubectl get pv
    ```
    {: pre}

5.  创建另一个配置文件以创建 PVC。为了使 PVC 与先前创建的 PV 对象相匹配，必须为 `storage` 和 `accessMode` 选择相同的值。`storage-class` 字段必须为空。如果其中任何字段与 PV 不匹配，那么会改为自动创建新的 PV。

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

6.  创建 PVC。

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  验证 PVC 是否已创建并与 PV 对象绑定。此过程可能需要几分钟时间。

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


您已成功创建 PV 对象，并将其绑定到 PVC。现在，集群用户可以[将 PVC 安装到其部署](#app_volume_mount)，并开始对 PV 对象执行读写操作。

<br />




## 向应用程序添加 NFS 文件存储器
{: #create}

创建持久性卷申领 (PVC) 以便为集群供应 NFS 文件存储器。然后，将此申领安装到持久性卷 (PV) 可确保即便 pod 崩溃或关闭，数据也仍然可用。
{:shortdesc}

支持 PV 的 NFS 文件存储器由 IBM 建立集群，以便为数据提供高可用性。存储类描述可用的存储产品类型，并在创建 PV 时定义数据保留策略、大小（以千兆字节计）和 IOPS 等方面。



**开始之前**：如果您有防火墙，那么[允许 Egress 访问](cs_firewall.html#pvc)集群所在位置（数据中心）的 IBM Cloud Infrastructure (SoftLayer) IP 范围，以便您可以创建 PVC。

要添加持久性存储器，请执行以下操作：

1.  查看可用的存储类。{{site.data.keyword.containerlong}} 为 NFS 文件存储器提供了预定义的存储类，因此集群管理员不必创建任何存储类。`ibmc-file-bronze` 存储类与 `default` 存储类相同。

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

    **提示：**如果要更改缺省存储类，请运行 `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`，并将 `<storageclass>` 替换为存储类的名称。

2.  决定在删除 PVC 之后是否要保留数据和 NFS 文件共享。
    - 如果要保留数据，请选择 `retain` 存储类。删除 PVC 时，将除去 PV，但 IBM Cloud Infrastructure (SoftLayer) 帐户中仍存在 NFS 文件和数据。稍后，要访问集群中的这些数据，请创建引用现有 [NFS 文件](#existing)的 PVC 和匹配的 PV。
    - 如果要在删除 PVC 时删除数据和 NFS 文件共享，请选择不带 `retain` 的存储类。

3.  **如果使用铜牌级、银牌级或金牌级存储类**：您将获得[耐久性存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/endurance-storage)，用于为每个类定义 IOPS/GB。但是，您可以通过在可用范围内选择大小来确定总 IOPS。您可以在允许的大小范围内选择任意整数的千兆字节大小（例如，20 Gi、256 Gi、11854 Gi）。例如，如果在 4 IOPS/GB 银牌级存储类中选择 1000Gi 文件共享大小，那么您的卷总计有 4000 IOPS。PV 的 IOPS 越高，处理输入和输出操作的速度越快。下表描述每个存储类的 IOPS/千兆字节和大小范围。

    <table>
         <caption>存储类大小范围和 IOPS/千兆字节表</caption>
         <thead>
         <th>存储类</th>
         <th>IOPS/千兆字节</th>
         <th>大小范围（千兆字节）</th>
         </thead>
         <tbody>
         <tr>
         <td>铜牌级（缺省值）</td>
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

    <p>**显示存储类详细信息的示例命令**：</p>

    <pre class="pre">    kubectl describe storageclasses ibmc-file-silver
    </pre>

4.  **如果选择定制存储类**：您将获得[性能存储器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/performance-storage)，并在选择 IOPS 和大小的组合时具有更多控制权。例如，如果为 PVC 选择大小 40 Gi，那么可以选择在 100 - 2000 IOPS 范围内且为 100 倍数的 IOPS。下表显示根据所选大小，您可以选择的 IOPS 范围。

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

    <p>**显示定制存储类详细信息的示例命令**：</p>

    <pre class="pre">    kubectl describe storageclasses ibmc-file-retain-custom 
    </pre>

5.  决定是要按小时还是按月计费。缺省情况下，会按月计费。

6.  创建配置文件以定义 PVC，并将配置保存为 `.yaml` 文件。

    -  **铜牌级、银牌级或金牌级存储类的示例**：
       以下 `.yaml` 文件创建名为 `mypvc` 的申领，其中存储类为 `"ibmc-file-silver"`，计费类型为 `"hourly"`，千兆字节大小为 `24Gi`。 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **定制存储类的示例**：
       以下 `.yaml` 文件创建名为 `mypvc` 的申领，其中存储类为 `ibmc-file-retain-custom`，计费类型为缺省值 `"monthly"`，千兆字节大小为 `45Gi`，IOPS 为 `"300"`。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "monthly"
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
	      <caption>表. 了解 YAML 文件的组成部分</caption>
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
        <td>指定 PV 的存储类：
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze：2 IOPS/GB。</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver：4 IOPS/GB。</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold：10 IOPS/GB。</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom：多个 IOPS 值可用。</li></ul>
          <p>如果未指定存储类，那么会使用缺省存储类来创建 PV。</p><p>**提示：**如果要更改缺省存储类，请运行 <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code>，并将 <code>&lt;storageclass&gt;</code> 替换为存储类的名称。</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>指定用于计算存储器帐单的频率："monthly" 或 "hourly"。缺省值为 "monthly"。</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>输入文件存储器的大小，以千兆字节 (Gi) 为单位。选择在允许大小范围内的整数。</br></br><strong>注：</strong>供应存储器后，即不能更改 NFS 文件共享的大小。因此，请确保指定与要存储的数据量相匹配的大小。</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>此选项仅适用于定制存储类 (`ibmc-file-custom / ibmc-file-retain-custom`)。请指定存储器的总 IOPS，在允许范围内选择 100 的倍数。要查看所有选项，请运行 `kubectl describe storageclasses <storageclass>`。如果选择的 IOPS 不同于列出的 IOPS，那么该 IOPS 会向上舍入。</td>
        </tr>
        </tbody></table>

7.  创建 PVC。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  验证 PVC 是否已创建并与 PV 绑定。此过程可能需要几分钟时间。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    输出示例：

    ```
    Name: mypvc
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

9.  {: #app_volume_mount}要将 PVC 安装到部署，请创建配置 `.yaml` 文件。

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
    <caption>表. 了解 YAML 文件的组成部分</caption>
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
    <td>要使用的映像的名称。要列出 {{site.data.keyword.registryshort_notm}} 帐户中的可用映像，请运行 `bx cr image-list`。</td>
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
    <td>要用作卷的 PVC 的名称。将卷安装到 pod 时，Kubernetes 会识别绑定到该 PVC 的 PV，并支持用户对 PV 执行读写操作。</td>
    </tr>
    </tbody></table>

10.  创建部署并安装 PVC。
     ```
    kubectl apply -f <local_yaml_path>
    ```
     {: pre}

11.  验证是否已成功安装卷。

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




## 为 NFS 文件共享设置备份和复原解决方案
{: #backup_restore}

文件共享会供应到集群所在的位置（数据中心），并由 {{site.data.keyword.IBM_notm}} 进行集群，以提供高可用性。但是，文件共享不会自动进行备份，因此在整个位置发生故障时可能无法进行访问。为了防止数据丢失或损坏，可以设置对 NFS 文件共享定期备份，以便在需要时可用于复原数据。
{: shortdesc}

查看 NFS 文件共享的以下备份和复原选项：

<dl>
  <dt>设置 NFS 文件共享的定期快照</dt>
  <dd>您可以为 NFS 文件共享设置[定期快照](/docs/infrastructure/FileStorage/snapshots.html#working-with-snapshots)，这是 NFS 文件共享的只读映像，用于捕获该卷在某个时间点的状态。快照会存储在同一位置的相同文件共享中。如果用户意外地从卷中除去了重要数据，那么可以通过快照来复原数据。</dd>
  <dt>将快照复制到另一位置（数据中心）中的 NFS 文件共享</dt>
 <dd>为了保护数据不受位置故障的影响，可以[复制快照](/docs/infrastructure/FileStorage/replication.html#working-with-replication)到在其他位置设置的 NFS 文件共享。数据只能从主 NFS 文件共享复制到备份 NFS 文件共享。不能将复制的 NFS 文件共享安装到集群。主 NFS 文件共享失败时，可以手动将备份 NFS 文件共享设置为主文件共享。然后，可以将其安装到集群。复原主 NFS 文件共享后，可以从备份 NFS 文件共享复原数据。</dd>
  <dt>将数据备份到 Object Storage</dt>
  <dd>可以使用 [**ibm-backup-restore 映像**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter)来加快集群中的备份和复原 pod。此 pod 包含一个脚本，用于对集群中的任何持久性卷申领 (PVC) 运行一次性或定期备份。数据存储在您在某个位置设置的 {{site.data.keyword.objectstoragefull}} 实例中。要使数据具有更高可用性，并保护应用程序不受位置故障的影响，请设置第二个 {{site.data.keyword.objectstoragefull}} 实例，并在各个位置之间复制数据。如果需要从 {{site.data.keyword.objectstoragefull}} 实例复原数据，请使用随映像一起提供的复原脚本。</dd>
  </dl>

## 添加对 NFS 文件存储器的非 root 用户访问权
{: #nonroot}

缺省情况下，非 root 用户在支持 NFS 的存储器的卷安装路径上没有写许可权。一些公共映像（例如，Jenkins 和 Nexus3）会在 Dockerfile 中指定拥有安装路径的非 root 用户。通过此 Dockerfile 创建容器时，由于安装路径上非 root 用户的许可权不足，创建容器会失败。要授予写许可权，可以修改 Dockerfile，以在更改安装路径许可权之前将非 root 用户临时添加到 root 用户组，或者使用 init 容器。
{:shortdesc}

如果要使用 Helm 图表以您希望在 NFS 文件共享上具有写许可权的非 root 用户身份部署映像，请首先编辑 Helm 部署以使用 init 容器。
{:tip}



在部署中包含 [init 容器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) 时，可以向 Dockerfile 中指定的非 root 用户授予对指向 NFS 文件共享的容器内卷安装路径的写许可权。init 容器会在应用程序容器启动之前启动。init 容器在容器内创建卷安装路径，将安装路径更改为由正确的（非 root）用户拥有，然后关闭。随后，应用程序容器将启动，这包括必须写入安装路径的非 root 用户。由于该路径已由非 root 用户拥有，因此写入安装路径成功。如果您不想使用 init 容器，那么可以修改 Dockerfile 以添加对 NFS 文件存储器的非 root 用户访问权。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

1.  打开应用程序的 Dockerfile，并从要向其授予卷安装路径的作者许可权的用户获取用户标识 (UID) 和组标识 (GID)。在来自 Jenkins Dockerfile 的示例中，信息为：
    - UID：`1000`
    - GID：`1000`

    **示例**：

    ```
    FROM openjdk:8-jdk

    RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

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

2.  通过创建持久性卷申领 (PVC) 将持久性存储器添加到应用程序。此示例使用 `ibmc-file-bronze` 存储类。要查看可用的存储类，请运行 `kubectl get storageclasses`。

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
    kubectl apply -f <local_file_path>
    ```
    {: pre}

4.  在部署 `.yaml` 文件中，添加 init 容器。包含您先前检索到的 UID 和 GID。

    ```
    initContainers:
    - name: initContainer # 或者，可以替换为任何名称
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # 将 UID 和 GID 替换为 Dockerfile 中的值
      volumeMounts:
      - name: volume # 或者，可以替换为任何名称
        mountPath: /mount # 必须与 args 行中的安装路径相匹配
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
    kubectl apply -f <local_yaml_path>
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


