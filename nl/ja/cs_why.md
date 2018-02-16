---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}} を使用する理由
{: #cs_ov}

{{site.data.keyword.containershort}} は、Docker と Kubernetes テクノロジーを結合させた強力なツール、直観的なユーザー・エクスペリエンス、標準装備のセキュリティーと分離機能を提供します。これらの機能を使用することで、コンピュート・ホストから成るクラスター内でコンテナー化アプリのデプロイメント、操作、スケーリング、モニタリングを自動化することができます。
{:shortdesc}

## クラスターを使用する利点
{: #benefits}

クラスターは、ネイティブの Kubernetes と {{site.data.keyword.IBM_notm}} が追加した機能を提供するコンピュート・ホストにデプロイされます。
{:shortdesc}

|利点|説明|
|-------|-----------|
|コンピュート、ネットワーク、およびストレージそれぞれのインフラストラクチャーを分離する、単一テナントの Kubernetes クラスター|<ul><li>組織の要件に適合する、カスタマイズされた独自のインフラストラクチャーを作成できる。</li><li>IBM Cloud インフラストラクチャー (SoftLayer) によって提供されるリソースを使用して、機密保護機能のある専用の Kubernetes マスター、ワーカー・ノード、仮想ネットワーク、そしてストレージをプロビジョンできる。</li><li>統合されたセキュアなボリューム・サービスによって、永続データを保管し、Kubernetes ポッド間でデータを共有し、必要に応じてデータを復元することができる。</li><li>クラスターを使用可能にしておくために {{site.data.keyword.IBM_notm}} によって継続的にモニターされて更新される、完全に管理された Kubernetes マスターを利用できる。</li><li>すべてのネイティブ Kubernetes API をフルサポートすることによる利点。</li></ul>|
|Vulnerability Advisor によるイメージ・セキュリティー・コンプライアンス|<ul><li>保護された独自の Docker プライベート・イメージ・レジストリーをセットアップできる。このレジストリーにイメージが格納され、組織内のすべてのユーザーによって共有される。</li><li>プライベート {{site.data.keyword.Bluemix_notm}} レジストリー内のイメージを自動スキャンすることによる利点。</li><li>イメージ内で使用されるオペレーティング・システムに固有の推奨を確認して、潜在的な脆弱性を修正できる。</li></ul>|
|アプリの自動スケーリング|<ul><li>CPU とメモリーの使用量に基づいてアプリのスケールアップとスケールダウンを行うためのカスタム・ポリシーを定義できる。</li></ul>|
|クラスターの正常性に関する継続的なモニター|<ul><li>クラスター・ダッシュボードを使用して、クラスター、ワーカー・ノード、およびコンテナー・デプロイメントの正常性を素早く参照して管理できる。</li><li>{{site.data.keyword.monitoringlong}}を使用して詳細な使用量メトリックを確認し、ワークロードに合わせてクラスターを素早く拡張することができる。</li><li>{{site.data.keyword.loganalysislong}}を使用してロギング情報を参照して、クラスター・アクティビティーの詳細を確認できる。</li></ul>|
|正常でないコンテナーの自動リカバリー|<ul><li>ワーカー・ノードにデプロイされたコンテナーの継続的なヘルス・チェック。</li><li>コンテナーに障害が発生した場合の自動再作成。</li></ul>|
|サービス・ディスカバリーとサービス・マネジメント|<ul><li>アプリ・サービスを一元的に登録してクラスター内の他のアプリがそれらを使用できるようにしつつ、パブリックには公開しない。</li><li>変化する IP アドレスやコンテナー ID を追跡しなくても登録されたサービスを検出して、使用可能なインスタンスに自動ルーティングできる利点がある。</li></ul>|
|サービスにパブリック・アクセスできるよう安全に公開する|<ul><li>完全なロード・バランサーと Ingress サポートを備えたプライベート・オーバーレイ・ネットワークを使用することによって、だれでもアクセスできるようにアプリを公開することが可能になり、クラスター内の変化する IP アドレスを追跡しなくても複数のワーカー・ノードの間でワークロードのバランスを保つことができる。</li><li>インターネットからクラスター内のサービスにアクセスする方法を、パブリック IP アドレス、{{site.data.keyword.IBM_notm}} 提供の経路、独自のカスタム・ドメインの中から選択できる。</li></ul>|
|{{site.data.keyword.Bluemix_notm}} サービスの統合|<ul><li>Watson API、ブロックチェーン、データ・サービス、モノのインターネットなどの {{site.data.keyword.Bluemix_notm}} サービスを統合してアプリに付加的な機能を追加し、クラスター・ユーザーがアプリ開発とコンテナー管理のプロセスを単純化できるようにする。</li></ul>|

<br />


## ライト・クラスターと標準クラスターの比較
{: #cluster_types}

ライト・クラスターまたは標準クラスターを作成できます。 ライト・クラスターを試して、いくつかの Kubernetes 機能の使用法を習得してテストすることもできますし、標準クラスターを作成して、Kubernetes の機能全体を使用してアプリをデプロイすることもできます。
{:shortdesc}

|特性|ライト・クラスター|標準クラスター|
|---------------|-------------|-----------------|
|[{{site.data.keyword.Bluemix_notm}} で使用可能](cs_why.html)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[クラスター内ネットワーキング](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[NodePort サービスによるパブリック・ネットワーク・アプリ・アクセス](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ユーザー・アクセス管理](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[クラスターとアプリからの {{site.data.keyword.Bluemix_notm}} サービス・アクセス](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ストレージ用のワーカー・ノードのディスク・スペース](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[NFS ファイル・ベースの永続ストレージのボリューム](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ロード・バランサー・サービスによるパブリック・ネットワークまたはプライベート・ネットワークのアプリ・アクセス](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[Ingress サービスによるパブリック・ネットワーク・アプリ・アクセス](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ポータブル・パブリック IP アドレス](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ロギングとモニタリング](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[{{site.data.keyword.Bluemix_dedicated_notm}} で使用可能](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|

<br />



## クラスター管理の責任
{: #responsibilities}

お客様が IBM と分担する、クラスター管理の責任について確認してください。
{:shortdesc}

**IBM は以下について責任を持ちます。**

- クラスター作成時に、マスター、ワーカー・ノード、管理コンポーネント (Ingress コントローラーなど) をクラスター内にデプロイする
- クラスターにおける Kubernetes マスターの更新、モニタリング、リカバリーを管理する
- ワーカー・ノードの正常性をモニタリングし、それらのワーカー・ノードの更新とリカバリーの自動化を提供する
- ワーカー・ノードの追加、ワーカー・ノードの削除、デフォルト・サブネットの作成などの、インフラストラクチャー・アカウントに対する自動化タスクを実行する
- クラスター内の運用コンポーネント (Ingress コントローラーやストレージ・プラグインなど) を管理、更新、リカバリーする
- ストレージ・ボリュームを、永続ボリューム請求で要求されたときにプロビジョンする
- すべてのワーカー・ノードにセキュリティー設定を提供する

</br>
**お客様は以下について責任を持ちます。**

- [Kubernetes リソース (ポッド、サービス、デプロイメントなど) をクラスター内にデプロイして管理する](cs_app.html#app_cli)
- [アプリの高可用性が確保されるように、サービスと Kubernetes の機能を活用する](cs_app.html#highly_available_apps)
- [CLI を使用してワーカー・ノードを追加または解除することで、キャパシティーを追加または縮小する](cs_cli_reference.html#cs_worker_add)
- [クラスターのネットワーク分離のために IBM Cloud インフラストラクチャー (SoftLayer) でパブリック VLAN とプライベート VLAN を作成する ](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [すべてのワーカー・ノードに、Kubernetes マスター URL へのネットワーク接続を設定する](cs_firewall.html#firewall) <p>**注**: ワーカー・ノードにパブリック VLAN とプライベート VLAN の両方が設定されている場合は、ネットワーク接続が構成されています。 ワーカー・ノードにプライベート VLAN のみがセットアップされている場合は、ネットワーク接続を確立するために Vyatta が必要です。</p>
- [Kubernetes のメジャー・バージョンまたはマイナー・バージョンの更新が利用可能な場合に、マスター kube-apiserver ノードとワーカー・ノードを更新する](cs_cluster_update.html#master)
- [トラブルが発生したワーカー・ノードをリカバリーするために対処する。これは、`kubectl` コマンド (`cordon` や `drain` など) を実行したり、`bx cs` コマンド (`reboot`、`reload`、`delete` など) を実行したりして行う](cs_cli_reference.html#cs_worker_reboot)
- [IBM Cloud インフラストラクチャー (SoftLayer) 内の追加サブネットを必要に応じて追加または解除する](cs_subnets.html#subnets)
- [IBM Cloud インフラストラクチャー (SoftLayer) で永続ストレージのデータのバックアップとリストアを実行する ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## コンテナーの不正使用
{: #terms}

お客様は {{site.data.keyword.containershort_notm}} を不正使用してはいけません。
{:shortdesc}

不正使用には、以下が含まれます。

*   不法行為
*   マルウェアの配布や実行
*   {{site.data.keyword.containershort_notm}} に損害を与えたり、他のお客様による {{site.data.keyword.containershort_notm}} の使用に干渉したりすること
*   他のサービスやシステムに損害を与えたり、他のお客様による使用に干渉したりすること
*   サービスまたはシステムに対する無許可アクセス
*   サービスまたはシステムに対する無許可の変更
*   他のお客様の権利を侵害すること

すべての使用条件については、[クラウド・サービスのご利用条件](/docs/navigation/notices.html#terms)を参照してください。
