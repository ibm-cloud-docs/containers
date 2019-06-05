---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-18"

keywords: kubernetes, iks, logmet, logs, metrics

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



# ロギングとモニタリング
{: #health}

{{site.data.keyword.containerlong}} でロギングとモニタリングをセットアップすると、問題のトラブルシューティングや、Kubernetes クラスターとアプリの正常性とパフォーマンスの改善に役立ちます。
{: shortdesc}

継続的なモニタリングとロギングは、クラスターへの攻撃を検出し、問題が発生したときに問題をトラブルシューティングするために重要です。 クラスターを継続的にモニターすることによって、クラスターの容量、およびアプリで使用可能なリソースの可用性をよく把握することができます。 この情報があれば、アプリのダウン時間の発生を防ぐために準備できます。 **注**: ロギングとモニタリングを構成するには、{{site.data.keyword.containerlong_notm}} で標準クラスターを使用する必要があります。



## ロギング・ソリューションの選択
{: #logging_overview}

デフォルトでは、{{site.data.keyword.containerlong_notm}} クラスター・コンポーネント (ワーカー・ノード、コンテナー、アプリケーション、永続ストレージ、Ingress アプリケーション・ロード・バランサー、Kubernetes API、`kube-system` 名前空間) のすべてのログは、ローカルで生成され、書き込まれます。 これらのログを収集し、転送して表示するために提供されているロギング・ソリューションが複数あります。
{: shortdesc}

ロギング・ソリューションは、ログを収集するクラスター・コンポーネントに応じて選択できます。 一般的には、分析機能やインターフェース機能に基づいて好みのロギング・サービス ({{site.data.keyword.loganalysisfull}}、{{site.data.keyword.la_full}}、サード・パーティー・サービスなど) を選択します。 それから、{{site.data.keyword.cloudaccesstrailfull}} を使用して、クラスター内のユーザー・アクティビティーを監査したり、クラスターのマスター・ログを {{site.data.keyword.cos_full}} にバックアップしたりします。 **注**: ロギングを構成するには、標準 Kubernetes クラスターを使用する必要があります。

<dl>

<dt>{{site.data.keyword.la_full_notm}}</dt>
<dd>サード・パーティー・サービスとして LogDNA をクラスターにデプロイして、ポッド・コンテナーのログを管理します。 {{site.data.keyword.la_full_notm}} を使用するには、クラスター内のすべてのワーカー・ノードにロギング・エージェントをデプロイする必要があります。 このエージェントは、`kube-system` などのすべての名前空間から、ポッドの `/var/log` ディレクトリーに保管されている拡張子のないファイルと拡張子が `*.log` のログを収集します。 そして、それらのログを {{site.data.keyword.la_full_notm}} サービスに転送します。 このサービスについて詳しくは、[{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about) の資料を参照してください。 始めに、[{{site.data.keyword.loganalysisfull_notm}} with LogDNA による Kubernetes クラスター・ログの管理](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube)を参照してください。</dd>

<dt>Fluentd と {{site.data.keyword.loganalysisfull_notm}} または syslog</dt>
<dd>クラスター・コンポーネントのログの収集、転送、表示のために、Fluentd を使用してロギング構成を作成できます。 ロギング構成を作成すると、[Fluentd ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.fluentd.org/) クラスター・アドオンが、指定されたソースのパスからログを収集します。 その後、Fluentd がそのログを {{site.data.keyword.loganalysisfull_notm}} または外部 syslog サーバーに転送します。

<ul><li><strong>{{site.data.keyword.loganalysisfull_notm}}</strong>: [{{site.data.keyword.loganalysisshort}}](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_analysis_ov) を使用すると、ログの収集、保存、検索の機能を拡張できます。 ソースのログを {{site.data.keyword.loganalysisshort_notm}} に転送するロギング構成を作成すると、Kibana ダッシュボードでログを表示できるようになります。<p class="deprecated">{{site.data.keyword.loganalysisfull_notm}} は非推奨になりました。2019 年 4 月 30 日をもって、新しい {{site.data.keyword.loganalysisshort_notm}} インスタンスをプロビジョンできなくなり、すべてのライト・プラン・インスタンスは削除されます。既存のプレミアム・プラン・インスタンスは 2019 年 9 月 30 日までサポートされます。クラスターのログ収集を継続するには、Fluentd によって収集されたログを外部 syslog サーバーに転送するか、{{site.data.keyword.la_full_notm}} をセットアップしてください。</p></li>

<li><strong>外部 syslog サーバー</strong>: syslog プロトコルを受け入れる外部サーバーをセットアップします。 その後、ログをその外部サーバーに転送するロギング構成をクラスター内のソースに対して作成できます。</li></ul>

始めに、[クラスターおよびアプリのログ転送について](#logging)を参照してください。
</dd>

<dt>{{site.data.keyword.cloudaccesstrailfull_notm}}</dt>
<dd>クラスター内でユーザーによって開始された管理アクティビティーをモニターするには、監査ログを収集して {{site.data.keyword.cloudaccesstrailfull_notm}} に転送します。 クラスターでは、2 種類の {{site.data.keyword.cloudaccesstrailshort}} イベントが生成されます。

<ul><li>クラスター管理イベントは自動的に生成され、{{site.data.keyword.cloudaccesstrailshort}} に転送されます。</li>

<li>Kubernetes API サーバー監査イベントは自動的に生成されますが、そのログを Fluentd で {{site.data.keyword.cloudaccesstrailshort}} に転送するには、[ロギング構成を作成](#api_forward)する必要があります。</li></ul>

追跡できる {{site.data.keyword.containerlong_notm}} イベントのタイプについて詳しくは、[Activity Tracker イベント](/docs/containers?topic=containers-at_events)を参照してください。 このサービスについて詳しくは、[Activity Tracker](/docs/services/cloud-activity-tracker?topic=cloud-activity-tracker-getting-started-with-cla) の資料を参照してください。
</dd>

<dt>{{site.data.keyword.cos_full_notm}}</dt>
<dd>クラスターの Kubernetes マスターのログを収集し、転送して表示するために、任意の時点のマスター・ログのスナップショットを取得して {{site.data.keyword.cos_full_notm}} バケット内に収集することができます。 このスナップショットには、ポッドのスケジューリング、デプロイメント、RBAC ポリシーなどの、API サーバー経由で送信されるすべてのものが含まれます。 始めに、[マスター・ログの収集](#collect_master)を参照してください。</dd>

<dt>サード・パーティー・サービス</dt>
<dd>特別な要件がある場合は、独自のロギング・ソリューションをセットアップできます。 クラスターに追加できるサード・パーティー・ロギング・サービスを[ロギングとモニタリングの統合](/docs/containers?topic=containers-supported_integrations#health_services)で確認してください。 Kubernetes バージョン 1.11 以降を実行するクラスターでは、`/var/log/pods/` パスからコンテナー・ログを収集できます。 Kubernetes バージョン 1.10 以前を実行するクラスターでは、`/var/lib/docker/containers/` パスからコンテナー・ログを収集できます。</dd>

</dl>

## クラスターとアプリのログの syslog への転送について
{: #logging}

デフォルトでは、ログはクラスター内の [Fluentd ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.fluentd.org/) アドオンによって収集されます。 クラスター内のソース (コンテナーなど) に対してロギング構成を作成すると、Fluentd によってそのソースのパスから収集されたログが、{{site.data.keyword.loganalysisshort_notm}} または外部 syslog サーバーに転送されます。 ソースからロギング・サービスの取り込みポートへのトラフィックは暗号化されます。
{: shortdesc}

{{site.data.keyword.loganalysisfull_notm}} は非推奨になりました。2019 年 4 月 30 日をもって、新しい {{site.data.keyword.loganalysisshort_notm}} インスタンスをプロビジョンできなくなり、すべてのライト・プラン・インスタンスは削除されます。既存のプレミアム・プラン・インスタンスは 2019 年 9 月 30 日までサポートされます。クラスターのログ収集を継続するには、Fluentd によって収集されたログを外部 syslog サーバーに転送するか、{{site.data.keyword.la_full_notm}} をセットアップしてください。
{: deprecated}

**ログ転送を構成できるソースは何ですか?**

ロギングを構成できるソースの場所は、次の図のとおりです。

<img src="images/log_sources.png" width="600" alt="クラスター内のログ・ソース" style="width:600px; border-style: none"/>

1. `ワーカー`: ユーザーがワーカー・ノードに指定したインフラストラクチャー構成に固有の情報。 ワーカー・ログは syslog に取り込まれ、オペレーティング・システムのイベントが含まれます。 `auth.log` には、OS に対して行われた認証要求に関する情報が含まれます。</br>**パス**:
    * `/var/log/syslog`
    * `/var/log/auth.log`

2. `container`: 実行中のコンテナーによってログに記録される情報。</br>**Paths**: `STDOUT` または `STDERR` に出力される任意の情報。

3. `アプリケーション`: アプリケーション・レベルで発生するイベントに関する情報。 これは、ログインの成功、ストレージに関する警告、アプリ・レベルで実行できるその他の操作などのイベントが発生したという通知である可能性があります。</br>**パス**: ログの転送先にするパスを設定できます。 ただし、ログを送信するには、ロギング構成で絶対パスを使用する必要があります。そうしないとログは読み取られません。 パスがワーカー・ノードにマウントされている場合は、シンボリック・リンクが作成されている可能性があります。 例: 指定されたパスが `/usr/local/spark/work/app-0546/0/stderr` であるのに、実際にはログが `/usr/local/spark-1.0-hadoop-1.2/work/app-0546/0/stderr` に送信されている場合、ログは読み取れません。

4. `ストレージ`: クラスター内にセットアップされた永続ストレージに関する情報。 ストレージ・ログは、DevOps パイプラインおよび製品リリースの一部として問題判別ダッシュボードおよびアラートをセットアップするのに役立ちます。 `注**: パス **/var/log/kubelet.log` および `/var/log/syslog` にもストレージ・ログが含まれていますが、これらのパスにあるログは `kubernetes` および `worker` ログ・ソースによって収集されます。</br>**パス**:
    * `/var/log/ibmc-s3fs.log`
    * `/var/log/ibmc-block.log`

  **ポッド**:
    * `portworx-***`
    * `ibmcloud-block-storage-attacher-***`
    * `ibmcloud-block-storage-driver-***`
    * `ibmcloud-block-storage-plugin-***`
    * `ibmcloud-object-storage-plugin-***`

5. `kubernetes`: ワーカー・ノードの kube-system 名前空間内で発生する kubelet、kube-proxy、その他の Kubernetes イベントからの情報。</br>**パス**:
    * `/var/log/kubelet.log`
    * `/var/log/kube-proxy.log`
    * `/var/log/event-exporter/1..log`

6. `kube-audit`: Kubernetes API サーバーに送信されるクラスター関連アクションに関する情報。時間、ユーザー、および影響を受けるリソースを含みます。

7. `ingress`: Ingress ALB を介してクラスターに伝送されるネットワーク・トラフィックに関する情報。</br>**パス**:
    * `/var/log/alb/ids/*.log`
    * `/var/log/alb/ids/*.err`
    * `/var/log/alb/customerlogs/*.log`
    * `/var/log/alb/customerlogs/*.err`

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
      <td>ログの転送元になるソース。 指定可能な値は、<code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code>、<code>storage</code>、および <code>kube-audit</code> です。 この引数では、構成を適用するログ・ソースのコンマ区切りのリストを使用できます。 ログ・ソースを指定しない場合は、<code>container</code> と <code>ingress</code> のログ・ソースのロギング構成が作成されます。</td>
    </tr>
    <tr>
      <td><code><em>--type</em></code></td>
      <td>ログの転送先。 オプションは、ログを {{site.data.keyword.loganalysisshort_notm}} に転送する <code>ibm</code> と、ログを外部サーバーに転送する <code>syslog</code> です。 <p class="deprecated">{{site.data.keyword.loganalysisfull_notm}} は非推奨になりました。既存のプレミアム・プラン・インスタンスは 2019 年 9 月 30 日までサポートされます。<code>--type syslog</code> を使用してログを外部 syslog サーバーに転送してください。</td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>オプション: ログの転送元になる Kubernetes 名前空間。 ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。 この値は、<code>container</code> ログ・ソースについてのみ有効です。 名前空間を指定しないと、クラスター内のすべての名前空間でこの構成が使用されます。</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>{{site.data.keyword.loganalysisshort_notm}} の場合は、[取り込み URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls)を使用します。 取り込み URL を指定しない場合、クラスターを作成した地域のエンドポイントが使用されます。</p>
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
      <td>アプリがログを書き込むコンテナー上のパス。 ソース・タイプが <code>application</code> のログを転送するには、パスを指定する必要があります。 複数のパスを指定するには、コンマ区切りリストを使用します。 例: <code>/var/log/myApp1/*,/var/log/myApp2/*</code></td>
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

**Fluentd は自分で更新し続ける必要がありますか?**

ロギングまたはフィルター構成を変更するには、Fluentd ロギング・アドオンが最新バージョンである必要があります。 デフォルトでは、このアドオンに対する自動更新が有効になっています。 自動更新を使用不可にするには、[クラスターのアドオンの更新: ロギング用の Fluentd](/docs/containers?topic=containers-update#logging-up)を参照してください。

**クラスター内の 1 つのソースから、一部のログだけを転送し、その他のログは転送しないようにすることは可能ですか?**

はい。 例えば、特にログ量の多いポッドがある場合に、そのポッドのログでログ・ストレージ・スペースが占有されないようにして、他のポッドのログを転送したいことがあります。 特定のポッドのログを転送しないようにする方法については、[ログのフィルタリング](#filter-logs)を参照してください。

**1 つのクラスターで複数のチームが作業しています。 チームごとにログを分離するにはどうしたらよいですか?**

名前空間ごとに別の Cloud Foundry スペースにコンテナー・ログを転送できます。 名前空間ごとに、`コンテナー`・ログ・ソースに対してログ転送構成を作成してください。 その構成を適用するチームの名前空間を `--namespace` フラグで指定し、ログの転送先にするチームのスペースを `--space` フラグで指定します。 そのスペース内の Cloud Foundry 組織を `--org` フラグで指定することもできます。

<br />


## クラスターとアプリのログの syslog への転送
{: #configuring}

コンソールまたは CLI を使用して、{{site.data.keyword.containerlong_notm}} 標準クラスターのロギングを構成できます。
{: shortdesc}

{{site.data.keyword.loganalysisfull_notm}} は非推奨になりました。2019 年 4 月 30 日をもって、新しい {{site.data.keyword.loganalysisshort_notm}} インスタンスをプロビジョンできなくなり、すべてのライト・プラン・インスタンスは削除されます。既存のプレミアム・プラン・インスタンスは 2019 年 9 月 30 日までサポートされます。クラスターのログ収集を継続するには、Fluentd によって収集されたログを外部 syslog サーバーに転送するか、{{site.data.keyword.la_full_notm}} をセットアップしてください。
{: deprecated}

### {{site.data.keyword.Bluemix_notm}} コンソールを使用したログ転送の有効化
{: #enable-forwarding-ui}

{{site.data.keyword.containerlong_notm}} ダッシュボードでログ転送を構成できます。 この処理が完了するまで数分かかることがあるため、すぐにログが表示されない場合は、数分待ってから再度確認してください。
{: shortdesc}

アカウント・レベルで特定のコンテナー名前空間用またはアプリ・ロギング用の構成を作成するには、CLI を使用します。
{: tip}

始める前に、使用する標準クラスターを[作成](/docs/containers?topic=containers-clusters#clusters)するか、決定します。

1. [{{site.data.keyword.Bluemix_notm}} コンソール](https://cloud.ibm.com/kubernetes/clusters)にログインして、**「Kubernetes」>「クラスター」**にナビゲートします。
2. 標準クラスターを選択し、**「概要」**タブの**「ログ」**フィールドで**「有効」**をクリックします。
3. ログの転送元の **Cloud Foundry 組織**と**スペース**を選択します。 ダッシュボードでログ転送を構成すると、クラスターのデフォルトの {{site.data.keyword.loganalysisshort_notm}} エンドポイントにログが送信されます。 外部サーバーまたは別の {{site.data.keyword.loganalysisshort_notm}} エンドポイントにログを転送するには、CLI を使用してロギングを構成します。
4. ログの転送元の**ログ・ソース**を選択します。
5. **「作成」**をクリックします。

</br>
</br>

### CLI を使用したログ転送の有効化
{: #enable-forwarding}

クラスター・ロギングの構成を作成できます。 フラグを使用することによって、異なるロギング・オプションを区別できます。
{: shortdesc}

始める前に、使用する標準クラスターを[作成](/docs/containers?topic=containers-clusters#clusters)するか、決定します。

**`udp` または `tcp` プロトコルを介してユーザー自身のサーバーにログを転送する**

1. [**エディター**または**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)があることを確認してください。

2. ログ・ソースがあるクラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. ログを syslog に転送するには、以下の 2 つの方法のいずれかで、syslog プロトコルを受け入れるサーバーをセットアップします。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。 プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。

  * コンテナーから syslog を実行します。 例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。 このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。

  syslog 接頭部を削除することによって、有効な JSON としてログを表示できます。 これを行うには、rsyslog サーバーが稼働している環境の <code>etc/rsyslog.conf</code> ファイルの先頭に次のコードを追加します。 <code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

4. ログ転送構成を作成します。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br></br>

**`tls` プロトコルを介してユーザー自身のサーバーにログを転送する**

以下のステップは、一般的な説明です。 実稼働環境でコンテナーを使用する前に、必要なセキュリティー条件を満たしていることを確認してください。
{: tip}

1. 以下の [{{site.data.keyword.Bluemix_notm}} IAM 役割](/docs/containers?topic=containers-users#platform)があることを確認します。
    * クラスターに対する**エディター**または**管理者**のプラットフォーム役割
    * `kube-system` 名前空間に対する**ライター**または**管理者**のサービス役割

2. ログ・ソースがあるクラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. 以下の 2 つの方法のいずれかで、syslog プロトコルを受け入れるサーバーをセットアップします。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。 プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。

  * コンテナーから syslog を実行します。 例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。 このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。 関連する認証局証明書およびサーバー・サイド証明書を注入し、`syslog.conf` を更新して、サーバー上で `tls` を有効にする必要があります。

4. 認証局証明書を `ca-cert` という名前のファイルに保存します。この名前のとおりでなければなりません。

5. `ca-cert` ファイル用のシークレットを `kube-system` 名前空間に作成します。 ロギング構成を作成するときは、`--ca-cert` フラグにこのシークレット名を使用します。
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

6. ログ転送構成を作成します。
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br></br>

**{{site.data.keyword.loganalysisfull_notm}} へのログの転送**

{{site.data.keyword.loganalysisfull_notm}} は非推奨になりました。2019 年 4 月 30 日をもって、新しい {{site.data.keyword.loganalysisshort_notm}} インスタンスをプロビジョンできなくなり、すべてのライト・プラン・インスタンスは削除されます。既存のプレミアム・プラン・インスタンスは 2019 年 9 月 30 日までサポートされます。クラスターのログ収集を継続するには、Fluentd によって収集されたログを外部 syslog サーバーに転送するか、{{site.data.keyword.la_full_notm}} をセットアップしてください。
{: deprecated}

1. 権限を確認してください。
    1. [**エディター**または**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)があることを確認してください。
    2. クラスターの作成時にスペースを指定した場合は、作成ユーザーと {{site.data.keyword.containerlong_notm}} API 鍵所有者の両方に、そのスペースにおける[**開発者** の Cloud Foundry 役割](/docs/iam?topic=iam-mngcf)が必要です。
      * {{site.data.keyword.containerlong_notm}} API 鍵所有者が不明な場合は、以下のコマンドを実行します。
          ```
          ibmcloud ks api-key-info --cluster <cluster_name>
          ```
          {: pre}
      * アクセス権を変更した場合は、以下のコマンドを実行して変更をすぐに適用できます。
          ```
          ibmcloud ks logging-config-refresh --cluster <cluster_name>
          ```
          {: pre}

2.  ログ・ソースがある標準クラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

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
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

コンテナー内で実行するアプリを、STDOUT または STDERR にログを書き込むように構成できない場合は、アプリ・ログ・ファイルからログを転送するログ構成を作成できます。
{: tip}

</br></br>

### ログ転送の確認
{: verify-logging}

以下の 2 とおりのいずれかの方法で、構成が正しくセットアップされていることを確認できます。

* クラスター内のすべてのロギング構成をリスト表示する場合には、以下のようにします。
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

* 1 つのタイプのログ・ソースのロギング構成をリストする場合には、以下のようにします。
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br></br>

### ログ転送の更新
{: #updating-forwarding}

既に作成したロギング構成を更新することができます。
{: shortdesc}

1. ログ転送構成を更新します。
    ```
    ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### ログ転送の停止
{: #log_sources_delete}

クラスターの 1 つまたはすべてのロギング構成によるログの転送を停止できます。
{: shortdesc}

1. ログ・ソースがあるクラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

2. ロギング構成を削除します。
  <ul>
  <li>1 つのロギング構成を削除するには、以下のようにします。</br>
    <pre><code>ibmcloud ks logging-config-rm --cluster &lt;cluster_name_or_ID&gt; --id &lt;log_config_ID&gt;</pre></code></li>
  <li>すべてのロギング構成を削除するには、以下のようにします。</br>
    <pre><code>ibmcloud ks logging-config-rm --cluster <my_cluster> --all</pre></code></li>
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

デフォルト値を使用して構成ファイルを作成した場合は、クラスターが作成されたアカウント (または組織とスペース) にログがあります。 構成ファイルに組織とスペースを指定した場合は、そのスペースにログがあります。 ロギングについて詳しくは、[{{site.data.keyword.containerlong_notm}} のロギング](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes)を参照してください。

Kibana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターのログ転送を構成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。
- 米国南部および米国東部: `https://logging.ng.bluemix.net`
- 英国南部: `https://logging.eu-gb.bluemix.net`
- EU 中央: `https://logging.eu-fra.bluemix.net`
- 南アジア太平洋地域と北アジア太平洋地域: `https://logging.au-syd.bluemix.net`

ログの表示について詳しくは、[Web ブラウザーから Kibana へのナビゲート](/docs/services/CloudLogAnalysis/kibana?topic=cloudloganalysis-launch#launch_Kibana_from_browser)を参照してください。

</br>

**コンテナー・ログ**

組み込みのコンテナー・ランタイム・ロギング機能を活用して、標準の STDOUT と STDERR 出力ストリームでアクティビティーを確認することができます。 詳しくは、[Kubernetes クラスターで実行されるコンテナーのコンテナー・ログの表示](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes)を参照してください。

<br />


## syslog に転送されるログのフィルタリング
{: #filter-logs}

一定期間における特定のログをフィルターで除外して、転送するログを選択することができます。 フラグを使用することによって、異なるフィルター操作オプションを区別できます。
{: shortdesc}

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
  ibmcloud ks logging-filter-get --cluster <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. 作成したログ・フィルターを更新します。
  ```
  ibmcloud ks logging-filter-update --cluster <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. 作成したログ・フィルターを削除します。

  ```
  ibmcloud ks logging-filter-rm --cluster <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## {{site.data.keyword.cloudaccesstrailfull_notm}} または syslog への Kubernetes API 監査ログの転送
{: #api_forward}

Kubernetes は、Kubernetes API サーバーを通るすべてのイベントを自動的に監査します。 {{site.data.keyword.cloudaccesstrailfull_notm}} または外部サーバーにイベントを転送できます。
{: shortdesc}

Kubernetes 監査ログについて詳しくは、Kubernetes 資料の<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">監査トピック <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。

* 現在は、このロギング構成のすべてのクラスターで、デフォルトの監査ポリシーが使用されます。
* 現在、フィルターはサポートされていません。
* クラスターごとに 1 つの `kube-audit` 構成しか設定できませんが、ロギング構成と Webhook を作成することで、{{site.data.keyword.cloudaccesstrailshort}} と外部サーバーにログを転送できます。
* クラスターに対する[**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)が必要です。

### {{site.data.keyword.cloudaccesstrailfull_notm}} への監査ログの転送
{: #audit_enable_loganalysis}

Kubernetes API サーバーの監査ログを {{site.data.keyword.cloudaccesstrailfull_notm}} に転送できます。
{: shortdesc}

**始める前に**

1. 権限を確認してください。 クラスターの作成時にスペースを指定した場合は、アカウント所有者と {{site.data.keyword.containerlong_notm}} 鍵所有者の両方に、そのスペース内の管理者権限、開発者権限、または監査員権限が必要です。

2. API サーバー監査ログの収集元にするクラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

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
          <td>ログの転送先となるエンドポイント。 [取り込み URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls) を指定しない場合、クラスターを作成した地域のエンドポイントが使用されます。</td>
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
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    コマンドと出力の例:
    ```
    ibmcloud ks logging-config-get --cluster myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. オプション: 監査ログの転送を停止するには、[構成を削除](#log_sources_delete)します。

### 外部 syslog サーバーへの監査ログの転送
{: #audit_enable}

**始める前に**

1. ログを転送できるリモート・ロギング・サーバーをセットアップします。 例えば、[Logstash と Kubernetes を使用して ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend)、監査イベントを収集できます。

2. API サーバー監査ログの収集元にするクラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

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
    ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. オプション: 監査ログの転送を停止するには、構成を無効にします。
    1. API サーバー監査ログの収集を停止するクラスターの場合: [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2. クラスターの API サーバーの Web フック・バックエンド構成を無効にします。

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. Kubernetes マスターを再始動して、構成の更新を適用します。

        ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
        {: pre}

<br />


## {{site.data.keyword.cos_full_notm}} バケット内のマスター・ログの収集
{: #collect_master}

{{site.data.keyword.containerlong_notm}} の使用時に、任意の時点でマスター・ログのスナップショットを取得して、{{site.data.keyword.cos_full_notm}} バケット内に収集できます。 このスナップショットには、ポッドのスケジューリング、デプロイメント、RBAC ポリシーなどの、API サーバー経由で送信されるすべてのものが含まれます。
{: shortdesc}

Kubernetes API サーバー・ログは自動的にストリーミングされるので、自動的に削除されて新しいログのための余地が設けられます。 特定の時点のログのスナップショットを保持すると、問題のトラブルシューティング、使用状況の違いの調査、パターンの検出を改善できるので、アプリケーションの安全性を高めて保守するために役立ちます。

**始める前に**

* {{site.data.keyword.Bluemix_notm}} カタログから {{site.data.keyword.cos_short}} の[インスタンスをプロビジョンします](/docs/services/cloud-object-storage/basics?topic=cloud-object-storage-gs-dev)。
* クラスターに対する[**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)があることを確認してください。

**スナップショットの作成**

1. [この入門チュートリアル](/docs/services/cloud-object-storage?topic=cloud-object-storage-getting-started#gs-create-buckets)に従って、{{site.data.keyword.Bluemix_notm}} コンソールを使用して Object Storage バケットを作成します。

2. 作成したバケット内で [HMAC サービス資格情報](/docs/services/cloud-object-storage/iam?topic=cloud-object-storage-service-credentials)を生成します。
  1. {{site.data.keyword.cos_short}} ダッシュボードの**「サービス資格情報」**タブで、**「新規資格情報」**をクリックします。
  2. HMAC 資格情報に`ライター`のサービス役割を付与します。
  3. **「インラインの構成パラメーターの追加」**フィールドで `{"HMAC":true}` を指定します。

3. CLI を使用して、マスター・ログのスナップショットに関する要求を行います。

  ```
  ibmcloud ks logging-collect --cluster <cluster name or ID>  --type <type_of_log_to_collect> --cos-bucket <COS_bucket_name> --cos-endpoint <location_of_COS_bucket> --hmac-key-id <HMAC_access_key_ID> --hmac-key <HMAC_access_key> --type <log_type>
  ```
  {: pre}

  コマンドと応答の例:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

4. 要求の状況を確認します。 スナップショットが完了するまでには多少時間を要することがありますが、要求が正常に完了するかどうかを確認できます。 マスター・ログが含まれるファイルの名前が応答の中で見つかります。{{site.data.keyword.Bluemix_notm}} コンソールを使用してこのファイルをダウンロードできます。

  ```
  ibmcloud ks logging-collect-status --cluster <cluster_name_or_ID>
  ```
  {: pre}

  出力例:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## モニタリング・ソリューションの選択
{: #view_metrics}

メトリックは、クラスターの正常性とパフォーマンスをモニターするのに役立ちます。 Kubernetes とコンテナー・ランタイムの標準機能を使用して、クラスターとアプリの正常性をモニターできます。 **注**: モニタリングは標準クラスターでのみサポートされています。
{:shortdesc}

**IBM は個々の利用者のクラスターをモニターしますか?**

Kubernetes マスターはすべて IBM によって継続的にモニターされます。 {{site.data.keyword.containerlong_notm}} は、Kubernetes マスターがデプロイされたすべてのノードにおいて、Kubernetes および OS 固有のセキュリティー修正で検出された脆弱性を自動的にスキャンします。 脆弱性が見つかった場合、{{site.data.keyword.containerlong_notm}} はユーザーに代わって自動的に修正を適用し、脆弱性を解決して、マスター・ノードが確実に保護されるようにします。 残りのクラスター・コンポーネントのログのモニターと分析は、お客様が行う必要があります。

メトリック・サービスの使用時に競合を回避するには、リソース・グループと地域の間でクラスターの名前が固有であることを確認してください。
{: tip}

<dl>
  <dt>{{site.data.keyword.Bluemix_notm}} のクラスター詳細ページ</dt>
    <dd>{{site.data.keyword.containerlong_notm}} には、クラスターの正常性と能力、そしてクラスター・リソースの使用方法に関する情報が表示されます。 このコンソールを使用して、クラスターのスケールアウト、永続ストレージの作業、{{site.data.keyword.Bluemix_notm}} サービス・バインディングによるクラスターへの機能の追加を行うことができます。 クラスターの詳細ページを表示するには、**{{site.data.keyword.Bluemix_notm}} の「ダッシュボード」**に移動して、クラスターを選択します。</dd>
  <dt>Kubernetes ダッシュボード</dt>
    <dd>Kubernetes ダッシュボードは、ワーカー・ノードの正常性の確認、Kubernetes リソースの検索、コンテナー化アプリのデプロイ、ロギングとモニタリング情報を使用したアプリのトラブルシューティングを行える管理 Web インターフェースです。 Kubernetes ダッシュボードにアクセスする方法について詳しくは、[{{site.data.keyword.containerlong_notm}} での Kubernetes ダッシュボードの起動](/docs/containers?topic=containers-app#cli_dashboard)を参照してください。</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>標準クラスターのメトリックは、Kubernetes クラスターを作成したときにログインした {{site.data.keyword.Bluemix_notm}} アカウントにあります。 クラスターの作成時に {{site.data.keyword.Bluemix_notm}} スペースを指定した場合、メトリックはそのスペースに配置されます。 コンテナーのメトリックはクラスターにデプロイされたすべてのコンテナーについて自動的に収集されます。 これらのメトリックが送信され、Grafana で使用できるようになります。 メトリックについて詳しくは、[{{site.data.keyword.containerlong_notm}}　のモニター](/docs/services/cloud-monitoring/containers?topic=cloud-monitoring-monitoring_bmx_containers_ov#monitoring_bmx_containers_ov)を参照してください。</p>
    <p>Grafana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。</p>
    <table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバー・ゾーン、2 列目は対応する IP アドレスです。">
      <caption>モニター・トラフィック用に開く IP アドレス</caption>
            <thead>
            <th>{{site.data.keyword.containerlong_notm}} 地域</th>
            <th>モニタリング・アドレス</th>
            <th>モニタリング・サブネット</th>
            </thead>
          <tbody>
            <tr>
             <td>中欧</td>
             <td><code>metrics.eu-de.bluemix.net</code></td>
             <td><code>158.177.65.80/30</code></td>
            </tr>
            <tr>
             <td>英国南部</td>
             <td><code>metrics.eu-gb.bluemix.net</code></td>
             <td><code>169.50.196.136/29</code></td>
            </tr>
            <tr>
              <td>米国東部、米国南部、北アジア太平洋地域、南アジア太平洋地域</td>
              <td><code>metrics.ng.bluemix.net</code></td>
              <td><code>169.47.204.128/29</code></td>
             </tr>
            </tbody>
          </table> </dd>
  <dt>{{site.data.keyword.mon_full_notm}}</dt>
  <dd>Sysdig をサード・パーティー・サービスとしてワーカー・ノードにデプロイし、メトリックを {{site.data.keyword.monitoringlong}} に転送することで、アプリのパフォーマンスと正常性を可視化して運用することができます。 詳しくは、[Kubernetes クラスターにデプロイされたアプリのメトリックの分析方法](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster)を参照してください。</dd>
</dl>

### その他のヘルス・モニター・ツール
{: #health_tools}

他のツールを構成してモニター機能を追加することができます。
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus は、Kubernetes のために設計されたモニタリング、ロギング、アラートのためのオープン・ソースのツールです。 このツールは、Kubernetes のロギング情報に基づいてクラスター、ワーカー・ノード、デプロイメントの正常性に関する詳細情報を取得します。 セットアップ情報については、[CoreOS の説明 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus) を参照してください。</dd>
</dl>

<br />


## Autorecovery を使用したワーカー・ノードの正常性モニタリングの構成
{: #autorecovery}

Autorecovery システムは、さまざまな検査機能を使用してワーカー・ノードの正常性状況を照会します。 Autorecovery は、構成された検査に基づいて正常でないワーカー・ノードを検出すると、ワーカー・ノードの OS の再ロードのような修正アクションをトリガーします。 修正アクションは、一度に 1 つのワーカー・ノードに対してのみ実行されます。 1 つのワーカー・ノードの修正アクションが正常に完了してからでないと、別のワーカー・ノードの修正アクションは実行されません。 詳しくは、[Autorecovery に関するブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/) を参照してください。
{: shortdesc}</br> </br>

Autorecovery が正常に機能するためには、1 つ以上の正常なノードが必要です。 Autorecovery でのアクティブな検査は、複数のワーカー・ノードが存在するクラスターでのみ構成します。
{: note}

開始前に、以下のことを行います。
- 以下の [{{site.data.keyword.Bluemix_notm}} IAM 役割](/docs/containers?topic=containers-users#platform)があることを確認します。
    - クラスターに対する**管理者**のプラットフォーム役割
    - `kube-system` 名前空間に対する**ライター**または**管理者**のサービス役割
- [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

自動リカバリーを構成するには、以下のようにします。

1.  [手順に従って](/docs/containers?topic=containers-helm#public_helm_install)、ローカル・マシンに Helm クライアントをインストールし、サービス・アカウントで Helm サーバー (tiller) をインストールし、{{site.data.keyword.Bluemix_notm}} Helm リポジトリーを追加します。

2.  tiller がサービス・アカウントでインストールされていることを確認します。
    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    出力例:
    ```
    NAME                                 SECRETS   AGE
    tiller                               1         2m
    ```
    {: screen}

3. 検査を JSON 形式で定義する構成マップ・ファイルを作成します。 例えば、次の YAML ファイルでは、3 つの検査 (1 つの HTTP 検査と 2 つの Kubernetes API サーバー検査) を定義しています。 この 3 種類の検査とそれらの検査の個々の構成要素については、YAML ファイルの例に続く表を参照してください。
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
   <td>ワーカー・ノードで稼働している HTTP サーバーが正常かどうかを検査する HTTP 検査を定義します。 この検査を使用するには、[デーモン・セット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用して、クラスター内のすべてのワーカー・ノードに HTTP サーバーをデプロイする必要があります。 HTTP サーバーが正常かどうかを検証できるヘルス・チェックを、<code>/myhealth</code> パスで利用できるように実装する必要があります。 他のパスを定義するには、<strong>Route</strong> パラメーターを変更します。 HTTP サーバーが正常である場合は、<strong><code>ExpectedStatus</code></strong> で定義されている HTTP 応答コードを返す必要があります。 HTTP サーバーは、ワーカー・ノードのプライベート IP アドレスで listen するように構成する必要があります。 プライベート IP アドレスを調べるには、<code>kubectl get nodes</code> ノードを実行します。<br></br>
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
   <td>リソース・タイプが <code>POD</code> である場合は、[<strong><code>NotReady </code></strong> ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状態になることができるワーカー・ノード上のポッドのしきい値 (パーセンテージ) を入力します。 このパーセンテージは、ワーカー・ノードにスケジュールされているポッドの合計数に基づきます。 検査の結果、正常でないポッドのパーセンテージがしきい値を超えていることが判別されると、1 回の失敗としてカウントされます。</td>
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
   <td>検査タイプが <code>HTTP</code> である場合は、HTTP サーバーがワーカー・ノードにバインドする必要があるポートを入力します。 このポートは、クラスター内のすべてのワーカー・ノードの IP で公開されている必要があります。 Autorecovery がサーバーを検査するためには、すべてのノードで一定のポート番号を使用する必要があります。 カスタム・サーバーをクラスターにデプロイする場合は、[デーモン・セット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用します。</td>
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

4. クラスター内に構成マップを作成します。
    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

5. 適切な検査を実行して、`kube-system` 名前空間内に `ibm-worker-recovery-checks` という名前の構成マップが作成されていることを確認します。
    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

6. `ibm-worker-recovery` Helm チャートをインストールして、クラスターに Autorecovery をデプロイします。
    ```
    helm install --name ibm-worker-recovery iks-charts/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

7. 数分後に、次のコマンドの出力にある `Events` セクションを確認して、Autorecovery のデプロイメントのアクティビティーを確認できます。
    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

8. Autorecovery デプロイメントでアクティビティーが表示されない場合は、Autorecovery チャート定義に含まれているテストを実行して、Helm デプロイメントを確認することができます。
```
    helm test ibm-worker-recovery
    ```
    {: pre}




