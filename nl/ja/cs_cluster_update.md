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


# クラスターとワーカー・ノードの更新
{: #update}

## Kubernetes マスターの更新
{: #master}

Kubernetes は定期的に更新をリリースします。[メジャー、マイナー、またはパッチという更新](cs_versions.html#version_types)があります。更新のタイプによっては、Kubernetes マスターの更新を自分で行う必要があります。ワーカー・ノードについては、必ず自分で最新状態に保つ必要があります。更新を適用する際には、Kubernetes マスターを更新してから、ワーカー・ノードを更新します。
{:shortdesc}

デフォルトでは、Kubernetes マスターを更新できるのは、現行バージョンから 2 つ先のマイナー・バージョンまでに制限されています。例えば、現在のマスターがバージョン 1.5 であり、1.8 に更新する計画の場合、まず 1.7 に更新する必要があります。更新を強制実行することは可能ですが、2 つ先のマイナー・バージョンを超える更新をしようとすると、予期しない結果が生じるおそれがあります。

以下の図は、マスターを更新するときに行えるプロセスを示しています。

![マスター更新のベスト・プラクティス](/images/update-tree.png)

図 1. Kubernetes マスター更新プロセスの図

**注意**: 更新プロセスが開始されたら、クラスターを前のバージョンにロールバックすることはできません。必ず、テスト・クラスターを使用し、手順に従って潜在する問題に対処してから、実動マスターを更新してください。

_メジャー_ または_マイナー_ の更新の場合、以下の手順を実行します。

1. [Kubernetes の変更点](cs_versions.html)を確認し、『_マスターの前に行う更新_』というマークのある更新を実行します。
2. GUI を使用するか [CLI コマンド](cs_cli_reference.html#cs_cluster_update)を実行して、Kubernetes マスターを更新します。 Kubernetes マスターを更新する際、マスターは 5 分から 10 分の間ダウンします。 更新中、クラスターにアクセスすることも変更することもできません。 ただし、クラスター・ユーザーがデプロイしたワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。
3. 更新が完了したことを確認します。 {{site.data.keyword.Bluemix_notm}} ダッシュボードで Kubernetes バージョンを確認するか、`bx cs clusters` を実行します。

Kubernetes マスターの更新が完了したら、ワーカー・ノードを更新することができます。

<br />


## ワーカー・ノードの更新
{: #worker_node}

ワーカー・ノードの更新を促す通知を受信する場合があります。これは何を意味しているでしょうか。ワーカー・ノード内のポッドの内部にデータが保管されています。セキュリティー更新とパッチが Kubernetes マスターに適用されるとき、ワーカー・ノードが同期されるようにする必要があります。ワーカー・ノード・マスターのレベルを、Kubernetes マスターより高くすることはできません。
{: shortdesc}

<ul>**注意**:</br>
<li>ワーカー・ノードを更新すると、アプリとサービスにダウン時間が発生する可能性があります。</li>
<li>データは、ポッドの外部に保管されていない場合、削除されます。</li>
<li>使用可能なノードにポッドをスケジュール変更するには、デプロイメントで[レプリカ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) を使用します。</li></ul>

ダウン時間を許容できない場合はどうしますか?

更新プロセスの過程で、特定のノードが一定時間ダウンします。アプリケーションのダウン時間を回避するため、アップグレード・プロセス中の、特定のタイプのノードのしきい値パーセンテージを指定する構成マップで、固有キーを定義することができます。標準の Kubernetes ラベルに基づいたルールを定義し、使用不可にできるノード最大量のパーセンテージを指定することで、確実にアプリを稼働したままにすることができます。ノードは、デプロイ・プロセスを完了していない場合、使用不可と見なされます。

キーをどのように定義しますか?

構成マップには、データ情報を格納するセクションがあります。任意の時点で実行される、最大 10 個の別々のルールを定義できます。ワーカー・ノードをアップグレードするには、ノードが、マップに定義されたすべてのルールに合格する必要があります。

キーが定義されました。次に何をしますか?

ルールを定義したら、ワーカー・アップグレード・コマンドを実行します。成功を示す応答が返された場合、ワーカー・ノードはアップグレード待機中となります。ただし、すべてのルールが満たされるまでは、ノードのアップグレード・プロセスが実行されません。待機中は一定の間隔でルールが検査され、いずれかのノードをアップグレードできないか判別されます。

構成マップを定義しない場合はどうなりますか?

構成マップを定義しない場合、デフォルトが使用されます。デフォルトでは、更新処理中、クラスターごとに全ワーカー・ノードの最大 20% が使用不可になります。

ワーカー・ノードを更新するには、以下のようにします。

1. Kubernetes マスターの Kubernetes バージョンと一致するバージョンの [`kubectl cli` ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) をインストールします。

2. [Kubernetes の変更](cs_versions.html)の『_マスターの後に行う更新_』に記載されている変更作業を行います。

3. オプション: 構成マップを定義します。
    例:

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はパラメーター、2 列目は対応する説明です。">
    <thead>
      <th colspan=2><img src="images/idea.png"/> 構成要素について</th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> デフォルトとして、ibm-cluster-update-configuration マップが有効な方法で定義されていない場合に、一度にクラスターの 20% のみを使用不可にすることができます。グローバル・デフォルトなしで、1 つ以上の有効なルールが定義されている場合、新規デフォルトでは、一度にワーカーの 100% を使用不可にすることを許容します。これを制御するには、デフォルト・パーセンテージを作成します。</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> ルールを設定する固有キーの例。キーの名前は、任意に設定できます。キー内に設定された構成によって、情報が解析されます。定義したキーごとに、<code>NodeSelectorKey</code> と <code>NodeSelectorValue</code> に値を 1 つだけ設定できます。複数の地域またはロケーション (データ・センター) のルールを設定する場合は、新規キー項目を作成します。</td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> 使用不可にできる、指定されたキーのノードの最大量 (パーセンテージで指定)。ノードは、デプロイ、再ロード、またはプロビジョニングのプロセス中に使用不可になります。待機中のワーカー・ノードは、定義された最大使用不可パーセンテージを超える場合に、アップグレードがブロックされます。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> 指定されたキーのルールを設定するラベルのタイプ。IBM 提供のデフォルト・ラベルと、自分で作成したラベルにルールを設定できます。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> 評価するルールが設定される、指定されたキー内のノードのサブセット。</td>
      </tr>
    </tbody>
  </table>

    **注**: 最大 10 個のルールを定義できます。10 を超えるキーを 1 つのファイルに追加した場合、情報のサブセットのみが解析されます。

3. GUI で、または CLI コマンドを実行して、ワーカー・ノードを更新します。
  * {{site.data.keyword.Bluemix_notm}} ダッシュボードから更新するには、クラスターの`「ワーカー・ノード (Worker Nodes)」`セクションにナビゲートし、`「ワーカーの更新 (Update Worker)」`をクリックします。
  * ワーカー・ノード ID を取得するには、`bx cs workers <cluster_name_or_id>` を実行します。 複数のワーカー・ノードを選択した場合、ワーカー・ノードは更新評価のためにキューに置かれます。評価の後、準備できていると見なされるなら、構成に設定されたルールに従って更新されます

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. オプション: 以下のコマンドを実行し、**イベント**を参照することで、構成マップによってトリガーされたイベントと、発生した検証エラーを確認します。
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. 更新が完了したことを確認します。
  * {{site.data.keyword.Bluemix_notm}} ダッシュボードで Kubernetes バージョンを確認するか、`bx cs workers<cluster_name_or_id>` を実行します。
  * `kubectl get nodes` を実行して、ワーカー・ノードの Kubernets のバージョンを確認します。
  * 場合によっては、更新後に古いクラスターで、**NotReady** 状況の重複したワーカー・ノードがリスト表示されることがあります。 重複を削除するには、[トラブルシューティング](cs_troubleshoot.html#cs_duplicate_nodes)を参照してください。

次のステップ:
  - 他のクラスターで更新処理を繰り返します。
  - クラスターで作業を行う開発者に、`kubectl` CLI を Kubernetes マスターのバージョンに更新するように伝えます。
  - Kubernetes ダッシュボードに使用状況グラフが表示されない場合は、[`kube-dashboard` ポッドを削除](cs_troubleshoot.html#cs_dashboard_graphs)します。
<br />

