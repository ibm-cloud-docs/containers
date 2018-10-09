---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# ロギングとモニタリング
{: #health}

{{site.data.keyword.containerlong}} でロギングとモニタリングをセットアップすると、問題のトラブルシューティングや、Kubernetes クラスターとアプリの正常性とパフォーマンスの改善に役立ちます。
{: shortdesc}

## クラスターおよびアプリのログ転送について
{: #logging}

継続的なモニタリングとロギングは、クラスターへの攻撃を検出し、問題が発生したときに問題をトラブルシューティングするために重要です。 クラスターを継続的にモニターすることによって、クラスターの容量、およびアプリで使用可能なリソースの可用性をよく把握することができます。 そうすることで、状態に応じて、ダウン時にアプリを保護する備えができます。 ロギングを構成するには、{{site.data.keyword.containerlong_notm}} 内の標準 Kubernetes クラスターで作業している必要があります。
{: shortdesc}


**IBM は個々の利用者のクラスターをモニターしますか?**
Kubernetes マスターはすべて IBM によって継続的にモニターされます。 {{site.data.keyword.containerlong_notm}} は、Kubernetes マスターがデプロイされたすべてのノードにおいて、Kubernetes および OS 固有のセキュリティー修正で検出された脆弱性を自動的にスキャンします。 脆弱性が見つかった場合、{{site.data.keyword.containerlong_notm}} はユーザーに代わって自動的に修正を適用し、脆弱性を解決して、マスター・ノードが確実に保護されるようにします。 残りのクラスターのログのモニターと分析は、お客様が行う必要があります。

**どのソースのロギングを構成できますか?**

ロギングを構成できるソースの場所は、次の図のとおりです。

![ログ・ソース](images/log_sources.png)

<ol>
<li><p><code>アプリケーション</code>: アプリケーション・レベルで発生するイベントに関する情報。 これは、ログインの成功、ストレージに関する警告、アプリ・レベルで実行できるその他の操作などのイベントが発生したという通知である可能性があります。</p> <p>パス: ログの転送先にするパスを設定できます。 ただし、ログを送信するには、ロギング構成で絶対パスを使用する必要があります。そうしないとログは読み取られません。 パスがワーカー・ノードにマウントされている場合は、シンボリック・リンクが作成されている可能性があります。 例: 指定されたパスが <code>/usr/local/<b>spark</b>/work/app-0546/0/stderr</code> であるのに、実際にはログが <code>/usr/local/<b>spark-1.0-hadoop-1.2</b>/work/app-0546/0/stderr</code> に送信されている場合、ログは読み取れません。</p></li>

<li><p><code>コンテナー</code>: 実行中のコンテナーによってログに記録される情報。</p> <p>パス: <code>STDOUT</code> または <code>STDERR</code> に書き込まれるすべての情報。</p></li>

<li><p><code>ingress</code>: Ingress アプリケーション・ロード・バランサーを介してクラスターに伝送されるネットワーク・トラフィックに関する情報。 特定の構成情報については、[Ingress の資料](cs_ingress.html#ingress_log_format)を確認してください。</p> <p>パス: <code>/var/log/alb/ids/&ast;.log</code>、<code>/var/log/alb/ids/&ast;.err</code>、 <code>/var/log/alb/customerlogs/&ast;.log</code>、<code>/var/log/alb/customerlogs/&ast;.err</code></p></li>

<li><p><code>kube-audit</code>: Kubernetes API サーバーに送信されるクラスター関連アクションに関する情報。時間、ユーザー、および影響を受けるリソースを含みます。</p></li>

<li><p><code>kubernetes</code>: kube-system 名前空間内で実行される、ワーカー・ノードで発生する kubelet、kube-proxy、およびその他の Kubernetes イベントからの情報。</p><p>パス: <code>/var/log/kubelet.log</code>、 <code>/var/log/kube-proxy.log</code>、<code>/var/log/event-exporter/*.log</code></p></li>

<li><p><code>ワーカー</code>: ユーザーがワーカー・ノードに指定したインフラストラクチャー構成に固有の情報。 ワーカー・ログは syslog に取り込まれ、オペレーティング・システムのイベントが含まれます。 auth.log には、OS に対して行われた認証要求に関する情報が含まれます。 </p><p>パス: <code>/var/log/syslog</code> および <code>/var/log/auth.log</code></p></li>
</ol>

</br>

**構成オプションにはどのようなものがありますか?**

ロギングを構成する際に使用できる各種オプションとその説明は、次の表のとおりです。

<table>
<caption> ロギング構成オプションについて</caption>
  <thead>
    <th>オプション</th>
    <th>説明</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
      <td>クラスターの名前または ID。</td>
    </tr>
    <tr>
      <td><code><em>--log_source</em></code></td>
      <td>ログの転送元になるソース。 指定可能な値は、<code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code>、および <code>kube-audit</code> です。</td>
    </tr>
    <tr>
      <td><code><em>--type</em></code></td>
      <td>ログの転送先。 オプションは、ログを {{site.data.keyword.loganalysisshort_notm}} に転送する <code>ibm</code> と、ログを外部サーバーに転送する <code>syslog</code> です。</td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>オプション: ログの転送元になる Kubernetes 名前空間。 ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。 この値は、<code>container</code> ログ・ソースについてのみ有効です。 名前空間を指定しないと、クラスター内のすべての名前空間でこの構成が使用されます。</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>{{site.data.keyword.loganalysisshort_notm}} の場合は、[取り込み URL](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)を使用します。 取り込み URL を指定しない場合、クラスターを作成した地域のエンドポイントが使用されます。</p>
      <p>syslog の場合は、ログ・コレクター・サービスのホスト名または IP アドレスを指定します。</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>取り込みポート。 ポートを指定しないと、標準ポート <code>9091</code> が使用されます。
      <p>syslog の場合は、ログ・コレクター・サーバーのポートを指定します。 ポートを指定しないと、標準ポート <code>514</code> が使用されます。</td>
    </tr>
    <tr>
      <td><code><em>--space</em></code></td>
      <td>オプション: ログの送信先となる Cloud Foundry スペースの名前。 ログを {{site.data.keyword.loganalysisshort_notm}} に転送するとき、スペースと組織は取り込みポイントで指定されます。 スペースを指定しない場合、ログはアカウント・レベルに送信されます。 space を指定する場合は、org. も指定する必要があります。</td>
    </tr>
    <tr>
      <td><code><em>--org</em></code></td>
      <td>オプション: このスペースが属する Cloud Foundry 組織の名前。 この値は、スペースを指定した場合には必須です。</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>オプション: アプリのログを転送するには、アプリが含まれているコンテナーの名前を指定します。 コンマ区切りのリストを使用して複数のコンテナーを指定できます。 コンテナーを指定しない場合は、指定したパスが入っているすべてのコンテナーのログが転送されます。</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>アプリがログを書き込むコンテナー上のパス。 ソース・タイプが <code>application</code> のログを転送するには、パスを指定する必要があります。 複数のパスを指定するには、コンマ区切りリストを使用します。 例: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></td>
    </tr>
    <tr>
      <td><code><em>--syslog-protocol</em></code></td>
      <td>ロギング・タイプが <code>syslog</code> の場合は、トランスポート層プロトコル。 `udp`、`tls`、または `tcp` の各プロトコルを使用できます。 <code>udp</code> プロトコルを使用して rsyslog サーバーに転送する場合、1KB を超えるログは切り捨てられます。</td>
    </tr>
    <tr>
      <td><code><em>--ca-cert</em></code></td>
      <td>必須: ロギング・タイプが <code>syslog</code> で、プロトコルが <code>tls</code> である場合、認証局証明書を含む Kubernetes シークレット名。</td>
    </tr>
    <tr>
      <td><code><em>--verify-mode</em></code></td>
      <td>ロギング・タイプが <code>syslog</code> で、プロトコルが <code>tls</code> である場合、検証モード。 サポートされる値は <code>verify-peer</code> で、デフォルトは <code>verify-none</code>。</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>オプション: 組織名とスペース名が指定されている場合にそれらの検証をスキップします。 検証をスキップすると処理時間は短縮されますが、ロギング構成が無効な場合、ログは正しく転送されません。</td>
    </tr>
  </tbody>
</table>

**ロギング用の Fluentd は自分で更新し続ける必要がありますか?**

ロギングまたはフィルター構成を変更するには、Fluentd ロギング・アドオンが最新バージョンである必要があります。 デフォルトでは、このアドオンに対する自動更新が有効になっています。 自動更新を使用不可にするには、[クラスターのアドオンの更新: ロギング用の Fluentd](cs_cluster_update.html#logging)を参照してください。

<br />


## ログ転送の構成
{: #configuring}

GUI または CLI を使用して、{{site.data.keyword.containerlong_notm}} のロギングを構成できます。
{: shortdesc}

### GUI を使用したログ転送の有効化
{: #enable-forwarding-ui}

{{site.data.keyword.containerlong_notm}} ダッシュボードでログ転送を構成できます。 この処理が完了するまで数分かかることがあるため、すぐにログが表示されない場合は、数分待ってから再度確認してください。

アカウント・レベルで特定のコンテナー名前空間用またはアプリ・ロギング用の構成を作成するには、CLI を使用します。
{: tip}

1. ダッシュボードの**「概要」**タブにナビゲートします。
2. ログの転送元となる Cloud Foundry 組織とスペースを選択します。 ダッシュボードでログ転送を構成すると、クラスターのデフォルトの {{site.data.keyword.loganalysisshort_notm}} エンドポイントにログが送信されます。 外部サーバーまたは別の {{site.data.keyword.loganalysisshort_notm}} エンドポイントにログを転送するには、CLI を使用してロギングを構成します。
3. ログの転送元となるログ・ソースを選択します。
4. **「作成」**をクリックします。

</br>
</br>

### CLI を使用したログ転送の有効化
{: #enable-forwarding}

クラスター・ロギングの構成を作成できます。 フラグを使用することによって、異なるロギング・オプションを区別できます。

**IBM へのログの転送**

1. 権限を確認してください。 クラスターまたはロギング構成を作成したときにスペースを指定した場合は、アカウント所有者と {{site.data.keyword.containerlong_notm}} API キー所有者の両方に、そのスペースの管理者、開発者、または監査員の[許可](cs_users.html#access_policies)が必要となります。
  * {{site.data.keyword.containerlong_notm}} API 鍵所有者が不明な場合は、以下のコマンドを実行します。
      ```
      ibmcloud ks api-key-info <cluster_name>
      ```
      {: pre}
  * 行った変更を即時に適用するには、以下のコマンドを実行します。
      ```
      ibmcloud ks logging-config-refresh <cluster_name>
      ```
      {: pre}

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。

  専用アカウントを使用している場合は、パブリックの {{site.data.keyword.cloud_notm}} エンドポイントにログインし、ログ転送を有効にするために、パブリックの組織とスペースをターゲットにする必要があります。
  {: tip}

3. ログ転送構成を作成します。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --type ibm --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs> --skip-validation
    ```
    {: pre}

  * デフォルトの名前空間および出力用のコンテナー・ロギング構成例
    ```
    ibmcloud ks logging-config-create mycluster
    Creating cluster mycluster logging configurations...
    OK
    ID                                      Source      Namespace    Host                                 Port    Org  Space   Server Type   Protocol   Application Containers   Paths
    4e155cf0-f574-4bdb-a2bc-76af972cae47    container       *        ingest.logging.eu-gb.bluemix.net✣   9091✣    -     -        ibm           -                  -               -
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

  * アプリケーション・ロギングの構成と出力の例:
    ```
    ibmcloud ks logging-config-create cluster2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'container1,container2,container3'
    Creating logging configuration for application logs in cluster cluster2...
    OK
    Id                                     Source        Namespace   Host                                    Port    Org   Space   Server Type   Protocol   Application Containers               Paths
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.stage1.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

コンテナー内で実行するアプリを、STDOUT または STDERR にログを書き込むように構成できない場合は、アプリ・ログ・ファイルからログを転送するログ構成を作成できます。
{: tip}

</br>
</br>


**`udp` または `tcp` プロトコルを介してユーザー自身のサーバーにログを転送する**

1. ログを syslog に転送するには、以下の 2 つの方法のいずれかで、syslog プロトコルを受け入れるサーバーをセットアップします。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。 プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。

  * コンテナーから syslog を実行します。 例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。 このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。

  syslog 接頭部を削除することによって、有効な JSON としてログを表示できます。 これを行うには、rsyslog サーバーが稼働している環境の <code>etc/rsyslog.conf</code> ファイルの先頭に次のコードを追加します。<code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。 専用アカウントを使用している場合は、パブリックの {{site.data.keyword.cloud_notm}} エンドポイントにログインし、ログ転送を有効にするために、パブリックの組織とスペースをターゲットにする必要があります。

3. ログ転送構成を作成します。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br>
</br>


**`tls` プロトコルを介してユーザー自身のサーバーにログを転送する**

以下のステップは、一般的な説明です。 実稼働環境でコンテナーを使用する前に、必要なセキュリティー条件を満たしていることを確認してください。
{: tip}

1. 以下の 2 つの方法のいずれかで、syslog プロトコルを受け入れるサーバーをセットアップします。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。 プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。

  * コンテナーから syslog を実行します。 例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。 このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。 関連する認証局証明書およびサーバー・サイド証明書を注入し、`syslog.conf` を更新して、サーバー上で `tls` を有効にする必要があります。

2. 認証局証明書を `ca-cert` という名前のファイルに保存します。この名前のとおりでなければなりません。

3. `ca-cert` ファイル用のシークレットを `kube-system` 名前空間に作成します。 ロギング構成を作成するときは、`--ca-cert` フラグにこのシークレット名を使用します。
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

4. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。 専用アカウントを使用している場合は、パブリックの {{site.data.keyword.cloud_notm}} エンドポイントにログインし、ログ転送を有効にするために、パブリックの組織とスペースをターゲットにする必要があります。

3. ログ転送構成を作成します。
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br>
</br>


### ログ転送の確認
{: verify-logging}

以下の 2 とおりのいずれかの方法で、構成が正しくセットアップされていることを確認できます。

* クラスター内のすべてのロギング構成をリスト表示する場合には、以下のようにします。
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

* 1 つのタイプのログ・ソースのロギング構成をリストする場合には、以下のようにします。
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br>
</br>

### ログ転送の更新
{: #updating-forwarding}

既に作成したロギング構成を更新することができます。

1. ログ転送構成を更新します。
    ```
    ibmcloud ks logging-config-update <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### ログ転送の停止
{: #log_sources_delete}

クラスターの 1 つまたはすべてのロギング構成によるログの転送を停止できます。
{: shortdesc}

1. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。

2. ロギング構成を削除します。
  <ul>
  <li>1 つのロギング構成を削除するには、以下のようにします。</br>
    <pre><code>ibmcloud ks logging-config-rm &lt;cluster_name_or_ID&gt; --id &lt;log_config_ID&gt;</pre></code></li>
  <li>すべてのロギング構成を削除するには、以下のようにします。</br>
    <pre><code>ibmcloud ks logging-config-rm <my_cluster> --all</pre></code></li>
  </ul>

</br>
</br>

### ログの表示
{: #view_logs}

クラスターとコンテナーのログを表示するには、Kubernetes とコンテナー・ランタイムの標準的なロギング機能を使用します。
{:shortdesc}

**{{site.data.keyword.loganalysislong_notm}}**
{: #view_logs_k8s}

Kibana ダッシュボードで、{{site.data.keyword.loganalysislong_notm}} に転送したログを参照できます。
{: shortdesc}

デフォルト値を使用して構成ファイルを作成した場合は、クラスターが作成されたアカウント (または組織とスペース) にログがあります。 構成ファイルに組織とスペースを指定した場合は、そのスペースにログがあります。 ロギングについて詳しくは、[{{site.data.keyword.containerlong_notm}} のロギング](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)を参照してください。

Kibana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターのログ転送を構成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。
- 米国南部および米国東部: https://logging.ng.bluemix.net
- 英国南部: https://logging.eu-gb.bluemix.net
- EU 中央: https://logging.eu-fra.bluemix.net
- 南アジア太平洋地域: https://logging.au-syd.bluemix.net

ログの表示について詳しくは、[Web ブラウザーから Kibana へのナビゲート](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)を参照してください。

</br>

**コンテナー・ログ**

組み込みのコンテナー・ランタイム・ロギング機能を活用して、標準の STDOUT と STDERR 出力ストリームでアクティビティーを確認することができます。詳しくは、[Kubernetes クラスターで実行されるコンテナーのコンテナー・ログの表示](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)を参照してください。

<br />


## ログのフィルタリング
{: #filter-logs}

一定期間における特定のログをフィルターで除外して、転送するログを選択することができます。 フラグを使用することによって、異なるフィルター操作オプションを区別できます。

<table>
<caption>ログ・フィルター操作のオプションについて</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ログ・フィルター操作オプションについて</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;cluster_name_or_ID&gt;</td>
      <td>必須: ログをフィルターに掛けるクラスターの名前または ID。</td>
    </tr>
    <tr>
      <td><code>&lt;log_type&gt;</code></td>
      <td>フィルターを適用するログのタイプ。 現在、<code>all</code>、<code>container</code>、<code>host</code> がサポートされています。</td>
    </tr>
    <tr>
      <td><code>&lt;configs&gt;</code></td>
      <td>オプション: ロギング構成 ID のコンマ区切りのリスト。 指定しない場合、フィルターに渡されたすべてのクラスター・ロギング構成にフィルターが適用されます。 フィルターと一致するログ構成を表示するには、<code>--show-matching-configs</code> オプションを使用します。</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes_namespace&gt;</code></td>
      <td>オプション: ログの転送元になる Kubernetes 名前空間。 このフラグは、ログ・タイプ <code>container</code> を使用している場合にのみ、適用されます。</td>
    </tr>
    <tr>
      <td><code>&lt;container_name&gt;</code></td>
      <td>オプション: ログをフィルタリングするコンテナーの名前。</td>
    </tr>
    <tr>
      <td><code>&lt;logging_level&gt;</code></td>
      <td>オプション: 指定したレベル以下のログをフィルターで除外します。 指定できる値は、規定の順に <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code>、<code>trace</code> です。 例えば、<code>info</code> レベルのログをフィルタリングした場合、<code>debug</code> と <code>trace</code> もフィルタリングされます。 **注**: このフラグは、ログ・メッセージが JSON 形式で、レベル・フィールドを含んでいる場合にのみ使用できます。 JSON 形式でメッセージを表示するには、<code>--json</code> フラグをコマンドに付加します。</td>
    </tr>
    <tr>
      <td><code>&lt;メッセージ&gt;</code></td>
      <td>オプション: 正規表現で記述された指定メッセージが含まれるログをフィルターで除外します。</td>
    </tr>
    <tr>
      <td><code>&lt;filter_ID&gt;</code></td>
      <td>オプション: ログ・フィルターの ID。</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>オプション: 各フィルターが適用されるロギング構成を表示します。</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>オプション: すべてのログ転送フィルターを削除します。</td>
    </tr>
  </tbody>
</table>


1. ロギング・フィルターを作成します。
  ```
  ibmcloud ks logging-filter-create <cluster_name_or_ID> --type <log_type> --logging-configs <configs> --namespace <kubernetes_namespace> --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

2. 作成したログ・フィルターを表示します。

  ```
  ibmcloud ks logging-filter-get <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. 作成したログ・フィルターを更新します。
  ```
  ibmcloud ks logging-filter-update <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. 作成したログ・フィルターを削除します。

  ```
  ibmcloud ks logging-filter-rm <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## Kubernetes API 監査ログのログ転送の構成
{: #api_forward}

Kubernetes は、apiserver を通るすべてのイベントを自動的に監査します。 {{site.data.keyword.loganalysisshort_notm}} または外部サーバーにイベントを転送できます。
{: shortdesc}


Kubernetes 監査ログについて詳しくは、Kubernetes 資料の<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">監査トピック <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。

* Kubernetes API 監査ログの転送は、Kubernetes バージョン 1.7 以降でのみサポートされています。
* 現在は、このロギング構成のすべてのクラスターで、デフォルトの監査ポリシーが使用されます。
* 現在、フィルターはサポートされていません。
* クラスターごとに 1 つの `kube-audit` 構成しか設定できませんが、ロギング構成と Webhook を作成することで、{{site.data.keyword.loganalysisshort_notm}} と外部サーバーにログを転送できます。
{: tip}


### {{site.data.keyword.loganalysisshort_notm}} への監査ログの送信
{: #audit_enable_loganalysis}

Kubernetes API サーバーの監査ログを {{site.data.keyword.loganalysisshort_notm}} に転送できます。

**始める前に**

1. 権限を確認してください。 クラスターまたはロギング構成の作成時にスペースを指定した場合は、アカウント所有者と {{site.data.keyword.containerlong_notm}} 鍵所有者の両方に、そのスペースの管理者権限、開発者権限、または監査員権限が必要です。

2. [CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、API サーバー監査ログの収集対象となるクラスターに設定します。 **注**: 専用アカウントを使用している場合は、パブリックの {{site.data.keyword.cloud_notm}} エンドポイントにログインし、ログ転送を有効にするために、パブリックの組織とスペースをターゲットにする必要があります。

**ログの転送**

1. ロギング構成を作成します。

    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource kube-audit --space <cluster_space> --org <cluster_org> --hostname <ingestion_URL> --type ibm
    ```
    {: pre}

    コマンドと出力の例:

    ```
    ibmcloud ks logging-config-create myCluster --logsource kube-audit
    Creating logging configuration for kube-audit logs in cluster myCluster...
    OK
    Id                                     Source      Namespace   Host                                   Port     Org    Space   Server Type   Protocol  Application Containers   Paths
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -         ingest-au-syd.logging.bluemix.net✣    9091✣     -       -         ibm          -              -                  -

    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

    ```
    {: screen}

    <table>
    <caption>このコマンドの構成要素について</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
          <td>クラスターの名前または ID。</td>
        </tr>
        <tr>
          <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
          <td>ログの転送先となるエンドポイント。 [取り込み URL](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) を指定しない場合、クラスターを作成した地域のエンドポイントが使用されます。</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_space&gt;</em></code></td>
          <td>オプション: ログの送信先となる Cloud Foundry スペースの名前。 ログを {{site.data.keyword.loganalysisshort_notm}} に転送するとき、スペースと組織は取り込みポイントで指定されます。 スペースを指定しない場合、ログはアカウント・レベルに送信されます。</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_org&gt;</em></code></td>
          <td>このスペースが属する Cloud Foundry 組織の名前。 この値は、スペースを指定した場合には必須です。</td>
        </tr>
      </tbody>
    </table>

2. クラスター・ロギング構成を表示して、意図したとおりに実装されたことを確認します。

    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

    コマンドと出力の例:
    ```
    ibmcloud ks logging-config-get myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. オプション: 監査ログの転送を停止するには、[構成を削除](#log_sources_delete)します。

<br />



### 外部サーバーへの監査ログの送信
{: #audit_enable}

**始める前に**

1. ログを転送できるリモート・ロギング・サーバーをセットアップします。 例えば、[Logstash と Kubernetes を使用して ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend)、監査イベントを収集できます。

2. [CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、API サーバー監査ログの収集対象となるクラスターに設定します。 **注**: 専用アカウントを使用している場合は、パブリックの {{site.data.keyword.cloud_notm}} エンドポイントにログインし、ログ転送を有効にするために、パブリックの組織とスペースをターゲットにする必要があります。

Kubernetes API 監査ログを転送するには、以下のようにします。

1. Webhook をセットアップします。 どのフラグにも情報を指定しない場合、デフォルトの構成が使用されます。

    ```
    ibmcloud ks apiserver-config-set audit-webhook <cluster_name_or_ID> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

  <table>
  <caption>このコマンドの構成要素について</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
        <td>クラスターの名前または ID。</td>
      </tr>
      <tr>
        <td><code><em>&lt;server_URL&gt;</em></code></td>
        <td>ログの送信先となるリモート・ロギング・サービスの URL または IP アドレス。 非セキュアなサーバー URL を指定すると、証明書は無視されます。</td>
      </tr>
      <tr>
        <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
        <td>リモート・ロギング・サービスの検証に使用される CA 証明書のファイル・パス。</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_cert_path&gt;</em></code></td>
        <td>リモート・ロギング・サービスに対する認証に使用されるクライアント証明書のファイル・パス。</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_key_path&gt;</em></code></td>
        <td>リモート・ロギング・サービスへの接続に使用される、対応するクライアント・キーのファイル・パス。</td>
      </tr>
    </tbody>
  </table>

2. リモート・ロギング・サービスの URL を参照して、ログ転送が有効化されていることを確認します。

    ```
    ibmcloud ks apiserver-config-get audit-webhook <cluster_name_or_ID>
    ```
    {: pre}

    出力例:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Kubernetes マスターを再始動して、構成の更新を適用します。

    ```
    ibmcloud ks apiserver-refresh <cluster_name_or_ID>
    ```
    {: pre}

4. オプション: 監査ログの転送を停止するには、構成を無効にします。
    1. [CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、API サーバー監査ログの収集停止対象となるクラスターにします。
    2. クラスターの API サーバーの Web フック・バックエンド構成を無効にします。

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. Kubernetes マスターを再始動して、構成の更新を適用します。

        ```
        ibmcloud ks apiserver-refresh <cluster_name_or_ID>
        ```
        {: pre}

## メトリックの表示
{: #view_metrics}

メトリックは、クラスターの正常性とパフォーマンスをモニターするのに役立ちます。 Kubernetes とコンテナー・ランタイムの標準機能を使用して、クラスターとアプリの正常性をモニターできます。**注**: モニタリングは標準クラスターでのみサポートされています。
{:shortdesc}

<dl>
  <dt>{{site.data.keyword.Bluemix_notm}} のクラスター詳細ページ</dt>
    <dd>{{site.data.keyword.containerlong_notm}} には、クラスターの正常性と能力、そしてクラスター・リソースの使用方法に関する情報が表示されます。 この GUI を使用して、クラスターのスケールアウト、永続ストレージの作業、{{site.data.keyword.Bluemix_notm}} サービス・バインディングによるクラスターへの機能の追加を行うことができます。 クラスターの詳細ページを表示するには、**{{site.data.keyword.Bluemix_notm}} の「ダッシュボード」**に移動して、クラスターを選択します。</dd>
  <dt>Kubernetes ダッシュボード</dt>
    <dd>Kubernetes ダッシュボードは、ワーカー・ノードの正常性の確認、Kubernetes リソースの検索、コンテナー化アプリのデプロイ、ロギングとモニタリング情報を使用したアプリのトラブルシューティングを行える管理 Web インターフェースです。 Kubernetes ダッシュボードにアクセスする方法について詳しくは、[{{site.data.keyword.containerlong_notm}} での Kubernetes ダッシュボードの起動](cs_app.html#cli_dashboard)を参照してください。</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>標準クラスターのメトリックは、Kubernetes クラスターを作成したときにログインした {{site.data.keyword.Bluemix_notm}} アカウントにあります。 クラスターの作成時に {{site.data.keyword.Bluemix_notm}} スペースを指定した場合、メトリックはそのスペースに配置されます。 コンテナーのメトリックはクラスターにデプロイされたすべてのコンテナーについて自動的に収集されます。 これらのメトリックが送信され、Grafana で使用できるようになります。 メトリックについて詳しくは、[{{site.data.keyword.containerlong_notm}} のモニター](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)を参照してください。</p>
    <p>Grafana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。</p> <table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバー・ゾーン、2 列目は対応する IP アドレスです。">
  <caption>モニター・トラフィック用に開く IP アドレス</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地域</th>
        <th>モニタリング・アドレス</th>
        <th>モニタリング IP アドレス</th>
        </thead>
      <tbody>
        <tr>
         <td>中欧</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>英国南部</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>米国東部、米国南部、北アジア太平洋地域、南アジア太平洋地域</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
 </dd>
</dl>

### その他のヘルス・モニター・ツール
{: #health_tools}

他のツールを構成してモニター機能を追加することができます。
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus は、Kubernetes のために設計されたモニタリング、ロギング、アラートのためのオープン・ソースのツールです。 このツールは、Kubernetes のロギング情報に基づいてクラスター、ワーカー・ノード、デプロイメントの正常性に関する詳細情報を取得します。 セットアップ方法について詳しくは、[{{site.data.keyword.containerlong_notm}} とのサービスの統合](cs_integrations.html#integrations)を参照してください。</dd>
</dl>

<br />


## Autorecovery を使用したワーカー・ノードの正常性モニタリングの構成
{: #autorecovery}

{{site.data.keyword.containerlong_notm}} Autorecovery システムは、Kubernetes バージョン 1.7 以降の既存のクラスターにデプロイできます。
{: shortdesc}

Autorecovery システムは、さまざまな検査機能を使用してワーカー・ノードの正常性状況を照会します。 Autorecovery は、構成された検査に基づいて正常でないワーカー・ノードを検出すると、ワーカー・ノードの OS の再ロードのような修正アクションをトリガーします。 修正アクションは、一度に 1 つのワーカー・ノードに対してのみ実行されます。 1 つのワーカー・ノードの修正アクションが正常に完了してからでないと、別のワーカー・ノードの修正アクションは実行されません。 詳しくは、[Autorecovery に関するブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/) を参照してください。</br> </br>
**注**: Autorecovery が正常に機能するためには、1 つ以上の正常なノードが必要です。 Autorecovery でのアクティブな検査は、複数のワーカー・ノードが存在するクラスターでのみ構成します。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ワーカー・ノードの状況を検査するクラスターに設定してください。

1. [クラスター用の Helm をインストールし、Helm インスタンスに {{site.data.keyword.Bluemix_notm}} リポジトリーを追加します](cs_integrations.html#helm)。

2. 検査を JSON 形式で定義する構成マップ・ファイルを作成します。 例えば、次の YAML ファイルでは、3 つの検査 (1 つの HTTP 検査と 2 つの Kubernetes API サーバー検査) を定義しています。 この 3 種類の検査とそれらの検査の個々の構成要素については、YAML ファイルの例に続く表を参照してください。
</br>
   **ヒント:** 構成マップの `data` セクションに、各検査を固有キーとして定義します。

   ```
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ibm-worker-recovery-checks
     namespace: kube-system
   data:
     checknode.json: |
       {
         "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
        }
      checkpod.json: |
        {
         "Check":"KUBEAPI",
         "Resource":"POD",
         "PodFailureThresholdPercent":50,
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
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
   ```
   {:codeblock}

   <table summary="構成マップの構成要素について">
   <caption>構成マップの構成要素について</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/>構成マップの構成要素について</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>構成名 <code>ibm-worker-recovery-checks</code> は定数であり、変更することはできません。</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td><code>kube-system</code> 名前空間は定数であり、変更することはできません。</td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>各ワーカー・ノードが <code>Ready</code> 状態であるかどうかを検査する Kubernetes API ノード検査を定義します。 特定のワーカー・ノードが<code>Ready</code> 状態でない場合、そのワーカー・ノードの検査結果は失敗となります。 サンプル YAML では、検査が 3 分ごとに実行されます。 連続して 3 回失敗すると、ワーカー・ノードは再ロードされます。 この操作は、<code>ibmcloud ks worker-reload</code> を実行することと同等です。<br></br><b>「有効」</b>フィールドを <code>false</code> に設定するか、または検査を除去するまで、ノード検査は有効になります。</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
   ワーカー・ノード上の <code>NotReady</code> ポッドの合計パーセンテージを、そのワーカー・ノードに割り当てられた合計ポッド数に基づいて検査する、Kubernetes API ポッド検査を定義します。 <code>NotReady</code> ポッドの合計パーセンテージが、定義済みの <code>PodFailureThresholdPercent</code> より大きい場合、そのワーカー・ノードの検査結果は失敗となります。 サンプル YAML では、検査が 3 分ごとに実行されます。 連続して 3 回失敗すると、ワーカー・ノードは再ロードされます。 この操作は、<code>ibmcloud ks worker-reload</code> を実行することと同等です。 例えば、デフォルトの <code>PodFailureThresholdPercent</code> は 50% です。<code>NotReady</code> ポッドの割合が連続 3 回 50% を超えると、ワーカー・ノードが再ロードされます。 <br></br>デフォルトでは、すべての名前空間のポッドが検査されます。 指定した名前空間内のポッドのみに検査を限定するには、<code>「名前空間」</code>フィールドを検査に追加します。 <b>「有効」</b>フィールドを <code>false</code> に設定するか、または検査を除去するまで、ポッド検査は有効になります。
   </td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>ワーカー・ノードで稼働している HTTP サーバーが正常かどうかを検査する HTTP 検査を定義します。 この検査を使用するには、[DaemonSet ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用して、クラスター内のすべてのワーカー・ノードに HTTP サーバーをデプロイする必要があります。 HTTP サーバーが正常かどうかを検証できるヘルス・チェックを、<code>/myhealth</code> パスで利用できるように実装する必要があります。 他のパスを定義するには、<strong>Route</strong> パラメーターを変更します。 HTTP サーバーが正常である場合は、<strong>ExpectedStatus</strong> で定義されている HTTP 応答コードを返す必要があります。 HTTP サーバーは、ワーカー・ノードのプライベート IP アドレスで listen するように構成する必要があります。 プライベート IP アドレスを調べるには、<code>kubectl get nodes</code> ノードを実行します。<br></br>
   例えば、プライベート IP アドレスが 10.10.10.1 および 10.10.10.2 の 2 つのノードがクラスターにあるとします。 この例では、<code>http://10.10.10.1:80/myhealth</code> および <code>http://10.10.10.2:80/myhealth</code> の 2 つのルートの 200 HTTP 応答を検査します。
   サンプル YAML では、検査が 3 分ごとに実行されます。 連続して 3 回失敗すると、ワーカー・ノードはリブートされます。 この操作は、<code>ibmcloud ks worker-reboot</code> を実行することと同等です。<br></br><b>「有効」</b>フィールドを <code>true</code> に設定するまで、HTTP 検査は無効になります。</td>
   </tr>
   </tbody>
   </table>

   <table summary="検査の個々の構成要素について">
   <caption>検査の個々の構成要素について</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/>検査の個々の構成要素について </th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Autorecovery で使用する検査のタイプを入力します。 <ul><li><code>HTTP</code>: Autorecovery は、各ノードで稼働する HTTP サーバーを呼び出して、ノードが正常に稼働しているかどうかを判別します。</li><li><code>KUBEAPI</code>: Autorecovery は、Kubernetes API サーバーを呼び出し、ワーカー・ノードによって報告された正常性状況データを読み取ります。</li></ul></td>
   </tr>
   <tr>
   <td><code>リソース</code></td>
   <td>検査タイプが <code>KUBEAPI</code> である場合は、Autorecovery で検査するリソースのタイプを入力します。 受け入れられる値は <code>NODE</code> または <code>POD</code> です。</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>検査の連続失敗数のしきい値を入力します。 このしきい値に達すると、Autorecovery が、指定された修正アクションをトリガーします。 例えば、値が 3 である場合に、Autorecovery で構成された検査が 3 回連続して失敗すると、Autorecovery は検査に関連付けられている修正アクションをトリガーします。</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>リソース・タイプが <code>POD</code> である場合は、[NotReady ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状態になることができるワーカー・ノード上のポッドのしきい値 (パーセンテージ) を入力します。 このパーセンテージは、ワーカー・ノードにスケジュールされているポッドの合計数に基づきます。 検査の結果、正常でないポッドのパーセンテージがしきい値を超えていることが判別されると、1 回の失敗としてカウントされます。</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>失敗しきい値に達したときに実行するアクションを入力します。 修正アクションは、他のワーカーが修復されておらず、しかもこのワーカー・ノードが以前のアクション実行時のクールオフ期間にないときにのみ実行されます。 <ul><li><code>REBOOT</code>: ワーカー・ノードをリブートします。</li><li><code>RELOAD</code>: ワーカー・ノードに必要な構成をすべて、クリーンな OS から再ロードします。</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>既に修正アクションが実行されたノードに対して別の修正アクションを実行するために Autorecovery が待機する必要がある秒数を入力します。 クールオフ期間は、修正アクションが実行された時点から始まります。</td>
   </tr>
   <tr>
   <td><code>IntervalSeconds</code></td>
   <td>連続する検査の間隔の秒数を入力します。 例えば、値が 180 である場合、Autorecovery は 3 分ごとに各ノードで検査を実行します。</td>
   </tr>
   <tr>
   <td><code>TimeoutSeconds</code></td>
   <td>データベースに対する検査の呼び出しの最大秒数を入力します。この秒数が経過すると、Autorecovery は呼び出し動作を終了します。 <code>TimeoutSeconds</code> の値は、<code>IntervalSeconds</code> の値より小さくする必要があります。</td>
   </tr>
   <tr>
   <td><code>ポート</code></td>
   <td>検査タイプが <code>HTTP</code> である場合は、HTTP サーバーがワーカー・ノードにバインドする必要があるポートを入力します。 このポートは、クラスター内のすべてのワーカー・ノードの IP で公開されている必要があります。 Autorecovery がサーバーを検査するためには、すべてのノードで一定のポート番号を使用する必要があります。 カスタム・サーバーをクラスターにデプロイする場合は、[DaemonSets ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用します。</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>検査タイプが <code>HTTP</code> である場合は、検査で返されることが予期される HTTP サーバー状況を入力します。 例えば、値 200 は、サーバーからの応答として <code>OK</code> を予期していることを示します。</td>
   </tr>
   <tr>
   <td><code>Route</code></td>
   <td>検査タイプが <code>HTTP</code> である場合は、HTTP サーバーから要求されたパスを入力します。 この値は通常、すべてのワーカー・ノードで実行されているサーバーのメトリック・パスです。</td>
   </tr>
   <tr>
   <td><code>Enabled</code></td>
   <td>検査を有効にするには <code>true</code>、検査を無効にするには <code>false</code> を入力します。</td>
   </tr>
   <tr>
   <td><code>Namespace</code></td>
   <td> オプション: ある名前空間内のポッドのみを検査するように <code>checkpod.json</code> を制限するには、<code>Namespace</code> フィールドを追加してその名前空間を入力します。</td>
   </tr>
   </tbody>
   </table>

3. クラスター内に構成マップを作成します。

    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

3. 適切な検査を実行して、`kube-system` 名前空間内に `ibm-worker-recovery-checks` という名前の構成マップが作成されていることを確認します。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. `ibm-worker-recovery` Helm チャートをインストールして、クラスターに Autorecovery をデプロイします。

    ```
    helm install --name ibm-worker-recovery ibm/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

5. 数分後に、次のコマンドの出力にある `Events` セクションを確認して、Autorecovery のデプロイメントのアクティビティーを確認できます。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

6. Autorecovery デプロイメントでアクティビティーが表示されない場合は、Autorecovery チャート定義に含まれているテストを実行して、Helm デプロイメントを確認することができます。

    ```
    helm test ibm-worker-recovery
    ```
    {: pre}
