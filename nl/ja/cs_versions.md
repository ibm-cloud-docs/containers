---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

表には、クラスターを新しいバージョンに更新するときに、デプロイされたアプリに影響を与える可能性が高い更新が示されています。Kubernetes の各バージョンでの変更内容を示す完全なリストについては、[Kubernetes changelog ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) を参照してください。

更新処理について詳しくは、[クラスターの更新](cs_cluster.html#cs_cluster_update)と[ワーカー・ノードの更新](cs_cluster.html#cs_cluster_worker_update)を参照してください。



## バージョン 1.7
{: #cs_v17}

### マスターの前に行う更新
{: #17_before}

<table summary="バージョン 1.7 と 1.6 の Kubernetes の更新">
<caption>表 1. マスターを Kubernetes 1.7 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</tr>
</thead>
<tbody>
<tr>
<td>ストレージ</td>
<td>構成スクリプトの中で、`hostPath` や `mountPath` に親ディレクトリー参照 (`../to/dir` など) を指定することはできません。パスを `/path/to/dir` などの単純な絶対パスに変更してください。
<ol>
  <li>このコマンドを実行して、ストレージ・パスを更新する必要があるかどうかを判別します。</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>`「Action required」`が返された場合、ワーカー・ノードを更新する前に、影響を受ける各ポッドを変更して絶対パスを参照するようにします。ポッドがデプロイメントなど別のリソースによって所有されている場合は、そのリソース内の [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) を変更します。
</ol>
</td>
</tr>
</tbody>
</table>

### マスターの後に行う更新
{: #17_after}

<table summary="バージョン 1.7 と 1.6 の Kubernetes の更新">
<caption>表 2. マスターを Kubernetes 1.7 に更新した後に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>`kubectl` CLI をクラスターのバージョンに更新した後、以下の `kubectl` コマンドは、コンマ区切りの引数ではなく複数のフラグを使用する必要があります。<ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  例えば、`kubectl create role --resource-name <x>,<y>` ではなく `kubectl create role --resource-name <x> --resource-name <y>` のように実行します。</td>
</tr>
<tr>
<td>ポッド・アフィニティー・スケジューリング</td>
<td> `scheduler.alpha.kubernetes.io/affinity` アノテーションは推奨されていません。
<ol>
  <li>`ibm-system` と `kube-system` 以外の名前空間ごとにこのコマンドを実行して、ポッド・アフィニティー・スケジューリングを更新する必要があるかどうかを判別します。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>`「Action required」`が返された場合、影響を受けるポッドを変更して、`scheduler.alpha.kubernetes.io/affinity` アノテーションではなく [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) の _affinity_ フィールドを使用します。
</ol>
</tr>
<tr>
<td>ネットワーク・ポリシー</td>
<td>`net.beta.kubernetes.io/network-policy` アノテーションはサポートされなくなりました。
<ol>
  <li>このコマンドを実行して、ネットワーク・ポリシーを更新する必要があるかどうかを判別します。</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>`「Action required」`が返された場合、リストされた各 Kubernetes 名前空間に以下のネットワーク・ポリシーを追加します。</br>

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

  <li> ネットワーク・ポリシーが配置された状態で、`net.beta.kubernetes.io/network-policy` アノテーションを削除します。
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>耐障害性</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` アノテーションはサポートされなくなりました。
<ol>
  <li>`ibm-system` と `kube-system` 以外の名前空間ごとにこのコマンドを実行して、耐障害性を更新する必要があるかどうかを判別します。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>`「Action required」`が返された場合、影響を受けるポッドを変更して、`scheduler.alpha.kubernetes.io/tolerations` アノテーションではなく [_PodSpec_ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) の _tolerations_ フィールドを使用します。
</ol>
</tr>
<tr>
<td>テイント</td>
<td>`scheduler.alpha.kubernetes.io/taints` アノテーションはサポートされなくなりました。
<ol>
  <li>このコマンドを実行して、テイントを更新する必要があるかどうかを判別します。</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>`「Action required」`が返された場合、サポートされないアノテーションがある各ノードの `scheduler.alpha.kubernetes.io/taints` アノテーションを削除します。</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>サポートされないアノテーションを削除してから、各ノードにテイントを追加します。`kubectl` CLI バージョン 1.6 以降が必要です。</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
  
  
