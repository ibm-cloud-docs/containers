---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 设置集群
{: #clusters}

设计集群设置以实现最高可用性和容量。
{:shortdesc}


## 集群配置规划
{: #planning_clusters}

使用标准集群来提高应用程序可用性。在多个工作程序节点和集群之间分发设置时，用户不太可能会遇到停机时间。内置功能（例如负载均衡和隔离）可在主机、网络或应用程序发生潜在故障时更快恢复。
{:shortdesc}

查看以下潜在的集群设置（按可用性程度从低到高排序）：

![集群的高可用性阶段](images/cs_cluster_ha_roadmap.png)

1.  一个集群具有多个工作程序节点
2.  在同一区域的不同位置运行的两个集群，每个集群具有多个工作程序节点
3.  在不同区域运行的两个集群，每个集群具有多个工作程序节点

使用以下技术提高集群的可用性：

<dl>
<dt>跨工作程序节点分布应用程序</dt>
<dd>允许开发者在每个集群的多个工作程序节点之间将其应用程序分布在容器中。三个工作程序节点中每个节点的应用程序实例允许有一个工作程序节点发生停机，而不会中断应用程序使用。在通过 [{{site.data.keyword.Bluemix_notm}} GUI](cs_clusters.html#clusters_ui) 或 [CLI](cs_clusters.html#clusters_cli) 创建集群时，可以指定要包含的工作程序节点数。Kubernetes 限制了可在集群中使用的最大工作程序节点数，因此请记住[工作程序节点和 pod 配额 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/cluster-large/)。<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>跨集群散布应用程序</dt>
<dd>创建多个集群，每个集群具有多个工作程序节点。如果一个集群发生停机，用户仍可以访问还部署在其他集群中的应用程序。<p>集群 1：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>集群 2：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>跨不同区域的集群散布应用程序</dt>
<dd>跨不同区域的集群散布应用程序时，可以允许基于用户所在的区域进行负载均衡。如果一个区域中的集群、硬件甚至整个位置当机，那么流量会路由到另一个位置内所部署的容器。<p><strong>重要信息</strong>：配置定制域后，可使用以下命令来创建集群。</p>
<p>位置 1：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>位置 2：</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## 工作程序节点配置规划
{: #planning_worker_nodes}

Kubernetes 集群由工作程序节点组成，并由 Kubernetes 主节点机进行集中监视和管理。集群管理员决定如何设置工作程序节点的集群，以确保集群用户具备在集群中部署和运行应用程序所需的所有资源。
{:shortdesc}

创建标准集群时，会在 IBM Cloud infrastructure (SoftLayer) 中代表您订购工作程序节点，然后在 {{site.data.keyword.Bluemix_notm}} 中对其进行设置。为每个工作程序节点分配唯一的工作程序节点标识和域名，在创建集群后，不得更改该标识和域名。根据选择的硬件隔离级别，可以将工作程序节点设置为共享或专用节点。您还可以选择是希望工作程序节点连接到公用 VLAN 和专用 VLAN，还是仅连接到专用 VLAN。每个工作程序节点都供应有特定机器类型，用于确定部署到该工作程序节点的容器可用的 vCPU 数、内存量和磁盘空间量。
Kubernetes 限制了在一个集群中可以拥有的最大工作程序节点数。有关更多信息，请查看[工作程序节点和 pod 配额 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/cluster-large/)。


### 工作程序节点的硬件
{: #shared_dedicated_node}

每个工作程序节点都会设置为物理硬件上的虚拟机。在 {{site.data.keyword.Bluemix_notm}} 中创建标准集群时，必须选择是希望底层硬件由多个 {{site.data.keyword.IBM_notm}} 客户共享（多租户）还是仅供您专用（单租户）。
{:shortdesc}

在多租户设置中，物理资源（如 CPU 和内存）在部署到同一物理硬件的所有虚拟机之间共享。要确保每个虚拟机都能独立运行，虚拟机监视器（也称为系统管理程序）会将物理资源分段成隔离的实体，并将其作为专用资源分配给虚拟机（系统管理程序隔离）。

在单租户设置中，所有物理资源都仅供您专用。您可以将多个工作程序节点作为虚拟机部署在同一物理主机上。与多租户设置类似，系统管理程序也会确保每个工作程序节点在可用物理资源中获得应有的份额。

共享节点通常比专用节点更便宜，因为底层硬件的开销由多个客户分担。但是，在决定是使用共享还是专用节点时，可能需要咨询您的法律部门，以讨论应用程序环境所需的基础架构隔离和合规性级别。

创建免费集群时，工作程序节点会自动作为 IBM Cloud infrastructure (SoftLayer) 帐户中的共享节点进行供应。

### 工作程序节点的 VLAN 连接
{: #worker_vlan_connection}

创建集群时，每个集群都会自动通过 IBM Cloud infrastructure (SoftLayer) 帐户连接到 VLAN。VLAN 会将一组工作程序节点和 pod 视为连接到同一物理连线那样进行配置。
专用 VLAN 用于确定在集群创建期间分配给工作程序节点的专用 IP 地址，公用 VLAN 用于确定在集群创建期间分配给工作程序节点的公共 IP 地址。

对于免费集群，缺省情况下集群的工作程序节点会在集群创建期间连接到 IBM 拥有的公用 VLAN 和专用 VLAN。对于标准集群，可以将工作程序节点连接到公用 VLAN 和专用 VLAN，也可以仅连接到专用 VLAN。如果要将工作程序节点仅连接到专用 VLAN，那么可以在集群创建期间指定现有专用 VLAN 的标识。但是，您还必须配置备用解决方案，以在工作程序节点与 Kubernetes 主节点之间启用安全连接。例如，您可以配置 Vyatta 以将流量从专用 VLAN 工作程序节点传递到 Kubernetes 主节点。有关更多信息，请参阅 [IBM Cloud infrastructure (SoftLayer) 文档](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta)中的“设置定制 Vyatta 以安全地将工作程序节点连接到 Kubernetes 主节点”。

### 工作程序节点内存限制
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} 会对每个工作程序节点设置内存限制。在工作程序节点上运行的 pod 超过此内存限制时，将除去 pod。在 Kubernetes 中，此限制称为[硬逐出阈值 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds)。
{:shortdesc}

如果需要频繁除去 pod，请向集群添加更多工作程序节点，或者对 pod 设置[资源限制 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container)。

每种机器类型都有不同的内存容量。如果工作程序节点上的可用内存小于允许的最小阈值，那么 Kubernetes 将立即除去 pod。如果有工作程序节点可用，那么 pod 会重新安排到其他工作程序节点上。

|工作程序节点内存容量|工作程序节点的最小内存阈值|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB| 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

要查看工作程序节点上使用的内存量，请运行 [kubectl top node ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top)。



<br />



## 使用 GUI 创建集群
{: #clusters_ui}

Kubernetes 集群是组织成网络的一组工作程序节点。集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。要部署应用程序，必须先创建集群，并在该集群中设置工作程序节点的定义。
{:shortdesc}

要创建集群，请执行以下操作：
1. 在目录中，选择 **Kubernetes 集群**。
2. 选择要在其中部署集群的区域。
3. 选择集群套餐的类型。您可以选择**免费**或**现买现付**。使用“现买现付”套餐，可以向标准集群提供诸如多个工作程序节点等功能，以获取高可用性环境。
4. 配置集群详细信息。
    1. 为集群提供名称，选择 Kubernetes 版本，然后选择要在其中部署集群的位置。要获得最佳性能，请选择实际离您最近的位置。请记住，如果选择您所在国家或地区以外的位置，那么您可能需要法律授权，才能将数据实际存储到国外。
    2. 选择机器类型并指定所需的工作程序节点数。机器类型用于定义在每个工作程序节点中设置并可供容器使用的虚拟 CPU 量、内存量和磁盘空间量。
    3. 从 IBM Cloud infrastructure (SoftLayer) 帐户中选择公用和专用 VLAN。两个 VLAN 在工作程序节点之间进行通信，但公用 VLAN 还与 IBM 管理的 Kubernetes 主节点进行通信。可以对多个集群使用相同的 VLAN。
**注**：如果选择不选择公用 VLAN，那么必须配置备用解决方案。有关更多信息，请参阅[工作程序节点的 VLAN 连接](#worker_vlan_connection)。
    4. 选择硬件的类型。
        - **专用**：工作程序节点在专用于您帐户的基础架构上托管。您的资源完全隔离。
        - **共享**：基础架构资源（例如，系统管理程序和物理硬件）在您与其他 IBM 客户之间分发，但每个工作程序节点只能由您访问。虽然此选项更便宜，并且在大多数情况下足够了，但您可能希望使用公司策略来验证您的性能和基础架构需求。
    5. 缺省情况下，已选择**加密本地磁盘**。如果选择清除该复选框，那么主机的 Docker 数据不会加密。请[了解有关加密的更多信息](cs_secure.html#encrypted_disks)。
4. 单击**创建集群**。您可以在**工作程序节点**选项卡中查看工作程序节点部署的进度。完成部署后，您可以在**概述**选项卡中看到集群已就绪。**注**：为每个工作程序节点分配了唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。


**接下来要做什么？**

集群启动并开始运行后，可查看以下任务：

-   [安装 CLI 以开始使用集群。](cs_cli_install.html#cs_cli_install)
-   [在集群中部署应用程序。](cs_app.html#app_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中设置自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry/index.html)
- 如果您有防火墙，那么可能需要[打开必要的端口](cs_firewall.html#firewall)才能使用 `bx`、`kubectl` 或 `calicotl` 命令，以允许来自集群的出站流量，或允许联网服务的入站流量。

<br />


## 使用 CLI 创建集群
{: #clusters_cli}

集群是组织成网络的一组工作程序节点。集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。要部署应用程序，必须先创建集群，并在该集群中设置工作程序节点的定义。
{:shortdesc}

要创建集群，请执行以下操作：
1.  安装 {{site.data.keyword.Bluemix_notm}} CLI 和 [{{site.data.keyword.containershort_notm}} 插件](cs_cli_install.html#cs_cli_install)。
2.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。

    ```
    bx login
    ```
    {: pre}

    **注**：如果您有联合标识，请使用 `bx login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。

3. 如果有多个 {{site.data.keyword.Bluemix_notm}} 帐户，请选择要在其中创建 Kubernetes 集群的帐户。

4.  如果要在先前选择的 {{site.data.keyword.Bluemix_notm}} 区域以外的区域中创建或访问 Kubernetes 集群，请运行 `bx cs region-set`。

6.  创建集群。
    1.  查看可用的位置。显示的位置取决于您登录到的 {{site.data.keyword.containershort_notm}} 区域。

        ```
        bx cs locations
        ```
        {: pre}

        CLI 输出与[容器区域的位置](cs_regions.html#locations)相匹配。

    2.  选择位置并查看该位置中可用的机器类型。机器类型指定可供每个工作程序节点使用的虚拟计算资源。


        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  检查 IBM Cloud infrastructure (SoftLayer) 中是否已存在此帐户的公用和专用 VLAN。

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10 
        ```
        {: screen}

        如果公用和专用 VLAN 已经存在，请记下匹配的路由器。专用 VLAN 路由器始终以 `bcr`（后端路由器）开头，而公用 VLAN 路由器始终以 `fcr`（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。在示例输出中，任一专用 VLAN 都可以与任一公用 VLAN 一起使用，因为路由器全都包含 `02a.dal10`。

    4.  运行 `cluster-create` 命令。您可以选择免费集群（包含设置有 2 个 vCPU 和 4 GB 内存的一个工作程序节点）或标准集群（可以包含您在 IBM Cloud infrastructure (SoftLayer) 帐户中选择的任意数量的工作程序节点）。创建标准集群时，缺省情况下会对工作程序节点磁盘进行加密，其硬件由多个 IBM 客户共享，并且会按使用小时数对其进行计费。</br>标准集群的示例：

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        免费集群的示例：

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>表. 了解 <code>bx cs cluster-create</code> 命令的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>此命令在 {{site.data.keyword.Bluemix_notm}} 组织中创建集群。</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>将 <em>&lt;location&gt;</em> 替换为要在其中创建集群的 {{site.data.keyword.Bluemix_notm}} 位置标识。[可用位置](cs_regions.html#locations)取决于您登录到的 {{site.data.keyword.containershort_notm}} 区域。</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>如果要创建标准集群，请选择机器类型。机器类型指定可供每个工作程序节点使用的虚拟计算资源。有关更多信息，请查看[比较 {{site.data.keyword.containershort_notm}} 的免费和标准集群](cs_why.html#cluster_types)。对于免费集群，无需定义机器类型。</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值对于标准集群是可选的，且不可用于免费集群。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>对于免费集群，无需定义公用 VLAN。免费集群会自动连接到 IBM 拥有的公用 VLAN。</li>
          <li>对于标准集群，如果已经在 IBM Cloud infrastructure (SoftLayer) 帐户中为该位置设置了公用 VLAN，请输入该公用 VLAN 的标识。如果您的帐户中没有公用和专用 VLAN，请勿指定此选项。{{site.data.keyword.containershort_notm}} 会自动为您创建公用 VLAN。<br/><br/>
          <strong>注</strong>：专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>对于免费集群，无需定义专用 VLAN。免费集群会自动连接到 IBM 拥有的专用 VLAN。</li><li>对于标准集群，如果已经在 IBM Cloud infrastructure (SoftLayer) 帐户中为该位置设置了专用 VLAN，请输入该专用 VLAN 的标识。如果您的帐户中没有公用和专用 VLAN，请勿指定此选项。{{site.data.keyword.containershort_notm}} 会自动为您创建公用 VLAN。<br/><br/><strong>注</strong>：专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>将 <em>&lt;name&gt;</em> 替换为集群的名称。</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>要包含在集群中的工作程序节点的数目。如果未指定 <code>--workers</code> 选项，那么会创建 1 个工作程序节点。</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>集群主节点的 Kubernetes 版本。此值是可选的。除非指定，否则会使用受支持 Kubernetes 版本的缺省值来创建集群。要查看可用版本，请运行 <code>bx cs kube-versions</code>。</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_secure.html#encrypted_disks)。如果要禁用加密，请包括此选项。</td>
        </tr>
        </tbody></table>

7.  验证是否请求了创建集群。

    ```
    bx cs clusters
    ```
    {: pre}

    **注**：可能需要最长 15 分钟时间，才能订购好工作程序节点计算机，并且在您的帐户中设置并供应集群。

    当完成集群供应时，集群的状态会更改为**已部署**。

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  检查工作程序节点的状态。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    当工作程序节点已准备就绪时，状态会更改为 **normal**，而阶段状态为 **Ready**。节点阶段状态为 **Ready** 时，可以访问集群。

    **注**：为每个工作程序节点分配了唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. 将所创建的集群设置为此会话的上下文。每次使用集群时都完成这些配置步骤。
    1.  获取命令以设置环境变量并下载 Kubernetes 配置文件。

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        配置文件下载完成后，会显示一个命令，您可以使用该命令将本地 Kubernetes 配置文件的路径设置为环境变量。

        OS X 的示例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  复制并粘贴终端中显示的命令，以设置 `KUBECONFIG` 环境变量。
    3.  验证是否已正确设置 `KUBECONFIG` 环境变量。

        OS X 的示例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        输出：

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

10. 使用缺省端口 `8001` 启动 Kubernetes 仪表板。
    1.  使用缺省端口号设置代理。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 浏览器中打开以下 URL 以查看 Kubernetes 仪表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**接下来要做什么？**

-   [在集群中部署应用程序。](cs_app.html#app_cli)
-   [使用 `kubectl` 命令行管理集群。![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中设置自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry/index.html)
- 如果您有防火墙，那么可能需要[打开必要的端口](cs_firewall.html#firewall)才能使用 `bx`、`kubectl` 或 `calicotl` 命令，以允许来自集群的出站流量，或允许联网服务的入站流量。

<br />


## 集群状态
{: #states}

您可以通过运行 `bx cs clusters` 命令并找到**状态**字段，查看当前集群状态。集群状态提供了有关集群可用性和容量的信息以及可能已发生的潜在问题。
{:shortdesc}

|集群状态|原因|
|-------------|------|

|紧急|无法访问 Kubernetes 主节点，或者集群中的所有工作程序节点都已停止运行。<ol><li>列出集群中的工作程序节点。<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>获取每个工作程序节点的详细信息。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>查看<strong>状态</strong>和<strong>阶段状态</strong>字段，以查找工作程序节点为什么会关闭的根本问题。<ul><li>如果工作程序节点状态显示 <strong>Provision_failed</strong>，说明您可能没有必需的许可权来从 IBM Cloud infrastructure (SoftLayer) 产品服务组合供应工作程序节点。要查找必需的许可权，请参阅[配置对 IBM Cloud infrastructure (SoftLayer) 产品服务组合的访问权以创建标准 Kubernetes 集群](cs_infrastructure.html#unify_accounts)。</li><li>如果工作程序节点状态显示<strong>紧急</strong>，并且阶段状态显示<strong>未就绪</strong>，那么您的工作程序节点可能无法连接到 IBM Cloud infrastructure (SoftLayer)。首先，通过运行 <code>bx cs worker-reboot --hard CLUSTER WORKER</code> 来启动故障诊断。如果该命令未成功，请运行 <code>bx cs worker reload CLUSTER WORKER</code>。</li><li>如果工作程序节点状态显示 <strong>Critical</strong>，并且阶段状态显示 <strong>Out of disk</strong>，说明工作程序节点的容量不足。您可以减少工作程序节点上的工作负载，或者向集群添加一个工作程序节点以帮助均衡工作负载。</li><li>如果工作程序节点状态显示 <strong>Critical</strong>，并且阶段状态显示 <strong>Unknown</strong>，说明 Kubernetes 主节点不可用。请通过开具 [{{site.data.keyword.Bluemix_notm}} 支持凭单](/docs/get-support/howtogetsupport.html#using-avatar)来联系 {{site.data.keyword.Bluemix_notm}} 支持。</li></ul></li></ol>|

|正在部署|Kubernetes 主节点尚未完全部署。无法访问集群。|
|正常|集群中的所有工作程序节点都已启动并正在运行。您可以访问集群，并将应用程序部署到集群。|
|暂挂|Kubernetes 主节点已部署。正在供应工作程序节点，这些节点在集群中尚不可用。您可以访问集群，但无法将应用程序部署到集群。|

|警告|集群中至少有一个工作程序节点不可用，但其他工作程序节点可用，并且可以接管工作负载。<ol><li>列出集群中的工作程序节点，并记下显示 <strong>Warning</strong> 状态的工作程序节点的标识。<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>获取工作程序节点的详细信息。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>查看<strong>状态</strong>、<strong>阶段状态</strong>和<strong>详细信息</strong>字段，以找到导致工作程序节点停止运行的根本问题。</li><li>如果工作程序节点几乎达到内存或磁盘空间限制，请减少工作程序节点上的工作负载，或者向集群添加一个工作程序节点以帮助均衡工作负载。</li></ol>|

{: caption="表. 集群状态" caption-side="top"}

<br />


## 除去集群
{: #remove}

使用集群完毕后，可以将该集群除去，使其不再耗用资源。
{:shortdesc}

对于使用现买现付帐户创建的免费和标准集群，不再需要这些集群时，必须由用户手动将其除去。

删除集群时，还会删除该集群上的资源，包括容器、pod、绑定的服务和私钥。如果在删除集群时未删除存储器，那么可以通过 {{site.data.keyword.Bluemix_notm}} GUI 中的 IBM Cloud infrastructure (SoftLayer) 仪表板删除存储器。受每月记帐周期的影响，无法在一个月的最后一天删除持久性卷申领。如果在一个月的最后一天删除持续性卷申领，那么删除操作会保持暂挂，直到下个月开始再执行。

**警告**：不会在持久存储器中创建集群或数据的备份。删除集群是永久性的，无法撤销。

-   通过 {{site.data.keyword.Bluemix_notm}} GUI
    1.  选择集群，然后单击**更多操作...** 菜单中的**删除**。
-   通过 {{site.data.keyword.Bluemix_notm}} CLI
    1.  列出可用的集群。


        ```
        bx cs clusters
        ```
        {: pre}

    2.  删除集群。

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  遵循提示并选择是否删除集群资源。

除去集群时，可以选择除去与之关联的可移植子网和持久性存储器：
- 子网用于将可移植公共 IP 地址分配给 LoadBalancer 服务或 Ingress 应用程序负载均衡器。如果保留子网，那么可以在新集群中复用这些子网，也可以日后从 IBM Cloud infrastructure (SoftLayer) 产品服务组合中手动删除这些子网。
- 如果使用[现有文件共享](cs_storage.html#existing)创建了持久性卷申领，那么在删除集群时无法删除该文件共享。必须日后从 IBM Cloud infrastructure (SoftLayer) 产品服务组合中手动删除此文件共享。
- 持久性存储器为您的数据提供了高可用性。如果将其删除，那么无法恢复这些数据。
