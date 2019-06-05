---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks

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


# 地域とゾーン
{: #regions-and-zones}

地域は、アプリ、サービス、およびその他の {{site.data.keyword.Bluemix}} リソースをデプロイできる特定の地理的な場所です。 [{{site.data.keyword.Bluemix_notm}} 地域](#bluemix_regions)は [{{site.data.keyword.containerlong}} 地域](#container_regions)とは異なります。 地域は 1 つ以上のゾーンで構成されます。
ゾーンは物理データ・センターであり、サービスとアプリケーションをホストするためのコンピュート・リソース、ネットワーク・リソース、ストレージ・リソース、関連冷却機器および電源機器をホストしています。 単一障害点を共有しないようにゾーンは互いに独立しています。
{:shortdesc}

![{{site.data.keyword.containerlong_notm}} 地域とゾーン](images/regions-mz.png)

_{{site.data.keyword.containerlong_notm}} 地域とゾーン_

 {{site.data.keyword.Bluemix_notm}} は、世界中でホストされています。 {{site.data.keyword.Bluemix_notm}} 内のサービスは、グローバルに使用できるものもありますし、特定の地域内で使用できるものもあります。 {{site.data.keyword.containerlong_notm}} で Kubernetes クラスターを作成すると、そのリソースは、クラスターをデプロイした地域に残ります。

 標準クラスターは、サポートされるすべての {{site.data.keyword.containerlong_notm}} 地域で作成できます。 フリー・クラスターは、限定地域でのみ使用可能です。
{: note}

 | {{site.data.keyword.containerlong_notm}} 地域 | 対応する {{site.data.keyword.Bluemix_notm}} のロケーション |
| --- | --- |
| 北アジア太平洋地域 (標準クラスターのみ) | 東京 |
| 南アジア太平洋地域 | シドニー |
| 中欧 | フランクフルト |
| 英国南部 | ロンドン |
| 米国東部 (標準クラスターのみ) | ワシントン DC |
| 米国南部 | ダラス |
{: caption="Kubernetes Service のサポート対象地域および対応する IBM Cloud のロケーション" caption-side="top"}

 <br />


## {{site.data.keyword.Bluemix_notm}} のロケーション
{: #bluemix_regions}

{{site.data.keyword.Bluemix_notm}} のロケーション(地域とも呼ばれる) を使用して、{{site.data.keyword.Bluemix_notm}} サービス間のリソースを編成できます。 例えば、同じロケーションの {{site.data.keyword.registryshort_notm}} に保管されるプライベート Docker イメージを使用して、Kubernetes クラスターを作成することができます。
{:shortdesc}

グローバル API エンドポイントにログインするときに、{{site.data.keyword.Bluemix_notm}} 地域を指定できます。 使用可能な地域をリストするには、`ibmcloud regions` を実行します。 現在どの {{site.data.keyword.Bluemix_notm}} ロケーションにいるのかを確認するには、`ibmcloud target` を実行し、**Region** フィールドを確認します。 地域を指定しない場合は、地域を選択するプロンプトが表示されます。

例えば、ダラス (`us-south`) 地域のグローバル API エンドポイントにログインするには、以下を実行します。
```
ibmcloud login -a https://cloud.ibm.com -r us-south
```
{: pre}

グローバル API エンドポイントにログインしてから地域を選択するには、以下を実行します。
```
ibmcloud login -a https://cloud.ibm.com
```
{: pre}

出力例:
```
API endpoint: cloud.ibm.com

Get One Time Code from https://identity-2.eu-central.iam.cloud.ibm.com/identity/passcode to proceed.
Open the URL in the default browser? [Y/n]> y
One Time Code > 
Authenticating...
OK

Select an account:
1. MyAccount (00a11aa1a11aa11a1111a1111aaa11aa) <-> 1234567
2. TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321
Enter a number> 2
Targeted account TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321


Targeted resource group default

Select a region (or press enter to skip):
1. au-syd
2. jp-tok
3. eu-de
4. eu-gb
5. us-south
6. us-east
Enter a number> 5
Targeted region us-south


API endpoint:      https://cloud.ibm.com   
Region:            us-south   
User:              first.last@email.com   
Account:           TeamAccount (2bb222bb2b22222bbb2b2222bb2bb222) <-> 7654321  
Resource group:    default   
CF API endpoint:      
Org:                  
Space:                

...
```
{: screen}

<br />


## {{site.data.keyword.containerlong_notm}} の地域
{: #container_regions}

{{site.data.keyword.containerlong_notm}} 地域を使用して、ログインしている {{site.data.keyword.Bluemix_notm}} 地域以外の地域で、Kubernetes クラスターの作成とアクセスを行うことができます。 {{site.data.keyword.containerlong_notm}} 地域のエンドポイントとは、{{site.data.keyword.Bluemix_notm}} 全体ではなく、{{site.data.keyword.containerlong_notm}} のみを指します。
{:shortdesc}

標準クラスターは、サポートされるすべての {{site.data.keyword.containerlong_notm}} 地域で作成できます。 フリー・クラスターは、限定地域でのみ使用可能です。
{: note}

 サポートされる {{site.data.keyword.containerlong_notm}} 地域は次のとおりです。
  * 北アジア太平洋地域 (標準クラスターのみ)
  * 南アジア太平洋地域
  * 中欧
  * 英国南部
  * 米国東部 (標準クラスターのみ)
  * 米国南部

1 つのグローバルなエンドポイント `https://containers.cloud.ibm.com/v1` を使用して、{{site.data.keyword.containerlong_notm}} にアクセスできます。
* 現在自分が属する {{site.data.keyword.containerlong_notm}} 地域を確認するには、`ibmcloud ks region` を実行します。
* 使用可能な地域とそのエンドポイントのリストを取得するには、`ibmcloud ks regions` を実行します。

グローバル・エンドポイントと共に API を使用するには、すべての要求で、`X-Region` ヘッダーによって地域名を渡します。
{: tip}

### 別の{{site.data.keyword.containerlong_notm}}地域へのログイン
{: #container_login_endpoints}

{{site.data.keyword.containerlong_notm}} CLI を使用して、地域を変更できます。
{:shortdesc}

以下の理由で、別の {{site.data.keyword.containerlong_notm}} 地域にログインしたい場合があります。
  * ある地域で作成した {{site.data.keyword.Bluemix_notm}} サービスまたはプライベート Docker イメージを、別の地域の {{site.data.keyword.containerlong_notm}} で使用したい。
  * ログインしているデフォルトの {{site.data.keyword.Bluemix_notm}} 地域とは別の地域のクラスターにアクセスしたい。

地域をすぐに切り替えるには、[`ibmcloud ks region-set`](/docs/containers?topic=containers-cs_cli_reference#cs_region-set) を実行します。

### {{site.data.keyword.containerlong_notm}} の API コマンドの使用
{: #containers_api}

{{site.data.keyword.containerlong_notm}} API と対話するには、コマンド・タイプを入力し、グローバルなエンドポイントに `/v1/command` を追加します。
{:shortdesc}

 `GET /clusters` API の例を示します。
  ```
  GET https://containers.cloud.ibm.com/v1/clusters
  ```
  {: codeblock}

 </br>

グローバル・エンドポイントと共に API を使用するには、すべての要求で、`X-Region` ヘッダーによって地域名を渡します。 使用可能な地域をリストするには、`ibmcloud ks regions` を実行します。
{: tip}

API コマンドの資料を参照するには、[https://containers.cloud.ibm.com/swagger-api/](https://containers.cloud.ibm.com/swagger-api/) を表示してください。

## {{site.data.keyword.containerlong_notm}} のゾーン
{: #zones}

ゾーンとは、各 {{site.data.keyword.Bluemix_notm}} 地域で使用できる物理データ・センターのことです。 地域は、ゾーンを編成するための概念的なツールであり、さまざまな国のゾーン (データ・センター) を含めることができます。 以下の表に、地域別に使用可能なゾーンを示します。
{:shortdesc}

* **複数ゾーンの大都市ロケーション**: 複数ゾーンの大都市ロケーションにクラスターを作成した場合は、可用性の高い Kubernetes マスターのレプリカがゾーン間に自動的に分散されます。1 つのゾーンの障害からアプリを保護するために、ワーカー・ノードを複数のゾーンに分散させるという選択肢があります。
* **単一ゾーンのロケーション**: 単一ゾーンのロケーションにクラスターを作成する場合は、複数のワーカー・ノードを作成できますが、それらを複数のゾーンに分散させることはできません。 可用性の高いマスターには、別々のホストに 3 つのレプリカを持ちますが、複数のゾーンには分散されません。

<table summary="この表は、地域別に使用可能なゾーンを示しています。行は左から右に読みます。1 列目は地域、2 列目は複数ゾーンの大都市ロケーション、3 列目は単一ゾーンのロケーションです。">
<caption>利用可能な単一ゾーンと複数ゾーン (地域別)。</caption>
  <thead>
  <th>地域</th>
  <th>複数ゾーンの大都市ロケーション</th>
  <th>単一ゾーンのロケーション</th>
  </thead>
  <tbody>
    <tr>
      <td>北アジア太平洋地域</td>
      <td>東京: tok02、tok04、tok05</td>
      <td><p>チェンナイ: che01</p>
      <p>中華人民共和国香港特別行政区: hkg02</p>
      <p>ソウル: seo01</p>
      <p>シンガポール: sng01</p></td>
    </tr>
    <tr>
      <td>南アジア太平洋地域</td>
      <td>シドニー: syd01、syd04、syd05</td>
      <td>メルボルン: mel01</td>
    </tr>
    <tr>
      <td>中欧</td>
      <td>フランクフルト: fra02、fra04、fra05</td>
      <td><p>アムステルダム: ams03</p>
      <p>ミラノ: mil01</p>
      <p>オスロ: osl01</p>
      <p>パリ: par01</p>
      </td>
    </tr>
    <tr>
      <td>英国南部</td>
      <td>ロンドン: lon04、lon05`*`、lon06</td>
      <td></td>
    </tr>
    <tr>
      <td>米国東部</td>
      <td>ワシントン特別区: wdc04、wdc06、wdc07</td>
      <td><p>モントリオール: mon01</p>
      <p>トロント: tor01</p></td>
    </tr>
    <tr>
      <td>米国南部</td>
      <td>ダラス: dal10、dal12、dal13</td>
      <td><p>メキシコ: mex01</p><p>サンノゼ: sjc03、sjc04</p><p>サンパウロ: sao01</p></td>
    </tr>
  </tbody>
</table>

`*` lon02 は lon05 に置き換えられました。 新規クラスターでは lon05 を使用する必要があります。lon05 のみで、ゾーン間での可用性の高いマスター・スプレッドがサポートされます。
{: note}

### 単一ゾーンのクラスター
{: #regions_single_zone}

単一ゾーンのクラスターでは、クラスターのリソースは、クラスターがデプロイされたゾーンにとどまります。 以下の図は、米国東部の地域の例における単一ゾーン・クラスターのコンポーネントの関係を表しています。

<img src="/images/region-cluster-resources.png" width="650" alt="クラスターのリソースが存在する場所について" style="width:650px; border-style: none"/>

_単一ゾーンのクラスターのリソースが存在する場所について_

1.  クラスターのリソース (マスター・ノードやワーカー・ノードなど) は、クラスターをデプロイした同じゾーンにあります。 ローカル・コンテナーのオーケストレーション・アクション (`kubectl` コマンドなど) を実行すると、同じゾーン内のマスター・ノードとワーカー・ノードの間で情報が交換されます。

2.  他のクラスター・リソース (ストレージ、ネットワーキング、コンピュート、ポッドで実行されているアプリなど) をセットアップした場合、リソースとそのデータは、クラスターをデプロイしたゾーンに残ります。

3.  クラスターの管理操作 (`ibmcloud ks` コマンドの使用など) を開始すると、クラスターに関する基本情報 (名前、ID、ユーザー、コマンドなど) が地域のエンドポイントを介して転送されます。

### 複数ゾーン・クラスター
{: #regions_multizone}

複数ゾーン・クラスターでは、マスター・ノードは複数ゾーン対応のゾーンにデプロイされ、クラスターのリソースは複数のゾーンに分散されます。

1.  ワーカー・ノードは、クラスターの可用性を向上させるために、1 つの地域内の複数のゾーンに分散されます。 マスターは、クラスターをデプロイしたのと同じ複数ゾーン対応のゾーンにとどまります。 ローカル・コンテナーのオーケストレーション操作 (`kubectl` コマンドなど) を開始すると、地域エンドポイントを介してマスター・ノードとワーカー・ノードの間で情報が交換されます。

2.  ストレージ、ネットワーキング、コンピュート、ポッドで実行されるアプリなど、他のクラスター・リソースは、さまざまな方法で複数ゾーン・クラスターにデプロイできます。 詳しくは、以下のトピックを参照してください。
  * 複数ゾーン・クラスターで [ファイル・ストレージ](/docs/containers?topic=containers-file_storage#add_file)と[ブロック・ストレージ](/docs/containers?topic=containers-block_storage#add_block)をセットアップする
  * [複数ゾーン・クラスターで LoadBalancer サービスを使用してアプリへのパブリック・アクセスまたはプライベート・アクセスを有効にする](/docs/containers?topic=containers-loadbalancer#multi_zone_config)
  * [Ingress を使用してネットワーク・トラフィックを管理する](/docs/containers?topic=containers-ingress#planning)
  * [アプリの可用性の向上](/docs/containers?topic=containers-app#increase_availability)

3.  クラスターの管理操作 ([`ibmcloud ks` コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)の使用など) を開始すると、クラスターに関する基本情報 (名前、ID、ユーザー、コマンドなど) が地域のエンドポイントを介して転送されます。




