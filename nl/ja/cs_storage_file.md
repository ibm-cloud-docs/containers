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




# IBM Cloud の IBM ファイル・ストレージへのデータの保管
{: #file_storage}


## ファイル・ストレージ構成の決定
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} には、ファイル・ストレージ用の事前定義のストレージ・クラスが用意されているので、これを使用して、特定の構成のファイル・ストレージをプロビジョンできます。
{: shortdesc}

ストレージ・クラスごとに、プロビジョンされるファイル・ストレージのタイプ (使用可能なサイズ、IOPS、ファイル・システム、保存ポリシーなど) が指定されています。  

ストレージ・クラスを使用して特定のタイプのストレージをプロビジョンした後に、ストレージ・デバイスのタイプ、または保存ポリシーを変更することはできません。 ただし、ストレージ容量とパフォーマンスを向上させたい場合に、[サイズと IOPS を変更する](#change_storage_configuration)ことができます。 ストレージのタイプおよび保存ポリシーを変更するには、[新しいストレージ・インスタンスを作成し、古いストレージ・インスタンスから新しいストレージ・インスタンスにデータをコピー](cs_troubleshoot_storage.html#cos_nonroot_access)する必要があります。
{: important}

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

ストレージ構成を決定するには、以下のようにします。

1. {{site.data.keyword.containerlong}} で使用可能なストレージ・クラスをリストします。
    ```
    kubectl get storageclasses | grep file
    ```
    {: pre}

    出力例:
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
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

2. ストレージ・クラスの構成を確認します。
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   各ストレージ・クラスについて詳しくは、[ストレージ・クラス・リファレンス](#storageclass_reference)を参照してください。 ニーズに合うものがない場合は、カスタマイズした独自のストレージ・クラスを作成することを検討してください。 まずは、[ストレージ・クラスのカスタマイズ例](#custom_storageclass)を確認してください。
   {: tip}

3. プロビジョンするファイル・ストレージのタイプを選択します。
   - **ブロンズ、シルバー、ゴールドのストレージ・クラス:** これらのストレージ・クラスは[エンデュランス・ストレージ](/docs/infrastructure/FileStorage/index.html#provisioning-with-endurance-tiers)をプロビジョンします。 エンデュランス・ストレージの場合、事前定義された IOPS ティアでストレージのサイズ (ギガバイト単位) を選択できます。
   - **カスタム・ストレージ・クラス:** このストレージ・クラスは[パフォーマンス・ストレージ](/docs/infrastructure/FileStorage/index.html#provisioning-with-performance)をプロビジョンします。 パフォーマンス・ストレージの場合は、より柔軟にストレージのサイズと IOPS を選択できます。

4. ファイル・ストレージのサイズと IOPS を選択します。 IOPS のサイズと数値によって、合計 IOPS (1 秒あたりの入出力操作数) が決まります。これは、ストレージの速度を示す指標となります。 ストレージの合計 IOPS が多いほど、読み取り/書き込み操作の処理が高速になります。
   - **ブロンズ、シルバー、ゴールドのストレージ・クラス:** これらのストレージ・クラスは、1 ギガバイトあたりの IOPS 数が固定されていて、SSD ハード・ディスクにプロビジョンされます。 合計の IOPS 数は、選択したストレージのサイズによって決まります。 指定可能なサイズの範囲内で、任意の整数のギガバイト (20 Gi、256 Gi、11854 Gi など) を選択できます。 合計 IOPS 数を求めるには、選択したサイズと IOPS を乗算します。 例えば、4 IOPS/GB のシルバー・ストレージ・クラスで、1000Gi のファイル・ストレージ・サイズを選択すると、ストレージの合計 IOPS は 4000 になります。
     <table>
         <caption>ストレージ・クラスのサイズの範囲と IOPS/GB を示す表</caption>
         <thead>
         <th>ストレージ・クラス</th>
         <th>IOPS/GB</th>
         <th>サイズの範囲 (ギガバイト単位)</th>
         </thead>
         <tbody>
         <tr>
         <td>ブロンズ</td>
         <td>2 IOPS/GB</td>
         <td>20 から 12000 Gi</td>
         </tr>
         <tr>
         <td>シルバー</td>
         <td>4 IOPS/GB</td>
         <td>20 から 12000 Gi</td>
         </tr>
         <tr>
         <td>ゴールド</td>
         <td>10 IOPS/GB</td>
         <td>20 から 4000 Gi</td>
         </tr>
         </tbody></table>
   - **カスタム・ストレージ・クラス:** このストレージ・クラスを選択した場合は、より柔軟に、希望するサイズと IOPS を選択できます。 サイズについては、指定可能なサイズの範囲内で、任意の整数のギガバイトを選択できます。 選択したサイズに応じて、選択可能な IOPS の範囲が決まります。 指定された範囲にある 100 の倍数で IOPS を選択できます。 選択する IOPS は静的であり、ストレージのサイズに合わせてスケーリングされません。 例えば、40Gi と 100 IOPS を選択した場合、合計 IOPS は 100 のままです。 </br></br> ギガバイトに対する IOPS の比率によって、プロビジョンされるハード・ディスクのタイプも決まります。 例えば、500Gi を 100 IOPS で選択した場合、ギガバイトに対する IOPS の比率は 0.2 となります。 0.3 以下の比率のストレージは、SATA ハード・ディスクにプロビジョンされます。 0.3 より大きい比率のストレージは、SSD ハード・ディスクにプロビジョンされます。  
     <table>
         <caption>カスタム・ストレージ・クラスのサイズ範囲と IOPS を示す表</caption>
         <thead>
         <th>サイズの範囲 (ギガバイト単位)</th>
         <th>IOPS の範囲 (100 の倍数)</th>
         </thead>
         <tbody>
         <tr>
         <td>20 から 39 Gi</td>
         <td>100 から 1000 IOPS</td>
         </tr>
         <tr>
         <td>40 から 79 Gi</td>
         <td>100 から 2000 IOPS</td>
         </tr>
         <tr>
         <td>80 から 99 Gi</td>
         <td>100 から 4000 IOPS</td>
         </tr>
         <tr>
         <td>100 から 499 Gi</td>
         <td>100 から 6000 IOPS</td>
         </tr>
         <tr>
         <td>500 から 999 Gi</td>
         <td>100 から 10000 IOPS</td>
         </tr>
         <tr>
         <td>1000 から 1999 Gi</td>
         <td>100 から 20000 IOPS</td>
         </tr>
         <tr>
         <td>2000 から 2999 Gi</td>
         <td>200 から 40000 IOPS</td>
         </tr>
         <tr>
         <td>3000 から 3999 Gi</td>
         <td>200 から 48000 IOPS</td>
         </tr>
         <tr>
         <td>4000 から 7999 Gi</td>
         <td>300 から 48000 IOPS</td>
         </tr>
         <tr>
         <td>8000 から 9999 Gi</td>
         <td>500 から 48000 IOPS</td>
         </tr>
         <tr>
         <td>10000 から 12000 Gi</td>
         <td>1000 から 48000 IOPS</td>
         </tr>
         </tbody></table>

5. クラスターまたは永続ボリューム請求 (PVC) が削除された後もデータを保持するかどうかを選択します。
   - データを保持する場合、`retain` ストレージ・クラスを選択します。 PVC を削除すると、PVC のみが削除されます。 PV と、IBM Cloud インフラストラクチャー (SoftLayer) アカウント内の物理ストレージ・デバイスと、データは残ります。 ストレージを回収し、クラスターで再使用するには、PV を削除し、[既存のファイル・ストレージを使用する](#existing_file)手順に従う必要があります。
   - PVC を削除するときに PV、データ、物理ファイル・ストレージ・デバイスが削除されるようにするには、`retain` なしのストレージ・クラスを選択します。 **注**: 専用アカウントがある場合は、`retain` を指定せずにストレージ・クラスを選択し、IBM Cloud インフラストラクチャー (SoftLayer) 内の孤立ボリュームを防止します。

6. 時間単位と月単位のどちらの課金方法にするかを選択します。 詳しくは、[料金設定 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/pricing) を参照してください。 デフォルトでは、すべてのファイル・ストレージ・デバイスが時間単位の課金タイプでプロビジョンされます。
   月単位の課金タイプを選択した場合は、永続ストレージを短期間しか使用せずに削除しても、月額料金を支払うことになります。
   {: note}

<br />



## ファイル・ストレージをアプリに追加する
{: #add_file}

ファイル・ストレージをクラスターに[動的にプロビジョン](cs_storage_basics.html#dynamic_provisioning)するために、永続ボリューム請求 (PVC) を作成します。 動的プロビジョニングでは、対応する永続ボリューム (PV) が自動的に作成され、お客様の IBM Cloud インフラストラクチャー (SoftLayer) アカウントで物理ストレージ・デバイスが注文されます。
{:shortdesc}

開始前に、以下のことを行います。
- ファイアウォールがある場合は、クラスターのあるゾーンの IBM Cloud インフラストラクチャー (SoftLayer) の IP 範囲に[発信アクセスを許可](cs_firewall.html#pvc)し、PVC を作成できるようにします。
- [事前定義されたストレージ・クラスを選択する](#predefined_storageclass)か、または[カスタマイズしたストレージ・クラス](#custom_storageclass)を作成します。

ステートフル・セットにファイル・ストレージをデプロイしようとお考えですか? 詳しくは、[ステートフル・セットでのファイル・ストレージの使用](#file_statefulset)を参照してください。
{: tip}

ファイル・ストレージを追加するには、以下のようにします。

1.  永続ボリューム請求 (PVC) を定義した構成ファイルを作成し、`.yaml` ファイルとして構成を保存します。

    - **ブロンズ、シルバー、ゴールドのストレージ・クラスの例**:
       以下の `.yaml` ファイルは、名前が `mypvc`、ストレージ・クラスが `"ibmc-file-silver"`、課金が `"monthly"`、ギガバイト・サイズが `24Gi` の請求を作成します。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "monthly"
           region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
       ```
       {: codeblock}

    -  **カスタム・ストレージ・クラスの使用例**:
       以下の `.yaml` ファイルで作成する請求は、名前が `mypvc`、ストレージ・クラスが `ibmc-file-retain-custom`、課金タイプが `"hourly"`、ギガバイト・サイズが `45Gi`、IOPS が `"300"` です。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "hourly"
           region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 45Gi
             iops: "300"
       ```
       {: codeblock}

       <table>
       <caption>YAML ファイルの構成要素について</caption>
       <thead>
       <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
       </thead>
       <tbody>
       <tr>
       <td><code>metadata.name</code></td>
       <td>PVC の名前を入力します。</td>
       </tr>
       <tr>
       <td><code>metadata.annotations.</code></br><code>volume.beta.kubernetes.io/</code></br><code>storage-class</code></td>
       <td>ファイル・ストレージをプロビジョンするために使用するストレージ・クラスの名前。 </br> ストレージ・クラスを指定しなかった場合は、デフォルトのストレージ・クラス <code>ibmc-file-bronze</code> を使用して PV が作成されます。</br></br><strong>ヒント:</strong> デフォルトのストレージ・クラスを変更する場合は、<code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> を実行して、<code>&lt;storageclass&gt;</code> をストレージ・クラスの名前に置き換えます。</td>
       </tr>
       <tr>
         <td><code>metadata.labels.billingType</code></td>
          <td>ストレージの課金額を計算する頻度として「monthly」または「hourly」を指定します。 課金タイプを指定しない場合、ストレージは時間単位 (hourly) の課金タイプでプロビジョンされます。 </td>
       </tr>
       <tr>
       <td><code>metadata.labels.region</code></td>
       <td>オプション: ファイル・ストレージをプロビジョンする地域を指定します。 ストレージに接続するには、クラスターが存在する地域と同じ地域にストレージを作成します。地域を指定する場合は、ゾーンも指定する必要があります。 地域を指定しなかった場合、または指定した地域が見つからなかった場合、ストレージはクラスターと同じ地域に作成されます。 </br></br><strong>ヒント: </strong>PVC に地域とゾーンを指定するのではなく、[カスタマイズ型ストレージ・クラス](#multizone_yaml)にそれらの値を指定することもできます。そして、PVC の <code>metadata.annotations.volume.beta.kubernetes.io/storage-class</code> セクションでそのストレージ・クラスを使用します。 地域とゾーンがストレージ・クラスにも PVC にも指定されている場合は、PVC の値が優先されます。</td>
       </tr>
       <tr>
       <td><code>metadata.labels.zone</code></td>
       <td>オプション: ファイル・ストレージをプロビジョンするゾーンを指定します。 アプリでストレージを使用するには、ワーカー・ノードが存在するゾーンと同じゾーンにストレージを作成します。 ワーカー・ノードのゾーンを表示するには、<code>ibmcloud ks workers --cluster &lt;cluster_name_or_ID&gt;</code> を実行し、CLI 出力の <strong>Zone</strong> 列を確認します。 ゾーンを指定する場合は、地域も指定する必要があります。 ゾーンを指定しなかった場合、または指定したゾーンが複数ゾーン・クラスターで見つからなかった場合、ゾーンはラウンドロビン・ベースで選択されます。 </br></br><strong>ヒント: </strong>PVC に地域とゾーンを指定するのではなく、[カスタマイズ型ストレージ・クラス](#multizone_yaml)にそれらの値を指定することもできます。そして、PVC の <code>metadata.annotations.volume.beta.kubernetes.io/storage-class</code> セクションでそのストレージ・クラスを使用します。地域とゾーンがストレージ・クラスにも PVC にも指定されている場合は、PVC の値が優先されます。</td>
       </tr>
       <tr>
       <td><code>spec.accessMode</code></td>
       <td>次のオプションのいずれかを指定してください。 <ul><li><strong>ReadWriteMany: </strong>PVC は複数のポッドによってマウントできます。 すべてのポッドは、ボリュームに対する読み取りと書き込みを行うことができます。 </li><li><strong>ReadOnlyMany: </strong>PVC は複数のポッドによってマウントできます。 すべてのポッドには読み取り専用アクセス権限があります。 <li><strong>ReadWriteOnce: </strong>PVC は 1 つのポッドのみによってマウントできます。 このポッドは、ボリュームに対して読み取りと書き込みを行うことができます。 </li></ul></td>
       </tr>
       <tr>
       <td><code>spec.resources.requests.storage</code></td>
       <td>ファイル・ストレージのサイズをギガバイト (Gi) 単位で入力します。 ストレージがプロビジョンされた後は、ファイル・ストレージのサイズを変更できません。 保管するデータの量に一致するサイズを指定してください。</td>
       </tr>
       <tr>
       <td><code>spec.resources.requests.iops</code></td>
       <td>このオプションは、カスタム・ストレージ・クラス (`ibmc-file-custom / ibmc-file-retain-custom`) でのみ使用できます。 許容範囲内で 100 の倍数を選択して、ストレージの合計 IOPS を指定します。 リストされているもの以外の IOPS を選択した場合、その IOPS は切り上げられます。</td>
       </tr>
       </tbody></table>

    カスタマイズされたストレージ・クラスを使用する場合は、対応するストレージ・クラス名、有効な IOPS、およびサイズを指定して PVC を作成します。   
    {: tip}

2.  PVC を作成します。

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  PVC が作成され、PV にバインドされたことを確認します。 この処理には数分かかる場合があります。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    出力例:

    ```
    Name:		mypvc
    Namespace:	default
    StorageClass:	""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}ストレージをデプロイメントにマウントするには、構成 `.yaml` ファイルを作成し、PV をバインドする PVC を指定します。

    非 root ユーザーが永続ストレージに書き込む必要があるアプリの場合、または root ユーザーがマウント・パスを所有する必要があるアプリの場合は、[NFS ファイル・ストレージに対する非 root ユーザーのアクセス権限の追加](cs_troubleshoot_storage.html#nonroot)または [NFS ファイル・ストレージに対する root 権限の有効化](cs_troubleshoot_storage.html#nonroot)を参照してください。
    {: tip}

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata.labels.app</code></td>
    <td>デプロイメントのラベル。</td>
      </tr>
      <tr>
        <td><code>spec.selector.matchLabels.app</code> <br/> <code>spec.template.metadata.labels.app</code></td>
        <td>アプリのラベル。</td>
      </tr>
    <tr>
    <td><code>template.metadata.labels.app</code></td>
    <td>デプロイメントのラベル。</td>
      </tr>
    <tr>
    <td><code>spec.containers.image</code></td>
    <td>使用するイメージの名前。 {{site.data.keyword.registryshort_notm}} アカウント内の使用可能なイメージをリストするには、`ibmcloud cr image-list` を実行します。</td>
    </tr>
    <tr>
    <td><code>spec.containers.name</code></td>
    <td>クラスターにデプロイするコンテナーの名前。</td>
    </tr>
    <tr>
    <td><code>spec.containers.volumeMounts.mountPath</code></td>
    <td>コンテナー内でボリュームがマウントされるディレクトリーの絶対パス。 マウント・パスに書き込まれるデータは、物理ファイル・ストレージ・インスタンスの <code>root</code> ディレクトリーに保管されます。 物理ファイル・ストレージ・インスタンス内にディレクトリーを作成するには、マウント・パスにサブディレクトリーを作成する必要があります。 </td>
    </tr>
    <tr>
    <td><code>spec.containers.volumeMounts.name</code></td>
    <td>ポッドにマウントするボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>volumes.name</code></td>
    <td>ポッドにマウントするボリュームの名前。 通常、この名前は <code>volumeMounts.name</code> と同じです。</td>
    </tr>
    <tr>
    <td><code>volumes.persistentVolumeClaim.claimName</code></td>
    <td>使用する PV をバインドする PVC の名前。 </td>
    </tr>
    </tbody></table>

5.  デプロイメントを作成します。
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  PV が正常にマウントされたことを確認します。

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
         Type:	PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
         ClaimName:	mypvc
         ReadOnly:	false
     ```
     {: screen}

<br />


## クラスターでの既存のファイル・ストレージの使用
{: #existing_file}

クラスターで使用したい既存の物理ストレージ・デバイスがある場合は、PV と PVC を手動で作成して、そのストレージを[静的にプロビジョン](cs_storage_basics.html#static_provisioning)することができます。

開始前に、以下のことを行います。
- 少なくとも 1 つのワーカー・ノードが、既存のファイル・ストレージ・インスタンスと同じゾーンに存在することを確認してください。
- [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

### ステップ 1: 既存のストレージを準備する

アプリへの既存のストレージのマウントを開始するには、その前に、PV に関する必要な情報をすべて取得し、クラスターでストレージにアクセスできるように準備する必要があります。  

**`retain` ストレージ・クラスを指定してプロビジョンされたストレージの場合** </br>
`retain` ストレージ・クラスを指定してストレージをプロビジョンした場合、PVC を削除しても、PV と物理ストレージ・デバイスは自動的に削除されません。 そのストレージをクラスターで再使用するには、残っている PV をまず削除する必要があります。

既存のストレージを、プロビジョンしたクラスターとは別のクラスターで使用するには、[クラスターの外部で作成されたストレージ](#external_storage)の手順に従って、ストレージをワーカー・ノードのサブネットに追加してください。
{: tip}

1. 既存の PV をリストします。
   ```
   kubectl get pv
   ```
   {: pre}

   対象の永続ストレージに属する PV を探します。 PV は `released` 状態になっています。

2. PV の詳細情報を取得します。
   ```
   kubectl describe pv <pv_name>
   ```
   {: pre}

3. `CapacityGb`、`storageClass`、`failure-domain.beta.kubernetes.io/region`、`failure-domain.beta.kubernetes.io/zone`、`server`、`path` をメモします。

4. PV を削除します。
   ```
   kubectl delete pv <pv_name>
   ```
   {: pre}

5. PV が削除されたことを確認します。
   ```
   kubectl get pv
   ```
   {: pre}

</br>

**クラスターの外部にプロビジョンされた永続ストレージの場合** </br>
以前にプロビジョンして、まだクラスターで使用したことがない既存のストレージを使用するには、そのストレージをワーカー・ノードと同じサブネットで使用できるようにする必要があります。

専用アカウントがある場合は、[サポート・ケースを開く](/docs/get-support/howtogetsupport.html#getting-customer-support)必要があります。
{: note}

1.  {: #external_storage}[IBM Cloud インフラストラクチャー (SoftLayer) ポータル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://control.bluemix.net/) で、**「ストレージ」**をクリックします。
2.  **「File Storage」**をクリックして、**「アクション」**メニューから**「ホストの許可」**を選択します。
3.  **「サブネット」**を選択します。
4.  ドロップダウン・リストから、ワーカー・ノードが接続されているプライベート VLAN サブネットを選択します。 ワーカー・ノードのサブネットを見つけるには、`ibmcloud ks workers <cluster_name>` を実行して、ワーカー・ノードの `Private IP` をドロップダウン・リストにあるサブネットと比較します。
5.  **「送信」**をクリックします。
6.  ファイル・ストレージの名前をクリックします。
7.  `マウント・ポイント`、`サイズ`、`ロケーション`のフィールドをメモします。 `マウント・ポイント`のフィールドは `<nfs_server>:<file_storage_path>` として表示されます。

### ステップ 2: 永続ボリューム (PV) および対応する永続ボリューム請求 (PVC) を作成する

1.  PV のストレージ構成ファイルを作成します。 先ほど取得した値を含めます。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
     labels:
        failure-domain.beta.kubernetes.io/region: <region>
        failure-domain.beta.kubernetes.io/zone: <zone>
    spec:
     capacity:
       storage: "<size>"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "<nfs_server>"
       path: "<file_storage_path>"
    ```
    {: codeblock}

    <table>
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>作成する PV オブジェクトの名前を入力します。</td>
    </tr>
    <tr>
    <td><code>metadata.labels</code></td>
    <td>先ほど取得した地域とゾーンを入力します。 クラスターでストレージをマウントするには、永続ストレージと同じ地域およびゾーンに少なくとも 1 つのワーカー・ノードが存在していなければなりません。 ストレージの PV が既に存在する場合は、PV に[ゾーンおよび地域のラベルを追加](cs_storage_basics.html#multizone)します。
    </tr>
    <tr>
    <td><code>spec.capacity.storage</code></td>
    <td>先ほど取得した既存の NFS ファイル共有のストレージ・サイズを入力します。 このストレージ・サイズはギガバイト単位 (例えば、20Gi (20 GB) や 1000Gi (1 TB) など) で入力する必要があり、そのサイズは既存のファイル共有のサイズと一致している必要があります。</td>
    </tr>
    <tr>
    <td><code>spec.accessMode</code></td>
    <td>次のオプションのいずれかを指定してください。 <ul><li><strong>ReadWriteMany: </strong>PVC は複数のポッドによってマウントできます。 すべてのポッドは、ボリュームに対する読み取りと書き込みを行うことができます。 </li><li><strong>ReadOnlyMany: </strong>PVC は複数のポッドによってマウントできます。 すべてのポッドには読み取り専用アクセス権限があります。 <li><strong>ReadWriteOnce: </strong>PVC は 1 つのポッドのみによってマウントできます。 このポッドは、ボリュームに対して読み取りと書き込みを行うことができます。 </li></ul></td>
    </tr>
    <tr>
    <td><code>spec.nfs.server</code></td>
    <td>先ほど取得した NFS ファイル共有サーバーの ID を入力します。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>先ほど取得した NFS ファイル共有のパスを入力します。</td>
    </tr>
    </tbody></table>

3.  クラスターに PV を作成します。

    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4.  PV が作成されたことを確認します。

    ```
    kubectl get pv
    ```
    {: pre}

5.  PVC を作成するために、別の構成ファイルを作成します。 PVC が、前の手順で作成した PV と一致するようにするには、`storage` および `accessMode` に同じ値を選択する必要があります。 `storage-class` フィールドは空である必要があります。 これらのいずれかのフィールドが PV と一致しない場合は、新しい PV と新しい物理ストレージ・インスタンスが[動的にプロビジョン](cs_storage_basics.html#dynamic_provisioning)されます。

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
         storage: "<size>"
    ```
    {: codeblock}

6.  PVC を作成します。

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

7.  PVC が作成され、PV にバインドされたことを確認します。 この処理には数分かかる場合があります。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    出力例:

    ```
    Name: mypvc
     Namespace: default
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
      3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


PV が正常に作成され、PVC にバインドされました。 これで、クラスター・ユーザーがデプロイメントに[PVC をマウント](#app_volume_mount)して、PV オブジェクトへの読み書きを開始できるようになりました。

<br />



## ステートフル・セットでのファイル・ストレージの使用
{: #file_statefulset}

データベースなどのステートフルなアプリがある場合は、そのアプリのデータを保管するために、ファイル・ストレージを使用するステートフル・セットを作成することができます。 別の方法として、{{site.data.keyword.Bluemix_notm}} Database as a Service を使用し、クラウドにデータを保管することもできます。
{: shortdesc}

**ファイル・ストレージをステートフル・セットに追加する場合、どんな点に留意する必要がありますか?** </br>
ストレージをステートフル・セットに追加するには、ステートフル・セット YAML の `volumeClaimTemplates` セクションでストレージ構成を指定します。 `volumeClaimTemplates` は、PVC の基礎となるもので、プロビジョンするファイル・ストレージのストレージ・クラスとサイズ (または IOPS) を含めることができます。 ただし、`volumeClaimTemplates` にラベルを含める場合、Kubernetes による PVC の作成時にそれらのラベルは組み込まれません。 その代わりに、自分で直接、それらのラベルをステートフル・セットに追加する必要があります。

2 つのステートフル・セットを同時にデプロイすることはできません。 1 つのステートフル・セットが完全にデプロイされる前に別のステートフル・セットを作成しようとすると、ステートフル・セットのデプロイメントが予期しない結果となる可能性があります。
{: important}

**ステートフル・セットをどのように特定のゾーンに作成できますか?** </br>
複数ゾーン・クラスターでは、ステートフル・セット YAML の `spec.selector.matchLabels` および `spec.template.metadata.labels` セクションで、ステートフル・セットを作成するゾーンと地域を指定することができます。 あるいは、それらのラベルを[カスタマイズ・ストレージ・クラス](cs_storage_basics.html#customized_storageclass)に追加し、このストレージ・クラスをステートフル・セットの `volumeClaimTemplates` セクションで使用することもできます。

**ステートフル・セットにファイル・ストレージを追加するときに選択できるどんなオプションがありますか?** </br>
ステートフル・セットを作成するときに PVC を自動的に作成する場合は、[動的プロビジョニング](#dynamic_statefulset)を使用します。 また、ステートフル・セットで使用するために [PVC を事前プロビジョンするか、既存の PVC を使用する](#static_statefulset)こともできます。  

### ステートフル・セットの作成時に PVC を動的にプロビジョンする
{: #dynamic_statefulset}

このオプションは、ステートフル・セットを作成するときに PVC を自動的に作成する場合に使用します。
{: shortdesc}

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

1. クラスターにある既存のすべてのステートフル・セットが完全にデプロイ済みであることを確認します。 デプロイ中のステートフル・セットがある場合は、ステートフル・セットの作成を開始できません。 予期しない結果が生じるのを避けるため、クラスター内のすべてのステートフル・セットが完全にデプロイされるまで待つ必要があります。
   1. クラスター内の既存のステートフル・セットをリストします。
      ```
      kubectl get statefulset --all-namespaces
      ```
      {: pre}

      出力例:
      ```
      NAME              DESIRED   CURRENT   AGE
      mystatefulset     3         3         6s
      ```
      {: screen}

   2. ステートフル・セットのデプロイメントが完了していることを確かめるため、各ステートフル・セットの **Pods Status** を確認します。  
      ```
      kubectl describe statefulset <statefulset_name>
      ```
      {: pre}

      出力例:
      ```
      Name:               nginx
      Namespace:          default
      CreationTimestamp:  Fri, 05 Oct 2018 13:22:41 -0400
      Selector:           app=nginx,billingType=hourly,region=us-south,zone=dal10
      Labels:             app=nginx
                          billingType=hourly
                          region=us-south
                          zone=dal10
      Annotations:        kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"apps/v1beta1","kind":"StatefulSet","metadata":{"annotations":{},"name":"nginx","namespace":"default"},"spec":{"podManagementPolicy":"Par...
      Replicas:           3 desired | 3 total
      Pods Status:        0 Running / 3 Waiting / 0 Succeeded / 0 Failed
      Pod Template:
        Labels:  app=nginx
                 billingType=hourly
                 region=us-south
                 zone=dal10
      ...
      ```
      {: screen}

      CLI 出力の **Replicas** セクションに示されたレプリカの数が、**Pods Status** セクションの **Running** ポッドの数と等しい場合は、ステートフル・セットが完全にデプロイ済みです。 ステートフル・セットがまだ完全にデプロイされていない場合は、デプロイメントが完了するまで待ってから、次に進んでください。

3. ステートフル・セットと、そのステートフル・セットを公開するために使用するサービスに関する、構成ファイルを作成します。 下記の例は、3 つのレプリカを伴うステートフル・セットとして nginx をデプロイする方法を示しています。 レプリカごとに、`ibmc-file-retain-bronze` ストレージ・クラスで定義された仕様に基づいて、20 ギガバイトのファイル・ストレージ・デバイスがプロビジョンされます。 すべてのストレージ・デバイスは `dal10` ゾーンでプロビジョンされます。 ファイル・ストレージは他のゾーンからアクセスできないため、ステートフル・セットのすべてのレプリカも、`dal10` に配置されたワーカー・ノードにデプロイされます。

   ```
   apiVersion: v1
   kind: Service
   metadata:
    name: nginx
    labels:
      app: nginx
   spec:
    ports:
    - port: 80
      name: web
    clusterIP: None
    selector:
      app: nginx
   ---
   apiVersion: apps/v1beta1
   kind: StatefulSet
   metadata:
    name: nginx
   spec:
    serviceName: "nginx"
    replicas: 3
    podManagementPolicy: Parallel
    selector:
      matchLabels:
        app: nginx
        billingType: "hourly"
        region: "us-south"
        zone: "dal10"
    template:
      metadata:
        labels:
          app: nginx
          billingType: "hourly"
          region: "us-south"
          zone: "dal10"
      spec:
        containers:
        - name: nginx
          image: k8s.gcr.io/nginx-slim:0.8
          ports:
          - containerPort: 80
            name: web
          volumeMounts:
          - name: myvol
            mountPath: /usr/share/nginx/html
    volumeClaimTemplates:
    - metadata:
        annotations:
          volume.beta.kubernetes.io/storage-class: ibmc-file-retain-bronze
        name: myvol
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 20Gi
            iops: "300" #required only for performance storage
   ```
   {: codeblock}

   <table>
    <caption>ステートフル・セット YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ステートフル・セット YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td style="text-align:left"><code>metadata.name</code></td>
    <td style="text-align:left">ステートフル・セットに対する名前を入力します。 入力した名前が使用されて、PVC の名前が次の形式で作成されます: <code>&lt;volume_name&gt;-&lt;statefulset_name&gt;-&lt;replica_number&gt;</code>。 </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.serviceName</code></td>
    <td style="text-align:left">ステートフル・セットを公開するために使用するサービスの名前を入力します。 </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.replicas</code></td>
    <td style="text-align:left">ステートフル・セットのレプリカの数を入力します。 </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.podManagementPolicy</code></td>
    <td style="text-align:left">ステートフル・セットで使用するポッド管理ポリシーを入力します。 次のいずれかのオプションを選択します。 <ul><li><strong>OrderedReady: </strong>このオプションを指定すると、ステートフル・セット・レプリカが 1 つずつデプロイされます。 例えば、3 つのレプリカを指定した場合、Kubernetes は 1 番目のレプリカの PVC を作成し、PVC がバインドされるまで待機し、ステートフル・セット・レプリカをデプロイし、PVC をレプリカにマウントします。 このデプロイメントが完了したら、2 番目のレプリカがデプロイされます。 このオプションについて詳しくは、[OrderedReady Pod Management ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#orderedready-pod-management) を参照してください。 </li><li><strong>Parallel: </strong>このオプションを指定すると、ステートフル・セット・レプリカのすべてのデプロイメントが同時に開始します。 アプリでレプリカの並行デプロイメントをサポートしている場合は、このオプションを使用して、PVC とステートフル・セット・レプリカをデプロイする時間を節約してください。 </li></ul></td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.selector.matchLabels</code></td>
    <td style="text-align:left">ステートフル・セットと PVC に含めるすべてのラベルを入力します。 ステートフル・セットの <code>volumeClaimTemplates</code> に含めたラベルは、Kubernetes によって認識されません。 含めることができるサンプル・ラベルには次のものがあります。 <ul><li><code><strong>region</strong></code> および <code><strong>zone</strong></code>: ステートフル・セット・レプリカと PVC のすべてを、1 つの特定のゾーンに作成する場合は、これらのラベルを両方とも追加します。 また、使用するストレージ・クラスでゾーン (zone) と地域 (region) を指定することもできます。 ゾーンと地域を指定せず、複数ゾーン・クラスターを使用している場合、ボリューム要求をすべてのゾーン間で均等に分散させるために、ストレージは、ラウンドロビン・ベースで選択されたゾーンにプロビジョンされます。</li><li><code><strong>billingType</strong></code>: PVC で使用する課金タイプを入力します。 <code>hourly</code> または <code>monthly</code> のいずれかを選択します。 このラベルを指定しない場合、すべての PVC が時間単位 (hourly) の課金タイプで作成されます。 </li></ul></td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.template.metadata.labels</code></td>
    <td style="text-align:left"><code>spec.selector.matchLabels</code> セクションに追加したラベルと同じラベルを入力します。 </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.metadata.</code></br><code>annotations.volume.beta.</code></br><code>kubernetes.io/storage-class</code></td>
    <td style="text-align:left">使用するストレージ・クラスを入力します。 既存のストレージ・クラスをリストするには、<code>kubectl get storageclasses | grep file</code> を実行します。 ストレージ・クラスを指定しなかった場合は、クラスターで設定されているデフォルト・ストレージ・クラスを使用して PVC が作成されます。 ファイル・ストレージを使用してステートフル・セットがプロビジョンされるようにするために、デフォルト・ストレージ・クラスで <code>ibm.io/ibmc-file</code> プロビジョナーが使用されていることを確認してください。</td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.metadata.name</code></td>
    <td style="text-align:left">ボリュームの名前を入力します。 <code>spec.containers.volumeMount.name</code> セクションで定義した名前と同じ名前を使用します。 ここに入力した名前が使用されて、PVC の名前が次の形式で作成されます: <code>&lt;volume_name&gt;-&lt;statefulset_name&gt;-&lt;replica_number&gt;</code>。 </td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.spec.resources.</code></br><code>requests.storage</code></td>
    <td style="text-align:left">ファイル・ストレージのサイズをギガバイト (Gi) 単位で入力します。</td>
    </tr>
    <tr>
    <td style="text-align:left"><code>spec.volumeClaimTemplates.spec.resources.</code></br><code>requests.iops</code></td>
    <td style="text-align:left">[パフォーマンス・ストレージ](#predefined_storageclass)をプロビジョンする場合は、IOPS 数を入力します。 エンデュランス・ストレージ・クラスを使用することにして IOPS 数を指定した場合は、IOPS 数が無視されます。 その代わりに、そのストレージ・クラスで指定されている IOPS が使用されます。  </td>
    </tr>
    </tbody></table>

4. ステートフル・セットを作成します。
   ```
   kubectl apply -f statefulset.yaml
   ```
   {: pre}

5. ステートフル・セットがデプロイされるまで待ちます。
   ```
   kubectl describe statefulset <statefulset_name>
   ```
   {: pre}

   PVC の現在の状況を確認するには、`kubectl get pvc` を実行します。 PVC の名前は `<volume_name>-<statefulset_name>-<replica_number>` というフォーマットになります。
   {: tip}

### ステートフル・セットの作成前に PVC を事前プロビジョンする
{: #static_statefulset}

ステートフル・セットを作成する前に PVC を事前プロビジョンするか、既存の PVC をステートフル・セットで使用することができます。
{: shortdesc}

[ステートフル・セットの作成時に PVC を動的にプロビジョンする](#dynamic_statefulset)場合は、ステートフル・セット YAML ファイルで使用した値に基づいて、PVC の名前が割り当てられます。 ステートフル・セットによって既存の PVC が使用されるようにするには、PVC の名前が、動的プロビジョニングを使用する場合に自動的に作成される名前と一致していなければなりません。

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

1. [ファイル・ストレージをアプリに追加する](#add_file)のステップ 1 から 3 に従って、それぞれのステートフル・セット・レプリカのために PVC を作成します。 作成する PVC の名前は、必ず次のフォーマットに従ったものにしてください: `<volume_name>-<statefulset_name>-<replica_number>`。
   - **`<volume_name>`**: ステートフル・セットの `spec.volumeClaimTemplates.metadata.name` セクションで指定する名前を使用します (例: `nginxvol`)。
   - **`<statefulset_name>`**: ステートフル・セットの `metadata.name` セクションで指定する名前を使用します (例: `nginx_statefulset`)。
   - **`<replica_number>`**: 0 から始まる、レプリカの番号を入力します。

   例えば、3 つのステートフル・セット・レプリカを作成する必要がある場合は、次の名前を使用して 3 つの PVC を作成します: `nginxvol-nginx_statefulset-0`、`nginxvol-nginx_statefulset-1`、`nginxvol-nginx_statefulset-2`。  

2. [ステートフル・セットの作成時に PVC を動的にプロビジョンする](#dynamic_statefulset)のステップに従って、ステートフル・セットを作成します。 ステートフル・セット仕様における PVC 名の値を必ず使用してください。
   - **`spec.volumeClaimTemplates.metadata.name`**: 前のステップで使用した `<volume_name>` を入力します。
   - **`metadata.name`**: 前のステップで使用した `<statefulset_name>` を入力します。
   - **`spec.replicas`**: 作成するステートフル・セット・レプリカの数を入力します。 レプリカの数は、先ほど作成した PVC の数と等しくなければなりません。

   PVC を別々のゾーンに作成した場合、ステートフル・セットに地域またはゾーンのラベルを含めないでください。
   {: note}

3. PVC がステートフル・セット・レプリカ・ポッドで使用されることを確認します。
   1. クラスター内のポッドをリストします。 ステートフル・セットに属するポッドを確認します。
      ```
      kubectl get pods
      ```
      {: pre}

   2. 既存の PVC がステートフル・セット・レプリカにマウントされていることを確認します。 CLI 出力の **Volumes** セクションで **ClaimName** を確認してください。
      ```
      kubectl describe pod <pod_name>
      ```
      {: pre}

      出力例:
      ```
      Name:           nginx-0
      Namespace:      default
      Node:           10.xxx.xx.xxx/10.xxx.xx.xxx
      Start Time:     Fri, 05 Oct 2018 13:24:59 -0400
      ...
      Volumes:
        myvol:
          Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
          ClaimName:  myvol-nginx-0
     ...
      ```
      {: screen}

<br />


## 既存のストレージ・デバイスのサイズと IOPS の変更
{: #change_storage_configuration}

ストレージ容量またはパフォーマンスを向上させるために既存のボリュームを変更することができます。
{: shortdesc}

課金方法について不明な点がある場合や、{{site.data.keyword.Bluemix_notm}} コンソールを使用してストレージを変更する手順を調べたい場合は、[ファイル共有容量の拡張](/docs/infrastructure/FileStorage/expandable_file_storage.html#expanding-file-share-capacity)を参照してください。
{: tip}

1. クラスターの PVC をリストし、**VOLUME** 列に表示される関連 PV の名前をメモします。 
   ```
   kubectl get pvc
   ```
   {: pre}
   
   出力例: 
   ```
   NAME             STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
   myvol            Bound     pvc-01ac123a-123b-12c3-abcd-0a1234cb12d3   20Gi       RWX            ibmc-file-bronze    147d
   ```
   {: screen}
   
2. PVC がバインドされている PV の詳細をリストして、PVC に関連付けられている物理ファイル・ストレージの **StorageType**、**volumeId**、および **server** を取得します。`<pv_name>` を前のステップで取得した PV の名前に置き換えてください。ストレージ・タイプ、ボリューム ID、およびサーバー名は、CLI 出力の **Labels** セクションに表示されます。 
   ```
   kubectl describe pv <pv_name>
   ```
   {: pre}
   
   出力例: 
   ```
   Name:            pvc-4b62c704-5f77-11e8-8a75-b229c11ba64a
   Labels:          CapacityGb=20
                    Datacenter=dal10
                    Iops=2
                    StorageType=ENDURANCE
                    Username=IBM02SEV1543159_6
                    billingType=hourly
                    failure-domain.beta.kubernetes.io/region=us-south
                    failure-domain.beta.kubernetes.io/zone=dal10
                    path=IBM01SEV1234567_8ab12t
                    server=fsf-dal1001g-fz.adn.networklayer.com
                    volumeId=12345678
   ...
   ```
   {: screen}

3. IBM Cloud インフラストラクチャー (SoftLayer) アカウントでボリュームのサイズまたは IOPS を変更します。 

   パフォーマンス・ストレージの例: 
   ```
   ibmcloud sl file volume-modify <volume_ID> --new-size <size> --new-iops <iops>
   ```
   {: pre}
   
   エンデュランス・ストレージの例: 
   ```
   ibmcloud sl file volume-modify <volume_ID> --new-size <size> --new-tier <iops>
   ```
   {: pre}
   
   <table>
   <caption>コマンドのコンポーネントについて</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;volume_ID&gt;</code></td>
   <td>前に取得したボリュームの ID を入力します。</td>
   </tr>
   <tr>
   <td><code>&lt;new-size&gt;</code></td>
   <td>ボリュームの新しいサイズをギガバイト (Gi) 単位で入力します。 有効なサイズについては、[ファイル・ストレージ構成の決定](#predefined_storageclass)を参照してください。 入力するサイズは、ボリュームの現行サイズ以上でなければなりません。 新しいサイズを指定しない場合、ボリュームの現行サイズが使用されます。</td>
   </tr>
   <tr>
   <td><code>&lt;new-iops&gt;</code></td>
   <td>パフォーマンス・ストレージのみ。 必要な新しい IOPS 数を入力します。 有効な IOPS については、[ファイル・ストレージ構成の決定](#predefined_storageclass)を参照してください。 IOPS を指定しない場合は、現在の IOPS が使用されます。<p class="note">ボリュームの元の IOPS/GB 率が 0.3 未満の場合、新しい IOPS/GB 率も 0.3 未満にする必要があります。 ボリュームの元の IOPS/GB 率が 0.3 以上の場合、ボリュームの新しい IOPS/GB 率も 0.3 以上にする必要があります。</p> </td>
   </tr>
   <tr>
   <td><code>&lt;new-tier&gt;</code></td>
   <td>エンデュランス・ストレージのみ。 必要な新しい IOPS 数/GB を入力します。 有効な IOPS については、[ファイル・ストレージ構成の決定](#predefined_storageclass)を参照してください。 IOPS を指定しない場合は、現在の IOPS が使用されます。<p class="note">ボリュームの元の IOPS/GB 率が 0.25 未満の場合、新しい IOPS/GB 率も 0.25 未満にする必要があります。 ボリュームの元の IOPS/GB 率が 0.25 以上の場合、ボリュームの新しい IOPS/GB 率も 0.25 以上にする必要があります。</p> </td>
   </tr>
   </tbody>
   </table>
   
   出力例: 
   ```
   Order 31020713 was placed successfully!.
   > Storage as a Service

   > 40 GBs

   > 2 IOPS per GB

   > 20 GB Storage Space (Snapshot Space)

   You may run 'ibmcloud sl file volume-list --order 12345667' to find this file volume after it is ready.
   ```
   {: screen}
   
4. サイズを変更したボリュームをポッドで使用する場合は、ポッドにログインして新しいサイズを確認します。 
   1. PVC を使用するすべてのポッドをリストします。
      ```
      kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"
      ```
      {: pre}
      
      ポッドは、`<pod_name>: <pvc_name>` の形式で返されます。
   2. ポッドにログインします。 
      ```
      kubectl exec -it <pod_name> bash
      ```
      {: pre}
      
   3. ディスク使用量の統計を表示し、前に取得したボリュームのサーバー・パスを見つけます。
      ```
      df -h
      ```
      {: pre}
      
      出力例: 
      ```
      Filesystem                                                      Size  Used Avail Use% Mounted on
      overlay                                                          99G  4.8G   89G   6% /
      tmpfs                                                            64M     0   64M   0% /dev
      tmpfs                                                           7.9G     0  7.9G   0% /sys/fs/cgroup
      fsf-dal1001g-fz.adn.networklayer.com:/IBM01SEV1234567_6/data01   40G     0   40G   0% /myvol
      ```
      {: screen}
   

## デフォルトの NFS バージョンの変更
{: #nfs_version}

ファイル・ストレージのバージョンによって、{{site.data.keyword.Bluemix_notm}} ファイル・ストレージ・サーバーとの通信に使用されるプロトコルが決まります。 デフォルトでは、すべてのファイル・ストレージ・インスタンスは NFS バージョン 4 でセットアップされます。アプリが正しく機能するために特定のバージョンが必要な場合は、既存の PV を古い NFS バージョンに変更できます。
{: shortdesc}

デフォルトの NFS バージョンを変更するには、新規ストレージ・クラスを作成してクラスター内のファイル・ストレージを動的にプロビジョンするか、ポッドにマウントされている既存の PV を変更します。

最新のセキュリティー更新を適用し、パフォーマンスを向上させるには、デフォルトの NFS バージョンを使用し、古い NFS バージョンに変更しないでください。
{: important}

**必要な NFS バージョンでカスタマイズしたストレージ・クラスを作成するには、以下のようにします。**
1. プロビジョンする NFS バージョンを指定して、[カスタマイズしたストレージ・クラス](#nfs_version_class)を作成します。
2. クラスター内にストレージ・クラスを作成します。
   ```
   kubectl apply -f nfsversion_storageclass.yaml
   ```
   {: pre}

3. カスタマイズしたストレージ・クラスが作成されたことを確認します。
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. カスタマイズしたストレージ・クラスで[ファイル・ストレージ](#add_file)をプロビジョンします。

**別の NFS バージョンを使用するように既存の PV を変更するには、以下のようにします。**

1. NFS バージョンを変更するファイル・ストレージの PV を取得し、PV の名前をメモします。
   ```
   kubectl get pv
   ```
   {: pre}

2. PV にアノテーションを追加します。 `<version_number>` を、使用する NFS バージョンで置き換えます。 例えば、NFS バージョン 3.0 に変更するには、**3** を入力します。  
   ```
   kubectl patch pv <pv_name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<version_number>"}}}'
   ```
   {: pre}

3. ファイル・ストレージを使用するポッドを削除し、ポッドを再作成します。
   1. ポッド yaml をローカル・マシンに保存します。
      ```
      kubect get pod <pod_name> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. ポッドを削除します。
      ```
      kubectl deleted pod <pod_name>
      ```
      {: pre}

   3. ポッドを再作成します。
      ```
      kubectl apply -f pod.yaml
      ```
      {: pre}

4. ポッドがデプロイされるまで待ちます。
   ```
   kubectl get pods
   ```
   {: pre}

   status が `Running` に変更されたら、ポッドは完全にデプロイされています。

5. ポッドにログインします。
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. 以前指定した NFS バージョンでファイル・ストレージがマウントされたことを確認します。
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   出力例:
   ```
   nfs vers=3.0
   ```
   {: screen}

<br />


## データのバックアップとリストア
{: #backup_restore}

ファイル・ストレージは、クラスター内のワーカー・ノードと同じロケーションにプロビジョンされます。 サーバーがダウンした場合の可用性を確保するために、IBM は、クラスター化したサーバーでストレージをホストしています。 ただし、ファイル・ストレージは自動的にはバックアップされないため、ロケーション全体で障害が発生した場合はアクセス不能になる可能性があります。 データの損失や損傷を防止するために、定期バックアップをセットアップすると、必要時にバックアップを使用してデータをリストアできます。
{: shortdesc}

ファイル・ストレージのバックアップとリストアのための以下のオプションを検討してください。

<dl>
  <dt>定期的なスナップショットをセットアップする</dt>
  <dd><p>[ファイル・ストレージの定期的なスナップショットをセットアップ](/docs/infrastructure/FileStorage/snapshots.html)できます。スナップショットとは、特定の時点のインスタンスの状態をキャプチャーした読み取り専用のイメージです。 スナップショットを保管するには、ファイル・ストレージでスナップショット・スペースを要求する必要があります。 スナップショットは、同じゾーン内の既存のストレージ・インスタンスに保管されます。 ユーザーが誤って重要なデータをボリュームから削除した場合に、スナップショットからデータをリストアできます。 <p class="note">: 専用アカウントがある場合は、[サポート・ケースを開く](/docs/get-support/howtogetsupport.html#getting-customer-support)必要があります。</p></br> <strong>ボリュームのスナップショットを作成するには、以下のようにします。</strong><ol><li>[アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。</li><li>`ibmcloud sl` CLI にログインします。 <pre class="pre"><code>    ibmcloud sl init
    </code></pre></li><li>クラスター内の既存の PV をリストします。 <pre class="pre"><code>kubectl get pv</code></pre></li><li>スナップショット・スペースを作成する PV の詳細を取得し、ボリューム ID、サイズ、および IOPS をメモします。 <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> ボリューム ID、サイズ、および IOPS は CLI 出力の <strong>Labels</strong> セクションにあります。 </li><li>前のステップで取得したパラメーターを使用して、既存のボリュームのスナップショット・サイズを作成します。 <pre class="pre"><code>ibmcloud sl file snapshot-order &lt;volume_ID&gt; --size &lt;size&gt; --tier &lt;iops&gt;</code></pre></li><li>スナップショット・サイズが作成されるまで待ちます。 <pre class="pre"><code>ibmcloud sl file volume-detail &lt;volume_ID&gt;</code></pre>CLI 出力の <strong>Snapshot Size (GB)</strong> が 0 から注文したサイズに変更されていれば、スナップショット・サイズは正常にプロビジョンされています。 </li><li>ボリュームのスナップショットを作成し、作成されたスナップショットの ID をメモします。 <pre class="pre"><code>ibmcloud sl file snapshot-create &lt;volume_ID&gt;</code></pre></li><li>スナップショットが正常に作成されたことを確認します。 <pre class="pre"><code>ibmcloud sl file snapshot-list &lt;volume_ID&gt;</code></pre></li></ol></br><strong>スナップショットから既存のボリュームにデータをリストアするには、以下のようにします。</strong><pre class="pre"><code>ibmcloud sl file snapshot-restore &lt;volume_ID&gt; &lt;snapshot_ID&gt;</code></pre></p></dd>
  <dt>スナップショットを別のゾーンにレプリケーションする</dt>
 <dd><p>ゾーンの障害からデータを保護するために、別のゾーンにセットアップしたファイル・ストレージのインスタンスに[スナップショットをレプリケーション](/docs/infrastructure/FileStorage/replication.html#replicating-data)することができます。 データは、1 次ストレージからバックアップ・ストレージにのみレプリケーションできます。 レプリケーションされたファイル・ストレージのインスタンスを、クラスターにマウントすることはできません。 1 次ストレージに障害が発生した場合には、レプリケーションされたバックアップ・ストレージを 1 次ストレージに手動で設定できます。 すると、そのファイル共有をクラスターにマウントできます。 1 次ストレージがリストアされたら、バックアップ・ストレージからデータをリストアできます。 <strong>注</strong>: 専用アカウントがある場合は、スナップショットを別のゾーンに複製することはできません。</p></dd>
 <dt>ストレージを複製する</dt>
 <dd><p>元のストレージ・インスタンスと同じゾーンに、[ファイル・ストレージ・インスタンスを複製](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage)できます。 複製インスタンスのデータは、それを作成した時点の元のストレージ・インスタンスと同じです。 レプリカとは異なり、複製インスタンスは、元のインスタンスから独立したストレージ・インスタンスとして使用します。 複製するには、まず、[ボリュームのスナップショットをセットアップします](/docs/infrastructure/FileStorage/snapshots.html)。 <strong>注</strong>: 専用アカウントがある場合は、<a href="/docs/get-support/howtogetsupport.html#getting-customer-support">サポート・ケースを開く</a>必要があります。</p></dd>
  <dt>{{site.data.keyword.cos_full}} にデータをバックアップする</dt>
  <dd><p>[**ibm-backup-restore image**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) を使用して、クラスター内にバックアップとリストアのポッドをスピンアップできます。 このポッドには、クラスター内の任意の永続ボリューム請求 (PVC) のために 1 回限りのバックアップまたは定期バックアップを実行するスクリプトが含まれています。 データは、ゾーンにセットアップした {{site.data.keyword.cos_full}} インスタンスに保管されます。</p>
  <p>データを可用性をさらに高め、アプリをゾーン障害から保護するには、2 つ目の {{site.data.keyword.cos_full}} インスタンスをセットアップして、ゾーン間でデータを複製します。 {{site.data.keyword.cos_full}} インスタンスからデータをリストアする必要がある場合は、イメージに付属するリストア・スクリプトを使用します。</p></dd>
<dt>ポッドおよびコンテナーとの間でデータをコピーする</dt>
<dd><p>`kubectl cp` [コマンド ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) を使用して、クラスター内のポッドまたは特定のコンテナーとの間でファイルとディレクトリーをコピーできます。</p>
<p>開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。 <code>-c</code> を使用してコンテナーを指定しない場合、コマンドはポッド内で最初に使用可能なコンテナーを使用します。</p>
<p>このコマンドは、以下のようにさまざまな方法で使用できます。</p>
<ul>
<li>ローカル・マシンからクラスター内のポッドにデータをコピーする: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>クラスター内のポッドからローカル・マシンにデータをコピーする: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>ローカル・マシンからクラスター内のポッドで実行される特定のコンテナーにデータをコピーする: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## ストレージ・クラス・リファレンス
{: #storageclass_reference}

### ブロンズ
{: #bronze}

<table>
<caption>ファイル・ストレージ・クラス: ブロンズ</caption>
<thead>
<th>特性</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名前</td>
<td><code>ibmc-file-bronze</code></br><code>ibmc-file-retain-bronze</code></td>
</tr>
<tr>
<td>タイプ</td>
<td>[エンデュランス・ストレージ](/docs/infrastructure/FileStorage/index.html#provisioning-with-endurance-tiers)</td>
</tr>
<tr>
<td>ファイル・システム</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS/GB</td>
<td>2</td>
</tr>
<tr>
<td>サイズの範囲 (ギガバイト単位)</td>
<td>20 から 12000 Gi</td>
</tr>
<tr>
<td>ハード・ディスク</td>
<td>SSD</td>
</tr>
<tr>
<td>課金</td>
<td>時間単位</td>
</tr>
<tr>
<td>料金設定</td>
<td>[料金情報 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>


### シルバー
{: #silver}

<table>
<caption>ファイル・ストレージ・クラス: シルバー</caption>
<thead>
<th>特性</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名前</td>
<td><code>ibmc-file-silver</code></br><code>ibmc-file-retain-silver</code></td>
</tr>
<tr>
<td>タイプ</td>
<td>[エンデュランス・ストレージ](/docs/infrastructure/FileStorage/index.html#provisioning-with-endurance-tiers)</td>
</tr>
<tr>
<td>ファイル・システム</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS/GB</td>
<td>4</td>
</tr>
<tr>
<td>サイズの範囲 (ギガバイト単位)</td>
<td>20 から 12000 Gi</td>
</tr>
<tr>
<td>ハード・ディスク</td>
<td>SSD</td>
</tr>
<tr>
<td>課金</td>
<td>時間単位</li></ul></td>
</tr>
<tr>
<td>料金設定</td>
<td>[料金情報 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### ゴールド
{: #gold}

<table>
<caption>ファイル・ストレージ・クラス: ゴールド</caption>
<thead>
<th>特性</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名前</td>
<td><code>ibmc-file-gold</code></br><code>ibmc-file-retain-gold</code></td>
</tr>
<tr>
<td>タイプ</td>
<td>[エンデュランス・ストレージ](/docs/infrastructure/FileStorage/index.html#provisioning-with-endurance-tiers)</td>
</tr>
<tr>
<td>ファイル・システム</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS/GB</td>
<td>10</td>
</tr>
<tr>
<td>サイズの範囲 (ギガバイト単位)</td>
<td>20 から 4000 Gi</td>
</tr>
<tr>
<td>ハード・ディスク</td>
<td>SSD</td>
</tr>
<tr>
<td>課金</td>
<td>時間単位</li></ul></td>
</tr>
<tr>
<td>料金設定</td>
<td>[料金情報 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### カスタム
{: #custom}

<table>
<caption>ファイル・ストレージ・クラス: カスタム</caption>
<thead>
<th>特性</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名前</td>
<td><code>ibmc-file-custom</code></br><code>ibmc-file-retain-custom</code></td>
</tr>
<tr>
<td>タイプ</td>
<td>[パフォーマンス](/docs/infrastructure/FileStorage/index.html#provisioning-with-performance)</td>
</tr>
<tr>
<td>ファイル・システム</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS とサイズ</td>
<td><p><strong>サイズの範囲 (ギガバイト単位) / IOPS の範囲 (100 の倍数)</strong></p><ul><li>20 から 39 Gi / 100 から 1000 IOPS</li><li>40 から 79 Gi / 100 から 2000 IOPS</li><li>80 から 99 Gi / 100 から 4000 IOPS</li><li>100 から 499 Gi / 100 から 6000 IOPS</li><li>500 から 999 Gi / 100 から 10000 IOPS</li><li>1000 から 1999 Gi / 100 から 20000 IOPS</li><li>2000 から 2999 Gi / 200 から 40000 IOPS</li><li>3000 から 3999 Gi / 200 から 48000 IOPS</li><li>4000 から 7999 Gi / 300 から 48000 IOPS</li><li>8000 から 9999 Gi / 500 から 48000 IOPS</li><li>10000 から 12000 Gi / 1000 から 48000 IOPS</li></ul></td>
</tr>
<tr>
<td>ハード・ディスク</td>
<td>ギガバイトに対する IOPS の比率によって、プロビジョンされるハード・ディスクのタイプが決まります。 ギガバイトに対する IOPS の比率を求めるには、IOPS をストレージ・サイズで除算します。 </br></br>例: </br>100 IOPS で 500Gi のストレージを選択しました。 比率は 0.2 です (100 IOPS/500Gi)。 </br></br><strong>比率に応じた大まかなハード・ディスクのタイプ</strong><ul><li>0.3 以下: SATA</li><li>0.3 より大: SSD</li></ul></td>
</tr>
<tr>
<td>課金</td>
<td>時間単位</li></ul></td>
</tr>
<tr>
<td>料金設定</td>
<td>[料金情報 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## ストレージ・クラスのカスタマイズ例
{: #custom_storageclass}

カスタマイズされたストレージ・クラスを作成し、PVC でそのストレージ・クラスを使用することができます。
{: shortdesc}

{{site.data.keyword.containerlong_notm}} では、特定の層と構成のファイル・ストレージをプロビジョンするための、[事前定義ストレージ・クラス](#storageclass_reference)が用意されています。 状況に応じて、それらの事前定義ストレージ・クラスではカバーされない、異なる構成のストレージをプロビジョンすることができます。 このトピックの例では、カスタマイズ・ストレージ・クラスのサンプルを示します。

カスタマイズ・ストレージ・クラスを作成するには、[ストレージ・クラスのカスタマイズ](cs_storage_basics.html#customized_storageclass)を参照してください。 それから、[カスタマイズ・ストレージ・クラスを PVC で使用](#add_file)します。

### 複数ゾーン・クラスターのゾーンを指定する
{: #multizone_yaml}

次の `.yaml` ファイルでカスタマイズしているストレージ・クラスは、非 retain の `ibm-file-silver` ストレージ・クラスに基づいています。`type` は `"Endurance"`、`iopsPerGB` は `4`、`sizeRange` は `"[20-12000]Gi"`、`reclaimPolicy` の設定は `"Delete"` です。 ゾーンは `dal12` と指定しています。 各項目に指定可能な値を選択するときには、`ibmc` ストレージ・クラスについての前述の情報が参考になります。 </br>

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-file-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-file
parameters:
  zone: "dal12"
  region: "us-south"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
  reclaimPolicy: "Delete"
  classVersion: "2"
```
{: codeblock}

### デフォルトの NFS バージョンの変更
{: #nfs_version_class}

次のストレージ・クラスは、[`ibmc-file-bronze` ストレージ・クラス](#bronze)を基にしてカスタマイズしたものであり、プロビジョンする NFS バージョンを定義できます。 例えば、NFS バージョン 3.0 をプロビジョンする場合は、`<nfs_version>` を **3.0** に置き換えます。
```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-file-mount
     #annotations:
     #  storageclass.beta.kubernetes.io/is-default-class: "true"
     labels:
       kubernetes.io/cluster-service: "true"
   provisioner: ibm.io/ibmc-file
   parameters:
     type: "Endurance"
     iopsPerGB: "2"
     sizeRange: "[1-12000]Gi"
     reclaimPolicy: "Delete"
     classVersion: "2"
     mountOptions: nfsvers=<nfs_version>
```
{: codeblock}
