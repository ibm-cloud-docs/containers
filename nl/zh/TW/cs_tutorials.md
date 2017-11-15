---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-16"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 指導教學：建立叢集
{: #cs_cluster_tutorial}

在雲端部署及管理自己的 Kubernete 叢集。您可以在稱為工作者節點的獨立運算主機叢集中，自動化進行容器化應用程式的部署、作業、擴充及監視。
{:shortdesc}

在本指導教學系列中，您可以看到虛構公關公司如何使用 Kubernetes 在 {{site.data.keyword.Bluemix_short}} 中部署容器化的應用程式。利用 {{site.data.keyword.toneanalyzerfull}}，公關公司會分析其新聞稿並收到回饋意見。


## 目標

在這第一個指導教學中，您擔任公關公司的網路管理者。您配置自訂 Kubernetes 叢集，以用來部署及測試 Hello World 版本的應用程式。

若要設定基礎架構，請執行下列動作：

-   建立具有一個工作者節點的 Kubernetes 叢集
-   安裝用來使用 Kubernetes API 及管理 Docker 映像檔的 CLI
-   在 {{site.data.keyword.registrylong_notm}} 中建立專用映像檔儲存庫，以儲存您的映像檔
-   將 {{site.data.keyword.toneanalyzershort}} 服務新增至叢集，讓叢集中的任何應用程式都可以使用此服務


## 所需時間

40 分鐘


## 適用對象

本指導教學的適用對象是之前未曾建立過 Kubernetes 叢集的軟體開發人員及網路管理者。


## 必要條件

-  [{{site.data.keyword.Bluemix_notm}} 帳戶 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/registration/)



## 課程 1：建立叢集並設定 CLI
{: #cs_cluster_tutorial_lesson1}

在 GUI 中建立叢集，並安裝必要的 CLI。針對本指導教學，請在英國南部地區建立您的叢集。


建立叢集：

1. 佈建叢集可能需要幾分鐘的時間。為了充分利用時間，請先[建立叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/containers-kubernetes/launch?env_id=ibm:yp:united-kingdom)，然後才安裝 CLI。精簡叢集附有一個要在其中部署容器 Pod 的工作者節點。工作者節點是應用程式在其上執行的運算主機（一般為虛擬機器）。


透過 CLI 管理叢集會使用下列 CLI 及其必要條件：
-   {{site.data.keyword.Bluemix_notm}} CLI 
-   {{site.data.keyword.containershort_notm}} 外掛程式
-   Kubernetes CLI
-   {{site.data.keyword.registryshort_notm}} 外掛程式
-   Docker CLI

</br>
若要安裝 CLI，請執行下列動作：

1.  安裝 [{{site.data.keyword.Bluemix_notm}} CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://clis.ng.bluemix.net/ui/home.html)，它是 {{site.data.keyword.containershort_notm}} 外掛程式的必要條件。若要執行 {{site.data.keyword.Bluemix_notm}} CLI 指令，請使用字首 `bx`。
2.  遵循提示來選取帳戶及 {{site.data.keyword.Bluemix_notm}} 組織。叢集是帳戶特有的，但與 {{site.data.keyword.Bluemix_notm}} 組織或空間無關。

4.  安裝 {{site.data.keyword.containershort_notm}} 外掛程式以建立 Kubernetes 叢集，以及管理工作者節點。若要執行 {{site.data.keyword.containershort_notm}} 外掛程式指令，請使用字首 `bx cs`。

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

5.  若要檢視本端版本的 Kubernetes 儀表板，以及將應用程式部署至叢集，請[安裝 Kubernetes CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)。若要使用 Kubernetes CLI 來執行指令，請使用字首 `kubectl`。
    1.  如需完整的功能相容性，請下載與您計劃使用之 Kubernetes 叢集版本相符的 Kubernetes CLI 版本。現行 {{site.data.keyword.containershort_notm}} 預設 Kubernetes 版本為 1.7.4。

        OS X：[https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux：[https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows：[https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

          **提示：**如果您使用的是 Windows，請在與 {{site.data.keyword.Bluemix_notm}} CLI 相同的目錄中安裝 Kubernetes CLI。當您稍後執行指令時，此設定可為您省去一些檔案路徑變更。

    2.  如果您是使用 OS X 或 Linux，請完成下列步驟。
        1.  將執行檔移至 `/usr/local/bin` 目錄。

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  確定 /usr/local/bin 列在 `PATH` 系統變數中。`PATH` 變數包含作業系統可在其中找到執行檔的所有目錄。`PATH` 變數中所列的目錄用於不同的用途。`/usr/local/bin` 是用來儲存軟體的執行檔，該軟體不是作業系統的一部分，並且已由系統管理者手動安裝。

            ```
            echo $PATH
            ```
            {: pre}

            CLI 輸出會與下列內容類似。

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  使檔案成為可執行檔。

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6. 若要在 {{site.data.keyword.registryshort_notm}} 中設定及管理專用映像檔儲存庫，請安裝 {{site.data.keyword.registryshort_notm}} 外掛程式。若要執行登錄指令，請使用字首 `bx cr`。

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    若要驗證已適當安裝 container-service 及 container-registry 外掛程式，請執行下列指令：

    ```
    bx plugin list
    ```
    {: pre}

7. 若要在本端建置映像檔，並將它們推送至專用映像檔登錄，請[安裝 Docker CE CLI ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.docker.com/community-edition#/download)。如果您使用的是 Windows 8 或更早版本，則可以改為安裝 [Docker Toolbox ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.docker.com/products/docker-toolbox)。

恭喜！您已順利安裝用於下列課程及指導教學的 CLI。接下來，請設定叢集環境並新增 {{site.data.keyword.toneanalyzershort}} 服務。


## 課程 2：設定叢集環境
{: #cs_cluster_tutorial_lesson2}

建立 Kubernetes 叢集、在 {{site.data.keyword.registryshort_notm}} 中設定專用映像檔儲存庫，以及將密碼新增至叢集，讓應用程式可以存取 {{site.data.keyword.toneanalyzershort}} 服務。

1.  當出現提示時，使用 {{site.data.keyword.Bluemix_notm}} 認證登入 {{site.data.keyword.Bluemix_notm}} CLI。

    ```
    bx login [--sso] -a api.eu-gb.bluemix.net
    ```
    {: pre}

    **附註：**如果您具有聯合 ID，請使用 `--sso` 旗標來登入。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。

2.  在 {{site.data.keyword.registryshort_notm}} 中設定您自己的專用映像檔儲存庫，以安全地儲存 Docker 映像檔，並將其與所有叢集使用者共用。{{site.data.keyword.Bluemix_notm}} 中的專用映像檔儲存庫是透過名稱空間識別。名稱空間是用來建立映像檔儲存庫的唯一 URL，而開發人員可以使用映像檔儲存庫來存取專用 Docker 映像檔。

    在此範例中，公關公司只要在 {{site.data.keyword.registryshort_notm}} 中建立一個映像檔儲存庫，因此選擇 _pr_firm_ 作為名稱空間來分組其帳戶中的所有映像檔。請將 _&lt;your_namespace&gt;_ 取代為您所選擇的名稱空間，而不要是與指導教學相關的項目。

    ```
    bx cr namespace-add <your_namespace>
    ```
    {: pre}

3.  繼續下一步之前，請驗證工作者節點的部署已完成。

    ```
    bx cs workers <cluster_name>
    ```
     {: pre}

    佈建工作者節點完成時，狀態會變更為 **Ready**，而且您可以開始連結要在未來指導教學中使用的 {{site.data.keyword.Bluemix_notm}} 服務。

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status
    kube-par02-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready
    ```
    {: screen}

4.  在 CLI 中，設定叢集的環境定義。每次登入容器 CLI 以使用叢集時，您都必須執行這些指令，以將叢集配置檔的路徑設為階段作業變數。Kubernetes CLI 會使用此變數來尋找與 {{site.data.keyword.Bluemix_notm}} 中的叢集連接所需的本端配置檔及憑證。

    1.  取得指令來設定環境變數，並下載 Kubernetes 配置檔。

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: pre}

        配置檔下載完成之後，會顯示一個指令，可讓您用來將本端 Kubernetes 配置檔的路徑設定為環境變數。

        OS X 的範例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
        ```
        {: screen}

    2.  複製並貼上終端機中顯示的指令，以設定 `KUBECONFIG` 環境變數。

    3.  驗證 `KUBECONFIG` 環境變數已適當設定。

        OS X 的範例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        輸出：

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
        ```
        {: screen}

    4.  檢查 Kubernetes CLI 伺服器版本，驗證叢集已適當地執行 `kubectl` 指令。

        ```
        kubectl version  --short
        ```
        {: pre}

        輸出範例：

        ```
        Client Version: v1.7.4
        Server Version: v1.7.4
        ```
        {: screen}

5.  將 {{site.data.keyword.toneanalyzershort}} 服務新增至叢集。使用 {{site.data.keyword.Bluemix_notm}} 服務，您可以在應用程式中利用已經開發的功能。任何在該叢集中部署的應用程式都可以使用任何已連結至叢集的 {{site.data.keyword.Bluemix_notm}} 服務。請針對每個您要與應用程式搭配使用的 {{site.data.keyword.Bluemix_notm}} 服務，重複下列步驟。
    1.  將 {{site.data.keyword.toneanalyzershort}} 服務新增至 {{site.data.keyword.Bluemix_notm}} 帳戶。

        **附註：**當您將 {{site.data.keyword.toneanalyzershort}} 服務新增至帳戶時，會顯示一則訊息指出該服務並非免費。如果您限制 API 呼叫，則此指導教學不會有 {{site.data.keyword.watson}} 服務所引起的費用。[請檢閱 {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} 服務的定價資訊 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block)。

        ```
        bx service create tone_analyzer standard <mytoneanalyzer>
        ```
        {: pre}

    2.  將 {{site.data.keyword.toneanalyzershort}} 實例連結至叢集的 `default` Kubernetes 名稱空間。稍後，您可以建立自己的名稱空間來管理使用者對 Kubernetes 資源的存取權，但現在請使用 `default` 名稱空間。Kubernetes 名稱空間與您稍早所建立的登錄名稱空間不同。

        ```
        bx cs cluster-service-bind <cluster_name> default <mytoneanalyzer>
        ```
        {: pre}

        輸出：

        ```
        bx cs cluster-service-bind <cluster_name> default <mytoneanalyzer>
        Binding service instance to namespace...
        OK
        Namespace:	default
        Secret name:	binding-mytoneanalyzer
        ```
        {: screen}

6.  驗證已在叢集名稱空間中建立 Kubernetes Secret。包括服務的機密資訊（例如，容器用來存取服務的使用者名稱、密碼及 URL）的 JSON 檔案會定義每個 {{site.data.keyword.Bluemix_notm}} 服務。若要安全地儲存此資訊，則會使用 Kubernetes Secret。在此範例中，密碼包括認證，可用來存取帳戶中佈建的 {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} 實例。

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    輸出：

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
做得好！您已配置叢集，且您的本端環境已備妥，可開始將應用程式部署到叢集。

## 下一步為何？

* [測試您學到的知識，並進行隨堂測驗！![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://bluemix-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)

* 嘗試[指導教學：在 {{site.data.keyword.containershort_notm}} 中將應用程式部署至 Kubernetes 叢集](cs_tutorials_apps.html#cs_apps_tutorial)，以將公關公司的應用程式部署至您所建立的叢集。
