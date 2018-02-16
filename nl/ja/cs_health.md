---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスターのロギングとモニタリング
{: #health}

クラスターとアプリの問題をトラブルシューティングするため、およびクラスターの正常性とパフォーマンスをモニターするために役立つように、クラスターのロギングとモニタリングを構成します。
{:shortdesc}

## クラスター・ロギングの構成
{: #logging}

処理や長期保管のためにログを特定の場所に送信することができます。{{site.data.keyword.containershort_notm}} の Kubernetes クラスターで、クラスターのログ転送を有効にしたり、ログの転送先を選択したりすることができます。 **注**: ログの転送は標準クラスターでのみサポートされています。
{:shortdesc}

コンテナー、アプリケーション、ワーカー・ノード、Kubernetes クラスター、Ingress コントローラーなどのログ・ソースのログを転送することができます。 それぞれのログ・ソースについては、以下の表を確認してください。

|ログ・ソース|特性|ログ・パス|
|----------|---------------|-----|
|`container`|Kubernetes クラスターで実行されるコンテナーのログ。|-|
|`application`|Kubernetes クラスターで実行される独自のアプリケーションのログ。|`/var/log/apps/**/*.log`、`/var/log/apps/**/*.err`|
|`worker`|Kubernetes クラスター内の仮想マシン・ワーカー・ノードのログ。|`/var/log/syslog`、`/var/log/auth.log`|
|`kubernetes`|Kubernetes システム構成要素のログ。|`/var/log/kubelet.log`、`/var/log/kube-proxy.log`|
|`ingress`|Ingress コントローラーによって管理される、Kubernetes クラスターに送信されるネットワーク・トラフィックを管理するアプリケーション・ロード・バランサーのログ。|`/var/log/alb/ids/*.log`、`/var/log/alb/ids/*.err`、`/var/log/alb/customerlogs/*.log`、`/var/log/alb/customerlogs/*.err`|
{: caption="ログ・ソースの特性" caption-side="top"}

## ログ転送の有効化
{: #log_sources_enable}

ログは {{site.data.keyword.loganalysislong_notm}} または外部の syslog サーバーに転送することができます。 あるログ・ソースから両方のログ・コレクター・サーバーにログを転送する場合は、2 つのロギング構成を作成する必要があります。 **注**: アプリケーションのログを転送する方法については、[アプリケーションのログ転送の有効化](#apps_enable)を参照してください。
{:shortdesc}

開始前に、以下のことを行います。

1. ログを外部 syslog サーバーに転送する場合は、次の 2 つの方法で syslog プロトコルを受け入れるサーバーをセットアップできます。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。 プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。
  * コンテナーから syslog を実行します。 例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。 このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。

コンテナー、ワーカー・ノード、Kubernetes システム構成要素、アプリケーション、または Ingress アプリケーション・ロード・バランサーのログ転送を有効にするには、以下のようにします。

1. ログ転送構成を作成します。

  * ログを {{site.data.keyword.loganalysislong_notm}} に転送する場合には、以下のようにします。

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>{{site.data.keyword.loganalysislong_notm}} ログ転送構成を作成するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td><em>&lt;my_log_source&gt;</em> をログ・ソースに置き換えます。 指定可能な値は <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> です。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td><em>&lt;kubernetes_namespace&gt;</em> を、ログの転送元になる Kubernetes 名前空間に置き換えます。ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。 この値はコンテナー・ログ・ソースについてのみ有効で、オプションです。 名前空間を指定しないと、クラスター内のすべての名前空間でこの構成が使用されます。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td><em>&lt;ingestion_URL&gt;</em> を {{site.data.keyword.loganalysisshort_notm}} 取り込み URL に置き換えます。 選択可能な取り込み URL のリストは、[ここを参照してください](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)。 取り込み URL を指定しない場合、クラスターが作成された地域のエンドポイントが使用されます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td><em>&lt;ingestion_port&gt;</em> を取り込みポートに置き換えます。 ポートを指定しないと、標準ポート <code>9091</code> が使用されます。</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td><em>&lt;cluster_space&gt;</em> を、ログの送信先となる Cloud Foundry スペースの名前に置き換えます。 スペースを指定しない場合、ログはアカウント・レベルに送信されます。</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td><em>&lt;cluster_org&gt;</em> を、このスペースが属する Cloud Foundry 組織の名前に置き換えます。 この値は、スペースを指定した場合には必須です。</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>ログを {{site.data.keyword.loganalysisshort_notm}} に送信するためのログ・タイプ。</td>
    </tr>
    </tbody></table>

  * ログを外部 syslog サーバーに転送する場合には、以下のようにします。

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>syslog ログ転送構成を作成するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td><em>&lt;my_log_source&gt;</em> をログ・ソースに置き換えます。 指定可能な値は <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> です。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td><em>&lt;kubernetes_namespace&gt;</em> を、ログの転送元になる Kubernetes 名前空間に置き換えます。ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。 この値はコンテナー・ログ・ソースについてのみ有効で、オプションです。 名前空間を指定しないと、クラスター内のすべての名前空間でこの構成が使用されます。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td><em>&lt;log_server_hostname&gt;</em> をログ・コレクター・サービスのホスト名または IP アドレスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em> をログ・コレクター・サーバーのポートに置き換えます。 ポートを指定しないと、標準ポート <code>514</code> が使用されます。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>ログを外部 syslog サーバーに送信するためのログ・タイプ。</td>
    </tr>
    </tbody></table>

2. ログ転送構成が作成されたことを確認します。

    * クラスター内のすべてのロギング構成をリスト表示する場合には、以下のようにします。
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      出力例:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 1 つのタイプのログ・ソースのロギング構成をリストする場合には、以下のようにします。
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      出力例:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}


### アプリケーションのログ転送の有効化
{: #apps_enable}

アプリケーションから取得されるログは、ホスト・ノード上の特定のディレクトリーに制約する必要があります。 これを行うには、マウント・パスを使用してコンテナーにホスト・パス・ボリュームをマウントします。 このマウント・パスは、アプリケーション・ログが送信されるコンテナーのディレクトリーとして機能します。 事前定義されたホスト・パス・ディレクトリー `/var/log/apps` は、ボリューム・マウントを作成すると自動的に作成されます。

アプリケーション・ログ転送の次の側面を確認します。
* ログは /var/log/apps パスから再帰的に読み込まれます。 つまり、/var/log/apps パスのサブディレクトリーにアプリケーション・ログを書き込むことができます。
* ファイル拡張子 `.log` または `.err` を持つアプリケーション・ログ・ファイルのみが転送されます。
* ログ転送を初めて有効にすると、アプリケーション・ログはヘッドから読み取られるのではなく、テールされます。 つまり、アプリケーション・ロギングが有効になる前に既に存在していたログの内容は読み取られません。 ログは、ロギングが有効になった時点から読み取られます。 ただし、ログ転送の初回有効化時以降は、ログは常に最後に中止された場所から取得されます。
* `/var/log/apps` ホスト・パス・ボリュームをコンテナーにマウントすると、コンテナーはすべてをこの同じディレクトリーに書き込みます。 つまり、コンテナーが同じファイル名に書き込みを行う場合は、ホスト上のまったく同じファイルに書き込みます。 これが意図しない動作である場合は、各コンテナーから取得するログ・ファイルに異なる名前を付けて、コンテナーが同じログ・ファイルを上書きしないようにすることができます。
* すべてのコンテナーが同じファイル名に書き込みを行うため、この方法で ReplicaSets のアプリケーション・ログを転送しないでください。 代わりに、アプリケーションのログを STDOUT と STDERR に書き込んで、コンテナー・ログとして取得することができます。 STDOUT と STDERR に書き込まれたアプリケーション・ログを転送するには、[ログ転送の有効化](cs_health.html#log_sources_enable)の手順に従います。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターに設定してください。

1. アプリケーションのポッドの `.yaml` 構成ファイルを開きます。

2. 次の `volumeMounts` と `volumes` を構成ファイルに追加します。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. ポッドにボリュームをマウントします。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. ログ転送構成を作成するには、[ログ転送の有効化](cs_health.html#log_sources_enable)の手順に従います。

<br />


## ログ転送構成の更新
{: #log_sources_update}

コンテナー、アプリケーション、ワーカー・ノード、Kubernetes システム構成要素、または Ingress アプリケーション・ロード・バランサーのロギング構成を更新できます。
{: shortdesc}

開始前に、以下のことを行います。

1. ログ・コレクター・サーバーを syslog に変更する場合は、次の 2 つの方法で syslog プロトコルを受け入れるサーバーをセットアップできます。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。 プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。
  * コンテナーから syslog を実行します。 例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。 このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。

ロギング構成の詳細を変更するには、以下のようにします。

1. ロギング構成を更新します。

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>ログ・ソースのログ転送構成を更新するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td><em>&lt;log_config_id&gt;</em> をログ・ソース構成の ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td><em>&lt;my_log_source&gt;</em> をログ・ソースに置き換えます。 指定可能な値は <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> です。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>ロギング・タイプが <code>syslog</code> であるとき、<em>&lt;log_server_hostname_or_IP&gt;</em> を、ログ・コレクター・サービスのホスト名または IP アドレスに置き換えます。 ロギング・タイプが <code>ibm</code> であるとき、<em>&lt;log_server_hostname&gt;</em> を {{site.data.keyword.loganalysislong_notm}} 取り込み URL に置き換えます。 選択可能な取り込み URL のリストは、[ここを参照してください](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)。 取り込み URL を指定しない場合、クラスターが作成された地域のエンドポイントが使用されます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em> をログ・コレクター・サーバーのポートに置き換えます。 ポートを指定しないと、標準ポート <code>514</code> が <code>syslog</code> で使用され、<code>9091</code> が <code>ibm</code> で使用されます。</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td><em>&lt;cluster_space&gt;</em> を、ログの送信先となる Cloud Foundry スペースの名前に置き換えます。 この値はログ・タイプ <code>ibm</code> についてのみ有効で、オプションです。 スペースを指定しない場合、ログはアカウント・レベルに送信されます。</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td><em>&lt;cluster_org&gt;</em> を、このスペースが属する Cloud Foundry 組織の名前に置き換えます。 この値はログ・タイプ <code>ibm</code> についてのみ有効で、スペースを指定した場合には必須です。</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td><em>&lt;logging_type&gt;</em> を、使用する新しいログ転送プロトコルに置き換えます。 現在、<code>syslog</code> と <code>ibm</code> がサポートされています。</td>
    </tr>
    </tbody></table>

2. ログ転送構成が更新されたことを確認します。

    * クラスター内のすべてのロギング構成をリスト表示する場合には、以下のようにします。

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      出力例:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 1 つのタイプのログ・ソースのロギング構成をリストする場合には、以下のようにします。

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      出力例:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

<br />


## ログ転送の停止
{: #log_sources_delete}

ロギング構成を削除すると、ログの転送を停止できます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターに設定してください。

1. ロギング構成を削除します。

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
    <em>&lt;my_cluster&gt;</em> をロギング構成が含まれているクラスターの名前で置き換え、<em>&lt;log_config_id&gt;</em> をログ・ソース構成の ID で置き換えます。

<br />


## Kubernetes API 監査ログのログ転送の構成
{: #app_forward}

Kubernetes API 監査ログは、クラスターから Kubernetes API サーバーへの呼び出しを収集します。 Kubernetes API 監査ログの収集を開始するために、Kubernetes API サーバーを構成して、クラスター用の Web フック・バックエンドをセットアップすることができます。 この Web フック・バックエンドにより、ログをリモート・サーバーに送信することができます。 Kubernetes 監査ログについて詳しくは、Kubernetes 資料の<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">監査トピック <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。

**注:**
* Kubernetes API 監査ログの転送は、Kubernetes バージョン 1.7 以降でのみサポートされています。
* 現在は、このロギング構成のすべてのクラスターで、デフォルトの監査ポリシーが使用されます。

### Kubernetes API 監査ログの転送の有効化
{: #audit_enable}

開始前に、以下のことを行います。

1. ログを転送できるリモート・ロギング・サーバーをセットアップします。例えば、[Logstash と Kubernetes を使用して ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend)、監査イベントを収集できます。

2. [CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、API サーバー監査ログの収集対象となるクラスターに設定します。

Kubernetes API 監査ログを転送するには、以下のようにします。

1. API サーバー構成の Web フック・バックエンドを設定します。 Web フック構成は、このコマンドのフラグで指定する情報に基づいて作成されます。 どのフラグにも情報を指定しない場合、デフォルトの Web フック構成が使用されます。

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>クラスターの Kubernetes API サーバー構成のオプションを設定するコマンド。</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>クラスターの Kubernetes API サーバーの監査 Web フック構成を設定するサブコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td><em>&lt;server_URL&gt;</em> を、ログの送信先となるリモート・ロギング・サービスの URL または IP アドレスに置き換えます。 非セキュアな serverURL を指定した場合、すべての証明書は無視されます。</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td><em>&lt;CA_cert_path&gt;</em> を、リモート・ロギング・サービスの検証に使用される CA 証明書のファイル・パスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td><em>&lt;client_cert_path&gt;</em> を、リモート・ロギング・サービスに対する認証に使用されるクライアント証明書のファイル・パスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td><em>&lt;client_key_path&gt;</em> を、リモート・ロギング・サービスへの接続に使用される、対応するクライアント・キーのファイル・パスに置き換えます。</td>
    </tr>
    </tbody></table>

2. リモート・ロギング・サービスの URL を参照して、ログ転送が有効化されていることを確認します。

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
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
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Kubernetes API 監査ログの転送の停止
{: #audit_delete}

クラスターの API サーバーの Web フック・バックエンド構成を無効にすることにより、監査ログの転送を停止できます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、API サーバー監査ログの収集停止の対象となるクラスターに設定します。

1. クラスターの API サーバーの Web フック・バックエンド構成を無効にします。

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Kubernetes マスターを再始動して、構成の更新を適用します。

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## ログの表示
{: #view_logs}

クラスターとコンテナーのログを表示するには、Kubernetes と Docker の標準的なロギング機能を使用します。
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

標準クラスターの場合、Kubernetes クラスターの作成時にログインした {{site.data.keyword.Bluemix_notm}} アカウントにログがあります。 クラスターの作成時またはロギング構成の作成時に {{site.data.keyword.Bluemix_notm}} スペースを指定した場合、ログはそのスペースに配置されます。 ログは、コンテナー外部からモニターされて転送されます。 コンテナーのログには Kibana ダッシュボードを使用してアクセスできます。 ロギングについて詳しくは、[{{site.data.keyword.containershort_notm}} のロギング](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)を参照してください。

**注**: クラスターまたはロギング構成の作成時にスペースを指定した場合、アカウント所有者がログを表示するには、そのスペースに対する管理者、開発者、または監査員の許可が必要です。 {{site.data.keyword.containershort_notm}} のアクセス・ポリシーとアクセス権限の変更について詳しくは、[クラスター・アクセス権限の管理](cs_users.html#managing)を参照してください。 権限を変更した後に、ログの表示が開始するまで最大で 24 時間かかります。

Kibana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。
- 米国南部および米国東部: https://logging.ng.bluemix.net
- 英国南部および中欧: https://logging.eu-fra.bluemix.net
- 南アジア太平洋地域: https://logging.au-syd.bluemix.net

ログの表示について詳しくは、[Web ブラウザーから Kibana へのナビゲート](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)を参照してください。

### Docker ログ
{: #view_logs_docker}

組み込みの Docker ロギング機能を活用して、標準の STDOUT と STDERR 出力ストリームのアクティビティーを検討することができます。 詳しくは、[Kubernetes クラスターで実行されるコンテナーのコンテナー・ログの表示](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)を参照してください。

<br />


## クラスター・モニタリングの構成
{: #monitoring}

メトリックは、クラスターの正常性とパフォーマンスをモニターするのに役立ちます。 機能低下状態または作動不可状態になったワーカー・ノードを自動的に検出して修正できるように、ワーカー・ノードの正常性モニタリングを構成できます。 **注**: モニタリングは標準クラスターでのみサポートされています。
{:shortdesc}

## メトリックの表示
{: #view_metrics}

Kubernetes と Docker の標準機能を使用して、クラスターとアプリの正常性をモニターできます。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}} のクラスター詳細ページ</dt>
<dd>{{site.data.keyword.containershort_notm}} には、クラスターの正常性と能力、そしてクラスター・リソースの使用方法に関する情報が表示されます。 この GUI を使用して、クラスターのスケールアウト、永続ストレージの作業、{{site.data.keyword.Bluemix_notm}} サービス・バインディングによるクラスターへの機能の追加を行うことができます。 クラスターの詳細ページを表示するには、**{{site.data.keyword.Bluemix_notm}} の「ダッシュボード」**に移動して、クラスターを選択します。</dd>
<dt>Kubernetes ダッシュボード</dt>
<dd>Kubernetes ダッシュボードは、ワーカー・ノードの正常性の検討、Kubernetes リソースの検索、コンテナー化アプリのデプロイ、ロギングとモニタリング情報を使用したアプリのトラブルシューティングを行うことができる、管理 Web インターフェースです。 Kubernetes ダッシュボードにアクセスする方法について詳しくは、[{{site.data.keyword.containershort_notm}} での Kubernetes ダッシュボードの起動](cs_app.html#cli_dashboard)を参照してください。</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>標準クラスターのメトリックは、Kubernetes クラスターを作成したときにログインした {{site.data.keyword.Bluemix_notm}} アカウントにあります。 クラスターの作成時に {{site.data.keyword.Bluemix_notm}} スペースを指定した場合、メトリックはそのスペースに配置されます。 コンテナーのメトリックはクラスターにデプロイされたすべてのコンテナーについて自動的に収集されます。 これらのメトリックが送信され、Grafana で使用できるようになります。 メトリックについて詳しくは、[{{site.data.keyword.containershort_notm}} のモニター](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)を参照してください。<p>Grafana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。<ul><li>米国南部と米国東部: https://metrics.ng.bluemix.net</li><li>英国南部: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

### その他のヘルス・モニター・ツール
{: #health_tools}

他のツールを構成してモニター機能を追加することができます。
<dl>
<dt>Prometheus</dt>
<dd>Prometheus は、Kubernetes のために設計されたモニタリング、ロギング、アラートのためのオープン・ソースのツールです。 このツールは、Kubernetes のロギング情報に基づいてクラスター、ワーカー・ノード、デプロイメントの正常性に関する詳細情報を取得します。 セットアップ方法について詳しくは、[{{site.data.keyword.containershort_notm}} とのサービスの統合](cs_integrations.html#integrations)を参照してください。</dd>
</dl>

<br />


## Autorecovery を使用したワーカー・ノードの正常性モニタリングの構成
{: #autorecovery}

{{site.data.keyword.containerlong_notm}} Autorecovery システムは、Kubernetes バージョン 1.7 以降の既存のクラスターにデプロイできます。 Autorecovery システムは、さまざまな検査機能を使用してワーカー・ノードの正常性状況を照会します。 Autorecovery は、構成された検査に基づいて正常でないワーカー・ノードを検出すると、ワーカー・ノードの OS の再ロードのような修正アクションをトリガーします。 修正アクションは、一度に 1 つのワーカー・ノードに対してのみ実行されます。 1 つのワーカー・ノードの修正アクションが正常に完了してからでないと、別のワーカー・ノードの修正アクションは実行されません。 詳しくは、[Autorecovery に関するブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/) を参照してください。
**注**: Autorecovery が正常に機能するためには、1 つ以上の正常なノードが必要です。 Autorecovery でのアクティブな検査は、複数のワーカー・ノードが存在するクラスターでのみ構成します。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ワーカー・ノードの状況を検査するクラスターに設定してください。

1. 検査を JSON 形式で定義する構成マップ・ファイルを作成します。 例えば、次の YAML ファイルでは、3 つの検査 (1 つの HTTP 検査と 2 つの Kubernetes API サーバー検査) を定義しています。 **注**: 各検査は、構成マップのデータ・セクションに固有キーとして定義する必要があります。

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
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
    ```
    {:codeblock}


    <table summary="構成マップの構成要素について">
    <caption>構成マップの構成要素について</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>構成マップの構成要素について</th>
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
          <td><code>checkhttp.json</code></td>
          <td>HTTP 検査を定義します。この検査では、HTTP サーバーがポート 80 上の各ノードの IP アドレスで稼働していることを検査して、パス <code>/myhealth</code> に 200 応答を返します。<code>kubectl get nodes</code> を実行することにより、ノードの IP アドレスを検索できます。
               例えば、IP アドレスが 10.10.10.1 および 10.10.10.2 である 2 つのノードがクラスターにあるとします。この例では、<code>http://10.10.10.1:80/myhealth</code> および <code>http://10.10.10.2:80/myhealth</code> の 2 つの経路で、200 OK の応答の検査が行われます。
               上記のサンプル YAML では、検査が 3 分ごとに実行されます。連続して 3 回失敗すると、ノードはリブートされます。この操作は、<code>bx cs worker-reboot</code> を実行することと同等です。<b>「有効」</b>フィールドを <code>true</code> に設定するまで、HTTP 検査は無効になります。</td>
        </tr>
        <tr>
          <td><code>checknode.json</code></td>
          <td>各ノードが <code>Ready</code> 状態であるかどうかを検査する Kubernetes API ノード検査を定義します。特定のノードが <code>Ready</code> 状態でない場合、そのノードの検査結果は失敗となります。
               上記のサンプル YAML では、検査が 3 分ごとに実行されます。連続して 3 回失敗すると、ノードは再ロードされます。この操作は、<code>bx cs worker-reload</code> を実行することと同等です。<b>「有効」</b>フィールドを <code>false</code> に設定するか、または検査を除去するまで、ノード検査は有効になります。</td>
        </tr>
        <tr>
          <td><code>checkpod.json</code></td>
          <td>ノード上の <code>NotReady</code> ポッドの合計パーセンテージを、そのノードに割り当てられた合計ポッド数に基づいて検査する、Kubernetes API ポッド検査を定義します。<code>NotReady</code> ポッドの合計パーセンテージが、定義済みの <code>PodFailureThresholdPercent</code> より大きい場合、そのノードの検査結果は失敗となります。
               上記のサンプル YAML では、検査が 3 分ごとに実行されます。連続して 3 回失敗すると、ノードは再ロードされます。この操作は、<code>bx cs worker-reload</code> を実行することと同等です。<b>「有効」</b>フィールドを <code>false</code> に設定するか、または検査を除去するまで、ポッド検査は有効になります。</td>
        </tr>
      </tbody>
    </table>


    <table summary="個別のルールの構成要素について">
    <caption>個別のルールの構成要素について</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>個別のルールの構成要素について</th>
      </thead>
      <tbody>
       <tr>
           <td><code>Check</code></td>
           <td>Autorecovery で使用する検査のタイプを入力します。 <ul><li><code>HTTP</code>: Autorecovery は、各ノードで稼働する HTTP サーバーを呼び出して、ノードが正常に稼働しているかどうかを判別します。</li><li><code>KUBEAPI</code>: Autorecovery は、Kubernetes API サーバーを呼び出し、ワーカー・ノードによって報告された正常性状況データを読み取ります。</li></ul></td>
           </tr>
       <tr>
           <td><code>リソース</code></td>
           <td>検査タイプが <code>KUBEAPI</code> である場合は、Autorecovery で検査するリソースのタイプを入力します。 受け入れられる値は <code>NODE</code> または <code>PODS</code> です。</td>
           </tr>
       <tr>
           <td><code>FailureThreshold</code></td>
           <td>検査の連続失敗数のしきい値を入力します。 このしきい値に達すると、Autorecovery が、指定された修正アクションをトリガーします。 例えば、値が 3 である場合に、Autorecovery で構成された検査が 3 回連続して失敗すると、Autorecovery は検査に関連付けられている修正アクションをトリガーします。</td>
       </tr>
       <tr>
           <td><code>PodFailureThresholdPercent</code></td>
           <td>リソース・タイプが <code>PODS</code> である場合は、[NotReady ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状態になることができるワーカー・ノード上のポッドのしきい値 (パーセンテージ) を入力します。 このパーセンテージは、ワーカー・ノードにスケジュールされているポッドの合計数に基づきます。 検査の結果、正常でないポッドのパーセンテージがしきい値を超えていることが判別されると、1 回の失敗としてカウントされます。</td>
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
      </tbody>
    </table>

2. クラスター内に構成マップを作成します。

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 適切な検査を実行して、`kube-system` 名前空間内に `ibm-worker-recovery-checks` という名前の構成マップが作成されていることを確認します。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. `kube-system` 名前空間内に `international-registry-docker-secret` という名前の Docker プル・シークレットが作成されていることを確認します。 Autorecovery は、{{site.data.keyword.registryshort_notm}} の Docker 国際レジストリーでホストされています。 国際レジストリーの有効な資格情報を格納する Docker レジストリー・シークレットを作成していない場合は、Autorecovery システムを実行するためにそれを作成します。

    1. {{site.data.keyword.registryshort_notm}} プラグインをインストールします。

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. ターゲットとして国際レジストリーを設定します。

        ```
        bx cr region-set international
        ```
        {: pre}

    3. 国際レジストリー・トークンを作成します。

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. `INTERNATIONAL_REGISTRY_TOKEN` 環境変数を、作成したトークンに設定します。

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. `DOCKER_EMAIL` 環境変数を現行ユーザーに設定します。 E メール・アドレスは、次のステップで `kubectl` コマンドを実行する場合にのみ必要です。

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Docker プル・シークレットを作成します。

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. この YAML ファイルを適用することによって、Autorecovery をクラスターにデプロイします。

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. 数分後に、次のコマンドの出力にある `Events` セクションを確認して、Autorecovery のデプロイメントのアクティビティーを確認できます。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
