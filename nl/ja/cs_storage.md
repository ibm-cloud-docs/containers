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


# 永続ボリューム・ストレージによるデータの保存
{: #planning}

コンテナーは、設計上、存続時間が短期です。しかし、図に示すように、コンテナーにフェイルオーバーが発生した場合でもデータが永続するように、そしてコンテナー間でデータを共有するために、複数のオプションから選択することができます。
{:shortdesc}

**注**: ファイアウォールがある場合は、クラスターのあるロケーション (データ・センター) の IBM Cloud インフラストラクチャー (SoftLayer) の IP 範囲における[発信 (egress) アクセスを許可](cs_firewall.html#pvc)し、永続ボリューム請求を作成できるようにします。

![Kubernetes クラスターでのデプロイメントのための永続ストレージ・オプション](images/cs_planning_apps_storage.png)

|オプション|説明|
|------|-----------|
|オプション 1: `/emptyDir` を使用して、ワーカー・ノード上の使用可能なディスク・スペースを使用してデータを永続させる<p>この機能は、ライト・クラスターと標準クラスターで使用可能です。</p>|このオプションでは、ポッドに割り当てられたワーカー・ノードのディスク・スペースに空のボリュームを作成できます。 そのポッド内のコンテナーは、そのボリュームに関する読み取りと書き込みを行うことができます。ボリュームが特定の 1 つのポッドに割り当てられているので、レプリカ・セット内の他のポッドとデータを共有することはできません。<p>`/emptyDir` ボリュームとそのデータは、割り当てられたポッドがワーカー・ノードから永久に削除されるときに削除されます。</p><p>**注:** ポッド内のコンテナーがクラッシュした場合でも、ボリューム内のデータはワーカー・ノードで引き続き使用できます。</p><p>詳しくは、[Kubernetes ボリューム ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/storage/volumes/) を参照してください。</p>|
|オプション 2: 使用するデプロイメント用に NFS ベースの永続ストレージをプロビジョンするための永続ボリューム請求を行う<p>このフィーチャーを使用できるのは、標準クラスターの場合に限られます。</p>|<p>このオプションにより、永続ボリュームで構成される、アプリとコンテナー・データのための永続ストレージを用意できます。 このボリュームは、[NFS ベースのエンデュランスとパフォーマンスのファイル・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/details) でホストされます。 ファイル・ストレージは保存時に暗号化され、保管データのレプリカを作成できます。</p> <p>NFS ベースのファイル・ストレージの要求を出すには、[永続ボリューム請求](cs_storage.html)を作成します。 {{site.data.keyword.containershort_notm}} には、ストレージのサイズ範囲、IOPS、削除ポリシー、ボリュームに対する読み取りと書き込みの許可を定義する、事前定義されたストレージ・クラスが用意されています。 永続ボリューム請求を行う際に、これらのストレージ・クラスの中から選択できます。 永続ボリューム請求をサブミットすると、NFS ベースのファイル・ストレージでホストされる永続ボリュームが {{site.data.keyword.containershort_notm}} によって動的にプロビジョンされます。 [永続ボリューム請求をデプロイメントのボリュームの 1 つとしてマウント](cs_storage.html#create)すると、コンテナーがそのボリュームに対する読み書きを行えるようになります。 永続ボリュームは、同じレプリカ・セットの間で、または同じクラスター内の他のデプロイメントと共有することができます。</p><p>コンテナーがクラッシュしたとき、またはポッドがワーカー・ノードから削除されたときでも、データは削除されないので、ボリュームをマウントした他のデプロイメントから引き続きアクセスできます。 永続ボリューム請求は永続ストレージでホストされますが、バックアップはありません。 データのバックアップが必要な場合は、手動バックアップを作成してください。</p><p>**注:** 永続 NFS ファイル共有ストレージは、月単位で課金されます。 クラスター用に永続ストレージをプロビジョンして即時にそれを削除したときは、短時間しか使用しない場合でも、永続ストレージの月額課金を支払います。</p>|
|オプション 3: {{site.data.keyword.Bluemix_notm}} データベース・サービスをポッドにバインドする<p>この機能は、ライト・クラスターと標準クラスターで使用可能です。</p>|このオプションの場合、{{site.data.keyword.Bluemix_notm}} データベース・クラウド・サービスを使用して、データを永続させ、アクセスすることができます。 {{site.data.keyword.Bluemix_notm}} サービスをクラスター内の名前空間にバインドすると、Kubernetes シークレットが作成されます。 Kubernetes シークレットは、サービスへの URL、ユーザー名、パスワードなど、サービスに関する機密情報を保持します。 シークレットをシークレット・ボリュームとしてポッドにマウントして、シークレット内の資格情報を使用することによりサービスにアクセスできます。 シークレット・ボリュームを他のポッドにマウントすることにより、ポッド間でデータを共有することもできます。<p>コンテナーがクラッシュしたとき、またはポッドがワーカー・ノードから削除されたときでも、データは削除されないので、シークレット・ボリュームをマウントした他のポッドから引き続きアクセスできます。</p><p>{{site.data.keyword.Bluemix_notm}} のデータベース・サービスのほとんどは、少量のデータ用のディスク・スペースを無料で提供しているため、機能をテストすることができます。</p><p>{{site.data.keyword.Bluemix_notm}} サービスをポッドにバインドする方法について詳しくは、[{{site.data.keyword.containershort_notm}} でのアプリ用 {{site.data.keyword.Bluemix_notm}} サービスの追加](cs_integrations.html#adding_app)を参照してください。</p>|
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

永続ボリュームの基礎の NFS ファイル・ストレージは、データの高可用性を実現するために IBM がクラスター化しています。

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

2.  pvc を削除した後にデータと NFS ファイル共有を保存するかどうかを決めます。 データを保持する場合、`retain` ストレージ・クラスを選択します。 pvc を削除するときにデータとファイル共有も削除する場合、`retain` のないストレージ・クラスを選択します。

3.  ストレージ・クラスの IOPS と使用可能なストレージ・サイズを確認します。

    - bronze、silver、gold の各ストレージ・クラスは[エンデュランス・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/endurance-storage) を使用し、各クラスには、定義された IOPS/GB が 1 つあります。 合計 IOPS は、ストレージのサイズに依存します。 例えば、4 IOPS/GB を 1000Gi pvc 使用すると、合計 4000 IOPS となります。

      ```
      kubectl describe storageclasses ibmc-file-silver
      ```
      {: pre}

      **「Parameters」**フィールドで、ストレージ・クラスに関連した 1 GB あたりの IOPS と使用可能なサイズ (ギガバイト単位) を確認できます。

      ```
      Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
      ```
      {: screen}

    - カスタム・ストレージ・クラスは、[パフォーマンス・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/performance-storage) を使用し、合計 IOPS とサイズが個別に設定されたオプションがあります。

      ```
      kubectl describe storageclasses ibmc-file-retain-custom
      ```
      {: pre}

      **「Parameters」**フィールドで、ストレージ・クラスに関連した IOPS と使用可能なサイズ (ギガバイト単位) を指定します。 例えば、40Gi pvc では、IOPS として 100 から 2000 IOPS の範囲の 100 の倍数を選択できます。

      ```
      Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
      ```
      {: screen}

4.  永続ボリューム請求を定義した構成ファイルを作成し、`.yaml` ファイルとして構成を保存します。

    bronze、silver、gold の各クラスの場合の例は次のようになります。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
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

    カスタム・クラスの場合の例は次のようになります。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
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
      <li>ibmc-file-custom / ibmc-file-retain-custom: 複数の IOPS の値を使用できます。

    </li> ストレージ・クラスを指定しなかった場合は、ブロンズ・ストレージ・クラスを使用して永続ボリュームが作成されます。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>リストされているもの以外のサイズを選択した場合、サイズは切り上げられます。 最大サイズより大きいサイズを選択した場合、サイズは切り下げられます。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>このオプションは、ibmc-file-custom / ibmc-file-retain-custom だけのためのものです。 ストレージのための合計 IOPS を指定します。 すべてのオプションを表示するには、`kubectl describe storageclasses ibmc-file-custom` を実行します。 リストされているもの以外の IOPS を選択した場合、その IOPS は切り上げられます。</td>
    </tr>
    </tbody></table>

5.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  永続ボリューム請求が作成され、永続ボリュームにバインドされたことを確認します。 この処理には数分かかる場合があります。

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    出力は、以下のようになります。

    ```
    Name:  <pvc_name>
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
    <td><code>volumeMounts/mountPath</code></td>
    <td>デプロイメント内でボリュームがマウントされるディレクトリーの絶対パス。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>デプロイメントにマウントするボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>デプロイメントにマウントするボリュームの名前。 通常、この名前は <code>volumeMounts/name</code> と同じです。</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>ボリュームとして使用する永続ボリューム請求の名前。 ボリュームをデプロイメントにマウントすると、Kubernetes は永続ボリューム請求にバインドされた永続ボリュームを識別して、その永続ボリュームでユーザーが読み取り/書き込みを行えるようにします。</td>
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

{{site.data.keyword.containershort_notm}} の場合、ボリューム・マウント・パスのデフォルト所有者は、所有者 `nobody` です。 NFS ストレージを使用する場合は、所有者がポッドのローカルに存在しなければ、`nobody` ユーザーが作成されます。 ボリュームは、コンテナー内の root ユーザーを認識するようにセットアップされます。一部のアプリでは、このユーザーがコンテナー内の唯一のユーザーです。 しかし、多くのアプリでは、コンテナー・マウント・パスへの書き込みを行う `nobody` 以外の非 root ユーザーを指定します。 ボリュームは root ユーザーが所有しなければならないということを指定するアプリもあります。 アプリは通常、セキュリティー上の懸念から root ユーザーを使用しません。 それでもアプリが root ユーザーを必要とする場合は、[{{site.data.keyword.Bluemix_notm}} サポート](/docs/support/index.html#contacting-support)に連絡を取ることができます。


1.  ローカル・ディレクトリーに Dockerfile を作成します。 この Dockerfile 例では、`myguest` という非 root ユーザーを作成します。

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

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


