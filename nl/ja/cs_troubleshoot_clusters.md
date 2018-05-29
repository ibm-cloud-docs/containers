---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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


# クラスターとワーカー・ノードのトラブルシューティング
{: #cs_troubleshoot_clusters}

{{site.data.keyword.containerlong}} を使用する際は、ここに示すクラスターとワーカー・ノードのトラブルシューティング手法を検討してください。
{: shortdesc}

より一般的な問題が起きている場合は、[クラスターのデバッグ](cs_troubleshoot.html)を試してください。
{: tip}

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


## ワーカー・ノードを更新または再ロードした後に、アプリケーションで RBAC DENY エラーが発生する
{: #cs_rbac_deny}

{: tsSymptoms}
Kubernetes バージョン 1.7 に更新した後に、アプリケーションで `RBAC DENY` エラーが発生します。

{: tsCauses}
[Kubernetes バージョン 1.7](cs_versions.html#cs_v17) 以降、セキュリティー向上のために、`default` 名前空間で実行されるアプリケーションに Kubernetes API に対するクラスター管理者特権は付与されなくなりました。

`default` 名前空間で実行され、`default ServiceAccount` を使用し、Kubernetes API にアクセスするアプリは、この Kubernetes の変更による影響を受けます。詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#upgrading-from-15) を参照してください。

{: tsResolve}
始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

1.  **一時的な対処**: アプリの RBAC ポリシーを更新する際に、`default` 名前空間の `default ServiceAccount` 用の前の `ClusterRoleBinding` に一時的に戻す必要がある場合があります。

    1.  以下の `.yaml` ファイルをコピーします。

        ```yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-nonResourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-nonResourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-resourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-resourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ```

    2.  `.yaml` ファイルをクラスターに適用します。

        ```
        kubectl apply -f FILENAME
        ```
        {: pre}

2.  [RBAC 許可リソースを作成し ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)、`ClusterRoleBinding` 管理アクセスを更新します。

3.  一時的なクラスター役割バインディングを作成した場合は、それを削除します。

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.8.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.8.11
  ```
  {: screen}

2.  [Calico CLI](cs_network_policy.html#adding_network_policies) をインストールします。
3.  Calico で使用可能なワーカー・ノードをリストします。 <path_to_file> は、Calico 構成ファイルのローカル・パスに置き換えてください。

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
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
  - `bx cs clusters` を実行して、クラスターの状況を確認します。 その後、`bx cs workers <cluster_name>` を実行して、ワーカー・ノードがデプロイされていることを確認します。
  - VLAN が有効であることを確認します。 VLAN が有効であるためには、ローカル・ディスク・ストレージを持つワーカーをホストできるインフラストラクチャーに VLAN が関連付けられている必要があります。 `bx cs VLAN LOCATION` を実行して [VLAN をリスト](/docs/containers/cs_cli_reference.html#cs_vlans)できます。VLAN がリストに表示されない場合、その VLAN は有効ではありません。 別の VLAN を選択してください。

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
  bx cs worker-add <cluster_name_or_ID> 1
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


## ヘルプとサポートの取得
{: #ts_getting_help}

まだクラスターに問題がありますか?
{: shortdesc}

-   {{site.data.keyword.Bluemix_notm}} が使用可能かどうかを確認するために、[{{site.data.keyword.Bluemix_notm}} 状況ページを確認します![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status)。
-   [{{site.data.keyword.containershort_notm}} Slack![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) に質問を投稿します。
    {{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、この Slack への[招待を要求](https://bxcs-slack-invite.mybluemix.net/)してください。
    {: tip}
-   フォーラムを確認して、同じ問題が他のユーザーで起こっているかどうかを調べます。 フォーラムを使用して質問するときは、{{site.data.keyword.Bluemix_notm}} 開発チームの目に止まるように、質問にタグを付けてください。

    -   {{site.data.keyword.containershort_notm}} を使用したクラスターまたはアプリの開発やデプロイに関する技術的な質問がある場合は、[Stack Overflow![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) に質問を投稿し、`ibm-cloud`、`kubernetes`、`containers` のタグを付けてください。
    -   サービスや概説の説明について質問がある場合は、[IBM developerWorks dW Answers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) フォーラムを使用してください。 `ibm-cloud` と `containers` のタグを含めてください。
    フォーラムの使用について詳しくは、[ヘルプの取得](/docs/get-support/howtogetsupport.html#using-avatar)を参照してください。

-   チケットを開いて、IBM サポートに連絡してください。IBM サポート・チケットを開く方法や、サポート・レベルとチケットの重大度については、[サポートへのお問い合わせ](/docs/get-support/howtogetsupport.html#getting-customer-support)を参照してください。

{:tip}
問題を報告する際に、クラスター ID も報告してください。 クラスター ID を取得するには、`bx cs clusters` を実行します。


