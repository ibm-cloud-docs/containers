---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, ibmcloud, ic, ks, kubectl

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




# 设置 CLI 和 API
{: #cs_cli_install}

可以使用 {{site.data.keyword.containerlong}} CLI 或 API 来创建和管理 Kubernetes 集群。
{:shortdesc}

## 安装 CLI
{: #cs_cli_install_steps}

安装必需的 CLI 以在 {{site.data.keyword.containerlong_notm}} 中创建和管理 Kubernetes 集群，并将容器化应用程序部署到集群。
{:shortdesc}

此任务包含用于安装这些 CLI 和插件的信息：

-   {{site.data.keyword.Bluemix_notm}} CLI V0.8.0 或更高版本
-   {{site.data.keyword.containerlong_notm}} 插件
-   与集群的 `major.minor` 版本相匹配的 Kubernetes CLI 版本
-   可选：{{site.data.keyword.registryshort_notm}} 插件



<br>
要安装 CLI，请执行以下操作：



1.  作为 {{site.data.keyword.containerlong_notm}} 插件的必备软件，请安装 [{{site.data.keyword.Bluemix_notm}} CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](/docs/cli?topic=cloud-cli-ibmcloud-cli)。用于通过 {{site.data.keyword.Bluemix_notm}} CLI 运行命令的前缀是 `ibmcloud`。

    计划大量使用 CLI 吗？尝试[针对 {{site.data.keyword.Bluemix_notm}} CLI 启动 shell 自动完成（仅限 Linux/MacOS）](/docs/cli/reference/ibmcloud?topic=cloud-cli-shell-autocomplete#shell-autocomplete-linux)。
    {: tip}

2.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。

    ```
    ibmcloud login
    ```
    {: pre}

    如果您有联合标识，请使用 `ibmcloud login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。
    {: tip}

3.  要创建 Kubernetes 集群以及管理工作程序节点，请安装 {{site.data.keyword.containerlong_notm}} 插件。用于通过 {{site.data.keyword.containerlong_notm}} 插件运行命令的前缀是 `ibmcloud ks`。

    ```
    ibmcloud plugin install container-service 
    ```
    {: pre}

    要验证是否已正确安装该插件，请运行以下命令：

    ```
    ibmcloud plugin list
    ```
    {: pre}

    {{site.data.keyword.containerlong_notm}} 插件会在结果中显示为 **container-service**。

4.  {: #kubectl}要查看 Kubernetes 仪表板的本地版本以及将应用程序部署到集群，请[安装 Kubernetes CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)。用于通过 Kubernetes CLI 来运行命令的前缀是 `kubectl`。

    1.  下载与您计划使用的 Kubernetes 集群 `major.minor` 版本相匹配的 Kubernetes CLI `major.minor` 版本。当前 {{site.data.keyword.containerlong_notm}} 缺省 Kubernetes 版本是 1.12.6。

        如果使用的 `kubectl` CLI 版本与集群的 `major.minor` 版本不匹配，那么可能会遇到意外的结果。请确保 Kubernetes 集群版本和 CLI 版本保持最新。
        {: note}

        - **OS X**：[https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/darwin/amd64/kubectl ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/darwin/amd64/kubectl)
        - **Linux**：[https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/linux/amd64/kubectl ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/linux/amd64/kubectl)
        - **Windows**：[https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/windows/amd64/kubectl.exe ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/windows/amd64/kubectl.exe)

    2.  **对于 OS X 和 Linux**：完成以下步骤。
        1.  将可执行文件移至 `/usr/local/bin` 目录。

            ```
            mv /filepath/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  确保 `/usr/local/bin` 列在 `PATH` 系统变量中。`PATH` 变量包含操作系统可以在其中找到可执行文件的所有目录。列在 `PATH` 变量中的目录用于不同的用途。`/usr/local/bin` 用于为不属于操作系统的一部分，而是由系统管理员手动安装的软件存储其可执行文件。

            ```
            echo $PATH
            ```
            {: pre}

            示例 CLI 输出：

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  使文件可执行。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

    3.  **对于 Windows：**将 Kubernetes CLI 安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中。通过此设置，您在以后运行命令时，可减少一些文件路径更改操作。

5.  要管理专用映像存储库，请安装 {{site.data.keyword.registryshort_notm}} 插件。使用此插件可在 IBM 托管的具备高可用性和高可缩放性的多租户专用映像注册表中设置自己的名称空间，存储 Docker 映像并与其他用户共享这些映像。要将容器部署到集群中，Docker 映像是必需的。用于运行注册表命令的前缀是 `ibmcloud cr`。

    ```
    ibmcloud plugin install container-registry 
    ```
    {: pre}

    要验证是否已正确安装该插件，请运行以下命令：

    ```
    ibmcloud plugin list
    ```
    {: pre}

    该插件会在结果中显示为 container-registry。

接下来，开始[使用 {{site.data.keyword.containerlong_notm}} 通过 CLI 创建 Kubernetes 集群](/docs/containers?topic=containers-clusters#clusters_cli)。

有关这些 CLI 的参考信息，请参阅那些工具的文档。

-   [`ibmcloud` 命令](/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_cli)
-   [`ibmcloud ks` 命令](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)
-   [`kubectl` 命令 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [`ibmcloud cr` 命令](/docs/services/Registry?topic=registry-registry_cli_reference#registry_cli_reference)

<br />




## 在计算机上的容器中运行 CLI
{: #cs_cli_container}

您可以将多个 CLI 安装到计算机上运行的一个容器中，而不必分别将每个 CLI 安装在计算机上。
{:shortdesc}

开始之前，[安装 Docker ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.docker.com/community-edition#/download) 以在本地构建并运行映像。如果使用的是 Windows 8 或更低版本，可以改为安装 [Docker Toolbox ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.docker.com/toolbox/toolbox_install_windows/)。

1. 基于提供的 Dockerfile 创建映像。

    ```
docker build -t <image_name> https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/install-clis-container/Dockerfile
    ```
    {: pre}

2. 将映像本地部署为容器，并安装卷以访问本地文件。

    ```
docker run -it -v /local/path:/container/volume <image_name>
    ```
    {: pre}

3. 在交互式 shell 中，开始运行 `ibmcloud ks` 和 `kubectl` 命令。如果创建了要保存的数据，请将这些数据保存到安装的卷中。退出 shell 时，容器会停止。

<br />



## 将 CLI 配置为运行 `kubectl`
{: #cs_cli_configure}

您可以使用 Kubernetes CLI 随附的命令，在 {{site.data.keyword.Bluemix_notm}} 中管理集群。
{:shortdesc}

支持 Kubernetes 1.12.6 中可用的所有 `kubectl` 命令用于 {{site.data.keyword.Bluemix_notm}} 中的集群。创建集群后，使用环境变量，将本地 CLI 的上下文设置到该集群。
然后，您可以运行 Kubernetes `kubectl` 命令，以在 {{site.data.keyword.Bluemix_notm}} 中使用集群。


要能够运行 `kubectl` 命令，请先执行以下操作：
* [安装必需的 CLI](#cs_cli_install)。
* [创建集群](/docs/containers?topic=containers-clusters#clusters_cli)。
* 确保您具有授予相应 Kubernetes RBAC 角色的[服务角色](/docs/containers?topic=containers-users#platform)，以便您可以使用 Kubernetes 资源。如果您只有服务角色而没有平台角色，那么需要集群管理员为您提供集群名称和标识，或者提供**查看者**平台角色，以便能列出集群。

要使用 `kubectl` 命令，请执行以下操作：

1.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。要指定 {{site.data.keyword.Bluemix_notm}} 区域，请[包含 API 端点](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    ```
    ibmcloud login
    ```
    {: pre}

    如果您有联合标识，请使用 `ibmcloud login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。
    {: tip}

2.  选择 {{site.data.keyword.Bluemix_notm}} 帐户。如果您分配有多个 {{site.data.keyword.Bluemix_notm}} 组织，请选择在其中创建集群的组织。集群是特定于组织的，但又独立于 {{site.data.keyword.Bluemix_notm}} 空间。因此，您无需选择空间。

3.  要在非缺省资源组中创建并使用集群，请将该资源组设定为目标。要查看每个集群所属的资源组，请运行 `ibmcloud ks clusters`。**注**：您必须至少具有对该资源组的[**查看者**访问权](/docs/containers?topic=containers-users#platform)。
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

4.  要在非先前所选 {{site.data.keyword.Bluemix_notm}} 区域的区域中创建或访问 Kubernetes 集群，请将该区域设定为目标。
    ```
    ibmcloud ks region-set
    ```
    {: pre}

5.  列出帐户中的所有集群以获取集群的名称。如果您仅具有 {{site.data.keyword.Bluemix_notm}} IAM 服务角色，并且无法查看集群，请要求集群管理员提供 IAM **查看者**平台角色，或提供集群名称和标识。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

6.  将所创建的集群设置为此会话的上下文。每次使用集群时都完成这些配置步骤。
    1.  获取命令以设置环境变量并下载 Kubernetes 配置文件。

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        下载配置文件后，会显示一个命令，您可以使用该命令将本地 Kubernetes 配置文件的路径设置为环境变量。

        示例：

        ```
    export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
    ```
        {: screen}

    2.  复制并粘贴终端中显示的命令，以设置 `KUBECONFIG` 环境变量。

        **Mac 或 Linux 用户**：可以不运行 `ibmcloud ks cluster-config` 命令并复制 `KUBECONFIG` 环境变量，而改为运行 `ibmcloud ks cluster-config --export <cluster-name>`。根据您的 shell，您可以通过运行 `eval $(ibmcloud ks cluster-config --export <cluster-name>)` 来设置 shell。
        {: tip}

        **Windows PowerShell 用户**：不要从 `ibmcloud ks cluster-config` 的输出中复制并粘贴 `SET` 命令，您必须改为运行相关命令来设置 `KUBECONFIG` 环境变量，例如运行 `$env:KUBECONFIG = "C:\Users\<user_name>\.bluemix\plugins\container-service\clusters\mycluster\kube-config-prod-dal10-mycluster.yml"`。
        {:tip}

    3.  验证是否已正确设置 `KUBECONFIG` 环境变量。

        示例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        输出：
        ```
                /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

7.  通过检查 Kubernetes CLI 服务器版本，验证 `kubectl` 命令是否针对您的集群正常运行。

    ```
        kubectl version  --short
        ```
    {: pre}

    输出示例：

    ```
    Client Version: v1.12.6
    Server Version: v1.12.6
    ```
    {: screen}

现在，可以运行 `kubectl` 命令，在 {{site.data.keyword.Bluemix_notm}} 中管理集群。有关完整的命令列表，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/)。

**提示：**如果使用的是 Windows，而 Kubernetes CLI 未安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中，那么必须将目录更改为 Kubernetes CLI 的安装路径才能成功运行 `kubectl` 命令。


<br />


## 更新 CLI
{: #cs_cli_upgrade}

您可能想要定期更新 CLI 以使用新功能。
{:shortdesc}

此任务包含用于更新这些 CLI 的信息。

-   {{site.data.keyword.Bluemix_notm}} CLI V0.8.0 或更高版本
-   {{site.data.keyword.containerlong_notm}} 插件
-   Kubernetes CLI V1.12.6 或更高版本
-   {{site.data.keyword.registryshort_notm}} 插件

<br>
要更新 CLI，请执行以下操作：

1.  更新 {{site.data.keyword.Bluemix_notm}} CLI。下载[最新版本 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](/docs/cli?topic=cloud-cli-ibmcloud-cli) 并运行安装程序。

2. 登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。要指定 {{site.data.keyword.Bluemix_notm}} 区域，请[包含 API 端点](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    ```
    ibmcloud login
    ```
    {: pre}

     如果您有联合标识，请使用 `ibmcloud login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。
     {: tip}

3.  更新 {{site.data.keyword.containerlong_notm}} 插件。
    1.  通过 {{site.data.keyword.Bluemix_notm}} 插件存储库安装更新。

        ```
        ibmcloud plugin update container-service 
        ```
        {: pre}

    2.  通过运行以下命令并检查已安装的插件的列表来验证插件安装。

        ```
    ibmcloud plugin list
    ```
        {: pre}

        {{site.data.keyword.containerlong_notm}} 插件会在结果中显示为 container-service。

    3.  初始化 CLI。

        ```
        ibmcloud ks init
        ```
        {: pre}

4.  [更新 Kubernetes CLI](#kubectl)。

5.  更新 {{site.data.keyword.registryshort_notm}} 插件。
    1.  通过 {{site.data.keyword.Bluemix_notm}} 插件存储库安装更新。

        ```
        ibmcloud plugin update container-registry 
        ```
        {: pre}

    2.  通过运行以下命令并检查已安装的插件的列表来验证插件安装。

        ```
    ibmcloud plugin list
    ```
        {: pre}

        Registry 插件会在结果中显示为 container-registry。

<br />


## 卸载 CLI
{: #cs_cli_uninstall}

如果不再需要 CLI，可以将其卸载。
{:shortdesc}

此任务包含用于除去以下 CLI 的信息：


-   {{site.data.keyword.containerlong_notm}} 插件
-   Kubernetes CLI
-   {{site.data.keyword.registryshort_notm}} 插件

要卸载 CLI，请执行以下操作：



1.  卸载 {{site.data.keyword.containerlong_notm}} 插件。

    ```
    ibmcloud plugin uninstall container-service
    ```
    {: pre}

2.  卸载 {{site.data.keyword.registryshort_notm}} 插件。

    ```
    ibmcloud plugin uninstall container-registry
    ```
    {: pre}

3.  通过运行以下命令并检查已安装的插件的列表，验证插件是否已卸载。

    ```
    ibmcloud plugin list
    ```
    {: pre}

    container-service 和 container-registry 插件未显示在结果中。

<br />




## 使用 API 自动部署集群
{: #cs_api}

可以使用 {{site.data.keyword.containerlong_notm}} API 来自动创建、部署和管理 Kubernetes 集群。
{:shortdesc}

{{site.data.keyword.containerlong_notm}} API 需要您必须在 API 请求中提供的头信息，根据您要使用的 API，这些头信息可以有所不同。
要确定 API 需要哪些头信息，请参阅 [{{site.data.keyword.containerlong_notm}} API 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://us-south.containers.cloud.ibm.com/swagger-api)。

要向 {{site.data.keyword.containerlong_notm}} 进行认证，必须提供包含创建集群的 {{site.data.keyword.Bluemix_notm}} 帐户标识且使用 {{site.data.keyword.Bluemix_notm}} 凭证生成的 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 令牌。根据您向 {{site.data.keyword.Bluemix_notm}} 进行认证的方式，可以在下列选项之间进行选择，以自动创建 {{site.data.keyword.Bluemix_notm}} IAM 令牌。

您还可以使用 [API Swagger JSON 文件 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://containers.cloud.ibm.com/swagger-api-json) 来生成可与 API 交互（作为自动化工作的一部分）的客户机。
{: tip}

<table>
<caption>标识类型和选项</caption>
<thead>
<th>{{site.data.keyword.Bluemix_notm}} 标识</th>
<th>我的选项</th>
</thead>
<tbody>
<tr>
<td>未联合的标识</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}} 用户名和密码：</strong>您可以遵循本主题中的步骤来完全自动化 {{site.data.keyword.Bluemix_notm}} IAM 访问令牌的创建。</li>
<li><strong>生成 {{site.data.keyword.Bluemix_notm}} API 密钥：</strong>作为使用 {{site.data.keyword.Bluemix_notm}} 用户名和密码的替代方法，您可以<a href="/docs/iam?topic=iam-userapikey#create_user_key" target="_blank">使用 {{site.data.keyword.Bluemix_notm}} API 密钥</a>。{{site.data.keyword.Bluemix_notm}} API 密钥依赖于为其生成这些密钥的 {{site.data.keyword.Bluemix_notm}} 帐户。您不能将 {{site.data.keyword.Bluemix_notm}} API 密钥与同一 {{site.data.keyword.Bluemix_notm}} IAM 令牌中的不同帐户标识组合使用。要访问使用非 {{site.data.keyword.Bluemix_notm}} API 密钥所基于的帐户创建的集群，必须登录该帐户以生成新的 API 密钥。</li></ul></tr>
<tr>
<td>联合标识</td>
<td><ul><li><strong>生成 {{site.data.keyword.Bluemix_notm}} API 密钥：</strong><a href="/docs/iam?topic=iam-userapikey#create_user_key" target="_blank">{{site.data.keyword.Bluemix_notm}} API 密钥</a>依赖于为其生成这些密钥的 {{site.data.keyword.Bluemix_notm}} 帐户。您不能将 {{site.data.keyword.Bluemix_notm}} API 密钥与同一 {{site.data.keyword.Bluemix_notm}} IAM 令牌中的不同帐户标识组合使用。要访问使用非 {{site.data.keyword.Bluemix_notm}} API 密钥所基于的帐户创建的集群，必须登录该帐户以生成新的 API 密钥。</li><li><strong>使用一次性密码：</strong>如果使用一次性密码向 {{site.data.keyword.Bluemix_notm}} 进行认证，那么无法完全自动化 {{site.data.keyword.Bluemix_notm}} IAM 令牌的创建，因为检索一次性密码需要与 Web 浏览器进行手动交互。要完全自动化 {{site.data.keyword.Bluemix_notm}} IAM 令牌的创建，必须改为创建 {{site.data.keyword.Bluemix_notm}} API 密钥。</ul></td>
</tr>
</tbody>
</table>

1.  创建 {{site.data.keyword.Bluemix_notm}} IAM 访问令牌。包含在请求中的主体信息根据您使用的 {{site.data.keyword.Bluemix_notm}} 认证方法而有所不同。替换以下值：
  - `<username>`：您的 {{site.data.keyword.Bluemix_notm}} 用户名。
  - `<password>`：您的 {{site.data.keyword.Bluemix_notm}} 密码。
  - `<api_key>`：您的 {{site.data.keyword.Bluemix_notm}} API 密钥。
  - `<passcode>`：您的 {{site.data.keyword.Bluemix_notm}} 一次性密码。运行 `ibmcloud login --sso`，并按照 CLI 输出中的指示信息，使用 Web 浏览器来检索一次性密码。

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    示例：
    ```
        POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    要指定 {{site.data.keyword.Bluemix_notm}} 区域，请[复查 API 端点中使用的区域缩写](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    <table summary-"Input parameters to retrieve tokens">
    <caption>用于获取令牌的输入参数</caption>
    <thead>
        <th>输入参数</th>
        <th>值</th>
    </thead>
    <tbody>
    <tr>
    <td>头</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><strong>注</strong>：<code>Yng6Yng=</code> 是针对用户名 <strong>bx</strong> 和密码 <strong>bx</strong> 的 URL 编码授权。</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 用户名和密码的主体</td>
    <td><ul><li>`grant_type: password`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`username: <em>&lt;username&gt;</em>`</li>
    <li>`password: <em>&lt;password&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret: `</li></ul>
    <strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} API 密钥的主体</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:apikey`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`apikey: <em>&lt;api_key&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:``</li></ul>
    <strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 一次性密码的主体</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:passcode`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`passcode: <em>&lt;passcode&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret: `</li></ul>
    <strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    </tbody>
    </table>

    示例 API 输出：

    ```
    {
    "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    

    ```
    {: screen}

    您可以在 API 输出的 **access_token** 字段中找到 {{site.data.keyword.Bluemix_notm}} IAM 令牌。请记下 {{site.data.keyword.Bluemix_notm}} IAM 令牌以在后续步骤中用于检索更多头信息。

2.  检索创建集群的 {{site.data.keyword.Bluemix_notm}} 帐户的标识。将 `<iam_token>` 替换为在上一步中检索到的 {{site.data.keyword.Bluemix_notm}} IAM 令牌。

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="用于获取 {{site.data.keyword.Bluemix_notm}} 帐户标识的输入参数">
    <caption>用于获取 {{site.data.keyword.Bluemix_notm}} 帐户标识的输入参数</caption>
    <thead>
  	<th>输入参数</th>
  	<th>值</th>
    </thead>
    <tbody>
  	<tr>
  		<td>头</td>
  		<td><ul><li>`Content-Type: application/json`</li>
      <li>`Authorization: bearer &lt;iam_token&gt;`</li>
      <li>`Accept: application/json
`</li></ul></td>
  	</tr>
    </tbody>
    </table>

    示例 API 输出：

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
"guid": "<account_ID>",
            "url": "/v1/accounts/<account_ID>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    可以在 API 输出的 **resources/metadata/guid** 字段中找到您的 {{site.data.keyword.Bluemix_notm}} 帐户的标识。

3.  生成新的 {{site.data.keyword.Bluemix_notm}} IAM 令牌，该令牌包含您的 {{site.data.keyword.Bluemix_notm}} 凭证和创建集群的帐户标识。将 `<account_ID>` 替换为在上一步中检索到的 {{site.data.keyword.Bluemix_notm}} 帐户的标识。

    如果使用的是 {{site.data.keyword.Bluemix_notm}} API 密钥，那么必须使用为其创建 API 密钥的 {{site.data.keyword.Bluemix_notm}} 帐户标识。要访问其他帐户中的集群，请登录此帐户并创建基于此帐户的 {{site.data.keyword.Bluemix_notm}} API 密钥。
    {: note}

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    示例：
    ```
        POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    要指定 {{site.data.keyword.Bluemix_notm}} 区域，请[复查 API 端点中使用的区域缩写](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    <table summary-"Input parameters to retrieve tokens">
    <caption>用于获取令牌的输入参数</caption>
    <thead>
        <th>输入参数</th>
        <th>值</th>
    </thead>
    <tbody>
    <tr>
    <td>头</td>
    <td><ul><li>`Content-Type:application/x-www-form-urlencoded`</li> <li>`Authorization: Basic Yng6Yng=`<p><strong>注</strong>：<code>Yng6Yng=</code> 是针对用户名 <strong>bx</strong> 和密码 <strong>bx</strong> 的 URL 编码授权。</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 用户名和密码的主体</td>
    <td><ul><li>`grant_type: password`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`username: <em>&lt;username&gt;</em>`</li>
    <li>`password: <em>&lt;password&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:``</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul>
    <strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} API 密钥的主体</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:apikey`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`apikey: <em>&lt;api_key&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:``</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul>
      <strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 一次性密码的主体</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:passcode`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`passcode: <em>&lt;passcode&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret: `</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul><strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    </tbody>
    </table>

    示例 API 输出：

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    

    ```
    {: screen}

    您可以在 **access_token** 中找到 {{site.data.keyword.Bluemix_notm}} IAM 令牌，在 **refresh_token** 中找到刷新令牌。

4.  列出您帐户中的所有 Kubernetes 集群。使用在先前步骤中检索到的信息来构建头信息。


     ```
     GET https://containers.cloud.ibm.com/v1/clusters
     ```
     {: codeblock}

     <table summary="用于使用 API 的输入参数">
         <caption>用于使用 API 的输入参数</caption>
     <thead>
     <th>输入参数</th>
     <th>值</th>
     </thead>
     <tbody>
     <tr>
     <td>头</td>
     <td><ul><li>`Authorization: bearer <em>&lt;iam_token&gt;</em>`</li>
     <li>`X-Auth-Refresh-Token: <em>&lt;refresh_token&gt;</em>`</li></ul></td>
     </tr>
     </tbody>
     </table>

5.  请查看 [{{site.data.keyword.containerlong_notm}} API 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://containers.cloud.ibm.com/swagger-api)，以查找受支持 API 的列表。

<br />


## 使用 API 刷新 {{site.data.keyword.Bluemix_notm}} IAM 访问令牌并获取新的刷新令牌
{: #cs_api_refresh}

通过 API 发出的每个 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 访问令牌都会在 1 小时后到期。必须定期刷新访问令牌才可确保对 {{site.data.keyword.Bluemix_notm}} API 的访问权。
您可以使用相同的步骤来获取新的刷新令牌。
{:shortdesc}

开始之前，请确保您拥有可用于请求新访问令牌的 {{site.data.keyword.Bluemix_notm}} IAM 刷新令牌或 {{site.data.keyword.Bluemix_notm}} API 密钥。
- **刷新令牌：**遵循[使用 {{site.data.keyword.Bluemix_notm}} API 自动执行集群创建和管理过程](#cs_api)中的指示信息。
- **API 密钥：**如下所示检索您的 [{{site.data.keyword.Bluemix_notm}} ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/) API 密钥。
   1. 在菜单栏中，单击**管理 ** > **访问权 (IAM)**。
   2. 单击**用户**页面，然后选择您自己。
   3. 在 **API 密钥**窗格中，单击**创建 IBM Cloud API 密钥**。
   4. 输入 API 密钥的**名称**和**描述**，然后单击**创建**。
   4. 单击**显示**以查看生成的 API 密钥。
   5. 复制 API 密钥，以便可以将其用于检索新的 {{site.data.keyword.Bluemix_notm}} IAM 访问令牌。

如果要创建 {{site.data.keyword.Bluemix_notm}} IAM 令牌或要获取新的刷新令牌，请执行以下步骤。

1.  使用刷新令牌或 {{site.data.keyword.Bluemix_notm}} API 密钥来生成新的 {{site.data.keyword.Bluemix_notm}} IAM 访问令牌。
    ```
    POST https://iam.bluemix.net/identity/token
    ```
    {: codeblock}

    <table summary="用于新 IAM 令牌的输入参数">
         <caption>用于新 {{site.data.keyword.Bluemix_notm}} IAM 令牌的输入参数</caption>
    <thead>
    <th>输入参数</th>
    <th>值</th>
    </thead>
    <tbody>
    <tr>
    <td>头</td>
    <td><ul><li>`Content-Type: application/x-www-form-urlencoded`</li>
      <li>`Authorization: Basic Yng6Yng=`</br></br><strong>注</strong>：<code>Yng6Yng=</code> 是针对用户名 <strong>bx</strong> 和密码 <strong>bx</strong> 的 URL 编码授权。</li></ul></td>
    </tr>
    <tr>
    <td>使用刷新令牌时的主体</td>
    <td><ul><li>`grant_type: refresh_token`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`refresh_token: <em>&lt;iam_refresh_token&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret: `</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul><strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    <tr>
      <td>使用 {{site.data.keyword.Bluemix_notm}} API 密钥时的主体</td>
      <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:apikey`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`apikey: <em>&lt;api_key&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
        <li>`uaa_client_secret: `</li></ul><strong>注</strong>：添加不指定值的 <code>uaa_client_secret</code> 键。</td>
    </tr>
    </tbody>
    </table>

    示例 API 输出：

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    

    ```
    {: screen}

    您可以在 API 输出的 **access_token** 字段中找到新的 {{site.data.keyword.Bluemix_notm}} IAM 令牌，在 **refresh_token** 字段中找到刷新令牌。

2.  使用上一步中的令牌，继续执行 [{{site.data.keyword.containerlong_notm}} API 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://containers.cloud.ibm.com/swagger-api) 中的操作。

<br />


## 使用 CLI 刷新 {{site.data.keyword.Bluemix_notm}} IAM 访问令牌并获取新的刷新令牌
{: #cs_cli_refresh}

启动新的 CLI 会话时，或者如果当前 CLI 会话已超过 24 小时，那么必须通过运行 `ibmcloud ks cluster-config <cluster_name>`. 使用此命令设置集群的上下文时，将下载 Kubernetes 集群的 `kubeconfig` 文件。此外，还会发出 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 标识令牌和刷新令牌以用于提供认证。
{: shortdesc}

**标识令牌**：通过 CLI 发出的每个 IAM 标识令牌都会在 1 小时后到期。标识令牌到期时，会向令牌提供程序发送刷新令牌以刷新标识令牌。这将刷新您的认证，随后您可以继续对集群运行命令。

**刷新令牌**：刷新令牌每 30 天到期一次。如果刷新令牌到期，那么无法刷新标识令牌，并且您无法在 CLI 中继续运行命令。您可以通过运行 `ibmcloud ks cluster-config <cluster_name>`. 此命令还会刷新标识令牌。
