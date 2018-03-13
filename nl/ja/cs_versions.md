---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}} に対応した Kubernetes バージョン
{: #cs_versions}

{{site.data.keyword.containerlong}} は現在、最新バージョン、デフォルト・バージョン、サポート対象バージョン (通常は最新バージョンより 2 つ前のバージョン) という複数のバージョンの Kubernetes をサポートしています。一般にはデフォルト・バージョンは最新バージョンと同じです。クラスターの作成時または更新時には、別のバージョンを指定しない限り、デフォルト・バージョンが使用されます。{:shortdesc}

現在サポートされている Kubernetes のバージョンは以下のとおりです。

- 最新: 1.9.2
- デフォルト: 1.8.6
- サポート対象: 1.7.4

現在サポートされていないバージョンの Kubernetes でクラスターを実行している場合は、更新について[想定される影響を確認してから](#version_types)、ただちに[クラスターを更新し](cs_cluster_update.html#update)、重要なセキュリティー更新とサポートを継続して受けられるようにしてください。サーバーのバージョンを確認するには、以下のコマンドを実行します。

```
kubectl version  --short | grep -i server
```
{: pre}

出力例:

```
Server Version: 1.8.6
```
{: screen}

## 更新タイプ
{: #version_types}

Kubernetes には以下のようなバージョン更新のタイプがあります。
{:shortdesc}

|更新タイプ|バージョン・ラベルの例|更新の実行者|影響
|-----|-----|-----|-----|
|メジャー|1.x.x|お客様|スクリプトやデプロイメントを含むクラスターの操作変更。|
|マイナー|x.5.x|お客様|スクリプトやデプロイメントを含むクラスターの操作変更。|
|パッチ|x.x.3|IBM とお客様|スクリプトやデプロイメントは変更されません。 マスターは IBM が自動的に更新しますが、ワーカー・ノードへのパッチはお客様が適用する必要があります。|
{: caption="Kubernetes 更新の影響" caption-side="top"}

デフォルトでは、Kubernetes マスターを更新できるのは 2 つ先のマイナー・バージョンまでです。 例えば、現在のマスターがバージョン 1.5 であり 1.8 に更新する計画の場合、まず 1.7 に更新する必要があります。 続けて更新を強制実行することは可能ですが、2 つのマイナー・バージョンを超える更新は予期しない結果を生じることがあります。
{: tip}

以下の情報は、クラスターを前のバージョンから新しいバージョンに更新した場合に、デプロイされているアプリに影響を与える可能性がある更新についてまとめたものです。Kubernetes の各バージョンでの変更内容を示す完全なリストについては、[Kubernetes changelog ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) を参照してください。

更新処理について詳しくは、[クラスターの更新](cs_cluster_update.html#master)と[ワーカー・ノードの更新](cs_cluster_update.html#worker_node)を参照してください。

## バージョン 1.9
{: #cs_v19}



Kubernetes を前のバージョンから 1.9 に更新する場合に必要な可能性がある変更作業について説明します。

<br/>

### マスターの前に行う更新
{: #19_before}

<table summary="バージョン 1.9 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.9 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Web フックのアドミッション API</td>
<td>API サーバーがアドミッション制御 Web フックを呼び出すときに使用されるアドミッション API が、<code>admission.v1alpha1</code> から <code>admission.v1beta1</code> に変更されました。<em>クラスターをアップグレードする前に既存の Web フックを削除し</em>、最新の API を使用するように Web フック構成ファイルを更新する必要があります。この変更には後方互換性がありません。</td>
</tr>
</tbody>
</table>

### マスターの後に行う更新
{: #19_after}

<table summary="バージョン 1.9 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.9 に更新した後に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>`kubectl` 出力</td>
<td>`-o custom-columns` を指定した `kubectl` コマンドで、列がオブジェクト内に見つからなかった場合に、`<none>` という出力が表示されるようになりました。<br>
以前は、このような操作は失敗し、エラー・メッセージ `xxx is not found` が表示されていました。以前の動作に依存したスクリプトがある場合は更新してください。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>パッチを適用したリソースに変更が行われない場合に、`kubectl patch` コマンドが`終了コード 1` で失敗するようになりました。以前の動作に依存したスクリプトがある場合は更新してください。</td>
</tr>
<tr>
<td>Kubernetes ダッシュボードの権限</td>
<td>ユーザーは、クラスター・リソースを参照するために、資格情報を使用して Kubernetes ダッシュボードにログインしなければならなくなりました。デフォルトの Kubernetes ダッシュボード `ClusterRoleBinding` RBAC 許可は削除されました。手順については、[Kubernetes ダッシュボードの起動](cs_app.html#cli_dashboard)を参照してください。</td>
</tr>
<tr>
<td>`default` `ServiceAccount` の RBAC</td>
<td>`default` 名前空間内の `default` `ServiceAccount` の管理者 `ClusterRoleBinding` は削除されました。アプリケーションが Kubernetes API にアクセスするためにこの RBAC ポリシーに依存している場合、[RBAC ポリシーを更新してください](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</td>
</tr>
<tr>
<td>テイントと耐障害性</td>
<td>`node.alpha.kubernetes.io/notReady` と `node.alpha.kubernetes.io/unreachable` テイントは、それぞれ `node.kubernetes.io/not-ready` と `node.kubernetes.io/unreachable` に変更されました。<br>
テイントは自動的に更新されますが、これらのテイントの耐障害性は手動で更新する必要があります。`ibm-system` と `kube-system` 以外の名前空間ごとに、耐障害性を変更する必要があるかどうかを判別します。<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
`Action required` が戻された場合は、適宜、ポッドの耐障害性を変更してください。</td>
</tr>
<tr>
<td>Web フックのアドミッション API</td>
<td>クラスターを更新する前に既存の Web フックを削除した場合は、新しい Web フックを作成してください。</td>
</tr>
</tbody>
</table>


## バージョン 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="このバッジは、IBM Cloud Container Service に関する Kubernetes バージョン 1.8 証明書を示しています。"/> {{site.data.keyword.containerlong_notm}} は、CNCF Kubernetes Software Conformance Certification プログラムにおけるバージョン 1.8 の認定 Kubernetes 製品です。</p>

Kubernetes を前のバージョンから 1.8 に更新する場合に必要な可能性がある変更作業について説明します。

<br/>

### マスターの前に行う更新
{: #18_before}

<table summary="バージョン 1.8 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.8 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>マスターを更新する前に必要な変更はありません</td>
</tr>
</tbody>
</table>

### マスターの後に行う更新
{: #18_after}

<table summary="バージョン 1.8 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.8 に更新した後に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes ダッシュボード・ログイン</td>
<td>バージョン 1.8 で Kubernetes ダッシュボードにアクセスするための URL は変更され、ログイン・プロセスには新しい認証ステップが含まれています。 詳しくは、[Kubernetes ダッシュボードにアクセスする](cs_app.html#cli_dashboard)を参照してください。</td>
</tr>
<tr>
<td>Kubernetes ダッシュボードの権限</td>
<td>バージョン 1.8 のクラスター・リソースを表示するユーザーが資格情報を使用してログインするように強制するには、1.7 ClusterRoleBinding RBAC 許可を除去します。 `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard` を実行します。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>`kubectl delete` コマンドは、ワークロード API オブジェクトを削除する前に、ポッドの場合のようにオブジェクトをスケールダウンすることはなくなりました。 オブジェクトのスケールダウンが必要な場合は、オブジェクトを削除する前に [kubectl scale ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale) を使用してください。</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` コマンドは、`--env` のために、コンマ区切りの引数ではなく複数のフラグを使用する必要があります。 例えば、<code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code> ではなく <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> を実行します。 </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` コマンドは使用できなくなりました。</td>
</tr>
</tbody>
</table>


## バージョン 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="このバッジは、IBM Cloud Container Service に関する Kubernetes バージョン 1.7 証明書を示しています。"/> {{site.data.keyword.containerlong_notm}} は、CNCF Kubernetes Software Conformance Certification プログラムにおけるバージョン 1.7 の認定 Kubernetes 製品です。</p>

Kubernetes を前のバージョンから 1.7 に更新する場合に必要な可能性がある変更作業について説明します。

<br/>

### マスターの前に行う更新
{: #17_before}

<table summary="バージョン 1.7 と 1.6 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.7 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>ストレージ</td>
<td>構成スクリプトの中で、`hostPath` や `mountPath` に親ディレクトリー参照 (`../to/dir` など) を指定することはできません。 パスを `/path/to/dir` などの単純な絶対パスに変更してください。
<ol>
  <li>ストレージ・パスを変更する必要があるかどうかを判別します。</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>`「Action required」`が返された場合、すべてのワーカー・ノードを更新する前に、ポッドを変更して絶対パスを参照するようにします。 ポッドがデプロイメントなど別のリソースによって所有されている場合は、そのリソース内の [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) を変更します。
</ol>
</td>
</tr>
</tbody>
</table>

### マスターの後に行う更新
{: #17_after}

<table summary="バージョン 1.7 と 1.6 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.7 に更新した後に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>`kubectl` CLI の更新の後、以下の `kubectl create` コマンドは、コンマ区切りの引数ではなく複数のフラグを使用する必要があります。<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  例えば、`kubectl create role --resource-name <x>,<y>` ではなく `kubectl create role --resource-name <x> --resource-name <y>` のように実行します。</td>
</tr>
<tr>
<td>ポッド・アフィニティー・スケジューリング</td>
<td> `scheduler.alpha.kubernetes.io/affinity` アノテーションは推奨されていません。
<ol>
  <li>`ibm-system` と `kube-system` 以外の名前空間ごとに、ポッド・アフィニティー・スケジューリングを更新する必要があるかどうかを判別します。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br></li>
  <li>`「Action required」`が返された場合、`scheduler.alpha.kubernetes.io/affinity` アノテーションではなく [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) の _affinity_ フィールドを使用します。</li>
</ol>
</tr>
<tr>
<td>ネットワーク・ポリシー</td>
<td>`net.beta.kubernetes.io/network-policy` アノテーションは使用できなくなりました。
<ol>
  <li>ポリシーを変更する必要があるかどうかを判別します。</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>`「Action required」`が返された場合、リストされたそれぞれの Kubernetes 名前空間に以下のネットワーク・ポリシーを追加します。</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> ネットワーキング・ポリシーを追加した後、`net.beta.kubernetes.io/network-policy` アノテーションを削除します。
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </li></ol>
</tr>
<tr>
<td>耐障害性</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` アノテーションは使用できなくなりました。
<ol>
  <li>`ibm-system` と `kube-system` 以外の名前空間ごとに、耐障害性を変更する必要があるかどうかを判別します。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>`「Action required」`が返された場合、`scheduler.alpha.kubernetes.io/tolerations` アノテーションではなく [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) の _tolerations_ フィールドを使用します。
</ol>
</tr>
<tr>
<td>テイント</td>
<td>`scheduler.alpha.kubernetes.io/taints` アノテーションは使用できなくなりました。
<ol>
  <li>テイントを変更する必要があるかどうかを判別します。</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>`「Action required」`が返された場合、各ノードの `scheduler.alpha.kubernetes.io/taints` アノテーションを削除します。</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>各ノードにテイントを追加します。</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</tr>
<tr>
<td>StatefulSet ポッド DNS</td>
<td>マスターを更新した後に、StatefulSet ポッドはその Kubernetes DNS エントリーを失います。 DNS エントリーを復元するには、StatefulSet ポッドを削除します。 Kubernetes はポッドを再作成して、DNS エントリーを自動的に復元します。 詳しくは、[Kubernetes issue ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/issues/48327) を参照してください。
</tr>
</tbody>
</table>
