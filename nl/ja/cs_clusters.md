---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}


# クラスターとワーカー・ノードのセットアップ
{: #clusters}
クラスターを作成して、ワーカー・ノードを追加し、{{site.data.keyword.containerlong}} のクラスターの容量を増やします。 基礎的な内容から始めたい場合は、 [Kubernetes クラスターを作成するチュートリアル](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial)を参照してください。
{: shortdesc}

## クラスター作成の準備
{: #cluster_prepare}

{{site.data.keyword.containerlong_notm}} を使用すると、多数の組み込みの追加機能や構成可能な追加機能を持つ可用性の高い安全な環境をアプリ用に作成できます。 クラスターに多くの可能性があるということは、クラスターの作成時に多くの決定を行う必要があるということでもあります。 以下の手順に、アカウント/許可/リソース・グループ/VLAN スパンニングのセットアップ、ゾーンとハードウェアに関するクラスター・セットアップ、請求先情報に関する考慮事項の概要を示します。
{: shortdesc}

このリストには、次の 2 つの部分があります。
*  **アカウント・レベル**: アカウント管理者がこの準備を行った後で、クラスターを作成するたびに変更する必要はないかもしれません。 しかし、クラスターを作成するたびに、現行のアカウント・レベルの状態が必要にかなっているか検証することができます。
*  **クラスター・レベル**: この準備は、クラスターを作成するたびに、そのクラスターに影響があります。

### アカウント・レベル
{: #prepare_account_level}

{{site.data.keyword.containerlong_notm}} 用の {{site.data.keyword.Bluemix_notm}} アカウントを準備するには、以下の手順に従います。
{: shortdesc}

1.  [有料アカウント ({{site.data.keyword.Bluemix_notm}} 従量課金またはサブスクリプション) を作成するか、有料アカウントにアップグレードします](https://cloud.ibm.com/registration/)。
2.  クラスターを作成しようとしている地域内で[{{site.data.keyword.containerlong_notm}} API キーをセットアップ](/docs/containers?topic=containers-users#api_key)します。 以下のような、クラスターを作成するための該当する許可を API キーに割り当てます。
    *  IBM Cloud インフラストラクチャー (SoftLayer) に対する**スーパーユーザー**の役割。
    *  {{site.data.keyword.containerlong_notm}} に対するアカウント・レベルの**管理者**のプラットフォーム管理役割。
    *  {{site.data.keyword.registrylong_notm}} に対するアカウント・レベルの**管理者**のプラットフォーム管理役割。 2018 年 10 月 4 日より前に作成されたアカウントの場合は、[{{site.data.keyword.registryshort_notm}} に対して {{site.data.keyword.Bluemix_notm}} IAM ポリシーを有効にする](/docs/services/Registry?topic=registry-user#existing_users)必要があります。 IAM ポリシーを使用すると、レジストリー名前空間などのリソースへのアクセスを制御できます。

    アカウント所有者には、 必要な許可が既にあります。 クラスターを作成すると、ご使用の資格情報を使用してその地域とリソース・グループの API キーが設定されます。
    {: tip}

3.  ご使用のアカウントで複数のリソース・グループが使用されている場合は、[リソース・グループを管理](/docs/containers?topic=containers-users#resource_groups)するためのアカウントの戦略を考えます。 
    *  {{site.data.keyword.Bluemix_notm}} にログインする際にターゲットとして設定するリソース・グループ内にクラスターを作成します。 リソース・グループをターゲットとして設定しない場合は、デフォルトのリソース・グループが自動的にターゲットとして設定されます。
    *  デフォルトとは異なるリソース・グループにクラスターを作成する場合は、そのリソース・グループに対する**ビューアー**以上の役割が必要です。 そのリソース・グループに対する役割はないものの、リソース・グループ内のサービスに対する**管理者**ではある場合、デフォルトのリソース・グループ内にクラスターが作成されます。
    *  クラスターのリソース・グループを変更することはできません。 また、`ibmcloud ks cluster-service-bind` [コマンド](/docs/containers-cli-plugin?topic=containers-cli-plugin-cs_cli_reference#cs_cluster_service_bind)を使用して [{{site.data.keyword.Bluemix_notm}} サービスと統合](/docs/containers?topic=containers-service-binding#bind-services)する必要がある場合は、このサービスがクラスターと同じリソース・グループにある必要があります。{{site.data.keyword.registrylong_notm}} のようにリソース・グループを使用しないサービスや、{{site.data.keyword.la_full_notm}} のようにサービス・バインディングを必要としないサービスは、異なるリソース・グループにクラスターがあっても機能します。
    *  [メトリック用に {{site.data.keyword.monitoringlong_notm}}](/docs/containers?topic=containers-health#view_metrics) を使用する計画の場合は、メトリックの命名に関する競合を避けるために、アカウントに属するすべてのリソース・グループと地域において固有の名前をクラスターに付けるよう計画します。

4.  IBM Cloud インフラストラクチャー (SoftLayer) ネットワークをセットアップします。 以下の選択肢から選択できます。
    *  **VRF 対応**: Kubernetes バージョン 1.11 以降を実行するクラスターでは、Virtual Routing and Forwarding (VRF) とその多重分離テクノロジーにより、パブリックおよびプライベートの両方のサービス・エンドポイントを使用して、Kubernetes マスターと通信できます。 [プライベート・サービス・エンドポイント](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)を使用すれば、Kubernetes マスターとワーカー・ノードの通信はプライベート VLAN でのみ行われます。 ローカル・マシンからクラスターに対して `kubectl` コマンドを実行するには、Kubernetes マスターと同じプライベート VLAN に接続する必要があります。 アプリをインターネットに公開するには、着信ネットワーク・トラフィックをアプリに転送できるように、ワーカー・ノードをパブリック VLAN に接続する必要があります。 インターネット経由でクラスターに対して `kubectl` コマンドを実行するには、パブリック・サービス・エンドポイントを使用します。 パブリック・サービス・エンドポイントでは、ネットワーク・トラフィックはパブリック VLAN 経由でルーティングされ、OpenVPN トンネルを使用して保護されます。 プライベート・サービス・エンドポイントを使用するには、アカウントで VRF とサービス・エンドポイントを有効にする必要があります。そのためには、IBM Cloud インフラストラクチャー (SoftLayer) のサポート・ケースを開く必要があります。 詳しくは、[{{site.data.keyword.Bluemix_notm}} の VRF の概要](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)および[アカウントのサービス・エンドポイントの有効化](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)を参照してください。
    *  **VRF 非対応**: アカウントの VRF を有効にしない、または有効にできない場合、ワーカー・ノードは、[パブリック・サービス・エンドポイント](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)を介して、パブリック・ネットワーク経由で自動的に Kubernetes マスターに接続できます。この通信を保護するために、{{site.data.keyword.containerlong_notm}} は、クラスターの作成時に、Kubernetes マスターとワーカー・ノードの間の OpenVPN 接続を自動的にセットアップします。 1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](/docs/containers?topic=containers-users#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)を使用します。

### クラスター・レベル
{: #prepare_cluster_level}

クラスターのセットアップを準備するには、以下の手順に従います。
{: shortdesc}

1.  {{site.data.keyword.containerlong_notm}} に対する**管理者**のプラットフォーム管理役割があることを確認します。 クラスターで専用レジストリーからイメージをプルできるようにするには、{{site.data.keyword.registrylong_notm}} に対する**管理者**のプラットフォーム役割も必要です。
    1.  [{{site.data.keyword.Bluemix_notm}} コンソール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/) のメニュー・バーで、**「管理」> 「アクセス (IAM)」**をクリックします。
    2.  **「ユーザー」**ページをクリックし、テーブルから自分を選択します。
    3.  **「アクセス・ポリシー」**タブから、**「役割」**が**「管理者」**になっていることを確認します。 アカウントに属するすべてのリソースか、少なくとも {{site.data.keyword.containershort_notm}} に対して、**管理者**になることができます。 **注**: アカウント全体ではなく 1 つのリソース・グループまたは地域のみの {{site.data.keyword.containershort_notm}} に対する**管理者**役割がある場合、アカウントの VLAN を参照するには、少なくともアカウント・レベルで**ビューアー**役割がなければなりません。
    <p class="tip">アカウント管理者によって、**管理者**のプラットフォーム役割がサービス役割として同時に割り当てられていないことを確認します。プラットフォーム役割とサービス役割は別々に割り当てる必要があります。</p>
2.  [フリー・クラスターまたは標準クラスター](/docs/containers?topic=containers-cs_ov#cluster_types)のどちらにするかを決定します。 フリー・クラスターを 1 つ作成して機能を 30 日間試すことも、ハードウェア分離を選択して完全にカスタマイズ可能な標準クラスターを作成することもできます。 クラスター・パフォーマンスの利点を活かし、制御するには、標準クラスターを作成します。
3.  [クラスターのセットアップを計画](/docs/containers?topic=containers-plan_clusters#plan_clusters)します。
    *  [単一ゾーン](/docs/containers?topic=containers-plan_clusters#single_zone)・クラスターと[複数ゾーン](/docs/containers?topic=containers-plan_clusters#multizone)・クラスターのどちらを作成するかを決定します。 複数ゾーン・クラスターは特定のロケーションでのみ提供されていることに注意してください。
    *  パブリックにアクセスできないクラスターを作成しようとしている場合、追加の[プライベート・クラスターの手順](/docs/containers?topic=containers-plan_clusters#private_clusters)を確認します。
    *  クラスターのワーカー・ノードにとって必要な[ハードウェアと分離](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)のタイプを選択します。仮想マシンとベアメタル・マシンのどちらにするか決定することも含まれます。
4.  標準クラスターの場合は、{{site.data.keyword.Bluemix_notm}} コンソールで[コストを見積もる](/docs/billing-usage?topic=billing-usage-cost#cost)ことができます。 見積もりツールに含まれない可能性がある料金について詳しくは、[価格設定および請求](/docs/containers?topic=containers-faqs#charges)を参照してください。
5.  ファイアウォールの内側の環境にクラスターを作成する場合は、使用する予定の {{site.data.keyword.Bluemix_notm}} サービスの[パブリック IP およびプライベート IP へのアウトバウンド・ネットワーク・トラフィック](/docs/containers?topic=containers-firewall#firewall_outbound)を許可します。
<br>
<br>

**次の作業**
* [{{site.data.keyword.Bluemix_notm}} コンソールでのクラスターの作成](#clusters_ui)
* [{{site.data.keyword.Bluemix_notm}} CLI でのクラスターの作成](#clusters_cli)

## {{site.data.keyword.Bluemix_notm}} コンソールでのクラスターの作成
{: #clusters_ui}

Kubernetes クラスターの目的は、アプリの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。 アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

[マスターからワーカーへの通信](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)に[サービス・エンドポイント](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)を使用するクラスターを作成するには、 [CLI を使用](#clusters_cli)してクラスターを作成する必要があります。
{: note}

### フリー・クラスターの作成
{: #clusters_ui_free}

{{site.data.keyword.containerlong_notm}} の作業に慣れるために、フリー・クラスターを 1 つ使用することができます。 フリー・クラスターで、用語について学習し、チュートリアルを行い、やるべきことを理解した後に、実動レベルの標準クラスターの使用に踏み出すことができます。 ご安心ください。有料アカウントの場合でもフリー・クラスターを利用できます。
{: shortdesc}

フリー・クラスターの存続期間は 30 日です。 その後、クラスターは期限切れになり、クラスターとそのデータは削除されます。 削除されたデータは、{{site.data.keyword.Bluemix_notm}} でバックアップされず、リストアできません。 重要なデータは必ずバックアップしてください。
{: note}

1. [クラスターを作成する準備をして](#cluster_prepare)、{{site.data.keyword.Bluemix_notm}} アカウントのセットアップとユーザー許可が正しいことを確認し、使用するクラスター・セットアップとリソース・グループを決定します。
2. [カタログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/catalog?category=containers) で、クラスターを作成する **{{site.data.keyword.containershort_notm}}** を選択します。
3. クラスターをデプロイするジオグラフィーを選択します。クラスターはこのジオグラフィー内のゾーンに作成されます。
4. **「無料」**クラスター・プランを選択します。
5. 名前をクラスターに付けます。 名前は先頭が文字でなければならず、文字、数字、およびハイフン (-) を使用できます。35 文字以内でなければなりません。 Ingress サブドメインの完全修飾ドメイン・ネームは、クラスター名と、クラスターがデプロイされる地域で形成されます。 Ingress サブドメインを地域内で固有にするために、クラスター名が切り捨てられ、Ingress ドメイン・ネームにランダムな値が付加されることがあります。

6. **「クラスターの作成」**をクリックします。 デフォルトでは、ワーカー・ノードを 1 つ含むワーカー・プールが作成されます。 **「ワーカー・ノード」**タブでワーカー・ノードのデプロイメントの進行状況を確認できます。 デプロイが完了すると、クラスターが**「概要」**タブに準備されていることが分かります。 クラスターの準備ができている場合でも、Ingress シークレットやレジストリーのイメージ・プル・シークレットなどの他のサービスによって使用される、クラスターの一部がまだ処理中である可能性があることに注意してください。

    作成時に割り当てられる固有の ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。
    {: note}

</br>

### 標準クラスターの作成
{: #clusters_ui_standard}

1. [クラスターを作成する準備をして](#cluster_prepare)、{{site.data.keyword.Bluemix_notm}} アカウントのセットアップとユーザー許可が正しいことを確認し、使用するクラスター・セットアップとリソース・グループを決定します。
2. [カタログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/catalog?category=containers) で、クラスターを作成する **{{site.data.keyword.containershort_notm}}** を選択します。
3. クラスターを作成するリソース・グループを選択します。
  **注:**
    * 1 つのリソース・グループのみにクラスターを作成できます。また、クラスターの作成後にそのリソース・グループを変更することはできません。
    * デフォルトのリソース・グループに無料クラスターが自動的に作成されます。
    * デフォルト以外のリソース・グループにクラスターを作成するには、リソース・グループに対する[**ビューアー**以上の役割](/docs/containers?topic=containers-users#platform)が必要です。
4. クラスターをデプロイする [{{site.data.keyword.Bluemix_notm}} のロケーション](/docs/containers?topic=containers-regions-and-zones#regions-and-zones)を選択します。 最高のパフォーマンスを得るために、物理的に最も近いロケーションを選択してください。 国外のゾーンを選択する場合は、データを保管する前に法的な許可を得なければならないことがあるので留意してください。
5. **「標準」**クラスター・プランを選択します。 標準クラスターでは、複数ワーカー・ノードなどの機能を利用して、可用性の高い環境を実現できます。
6. ゾーンの詳細情報を入力します。
    1. **「単一ゾーン (Single zone)」**または**「複数ゾーン (Multizone)」**の可用性を選択します。 複数ゾーン・クラスターでは、マスター・ノードは複数ゾーン対応ゾーンにデプロイされ、クラスターのリソースは複数のゾーン間に分散されます。 地域によって選択肢が限定される可能性があります。
    2. クラスターをホストする特定のゾーンを選択します。 少なくとも 1 つのゾーンを選択する必要がありますが、ご希望の数だけ選択できます。 複数のゾーンを選択すると、その選択したゾーン間でワーカー・ノードが分散され、可用性が高くなります。 ゾーンを 1 つだけ選択した場合は、クラスターの作成後に[ゾーンを追加](#add_zone)できます。
    3. パブリック VLAN (オプション) とプライベート VLAN (必須) を IBM Cloud インフラストラクチャー (SoftLayer) アカウントから選択します。 ワーカー・ノードはプライベート VLAN を使用して相互に通信します。 Kubernetes マスターと通信するために、ワーカー・ノードにパブリック接続を構成する必要があります。  このゾーン内にパブリック VLAN またはプライベート VLAN がない場合は、ブランクのままにしてください。 パブリック VLAN とプライベート VLAN は自動的に作成されます。 既存の VLAN があり、パブリック VLAN を指定しない場合は、[仮想ルーター・アプライアンス](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra)などのファイアウォールの構成を検討してください。 複数のクラスターで同じ VLAN を使用できます。
        プライベート VLAN のみを使用してワーカー・ノードをセットアップする場合は、[プライベート・サービス・エンドポイントを有効にする](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)か、[ゲートウェイ・デバイスを構成する](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)ことによって、ワーカー・ノードとクラスター・マスターが通信できるようにする必要があります。
        {: note}

7. デフォルトのワーカー・プールを構成します。 ワーカー・プールとは、同じ構成を共有するワーカー・ノードのグループのことです。 後で、別のワーカー・プールをクラスターに追加することができます。

    1. ハードウェア分離のタイプを選択します。 仮想マシンは時間単位で請求され、ベア・メタル・マシンは月単位で請求されます。

        - **仮想 - 専用**: ワーカー・ノードはお客様のアカウント専用のインフラストラクチャーでホストされます。 物理リソースは完全に分離されます。

        - **仮想 - 共有**: ハイパーバイザーや物理ハードウェアなどのインフラストラクチャー・リソースはお客様と IBM の他の利用者の間で共有されます。ただし、各ワーカー・ノードにはお客様だけがアクセスできます。 ほとんどの場合はこの安価なオプションで十分ですが、企業ポリシーに照らしてパフォーマンスとインフラストラクチャーの要件を確認する必要があります。

        - **ベアメタル**: 月単位で課金されるベアメタル・サーバーは、お客様が注文した後に IBM Cloud インフラストラクチャー (SoftLayer) によって手動でプロビジョンされます。完了するまでに 1 営業日以上かかることがあります。 多くのリソースとホスト制御を必要とする高性能アプリケーションには、ベア・メタルが最適です。 ワーカー・ノードが改ざんされていないことを検証するために、[トラステッド・コンピューティング](/docs/containers?topic=containers-security#trusted_compute)を有効にすることも選択できます。 トラステッド・コンピューティングは、選ばれたベア・メタル・マシン・タイプでのみ使用できます。 例えば、`mgXc` GPU フレーバーではトラステッド・コンピューティングはサポートされません。 クラスターの作成時にトラストを有効にしなかった場合に、後で有効にするには、`ibmcloud ks feature-enable` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)を使用します。 トラストを有効にした後に無効にすることはできません。

        ベア・メタル・マシンは、必ず確認してからプロビジョンしてください。 月単位で課金されるので、誤って注文した後にすぐに解約しても、1 カ月分の料金が課金されます。
        {:tip}

    2. マシン・タイプを選択します。 各ワーカー・ノードにセットアップされ、コンテナーで使用できるようになる仮想 CPU、メモリー、ディスク・スペースの量は、マシン・タイプによって決まります。 使用可能なベア・メタル・マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 クラスターを作成した後、ワーカーまたはプールをクラスターに追加して別のマシン・タイプを追加できます。

    3. クラスターに必要なワーカー・ノードの数を指定します。 入力した数のワーカーが、選択した数のゾーンのそれぞれに複製されます。 つまり、2 つのゾーンがある場合に、3 つのワーカー・ノードを選択すると、6 つのノードがプロビジョンされ、各ゾーンに 3 つのノードが存在することになります。

8. 固有の名前をクラスターに付けます。 **注**: 作成時に割り当てられる固有の ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。
9. クラスター・マスター・ノードの Kubernetes API サーバーのバージョンを選択します。
10. **「クラスターの作成」**をクリックします。 指定した数のワーカーを含むワーカー・プールが作成されます。 **「ワーカー・ノード」**タブでワーカー・ノードのデプロイメントの進行状況を確認できます。 デプロイが完了すると、クラスターが**「概要」**タブに準備されていることが分かります。 クラスターの準備ができている場合でも、Ingress シークレットやレジストリーのイメージ・プル・シークレットなどの他のサービスによって使用される、クラスターの一部がまだ処理中である可能性があることに注意してください。

**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

-   複数ゾーン対応ゾーンにクラスターを作成した場合は、[ゾーンをクラスターに追加](#add_zone)して、ワーカー・ノードを分散させます。
-   [CLI をインストール](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)して、または [Web ブラウザーで直接 CLI を使用するために Kubernetes Terminal を起動](/docs/containers?topic=containers-cs_cli_install#cli_web)して、クラスターでの作業を開始します。
-   [クラスターにアプリをデプロイします。](/docs/containers?topic=containers-app#app_cli)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry?topic=registry-getting-started)
-   ファイアウォールがある場合、[必要なポートを開く](/docs/containers?topic=containers-firewall#firewall)必要が生じることがあります。例えば、コマンド `ibmcloud`、`kubectl`、または `calicotl` を使用する場合、クラスターからのアウトバウンド・トラフィックを許可する場合、ネットワーク・サービスのインバウンド・トラフィックを許可する場合などです。
-   ワークロード・リソース要求に基づいてワーカー・プールにワーカー・ノードを自動的に追加または削除するように[クラスター自動スケーリング機能をセットアップ](/docs/containers?topic=containers-ca#ca)します。
-   [ポッドのセキュリティー・ポリシー](/docs/containers?topic=containers-psp)を使用して、クラスター内にポッドを作成できる人を制御します。

<br />


## {{site.data.keyword.Bluemix_notm}} CLI でのクラスターの作成
{: #clusters_cli}

Kubernetes クラスターの目的は、アプリの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。 アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

### サンプル CLI `ibmcloud ks cluster-create` コマンド
{: #clusters_cli_samples}

前にクラスターを作成したことがあり、簡単なコマンド例を探しているだけであれば、 以下の例をお試しください。
*  **フリー・クラスター**:
   ```
   ibmcloud ks cluster-create --name my_cluster
   ```
   {: pre}
*  **標準クラスター、共有仮想マシン**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **標準クラスター、ベアメタル**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **標準クラスター、VRF 対応アカウントで[パブリックおよびプライベートのサービス・エンドポイント](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)を使用できる仮想マシン**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*   **標準クラスター、プライベート VLAN 専用およびプライベート・サービス・エンドポイント専用**。プライベート・クラスター・ネットワーキングの構成について詳しくは、[プライベート VLAN のみを使用するクラスター・ネットワークのセットアップ](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan)を参照してください。
    ```
    ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_VLAN_ID> --private-only
    ```
    {: pre}

### CLI でのクラスターの作成手順
{: #clusters_cli_steps}

開始する前に、{{site.data.keyword.Bluemix_notm}} CLI および [{{site.data.keyword.containerlong_notm}} プラグイン](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)をインストールしてください。

クラスターを作成するには、以下のようにします。

1. [クラスターを作成する準備をして](#cluster_prepare)、{{site.data.keyword.Bluemix_notm}} アカウントのセットアップとユーザー許可が正しいことを確認し、使用するクラスター・セットアップとリソース・グループを決定します。

2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。

    1.  ログインし、プロンプトが出されたら {{site.data.keyword.Bluemix_notm}} 資格情報を入力します。

        ```
        ibmcloud login
        ```
        {: pre}

        フェデレーテッド ID がある場合は、`ibmcloud login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。 ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。
        {: tip}

    2. 複数の {{site.data.keyword.Bluemix_notm}} アカウントがある場合は、Kubernetes クラスターを作成するアカウントを選択します。

    3.  デフォルト以外のリソース・グループにクラスターを作成するには、そのリソース・グループをターゲットとして設定します。
      **注:**
        * 1 つのリソース・グループのみにクラスターを作成できます。また、クラスターの作成後にそのリソース・グループを変更することはできません。
        * リソース・グループに対する[**ビューアー**以上の役割](/docs/containers?topic=containers-users#platform)が必要です。
        * デフォルトのリソース・グループに無料クラスターが自動的に作成されます。
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4. **フリー・クラスター**: 特定の地域にフリー・クラスターを作成する場合は、`ibmcloud ks region-set` を実行して、その地域をターゲットにする必要があります。

4.  クラスターを作成します。 標準クラスターは、任意の地域の使用可能なゾーンに作成できます。 フリー・クラスターは、`ibmcloud ks region-set` コマンドでターゲットに設定した地域には作成できますが、ゾーンを選択することはできません。

    1.  **標準クラスター**: 使用可能なゾーンを確認します。 表示されるゾーンは、ログインしている {{site.data.keyword.containerlong_notm}} 地域によって異なります。 複数のゾーンにクラスターを広げるには、[複数ゾーン対応ゾーン](/docs/containers?topic=containers-regions-and-zones#zones)内でクラスターを作成する必要があります。
        ```
        ibmcloud ks zones
        ```
        {: pre}
        国外のゾーンを選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。
        {: note}

    2.  **標準クラスター**: ゾーンを選択して、そのゾーンで使用できるマシン・タイプを確認します。 マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・ホストまたは物理コンピュート・ホストが決まります。

        -  **「サーバー・タイプ」**フィールドを表示して、仮想マシンと物理 (ベア・メタル) マシンのどちらにするかを選択します。
        -  **仮想**: 仮想マシンは時間単位で課金され、共有ハードウェアまたは専用ハードウェア上にプロビジョンされます。
        -  **物理**: 月単位で課金されるベアメタル・サーバーは、お客様が注文した後に IBM Cloud インフラストラクチャー (SoftLayer) によって手動でプロビジョンされます。完了するまでに 1 営業日以上かかることがあります。 多くのリソースとホスト制御を必要とする高性能アプリケーションには、ベア・メタルが最適です。
        - **トラステッド・コンピューティングを使用する物理マシン**: ベア・メタル・ワーカー・ノードが改ざんされていないことを検証するために、[トラステッド・コンピューティング](/docs/containers?topic=containers-security#trusted_compute)を有効にすることもできます。 トラステッド・コンピューティングは、選ばれたベア・メタル・マシン・タイプでのみ使用できます。 例えば、`mgXc` GPU フレーバーではトラステッド・コンピューティングはサポートされません。 クラスターの作成時にトラストを有効にしなかった場合に、後で有効にするには、`ibmcloud ks feature-enable` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)を使用します。 トラストを有効にした後に無効にすることはできません。
        -  **マシン・タイプ**: デプロイするマシン・タイプを決定するには、[使用可能なワーカー・ノードのハードウェア](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)のコア、メモリー、ストレージの組み合わせについて検討してください。 クラスターを作成した後、[ワーカー・プールを追加](#add_pool)して、別の物理または仮想マシン・タイプを追加できます。

           ベア・メタル・マシンは、必ず確認してからプロビジョンしてください。 月単位で課金されるので、誤って注文した後にすぐに解約しても、1 カ月分の料金が課金されます。
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **標準クラスター**: このアカウントの IBM Cloud インフラストラクチャー (SoftLayer) にパブリック VLAN とプライベート VLAN が既に存在しているかどうかを確認します。

        ```
        ibmcloud ks vlans --zone <zone>
        ```
        {: pre}

        ```
        ID        Name   Number   Type      Router
        1519999   vlan   1355     private   bcr02a.dal10
        1519898   vlan   1357     private   bcr02a.dal10
        1518787   vlan   1252     public    fcr02a.dal10
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        パブリック VLAN およびプライベート VLAN が既に存在する場合、対応するルーターをメモに取ります。 必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。 このサンプル出力では、すべてのルーターに
`02a.dal10` が含まれているため、これらのプライベート VLAN とパブリック VLAN はどの組み合わせでも使用できます。

        ワーカー・ノードはプライベート VLAN に接続する必要があります。オプションで、ワーカー・ノードをパブリック VLAN に接続できます。 **注**: ワーカー・ノードにプライベート VLAN のみをセットアップする場合は、[プライベート・サービス・エンドポイントを有効にする](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)か、または[ゲートウェイ・デバイスを構成](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)して、ワーカー・ノードとクラスター・マスターが通信できるようにする必要があります。

    4.  **フリー・クラスターおよび標準クラスター**: `cluster-create` コマンドを実行します。 vCPU 2 つと 4GB のメモリーでセットアップされた 1 つのワーカー・ノードが含まれており、30 日後に自動的に削除されるフリー・クラスターのなかから選択できます。 標準クラスターを作成する場合、デフォルトでは、ワーカー・ノードのディスクは AES 256 ビット暗号化され、そのハードウェアは IBM の複数のお客様によって共有され、使用時間に応じて課金されます。 </br>標準クラスターの例。 次のようにクラスターのオプションを指定します。

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b3c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--private-service-endpoint][--public-service-endpoint] [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        フリー・クラスターの例。 次のようにクラスター名を指定します。

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>cluster-create コンポーネント</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**標準クラスター**: <em>&lt;zone&gt;</em> を、クラスターを作成する {{site.data.keyword.Bluemix_notm}} ゾーンの ID に置き換えます。 使用可能なゾーンは、ログインしている {{site.data.keyword.containerlong_notm}} 地域によって異なります。<p class="note">クラスター・ワーカー・ノードはこのゾーン内にデプロイされます。 複数のゾーンにクラスターを広げるには、[複数ゾーン対応ゾーン](/docs/containers?topic=containers-regions-and-zones#zones)内でクラスターを作成する必要があります。 クラスターの作成後に、[ゾーンをクラスターに追加](#add_zone)できます。</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**標準クラスター**: マシン・タイプを選択します。 ワーカー・ノードは、共有または専用ハードウェア上に仮想マシンとしてデプロイすることも、ベア・メタル上に物理マシンとしてデプロイすることもできます。 使用可能な物理マシンと仮想マシンのタイプは、クラスターをデプロイするゾーンによって異なります。 詳しくは、`ibmcloud ks machine-type` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)についての説明を参照してください。 フリー・クラスターの場合、マシン・タイプを定義する必要はありません。</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**標準クラスター**: ワーカー・ノードのハードウェア分離のレベル。 使用可能な物理リソースを自分専用にする場合は dedicated を使用し、IBM の他のお客様と物理リソースを共有することを許可する場合は shared を使用します。 デフォルトは shared です。 この値は、VM 標準クラスターではオプションで、フリー・クラスターでは使用できません。 ベアメタル・マシン・タイプの場合、`dedicated` を指定します。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**フリー・クラスター**: パブリック VLAN を定義する必要はありません。 フリー・クラスターは IBM 所有のパブリック VLAN に自動的に接続されます。</li>
          <li>**標準クラスター**: IBM Cloud インフラストラクチャー (SoftLayer) アカウントでそのゾーン用にパブリック VLAN を既にセットアップしている場合には、そのパブリック VLAN の ID を入力します。 ワーカー・ノードをプライベート VLAN だけに接続する場合は、このオプションを指定しないでください。
          <p>必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。</p>
          <p class="note">プライベート VLAN のみを使用してワーカー・ノードをセットアップする場合は、[プライベート・サービス・エンドポイントを有効にする](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)か、[ゲートウェイ・デバイスを構成する](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)ことによって、ワーカー・ノードとクラスター・マスターが通信できるようにする必要があります。</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**フリー・クラスター**: プライベート VLAN を定義する必要はありません。 フリー・クラスターは IBM 所有のプライベート VLAN に自動的に接続されます。</li><li>**標準クラスター**: IBM Cloud インフラストラクチャー (SoftLayer) アカウントでそのゾーン用にプライベート VLAN を既にセットアップしている場合には、そのプライベート VLAN の ID を入力します。 ご使用のアカウントでプライベート VLAN がない場合は、このオプションを指定しないでください。 {{site.data.keyword.containerlong_notm}} が自動的にプライベート VLAN を作成します。<p>必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。 クラスターを作成し、パブリック VLAN とプライベート VLAN を指定するときには、それらの接頭部の後の番号と文字の組み合わせが一致する必要があります。</p></li>
        <li>[プライベート VLAN 専用クラスター](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan)を作成するには、`--private-vlan` フラグおよび `--private-only` フラグを含めて、選択を確認します。`--public-vlan` フラグおよび `--public-service-endpoint` フラグは**含めないでください**。マスター・ノードとワーカー・ノードとの間の接続を有効にするには、`--private-service-endpoint` フラグを含めるか、または独自のゲートウェイ・アプライアンス・デバイスをセットアップする必要があることに注意してください。</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**フリー・クラスターおよび標準クラスター**: <em>&lt;name&gt;</em> をクラスターの名前に置き換えます。 名前は先頭が文字でなければならず、文字、数字、およびハイフン (-) を使用できます。35 文字以内でなければなりません。 Ingress サブドメインの完全修飾ドメイン・ネームは、クラスター名と、クラスターがデプロイされる地域で形成されます。 Ingress サブドメインを地域内で固有にするために、クラスター名が切り捨てられ、Ingress ドメイン・ネームにランダムな値が付加されることがあります。
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**標準クラスター**: クラスターに含めるワーカー・ノードの数。 <code>--workers</code> オプションが指定されていない場合は、ワーカー・ノードが 1 つ作成されます。</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**標準クラスター**: クラスター・マスター・ノードの Kubernetes のバージョン。 この値はオプションです。 バージョンを指定しなかった場合、クラスターは、サポートされるデフォルトの Kubernetes バージョンを使用して作成されます。 使用可能なバージョンを確認するには、<code>ibmcloud ks kube-versions</code> を実行します。
</td>
        </tr>
        <tr>
        <td><code>--private-service-endpoint</code></td>
        <td>**[VRF 対応アカウント](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)の標準クラスター**: Kubernetes マスター・ノードとワーカー・ノードがプライベート VLAN を介して通信できるように、[プライベート・サービス・エンドポイント](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)を有効にします。 さらに、`--public-service-endpoint` フラグを使用してパブリック・サービス・エンドポイントを有効にすることで、インターネットを介してクラスターにアクセスすることもできます。 プライベート・サービス・エンドポイントのみを有効にする場合は、Kubernetes マスターと通信するためにプライベート VLAN に接続している必要があります。 プライベート・サービス・エンドポイントを有効にしたら、後で無効にすることはできません。<br><br>クラスターを作成した後、`ibmcloud ks cluster-get <cluster_name_or_ID>` を実行してエンドポイントを取得できます。</td>
        </tr>
        <tr>
        <td><code>--public-service-endpoint</code></td>
        <td>**標準クラスター**: Kubernetes マスターにパブリック・ネットワーク経由でアクセスできるように、[パブリック・サービス・エンドポイント](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)を有効にします。例えば、端末から `kubectl` コマンドを実行できるようになります。 `--private-service-endpoint` フラグも指定した場合は、[マスターとワーカー・ノードの通信](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)は、VRF 対応アカウントのプライベート・ネットワークで行われます。 後で、プライベート専用クラスターにする場合は、パブリック・サービス・エンドポイントを無効にすることができます。<br><br>クラスターを作成した後、`ibmcloud ks cluster-get <cluster_name_or_ID>` を実行してエンドポイントを取得できます。</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**フリー・クラスターおよび標準クラスター**: ワーカー・ノードには、デフォルトで AES 256 ビット・[ディスク暗号化](/docs/containers?topic=containers-security#encrypted_disk)の機能があります。 暗号化を無効にする場合は、このオプションを組み込みます。</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**標準のベア・メタル・クラスター**: [トラステッド・コンピューティング](/docs/containers?topic=containers-security#trusted_compute)を有効にして、ベア・メタル・ワーカー・ノードが改ざんされていないことを検証します。 トラステッド・コンピューティングは、選ばれたベア・メタル・マシン・タイプでのみ使用できます。 例えば、`mgXc` GPU フレーバーではトラステッド・コンピューティングはサポートされません。 クラスターの作成時にトラストを有効にしなかった場合に、後で有効にするには、`ibmcloud ks feature-enable` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)を使用します。 トラストを有効にした後に無効にすることはできません。</td>
        </tr>
        </tbody></table>

5.  クラスターの作成が要求されたことを確認します。 仮想マシンの場合、ワーカー・ノード・マシンの注文と、アカウントへのクラスターのセットアップとプロビジョンには、数分かかります。 ベア・メタル物理マシンは、IBM Cloud インフラストラクチャー (SoftLayer) との人同士のやりとりによりプロビジョンされるので、完了するのに 1 営業日以上かかることがあります。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    クラスターのプロビジョニングが完了すると、クラスターの状況が **deployed** に変わります。

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.12.7      Default
    ```
    {: screen}

6.  ワーカー・ノードの状況を確認します。

    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。 ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。 クラスターの準備ができている場合でも、Ingress シークレットやレジストリーのイメージ・プル・シークレットなどの他のサービスによって使用される、クラスターの一部がまだ処理中である可能性があることに注意してください。

    どのワーカー・ノードにも固有のワーカー・ノード ID とドメイン名が割り当てられます。それらをクラスター作成後に手動で変更してはいけません。 ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.12.7      Default
    ```
    {: screen}

7.  作成したクラスターを、このセッションのコンテキストとして設定します。 次の構成手順は、クラスターの操作時に毎回行ってください。
    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。

        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。

        OS X の場合の例:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。
    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。

        OS X の場合の例:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        出力:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  デフォルトのポート `8001` で Kubernetes ダッシュボードを起動します。
    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Web ブラウザーで以下の URL を開いて、Kubernetes ダッシュボードを表示します。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**次の作業**

-   複数ゾーン対応ゾーンにクラスターを作成した場合は、[ゾーンをクラスターに追加](#add_zone)して、ワーカー・ノードを分散させます。
-   [クラスターにアプリをデプロイします。](/docs/containers?topic=containers-app#app_cli)
-   [`kubectl` コマンド・ラインを使用してクラスターを管理します。![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubectl.docs.kubernetes.io/)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry?topic=registry-getting-started)
- ファイアウォールがある場合、[必要なポートを開く](/docs/containers?topic=containers-firewall#firewall)必要が生じることがあります。例えば、コマンド `ibmcloud`、`kubectl`、または `calicotl` を使用する場合、クラスターからのアウトバウンド・トラフィックを許可する場合、ネットワーク・サービスのインバウンド・トラフィックを許可する場合などです。
-   ワークロード・リソース要求に基づいてワーカー・プールにワーカー・ノードを自動的に追加または削除するように[クラスター自動スケーリング機能をセットアップ](/docs/containers?topic=containers-ca#ca)します。
-  [ポッドのセキュリティー・ポリシー](/docs/containers?topic=containers-psp)を使用して、クラスター内にポッドを作成できる人を制御します。

<br />



## クラスターへのワーカー・ノードとゾーンの追加
{: #add_workers}

アプリの可用性を高めるために、クラスター内の既存の 1 つまたは複数のゾーンにワーカー・ノードを追加できます。 ゾーンの障害からアプリケーションを保護するには、ゾーンをクラスターに追加します。
{:shortdesc}

クラスターを作成すると、ワーカー・ノードがワーカー・プールにプロビジョンされます。 クラスターの作成後に、さらにワーカー・ノードをプールに追加するには、プールをサイズ変更するか、別のワーカー・プールを追加します。 デフォルトでは、ワーカー・プールは 1 つのゾーン内に存在します。 1 つのゾーン内のみにワーカー・プールがあるクラスターを、単一ゾーン・クラスターと呼びます。 クラスターに別のゾーンを追加すると、ワーカー・プールはそれらのゾーンにまたがって存在します。 複数のゾーン間にワーカー・プールが分散しているクラスターを、複数ゾーン・クラスターと呼びます。

複数ゾーン・クラスターの場合は、そのワーカー・ノードのリソースをバランスが取れた状態に維持してください。 すべてのワーカー・プールが同じゾーン間に分散されていることを確認し、ワーカーの追加/削除を行う場合は、個々のノードを追加するのではなく、プールのサイズを変更してください。
{: tip}

始める前に、[**オペレーター**または**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)があることを確認してください。 次に、以下のいずれかのセクションを選択してください。
  * [クラスター内の既存のワーカー・プールのサイズを変更してワーカー・ノードを追加する](#resize_pool)
  * [ワーカー・プールをクラスターに追加してワーカー・ノードを追加する](#add_pool)
  * [ゾーンをクラスターに追加し、複数のゾーン間でワーカー・プール内のワーカー・ノードを複製する](#add_zone)
  * [非推奨: スタンドアロン・ワーカー・ノードをクラスターに追加する](#standalone)

ワーカー・プールをセットアップしたら、ワークロード・リソース要求に基づいてワーカー・プールにワーカー・ノードを自動的に追加または削除するように[クラスター自動スケーリング機能をセットアップ](/docs/containers?topic=containers-ca#ca)します。
{:tip}

### 既存のワーカー・プールのサイズを変更してワーカー・ノードを追加する
{: #resize_pool}

ワーカー・プールが 1 つのゾーンにあるか複数のゾーン間に分散しているかにかかわらず、既存のワーカー・プールのサイズを変更して、クラスター内のワーカー・ノードの数を追加したり減らしたりできます。
{: shortdesc}

例えば、 1 つのワーカー・プールにゾーンあたり 3 つのワーカー・ノードがあるクラスターについて検討してみましょう。
* クラスターが単一ゾーンで `dal10` にある場合は、ワーカー・プールは `dal10` 内に 3 つのワーカー・ノードを持っています。 クラスターには合計で 3 つのワーカー・ノードがあります。
* クラスターが複数ゾーンで `dal10` と `dal12` にある場合、ワーカー・プールは `dal10` 内に 3 つのワーカー・ノードと `dal12` 内に 3 つのワーカー・ノードを持っています。 クラスターには合計で 6 つのワーカー・ノードがあります。

ベア・メタル・ワーカー・プールの場合は、月単位で課金されることに留意してください。 サイズを変更して増減すると、その月のコストに影響します。
{: tip}

ワーカー・プールのサイズを変更するには、そのワーカー・プールが各ゾーン内にデプロイするワーカー・ノードの数を変更します。

1. サイズ変更するワーカー・プールの名前を取得します。
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. 各ゾーン内にデプロイするワーカー・ノードの数を指定して、ワーカー・プールのサイズを変更します。 最小値は 1 です。
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. ワーカー・プールがサイズ変更されたことを確認します。
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    `dal10` と `dal12` の 2 つのゾーン内にあり、ゾーンあたり 2 つのワーカー・ノードにサイズ変更されるワーカー・プールの出力例:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### 新しいワーカー・プールを作成してワーカー・ノードを追加する
{: #add_pool}

新しいワーカー・プールを作成して、クラスターにワーカー・ノードを追加できます。
{:shortdesc}

1. クラスターの**ワーカー・ゾーン**を取得し、ワーカー・プール内のワーカー・ノードをデプロイするゾーンを選択します。 単一ゾーン・クラスターの場合は、**Worker Zones** フィールドに表示されるゾーンを使用する必要があります。 複数ゾーン・クラスターの場合は、クラスターの既存の**ワーカー・ゾーン**を選択することも、クラスターが存在する地域の[複数ゾーンの大都市ロケーション](/docs/containers?topic=containers-regions-and-zones#zones)のゾーンを追加することもできます。`ibmcloud ks zones` を実行して、使用可能なゾーンをリストできます。
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   出力例:
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. ゾーンごとに、使用可能なプライベート VLAN とパブリック VLAN をリストします。 使用するプライベート VLAN とパブリック VLAN をメモしておきます。 プライベート VLAN やパブリック VLAN がない場合は、ゾーンをワーカー・プールに追加したときに VLAN が自動的に作成されます。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  ゾーンごとに、[ワーカー・ノードで選択可能なマシン・タイプ](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)を確認します。

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. ワーカー・プールを作成します。 ベアメタル・ワーカー・プールをプロビジョンする場合は、`--hardware dedicated` を指定します。
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. ワーカー・プールが作成されたことを確認します。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. デフォルトでは、ワーカー・プールを追加すると、ゾーンのないプールが作成されます。 ワーカー・ノードをゾーン内にデプロイするには、以前に取得したゾーンをワーカー・プールに追加する必要があります。 ワーカー・ノードを複数のゾーン間に分散させる場合は、ゾーンごとにこのコマンドを繰り返します。  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. 追加したゾーンにワーカー・ノードがプロビジョンされたことを確認します。 状況が **provision_pending** から **normal** に変わったら、ワーカー・ノードの準備ができています。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   出力例:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### ゾーンをワーカー・プールに追加してワーカー・ノードを追加する
{: #add_zone}

ゾーンを既存のワーカー・プールに追加して、1 つの地域内の複数のゾーンにクラスターを広げることができます。
{:shortdesc}

ゾーンをワーカー・プールに追加すると、ワーカー・プールで定義されているワーカー・ノードがその新しいゾーンにプロビジョンされ、今後のワークロード・スケジュールの対象に含められます。 {{site.data.keyword.containerlong_notm}} により、地域を表す `failure-domain.beta.kubernetes.io/region` ラベルと、ゾーンを表す `failure-domain.beta.kubernetes.io/zone` ラベルが各ワーク・ノードに自動的に追加されます。 Kubernetes スケジューラーは、これらのラベルを使用して、同じ領域内のゾーン間にポッドを分散させます。

クラスター内に複数のワーカー・プールがある場合は、すべてのプールにゾーンを追加して、ワーカー・ノードがクラスター全体に均等に分散されるようにします。

開始前に、以下のことを行います。
*  ワーカー・プールにゾーンを追加するには、そのワーカー・プールが[複数ゾーン対応ゾーン](/docs/containers?topic=containers-regions-and-zones#zones)内になければなりません。 ワーカー・プールが複数ゾーン対応ゾーン内にない場合は、[新しいワーカー・プールを作成](#add_pool)することを検討してください。
*  1 つのクラスターに複数の VLAN がある場合、同じ VLAN 上に複数のサブネットがある場合、または複数ゾーン・クラスターがある場合は、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。 VRF を有効にするには、[IBM Cloud インフラストラクチャー (SoftLayer) のアカウント担当者に連絡してください](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion)。 VRF の有効化が不可能または不要な場合は、[VLAN スパンニング](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)を有効にしてください。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](/docs/containers?topic=containers-users#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)を使用します。

ゾーンをワーカー・ノードと一緒にワーカー・プールに追加するには、次のようにします。

1. 使用可能なゾーンをリストし、ワーカー・プールに追加するゾーンを選びます。 複数ゾーン対応ゾーンを選ばなければなりません。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. そのゾーン内の使用可能な VLAN をリストします。 プライベート VLAN やパブリック VLAN がない場合は、ゾーンをワーカー・プールに追加したときに VLAN が自動的に作成されます。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. クラスター内のワーカー・プールをリストし、それらの名前をメモします。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. ゾーンをワーカー・プールに追加します。 ワーカー・プールが複数ある場合は、すべてのゾーンでクラスターのバランスが取れるように、すべてのワーカー・プールにゾーンを追加してください。 `<pool1_id_or_name,pool2_id_or_name,...>` を、すべてのワーカー・プールの名前をコンマ区切りで指定したリストに置き換えます。

    複数のワーカー・プールにゾーンを追加するには、その前にプライベート VLAN とパブリック VLAN がなければなりません。 そのゾーン内にプライベート VLAN もパブリック VLAN もない場合は、まず、いずれかのワーカー・プールにゾーンを追加して、プライベート VLAN とパブリック VLAN が作成されるようにしてください。 その後、作成されたプライベート VLAN とパブリック VLAN を指定して、他のワーカー・プールにゾーンを追加できます。
    {: note}

   ワーカー・プールごとに別の VLAN を使用する場合は、このコマンドを VLAN とその対応するワーカー・プールごとに繰り返します。 指定した VLAN に新しいワーカー・ノードが追加されますが、既存のワーカー・ノードの VLAN は変更されません。
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. ゾーンがクラスターに追加されたことを確認します。 出力の **Worker zones** フィールド内で、追加したゾーンを探します。 追加したゾーンに新しいワーカー・ノードがプロビジョンされたため、**Workers** フィールド内のワーカーの合計数が増えていることに注意してください。
  ```
  ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  出力例:
  ```
  Name:                           mycluster
ID:                             df253b6025d64944ab99ed63bb4567b6
State:                          normal
Created:                        2018-09-28T15:43:15+0000
Location:                       dal10
Master URL:                     https://c3.<region>.containers.cloud.ibm.com:30426
Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
Master Location:                Dallas
Master Status:                  Ready (21 hours ago)
Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
Ingress Secret:                 mycluster
Workers:                        6
Worker Zones:                   dal10, dal12
Version:                        1.11.3_1524
Owner:                          owner@email.com
Monitoring Dashboard:           ...
Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
Resource Group Name:            Default
  ```
  {: screen}  

### 非推奨: スタンドアロン・ワーカー・ノードを追加する
{: #standalone}

ワーカー・プールが導入される前に作成されたクラスターがある場合は、非推奨のコマンドを使用してスタンドアロン・ワーカー・ノードを追加できます。
{: deprecated}

ワーカー・プールが導入された後にクラスターが作成された場合は、スタンドアロン・ワーカー・ノードを追加できません。 代わりに、[ワーカー・プールを作成する](#add_pool)か、[既存のワーカー・プールのサイズを変更する](#resize_pool)か、または[ゾーンをワーカー・プールに追加](#add_zone)して、ワーカー・ノードをクラスターに追加できます。
{: note}

1. 使用可能なゾーンをリストし、ワーカー・ノードを追加するゾーンを選びます。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. そのゾーン内の使用可能な VLAN をリストし、それらの ID をメモします。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. そのゾーン内で使用可能なマシン・タイプをリストします。
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. スタンドアロン・ワーカー・ノードをクラスターに追加します。 ベアメタル・マシン・タイプの場合、`dedicated` を指定します。
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. ワーカー・ノードが作成されたことを確認します。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## クラスターの状態の表示
{: #states}

Kubernetes クラスターの状態を確認して、クラスターの可用性と容量、発生した可能性のある問題に関する情報を取得します。
{:shortdesc}

特定のクラスターに関する情報 (ゾーン、サービス・エンドポイント URL、Ingress サブドメイン、バージョン、所有者、モニター・ダッシュボードなど) を表示するには、`ibmcloud ks cluster-get<cluster_name_or_ID>` [コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)を使用します。 `--showResources` フラグを指定すると、ストレージ・ポッドのアドオンやパブリック IP とプライベート IP のサブネット VLAN など、さらに多くのクラスター・リソースを表示できます。

現在のクラスターの状態を確認するには、`ibmcloud ks clusters` コマンドを実行して **State** フィールドを見つけます。 クラスターとワーカー・ノードのトラブルシューティングを行うには、[クラスターのトラブルシューティング ](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters)を参照してください。

<table summary="表の行はすべて左から右に読みます。1 列目はクラスターの状態、2 列目は説明です。">
<caption>クラスターの状態</caption>
   <thead>
   <th>クラスターの状態</th>
   <th>説明</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>Kubernetes マスターがデプロイされる前にユーザーからクラスターの削除が要求されました。 クラスターの削除が完了すると、クラスターはダッシュボードから除去されます。 クラスターが長時間この状態になっている場合は、[{{site.data.keyword.Bluemix_notm}} サポート・ケース](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)を開いてください。</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>Kubernetes マスターにアクセスできないか、クラスター内のワーカー・ノードがすべてダウンしています。 </td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>Kubernetes マスターまたは 1 つ以上のワーカー・ノードを削除できません。  </td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>クラスターは削除されましたが、まだダッシュボードからは除去されていません。 クラスターが長時間この状態になっている場合は、[{{site.data.keyword.Bluemix_notm}} サポート・ケース](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)を開いてください。 </td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>クラスターの削除とクラスター・インフラストラクチャーの破棄を実行中です。 クラスターにアクセスできません。  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>Kubernetes マスターのデプロイメントを完了できませんでした。 この状態はお客様には解決できません。 [{{site.data.keyword.Bluemix_notm}} サポート・ケース](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)を開いて、IBM Cloud サポートに連絡してください。</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Kubernetes マスターがまだ完全にデプロイされていません。 クラスターにアクセスできません。 クラスターが完全にデプロイされるまで待ってからクラスターの正常性を確認してください。</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>クラスター内のすべてのワーカー・ノードが稼働中です。 クラスターにアクセスし、アプリをクラスターにデプロイできます。 この状態は正常と見なされるので、アクションは必要ありません。<p class="note">ワーカー・ノードは正常であっても、[ネットワーキング](/docs/containers?topic=containers-cs_troubleshoot_network)や[ストレージ](/docs/containers?topic=containers-cs_troubleshoot_storage)などの他のインフラストラクチャー・リソースには注意が必要な可能性もあります。 クラスターの作成直後は、Ingress シークレットやレジストリー・イメージ・プル・シークレットなど、他のサービスによって使用されるクラスターの一部が、まだ処理中である場合があります。</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Kubernetes マスターはデプロイされています。 ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。 クラスターにはアクセスできますが、アプリをクラスターにデプロイすることはできません。  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>クラスターを作成し、Kubernetes マスターとワーカー・ノードのインフラストラクチャーを注文するための要求が送信されました。 クラスターのデプロイメントが開始されると、クラスターの状態は「<code>Deploying</code>」に変わります。 クラスターが長時間「<code>Requested</code>」状態になっている場合は、[{{site.data.keyword.Bluemix_notm}} サポート・ケース](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)を開いてください。 </td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>Kubernetes マスターで実行される Kubernetes API サーバーが、新しい Kubernetes API バージョンに更新されています。 更新中、クラスターにアクセスすることも変更することもできません。 ユーザーがデプロイしたワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。 更新が完了するまで待ってから、クラスターの正常性を確認してください。 </td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>クラスター内の 1 つ以上のワーカー・ノードが使用不可です。ただし、他のワーカー・ノードが使用可能であるため、ワークロードを引き継ぐことができます。 </td>
    </tr>
   </tbody>
 </table>


<br />


## クラスターの削除
{: #remove}

有料アカウントで作成したフリー・クラスターと標準クラスターが不要になったら、リソースが消費されないように手動で削除する必要があります。
{:shortdesc}

<p class="important">
永続ストレージ内のクラスターやデータのバックアップは作成されません。 クラスターを削除するときに、永続ストレージも削除することができます。 永続ストレージを削除する場合、`delete` ストレージ・クラスを使用してプロビジョンした永続ストレージは、IBM Cloud インフラストラクチャー (SoftLayer) で完全に削除されます。 `retain` ストレージ・クラスを使用してプロビジョンした永続ストレージを削除する場合、クラスター、PV、および PVC は削除されますが、IBM Cloud インフラストラクチャー (SoftLayer) アカウント内の永続ストレージ・インスタンスは残ります。</br>
</br>クラスターを削除するときには、クラスターの作成時に自動的にプロビジョニングされたサブネットと、`ibmcloud ks cluster-subnet-create` コマンドを使用して作成したサブネットもすべて削除します。 ただし、`ibmcloud ks cluster-subnet-add コマンド`を使用して既存のサブネットをクラスターに手動で追加した場合、これらのサブネットは IBM Cloud インフラストラクチャー (SoftLayer) アカウントから削除されず、他のクラスターで再利用できます。</p>

開始前に、以下のことを行います。
* クラスター ID をメモします。 クラスターで自動的に削除されない IBM Cloud インフラストラクチャー (SoftLayer) 関連リソースを調査および削除するために、クラスター ID が必要になる場合があります。
* 永続ストレージ内のデータを削除する場合は、[削除オプションについて理解します](/docs/containers?topic=containers-cleanup#cleanup)。
* [**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)があることを確認してください。

クラスターを削除するには、以下のようにします。

-   {{site.data.keyword.Bluemix_notm}} コンソールから
    1.  クラスターを選択して、**「その他のアクション...」**メニューから**「削除」**をクリックします。

-   {{site.data.keyword.Bluemix_notm}} CLI から
    1.  使用可能なクラスターをリストします。

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  クラスターを削除します。

        ```
        ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3.  プロンプトに従って、コンテナー、ポッド、バインドされたサービス、永続ストレージ、およびシークレットを含むクラスター・リソースを削除するかどうかを選択します。
      - **永続ストレージ**: 永続ストレージでは、データの高可用性を確保できます。 [既存のファイル共有](/docs/containers?topic=containers-file_storage#existing_file)を使用して永続ボリューム請求を作成した場合は、クラスターを削除するときにファイル共有を削除できません。 このファイル共有は後で IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオから手動で削除する必要があります。

          毎月の課金サイクルの規定で、永続ボリューム請求を月の最終日に削除することはできません。 永続ボリューム請求を月の末日に削除した場合、削除は翌月初めまで保留状態になります。
          {: note}

次のステップ:
- 削除したクラスターの名前は、`ibmcloud ks clusters` コマンドを実行しても使用可能なクラスターのリストに表示されなくなったら、再利用できます。
- サブネットを残した場合は、[それらを新しいクラスターで再利用](/docs/containers?topic=containers-subnets#subnets_custom)することも、後で IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオから手動で削除することもできます。
- 永続ストレージを残した場合は、後で {{site.data.keyword.Bluemix_notm}} コンソールの IBM Cloud インフラストラクチャー (SoftLayer) ダッシュボードを使用して[ストレージを削除](/docs/containers?topic=containers-cleanup#cleanup)できます。
