---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb, health check, dns, host name

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


# NLB ホスト名の登録
{: #loadbalancer_hostname}

ネットワーク・ロード・バランサー (NLB) をセットアップした後、ホスト名を作成して、NLB IP の DNS エントリーを作成できます。 また、TCP/HTTP(S) モニターをセットアップして、各ホスト名の背後にある NLB IP アドレスのヘルス・チェックを行うこともできます。
{: shortdesc}

<dl>
<dt>ホスト名</dt>
<dd>単一ゾーンまたは複数ゾーンのクラスターでパブリック NLB を作成すると、NLB IP アドレスのホスト名を作成して、インターネットにアプリを公開できます。また、{{site.data.keyword.cloud_notm}} によって、ホスト名のワイルドカード SSL 証明書の生成と保守が行われます。
<p>複数ゾーンのクラスターで、ホスト名を作成し、各ゾーンでそのホスト名の DNS エントリーに NLB IP アドレスを追加できます。 例えば、米国南部の 3 つのゾーンでアプリの NLB をデプロイした場合は、3 つの NLB IP アドレスに対してホスト名 `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` を作成できます。 ユーザーがアプリのホスト名にアクセスすると、クライアントがこれらの IP のいずれかにランダムにアクセスし、要求が NLB に送信されます。</p>
現在、プライベート NLB のホスト名を作成することはできません。</dd>
<dt>ヘルス・チェック・モニター</dt>
<dd>単一のホスト名の背後にある NLB IP アドレスに対するヘルス・チェックを有効にして、IP アドレスが使用可能かどうかを判別します。 ホスト名のモニターを有効にすると、モニターによって各 NLB IP がヘルス・チェックされ、そのヘルス・チェックに基づいて DNS 参照の結果が最新の状態に保たれます。 例えば、NLB IP アドレスが `1.1.1.1`、`2.2.2.2`、`3.3.3.3` である場合、ホスト名の DNS 参照の通常の動作では、3 つの IP がすべて返され、クライアントはそのうちの 1 つにランダムにアクセスします。 IP アドレスが `3.3.3.3` の NLB がゾーンの障害などの理由で使用不可になると、その IP のヘルス・チェックが失敗し、モニターは障害のある IP をホスト名から削除し、DNS 参照では正常な `1.1.1.1` および `2.2.2.2` の IP のみが返されます。</dd>
</dl>

クラスター内の NLB IP に登録されているすべてのホスト名を表示するには、以下のコマンドを実行します。
```
ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
```
{: pre}

</br>

## DNS ホスト名への NLB IP の登録
{: #loadbalancer_hostname_dns}

ネットワーク・ロード・バランサー (NLB) IP アドレスのホスト名を作成して、アプリをパブリック・インターネットに公開します。
{: shortdesc}

開始前に、以下のことを行います。
* 以下の考慮事項および制限事項を確認します。
  * パブリック・バージョン 1.0 および 2.0 の NLB のホスト名を作成できます。
  * 現在、プライベート NLB のホスト名を作成することはできません。
  * 最大 128 台のホスト名を登録できます。 この制限は、[サポート・ケース](/docs/get-support?topic=get-support-getting-customer-support)を開いて、要求によって解除できます。
* [単一ゾーン・クラスターでアプリの NLB を作成する](/docs/containers?topic=containers-loadbalancer#lb_config)か、[複数ゾーン・クラスターの各ゾーンで NLB を作成します](/docs/containers?topic=containers-loadbalancer#multi_zone_config)。

1 つ以上の NLB IP アドレスのホスト名を作成するには、以下のようにします。

1. NLB の **EXTERNAL-IP** アドレスを取得します。 アプリを公開する複数ゾーン・クラスターの各ゾーンに NLB がある場合は、各 NLB の IP を取得します。
  ```
  kubectl get svc
  ```
  {: pre}

  以下の出力例では、NLB **EXTERNAL-IP** は `168.2.4.5` および `88.2.4.5` です。
  ```
  NAME             TYPE           CLUSTER-IP       EXTERNAL-IP       PORT(S)                AGE
  lb-myapp-dal10   LoadBalancer   172.21.xxx.xxx   168.2.4.5         1883:30303/TCP         6d
  lb-myapp-dal12   LoadBalancer   172.21.xxx.xxx   88.2.4.5          1883:31303/TCP         6d
  ```
  {: screen}

2. DNS ホスト名を作成することによって、この IP を登録します。 最初にホスト名を作成するときには、1 つの IP アドレスのみを使用できます。
  ```
  ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <NLB_IP>
  ```
  {: pre}

3. ホスト名が作成されたことを確認します。
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  出力例:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.2.4.5"]      None             created                   <certificate>
  ```
  {: screen}

4. アプリを公開する複数ゾーン・クラスターの各ゾーンに NLB がある場合は、他の NLB の IP をホスト名に追加します。 追加する各 IP アドレスに対して以下のコマンドを実行する必要があります。
  ```
  ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
  ```
  {: pre}

5. オプション: `host` または `ns lookup` を実行して、ホスト名に IP が登録されていることを確認します。
  コマンド例:
  ```
  host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud
  ```
  {: pre}

  出力例:
  ```
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 88.2.4.5  
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud has address 168.2.4.5
  ```
  {: screen}

6. Web ブラウザーに、作成したホスト名によってアプリにアクセスする URL を入力します。

次に、[ヘルス・モニターを作成して、ホスト名に対するヘルス・チェックを有効にできます](#loadbalancer_hostname_monitor)。

</br>

## ホスト名のフォーマットについて
{: #loadbalancer_hostname_format}

Host names for NLB のホスト名は、フォーマット `<cluster_name>-<globally_unique_account_HASH>-0001.<region>.containers.appdomain.cloud` に従います。
{: shortdesc}

例えば、NLB に作成したホスト名が `mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud` のようになります。 以下の表で、ホスト名の各構成要素について説明します。

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> LB ホスト名のフォーマットについて</th>
</thead>
<tbody>
<tr>
<td><code>&lt;cluster_name&gt;</code></td>
<td>クラスターの名前。
<ul><li>クラスター名が 26 文字以下である場合は、クラスター名全体が含まれ、変更されません (<code>myclustername</code>)。</li>
<li>クラスター名が 26 文字以上であり、その地域で一意である場合は、クラスター名の最初の 24 文字のみが使用されます (<code>myveryverylongclusternam</code>)。</li>
<li>クラスター名が 26 文字以上であり、その地域に同じ名前の既存のクラスターがある場合は、クラスター名の最初の 17 文字のみが使用され、ダッシュとランダムな 6 文字が追加されます (<code>myveryverylongclu-ABC123</code>)。</li></ul>
</td>
</tr>
<tr>
<td><code>&lt;globally_unique_account_HASH&gt;</code></td>
<td>{{site.data.keyword.cloud_notm}} アカウントにグローバルに一意のハッシュが作成されます。 アカウントのクラスター内で NLB に作成したすべてのホスト名は、このグローバルに一意のハッシュを使用します。</td>
</tr>
<tr>
<td><code>0001</code></td>
<td>
最初と 2 番目の文字 <code>00</code> はパブリック・ホスト名を示します。 3 番目と 4 番目の文字 <code>01</code> や別の数値は、作成した各ホスト名のカウンターとして機能します。</td>
</tr>
<tr>
<td><code>&lt;region&gt;</code></td>
<td>クラスターが作成された地域。</td>
</tr>
<tr>
<td><code>containers.appdomain.cloud</code></td>
<td>{{site.data.keyword.containerlong_notm}} のホスト名のサブドメイン。</td>
</tr>
</tbody>
</table>

</br>

## ヘルス・モニターを作成して、ホスト名に対するヘルス・チェックを有効にする
{: #loadbalancer_hostname_monitor}

単一のホスト名の背後にある NLB IP アドレスに対するヘルス・チェックを有効にして、IP アドレスが使用可能かどうかを判別します。
{: shortdesc}

開始する前に、[DNS ホスト名に NLB IP を登録します](#loadbalancer_hostname_dns)。

1. ホスト名を取得します。 出力では、ホストのモニターの **Status** が `Unconfigured` になっています。
  ```
  ibmcloud ks nlb-dns-monitor-ls --cluster <cluster_name_or_id>
  ```
  {: pre}

  出力例:
  ```
  Hostname                                                                                   Status         Type    Port   Path
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud        Unconfigured   N/A     0      N/A
  ```
  {: screen}

2. ホスト名のヘルス・チェック・モニターを作成します。 構成パラメーターを含めない場合は、そのデフォルト値が使用されます。
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --enable --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
  ```
  {: pre}

  <table>
  <caption>このコマンドの構成要素について</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>--cluster &lt;cluster_name_or_ID&gt;</code></td>
  <td>必須: ホスト名が登録されているクラスターの名前または ID。</td>
  </tr>
  <tr>
  <td><code>--nlb-host &lt;host_name&gt;</code></td>
  <td>必須: ヘルス・チェック・モニターを有効にするホスト名。</td>
  </tr>
  <tr>
  <td><code>--enable</code></td>
  <td>必須: ホスト名のヘルス・チェック・モニターを有効にします。</td>
  </tr>
  <tr>
  <td><code>--description &lt;description&gt;</code></td>
  <td>ヘルス・モニターの説明。</td>
  </tr>
  <tr>
  <td><code>--type &lt;type&gt;</code></td>
  <td>ヘルス・チェックに使用するプロトコル: <code>HTTP</code>、<code>HTTPS</code>、または <code>TCP</code>。 デフォルト: <code>HTTP</code></td>
  </tr>
  <tr>
  <td><code>--method &lt;method&gt;</code></td>
  <td>ヘルス・チェックに使用するメソッド。 <code>type</code> <code>HTTP</code> および <code>HTTPS</code> のデフォルト: <code>GET</code>。 <code>type</code> <code>TCP</code> のデフォルト: <code>connection_established</code></td>
  </tr>
  <tr>
  <td><code>--path &lt;path&gt;</code></td>
  <td><code>type</code> が <code>HTTPS</code> の場合: ヘルス・チェック対象のエンドポイント・パス。 デフォルト: <code>/</code></td>
  </tr>
  <tr>
  <td><code>--timeout &lt;timeout&gt;</code></td>
  <td>IP が正常でないと見なされるまでのタイムアウト (秒)。 デフォルト: <code>5</code></td>
  </tr>
  <tr>
  <td><code>--retries &lt;retries&gt;</code></td>
  <td>タイムアウトが発生したときに、IP が正常でないと見なされるまでに再試行する回数。 再試行は即時に実行されます。 デフォルト: <code>2</code></td>
  </tr>
  <tr>
  <td><code>--interval &lt;interval&gt;</code></td>
  <td>各ヘルス・チェックの間隔 (秒)。 間隔を短くすると、フェイルオーバーの時間が改善される場合がありますが、IP の負荷が増える場合があります。 デフォルト: <code>60</code></td>
  </tr>
  <tr>
  <td><code>--port &lt;port&gt;</code></td>
  <td>ヘルス・チェックのために接続するポート番号。 <code>type</code> が <code>TCP</code> の場合、このパラメーターは必須です。 <code>type</code> が <code>HTTP</code> または <code>HTTPS</code> の場合、80 (HTTP の場合) または 443 (HTTPS の場合) 以外のポートを使用する場合にのみポートを定義します。 TCP のデフォルト: <code>0</code>。HTTP のデフォルト: <code>80</code>。 HTTPS のデフォルト: <code>443</code>。</td>
  </tr>
  <tr>
  <td><code>--expected-body &lt;expected-body&gt;</code></td>
  <td><code>type</code> が <code>HTTP</code> または <code>HTTPS</code> の場合: 応答本体でヘルス・チェックが検索する大/小文字を区別しないサブストリング。 このストリングが検出されない場合、IP が正常でないと見なされます。</td>
  </tr>
  <tr>
  <td><code>--expected-codes &lt;expected-codes&gt;</code></td>
  <td><code>type</code> が <code>HTTP</code> または <code>HTTPS</code> の場合: 応答内でヘルス・チェックが検索する HTTP コード。 HTTP コードが検出されない場合、IP が正常でないと見なされます。 デフォルト: <code>2xx</code></td>
  </tr>
  <tr>
  <td><code>--allows-insecure &lt;true&gt;</code></td>
  <td><code>type</code> が <code>HTTP</code> または <code>HTTPS</code> の場合: 証明書を検証しない場合は <code>true</code> に設定します。</td>
  </tr>
  <tr>
  <td><code>--follows-redirects &lt;true&gt;</code></td>
  <td><code>type</code> が <code>HTTP</code> または <code>HTTPS</code> の場合: IP によって返されたリダイレクトに従う場合は <code>true</code> に設定します。</td>
  </tr>
  </tbody>
  </table>

  コマンド例:
  ```
  ibmcloud ks nlb-dns-monitor-configure --cluster mycluster --nlb-host mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud --enable --desc "Login page monitor" --type HTTPS --method GET --path / --timeout 5 --retries 2 --interval 60 --expected-body "healthy" --expected-codes 2xx --follows-redirects true
  ```
  {: pre}

3. ヘルス・チェック・モニターが正しい設定を使用して構成されていることを確認します。
  ```
  ibmcloud ks nlb-dns-monitor-get --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  出力例:
  ```
  <placeholder - still want to test this one>
  ```
  {: screen}

4. ご使用のホスト名の NLB IP のヘルス・チェックの状況を表示します。
  ```
  ibmcloud ks nlb-dns-monitor-status --cluster <cluster_name_or_id> --nlb-host <host_name>
  ```
  {: pre}

  出力例:
  ```
  Hostname                                                                                IP          Health Monitor   H.Monitor Status
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     168.2.4.5   Enabled          Healthy
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     88.2.4.5    Enabled          Healthy
  ```
  {: screen}

</br>

### ホスト名の IP およびモニターの更新と削除
{: #loadbalancer_hostname_delete}

生成したホスト名の NLB IP アドレスを追加および削除できます。 また、必要に応じてホスト名のヘルス・チェック・モニターを無効および有効にすることができます。
{: shortdesc}

**NLB IP**

後でクラスターの他のゾーン内にさらに NLB を追加して同じアプリを公開する場合は、既存のホスト名に NLB IP を追加できます。 追加する各 IP アドレスに対して以下のコマンドを実行する必要があります。
```
ibmcloud ks nlb-dns-add --cluster <cluster_name_or_id> --ip <IP_address> --nlb-host <host_name>
```
{: pre}

ホスト名に登録する必要がなくなった NLB の IP アドレスを削除することもできます。 削除する各 IP アドレスに対して以下のコマンドを実行する必要があります。 ホスト名からすべての IP を削除してもホスト名は引き続き存在しますが、そのホスト名に関連付けられている IP はなくなります。
```
ibmcloud ks nlb-dns-rm --cluster <cluster_name_or_id> --ip <ip1,ip2> --nlb-host <host_name>
```
{: pre}

</br>

**ヘルス・チェック・モニター**

ヘルス・モニターの構成を変更する必要がある場合は、特定の設定を変更できます。 変更する設定のフラグのみを含めます。
```
ibmcloud ks nlb-dns-monitor-configure --cluster <cluster_name_or_id> --nlb-host <host_name> --desc <description> --type <type> --method <method> --path <path> --timeout <timeout> --retries <retries> --interval <interval> --port <port> --expected-body <expected-body> --expected-codes <expected-codes> --follows-redirects <true> --allows-insecure <true>
```
{: pre}

ホスト名のヘルス・チェック・モニターは、以下のコマンドを実行していつでも無効にできます。
```
ibmcloud ks nlb-dns-monitor-disable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}

ホスト名のモニターを再度有効にするには、以下のコマンドを実行します。
```
ibmcloud ks nlb-dns-monitor-enable --cluster <cluster_name_or_id> --nlb-host <host_name>
```
{: pre}
