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



# バージョン情報および更新操作
{: #cs_versions}

## Kubernetes バージョンのタイプ
{: #version_types}

{{site.data.keyword.containerlong}} は、複数のバージョンの Kubernetes を同時にサポートします。 最新バージョン (n) がリリースされると、2 つ前のバージョン (n-2) までサポートされます。 最新バージョンから 2 つより前のバージョン (n-3) は、まず非推奨になり、その後サポートされなくなります。
{:shortdesc}

**サポートされる Kubernetes バージョン**:

- 最新: 1.11.3
- デフォルト: 1.10.8
- その他: 1.9.10

</br>

**非推奨バージョン**: 非推奨 Kubernetes バージョンでクラスターを実行している場合は、そのバージョンがサポートされなくなるまでの 30 日の間に、サポートされるバージョンの Kubernetes を確認したうえで更新してください。 非推奨の期間中は、クラスターはまだ完全にサポートされています。 ただし、非推奨バージョンを使用する新規クラスターは作成できません。

**非サポート・バージョン**: サポートされないバージョンの Kubernetes でクラスターを実行している場合は、以下のような更新の潜在的な影響を確認し、即時に[クラスターを更新](cs_cluster_update.html#update)して、重要なセキュリティー更新とサポートを継続して受けてください。
*  **重要**: クラスターが、サポートされるバージョンの 3 つ以上マイナーのバージョンになった場合は、強制的に更新を実行する必要があり、この場合、予期しない結果または障害が発生する可能性があります。
*  非サポートのクラスターは、既存のワーカー・ノードを追加したり再ロードしたりすることはできません。
*  サポートされるバージョンにクラスターを更新した後は、クラスターで、通常の操作を再開し、引き続きサポートを受けることができます。

</br>

クラスターのサーバー・バージョンを確認するには、以下のコマンドを実行します。

```
kubectl version  --short | grep -i server
```
{: pre}

出力例:

```
Server Version: v1.10.8+IKS
```
{: screen}


## 更新タイプ
{: #update_types}

Kubernetes クラスターには、メジャー、マイナー、およびパッチという 3 つのタイプの更新があります。
{:shortdesc}

|更新タイプ|バージョン・ラベルの例|更新の実行者|影響
|-----|-----|-----|-----|
|メジャー|1.x.x|お客様|スクリプトやデプロイメントを含むクラスターの操作変更。|
|マイナー|x.9.x|お客様|スクリプトやデプロイメントを含むクラスターの操作変更。|
|パッチ|x.x.4_1510|IBM とお客様|Kubernetes のパッチ、および、セキュリティー・パッチやオペレーティング・システム・パッチなどの他の {{site.data.keyword.Bluemix_notm}} Provider コンポーネントの更新。 マスターは IBM が自動的に更新しますが、ワーカー・ノードへのパッチはお客様が適用する必要があります。 パッチについて詳しくは、以下のセクションを参照してください。|
{: caption="Kubernetes 更新の影響" caption-side="top"}

更新が利用可能になると、`ibmcloud ks workers <cluster>` や `ibmcloud ks worker-get <cluster> <worker>` コマンドなどを使用してワーカー・ノードの情報を表示したときに通知されます。
-  **メジャー更新とマイナー更新**: まず[マスター・ノードを更新して](cs_cluster_update.html#master)、それから[ワーカー・ノードを更新します](cs_cluster_update.html#worker_node)。
   - デフォルトでは、Kubernetes マスターを更新できるのは 2 つ先のマイナー・バージョンまでです。 例えば、現在のマスターがバージョン 1.7 であり 1.10 に更新する計画の場合、まず 1.9 に更新する必要があります。 続けて更新を強制実行することは可能ですが、2 つのマイナー・バージョンを超える更新によって、予期しない結果や障害が発生するおそれがあります。
   - 少なくともクラスターの `major.minor` バージョンに一致する `kubectl` CLI バージョンを使用しないと、予期しない結果になる可能性があります。 Kubernetes クラスターと [CLI のバージョン](cs_cli_install.html#kubectl)を最新の状態に保つようにしてください。
-  **パッチ更新**: パッチに関する変更については、[バージョンの変更ログ](cs_versions_changelog.html)で説明しています。更新が利用可能になると、マスター・ノードやワーカー・ノードに関する情報を GUI または CLI で `ibmcloud ks clusters`、`cluster-get`、`workers`、`worker-get` などのコマンドを使用して表示したときに通知されます。
   - **ワーカー・ノードのパッチ**: 更新が使用可能かどうかを毎月確認し、`ibmcloud ks worker-update` [コマンド](cs_cli_reference.html#cs_worker_update)または `ibmcloud ks worker-reload` [コマンド](cs_cli_reference.html#cs_worker_reload)を使用して、これらのセキュリティー・パッチおよびオペレーティング・システム・パッチを適用してください。
   - **マスターのパッチ**: マスターのパッチは、数日にわたって自動的に適用されるため、マスターに適用される前に、マスターのパッチ・バージョンが使用可能であると表示される場合があります。また、更新の自動化では、正常な状態でないクラスターや現在進行中の操作があるクラスターはスキップされます。必要に応じて、IBM は特定のマスターのフィックスパック (変更ログに記載されているように、マスターが 1 つ前のマイナー・バージョンから更新される場合にのみ必要なパッチなど) に対して、自動更新を無効にする場合があります。これらのいずれかの場合、自動更新が適用されるのを待たずに、`ibmcloud ks cluster-update` [コマンド](cs_cli_reference.html#cs_cluster_update)を使用して手動で確実に更新することができます。

</br>

この情報は、クラスターを前のバージョンから新しいバージョンに更新した場合に、デプロイされているアプリに影響を与える可能性がある更新についてまとめたものです。
-  バージョン 1.11 [マイグレーションの操作](#cs_v111)。
-  バージョン 1.10 [マイグレーションの操作](#cs_v110)。
-  バージョン 1.9 [マイグレーションの操作](#cs_v19)。
-  非推奨または非サポートのバージョンの[アーカイブ](#k8s_version_archive)。

<br/>

変更内容の完全なリストは、以下の情報を参照してください。
* [Kubernetes の変更ログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)。
* [IBM バージョンの変更ログ](cs_versions_changelog.html)。

</br>

## バージョン 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="このバッジは、IBM Cloud コンテナー・サービスが Kubernetes バージョン 1.11 の認定を受けたことを示しています。"/> {{site.data.keyword.containerlong_notm}} は、CNCF Kubernetes Software Conformance Certification プログラムのもとで認定を受けたバージョン 1.11 の Kubernetes 製品です。 __</p>

Kubernetes を前のバージョンから 1.11 に更新する場合に必要な可能性がある変更作業について説明します。

**重要**:
Kubernetes バージョン 1.9 以前からバージョン 1.11 にクラスターを正常に更新するには、その前に、[Calico v3 への更新の準備](#111_calicov3)に記載の手順を実行しておく必要があります。

### マスターの前に行う更新
{: #111_before}

<table summary="バージョン 1.11 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.11 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>`containerd` の新しい Kubernetes コンテナー・ランタイム</td>
<td><strong>重要</strong>: `containerd` は、Kubernetes の新しいコンテナー・ランタイムとして Docker を置き換えるものです。 実行する必要があるアクションについては、[コンテナー・ランタイムとしての `containerd` へのマイグレーション](#containerd)を参照してください。</td>
</tr>
<tr>
<td>Kubernetes コンテナー・ボリューム・マウント伝搬</td>
<td>コンテナー `VolumeMount` の [`mountPropagation` フィールド ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) のデフォルト値は、`HostToContainer` から `None` に変更されました。 この変更により、Kubernetes バージョン 1.9 以前に存在していた動作が復元されます。 ポッドの仕様がデフォルトの `HostToContainer` に依存している場合は、それらを更新します。</td>
</tr>
<tr>
<td>Kubernetes API サーバー JSON デシリアライザー</td>
<td>Kubernetes API サーバー JSON デシリアライザーで、大/小文字が区別されるようになりました。 この変更により、Kubernetes バージョン 1.7 以前に存在していた動作が復元されます。 JSON リソース定義で正しくない大/小文字が使用されている場合は、それらを更新します。 <br><br>**注**: 影響を受けるのは、直接の Kubernetes API サーバー要求のみです。 `kubectl` CLI では、Kubernetes バージョン 1.7 以降で大/小文字を区別するキーが引き続き強制されるため、`kubectl` でリソースを厳密に管理する場合は、影響を受けません。</td>
</tr>
</tbody>
</table>

### マスターの後に行う更新
{: #111_after}

<table summary="バージョン 1.11 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.11 に更新した後に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>クラスター・ロギング構成</td>
<td>`fluentd` クラスター・アドオンは、`logging-autoupdate` が無効になっている場合でも、バージョン 1.11 で自動的に更新されます。<br><br>
コンテナー・ログ・ディレクトリーが `/var/lib/docker/` から `/var/log/pods/` に変更されました。 以前のディレクトリーをモニターする独自のロギング・ソリューションを使用する場合は、それに応じて更新します。</td>
</tr>
<tr>
<td>Kubernetes 構成のリフレッシュ</td>
<td>クラスターの Kubernetes API サーバーの OpenID Connect 構成が、{{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) アクセス・グループをサポートするように更新されました。そのため、`ibmcloud ks cluster-config --cluster <cluster_name_or_ID>` を実行して、マスター Kubernetes v1.11 の更新の後にクラスターの Kubernetes 構成をリフレッシュする必要があります。 <br><br>構成をリフレッシュしないと、クラスター・アクションは失敗し、`You must be logged in to the server (Unauthorized).` というエラー・メッセージが表示されます。</td>
</tr>
<tr>
<td>`kubectl` CLI</td>
<td>Kubernetes バージョン 1.11 の `kubectl` CLI には、`apps/v1` API が必要です。 そのため、v1.11 の `kubectl` CLI は、Kubernetes バージョン 1.8 以前を実行するクラスターでは機能しません。 クラスターの Kubernetes API サーバーのバージョンに一致している `kubectl` CLI のバージョンを使用してください。</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>ユーザーが許可されていない場合、`kubectl auth can-i` コマンドが `exit code 1` で失敗するようになりました。以前の動作に依存したスクリプトがある場合は更新してください。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>ラベルなどの選択基準を使用してリソースを削除すると、デフォルトでは `kubectl delete` コマンドで `not found` エラーが無視されるようになりました。 以前の動作に依存したスクリプトがある場合は更新してください。</td>
</tr>
<tr>
<td>Kubernetes `sysctls` 機能</td>
<td>`security.alpha.kubernetes.io/sysctls` アノテーションが無視されるようになりました。 代わりに、Kubernetes では、`sysctls` を指定および制御できるように `PodSecurityPolicy` オブジェクトと `Pod` オブジェクトにフィールドが追加されました。 詳しくは、[Using sysctls in Kubernetes ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/) を参照してください。 <br><br>クラスターのマスターおよびワーカーを更新したら、新しい `sysctls` フィールドを使用するように `PodSecurityPolicy` オブジェクトと `Pod` オブジェクトを更新します。</td>
</tr>
</tbody>
</table>

### コンテナー・ランタイムとしての `containerd` へのマイグレーション
{: #containerd}

Kubernetes バージョン 1.11 以降を実行するクラスターの場合、`containerd` は、パフォーマンスを向上させるために、Kubernetes の新しいコンテナー・ランタイムとして Docker を置き換えるものです。 ご使用のポッドが Kubernetes コンテナー・ランタイムとしての Docker に依存している場合は、これらを更新して、`containerd` をコンテナー・ランタイムとして処理する必要があります。 詳しくは、[Kubernetes の containerd についての発表 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/) を参照してください。
{: shortdesc}

**アプリが `containerd` ではなく `docker` に依存しているかどうかを確認するには、どうすればよいですか?**<br>
コンテナー・ランタイムとしての Docker に依存している可能性のある場合の例:
*  特権コンテナーを使用して Docker エンジンまたは API に直接アクセスする場合は、ランタイムとしての `containerd` をサポートするようにポッドを更新します。
*  クラスター内にインストールするロギング・ツールやモニター・ツールなどの一部のサード・パーティー・アドオンは、Docker エンジンに依存している場合があります。 ツールが `containerd` と互換性があることをプロバイダーに確認してください。

<br>

**ランタイムへの依存以外に、マイグレーション・アクションを実行する必要がありますか?**<br>

**マニフェスト・ツール**: Docker バージョン 18.06 より前の試験的な `docker manifest` [ツール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.docker.com/edge/engine/reference/commandline/manifest/) を使用してビルドされたマルチプラットフォーム・イメージがある場合は、`containerd` を使用して DockerHub からイメージをプルすることはできません。

ポッドのイベントを確認すると、次のようなエラーが表示されることがあります。
```
failed size validation
```
{: screen}

マニフェスト・ツールを使用してビルドされたイメージとともに `containerd` を使用するには、以下のオプションのいずれかを選択します。

*  [マニフェスト・ツール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/estesp/manifest-tool) を使用してイメージを再ビルドします。
*  Docker バージョン 18.06 以降に更新した後で `docker-manifest` ツールを使用してイメージを再ビルドします。

<br>

**影響を受けないものは何ですか? コンテナーのデプロイ方法を変更する必要がありますか?**<br>
一般に、コンテナー・デプロイメント・プロセスは変更されません。 引き続き Dockerfile を使用して Docker イメージを定義し、アプリの Docker コンテナーをビルドできます。 `docker` コマンドを使用して、イメージをビルドしてレジストリーにプッシュする場合は、引き続き `docker` を使用することも、代わりに `ibmcloud cr` コマンドを使用することもできます。

### Calico v3 への更新の準備
{: #111_calicov3}

**重要**: Kubernetes バージョン 1.9 以前からバージョン 1.11 にクラスターを更新する場合、マスターを更新する前に、Calico v3 の更新の準備をします。Kubernetes v1.11 へのマスター・アップグレード中は、新規ポッドおよび新規 Kubernetes または Calico ネットワーク・ポリシーはスケジュールされません。 更新によって新しいスケジュールが妨げられる時間はさまざまです。 小規模なクラスターでは数分かかり、ノードが 10 個増えるごとにさらに数分追加されます。 既存のネットワーク・ポリシーとポッドは引き続き実行されます。

**注**: Kubernetes バージョン 1.10 からバージョン 1.11 にクラスターを更新する場合は、1.10 への更新時にこれらの手順は完了しているので、これらの手順をスキップします。

始める前に、クラスター・マスターとすべてのワーカー・ノードで Kubernetes バージョン 1.8 または 1.9 が実行されている必要があり、少なくとも 1 つのワーカー・ノードが必要です。

1.  Calico ポッドが正常であることを確認します。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  **Running** 状態になっていないポッドがある場合は、そのポッドを削除し、**Running** 状態になるまで待ってから続行します。

3.  Calico ポリシーまたはその他の Calico リソースを自動生成する場合は、これらのリソースを生成するための自動化ツールを [Calico v3 構文 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) で更新します。

4.  VPN 接続に [strongSwan](cs_vpn.html#vpn-setup) を使用している場合、strongSwan 2.0.0 Helm チャートは Calico v3 または Kubernetes 1.11 では機能しません。 Calico 2.6、および Kubernetes 1.7、1.8、および 1.9 との後方互換性のある 2.1.0 Helm チャートに [strongSwan を更新](cs_vpn.html#vpn_upgrade)してください。

5.  [クラスター・マスターを Kubernetes 1.11 に更新します](cs_cluster_update.html#master)。

<br />


## バージョン 1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="このバッジは、IBM Cloud Container Service が Kubernetes バージョン 1.10 の認定を受けたことを示しています。"/> {{site.data.keyword.containerlong_notm}} は、CNCF Kubernetes Software Conformance Certification プログラムのもとで認定を受けたバージョン 1.10 の Kubernetes 製品です。 __</p>

Kubernetes を前のバージョンから 1.10 に更新する場合に必要な可能性がある変更作業について説明します。

**重要**: Kubernetes 1.10 に正常に更新するには、その前に、[Calico v3 への更新の準備](#110_calicov3)に記載の手順を実行しておく必要があります。

<br/>

### マスターの前に行う更新
{: #110_before}

<table summary="バージョン 1.10 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.10 に更新する前に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>Kubernetes バージョン 1.10 に更新すると、Calico も v2.6.5 から v3.1.1 に更新されます。 <strong>重要</strong>: Kubernetes v1.10 に正常に更新するには、その前に、[Calico v3 への更新の準備](#110_calicov3)に記載の手順を実行しておく必要があります。</td>
</tr>
<tr>
<td>Kubernetes ダッシュボードのネットワーク・ポリシー</td>
<td>Kubernetes 1.10 では、<code>kube-system</code> 名前空間の <code>kubernetes-dashboard</code> ネットワーク・ポリシーによって、すべてのポッドが Kubernetes ダッシュボードへのアクセスをブロックされます。 ただしこれは、{{site.data.keyword.Bluemix_notm}} コンソールからの、または <code>kubectl proxy</code> を使用したダッシュボードへのアクセスには影響<strong>しません</strong>。 ポッドがダッシュボードにアクセスする必要がある場合は、名前空間に <code>kubernetes-dashboard-policy: allow</code> ラベルを追加し、その名前空間にポッドをデプロイします。</td>
</tr>
<tr>
<td>Kubelet API アクセス</td>
<td>Kubelet API 許可は、<code>Kubernetes API サーバー</code>に委任されました。 Kubelet API へのアクセスは、<strong>ノード</strong>・サブリソースへのアクセス許可を付与する <code>ClusterRoles</code> に基づきます。 Kubernetes Heapster にはデフォルトで、<code>ClusterRole</code> および <code>ClusterRoleBinding</code> が付与されています。 ただし、他のユーザーやアプリが Kubelet API を使用する場合は、それらのユーザーやアプリに API を使用する許可を付与する必要があります。 [Kubelet 許可 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/) に関する Kubernetes 資料を参照してください。</td>
</tr>
<tr>
<td>暗号スイート</td>
<td><code>Kubernetes API サーバー</code>および Kubelet API に対してサポートされる暗号スイートが、高強度の暗号化 (128 ビット以上) を備えたサブセットに限定されるようになりました。 既存の自動化またはリソースで、これより弱い暗号を使用し、<code>Kubernetes API サーバー</code>または Kubelet API との通信を利用している場合は、マスターを更新する前に、より強力な暗号サポートを有効にしてください。</td>
</tr>
<tr>
<td>strongSwan VPN</td>
<td>VPN 接続に [strongSwan](cs_vpn.html#vpn-setup) を使用している場合、クラスターを更新する前に、`helm delete --purge <release_name>` を実行してチャートを削除する必要があります。 クラスターの更新が完了した後、strongSwan Helm チャートを再インストールします。</td>
</tr>
</tbody>
</table>

### マスターの後に行う更新
{: #110_after}

<table summary="バージョン 1.10 の Kubernetes の更新">
<caption>マスターを Kubernetes 1.10 に更新した後に行う変更</caption>
<thead>
<tr>
<th>タイプ</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>クラスターが更新されると、そのクラスターに適用される既存のすべての Calico データが Calico v3 構文を使用するように自動的にマイグレーションされます。 Calico v3 構文の Calico リソースを表示、追加、または変更するには、[Calico CLI 構成をバージョン 3.1.1](#110_calicov3) に更新してください。</td>
</tr>
<tr>
<td>ノードの <code>ExternalIP</code> アドレス</td>
<td>ノードの <code>ExternalIP</code> フィールドが、ノードのパブリック IP アドレス値に設定されるようになりました。 この値に依存するすべてのリソースを確認して更新してください。</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td><code>kubectl port-forward</code> コマンドを使用する際に、<code>-p</code> フラグがサポートされなくなりました。 以前の動作に依存するスクリプトがある場合は、<code>-p</code> フラグをポッド名で置き換えるようにスクリプトを更新してください。</td>
</tr>
<tr>
<td>読み取り専用 API データ・ボリューム</td>
<td>`secret`、`configMap`、`downwardAPI`、および投影ボリュームは、読み取り専用でマウントされるようになります。
これまでは、システムによって自動的に元の状態に戻されることがあるこれらのボリュームに、アプリがデータを書き込めました。 このマイグレーション操作は、セキュリティーの脆弱性 [CVE-2017-1002102![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) を修正するために必要です。
アプリが以前の非セキュアな動作に依存している場合は、適切に変更してください。</td>
</tr>
<tr>
<td>strongSwan VPN</td>
<td>VPN 接続に [strongSwan](cs_vpn.html#vpn-setup) を使用していて、クラスターの更新前にチャートを削除していた場合は、strongSwan Helm チャートを再インストールできます。</td>
</tr>
</tbody>
</table>

### Calico v3 への更新の準備
{: #110_calicov3}

始める前に、クラスター・マスターとすべてのワーカー・ノードで Kubernetes バージョン 1.8 以降が実行されている必要があり、少なくとも 1 つのワーカー・ノードが必要です。

**重要**: マスターを更新する前に、Calico v3 の更新の準備をします。 Kubernetes v1.10 へのマスター・アップグレード中は、新規ポッドおよび新規 Kubernetes または Calico ネットワーク・ポリシーはスケジュールされません。 更新によって新しいスケジュールが妨げられる時間はさまざまです。 小規模なクラスターでは数分かかり、ノードが 10 個増えるごとにさらに数分追加されます。 既存のネットワーク・ポリシーとポッドは引き続き実行されます。

1.  Calico ポッドが正常であることを確認します。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  **Running** 状態になっていないポッドがある場合は、そのポッドを削除し、**Running** 状態になるまで待ってから続行します。

3.  Calico ポリシーまたはその他の Calico リソースを自動生成する場合は、これらのリソースを生成するための自動化ツールを [Calico v3 構文 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) で更新します。

4.  VPN 接続に [strongSwan](cs_vpn.html#vpn-setup) を使用している場合、strongSwan 2.0.0 Helm チャートは Calico v3 または Kubernetes 1.10 では機能しません。 Calico 2.6、および Kubernetes 1.7、1.8、および 1.9 との後方互換性のある 2.1.0 Helm チャートに [strongSwan を更新](cs_vpn.html#vpn_upgrade)してください。

5.  [クラスター・マスターを Kubernetes v1.10 に更新します](cs_cluster_update.html#master)。

<br />


## バージョン 1.9
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="このバッジは、IBM Cloud Container Service が Kubernetes バージョン 1.9 の認定を受けたことを示しています。"/> {{site.data.keyword.containerlong_notm}} は、CNCF Kubernetes Software Conformance Certification プログラムのもとで認定を受けたバージョン 1.9 の Kubernetes 製品です。 __</p>

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
<td>API サーバーがアドミッション制御 Web フックを呼び出すときに使用されるアドミッション API が、<code>admission.v1alpha1</code> から <code>admission.v1beta1</code> に変更されました。 <em>クラスターをアップグレードする前に既存の Web フックを削除し</em>、最新の API を使用するように Web フック構成ファイルを更新する必要があります。 この変更には後方互換性がありません。</td>
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
<td>`-o custom-columns` を指定した `kubectl` コマンドの使用時に、列がオブジェクト内に見つからなかった場合に、`<none>` という出力が表示されるようになりました。<br>
以前は、このような操作は失敗し、エラー・メッセージ `xxx is not found` が表示されていました。 以前の動作に依存したスクリプトがある場合は更新してください。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>パッチを適用したリソースに変更が行われない場合に、`kubectl patch` コマンドが`終了コード 1` で失敗するようになりました。以前の動作に依存したスクリプトがある場合は更新してください。</td>
</tr>
<tr>
<td>Kubernetes ダッシュボードの権限</td>
<td>ユーザーは、クラスター・リソースを参照するために、資格情報を使用して Kubernetes ダッシュボードにログインしなければなりません。 デフォルトの Kubernetes ダッシュボード `ClusterRoleBinding` RBAC 許可は削除されました。 手順については、[Kubernetes ダッシュボードの起動](cs_app.html#cli_dashboard)を参照してください。</td>
</tr>
<tr>
<td>読み取り専用 API データ・ボリューム</td>
<td>`secret`、`configMap`、`downwardAPI`、および投影ボリュームは、読み取り専用でマウントされるようになります。
これまでは、システムによって自動的に元の状態に戻されることがあるこれらのボリュームに、アプリがデータを書き込めました。 このマイグレーション操作は、
セキュリティーの脆弱性 [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) を修正するために必要です。
アプリが以前の非セキュアな動作に依存している場合は、適切に変更してください。</td>
</tr>
<tr>
<td>テイントと耐障害性</td>
<td>`node.alpha.kubernetes.io/notReady` テイントと `node.alpha.kubernetes.io/unreachable` テイントは、それぞれ `node.kubernetes.io/not-ready` と `node.kubernetes.io/unreachable` に変更されました。<br>
テイントは自動的に更新されますが、これらのテイントの耐障害性は手動で更新する必要があります。 `ibm-system` と `kube-system` 以外の名前空間ごとに、耐障害性を変更する必要があるかどうかを判別します。<br>
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

<br />



## アーカイブ
{: #k8s_version_archive}

### バージョン 1.8 (サポート対象外)
{: #cs_v18}

2018 年 9 月 22 日現在、[Kubernetes バージョン 1.8](cs_versions_changelog.html#changelog_archive) を実行する {{site.data.keyword.containerlong_notm}} クラスターはサポートされていません。 バージョン 1.8 クラスターは、次に最新のバージョン ([Kubernetes 1.9](#cs_v19)) に更新しない限り、セキュリティー更新もサポートも受けられません。

各 Kubernetes バージョンの更新が[与える可能性のある影響を確認](cs_versions.html#cs_versions)したうえで、少なくとも 1.9 にただちに[クラスターを更新](cs_cluster_update.html#update)してください。

### バージョン 1.7 (サポート対象外)
{: #cs_v17}

2018 年 6 月 21 日現在、[Kubernetes バージョン 1.7](cs_versions_changelog.html#changelog_archive) を実行する {{site.data.keyword.containerlong_notm}} クラスターはサポートされていません。 バージョン 1.7 クラスターは、次に最新のバージョン ([Kubernetes 1.9](#cs_v19)) に更新しない限り、セキュリティー更新もサポートも受けられません。

各 Kubernetes バージョンの更新が[与える可能性のある影響を確認](cs_versions.html#cs_versions)したうえで、少なくとも 1.9 にただちに[クラスターを更新](cs_cluster_update.html#update)してください。

### バージョン 1.5 (サポート対象外)
{: #cs_v1-5}

2018 年 4 月 4 日現在、[Kubernetes バージョン 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) を実行する {{site.data.keyword.containerlong_notm}} クラスターはサポートされていません。 バージョン 1.5 クラスターは、セキュリティー更新もサポートも受けられません。

{{site.data.keyword.containerlong_notm}} でアプリの実行を継続するには、[新規クラスターを作成して](cs_clusters.html#clusters)、そのクラスターに[アプリをマイグレーションしてください](cs_app.html#app)。
