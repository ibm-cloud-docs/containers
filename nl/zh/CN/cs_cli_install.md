---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 设置 CLI 和 API
{: #cs_cli_install}

可以使用 {{site.data.keyword.containershort_notm}} CLI 或 API 来创建和管理 Kubernetes 集群。
{:shortdesc}

## 安装 CLI
{: #cs_cli_install_steps}

安装必需的 CLI 以在 {{site.data.keyword.containershort_notm}} 中创建和管理 Kubernetes 集群，并将容器化应用程序部署到集群。
{:shortdesc}

此任务包含用于安装这些 CLI 和插件的信息：

-   {{site.data.keyword.Bluemix_notm}} CLI V0.5.0 或更高版本
-   {{site.data.keyword.containershort_notm}} 插件
-   Kubernetes CLI V1.5.6 或更高版本
-   可选：{{site.data.keyword.registryshort_notm}} 插件
-   可选：Docker V1.9 或更高版本

<br>
要安装 CLI，请执行以下操作：

1.  作为 {{site.data.keyword.containershort_notm}} 插件的必备软件，请安装 [{{site.data.keyword.Bluemix_notm}} CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://clis.ng.bluemix.net/ui/home.html)。用于通过 {{site.data.keyword.Bluemix_notm}} CLI 运行命令的前缀是 `bx`。

2.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。

    ```
    bx login
    ```
    {: pre}

    **注**：如果您有联合标识，请使用 `bx login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。



4.  要创建 Kubernetes 集群以及管理工作程序节点，请安装 {{site.data.keyword.containershort_notm}} 插件。用于通过 {{site.data.keyword.containershort_notm}} 插件运行命令的前缀是 `bx cs`。

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    要验证是否已正确安装该插件，请运行以下命令：

    ```
    bx plugin list
    ```
    {: pre}

    {{site.data.keyword.containershort_notm}} 插件会在结果中显示为 container-service。

5.  要查看 Kubernetes 仪表板的本地版本以及将应用程序部署到集群，请[安装 Kubernetes CLI ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)。用于通过 Kubernetes CLI 来运行命令的前缀是 `kubectl`。

    1.  下载 Kubernetes CLI。

        OS X：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **提示：**如果使用的是 Windows，请将 Kubernetes CLI 安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中。此安装将在您以后运行命令时减少一些文件路径更改操作。

    2.  对于 OSX 和 Linux 用户，请完成以下步骤。
        1.  将可执行文件移至 `/usr/local/bin` 目录。

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
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

        3.  将二进制文件转换为可执行文件。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6.  要管理专用映像存储库，请安装 {{site.data.keyword.registryshort_notm}} 插件。使用此插件可在 IBM 托管的具备高可用性和高可扩展性的多租户专用映像注册表中设置自己的名称空间，存储 Docker 映像并与其他用户共享这些映像。要将容器部署到集群中，Docker 映像是必需的。用于运行注册表命令的前缀是 `bx cr`。

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    要验证是否已正确安装该插件，请运行以下命令：

    ```
    bx plugin list
    ```
    {: pre}

    该插件会在结果中显示为 container-registry。

7.  要在本地构建映像并将其推送到注册表名称空间，请[安装 Docker ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.docker.com/community-edition#/download)。如果使用的是 Windows 8 或更低版本，可以改为安装 [Docker Toolbox ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.docker.com/products/docker-toolbox)。Docker CLI 用于将应用程序构建成映像。用于通过 Docker CLI 运行命令的前缀是 `docker`。

接下来，开始[使用 {{site.data.keyword.containershort_notm}} 通过 CLI 创建 Kubernetes 集群](cs_cluster.html#cs_cluster_cli)。

有关这些 CLI 的参考信息，请参阅那些工具的文档。

-   [`bx` 命令](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [`bx cs` 命令](cs_cli_reference.html#cs_cli_reference)
-   [`kubectl` 命令 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [`bx cr` 命令](/docs/cli/plugins/registry/index.html#containerregcli)

## 将 CLI 配置为运行 `kubectl`
{: #cs_cli_configure}

您可以使用 Kubernetes CLI 随附的命令，在 {{site.data.keyword.Bluemix_notm}} 中管理集群。支持 Kubernetes 1.5.6 中可用的所有 `kubectl` 命令用于 {{site.data.keyword.Bluemix_notm}} 中的集群。创建集群后，使用环境变量，将本地 CLI 的上下文设置到该集群。
然后，您可以运行 Kubernetes `kubectl` 命令，以在 {{site.data.keyword.Bluemix_notm}} 中使用集群。
{:shortdesc}

[安装必需的 CLI](#cs_cli_install) 并[创建集群](cs_cluster.html#cs_cluster_cli)后，才能运行 `kubectl` 命令。

1.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。

    ```
    bx login
    ```
    {: pre}

    要指定特定的 {{site.data.keyword.Bluemix_notm}} 区域，请包含相应的 API 端点。如果有专用 Docker 映像存储在特定 {{site.data.keyword.Bluemix_notm}} 区域或者已经创建的 {{site.data.keyword.Bluemix_notm}} 服务实例的容器注册表中，请登录到此区域来访问映像和 {{site.data.keyword.Bluemix_notm}} 服务。


    您登录到的 {{site.data.keyword.Bluemix_notm}} 区域还决定了可以在其中创建 Kubernetes 集群的区域，包括可用的数据中心。如果未指定区域，那么您会自动登录到离您最近的区域。
      -   美国南部

          ```
          bx login -a api.ng.bluemix.net
          ```
          {: pre}

      -   悉尼

          ```
          bx login -a api.au-syd.bluemix.net
          ```
          {: pre}

      -   德国

          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   英国

          ```
          bx login -a api.eu-gb.bluemix.net
          ```
          {: pre}

    **注**：如果您有联合标识，请使用 `bx login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。

2.  选择 {{site.data.keyword.Bluemix_notm}} 帐户。如果您分配有多个 {{site.data.keyword.Bluemix_notm}} 组织，请选择在其中创建集群的组织。集群是特定于组织的，但又独立于 {{site.data.keyword.Bluemix_notm}} 空间。因此，您无需选择空间。

3.  如果要在除了先前所选 {{site.data.keyword.Bluemix_notm}} 区域以外的区域中创建或访问 Kubernetes 集群，请指定此区域。例如，出于以下原因，您可能希望登录到其他 {{site.data.keyword.containershort_notm}} 区域：
   -   您在一个区域中创建了 {{site.data.keyword.Bluemix_notm}} 服务或专用 Docker 映像，并希望将其用于另一个区域中的 {{site.data.keyword.containershort_notm}}。
   -   您希望访问与登录到的缺省 {{site.data.keyword.Bluemix_notm}} 区域不同的区域中的集群。<br>
在以下 API 端点中进行选择：
        - 美国南部：
          ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
          {: pre}

        - 英国南部：
          ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
          {: pre}

        - 欧洲中部：
          ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
          {: pre}

        - 亚太南部：
          ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
          {: pre}

4.  列出帐户中的所有集群以获取集群的名称。

    ```
    bx cs clusters
    ```
    {: pre}

5.  将所创建的集群设置为此会话的上下文。每次使用集群时都完成这些配置步骤。
    1.  获取命令以设置环境变量并下载 Kubernetes 配置文件。


        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        下载配置文件后，会显示一个命令，您可以使用该命令将本地 Kubernetes 配置文件的路径设置为环境变量。

        示例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  复制并粘贴终端中显示的命令，以设置 `KUBECONFIG` 环境变量。
    3.  验证已正确设置 `KUBECONFIG` 环境变量。


        示例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        输出：
        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

6.  通过检查 Kubernetes CLI 服务器版本，验证 `kubectl` 命令是否针对您的集群正常运行。

    ```
    kubectl version  --short
    ```
    {: pre}

    输出示例：

    ```
    Client Version: v1.5.6
    Server Version: v1.5.6
    ```
    {: screen}


现在，可以运行 `kubectl` 命令，在 {{site.data.keyword.Bluemix_notm}} 中管理集群。有关完整的命令列表，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)。

**提示：**如果使用的是 Windows，而 Kubernetes CLI 未安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中，那么必须将目录更改为 Kubernetes CLI 的安装路径才能成功运行 `kubectl` 命令。

## 更新 CLI
{: #cs_cli_upgrade}

您可能想要定期更新 CLI 以使用新功能。
{:shortdesc}

此任务包含用于更新这些 CLI 的信息。

-   {{site.data.keyword.Bluemix_notm}} CLI V0.5.0 或更高版本
-   {{site.data.keyword.containershort_notm}} 插件
-   Kubernetes CLI V1.5.6 或更高版本
-   {{site.data.keyword.registryshort_notm}} 插件
-   Docker V1.9 或更高版本

<br>
要更新 CLI，请执行以下操作：
1.  更新 {{site.data.keyword.Bluemix_notm}} CLI。下载[最新版本 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://clis.ng.bluemix.net/ui/home.html) 并运行安装程序。

2.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。根据提示，输入您的 {{site.data.keyword.Bluemix_notm}} 凭证。

    ```
    bx login
    ```
     {: pre}

    要指定特定的 {{site.data.keyword.Bluemix_notm}} 区域，请包含相应的 API 端点。如果有专用 Docker 映像存储在特定 {{site.data.keyword.Bluemix_notm}} 区域或者已经创建的 {{site.data.keyword.Bluemix_notm}} 服务实例的容器注册表中，请登录到此区域来访问映像和 {{site.data.keyword.Bluemix_notm}} 服务。

    您登录到的 {{site.data.keyword.Bluemix_notm}} 区域还决定了可以在其中创建 Kubernetes 集群的区域，包括可用的数据中心。如果未指定区域，那么您会自动登录到离您最近的区域。

    -   美国南部

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

    -   悉尼

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -   德国

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -   英国

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

        **注**：如果您有联合标识，请使用 `bx login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。

3.  更新 {{site.data.keyword.containershort_notm}} 插件。
    1.  通过 {{site.data.keyword.Bluemix_notm}} 插件存储库安装更新。

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  通过运行以下命令并检查已安装的插件的列表来验证插件安装。

        ```
        bx plugin list
        ```
        {: pre}

        {{site.data.keyword.containershort_notm}} 插件会在结果中显示为 container-service。

    3.  初始化 CLI。

        ```
        bx cs init
        ```
        {: pre}

4.  更新 Kubernetes CLI。
    1.  下载 Kubernetes CLI。

        OS X：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **提示：**如果使用的是 Windows，请将 Kubernetes CLI 安装在 {{site.data.keyword.Bluemix_notm}} CLI 所在的目录中。此安装将在您以后运行命令时减少一些文件路径更改操作。

    2.  对于 OSX 和 Linux 用户，请完成以下步骤。
        1.  将可执行文件移至 /usr/local/bin 目录。

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
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

        3.  将二进制文件转换为可执行文件。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  更新 {{site.data.keyword.registryshort_notm}} 插件。
    1.  通过 {{site.data.keyword.Bluemix_notm}} 插件存储库安装更新。

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  通过运行以下命令并检查已安装的插件的列表来验证插件安装。

        ```
        bx plugin list
        ```
        {: pre}

        Registry 插件会在结果中显示为 container-registry。

6.  更新 Docker。
    -   如果您使用 Docker Community Edition，请启动 Docker，单击 **Docker** 图标并单击**检查更新**。
    -   如果使用的是 Docker Toolbox，请下载[最新版本 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.docker.com/products/docker-toolbox) 并运行安装程序。

## 卸载 CLI
{: #cs_cli_uninstall}

如果不再需要 CLI，可以将其卸载。
{:shortdesc}

此任务包含用于除去以下 CLI 的信息：


-   {{site.data.keyword.containershort_notm}} 插件
-   Kubernetes CLI V1.5.6 或更高版本
-   {{site.data.keyword.registryshort_notm}} 插件
-   Docker V1.9 或更高版本

<br>
要卸载 CLI，请执行以下操作：

1.  卸载 {{site.data.keyword.containershort_notm}} 插件。

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  卸载 {{site.data.keyword.registryshort_notm}} 插件。

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  通过运行以下命令并检查已安装的插件的列表，验证插件是否已卸载。

    ```
    bx plugin list
    ```
    {: pre}

    container-service 和 container-registry 插件未显示在结果中。





6.  卸载 Docker。有关卸载 Docker 的指示信息因您使用的操作系统不同而有所不同。

    <table summary="用于卸载 Docker 的特定于操作系统的指示信息">
     <tr>
      <th>操作系统</th>
      <th>链接</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>选择通过 [GUI 或命令行 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset) 卸载 Docker</td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>有关卸载 Docker 的指示信息因您使用的 Linux 分发版不同而有所不同。要为 Ubuntu 卸载 Docker，请参阅[卸载 Docker ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce)。使用此链接来查找有关如何通过从导航选择分发版来卸载其他 Linux 分发版的 Docker 的指示信息。</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>卸载 [Docker Toolbox ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox)。</td>
      </tr>
    </table>

## 使用 API 自动部署集群
{: #cs_api}

可以使用 {{site.data.keyword.containershort_notm}} API 来自动创建、部署和管理 Kubernetes 集群。
{:shortdesc}

{{site.data.keyword.containershort_notm}} API 需要您必须在 API 请求中提供的头信息，根据您要使用的 API，这些头信息可以有所不同。
要确定 API 需要哪些头信息，请参阅 [{{site.data.keyword.containershort_notm}} API 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://us-south.containers.bluemix.net/swagger-api)。

以下步骤提供的指示信息说明如何检索此头信息，以便您可以将其包含在 API 请求中。

1.  检索 IAM（身份和访问管理）访问令牌。需要 IAM 访问令牌才能登录到 {{site.data.keyword.containershort_notm}}。将 _&lt;my_bluemix_username&gt;_ 和 _&lt;my_bluemix_password&gt;_ 替换为您的 {{site.data.keyword.Bluemix_notm}} 凭证。


    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Input parameters to get tokens">
      <tr>
        <th>输入参数</th>
        <th>值</th>
      </tr>
      <tr>
        <td>头</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>主体</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret: </li></ul>
        <p>**注**：添加不指定值的 uaa_client_secret 密钥。</p></td>
      </tr>
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

    您可以在 API 输出的 **access_token** 字段中找到 IAM 令牌，在 **uaa_token**字段中找到 UAA 令牌。请记下 IAM 和 UAA 令牌以在后续步骤中用于检索更多头信息。

2.  检索要在其中创建和管理集群的 {{site.data.keyword.Bluemix_notm}} 帐户的标识。将 _&lt;iam_token&gt;_ 替换为在上一步中检索到的 IAM 令牌。

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="用于获取 Bluemix 帐户标识的输入参数">
   <tr>
    <th>输入参数</th>
    <th>值</th>
   </tr>
   <tr>
    <td>头</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json
</li></ul></td>
   </tr>
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
"guid": "<my_bluemix_account_id>",
            "url": "/v1/accounts/<my_bluemix_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    可以在 API 输出的 **resources/metadata/guid** 字段中找到您的 {{site.data.keyword.Bluemix_notm}} 帐户的标识。

3.  检索包含 {{site.data.keyword.Bluemix_notm}} 帐户信息的新 IAM 令牌。将 _&lt;my_bluemix_account_id&gt;_ 替换为在上一步中检索到的 {{site.data.keyword.Bluemix_notm}} 帐户标识。

    **注**：IAM 访问令牌在 1 小时后到期。请查看[使用 API 刷新 IAM 访问令牌](#cs_api_refresh)，以了解有关如何刷新访问令牌的指示信息。

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="输入参数以获取访问令牌">
     <tr>
      <th>输入参数</th>
      <th>值</th>
     </tr>
     <tr>
      <td>头</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>主体</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret: <p>**注**：添加不指定值的 uaa_client_secret 密钥。</p>
        <li>bss_account: <em>&lt;my_bluemix_account_id&gt;</em></li></ul></td>
     </tr>
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

    您可以在 CLI 输出的 **access_token** 字段中找到 IAM 令牌，在 **refresh_token** 字段中找到 IAM 刷新令牌。

4.  检索要在其中创建或管理集群的 {{site.data.keyword.Bluemix_notm}} 空间的标识。
    1.  检索 API 端点以访问空间标识。将 _&lt;uaa_token&gt;_ 替换为在第一步中检索到的 UAA 令牌。

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="用于检索空间标识的输入参数">
         <tr>
          <th>输入参数</th>
          <th>值</th>
         </tr>
         <tr>
          <td>头</td>
          <td><ul><li> Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa_token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      示例 API 输出：

      ```
      {
            "metadata": {
"guid": "<my_bluemix_org_id>",
              "url": "/v2/organizations/<my_bluemix_org_id>",
              "created_at": "2016-01-07T18:55:19Z",
              "updated_at": "2016-02-09T15:56:22Z"
            },
            "entity": {
              "name": "<my_bluemix_org_name>",
              "billing_enabled": false,
              "quota_definition_guid": "<my_bluemix_org_id>",
              "status": "active",
              "quota_definition_url": "/v2/quota_definitions/<my_bluemix_org_id>",
              "spaces_url": "/v2/organizations/<my_bluemix_org_id>/spaces",
      ...

      ```
      {: screen}

5.  记下 **spaces_url** 字段的输出。
6.  使用 **spaces_url** 端点检索 {{site.data.keyword.Bluemix_notm}} 空间的标识。

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<my_bluemix_org_id>/spaces
      ```
      {: pre}

      示例 API 输出：

      ```
      {
            "metadata": {
"guid": "<my_bluemix_space_id>",
              "url": "/v2/spaces/<my_bluemix_space_id>",
              "created_at": "2016-01-07T18:55:22Z",
              "updated_at": null
            },
            "entity": {
              "name": "<my_bluemix_space_name>",
              "organization_guid": "<my_bluemix_org_id>",
              "space_quota_definition_guid": null,
              "allow_ssh": true,
      ...
      ```
      {: screen}

      可以在 API 输出的 **metadata/guid** 字段中找到您 {{site.data.keyword.Bluemix_notm}} 空间的标识。

7.  列出您帐户中的所有 Kubernetes 集群。使用在先前步骤中检索到的信息来构建头信息。


    -   美国南部

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   英国南部

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   欧洲中部

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   亚太南部

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

        <table summary="用于使用 API 的输入参数">
         <thead>
          <th>输入参数</th>
          <th>值</th>
         </thead>
          <tbody>
         <tr>
          <td>头</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  请查看 [{{site.data.keyword.containershort_notm}} API 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://us-south.containers.bluemix.net/swagger-api)，以查找受支持 API 的列表。

## 刷新 IAM 访问令牌
{: #cs_api_refresh}

通过 API 发出的每个 IAM（身份和访问权管理）访问令牌都会在 1 小时后到期。必须定期刷新访问令牌才可确保对 {{site.data.keyword.containershort_notm}} API 的访问权。
{:shortdesc}

开始之前，请确保您拥有可用于请求新访问令牌的 IAM 刷新令牌。如果没有刷新令牌，请查看[使用 {{site.data.keyword.containershort_notm}} API 自动执行集群创建和管理过程](#cs_api)来检索访问令牌。

如果要刷新 IAM 令牌，请使用以下步骤。

1.  检索新的 IAM 访问令牌。将 _&lt;iam_refresh_token&gt;_ 替换为首次向 {{site.data.keyword.Bluemix_notm}} 认证时接收到的 IAM 刷新令牌。

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="用于新 IAM 令牌的输入参数">
         <tr>
      <th>输入参数</th>
      <th>值</th>
     </tr>
     <tr>
      <td>头</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>主体</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret: <p>**注**：添加不指定值的 uaa_client_secret 密钥。</p></li><ul></td>
     </tr>
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

    您可以在 API 输出的 **access_token** 字段中找到新的 IAM 令牌，在 **refresh_token** 字段中找到 IAM 刷新令牌。

2.  使用上一步中的令牌，继续执行 [{{site.data.keyword.containershort_notm}} API 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://us-south.containers.bluemix.net/swagger-api) 中的操作。
