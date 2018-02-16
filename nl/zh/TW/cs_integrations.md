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


# 整合服務
{: #integrations}

您可以使用各種外部服務，以及具有 {{site.data.keyword.containershort_notm}} 中標準叢集的「{{site.data.keyword.Bluemix_notm}} 型錄」中的服務。
{:shortdesc}

<table summary="可存取性摘要">
<caption>表格。Kubernetes 中叢集及應用程式的整合選項</caption>
<thead>
<tr>
<th>服務</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Blockchain</td>
<td>將 IBM Blockchain 的可公開使用開發環境部署至 {{site.data.keyword.containerlong_notm}} 中的 Kubernetes 叢集。使用此環境開發及自訂您自己的區塊鏈網路，以部署應用程式來共用可記錄交易歷程的不可變分類帳。如需相關資訊，請參閱<a href="https://ibm-blockchain.github.io" target="_blank">在雲端沙盤推演 IBM Blockchain 平台中開發 <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。</td>
</tr>
<tr>
<td>Continuous Delivery</td>
<td>使用工具鏈自動建置應用程式，並將容器部署至 Kubernetes 叢集。如需設定資訊，請參閱部落格 <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。</td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh/" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a> 是 Kubernetes 套件管理程式。建立「Helm 圖表」，以定義、安裝及升級在 {{site.data.keyword.containerlong_notm}} 叢集中執行的複式 Kubernetes 應用程式。進一步瞭解您如何<a href="https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/" target="_blank">使用 Kubernetes Helm 圖表來加快部署 <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。</td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a> 透過自動探索及對映應用程式的 GUI，提供基礎架構及應用程式效能監視。此外，Istana 也會擷取向應用程式提出的每一個要求，讓您可以進行疑難排解，並執行主要原因分析，以避免問題再次發生。如需進一步瞭解，請參閱關於<a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">在 {{site.data.keyword.containershort_notm}} 中部署 Istana <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a> 的部落格文章。</td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio<img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a> 是一種開放程式碼服務，提供方法讓開發人員連接、保護、管理及監視雲端編排平台上微服務（也稱為服務網）的網路，例如 Kubernetes。請參閱關於 <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">IBM 如何共同建立及啟動 Istio <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a> 的部落格文章，以進一步瞭解開放程式碼專案的相關資訊。若要在 {{site.data.keyword.containershort_notm}} 的 Kubernetes 叢集上安裝 Istio，並開始使用範例應用程式，請參閱[指導教學：使用 Istio 管理微服務](cs_tutorials_istio.html#istio_tutorial)。</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus 是一個專為 Kubernetes 所設計的開放程式碼監視、記載及警示工具，可根據 Kubernetes 記載資訊來擷取叢集、工作者節點及部署性能的詳細資訊。會收集叢集中所有執行中容器的 CPU、記憶體、I/O 及網路活動，並且可以用於自訂查詢或警示中，以監視叢集中的效能及工作負載。<p>若要使用 Prometheus，請執行下列動作：</p>
<ol>
<li>遵循 <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS 指示 <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a> 來安裝 Prometheus。
<ol>
<li>當您執行 export 指令時，請使用 kube-system 名稱空間。
<p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>在叢集中部署 Prometheus 之後，請在 Grafana 中編輯 Prometheus 資料來源，以參照 <code>prometheus.kube-system:30900</code>。</li>
</ol>
</td>
</tr>
<tr>
<td>{{site.data.keyword.bpshort}}</td>
<td>{{site.data.keyword.bplong}} 是一種自動化工具，可使用 Terraform 將基礎架構部署為程式碼。當您將基礎架構部署為單一單元時，可以跨任意數目的環境重複使用那些雲端資源定義。若要使用 {{site.data.keyword.bpshort}} 將 Kubernetes 叢集定義為資源，請嘗試使用 [container-cluster 範本](https://console.bluemix.net/schematics/templates/details/Cloud-Schematics%2Fcontainer-cluster)來建立環境。如需 Schematics 的相關資訊，請參閱[關於 {{site.data.keyword.bplong_notm}}](/docs/services/schematics/schematics_overview.html#about)。</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope 提供 Kubernetes 叢集內資源（包括服務、Pod、容器、處理程序、節點等項目）的視覺圖。Weave Scope 提供 CPU 及記憶體的互動式度量值，也提供工具來調整並執行至容器。
<p>如需相關資訊，請參閱[使用 Weave Scope 及 {{site.data.keyword.containershort_notm}} 視覺化 Kubernetes 叢集資源](cs_integrations.html#weavescope)。</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## 將服務新增至叢集
{: #adding_cluster}

將現有 {{site.data.keyword.Bluemix_notm}} 服務實例新增至叢集，讓叢集使用者在將應用程式部署至叢集時能夠存取及使用 {{site.data.keyword.Bluemix_notm}} 服務。
{:shortdesc}

開始之前：

1. [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。
2. [要求 {{site.data.keyword.Bluemix_notm}} 服務的實例](/docs/manageapps/reqnsi.html#req_instance)。
   **附註：**若要在華盛頓特區中建立服務實例，您必須使用 CLI。

**附註：**
<ul><ul>
<li>您只能新增支援服務金鑰的 {{site.data.keyword.Bluemix_notm}} 服務。如果服務不支援服務金鑰，請參閱[啟用外部應用程式以使用 {{site.data.keyword.Bluemix_notm}} 服務](/docs/manageapps/reqnsi.html#accser_external)。</li>
<li>必須完全部署叢集及工作者節點，才能新增服務。</li>
</ul></ul>


若要新增服務，請執行下列動作：
2.  列出可用的 {{site.data.keyword.Bluemix_notm}} 服務。

    ```
    bx service list
    ```
    {: pre}

    CLI 輸出範例：

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  記下您要新增至叢集的服務實例的**名稱**。
4.  識別您要用來新增服務的叢集名稱空間。請選擇下列選項。
    -   列出現有名稱空間，並選擇您要使用的名稱空間。

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   在叢集中建立新的名稱空間。

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  將服務新增至叢集。

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    將服務順利新增至叢集之後，即會建立叢集 Secret，以保留服務實例認證。CLI 輸出範例：

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  驗證已在叢集名稱空間中建立 Secret。

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


若要在叢集中所部署的 Pod 中使用服務，叢集使用者可以存取 {{site.data.keyword.Bluemix_notm}} 服務的服務認證，方法是[將 Kubernetes 密碼以密碼磁區形式裝載至 Pod](cs_integrations.html#adding_app)。

<br />



## 將服務新增至應用程式
{: #adding_app}

加密 Kubernetes Secret 是用來儲存 {{site.data.keyword.Bluemix_notm}} 服務詳細資料及認證，以及容許服務與叢集之間的安全通訊。身為叢集使用者，您可以將此 Secret 以磁區形式裝載至 Pod 來進行存取。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。請確定叢集管理者已將您要用在應用程式中的 {{site.data.keyword.Bluemix_notm}} 服務[新增至叢集](cs_integrations.html#adding_cluster)。

Kubernetes Secret 是一種儲存機密資訊（例如使用者名稱、密碼或金鑰）的安全方式。Secret 必須以 Secret 磁區形式裝載至 Pod，以供在 Pod 中執行的容器存取，而不是透過環境變數或直接在 Dockerfile 中公開機密資訊。

當您將 Secret 磁區裝載至 Pod 時，會將名為 binding 的檔案儲存在磁區裝載目錄中，該目錄包括您存取 {{site.data.keyword.Bluemix_notm}} 服務所需的所有資訊及認證。

1.  列出叢集名稱空間中的可用 Secret。

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    輸出範例：

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  尋找 **Opaque** 類型的 Secret，並記下 Secret 的**名稱**。如果有多個 Secret，請與叢集管理者聯絡，以識別正確的服務 Secret。

3.  開啟您偏好的編輯器。

4.  建立 YAML 檔案，以配置可透過 Secret 磁區存取服務詳細資料的 Pod。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>您要裝載至容器的 Secret 磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>輸入您要裝載至容器的 Secret 磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>設定服務 Secret 的唯讀許可權。</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>輸入您稍早記下的 Secret 的名稱。</td>
    </tr></tbody></table>

5.  建立 Pod，並裝載 Secret 磁區。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  驗證已建立 Pod。

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    CLI 輸出範例：

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  記下 Pod 的**名稱**。
8.  取得有關 Pod 的詳細資料，並尋找 Secret 名稱。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    輸出：

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  實作應用程式時，請將它配置為在裝載目錄中尋找名為 **binding** 的 Secret 檔案、剖析 JSON 內容，以及判定可存取 {{site.data.keyword.Bluemix_notm}} 服務的 URL 及服務認證。

您現在可以存取 {{site.data.keyword.Bluemix_notm}} 服務詳細資料及認證。若要使用 {{site.data.keyword.Bluemix_notm}} 服務，請確定應用程式已配置為在裝載目錄中尋找服務 Secret 檔案、剖析 JSON 內容，以及判定服務詳細資料。

<br />



## 視覺化 Kubernetes 叢集資源
{: #weavescope}

Weave Scope 提供 Kubernetes 叢集內資源（包括服務、Pod、容器、處理程序、節點等項目）的視覺圖。Weave Scope 提供 CPU 及記憶體的互動式度量值，也提供工具來調整並執行至容器。
{:shortdesc}

開始之前：

-   請記住不要在公用網際網路上公開叢集資訊。請完成下列步驟，以安全地部署 Weave Scope，並於本端從 Web 瀏覽器進行存取。
-   如果您還沒有叢集，請[建立標準叢集](cs_clusters.html#clusters_ui)。Weave Scope 可能需要大量 CPU，特別是應用程式。請搭配執行 Weave Scope 與較大的標準叢集，而非精簡叢集。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。


若要搭配使用 Weave Scope 與叢集，請執行下列動作：
2.  在叢集中部署其中一個提供的 RBAC 許可權配置檔。

    若要啟用讀寫許可權，請執行下列指令：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    若要啟用唯讀許可權，請執行下列動作：

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    輸出：

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  部署 Weave Scope 服務（只能透過叢集 IP 位址進行私密存取）。

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    輸出：

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  在您的電腦上執行埠轉遞指令，以啟動服務。既然 Weave Scope 已配置叢集，則下一次存取 Weave Scope 時，您就可以執行此埠轉遞指令，而不需要再次完成先前的配置步驟。

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    輸出：

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  開啟 Web 瀏覽器，並前往 `http://localhost:4040`。若未部署預設元件，您會看到下圖。您可以選擇檢視拓蹼圖，或叢集中的 Kubernetes 資源表格。

     <img src="images/weave_scope.png" alt="來自 Weave Scope 的拓蹼範例" style="width:357px;" />


[進一步瞭解 Weave Scope 特性 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.weave.works/docs/scope/latest/features/)。

<br />

