---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 区域和位置
{{site.data.keyword.Bluemix}} 在全球托管。区域是由端点访问的地理区域。位置是该区域内的数据中心。{{site.data.keyword.Bluemix_notm}} 内的服务可以在全球可用或在特定区域内可用。
{:shortdesc}

[{{site.data.keyword.Bluemix_notm}} 区域](#bluemix_regions)与 [{{site.data.keyword.containershort_notm}} 区域](#container_regions)不同。

支持的 {{site.data.keyword.containershort_notm}} 区域：
  * 亚太地区南部
  * 欧洲中部
  * 英国南部
  * 美国东部
  * 美国南部

## {{site.data.keyword.Bluemix_notm}} 区域 API 端点
{: #bluemix_regions}

您可以使用 {{site.data.keyword.Bluemix_notm}} 区域在 {{site.data.keyword.Bluemix_notm}} 服务之间组织资源。例如，您可以通过使用存储在同一区域的 {{site.data.keyword.registryshort_notm}} 中的专用 Docker 映像来创建 Kubernetes 集群。
{:shortdesc}

要检查您当前所在的 {{site.data.keyword.Bluemix_notm}} 区域，请运行 `bx info` 并查看**区域**字段。

可以通过在登录时指定 API 端点来访问 {{site.data.keyword.Bluemix_notm}} 区域。如果未指定区域，那么您会自动登录到离您最近的区域。

使用示例登录命令的 {{site.data.keyword.Bluemix_notm}} 区域 API 端点：

  * 美国南部和美国东部
      ```
          bx login -a api.ng.bluemix.net
          ```
      {: pre}

  * 悉尼
      ```
        bx login -a api.au-syd.bluemix.net
        ```
      {: pre}

  * 德国
      ```
           bx login -a api.eu-de.bluemix.net
           ```
      {: pre}

  * 英国
      ```
           bx login -a api.eu-gb.bluemix.net
           ```
      {: pre}



<br />


## {{site.data.keyword.containershort_notm}} 区域 API 端点和位置
{: #container_regions}

通过使用 {{site.data.keyword.containershort_notm}} 区域，您可以在除您登录的 {{site.data.keyword.Bluemix_notm}} 区域以外的区域中创建或访问 Kibernetes 集群。
{{site.data.keyword.containershort_notm}} 区域端点具体参考 {{site.data.keyword.containershort_notm}}，而不是作为一个整体参考 {{site.data.keyword.Bluemix_notm}}。
{:shortdesc}

{{site.data.keyword.containershort_notm}} 区域 API 端点：
  * 亚太地区南部：`https://ap-south.containers.bluemix.net`
  * 欧洲中部：`https://eu-central.containers.bluemix.net`
  * 英国南部：`https://uk-south.containers.bluemix.net`
  * 美国东部：`https://us-east.containers.bluemix.net`
  * 美国南部：`https://us-south.containers.bluemix.net`

**注：**美国东部仅可与 CLI 命令一起使用。

要检查您当前所在的 {{site.data.keyword.containershort_notm}} 区域，请运行 `bx cs api` 并查看**区域**字段。

### 登录到其他容器服务区域
{: #container_login_endpoints}

出于以下原因，您可能希望登录到其他 {{site.data.keyword.containershort_notm}} 区域：
  * 您在一个区域中创建了 {{site.data.keyword.Bluemix_notm}} 服务或专用 Docker 映像，并希望将其用于另一个区域中的 {{site.data.keyword.containershort_notm}}。
  * 您希望访问与登录到的缺省 {{site.data.keyword.Bluemix_notm}} 区域不同的区域中的集群。

</br>

用于登录到 {{site.data.keyword.containershort_notm}} 区域的示例命令：
  * 亚太地区南部：
    ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
    {: pre}

  * 欧洲中部：
    ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
    {: pre}

  * 英国南部：
    ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
    {: pre}

  * 美国东部：
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * 美国南部：
    ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
    {: pre}

### 在容器服务区域中创建 Lite 集群
{: #lite_regions}

您可以在以下区域中创建 Kubernetes Lite 集群：
  * 亚太地区南部
  * 欧洲中部
  * 英国南部
  * 美国南部

### 可供容器服务使用的位置
{: #locations}

位置是区域内可用的数据中心。

  | 区域| 位置| 城市|
  |--------|----------|------|
  | 亚太地区南部| mel01、syd01、syd04        | 墨尔本、悉尼|
  | 欧洲中部| ams03、fra02        | 阿姆斯特丹、法兰克福|
  | 英国南部| lon02、lon04         | 伦敦|
  | 美国东部| wdc06、wdc07        | 华盛顿|
  | 美国南部| dal10、dal12、dal13       | 达拉斯|

### 使用容器服务 API 命令
{: #container_api}

要与 {{site.data.keyword.containershort_notm}} API 交互，请输入命令类型并将 `/v1/command` 附加到端点。

美国南部的 `GET /clusters` API 示例：
  ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
  {: codeblock}

</br>

要查看有关 API 命令的文档，请将 `swagger-api` 附加到要查看的区域的端点。
  * 亚太地区南部：https://ap-south.containers.bluemix.net/swagger-api/
  * 欧洲中部：https://eu-central.containers.bluemix.net/swagger-api/
  * 英国南部：https://uk-south.containers.bluemix.net/swagger-api/
  * 美国东部：https://us-east.containers.bluemix.net/swagger-api/
  * 美国南部：https://us-south.containers.bluemix.net/swagger-api/
