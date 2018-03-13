---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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

{{site.data.keyword.containershort_notm}} を使用する際は、ここに示すトラブルシューティング手法やヘルプの利用手法を検討してください。 [{{site.data.keyword.Bluemix_notm}} システムの状況 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status) を確認することもできます。

いくつかの一般的な手順を実行することにより、クラスターが最新のものであることを確認できます。
- 定期的に[ワーカー・ノードをリブートして](cs_cli_reference.html#cs_worker_reboot)、IBM によってオペレーティング・システムに自動的にデプロイされる更新プログラムとセキュリティー・パッチがインストールされるようにします
- クラスターを {{site.data.keyword.containershort_notm}} 用の [Kubernetes の最新のデフォルト・バージョン](cs_versions.html)に更新します

{: shortdesc}

<br />




## クラスターのデバッグ
{: #debug_clusters}

クラスターをデバッグするためのオプションを確認し、障害の根本原因を探します。

1.  クラスターをリストし、クラスターの `State` を見つけます。

  ```
  bx cs clusters
  ```
  {: pre}

2.  クラスターの `State` を確認します。

  <table summary="表の行はすべて左から右に読みます。1 列目はクラスターの状態、2 列目は説明です。">
    <thead>
    <th>クラスターの状態</th>
    <th>説明</th>
    </thead>
    <tbody>
  
  <tr>
      <td>Critical</td>
      <td>Kubernetes マスターにアクセスできないか、クラスター内のワーカー・ノードがすべてダウンしています。</td>
     </tr>
  
      <tr>
        <td>Deploying</td>
        <td>Kubernetes マスターがまだ完全にデプロイされていません。 クラスターにアクセスできません。</td>
       </tr>
       <tr>
        <td>Normal</td>
        <td>クラスター内のすべてのワーカー・ノードが稼働中です。 クラスターにアクセスし、アプリをクラスターにデプロイできます。</td>
     </tr>
       <tr>
        <td>Pending</td>
        <td>Kubernetes マスターはデプロイされています。 ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。 クラスターにはアクセスできますが、アプリをクラスターにデプロイすることはできません。</td>
      </tr>
  
     <tr>
        <td>Warning</td>
        <td>クラスター内の 1 つ以上のワーカー・ノードが使用不可です。ただし、他のワーカー・ノードが使用可能であるため、ワークロードを引き継ぐことができます。</td>
     </tr>  
    </tbody>
  </table>

3.  クラスターが **Warning**、**Critical**、または **Delete failed** 状態の場合、あるいは **Pending** 状態が長時間続いている場合は、ワーカー・ノードの状態を確認してください。クラスターが **Deploying** 状態の場合は、クラスターが完全にデプロイされるまで待ってからクラスターの正常性を確認してください。 **Normal** 状態のクラスターは、この時点ではアクションは不要です。 
<p>ワーカー・ノードの状態を確認するには、以下のようにします。</p>

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
       <td>次のいずれかの理由で、Kubernetes マスターにアクセスできません。<ul><li>Kubernetes マスターの更新を要求しました。 更新中は、ワーカー・ノードの状態を取得できません。</li><li>ワーカー・ノードを保護している追加のファイアウォールが存在するか、最近ファイアウォールの設定が変更された可能性があります。 {{site.data.keyword.containershort_notm}} では、ワーカー・ノードと Kubernetes マスター間で通信を行うには、特定の IP アドレスとポートが開いている必要があります。 詳しくは、[ファイアウォールがあるためにワーカー・ノードが接続しない](#cs_firewall)を参照してください。</li><li>Kubernetes マスターがダウンしています。 [{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#getting-customer-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</li></ul></td>
      </tr>
      <tr>
        <td>Provisioning</td>
        <td>ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。 CLI 出力の **Status** 列で、プロビジョニングのプロセスをモニターできます。 ワーカー・ノードが長時間この状態であるのに、**Status** 列で処理の進行が見られない場合は、次のステップに進んで、プロビジョニング中に問題が発生していないか調べてください。</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>ワーカー・ノードをプロビジョンできませんでした。 次のステップに進んで、障害に関する詳細を調べてください。</td>
      </tr>
      <tr>
        <td>Reloading</td>
        <td>ワーカー・ノードは再ロード中であるため、クラスターでは使用できません。 CLI 出力の **Status** 列で、再ロードのプロセスをモニターできます。 ワーカー・ノードが長時間この状態であるのに、**Status** 列で処理の進行が見られない場合は、次のステップに進んで、再ロード中に問題が発生していないか調べてください。</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>ワーカー・ノードを再ロードできませんでした。 次のステップに進んで、障害に関する詳細を調べてください。</td>
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
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

5.  一般的なエラー・メッセージを確認し、解決方法を調べます。

  <table>
    <thead>
    <th>エラー・メッセージ</th>
    <th>説明と解決
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Your account is currently prohibited from ordering 'Computing Instances'.</td>
        <td>ご使用の IBM Cloud インフラストラクチャー (SoftLayer) アカウントは、コンピュート・リソースの注文を制限されている可能性があります。 [{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#getting-customer-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not place order. There are insufficient resources behind router 'router_name' to fulfill the request for the following guests: 'worker_id'.</td>
        <td>選択した VLAN に関連付けられているデータ・センター内のポッドのスペースが不足しているため、ワーカー・ノードをプロビジョンできません。 以下の選択肢があります。<ul><li>別のデータ・センターを使用してワーカー・ノードをプロビジョンします。 使用可能なデータ・センターをリストするには、<code>bx cs locations</code> を実行します。<li>データ・センター内の別のポッドに関連付けられているパブリック VLAN とプライベート VLAN の既存のペアがある場合は、代わりにその VLAN ペアを使用します。<li>[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#getting-customer-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not obtain network VLAN with id: &lt;vlan id&gt;.</td>
        <td>次のいずれかの理由で、選択した VLAN ID が見つからなかったため、ワーカー・ノードをプロビジョンできませんでした。<ul><li>VLAN ID ではなく VLAN 番号を指定した可能性があります。 VLAN 番号の長さは 3 桁または 4 桁ですが、VLAN ID の長さは 7 桁です。 VLAN ID を取得するには、<code>bx cs vlans &lt;location&gt;</code> を実行してください。<li>ご使用の IBM Cloud インフラストラクチャー (SoftLayer) アカウントに VLAN ID が関連付けられていない可能性があります。 アカウントの使用可能な VLAN ID をリストするには、<code>bx cs vlans &lt;location&gt;</code> を実行します。 IBM Cloud インフラストラクチャー (SoftLayer) アカウントを変更するには、[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set) を参照してください。 </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500)</td>
        <td>ご使用の IBM Cloud インフラストラクチャー (SoftLayer) は、選択したデータ・センター内のコンピュート・リソースを注文するようにセットアップされていません。 [{{site.data.keyword.Bluemix_notm}} サポート](/docs/get-support/howtogetsupport.html#getting-customer-support)に問い合わせて、アカウントが正しくセットアップされているか確認してください。</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers

        </br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.</td>
        <td>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオからワーカー・ノードをプロビジョンするために必要なアクセス権限がない可能性があります。 [IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセス権限を構成して標準の Kubernetes クラスターを作成する](cs_infrastructure.html#unify_accounts)を参照してください。</td>
      </tr>
    </tbody>
  </table>

<br />




## アプリ・デプロイメントのデバッグ
{: #debug_apps}

アプリ・デプロイメントをデバッグするためのオプションを確認し、障害の根本原因を探します。

1. `describe` コマンドを実行して、サービス・リソースまたはデプロイメント・リソース内の異常を見つけます。

 例:
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [コンテナーが ContainerCreating 状態で停滞しているかどうかを確認します](#stuck_creating_state)。

3. クラスターが `Critical` 状態かどうかを確認します。 クラスターが `Critical` 状態の場合、ファイアウォール・ルールを調べて、マスターがワーカー・ノードと通信できることを検査します。

4. サービスが正しいポートで listen していることを確認します。
   1. ポッドの名前を取得します。
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. コンテナーにログインします。
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. コンテナー内からアプリに対して curl を実行します。 ポートにアクセスできない場合、サービスは正しいポートで listen していないか、またはアプリに問題が生じている可能性があります。 正しいポートを指定してサービスの構成ファイルを更新して再デプロイするか、またはアプリに存在する可能性がある問題を調査します。
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. サービスがポッドに正しくリンクされていることを確認します。
   1. ポッドの名前を取得します。
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. コンテナーにログインします。
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. サービスのクラスター IP アドレスとポートに対して curl を実行します。 IP アドレスとポートにアクセスできない場合、サービスのエンドポイントを調べます。 エンドポイントがない場合は、サービスのセレクターがポッドと一致していません。 エンドポイントがある場合は、サービスの宛先ポート・フィールドを調べて、ポッドに使用されているポートが宛先ポートと同じであることを確認します。
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Ingress サービスの場合、クラスター内からサービスにアクセスできることを検証します。
   1. ポッドの名前を取得します。
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. コンテナーにログインします。
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Ingress サービス用に指定された URL に対して curl を実行します。 URL にアクセスできない場合、クラスターと外部エンドポイントの間にファイアウォールの問題が生じていないかを調べます。 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />


## インフラストラクチャー・アカウントに接続できない
{: #cs_credentials}

{: tsSymptoms}
新しい Kubernetes クラスターを作成すると、以下のメッセージを受け取ります。

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account.
Creating a standard cluster requires that you have either a Pay-As-You-Go account
that is linked to an IBM Cloud infrastructure (SoftLayer) account term or that you have used the {{site.data.keyword.Bluemix_notm}}
Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
リンクされていない {{site.data.keyword.Bluemix_notm}} アカウントのユーザーは、新しい従量課金アカウントを作成するか、{{site.data.keyword.Bluemix_notm}} CLI を使用して IBM Cloud インフラストラクチャー (SoftLayer) API キーを手動で追加する必要があります。

{: tsResolve}
{{site.data.keyword.Bluemix_notm}} アカウントの資格情報を追加するには、以下のようにします。

1.  IBM Cloud インフラストラクチャー (SoftLayer) 管理者に連絡して、IBM Cloud インフラストラクチャー (SoftLayer) のユーザー名と API キーを入手します。

    **注:** 標準クラスターを正常に作成するには、使用する IBM Cloud インフラストラクチャー (SoftLayer) アカウントに SuperUser 権限がセットアップされている必要があります。

2.  資格情報を追加します。

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  標準クラスターを作成します。

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## ファイアウォールがあるために CLI コマンドを実行できない
{: #ts_firewall_clis}

{: tsSymptoms}
CLI からコマンド `bx`、`kubectl`、または `calicoctl` を実行すると、失敗します。

{: tsCauses}
ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている可能性があります。

{: tsResolve}
[CLI コマンドでの TCP アクセスを許可します](cs_firewall.html#firewall)。 このタスクには、[管理者アクセス・ポリシー](cs_users.html#access_policies)が必要です。 現在の[アクセス・ポリシー](cs_users.html#infra_access)を確認してください。


## ファイアウォールがあるためにクラスターからリソースに接続できない
{: #cs_firewall}

{: tsSymptoms}
ワーカー・ノードを接続できない場合、さまざまな症状が出現することがあります。 kubectl プロキシーに障害が起きると、またはクラスター内のサービスにアクセスしようとして接続が失敗すると、次のいずれかのメッセージが表示されることがあります。

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

kubectl exec、attach、または logs を実行する場合、以下のメッセージが表示されることがあります。

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

kubectl プロキシーが正常に実行されても、ダッシュボードを使用できない場合は、次のエラー・メッセージが表示されることがあります。

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
追加のファイアウォールを設定したか、IBM Cloud インフラストラクチャー (SoftLayer) アカウントの既存のファイアウォール設定をカスタマイズした可能性があります。 {{site.data.keyword.containershort_notm}} では、ワーカー・ノードと Kubernetes マスター間で通信を行うには、特定の IP アドレスとポートが開いている必要があります。 別の原因として、ワーカー・ノードが再ロード・ループにはまっている可能性があります。

{: tsResolve}
[クラスターからインフラストラクチャー・リソースや他のサービスへのアクセスを許可](cs_firewall.html#firewall_outbound)します。 このタスクには、[管理者アクセス・ポリシー](cs_users.html#access_policies)が必要です。 現在の[アクセス・ポリシー](cs_users.html#infra_access)を確認してください。

<br />



## SSH によるワーカー・ノードへのアクセスが失敗する
{: #cs_ssh_worker}

{: tsSymptoms}
SSH 接続を使用してワーカー・ノードにアクセスすることはできません。

{: tsCauses}
パスワードを使用した SSH は、ワーカー・ノードでは無効になっています。

{: tsResolve}
すべてのノードで実行する必要がある場合は [DaemonSets ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用し、一回限りのアクションを実行する必要がある場合はジョブを使用してください。

<br />



## サービスをクラスターにバインドすると同名エラーが発生する
{: #cs_duplicate_services}

{: tsSymptoms}
`bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>` を実行すると、以下のメッセージが表示されます。

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
異なる地域にある複数のサービス・インスタンスの名前が等しい可能性があります。

{: tsResolve}
`bx cs cluster-service-bind` コマンドで、サービス・インスタンス名ではなくサービス GUID を使用してください。

1. [バインドするサービス・インスタンスが含まれる地域にログインします。](cs_regions.html#bluemix_regions)

2. サービス・インスタンスの GUID を取得します。
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  出力:
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. サービスをクラスターに再びバインドします。
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## ワーカー・ノードを更新または再ロードした後に、重複するノードとポッドが表示される
{: #cs_duplicate_nodes}

{: tsSymptoms}
`kubectl get nodes` を実行すると、状況が **NotReady** の重複したワーカー・ノードが表示されます。 **NotReady** のワーカー・ノードにはパブリック IP アドレスがありますが、**Ready** のワーカー・ノードにはプライベート IP アドレスがあります。

{: tsCauses}
以前のクラスターでは、クラスターのパブリック IP アドレスごとにワーカー・ノードがリストされていました。 現在は、ワーカー・ノードはクラスターのプライベート IP アドレスごとにリストされています。 ノードを再ロードまたは更新すると、IP アドレスは変更されますがパブリック IP アドレスへの参照は残ります。

{: tsResolve}
これらの重複によってサービスが中断されることはありませんが、以前のワーカー・ノード参照を API サーバーから除去する必要があります。

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />




## 新しいワーカー・ノード上のポッドへのアクセスがタイムアウトで失敗する
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
クラスターのワーカー・ノードを削除した後にワーカー・ノードを追加しました。 ポッドまたは Kubernetes サービスをデプロイすると、新しく作成したワーカー・ノードにリソースがアクセスできずに、接続がタイムアウトになります。

{: tsCauses}
クラスターからワーカー・ノードを削除した後にワーカー・ノードを追加すると、削除されたワーカー・ノードのプライベート IP アドレスが新しいワーカー・ノードに割り当てられる場合があります。 Calico はこのプライベート IP アドレスをタグとして使用して、削除されたノードにアクセスし続けます。

{: tsResolve}
正しいノードを指すように、プライベート IP アドレスの参照を手動で更新します。

1.  2 つのワーカー・ノードの**プライベート IP** アドレスが同じであることを確認します。 削除されたワーカーの**プライベート IP** と **ID** をメモします。

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b2c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b2c.4x16       deleted    -
  ```
  {: screen}

2.  [Calico CLI](cs_network_policy.html#adding_network_policies) をインストールします。
3.  Calico で使用可能なワーカー・ノードをリストします。 <path_to_file> は、Calico 構成ファイルのローカル・パスに置き換えてください。

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

4.  Calico で重複しているワーカー・ノードを削除します。 NODE_ID はワーカー・ノード ID に置き換えてください。

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

<br />




## ポッドが保留状態のままである
{: #cs_pods_pending}

{: tsSymptoms}
`kubectl get pods` を実行すると、ポッドの状態が **Pending** になる場合があります。

{: tsCauses}
Kubernetes クラスターを作成したばかりの場合は、まだワーカー・ノードが構成中の可能性があります。 クラスターが以前から存在するものである場合は、ポッドをデプロイするための十分な容量がクラスター内で不足している可能性があります。

{: tsResolve}
このタスクには、[管理者アクセス・ポリシー](cs_users.html#access_policies)が必要です。 現在の[アクセス・ポリシー](cs_users.html#infra_access)を確認してください。

Kubernetes クラスターを作成したばかりの場合は、以下のコマンドを実行して、ワーカー・ノードが初期化するまで待ちます。

```
kubectl get nodes
```
{: pre}

クラスターが以前から存在するものである場合は、クラスターの容量を確認します。

1.  デフォルトのポート番号でプロキシーを設定します。

  ```
  kubectl proxy
  ```
   {: pre}

2.  Kubernetes ダッシュボードを開きます。

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  ポッドをデプロイするための十分な容量がクラスター内にあるか確認します。

4.  クラスターの容量が足りない場合は、クラスターに別のワーカー・ノードを追加します。

  ```
  bx cs worker-add <cluster name or id> 1
  ```
  {: pre}

5.  ワーカー・ノードが完全にデプロイされたのにまだポッドが **pending** 状態のままである場合は、[Kubernetes の資料![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) を参照して、ポッドの pending 状態のトラブルシューティングを行ってください。

<br />




## ポッドが作成状態で停滞している
{: #stuck_creating_state}

{: tsSymptoms}
`kubectl get pods -o wide` を実行すると、同じワーカー・ノードで稼働している複数のポッドが `ContainerCreating` 状態で停滞していることが判明します。

{: tsCauses}
ワーカー・ノード上のファイル・システムは読み取り専用です。

{: tsResolve}
1. ワーカー・ノード上またはコンテナー内に保管されている可能性のあるデータをバックアップします。
2. 以下のコマンドを実行してワーカー・ノードを再作成します。

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

<br />




## コンテナーが開始しない
{: #containers_do_not_start}

{: tsSymptoms}
ポッドはクラスターに正常にデプロイされましたが、コンテナーが開始しません。

{: tsCauses}
レジストリーの割り当て量に到達すると、コンテナーが開始しないことがあります。

{: tsResolve}
[{{site.data.keyword.registryshort_notm}} 内のストレージを解放してください。](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />




## ログが表示されない
{: #cs_no_logs}

{: tsSymptoms}
Kibana ダッシュボードにアクセスするとき、ログが表示されません。

{: tsResolve}
以下に示されている、ログが表示されない理由および対応するトラブルシューティング手順を確認してください。

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>現象の理由</th>
 <th>修正方法</th>
 </thead>
 <tbody>
 <tr>
 <td>ロギング構成がセットアップされていない。</td>
 <td>ログが送信されるようにするには、まずログを {{site.data.keyword.loganalysislong_notm}} に転送するようにロギング構成を作成する必要があります。 ロギング構成を作成するには、<a href="cs_health.html#log_sources_enable">ログ転送の有効化</a>を参照してください。</td>
 </tr>
 <tr>
 <td>クラスターが <code>Normal</code> 状態ではない。</td>
 <td>クラスターの状態を確認する方法については、<a href="cs_troubleshoot.html#debug_clusters">クラスターのデバッグ</a>を参照してください。</td>
 </tr>
 <tr>
 <td>ログ・ストレージの割り当て量に達している。</td>
 <td>ログ・ストレージの限度を増やす方法については、<a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html">{{site.data.keyword.loganalysislong_notm}} の資料</a>を参照してください。</td>
 </tr>
 <tr>
 <td>クラスター作成の際にスペースを指定した場合、アカウント所有者に、そのスペースに対する管理者、開発者、または監査員の権限がない。</td>
 <td>アカウント所有者のアクセス許可を変更するには、以下のようにします。<ol><li>クラスターのアカウント所有者を見つけるために、<code>bx cs api-key-info &lt;cluster_name_or_ID&gt;</code> を実行します。</li><li>そのアカウント所有者にスペースに対する管理者、開発者、または監査員の {{site.data.keyword.containershort_notm}} アクセス許可を付与する方法については、<a href="cs_users.html#managing">クラスター・アクセス権限の管理</a>を参照してください。</li><li>許可が変更された後にロギング・トークンをリフレッシュするには、<code>bx cs logging-config-refresh &lt;cluster_name_or_ID&gt;</code> を実行します。</li></ol></td>
 </tr>
 </tbody></table>

トラブルシューティング中に行った変更をテストするには、複数のログ・イベントを生成するサンプルのポッド Noisy をクラスター内のワーカー・ノードにデプロイすることができます。

  1. クラスター上のログの生成を開始する場所に [CLI のターゲット](cs_cli_install.html#cs_cli_configure)を設定します。

  2. `deploy-noisy.yaml` 構成ファイルを作成します。

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. クラスターのコンテキストで構成ファイルを実行します。

        ```
        kubectl apply -f <filepath_to_noisy>
        ```
        {:pre}

  4. 数分後に、Kibana ダッシュボードにログが表示されます。 Kibana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントを選択します。 クラスター作成の際にスペースを指定した場合は、代わりにそのスペースに移動します。
      - 米国南部および米国東部: https://logging.ng.bluemix.net
      - 英国南部: https://logging.eu-gb.bluemix.net
      - EU 中央: https://logging.eu-fra.bluemix.net
      - 南アジア太平洋地域: https://logging.au-syd.bluemix.net

<br />




## Kubernetes ダッシュボードに使用状況グラフが表示されない
{: #cs_dashboard_graphs}

{: tsSymptoms}
Kubernetes ダッシュボードにアクセスするとき、使用状況グラフが表示されません。

{: tsCauses}
クラスターの更新やワーカー・ノードのリブートの後に、`kube-dashboard` ポッドが更新されないことがあります。

{: tsResolve}
`kube-dashboard` ポッドを削除して、強制的に再始動してください。 ポッドは RBAC ポリシーを使用して再作成され、heapster にアクセスして使用状況情報を取得します。

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## ロード・バランサー・サービス経由でアプリに接続できない
{: #cs_loadbalancer_fails}

{: tsSymptoms}
クラスター内にロード・バランサー・サービスを作成して、アプリをパブリックに公開しました。 ロード・バランサーのパブリック IP アドレス経由でアプリに接続しようとすると、接続が失敗するかタイムアウトになります。

{: tsCauses}
次のいずれかの理由で、ロード・バランサー・サービスが正しく機能していない可能性があります。

-   クラスターが、フリー・クラスターであるか、またはワーカー・ノードが 1 つしかない標準クラスターです。
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

    1.  サービスのタイプとして **LoadBalancer** を定義したことを確認します。
    2.  アプリをデプロイするときに **label/metadata** セクションで使用したものと同じ **<selectorkey>** と **<selectorvalue>** を使用していることを確認します。
    3.  アプリで listen している **port** を使用していることを確認します。

3.  ロード・バランサー・サービスを確認し、**Events** セクションを参照して、エラーがないか探します。

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    次のようなエラー・メッセージを探します。

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>ロード・バランサー・サービスを使用するには、2 つ以上のワーカー・ノードがある標準クラスターでなければなりません。</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>このエラー・メッセージは、ロード・バランサー・サービスに割り振れるポータブル・パブリック IP アドレスが残っていないことを示しています。 クラスター用にポータブル・パブリック IP アドレスを要求する方法については、<a href="cs_subnets.html#subnets">クラスターへのサブネットの追加</a>を参照してください。 クラスターにポータブル・パブリック IP アドレスを使用できるようになると、ロード・バランサー・サービスが自動的に作成されます。</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>**loadBalancerIP** セクションを使用してロード・バランサー・サービスのポータブル・パブリック IP アドレスを定義しましたが、そのポータブル・パブリック IP アドレスはポータブル・パブリック・サブネットに含まれていません。 ロード・バランサー・サービスの構成スクリプトを変更して、使用可能なポータブル・パブリック IP アドレスを選択するか、またはスクリプトから **loadBalancerIP** セクションを削除して、使用可能なポータブル・パブリック IP アドレスが自動的に割り振られるようにします。</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>ワーカー・ノードが不足しているため、ロード・バランサー・サービスをデプロイできません。 複数のワーカー・ノードを持つ標準クラスターをデプロイしましたが、ワーカー・ノードのプロビジョンが失敗した可能性があります。</li>
    <ol><li>使用可能なワーカー・ノードのリストを表示します。</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>使用可能なワーカー・ノードが 2 つ以上ある場合は、ワーカー・ノードの詳細情報をリストします。</br><pre class="screen"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li><code>kubectl get nodes</code> コマンドと <code>bx cs [&lt;cluster_name_or_id&gt;] worker-get</code> コマンドから返されたワーカー・ノードのパブリック VLAN ID とプライベート VLAN ID が一致していることを確認します。</li></ol></li></ul>

4.  カスタム・ドメインを使用してロード・バランサー・サービスに接続している場合は、カスタム・ドメインがロード・バランサー・サービスのパブリック IP アドレスにマップされていることを確認します。
    1.  ロード・バランサー・サービスのパブリック IP アドレスを見つけます。

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  カスタム・ドメインが、ポインター・レコード (PTR) でロード・バランサー・サービスのポータブル・パブリック IP アドレスにマップされていることを確認します。

<br />


## Ingress 経由でアプリに接続できない
{: #cs_ingress_fails}

{: tsSymptoms}
クラスターでアプリ用の Ingress リソースを作成して、アプリをパブリックに公開しました。 Ingress アプリケーション・ロード・バランサーのパブリック IP アドレスまたはサブドメインを経由してアプリに接続しようとすると、接続に失敗するかタイムアウトになります。

{: tsCauses}
次の理由で、Ingress が正しく機能していない可能性があります。
<ul><ul>
<li>クラスターがまだ完全にデプロイされていません。
<li>クラスターが、フリー・クラスターとして、またはワーカー・ノードが 1 つしかない標準クラスターとしてセットアップされました。
<li>Ingress 構成スクリプトにエラーがあります。
</ul></ul>

{: tsResolve}
Ingress のトラブルシューティングを行うには、以下のようにします。

1.  標準クラスターをセットアップしたこと、クラスターが完全にデプロイされていること、また、Ingress アプリケーション・ロード・バランサーの高可用性を確保するためにクラスターに 2 つ以上のワーカー・ノードがあることを確認します。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    CLI 出力で、ワーカー・ノードの **Status** に **Ready** と表示され、**Machine Type** に **free** 以外のマシン・タイプが表示されていることを確認します。

2.  Ingress アプリケーション・ロード・バランサーのサブドメインとパブリック IP アドレスを取得し、それぞれを ping します。

    1.  Ingress コントローラーのサブドメインを取得します。

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Ingress アプリケーション・ロード・バランサーのサブドメインを ping します。

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Ingress アプリケーション・ロード・バランサーのパブリック IP アドレスを取得します。

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Ingress アプリケーション・ロード・バランサーのパブリック IP アドレスを ping します。

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Ingress アプリケーション・ロード・バランサーのパブリック IP アドレスまたはサブドメインで CLI からタイムアウトが返された場合は、カスタム・ファイアウォールをセットアップしてワーカー・ノードを保護しているのであれば、[ファイアウォール](#cs_firewall)で追加のポートとネットワーキング・グループを開く必要があります。

3.  カスタム・ドメインを使用している場合は、ドメイン・ネーム・サービス (DNS) プロバイダーで、カスタム・ドメインが IBM 提供の Ingress アプリケーション・ロード・バランサーのパブリック IP アドレスまたはサブドメインにマップされていることを確認します。
    1.  Ingress アプリケーション・ロード・バランサーのサブドメインを使用した場合は、正規名レコード (CNAME) を確認します。
    2.  Ingress アプリケーション・ロード・バランサーのパブリック IP アドレスを使用した場合は、カスタム・ドメインがポインター・レコード (PTR) でポータブル・パブリック IP アドレスにマップされていることを確認します。
4.  Ingress リソース構成ファイルを確認します。

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

    1.  Ingress アプリケーション・ロード・バランサーのサブドメインと TLS 証明書が正しいことを確認します。 IBM 提供のサブドメインと TLS 証明書を見つけるには、bx cs cluster-get <cluster_name_or_id> を実行します。
    2.  アプリが、Ingress の **path** セクションで構成されているパスを使用して listen していることを確認します。 アプリがルート・パスで listen するようにセットアップされている場合は、**/** をパスとして含めます。
5.  Ingress デプロイメントを確認して、エラー・メッセージがないか探します。

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Ingress コントローラーのログを確認します。
    1.  クラスター内で稼働している Ingress ポッドの ID を取得します。

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Ingress ポッドごとにログを取得します。

      ```
      kubectl logs <ingress_pod_id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Ingress コントローラーのログでエラー・メッセージを探します。

<br />



## Ingress アプリケーション・ロード・バランサーのシークレットの問題
{: #cs_albsecret_fails}

{: tsSymptoms}
Ingress アプリケーション・ロード・バランサーのシークレットをクラスターにデプロイした後に、{{site.data.keyword.cloudcerts_full_notm}} 内の証明書を参照すると、`Description` フィールドがそのシークレット名で更新されていません。

アプリケーション・ロード・バランサーのシークレットに関する情報をリストすると、状況は `*_failed` となっています。 例えば、`create_failed`、`update_failed`、`delete_failed` などです。

{: tsResolve}
以下に示されている、アプリケーション・ロード・バランサーのシークレットが失敗する場合の理由および対応するトラブルシューティング手順を確認してください。

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>現象の理由</th>
 <th>修正方法</th>
 </thead>
 <tbody>
 <tr>
 <td>証明書データのダウンロードやアップデートに必要なアクセス役割を持っていない。</td>
 <td>アカウント管理者に問い合わせて、{{site.data.keyword.cloudcerts_full_notm}} インスタンスに対する**オペレーター**と**エディター**の両方の役割を割り当てるように依頼してください。 詳しくは、{{site.data.keyword.cloudcerts_short}} の <a href="/docs/services/certificate-manager/about.html#identity-access-management">ID およびアクセス管理</a>を参照してください。</td>
 </tr>
 <tr>
 <td>作成時、更新時、または削除時に提供された証明書 CRN が、クラスターと同じアカウントに属していない。</td>
 <td>提供した証明書 CRN が、クラスターと同じアカウントにデプロイされた、{{site.data.keyword.cloudcerts_short}} サービスのインスタンスにインポートされていることを確認します。</td>
 </tr>
 <tr>
 <td>作成時に提供された証明書 CRN が正しくない。</td>
 <td><ol><li>提供した証明書 CRN ストリングが正確であることを確認します。</li><li>証明書 CRN が正確である場合は、シークレットの更新を試行します。 <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>このコマンドの結果が <code>update_failed</code> 状況になる場合、シークレットを削除します。 <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>シークレットを再デプロイします。 <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>更新時に提供された証明書 CRN が正しくない。</td>
 <td><ol><li>提供した証明書 CRN ストリングが正確であることを確認します。</li><li>証明書 CRN が正確である場合は、シークレットの削除を試行します。 <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>シークレットを再デプロイします。 <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>シークレットの更新を試行します。 <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>{{site.data.keyword.cloudcerts_long_notm}} サービスがダウンしている。</td>
 <td>{{site.data.keyword.cloudcerts_short}} サービスが稼働中であることを確認します。</td>
 </tr>
 </tbody></table>

<br />



## Calico CLI 構成の ETCD URL を取得できない
{: #cs_calico_fails}

{: tsSymptoms}
[ネットワーク・ポリシーを追加するための](cs_network_policy.html#adding_network_policies) `<ETCD_URL>` を取得するときに、`calico-config not found` エラー・メッセージが出されます。

{: tsCauses}
クラスターが [Kubernetes バージョン 1.7](cs_versions.html) 以降ではありません。

{: tsResolve}
[クラスターを更新する](cs_cluster_update.html#master)か、以前のバージョンの Kubernetes と互換性のあるコマンドによって `<ETCD_URL>` を取得します。

`<ETCD_URL>` を取得するには、以下のいずれかのコマンドを実行します。

- Linux および OS X:

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows:
    <ol>
    <li> kube-system 名前空間内のポッドのリストを取得し、Calico コントローラー・ポッドを見つけます。 </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>例:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Calico コントローラー・ポッドの詳細を表示します。</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> ETCD エンドポイント値を見つけます。 例: <code>https://169.1.1.1:30001</code>
    </ol>

`<ETCD_URL>` を取得するときには、(ネットワーク・ポリシーの追加)[cs_network_policy.html#adding_network_policies] にリストされている手順を続行します。

<br />




## ヘルプとサポートの取得
{: #ts_getting_help}

コンテナーのトラブルシューティングを開始するには、以下の方法があります。

-   {{site.data.keyword.Bluemix_notm}} が使用可能かどうかを確認するために、[{{site.data.keyword.Bluemix_notm}} 状況ページを確認します![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status)。
-   [{{site.data.keyword.containershort_notm}} Slack![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) に質問を投稿します。 ヒント: {{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、この Slack への[招待を要求](https://bxcs-slack-invite.mybluemix.net/)してください。
-   フォーラムを確認して、同じ問題が他のユーザーで起こっているかどうかを調べます。 フォーラムを使用して質問するときは、{{site.data.keyword.Bluemix_notm}} 開発チームの目に止まるように、質問にタグを付けてください。

    -   {{site.data.keyword.containershort_notm}} を使用したクラスターまたはアプリの開発やデプロイに関する技術的な質問がある場合は、[Stack Overflow![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) に質問を投稿し、`ibm-cloud`、`kubernetes`、`containers` のタグを付けてください。
    -   サービスや概説の説明について質問がある場合は、[IBM developerWorks dW Answers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) フォーラムを使用してください。 `ibm-cloud` と `containers` のタグを含めてください。
    フォーラムの使用について詳しくは、[ヘルプの取得](/docs/get-support/howtogetsupport.html#using-avatar)を参照してください。

-   IBM サポートにお問い合わせください。 IBM サポート・チケットを開く方法や、サポート・レベルとチケットの重大度については、[サポートへのお問い合わせ](/docs/get-support/howtogetsupport.html#getting-customer-support)を参照してください。

{:tip}
問題を報告する際に、クラスター ID も報告してください。クラスター ID を取得するには、`bx cs clusters` を実行します。
