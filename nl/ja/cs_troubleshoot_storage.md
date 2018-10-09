---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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
 


# クラスターのストレージのトラブルシューティング
{: #cs_troubleshoot_storage}

{{site.data.keyword.containerlong}} を使用する際は、ここに示すクラスターのストレージのトラブルシューティング手法を検討してください。
{: shortdesc}

より一般的な問題が起きている場合は、[クラスターのデバッグ](cs_troubleshoot.html)を試してください。
{: tip}

## 複数ゾーン・クラスターで、永続ボリュームをポッドにマウントできない
{: #mz_pv_mount}

{: tsSymptoms}
ご使用のクラスターは、前にワーカー・プール内になかったスタンドアロン・ワーカー・ノードを持つ単一ゾーン・クラスターでした。 アプリのポッドのデプロイメントに使用するために永続ボリューム (PV) について記述した永続ボリューム請求 (PVC) を正常にマウントしていました。 現在では、ワーカー・プールがあり、ゾーンをそのクラスターに追加済みですが、PV をポッドにマウントできません。

{: tsCauses}
複数ゾーン・クラスターの場合、ポッドが別のゾーン内のボリュームのマウントを試みないように、PV には次のラベルが必要です。
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

複数のゾーンにまたがることが可能なワーカー・プールを持つ新しいクラスターは、デフォルトで PV にラベルを付けます。 ワーカー・プールが導入されたときよりも前に、クラスターを作成していた場合、ラベルを手動で追加する必要があります。

{: tsResolve}
[クラスター内の PV を地域ラベルとゾーン・ラベルで更新します](cs_storage_basics.html#multizone)。

<br />


## ファイル・ストレージ: ワーカー・ノードのファイル・システムが読み取り専用に変更される
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
以下のいずれかの症状が見られることがあります。
- `kubectl get pods -o wide` を実行すると、同じワーカー・ノードで稼働している複数のポッドが `ContainerCreating` 状態で停滞していることが判明します。
- `kubectl describe` コマンドを実行すると、**Events** セクションに `MountVolume.SetUp failed for volume ... read-only file system` というエラーが表示されます。

{: tsCauses}
ワーカー・ノード上のファイル・システムは読み取り専用です。

{: tsResolve}
1.  ワーカー・ノード上またはコンテナー内に保管されている可能性のあるデータをバックアップします。
2.  既存のワーカー・ノードに対する短期的な解決策としては、ワーカー・ノードを再ロードします。
    <pre class="pre"><code>ibmcloud ks worker-reload &lt;cluster_name&gt; &lt;worker_ID&gt;</code></pre>

長期的な修正としては、[ワーカー・プールのマシン・タイプを更新します](cs_cluster_update.html#machine_type)。

<br />



## ファイル・ストレージ: 非 root ユーザーが NFS ファイル・ストレージのマウント・パスを所有しているとアプリが失敗する
{: #nonroot}

{: tsSymptoms}
デプロイメントに [NFS ストレージを追加](cs_storage_file.html#app_volume_mount)した後に、コンテナーのデプロイメントが失敗します。 コンテナーのログを取得すると、「書き込み権限」や「必要な権限がない」などのエラーが表示されることがあります。 ポッドが失敗し、再ロードが繰り返されます。

{: tsCauses}
デフォルトでは、非 root ユーザーには、NFS ベースのストレージのボリューム・マウント・パスに対する書き込み権限がありません。 一部の一般的なアプリのイメージ (Jenkins や Nexus3 など) は、マウント・パスを所有する非 root ユーザーを Dockerfile に指定しています。 この Dockerfile からコンテナーを作成すると、マウント・パスに対する非 root ユーザーの権限が不十分なために、コンテナーの作成は失敗します。 書き込み権限を付与するには、Dockerfile を変更して非 root ユーザーを root ユーザー・グループに一時的に追加してから、マウント・パスの権限を変更するか、または init コンテナーを使用します。

Helm チャートを使用してイメージをデプロイする場合は、init コンテナーを使用するように Helm デプロイメントを編集します。
{:tip}



{: tsResolve}
デプロイメントに [init コンテナー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) を指定すると、Dockerfile に指定された非 root ユーザーに、コンテナー内のボリューム・マウント・パスに対する書き込み権限を付与できます。 init コンテナーは、アプリ・コンテナーが開始される前に開始されます。 init コンテナーは、コンテナーの内部にボリューム・マウント・パスを作成し、そのマウント・パスを正しい (非 root) ユーザーが所有するように変更してから、クローズします。 その後、マウント・パスに書き込む必要がある非 root ユーザーでアプリ・コンテナーが開始されます。 パスは既に非 root ユーザーによって所有されているため、マウント・パスへの書き込みは成功します。 init コンテナーを使用したくない場合は、Dockerfile を変更して、非 root ユーザーに NFS ファイル・ストレージへのアクセス権限を追加できます。


始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

1.  アプリの Dockerfile を開き、ボリューム・マウント・パスに対する書き込み権限を付与するユーザーのユーザー ID (UID) とグループ ID (GID) を取得します。 Jenkins Dockerfile の例では、情報は以下のとおりです。
    - UID: `1000`
    - GID: `1000`

    **例**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  永続ボリューム請求 (PVC) を作成して、アプリに永続ストレージを追加します。 この例では、`ibmc-file-bronze` ストレージ・クラスを使用します。 使用可能なストレージ・クラスを確認するには、`kubectl get storageclasses` を実行します。

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

3.  PVC を作成します。

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  デプロイメント `.yaml` ファイルに、init コンテナーを追加します。 先ほど取得した UID と GID を指定します。

    ```
    initContainers:
    - name: initContainer # Or you can replace with any name
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Replace UID and GID with values from the Dockerfile
      volumeMounts:
      - name: volume # Or you can replace with any name
        mountPath: /mount # Must match the mount path in the args line
    ```
    {: codeblock}

    Jenkins デプロイメントの**例**:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  ポッドを作成して、PVC をポッドにマウントします。

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. ボリュームがポッドに正常にマウントされたことを確認します。 ポッド名と **Containers/Mounts** パスをメモします。

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **出力例**:

    ```
    Name:       mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type:	PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName:	mypvc
        ReadOnly:	  false

    ```
    {: screen}

7.  前にメモしたポッド名を使用して、ポッドにログインします。

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. コンテナーのマウント・パスの権限を確認します。 この例では、マウント・パスは `/var/jenkins_home` です。

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **出力例**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    この出力は、Dockerfile の GID と UID (この例では `1000` と `1000`) がコンテナー内部のマウント・パスを所有していることを示しています。

<br />


## ファイル・ストレージ: 永続ストレージに対する非 root ユーザー・アクセスの追加が失敗する
{: #cs_storage_nonroot}

{: tsSymptoms}
[永続ストレージに対する非 root ユーザーのアクセスを追加した](#nonroot)後、または、非 root ユーザーの ID を指定して Helm チャートをデプロイした後に、そのユーザーがマウントされたストレージに書き込めません。

{: tsCauses}
デプロイメント構成または Helm チャートの構成で、ポッドの `fsGroup` (グループ ID) と `runAsUser` (ユーザー ID) に対して[セキュリティー・コンテキスト](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)が指定されています。 現在、{{site.data.keyword.containerlong_notm}} では `fsGroup` の指定をサポートしていません。`0` (ルート権限) に設定された `runAsUser` だけをサポートしています。

{: tsResolve}
イメージ、デプロイメント、または Helm チャートの構成ファイルから構成の `fsGroup` と `runAsUser` の `securityContext` フィールドを削除してから、再デプロイします。 マウント・パスの所有権を `nobody` から変更する必要がある場合は、[非 root ユーザー・アクセスを追加します](#nonroot)。 [非 root の initContainer](#nonroot) を追加した後、ポッド・レベルではなくコンテナー・レベルで `runAsUser` を設定します。

<br />




## ブロック・ストレージ: ファイル・システムが正しくないため、既存のブロック・ストレージをポッドにマウントできない
{: #block_filesystem}

{: tsSymptoms}
`kubectl describe pod<pod_name>` を実行すると、以下のエラーが表示されます。
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
`XFS` ファイル・システムでセットアップされている、既存のブロック・ストレージ・デバイスがあります。 このデバイスをポッドにマウントするために、`spec/flexVolume/fsType` セクションでファイル・システムとして `ext4` を指定しているか、またはファイル・システムを指定していない [PV を作成](cs_storage_block.html#existing_block)しました。 ファイル・システムが定義されていない場合、PV はデフォルトで `ext4` に設定されます。
PV は正常に作成され、既存のブロック・ストレージ・インスタンスにリンクされました。 ところが、対応する PVC を使用してクラスターに PV をマウントしようとすると、ボリュームのマウントが失敗します。 `ext4` ファイル・システムが指定された `XFS` ブロック・ストレージ・インスタンスをポッドにマウントすることができません。

{: tsResolve}
既存の PV のファイル・システムを `ext4` から `XFS` に更新します。

1. クラスター内の既存の PV をリストし、既存のブロック・ストレージ・インスタンスに使用している PV の名前をメモします。
   ```
   kubectl get pv
   ```
   {: pre}

2. ローカル・マシンに PV yaml を保存します。
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. yaml ファイルを開き、`fsType` を `ext4` から `xfs` に変更します。
4. クラスター内の PV を置き換えます。
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. PV をマウントしたポッドにログインします。
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. ファイル・システムが `XFS` に変更されたことを確認します。
   ```
   df -Th
   ```
   {: pre}

   出力例:
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## オブジェクト・ストレージ: {{site.data.keyword.cos_full_notm}} `ibmc` Helm プラグインのインストールが失敗する
{: #cos_helm_fails}

{: tsSymptoms}
{{site.data.keyword.cos_full_notm}} `ibmc` Helm プラグインをインストールすると、インストールが失敗し、以下のエラーが発生します。 
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
`ibmc` Helm プラグインがインストールされると、`./helm/plugins/helm-ibmc` ディレクトリーから、`ibmc` Helm プラグインがローカル・システムに置かれているディレクトリー (通常は `./ibmcloud-object-storage-plugin/helm-ibmc` にあります) へのシンボリック・リンクが作成されます。ローカル・システムから `ibmc` Helm プラグインを削除するか、または `ibmc` Helm プラグイン・ディレクトリーを別の場所に移動すると、シンボリック・リンクは削除されません。

{: tsResolve}
1. {{site.data.keyword.cos_full_notm}} Helm プラグインを削除します。 
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}
   
2. [{{site.data.keyword.cos_full_notm}} をインストールします](cs_storage_cos.html#install_cos)。 

<br />


## オブジェクト・ストレージ: Kubernetes シークレットが見つからないため、PVC またはポッドの作成が失敗する
{: #cos_secret_access_fails}

{: tsSymptoms}
PVC を作成するか、PVC をマウントするポッドをデプロイすると、作成またはデプロイメントが失敗します。 

- PVC の作成が失敗した場合のエラー・メッセージの例: 
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- ポッドの作成が失敗した場合のエラー・メッセージの例: 
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}
  
{: tsCauses}
{{site.data.keyword.cos_full_notm}} サービス資格情報を保管する Kubernetes シークレット、PVC、およびポッドのすべてが、同じ Kubernetes 名前空間に含まれていません。シークレットが PVC またはポッドとは異なる名前空間にデプロイされた場合、そのシークレットにはアクセスできません。 

{: tsResolve}
1. クラスター内のシークレットをリストし、{{site.data.keyword.cos_full_notm}} サービス・インスタンスの Kubernetes シークレットが作成される Kubernetes 名前空間を確認します。シークレットには、`ibm/ibmc-s3fs` が **Type** として表示される必要があります。 
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}
   
2. ご使用の PVC およびポッドの YAML 構成ファイルを確認して、同じ名前空間を使用したことを確認します。シークレットが存在する名前空間とは異なる名前空間にポッドをデプロイする場合は、目的の名前空間に[別のシークレットを作成](cs_storage_cos.html#create_cos_secret)します。 
   
3. 目的の名前空間に PVC を作成するか、ポッドをデプロイします。 

<br />


## オブジェクト・ストレージ: 資格情報が正しくないかアクセスが拒否されたために PVC の作成が失敗する
{: #cred_failure}

{: tsSymptoms}
PVC を作成すると、次のいずれかのようなエラー・メッセージが表示されます。 

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403
```
{: screen}

```
CredentialsEndpointError: failed to load credentials
```
{: screen}

{: tsCauses}
サービス・インスタンスへのアクセスに使用する {{site.data.keyword.cos_full_notm}} サービス資格情報が正しくないか、バケットに対する読み取りアクセスのみを許可している可能性があります。

{: tsResolve}
1. サービス詳細ページのナビゲーションで、**「サービス資格情報」**をクリックします。
2. 資格情報を見つけて、**「資格情報の表示」**をクリックします。 
3. Kubernetes シークレットで正しい **access_key_id** と **secret_access_key** を使用していることを確認します。そうでない場合は、Kubernetes シークレットを更新します。 
   1. シークレットの作成に使用した YAML を取得します。
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}
      
   2. **access_key_id** と **secret_access_key** を更新します。 
   3. シークレットを更新します。
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}
      
4. **iam_role_crn** セクションで、`Writer` または `Manager` の役割があることを確認します。正しい役割を持っていない場合は、[正しい権限で新しい {{site.data.keyword.cos_full_notm}} サービス資格情報を作成する](cs_storage_cos.html#create_cos_service)必要があります。その後、新しいサービス資格情報を使用して既存のシークレットを更新するか、[新しいシークレットを作成](cs_storage_cos.html#create_cos_secret)します。 

<br />


## オブジェクト・ストレージ: 既存のバケットにアクセスできない

{: tsSymptoms}
PVC を作成すると、{{site.data.keyword.cos_full_notm}} のバケットにアクセスできません。次のようなエラー・メッセージが表示されます。 

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
既存のバケットへのアクセスに正しくないストレージ・クラスを使用したか、作成しなかったバケットにアクセスしようとした可能性があります。 

{: tsResolve}
1. [{{site.data.keyword.Bluemix_notm}} ダッシュボード ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/dashboard/apps) から、{{site.data.keyword.cos_full_notm}} サービス・インスタンスを選択します。 
2. **「バケット」**を選択します。 
3. 既存のバケットの**クラス**および**場所**の情報を確認します。 
4. 該当する[ストレージ・クラス](cs_storage_cos.html#storageclass_reference)を選択します。 

<br />


## オブジェクト・ストレージ: 非 root ユーザーとしてのファイルへのアクセスが失敗する
{: #cos_nonroot_access}

{: tsSymptoms}
GUI または REST API を使用して、{{site.data.keyword.cos_full_notm}} サービス・インスタンスにファイルをアップロードしました。アプリ・デプロイメントで `runAsUser` で定義した非 root ユーザーを使用してこれらのファイルにアクセスしようとすると、ファイルへのアクセスは拒否されます。 

{: tsCauses}
Linux では、ファイルまたはディレクトリーには `Owner`、`Group`、および `Other` の 3 つのアクセス・グループがあります。GUI または REST API を使用してファイルを {{site.data.keyword.cos_full_notm}} にアップロードする場合、`Owner`、`Group`、および `Other` の権限が削除されます。各ファイルの権限は、以下のようになります。 

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

{{site.data.keyword.cos_full_notm}} プラグインを使用してファイルをアップロードすると、ファイルの権限が保持され、変更されません。 

{: tsResolve}
非 root ユーザーとしてファイルにアクセスするために、非 root ユーザーには、そのファイルに対する読み取り権限と書き込み権限が必要です。ポッドのデプロイメントの一部としてファイルに対するアクセス権を変更するには、書き込み操作が必要です。{{site.data.keyword.cos_full_notm}} は、書き込みワークロード用には設計されていません。ポッドのデプロイメント中に権限を更新すると、ポッドが `Running` 状態にならない場合があります。 

この問題を解決するには、PVC をアプリ・ポッドにマウントする前に、別のポッドを作成して非 root ユーザーに正しい権限を設定します。 

1. バケット内のファイルのアクセス権を確認します。 
   1. `test-permission` ポッドの構成ファイルを作成し、ファイルに `test-permission.yaml` という名前を付けます。
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc_name>
      ```
      {: codeblock}
        
   2. `test-permission` ポッドを作成します。 
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}
      
   3. ポッドにログインします。 
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}
   
   4. マウント・パスにナビゲートし、ファイルのアクセス権をリストします。
      ```
      cd test && ls -al
      ```
      {: pre}
      
      出力例: 
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}
      
2. ポッドを削除します。 
   ```
   kubectl delete pod test-permission
   ```
   {: pre}
      
3. ファイルのアクセス権を修正するために使用するポッドの構成ファイルを作成し、`fix-permission.yaml` という名前を付けます。 
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission 
     namespace: <namespace>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nonroot_userID> <mount_path>/*; find <mount_path>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mount_path>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}
    
3. `fix-permission` ポッドを作成します。 
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}
   
4. ポッドが `Completed` 状態になるまで待機します。  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. `fix-permission` ポッドを削除します。 
   ```
   kubectl delete pod fix-permission
   ```
   {: pre} 
   
5. 以前に使用した `test-permission` ポッドを再作成して、アクセス権を確認します。 
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}
   
5. ファイルのアクセス権が更新されていることを確認します。 
   1. ポッドにログインします。 
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}
   
   2. マウント・パスにナビゲートし、ファイルのアクセス権をリストします。
      ```
      cd test && ls -al
      ```
      {: pre}

      出力例: 
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}
      
6. `test-permission` ポッドを削除します。 
   ```
   kubectl delete pod test-permission
   ```
   {: pre}
   
7. 非 root ユーザーとしてアプリに PVC をマウントします。 

   **重要:** デプロイメント YAML で同時に `fsGroup` を設定することなく、非 root ユーザーを `runAsUser` として定義します。`fsGroup` を設定すると、ポッドのデプロイ時に、{{site.data.keyword.cos_full_notm}} プラグインによるバケット内のすべてのファイルのグループ権限の更新がトリガーされます。権限の更新は書き込み操作であり、これによってポッドが `Running` 状態にならない場合があります。 

{{site.data.keyword.cos_full_notm}} サービス・インスタンスで正しいファイルのアクセス権を設定した後は、GUI または REST API を使用してファイルをアップロードしないでください。{{site.data.keyword.cos_full_notm}} プラグインを使用して、サービス・インスタンスにファイルを追加します。
{: tip}

<br />


## ヘルプとサポートの取得
{: #ts_getting_help}

まだクラスターに問題がありますか?
{: shortdesc}

-  `ibmcloud` CLI およびプラグインの更新が使用可能になると、端末に通知が表示されます。使用可能なすべてのコマンドおよびフラグを使用できるように、CLI を最新の状態に保つようにしてください。

-   {{site.data.keyword.Bluemix_notm}} が使用可能かどうかを確認するために、[{{site.data.keyword.Bluemix_notm}} 状況ページを確認します![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/support/#status)。
-   [{{site.data.keyword.containerlong_notm}} Slack ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) に質問を投稿します。

    {{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、この Slack への[招待を要求](https://bxcs-slack-invite.mybluemix.net/)してください。
    {: tip}
-   フォーラムを確認して、同じ問題が他のユーザーで起こっているかどうかを調べます。 フォーラムを使用して質問するときは、{{site.data.keyword.Bluemix_notm}} 開発チームの目に止まるように、質問にタグを付けてください。

    -   {{site.data.keyword.containerlong_notm}} を使用したクラスターまたはアプリの開発やデプロイに関する技術的な質問がある場合は、[Stack Overflow![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) に質問を投稿し、`ibm-cloud`、`kubernetes`、`containers` のタグを付けてください。
    -   サービスや概説の説明について質問がある場合は、[IBM Developer Answers Answers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) フォーラムを使用してください。 `ibm-cloud` と `containers` のタグを含めてください。
    フォーラムの使用について詳しくは、[ヘルプの取得](/docs/get-support/howtogetsupport.html#using-avatar)を参照してください。

-   チケットを開いて、IBM サポートに連絡してください。 IBM サポート・チケットを開く方法や、サポート・レベルとチケットの重大度については、[サポートへのお問い合わせ](/docs/get-support/howtogetsupport.html#getting-customer-support)を参照してください。

{: tip}
問題を報告する際に、クラスター ID も報告してください。 クラスター ID を取得するには、`ibmcloud ks clusters` を実行します。

