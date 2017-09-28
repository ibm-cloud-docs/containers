---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# CLI と API のセットアップ
{: #cs_cli_install}

{{site.data.keyword.containershort_notm}} CLI または API を使用して、Kubernetes クラスターを作成して管理できます。{:shortdesc}

## CLI のインストール
{: #cs_cli_install_steps}

{{site.data.keyword.containershort_notm}} での Kubernetes クラスターの作成と管理、およびクラスターへのコンテナー化アプリのデプロイに必要な CLI をインストールします。
{:shortdesc}

このタスクには、次の CLI とプラグインをインストールするための情報が含まれています。

-   {{site.data.keyword.Bluemix_notm}} CLI バージョン 0.5.0 以降
-   {{site.data.keyword.containershort_notm}} プラグイン
-   Kubernetes CLI バージョン 1.5.6 以降
-   オプション: {{site.data.keyword.registryshort_notm}} プラグイン
-   オプション: Docker バージョン 1.9. 以降

<br>
CLI をインストールするには、以下のことを行います。1.  {{site.data.keyword.containershort_notm}} プラグインの前提条件として、[{{site.data.keyword.Bluemix_notm}} CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://clis.ng.bluemix.net/ui/home.html) をインストールします。{{site.data.keyword.Bluemix_notm}} CLI を使用してコマンドを実行するための接頭部は、`bx` です。

2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。


    ```
bx login```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。



4.  Kubernetes クラスターを作成し、ワーカー・ノードを管理するには、{{site.data.keyword.containershort_notm}} プラグインをインストールします。{{site.data.keyword.containershort_notm}} プラグインを使用してコマンドを実行するための接頭部は、`bx cs` です。

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    プラグインが正常にインストールされていることを検証するには、以下のコマンドを実行します。


    ```
bx plugin list```
    {: pre}

    {{site.data.keyword.containershort_notm}} プラグインは container-service として結果に表示されます。

5.  Kubernetes ダッシュボードのローカル・バージョンを表示して、アプリをクラスター内にデプロイするには、[Kubernetes CLI をインストールします![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)。
Kubernetes CLI を使用してコマンドを実行するための接頭部は、`kubectl` です。


    1.  Kubernetes CLI をダウンロードします。

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **ヒント:** Windows を使用している場合、Kubernetes CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。


    2.  OSX と Linux のユーザーは、以下の手順を実行してください。

        1.  実行可能ファイルを `/usr/local/bin` ディレクトリーに移動します。


            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  `/usr/local/bin` が `PATH` システム変数にリストされていることを確認します。
`PATH` 変数には、オペレーティング・システムが実行可能ファイルを見つけることのできるすべてのディレクトリーが含まれています。
`PATH` 変数にリストされた複数のディレクトリーには、それぞれ異なる目的があります。
`/usr/local/bin` は実行可能ファイルを保管するために使用されますが、保管対象となるのは、オペレーティング・システムの一部ではなく、システム管理者によって手動でインストールされたソフトウェアです。


            ```
echo $PATH```
            {: pre}

            CLI 出力例:

            ```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin```
            {: screen}

        3.  バイナリー・ファイルを実行可能ファイルに変換します。


            ```
chmod +x /usr/local/bin/kubectl```
            {: pre}

6.  プライベート・イメージ・リポジトリーを管理するには、{{site.data.keyword.registryshort_notm}} プラグインをインストールします。このプラグインを使用して、IBM がホストするマルチテナントで可用性が高く拡張可能なプライベート・イメージ・レジストリー内に独自の名前空間をセットアップし、Docker イメージを保管して他のユーザーと共有します。
クラスターにコンテナーをデプロイするためには、Docker イメージが必要です。レジストリー・コマンドを実行するための接頭部は、`bx cr` です。

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    プラグインが正常にインストールされていることを検証するには、以下のコマンドを実行します。


    ```
bx plugin list```
    {: pre}

    プラグインは container-registry として結果に表示されます。


7.  ローカルにイメージを作成して、それらをレジストリー名前空間にプッシュするには、[Docker をインストールします![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.docker.com/community-edition#/download)。Windows 8 以前を使用している場合、代わりに [Docker Toolbox ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.docker.com/products/docker-toolbox) をインストールしてください。Docker CLI は、イメージ内にアプリを構築するために使用されます。Docker CLI を使用してコマンドを実行するための接頭部は、`docker` です。


次に、[{{site.data.keyword.containershort_notm}} における CLI からの Kubernetes クラスターの作成](cs_cluster.html#cs_cluster_cli)を開始します。

以下の CLI に関する参照情報については、それらのツールの資料を参照してください。


-   [`bx` コマンド](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [`bx cs` コマンド](cs_cli_reference.html#cs_cli_reference)
-   [`kubectl` コマンド ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [`bx cr` コマンド](/docs/cli/plugins/registry/index.html#containerregcli)

## `kubectl` を実行するように CLI を構成する
{: #cs_cli_configure}

Kubernetes CLI に用意されているコマンドを使用して、{{site.data.keyword.Bluemix_notm}} のクラスターを管理することができます。
Kubernetes  1.5.6 内で使用できるすべての `kubectl` コマンドは、{{site.data.keyword.Bluemix_notm}} 内のクラスターに対して使用することができます。クラスターを作成したら、環境変数を使用してローカル CLI のコンテキストをそのクラスターに設定します。
その後、Kubernetes のさまざまな `kubectl` コマンドを実行して、{{site.data.keyword.Bluemix_notm}} のクラスターを操作することができます。
{:shortdesc}

`kubectl` コマンドを実行する前に、[必要な CLI をインストール](#cs_cli_install)して、[クラスターを作成](cs_cluster.html#cs_cluster_cli)します。

1.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。


    ```
bx login```
    {: pre}

    特定の {{site.data.keyword.Bluemix_notm}} 地域を指定するには、API エンドポイントを含めます。特定の
{{site.data.keyword.Bluemix_notm}} 地域のコンテナー・レジストリーに保管されているプライベート Dockerイメージがある場合、またはすでに作成した {{site.data.keyword.Bluemix_notm}} サービス・インスタンスがある場合、この地域にログインして、イメージと {{site.data.keyword.Bluemix_notm}} サービスにログインします。


    ログインする {{site.data.keyword.Bluemix_notm}} 地域により、使用可能なデータ・センターなど、Kubernetes クラスターを作成できる地域も決まります。地域を指定しない場合、最も近い地域に自動的にログインします。
      -   米国南部

          ```
bx login -a api.ng.bluemix.net```
          {: pre}

      -   シドニー

          ```
bx login -a api.au-syd.bluemix.net```
          {: pre}

      -   ドイツ


          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   英国

          ```
bx login -a api.eu-gb.bluemix.net```
          {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

2.  {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
複数の {{site.data.keyword.Bluemix_notm}} の組織が割り当てられている場合は、対象クラスターが作成されている組織を選択してください。
クラスターは組織に固有のものですが、{{site.data.keyword.Bluemix_notm}} スペースからは独立しています。
そのため、スペースを選択する必要はありません。

3.  前に選択した {{site.data.keyword.Bluemix_notm}} 地域とは別の地域で Kubernetes クラスターを作成したり、別の地域のクラスターにアクセスしたりする場合は、その地域を指定します。例えば、次の理由で別の {{site.data.keyword.containershort_notm}} 地域にログインすることができます。
   -   ある地域で作成した {{site.data.keyword.Bluemix_notm}} サービスまたはプライベート Docker イメージを、別の地域の {{site.data.keyword.containershort_notm}} で使用したい。
   -   ログインしているデフォルトの {{site.data.keyword.Bluemix_notm}} 地域とは別の地域のクラスターにアクセスしたい。<br>
   以下の API エンドポイントから選択します。
        - 米国南部:
          ```
bx cs init --host https://us-south.containers.bluemix.net```
          {: pre}

        - 英国南部:
          ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
          {: pre}

        - 中欧:
          ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
          {: pre}

        - 南アジア太平洋地域:
          ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
          {: pre}

4.  クラスターの名前を取得するために、アカウントに含まれているすべてのクラスターのリストを出力します。


    ```
bx cs clusters```
    {: pre}

5.  作成したクラスターを、このセッションのコンテキストとして設定します。次の構成手順は、クラスターの操作時に毎回行ってください。

    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。


        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        構成ファイルをダウンロードした後に、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。

        例:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。

    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。


        例:

        ```
echo $KUBECONFIG```
        {: pre}

        出力:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

6.  Kubernetes CLI サーバーのバージョンを調べて、ご使用のクラスターで `kubectl` コマンドが正常に実行することを確認します。

    ```
kubectl version  --short```
    {: pre}

    出力例:


    ```
        Client Version: v1.5.6
        Server Version: v1.5.6
        ```
    {: screen}


これで、`kubectl` のコマンドを実行して、{{site.data.keyword.Bluemix_notm}} のクラスターを管理できるようになりました。
すべてのコマンドのリストについては、[Kubernetes の資料![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/) を参照してください。

**ヒント:** Windows を使用している場合、Kubernetes CLI が {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールされていなければ、`kubectl` コマンドを正常に実行するために、Kubernetes CLI のインストール先パスにディレクトリーを変更する必要があります。

## CLI の更新
{: #cs_cli_upgrade}

新しいフィーチャーを使用するためには、CLI を定期的に更新する必要があります。
{:shortdesc}

このタスクには、これらの CLI を更新するための情報が含まれています。


-   {{site.data.keyword.Bluemix_notm}} CLI バージョン 0.5.0 以降
-   {{site.data.keyword.containershort_notm}} プラグイン
-   Kubernetes CLI バージョン 1.5.6 以降
-   {{site.data.keyword.registryshort_notm}} プラグイン
-   Docker バージョン 1.9. 以降

<br>
CLI を更新するには、以下のようにします。
1.  {{site.data.keyword.Bluemix_notm}} CLI を更新します。
[最新バージョン ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://clis.ng.bluemix.net/ui/home.html) をダウンロードし、インストーラーを実行します。

2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。


    ```
bx login```
     {: pre}

    特定の {{site.data.keyword.Bluemix_notm}} 地域を指定するには、API エンドポイントを含めます。特定の
{{site.data.keyword.Bluemix_notm}} 地域のコンテナー・レジストリーに保管されているプライベート Dockerイメージがある場合、またはすでに作成した {{site.data.keyword.Bluemix_notm}} サービス・インスタンスがある場合、この地域にログインして、イメージと {{site.data.keyword.Bluemix_notm}} サービスにログインします。


    ログインする {{site.data.keyword.Bluemix_notm}} 地域により、使用可能なデータ・センターなど、Kubernetes クラスターを作成できる地域も決まります。地域を指定しない場合、最も近い地域に自動的にログインします。

    -   米国南部

        ```
bx login -a api.ng.bluemix.net```
        {: pre}

    -   シドニー

        ```
bx login -a api.au-syd.bluemix.net```
        {: pre}

    -   ドイツ


        ```
          bx login -a api.eu-de.bluemix.net
          ```
        {: pre}

    -   英国

        ```
bx login -a api.eu-gb.bluemix.net```
        {: pre}

        **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3.  {{site.data.keyword.containershort_notm}} プラグインを更新します。
    1.  {{site.data.keyword.Bluemix_notm}} プラグイン・リポジトリーからアップデートをインストールします。

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  以下のコマンドを実行し、インストールされたプラグインのリストを確認することで、プラグインのインストールを検証します。

        ```
bx plugin list```
        {: pre}

        {{site.data.keyword.containershort_notm}} プラグインは container-service として結果に表示されます。

    3.  CLI を初期化します。

        ```
bx cs init```
        {: pre}

4.  Kubernetes CLI を更新します。

    1.  Kubernetes CLI をダウンロードします。

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **ヒント:** Windows を使用している場合、Kubernetes CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。


    2.  OSX と Linux のユーザーは、以下の手順を実行してください。

        1.  実行可能ファイルを /usr/local/bin ディレクトリーに移動します。

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  `/usr/local/bin` が `PATH` システム変数にリストされていることを確認します。
`PATH` 変数には、オペレーティング・システムが実行可能ファイルを見つけることのできるすべてのディレクトリーが含まれています。
`PATH` 変数にリストされた複数のディレクトリーには、それぞれ異なる目的があります。
`/usr/local/bin` は実行可能ファイルを保管するために使用されますが、保管対象となるのは、オペレーティング・システムの一部ではなく、システム管理者によって手動でインストールされたソフトウェアです。


            ```
echo $PATH```
            {: pre}

            CLI 出力例:

            ```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin```
            {: screen}

        3.  バイナリー・ファイルを実行可能ファイルに変換します。


            ```
chmod +x /usr/local/bin/kubectl```
            {: pre}

5.  {{site.data.keyword.registryshort_notm}} プラグインを更新します。
    1.  {{site.data.keyword.Bluemix_notm}} プラグイン・リポジトリーからアップデートをインストールします。

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  以下のコマンドを実行し、インストールされたプラグインのリストを確認することで、プラグインのインストールを検証します。

        ```
bx plugin list```
        {: pre}

        レジストリー・プラグインが container-registry として結果に表示されます。


6.  Docker を更新します。

    -   Docker Community Edition を使用している場合は、Docker を開始し、**Docker** アイコンをクリックし、**「Check for updatess (更新のチェック)」**をクリックします。

    -   Docker Toolbox を使用する場合は、[最新バージョン ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.docker.com/products/docker-toolbox) をダウンロードし、インストーラーを実行します。


## CLI のアンインストール
{: #cs_cli_uninstall}

不要になった CLI はアンインストールできます。{:shortdesc}

このタスクには、次の CLI を削除するための情報が含まれています。


-   {{site.data.keyword.containershort_notm}} プラグイン
-   Kubernetes CLI バージョン 1.5.6 以降
-   {{site.data.keyword.registryshort_notm}} プラグイン
-   Docker バージョン 1.9. 以降

<br>
CLI をアンインストールするには、以下のようにします。1.  {{site.data.keyword.containershort_notm}} プラグインをアンインストールします。

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  {{site.data.keyword.registryshort_notm}} プラグインをアンインストールします。

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  次のコマンドを実行し、インストールされているプラグインのリストを確認することで、プラグインがアンインストールされたことを検証します。

    ```
bx plugin list```
    {: pre}

    container-service プラグインと container-registry プラグインは結果に表示されません。






6.  Docker をアンインストールします。Docker をアンインストールする手順は、ご使用のオペレーティング・システムによって異なります。


    <table summary="Docker をアンインストールするための OS 固有の手順">
     <tr>
      <th>オペレーティング・システム</th>
      <th>リンク</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>[GUI またはコマンド・ライン ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset) のどちらでも Docker をアンインストールできます。</td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>Docker をアンインストールする手順は、ご使用の Linux ディストリビューションによって異なります。Ubuntu の場合、Docker をアンインストールするには、[Docker のアンインストール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce) を参照してください。他の Linux ディストリビューションの場合は、このリンクを使用してナビゲーションからご使用のディストリビューションを選択すると、Docker のアンインストール手順が見つかります。
</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>[Docker Toolbox ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox) をアンインストールします。</td>
      </tr>
    </table>

## API を使用したクラスターのデプロイメントの自動化
{: #cs_api}

{{site.data.keyword.containershort_notm}} API を使用して、Kubernetes クラスターの作成、デプロイメント、管理を自動化できます。{:shortdesc}

{{site.data.keyword.containershort_notm}} API にはヘッダー情報が必要です。これは、API 要求に指定する必要があります。また、使用する API に応じて異なる場合があります。使用する API に必要なヘッダー情報を調べるには、[{{site.data.keyword.containershort_notm}} API の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://us-south.containers.bluemix.net/swagger-api) を参照してください。

以下の手順は、このヘッダー情報を API 要求に含めるために、ヘッダー情報を取得する方法を示しています。

1.  IAM (ID およびアクセス管理) のアクセス・トークンを取得します。IAM アクセス・トークンは、{{site.data.keyword.containershort_notm}} にログインするために必要です。_&lt;my_bluemix_username&gt;_ と _&lt;my_bluemix_password&gt;_ を、{{site.data.keyword.Bluemix_notm}} 資格情報に置き換えます。


    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Input parameters to get tokens">
      <tr>
        <th>入力パラメーター</th>
        <th>値</th>
      </tr>
      <tr>
        <td>ヘッダー</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>本文</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam、uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:
</li></ul>
        <p>**注:** uaa_client_secret キーは値を指定せずに追加します。</p></td>
      </tr>
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

    API 出力の **access_token** フィールドに IAM トークンがあり、**uaa_token** フィールドに UAA トークンがあります。次以降の手順で追加のヘッダー情報を取得するために、IAM トークンと UAA トークンをメモしておきます。

2.  クラスターを作成して管理する {{site.data.keyword.Bluemix_notm}} アカウントの ID を取得します。_&lt;iam_token&gt;_ を、前の手順で取得した IAM トークンに置き換えてください。

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="Bluemix アカウント ID を取得するための入力パラメーター">
   <tr>
    <th>入力パラメーター</th>
    <th>値</th>
   </tr>
   <tr>
    <td>ヘッダー</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json
</li></ul></td>
   </tr>
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
"guid": "<my_bluemix_account_id>",
            "url": "/v1/accounts/<my_bluemix_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    API 出力の **resources/metadata/guid** フィールドに、{{site.data.keyword.Bluemix_notm}} アカウントの ID があります。

3.  {{site.data.keyword.Bluemix_notm}} アカウント情報を含む新しい IAM トークンを取得します。_&lt;my_bluemix_account_id&gt;_ を、前のステップで取得した {{site.data.keyword.Bluemix_notm}} アカウントの ID に置き換えます。

    **注:** IAM アクセス・トークンの有効期間は 1 時間です。アクセス・トークンのリフレッシュ方法については、[API による IAM アクセス・トークンのリフレッシュ](#cs_api_refresh)を参照してください。

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="アクセス・トークンを取得するための入力パラメーター">
     <tr>
      <th>入力パラメーター</th>
      <th>値</th>
     </tr>
     <tr>
      <td>ヘッダー</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded
</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>本文</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam、uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:
<p>**注:** uaa_client_secret キーは値を指定せずに追加します。</p>
        <li>bss_account: <em>&lt;my_bluemix_account_id&gt;</em></li></ul></td>
     </tr>
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

    CLI 出力の **access_token** フィールドに IAM トークンがあり、**refresh_token** フィールドに IAM リフレッシュ・トークンがあります。

4.  クラスターを作成または管理する {{site.data.keyword.Bluemix_notm}} スペースの ID を取得します。
    1.  スペース ID にアクセスするための API エンドポイントを取得します。_&lt;uaa_token&gt;_ を、最初の手順で取得した UAA トークンに置き換えてください。

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="スペース ID を取得するための入力パラメーター">
         <tr>
          <th>入力パラメーター</th>
          <th>値</th>
         </tr>
         <tr>
          <td>ヘッダー</td>
          <td><ul><li>Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa_token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      API 出力例:

      ```
      {
            "metadata": {
"guid": "<my_bluemix_org_id>",
              "url": "/v2/organizations/<my_bluemix_org_id>",
              "created_at": "2016-01-07T18:55:19Z",
              "updated_at": "2016-02-09T15:56:22Z"
            },
            "entity": {
              "name": "<my_bluemix_org_name>",
              "billing_enabled": false,
              "quota_definition_guid": "<my_bluemix_org_id>",
              "status": "active",
              "quota_definition_url": "/v2/quota_definitions/<my_bluemix_org_id>",
              "spaces_url": "/v2/organizations/<my_bluemix_org_id>/spaces",
      ...

      ```
      {: screen}

5.  **spaces_url** フィールドの出力をメモしておきます。
6.  **spaces_url** エンドポイントを使用して、{{site.data.keyword.Bluemix_notm}} スペースの ID を取得します。

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<my_bluemix_org_id>/spaces
      ```
      {: pre}

      API 出力例:

      ```
      {
            "metadata": {
"guid": "<my_bluemix_space_id>",
              "url": "/v2/spaces/<my_bluemix_space_id>",
              "created_at": "2016-01-07T18:55:22Z",
              "updated_at": null
            },
            "entity": {
              "name": "<my_bluemix_space_name>",
              "organization_guid": "<my_bluemix_org_id>",
              "space_quota_definition_guid": null,
              "allow_ssh": true,
      ...
      ```
      {: screen}

      API 出力の **metadata/guid** フィールドに、{{site.data.keyword.Bluemix_notm}} スペースの ID があります。

7.  アカウント内の Kubernetes クラスターをすべてリストします。前述のステップで取得した情報を使用して、ヘッダー情報をビルドします。


    -   米国南部

        ```
GET https://us-south.containers.bluemix.net/v1/clusters```
        {: pre}

    -   英国南部

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   中欧

        ```
GET https://eu-central.containers.bluemix.net/v1/clusters```
        {: pre}

    -   南アジア太平洋地域

        ```
GET https://ap-south.containers.bluemix.net/v1/clusters```
        {: pre}

        <table summary="API を使用するための入力パラメーター">
         <thead>
          <th>入力パラメーター</th>
          <th>値</th>
         </thead>
          <tbody>
         <tr>
          <td>ヘッダー</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  [{{site.data.keyword.containershort_notm}} API の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://us-south.containers.bluemix.net/swagger-api) を参照して、サポートされている API のリストを確認します。

## IAM アクセス・トークンのリフレッシュ
{: #cs_api_refresh}

API から発行されるすべての IAM (ID およびアクセス管理) アクセス・トークンの有効期間は 1 時間です。{{site.data.keyword.containershort_notm}} API へのアクセスを確保するには、アクセス・トークンを定期的にリフレッシュする必要があります。{:shortdesc}

始める前に、新しいアクセス・トークンを要求するために使用できる IAM リフレッシュ・トークンを用意してください。リフレッシュ・トークンがない場合は、[{{site.data.keyword.containershort_notm}} API によるクラスターの作成と管理のプロセスの自動化](#cs_api)を参照してアクセス・トークンを取得してください。

IAM トークンをリフレッシュするには、以下の手順を実行します。

1.  新しい IAM トークンを取得します。_&lt;iam_refresh_token&gt;_ を、{{site.data.keyword.Bluemix_notm}} での最初の認証時に受け取った IAM リフレッシュ・トークンに置き換えます。

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="新しい IAM トークンのための入力パラメーター">
     <tr>
      <th>入力パラメーター</th>
      <th>値</th>
     </tr>
     <tr>
      <td>ヘッダー</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded
</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>本文</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam、uaa</li>
        <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:
<p>**注:** uaa_client_secret キーは値を指定せずに追加します。</p></li><ul></td>
     </tr>
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

    API 出力の **access_token** フィールドに新しい IAM トークンがあり、**refresh_token** フィールドに IAM リフレッシュ・トークンがあります。

2.  前の手順のトークンを使用して、[{{site.data.keyword.containershort_notm}} API の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://us-south.containers.bluemix.net/swagger-api) の作業を進めます。
