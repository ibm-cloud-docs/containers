---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# クラスターのトラブルシューティング
{: #cs_troubleshoot}

{{site.data.keyword.containershort_notm}} を使用している場合は、ここに示すトラブルシューティング手法やヘルプの利用手法を検討してください。


{: shortdesc}


## クラスターのデバッグ
{: #debug_clusters}

クラスターをデバッグするためのオプションを確認し、障害の根本原因を探します。

1.  クラスターをリストし、クラスターの `State` を見つけます。

  ```
bx cs clusters```
  {: pre}

2.  クラスターの `State` を確認します。

  <table summary="表の行はすべて左から右に読みます。1 列目はクラスターの状態、2 列目は説明です。">
    <thead>
    <th>クラスターの状態</th>
    <th>説明</th>
    </thead>
    <tbody>
      <tr>
        <td>Deploying</td>
        <td>Kubernetes マスターがまだ完全にデプロイされていません。クラスターにアクセスできません。</td>
       </tr>
       <tr>
        <td>Pending</td>
        <td>Kubernetes マスターはデプロイされています。ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。クラスターにはアクセスできますが、アプリをクラスターにデプロイすることはできません。</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>クラスター内のすべてのワーカー・ノードが稼働中です。クラスターにアクセスし、アプリをクラスターにデプロイできます。</td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>クラスター内の 1 つ以上のワーカー・ノードが使用不可です。ただし、他のワーカー・ノードが使用可能であるため、ワークロードを引き継ぐことができます。</td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>Kubernetes マスターにアクセスできないか、クラスター内のワーカー・ノードがすべてダウンしています。</td>
     </tr>
    </tbody>
  </table>

3.  クラスターが **Warning** 状態または **Critical** 状態の場合、あるいは **Pending** 状態が長時間続いている場合は、ワーカー・ノードの状態を確認してください。クラスターが **Deploying** 状態の場合は、クラスターが完全にデプロイされるまで待ってからクラスターの正常性を確認してください。**Normal** 状態のクラスターは、正常と見なされるので、この時点ではアクションは不要です。 

  ```
    bx cs workers <cluster_name_or_id>
    ```
  {: pre}

  <table summary="表の行はすべて左から右に読みます。1 列目はクラスターの状態、2 列目は説明です。">
    <thead>
    <th>ワーカー・ノードの状態</th>
    <th>説明</th>
    </thead>
    <tbody>
      <tr>
       <td>Unknown</td>
       <td>次のいずれかの理由で、Kubernetes マスターにアクセスできません。<ul><li>Kubernetes マスターの更新を要求しました。更新中は、ワーカー・ノードの状態を取得できません。
</li><li>ワーカー・ノードを保護している追加のファイアウォールが存在するか、最近ファイアウォールの設定が変更された可能性があります。{{site.data.keyword.containershort_notm}} では、ワーカー・ノードと Kubernetes マスター間で通信を行うには、特定の IP アドレスとポートが開いている必要があります。
詳しくは、[ワーカー・ノードが再ロード・ループにはまった場合](#cs_firewall)を参照してください。
</li><li>Kubernetes マスターがダウンしています。[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/support/index.html#contacting-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</li></ul></td>
      </tr>
      <tr>
        <td>Provisioning</td>
        <td>ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。CLI 出力の **Status** 列で、プロビジョニングのプロセスをモニターできます。ワーカー・ノードが長時間この状態であるのに、**Status** 列で処理の進行が見られない場合は、次のステップに進んで、プロビジョニング中に問題が発生していないか調べてください。</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>ワーカー・ノードをプロビジョンできませんでした。次のステップに進んで、障害に関する詳細を調べてください。</td>
      </tr>
      <tr>
        <td>Reloading</td>
        <td>ワーカー・ノードは再ロード中であるため、クラスターでは使用できません。CLI 出力の **Status** 列で、再ロードのプロセスをモニターできます。ワーカー・ノードが長時間この状態であるのに、**Status** 列で処理の進行が見られない場合は、次のステップに進んで、再ロード中に問題が発生していないか調べてください。</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>ワーカー・ノードを再ロードできませんでした。次のステップに進んで、障害に関する詳細を調べてください。</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>ワーカー・ノードは完全にプロビジョンされ、クラスターで使用できる状態です。</td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>ワーカー・ノードが、メモリーまたはディスク・スペースの限度に達しています。</td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>ワーカー・ノードがディスク・スペースを使い尽くしました。</td>
     </tr>
    </tbody>
  </table>

4.  ワーカー・ノードの詳細情報をリストします。

  ```
  bx cs worker-get <worker_node_id>
  ```
  {: pre}

5.  一般的なエラー・メッセージを確認し、解決方法を調べます。

  <table>
    <thead>
    <th>エラー・メッセージ</th>
    <th>説明と解決</thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Your account is currently prohibited from ordering 'Computing Instances'.</td>
        <td>ご使用の {{site.data.keyword.BluSoftlayer_notm}} アカウントは、コンピュート・リソースの注文を制限されている可能性があります。[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/support/index.html#contacting-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not place order. There are insufficient resources behind router 'router_name' to fulfill the request for the following guests: 'worker_id'.</td>
        <td>選択した VLAN に関連付けられているデータ・センター内のポッドのスペースが不足しているため、ワーカー・ノードをプロビジョンできません。以下の選択肢があります。
<ul><li>別のデータ・センターを使用してワーカー・ノードをプロビジョンします。使用可能なデータ・センターをリストするには、<code>bx cs locations</code> を実行します。
<li>データ・センター内の別のポッドに関連付けられているパブリック VLAN とプライベート VLAN の既存のペアがある場合は、代わりにその VLAN ペアを使用します。<li>[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/support/index.html#contacting-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not obtain network VLAN with id: &lt;vlan id&gt;.</td>
        <td>次のいずれかの理由で、選択した VLAN ID が見つからなかったため、ワーカー・ノードをプロビジョンできませんでした。
<ul><li>VLAN ID ではなく VLAN 番号を指定した可能性があります。VLAN 番号の長さは 3 桁または 4 桁ですが、VLAN ID の長さは 7 桁です。VLAN ID を取得するには、<code>bx cs vlans &lt;location&gt;</code> を実行してください。
<li>ご使用の Bluemix Infrastructure (SoftLayer) アカウントに VLAN ID が関連付けられていない可能性があります。アカウントの使用可能な VLAN ID をリストするには、<code>bx cs vlans &lt;location&gt;</code> を実行します。{{site.data.keyword.BluSoftlayer_notm}} アカウントを変更するには、[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set) を参照してください。</ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500)</td>
        <td>ご使用の {{site.data.keyword.BluSoftlayer_notm}} は、選択したデータ・センター内のコンピュート・リソースを注文するようにセットアップされていません。[{{site.data.keyword.Bluemix_notm}} サポート](/docs/support/index.html#contacting-support)に問い合わせて、アカウントが正しくセットアップされているか確認してください。</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers
        
        </br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.</td>
        <td>{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオからワーカー・ノードをプロビジョンするために必要なアクセス権限がない可能性があります。必要なアクセス権限については、[{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオへのアクセス権限を構成して標準の Kubernetes クラスターを作成する](cs_planning.html#cs_planning_unify_accounts)を参照してください。</td>
      </tr>
    </tbody>
  </table>

## クラスターの作成中に IBM {{site.data.keyword.BluSoftlayer_notm}} アカウントに接続できない
{: #cs_credentials}

{: tsSymptoms}
新しい Kubernetes クラスターを作成すると、以下のメッセージを受け取ります。


```
We were unable to connect to your {{site.data.keyword.BluSoftlayer_notm}} account. Creating a standard cluster requires that you have either a Pay-As-You-Go account that is linked to an {{site.data.keyword.BluSoftlayer_notm}} account term or that you have used the IBM
{{site.data.keyword.Bluemix_notm}} Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
リンクされていない {{site.data.keyword.Bluemix_notm}} アカウントのユーザーは、新しい従量課金アカウントを作成するか、{{site.data.keyword.Bluemix_notm}} CLI を使用して {{site.data.keyword.BluSoftlayer_notm}} API キーを手動で追加しなければなりません。

{: tsResolve}
{{site.data.keyword.Bluemix_notm}} アカウントの資格情報を追加するには、以下のようにします。

1.  {{site.data.keyword.BluSoftlayer_notm}} 管理者に問い合わせて、{{site.data.keyword.BluSoftlayer_notm}} ユーザー名と API キーを入手します。


    **注:** 標準クラスターを正常に作成するには、使用する {{site.data.keyword.BluSoftlayer_notm}} アカウントを SuperUser 権限を付けてセットアップしなければなりません。

2.  資格情報を追加します。

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  標準クラスターを作成します。

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}


## SSH によるワーカー・ノードへのアクセスが失敗する
{: #cs_ssh_worker}

{: tsSymptoms}
SSH 接続を使用してワーカー・ノードにアクセスすることはできません。


{: tsCauses}
パスワードを使用した SSH は、ワーカー・ノードでは無効になっています。


{: tsResolve}
すべてのノードで実行する必要がある場合は [DaemonSets ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用し、一回限りのアクションを実行する必要がある場合はジョブを使用してください。


## ポッドが保留状態のままである
{: #cs_pods_pending}

{: tsSymptoms}
`kubectl get pods` を実行すると、ポッドの状態が **Pending** になる場合があります。


{: tsCauses}
Kubernetes クラスターを作成したばかりの場合は、まだワーカー・ノードが構成中の可能性があります。クラスターが以前から存在するものである場合は、ポッドをデプロイするための十分な容量がクラスター内で不足している可能性があります。

{: tsResolve}
このタスクには、[管理者アクセス・ポリシー](cs_cluster.html#access_ov)が必要です。現在の[アクセス・ポリシー](cs_cluster.html#view_access)を確認してください。

Kubernetes クラスターを作成したばかりの場合は、以下のコマンドを実行して、ワーカー・ノードが初期化するまで待ちます。


```
kubectl get nodes```
{: pre}

クラスターが以前から存在するものである場合は、クラスターの容量を確認します。

1.  デフォルトのポート番号でプロキシーを設定します。

  ```
kubectl proxy```
   {: pre}

2.  Kubernetes ダッシュボードを開きます。

  ```
http://localhost:8001/ui```
  {: pre}

3.  ポッドをデプロイするための十分な容量がクラスター内にあるか確認します。


4.  クラスターの容量が足りない場合は、クラスターに別のワーカー・ノードを追加します。


  ```
bx cs worker-add <cluster name or id> 1```
  {: pre}

5.  ワーカー・ノードが完全にデプロイされたのにまだポッドが **pending** 状態のままである場合は、[Kubernetes の資料![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) を参照して、ポッドの pending 状態のトラブルシューティングを行ってください。

## provision_failed というメッセージとともにワーカー・ノードの作成が失敗する
{: #cs_pod_space}

{: tsSymptoms}
Kubernetes クラスターを作成したり、ワーカー・ノードを追加したりするときに、provision_failed 状態になります。以下のコマンドを実行します。

```
bx cs worker-get <WORKER_NODE_ID>
```
{: pre}

以下のメッセージが表示されます。

```
SoftLayer_Exception_Virtual_Host_Pool_InsufficientResources: Could not place order. There are insufficient resources behind router bcr<router_ID> to fulfill the request for the following guests: kube-<location>-<worker_node_ID>-w1 (HTTP 500)```
{: screen}

{: tsCauses}
、{{site.data.keyword.BluSoftlayer_notm}} に現時点でワーカー･ノードをプロビジョンするための十分な容量がない可能性があります。

{: tsResolve}
オプション 1: 別の場所にクラスターを作成します。

オプション 2: {{site.data.keyword.BluSoftlayer_notm}} のサポートの問い合わせを開き、その場所の使用可能な容量を尋ねます。

## 新しいワーカー・ノード上のポッドへのアクセスがタイムアウトで失敗する
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
クラスターのワーカー・ノードを削除した後にワーカー・ノードを追加しました。ポッドまたは Kubernetes サービスをデプロイすると、新しく作成したワーカー・ノードにリソースがアクセスできずに、接続がタイムアウトになります。

{: tsCauses}
クラスターからワーカー・ノードを削除した後にワーカー・ノードを追加すると、削除されたワーカー・ノードのプライベート IP アドレスが新しいワーカー・ノードに割り当てられる場合があります。Calico はこのプライベート IP アドレスをタグとして使用して、削除されたノードにアクセスし続けます。

{: tsResolve}
正しいノードを指すように、プライベート IP アドレスの参照を手動で更新します。

1.  2 つのワーカー・ノードの**プライベート IP** アドレスが同じであることを確認します。削除されたワーカーの**プライベート IP** と **ID** をメモします。

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b1c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b1c.4x16       deleted    -
  ```
  {: screen}

2.  [Calico CLI](cs_security.html#adding_network_policies) をインストールします。
3.  Calico で使用可能なワーカー・ノードをリストします。<path_to_file> は、Calico 構成ファイルのローカル・パスに置き換えてください。

  ```
  calicoctl get nodes --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Calico で重複しているワーカー・ノードを削除します。NODE_ID はワーカー・ノード ID に置き換えてください。

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  削除されていないワーカー・ノードをリブートします。

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


削除されたノードが Calico にリストされなくなります。

## ワーカー・ノードが接続できない
{: #cs_firewall}

{: tsSymptoms}
kubectl プロキシーに障害が起きると、またはクラスター内のサービスにアクセスしようとすると、接続が失敗して次のいずれかのエラー・メッセージが表示されます。


  ```
Connection refused```
  {: screen}

  ```
Connection timed out```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

あるいは、kubectl exec、attach、または logs を使用すると、次のエラー・メッセージを受け取ります。


  ```
Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out```
  {: screen}

あるいは、kubectl プロキシーが正常に実行されても、ダッシュボードが使用できず、次のエラー・メッセージを受け取ります。


  ```
timeout on 172.xxx.xxx.xxx```
  {: screen}

あるいは、ワーカー・ノードが再ロード・ループにはまっています。

{: tsCauses}
追加のファイアウォールを設定したか、{{site.data.keyword.BluSoftlayer_notm}} アカウントの既存のファイアウォール設定をカスタマイズした可能性があります。
{{site.data.keyword.containershort_notm}} では、ワーカー・ノードと Kubernetes マスター間で通信を行うには、特定の IP アドレスとポートが開いている必要があります。


{: tsResolve}
このタスクには、[管理者アクセス・ポリシー](cs_cluster.html#access_ov)が必要です。現在の[アクセス・ポリシー](cs_cluster.html#view_access)を確認してください。

カスタマイズ済みのファイアウォールで、以下のポートと IP アドレスを開きます。

```
TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
{: pre}


<!--Inbound left for existing clusters. Once existing worker nodes are reloaded, users only need the Outbound information, which is found in the regular docs.-->

1.  以下を実行して、クラスター内のすべてのワーカー・ノードのパブリック IP アドレスをメモします。


  ```
  bx cs workers '<cluster_name_or_id>'
  ```
  {: pre}

2.  以下のように、ファイアウォールの設定で、ワーカー・ノードとの間の以下の接続を許可します。

  ```
  TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
  ```
  {: pre}

    <ul><li>ワーカー・ノードへのインバウンド接続として、以下のソース・ネットワーク・グループと IP アドレスから宛先 TCP/UDP ポート 10250 と `<public_IP_of _each_worker_node>` への着信ネットワーク・トラフィックを許可します。</br>
    
    <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
    <thead>
      <th colspan=2><img src="images/idea.png"/>インバウンド IP アドレス</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.144.128/28
</code></br><code>169.50.169.104/29</code></br><code>169.50.185.32/27
</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.232/29 </code></br><code>169.48.138.64/26
</code></br><code>169.48.180.128/25</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.8/29</code></br><code>169.47.79.192/26
</code></br><code>169.47.126.192/27
</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.48.160/28
</code></br><code>169.50.56.168/29</code></br><code>169.50.58.160/27
</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.68.192/26</code></td>
      </tr>
      <tr>
       <td>syd01
</td>
       <td><code>168.1.209.192/26</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.67.0/26</code></td>
      </tr>
    </table>

    <li>ワーカー・ノードからのアウトバウンド接続として、ソース・ワーカー・ノードから、`<each_worker_node_publicIP>` の宛先 TCP/UDP ポート範囲 (20000 から 32767 まで) への発信ネットワーク・トラフィック、および以下の IP アドレスとネットワーク・グループへの発信ネットワーク・トラフィックを許可します。</br>
    
    <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
    <thead>
      <th colspan=2><img src="images/idea.png"/> アウトバウンド IP アドレス</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01
</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>
    
    

## Ingress 経由でアプリに接続できない
{: #cs_ingress_fails}

{: tsSymptoms}
クラスターでアプリ用の Ingress リソースを作成して、アプリをパブリックに公開しました。Ingress コントローラーのパブリック IP アドレスまたはサブドメインを経由してアプリに接続しようとすると、接続に失敗するかタイムアウトになります。

{: tsCauses}
次の理由で、Ingress が正しく機能していない可能性があります。
<ul><ul>
<li>クラスターがまだ完全にデプロイされていません。<li>クラスターが、ライト・クラスターとして、またはワーカー・ノードが 1 つしかない標準クラスターとしてセットアップされました。
<li>Ingress 構成スクリプトにエラーがあります。</ul></ul>

{: tsResolve}
Ingress のトラブルシューティングを行うには、以下のようにします。

1.  標準クラスターをセットアップしたこと、クラスターが完全にデプロイされていること、また、Ingress コントローラーの高可用性を確保するためにクラスターに 2 つ以上のワーカー・ノードがあることを確認します。

  ```
    bx cs workers <cluster_name_or_id>
    ```
  {: pre}

    CLI 出力で、ワーカー・ノードの **Status** に **Ready** と表示され、**Machine Type** に **free** 以外のマシン・タイプが表示されていることを確認します。

2.  Ingress コントローラーのサブドメインとパブリック IP アドレスを取得し、それぞれを ping します。

    1.  Ingress コントローラーのサブドメインを取得します。

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Ingress コントローラーのサブドメインを ping します。

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Ingress コントローラーのパブリック IP アドレスを取得します。

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Ingress コントローラーのパブリック IP アドレスを ping します。

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Ingress コントローラーのパブリック IP アドレスまたはサブドメインで CLI からタイムアウトが返された場合は、カスタム・ファイアウォールをセットアップしてワーカー・ノードを保護しているのであれば、[ファイアウォール](#cs_firewall)で追加のポートとネットワーキング・グループを開く必要があります。

3.  カスタム・ドメインを使用している場合は、ドメイン・ネーム・サービス (DNS) プロバイダーで、カスタム・ドメインが IBM 提供の Ingress コントローラーのパブリック IP アドレスまたはサブドメインにマップされていることを確認します。
    1.  Ingress コントローラーのサブドメインを使用した場合は、正規名レコード (CNAME) を確認します。
    2.  Ingress コントローラーのパブリック IP アドレスを使用した場合は、カスタム・ドメインがポインター・レコード (PTR) でポータブル・パブリック IP アドレスにマップされていることを確認します。
4.  Ingress 構成ファイルを確認します。

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tlssecret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Ingress コントローラーのサブドメインと TLS 証明書が正しいことを確認します。IBM 提供のサブドメインと TLS 証明書を見つけるには、bx cs cluster-get <cluster_name_or_id> を実行します。
    2.  アプリが、Ingress の **path** セクションで構成されているパスを使用して listen していることを確認します。アプリがルート・パスで listen するようにセットアップされている場合は、**/** をパスとして含めます。
5.  Ingress デプロイメントを確認して、エラー・メッセージがないか探します。

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Ingress コントローラーのログを確認します。
    1.  クラスター内で稼働している Ingress ポッドの ID を取得します。

      ```
      kubectl get pods -n kube-system |grep ingress
      ```
      {: pre}

    2.  Ingress ポッドごとにログを取得します。

      ```
      kubectl logs <ingress_pod_id> -n kube-system
      ```
      {: pre}

    3.  Ingress コントローラーのログでエラー・メッセージを探します。

## ロード・バランサー・サービス経由でアプリに接続できない
{: #cs_loadbalancer_fails}

{: tsSymptoms}
クラスター内にロード・バランサー・サービスを作成して、アプリをパブリックに公開しました。ロード・バランサーのパブリック IP アドレス経由でアプリに接続しようとすると、接続が失敗するかタイムアウトになります。

{: tsCauses}
次のいずれかの理由で、ロード・バランサー・サービスが正しく機能していない可能性があります。

-   クラスターが、ライト・クラスターであるか、またはワーカー・ノードが 1 つしかない標準クラスターです。
-   クラスターがまだ完全にデプロイされていません。
-   ロード・バランサー・サービスの構成スクリプトにエラーが含まれています。

{: tsResolve}
ロード・バランサー・サービスのトラブルシューティングを行うには、以下のようにします。

1.  標準クラスターをセットアップしたこと、クラスターが完全にデプロイされていること、また、ロード・バランサー・サービスの高可用性を確保するためにクラスターに 2 つ以上のワーカー・ノードがあることを確認します。

  ```
    bx cs workers <cluster_name_or_id>
    ```
  {: pre}

    CLI 出力で、ワーカー・ノードの **Status** に **Ready** と表示され、**Machine Type** に **free** 以外のマシン・タイプが表示されていることを確認します。

2.  ロード・バランサー・サービスの構成ファイルが正しいことを確認します。

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selectorkey>:<selectorvalue>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  サービスのタイプとして **LoadBlanacer** を定義したことを確認します。
    2.  アプリをデプロイするときに **label/metadata** セクションで使用したものと同じ **<selectorkey>** と **<selectorvalue>** を使用していることを確認します。
    3.  アプリで listen している **port** を使用していることを確認します。

3.  ロード・バランサー・サービスを確認し、**Events** セクションを参照して、エラーがないか探します。

  ```
    kubectl describe service <myservice>
    ```
  {: pre}

    次のようなエラー・メッセージを探します。
<ul><ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code>
</pre></br>ロード・バランサー・サービスを使用するには、2 つ以上のワーカー・ノードがある標準クラスターでなければなりません。
<li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code>
</pre></br>このエラー・メッセージは、ロード・バランサー・サービスに割り振れるポータブル・パブリック IP アドレスが残っていないことを示しています。クラスター用にポータブル・パブリック IP アドレスを要求する方法については、[クラスターへのサブネットの追加](cs_cluster.html#cs_cluster_subnet)を参照してください。クラスターにポータブル・パブリック IP アドレスを使用できるようになると、ロード・バランサー・サービスが自動的に作成されます。
<li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips</code>
</pre></br>**loadBalancerIP** セクションを使用してロード・バランサー・サービスのポータブル・パブリック IP アドレスを定義しましたが、そのポータブル・パブリック IP アドレスはポータブル・パブリック・サブネットに含まれていません。ロード・バランサー・サービスの構成スクリプトを変更して、使用可能なポータブル・パブリック IP アドレスを選択するか、またはスクリプトから **loadBalancerIP** セクションを削除して、使用可能なポータブル・パブリック IP アドレスが自動的に割り振られるようにします。
<li><pre class="screen"><code>No available nodes for load balancer services</code>
</pre>ワーカー・ノードが不足しているため、ロード・バランサー・サービスをデプロイできません。複数のワーカー・ノードを持つ標準クラスターをデプロイしましたが、ワーカー・ノードのプロビジョンが失敗した可能性があります。
<ol><li>使用可能なワーカー・ノードのリストを表示します。</br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>使用可能なワーカー・ノードが 2 つ以上ある場合は、ワーカー・ノードの詳細情報をリストします。</br><pre class="screen"><code>bx cs worker-get <worker_ID></code></pre>
    <li>「kubectl get nodes」コマンドと「bx cs worker-get」コマンドから返されたワーカー・ノードのパブリック VLAN ID とプライベート VLAN ID が一致していることを確認します。</ol></ul></ul>

4.  カスタム・ドメインを使用してロード・バランサー・サービスに接続している場合は、カスタム・ドメインがロード・バランサー・サービスのパブリック IP アドレスにマップされていることを確認します。
    1.  ロード・バランサー・サービスのパブリック IP アドレスを見つけます。

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  カスタム・ドメインが、ポインター・レコード (PTR) でロード・バランサー・サービスのポータブル・パブリック IP アドレスにマップされていることを確認します。

## 既知の問題
{: #cs_known_issues}

既知の問題について説明します。
{: shortdesc}

### クラスター
{: #ki_clusters}

<dl>
  <dt>同じ {{site.data.keyword.Bluemix_notm}} スペース内の Cloud Foundry アプリがクラスターにアクセスできない</dt>
    <dd>Kubernetes クラスターを作成すると、クラスターはアカウント・レベルで作成され、スペースを使用しません ({{site.data.keyword.Bluemix_notm}} サービスをバインドする場合を除く)。クラスターからアクセスする Cloud Foundry アプリがある場合は、その Cloud Foundry アプリをパブリックに利用可能にするか、クラスター内のアプリを[パブリックに利用可能にする](cs_planning.html#cs_planning_public_network)必要があります。</dd>
  <dt>Kubernetes ダッシュボード NodePort サービスが無効になっている</dt>
    <dd>セキュリティー上の理由により、Kubernetes ダッシュボード NodePort サービスは無効になっています。
Kubernetes ダッシュボードにアクセスするには、以下のコマンドを実行します。
</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>これにより、`http://localhost:8001/ui` から Kubernetes ダッシュボードにアクセスできるようになります。</dd>
  <dt>ロード・バランサーのサービス・タイプに制約がある</dt>
    <dd><ul><li>プライベート VLAN では、ロード・バランシングは使用できません。
<li>service.beta.kubernetes.io/external-traffic サービスと service.beta.kubernetes.io/healthcheck-nodeport サービスのアノテーションを使用することはできません。
これらのアノテーションについて詳しくは、[Kubernetes の資料![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/services/source-ip/) を参照してください。</ul></dd>
  <dt>水平自動スケーリングが機能しない</dt>
    <dd>セキュリティー上の理由で、Heapster によって使用される標準のポート (10255) はすべてのワーカー・ノードで閉じられています。
このポートが閉じられていて Heapster がワーカー・ノードのメトリックを報告できないので、水平自動スケーリングは Kubernetes 資料の [Horizontal Pod Autoscaling ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) の説明のようには機能しません。</dd>
</dl>

### 永続ストレージ 
{: #persistent_storage}

`kubectl describe <pvc_name>` コマンドを実行すると、永続ボリュームの請求に対して **ProvisioningFailed** が表示されます。
<ul><ul>
<li>永続ボリューム請求を行う時に、利用できる永続ボリュームがないため、Kubernetes はメッセージ **ProvisioningFailed** を返します。
<li>永続ボリュームが作成され、それが請求にバインドされると、Kubernetes はメッセージ **ProvisioningSucceeded** を返します。
この処理には数分かかる場合があります。
</ul></ul>

## ヘルプとサポートの取得
{: #ts_getting_help}

コンテナーのトラブルシューティングを開始するには、以下の方法があります。

-   {{site.data.keyword.Bluemix_notm}} が使用可能かどうかを確認するために、[{{site.data.keyword.Bluemix_notm}} 状況ページを確認します![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status)。
-   [{{site.data.keyword.containershort_notm}} Slack![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) に質問を投稿します。{{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、[crosen@us.ibm.com](mailto:crosen@us.ibm.com) に問い合わせて、この Slack への招待を要求してください。
-   フォーラムを確認して、同じ問題が他のユーザーで起こっているかどうかを調べます。
フォーラムを使用して質問するときは、{{site.data.keyword.Bluemix_notm}} 開発チームの目に止まるように、質問にタグを付けてください。


    -   {{site.data.keyword.containershort_notm}} を使用したクラスターまたはアプリの開発やデプロイに関する技術的な質問がある場合は、[Stack Overflow![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://stackoverflow.com/search?q=bluemix+containers) に質問を投稿し、`ibm-bluemix`、`kubernetes`、`containers` のタグを付けてください。
    -   サービスや概説の説明について質問がある場合は、[IBM developerWorks dW Answers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) フォーラムを使用してください。`bluemix` と `containers` のタグを含めてください。
フォーラムの使用について詳しくは、[ヘルプの取得](/docs/support/index.html#getting-help)を参照してください。


-   IBM サポートにお問い合わせください。
IBM サポート・チケットを開く方法や、サポート・レベルとチケットの重大度については、[サポートへのお問い合わせ](/docs/support/index.html#contacting-support)を参照してください。

