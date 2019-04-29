---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, ibmcloud, ic, ks, kubectl

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




# CLI と API のセットアップ
{: #cs_cli_install}

{{site.data.keyword.containerlong}} CLI または API を使用して、Kubernetes クラスターを作成して管理できます。
{:shortdesc}

## CLI のインストール
{: #cs_cli_install_steps}

{{site.data.keyword.containerlong_notm}} での Kubernetes クラスターの作成と管理、およびクラスターへのコンテナー化アプリのデプロイに必要な CLI をインストールします。
{:shortdesc}

このタスクには、次の CLI とプラグインをインストールするための情報が含まれています。

-   {{site.data.keyword.Bluemix_notm}} CLI バージョン 0.8.0 以降
-   {{site.data.keyword.containerlong_notm}} プラグイン
-   クラスターの `major.minor` バージョンと一致する Kubernetes CLI バージョン
-   オプション: {{site.data.keyword.registryshort_notm}} プラグイン



<br>
CLI をインストールするには、以下のことを行います。

1.  {{site.data.keyword.containerlong_notm}} プラグインの前提条件として、[{{site.data.keyword.Bluemix_notm}} CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](/docs/cli?topic=cloud-cli-ibmcloud-cli) をインストールします。 {{site.data.keyword.Bluemix_notm}} CLI を使用してコマンドを実行するための接頭部は、`ibmcloud` です。

    CLI を多用する計画ですか? [{{site.data.keyword.Bluemix_notm}} CLI の shell オートコンプリート機能の有効化 (Linux/MacOS のみ)](/docs/cli/reference/ibmcloud?topic=cloud-cli-shell-autocomplete#shell-autocomplete-linux) を試してみてください。
    {: tip}

2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。 プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。

    ```
    ibmcloud login
    ```
    {: pre}

    フェデレーテッド ID がある場合は、`ibmcloud login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。 ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。
    {: tip}

3.  Kubernetes クラスターを作成し、ワーカー・ノードを管理するには、{{site.data.keyword.containerlong_notm}} プラグインをインストールします。 {{site.data.keyword.containerlong_notm}} プラグインを使用してコマンドを実行するための接頭部は、`ibmcloud ks` です。

    ```
    ibmcloud plugin install container-service
    ```
    {: pre}

    プラグインが正常にインストールされていることを検証するには、以下のコマンドを実行します。

    ```
    ibmcloud plugin list
    ```
    {: pre}

    {{site.data.keyword.containerlong_notm}} プラグインは **container-service** として結果に表示されます。

4.  {: #kubectl}Kubernetes ダッシュボードのローカル・バージョンを表示して、アプリをクラスター内にデプロイするには、[Kubernetes CLI をインストールします![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)。 Kubernetes CLI を使用してコマンドを実行するための接頭部は、`kubectl` です。

    1.  使用する予定の Kubernetes クラスターの `major.minor` バージョンと一致する Kubernetes CLI の `major.minor` バージョンをダウンロードします。 現在の {{site.data.keyword.containerlong_notm}} のデフォルト Kubernetes バージョンは 1.12.6 です。

        少なくともクラスターの `major.minor` バージョンと同じ `kubectl` CLI バージョンを使用しないと、予期しない結果になる可能性があります。 Kubernetes クラスターと CLI のバージョンを最新の状態に保つようにしてください。
        {: note}

        - **OS X**:   [https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/darwin/amd64/kubectl ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/darwin/amd64/kubectl)
        - **Linux**:   [https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/linux/amd64/kubectl ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/linux/amd64/kubectl)
        - **Windows**:    [https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/windows/amd64/kubectl.exe ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/windows/amd64/kubectl.exe)

    2.  **OS X および Linux の場合**: 以下の手順を実行します。
        1.  実行可能ファイルを `/usr/local/bin` ディレクトリーに移動します。

            ```
            mv /filepath/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  `/usr/local/bin` が `PATH` システム変数にリストされていることを確認します。 `PATH` 変数には、オペレーティング・システムが実行可能ファイルを見つけることのできるすべてのディレクトリーが含まれています。 `PATH` 変数にリストされた複数のディレクトリーには、それぞれ異なる目的があります。 `/usr/local/bin` は実行可能ファイルを保管するために使用されますが、保管対象となるのは、オペレーティング・システムの一部ではなく、システム管理者によって手動でインストールされたソフトウェアです。

            ```
            echo $PATH
            ```
            {: pre}

            CLI 出力例:

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  ファイルを実行可能にします。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

    3.  **Windows の場合**: Kubernetes CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。 このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。

5.  プライベート・イメージ・リポジトリーを管理するには、{{site.data.keyword.registryshort_notm}} プラグインをインストールします。 このプラグインを使用して、IBM がホストするマルチテナントで可用性が高く拡張可能なプライベート・イメージ・レジストリー内に独自の名前空間をセットアップし、Docker イメージを保管して他のユーザーと共有します。 クラスターにコンテナーをデプロイするためには、Docker イメージが必要です。 レジストリー・コマンドを実行するための接頭部は、`ibmcloud cr` です。

    ```
    ibmcloud plugin install container-registry 
    ```
    {: pre}

    プラグインが正常にインストールされていることを検証するには、以下のコマンドを実行します。

    ```
    ibmcloud plugin list
    ```
    {: pre}

    プラグインは container-registry として結果に表示されます。

次に、[{{site.data.keyword.containerlong_notm}} における CLI からの Kubernetes クラスターの作成](/docs/containers?topic=containers-clusters#clusters_cli)を開始します。

以下の CLI に関する参照情報については、それらのツールの資料を参照してください。

-   [`ibmcloud` コマンド](/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_cli)
-   [`ibmcloud ks` コマンド](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)
-   [`kubectl` コマンド ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [`ibmcloud cr` コマンド](/docs/services/Registry?topic=registry-registry_cli_reference#registry_cli_reference)

<br />




## コンテナー内の CLI をコンピューター上で実行する
{: #cs_cli_container}

コンピューターに個別に各 CLI をインストールする代わりに、コンピューター上で実行するコンテナーに CLI をインストールすることができます。
{:shortdesc}

始めに、[Docker をインストール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.docker.com/community-edition#/download) し、ローカルにイメージをビルドして実行します。 Windows 8 以前を使用している場合、代わりに [Docker Toolbox ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.docker.com/toolbox/toolbox_install_windows/) をインストールしてください。

1. 提供された Dockerfile からイメージを作成します。

    ```
    docker build -t <image_name> https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/install-clis-container/Dockerfile
    ```
    {: pre}

2. イメージをコンテナーとしてローカルにデプロイし、ローカル・ファイルにアクセスするためのボリュームをマウントします。

    ```
    docker run -it -v /local/path:/container/volume <image_name>
    ```
    {: pre}

3. 対話式シェルから `ibmcloud ks` コマンドと `kubectl` コマンドの実行を開始します。 保存するデータを作成する場合は、マウントしたボリュームにそのデータを保存します。 シェルを終了すると、コンテナーは停止します。

<br />



## `kubectl` を実行するように CLI を構成する
{: #cs_cli_configure}

Kubernetes CLI に用意されているコマンドを使用して、{{site.data.keyword.Bluemix_notm}} のクラスターを管理することができます。
{:shortdesc}

Kubernetes 1.12.6 内で使用できるすべての `kubectl` コマンドは、{{site.data.keyword.Bluemix_notm}} 内のクラスターに対して使用することができます。 クラスターを作成したら、環境変数を使用してローカル CLI のコンテキストをそのクラスターに設定します。 その後、Kubernetes のさまざまな `kubectl` コマンドを実行して、{{site.data.keyword.Bluemix_notm}} のクラスターを操作することができます。

`kubectl` コマンドを実行するためには、その前に以下のようにします。
* [必要な CLI をインストールします](#cs_cli_install)。
* [クラスターを作成します](/docs/containers?topic=containers-clusters#clusters_cli)。
* Kubernetes リソースを処理できる適切な Kubernetes RBAC 役割を付与する、[サービス役割](/docs/containers?topic=containers-users#platform)を持っていることを確認します。サービス役割しかなく、プラットフォーム役割がない場合は、クラスター管理者に依頼して、クラスター名とクラスター ID を取得するか、クラスターをリストするための**ビューアー**・プラットフォーム役割を付与してもらう必要があります。

`kubectl` コマンドを使用するには、以下のようにします。

1.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。 プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。 {{site.data.keyword.Bluemix_notm}} 地域を指定するには、[API エンドポイントを含めます](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    ```
    ibmcloud login
    ```
    {: pre}

    フェデレーテッド ID がある場合は、`ibmcloud login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。 ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。
    {: tip}

2.  {{site.data.keyword.Bluemix_notm}} アカウントを選択します。 複数の {{site.data.keyword.Bluemix_notm}} の組織が割り当てられている場合は、対象クラスターが作成されている組織を選択してください。 クラスターは組織に固有のものですが、{{site.data.keyword.Bluemix_notm}} スペースからは独立しています。 そのため、スペースを選択する必要はありません。

3.  デフォルト以外のリソース・グループにクラスターを作成して操作するには、そのリソース・グループをターゲットとして設定します。 各クラスターが属するリソース・グループを表示するには、`ibmcloud ks clusters` を実行します。 **注**: そのリソース・グループに対する [**Viewer** アクセス権限](/docs/containers?topic=containers-users#platform)が必要です。
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {: pre}

4.  前に選択した {{site.data.keyword.Bluemix_notm}} 地域とは別の地域の Kubernetes クラスターを作成または使用するには、その地域をターゲットにします。
    ```
    ibmcloud ks region-set
    ```
    {: pre}

5.  クラスターの名前を取得するために、アカウントに含まれているすべてのクラスターのリストを出力します。 {{site.data.keyword.Bluemix_notm}} IAM サービス役割しかないために、クラスターを表示できない場合は、クラスター管理者に依頼して、IAM プラットフォームの**ビューアー**役割を付与してもらうか、クラスター名とクラスター ID を取得してください。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

6.  作成したクラスターを、このセッションのコンテキストとして設定します。 次の構成手順は、クラスターの操作時に毎回行ってください。
    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        構成ファイルをダウンロードした後に、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。

        例:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。

        **Mac または Linux ユーザー**: `ibmcloud ks cluster-config` コマンドを実行して `KUBECONFIG` 環境変数をコピーする代わりに、`ibmcloud ks cluster-config --export <cluster-name>` を実行することができます。ご使用のシェルに応じて、`eval $(ibmcloud ks cluster-config --export <cluster-name>)` を実行してシェルをセットアップすることができます。
        {: tip}

        **Windows PowerShell ユーザー**: `ibmcloud ks cluster-config` の出力から `SET` コマンドをコピーして貼り付ける代わりに、次の例のように実行して `KUBECONFIG` 環境変数を設定する必要があります。`$env:KUBECONFIG = "C:\Users\<user_name>\.bluemix\plugins\container-service\clusters\mycluster\kube-config-prod-dal10-mycluster.yml"`。
        {:tip}

    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。

        例:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        出力:
        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

7.  Kubernetes CLI サーバーのバージョンを調べて、ご使用のクラスターで `kubectl` コマンドが正常に実行することを確認します。

    ```
    kubectl version  --short
    ```
    {: pre}

    出力例:

    ```
    Client Version: v1.12.6
    Server Version: v1.12.6
    ```
    {: screen}

これで、`kubectl` のコマンドを実行して、{{site.data.keyword.Bluemix_notm}} のクラスターを管理できるようになりました。 すべてのコマンドのリストについては、[Kubernetes の資料![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/overview/) を参照してください。

**ヒント:** Windows を使用している場合、Kubernetes CLI が {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールされていなければ、`kubectl` コマンドを正常に実行するために、Kubernetes CLI のインストール先パスにディレクトリーを変更する必要があります。


<br />


## CLI の更新
{: #cs_cli_upgrade}

新しいフィーチャーを使用するためには、CLI を定期的に更新する必要があります。
{:shortdesc}

このタスクには、これらの CLI を更新するための情報が含まれています。

-   {{site.data.keyword.Bluemix_notm}} CLI バージョン 0.8.0 以降
-   {{site.data.keyword.containerlong_notm}} プラグイン
-   Kubernetes CLI バージョン 1.12.6 以降
-   {{site.data.keyword.registryshort_notm}} プラグイン

<br>
CLI を更新するには、以下のようにします。

1.  {{site.data.keyword.Bluemix_notm}} CLI を更新します。 [最新バージョン ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](/docs/cli?topic=cloud-cli-ibmcloud-cli) をダウンロードし、インストーラーを実行します。

2. {{site.data.keyword.Bluemix_notm}} CLI にログインします。 プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。 {{site.data.keyword.Bluemix_notm}} 地域を指定するには、[API エンドポイントを含めます](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    ```
    ibmcloud login
    ```
    {: pre}

     フェデレーテッド ID がある場合は、`ibmcloud login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。 ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。
     {: tip}

3.  {{site.data.keyword.containerlong_notm}} プラグインを更新します。
    1.  {{site.data.keyword.Bluemix_notm}} プラグイン・リポジトリーからアップデートをインストールします。

        ```
        ibmcloud plugin update container-service 
        ```
        {: pre}

    2.  以下のコマンドを実行し、インストールされたプラグインのリストを確認することで、プラグインのインストールを検証します。

        ```
        ibmcloud plugin list
        ```
        {: pre}

        {{site.data.keyword.containerlong_notm}} プラグインは container-service として結果に表示されます。

    3.  CLI を初期化します。

        ```
        ibmcloud ks init
        ```
        {: pre}

4.  [Kubernetes CLI を更新します](#kubectl)。

5.  {{site.data.keyword.registryshort_notm}} プラグインを更新します。
    1.  {{site.data.keyword.Bluemix_notm}} プラグイン・リポジトリーからアップデートをインストールします。

        ```
        ibmcloud plugin update container-registry 
        ```
        {: pre}

    2.  以下のコマンドを実行し、インストールされたプラグインのリストを確認することで、プラグインのインストールを検証します。

        ```
        ibmcloud plugin list
        ```
        {: pre}

        レジストリー・プラグインが container-registry として結果に表示されます。

<br />


## CLI のアンインストール
{: #cs_cli_uninstall}

不要になった CLI はアンインストールできます。
{:shortdesc}

このタスクには、次の CLI を削除するための情報が含まれています。


-   {{site.data.keyword.containerlong_notm}} プラグイン
-   Kubernetes CLI
-   {{site.data.keyword.registryshort_notm}} プラグイン

CLI をアンインストールするには、以下のようにします。

1.  {{site.data.keyword.containerlong_notm}} プラグインをアンインストールします。

    ```
    ibmcloud plugin uninstall container-service
    ```
    {: pre}

2.  {{site.data.keyword.registryshort_notm}} プラグインをアンインストールします。

    ```
    ibmcloud plugin uninstall container-registry
    ```
    {: pre}

3.  次のコマンドを実行し、インストールされているプラグインのリストを確認することで、プラグインがアンインストールされたことを検証します。

    ```
    ibmcloud plugin list
    ```
    {: pre}

    container-service プラグインと container-registry プラグインは結果に表示されません。

<br />




## API を使用したクラスターのデプロイメントの自動化
{: #cs_api}

{{site.data.keyword.containerlong_notm}} API を使用して、Kubernetes クラスターの作成、デプロイメント、管理を自動化できます。
{:shortdesc}

{{site.data.keyword.containerlong_notm}} API にはヘッダー情報が必要です。これは、API 要求に指定する必要があります。また、使用する API に応じて異なる場合があります。 使用する API に必要なヘッダー情報を調べるには、[{{site.data.keyword.containerlong_notm}} API の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://us-south.containers.cloud.ibm.com/swagger-api) を参照してください。

{{site.data.keyword.containerlong_notm}} で認証を受けるために、{{site.data.keyword.Bluemix_notm}} 資格情報を使用して生成した {{site.data.keyword.Bluemix_notm}} IAM (ID およびアクセス管理) トークン (クラスターの作成に使用した {{site.data.keyword.Bluemix_notm}} アカウント ID が入っているもの) を渡す必要があります。 {{site.data.keyword.Bluemix_notm}} での認証方法に応じて、{{site.data.keyword.Bluemix_notm}} IAM トークンの作成を自動化するための次のオプションから選択できます。

[API Swagger JSON ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://containers.cloud.ibm.com/swagger-api-json) を使用して、自動化作業の一部として API と対話可能なクライアントを生成することもできます。
{: tip}

<table>
<caption>ID タイプとオプション</caption>
<thead>
<th>{{site.data.keyword.Bluemix_notm}} ID</th>
<th>選択オプション</th>
</thead>
<tbody>
<tr>
<td>非フェデレーテッド ID</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}} ユーザー名とパスワード:</strong> このトピックに記載されたステップに従って、{{site.data.keyword.Bluemix_notm}} IAM アクセス・トークンの作成を完全に自動化できます。</li>
<li><strong>{{site.data.keyword.Bluemix_notm}} API キーの生成:</strong> {{site.data.keyword.Bluemix_notm}} ユーザー名とパスワードを使用する代わりに、<a href="/docs/iam?topic=iam-userapikey#create_user_key" target="_blank">{{site.data.keyword.Bluemix_notm}} API キーを使用</a>することができます。{{site.data.keyword.Bluemix_notm}} API キーは、その生成対象の {{site.data.keyword.Bluemix_notm}} アカウントに依存しています。{{site.data.keyword.Bluemix_notm}} API キーと別のアカウント ID を同一の {{site.data.keyword.Bluemix_notm}} IAM トークンで結合することはできません。 {{site.data.keyword.Bluemix_notm}} API キーの基となっているアカウント以外のアカウントを使用して作成されたクラスターにアクセスするには、そのアカウントにログインして新しい API キーを生成する必要があります。 </li></ul></tr>
<tr>
<td>フェデレーテッド ID</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}} API キーの生成:</strong> <a href="/docs/iam?topic=iam-userapikey#create_user_key" target="_blank">{{site.data.keyword.Bluemix_notm}} API キー</a>は、その生成対象の {{site.data.keyword.Bluemix_notm}} アカウントに依存しています。 {{site.data.keyword.Bluemix_notm}} API キーと別のアカウント ID を同一の {{site.data.keyword.Bluemix_notm}} IAM トークンで結合することはできません。 {{site.data.keyword.Bluemix_notm}} API キーの基となっているアカウント以外のアカウントを使用して作成されたクラスターにアクセスするには、そのアカウントにログインして新しい API キーを生成する必要があります。 </li><li><strong>ワンタイム・パスコードの使用: </strong>ワンタイム・パスコードを使用して {{site.data.keyword.Bluemix_notm}} で認証する場合、{{site.data.keyword.Bluemix_notm}} IAM トークンの作成を完全に自動化することはできません。ワンタイム・パスコードを取得するには、Web ブラウザーとの手動対話が必要になるためです。 {{site.data.keyword.Bluemix_notm}} IAM トークンの作成を完全に自動化するには、代わりに {{site.data.keyword.Bluemix_notm}} API キーを作成する必要があります。 </ul></td>
</tr>
</tbody>
</table>

1.  {{site.data.keyword.Bluemix_notm}} IAM アクセス・トークンを作成します。 要求に含まれる本文情報は、使用する {{site.data.keyword.Bluemix_notm}} 認証方式によって異なります。 以下の値を置き換えます。
  - `<username>`: {{site.data.keyword.Bluemix_notm}} ユーザー名。
  - `<password>`: {{site.data.keyword.Bluemix_notm}} パスワード。
  - `<api_key>`: {{site.data.keyword.Bluemix_notm}} API キー。
  - `<passcode>`: {{site.data.keyword.Bluemix_notm}} ワンタイム・パスコード。 `ibmcloud login --sso` を実行し、CLI 出力の説明に従って、Web ブラウザーを使用してワンタイム・パスコードを取得します。

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    例:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    {{site.data.keyword.Bluemix_notm}} 地域を指定するには、[API エンドポイントで使用される地域の略語を確認してください](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    <table summary-"Input parameters to retrieve tokens">
    <caption>トークンを取得するための入力パラメーター</caption>
    <thead>
        <th>入力パラメーター</th>
        <th>値</th>
    </thead>
    <tbody>
    <tr>
    <td>ヘッダー</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><strong>注</strong>: <code>Yng6Yng=</code> は、ユーザー名 <strong>bx</strong> とパスワード <strong>bx</strong> を URL にエンコードする許可と同じです。</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} ユーザー名とパスワードの本文</td>
    <td><ul><li>`grant_type: password`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`username: <em>&lt;username&gt;</em>`</li>
    <li>`password: <em>&lt;password&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:`</li></ul>
    <strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} API キーの本文</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:apikey`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`apikey: <em>&lt;api_key&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:``</li></ul>
    <strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} ワンタイム・パスコードの本文</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:passcode`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`passcode: <em>&lt;passcode&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:`</li></ul>
    <strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    </tbody>
    </table>

    API 出力例:

    ```
    {
    "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    {{site.data.keyword.Bluemix_notm}} IAM トークンは、API 出力の **access_token** フィールドで確認できます。 次のステップでさらにヘッダー情報を取得するため、{{site.data.keyword.Bluemix_notm}} IAM トークンをメモしておきます。

2.  クラスターの作成に使用した {{site.data.keyword.Bluemix_notm}} アカウントの ID を取得します。 `<iam_token>` を、前の手順で取得した {{site.data.keyword.Bluemix_notm}} IAM トークンに置き換えてください。

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="{{site.data.keyword.Bluemix_notm}} アカウント ID を取得するための入力パラメーター">
    <caption>{{site.data.keyword.Bluemix_notm}} アカウント ID を取得するための入力パラメーター</caption>
    <thead>
  	<th>入力パラメーター</th>
  	<th>値</th>
    </thead>
    <tbody>
  	<tr>
  		<td>ヘッダー</td>
  		<td><ul><li>`Content-Type: application/json`</li>
      <li>`Authorization: bearer &lt;iam_token&gt;`</li>
      <li>`Accept: application/json`</li></ul></td>
  	</tr>
    </tbody>
    </table>

    API 出力例:

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<account_ID>",
            "url": "/v1/accounts/<account_ID>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    API 出力の **resources/metadata/guid** フィールドに、{{site.data.keyword.Bluemix_notm}} アカウントの ID があります。

3.  {{site.data.keyword.Bluemix_notm}} 資格情報と、クラスターの作成に使用したアカウント ID の両方が含まれる新しい {{site.data.keyword.Bluemix_notm}} IAM トークンを生成します。 `<account_ID>` を、前のステップで取得した {{site.data.keyword.Bluemix_notm}} アカウントの ID に置き換えます。

    {{site.data.keyword.Bluemix_notm}} API キーを使用している場合、API キーの作成対象となった {{site.data.keyword.Bluemix_notm}} アカウント ID を使用する必要があります。 他のアカウントのクラスターにアクセスするには、そのアカウントにログインし、このアカウントに基づく {{site.data.keyword.Bluemix_notm}} API キーを作成します。
    {: note}

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    例:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: codeblock}

    {{site.data.keyword.Bluemix_notm}} 地域を指定するには、[API エンドポイントで使用される地域の略語を確認してください](/docs/containers?topic=containers-regions-and-zones#bluemix_regions)。

    <table summary-"Input parameters to retrieve tokens">
    <caption>トークンを取得するための入力パラメーター</caption>
    <thead>
        <th>入力パラメーター</th>
        <th>値</th>
    </thead>
    <tbody>
    <tr>
    <td>ヘッダー</td>
    <td><ul><li>`Content-Type:application/x-www-form-urlencoded`</li> <li>`Authorization: Basic Yng6Yng=`<p><strong>注</strong>: <code>Yng6Yng=</code> は、ユーザー名 <strong>bx</strong> とパスワード <strong>bx</strong> を URL にエンコードする許可と同じです。</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} ユーザー名とパスワードの本文</td>
    <td><ul><li>`grant_type: password`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`username: <em>&lt;username&gt;</em>`</li>
    <li>`password: <em>&lt;password&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:``</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul>
    <strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} API キーの本文</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:apikey`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`apikey: <em>&lt;api_key&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:``</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul>
      <strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} ワンタイム・パスコードの本文</td>
    <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:passcode`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`passcode: <em>&lt;passcode&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:`</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul><strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    </tbody>
    </table>

    API 出力例:

    ```
    {
      "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    **access_token** に {{site.data.keyword.Bluemix_notm}} IAM トークンがあり、**refresh_token** にリフレッシュ・トークンがあります。

4.  アカウント内の Kubernetes クラスターをすべてリストします。 前述のステップで取得した情報を使用して、ヘッダー情報をビルドします。

     ```
     GET https://containers.cloud.ibm.com/v1/clusters
     ```
     {: codeblock}

     <table summary="API を使用するための入力パラメーター">
     <caption>API を使用するための入力パラメーター</caption>
     <thead>
     <th>入力パラメーター</th>
     <th>値</th>
     </thead>
     <tbody>
     <tr>
     <td>ヘッダー</td>
     <td><ul><li>`Authorization: bearer <em>&lt;iam_token&gt;</em>`</li>
     <li>`X-Auth-Refresh-Token: <em>&lt;refresh_token&gt;</em>`</li></ul></td>
     </tr>
     </tbody>
     </table>

5.  [{{site.data.keyword.containerlong_notm}} API の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://containers.cloud.ibm.com/swagger-api) を参照して、サポートされている API のリストを確認します。

<br />


## API を使用した {{site.data.keyword.Bluemix_notm}} IAM アクセス・トークンのリフレッシュと新しいリフレッシュ・トークンの取得
{: #cs_api_refresh}

API を介して発行されるすべての {{site.data.keyword.Bluemix_notm}} IAM (ID およびアクセス管理) アクセス・トークンは、1 時間後に有効期限が切れます。 {{site.data.keyword.Bluemix_notm}} API へのアクセスを確保するには、アクセス・トークンを定期的にリフレッシュする必要があります。 同じ手順を使用して、新しいリフレッシュ・トークンを取得できます。
{:shortdesc}

まず始めに、新しいアクセス・トークンを要求するために使用できる {{site.data.keyword.Bluemix_notm}} IAM リフレッシュ・トークンまたは {{site.data.keyword.Bluemix_notm}} API キーを用意してください。
- **リフレッシュ・トークン:** [{{site.data.keyword.Bluemix_notm}} API を使用したクラスターの作成と管理のプロセスの自動化](#cs_api) の説明に従います。
- **API キー:** 次のように [{{site.data.keyword.Bluemix_notm}} ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/) API キーを取得します。
   1. メニュー・バーから、**「管理」** > **「アクセス (IAM)」**をクリックします。
   2. **「ユーザー」**ページをクリックして、自分を選択します。
   3. **「API キー」**ペインで、**「IBM Cloud API キーの作成」**をクリックします。
   4. API キーの**「名前」**と**「説明」**を入力し、**「作成」**をクリックします。
   4. **「表示」**をクリックして、生成された API キーを確認します。
   5. API キーをコピーして、新しい {{site.data.keyword.Bluemix_notm}} IAM アクセス・トークンを取得できるようにします。

{{site.data.keyword.Bluemix_notm}} IAM トークンを作成する場合、または新しいリフレッシュ・トークンを取得する場合は、以下の手順を使用します。

1.  リフレッシュ・トークンまたは {{site.data.keyword.Bluemix_notm}} API キーを使用して、新しい {{site.data.keyword.Bluemix_notm}} IAM アクセス・トークンを生成します。
    ```
    POST https://iam.bluemix.net/identity/token
    ```
    {: codeblock}

    <table summary="新しい IAM トークンのための入力パラメーター">
    <caption>新しい {{site.data.keyword.Bluemix_notm}} IAM トークンのための入力パラメーター</caption>
    <thead>
    <th>入力パラメーター</th>
    <th>値</th>
    </thead>
    <tbody>
    <tr>
    <td>ヘッダー</td>
    <td><ul><li>`Content-Type: application/x-www-form-urlencoded`</li>
      <li>`Authorization: Basic Yng6Yng=`</br></br><strong>注:</strong> <code>Yng6Yng=</code> は、ユーザー名 <strong>bx</strong> とパスワード <strong>bx</strong> を URL にエンコードする許可と同じです。</li></ul></td>
    </tr>
    <tr>
    <td>リフレッシュ・トークン使用時の本体</td>
    <td><ul><li>`grant_type: refresh_token`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`refresh_token: <em>&lt;iam_refresh_token&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
    <li>`uaa_client_secret:`</li>
    <li>`bss_account: <em>&lt;account_ID&gt;</em>`</li></ul><strong>注</strong>: <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    <tr>
      <td>{{site.data.keyword.Bluemix_notm}} API キー使用時の本体</td>
      <td><ul><li>`grant_type: urn:ibm:params:oauth:grant-type:apikey`</li>
    <li>`response_type: cloud_iam uaa`</li>
    <li>`apikey: <em>&lt;api_key&gt;</em>`</li>
    <li>`uaa_client_ID: cf`</li>
        <li>`uaa_client_secret:`</li></ul><strong>注:</strong> <code>uaa_client_secret</code> キーは値を指定せずに追加します。</td>
    </tr>
    </tbody>
    </table>

    API 出力例:

    ```
    {
      "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    API 出力の **access_token** フィールドに新しい {{site.data.keyword.Bluemix_notm}} IAM トークンがあり、**refresh_token** フィールドにリフレッシュ・トークンがあります。

2.  前の手順のトークンを使用して、[{{site.data.keyword.containerlong_notm}} API の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://containers.cloud.ibm.com/swagger-api) の作業を進めます。

<br />


## CLI を使用した {{site.data.keyword.Bluemix_notm}} IAM アクセス・トークンのリフレッシュと新しいリフレッシュ・トークンの取得
{: #cs_cli_refresh}

新しい CLI セッションを開始する場合、または現在の CLI セッションで 24 時間が経過した場合は、`ibmcloud ks cluster-config<cluster_name>` を実行してクラスターのコンテキストを設定する必要があります。 このコマンドでクラスターのコンテキストを設定すると、Kubernetes クラスターの `kubeconfig` ファイルがダウンロードされます。 さらに、認証を提供するために、{{site.data.keyword.Bluemix_notm}} IAM (ID およびアクセス管理) ID トークンおよびリフレッシュ・トークンが発行されます。
{: shortdesc}

**ID トークン**: CLI を介して発行されるすべての IAM ID トークンは、1 時間後に有効期限が切れます。 ID トークンの有効期限が切れると、リフレッシュ・トークンがトークン・プロバイダーに送信され、ID トークンがリフレッシュされます。 認証がリフレッシュされ、クラスターに対して引き続きコマンドを実行できるようになります。

**リフレッシュ・トークン**: リフレッシュ・トークンは 30 日ごとに有効期限が切れます。 リフレッシュ・トークンの有効期限が切れると、ID トークンをリフレッシュできなくなるので、CLI でコマンドの実行を続けられなくなります。 `ibmcloud ks cluster-config <cluster_name>` を実行すると、新しいリフレッシュ・トークンを取得できます。 このコマンドは ID トークンもリフレッシュします。
