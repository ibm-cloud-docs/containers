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


# 設定 CLI 及 API
{: #cs_cli_install}

您可以使用 {{site.data.keyword.containershort_notm}} CLI 或 API 來建立及管理 Kubernetes 叢集。
{:shortdesc}

## 安裝 CLI
{: #cs_cli_install_steps}

安裝必要 CLI 以在 {{site.data.keyword.containershort_notm}} 中建立及管理 Kubernetes 叢集，並且將容器化應用程式部署至叢集。
{:shortdesc}

此作業包括安裝這些 CLI 及外掛程式的資訊：

-   {{site.data.keyword.Bluemix_notm}} CLI 0.5.0 版或更新版本
-   {{site.data.keyword.containershort_notm}} 外掛程式
-   Kubernetes CLI 1.5.6 版或更新版本
-   選用項目：{{site.data.keyword.registryshort_notm}} 外掛程式
-   選用項目：Docker 1.9 版或更新版本

<br>
若要安裝 CLI，請執行下列動作：

1.  安裝 [{{site.data.keyword.Bluemix_notm}} CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://clis.ng.bluemix.net/ui/home.html)，它是 {{site.data.keyword.containershort_notm}} 外掛程式的必要條件。使用 {{site.data.keyword.Bluemix_notm}} CLI 來執行指令的字首是 `bx`。

2.  登入 {{site.data.keyword.Bluemix_notm}} CLI。系統提示時，請輸入您的 {{site.data.keyword.Bluemix_notm}} 認證。

    ```
    bx login
    ```
    {: pre}

    **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。



4.  若要建立 Kubernetes 叢集，以及管理工作者節點，請安裝 {{site.data.keyword.containershort_notm}} 外掛程式。使用 {{site.data.keyword.containershort_notm}} 外掛程式來執行指令的字首是 `bx cs`。

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    若要驗證已適當安裝外掛程式，請執行下列指令：

    ```
    bx plugin list
    ```
    {: pre}

    在結果中，{{site.data.keyword.containershort_notm}} 外掛程式會顯示為 container-service。

5.  若要檢視本端版本的 Kubernetes 儀表板，以及將應用程式部署至叢集，請[安裝 Kubernetes CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)。使用 Kubernetes CLI 來執行指令的字首是 `kubectl`。

    1.  下載 Kubernetes CLI。

        OS X：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **提示：**如果您使用的是 Windows，請在與 {{site.data.keyword.Bluemix_notm}} CLI 相同的目錄中安裝 Kubernetes CLI。當您稍後執行指令時，此設定可為您省去一些檔案路徑變更。

    2.  若為 OSX 及 Linux 使用者，請完成下列步驟。
        1.  將執行檔移至 `/usr/local/bin` 目錄。

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  確定 `/usr/local/bin` 列在 `PATH` 系統變數中。`PATH` 變數包含作業系統可在其中找到執行檔的所有目錄。`PATH` 變數中所列的目錄用於不同的用途。`/usr/local/bin` 是用來儲存軟體的執行檔，該軟體不是作業系統的一部分，並且已由系統管理者手動安裝。

            ```
            echo $PATH
            ```
            {: pre}

            CLI 輸出範例：

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  將二進位檔轉換成執行檔。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6.  若要管理專用映像檔儲存庫，請安裝 {{site.data.keyword.registryshort_notm}} 外掛程式。您可以使用此外掛程式，在多方承租戶、高可用性並且由 IBM 所管理的可擴充專用映像檔登錄中設定您自己的名稱空間，以及儲存 Docker 映像檔，並將其與其他使用者共用。需要有 Docker 映像檔，才能將容器部署至叢集。執行登錄指令的字首是 `bx cr`。

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    若要驗證已適當安裝外掛程式，請執行下列指令：

    ```
    bx plugin list
    ```
    {: pre}

    在結果中，外掛程式會顯示為 container-registry。

7.  若要在本端建置映像檔，並將它們推送至您的登錄名稱空間，請[安裝 Docker ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.docker.com/community-edition#/download)。如果您使用的是 Windows 8 或更早版本，則可以改為安裝 [Docker Toolbox ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.docker.com/products/docker-toolbox)。Docker CLI 是用來將應用程式建置成映像檔。使用 Docker CLI 來執行指令的字首是 `docker`。

接下來，開始[使用 {{site.data.keyword.containershort_notm}} 從 CLI 建立 Kubernetes 叢集](cs_cluster.html#cs_cluster_cli)。

如需這些 CLI 的相關參考資訊，請參閱那些工具的文件。

-   [`bx` 指令](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [`bx cs` 指令](cs_cli_reference.html#cs_cli_reference)
-   [`kubectl` 指令![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [`bx cr` 指令](/docs/cli/plugins/registry/index.html#containerregcli)

## 配置 CLI 以執行 `kubectl`
{: #cs_cli_configure}

您可以使用 Kubernetes CLI 隨附的指令來管理 {{site.data.keyword.Bluemix_notm}} 中的叢集。Kubernetes 1.5.6 中可用的所有 `kubectl` 指令都支援與 {{site.data.keyword.Bluemix_notm}} 中的叢集搭配使用。建立叢集之後，使用環境變數將本端 CLI 的環境定義設定為該叢集。然後，您可以執行 Kubernetes `kubectl` 指令，在 {{site.data.keyword.Bluemix_notm}} 中使用您的叢集。
{:shortdesc}

您必須先[安裝必要的 CLI](#cs_cli_install) 及[建立叢集](cs_cluster.html#cs_cluster_cli)，才能執行 `kubectl` 指令。

1.  登入 {{site.data.keyword.Bluemix_notm}} CLI。系統提示時，請輸入您的 {{site.data.keyword.Bluemix_notm}} 認證。

    ```
    bx login
    ```
    {: pre}

    若要指定特定 {{site.data.keyword.Bluemix_notm}} 地區，請包括 API 端點。如果您的專用 Docker 映像檔已儲存在特定 {{site.data.keyword.Bluemix_notm}} 地區的容器登錄中，或已建立的 {{site.data.keyword.Bluemix_notm}} 服務實例，請登入此地區以存取映像檔及 {{site.data.keyword.Bluemix_notm}} 服務。

    您登入的 {{site.data.keyword.Bluemix_notm}} 地區也會決定可以建立 Kubernetes 叢集的地區（包括可用的資料中心）。如果您未指定地區，則會將您自動登入最接近的地區。
      -   美國南部

          ```
          bx login -a api.ng.bluemix.net
          ```
          {: pre}

      -   雪梨

          ```
          bx login -a api.au-syd.bluemix.net
          ```
          {: pre}

      -   德國

          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   英國

          ```
          bx login -a api.eu-gb.bluemix.net
          ```
          {: pre}

    **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

2.  選取 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您被指派到多個 {{site.data.keyword.Bluemix_notm}} 組織，請選取在其中建立叢集的組織。叢集是組織特有的，但與 {{site.data.keyword.Bluemix_notm}} 空間無關。因此，您不需要選取空間。

3.  如果您要在先前所選取 {{site.data.keyword.Bluemix_notm}} 地區以外的地區中建立或存取 Kubernetes 叢集，請指定此地區。例如，您可能因為下列原因而想要登入另一個 {{site.data.keyword.containershort_notm}} 地區：
   -   您已在其中一個地區中建立 {{site.data.keyword.Bluemix_notm}} 服務或專用 Docker 映像檔，並且想要在另一個地區中將它們與 {{site.data.keyword.containershort_notm}} 搭配使用。
   -   您要在與您登入的預設 {{site.data.keyword.Bluemix_notm}} 地區不同的地區中存取叢集。<br>
   選擇下列 API 端點：
        - 美國南部：
          ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
          {: pre}

        - 英國南部：
          ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
          {: pre}

        - 歐盟中部：
          ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
          {: pre}

        - 亞太地區南部：
          ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
          {: pre}

4.  列出帳戶中的所有叢集，以取得叢集的名稱。

    ```
    bx cs clusters
    ```
    {: pre}

5.  將您建立的叢集設為此階段作業的環境定義。請在您每次使用叢集時，完成下列配置步驟。
    1.  取得指令來設定環境變數，並下載 Kubernetes 配置檔。

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        下載配置檔之後，會顯示一個指令，可讓您用來將本端 Kubernetes 配置檔的路徑設定為環境變數。

        範例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  複製並貼上終端機中顯示的指令，以設定 `KUBECONFIG` 環境變數。
    3.  驗證 `KUBECONFIG` 環境變數已適當設定。

        範例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        輸出：
        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

6.  檢查 Kubernetes CLI 伺服器版本，驗證叢集已適當地執行 `kubectl` 指令。

    ```
    kubectl version  --short
    ```
    {: pre}

    輸出範例：

    ```
    Client Version: v1.5.6
    Server Version: v1.5.6
    ```
    {: screen}


您現在可以執行 `kubectl` 指令，以在 {{site.data.keyword.Bluemix_notm}} 中管理叢集。如需完整指令清單，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)。

**提示：**如果您使用的是 Windows，但未在與 {{site.data.keyword.Bluemix_notm}} CLI 相同的目錄中安裝 Kubernetes CLI，則必須將目錄切換至 Kubernetes CLI 安裝所在的路徑，才能順利執行 `kubectl` 指令。

## 更新 CLI
{: #cs_cli_upgrade}

您可能想要定期更新 CLI，以使用新特性。
{:shortdesc}

此作業包括更新這些 CLI 的資訊。

-   {{site.data.keyword.Bluemix_notm}} CLI 0.5.0 版或更新版本
-   {{site.data.keyword.containershort_notm}} 外掛程式
-   Kubernetes CLI 1.5.6 版或更新版本
-   {{site.data.keyword.registryshort_notm}} 外掛程式
-   Docker 1.9 版或更新版本

<br>
若要更新 CLI，請執行下列動作：
1.  更新 {{site.data.keyword.Bluemix_notm}} CLI。下載[最新版本 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://clis.ng.bluemix.net/ui/home.html)，並執行安裝程式。

2.  登入 {{site.data.keyword.Bluemix_notm}} CLI。系統提示時，請輸入您的 {{site.data.keyword.Bluemix_notm}} 認證。

    ```
    bx login
    ```
     {: pre}

    若要指定特定 {{site.data.keyword.Bluemix_notm}} 地區，請包括 API 端點。如果您的專用 Docker 映像檔已儲存在特定 {{site.data.keyword.Bluemix_notm}} 地區的容器登錄中，或已建立的 {{site.data.keyword.Bluemix_notm}} 服務實例，請登入此地區以存取映像檔及 {{site.data.keyword.Bluemix_notm}} 服務。

    您登入的 {{site.data.keyword.Bluemix_notm}} 地區也會決定可以建立 Kubernetes 叢集的地區（包括可用的資料中心）。如果您未指定地區，則會將您自動登入最接近的地區。

    -   美國南部

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

    -   雪梨

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -   德國

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -   英國

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

        **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

3.  更新 {{site.data.keyword.containershort_notm}} 外掛程式。
    1.  從 {{site.data.keyword.Bluemix_notm}} 外掛程式儲存庫中安裝更新。

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  執行下列指令，並檢查已安裝的外掛程式清單，以驗證外掛程式安裝。

        ```
        bx plugin list
        ```
        {: pre}

        在結果中，{{site.data.keyword.containershort_notm}} 外掛程式會顯示為 container-service。

    3.  起始設定 CLI。

        ```
        bx cs init
        ```
        {: pre}

4.  更新 Kubernetes CLI。
    1.  下載 Kubernetes CLI。

        OS X：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows：[https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **提示：**如果您使用的是 Windows，請在與 {{site.data.keyword.Bluemix_notm}} CLI 相同的目錄中安裝 Kubernetes CLI。當您稍後執行指令時，此設定可為您省去一些檔案路徑變更。

    2.  若為 OSX 及 Linux 使用者，請完成下列步驟。
        1.  將執行檔移至 /usr/local/bin 目錄。

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  確定 `/usr/local/bin` 列在 `PATH` 系統變數中。`PATH` 變數包含作業系統可在其中找到執行檔的所有目錄。`PATH` 變數中所列的目錄用於不同的用途。`/usr/local/bin` 是用來儲存軟體的執行檔，該軟體不是作業系統的一部分，並且已由系統管理者手動安裝。

            ```
            echo $PATH
            ```
            {: pre}

            CLI 輸出範例：

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  將二進位檔轉換成執行檔。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  更新 {{site.data.keyword.registryshort_notm}} 外掛程式。
    1.  從 {{site.data.keyword.Bluemix_notm}} 外掛程式儲存庫中安裝更新。

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  執行下列指令，並檢查已安裝的外掛程式清單，以驗證外掛程式安裝。

        ```
        bx plugin list
        ```
        {: pre}

        在結果中，登錄外掛程式會顯示為 container-registry。

6.  更新 Docker。
    -   如果您使用 Docker Community Edition，請啟動 Docker、按一下 **Docker** 圖示，然後按一下 **Check for updates**。
    -   如果您使用 Docker Toolbox，請下載[最新版本 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.docker.com/products/docker-toolbox)，並執行安裝程式。

## 解除安裝 CLI
{: #cs_cli_uninstall}

如果不再需要 CLI，則可以將它解除安裝。
{:shortdesc}

此作業包括移除這些 CLI 的資訊：


-   {{site.data.keyword.containershort_notm}} 外掛程式
-   Kubernetes CLI 1.5.6 版或更新版本
-   {{site.data.keyword.registryshort_notm}} 外掛程式
-   Docker 1.9 版或更新版本

<br>
若要解除安裝 CLI，請執行下列動作：

1.  解除安裝 {{site.data.keyword.containershort_notm}} 外掛程式。

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  解除安裝 {{site.data.keyword.registryshort_notm}} 外掛程式。

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  執行下列指令，並檢查已安裝的外掛程式清單，以驗證已解除安裝外掛程式。

    ```
    bx plugin list
    ```
    {: pre}

    container-service 及 container-registry 外掛程式不會顯示在結果中。





6.  解除安裝 Docker。根據您使用的作業系統，解除安裝 Docker 的指示會不同。

    <table summary="解除安裝 Docker 的 OS 特定指示">
     <tr>
      <th>作業系統</th>
      <th>鏈結</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>選擇從 [GUI 或指令行 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset) 解除安裝 Docker</td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>根據您使用的 Linux 發行套件，解除安裝 Docker 的指示會不同。若要解除安裝 Docker for Ubuntu，請參閱[解除安裝 Docker ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce)。使用此鏈結來尋找如何解除安裝適用於其他 Linux 發行套件之 Docker 的指示，方法是從導覽中選取發行套件。</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>解除安裝 [Docker Toolbox ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox)。</td>
      </tr>
    </table>

## 使用 API 自動化進行叢集部署
{: #cs_api}

您可以使用 {{site.data.keyword.containershort_notm}} API 來自動化進行 Kubernetes 叢集的建立、部署及管理。
{:shortdesc}

{{site.data.keyword.containershort_notm}} API 需要標頭資訊，您必須在 API 要求中提供它，且它會視您要使用的 API 而變。若要判斷 API 所需的標頭資訊，請參閱 [{{site.data.keyword.containershort_notm}} API 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://us-south.containers.bluemix.net/swagger-api)。

下列步驟提供如何擷取此標頭資訊，以將它包括在 API 要求中的指示。

1.  擷取 IAM（身分及存取管理）存取記號。需要有 IAM 存取記號，才能登入 {{site.data.keyword.containershort_notm}}。請將 _&lt;my_bluemix_username&gt;_ 及 _&lt;my_bluemix_password&gt;_ 取代為 {{site.data.keyword.Bluemix_notm}} 認證。

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Input parameters to get tokens">
      <tr>
        <th>輸入參數</th>
        <th>值</th>
      </tr>
      <tr>
        <td>Header</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>Body</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret: </li></ul>
        <p>**附註：**新增未指定任何值的 uaa_client_secret 金鑰。</p></td>
      </tr>
    </table>

    API 輸出範例：

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

    您可以在 API 輸出的 **access_token** 欄位中尋找 IAM 記號，並在 **uaa_token** 欄位中尋找 UAA 記號。請記下 IAM 及 UAA 記號，以在接下來的步驟中擷取其他標頭資訊。

2.  擷取您要建立及管理叢集的 {{site.data.keyword.Bluemix_notm}} 帳戶的 ID。將 _&lt;iam_token&gt;_ 取代為您在前一個步驟中所擷取的 IAM 記號。

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="取得 Bluemix 帳戶 ID 的輸入參數">
   <tr>
    <th>輸入參數</th>
    <th>值</th>
   </tr>
   <tr>
    <td>Headers</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
   </tr>
    </table>

    API 輸出範例：

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

    您可以在 API 輸出的 **resources/metadata/guid** 欄位中找到 {{site.data.keyword.Bluemix_notm}} 帳戶的 ID。

3.  擷取包括 {{site.data.keyword.Bluemix_notm}} 帳戶資訊的新 IAM 記號。將 _&lt;my_bluemix_account_id&gt;_ 取代為您在前一個步驟中所擷取的 {{site.data.keyword.Bluemix_notm}} 帳戶 ID。

    **附註：**IAM 存取記號會在 1 個小時後到期。請檢閱[使用 API 重新整理 IAM 存取記號](#cs_api_refresh)，以尋找如何重新整理存取記號的指示。

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="取得存取記號的輸入參數">
     <tr>
      <th>輸入參數</th>
      <th>值</th>
     </tr>
     <tr>
      <td>Headers</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>Body</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret: <p>**附註：**新增未指定任何值的 uaa_client_secret 金鑰。</p>
        <li>bss_account: <em>&lt;my_bluemix_account_id&gt;</em></li></ul></td>
     </tr>
    </table>

    API 輸出範例：

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

    您可以在 CLI 輸出的 **access_token** 欄位中尋找 IAM 記號，並在 **refresh_token** 欄位中尋找 IAM 重新整理記號。

4.  擷取您要建立或管理叢集的 {{site.data.keyword.Bluemix_notm}} 空間的 ID。
    1.  擷取 API 端點以存取空間 ID。將 _&lt;uaa_token&gt;_ 取代為您在第一個步驟中所擷取的 UAA 記號。

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="擷取空間 ID 的輸入參數">
         <tr>
          <th>輸入參數</th>
          <th>值</th>
         </tr>
         <tr>
          <td>Header</td>
          <td><ul><li>Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa_token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      API 輸出範例：

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

5.  記下 **spaces_url** 欄位的輸出。
6.  使用 **spaces_url** 端點，擷取 {{site.data.keyword.Bluemix_notm}} 空間的 ID。

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<my_bluemix_org_id>/spaces
      ```
      {: pre}

      API 輸出範例：

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

      您可以在 API 輸出的 **metadata/guid** 欄位中找到 {{site.data.keyword.Bluemix_notm}} 空間的 ID。

7.  列出帳戶中的所有 Kubernetes 叢集。使用您在先前步驟中所擷取的資訊，以建置標頭資訊。

    -   美國南部

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   英國南部

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   歐盟中部

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   亞太地區南部

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

        <table summary="使用 API 的輸入參數">
         <thead>
          <th>輸入參數</th>
          <th>值</th>
         </thead>
          <tbody>
         <tr>
          <td>Header</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  請檢閱 [{{site.data.keyword.containershort_notm}} API 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://us-south.containers.bluemix.net/swagger-api)，以尋找所支援 API 的清單。

## 重新整理 IAM 存取記號
{: #cs_api_refresh}

每個透過 API 發出的 IAM（身分及存取管理）存取記號都會在一個小時後到期。您必須定期重新整理存取記號，以確保 {{site.data.keyword.containershort_notm}} API 的存取權。
{:shortdesc}

開始之前，請確定您有可用來要求新存取記號的 IAM 重新整理記號。如果您沒有重新整理記號，請檢閱[使用 {{site.data.keyword.containershort_notm}} API 自動化叢集建立及管理處理程序](#cs_api)來擷取存取記號。

如果您要重新整理 IAM 記號，請使用下列步驟。

1.  擷取新的 IAM 存取記號。將 _&lt;iam_refresh_token&gt;_ 取代為您在第一次向 {{site.data.keyword.Bluemix_notm}} 進行鑑別時收到的 IAM 重新整理記號。

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="新 IAM 記號的輸入參數">
     <tr>
      <th>輸入參數</th>
      <th>值</th>
     </tr>
     <tr>
      <td>Header</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>Body</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret: <p>**附註：**新增未指定任何值的 uaa_client_secret 金鑰。</p></li><ul></td>
     </tr>
    </table>

    API 輸出範例：

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

    您可以在 API 輸出的 **access_token** 欄位中尋找新的 IAM 記號，並 **refresh_token** 欄位中尋找 IAM 重新整理記號。

2.  使用前一個步驟中的記號，繼續使用 [{{site.data.keyword.containershort_notm}} API 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://us-south.containers.bluemix.net/swagger-api)。
