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


# イメージからのコンテナーのビルド
{: #images}

Docker イメージは、作成するすべてのコンテナーの基礎となるものです。 イメージは、Dockerfile (イメージをビルドするための指示が入ったファイル) から作成されます。 Dockerfile の別個に保管されている指示の中で、ビルド成果物 (アプリ、アプリの構成、その従属関係) が参照されることもあります。
{:shortdesc}


## イメージ・レジストリーの計画
{: #planning}

イメージは通常、レジストリーに保管されます。だれでもアクセスできるレジストリー (パブリック・レジストリー) を使用することも、小さなグループのユーザーだけにアクセスを限定したレジストリー (プライベート・レジストリー) をセットアップすることもできます。 Docker Hub などのパブリック・レジストリーは、Docker および Kubernetes の入門として最初のコンテナー化アプリをクラスター内に作成する時に使用できます。 しかしエンタープライズ・アプリケーションを作成する場合は、許可されていないユーザーが勝手にイメージを使用したり変更したりすることがないように、 {{site.data.keyword.registryshort_notm}} で提供されているようなプライベート・レジストリーを使用してください。 プライベート・レジストリーはクラスター管理者がセットアップする必要があります。プライベート・レジストリーにアクセスするための資格情報をクラスター・ユーザーに提供する必要があるためです。
{:shortdesc}

{{site.data.keyword.containershort_notm}} では、複数のレジストリーを使用してアプリをクラスターにデプロイできます。

|レジストリー|説明|利点|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|このオプションを使用すると、保護された独自の Docker イメージ・リポジトリーを {{site.data.keyword.registryshort_notm}} 内にセットアップできます。そこでイメージを安全に保管してクラスター・ユーザー間で共有することができます。|<ul><li>アカウント内でイメージへのアクセス権限を管理できる。</li><li>{{site.data.keyword.IBM_notm}} 提供のイメージとサンプル・アプリ ({{site.data.keyword.IBM_notm}} Liberty など) を親イメージとして使用し、それに独自のアプリ・コードを追加できる。</li><li>Vulnerability Advisor によるイメージの潜在的脆弱性の自動スキャン (それらの脆弱性を修正するための OS 固有の推奨事項を含む)。</li></ul>|
|他のプライベート・レジストリー|[imagePullSecret ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/containers/images/) を作成して、既存のプライベート・レジストリーをクラスターに接続します。 このシークレットは、レジストリーの URL と資格情報を Kubernetes シークレットに安全に保存するために使用されます。|<ul><li>ソース (Docker Hub、組織が所有するレジストリー、または他のプライベート・クラウド・レジストリー) と無関係に既存のプライベート・レジストリーを使用できる。</li></ul>|
|パブリック Docker Hub|このオプションは、Dockerfile に変更を加える必要がなく、Docker Hub にある既存のパブリック・イメージを直接使用する場合に使用します。 <p>**注:** このオプションは組織のセキュリティー要件 (アクセス管理、脆弱性スキャン、アプリ・プライバシーなど) を満たさない可能性があるということに留意してください。</p>|<ul><li>クラスターの追加セットアップが不要。</li><li>さまざまなオープン・ソース・アプリケーションを含めることができる。</li></ul>|
{: caption="表。 パブリック・イメージ・レジストリーおよびプライベート・イメージ・レジストリーのオプション" caption-side="top"}

イメージ・レジストリーをセットアップすると、クラスター・ユーザーがイメージを使用してクラスターにアプリをデプロイできるようになります。


<br />



## {{site.data.keyword.registryshort_notm}} 内の名前空間へのアクセス
{: #namespace}

{{site.data.keyword.registryshort_notm}} 内の名前空間に保管されている IBM 提供のパブリック・イメージやプライベート・イメージからクラスターにコンテナーをデプロイできます。
{:shortdesc}

開始前に、以下のことを行います。

1. [{{site.data.keyword.Bluemix_notm}} Public または {{site.data.keyword.Bluemix_dedicated_notm}} の {{site.data.keyword.registryshort_notm}} に名前空間をセットアップし、その名前空間にイメージをプッシュします](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2. [クラスターを作成します](cs_clusters.html#clusters_cli)。
3. [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

クラスターを作成すると、有効期限のないレジストリー・トークンおよびシークレットが、[最も近い地域レジストリーとグローバル・レジストリー](/docs/services/Registry/registry_overview.html#registry_regions)の両方に対して自動的に作成されます。 グローバル・レジストリーには、ユーザーが各地域レジストリーに保管されたイメージを別個に参照する代わりにデプロイメント全体で参照することのできる、IBM 提供のパブリック・イメージが安全に保管されます。 地域レジストリーには、グローバル・レジストリーに保管されるパブリック・イメージと同じイメージに加えて、独自のプライベート Docker イメージが安全に保管されます。 トークンは、{{site.data.keyword.registryshort_notm}} 内にセットアップした名前空間への読み取り専用アクセスを許可するために使用されるもので、これにより、パブリック (グローバル・レジストリー) およびプライベート (地域レジストリー) のイメージの処理が可能になります。

コンテナー化アプリのデプロイ時に Kubernetes クラスターがトークンにアクセスできるように、各トークンは Kubernetes の `imagePullSecret` 内に保管されている必要があります。 クラスターが作成されると、{{site.data.keyword.containershort_notm}} により、グローバル・レジストリー (IBM 提供のパブリック・イメージ) および地域レジストリーのトークンが Kubernetes イメージ・プル・シークレット内に自動的に保管されます。 イメージ・プル・シークレットは、`default` Kubernetes 名前空間、その名前空間の `ServiceAccount` 内のデフォルトのシークレット・リスト、`kube-system` 名前空間に追加されます。

**注:** この初期セットアップを使用すると、{{site.data.keyword.Bluemix_notm}} アカウントの名前空間にある任意のイメージのコンテナーを、クラスターの **default** 名前空間にデプロイできます。 クラスター内のその他の名前空間内にコンテナーをデプロイする場合や、別の {{site.data.keyword.Bluemix_notm}} 地域か別の {{site.data.keyword.Bluemix_notm}} アカウントに保管されているイメージを使用する場合は、その[クラスター用に独自の imagePullSecret を作成](#other)しなければなりません。

コンテナーをクラスターの **default** 名前空間にデプロイするために、構成ファイルを作成します。

1.  `mydeployment.yaml` という名前のデプロイメント構成ファイルを作成します。
2.  デプロイメントと、{{site.data.keyword.registryshort_notm}}内の名前空間にある、使用するイメージを定義します。

    {{site.data.keyword.registryshort_notm}}内の名前空間にあるプライベート・イメージを使用するには、次のようにします。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **ヒント:** 名前空間の情報を取得するには、`bx cr namespace-list` を実行します。

3.  クラスター内にデプロイメントを作成します。

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **ヒント:** IBM 提供のパブリック・イメージなど、既存の構成ファイルをデプロイすることもできます。 この例では、米国南部地域の **ibmliberty** イメージを使用しています。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}


<br />



## 他の Kubernetes 名前空間、{{site.data.keyword.Bluemix_notm}} 地域、アカウント内のイメージへのアクセス
{: #other}

独自の imagePullSecret を作成すれば、他の Kubernetes 名前空間にコンテナーをデプロイしたり、他の {{site.data.keyword.Bluemix_notm}} 地域やアカウント内に保管されているイメージを使用したり、{{site.data.keyword.Bluemix_dedicated_notm}} 内に保管されているイメージを使用したりできます。
{:shortdesc}

開始前に、以下のことを行います。

1.  [{{site.data.keyword.Bluemix_notm}} Public または {{site.data.keyword.Bluemix_dedicated_notm}} の {{site.data.keyword.registryshort_notm}} に名前空間をセットアップし、その名前空間にイメージをプッシュします](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2.  [クラスターを作成します](cs_clusters.html#clusters_cli)。
3.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

独自の imagePullSecret を作成するには、以下のようにします。

**注:** ImagePullSecrets は、それらが作成された Kubernetes 名前空間に対してのみ有効です。 コンテナーをデプロイする名前空間ごとに、以下の手順を繰り返してください。 [DockerHub](#dockerhub) のイメージの場合は ImagePullSecrets は必要ありません。

1.  トークンがない場合は、[アクセスするレジストリーのトークンを作成します。](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  {{site.data.keyword.Bluemix_notm}} アカウント内のトークンのリストを表示します。

    ```
    bx cr token-list
    ```
    {: pre}

3.  使用するトークン ID をメモします。
4.  トークンの値を取得します。 <em>&lt;token_id&gt;</em> を、前のステップで取得したトークンの ID に置き換えます。

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    CLI 出力の **Token** フィールドに、トークン値が表示されます。

5.  トークン情報を保管する Kubernetes シークレットを作成します。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表。 このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必須。 シークレットを使用してコンテナーをデプロイする、クラスターの Kubernetes 名前空間。 クラスター内の名前空間をすべてリストするには、<code>kubectl get namespaces</code> を実行します。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必須。 imagePullSecret に使用する名前。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必須。 名前空間をセットアップするイメージ・レジストリーの URL。<ul><li>米国南部と米国東部でセットアップした名前空間の場合: registry.ng.bluemix.net</li><li>英国南部でセットアップした名前空間の場合: registry.eu-gb.bluemix.net</li><li>中欧 (フランクフルト) でセットアップした名前空間の場合: registry.eu-de.bluemix.net</li><li>オーストラリア (シドニー) でセットアップした名前空間の場合: registry.au-syd.bluemix.net</li><li>{{site.data.keyword.Bluemix_dedicated_notm}} でセットアップした名前空間の場合: registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必須。 プライベート・レジストリーにログインするためのユーザー名。 {{site.data.keyword.registryshort_notm}} の場合、ユーザー名は <code>token</code> に設定されます。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必須。 以前に取得したレジストリー・トークンの値。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必須。 Docker E メール・アドレスがある場合は、その値を入力します。 ない場合は、例えば a@b.c のような架空の E メール・アドレスを入力します。 この E メールは、Kubernetes シークレットを作成する際には必須ですが、作成後は使用されません。</td>
    </tr>
    </tbody></table>

6.  シークレットが正常に作成されたことを確認します。 <em>&lt;kubernetes_namespace&gt;</em> を、imagePullSecret を作成した名前空間の名前に置き換えます。

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  imagePullSecret を参照するポッドを作成します。
    1.  `mypod.yaml` という名前のポッド構成ファイルを作成します。
    2.  ポッドと、プライベート
{{site.data.keyword.Bluemix_notm}} レジストリーへのアクセスに使用する imagePullSecret を定義します。

        名前空間のプライベート・イメージ:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        {{site.data.keyword.Bluemix_notm}} パブリック・イメージ:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表。 YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>クラスターにデプロイするコンテナーの名前。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>イメージが保管されている名前空間。 使用可能な名前空間をリストするには、`bx cr namespace-list` を実行します。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>使用するイメージの名前。 {{site.data.keyword.Bluemix_notm}} アカウント内の使用可能なイメージをリストするには、`bx cr image-list` を実行します。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>使用するイメージのバージョン。 タグを指定しないと、デフォルトでは <strong>latest</strong> のタグが付いたイメージが使用されます。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>以前に作成した imagePullSecret の名前。</td>
        </tr>
        </tbody></table>

   3.  変更を保存します。
   4.  クラスター内にデプロイメントを作成します。

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


<br />



## Docker Hub 内のパブリック・イメージへのアクセス
{: #dockerhub}

Docker Hub 内に保管されているパブリック・イメージを使用すれば、追加の構成を行わずにコンテナーをクラスターにデプロイできます。
{:shortdesc}

開始前に、以下のことを行います。

1.  [クラスターを作成します](cs_clusters.html#clusters_cli)。
2.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

デプロイメント構成ファイルを作成します。

1.  `mydeployment.yaml` という名前の構成ファイルを作成します。
2.  デプロイメントと、Docker Hub 内の使用するパブリック・イメージを定義します。 以下の構成ファイルでは、Docker Hub にある使用可能パブリック・イメージ NGINX が使用されています。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  クラスター内にデプロイメントを作成します。

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **ヒント:** 代わりに、既存の構成ファイルをデプロイすることもできます。 以下の例では同じパブリック NGINX イメージを使用しますが、クラスターに直接適用しています。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}

<br />



## 他のプライベート・レジストリー内に保管されているイメージへのアクセス
{: #private_images}

既存のプライベート・レジストリーを使用する場合は、そのレジストリーの資格情報を Kubernetes imagePullSecret に保管し、構成ファイル内でこのシークレットを参照する必要があります。
{:shortdesc}

開始前に、以下のことを行います。

1.  [クラスターを作成します](cs_clusters.html#clusters_cli)。
2.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

imagePullSecret を作成するには、以下のようにします。

**注:** ImagePullSecrets は、それらが作成された対象の Kubernetes 名前空間に対して有効となります。 プライベート {{site.data.keyword.Bluemix_notm}} レジストリー内のイメージからコンテナーをデプロイする名前空間ごとに、以下の手順を繰り返してください。

1.  プライベート・レジストリーの資格情報を保管する Kubernetes シークレットを作成します。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表。 このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必須。 シークレットを使用してコンテナーをデプロイする、クラスターの Kubernetes 名前空間。 クラスター内の名前空間をすべてリストするには、<code>kubectl get namespaces</code> を実行します。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必須。 imagePullSecret に使用する名前。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必須。 プライベート・イメージが保管されているレジストリーの URL。</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必須。 プライベート・レジストリーにログインするためのユーザー名。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必須。 以前に取得したレジストリー・トークンの値。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必須。 Docker E メール・アドレスがある場合は、その値を入力します。 ない場合は、例えば a@b.c のような架空の E メール・アドレスを入力します。 この E メールは、Kubernetes シークレットを作成する際には必須ですが、作成後は使用されません。</td>
    </tr>
    </tbody></table>

2.  シークレットが正常に作成されたことを確認します。 <em>&lt;kubernetes_namespace&gt;</em> を、imagePullSecret を作成した名前空間の名前に置き換えます。

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  imagePullSecret を参照するポッドを作成します。
    1.  `mypod.yaml` という名前のポッド構成ファイルを作成します。
    2.  ポッドと、プライベート
{{site.data.keyword.Bluemix_notm}} レジストリーへのアクセスに使用する imagePullSecret を定義します。 プライベート・レジストリー内のプライベート・イメージを使用するには、次のようにします。

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表。 YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>作成するポッドの名前。</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>クラスターにデプロイするコンテナーの名前。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>プライベート・レジストリー内の使用するイメージへのフルパス。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>使用するイメージのバージョン。 タグを指定しないと、デフォルトでは <strong>latest</strong> のタグが付いたイメージが使用されます。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>以前に作成した imagePullSecret の名前。</td>
        </tr>
        </tbody></table>

  3.  変更を保存します。
  4.  クラスター内にデプロイメントを作成します。

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

