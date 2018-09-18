---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Ingress を使用してアプリを公開する
{: #ingress}

{{site.data.keyword.containerlong}} で、IBM 提供のアプリケーション・ロード・バランサーで管理される Ingress リソースを作成して、Kubernetes クラスター内の複数のアプリを公開します。
{:shortdesc}

## Ingress のコンポーネントとアーキテクチャー
{: #planning}

Ingress は、パブリック要求またはプライベート要求をアプリに転送して、クラスター内のネットワーク・トラフィック・ワークロードを負荷分散させる Kubernetes サービスです。 Ingress を利用すると、固有のパブリック経路またはプライベート経路を使用して複数のアプリ・サービスをパブリック・ネットワークまたはプライベート・ネットワークに公開できます。
{:shortdesc}

**Ingress に含まれるもの**</br>
Ingress は、以下の 3 つのコンポーネントで構成されています。
<dl>
<dt>Ingress リソース</dt>
<dd>Ingress を使用してアプリを公開するには、アプリ用に Kubernetes サービスを作成し、Ingress リソースを定義してそのサービスを Ingress に登録する必要があります。 Ingress リソースは、アプリに対する着信要求を転送する方法についてのルールを定義する Kubernetes リソースです。 また、Ingress リソースによってアプリ・サービスへのパスも指定します。このパスがパブリック経路に付加されて、アプリの固有 URL が形成されます。例えば、`mycluster.us-south.containers.appdomain.cloud/myapp1` のようになります。 <br></br>**注**: 2018 年 5 月 24 日に、新しいクラスターの Ingress サブドメイン形式が変更されました。 新しいサブドメイン形式に含まれる地域名またはゾーン名は、クラスターが作成されたゾーンに基づいて生成されます。一貫したアプリのドメイン名にパイプラインが依存している場合は、IBM 提供の Ingress サブドメインの代わりに独自のカスタム・ドメインを使用できます。<ul><li>2018 年 5 月 24 日以降に作成されたすべてのクラスターには、新しい形式 <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code> のサブドメインが割り当てられます。</li><li>2018 年 5 月 24 日より前に作成された単一ゾーン・クラスターは、古い形式 <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code> で割り当てられたサブドメインを引き続き使用します。</li><li>初めて[ゾーンをクラスターに追加](cs_clusters.html#add_zone)して、2018 年 5 月 24 日より前に作成された単一ゾーン・クラスターを複数ゾーンに変更した場合も、古い形式 <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code> で割り当てられたサブドメインが使用されますが、新しい形式 <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code> のサブドメインも割り当てられます。どちらのサブドメインも使用できます。</li></ul></br>**複数ゾーン・クラスター**: Ingress リソースはグローバルであるため、複数ゾーン・クラスターでは名前空間ごとに 1 つだけ必要になります。</dd>
<dt>アプリケーション・ロード・バランサー (ALB)</dt>
<dd>アプリケーション・ロード・バランサー (ALB) は、着信 HTTP、HTTPS、TCP、または UDP サービス要求を listen する外部ロード・バランサーです。 そして、ALB は Ingress リソースで定義されたルールに従って、要求を適切なアプリ・ポッドに転送します。標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} がそのクラスター用に可用性の高い ALB を自動で作成し、固有のパブリック経路を割り当てます。 パブリック経路は、クラスター作成時にお客様の IBM Cloud インフラストラクチャー (SoftLayer) アカウントにプロビジョンされたポータブル・パブリック IP アドレスにリンクされます。 デフォルトのプライベート ALB も自動的に作成されますが、自動的に有効になるわけではありません。<br></br>**複数ゾーン・クラスター**: ゾーンをクラスターに追加すると、ポータブル・パブリック・サブネットが追加され、新しいパブリック ALB が自動的に作成されて、そのゾーンのサブネットで有効にされます。クラスター内のデフォルトのすべてのパブリック ALB は 1 つのパブリック経路を共有しますが、異なる IP アドレスを持っています。各ゾーンにデフォルトのプライベート ALB も自動的に作成されますが、自動的に有効になるわけではありません。</dd>
<dt>複数ゾーン・ロード・バランサー (MZLB)</dt>
<dd><p>**複数ゾーン・クラスター**: 初めて[ゾーンをクラスターに追加](cs_clusters.html#add_zone)してクラスターを単一ゾーンから複数ゾーンに変更したときに、必ず、複数ゾーン・ロード・バランサー(MZLB) が自動的に作成され、ワーカーが存在する各ゾーンにデプロイされます。MZLB は、クラスターの各ゾーンの ALB をヘルス・チェックし、そのヘルス・チェックに基づいて DNS 参照の結果を更新し続けます。例えば、ALB の IP アドレスが `1.1.1.1`、`2.2.2.2`、`3.3.3.3` である場合、Ingress サブドメインの DNS 参照の通常の動作では、3 つの IP がすべて返され、クライアントはそのうちの 1 つにランダムにアクセスします。IP アドレス `3.3.3.3` の ALB が何らかの理由で使用不可になると、MZLB ヘルス・チェックが失敗し、DNS 参照では使用可能な `1.1.1.1` と `2.2.2.2` の ALB IP が返されるので、クライアントはその使用可能な ALB IP のいずれかにアクセスします。</p>
<p>MZLB は、IBM 提供の Ingress サブドメインのみを使用するパブリック ALB に対してロード・バランシングを行います。プライベート ALB のみを使用する場合、ALB のヘルスを手動で検査し、DNS 参照の結果を更新する必要があります。カスタム・ドメインを使用するパブリック ALB を使用する場合は、DNS エントリーに CNAME を作成して、カスタム・ドメインからクラスターの IBM 提供の Ingress サブドメインに要求を転送することで、MZLB ロード・バランシングにパブリック ALB を含めることができます。</p>
<p><strong>注</strong>: Calico preDNAT ネットワーク・ポリシーを使用して Ingress サービスへのすべての着信トラフィックをブロックする場合は、ALB のヘルス・チェックに使用される <a href="https://www.cloudflare.com/ips/">Cloudflare の IPv4 IP<img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> をホワイトリストに登録する必要があります。Calico preDNAT ポリシーを作成してこれらの IP をホワイトリストに登録する手順については、<a href="cs_tutorials_policies.html#lesson3">Calico ネットワーク・ポリシー・チュートリアル</a>のレッスン 3 を参照してください。</dd>
</dl>

**単一ゾーン・クラスターで Ingress を使用して要求をアプリに届ける方法**</br>
次の図は、Ingress がインターネットから単一ゾーン・クラスター内のアプリへの通信をどのように誘導するかを示しています。

<img src="images/cs_ingress_singlezone.png" alt="Ingress を使用して単一ゾーン・クラスターのアプリを公開する" style="border-style: none"/>

1. ユーザーがアプリの URL にアクセスしてアプリに要求を送信します。 この URL は、Ingress リソース・パスが付加された公開アプリのパブリック URL です (例: `mycluster.us-south.containers.appdomain.cloud/myapp`)。

2. DNS システム・サービスが、URL のホスト名を、クラスター内の ALB を公開しているロード・バランサーのポータブル・パブリック IP アドレスに解決します。

3. 解決された IP アドレスに基づいて、クライアントが、ALB を公開しているロード・バランサー・サービスに要求を送信します。

4. ロード・バランサー・サービスが、要求を ALB にルーティングします。

5. ALB は、クラスター内の `myapp` パスのルーティング・ルールが存在するかどうかを検査します。 一致するルールが見つかった場合、要求は、Ingress リソースで定義したルールに従って、アプリがデプロイされているポッドに転送されます。 パッケージのソース IP アドレスは、アプリ・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。複数のアプリ・インスタンスがクラスターにデプロイされている場合、ALB は、アプリ・ポッド間で要求のロード・バランシングを行います。

**複数ゾーン・クラスターで Ingress を使用して要求をアプリに届ける方法**</br>
次の図は、Ingress がインターネットから複数ゾーン・クラスター内のアプリへの通信をどのように誘導するかを示しています。

<img src="images/cs_ingress_multizone.png" alt="Ingress を使用して複数ゾーン・クラスターのアプリを公開する" style="border-style: none"/>

1. ユーザーがアプリの URL にアクセスしてアプリに要求を送信します。 この URL は、Ingress リソース・パスが付加された公開アプリのパブリック URL です (例: `mycluster.us-south.containers.appdomain.cloud/myapp`)。

2. グローバル・ロード・バランサーとして動作する DNS システム・サービスが、URL のホスト名を、MZLB から正常なものとして報告された使用可能な IP アドレスに解決します。MZLB は、クラスター内の パブリック ALB を公開しているロード・バランサー・サービスのポータブル・パブリック IP アドレスを継続的に検査します。IP アドレスはラウンドロビン・サイクルで解決されます。これにより、さまざまなゾーンの正常な ALB の間で、要求が等しくロード・バランシングされます。

3. クライアントが、ALB を公開しているロード・バランサー・サービスの IP アドレスに要求を送信します。

4. ロード・バランサー・サービスが、要求を ALB にルーティングします。

5. ALB は、クラスター内の `myapp` パスのルーティング・ルールが存在するかどうかを検査します。 一致するルールが見つかった場合、要求は、Ingress リソースで定義したルールに従って、アプリがデプロイされているポッドに転送されます。 パッケージのソース IP アドレスは、アプリ・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。複数のアプリ・インスタンスがクラスターにデプロイされている場合、ALB はすべてのゾーンのアプリ・ポッド間で要求のロード・バランシングを行います。

<br />


## 前提条件
{: #config_prereqs}

Ingress の使用を開始する前に、以下の前提条件を確認してください。
{:shortdesc}

**すべての Ingress 構成の前提条件:**
- Ingress は標準クラスターでのみ使用可能です。高可用性を確保して定期的に更新を適用するために、ゾーンごとにワーカー・ノードが 2 つ以上必要です。
- Ingress のセットアップには、[管理者アクセス・ポリシー](cs_users.html#access_policies)が必要です。 現在の[アクセス・ポリシー](cs_users.html#infra_access)を確認してください。

**複数ゾーン・クラスターで Ingress を使用するための前提条件**:
 - ネットワーク・トラフィックを[エッジ・ワーカー・ノード](cs_edge.html)に制限する場合、Ingress ポッドの高可用性を確保するために、少なくとも 2 つのエッジ・ワーカー・ノードを各ゾーンで有効にする必要があります。クラスター内のすべてのゾーンにまたがり、ゾーンごとにワーカー・ノードを 2 つ以上持つ[エッジ・ワーカー・ノード・プールを作成します](cs_clusters.html#add_pool)。
 - 別々のゾーンにあるワーカーがプライベート・ネットワークで通信できるようにするには、[VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にする必要があります。
 - ゾーンで障害が発生した場合、そのゾーンの Ingress ALB への要求で断続的に障害が発生する可能性があります。

<br />


## 1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画
{: #multiple_namespaces}

公開するアプリを入れる名前空間ごとに少なくとも 1 つの Ingress リソースが必要です。
{:shortdesc}

<dl>
<dt>1 つの名前空間にすべてのアプリを入れる場合</dt>
<dd>クラスター内のすべてのアプリを同じ名前空間に入れる場合は、そこで公開するアプリのルーティング・ルールを定義するために少なくとも 1 つの Ingress リソースが必要になります。 例えば、開発用の名前空間にあるサービスで `app1` と `app2` を公開する場合は、その名前空間で 1 つの Ingress リソースを作成できます。 そのリソースで、`domain.net` をホストとして指定し、各アプリが `domain.net` で listen するパスを登録します。
<br></br><img src="images/cs_ingress_single_ns.png" width="300" alt="名前空間ごとに少なくとも 1 つのリソースが必要" style="width:300px; border-style: none"/>
</dd>
<dt>複数の名前空間にアプリを入れる場合</dt>
<dd>クラスター内のアプリを別々の名前空間に入れる場合は、そこで公開するアプリのルールを定義するために、名前空間ごとに少なくとも 1 つのリソースを作成する必要があります。 複数の Ingress リソースをクラスターの Ingress ALB に登録するには、ワイルドカード・ドメインを使用する必要があります。 ワイルドカード・ドメイン (`*.domain.net` など) を登録すると、すべてのサブドメインが同じホストに解決されます。 そうすれば、各名前空間で Ingress リソースを作成し、各 Ingress リソースで別々のサブドメインを指定できます。
<br><br>
例えば、以下のシナリオがあるとします。<ul>
<li>テスト用の同じアプリに `app1` と `app3` という 2 つのバージョンがあります。</li>
<li>それらのアプリを同じクラスター内の 2 つの別々の名前空間にデプロイします (`app1` を開発用名前空間に、`app3` をステージング用名前空間にデプロイします)。</li></ul>
同じクラスター ALB を使用してそれらのアプリへのトラフィックを管理するには、以下のサービスとリソースを作成します。<ul>
<li>`app1` を公開する開発用名前空間の Kubernetes サービス。</li>
<li>ホストを `dev.domain.net` として指定する、開発用名前空間内の Ingress リソース。</li>
<li>`app3` を公開するステージング用名前空間の Kubernetes サービス。</li>
<li>ホストを `stage.domain.net` として指定する、ステージング用名前空間内の Ingress リソース。</li></ul></br>
<img src="images/cs_ingress_multi_ns.png" alt="名前空間内の 1 つ以上のリソースでサブドメインを使用する" style="border-style: none"/>
これで、両方の URL が同じドメインに解決され、同じ ALB のサービスを受けるようになります。 しかし、ステージング用名前空間のリソースは `stage` サブドメインに登録されるので、Ingress ALB は、`stage.domain.net/app3` URL からの要求を `app3` だけに正しくルーティングします。</dd>
</dl>

{: #wildcard_tls}
**注:**
* デフォルトでは、クラスターに対し、IBM 提供の Ingress サブドメイン・ワイルドカード `*.<cluster_name>.<region>.containers.appdomain.cloud` が登録されます。 2018 年 6 月 6 日以降に作成されたクラスターの場合、IBM 提供の Ingress サブドメインの TLS 証明書はワイルドカード証明書ですので、登録されているワイルドカード・サブドメインに使用できます。2018 年 6 月 6 日より前に作成されたクラスターの場合、現在の TLS 証明書が更新されるときに、ワイルドカード証明書に更新されます。
* カスタム・ドメインを使用する場合は、カスタム・ドメインを `*.custom_domain.net` などのワイルドカード・ドメインとして登録する必要があります。 TLS を使用するには、ワイルドカード証明書を取得する必要があります。

### 1 つの名前空間の中で複数のドメインを使用する場合

それぞれの名前空間では、1 つのドメインを使用して、その名前空間内のすべてのアプリにアクセスできます。 1 つの名前空間の中でアプリのために複数のドメインを使用する場合は、ワイルドカード・ドメインを使用します。 ワイルドカード・ドメイン (`*.mycluster.us-south.containers.appdomain.cloud` など) を登録すると、すべてのサブドメインが同じホストに解決されます。 そうすれば、1 つのリソースを使用し、そのリソースの中で複数のサブドメイン・ホストを指定することができます。 あるいは別の方法として、その名前空間で複数の Ingress リソースを作成し、各 Ingress リソースで別々のサブドメインを指定することも可能です。

<img src="images/cs_ingress_single_ns_multi_subs.png" alt="名前空間ごとに少なくとも 1 つのリソースが必要" style="border-style: none"/>

**注:**
* デフォルトでは、クラスターに対し、IBM 提供の Ingress サブドメイン・ワイルドカード `*.<cluster_name>.<region>.containers.appdomain.cloud` が登録されます。 2018 年 6 月 6 日以降に作成されたクラスターの場合、IBM 提供の Ingress サブドメインの TLS 証明書はワイルドカード証明書ですので、登録されているワイルドカード・サブドメインに使用できます。2018 年 6 月 6 日より前に作成されたクラスターの場合、現在の TLS 証明書が更新されるときに、ワイルドカード証明書に更新されます。
* カスタム・ドメインを使用する場合は、カスタム・ドメインを `*.custom_domain.net` などのワイルドカード・ドメインとして登録する必要があります。 TLS を使用するには、ワイルドカード証明書を取得する必要があります。

<br />


## クラスター内のアプリをパブリックに公開する
{: #ingress_expose_public}

パブリック Ingress ALB を使用して、クラスター内のアプリをパブリックに公開します。
{:shortdesc}

開始前に、以下のことを行います。

* Ingress の[前提条件](#config_prereqs)を確認します。
* 対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

### ステップ 1: アプリをデプロイしてアプリ・サービスを作成する
{: #public_inside_1}

まず、アプリをデプロイし、それらを公開するための Kubernetes サービスを作成します。
{: shortdesc}

1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります (例えば、`app: code`)。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

2.   公開するアプリごとに Kubernetes サービスを作成します。 アプリをクラスター ALB の Ingress ロード・バランシングに含めるには、Kubernetes サービスを介してアプリを公開する必要があります。
      1.  任意のエディターを開き、`myappservice.yaml` などの名前のサービス構成ファイルを作成します。
      2.  ALB で公開するアプリのサービスを定義します。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
         port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ALB サービス YAML ファイルの構成要素について</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにして、それらをサービスのロード・バランシングに組み込む場合は、<em>&lt;selector_key&gt;</em> と <em>&lt;selector_value&gt;</em> を、デプロイメント yaml の <code>spec.template.metadata.labels</code> セクションにあるキー/値のペアと同じになるようにしてください。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>サービスが listen するポート。</td>
           </tr>
           </tbody></table>
      3.  変更を保存します。
      4.  クラスター内にサービスを作成します。 クラスター内の複数の名前空間にアプリをデプロイする場合は、公開するアプリと同じ名前空間にサービスをデプロイするようにしてください。

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  公開するアプリごとに、上記のステップを繰り返します。


### ステップ 2: アプリ・ドメインと TLS 終端を選択する
{: #public_inside_2}

パブリック ALB を構成する場合は、アプリにアクセスするためのドメインを選択し、TLS 終端を使用するかどうかを決めます。
{: shortdesc}

<dl>
<dt>ドメイン</dt>
<dd>IBM 提供のドメイン (<code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code> など) を使用して、インターネットからアプリにアクセスできます。 代わりにカスタム・ドメインを使用するには、カスタム・ドメインを IBM 提供のドメインにマップする CNAME レコードをセットアップするか、または ALB のパブリック IP アドレスを使用して DNS プロバイダーに A レコードをセットアップします。</dd>
<dt>TLS 終端</dt>
<dd>ALB は、HTTP ネットワーク・トラフィックをクラスター内のアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、ネットワーク・トラフィックを復号し、復号した要求をクラスター内で公開されているアプリに転送するように構成します。 <ul><li>IBM 提供の Ingress サブドメインを使用する場合は、IBM 提供の TLS 証明書を使用できます。 IBM 提供の TLS 証明書は、LetsEncrypt によって署名され、IBM によって完全に管理されます。証明書の有効期間は 90 日で、有効期限が切れる 7 日前に自動的に更新されます。</li><li>カスタム・ドメインを使用する場合は、独自の TLS 証明書を使用して TLS 終端を管理できます。 1 つの名前空間にのみアプリがある場合は、その同じ名前空間に、証明書に対する TLS シークレットをインポートまたは作成できます。複数の名前空間にアプリがある場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、<code>default</code> 名前空間の証明書に対して TLS シークレットをインポートまたは作成します。</li></ul></dd>
</dl>

IBM 提供の Ingress ドメインを使用する場合:
1. クラスターの詳細情報を取得します。 _&lt;cluster_name_or_ID&gt;_ を、公開するアプリのデプロイ先のクラスターの名前に置き換えてください。

    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    出力例:

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Zone:                   dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.10.5
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}
2. **Ingress subdomain** フィールドにある IBM 提供のドメインを取得します。 TLS を使用する場合は、**Ingress Secret** フィールドにある IBM 提供の TLS シークレットも取得してください。
    **注**: ワイルドカードの TLS 証明書については、[この注記](#wildcard_tls)を参照してください。

カスタム・ドメインを使用する場合:
1.    カスタム・ドメインを作成します。 カスタム・ドメインを登録する時には、Domain Name Service (DNS) プロバイダーまたは [{{site.data.keyword.Bluemix_notm}} DNS](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) を使用してください。
      * Ingress で公開するアプリが 1 つのクラスター内の別々の名前空間にある場合は、カスタム・ドメインをワイルドカード・ドメイン (`*.custom_domain.net` など) として登録します。

2.  着信ネットワーク・トラフィックを IBM 提供の ALB にルーティングするようにドメインを構成します。 以下の選択肢があります。
    -   IBM 提供ドメインを正規名レコード (CNAME) として指定することで、カスタム・ドメインの別名を定義します。 IBM 提供の Ingress ドメインを確認するには、`ibmcloud ks cluster-get <cluster_name>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。
    -   カスタム・ドメインを IBM 提供の ALB のポータブル・パブリック IP アドレスにマップします。これは、IP アドレスをレコードとして追加して行います。 ALB のポータブル・パブリック IP アドレスを見つけるには、`ibmcloud ks alb-get <public_alb_ID>` を実行します。
3.   オプション: TLS を使用するには、TLS 証明書とキー・シークレットをインポートまたは作成します。ワイルドカード・ドメインを使用する場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、必ず、<code>default</code> 名前空間にワイルドカード証明書をインポートまたは作成してください。
      * 使用する TLS 証明書が {{site.data.keyword.cloudcerts_long_notm}} に保管されている場合は、それに関連付けられたシークレットを、以下のコマンドを実行してクラスター内にインポートできます。
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * TLS 証明書の準備ができていない場合は、以下の手順に従ってください。
        1. PEM 形式でエンコードされた TLS 証明書と鍵を、当該ドメインのために作成します。
        2. TLS 証明書と鍵を使用するシークレットを作成します。 <em>&lt;tls_secret_name&gt;</em> を Kubernetes シークレットの名前に、<em>&lt;tls_key_filepath&gt;</em> をカスタム TLS 鍵ファイルへのパスに、<em>&lt;tls_cert_filepath&gt;</em> をカスタム TLS 証明書ファイルへのパスに置き換えます。
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### ステップ 3: Ingress リソースを作成する
{: #public_inside_3}

Ingress リソースは、ALB がトラフィックをアプリ・サービスにルーティングするために使用するルーティング・ルールを定義します。
{: shortdesc}

**注:** クラスター内の複数の名前空間でアプリを公開する場合は、名前空間ごとに少なくとも 1 つの Ingress リソースが必要になります。 ただし、各名前空間で別々のホストを使用する必要があります。 ワイルドカード・ドメインを登録し、各リソースで別々のサブドメインを指定しなければなりません。 詳しくは、[1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画](#multiple_namespaces)を参照してください。

1. 任意のエディターを開き、`myingressresource.yaml` などの名前の Ingress 構成ファイルを作成します。

2. IBM 提供のドメインまたはカスタム・ドメインを使用して着信ネットワーク・トラフィックを作成済みサービスにルーティングする Ingress リソースを構成ファイル内に定義します。

    TLS を使用しない YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    TLS を使用する YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>TLS を使用する場合は、<em>&lt;domain&gt;</em> を IBM 提供の Ingress サブドメインかカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` や `subdomain1.mycluster.us-south.containers.appdomain.cloud` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>IBM 提供の Ingress ドメインを使用する場合は、<em>&lt;tls_secret_name&gt;</em> を IBM 提供の Ingress シークレットの名前に置き換えます。</li><li>カスタム・ドメインを使用する場合は、<em>&lt;tls_secret_name&gt;</em> を、カスタム TLS 証明書と鍵を保持するために作成しておいたシークレットに置き換えます。 {{site.data.keyword.cloudcerts_short}} から証明書をインポートする場合、<code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> を実行して、TLS 証明書に関連付けられたシークレットを確認できます。</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td><em>&lt;domain&gt;</em> を IBM 提供の Ingress サブドメインかカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` や `subdomain1.mycluster.us-south.containers.appdomain.cloud` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td><em>&lt;app_path&gt;</em> をスラッシュに置き換えるか、アプリが listen するパスに置き換えます。 IBM 提供のドメインまたはカスタム・ドメインにパスが追加され、アプリへの固有の経路が作成されます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが ALB にルーティングされます。 ALB は、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信します。 そして、サービスが、アプリを実行しているポッドにトラフィックを転送します。
    </br></br>
    多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。 例: <ul><li><code>http://domain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://domain/app1_path</code> の場合、<code>/app1_path</code> をパスとして入力します。</li></ul>
    </br>
    <strong>ヒント:</strong> アプリが listen するパスとは異なるパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用できます。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td><em>&lt;app1_service&gt;</em> や <em>&lt;app2_service&gt;</em> などを、アプリを公開するために作成しておいたサービスの名前に置き換えます。 クラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、同じ名前空間にあるアプリ・サービスだけを組み込んでください。 公開するアプリを入れる名前空間ごとに 1 つの Ingress リソースを作成する必要があります。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
    </tr>
    </tbody></table>

3.  クラスターの Ingress リソースを作成します。 リソースで指定したアプリ・サービスと同じ名前空間にリソースがデプロイされていることを確認します。

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Ingress リソースが正常に作成されたことを確認します。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. イベント内のメッセージにリソース構成のエラーが示された場合は、リソース・ファイル内の値を変更して、リソースのファイルを再適用してください。


Ingress リソースがアプリ・サービスと同じ名前空間に作成されます。 その名前空間内のアプリがクラスターの Ingress ALB に登録されます。

### ステップ 4: インターネットからアプリにアクセスする
{: #public_inside_4}

Web ブラウザーに、アクセスするアプリ・サービスの URL を入力します。

```
https://<domain>/<app1_path>
```
{: pre}

複数のアプリを公開した場合は、URL に追加するパスを変更して、それぞれのアプリにアクセスしてください。

```
https://<domain>/<app2_path>
```
{: pre}

ワイルドカード・ドメインを使用して別々の名前空間にアプリを公開した場合は、それぞれのサブドメインを使用して各アプリにアクセスしてください。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


<br />


## クラスター外のアプリをパブリックに公開する
{: #external_endpoint}

クラスター外にあるアプリをパブリック Ingress ALB のロード・バランシングに組み込んでパブリックに公開します。 IBM 提供のドメインまたはカスタム・ドメインに着信したパブリック要求が自動的にその外部アプリに転送されます。
{:shortdesc}

開始前に、以下のことを行います。

-   Ingress の[前提条件](#config_prereqs)を確認します。
-   クラスター・ロード・バランシングに含めようとしている外部アプリに、パブリック IP アドレスを使用してアクセスできることを確認します。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

### ステップ 1: アプリ・サービスと外部エンドポイントを作成する
{: #public_outside_1}

まず、外部アプリを公開するための Kubernetes サービスを作成し、そのアプリの Kubernetes 外部エンドポイントを構成します。
{: shortdesc}

1.  作成する外部エンドポイントに着信要求を転送する Kubernetes サービスをクラスターに作成します。
    1.  任意のエディターを開き、`myexternalservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  ALB で公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
         port: 8080
        ```
        {: codeblock}

        <table>
        <caption>ALB サービス・ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td><em>&lt;myexternalservice&gt;</em> をサービスの名前に置き換えます。<p>Kubernetes リソースを処理する際の[個人情報の保護](cs_secure.html#pi)の詳細を確認してください。</p></td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
        </tr></tbody></table>

    3.  変更を保存します。
    4.  クラスターの Kubernetes サービスを作成します。

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  クラスター・ロード・バランシングに含める外部のアプリの場所を定義する、Kubernetes エンドポイントを構成します。
    1.  任意のエディターを開き、`myexternalendpoint.yaml` などの名前のエンドポイント構成ファイルを作成します。
    2.  外部エンドポイントを定義します。 外部アプリにアクセスするために使用可能な、すべてのパブリック IP アドレスとポートを含めます。

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalendpoint
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myexternalendpoint&gt;</em> を、先ほど作成した Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td><em>&lt;external_IP&gt;</em> を、外部アプリに接続するためのパブリック IP アドレスに置き換えます。</td>
         </tr>
         <td><code>port</code></td>
         <td><em>&lt;external_port&gt;</em> を、外部アプリが listen するポートに置き換えます。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Kubernetes エンドポイントを作成します。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

### ステップ 2: アプリ・ドメインと TLS 終端を選択する
{: #public_outside_2}

パブリック ALB を構成する場合は、アプリにアクセスするためのドメインを選択し、TLS 終端を使用するかどうかを決めます。
{: shortdesc}

<dl>
<dt>ドメイン</dt>
<dd>IBM 提供のドメイン (<code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code> など) を使用して、インターネットからアプリにアクセスできます。 代わりにカスタム・ドメインを使用するには、カスタム・ドメインを IBM 提供のドメインにマップする CNAME レコードをセットアップするか、または ALB のパブリック IP アドレスを使用して DNS プロバイダーに A レコードをセットアップします。</dd>
<dt>TLS 終端</dt>
<dd>ALB は、HTTP ネットワーク・トラフィックをクラスター内のアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、ネットワーク・トラフィックを復号し、復号した要求をクラスター内で公開されているアプリに転送するように構成します。 <ul><li>IBM 提供の Ingress サブドメインを使用する場合は、IBM 提供の TLS 証明書を使用できます。 IBM 提供の TLS 証明書は、LetsEncrypt によって署名され、IBM によって完全に管理されます。証明書の有効期間は 90 日で、有効期限が切れる 7 日前に自動的に更新されます。</li><li>カスタム・ドメインを使用する場合は、独自の TLS 証明書を使用して TLS 終端を管理できます。 1 つの名前空間にのみアプリがある場合は、その同じ名前空間に、証明書に対する TLS シークレットをインポートまたは作成できます。複数の名前空間にアプリがある場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、<code>default</code> 名前空間の証明書に対して TLS シークレットをインポートまたは作成します。</li></ul></dd>
</dl>

IBM 提供の Ingress ドメインを使用する場合:
1. クラスターの詳細情報を取得します。 _&lt;cluster_name_or_ID&gt;_ を、公開するアプリのデプロイ先のクラスターの名前に置き換えてください。

    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    出力例:

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Zone:                   dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.10.5
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}
2. **Ingress subdomain** フィールドにある IBM 提供のドメインを取得します。 TLS を使用する場合は、**Ingress Secret** フィールドにある IBM 提供の TLS シークレットも取得してください。 **注**: ワイルドカードの TLS 証明書については、[この注記](#wildcard_tls)を参照してください。

カスタム・ドメインを使用する場合:
1.    カスタム・ドメインを作成します。 カスタム・ドメインを登録する時には、Domain Name Service (DNS) プロバイダーまたは [{{site.data.keyword.Bluemix_notm}} DNS](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) を使用してください。
      * Ingress で公開するアプリが 1 つのクラスター内の別々の名前空間にある場合は、カスタム・ドメインをワイルドカード・ドメイン (`*.custom_domain.net` など) として登録します。

2.  着信ネットワーク・トラフィックを IBM 提供の ALB にルーティングするようにドメインを構成します。 以下の選択肢があります。
    -   IBM 提供ドメインを正規名レコード (CNAME) として指定することで、カスタム・ドメインの別名を定義します。 IBM 提供の Ingress ドメインを確認するには、`ibmcloud ks cluster-get <cluster_name>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。
    -   カスタム・ドメインを IBM 提供の ALB のポータブル・パブリック IP アドレスにマップします。これは、IP アドレスをレコードとして追加して行います。 ALB のポータブル・パブリック IP アドレスを見つけるには、`ibmcloud ks alb-get <public_alb_ID>` を実行します。
3.   オプション: TLS を使用するには、TLS 証明書とキー・シークレットをインポートまたは作成します。ワイルドカード・ドメインを使用する場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、必ず、<code>default</code> 名前空間にワイルドカード証明書をインポートまたは作成してください。
      * 使用する TLS 証明書が {{site.data.keyword.cloudcerts_long_notm}} に保管されている場合は、それに関連付けられたシークレットを、以下のコマンドを実行してクラスター内にインポートできます。
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * TLS 証明書の準備ができていない場合は、以下の手順に従ってください。
        1. PEM 形式でエンコードされた TLS 証明書と鍵を、当該ドメインのために作成します。
        2. TLS 証明書と鍵を使用するシークレットを作成します。 <em>&lt;tls_secret_name&gt;</em> を Kubernetes シークレットの名前に、<em>&lt;tls_key_filepath&gt;</em> をカスタム TLS 鍵ファイルへのパスに、<em>&lt;tls_cert_filepath&gt;</em> をカスタム TLS 証明書ファイルへのパスに置き換えます。
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### ステップ 3: Ingress リソースを作成する
{: #public_outside_3}

Ingress リソースは、ALB がトラフィックをアプリ・サービスにルーティングするために使用するルーティング・ルールを定義します。
{: shortdesc}

**注:** 複数の外部アプリを公開し、[ステップ 1](#public_outside_1) で作成したアプリ・サービスを別々の名前空間に入れる場合は、名前空間ごとに少なくとも 1 つの Ingress リソースが必要になります。 ただし、各名前空間で別々のホストを使用する必要があります。 ワイルドカード・ドメインを登録し、各リソースで別々のサブドメインを指定しなければなりません。 詳しくは、[1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画](#multiple_namespaces)を参照してください。

1. 任意のエディターを開き、`myexternalingress.yaml` などの名前の Ingress 構成ファイルを作成します。

2. IBM 提供のドメインまたはカスタム・ドメインを使用して着信ネットワーク・トラフィックを作成済みサービスにルーティングする Ingress リソースを構成ファイル内に定義します。

    TLS を使用しない YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<external_app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<external_app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    TLS を使用する YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<external_app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<external_app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>TLS を使用する場合は、<em>&lt;domain&gt;</em> を IBM 提供の Ingress サブドメインかカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>クラスターの別々の名前空間にアプリ・サービスを入れる場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` や `subdomain1.mycluster.us-south.containers.appdomain.cloud` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>IBM 提供の Ingress ドメインを使用する場合は、<em>&lt;tls_secret_name&gt;</em> を IBM 提供の Ingress シークレットの名前に置き換えます。</li><li>カスタム・ドメインを使用する場合は、<em>&lt;tls_secret_name&gt;</em> を、カスタム TLS 証明書と鍵を保持するために作成しておいたシークレットに置き換えます。 {{site.data.keyword.cloudcerts_short}} から証明書をインポートする場合、<code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> を実行して、TLS 証明書に関連付けられたシークレットを確認できます。</li><ul><td>
    </tr>
    <tr>
    <td><code>rules/host</code></td>
    <td><em>&lt;domain&gt;</em> を IBM 提供の Ingress サブドメインかカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` や `subdomain1.mycluster.us-south.containers.appdomain.cloud` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td><em>&lt;external_app_path&gt;</em> をスラッシュに置き換えるか、アプリが listen するパスに置き換えます。 IBM 提供のドメインまたはカスタム・ドメインにパスが追加され、アプリへの固有の経路が作成されます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが ALB にルーティングされます。 ALB は、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信します。 サービスは、トラフィックを外部アプリに転送します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。
    </br></br>
    多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。 例: <ul><li><code>http://domain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://domain/app1_path</code> の場合、<code>/app1_path</code> をパスとして入力します。</li></ul>
    </br></br>
    <strong>ヒント:</strong> アプリが listen するパスとは異なるパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用できます。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td><em>&lt;app1_service&gt;</em> や <em>&lt;app2_service&gt;</em> などを、外部アプリを公開するために作成しておいたサービスの名前に置き換えます。クラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、同じ名前空間にあるアプリ・サービスだけを組み込んでください。 公開するアプリを入れる名前空間ごとに 1 つの Ingress リソースを作成する必要があります。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
    </tr>
    </tbody></table>

3.  クラスターの Ingress リソースを作成します。 リソースで指定したアプリ・サービスと同じ名前空間にリソースがデプロイされていることを確認します。

    ```
    kubectl apply -f myexternalingress.yaml -n <namespace>
    ```
    {: pre}
4.   Ingress リソースが正常に作成されたことを確認します。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. イベント内のメッセージにリソース構成のエラーが示された場合は、リソース・ファイル内の値を変更して、リソースのファイルを再適用してください。


Ingress リソースがアプリ・サービスと同じ名前空間に作成されます。 その名前空間内のアプリがクラスターの Ingress ALB に登録されます。

### ステップ 4: インターネットからアプリにアクセスする
{: #public_outside_4}

Web ブラウザーに、アクセスするアプリ・サービスの URL を入力します。

```
https://<domain>/<app1_path>
```
{: pre}

複数のアプリを公開した場合は、URL に追加するパスを変更して、それぞれのアプリにアクセスしてください。

```
https://<domain>/<app2_path>
```
{: pre}

ワイルドカード・ドメインを使用して別々の名前空間にアプリを公開した場合は、それぞれのサブドメインを使用して各アプリにアクセスしてください。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


<br />


## デフォルトのプライベート ALB を有効にする
{: #private_ingress}

標準クラスターを作成した場合は、ワーカー・ノードが存在する各ゾーンに IBM 提供のプライベート・アプリケーション・ロード・バランサー (ALB) が作成され、ポータブル・プライベート IP アドレスとプライベート経路を割り当てられます。ただし、各ゾーンのデフォルトのプライベート ALB は自動的には有効になりません。 デフォルトのプライベート ALB でプライベート・ネットワーク・トラフィックをアプリに振り分けてロード・バランシングを行うには、まず IBM 提供のポータブル・プライベート IP アドレスを使用するか、独自のポータブル・プライベート IP アドレスを使用して、プライベート ALB を有効にする必要があります。
{:shortdesc}

**注**: クラスターを作成したときに `--no-subnet` フラグを使用した場合、プライベート ALB を有効にするには、その前にポータブル・プライベート・サブネットまたはユーザー管理サブネットを追加する必要があります。 詳しくは、[クラスターのその他のサブネットの要求](cs_subnets.html#request)を参照してください。

開始前に、以下のことを行います。

-   ワーカー・ノードを[パブリック VLAN とプライベート VLAN](cs_network_planning.html#private_both_vlans)、または[プライベート VLAN のみ](cs_network_planning.html#private_vlan)に接続した状況でアプリへのプライベート・アクセスを計画するためのオプションを確認します。
-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

IBM 提供の事前割り当てポータブル・プライベート IP アドレスを使用してデフォルトのプライベート ALB を有効にするには、以下のようにします。

1. 有効にするデフォルトのプライベート ALB の ID を取得します。<em>&lt;cluster_name&gt;</em> を、公開するアプリがデプロイされているクラスターの名前に置き換えます。

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    プライベート ALB の**「Status」**フィールドは「_disabled_」になっています。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419aa3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2   false     disabled   private   -               dal12
    public-cr6d779503319d419aa3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    public-crb2f60e9735254ac8b20b9c1e38b649a5-alb2    true      enabled    public    169.xx.xxx.xxx  dal12
    ```
    {: screen}
複数ゾーン・クラスターでは、ALB ID の接尾部の番号は、ALB が追加された順序を示しています。
    * 例えば、ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` の接尾部 `-alb1` は、それが最初に作成されたデフォルトのプライベート ALB であることを示しています。これは、クラスターを作成したゾーンに存在します。上記の例では、クラスターは `dal10` に作成されました。
    * ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` の接尾部 `-alb2` は、それが 2 番目に作成されたデフォルトのプライベート ALB であることを示しています。これは、クラスターに追加した 2 番目のゾーンに存在します。上記の例では、2 番目のゾーンは `dal12` です。

2. プライベート ALB を有効にします。 <em>&lt;private_ALB_ID&gt;</em> を、前のステップの出力にあるプライベート ALB の ID に置き換えます。

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

<br>
独自のポータブル・プライベート IP アドレスを使用してプライベート ALB を有効にするには、以下のようにします。

1. ご使用のクラスターのプライベート VLAN 上でトラフィックをルーティングするように、選択した IP アドレスのユーザー管理サブネットを構成します。

   ```
   ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> コマンドの構成要素について</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;cluster_name&gt;</code></td>
   <td>公開するアプリのデプロイ先のクラスターの名前または ID。</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>ユーザー管理サブネットの CIDR。</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>使用可能なプライベート VLAN の ID。 使用可能なプライベート VLAN の ID は、`ibmcloud ks vlans` を実行することによって見つけることができます。</td>
   </tr>
   </tbody></table>

2. クラスター内で使用可能な ALB をリスト表示して、プライベート ALB の ID を取得します。

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    プライベート ALB の**「Status」**フィールドは_「disabled」_になっています。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    ```
    {: screen}

3. プライベート ALB を有効にします。 <em>&lt;private_ALB_ID&gt;</em> を、前のステップの出力にあるプライベート ALB の ID に置き換えます。<em>&lt;user_IP&gt;</em> を、使用するユーザー管理サブネットからの IP アドレスに置き換えます。

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

<br />


## プライベート・ネットワークにアプリを公開する
{: #ingress_expose_private}

プライベート Ingress ALB を使用して、アプリをプライベート・ネットワークに公開します。
{:shortdesc}

開始前に、以下のことを行います。
* Ingress の[前提条件](#config_prereqs)を確認します。
* ワーカー・ノードを[パブリック VLAN とプライベート VLAN](cs_network_planning.html#private_both_vlans)、または[プライベート VLAN のみ](cs_network_planning.html#private_vlan)に接続した状況でアプリへのプライベート・アクセスを計画するためのオプションを確認します。
    * パブリック VLAN とプライベート VLAN: デフォルトの外部 DNS プロバイダーを使用するには、[パブリック・アクセス用のエッジ・ノードを構成](cs_edge.html#edge)し、[仮想ルーター・アプライアンスを構成 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) する必要があります。
    * プライベート VLAN のみ: [プライベート・ネットワークで使用可能な DNS サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を構成する必要があります。
* [プライベート・アプリケーションのロード・バランサーを有効にします](#private_ingress)。

### ステップ 1: アプリをデプロイしてアプリ・サービスを作成する
{: #private_1}

まず、アプリをデプロイし、それらを公開するための Kubernetes サービスを作成します。
{: shortdesc}

1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります (例えば、`app: code`)。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

2.   公開するアプリごとに Kubernetes サービスを作成します。 アプリをクラスター ALB の Ingress ロード・バランシングに含めるには、Kubernetes サービスを介してアプリを公開する必要があります。
      1.  任意のエディターを開き、`myappservice.yaml` などの名前のサービス構成ファイルを作成します。
      2.  ALB で公開するアプリのサービスを定義します。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
         port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ALB サービス YAML ファイルの構成要素について</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにして、それらをサービスのロード・バランシングに組み込む場合は、<em>&lt;selector_key&gt;</em> と <em>&lt;selector_value&gt;</em> を、デプロイメント yaml の <code>spec.template.metadata.labels</code> セクションにあるキー/値のペアと同じになるようにしてください。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>サービスが listen するポート。</td>
           </tr>
           </tbody></table>
      3.  変更を保存します。
      4.  クラスター内にサービスを作成します。 クラスター内の複数の名前空間にアプリをデプロイする場合は、公開するアプリと同じ名前空間にサービスをデプロイするようにしてください。

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  公開するアプリごとに、上記のステップを繰り返します。


### ステップ 2: カスタム・ドメインをマップして TLS 終端を選択する
{: #private_2}

プライベート ALB を構成する場合は、アプリにアクセスするためのカスタム・ドメインを使用し、TLS 終端を使用するかどうかを選択します。
{: shortdesc}

ALB は、HTTP ネットワーク・トラフィックをアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、独自の TLS 証明書を使用してネットワーク・トラフィックを復号します。 その後 ALB で、復号した要求をクラスター内で公開されているアプリに転送します。
1.   カスタム・ドメインを作成します。 カスタム・ドメインを登録する時には、Domain Name Service (DNS) プロバイダーまたは [{{site.data.keyword.Bluemix_notm}} DNS](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) を使用してください。
      * Ingress で公開するアプリが 1 つのクラスター内の別々の名前空間にある場合は、カスタム・ドメインをワイルドカード・ドメイン (`*.custom_domain.net` など) として登録します。

2. カスタム・ドメインを IBM 提供のプライベート ALB のポータブル・プライベート IP アドレスにマップします。これは、IP アドレスをレコードとして追加して行います。 プライベート ALB のポータブル・プライベート IP アドレスを見つけるには、`ibmcloud ks albs --cluster<cluster_name>` を実行します。
3.   オプション: TLS を使用するには、TLS 証明書とキー・シークレットをインポートまたは作成します。ワイルドカード・ドメインを使用する場合は、どの名前空間でも ALB が証明書にアクセスして使用できるように、必ず、<code>default</code> 名前空間にワイルドカード証明書をインポートまたは作成してください。
      * 使用する TLS 証明書が {{site.data.keyword.cloudcerts_long_notm}} に保管されている場合は、それに関連付けられたシークレットを、以下のコマンドを実行してクラスター内にインポートできます。
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * TLS 証明書の準備ができていない場合は、以下の手順に従ってください。
        1. PEM 形式でエンコードされた TLS 証明書と鍵を、当該ドメインのために作成します。
        2. TLS 証明書と鍵を使用するシークレットを作成します。 <em>&lt;tls_secret_name&gt;</em> を Kubernetes シークレットの名前に、<em>&lt;tls_key_filepath&gt;</em> をカスタム TLS 鍵ファイルへのパスに、<em>&lt;tls_cert_filepath&gt;</em> をカスタム TLS 証明書ファイルへのパスに置き換えます。
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### ステップ 3: Ingress リソースを作成する
{: #pivate_3}

Ingress リソースは、ALB がトラフィックをアプリ・サービスにルーティングするために使用するルーティング・ルールを定義します。
{: shortdesc}

**注:** クラスター内の複数の名前空間でアプリを公開する場合は、名前空間ごとに少なくとも 1 つの Ingress リソースが必要になります。 ただし、各名前空間で別々のホストを使用する必要があります。 ワイルドカード・ドメインを登録し、各リソースで別々のサブドメインを指定しなければなりません。 詳しくは、[1 つの名前空間を使用する場合と複数の名前空間を使用する場合のネットワーキングの計画](#multiple_namespaces)を参照してください。

1. 任意のエディターを開き、`myingressresource.yaml` などの名前の Ingress 構成ファイルを作成します。

2.  カスタム・ドメインを使用して着信ネットワーク・トラフィックを作成済みのサービスにルーティングするように、Ingress リソースを構成ファイル内に定義します。

    TLS を使用しない YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    TLS を使用する YAML の例:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td><em>&lt;private_ALB_ID&gt;</em> を、プライベート ALB の ID に置き換えます。 ALB ID を見つけるには、<code>ibmcloud ks albs --cluster <my_cluster></code> を実行します。 この Ingress アノテーションについて詳しくは、[プライベート・アプリケーションのロード・バランサーのルーティング](cs_annotations.html#alb-id)を参照してください。</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>TLS を使用する場合は、<em>&lt;domain&gt;</em> をカスタム・ドメインに置き換えます。

    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><em>&lt;tls_secret_name&gt;</em> を、先ほど作成した、カスタム TLS 証明書と鍵を保持するシークレットの名前に置き換えます。 {{site.data.keyword.cloudcerts_short}} から証明書をインポートする場合、<code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> を実行して、TLS 証明書に関連付けられたシークレットを確認できます。
    </tr>
    <tr>
    <td><code>host</code></td>
    <td><em>&lt;domain&gt;</em> をカスタム・ドメインに置き換えます。
    </br></br>
    <strong>注:</strong><ul><li>1 つのクラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、ドメインの先頭にワイルドカード・サブドメインを追加します (`subdomain1.custom_domain.net` など)。 クラスター内に作成するリソースごとに固有のサブドメインを使用してください。</li><li>Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td><em>&lt;app_path&gt;</em> をスラッシュに置き換えるか、アプリが listen するパスに置き換えます。 カスタム・ドメインにパスが追加され、アプリへの固有の経路が作成されます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが ALB にルーティングされます。 ALB は、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信します。 そして、サービスが、アプリを実行しているポッドにトラフィックを転送します。
    </br></br>
    多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。 例: <ul><li><code>http://domain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://domain/app1_path</code> の場合、<code>/app1_path</code> をパスとして入力します。</li></ul>
    </br>
    <strong>ヒント:</strong> アプリが listen するパスとは異なるパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用できます。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td><em>&lt;app1_service&gt;</em> や <em>&lt;app2_service&gt;</em> などを、アプリを公開するために作成しておいたサービスの名前に置き換えます。 クラスターの別々の名前空間にあるサービスによってアプリを公開する場合は、同じ名前空間にあるアプリ・サービスだけを組み込んでください。 公開するアプリを入れる名前空間ごとに 1 つの Ingress リソースを作成する必要があります。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
    </tr>
    </tbody></table>

3.  クラスターの Ingress リソースを作成します。 リソースで指定したアプリ・サービスと同じ名前空間にリソースがデプロイされていることを確認します。

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Ingress リソースが正常に作成されたことを確認します。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. イベント内のメッセージにリソース構成のエラーが示された場合は、リソース・ファイル内の値を変更して、リソースのファイルを再適用してください。


Ingress リソースがアプリ・サービスと同じ名前空間に作成されます。 その名前空間内のアプリがクラスターの Ingress ALB に登録されます。

### ステップ 4: プライベート・ネットワークからアプリにアクセスする
{: #private_4}

1. アプリにアクセスする前に、DNS サービスにアクセスできることを確認してください。
  * パブリック VLAN とプライベート VLAN: デフォルトの外部 DNS プロバイダーを使用するには、[パブリック・アクセス用のエッジ・ノードを構成](cs_edge.html#edge)し、[仮想ルーター・アプライアンスを構成 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) する必要があります。
  * プライベート VLAN のみ: [プライベート・ネットワークで使用可能な DNS サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を構成する必要があります。

2. プライベート・ネットワーク・ファイアウォール内で、Web ブラウザーにアプリ・サービスの URL を入力します。

```
https://<domain>/<app1_path>
```
{: pre}

複数のアプリを公開した場合は、URL に追加するパスを変更して、それぞれのアプリにアクセスしてください。

```
https://<domain>/<app2_path>
```
{: pre}

ワイルドカード・ドメインを使用して別々の名前空間にアプリを公開した場合は、それぞれのサブドメインを使用して各アプリにアクセスしてください。

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


プライベート ALB と TLS を使用してクラスター全体でマイクロサービス間通信を保護する方法を学ぶ包括的なチュートリアルがあります。[このブログの投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2) を参照してください。

<br />


## アノテーションを使用した Ingress リソースのカスタマイズ
{: #annotations}

Ingress アプリケーション・ロード・バランサー (ALB) に機能を追加するには、Ingress リソースにメタデータとして IBM 固有のアノテーションを追加します。
{: shortdesc}

まずは、最もよく使用されるアノテーションをいくつか紹介します。
* [redirect-to-https](cs_annotations.html#redirect-to-https): 非セキュア HTTP クライアント要求を HTTPS に変換します。
* [rewrite-path](cs_annotations.html#rewrite-path): 着信ネットワーク・トラフィックを、バックエンド・アプリが listen する別のパスにルーティングします。
* [ssl-services](cs_annotations.html#ssl-services): HTTPS を必要とするアップストリーム・アプリへのトラフィックを、TLS を使用して暗号化します。
* [client-max-body-size](cs_annotations.html#client-max-body-size): クライアントが要求の一部として送信できる本体の最大サイズを設定します。

サポートされるすべてのアノテーションのリストについては、[アノテーションを使用した Ingress のカスタマイズ](cs_annotations.html)を参照してください。

<br />


## Ingress ALB でポートを開く
{: #opening_ingress_ports}

デフォルトでは、Ingress ALB で公開されるのはポート 80 とポート 443 のみです。 他のポートを公開するには、`ibm-cloud-provider-ingress-cm` 構成マップ・リソースを編集します。
{:shortdesc}

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成して開きます。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. <code>data</code> セクションを追加し、パブリック・ポート `80` および `443` と、公開する他のポートをセミコロン (;) で区切って指定します。

    **重要**: デフォルトでは、ポート 80 と 443 が開きます。 80 と 443 を開いたままにしておく場合は、指定する他のポートに加えて、それらのポートも `public-ports` フィールドに含める必要があります。 指定しないポートは閉じられます。 プライベート ALB を有効にした場合は、開いたままにしておくポートも `private-ports` フィールドで指定する必要があります。

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    ポート `80`、`443`、`9443` を開いたままにしておく例:
    ```
    apiVersion: v1
    data:
      public-ports: "80;443;9443"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

3. 構成ファイルを保存します。

4. 構成マップの変更が適用されたことを確認します。

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

構成マップ・リソースについて詳しくは、[Kubernetes の資料](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)を参照してください。

<br />


## ソース IP アドレスの保持
{: #preserve_source_ip}

デフォルトでは、クライアント要求のソース IP アドレスは保持されません。アプリへのクライアント要求がクラスターに送信されると、その要求は、ALB を公開しているロード・バランサー・サービス・ポッドに転送されます。 ロード・バランサー・サービス・ポッドと同じワーカー・ノードにアプリ・ポッドが存在しない場合、ロード・バランサーは異なるワーカー・ノード上のアプリ・ポッドに要求を転送します。 パッケージのソース IP アドレスは、アプリ・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。

クライアント要求の元のソース IP アドレスを保持するには、[ソース IP の保持を有効にします ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)。クライアントの IP を保持すると、例えば、アプリ・サーバーがセキュリティーやアクセス制御ポリシーを適用する必要がある場合などに役に立ちます。

**注**: [ALB を無効にした](cs_cli_reference.html#cs_alb_configure)場合、ALB を公開するロード・バランサー・サービスに対して行ったソース IP の変更はすべて失われます。ALB を再度有効にする場合、ソース IP を再度有効にする必要があります。

ソース IP の保持を有効にするには、Ingress ALB を公開するロード・バランサー・サービスを編集します。

1. 1 つの ALB またはクラスター内のすべての ALB のソース IP の保持を有効にします。
    * 1 つの ALB のソース IP の保持をセットアップするには、次の手順を実行します。
        1. ソース IP を有効にする ALB の ID を取得します。ALB サービスは、パブリック ALB の場合は `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`、プライベート ALB の場合は `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` のような形式になります。
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. ALB を公開するロード・バランサー・サービスの YAML を開きます。
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. **spec** の下で、**externalTrafficPolicy** の値を「`Cluster`」から「`Local`」に変更します。

        4. 構成ファイルを保存して閉じます。
出力は、以下のようになります。

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * クラスター内のすべてのパブリック ALB のソース IP 保持をセットアップするには、次のコマンドを実行します。
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        出力例:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * クラスター内のすべてのプライベート ALB のソース IP 保持をセットアップするには、次のコマンドを実行します。
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        出力例:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. ソース IP が保持されていることを ALB ポッド・ログで確認します。
    1. 変更した ALB のポッドの ID を取得します。
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. その ALB ポッドのログを開きます。`client` フィールドの IP アドレスが、ロード・バランサー・サービスの IP アドレスではなく、クライアント要求の IP アドレスであることを確認します。
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. これで、バックエンド・アプリに送信された要求のヘッダーを見れば、`x-forwarded-for` ヘッダーでクライアント IP アドレスがわかるようになります。

4. ソース IP を保持しないようにする場合は、サービスに対して行った変更を戻します。
    * パブリック ALB のソース IP 保持を戻すには、次を実行します。
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * プライベート ALB のソース IP 保持を戻すには、次を実行します。
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## HTTP レベルで SSL プロトコルと SSL 暗号を構成する
{: #ssl_protocols_ciphers}

`ibm-cloud-provider-ingress-cm` 構成マップを編集して、グローバル HTTP レベルで SSL プロトコルと暗号を有効にします。
{:shortdesc}

デフォルトでは、IBM 提供のドメインを使用するすべての Ingress 構成で TLS 1.2 プロトコルが使用されます。 デフォルトをオーバーライドして TLS 1.1 か 1.0 のプロトコルを使用する場合は、以下の手順を実行します。

**注**: すべてのホストで有効なプロトコルを指定する場合、TLSv1.1 および TLSv1.2 パラメーター (1.1.13、1.0.12) は、OpenSSL 1.0.1 以上が使用されている場合にのみ使用できます。 TLSv1.3 パラメーター (1.13.0) は、TLSv1.3 対応版の OpenSSL 1.1.1 が使用されている場合にのみ使用できます。

構成マップを編集して SSL プロトコルおよび暗号を有効にするには、以下のようにします。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成して開きます。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. SSL プロトコルおよび暗号を追加します。 [OpenSSL library cipher list format ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html) に従って暗号の形式を設定します。

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

3. 構成ファイルを保存します。

4. 構成マップの変更が適用されたことを確認します。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## パフォーマンスのチューニング
{: #perf_tuning}

Ingress ALB のパフォーマンスを最適化するために、必要に応じてデフォルト設定を変更できます。{: shortdesc}



### キープアライブ接続時間の増加
{: #keepalive_time}

キープアライブ接続は、接続のオープンとクローズに必要な CPU およびネットワークのオーバーヘッドを削減することで、パフォーマンスに大きな影響を及ぼすことがあります。ALB のパフォーマンスを最適化するために、ALB とクライアントの接続のキープアライブ時間のデフォルト設定を変更することができます。{: shortdesc}

`ibm-cloud-provider-ingress-cm` Ingress 構成マップの `keep-alive` フィールドで、キープアライブ・クライアント接続を Ingress ALB に対して開いておくタイムアウトを秒単位で設定できます。デフォルトでは、`keep-alive` は `8s` に設定されます。Ingress 構成マップを編集して、デフォルト設定をオーバーライドできます。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成して開きます。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. `keep-alive` の値を `8s` より大きい値に変更します。

   ```
   apiVersion: v1
   data:
     keep-alive: "8s"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. 構成ファイルを保存します。

4. 構成マップの変更が適用されたことを確認します。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## ユーザー管理の Ingress コントローラーの構成
{: #user_managed}

クラスターに割り当てられた IBM 提供の Ingress サブドメインと TLS 証明書を活用しながら、独自の Ingress コントローラーを {{site.data.keyword.Bluemix_notm}} で実行します。
{: shortdesc}

特定の Ingress 要件がある場合は、独自のカスタム Ingress コントローラーを構成すると便利です。IBM 提供の Ingress ALB ではなく、独自の Ingress コントローラーを実行する場合は、コントローラー・イメージの提供、コントローラーの保守、コントローラーの更新を自分で行う必要があります。

1. デフォルトのパブリック ALB の ID を取得します。パブリック ALB は、`public-cr18e61e63c6e94b658596ca93d087eed9-alb1` のような形式になります。
```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. デフォルトのパブリック ALB を無効にします。`--disable-deployment` フラグは、IBM 提供の ALB デプロイメントを無効にしますが、IBM 提供の Ingress サブドメインの DNS 登録も、Ingress コントローラーを公開するために使用されるロード・バランサー・サービスも削除しません。
```
    ibmcloud ks alb-configure --alb-ID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. Ingress コントローラーの構成ファイルを準備します。例えば、[nginx コミュニティー Ingress コントローラー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/ingress-nginx/blob/master/deploy/mandatory.yaml) の YAML 構成ファイルを使用できます。

4. 独自の Ingress コントローラーをデプロイします。**重要**: コントローラーを公開するロード・バランサー・サービスと IBM 提供の Ingress サブドメインを引き続き使用するには、コントローラーを `kube-system` 名前空間にデプロイする必要があります。
```
    kubectl apply -f customingress.yaml -n kube-system
    ```
    {: pre}

5. カスタム Ingress デプロイメントのラベルを取得します。
    ```
    kubectl get deploy nginx-ingress-controller -n kube-system --show-labels
    ```
    {: pre}

    次の出力例では、ラベル値は `ingress-nginx` です。
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

5. ステップ 1 で取得した ALB ID を使用して、ALB を公開するロード・バランサー・サービスを開きます。
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

6. カスタム Ingress デプロイメントを指すようにロード・バランサー・サービスを更新します。`spec/selector` の下で、`app` ラベルから ALB ID を削除し、ステップ 5 で取得した独自の Ingress コントローラーのラベルを追加します。
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. オプション: デフォルトでは、ロード・バランサー・サービスは、ポート 80 と 443 のトラフィックを許可します。カスタム Ingress コントローラーで異なるポートのセットを使用する必要がある場合は、それらのポートを `ports` セクションに追加します。

7. 構成ファイルを保存して閉じます。出力は、以下のようになります。
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

8. ALB `Selector` がユーザーのコントローラーを指していることを確認します。
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    出力例:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

8. 構成マップなど、カスタム Ingress コントローラーに必要なその他のリソースをデプロイします。

9. 複数ゾーン・クラスターがある場合は、ALB ごとにこれらの手順を繰り返します。

10. [クラスター内部にあるアプリをパブリックに公開する](#ingress_expose_public)の手順に従って、アプリの Ingress リソースを作成します。

これで、カスタム Ingress コントローラーでアプリが公開されるようになりました。IBM 提供の ALB デプロイメントを復元するには、ALB を再度有効にします。ALB が再デプロイされ、ロード・バランサー・サービスがその ALB を指すように自動的に再構成されます。

```
ibmcloud ks alb-configure --alb-ID <alb ID> --enable
```
{: pre}
