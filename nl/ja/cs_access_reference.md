---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="blank"}
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
{:preview: .preview}

# ユーザー・アクセス許可
{: #access_reference}

[クラスター許可を割り当てる](/docs/containers?topic=containers-users)とき、ユーザーにどの役割を割り当てる必要があるか判断が難しい場合があります。 以下のセクションの表を使用して、{{site.data.keyword.containerlong}} で一般的な作業を実行するために最低限必要な許可レベルを判別してください。
{: shortdesc}

## {{site.data.keyword.cloud_notm}} IAM プラットフォーム役割
{: #iam_platform}

{{site.data.keyword.containerlong_notm}} は、{{site.data.keyword.cloud_notm}} の IAM (ID およびアクセス管理) 役割を使用するように構成されています。 {{site.data.keyword.cloud_notm}} IAM プラットフォーム役割によって、クラスター、ワーカー・ノード、および Ingress アプリケーション・ロード・バランサー (ALB) などの {{site.data.keyword.cloud_notm}} リソースでユーザーが実行できるアクションが決まります。 また、{{site.data.keyword.cloud_notm}} IAM プラットフォーム役割により、ユーザーの基本的なインフラストラクチャー許可も自動的に設定されます。 プラットフォーム役割を設定するには、[{{site.data.keyword.cloud_notm}} IAM プラットフォーム許可の割り当て](/docs/containers?topic=containers-users#platform)を参照してください。
{: shortdesc}

<p class="tip">{{site.data.keyword.cloud_notm}} IAM プラットフォーム役割は、サービス役割と同時に割り当てないでください。 プラットフォーム役割とサービス役割は別々に割り当てる必要があります。</p>

以下の各セクションの表に、各 {{site.data.keyword.cloud_notm}} IAM プラットフォーム役割が付与するクラスター管理許可、ロギング許可、および Ingress 許可が示されています。 表は CLI コマンド名のアルファベット順に編成されています。

* [許可を必要としないアクション](#none-actions)
* [ビューアーのアクション](#view-actions)
* [エディターのアクション](#editor-actions)
* [オペレーターのアクション](#operator-actions)
* [管理者のアクション](#admin-actions)

### 許可を必要としないアクション
{: #none-actions}

ご使用のアカウントのうち、以下の表のアクションに関して CLI コマンドを実行するか API 呼び出しをするユーザーには、そのユーザーに許可が割り当てられていなくても結果が表示されます。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} で許可を必要としない CLI コマンドおよび API 呼び出しの概要</caption>
<thead>
<th id="none-actions-action">アクション</th>
<th id="none-actions-cli">CLI コマンド</th>
<th id="none-actions-api">API 呼び出し</th>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.containerlong_notm}} の管理対象アドオンのサポートされているバージョンのリストを表示します。</td>
<td><code>[ibmcloud ks addon-versions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_addon_versions)</code></td>
<td><code>[GET /v1/addon](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetAddons)</code></td>
</tr>
<tr>
<td>{{site.data.keyword.containerlong_notm}} の API エンドポイントをターゲットに設定するか表示します。</td>
<td><code>[ibmcloud ks api](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cli_api)</code></td>
<td>-</td>
</tr>
<tr>
<td>サポートされるコマンドとパラメーターのリストを表示します。</td>
<td><code>[ibmcloud ks help](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_help)</code></td>
<td>-</td>
</tr>
<tr>
<td>{{site.data.keyword.containerlong_notm}} プラグインを初期化するか、Kubernetes クラスターを作成またはアクセスする地域を指定します。</td>
<td><code>[ibmcloud ks init](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_init)</code></td>
<td>-</td>
</tr>
<tr>
<td>非推奨: {{site.data.keyword.containerlong_notm}} でサポートされている Kubernetes のバージョンのリストを表示します。</td>
<td><code>[ibmcloud ks kube-versions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_kube_versions)</code></td>
<td><code>[GET /v1/kube-versions](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetKubeVersions)</code></td>
</tr>
<tr>
<td>ワーカー・ノードのために使用できるフレーバーのリストを表示します。</td>
<td><code>[ibmcloud ks flavors](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_machine_types) (machine-types)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/machine-types](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetDatacenterMachineTypes)</code></td>
</tr>
<tr>
<td>IBMid ユーザーに対する現在のメッセージを表示します。</td>
<td><code>[ibmcloud ks messages](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_messages)</code></td>
<td><code>[GET /v1/messages](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetMessages)</code></td>
</tr>
<tr>
<td>非推奨: 現在自分が属している {{site.data.keyword.containerlong_notm}} 地域を見つけます。</td>
<td><code>[ibmcloud ks region](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_region)</code></td>
<td>-</td>
</tr>
<tr>
<td>非推奨: {{site.data.keyword.containerlong_notm}} の地域を設定します。</td>
<td><code>[ibmcloud ks region-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_region-set)</code></td>
<td>-</td>
</tr>
<tr>
<td>非推奨: 選択可能な地域をリストします。</td>
<td><code>[ibmcloud ks regions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_regions)</code></td>
<td><code>[GET /v1/regions](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetRegions)</code></td>
</tr>
<tr>
<td>{{site.data.keyword.containerlong_notm}} でサポートされているロケーションのリストを表示します。</td>
<td><code>[ibmcloud ks supported-locations](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_supported-locations)</code></td>
<td><code>[GET /v1/locations](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/ListLocations)</code></td>
</tr>
<tr>
<td>{{site.data.keyword.containerlong_notm}} でサポートされているバージョンのリストを表示します。</td>
<td><code>[ibmcloud ks versions](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_versions_command)</code></td>
<td>-</td>
</tr>
<tr>
<td>クラスターを作成するために使用できるゾーンのリストを表示します。</td>
<td><code>[   ibmcloud ks zones
   ](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_datacenters)</code></td>
<td><code>[GET /v1/zones](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetZones)</code></td>
</tr>
</tbody>
</table>

### ビューアーのアクション
{: #view-actions}

**ビューアー**・プラットフォーム役割には、[許可を必要としないアクション](#none-actions)、および以下の表に示された許可が含まれます。 **ビューアー**役割によって、監査員などのユーザーまたは請求処理の場合は、クラスターの詳細を表示できますが、インフラストラクチャーを変更することはできません。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} でビューアー・プラットフォーム役割を必要とする CLI コマンドおよび API 呼び出しの概要</caption>
<thead>
<th id="view-actions-mngt">アクション</th>
<th id="view-actions-cli">CLI コマンド</th>
<th id="view-actions-api">API 呼び出し</th>
</thead>
<tbody>
<tr>
<td>Ingress ALB の情報を表示します。</td>
<td><code>[ibmcloud ks alb-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_get)</code></td>
<td><code>[GET /albs/{albId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/GetClusterALB)</code></td>
</tr>
<tr>
<td>この地域でサポートされている ALB のタイプを表示します。</td>
<td><code>[ibmcloud ks alb-types](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_types)</code></td>
<td><code>[GET /albtypes](https://containers.cloud.ibm.com/global/swagger-global-api/#/util/GetAvailableALBTypes)</code></td>
</tr>
<tr>
<td>クラスター内のすべての Ingress ALB をリストします。</td>
<td><code>[ibmcloud ks albs](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_albs)</code></td>
<td><code>[GET /clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/GetClusterALBs)</code></td>
</tr>
<tr>
<td>リソース・グループおよび地域の {{site.data.keyword.cloud_notm}} IAM API キーの所有者の名前と E メール・アドレスを表示します。</td>
<td><code>[ibmcloud ks api-key-info](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_info)</code></td>
<td><code>[GET /v1/logging/{idOrName}/clusterkeyowner](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/GetClusterKeyOwner)</code></td>
</tr>
<tr>
<td>クラスターに接続して `kubectl` コマンドを実行するための Kubernetes 構成データと証明書をダウンロードします。</td>
<td><code>[ibmcloud ks cluster-config](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_config)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/config](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterConfig)</code></td>
</tr>
<tr>
<td>クラスターの情報を表示します。</td>
<td><code>[ibmcloud ks cluster-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetCluster)</code></td>
</tr>
<tr>
<td>クラスターにバインドされているすべての名前空間のすべてのサービスをリストします。</td>
<td><code>[ibmcloud ks cluster-services](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_services)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ListServicesForAllNamespaces)</code></td>
</tr>
<tr>
<td>すべてのクラスターをリストします。</td>
<td><code>[ibmcloud ks clusters](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_clusters)</code></td>
<td><code>[GET /v1/clusters](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusters)</code></td>
</tr>
<tr>
<td>別の IBM Cloud インフラストラクチャー・ポートフォリオにアクセスするための {{site.data.keyword.cloud_notm}} アカウントに対して設定されているインフラストラクチャー資格情報を取得します。</td>
<td><code>[ibmcloud ks credential-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credential_get)</code></td><td><code>[GET /v1/credentials](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/GetUserCredentials)</code></td>
</tr>
<tr>
<td>ターゲットになっている地域とリソース・グループの IBM Cloud インフラストラクチャー・ポートフォリオにアクセスできるようにする資格情報に、推奨または必須のインフラストラクチャー許可の欠落がないかどうかを確認します。</td>
<td><code>[ibmcloud ks infra-permissions-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#infra_permissions_get)</code></td>
<td><code>[GET /v1/infra-permissions](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/GetInfraPermissions)</code></td>
</tr>
<tr>
<td>Fluentd アドオンの自動更新の状況を表示します。</td>
<td><code>[ibmcloud ks logging-autoupdate-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_autoupdate_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>ターゲットになっている地域のデフォルトのロギング・エンドポイントを表示します。</td>
<td>-</td>
<td><code>[GET /v1/logging/{idOrName}/default](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/GetDefaultLoggingEndpoint)</code></td>
</tr>
<tr>
<td>クラスターまたはクラスター内の特定のログ・ソースのすべてのログ転送構成をリストします。</td>
<td><code>[ibmcloud ks logging-config-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/FetchLoggingConfigs) および [GET /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/FetchLoggingConfigsForSource)</code></td>
</tr>
<tr>
<td>ログ・フィルター構成の情報を表示します。</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/FetchFilterConfig)</code></td>
</tr>
<tr>
<td>クラスター内のすべてのロギング・フィルター構成をリストします。</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/FetchFilterConfigs)</code></td>
</tr>
<tr>
<td>特定の名前空間にバインドされているすべてのサービスをリストします。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/services/{namespace}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ListServicesInNamespace)</code></td>
</tr>
<tr>
<td>クラスターにバインドされているすべての IBM Cloud インフラストラクチャー・サブネットをリストします。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/subnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterSubnets)</code></td>
</tr>
<tr>
<td>クラスターにバインドされているすべてのユーザー管理サブネットをリストします。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterUserSubnet)</code></td>
</tr>
<tr>
<td>インフラストラクチャー・アカウントで使用可能なサブネットのリストを表示します。</td>
<td><code>[ibmcloud ks subnets](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_subnets)</code></td>
<td><code>[GET /v1/subnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/properties/ListSubnets)</code></td>
</tr>
<tr>
<td>インフラストラクチャー・アカウントの VLAN スパンニング状況を表示します。</td>
<td><code>[ibmcloud ks vlan-spanning-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get)</code></td>
<td><code>[GET /v1/subnets/vlan-spanning](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/GetVlanSpanning)</code></td>
</tr>
<tr>
<td>1 つのクラスターに対して設定された場合: ゾーン内のクラスター接続先 VLAN のリストを表示します。</br>このアカウントに属するすべてのクラスターに対して設定された場合: ゾーン内の使用可能なすべての VLAN のリストを表示します。</td>
<td><code>[ibmcloud ks vlans](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlans)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/vlans](https://containers.cloud.ibm.com/global/swagger-global-api/#/properties/GetDatacenterVLANs)</code></td>
</tr>
<tr>
<td>クラスターのすべての Web フックをリストします。</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterWebhooks)</code></td>
</tr>
<tr>
<td>ワーカー・ノードの情報を表示します。</td>
<td><code>[ibmcloud ks worker-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetWorkers)</code></td>
</tr>
<tr>
<td>ワーカー・プールの情報を表示します。</td>
<td><code>[ibmcloud ks worker-pool-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetWorkerPool)</code></td>
</tr>
<tr>
<td>クラスター内のすべてのワーカー・プールをリストします。</td>
<td><code>[ibmcloud ks worker-pools](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pools)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetWorkerPools)</code></td>
</tr>
<tr>
<td>クラスター内のすべてのワーカー・ノードをリストします。</td>
<td><code>[ibmcloud ks workers](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_workers)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterWorkers)</code></td>
</tr>
</tbody>
</table>

### エディターのアクション
{: #editor-actions}

**エディター**・プラットフォーム役割には、**ビューアー**により付与される許可、および以下が含まれます。 **エディター**役割によって、開発者などのユーザーは、サービスをバインドしたり、Ingress リソースを処理したり、アプリのログ転送をセットアップしたりできますが、インフラストラクチャーを変更することはできません。 **ヒント**: アプリ開発者にはこの役割を使用し、<a href="#cloud-foundry">Cloud Foundry</a> **Developer** 役割を割り当ててください。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} でエディター・プラットフォーム役割を必要とする CLI コマンドおよび API 呼び出しの概要</caption>
<thead>
<th id="editor-actions-mngt">アクション</th>
<th id="editor-actions-cli">CLI コマンド</th>
<th id="editor-actions-api">API 呼び出し</th>
</thead>
<tbody>
<tr>
<td>Ingress ALB アドオンの自動更新を無効にします。</td>
<td><code>[ibmcloud ks alb-autoupdate-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Ingress ALB アドオンの自動更新を有効にします。</td>
<td><code>[ibmcloud ks alb-autoupdate-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Ingress ALB アドオンの自動更新が有効になっているか検査します。</td>
<td><code>[ibmcloud ks alb-autoupdate-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_autoupdate_get)</code></td>
<td><code>[GET /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Ingress ALB を有効化または無効化します。</td>
<td><code>[ibmcloud ks alb-configure](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure)</code></td>
<td><code>[POST /albs](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/EnableALB) および [DELETE /albs/{albId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/)</code></td>
</tr>
<tr>
<td>Ingress ALB アドオン更新を、以前 ALB ポッドが実行されていたビルドにロールバックします。</td>
<td><code>[ibmcloud ks alb-rollback](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_rollback)</code></td>
<td><code>[PUT /clusters/{idOrName}/updaterollback](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/RollbackUpdate)</code></td>
</tr>
<tr>
<td>手動で Ingress ALB アドオンを更新することにより、一回限りの ALB ポッド更新を強制実行します。</td>
<td><code>[ibmcloud ks alb-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_update)</code></td>
<td><code>[PUT /clusters/{idOrName}/update](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/UpdateALBs)</code></td>
</tr>
<tr>
<td>API サーバーの監査 Web フックを作成します。</td>
<td><code>[ibmcloud ks apiserver-config-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_config_set)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/apiserverconfigs/UpdateAuditWebhook)</code></td>
</tr>
<tr>
<td>API サーバーの監査 Web フックを削除します。</td>
<td><code>[ibmcloud ks apiserver-config-unset](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_config_unset)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/global/swagger-global-api/#/apiserverconfigs/DeleteAuditWebhook)</code></td>
</tr>
<tr>
<td>サービスをクラスターにバインドします。 **注**: サービス・インスタンスがあるスペースの Cloud Foundry 開発者役割が必要です。</td>
<td><code>[ibmcloud ks cluster-service-bind](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_service_bind)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/BindServiceToNamespace)</code></td>
</tr>
<tr>
<td>クラスターからサービスをアンバインドします。 **注**: サービス・インスタンスがあるスペースの Cloud Foundry 開発者役割が必要です。</td>
<td><code>[ibmcloud ks cluster-service-unbind](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_service_unbind)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/services/{namespace}/{serviceInstanceId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UnbindServiceFromNamespace)</code></td>
</tr>
<tr>
<td><code>kube-audit</code> 以外のすべてのログ・ソースのログ転送構成を作成します。</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>ログ転送構成をリフレッシュします。</td>
<td><code>[ibmcloud ks logging-config-refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_refresh)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/refresh](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/RefreshLoggingConfig)</code></td>
</tr>
<tr>
<td><code>kube-audit</code> 以外のすべてのログ・ソースのログ転送構成を削除します。</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/DeleteLoggingConfig)</code></td>
</tr>
<tr>
<td>クラスターのすべてのログ転送構成を削除します。</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/DeleteLoggingConfigs)</code></td>
</tr>
<tr>
<td>ログ転送構成を更新します。</td>
<td><code>[ibmcloud ks logging-config-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/UpdateLoggingConfig)</code></td>
</tr>
<tr>
<td>ログ・フィルター操作構成を作成します。</td>
<td><code>[ibmcloud ks logging-filter-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/CreateFilterConfig)</code></td>
</tr>
<tr>
<td>ログ・フィルター操作構成を削除します。</td>
<td><code>[ibmcloud ks logging-filter-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_delete)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/DeleteFilterConfig)</code></td>
</tr>
<tr>
<td>Kubernetes クラスターのすべてのロギング・フィルター構成を削除します。</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/DeleteFilterConfigs)</code></td>
</tr>
<tr>
<td>ログ・フィルター操作構成を更新します。</td>
<td><code>[ibmcloud ks logging-filter-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_filter_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/filter/UpdateFilterConfig)</code></td>
</tr>
<tr>
<td>既存の NLB ホスト名に NLB IP アドレスを追加します。</td>
<td><code>[ibmcloud ks nlb-dns-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-add)</code></td>
<td><code>[PUT /clusters/{idOrName}/add](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/UpdateDNSWithIP)</code></td>
</tr>
<tr>
<td>NLB IP アドレスを登録する DNS ホスト名を作成します。</td>
<td><code>[ibmcloud ks nlb-dns-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-create)</code></td>
<td><code>[POST /clusters/{idOrName}/register](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/RegisterDNSWithIP)</code></td>
</tr>
<tr>
<td>クラスターに登録されている NLB ホスト名および IP アドレスをリストします。</td>
<td><code>[ibmcloud ks nlb-dnss](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-ls)</code></td>
<td><code>[GET /clusters/{idOrName}/list](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/ListNLBIPsForSubdomain)</code></td>
</tr>
<tr>
<td>ホスト名から NLB IP アドレスを削除します。</td>
<td><code>[ibmcloud ks nlb-dns-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/host/{nlbHost}/ip/{nlbIP}/remove](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-dns-beta/UnregisterDNSWithIP)</code></td>
</tr>
<tr>
<td>クラスター内の既存の NLB ホスト名に対するヘルス・チェック・モニターを構成し、オプションとして有効にします。</td>
<td><code>[ibmcloud ks nlb-dns-monitor-configure](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-configure)</code></td>
<td><code>[POST /health/clusters/{idOrName}/config](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/AddNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>既存のヘルス・チェック・モニターの設定を表示します。</td>
<td><code>[ibmcloud ks nlb-dns-monitor-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-get)</code></td>
<td><code>[GET /health/clusters/{idOrName}/host/{nlbHost}/config](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/GetNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>クラスター内のホスト名に対する既存のヘルス・チェック・モニターを無効にします。</td>
<td><code>[ibmcloud ks nlb-dns-monitor-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/health](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/UpdateNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>構成した既存のヘルス・チェック・モニターを有効にします。</td>
<td><code>[ibmcloud ks nlb-dns-monitor-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/health](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/UpdateNlbDNSHealthMonitor)</code></td>
</tr>
<tr>
<td>クラスター内の NLB ホスト名ごとのヘルス・チェック・モニターの設定をリストします。</td>
<td><code>[ibmcloud ks nlb-dns-monitor-ls](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-ls)</code></td>
<td><code>[GET /health/clusters/{idOrName}/list](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/ListNlbDNSHealthMonitors)</code></td>
</tr>
<tr>
<td>クラスター内の NLB ホスト名に登録されている各 IP アドレスのヘルス・チェック状況をリストします。</td>
<td><code>[ibmcloud ks nlb-dns-monitor-status](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_nlb-dns-monitor-status)</code></td>
<td><code>[GET /health/clusters/{idOrName}/status](https://containers.cloud.ibm.com/global/swagger-global-api/#/nlb-health-monitor-beta/ListNlbDNSHealthMonitorStatus)</code></td>
</tr>
<tr>
<td>クラスター内に Web フックを作成します。</td>
<td><code>[ibmcloud ks webhook-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_webhook_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterWebhooks)</code></td>
</tr>
</tbody>
</table>

### オペレーターのアクション
{: #operator-actions}

**オペレーター**・プラットフォーム役割には、**ビューアー**により付与される許可、および以下の表に示されている許可が含まれます。 **オペレーター**役割によって、サイト信頼性エンジニア、DevOps エンジニア、クラスター管理者などのユーザーは、ワーカー・ノードを追加したり、ワーカー・ノードの再ロードなどによりインフラストラクチャーをトラブルシューティングしたりできますが、クラスターを作成または削除したり、資格情報を変更したり、サービス・エンドポイントや管理対象アドオンなどのクラスター全体にわたる機能をセットアップしたりすることはできません。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} でオペレーター・プラットフォーム役割を必要とする CLI コマンドおよび API 呼び出しの概要</caption>
<thead>
<th id="operator-mgmt">アクション</th>
<th id="operator-cli">CLI コマンド</th>
<th id="operator-api">API 呼び出し</th>
</thead>
<tbody>
<tr>
<td>Kubernetes マスターをリフレッシュします。</td>
<td><code>[ibmcloud ks apiserver-refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh) (cluster-refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>クラスターの {{site.data.keyword.cloud_notm}} IAM サービス ID を作成し、{{site.data.keyword.registrylong_notm}} で**リーダー**・サービス・アクセス役割を割り当てるサービス ID のポリシーを作成してから、サービス ID の API キーを作成します。</td>
<td><code>[ibmcloud ks cluster-pull-secret-apply](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_pull_secret_apply)</code></td>
<td>-</td>
</tr>
<tr>
<td>クラスターにサブネットを追加します。</td>
<td><code>[ibmcloud ks cluster-subnet-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_add)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterSubnet)</code></td>
</tr>
<tr>
<td>サブネットを作成してクラスターに追加します。</td>
<td><code>[ibmcloud ks cluster-subnet-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateClusterSubnet)</code></td>
</tr>
<tr>
<td>クラスターからサブネットを切り離します。</td>
<td><code>[ibmcloud ks cluster-subnet-detach](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_subnet_detach)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/DetachClusterSubnet)</code></td>
</tr>
<tr>
<td>クラスターを更新します。</td>
<td><code>[ibmcloud ks cluster-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateCluster)</code></td>
</tr>
<tr>
<td>クラスターにユーザー管理のサブネットを追加します。</td>
<td><code>[ibmcloud ks cluster-user-subnet-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_user_subnet_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterUserSubnet)</code></td>
</tr>
<tr>
<td>クラスターからユーザー管理のサブネットを削除します。</td>
<td><code>[ibmcloud ks cluster-user-subnet-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_user_subnet_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveClusterUserSubnet)</code></td>
</tr>
<tr>
<td>ワーカー・ノードを追加します。</td>
<td><code>[ibmcloud ks worker-add (非推奨)](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddClusterWorkers)</code></td>
</tr>
<tr>
<td>ワーカー・プールを作成します。</td>
<td><code>[ibmcloud ks worker-pool-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateWorkerPool)</code></td>
</tr>
<tr>
<td>ワーカー・プールのバランスを再調整します。</td>
<td><code>[ibmcloud ks worker-pool-rebalance](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_rebalance)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>ワーカー・プールをサイズ変更します。</td>
<td><code>[ibmcloud ks worker-pool-resize](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_resize)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>ワーカー・プールを削除します。</td>
<td><code>[ibmcloud ks worker-pool-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveWorkerPool)</code></td>
</tr>
<tr>
<td>ワーカー・ノードをリブートします。</td>
<td><code>[ibmcloud ks worker-reboot](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reboot)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>ワーカー・ノードを再ロードします。</td>
<td><code>[ibmcloud ks worker-reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>ワーカー・ノードを削除します。</td>
<td><code>[ibmcloud ks worker-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveClusterWorker)</code></td>
</tr>
<tr>
<td>ワーカー・ノードを更新します。</td>
<td><code>[ibmcloud ks worker-update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>ワーカー・プールにゾーンを追加します。</td>
<td><code>[ibmcloud ks zone-add](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddWorkerPoolZone)</code></td>
</tr>
<tr>
<td>ワーカー・プール内の特定のゾーンのネットワーク構成を更新します。</td>
<td><code>[ibmcloud ks zone-network-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_network_set)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/AddWorkerPoolZoneNetwork)</code></td>
</tr>
<tr>
<td>ワーカー・プールからゾーンを削除します。</td>
<td><code>[ibmcloud ks zone-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveWorkerPoolZone)</code></td>
</tr>
</tbody>
</table>

### 管理者のアクション
{: #admin-actions}

**管理者**プラットフォーム役割には、**ビューアー**役割、**エディター**役割、および**オペレーター**役割により付与されるすべての許可、および以下が含まれます。 **管理者**役割によって、クラスター管理者またはアカウント管理者などのユーザーは、クラスターを作成または削除したり、サービス・エンドポイントや管理対象アドオンなどのクラスター全体にわたる機能をセットアップしたりできます。 ワーカー・ノード・マシン、VLAN、サブネットなどのインフラストラクチャー・リソースを注文するには、管理者ユーザーに**スーパーユーザー**・<a href="#infra">インフラストラクチャー役割</a>が必要です。または、地域の API キーが、該当する許可で設定されている必要があります。
{: shortdesc}

<table>
<caption>{{site.data.keyword.containerlong_notm}} で管理者プラットフォーム役割を必要とする CLI コマンドおよび API 呼び出しの概要</caption>
<thead>
<th id="admin-mgmt">アクション</th>
<th id="admin-cli">CLI コマンド</th>
<th id="admin-api">API 呼び出し</th>
</thead>
<tbody>
<tr>
<td>ベータ版: {{site.data.keyword.cloudcerts_long_notm}} インスタンスから ALB への証明書をデプロイまたは更新します。</td>
<td><code>[ibmcloud ks alb-cert-deploy](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_cert_deploy)</code></td>
<td><code>[POST /albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb/CreateALBSecret) または [PUT /albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb-beta/UpdateALBSecret)</code></td>
</tr>
<tr>
<td>ベータ版: クラスター内の ALB シークレットの詳細を表示します。</td>
<td><code>[ibmcloud ks alb-cert-get](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_cert_get)</code></td>
<td><code>[GET /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb-beta/ViewClusterALBSecrets)</code></td>
</tr>
<tr>
<td>ベータ版: クラスターから ALB シークレットを削除します。</td>
<td><code>[ibmcloud ks alb-cert-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_cert_rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/global/swagger-global-api/#/alb-beta/DeleteClusterALBSecrets)</code></td>
</tr>
<tr>
<td>クラスター内のすべての ALB シークレットをリストします。</td>
<td><code>[ibmcloud ks alb-certs](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_certs)</code></td>
<td>-</td>
</tr>
<tr>
<td>リンクされた IBM Cloud インフラストラクチャー・ポートフォリオにアクセスするための {{site.data.keyword.cloud_notm}} アカウントの API キーを設定します。</td>
<td><code>[ibmcloud ks api-key-reset](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_reset)</code></td>
<td><code>[POST /v1/keys](https://containers.cloud.ibm.com/global/swagger-global-api/#/accounts/ResetUserAPIKey)</code></td>
</tr>
<tr>
<td>クラスター内の、Istio や Knative などの管理対象アドオンを無効化します。</td>
<td><code>[ibmcloud ks cluster-addon-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_disable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>クラスター内の、Istio や Knative などの管理対象アドオンを有効化します。</td>
<td><code>[ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addon_enable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>クラスター内で有効化されている、Istio や Knative などの管理対象アドオンをリストします。</td>
<td><code>[ibmcloud ks cluster-addons](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_addons)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/GetClusterAddons)</code></td>
</tr>
<tr>
<td>フリー・クラスターまたは標準クラスターを作成します。 **注**: {{site.data.keyword.registrylong_notm}} の管理者プラットフォーム役割、およびスーパーユーザー・インフラストラクチャー役割も必要です。</td>
<td><code>[ibmcloud ks cluster-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_create)</code></td>
<td><code>[POST /v1/clusters](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateCluster)</code></td>
</tr>
<tr>
<td>クラスター・マスターのパブリック・サービス・エンドポイントなどの、クラスターの指定された機能を無効化します。</td>
<td><code>[ibmcloud ks cluster-feature-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_disable)</code></td>
<td>-</td>
</tr>
<tr>
<td>クラスター・マスターのプライベート・サービス・エンドポイントなどの、クラスターの指定された機能を有効化します。</td>
<td><code>[ibmcloud ks cluster-feature-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable)</code></td>
<td>-</td>
</tr>
<tr>
<td>クラスターを削除します。</td>
<td><code>[ibmcloud ks cluster-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/RemoveCluster)</code></td>
</tr>
<tr>
<td>別の IBM Cloud インフラストラクチャー・ポートフォリオにアクセスするための {{site.data.keyword.cloud_notm}} アカウントのインフラストラクチャー資格情報を設定します。</td>
<td><code>[ibmcloud ks credential-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_set)</code></td>
<td><code>[POST /v1/credentials](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/accounts/StoreUserCredentials)</code></td>
</tr>
<tr>
<td>別の IBM Cloud インフラストラクチャー・ポートフォリオにアクセスするための {{site.data.keyword.cloud_notm}} アカウントのインフラストラクチャー資格情報を削除します。</td>
<td><code>[ibmcloud ks credential-unset](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_unset)</code></td>
<td><code>[DELETE /v1/credentials](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/accounts/RemoveUserCredentials)</code></td>
</tr>
<tr>
<td>ベータ版: {{site.data.keyword.keymanagementservicefull}} を使用した Kubernetes シークレットを暗号化します。</td>
<td><code>[ibmcloud ks key-protect-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_messages)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/kms](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/CreateKMSConfig)</code></td>
</tr>
<tr>
<td>Fluentd クラスター・アドオンの自動更新を無効にします。</td>
<td><code>[ibmcloud ks logging-autoupdate-disable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_autoupdate_disable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Fluentd クラスター・アドオンの自動更新を有効にします。</td>
<td><code>[ibmcloud ks logging-autoupdate-enable](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_autoupdate_enable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>{{site.data.keyword.cos_full_notm}} バケット内の API サーバー・ログのスナップショットを収集します。</td>
<td><code>[ibmcloud ks logging-collect](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_collect)</code></td>
<td>[POST /v1/log-collector/{idOrName}/masterlogs](https://containers.cloud.ibm.com/global/swagger-global-api/#/log45collector/CreateMasterLogCollection)</td>
</tr>
<tr>
<td>API サーバー・ログのスナップショット要求の状況を表示します。</td>
<td><code>[ibmcloud ks logging-collect-status](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_log_collect_status)</code></td>
<td>[GET /v1/log-collector/{idOrName}/masterlogs](https://containers.cloud.ibm.com/global/swagger-global-api/#/log45collector/GetMasterLogCollectionStatus)</td>
</tr>
<tr>
<td><code>kube-audit</code> ログ・ソースのログ転送構成を作成します。</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td><code>kube-audit</code> ログ・ソースのログ転送構成を削除します。</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/global/swagger-global-api/#/logging/DeleteLoggingConfig)</code></td>
</tr>
</tbody>
</table>

<br />


## {{site.data.keyword.cloud_notm}} IAM サービス役割
{: #service}

{{site.data.keyword.cloud_notm}} IAM サービス・アクセス役割が割り当てられたユーザーには必ず、特定の名前空間での対応する Kubernetes 役割ベース・アクセス制御 (RBAC) 役割も自動的に割り当てられます。 サービス・アクセス役割について詳しくは、[{{site.data.keyword.cloud_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)を参照してください。 {{site.data.keyword.cloud_notm}} IAM プラットフォーム役割は、サービス役割と同時に割り当てないでください。 プラットフォーム役割とサービス役割は別々に割り当てる必要があります。
{: shortdesc}

RBAC を介して各サービス役割が付与する Kubernetes アクションについて詳しくは、 [RBAC 役割ごとの Kubernetes リソース許可](#rbac_ref)を参照してください。 RBAC 役割について詳しくは、[RBAC 許可の割り当て](/docs/containers?topic=containers-users#role-binding)および[クラスター役割の集約による既存の許可の拡張](/docs/containers?topic=containers-users#rbac_aggregate)を参照してください。
{: tip}

以下の表は、各サービス役割およびそれに対応する RBAC 役割によって付与される Kubernetes リソース許可を示しています。

<table>
<caption>サービス役割および対応する RBAC 役割別の Kubernetes リソース許可</caption>
<thead>
    <th id="service-role">サービス役割</th>
    <th id="rbac-role">対応する RBAC 役割、バインディング、およびスコープ</th>
    <th id="kube-perm">Kubernetes リソース許可</th>
</thead>
<tbody>
  <tr>
    <td id="service-role-reader" headers="service-role">リーダー役割</td>
    <td headers="service-role-reader rbac-role">有効範囲を 1 つの名前空間に設定する場合: <strong><code>ibm-view</code></strong> 役割バインディングによってその名前空間で適用される <strong><code>view</code></strong> クラスター役割</br><br>有効範囲をすべての名前空間に設定する場合: <strong><code>ibm-view</code></strong> 役割バインディングによってクラスターの各名前空間で適用される <strong><code>view</code></strong> クラスター役割</td>
    <td headers="service-role-reader kube-perm"><ul>
      <li>名前空間内にあるリソースに対する読み取りアクセス</li>
      <li>役割および役割バインディングまたは Kubernetes シークレットに対する読み取りアクセス権限はなし</li>
      <li>Kubernetes ダッシュボードにアクセスして名前空間内のリソースを表示する</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-writer" headers="service-role">ライター役割</td>
    <td headers="service-role-writer rbac-role">有効範囲を 1 つの名前空間に設定する場合: <strong><code>ibm-edit</code></strong> 役割バインディングによってその名前空間で適用される <strong><code>edit</code></strong> クラスター役割</br><br>有効範囲をすべての名前空間に設定する場合: <strong><code>ibm-edit</code></strong> 役割バインディングによってクラスターの各名前空間で適用される <strong><code>edit</code></strong> クラスター役割</td>
    <td headers="service-role-writer kube-perm"><ul><li>名前空間内にあるリソースに対する読み取り/書き込みアクセス</li>
    <li>役割および役割バインディングに対する読み取り/書き込みアクセス権限はなし</li>
    <li>Kubernetes ダッシュボードにアクセスして名前空間内のリソースを表示する</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-manager" headers="service-role">マネージャー役割</td>
    <td headers="service-role-manager rbac-role">有効範囲を 1 つの名前空間に設定する場合: <strong><code>ibm-operate</code></strong> 役割バインディングによってその名前空間で適用される <strong><code>admin</code></strong> クラスター役割</br><br>有効範囲をすべての名前空間に設定する場合: すべての名前空間に適用される <strong><code>ibm-admin</code></strong> クラスター役割バインディングによって適用される <strong><code>cluster-admin</code></strong> クラスター役割</td>
    <td headers="service-role-manager kube-perm">有効範囲を 1 つの名前空間に設定する場合:
      <ul><li>名前空間内のすべてのリソースに対する読み取り/書き込みアクセス、ただしリソース・クォータまたは名前空間自体への読み取り/書き込みアクセス権限はなし</li>
      <li>名前空間内で RBAC 役割および役割バインディングを作成する</li>
      <li>Kubernetes ダッシュボードにアクセスして名前空間内のすべてのリソースを表示する</li></ul>
    </br>有効範囲をすべての名前空間に設定する場合:
        <ul><li>すべての名前空間内にあるすべてのリソースに対する読み取り/書き込みアクセス</li>
        <li>名前空間内で RBAC 役割および役割バインディングを作成する、またはすべての名前空間内でクラスター役割およびクラスター役割バインディングを作成する</li>
        <li>Kubernetes ダッシュボードにアクセスする</li>
        <li>アプリをだれでも利用できるようにする Ingress リソースを作成する</li>
        <li><code>kubectl top pods</code>、<code>kubectl top nodes</code>、または <code>kubectl get nodes</code> コマンドを使用した場合などのクラスター・メトリックを確認する</li></ul>
    </td>
  </tr>
    <tr>
    <td>任意のサービス役割</td>
    <td>**OpenShift クラスターのみ**: OpenShift クラスターのすべてのユーザーに、`basic-users` および `self-provisioners` クラスター役割バインディングによって適用される `basic-users` および `self-provisioners` クラスター役割が付与されます。</td>
    <td><ul>
      <li>ユーザーがアクセスできるプロジェクトに関する基本情報を取得します。</li>
      <li>ユーザーがアクセスできるプロジェクトに許可リソースを作成します。</li>
      <li>詳しくは、[OpenShift の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_rbac.html) を参照してください。</li></ul></td>
  </tr>
</tbody>
</table>

<br />


## RBAC 役割ごとの Kubernetes リソース許可
{: #rbac_ref}

{{site.data.keyword.cloud_notm}} IAM サービス・アクセス役割が割り当てられたユーザーには必ず、対応する事前定義の Kubernetes 役割ベース・アクセス制御 (RBAC) 役割も自動的に割り当てられます。 独自のカスタム Kubernetes RBAC 役割を管理する場合は、[ユーザー、グループ、またはサービス・アカウントに対するカスタム RBAC 許可の作成](/docs/containers?topic=containers-users#rbac)を参照してください。
{: shortdesc}

名前空間内のリソースに対して特定の `kubectl` コマンドを実行する正しい許可があるかどうか不明な場合は、 [`kubectl auth can-i` コマンド ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em-) を試行してください。
{: tip}

以下の表は、各 RBAC 役割によって個々の Kubernetes リソースに付与される許可を示しています。 許可は、その役割を持つユーザーがリソースに対して実行できる verbs ("get"、"list"、"describe"、"create"、または "delete" など) として示されています。

<table>
 <caption>各事前定義 RBAC 役割によって付与される Kubernetes リソース許可</caption>
 <thead>
  <th>Kubernetes リソース</th>
  <th><code>view</code></th>
  <th><code>edit</code></th>
  <th><code>admin</code> および <code>cluster-admin</code></th>
 </thead>
<tbody>
<tr>
  <td><code>bindings</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>configmaps</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>cronjobs.batch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>daemonsets.apps </code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>daemonsets.extensions</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>deployments.apps</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>deployments.apps/rollback</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>deployments.apps/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>deployments.extensions</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>deployments.extensions/rollback</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>deployments.extensions/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>endpoints</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>events</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>horizontalpodautoscalers.autoscaling</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>ingresses.extensions</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>jobs.batch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>limitranges</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>localsubjectaccessreviews</code></td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code></td>
</tr><tr>
  <td><code>namespaces</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></br>**cluster-admin のみ:** <code>create</code>、<code>delete</code></td>
</tr><tr>
  <td><code>namespaces/status</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>networkpolicies</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>networkpolicies.extensions</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>persistentvolumeclaims</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>poddisruptionbudgets.policy</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>top</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods/attach</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods/exec</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods/log</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods/portforward</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods/proxy</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>pods/status</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicasets.apps</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicasets.apps/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicasets.extensions</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicasets.extensions/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers/status</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>replicationcontrollers.extensions/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>resourcequotas</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>resourcequotas/status</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
</tr><tr>
  <td><code>rolebindings</code></td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>roles</code></td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>シークレット</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>serviceaccounts</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code>、<code>impersonate</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code>、<code>impersonate</code></td>
</tr><tr>
  <td><code> サービス</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>services/proxy</code></td>
  <td>-</td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>statefulsets.apps</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr><tr>
  <td><code>statefulsets.apps/scale</code></td>
  <td><code>get</code>、<code>list</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
  <td><code>create</code>、<code>delete</code>、<code>deletecollection</code>、<code>get</code>、<code>list</code>、<code>patch</code>、<code>update</code>、<code>watch</code></td>
</tr>
</tbody>
</table>

<br />


## Cloud Foundry の役割
{: #cloud-foundry}

Cloud Foundry の役割は、このアカウントに属する組織およびスペースにアクセス権限を付与します。 {{site.data.keyword.cloud_notm}} の Cloud Foundry ベースのサービスのリストを表示するには、`ibmcloud service list` を実行します。 詳しくは、{{site.data.keyword.cloud_notm}} IAM 資料に記載されている、使用可能なすべての[組織およびスペース役割](/docs/iam?topic=iam-cfaccess)、または [Cloud Foundry アクセス権限を管理する](/docs/iam?topic=iam-mngcf)ためのステップを参照してください。
{: shortdesc}

次の表は、クラスター・アクション許可に必要な Cloud Foundry 役割を示しています。

<table>
  <caption>Cloud Foundry 役割別のクラスター管理許可</caption>
  <thead>
    <th>Cloud Foundry 役割</th>
    <th>クラスター管理許可</th>
  </thead>
  <tbody>
  <tr>
    <td>スペースの役割: 管理者</td>
    <td>{{site.data.keyword.cloud_notm}} スペースに対するユーザー・アクセスを管理する</td>
  </tr>
  <tr>
    <td>スペースの役割: 開発者</td>
    <td>
      <ul><li>{{site.data.keyword.cloud_notm}} サービス・インスタンスを作成する</li>
      <li>{{site.data.keyword.cloud_notm}} サービス・インスタンスをクラスターにバインドする</li>
      <li>クラスターのログ転送構成からのログをスペース・レベルで表示する</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## クラシック・インフラストラクチャーの役割
{: #infra}

**スーパーユーザー**・インフラストラクチャー・アクセス役割を持つユーザーが[地域とリソース・グループの API キーを設定する](/docs/containers?topic=containers-users#api_key)と、インフラストラクチャー・アクションを実行できます ([手動で別のアカウント資格情報を設定する](/docs/containers?topic=containers-users#credentials)場合もわずかにあります)。 その後、アカウント内の他のユーザーが実行できるインフラストラクチャー・アクションは、{{site.data.keyword.cloud_notm}} IAM プラットフォーム役割によって許可されます。 他のユーザーのクラシック・インフラストラクチャー許可を編集する必要はありません。API キーを設定するユーザーに**スーパーユーザー**を割り当てることができない場合にのみ、以下の表を使用して、ユーザーのクラシック・インフラストラクチャー許可をカスタマイズしてください。許可の割り当てについて詳しくは、[インフラストラクチャー許可のカスタマイズ](/docs/containers?topic=containers-users#infra_access)を参照してください。
{: shortdesc}



API キーまたは手動で設定された資格情報に、必要なインフラストラクチャー許可と推奨されるインフラストラクチャー許可があることを確認する必要がある場合は、`ibmcloud ks infra-permissions-get` [コマンド](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#infra_permissions_get)使用してください。
{: tip}

地域およびリソース・グループの資格情報に盛り込むことができる、クラスターの作成やその他の一般的なユース・ケースのためのクラシック・インフラストラクチャー許可を次の表に示します。説明には、{{site.data.keyword.cloud_notm}} IAM クラシック・インフラストラクチャー・コンソールまたは `ibmcloud sl` コマンドで許可を割り当てる方法が含まれています。詳しくは、[コンソール](/docs/containers?topic=containers-users#infra_console)または [CLI](/docs/containers?topic=containers-users#infra_cli) についての説明を参照してください。 
*   **クラスターの作成**: クラスターを作成するために必要なクラシック・インフラストラクチャーの許可。`ibmcloud ks infra-permissions-get` を実行すると、これらの許可が **「必須」**としてリストされます。
*   **その他の一般的なユース・ケース**: 他の一般的なシナリオで必要なクラシック・インフラストラクチャーの許可。クラスターを作成するための許可があっても、それだけではまだ、いくらかの制限が適用される可能性があります。例えば、ベアメタル・ワーカー・ノードまたはパブリック IP アドレスを持つクラスターを作成または処理できない場合があります。クラスターの作成後、ネットワーク・リソースやストレージ・リソースを追加するステップが失敗することもあります。`ibmcloud ks infra-permissions-get`を実行すると、これらの許可が **「推奨」**としてリストされます。

| 許可 | 説明 | IAM 割り当てポリシー・コンソール | CLI |
|:-----------------|:-----------------|:---------------|:----|
| IPMI リモート管理 | ワーカー・ノードを管理します。|「クラシック・インフラストラクチャー」>「許可」>「デバイス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission REMOTE_MANAGEMENT --enable true</code></pre> |
| サーバーの追加 | ワーカー・ノードを追加します。 パブリック IP アドレスを持つワーカー・ノードの場合は、**「パブリック・ネットワーク・ポートでのコンピュートの追加」**の許可も必要です。|「クラシック・インフラストラクチャー」>「許可」>「アカウント」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission SERVER_ADD --enable true</code></pre>  |
| サーバーのキャンセル | ワーカー・ノードを削除します。|「クラシック・インフラストラクチャー」>「許可」>「アカウント」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission SERVER_CANCEL --enable true</code></pre>  |
| OS の再ロードとカーネルのレスキュー | ワーカー・ノードを更新、リブート、および再ロードします。|「クラシック・インフラストラクチャー」>「許可」>「デバイス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission SERVER_RELOAD --enable true</code></pre>  |
| Virtual Server の詳細の表示 | クラスターに VM ワーカー・ノードがある場合は必須です。VM ワーカー・ノードの詳細をリストおよび取得します。|「クラシック・インフラストラクチャー」>「許可」>「デバイス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission VIRTUAL_GUEST_VIEW --enable true</code></pre>  |
| ハードウェアの詳細の表示 | クラスターにベアメタル・ワーカー・ノードがある場合は必須です。ベアメタル・ワーカー・ノードの詳細をリストおよび取得します。|「クラシック・インフラストラクチャー」>「許可」>「デバイス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission HARDWARE_VIEW --enable true</code></pre>  |
| サポート・ケースの追加 | クラスター作成自動化の一環として、クラスター・インフラストラクチャーをプロビジョンするためにサポート・ケースが開かれます。|「アカウント管理サービスへのアクセスの割り当て」>「サポート・センター」>「管理者」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission TICKET_ADD --enable true</code></pre>  |
| サポート・ケースの編集 | クラスター作成自動化の一環として、クラスター・インフラストラクチャーをプロビジョンするためにサポート・ケースが更新されます。|「アカウント管理サービスへのアクセスの割り当て」>「サポート・センター」>「管理者」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission TICKET_EDIT --enable true</code></pre>  |
| サポート・ケースの表示 | クラスター作成自動化の一環として、クラスター・インフラストラクチャーをプロビジョンするためにサポート・ケースが使用されます。|「アカウント管理サービスへのアクセスの割り当て」>「サポート・センター」>「管理者」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission TICKET_VIEW --enable true</code></pre>  |
{: class="simple-tab-table"}
{: caption="必須のクラシック・インフラストラクチャー許可" caption-side="top"}
{: #classic-permissions-required}
{: tab-title="Create clusters"}
{: tab-group="Classic infrastructure permissions"}

| 許可 | 説明 | IAM 割り当てポリシー・コンソール | CLI |
|:-----------------|:-----------------|:---------------|:----|
| すべての仮想にアクセス (Access All Virtual) | すべての VM ワーカー・ノードへのアクセスを指定します。この許可がないと、1 つのクラスターを作成するユーザーは、そのクラスターと別のクラスターの両方に対する IAM アクセス権限を持っていても、別のクラスターの VM ワーカー・ノードを表示できない場合があります。| 「クラシック・インフラストラクチャー」>「デバイス」>「すべての仮想サーバーの検査 (Check All virtual servers)」および「仮想サーバーへの自動アクセス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission ACCESS_ALL_GUEST --enable true</code></pre> |
| すべてのハードウェアへのアクセス | すべてのベアメタル・ワーカー・ノードへのアクセスを指定します。この許可がないと、1 つのクラスターを作成するユーザーは、そのクラスターと別のクラスターの両方に対する IAM アクセス権限を持っていても、別のクラスターのベアメタル・ワーカー・ノードを表示できない場合があります。| 「クラシック・インフラストラクチャー」>「デバイス」>「すべての仮想サーバーの検査 (Check All virtual servers)」および「仮想サーバーへの自動アクセス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission ACCESS_ALL_HARDWARE --enable true</code></pre> |
| パブリック・ネットワーク・ポートのコンピュートを追加 | ワーカー・ノードがパブリック・ネットワーク上でアクセス可能なポートを持つようにします。|「クラシック・インフラストラクチャー」>「許可」>「ネットワーク」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission PUBLIC_NETWORK_COMPUTE --enable true</code></pre> |
| DNS の管理 | アプリを公開するためにパブリック・ロード・バランサーまたは Ingress ネットワーキングをセットアップする。 |「クラシック・インフラストラクチャー」>「許可」>「サービス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission DNS_MANAGE --enable true</code></pre> |
| ホスト名/ドメインの編集 | アプリを公開するためにパブリック・ロード・バランサーまたは Ingress ネットワーキングをセットアップする。 |「クラシック・インフラストラクチャー」>「許可」>「デバイス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission HOSTNAME_EDIT --enable true</code></pre> |
| IP アドレスの追加 | クラスター・ロード・バランシングに使用するパブリック・サブネットまたはプライベート・サブネットに IP アドレスを追加します。|「クラシック・インフラストラクチャー」>「許可」>「ネットワーク」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission IP_ADD --enable true</code></pre> |
| ネットワーク・サブネット経路の管理 | クラスター・ロード・バランシングに使用するパブリックまたはプライベートの VLAN およびサブネットを管理します。|「クラシック・インフラストラクチャー」>「許可」>「ネットワーク」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission NETWORK_ROUTE_MANAGE --enable true</code></pre> |
| ポート・コントロールの管理 | アプリのロード・バランシングに使用するポートを管理します。|「クラシック・インフラストラクチャー」>「許可」>「デバイス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission PORT_CONTROL --enable true</code></pre> |
| 証明書 (SSL) の管理 | クラスター・ロード・バランシングに使用する証明書をセットアップします。|「クラシック・インフラストラクチャー」>「許可」>「サービス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission SECURITY_CERTIFICATE_MANAGE --enable true</code></pre>  |
| 証明書 (SSL) の表示 | クラスター・ロード・バランシングに使用する証明書をセットアップします。|「クラシック・インフラストラクチャー」>「許可」>「サービス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission SECURITY_CERTIFICATE_MANAGE --enable true</code></pre> |
| ストレージの追加/アップグレード (StorageLayer) |データを永続的に保管するためのボリュームとしてアプリに接続する {{site.data.keyword.cloud_notm}} ファイル・ストレージ・インスタンスまたはブロック・ストレージ・インスタンスを作成します。|「クラシック・インフラストラクチャー」>「許可」>「アカウント」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission ADD_SERVICE_STORAGE --enable true</code></pre>  |
| ストレージ管理 | データを永続的に保管するためのボリュームとしてアプリに接続された {{site.data.keyword.cloud_notm}} ファイル・ストレージ・インスタンスまたはブロック・ストレージ・インスタンスを管理します。 |「クラシック・インフラストラクチャー」>「許可」>「サービス」|<pre class="pre"><code>ibmcloud sl user permission-edit &lt;user_id&gt; --permission NAS_MANAGE --enable true</code></pre> |
{: class="simple-tab-table"}
{: caption="推奨されているクラシック・インフラストラクチャー許可" caption-side="top"}
{: #classic-permissions-suggested}
{: tab-title="Other common use cases"}
{: tab-group="Classic infrastructure permissions"}




