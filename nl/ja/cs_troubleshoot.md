---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

{{site.data.keyword.containerlong}} を使用する際は、ここに示すトラブルシューティング手法やヘルプの利用手法を検討してください。 [{{site.data.keyword.Bluemix_notm}} システムの状況 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status) を確認することもできます。
{: shortdesc}

いくつかの一般的な手順を実行することにより、クラスターが最新のものであることを確認できます。
- 定期的に[ワーカー・ノードをリブートして](cs_cli_reference.html#cs_worker_reboot)、IBM によってオペレーティング・システムに自動的にデプロイされる更新プログラムとセキュリティー・パッチがインストールされるようにします
- クラスターを {{site.data.keyword.containershort_notm}} 用の [Kubernetes の最新のデフォルト・バージョン](cs_versions.html)に更新します

<br />




## クラスターのデバッグ
{: #debug_clusters}

クラスターをデバッグするためのオプションを確認し、障害の根本原因を探します。

1.  クラスターをリストし、クラスターの `State` を見つけます。

  ```
  bx cs clusters
  ```
  {: pre}

2.  クラスターの `State` を確認します。 クラスターが **Critical**、**Delete failed**、または **Warning** 状態の場合、あるいは **Pending** 状態が長時間続いている場合は、[ワーカー・ノードのデバッグ](#debug_worker_nodes)を開始してください。

    <table summary="表の行はすべて左から右に読みます。1 列目はクラスターの状態、2 列目は説明です。">
   <thead>
   <th>クラスターの状態</th>
   <th>説明</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>Kubernetes マスターがデプロイされる前にユーザーからクラスターの削除が要求されました。クラスターの削除が完了すると、クラスターはダッシュボードから除去されます。クラスターが長時間この状態になっている場合は、[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#using-avatar)を開いてください。</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>Kubernetes マスターにアクセスできないか、クラスター内のワーカー・ノードがすべてダウンしています。 </td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>Kubernetes マスターまたは 1 つ以上のワーカー・ノードを削除できません。</td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>クラスターは削除されましたが、まだダッシュボードからは除去されていません。クラスターが長時間この状態になっている場合は、[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#using-avatar)を開いてください。</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>クラスターの削除とクラスター・インフラストラクチャーの破棄を実行中です。クラスターにアクセスできません。  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>Kubernetes マスターのデプロイメントを完了できませんでした。この状態はお客様には解決できません。[{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#using-avatar)を開いて、IBM Cloud サポートに連絡してください。</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Kubernetes マスターがまだ完全にデプロイされていません。 クラスターにアクセスできません。 クラスターが完全にデプロイされるまで待ってからクラスターの正常性を確認してください。</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>クラスター内のすべてのワーカー・ノードが稼働中です。 クラスターにアクセスし、アプリをクラスターにデプロイできます。 この状態は正常と見なされるので、アクションは必要ありません。</td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Kubernetes マスターはデプロイされています。 ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。 クラスターにはアクセスできますが、アプリをクラスターにデプロイすることはできません。  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>クラスターを作成し、Kubernetes マスターとワーカー・ノードのインフラストラクチャーを注文するための要求が送信されました。クラスターのデプロイメントが開始されると、クラスターの状態は「<code>Deploying</code>」に変わります。クラスターが長時間「<code>Requested</code>」状態になっている場合は、{{site.data.keyword.Bluemix_notm}}[ サポート・チケット](/docs/get-support/howtogetsupport.html#using-avatar)を開いてください。</td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>Kubernetes マスターで実行される Kubernetes API サーバーが、新しい Kubernetes API バージョンに更新されています。更新中、クラスターにアクセスすることも変更することもできません。 ユーザーがデプロイしたワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。 更新が完了するまで待ってから、クラスターの正常性を確認してください。</td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>クラスター内の 1 つ以上のワーカー・ノードが使用不可です。ただし、他のワーカー・ノードが使用可能であるため、ワークロードを引き継ぐことができます。 </td>
    </tr>
   </tbody>
 </table>

<br />


## ワーカー・ノードのデバッグ
{: #debug_worker_nodes}

ワーカー・ノードをデバッグするためのオプションを確認し、障害の根本原因を探します。


1.  クラスターが **Critical**、**Delete failed**、または **Warning** 状態の場合、あるいは **Pending** 状態が長時間続いている場合は、ワーカー・ノードの状態を確認してください。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

2.  CLI 出力内ですべてのワーカー・ノードの `State` フィールドと `Status` フィールドを確認します。

  <table summary="表の行はすべて左から右に読みます。1 列目はクラスターの状態、2 列目は説明です。">
    <thead>
    <th>ワーカー・ノードの状態</th>
    <th>説明</th>
    </thead>
    <tbody>
  <tr>
      <td>Critical</td>
      <td>ワーカー・ノードが Critical 状態になる理由は多数あります。最も一般的な理由は、次のとおりです。<ul><li>閉鎖と排出を行わずに、ワーカー・ノードのリブートを開始しました。ワーカー・ノードのリブートによって、<code>docker</code>、<code>kubelet</code>、<code>kube-proxy</code>、<code>calico</code> でデータ破損が発生した可能性があります。</li><li>ワーカー・ノードにデプロイしたポッドが、[メモリー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) と [CPU ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/) のリソース制限を使用していません。リソース制限を使用しないと、ポッドが、使用可能なリソースをすべて使い果たして、このワーカー・ノード上の他のポッドを実行するためのリソースがなくなる可能性があります。この過剰なワークロードにより、ワーカー・ノードに障害が発生します。</li><li>何百、何千ものコンテナーを長時間実行した後、<code>Docker</code>、<code>kubelet</code>、または <code>calico</code> がリカバリー不能な状態になりました。</li><li>ワーカー・ノード用にセットアップした Vyatta が停止したために、ワーカー・ノードと Kubernetes マスターの間の通信が切断されました。
</li><li> {{site.data.keyword.containershort_notm}} または IBM Cloud インフラストラクチャー (SoftLayer) の現在のネットワーキングの問題によって、ワーカー・ノードと Kubernetes マスターが通信できなくなっています。</li><li>ワーカー・ノードが容量を使い尽くしました。ワーカー・ノードの <strong>Status</strong> に <strong>Out of disk</strong> または <strong>Out of memory</strong> と表示されていないか確認します。ワーカー・ノードが容量を使い尽くしている場合は、ワーカー・ノードのワークロードを減らすか、ワークロードの負荷を分散できるようにクラスターにワーカー・ノードを追加してください。</li></ul> 多くの場合、ワーカー・ノードを[再ロードする](cs_cli_reference.html#cs_worker_reload)と問題を解決できます。必ず、ワーカー・ノードを再ロードする前に、ワーカー・ノードを閉鎖して排出してください。これにより、既存のポッドが正常終了し、他のワーカー・ノードにスケジュールを変更されます。  </br></br> ワーカー・ノードを再ロードしても問題が解決しない場合は、次の手順に進み、ワーカー・ノードのトラブルシューティングを続けてください。</br></br><strong>ヒント:</strong> [ワーカー・ノードのヘルス・チェックを構成し、Autorecovery を有効にする](cs_health.html#autorecovery)ことができます。Autorecovery は、構成された検査に基づいて正常でないワーカー・ノードを検出すると、ワーカー・ノードの OS の再ロードのような修正アクションをトリガーします。 Autorecovery の仕組みについて詳しくは、[Autorecovery のブログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/) を参照してください。</td>
     </tr>
      <tr>
        <td>Deploying</td>
        <td>ワーカー・ノードの Kubernetes バージョンを更新する際には、更新をインストールするためにワーカー・ノードが再デプロイされます。ワーカー・ノードが長時間この状態になっている場合は、次の手順に進み、デプロイメント中に問題が発生していないか調べてください。</td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>ワーカー・ノードは完全にプロビジョンされ、クラスターで使用できる状態です。 この状態は正常と見なされるので、ユーザーのアクションは必要ありません。</td>
     </tr>
   <tr>
        <td>Provisioning</td>
        <td>ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。 CLI 出力の <strong>Status</strong> 列で、プロビジョニングのプロセスをモニターできます。 ワーカー・ノードが長時間この状態であるのに、<strong>Status</strong> 列で処理の進行が見られない場合は、次のステップに進んで、プロビジョニング中に問題が発生していないか調べてください。</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>ワーカー・ノードをプロビジョンできませんでした。 次のステップに進んで、障害に関する詳細を調べてください。</td>
      </tr>
   <tr>
        <td>Reloading</td>
        <td>ワーカー・ノードは再ロード中であるため、クラスターでは使用できません。 CLI 出力の <strong>Status</strong> 列で、再ロードのプロセスをモニターできます。 ワーカー・ノードが長時間この状態であるのに、<strong>Status</strong> 列で処理の進行が見られない場合は、次のステップに進んで、再ロード中に問題が発生していないか調べてください。</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>ワーカー・ノードを再ロードできませんでした。 次のステップに進んで、障害に関する詳細を調べてください。</td>
      </tr>
      <tr>
        <td>Reload_pending</td>
        <td>ワーカー・ノードの Kubernetes バージョンを再ロードまたは更新する要求が送信されました。ワーカー・ノードが再ロードされると、状態は「<code>Reloading</code>」に変わります。</td>
      </tr>
      <tr>
       <td>Unknown</td>
       <td>次のいずれかの理由で、Kubernetes マスターにアクセスできません。<ul><li>Kubernetes マスターの更新を要求しました。 更新中は、ワーカー・ノードの状態を取得できません。</li><li>ワーカー・ノードを保護している追加のファイアウォールが存在するか、最近ファイアウォールの設定が変更された可能性があります。 {{site.data.keyword.containershort_notm}} では、ワーカー・ノードと Kubernetes マスター間で通信を行うには、特定の IP アドレスとポートが開いている必要があります。 詳しくは、[ファイアウォールがあるためにワーカー・ノードが接続しない](#cs_firewall)を参照してください。</li><li>Kubernetes マスターがダウンしています。 [{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/get-support/howtogetsupport.html#getting-customer-support)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</li></ul></td>
  </tr>
     <tr>
        <td>Warning</td>
        <td>ワーカー・ノードが、メモリーまたはディスク・スペースの限度に達しています。 ワーカー・ノードのワークロードを減らすか、またはワークロードを分散できるようにクラスターにワーカー・ノードを追加してください。</td>
  </tr>
    </tbody>
  </table>

5.  ワーカー・ノードの詳細情報をリストします。 詳細情報にエラー・メッセージが含まれている場合は、[ワーカー・ノードに関する一般的なエラー・メッセージ](#common_worker_nodes_issues)のリストを参照して、問題の解決方法を確認してください。

   ```
   bx cs worker-get <worker_id>
   ```
   {: pre}

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

<br />


## ワーカー・ノードに関する一般的な問題
{: #common_worker_nodes_issues}

一般的なエラー・メッセージを確認し、解決方法を調べます。

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
      <tr>
       <td>Worker unable to talk to {{site.data.keyword.containershort_notm}} servers. Please verify your firewall setup is allowing traffic from this worker.
       <td><ul><li>ファイアウォールがある場合は、[該当するポートと IP アドレスへの発信トラフィックを許可するようにファイアウォール設定を構成します](cs_firewall.html#firewall_outbound)。</li><li>`bx cs workers <mycluster>` を実行して、クラスターにパブリック IP がないか確認します。パブリック IP がリストされない場合、クラスターにはプライベート VLAN だけがあります。
<ul><li>プライベート VLAN だけがあるクラスターにするには、[VLAN 接続](cs_clusters.html#worker_vlan_connection)と[ファイアウォール](cs_firewall.html#firewall_outbound)をセットアップします。
</li><li>パブリック IP があるクラスターにするには、パブリック VLAN とプライベート VLAN の両方を指定して[新しいワーカー・ノードを追加](cs_cli_reference.html#cs_worker_add)します。</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>Cannot create IMS portal token, as no IMS account is linked to the selected BSS account</br></br>Provided user not found or active</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: User account is currently cancel_pending.</td>
  <td>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスに使用される API キーの所有者には、このアクションを実行するために必要な権限がありません。あるいは、その所有者が削除の保留中である可能性があります。</br></br><strong>ユーザーは</strong>、以下の手順に従ってください。<ol><li>複数のアカウントを利用できる場合は、{{site.data.keyword.containerlong_notm}} を操作したいアカウントにログインしていることを確認します。</li><li><code>bx cs api-key-info</code> を実行して、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスに使用される現在の API キーの所有者を表示します。</li><li><code>bx account list</code> を実行して、現在使用している {{site.data.keyword.Bluemix_notm}} アカウントの所有者を表示します。</li><li>その {{site.data.keyword.Bluemix_notm}} アカウントの所有者に連絡し、前の手順で確認した API キーの所有者が IBM Cloud インフラストラクチャー (SoftLayer) の十分な権限を持っていないこと、または、その所有者が削除の保留中である可能性があることを報告します。</li></ol></br><strong>アカウント所有者は</strong>、以下の手順に従ってください。<ol><li>失敗したアクションを実行するために [IBM Cloud インフラストラクチャー (SoftLayer) に必要な権限](cs_users.html#managing)を確認します。</li><li>[<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) コマンドを使用して、API キーの所有者の権限を修正するか、新しい API キーを作成します。</li><li>自分または別のアカウント管理者が、IBM Cloud インフラストラクチャー (SoftLayer) の資格情報を手動でアカウントに設定した場合は、[<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) を実行してアカウントから資格情報を削除します。</li></ol></td>
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




## ワーカー・ノードのファイル・システムが読み取り専用に変更される
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
以下のいずれかの症状が見られることがあります。
- `kubectl get pods -o wide` を実行すると、同じワーカー・ノードで稼働している複数のポッドが `ContainerCreating` 状態で停滞していることが判明します。
- `kubectl describe` コマンドを実行すると、events セクションに `MountVolume.SetUp failed for volume ... read-only file system` というエラーが表示されます。

{: tsCauses}
ワーカー・ノード上のファイル・システムは読み取り専用です。

{: tsResolve}
1. ワーカー・ノード上またはコンテナー内に保管されている可能性のあるデータをバックアップします。
2. 既存のワーカー・ノードに対する短期的な解決策としては、ワーカー・ノードを再ロードします。

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

長期的な解決策としては、[別のワーカー・ノードを追加して、マシン・タイプを更新します](cs_cluster_update.html#machine_type)。

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
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12    203.0.113.144    b2c.4x16       normal    Ready    dal10      1.8.8
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16    203.0.113.144    b2c.4x16       deleted    -       dal10      1.8.8
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


## クラスターが保留状態のままである
{: #cs_cluster_pending}

{: tsSymptoms}
デプロイしたクラスターが、保留状態のままで開始されません。

{: tsCauses}
クラスターを作成したばかりの場合は、まだワーカー・ノードが構成中の可能性があります。 時間が経過している場合は、VLAN が無効である可能性があります。

{: tsResolve}

以下のいずれかの解決策を試してください。
  - `bx cs clusters` を実行して、クラスターの状況を確認します。その後、`bx cs workers <cluster_name>` を実行して、ワーカー・ノードがデプロイされていることを確認します。
  - VLAN が有効であることを確認します。VLAN が有効であるためには、ローカル・ディスク・ストレージを持つワーカーをホストできるインフラストラクチャーに VLAN が関連付けられている必要があります。`bx cs VLAN LOCATION` を実行して [VLAN をリスト](/docs/containers/cs_cli_reference.html#cs_vlans)できます。VLAN がリストに表示されない場合、その VLAN は有効ではありません。別の VLAN を選択してください。

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
 <td>ログが送信されるようにするには、まずログを {{site.data.keyword.loganalysislong_notm}} に転送するようにロギング構成を作成する必要があります。 ロギングの構成を作成するには、<a href="cs_health.html#logging">クラスター・ロギングの構成</a>を参照してください。</td>
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


## 永続ストレージに対する非 root ユーザー・アクセスの追加が失敗する
{: #cs_storage_nonroot}

{: tsSymptoms}
[永続ストレージに対する非 root ユーザーのアクセスを追加した](cs_storage.html#nonroot)後、または、非ルートのユーザー ID を指定して Helm チャートをデプロイした後に、そのユーザーがマウントされたストレージに書き込めません。

{: tsCauses}
デプロイメント構成または Helm チャートの構成で、ポッドの `fsGroup` (グループ ID) と `runAsUser` (ユーザー ID) に関する[セキュリティー・コンテキスト](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)が指定されています。現在、{{site.data.keyword.containershort_notm}} は `fsGroup` の指定をサポートしていません。`0` (ルート権限) に設定された `runAsUser` だけをサポートしています。

{: tsResolve}
イメージ、デプロイメント、または Helm チャートの構成ファイルから構成の `fsGroup` と `runAsUser` の `securityContext` フィールドを削除してから、再デプロイします。マウント・パスの所有権を `nobody` から変更する必要がある場合は、[非 root ユーザー・アクセスを追加します](cs_storage.html#nonroot)。

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
    <li>使用可能なワーカー・ノードが 2 つ以上ある場合は、ワーカー・ノードの詳細情報をリストします。</br><pre class="codeblock"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
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

    1.  アプリケーション・ロード・バランサーのサブドメインを取得します。

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

    1.  Ingress アプリケーション・ロード・バランサーのサブドメインと TLS 証明書が正しいことを確認します。 IBM 提供のサブドメインと TLS 証明書を見つけるには、`bx cs cluster-get <cluster_name_or_id>` を実行します。
    2.  アプリが、Ingress の **path** セクションで構成されているパスを使用して listen していることを確認します。 アプリがルート・パスで listen するようにセットアップされている場合は、**/** をパスとして含めます。
5.  Ingress デプロイメントを確認して、警告メッセージやエラー・メッセージがないか探します。

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    例えば、出力の **Events** セクションに、Ingress リソースや使用した特定のアノテーション内の無効な値に関する警告メッセージが表示される場合があります。

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xx,169.xx.xxx.xx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  アプリケーション・ロード・バランサーのログを確認します。
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

    3.  アプリケーション・ロード・バランサーのログでエラー・メッセージを探します。

<br />



## Ingress アプリケーション・ロード・バランサーのシークレットの問題
{: #cs_albsecret_fails}

{: tsSymptoms}
Ingress アプリケーション・ロード・バランサーのシークレットをクラスターにデプロイした後に、{{site.data.keyword.cloudcerts_full_notm}} 内の証明書を参照すると、`Description` フィールドがそのシークレット名で更新されていません。

アプリケーション・ロード・バランサーのシークレットに関する情報をリストすると、状況は `*_failed` となっています。 例えば、`create_failed`、`update_failed`、`delete_failed` などです。

{: tsResolve}
以下に示されている、アプリケーション・ロード・バランサーのシークレットが失敗する場合の理由および対応するトラブルシューティング手順を確認してください。

<table>
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
 <td><ol><li>提供した証明書 CRN ストリングが正確であることを確認します。</li><li>証明書 CRN が正確であることを確認した場合は、<code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code> を実行して、シークレットの更新を試行します。</li><li>このコマンドの結果が <code>update_failed</code> 状況になる場合は、<code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code> を実行して、シークレットを削除します。</li><li><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code> を実行して、シークレットを再デプロイします。</li></ol></td>
 </tr>
 <tr>
 <td>更新時に提供された証明書 CRN が正しくない。</td>
 <td><ol><li>提供した証明書 CRN ストリングが正確であることを確認します。</li><li>証明書 CRN が正確であることを確認した場合は、<code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code> を実行して、シークレットを削除します。</li><li><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code> を実行して、シークレットを再デプロイします。</li><li><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code> を実行して、シークレットの更新を試行します。</li></ol></td>
 </tr>
 <tr>
 <td>{{site.data.keyword.cloudcerts_long_notm}} サービスがダウンしている。</td>
 <td>{{site.data.keyword.cloudcerts_short}} サービスが稼働中であることを確認します。</td>
 </tr>
 </tbody></table>

<br />


## 更新した構成値で Helm チャートをインストールできない
{: #cs_helm_install}

{: tsSymptoms}
`helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>` を実行して、更新した Helm チャートをインストールしようとすると、エラー・メッセージ `Error: failed to download "ibm/<chart_name>"` を受け取ります。

{: tsCauses}
Helm インスタンス内の {{site.data.keyword.Bluemix_notm}} リポジトリーの URL が正しくない可能性があります。

{: tsResolve}
Helm チャートをトラブルシューティングするには、以下のようにします。

1. Helm インスタンス内に現在存在するリポジトリーをリストします。

    ```
    helm repo list
    ```
    {: pre}

2. 出力で、{{site.data.keyword.Bluemix_notm}} リポジトリー `ibm` の URL が `https://registry.bluemix.net/helm/ibm` であることを確認します。

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * URL が正しくない場合は、以下のようにします。

        1. {{site.data.keyword.Bluemix_notm}} リポジトリーを削除します。

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. {{site.data.keyword.Bluemix_notm}} リポジトリーを再度追加します。

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * URL が正しい場合は、リポジトリーから最新の更新を取得します。

        ```
        helm repo update
        ```
        {: pre}

3. 取得した更新を使用して、Helm チャートをインストールします。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## strongSwan Helm チャートとの VPN 接続を確立できない
{: #cs_vpn_fails}

{: tsSymptoms}
`kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status` を実行して VPN 接続を確認すると、`ESTABLISHED` 状況が表示されない、または、VPN ポッドが `ERROR` 状態になっている、または、クラッシュと再始動が繰り返されます。

{: tsCauses}
Helm チャートの構成ファイルに誤った値があるか、値が欠落しているか、構文エラーがあります。

{: tsResolve}
strongSwan Helm チャートとの VPN 接続を確立しようとすると、初めは VPN の状況が `ESTABLISHED` にならない可能性があります。いくつかのタイプの問題を確認し、それに応じて構成ファイルを変更する必要がある場合があります。strongSwan VPN 接続をトラブルシューティングするには、以下のようにします。

1. オンプレミス VPN エンドポイントの設定を、構成ファイル内の設定と照らして確認します。不一致があった場合、以下を実行します。

    <ol>
    <li>既存の Helm chart を削除します。</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li><code>config.yaml</code> ファイル内の誤った値を修正し、更新したファイルを保存します。</li>
    <li>新しい Helm チャートをインストールします。</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. VPN ポッドが `ERROR` 状態である場合や、クラッシュと再始動が繰り返される場合は、チャートの構成マップ内の `ipsec.conf` 設定のパラメーターの検証が原因である可能性があります。 

    <ol>
    <li>Strongswan ポッドのログに検証エラーがないか確認してください。</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>検証エラーがある場合は、既存の Helm チャートを削除します。</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>`config.yaml` ファイル内の誤った値を修正し、更新したファイルを保存します。</li>
    <li>新しい Helm チャートをインストールします。</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. strongSwan チャート定義に含まれている 5 つの Helm テストを実行します。

    <ol>
    <li>Helm テストを実行します。</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>いずれかのテストが失敗した場合は、[Helm VPN 接続テストについて](cs_vpn.html#vpn_tests_table)を参照して、各テストと、テストが失敗する原因として想定される原因を確認してください。<b>注</b>: テストの中には、VPN 構成ではオプションの設定を必要とするテストがあります。一部のテストが失敗しても、そのようなオプションの設定を指定したかどうかによっては、失敗を許容できる場合があります。</li>
    <li>テスト・ポッドのログを参照して、失敗したテストの出力を確認します。<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>既存の Helm chart を削除します。</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li><code>config.yaml</code> ファイル内の誤った値を修正し、更新したファイルを保存します。</li>
    <li>新しい Helm チャートをインストールします。</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>変更を確認するには、以下の手順に従います。<ol><li>現在のテスト・ポッドを取得します。</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>現在のテスト・ポッドをクリーンアップします。</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>テストを再度実行します。</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. VPN ポッド・イメージ内にパッケージされている VPN デバッグ・ツールを実行します。

    1. `STRONGSWAN_POD` 環境変数を設定します。

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. デバッグ・ツールを実行します。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        このツールは、一般的なネットワーキングの問題に関するさまざまなテストを実行して、複数の情報ページを出力します。先頭が `ERROR`、`WARNING`、`VERIFY`、または `CHECK` の出力行に、VPN 接続エラーが示されている可能性があります。

    <br />


## ワーカー・ノードの追加または削除後に strongSwan VPN 接続が失敗する
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
以前は strongSwan IPSec VPN サービスを使用して、正常に機能する VPN 接続を確立できていました。しかし、クラスターでワーカー・ノードを追加または削除した後に、以下の症状が 1 つ以上発生します。

* VPN 状況が `ESTABLISHED` にならない
* オンプレミス・ネットワークから新しいワーカー・ノードにアクセスできない
* 新しいワーカー・ノード上で実行されているポッドからリモート・ネットワークにアクセスできない

{: tsCauses}
ワーカー・ノードを追加した場合:

* 既存の `localSubnetNAT` または `local.subnet` 設定では VPN 接続を介して公開されない新しいプライベート・サブネットに、ワーカー・ノードがプロビジョンされました。
* ワーカー・ノードのテイントまたはラベルが既存の `tolerations` または `nodeSelector` 設定に含まれていないため、VPN 経路をワーカー・ノードに追加できません。
* 新しいワーカー・ノードで VPN ポッドが実行されていますが、そのワーカー・ノードのパブリック IP アドレスがオンプレミス・ファイアウォールを通過することを許可されていません。

ワーカー・ノードを削除した場合:

* 既存の `tolerations` または `nodeSelector` 設定による特定のテイントまたはラベルに対する制限のため、削除されたワーカー・ノードが、VPN ポッドを実行する唯一のノードでした。

{: tsResolve}
以下のように、ワーカー・ノードの変更を反映するように Helm チャートの値を更新します。

1. 既存の Helm chart を削除します。

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. strongSwan VPN サービスの構成ファイルを開きます。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 以下の設定を確認し、必要に応じて、削除または追加したワーカー・ノードを反映するように変更します。

    ワーカー・ノードを追加した場合:

    <table>
     <thead>
     <th>設定</th>
     <th>説明</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>追加したワーカー・ノードは、他のワーカー・ノードがある既存のサブネットとは違う新しいプライベート・サブネット上にデプロイされる可能性があります。サブネット NAT を使用してクラスターのプライベート・ローカル IP アドレスを再マップしていて、ワーカー・ノードが新しいサブネット上に追加された場合は、その新しいサブネットの CIDR をこの設定に追加してください。</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>特定のラベルのワーカー・ノード上で VPN ポッドを実行するように制限していた場合、VPN 経路をワーカーに追加するには、追加したワーカー・ノードにそのラベルがあることを確認してください。</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>追加したワーカー・ノードにテイントがある場合、VPN 経路をワーカーに追加するには、テイントがあるすべてのワーカー・ノードまたは特定のテイントのワーカー・ノードで VPN ポッドを実行できるように、この設定を変更してください。</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>追加したワーカー・ノードは、他のワーカー・ノードがある既存のサブネットとは違う新しいプライベート・サブネット上にデプロイされる可能性があります。プライベート・ネットワークの NodePort または LoadBalancer サービスでアプリを公開し、追加した新しいワーカー・ノード上にそれらのアプリがある場合は、新しいサブネットの CIDR をこの設定に追加してください。**注**: `local.subnet` に値を追加する場合は、オンプレミス・サブネットの VPN 設定を確認して、それらの設定も更新する必要があるかどうか判断してください。</td>
     </tr>
     </tbody></table>

    ワーカー・ノードを削除した場合:

    <table>
     <thead>
     <th>設定</th>
     <th>説明</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>サブネット NAT を使用して特定のプライベート・ローカル IP アドレスを再マップしている場合は、古いワーカー・ノードの IP アドレスを削除してください。サブネット NAT を使用してサブネット全体を再マップしている場合、ワーカー・ノードが 1 つも存在しなくなったサブネットの CIDR は、この設定から削除してください。</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>VPN ポッドを単一のワーカー・ノードで実行するように制限していて、そのワーカー・ノードを削除した場合は、他のワーカー・ノードで VPN ポッドを実行できるように、この設定を変更してください。</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>削除したワーカー・ノードにはテイントがなく、残りのワーカー・ノードにだけテイントがある場合は、テイントがあるすべてのワーカー・ノードまたは特定のテイントがあるワーカー・ノードで VPN ポッドを実行できるように、この設定を変更してください。
     </td>
     </tr>
     </tbody></table>

4. 更新した値を使用して新しい Helm チャートをインストールします。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Chart のデプロイメント状況を確認します。 Chart の準備ができている場合は、出力の先頭付近の **STATUS** フィールドに `DEPLOYED` の値があります。

    ```
    helm status <release_name>
    ```
    {: pre}

6. 時により、VPN 構成ファイルに加えた変更と一致するように、オンプレミス設定とファイアウォール設定を変更する必要がある場合があります。

7. VPN を開始します。
    * クラスターから VPN 接続を開始する (`ipsec.auto` を `start` に設定した) 場合は、オンプレミス・ゲートウェイの VPN を開始してからクラスターの VPN を開始します。
    * オンプレミス・ゲートウェイから VPN 接続を開始する (`ipsec.auto` を `auto` に設定した) 場合は、クラスターの VPN を開始してからオンプレミス・ゲートウェイの VPN を開始します。

8. `STRONGSWAN_POD` 環境変数を設定します。

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. VPN の状況を確認します。

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * VPN 接続の状況が `ESTABLISHED` の場合、VPN 接続は正常に行われました。これ以上のアクションは不要です。

    * 接続の問題が解決されない場合は、[strongSwan Helm チャートとの VPN 接続を確立できない](#cs_vpn_fails)を参照して、VPN 接続のトラブルシューティングをさらに行います。

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
{: shortdesc}

-   {{site.data.keyword.Bluemix_notm}} が使用可能かどうかを確認するために、[{{site.data.keyword.Bluemix_notm}} 状況ページを確認します![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status)。
-   [{{site.data.keyword.containershort_notm}} Slack![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) に質問を投稿します。 ヒント: {{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、この Slack への[招待を要求](https://bxcs-slack-invite.mybluemix.net/)してください。
-   フォーラムを確認して、同じ問題が他のユーザーで起こっているかどうかを調べます。 フォーラムを使用して質問するときは、{{site.data.keyword.Bluemix_notm}} 開発チームの目に止まるように、質問にタグを付けてください。

    -   {{site.data.keyword.containershort_notm}} を使用したクラスターまたはアプリの開発やデプロイに関する技術的な質問がある場合は、[Stack Overflow![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) に質問を投稿し、`ibm-cloud`、`kubernetes`、`containers` のタグを付けてください。
    -   サービスや概説の説明について質問がある場合は、[IBM developerWorks dW Answers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) フォーラムを使用してください。 `ibm-cloud` と `containers` のタグを含めてください。
    フォーラムの使用について詳しくは、[ヘルプの取得](/docs/get-support/howtogetsupport.html#using-avatar)を参照してください。

-   IBM サポートにお問い合わせください。 IBM サポート・チケットを開く方法や、サポート・レベルとチケットの重大度については、[サポートへのお問い合わせ](/docs/get-support/howtogetsupport.html#getting-customer-support)を参照してください。

{:tip}
問題を報告する際に、クラスター ID も報告してください。 クラスター ID を取得するには、`bx cs clusters` を実行します。
