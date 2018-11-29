---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Ingress のロギングとモニタリング
{: #ingress_health}

ロギングをカスタマイズし、モニタリングをセットアップすると、問題のトラブルシューティングや、Ingress 構成のパフォーマンスを向上させるのに役立ちます。
{: shortdesc}

## Ingress ログの表示
{: #ingress_logs}

Ingress ALB のログは自動的に収集されます。 ALB ログを表示するには、次の 2 つの方法から選択します。
* クラスターで [Ingress サービスのロギング構成を作成します](cs_health.html#configuring)。
* CLI からログを確認します。
    1. ALB のポッドの ID を取得します。
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. その ALB ポッドのログを開きます。 ログが更新されたフォーマットに従っていることを確認します。
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>デフォルトの Ingress ログの内容は JSON 形式で、クライアントとアプリの間の接続セッションを記述する共通フィールドが表示されます。 デフォルト・フィールドのサンプル・ログは、以下のようになります。

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>デフォルトの Ingress ログ・フォーマットのフィールドについて</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> デフォルトの Ingress ログ・フォーマットのフィールドについて</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>ログが書き込まれた現地時間 (ISO 8601 標準形式)。</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>クライアントがアプリに送信した要求パッケージの IP アドレス。 この IP は、以下の状況に基づいて変更されることがあります。<ul><li>アプリへのクライアント要求がクラスターに送信されると、その要求は、ALB を公開しているロード・バランサー・サービス・ポッドに転送されます。 ロード・バランサー・サービス・ポッドと同じワーカー・ノードにアプリ・ポッドが存在しない場合、ロード・バランサーは異なるワーカー・ノード上のアプリ・ポッドに要求を転送します。 要求パッケージのソース IP アドレスが、アプリ・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。</li><li>[ソース IP の保持が有効な場合](cs_ingress.html#preserve_source_ip)、アプリへのクライアント要求の元の IP アドレスが代わりに記録されます。</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>アプリへのアクセスが可能なホストまたはサブドメイン。 このホストは、ALB の Ingress リソース・ファイルで構成されています。</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>要求の種類 (<code>HTTP</code> または <code>HTTPS</code>)。</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td><code>GET</code> や <code>POST</code> など、バックエンド・アプリへの要求呼び出しのメソッド。</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>アプリ・パスへの元の要求 URI。 ALB はアプリが listen するパスを接頭部として処理します。 ALB がクライアントからアプリへの要求を受け取ると、ALB は、要求 URI のパスに一致するパス (接頭部として指定) があるか Ingress リソースを検査します。</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>16 ランダム・バイトから生成された一意の要求 ID。</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>接続セッションの状況コード。<ul>
<li><code>200</code>: セッションが正常に完了しました</li>
<li><code>400</code>: クライアント・データを解析できません</li>
<li><code>403</code>: アクセスが禁止されています (特定のクライアント IP アドレスについてはアクセスが制限されている場合など)</li>
<li><code>500</code>: 内部サーバー・エラー</li>
<li><code>502</code>: 不正なゲートウェイ (アップストリーム・サーバーを選択できないか、または到達できない場合など)</li>
<li><code>503</code>: サービスは使用不可です (接続数によってアクセスが制限されている場合など)</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>アップストリーム・サーバーの IP アドレスおよびポート、または UNIX ドメイン・ソケットへのパス。 要求の処理時に複数のサーバーが接続される場合は、アドレスがコンマで区切られます (<code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>)。 要求が内部的にサーバー・グループ間でリダイレクトされる場合、さまざまなグループからのサーバー・アドレスがコロンで区切られます (<code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>)。 ALB がサーバーを選択できない場合は、代わりにサーバー・グループの名前がログに記録されます。</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>バックエンド・アプリのアップストリーム・サーバーから取得された応答の状況コード (標準 HTTP 応答コードなど)。 いくつかの応答の状況コードは、<code>$upstream_addr</code> 変数のアドレスのようにコンマとコロンで区切られます。 ALB がサーバーを選択できない場合は、502 (不正なゲートウェイ) 状況コードがログに記録されます。</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>要求処理時間 (ミリ秒分解能の秒単位で測定)。 この時間は、ALB がクライアント要求の最初のバイトを読み取ったときに開始され、ALB が応答の最後のバイトをクライアントに送信するときに停止されます。 ログは、要求処理時間が停止した直後に書き込まれます。</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>ALB がバックエンド・アプリのアップストリーム・サーバーから応答を受信するのにかかる時間 (ミリ秒分解能の秒単位で測定)。 いくつかの応答の時間は、<code>$upstream_addr</code> 変数のアドレスのようにコンマとコロンで区切られます。</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>ALB がバックエンド・アプリのアップストリーム・サーバーとの接続を確立するのにかかる時間 (ミリ秒分解能の秒単位で測定)。 Ingress リソース構成で TLS/SSL が有効になっている場合、この時間にはハンドシェークに費やされた時間が含まれます。 いくつかの接続の時間は、<code>$upstream_addr</code> 変数のアドレスのようにコンマとコロンで区切られます。</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>ALB がバックエンド・アプリのアップストリーム・サーバーから応答ヘッダーを受信するのにかかる時間 (ミリ秒分解能の秒単位で測定)。 いくつかの接続の時間は、<code>$upstream_addr</code> 変数のアドレスのようにコンマとコロンで区切られます。</td>
</tr>
</tbody></table>

## Ingress ログの内容とフォーマットをカスタマイズする
{: #ingress_log_format}

Ingress ALB に関して収集されるログの内容とフォーマットをカスタマイズすることができます。
{:shortdesc}

デフォルトでは、Ingress ログは JSON 形式にフォーマットされ、一般的なログ・フィールドが示されます。 しかし、カスタム・ログ・フォーマットを作成することもできます。 転送するログの構成要素と、それぞれの構成要素をログ出力に配置する方法を選択するには、以下のようにします。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成して開きます。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. <code>data</code> セクションを追加します。 `log-format` フィールドと、オプションで `log-format-escape-json` フィールドを追加します。

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>YAML ファイルの構成要素</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> log-format の構成について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td><code>&lt;key&gt;</code> を、ログの構成要素の名前に置き換えます。<code>&lt;log_variable&gt;</code> を、ログ・エントリーに収集する、ログの構成要素の変数に置き換えます。 ストリング値を囲む引用符や、ログの構成要素を区切るコンマなど、ログ・エントリーに含めたいテキストと句読点を指定できます。 例えば、<code>request: "$request"</code> のように構成要素をフォーマットすると、<code>request: "GET / HTTP/1.1"</code> がログ・エントリーに生成されます。 使用できるすべての変数のリストについては、<a href="http://nginx.org/en/docs/varindex.html">Nginx の変数の索引</a>を参照してください。<br><br><em>x-custom-ID</em> などの追加ヘッダーをログに記録するには、次のキー/値ペアをカスタム・ログの内容に追加します。 <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>ハイフン (<code>-</code>) は下線 (<code>_</code>) に変換されます。カスタム・ヘッダー名の先頭に <code>$http_</code> を追加する必要があります。</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>オプション: デフォルトでは、ログはテキスト形式で生成されます。 ログを JSON 形式で生成するには、<code>log-format-escape-json</code> フィールドを追加し、値 <code>true</code> を使用します。</td>
    </tr>
    </tbody></table>

    例えば、ログ・フォーマットに以下の変数が含まれるとします。
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    このフォーマットに基づくログ項目の例を以下に示します。
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    ALB ログのデフォルト・フォーマットに基づくカスタム・ログ・フォーマットを作成するには、必要に応じて以下のセクションを変更して構成マップに追加します。
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. 構成ファイルを保存します。

5. 構成マップの変更が適用されたことを確認します。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Ingress ALB ログを表示するには、次の 2 つの方法から選択します。
    * クラスターで [Ingress サービスのロギング構成を作成します](cs_health.html#logging)。
    * CLI からログを確認します。
        1. ALB のポッドの ID を取得します。
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. その ALB ポッドのログを開きます。 ログが更新されたフォーマットに従っていることを確認します。
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Ingress メトリックの収集に関する共有メモリー・ゾーン・サイズの引き上げ
{: #vts_zone_size}

共有メモリー・ゾーンは、ワーカー・プロセスがキャッシュ、セッション・パーシスタンス、速度制限などの情報を共有できるように定義されています。 仮想ホスト・トラフィック状況ゾーンとも呼ばれる共有メモリー・ゾーンは、Ingress が ALB のメトリック・データを収集できるようにセットアップされています。
{:shortdesc}

`ibm-cloud-provider-ingress-cm` Ingress 構成マップの `vts-status-zone-size` フィールドで、メトリック・データ収集の共有メモリー・ゾーンのサイズを設定します。 デフォルトでは、`vts-status-zone-size` は `10m` に設定されます。 大きな環境で、メトリックを収集するためにさらに多くのメモリーが必要な場合は、以下の手順に従って、デフォルトをオーバーライドして大きい値を使用することができます。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成して開きます。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. `vts-status-zone-size` の値を `10m` より大きい値に変更します。

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
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
