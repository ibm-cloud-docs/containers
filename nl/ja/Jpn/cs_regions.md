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

# 地域とロケーション
{{site.data.keyword.Bluemix}} は、世界中でホストされています。地域とは、エンドポイントによってアクセスされる地理的領域のことです。ロケーションとは、地域内のデータ・センターのことです。{{site.data.keyword.Bluemix_notm}} 内のサービスは、グローバルに使用できるものもありますし、特定の地域内で使用できるものもあります。
{:shortdesc}

[{{site.data.keyword.Bluemix_notm}} 地域](#bluemix_regions)は [{{site.data.keyword.containershort_notm}} 地域](#container_regions)とは異なります。

![{{site.data.keyword.containershort_notm}} 地域とデータ・センター](/images/regions.png)

図 1. {{site.data.keyword.containershort_notm}} 地域とデータ・センター

サポートされる {{site.data.keyword.containershort_notm}} 地域は次のとおりです。
  * 北アジア太平洋地域
  * 南アジア太平洋地域
  * 中欧
  * 英国南部
  * 米国東部
  * 米国南部

Kubernetes ライト・クラスターを以下の地域に作成することができます。
  * 南アジア太平洋地域
  * 中欧
  * 英国南部
  * 米国南部

  **注**: 有料カスタマーではない場合、米国南部地域にライト・クラスターを作成することはできません。


## {{site.data.keyword.Bluemix_notm}} 地域の API エンドポイント
{: #bluemix_regions}

{{site.data.keyword.Bluemix_notm}} 地域を使用して、{{site.data.keyword.Bluemix_notm}} サービス間のリソースを編成できます。例えば、同じ地域の {{site.data.keyword.registryshort_notm}} に保管されるプライベート Docker イメージを使用して、Kubernetes クラスターを作成することができます。
{:shortdesc}

現在どの {{site.data.keyword.Bluemix_notm}} 地域にいるのかを確認するには、`bx info` を実行し、**Region** フィールドを確認します。

{{site.data.keyword.Bluemix_notm}} 地域には、ログイン時に API エンドポイントを指定することによってアクセスできます。地域を指定しない場合、最も近い地域に自動的にログインします。

{{site.data.keyword.Bluemix_notm}} 地域の API エンドポイントを指定したログイン・コマンドの例を以下に示します。

  * 米国南部と米国東部
      ```
bx login -a api.ng.bluemix.net```
      {: pre}

  * シドニーと北アジア太平洋地域
      ```
bx login -a api.au-syd.bluemix.net```
      {: pre}

  * ドイツ

      ```
          bx login -a api.eu-de.bluemix.net
          ```
      {: pre}

  * 英国
      ```
bx login -a api.eu-gb.bluemix.net```
      {: pre}



<br />


## {{site.data.keyword.containershort_notm}} 地域の API エンドポイントとロケーション
{: #container_regions}

{{site.data.keyword.containershort_notm}} 地域を使用して、ログインしている {{site.data.keyword.Bluemix_notm}} 地域以外の地域で、Kubernetes クラスターの作成とアクセスを行うことができます。{{site.data.keyword.containershort_notm}} 地域のエンドポイントとは、{{site.data.keyword.Bluemix_notm}} 全体ではなく、{{site.data.keyword.containershort_notm}} のみを指します。
{:shortdesc}

{{site.data.keyword.containershort_notm}} 地域の API エンドポイントは、以下のようになります。
  * 北アジア太平洋地域: `https://ap-north.containers.bluemix.net`
  * 南アジア太平洋地域: `https://ap-south.containers.bluemix.net`
  * 中欧: `https://eu-central.containers.bluemix.net`
  * 英国南部: `https://uk-south.containers.bluemix.net`
  * 米国東部: `https://us-east.containers.bluemix.net`
  * 米国南部: `https://us-south.containers.bluemix.net`

現在どの {{site.data.keyword.containershort_notm}} 地域にいるのかを確認するには、`bx cs api` を実行し、**Region** フィールドを確認します。

### 別のコンテナー・サービス地域へのログイン
{: #container_login_endpoints}

以下の理由で、別の {{site.data.keyword.containershort_notm}} 地域にログインしたい場合があります。
  * ある地域で作成した {{site.data.keyword.Bluemix_notm}} サービスまたはプライベート Docker イメージを、別の地域の {{site.data.keyword.containershort_notm}} で使用したい。
  * ログインしているデフォルトの {{site.data.keyword.Bluemix_notm}} 地域とは別の地域のクラスターにアクセスしたい。

</br>

{{site.data.keyword.containershort_notm}} 地域にログインするためのコマンドの例を以下に示します。
  * 北アジア太平洋地域:
    ```
    bx cs init --host https://ap-north.containers.bluemix.net
    ```
  {: pre}

  * 南アジア太平洋地域:
    ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
    {: pre}

  * 中欧:
    ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
    {: pre}

  * 英国南部:
    ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
    {: pre}

  * 米国東部:
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * 米国南部:
    ```
bx cs init --host https://us-south.containers.bluemix.net```
    {: pre}


### コンテナー・サービスを使用できるロケーション
{: #locations}

ロケーションとは、地域内で使用できるデータ・センターのことです。

  | 地域| ロケーション| 市区町村|
  |--------|----------|------|
  | 北アジア太平洋地域 | hkg02、tok02 | 香港、東京 |
  | 南アジア太平洋地域| mel01、syd01、syd04 | メルボルン、シドニー|
  | 中欧| ams03、fra02、par01        | アムステルダム、フランクフルト、パリ |
  | 英国南部| lon02、lon04 | London (ロンドン)|
  | 米国東部| tor01、wdc06、wdc07        | トロント、ワシントン DC |
  | 米国南部| dal10、dal12、dal13 | ダラス |

### コンテナー・サービスの API コマンドの使用
{: #container_api}

{{site.data.keyword.containershort_notm}} API と対話するには、コマンド・タイプを入力し、エンドポイントに `/v1/command` を追加します。

米国南部における `GET /clusters` API の例を示します。
  ```
GET https://us-south.containers.bluemix.net/v1/clusters```
  {: codeblock}

</br>

API コマンドの資料を表示するには、表示する地域のエンドポイントに `swagger-api` を追加します。
  * 北アジア太平洋地域: https://ap-north.containers.bluemix.net/swagger-api/
  * 南アジア太平洋地域: https://ap-south.containers.bluemix.net/swagger-api/
  * 中欧: https://eu-central.containers.bluemix.net/swagger-api/
  * 英国南部: https://uk-south.containers.bluemix.net/swagger-api/
  * 米国東部: https://us-east.containers.bluemix.net/swagger-api/
  * 米国南部: https://us-south.containers.bluemix.net/swagger-api/
