---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

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

# クラスター・ネットワークのセットアップ
{: #cs_network_cluster}

{{site.data.keyword.containerlong}} クラスターにネットワーク構成をセットアップします。
{:shortdesc}

このページには、クラスターのネットワーク構成をセットアップするときに役立つ情報を記載します。 どのセットアップを選べばよいかわからない場合は、 [クラスター・ネットワークの計画](/docs/containers?topic=containers-cs_network_ov)を参照してください。
{: tip}

## パブリック VLAN およびプライベート VLAN を使用するクラスター・ネットワークのセットアップ
{: #both_vlans}

[パブリック VLAN およびプライベート VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options) にアクセスできるクラスターをセットアップします。
{: shortdesc}

このネットワークをセットアップするには、クラスター作成時に以下の必須のネットワーク構成を設定し、クラスター作成後にオプションのネットワーク構成を設定します。

1. ファイアウォールの内側の環境にクラスターを作成する場合は、使用する予定の {{site.data.keyword.Bluemix_notm}} サービスの[パブリック IP およびプライベート IP へのアウトバウンド・ネットワーク・トラフィック](/docs/containers?topic=containers-firewall#firewall_outbound)を許可します。

2. パブリック VLAN とプライベート VLAN に接続されるクラスターを作成します。 複数ゾーン・クラスターを作成する場合は、ゾーンごとに VLAN のペアを選択できます。

3. Kubernetes マスターとワーカー・ノードの通信方法を選択します。
  * {{site.data.keyword.Bluemix_notm}} アカウントの VRF が有効になっている場合は、[パブリックのみ](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)、[パブリックとプライベート](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)、または [プライベートのみ](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)のサービス・エンドポイントを有効にします。
  * VRF の有効化が不可能または不要な場合は、[パブリック・サービス・エンドポイントのみ](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)を有効にし、[VLAN スパンニングを有効にします](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。

4. クラスターを作成したら、以下のネットワーク・オプションを構成できます。
  * [strongSwan VPN 接続サービス](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public)をセットアップして、クラスターとオンプレミスのネットワークまたは {{site.data.keyword.icpfull_notm}} との通信を許可する。
  * [Kubernetes ディスカバリー・サービス](/docs/containers?topic=containers-cs_network_planning#in-cluster)を作成して、ポッド間のクラスター内部通信を許可する。
  * [パブリック](/docs/containers?topic=containers-cs_network_planning#public_access)・ネットワーク・ロード・バランサー (NLB)、Ingress アプリケーション・ロード・バランサー (ALB)、または NodePort サービスを作成して、アプリをパブリック・ネットワークで公開する。
  * [プライベート](/docs/containers?topic=containers-cs_network_planning#private_both_vlans)・ネットワーク・ロード・バランサー (NLB)、Ingress アプリケーション・ロード・バランサー (ALB)、または NodePort サービスを作成してアプリをプライベート・ネットワークで公開し、Calico ネットワーク・ポリシーを作成してパブリック・アクセスからクラスターを保護する。
  * ネットワーク・ワークロードを[エッジ・ワーカー・ノード](#both_vlans_private_edge)に分離する。
  * [プライベート・ネットワーク上でクラスターを分離する](#isolate)。

<br />


## プライベート VLAN のみを使用するクラスター・ネットワークのセットアップ
{: #setup_private_vlan}

固有のセキュリティー要件がある場合や、専用ネットワークのセキュリティーを装備するためにカスタムのネットワーク・ポリシーやルーティング・ルールを作成する必要がある場合は、[プライベート VLAN のみ](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options)にアクセスできるクラスターをセットアップします。
{: shortdesc}

このネットワークをセットアップするには、クラスター作成時に以下の必須のネットワーク構成を設定し、クラスター作成後にオプションのネットワーク構成を設定します。

1. ファイアウォールの内側の環境にクラスターを作成する場合は、使用する予定の {{site.data.keyword.Bluemix_notm}} サービスの[パブリック IP およびプライベート IP へのアウトバウンド・ネットワーク・トラフィック](/docs/containers?topic=containers-firewall#firewall_outbound)を許可します。

2. [プライベート VLAN のみ](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options)に接続するクラスターを作成します。 複数ゾーン・クラスターを作成する場合は、ゾーンごとにプライベート VLAN を選択できます。

3. Kubernetes マスターとワーカー・ノードの通信方法を選択します。
  * {{site.data.keyword.Bluemix_notm}} アカウントの VRF が有効になっている場合は、[プライベート・サービス・エンドポイントを有効にします](#set-up-private-se)。
  * VRF を有効にできない、またはしたくない場合、そのままでは Kubernetes マスター・ノードとワーカー・ノードは接続できません。 [ゲートウェイ・アプライアンス](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private)をクラスターに構成する必要があります。

4. クラスターを作成したら、以下のネットワーク・オプションを構成できます。
  * [VPN ゲートウェイをセットアップ](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private)して、クラスターとオンプレミスのネットワークまたは {{site.data.keyword.icpfull_notm}} との通信を許可する。 マスター・ノードとワーカー・ノードの通信を許可するために既に VRA (Vyatta) または FSA をセットアップしている場合は、その VRA または FSA に IPSec VPN エンドポイントを構成できます。
  * [Kubernetes ディスカバリー・サービス](/docs/containers?topic=containers-cs_network_planning#in-cluster)を作成して、ポッド間のクラスター内部通信を許可する。
  * [プライベート](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan)・ネットワーク・ロード・バランサー (NLB)、 Ingress アプリケーション・ロード・バランサー (ALB)、または NodePort サービスを作成して、アプリをプライベート・ネットワークで公開する。
  * ネットワーク・ワークロードを[エッジ・ワーカー・ノード](#both_vlans_private_edge)に分離する。
  * [プライベート・ネットワーク上でクラスターを分離する](#isolate)。

<br />


## ワーカー・ノードの VLAN 接続を変更する
{: #change-vlans}

クラスター作成時に、ワーカー・ノードをプライベート VLAN とパブリック VLAN に接続するか、それともプライベート VLAN にのみ接続するかを選択します。 ワーカー・ノードはワーカー・プールの一部であり、ワーカー・プールには、そのプールで将来のワーカー・ノードをプロビジョンするときに使用する VLAN などのネットワーク・メタデータが保管されます。 以下のようなケースでは、クラスターの VLAN 接続セットアップを後から変更しなければなりません。
{: shortdesc}

* ゾーンのワーカー・プールの VLAN が不足してきたので、クラスター・ワーカー・ノード用に新しい VLAN をプロビジョンする必要がある。
* クラスターのワーカー・ノードがパブリック VLAN とプライベート VLAN の両方に接続しているが、[プライベート専用クラスター](#setup_private_vlan)に変更したい。
* プライベート専用クラスターであるが、パブリック VLAN に接続した[エッジ・ノード](/docs/containers?topic=containers-edge#edge)のワーカー・プールなど、一部のワーカー・ノードでアプリをインターネットに公開したい。

代わりに、マスター対ワーカーの通信用のサービス・エンドポイントを変更できませんか? [パブリック・サービス・エンドポイント](#set-up-public-se)と [プライベート](#set-up-private-se)・サービス・エンドポイントをセットアップするトピックを確認してください。
{: tip}

開始前に、以下のことを行います。
* [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
* スタンドアロンのワーカー・ノード (ワーカー・プールの一部ではないワーカー・ノード) は、[ワーカー・プールに更新します](/docs/containers?topic=containers-update#standalone_to_workerpool)。

ワーカー・ノードをプロビジョンするときにワーカー・プールが使用する VLAN を変更するには、以下の手順を実行します。

1. クラスター内のワーカー・プールの名前をリストします。
  ```
  ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. いずれかのワーカー・プールのゾーンを調べます。 出力中の**「Zones」**フィールドを探します。
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. 前の手順で確認した各ゾーンについて、パブリック VLAN とプライベート VLAN が対応しているものがあるか確認します。

  1. 出力中の**「Type」**の下にリストされているパブリック VLAN とプライベート VLAN を確認します。
     ```
     ibmcloud ks vlans --zone <zone>
     ```
     {: pre}

  2. ゾーンのパブリック VLAN とプライベート VLAN が対応していることを確認します。 対応している VLAN は、**Router** のポッド ID が同じです。 この出力例では、**Router** のポッド ID は `01a` と `01a` であり、一致しています。 ポッド ID の一方が `01a` で、もう一方が `02a` である場合、ワーカー・プールにこれらのパブリック VLAN ID とプライベート VLAN ID を設定することはできません。
     ```
     ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
     ```
     {: screen}

  3. ゾーンに新しいパブリックまたはプライベート VLAN を注文する必要がある場合は、[{{site.data.keyword.Bluemix_notm}} コンソール](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans)または以下のコマンドを使用して注文できます。 前の手順で示したように、プライベート VLAN とパブリック VLAN は、同じ **Router** のポッド ID を持つ、対応した VLAN でなければならないことを忘れないでください。 新しいパブリック VLAN とプライベート VLAN をペアにする場合は、それらの VLAN が対応していなければなりません。
     ```
     ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
     ```
     {: pre}

  4. 対応している VLAN の ID をメモします。

4. ゾーンごとに、新しい VLAN ネットワーク・メタデータをワーカー・プールにセットアップします。 ワーカー・プールを新規作成することも、既存のワーカー・プールを変更することもできます。

  * **ワーカー・プールを新規作成する**: [ワーカー・プールを新規作成してワーカー・ノードを追加する](/docs/containers?topic=containers-clusters#add_pool)を参照してください。

  * **既存のワーカー・プールを変更する**: ゾーンごとに特定の VLAN を使用するようにワーカー・プールのネットワーク・メタデータを設定します。 プール内に既に作成されているワーカー・ノードは前の VLAN を使用し続けますが、プール内の新しいワーカー・ノードは、設定した新しい VLAN メタデータを使用します。

    * パブリック VLAN とプライベート VLAN の両方を追加する例 (プライベートのみの環境からプライベートとパブリックの両方の環境に変更する場合など)
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * プライベート VLAN のみを追加する例 ([VRF を有効にしたアカウントで複数のサービス・エンドポイントを使用している場合](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)に、パブリックとプライベートの両方の VLAN からプライベートのみの VLAN に変更する場合など)
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. プールのサイズを変更して、ワーカー・ノードをワーカー・プールに追加します。
   ```
   ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

   前のネットワーク・メタデータを使用するワーカー・ノードを削除するには、ゾーンごとのワーカー数を変更して、前のゾーンごとのワーカー数の 2 倍になるようにします。 この手順の後半に、前のワーカー・ノードを閉鎖、排出、そして削除できます。
  {: tip}

6. 出力で、適切な **パブリック IP** と **プライベート IP** を持つ新しいワーカー・ノードが作成されていることを確認します。 例えば、パブリックとプライベートの両方の VLAN からプライベートのみの VLAN にワーカー・プールを変更した場合は、新しいワーカー・ノードはプライベート IP のみを持ちます。 ワーカー・プールをプライベートのみの VLAN からパブリックとプライベートの両方の VLAN に変更した場合は、新しいワーカー・ノードはパブリック IP とプライベート IP の両方を持ちます。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

7. オプション: 前のネットワーク・メタデータを使用しているワーカー・ノードをワーカー・プールから削除します。
  1. 前の手順の出力から、ワーカー・プールから削除するワーカー・ノードの **ID** と **プライベート IP** をメモします。
  2. 閉鎖と呼ばれるプロセスで、ワーカー・ノードにスケジュール不能のマークを付けます。 閉鎖したワーカー・ノードは、それ以降のポッドのスケジューリングに使用できなくなります。
     ```
     kubectl cordon <worker_private_ip>
     ```
     {: pre}
  3. ワーカー・ノードでポッドのスケジューリングが無効になっていることを確認します。
     ```
     kubectl get nodes
     ```
     {: pre}
     状況に **`SchedulingDisabled`** と表示された場合、ワーカー・ノードのポッドのスケジューリングは無効になっています。
  4. ポッドをワーカー・ノードから強制的に削除し、クラスター内の残りのワーカー・ノードにスケジュールを変更します。
     ```
     kubectl drain <worker_private_ip>
     ```
     {: pre}
     この処理には数分かかる場合があります。
  5. ワーカー・ノードを削除します。 前に取得したワーカー ID を使用します。
     ```
     ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
     ```
     {: pre}
  6. ワーカー・ノードが削除されたことを確認します。
     ```
     ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
     ```
     {: pre}

8. オプション: クラスター内の各ワーカー・プールについて、手順 2 から 7 までを繰り返すことができます。 これらの手順が完了すると、クラスター内のすべてのワーカー・ノードに新しい VLAN がセットアップされます。

<br />


## プライベート・サービス・エンドポイントのセットアップ
{: #set-up-private-se}

Kubernetes バージョン 1.11 以降を実行するクラスターでは、クラスターのプライベート・サービス・エンドポイントを有効/無効にできます。
{: shortdesc}

プライベート・サービス・エンドポイントがあれば、Kubernetes マスターにプライベートからアクセスできます。 ワーカー・ノードと許可されたクラスター・ユーザーは、プライベート・ネットワーク経由で Kubernetes マスターと通信できます。 プライベート・サービス・エンドポイントを有効にできるかどうかを調べるには、 [マスター対ワーカーの通信の計画](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)を参照してください。 プライベート・サービス・エンドポイントは、いったん有効にしたら無効にすることはできないので注意してください。

**クラスター作成時に有効にする手順**</br>
1. ご使用の IBM Cloud インフラストラクチャー (SoftLayer) アカウントで [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にします。
2. [{{site.data.keyword.Bluemix_notm}} アカウントでサービス・エンドポイントを使用できるようにします](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
3. ファイアウォールの内側の環境にクラスターを作成する場合は、使用する予定のインフラストラクチャー・リソースや {{site.data.keyword.Bluemix_notm}} サービスの[パブリック IP およびプライベート IP へのアウトバウンド・トラフィックを許可](/docs/containers?topic=containers-firewall#firewall_outbound)します。
4. クラスターを作成します。
  * [CLIを使用してクラスターを作成し、](/docs/containers?topic=containers-clusters#clusters_cli)`--private-service-endpoint` フラグを使用します。 パブリック・サービス・エンドポイントも有効にする場合は、`--public-service-endpoint` フラグも使用します。
  * [UI でクラスターを作成し、](/docs/containers?topic=containers-clusters#clusters_ui_standard)**「プライベート・エンドポイントのみ (Private endpoint only)」**を選択します。 パブリック・サービス・エンドポイントも有効にする場合は、**「パブリック・エンドポイントとプライベート・エンドポイント (Both private & public endpoints)」**を選択します。
5. ファイアウォールの内側の環境のクラスターに対してプライベート・サービス・エンドポイントのみを有効にする場合:
  1. {{site.data.keyword.Bluemix_notm}} プライベート・ネットワークの中で作業していること、または、VPN 接続経由でプライベート・ネットワークに接続していることを確認します。
  2. [許可されたクラスター・ユーザーに対して、`kubectl` コマンドの実行を許可し](/docs/containers?topic=containers-firewall#firewall_kubectl)、プライベート・サービス・エンドポイントを介してマスターにアクセスできるようにします。 `kubectl` コマンドを実行するクラスター・ユーザーは、{{site.data.keyword.Bluemix_notm}} プライベート・ネットワークの中で作業しているか、VPN 接続経由でプライベート・ネットワークに接続している必要があります。
  3. ネットワーク・アクセスが会社のファイアウォールによって保護されている場合は、[ファイアウォールで `ibmcloud` API および `ibmcloud ks` API のパブリック・エンドポイントへのアクセスを許可する](/docs/containers?topic=containers-firewall#firewall_bx)必要があります。 マスターへのすべての通信はプライベート・ネットワークを経由しますが、`ibmcloud` コマンドと `ibmcloud ks` コマンドはパブリック API エンドポイントを経由する必要があります。

  </br>

**クラスター作成後に有効にする手順**</br>
1. ご使用の IBM Cloud インフラストラクチャー (SoftLayer) アカウントで [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にします。
2. [{{site.data.keyword.Bluemix_notm}} アカウントでサービス・エンドポイントを使用できるようにします](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
3. プライベート・サービス・エンドポイントを有効にします。
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
4. プライベート・サービス・エンドポイントを使用するには、Kubernetes マスター API サーバーをリフレッシュします。 CLI のプロンプトに従うか、または以下のコマンドを手動で実行します。
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}

5. 一度に使用不可にできるクラスター内のワーカー・ノードの最大数を制御する[構成マップを作成](/docs/containers?topic=containers-update#worker-up-configmap)します。 この構成マップによって、ワーカー・ノードを更新するときに、使用可能なワーカー・ノードに順番にアプリが再スケジュールされるので、アプリのダウン時間の発生を回避できます。
6. クラスター内のすべてのワーカー・ノードを更新して、プライベート・サービス・エンドポイント構成を反映させます。

   <p class="important">update コマンドを発行することで、ワーカー・ノードが再ロードされてサービス・エンドポイント構成が反映されます。 ワーカーを更新できない場合は、[手動でワーカー・ノードを再ロードする](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)必要があります。 再ロードする場合は、一度に使用不可にできるワーカー・ノードの最大数を制御するために、ワーカー・ノードの閉鎖、排出、順番の管理を確実に行ってください。</p>
   ```
   ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
   ```
   {: pre}

8. クラスターがファイアウォールの内側の環境にある場合:
  * [許可されたクラスター・ユーザーに対して、`kubectl` コマンドの実行を許可し、プライベート・サービス・エンドポイントを介してマスターにアクセスできるようにします。](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * 使用する予定のインフラストラクチャー・リソースや {{site.data.keyword.Bluemix_notm}} サービスの[プライベート IP へのアウトバウンド・ネットワーク・トラフィックを許可](/docs/containers?topic=containers-firewall#firewall_outbound)します。

9. オプション: プライベート・サービス・エンドポイントのみを使用するには、パブリック・サービス・エンドポイントを無効にします。
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
  </br>

**無効にする手順**</br>
プライベート・サービス・エンドポイントは無効にできません。

## パブリック・サービス・エンドポイントのセットアップ
{: #set-up-public-se}

クラスターのパブリック・サービス・エンドポイントを有効または無効にします。
{: shortdesc}

パブリック・サービス・エンドポイントがあれば、Kubernetes マスターにパブリックからアクセスできます。 ワーカー・ノードと許可されたクラスター・ユーザーは、パブリック・ネットワークを介して Kubernetes マスターと安全に通信できます。 パブリック・サービス・エンドポイントを有効にできるかどうかを調べるには、[ワーカー・ノードと Kubernetes マスターの通信の計画](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)を参照してください。

**クラスター作成時に有効にする手順**</br>

1. ファイアウォールの内側の環境にクラスターを作成する場合は、使用する予定の {{site.data.keyword.Bluemix_notm}} サービスの[パブリック IP およびプライベート IP へのアウトバウンド・ネットワーク・トラフィック](/docs/containers?topic=containers-firewall#firewall_outbound)を許可します。

2. クラスターを作成します。
  * [CLI を使用してクラスターを作成し、](/docs/containers?topic=containers-clusters#clusters_cli)`--public-service-endpoint` フラグを使用します。 プライベート・サービス・エンドポイントも有効にする場合は、`--private-service-endpoint` フラグも使用します。
  * [UI でクラスターを作成し、](/docs/containers?topic=containers-clusters#clusters_ui_standard)**「パブリック・エンドポイントのみ (Public endpoint only)」**を選択します。 プライベート・サービス・エンドポイントも有効にする場合は、**「パブリック・エンドポイントとプライベート・エンドポイント (Both private & public endpoints)」**を選択します。

3. ファイアウォールの内側の環境にクラスターを作成する場合は、[許可されたクラスター・ユーザーに対して `kubectl` コマンドの実行を許可し、パブリック・サービス・エンドポイントからのみマスターにアクセスできるようにするか、またはパブリックとプライベートの両方のサービス・エンドポイントからマスターにアクセスできるようにします。](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

**クラスター作成後に有効にする手順**</br>
パブリック・エンドポイントを無効にした場合は、後で再び有効にすることができます。
1. パブリック・サービス・エンドポイントを有効にします。
   ```
   ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
2. パブリック・サービス・エンドポイントを使用するには、Kubernetes マスター API サーバーをリフレッシュします。 CLI のプロンプトに従うか、または以下のコマンドを手動で実行します。
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}

   </br>

**無効にする手順**</br>
パブリック・サービス・エンドポイントを無効にするには、まず、ワーカー・ノードが Kubernetes マスターと通信できるように、プライベート・サービス・エンドポイントを有効にする必要があります。
1. プライベート・サービス・エンドポイントを有効にします。
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
2. プライベート・サービス・エンドポイントを使用するには、CLI プロンプトに従うか、または以下のコマンドを手動で実行して、Kubernetes マスター API サーバーをリフレッシュします。
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}
3. 一度に使用不可にできるクラスター内のワーカー・ノードの最大数を制御する[構成マップを作成](/docs/containers?topic=containers-update#worker-up-configmap)します。 この構成マップによって、ワーカー・ノードを更新するときに、使用可能なワーカー・ノードに順番にアプリが再スケジュールされるので、アプリのダウン時間の発生を回避できます。

4. クラスター内のすべてのワーカー・ノードを更新して、プライベート・サービス・エンドポイント構成を反映させます。

   <p class="important">update コマンドを発行することで、ワーカー・ノードが再ロードされてサービス・エンドポイント構成が反映されます。 ワーカーを更新できない場合は、[手動でワーカー・ノードを再ロードする](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)必要があります。 再ロードする場合は、一度に使用不可にできるワーカー・ノードの最大数を制御するために、ワーカー・ノードの閉鎖、排出、順番の管理を確実に行ってください。</p>
   ```
   ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
   ```
  {: pre}
5. パブリック・サービス・エンドポイントを無効にします。
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}

## パブリック・サービス・エンドポイントからプライベート・サービス・エンドポイントへの切り替え
{: #migrate-to-private-se}

Kubernetes バージョン 1.11 以降を実行するクラスターでは、プライベート・サービス・エンドポイントを有効にして、ワーカー・ノードにパブリック・ネットワークではなくプライベート・ネットワーク経由でマスターと通信させることができます。
{: shortdesc}

パブリック VLAN およびプライベート VLAN に接続しているすべてのクラスターは、デフォルトでは、パブリック・サービス・エンドポイントを使用します。 ワーカー・ノードと許可されたクラスター・ユーザーは、パブリック・ネットワークを介して Kubernetes マスターと安全に通信できます。 ワーカー・ノードにパブリック・ネットワークではなくプライベート・ネットワーク経由で Kubernetes マスターと通信させるには、プライベート・サービス・エンドポイントを有効にします。 その後に、任意でパブリック・サービス・エンドポイントを無効にできます。
* プライベート・サービス・エンドポイントを有効にし、パブリック・サービス・エンドポイントも有効にしたままの場合、ワーカーは常にプライベート・ネットワーク経由でマスターと通信します。一方、ユーザーはパブリックとプライベートのどちらのネットワーク経由でもマスターと通信できます。
* プライベート・サービス・エンドポイントを有効にし、パブリック・サービス・エンドポイントを無効にした場合、ワーカーとユーザーはプライベート・ネットワーク経由でマスターと通信しなければなりません。

プライベート・サービス・エンドポイントは、いったん有効にしたら無効にすることはできないので注意してください。

1. ご使用の IBM Cloud インフラストラクチャー (SoftLayer) アカウントで [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にします。
2. [{{site.data.keyword.Bluemix_notm}} アカウントでサービス・エンドポイントを使用できるようにします](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
3. プライベート・サービス・エンドポイントを有効にします。
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
4. プライベート・サービス・エンドポイントを使用するには、CLI プロンプトに従うか、または以下のコマンドを手動で実行して、Kubernetes マスター API サーバーをリフレッシュします。
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}
5. 一度に使用不可にできるクラスター内のワーカー・ノードの最大数を制御する[構成マップを作成](/docs/containers?topic=containers-update#worker-up-configmap)します。 この構成マップによって、ワーカー・ノードを更新するときに、使用可能なワーカー・ノードに順番にアプリが再スケジュールされるので、アプリのダウン時間の発生を回避できます。

6.  クラスター内のすべてのワーカー・ノードを更新して、プライベート・サービス・エンドポイント構成を反映させます。

    <p class="important">update コマンドを発行することで、ワーカー・ノードが再ロードされてサービス・エンドポイント構成が反映されます。 ワーカーを更新できない場合は、[手動でワーカー・ノードを再ロードする](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)必要があります。 再ロードする場合は、一度に使用不可にできるワーカー・ノードの最大数を制御するために、ワーカー・ノードの閉鎖、排出、順番の管理を確実に行ってください。</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. オプション: パブリック・サービス・エンドポイントを無効にします。
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## オプション: ネットワーク・ワークロードをエッジ・ワーカー・ノードに分離する
{: #both_vlans_private_edge}

エッジ・ワーカー・ノードを使用すると、外部的にアクセスされるワーカー・ノードの数を減らし、ネットワークのワークロードを分離することができるので、クラスターのセキュリティーが改善されます。 指定したワーカー・ノードにのみネットワーク・ロード・バランサー (NLB) ポッドと Ingress アプリケーション・ロード・バランサー (ALB) ポッドがデプロイされるようにするには、[ワーカー・ノードにエッジ・ノードのラベルを付けます](/docs/containers?topic=containers-edge#edge_nodes)。 他のワークロードをエッジ・ノードで実行しないようにするには、[エッジ・ノードにテイントを適用します](/docs/containers?topic=containers-edge#edge_workloads)。
{: shortdesc}

クラスターをパブリック VLAN に接続しているけれども、エッジ・ワーカー・ノード上のパブリック NodePorts へのトラフィックをブロックしたい場合は、 [Calico preDNAT ネットワーク・ポリシー](/docs/containers?topic=containers-network_policies#block_ingress)も使用できます。 ノード・ポートをブロックすることにより、エッジ・ワーカー・ノードだけが着信トラフィックを扱うワーカー・ノードとなります。

## オプション: プライベート・ネットワーク上のクラスターを分離する
{: #isolate}

複数ゾーン・クラスター、単一ゾーン・クラスター用の複数 VLAN、または同じ VLAN 上に複数のサブネットがある場合、[VLAN スパンニングを有効](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)にするか、または [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にして、プライベート・ネットワークによるワーカー・ノードの相互通信を可能にする必要があります。 ただし、VLAN スパンニングまたは VRF が有効になっている場合、同じ IBM Cloud アカウント内のいずれかのプライベート VLAN に接続されているすべてのシステムはワーカーにアクセスできます。 [Calico ネットワーク・ポリシー](/docs/containers?topic=containers-network_policies#isolate_workers)を使用して、プライベート・ネットワーク上の他のシステムから複数ゾーン・クラスターを分離できます。 このポリシーでは、プライベート・ファイアウォールで開いたプライベート IP 範囲およびポートの着信および発信も許可されます。
{: shortdesc}
