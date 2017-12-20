---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Ingress のアノテーション
{: #ingress_annotation}

Ingress コントローラーに機能を追加するため、Ingress リソースにメタデータとしてアノテーションを指定できます。
{: shortdesc}

Ingress サービスとその使用開始方法に関する一般情報については、[Ingress コントローラーを使用してアプリへのパブリック・アクセスを構成する方法](cs_apps.html#cs_apps_public_ingress)を参照してください。


|サポートされるアノテーション|説明|
|--------------------|-----------|
|[クライアント要求またはクライアント応答の追加ヘッダー](#proxy-add-headers)|クライアント要求をバックエンド・アプリに転送する前に要求にヘッダー情報を追加します。または、クライアント応答をクライアントに送信する前に応答にヘッダー情報を追加します。|
|[クライアント応答データのバッファリング](#proxy-buffering)|クライアントに応答を送信する間、Ingress コントローラーでのクライアント応答バッファリングを無効にします。|
|[クライアント応答ヘッダーの削除](#response-remove-headers)|クライアント応答をクライアントに転送する前に、応答からヘッダー情報を削除します。|
|[接続タイムアウトおよび読み取りタイムアウトのカスタマイズ](#proxy-connect-timeout)|バックエンド・アプリを使用不可と見なすまで、バックエンド・アプリへの接続およびバックエンド・アプリからの読み取りを Ingress コントローラーが待機する時間を調整します。|
|[カスタムの HTTP および HTTPS ポート](#custom-port)|HTTP および HTTPS ネットワーク・トラフィック用のデフォルト・ポートを変更します。|
|[クライアント要求本体の最大サイズのカスタマイズ](#client-max-body-size)|Ingress コントローラーに送信可能なクライアント要求本体のサイズを調整します。|
|[外部サービス](#proxy-external-service)|{{site.data.keyword.Bluemix_notm}} でホストされるサービスなどの外部サービスへのパスの定義を追加します。|
|[グローバルな速度制限](#global-rate-limit)|すべてのサービスに対して、定義済みキーあたりの要求処理速度と接続数を制限します。|
|[HTTPS への HTTP リダイレクト](#redirect-to-https)|ドメイン上の非セキュアな HTTP 要求を HTTPS にリダイレクトします。|
|[キープアライブ要求数](#keepalive-requests)|1 つのキープアライブ接続で処理できる要求の最大数を構成します。|
|[キープアライブ・タイムアウト](#keepalive-timeout)|キープアライブ接続がサーバー上で開いた状態を保つ時間を構成します。|
|[相互認証](#mutual-auth)|Ingress コントローラーの相互認証を構成します。|
|[プロキシー・バッファー](#proxy-buffers)|プロキシー・サーバーからの単一の接続に対して、応答の読み取りに使用されるバッファーの数とサイズを設定します。|
|[プロキシー・ビジー・バッファー・サイズ](#proxy-busy-buffers-size)|クライアントへの応答がまだ全部読み取られていない間にその応答の送信でビジー状態にすることができるバッファー群の合計サイズを制限します。|
|[プロキシー・バッファー・サイズ](#proxy-buffer-size)|プロキシー・サーバーから受け取る応答の最初の部分を読み取るために使用されるバッファーのサイズを設定します。|
|[再書き込みパス](#rewrite-path)|着信ネットワーク・トラフィックを、バックエンド・アプリが listen する別のパスにルーティングします。|
|[Cookie によるセッション・アフィニティー](#sticky-cookie-services)|スティッキー Cookie を使用して、着信ネットワーク・トラフィックを常に同じアップストリーム・サーバーにルーティングします。|
|[サービスの速度制限](#service-rate-limit)|特定のサービスに対して、定義済みキーあたりの要求処理速度と接続数を制限します。|
|[SSL サービス・サポート](#ssl-services)|ロード・バランシングに対する SSL サービス・サポートを許可します。|
|[TCP ポート](#tcp-ports)|標準以外の TCP ポートを介してアプリにアクセスします。|
|[アップストリーム・キープアライブ](#upstream-keepalive)|アップストリーム・サーバーのアイドル・キープアライブ接続の最大数を構成します。|






## クライアント要求またはクライアント応答の追加ヘッダー (proxy-add-headers)
{: #proxy-add-headers}

クライアント要求をバックエンド・アプリに送信する前に要求にさらにヘッダー情報を追加します。または、クライアント応答をクライアントに送信する前に応答にさらにヘッダー情報を追加します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラーは、クライアント・アプリとバックエンド・アプリの間のプロキシーとして機能します。 Ingress コントローラーに送信されたクライアント要求は、処理 (プロキシー処理) され、新しい要求に入れられた後に、Ingress コントローラーからバックエンド・アプリに送信されます。 クライアントから最初に送信された HTTP ヘッダー情報 (ユーザー名など) は、要求のプロキシー処理で削除されます。 そのような情報がバックエンド・アプリに必要な場合は、<strong>ingress.bluemix.net/proxy-add-headers</strong> アノテーションを使用して、Ingress コントローラーからバックエンド・アプリにクライアント要求を転送する前に、ヘッダー情報を要求に追加することができます。

</br></br>
バックエンド・アプリが応答をクライアントに送信する場合は、応答が Ingress コントローラーによってプロキシー処理され、HTTP ヘッダーが応答から削除されます。 クライアント Web アプリで応答を正常に処理するために、このヘッダー情報が必要になる場合があります。 <strong>ingress.bluemix.net/response-add-headers</strong> アノテーションを使用すると、Ingress コントローラーからクライアント Web アプリにクライアント応答を転送する前に、ヘッダー情報を応答に追加することができます。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: アプリ用に作成した Kubernetes サービスの名前。</li>
  <li><code><em>&lt;header&gt;</em></code>: クライアント要求またはクライアント応答に追加するヘッダー情報のキー。</li>
  <li><code><em>&lt;value&gt;</em></code>: クライアント要求またはクライアント応答に追加するヘッダー情報の値。</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## クライアント応答データのバッファリング (proxy-buffering)
 {: #proxy-buffering}

 バッファー・アノテーションを使用すると、クライアントにデータを送信する間、Ingress コントローラーでの応答データの保存を無効にできます。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>Ingress コントローラーは、バックエンド・アプリとクライアント Web ブラウザーの間のプロキシーとして機能します。 応答がバックエンド・アプリからクライアントに送信されると、デフォルトでは、応答データが Ingress コントローラーのバッファーに入れられます。 Ingress コントローラーは、クライアント応答をプロキシー処理し、クライアントのペースでクライアントに応答を送信し始めます。 バックエンド・アプリからのすべてのデータを Ingress コントローラーが受信すると、バックエンド・アプリへの接続は閉じられます。 Ingress コントローラーからクライアントへの接続は、クライアントがすべてのデータを受信するまで開いたままです。

 </br></br>
 Ingress コントローラーでの応答データのバッファリングを無効にすると、データは即時に Ingress コントローラーからクライアントに送信されます。 クライアントが、Ingress コントローラーのペースで着信データを処理できなければなりません。 クライアントの処理速度が遅すぎる場合は、データが失われる可能性があります。
 </br></br>
 Ingress コントローラーでの応答データのバッファリングは、デフォルトでは有効です。</dd>
 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/proxy-buffering: "False"
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
 </dd></dl>

<br />


 ## クライアント応答ヘッダーの削除 (response-remove-headers)
 {: #response-remove-headers}

バックエンド・アプリからのクライアント応答に含まれているヘッダー情報を削除してから、クライアントに応答を送信します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>Ingress コントローラーは、バックエンド・アプリとクライアント Web ブラウザーの間のプロキシーとして機能します。 Ingress コントローラーに送信されたバックエンド・アプリからのクライアント応答は、処理 (プロキシー処理) され、新しい応答に入れられた後に、Ingress コントローラーからクライアント Web ブラウザーに送信されます。 応答のプロキシー処理によって、バックエンド・アプリから最初に送信された HTTP ヘッダー情報は削除されますが、バックエンド・アプリに固有のヘッダーが削除されずに残る場合があります。 Ingress コントローラーからクライアント Web ブラウザーにクライアント応答を転送する前に、応答からヘッダー情報を削除します。</dd>
 <dt>サンプル Ingress リソース YAML</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;service_name1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;service_name2&gt; {
       "&lt;header3&gt;";
       }
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
       - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>以下の値を置き換えます。<ul>
   <li><code><em>&lt;service_name&gt;</em></code>: アプリ用に作成した Kubernetes サービスの名前。</li>
   <li><code><em>&lt;header&gt;</em></code>: クライアント応答から削除するヘッダーのキー。</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## 接続タイムアウトおよび読み取りタイムアウトのカスタマイズ (proxy-connect-timeout、proxy-read-timeout)
{: #proxy-connect-timeout}

Ingress コントローラーの接続タイムアウトおよび読み取りタイムアウトをカスタマイズします。 バックエンド・アプリを使用不可と見なすまでに、バックエンド・アプリへの接続およびバックエンド・アプリからの読み取りを Ingress コントローラーが待機する時間を調整します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>クライアント要求が Ingress コントローラーに送信されると、Ingress コントローラーはバックエンド・アプリへの接続を開きます。 デフォルトでは、Ingress コントローラーはバックエンド・アプリからの応答を受信するまで 60 秒待機します。 バックエンド・アプリが 60 秒以内に応答しない場合は、接続要求が中止され、バックエンド・アプリは使用不可と見なされます。

</br></br>
Ingress コントローラーがバックエンド・アプリに接続されると、応答データは Ingress コントローラーによってバックエンド・アプリから読み取られます。 この読み取り操作では、Ingress コントローラーはバックエンド・アプリからのデータを受け取るために、2 回の読み取り操作の間に最大 60 秒間待機します。 バックエンド・アプリが 60 秒以内にデータを送信しない場合、バックエンド・アプリへの接続が閉じられ、アプリは使用不可と見なされます。
</br></br>
60 秒の接続タイムアウトと読み取りタイムアウトは、プロキシー上のデフォルトのタイムアウトであり、通常は変更すべきではありません。
</br></br>
アプリの可用性が安定していない場合や、ワークロードが多いためにアプリの応答が遅い場合は、接続タイムアウトまたは読み取りタイムアウトを引き上げることもできます。 タイムアウトを引き上げると、タイムアウトになるまでバックエンド・アプリへの接続を開いている必要があるため、Ingress コントローラーのパフォーマンスに影響が及ぶことに注意してください。
</br></br>
一方、タイムアウトを下げると、Ingress コントローラーのパフォーマンスは向上します。 ワークロードが多いときでも、指定したタイムアウト内でバックエンド・アプリが要求を処理できるようにしてください。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
   ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>以下の値を置き換えます。<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: バックエンド・アプリへの接続で待機する秒数を入力します (例: <strong>65s</strong>)。

 </br></br>
 <strong>注:</strong> 接続タイムアウトは、75 秒より長くできません。</li><li><code><em>&lt;read_timeout&gt;</em></code>: バックエンド・アプリから読み取る前に待機する秒数を入力します (例: <strong>65s</strong>)。</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## カスタムの HTTP ポートおよび HTTPS ポート (custom-port)
{: #custom-port}

HTTP (ポート 80) および HTTPS (ポート 443) ネットワーク・トラフィックのデフォルト・ポートを変更します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>デフォルトで、Ingress コントローラーは、ポート 80 上の着信 HTTP ネットワーク・トラフィックとポート 443 上の着信 HTTPS ネットワーク・トラフィックを listen するように構成されています。 Ingress コントローラー・ドメインのセキュリティーを強化するため、または HTTPS ポートだけを有効にするために、デフォルト・ポートを変更できます。
</dd>


<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/custom-port: "protocol=&lt;protocol1&gt; port=&lt;port1&gt;;protocol=&lt;protocol2&gt;port=&lt;port2&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>以下の値を置き換えます。<ul>
 <li><code><em>&lt;protocol&gt;</em></code>: 着信 HTTP または HTTPS ネットワーク・トラフィックのデフォルト・ポートを変更するには、<strong>http</strong> または <strong>https</strong> を入力します。</li>
 <li><code><em>&lt;port&gt;</em></code>: 着信 HTTP または HTTPS ネットワーク・トラフィック用に使用するポート番号を入力します。</li>
 </ul>
 <p><strong>注:</strong> HTTP または HTTPS 用にカスタム・ポートを指定した場合、デフォルト・ポートは、HTTP と HTTPS のどちらに対しても有効ではなくなります。 例えば、HTTPS のデフォルト・ポートを 8443 に変更し、HTTP ではデフォルト・ポートを使用する場合、それらの両方に対して次のようにカスタム・ポートを設定する必要があります。<code>custom-port: "protocol=http port=80; protocol=https port=8443"</code></p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>使用法</dt>
 <dd><ol><li>Ingress コントローラー用の開かれたポートを確認します。 **注: IP アドレスは generic doc IP アドレスである必要があります。 ターゲットの kubectl cli にリンクする必要もありますか? 必要ない場合もあります。**
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 出力は、以下のようになります。
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>Ingress コントローラーの構成マップを開きます。
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>非デフォルトの HTTP および HTTPS ポートを構成マップに追加します。 &lt;port&gt; を、開く HTTP または HTTPS のポートに置き換えます。
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
data:
 public-ports: &lt;port1&gt;;&lt;port2&gt;
metadata:
 creationTimestamp: 2017-08-22T19:06:51Z
 name: ibm-cloud-provider-ingress-cm
 namespace: kube-system
 resourceVersion: "1320"
 selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
 uid: &lt;uid&gt;</code></pre></li>
 <li>Ingress コントローラーが非デフォルトのポートによって再構成されたことを確認します。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 出力は、以下のようになります。
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>着信ネットワーク・トラフィックをサービスにルーティングする際に、非デフォルトのポートを使用するように Ingress を構成します。 この解説ではサンプル YAML ファイルを使用します。 </li>
<li>Ingress コントローラー構成を更新します。
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>任意の Web ブラウザーを開いてアプリにアクセスします。 例: <code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />


## クライアント要求本体の最大サイズのカスタマイズ (client-max-body-size)
{: #client-max-body-size}

クライアントが要求の一部として送信できる本体の最大サイズを調整します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>必要なパフォーマンスを維持するため、クライアント要求本体の最大サイズは 1 M バイトに設定されています。 本体サイズがこの制限を超えるクライアント要求が Ingress コントローラーに送信された場合、データを分割することをクライアントが許可していなければ、Ingress コントローラーは http 応答 413 (要求エンティティーが大き過ぎる) をクライアントに返します。 要求本体のサイズが小さくなるまで、クライアントと Ingress コントローラーの間の接続は確立されません。 データを複数のチャンクに分割することをクライアントが許可した場合は、データが 1 M バイトの複数のパッケージに分割されて、Ingress コントローラーに送信されます。

</br></br>
本体サイズが 1 M バイトを超えるクライアント要求が想定されるために、最大本体サイズを引き上げたい場合があります。 例えば、クライアントが大きなファイルをアップロードできるようにしたい場合があります。 要求本体の最大サイズを引き上げると、要求を受信するまでクライアントへの接続を開いておかなければならないため、Ingress コントローラーのパフォーマンスに影響を及ぼす可能性があります。
</br></br>
<strong>注:</strong> 一部のクライアント Web ブラウザーは、http 応答 413 のメッセージを正しく表示できません。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
 name: myingress
 annotations:
   ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
 tls:
 - hosts:
   - mydomain
    secretName: mytlssecret
  rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>以下の値を置き換えます。<ul>
 <li><code><em>&lt;size&gt;</em></code>: クライアント応答本体の最大サイズを入力します。 例えば、200 M バイトに設定するには、<strong>200m</strong> と定義します。

 </br></br>
 <strong>注:</strong> サイズを 0 に設定すると、クライアント要求の本体サイズの検査を無効にすることができます。</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<ここに戻る>

## 外部サービス (proxy-external-service)
{: #proxy-external-service}
{{site.data.keyword.Bluemix_notm}} でホストされるサービスなどの外部サービスへのパス定義を追加します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>外部サービスへのパス定義を追加します。 このアノテーションは特殊な用途で使用されます。つまり、バックエンド・サービスに対して作用するのではなく、外部サービスに対して機能します。 client-max-body-size、proxy-read-timeout、proxy-connect-timeout、proxy-buffering 以外のアノテーションは、外部サービス経路ではサポートされません。
</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: cafe-ingress
  annotations:
    ingress.bluemix.net/proxy-external-service: "path=&lt;path&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
spec:
  tls:
  - hosts:
    - &lt;mydomain&gt;
    secretName: mysecret
  rules:
  - host: &lt;mydomain&gt;
    http:
      paths:
      - path: &lt;path&gt;
        backend:
          serviceName: myservice
          servicePort: 80
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>以下の値を置き換えます。
 <ul>
 <li><code><em>&lt;external_service&gt;</em></code>: 呼び出される外部サービスを入力します。 例えば、https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net を入力します。</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## グローバルな速度制限 (global-rate-limit)
{: #global-rate-limit}

すべてのサービスに対して、Ingress マッピング内のすべてのホストに使用される単一の IP アドレスから渡される定義済みキーあたりの要求処理速度と接続数を制限します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>
制限を設定するために、`ngx_http_limit_conn_module` と `ngx_http_limit_req_module` でゾーンを定義します。 これらのゾーンは、Ingress マッピング内の各ホストに対応するサーバー・ブロックに適用されます。
</dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/global-rate-limit: "key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;key&gt;</em></code>: ロケーションまたはサービスに基づいて着信要求のグローバル制限を設定するには、`key=location` を使用します。 ヘッダーに基づいて着信要求のグローバル制限を設定するには、`X-USER-ID key==$http_x_user_id` を使用します。</li>
  <li><code><em>&lt;rate&gt;</em></code>: 速度。</li>
  <li><code><em>&lt;conn&gt;</em></code>: 接続数。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## HTTPS への HTTP リダイレクト (redirect-to-https)
 {: #redirect-to-https}

 非セキュア HTTP クライアント要求を HTTPS に変換します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>Ingress コントローラーは、IBM 提供の TLS 証明書またはカスタム TLS 証明書を使用してドメインを保護するようにセットアップされます。 一部のユーザーが、Ingress コントローラー・ドメインへの非セキュアな HTTP 要求、例えば、<code>https</code> ではなく <code>http://www.myingress.com</code> を使用してアプリにアクセスしようとする可能性があります。 リダイレクト・アノテーションを使用すると、非セキュアな HTTP 要求を常に HTTPS に変換できます。 このアノテーションを使用しない場合、デフォルトでは非セキュアな HTTP 要求は HTTPS 要求に変換されないので、暗号化されていない機密情報が公開されてしまうおそれがあります。

 </br></br>
 HTTP 要求の HTTPS へのリダイレクトはデフォルトで無効です。</dd>
 <dt>サンプル Ingress リソース YAML</dt>
<dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/redirect-to-https: "True"
 spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
 </dd></dl>

<br />




 <br />

 
 ## キープアライブ要求数 (keepalive-requests)
 {: #keepalive-requests}

 1 つのキープアライブ接続で処理できる要求の最大数を構成します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>
 1 つのキープアライブ接続で処理できる要求の最大数を設定します。
 </dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/keepalive-requests: "serviceName=&lt;service_name&gt; requests=&lt;max_requests&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: <em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。 このパラメーターはオプションです。 特定のサービスが指定されていなければ、Ingress ホスト内のすべてのサービスにこの構成が適用されます。 このパラメーターを指定した場合は、所定のサービスに対してキープアライブ要求が設定されます。 パラメーターを指定しない場合は、キープアライブ要求が構成されていないすべてのサービスに対して、サーバー・レベルの <code>nginx.conf</code> でキープアライブ要求が設定されます。</li>
  <li><code><em>&lt;requests&gt;</em></code>: <em>&lt;max_requests&gt;</em> を、1 つのキープアライブ接続で処理できる要求の最大数に置き換えます。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## キープアライブ・タイムアウト (keepalive-timeout)
 {: #keepalive-timeout}

  キープアライブ接続がサーバー・サイドで開いた状態を保つ時間を構成します。
  {:shortdesc}

  <dl>
  <dt>説明</dt>
  <dd>
  キープアライブ接続がサーバー上で開いた状態を保つ時間を設定します。
  </dd>


  <dt>サンプル Ingress リソース YAML</dt>
  <dd>

  <pre class="codeblock">
  <code>apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;service_name&gt; timeout=&lt;time&gt;s"
  spec:
   tls:
   - hosts:
     - mydomain
    secretName: mytlssecret
  rules:
   - host: mydomain
    http:
      paths:
       - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>以下の値を置き換えます。<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>: <em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。 このパラメーターはオプションです。 このパラメーターを指定した場合は、所定のサービスに対してキープアライブ・タイムアウトが設定されます。 パラメーターを指定しない場合は、キープアライブ・タイムアウトが構成されていないすべてのサービスに対して、サーバー・レベルの <code>nginx.conf</code> でキープアライブ・タイムアウトが設定されます。</li>
   <li><code><em>&lt;timeout&gt;</em></code>: <em>&lt;time&gt;</em> を時間の長さ (秒単位) に置き換えます。 例:<code><em>timeout=20s</em></code>。 値をゼロに設定すると、キープアライブ・クライアント接続が無効になります。</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## 相互認証 (mutual-auth)
 {: #mutual-auth}

 Ingress コントローラーの相互認証を構成します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>
 Ingress コントローラーの相互認証を構成します。 クライアントはサーバーを認証し、サーバーもクライアントを認証します。どちらも証明書が使用されます。 相互認証は、証明書ベース認証とも双方向認証とも呼ばれます。
 </dd>

 <dt>前提条件</dt>
 <dd>
 <ul>
 <li>[必要な認証局 (CA) を含んだ有効なシークレットが必要です](cs_apps.html#secrets)。 相互認証で認証するためには、<code>client.key</code> と <code>client.crt</code> も必要です。</li>
 <li>443 以外のポートでの相互認証を有効にするには、[ロード・バランサーを構成して有効なポートを開きます](cs_apps.html#opening_ingress_ports)。</li>
 </ul>
 </dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/mutual-auth: "port=&lt;port&gt; secretName=&lt;secretName&gt; serviceName=&lt;service1&gt;,&lt;service2&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: 1 つ以上の Ingress リソースの名前。 このパラメーターはオプションです。</li>
  <li><code><em>&lt;secretName&gt;</em></code>: <em>&lt;secret_name&gt;</em> を、シークレット・リソースの名前に置き換えます。</li>
  <li><code><em>&lt;port&gt;</em></code>: ポート番号を入力します。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## プロキシー・バッファー (proxy-buffers)
 {: #proxy-buffers}
 
 Ingress コントローラー用のプロキシー・バッファーを構成します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>
 プロキシー・サーバーからの単一の接続に対して、応答の読み取りに使用されるバッファーの数とサイズを設定します。 特定のサービスが指定されていなければ、Ingress ホスト内のすべてのサービスにこの構成が適用されます。 例えば、<code>serviceName=SERVICE number=2 size=1k</code> という構成を指定した場合は、サービスに 1k が適用されます。 <code>number=2 size=1k</code> という構成を指定した場合は、Ingress ホスト内のすべてのサービスに 1k が適用されます。
 </dd>
 <dt>サンプル Ingress リソース YAML</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffers: "serviceName=&lt;service_name&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。
  <ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: <em>&lt;serviceName&gt;</em> を、proxy-buffers を適用するサービスの名前に置き換えます。 </li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code>: <em>&lt;number_of_buffers&gt;</em> を、<em>2</em> などの数値に置き換えます。</li>
  <li><code><em>&lt;size&gt;</em></code>: 各バッファーのサイズをキロバイト (k または K) 単位で入力します (例えば <em>1K</em>)。</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## プロキシー・ビジー・バッファー・サイズ (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 Ingress コントローラー用のプロキシー・ビジー・バッファー・サイズを構成します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>
 プロキシー・サーバーからの応答のバッファリングが有効になっている場合、クライアントへの応答がまだ全部読み取られていない間にその応答の送信でビジー状態にすることができるバッファー群の合計サイズを制限します。 その間、残りのバッファーを応答の読み取りに使用することができます。必要であれば、残りのバッファーを使用して応答の一部を一時ファイルにバッファリングすることもできます。 特定のサービスが指定されていなければ、Ingress ホスト内のすべてのサービスにこの構成が適用されます。 例えば、<code>serviceName=SERVICE size=1k</code> という構成を指定した場合は、サービスに 1k が適用されます。 <code>size=1k</code> という構成を指定した場合は、Ingress ホスト内のすべてのサービスに 1k が適用されます。
 </dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: <em>&lt;serviceName&gt;</em> を、proxy-busy-buffers-size を適用するサービスの名前に置き換えます。</li>
  <li><code><em>&lt;size&gt;</em></code>: 各バッファーのサイズをキロバイト (k または K) 単位で入力します (例えば <em>1K</em>)。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## プロキシー・バッファー・サイズ (proxy-buffer-size)
 {: #proxy-buffer-size}

 Ingress コントローラー用のプロキシー・バッファー・サイズを構成します。
 {:shortdesc}

 <dl>
 <dt>説明</dt>
 <dd>
 プロキシー・サーバーから受け取る応答の最初の部分を読み取るために使用されるバッファーのサイズを設定します。 応答のこの部分には通常、短い応答ヘッダーが含まれています。 特定のサービスが指定されていなければ、Ingress ホスト内のすべてのサービスにこの構成が適用されます。 例えば、<code>serviceName=SERVICE size=1k</code> という構成を指定した場合は、サービスに 1k が適用されます。 <code>size=1k</code> という構成を指定した場合は、Ingress ホスト内のすべてのサービスに 1k が適用されます。
 </dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080
 </code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: <em>&lt;serviceName&gt;</em> を、proxy-busy-buffers-size を適用するサービスの名前に置き換えます。</li>
  <li><code><em>&lt;size&gt;</em></code>: 各バッファーのサイズをキロバイト (k または K) 単位で入力します (例えば <em>1K</em>)。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## 再書き込みパス (rewrite-path)
{: #rewrite-path}

Ingress コントローラー・ドメイン・パスへの着信ネットワーク・トラフィックを、バックエンド・アプリケーションが listen する別のパスにルーティングできます。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラー・ドメインは、<code>mykubecluster.us-south.containers.mybluemix.net/beans</code> への着信ネットワーク・トラフィックをアプリにルーティングします。 アプリは、<code>/beans</code> ではなく <code>/coffee</code> で listen します。 着信ネットワーク・トラフィックをアプリに転送するには、Ingress リソース構成ファイルに再書き込みアノテーションを追加します。 再書き込みアノテーションにより、<code>/beans</code> 上の着信ネットワーク・トラフィックは <code>/coffee</code> パスを使用してアプリに転送されるようになります。 複数のサービスを含める場合は、セミコロン (;) のみを使用して区切ってください。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;target_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: &lt;mytlssecret&gt;
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td><em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。さらに、<em>&lt;target-path&gt;</em> を、アプリが listen するパスに置き換えます。 Ingress コントローラー・ドメイン上の着信ネットワーク・トラフィックは、このパスを使用して Kubernetes サービスに転送されます。 大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合は、<code>/</code> をアプリの <em>rewrite-path</em> として定義します。</td>
</tr>
<tr>
<td><code>path</code></td>
<td><em>&lt;domain_path&gt;</em> を、Ingress コントローラー・ドメインに付加するパスに置き換えます。 このパス上の着信ネットワーク・トラフィックは、アノテーションで定義した再書き込みパスに転送されます。 上記の例では、ドメイン・パスを <code>/beans</code> に設定して、このパスを Ingress コントローラーのロード・バランシングに含めます。</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td><em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。 ここで使用するサービス名は、アノテーションで定義したものと同じ名前でなければなりません。</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td><em>&lt;service_port&gt;</em> を、サービスが listen するポートに置き換えます。</td>
</tr></tbody></table>

</dd></dl>

<br />


## サービスの速度制限 (service-rate-limit)
{: #service-rate-limit}

特定のサービスに対して、選択したバックエンドのすべてのパスに使用される単一の IP アドレスから渡される定義済みキーあたりの要求処理速度と接続数を制限します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>
制限を設定するために、Ingress マッピング内のアノテーションでターゲットになっているすべてのサービスに対応するすべてのロケーション・ブロックで、`ngx_http_limit_conn_module` と `ngx_http_limit_req_module` によって定義されたゾーンが適用されます。 </dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;service_name&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Ingress リソースの名前。</li>
  <li><code><em>&lt;key&gt;</em></code>: ロケーションまたはサービスに基づいて着信要求のグローバル制限を設定するには、`key=location` を使用します。 ヘッダーに基づいて着信要求のグローバル制限を設定するには、`X-USER-ID key==$http_x_user_id` を使用します。</li>
  <li><code><em>&lt;rate&gt;</em></code>: 速度。</li>
  <li><code><em>&lt;conn&gt;</em></code>: 接続数。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## Cookie によるセッション・アフィニティー (sticky-cookie-services)
{: #sticky-cookie-services}

スティッキー Cookie のアノテーションを使用すると、セッション・アフィニティーを Ingress コントローラーに追加し、常に着信ネットワーク・トラフィックを同じアップストリーム・サーバーにルーティングできます。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>高可用性にするためには、アプリのセットアップによっては、着信クライアント要求を処理する複数のアップストリーム・サーバーをデプロイする必要があります。 クライアントがバックエンド・アプリに接続したら、セッション期間中またはタスクが完了するまでの間、1 つのクライアントに同じアップストリーム・サーバーがサービスを提供するように、セッション・アフィニティーを使用することができます。 着信ネットワーク・トラフィックを常に同じアップストリーム・サーバーにルーティングしてセッション・アフィニティーを保つように、Ingress コントローラーを構成することができます。

</br></br>
バックエンド・アプリに接続した各クライアントは、Ingress コントローラーによって、使用可能なアップストリーム・サーバーのいずれかに割り当てられます。 Ingress コントローラーは、クライアントのアプリに保管されるセッション Cookie を作成します。そのセッション Cookie は、Ingress コントローラーとクライアントの間でやり取りされるすべての要求のヘッダー情報に含められます。 この Cookie の情報により、同一セッションのすべての要求を同じアップストリーム・サーバーで処理することができます。

</br></br>
複数のサービスを含める場合は、セミコロン (;) を使用して区切ってください。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>YAML ファイルの構成要素について</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: アプリ用に作成した Kubernetes サービスの名前。</li>
  <li><code><em>&lt;cookie_name&gt;</em></code>: セッション中に作成されたスティッキー Cookie の名前を選択します。</li>
  <li><code><em>&lt;expiration_time&gt;</em></code>: スティッキー Cookie の有効期間 (秒、分、または時間単位)。 この時間は、ユーザー・アクティビティーとは無関係です。 期限が切れた Cookie は、クライアント Web ブラウザーによって削除され、Ingress コントローラーに送信されなくなります。 例えば、有効期間を 1 秒、1 分、または 1 時間に設定するには、<strong>1s</strong>、<strong>1m</strong>、または <strong>1h</strong> と入力します。</li>
  <li><code><em>&lt;cookie_path&gt;</em></code>: Ingress サブドメインに付加されるパス。Cookie を Ingress コントローラーに送信するドメインとサブドメインを示します。 例えば、Ingress ドメインが <code>www.myingress.com</code> である場合に、すべてのクライアント要求で Cookie を送信するには、<code>path=/</code> を設定する必要があります。 <code>www.myingress.com/myapp</code> とそのすべてのサブドメインについてにのみ Cookie を送信するには、<code>path=/myapp</code> を設定する必要があります。</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code>: Cookie の情報を保護するハッシュ・アルゴリズム。 <code>sha1</code> のみサポートされます。 SHA1 は、Cookie の情報に基づいてハッシュ合計を生成し、そのハッシュ合計を Cookie に付加します。 サーバーは Cookie の情報を暗号化解除し、データ保全性を検証します。
  </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## SSL サービス・サポート (ssl-services)
{: #ssl-services}

HTTPS 要求を許可し、アップストリーム・アプリへのトラフィックを暗号化します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>
Ingress コントローラーとの間に HTTPS を必要とするアップストリーム・アプリへのトラフィックを暗号化します。

**オプション**: このアノテーションに[片方向認証または相互認証](#ssl-services-auth)を追加できます。
</dd>


<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: ssl-service=&lt;service1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;service2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
spec:
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;myservice&gt;</em></code>: アプリを表すサービスの名前を入力します。 Ingress コントローラーからこのアプリへのトラフィックは暗号化されます。</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>: サービスのシークレットを入力します。 このパラメーターはオプションです。 このパラメーターを指定した場合は、アプリが必要とするクライアントの鍵と証明書が値に含まれていなければなりません。  </li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。
  <br><br>
  <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに * を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td><em>&lt;myservicepath&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

  </br>
  Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

  </br></br>
  多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。
  </br>
  例: <ul><li><code>http://ingress_host_name/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://ingress_host_name/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
  </br>
  <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成するには、<a href="#rewrite-path" target="_blank">再書き込みアノテーション</a>を使用してアプリへの適切なルーティングを設定します。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td><em>&lt;myservice&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### 認証を使用する SSL サービス・サポート
{: #ssl-services-auth}

HTTPS 要求を許可し、セキュリティーを強化するために片方向認証または相互認証を使用してアップストリーム・アプリへのトラフィックを暗号化します。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>
Ingress コントローラーとの間に HTTPS を必要とするロード・バランシング・アプリの相互認証を構成します。

**注**: 始めに、[証明書と鍵を base-64 に変換してください ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.base64encode.org/)。

</dd>


<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: |
      ssl-service=&lt;service1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;service2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
spec:
  tls:
  - hosts:
    - &lt;ibmdomain&gt;
    secretName: &lt;secret_name&gt;
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;service&gt;</em></code>: サービスの名前を入力します。</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code>: サービスのシークレットを入力します。</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。
  <br><br>
  <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに * を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td><em>&lt;secret_name&gt;</em> を、証明書と鍵 (相互認証の場合) を保持しているシークレットの名前に置き換えます。
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td><em>&lt;myservicepath&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

  </br>
  Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

  </br></br>
  多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。
  </br>
  例: <ul><li><code>http://ingress_host_name/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://ingress_host_name/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
  </br>
  <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成するには、<a href="#rewrite-path" target="_blank">再書き込みアノテーション</a>を使用してアプリへの適切なルーティングを設定します。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td><em>&lt;myservice&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
  </tr>
  </tbody></table>

  </dd>



<dt>片方向認証用サンプル・シークレット YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt: &lt;certificate_name&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td><em>&lt;secret_name&gt;</em> をシークレット・リソースの名前に置き換えます。</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>: 信頼証明書の名前を入力します。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>相互認証用サンプル・シークレット YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt: &lt;certificate_name&gt;
    client.crt : &lt;client_certificate_name&gt;
    client.key : &lt;certificate_key&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td><em>&lt;secret_name&gt;</em> をシークレット・リソースの名前に置き換えます。</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>: 信頼証明書の名前を入力します。</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code>: クライアント証明書の名前を入力します。</li>
  <li><code><em>&lt;certificate_key&gt;</em></code>: クライアント証明書の鍵を入力します。</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## Ingress コントローラー用 TCP ポート (tcp-ports)
{: #tcp-ports}

標準以外の TCP ポートを介してアプリにアクセスします。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>
このアノテーションは、TCP ストリーム・ワークロードを実行するアプリに使用します。

<p>**注**: Ingress コントローラーはパススルー・モードで動作し、トラフィックをバックエンド・アプリに転送します。 この場合、SSL 終端はサポートされません。</p>
</dd>


 <dt>サンプル Ingress リソース YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/tcp-ports: "serviceName=&lt;service_name&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>: アプリにアクセスするための TCP ポート。</li>
  <li><code><em>&lt;serviceName&gt;</em></code>: 標準以外の TCP ポートでアクセスする Kubernetes サービスの名前。</li>
  <li><code><em>&lt;servicePort&gt;</em></code>: このパラメーターはオプションです。 指定した場合、トラフィックがバックエンド・アプリに送信される前に、ポートはこの値に置き換えられます。 指定しない場合、ポートは Ingress ポートと同じままです。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## アップストリーム・キープアライブ (upstream-keepalive)
  {: #upstream-keepalive}

  アップストリーム・サーバーのアイドル・キープアライブ接続の最大数を構成します。
  {:shortdesc}

  <dl>
  <dt>説明</dt>
  <dd>
  所定のサービスのアップストリーム・サーバーへのアイドル・キープアライブ接続の最大数を変更します。 デフォルトでは、64 個のアイドル・キープアライブ接続がアップストリーム・サーバーに設定されています。
  </dd>


   <dt>サンプル Ingress リソース YAML</dt>
   <dd>

   <pre class="codeblock">
   <code>apiVersion: extensions/v1beta1
   kind: Ingress
   metadata:
    name: myingress
    annotations:
      ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;service_name&gt; keepalive=&lt;max_connections&gt;"
   spec:
    tls:
    - hosts:
      - mydomain
    secretName: mytlssecret
  rules:
    - host: mydomain
    http:
      paths:
        - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

   <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>annotations</code></td>
    <td>以下の値を置き換えます。<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>: <em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。</li>
    <li><code><em>&lt;keepalive&gt;</em></code>: <em>&lt;max_connections&gt;</em> を、アップストリーム・サーバーへのアイドル・キープアライブ接続の最大数に置き換えます。 デフォルトは 64 です。 値をゼロに設定すると、所定のサービスのアップストリーム・キープアライブ接続が無効になります。</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


