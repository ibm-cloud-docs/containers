---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# コマンド解説書
{: #cs_cli_reference}

{{site.data.keyword.containerlong}} で Kubernetes クラスターの作成と管理を行うには、以下のコマンドを参照してください。
{:shortdesc}

CLI プラグインをインストールするには、[CLI のインストール](cs_cli_install.html#cs_cli_install_steps)を参照してください。

`ibmcloud` CLI およびプラグインの更新が使用可能になると、端末に通知が表示されます。 使用可能なすべてのコマンドおよびフラグを使用できるように、CLI を最新の状態に保つようにしてください。

`ibmcloud cr` コマンドをお探しですか? [{{site.data.keyword.registryshort_notm}} CLI リファレンス](/docs/container-registry-cli-plugin/container-registry-cli.html#containerregcli)を参照してください。 `kubectl` コマンドをお探しですか? [Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/overview/) を参照してください。
{:tip}

## ibmcloud ks コマンド
{: #cs_commands}

**ヒント:** {{site.data.keyword.containerlong_notm}} プラグインのバージョンを表示するには、以下のコマンドを実行します。

```
ibmcloud plugin list
```
{: pre}



<table summary="API コマンドの表">
<caption>API コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>API コマンド</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks api](#cs_api)</td>
    <td>[ibmcloud ks api-key-info](#cs_api_key_info)</td>
    <td>[ibmcloud ks api-key-reset](#cs_api_key_reset)</td>
    <td>[ibmcloud ks apiserver-config-get](#cs_apiserver_config_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks apiserver-config-set](#cs_apiserver_config_set)</td>
    <td>[ibmcloud ks apiserver-config-unset](#cs_apiserver_config_unset)</td>
    <td>[ibmcloud ks apiserver-refresh](#cs_apiserver_refresh)</td>
    <td></td>
 </tr>
</tbody>
</table>

<br>

<table summary="CLI プラグインの使用方法を示すコマンドの表">
<caption>CLI プラグインの使用方法を示すコマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>CLI プラグインの使用方法を示すコマンド</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks help](#cs_help)</td>
    <td>[ibmcloud ks init](#cs_init)</td>
    <td>[ibmcloud ks messages](#cs_messages)</td>
    <td></td>
  </tr>
</tbody>
</table>

<br>

<table summary="クラスター・コマンド: 管理の表">
<caption>クラスター・コマンド: 管理コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>クラスター・コマンド: 管理</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-config](#cs_cluster_config)</td>
    <td>[ibmcloud ks cluster-create](#cs_cluster_create)</td>
    <td>[ibmcloud ks cluster-feature-enable](#cs_cluster_feature_enable)</td>
    <td>[ibmcloud ks cluster-get](#cs_cluster_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks cluster-refresh](#cs_cluster_refresh)</td>
    <td>[ibmcloud ks cluster-rm](#cs_cluster_rm)</td>
    <td>[ibmcloud ks cluster-update](#cs_cluster_update)</td>
    <td>[ibmcloud ks clusters](#cs_clusters)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks kube-versions](#cs_kube_versions)</td>
    <td> </td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

<br>

<table summary="クラスター・コマンド: サービスと統合の表">
<caption>クラスター・コマンド: サービスと統合のコマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>クラスター・コマンド: サービスと統合</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[ibmcloud ks cluster-service-unbind](#cs_cluster_service_unbind)</td>
    <td>[ibmcloud ks cluster-services](#cs_cluster_services)</td>
    <td>[ibmcloud ks va](#cs_va)</td>
  </tr>
    <td>[ibmcloud ks webhook-create](#cs_webhook_create)</td>
  <tr>
  </tr>
</tbody>
</table>

</br>

<table summary="クラスター・コマンド: サブネットの表">
<caption>クラスター・コマンド: サブネット・コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>クラスター・コマンド: サブネット</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[ibmcloud ks cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[ibmcloud ks cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[ibmcloud ks cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks subnets](#cs_subnets)</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>

</br>

<table summary="インフラストラクチャー・コマンドの表">
<caption>クラスター・コマンド: インフラストラクチャー・コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>インフラストラクチャー・コマンド</th>
 </thead>
 <tbody>
  <tr>
    <td>[        ibmcloud ks credential-get
        ](#cs_credential_get)</td>
    <td>[ibmcloud ks credential-set](#cs_credentials_set)</td>
    <td>[ibmcloud ks credential-unset](#cs_credentials_unset)</td>
    <td>[ibmcloud ks machine-types](#cs_machine_types)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks vlans](#cs_vlans)</td>
    <td>[ibmcloud ks vlan-spanning-get](#cs_vlan_spanning_get)</td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

</br>

<table summary="Ingress アプリケーション・ロード・バランサー (ALB) コマンドの表">
<caption>Ingress アプリケーション・ロード・バランサー (ALB) コマンド</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Ingress アプリケーション・ロード・バランサー (ALB) コマンド</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks alb-autoupdate-disable](#cs_alb_autoupdate_disable)</td>
      <td>[ibmcloud ks alb-autoupdate-enable](#cs_alb_autoupdate_enable)</td>
      <td>[ibmcloud ks alb-autoupdate-get](#cs_alb_autoupdate_get)</td>
      <td>[ibmcloud ks alb-cert-deploy](#cs_alb_cert_deploy)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-cert-get](#cs_alb_cert_get)</td>
      <td>[ibmcloud ks alb-cert-rm](#cs_alb_cert_rm)</td>
      <td>[ibmcloud ks alb-certs](#cs_alb_certs)</td>
      <td>[ibmcloud ks alb-configure](#cs_alb_configure)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-get](#cs_alb_get)</td>
      <td>[ibmcloud ks alb-rollback](#cs_alb_rollback)</td>
      <td>[ibmcloud ks alb-types](#cs_alb_types)</td>
      <td>[ibmcloud ks alb-update](#cs_alb_update)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks albs](#cs_albs)</td>
      <td> </td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

</br>

<table summary="ロギング・コマンドの表">
<caption>ロギング・コマンド</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>ロギング・コマンド</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks logging-autoupdate-enable](#cs_log_autoupdate_enable)</td>
      <td>[ibmcloud ks logging-autoupdate-disable](#cs_log_autoupdate_disable)</td>
      <td>[ibmcloud ks logging-autoupdate-get](#cs_log_autoupdate_get)</td>
      <td>[ibmcloud ks logging-config-create](#cs_logging_create)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-config-get](#cs_logging_get)</td>
      <td>[ibmcloud ks logging-config-refresh](#cs_logging_refresh)</td>
      <td>[ibmcloud ks logging-config-rm](#cs_logging_rm)</td>
      <td>[ibmcloud ks logging-config-update](#cs_logging_update)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-filter-create](#cs_log_filter_create)</td>
      <td>[ibmcloud ks logging-filter-update](#cs_log_filter_update)</td>
      <td>[ibmcloud ks logging-filter-get](#cs_log_filter_view)</td>
      <td>[ibmcloud ks logging-filter-rm](#cs_log_filter_delete)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-collect](#cs_log_collect)</td>
      <td>[ibmcloud ks logging-collect-status](#cs_log_collect_status)</td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

</br>

<table summary="地域コマンドの表">
<caption>地域コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>地域コマンド</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks region](#cs_region)</td>
    <td>[ibmcloud ks region-set](#cs_region-set)</td>
    <td>[ibmcloud ks regions](#cs_regions)</td>
    <td>[   ibmcloud ks zones
   ](#cs_datacenters)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="ワーカー・ノード・コマンドの表">
<caption>ワーカー・ノード・コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>ワーカー・ノード・コマンド</th>
 </thead>
 <tbody>
    <tr>
      <td>非推奨: [ibmcloud ks worker-add](#cs_worker_add)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks worker-update](#cs_worker_update)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
      <td> </td>
    </tr>
  </tbody>
</table>

<table summary="ワーカー・プール・コマンドの表">
<caption>ワーカー・プール・コマンド</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>ワーカー・プール・コマンド</th>
 </thead>
 <tbody>
    <tr>
      <td>[ibmcloud ks worker-pool-create](#cs_worker_pool_create)</td>
      <td>[ibmcloud ks worker-pool-get](#cs_worker_pool_get)</td>
      <td>[ibmcloud ks worker-pool-rebalance](#cs_rebalance)</td>
      <td>[ibmcloud ks worker-pool-resize](#cs_worker_pool_resize)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-pool-rm](#cs_worker_pool_rm)</td>
      <td>[ibmcloud ks worker-pools](#cs_worker_pools)</td>
      <td>[ibmcloud ks zone-add](#cs_zone_add)</td>
      <td>[ibmcloud ks zone-network-set](#cs_zone_network_set)</td>
    </tr>
    <tr>
     <td>[ibmcloud ks zone-rm](#cs_zone_rm)</td>
     <td></td>
    </tr>
  </tbody>
</table>

## API コマンド
{: #api_commands}

### ibmcloud ks api --endpoint ENDPOINT [--insecure][--skip-ssl-validation] [--api-version VALUE][-s]
{: #cs_api}

API エンドポイントを {{site.data.keyword.containerlong_notm}} のターゲットとして設定します。 エンドポイントを指定しない場合、ターゲットとして設定されている現行エンドポイントに関する情報を表示できます。

地域を切り替えますか? `ibmcloud ks region-set` [コマンド](#cs_region-set)を代わりに使用します。
{: tip}

<strong>最小限必要な許可</strong>: なし

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--endpoint <em>ENDPOINT</em></code></dt>
   <dd>{{site.data.keyword.containerlong_notm}} API エンドポイント。 このエンドポイントは、{{site.data.keyword.Bluemix_notm}} エンドポイントとは異なることに注意してください。 この値は、API エンドポイントを設定するために必須です。 指定できる値は以下のとおりです。<ul>
   <li>グローバル・エンドポイント: https://containers.bluemix.net</li>
   <li>北アジア太平洋地域エンドポイント: https://ap-north.containers.bluemix.net</li>
   <li>南アジア太平洋地域エンドポイント: https://ap-south.containers.bluemix.net</li>
   <li>中欧エンドポイント: https://eu-central.containers.bluemix.net</li>
   <li>英国南部エンドポイント: https://uk-south.containers.bluemix.net</li>
   <li>米国東部エンドポイント: https://us-east.containers.bluemix.net</li>
   <li>米国南部エンドポイント: https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>非セキュアな HTTP 接続を許可します。 このフラグはオプションです。</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>非セキュアな SSL 証明書を許可します。 このフラグはオプションです。</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>使用するサービスの API バージョンを指定します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**: ターゲットとして設定されている現行の API エンドポイントに関する情報を表示します。
```
ibmcloud ks api
```
{: pre}

```
API Endpoint:          https://containers.bluemix.net
API Version:           v1
Skip SSL Validation:   false
Region:                us-south
```
{: screen}


### ibmcloud ks api-key-info --cluster CLUSTER [--json][-s]
{: #cs_api_key_info}

{{site.data.keyword.containerlong_notm}} リソース・グループおよび地域の {{site.data.keyword.Bluemix_notm}} IAM (ID およびアクセス管理) API キーの所有者の名前と E メール・アドレスを表示します。

{{site.data.keyword.containerlong_notm}} 管理アクセス・ポリシーを必要とする最初のアクションが実行されると、リソース・グループおよび地域に対して {{site.data.keyword.Bluemix_notm}} API キーが自動的に設定されます。例えば、管理ユーザーの 1 人が `us-south` 地域内の `default` リソース・グループに最初のクラスターを作成したとします。 これにより、そのリソース・グループおよび地域に対してこのユーザーの {{site.data.keyword.Bluemix_notm}} IAM API キーがアカウントに保管されます。 新しいワーカー・ノードや VLAN などのリソースを IBM Cloud インフラストラクチャー (SoftLayer) で注文する際には、この API キーが使用されます。 リソース・グループ内で地域ごとに異なる API キーを設定できます。

IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオとのやりとりが必要なアクション (例えば、新規クラスターの作成やワーカー・ノードの再ロードなど) を別のユーザーがこのリソース・グループおよび地域で実行すると、保管されている API キーを基に、そのアクションを実行できるだけの権限があるかどうかが判断されます。 インフラストラクチャー関連のアクションをクラスター内で正常に実行するためには、{{site.data.keyword.containerlong_notm}} 管理ユーザーにインフラストラクチャー・アクセス・ポリシーの**スーパーユーザー**を割り当ててください。 詳しくは、[ユーザー・アクセスの管理](cs_users.html#infra_access)を参照してください。

リソース・グループおよび地域に対して保管されている API キーを更新する必要がある場合は、[ibmcloud ks api-key-reset](#cs_api_key_reset) コマンドを実行して更新できます。 このコマンドには {{site.data.keyword.containerlong_notm}} 管理アクセス・ポリシーが必要です。このコマンドを実行すると、実行したユーザーの API キーがアカウントに保管されます。

**ヒント:** [ibmcloud ks credential-set](#cs_credentials_set) コマンドを使用して IBM Cloud インフラストラクチャー (SoftLayer) の資格情報を手動で設定した場合、このコマンドで返される API キーは使用されない場合があります。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks api-key-info --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks api-key-reset [-s]
{: #cs_api_key_reset}

{{site.data.keyword.containerlong_notm}} 地域の現在の {{site.data.keyword.Bluemix_notm}} IAM API キーを置き換えます。
{: shortdesc}

このコマンドには {{site.data.keyword.containerlong_notm}} 管理アクセス・ポリシーが必要です。このコマンドを実行すると、実行したユーザーの API キーがアカウントに保管されます。 その {{site.data.keyword.Bluemix_notm}} IAM API キーが、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにインフラストラクチャーを注文する際に必要になります。 保管された API キーは、このコマンドを実行したユーザーに関係なく、地域内で実行される、インフラストラクチャー権限を必要とするあらゆるアクションに使用されます。 {{site.data.keyword.Bluemix_notm}} IAM API キーの仕組みについて詳しくは、[`ibmcloud ks api-key-info` コマンド](#cs_api_key_info)を参照してください。

このコマンドを使用する前に、このコマンドを実行するユーザーに必要な [{{site.data.keyword.containerlong_notm}} 権限と IBM Cloud インフラストラクチャー (SoftLayer) 権限](cs_users.html#users)があることを確認してください。
{: important}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>


**例**:

  ```
  ibmcloud ks api-key-reset
  ```
  {: pre}


### ibmcloud ks apiserver-config-get
{: #cs_apiserver_config_get}

クラスターの Kubernetes API サーバー構成のオプションに関する情報を取得します。 このコマンドは、情報を取得する構成オプションを表す以下のいずれかのサブコマンドと一緒に指定する必要があります。

#### ibmcloud ks apiserver-config-get audit-webhook --cluster CLUSTER
{: #cs_apiserver_config_get_audit_webhook}

API サーバー監査ログの送信先となるリモート・ロギング・サービスの URL を表示します。 URL は、API サーバー構成の Web フック・バックエンドの作成時に指定されています。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks apiserver-config-get audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-config-set
{: #cs_apiserver_config_set}

クラスターの Kubernetes API サーバー構成のオプションを設定します。 このコマンドは、設定する構成オプションに対する以下のいずれかのサブコマンドと結合させる必要があります。

#### ibmcloud ks apiserver-config-set audit-webhook --cluster CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_set}

API サーバー構成の Web フック・バックエンドを設定します。 Web フック・バックエンドは、API サーバー監査ログをリモート・サーバーに転送します。 Web フック構成は、このコマンドのフラグで指定する情報に基づいて作成されます。 どのフラグにも情報を指定しない場合、デフォルトの Web フック構成が使用されます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>監査ログの送信先となるリモート・ロギング・サービスの URL または IP アドレス。 非セキュアなサーバー URL を指定した場合、すべての証明書は無視されます。 この値はオプションです。</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>リモート・ロギング・サービスの検証に使用される CA 証明書のファイル・パス。 この値はオプションです。</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>リモート・ロギング・サービスに対する認証に使用されるクライアント証明書のファイル・パス。 この値はオプションです。</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>リモート・ロギング・サービスへの接続に使用される、対応するクライアント・キーのファイル・パス。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks apiserver-config-set audit-webhook --cluster my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud ks apiserver-config-unset
{: #cs_apiserver_config_unset}

クラスターの Kubernetes API サーバー構成のオプションを無効にします。 このコマンドは、設定を解除する構成オプションを表す以下のいずれかのサブコマンドと一緒に指定する必要があります。

#### ibmcloud ks apiserver-config-unset audit-webhook --cluster CLUSTER
{: #cs_apiserver_unset}

クラスターの API サーバーの Web フック・バックエンド構成を無効にします。 Web フック・バックエンドを無効にすると、リモート・サーバーへの API サーバー監査ログの転送が停止します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks apiserver-config-unset audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-refresh --cluster CLUSTER [-s]
{: #cs_apiserver_refresh}

クラスターのマスターを再始動して、新しい Kubernetes API 構成変更を適用します。 ご使用のワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks apiserver-refresh --cluster my_cluster
  ```
  {: pre}


<br />


## CLI プラグインの使用方法を示すコマンド
{: #cli_plug-in_commands}

### ibmcloud ks help
{: #cs_help}

サポートされるコマンドとパラメーターのリストを表示します。

<strong>最小限必要な許可</strong>: なし

<strong>コマンド・オプション</strong>:

   なし

**例**:

  ```
  ibmcloud ks help
  ```
  {: pre}


### ibmcloud ks init [--host HOST][--insecure] [-p][-u] [-s]
{: #cs_init}

{{site.data.keyword.containerlong_notm}} プラグインを初期化するか、Kubernetes クラスターを作成またはアクセスする地域を指定します。
{: shortdesc}

<strong>最小限必要な許可</strong>: なし

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>使用する {{site.data.keyword.containerlong_notm}} API エンドポイント。  この値はオプションです。 [API エンドポイントの選択可能な値を表示します。](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>非セキュアな HTTP 接続を許可します。</dd>

   <dt><code>-p</code></dt>
   <dd>IBM Cloud のパスワード。</dd>

   <dt><code>-u</code></dt>
   <dd>IBM Cloud のユーザー名。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:


```
ibmcloud ks init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud ks messages
{: #cs_messages}

IBMid ユーザーに対する現在のメッセージを表示します。
{: shortdesc}

<strong>最小限必要な許可</strong>: なし

**例**:

```
ibmcloud ks messages
```
{: pre}


<br />


## クラスター・コマンド: 管理
{: #cluster_mgmt_commands}



### ibmcloud ks cluster-config --cluster CLUSTER [--admin][--export] [--network][-s] [--yaml]
{: #cs_cluster_config}

ログインした後に、クラスターに接続して `kubectl` コマンドを実行するための Kubernetes 構成データと証明書をダウンロードします。 それらのファイルは、`user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>` にダウンロードされます。
{: shortdesc}

**最小限必要な許可**: なし

**コマンド・オプション**:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--admin</code></dt>
   <dd>スーパーユーザー役割の TLS 証明書と許可ファイルをダウンロードします。 それらの証明書を使用すると、再認証しなくてもクラスターでのタスクを自動化することができます。 それらのファイルは、`<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin` にダウンロードされます。 この値はオプションです。</dd>

   <dt><code>--network</code></dt>
   <dd>クラスター内で <code>calicoctl</code> コマンドを実行するために必要な Calico 構成ファイル、TLS 証明書、許可ファイルをダウンロードします。 この値はオプションです。 **注**: ダウンロードされる Kubernetes の構成データや証明書に関する export コマンドを取得するには、このフラグを指定せずにこのコマンドを実行する必要があります。</dd>

   <dt><code>--export</code></dt>
   <dd>export コマンド以外のメッセージなしで、Kubernetes の構成データと証明書をダウンロードします。 メッセージが表示されないため、自動化スクリプトを作成するときにこのフラグを使用することができます。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

  <dt><code>--yaml</code></dt>
  <dd>コマンド出力を YAML フォーマットで出力します。 この値はオプションです。</dd>

   </dl>

**例**:

```
ibmcloud ks cluster-config --cluster my_cluster
```
{: pre}


### ibmcloud ks cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --zone ZONE --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--private-only][--workers WORKER] [--disable-disk-encrypt][--trusted] [-s]
{: #cs_cluster_create}

組織内にクラスターを作成します。 フリー・クラスターの場合は、クラスター名を指定します。それ以外はすべてデフォルト値に設定されます。 フリー・クラスターは 30 日後に自動的に削除されます。 フリー・クラスターは一度に 1 つしか作成できません。 Kubernetes のすべての機能を利用するには、標準クラスターを作成してください。

<strong>最小限必要な許可</strong>:
* {{site.data.keyword.containerlong_notm}} に対するアカウント・レベルの**管理者**のプラットフォーム役割
* {{site.data.keyword.registrylong_notm}} に対するアカウント・レベルの**管理者**のプラットフォーム役割
* IBM Cloud インフラストラクチャー (SoftLayer) に対する**スーパーユーザー**の役割

<strong>コマンド・オプション</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>標準クラスターを作成する YAML ファイルのパス。 このコマンドに用意されているオプションを使用してクラスターの特性を定義する代わりに、YAML ファイルを使用することができます。  この値は、標準クラスターではオプションで、フリー・クラスターでは使用できません。

<p class="note">YAML ファイル内のパラメーターと同じオプションをコマンドで指定した場合は、コマンドの値が YAML 内の値よりも優先されます。 例えば、YAML ファイル内で場所を定義し、コマンドで <code>--zone</code> オプションを使用した場合は、コマンド・オプションに入力した値が YAML ファイル内の値をオーバーライドします。</p>

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
zone: <em>&lt;zone&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
diskEncryption: <em>false</em>
trusted: <em>true</em>
</code></pre>


<table>
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td><code><em>&lt;cluster_name&gt;</em></code> をクラスターの名前に置き換えます。 名前は先頭が文字でなければならず、文字、数字、およびハイフン (-) を使用できます。35 文字以内でなければなりません。 Ingress サブドメインの完全修飾ドメイン・ネームは、クラスター名と、クラスターがデプロイされる地域で形成されます。 Ingress サブドメインを地域内で固有にするために、クラスター名が切り捨てられ、Ingress ドメイン・ネームにランダムな値が付加されることがあります。
</td>
    </tr>
    <tr>
    <td><code><em>zone</em></code></td>
    <td><code><em>&lt;zone&gt;</em></code> を、クラスターを作成するゾーンに置き換えます。 使用可能なゾーンは、ログインしている地域によって異なります。 使用可能なゾーンをリストするには、<code>ibmcloud ks zones</code> を実行します。 </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>デフォルトでは、パブリックとプライベートのポータブル・サブネットが、クラスターに関連付けられた VLAN 上に作成されます。 クラスターを使用してサブネットを作成することを回避するには、<code><em>&lt;no-subnet&gt;</em></code> を <code><em>true</em></code> に置き換えます。 後でサブネットを[作成](#cs_cluster_subnet_create)したり、クラスターに[追加](#cs_cluster_subnet_add)したりすることができます。</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td><code><em>&lt;machine_type&gt;</em></code> を、ワーカー・ノードをデプロイするマシンのタイプに置き換えます。 ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてデプロイすることも、ベア・メタル上に物理マシンとしてデプロイすることもできます。 使用可能な物理マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 詳しくは、`ibmcloud ks machine-type` [コマンド](cs_cli_reference.html#cs_machine_types)についての説明を参照してください。</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td><code><em>&lt;private_VLAN&gt;</em></code> を、ワーカー・ノードに使用するプライベート VLAN の ID に置き換えます。 使用可能な VLAN をリストするには、<code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> を実行して、<code>bcr</code> で始まる VLAN ルーター (バックエンド・ルーター) を探します。</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td><code><em>&lt;public_VLAN&gt;</em></code> を、ワーカー・ノードに使用するパブリック VLAN の ID に置き換えます。 使用可能な VLAN をリストするには、<code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> を実行して、<code>fcr</code> で始まる VLAN ルーター (フロントエンド・ルーター) を探します。</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>仮想マシン・タイプの場合: ワーカー・ノードのハードウェア分離のレベル。 使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。 デフォルトは <code>shared</code> です。</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td><code><em>&lt;number_workers&gt;</em></code> を、デプロイするワーカー・ノードの数に置き換えます。</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>クラスター・マスター・ノードの Kubernetes のバージョン。 この値はオプションです。 バージョンを指定しなかった場合、クラスターは、サポートされるデフォルトの Kubernetes バージョンを使用して作成されます。 使用可能なバージョンを確認するには、<code>ibmcloud ks kube-versions</code> を実行します。
</td></tr> 
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>ワーカー・ノードには、デフォルトでディスク暗号化の機能があります。[詳しくはこちらを参照してください](cs_secure.html#encrypted_disk)。 暗号化を無効にするには、このオプションを組み込んで値を <code>false</code> に設定します。</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**ベア・メタルのみ**: [トラステッド・コンピューティング](cs_secure.html#trusted_compute)を有効にして、ベア・メタル・ワーカー・ノードが改ざんされていないことを検証します。 クラスターの作成時にトラストを有効にしなかった場合に、後で有効にするには、`ibmcloud ks feature-enable` [コマンド](cs_cli_reference.html#cs_cluster_feature_enable)を使用します。 トラストを有効にした後に無効にすることはできません。</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>ワーカー・ノードのハードウェア分離のレベル。 使用可能な物理リソースを自分専用にする場合は dedicated を使用し、IBM の他のお客様と物理リソースを共有することを許可する場合は shared を使用します。 デフォルトは shared です。  この値は、標準クラスターではオプションで、フリー・クラスターでは使用できません。</dd>

<dt><code>--zone <em>ZONE</em></code></dt>
<dd>クラスターを作成するゾーン。 使用可能なゾーンは、ログインしている {{site.data.keyword.Bluemix_notm}} 地域によって異なります。 最高のパフォーマンスを得るために、物理的に最も近い地域を選択してください。 この値は、標準クラスターでは必須で、フリー・クラスターではオプションです。

<p>[使用可能なゾーン](cs_regions.html#zones)を参照してください。</p>

<p class="note">国外のゾーンを選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>マシン・タイプを選択します。 ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてデプロイすることも、ベア・メタル上に物理マシンとしてデプロイすることもできます。 使用可能な物理マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 詳しくは、`ibmcloud ks machine-types` [コマンド](cs_cli_reference.html#cs_machine_types)についての説明を参照してください。 この値は、標準クラスターでは必須で、フリー・クラスターでは使用できません。</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>クラスターの名前。  この値は必須です。 名前は先頭が文字でなければならず、文字、数字、およびハイフン (-) を使用できます。35 文字以内でなければなりません。 Ingress サブドメインの完全修飾ドメイン・ネームは、クラスター名と、クラスターがデプロイされる地域で形成されます。 Ingress サブドメインを地域内で固有にするために、クラスター名が切り捨てられ、Ingress ドメイン・ネームにランダムな値が付加されることがあります。
</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>クラスター・マスター・ノードの Kubernetes のバージョン。 この値はオプションです。 バージョンを指定しなかった場合、クラスターは、サポートされるデフォルトの Kubernetes バージョンを使用して作成されます。 使用可能なバージョンを確認するには、<code>ibmcloud ks kube-versions</code> を実行します。
</dd>

<dt><code>--no-subnet</code></dt>
<dd>デフォルトでは、パブリックとプライベートのポータブル・サブネットが、クラスターに関連付けられた VLAN 上に作成されます。 クラスターを使用してサブネットを作成することを回避するには、<code>--no-subnet</code> フラグを指定します。 後でサブネットを[作成](#cs_cluster_subnet_create)したり、クラスターに[追加](#cs_cluster_subnet_add)したりすることができます。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>このパラメーターは、フリー・クラスターでは使用できません。</li>
<li>この標準クラスターが、このゾーンに作成する最初の標準クラスターである場合は、このフラグを含めないでください。 プライベート VLAN は、クラスターが作成されるときに作成されます。</li>
<li>前に標準クラスターをこのゾーンに作成している場合、または前にプライベート VLAN を IBM Cloud インフラストラクチャー (SoftLayer) に作成している場合は、そのプライベート VLAN を指定する必要があります。 必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。</li>
</ul>

<p>特定のゾーンにプライベート VLAN が既に存在するかどうかや、既存のプライベート VLAN の名前を確認するには、<code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> を実行します。</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>このパラメーターは、フリー・クラスターでは使用できません。</li>
<li>この標準クラスターが、このゾーンに作成する最初の標準クラスターである場合は、このフラグを使用しないでください。 パブリック VLAN は、クラスターが作成されるときに作成されます。</li>
<li>前に標準クラスターをこのゾーンに作成している場合、または前にパブリック VLAN を IBM Cloud インフラストラクチャー (SoftLayer) に作成している場合は、そのパブリック VLAN を指定します。 ワーカー・ノードをプライベート VLAN だけに接続する場合は、このオプションを指定しないでください。 必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。</li>
</ul>

<p>特定のゾーンにパブリック VLAN が既に存在するかどうかや、既存のパブリック VLAN の名前を確認するには、<code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> を実行します。</p></dd>

<dt><code>--private-only </code></dt>
  <dd>このオプションは、パブリック VLAN が作成されるのを防止するために使用します。 `--private-vlan` フラグを指定する場合にしか必要でないため、`--public-vlan` フラグは含めないでください。  <p class="note">プライベート専用クラスターが必要な場合は、ネットワーク接続用にゲートウェイ・アプライアンスを構成する必要があります。 詳しくは、[プライベート・クラスター](cs_clusters_planning.html#private_clusters)を参照してください。</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>クラスターにデプロイするワーカー・ノードの数。 このオプションを指定しない場合、1 つのワーカー・ノードを持つクラスターが作成されます。 この値は、標準クラスターではオプションで、フリー・クラスターでは使用できません。

<p class="important">ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはいけません。 ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>ワーカー・ノードには、デフォルトでディスク暗号化の機能があります。[詳しくはこちらを参照してください](cs_secure.html#encrypted_disk)。 暗号化を無効にするには、このオプションを組み込みます。</dd>

<dt><code>--trusted</code></dt>
<dd><p>**ベア・メタルのみ**: [トラステッド・コンピューティング](cs_secure.html#trusted_compute)を有効にして、ベア・メタル・ワーカー・ノードが改ざんされていないことを検証します。 クラスターの作成時にトラストを有効にしなかった場合に、後で有効にするには、`ibmcloud ks feature-enable` [コマンド](cs_cli_reference.html#cs_cluster_feature_enable)を使用します。 トラストを有効にした後に無効にすることはできません。</p>
<p>ベア・メタルのマシン・タイプがトラストをサポートしているかどうかを調べるには、`ibmcloud ks machine-types<zone>` [コマンド](#cs_machine_types)の出力の`「Trustable」`フィールドを参照します。 クラスターでトラストが有効になっていることを確認するには、`ibmcloud ks cluster-get` [コマンド](#cs_cluster_get)の出力の**「Trust ready」**フィールドを参照します。 ベア・メタル・ワーカー・ノードでトラストが有効になっていることを確認するには、`ibmcloud ks worker-get` [コマンド](#cs_worker_get)の出力の**「Trust」**フィールドを参照します。</p></dd>

<dt><code>-s</code></dt>
<dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  

  **フリー・クラスターを作成する**: クラスター名のみ指定します。それ以外の値はすべてデフォルト値に設定されます。 フリー・クラスターは 30 日後に自動的に削除されます。 フリー・クラスターは一度に 1 つしか作成できません。 Kubernetes のすべての機能を利用するには、標準クラスターを作成してください。

  ```
  ibmcloud ks cluster-create --name my_cluster
  ```
  {: pre}

  **最初の標準クラスターを作成する**: あるゾーンに最初の標準クラスターを作成すると、プライベート VLAN も作成されます。 そのため、`--public-vlan` フラグを含めないようにしてください。
  {: #example_cluster_create}

  ```
  ibmcloud ks cluster-create --zone dal10 --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **2 番目以降の標準クラスターを作成する**: 既に標準クラスターをこのゾーンに作成してある場合、または以前にパブリック VLAN を IBM Cloud インフラストラクチャー (SoftLayer) に作成した場合は、`--public-vlan` フラグを使用してそのパブリック VLAN を指定します。 特定のゾーンにパブリック VLAN が既に存在するかどうかや、既存のパブリック VLAN の名前を確認するには、`ibmcloud ks vlans<zone>` を実行します。

  ```
  ibmcloud ks cluster-create --zone dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **{{site.data.keyword.Bluemix_dedicated_notm}} 環境でクラスターを作成する**:

  ```
  ibmcloud ks cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}

### ibmcloud ks cluster-feature-enable [-f] --cluster CLUSTER [--trusted][-s]
{: #cs_cluster_feature_enable}

既存のクラスターでフィーチャーを有効にします。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的に <code>--trusted</code> オプションを実行するには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>このフラグを指定すると、クラスター内のすべてのサポート対象ベア・メタル・ワーカー・ノードで[トラステッド・コンピューティング](cs_secure.html#trusted_compute)を有効にすることができます。 トラストを有効にした後に、そのクラスターのトラストを無効にすることはできません。</p>
   <p>ベア・メタルのマシン・タイプがトラストをサポートしているかどうかを調べるには、**ibmcloud ks machine-types<zone>` [コマンド](#cs_machine_types)の出力の`「Trustable」**フィールドを参照します。 クラスターでトラストが有効になっていることを確認するには、`ibmcloud ks cluster-get` [コマンド](#cs_cluster_get)の出力の**「Trust ready」**フィールドを参照します。 ベア・メタル・ワーカー・ノードでトラストが有効になっていることを確認するには、`ibmcloud ks worker-get` [コマンド](#cs_worker_get)の出力の**「Trust」**フィールドを参照します。</p></dd>

  <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**コマンド例**:

  ```
  ibmcloud ks cluster-feature-enable --cluster my_cluster --trusted=true
  ```
  {: pre}

### ibmcloud ks cluster-get --cluster CLUSTER [--json][--showResources] [-s]
{: #cs_cluster_get}

組織内のクラスターに関する情報を表示します。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>追加のクラスター・リソース (アドオン、VLAN、サブネット、ストレージなど) を表示します。</dd>


  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**コマンド例**:

  ```
  ibmcloud ks cluster-get --cluster my_cluster --showResources
  ```
  {: pre}

**出力例**:

  ```
  Name:                   mycluster
    ID:                     df253b6025d64944ab99ed63bb4567b6
    State:                  normal
    Created:                2018-09-28T15:43:15+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:30426
    Master Location:        Dallas
    Master Status:          Ready (21 hours ago)
    Ingress Subdomain:      ...
    Ingress Secret:         mycluster
    Workers:                6
    Worker Zones:           dal10, dal12
    Version:                1.11.3_1524
    Owner:                  owner@email.com
    Monitoring Dashboard:   ...
    Resource Group ID:      a8a12accd63b437bbd6d58fb6a462ca7
    Resource Group Name:    Default

  Addons
  Name                   Enabled
  customer-storage-pod   true
  basic-ingress-v2       true
  storage-watcher-pod    true

  Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false

  ```
  {: screen}

### ibmcloud ks cluster-refresh --cluster CLUSTER [-f][-s]
{: #cs_cluster_refresh}

クラスター・マスター・ノードを再始動して、新しい Kubernetes API 構成変更を適用します。ご使用のワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にクラスターを削除するには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks cluster-refresh --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks cluster-rm --cluster CLUSTER [--force-delete-storage][-f] [-s]
{: #cs_cluster_rm}

組織が使用するクラスターを削除します。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--force-delete-storage</code></dt>
   <dd>クラスターと、そのクラスターが使用する永続ストレージを削除します。 **注意**: このフラグを含めると、クラスターやその関連ストレージ・インスタンスに格納されているデータをリカバリーできません。 この値はオプションです。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にクラスターを削除するには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks cluster-rm --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks cluster-update --cluster CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update] [-f][-s]
{: #cs_cluster_update}

Kubernetes マスターをデフォルトの API バージョンに更新します。 更新中、クラスターにアクセスすることも変更することもできません。 ユーザーがデプロイしたワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。
{: shortdesc}

今後のデプロイメント用に、YAML ファイルを変更する必要がある場合があります。 詳しくは、この[リリース・ノート](cs_versions.html)を確認してください。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>クラスターの Kubernetes のバージョン。 バージョンを指定しない場合、Kubernetes マスターはデフォルトの API バージョンに更新されます。 使用可能なバージョンを確認するには、[ibmcloud ks kube-versions](#cs_kube_versions) を実行します。 この値はオプションです。</dd>

   <dt><code>--force-update</code></dt>
   <dd>変更が 2 つのマイナー・バージョンより大規模である場合でも、更新を試行します。 この値はオプションです。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを表示せず、強制的にコマンドを実行します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks cluster-update --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks clusters [--json][-s]
{: #cs_clusters}

組織が使用するクラスターのリストを表示します。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**例**:

  ```
  ibmcloud ks clusters
  ```
  {: pre}


### ibmcloud ks kube-versions [--json][-s]
{: #cs_kube_versions}

{{site.data.keyword.containerlong_notm}} でサポートされている Kubernetes のバージョンのリストを表示します。 最新の安定した機能を使用するために、[クラスター・マスター](#cs_cluster_update)と[ワーカー・ノード](cs_cli_reference.html#cs_worker_update)をデフォルト・バージョンに更新してください。
{: shortdesc}

<strong>最小限必要な許可</strong>: なし

**コマンド・オプション**:

  <dl>
  <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**例**:

  ```
  ibmcloud ks kube-versions
  ```
  {: pre}

<br />



## クラスター・コマンド: サービスと統合
{: #cluster_services_commands}


### ibmcloud ks cluster-service-bind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_NAME [-s]
{: #cs_cluster_service_bind}

{{site.data.keyword.Bluemix_notm}} サービスをクラスターに追加します。 {{site.data.keyword.Bluemix_notm}} カタログにある {{site.data.keyword.Bluemix_notm}} サービスを表示するには、`ibmcloud service offerings` を実行します。 **注**: サービス・キーをサポートする {{site.data.keyword.Bluemix_notm}} サービスだけを追加できます。
{: shortdesc}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割と、**開発者**の Cloud Foundry 役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名前空間の名前。 この値は必須です。</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_NAME</em></code></dt>
   <dd>バインドする {{site.data.keyword.Bluemix_notm}} サービス・インスタンスの名前。 サービス・インスタンスの名前を調べるには、<code>ibmcloud service list</code> を実行します。 アカウント内に同じ名前のインスタンスが複数ある場合は、名前の代わりにサービス・インスタンス ID を使用します。 ID を調べるには、<code>ibmcloud service show <service instance name> --guid</code> を実行します。 これらの値のいずれかが必要です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks cluster-service-bind --cluster my_cluster --namespace my_namespace --service my_service_instance
  ```
  {: pre}


### ibmcloud ks cluster-service-unbind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_GUID [-s]
{: #cs_cluster_service_unbind}

クラスターから {{site.data.keyword.Bluemix_notm}} サービスを削除します。
{: shortdesc}

{{site.data.keyword.Bluemix_notm}} サービスを削除すると、サービス資格情報がクラスターから削除されます。 そのサービスをまだ使用しているポッドがあるなら、サービス資格情報を検出できなくなるためそのポッドは失敗します。
{: note}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割と、**開発者**の Cloud Foundry 役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Kubernetes 名前空間の名前。 この値は必須です。</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>削除する {{site.data.keyword.Bluemix_notm}} サービス・インスタンスの ID。 サービス・インスタンスの ID を確認するには、`ibmcloud ks cluster-services <cluster_name_or_ID>` を実行します。この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks cluster-service-unbind --cluster my_cluster --namespace my_namespace --service 8567221
  ```
  {: pre}


### ibmcloud ks cluster-services --cluster CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces] [--json][-s]
{: #cs_cluster_services}

クラスター内の 1 つまたはすべての Kubernetes 名前空間にバインドされたサービスをリストします。 指定されたオプションがない場合、デフォルトの名前空間のサービスが表示されます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>クラスター内の特定の名前空間にバインドされたサービスを含めます。 この値はオプションです。</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>クラスター内のすべての名前空間にバインドされたサービスを含めます。 この値はオプションです。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks cluster-services --cluster my_cluster --namespace my_namespace
  ```
  {: pre}

### ibmcloud ks va --container CONTAINER_ID [--extended][--vulnerabilities] [--configuration-issues][--json]
{: #cs_va}

[コンテナー・スキャナーのインストール](/docs/services/va/va_index.html#va_install_container_scanner)後に、クラスター内のコンテナーに関する詳細な脆弱性評価レポートを表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.registrylong_notm}} に対する**リーダー**のサービス・アクセス役割。**注**: {{site.data.keyword.registryshort_notm}} のポリシーをリソース・グループ・レベルで割り当てないでください。

**コマンド・オプション**:

<dl>
<dt><code>--container CONTAINER_ID</code></dt>
<dd><p>コンテナーの ID。 この値は必須です。</p>
<p>コンテナーの ID を確認するには、次のようにします。<ol><li>[クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。</li><li>`kubectl get pods` を実行して、ポッドをリストします。</li><li>`kubectl describe pod <pod_name>` コマンドの出力内で **Container ID** フィールドを見つけます。 例えば、`Container ID: containerd://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15` などです。</li><li>`ibmcloud ks va` コマンドのコンテナー ID から `containerd://` 接頭部を削除してから、その ID を使用します。 上記の例では、`1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15` の部分です。</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>脆弱なパッケージについてより多くの修正情報を表示するようにコマンド出力を拡張します。 この値はオプションです。</p>
<p>デフォルトでは、スキャン結果には ID、ポリシーの状況、影響を受けるパッケージ、解決方法が表示されます。 `--extended` フラグを使用すると、要約、ベンダーのセキュリティー上の注意、公式通知のリンクなどの情報が追加されます。</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>コマンド出力にパッケージの脆弱性のみが表示されるように制限します。 この値はオプションです。 このフラグを `--configuration-issues` フラグと併用することはできません。</dd>

<dt><code>--configuration-issues</code></dt>
<dd>構成の問題のみを表示するようにコマンド出力を制限します。 この値はオプションです。 `--vulnerabilities` フラグを使用する場合、このフラグは使用できません。</dd>

<dt><code>--json</code></dt>
<dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>
</dl>

**例**:

```
ibmcloud ks va --container 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}

### ibmcloud ks key-protect-enable --cluster CLUSTER_NAME_OR_ID --key-protect-url ENDPOINT --key-protect-instance INSTANCE_GUID --crk ROOT_KEY_ID
{: #cs_key_protect}

クラスター内で[鍵管理サービス (KMS) プロバイダー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) として [{{site.data.keyword.keymanagementservicefull}} ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](/docs/services/key-protect/index.html#getting-started-with-key-protect) を使用して、Kubernetes シークレットを暗号化します。
{: shortdesc}

{{site.data.keyword.keymanagementserviceshort}} インスタンス内でルート・キーを削除すると、クラスター内でシークレットからデータにアクセスしたりデータを削除したりすることはできません。
{: important}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

**コマンド・オプション**:

<dl>
<dt><code>--container CLUSTER_NAME_OR_ID</code></dt>
<dd>クラスターの名前または ID。</dd>

<dt><code>--key-protect-url ENDPOINT</code></dt>
<dd>クラスター・インスタンスの {{site.data.keyword.keymanagementserviceshort}} エンドポイント。 このエンドポイントを取得するには、[地域別のサービス・エンドポイント](/docs/services/key-protect/regions.html#endpoints)を参照してください。</dd>

<dt><code>--key-protect-instance INSTANCE_GUID</code></dt>
<dd>{{site.data.keyword.keymanagementserviceshort}} インスタンス GUID。 このインスタンス GUID を取得するには、<code>ibmcloud resource service-instance SERVICE_INSTANCE_NAME --id</code> を実行し、2 番目の値 (CRN 全体ではない) をコピーします。</dd>

<dt><code>--crk ROOT_KEY_ID</code></dt>
<dd>{{site.data.keyword.keymanagementserviceshort}} ルート・キー ID。 CRK を取得するには、[鍵の表示](/docs/services/key-protect/view-keys.html#view-keys)を参照してください。</dd>
</dl>

**例**:

```
ibmcloud ks key-protect-enable --cluster mycluster --key-protect-url keyprotect.us-south.bluemix.net --key-protect-instance a11aa11a-bbb2-3333-d444-e5e555e5ee5 --crk 1a111a1a-bb22-3c3c-4d44-55e555e55e55
```
{: pre}


### ibmcloud ks webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-s]
{: #cs_webhook_create}

Web フックを登録します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd><code>Normal</code> や <code>Warning</code> などの通知レベル。 <code>警告</code> はデフォルト値です。 この値はオプションです。</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Web フックのタイプ。 現在は、slack がサポートされています。 この値は必須です。</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>Web フックの URL。 この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## クラスター・コマンド: サブネット
{: #cluster_subnets_commands}

### ibmcloud ks cluster-subnet-add --cluster CLUSTER --subnet-id SUBNET [-s]
{: #cs_cluster_subnet_add}

自動的にプロビジョンされるサブネットを使用する代わりに、既存のポータブル・パブリック・サブネットまたはポータブル・プライベート・サブネットを IBM Cloud インフラストラクチャー (SoftLayer) アカウントから Kubernetes クラスターに追加したり、削除したクラスターのサブネットを再使用したりできます。
{: shortdesc}

<p class="important">ポータブル・パブリック IP アドレスは、月単位で課金されます。 クラスターをプロビジョンした後にポータブル・パブリック IP アドレスを削除した場合、短時間しか使用していなくても月額料金を支払う必要があります。</br>
</br>クラスターでサブネットを使用できるようにすると、このサブネットの IP アドレスは、クラスターのネットワーキングの目的で使用されるようになります。 IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。 あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containerlong_notm}}の外部で使用したりしないでください。</br>
</br>同じ VLAN の別々のサブネットにあるワーカーが通信できるようにするには、[同じ VLAN 上のサブネット間のルーティングを有効にする](cs_subnets.html#subnet-routing)必要があります。</p>

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--subnet-id <em>SUBNET</em></code></dt>
   <dd>サブネットの ID。 この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks cluster-subnet-add --cluster my_cluster --subnet-id 1643389
  ```
  {: pre}


### ibmcloud ks cluster-subnet-create --cluster CLUSTER --size SIZE --vlan VLAN_ID [-s]
{: #cs_cluster_subnet_create}

IBM Cloud インフラストラクチャー (SoftLayer) アカウントでサブネットを作成し、{{site.data.keyword.containerlong_notm}} において指定されたクラスターでそのサブネットを使用できるようにします。

<p class="important">クラスターでサブネットを使用できるようにすると、このサブネットの IP アドレスは、クラスターのネットワーキングの目的で使用されるようになります。 IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。 あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containerlong_notm}}の外部で使用したりしないでください。</br>
</br>1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](cs_users.html#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)を使用します。 {{site.data.keyword.BluDirectLink}} を使用している場合は、代わりに[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) を使用する必要があります。 VRF を有効にするには、IBM Cloud インフラストラクチャー (SoftLayer) のアカウント担当者に連絡してください。</p>

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。 クラスターをリストするには、`ibmcloud ks clusters` [コマンド](#cs_clusters)を使用します。</dd>

   <dt><code>--size <em>SIZE</em></code></dt>
   <dd>サブネット IP アドレスの数。 この値は必須です。 指定可能な値は 8、16、32、64 です。</dd>

   <dd>サブネットを作成する VLAN。 この値は必須です。 使用可能な VLAN をリストするには、`ibmcloud ks vlans<zone>` [コマンド](#cs_vlans)を使用します。 サブネットは、VLAN が存在するゾーンにプロビジョンされます。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks cluster-subnet-create --cluster my_cluster --size 8 --vlan 1764905
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-add --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

{{site.data.keyword.containerlong_notm}} のクラスターに独自のプライベート・サブネットを追加します。

このプライベート・サブネットは、IBM Cloud インフラストラクチャー (SoftLayer) から提供されたプライベート・サブネットではありません。 このため、そのサブネットに対してインバウンドおよびアウトバウンドのネットワーク・トラフィックのルーティングをすべて構成する必要があります。 IBM Cloud インフラストラクチャー (SoftLayer) のサブネットを追加する場合は、`ibmcloud ks cluster-subnet-add` [コマンド](#cs_cluster_subnet_add)を使用します。

<p class="important">クラスターでサブネットを使用できるようにすると、このサブネットの IP アドレスは、クラスターのネットワーキングの目的で使用されるようになります。 IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。 あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containerlong_notm}}の外部で使用したりしないでください。</br>
</br>1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](cs_users.html#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)を使用します。 {{site.data.keyword.BluDirectLink}} を使用している場合は、代わりに[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) を使用する必要があります。 VRF を有効にするには、IBM Cloud インフラストラクチャー (SoftLayer) のアカウント担当者に連絡してください。</p>

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>サブネットのクラスレス・ドメイン間ルーティング (CIDR)。 この値は必須です。IBM Cloud インフラストラクチャー (SoftLayer) によって使用されるどのサブネットとも競合しない値にする必要があります。

   サポートされる接頭部の範囲は、`/30` (1 個の IP アドレス) から `/24` (253 個の IP アドレス) です。 CIDR の接頭部の長さを設定した後でその長さを変更することが必要になった場合は、まず新しい CIDR を追加し、その後[古い CIDR を削除](#cs_cluster_user_subnet_rm)します。</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>プライベート VLAN の ID。 この値は必須です。 この値は、クラスター内にある 1 つ以上のワーカー・ノードのプライベート VLAN ID と一致していなければなりません。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks cluster-user-subnet-add --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-rm --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

指定されたクラスターから独自のプライベート・サブネットを削除します。 独自のプライベート・サブネットに属する IP アドレスにデプロイされたサービスは、そのサブネットが削除された後にもすべてアクティブのままになります。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>サブネットのクラスレス・ドメイン間ルーティング (CIDR)。 この値は必須です。`ibmcloud ks cluster-user-subnet-add` [コマンド](#cs_cluster_user_subnet_add)で設定された CIDR と一致する値にする必要があります。</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>プライベート VLAN の ID。 この値は必須です。`ibmcloud ks cluster-user-subnet-add` [コマンド](#cs_cluster_user_subnet_add)で設定された VLAN ID と一致する値にする必要があります。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks cluster-user-subnet-rm --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}

### ibmcloud ks subnets [--json][-s]
{: #cs_subnets}

IBM Cloud インフラストラクチャー (SoftLayer) アカウントで使用できるサブネットのリストを表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**例**:

  ```
  ibmcloud ks subnets
  ```
  {: pre}


<br />


## Ingress アプリケーション・ロード・バランサー (ALB) コマンド
{: #alb_commands}

### ibmcloud ks alb-autoupdate-disable --cluster CLUSTER
{: #cs_alb_autoupdate_disable}

デフォルトでは、Ingress アプリケーション・ロード・バランサー (ALB) アドオンに対する自動更新が有効になっています。新しいビルド・バージョンが使用可能になると、ALB ポッドが自動的に更新されます。代わりに手動でアドオンを更新したい場合に、このコマンドを使用して自動更新を無効にすることができます。その後に、[`ibmcloud ks alb-update` コマンド](#cs_alb_update)を実行して ALB ポッドを更新できます。

お客様がクラスターの Kubernetes のメジャー・バージョンまたはマイナー・バージョンを更新した場合、IBM は Ingress デプロイメントに対して必要な変更を自動的に行いますが、Ingress ALB アドオンのビルド・バージョンは変更しません。お客様が、最新の Kubernetes バージョンと Ingress ALB アドオン・イメージの適合性を確認する必要があります。

**最小限必要な許可**: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

**例**:

```
ibmcloud ks alb-autoupdate-disable --cluster mycluster
```
{: pre}

### ibmcloud ks alb-autoupdate-enable --cluster CLUSTER
{: #cs_alb_autoupdate_enable}

Ingress ALB アドオンの自動更新を無効にした場合に、再び自動更新を有効にすることができます。次のビルド・バージョンが使用可能になるたびに、ALB は自動的に最新ビルドに更新されます。

**最小限必要な許可**: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

**例**:

```
ibmcloud ks alb-autoupdate-enable --cluster mycluster
```
{: pre}

### ibmcloud ks alb-autoupdate-get --cluster CLUSTER
{: #cs_alb_autoupdate_get}

Ingress ALB アドオンの自動更新が有効になっているかどうか、および ALB が最新のビルド・バージョンに更新されているかどうかを検査します。

**最小限必要な許可**: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

**例**:

```
ibmcloud ks alb-autoupdate-get --cluster mycluster
```
{: pre}

### ibmcloud ks alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN [--update][-s]
{: #cs_alb_cert_deploy}

クラスター内の ALB に対する、{{site.data.keyword.cloudcerts_long_notm}} インスタンスからの証明書のデプロイまたは更新を実行します。 同じ {{site.data.keyword.cloudcerts_long_notm}} インスタンスからインポートされた証明書のみを更新できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--update</code></dt>
   <dd>クラスター内の ALB シークレットの証明書を更新します。 この値はオプションです。</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>ALB シークレットの名前。 この値は必須です。</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>証明書 CRN。 この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

ALB シークレットをデプロイする場合の例:

   ```
   ibmcloud ks alb-cert-deploy --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

既存の ALB シークレットを更新する場合の例:

 ```
 ibmcloud ks alb-cert-deploy --update --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud ks alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [--json][-s]
{: #cs_alb_cert_get}

クラスター内の ALB シークレットに関する情報を表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB シークレットの名前。 この値は、クラスター内の特定の ALB シークレットに関する情報を取得するときに必要です。</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>証明書 CRN。 この値は、クラスター内の特定の証明書 CRN と一致する、すべての ALB シークレットに関する情報を取得するときに必要です。</dd>

  <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**例**:

 ALB シークレットに関する情報を取り出す場合の例:

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 指定された証明書 CRN と一致する、すべての ALB シークレットに関する情報を取り出す場合の例:

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

クラスター内の ALB シークレットを削除します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>ALB シークレットの名前。 この値は、クラスター内の特定の ALB シークレットを削除するときに必要です。</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>証明書 CRN。 この値は、クラスター内の特定の証明書 CRN と一致する、すべての ALB シークレットを削除するときに必要です。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

  </dl>

**例**:

 ALB シークレットを削除する場合の例:

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 指定された証明書 CRN と一致する、すべての ALB シークレットを削除する場合の例:

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-certs --cluster CLUSTER [--json][-s]
{: #cs_alb_certs}

クラスター内の ALB シークレットのリストを表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>
   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>
   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

 ```
 ibmcloud ks alb-certs --cluster my_cluster
 ```
 {: pre}

### ibmcloud ks alb-configure --albID ALB_ID [--enable][--user-ip USERIP] [--disable][--disable-deployment] [-s]
{: #cs_alb_configure}

標準クラスターで、ALB を有効または無効にします。 パブリック ALB は、デフォルトで有効になります。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

**コマンド・オプション**:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB の ID。 クラスター内の ALB の ID を表示するには、<code>ibmcloud ks albs <em>--cluster </em>CLUSTER</code> を実行します。 この値は必須です。</dd>

   <dt><code>--enable</code></dt>
   <dd>クラスター内の ALB を有効にするには、このフラグを指定します。</dd>

   <dt><code>--disable</code></dt>
   <dd>クラスター内の ALB を無効にするには、このフラグを指定します。</dd>

   <dt><code>--disable-deployment</code></dt>
   <dd>IBM 提供の ALB デプロイメントを無効にするには、このフラグを指定します。 このフラグは、IBM 提供の Ingress サブドメインの DNS 登録も、Ingress コントローラーを公開するために使用されるロード・バランサー・サービスも削除しません。</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>このパラメーターは、プライベート ALB のみを有効にする場合に使用できます。</li>
    <li>プライベート ALB は、ユーザー提供のプライベート・サブネットからの IP アドレスとともにデプロイされます。 IP アドレスが提供されない場合、ALB は、クラスターの作成時に自動的にプロビジョンされたポータブル・プライベート・サブネットのプライベート IP アドレスを使用してデプロイされます。</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ALB を有効にする場合の例:

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  ユーザー提供の IP アドレスを使用して ALB を有効にする場合の例:

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip user_ip
  ```
  {: pre}

  ALB を無効にする場合の例:

  ```
  ibmcloud ks alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud ks alb-get --albID ALB_ID [--json][-s]
{: #cs_alb_get}

ALB の詳細を表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ALB の ID。 クラスター内の ALB の ID を表示するには、<code>ibmcloud ks albs --cluster <em>CLUSTER</em></code> を実行します。 この値は必須です。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud ks alb-rollback --cluster CLUSTER
{: #cs_alb_rollback}

ALB ポッドが最近更新されたが、ALB のカスタム構成が最新ビルドの影響を受けているという場合は、ALB ポッドが以前実行していたビルドに更新をロールバックできます。更新をロールバックした後、ALB ポッドの自動更新は無効になります。自動更新を再び有効にするには、[`alb-autoupdate-enable` コマンド](#cs_alb_autoupdate_enable)を使用します。

**最小限必要な許可**: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

**例**:

```
ibmcloud ks alb-rollback --cluster mycluster
```
{: pre}

### ibmcloud ks alb-types [--json][-s]
{: #cs_alb_types}

この地域でサポートされている ALB のタイプを表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**例**:

  ```
  ibmcloud ks alb-types
  ```
  {: pre}

### ibmcloud ks alb-update --cluster CLUSTER
{: #cs_alb_update}

Ingress ALB アドオンの自動更新が無効になっている場合にアドオンを更新するには、一回限りの ALB ポッド更新を強制実行します。アドオンを手動で更新することにした場合は、クラスター内のすべての ALB ポッドが最新ビルドに更新されます。個々の ALB を更新したり、どのビルドにアドオンを更新するかを選択したりすることはできません。自動更新は無効のままです。

お客様がクラスターの Kubernetes のメジャー・バージョンまたはマイナー・バージョンを更新した場合、IBM は Ingress デプロイメントに対して必要な変更を自動的に行いますが、Ingress ALB アドオンのビルド・バージョンは変更しません。お客様が、最新の Kubernetes バージョンと Ingress ALB アドオン・イメージの適合性を確認する必要があります。

**最小限必要な許可**: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

**例**:

```
ibmcloud ks alb-update --cluster <cluster_name_or_ID>
```
{: pre}

### ibmcloud ks albs --cluster CLUSTER [--json][-s]
{: #cs_albs}

クラスター内のすべての ALB の状態を表示します。 ALB ID が返されない場合、クラスターには移植可能なサブネットはありません。 サブネットを[作成](#cs_cluster_subnet_create)したり、クラスターに[追加](#cs_cluster_subnet_add)したりすることができます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>使用可能な ALB をリストするクラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks albs --cluster my_cluster
  ```
  {: pre}


<br />


## インフラストラクチャー・コマンド
{: #infrastructure_commands}

### ibmcloud ks credential-get [-s][--json]
{: #cs_credential_get}

複数の異なる資格情報を使用して IBM Cloud インフラストラクチャー・ポートフォリオにアクセスするように IBM Cloud アカウントをセットアップした場合に、現在ターゲットになっている地域とリソース・グループのインフラストラクチャー・ユーザー名を取得します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

 <dl>
 <dt><code>--json</code></dt>
 <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>
 <dt><code>-s</code></dt>
 <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
 </dl>

**例:**
```
ibmcloud ks credential-get
```
{: pre}

**出力例:**
```
Infrastructure credentials for user name user@email.com set for resource group default.
```

### ibmcloud ks credential-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME [-s]
{: #cs_credentials_set}

{{site.data.keyword.containerlong_notm}} リソース・グループおよび地域に IBM Cloud インフラストラクチャー (SoftLayer) アカウントの資格情報を設定します。

{{site.data.keyword.Bluemix_notm}} 従量制課金アカウントがあれば、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにデフォルトでアクセスできます。 しかし、既に所有している別の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用して、インフラストラクチャーを注文したい場合もあるでしょう。 このコマンドを使用すると、そのようなインフラストラクチャー・アカウントを {{site.data.keyword.Bluemix_notm}} アカウントにリンクできます。

特定の地域とリソース・グループに対して IBM Cloud インフラストラクチャー (SoftLayer) の資格情報が手動で設定されている場合、その地域のそのリソース・グループ内のすべてのクラスターにおいて、それらの資格情報を使用してインフラストラクチャーを注文します。 リソース・グループおよび地域に [{{site.data.keyword.Bluemix_notm}}IAM API キー](#cs_api_key_info)が既に存在している場合でも、インフラストラクチャー権限を判別するためにこれらの資格情報が使用されます。 資格情報が保管されているユーザーにインフラストラクチャーを注文するために必要な権限がない場合、クラスターを作成したりワーカー・ノードを再ロードしたりするインフラストラクチャー関連のアクションは失敗する可能性があります。

同じ {{site.data.keyword.containerlong_notm}} リソース・グループおよび地域に複数の資格情報を設定することはできません。

このコマンドを使用する前に、使用する資格情報を所有するユーザーに、必要な [{{site.data.keyword.containerlong_notm}} 権限と IBM Cloud インフラストラクチャー (SoftLayer) 権限](cs_users.html#users)があることを確認してください。
{: important}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud インフラストラクチャー (SoftLayer) アカウントの API ユーザー名。 この値は必須です。 インフラストラクチャー API ユーザー名は IBMid と同じではないことに注意してください。インフラストラクチャーの API ユーザー名を表示するには、以下のようにします。
   <ol><li>[{{site.data.keyword.Bluemix_notm}} ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/) にログインします。</li>
   <li>メニュー ![メニュー・アイコン](../icons/icon_hamburger.svg "メニュー・アイコン") から、**「インフラストラクチャー」**を選択します。</li>
   <li>メニュー・バーから、**「アカウント」** > **「ユーザー」** > **「ユーザー・リスト」**を選択します。</li>
   <li>表示するユーザーの**「IBM ID またはユーザー名」**をクリックします。</li>
   <li>**「API アクセス情報」**セクションで、**「API ユーザー名」**を表示します。</li>
   </ol></dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud インフラストラクチャー (SoftLayer) アカウントの API キー。 この値は必須です。

 <p>
  API キーを生成するには、以下のようにします。

  <ol>
  <li>[IBM Cloud インフラストラクチャー (SoftLayer) ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.bluemix.net/) にログインします。</li>
  <li><strong>「アカウント」</strong>を選択し、次に<strong>「ユーザー」</strong>を選択します。</li>
  <li><strong>「生成」</strong>をクリックして、アカウント用の IBM Cloud インフラストラクチャー (SoftLayer) の API キーを生成します。</li>
  <li>このコマンドで使用するために API キーをコピーします。</li>
  </ol>

  既存の API キーを表示するには、以下のようにします。
  <ol>
  <li>[IBM Cloud インフラストラクチャー (SoftLayer) ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.bluemix.net/) にログインします。</li>
  <li><strong>「アカウント」</strong>を選択し、次に<strong>「ユーザー」</strong>を選択します。</li>
  <li><strong>「表示」</strong>をクリックして既存の API キーを表示します。</li>
  <li>このコマンドで使用するために API キーをコピーします。</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

  </dl>

**例**:

  ```
  ibmcloud ks credential-set --infrastructure-api-key <api_key> --infrastructure-username dbmanager
  ```
  {: pre}

### ibmcloud ks credential-unset
{: #cs_credentials_unset}

{{site.data.keyword.containerlong_notm}} 地域から IBM Cloud インフラストラクチャー (SoftLayer) アカウントの資格情報を削除します。

資格情報を削除すると、[{{site.data.keyword.Bluemix_notm}}IAM API キー](#cs_api_key_info)が、IBM Cloud インフラストラクチャー (SoftLayer) のリソースの注文に使用されます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

  <dl>
  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**例**:

  ```
  ibmcloud ks credential-unset
  ```
  {: pre}


### ibmcloud ks machine-types --zone ZONE [--json][-s]
{: #cs_machine_types}

ワーカー・ノードのために使用できるマシン・タイプのリストを表示します。 マシン・タイプはゾーンによって異なります。 各マシン・タイプには、クラスター内の各ワーカー・ノード用の仮想 CPU、メモリー、ディスク・スペースの量が含まれます。 デフォルトでは、すべてのコンテナー・データが格納される 2 次ストレージ・ディスク・ディレクトリーは、LUKS 暗号で暗号化されます。 クラスターの作成時に `disable-disk-encrypt` オプションが指定された場合、ホストのコンテナー・ランタイムのデータは暗号化されません。 [暗号化について詳しくは、こちらをご覧ください](cs_secure.html#encrypted_disk)。
{:shortdesc}

ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてプロビジョンすることも、ベア・メタル上に物理マシンとしてプロビジョンすることもできます。 [マシン・タイプのオプションについて詳しくは、こちらをご覧ください](cs_clusters_planning.html#shared_dedicated_node)。

<strong>最小限必要な許可</strong>: なし

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>使用可能なマシン・タイプをリストする対象のゾーンを入力します。 この値は必須です。 [使用可能なゾーン](cs_regions.html#zones)を参照してください。</dd>

   <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**コマンド例**:

  ```
  ibmcloud ks machine-types --zone dal10
  ```
  {: pre}

### ibmcloud ks vlans --zone ZONE [--all][--json] [-s]
{: #cs_vlans}

あるゾーンにおいて、IBM Cloud インフラストラクチャー (SoftLayer) アカウントで使用可能なパブリック VLAN とプライベート VLAN をリストします。 使用可能な VLAN をリストするには、有料アカウントが必要です。

<strong>最小限必要な許可</strong>:
* ゾーン内のクラスター接続先 VLAN を表示する場合: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割
* ゾーン内の使用可能な VLAN をすべてリストする場合: {{site.data.keyword.containerlong_notm}} 内の地域に対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>プライベート VLAN とパブリック VLAN をリストする対象のゾーンを入力します。 この値は必須です。 [使用可能なゾーン](cs_regions.html#zones)を参照してください。</dd>

   <dt><code>--all</code></dt>
   <dd>使用可能なすべての VLAN をリストします。 デフォルトでは、VLAN はフィルタリングされて、有効な VLAN のみが表示されます。 VLAN が有効であるためには、ローカル・ディスク・ストレージを持つワーカーをホストできるインフラストラクチャーに VLAN が関連付けられている必要があります。</dd>

   <dt><code>--json</code></dt>
  <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks vlans --zone dal10
  ```
  {: pre}


### ibmcloud ks vlan-spanning-get [--json][-s]
{: #cs_vlan_spanning_get}

IBM Cloud インフラストラクチャー (SoftLayer) アカウントの VLAN スパンニングの状況を表示します。 VLAN スパンニングにより、アカウントのすべてのデバイスは、それぞれに割り当てられた VLAN に関係なく、プライベート・ネットワークを使用して相互に通信することができます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
    <dt><code>--json</code></dt>
      <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

    <dt><code>-s</code></dt>
      <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks vlan-spanning-get
  ```
  {: pre}

<br />


## ロギング・コマンド
{: #logging_commands}

### ibmcloud ks logging-autoupdate-disable --cluster CLUSTER
{: #cs_log_autoupdate_disable}

特定のクラスター内の Fluentd ポッドの自動更新を無効にします。 お客様がクラスターの Kubernetes のメジャー・バージョンまたはマイナー・バージョンを更新した場合、IBM は Fluentd 構成マップに対して必要な変更を自動的に行いますが、ロギング用 Fluentd アドオンのビルド・バージョンは変更しません。お客様が、最新の Kubernetes バージョンとアドオン・イメージの適合性を確認する必要があります。

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Fluentd アドオンの自動更新を無効にするクラスターの名前または ID。この値は必須です。</dd>
</dl>

### ibmcloud ks logging-autoupdate-enable --cluster CLUSTER
{: #cs_log_autoupdate_enable}

特定のクラスター内の Fluentd ポッドの自動更新を有効にします。新しいビルド・バージョンが使用可能になると、Fluentd ポッドが自動的に更新されます。

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Fluentd アドオンの自動更新を有効にするクラスターの名前または ID。この値は必須です。</dd>
</dl>

### ibmcloud ks logging-autoupdate-get --cluster CLUSTER
{: #cs_log_autoupdate_get}

特定のクラスター内の Fluentd ポッドが自動更新されるように設定されているかどうかを検査します。

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Fluentd アドオンの自動更新が有効になっているかどうかを検査するクラスターの名前または ID。この値は必須です。</dd>
</dl>

### ibmcloud ks logging-config-create --cluster CLUSTER --logsource LOG_SOURCE --type LOG_TYPE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS][--syslog-protocol PROTOCOL]  [--json][--skip-validation] [--force-update][-s]
{: #cs_logging_create}

ロギング構成を作成します。 このコマンドを使用して、コンテナー、アプリケーション、ワーカー・ノード、Kubernetes クラスター、Ingress アプリケーション・ロード・バランサーのログを {{site.data.keyword.loganalysisshort_notm}} または外部 syslog サーバーに転送できます。

<strong>最小限必要な許可</strong>: `kube-audit` 以外のログ・ソースの場合はクラスターに対する**エディター**のプラットフォーム役割、`kube-audit` ログ・ソースの場合はクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>    
    <dd>ログ転送を有効にする対象のログ・ソース。 この引数では、構成を適用するログ・ソースのコンマ区切りのリストを使用できます。 指定可能な値は、<code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>storage</code>、<code>ingress</code>、および <code>kube-audit</code> です。 ログ・ソースを指定しない場合は、<code>container</code> と <code>ingress</code> の構成が作成されます。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>ログの転送先。 オプションは、ログを {{site.data.keyword.loganalysisshort_notm}} に転送する <code>ibm</code> と、ログを外部サーバーに転送する <code>syslog</code> です。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>ログの転送元になる Kubernetes 名前空間。 ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。 この値はコンテナー・ログ・ソースについてのみ有効で、オプションです。 名前空間を指定しないと、クラスター内のすべての名前空間でこの構成が使用されます。</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
    <dd>ロギング・タイプが <code>syslog</code> であるとき、ログ・コレクター・サーバーのホスト名または IP アドレス。 この値は <code>syslog</code> の場合に必須です。 ロギング・タイプが <code>ibm</code> であるとき、{{site.data.keyword.loganalysislong_notm}} 取り込み URL。 選択可能な取り込み URL のリストは、[ここを参照してください](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)。 取り込み URL を指定しない場合、クラスターが作成された地域のエンドポイントが使用されます。</dd>

  <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
    <dd>ログ・コレクター・サーバーのポート。 この値はオプションです。 ポートを指定しないと、標準ポート <code>514</code> が <code>syslog</code> で使用され、標準ポート <code>9091</code> が <code>ibm</code> で使用されます。</dd>

  <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
    <dd>オプション: ログの送信先となる Cloud Foundry スペースの名前。 この値はログ・タイプ <code>ibm</code> についてのみ有効で、オプションです。 スペースを指定しない場合、ログはアカウント・レベルに送信されます。 スペースを指定する場合、org も指定する必要があります。</dd>

  <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
    <dd>オプション: このスペースが属する Cloud Foundry 組織の名前。 この値はログ・タイプ <code>ibm</code> についてのみ有効で、スペースを指定した場合には必須です。</dd>

  <dt><code>--app-paths</code></dt>
    <dd>アプリがロギングするコンテナー上のパス。 ソース・タイプが <code>application</code> のログを転送するには、パスを指定する必要があります。 複数のパスを指定するには、コンマ区切りリストを使用します。 この値はログ・ソース <code>application</code> の場合に必須です。 例: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>ロギング・タイプが <code>syslog</code> の場合に使用される転送層プロトコル。 サポートされる値は、<code>tcp</code>、<code>tls</code>、およびデフォルトの <code>udp</code> です。 <code>udp</code> プロトコルを使用して rsyslog サーバーに転送する場合、1KB を超えるログは切り捨てられます。</dd>

  <dt><code>--app-containers</code></dt>
    <dd>アプリのログを転送するには、アプリが含まれているコンテナーの名前を指定します。 コンマ区切りのリストを使用して複数のコンテナーを指定できます。 コンテナーを指定しない場合は、指定したパスが入っているすべてのコンテナーのログが転送されます。 このオプションは、ログ・ソース <code>application</code> の場合にのみ有効です。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>組織名とスペース名が指定されている場合にそれらの検証をスキップします。 検証をスキップすると処理時間は短縮されますが、ロギング構成が無効な場合、ログは正しく転送されません。 この値はオプションです。</dd>

  <dt><code>--force-update</code></dt>
    <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

    <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

デフォルト・ポート 9091 で `container` ログ・ソースから転送されるログ・タイプ `ibm` の例:

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

デフォルト・ポート 514 で `container` ログ・ソースから転送されるログ・タイプ `syslog` の例:

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

デフォルトではないポートで `ingress` ソースからログを転送するログ・タイプ `syslog` の例:

  ```
  ibmcloud ks logging-config-create --cluster my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud ks logging-config-get --cluster CLUSTER [--logsource LOG_SOURCE][--json] [-s]
{: #cs_logging_get}

クラスターのログ転送構成をすべて表示するか、またはログ・ソースを基準にロギング構成をフィルタリングします。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

 <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
    <dd>フィルター操作で取得するログ・ソースの種類。 クラスター内のこのログ・ソースのロギング構成のみが返されます。 指定可能な値は、<code>container</code>、<code>storage</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code>、および <code>kube-audit</code> です。 この値はオプションです。</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>以前のフィルターをサポート対象外にするロギング・フィルターを表示します。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
 </dl>

**例**:

  ```
  ibmcloud ks logging-config-get --cluster my_cluster --logsource worker
  ```
  {: pre}


### ibmcloud ks logging-config-refresh --cluster CLUSTER  [--force-update][-s]
{: #cs_logging_refresh}

クラスターのロギング構成をリフレッシュします。 クラスター内のスペース・レベルに転送を行うすべてのロギング構成のロギング・トークンをリフレッシュします。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--force-update</code></dt>
     <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

   <dt><code>-s</code></dt>
     <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks logging-config-refresh --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks logging-config-rm --cluster CLUSTER [--id LOG_CONFIG_ID][--all] [--force-update][-s]
{: #cs_logging_rm}

クラスターの 1 つのログ転送構成またはすべてのロギング構成を削除します。 これにより、リモート syslog サーバーまたは {{site.data.keyword.loganalysisshort_notm}} へのログの転送が停止します。

<strong>最小限必要な許可</strong>: `kube-audit` 以外のログ・ソースの場合はクラスターに対する**エディター**のプラットフォーム役割、`kube-audit` ログ・ソースの場合はクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>単一のロギング構成を削除する場合は、ロギング構成 ID。</dd>

  <dt><code>--all</code></dt>
   <dd>クラスター内のすべてのロギング構成を削除するフラグ。</dd>

  <dt><code>--force-update</code></dt>
    <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

   <dt><code>-s</code></dt>
     <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks logging-config-rm --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud ks logging-config-update --cluster CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-paths PATH] [--app-containers PATH][--json] [--skipValidation][--force-update] [-s]
{: #cs_logging_update}

ログ転送構成の詳細を更新します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>更新するロギング構成 ID。 この値は必須です。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>使用するログ転送プロトコル。 現在、<code>syslog</code> と <code>ibm</code> がサポートされています。 この値は必須です。</dd>

  <dt><code>--namespace <em>NAMESPACE</em></code>
    <dd>ログの転送元になる Kubernetes 名前空間。 ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。 この値は、<code>container</code> ログ・ソースについてのみ有効です。 名前空間を指定しないと、クラスター内のすべての名前空間でこの構成が使用されます。</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>ロギング・タイプが <code>syslog</code> であるとき、ログ・コレクター・サーバーのホスト名または IP アドレス。 この値は <code>syslog</code> の場合に必須です。 ロギング・タイプが <code>ibm</code> であるとき、{{site.data.keyword.loganalysislong_notm}} 取り込み URL。 選択可能な取り込み URL のリストは、[ここを参照してください](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)。 取り込み URL を指定しない場合、クラスターが作成された地域のエンドポイントが使用されます。</dd>

   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>ログ・コレクター・サーバーのポート。 この値は、ロギング・タイプが <code>syslog</code> の場合にオプションです。 ポートを指定しないと、標準ポート <code>514</code> が <code>syslog</code> で使用され、<code>9091</code> が <code>ibm</code> で使用されます。</dd>

   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>オプション: ログの送信先となるスペースの名前。 この値はログ・タイプ <code>ibm</code> についてのみ有効で、オプションです。 スペースを指定しない場合、ログはアカウント・レベルに送信されます。 スペースを指定する場合、org も指定する必要があります。</dd>

   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>オプション: このスペースが属する Cloud Foundry 組織の名前。 この値はログ・タイプ <code>ibm</code> についてのみ有効で、スペースを指定した場合には必須です。</dd>

   <dt><code>--app-paths <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>ログの収集元となるコンテナー内の絶対ファイル・パス。 ワイルドカード (「/var/log/*.log」など) は使用できますが、再帰的なグロブ (「/var/log/**/test.log」) は使用できません。 複数のパスを指定するには、コンマ区切りリストを使用します。 この値は、ログ・ソースに「application」を指定する場合に必須です。 </dd>

   <dt><code>--app-containers <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>アプリがロギングするコンテナー上のパス。 ソース・タイプが <code>application</code> のログを転送するには、パスを指定する必要があります。 複数のパスを指定するには、コンマ区切りリストを使用します。 例: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>組織名とスペース名が指定されている場合にそれらの検証をスキップします。 検証をスキップすると処理時間は短縮されますが、ロギング構成が無効な場合、ログは正しく転送されません。 この値はオプションです。</dd>

  <dt><code>--force-update</code></dt>
    <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

   <dt><code>-s</code></dt>
     <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

**ログ・タイプ `ibm`** の例

  ```
  ibmcloud ks logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**ログ・タイプ `syslog` の例**

  ```
  ibmcloud ks logging-config-update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud ks logging-filter-create --cluster CLUSTER --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_create}

ロギング・フィルターを作成します。 このコマンドを使用すると、ロギング構成によって転送されるログをフィルターで除外できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>ロギング・フィルターを作成するクラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>フィルターを適用するログのタイプ。 現在、<code>all</code>、<code>container</code>、<code>host</code> がサポートされています。</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>ロギング構成 ID のコンマ区切りのリスト。 指定しない場合、フィルターに渡されたすべてのクラスター・ロギング構成にフィルターが適用されます。 フィルターと一致するログ構成を表示するには、コマンドに <code>--show-matching-configs</code> フラグを使用します。 この値はオプションです。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>ログをフィルタリングする Kubernetes 名前空間。 この値はオプションです。</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>ログをフィルターで除外するコンテナーの名前。 このフラグは、ログ・タイプ <code>container</code> を使用している場合にのみ、適用されます。 この値はオプションです。</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>指定したレベル以下のログをフィルターで除外します。 指定できる値は、規定の順に <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code>、<code>trace</code> です。 この値はオプションです。 例えば、<code>info</code> レベルのログをフィルタリングした場合、<code>debug</code> と <code>trace</code> もフィルタリングされます。 **注**: このフラグは、ログ・メッセージが JSON 形式で、レベル・フィールドを含んでいる場合にのみ使用できます。 出力例: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>指定したメッセージが含まれているログをフィルターで除外します。 この値はオプションです。 例: メッセージ「Hello」、「!」、および「Hello, World!」はログ「Hello, World!」に適用されます。.</dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>ログ内のどこかの場所に正規表現で記述された指定メッセージが含まれるログをすべてフィルターで除外します。 この値はオプションです。 例: パターン「hello [0-9]」は「hello 1」、「hello 2」、「hello 9」に適用されます。</dd>

  <dt><code>--force-update</code></dt>
    <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

この例のフィルターでは、デフォルト名前空間内の `test-container` という名前のコンテナーから転送された、ログ・メッセージに「GET request」が含まれている、debug レベル以下のすべてのログが除外されます。

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

この例では、特定のクラスターから転送された info レベル以下のすべてのログをフィルターで除外します。 出力は JSON として返されます。

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud ks logging-filter-get --cluster CLUSTER [--id FILTER_ID][--show-matching-configs] [--show-covering-filters][--json] [-s]
{: #cs_log_filter_view}

ロギング・フィルター構成を表示します。 このコマンドを使用すると、作成したロギング・フィルターを表示できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>フィルターを表示するクラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>表示するログ・フィルターの ID。</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>表示している構成と一致するロギング構成を表示します。 この値はオプションです。</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>以前のフィルターをサポート対象外にするロギング・フィルターを表示します。 この値はオプションです。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
     <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

```
ibmcloud ks logging-filter-get mycluster --id 885732 --show-matching-configs
```
{: pre}

### ibmcloud ks logging-filter-rm --cluster CLUSTER [--id FILTER_ID][--all] [--force-update][-s]
{: #cs_log_filter_delete}

ロギング・フィルターを削除します。 このコマンドを使用すると、作成したロギング・フィルターを削除できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>フィルターを削除するクラスターの名前または ID。</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>削除するログ・フィルターの ID。</dd>

  <dt><code>--all</code></dt>
    <dd>すべてのログ転送フィルターを削除します。 この値はオプションです。</dd>

  <dt><code>--force-update</code></dt>
    <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

```
ibmcloud ks logging-filter-rm mycluster --id 885732
```
{: pre}

### ibmcloud ks logging-filter-update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_update}

ロギング・フィルターを更新します。 このコマンドを使用すると、作成したロギング・フィルターを更新できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**エディター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>ロギング・フィルターを更新するクラスターの名前または ID。 この値は必須です。</dd>

 <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>更新するログ・フィルターの ID。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>フィルターを適用するログのタイプ。 現在、<code>all</code>、<code>container</code>、<code>host</code> がサポートされています。</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>ロギング構成 ID のコンマ区切りのリスト。 指定しない場合、フィルターに渡されたすべてのクラスター・ロギング構成にフィルターが適用されます。 フィルターと一致するログ構成を表示するには、コマンドに <code>--show-matching-configs</code> フラグを使用します。 この値はオプションです。</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>ログをフィルタリングする Kubernetes 名前空間。 この値はオプションです。</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>ログをフィルターで除外するコンテナーの名前。 このフラグは、ログ・タイプ <code>container</code> を使用している場合にのみ、適用されます。 この値はオプションです。</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>指定したレベル以下のログをフィルターで除外します。 指定できる値は、規定の順に <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code>、<code>trace</code> です。 この値はオプションです。 例えば、<code>info</code> レベルのログをフィルタリングした場合、<code>debug</code> と <code>trace</code> もフィルタリングされます。 **注**: このフラグは、ログ・メッセージが JSON 形式で、レベル・フィールドを含んでいる場合にのみ使用できます。 出力例: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>指定したメッセージが含まれているログをフィルターで除外します。 この値はオプションです。 例: メッセージ「Hello」、「!」、および「Hello, World!」はログ「Hello, World!」に適用されます。.</dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>ログ内のどこかの場所に正規表現で記述された指定メッセージが含まれるログをすべてフィルターで除外します。 この値はオプションです。 例: パターン「hello [0-9]」は「hello 1」、「hello 2」、「hello 9」に適用されます</dd>

  <dt><code>--force-update</code></dt>
    <dd>Fluentd ポッドを強制的に最新バージョンに更新します。 ロギング構成に変更を加えるには、Fluentd が最新バージョンでなければなりません。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

この例のフィルターでは、デフォルト名前空間内の `test-container` という名前のコンテナーから転送された、ログ・メッセージに「GET request」が含まれている、debug レベル以下のすべてのログが除外されます。

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 885274 --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

この例では、特定のクラスターから転送された info レベル以下のすべてのログをフィルターで除外します。 出力は JSON として返されます。

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 274885 --type all --level info --json
  ```
  {: pre}

### ibmcloud ks logging-collect --cluster CLUSTER --cos-bucket BUCKET_NAME --cos-endpoint ENDPOINT --hmac-key-id HMAC_KEY_ID --hmac-key HMAC_KEY --type LOG_TYPE [-s]
{: #cs_log_collect}

特定の時点でのログのスナップショットを要求し、そのログを {{site.data.keyword.cos_full_notm}} バケットに保管します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>スナップショットを作成するクラスターの名前または ID。 この値は必須です。</dd>

 <dt><code>--cos-bucket <em>BUCKET_NAME</em></code></dt>
    <dd>ログの保管先となる {{site.data.keyword.cos_short}} バケットの名前。 この値は必須です。</dd>

  <dt><code>--cos-endpoint <em>ENDPOINT</em></code></dt>
    <dd>ログを保管するバケットの {{site.data.keyword.cos_short}} エンドポイント。 この値は必須です。</dd>

  <dt><code>--hmac-key-id <em>HMAC_KEY_ID</em></code></dt>
    <dd>Object Storage インスタンスの HMAC 資格情報の固有の ID。 この値は必須です。</dd>

  <dt><code>--hmac-key <em>HMAC_KEY</em></code></dt>
    <dd>{{site.data.keyword.cos_short}} インスタンスの HMAC 鍵。 この値は必須です。</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>スナップショットを作成する対象のログのタイプ。 現在、`master` が唯一のオプションであり、デフォルトでもあります。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  ```
  {: pre}

**出力例**:

  ```
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

### ibmcloud ks logging-collect-status --cluster CLUSTER [--json][-s]
{: #cs_log_collect_status}

クラスターのログ収集スナップショット要求の状況を確認します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**管理者**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>スナップショットを作成するクラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  ```
  {: pre}

**出力例**:

  ```
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## 地域コマンド
{: #region_commands}

### ibmcloud ks region
{: #cs_region}

現在自分が属している {{site.data.keyword.containerlong_notm}} 地域を見つけます。 その地域に固有のクラスターを作成して管理します。 地域を変更するには、`ibmcloud ks region-set` コマンドを使用します。

<strong>最小限必要な許可</strong>: なし

**例**:

```
ibmcloud ks region
```
{: pre}

**出力**:
```
Region: us-south
```
{: screen}

### ibmcloud ks region-set [--region REGION]
{: #cs_region-set}

{{site.data.keyword.containerlong_notm}} の地域を設定します。 その地域に固有のクラスターを作成して管理します。高可用性を確保するために、複数の地域にクラスターを作成することもできます。

例えば、米国南部地域の {{site.data.keyword.Bluemix_notm}} にログインしてクラスターを作成できます。 次に `ibmcloud ks region-set eu-central` を使用して中欧地域をターゲットにし、別のクラスターを作成できます。 最後に、`ibmcloud ks region-set us-south` を使用して米国南部地域に戻り、その地域のクラスターを管理できます。

<strong>最小限必要な許可</strong>: なし

**コマンド・オプション**:

<dl>
<dt><code>--region <em>REGION</em></code></dt>
<dd>ターゲットにする地域を入力します。 この値はオプションです。 地域を指定しない場合、出力に含まれるリストからそれを選択できます。

選択可能な地域のリストを参照するには、[地域とゾーン](cs_regions.html)を確認するか、`ibmcloud ks regions` [コマンド](#cs_regions)を使用します。</dd></dl>

**例**:

```
ibmcloud ks region-set eu-central
```
{: pre}

```
ibmcloud ks region-set
```
{: pre}

**出力**:
```
Choose a region:
1. ap-north
2. ap-south
3. eu-central
4. uk-south
5. us-east
6. us-south
Enter a number> 3
OK
```
{: screen}



### ibmcloud ks regions
{: #cs_regions}

選択可能な地域をリストします。 `Region Name` は {{site.data.keyword.containerlong_notm}} 名、`Region Alias` はその地域の一般的な {{site.data.keyword.Bluemix_notm}} 名です。

<strong>最小限必要な許可</strong>: なし

**例**:

```
ibmcloud ks regions
```
{: pre}

**出力**:
```
Region Name   Region Alias
ap-north      jp-tok
ap-south      au-syd
eu-central    eu-de
uk-south      eu-gb
us-east       us-east
us-south      us-south
```
{: screen}

### ibmcloud ks zones [--region-only][--json] [-s]
{: #cs_datacenters}

クラスターを作成するために使用できるゾーンのリストを表示します。 使用できるゾーンは、ログインしている地域によって異なります。 地域を切り替えるには、`ibmcloud ks region-set` を実行します。

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--region-only</code></dt>
   <dd>ログインしている地域内の複数ゾーンのみリストします。 この値はオプションです。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks zones
  ```
  {: pre}

<br />


## ワーカー・ノード・コマンド
{: worker_node_commands}


### 非推奨: ibmcloud ks worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt][-s]
{: #cs_worker_add}

ワーカー・プールに含まれていないスタンドアロン・ワーカー・ノードを、標準クラスターに追加します。
{: deprecated}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>クラスターの名前または ID。 この値は必須です。</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>ワーカー・ノードをクラスターに追加する YAML ファイルのパス。 このコマンドに用意されているオプションを使用して追加のワーカー・ノードを定義する代わりに、YAML ファイルを使用することができます。 この値はオプションです。

<p class="note">YAML ファイル内のパラメーターと同じオプションをコマンドで指定した場合は、コマンドの値が YAML 内の値よりも優先されます。 例えば、YAML ファイル内でマシン・タイプを定義し、コマンドで --machine-type オプションを使用した場合は、コマンド・オプションに入力した値が YAML ファイル内の値をオーバーライドします。</p>

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_ID&gt;</em>
zone: <em>&lt;zone&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
diskEncryption: <em>false</em></code></pre>

<table>
<caption>YAML ファイルの構成要素について</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td><code><em>&lt;cluster_name_or_ID&gt;</em></code> を、ワーカー・ノードの追加先のクラスターの名前または ID に置き換えます。</td>
</tr>
<tr>
<td><code><em>zone</em></code></td>
<td><code><em>&lt;zone&gt;</em></code> を、ワーカー・ノードをデプロイするゾーンに置き換えます。 使用可能なゾーンは、ログインしている地域によって異なります。 使用可能なゾーンをリストするには、<code>ibmcloud ks zones</code> を実行します。</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td><code><em>&lt;machine_type&gt;</em></code> を、ワーカー・ノードをデプロイするマシンのタイプに置き換えます。 ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてデプロイすることも、ベア・メタル上に物理マシンとしてデプロイすることもできます。 使用可能な物理マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 詳しくは、`ibmcloud ks machine-types` [コマンド](cs_cli_reference.html#cs_machine_types)を参照してください。</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td><code><em>&lt;private_VLAN&gt;</em></code> を、ワーカー・ノードに使用するプライベート VLAN の ID に置き換えます。 使用可能な VLAN をリストするには、<code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> を実行して、<code>bcr</code> で始まる VLAN ルーター (バックエンド・ルーター) を探します。</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td><code>&lt;public_VLAN&gt;</code> を、ワーカー・ノードに使用するパブリック VLAN の ID に置き換えます。 使用可能な VLAN をリストするには、<code>ibmcloud ks vlans &lt;zone&gt;</code> を実行して、<code>fcr</code> で始まる VLAN ルーター (フロントエンド・ルーター) を探します。 <br><strong>注</strong>: ワーカー・ノードにプライベート VLAN だけをセットアップする場合は、代わりのネットワーク接続ソリューションを構成する必要があります。 詳しくは、[プライベート専用クラスター・ネットワーキングの計画](cs_network_cluster.html#private_vlan)を参照してください。</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>仮想マシン・タイプの場合: ワーカー・ノードのハードウェア分離のレベル。 使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。 デフォルトは shared です。</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td><code><em>&lt;number_workers&gt;</em></code> を、デプロイするワーカー・ノードの数に置き換えます。</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>ワーカー・ノードには、デフォルトでディスク暗号化の機能があります。[詳しくはこちらを参照してください](cs_secure.html#encrypted_disk)。 暗号化を無効にするには、このオプションを組み込んで値を <code>false</code> に設定します。</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>ワーカー・ノードのハードウェア分離のレベル。 使用可能な物理リソースを自分専用にする場合には dedicated を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には shared を使用してください。 デフォルトは shared です。 この値はオプションです。</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>マシン・タイプを選択します。 ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてデプロイすることも、ベア・メタル上に物理マシンとしてデプロイすることもできます。 使用可能な物理マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 詳しくは、`ibmcloud ks machine-types` [コマンド](cs_cli_reference.html#cs_machine_types)についての説明を参照してください。 この値は、標準クラスターでは必須で、フリー・クラスターでは使用できません。</dd>

<dt><code>--workers <em>NUMBER</em></code></dt>
<dd>クラスター内に作成するワーカー・ノードの数を表す整数。 デフォルト値は 1 です。この値はオプションです。</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>クラスターの作成時に指定されたプライベート VLAN。 この値は必須です。 必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。</dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>クラスターの作成時に指定されたパブリック VLAN。 この値はオプションです。 ワーカー・ノードがプライベート VLAN だけに存在するようにするには、パブリック VLAN ID を指定しないでください。 必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。<p class="note">ワーカー・ノードにプライベート VLAN だけをセットアップする場合は、代わりのネットワーク接続ソリューションを構成する必要があります。 詳しくは、[プライベート専用クラスター・ネットワーキングの計画](cs_network_cluster.html#private_vlan)を参照してください。</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>ワーカー・ノードには、デフォルトでディスク暗号化の機能があります。[詳しくはこちらを参照してください](cs_secure.html#encrypted_disk)。 暗号化を無効にするには、このオプションを組み込みます。</dd>

<dt><code>-s</code></dt>
<dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

</dl>

**例**:

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  {{site.data.keyword.Bluemix_dedicated_notm}} の場合の例:

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud ks worker-get --cluster [CLUSTER_NAME_OR_ID] --worker WORKER_NODE_ID [--json][-s]
{: #cs_worker_get}

ワーカー・ノードの詳細を表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>ワーカー・ノードのクラスターの名前または ID。 この値はオプションです。</dd>

   <dt><code>--worker <em>WORKER_NODE_ID</em></code></dt>
   <dd>ワーカー・ノードの名前。 クラスター内のワーカー・ノードの ID を表示するには、<code>ibmcloud ks workers <em>CLUSTER</em></code> を実行します。 この値は必須です。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**コマンド例**:

  ```
  ibmcloud ks worker-get --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**出力例**:

  ```
  ID:           kube-dal10-123456789-w1
  State:        normal
  Status:       Ready
  Trust:        disabled
  Private VLAN: 223xxxx
  Public VLAN:  223xxxx
  Private IP:   10.xxx.xx.xxx
  Public IP:    169.xx.xxx.xxx
  Hardware:     shared
  Zone:         dal10
  Version:      1.8.11_1509
  ```
  {: screen}

### ibmcloud ks worker-reboot [-f][--hard] --cluster CLUSTER --worker WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reboot}

クラスター内のワーカー・ノードをリブートします。 リブート中は、ワーカー・ノードの状態は変わりません。 例えば、IBM Cloud インフラストラクチャー (SoftLayer) のワーカー・ノードの状況が `Powered Off` のときに、ワーカー・ノードをオンにする必要がある場合、リブートを使用できます。

**注意:** ワーカー・ノードをリブートすると、ワーカー・ノードのデータが破損する可能性があります。 このコマンドは、リブートがワーカー・ノードのリカバリーに役立つことが明らかな場合に、注意して使用してください。 そうでない場合は、代わりに[ワーカー・ノードを再ロード](#cs_worker_reload)してください。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

アプリのダウン時間やワーカー・ノードのデータ破損を防止するために、ワーカー・ノードをリブートする前に、必ず、他のワーカー・ノードにポッドのスケジュールを変更してください。

1. クラスター内のすべてのワーカー・ノードをリストして、リブートするワーカー・ノードの**名前**をメモします。
   ```
   kubectl get nodes
   ```
   {: pre}
   このコマンドで返される**名前**は、ワーカー・ノードに割り当てられたプライベート IP アドレスです。 `ibmcloud ks workers <cluster_name_or_ID>` コマンドを実行して同じ**プライベート IP** アドレスのワーカー・ノードを探せば、より詳しいワーカー・ノードの情報が得られます。
2. 閉鎖と呼ばれるプロセスで、ワーカー・ノードにスケジュール不能のマークを付けます。 閉鎖したワーカー・ノードは、それ以降のポッドのスケジューリングに使用できなくなります。 前の手順で取得したワーカー・ノードの**名前**を使用します。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. ワーカー・ノードでポッドのスケジューリングが無効になっていることを確認します。
   ```
   kubectl get nodes
   ```
   {: pre}
   状況に **SchedulingDisabled** と表示された場合、ワーカー・ノードのポッドのスケジューリングは無効になっています。
 4. ポッドをワーカー・ノードから強制的に削除し、クラスター内の残りのワーカー・ノードにスケジュールを変更します。
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    この処理には数分かかる場合があります。
 5. ワーカー・ノードをリブートします。 `ibmcloud ks workers <cluster_name_or_ID>` コマンドから返されるワーカー ID を使用します。
    ```
    ibmcloud ks worker-reboot --cluster <cluster_name_or_ID> --workers <worker_name_or_ID>
    ```
    {: pre}
 6. リブートを確実に完了させるために、約 5 分間待機してから、ワーカー・ノードをポッドのスケジューリングに使用できるようにします。 リブート中は、ワーカー・ノードの状態は変わりません。 ワーカー・ノードのリブートは、通常数秒で完了します。
 7. ワーカー・ノードをポッドのスケジューリングに使用できるようにします。 `kubectl get nodes` コマンドから返されるワーカー・ノードの**名前**を使用します。
    ```
    kubectl uncordon <worker_name>
    ```
    {: pre}

    </br>

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にワーカー・ノードを再始動するには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code>--hard</code></dt>
   <dd>ワーカー・ノードの電源を遮断することでワーカー・ノードのハード再始動を強制するには、このオプションを使用します。 このオプションは、ワーカー・ノードが応答しない場合、またはワーカー・ノードのコンテナー・ランタイムが応答しない場合に使用します。 この値はオプションです。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの名前または ID。 複数のワーカー・ノードをリストするには、スペースを使用します。 この値は必須です。</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>マスターのヘルス・チェックをスキップしてから、ワーカー・ノードを再ロードまたはリブートします。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks worker-reboot --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-reload [-f] --cluster CLUSTER --workers WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reload}

ワーカー・ノードの構成を再ロードします。再ロードは、ワーカー・ノードでパフォーマンスの低下などの問題が発生した場合や、ワーカー・ノードが正常でない状態に陥った場合に役立ちます。 再ロード中に、ワーカー・ノード・マシンが最新のイメージで更新されるので、[ワーカー・ノードの外部に保管](cs_storage_planning.html#persistent_storage_overview)していないデータは削除されることに注意してください。
{: shortdesc}

ワーカー・ノードを再ロードすると、パッチ・バージョンの更新がワーカー・ノードに適用されますが、メジャー更新やマイナー更新は適用されません。 あるパッチ・バージョンから次のバージョンまでの変更点を確認するには、[バージョンの変更ログ](cs_versions_changelog.html#changelog)の資料を参照してください。
{: tip}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

アプリのダウン時間やワーカー・ノードのデータ破損を防止するために、ワーカー・ノードを再ロードする前に、必ず、他のワーカー・ノードにポッドのスケジュールを変更してください。

1. クラスター内のすべてのワーカー・ノードをリストして、再ロードするワーカー・ノードの**名前**をメモします。
   ```
   kubectl get nodes
   ```
   このコマンドで返される**名前**は、ワーカー・ノードに割り当てられたプライベート IP アドレスです。 `ibmcloud ks workers <cluster_name_or_ID>` コマンドを実行して同じ**プライベート IP** アドレスのワーカー・ノードを探せば、より詳しいワーカー・ノードの情報が得られます。
2. 閉鎖と呼ばれるプロセスで、ワーカー・ノードにスケジュール不能のマークを付けます。 閉鎖したワーカー・ノードは、それ以降のポッドのスケジューリングに使用できなくなります。 前の手順で取得したワーカー・ノードの**名前**を使用します。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. ワーカー・ノードでポッドのスケジューリングが無効になっていることを確認します。
   ```
   kubectl get nodes
   ```
   {: pre}
   状況に **SchedulingDisabled** と表示された場合、ワーカー・ノードのポッドのスケジューリングは無効になっています。
 4. ポッドをワーカー・ノードから強制的に削除し、クラスター内の残りのワーカー・ノードにスケジュールを変更します。
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    この処理には数分かかる場合があります。
 5. ワーカー・ノードを再ロードします。 `ibmcloud ks workers <cluster_name_or_ID>` コマンドから返されるワーカー ID を使用します。
    ```
    ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --workers <worker_name_or_ID>
    ```
    {: pre}
 6. 再ロードが完了するまで待ちます。
 7. ワーカー・ノードをポッドのスケジューリングに使用できるようにします。 `kubectl get nodes` コマンドから返されるワーカー・ノードの**名前**を使用します。
    ```
    kubectl uncordon <worker_name>
    ```
</br>
<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にワーカー・ノードを再ロードするには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの名前または ID。 複数のワーカー・ノードをリストするには、スペースを使用します。 この値は必須です。</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>マスターのヘルス・チェックをスキップしてから、ワーカー・ノードを再ロードまたはリブートします。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks worker-reload --cluster my_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-rm [-f] --cluster CLUSTER --workers WORKER[,WORKER][-s]
{: #cs_worker_rm}

1 つ以上のワーカー・ノードをクラスターから削除します。 ワーカー・ノードを削除すると、クラスターがアンバランスになります。 `ibmcloud ks worker-pool-rebalance` [コマンド](#cs_rebalance)を実行して、ワーカー・プールのバランスを自動的に再調整できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

アプリのダウン時間やワーカー・ノードのデータ破損を防止するために、ワーカー・ノードを削除する前に、必ず、他のワーカー・ノードにポッドのスケジュールを変更してください。
{: tip}

1. クラスター内のすべてのワーカー・ノードをリストして、削除するワーカー・ノードの**名前**をメモします。
   ```
   kubectl get nodes
   ```
   このコマンドで返される**名前**は、ワーカー・ノードに割り当てられたプライベート IP アドレスです。 `ibmcloud ks workers <cluster_name_or_ID>` コマンドを実行して同じ**プライベート IP** アドレスのワーカー・ノードを探せば、より詳しいワーカー・ノードの情報が得られます。
2. 閉鎖と呼ばれるプロセスで、ワーカー・ノードにスケジュール不能のマークを付けます。 閉鎖したワーカー・ノードは、それ以降のポッドのスケジューリングに使用できなくなります。 前の手順で取得したワーカー・ノードの**名前**を使用します。
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. ワーカー・ノードでポッドのスケジューリングが無効になっていることを確認します。
   ```
   kubectl get nodes
   ```
   {: pre}
   状況に **SchedulingDisabled** と表示された場合、ワーカー・ノードのポッドのスケジューリングは無効になっています。
4. ポッドをワーカー・ノードから強制的に削除し、クラスター内の残りのワーカー・ノードにスケジュールを変更します。
   ```
   kubectl drain <worker_name>
   ```
   {: pre}
   この処理には数分かかる場合があります。
5. ワーカー・ノードを削除します。 `ibmcloud ks workers <cluster_name_or_ID>` コマンドから返されるワーカー ID を使用します。
   ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
   {: pre}

6. ワーカー・ノードが削除されたことを確認します。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
</br>
<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>クラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずに強制的にワーカー・ノードを削除するには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの名前または ID。 複数のワーカー・ノードをリストするには、スペースを使用します。 この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks worker-rm --cluster my_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-update [-f] --cluster CLUSTER --workers WORKER[,WORKER][--force-update] [-s]
{: #cs_worker_update}

ワーカー・ノードを更新して最新のセキュリティー更新とパッチをオペレーティング・システムに適用し、Kubernetes のバージョンを Kubernetes マスターのバージョンと一致するように更新します。 `ibmcloud ks cluster-update` [コマンド](cs_cli_reference.html#cs_cluster_update)を使用して、マスターの Kubernetes バージョンを更新できます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

`ibmcloud ks worker-update` を実行すると、アプリとサービスにダウン時間が発生する可能性があります。 更新中は、すべてのポッドが他のワーカー・ノードにスケジュール変更され、ワーカー・ノードが再イメージ化されるので、ポッドの外部に保管していないデータは削除されます。ダウン時間を回避するには、[選択したワーカー・ノードの更新中に、ワークロードを処理するために十分なワーカー・ノード数を確保するようにしてください。](cs_cluster_update.html#worker_node)
{: important}

更新の前に、デプロイメント用に YAML ファイルを変更する必要がある場合があります。 詳しくは、この[リリース・ノート](cs_versions.html)を確認してください。

<strong>コマンド・オプション</strong>:

   <dl>

   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>使用可能なワーカー・ノードをリストする対象のクラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>-f</code></dt>
   <dd>ユーザー・プロンプトを出さずにマスターを強制的に更新するには、このオプションを使用します。 この値はオプションです。</dd>

   <dt><code>--force-update</code></dt>
   <dd>変更が 2 つのマイナー・バージョンより大規模である場合でも、更新を試行します。 この値はオプションです。</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>1 つ以上のワーカー・ノードの ID。 複数のワーカー・ノードをリストするには、スペースを使用します。 この値は必須です。</dd>

   <dt><code>-s</code></dt>
   <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

   </dl>

**例**:

  ```
  ibmcloud ks worker-update --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}

### ibmcloud ks workers --cluster CLUSTER [--worker-pool POOL][--show-pools] [--show-deleted][--json] [-s]
{: #cs_workers}

ワーカー・ノードのリストと、それぞれのクラスター内での状況を表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>使用可能なワーカー・ノードのクラスターの名前または ID。 この値は必須です。</dd>

   <dt><code>--worker-pool <em>POOL</em></code></dt>
   <dd>ワーカー・プールに属するワーカー・ノードのみを表示します。 使用可能なワーカー・プールをリストするには、`ibmcloud ks worker-pools --cluster <cluster_name_or_ID>` を実行します。 この値はオプションです。</dd>

   <dt><code>--show-pools</code></dt>
   <dd>各ワーカー・ノードが属するワーカー・プールをリストします。 この値はオプションです。</dd>

   <dt><code>--show-deleted</code></dt>
   <dd>クラスターから削除されたワーカー・ノードを、削除理由も含めて表示します。 この値はオプションです。</dd>

   <dt><code>--json</code></dt>
   <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
  <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
   </dl>

**例**:

  ```
  ibmcloud ks workers --cluster my_cluster
  ```
  {: pre}

<br />


## ワーカー・プール・コマンド
{: #worker-pool}

### ibmcloud ks worker-pool-create --name POOL_NAME --cluster CLUSTER --machine-type MACHINE_TYPE --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION [--labels LABELS][--disable-disk-encrypt] [-s][--json]
{: #cs_worker_pool_create}

クラスター内にワーカー・プールを作成できます。 デフォルトでは、ワーカー・プールの追加時にゾーンは割り当てられません。 各ゾーンに必要なワーカー数と、ワーカーのマシン・タイプを指定します。 デフォルトの Kubernetes バージョンがワーカー・プールに付与されます。 ワーカーの作成を終了するには、プールに[1 つまたは複数のゾーンを追加](#cs_zone_add)します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:
<dl>

  <dt><code>--name <em>POOL_NAME</em></code></dt>
    <dd>ワーカー・プールに指定する名前。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>マシン・タイプを選択します。 ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてデプロイすることも、ベア・メタル上に物理マシンとしてデプロイすることもできます。 使用可能な物理マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 詳しくは、`ibmcloud ks machine-types` [コマンド](cs_cli_reference.html#cs_machine_types)についての説明を参照してください。 この値は、標準クラスターでは必須で、フリー・クラスターでは使用できません。</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>各ゾーンに作成するワーカーの数。 この値は必須です。1 以上の値にする必要があります。</dd>

  <dt><code>--hardware <em>ISOLATION</em></code></dt>
    <dd>ワーカー・ノードのハードウェア分離のレベル。 使用可能な物理リソースを自分専用にする場合には `dedicated` を使用し、他の IBM の顧客と物理リソースを共有することを許可する場合には `shared` を使用してください。 デフォルトは `shared` です。 ベアメタル・マシン・タイプの場合、`dedicated` を指定します。 この値は必須です。</dd>

  <dt><code>--labels <em>LABELS</em></code></dt>
    <dd>プール内のワーカーに割り当てるラベル。 例: `<key1>=<val1>`,`<key2>=<val2>`</dd>

  <dt><code>--disable-disk-encrpyt</code></dt>
    <dd>ディスクが暗号化されないことを指定します。 デフォルト値は <code>false</code> です。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**コマンド例**:

  ```
  ibmcloud ks worker-pool-create --name my_pool --cluster my_cluster --machine-type b2c.4x16 --size-per-zone 6
  ```
  {: pre}

### ibmcloud ks worker-pool-get --worker-pool WORKER_POOL --cluster CLUSTER [-s][--json]
{: #cs_worker_pool_get}

ワーカー・プールの詳細を表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>詳細を表示するワーカー・ノード・プールの名前。 使用可能なワーカー・プールをリストするには、`ibmcloud ks worker-pools --cluster <cluster_name_or_ID>` を実行します。 この値は必須です。</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>ワーカー・プールが存在するクラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**コマンド例**:

  ```
  ibmcloud ks worker-pool-get --worker-pool pool1 --cluster my_cluster
  ```
  {: pre}

**出力例**:

  ```
  Name:               pool   
  ID:                 a1a11b2222222bb3c33c3d4d44d555e5-f6f777g   
  State:              active   
  Hardware:           shared   
  Zones:              dal10,dal12   
  Workers per zone:   3   
  Machine type:       b2c.4x16.encrypted   
  Labels:             -   
  Version:            1.10.11_1512
  ```
  {: screen}

### ibmcloud ks worker-pool-rebalance --cluster CLUSTER --worker-pool WORKER_POOL [-s]
{: #cs_rebalance}

ワーカー・ノードの削除後に、ワーカー・プールのバランスを再調整できます。 このコマンドを実行すると、新しいワーカーが 1 つ以上ワーカー・プールに追加されます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code><em>--cluster CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。 この値は必須です。</dd>
  <dt><code><em>--worker-pool WORKER_POOL</em></code></dt>
    <dd>バランスを再調整するワーカー・プール。 この値は必須です。</dd>
  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks worker-pool-rebalance --cluster my_cluster --worker-pool my_pool
  ```
  {: pre}

### ibmcloud ks worker-pool-resize --worker-pool WORKER_POOL --cluster CLUSTER --size-per-zone WORKERS_PER_ZONE [-s]
{: #cs_worker_pool_resize}

ワーカー・プールをサイズ変更して、クラスターの各ゾーンにあるワーカー・ノードの数を増減します。 ワーカー・プールには 1 つ以上のワーカー・ノードがなければなりません。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>更新するワーカー・ノード・プールの名前。 この値は必須です。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>ワーカー・プールをサイズ変更するクラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>各ゾーンに必要なワーカーの数。 この値は必須です。1 以上の値にする必要があります。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>

</dl>

**コマンド例**:

  ```
  ibmcloud ks worker-pool-resize --cluster my_cluster --worker-pool my_pool --size-per-zone 3
  ```
  {: pre}

### ibmcloud ks worker-pool-rm --worker-pool WORKER_POOL --cluster CLUSTER [-s]
{: #cs_worker_pool_rm}

クラスターからワーカー・プールを削除します。 プール内のすべてのワーカー・ノードが削除されます。 削除を行うと、ポッドがスケジュール変更されます。 ダウン時間を避けるため、ワークロードを実行するために十分なワーカーがあることを確認してください。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>削除するワーカー・ノード・プールの名前。 この値は必須です。</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>ワーカー・プールを削除するクラスターの名前または ID。 この値は必須です。</dd>
  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**コマンド例**:

  ```
  ibmcloud ks worker-pool-rm --cluster my_cluster --worker-pool pool1
  ```
  {: pre}

### ibmcloud ks worker-pools --cluster CLUSTER [--json][-s]
{: #cs_worker_pools}

クラスター内にあるワーカー・プールを表示します。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**ビューアー**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
    <dd>ワーカー・プールをリストするクラスターの名前または ID。 この値は必須です。</dd>
  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>
  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**コマンド例**:

  ```
  ibmcloud ks worker-pools --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks zone-add --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][--private-only] [--json][-s]
{: #cs_zone_add}

**複数ゾーン・クラスターのみ**: クラスターまたはワーカー・プールを作成した後、ゾーンを追加できます。 ゾーンを追加すると、ワーカー・プールに対して指定した「ゾーンあたりのワーカー数」を満たすように新しいゾーンにワーカー・ノードが追加されます。

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>追加するゾーン。 クラスターの地域内の[複数ゾーン対応ゾーン](cs_regions.html#zones)でなければなりません。 この値は必須です。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>ゾーンを追加するワーカー・プールのコンマ区切りリスト。 少なくとも 1 つのワーカー・プールが必要です。</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd><p>プライベート VLAN の ID。 この値は条件付きです。</p>
    <p>ゾーンにプライベート VLAN がある場合、この値は、クラスターのワーカー・ノードが 1 つ以上存在するプライベート VLAN ID と一致していなければなりません。 使用可能な VLAN を確認するには、<code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code> を実行します。 指定した VLAN に新しいワーカー・ノードが追加されますが、既存のワーカー・ノードの VLAN は変更されません。</p>
    <p>このゾーン内にプライベート VLAN もパブリック VLAN もない場合は、このオプションを指定しないでください。 新規ゾーンをワーカー・プールに初めて追加するときに、プライベート VLAN とパブリック VLAN が自動的に作成されます。</p>
    <p>1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](cs_users.html#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)を使用します。 {{site.data.keyword.BluDirectLink}} を使用している場合は、代わりに[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) を使用する必要があります。 VRF を有効にするには、IBM Cloud インフラストラクチャー (SoftLayer) のアカウント担当者に連絡してください。</p></dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd><p>パブリック VLAN の ID。 クラスターの作成後にノード上のワークロードをパブリックに公開する場合は、この値が必要です。 この値は、このゾーンでクラスターのワーカー・ノードが 1 つ以上存在するパブリック VLAN ID と一致していなければなりません。 使用可能な VLAN を確認するには、<code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code> を実行します。 指定した VLAN に新しいワーカー・ノードが追加されますが、既存のワーカー・ノードの VLAN は変更されません。</p>
    <p>このゾーン内にプライベート VLAN もパブリック VLAN もない場合は、このオプションを指定しないでください。 新規ゾーンをワーカー・プールに初めて追加するときに、プライベート VLAN とパブリック VLAN が自動的に作成されます。</p>
    <p>1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](cs_users.html#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)を使用します。 {{site.data.keyword.BluDirectLink}} を使用している場合は、代わりに[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) を使用する必要があります。 VRF を有効にするには、IBM Cloud インフラストラクチャー (SoftLayer) のアカウント担当者に連絡してください。</p></dd>

  <dt><code>--private-only </code></dt>
    <dd>このオプションは、パブリック VLAN が作成されるのを防止するために使用します。 `--private-vlan` フラグを指定する場合にしか必要でないため、`--public-vlan` フラグは含めないでください。<p class="note">プライベート専用クラスターが必要な場合は、ネットワーク接続用にゲートウェイ・アプライアンスを構成する必要があります。 詳しくは、[プライベート・クラスター](cs_clusters_planning.html#private_clusters)を参照してください。</p></dd>

  <dt><code>--json</code></dt>
    <dd>コマンド出力を JSON フォーマットで出力します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks zone-add --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

  ### ibmcloud ks zone-network-set --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][-f] [-s]
  {: #cs_zone_network_set}

  **複数ゾーン・クラスターのみ**: これまで使用していたものとは別のパブリック VLAN またはプライベート VLAN をゾーンで使用するように、ワーカー・プールのネットワーク・メタデータを設定します。 プール内に既に作成済みのワーカー・ノードは、これまでと同じパブリック VLAN またはプライベート VLAN を使用し続けますが、プール内の新しいワーカー・ノードは新しいネットワーク・データを使用します。

  <strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

  必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。
  <ol><li>クラスター内で使用可能な VLAN を確認します。 <pre class="pre"><code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt; --showResources</code></pre><p>出力例:</p>
  <pre class="screen"><code>Subnet VLANs
VLAN ID   Subnet CIDR         Public   User-managed
229xxxx   169.xx.xxx.xxx/29   true     false
229xxxx   10.xxx.xx.x/29      false    false</code></pre></li>
  <li>使用するパブリック VLAN ID とプライベート VLAN ID に互換性があることを確認します。 互換性を持つようにするには、<strong>Router</strong> に同じポッド ID がある必要があります。<pre class="pre"><code>ibmcloud ks vlans --zone &lt;zone&gt;</code></pre><p>出力例:</p>
  <pre class="screen"><code>ID        Name   Number   Type      Router         Supports Virtual Workers
229xxxx          1234     private   bcr01a.dal12   true
229xxxx          5678     public    fcr01a.dal12   true</code></pre><p><strong>Router</strong> のポッド ID が、`01a` と `01a` であり、一致していることに注意してください。 ポッド ID の一方が `01a` で、もう一方が `02a` である場合、ワーカー・プールにこれらのパブリック VLAN ID とプライベート VLAN ID を設定することはできません。</p></li>
  <li>使用可能な VLAN がない場合は、<a href="/docs/infrastructure/vlans/order-vlan.html#ordering-premium-vlans">新規 VLAN を注文</a>できます。</li></ol>

  <strong>コマンド・オプション</strong>:

  <dl>
    <dt><code>--zone <em>ZONE</em></code></dt>
      <dd>追加するゾーン。 クラスターの地域内の[複数ゾーン対応ゾーン](cs_regions.html#zones)でなければなりません。 この値は必須です。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>ゾーンを追加するワーカー・プールのコンマ区切りリスト。 少なくとも 1 つのワーカー・プールが必要です。</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>プライベート VLAN の ID。 この値は、使用するプライベート VLAN が他のワーカー・ノードで使用していたものと同じか異なるかに関係なく必須です。 指定した VLAN に新しいワーカー・ノードが追加されますが、既存のワーカー・ノードの VLAN は変更されません。<p class="note">プライベート VLAN とパブリック VLAN は互換性がある必要があり、これは、**Router** ID 接頭部で判別できます。</p></dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>パブリック VLAN の ID。 この値は、ゾーンのパブリック VLAN を変更する場合にのみ、必須です。 パブリック VLAN を変更するには、常に互換性のあるプライベート VLAN を指定する必要があります。 指定した VLAN に新しいワーカー・ノードが追加されますが、既存のワーカー・ノードの VLAN は変更されません。<p class="note">プライベート VLAN とパブリック VLAN は互換性がある必要があり、これは、**Router** ID 接頭部で判別できます。</p></dd>

  <dt><code>-f</code></dt>
    <dd>ユーザー・プロンプトを表示せず、強制的にコマンドを実行します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
  </dl>

  **例**:

  ```
  ibmcloud ks zone-network-set --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

### ibmcloud ks zone-rm --zone ZONE --cluster CLUSTER [-f][-s]
{: #cs_zone_rm}

**複数ゾーン・クラスターのみ**: クラスター内のすべてのワーカー・プールからゾーンを削除します。 ワーカー・プールからそのゾーンのワーカー・ノードがすべて削除されます。

アプリのダウン時間やワーカー・ノードのデータ破損を防止するために、必ず、ゾーンを削除する前に、クラスター内の他のゾーンに、ポッドがスケジュールを変更できるだけの十分な数のワーカー・ノードが存在することを確認してください。
{: tip}

<strong>最小限必要な許可</strong>: {{site.data.keyword.containerlong_notm}} 内のクラスターに対する**オペレーター**のプラットフォーム役割

<strong>コマンド・オプション</strong>:

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>追加するゾーン。 クラスターの地域内の[複数ゾーン対応ゾーン](cs_regions.html#zones)でなければなりません。 この値は必須です。</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>クラスターの名前または ID。 この値は必須です。</dd>

  <dt><code>-f</code></dt>
    <dd>ユーザー・プロンプトを表示せず、強制的に更新します。 この値はオプションです。</dd>

  <dt><code>-s</code></dt>
    <dd>その日のメッセージを表示せず、リマインダーも更新しません。 この値はオプションです。</dd>
</dl>

**例**:

  ```
  ibmcloud ks zone-rm --zone dal10 --cluster my_cluster
  ```
  {: pre}
