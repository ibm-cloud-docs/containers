---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

subcollection: containers

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



# {{site.data.keyword.containerlong_notm}} を使用する際の責任
{{site.data.keyword.containerlong}} を使用する際のクラスターの管理責任とご利用条件について説明します。
{:shortdesc}

## クラスター管理の責任
{: #responsibilities}

お客様が IBM と分担する、クラスター管理の責任について確認してください。
{:shortdesc}

**IBM は以下について責任を持ちます。**

- クラスター作成時に、マスター、ワーカー・ノード、管理コンポーネント (Ingress アプリケーション・ロード・バランサーなど) をクラスター内にデプロイする
- クラスターの Kubernetes マスターのセキュリティー更新、モニタリング、分離、リカバリーを提供する
- バージョン更新とセキュリティー・パッチをクラスター・ワーカー・ノードに適用できるようにする
- ワーカー・ノードの正常性をモニタリングし、それらのワーカー・ノードの更新とリカバリーの自動化を提供する
- ワーカー・ノードの追加、ワーカー・ノードの削除、デフォルト・サブネットの作成などの、インフラストラクチャー・アカウントに対する自動化タスクを実行する
- クラスター内の運用コンポーネント (Ingress アプリケーション・ロード・バランサーやストレージ・プラグインなど) を管理、更新、リカバリーする
- ストレージ・ボリュームを、永続ボリューム請求で要求されたときにプロビジョンする
- すべてのワーカー・ノードにセキュリティー設定を提供する

</br>

**お客様は以下について責任を持ちます。**

- [IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオと他の {{site.data.keyword.Bluemix_notm}} サービスにアクセスするために、適切な権限を使用して {{site.data.keyword.containerlong_notm}} API キーを構成する](/docs/containers?topic=containers-users#api_key)
- [Kubernetes リソース (ポッド、サービス、デプロイメントなど) をクラスター内にデプロイして管理する](/docs/containers?topic=containers-app#app_cli)
- [アプリの高可用性が確保されるように、サービスと Kubernetes の機能を活用する](/docs/containers?topic=containers-app#highly_available_apps)
- [ワーカー・プールのサイズを変更することで、クラスターの容量を追加または削除する](/docs/containers?topic=containers-clusters#add_workers)
- [VLAN のスパンニングを有効にし、ゾーン間で複数ゾーン・ワーカー・プールのバランスを維持する](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [クラスターのネットワーク分離のために IBM Cloud インフラストラクチャー (SoftLayer) でパブリック VLAN とプライベート VLAN を作成する ](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [すべてのワーカー・ノードに、Kubernetes サービス・エンドポイント URL へのネットワーク接続を設定する](/docs/containers?topic=containers-firewall#firewall)
<p class="note">ワーカー・ノードにパブリック VLAN とプライベート VLAN の両方が設定されている場合は、ネットワーク接続が構成されています。 プライベート VLAN のみを使用してワーカー・ノードをセットアップする場合は、[プライベート・サービス・エンドポイントを有効にする](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)か、[ゲートウェイ・デバイスを構成する](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)ことによって、ワーカー・ノードとクラスター・マスターが通信できるようにする必要があります。ファイアウォールをセットアップする場合は、クラスターと併用する {{site.data.keyword.containerlong_notm}} および他の {{site.data.keyword.Bluemix_notm}} サービスに関するアクセスを許可するように、ファイアウォールの設定を管理したり構成したりする必要があります。</p>
- [Kubernetes バージョンの更新が利用可能になったら、マスター kube-apiserver を更新する](/docs/containers?topic=containers-update#master)
- [ワーカー・ノードをメジャー・バージョン、マイナー・バージョン、およびパッチ・バージョンについて常に最新の状態に保持する](/docs/containers?topic=containers-update#worker_node) <p class="note">ワーカー・ノードのオペレーティング・システムを変更したり、ワーカー・ノードにログインしたりすることはできません。最新のセキュリティー・パッチが含まれる完全なワーカー・ノードのイメージとして、ワーカー・ノードの更新が IBM により提供されています。更新を適用するには、ワーカー・ノードのイメージを再作成し、新しいイメージを使ってワーカー・ノードを再ロードする必要があります。ワーカー・ノードの再ロード時に、root ユーザーの鍵は自動的に交替されます。</p>
- [クラスター・コンポーネント用にログ転送をセットアップして、クラスターの正常性をモニターする](/docs/containers?topic=containers-health#health)。   
- [トラブルが発生したワーカー・ノードをリカバリーする。これは、`kubectl` コマンド (`cordon` や `drain` など) を実行したり、`ibmcloud ks` コマンド (`reboot`、`reload`、`delete` など) を実行したりして行う](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [IBM Cloud インフラストラクチャー (SoftLayer) 内のサブネットを必要に応じて追加または解除する](/docs/containers?topic=containers-subnets#subnets)
- [IBM Cloud インフラストラクチャー (SoftLayer) で永続ストレージのデータのバックアップとリストアを実行する ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- クラスターの正常性とパフォーマンスをサポートするために[ロギング](/docs/containers?topic=containers-health#logging)・サービスと[モニタリング](/docs/containers?topic=containers-health#view_metrics)・サービスをセットアップする
- [Autorecovery を使用したワーカー・ノードの正常性モニタリングの構成](/docs/containers?topic=containers-health#autorecovery)
- クラスター内のリソースを変更するイベントを監査する。例えば [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) を使用して、ユーザーによって開始された {{site.data.keyword.containerlong_notm}} インスタンスの状態を変更するアクティビティーを確認したりする

<br />


## {{site.data.keyword.containerlong_notm}} の不正使用
{: #terms}

お客様は {{site.data.keyword.containerlong_notm}} を不正使用してはいけません。
{:shortdesc}

不正使用には、以下が含まれます。

*   不法行為
*   マルウェアの配布や実行
*   {{site.data.keyword.containerlong_notm}} に損害を与えたり、他のお客様による {{site.data.keyword.containerlong_notm}} の使用に干渉したりすること
*   他のサービスやシステムに損害を与えたり、他のお客様による使用に干渉したりすること
*   サービスまたはシステムに対する無許可アクセス
*   サービスまたはシステムに対する無許可の変更
*   他のお客様の権利を侵害すること

すべての使用条件については、[クラウド・サービスのご利用条件](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms)を参照してください。
