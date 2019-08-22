---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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
{:preview: .preview}



# デフォルトの Ingress 動作の変更
{: #ingress-settings}

Ingress リソースを作成してアプリを公開した後、以下のオプションを設定して、クラスター内の Ingress ALB をさらに構成できます。
{: shortdesc}

## Ingress ALB でポートを開く
{: #opening_ingress_ports}

デフォルトでは、Ingress ALB で公開されるのはポート 80 とポート 443 のみです。 他のポートを公開するには、`ibm-cloud-provider-ingress-cm` 構成マップ・リソースを編集します。
{: shortdesc}

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを編集します。
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. <code>data</code> セクションを追加し、パブリック・ポート `80` および `443` と、公開する他のポートをセミコロン (;) で区切って指定します。

    デフォルトでは、ポート 80 と 443 が開きます。 80 と 443 を開いたままにしておく場合は、指定する他のポートに加えて、それらのポートも `public-ports` フィールドに含める必要があります。 指定しないポートは閉じられます。 プライベート ALB を有効にした場合は、開いたままにしておくポートも `private-ports` フィールドで指定する必要があります。
    {: important}

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

5. オプション:
  * [`tcp-ports`](/docs/containers?topic=containers-ingress_annotation#tcp-ports) アノテーションで開いた標準以外の TCP ポートでアプリにアクセスします。
  * HTTP (ポート 80) と HTTPS (ポート 443) のネットワーク・トラフィックのデフォルトのポートを、[`custom-port`](/docs/containers?topic=containers-ingress_annotation#custom-port) アノテーションで開いたポートに変更します。

構成マップ・リソースについて詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/) を参照してください。

<br />


## ソース IP アドレスの保持
{: #preserve_source_ip}

デフォルトでは、クライアント要求のソース IP アドレスは保持されません。 アプリへのクライアント要求がクラスターに送信されると、その要求は、ALB を公開しているロード・バランサー・サービス・ポッドに転送されます。 ロード・バランサー・サービス・ポッドと同じワーカー・ノードにアプリ・ポッドが存在しない場合、ロード・バランサーは異なるワーカー・ノード上のアプリ・ポッドに要求を転送します。 パッケージのソース IP アドレスは、アプリ・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。
{: shortdesc}

クライアント要求の元のソース IP アドレスを保持するには、[ソース IP の保持 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) を有効にします。 クライアントの IP を保持すると、例えば、アプリ・サーバーがセキュリティーやアクセス制御ポリシーを適用する必要がある場合などに役に立ちます。

[ALB を無効にした](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure)場合、ALB を公開するロード・バランサー・サービスに対して行ったソース IP の変更はすべて失われます。 ALB を再度有効にする場合、ソース IP を再度有効にする必要があります。
{: note}

ソース IP の保持を有効にするには、Ingress ALB を公開するロード・バランサー・サービスを編集します。

1. 1 つの ALB またはクラスター内のすべての ALB のソース IP の保持を有効にします。
    * 1 つの ALB のソース IP の保持をセットアップするには、次の手順を実行します。
        1. ソース IP を有効にする ALB の ID を取得します。 ALB サービスは、パブリック ALB の場合は `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`、プライベート ALB の場合は `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` のような形式になります。
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. ALB を公開するロード・バランサー・サービスの YAML を開きます。
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. **`spec`** の下で、**`externalTrafficPolicy`** の値を「`Cluster`」から「`Local`」に変更します。

        4. 構成ファイルを保存して閉じます。 出力は、以下のようになります。

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

    2. その ALB ポッドのログを開きます。 `client` フィールドの IP アドレスが、ロード・バランサー・サービスの IP アドレスではなく、クライアント要求の IP アドレスであることを確認します。
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. これで、バックエンド・アプリに送信された要求のヘッダーを見れば、`x-forwarded-for` ヘッダーでクライアント IP アドレスがわかるようになります。

4. 　ソース IP を保持しないようにする場合は、サービスに対して行った変更を戻します。
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

PCI Security Standards Council の基準に準拠するために、Ingress サービスでは、2019 年 1 月 23 日の Ingress ALB ポッドのバージョン更新によって TLS 1.0 と 1.1 がデフォルトで無効になります。 この更新は、自動 ALB 更新をオプトアウトしていないすべての {{site.data.keyword.containerlong_notm}} クラスターに自動的にロールアウトされます。 アプリに接続するクライアントが TLS 1.2 に対応していれば、何の対処も必要ありません。 TLS 1.0 または 1.1 のサポートを必要とする既存のクライアントをまだ使用する場合は、必要な TLS バージョンを手動で有効にしなければなりません。 このセクションで、TLS 1.1 または 1.0 のプロトコルを使用するためにデフォルトの設定をオーバーライドする手順を説明します。 アプリへのアクセスにクライアントで使用している TLS バージョンを確認する方法について詳しくは、こちらの [{{site.data.keyword.cloud_notm}} のブログ投稿](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/)を参照してください。
{: important}

すべてのホストで有効なプロトコルを指定する場合、TLSv1.1 および TLSv1.2 パラメーター (1.1.13、1.0.12) は、OpenSSL 1.0.1 以上が使用されている場合にのみ使用できます。 TLSv1.3 パラメーター (1.13.0) は、TLSv1.3 対応版の OpenSSL 1.1.1 が使用されている場合にのみ使用できます。
{: note}

構成マップを編集して SSL プロトコルおよび暗号を有効にするには、以下のようにします。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを編集します。

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


## ALB ポッドの再始動準備状況検査時間を増やす
{: #readiness-check}

ALB ポッドが再始動したときに、ALB ポッドがサイズの大きい Ingress リソース・ファイルの解析にかけることのできる時間を増やします。
{: shortdesc}

更新が適用された後などに ALB ポッドが再始動すると、準備状況検査が実施され、そのために、すべての Ingress リソース・ファイルが解析されるまで、ALB ポッドはトラフィック要求のルーティングを試行できなくなります。この準備状況検査は、ALB ポッドの再始動時に要求が失われることを防止します。デフォルトでは、準備状況検査は、ポッドの再始動後 15 秒間待機してから開始し、すべての Ingress ファイルが解析されているかどうかを検査します。ポッドの再始動の 15 秒後の時点ですべてのファイルが解析されていれば、 ALB ポッドはトラフィック要求のルーティングを再開します。ポッドの再始動の 15 秒後の時点ですべてのファイルが解析されていない場合、ポッドはトラフィックのルーティングを行わず、準備状況検査が続行され、最大でタイムアウトになるまでの 5 分の間、15 秒ごとに検査が実施されます。5 分経過すると、ALB ポッドはトラフィックのルーティングを開始します。

Ingress リソース・ファイルが非常に大きい場合、すべてのファイルが解析されるまでに 5 分より長くかかることがあります。`ingress-resource-creation-rate` と `ingress-resource-timeout` の設定を `ibm-cloud-provider-ingress-cm` 構成マップに追加することにより、準備状況検査間隔レートと準備状況検査のタイムアウトまでの合計最大時間のデフォルト値を変更することができます。 

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを編集します。
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. **data** セクションに、`ingress-resource-creation-rate` と `ingress-resource-timeout` の設定を追加します。値は、秒 (`s`) と分 (`m`) の形式にすることができます。例:
   ```
   apiVersion: v1
   data:
     ingress-resource-creation-rate: 1m
     ingress-resource-timeout: 6m
     keep-alive: 8s
     private-ports: 80;443
     public-ports: 80;443
   ```
   {: codeblock}

3. 構成ファイルを保存します。

4. 構成マップの変更が適用されたことを確認します。
   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## ALB のパフォーマンスの調整
{: #perf_tuning}

Ingress ALB のパフォーマンスを最適化するために、必要に応じてデフォルト設定を変更できます。
{: shortdesc}

### すべてのワーカー・ノードへの ALB ソケット・リスナーの追加
{: #reuse-port}

`reuse-port` Ingress ディレクティブを使用して、ALBソケット・リスナーの数を「クラスターごとに 1 つ」から「ワーカー・ノードごとに 1 つ」にまで増やします。
{: shortdesc}

`reuse-port` オプションが使用不可の場合、1 つの listen ソケットが着信接続についてワーカーに通知すると、すべてのワーカー・ノードがその接続を取得しようとします。しかし、`reuse-port` が有効にされている場合は、ALB IP アドレスとポートの組み合わせごとに 1 つのワーカー・ノードにつき 1 つのソケット・リスナーが存在します。各ワーカー・ノードがその接続を受け入れようとするのではなく、Linux カーネルが、どの使用可能ソケット・リスナーが接続を取得できるかを判別します。ワーカー間のロック競合が減り、パフォーマンスが向上する可能性があります。 `reuse-port` ディレクティブのメリットとデメリットについて詳しくは、[この NGINX ブログの投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/) を参照してください。

`ibm-cloud-provider-ingress-cm` Ingress 構成マップを編集して、リスナーをスケーリングできます。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを編集します。
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. `metadata` セクションに、`reuse-port:"true"` を追加します。例:
   ```
   apiVersion: v1
   data:
     private-ports: 80;443;9443
     public-ports: 80;443
   kind: ConfigMap
   metadata:
     creationTimestamp: "2018-09-28T15:53:59Z"
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
     resourceVersion: "24648820"
     selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
     uid: b6ca0c36-c336-11e8-bf8c-bee252897df5
     reuse-port: "true"
   ```
   {: codeblock}

3. 構成ファイルを保存します。

4. 構成マップの変更が適用されたことを確認します。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### ログ・バッファリングとフラッシュ・タイムアウトの有効化
{: #access-log}

デフォルトでは、Ingress ALB は要求の到着時に各要求をログに記録します。 頻繁に使用される環境がある場合は、要求が到着するたびに各要求をログに記録していると、ディスク入出力の使用率が大幅に増加します。 連続的なディスク入出力を回避するには、`ibm-cloud-provider-ingress-cm` Ingress 構成マップを編集して、ALB のログ・バッファリングとフラッシュ・タイムアウトを有効にします。 バッファリングが有効になっている場合、ALB は、ログ・エントリーごとに個別の書き込み操作を実行する代わりに、一連のエントリーをバッファーに入れて、1 回の操作でまとめてファイルに書き込みます。
{: shortdesc}

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを作成して編集します。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 構成マップを編集します。
    1. `access-log-buffering` フィールドを追加して `"true"` に設定することで、ログ・バッファリングを有効にします。

    2. ALB がバッファーの内容をログに書き込むときのしきい値を設定します。
        * 時間間隔: `flush-interval` フィールドを追加して、ALB がログに書き込む頻度を設定します。 例えば、デフォルト値の `5m` を使用すると、ALB は 5 分ごとにログにバッファーの内容を書き込みます。
        * バッファー・サイズ: `buffer-size` フィールドを追加して、ALB がバッファーの内容をログに書き込む前にバッファーに保持できるログ・メモリーの量を設定します。 例えば、デフォルト値の `100KB` を使用すると、ALB はバッファーのログの内容が 100KB に達するたびにバッファーの内容をログに書き込みます。
        * 時間間隔またはバッファー・サイズ: `flush-interval` と `buffer-size` の両方が設定されている場合、ALB は、最初に満たされたしきい値パラメーターに基づいて、ログにバッファーの内容を書き込みます。

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. 構成ファイルを保存します。

4. ALB がアクセス・ログの変更によって構成されたことを確認します。

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### キープアライブ接続の数または期間の変更
{: #keepalive_time}

キープアライブ接続によって、接続を開いたり閉じたりするのに必要な CPU とネットワークの使用量を減らせれば、パフォーマンスに大きな影響を及ぼせます。 ALB のパフォーマンスを最適化するには、ALB とクライアントのキープアライブ接続の最大数と、キープアライブ接続を持続できる時間を変更します。
{: shortdesc}

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを編集します。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. `keep-alive-requests` および `keep-alive` の値を変更します。
    * `keep-alive-requests`: Ingress ALB に対して接続を開いておくことができるキープアライブ・クライアント接続の数。 デフォルトは `4096`です。
    * `keep-alive`: キープアライブ・クライアント接続を Ingress ALB に対して開いておくタイムアウト (秒)。 デフォルトは `8s` です。
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
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

### 保留中の接続のバックログの変更
{: #backlog}

サーバー・キューで待機できる保留中の接続数に関するデフォルトのバックログ設定を減らすことができます。
{: shortdesc}

`ibm-cloud-provider-ingress-cm` Ingress 構成マップの `backlog` フィールドで、サーバー・キューで待機できる保留中の接続の最大数を設定します。 デフォルトでは、`backlog` は `32768` に設定されます。 Ingress 構成マップを編集して、デフォルト設定をオーバーライドできます。

1. `ibm-cloud-provider-ingress-cm` 構成マップ・リソースに対応する構成ファイルを編集します。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. `backlog` の値を `32768` より小さい値に変更します。 値は 32768 以下である必要があります。

   ```
   apiVersion: v1
   data:
     backlog: "32768"
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

### カーネルのパフォーマンスの調整
{: #ingress_kernel}

Ingress ALB のパフォーマンスを最適化するには、[ワーカー・ノードで Linux カーネルの `sysctl` パラメーターを変更する](/docs/containers?topic=containers-kernel)こともできます。 ワーカー・ノードには、最適化されたカーネルの調整が自動的にプロビジョンされるため、特定のパフォーマンス最適化要件がある場合にのみこの設定を変更します。
{: shortdesc}

<br />

