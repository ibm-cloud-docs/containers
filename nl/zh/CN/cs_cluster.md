---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 设置集群
{: #cs_cluster}

设计集群设置以实现最高可用性和容量。
{:shortdesc}

下图包含常用的集群配置，按可用性从低到高排列。

![集群的高可用性阶段](images/cs_cluster_ha_roadmap.png)

如图所示，跨多个工作程序节点部署应用程序会提高应用程序的可用性。跨多个集群部署应用程序能更进一步提高其可用性。为了实现最高可用性，请跨不同区域中的集群部署应用程序。[有关更多详细信息，请查看高可用性集群配置的选项](cs_planning.html#cs_planning_cluster_config)。

<br />


## 使用 GUI 创建集群
{: #cs_cluster_ui}

Kubernetes 集群是组织成网络的一组工作程序节点。集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。要部署应用程序，必须先创建集群，并在该集群中设置工作程序节点的定义。
{:shortdesc}

要创建集群，请执行以下操作：
1. 在目录中，选择 **Kubernetes 集群**。
2. 选择集群套餐的类型。您可以选择 **Lite** 或**现买现付**。使用“现买现付”套餐，可以向标准集群提供诸如多个工作程序节点等功能，以获取高可用性环境。
3. 配置集群详细信息。
    1. 为集群提供名称，选择 Kubernetes 版本，然后选择要部署的位置。请选择实际离您最近的位置，以获得最佳性能。
请记住，如果您选择所在国家或地区以外的位置，那么您可能需要法律授权，才能将数据实际存储到国外。
    2. 选择机器类型并指定所需的工作程序节点数。机器类型用于定义在每个工作程序节点中设置并可供容器使用的虚拟 CPU 和内存量。
        - 微机器类型指示最小的选项。
        - 均衡机器具有分配给每个 CPU 的相等内存量，从而优化性能。
        - 名称中包含 `encrypted` 的机器类型将加密主机的 Docker 数据。存储所有容器数据的 `/var/lib/docker` 目录将使用 LUKS 加密进行加密。
    3. 从 IBM Cloud infrastructure (SoftLayer) 帐户中选择公用和专用 VLAN。两个 VLAN 在工作程序节点之间进行通信，但公用 VLAN 还与 IBM 管理的 Kubernetes 主节点进行通信。可以对多个集群使用相同的 VLAN。
**注**：如果选择不选择公用 VLAN，那么必须配置备用解决方案。
    4. 选择硬件的类型。共享是足以适合大多数情况的选项。
        - **专用**：确保完全隔离您的物理资源。
        - **共享**：允许将您的物理资源存储在与其他 IBM 客户相同的硬件上。
        - 工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_security.html#cs_security_worker)。如果要禁用加密功能，请清除**加密本地磁盘**复选框。
4. 单击**创建集群**。您可以在**工作程序节点**选项卡中查看工作程序节点部署的进度。完成部署后，您可以在**概述**选项卡中看到集群已就绪。**注**：为每个工作程序节点分配了唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。


**接下来要做什么？**

集群启动并开始运行后，可查看以下任务：

-   [安装 CLI 以开始使用集群。](cs_cli_install.html#cs_cli_install)
-   [在集群中部署应用程序。](cs_apps.html#cs_apps_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中设置自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry/index.html)
- 如果您有防火墙，那么可能需要[打开必要的端口](cs_security.html#opening_ports)才能使用 `bx`、`kubectl` 或 `calicotl` 命令，以允许来自集群的出站流量，或允许联网服务的入站流量。

<br />


## 使用 CLI 创建集群
{: #cs_cluster_cli}

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

    4.  运行 `cluster-create` 命令。您可以选择 Lite 集群（包含设置有 2 个 vCPU 和 4 GB 内存的一个工作程序节点）或标准集群（可以包含您在 IBM Cloud infrastructure (SoftLayer) 帐户中选择的任意数量的工作程序节点）。创建标准集群时，缺省情况下会对工作程序节点磁盘进行加密，其硬件由多个 IBM 客户共享，并且会按使用小时数对其进行计费。</br>标准集群的示例：

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch>
        ```
        {: pre}

        Lite 集群的示例：

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>表 1. 了解 <code>bx cs cluster-create</code> 命令的组成部分</caption>
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
        <td>如果要创建标准集群，请选择机器类型。机器类型指定可供每个工作程序节点使用的虚拟计算资源。有关更多信息，请查看[比较 {{site.data.keyword.containershort_notm}} 的 Lite 和标准集群](cs_planning.html#cs_planning_cluster_type)。对于 Lite 集群，无需定义机器类型。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>对于 Lite 集群，无需定义公用 VLAN。Lite 集群会自动连接到 IBM 拥有的公用 VLAN。</li>
          <li>对于标准集群，如果已经在 IBM Cloud infrastructure (SoftLayer) 帐户中为该位置设置了公用 VLAN，请输入该公用 VLAN 的标识。如果您的帐户中没有公用和专用 VLAN，请勿指定此选项。{{site.data.keyword.containershort_notm}} 会自动为您创建公用 VLAN。<br/><br/>
          <strong>注</strong>：专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>对于 Lite 集群，无需定义专用 VLAN。Lite 集群会自动连接到 IBM 拥有的专用 VLAN。</li><li>对于标准集群，如果已经在 IBM Cloud infrastructure (SoftLayer) 帐户中为该位置设置了专用 VLAN，请输入该专用 VLAN 的标识。如果您的帐户中没有公用和专用 VLAN，请勿指定此选项。{{site.data.keyword.containershort_notm}} 会自动为您创建公用 VLAN。<br/><br/><strong>注</strong>：专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。这两个前缀后面的数字和字母组合必须匹配，才可在创建集群时使用这些 VLAN。</li></ul></td>
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
        <td>工作程序节点缺省情况下具有磁盘加密功能：[了解更多](cs_security.html#cs_security_worker)。如果要禁用加密，请包括此选项。</td>
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

-   [在集群中部署应用程序。](cs_apps.html#cs_apps_cli)
-   [使用 `kubectl` 命令行管理集群。![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中设置自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry/index.html)
- 如果您有防火墙，那么可能需要[打开必要的端口](cs_security.html#opening_ports)才能使用 `bx`、`kubectl` 或 `calicotl` 命令，以允许来自集群的出站流量，或允许联网服务的入站流量。

<br />


## 使用专用和公共映像注册表
{: #cs_apps_images}

Docker 映像是所创建的每一个容器的基础。映像通过 Dockerfile 进行创建，此文件包含用于构建映像的指令。Dockerfile 可能会在其单独存储的指令中引用构建工件，例如应用程序、应用程序配置及其依赖项。映像通常会存储在可以公共访问的注册表（公共注册表）中，或者存储在设置为仅供一小组用户访问的注册表（专用注册表）中。
{:shortdesc}

查看以下选项以找到有关如何设置映像注册表以及如何通过注册表使用映像的信息。

-   [访问 {{site.data.keyword.registryshort_notm}} 中的名称空间以使用 IBM 提供的映像和您自己的专用 Docker 映像](#bx_registry_default)。
-   [访问 Docker Hub 中的公共映像](#dockerhub)。
-   [访问存储在其他专用注册表中的专用映像](#private_registry)。

### 访问 {{site.data.keyword.registryshort_notm}} 中的名称空间以使用 IBM 提供的映像和自己的专用 Docker 映像
{: #bx_registry_default}

可以通过 IBM 提供的公共映像将容器部署到集群，也可以通过存储在 {{site.data.keyword.registryshort_notm}} 的名称空间中的专用映像来部署。

开始之前：

1. [在 {{site.data.keyword.Bluemix_notm}} Public 或 {{site.data.keyword.Bluemix_dedicated_notm}} 的 {{site.data.keyword.registryshort_notm}} 中设置名称空间并将映像推送到此名称空间](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2. [创建集群](#cs_cluster_cli)。
3. [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

创建集群时，会自动为该集群创建不到期的注册表令牌。此令牌用于授予对 {{site.data.keyword.registryshort_notm}} 中设置的任一名称空间的只读访问权，以便您可以使用 IBM 提供的公共 Docker 映像和您自己的专用 Docker 映像。令牌必须存储在 Kubernetes `imagePullSecret` 中，才能在部署容器化应用程序时供 Kubernetes 集群访问。创建集群时，{{site.data.keyword.containershort_notm}} 会自动将此令牌存储在 Kubernetes `imagePullSecret` 中。`imagePullSecret` 会添加到缺省 Kubernetes 名称空间、该名称空间的 ServiceAccount 中的缺省私钥列表以及 kube-system 名称空间。

**注**：使用此初始设置时，可以通过 {{site.data.keyword.Bluemix_notm}} 帐户的名称空间中可用的任何映像，将容器部署到集群的**缺省**名称空间。如果要将容器部署到集群的其他名称空间，或者如果要使用存储在其他 {{site.data.keyword.Bluemix_notm}} 区域或其他 {{site.data.keyword.Bluemix_notm}} 帐户中的映像，您必须[为集群创建自己的 imagePullSecret](#bx_registry_other)。

要将容器部署到集群的**缺省**名称空间，请创建配置文件。

1.  创建名为 `mydeployment.yaml` 的部署配置文件。
2.  定义部署以及要在 {{site.data.keyword.registryshort_notm}} 的名称空间中使用的映像。

    要使用 {{site.data.keyword.registryshort_notm}} 的名称空间中的专用映像，请使用以下内容：


    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **提示**：要检索名称空间信息，请运行 `bx cr namespace-list`。

3.  在集群中创建部署。

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **提示：**您还可以部署现有配置文件，如 IBM 提供的其中一个公共映像。此示例使用美国南部区域中的 **ibmliberty** 映像。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### 将映像部署到其他 Kubernetes 名称空间或者访问其他 {{site.data.keyword.Bluemix_notm}} 区域和帐户中的映像
{: #bx_registry_other}

通过创建您自己的 imagePullSecret，可以将容器部署到其他 Kubernetes 名称空间，使用存储在其他 {{site.data.keyword.Bluemix_notm}} 区域或帐户中的映像，或者使用存储在 {{site.data.keyword.Bluemix_dedicated_notm}} 中的映像。

开始之前：

1.  [在 {{site.data.keyword.Bluemix_notm}} Public 或 {{site.data.keyword.Bluemix_dedicated_notm}} 的 {{site.data.keyword.registryshort_notm}} 中设置名称空间并将映像推送到此名称空间](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2.  [创建集群](#cs_cluster_cli)。
3.  [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

要创建自己的 imagePullSecret，请执行以下操作：

**注**：ImagePullSecret 仅对于创建它们时所用于的 Kubernetes 名称空间有效。对要部署容器的每个名称空间，重复这些步骤。来自 [DockerHub](#dockerhub) 的映像不需要 ImagePullSecrets。

1.  如果还没有令牌，请[为要访问的注册表创建令牌](/docs/services/Registry/registry_tokens.html#registry_tokens_create)。
2.  列出您的 {{site.data.keyword.Bluemix_notm}} 帐户中的令牌。

    ```
    bx cr token-list
    ```
    {: pre}

3.  记下要使用的令牌标识。
4.  检索令牌的值。将 <em>&lt;token_id&gt;</em> 替换为在上一步中检索到的令牌的标识。


    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    令牌值会显示在 CLI 输出的**令牌**字段中。

5.  创建 Kubernetes 私钥以用于存储令牌信息。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表 3. 了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必需。要使用私钥并将容器部署到的集群的 Kubernetes 名称空间。运行 <code>kubectl get namespaces</code> 可列出集群中的所有名称空间。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必需。要用于 imagePullSecret 的名称。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必需。在其中设置名称空间的映像注册表的 URL。<ul><li>对于在美国南部和美国东部设置的名称空间：registry.ng.bluemix.net</li><li>对于在英国南部设置的名称空间：registry.eu-gb.bluemix.net</li><li>对于在欧洲中部（法兰克福）设置的名称空间：registry.eu-de.bluemix.net</li><li>对于在澳大利亚（悉尼）设置的名称空间：registry.au-syd.bluemix.net</li><li>对于在 {{site.data.keyword.Bluemix_dedicated_notm}} 中设置的名称空间：registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必需。用于登录到专用注册表的用户名。对于 {{site.data.keyword.registryshort_notm}}，用户名设置为 <code>token</code>。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必需。先前检索到的注册表令牌的值。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必需。如果您有 Docker 电子邮件地址，请输入该地址。如果没有，请输入虚构的电子邮件地址，例如 a@b.c。此电子邮件对于创建 Kubernetes 私钥是必需的，但在创建后不会再使用此电子邮件。</td>
    </tr>
    </tbody></table>

6.  验证私钥是否已成功创建。将 <em>&lt;kubernetes_namespace&gt;</em> 替换为在其中创建 imagePullSecret 的名称空间的名称。


    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  创建引用 imagePullSecret 的 pod。
    1.  创建名为 `mypod.yaml` 的 pod 配置文件。
    2.  定义要用于访问专用 {{site.data.keyword.Bluemix_notm}} 注册表的 pod 和 imagePullSecret。

        来自名称空间的专用映像：

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        {{site.data.keyword.Bluemix_notm}} 公共映像：

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表 4. 了解 YAML 文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>要部署到集群的容器的名称。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>存储映像的名称空间。要列出可用名称空间，请运行 `bx cr namespace-list`。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>要使用的映像的名称。要列出 {{site.data.keyword.Bluemix_notm}} 帐户中的可用映像，请运行 `bx cr image-list`。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>要使用的映像的版本。如果未指定标记，那么缺省情况下会使用标记为 <strong>latest</strong> 的映像。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>先前创建的 imagePullSecret 的名称。</td>
        </tr>
        </tbody></table>

   3.  保存更改。
   4.  在集群中创建部署。

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


### 访问 Docker Hub 中的公共映像
{: #dockerhub}

可以使用存储在 Docker Hub 中的任何公共映像将容器部署到集群，而无需任何其他配置。

开始之前：

1.  [创建集群](#cs_cluster_cli)。
2.  [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

创建部署配置文件。

1.  创建名为 `mydeployment.yaml` 的配置文件。
2.  定义部署以及 Docker Hub 中要使用的公共映像。以下配置文件使用 Docker Hub 中可用的公用 NGINX 映像。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  在集群中创建部署。

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **提示：**或者，部署现有配置文件。以下示例使用相同的公共 NGINX 映像，但会将其直接应用于集群。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### 访问存储在其他专用注册表中的专用映像
{: #private_registry}

如果您已经拥有要使用的专用注册表，那么必须将相应的注册表凭证存储在 Kubernetes imagePullSecret 中，并在配置文件中引用此私钥。

开始之前：

1.  [创建集群](#cs_cluster_cli)。
2.  [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

要创建 imagePullSecret，请执行以下操作：

**注**：ImagePullSecret 对于创建它们时所用于的 Kubernetes 名称空间有效。对要通过专用 {{site.data.keyword.Bluemix_notm}} 注册表中的映像来部署容器的每个名称空间，重复这些步骤。

1.  创建 Kubernetes 私钥以用于存储专用注册表凭证。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表 5. 了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必需。要使用私钥并将容器部署到的集群的 Kubernetes 名称空间。运行 <code>kubectl get namespaces</code> 可列出集群中的所有名称空间。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必需。要用于 imagePullSecret 的名称。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必需。要在其中存储专用映像的注册表的 URL。</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必需。用于登录到专用注册表的用户名。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必需。先前检索到的注册表令牌的值。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必需。如果您有 Docker 电子邮件地址，请输入该地址。如果没有，请输入虚构的电子邮件地址，例如 a@b.c。此电子邮件对于创建 Kubernetes 私钥是必需的，但在创建后不会再使用此电子邮件。</td>
    </tr>
    </tbody></table>

2.  验证私钥是否已成功创建。将 <em>&lt;kubernetes_namespace&gt;</em> 替换为在其中创建 imagePullSecret 的名称空间的名称。


    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  创建引用 imagePullSecret 的 pod。
    1.  创建名为 `mypod.yaml` 的 pod 配置文件。
    2.  定义要用于访问专用 {{site.data.keyword.Bluemix_notm}} 注册表的 pod 和 imagePullSecret。要使用专用注册表中的专用映像，请使用以下内容：



        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表 6. 了解 YAML 文件的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>要创建的 pod 的名称。</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>要部署到集群的容器的名称。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>专用注册表中要使用的映像的完整路径。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>要使用的映像的版本。如果未指定标记，那么缺省情况下会使用标记为 <strong>latest</strong> 的映像。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>先前创建的 imagePullSecret 的名称。</td>
        </tr>
        </tbody></table>

  3.  保存更改。
  4.  在集群中创建部署。

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## 将 {{site.data.keyword.Bluemix_notm}} 服务添加到集群
{: #cs_cluster_service}

将现有 {{site.data.keyword.Bluemix_notm}} 服务实例添加到集群，以支持集群用户在将应用程序部署到集群时，访问和使用 {{site.data.keyword.Bluemix_notm}} 服务。
{:shortdesc}

开始之前：

1. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。
2. [请求 {{site.data.keyword.Bluemix_notm}} 服务的实例](/docs/manageapps/reqnsi.html#req_instance)。**注：**要在华盛顿位置创建服务的实例，必须使用 CLI。

**注：**
<ul><ul>
<li>只能添加支持服务密钥的 {{site.data.keyword.Bluemix_notm}} 服务。如果服务不支持服务密钥，请参阅[使外部应用程序能够使用 {{site.data.keyword.Bluemix_notm}} 服务](/docs/manageapps/reqnsi.html#req_instance)。</li>
<li>必须完全部署集群和工作程序节点后，才能添加服务。</li>
</ul></ul>


要添加服务，请执行以下操作：
2.  列出可用的 {{site.data.keyword.Bluemix_notm}} 服务。

    ```
    bx service list
    ```
    {: pre}

    示例 CLI 输出：

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  记下要添加到集群的服务实例的**名称**。
4.  确定要用于添加服务的集群名称空间。在以下选项之间进行选择。

    -   列出现有名称空间，并选择要使用的名称空间。


        ```
        kubectl get namespaces
        ```
        {: pre}

    -   在集群中创建新的名称空间。

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  将服务添加到集群。

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    服务成功添加到集群后，将创建集群私钥，用于保存服务实例的凭证。示例 CLI 输出：

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  验证是否已在集群名称空间中创建私钥。

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


要在集群中部署的 pod 中使用服务，集群用户可以[将 Kubernetes 私钥作为私钥卷安装到 pod](cs_apps.html#cs_apps_service)，以访问 {{site.data.keyword.Bluemix_notm}} 服务的服务凭证。

<br />



## 管理集群访问权
{: #cs_cluster_user}

每个使用 {{site.data.keyword.containershort_notm}} 的用户都必须分配有服务特点用户角色的组合，以确定用户可以执行的操作。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 访问策略</dt>
<dd>在 Identity and Access Management 中，{{site.data.keyword.containershort_notm}} 访问策略用于确定可以在集群上执行的集群管理操作，例如创建或除去集群，以及添加或除去多余的工作程序节点。这些策略必须与基础架构策略一起设置。</dd>
<dt>基础架构访问策略</dt>
<dd>在 Identity and Access Management 中，基础架构访问策略允许从 {{site.data.keyword.containershort_notm}} 用户界面或 CLI 请求的操作在 IBM Cloud infrastructure (SoftLayer) 中完成。这些策略必须与 {{site.data.keyword.containershort_notm}} 访问策略一起设置。[了解有关可用基础架构角色的更多信息](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>资源组</dt>
<dd>资源组用于将 {{site.data.keyword.Bluemix_notm}} 服务组织成分组，以便您可以一次性快速为用户分配对多个资源的访问权。[了解如何使用资源组来管理用户](/docs/admin/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry 角色</dt>
<dd>在 Identity and Access Management 中，必须为每个用户分配 Cloud Foundry 用户角色。此角色将确定用户可以在 {{site.data.keyword.Bluemix_notm}} 帐户上执行的操作，例如邀请其他用户或查看配额使用情况。[了解有关可用 Cloud Foundry 角色的更多信息](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC 角色</dt>
<dd>分配了 {{site.data.keyword.containershort_notm}} 访问策略的每个用户都将自动分配有 Kubernetes RBAC 角色。在 Kubernetes 中，RBAC 角色将确定可以在集群内部的 Kubernetes 资源上执行的操作。只会为缺省名称空间设置 RBAC 角色。集群管理员可以为集群中的其他名称空间添加 RBAC 角色。有关更多信息，请参阅 Kubernetes 文档中的[使用 RBAC 授权 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</dd>
</dl>

在此部分中：

-   [访问策略和许可权](#access_ov)
-   [向 {{site.data.keyword.Bluemix_notm}} 帐户添加用户](#add_users)
-   [定制用户的基础架构许可权](#infrastructure_permissions)

### 访问策略和许可权
{: #access_ov}

查看可以授予 {{site.data.keyword.Bluemix_notm}} 帐户中用户的访问策略和许可权。“操作员”和“编辑者”角色具有不同的许可权。例如，如果希望用户添加工作程序节点和绑定服务，那么必须为用户同时分配“操作员”和“编辑者”角色。

|{{site.data.keyword.containershort_notm}} 访问策略|集群管理许可权|Kubernetes 资源许可权|
|-------------|------------------------------|-------------------------------|
|管理员|此角色会继承此帐户中所有集群的“编辑者”、“操作员”和“查看者”角色的许可权。<br/><br/>为所有当前服务实例设置时：<ul><li>创建 Lite 或标准集群</li><li>为 {{site.data.keyword.Bluemix_notm}} 帐户设置凭证以访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合</li><li>除去集群</li><li>为此帐户中的其他现有用户分配和更改 {{site.data.keyword.containershort_notm}} 访问策略。</li></ul><p>为特定集群标识设置时：<ul><li>除去特定集群。</li></ul></p>相应的基础架构访问策略：超级用户<br/><br/><b>注</b>：要创建资源（如机器、VLAN 和子网），用户需要**超级用户**基础架构角色。|<ul><li>RBAC 角色：集群管理员</li><li>对每个名称空间中资源的读/写访问权</li><li>在名称空间内创建角色</li><li>访问 Kubbernees 仪表板</li><li>创建使应用程序公共可用的 Ingress 资源</li></ul>|
|操作员|<ul><li>向集群添加其他工作程序节点</li><li>从集群中除去工作程序节点</li><li>重新引导工作程序节点</li><li>重新装入工作程序节点</li><li>向集群添加子网</li></ul><p>相应的基础架构访问策略：基本用户</p>|<ul><li>RBAC 角色：管理员</li><li>具有对缺省名称空间内部资源的读/写访问权，但对名称空间本身没有读/写访问权</li><li>在名称空间内创建角色</li></ul>|
|编辑者<br/><br/><b>提示</b>：将此角色用于应用程序开发者。|<ul><li>将 {{site.data.keyword.Bluemix_notm}} 服务绑定到集群。</li><li>取消 {{site.data.keyword.Bluemix_notm}} 服务与集群的绑定。</li><li>创建 Webhook。</li></ul><p>相应的基础架构访问策略：基本用户|<ul><li>RBAC 角色：编辑</li><li>对缺省名称空间内部资源的读/写访问权</li></ul></p>|
|查看者|<ul><li>列出集群</li><li>查看集群的详细信息</li></ul><p>相应的基础架构访问策略：仅查看</p>|<ul><li>RBAC 角色：查看</li><li>对缺省名称空间内部资源的读访问权</li><li>对 Kubernetes 私钥无读访问权</li></ul>|
{: caption="表 7. {{site.data.keyword.containershort_notm}} 访问策略和许可权" caption-side="top"}

|Cloud Foundry 访问策略|帐户管理许可权|
|-------------|------------------------------|
|组织角色：管理员|<ul><li>将其他用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户</li></ul>| |
|空间角色：开发者|<ul><li>创建 {{site.data.keyword.Bluemix_notm}} 服务实例</li><li>将 {{site.data.keyword.Bluemix_notm}} 服务实例绑定到集群</li></ul>| 
{: caption="表 8. Cloud Foundry 访问策略和许可权" caption-side="top"}


### 向 {{site.data.keyword.Bluemix_notm}} 帐户添加用户
{: #add_users}

可以将其他用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户以授予对集群的访问权。

开始之前，请验证您是否已分配有对 {{site.data.keyword.Bluemix_notm}} 帐户的“管理员”Cloud Foundry 角色。

1.  [向帐户添加用户](../iam/iamuserinv.html#iamuserinv).
2.  在**访问权**部分中，展开**服务**。
3.  分配 {{site.data.keyword.containershort_notm}} 访问角色。从**分配访问权**下拉列表中，决定是要仅授予对 {{site.data.keyword.containershort_notm}} 帐户（**资源**）的访问权，还是授予对帐户内各种资源的集合（**资源组**）的访问权。
  -  对于**资源**：
      1. 从**服务**下拉列表中，选择 **{{site.data.keyword.containershort_notm}}**。
      2. 从**区域**下拉列表中，选择要邀请用户加入的区域。
      3. 从**服务实例**下拉列表中，选择要邀请用户加入的集群。要找到特定集群的标识，请运行 `bx cs clusters`。
      4. 在**选择角色**部分中，选择角色。要查找每个角色的受支持操作列表，请参阅[访问策略和许可权](#access_ov)。
  - 对于**资源组**：
      1. 从**资源组**下拉列表中，选择包含帐户的 {{site.data.keyword.containershort_notm}} 资源许可权的资源组。
      2. 从**分配对资源组的访问权**下拉列表中，选择角色。要查找每个角色的受支持操作列表，请参阅[访问策略和许可权](#access_ov)。
4. [可选：分配基础架构角色](/docs/iam/mnginfra.html#managing-infrastructure-access)。
5. [可选：分配 Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。
5. 单击**邀请用户**。



### 定制用户的基础架构许可权
{: #infrastructure_permissions}

在 Identity and Access Management 中设置基础架构策略时，会向用户授予与角色相关联的许可权。要定制这些许可权，必须登录到 IBM Cloud infrastructure (SoftLayer) 并调整许可权。
{: #view_access}

例如，基本用户可以重新引导工作程序节点，但它们无法重新装入工作程序节点。在不提供人员超级用户许可权的情况下，您可以调整 IBM Cloud infrastructure (SoftLayer) 许可权，并添加许可权以运行重新装入命令。

1.  登录到 IBM Cloud infrastructure (SoftLayer) 帐户。
2.  选择要更新的用户概要文件。
3.  在**门户网站许可权**中，定制用户访问权。例如，要添加重新装入许可权，请在**设备**选项卡中选择**发出操作系统重新装入并启动急救内核**。
9.  保存更改。

<br />



## 更新 Kubernetes 主节点
{: #cs_cluster_update}

Kubernetes 定期更新[主版本、次版本和补丁版本](cs_versions.html#version_types)，这会影响到集群。更新集群的过程分为两个步骤。首先，必须更新 Kubernetes 主节点，然后才能更新每个工作程序节点。

缺省情况下，您最多只能跨 Kubernetes 主节点的两个次版本进行更新。例如，如果当前主节点的版本是 1.5，而您要更新到 1.8，那么必须先更新到 1.7。可以强制更新继续，但跨两个以上的次版本更新可能会导致意外结果。

**注意**：请遵循更新指示信息并使用测试集群来解决更新期间潜在的应用程序停止运行和中断情况。不能将集群回滚到先前版本。

在进行_主要_或_次要_更新时，请完成以下步骤。

1. 查看 [Kubernetes 更改](cs_versions.html)，并对任何更新标记为_在更新主节点之前更新_。
2. 使用 GUI 或运行 [CLI 命令](cs_cli_reference.html#cs_cluster_update)来更新 Kubernetes 主节点。当您更新 Kubernetes 主节点时，主节点将关闭约 5 到 10 分钟。在更新期间，您无法访问或更改集群。但是，不会修改集群用户已部署的工作程序节点、应用程序和资源，并继续运行。
3. 确认更新已完成。在 {{site.data.keyword.Bluemix_notm}} 仪表板上查看 Kubernetes 版本，或运行 `bx cs clusters`。

Kubernetes 主节点更新完成后，可以更新工作程序节点。

<br />


## 更新工作程序节点
{: #cs_cluster_worker_update}

IBM 自动将补丁应用于 Kubernetes 主节点时，对于主要和次要更新，必须显式更新工作程序节点。工作程序节点的版本不能高于 Kubernetes 主节点的版本。

**注意**：更新工作程序节点可能会导致应用程序和服务产生停机时间：
- 如果数据未存储在 pod 外，那么将删除数据。
- 在部署中使用 [replicas ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) 以在可用节点上重新安排 pod。

更新生产级别集群：
- 为了帮助避免应用程序产生停机时间，更新过程在更新期间会阻止在工作程序节点上安排 pod。有关更多信息，请参阅 [`kubectl drain` ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain)。
- 使用测试集群验证工作负载和交付过程是否不受更新影响。您无法将工作程序节点回滚到先前版本。
- 生产级别集群应该能够在工作程序节点发生故障时生存。如果您的集群不存在，请在更新集群之前先添加工作程序节点。
- 请求多个工作程序节点升级时，将执行滚动更新。最多可以同时升级集群中工作程序节点总数的 20%。升级过程会等待一个工作程序节点完成升级后，再开始另一个工作程序的升级。


1. 安装与 Kubernetes 主节点的 Kubernetes 版本相匹配的 [`kubectl cli` ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 版本。

2. 落实在 [Kubernetes 更改](cs_versions.html)中标记为_在主节点后更新_的任何更改。

3. 更新工作程序节点：
  * 要从 {{site.data.keyword.Bluemix_notm}} 仪表板进行更新，请浏览到集群的 `Worker Nodes` 部分，然后单击 `Update Worker`。
  * 要获取工作程序节点标识，请运行 `bx cs workers <cluster_name_or_id>`. 如果选择多个工作程序节点，那么一次更新一个工作程序节点。

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. 确认更新是否已完成：
  * 在 {{site.data.keyword.Bluemix_notm}}“仪表板”上查看 Kubernetes 版本，或运行 `bx cs workers <cluster_name_or_id>`.
  * 通过运行 `kubectl get nodes`，查看工作程序节点的 Kubernetes 版本。
  * 在某些情况下，较旧的集群可能会在更新后列出具有 **NotReady** 状态的重复工作程序节点。要除去重复项，请参阅[故障诊断](cs_troubleshoot.html#cs_duplicate_nodes)。

完成更新后，请执行以下操作：
  - 对其他集群重复更新过程。
  - 通知在集群中工作的开发者将其 `kubectl` CLI 更新到 Kubernetes 主节点的版本。
  - 如果 Kubernetes 仪表板未显示利用率图形，请[删除 `kube-dashboard` pod](cs_troubleshoot.html#cs_dashboard_graphs)。

<br />


## 向集群添加子网
{: #cs_cluster_subnet}

通过向集群添加子网，更改可用的可移植公共或专用 IP 地址的池。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以通过将网络子网添加到集群来为 Kubernetes 服务添加稳定的可移植 IP。在这种情况下，不会将子网与 netmasking 一起使用，以在一个或多个集群间创建连接。相反，子网用于从可用于访问该服务的集群，为服务提供永久固定 IP。

创建标准集群时，{{site.data.keyword.containershort_notm}} 会自动供应具有 5 个 公共 IP 地址的可移植公共子网和具有 5 个专用 IP 地址的可移植专用子网。可移植公共和专用 IP 地址是静态的，不会在除去工作程序节点甚至集群时更改。对于每个子网，其中一个可移植公共 IP 地址和其中一个可移植专用 IP 地址供可用于公开集群中多个应用程序的[应用程序负载均衡器](cs_apps.html#cs_apps_public_ingress)使用。剩余 4 个可移植公共 IP 地址和 4 个可移植专用 IP 地址可用于通过[创建 LoadBalancer 服务](cs_apps.html#cs_apps_public_load_balancer)向公众公开单个应用程序。

**注**：可移植公共 IP 地址按月收费。如果在供应集群后选择除去可移植公共 IP 地址，那么即使只使用了很短的时间，您也仍然必须支付一个月的费用。

### 为集群请求其他子网
{: #add_subnet}

可以通过向集群分配子网，将稳定的可移植公共或专用 IP 添加到集群。

**注**：使子网可供集群使用时，此子网的 IP 地址会用于集群联网。为了避免 IP 地址冲突，请确保一个子网只用于一个集群。不要同时将一个子网用于多个集群或用于 {{site.data.keyword.containershort_notm}} 外部的其他用途。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

要在 IBM Cloud infrastructure (SoftLayer) 帐户中创建子网并使其可用于指定集群，请执行以下操作：

1. 供应新子网。

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>表 8. 了解此命令的构成</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>为集群供应子网的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>将 <code>&gt;cluster_name_or_id&lt;</code> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>将 <code>&gt;subnet_size&lt;</code> 替换为要从可移植子网中添加的 IP 地址数。接受的值为 8、16、32 或 64。<p>**注**：添加子网的可移植 IP 地址时，会使用 3 个 IP 地址来建立集群内部联网，所以不能将这 3 个地址用于应用程序负载均衡器或用于创建 LoadBalancer 服务。例如，如果请求 8 个可移植公共 IP 地址，那么可以使用其中 5 个地址向公众公开应用程序。</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>将 <code>&gt;VLAN_ID&lt;</code> 替换为要分配可移植公共或专用 IP 地址的公共或专用 VLAN 的标识。必须选择现有工作程序节点连接到的公用或专用 VLAN。要查看工作程序节点的公共或专用 VLAN ，请运行 <code>bx cs worker-get &gt;worker_id&lt;</code> 命令。</td>
    </tr>
    </tbody></table>

2.  验证子网已成功创建并添加到集群。子网 CIDR 在 **VLAN** 部分中列出。

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### 向 Kibernetes 集群添加定制和现有子网
{: #custom_subnet}

可以向 Kubernetes 集群添加现有可移植公用或专用子网。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群。

如果 IBM Cloud infrastructure (SoftLayer) 产品服务组合中存在具有要使用的定制防火墙规则或可用 IP 地址的现有子网，请创建不具有子网的集群，并在集群供应时使现有子网可供集群使用。

1.  识别要使用的子网。记下子网的标识和 VLAN 标识。在此示例中，子网标识为 807861，VLAN 标识为 1901230。

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  确认 VLAN 所在的位置。在此示例中，位置为 dal10。

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10 
    ```
    {: screen}

3.  使用您识别的位置和 VLAN 标识来创建集群。包含 `--no-subnet` 标志，以阻止自动创建新的可移植公共 IP 子网和新的可移植专用 IP 子网。

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  验证是否请求了创建集群。

    ```
    bx cs clusters
    ```
    {: pre}

    **注**：可能需要最长 15 分钟时间，才能订购好工作程序节点计算机，并且在您的帐户中设置并供应集群。

    当完成集群供应时，集群的状态会更改为**已部署**。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3   
    ```
    {: screen}

5.  检查工作程序节点的状态。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    当工作程序节点已准备就绪时，状态会更改为 **normal**，而阶段状态为 **Ready**。节点阶段状态为 **Ready** 时，可以访问集群。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  通过指定子网标识，向集群添加子网。使子网可供集群使用后，将创建 Kubernetes 配置映射，其中包含所有可用的可移植公共 IP 地址以供您使用。如果尚不存在用于集群的应用程序负载均衡器，那么会自动使用一个可移植公共 IP 地址和一个可移植专用 IP 地址来创建公共和专用应用程序负载均衡器。其他所有可移植公共和专用 IP 地址都可用于为应用程序创建 LoadBalancer 服务。

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### 将用户管理的子网和 IP 地址添加到 Kubernetes 集群
{: #user_subnet}

从要 {{site.data.keyword.containershort_notm}} 访问的内部部署网络中提供自己的子网。然后，可以将专用 IP 地址从该子网添加到 Kubernetes 集群中的 LoadBalancer 服务。

需求：
- 用户管理的子网只能添加到专用 VLAN。
- 子网前缀长度限制为 /24 到 /30。例如，`203.0.113.0/24` 指定了 253 个可用的专用 IP 地址，而 `203.0.113.0/30` 指定了 1 个可用的专用 IP 地址。
- 子网中的第一个 IP 地址必须用作子网的网关。

开始之前：配置网络流量在外部子网的输入和输出的路径。此外，请确认内部部署数据中心网关设备与 IBM Cloud infrastructure (SoftLayer) 产品服务组合中的专用网络 Vyatta 之间具有 VPN 连接。有关更多信息，请参阅此[博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。

1. 查看集群的专用 VLAN 的标识。找到 **VLAN** 部分。在 **User-managed** 字段中，识别带有 _false_ 的 VLAN 标识。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. 将外部子网添加到专用 VLAN。可移植专用 IP 地址将添加到集群的配置映射中。

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    示例：

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. 验证是否添加了用户提供的子网。**User-managed**字段为 _true_。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. 添加专用 LoadBalancer 服务或专用 Ingress 应用程序负载均衡器，以通过专用网络访问应用程序。如果要使用在创建专用负载均衡器或专用 Ingress 应用程序负载均衡器时添加的子网的专用 IP 地址，那么必须指定 IP 地址。否则，将在专用 VLAN 上的 IBM Cloud infrastructure (SoftLayer) 子网或用户提供的子网中随机选择 IP 地址。有关更多信息，请参阅[使用 LoadBalancer 服务类型配置对应用程序的访问](cs_apps.html#cs_apps_public_load_balancer)或[启用专用应用程序负载均衡器](cs_apps.html#private_ingress)。

<br />


## 在集群中使用 NFS 文件共享
{: #cs_cluster_volume_create}

如果在 IBM Cloud infrastructure (SoftLayer) 帐户中已经有要用于 Kubernetes 的现有 NFS 文件共享，那么可以通过在现有 NFS 文件共享上创建持久性卷来使用 NFS 文件共享。持久性卷是一块实际硬件，用作 Kubernetes 集群资源，并可以由集群用户使用。
{:shortdesc}

Kubernetes 会区分持久性卷（代表实际硬件）和持久性卷申领（通常由集群用户发起的对存储器的请求）。下图说明持久性卷与持久性卷申领之间的关系。

![创建持久性卷和持久性卷申领](images/cs_cluster_pv_pvc.png)

 如图所示，要使现有 NFS 文件共享可用于 Kubernetes，必须创建具有特定大小和访问方式的持久性卷，并创建与持久性卷规范相匹配的持久性卷申领。如果持久性卷和持久性卷申领相匹配，那么会将它们相互绑定。只有绑定的持久性卷申领才能由集群用户用于将相应卷安装到部署。此过程称为持久性存储器的静态供应。

开始之前，请确保您拥有可用于创建持久性卷的现有 NFS 文件共享。

**注**：持久性存储器的静态供应仅适用于现有 NFS 文件共享。如果没有现有 NFS 文件共享，那么集群用户可以使用[动态供应](cs_apps.html#cs_apps_volume_claim)过程来添加持久性卷。

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
    <caption>表 9. 了解 YAML 文件构成</caption>
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


您已成功创建持久性卷对象，并将其绑定到持久性卷申领。现在，集群用户可以[安装持久性卷申领](cs_apps.html#cs_apps_volume_mount)至其部署，并开始对持久性卷对象执行读写操作。

<br />


## 配置集群日志记录
{: #cs_logging}

日志可帮助您对集群和应用程序的问题进行故障诊断。有时，您可能希望将日志发送到特定位置以进行处理或长期存储。在 {{site.data.keyword.containershort_notm}} 中的 Kubernetes 集群上，可以为集群启用日志转发并选择日志的转发位置。**注**：对于标准集群，仅支持日志转发。
{:shortdesc}

您可以为日志源（如容器、应用程序、工作程序节点、Kubernetes 集群和 Ingress 控制器）转发日志。
查看下表以获取有关每个日志源的信息。

|日志源|特征|日志路径|
|----------|---------------|-----|
|`container`|在 Kubernetes 集群中运行的容器的日志。|-|
|`application`|在 Kubernetes 集群中运行的自己应用程序的日志。|`/var/log/apps/**/*.log`、`/var/log/apps/**/*.err`|
|`worker`|Kubernetes 集群中虚拟机工作程序节点的日志。|`/var/log/syslog`、`/var/log/auth.log`|
|`Kubernetes`|Kubernetes 系统组件的日志。|`/var/log/kubelet.log`、`/var/log/kube-proxy.log`|
|`ingress`|由 Ingress 控制器管理的应用程序负载均衡器的日志，用于管理进入 Kubernetes 集群的网络流量。|`/var/log/alb/ids/*.log`、`/var/log/alb/ids/*.err`、`/var/log/alb/customerlogs/*.log`、`/var/log/alb/customerlogs/*.err`|
{: caption="表 9. 日志源特征。" caption-side="top"}

### 启用日志转发
{: #cs_log_sources_enable}

可以将日志转发到 {{site.data.keyword.loganalysislong_notm}} 或外部 syslog 服务器。如果要将来自一个日志源的日志转发到两个日志收集器服务器，那么必须创建两个日志记录配置。
**注**：要转发应用程序的日志，请参阅[为应用程序启用日志转发](#cs_apps_enable)。
{:shortdesc}

开始之前：

1. 如果要将日志转发到外部 syslog 服务器，可以通过以下两种方式来设置接受 syslog 协议的服务器：
  * 设置和管理自己的服务器，或者让提供者为您管理服务器。如果提供者为您管理服务器，请从日志记录提供者获取日志记录端点。
  * 从容器运行 syslog。例如，可以使用此[部署 .yaml 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) 来访存在 Kubernetes 集群中运行容器的 Docker 公共映像。该映像在公共集群 IP 地址上发布端口 `514`，并使用此公共集群 IP 地址来配置 syslog 主机。

2. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

要为容器、工作程序节点、Kubernetes 系统组件、应用程序或 Ingress 应用程序负载均衡器启用日志转发，请执行以下操作：

1. 创建日志转发配置。

  * 将日志转发到 {{site.data.keyword.loganalysislong_notm}}：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --spaceName <cluster_space> --orgName <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>表 10. 了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>用于创建 {{site.data.keyword.loganalysislong_notm}} 日志转发配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>将 <em>&lt;my_log_source&gt;</em> 替换为日志源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>将 <em>&lt;kubernetes_namespace&gt;</em> 替换为您希望从中转发日志的 Docker 容器名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对容器日志源有效，并且是可选的。如果未指定名称空间，那么容器中的所有名称空间都将使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>将 <em>&lt;ingestion_URL&gt;</em> 替换为 {{site.data.keyword.loganalysisshort_notm}} 数据获取 URL。您可以在[此处](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)找到可用数据获取 URL 的列表。如果未指定数据获取 URL，那么将使用创建集群所在区域的端点。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>将 <em>&lt;ingestion_port&gt;</em> 替换为数据获取端口。如果未指定端口，那么将使用标准端口 <code>9091</code>。</td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td>将 <em>&lt;cluster_space&gt;</em> 替换为要将日志发送到的空间的名称。如果未指定空间，日志将发送到帐户级别。</td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td>将 <em>&lt;cluster_org&gt;</em> 替换为空间所在的组织的名称。如果指定了空间，那么此值是必需的。</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>用于将日志发送到 {{site.data.keyword.loganalysisshort_notm}} 的日志类型。</td>
    </tr>
    </tbody></table>

  * 将日志转发到外部 syslog 服务器：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 11. 了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>用于创建 syslog 日志转发配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>将 <em>&lt;my_log_source&gt;</em> 替换为日志源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>将 <em>&lt;kubernetes_namespace&gt;</em> 替换为您希望从中转发日志的 Docker 容器名称空间。<code>ibm-system</code> 和 <code>kube-system</code> Kubernetes 名称空间不支持日志转发。此值仅对容器日志源有效，并且是可选的。如果未指定名称空间，那么容器中的所有名称空间都将使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>将 <em>&lt;log_server_hostname&gt;</em> 替换为日志收集器服务的主机名或 IP 地址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>将 <em>&lt;log_server_port&gt;</em> 替换为日志收集器服务器的端口。如果未指定端口，那么将使用标准端口 <code>514</code>。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>用于将日志发送到 syslog 服务器的日志类型。</td>
    </tr>
    </tbody></table>

2. 验证是否已创建日志转发配置。

    * 列出集群中的所有日志记录配置：
      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      输出示例：

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 列出一种类型的日志源的日志记录配置：
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      输出示例：

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### 为应用程序启用日志转发
{: #cs_apps_enable}

应用程序中的日志必须限于主机节点上的特定目录。可以通过使用安装路径将主机路径卷安装到容器来完成此操作。此安装路径充当容器上要将应用程序日志发送到的目录。创建卷安装时，会自动创建预定义的主机路径目录 `/var/log/apps`。

查看应用程序日志转发的以下方面：
* 日志以递归方式从 var/log/apps 路径中进行读取。这意味着可以将应用程序日志置于⁄var/log/apps 路径的子目录中。
* 仅会转发具有 `.log` 或 `.err` 文件扩展名的应用程序日志文件。
* 首次启用日志转发时，会从应用程序日志尾部进行读取，而不是从头进行读取。这意味着不会读取任何日志在启用应用程序日志记录之前已经存在的内容。日志会从启用日志记录时的位置开始进行读取。但是，首次启用日志转发之后，日志将始终从上次停止的位置继续。
* 将 `/var/log/apps` 主机路径卷安装到容器时，容器会全部写入此同一目录。这意味着如果容器要写入相同名称的文件，那么容器会写入主机上完全相同的文件。如果您并不打算这么做，可以通过采用不同方式对每个容器中的日志文件命名，以阻止容器覆盖相同的日志文件。
* 由于所有容器都会写入相同名称的文件，因此不要使用此方法来转发 ReplicaSets 的应用程序日志。可以改为将应用程序中的日志写入 STDOUT 和 STDERR，这会作为容器日志进行选取。要转发写入到 STDOUT 和 STDERR 的应用程序日志，请遵循[启用日志转发](cs_cluster.html#cs_log_sources_enable)中的步骤。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

1. 打开应用程序的 pod 的 `.yaml` 配置文件。

2. 将以下 `volumeMounts` 和 `volumes` 添加到配置文件：

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. 将卷安装到 pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. 要创建日志转发配置，请遵循[启用日志转发](cs_cluster.html#cs_log_sources_enable)中的步骤。

### 更新日志转发配置
{: #cs_log_sources_update}

您可以更新容器、应用程序、工作程序节点、Kubernetes 系统组件或 Ingress 应用程序负载均衡器的日志记录配置。
{: shortdesc}

开始之前：

1. 如果要将日志收集器服务器更改为 syslog，那么可以通过以下两种方式来设置接受 syslog 协议的服务器：
  * 设置和管理自己的服务器，或者让提供者为您管理服务器。如果提供者为您管理服务器，请从日志记录提供者获取日志记录端点。
  * 从容器运行 syslog。例如，可以使用此[部署 .yaml 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) 来访存在 Kubernetes 集群中运行容器的 Docker 公共映像。该映像在公共集群 IP 地址上发布端口 `514`，并使用此公共集群 IP 地址来配置 syslog 主机。

2. [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

要更改日志记录配置的详细信息，请执行以下操作：

1. 更新日志记录配置。

    ```
    bx cs logging-config-update <my_cluster> <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --spaceName <cluster_space> --orgName <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>表 12. 了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>用于为日志源更新日志转发配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code><em>&lt;log_config_id&gt;</em></code></td>
    <td>将 <em>&lt;log_config_id&gt;</em> 替换为日志源配置的标识。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>将 <em>&lt;my_log_source&gt;</em> 替换为日志源。接受的值为 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 和 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>当日志记录类型为 <code>syslog</code> 时，请将 <em>&lt;log_server_hostname_or_IP&gt;</em> 替换为日志收集器服务的主机名或 IP 地址。当日志记录类型为 <code>ibm</code> 时，请将 <em>&lt;log_server_hostname&gt;</em> 替换为 {{site.data.keyword.loganalysislong_notm}} 数据获取 URL。您可以在[此处](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)找到可用数据获取 URL 的列表。如果未指定数据获取 URL，那么将使用创建集群所在区域的端点。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>将 <em>&lt;log_server_port&gt;</em> 替换为日志收集器服务器的端口。如果未指定端口，那么标准端口 <code>514</code> 将用于 <code>syslog</code>，并且 <code>9091</code> 将用于 <code>ibm</code>。</td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td>将 <em>&lt;cluster_space&gt;</em> 替换为要将日志发送到的空间的名称。此值仅对日志类型 <code>ibm</code> 有效，并且是可选的。如果未指定空间，日志将发送到帐户级别。</td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td>将 <em>&lt;cluster_org&gt;</em> 替换为空间所在的组织的名称。此值仅对日志类型 <code>ibm</code> 有效，如果指定了空间，那么此值是必需的。</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>将 <em>&lt;logging_type&gt;</em> 替换为要使用的新日志转发协议。目前支持 <code>syslog</code> 和 <code>ibm</code>。</td>
    </tr>
    </tbody></table>

2. 验证日志转发配置是否已更新。

    * 列出集群中的所有日志记录配置：

      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      输出示例：

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 列出一种类型的日志源的日志记录配置：

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      输出示例：

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

### 停止日志转发
{: #cs_log_sources_delete}

可以通过删除日志记录配置来停止日志转发。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为日志源所在的集群。

1. 删除日志记录配置。

    ```
    bx cs logging-config-rm <my_cluster> <log_config_id>
    ```
    {: pre}
将 <em>&lt;my_cluster&gt;</em> 替换为日志记录配置所在集群的名称，并将 <em>&lt;log_config_id&gt;</em> 替换为日志源配置的标识。


### 为 Kubernetes API 审计日志配置日志转发
{: #cs_configure_api_audit_logs}

Kubernetes API 审计日志从集群中捕获对 Kubernetes API 服务器的任何调用。要开始收集 Kubernetes API 审计日志，您可以配置 Kubernetes API 服务器，以便为集群设置 Webhook 后端。通过此 Webhook 后端，可将日志发送到远程服务器。有关 Kubernetes 审计日志的更多信息，请参阅 Kubernetes 文档中的<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">审计主题 <img src="../icons/launch-glyph.svg" alt="外部链接图标"></a>。

**注**：
* 仅 Kubernetes V1.7 和更新版本支持 Kubernetes API 审计日志的转发。
* 目前，缺省审计策略用于具有此日志记录配置的所有集群。

#### 启用 Kubernetes API 审计日志转发
{: #cs_audit_enable}

开始之前，请将[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)设置为要从中收集 API 服务器审计日志的集群。

1. 设置 API 服务器配置的 Webhook 后端。根据您在此命令标志中提供的信息来创建 Webhook 配置。如果未在标志中提供任何信息，那么将使用缺省的 Webhook 配置。

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>表 13. 了解此命令的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 了解此命令的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>用于为集群的 Kubernetes API 服务器配置设置选项的命令。</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>用于为集群的 Kubernetes API 服务器设置审计 Webhook 配置的命令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>将 <em>&lt;my_cluster&gt;</em> 替换为集群的名称或标识。</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>将 <em>&lt;server_URL&gt;</em> 替换为要将日志发送到的远程日志记录服务的 URL 或 IP 地址。如果提供不安全的服务器 URL，那么将忽略任何证书。如果未指定远程服务器 URL 或 IP 地址，那么会使用缺省 QRadar 配置，并且日志将发送到该集群所在区域的 QRadar 实例。</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>将 <em>&lt;CA_cert_path&gt;</em> 替换为用于验证远程日志记录服务的 CA 证书的文件路径。</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>将 <em>&lt;client_cert_path&gt;</em> 替换为用于针对远程日志记录服务进行认证的客户机证书的文件路径。</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>将 <em>&lt;client_key_path&gt;</em> 替换为用于连接到远程日志记录服务的相应客户机密钥的文件路径。</td>
    </tr>
    </tbody></table>

2. 通过查看远程日志记录服务的 URL 来验证是否已启用日志转发。

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    输出示例：
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. 通过重新启动 Kubernetes 主节点来应用配置更新。

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

#### 停止 Kubernetes API 审计日志转发
{: #cs_audit_delete}

您可以通过禁用集群的 API 服务器的 Webhook 后端配置来停止转发审计日志。

开始之前，请将[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)设置为要从中停止收集 API 服务器审计日志的集群。

1. 禁用集群 API 服务器的 Webhook 后端配置。

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. 通过重新启动 Kubernetes 主节点来应用配置更新。

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### 查看日志
{: #cs_view_logs}

要查看集群和容器的日志，可以使用标准的 Kubernetes 和 Docker 日志记录功能。
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

对于标准集群，日志位于您创建 Kubernetes 集群时登录到的 {{site.data.keyword.Bluemix_notm}} 帐户中。如果在创建集群或创建日志记录配置时指定了 {{site.data.keyword.Bluemix_notm}} 空间，那么日志将位于该空间中。日志在容器外部监视和转发。可以使用 Kibana 仪表板来访问容器的日志。有关日志记录的更多信息，请参阅 [{{site.data.keyword.containershort_notm}} 的日志记录](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

**注**：如果在创建集群或日志记录配置时指定了空间，那么帐户所有者需要该空间的“管理员”、“开发者”或“审计员”许可权才能查看日志。有关更改 {{site.data.keyword.containershort_notm}} 访问策略和许可权的更多信息，请参阅[管理集群访问权](cs_cluster.html#cs_cluster_user)。更改许可权后，日志可能最长需要 24 小时才会开始显示。

要访问 Kibana 仪表板，请转至以下某个 URL，然后选择在其中创建了集群的 {{site.data.keyword.Bluemix_notm}} 帐户或空间。
- 美国南部和美国东部：https://logging.ng.bluemix.net
- 英国南部和欧洲中部：https://logging.eu-fra.bluemix.net
- 亚太南部：https://logging.au-syd.bluemix.net

有关查看日志的更多信息，请参阅[通过 Web 浏览器导航至 Kibana](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)。

#### Docker 日志
{: #cs_view_logs_docker}

可以利用内置 Docker 日志记录功能来查看标准 STDOUT 和 STDERR 输出流上的活动。有关更多信息，请参阅[查看在 Kubernetes 集群中运行的容器的容器日志](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

<br />


## 配置集群监视
{: #cs_monitoring}

度量值可帮助您监视集群的运行状况和性能。可以配置工作程序节点的运行状况监视，以自动检测并更正进入已降级或非运行状态的任何工作程序。**注**：仅标准集群支持监视功能。
{:shortdesc}

### 查看度量值
{: #cs_view_metrics}

您可以使用标准 Kubernetes 和 Docker 功能来监视集群和应用程序的运行状况。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}} 中的集群详细信息页面</dt>
<dd>{{site.data.keyword.containershort_notm}} 提供了有关集群的运行状况和容量以及集群资源使用情况的信息。可以使用此 GUI 通过 {{site.data.keyword.Bluemix_notm}} 服务绑定来向外扩展集群、使用持久性存储器以及向集群添加更多功能。要查看集群详细信息页面，请转至 **{{site.data.keyword.Bluemix_notm}} 仪表板**，然后选择集群。</dd>
<dt>Kubernetes 仪表板</dt>
<dd>Kubernetes 仪表板是一个管理 Web 界面，可以在其中查看工作程序节点的运行状况，查找 Kubernetes 资源，部署容器化应用程序，以及使用日志记录和监视信息对应用程序进行故障诊断。有关如何访问 Kubernetes 仪表板的更多信息，请参阅[启动 {{site.data.keyword.containershort_notm}} 的 Kubernetes 仪表板](cs_apps.html#cs_cli_dashboard)。</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>标准集群的度量值位于创建 Kubernetes 集群时登录到的 {{site.data.keyword.Bluemix_notm}} 帐户中。如果在创建集群时指定了 {{site.data.keyword.Bluemix_notm}} 空间，那么度量值将位于该空间中。将为集群中部署的所有容器自动收集容器度量值。这些度量值会通过 Grafana 发送并使其可用。有关度量值的更多信息，请参阅[监视 {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)。<p>要访问 Grafana 仪表板，请转至以下某个 URL，然后选择在其中已创建集群的 {{site.data.keyword.Bluemix_notm}} 帐户或空间。<ul><li>美国南部和美国东部：https://metrics.ng.bluemix.net
</li><li>英国南部：https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### 其他运行状况监视工具
{: #cs_health_tools}

可以配置其他工具来执行更多监视功能。
<dl>
<dt>Prometheus</dt>
<dd>Prometheus 是一个开放式源代码监视、日志记录和警报工具，专为 Kubernetes 而设计。该工具基于 Kubernetes 日志记录信息来检索有关集群、工作程序节点和部署运行状况的详细信息。有关设置信息，请参阅[将服务与 {{site.data.keyword.containershort_notm}} 集成](cs_planning.html#cs_planning_integrations)。</dd>
</dl>

### 使用自动恢复为工作程序节点配置运行状况监视
{: #cs_configure_worker_monitoring}

可以将 {{site.data.keyword.containerlong_notm}} 自动恢复系统部署到 Kubernetes V1.7 或更高版本的现有集群中。自动恢复系统会使用各种检查来查询工作程序节点的运行状态。如果自动恢复根据配置的检查，检测到运行状况欠佳的工作程序节点，那么自动恢复会触发更正操作，例如在工作程序节点上重装操作系统。一次只会对一个工作程序节点执行更正操作。该工作程序节点必须成功完成更正操作后，才能对其他任何工作程序节点执行更正操作。
有关更多信息，请参阅此[自动恢复博客帖子 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。**注**：自动恢复至少需要一个正常运行的节点才能有效运行。仅在具有两个或两个以上工作程序节点的集群中，将自动恢复配置为执行主动检查。

开始之前，请[设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为要检查其工作程序节点状态的集群。

1. 创建配置映射文件以通过 JSON 格式定义检查。例如，以下 YAML 文件定义了三项检查：一项 HTTP 检查和两项 Kubernetes API 服务器检查。

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>表 14. 了解 YAML 文件的组成部分</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>配置名称 <code>ibm-worker-recovery-checks</code> 是常量，无法更改。</td>
    </tr>
    <tr>
    <td><code>namespace</code></td>
    <td><code>kube-system</code> 名称空间是常量，无法更改。</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>输入希望自动恢复使用的检查类型。<ul><li><code>HTTP</code>：自动恢复调用在每个节点上运行的 HTTP 服务器，以确定节点是否在正常运行。</li><li><code>KUBEAPI</code>：自动恢复调用 Kubernetes API 服务器并读取工作程序节点报告的运行状态数据。</li></ul></td>
    </tr>
    <tr>
    <td><code>资源</code></td>
    <td>检查类型为 <code>KUBEAPI</code> 时，输入希望自动恢复检查的资源类型。接受的值为 <code>NODE</code> 或 <code>PODS</code>。</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>输入检查连续失败次数的阈值。达到此阈值时，自动恢复会触发指定的更正操作。例如，如果值为 3 且自动恢复连续三次执行配置的检查失败，那么自动恢复会触发与检查关联的更正操作。</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>资源类型为 <code>PODS</code> 时，请输入工作程序节点上可以处于 [NotReady ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状态的 pod 的百分比阈值。此百分比基于安排到一个工作程序节点的 pod 总数。检查确定运行状况欠佳的 pod 百分比大于阈值时，该检查计为一次失败。</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>输入在达到失败阈值时要运行的操作。仅当没有其他工作程序在进行修复，并且此工作程序节点距离执行上一个更正操作的时间已超过等待期时，才会运行更正操作。<ul><li><code>REBOOT</code>：重新引导工作程序节点。</li><li><code>RELOAD</code>：从干净的操作系统重新装入工作程序节点的所有必需配置。</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>输入自动恢复在对节点发出更正操作后，必须等待多长时间才能再次向该节点发出其他更正操作（以秒为单位）。等待期自发出更正操作时开始计算。</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>输入连续检查的间隔秒数。例如，如果值为 180，那么自动恢复会每 3 分钟对每个节点运行一次检查。</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>输入在自动恢复终止调用操作之前，对数据库执行检查调用所用的最长时间（以秒为单位）。<code>TimeoutSeconds</code> 的值必须小于 <code>IntervalSeconds</code> 的值。</td>
    </tr>
    <tr>
    <td><code>端口</code></td>
    <td>检查类型为 <code>HTTP</code> 时，请输入工作程序节点上 HTTP 服务器必须绑定到的端口。此端口必须在集群中每个工作程序节点的 IP 上公开。自动恢复需要一个跨所有节点的常量端口号以用于检查服务器。将定制服务器部署到集群中时，请使用 [DaemonSets ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>检查类型为 <code>HTTP</code> 时，请输入期望从检查返回的 HTTP 服务器状态。例如，值为 200 表示期望服务器返回 <code>OK</code> 响应。</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>检查类型为 <code>HTTP</code> 时，请输入从 HTTP 服务器请求的路径。此值通常是在所有工作程序节点上运行的服务器的度量值路径。</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>输入 <code>true</code> 以启用检查，或输入 <code>false</code> 以禁用检查。</td>
    </tr>
    </tbody></table>

2. 在集群中创建配置映射。

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 使用相应检查来验证是否已在 `kube-system` 名称空间中创建名称为 `ibm-worker-recovery-checks` 的配置映射。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. 确保已在 `kube-system` 名称空间中创建名称为 `international-registry-docker-secret`的 Docker 拉取私钥。自动恢复会在 {{site.data.keyword.registryshort_notm}} 的国际 Docker 注册表中进行托管。如果尚未创建包含国际注册表的有效凭证的 Docker 注册表私钥，请创建 Docker 注册表私钥以运行自动恢复系统。

    1. 安装 {{site.data.keyword.registryshort_notm}} 插件。

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. 将国际注册表设定为目标。

        ```
        bx cr region-set international
        ```
        {: pre}

    3. 创建国际注册表令牌。

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. 将 `INTERNATIONAL_REGISTRY_TOKEN` 环境变量设置为已创建的令牌。

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. 将 `DOCKER_EMAIL` 环境变量设置为当前用户。仅在下一步中运行 `kubectl` 命令时才需要您的电子邮件地址。

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. 创建 Docker 拉取私钥。

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. 通过应用此 YAML 文件，将自动恢复部署到集群中。

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. 过几分钟后，可以检查以下命令的输出中的 `Events` 部分，以查看自动恢复部署上的活动。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## 可视化 Kubernetes 集群资源
{: #cs_weavescope}

Weave Scope 提供了 Kubernetes 集群内资源（包括服务、pod、容器、进程、节点等等）的可视图。此外，Weave Scope 还提供了 CPU 和内存的交互式度量值，以及用于跟踪和执行到容器中的多种工具。
{:shortdesc}

开始之前：

-   切勿在公共因特网上公开您的集群信息。完成以下步骤以安全地部署 Weave Scope 并在本地从 Web 浏览器对其进行访问。
-   如果还没有标准集群，请[创建标准集群](#cs_cluster_ui)。Weave Scope 可以是 CPU 密集型，尤其是应用程序。因此请使用更大的标准集群运行 Weave Scope，而不要使用 Lite 集群。
-   [设定 CLI 的目标](cs_cli_install.html#cs_cli_configure)为集群以运行 `kubectl` 命令。


要将 Weave Scope 用于集群，请执行以下操作：
2.  在集群中部署其中一个提供的 RBAC 许可权配置文件。

    启用读/写许可权：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    启用只读许可权：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    输出：

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  部署 Weave Scope 服务，此服务专供集群 IP 地址访问。

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    输出：

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  运行端口转发命令以在计算机上启动该服务。现在，Weave Scope 已配置用于集群；下次访问 Weave Scope 时，可以运行以下端口转发命令，而不用再次完成先前的配置步骤。

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    输出：

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  打开 Web 浏览器并转至 `http://localhost:4040`。未部署缺省组件时，将看到下图。可以选择查看集群中 Kubernetes 资源的拓扑图或表。

     <img src="images/weave_scope.png" alt="Weave Scope 中的示例拓扑" style="width:357px;" />


[了解有关 Weave Scope 功能的更多信息 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.weave.works/docs/scope/latest/features/)。

<br />


## 除去集群
{: #cs_cluster_remove}

使用集群完毕后，可以将该集群除去，使其不再耗用资源。
{:shortdesc}

对于使用现买现付帐户创建的 Lite 和标准集群，不再需要这些集群时，必须由用户手动将其除去。

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
- 子网用于将可移植公共 IP 地址分配给 LoadBalancer 服务或 Ingress 控制器。如果保留子网，那么可以在新集群中复用这些子网，也可以日后从 IBM Cloud infrastructure (SoftLayer) 产品服务组合中手动删除这些子网。
- 如果使用(现有文件共享)[#cs_cluster_volume_create]创建了持久性卷申领，那么在删除集群时无法删除该文件共享。必须日后从 IBM Cloud infrastructure (SoftLayer) 产品服务组合中手动删除此文件共享。
- 持久性存储器为您的数据提供了高可用性。如果将其删除，那么无法恢复这些数据。
