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


# 基于映像构建容器
{: #images}

Docker 映像是所创建的每一个容器的基础。映像通过 Dockerfile 进行创建，此文件包含用于构建映像的指令。Dockerfile 可能会在其单独存储的指令中引用构建工件，例如应用程序、应用程序配置及其依赖项。
{:shortdesc}


## 规划映像注册表
{: #planning}

映像通常会存储在可以公共访问的注册表（公共注册表）中，或者存储在设置为仅供一小组用户访问的注册表（专用注册表）中。开始使用 Docker 和 Kubernetes 在集群中创建第一个容器化应用程序时，可以使用公共注册表（如 Docker Hub）。但是对于企业应用程序，请使用专用注册表（如在 {{site.data.keyword.registryshort_notm}} 中提供的注册表），以保护映像不被未经授权的用户使用和更改。专用注册表必须由集群管理员设置，以确保用于访问专用注册表的凭证可供集群用户使用。
{:shortdesc}

可以通过 {{site.data.keyword.containershort_notm}} 使用多个注册表将应用程序部署到集群。

|注册表|描述|优点|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|使用此选项，可以在 {{site.data.keyword.registryshort_notm}} 中设置自己的安全 Docker 映像存储库，在其中可以安全地存储映像并在集群用户之间共享这些映像。|<ul><li>管理对您帐户中映像的访问权。</li><li>将 {{site.data.keyword.IBM_notm}} 提供的映像和样本应用程序（如 {{site.data.keyword.IBM_notm}} Liberty）用作父映像，并向其添加自己的应用程序代码。</li><li>漏洞顾问程序会自动扫描映像以确定是否有潜在漏洞，包括特定于操作系统的漏洞修复建议。</li></ul>|
|其他任何专用注册表|通过创建 [imagePullSecret ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/containers/images/)，将任何现有专用注册表连接到集群。私钥用于将注册表 URL 和凭证安全地保存在 Kubernetes 私钥中。|<ul><li>独立于源（Docker Hub、组织拥有的注册表或其他云专用注册表）使用现有专用注册表。</li></ul>|
|公共 Docker Hub|使用此选项可在不需要 Dockerfile 更改时，通过 Docker Hub 直接使用现有公共映像。<p>**注**：请记住，此选项可能不满足您组织的安全需求，如访问管理、漏洞扫描或应用程序隐私。</p>|<ul><li>无需为集群进行其他设置。</li><li>包含各种开放式源代码应用程序。</li></ul>|
{: caption="表. 公共和专用映像注册表选项" caption-side="top"}

设置映像注册表后，集群用户可以使用映像将其应用程序部署到集群。


<br />



## 访问 {{site.data.keyword.registryshort_notm}} 中的名称空间
{: #namespace}

可以通过 IBM 提供的公共映像将容器部署到集群，也可以通过存储在 {{site.data.keyword.registryshort_notm}} 的名称空间中的专用映像来部署。
{:shortdesc}

开始之前：

1. [在 {{site.data.keyword.Bluemix_notm}} Public 或 {{site.data.keyword.Bluemix_dedicated_notm}} 的 {{site.data.keyword.registryshort_notm}} 中设置名称空间并将映像推送到此名称空间](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2. [创建集群](cs_clusters.html#clusters_cli)。
3. [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

创建集群时，会自动为[离得最近的区域注册表和全局注册表](/docs/services/Registry/registry_overview.html#registry_regions)创建不到期的注册表令牌和私钥。全局注册表用于安全地存储 IBM 提供的公共映像，您可以在不同部署中引用这些映像，而不用分别引用存储在各个区域注册表中的映像。区域注册表用于安全地存储您自己的专用 Docker 映像以及全局注册表中所存储的相同公共映像。令牌用于授予对 {{site.data.keyword.registryshort_notm}} 中设置的任一名称空间的只读访问权，以便您可以使用这些公共（全局注册表）映像和专用（区域注册表）映像。

每个令牌必须存储在 Kubernetes `imagePullSecret` 中，才能在部署容器化应用程序时供 Kubernetes 集群访问。创建集群时，{{site.data.keyword.containershort_notm}} 会自动将全局（IBM 提供的公共映像）和区域注册表的令牌存储在 Kubernetes 映像拉取私钥中。映像拉取私钥会添加到 `default` Kubernetes 名称空间、该名称空间的 `ServiceAccount` 中的缺省私钥列表以及 `kube-system` 名称空间。

**注**：使用此初始设置时，可以通过 {{site.data.keyword.Bluemix_notm}} 帐户的名称空间中可用的任何映像，将容器部署到集群的**缺省**名称空间。如果要将容器部署到集群的其他名称空间，或者如果要使用存储在其他 {{site.data.keyword.Bluemix_notm}} 区域或其他 {{site.data.keyword.Bluemix_notm}} 帐户中的映像，您必须[为集群创建自己的 imagePullSecret](#other)。

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
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}


<br />



## 访问其他 Kubernetes 名称空间、{{site.data.keyword.Bluemix_notm}} 区域和帐户中的映像
{: #other}

通过创建您自己的 imagePullSecret，可以将容器部署到其他 Kubernetes 名称空间，使用存储在其他 {{site.data.keyword.Bluemix_notm}} 区域或帐户中的映像，或者使用存储在 {{site.data.keyword.Bluemix_dedicated_notm}} 中的映像。
{:shortdesc}

开始之前：

1.  [在 {{site.data.keyword.Bluemix_notm}} Public 或 {{site.data.keyword.Bluemix_dedicated_notm}} 的 {{site.data.keyword.registryshort_notm}} 中设置名称空间并将映像推送到此名称空间](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2.  [创建集群](cs_clusters.html#clusters_cli)。
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
    <caption>表. 了解此命令的组成部分</caption>
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
        <caption>表. 了解 YAML 文件的组成部分</caption>
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


<br />



## 访问 Docker Hub 中的公共映像
{: #dockerhub}

可以使用存储在 Docker Hub 中的任何公共映像将容器部署到集群，而无需任何其他配置。
{:shortdesc}

开始之前：

1.  [创建集群](cs_clusters.html#clusters_cli)。
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
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}

<br />



## 访问存储在其他专用注册表中的映像
{: #private_images}

如果您已经拥有要使用的专用注册表，那么必须将相应的注册表凭证存储在 Kubernetes imagePullSecret 中，并在配置文件中引用此私钥。
{:shortdesc}

开始之前：

1.  [创建集群](cs_clusters.html#clusters_cli)。
2.  [设定 CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)。

要创建 imagePullSecret，请执行以下操作：

**注**：ImagePullSecret 对于创建它们时所用于的 Kubernetes 名称空间有效。对要通过专用 {{site.data.keyword.Bluemix_notm}} 注册表中的映像来部署容器的每个名称空间，重复这些步骤。

1.  创建 Kubernetes 私钥以用于存储专用注册表凭证。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表. 了解此命令的组成部分</caption>
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
        <caption>表. 了解 YAML 文件的组成部分</caption>
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

