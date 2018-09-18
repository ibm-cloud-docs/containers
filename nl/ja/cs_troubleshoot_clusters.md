---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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
新しい Kubernetes クラスターを作成すると、次のいずれかと同様のエラー・メッセージを受け取ります。

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account.
Creating a standard cluster requires that you have either a Pay-As-You-Go account
that is linked to an IBM Cloud infrastructure (SoftLayer) account term or that you have used the {{site.data.keyword.containerlong_notm}} CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers
```
{: screen}

{: tsCauses}
自動アカウント・リンクを有効にした後に作成した {{site.data.keyword.Bluemix_notm}} の従量制課金アカウントは、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスできるように既にセットアップされています。 追加の構成を行わなくても、クラスターのためのインフラストラクチャー・リソースを購入できます。

他の {{site.data.keyword.Bluemix_notm}} アカウント・タイプを持つユーザー、または {{site.data.keyword.Bluemix_notm}} アカウントにリンクされていない既存の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを持つユーザーは、標準クラスターを作成できるようにアカウントを構成する必要があります。 

有効な従量制課金アカウントを持っていて、このエラー・メッセージを受け取った場合は、インフラストラクチャー・リソースにアクセスするための正しい IBM Cloud インフラストラクチャー (SoftLayer) アカウントの資格情報を使用していない可能性があります。

{: tsResolve}
アカウント所有者は、インフラストラクチャー・アカウントの資格情報を正しくセットアップする必要があります。資格情報は、使用しているインフラストラクチャー・アカウントのタイプによって異なります。
*  最近の従量制課金の {{site.data.keyword.Bluemix_notm}} アカウントをお持ちの場合、そのアカウントには使用可能なリンクされたインフラストラクチャー・アカウントが付いています。[インフラストラクチャー API キーが正しい許可 (権限) でセットアップされている](#apikey)ことを確認してください。
*  異なる {{site.data.keyword.Bluemix_notm}} アカウント・タイプの場合は、インフラストラクチャー・ポートフォリオにアクセスできること、および[インフラストラクチャー・アカウントの資格情報が正しい許可 (権限) でセットアップされている](#credentials)ことを確認してください。

クラスターがリンクされたインフラストラクチャー・アカウントを使用しているか、別のインフラストラクチャー・アカウントを使用しているかを確認するには、次の手順を実行します。
1.  インフラストラクチャー・アカウントに対するアクセス権限があることを確認します。[{{site.data.keyword.Bluemix_notm}} コンソール![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/) にログインし、展開可能メニューで**「インフラストラクチャー」**をクリックします。インフラストラクチャー・ダッシュボードが表示された場合は、インフラストラクチャー・アカウントへのアクセス権限があります。
2.  クラスターが別のインフラストラクチャー・アカウントを使用しているかどうかを確認します。展開可能メニューで、**「コンテナー」 > 「クラスター」**をクリックします。
3.  テーブルから、該当のクラスターを選択します。 
4.  **「概要」**タブで、**「インフラストラクチャー・ユーザー (Infrastructure User)」**フィールドが表示されている場合、そのクラスターでは、ご使用の従量制課金アカウントに付属したものとは異なるインフラストラクチャー・アカウントを使用しています。

### リンクされたアカウント用のインフラストラクチャー API 資格情報の構成
{: #apikey}

1.  インフラストラクチャーのアクションに使用する資格情報を持つユーザーの許可 (権限) が正しいことを確認してください。

    1.  [{{site.data.keyword.Bluemix_notm}} コンソール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/) にログインします。
        
    2.  メニューを展開して、**「インフラストラクチャー」**を選択します。
        
    3.  メニュー・バーから、**「アカウント」** > **「ユーザー」** > **「ユーザー・リスト」**を選択します。

    4.  **「API キー」**列で、ユーザーが「API キー」を保持していることを確認するか、または**「生成」**をクリックします。

    5.  ユーザーに[正しいインフラストラクチャーの許可](cs_users.html#infra_access)を割り当てるか、そうなっていることを確認します。

2.  クラスターが所在する地域の API キーを、その API キーがユーザーに属すようにリセットします。
    
    1.  正しいユーザーとして端末にログインします。
    
    2.  API キーをこのユーザーにリセットします。
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    
    3.  API キーが設定されていることを確認してください。
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}
        
    4.  **オプション**: 前に `ibmcloud ks credentials-set` コマンドを使用して資格情報を手動で設定していた場合は、関連付けられているインフラストラクチャー・アカウントを削除します。これで、前のサブステップで設定した API キーがインフラストラクチャーを発注するために使用されます。
        ```
        ibmcloud ks credentials-unset
        ```
        {: pre}

3.  **オプション**: パブリック・クラスターをオンプレミス・リソースに接続する場合は、ネットワーク接続を確認します。

    1.  ワーカーの VLAN 接続を確認します。 
    2.  必要な場合、[VPN 接続をセットアップします](cs_vpn.html#vpn)。
    3.  [ファイアウォールで必要なポートを開きます](cs_firewall.html#firewall)。

### 異なるアカウント用のインフラストラクチャー・アカウント資格情報の構成
{: #credentials}

1.  IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするために使用するインフラストラクチャー・アカウントを取得します。ご使用の現在のアカウント・タイプに依存する異なるオプションがあります。

    <table summary="この表は、アカウント・タイプ別の標準クラスターの作成オプションを示しています。各行は、左から右に読む必要があります。1 番目の列にアカウントの説明があり、2 番目の列に標準クラスターを作成するためのオプションがあります。">
    <caption>アカウント・タイプ別の標準クラスター作成の選択肢</caption>
      <thead>
      <th>アカウントの説明</th>
      <th>標準クラスターを作成するためのオプション</th>
      </thead>
      <tbody>
        <tr>
          <td>**ライト・アカウント**ではクラスターをプロビジョンできません。</td>
          <td>[ライト・アカウントを {{site.data.keyword.Bluemix_notm}} 従量課金 (PAYG) アカウントにアップグレードします](/docs/account/index.html#paygo)。従量課金アカウントには、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスがセットアップされています。</td>
        </tr>
        <tr>
          <td>**最近の従量制課金**アカウントには、インフラストラクチャー・ポートフォリオへのアクセス権限が付属しています。</td>
          <td>標準クラスターを作成できます。 インフラストラクチャーの許可 (権限) をトラブルシューティングするには、[リンクされたアカウント用のインフラストラクチャー API 資格情報の構成](#apikey)を参照してください。</td>
        </tr>
        <tr>
          <td>**以前の従量制課金アカウント**は、自動アカウント・リンクが使用可能になる前に作成されたアカウントで、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセス権限が付属していませんでした。
<p>既存の IBM Cloud インフラストラクチャー (SoftLayer) アカウントがあっても、そのアカウントを以前の従量制課金アカウントにリンクすることはできません。</p></td>
          <td><p><strong>選択肢 1:</strong> [新しい従量制課金アカウントを作成します](/docs/account/index.html#paygo)。このアカウントには、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスがセットアップされます。 この選択肢を取る場合は、2 つの異なる {{site.data.keyword.Bluemix_notm}} アカウントを所有し、2 つの異なる課金が行われることになります。</p><p>以前の従量制課金アカウントを引き続き使用する場合は、新しい従量制課金アカウントを使用して、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするための API キーを生成できます。</p><p><strong>選択肢 2:</strong> 既存の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用する場合は、{{site.data.keyword.Bluemix_notm}} アカウントに資格情報を設定できます。</p><p>**注:** IBM Cloud インフラストラクチャー (SoftLayer) アカウントに手動でリンクする場合、資格情報は {{site.data.keyword.Bluemix_notm}} アカウントでの IBM Cloud インフラストラクチャー (SoftLayer) 固有のすべてのアクションに使用されます。 ユーザーがクラスターを作成して操作できるように、設定した API キーに[十分なインフラストラクチャー許可](cs_users.html#infra_access)があることを確認する必要があります。</p><p>**どちらのオプションについても、次のステップに進んでください**。</p></td>
        </tr>
        <tr>
          <td>**サブスクリプション・アカウント**には、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスがセットアップされていません。</td>
          <td><p><strong>選択肢 1:</strong> [新しい従量制課金アカウントを作成します](/docs/account/index.html#paygo)。このアカウントには、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスがセットアップされます。 この選択肢を取る場合は、2 つの異なる {{site.data.keyword.Bluemix_notm}} アカウントを所有し、2 つの異なる課金が行われることになります。</p><p>サブスクリプション・アカウントを引き続き使用する場合は、新しい従量制課金アカウントを使用して、IBM Cloud インフラストラクチャー (SoftLayer) で API キーを生成します。 次に、手動でサブスクリプション・アカウント用に IBM Cloud インフラストラクチャー (SoftLayer) API キーを設定する必要があります。 IBM Cloud インフラストラクチャー (SoftLayer) リソースは新しい従量制課金アカウントを介して課金されることに注意してください。</p><p><strong>選択肢 2:</strong> 既存の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用する場合は、{{site.data.keyword.Bluemix_notm}} アカウントに手動で IBM Cloud インフラストラクチャー (SoftLayer) 資格情報を設定できます。</p><p>**注:** IBM Cloud インフラストラクチャー (SoftLayer) アカウントに手動でリンクする場合、資格情報は {{site.data.keyword.Bluemix_notm}} アカウントでの IBM Cloud インフラストラクチャー (SoftLayer) 固有のすべてのアクションに使用されます。 ユーザーがクラスターを作成して操作できるように、設定した API キーに[十分なインフラストラクチャー許可](cs_users.html#infra_access)があることを確認する必要があります。</p><p>**どちらのオプションについても、次のステップに進んでください**。</p></td>
        </tr>
        <tr>
          <td>**IBM Cloud インフラストラクチャー (SoftLayer) アカウント**があり、{{site.data.keyword.Bluemix_notm}} アカウントはない</td>
          <td><p>[{{site.data.keyword.Bluemix_notm}} 従量制課金アカウントを作成します](/docs/account/index.html#paygo)。このアカウントには、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセスがセットアップされます。 この選択肢を使用する場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントが自動的に作成されます。 2 つの別個の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを所有し、課金されることになります。</p><p>デフォルトでは、お客様の新規の {{site.keyword.data.Bluemix_notm}} アカウントでは新規のインフラストラクチャー・アカウントを使用します。古いインフラストラクチャー・アカウントを引き続き使用する場合は、次のステップに進んでください。</p></td>
        </tr>
      </tbody>
      </table>

2.  インフラストラクチャーのアクションに使用する資格情報を持つユーザーの許可 (権限) が正しいことを確認してください。

    1.  [{{site.data.keyword.Bluemix_notm}} コンソール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/) にログインします。
        
    2.  メニューを展開して、**「インフラストラクチャー」**を選択します。
        
    3.  メニュー・バーから、**「アカウント」** > **「ユーザー」** > **「ユーザー・リスト」**を選択します。

    4.  **「API キー」**列で、ユーザーが「API キー」を保持していることを確認するか、または**「生成」**をクリックします。

    5.  ユーザーに[正しいインフラストラクチャーの許可](cs_users.html#infra_access)を割り当てるか、そうなっていることを確認します。

3.  正しいアカウントのユーザーでインフラストラクチャー API 資格情報を設定します。

    1.  ユーザーのインフラストラクチャー API 資格情報を取得します。**注**: 資格情報は IBMid とは異なります。
            
        1.  [{{site.data.keyword.Bluemix_notm}} ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/) コンソールで、**「インフラストラクチャー」** > **「アカウント」** > **「ユーザー」** > **「ユーザー・リスト」**テーブルを選択し、**IBMid またはユーザー名**をクリックします。
            
        2.  **「API アクセス情報」**セクションで、**「API ユーザー名」**と**「認証鍵」**を表示します。    
        
    2.  使用するインフラストラクチャー API 資格情報を設定します。
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
  
4.  **オプション**: パブリック・クラスターをオンプレミス・リソースに接続する場合は、ネットワーク接続を確認します。

    1.  ワーカーの VLAN 接続を確認します。 
    2.  必要な場合、[VPN 接続をセットアップします](cs_vpn.html#vpn)。
    3.  [ファイアウォールで必要なポートを開きます](cs_firewall.html#firewall)。

<br />


## ファイアウォールがあるために CLI コマンドを実行できない
{: #ts_firewall_clis}

{: tsSymptoms}
CLI からコマンド `ibmcloud`、`kubectl`、または `calicoctl` を実行すると、失敗します。

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
別のファイアウォールをセットアップしたか、IBM Cloud インフラストラクチャー (SoftLayer) アカウントの既存のファイアウォール設定をカスタマイズした可能性があります。 {{site.data.keyword.containershort_notm}} では、ワーカー・ノードと Kubernetes マスター間で通信を行うには、特定の IP アドレスとポートが開いている必要があります。 別の原因として、ワーカー・ノードが再ロード・ループにはまっている可能性があります。

{: tsResolve}
[クラスターからインフラストラクチャー・リソースや他のサービスへのアクセスを許可](cs_firewall.html#firewall_outbound)します。 このタスクには、[管理者アクセス・ポリシー](cs_users.html#access_policies)が必要です。 現在の[アクセス・ポリシー](cs_users.html#infra_access)を確認してください。

<br />



## SSH によるワーカー・ノードへのアクセスが失敗する
{: #cs_ssh_worker}

{: tsSymptoms}
SSH 接続を使用してワーカー・ノードにアクセスすることはできません。

{: tsCauses}
パスワードによる SSH は、ワーカー・ノードでは使用できません。

{: tsResolve}
すべてのノードで実行する必要があるアクションについては、[DaemonSets ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用するか、または実行する必要がある一回限りのアクション用のジョブを使用します。

<br />


## ベアメタルのインスタンス ID がワーカー・レコードと不整合
{: #bm_machine_id}

{: tsSymptoms}
ベアメタルのワーカー・ノードで `ibmcloud ks worker` コマンドを使用すると、次のようなメッセージが表示されます。

```
Instance ID inconsistent with worker records
```
{: screen}

{: tsCauses}
マシンでハードウェアの問題が発生した場合、マシン ID が {{site.data.keyword.containershort_notm}} のワーカー・レコードと不整合になる可能性があります。IBM Cloud インフラストラクチャー (SoftLayer) がこの問題を解決すると、サービスが識別していないシステム内で、あるコンポーネントが変化する可能性があります。

{: tsResolve}
{{site.data.keyword.containershort_notm}} がそのマシンを再識別するには、[ベアメタルのワーカー・ノードを再ロードします](cs_cli_reference.html#cs_worker_reload)。**注**: 再ロードによって、マシンの[パッチ・バージョン](cs_versions_changelog.html)も更新されます。

[ベアメタル・ワーカー・ノードは削除](cs_cli_reference.html#cs_cluster_rm)することもできます。**注**: ベア・メタル・インスタンスは月単位で請求されます。

<br />


## `kubectl exec` および `kubectl logs` が機能しない
{: #exec_logs_fail}

{: tsSymptoms}
`kubectl exec` または `kubectl logs` を実行すると、以下のメッセージが表示されます。

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
マスター・ノードとワーカー・ノードの間の OpenVPN 接続が正しく機能していません。

{: tsResolve}
1. IBM Cloud インフラストラクチャー (SoftLayer) アカウントの [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にします。
2. OpenVPN クライアント・ポッドを再始動します。
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. それでも同じエラー・メッセージが表示される場合は、VPN ポッドがあるワーカー・ノードが正常ではない可能性があります。 VPN ポッドを再始動し、異なるワーカー・ノードにスケジュールを変更するには、VPN ポッドがある[ワーカー・ノードを閉鎖、排出してリブートします](cs_cli_reference.html#cs_worker_reboot)。

<br />


## サービスをクラスターにバインドすると同名エラーが発生する
{: #cs_duplicate_services}

{: tsSymptoms}
`ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` を実行すると、以下のメッセージが表示されます。

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
異なる地域にある複数のサービス・インスタンスの名前が等しい可能性があります。

{: tsResolve}
`ibmcloud ks cluster-service-bind` コマンドで、サービス・インスタンス名ではなくサービス GUID を使用してください。

1. [バインドするサービス・インスタンスが含まれる地域にログインします。](cs_regions.html#bluemix_regions)

2. サービス・インスタンスの GUID を取得します。
  ```
  ibmcloud service show <service_instance_name> --guid
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
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## サービスをクラスターにバインドすると、サービスが見つからないというエラーが発生する
{: #cs_not_found_services}

{: tsSymptoms}
`ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` を実行すると、以下のメッセージが表示されます。

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
サービスをクラスターにバインドするには、サービス・インスタンスがプロビジョンされているスペースに対する Cloud Foundry 開発者ユーザー役割が必要です。 また、{{site.data.keyword.containerlong}} に対する IAM の Editor アクセス権限も必要です。 サービス・インスタンスにアクセスするには、サービス・インスタンスがプロビジョンされているスペースにログインする必要があります。

{: tsResolve}

**ユーザーは、以下の手順を実行します。**

1. {{site.data.keyword.Bluemix_notm}} にログインします。
   ```
   ibmcloud login
   ```
   {: pre}

2. サービス・インスタンスがプロビジョンされている組織とスペースをターゲットにします。
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. サービス・インスタンスをリストして、正しいスペースにいることを確認します。
   ```
   ibmcloud service list
   ```
   {: pre}

4. サービスのバインドを再試行してください。 同じエラーが発生した場合は、アカウント管理者に連絡して、サービスをバインドするための十分な許可があることを確認してください (以下のアカウント管理者の手順を参照してください)。

**アカウント管理者は、以下の手順を実行します。**

1. この問題が発生しているユーザーに、[{{site.data.keyword.containerlong}} の Editor 許可](/docs/iam/mngiam.html#editing-existing-access)があることを確認します。

2. この問題が発生したユーザーに、サービスがプロビジョンされている[スペースに対する Cloud Foundry 開発者役割](/docs/iam/mngcf.html#updating-cloud-foundry-access)があることを確認します。

3. 正しい許可が存在する場合は、別の許可を割り当ててから、必要な許可を再度割り当ててみてください。

4. 数分待ってから、ユーザーにサービスのバインドを再試行してもらってください。

5. これで問題が解決しない場合は、IAM 許可が同期していないため、自分で問題を解決することはできません。 サポート・チケットを開いて、[IBM サポートにお問い合わせください](/docs/get-support/howtogetsupport.html#getting-customer-support)。 必ず、クラスター ID、ユーザー ID、およびサービス・インスタンス ID をご提供ください。
   1. クラスター ID を取得します。
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. サービス・インスタンス ID を取得します。
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />



## ワーカー・ノードが更新または再ロードされた後で、重複するノードとポッドが表示される
{: #cs_duplicate_nodes}

{: tsSymptoms}
`kubectl get nodes` を実行すると、状況が **NotReady** の重複したワーカー・ノードが表示されます。 **NotReady** のワーカー・ノードにはパブリック IP アドレスがありますが、**Ready** のワーカー・ノードにはプライベート IP アドレスがあります。

{: tsCauses}
以前のクラスターでは、クラスターのパブリック IP アドレスごとにワーカー・ノードがリストされていました。 現在は、ワーカー・ノードはクラスターのプライベート IP アドレスごとにリストされています。 ノードを再ロードまたは更新すると、IP アドレスは変更されますがパブリック IP アドレスへの参照は残ります。

{: tsResolve}
これらの重複によってサービスが中断されることはありませんが、以前のワーカー・ノード参照は API サーバーから削除できます。

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
クラスターからワーカー・ノードを削除した後でワーカー・ノードを追加すると、削除されたワーカー・ノードのプライベート IP アドレスが新しいワーカー・ノードに割り当てられる場合があります。 Calico はこのプライベート IP アドレスをタグとして使用して、削除されたノードにアクセスし続けます。

{: tsResolve}
正しいノードを指すように、プライベート IP アドレスの参照を手動で更新します。

1.  2 つのワーカー・ノードの**プライベート IP** アドレスが同じであることを確認します。 削除されたワーカーの**プライベート IP** と **ID** をメモします。

  ```
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.5
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.5
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
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


削除されたノードが Calico にリストされなくなります。

<br />




## ポッド・セキュリティー・ポリシーが原因でポッドをデプロイできない
{: #cs_psp}

{: tsSymptoms}
ポッドの作成後、または `kubectl get events` を実行してポッドのデプロイメントを確認した後に、次のようなエラー・メッセージが表示されます。

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[`PodSecurityPolicy` アドミッション・コントローラー](cs_psp.html)は、ポッドを作成しようとしたユーザー・アカウントまたはサービス・アカウント (デプロイメントまたは Helm tiller など) の許可を検査します。ポッドのセキュリティー・ポリシーがユーザー・アカウントまたはサービス・アカウントをサポートしていない場合、`PodSecurityPolicy` アドミッション・コントローラーはポッドが作成されないようにします。

[{{site.data.keyword.IBM_notm}} クラスター管理](cs_psp.html#ibm_psp)用のポッドのセキュリティー・ポリシー・リソースのいずれかを削除した場合、同様の問題が発生する場合があります。

{: tsResolve}
ユーザー・アカウントまたはサービス・アカウントがポッドのセキュリティー・ポリシーによって許可されていることを確認してください。[既存のポリシーを変更する](cs_psp.html#customize_psp)ことが必要になる場合があります。

{{site.data.keyword.IBM_notm}} クラスター管理リソースを削除した場合は、Kubernetes マスターをリフレッシュして復元します。

1.  [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。
2.  Kubernetes マスターを最新表示して復元します。

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## クラスターが保留状態のままである
{: #cs_cluster_pending}

{: tsSymptoms}
デプロイしたクラスターが、保留状態のままで開始されません。

{: tsCauses}
クラスターを作成したばかりの場合は、まだワーカー・ノードが構成中の可能性があります。 既にしばらく待機している場合は、VLAN が無効である可能性があります。

{: tsResolve}

以下のいずれかの解決策を試してください。
  - `ibmcloud ks clusters` を実行して、クラスターの状況を確認します。 その後、`ibmcloud ks workers <cluster_name>` を実行して、ワーカー・ノードがデプロイされていることを確認します。
  - VLAN が有効かどうかを確認します。 VLAN が有効であるためには、ローカル・ディスク・ストレージを持つワーカーをホストできるインフラストラクチャーに VLAN が関連付けられている必要があります。 `ibmcloud ks vlans <zone>` を実行して [VLAN をリスト](/docs/containers/cs_cli_reference.html#cs_vlans)できます。VLAN がリストに表示されない場合、その VLAN は有効ではありません。 別の VLAN を選択してください。

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

4.  クラスターに十分な容量がない場合は、ワーカー・プールをサイズ変更してノードをさらに追加します。

    1.  ワーカー・プールの現在のサイズとマシン・タイプを確認して、サイズ変更するワーカー・プールを決定します。

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  ワーカー・プールをサイズ変更して、そのプールが及ぶ範囲のゾーンごとにノードをさらに追加します。

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
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
-   [{{site.data.keyword.containershort_notm}} Slack ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) に質問を投稿します。

    {{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、この Slack への[招待を要求](https://bxcs-slack-invite.mybluemix.net/)してください。
    {: tip}
-   フォーラムを確認して、同じ問題が他のユーザーで起こっているかどうかを調べます。 フォーラムを使用して質問するときは、{{site.data.keyword.Bluemix_notm}} 開発チームの目に止まるように、質問にタグを付けてください。

    -   {{site.data.keyword.containershort_notm}} を使用したクラスターまたはアプリの開発やデプロイに関する技術的な質問がある場合は、[Stack Overflow![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) に質問を投稿し、`ibm-cloud`、`kubernetes`、`containers` のタグを付けてください。
    -   サービスや概説の説明について質問がある場合は、[IBM developerWorks dW Answers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) フォーラムを使用してください。 `ibm-cloud` と `containers` のタグを含めてください。
    フォーラムの使用について詳しくは、[ヘルプの取得](/docs/get-support/howtogetsupport.html#using-avatar)を参照してください。

-   チケットを開いて、IBM サポートに連絡してください。 IBM サポート・チケットを開く方法や、サポート・レベルとチケットの重大度については、[サポートへのお問い合わせ](/docs/get-support/howtogetsupport.html#getting-customer-support)を参照してください。

{: tip}
問題を報告する際に、クラスター ID も報告してください。 クラスター ID を取得するには、`ibmcloud ks clusters` を実行します。

