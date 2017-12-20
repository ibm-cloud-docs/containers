---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-03"

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

{{site.data.keyword.containerlong}} で使用可能な Kubernetes バージョンを確認します。
{:shortdesc}

{{site.data.keyword.containershort_notm}} は、Kubernetes のさまざまなバージョンをサポートします。 クラスターを作成または更新するときには、異なるバージョンを指定しない限り、デフォルトのバージョンが使用されます。 使用可能な Kubernetes のバージョンは以下のとおりです。
- 1.8.2
- 1.7.4 (デフォルト・バージョン)
- 1.5.6

以下の情報は、クラスターを新しいバージョンに更新するときに、デプロイされたアプリに影響を与える可能性が高い更新を要約しています。 Kubernetes の各バージョンでの変更内容を示す完全なリストについては、[Kubernetes changelog ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) を参照してください。

更新処理について詳しくは、[クラスターの更新](cs_cluster.html#cs_cluster_update)と[ワーカー・ノードの更新](cs_cluster.html#cs_cluster_worker_update)を参照してください。

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

## バージョン 1.8
{: #cs_v18}
Kubernetes バージョン 1.8 に更新する際に、行うことが必要となる可能性がある変更を検討します。

### マスターの前に行う更新
{: #18_before}

<table summary="バージョン 1.8 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.8 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明
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
<th>説明
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes ダッシュボード・ログイン</td>
<td>バージョン 1.8 で Kubernetes ダッシュボードにアクセスするための URL は変更され、ログイン・プロセスには新しい認証ステップが含まれています。 詳しくは、[Kubernetes ダッシュボードにアクセスする](cs_apps.html#cs_cli_dashboard)を参照してください。</td>
</tr>
<tr>
<tr>
<td>Kubernetes ダッシュボードの権限</td>
<td>バージョン 1.8 のクラスター・リソースを表示するユーザーが資格情報を使用してログインするように強制するには、1.7 ClusterRoleBinding RBAC 許可を除去します。 `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard` を実行します。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>`kubectl delete` コマンドは、ワークロード API オブジェクトを削除する前に、ポッドの場合のようにオブジェクトをスケールダウンすることはなくなりました。 オブジェクトのスケールダウンが必要な場合は、オブジェクトを削除する前に [kubectl scale ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#scale) を使用してください。</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` コマンドは、`--env` のために、コンマ区切りの引数ではなく複数のフラグを使用する必要があります。 例えば、`kubectl run --env <x>=<y>,<z>=<k>` ではなく `kubectl run --env <x>=<y> --env <z>=<k>` を実行します。</td>
</tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` コマンドは使用できなくなりました。</td>
</tr>
</tbody>
</table>


## バージョン 1.7
{: #cs_v17}

Kubernetes バージョン 1.7 に更新する際に、行うことが必要となる可能性がある変更を検討します。

### マスターの前に行う更新
{: #17_before}

<table summary="バージョン 1.7 と 1.6 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.7 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明
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
<th>説明
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
  </br>
  <li>`「Action required」`が返された場合、`scheduler.alpha.kubernetes.io/affinity` アノテーションではなく [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) の _affinity_ フィールドを使用します。
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
  </ol>
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
  </ol>
</tr>
<tr>
<td>StatefulSet ポッド DNS</td>
<td>マスターを更新した後に、StatefulSet ポッドはその Kubernetes DNS エントリーを失います。 DNS エントリーを復元するには、StatefulSet ポッドを削除します。 Kubernetes はポッドを再作成して、DNS エントリーを自動的に復元します。 詳しくは、[Kubernetes issue ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/issues/48327) を参照してください。
</tr>
</tbody>
</table>
