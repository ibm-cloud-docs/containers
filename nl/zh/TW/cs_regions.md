---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 地區及位置
{{site.data.keyword.Bluemix}} 是在全球各地管理。地區是端點所存取的地理區域。位置是地區內的資料中心。{{site.data.keyword.Bluemix_notm}} 內的服務可能在全球提供，或在特定地區內提供。
{:shortdesc}

[{{site.data.keyword.Bluemix_notm}} 地區](#bluemix_regions)與 [{{site.data.keyword.containershort_notm}} 地區](#container_regions)不同。

![{{site.data.keyword.containershort_notm}} 地區與資料中心](/images/regions.png)

圖 1. {{site.data.keyword.containershort_notm}} 地區與資料中心

支援的 {{site.data.keyword.containershort_notm}} 地區：
  * 亞太地區北部
  * 亞太地區南部
  * 歐盟中部
  * 英國南部
  * 美國東部
  * 美國南部

您可以在下列地區建立 Kubernetes 精簡叢集：
  * 亞太地區南部
  * 歐盟中部
  * 英國南部
  * 美國南部

  **附註**：如果您不是付費客戶，則無法在美國南部地區建立精簡叢集。


## {{site.data.keyword.Bluemix_notm}} 地區 API 端點
{: #bluemix_regions}

您可以使用 {{site.data.keyword.Bluemix_notm}} 地區，跨 {{site.data.keyword.Bluemix_notm}} 服務來組織資源。例如，您可以使用儲存在相同地區的 {{site.data.keyword.registryshort_notm}} 中的專用 Docker 映像檔，來建立 Kubernetes 叢集。
{:shortdesc}

若要檢查您目前所在的 {{site.data.keyword.Bluemix_notm}} 地區，請執行 `bx info`，並檢閱**地區**欄位。

{{site.data.keyword.Bluemix_notm}} 地區可以藉由在登入時指定 API 端點來存取。如果您未指定地區，則會將您自動登入最接近的地區。

{{site.data.keyword.Bluemix_notm}} 地區 API 端點與範例登入指令：

  * 美國南部及美國東部
      ```
      bx login -a api.ng.bluemix.net
      ```
      {: pre}

  * 雪梨及亞太地區北部
      ```
      bx login -a api.au-syd.bluemix.net
      ```
      {: pre}

  * 德國
      ```
      bx login -a api.eu-de.bluemix.net
      ```
      {: pre}

  * 英國
      ```
      bx login -a api.eu-gb.bluemix.net
      ```
      {: pre}



<br />


## {{site.data.keyword.containershort_notm}} 地區 API 端點及位置
{: #container_regions}

透過使用 {{site.data.keyword.containershort_notm}} 地區，您可以在您登入的 {{site.data.keyword.Bluemix_notm}} 地區以外的地區建立或存取 Kubernetes 叢集。{{site.data.keyword.containershort_notm}} 地區端點特指 {{site.data.keyword.containershort_notm}}，而不是 {{site.data.keyword.Bluemix_notm}} 整體。
{:shortdesc}

{{site.data.keyword.containershort_notm}} 地區 API 端點：
  * 亞太地區北部：`https://ap-north.containers.bluemix.net`
  * 亞太地區南部：`https://ap-south.containers.bluemix.net`
  * 歐盟中部：`https://eu-central.containers.bluemix.net`
  * 英國南部：`https://uk-south.containers.bluemix.net`
  * 美國東部：`https://us-east.containers.bluemix.net`
  * 美國南部：`https://us-south.containers.bluemix.net`

若要檢查您目前所在的 {{site.data.keyword.containershort_notm}} 地區，請執行 `bx cs api`，並檢閱**地區**欄位。

### 登入不同的容器服務地區
{: #container_login_endpoints}

您可能因為下列原因而想要登入另一個 {{site.data.keyword.containershort_notm}} 地區：
  * 您已在其中一個地區中建立 {{site.data.keyword.Bluemix_notm}} 服務或專用 Docker 映像檔，並且想要在另一個地區中將它們與 {{site.data.keyword.containershort_notm}} 搭配使用。
  * 您要在與您登入的預設 {{site.data.keyword.Bluemix_notm}} 地區不同的地區中存取叢集。

</br>

用來登入 {{site.data.keyword.containershort_notm}} 地區的範例指令：
  * 亞太地區北部：
    ```
    bx cs init --host https://ap-north.containers.bluemix.net
    ```
  {: pre}

  * 亞太地區南部：
    ```
    bx cs init --host https://ap-south.containers.bluemix.net
    ```
    {: pre}

  * 歐盟中部：
    ```
    bx cs init --host https://eu-central.containers.bluemix.net
    ```
    {: pre}

  * 英國南部：
    ```
    bx cs init --host https://uk-south.containers.bluemix.net
    ```
    {: pre}

  * 美國東部：
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * 美國南部：
    ```
    bx cs init --host https://us-south.containers.bluemix.net
    ```
    {: pre}


### 容器服務可用的位置
{: #locations}

位置是地區內可用的資料中心。

  | 地區| 位置| 城市|
  |--------|----------|------|
  | 亞太地區北部| hkg02、tok02| 香港、東京|
  | 亞太地區南部| mel01、syd01、syd04| 墨爾本、雪梨|
  | 歐盟中部| ams03、fra02、par01| 阿姆斯特丹、法蘭克福、巴黎|
  | 英國南部| lon02、lon04| 倫敦|
  | 美國東部| tor01、wdc06、wdc07| 多倫多、華盛頓特區|
  | 美國南部| dal10、dal12、dal13| 達拉斯|

### 使用容器服務 API 指令
{: #container_api}

若要與 {{site.data.keyword.containershort_notm}} API 互動，請輸入指令類型，並在端點附加 `/v1/command`。

美國南部的 `GET /clusters` API 範例：
  ```
  GET https://us-south.containers.bluemix.net/v1/clusters
  ```
  {: codeblock}

</br>

若要檢視 API 指令的文件，請將 `swagger-api` 附加至地區的端點以便檢視。
  * 亞太地區北部：https://ap-north.containers.bluemix.net/swagger-api/
  * 亞太地區南部：https://ap-south.containers.bluemix.net/swagger-api/
  * 歐盟中部：https://eu-central.containers.bluemix.net/swagger-api/
  * 英國南部：https://uk-south.containers.bluemix.net/swagger-api/
  * 美國東部：https://us-east.containers.bluemix.net/swagger-api/
  * 美國南部：https://us-south.containers.bluemix.net/swagger-api/
