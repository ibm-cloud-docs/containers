---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスター内でのデータの保存
{: #storage}
クラスター内のコンポーネントの障害に備えるため、また、アプリ・インスタンス間でデータを共有するために、データを保持できます。

## 可用性の高いストレージの計画
{: #planning}

{{site.data.keyword.containerlong_notm}} では、アプリ・データを保管してクラスター内のポッド間でデータを共有する方法として、複数の選択肢 (オプション) の中から選択することができます。ただし、どのストレージ・オプションでも、クラスター内のコンポーネントの障害またはサイト全体の障害に対して同じレベルの永続性と可用性が得られるというわけではありません。
{: shortdesc}

### 非永続のデータ・ストレージ・オプション
{: #non_persistent}

クラスター内のコンポーネントの障害時にデータをリカバリーするためにデータを永続的に保管する必要がない場合、または、アプリ・インスタンス間でデータを共有する必要がない場合は、非永続ストレージ・オプションを使用できます。アプリ・コンポーネントの単体テストを行う場合や新機能を試す場合にも非永続ストレージ・オプションを使用できます。
{: shortdesc}

以下のイメージは、{{site.data.keyword.containerlong_notm}} で使用可能な非永続データ・ストレージ・オプションを示しています。これらの方法は、フリー・クラスターと標準クラスターで使用可能です。
<p>
<img src="images/cs_storage_nonpersistent.png" alt="非永続データ・ストレージ・オプション" width="450" style="width: 450px; border-style: none"/></p>

<table summary="この表は非永続ストレージ・オプションを示しています。行は左から右に読みます。1 列目はオプションの番号、2 列目はオプションの名称、3 列目は説明です。" style="width: 100%">
<colgroup>
       <col span="1" style="width: 5%;"/>
       <col span="1" style="width: 20%;"/>
       <col span="1" style="width: 75%;"/>
    </colgroup>
  <thead>
  <th>#</th>
  <th>オプション</th>
  <th>説明</th>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>コンテナーまたはポッドの内部</td>
      <td>設計上、コンテナーやポッドの存続期間は短く、予期せぬ障害が起こることがあります。ただし、コンテナーのローカル・ファイル・システムにデータを書き込み、コンテナーのライフサイクルにわたってデータを保管することはできます。コンテナー内部のデータは、他のコンテナーやポッドと共有できず、コンテナーがクラッシュしたり削除されたりすると失われます。詳しくは、[Storing data in a container](https://docs.docker.com/storage/) を参照してください。</td>
    </tr>
  <tr>
    <td>2</td>
    <td>ワーカー・ノード上</td>
    <td>すべてのワーカー・ノードのセットアップには 1 次ストレージと 2 次ストレージがあり、これはワーカー・ノードとして選択したマシン・タイプによって決まります。1 次ストレージは、オペレーティング・システムのデータの保管に使用され、ユーザーはアクセスできません。2 次ストレージは、すべてのコンテナー・データが書き込まれる <code>/var/lib/docker</code> ディレクトリー内のデータの保管に使用されます。<br/><br/>ワーカー・ノードの 2 次ストレージにアクセスするには、<code>/emptyDir</code> ボリュームを作成します。この空のボリュームはクラスター内のポッドに割り当てられるので、そのポッド内のコンテナーはこのボリュームに対して読み取りと書き込みを行うことができます。ボリュームは特定の 1 つのポッドに割り当てられるので、レプリカ・セット内の他のポッドとデータを共有することはできません。<br/><p><code>/emptyDir</code> ボリュームとそのデータは、以下の場合に削除されます。<ul><li>割り当てられたポッドはワーカー・ノードから永久に削除されます。</li><li>割り当てられたポッドが別のワーカー・ノード上にスケジュールされた場合。</li><li>ワーカー・ノードが再ロードされた、または更新された場合。</li><li>ワーカー・ノードが削除された場合。</li><li>クラスターが削除された場合。</li><li>{{site.data.keyword.Bluemix_notm}} アカウントが一時停止状態になった場合。</li></ul></p><p><strong>注:</strong> ポッド内のコンテナーがクラッシュした場合でも、ボリューム内のデータはワーカー・ノードで引き続き使用できます。</p><p>詳しくは、[Kubernetes ボリューム ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/storage/volumes/) を参照してください。</p></td>
    </tr>
    </tbody>
    </table>

### 高可用性のための永続データ・ストレージ・オプション
{: persistent}

可用性の高いステートフル・アプリを作成するための主要な課題は、複数の場所にある複数のアプリ・インスタンスの間でデータを保持し、常にデータの同期を保つことです。高可用性データのために、マスター・データベースの複数のインスタンスを複数のデータ・センターあるいは複数の地域に分散させ、そのマスターのデータを継続的に複製することができます。クラスター内のすべてのインスタンスが、このマスター・データベースに対して読み取りと書き込みを行う必要があります。マスターのいずれかのインスタンスがダウンした場合は、その他のインスタンスがワークロードを引き継げるので、アプリのダウン時間は発生しません。
{: shortdesc}

以下のイメージは、標準クラスター内のデータの可用性を高めるために {{site.data.keyword.containerlong_notm}} で選択できるオプションを示しています。どのオプションが適切かは、以下の要因に応じて決まります。
  * **所有しているアプリのタイプ:** 例えば、データをデータベース内ではなくファイル・ベースで保管しなければならないアプリがある場合があります。
  * **データの保管と転送の場所に関する法的要件:** 例えば、法律によってデータの保管と転送が米国内だけに制限されているために、欧州にあるサービスを使用できない場合があります。
  * **バックアップとリストアのオプション:** すべてのストレージ・オプションに、データをバックアップ/リストアするための機能が用意されています。利用可能なバックアップとリストアのオプションが、バックアップの頻度や、1 次データ・センター外にデータを保管できるかどうかなどの、お客様の災害復旧計画の要件を満たしていることを確認してください。
  * **グローバルな複製:** 高可用性のために、ストレージの複数のインスタンスを、世界中のデータ・センターの間に分散させ、複製するようにセットアップすることもできます。

<br/>
<img src="images/cs_storage_ha.png" alt="永続ストレージに関する高可用性オプション"/>

<table summary="この表は永続ストレージ・オプションを示しています。行は左から右に読みます。1 列目はオプションの番号、2 列目はオプションの名称、3 列目は説明です。">
  <thead>
  <th>#</th>
  <th>オプション</th>
  <th>説明</th>
  </thead>
  <tbody>
  <tr>
  <td width="5%">1</td>
  <td width="20%">NFS ファイル・ストレージ</td>
  <td width="75%">このオプションでは、Kubernetes 永続ボリュームを使用して、アプリやコンテナーのデータを保持できます。ボリュームは、[NFS ベースのエンデュランスとパフォーマンスのファイル・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/details) でホストされます。このファイル・ストレージは、データをデータベース内ではなくファイル・ベースで保管するアプリの場合に使用できます。可用性を高めるために、ファイル・ストレージは REST で暗号化されて IBM でクラスター化されています。<p>{{site.data.keyword.containershort_notm}} には、ストレージのサイズ範囲、IOPS、削除ポリシー、ボリュームに対する読み取りと書き込みの許可を定義する、事前定義されたストレージ・クラスが用意されています。 NFS ベースのファイル・ストレージに関する要求を開始するには、[永続ボリューム請求](cs_storage.html#create)を作成する必要があります。永続ボリューム請求をサブミットすると、NFS ベースのファイル・ストレージでホストされる永続ボリュームが {{site.data.keyword.containershort_notm}} によって動的にプロビジョンされます。 [永続ボリューム請求をデプロイメントのボリュームとしてマウント](cs_storage.html#app_volume_mount)すると、コンテナーがそのボリュームに対して読み取りと書き込みを行えるようになります。</p><p>永続ボリュームは、ワーカー・ノードがあるデータ・センター内でプロビジョンされます。同じレプリカ・セットと、または同じクラスター内の他のデプロイメントとデータを共有できます。別のデータ・センターまたは地域にあるクラスターとデータを共有することはできません。</p><p>デフォルトでは、NFS ストレージは自動的にバックアップされません。用意されているバックアップとリストアのメカニズムを使用して、クラスターの定期的なバックアップをセットアップできます。コンテナーがクラッシュしたとき、またはポッドがワーカー・ノードから削除されたときでも、データは削除されないので、ボリュームをマウントした他のデプロイメントから引き続きアクセスできます。 </p><p><strong>注:</strong> 永続 NFS ファイル共有ストレージは、月単位で課金されます。 クラスター用に永続ストレージをプロビジョンして即時にそれを削除したときは、短時間しか使用しない場合でも、永続ストレージの月額課金を支払います。</p></td>
  </tr>
  <tr>
    <td>2</td>
    <td>Cloud データベース・サービス</td>
    <td>このオプションでは、[IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) などの {{site.data.keyword.Bluemix_notm}} データベース・クラウド・サービスを使用して、データを保持できます。このオプションを使用して保管されたデータには、すべてのクラスター、場所、地域からアクセスできます。<p> すべてのアプリから単一のデータベース・インスタンスにアクセスするように構成するか、[複数のインスタンスを複数のデータ・センターに分散させ、インスタンス間の複製をセットアップ](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery)して可用性を高めるかを選択できます。IBM Cloudant NoSQL データベースでは、データは自動的にバックアップされません。用意されている[バックアップとリストアのメカニズム](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery)を使用して、サイトの障害からデータを保護できます。</p> <p> クラスター内のサービスを使用するには、クラスター内の名前空間に [{{site.data.keyword.Bluemix_notm}} サービスをバインド](cs_integrations.html#adding_app)する必要があります。サービスをクラスターにバインドすると、Kubernetes シークレットが作成されます。 Kubernetes シークレットは、サービスへの URL、ユーザー名、およびパスワードなど、サービスに関する機密情報を保持します。 シークレットをシークレット・ボリュームとしてポッドにマウントして、シークレット内の資格情報を使用することによりサービスにアクセスできます。 シークレット・ボリュームを他のポッドにマウントすることにより、ポッド間でデータを共有することもできます。 コンテナーがクラッシュしたとき、またはポッドがワーカー・ノードから削除されたときでも、データは削除されないので、シークレット・ボリュームをマウントした他のポッドから引き続きアクセスできます。 <p>{{site.data.keyword.Bluemix_notm}} のデータベース・サービスのほとんどは、少量のデータ用のディスク・スペースを無料で提供しているため、機能をテストすることができます。</p></td>
  </tr>
  <tr>
    <td>3</td>
    <td>オンプレミスのデータベース</td>
    <td>法的な理由でデータをオンサイトに保管しなければならない場合は、オンプレミス・データベースへの [VPN 接続をセットアップ](cs_vpn.html#vpn)し、データ・センター内の既存のストレージ、バックアップと複製のメカニズムを使用できます。</td>
  </tr>
  </tbody>
  </table>

{: caption="表。 Kubernetes クラスターでのデプロイメントのための永続データ・ストレージのオプション" caption-side="top"}

<br />



## クラスターでの既存の NFS ファイル共有の使用
{: #existing}

IBM Cloud インフラストラクチャー (SoftLayer) アカウントにある既存の NFS ファイル共有を Kubernetes で使用するには、その既存の NFS ファイル共有上に永続ボリュームを作成します。 永続ボリュームとは、Kubernetes クラスター・リソースとして機能する実際のハードウェアの一片であり、クラスター・ユーザーによって使用されます。
{:shortdesc}

Kubernetes は永続ボリューム (実際のハードウェアを表す) と、永続ボリューム請求 (ストレージの要求。通常はクラスター・ユーザーにより開始される) とを区別します。 次の図は、永続ボリュームと永続ボリューム請求の間の関係を示しています。

![永続ボリュームと永続ボリューム請求の作成](images/cs_cluster_pv_pvc.png)

 図に示すように、既存の NFS ファイル共有を Kubernetes で使用できるようにするには、特定のサイズとアクセス・モードを持つ永続ボリュームを作成し、その永続ボリュームの仕様と一致する永続ボリューム請求を作成する必要があります。 永続ボリュームと永続ボリューム請求が一致すると、それらは相互にバインドされます。 クラスター・ユーザーがデプロイメントへのボリュームのマウントに使用できるのは、バインドされた永続ボリューム請求だけです。 この処理は永続ストレージの静的プロビジョニングと呼ばれます。

始める前に、永続ボリュームの作成に使用できる既存の NFS ファイル共有があることを確認します。

**注:** 永続ストレージの静的プロビジョニングは既存の NFS ファイル共有にのみ適用されます。 既存の NFS ファイル共有がない場合、クラスター・ユーザーは[動的プロビジョニング](cs_storage.html#create)処理を使用して永続ボリュームを追加できます。

永続ボリューム、およびそれと一致する永続ボリューム請求を作成するには、次の手順を実行します。

1.  IBM Cloud インフラストラクチャー (SoftLayer) アカウントで、永続ボリューム・オブジェクトを作成する NFS ファイル共有の ID とパスを検索します。 さらに、クラスター内のサブネットに対する許可をファイル・ストレージに付与します。 この許可により、クラスターにストレージへのアクセス権限が付与されます。
    1.  IBM Cloud インフラストラクチャー (SoftLayer) アカウントにログインします。
    2.  **「ストレージ」**をクリックします。
    3.  **「ファイル・ストレージ」**をクリックして、**「アクション」**メニューから**「ホストの許可」**を選択します。
    4.  **「サブネット」**をクリックします。 許可した後、そのサブネット上のワーカー・ノードにはファイル・ストレージにアクセスできるようになります。
    5.  クラスターのパブリック VLAN のサブネットをメニューから選択し、**「送信」**をクリックします。 サブネットを見つける必要がある場合、`bx cs cluster-get <cluster_name> --showResources` を実行します。
    6.  ファイル・ストレージの名前をクリックします。
    7.  **「マウント・ポイント」**フィールドをメモします。 フィールドは `<server>:/<path>` の形式で表示されます。
2.  永続ボリュームのストレージ構成ファイルを作成します。 ファイル・ストレージの**「マウント・ポイント」**フィールドにあるサーバーとパスを含めます。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>表。 YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>作成する永続ボリューム・オブジェクトの名前を入力します。</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>既存の NFS ファイル共有のストレージ・サイズを入力します。 このストレージ・サイズはギガバイト単位 (例えば、20Gi (20 GB) や 1000Gi (1 TB) など) で入力する必要があり、そのサイズは既存のファイル共有のサイズと一致している必要があります。</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>アクセス・モードは、永続ボリューム請求をワーカー・ノードにマウントする方法を定義します。<ul><li>ReadWriteOnce (RWO): 永続ボリュームは、単一のワーカー・ノードのデプロイメントにのみマウントできます。 この永続ボリュームにマウントされているデプロイメントのコンテナーは、当該ボリュームに対する読み取り/書き込みを行うことができます。</li><li>ReadOnlyMany (ROX): 永続ボリュームは、複数のワーカー・ノードでホストされているデプロイメントにマウントできます。 この永続ボリュームにマウントされているデプロイメントは、当該ボリュームで読み取りだけを行うことができます。</li><li>ReadWriteMany (RWX): この永続ボリュームは、複数のワーカー・ノードでホストされているデプロイメントにマウントできます。 この永続ボリュームにマウントされているデプロイメントは、当該ボリュームに対する読み取り/書き込みを行うことができます。</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>NFS ファイル共有サーバーの ID を入力します。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>永続ボリューム・オブジェクトを作成する NFS ファイル共有のパスを入力します。</td>
    </tr>
    </tbody></table>

3.  クラスターに永続ボリューム・オブジェクトを作成します。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    例

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  永続ボリュームが作成されたことを確認します。

    ```
    kubectl get pv
    ```
    {: pre}

5.  永続ボリューム請求を作成するために、別の構成ファイルを作成します。 永続ボリューム請求が、前の手順で作成した永続ボリューム・オブジェクトと一致するようにするには、`storage` および
`accessMode` に同じ値を選択する必要があります。 `storage-class` フィールドは空である必要があります。 これらのいずれかのフィールドが永続ボリュームと一致しない場合、代わりに新しい永続ボリュームが自動的に作成されます。

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  永続ボリューム請求が作成され、永続ボリューム・オブジェクトにバインドされたことを確認します。 この処理には数分かかる場合があります。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    出力は、以下のようになります。

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


永続ボリューム・オブジェクトが正常に作成され、永続ボリューム請求にバインドされました。 これで、クラスター・ユーザーがデプロイメントに[永続ボリューム請求をマウント](#app_volume_mount)して、永続ボリューム・オブジェクトへの読み書きを開始できるようになりました。

<br />


## アプリ用の永続ストレージの作成
{: #create}

NFS ファイル・ストレージをクラスターにプロビジョンするために、永続ボリューム請求 (pvc) を作成します。 その後、この請求をデプロイメントにマウントすることで、ポッドがクラッシュしたりシャットダウンしたりしてもデータを利用できるようにします。
{:shortdesc}

永続ボリュームの基礎の NFS ファイル・ストレージは、データの高可用性を実現するために IBM がクラスター化しています。ストレージ・クラスとは、提供されているストレージ・オファリングのタイプを表し、永続ボリュームの作成時にデータ保存ポリシー、サイズ (GB)、IOPS などの特性を定義するものです。

**注**: ファイアウォールがある場合は、クラスターのあるロケーション (データ・センター) の IBM Cloud インフラストラクチャー (SoftLayer) の IP 範囲における[発信 (egress) アクセスを許可](cs_firewall.html#pvc)し、永続ボリューム請求を作成できるようにします。

1.  使用可能なストレージ・クラスを確認します。 {{site.data.keyword.containerlong}} には事前定義のストレージ・クラスが 8 つ用意されているので、クラスター管理者がストレージ・クラスを作成する必要はありません。 `ibmc-file-bronze` ストレージ・クラスは `default` ストレージ・クラスと同じです。

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  pvcを削除した後にデータと NFS ファイル共有を保存するかどうか (再請求ポリシー) を決めます。データを保持する場合、`retain` ストレージ・クラスを選択します。 pvc を削除するときにデータとファイル共有も削除する場合、`retain` のないストレージ・クラスを選択します。

3.  ストレージ・クラスの詳細を取得します。 CLI 出力内の **「paramters」**フィールドで、IOPS/GB とサイズの範囲を確認します。 

    <ul>
      <li>ブロンズ、シルバー、ゴールドのストレージ・クラスを使用する場合は、クラスごとに IOPS/GB が定義された[エンデュランス・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/endurance-storage) が割り当てられます。しかし、使用可能な範囲内のサイズを選択して、合計 IOPS を決めることができます。例えば、4 IOPS/GB のシルバー・ストレージ・クラスで 1000Gi のファイル共有サイズを選択すると、ボリュームの合計 IOPS は 4000 になります。 永続ボリュームの IOPS が多いほど、入出力操作の処理が高速になります。<p>**ストレージ・クラスの詳細を表示するコマンドの例**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-silver</pre>

       **「Parameters」**フィールドに、このストレージ・クラスに関連付けられている IOPS/GB と使用可能なサイズ (GB 単位) が示されます。
       <pre class="pre">Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi</pre>
       
       </li>
      <li>カスタム・ストレージ・クラスでは、[パフォーマンス・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/performance-storage) が割り当てられるので、IOPS とサイズの組み合わせを、より細かく選択できます。<p>**カスタム・ストレージ・クラスの詳細を表示するコマンドの例**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-retain-custom</pre>

       **「Parameters」**フィールドで、ストレージ・クラスに関連した IOPS と使用可能なサイズ (ギガバイト単位) を指定します。 例えば、40Gi pvc では、IOPS として 100 から 2000 IOPS の範囲の 100 の倍数を選択できます。

       ```
       Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
       ```
       {: screen}
       </li></ul>
4. 永続ボリューム請求を定義した構成ファイルを作成し、`.yaml` ファイルとして構成を保存します。

    -  **ブロンズ、シルバー、ゴールドのストレージ・クラスの例**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
        name: mypvc
        annotations:
          volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
          
       spec:
        accessModes:
          - ReadWriteMany
        resources:
          requests:
            storage: 20Gi
        ```
        {: codeblock}

    -  **カスタム・ストレージ・クラスの例**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 40Gi
             iops: "500"
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>永続ボリューム請求の名前を入力します。</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>永続ボリュームのためのストレージ・クラスを指定します。
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze: 2 IOPS/GB。</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS/GB。</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS/GB。</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom: 複数の IOPS の値を使用できます。</li>
          <p>ストレージ・クラスを指定しなかった場合は、ブロンズ・ストレージ・クラスを使用して永続ボリュームが作成されます。</p></td>
        </tr>
        
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
        <td>リストされているもの以外のサイズを選択した場合、サイズは切り上げられます。 最大サイズより大きいサイズを選択した場合、サイズは切り下げられます。</td>
        </tr>
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
        <td>このオプションは、カスタマー・ストレージ・クラス (`ibmc-file-custom / ibmc-file-retain-custom`) でのみ使用できます。ストレージのための合計 IOPS を指定します。 すべてのオプションを表示するには、`kubectl describe storageclasses ibmc-file-custom` を実行します。 リストされているもの以外の IOPS を選択した場合、その IOPS は切り上げられます。</td>
        </tr>
        </tbody></table>

5.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  永続ボリューム請求が作成され、永続ボリュームにバインドされたことを確認します。 この処理には数分かかる場合があります。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    出力例:

    ```
    Name:		mypvc
    Namespace:	default
    StorageClass:	""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #app_volume_mount}永続ボリューム請求をデプロイメントにマウントするには、構成ファイルを作成します。 構成を `.yaml` ファイルとして保存します。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <deployment_name>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app_name>
    spec:
     containers:
     - image: <image_name>
       name: <container_name>
       volumeMounts:
       - mountPath: /<file_path>
         name: <volume_name>
     volumes:
     - name: <volume_name>
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>デプロイメントの名前。</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>デプロイメントのラベル。</td>
    </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>使用するイメージの名前。{{site.data.keyword.registryshort_notm}} アカウント内の使用可能なイメージをリストするには、`bx cr image-list` を実行します。</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>クラスターにデプロイするコンテナーの名前。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>コンテナー内でボリュームがマウントされるディレクトリーの絶対パス。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>ポッドにマウントするボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>ポッドにマウントするボリュームの名前。通常、この名前は <code>volumeMounts/name</code> と同じです。</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>ボリュームとして使用する永続ボリューム請求の名前。 ボリュームをポッドにマウントすると、Kubernetes は永続ボリューム請求にバインドされた永続ボリュームを識別して、その永続ボリュームでユーザーが読み取り/書き込みを行えるようにします。</td>
    </tr>
    </tbody></table>

8.  デプロイメントを作成して、永続ボリューム請求をマウントします。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  ボリュームが正常にマウントされたことを確認します。

    ```
    kubectl describe deployment <deployment_name>
    ```
    {: pre}

    マウント・ポイントは **Volume Mounts** フィールドにあり、ボリュームは **Volumes** フィールドにあります。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />



## 永続ストレージに対する非 root ユーザーのアクセス権限の追加
{: #nonroot}

非 root ユーザーには、NFS ベースのストレージのボリューム・マウント・パスに対する書き込み権限がありません。 書き込み権限を付与するには、イメージの Dockerfile を編集して、適切な権限を設定したディレクトリーをマウント・パス上に作成する必要があります。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

非 root ユーザーを使用するアプリを設計していて、そのユーザーにボリュームに対する書き込み権限が必要な場合は、Dockerfile とエントリー・ポイント・スクリプトに次の処理を追加する必要があります。

-   非 root ユーザーを作成する。
-   そのユーザーを一時的に root グループに追加する。
-   ボリューム・マウント・パスにディレクトリーを作成して、適切なユーザー権限を設定する。

{{site.data.keyword.containershort_notm}} の場合、ボリューム・マウント・パスのデフォルト所有者は、所有者 `nobody` です。 NFS ストレージを使用する場合は、所有者がポッドのローカルに存在しなければ、`nobody` ユーザーが作成されます。 ボリュームは、コンテナー内の root ユーザーを認識するようにセットアップされます。一部のアプリでは、このユーザーがコンテナー内の唯一のユーザーです。 しかし、多くのアプリでは、コンテナー・マウント・パスへの書き込みを行う `nobody` 以外の非 root ユーザーを指定します。 ボリュームは root ユーザーが所有しなければならないということを指定するアプリもあります。 アプリは通常、セキュリティー上の懸念から root ユーザーを使用しません。 それでもアプリが root ユーザーを必要とする場合は、[{{site.data.keyword.Bluemix_notm}} サポート](/docs/get-support/howtogetsupport.html#getting-customer-support)に連絡を取ることができます。


1.  ローカル・ディレクトリーに Dockerfile を作成します。 この Dockerfile 例では、`myguest` という非 root ユーザーを作成します。

    ```
    FROM registry.<region>.bluemix.net/ibmliberty:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Dockerfile と同じローカル・フォルダーに、エントリー・ポイント・スクリプトを作成します。 このエントリー・ポイント・スクリプト例では、ボリューム・マウント・パスとして `/mnt/myvol` を指定します。

    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  {{site.data.keyword.registryshort_notm}} にログインします。

    ```
    bx cr login
    ```
    {: pre}

4.  イメージをローカルにビルドします。 _&lt;my_namespace&gt;_ を、プライベート・イメージ・レジストリーの名前空間に必ず置き換えてください。 名前空間を調べる必要がある場合は、`bx cr namespace-get` を実行します。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  {{site.data.keyword.registryshort_notm}} 内の名前空間にイメージをプッシュします。

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  `.yaml` 構成ファイルを作成して、永続ボリューム請求を作成します。 この例では、パフォーマンスがやや低いストレージ・クラスを使用しています。 使用可能なストレージ・クラスを表示するには、`kubectl get storageclasses` を実行してください。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  ボリュームをマウントし、非 root イメージからポッドを実行するように構成ファイルを作成します。 ボリューム・マウント・パス `/mnt/myvol` は、Dockerfile で指定されたマウント・パスと一致します。 構成を `.yaml` ファイルとして保存します。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  ポッドを作成して、永続ボリューム請求をポッドにマウントします。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. ボリュームがポッドに正常にマウントされたことを確認します。

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    マウント・ポイントは **Volume Mounts** フィールドにリストされ、ボリュームは **Volumes** フィールドにリストされます。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. ポッドが実行されたら、ポッドにログインします。

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. ボリューム・マウント・パスの許可を表示します。

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    この出力が示すように、root にはボリューム・マウント・パス `mnt/myvol/` に対する読み取り/書き込み/実行権限があり、非 root の myguest ユーザーには、`mnt/myvol/mydata` フォルダーに対する読み取り/書き込み権限があります。 このように権限が更新されたことにより、非 root ユーザーは永続ボリュームにデータを書き込めるようになりました。


